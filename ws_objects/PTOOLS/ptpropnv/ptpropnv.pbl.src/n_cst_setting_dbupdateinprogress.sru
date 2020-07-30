$PBExportHeader$n_cst_setting_dbupdateinprogress.sru
forward
global type n_cst_setting_dbupdateinprogress from n_cst_syssettings
end type
end forward

global type n_cst_setting_dbupdateinprogress from n_cst_syssettings
end type
global n_cst_setting_dbupdateinprogress n_cst_setting_dbupdateinprogress

type variables
Public:
Constant String	cs_Locked = "1"
Constant String	cs_Unlocked = "0"
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String	ls_Value
Long		ll_Value

SetNull(ll_Value)

SELECT ss_long INTO :ll_Value
FROM system_settings 
WHERE ss_id = 16;

IF NOT isNull(ll_Value) THEN
	ls_Value = String(ll_Value)
ELSE
	ls_Value = cs_Unlocked
END IF

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(16,ls_Value,lnv_settings.cs_datatype_long)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

on n_cst_setting_dbupdateinprogress.create
call super::create
end on

on n_cst_setting_dbupdateinprogress.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Database Update In Progress"
end event

