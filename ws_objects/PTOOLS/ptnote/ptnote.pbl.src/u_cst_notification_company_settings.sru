$PBExportHeader$u_cst_notification_company_settings.sru
forward
global type u_cst_notification_company_settings from u_base
end type
type gb_2 from groupbox within u_cst_notification_company_settings
end type
type dw_list from u_dw_companycontacts_list within u_cst_notification_company_settings
end type
type st_5 from statictext within u_cst_notification_company_settings
end type
type gb_dest from groupbox within u_cst_notification_company_settings
end type
type gb_4 from groupbox within u_cst_notification_company_settings
end type
type gb_1 from groupbox within u_cst_notification_company_settings
end type
type st_4 from statictext within u_cst_notification_company_settings
end type
type st_2 from statictext within u_cst_notification_company_settings
end type
type rb_none from radiobutton within u_cst_notification_company_settings
end type
type rb_billto from radiobutton within u_cst_notification_company_settings
end type
type rb_any from radiobutton within u_cst_notification_company_settings
end type
type dw_images from u_dw_attachimages within u_cst_notification_company_settings
end type
type gb_3 from groupbox within u_cst_notification_company_settings
end type
type st_6 from statictext within u_cst_notification_company_settings
end type
type st_7 from statictext within u_cst_notification_company_settings
end type
type st_1 from statictext within u_cst_notification_company_settings
end type
type uo_accauthfile from u_cst_fileselection within u_cst_notification_company_settings
end type
type uo_accnotetemplate from u_cst_fileselection within u_cst_notification_company_settings
end type
type uo_eventconfirmationtemplate from u_cst_fileselection within u_cst_notification_company_settings
end type
type uo_statusrequesttemplate from u_cst_fileselection within u_cst_notification_company_settings
end type
type uo_lfdtemplate from u_cst_fileselection within u_cst_notification_company_settings
end type
type st_8 from statictext within u_cst_notification_company_settings
end type
type cb_new from commandbutton within u_cst_notification_company_settings
end type
type cb_delete from commandbutton within u_cst_notification_company_settings
end type
type sle_fullpath from u_sle within u_cst_notification_company_settings
end type
type st_3 from statictext within u_cst_notification_company_settings
end type
type uo_loadconfirmation from u_cst_fileselection within u_cst_notification_company_settings
end type
type rb_orig_none from radiobutton within u_cst_notification_company_settings
end type
type rb_orig_orig from radiobutton within u_cst_notification_company_settings
end type
type rb_orig_hmp from radiobutton within u_cst_notification_company_settings
end type
type rb_dest_none from radiobutton within u_cst_notification_company_settings
end type
type rb_dest_dest from radiobutton within u_cst_notification_company_settings
end type
type rb_dest_rdn from radiobutton within u_cst_notification_company_settings
end type
end forward

global type u_cst_notification_company_settings from u_base
integer width = 2697
integer height = 1276
long backcolor = 12632256
event ue_attachmentchanged ( )
event ue_templatechanged ( string as_template )
event ue_populate ( )
event ue_rolechanged ( string as_role )
event type n_cst_beo_company ue_getcompany ( )
event ue_changeaccnotetemplate ( )
event type integer ue_setaccnotetemplate ( string as_template )
event ue_eventdestchanged ( string as_event )
event ue_eventorigchanged ( string as_event )
gb_2 gb_2
dw_list dw_list
st_5 st_5
gb_dest gb_dest
gb_4 gb_4
gb_1 gb_1
st_4 st_4
st_2 st_2
rb_none rb_none
rb_billto rb_billto
rb_any rb_any
dw_images dw_images
gb_3 gb_3
st_6 st_6
st_7 st_7
st_1 st_1
uo_accauthfile uo_accauthfile
uo_accnotetemplate uo_accnotetemplate
uo_eventconfirmationtemplate uo_eventconfirmationtemplate
uo_statusrequesttemplate uo_statusrequesttemplate
uo_lfdtemplate uo_lfdtemplate
st_8 st_8
cb_new cb_new
cb_delete cb_delete
sle_fullpath sle_fullpath
st_3 st_3
uo_loadconfirmation uo_loadconfirmation
rb_orig_none rb_orig_none
rb_orig_orig rb_orig_orig
rb_orig_hmp rb_orig_hmp
rb_dest_none rb_dest_none
rb_dest_dest rb_dest_dest
rb_dest_rdn rb_dest_rdn
end type
global u_cst_notification_company_settings u_cst_notification_company_settings

