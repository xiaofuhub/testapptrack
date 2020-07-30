$PBExportHeader$w_settings.srw
forward
global type w_settings from w_response
end type
type cb_settinghelp from commandbutton within w_settings
end type
type cb_save from commandbutton within w_settings
end type
type cb_cancel from u_cbcancel within w_settings
end type
type cb_ok from u_cbok within w_settings
end type
type uo_1 from u_systemsettingsbase within w_settings
end type
end forward

global type w_settings from w_response
integer width = 3232
integer height = 1956
string title = "System Settings"
event ue_save ( )
event ue_ok ( )
cb_settinghelp cb_settinghelp
cb_save cb_save
cb_cancel cb_cancel
cb_ok cb_ok
uo_1 uo_1
end type
global w_settings w_settings

type variables
Private:
Boolean	ib_ForceClose
end variables

event ue_save();n_cst_Syssettings	lnv_Settings
lnv_Settings = CREATE n_cst_Syssettings

IF IsValid(lnv_Settings) THEN
	lnv_Settings.of_SaveSetting( )
END IF

DESTROY(lnv_Settings)
end event

event ue_ok();//ib_disableclosequery = TRUE
event ue_save( )
Close(This)
end event

on w_settings.create
int iCurrent
call super::create
this.cb_settinghelp=create cb_settinghelp
this.cb_save=create cb_save
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_settinghelp
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.uo_1
end on

on w_settings.destroy
call super::destroy
destroy(this.cb_settinghelp)
destroy(this.cb_save)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.uo_1)
end on

event open;call super::open;n_cst_privileges	lnv_Privs


// Display the window on top left
This.X = 10
This.Y = 315

ib_disableclosequery = TRUE

IF NOT lnv_Privs.of_hassysadminrights( ) THEN
	MessageBox ("System Settings" , "Only PTADMIN can edit System Settings.")
	CLOSE (THIS) 
END IF
end event

type cb_help from w_response`cb_help within w_settings
integer x = 3104
integer y = 1792
end type

type cb_settinghelp from commandbutton within w_settings
boolean visible = false
integer x = 2807
integer y = 680
integer width = 343
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Help"
end type

type cb_save from commandbutton within w_settings
integer x = 2807
integer y = 504
integer width = 343
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Save"
end type

event clicked;IF uo_1.event ue_validatecontrols( ) <> -1 THEN
	Parent.Event ue_Save()
END IF	

end event

type cb_cancel from u_cbcancel within w_settings
integer x = 2807
integer y = 324
integer width = 352
integer height = 108
integer taborder = 30
integer weight = 400
fontcharset fontcharset = ansi!
boolean cancel = false
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_ok from u_cbok within w_settings
integer x = 2807
integer y = 144
integer width = 352
integer height = 108
integer taborder = 20
integer weight = 400
fontcharset fontcharset = ansi!
boolean default = false
end type

event clicked;call super::clicked;IF uo_1.event ue_validatecontrols( ) <> - 1 THEN
	Parent.Event ue_ok()
END IF	
end event

type uo_1 from u_systemsettingsbase within w_settings
integer x = 37
integer y = 32
integer height = 1800
integer taborder = 10
end type

on uo_1.destroy
call u_systemsettingsbase::destroy
end on

