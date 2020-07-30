$PBExportHeader$n_cst_setting_defaulttypechassismove.sru
forward
global type n_cst_setting_defaulttypechassismove from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaulttypechassismove from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaulttypechassismove n_cst_setting_defaulttypechassismove

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(88,la_Value)

ls_Value = String(la_Value)

Return ls_Value


end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(88,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue


end function

on n_cst_setting_defaulttypechassismove.create
call super::create
end on

on n_cst_setting_defaulttypechassismove.destroy
call super::destroy
end on

event constructor;call super::constructor;String lsa_array[]								 

is_PropertyTextlabel = "Default Type For Chassis Move. " + & 
						    	"(Enter a value for Chassis Move type)" 			

n_cst_setting_EventNoteTypes lnv_EventNoteTypes	 
lnv_EventNoteTypes = CREATE n_cst_setting_EventNoteTypes


lnv_EventNoteTypes.of_GetValue(lsa_array)								 

isa_MultiChoice[] 	= lsa_array

DESTROY(lnv_EventNoteTypes)
end event

