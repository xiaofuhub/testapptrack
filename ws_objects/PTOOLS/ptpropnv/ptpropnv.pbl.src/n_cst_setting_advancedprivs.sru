$PBExportHeader$n_cst_setting_advancedprivs.sru
forward
global type n_cst_setting_advancedprivs from n_cst_syssettings_enumerated_cbx
end type
end forward

global type n_cst_setting_advancedprivs from n_cst_syssettings_enumerated_cbx
end type
global n_cst_setting_advancedprivs n_cst_setting_advancedprivs

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	ls_Value	= This.of_DecideCYesNo(ls_Value)
	This.of_SetSetting(211,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(211,la_Value)

IF not IsNUll( la_value ) THEN
	ls_Value = String(la_Value)
ELSE
	ls_value = "NO!"
END IF
ls_Value = This.of_decideyesno(ls_Value)

Return ls_Value

end function

on n_cst_setting_advancedprivs.create
call super::create
end on

on n_cst_setting_advancedprivs.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Use advanced privileges."
end event

