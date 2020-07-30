$PBExportHeader$u_tabpg_prprties_equipment_files.sru
forward
global type u_tabpg_prprties_equipment_files from u_tabpg_prprties_equipment
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_equipment_files
end type
end forward

global type u_tabpg_prprties_equipment_files from u_tabpg_prprties_equipment
integer width = 1842
string text = "Files"
uo_1 uo_1
end type
global u_tabpg_prprties_equipment_files u_tabpg_prprties_equipment_files

on u_tabpg_prprties_equipment_files.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_prprties_equipment_files.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_equipment_files
integer x = 14
integer y = 20
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_EquipSummViewsFolder
event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

