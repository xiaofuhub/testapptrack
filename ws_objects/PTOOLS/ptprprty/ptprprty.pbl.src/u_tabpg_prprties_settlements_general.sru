$PBExportHeader$u_tabpg_prprties_settlements_general.sru
forward
global type u_tabpg_prprties_settlements_general from u_tabpg_prprties_settlements
end type
type st_1 from statictext within u_tabpg_prprties_settlements_general
end type
type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
end type
type uo_reversesearch from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
end type
type uo_excludenonintermodal from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
end type
type uo_payfuelsurchargetype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_settlements_general
end type
type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
end type
type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_settlements_general
end type
type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_settlements_general
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
end type
end forward

global type u_tabpg_prprties_settlements_general from u_tabpg_prprties_settlements
integer width = 1993
integer height = 1464
string text = "General"
st_1 st_1
uo_5 uo_5
uo_reversesearch uo_reversesearch
uo_excludenonintermodal uo_excludenonintermodal
uo_payfuelsurchargetype uo_payfuelsurchargetype
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_settlements_general u_tabpg_prprties_settlements_general

type variables


end variables

on u_tabpg_prprties_settlements_general.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_5=create uo_5
this.uo_reversesearch=create uo_reversesearch
this.uo_excludenonintermodal=create uo_excludenonintermodal
this.uo_payfuelsurchargetype=create uo_payfuelsurchargetype
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_5
this.Control[iCurrent+3]=this.uo_reversesearch
this.Control[iCurrent+4]=this.uo_excludenonintermodal
this.Control[iCurrent+5]=this.uo_payfuelsurchargetype
this.Control[iCurrent+6]=this.uo_4
this.Control[iCurrent+7]=this.uo_3
this.Control[iCurrent+8]=this.uo_2
this.Control[iCurrent+9]=this.uo_1
end on

on u_tabpg_prprties_settlements_general.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_5)
destroy(this.uo_reversesearch)
destroy(this.uo_excludenonintermodal)
destroy(this.uo_payfuelsurchargetype)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type st_1 from statictext within u_tabpg_prprties_settlements_general
integer x = 59
integer y = 1076
integer width = 1486
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "When repairing failed transactions in the batch manager"
boolean focusrectangle = false
end type

type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
integer x = 41
integer y = 1152
integer width = 1856
integer height = 144
integer taborder = 80
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_EnableStartEndDate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_reversesearch from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
integer x = 41
integer y = 932
integer width = 1856
integer height = 144
integer taborder = 70
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_reverseoridessettlements

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_reversesearch.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_excludenonintermodal from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
integer x = 41
integer y = 260
integer width = 1856
integer height = 244
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_excludenonintermodaltype

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

this.of_SetLabelHeight(200)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_excludenonintermodal.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_payfuelsurchargetype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_settlements_general
integer x = 41
integer y = 780
integer width = 1280
integer taborder = 50
end type

event constructor;call super::constructor;this.of_Setddlb1Width(500)
this.of_Setst1Width(825)
this.of_Setddlb1XPos(780)

inv_syssetting = CREATE n_cst_setting_PayFuelSurchargeType

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

on uo_payfuelsurchargetype.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
integer x = 41
integer y = 152
integer width = 1856
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PayableFuelCardEntity

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_settlements_general
integer x = 41
integer y = 628
integer width = 1934
integer taborder = 40
end type

event constructor;call super::constructor;this.of_Setddlb1Width(500)
this.of_Setst1Width(825)
this.of_Setddlb1XPos(780)


inv_syssetting = CREATE n_cst_setting_SettlementsMileageType

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY inv_syssetting
end event

on uo_3.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_settlements_general
integer x = 1362
integer y = 780
integer width = 567
integer height = 128
integer taborder = 60
end type

event constructor;call super::constructor;this.of_SetSlexpos(8)
this.of_SetSleYPos(4)
this.of_SetSleWidth(421)
this.of_Setst1Visible(false)
this.of_Setst2Visible(false)

inv_syssetting = CREATE n_cst_setting_PayableFuelSurcharge%age

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY inv_syssetting
end event

on uo_2.destroy
call u_cst_syssettings_sle::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_general
integer x = 41
integer y = 44
integer width = 1856
integer taborder = 10
end type

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AutoPayForAccessorials

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY inv_syssetting
end event

