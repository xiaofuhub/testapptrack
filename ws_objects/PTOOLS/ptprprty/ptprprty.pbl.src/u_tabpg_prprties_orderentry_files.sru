$PBExportHeader$u_tabpg_prprties_orderentry_files.sru
forward
global type u_tabpg_prprties_orderentry_files from u_tabpg_prprties_orderentry
end type
type uo_3 from u_cst_syssettings_files within u_tabpg_prprties_orderentry_files
end type
type uo_2 from u_cst_syssettings_files within u_tabpg_prprties_orderentry_files
end type
type uo_multishipmentupdate from u_cst_syssettings_files within u_tabpg_prprties_orderentry_files
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_orderentry_files
end type
end forward

global type u_tabpg_prprties_orderentry_files from u_tabpg_prprties_orderentry
integer width = 1957
integer height = 1792
string text = "Files"
uo_3 uo_3
uo_2 uo_2
uo_multishipmentupdate uo_multishipmentupdate
uo_1 uo_1
end type
global u_tabpg_prprties_orderentry_files u_tabpg_prprties_orderentry_files

type variables

end variables

on u_tabpg_prprties_orderentry_files.create
int iCurrent
call super::create
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_multishipmentupdate=create uo_multishipmentupdate
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_multishipmentupdate
this.Control[iCurrent+4]=this.uo_1
end on

on u_tabpg_prprties_orderentry_files.destroy
call super::destroy
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_multishipmentupdate)
destroy(this.uo_1)
end on

type uo_3 from u_cst_syssettings_files within u_tabpg_prprties_orderentry_files
integer x = 165
integer y = 932
integer width = 1623
integer taborder = 13
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PathToSavedRatesFile
event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_files::destroy
end on

type uo_2 from u_cst_syssettings_files within u_tabpg_prprties_orderentry_files
integer x = 165
integer y = 620
integer width = 1623
integer taborder = 12
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_RateConfirmTemplate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_files::destroy
end on

type uo_multishipmentupdate from u_cst_syssettings_files within u_tabpg_prprties_orderentry_files
integer x = 165
integer y = 308
integer width = 1623
integer taborder = 11
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_MultiShipmentUpdate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_multishipmentupdate.destroy
call u_cst_syssettings_files::destroy
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_orderentry_files
integer x = 165
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CachePathFilesFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

