$PBExportHeader$u_cst_shipment_notification.sru
forward
global type u_cst_shipment_notification from u_base
end type
type gb_shipstatus from groupbox within u_cst_shipment_notification
end type
type gb_contacts from groupbox within u_cst_shipment_notification
end type
type gb_1 from groupbox within u_cst_shipment_notification
end type
type dw_available from u_dw_companycontacts_list within u_cst_shipment_notification
end type
type ddlb_newaddress from u_ddlb within u_cst_shipment_notification
end type
type cb_1 from commandbutton within u_cst_shipment_notification
end type
type st_3 from statictext within u_cst_shipment_notification
end type
type cb_4 from commandbutton within u_cst_shipment_notification
end type
type uo_template from u_cst_fileselection within u_cst_shipment_notification
end type
type gb_shipevent from groupbox within u_cst_shipment_notification
end type
type dw_eventlist from u_dw_eventlist within u_cst_shipment_notification
end type
type rb_event from u_rb within u_cst_shipment_notification
end type
type rb_shipment from u_rb within u_cst_shipment_notification
end type
type dw_companies from u_dw_companiesbycontacts within u_cst_shipment_notification
end type
type cb_3 from commandbutton within u_cst_shipment_notification
end type
type cb_5 from commandbutton within u_cst_shipment_notification
end type
type dw_recipients from u_dw_notificationrecipients within u_cst_shipment_notification
end type
type cb_clear_remove from commandbutton within u_cst_shipment_notification
end type
type cb_8 from commandbutton within u_cst_shipment_notification
end type
type cb_addressbook from commandbutton within u_cst_shipment_notification
end type
type sle_address from singlelineedit within u_cst_shipment_notification
end type
type cb_6 from commandbutton within u_cst_shipment_notification
end type
type st_shipstatus from statictext within u_cst_shipment_notification
end type
type cb_sendnow from commandbutton within u_cst_shipment_notification
end type
type st_emailaddress from statictext within u_cst_shipment_notification
end type
end forward

global type u_cst_shipment_notification from u_base
integer width = 2304
integer height = 2084
long backcolor = 12632256
event type integer ue_templatechanged ( string as_template )
event type n_cst_bso_dispatch ue_getdispatchobject ( )
event ue_sendnow ( )
event type integer ue_resize ( )
gb_shipstatus gb_shipstatus
gb_contacts gb_contacts
gb_1 gb_1
dw_available dw_available
ddlb_newaddress ddlb_newaddress
cb_1 cb_1
st_3 st_3
cb_4 cb_4
uo_template uo_template
gb_shipevent gb_shipevent
dw_eventlist dw_eventlist
rb_event rb_event
rb_shipment rb_shipment
dw_companies dw_companies
cb_3 cb_3
cb_5 cb_5
dw_recipients dw_recipients
cb_clear_remove cb_clear_remove
cb_8 cb_8
cb_addressbook cb_addressbook
sle_address sle_address
cb_6 cb_6
st_shipstatus st_shipstatus
cb_sendnow cb_sendnow
st_emailaddress st_emailaddress
end type
global u_cst_shipment_notification u_cst_shipment_notification

type variables
Long	il_ShipmentID
Long	ila_Companyids[]
n_cst_beo_Shipment	inva_Shipment[]
n_cst_beo_Event		inv_Event
Boolean	ib_CheckClicked  = FALSE
Boolean   ib_ReturnEmail     = FALSE
Boolean   ib_EventContacts = FALSE

Private:
Long	il_X_Offset = 1
Long	il_Y_Offset = 1
Long	il_Row
end variables

forward prototypes
public function integer of_setshipmentid (long al_shipmentid)
public function integer of_retrievecontacts ()
public function integer of_addrecipient (long al_row)
public function integer of_addnew ()
public function integer of_details (long al_row)
public function integer of_sendnotification ()
private function integer of_initializetypeahead ()
public function integer of_addall ()
public function integer of_preloadrecipients ()
public function integer of_settemplate (string as_template)
public function integer of_savecontactlist ()
private function integer of_updatecontactlists ()
private function integer of_checkrecipients (string as_column, long ala_ids[])
public subroutine of_setshipment (n_cst_beo_shipment anv_shipment)
private function long of_getshipment (ref n_cst_beo_Shipment anva_Shipment[])
public function boolean of_validaddress (readonly string as_email)
private function integer of_setrecipientschecked (readonly boolean ab_checked)
public function integer of_getalladdresses (ref string asa_address[])
public function integer of_loadcompanies (readonly long ala_shipment)
public function integer of_companycheck ()
public subroutine of_setshipment (n_cst_beo_shipment anva_shipment[])
public function integer of_getallcontacts (ref long ala_Contact[])
public subroutine of_showshipstatus (readonly boolean ab_show)
public subroutine of_setreturnemail (readonly boolean ab_ReturnEMail)
public function integer of_setallcompanychecks ()
public function integer of_adhocaddress (readonly string asa_address[])
public function integer of_loadevents ()
public function integer of_initialize ()
public function integer of_addcompanytoevents (readonly long al_companyid, ref n_cst_beo_event anv_event)
public function integer of_removecompanyfromevents (ref long al_companyid, ref n_cst_beo_event anv_event)
public function integer of_viewevent (readonly boolean ab_show)
public function long of_getxoffset ()
public function long of_getyoffset ()
public function integer of_seteventid (readonly long al_eventid)
public function integer of_getcontactsforallevents (ref long ala_contactid[])
private function integer of_companycheck (readonly long al_coid)
public function integer of_setcontextshipment ()
public function integer of_setcontextevent ()
private function integer of_addeventsfromdw ()
end prototypes

public function integer of_setshipmentid (long al_shipmentid);il_ShipmentID = al_ShipmentID

RETURN 1
end function

public function integer of_retrievecontacts ();
//RDT 3-12-03 lnv_Shipment changed to inva_Shipment[li_Count]
Long	ll_BillTo
Long	lla_Ids[]
Long	lla_AllCompanies[]

Integer 	li_Count, & 
			li_upper

//n_cst_beo_Shipment	lnv_Shipment					//RDT 3-12-03

//lnv_Shipment = THIS.of_GetShipment ( )			//RDT 3-12-03

//IF IsValid ( lnv_Shipment )THEN					//RDT 3-12-03
li_Upper = UpperBound( inva_shipment[]	)			//RDT 3-12-03

If li_Upper > 0 Then 									//RDT 3-12-03

	For li_Count = 1 to li_Upper 						//RDT 3-12-03
		inva_Shipment[li_Count].of_getreferencedcompanies ( lla_AllCompanies ) 		//RDT 3-12-03
		
		ll_BillTo = inva_Shipment[li_Count].of_GEtBillto ( )
		IF ll_BillTo > 0 THEN
			dw_available.of_SetCompanyID ( ll_BillTo )
			dw_Recipients.of_SetCompanyID ( ll_BillTo )
			lla_Ids [ 1 ] = ll_BillTo
		END IF
	Next	
	
END IF

ila_companyids[] = lla_AllCompanies

IF UpperBound( lla_AllCompanies ) > 0 THEN
	dw_available.of_Retrieve ( lla_AllCompanies )
END IF

//DESTROY ( lnv_Shipment )

RETURN 1
end function

public function integer of_addrecipient (long al_row);// I don't think this is used.
Long	ll_Find
String	ls_Find

IF al_Row > 0 THEN
	
	ls_Find = dw_available.GetItemString ( al_Row , "cf_name" ) 
	IF dw_recipients.find ( "cf_name = '" + ls_Find +"'" , 1 , 9999 ) = 0  THEN
		dw_available.RowsCopy ( al_Row , al_Row , PRIMARY! , dw_recipients , 999 ,Primary! )
	END IF
	
	THIS.of_UpdateContactLists ( )
END IF

RETURN 1
end function

public function integer of_addnew ();Int	li_Return = 1
Long	ll_ID
String	ls_Text
String	ls_Fn
String	ls_Find
string	lsa_Result[]

n_cst_String	lnv_String

n_cst_bso_notification_Manager	lnv_Note
lnv_Note = CREATE n_cst_bso_Notification_Manager

DataStore	lds_Temp
lds_Temp = CREATE DataStore
lds_Temp.DataObject = "d_contact_info"

lds_Temp.SetTransObject ( sqlca )

ls_Text = Trim ( ddlb_newaddress.Text )

lnv_String.of_ParseToArray ( ls_Text , "@" , lsa_Result )

IF UpperBound ( lsa_Result ) > 1 THEN
	ls_fn = lsa_Result [ 1 ] 
	IF len ( ls_Fn ) > 15 THEN
		ls_Fn = Left ( ls_Fn , 15 ) 
	END IF
ELSE
	Messagebox ("New Address" , "Please make sure the email address is formatted correctly." )
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF len ( ls_Text ) > 0 THEN
		ll_ID = lnv_Note.of_GetIdFromEmailAddress ( ls_Text )
		IF ll_ID = 0 THEN			
			ll_ID = lnv_Note.of_NewContact ( ls_Fn , "" , "" , ls_Text , 0 )
		END IF
		
		IF ll_ID > 0 THEN
			IF lds_Temp.Retrieve ( ll_ID ) = 1 THEN
				ls_Find = lds_Temp.GetItemString ( 1 , "ct_emailaddress" ) 
				IF dw_recipients.find ( "ct_emailaddress = '" + ls_Find +"'" , 1 , 9999 ) = 0  THEN
					lds_Temp.RowsCopy ( 1 , 1 , PRIMARY! , dw_recipients , 999 ,Primary! )
				END IF
			END IF
		END IF
		
	END IF
END IF

DESTROY ( lnv_Note ) 
DESTROY ( lds_Temp ) 

THIS.of_InitializeTypeAhead ( )

ddlb_newaddress.Text = ""

THIS.of_UpdateContactLists ( )

RETURN li_Return
end function

public function integer of_details (long al_row);long	ll_ID
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm



IF al_Row > 0 THEN
	
	ll_ID = dw_recipients.getItemNumber ( al_Row, "id" )
	
END IF

IF ll_ID > 0 THEN
	lstr_Parm.is_Label = "CONTACTID"
	lstr_Parm.ia_Value = ll_ID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	OpenWithParm ( w_CompanyContact_Detail , lnv_Msg )
	
	dw_recipients.of_Refresh ( )
END IF

RETURN 1
end function

public function integer of_sendnotification ();// RDT 3-12-03 
Int		li_Return = 1
Long		lla_ContactIDs[]
Boolean	lb_IgnoreSystemSetting = TRUE
String	ls_Error
String	ls_OldType

Integer 	li_Count, &
			li_Upper


n_cst_bso_Notification_Manager	lnv_NoteManager
pt_n_cst_beo							lnv_Shipment

lnv_NoteManager = CREATE n_cst_Bso_Notification_Manager

