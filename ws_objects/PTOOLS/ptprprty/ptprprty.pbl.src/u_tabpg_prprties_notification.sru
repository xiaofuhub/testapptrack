$PBExportHeader$u_tabpg_prprties_notification.sru
forward
global type u_tabpg_prprties_notification from u_tabpg_prprties
end type
type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_notification
end type
type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_notification
end type
end forward

global type u_tabpg_prprties_notification from u_tabpg_prprties
integer width = 2322
integer height = 1132
string text = "General"
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_notification u_tabpg_prprties_notification

on u_tabpg_prprties_notification.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_notification.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_notification
integer x = 18
integer y = 176
integer width = 1751
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ImagingRootPathFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_notification
integer x = 23
integer y = 20
integer width = 2043
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_SendTIRLFDGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

