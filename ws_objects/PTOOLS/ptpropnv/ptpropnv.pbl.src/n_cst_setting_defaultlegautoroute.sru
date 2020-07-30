$PBExportHeader$n_cst_setting_defaultlegautoroute.sru
forward
global type n_cst_setting_defaultlegautoroute from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaultlegautoroute from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaultlegautoroute n_cst_setting_defaultlegautoroute

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(107,la_Value)

ls_Value = String(la_Value)

CHOOSE CASE ls_Value
	CASE "0"
		ls_Value = cs_All
	CASE "1"
		ls_Value = "1"
	CASE "2"
		ls_Value = "2"
	CASE "3"
		ls_Value = "3"
	CASE "4"
		ls_Value = "4"
	CASE "5"
		ls_Value = "5"
	CASE "6"
		ls_Value = "6"
	CASE "7"
		ls_Value = "7"
	CASE "8"
		ls_Value = "8"
	CASE "9"
		ls_Value = "9"
	CASE "10"
		ls_Value = "10"
	CASE ELSE
		ls_Value = ls_Value
END CHOOSE	

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Int 	 li_ReturnValue = 1
Any 	 la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = Trim(String(aa_Value))

CHOOSE CASE ls_Value
	CASE cs_All 
		la_Value = "0"
	CASE '1'
		la_Value = "1"
	CASE '2'
		la_Value = "2"
	CASE '3'
		la_Value = "3"
	CASE '4'
		la_Value = "4"
	CASE '5'
		la_Value = "5"
	CASE '6'
		la_Value = "6"
	CASE '7'
		la_Value = "7"
	CASE '8'
		la_Value = "8"
	CASE '9'
		la_Value = "9"
	CASE '10'
		la_Value = "10"
	CASE ELSE
		la_Value = ls_Value
END CHOOSE	

This.of_SetSetting(107,la_Value,lnv_settings.cs_datatype_string)

Return li_ReturnValue

end function

on n_cst_setting_defaultlegautoroute.create
call super::create
end on

on n_cst_setting_defaultlegautoroute.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Default Leg for Auto Route."
end event