type variables
n_cst_beo_company	inv_Company
boolean	ib_notification
Long	il_CompanyID

//dataWindow	idw_Contacts


end variables

forward prototypes
public function integer of_settemplate (string as_template)
public function integer of_filterlist (long al_Company)
public function string of_getattachmenttypes ()
public function integer of_setattachmenttypes (string asa_Types[])
public function integer of_setcompany (n_cst_beo_Company anv_Company)
public function integer of_setrole (string as_Role)
public function integer of_populate (long al_companyid)
private function integer of_hasnotification (boolean ab_value)
private function integer of_setenablement ()
public function integer of_setcontactsource (ref datastore ads_source)
public function integer of_setcompanyid (long al_ID)
protected function integer of_setaccnotetemplate (string as_template)
public function string of_getaccnotetemplate ()
public function string of_getaccauthtemplate ()
public function string of_geteventtemplate ()
public function string of_getstatusrequesttemplate ()
public function integer of_seteventdest (ref string as_event)
public function integer of_seteventorig (ref string as_event)
end prototypes

event ue_changeaccnotetemplate;String	ls_pathname
String	ls_FileName

IF GetFileOpenName ( "Accessorial Notification template", ls_pathname, ls_filename ) = 1 THEN
	of_SetAccNoteTemplate ( ls_PathName ) // this sets and formats the presentation 
	THIS.Event ue_SetAccNoteTemplate ( ls_PathName  ) // this set the value on the company beo
	
END IF
end event

event ue_setaccnotetemplate;IF isValid ( inv_Company ) THEN
	inv_Company.of_SetAccNoteTemplate ( as_Template ) 	
END IF

RETURN 1
end event

public function integer of_settemplate (string as_template);//String	ls_Template
//String	lsa_Result[]
//
//n_cst_String	lnv_String
//IF lnv_String.of_ParseToArray ( as_template , "\", lsa_Result ) > 0 THEN
//	
//	ls_Template = lsa_Result [ UpperBound ( lsa_Result ) ]
//	sle_Template.Text = ls_Template
//	
//END IF
RETURN 1

end function

public function integer of_filterlist (long al_Company);RETURN dw_list.of_FilterList ( )
end function

public function string of_getattachmenttypes ();RETURN dw_images.of_GetAttachTypes( )
end function

public function integer of_setattachmenttypes (string asa_Types[]);dw_images.of_SetAttachTypes( asa_Types[] )
RETURN 1
end function

public function integer of_setcompany (n_cst_beo_Company anv_Company);inv_Company = anv_Company
RETURN 1
end function

public function integer of_setrole (string as_Role);Int	li_Return

CHOOSE CASE as_Role
		
			
	CASE  n_cst_Constants.cs_RequestRole_Billto
		rb_Billto.checked = TRUE	
		
	CASE n_cst_Constants.cs_RequestRole_Any
		rb_Any.Checked = TRUE
		
	CASE ELSE  // none
		rb_None.Checked = TRUE
		
END CHOOSE


RETURN li_Return
end function

public function integer of_populate (long al_companyid);//dw_list.of_SetCompanyID ( al_companyid )
//dw_list.of_Populate ( )
RETURN 1
end function

private function integer of_hasnotification (boolean ab_value);ib_notification = ab_Value
RETURN 1
end function

private function integer of_setenablement ();//RDT 12-03-02 Added Accessorial & Authorization
//MFS 1/20/06 Added Events & New/Del buttons
Boolean	lb_Admin
Any		la_Value

String	ls_Value

n_cst_Settings	lnv_Settings
n_cst_Privileges	lnv_Privs

IF lnv_Settings.of_GetSetting ( 109 , la_Value ) = 1 THEN
	ls_Value = String (la_Value)
END IF


lb_Admin = lnv_Privs.of_HasAdministrativeRights (  )

rb_any.Enabled = ib_Notification AND lb_Admin
rb_billto.Enabled = ib_Notification AND lb_Admin
rb_none.Enabled =  ib_Notification AND lb_Admin