li_Upper = UpperBound( inva_shipment )								// RDT 3-12-03 
For li_Count = 1 to li_Upper											// RDT 3-12-03 
	//lnv_Shipment = THIS.of_GEtShipment ( ) 						// RDT 3-12-03 
	lnv_Shipment = inva_shipment[ li_Count ]						// RDT 3-12-03 
	
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
	
	IF li_Return = 1 THEN
		IF NOT lnv_Shipment.of_HasSource ( ) THEN
			li_Return = -1 
		END IF
	END IF
	
	IF li_Return = 1 THEN
		
		ls_OldType = lnv_Shipment.of_GetDocumentType ( )
		lnv_Shipment.of_SetDocumentType ( appeon_constant.cs_loadconfirmation )
	
	
		
		IF lnv_Shipment.Dynamic of_GetShipmentContacts ( lla_ContactIDs  ) > 0  THEN					
			IF lnv_NoteManager.of_ProcessNotificationRequest ( lnv_Shipment , lb_IgnoreSystemSetting, ls_Error ) <> 1 THEN
				MessageBox ( "Shipment Notification" , ls_Error )
			END IF
		ELSE 
			
			MessageBox ( "Shipment Notification" , "No contacts have been selected for shipment notification." )
		
		END IF
		
		lnv_Shipment.of_SetDocumentType ( ls_OldType )
				
	END IF

Next																			// RDT 3-12-03 

//DESTROY ( lnv_Shipment )
DESTROY ( lnv_NoteManager )

RETURN li_Return
end function

private function integer of_initializetypeahead ();Long	ll_Count
Long	i

dataStore	lds_Contacts
lds_Contacts = CREATE dataStore
lds_Contacts.dataobject = "d_CompanyContacts_list"
lds_Contacts.SetTransObject ( SQLCA )
																								 
lds_Contacts.object.datawindow.table.select = "SELECT * FROM contacts"

lds_Contacts.Retrieve ( 0 ) // this just satisfies the need for retrieval args. its not used

lds_Contacts.SetFilter ( "isNull (ct_co) AND ct_status = '" &
									+ appeon_constant.cs_Status_active +"'" )
lds_Contacts.Filter ( ) 

ll_Count = lds_Contacts.RowCount ( )

ddlb_newaddress.Reset ( )

FOR i = 1 TO ll_Count
	ddlb_newaddress.AddItem ( lds_Contacts.getItemString ( i , "ct_emailaddress" ) )
NEXT

DESTROY ( lds_Contacts )

RETURN 1




end function

public function integer of_addall ();Long	ll_RowCount
Long	ll_i

ll_RowCount = dw_available.RowCount ( )
FOR ll_i = 1 TO ll_RowCount 
	THIS.of_AddRecipient ( ll_i )
NEXT

RETURN 1

end function

public function integer of_preloadrecipients ();//RDT 3-12-03 all lnv_Shipment changed to  inva_shipment[] 
Int		li_Return = 1
Long		lla_Contactids[]
Long		lla_EmptyArray[]
Long		lla_HoldContacts[]
Long		lla_EventContacts[]
Long		lla_AccNoteContacts[]
Long		lla_AccAuthContacts[]
Long		lla_LFDContacts[]
Long		lla_ShipmentContacts[]
Long		ll_RowCount

Integer 	li_Count, &
			li_Upper

dw_recipients.SetRedraw ( FALSE )

n_cst_AnyArraySrv	lnv_ArraySrv

////// RDT 3-12-03 - Get all companies on shipment- STart
	n_cst_ContactManager	lnv_CtManager
	lnv_CtManager = CREATE n_cst_ContactManager
	
	n_cst_beo_Company	lnv_Co
	lnv_Co = CREATE n_cst_beo_Company
	
	lnv_Co.of_SetUseCache ( TRUE )

	Long ll_i, ll_ID
	ll_RowCount = UpperBound( ila_Companyids[] )

	For ll_i = 1 to ll_RowCount
		lnv_Co.of_SetSourceID ( ila_Companyids[ll_i] ) 
		IF lnv_Co.of_HasSource( ) THEN
			lla_HoldContacts = lla_EmptyArray
			lnv_CtManager.of_GetAllContactsForCompany ( lnv_Co , lla_HoldContacts )
			lnv_ArraySrv.of_AppendLong ( lla_ContactIds , lla_HoldContacts ) 
		ELSE
			messageBox ( "Company Add" , "Error resolving company" ) 
		END IF
	Next
	
	Destroy lnv_CtManager 
	Destroy lnv_Co 
////// RDT 3-12-03 - End 


//n_cst_beo_Shipment lnv_Shipment 							//RDT 3-12-03
//lnv_Shipment = THIS.of_GetShipment ( ) 					//RDT 3-12-03

//IF NOT IsValid( lnv_shipment )  THEN						// RDT 3-12-03 
li_Upper = UpperBound( inva_shipment[] ) 					// RDT 3-12-03 
IF li_Upper < 1  THEN											// RDT 3-12-03 
	li_Return = -1
END IF

IF li_Return = 1 THEN

	For li_Count = 1 to li_Upper 								// RDT 3-12-03 
		IF NOT inva_shipment[ li_Count ].of_HasSource ( ) THEN
			li_Return = -1
		END IF														// RDT 3-12-03 
	Next
END IF


IF li_Return = 1 THEN
	For li_Count = 1 to li_Upper								//RDT 3-12-03 

		// RDT 6-01-03 -Start-
		//inva_shipment[ li_Count ].of_GetEventContacts ( lla_EventContacts )
		// get contacts from all events 
		//lla_EventContacts[] = lla_EmptyArray[]
		if This.of_GetContactsForAllEvents( lla_EventContacts[] ) > 0 then 
			lnv_ArraySrv.of_AppendLong ( lla_ContactIds , lla_EventContacts  ) 
		end if
		// RDT 6-01-03 -end-

		inva_shipment[ li_Count ].of_GetAccnoteContacts ( lla_AccNoteContacts )
		inva_shipment[ li_Count ].of_GetAccAuthContacts ( lla_AccAuthContacts )
		inva_shipment[ li_Count ].of_GetLastFreeDateContacts ( lla_LFDContacts )
		inva_shipment[ li_Count ].of_GetShipmentContacts ( lla_ShipmentContacts )

	//END IF																// RDT 3-12-03 
	//IF li_Return = 1 THEN											// RDT 3-12-03 
	
		lnv_ArraySrv.of_AppendLong ( lla_ContactIds , lla_EventContacts  ) 
		lnv_ArraySrv.of_AppendLong ( lla_ContactIds , lla_AccNoteContacts ) 
		lnv_ArraySrv.of_AppendLong ( lla_ContactIds , lla_AccAuthContacts ) 
		lnv_ArraySrv.of_AppendLong ( lla_ContactIds , lla_LFDContacts )  
		lnv_ArraySrv.of_AppendLong ( lla_ContactIds , lla_ShipmentContacts ) 		
		
		lnv_ArraySrv.of_GetShrinked ( lla_ContactIds , TRUE , TRUE )
		
		ll_RowCount = dw_recipients.of_Refresh ( lla_ContactIds )
	
		IF ll_RowCount <= 0 THEN
			li_Return = -1
		END IF

	Next																// RDT 3-12-03 
END IF

IF li_Return = 1 THEN	

	THIS.of_CheckRecipients ( "ct_NotifyonEvent"  , lla_EventContacts )
	THIS.of_CheckRecipients ( "ct_NotifyonAccNote" , lla_AccNoteContacts )
	THIS.of_CheckRecipients ( "ct_NotifyonAccAuth" , lla_AccAuthContacts )
	THIS.of_CheckRecipients ( "ct_NotifyonShipment"  , lla_ShipmentContacts )
	THIS.of_CheckRecipients ( "ct_NotifyonLFD", lla_LFDContacts )	
END IF

dw_recipients.of_FilterList (  ) 

//IF ll_RowCount > 0 THEN
//	dw_available.SetRow ( 1 ) 
//	dw_available.Post Event rowFocusChanged ( 1 ) 
//END IF

dw_recipients.SetRedraw ( TRUE )

RETURN li_Return
end function

public function integer of_settemplate (string as_template);//String	ls_Template
//String	lsa_Result[]
//
//n_cst_String	lnv_String
//
//IF lnv_String.of_ParseToArray ( as_template , "\", lsa_Result ) > 0 THEN
//	
//	ls_Template = lsa_Result [ UpperBound ( lsa_Result ) ]
//	sle_Template.Text = ls_Template
//	
//END IF
//RETURN 1

uo_template.Event ue_SetFileFromPath (as_template )
RETURN 1


end function

public function integer of_savecontactlist ();//  This is not called by anything.
Return 1

end function

private function integer of_updatecontactlists ();// RDT 3-12-03 changed to process shipment array

Int		li_Return = 1
Long		lla_Contacts[]
Integer	li_Count, &
			li_Upper
			
n_cst_beo_Shipment	lnv_Shipment

li_Upper = UpperBound( inva_shipment[] )

//dw_recipients.SetRedraw ( FALSE )

If li_Upper > 0 Then 
	For li_Count = 1 to li_Upper
	
		IF li_Return = 1 THEN
			// lnv_Shipment = THIS.of_GetShipment ( ) 						//RDT 3-12-03
			lnv_Shipment = inva_shipment[ li_Count ]	 						//RDT 3-12-03
			IF NOT isValid ( lnv_Shipment ) THEN
				li_Return = -1
			END IF
			
		END IF
		
		IF li_Return = 1 THEN
			IF NOT lnv_Shipment.of_HasSource ( ) THEN
				li_Return = -1
			END IF
		END IF
		
		IF li_Return = 1 THEN
//			dw_recipients.of_GetEventContacts ( lla_Contacts )				// RDT 6-09-03 
//			lnv_Shipment.of_SetEventContacts ( lla_Contacts )				// RDT 6-09-03 

			dw_recipients.of_GetAccNoteContacts ( lla_Contacts  )
			lnv_Shipment.of_SetAccNoteContacts ( lla_Contacts )
			
			dw_recipients.of_GetAccAuthContacts ( lla_Contacts )
			lnv_Shipment.of_SetAccAuthContacts ( lla_Contacts )
		
			dw_recipients.of_GetShipmentContacts ( lla_Contacts )
			lnv_Shipment.of_SetShipmentContacts ( lla_Contacts )
			
			dw_recipients.of_GetLastFreeDateContacts ( lla_Contacts )
			lnv_Shipment.of_SetLastFreeDateContacts ( lla_Contacts )
	
		END IF
		
	Next
	
END IF // li_Upper > 0 Then 
	
//dw_recipients.SetRedraw ( TRUE )

RETURN li_Return
	


end function

private function integer of_checkrecipients (string as_column, long ala_ids[]);
String	ls_Filter
Long		ll_RowCount
Long		ll_i
Int		li_Return = 1

n_cst_sql	lnv_Sql

dw_recipients.SetRedraw ( false )

dw_recipients.SetFilter ( "" ) 	
dw_recipients.Filter ( )			

IF li_Return = 1 THEN
	// first clear all the check boxes
	ll_RowCount = dw_recipients.RowCount ( ) 
	FOR ll_i = 1 TO ll_RowCount
		dw_recipients.SetItem ( ll_i , as_Column , 0 )
	NEXT
	
END IF


IF li_Return = 1 THEN
	
	IF UpperBound ( ala_Ids[] ) <= 0 THEN
	
		li_Return = -1	
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	// then set the correct ones
	ls_Filter = "ct_id " +  lnv_Sql.of_MakeInclause ( ala_Ids )
	dw_recipients.SetFilter ( ls_Filter )
	dw_recipients.Filter ( )
	ll_RowCount = dw_recipients.RowCount ( ) 
	
	FOR ll_i = 1 TO ll_RowCount
		dw_recipients.SetItem ( ll_i , as_Column , 1 )
	NEXT
	dw_recipients.SetFilter ( "" )
	dw_recipients.Filter ( )
	
