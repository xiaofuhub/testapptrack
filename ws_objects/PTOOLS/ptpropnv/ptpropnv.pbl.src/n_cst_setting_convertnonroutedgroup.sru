$PBExportHeader$n_cst_setting_convertnonroutedgroup.sru
forward
global type n_cst_setting_convertnonroutedgroup from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_convertnonroutedgroup from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_convertnonroutedgroup n_cst_setting_convertnonroutedgroup

type variables

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(130,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE ls_Value
	CASE "ENTRY!"
		ls_Value = cs_Entry
	CASE "AUDIT!"
		ls_Value = cs_Audit
	CASE "ADMIN!"
		ls_Value = cs_admin
	CASE "PTADMIN!"
		ls_Value = cs_PTAdmin
	CASE "NONE!"
		ls_Value = cs_None
END CHOOSE		

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_Entry
		la_Value = "ENTRY!" 
	CASE cs_Audit
		la_Value =  "AUDIT!"
	CASE cs_admin
		la_Value = "ADMIN!" 
	CASE cs_PTAdmin
		la_Value = "PTADMIN!" 
	CASE cs_None
		la_Value = "NONE!" 
END CHOOSE			

This.of_SetSetting(130,la_Value,lnv_settings.cs_datatype_string)

Return 1
end function

on n_cst_setting_convertnonroutedgroup.create
call super::create
end on

on n_cst_setting_convertnonroutedgroup.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Groups Who Can Convert Shipments to Non-Routed."
isa_MultiChoice[] = {cs_Entry		&
						  ,cs_Audit		&
						  ,cs_Admin	   &
						  ,cs_PTAdmin  &
						  , cs_None}
end event

