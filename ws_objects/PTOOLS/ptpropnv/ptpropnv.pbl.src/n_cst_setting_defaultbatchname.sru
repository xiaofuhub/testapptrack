$PBExportHeader$n_cst_setting_defaultbatchname.sru
forward
global type n_cst_setting_defaultbatchname from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaultbatchname from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaultbatchname n_cst_setting_defaultbatchname

type variables
Protected:

CONSTANT String	cs_Always = "Always"
CONSTANT String	cs_Never	 = "Never"


end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(52,la_Value)

ls_Value = String(la_Value)

CHOOSE CASE ls_Value
	CASE "YES!"
		ls_Value = THIS.cs_Always
	CASE "NO!"
	ls_Value = THIS.cs_Never
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
	CASE THIS.cs_Always
		la_Value = "YES!"
	CASE THIS.cs_Never
		la_Value = "NO!" 
	CASE THIS.cs_Ask
		la_Value = "ASK!" 
END CHOOSE	

This.of_SetSetting(52,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_defaultbatchname.create
call super::create
end on

on n_cst_setting_defaultbatchname.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Use Default Batch Name."
isa_MultiChoice[] 	= {cs_Always,cs_Never,cs_Ask}


end event

