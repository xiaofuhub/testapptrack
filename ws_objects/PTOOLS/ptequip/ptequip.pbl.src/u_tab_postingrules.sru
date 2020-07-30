$PBExportHeader$u_tab_postingrules.sru
forward
global type u_tab_postingrules from u_tab
end type
type tabpage_1 from u_tabpg_postingrules within u_tab_postingrules
end type
type tabpage_1 from u_tabpg_postingrules within u_tab_postingrules
end type
type tabpage_2 from u_tabpg_postingrules_company within u_tab_postingrules
end type
type tabpage_2 from u_tabpg_postingrules_company within u_tab_postingrules
end type
end forward

global type u_tab_postingrules from u_tab
integer width = 2990
integer height = 1084
long backcolor = 12632256
boolean boldselectedtext = true
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
global u_tab_postingrules u_tab_postingrules

on u_tab_postingrules.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
this.Control[iCurrent+2]=this.tabpage_2
end on

on u_tab_postingrules.destroy
call super::destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from u_tabpg_postingrules within u_tab_postingrules
integer x = 18
integer y = 100
integer width = 2953
integer height = 968
long backcolor = 12632256
string text = "Line/Type"
long tabbackcolor = 12632256
end type

type tabpage_2 from u_tabpg_postingrules_company within u_tab_postingrules
integer x = 18
integer y = 100
integer width = 2953
integer height = 968
long backcolor = 12632256
string text = "Company"
long tabbackcolor = 12632256
end type

