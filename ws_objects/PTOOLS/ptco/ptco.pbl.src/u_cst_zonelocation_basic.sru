$PBExportHeader$u_cst_zonelocation_basic.sru
forward
global type u_cst_zonelocation_basic from u_cst_zonelocation
end type
end forward

global type u_cst_zonelocation_basic from u_cst_zonelocation
int Width=1385
int Height=200
end type
global u_cst_zonelocation_basic u_cst_zonelocation_basic

on u_cst_zonelocation_basic.create
call super::create
end on

on u_cst_zonelocation_basic.destroy
call super::destroy
end on

type cb_find from u_cst_zonelocation`cb_find within u_cst_zonelocation_basic
int TabOrder=0
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type dw_zones from u_cst_zonelocation`dw_zones within u_cst_zonelocation_basic
int TabOrder=0
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type dw_select from u_cst_zonelocation`dw_select within u_cst_zonelocation_basic
int X=0
int Y=12
int Width=1303
boolean BringToTop=true
string DataObject="d_zonelocation_small"
end type

type gb_1 from u_cst_zonelocation`gb_1 within u_cst_zonelocation_basic
boolean Visible=false
boolean Enabled=false
string Text=""
end type

type cb_1 from u_cst_zonelocation`cb_1 within u_cst_zonelocation_basic
int TabOrder=0
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

