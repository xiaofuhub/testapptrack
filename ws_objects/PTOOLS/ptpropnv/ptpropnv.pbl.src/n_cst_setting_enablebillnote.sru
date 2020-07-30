$PBExportHeader$n_cst_setting_enablebillnote.sru
forward
global type n_cst_setting_enablebillnote from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_enablebillnote from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_enablebillnote n_cst_setting_enablebillnote

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(189,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "NO!" THEN
	ls_Value = THIS.cs_NO
ELSE
	ls_Value = THIS.cs_Yes
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

This.of_SetSetting(189,ls_Value,lnv_settings.cs_datatype_string)

Return li_ReturnValue
end function

on n_cst_setting_enablebillnote.create
call super::create
end on

on n_cst_setting_enablebillnote.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Bill note always enabled."
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No
end event

