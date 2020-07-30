$PBExportHeader$n_cst_setting_defaultitinerarybutton.sru
forward
global type n_cst_setting_defaultitinerarybutton from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaultitinerarybutton from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaultitinerarybutton n_cst_setting_defaultitinerarybutton

type variables
CONSTANT String	cs_Driver					= "Driver"
CONSTANT String	cs_PowerUnit				= "Power Unit"
CONSTANT String	cs_Trailer		 			= "Trailer/Chassis"
CONSTANT String	cs_Container				= "Container"
CONSTANT String	cs_3rdpartytrip			= "3rd Party Trip"
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(198,la_Value)

ls_Value = String(la_Value)

Return ls_Value
end function

public function integer of_savevalue (any aa_value);String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

This.of_SetSetting(198,ls_Value, lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_defaultitinerarybutton.create
call super::create
end on

on n_cst_setting_defaultitinerarybutton.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Default for Itinerary Selection."
isa_MultiChoice[] 	= {cs_Driver					& 
						  	  ,cs_PowerUnit				&
							  ,cs_Trailer					&
						     ,cs_Container				&
						     ,cs_3rdpartytrip			}
							  

end event

