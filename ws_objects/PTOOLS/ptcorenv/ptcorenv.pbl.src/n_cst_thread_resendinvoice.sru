$PBExportHeader$n_cst_thread_resendinvoice.sru
forward
global type n_cst_thread_resendinvoice from n_cst_thread
end type
end forward

global type n_cst_thread_resendinvoice from n_cst_thread
end type
global n_cst_thread_resendinvoice n_cst_thread_resendinvoice

type variables
n_cst_BillServices	inv_BillService
end variables

forward prototypes
public function integer of_executejob (n_cst_threadjob anv_job)
end prototypes

public function integer of_executejob (n_cst_threadjob anv_job);/****************************************************************************************
NAME: 		of_ExecuteJob		

ACCESS:		Public
		
ARGUMENTS:	(n_cst_threadjob	anv_job)

RETURNS:		Integer   //not used 
	
DESCRIPTION: 
				Sorts Individual/Manifest invoices passed in.
				
				Attempts to resend invoices.
				
				Reports the results back to the requestor window via the threadcomm object.
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/19/07 - Maury
***************************************************************************************/

Integer	li_Return = 1
Long		lla_Shipments[]
Long		ll_InvoiceCount
Long		i, j, k
Long		ll_NumShipments,ll_IndividualCount, ll_MultiManifestCount, ll_ManifestCount
Long		lla_Individual[], lla_MultiManifest[], lla_Manifestids[]
Long		ll_ErrorCount
String	ls_InvoiceIds
String	ls_InvoiceNum
String	ls_ManifestNum
String	ls_FinalMessage
String	ls_HeaderInd
String	ls_HeaderMan
String	ls_MessageInd
String	ls_MessageMan
String	lsa_Errors[]
Boolean	lb_Success = True

CONSTANT Boolean	lb_PrintDialog = FALSE
CONSTANT Boolean	lb_ProgressBar = FALSE

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_billservices	lnv_BillServices //autoinst

n_cst_Threadjob		lnv_InvoiceJob

lnv_InvoiceJob = anv_job

IF isValid(lnv_InvoiceJob) THEN
	lla_Shipments = lnv_InvoiceJob.ila_SourceIds 
END IF

lnv_Dispatch = Create n_cst_bso_Dispatch
lnv_Shipment = Create n_cst_beo_Shipment

lnv_Dispatch.of_RetrieveShipments( lla_Shipments )
lnv_Shipment.of_SetSource(lnv_Dispatch.of_GetShipmentCache())

//Sort individual and manifest invoices
ll_NumShipments = UpperBound(lla_Shipments)
FOR i = 1 TO ll_NumShipments
	lnv_Shipment.of_SetSourceId(lla_Shipments[i])
	ls_InvoiceNum = lnv_Shipment.of_GetInvoiceNumber()
	IF Pos(ls_InvoiceNum, "--") > 0 THEN
		lla_MultiManifest[UpperBound(lla_MultiManifest) + 1] = lla_Shipments[i] 
	ELSE
		lla_Individual[UpperBound(lla_Individual[]) + 1] = lla_Shipments[i] 
	END IF
NEXT

//Send Individual Invoices
ll_IndividualCount = UpperBound(lla_Individual[])
IF ll_IndividualCount > 0 THEN
	ls_HeaderInd = "-----------------------------------------------------------------~r~n" + &
					   "                       Individual Invoices                       ~r~n" + &
					   "-----------------------------------------------------------------~r~n"
	IF inv_BillService.of_PrintCustomInvoices(lla_Individual[], lb_PrintDialog, lb_ProgressBar) <> 1 THEN
		li_Return = -1
		//Build string of individual invoice ids
		ll_InvoiceCount = Upperbound(lla_Individual)
		FOR i = 1 TO ll_Invoicecount
			lnv_Shipment.of_SetSourceId(lla_Individual[i])
			ls_InvoiceIds += lnv_Shipment.of_GetInvoiceNumber()
			IF i <> ll_InvoiceCount THEN
				ls_InvoiceIds += ","
			END IF
		NEXT
		ls_MessageInd = "Failed to resend the following individual invoice(s):~r~n"
		ls_MessageInd += "{ " + ls_InvoiceIds + " }~r~n" 
		inv_BillService.of_GetErrors(lsa_Errors)
		ll_ErrorCount = UpperBound(lsa_Errors)
		FOR i = 1 TO ll_Errorcount
			ls_MessageInd += lsa_errors[i] + "~r~n"
		NEXT
	ELSE
		ls_MessageInd = "Successfully resent " + String(ll_IndividualCount) + " individual invoice(s).~r~n"
	END IF	 
