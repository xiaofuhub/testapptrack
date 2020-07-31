$PBExportHeader$uo_test.sru
forward
global type uo_test from userobject
end type
type tab_1 from tab within uo_test
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tab_1 from tab within uo_test
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type uo_test from userobject
integer width = 3090
integer height = 1728
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
tab_1 tab_1
end type
global uo_test uo_test

on uo_test.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on uo_test.destroy
destroy(this.tab_1)
end on

type tab_1 from tab within uo_test
integer x = 18
integer y = 16
integer width = 3058
integer height = 1676
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3022
integer height = 1544
long backcolor = 67108864
string text = "employee"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
integer x = 9
integer y = 8
integer width = 2949
integer height = 1524
integer taborder = 20
string title = "none"
string dataobject = "d_employee_test"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 116
integer width = 3022
integer height = 1544
long backcolor = 67108864
string text = "customer"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
integer x = 23
integer y = 12
integer width = 2962
integer height = 1512
integer taborder = 20
string title = "none"
string dataobject = "d_customer_test"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