rb_orig_orig.Enabled = ib_Notification AND lb_Admin
rb_orig_hmp.Enabled = ib_Notification AND lb_Admin
rb_orig_none.Enabled = ib_Notification AND lb_Admin
rb_dest_dest.Enabled = ib_Notification AND lb_Admin
rb_dest_rdn.Enabled = ib_Notification AND lb_Admin
rb_dest_none.Enabled = ib_Notification AND lb_Admin

cb_New.Visible = ib_Notification AND lb_Admin
cb_Delete.Visible = ib_Notification AND lb_Admin


uo_eventconfirmationtemplate.of_SetEnabled ( ib_Notification AND lb_Admin AND ( ls_Value = "YES!" ) )
uo_statusrequesttemplate.of_SetEnabled ( ib_Notification AND lb_Admin )
uo_lfdtemplate.of_SetEnabled ( ib_Notification AND lb_Admin )
uo_loadconfirmation.of_SetEnabled ( ib_Notification AND lb_Admin )

//RDT 12-03-02 Code changes - Start //
//uo_tirtemplate.of_SetEnabled ( ib_Notification AND lb_Admin ) 
//uo_accauthfile.of_SetEnabled ( ib_Notification AND lb_Admin ) 	 		 		
//uo_accnotetemplate.of_SetEnabled ( ib_Notification AND lb_Admin ) 	 		 		 		 		

// get accessorial system setting
IF lnv_Settings.of_GetSetting ( 135 , la_Value ) = 1 THEN
	ls_Value = String (la_Value)
Else
	ls_Value = ""
END IF
uo_accnotetemplate.of_SetEnabled ( ib_Notification AND lb_Admin AND ( ls_Value = "YES!" ) )	

// get Authorization system setting
IF lnv_Settings.of_GetSetting ( 136 , la_Value ) = 1 THEN
	ls_Value = String (la_Value)
Else
	ls_Value = ""
END IF
uo_accauthfile.of_SetEnabled (  ib_Notification AND lb_Admin AND ( ls_Value = "YES!" ) )		

//RDT 12-03-02 Code changes - End //

//dw_images.Enabled = ib_Notification AND lb_Admin

n_cst_Presentation	lnv_Presentation
IF NOT (ib_Notification AND lb_Admin) THEN
	lnv_Presentation.of_SetEnablement( dw_Images, False)
END IF

RETURN 1
end function

public function integer of_setcontactsource (ref datastore ads_source);//RETURN adw_Source.ShareData ( dw_list )


//Blob	lblb_State
//
//DataWindow	ldw_Temp
//ldw_Temp = Create dataWindow
//ldw_Temp.Dataobject = "d_companycontact_list"
//
//ldw_Temp.Retrieve ( 1387 )
//
//
//ldw_Temp.GetFullState ( lblb_State )
//RETURN dw_list.SetFullState ( lblb_State )
dw_list.of_SetCache ( ads_source )
//idw_contacts = adw_source

RETURN 1 // dw_list.Retrieve ( 1387 )
end function

public function integer of_setcompanyid (long al_ID);il_CompanyID = al_ID
dw_list.of_SetCompanyID ( il_CompanyID ) 
RETURN 1

end function

protected function integer of_setaccnotetemplate (string as_template);//String	ls_Template
//String	lsa_Result[]
//
//n_cst_String	lnv_String
//
//
//IF lnv_String.of_ParseToArray ( as_template , "\", lsa_Result ) > 0 THEN
//	
//	ls_Template = lsa_Result [ UpperBound ( lsa_Result ) ]
//	sle_accnote.Text = ls_Template
//	
//END IF
//
RETURN 1
end function

public function string of_getaccnotetemplate ();String	ls_template


IF isValid ( inv_Company ) THEN
	ls_Template = inv_Company.of_GetAccNoteTemplate ( )
END IF

RETURN ls_Template

	
end function

public function string of_getaccauthtemplate ();String	ls_template


IF isValid ( inv_Company ) THEN
	ls_Template = inv_Company.of_GetAccAuthTemplate ( )
END IF

RETURN ls_Template

end function

public function string of_geteventtemplate ();String	ls_template


IF isValid ( inv_Company ) THEN
	ls_Template = inv_Company.of_GetEventTemplate ( )
END IF

RETURN ls_Template

end function

