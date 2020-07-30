$PBExportHeader$n_cst_setting_sendnewcompanyemail.sru
forward
global type n_cst_setting_sendnewcompanyemail from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_sendnewcompanyemail from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_sendnewcompanyemail n_cst_setting_sendnewcompanyemail

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
end prototypes

public function integer of_savevalue (any aa_value);Any 		la_Value

n_cst_Settings lnv_settings
IF String ( aa_value ) = THIS.cs_Yes THEN
	la_Value = "YES!"
ELSE
	la_Value = "NO!"
END IF
THIS.of_SetSetting(255,la_Value,lnv_settings.cs_datatype_string)

Return 1
end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(255,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "YES!" THEN
	ls_Value = THIS.cs_Yes
ELSE
	ls_Value = THIS.cs_no
END IF

Return ls_Value
end function

event constructor;call super::constructor;is_PropertyTextlabel = "Send email upon company creation?"
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No
end event

on n_cst_setting_sendnewcompanyemail.create
call super::create
end on

on n_cst_setting_sendnewcompanyemail.destroy
call super::destroy
end on

