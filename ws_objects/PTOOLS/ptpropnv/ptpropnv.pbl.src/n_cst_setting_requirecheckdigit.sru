$PBExportHeader$n_cst_setting_requirecheckdigit.sru
forward
global type n_cst_setting_requirecheckdigit from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_requirecheckdigit from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_requirecheckdigit n_cst_setting_requirecheckdigit

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(243,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "YES!" THEN
	ls_Value = THIS.cs_Yes
ELSE
	ls_Value = THIS.cs_No
END IF

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

IF String ( aa_value ) = THIS.cs_Yes THEN
	ls_Value = "YES!"
ELSE
	ls_Value = "NO!"
END IF

This.of_SetSetting(243,ls_Value,lnv_settings.cs_datatype_string)

Return li_ReturnValue
end function

on n_cst_setting_requirecheckdigit.create
call super::create
end on

on n_cst_setting_requirecheckdigit.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Require check digit for containers"
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No
end event

