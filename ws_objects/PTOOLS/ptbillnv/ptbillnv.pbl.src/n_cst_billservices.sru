$PBExportHeader$n_cst_billservices.sru
forward
global type n_cst_billservices from n_cst_base
end type
end forward

global type n_cst_billservices from n_cst_base autoinstantiate
end type

type variables
Private:
boolean	ib_DeliveryReceipt
n_cst_bso_ReportManager	inv_ReportManager
string	is_Context

Boolean	ib_ThreadMode

end variables

forward prototypes
public function integer of_quickprint_delrecs (long ala_ids[])
public function integer of_usecustominvoice (ref boolean ab_usecustominvoice)
private function integer of_reportmanager (long ala_ids[], string as_filename)
private function boolean of_processcrossdocks ()
public function integer of_printcustominvoices (long ala_ids[], boolean ab_printdialog)
public function integer of_usemanifestcustominvoice (ref boolean ab_usecustominvoice)
public function integer of_printmanifestcustominvoices (long ala_ids[], boolean ab_printdialog)
public function integer of_getallshipmentsinmanifest (string as_invoicenum, ref long ala_shipmentids[])
public function integer of_printcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar)
public function integer of_printcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar, string as_sourcetemplatefile)
public function integer of_printmanifestcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar)
public function integer of_printmanifestcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar, string as_sourcetemplatefile)
public function integer of_setthreadmode (boolean ab_switch)
public function integer of_geterrors (ref string asa_errors[])
public function integer of_adderrors (string asa_errors[])
end prototypes

public function integer of_quickprint_delrecs (long ala_ids[]);Integer	li_Return = 1, &
			li_RetVal
			
any		la_Setting

string	ls_Setting, &
			ls_Description, &
			ls_Path, &
			ls_File
			
boolean	lb_UseOldVersion, &
			lb_GetCustomTemplate

n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
w_BillQuickPrint	lw_Print
n_cst_Settings lnv_Settings 
n_cst_fileSrvwin32	lnv_fileSrv
n_cst_String	lnv_String

ib_DeliveryReceipt = TRUE
is_Context = "Delivery Receipt"

lnv_FileSrv = CREATE n_cst_fileSrvwin32

IF UpperBound ( ala_Ids ) > 0 THEN

//Use custom Delivery receipt	
	CHOOSE CASE lnv_Settings.of_GetSetting( 45, la_Setting ) 
		CASE 0
			lb_UseOldVersion=TRUE
			
		CASE 1
			ls_Setting = string ( la_Setting ) 
			
			CHOOSE CASE ls_Setting
					
				CASE "YES!"
					
					lb_GetCustomTemplate=TRUE
									
				CASE "NO!"
					lb_UseOldVersion=TRUE
					
				CASE "ASK!"
					CHOOSE CASE messagebox("Delivery Receipt Template", &
										"Do you want to use a custom delivery receipt?", Question!, YesNoCancel!)
										
						CASE 1
							lb_UseOldVersion=FALSE
							lb_GetCustomTemplate=TRUE
							
						CASE 2
							lb_UseOldVersion=TRUE
							
						CASE 3
							li_Return = 0
							
					END CHOOSE
					
			END CHOOSE
			
		CASE ELSE
			lb_UseOldVersion=TRUE
			
	END CHOOSE

	IF li_Return = 1 THEN
		
		IF lb_UseOldVersion THEN
			lstr_Parm.is_Label = "IDS"
			lstr_Parm.ia_Value = ala_Ids
			
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "TYPE"
			lstr_Parm.ia_Value = "DELIVERY_RECEIPT!"
			
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			OpenWithParm ( lw_Print, lnv_Msg )
		ELSE
			IF lb_GetCustomTemplate THEN
				//Get Delivery Receipt Template
				CHOOSE CASE lnv_Settings.of_GetSetting( 46, la_Setting )
					CASE 0
						
					CASE 1
						ls_Description = String ( la_Setting )
											
					CASE ELSE
						
				END CHOOSE
				
				IF isnull ( ls_Description ) or &
					len ( ls_Description ) = 0 THEN

					IF GetFileOpenName("Select File", ls_Path, ls_File, "doc", + &
								"Word Document (*.doc), *.doc,Word Template (*.dot),*.dot,all files (*.*), *.*") = 1 THEN
						ls_description = ls_Path 
					END IF
					
				ELSE
					
					IF right ( ls_Description, 1 ) = "\" THEN
						lnv_FileSrv.of_ChangeDirectory ( ls_Description ) 
						IF GetFileOpenName("Select File", ls_Path, ls_File, "doc", + &
								"Word Document (*.doc), *.doc,Word Template (*.dot),*.dot,all files (*.*), *.*") = 1 THEN
							ls_description = ls_Path 
						END IF
					END IF	
		
				END IF
				
			END IF
			
			IF This.of_ReportManager ( ala_ids, ls_Description ) < 0 THEN
				li_Return = 0
			END IF
			
		END IF
		
	END IF

