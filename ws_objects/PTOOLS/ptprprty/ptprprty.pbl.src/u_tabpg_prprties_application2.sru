$PBExportHeader$u_tabpg_prprties_application2.sru
forward
global type u_tabpg_prprties_application2 from u_tabpg_prprties
end type
type cb_backup from commandbutton within u_tabpg_prprties_application2
end type
type uo_1 from u_cst_syssettings_employee_populate within u_tabpg_prprties_application2
end type
type st_1 from statictext within u_tabpg_prprties_application2
end type
type uo_systememailrecipient from u_cst_syssettings_sle within u_tabpg_prprties_application2
end type
type uo_webserviceaddress from u_cst_syssettings_sle within u_tabpg_prprties_application2
end type
type uo_dbbackuplocation from u_cst_syssettings_sle within u_tabpg_prprties_application2
end type
end forward

global type u_tabpg_prprties_application2 from u_tabpg_prprties
integer width = 1977
integer height = 1976
string text = "ASA 9+"
cb_backup cb_backup
uo_1 uo_1
st_1 st_1
uo_systememailrecipient uo_systememailrecipient
uo_webserviceaddress uo_webserviceaddress
uo_dbbackuplocation uo_dbbackuplocation
end type
global u_tabpg_prprties_application2 u_tabpg_prprties_application2

on u_tabpg_prprties_application2.create
int iCurrent
call super::create
this.cb_backup=create cb_backup
this.uo_1=create uo_1
this.st_1=create st_1
this.uo_systememailrecipient=create uo_systememailrecipient
this.uo_webserviceaddress=create uo_webserviceaddress
this.uo_dbbackuplocation=create uo_dbbackuplocation
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_backup
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_systememailrecipient
this.Control[iCurrent+5]=this.uo_webserviceaddress
this.Control[iCurrent+6]=this.uo_dbbackuplocation
end on

on u_tabpg_prprties_application2.destroy
call super::destroy
destroy(this.cb_backup)
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.uo_systememailrecipient)
destroy(this.uo_webserviceaddress)
destroy(this.uo_dbbackuplocation)
end on

type cb_backup from commandbutton within u_tabpg_prprties_application2
integer x = 1490
integer y = 284
integer width = 370
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Backup Now"
end type

event clicked;String	ls_Location

n_cst_Licensemanager		lnv_LicenseManager
n_cst_setting_DbBackupLocation	lnv_BackupLocation

lnv_BackupLocation = Create n_cst_setting_DbBackupLocation

ls_Location = lnv_BackupLocation.of_GetValue()

lnv_LicenseManager.of_BackupDatabase(ls_Location)

Destroy lnv_BackupLocation



end event

type uo_1 from u_cst_syssettings_employee_populate within u_tabpg_prprties_application2
integer y = 920
integer height = 608
integer taborder = 40
end type

on uo_1.destroy
call u_cst_syssettings_employee_populate::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_dbAlertRecipient

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event ue_deleterow;call super::ue_deleterow;Long	ll_ID
Long	ll_Uid


ll_ID = 202
ll_UID = Long ( uo_1.Dw_1.GetItemString ( al_Row, "hidden_values" ) )
uo_1.Dw_1.DeleteRow ( al_Row )
inv_syssetting.of_deleteusersetting( ll_ID , ll_Uid )

end event

type st_1 from statictext within u_tabpg_prprties_application2
integer x = 5
integer y = 24
integer width = 1925
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "The Settings on this tab page are for use with ASA version 9.0 or greater"
boolean focusrectangle = false
end type

type uo_systememailrecipient from u_cst_syssettings_sle within u_tabpg_prprties_application2
integer x = 14
integer y = 652
integer width = 1417
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_SystemEmailRecipient

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy( inv_syssetting )
end event

on uo_systememailrecipient.destroy
call u_cst_syssettings_sle::destroy
end on

type uo_webserviceaddress from u_cst_syssettings_sle within u_tabpg_prprties_application2
integer x = 14
integer y = 404
integer width = 1417
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_WebServicesAddress

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy ( inv_syssetting )
end event

on uo_webserviceaddress.destroy
call u_cst_syssettings_sle::destroy
end on

type uo_dbbackuplocation from u_cst_syssettings_sle within u_tabpg_prprties_application2
integer x = 14
integer y = 152
integer width = 1417
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_dbbackupLocation

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_dbbackuplocation.destroy
call u_cst_syssettings_sle::destroy
end on

event destructor;call super::destructor;Destroy (inv_syssetting)
end event

