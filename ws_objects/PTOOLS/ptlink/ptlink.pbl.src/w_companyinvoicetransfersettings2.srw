$PBExportHeader$w_companyinvoicetransfersettings2.srw
forward
global type w_companyinvoicetransfersettings2 from w_response
end type
type tab_invoice from u_tab_invoicetransfer within w_companyinvoicetransfersettings2
end type
type tab_invoice from u_tab_invoicetransfer within w_companyinvoicetransfersettings2
end type
type cb_ok from commandbutton within w_companyinvoicetransfersettings2
end type
type cb_save from commandbutton within w_companyinvoicetransfersettings2
end type
type dw_1 from u_dw_emailinvoicetoggle within w_companyinvoicetransfersettings2
end type
end forward

global type w_companyinvoicetransfersettings2 from w_response
integer width = 2117
integer height = 1368
string title = "Invoice Transfer Settings"
long backcolor = 12632256
event ue_itemchanged ( )
event ue_toggleemailinvoice ( boolean ab_switch )
event ue_postsave ( )
tab_invoice tab_invoice
cb_ok cb_ok
cb_save cb_save
dw_1 dw_1
end type
global w_companyinvoicetransfersettings2 w_companyinvoicetransfersettings2

type variables
Long	il_CoId

end variables

forward prototypes
public function integer of_checkcustomtemplate ()
public function integer of_validate ()
end prototypes

event ue_itemchanged();cb_save.Enabled = TRUE
end event

event ue_toggleemailinvoice(boolean ab_switch);tab_invoice.Event ue_Toggleemailinvoice(ab_Switch)
end event

event ue_postsave();tab_invoice.Event ue_postsave()
end event

public function integer of_checkcustomtemplate ();Integer	li_Return = 1
Any		la_Setting
String	ls_Setting

n_cst_Settings lnv_Settings 

lnv_Settings.of_GetSetting( 37, la_Setting ) 

ls_Setting = String(la_Setting)

IF Upper(ls_Setting) = "NO!" THEN
	MessageBox("Custom Invoice", "The Use Custom Invoice setting must be set to 'Yes' OR 'Ask' " + &
	"in order to email invoices.~r~nTo change this setting go to System Settings, choose Billing, " + &
	"and set 'Use Custom Invoice' on the Printing Tab.~r~n")
ELSEIF Upper(ls_Setting) = "ASK!" THEN
	MessageBox("Custom Invoice", "The 'Use Custom Invoice' setting is set to 'Ask each Time'.~r~n" + &
	"To email invoices you must select 'Yes' when asked if a custom template should be used.")
END IF

Return 1
end function

public function integer of_validate ();Return tab_invoice.of_Validate()
end function

on w_companyinvoicetransfersettings2.create
int iCurrent
call super::create
this.tab_invoice=create tab_invoice
this.cb_ok=create cb_ok
this.cb_save=create cb_save
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_invoice
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.dw_1
end on

on w_companyinvoicetransfersettings2.destroy
call super::destroy
destroy(this.tab_invoice)
destroy(this.cb_ok)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;call super::open;il_CoID = Message.DoubleParm
String	ls_Toggle

IF il_CoID > 0 THEN
	tab_invoice.of_Retrieve( il_CoID )
	dw_1.of_Retrieve(il_CoID)
	ls_Toggle = dw_1.GetItemString(1, "emailinvoice")
	IF isNull(ls_Toggle) OR ls_Toggle = "F" THEN
		tab_invoice.Event ue_ToggleEmailInvoice(FALSE)
	END IF
END IF


end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_Return 

tab_invoice.Event ue_PreUpdate()

IF of_Validate() = 1 THEN
	li_Return = AncestorReturnValue
ELSE
	li_Return = -1 //Do not save
END IF

Return li_Return
end event

type cb_help from w_response`cb_help within w_companyinvoicetransfersettings2
end type

type tab_invoice from u_tab_invoicetransfer within w_companyinvoicetransfersettings2
integer x = 37
integer y = 40
integer taborder = 20
boolean bringtotop = true
end type

event ue_itemchanged;call super::ue_itemchanged;cb_save.Enabled = TRUE
end event

event ue_toggleoff;call super::ue_toggleoff;This.Visible = FALSE
end event

type cb_ok from commandbutton within w_companyinvoicetransfersettings2
integer x = 704
integer y = 1168
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
end type

event clicked;Parent.event pfc_close( )
end event

type cb_save from commandbutton within w_companyinvoicetransfersettings2
integer x = 1065
integer y = 1168
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Save"
end type

event clicked;IF Parent.of_Validate() = 1 THEN
	Parent.Event pfc_save( )
	Parent.Event ue_PostSave()
	THIS.Enabled = FALSE
END IF
end event

type dw_1 from u_dw_emailinvoicetoggle within w_companyinvoicetransfersettings2
integer x = 1422
integer y = 20
integer width = 603
integer height = 76
integer taborder = 10
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;Parent.Event ue_ItemChanged()
IF dwo.Name = "emailinvoice" THEN
	IF data = "T" THEN
		Parent.Event ue_ToggleEmailInvoice(TRUE)
		Parent.of_CheckCustomTemplate( )
	ELSE
		Parent.Event ue_ToggleEmailInvoice(FALSE)
	END IF
END IF
end event

