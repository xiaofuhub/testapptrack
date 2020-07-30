$PBExportHeader$u_dw_batchselection.sru
forward
global type u_dw_batchselection from u_dw
end type
end forward

global type u_dw_batchselection from u_dw
integer width = 1083
integer height = 192
string dataobject = "d_batchselection"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_batchselection u_dw_batchselection

type variables
DataWindowChild	idwc_Batchnumber
end variables

forward prototypes
public subroutine of_getchilddw (ref datawindowchild adwc_value)
end prototypes

public subroutine of_getchilddw (ref datawindowchild adwc_value);adwc_value =  idwc_Batchnumber
end subroutine

event constructor;THIS.GetChild ( "batchnumber" , idwc_Batchnumber )
ib_Rmbmenu = FALSE	
end event

on u_dw_batchselection.create
end on

on u_dw_batchselection.destroy
end on

