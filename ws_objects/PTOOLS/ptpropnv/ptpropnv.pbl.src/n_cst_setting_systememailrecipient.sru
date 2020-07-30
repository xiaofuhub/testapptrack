$PBExportHeader$n_cst_setting_systememailrecipient.sru
forward
global type n_cst_setting_systememailrecipient from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_systememailrecipient from n_cst_syssettings_sle
end type
global n_cst_setting_systememailrecipient n_cst_setting_systememailrecipient

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(187,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(187,la_Value)

ls_Value = String(la_Value)

Return ls_Value


end function

on n_cst_setting_systememailrecipient.create
call super::create
end on

on n_cst_setting_systememailrecipient.destroy
call super::destroy
end on

event constructor;call super::constructor;is_propertytextlabel = "System email recipient"
end event