ELSE

	li_Return = 0

END IF

IF isvalid ( lnv_FileSrv )THEN
	DESTROY lnv_FileSrv
END IF


RETURN li_Return
end function

public function integer of_usecustominvoice (ref boolean ab_usecustominvoice);//Use custom Invoice

Integer	li_Return = 1
	
any		la_Setting

string	ls_Setting

n_cst_Settings lnv_Settings 

CHOOSE CASE lnv_Settings.of_GetSetting( 37, la_Setting ) 
	CASE 0
		ab_UseCustomInvoice=FALSE
		
	CASE 1
		ls_Setting = string ( la_Setting ) 
		
		CHOOSE CASE ls_Setting
				
			CASE "YES!"
				
				ab_UseCustomInvoice=TRUE
								
			CASE "NO!"
				ab_UseCustomInvoice=FALSE
				
			CASE "ASK!"
				CHOOSE CASE messagebox("Custom Invoice Template", &
									"Do you want to use a custom invoice?", Question!, YesNoCancel!)
									
					CASE 1
						ab_UseCustomInvoice=TRUE
						
					CASE 2
						ab_UseCustomInvoice=FALSE
						
					CASE 3
						li_Return = 0
						
				END CHOOSE
				
		END CHOOSE
		
	CASE ELSE
		ab_UseCustomInvoice=FALSE
		
END CHOOSE

return li_Return
end function

private function integer of_reportmanager (long ala_ids[], string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ReportManager
//
//	Access:  private
//
//	Arguments:  ala_ids[]
//					as_Filename
//
// Returns:		none
//
//	Description:	
//
// Written by: Norm LeBlanc
// 		Date: 9/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//		modified 11/15/00:
//			changed arguments for createreport
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
string ls_test

integer	li_Return

long	ll_shipmentcount, &
		ll_shipmentindex
		
any	laa_Beo [], &
		laa_Data []
		
boolean	lb_FilterCrossDocks

n_ds	lds_ShipmentCache,&
		lds_EventCache, &
		lds_ItemCache


n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_shipment	lnva_ShipmentBeo []
n_cst_msg				lnv_msg

lnv_Dispatch = CREATE n_cst_bso_Dispatch 

ll_shipmentCount = upperbound ( ala_Ids )
IF isValid ( lnv_Dispatch ) THEN
	
	lnv_Dispatch.of_RetrieveShipments ( ala_Ids )
	lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )
	IF isValid ( lds_ShipmentCache ) THEN
		lds_ShipmentCache.SetFilter ( "" )
		lds_ShipmentCache.SetSort ( "ds_id A" )
		lds_ShipmentCache.Filter ( )
		lds_ShipmentCache.Sort ( )
		
		lds_eventCache = lnv_Dispatch.of_GeteventCache ( )
		IF isValid ( lds_eventCache ) THEN
			lds_EventCache.SetFilter ( "" )
			lds_EventCache.SetSort ( "de_shipment_id A, de_ship_seq A" )
			lds_EventCache.Filter ( )
			lds_EventCache.Sort ( )
		END IF

		//filter docks	
		lb_FilterCrossDocks = this.of_ProcessCrossDocks ( )
		
		lds_ItemCache = lnv_Dispatch.of_GetItemCache ( )
		IF isValid ( lds_ItemCache ) THEN
			lds_ItemCache.SetFilter ( "" )
			lds_ItemCache.SetSort ( "di_shipment_id A, di_item_type D, di_item_id A " )
			lds_ItemCache.Filter ( )
			lds_ItemCache.Sort ( )
		END IF
		
		FOR ll_ShipmentIndex = 1 TO ll_ShipmentCount
			
				lnva_ShipmentBeo [ ll_ShipmentIndex ] = CREATE n_cst_beo_shipment
				
				lnva_ShipmentBeo [ ll_ShipmentIndex ].of_SetSource ( lds_ShipmentCache )
				lnva_ShipmentBeo [ ll_ShipmentIndex ].of_SetSourceId ( ala_Ids [ ll_ShipmentIndex ] )
				lnva_ShipmentBeo [ ll_ShipmentIndex ].of_SetEventSource ( lds_EventCache )
				lnva_ShipmentBeo [ ll_ShipmentIndex ].of_SetItemSource ( lds_ItemCache )
				lnva_ShipmentBeo [ ll_ShipmentIndex ].of_SetExcludeCrossDock ( lb_FilterCrossDocks )
				lnva_ShipmentBeo [ ll_ShipmentIndex ].of_LockEventList ( "reportmanager" )
		NEXT

	end if
