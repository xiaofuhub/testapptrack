$PBExportHeader$u_cst_syssettings_enumerated_cbx.sru
$PBExportComments$ZMC
forward
global type u_cst_syssettings_enumerated_cbx from u_cst_syssettings_enumerated
end type
type cbx_1 from checkbox within u_cst_syssettings_enumerated_cbx
end type
end forward

global type u_cst_syssettings_enumerated_cbx from u_cst_syssettings_enumerated
integer width = 2441
integer height = 124
long backcolor = 12632256
event ue_choicechanged ( string as_value )
cbx_1 cbx_1
end type
global u_cst_syssettings_enumerated_cbx u_cst_syssettings_enumerated_cbx

type variables
Constant String cs_Yes = "Yes"
Constant String cs_No = "No"
end variables

event ue_choicechanged(string as_value);inv_syssetting.of_savevalue( as_Value )
end event

on u_cst_syssettings_enumerated_cbx.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on u_cst_syssettings_enumerated_cbx.destroy
call super::destroy
destroy(this.cbx_1)
end on

event ue_setvalue;call super::ue_setvalue;Integer li_Return = -1 

String ls_value
IF IsValid(inv_syssetting) THEN
	ls_value = inv_syssetting.of_getvalue( )
	li_Return = 1 
END IF

IF li_Return = 1 THEN
	IF ls_Value = cs_Yes THEN
		This.cbx_1.Checked = TRUE
	ELSE
		This.cbx_1.Checked = FALSE
	END IF		
END IF

Return li_Return
end event

event ue_setproperty;call super::ue_setproperty;IF IsValid(inv_sysSetting) THEN 
	This.cbx_1.Text = inv_sysSetting.of_getlabel( ) 
END IF	

Return AncestorReturnValue
end event

type cbx_1 from checkbox within u_cst_syssettings_enumerated_cbx
integer x = 23
integer y = 24
integer width = 2405
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
end type

event clicked;IF this.checked THEN
	Parent.event ue_choicechanged(cs_Yes)
ELSE
	Parent.event ue_choicechanged(cs_No)
END IF
end event

