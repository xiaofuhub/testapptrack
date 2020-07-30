$PBExportHeader$u_tabpg_armap.sru
forward
global type u_tabpg_armap from u_tabpg
end type
type dw_1 from u_dw_armap within u_tabpg_armap
end type
end forward

global type u_tabpg_armap from u_tabpg
int Width=2880
int Height=1272
dw_1 dw_1
end type
global u_tabpg_armap u_tabpg_armap

on u_tabpg_armap.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_armap.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_armap within u_tabpg_armap
int X=9
int Y=12
int Width=2839
int Height=1232
int TabOrder=10
boolean BringToTop=true
end type