end if

laa_Beo = lnva_ShipmentBeo
		
IF inv_ReportManager.of_CreateReport ( "Shipment", as_FileName, laa_Beo, TRUE, TRUE, laa_Data, lnv_msg ) < 0 THEN
	
	li_Return = -1
	
END IF

destroy lnv_Dispatch

FOR ll_ShipmentIndex = 1 TO ll_ShipmentCount
	DESTROY ( lnva_ShipmentBeo [ ll_ShipmentIndex ] )
NEXT

return li_Return

end function

private function boolean of_processcrossdocks ();
string	ls_MessageHeader

Boolean		lb_FilterDockEvents
				
n_cst_CrossDock	lnv_CrossDock

lnv_CrossDock = CREATE n_cst_CrossDock
	
IF ib_DeliveryReceipt THEN
	ls_MessageHeader = "Print Custom Delivery Receipt"
ELSE
	ls_MessageHeader = "Print Custom Invoice"
END IF

IF lnv_CrossDock.of_Ready ( ) THEN

	IF ib_DeliveryReceipt THEN
		lb_FilterDockEvents = lnv_CrossDock.of_GetFilterOnDelrec ( )
	ELSE
		lb_FilterDockEvents = lnv_CrossDock.of_GetFilterOnInvoice ( )
	END IF

ELSE

	CHOOSE CASE MessageBox ( ls_MessageHeader, "Could not retrieve crossdock filter "+&
		"settings from database.  Do you want to proceed without filtering crossdock events?", &
		Question!, YesNo!, 1 )
	CASE 1
		//Proceed
	CASE 2
		//failure
	END CHOOSE

END IF

DESTROY lnv_CrossDock

return lb_FilterDockEvents



end function

public function integer of_printcustominvoices (long ala_ids[], boolean ab_printdialog);Boolean	lb_ProgressBar = TRUE


RETURN THIS.of_Printcustominvoices( ala_ids[], ab_printdialog, lb_ProgressBar )


end function

public function integer of_usemanifestcustominvoice (ref boolean ab_usecustominvoice);//Use Manifest Custom Invoice

Integer	li_Return = 1
	
any		la_Setting

string	ls_Setting

n_cst_Settings lnv_Settings 

CHOOSE CASE lnv_Settings.of_GetSetting( 237, la_Setting ) 
	CASE 0
		ab_UseCustomInvoice=FALSE
		
	CASE 1
		ls_Setting = string ( la_Setting ) 
		
		CHOOSE CASE ls_Setting
				
			CASE "YES!"
				
				ab_UseCustomInvoice=TRUE
								
			CASE "NO!"
				ab_UseCustomInvoice=FALSE
				
			CASE "ASK!"
				CHOOSE CASE messagebox("Manifest Custom Invoice Template", &
									"Do you want to use a custom invoice for the manifest?", Question!, YesNoCancel!)
									
					CASE 1
						ab_UseCustomInvoice=TRUE
						
					CASE 2
						ab_UseCustomInvoice=FALSE
						
					CASE 3
						li_Return = 0
						
				END CHOOSE
				
		END CHOOSE
		
	CASE ELSE
		ab_UseCustomInvoice=FALSE
		
