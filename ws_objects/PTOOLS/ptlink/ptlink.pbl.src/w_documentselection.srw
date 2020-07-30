$PBExportHeader$w_documentselection.srw
forward
global type w_documentselection from w_response
end type
type dw_1 from u_dw within w_documentselection
end type
type sle_1 from singlelineedit within w_documentselection
end type
type gb_2 from groupbox within w_documentselection
end type
type gb_1 from groupbox within w_documentselection
end type
type rb_custom from radiobutton within w_documentselection
end type
type rb_system from radiobutton within w_documentselection
end type
type ddlb_templatelist from dropdownlistbox within w_documentselection
end type
type cbx_seperatedelivery from checkbox within w_documentselection
end type
type cb_ok from u_cbok within w_documentselection
end type
type cb_cancel from u_cbcancel within w_documentselection
end type
type cb_more from commandbutton within w_documentselection
end type
type ddlb_documenttype from dropdownlistbox within w_documentselection
end type
type cbx_resend from checkbox within w_documentselection
end type
end forward

global type w_documentselection from w_response
integer x = 123
integer y = 208
integer width = 3333
integer height = 1952
string title = "Document Selection"
long backcolor = 12632256
event ue_open ( )
dw_1 dw_1
sle_1 sle_1
gb_2 gb_2
gb_1 gb_1
rb_custom rb_custom
rb_system rb_system
ddlb_templatelist ddlb_templatelist
cbx_seperatedelivery cbx_seperatedelivery
cb_ok cb_ok
cb_cancel cb_cancel
cb_more cb_more
ddlb_documenttype ddlb_documenttype
cbx_resend cbx_resend
end type
global w_documentselection w_documentselection

type variables
string		is_Document
string		is_Topic
string		is_FileName
string		is_TemplatePath
long			ila_ShipmentId[]
long			il_ShipmentId
integer		iia_Stops[]
n_cst_beo_event	inva_EventBeo[]
datawindow	idw_Source
string		is_MatchColumn
string		is_DeliveryTemplate
string		is_InvoiceTemplate
string		is_QuoteTemplate
string		is_ExportTemplate
string		is_RateConfTemplate
Boolean		ib_IsPSRDocument
String		is_InvoiceError

n_cst_bso_ReportManager	inv_ReportManager
n_cst_bso_Dispatch	inv_Dispatch
n_cst_Bso_PSR_Manager 	inv_PSR_Man
Long	ila_IndividualInvoices[]
Long	ila_ManifestInvoices[]

end variables

forward prototypes
public subroutine wf_loadtemplatelist ()
public function boolean wf_usecustomtemplate (long al_SystemSettingId)
public function string wf_getcustomtemplate (long al_SystemSettingId)
private function boolean wf_processcrossdocks ()
public subroutine wf_getpassedparms (n_cst_msg anv_msg)
private function integer wf_processdocument ()
private function integer wf_settemplatepath (string as_path)
private function integer wf_printinvoices ()
private function integer wf_getshipments (ref n_cst_beo_shipment anva_shipments[])
private function long wf_getstoplist (long al_shipmentid, ref integer aia_stop[])
public subroutine wf_processpsr ()
public function integer wf_getshipmentfreightitem (long al_shipid, ref n_cst_beo_item anva_item[])
public function integer wf_getpudelstops (n_cst_beo_item anva_item[], ref integer aia_pu[], ref integer aia_del[])
private subroutine wf_loadshipmentbeo (ref n_cst_beo_shipment anva_shipmentbeo[], long ala_id[])
private function boolean wf_showresendbutton ()
private function boolean wf_allowresend (long al_shipmentid)
private function string wf_gettemplatepath ()
private function integer wf_processresend (long ala_shipmentids[])
public function integer wf_resendmode (boolean ab_resendmode)
protected function integer wf_resendauthorized ()
end prototypes

event ue_open();string	ls_list, &
			ls_filter

long		ll_Count, &
			ll_Arraycount

integer	li_Select

blob		lblb_State
n_cst_Msg	lnv_Msg
s_parm		lstr_Parm

THIS.SetReDraw(FALSE)

IF isvalid ( idw_Source ) THEN
	Long ll_index
	///DEK 4-3-07	Issue 2810 fix.
	//This is one of the dumber things I have ever seen.  Basically powerbuilder
	//would crash every time you deleted an event, saved the shipment, and opened the
	//document window.  The line that was failing was getFullState() on the source.
	//I do not know why it failed in that scenereo, and I do not know why the following
	//fixes it, but it does, and I am happy.  I insert a row, and discard it and then
	//getfullstate doesn't fail......Happy days ahead...
	idw_source.setredraw( false)
	ll_index = idw_source.insertRow( 0)
	idw_source.rowsdiscard( ll_index, ll_index , PRIMARY!)
	idw_source.setredraw(true)
	// END CHANGE 4-3-07
	idw_Source.GetFullState (lblb_State )

	dw_1.SetFullState ( lblb_State )
	dw_1.of_setinsertable ( false )
	dw_1.of_setDeleteable ( false )
	
	dw_1.Event ue_HideFooter()
END IF

//check dw type for filter column name
ll_ArrayCount = upperbound ( iia_stops)
IF ll_ArrayCount > 0 THEN
	
	cbx_seperatedelivery.checked=TRUE
	
	FOR ll_Count = 1 to ll_Arraycount
		ls_list += string(iia_stops[ll_Count]) + ", "
	NEXT
	
ELSE
	cbx_seperatedelivery.checked = FALSE
	
	ll_ArrayCount = upperbound ( ila_ShipmentId)
	
	IF ll_ArrayCount = 0 THEN
		ila_ShipmentId[1] = il_ShipmentId
		ll_ArrayCount = 1
	END IF
	
	FOR ll_Count = 1 to ll_Arraycount
		ls_list += string(ila_ShipmentId[ll_Count]) + ", "
	NEXT

END IF
	
ls_list = left(ls_list,len(ls_list) - 2)
ls_Filter = is_MatchColumn + " in (" + ls_list + ")"
dw_1.SetFilter(ls_Filter)
dw_1.Filter( )

dw_1.Modify("destroy r_hlt")

li_Select = ddlb_documenttype.SelectItem ( is_Document, 0 )
ddlb_documenttype.Event selectionchanged(li_Select)
//set is_filename 
//ddlb_templatelist.Event Selectionchanged(1)

THIS.SetReDraw(TRUE)

n_Cst_beo_Shipment	lnva_Shipments[]
String	ls_InvoiceNum
Int	i
THIS.wf_GetShipments ( lnva_Shipments )
ll_Count = UpperBound ( lnva_Shipments )
FOR i = 1 TO ll_Count
	ls_InvoiceNum = lnva_Shipments[i].of_GetInvoiceNumber()
	IF Pos(ls_InvoiceNum, "--") > 0 THEN
		ila_manifestinvoices [UpperBound(ila_manifestinvoices) + 1] = lnva_Shipments[i].of_GetID ( ) 
	ELSE
		ila_individualinvoices [UpperBound(ila_individualinvoices[]) + 1] = lnva_Shipments[i].of_GetID ( ) 
	END IF		
NEXT


end event

public subroutine wf_loadtemplatelist ();// RDT 4-1-03 Added PSR file types
String	ls_FileName 

