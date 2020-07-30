$PBExportHeader$u_dw_employees.sru
forward
global type u_dw_employees from u_dw
end type
end forward

global type u_dw_employees from u_dw
integer width = 1440
integer height = 1188
boolean titlebar = true
string title = "Emp List"
string dataobject = "d_emp_list"
end type
global u_dw_employees u_dw_employees

on u_dw_employees.create
end on

on u_dw_employees.destroy
end on

event constructor;call super::constructor;This.SetTransObject ( SQLCA )
This.Retrieve()
Commit ;
//this.of_SetLinkage(TRUE)
end event