END CHOOSE

return li_Return
end function

public function integer of_printmanifestcustominvoices (long ala_ids[], boolean ab_printdialog);Boolean lb_ProgressBar = True


RETURN THIS.of_PrintManifestCustomInvoices( ala_ids[], ab_printdialog, lb_ProgressBar )

end function

public function integer of_getallshipmentsinmanifest (string as_invoicenum, ref long ala_shipmentids[]);String	ls_InvoiceNum
Long		ll_Pos
Long		lla_ShipmentIds[]
Long		ll_NumShips, i
Integer	li_Return

DataStore	lds_Manifest

lds_Manifest = CREATE DataStore
lds_Manifest.DataObject = "d_manifestids"
lds_Manifest.SetTransObject(SQLCA)

ls_InvoiceNum = as_InvoiceNum
ll_Pos = Pos(as_InvoiceNum, "--")
IF ll_Pos > 0 THEN
	ls_InvoiceNum = Left(as_InvoiceNum, ll_Pos - 1)
END IF

IF lds_Manifest.Retrieve(ls_invoicenum) = -1 THEN
	RollBack;
	li_Return = -1
ELSE
	Commit;
	li_Return = 1
END IF

IF li_Return = 1 THEN
	ll_NumShips = lds_Manifest.Rowcount()
	FOR i = 1 TO ll_NumShips
		lla_ShipmentIds[Upperbound(lla_ShipmentIds[]) + 1] = lds_Manifest.Object.ds_id[i]
	NEXT
END IF

ala_ShipmentIds = lla_ShipmentIds

Destroy	lds_Manifest

Return 1



end function

public function integer of_printcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar);n_cst_setting_custominvoicetemplate	lnv_template
lnv_template = CREATE n_cst_setting_custominvoicetemplate
String	ls_Template
ls_Template = lnv_template.of_getValue( )
DESTROY ( lnv_template )


RETURN THIS.of_Printcustominvoices( ala_ids[], ab_printdialog, ab_ProgressBar, ls_Template )


end function

public function integer of_printcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar, string as_sourcetemplatefile);integer 	li_Return = 1
String	lsa_Errors[]

n_Cst_InvoiceManager	lnv_InvoiceManager

// I am going to split processing here now because I don't have time to 
// implement all of the different types of custom invoices.

String	ls_Template
ls_Template = as_sourcetemplatefile

IF Right ( Trim ( ls_Template ) , 4  )= ".psr" THEN
	
	lnv_InvoiceManager = CREATE n_Cst_InvoiceManager
	lnv_InvoiceManager.of_SetProgressBar(ab_ProgressBar)
	lnv_InvoiceManager.of_Setsourcetemplatefile( ls_Template )

	IF lnv_InvoiceManager.of_GenerateIndividualInvoices( ala_ids[] ) = 1 THEN
		li_Return = 1
	ELSE
		IF ib_ThreadMode THEN
			//We do not want to display the errors yet
			lnv_InvoiceManager.of_GetErrors(lsa_Errors)
			This.of_AddErrors(lsa_Errors)
		ELSE
			lnv_InvoiceManager.of_DisplayErrors()
		END IF
		li_Return = -1
	END IF

	
	DESTROY ( lnv_InvoiceManager )
	
