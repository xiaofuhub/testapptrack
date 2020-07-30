$PBExportHeader$w_stopselection.srw
forward
global type w_stopselection from w_response
end type
type sle_start from singlelineedit within w_stopselection
end type
type sle_end from singlelineedit within w_stopselection
end type
type cb_1 from commandbutton within w_stopselection
end type
type st_1 from statictext within w_stopselection
end type
type st_2 from statictext within w_stopselection
end type
type st_3 from statictext within w_stopselection
end type
type st_4 from statictext within w_stopselection
end type
end forward

global type w_stopselection from w_response
integer width = 919
integer height = 376
string title = "Select Stops"
boolean controlmenu = false
long backcolor = 12632256
sle_start sle_start
sle_end sle_end
cb_1 cb_1
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_stopselection w_stopselection

on w_stopselection.create
int iCurrent
call super::create
this.sle_start=create sle_start
this.sle_end=create sle_end
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_start
this.Control[iCurrent+2]=this.sle_end
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
end on

on w_stopselection.destroy
call super::destroy
destroy(this.sle_start)
destroy(this.sle_end)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

event open;call super::open;
THIS.x = Pointerx( )
THIS.y = Pointery( )
end event

type cb_help from w_response`cb_help within w_stopselection
integer x = 539
integer y = 344
integer height = 56
integer taborder = 0
end type

event cb_help::constructor;call super::constructor;THIS.Visible = FALSE
end event

type sle_start from singlelineedit within w_stopselection
integer x = 78
integer y = 116
integer width = 128
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_end from singlelineedit within w_stopselection
integer x = 361
integer y = 116
integer width = 128
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_stopselection
integer x = 553
integer y = 112
integer width = 261
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean cancel = true
boolean default = true
end type

event clicked;String	ls_Start
String	ls_End

Int		li_Start
Int		li_End

ls_Start = sle_start.Text
ls_End = sle_End.text

If isNumber ( ls_Start ) THEN
	li_Start = Integer ( ls_Start )
END IF

If isNumber ( ls_End ) THEN
	li_End = Integer ( ls_End )
END IF

n_cst_msg	lnv_Msg
s_Parm		lstr_Parm

lstr_Parm.is_label = "START"
lstr_Parm.ia_Value = li_Start
lnv_msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "END"
lstr_Parm.ia_Value = li_End
lnv_msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( Parent , lnv_Msg )

end event

type st_1 from statictext within w_stopselection
integer x = 37
integer y = 44
integer width = 210
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "1   Stop"
boolean focusrectangle = false
end type

type st_2 from statictext within w_stopselection
integer x = 64
integer y = 24
integer width = 50
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "st"
boolean focusrectangle = false
end type

type st_3 from statictext within w_stopselection
integer x = 320
integer y = 44
integer width = 210
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "2   Stop"
boolean focusrectangle = false
end type

type st_4 from statictext within w_stopselection
integer x = 352
integer y = 20
integer width = 46
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "nd"
boolean focusrectangle = false
end type

