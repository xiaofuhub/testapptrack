$PBExportHeader$u_tabpg_postingrules.sru
forward
global type u_tabpg_postingrules from u_tabpg
end type
type dw_1 from u_dw_postingrules within u_tabpg_postingrules
end type
end forward

global type u_tabpg_postingrules from u_tabpg
integer width = 2981
integer height = 984
dw_1 dw_1
end type
global u_tabpg_postingrules u_tabpg_postingrules

on u_tabpg_postingrules.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_postingrules.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_postingrules within u_tabpg_postingrules
integer x = 20
integer y = 20
integer width = 2921
integer height = 928
integer taborder = 10
string dataobject = "d_postingrules_leasetype"
end type

