$PBExportHeader$n_cst_setting_produce990edi.sru
forward
global type n_cst_setting_produce990edi from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_produce990edi from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_produce990edi n_cst_setting_produce990edi

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
public function string of_decideyesnorb (string as_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(214,la_Value)

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
	This.of_SetSetting(214,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1
END IF	

Return li_ReturnValue
end function

public function string of_decideyesnorb (string as_value);String ls_value
ls_value = as_value

IF ls_Value = "NO!" THEN
	ls_Value = THIS.cs_no
ELSE
	ls_Value = THIS.cs_yes
END IF

Return ls_value
end function

on n_cst_setting_produce990edi.create
call super::create
end on

on n_cst_setting_produce990edi.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Produce 990 EDI file on accept/decline shipments."
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No
end event

