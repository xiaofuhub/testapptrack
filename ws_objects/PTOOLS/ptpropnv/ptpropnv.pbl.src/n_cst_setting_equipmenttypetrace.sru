$PBExportHeader$n_cst_setting_equipmenttypetrace.sru
forward
global type n_cst_setting_equipmenttypetrace from n_cst_syssettings
end type
end forward

global type n_cst_setting_equipmenttypetrace from n_cst_syssettings
end type
global n_cst_setting_equipmenttypetrace n_cst_setting_equipmenttypetrace

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(221,la_Value)

IF NOT IsNUll( la_value ) THEN
	ls_Value = String(la_Value)
ELSE
	ls_value = ""
END IF

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Int li_Return = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(221,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_Return = -1 
END IF

Return li_Return
end function

on n_cst_setting_equipmenttypetrace.create
call super::create
end on

on n_cst_setting_equipmenttypetrace.destroy
call super::destroy
end on