public function string of_getstatusrequesttemplate ();String	ls_template


IF isValid ( inv_Company ) THEN
	ls_Template = inv_Company.of_GetStatusRequestTemplate ( )
END IF

RETURN ls_Template

end function

public function integer of_seteventdest (ref string as_event);Int	li_Return

CHOOSE CASE as_event
		
			
	CASE  n_cst_constants.cs_notificatioevent_dest
		rb_dest_dest.checked = TRUE	
		
	CASE n_cst_constants.cs_notificatioevent_drn
		rb_dest_rdn.Checked = TRUE
		
	CASE ELSE  // none
		rb_dest_none.Checked = TRUE
		
END CHOOSE


RETURN li_Return

end function

public function integer of_seteventorig (ref string as_event);Int	li_Return

CHOOSE CASE as_event
		
			
	CASE  n_cst_constants.cs_notificatioevent_orig
		rb_orig_orig.checked = TRUE	
		
	CASE n_cst_constants.cs_notificatioevent_hmp
		rb_orig_hmp.Checked = TRUE
		
	CASE ELSE  // none
		rb_orig_none.Checked = TRUE
		
END CHOOSE


RETURN li_Return

end function

on u_cst_notification_company_settings.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.dw_list=create dw_list
this.st_5=create st_5
this.gb_dest=create gb_dest
this.gb_4=create gb_4
this.gb_1=create gb_1
this.st_4=create st_4
this.st_2=create st_2
this.rb_none=create rb_none
this.rb_billto=create rb_billto
this.rb_any=create rb_any
this.dw_images=create dw_images
this.gb_3=create gb_3
this.st_6=create st_6
this.st_7=create st_7
this.st_1=create st_1
this.uo_accauthfile=create uo_accauthfile
this.uo_accnotetemplate=create uo_accnotetemplate
this.uo_eventconfirmationtemplate=create uo_eventconfirmationtemplate
this.uo_statusrequesttemplate=create uo_statusrequesttemplate
this.uo_lfdtemplate=create uo_lfdtemplate
this.st_8=create st_8
this.cb_new=create cb_new
this.cb_delete=create cb_delete
this.sle_fullpath=create sle_fullpath
this.st_3=create st_3
this.uo_loadconfirmation=create uo_loadconfirmation
this.rb_orig_none=create rb_orig_none
this.rb_orig_orig=create rb_orig_orig
this.rb_orig_hmp=create rb_orig_hmp
this.rb_dest_none=create rb_dest_none
this.rb_dest_dest=create rb_dest_dest
this.rb_dest_rdn=create rb_dest_rdn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.gb_dest
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.rb_none
this.Control[iCurrent+10]=this.rb_billto
this.Control[iCurrent+11]=this.rb_any
this.Control[iCurrent+12]=this.dw_images
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.uo_accauthfile
this.Control[iCurrent+18]=this.uo_accnotetemplate
this.Control[iCurrent+19]=this.uo_eventconfirmationtemplate
this.Control[iCurrent+20]=this.uo_statusrequesttemplate
this.Control[iCurrent+21]=this.uo_lfdtemplate
this.Control[iCurrent+22]=this.st_8
this.Control[iCurrent+23]=this.cb_new
this.Control[iCurrent+24]=this.cb_delete
this.Control[iCurrent+25]=this.sle_fullpath
this.Control[iCurrent+26]=this.st_3
this.Control[iCurrent+27]=this.uo_loadconfirmation
this.Control[iCurrent+28]=this.rb_orig_none
this.Control[iCurrent+29]=this.rb_orig_orig
this.Control[iCurrent+30]=this.rb_orig_hmp
this.Control[iCurrent+31]=this.rb_dest_none
this.Control[iCurrent+32]=this.rb_dest_dest
this.Control[iCurrent+33]=this.rb_dest_rdn
end on

