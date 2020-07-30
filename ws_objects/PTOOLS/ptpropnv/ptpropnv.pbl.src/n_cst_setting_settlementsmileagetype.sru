$PBExportHeader$n_cst_setting_settlementsmileagetype.sru
forward
global type n_cst_setting_settlementsmileagetype from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_settlementsmileagetype from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_settlementsmileagetype n_cst_setting_settlementsmileagetype

type variables
Protected:

CONSTANT String	cs_Practical			= "Practical"
CONSTANT String	cs_Short		 			= "Short"
CONSTANT String	cs_National_Network 	= "National Network"
CONSTANT String	cs_Avoid_Toll			= "Avoid Toll"
CONSTANT String	cs_Air					= "Air"




end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(12,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE Long(la_Value)
	CASE 0
		ls_Value = cs_Practical
	CASE 1
		ls_Value = cs_Short
	CASE 2
		ls_Value = cs_National_Network
	CASE 3
		ls_Value = cs_Avoid_Toll
	CASE 4
		ls_Value = cs_Air
END CHOOSE		

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_Practical
		la_Value = 0
	CASE cs_Short
		la_Value = 1
	CASE cs_National_Network
		la_Value = 2
	CASE cs_Avoid_Toll
		la_Value = 3
	CASE cs_Air
		la_Value = 4
END CHOOSE		

This.of_SetSetting(12,la_Value,lnv_settings.cs_datatype_long)

Return 1
end function

on n_cst_setting_settlementsmileagetype.create
call super::create
end on

on n_cst_setting_settlementsmileagetype.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Mileage Type for Settlements."
isa_MultiChoice[] = {cs_Practical			& 
						  ,cs_Short					&
						  ,cs_National_Network	&
						  ,cs_Avoid_Toll			&
						  ,cs_Air}			  


end event