long		ll_NewRow, &
			ll_Count, &
			ll_FileCount

n_cst_dirattrib		lnv_DirAttrib[]
n_cst_FileSrvwin32 	lnv_FileSrv

lnv_FileSrv = CREATE n_cst_FileSrvwin32
ddlb_templatelist.Reset ( )
//doc
lnv_FileSrv.of_DirList (  is_TemplatePath + "*.doc" , 39, lnv_DirAttrib )
ll_FileCount =  UpperBound( lnv_DirAttrib ) 
For ll_Count = 1 TO ll_FileCount
	ls_FileName = lnv_dirAttrib[ll_Count].is_FileName
	IF Len ( ls_FileName ) > 0 THEN				
		ddlb_templatelist.AddItem (ls_FileName )
	END IF
NEXT

//dot
lnv_FileSrv.of_DirList (  is_TemplatePath + "*.dot" , 39, lnv_DirAttrib )
ll_FileCount =  UpperBound( lnv_DirAttrib ) 
For ll_Count = 1 TO ll_FileCount
	ls_FileName = lnv_dirAttrib[ll_Count].is_FileName
	IF Len ( ls_FileName ) > 0 THEN				
		ddlb_templatelist.AddItem (ls_FileName )
	END IF
NEXT

//xls
lnv_FileSrv.of_DirList (  is_TemplatePath + "*.xls" , 39, lnv_DirAttrib )
ll_FileCount =  UpperBound( lnv_DirAttrib ) 
For ll_Count = 1 TO ll_FileCount
	ls_FileName = lnv_dirAttrib[ll_Count].is_FileName
	IF Len ( ls_FileName ) > 0 THEN				
		ddlb_templatelist.AddItem (ls_FileName )
	END IF
NEXT

//PSR
lnv_FileSrv.of_DirList (  is_TemplatePath + "*.psr" , 39, lnv_DirAttrib )
ll_FileCount =  UpperBound( lnv_DirAttrib ) 
For ll_Count = 1 TO ll_FileCount
	ls_FileName = lnv_dirAttrib[ll_Count].is_FileName
	IF Len ( ls_FileName ) > 0 THEN				
		ddlb_templatelist.AddItem (ls_FileName )
	END IF
NEXT

DESTROY lnv_FileSrv

ddlb_templatelist.SetFocus()

end subroutine

public function boolean wf_usecustomtemplate (long al_SystemSettingId);any		la_Setting

string	ls_Setting

boolean	lb_UseCustomTemplate

n_cst_Settings lnv_Settings 

CHOOSE CASE lnv_Settings.of_GetSetting( al_SystemSettingId, la_Setting ) 
CASE 0
	lb_UseCustomTemplate=FALSE
	
CASE 1
	ls_Setting = string ( la_Setting ) 
	
	CHOOSE CASE ls_Setting
			
		CASE "YES!"			
			lb_UseCustomTemplate=TRUE
							
		CASE "NO!"
			lb_UseCustomTemplate=FALSE
			
		CASE "ASK!"
			lb_UseCustomTemplate=TRUE
			
	END CHOOSE
	
CASE ELSE
	lb_UseCustomTemplate=FALSE
	
END CHOOSE

RETURN lb_UseCustomTemplate
end function

public function string wf_getcustomtemplate (long al_SystemSettingId);any		la_Setting

string	ls_Setting, &
			ls_Description
			
n_cst_Settings lnv_Settings 

CHOOSE CASE lnv_Settings.of_GetSetting( al_SystemSettingId, la_Setting )
	CASE 0
		
	CASE 1
		ls_Description = String ( la_Setting )
							
	CASE ELSE
		
END CHOOSE

return ls_Description
end function

private function boolean wf_processcrossdocks ();
string	ls_MessageHeader

Boolean		lb_FilterDockEvents
				
n_cst_CrossDock	lnv_CrossDock

lnv_CrossDock = CREATE n_cst_CrossDock
	
CHOOSE CASE is_Document
		
	CASE n_cst_Constants.cs_Document_DeliveryReceipt
		ls_MessageHeader = "Print Custom Delivery Receipt"
		
	CASE n_cst_Constants.cs_Document_Invoice
		ls_MessageHeader = "Print Custom Invoice"

END CHOOSE

IF lnv_CrossDock.of_Ready ( ) THEN

	CHOOSE CASE is_Document
			
		CASE n_cst_Constants.cs_Document_DeliveryReceipt
			lb_FilterDockEvents = lnv_CrossDock.of_GetFilterOnDelrec ( )
			
		CASE n_cst_Constants.cs_Document_Invoice
			lb_FilterDockEvents = lnv_CrossDock.of_GetFilterOnInvoice ( )
	
	END CHOOSE

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

public subroutine wf_getpassedparms (n_cst_msg anv_msg);long	ll_Count, &
		ll_ArrayCount

integer	li_Ndx, &
			li_MsgCount

s_parm	lstr_Parm

li_MsgCount = 	anv_msg.of_get_count()
FOR li_Ndx = 1 to li_MsgCount
	anv_msg.of_get_parm(li_ndx, lstr_parm)
	
	CHOOSE CASE lstr_parm.is_label
				
		CASE "DOCUMENT"
			is_document = lstr_Parm.ia_Value 
			
		CASE "TOPIC"
			is_Topic = lstr_Parm.ia_Value 
			
			//load based on topic
			ddlb_documenttype.AddItem (n_cst_Constants.cs_Document_DeliveryReceipt )
			ddlb_documenttype.AddItem (n_cst_Constants.cs_Document_Invoice )
			ddlb_documenttype.AddItem (n_cst_Constants.cs_Document_Quote )
			ddlb_documenttype.AddItem (n_cst_Constants.cs_Document_RateConfirmation )
			ddlb_documenttype.AddItem ("Export File" )
			
		CASE "SHIPMENTID", "TARGET_IDS", 'EVENTID'
			ila_ShipmentId = lstr_Parm.ia_Value
			
		CASE "TARGET_ID"
			il_ShipmentId = lstr_Parm.ia_Value
		CASE "EVENTS"
			inva_EventBeo = lstr_Parm.ia_Value
			ll_ArrayCount = upperbound ( inva_EventBeo )
			if is_matchcolumn = 'de_ship_seq' then
				FOR ll_Count = 1 to ll_ArrayCount
					iia_stops[ll_Count] = inva_EventBeo[ll_Count].of_GetShipmentSequence()
				NEXT
				
			end if
			
		CASE "DATAWINDOW"
			idw_Source = lstr_Parm.ia_Value

		CASE "MATCHCOLUMN"
			is_matchcolumn = lstr_Parm.ia_Value
			
	END CHOOSE
		
NEXT



end subroutine

private function integer wf_processdocument ();// RDT 4-1-03 added code for wf_processPSR()
integer	li_Return, &
			lia_orig[], &
			lia_dest[], &
			li_null, &
			lia_Stops[]

long	ll_Count, &
		ll_count2, &
		ll_StopCount, &
		ll_BeoCount
		
any	laa_Beo [], &
		laa_Data []
Long	i
s_parm		lstr_Parm		
n_cst_msg				lnv_msg
n_cst_beo_shipment	lnva_ShipmentBeo[]
n_cst_beo_shipment	lnva_TempShipmentBeo[]

