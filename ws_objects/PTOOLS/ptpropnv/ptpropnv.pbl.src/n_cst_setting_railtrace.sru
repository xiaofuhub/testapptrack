$PBExportHeader$n_cst_setting_railtrace.sru
forward
global type n_cst_setting_railtrace from n_cst_syssettings_enumerated_2rb
end type
end forward

global type n_cst_setting_railtrace from n_cst_syssettings_enumerated_2rb
end type
global n_cst_setting_railtrace n_cst_setting_railtrace

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

//n_cst_Settings lnv_settings

n_cst_LicenseManager		lnv_LicenseManager

//lnv_settings.of_GetSetting(220,la_Value)


//IF RT is active outbound, we can assume it is also active inbound
//becuase of_savevalue sets both inbound and outbound
IF lnv_LicenseManager.of_IsRailTraceActiveOutbound() THEN
	ls_Value = cs_Yes
ELSE
	ls_Value = cs_No
END IF

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Int li_Return = 1
String ls_Value

//n_cst_Settings lnv_settings

n_cst_licensemanager		lnv_LicenseManager

ls_Value = String(aa_Value)

//This will save system_setting 220 in profit tools AND rt_system_settting 1 in proxy table

IF ls_Value = This.cs_Yes THEN
	//Assumes RT is set up
	IF lnv_LicenseManager.of_ActivateRailTrace() <> 1 THEN
		li_Return = -1
	END IF
ELSEIF ls_Value = This.cs_No THEN
	//Assumes RT is set up
	IF lnv_LicenseManager.of_DeActivateRailTrace() <> 1 THEN
		li_Return = -1
	END IF
	
ELSE
	li_Return = -1
END IF

	//Value is no longer saved to cache
//IF li_Return = 1 THEN
//	IF Not IsNull(ls_Value) THEN
//		
//		ls_Value	= This.of_DecideCYesCNo(ls_Value)
//	
//		This.of_SetSetting(220,ls_Value,lnv_settings.cs_datatype_string)
//	ELSE
//		li_Return = -1 
//	END IF
//END IF

Return li_Return
end function

on n_cst_setting_railtrace.create
call super::create
end on

on n_cst_setting_railtrace.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Enable " +  gnv_App.of_GEtRailTraceAppName() + " Application?"
is_RB1Text				= THIS.cs_Yes
is_RB2text				= THIS.cs_No
end event

