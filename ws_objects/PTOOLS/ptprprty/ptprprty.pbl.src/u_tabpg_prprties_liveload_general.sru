$PBExportHeader$u_tabpg_prprties_liveload_general.sru
forward
global type u_tabpg_prprties_liveload_general from u_tabpg_prprties_liveload
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_liveload_general
end type
end forward

global type u_tabpg_prprties_liveload_general from u_tabpg_prprties_liveload
integer width = 1952
integer height = 1212
string text = "General"
uo_1 uo_1
end type
global u_tabpg_prprties_liveload_general u_tabpg_prprties_liveload_general

on u_tabpg_prprties_liveload_general.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_prprties_liveload_general.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_liveload_general
integer x = 5
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_LiveLoadFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