END IF

dw_recipients.SetRedraw ( TRUE )

RETURN li_Return
end function

public subroutine of_setshipment (n_cst_beo_shipment anv_shipment);//  RDT 3-12-03 Commented section below and now calls new method with an array
////Long	ll_Companies []
//
//inva_shipment[1] = anv_Shipment 
//
//dw_companies.of_Retrieve ( inva_shipment[1] )
//
//dw_companies.of_GetallCompanies ( ila_companyids )
//
//THIS.Post of_PreLoadRecipients ( )
//
this.of_SetShipment( { anv_Shipment } )
end subroutine

private function long of_getshipment (ref n_cst_beo_Shipment anva_Shipment[]);// RDT 3-12-03 Returns the number of elements in the array and sets the argument to the instance. 
Long 	ll_Count

ll_Count = UpperBound( inva_shipment[] )

anva_Shipment[] = inva_shipment[]

RETURN 	ll_Count

end function

public function boolean of_validaddress (readonly string as_email);//  Looks for the following in the string

Boolean 	lb_Return = TRUE

String 	ls_Valid[]

Integer	li_Count, &
			li_ArrayCount = 0

Long		ll_result


li_ArrayCount ++
ls_valid[ li_ArrayCount ] = "@"

li_ArrayCount ++
ls_Valid[ li_ArrayCount ] = "."

For  li_count =  1 to li_ArrayCount 
	
	If lb_Return Then 
		ll_Result = POS( as_Email , ls_Valid[li_Count] ) 
		
		if ll_Result = 0 OR IsNull( ll_Result ) Then 
			lb_Return = FALSE
		end if
		
	End If
	
Next


Return lb_Return
end function

private function integer of_setrecipientschecked (readonly boolean ab_checked);//
/***************************************************************************************
NAME			: of_SetRecipientsChecked
ACCESS		: Private 
ARGUMENTS	: boolean	(True = marked as checked, False = Mark as UNchecked
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 

REVISION		: RDT 3-12-03
				: RDT 6-01-03 add or delete contacts from event
				: RDT 6-13-03 check for Role before adding checks to accauth
***************************************************************************************/
long 	ll_RowCount, &
		ll_i, &
		ll_Col_Count, &
		ll_col, &
		ll_StartColumn
		
String	ls_Column[], &
			ls_Role

ll_StartColumn = 1

IF ib_EventContacts Then 
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonevent"
Else
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonaccauth"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonaccnote"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonlfd"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonshipment"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "rowchecked"
	
End If

IF NOT ib_EventContacts Then 
	// RDT 6-13-03 -start 
	// Role column may contain more than one value
	n_cst_String	lnv_String
	ls_Role = UPPER ( dw_companies.GetItemString(dw_companies.GetRow(), "role") )
	
	IF lnv_String.of_CountOccurrences ( ls_Role, "BILLTO", TRUE ) > 0 Then 
		// Authorization Allowed
	Else
		// Authorization not Allowed. this is not a BillTo Company
		if ab_checked then 
			ll_StartColumn = 2
		end if
		
	End if
	// RDT 6-13-03 -end
End If

If ab_checked Then 
	// set all the check boxes to checked
	ll_RowCount = dw_recipients.RowCount ( ) 
	FOR ll_i = 1 TO ll_RowCount
		
		for ll_Col = ll_StartColumn to ll_Col_Count

			If dw_recipients.GetItemNumber( ll_i, "ct_co" ) > 0 then 

				if Len( TRim( dw_recipients.GetItemString( ll_i, "ct_EmailAddress" ) ) ) > 0 then 
					dw_recipients.SetItem ( ll_i , ls_Column[ll_col], 1 )
					
					If ls_Column[ll_col] = "ct_notifyonevent" Then 
						// RDT 6-01-03  get contact id and add to event
						inv_Event.of_AddContactId( dw_recipients.GetItemNumber( ll_i, 'ct_id') ) 
					End if			
					
				end if
				
			End If
			
		next

	NEXT
Else
	// set all the check boxes to NOT checked
	ll_RowCount = dw_recipients.RowCount ( ) 
	
	FOR ll_i = 1 TO ll_RowCount
		
		for ll_Col = ll_StartColumn to ll_Col_Count
			
			If dw_recipients.GetItemNumber( ll_i, "ct_co" ) > 0 then 
				dw_recipients.SetItem ( ll_i , ls_Column[ll_col], 0 )
				
				If ls_Column[ll_col] = "ct_notifyonevent" Then 
					// RDT 6-01-03 get contact id and Remove From Event
					inv_Event.of_RemoveContactId( dw_recipients.GetItemNumber( ll_i, 'ct_id')) 
				End If

			End If
			
		next
		
		
	NEXT
	
END IF

//This.Post of_UpdateContactLists ( )

Return 1


end function

public function integer of_getalladdresses (ref string asa_address[]);//
/***************************************************************************************
NAME			: of_GetAllAddresses
ACCESS		: Public 
ARGUMENTS	: String[]	Address array by ref
RETURNS		: integer	(Number of addresses
DESCRIPTION	: returns all email addresses in dw_recepients 

REVISION		: RDT 3-12-03
***************************************************************************************/
String 	ls_Address
Integer	li_Return
			
Long		ll_Count, &
			ll_RowCount
			
// remove filter
dw_recipients.Setfilter('')

ll_RowCount = dw_recipients.RowCount()

If ll_RowCount > 0 Then 

	For ll_Count = 1 to ll_RowCount
		
		If dw_Recipients.GetItemNumber( ll_Count, "RowChecked" ) = 1 Then 
			ls_Address = Trim ( dw_Recipients.GetItemString( ll_Count, "ct_emailaddress" ) )
			
			If  Len( ls_Address ) > 0 Then 
				li_Return ++
				asa_Address[ li_Return ] = ls_Address 
			End If
			
		End If
		
	Next

Else
	li_Return = 0		
End If

Return 	li_Return 
end function

public function integer of_loadcompanies (readonly long ala_shipment);
// Load all companies for all shipments (inva_Shipments[])

Long 	ll_i, &
		ll_Upper, &
		lla_CompanyId[], &
		lla_CompanyTarget[]
		
		
n_cst_anyarraysrv lnv_anyarray
n_cst_beo_company lnv_Company

// Get all companies for all shipments
ll_Upper = UpperBound( inva_shipment[] )

For ll_i = 1 to ll_upper 
	
	inva_Shipment[ll_i].of_getreferencedcompanies ( lla_CompanyId[] )
	
	lnv_anyarray.of_appendlong ( lla_CompanyTarget[], lla_CompanyId[] )
	
Next

//// Get all contacts for all companies
//
//ll_Upper = UpperBound( ll_CompanyTarget[] )
//
//For li_i = 1 to ll_Upper
//	lnv_Company.of_getnotificationtargets ( ref long ala_emailtargets[] )
//Next

Return ll_Upper


end function

public function integer of_companycheck ();// RDT 3-12-03 Loop thru all rows and look for any boxes checked.
// If a check is found stop processing and set company to checked.
// If no check found set company to Unchecked.
// RDT 5-13-03 changed code from " ) = 1" to ") > 0" 

Long		ll_Row , &
			ll_RowCount
			
Boolean 	lb_NoContactChecked = TRUE 

ll_RowCount = dw_recipients.RowCount()

For ll_Row = 1 to ll_RowCount
	
	If dw_recipients.GetItemNumber( ll_Row , "ct_Co") > 0 Then // only check contacts with a company

		If dw_recipients.ib_EmailBoxVisible Then 
	
			If lb_NoContactChecked AND dw_recipients.GetItemNumber(ll_Row, "rowchecked" ) > 0 Then 
				lb_NoContactChecked = FALSE 
			End IF
			
		End If
		
		If dw_recipients.ib_EventBoxVisible Then 
						
			If lb_NoContactChecked AND dw_recipients.GetItemNumber(ll_Row, "ct_notifyonevent" ) > 0 Then 
				lb_NoContactChecked = FALSE 
			End IF
		End If
		
		If NOT dw_recipients.ib_EventBoxVisible AND NOT dw_recipients.ib_EmailBoxVisible Then 

			If lb_NoContactChecked AND dw_recipients.GetItemNumber(ll_Row, "ct_notifyonshipment" ) > 0 Then 
				lb_NoContactChecked = FALSE 
			End IF
			
			If lb_NoContactChecked AND dw_recipients.GetItemNumber(ll_Row, "ct_notifyonlfd" ) > 0 Then 
				lb_NoContactChecked = FALSE 
			End IF
			
			If lb_NoContactChecked AND dw_recipients.GetItemNumber(ll_Row, "ct_notifyonaccnote" ) > 0 Then 
				lb_NoContactChecked = FALSE 
			End IF
			
			If lb_NoContactChecked AND dw_recipients.GetItemNumber(ll_Row, "ct_notifyonaccauth" ) > 0 Then 
				lb_NoContactChecked = FALSE 
			End IF
		
		End If
	End If

	// if check was found stop the LOOP
	If lb_NoContactChecked = FALSE Then 
		EXIT 
	End If
	
Next 
	
ll_Row = dw_companies.GetRow()
If ll_Row > 0 then 
	If lb_NoContactChecked Then 
		dw_companies.SetItem(ll_Row , "companychecked",0 )
	Else
		dw_companies.SetItem(ll_Row , "companychecked",1 )
	End IF
End IF

//if ( dw_recipients.RowCount() > 0 ) and ( il_Row > 0 ) Then 
//	dw_recipients.ScrollToRow( il_Row ) 
//end if
	
Return 1
end function

public subroutine of_setshipment (n_cst_beo_shipment anva_shipment[]);// RDT 3-12-03 New Method
// RDT 5-13-03 Added Event Contactid retrieve
Integer	li_Count

Long 	lla_CoID[], lla_contactid[]
long	ll_CompanyCount

n_cst_beo_company lnv_company
lnv_company = create n_cst_beo_company 
lnv_company.of_SetUseCache ( TRUE )

n_cst_ShipmentManager lnv_ShipmentManager   // autoinstantiate

inva_Shipment[] = anva_shipment[]

If ib_EventContacts Then	 										// RDT 5-13-03
	THIS.of_GetContactsForAllEvents ( lla_contactid[] )	// RDT 5-13-03
Else 																		// RDT 5-13-03
	dw_companies.of_Retrieve ( inva_Shipment[] ) 	
	dw_companies.of_GetallCompanies ( ila_companyids ) // gets the company ids with contacts checked

End if																	// RDT 5-13-03


// get all companies linked to shipment
ll_CompanyCount = lnv_ShipmentManager.of_GetAllCompanies( inva_Shipment[], lla_CoId )

// Add companies that do not exist. 
For li_Count = 1 to ll_CompanyCount
	
	If dw_Companies.OF_Companyexists(lla_CoID[ li_Count ]) > 0 Then 
		// do nothing
	Else
		//	 add company id's that are not in the dw_Companies		
		If NOT IsValid( lnv_company  ) Then 
			lnv_company = create n_cst_beo_company 
			lnv_company.of_SetUseCache ( TRUE )
		End If
		lnv_Company.of_SetSourceID (lla_CoID[ li_Count ] ) 
		dw_Companies.of_AddCompany( lnv_Company, "UNCHECKED" )  	

		// RDT 6-09-03 Set the company check box based on the recipient check boxes
