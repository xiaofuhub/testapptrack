$PBExportHeader$u_dw_emppop.sru
forward
global type u_dw_emppop from u_dw
end type
end forward

global type u_dw_emppop from u_dw
integer width = 1454
integer height = 280
boolean titlebar = true
string title = "Emp Row"
string dataobject = "d_emp_list"
end type
global u_dw_emppop u_dw_emppop

on u_dw_emppop.create
end on

on u_dw_emppop.destroy
end on

event constructor;call super::constructor;This.SetTransObject ( SQLCA )
This.Retrieve()
Commit ;
end event

