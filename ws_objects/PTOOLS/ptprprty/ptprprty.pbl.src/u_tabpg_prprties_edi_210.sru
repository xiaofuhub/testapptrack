$PBExportHeader$u_tabpg_prprties_edi_210.sru
forward
global type u_tabpg_prprties_edi_210 from u_tabpg_prprties_edi
end type
type uo_produce210 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_210
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_edi_210
end type
end forward

global type u_tabpg_prprties_edi_210 from u_tabpg_prprties_edi
integer width = 1787
string text = "210"
uo_produce210 uo_produce210
uo_1 uo_1
end type
global u_tabpg_prprties_edi_210 u_tabpg_prprties_edi_210

on u_tabpg_prprties_edi_210.create
int iCurrent
call super::create
this.uo_produce210=create uo_produce210
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_produce210
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_edi_210.destroy
call super::destroy
destroy(this.uo_produce210)
destroy(this.uo_1)
end on

type uo_produce210 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_210
integer x = 5
integer y = 304
integer width = 1769
integer height = 104
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_Produce210EDI

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_produce210.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_edi_210
integer x = 18
integer y = 28
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PathToEDI210ExportFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

