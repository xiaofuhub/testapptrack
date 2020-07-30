$PBExportHeader$u_dw_intermodalheader.sru
forward
global type u_dw_intermodalheader from u_dw_shipinfo
end type
end forward

global type u_dw_intermodalheader from u_dw_shipinfo
int Width=1947
int Height=80
string DataObject="d_intermodalshipheader"
end type
global u_dw_intermodalheader u_dw_intermodalheader

event ue_shipmentchanged;call super::ue_shipmentchanged;THIS.SetTabOrder ( "ds_id" , 1 ) 
THIS.SetColumn ( "ds_id" ) 
THIS.SetRedraw ( TRUE ) 
THIS.SetTabOrder ( "ds_id" , 0 ) 
end event

