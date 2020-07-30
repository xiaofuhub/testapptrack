$PBExportHeader$n_cst_setting_daysofitintocache.sru
forward
global type n_cst_setting_daysofitintocache from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_daysofitintocache from n_cst_syssettings_sle
end type
global n_cst_setting_daysofitintocache n_cst_setting_daysofitintocache

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();Int 	li_Value
Any 		la_Value
Int		li_GetRtn
n_cst_Settings lnv_settings

li_GetRtn = lnv_settings.of_GetSetting(239,la_Value)

li_Value = Integer (la_Value)
IF isNull ( li_Value ) OR li_GetRtn = 0 THEN
	li_Value = 30
END IF

Return String ( li_Value )

end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value
Int	li_value
n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) And IsNumber ( ls_Value ) THEN
	li_Value = Integer ( ls_Value )
	IF li_Value >= 0 AND li_Value < 365 THEN	
		This.of_SetSetting(239,li_Value,lnv_settings.cs_datatype_long)
	ELSE
		li_ReturnValue = -1
	END IF
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue





end function

on n_cst_setting_daysofitintocache.create
call super::create
end on

on n_cst_setting_daysofitintocache.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "# of days to look back for Drivers during assignments"
end event