on u_cst_notification_company_settings.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.dw_list)
destroy(this.st_5)
destroy(this.gb_dest)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.rb_none)
destroy(this.rb_billto)
destroy(this.rb_any)
destroy(this.dw_images)
destroy(this.gb_3)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_1)
destroy(this.uo_accauthfile)
destroy(this.uo_accnotetemplate)
destroy(this.uo_eventconfirmationtemplate)
destroy(this.uo_statusrequesttemplate)
destroy(this.uo_lfdtemplate)
destroy(this.st_8)
destroy(this.cb_new)
destroy(this.cb_delete)
destroy(this.sle_fullpath)
destroy(this.st_3)
destroy(this.uo_loadconfirmation)
destroy(this.rb_orig_none)
destroy(this.rb_orig_orig)
destroy(this.rb_orig_hmp)
destroy(this.rb_dest_none)
destroy(this.rb_dest_dest)
destroy(this.rb_dest_rdn)
end on

event constructor;call super::constructor;n_cst_LicenseManager	lnv_Lic

THIS.of_HasNotification ( lnv_Lic.of_HasNotificationLicense ( ) )
THIS.of_SetEnablement ( )

dw_list.of_ShareCache ( )

inv_Company = THIS.Event ue_GetCompany ( )

end event

type gb_2 from groupbox within u_cst_notification_company_settings
integer x = 878
integer y = 1016
integer width = 901
integer height = 136
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Events"
end type

type dw_list from u_dw_companycontacts_list within u_cst_notification_company_settings
integer x = 5
integer width = 1774
integer height = 500
integer taborder = 10
boolean bringtotop = true
end type

type st_5 from statictext within u_cst_notification_company_settings
integer x = 59
integer y = 552
integer width = 1609
integer height = 52
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
string text = "Images to attach to ~'Shipment Status~' and ~'Automated Status Reply~' Emails"
boolean focusrectangle = false
end type

type gb_dest from groupbox within u_cst_notification_company_settings
integer x = 878
integer y = 1120
integer width = 901
integer height = 132
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within u_cst_notification_company_settings
integer x = 1806
integer y = 120
integer width = 859
integer height = 1124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Select the template to be used for:"
end type

type gb_1 from groupbox within u_cst_notification_company_settings
integer y = 1016
integer width = 873
integer height = 236
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_4 from statictext within u_cst_notification_company_settings
integer x = 1851
integer y = 188
integer width = 530
integer height = 60
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
string text = "Automated Status Reply"
boolean focusrectangle = false
end type

type st_2 from statictext within u_cst_notification_company_settings
integer x = 14
integer y = 1064
integer width = 837
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
string text = "Company role to be sent notifications"
boolean focusrectangle = false
end type

type rb_none from radiobutton within u_cst_notification_company_settings
integer x = 18
integer y = 1136
integer width = 215
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
string text = "Never"
boolean lefttext = true
end type

event clicked;Parent.Event ue_RoleChanged ( n_cst_constants.cs_RequestRole_None )



end event

type rb_billto from radiobutton within u_cst_notification_company_settings
integer x = 274
integer y = 1136
integer width = 206
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
string text = "Bill to"
boolean lefttext = true
end type

event clicked;Parent.Event ue_RoleChanged ( n_cst_constants.cs_RequestRole_Billto )
end event

type rb_any from radiobutton within u_cst_notification_company_settings
integer x = 553
integer y = 1136
integer width = 187
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
string text = "Any"
boolean lefttext = true
end type

event clicked;Parent.Event ue_RoleChanged ( n_cst_constants.cs_RequestRole_Any )
end event

type dw_images from u_dw_attachimages within u_cst_notification_company_settings
integer x = 32
integer y = 608
integer width = 1728
integer height = 372
integer taborder = 120
end type

event itemchanged;call super::itemchanged;Parent.Post Event ue_AttachmentChanged ( )
end event

event getfocus;call super::getfocus;THIS.Border = TRUE
THIS.borderStyle = StyleLowered!

//StyleBox!StyleRaised!StyleShadowBox!
end event

event losefocus;THIS.Border = FALSE

end event

type gb_3 from groupbox within u_cst_notification_company_settings
integer x = 5
integer y = 500
integer width = 1778
integer height = 512
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_6 from statictext within u_cst_notification_company_settings
integer x = 1851
integer y = 344
integer width = 439
integer height = 60
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
string text = "Event Confirmation"
boolean focusrectangle = false
end type

type st_7 from statictext within u_cst_notification_company_settings
integer x = 1851
integer y = 496
integer width = 366
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
string text = "Acc. Notification"
boolean focusrectangle = false
end type

