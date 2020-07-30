$PBExportHeader$w_mle.srw
forward
global type w_mle from w_response
end type
type mle_1 from u_mle within w_mle
end type
type cb_1 from commandbutton within w_mle
end type
end forward

global type w_mle from w_response
integer x = 214
integer y = 221
integer width = 3319
integer height = 2480
mle_1 mle_1
cb_1 cb_1
end type
global w_mle w_mle

event open;call super::open;n_cst_msg	lnv_msg
S_Parm		lstr_Parm

lnv_Msg = Message.PowerobjectParm

IF lnv_Msg.of_Get_Parm ( "TEXT" , lstr_parm ) <> 0 THEN
	mle_1.Text = lstr_Parm.ia_value
END IF

IF lnv_Msg.of_Get_Parm ( "TITLE" , lstr_parm ) <> 0 THEN
	THIS.Title = lstr_Parm.ia_value
END IF


end event

on w_mle.create
int iCurrent
call super::create
this.mle_1=create mle_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_mle.destroy
call super::destroy
destroy(this.mle_1)
destroy(this.cb_1)
end on

type mle_1 from u_mle within w_mle
integer x = 32
integer y = 28
integer width = 3218
integer height = 2308
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean displayonly = true
end type

type cb_1 from commandbutton within w_mle
integer x = 928
integer y = 520
integer width = 1326
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "THIS is here to close the window w. the esc key"
boolean cancel = true
end type

event clicked;Close ( PARENT ) 
end event

