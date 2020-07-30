$PBExportHeader$u_tabpg_prprties_rating_general.sru
forward
global type u_tabpg_prprties_rating_general from u_tabpg_prprties_rating
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
end type
type uo_showbillratecodelist from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
end type
type uo_rerateconfirmation from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
end type
type uo_reversezonesearch from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
end type
end forward

global type u_tabpg_prprties_rating_general from u_tabpg_prprties_rating
integer width = 1925
integer height = 1244
string text = "General"
uo_1 uo_1
uo_showbillratecodelist uo_showbillratecodelist
uo_rerateconfirmation uo_rerateconfirmation
uo_reversezonesearch uo_reversezonesearch
end type
global u_tabpg_prprties_rating_general u_tabpg_prprties_rating_general

on u_tabpg_prprties_rating_general.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_showbillratecodelist=create uo_showbillratecodelist
this.uo_rerateconfirmation=create uo_rerateconfirmation
this.uo_reversezonesearch=create uo_reversezonesearch
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_showbillratecodelist
this.Control[iCurrent+3]=this.uo_rerateconfirmation
this.Control[iCurrent+4]=this.uo_reversezonesearch
end on

on u_tabpg_prprties_rating_general.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_showbillratecodelist)
destroy(this.uo_rerateconfirmation)
destroy(this.uo_reversezonesearch)
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
integer x = 91
integer y = 496
integer width = 1769
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_appendratecodesearchlist

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_showbillratecodelist from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
integer x = 91
integer y = 316
integer width = 1769
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ShowBillRateCodeList

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy ( inv_syssetting )
end event

on uo_showbillratecodelist.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_rerateconfirmation from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
integer x = 91
integer y = 52
integer width = 1769
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_rerateconf

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy ( inv_syssetting )
end event

on uo_rerateconfirmation.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_reversezonesearch from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_rating_general
integer x = 91
integer y = 180
integer width = 1769
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ReverseOriDes

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_reversezonesearch.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