n_Cst_bso_Dispatch	lnva_Disp[]

n_CsT_beo_Shipment	lnv_Shipment
n_cst_beo_item			lnva_item[]

n_cst_ShipmentManager	lnv_Manager

setnull(li_null)
// RDT 4-1-03 Start
If ib_IsPSRDocument Then 
	this.wf_processPSR( )
Else
// RDT 4-1-03 end

	inv_Dispatch = CREATE n_cst_bso_Dispatch 
	
	CHOOSE CASE is_Document
			
		CASE n_cst_Constants.cs_Document_DeliveryReceipt
			
			IF cbx_seperatedelivery.checked THEN		
				// loop thru stops
				ll_StopCount = upperbound ( iia_Stops ) 
				IF ll_StopCount > 0 THEN
					
					FOR ll_Count = 1 to ll_StopCount 
						this.wf_loadshipmentbeo(lnva_ShipmentBeo, ila_shipmentid)
						//the lnva_ShipmentBeo index in line below was 'll_BeoCount' but I switched it to
						// ll_count.  This did not seem to produce any meaningful results except to
						// prevent an array boundary exceeded. I don't know what the intended functionality is 
						// supposed to be... and i guess no one else does. <<*>>
						lnva_ShipmentBeo [ ll_Count ].of_SetDeliveryMode(li_null, iia_Stops[ll_count])
					NEXT
				
				ELSE
									
			
					lnv_Shipment = CREATE n_cst_beo_Shipment
					FOR i = 1 TO UpperBound ( ila_shipmentid ) 
						// wierd... Yes 
						// does it work... Yes
						lnva_Disp [ i ] = CREATE n_cst_bso_Dispatch
						lnva_Disp [ i ].of_Retrieveshipment( ila_shipmentid[i] )						
						lnva_Disp [ i ].of_FilterShipment( ila_shipmentid [i] )
					
						lnv_Shipment.of_SetSource ( lnva_Disp [ i ].of_GetShipmentCache ( ) ) 
						lnv_Shipment.of_Setsourceid ( ila_Shipmentid[i] ) 
						lnv_Shipment.of_SetItemSource ( lnva_Disp [ i ].of_GetItemCache ( ) )
						lnv_Shipment.of_SetEventSource ( lnva_Disp [ i ].of_GetEventCache ( )) 											
						lnv_Manager.of_Createshipmentsfordeliveryreceipt( lnv_Shipment , lnva_ShipmentBeo )
					NEXT
																							
				END IF
				
			ELSE
				this.wf_loadshipmentbeo(lnva_ShipmentBeo, ila_shipmentid)
				
			END IF
	
			laa_Beo = lnva_ShipmentBeo			
			
		CASE n_cst_Constants.cs_Document_Invoice, n_cst_Constants.cs_Document_Quote, "Export File", n_cst_Constants.cs_Document_RateConfirmation
		
			this.wf_loadshipmentbeo(lnva_ShipmentBeo, ila_shipmentid)
			laa_Beo = lnva_ShipmentBeo			
			
	END CHOOSE
	
	IF upperbound(inva_eventbeo) > 0 THEN
		laa_Beo = inva_eventbeo
		lstr_parm.is_Label = "NUMBERTAGS"
		lstr_Parm.ia_Value = '' 
		lnv_msg.of_Add_Parm ( lstr_Parm )
	
	
	end if
	
	IF upperbound ( laa_Beo ) > 0 THEN
	
		IF inv_ReportManager.of_CreateReport ( is_Topic, is_templatepath + is_FileName, laa_Beo, TRUE, TRUE, laa_Data, lnv_msg ) < 0 THEN
		
			li_Return = -1
		ELSE
			IF is_Document = n_cst_Constants.cs_Document_Invoice THEN
				inv_ReportManager.of_PrintWordTemplate ( )
			END IF
		END IF
	
	END IF
	
	IF isvalid ( inv_Dispatch ) THEN
		destroy inv_Dispatch
	END IF
	
	ll_Count = UpperBound ( lnva_ShipmentBeo ) 
	FOR i = 1 TO ll_Count
	//	DESTROY ( lnva_ShipmentBeo[i] )
	NEXT
	
	DESTROY ( lnv_Shipment )
	
	ll_Count = UpperBound ( lnva_Disp ) 
	FOR i = 1 TO ll_Count
		DESTROY ( lnva_Disp[i] )
	NEXT
End If

return li_Return

end function

private function integer wf_settemplatepath (string as_path);string	ls_Template, &
			ls_Drive, &
			ls_DirPath, &
			ls_FileName, &
			ls_Ext

Integer	li_Select, &
			li_Return = 1

n_cst_FileSrvwin32	lnv_FileSrv

ls_Template = as_Path

IF len(ls_Template) > 0 THEN
	
	lnv_FileSrv = CREATE n_cst_FileSrvwin32

	IF lnv_FileSrv.of_ParsePath(ls_Template, ls_Drive, ls_DirPath, ls_FileName, ls_Ext) = 1 THEN
		is_TemplatePath = ls_Drive + ls_DirPath
		This.wf_LoadTemplateList()
		li_Select = ddlb_templatelist.SelectItem ( ls_filename, 1 )
		IF li_Select > 0 THEN
			ddlb_templatelist.Event Selectionchanged(li_Select)
		ELSE
			ddlb_templatelist.SelectItem ( 1 )
			ddlb_templatelist.Event Selectionchanged(1)
		END IF

	END IF

	destroy lnv_FileSrv

END IF			

return li_Return
end function

private function integer wf_printinvoices ();Boolean					lb_PegPrint
Long						ll_tmp
Long						i
Long						ll_Count
DataStore				lds_Cache
Int						li_PrintReturn
n_cst_msg				lnv_msg
n_cst_pegasus_print	lnv_pegPrint

Integer	li_ImageReturn, &
			li_Return = 1, &
			li_Ndx, &
			li_ArrayCount
			
boolean	lb_PrintImages
String	ls_Type
n_cst_LicenseManager	lnv_LicenseManager
n_cst_billing			lnv_cst_Billing
n_cst_beo_Shipment	lnva_Shipments[]


lnv_cst_billing = create n_cst_billing

THIS.wf_GetShipments ( lnva_Shipments )

IF UpperBound (ila_individualinvoices ) > 0 AND UpperBound ( ila_manifestinvoices ) > 0 THEN
	MessageBox ( "Reprinting Invoices" , "Your selection includes mixed types of invoices (Manifests/Individual). Please limit your selection to one type per request." )
	li_Return =  -1
END IF

