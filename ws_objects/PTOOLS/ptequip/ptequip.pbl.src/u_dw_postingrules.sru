$PBExportHeader$u_dw_postingrules.sru
forward
global type u_dw_postingrules from u_dw
end type
end forward

global type u_dw_postingrules from u_dw
integer width = 2939
integer height = 676
end type
global u_dw_postingrules u_dw_postingrules

on u_dw_postingrules.create
end on

on u_dw_postingrules.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
THIS.Retrieve( )
ib_Rmbmenu = FALSE


end event

