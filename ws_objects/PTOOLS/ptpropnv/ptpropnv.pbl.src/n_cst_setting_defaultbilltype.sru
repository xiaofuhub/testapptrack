$PBExportHeader$n_cst_setting_defaultbilltype.sru
forward
global type n_cst_setting_defaultbilltype from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaultbilltype from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaultbilltype n_cst_setting_defaultbilltype

type variables
Constant String cs_UnClassified 	= "UNCLASSIFIED"
Constant String cs_Prepaid 		= "PREPAID"
Constant String cs_Collect 		= "COLLECT"
Constant String cs_3RDParty 		= "3RD PARTY"
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(166,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE ls_Value
	CASE "Z"
		ls_Value = cs_unclassified
	CASE "P"
		ls_Value = cs_prepaid
	CASE "C"
		ls_Value = cs_collect
	CASE "T"
		ls_Value = cs_3rdparty
	CASE ELSE
		ls_Value = cs_unclassified
END CHOOSE		

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_unclassified
		la_Value = "Z" 
	CASE cs_prepaid
		la_Value = "P" 
	CASE cs_collect
		la_Value = "C"
	CASE cs_3rdparty
		la_Value = "T"
END CHOOSE		

This.of_SetSetting(166,la_Value,lnv_settings.cs_datatype_string)

Return 1
end function

on n_cst_setting_defaultbilltype.create
call super::create
end on

on n_cst_setting_defaultbilltype.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Default Bill Type."
isa_MultiChoice[] = {cs_UnClassified,cs_Prepaid,cs_Collect,cs_3RDParty} 		


end event

