$PBExportHeader$n_cst_setting_shipprimrefval.sru
forward
global type n_cst_setting_shipprimrefval from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_shipprimrefval from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_shipprimrefval n_cst_setting_shipprimrefval

type variables
Protected:

CONSTANT String	cs_Open	 		= "Open"

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(72,la_Value)

ls_Value = String(la_Value)
// Changed the default value to match the default processing in the 
// scripts that were checking the setting directly by number
IF ls_Value = "All!" THEN
	ls_Value = THIS.cs_All
ELSE
	ls_Value = THIS.cs_Open
END IF

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF ls_Value = THIS.cs_Open  THEN
	la_Value = "Open!"
ELSE
	la_Value = "All!"
END IF

This.of_SetSetting(72,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_shipprimrefval.create
call super::create
end on

on n_cst_setting_shipprimrefval.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Shipments to Validate Against Prim Ref."
isa_MultiChoice[] 	= {cs_Open,cs_All}


end event

