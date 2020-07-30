$PBExportHeader$n_cst_setting_allowrelinking.sru
forward
global type n_cst_setting_allowrelinking from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_allowrelinking from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_allowrelinking n_cst_setting_allowrelinking

type variables
Protected:
Constant String cs_Relink = "Relink"
Constant String cs_Reload = "Reload" 
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(138,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "YES!" THEN
	ls_Value = THIS.cs_Relink
ELSE
	ls_Value = THIS.cs_Reload
END IF

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF ls_Value = cs_Relink THEN
	la_Value = "YES!"
ELSE
	la_Value = "NO!"
END IF

This.of_SetSetting(138,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_allowrelinking.create
call super::create
end on

on n_cst_setting_allowrelinking.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Allow Relinking or Reloading of Equipment?"
isa_MultiChoice[] 	= {cs_Relink,cs_Reload}

end event

