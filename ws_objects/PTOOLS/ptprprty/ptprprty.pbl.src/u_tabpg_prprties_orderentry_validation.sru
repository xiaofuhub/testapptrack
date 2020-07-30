$PBExportHeader$u_tabpg_prprties_orderentry_validation.sru
forward
global type u_tabpg_prprties_orderentry_validation from u_tabpg_prprties_orderentry
end type
type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_validation
end type
type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_validation
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_validation
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_validation
end type
end forward

global type u_tabpg_prprties_orderentry_validation from u_tabpg_prprties_orderentry
integer width = 2007
integer height = 1372
string text = "Validation"
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_orderentry_validation u_tabpg_prprties_orderentry_validation

on u_tabpg_prprties_orderentry_validation.create
int iCurrent
call super::create
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_4
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.uo_1
end on

on u_tabpg_prprties_orderentry_validation.destroy
call super::destroy
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_validation
integer x = 46
integer y = 344
integer width = 1934
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CrossCheck2nd3rdRef

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_orderentry_validation
integer x = 46
integer y = 224
integer width = 1934
integer taborder = 30
end type

on uo_3.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ShipPrimRefVal

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_validation
integer x = 46
integer y = 124
integer width = 1838
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ValidateItemBLRef

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_orderentry_validation
integer x = 46
integer y = 28
integer width = 1838
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ValidatePrimRef

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

