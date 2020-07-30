$PBExportHeader$u_tabpg_prprties_orderentry_general.sru
forward
global type u_tabpg_prprties_orderentry_general from u_tabpg_prprties_orderentry
end type
type uo_allownewco from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_general
end type
type uo_newbrokerageshippayformat from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_general
end type
type uo_newdispatchshippayformat from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_general
end type
type uo_billnote from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
type uo_shipnote from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
type uo_setshipdate from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
end type
end forward

global type u_tabpg_prprties_orderentry_general from u_tabpg_prprties_orderentry
integer width = 2002
integer height = 1904
string text = "General"
uo_allownewco uo_allownewco
uo_4 uo_4
uo_newbrokerageshippayformat uo_newbrokerageshippayformat
uo_newdispatchshippayformat uo_newdispatchshippayformat
uo_billnote uo_billnote
uo_shipnote uo_shipnote
uo_5 uo_5
uo_setshipdate uo_setshipdate
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_orderentry_general u_tabpg_prprties_orderentry_general

on u_tabpg_prprties_orderentry_general.create
int iCurrent
call super::create
this.uo_allownewco=create uo_allownewco
this.uo_4=create uo_4
this.uo_newbrokerageshippayformat=create uo_newbrokerageshippayformat
this.uo_newdispatchshippayformat=create uo_newdispatchshippayformat
this.uo_billnote=create uo_billnote
this.uo_shipnote=create uo_shipnote
this.uo_5=create uo_5
this.uo_setshipdate=create uo_setshipdate
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_allownewco
this.Control[iCurrent+2]=this.uo_4
this.Control[iCurrent+3]=this.uo_newbrokerageshippayformat
this.Control[iCurrent+4]=this.uo_newdispatchshippayformat
this.Control[iCurrent+5]=this.uo_billnote
this.Control[iCurrent+6]=this.uo_shipnote
this.Control[iCurrent+7]=this.uo_5
this.Control[iCurrent+8]=this.uo_setshipdate
this.Control[iCurrent+9]=this.uo_3
this.Control[iCurrent+10]=this.uo_2
this.Control[iCurrent+11]=this.uo_1
end on

on u_tabpg_prprties_orderentry_general.destroy
call super::destroy
destroy(this.uo_allownewco)
destroy(this.uo_4)
destroy(this.uo_newbrokerageshippayformat)
destroy(this.uo_newdispatchshippayformat)
destroy(this.uo_billnote)
destroy(this.uo_shipnote)
destroy(this.uo_5)
destroy(this.uo_setshipdate)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_allownewco from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 788
integer height = 80
integer taborder = 80
end type

on uo_allownewco.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AllowNewCompany

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_general
integer x = 41
integer y = 900
integer width = 1920
integer taborder = 60
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_EventListDisplay

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_newbrokerageshippayformat from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_general
integer x = 41
integer y = 1168
integer width = 1920
integer taborder = 60
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_NewBrokerageShipPayFormat

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_newbrokerageshippayformat.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_newdispatchshippayformat from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_general
integer x = 41
integer y = 1032
integer width = 1920
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_NewDispatchShipPayFormat

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_newdispatchshippayformat.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_billnote from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 684
integer width = 1920
integer height = 80
integer taborder = 70
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_EnableBillNote

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_billnote.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_shipnote from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 576
integer width = 1920
integer height = 80
integer taborder = 60
end type

on uo_shipnote.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_EnableShipNote

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 472
integer width = 1920
integer height = 80
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CombineSaveAndCloseOnShpmt

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

on uo_5.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_setshipdate from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 368
integer width = 1920
integer height = 80
integer taborder = 40
end type

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_setshipdate.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_setshipdate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 264
integer width = 1920
integer height = 80
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_BillToSaveShipment

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 160
integer width = 1920
integer height = 80
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DetermineOriDes

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_general
integer x = 32
integer y = 56
integer width = 1920
integer height = 80
integer taborder = 10
end type

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_GoToInShipment

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

