$PBExportHeader$u_tabpg_prprties_billing_print.sru
forward
global type u_tabpg_prprties_billing_print from u_tabpg_prprties_billing
end type
type st_1 from statictext within u_tabpg_prprties_billing_print
end type
type cb_1 from commandbutton within u_tabpg_prprties_billing_print
end type
type uo_7 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
end type
type uo_manifestcustominvoice from u_cst_syssettings_files within u_tabpg_prprties_billing_print
end type
type uo_codenameoninvoice from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_print
end type
type uo_6 from u_cst_syssettings_files within u_tabpg_prprties_billing_print
end type
type uo_5 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
end type
type uo_usemanifestcustominvoice from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
end type
type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
end type
type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
end type
end forward

global type u_tabpg_prprties_billing_print from u_tabpg_prprties_billing
integer width = 1979
integer height = 1484
string text = "Printing"
st_1 st_1
cb_1 cb_1
uo_7 uo_7
uo_manifestcustominvoice uo_manifestcustominvoice
uo_codenameoninvoice uo_codenameoninvoice
uo_6 uo_6
uo_5 uo_5
uo_usemanifestcustominvoice uo_usemanifestcustominvoice
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_billing_print u_tabpg_prprties_billing_print

on u_tabpg_prprties_billing_print.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.uo_7=create uo_7
this.uo_manifestcustominvoice=create uo_manifestcustominvoice
this.uo_codenameoninvoice=create uo_codenameoninvoice
this.uo_6=create uo_6
this.uo_5=create uo_5
this.uo_usemanifestcustominvoice=create uo_usemanifestcustominvoice
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_7
this.Control[iCurrent+4]=this.uo_manifestcustominvoice
this.Control[iCurrent+5]=this.uo_codenameoninvoice
this.Control[iCurrent+6]=this.uo_6
this.Control[iCurrent+7]=this.uo_5
this.Control[iCurrent+8]=this.uo_usemanifestcustominvoice
this.Control[iCurrent+9]=this.uo_2
this.Control[iCurrent+10]=this.uo_1
end on

on u_tabpg_prprties_billing_print.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.uo_7)
destroy(this.uo_manifestcustominvoice)
destroy(this.uo_codenameoninvoice)
destroy(this.uo_6)
destroy(this.uo_5)
destroy(this.uo_usemanifestcustominvoice)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type st_1 from statictext within u_tabpg_prprties_billing_print
integer x = 18
integer y = 1300
integer width = 1115
integer height = 144
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Specify the number of invoice copies to use by default."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within u_tabpg_prprties_billing_print
integer x = 1317
integer y = 1308
integer width = 402
integer height = 112
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Setup"
end type

event clicked;open( w_setting_billingcopyDefaults )
end event

type uo_7 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
integer x = 9
integer y = 928
integer width = 1934
integer taborder = 60
end type

on uo_7.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_UseManifestCustomInvoice

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

type uo_manifestcustominvoice from u_cst_syssettings_files within u_tabpg_prprties_billing_print
integer y = 256
integer taborder = 20
end type

on uo_manifestcustominvoice.destroy
call u_cst_syssettings_files::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ManifCustInvoiceTemplate

Event ue_setproperty(inv_syssetting)

Event ue_setvalue(inv_syssetting)

This.of_SetExtension("PSR")
This.of_SetFilter("PSR Files (*.PSR), *.PSR")
end event

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

event ue_valuechanged;Int li_Return = 1
String ls_Path
Boolean lb_exist

ls_Path = Trim(as_Value)
IF NOT isNull(ls_Path) AND Len(ls_Path) > 0 THEN
	IF Upper( Right (ls_Path, 3) )  = "PSR" THEN
		inv_syssetting.of_savevalue( as_Value )
		li_Return = 1
	ELSE
		sle_1.text = ""
		MessageBox("Invalid Template", "Manifest custom template must have a .psr extension.", &
						Exclamation!, OK!)
		li_Return = -1
	END IF
ELSE
	inv_syssetting.of_savevalue( as_Value )
END IF
		
end event

type uo_codenameoninvoice from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_print
integer x = 5
integer y = 1180
integer width = 1966
integer taborder = 80
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_printcodenameoninvoice

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_codenameoninvoice.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_6 from u_cst_syssettings_files within u_tabpg_prprties_billing_print
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CustomInvoiceTemplate

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

on uo_6.destroy
call u_cst_syssettings_files::destroy
end on

type uo_5 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
integer x = 9
integer y = 1052
integer width = 1934
integer taborder = 70
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_BillManiPrntOrient

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_usemanifestcustominvoice from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
integer x = 9
integer y = 804
integer width = 1934
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_UseCustomInvoice

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_usemanifestcustominvoice.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_2 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
integer x = 9
integer y = 680
integer width = 1934
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_InvoiceBillAlign

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_print
integer x = 9
integer y = 560
integer width = 1934
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_InvoiceSize

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

