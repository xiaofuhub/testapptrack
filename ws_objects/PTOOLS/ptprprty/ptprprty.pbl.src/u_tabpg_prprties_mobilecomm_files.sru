$PBExportHeader$u_tabpg_prprties_mobilecomm_files.sru
forward
global type u_tabpg_prprties_mobilecomm_files from u_tabpg_prprties_mobilecomm
end type
type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_mobilecomm_files
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_mobilecomm_files
end type
end forward

global type u_tabpg_prprties_mobilecomm_files from u_tabpg_prprties_mobilecomm
integer width = 1774
integer height = 1424
string text = "Files"
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_mobilecomm_files u_tabpg_prprties_mobilecomm_files

on u_tabpg_prprties_mobilecomm_files.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_mobilecomm_files.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_mobilecomm_files
integer x = 73
integer y = 244
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_TemplatesPathFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_mobilecomm_files
integer x = 73
integer y = 8
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_QualCommPathFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