IF li_Return = 1 THEN
	IF UpperBound(ila_ManifestInvoices[]) > 0 THEN
		//NOTE: of_Manifest_Check may change the values of ila_ManifestInvoices
		ls_Type = "INVOICE!" //Dummy variable
		CHOOSE CASE lnv_cst_Billing.of_Manifest_Check(ila_ManifestInvoices[], ls_Type /*type does not matter here*/)
		
		CASE -1  //Failure
			MessageBox ( "Print Invoices", "Could not retrieve shipment(s) from database for manifest check.")
			li_return =  -1
		
		CASE -2  //Either more than one manifest, or a mix of manifest and non-manifest shipments.
			MessageBox ( "Print Invoices", "Only one manifest may be viewed at a time.~n~nRequest cancelled." )
			li_return = -1
			
		END CHOOSE
		
		//Create lnva_Shipments with ALL shipments from manifest
		IF not isValid ( inv_Dispatch ) THEN
			inv_Dispatch = CREATE n_cst_bso_Dispatch 
		END IF
		
		inv_Dispatch.of_RetrieveShipments (ila_ManifestInvoices[])
		lds_Cache = inv_Dispatch.of_GetShipmentCache ( )
		
		// destroy any valid shipments to prevent a memory leak
		ll_Count = UpperBound ( lnva_shipments )
		FOR i = 1 TO ll_Count
			DESTROY ( lnva_shipments[i] )
		NEXT
		
		ll_Count = UpperBound ( ila_ManifestInvoices[] )
		FOR i = 1 TO ll_Count
			
			lnva_Shipments [i] = CREATE n_cst_Beo_Shipment
			lnva_Shipments [i].of_SetSource (lds_Cache)
			lnva_Shipments [i].of_SetSourceid (ila_ManifestInvoices[i])
		
		NEXT
	
	END IF
END IF

IF li_Return = 1 THEN

	IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN
	
		
	
		// this will unlock pegasus if not already done
		n_cst_bso_ImageManager_pegasus	lnv_Imagemanager
		lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
		
		IF lnv_ImageManager.of_CheckConnection ( )  <> 0 THEN
			MessageBox ("Image Printing" , "The controls needed to print the associated images could not be located or unlocked. Printing of the images will not occur." ) 
			lb_PrintImages = FALSE
		ELSE
			lb_PrintImages = TRUE
		END IF
		
		IF isValid ( lnv_ImageManager ) THEN
			Destroy lnv_ImageManager
		END IF
	
		IF lb_PrintImages THEN
			li_ImageReturn =  lnv_cst_billing.of_DoImagesNeedToPrint ( lnva_Shipments ) 
		
			CHOOSE CASE li_ImageReturn
					
				CASE -1 // failure
					
				CASE 1 // success, but no images to be printed
						lb_PrintImages = FALSE
						
				CASE 2 // success and there are images to print
					
					IF MessageBox ( "Document Imaging" , "Would you like to print the associated images" , QUESTION!, YESNO!, 1 ) = 1 THEN
						
						lb_PrintImages = TRUE	
						
					ELSE
						
						lb_PrintImages = FALSE	
						
					END IF
					
				CASE ELSE // unexpected Return
					
			END CHOOSE 
			
		END IF
		
	END IF
	
	IF len ( is_FileName ) = 0 THEN
		ddlb_templatelist.SelectItem (1)
	END IF
		
		
	// If Imaging is licensed then I am going to see if they are printing a .psr invoice.
	// If so, then I am going to ask If they want to collate the images and the invoices. 
	Boolean	lb_Collate
	IF lb_PrintImages AND right ( Trim ( is_filename ) , 4) = ".psr" THEN
	
		lb_Collate = messageBox ( "Printing Invoices/Images" , "Do you want to skip the Report Viewer and go directly to collating the specified images with the invoices?" ,QUESTION! , YESNO!, 1 ) = 1
	
	END IF
	
	
	IF lb_Collate THEN
	//	n_cst_billservices	lnv_BillSrv
		
	//	lnv_BillSrv.of_printcustominvoices( lla_ShipmentIDS, TRUE , is_templatepath + is_filename ) // The boolean has no effect when printing a .psr
	//		
	//	CLOSE ( THIS ) 
		/////////
		n_Cst_InvoiceManager lnv_InvoiceManager
		lnv_InvoiceManager = CREATE n_Cst_InvoiceManager
		lnv_InvoiceManager.of_SetAllowemail( FALSE )
		
		IF UpperBound ( ila_individualinvoices ) > 0 THEN
		
			lnv_InvoiceManager.of_Setsourcetemplatefile( is_templatepath + is_filename )
			IF lnv_InvoiceManager.of_GenerateIndividualInvoices( ila_individualinvoices ) = 1 THEN
				li_Return = 1
			ELSE
				lnv_InvoiceManager.of_DisplayErrors()
				li_Return = -1
			END IF
			
		ELSEIF UpperBound ( ila_manifestinvoices ) > 0 THEN
		  
			lnv_InvoiceManager.of_Setsourcetemplatefile( is_templatepath + is_filename )
			IF lnv_InvoiceManager.of_generatemanifestinvoices ( ila_manifestinvoices ) = 1 THEN
				li_Return = 1
			ELSE
				lnv_InvoiceManager.of_DisplayErrors()
				li_Return = -1
			END IF
		END IF
		
		DESTROY ( lnv_InvoiceManager )
		//////////
		
		
		
	ELSE
	
	
	
		IF this.wf_ProcessDocument() < 0 THEN
			MessageBox ( "Print Custom Invoice", " Invoices have not been printed.")
			lb_PrintImages = FALSE
		END IF
				
		IF lb_PrintImages THEN
			
		//	lnv_cst_billing.of_PrintBillingImages ( dw_bills )
			
		//**		
			
			lnv_PegPrint = CREATE n_cst_pegasus_print
			
			IF isValid ( lnv_PegPrint ) THEN
				IF lnv_PegPrint.of_PrintSetup ( lnv_msg ) <> 1 THEN
					lb_PegPrint = FALSE
				END IF
			
				li_ArrayCount = upperbound ( lnva_Shipments )
				For li_Ndx = 1 to li_ArrayCount
					IF lnva_Shipments[li_Ndx].of_HasSource() THEN
						li_PrintReturn = lnv_cst_billing.of_PrintImages ( lnva_Shipments[li_Ndx] , lnv_msg )
						IF li_PrintReturn <> 1 THEN
							messageBox( "Image Printing" , "An error occurred while attempting to print the images associated with the current invoice.")						
						END IF
					END IF
				NEXT
			ELSE 
				li_Return = -1
			END IF
			
				
			DESTROY lnv_PegPrint
			
		//**
		
			
		END IF
	END IF
	
END IF

li_ArrayCount = UpperBound ( lnva_Shipments )
FOR li_Ndx = 1 TO li_ArrayCount 
	DESTROY lnva_Shipments [ li_Ndx ]
NEXT

Destroy lnv_cst_billing
	
return  li_Return
end function

private function integer wf_getshipments (ref n_cst_beo_shipment anva_shipments[]);Long	i
Long	ll_IDCount

n_cst_beo_shipment	lnv_Shipment
n_cst_beo_shipment	lnva_Shipments[]
DataStore	lds_Cache


IF not isValid ( inv_Dispatch ) THEN
	inv_Dispatch = CREATE n_cst_bso_Dispatch 
END IF

// destroy any valid shipments passed in to prevent a memory leak
ll_IdCount = UpperBound ( anva_shipments )
FOR i = 1 TO ll_IdCount
	DESTROY ( anva_shipments[i] )
NEXT


inv_Dispatch.of_RetrieveShipments ( ila_ShipmentId[] )
lds_Cache = inv_Dispatch.of_GetShipmentCache ( )

ll_IDCount = UpperBound ( ila_ShipmentId[] )
FOR i = 1 TO ll_IDCount
	
