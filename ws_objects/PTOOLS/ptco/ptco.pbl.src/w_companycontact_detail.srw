$PBExportHeader$w_companycontact_detail.srw
forward
global type w_companycontact_detail from w_response
end type
type cb_ok from u_cbok within w_companycontact_detail
end type
type gb_1 from groupbox within w_companycontact_detail
end type
type st_1 from statictext within w_companycontact_detail
end type
type dw_details from u_dw_companycontact_detail within w_companycontact_detail
end type
end forward

global type w_companycontact_detail from w_response
integer x = 974
integer y = 576
integer width = 1710
integer height = 1380
string title = "Contact Information"
long backcolor = 12632256
cb_ok cb_ok
gb_1 gb_1
st_1 st_1
dw_details dw_details
end type
global w_companycontact_detail w_companycontact_detail

type variables
Long	il_ID
Long	il_CompanyID

Boolean	ib_Update = TRUE
String	is_Context

DataStore	ids_ContactCache
n_cst_Msg	inv_Msg

Long		il_Row

Boolean		ib_StopRowChange 


end variables

forward prototypes
private function integer wf_newcontact ()
private function integer wf_retrievecontact (long al_id)
private function integer wf_details ()
private function integer wf_validate ()
private function boolean wf_notificationchecked ()
end prototypes

private function integer wf_newcontact ();Int		li_Return
Long		ll_NewRow
Long		ll_CompanyID 
S_Parm	lstr_parm


IF inv_Msg.of_Get_Parm ( "COMPANYID" , lstr_Parm ) <> 0 THEN
	ll_CompanyID =  lstr_Parm.ia_Value 
	dw_details.of_SetCoID ( ll_CompanyID ) 
END IF

IF inv_Msg.of_Get_Parm ( "CACHE" , lstr_Parm ) <> 0 THEN

	ids_ContactCache = lstr_Parm.ia_Value
	ib_Update = FALSE
	ll_NewRow = dw_details.InsertRow ( 0 )

	IF ll_NewRow > 0 THEN
		dw_details.SetItem ( ll_NewRow , "ct_status" , appeon_constant.cs_status_Active )
		dw_details.SetItem ( ll_NewRow , "ct_co" , ll_CompanyID )
	END IF
	
END IF

RETURN li_Return
end function

private function integer wf_retrievecontact (long al_id);RETURN dw_details.Retrieve ( {al_ID} )


end function

private function integer wf_details ();Long		ll_Find
Int		li_Return = 1
Boolean	lb_Editable = TRUE
S_Parm	lstr_parm

IF inv_msg.of_Get_Parm ( "EDITABLE" , lstr_Parm ) <> 0 THEN	
	lb_Editable = lstr_Parm.ia_Value
END IF

dw_details.Enabled = lb_Editable

IF inv_Msg.of_Get_Parm ( "CACHE" , lstr_Parm ) <> 0 THEN

	ids_ContactCache = lstr_Parm.ia_Value
	ids_ContactCache.ShareData ( dw_details ) 
	ib_Update = FALSE
	
	IF inv_msg.of_Get_Parm ( "ID" , lstr_Parm ) <> 0 THEN	
		ll_Find = ids_ContactCache.Find ( "ct_id = " + String ( lstr_Parm.ia_value ) , 1, ids_ContactCache.RowCount ( ) ) 
		IF ll_Find > 0 THEN
			il_Row = ll_Find 
		END IF
	END IF	
	
	IF il_Row = 0 THEN
		IF inv_msg.of_Get_Parm ( "ROW" , lstr_Parm ) <> 0 THEN	
			il_Row = lstr_Parm.ia_Value
		END IF
	END IF
	
	IF il_Row > 0 THEN
		
		dw_details.ScrollToRow ( il_Row ) 

		ib_StopRowChange = TRUE 		
		
	END IF

END IF

RETURN li_Return 
end function

private function integer wf_validate ();// RDT 7-18-03 Added checks for email address
Int	li_Return = 1

String	ls_Firstname, &
			ls_EmailAddress

IF li_Return = 1 THEN
	IF dw_details.AcceptText ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	
	IF NOT dw_Details.RowCount ( ) > 0 THEN
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN

	ls_FirstName = dw_Details.getItemString ( 1, "ct_fn" )
	
	IF IsNull ( ls_FirstName ) THEN
		li_Return = -1
		MessageBox ( "Contact Details" , "Please provide a first name." )
	END IF
	
	// RDT 7-18-03 - start
	If this.wf_NotificationChecked() then 

		// look for an address
		ls_EmailAddress = dw_details.GetItemString( 1, "ct_EmailAddress")

		if IsNull( ls_EmailAddress ) or Len( Trim( ls_EmailAddress) ) < 1 then 
			li_Return = -1
			MessageBox ( "Contact Details" , "At least one notify topic is checked, but there is no email address." )
		end If
		
	End If
	// RDT 7-18-03 - End 
	
