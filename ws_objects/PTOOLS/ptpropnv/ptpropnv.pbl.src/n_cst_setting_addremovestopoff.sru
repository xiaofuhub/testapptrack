$PBExportHeader$n_cst_setting_addremovestopoff.sru
forward
global type n_cst_setting_addremovestopoff from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_addremovestopoff from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_addremovestopoff n_cst_setting_addremovestopoff

type variables



end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(139,la_Value)

ls_Value = String(la_Value) 

CHOOSE CASE ls_Value
	CASE "NO!"
		ls_Value = THIS.cs_No
	CASE "YES!"
	ls_Value = THIS.cs_Yes
	CASE "ASK!"
	ls_Value = THIS.cs_AskEachTime
END CHOOSE	

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1 
Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	CHOOSE CASE ls_Value
		CASE THIS.cs_No 
			la_Value = "NO!"
		CASE THIS.cs_Yes
			la_Value = "YES!"
		CASE THIS.cs_AskEachTime
			la_Value = "ASK!"
	END CHOOSE	
	This.of_SetSetting(139,la_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue

end function

on n_cst_setting_addremovestopoff.create
call super::create
end on

on n_cst_setting_addremovestopoff.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Automatically add/remove Stopoff Item."
isa_MultiChoice[] 	= {cs_yes,cs_no,cs_AskEachTime}


end event

