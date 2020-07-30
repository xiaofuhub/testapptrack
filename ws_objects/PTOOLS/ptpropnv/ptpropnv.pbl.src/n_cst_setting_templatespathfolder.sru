$PBExportHeader$n_cst_setting_templatespathfolder.sru
forward
global type n_cst_setting_templatespathfolder from n_cst_syssettings_folders
end type
end forward

global type n_cst_setting_templatespathfolder from n_cst_syssettings_folders
end type
global n_cst_setting_templatespathfolder n_cst_setting_templatespathfolder

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(67,la_Value)

ls_Value = String(la_Value)

IF Len ( ls_Value ) > 0 THEN
	If Right ( TRIM ( ls_Value ) , 1  ) <> '\' THEN
		ls_Value += '\'
	END IF
END IF

Return ls_Value


end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(67,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue


end function

on n_cst_setting_templatespathfolder.create
call super::create
end on

on n_cst_setting_templatespathfolder.destroy
call super::destroy
end on

event constructor;call super::constructor;is_propertytextlabel = "Full Path to Templates Folder."
end event