//		This.Post of_companycheck ( )

	End if

Next

Destroy ( lnv_company )

dw_recipients.Event ue_ApplyFilter ( )

THIS.Post of_PreLoadRecipients ( )
This.Post of_SetAllCompanyChecks()	

	

end subroutine

public function integer of_getallcontacts (ref long ala_Contact[]);
// returns all contacts from dw
Integer 	li_Return 
Long		ll_Row, &
			ll_RowCount

ll_RowCOunt = dw_recipients.RowCount()

For ll_Row = 1 to ll_RowCount
	ala_Contact[ll_row]	= dw_recipients.GetItemNumber( ll_Row, "ct_id")
Next

Return ll_RowCount
end function

public subroutine of_showshipstatus (readonly boolean ab_show);
If ab_show Then 
	gb_shipstatus.Visible = TRUE 
	cb_sendnow.Visible 	 = TRUE 
	st_shipstatus.Visible = TRUE 
Else
	rb_event.Enabled = False
	rb_shipment.Enabled = False
	gb_shipstatus.text = "Select Emails"
	st_shipstatus.Text = "Click the Send Now button to send emails to the contacts selected above. "
End If

end subroutine

public subroutine of_setreturnemail (readonly boolean ab_ReturnEMail);ib_ReturnEmail = ab_ReturnEmail
end subroutine

public function integer of_setallcompanychecks ();
dw_recipients.SetRedraw( FALSE )
dw_companies.SetRedraw ( FALSE )

long 	ll_Row, &
		ll_RowCount

ll_RowCount = dw_companies.RowCount()

If ll_RowCount > 1 Then 
	For ll_Row = 1 to ll_RowCount 
		dw_companies.SetRow( ll_Row )
		// set row will trigger the rowfocuschanged event which will trigger of_CompanyCheck() and set the check box on the company
	Next
	dw_companies.SetRow( 1 )

Else
	dw_companies.SetRow( 1 )
	dw_recipients.Event ue_ApplyFilter ( )
	This.of_CompanyCheck()
End If

dw_recipients.SetRedraw( TRUE )
dw_companies.SetRedraw ( TRUE )

Return 1
end function

public function integer of_adhocaddress (readonly string asa_address[]);// RDT 4-1-03  Changed to accept an Array of Addresses and add them all at once.
// RDT 6-01-03 

String 	ls_Find		
Long	 	lla_Contacts[]
Long	 	ll_ID
Long	 	ll_FoundRow 
Integer 	li_ct_co 
Integer 	li_Return = 1 
Integer 	li_Count, &
			li_Upper

n_Cst_Beo_Company lnv_Company
lnv_Company = Create n_Cst_Beo_Company 


dw_recipients.Event ue_ApplyFilter ( )

n_cst_ContactManager		lnv_Contacts
MailRecipient	lnv_Recipient

lnv_Contacts = CREATE n_cst_ContactManager

li_Upper = UpperBound( asa_Address )

For li_Count = 1 to li_Upper 
	lnv_Recipient.address = asa_Address[li_Count]

	ll_ID = lnv_Contacts.of_GetContactIDForRecipient ( lnv_Recipient )
	
	IF ll_ID > 0 THEN
		lla_Contacts [ UpperBound ( lla_Contacts ) + 1 ] = ll_ID
	END IF
Next		

DESTROY ( lnv_Contacts ) 		

dw_recipients.of_AddContacts ( lla_Contacts  )

For li_Count = 1 to li_Upper 
	// RDT 3-12-03 Find contact and set email check box to checked. 
	ls_Find = "ct_emailaddress = '" + asa_Address[ li_Count ] + "'"
	ll_FoundRow = dw_Recipients.Find( ls_Find, 0,  dw_Recipients.RowCount() )
	
	If ll_FoundRow > 0 Then 
		dw_Recipients.SetItem(ll_FoundRow, "rowchecked", 1)
		if ib_EventContacts Then 														// RDT 6-01-03
			dw_Recipients.SetItem(ll_FoundRow, "ct_notifyonevent", 1)		// RDT 6-01-03
			inv_Event.of_AddContactId( lla_contacts[li_Count ] ) 				// RDT 6-01-03
		end if																				// RDT 6-01-03
		
		// RDT 4-1-03	if contact has a company id add the company
		li_ct_co	= dw_Recipients.GetItemNumber(ll_FoundRow,"ct_co")
		If IsNull( li_ct_co	) Then 
			// do nothing
		Else
			// get company id and add.
			gnv_cst_companies.of_cache ( li_ct_co, true)
			lnv_Company.of_SetUseCache(TRUE)
			lnv_Company.of_SetSourceID( li_ct_co )
			dw_companies.of_AddCompany ( lnv_Company, "UNCHECKED") 		
		
		End If

	End If
Next

sle_Address.text = ''

This.Post of_UpdateContactLists ( )

This.Post of_CompanyCheck()

Destroy lnv_Company 

Return li_Return 
end function

public function integer of_loadevents ();
// RDT 5-13-03 Load events from shipment event cache
long 	ll_Count, &
		ll_RowCount, &
		lla_EventContactId[], &
		lla_AllContactId[], &
		ll_id

Integer li_Return = 1

PowerObject lpo_event

dwBuffer				le_Buffer
DataStore			lds_Source
DataWindow			ldw_Source
n_cst_Dws			lnv_Dws
n_cst_anyarraysrv	lnv_anyarray

IF UpperBound ( inva_Shipment ) <=0 THEN 
	li_Return = -1
END IF

//Check that the source type is ok.
IF li_Return = 1 THEN    

	lpo_event = inva_Shipment[1].of_GetEventSource ( )
	
	CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( lpo_event, ldw_Source, lds_Source )
	
	CASE DataStore!, DataWindow!
		//Type is ok.
	
	CASE ELSE // or nothing
		//Can't process -- processing service only handles datastores.
		li_Return = -1
		
	END CHOOSE

END IF

// Share datastore with datawindow
IF li_Return = 1 THEN
	 // create an instance of the beo_event 
	inv_Event = Create n_cst_beo_Event
 	inv_Event.of_SetSource( lds_Source )
 	lds_Source.Sharedata(dw_eventlist)
	
END IF



Return li_Return 
end function

public function integer of_initialize ();//
/***************************************************************************************
NAME			: of_Initialize
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: none
DESCRIPTION	: Sets the initial status of the object. Focus, etc.
REVISION		: RDT 5-13-03
				: RDT 6-01-03 Added check for ib_ReturnEmail so contacts check boxes display right
***************************************************************************************/
Integer 	li_Return = 1

SetFocus ( dw_companies )

dw_eventlist.SetRedraw ( False )

If ib_ReturnEmail Then 
	This.of_ViewEvent(FALSE) 
	rb_event.Visible		= FALSE
	rb_shipment.Visible	= FALSE

Else
	rb_shipment.checked = TRUE
	This.Post of_SetContextShipment() 

End If

dw_eventlist.SetRedraw ( True )

Return li_Return 
end function

public function integer of_addcompanytoevents (readonly long al_companyid, ref n_cst_beo_event anv_event);/***************************************************************************************
NAME			: of_AddCompanyToEvents
ACCESS		: Private 
ARGUMENTS	: Long					al_companyid
				  n_cst_beo_Event 	anv_Event
RETURNS		: Integer  (1 = success, -1=failed)
DESCRIPTION	: Loop thru events and set defaults on that event for the company
					Do Not process cross dock events
REVISION		: RDT 
***************************************************************************************/
Long 		lla_Contactids[], &
			ll_Row, &
			ll_i, &
			ll_RowCount, &
			i

String	ls_ContactIds, &
			ls_Find

n_cst_bso_Notification_Manager lnv_Notification_Manager 
lnv_Notification_Manager = Create n_cst_bso_Notification_Manager 


// Loop thru events
ll_RowCount = dw_eventlist.RowCount()

For ll_i = 1 to ll_RowCount 
	
	// get event id
	inv_event.of_setsourcerow ( ll_i)
	If inv_Event.of_IsCrossDock() Then 
		// do nothing. User must manually add contacts for cross docks
	Else
		// otherwise add the company to the event and set the defaults
		For i = 1 to UpperBound( inva_shipment[] )
			inv_Event.of_SetShipment( inva_shipment[i] ) 
			lnv_Notification_Manager.of_EventCompanyContact (al_companyid , inv_event, TRUE /*add company*/)
		Next
	End If
	
Next


dw_recipients.Event ue_RemoveFilter ( )

// Find company in dw_companies and scroll to row. 
ls_find = "companies_co_id = "+String ( al_companyid )
ll_Row = dw_Companies.Find (ls_Find, 1, dw_companies.RowCount() + 1 ) 
If ll_Row > 0 Then 
	dw_Companies.ScrollToRow( ll_Row )
	dw_Companies.SetFocus( ) 
	
End If

Destroy ( lnv_Notification_Manager )

Return 1

end function

public function integer of_removecompanyfromevents (ref long al_companyid, ref n_cst_beo_event anv_event);/***************************************************************************************
NAME			: of_RemoveCompanyFromEvents

ACCESS		: Private 
ARGUMENTS	: Long					al_companyid
				  n_cst_beo_Event 	anv_Event
RETURNS		: Integer  (1 = success, -1=failed)
DESCRIPTION	: Loop thru events and remove the company from them 

REVISION		: RDT 5-13-03
***************************************************************************************/
Long 		lla_Contactids[], &
			ll_Row, &
			ll_i, &
			ll_RowCount, &
			i

String	ls_ContactIds, &
			ls_Find

n_cst_bso_Notification_Manager lnv_Notification_Manager 
lnv_Notification_Manager = Create n_cst_bso_Notification_Manager 

// Loop thru events
ll_RowCount = dw_eventlist.RowCount()

For ll_i = 1 to ll_RowCount 
	// get event id
	inv_event.of_setsourcerow ( ll_i)
	// Remove company from the event 
	For i = 1 to UpperBound( inva_shipment[] )
		inv_Event.of_SetShipment( inva_shipment[i] ) 
		lnv_Notification_Manager.of_eventcompanycontact (al_companyid , inv_event, FALSE  /*Remove company*/)
	Next
Next


Destroy ( lnv_Notification_Manager )

Return 1

end function

public function integer of_viewevent (readonly boolean ab_show);// //
/***************************************************************************************
NAME			: of_ViewEvent
ACCESS		: Public 
ARGUMENTS	: Boolean 
					True  will show Event objects and expand the window
					False will hide the Event and shrink the window
					
RETURNS		: integer

DESCRIPTION	: Makes the event objects invisible and repositions the other objects 
					to the correct positions
					The il_Y_Offset is used to track if the window was sized.
					
REVISION		: RDT 6-01-03
***************************************************************************************/
Boolean 	lb_ResizeIt = False
Long 		ll_Y_Delta

ll_Y_Delta = 604

