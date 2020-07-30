$PBExportHeader$u_tabpg_prprties_billing_general.sru
forward
global type u_tabpg_prprties_billing_general from u_tabpg_prprties_billing
end type
type uo_7 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
end type
type uo_paymentterms from u_cst_syssettings_generic_populate within u_tabpg_prprties_billing_general
end type
type uo_6 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
end type
type uo_defaultbatchname from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
end type
type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
end type
type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
end type
type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
end type
type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
end type
end forward

global type u_tabpg_prprties_billing_general from u_tabpg_prprties_billing
integer width = 2126
integer height = 1596
string text = "General"
uo_7 uo_7
uo_paymentterms uo_paymentterms
uo_6 uo_6
uo_defaultbatchname uo_defaultbatchname
uo_5 uo_5
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_billing_general u_tabpg_prprties_billing_general

on u_tabpg_prprties_billing_general.create
int iCurrent
call super::create
this.uo_7=create uo_7
this.uo_paymentterms=create uo_paymentterms
this.uo_6=create uo_6
this.uo_defaultbatchname=create uo_defaultbatchname
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_7
this.Control[iCurrent+2]=this.uo_paymentterms
this.Control[iCurrent+3]=this.uo_6
this.Control[iCurrent+4]=this.uo_defaultbatchname
this.Control[iCurrent+5]=this.uo_5
this.Control[iCurrent+6]=this.uo_4
this.Control[iCurrent+7]=this.uo_3
this.Control[iCurrent+8]=this.uo_2
this.Control[iCurrent+9]=this.uo_1
end on

on u_tabpg_prprties_billing_general.destroy
call super::destroy
destroy(this.uo_7)
destroy(this.uo_paymentterms)
destroy(this.uo_6)
destroy(this.uo_defaultbatchname)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_7 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
integer x = 32
integer y = 864
integer width = 1979
integer taborder = 70
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_billingarbatch

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_7.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_paymentterms from u_cst_syssettings_generic_populate within u_tabpg_prprties_billing_general
integer y = 964
integer height = 580
integer taborder = 80
end type

on uo_paymentterms.destroy
call u_cst_syssettings_generic_populate::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_billingpaymentterms

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

this.of_setheight(600)
this.of_SetColumnCase('UPPER')
this.of_SetColumnLimit(12)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_6 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
integer x = 32
integer y = 732
integer width = 1979
integer taborder = 70
end type

on uo_6.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultBillType

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_defaultbatchname from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
integer x = 32
integer y = 604
integer width = 1979
integer taborder = 60
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultBatchName

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_defaultbatchname.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
integer x = 23
integer y = 352
integer width = 1865
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AllowForceBilling

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
integer x = 23
integer y = 240
integer width = 1865
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_SplitBilling

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
integer x = 23
integer y = 128
integer width = 1865
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ExcludeChassis

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_general
integer x = 23
integer y = 28
integer width = 1865
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AltInvoiceDate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_general
integer x = 32
integer y = 472
integer width = 1979
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CrossDockOnInvoice

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

