$PBExportHeader$u_tabpg_prprties_imaging_files.sru
forward
global type u_tabpg_prprties_imaging_files from u_tabpg_prprties_imaging
end type
type uo_imgtmp from u_cst_syssettings_folders within u_tabpg_prprties_imaging_files
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_imaging_files
end type
end forward

global type u_tabpg_prprties_imaging_files from u_tabpg_prprties_imaging
integer width = 1961
integer height = 1248
string text = "Files"
uo_imgtmp uo_imgtmp
uo_1 uo_1
end type
global u_tabpg_prprties_imaging_files u_tabpg_prprties_imaging_files

on u_tabpg_prprties_imaging_files.create
int iCurrent
call super::create
this.uo_imgtmp=create uo_imgtmp
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_imgtmp
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_imaging_files.destroy
call super::destroy
destroy(this.uo_imgtmp)
destroy(this.uo_1)
end on

type uo_imgtmp from u_cst_syssettings_folders within u_tabpg_prprties_imaging_files
integer x = 32
integer y = 236
integer width = 1751
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_imagingscanpathunnassigned

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_imgtmp.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_imaging_files
integer x = 23
integer y = 8
integer width = 1751
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ImagingRootPathFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