END IF



RETURN li_Return

end function

private function boolean wf_notificationchecked ();//
/***************************************************************************************
NAME			: wf_NotificationChecked
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Boolen
DESCRIPTION	: Looks for at least one notification checked

REVISION		: RDT 7-18-03
***************************************************************************************/
Boolean  lb_Return = FALSE

String	lsa_Column[]

Integer	i, &
			li_ColCount

// Load Columns
li_ColCount ++
lsa_Column[ li_ColCount ] = "ct_notifyonshipment"

li_ColCount ++
lsa_Column[ li_ColCount ] = "ct_notifyonevent"

li_ColCount ++
lsa_Column[ li_ColCount ] = "ct_notifyonaccnote"

li_ColCount ++
lsa_Column[ li_ColCount ] = "ct_notifyonlfd"

li_ColCount ++
lsa_Column[ li_ColCount ] = "ct_notifyonaccauth"

li_ColCount ++
lsa_Column[ li_ColCount ] = "ct_notifyontir"

For i = 1 to li_ColCount 
	If dw_details.GetItemNumber( 1, lsa_column[i] ) = 1 then 
		lb_Return = TRUE
		exit
	End If

Next

Return lb_Return
end function

on w_companycontact_detail.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.st_1=create st_1
this.dw_details=create dw_details
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_details
end on

on w_companycontact_detail.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.dw_details)
end on

event open;call super::open;ib_DisableCloseQuery = TRUE 
dw_details.SetTransObject ( SQLCA )


CHOOSE CASE UPPER ( is_Context )
		
	CASE "NEW"
		THIS.wf_NewContact ( ) 
		
	CASE "DETAILS"
		THIS.wf_Details ( )
		
END CHOOSE

end event

event pfc_cancel;call super::pfc_cancel;CLOSE ( THIS )
end event

event pfc_default;Int	li_Return = 1
Long	ll_NewID

n_Cst_bso_Notification_manager	lnv_Manager
lnv_Manager = Create n_Cst_bso_Notification_manager

IF li_Return = 1 THEN
	
	IF THIS.wf_Validate () <> 1 THEN
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	
	IF ib_Update THEN
	
		IF dw_details.of_Update ( ) <> 1 THEN
			MessageBox ( "Contact Details" , "Changes could not be saved." )
		END IF
		
	ELSE
		
		IF isValid ( ids_ContactCache ) AND is_Context = "NEW" THEN
				
		   dw_details.RowsCopy ( 1,1 , Primary!, ids_ContactCache ,999,PRIMARY! )
			
		END IF	
		
	END IF
	
	DESTROY ( lnv_Manager )
	
	CLOSE ( THIS )
	
END IF
end event

type cb_help from w_response`cb_help within w_companycontact_detail
integer x = 1609
integer y = 1044
end type

type cb_ok from u_cbok within w_companycontact_detail
integer x = 1376
integer y = 1056
integer width = 233
integer taborder = 20
boolean bringtotop = true
string text = "Close"
end type

type gb_1 from groupbox within w_companycontact_detail
integer x = 41
integer y = 92
integer width = 1600
integer height = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_1 from statictext within w_companycontact_detail
integer x = 59
integer y = 40
integer width = 1563
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Enter information about this contact here."
boolean focusrectangle = false
end type

type dw_details from u_dw_companycontact_detail within w_companycontact_detail
integer x = 32
integer y = 148
integer width = 1623
integer taborder = 10
end type

event constructor;call super::constructor;
S_parm		lstr_Parm


inv_Msg = Message.PowerObjectParm

IF inv_Msg.of_Get_Parm ( "CONTEXT" , lstr_Parm ) <> 0 THEN
	is_Context = lstr_Parm.ia_Value
END IF

n_cst_LicenseManager 	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_HasNotificationLicense() THEN
	This.of_SetEnableNotifyDefaults(False)
END IF



end event

event itemfocuschanged;call super::itemfocuschanged;//IF dwo.name = "ct_emailaddress"  THEN
//	cb_ok.SetFocus ( ) 	
//END IF
end event

event rowfocuschanging;call super::rowfocuschanging;/*
	this is used b/c the data is shared with the cache and tabing around the dw will cause the row displayed to change
	which is what we don't want

*/
Long	ll_Return

ll_Return = AncestorReturnValue 

IF ll_Return = 0 THEN

	IF ib_StopRowChange THEN
		cb_ok.Post SetFocus ( )
		THIS.ScrollToRow ( currentrow )
		ll_Return = 1
	END IF
END IF

RETURN ll_Return

end event

