$PBExportHeader$n_cst_setting_imagezoomtofit.sru
forward
global type n_cst_setting_imagezoomtofit from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_imagezoomtofit from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_imagezoomtofit n_cst_setting_imagezoomtofit

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1 
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF NOT IsNull(ls_Value) THEN
	ls_Value	= This.of_DecideCYesCNo(ls_Value)
	This.of_SetSetting(246,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1
END IF	

Return li_ReturnValue

end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(246,la_Value)

ls_Value = String(la_Value)

//default to yes for people who already have 7 who haven't complained.
IF isNull( ls_value ) OR len( ls_value ) = 0 THEN
	ls_value = "YES!"
END IF

ls_Value = This.of_DecideYesNoRB(ls_Value)

Return ls_Value
end function

on n_cst_setting_imagezoomtofit.create
call super::create
end on

on n_cst_setting_imagezoomtofit.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Zoom to fit display"
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No
end event