ELSE  // this was the original code in the method ... with a modification to 
		// respond to the manual seletion of a .psr
		
	//	This method asumes that the setting for printing custom invoices 
	//	has already been checked.
	

	
	any		la_Setting
	
	string	ls_Setting, &
				ls_Description, &
				ls_Path, &
				ls_File
				
	Boolean	lb_SelectFileAgain 
	
	n_cst_Settings lnv_Settings 
	n_cst_fileSrvwin32	lnv_fileSrv
	lnv_FileSrv = CREATE n_cst_fileSrvwin32
	
	is_Context = "Invoice"
	
	//get the template folder location
	n_cst_setting_templatespathfolder	lnv_PathSetting
	lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
	ls_Path = lnv_PathSetting.of_Getvalue( )
	DESTROY ( lnv_PathSetting )
	
	
	//get invoice template
	CHOOSE CASE lnv_Settings.of_GetSetting( 38, la_Setting )
		CASE 0
			
		CASE 1
			ls_File = String ( la_Setting )
			
		CASE ELSE
			
	END CHOOSE
	
	
	IF Len  ( ls_File ) = 0 THEN
		IF len ( ls_Path ) > 0 THEN
			
			ls_Path += "invoice\"
			IF len ( ls_File ) > 0 THEN
				ls_Description = ls_Path + ls_File
			ELSE
				ls_Description = ls_Path
			END IF
		
		END IF
	ELSE
		ls_Description = ls_File
	END IF
	
		
	IF len ( ls_Description ) = 0 THEN
	
		Do
			lb_SelectFileAgain = FALSE
			CHOOSE CASE GetFileOpenName("Select File", ls_Path, ls_File, "psr,doc" , "Invoice Template (*.doc; *.dot; *.xls; *.psr),*.doc;*.dot;*.psr;*.xls")
				CASE 1 // success
					ls_description = ls_Path 
				CASE 0 // user cancelled
					IF MessageBox ( "Custom Invoice" , &
							"By not selecting a template you have cancelled the viewing/printing operation. However, the bills will still be processed. " + &
							" Are you sure you want to cancel ?", QUESTION!, YESNO! , 2 ) = 1 THEN
						li_Return = 0
					ELSE
						lb_SelectFileAgain = TRUE
					END IF
				CASE ELSE // unexpected error
					li_Return = -1
				
			END CHOOSE
		LOOP While lb_SelectFileAgain
	
	ELSE
		
		IF right ( ls_Description, 1 ) = "\" THEN
			
			lnv_FileSrv.of_ChangeDirectory ( ls_Description ) 
			Do
				lb_SelectFileAgain = FALSE
				CHOOSE CASE GetFileOpenName("Select File", ls_Path, ls_File, "psr,doc" , "Invoice Template (*.doc; *.dot; *.xls; *.psr),*.doc;*.dot;*.psr;*.xls")
					CASE 1 // success
						ls_description = ls_Path 
					CASE 0 // user cancelled
						IF MessageBox ( "Custom Invoice" , &
								"By not selecting a template you have cancelled the viewing/printing operation. However, the bills will still be processed. " + &
								" Are you sure you want to cancel ?", QUESTION!, YESNO! , 2 ) = 1 THEN
							li_Return = 0
						ELSE
							lb_SelectFileAgain = TRUE
						END IF
					CASE ELSE // unexpected error
						li_Return = -1
					
				END CHOOSE
			LOOP While lb_SelectFileAgain
			
		END IF	
	
	END IF
	
	IF li_Return = 1 THEN
		
		ls_Template = ls_Description
		
		IF Right ( Trim ( ls_Template ) , 4  )= ".psr" THEN
			// we need to resopnd to a manual selection of a .psr file here. This condition can
			// occur if they want to use a custom invoice but do not have the file specified in
			// the system settings.
			
			lnv_InvoiceManager = CREATE n_Cst_InvoiceManager
			lnv_InvoiceManager.of_SetProgressBar(ab_ProgressBar)
			lnv_InvoiceManager.of_Setsourcetemplatefile( ls_Template )
			IF lnv_InvoiceManager.of_GenerateIndividualInvoices( ala_ids[] ) = 1 THEN
				li_Return = 1
			ELSE
				IF ib_ThreadMode THEN
					//We do not want to display the errors yet
					lnv_InvoiceManager.of_GetErrors(lsa_Errors)
					This.of_AddErrors(lsa_Errors)
				ELSE
					lnv_InvoiceManager.of_DisplayErrors()
				END IF
				li_Return = -1
			END IF
				
			
			DESTROY ( lnv_InvoiceManager )
		
		ELSE
					
			IF This.of_ReportManager ( ala_ids, ls_Template ) < 0 THEN
				li_Return = -1
			ELSE
				IF ab_PrintDialog THEN
					inv_ReportManager.of_PrintWordTemplate ( )
				END IF
			END IF	
		END IF
	END IF
	
	Destroy ( lnv_FileSrv )

