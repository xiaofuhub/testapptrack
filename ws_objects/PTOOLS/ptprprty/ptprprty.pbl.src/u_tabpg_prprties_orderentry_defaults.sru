$PBExportHeader$u_tabpg_prprties_orderentry_defaults.sru
forward
global type u_tabpg_prprties_orderentry_defaults from u_tabpg_prprties_orderentry
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_defaults
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_defaults
end type
type uo_applymanualfilter from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_defaults
end type
type uo_defaultshipsummary from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
end type
type uo_defaulttypeyarddrop from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
end type
type uo_defaulttypechassismove from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
end type
type uo_defaultnewshipbutton from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
end type
type uo_defaultaccessorialamttype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
end type
type uo_defaultfreightamttype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
end type
end forward

global type u_tabpg_prprties_orderentry_defaults from u_tabpg_prprties_orderentry
integer width = 2176
integer height = 1832
string text = "Defaults"
uo_2 uo_2
uo_1 uo_1
uo_applymanualfilter uo_applymanualfilter
uo_defaultshipsummary uo_defaultshipsummary
uo_defaulttypeyarddrop uo_defaulttypeyarddrop
uo_defaulttypechassismove uo_defaulttypechassismove
uo_defaultnewshipbutton uo_defaultnewshipbutton
uo_defaultaccessorialamttype uo_defaultaccessorialamttype
uo_defaultfreightamttype uo_defaultfreightamttype
end type
global u_tabpg_prprties_orderentry_defaults u_tabpg_prprties_orderentry_defaults

on u_tabpg_prprties_orderentry_defaults.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.uo_1=create uo_1
this.uo_applymanualfilter=create uo_applymanualfilter
this.uo_defaultshipsummary=create uo_defaultshipsummary
this.uo_defaulttypeyarddrop=create uo_defaulttypeyarddrop
this.uo_defaulttypechassismove=create uo_defaulttypechassismove
this.uo_defaultnewshipbutton=create uo_defaultnewshipbutton
this.uo_defaultaccessorialamttype=create uo_defaultaccessorialamttype
this.uo_defaultfreightamttype=create uo_defaultfreightamttype
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_applymanualfilter
this.Control[iCurrent+4]=this.uo_defaultshipsummary
this.Control[iCurrent+5]=this.uo_defaulttypeyarddrop
this.Control[iCurrent+6]=this.uo_defaulttypechassismove
this.Control[iCurrent+7]=this.uo_defaultnewshipbutton
this.Control[iCurrent+8]=this.uo_defaultaccessorialamttype
this.Control[iCurrent+9]=this.uo_defaultfreightamttype
end on

on u_tabpg_prprties_orderentry_defaults.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.uo_applymanualfilter)
destroy(this.uo_defaultshipsummary)
destroy(this.uo_defaulttypeyarddrop)
destroy(this.uo_defaulttypechassismove)
destroy(this.uo_defaultnewshipbutton)
destroy(this.uo_defaultaccessorialamttype)
destroy(this.uo_defaultfreightamttype)
end on

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 1168
integer width = 1920
integer height = 148
integer taborder = 120
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PickupNumberFillReleased

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 1052
integer width = 1920
integer height = 148
integer taborder = 120
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_defaultshipmentdate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_applymanualfilter from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 888
integer width = 1920
integer height = 148
integer taborder = 110
end type

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ShipSummaryManualFilter

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_applymanualfilter.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_defaultshipsummary from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 740
integer width = 1920
integer taborder = 100
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultShipmentSummary

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_defaultshipsummary.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_defaulttypeyarddrop from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 596
integer width = 1920
integer taborder = 90
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultTypeYardDrop

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_defaulttypeyarddrop.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_defaulttypechassismove from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 452
integer width = 1920
integer taborder = 80
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultTypeChassisMove

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_defaulttypechassismove.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_defaultnewshipbutton from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 316
integer width = 1920
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultNewShipButton

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_defaultnewshipbutton.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_defaultaccessorialamttype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 172
integer width = 1920
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultAccessorialAmtType

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY inv_syssetting
end event

on uo_defaultaccessorialamttype.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_defaultfreightamttype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_defaults
integer x = 41
integer y = 28
integer width = 1920
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultFreightAmtType

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_defaultfreightamttype.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

