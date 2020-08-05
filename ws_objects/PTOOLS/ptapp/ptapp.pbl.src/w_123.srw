$PBExportHeader$w_123.srw
forward
global type w_123 from window
end type
type cb_1 from commandbutton within w_123
end type
end forward

global type w_123 from window
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
cb_1 cb_1
end type
global w_123 w_123

on w_123.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_123.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_123
integer x = 1042
integer y = 304
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

