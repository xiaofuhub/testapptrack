$PBExportHeader$u_cst_syssettings_ddc_defltlegautoroute.sru
$PBExportComments$Inherited from n_cst_syssettings_dropdownchoices
forward
global type u_cst_syssettings_ddc_defltlegautoroute from u_cst_syssettings_dropdownchoices
end type
end forward

global type u_cst_syssettings_ddc_defltlegautoroute from u_cst_syssettings_dropdownchoices
end type
global u_cst_syssettings_ddc_defltlegautoroute u_cst_syssettings_ddc_defltlegautoroute

on u_cst_syssettings_ddc_defltlegautoroute.create
call super::create
end on

on u_cst_syssettings_ddc_defltlegautoroute.destroy
call super::destroy
end on

event ue_setproperty;// Override 

Int li_Return = -1
IF IsValid(inv_sysSetting) THEN 
	This.st_1.Text = inv_sysSetting.of_getlabel( ) 
	li_Return = 1
END IF	

Return li_Return
end event

event ue_setvalue;// Override 
Integer li_Return = -1 
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
		Int i
		i = ddlb_1.Totalitems( )
		This.ddlb_1.selectitem(i + 1)
		This.ddlb_1.Text = ls_value
	END IF
END IF

Return li_Return







end event

event ue_choicechanged;// Override

String ls_Value

ls_Value = Trim(as_Value)

IF (Not IsNumber(ls_Value))  AND (ls_Value <> "ALL") THEN
	MESSAGEBOX("System Setting","Please enter a number")
	ddlb_1.SetFocus()
	Return
ELSE
	inv_syssetting.of_savevalue( ls_Value )
END IF


end event

type ddlb_1 from u_cst_syssettings_dropdownchoices`ddlb_1 within u_cst_syssettings_ddc_defltlegautoroute
boolean allowedit = true
string item[] = {"ALL","1","2","3","4","5","6","7","8","9","10",""}
end type

event ddlb_1::selectionchanged;Parent.event ue_choicechanged(This.Text)


end event

event ddlb_1::modified;call super::modified;Parent.event ue_choicechanged(This.Text)
end event

type st_1 from u_cst_syssettings_dropdownchoices`st_1 within u_cst_syssettings_ddc_defltlegautoroute
end type

