$PBExportHeader$u_tabpg_prprties_edi_214.sru
forward
global type u_tabpg_prprties_edi_214 from u_tabpg_prprties_edi
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_214
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_edi_214
end type
end forward

global type u_tabpg_prprties_edi_214 from u_tabpg_prprties_edi
integer width = 1906
string text = "214"
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_edi_214 u_tabpg_prprties_edi_214

on u_tabpg_prprties_edi_214.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_edi_214.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_214
integer x = 23
integer y = 272
integer width = 1719
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_Produce214EDI

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_edi_214
integer x = 23
integer y = 12
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PathToEdi214ExportFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

