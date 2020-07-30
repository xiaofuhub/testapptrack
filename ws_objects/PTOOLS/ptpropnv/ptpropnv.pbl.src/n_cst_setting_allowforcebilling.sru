$PBExportHeader$n_cst_setting_allowforcebilling.sru
forward
global type n_cst_setting_allowforcebilling from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_allowforcebilling from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_allowforcebilling n_cst_setting_allowforcebilling

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(26,la_Value)

IF Long(la_Value) = 1  THEN
	ls_Value = THIS.cs_yes
ELSEIF Long(la_Value) = 0 THEN
	ls_Value = THIS.cs_no
END IF

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String  ls_Value
Long ll_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF NOT IsNull(ls_Value) THEN
	IF ls_Value = THIS.cs_Yes THEN
		ll_Value = 1
	ELSEIF ls_Value = THIS.cs_No THEN
		ll_Value = 0
	END IF
	This.of_SetSetting(26,ll_Value,lnv_settings.cs_datatype_long)
ELSE
	li_ReturnValue = -1
END IF	

Return li_ReturnValue
end function

on n_cst_setting_allowforcebilling.create
call super::create
end on

on n_cst_setting_allowforcebilling.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Allow Force Billing."
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No


end event

