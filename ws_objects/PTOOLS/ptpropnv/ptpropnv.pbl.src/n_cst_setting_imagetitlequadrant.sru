$PBExportHeader$n_cst_setting_imagetitlequadrant.sru
forward
global type n_cst_setting_imagetitlequadrant from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_imagetitlequadrant from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_imagetitlequadrant n_cst_setting_imagetitlequadrant

type variables
Protected:

CONSTANT String	cs_UpperRight 	= "Upper Right"
CONSTANT String	cs_UpperLeft	= "Upper Left"
CONSTANT String	cs_LowerRight 	= "Lower Right"
CONSTANT String	cs_LowerLeft	= "Lower Left"

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(35,la_Value)

ls_Value = String(la_Value)

CHOOSE CASE ls_Value
	CASE "UR!"
		ls_Value = THIS.cs_UpperRight
	CASE "UL!"
		ls_Value = THIS.cs_UpperLeft
	CASE "LL!"
		ls_Value = THIS.cs_LowerLeft
	CASE "LR!"
		ls_Value = THIS.cs_LowerRight
END CHOOSE	

Return ls_Value




end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE THIS.cs_UpperRight 
		la_Value = "UR!"
	CASE THIS.cs_UpperLeft
		la_Value = "UL!" 
	CASE THIS.cs_LowerLeft
		la_Value = "LL!" 
	CASE THIS.cs_LowerRight
		la_Value = "LR!" 
END CHOOSE	

This.of_SetSetting(35,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_imagetitlequadrant.create
call super::create
end on

on n_cst_setting_imagetitlequadrant.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Quadrant for Image Title."
isa_MultiChoice[] 	= {cs_UpperRight,cs_UpperLeft &
							  ,cs_LowerRight,cs_LowerLeft}


end event

