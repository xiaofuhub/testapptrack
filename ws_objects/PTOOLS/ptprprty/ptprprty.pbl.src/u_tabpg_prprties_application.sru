$PBExportHeader$u_tabpg_prprties_application.sru
forward
global type u_tabpg_prprties_application from u_tabpg_prprties
end type
type uo_toplevelfolder from u_cst_syssettings_folders within u_tabpg_prprties_application
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application
end type
type uo_ptmultipleinstancesallowed from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application
end type
type uo_templatespathfolder from u_cst_syssettings_folders within u_tabpg_prprties_application
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application
end type
end forward

global type u_tabpg_prprties_application from u_tabpg_prprties
integer width = 2025
integer height = 1596
string text = "General"
uo_toplevelfolder uo_toplevelfolder
uo_2 uo_2
uo_ptmultipleinstancesallowed uo_ptmultipleinstancesallowed
uo_templatespathfolder uo_templatespathfolder
uo_1 uo_1
end type
global u_tabpg_prprties_application u_tabpg_prprties_application

type variables

end variables

on u_tabpg_prprties_application.create
int iCurrent
call super::create
this.uo_toplevelfolder=create uo_toplevelfolder
this.uo_2=create uo_2
this.uo_ptmultipleinstancesallowed=create uo_ptmultipleinstancesallowed
this.uo_templatespathfolder=create uo_templatespathfolder
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_toplevelfolder
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_ptmultipleinstancesallowed
this.Control[iCurrent+4]=this.uo_templatespathfolder
this.Control[iCurrent+5]=this.uo_1
end on

on u_tabpg_prprties_application.destroy
call super::destroy
destroy(this.uo_toplevelfolder)
destroy(this.uo_2)
destroy(this.uo_ptmultipleinstancesallowed)
destroy(this.uo_templatespathfolder)
destroy(this.uo_1)
end on

type uo_toplevelfolder from u_cst_syssettings_folders within u_tabpg_prprties_application
boolean visible = false
integer y = 1152
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_TopLevelFolderForIOFiles

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_toplevelfolder.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application
integer y = 300
integer width = 1774
integer height = 116
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ShowPrintDialog

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_ptmultipleinstancesallowed from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application
integer y = 168
integer width = 1774
integer height = 116
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ptmultipleinstancesallowed

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_ptmultipleinstancesallowed.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

type uo_templatespathfolder from u_cst_syssettings_folders within u_tabpg_prprties_application
integer x = 5
integer y = 424
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_TemplatesPathFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_templatespathfolder.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_application
integer y = 36
integer width = 1774
integer height = 116
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_confirmexit

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

