$PBExportHeader$u_tabpg_prprties_equipment_permissions.sru
forward
global type u_tabpg_prprties_equipment_permissions from u_tabpg_prprties_equipment
end type
type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_equipment_permissions
end type
end forward

global type u_tabpg_prprties_equipment_permissions from u_tabpg_prprties_equipment
integer width = 2071
integer height = 1256
string text = "Permissions"
uo_1 uo_1
end type
global u_tabpg_prprties_equipment_permissions u_tabpg_prprties_equipment_permissions

on u_tabpg_prprties_equipment_permissions.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_prprties_equipment_permissions.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_equipment_permissions
integer x = 32
integer y = 28
integer width = 1957
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_TerminateEquipGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

on uo_1.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