END IF

//Send Manifest Invoices
ll_MultiManifestCount = UpperBound(lla_MultiManifest[])
IF ll_MultiManifestCount > 0 THEN
	ls_HeaderMan = "---------------------------------------------------------------~r~n" + &
						"                        Manifest Invoices                      ~r~n" + &
						"---------------------------------------------------------------~r~n"
END IF
FOR i = 1 TO ll_MultiManifestCount
	IF NOT isNull(lla_MultiManifest[i]) THEN //NECESSARY!!
		lnv_Shipment.of_SetSourceId(lla_MultiManifest[i])
		ls_InvoiceNum = lnv_Shipment.of_Getinvoicenumber( )
		ls_ManifestNum = Left(ls_InvoiceNum, Pos(ls_InvoiceNum, "--") - 1)
		lnv_BillServices.of_GetAllShipmentsInManifest(ls_ManifestNum, lla_ManifestIds)
		ll_ManifestCount = UpperBound(lla_ManifestIds[])
		IF inv_BillService.of_PrintManifestCustomInvoices(lla_ManifestIds[], lb_PrintDialog, lb_ProgressBar) <> 1 THEN
			li_Return = -1
			ls_MessageMan += "Failed to resend manifest invoice " + ls_ManifestNum + ".~r~n"
			inv_BillService.of_GetErrors(lsa_Errors)
			ll_ErrorCount = UpperBound(lsa_Errors)
			FOR j = 1 TO ll_Errorcount
				ls_MessageMan += lsa_errors[j] + "~r~n"
			NEXT
		ELSE
			ls_MessageMan += "Successfully resent manifest invoice " + ls_ManifestNum + "~r~n"
		END IF
		
		//Remove all Manifest Ids from multimanifest that were already executed
		FOR j = 1 TO ll_MultiManifestCount
			FOR k = 1 TO ll_ManifestCount
				IF NOT isNull(lla_MultiManifest[j]) THEN
					IF lla_MultiManifest[j] = lla_ManifestIds[k] THEN
						SetNull(lla_MultiManifest[j])
						EXIT
					END IF
				END IF
			NEXT
		NEXT
		
	END IF
NEXT

//communicate message to registered window on the message broker object
IF isValid(inv_ThreadComm) THEN
	//build final message
	IF Len(ls_HeaderInd) > 0 THEN
		ls_FinalMessage += ls_HeaderInd + ls_MessageInd
	END IF
	IF Len(ls_HeaderMan) > 0 THEN
		ls_FinalMessage += ls_HeaderMan + ls_MessageMan
	END IF
	inv_ThreadComm.of_ShowMessageBox("Resend Invoices", ls_FinalMessage)
	inv_ThreadComm.of_SendMessage("DONE")
END IF

IF li_Return <> 1 THEN
	lb_Success = False
END IF

//Tell manager that we are done with the thread
This.of_Done(lb_Success)

Destroy lnv_Dispatch 
Destroy lnv_Shipment 

Return li_Return
end function

on n_cst_thread_resendinvoice.create
call super::create
end on

on n_cst_thread_resendinvoice.destroy
call super::destroy
end on

event destructor;call super::destructor;//Disconnect from db
SQLCA.of_Disconnect ( )

Destroy (gnv_bcmmgr)
Destroy(gnv_app)
Destroy(gnv_cst_companies) 
end event

event constructor;call super::constructor;is_Description = "Resending invoices"


//We need to connect to the db.
//Even though thread objects run on a new/separate application session (with its own globals), the 'connectionbegin' and 'open'
//events do not get fired. So we have to explicitly connect/disconnect from the db.

Integer	li_Return //Flag only, no return
String	ls_inifile

gnv_bcmmgr = Create n_cst_bcmmgr
gnv_app = Create n_cst_appmanager_trucking

gnv_cst_companies = Create n_cst_companies

ls_inifile = gnv_app.of_GetAppIniFile()

IF SQLCA.of_Init(ls_inifile,"Database") = -1 THEN     
	li_Return = -1
END IF  

//connect to database
IF SQLCA.of_Connect() = -1 THEN     
	li_Return = -1
END IF

//Clear DBParm Entry, for Security Reasons
SQLCA.DBParm = ""

gnv_App.of_SetCacheManager ( TRUE )


//this will force billservice manager not to display errors
inv_BillService.of_SetThreadMode(True)

end event

