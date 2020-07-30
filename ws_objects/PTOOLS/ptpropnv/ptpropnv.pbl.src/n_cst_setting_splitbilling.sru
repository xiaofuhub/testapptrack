$PBExportHeader$n_cst_setting_splitbilling.sru
forward
global type n_cst_setting_splitbilling from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_splitbilling from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_splitbilling n_cst_setting_splitbilling

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(65,la_Value)

ls_Value = String(la_Value)

ls_Value = This.of_decideyesnorb(ls_Value)

Return ls_Value


end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF NOT IsNull(ls_Value) THEN
	ls_Value	= This.of_DecideCYesCNo(ls_Value)
	This.of_SetSetting(65,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1
END IF	

Return li_ReturnValue

end function

on n_cst_setting_splitbilling.create
call super::create
end on

on n_cst_setting_splitbilling.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Enable Split Billing."
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No

end event

