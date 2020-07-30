$PBExportHeader$u_dw_driverinfo.sru
forward
global type u_dw_driverinfo from u_dw
end type
end forward

global type u_dw_driverinfo from u_dw
integer width = 2377
integer height = 1228
boolean titlebar = true
string title = "Driver Info"
string dataobject = "d_driver_info"
end type
global u_dw_driverinfo u_dw_driverinfo

on u_dw_driverinfo.create
end on

on u_dw_driverinfo.destroy
end on

event constructor;call super::constructor;//this.visible = FALSE
This.SetTransObject ( SQLCA )
This.of_SetLinkage(TRUE)
end event

