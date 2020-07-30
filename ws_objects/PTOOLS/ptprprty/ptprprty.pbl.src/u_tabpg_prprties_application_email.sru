$PBExportHeader$u_tabpg_prprties_application_email.sru
forward
global type u_tabpg_prprties_application_email from u_tabpg_prprties
end type
type uo_authpwd from u_cst_syssettings_sle_pwd within u_tabpg_prprties_application_email
end type
type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_application_email
end type
type uo_smtpserver from u_cst_syssettings_sle within u_tabpg_prprties_application_email
end type
type uo_replya from u_cst_syssettings_sle within u_tabpg_prprties_application_email
end type
type gb_1 from groupbox within u_tabpg_prprties_application_email
end type
end forward

global type u_tabpg_prprties_application_email from u_tabpg_prprties
integer width = 1977
string text = "Email"
uo_authpwd uo_authpwd
uo_2 uo_2
uo_smtpserver uo_smtpserver
uo_replya uo_replya
gb_1 gb_1
end type
global u_tabpg_prprties_application_email u_tabpg_prprties_application_email

on u_tabpg_prprties_application_email.create
int iCurrent
call super::create
this.uo_authpwd=create uo_authpwd
this.uo_2=create uo_2
this.uo_smtpserver=create uo_smtpserver
this.uo_replya=create uo_replya
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_authpwd
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_smtpserver
this.Control[iCurrent+4]=this.uo_replya
this.Control[iCurrent+5]=this.gb_1
end on

on u_tabpg_prprties_application_email.destroy
call super::destroy
destroy(this.uo_authpwd)
destroy(this.uo_2)
destroy(this.uo_smtpserver)
destroy(this.uo_replya)
destroy(this.gb_1)
end on

type uo_authpwd from u_cst_syssettings_sle_pwd within u_tabpg_prprties_application_email
integer x = 50
integer y = 848
integer width = 1486
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_mailauthpassword

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_authpwd.destroy
call u_cst_syssettings_sle_pwd::destroy
end on

type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_application_email
integer x = 55
integer y = 612
integer width = 1486
integer height = 244
integer taborder = 30
end type

event constructor;call super::constructor;

inv_syssetting = CREATE n_cst_setting_mailauthname

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_sle::destroy
end on

type uo_smtpserver from u_cst_syssettings_sle within u_tabpg_prprties_application_email
integer x = 55
integer y = 8
integer width = 1417
integer height = 228
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_SmtpServer

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy( inv_syssetting )
end event

on uo_smtpserver.destroy
call u_cst_syssettings_sle::destroy
end on

type uo_replya from u_cst_syssettings_sle within u_tabpg_prprties_application_email
integer x = 55
integer y = 236
integer width = 1417
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_replyemailaddress

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy (inv_syssetting)
end event

on uo_replya.destroy
call u_cst_syssettings_sle::destroy
end on

type gb_1 from groupbox within u_tabpg_prprties_application_email
integer x = 41
integer y = 540
integer width = 1824
integer height = 600
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "These are only needed if your mail server requires authentication."
end type

