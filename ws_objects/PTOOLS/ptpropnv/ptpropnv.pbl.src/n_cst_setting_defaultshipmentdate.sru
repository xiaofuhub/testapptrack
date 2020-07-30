$PBExportHeader$n_cst_setting_defaultshipmentdate.sru
forward
global type n_cst_setting_defaultshipmentdate from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_defaultshipmentdate from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_defaultshipmentdate n_cst_setting_defaultshipmentdate

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(167,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "YES!" THEN
	ls_Value = THIS.cs_Yes
ELSE
	ls_Value = THIS.cs_no
END IF

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Any 		la_Value

n_cst_Settings lnv_settings
IF String ( aa_value ) = THIS.cs_Yes THEN
	la_Value = "YES!"
ELSE
	la_Value = "NO!"
END IF
THIS.of_SetSetting(167,la_Value,lnv_settings.cs_datatype_string)

Return 1
end function

on n_cst_setting_defaultshipmentdate.create
call super::create
end on

on n_cst_setting_defaultshipmentdate.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Set Shipment Date to Today's Date?"
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No
end event

