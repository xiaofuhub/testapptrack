$PBExportHeader$u_tabpg_prprties_orderentry_fuel.sru
forward
global type u_tabpg_prprties_orderentry_fuel from u_tabpg_prprties_orderentry
end type
type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_fuel
end type
type uo_billingfuelsurchargetype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_fuel
end type
type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_fuel
end type
type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_orderentry_fuel
end type
type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_orderentry_fuel
end type
end forward

global type u_tabpg_prprties_orderentry_fuel from u_tabpg_prprties_orderentry
integer width = 2153
integer height = 1232
string text = "Fuel"
uo_4 uo_4
uo_billingfuelsurchargetype uo_billingfuelsurchargetype
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_orderentry_fuel u_tabpg_prprties_orderentry_fuel

on u_tabpg_prprties_orderentry_fuel.create
int iCurrent
call super::create
this.uo_4=create uo_4
this.uo_billingfuelsurchargetype=create uo_billingfuelsurchargetype
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_4
this.Control[iCurrent+2]=this.uo_billingfuelsurchargetype
this.Control[iCurrent+3]=this.uo_3
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.uo_1
end on

on u_tabpg_prprties_orderentry_fuel.destroy
call super::destroy
destroy(this.uo_4)
destroy(this.uo_billingfuelsurchargetype)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_fuel
integer x = 55
integer y = 636
integer width = 1769
integer taborder = 50
end type

on uo_4.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_recalcFuelSurcharge

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;destroy inv_syssetting
end event

type uo_billingfuelsurchargetype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_fuel
integer x = 50
integer y = 44
integer width = 1106
integer taborder = 10
end type

on uo_billingfuelsurchargetype.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;this.of_Setddlb1Width(500)
this.of_Setst1Width(825)
this.of_Setddlb1XPos(600)

inv_syssetting = CREATE n_cst_setting_BillFuelSurchargeType

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_fuel
integer x = 55
integer y = 480
integer width = 1769
integer taborder = 40
end type

on uo_3.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AutoAddFuelSurcharge

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_orderentry_fuel
integer x = 55
integer y = 208
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CustomFuelSurchargeDesc

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_sle::destroy
end on

type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_orderentry_fuel
integer x = 1184
integer y = 44
integer width = 741
integer height = 128
integer taborder = 20
end type

event constructor;call super::constructor;this.of_SetSlexpos(8)
this.of_SetSleYPos(4)
this.of_SetSleWidth(421)
this.of_Setst1Visible(false)
this.of_Setst2Visible(false)

inv_syssetting = CREATE n_cst_setting_FuelSurcharge%Age

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

on uo_1.destroy
call u_cst_syssettings_sle::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

