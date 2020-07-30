$PBExportHeader$n_cst_setting_crosscheck2nd3rdref.sru
forward
global type n_cst_setting_crosscheck2nd3rdref from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_crosscheck2nd3rdref from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_crosscheck2nd3rdref n_cst_setting_crosscheck2nd3rdref

type variables
Protected:

Constant String cs_Ref1Empty = "Only If Ref1 is Empty"



end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(143,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE ls_Value
	CASE "YES!"
		ls_Value = cs_Yes
	CASE "NULLREF1!"
		ls_Value = cs_Ref1Empty
	CASE "NO!"
		ls_Value = cs_No
END CHOOSE		

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_Yes
		la_Value = "YES!" 
	CASE cs_Ref1Empty 
		la_Value = "NULLREF1!"
	CASE cs_No
		la_Value = "NO!" 
END CHOOSE		

This.of_SetSetting(143,la_Value,lnv_settings.cs_datatype_string)

Return 1
end function

on n_cst_setting_crosscheck2nd3rdref.create
call super::create
end on

on n_cst_setting_crosscheck2nd3rdref.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Cross Check 2nd and 3rd Ref."
isa_MultiChoice[] = {cs_Yes			&
						  ,cs_Ref1Empty	&
						  ,cs_No}
end event

