$PBExportHeader$n_cst_setting_billfuelsurchargetype.sru
forward
global type n_cst_setting_billfuelsurchargetype from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_billfuelsurchargetype from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_billfuelsurchargetype n_cst_setting_billfuelsurchargetype

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(171,la_Value)

ls_Value = String(la_Value) 

CHOOSE CASE ls_Value
	CASE "PERCENTAGE", "PERMILE"
		//OK
	CASE ELSE
		//default
		ls_Value = "PERCENTAGE"
END CHOOSE	

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1 
Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	CHOOSE CASE ls_Value
		CASE THIS.cs_Percentage
			la_Value = "PERCENTAGE"
		CASE THIS.cs_PerMile
			la_Value = "PERMILE"
	END CHOOSE	
	This.of_SetSetting(171,la_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue

end function

event constructor;call super::constructor;is_PropertyTextlabel = "Fuel Surcharge Type."
isa_MultiChoice[] 	= {cs_Percentage,cs_PerMile}

end event

on n_cst_setting_billfuelsurchargetype.create
call super::create
end on

on n_cst_setting_billfuelsurchargetype.destroy
call super::destroy
end on

