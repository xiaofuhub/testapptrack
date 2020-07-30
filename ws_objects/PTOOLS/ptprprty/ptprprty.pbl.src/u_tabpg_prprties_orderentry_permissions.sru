$PBExportHeader$u_tabpg_prprties_orderentry_permissions.sru
forward
global type u_tabpg_prprties_orderentry_permissions from u_tabpg_prprties_orderentry
end type
type uo_6 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
end type
type uo_5 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
end type
type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
end type
type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
end type
type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
end type
type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
end type
end forward

global type u_tabpg_prprties_orderentry_permissions from u_tabpg_prprties_orderentry
integer width = 2034
integer height = 1436
string text = "Permissions"
uo_6 uo_6
uo_5 uo_5
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_orderentry_permissions u_tabpg_prprties_orderentry_permissions

type variables

end variables

on u_tabpg_prprties_orderentry_permissions.create
int iCurrent
call super::create
this.uo_6=create uo_6
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_6
this.Control[iCurrent+2]=this.uo_5
this.Control[iCurrent+3]=this.uo_4
this.Control[iCurrent+4]=this.uo_3
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.uo_1
end on

on u_tabpg_prprties_orderentry_permissions.destroy
call super::destroy
destroy(this.uo_6)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_6 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
integer x = 55
integer y = 536
integer width = 1897
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ModFreightRateInfoGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_6.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_5 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
integer x = 55
integer y = 660
integer width = 1897
integer taborder = 60
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ModAccessRateInfoGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
integer x = 55
integer y = 412
integer width = 1906
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ConvertNonRoutedGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
integer x = 55
integer y = 288
integer width = 1906
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DeleteShipmentGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
integer x = 55
integer y = 164
integer width = 1906
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CancelShipmentGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_permissions
integer x = 55
integer y = 36
integer width = 1906
integer taborder = 10
end type

on uo_1.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ShipSalesTotGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

