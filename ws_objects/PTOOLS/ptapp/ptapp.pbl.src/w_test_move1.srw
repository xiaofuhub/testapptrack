$PBExportHeader$w_test_move1.srw
forward
global type w_test_move1 from window
end type
type pb_1 from picturebutton within w_test_move1
end type
end forward

global type w_test_move1 from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_1 pb_1
end type
global w_test_move1 w_test_move1

on w_test_move1.create
this.pb_1=create pb_1
this.Control[]={this.pb_1}
end on

on w_test_move1.destroy
destroy(this.pb_1)
end on

type pb_1 from picturebutton within w_test_move1
integer x = 320
integer y = 140
integer width = 402
integer height = 224
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean originalsize = true
alignment htextalign = left!
end type

