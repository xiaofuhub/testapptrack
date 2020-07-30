$PBExportHeader$u_tabpg_prprties_routing_general.sru
forward
global type u_tabpg_prprties_routing_general from u_tabpg_prprties_routing
end type
type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_routing_general
end type
type uo_1 from u_cst_syssettings_poolsyards_populate within u_tabpg_prprties_routing_general
end type
end forward

global type u_tabpg_prprties_routing_general from u_tabpg_prprties_routing
integer width = 2039
integer height = 1624
string text = "General"
uo_3 uo_3
uo_1 uo_1
end type
global u_tabpg_prprties_routing_general u_tabpg_prprties_routing_general

on u_tabpg_prprties_routing_general.create
int iCurrent
call super::create
this.uo_3=create uo_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3
this.Control[iCurrent+2]=this.uo_1
end on

on u_tabpg_prprties_routing_general.destroy
call super::destroy
destroy(this.uo_3)
destroy(this.uo_1)
end on

type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_routing_general
integer x = 50
integer y = 32
integer width = 1970
integer height = 92
integer taborder = 10
end type

on uo_3.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AddRemoveStopOff

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

type uo_1 from u_cst_syssettings_poolsyards_populate within u_tabpg_prprties_routing_general
integer y = 152
integer width = 1723
integer height = 1280
integer taborder = 20
end type

on uo_1.destroy
call u_cst_syssettings_poolsyards_populate::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PoolsYards

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

