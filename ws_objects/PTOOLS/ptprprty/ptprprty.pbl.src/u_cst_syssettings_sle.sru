$PBExportHeader$u_cst_syssettings_sle.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_sle from u_cst_syssettings
end type
type st_1 from statictext within u_cst_syssettings_sle
end type
type sle_1 from singlelineedit within u_cst_syssettings_sle
end type
type st_2 from statictext within u_cst_syssettings_sle
end type
end forward

global type u_cst_syssettings_sle from u_cst_syssettings
integer width = 2071
integer height = 232
event ue_valuechanged ( string as_value )
st_1 st_1
sle_1 sle_1
st_2 st_2
end type
global u_cst_syssettings_sle u_cst_syssettings_sle

forward prototypes
public subroutine of_setslexpos (long al_value)
public subroutine of_setsleypos (long al_value)
public subroutine of_setslewidth (long al_value)
public subroutine of_setst1visible (boolean ab_value)
public subroutine of_setst2visible (boolean ab_value)
end prototypes

event ue_valuechanged(string as_value);inv_syssetting.of_savevalue( as_Value )
end event

public subroutine of_setslexpos (long al_value);sle_1.x=al_value
end subroutine

public subroutine of_setsleypos (long al_value);sle_1.y=al_value
end subroutine

public subroutine of_setslewidth (long al_value);sle_1.width=al_value
end subroutine

public subroutine of_setst1visible (boolean ab_value);st_1.visible = ab_value
end subroutine

public subroutine of_setst2visible (boolean ab_value);st_2.visible = ab_value
end subroutine

on u_cst_syssettings_sle.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.st_2
end on

on u_cst_syssettings_sle.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.st_2)
end on

event ue_setproperty;call super::ue_setproperty;String ls_Label
Long ll_Pos
IF IsValid(inv_sysSetting) THEN 
	ls_Label = Trim(inv_sysSetting.of_getlabel( )) 
	IF Len(ls_Label) <= 50 THEN
		This.st_1.Text = inv_SysSetting.of_getlabel( ) 
	ELSE
		// Checks for the first period (.) and breaks the text line
		ll_Pos = Pos(ls_Label,".")
		This.st_2.Text = Trim(Left(ls_Label,ll_Pos))
		This.st_1.Text = Trim(Mid(ls_Label,ll_Pos + 1))
	END IF	
END IF	

Return AncestorReturnValue
end event

event ue_setvalue;call super::ue_setvalue;Integer li_Return = -1 

IF IsValid(inv_syssetting) THEN
	sle_1.Text = inv_syssetting.of_getvalue( )
	li_Return = 1 
END IF

Return li_Return
end event

type st_1 from statictext within u_cst_syssettings_sle
integer x = 32
integer y = 72
integer width = 1810
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within u_cst_syssettings_sle
integer x = 37
integer y = 140
integer width = 1349
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;Parent.event ue_ValueChanged(This.Text)
end event

type st_2 from statictext within u_cst_syssettings_sle
integer x = 32
integer y = 4
integer width = 1810
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

