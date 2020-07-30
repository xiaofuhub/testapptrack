$PBExportHeader$u_tabpg_prprties_edi_204.sru
forward
global type u_tabpg_prprties_edi_204 from u_tabpg_prprties_edi
end type
type uo_validatechanges from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_204
end type
type cb_1 from commandbutton within u_tabpg_prprties_edi_204
end type
type uo_5 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_edi_204
end type
type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_204
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_edi_204
end type
type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_edi_204
end type
type uo_3 from u_cst_syssettings_folders within u_tabpg_prprties_edi_204
end type
type uo_6 from u_cst_syssettings_files within u_tabpg_prprties_edi_204
end type
end forward

global type u_tabpg_prprties_edi_204 from u_tabpg_prprties_edi
integer width = 1929
integer height = 1560
string text = "204"
uo_validatechanges uo_validatechanges
cb_1 cb_1
uo_5 uo_5
uo_4 uo_4
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
uo_6 uo_6
end type
global u_tabpg_prprties_edi_204 u_tabpg_prprties_edi_204

on u_tabpg_prprties_edi_204.create
int iCurrent
call super::create
this.uo_validatechanges=create uo_validatechanges
this.cb_1=create cb_1
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.uo_6=create uo_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_validatechanges
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_5
this.Control[iCurrent+4]=this.uo_4
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_2
this.Control[iCurrent+7]=this.uo_3
this.Control[iCurrent+8]=this.uo_6
end on

on u_tabpg_prprties_edi_204.destroy
call super::destroy
destroy(this.uo_validatechanges)
destroy(this.cb_1)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.uo_6)
end on

type uo_validatechanges from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_204
integer x = 9
integer y = 1016
integer width = 1783
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_Validate204Changes

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_validatechanges.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type cb_1 from commandbutton within u_tabpg_prprties_edi_204
integer x = 32
integer y = 1368
integer width = 402
integer height = 104
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Alias List"
end type

event clicked;Open ( w_AliasSetup )
end event

type uo_5 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_edi_204
integer x = 18
integer y = 1192
integer taborder = 50
end type

event constructor;call super::constructor;THIS.of_Setddlb1xpos( 350 )

inv_syssetting = CREATE n_cst_setting_edi204version

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY ( inv_syssetting )
end event

on uo_5.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_204
integer x = 9
integer y = 836
integer width = 1783
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_StopOffItem204

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_edi_204
integer x = 9
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PathTo204ImportFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_edi_204
integer x = 9
integer y = 184
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PathTo204ProcessedFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_3 from u_cst_syssettings_folders within u_tabpg_prprties_edi_204
integer x = 9
integer y = 368
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PathTo204LogFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_6 from u_cst_syssettings_files within u_tabpg_prprties_edi_204
integer x = 9
integer y = 552
integer taborder = 40
end type

on uo_6.destroy
call u_cst_syssettings_files::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_edi204sefpath

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy inv_syssetting
end event

