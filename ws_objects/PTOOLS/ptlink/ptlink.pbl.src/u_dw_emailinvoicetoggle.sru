$PBExportHeader$u_dw_emailinvoicetoggle.sru
forward
global type u_dw_emailinvoicetoggle from u_dw
end type
end forward

global type u_dw_emailinvoicetoggle from u_dw
integer width = 695
integer height = 92
string dataobject = "d_emailinvoicetoggle"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type
global u_dw_emailinvoicetoggle u_dw_emailinvoicetoggle

forward prototypes
public function integer of_retrieve (long al_coid)
end prototypes

public function integer of_retrieve (long al_coid);Integer	li_Return
li_Return = THIS.Retrieve ( al_coid )
IF li_Return = 0 THEN
	//Should not get here
	MessageBox("Email Invoice Setup Error", "Failed to retrieve company invoice setup.")
END IF

RETURN li_Return
end function

on u_dw_emailinvoicetoggle.create
end on

on u_dw_emailinvoicetoggle.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
ib_Rmbmenu = FALSE
end event

