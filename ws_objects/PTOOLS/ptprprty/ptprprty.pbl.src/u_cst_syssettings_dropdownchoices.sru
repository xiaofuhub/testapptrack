$PBExportHeader$u_cst_syssettings_dropdownchoices.sru
forward
global type u_cst_syssettings_dropdownchoices from u_cst_syssettings
end type
type ddlb_1 from dropdownlistbox within u_cst_syssettings_dropdownchoices
end type
type st_1 from statictext within u_cst_syssettings_dropdownchoices
end type
end forward

global type u_cst_syssettings_dropdownchoices from u_cst_syssettings
integer width = 2135
integer height = 128
event ue_choicechanged ( string as_value )
ddlb_1 ddlb_1
st_1 st_1
end type
global u_cst_syssettings_dropdownchoices u_cst_syssettings_dropdownchoices

forward prototypes
public subroutine of_setst1width (long al_value)
public subroutine of_setst1alignment (string as_value)
public subroutine of_setddlb1xpos (long al_value)
public subroutine of_setddlb1width (long al_value)
end prototypes

event ue_choicechanged(string as_value);inv_syssetting.of_savevalue( as_Value )
end event

public subroutine of_setst1width (long al_value);st_1.width = al_value
end subroutine

public subroutine of_setst1alignment (string as_value);Choose case upper(as_value)
	case 'LEFT'
		st_1.alignment = left!
	case 'CENTER'
		st_1.alignment = Center!
	case 'RIGHT'
		st_1.alignment = Right!
End choose


end subroutine

public subroutine of_setddlb1xpos (long al_value);ddlb_1.x=al_value
end subroutine

public subroutine of_setddlb1width (long al_value);ddlb_1.width = al_value
end subroutine

on u_cst_syssettings_dropdownchoices.create
int iCurrent
call super::create
this.ddlb_1=create ddlb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_1
this.Control[iCurrent+2]=this.st_1
end on

on u_cst_syssettings_dropdownchoices.destroy
call super::destroy
destroy(this.ddlb_1)
destroy(this.st_1)
end on

event ue_setproperty;call super::ue_setproperty;Int li_Ctr
Long ll_UpperBound
String lsa_Array[]

IF IsValid(inv_sysSetting) THEN 
	This.st_1.Text = inv_sysSetting.of_getlabel( ) 
	IF inv_syssetting.Dynamic of_GetArray(lsa_Array[]) = 1 THEN
		ll_UpperBound = UpperBound(lsa_Array)
		FOR li_Ctr = 1 TO ll_UpperBound
			This.ddlb_1.AddItem(lsa_Array[li_Ctr])
		NEXT 	
	END IF
END IF	

Return AncestorReturnValue

end event

event ue_setvalue;call super::ue_setvalue;Integer li_Return = -1 
Integer	li_FindIndex
String ls_value
IF IsValid(inv_syssetting) THEN
	ls_value = inv_syssetting.of_getvalue( )
	li_Return = 1 
END IF

IF li_Return = 1 THEN
	li_FindIndex = This.ddlb_1.FindItem ( ls_Value, 0 )
	IF li_Findindex > 0 THEN
		This.ddlb_1.selectitem(li_Findindex)
	ELSE
		li_Return = -1
	END IF
END IF

Return li_Return



end event

type ddlb_1 from dropdownlistbox within u_cst_syssettings_dropdownchoices
integer x = 1166
integer y = 4
integer width = 741
integer height = 400
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Parent.event ue_choicechanged(This.Text)
end event

type st_1 from statictext within u_cst_syssettings_dropdownchoices
integer x = 9
integer y = 4
integer width = 1161
integer height = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

