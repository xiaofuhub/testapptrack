$PBExportHeader$u_tab_communication_manager.sru
forward
global type u_tab_communication_manager from u_tab
end type
type tabpage_equipment from u_tabpage_communication_equipment within u_tab_communication_manager
end type
type tabpage_employee from u_tabpage_communication_employee within u_tab_communication_manager
end type
end forward

global type u_tab_communication_manager from u_tab
int Width=3264
int Height=1328
boolean BoldSelectedText=true
tabpage_equipment tabpage_equipment
tabpage_employee tabpage_employee
end type
global u_tab_communication_manager u_tab_communication_manager

on u_tab_communication_manager.create
this.tabpage_equipment=create tabpage_equipment
this.tabpage_employee=create tabpage_employee
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_equipment
this.Control[iCurrent+2]=this.tabpage_employee
end on

on u_tab_communication_manager.destroy
call super::destroy
destroy(this.tabpage_equipment)
destroy(this.tabpage_employee)
end on

type tabpage_equipment from u_tabpage_communication_equipment within u_tab_communication_manager
int X=18
int Y=100
int Width=3227
int Height=1212
string Text="Equipment"
end type

type tabpage_employee from u_tabpage_communication_employee within u_tab_communication_manager
int X=18
int Y=100
int Width=3227
int Height=1212
string Text="Employee"
end type

