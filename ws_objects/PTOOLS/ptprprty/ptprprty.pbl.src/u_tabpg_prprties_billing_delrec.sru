$PBExportHeader$u_tabpg_prprties_billing_delrec.sru
forward
global type u_tabpg_prprties_billing_delrec from u_tabpg_prprties_billing
end type
type uo_5 from u_cst_syssettings_files within u_tabpg_prprties_billing_delrec
end type
type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_delrec
end type
type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_delrec
end type
type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_delrec
end type
type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_billing_delrec
end type
end forward

global type u_tabpg_prprties_billing_delrec from u_tabpg_prprties_billing
integer width = 1938
integer height = 1428
string text = "Delivery Receipt"
uo_5 uo_5
uo_4 uo_4
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_billing_delrec u_tabpg_prprties_billing_delrec

on u_tabpg_prprties_billing_delrec.create
int iCurrent
call super::create
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_5
this.Control[iCurrent+2]=this.uo_4
this.Control[iCurrent+3]=this.uo_3
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.uo_1
end on

on u_tabpg_prprties_billing_delrec.destroy
call super::destroy
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_5 from u_cst_syssettings_files within u_tabpg_prprties_billing_delrec
integer x = 23
integer y = 644
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DeliveryRcptTemplate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_files::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_4 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_delrec
integer x = 23
integer y = 288
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CustomDeliveryRcpt

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_delrec
integer x = 23
integer y = 156
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_xDocDeliveryRcpt

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_delrec
integer x = 23
integer y = 24
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DeliveryRcptChrgs

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_billing_delrec
integer x = 23
integer y = 404
integer width = 1723
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DeliveryReceiptComment

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_sle::destroy
end on