IF ab_Show Then 
	
	If il_Y_Offset < ll_Y_Delta  Then 		
		// grow window 
		il_X_Offset = 0
		il_Y_Offset = ll_Y_Delta 
		
		// Show Event stuff
		gb_shipevent.Visible	= TRUE 
		dw_eventlist.Visible	= TRUE 
		cb_clear_remove.Visible	= FALSE
		lb_ResizeIt = TRUE
	Else
		// window is big enough 
		lb_ResizeIt = FALSE		
	End If
ELSE
	If il_Y_Offset > ( ll_Y_Delta * -1 ) Then 
		// shrink window
		il_X_Offset = 0
		il_Y_Offset = ll_Y_Delta * -1 
		
		// Hide Event stuff
		gb_shipevent.Visible	= FALSE
		dw_eventlist.Visible	= FALSE
		cb_clear_remove.Visible	= TRUE 
		lb_ResizeIt = TRUE
	Else
		// window is Small enough 
		lb_ResizeIt = FALSE	
	End If
	
END IF

If lb_ResizeIt Then 
	// company area 
	gb_1.Move( gb_1.X, gb_1.Y + il_Y_Offset)  
	dw_companies.Move(dw_companies.x, dw_companies.Y + il_Y_Offset )
	
	cb_3.Move( cb_3.X, cb_3.Y + il_Y_Offset )
	cb_5.Move( cb_5.X, cb_5.Y + il_Y_Offset )
	
	// Contact area
	gb_contacts.Move(gb_contacts.X, gb_contacts.Y + il_Y_Offset)
	dw_recipients.Move(dw_recipients.X, dw_recipients.Y + il_Y_Offset )
	cb_clear_remove.Move( cb_clear_remove.X, cb_clear_remove.Y + il_Y_Offset )
	cb_8.Move( cb_8.X, cb_8.Y + il_Y_Offset )
	cb_AddressBook.Move( cb_AddressBook.X, cb_AddressBook.Y + il_Y_Offset )
	cb_6.Move( cb_6.X, cb_6.Y + il_Y_Offset )
	st_emailaddress.Move( st_emailaddress.X, st_emailaddress.Y + il_Y_Offset )
	
	// Email address area 
	gb_shipstatus.Move( gb_shipstatus.X, gb_shipstatus.Y + il_Y_Offset ) 
	sle_address.Move( sle_address.X, sle_address.Y + il_Y_Offset )
	st_shipstatus.Move( st_shipstatus.X, st_shipstatus.Y + il_Y_Offset )
	cb_sendnow.Move( cb_sendnow.X, cb_sendnow.Y + il_Y_Offset )
	
	// Resize the entire object
	This.Resize( This.Width + il_X_Offset, This.Height + il_Y_Offset ) 
	This.TriggerEvent("ue_Resize")
End IF

return 1
end function

public function long of_getxoffset ();Return il_X_Offset 
end function

public function long of_getyoffset ();Return il_Y_Offset 
end function

public function integer of_seteventid (readonly long al_eventid);//
/***************************************************************************************
NAME			: of_SetEventId
ACCESS		: Public 

ARGUMENTS	: Long	EventId
RETURNS		: integer	(Row )
DESCRIPTION	: Uses the event id argument and sets the window to the event
					check the event radio button
					scroll to the event id 

REVISION		: RDT 6-01-03

***************************************************************************************/

Integer 	li_Return = 1
long		ll_Row

String ls_Find

ls_Find = "de_id = "+ String( al_eventid )

ll_Row = dw_eventlist.Find( ls_Find, 0 ,  dw_eventlist.RowCount() + 1 )

If ll_Row > 0 then 
	rb_event.Checked = TRUE 
	rb_Event.TriggerEvent(Clicked!)
	dw_eventlist.ScrollToRow( ll_Row )

else
	li_Return = -1
end if

Return li_Return
end function

public function integer of_getcontactsforallevents (ref long ala_contactid[]);//
/***************************************************************************************
NAME			: of_GetContactsForAllEvents
ACCESS		: Private 
ARGUMENTS	: Long array 	( ala_contactid[] by ref)
RETURNS		: integer 		number of elements in array
DESCRIPTION	: loops thru all events and gets all contact IDs
REVISION		: RDT 5-13-03 
***************************************************************************************/


Long	ll_RowCount, &
		ll_Count, &
		ll_id, &
		lla_EventContactId[]
		
n_cst_anyarraysrv  lnv_anyarray

// Loop thru each event and get all the contact Id's
ll_RowCount = dw_eventlist.RowCount()
For ll_Count = 1 to ll_RowCount
	ll_id = dw_eventlist.GetItemNumber( ll_Count, 'de_id' ) 

//	inv_Event.of_SetSource( dw_eventlist ) // This is done in of_loadEvents
	inv_Event.of_SetSourceRow ( ll_Count ) 
	
	If inv_Event.of_HasSource() Then 
		inv_Event.of_GetEventContacts( lla_EventContactId )
		lnv_anyarray.of_appendlong ( ala_contactid[], lla_EventContactId [] )
	Else
		MessageBox("Program error", "Get Contact has no source" )
	End if
Next

lnv_AnyArray.of_GetShrinked ( ala_contactid[], TRUE , TRUE )
		
Return UpperBound( ala_contactid[] ) 


end function

private function integer of_companycheck (readonly long al_coid);// RDT 6-01-03 set company to company id apply filter and call company check

String 	ls_Find
Long		ll_Row
ls_Find = "companies_co_id = "+String( al_coid )

ll_Row = dw_companies.Find( ls_Find , 0 , dw_companies.RowCount() + 1 )

If ll_Row > 0 Then 
	dw_companies.SetRow( ll_Row ) 
	dw_recipients.TriggerEvent("ue_applyFilter")
	This.of_CompanyCheck()
End If


Return 1

end function

public function integer of_setcontextshipment ();// RDT 6-01-03 New
dw_recipients.of_showeventcheckbox ( FALSE )	

dw_eventlist.SelectRow(0, FALSE)
dw_companies.SelectRow(0, FALSE)

ib_EventContacts = FALSE 

This.of_ViewEvent( FALSE )

This.of_SetAllCompanyChecks()

dw_companies.SetFocus()

Return 1
end function

public function integer of_setcontextevent ();long	ll_Return = 0

dw_companies.SetRedraw(FALSE)
dw_recipients.SetRedraw(FALSE)

If dw_eventlist.RowCount() > 0 Then 
		Long 	lla_Contacts[]
		This.of_ViewEvent( TRUE )
		inv_Event.of_SetSourceRow ( 1 ) 
		
		If inv_Event.of_HasSource() Then 
			ib_EventContacts = TRUE 		

			// get contact id's
			inv_event.of_GetEventContacts ( lla_contacts[] )
					
			// set row 1 contacts check status
			dw_companies.SelectRow(0, FALSE)
			dw_recipients.of_showeventcheckbox ( TRUE )	
			This.of_CheckRecipients ( "ct_notifyonevent", lla_Contacts[] )
			
			// Set company check marks
			This.of_SetAllCompanyChecks()
			dw_recipients.Event ue_RemoveFilter ( )	
			
			dw_eventlist.ScrollToRow( 1 )
			dw_eventlist.SetRow( 1 )
			dw_eventlist.SelectRow(1, TRUE )
			dw_eventlist.TriggerEvent(CLICKED!)
			dw_eventlist.TriggerEvent(ROWFOCUSCHANGED!)
		Else
			Messagebox("Program Error","Event list has no source ")	
			ll_Return = -1
		End If

Else
	MessageBox("Events","There are no events for this shipment.")
	ll_Return = -1
End If

dw_companies.SetRedraw(TRUE)
dw_recipients.SetRedraw(TRUE)


Return ll_Return
end function

private function integer of_addeventsfromdw ();
// add contact id to inv_events from dw_recepient check
Long ll_Row, ll_RowCount

ll_RowCount = dw_recipients.RowCount()

IF dw_eventlist.GetRow() > 0 Then 
	inv_Event.of_SetSourceRow( dw_eventlist.GetRow() ) 

	If ll_RowCount > 0 Then 
		For ll_row = 1 to ll_RowCount
			if dw_recipients.GetItemNumber( ll_Row, 'ct_notifyonevent') = 1 then 
				inv_Event.of_AddContactId( dw_recipients.GetItemNumber( ll_Row, 'ct_id') ) 
			end if
		Next 
	End if

End IF

Return 1
end function

on u_cst_shipment_notification.create
int iCurrent
call super::create
this.gb_shipstatus=create gb_shipstatus
this.gb_contacts=create gb_contacts
this.gb_1=create gb_1
this.dw_available=create dw_available
this.ddlb_newaddress=create ddlb_newaddress
this.cb_1=create cb_1
this.st_3=create st_3
this.cb_4=create cb_4
this.uo_template=create uo_template
this.gb_shipevent=create gb_shipevent
this.dw_eventlist=create dw_eventlist
this.rb_event=create rb_event
this.rb_shipment=create rb_shipment
this.dw_companies=create dw_companies
this.cb_3=create cb_3
this.cb_5=create cb_5
this.dw_recipients=create dw_recipients
this.cb_clear_remove=create cb_clear_remove
this.cb_8=create cb_8
this.cb_addressbook=create cb_addressbook
this.sle_address=create sle_address
this.cb_6=create cb_6
this.st_shipstatus=create st_shipstatus
this.cb_sendnow=create cb_sendnow
this.st_emailaddress=create st_emailaddress
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_shipstatus
this.Control[iCurrent+2]=this.gb_contacts
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_available
this.Control[iCurrent+5]=this.ddlb_newaddress
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.cb_4
this.Control[iCurrent+9]=this.uo_template
this.Control[iCurrent+10]=this.gb_shipevent
this.Control[iCurrent+11]=this.dw_eventlist
this.Control[iCurrent+12]=this.rb_event
this.Control[iCurrent+13]=this.rb_shipment
this.Control[iCurrent+14]=this.dw_companies
this.Control[iCurrent+15]=this.cb_3
this.Control[iCurrent+16]=this.cb_5
this.Control[iCurrent+17]=this.dw_recipients
this.Control[iCurrent+18]=this.cb_clear_remove
this.Control[iCurrent+19]=this.cb_8
this.Control[iCurrent+20]=this.cb_addressbook
this.Control[iCurrent+21]=this.sle_address
this.Control[iCurrent+22]=this.cb_6
this.Control[iCurrent+23]=this.st_shipstatus
this.Control[iCurrent+24]=this.cb_sendnow
this.Control[iCurrent+25]=this.st_emailaddress
end on

on u_cst_shipment_notification.destroy
call super::destroy
destroy(this.gb_shipstatus)
destroy(this.gb_contacts)
destroy(this.gb_1)
destroy(this.dw_available)
destroy(this.ddlb_newaddress)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.cb_4)
destroy(this.uo_template)
destroy(this.gb_shipevent)
destroy(this.dw_eventlist)
destroy(this.rb_event)
destroy(this.rb_shipment)
destroy(this.dw_companies)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.dw_recipients)
destroy(this.cb_clear_remove)
destroy(this.cb_8)
destroy(this.cb_addressbook)
destroy(this.sle_address)
destroy(this.cb_6)
destroy(this.st_shipstatus)
destroy(this.cb_sendnow)
destroy(this.st_emailaddress)
end on

type gb_shipstatus from groupbox within u_cst_shipment_notification
integer y = 1924
integer width = 2290
integer height = 156
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_contacts from groupbox within u_cst_shipment_notification
integer y = 1184
integer width = 2290
integer height = 740
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Contacts being notified"
end type

