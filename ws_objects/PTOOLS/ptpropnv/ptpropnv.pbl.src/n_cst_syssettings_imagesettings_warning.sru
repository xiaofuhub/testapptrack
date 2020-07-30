$PBExportHeader$n_cst_syssettings_imagesettings_warning.sru
forward
global type n_cst_syssettings_imagesettings_warning from n_cst_syssettings_imagesettings
end type
end forward

global type n_cst_syssettings_imagesettings_warning from n_cst_syssettings_imagesettings
end type
global n_cst_syssettings_imagesettings_warning n_cst_syssettings_imagesettings_warning

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(32,la_Value)

ls_Value = String(la_Value)

Return ls_Value

end function

public function integer of_savevalue (any aa_value);String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_value)

This.of_SetSetting(32,ls_Value,lnv_settings.cs_datatype_string)

Return 1


end function

on n_cst_syssettings_imagesettings_warning.create
call super::create
end on

on n_cst_syssettings_imagesettings_warning.destroy
call super::destroy
end on

