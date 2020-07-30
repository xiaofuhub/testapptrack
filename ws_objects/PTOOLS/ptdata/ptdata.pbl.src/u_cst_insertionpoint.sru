$PBExportHeader$u_cst_insertionpoint.sru
forward
global type u_cst_insertionpoint from u_base
end type
type st_ip from statictext within u_cst_insertionpoint
end type
type st_number from statictext within u_cst_insertionpoint
end type
end forward

global type u_cst_insertionpoint from u_base
integer width = 123
integer height = 72
long backcolor = 12632256
event ue_mousemove pbm_mousemove
event ue_clicked pbm_lbuttonclk
st_ip st_ip
st_number st_number
end type
global u_cst_insertionpoint u_cst_insertionpoint

type variables
Private:
Int	ii_Number
end variables

forward prototypes
public function integer of_assignnumber (integer ai_number)
public subroutine of_setvisible (boolean ab_value)
public subroutine of_reset ()
public function integer of_getassignednumber ()
end prototypes

event ue_mousemove;st_ip.TextColor = RGB ( 0, 255 , 0 )
st_number.TextColor = RGB ( 0, 255 , 0 )



end event

public function integer of_assignnumber (integer ai_number);String	ls_Number

//IF ai_Number <= 9 THEN
//	ls_Number = "&" + String ( ai_Number )
//ELSE
	ls_Number = String ( ai_Number )
//END IF
st_number.Text = ls_Number
ii_Number = ai_Number

RETURN 1
end function

public subroutine of_setvisible (boolean ab_value);st_ip.Visible = ab_Value
st_number.Visible = ab_Value

//st_ip.Enabled = ab_Value
//st_number.Enabled = ab_Value
//
THIS.Enabled = ab_Value
//


end subroutine

public subroutine of_reset ();st_ip.TextColor = RGB ( 255, 255 , 255 )
st_number.TextColor =  RGB ( 0, 0 , 0 )
end subroutine

public function integer of_getassignednumber ();RETURN ii_Number
end function

on u_cst_insertionpoint.create
int iCurrent
call super::create
this.st_ip=create st_ip
this.st_number=create st_number
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ip
this.Control[iCurrent+2]=this.st_number
end on

on u_cst_insertionpoint.destroy
call super::destroy
destroy(this.st_ip)
destroy(this.st_number)
end on

type st_ip from statictext within u_cst_insertionpoint
integer x = 69
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_number from statictext within u_cst_insertionpoint
integer y = 4
integer width = 64
integer height = 60
integer taborder = 1
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "99"
alignment alignment = right!
boolean focusrectangle = false
end type

