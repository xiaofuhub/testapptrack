$PBExportHeader$u_cst_buildnamingconvention.sru
forward
global type u_cst_buildnamingconvention from u_base
end type
type cb_clear from commandbutton within u_cst_buildnamingconvention
end type
type sle_statictext from singlelineedit within u_cst_buildnamingconvention
end type
type st_2 from statictext within u_cst_buildnamingconvention
end type
type sle_seqnumlength from singlelineedit within u_cst_buildnamingconvention
end type
type st_1 from statictext within u_cst_buildnamingconvention
end type
type rb_date1 from radiobutton within u_cst_buildnamingconvention
end type
type rb_date2 from radiobutton within u_cst_buildnamingconvention
end type
type sle_convention from singlelineedit within u_cst_buildnamingconvention
end type
type cb_addseqnum from commandbutton within u_cst_buildnamingconvention
end type
type cb_addtext from commandbutton within u_cst_buildnamingconvention
end type
type cb_addtime from commandbutton within u_cst_buildnamingconvention
end type
type cb_adddate from commandbutton within u_cst_buildnamingconvention
end type
type gb_1 from groupbox within u_cst_buildnamingconvention
end type
type gb_2 from groupbox within u_cst_buildnamingconvention
end type
type gb_3 from groupbox within u_cst_buildnamingconvention
end type
type gb_4 from groupbox within u_cst_buildnamingconvention
end type
type gb_5 from groupbox within u_cst_buildnamingconvention
end type
end forward

global type u_cst_buildnamingconvention from u_base
integer width = 2587
integer height = 704
long backcolor = 12632256
event ue_adddate ( )
event ue_addtime ( )
event ue_addseqnumber ( )
event ue_addtext ( )
event ue_clear ( )
cb_clear cb_clear
sle_statictext sle_statictext
st_2 st_2
sle_seqnumlength sle_seqnumlength
st_1 st_1
rb_date1 rb_date1
rb_date2 rb_date2
sle_convention sle_convention
cb_addseqnum cb_addseqnum
cb_addtext cb_addtext
cb_addtime cb_addtime
cb_adddate cb_adddate
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
end type
global u_cst_buildnamingconvention u_cst_buildnamingconvention

on u_cst_buildnamingconvention.create
int iCurrent
call super::create
this.cb_clear=create cb_clear
this.sle_statictext=create sle_statictext
this.st_2=create st_2
this.sle_seqnumlength=create sle_seqnumlength
this.st_1=create st_1
this.rb_date1=create rb_date1
this.rb_date2=create rb_date2
this.sle_convention=create sle_convention
this.cb_addseqnum=create cb_addseqnum
this.cb_addtext=create cb_addtext
this.cb_addtime=create cb_addtime
this.cb_adddate=create cb_adddate
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_clear
this.Control[iCurrent+2]=this.sle_statictext
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_seqnumlength
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.rb_date1
this.Control[iCurrent+7]=this.rb_date2
this.Control[iCurrent+8]=this.sle_convention
this.Control[iCurrent+9]=this.cb_addseqnum
this.Control[iCurrent+10]=this.cb_addtext
this.Control[iCurrent+11]=this.cb_addtime
this.Control[iCurrent+12]=this.cb_adddate
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.gb_4
this.Control[iCurrent+17]=this.gb_5
end on

on u_cst_buildnamingconvention.destroy
call super::destroy
destroy(this.cb_clear)
destroy(this.sle_statictext)
destroy(this.st_2)
destroy(this.sle_seqnumlength)
destroy(this.st_1)
destroy(this.rb_date1)
destroy(this.rb_date2)
destroy(this.sle_convention)
destroy(this.cb_addseqnum)
destroy(this.cb_addtext)
destroy(this.cb_addtime)
destroy(this.cb_adddate)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
end on

type cb_clear from commandbutton within u_cst_buildnamingconvention
integer x = 2144
integer y = 516
integer width = 343
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear"
end type

type sle_statictext from singlelineedit within u_cst_buildnamingconvention
integer x = 1865
integer y = 284
integer width = 594
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within u_cst_buildnamingconvention
integer x = 1074
integer y = 288
integer width = 590
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Number Length ( 5-9 )"
boolean focusrectangle = false
end type

type sle_seqnumlength from singlelineedit within u_cst_buildnamingconvention
integer x = 1678
integer y = 284
integer width = 87
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "5"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within u_cst_buildnamingconvention
integer x = 663
integer y = 288
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "HH/MM/SS"
boolean focusrectangle = false
end type

type rb_date1 from radiobutton within u_cst_buildnamingconvention
integer x = 96
integer y = 288
integer width = 466
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "YYYY/MM/DD"
end type

type rb_date2 from radiobutton within u_cst_buildnamingconvention
integer x = 91
integer y = 396
integer width = 466
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "MM/DD/YYYY"
boolean checked = true
end type

type sle_convention from singlelineedit within u_cst_buildnamingconvention
integer x = 78
integer y = 516
integer width = 2021
integer height = 112
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_addseqnum from commandbutton within u_cst_buildnamingconvention
integer x = 1065
integer y = 152
integer width = 699
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sequential Number"
end type

type cb_addtext from commandbutton within u_cst_buildnamingconvention
integer x = 1861
integer y = 152
integer width = 599
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Static Text"
end type

type cb_addtime from commandbutton within u_cst_buildnamingconvention
integer x = 658
integer y = 152
integer width = 334
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Time"
end type

type cb_adddate from commandbutton within u_cst_buildnamingconvention
integer x = 110
integer y = 152
integer width = 457
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Date"
end type

type gb_1 from groupbox within u_cst_buildnamingconvention
integer x = 82
integer y = 64
integer width = 512
integer height = 424
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Add"
end type

type gb_2 from groupbox within u_cst_buildnamingconvention
integer x = 622
integer y = 64
integer width = 402
integer height = 324
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Add"
end type

type gb_3 from groupbox within u_cst_buildnamingconvention
integer x = 1038
integer y = 64
integer width = 763
integer height = 324
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Add"
end type

type gb_4 from groupbox within u_cst_buildnamingconvention
integer x = 1829
integer y = 64
integer width = 658
integer height = 328
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Add"
end type

type gb_5 from groupbox within u_cst_buildnamingconvention
integer x = 41
integer y = 4
integer width = 2505
integer height = 656
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

