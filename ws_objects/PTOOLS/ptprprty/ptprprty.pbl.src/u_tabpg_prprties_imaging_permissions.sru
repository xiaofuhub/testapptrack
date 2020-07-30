$PBExportHeader$u_tabpg_prprties_imaging_permissions.sru
forward
global type u_tabpg_prprties_imaging_permissions from u_tabpg_prprties_imaging
end type
type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_imaging_permissions
end type
type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_imaging_permissions
end type
end forward

global type u_tabpg_prprties_imaging_permissions from u_tabpg_prprties_imaging
integer width = 1979
integer height = 1244
string text = "Permissions"
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_imaging_permissions u_tabpg_prprties_imaging_permissions

on u_tabpg_prprties_imaging_permissions.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_imaging_permissions.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_imaging_permissions
integer x = 37
integer y = 144
integer width = 1925
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ChangeImageGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_imaging_permissions
integer x = 37
integer y = 32
integer width = 1925
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ScanDocGroup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

