$PBExportHeader$u_tabpg_prprties_application3.sru
forward
global type u_tabpg_prprties_application3 from u_tabpg_prprties
end type
type uo_2 from u_cst_syssettings_email_populate within u_tabpg_prprties_application3
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application3
end type
end forward

global type u_tabpg_prprties_application3 from u_tabpg_prprties
integer height = 1544
string text = "App cont."
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_application3 u_tabpg_prprties_application3

on u_tabpg_prprties_application3.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_application3.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_2 from u_cst_syssettings_email_populate within u_tabpg_prprties_application3
integer y = 204
integer taborder = 40
end type

on uo_2.destroy
call u_cst_syssettings_email_populate::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_compemailnotrecipients

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application3
integer x = 37
integer y = 112
integer width = 1765
integer taborder = 10
end type

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_SendNewCompanyEmail
event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

