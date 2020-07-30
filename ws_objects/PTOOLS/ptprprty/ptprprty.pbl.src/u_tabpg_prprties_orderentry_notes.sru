$PBExportHeader$u_tabpg_prprties_orderentry_notes.sru
forward
global type u_tabpg_prprties_orderentry_notes from u_tabpg_prprties_orderentry
end type
type uo_2 from u_cst_syssettings_generic_populate within u_tabpg_prprties_orderentry_notes
end type
type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_notes
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_notes
end type
end forward

global type u_tabpg_prprties_orderentry_notes from u_tabpg_prprties_orderentry
integer width = 1989
integer height = 1584
string text = "Notes"
uo_2 uo_2
uo_3 uo_3
uo_1 uo_1
end type
global u_tabpg_prprties_orderentry_notes u_tabpg_prprties_orderentry_notes

type variables

end variables

on u_tabpg_prprties_orderentry_notes.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_3=create uo_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.uo_1
end on

on u_tabpg_prprties_orderentry_notes.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.uo_1)
end on

type uo_2 from u_cst_syssettings_generic_populate within u_tabpg_prprties_orderentry_notes
integer y = 236
integer height = 1284
integer taborder = 30
end type

on uo_2.destroy
call u_cst_syssettings_generic_populate::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_EventNoteTypes

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_notes
integer x = 50
integer y = 132
integer width = 1929
integer taborder = 20
end type

on uo_3.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ShipNoteFormat

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_notes
integer x = 37
integer y = 16
integer width = 1810
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_NoteWizard

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

