$PBExportHeader$u_cst_syssettings_intergerspin.sru
forward
global type u_cst_syssettings_intergerspin from u_cst_syssettings
end type
type st_1 from statictext within u_cst_syssettings_intergerspin
end type
type uo_1 from u_cst_integerspin within u_cst_syssettings_intergerspin
end type
end forward

global type u_cst_syssettings_intergerspin from u_cst_syssettings
integer width = 1865
integer height = 140
event ue_valuechanged ( integer ai_value )
st_1 st_1
uo_1 uo_1
end type
global u_cst_syssettings_intergerspin u_cst_syssettings_intergerspin

forward prototypes
public function integer of_setbounds (integer ai_lower, integer ai_upper)
end prototypes

event ue_valuechanged(integer ai_value);inv_syssetting.of_savevalue( String ( ai_Value ) )
end event

public function integer of_setbounds (integer ai_lower, integer ai_upper);uo_1.of_Setbounds( ai_lower ,ai_upper , 999 )
RETURN 1
end function

on u_cst_syssettings_intergerspin.create
int iCurrent
call super::create
this.st_1=create st_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.uo_1
end on

on u_cst_syssettings_intergerspin.destroy
call super::destroy
destroy(this.st_1)
destroy(this.uo_1)
end on

event ue_setproperty;call super::ue_setproperty;String ls_Label

IF IsValid(inv_sysSetting) THEN 
	ls_Label = Trim(inv_sysSetting.of_getlabel( )) 
	st_1.Text = ls_Label
END IF	

Return AncestorReturnValue
end event

event ue_setvalue;call super::ue_setvalue;Integer li_Return = -1 

IF IsValid(inv_syssetting) THEN
	uo_1.of_setvalue(Integer ( inv_syssetting.of_getvalue( ))  )
	li_Return = 1 
END IF

Return li_Return
end event

type st_1 from statictext within u_cst_syssettings_intergerspin
integer x = 9
integer y = 32
integer width = 1586
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type uo_1 from u_cst_integerspin within u_cst_syssettings_intergerspin
integer x = 1618
integer y = 24
integer height = 92
integer taborder = 20
long backcolor = 67108864
end type

on uo_1.destroy
call u_cst_integerspin::destroy
end on

event ue_valuechanged;call super::ue_valuechanged;Parent.event ue_valuechanged( ai_value )
end event

