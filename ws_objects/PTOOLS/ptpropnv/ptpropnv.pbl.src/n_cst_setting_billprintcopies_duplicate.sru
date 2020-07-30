$PBExportHeader$n_cst_setting_billprintcopies_duplicate.sru
forward
global type n_cst_setting_billprintcopies_duplicate from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_billprintcopies_duplicate from n_cst_syssettings_sle
end type
global n_cst_setting_billprintcopies_duplicate n_cst_setting_billprintcopies_duplicate

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) AND isNumber( ls_value )  THEN
	IF Long(ls_value) >= 0 THEN
		This.of_SetSetting(251,ls_Value,lnv_settings.cs_datatype_string)
	ELSE
		li_ReturnValue = -1
	END IF
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(251,la_Value)

ls_Value = String(la_Value)

IF len(ls_value ) > 0 THEN
	//there is a setting
ELSE
	ls_value = "1"  //default to 1 copy
END IF

Return ls_Value
end function

on n_cst_setting_billprintcopies_duplicate.create
call super::create
end on

on n_cst_setting_billprintcopies_duplicate.destroy
call super::destroy
end on

event constructor;call super::constructor;is_propertytextlabel = "Duplicate"
end event

