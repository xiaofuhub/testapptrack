$PBExportHeader$n_cst_setting_mailauthpassword.sru
forward
global type n_cst_setting_mailauthpassword from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_mailauthpassword from n_cst_syssettings_sle
end type
global n_cst_setting_mailauthpassword n_cst_setting_mailauthpassword

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(113,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(113,la_Value)

ls_Value = String(la_Value)

Return ls_Value


end function

on n_cst_setting_mailauthpassword.create
call super::create
end on

on n_cst_setting_mailauthpassword.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Mail Server Auth. Password"
end event

