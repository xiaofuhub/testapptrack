$PBExportHeader$w_emailbody.srw
forward
global type w_emailbody from w_response
end type
type cb_ok from commandbutton within w_emailbody
end type
type cb_2 from commandbutton within w_emailbody
end type
type mle_body from multilineedit within w_emailbody
end type
type st_emailbody from statictext within w_emailbody
end type
end forward

global type w_emailbody from w_response
integer width = 1957
integer height = 1232
string title = "Invoice Transfer Settings"
long backcolor = 12632256
cb_ok cb_ok
cb_2 cb_2
mle_body mle_body
st_emailbody st_emailbody
end type
global w_emailbody w_emailbody

type variables
String	is_OldBody
end variables

on w_emailbody.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_2=create cb_2
this.mle_body=create mle_body
this.st_emailbody=create st_emailbody
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.mle_body
this.Control[iCurrent+4]=this.st_emailbody
end on

on w_emailbody.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_2)
destroy(this.mle_body)
destroy(this.st_emailbody)
end on

event open;call super::open;String	ls_Body

n_cst_msg	lnv_msg
S_parm		lstr_Parm

IF isValid(Message.PowerObjectParm) THEN
	lnv_msg = Message.PowerobjectParm
END IF


IF isValid ( lnv_msg ) THEN
	
	IF lnv_msg.of_Get_Parm ( "BODY" , lstr_Parm)  <> 0 THEN
		ls_Body = lstr_Parm.ia_Value
		This.mle_Body.Text = ls_Body
		is_OldBody = ls_Body
	END IF
	
END IF


THIS.of_SetBase ( TRUE ) 

IF isValid ( inv_Base ) THEN
	inv_Base.of_Center ( )
END IF

This.mle_body.Text = ls_Body
This.mle_Body.setfocus( )

end event

event closequery;//Overriding Ancestor
String ls_Newbody

n_cst_msg	lnv_msg
S_parm		lstr_parm 

IF NOT ib_DisableCloseQuery THEN
	ls_NewBody = mle_Body.Text
	IF is_OldBody <> ls_NewBody THEN
		CHOOSE CASE MessageBox("Closing..", "Set email body before closing?", Question!, YesNoCancel!)
			
			CASE 1
				lstr_Parm.is_label = "NEWBODY"
				lstr_Parm.ia_Value = ls_NewBody
				lnv_msg.of_Add_Parm ( lstr_Parm )
	
				Message.PowerObjectParm = lnv_Msg
				
			CASE 3
				Return 1 //Prevent Close
		END CHOOSE
	END IF
END IF
end event

event pfc_default;call super::pfc_default;n_cst_msg	lnv_msg
S_parm		lstr_parm 

ib_disableclosequery = TRUE

lstr_Parm.is_label = "NEWBODY"
lstr_Parm.ia_Value = mle_body.Text
lnv_msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )
end event

type cb_help from w_response`cb_help within w_emailbody
boolean visible = false
end type

type cb_ok from commandbutton within w_emailbody
integer x = 1138
integer y = 1004
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;Parent.Event pfc_Default()
end event

type cb_2 from commandbutton within w_emailbody
integer x = 1518
integer y = 1004
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
boolean default = true
end type

event clicked;ib_DisableCloseQuery = TRUE

Close(Parent)

end event

type mle_body from multilineedit within w_emailbody
integer x = 73
integer y = 140
integer width = 1787
integer height = 796
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
boolean ignoredefaultbutton = true
end type

type st_emailbody from statictext within w_emailbody
integer x = 73
integer y = 64
integer width = 443
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Email Body:"
boolean focusrectangle = false
end type

