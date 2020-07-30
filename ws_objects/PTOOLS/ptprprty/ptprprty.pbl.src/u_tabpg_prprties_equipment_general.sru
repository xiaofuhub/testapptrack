$PBExportHeader$u_tabpg_prprties_equipment_general.sru
forward
global type u_tabpg_prprties_equipment_general from u_tabpg_prprties_equipment
end type
type uo_7 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
end type
type uo_6 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
end type
type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_equipment_general
end type
type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_equipment_general
end type
type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
end type
type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
end type
end forward

global type u_tabpg_prprties_equipment_general from u_tabpg_prprties_equipment
integer width = 2071
integer height = 1624
string text = "General"
uo_7 uo_7
uo_6 uo_6
uo_2 uo_2
uo_4 uo_4
uo_5 uo_5
uo_3 uo_3
uo_1 uo_1
end type
global u_tabpg_prprties_equipment_general u_tabpg_prprties_equipment_general

on u_tabpg_prprties_equipment_general.create
int iCurrent
call super::create
this.uo_7=create uo_7
this.uo_6=create uo_6
this.uo_2=create uo_2
this.uo_4=create uo_4
this.uo_5=create uo_5
this.uo_3=create uo_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_7
this.Control[iCurrent+2]=this.uo_6
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.uo_4
this.Control[iCurrent+5]=this.uo_5
this.Control[iCurrent+6]=this.uo_3
this.Control[iCurrent+7]=this.uo_1
end on

on u_tabpg_prprties_equipment_general.destroy
call super::destroy
destroy(this.uo_7)
destroy(this.uo_6)
destroy(this.uo_2)
destroy(this.uo_4)
destroy(this.uo_5)
destroy(this.uo_3)
destroy(this.uo_1)
end on

type uo_7 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
integer x = 41
integer y = 532
integer width = 1787
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ValidateCheckDigit

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_7.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_6 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
integer x = 41
integer y = 404
integer width = 1787
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_RequireCheckDigit

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_6.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_equipment_general
integer x = 41
integer y = 796
integer width = 2053
integer taborder = 50
end type

on uo_2.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AllowRelinking

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_equipment_general
integer x = 41
integer y = 668
integer width = 2053
integer taborder = 40
end type

on uo_4.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PerDiemChargesFormat

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
integer x = 41
integer y = 284
integer width = 1787
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_HolidayCntXtraFreeDay

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
integer x = 41
integer y = 172
integer width = 1787
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DeActEquipOnTerm

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_equipment_general
integer x = 41
integer y = 56
integer width = 1787
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_UnlinkedEquipment

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