//	lnv_Shipment.of_SetSource ( lds_Cache )
//	lnv_Shipment.of_SetSourceid ( ila_ShipmentId[i]  )
//	lnva_Shipments[ Upperbound ( lnva_Shipments ) + 1 ] = lnv_Shipment
	
	lnva_Shipments [ i ] = CREATE n_cst_Beo_Shipment
	lnva_Shipments [ i ].of_SetSource ( lds_Cache )
	lnva_Shipments [ i ].of_SetSourceid ( ila_ShipmentId[i]  )

NEXT

anva_Shipments = lnva_Shipments

RETURN UpperBound ( anva_Shipments )
end function

private function long wf_getstoplist (long al_shipmentid, ref integer aia_stop[]);//return number of deliver stops
integer	li_Stops

long		ll_EventCount, &
			ll_StopCount, &
			ll_Ndx, &
			lla_shipmentid[]

n_ds	lds_ShipmentCache,&
		lds_EventCache, &
		lds_ItemCache
		
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_shipment	lnv_Shipmentbeo
n_cst_beo_event		lnva_EventBeo[]

lnv_Dispatch = CREATE n_cst_bso_Dispatch 
lnv_Shipmentbeo = CREATE n_cst_beo_Shipment


lla_shipmentid[1] = al_shipmentid

IF isValid ( lnv_Dispatch ) THEN
	
	lnv_Dispatch.of_RetrieveShipments ( lla_shipmentid )
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

		lnv_Shipmentbeo.of_SetSource ( lds_ShipmentCache )
		lnv_Shipmentbeo.of_SetSourceId ( lla_shipmentid [ 1 ] )
		lnv_Shipmentbeo.of_SetEventSource ( lds_EventCache )
	
		lnv_Shipmentbeo.of_GetEventList(lnva_EventBeo)
		ll_EventCount = upperbound ( lnva_EventBeo ) 
		FOR ll_Ndx = 1 to ll_EventCount
			IF lnva_EventBeo[ll_Ndx].of_IsDeliverGroup() THEN
				ll_StopCount ++
				aia_stop[ll_StopCount] = lnva_EventBeo[ll_Ndx].of_GetShipmentSequence()
			END IF
		NEXT
	end if
	
end if

//DESTROY ( lnv_Shipmentbeo )
//DESTROY ( lnv_Dispatch )


FOR ll_Ndx = 1 TO ll_EventCount 
//	DESTROY ( lnva_EventBeo[ ll_Ndx ] )
NEXT

return ll_StopCount
end function

public subroutine wf_processpsr ();//
/***************************************************************************************
NAME			: wf_ProcessPSR
ACCESS		: Private 
ARGUMENTS	: None
RETURNS		: none
DESCRIPTION	: 

REVISION		: RDT 4-1-03
***************************************************************************************/

/**** updated code */
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

lstr_Parm.is_Label = "TEMPLATE"
lstr_Parm.ia_Value = is_templatepath+is_FileName
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "SHIPMENTIDS"
IF UpperBound(ila_IndividualInvoices) > 0 THEN
	lstr_Parm.ia_Value = ila_IndividualInvoices
ELSEIF UpperBound(ila_ManifestInvoices) > 0 THEN
	lstr_Parm.ia_Value = ila_ManifestInvoices[]
END IF
lnv_Msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( This, lnv_Msg )

/**end updated code */

//CloseWithReturn ( This, is_templatepath+is_FileName ) 

end subroutine

public function integer wf_getshipmentfreightitem (long al_shipid, ref n_cst_beo_item anva_item[]);integer	li_return

long	ll_shipmentcount, &
		ll_shipmentindex, &
		ll_BeoCount
		
n_ds	lds_ShipmentCache,&
		lds_ItemCache
		
n_cst_beo_shipment	lnv_shipmentbeo

IF isValid ( inv_Dispatch ) THEN
	
	inv_Dispatch.of_RetrieveShipments ( {al_shipid} )
	lds_ShipmentCache = inv_Dispatch.of_GetShipmentCache ( )
	IF isValid ( lds_ShipmentCache ) THEN
		lds_ShipmentCache.SetFilter ( "" )
		lds_ShipmentCache.SetSort ( "ds_id A" )
		lds_ShipmentCache.Filter ( )
		lds_ShipmentCache.Sort ( )
		
		lds_ItemCache = inv_Dispatch.of_GetItemCache ( )
		IF isValid ( lds_ItemCache ) THEN
			lds_ItemCache.SetFilter ( "" )
			lds_ItemCache.SetSort ( "di_shipment_id A, di_item_type D, di_item_id A " )
			lds_ItemCache.Filter ( )
			lds_ItemCache.Sort ( )
		END IF

		lnv_shipmentbeo  = CREATE n_cst_beo_shipment
		lnv_shipmentbeo.of_SetSource ( lds_ShipmentCache )
		lnv_shipmentbeo.of_SetSourceId ( al_shipid )
		lnv_shipmentbeo.of_SetItemSource ( lds_ItemCache )
		
		lnv_shipmentbeo.of_GetItemList(anva_item, n_cst_constants.cs_ItemType_Freight )
		
	end if
end if


return upperbound(anva_item)
end function

public function integer wf_getpudelstops (n_cst_beo_item anva_item[], ref integer aia_pu[], ref integer aia_del[]);integer	li_count, &
			lia_blank[], &
			li_index

long		ll_pu, &
			ll_del
			
			
			
li_count = upperbound( anva_item )

//clear old first
aia_pu = lia_blank
aia_del = lia_blank

for li_index = 1 to li_count
	
	ll_pu = anva_item[li_index].of_GetPickupEvent()
	if ll_pu > 0 then
		ll_del = anva_item[li_index].of_GetDeliverEvent()
		if ll_del > 0 then
			aia_pu[upperbound(aia_pu) + 1] = ll_pu
			aia_del[upperbound(aia_del) + 1] = ll_del
		end if
	end if
next

return upperbound(aia_pu)
end function

private subroutine wf_loadshipmentbeo (ref n_cst_beo_shipment anva_shipmentbeo[], long ala_id[]);long	ll_shipmentcount, &
		ll_shipmentindex, &
		ll_BeoCount
		
boolean	lb_FilterCrossDocks

n_ds	lds_ShipmentCache,&
		lds_EventCache, &
		lds_ItemCache
		
ll_shipmentCount = upperbound ( ala_Id )
ll_BeoCount = upperbound ( anva_ShipmentBeo )

