$PBExportHeader$u_cst_invoicetransfersettings.sru
forward
global type u_cst_invoicetransfersettings from u_base
end type
type dw_1 from u_dw_companyinvoicetransfersettings within u_cst_invoicetransfersettings
end type
end forward

global type u_cst_invoicetransfersettings from u_base
integer width = 2016
integer height = 980
long backcolor = 12632256
event ue_itemchanged ( )
event ue_toggleemailinvoice ( boolean ab_switch )
dw_1 dw_1
end type
global u_cst_invoicetransfersettings u_cst_invoicetransfersettings

forward prototypes
public function integer of_retrieve (long al_coid)
public function integer of_validate ()
end prototypes

event ue_toggleemailinvoice(boolean ab_switch);dw_1.Event ue_ToggleEmailInvoice(ab_Switch)
end event

public function integer of_retrieve (long al_coid);RETURN dw_1.of_Retrieve ( al_coid )
end function

public function integer of_validate ();Return dw_1.of_Validate()
end function

on u_cst_invoicetransfersettings.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_cst_invoicetransfersettings.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_companyinvoicetransfersettings within u_cst_invoicetransfersettings
integer x = 41
integer y = 24
integer height = 940
integer taborder = 10
end type

event itemchanged;call super::itemchanged;Parent.event ue_itemchanged( )
end event

event editchanged;call super::editchanged;Parent.event ue_itemchanged( )
end event

