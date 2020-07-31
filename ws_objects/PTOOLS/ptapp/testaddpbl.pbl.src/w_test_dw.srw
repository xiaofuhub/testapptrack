$PBExportHeader$w_test_dw.srw
forward
global type w_test_dw from window
end type
type dw_1 from uo_dw_itemlist_child within w_test_dw
end type
end forward

global type w_test_dw from window
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
dw_1 dw_1
end type
global w_test_dw w_test_dw

on w_test_dw.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_test_dw.destroy
destroy(this.dw_1)
end on

type dw_1 from uo_dw_itemlist_child within w_test_dw
integer x = 14
integer y = 204
integer taborder = 10
end type