IF isValid ( inv_Dispatch ) THEN
	
	inv_Dispatch.of_RetrieveShipments ( ala_Id )
	lds_ShipmentCache = inv_Dispatch.of_GetShipmentCache ( )
	IF isValid ( lds_ShipmentCache ) THEN
		lds_ShipmentCache.SetFilter ( "" )
		lds_ShipmentCache.SetSort ( "ds_id A" )
		lds_ShipmentCache.Filter ( )
		lds_ShipmentCache.Sort ( )
		
		lds_eventCache = inv_Dispatch.of_GeteventCache ( )
		IF isValid ( lds_eventCache ) THEN
			lds_EventCache.SetFilter ( "" )
			lds_EventCache.SetSort ( "de_shipment_id A, de_ship_seq A" )
			lds_EventCache.Filter ( )
			lds_EventCache.Sort ( )
		END IF

		//filter docks	
		lb_FilterCrossDocks = this.wf_ProcessCrossDocks ( )
		
		lds_ItemCache = inv_Dispatch.of_GetItemCache ( )
		IF isValid ( lds_ItemCache ) THEN
			lds_ItemCache.SetFilter ( "" )
			lds_ItemCache.SetSort ( "di_shipment_id A, di_item_type D, di_item_id A " )
			lds_ItemCache.Filter ( )
			lds_ItemCache.Sort ( )
		END IF
		
		FOR ll_ShipmentIndex = 1 TO ll_ShipmentCount
	
			ll_BeoCount ++
			anva_ShipmentBeo [ ll_BeoCount ] = CREATE n_cst_beo_shipment
			anva_ShipmentBeo [ ll_BeoCount ].of_SetSource ( lds_ShipmentCache )
			anva_ShipmentBeo [ ll_BeoCount ].of_SetSourceId ( ala_Id [ ll_ShipmentIndex ] )

			anva_ShipmentBeo [ ll_BeoCount ].of_SetEventSource ( lds_EventCache )
			anva_ShipmentBeo [ ll_BeoCount ].of_SetItemSource ( lds_ItemCache )
			anva_ShipmentBeo [ ll_BeoCount ].of_SetExcludeCrossDock ( lb_FilterCrossDocks )
			anva_ShipmentBeo [ ll_BeoCount ].of_LockEventList ( "reportmanager" )
			
		NEXT

	end if
end if


end subroutine

private function boolean wf_showresendbutton ();Long	ll_NumShipments
Long	i
Boolean	lb_Show

n_cst_LicenseManager	lnv_LicenseMan


ll_NumShipments = UpperBound(ila_ShipmentId[])
FOR i = 1 TO ll_NumShipments
	
	lb_Show = wf_AllowResend(ila_ShipmentId[i])

	
	IF lb_Show THEN
		EXIT //IF any shipments are capable of resending, then show button
	END IF
	
NEXT
		

Return lb_Show
end function

private function boolean wf_allowresend (long al_shipmentid);Boolean	lb_AllowResend = False
n_cst_beo_company		lnv_company
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch 	lnv_Dispatch

lnv_Dispatch = Create n_cst_bso_Dispatch
lnv_Shipment = Create n_cst_beo_Shipment

IF al_Shipmentid > 0 THEN

	lnv_Dispatch.of_RetrieveShipment(al_shipmentid)
	lnv_Shipment.of_SetSource(lnv_Dispatch.of_GetShipmentCache())
	lnv_Shipment.of_SetSourceId(al_ShipmentId)	

	lb_AllowResend = lnv_Shipment.of_isBilled()
	
	IF lb_AllowResend THEN
		lnv_Shipment.of_GetBillToCompany( lnv_Company, TRUE)
		IF lnv_Company.of_HasSource() THEN
			lb_AllowResend = lnv_Company.of_EmailInvoices()
		END IF
	END IF

END IF

Destroy lnv_Shipment
Destroy lnv_Company 
Destroy lnv_Dispatch 


Return lb_AllowResend
end function

private function string wf_gettemplatepath ();Return is_TemplatePath + is_FileName
end function

private function integer wf_processresend (long ala_shipmentids[]);/***************************************************************************************
NAME: 		wf_ProcessResend		

ACCESS:		Private
		
ARGUMENTS:	(long ala_Shipmentids[])

RETURNS:		Integer
	
DESCRIPTION: 
				Offload resend processing to another thread.
				
				The thread doing the work will notifiy the progess window when done
				via the threadcomm object.
				
				Return 1 - thread spawned successfully
				Return -1 - error getting thread
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/24/06 - Maury
				1/17/07 Maury - Thread implementation
***************************************************************************************/
Integer							li_Return = 1
n_cst_threadjob			   lnv_invoiceJob
n_cst_thread_resendinvoice lnv_resendThread
n_cst_threadManager 			lnv_ThreadManager
n_cst_threadComm				lnv_ThreadComm

w_Pop_Progress					lw_Progress

lnv_threadManager = gnv_App.of_GetThreadManager()

//initailize thread job
lnv_InvoiceJob.ila_SourceIds = ala_ShipmentIds
				
//Get a thread and execute the resend invoice job 				
IF lnv_threadManager.of_GetThread( lnv_resendThread, "n_cst_thread_resendinvoice" ) = 1 THEN
	IF IsValid( lnv_resendThread ) THEN
		
		Open(lw_Progress, gnv_App.of_GetFrame())
		lw_Progress.wf_SetTitle ( "Invoice Resend" )
		lw_Progress.wf_SetText("Resending Invoices...")
		lw_Progress.wf_SetStatus("Resending invoices as a background process.~r~nYou will be notified when the resend process is done.")
		lw_Progress.wf_ShowBar(False)
		lw_Progress.wf_SetMinimizeable(True)

		//create and initialize a communication broker object
		lnv_Threadcomm = CREATE n_cst_ThreadComm
		lnv_Threadcomm.of_SetRequestor( lw_Progress )
		lnv_resendThread.of_SetThreadComm(lnv_ThreadComm) 
		
		//Do work on thread
		//Must Post thread functions to execute the method asynchronously
		lnv_resendThread.Post of_ExecuteJob( lnv_invoiceJob )
		
	END IF
ELSE
	li_Return = -1 //could not get thread for job
	Messagebox("Resend Invoice", "Error getting a thread for the invoice resend job.")
END IF
	

Return li_Return
end function

public function integer wf_resendmode (boolean ab_resendmode);IF ab_ResendMode THEN
	gb_2.Visible = FALSE
	ddlb_templatelist.Visible = FALSE
	cb_more.Visible = FALSE
	cb_ok.Text = "Send"
ELSE
	gb_2.Visible = TRUE
	ddlb_templatelist.Visible = TRUE
	cb_more.Visible = TRUE
	cb_ok.Text = "OK"
	cbx_Resend.Checked = FALSE // OK/Send button fuctionality is based on this property
END IF

Return 1
end function

protected function integer wf_resendauthorized ();/***************************************************************************************
NAME: 		wf_ResendAuthorized		

ACCESS:		Public
		
ARGUMENTS:	()

RETURNS:		Integer
	
DESCRIPTION: 
				Authorized Shipmetments to only allow resend of invoices that are set up properly
				
				Retrun 1 Success (All Shipments got sent)
				Return -1 Faliure (Not ALL shipments got sent)
				Return 0 User Canceled / No Authorized Shipments to send
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 1/24/06 - Maury
***************************************************************************************/


Integer	li_Return
Integer	li_Resend
Long		ll_NumShipments, i
Long		lla_ResendAuthorized[]
Long		lla_ResendUnauthorized[]
String	ls_ErrMsg
String	ls_Message
Boolean	lb_Authorized

ll_NumShipments = UpperBound(ila_ShipmentId[])

IF ll_NumShipments > 0 THEN
	li_Return = 1
ELSE
	ls_ErrMsg = "No Shipments to Resend."
	li_Return = -1
END IF

IF li_Return = 1 THEN
	FOR i = 1 TO ll_NumShipments
		lb_Authorized = wf_AllowResend(ila_ShipmentId[i])
		IF lb_Authorized THEN
			lla_ResendAuthorized[UpperBound(lla_ResendAuthorized[])+1] = ila_ShipmentId[i]
		ELSE
			lla_ResendUnauthorized[UpperBound(lla_ResendUnAuthorized[])+1] = ila_ShipmentId[i]
		END IF
	NEXT
