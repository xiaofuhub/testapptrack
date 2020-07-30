$PBExportHeader$n_cst_setting_dbbackuplocation.sru
forward
global type n_cst_setting_dbbackuplocation from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_dbbackuplocation from n_cst_syssettings_sle
end type
global n_cst_setting_dbbackuplocation n_cst_setting_dbbackuplocation

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(190,la_Value)

ls_Value = String(la_Value)

n_Cst_String	lnv_String
lnv_String.of_Globalreplace( ls_Value , "\\n" , "\n" , TRUE )

//ls_Value = String(la_Value,"#.##0.0")

Return ls_Value


end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)


n_Cst_String	lnv_String
ls_Value = lnv_String.of_Globalreplace( ls_Value , "\n", "\\n" , TRUE )


IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(190,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue


end function

on n_cst_setting_dbbackuplocation.create
call super::create
end on

on n_cst_setting_dbbackuplocation.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "DB backup location (From server's perspective). NOTE: Scheduler setup also required. (ASA 9.0+)"
end event

