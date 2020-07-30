$PBExportHeader$n_cst_setting_perdiemchargesformat.sru
forward
global type n_cst_setting_perdiemchargesformat from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_perdiemchargesformat from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_perdiemchargesformat n_cst_setting_perdiemchargesformat

type variables
Protected:
Constant String cs_TotalAmount = "Total Amount"
Constant String cs_By_Period	 = "By Period" 


end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(144,la_Value)

ls_Value = String(la_Value) 

CHOOSE CASE ls_Value
	CASE "TOTAL!"
		ls_Value = cs_TotalAmount
	CASE "BYPERIOD!"
	ls_Value = cs_By_Period
END CHOOSE	

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_TotalAmount 
		la_Value = "TOTAL!"
	CASE cs_By_Period
	la_Value = "BYPERIOD!"
END CHOOSE	

This.of_SetSetting(144,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_perdiemchargesformat.create
call super::create
end on

on n_cst_setting_perdiemchargesformat.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Format of Paste Per Diem Charges."
isa_MultiChoice[] 	= {cs_TotalAmount,cs_By_Period}


end event

