$PBExportHeader$n_cst_setting_eventlistdisplay.sru
forward
global type n_cst_setting_eventlistdisplay from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_eventlistdisplay from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_eventlistdisplay n_cst_setting_eventlistdisplay

type variables
Constant String	cs_Driver = "DRIVER"
Constant String	cs_Tractor = "TRACTOR"
Constant String	cs_Both = "BOTH"
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(240,la_Value)

IF Not isNull(ls_Value) THEN
	ls_Value = String(la_Value)
ELSE
	ls_Value = cs_Tractor
END IF

Return ls_Value
end function

public function integer of_savevalue (any aa_value);String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

This.of_SetSetting(240,ls_Value, lnv_settings.cs_datatype_string)

Return 1
end function

on n_cst_setting_eventlistdisplay.create
call super::create
end on

on n_cst_setting_eventlistdisplay.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Display on event list."

isa_MultiChoice[1] = cs_Tractor
isa_MultiChoice[2] = cs_Driver
isa_MultiChoice[3] = cs_Both

end event

