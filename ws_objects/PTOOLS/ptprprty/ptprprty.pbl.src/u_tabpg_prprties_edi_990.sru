$PBExportHeader$u_tabpg_prprties_edi_990.sru
forward
global type u_tabpg_prprties_edi_990 from u_tabpg_prprties_edi
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_990
end type
end forward

global type u_tabpg_prprties_edi_990 from u_tabpg_prprties_edi
string text = "990"
uo_1 uo_1
end type
global u_tabpg_prprties_edi_990 u_tabpg_prprties_edi_990

on u_tabpg_prprties_edi_990.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_prprties_edi_990.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_990
integer x = 27
integer y = 40
integer taborder = 10
end type

event destructor;call super::destructor;DESTROY inv_syssetting
end event

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_Produce990EDI

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