type st_1 from statictext within u_cst_notification_company_settings
integer x = 1851
integer y = 648
integer width = 402
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
string text = "Acc. Authorization"
boolean focusrectangle = false
end type

type uo_accauthfile from u_cst_fileselection within u_cst_notification_company_settings
integer x = 1851
integer y = 700
integer taborder = 100
boolean bringtotop = true
long backcolor = 12632256
end type

on uo_accauthfile.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;IF IsValid ( inv_Company ) THEN
	inv_Company.of_SetAccAuthTemplate ( as_path )
END IF

RETURN 1

end event

event constructor;call super::constructor;String	ls_Template
This.of_SetProtected(TRUE)  // RDT 3-5-03

ls_Template = Parent.of_GetAccAuthTemplate ( ) 

THIS.Event ue_SetFileFromPath ( ls_Template )

end event

event ue_slegetfocus;
sle_fullpath.text = Parent.of_GetAccAuthTemplate() // RDT 12-19-02


end event

type uo_accnotetemplate from u_cst_fileselection within u_cst_notification_company_settings
event destroy ( )
integer x = 1851
integer y = 548
integer taborder = 90
boolean bringtotop = true
long backcolor = 12632256
end type

on uo_accnotetemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;IF IsValid ( inv_company ) THEN
	inv_Company.of_SetAccNoteTemplate ( as_path )	
END IF

RETURN 1
end event

event constructor;call super::constructor;String	ls_Template
This.of_SetProtected(TRUE)  // RDT 3-5-03

ls_Template = Parent.of_GetAccNoteTemplate ( ) 

THIS.Event ue_SetFileFromPath ( ls_Template )

end event

event ue_slegetfocus;
sle_fullpath.text = Parent.of_GetAccNoteTemplate() // RDT 12-19-02


end event

type uo_eventconfirmationtemplate from u_cst_fileselection within u_cst_notification_company_settings
event destroy ( )
integer x = 1851
integer y = 396
integer taborder = 80
boolean bringtotop = true
long backcolor = 12632256
end type

on uo_eventconfirmationtemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;IF IsValid ( inv_company ) THEN
	inv_Company.of_SetEventTemplate ( as_path )	
END IF

RETURN 1
end event

event constructor;call super::constructor;Any		la_Value
String	ls_Value
String	ls_Template
n_cst_Settings	lnv_Settings

IF lnv_Settings.of_GetSetting ( 109 , la_Value ) = 1 THEN
	ls_Value = String (la_Value)
END IF

This.of_SetProtected(TRUE)  // RDT 3-5-03	

IF ls_Value = "YES!" THEN
	
	ls_Template = Parent.of_GetEventTemplate ( ) 
	
	THIS.Event ue_SetFileFromPath ( ls_Template )

END IF
end event

event ue_slegetfocus;
sle_fullpath.text = Parent.of_GetEventTemplate() // RDT 12-19-02
end event

type uo_statusrequesttemplate from u_cst_fileselection within u_cst_notification_company_settings
event destroy ( )
integer x = 1851
integer y = 244
integer taborder = 70
boolean bringtotop = true
long backcolor = 12632256
end type

on uo_statusrequesttemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;IF IsValid ( inv_company ) THEN
	inv_Company.of_SetStatusRequestTemplate ( as_path )	
END IF

RETURN 1
end event

event constructor;call super::constructor;//String	ls_Template
//
//ls_Template = Parent.of_GetStatusRequestTemplate ( ) 
//
//THIS.Event ue_SetFileFromPath ( ls_Template )
//

//

String	ls_template

This.of_SetProtected(TRUE)  // RDT 3-5-03

IF isValid ( inv_Company ) THEN
	ls_Template = inv_Company.of_GetStatusRequestTemplate ( )
END IF
THIS.Event ue_SetFileFromPath ( ls_Template )
//RETURN ls_Template

end event

event ue_slegetfocus;
sle_fullpath.text = Parent.of_GetStatusRequestTemplate() // RDT 12-19-02


end event

type uo_lfdtemplate from u_cst_fileselection within u_cst_notification_company_settings
integer x = 1851
integer y = 852
integer taborder = 110
boolean bringtotop = true
long backcolor = 12632256
end type

on uo_lfdtemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;IF IsValid ( inv_company ) THEN
	inv_Company.of_SetLastFreeDateTemplate ( as_path )	
