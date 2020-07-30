$PBExportHeader$w_contactselect.srw
forward
global type w_contactselect from w_response
end type
type dw_contactlist from u_dw_companycontacts_list within w_contactselect
end type
type cb_addselected from u_cbok within w_contactselect
end type
type cb_cancel from u_cbcancel within w_contactselect
end type
type st_1 from statictext within w_contactselect
end type
type st_companyname from statictext within w_contactselect
end type
type cb_addressbook from commandbutton within w_contactselect
end type
type sle_address from singlelineedit within w_contactselect
end type
type cb_addaddress from commandbutton within w_contactselect
end type
end forward

global type w_contactselect from w_response
int X=91
int Y=176
int Width=4242
int Height=1196
boolean TitleBar=true
string Title="Select Contacts"
long BackColor=12632256
event ue_returnselected ( long ala_contactids[] )
dw_contactlist dw_contactlist
cb_addselected cb_addselected
cb_cancel cb_cancel
st_1 st_1
st_companyname st_companyname
cb_addressbook cb_addressbook
sle_address sle_address
cb_addaddress cb_addaddress
end type
global w_contactselect w_contactselect

type variables
PRIVATE:
n_cst_beo_Company	inv_Company
end variables

forward prototypes
private function integer wf_setcompany (n_cst_beo_company anv_company)
private function long wf_retrieve ()
end prototypes

event ue_returnselected;n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "CONTACTIDS"
lstr_Parm.ia_Value = ala_contactids[] 
lnv_Msg.of_Add_Parm ( lstr_Parm )


CloseWithReturn ( THIS , lnv_Msg ) 

end event

private function integer wf_setcompany (n_cst_beo_company anv_company);String	ls_Name

inv_Company = anv_Company

IF isValid ( inv_Company ) THEN
	st_CompanyName.Text = inv_Company.of_GetName ( ) 
END IF

THIS.wf_Retrieve ( )

RETURN 1
end function

private function long wf_retrieve ();Long	ll_Rtn

IF isValid ( inv_Company ) THEN
	dw_contactlist.SetRedraw ( FALSE ) 
	dw_contactlist.Retrieve ( { inv_Company.of_GetID ( ) } )
	dw_contactlist.SetFilter (" ct_co > 0 " )
	dw_contactlist.Filter ( )
	dw_contactlist.SetRedraw ( TRUE ) 	
END IF

RETURN ll_Rtn
end function

event open;call super::open;environment env
ib_DisableCloseQuery = TRUE

S_Parm		lstr_Parm
n_Cst_msg	lnv_Msg
lnv_Msg = message.PowerobjectParm

IF lnv_Msg.of_Get_Parm ( "COMPANY" , lstr_Parm ) <> 0 THEN
	
	THIS.wf_SetCompany ( lstr_Parm.ia_Value ) 
	
END IF

THIS.of_SetResize ( TRUE ) 
inv_Resize.of_Register ( dw_contactlist ,appeon_constant.Scaleright  )
inv_Resize.of_Register ( cb_addaddress ,appeon_constant.fixedright  )
inv_Resize.of_Register ( cb_addressbook ,appeon_constant.fixedright  )
inv_Resize.of_Register ( cb_addselected ,appeon_constant.fixedright  )
inv_Resize.of_Register ( cb_cancel ,appeon_constant.fixedright  )
inv_Resize.of_Register ( sle_address ,appeon_constant.fixedright  )


GetEnvironment(env)
If env.ScreenHeight	< 768 then 
	
	THIS.Width = 3525
	
End If
								

end event

event pfc_cancel;call super::pfc_cancel;Close ( THIS )
end event

on w_contactselect.create
int iCurrent
call super::create
this.dw_contactlist=create dw_contactlist
this.cb_addselected=create cb_addselected
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_companyname=create st_companyname
this.cb_addressbook=create cb_addressbook
this.sle_address=create sle_address
this.cb_addaddress=create cb_addaddress
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_contactlist
this.Control[iCurrent+2]=this.cb_addselected
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_companyname
this.Control[iCurrent+6]=this.cb_addressbook
this.Control[iCurrent+7]=this.sle_address
this.Control[iCurrent+8]=this.cb_addaddress
end on

on w_contactselect.destroy
call super::destroy
destroy(this.dw_contactlist)
destroy(this.cb_addselected)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_companyname)
destroy(this.cb_addressbook)
destroy(this.sle_address)
destroy(this.cb_addaddress)
end on

type dw_contactlist from u_dw_companycontacts_list within w_contactselect
int X=37
int Y=120
int Width=4155
int Height=824
int TabOrder=40
boolean BringToTop=true
end type

event constructor;call super::constructor;
THIS.SetTransObject ( SQLCA ) 
THIS.of_SetRowSelect ( TRUE )
inv_RowSelect.of_SetStyle ( appeon_constant.appeon_EXTENDED )
ib_RmbMenu = FALSE
end event

event doubleclicked;// OverRide 
Long	lla_Contacts[]
THIS.of_GetSelectedContactids ( lla_Contacts )

Parent.Event ue_ReturnSelected ( lla_Contacts )


end event

event rbuttonup;// override 
return 1
end event

type cb_addselected from u_cbok within w_contactselect
int X=1797
int Y=984
int Width=398
int TabOrder=50
boolean BringToTop=true
string Text="Add Selected"
end type

event clicked;call super::clicked;Long	lla_Contacts[]
dw_contactlist.of_GetSelectedContactids ( lla_Contacts )

Parent.Event ue_ReturnSelected ( lla_Contacts )
end event

type cb_cancel from u_cbcancel within w_contactselect
int X=2249
int Y=984
int TabOrder=60
boolean BringToTop=true
end type

type st_1 from statictext within w_contactselect
int X=50
int Y=24
int Width=325
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Contacts for "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_companyname from statictext within w_contactselect
int X=370
int Y=24
int Width=1065
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_addressbook from commandbutton within w_contactselect
int X=3721
int Y=16
int Width=471
int Height=80
int TabOrder=30
boolean BringToTop=true
string Text="Goto Address Book"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long	lla_Contacts[]
Long	ll_i
Long	ll_ID
Long	ll_Count

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

Parent.Event ue_ReturnSelected ( lla_Contacts )
end event

type sle_address from singlelineedit within w_contactselect
int X=2446
int Y=16
int Width=974
int Height=80
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_addaddress from commandbutton within w_contactselect
int X=3433
int Y=16
int Width=247
int Height=80
int TabOrder=20
boolean BringToTop=true
string Text="Add "
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long	lla_Contacts[]
Long	ll_ID


n_cst_ContactManager		lnv_Contacts
MailRecipient	lnv_Recipient

lnv_Contacts = CREATE n_cst_ContactManager

lnv_Recipient.address = sle_address.text

ll_ID = lnv_Contacts.of_GetContactIDForRecipient ( lnv_Recipient )
IF ll_ID > 0 THEN
	lla_Contacts [ UpperBound ( lla_Contacts ) + 1 ] = ll_ID
END IF

DESTROY ( lnv_Contacts ) 

IF UpperBound ( lla_Contacts ) > 0 THEN
	Parent.Event ue_ReturnSelected ( lla_Contacts )
END IF
end event

