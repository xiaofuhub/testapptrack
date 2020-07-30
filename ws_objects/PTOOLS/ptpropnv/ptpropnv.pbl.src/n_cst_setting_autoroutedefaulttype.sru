$PBExportHeader$n_cst_setting_autoroutedefaulttype.sru
forward
global type n_cst_setting_autoroutedefaulttype from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_autoroutedefaulttype from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_autoroutedefaulttype n_cst_setting_autoroutedefaulttype

type variables

Constant String cs_Any		= "ANY"
Constant String cs_PickUp	= "PICKUP"
Constant String cs_Deliver	= "DELIVER"


end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(106,la_Value)

ls_Value = String(la_Value) 

CHOOSE CASE ls_Value
	CASE "ANY"
		ls_Value = cs_Any
	CASE "PICKUP"
	ls_Value = cs_PickUp
	CASE "DELIVER"
	ls_Value = cs_Deliver
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
	CASE cs_Any 
		la_Value = "ANY"
	CASE cs_PickUp
		la_Value = "PICKUP" 
	CASE cs_Deliver
		la_Value = "DELIVER" 
	CASE cs_None
		la_Value = "NONE!"
END CHOOSE	

This.of_SetSetting(106,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_autoroutedefaulttype.create
call super::create
end on

on n_cst_setting_autoroutedefaulttype.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Default Type for Auto Route."
isa_MultiChoice[] 	= {cs_Any,cs_PickUp,cs_Deliver,cs_None}


end event

