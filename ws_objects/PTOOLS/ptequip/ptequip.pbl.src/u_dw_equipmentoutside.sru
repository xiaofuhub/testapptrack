$PBExportHeader$u_dw_equipmentoutside.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentoutside from u_dw
end type
end forward

global type u_dw_equipmentoutside from u_dw
integer width = 1486
integer height = 1556
string dataobject = "d_eq_outside"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type
global u_dw_equipmentoutside u_dw_equipmentoutside

on u_dw_equipmentoutside.create
end on

on u_dw_equipmentoutside.destroy
end on

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