END IF

return li_Return

end function

public function integer of_printmanifestcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar);n_cst_setting_manifcustinvoicetemplate	lnv_template
lnv_template = CREATE n_cst_setting_manifcustinvoicetemplate
String	ls_Template
ls_Template = lnv_template.of_getValue( )
DESTROY ( lnv_template )


RETURN THIS.of_PrintManifestCustomInvoices( ala_ids[], ab_printdialog, ab_Progressbar, ls_Template )

end function

public function integer of_printmanifestcustominvoices (long ala_ids[], boolean ab_printdialog, boolean ab_progressbar, string as_sourcetemplatefile);integer li_Return = 1
String	lsa_Errors[]
n_Cst_InvoiceManager	lnv_InvoiceManager


// I am going to split processing here now because I don't have time to 
// implement all of the different types of custom invoices.

String	ls_Template
ls_Template = as_sourcetemplatefile

IF Right ( Trim ( ls_Template ) , 4  )= ".psr" THEN
	
	lnv_InvoiceManager = CREATE n_Cst_InvoiceManager
	lnv_InvoiceManager.of_SetProgressBar(ab_ProgressBar)
	lnv_InvoiceManager.of_Setsourcetemplatefile( ls_Template )
	IF lnv_InvoiceManager.of_GenerateManifestInvoices( ala_ids[] ) = 1 THEN
		li_Return = 1
	ELSE
		IF ib_ThreadMode THEN
			//We do not want to display the errors yet
			lnv_InvoiceManager.of_GetErrors(lsa_Errors)
			This.of_AddErrors(lsa_Errors)
		ELSE
			lnv_InvoiceManager.of_DisplayErrors()
		END IF
		li_Return = -1
	END IF
		
	
	DESTROY ( lnv_InvoiceManager )
	
