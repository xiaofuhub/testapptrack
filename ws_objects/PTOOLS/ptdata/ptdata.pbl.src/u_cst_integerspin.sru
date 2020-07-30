$PBExportHeader$u_cst_integerspin.sru
forward
global type u_cst_integerspin from u_base
end type
type vsb_spin from vscrollbar within u_cst_integerspin
end type
type sle_value from singlelineedit within u_cst_integerspin
end type
end forward

global type u_cst_integerspin from u_base
integer width = 233
integer height = 108
long backcolor = 12632256
event ue_valuechanged ( integer ai_value )
vsb_spin vsb_spin
sle_value sle_value
end type
global u_cst_integerspin u_cst_integerspin

type variables
Private:
Int	ii_LowerBound
Int	ii_UpperBound
Int	ii_WarnValue
INt	ii_Previous
end variables

forward prototypes
public function integer of_setbounds (integer ai_lower, integer ai_upper, integer ai_warnvalue)
public function integer of_getvalue ()
public function integer of_setvalue (integer ai_value)
public function integer of_enable (boolean ab_value)
end prototypes

public function integer of_setbounds (integer ai_lower, integer ai_upper, integer ai_warnvalue);ii_Lowerbound = ai_Lower
ii_Upperbound = ai_upper
ii_warnvalue = ai_Warnvalue // this is used as an incrementing warning i.e 
									// if previous + new >= warnvalue then display warning
 
RETURN 1
end function

public function integer of_getvalue ();Return ii_previous
end function

public function integer of_setvalue (integer ai_value);sle_Value.text = String ( ai_value )
ii_previous = ai_value
RETURN 1
end function

public function integer of_enable (boolean ab_value);sle_value.Enabled = ab_value
//vsb_spin.Enabled = ab_value

RETURN 1
end function

on u_cst_integerspin.create
int iCurrent
call super::create
this.vsb_spin=create vsb_spin
this.sle_value=create sle_value
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.vsb_spin
this.Control[iCurrent+2]=this.sle_value
end on

on u_cst_integerspin.destroy
call super::destroy
destroy(this.vsb_spin)
destroy(this.sle_value)
end on

type vsb_spin from vscrollbar within u_cst_integerspin
integer x = 133
integer width = 55
integer height = 84
boolean stdwidth = false
end type

event linedown;IF sle_value.Enabled THEN
	Int	li_Value
	li_Value = Integer ( sle_Value.Text )
	IF li_Value > 0 THEN
		li_Value --
		sle_Value.Text = ( String ( li_Value) )
		sle_Value.event modified( )
	ELSE 
		Beep ( 1 ) 
	END IF
END IF
end event

event lineup;IF sle_value.enabled THEN
	Int	li_Value
	li_Value = Integer ( sle_Value.Text )
	li_Value ++
	sle_Value.Text = ( String ( li_Value) )
	sle_Value.event modified( )
END IF
end event

type sle_value from singlelineedit within u_cst_integerspin
integer y = 4
integer width = 128
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
string text = "0"
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

event modified;Boolean	lb_Continue = TRUE
Int	li_Temp

IF NOT isNumber ( THIS.Text ) THEN
	lb_Continue = FALSE
	MessageBox ( "Entered Value" , "Please enter a number from " + String (ii_lowerbound ) + " to " + String ( ii_Upperbound ) + "." )
END IF

IF lb_Continue THEN

	li_Temp = Integer ( THIS.Text )
	IF li_Temp >= ii_LowerBound AND  li_Temp <= ii_upperbound THEN
		
	ELSE
		MessageBox ( "Entered Value" , "Please enter a number from " + String (ii_lowerbound ) + " to " + String ( ii_Upperbound ) + "." )
		lb_Continue = FALSE
	END IF
END IF
		
IF lb_Continue THEN
	IF Not isNull ( ii_Warnvalue ) THEN
		IF ii_previous + li_Temp >= ii_Warnvalue and li_Temp > ii_warnvalue THEN
			IF Messagebox ( "Selected Value" , "Are you sure you want to select " +String (li_Temp ) &
				+ "? It could take a few minutes to process the request." , QUESTION!, YesNO!, 2 ) = 2 THEN
				lb_Continue = FALSE
			END IF
		END IF
	END IF	
END IF

IF lb_Continue THEN
	ii_previous = li_Temp	
	Parent.event ue_valuechanged( li_Temp )
ELSE
	Beep ( 1 ) 
	THIS.Text = String ( ii_previous )
END IF
end event