END IF

RETURN 1
end event

event constructor;call super::constructor;String	ls_template
This.of_SetProtected(TRUE)  // RDT 3-5-03

IF isValid ( inv_Company ) THEN
	ls_Template = inv_Company.of_GetLastFreeDateTemplate ( )
END IF
	
THIS.Event ue_SetFileFromPath ( ls_Template )

end event

event ue_slegetfocus;
sle_fullpath.text = inv_Company.of_GetLastFreeDateTemplate ( )// RDT 12-19-02

end event

type st_8 from statictext within u_cst_notification_company_settings
integer x = 1851
integer y = 804
integer width = 517
integer height = 48
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
string text = "LFD Notification"
boolean focusrectangle = false
end type

type cb_new from commandbutton within u_cst_notification_company_settings
integer x = 1815
integer y = 20
integer width = 233
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "New"
end type

event clicked;dw_list.Event ue_NewContact ( )
end event

type cb_delete from commandbutton within u_cst_notification_company_settings
integer x = 2085
integer y = 20
integer width = 233
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete"
end type

event clicked;dw_list.Event ue_deleteContact ( dw_list.GetRow  ( )  )
end event

type sle_fullpath from u_sle within u_cst_notification_company_settings
integer x = 1851
integer y = 1132
integer width = 773
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long textcolor = 33554432
long backcolor = 12632256
boolean autohscroll = true
textcase textcase = anycase!
boolean displayonly = true
end type

type st_3 from statictext within u_cst_notification_company_settings
integer x = 1851
integer y = 948
integer width = 517
integer height = 52
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
string text = "Shipment Status"
boolean focusrectangle = false
end type

type uo_loadconfirmation from u_cst_fileselection within u_cst_notification_company_settings
integer x = 1851
integer y = 1004
integer taborder = 130
boolean bringtotop = true
long backcolor = 12632256
end type

event ue_slegetfocus;sle_fullpath.text = inv_Company.of_GetLoadConfirmationTemplate ( )
end event

event constructor;call super::constructor;String	ls_template
This.of_SetProtected(TRUE)  // RDT 3-5-03

IF isValid ( inv_Company ) THEN
	ls_Template = inv_Company.of_GetLoadConfirmationTemplate ( )
END IF
	
THIS.Event ue_SetFileFromPath ( ls_Template )
end event

event ue_filechanged;IF IsValid ( inv_company ) THEN
	inv_Company.of_SetLoadConfirmationTemplate ( as_path )	
END IF

RETURN 1
end event

on uo_loadconfirmation.destroy
call u_cst_fileselection::destroy
end on

type rb_orig_none from radiobutton within u_cst_notification_company_settings
integer x = 1527
integer y = 1068
integer width = 219
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
string text = "None"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;Parent.Event ue_eventorigchanged ( "none" )
end event

type rb_orig_orig from radiobutton within u_cst_notification_company_settings
integer x = 910
integer y = 1068
integer width = 229
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
string text = "Origin"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;Parent.Event ue_eventorigchanged ( n_cst_constants.cs_NotificatioEvent_Orig )

end event

type rb_orig_hmp from radiobutton within u_cst_notification_company_settings
integer x = 1170
integer y = 1068
integer width = 325
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
string text = "Hk/Mt/Pu"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;Parent.Event ue_eventorigchanged ( n_cst_constants.cs_NotificatioEvent_HMP )

end event

type rb_dest_none from radiobutton within u_cst_notification_company_settings
integer x = 1527
integer y = 1160
integer width = 219
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
string text = "None"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;Parent.Event ue_eventDestChanged  ( "none" )
end event

type rb_dest_dest from radiobutton within u_cst_notification_company_settings
integer x = 910
integer y = 1160
integer width = 229
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
string text = "Dest."
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;Parent.Event ue_eventDestChanged ( n_cst_constants.cs_NotificatioEvent_Dest )

end event

type rb_dest_rdn from radiobutton within u_cst_notification_company_settings
integer x = 1170
integer y = 1160
integer width = 325
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
string text = "Dr/Dl/Ds"
boolean lefttext = true
boolean righttoleft = true
end type

event clicked;Parent.Event ue_eventDestChanged  ( n_cst_constants.cs_NotificatioEvent_DRN )

end event

