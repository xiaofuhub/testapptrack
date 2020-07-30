$PBExportHeader$u_cst_syssettings_enumerated_2rb.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_enumerated_2rb from u_cst_syssettings_enumerated
end type
type st_1 from statictext within u_cst_syssettings_enumerated_2rb
end type
type rb_2 from radiobutton within u_cst_syssettings_enumerated_2rb
end type
type rb_1 from radiobutton within u_cst_syssettings_enumerated_2rb
end type
end forward

global type u_cst_syssettings_enumerated_2rb from u_cst_syssettings_enumerated
integer width = 2441
integer height = 120
event ue_choicechanged ( string as_value )
st_1 st_1
rb_2 rb_2
rb_1 rb_1
end type
global u_cst_syssettings_enumerated_2rb u_cst_syssettings_enumerated_2rb

type variables

end variables

forward prototypes
public function integer of_setproperty (n_cst_syssettings anv_setting)
public function integer of_setrb1text (n_cst_syssettings anv_setting)
public function integer of_setrb2text (n_cst_syssettings anv_setting)
public function integer of_setvalue (n_cst_syssettings anv_setting)
public function integer of_savevalue (n_cst_syssettings anv_setting, string as_value)
public subroutine of_setlabelheight (integer ai_value)
public function integer of_enable (boolean ab_enable)
end prototypes

event ue_choicechanged(string as_value);inv_syssetting.of_savevalue( as_Value )
end event

public function integer of_setproperty (n_cst_syssettings anv_setting);String	ls_Label

inv_syssetting = anv_setting

ls_Label 	= anv_Setting.of_GetLabel (	)

This.st_1.Text = ls_Label

//String 	ls_RB1Text
//
//ls_RB1Text 	= anv_Setting.of_GetRB1Text	(	)
//
//This.rb_1.Text = ls_RB1Text
//
//RETURN 1




RETURN 1
end function

public function integer of_setrb1text (n_cst_syssettings anv_setting);//String 	ls_RB1Text
//
//ls_RB1Text 	= anv_Setting.of_GetRB1Text	(	)
//
//This.rb_1.Text = ls_RB1Text
//
RETURN -1
end function

public function integer of_setrb2text (n_cst_syssettings anv_setting);String 	ls_RB2Text

ls_RB2Text	= anv_Setting.of_GetRB2Text	(	)

This.rb_2.Text = ls_RB2Text

RETURN 1
end function

public function integer of_setvalue (n_cst_syssettings anv_setting);
RETURN 1
end function

public function integer of_savevalue (n_cst_syssettings anv_setting, string as_value);anv_setting.of_SaveValue(as_value)
Return 1
end function

public subroutine of_setlabelheight (integer ai_value);st_1.height=ai_value
end subroutine

public function integer of_enable (boolean ab_enable);rb_1.Enabled = ab_Enable
rb_2.Enabled = ab_Enable

Return 1
end function

on u_cst_syssettings_enumerated_2rb.create
int iCurrent
call super::create
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_1
end on

on u_cst_syssettings_enumerated_2rb.destroy
call super::destroy
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
end on

event ue_setproperty;call super::ue_setproperty;IF IsValid(inv_sysSetting) THEN 
	This.st_1.Text = inv_sysSetting.of_getlabel( ) 
	This.rb_1.Text = inv_Syssetting.of_Getrb1text( )
	THIS.rb_2.text = inv_syssetting.of_getrb2text( )
END IF	

Return AncestorReturnValue
end event

event ue_setvalue;call super::ue_setvalue;Integer li_Return = -1 

String ls_value
IF IsValid(inv_syssetting) THEN
	ls_value = inv_syssetting.of_getvalue( )
	li_Return = 1 
END IF

IF li_Return = 1 THEN
	IF ls_Value = This.rb_1.text THEN
		This.rb_1.Checked = TRUE
	ELSE
		This.rb_2.Checked = TRUE
	END IF		
END IF

Return li_Return




end event

type st_1 from statictext within u_cst_syssettings_enumerated_2rb
integer x = 18
integer y = 8
integer width = 1253
integer height = 112
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

type rb_2 from radiobutton within u_cst_syssettings_enumerated_2rb
integer x = 1568
integer y = 4
integer width = 229
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;Parent.event ue_choicechanged(This.Text)
end event

type rb_1 from radiobutton within u_cst_syssettings_enumerated_2rb
integer x = 1285
integer y = 4
integer width = 256
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;Parent.event ue_choicechanged(This.Text)




end event

