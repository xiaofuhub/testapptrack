$PBExportHeader$n_cst_setting_defaultnewshipbutton.sru
forward
global type n_cst_setting_defaultnewshipbutton from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaultnewshipbutton from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaultnewshipbutton n_cst_setting_defaultnewshipbutton

type variables
Protected:

CONSTANT String	cs_Dispatch					= "DISPATCH"
CONSTANT String	cs_Intermodal				= "INTERMODAL"
CONSTANT String	cs_Crossdock	 			= "CROSSDOCK"
CONSTANT String	cs_Nonrouted 				= "NONROUTED"
CONSTANT String	cs_Brokerage				= "BROKERAGE"
CONSTANT String	cs_Nonroutedbrokerage	= "NONROUTEDBROKERAGE"
CONSTANT String	cs_Template					= "TEMPLATE"
CONSTANT String	cs_3rdpartytrip			= "3RDPARTYTRIP"


end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(105,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE ls_Value
	CASE "DISPATCH!"
		ls_Value = cs_Dispatch
	CASE "INTERMODAL!"
		ls_Value = cs_Intermodal
	CASE "CROSSDOCK!"
		ls_Value = cs_Crossdock
	CASE "NONROUTED!"
		ls_Value = cs_Nonrouted
	CASE "BROKERAGE!"
		ls_Value = cs_Brokerage
	CASE "NONROUTEDBROKERAGE!"
		ls_Value = cs_Nonroutedbrokerage
	CASE "TEMPLATE!"
		ls_Value = cs_Template
	CASE "3RDPARTYTRIP!"
		ls_Value = cs_3rdpartytrip
END CHOOSE		

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_Dispatch 
		la_Value = "DISPATCH!"
	CASE cs_Intermodal
		la_Value = "INTERMODAL!" 
	CASE cs_Crossdock 
		la_Value = "CROSSDOCK!"
	CASE cs_Nonrouted 
		la_Value = "NONROUTED!"
	CASE cs_Brokerage 
		la_Value = "BROKERAGE!"
	CASE cs_Nonroutedbrokerage
		la_Value = "NONROUTEDBROKERAGE!" 
	CASE cs_Template
		la_Value = "TEMPLATE!" 
	CASE cs_3rdpartytrip
		la_Value = "3RDPARTYTRIP!" 
END CHOOSE		

This.of_SetSetting(105,la_Value,lnv_settings.cs_datatype_string)

Return 1



end function

on n_cst_setting_defaultnewshipbutton.create
call super::create
end on

on n_cst_setting_defaultnewshipbutton.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Default for New Ship Button."
isa_MultiChoice[] 	= {cs_Dispatch					& 
						  	  ,cs_Intermodal				&
							  ,cs_Crossdock				&
						     ,cs_Nonrouted				&
						     ,cs_Brokerage				&
						     ,cs_Nonroutedbrokerage	&
						     ,cs_Template					&
						     ,cs_3rdpartytrip}


end event