type gb_1 from groupbox within u_cst_shipment_notification
integer y = 668
integer width = 2290
integer height = 512
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Companies being notified"
end type

type dw_available from u_dw_companycontacts_list within u_cst_shipment_notification
integer x = 2405
integer y = 72
integer width = 887
integer height = 664
integer taborder = 0
boolean bringtotop = true
end type

event doubleclicked;//Long	ll_ID
//
//IF row > 0 THEN
//	ll_ID = THIS.GetItemNumber ( row , "id" )
//	IF ll_ID > 0 THEN
//		dw_recipients.of_AddContact ( ll_ID )
//		dw_recipients.of_Refresh ( )
//	END IF
//END IF

PARENT.of_AddRecipient ( row )
end event

event rbuttonup;String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]


lsa_parm_labels[1] = "ADD_ITEM"
laa_parm_values[1] = "&Add->"	

lsa_parm_labels[2] = "ADD_ITEM"
laa_parm_values[2] = "Add A&ll"	

lsa_parm_labels[3] = "ADD_ITEM"
laa_parm_values[3] = "-"

lsa_parm_labels[4] = "ADD_ITEM"
laa_parm_values[4] = "&Details"

lsa_parm_labels [5] = "XPOS"
laa_parm_values [5] = THIS.X + PointerX ( ) + 105

lsa_parm_labels [6] = "YPOS"
laa_parm_values [6] = THIS.Y + PointerY ( ) + 165
	
	
ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)

CHOOSE CASE ls_PopRtn
				
	CASE "DETAILS"
		THIS.Event ue_Details ( row )
		
	CASE "ADD->"
		PARENT.of_AddRecipient ( row )
		
	CASE "ADD ALL"
		PARENT.of_AddAll ( )
		
		
END CHOOSE
end event

event ue_details;//OverRide with call to super
THIS.of_Cache ( ila_Companyids[] )
SUPER::Event ue_Details ( al_row )
dw_recipients.Event ue_Refresh ( )
RETURN 1
end event

type ddlb_newaddress from u_ddlb within u_cst_shipment_notification
integer x = 2432
integer y = 1044
integer width = 887
integer height = 316
integer taborder = 0
boolean bringtotop = true
boolean allowedit = true
boolean autohscroll = true
end type

event constructor;ddlb_newaddress.ib_Search = TRUE
end event

type cb_1 from commandbutton within u_cst_shipment_notification
integer x = 2473
integer y = 1176
integer width = 265
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Add ->"
end type

event clicked;
IF Len ( ddlb_newaddress.Text ) > 0  THEN
	Parent.of_AddNew ( )
ELSE
	PARENT.of_AddRecipient ( dw_available.GetRow ( ) )
END IF
end event

type st_3 from statictext within u_cst_shipment_notification
integer x = 2437
integer y = 952
integer width = 887
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Type address or select it from list"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within u_cst_shipment_notification
integer x = 2473
integer y = 1276
integer width = 265
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add A&ll ->"
end type

event clicked;Parent.of_AddAll ( )
end event

type uo_template from u_cst_fileselection within u_cst_shipment_notification
integer x = 2464
integer y = 828
integer width = 777
boolean bringtotop = true
long backcolor = 12632256
end type

event ue_filechanged;Parent.of_SetTemplate ( as_path )
Parent.Event ue_TemplateChanged ( as_path  )
Return 1


end event

on uo_template.destroy
call u_cst_fileselection::destroy
end on

type gb_shipevent from groupbox within u_cst_shipment_notification
integer y = 64
integer width = 2290
integer height = 604
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Events"
end type

type dw_eventlist from u_dw_eventlist within u_cst_shipment_notification
integer x = 23
integer y = 128
integer width = 1915
integer height = 492
boolean bringtotop = true
string dataobject = "d_shipmenteventlist"
boolean livescroll = false
end type

event constructor;call super::constructor;
This.SetRowFocusIndicator ( FocusRect! )
This.ib_rmbmenu = false


end event

event rowfocuschanged;// OVERRIDE OVERRIDE 
// RDT 6-01-03 fixed company check boxes

dw_companies.SetRedraw(FALSE) 
dw_recipients.SetRedraw(FALSE) 

Long 	ll_id, &
		lla_Contacts[], &
		ll_Return = 0, &
		ll_Row, &
		ll_Upper

If ib_eventcontacts Then 
	If Currentrow > 0 Then 
		gf_multiselect(this, Currentrow )
		
//		inv_Event.of_SetSource( This ) // This is done in of_loadEvents
		inv_Event.of_SetSourceRow ( currentrow ) 
		
		If inv_Event.of_HasSource() Then 
			// get contact id's
			inv_event.of_GetEventContacts ( lla_contacts[] )
			
			// set contact checks
			Parent.of_CheckRecipients ( "ct_notifyonevent", lla_Contacts[] )
			
			// set company check for each company // RDT 6-01-03
			dw_recipients.Event ue_RemoveFilter ( )

			// Set company check marks
			dw_recipients.Event ue_RemoveFilter ( )
			Parent.of_SetAllCompanyChecks()

//			ll_Upper = dw_companies.RowCount()
//			For ll_row = 1 to ll_Upper 
//				dw_companies.SetRow( ll_Row ) 
//				Parent.of_CompanyCheck()
//			Next

		Else
			Messagebox("Program Error","Event list has no source ")	
			ll_Return = 1
		End If
	
		
	End If
Else
	ll_Return = 1
End IF

dw_recipients.Event ue_RemoveFilter ( )

dw_companies.SelectRow(0, False)

dw_companies.SetRedraw( TRUE) 
dw_recipients.SetRedraw(TRUE) 

RETURN ll_return


end event

event doubleclicked;// override override 
// override override 
end event

event destructor;// OverRide 
// OverRide 
end event

event buttonclicked;// OverRide 
// OverRide 

end event

event editchanged;// OverRide 
// OverRide 

end event

event itemchanged;// OverRide 
// OverRide 

end event

event itemerror;// OverRide 
// OverRide 

end event

event itemfocuschanged;// OverRide 
// OverRide 

end event

event clicked;// OverRide 
Long	ll_Return 
If row > 0 Then 
	If ib_eventcontacts Then 
		gf_multiselect(this, row)
		THIS.SetRow ( row )
		ll_Return = 0
	Else
		MessageBox("Events ", "Please Select Events Before Proceeding ")
		ll_Return = 1
	End IF
End IF

Return ll_Return 
end event

type rb_event from u_rb within u_cst_shipment_notification
integer x = 1979
integer y = 16
integer width = 256
integer height = 56
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 12632256
string text = "Event"
end type

event clicked;Parent.of_SetContextEvent()
//long	ll_Return = 0
//
//dw_companies.SetRedraw(FALSE)
//dw_recipients.SetRedraw(FALSE)
//
//If dw_eventlist.RowCount() > 0 Then 
//		Long 	lla_Contacts[]
//		Parent.of_ViewEvent( TRUE )
//		inv_Event.of_SetSourceRow ( 1 ) 
//		
//		If inv_Event.of_HasSource() Then 
//			ib_EventContacts = TRUE 		
//
//			// get contact id's
//			inv_event.of_GetEventContacts ( lla_contacts[] )
//					
//			// set row 1 contacts check status
//			dw_companies.SelectRow(0, FALSE)
//			dw_recipients.of_showeventcheckbox ( TRUE )	
//			Parent.of_CheckRecipients ( "ct_notifyonevent", lla_Contacts[] )
//			
//			// Set company check marks
//			Parent.of_SetAllCompanyChecks()
//			dw_recipients.Event ue_RemoveFilter ( )	
//			
//			dw_eventlist.ScrollToRow( 1 )
//			dw_eventlist.SetRow( 1 )
//			dw_eventlist.SelectRow(1, TRUE )
//			dw_eventlist.TriggerEvent(CLICKED!)
//			dw_eventlist.TriggerEvent(ROWFOCUSCHANGED!)
//		Else
//			Messagebox("Program Error","Event list has no source ")	
//			ll_Return = -1
//		End If
//
//Else
//	MessageBox("Events","There are no events for this shipment.")
//	ll_Return = -1
//End If
//
//dw_companies.SetRedraw(TRUE)
//dw_recipients.SetRedraw(TRUE)
//
//
//Return ll_Return
end event

type rb_shipment from u_rb within u_cst_shipment_notification
integer x = 1591
integer y = 16
integer width = 306
integer height = 56
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 12632256
string text = "Shipment"
end type

event clicked;Parent.of_SetContextShipment() 
//dw_recipients.of_showeventcheckbox ( FALSE )	
//
//dw_eventlist.SelectRow(0, FALSE)
//
//ib_EventContacts = FALSE 
//
//Parent.of_ViewEvent( FALSE )
//
//Parent.of_SetAllCompanyChecks()
//
////Parent.of_SetShipment( inva_Shipment[] )
//
//
end event

type dw_companies from u_dw_companiesbycontacts within u_cst_shipment_notification
integer x = 23
integer y = 736
integer width = 1915
integer height = 416
integer taborder = 20
boolean bringtotop = true
end type

event rowfocuschanged;call super::rowfocuschanged;dw_recipients.Event ue_ApplyFilter ( )

Parent.of_CompanyCheck()

RETURN AncestorReturnValue 
end event

event ue_getshipment;// RDT 3-12-03 

If UpperBound( inva_shipment[] ) > 0 Then 
	RETURN inva_Shipment[1]
Else
	Return n_cst_Beo_Shipment
End If

//Long 	ll_i
//n_cst_Beo_Shipment lnv_Ship
//For ll_i = 1 to UpperBound( inva_shipment )
//	If inva_shipment[ll_i].of_getbillto( ) = this.GetItemNumber(This.GetRow(),"companies_co_id") Then 
//		lnv_Ship = inva_shipment[ll_i]
//	End If
//	
//Next
//
//Return lnv_Ship
end event

event ue_companyadded;
Long	lla_Contacts[]

n_cst_ContactManager	lnv_CtManager
lnv_CtManager = CREATE n_cst_ContactManager

n_cst_beo_Company	lnv_Co
lnv_Co = CREATE n_cst_beo_Company

lnv_Co.of_SetUseCache ( TRUE ) 
lnv_Co.of_SetSourceID ( al_ID ) 

IF lnv_Co.of_HasSource( ) THEN
	lnv_CtManager.of_GetAllContactsForCompany ( lnv_Co , lla_Contacts )
	dw_recipients.of_AddContacts ( lla_Contacts ) 
ELSE
	messageBox ( "Company Added" , "Error resolving company" ) 
END IF

THIS.of_GetallCompanies ( ila_companyids )
dw_recipients.Event ue_ApplyFilter ( )

// RDT 3-12-03 added case statements
Choose Case Upper( as_setcontactchecks )
	Case "CHECKED" 
		Parent.Post of_setrecipientschecked( TRUE )
	Case "UNCHECKED" 
		Parent.Post of_setrecipientschecked( FALSE )
	Case "DEFAULT" 
		Parent.Post of_AddCompanyToEvents ( al_id, inv_event )

End Choose

