$PBExportHeader$u_tabpg_prprties_rating_files.sru
forward
global type u_tabpg_prprties_rating_files from u_tabpg_prprties_rating
end type
type uo_1 from u_cst_syssettings_files within u_tabpg_prprties_rating_files
end type
end forward

global type u_tabpg_prprties_rating_files from u_tabpg_prprties_rating
integer width = 2053
integer height = 1276
string text = "Files"
uo_1 uo_1
end type
global u_tabpg_prprties_rating_files u_tabpg_prprties_rating_files

on u_tabpg_prprties_rating_files.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_prprties_rating_files.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_syssettings_files within u_tabpg_prprties_rating_files
integer x = 14
integer y = 16
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PathToSavedRatesFile
event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_files::destroy
end on

