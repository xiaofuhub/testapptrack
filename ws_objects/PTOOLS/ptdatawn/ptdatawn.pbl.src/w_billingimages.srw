$PBExportHeader$w_billingimages.srw
forward
global type w_billingimages from w_response
end type
type cb_1 from u_cbok within w_billingimages
end type
type cb_cancel from u_cbcancel within w_billingimages
end type
type cb_override from u_cb within w_billingimages
end type
type dw_list from u_dw_billingimages within w_billingimages
end type
type mle_message from u_mle within w_billingimages
end type
end forward

global type w_billingimages from w_response
integer x = 214
integer y = 221
integer width = 2290
integer height = 1256
string title = "Billing Images"
boolean controlmenu = false
long backcolor = 12632256
cb_1 cb_1
cb_cancel cb_cancel
cb_override cb_override
dw_list dw_list
mle_message mle_message
end type
global w_billingimages w_billingimages

on w_billingimages.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_override=create cb_override
this.dw_list=create dw_list
this.mle_message=create mle_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_override
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.mle_message
end on

on w_billingimages.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_override)
destroy(this.dw_list)
destroy(this.mle_message)
end on

event open;call super::open;n_cst_msg	lnv_msg
S_parm		lstr_Parm

String		ls_Context
String		ls_Message

blob		lblb_dw



n_cst_Privileges	lnv_Privileges

lnv_msg = message.powerobjectparm



THIS.of_SetBase ( TRUE ) 
inv_Base.of_Center( )
THIS.y -= THIS.Height/3

IF isValid ( lnv_msg ) THEN
	
	IF lnv_msg.of_Get_Parm ( "DATASTORE" , lstr_Parm)  <> 0 THEN
		lblb_dw = lstr_Parm.ia_Value
		dw_list.SetFullState ( lblb_dw )
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "CONTEXT" , lstr_Parm ) <> 0 THEN
		ls_Context = lstr_Parm.ia_Value
		
	END IF

ELSE
	

END IF
IF ls_Context = "MISSINGIMAGES" THEN
	THIS.title = "Missing Image Report"
	ls_Message = ""
	mle_message.Enabled = FALSE
	cb_cancel.visible = False
	
ELSEIF ls_Context = "REQUIRED" THEN
	THIS.Title = "Missing Required Image Types"
	ls_Message = "The following invoices will NOT be processed due to lack of required images."

ELSE
	This.title = "Warning"
	ls_Message = "The following invoices do not have the following associated images."
	
END IF

IF ls_Context <> "MISSINGIMAGES" THEN
	
	ls_Message += " Click OK to proceed or Cancel to abort the billing process."
END IF

IF lnv_privileges.of_hasSysAdminRights ( ) AND ls_Context = "REQUIRED" AND ( ls_Context <> "MISSINGIMAGES" ) THEN
	cb_Override.Visible = TRUE
	ls_Message += "~r~nYou may click Process Anyway to process all the invoices regardless of associated image status."
END IF


mle_message.Text = ls_Message
end event

event pfc_default;

n_cst_msg	lnv_msg
S_parm		lstr_parm 

ib_disableclosequery = TRUE

lstr_Parm.is_label = "CONTINUE"
lstr_Parm.ia_Value = TRUE
lnv_msg.of_Add_Parm ( lstr_Parm )

closeWithReturn ( THIS , lnv_Msg )
end event

event pfc_cancel;call super::pfc_cancel;n_cst_msg	lnv_msg
S_parm		lstr_parm 

lstr_Parm.is_label = "CONTINUE"
lstr_Parm.ia_Value = False
lnv_msg.of_Add_Parm ( lstr_Parm )

closeWithReturn ( THIS , lnv_Msg )
end event

event close;call super::close;ib_disableclosequery = TRUE
end event

type cb_help from w_response`cb_help within w_billingimages
end type

type cb_1 from u_cbok within w_billingimages
integer x = 891
integer y = 1040
integer width = 233
integer taborder = 40
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
string text = "&OK"
end type

type cb_cancel from u_cbcancel within w_billingimages
integer x = 1166
integer y = 1040
integer width = 233
integer taborder = 30
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_override from u_cb within w_billingimages
boolean visible = false
integer x = 55
integer y = 1036
integer width = 489
integer taborder = 20
boolean bringtotop = true
integer weight = 400
string text = "Process Anyway"
end type

event clicked;n_cst_msg	lnv_msg
S_parm		lstr_parm 

ib_disableclosequery = TRUE

lstr_Parm.is_label = "CONTINUE"
lstr_Parm.ia_Value = TRUE
lnv_msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "OVERRIDE"
lstr_Parm.ia_Value = TRUE
lnv_msg.of_Add_Parm ( lstr_Parm )


closeWithReturn ( w_billingimages , lnv_Msg )
end event

type dw_list from u_dw_billingimages within w_billingimages
integer x = 27
integer y = 292
integer width = 2213
integer height = 704
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
end type

type mle_message from u_mle within w_billingimages
integer x = 27
integer y = 56
integer width = 2208
integer height = 188
integer taborder = 10
boolean bringtotop = true
end type

