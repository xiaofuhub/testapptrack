$PBExportHeader$n_cst_setting_edi204version.sru
forward
global type n_cst_setting_edi204version from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_edi204version from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_edi204version n_cst_setting_edi204version

type variables
CONSTANT	String	cs_EDIVersion_Pseudo = "1.0 (pseudo)"  		// mcst
CONSTANT	String	cs_EDIVersion_VanMapping = "2.0 (VAN mapping)"  // Toal WH
CONSTANT	String	cs_EDIVersion_DirectWithAutoReply = "3.0 (Direct auto accept)"
CONSTANT	String	cs_EDIVersion_Direct	= "4.0 (Direct)"
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(174,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE ls_Value
	CASE "1.0!"
		ls_Value = cs_ediversion_pseudo
	CASE "2.0!"  
		ls_Value	= cs_ediversion_vanmapping
	CASE "3.0!"
		ls_Value = cs_ediversion_directwithautoreply
	CASE "4.0!"
		ls_Value = cs_ediversion_direct
		
END CHOOSE		

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_ediversion_pseudo
		la_Value = "1.0!"
		
	CASE cs_ediversion_vanmapping
		la_Value = "2.0!"
		
	CASE cs_ediversion_directwithautoreply
		la_Value = "3.0!"
		
	CASE cs_ediversion_direct
		la_Value = "4.0!"
		
END CHOOSE		

This.of_SetSetting(174,la_Value,lnv_settings.cs_datatype_string)

Return 1
end function

on n_cst_setting_edi204version.create
call super::create
end on

on n_cst_setting_edi204version.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "EDI Version"
isa_MultiChoice[] 	= {cs_EDIVersion_Pseudo	& 
						  	  ,cs_EDIVersion_VanMapping &
							  ,cs_EDIVersion_DirectWithAutoReply &
						     ,cs_EDIVersion_Direct}



end event

