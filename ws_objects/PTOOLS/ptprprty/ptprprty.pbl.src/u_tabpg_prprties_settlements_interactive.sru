$PBExportHeader$u_tabpg_prprties_settlements_interactive.sru
forward
global type u_tabpg_prprties_settlements_interactive from u_tabpg_prprties_settlements
end type
type uo_pointtopoint from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_interactive
end type
type uo_selectionfilter from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_interactive
end type
end forward

global type u_tabpg_prprties_settlements_interactive from u_tabpg_prprties_settlements
integer width = 1993
integer height = 1464
string text = "Interactive"
uo_pointtopoint uo_pointtopoint
uo_selectionfilter uo_selectionfilter
end type
global u_tabpg_prprties_settlements_interactive u_tabpg_prprties_settlements_interactive

type variables


end variables

on u_tabpg_prprties_settlements_interactive.create
int iCurrent
call super::create
this.uo_pointtopoint=create uo_pointtopoint
this.uo_selectionfilter=create uo_selectionfilter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_pointtopoint
this.Control[iCurrent+2]=this.uo_selectionfilter
end on

on u_tabpg_prprties_settlements_interactive.destroy
call super::destroy
destroy(this.uo_pointtopoint)
destroy(this.uo_selectionfilter)
end on

type uo_pointtopoint from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_interactive
integer x = 41
integer y = 200
integer width = 1856
integer height = 144
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PointtoPointPrompt

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_pointtopoint.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_selectionfilter from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_interactive
integer x = 41
integer y = 40
integer width = 1856
integer height = 144
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_InteractiveSelectionFilter

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_selectionfilter.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

