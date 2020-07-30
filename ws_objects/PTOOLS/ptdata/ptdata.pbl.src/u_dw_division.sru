$PBExportHeader$u_dw_division.sru
forward
global type u_dw_division from u_dw
end type
end forward

global type u_dw_division from u_dw
integer width = 832
integer height = 112
string dataobject = "d_division"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type
global u_dw_division u_dw_division

forward prototypes
public function long of_getdivision ()
public subroutine of_setdivision (long al_value)
end prototypes

public function long of_getdivision ();long	ll_division
setnull(ll_division)

if this.rowcount( ) > 0 then
	ll_division = this.object.division[1]
end if

return ll_division
end function

public subroutine of_setdivision (long al_value);
if isnull(al_value) then
	//skip
else
	this.object.division[1] = al_value
end if

end subroutine

event constructor;call super::constructor;string	ls_value

dwobject	ldwo_Division

n_cst_Presentation_AmountTemplate		lnv_Amounttemplate

lnv_Amounttemplate.of_SetPresentation ( This )

//add a blank to the code table
ldwo_Division = this.object.division
ls_value = ldwo_Division.values
ls_value = '' + '~t' + '0' + '/' + ls_value
ldwo_Division.values = ls_value
end event

on u_dw_division.create
end on

on u_dw_division.destroy
end on

