$PBExportHeader$w_freeform_text.srw
forward
global type w_freeform_text from w_response
end type
type mle_text from multilineedit within w_freeform_text
end type
type st_1 from statictext within w_freeform_text
end type
type cb_1 from u_cbok within w_freeform_text
end type
type cb_2 from u_cbcancel within w_freeform_text
end type
end forward

global type w_freeform_text from w_response
integer x = 1061
integer y = 776
integer width = 1426
integer height = 788
string title = "Free Form Message Text "
long backcolor = 12632256
mle_text mle_text
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_freeform_text w_freeform_text

type variables
n_cst_msg	inv_Msg	
end variables

on w_freeform_text.create
int iCurrent
call super::create
this.mle_text=create mle_text
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_text
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_freeform_text.destroy
call super::destroy
destroy(this.mle_text)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_default;
S_Parm	lstr_Parm

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = TRUE
inv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "TEXT"
lstr_Parm.ia_Value = mle_text.Text
inv_Msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( THIS, inv_Msg)


end event

event open;call super::open;IF  Len (message.stringparm) > 0   THEN
	mle_text.text = message.stringparm
END IF
end event

event pfc_cancel;call super::pfc_cancel;
S_Parm	lstr_Parm

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = FALSE
inv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "TEXT"
lstr_Parm.ia_Value = mle_text.Text
inv_Msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( THIS, inv_Msg)


end event

event close;call super::close;IF inv_msg.of_Get_Count ( ) = 0 THEN
	S_Parm	lstr_Parm
	
	lstr_Parm.is_Label = "CONTINUE"
	lstr_Parm.ia_Value = FALSE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "TEXT"
	lstr_Parm.ia_Value = mle_text.Text
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	CloseWithReturn ( THIS, inv_Msg)
END IF

end event

type cb_help from w_response`cb_help within w_freeform_text
boolean visible = false
integer x = 1317
integer y = 636
end type

type mle_text from multilineedit within w_freeform_text
integer x = 73
integer y = 140
integer width = 1253
integer height = 360
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
integer limit = 32767
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_freeform_text
integer x = 69
integer y = 48
integer width = 1294
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Enter the free form text below and click OK."
boolean focusrectangle = false
end type

type cb_1 from u_cbok within w_freeform_text
integer x = 402
integer y = 560
integer width = 233
integer taborder = 20
boolean bringtotop = true
end type

type cb_2 from u_cbcancel within w_freeform_text
integer x = 722
integer y = 560
integer width = 233
integer taborder = 30
boolean bringtotop = true
end type

