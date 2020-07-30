$PBExportHeader$n_cst_setting_billmaniprntorient.sru
forward
global type n_cst_setting_billmaniprntorient from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_billmaniprntorient from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_billmaniprntorient n_cst_setting_billmaniprntorient

type variables
Protected:

CONSTANT String	cs_LandScape 	= "Landscape"
CONSTANT String	cs_Portrait		= "Portrait"

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(43,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "Landscape!" THEN
	ls_Value = THIS.cs_LandScape
ELSE
	ls_Value = THIS.cs_Portrait
END IF

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF ls_Value = THIS.cs_Landscape  THEN
	la_Value = "Landscape!"
ELSE
	la_Value = "Portrait!"
END IF

This.of_SetSetting(43,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_billmaniprntorient.create
call super::create
end on

on n_cst_setting_billmaniprntorient.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Billing Manifest Print Orientation."
isa_MultiChoice[] 	= {cs_LandScape,cs_Portrait}


end event