END IF
 
IF li_Return = 1 THEN
	//Inform user some shipments will not be sent
	IF UpperBound(lla_ResendUnAuthorized) > 0 THEN
		ls_Message = "The following shipment invoice(s) will not be sent because the bill to company is not properly set up for email invoice:~r~n"
		ll_NumShipments = UpperBound(lla_ResendUnAuthorized)
		FOR i = 1 TO ll_NumShipments
			ls_Message += String(lla_ResendUnAuthorized[i]) + "~t~r~n"
		NEXT
		IF UpperBound(lla_ResendAuthorized) > 0 THEN
			ls_Message += "~r~nWould you like to send the other shipments anyway?"
			IF MessageBox("Resend Invoices", ls_Message, Question!, YesNo!, 1) = 2 THEN
				li_Return = 0
			END IF
		ELSE
			MessageBox("Resend Invoices", ls_Message)
			li_Return = 0 //Dont Send
		END IF
	END IF
END IF


IF li_Return = 1 THEN
	IF UpperBound(lla_ResendAuthorized) > 0  THEN
		IF wf_ProcessResend(lla_ResendAuthorized[]) <> 1 THEN
			li_Return = -1
		END IF
	END IF
END IF

IF Not isNull(ls_ErrMsg) AND Len(ls_ErrMsg) > 0 THEN
	MessageBox("Error Reseding Invoice", ls_ErrMsg )
END IF


Return li_Return
end function

on w_documentselection.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.sle_1=create sle_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_custom=create rb_custom
this.rb_system=create rb_system
this.ddlb_templatelist=create ddlb_templatelist
this.cbx_seperatedelivery=create cbx_seperatedelivery
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_more=create cb_more
this.ddlb_documenttype=create ddlb_documenttype
this.cbx_resend=create cbx_resend
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.rb_custom
this.Control[iCurrent+6]=this.rb_system
this.Control[iCurrent+7]=this.ddlb_templatelist
this.Control[iCurrent+8]=this.cbx_seperatedelivery
this.Control[iCurrent+9]=this.cb_ok
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_more
this.Control[iCurrent+12]=this.ddlb_documenttype
this.Control[iCurrent+13]=this.cbx_resend
end on

on w_documentselection.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.sle_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_custom)
destroy(this.rb_system)
destroy(this.ddlb_templatelist)
destroy(this.cbx_seperatedelivery)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_more)
destroy(this.ddlb_documenttype)
destroy(this.cbx_resend)
end on

event open;call super::open;n_cst_msg	lnv_Msg

lnv_Msg = message.powerobjectparm
this.wf_getpassedparms(lnv_msg)
ib_disableclosequery = TRUE
THIS.of_SetBase ( TRUE )
inv_Base.of_Center( )

this.Post event ue_Open()



end event

event pfc_default;
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
w_BillQuickPrint	lw_Print

CHOOSE CASE is_Document
		
	CASE n_cst_Constants.cs_Document_DeliveryReceipt
		
		IF rb_system.checked THEN 
			lstr_Parm.is_Label = "IDS"
			lstr_Parm.ia_Value = ila_shipmentid
			
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "TYPE"
			lstr_Parm.ia_Value = "DELIVERY_RECEIPT!"
			
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			OpenWithParm ( lw_Print, lnv_Msg )
			
		ELSE
			IF len ( is_FileName ) = 0 THEN
				ddlb_templatelist.SelectItem (1)
			END IF
			
			this.wf_ProcessDocument()
		
		END IF
		
	CASE n_cst_Constants.cs_Document_Invoice
		
		IF rb_system.checked THEN 
			//new code
			Long	lla_Ids[]
			s_Anys	lstr_Open
			w_bill_preview	lw_Bill_Preview
			String	ls_Request
			
//			ls_Request = "DELIVERY_RECEIPT!"
			ls_Request = "INVOICE!"	
			lstr_open.anys[1] = ls_request
			lstr_open.anys[2] = ila_shipmentid
			openwithparm(lw_bill_preview, lstr_open)
		ELSEIF cbx_Resend.Checked THEN
			This.wf_ResendAuthorized()
		ELSE			
			THIS.wf_PrintInvoices()			
		END IF
		
			
	CASE n_cst_Constants.cs_Document_Quote, "Export File", n_cst_Constants.cs_Document_RateConfirmation
	
		IF len ( is_FileName ) = 0 THEN
				ddlb_templatelist.SelectItem (1)
		END IF
			
		this.wf_ProcessDocument()
			

END CHOOSE

end event

event pfc_cancel;call super::pfc_cancel;Close ( THIS ) 
end event

