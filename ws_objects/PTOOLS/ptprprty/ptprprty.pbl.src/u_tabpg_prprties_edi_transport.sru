$PBExportHeader$u_tabpg_prprties_edi_transport.sru
forward
global type u_tabpg_prprties_edi_transport from u_tabpg_prprties_edi
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_transport
end type
end forward

global type u_tabpg_prprties_edi_transport from u_tabpg_prprties_edi
string text = "Transport"
uo_1 uo_1
end type
global u_tabpg_prprties_edi_transport u_tabpg_prprties_edi_transport

on u_tabpg_prprties_edi_transport.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_prprties_edi_transport.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_transport
integer x = 23
integer y = 36
integer width = 1934
integer taborder = 10
end type

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_editransport

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;destroy inv_syssetting
end event

