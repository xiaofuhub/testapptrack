$PBExportHeader$u_dw_shiptype_list.sru
forward
global type u_dw_shiptype_list from u_dw
end type
end forward

global type u_dw_shiptype_list from u_dw
int Width=2107
int Height=456
string DataObject="d_shiptype_list"
boolean VScrollBar=false
end type
global u_dw_shiptype_list u_dw_shiptype_list

event constructor;ib_isupdateable = FALSE
ib_rmbmenu = FALSE
end event

