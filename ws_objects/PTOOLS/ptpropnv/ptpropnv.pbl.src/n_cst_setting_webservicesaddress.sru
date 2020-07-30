$PBExportHeader$n_cst_setting_webservicesaddress.sru
forward
global type n_cst_setting_webservicesaddress from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_webservicesaddress from n_cst_syssettings_sle
end type
global n_cst_setting_webservicesaddress n_cst_setting_webservicesaddress

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(183,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue


end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(183,la_Value)

ls_Value = String(la_Value)

Return ls_Value
end function

on n_cst_setting_webservicesaddress.create
call super::create
end on

on n_cst_setting_webservicesaddress.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Web Services Address"

end event