// RDT 6-09-03 
//// RDT 3-12-03 Set the company check box based on the recipient check boxes
//IF MessageBox("RICH ue_Company added row: "+String(This.GetRow()), "of_companycheck?",Question!,yesNo! ) = 1 then // RDTTEST
//Parent.Post of_companycheck ( )
//end if // RDTTEST
//IF MessageBox("RICH ue_Company added row: "+String(This.GetRow()), "of_UpdateContactLists ( )?",Question!,yesNo! ) = 1 then // RDTTEST
//Parent.Post of_UpdateContactLists ( )
//end if // RDTTEST


DESTROY ( lnv_Co ) 
DESTROY ( lnv_CtManager )


RETURN 1

end event

event constructor;call super::constructor;This.SetRowFocusIndicator ( FocusRect! )
This.ib_rmbmenu = false

end event

event ue_companydeleted;Long	lla_Contacts[]

n_cst_ContactManager	lnv_Manager
lnv_Manager = CREATE n_cst_ContactManager

IF lnv_Manager.of_GetAllContactsForCompany ( anv_company , lla_Contacts ) > 0 THEN // returns count of contacts

	dw_recipients.of_RemoveContacts ( lla_Contacts ) 

	Parent.of_UpdateContactLists ( )
	dw_recipients.Event ue_ApplyFilter ( )
	
END IF

DESTROY ( lnv_Manager )

RETURN 1
end event

event itemchanged;call super::itemchanged;
// RDT check the company check box

//IF This.GetColumn() = 5 then 
IF dwo.Name = "companychecked" Then 
	
	dw_recipients.Event ue_ApplyFilter ( )

	If This.GetItemNumber(row, "companychecked" ) = 1 Then 
		// uncheck all the contacts for that company
		Parent.of_setrecipientschecked( FALSE ) 
		
	Else
		// check all the contacts
		Parent.of_setrecipientschecked( TRUE ) 
		
	End If

	Parent.Post of_UpdateContactLists ( )
	
END IF



end event

event getfocus;call super::getfocus;//
//dw_recipients.of_showeventcheckbox ( FALSE )	
//
//dw_eventlist.SelectRow(0, FALSE)
//
//ib_EventContactsShowing = FALSE 
end event

event clicked;call super::clicked;
gf_multiselect(this, row)
THIS.SetRow ( row )

dw_recipients.Event ue_ApplyFilter ( )

Parent.of_CompanyCheck()

Return AncestorReturnValue
end event

event ue_deletecompany;// OverRide
// OverRide Need to get company ID before it is deleted.

Long 	ll_CompanyId
ll_CompanyId = This.GetItemNumber( This.GetRow(), 'companies_co_id' )

THIS.of_DeleteCompany ( THIS.of_GetCompanyFromRow ( THIS.GetRow( )  ) )

Parent.of_RemoveCompanyFromEvents( ll_CompanyId , inv_Event )


// Remove company eventcontacts from shipment
//If MessageBOx("RICH ue_deletecompany","Clear shipment event contacts?",Question!,Yesno!,2) = 1 then 
//	Integer 	li_Upper, &
//				i
//	
//	Long		lla_Contacts[]			
//	
//	li_Upper = UpperBound( inva_Shipment[] )
//	lla_Contacts[1] = 0
//	For i = 1 to li_Upper 
//		inva_Shipment[i].of_seteventcontacts ( lla_contacts[] )
//	Next
//	
//End if
end event

type cb_3 from commandbutton within u_cst_shipment_notification
integer x = 1966
integer y = 740
integer width = 288
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add"
end type

event clicked;
If ib_EventContacts Then 							// RDT 8-12-03 
	il_Row = dw_eventlist.GetSelectedRow(0)	// RDT 8-12-03 
End if													// RDT 8-12-03 

dw_companies.SetRedraw( FALSE ) 

dw_companies.Event ue_AddCompany ( "DEFAULT" )
 
Parent.of_UpdateContactLists ( )		// RDT 6-09-03 
Parent.of_companycheck ( )				// RDT 6-09-03 

If ib_EventContacts Then 							// RDT 8-12-03 
	If il_Row > 0 Then 								// RDT 8-12-03 
		dw_eventlist.SetRow( il_Row )				// RDT 8-12-03 
	End if												// RDT 8-12-03 
End if													// RDT 8-12-03 

If ib_EventContacts  then 
	Parent.of_addeventsfromdw ( )						// RDT 8-12-03 
End if

dw_companies.SetRedraw( TRUE ) 
end event

type cb_5 from commandbutton within u_cst_shipment_notification
integer x = 1966
integer y = 860
integer width = 288
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Remove"
end type

event clicked;
// Delete ONLY UNlinked companies ( Role = NONE ) 

//If dw_companies.GetItemString(dw_companies.GetRow(), "role") = n_cst_constants.cs_requestrole_none Then 
If UPPER( dw_companies.GetItemString(dw_companies.GetRow(), "role") ) = "NONE" Then 	
	If MessageBox("Remove Company","OK to Remove Company "+ dw_companies.GetItemString(dw_companies.GetRow(), "companies_co_name") ,Question!,YesNo!,1) = 1 then 
		dw_companies.Event ue_DeleteCompany ( ) 
	end If
Else
	MessageBox("Remove Company", "Company is linked to the shipment and can not be removed.")
End If

end event

type dw_recipients from u_dw_notificationrecipients within u_cst_shipment_notification
event ue_selectnewcontact ( n_cst_beo_company anv_company )
event ue_removefilter ( )
event ue_applyfilter ( )
integer x = 23
integer y = 1252
integer width = 1915
integer height = 488
integer taborder = 50
boolean bringtotop = true
boolean hscrollbar = false
end type

event ue_selectnewcontact;Long			lla_contactIDs[]
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "COMPANY"
lstr_Parm.ia_Value = anv_company
lnv_Msg.of_Add_Parm ( lstr_Parm )


//IF isValid ( anv_Company ) THEN
	OpenWithParm ( w_ContactSelect, lnv_Msg )
	
	IF isValid ( Message.PowerObjectParm )THEN
		lnv_Msg = Message.PowerObjectParm 
		IF lnv_Msg.of_Get_Parm ( "CONTACTIDS" , lstr_Parm ) <> 0 THEN
			lla_ContactIds = lstr_Parm.ia_Value			
			dw_recipients.of_AddContacts ( lla_ContactIds   )
			
		END IF
	END IF
	
//ELSE
//	MessageBox ( "Select Contact" , "Please be sure you have selected a company." )
//END IF	


end event

event ue_removefilter;dw_recipients.SetFilter( "" ) 
dw_recipients.Filter ( )
gb_contacts.Text = "Company contacts being notified"

end event

event ue_applyfilter;Long	ll_CoID 
String	ls_Name
Long		ll_Row
n_cst_String	lnv_String

ll_Row = dw_companies.GetRow ( )
ll_CoId = dw_companies.of_GetCompanyID ( ll_Row )

IF ll_CoID > 0 THEN
	dw_recipients.of_SetCompanyID ( ll_CoID )
	dw_recipients.of_FilterList (  ) 
END IF

IF ll_Row > 0 THEN
	ls_name = dw_companies.GetItemString ( ll_Row , "companies_co_name" )
	ls_Name = lnv_String.of_Substitute ( ls_Name , "&" , "+" ) 
	gb_Contacts.Text = ls_Name + "'S contacts being notified"
ELSE
	gb_Contacts.Text = "Company contacts being notified"
END IF



end event

event doubleclicked;THIS.Event ue_Details ( row )
end event

event rbuttonup;//String	ls_PopRtn
//String	lsa_parm_labels[]
//Any		laa_parm_values[]
//
//lsa_parm_labels [1] = "ADD_ITEM"
//laa_parm_values [1] = "&Remove Contact"	
//
//lsa_parm_labels [2] = "ADD_ITEM"
//laa_parm_values [2] = "&Clear List"	
//
//lsa_parm_labels [3] = "ADD_ITEM"
//laa_parm_values [3] = "-"
//
//lsa_parm_labels [4] = "ADD_ITEM"
//laa_parm_values [4] = "&Details"	
//
//lsa_parm_labels [5] = "XPOS"
//laa_parm_values [5] = THIS.X + PointerX ( ) + 105
//
//lsa_parm_labels [6] = "YPOS"
//laa_parm_values [6] = THIS.Y + PointerY ( ) + 165
//	
//ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)
//
//CHOOSE CASE ls_PopRtn
//				
//	CASE "DETAILS"
//		THIS.Event ue_Details ( row )
//		
//	CASE "REMOVE CONTACT"
//		THIS.of_RemoveContact ( row )
//		PARENT.of_UpdateContactLists ( )
//		
//	CASE "CLEAR LIST"
//		THIS.of_RemoveAll ( )		
//		PARENT.of_UpdateContactLists ( )
//		
//		
//END CHOOSE
end event

event ue_details;//OverRide 
THIS.of_Cache ( ila_Companyids[] )
//SUPER::Event ue_Details ( al_row )


long	ll_ID
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


SetPointer ( HourGlass! )

IF al_Row > 0 THEN
			
	lstr_Parm.is_Label = "CONTEXT"
	lstr_Parm.ia_Value = "DETAILS"
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ID"
	lstr_Parm.ia_Value = THIS.GetItemNumber ( al_Row , "ct_id" )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ROW"
	lstr_Parm.ia_Value = al_Row
	lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	lstr_Parm.is_Label = "CACHE"
	lstr_Parm.ia_Value = THIS.of_GetCache ( )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EDITABLE"
	lstr_Parm.ia_Value = FALSE
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	OpenWithParm ( w_CompanyContact_Detail , lnv_Msg )
		
END IF

RETURN 1


end event

event itemchanged;call super::itemchanged;Long 		ll_checked, &
			ll_id, &
			ll_coId, &
			ll_Return 
			
String 	ls_EmailAddress 

ll_Return = AncestorReturnValue

This.SetRedraw( FALSE )

IF ll_Return = 0 Then 
	If row > 0 Then 
	
		If This.GetItemNumber( row, "ct_Co") > 0 Then 
			ll_coId = This.GetItemNumber( row, "ct_Co") 
			cb_clear_remove.Text = "Clear"
		Else
			cb_clear_remove.Text = "Remove"	
		End If
	End If
	
	// check for event and set 
	
	If This.GetColumnName ( ) = "ct_notifyonevent" AND row > 0 Then
	
	//	inv_Event.of_SetSource( dw_eventlist )  // This is done in of_loadEvents
		
		IF dw_eventlist.GetRow() > 0 Then 
			inv_Event.of_SetSourceRow( dw_eventlist.GetRow() ) 
		End IF
		
		If inv_Event.of_HasSource( )  Then 
			// add or delete contact id
			if This.GetItemNumber(row, 'ct_notifyonevent' ) = 0 Then // will be checked
				// get contact id and  add to event
				inv_Event.of_AddContactId( This.GetItemNumber( Row, 'ct_id') ) 
			else
				// get contact id and Remove From Event
				inv_Event.of_RemoveContactId( This.GetItemNumber( Row, 'ct_id')) 
				
			end if 
		Else
			MessageBox("Program error","Recipient has no source.") 
		End IF
		
	End If
	
	Parent.Post of_UpdateContactLists ( )
	
	//Parent.Post of_CompanyCheck()
	
	Parent.Post of_CompanyCheck(ll_coId)
	
	This.SetFocus()
	
	This.SetRedraw( TRUE )
