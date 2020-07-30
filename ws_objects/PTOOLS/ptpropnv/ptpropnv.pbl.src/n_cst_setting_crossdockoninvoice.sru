$PBExportHeader$n_cst_setting_crossdockoninvoice.sru
forward
global type n_cst_setting_crossdockoninvoice from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_crossdockoninvoice from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_crossdockoninvoice n_cst_setting_crossdockoninvoice

type variables

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(41,la_Value)

ls_Value = String(la_Value)

CHOOSE CASE ls_Value
	CASE "HIDE!"
		ls_Value = THIS.cs_AlwaysHide
	CASE "SHOW!"
	ls_Value = THIS.cs_AlwaysShow
	CASE "ASK!"
	ls_Value = THIS.cs_Ask
END CHOOSE	

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE THIS.cs_AlwaysHide 
		la_Value = "HIDE!"
	CASE THIS.cs_AlwaysShow
	la_Value = "SHOW!" 
	CASE THIS.cs_Ask
	la_Value = "ASK!" 
END CHOOSE	

This.of_SetSetting(41,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_crossdockoninvoice.create
call super::create
end on

on n_cst_setting_crossdockoninvoice.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Crossdock on Invoice."
isa_MultiChoice[] 	= {cs_AlwaysHide,cs_AlwaysShow,cs_Ask}


end event