type cb_help from w_response`cb_help within w_documentselection
end type

type dw_1 from u_dw within w_documentselection
event ue_hidefooter ( )
integer x = 32
integer y = 772
integer width = 3246
integer height = 988
integer taborder = 110
boolean bringtotop = true
end type

event ue_hidefooter();//Hide Buttons
This.Modify("DataWindow.Footer.Height=0")
end event

type sle_1 from singlelineedit within w_documentselection
integer x = 32
integer y = 692
integer width = 1440
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Data source for the document:"
boolean border = false
boolean autohscroll = false
end type

type gb_2 from groupbox within w_documentselection
integer x = 50
integer y = 412
integer width = 1810
integer height = 228
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Template"
end type

type gb_1 from groupbox within w_documentselection
integer x = 50
integer y = 16
integer width = 1810
integer height = 372
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select Type"
end type

type rb_custom from radiobutton within w_documentselection
integer x = 123
integer y = 156
integer width = 498
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Custom Template"
end type

event clicked;ddlb_templatelist.enabled=TRUE
cb_more.enabled=TRUE
cbx_seperatedelivery.enabled=NOT ib_ispsrdocument
IF NOT cbx_seperatedelivery.enabled THEN
	cbx_seperatedelivery.Checked = FALSE
END IF

IF ddlb_documenttype.Text = n_cst_Constants.cs_Document_Invoice THEN
	cbx_resend.Visible = wf_ShowResendButton()
END IF
end event

type rb_system from radiobutton within w_documentselection
integer x = 123
integer y = 76
integer width = 507
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "System Generated"
end type

event clicked;ddlb_templatelist.enabled=FALSE
cb_more.enabled=FALSE
cbx_seperatedelivery.enabled=FALSE
cbx_seperatedelivery.Checked=FALSE
cbx_resend.Visible = False
wf_ResendMode(False)
end event

type ddlb_templatelist from dropdownlistbox within w_documentselection
integer x = 123
integer y = 504
integer width = 1029
integer height = 468
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;is_FileName = this.text(index)

If Trim( Upper( Right (is_FileName, 3) ) ) = "PSR" Then 
	ib_IsPSRDocument = TRUE
	cbx_seperatedelivery.Enabled = FALSE
Else
	ib_IsPSRDocument = FALSE
	cbx_seperatedelivery.Enabled = TRUE 
	
End IF


end event

type cbx_seperatedelivery from checkbox within w_documentselection
integer x = 123
integer y = 300
integer width = 1275
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Separate delivery receipts for multiple event shipments."
end type

type cb_ok from u_cbok within w_documentselection
integer x = 3040
integer y = 44
integer width = 233
integer taborder = 90
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_cancel from u_cbcancel within w_documentselection
integer x = 3040
integer y = 172
integer width = 233
integer taborder = 100
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "Close"
end type

type cb_more from commandbutton within w_documentselection
integer x = 1568
integer y = 504
integer width = 233
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&More"
end type

event clicked;string	ls_Drive, &
			ls_DirPath, &
			ls_FileName, &
			ls_Ext, &
			ls_type, &
			ls_InitDir
			
			
n_cst_FileSrvwin32 	lnv_FileSrv
lnv_FileSrv = CREATE n_cst_FileSrvwin32

n_cst_setting_templatespathfolder lnv_folder
lnv_folder = CREATE n_cst_setting_templatespathfolder
ls_InitDir = lnv_folder.of_GetValue()
DESTROY ( lnv_folder )

if pos(upper(is_templatepath), "EXPORT", 1) > 0 THEN
	
	ls_type = "Excel Template ( *.xls), *.xls,all files (*.*), *.*"
	
else
	
	ls_type = "Word Document (*.doc), *.doc,Word Template (*.dot), *.dot," + &
				"PowerSoft Report (*.psr),*.psr,Excel Template ( *.xls), *.xls,all files (*.*), *.*"
	
end if


IF GetFileOpenName("Select File", is_templatepath, is_filename, "doc", ls_type ,ls_InitDir ) = 1 THEN
	
	lnv_FileSrv.of_ParsePath(is_templatepath, ls_Drive, ls_DirPath, ls_FileName, ls_Ext)
	is_TemplatePath = ls_Drive + ls_DirPath
	Parent.wf_LoadTemplateList()
	ddlb_templatelist.SelectItem ( ls_filename, 1 )
	
	is_FileName =  ls_filename + "." + ls_Ext
	
	If Upper(ls_Ext) = "PSR" Then 
		ib_IsPSRDocument = TRUE
		cbx_seperatedelivery.Enabled = FALSE
	ELSE
		ib_IsPSRDocument = FALSE
		cbx_seperatedelivery.Enabled = TRUE
	END IF

END IF

destroy lnv_FileSrv
end event

type ddlb_documenttype from dropdownlistbox within w_documentselection
integer x = 869
integer y = 148
integer width = 933
integer height = 432
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string	ls_Template, &
			ls_Drive, &
			ls_DirPath, &
			ls_FileName, &
			ls_Ext

n_cst_FileSrvwin32	lnv_FileSrv

//is_TemplatePath
Parent.SetRedraw(FALSE)
cbx_seperatedelivery.checked=FALSE
cbx_seperatedelivery.visible=FALSE
cbx_resend.Visible = FALSE
wf_ResendMode(False)

is_Document = this.text(index)
//ddlb_templatelist.Reset ( )
CHOOSE CASE this.text(index)
		
	CASE n_cst_Constants.cs_Document_DeliveryReceipt
		
//		cbx_seperatedelivery.checked=TRUE
		cbx_seperatedelivery.visible=TRUE
		
		IF len ( is_DeliveryTemplate ) = 0 THEN
			IF Parent.wf_UseCustomTemplate(45) THEN
				rb_custom.checked=TRUE
				rb_system.checked=FALSE
				is_DeliveryTemplate = Parent.wf_GetCustomTemplate(46)
				
				ddlb_templatelist.enabled=TRUE
				cb_more.enabled=TRUE
						
			ELSE
				rb_custom.checked=FALSE
				rb_system.checked=TRUE		
				ddlb_templatelist.enabled=FALSE
				cb_more.enabled=FALSE
					
			END IF
			
		END IF
		
		Parent.wf_SetTemplatePath(is_DeliveryTemplate)
		
	CASE n_cst_Constants.cs_Document_Invoice
		Int	li_UseSetting
		Int	li_TemplateSetting
		IF UpperBound ( ila_individualinvoices ) > 0 THEN
			li_UseSetting = 37
			li_TemplateSetting = 38
		ELSEIF UpperBound ( ila_Manifestinvoices ) >0  THEN
			li_UseSetting = 237
			li_TemplateSetting = 238
		END IF
		
		
		
		
		IF len ( is_invoicetemplate ) = 0 THEN
			IF Parent.wf_UseCustomTemplate(li_UseSetting) THEN
				rb_custom.checked=TRUE
				rb_system.checked=FALSE
				is_invoicetemplate = Parent.wf_GetCustomTemplate(li_TemplateSetting)
				IF NOT fileexists(is_invoicetemplate) then
					ls_Template = Parent.wf_GetCustomTemplate(67)
					IF fileexists ( ls_template + is_invoicetemplate) then
						IF len(is_invoicetemplate) = 0 THEN
							is_invoicetemplate = ls_template + "INVOICE\"
						ELSE
							is_invoicetemplate = ls_template + is_invoicetemplate
						END IF
					ELSE
						is_invoicetemplate = ls_Template + "INVOICE\"
					END IF
				END IF
				
				ddlb_templatelist.enabled=TRUE
				cb_more.enabled=TRUE
		
						
			ELSE
				rb_custom.checked=FALSE
				rb_system.checked=TRUE		
				ddlb_templatelist.enabled=FALSE
				cb_more.enabled=FALSE
					
			END IF
			
		END IF
		
		Parent.wf_SetTemplatePath(is_invoicetemplate)
		
		//Resend Button
		IF rb_custom.checked THEN
			cbx_resend.Visible = wf_ShowResendButton( )
		END IF
		
	CASE n_cst_Constants.cs_Document_Quote
		
		rb_custom.checked=TRUE
		rb_system.checked=FALSE
		is_ExportTemplate = Parent.wf_GetCustomTemplate(67)
		
		is_ExportTemplate += "quote\"
		
		ddlb_templatelist.enabled=TRUE
		cb_more.enabled=TRUE
		
		Parent.wf_SetTemplatePath(is_ExportTemplate)
			
	CASE n_cst_Constants.cs_Document_rateconfirmation
		
		rb_custom.checked=TRUE
		rb_system.checked=FALSE
		is_RateConfTemplate = Parent.wf_GetCustomTemplate(44)
		
//		is_ExportTemplate = Parent.wf_GetCustomTemplate(67)
//		is_ExportTemplate += "rateconf\"
		
		ddlb_templatelist.enabled=TRUE
		cb_more.enabled=TRUE
		
//		Parent.wf_SetTemplatePath(is_ExportTemplate)
		Parent.wf_SetTemplatePath(is_RateConfTemplate)
		
	CASE "Export File"
		
		rb_custom.checked=TRUE
		rb_system.checked=FALSE
		is_ExportTemplate = Parent.wf_GetCustomTemplate(67)
		
		is_ExportTemplate += "Exports\"
		
		ddlb_templatelist.enabled=TRUE
		cb_more.enabled=TRUE
		
		Parent.wf_SetTemplatePath(is_ExportTemplate)
			
		
END CHOOSE

Parent.SetRedraw(TRUE)

end event

type cbx_resend from checkbox within w_documentselection
boolean visible = false
integer x = 864
integer y = 240
integer width = 535
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Resend Invoices"
end type

event clicked;wf_ResendMode(This.Checked)


end event