ELSE  // this was the original code in the method ... with a modification to 
		// respond to the manual seletion of a .psr
		
	//	This method asumes that the setting for printing custom invoices 
	//	has already been checked.
	

	
	any		la_Setting
	
	string	ls_Setting, &
				ls_Description, &
				ls_Path, &
				ls_File
				
	Boolean	lb_SelectFileAgain 
	
	n_cst_Settings lnv_Settings 
	n_cst_fileSrvwin32	lnv_fileSrv
	lnv_FileSrv = CREATE n_cst_fileSrvwin32
	
	is_Context = "Invoice"
	
	//get the template folder location
	n_cst_setting_templatespathfolder	lnv_PathSetting
	lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
	ls_Path = lnv_PathSetting.of_Getvalue( )
	DESTROY ( lnv_PathSetting )
	
	
	//get invoice template
	CHOOSE CASE lnv_Settings.of_GetSetting( 238, la_Setting )
		CASE 0
			
		CASE 1
			ls_File = String ( la_Setting )
			
		CASE ELSE
			
	END CHOOSE
	
	
	IF Len  ( ls_File ) = 0 THEN
		IF len ( ls_Path ) > 0 THEN
			
			ls_Path += "invoice\"
			IF len ( ls_File ) > 0 THEN
				ls_Description = ls_Path + ls_File
			ELSE
				ls_Description = ls_Path
			END IF
		
		END IF
	ELSE
		ls_Description = ls_File
	END IF
	
		
	IF len ( ls_Description ) = 0 THEN
	
		Do
			lb_SelectFileAgain = FALSE
			CHOOSE CASE GetFileOpenName("Select Manifest Invoice File", ls_Path, ls_File, "psr" , "Invoice Template (*.psr),*.psr")
				CASE 1 // success
					ls_description = ls_Path 
				CASE 0 // user cancelled
					IF MessageBox ( "Manifest Custom Invoice" , &
							"By not selecting a template you have cancelled the print/email manifest operation. However, the bills will still be processed. " + &
							" Are you sure you want to cancel ?", QUESTION!, YESNO! , 2 ) = 1 THEN
						li_Return = 0
					ELSE
						lb_SelectFileAgain = TRUE
					END IF
				CASE ELSE // unexpected error
					li_Return = -1
				
			END CHOOSE
		LOOP While lb_SelectFileAgain
	
	ELSE
		
		IF right ( ls_Description, 1 ) = "\" THEN
			
			lnv_FileSrv.of_ChangeDirectory ( ls_Description ) 
			Do
				lb_SelectFileAgain = FALSE
				CHOOSE CASE GetFileOpenName("Select Manifest Invoice File", ls_Path, ls_File, "psr" , "Invoice Template (*.psr),*.psr")
					CASE 1 // success
						ls_description = ls_Path 
					CASE 0 // user cancelled
						IF MessageBox ( "Manifest Custom Invoice" , &
								"By not selecting a template you have cancelled the print/email manifest operation. However, the bills will still be processed. " + &
								" Are you sure you want to cancel ?", QUESTION!, YESNO! , 2 ) = 1 THEN
							li_Return = 0
						ELSE
							lb_SelectFileAgain = TRUE
						END IF
					CASE ELSE // unexpected error
						li_Return = -1
					
				END CHOOSE
			LOOP While lb_SelectFileAgain
			
		END IF	
	
	END IF
	
	IF li_Return = 1 THEN
		
		ls_Template = ls_Description
		
		IF Right ( Trim ( ls_Template ) , 4  )= ".psr" THEN
			// we need to resopnd to a manual selection of a .psr file here. This condition can
			// occur if they want to use a custom invoice but do not have the file specified in
			// the system settings.
			
			lnv_InvoiceManager = CREATE n_Cst_InvoiceManager
			lnv_InvoiceManager.of_SetProgressBar(ab_ProgressBar)
			lnv_InvoiceManager.of_Setsourcetemplatefile( ls_Template )
			IF lnv_InvoiceManager.of_GenerateManifestInvoices( ala_ids[] ) = 1 THEN
				li_Return = 1
			ELSE
				IF ib_ThreadMode THEN
					//We do not want to display the errors yet
					lnv_InvoiceManager.of_GetErrors(lsa_Errors)
					This.of_AddErrors(lsa_Errors)
				ELSE
					lnv_InvoiceManager.of_DisplayErrors()
				END IF
				li_Return = -1
			END IF
				
			
			DESTROY ( lnv_InvoiceManager )
		END IF
	END IF
	
	Destroy ( lnv_FileSrv )

END IF

return li_Return

end function

public function integer of_setthreadmode (boolean ab_switch);ib_ThreadMode = ab_Switch

Return 1
end function

public function integer of_geterrors (ref string asa_errors[]);int 		li_errorCount
int		i
String	lsa_Errors[]

n_cst_OFRError 				lnva_Error[]
n_cst_OFRError_Collection 	lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_ErrorCollection.geterrorcount( )

FOR i = 1 TO li_ErrorCount
  lsa_Errors[i] = string( lnva_Error[i].getErrorMessage() )
NEXT

asa_Errors = lsa_Errors

Return li_ErrorCount
end function

public function integer of_adderrors (string asa_errors[]);String				ls_ErrorMessage
Long					i, ll_Errorcount
n_cst_OFRError		lnv_Error

ll_ErrorCount = UpperBound(asa_Errors)
FOR i = 1 TO ll_ErrorCount

	lnv_Error = This.AddOFRError ( )
	
	ls_ErrorMessage = asa_errors[i]
	
	lnv_Error.SetErrorMessage( ls_ErrorMessage )
	lnv_Error.SetMessageHeader ( "Billing" )
	
NEXT

RETURN 1
end function

on n_cst_billservices.create
call super::create
end on

on n_cst_billservices.destroy
call super::destroy
end on

