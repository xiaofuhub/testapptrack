$PBExportHeader$uo_test.sru
forward
global type uo_test from userobject
end type
type st_1 from statictext within uo_test
end type
end forward

global type uo_test from userobject
integer width = 2903
integer height = 1804
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
end type
global uo_test uo_test

on uo_test.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on uo_test.destroy
destroy(this.st_1)
end on

type st_1 from statictext within uo_test
integer x = 379
integer y = 224
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