END IF

end event

event constructor;call super::constructor;//THIS.Event ue_SetFocusIndicator ( FALSE )

//THIS.Object.DataWindow.HorizontalScrollSplit = 261
end event

event rowfocuschanged;call super::rowfocuschanged;
THIS.SelectRow ( 0 , FALSE )

If currentrow > 0  AND This.RowCount() > 0 then 

		If This.GetItemNumber( currentrow, "ct_co") > 0 Then 
			
			cb_clear_remove.Text = "Clear"
		Else
			cb_clear_remove.Text = "Remove"	
		End If
		
End If

end event

event ue_deletecontact;call super::ue_deletecontact;IF AncestorReturnValue = 1 THEN
	PARENT.of_updateContactLists ( )
END IF

RETURN AncestorReturnValue 

end event

event clicked;call super::clicked;
Long 		ll_Return = 0
Long		ll_coId, &
			ll_RowFound
			
Boolean	lb_CompanyEmail = TRUE 

String	ls_Find, &
			ls_Role, &
			ls_EmailAddress
// RDT 7-18-03 Added checks for email address - Start 
IF ll_Return = 0 Then 
	IF row > 0 Then
	
		If (dwo.name =  "ct_notifyonaccauth" OR dwo.name =  "ct_notifyonshipment" OR &
			 dwo.name =  "ct_notifyonevent"   OR dwo.name =  "ct_notifyonaccnote"  OR &
			 dwo.name =  "ct_notifyonlfd"     OR dwo.name =  "ct_notifyontir" ) 	  OR &
			 dwo.name =  "rowchecked" 	Then 
			 
	 		if dwo.Primary[row] = 0 or IsNull ( dwo.Primary[row] ) Then 

				ls_EmailAddress = This.GetItemString( Row, 'ct_EmailAddress') 
				
				if IsNull( ls_EmailAddress ) OR Len( Trim( ls_EmailAddress )  ) < 1 then 
					MessageBox("Notification Error","Contact has no email address.")
					ll_Return = 1
				end if
				
		 	end if
		End If
	END IF	
END IF
// RDT 7-18-03 Added checks for email address - End 
			
IF ll_Return = 0 Then 
	IF row > 0 Then 
		If This.GetItemNumber( row, "ct_Co") > 0 Then 
			ll_coId = This.GetItemNumber( row, "ct_Co") 
			ls_Find = "companies_co_id = "+String(ll_coID)
			ll_RowFound = dw_companies.Find( ls_Find, 0, dw_companies.RowCount() +1 ) 
	
			if ll_RowFound > 0 Then 
				if ll_RowFound <> dw_companies.GetRow() then 
					dw_companies.SetReDraw ( FALSE )
					dw_companies.SetRow(ll_RowFound) 
					dw_companies.SelectRow(0 , FALSE) 
					dw_companies.SelectRow(ll_RowFound, True) 
					dw_companies.SetReDraw ( TRUE )
				end if
			end if
		ELSE
			lb_CompanyEmail = FALSE 
		End If
	END IF
END IF

IF ll_Return = 0 Then 
	IF dwo.name =  "ct_notifyonaccauth" AND row > 0 Then
		
		If lb_CompanyEmail Then 	
			
			// Role column may contain more than one value
			n_cst_String	lnv_String
			ls_Role = UPPER ( dw_companies.GetItemString(dw_companies.GetRow(), "role") )
			
			IF lnv_String.of_CountOccurrences ( ls_Role, "BILLTO", TRUE ) > 0 Then 
				inv_Event.of_AddContactId( This.GetItemNumber( Row, 'ct_id') ) 
			Else
				MessageBox("Authorization not Allowed", "This Email is not on the BillTo Company.")
				ll_Return = 1
			End if
			
		Else
			MessageBox("Authorization not Allowed", "This Email is not associated with any Company.")
			ll_Return = 1
		End If
		
	END IF
END IF

Return ll_Return 
end event

type cb_clear_remove from commandbutton within u_cst_shipment_notification
integer x = 1966
integer y = 1252
integer width = 288
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Remove"
end type

event clicked;// RDT 6-01-03 check for return on ue_deleteContact()

Long	ll_Row, ll_ID

ll_Row = dw_recipients.GetRow ( ) 

If This.Text = "Remove" Then 

	IF ll_Row > 0 THEN
		// get contact id and Remove From Event
		ll_ID = dw_Recipients.GetItemNumber( ll_Row, 'ct_id') 
		If dw_recipients.Event ue_DeleteContact ( ll_Row ) = 1 Then 
				inv_Event.of_RemoveContactId( ll_id ) 
		End If
		
	End If

END IF
	
If This.Text = "Clear" Then 
	long 	ll_Col_Count, &
			ll_col
	String	ls_Column[]
	
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonaccauth"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonaccnote"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonlfd"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonshipment"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "ct_notifyonevent"
	ll_Col_Count ++
	ls_Column[ ll_Col_Count ] = "RowChecked"

	IF ll_Row > 0 THEN
		// set all the check boxes to NOT checked
		for ll_Col = 1 to ll_Col_Count
			dw_recipients.SetItem ( ll_Row , ls_Column[ll_col], 0 )
		next
		// set company to not checked
		Parent.of_CompanyCheck()
		Parent.Post of_UpdateContactLists ( )

	End If

END IF
	
	
end event

type cb_8 from commandbutton within u_cst_shipment_notification
integer x = 1966
integer y = 1384
integer width = 288
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Show All"
end type

event clicked;dw_recipients.Event ue_RemoveFilter ( )

end event

type cb_addressbook from commandbutton within u_cst_shipment_notification
integer x = 1966
integer y = 1516
integer width = 288
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Addr. Book"
end type

event clicked;// RDT 6-01-03 set check box to checked for events

String 	ls_Find
String	ls_Address
Long		ll_pos
Long		ll_FoundRow
Long		lla_Contacts[]
Long		ll_i
Long		ll_ID
Long		ll_Count


n_Cst_bso_Email_Manager	lnv_Email
n_cst_ContactManager		lnv_Contacts
MailRecipient	lnva_Recipients[]

lnv_Contacts = CREATE n_cst_ContactManager
lnv_Email = CREATE n_Cst_bso_Email_Manager

lnv_Email.of_GetRecipientsFromAddressBook ( lnva_Recipients )
ll_Count = UpperBound ( lnva_Recipients ) 

FOR ll_i = 1 TO ll_count
	ll_ID = lnv_Contacts.of_GetContactIDForRecipient ( lnva_Recipients [ ll_i ] )
	IF ll_ID > 0 THEN
		lla_Contacts [ UpperBound ( lla_Contacts ) + 1 ] = ll_ID
	END IF
NEXT

DESTROY ( lnv_Contacts ) 
DESTROY ( lnv_Email )

dw_recipients.of_AddContacts ( lla_Contacts  )


// RDT 3-12-03 Find and set check boxes to checked
FOR ll_i = 1 TO ll_count
	 // 	SMTP:name@company.domain
	ls_Address = Trim ( lnva_Recipients[ll_i].Address )

	If Upper ( left( ls_Address ,5 ) ) = "SMTP:" Then 
		ls_Address = Right ( ls_address,  Len( ls_address) - 5 )
	End If
	
	ls_Find = "ct_emailaddress = '" + ls_Address + "'"
		ll_FoundRow = dw_Recipients.Find( ls_Find, 0,  dw_Recipients.RowCount() )
		If ll_FoundRow > 0 Then 
			if ib_EventContacts Then 														// RDT 6-01-03
				dw_Recipients.SetItem(ll_FoundRow, "ct_notifyonevent", 1)		// RDT 6-01-03
				inv_Event.of_AddContactId( lla_contacts[ll_i] ) 					// RDT 6-01-03
			end if																				// RDT 6-01-03
			if ib_ReturnEmail then 
				dw_Recipients.SetItem(ll_FoundRow, "rowchecked", 1)
			end if
		End If
Next

// RDT 6-01-03
If ll_Count > 0 and ib_EventContacts Then 
	Parent.Post of_UpdateContactLists ( )
End If


end event

type sle_address from singlelineedit within u_cst_shipment_notification
integer x = 23
integer y = 1808
integer width = 1915
integer height = 80
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_6 from commandbutton within u_cst_shipment_notification
integer x = 1966
integer y = 1792
integer width = 288
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add"
end type

event clicked;// RDT 3-12-03 Moved code to of_AdhocAddress()
If Parent.of_ValidAddress( sle_Address.text ) Then 
	parent.of_AdhocAddress( { sle_Address.text })
Else
	MessageBox("Add Address","Email address is not in a valid format. (name@company.xyz) ")
End if

//String ls_Find		// RDT 3-12-03 
//Long	 lla_Contacts[]
//Long	 ll_ID
//Long	 ll_FoundRow  // RDT 3-12-03 
//
//If Len( Trim( sle_address.Text ) )  > 0 Then 
//	If Parent.of_ValidAddress( sle_address.text ) Then 
//		dw_recipients.Event ue_ApplyFilter ( )
//		
//		n_cst_ContactManager		lnv_Contacts
//		MailRecipient	lnv_Recipient
//		
//		lnv_Contacts = CREATE n_cst_ContactManager
//		
//		lnv_Recipient.address = sle_address.text
//		
//		ll_ID = lnv_Contacts.of_GetContactIDForRecipient ( lnv_Recipient )
//		IF ll_ID > 0 THEN
//			lla_Contacts [ UpperBound ( lla_Contacts ) + 1 ] = ll_ID
//		END IF
//		
//		DESTROY ( lnv_Contacts ) 		
//	
//		dw_recipients.of_AddContacts ( lla_Contacts  )
//
//		// RDT 3-12-03 Find contact and set email check box to checked. 
//		ls_Find = "ct_emailaddress = '" + sle_address.text + "'"
//		ll_FoundRow = dw_Recipients.Find( ls_Find, 0,  dw_Recipients.RowCount() )
//		
//		If ll_FoundRow > 0 Then 
//			dw_Recipients.SetItem(ll_FoundRow, "rowchecked", 1)
//		End If
//		
//		sle_Address.Text = ''
//		dw_Recipients.TriggerEvent('ItemChanged')			
//		
//	Else
//		MessageBox("Add Address","Email address is not a valid format. (name@company.xyz) ")
//	End If
//	
//Else
//	MessageBox("Add Address","Please Enter an Email address")
//
//End IF
//
//sle_address.SetFocus()
end event

type st_shipstatus from statictext within u_cst_shipment_notification
integer x = 677
integer y = 1992
integer width = 1266
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = " Send Current Shipment Information to Selected Contacts:"
boolean focusrectangle = false
end type

type cb_sendnow from commandbutton within u_cst_shipment_notification
integer x = 1966
integer y = 1972
integer width = 288
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Send Now"
end type

event clicked;// RDT 4-1-03 


If ib_ReturnEmail Then							 	// RDT 4-1-03 
	Parent.TriggerEvent( 'ue_SendNow' )  		// RDT 4-1-03 
Else														// RDT 4-1-03 
	of_SendNotification ( )
End If													// RDT 4-1-03 
end event

type st_emailaddress from statictext within u_cst_shipment_notification
integer x = 32
integer y = 1744
integer width = 384
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Email Address"
boolean focusrectangle = false
end type

