$PBExportHeader$n_cst_setting_accpkgs.sru
forward
global type n_cst_setting_accpkgs from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_accpkgs from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_accpkgs n_cst_setting_accpkgs

type variables
Public:

CONSTANT String	cs_BusinessWorks			= "BusinessWorks"
CONSTANT String	cs_BusinessWorksGold5	= "BusinessWorks Gold 5"
CONSTANT String	cs_PeachTree 				= "Peachtree"
CONSTANT String	cs_QB	 						= "QuickBooks"
CONSTANT String	cs_QB2002Direct			= "QuickBooks 2002 Direct"
CONSTANT String	cs_QB2003Direct			= "QuickBooks 2003 Direct"
CONSTANT String	cs_Dynamics45 				= "Dynamics ver. 4 and 5"
CONSTANT String	cs_Dynamics6 				= "Dynamics ver. 6"
CONSTANT String	cs_Dynamics7 				= "Dynamics ver. 7"
CONSTANT String	cs_DacEasy 					= "DacEasy"
CONSTANT String	cs_FlatFileExport			= "Flat File Export"
CONSTANT STring	cs_SAP						= "SAP"




end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(20,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE ls_Value
	CASE "BUSINESSWORKS!"
		ls_Value = cs_BusinessWorks
	CASE "BUSINESSWORKSGOLD5!"
		ls_Value = cs_BusinessWorksGold5
	CASE "PEACHTREE!"
		ls_Value = cs_PeachTree
	CASE "QUICKBOOKS!"
		ls_Value = cs_QB
	CASE "QUICKBOOKSDIRECT2002!"
		ls_Value = cs_QB2002Direct
	CASE "QUICKBOOKSDIRECT2003!"
		ls_Value = cs_QB2003Direct
	CASE "DYNAMICS4AND5!"
		ls_Value = cs_Dynamics45
	CASE "DYNAMICS6!"
		ls_Value = cs_Dynamics6
	CASE "DYNAMICS7!"
		ls_Value = cs_Dynamics7		
	CASE "DACEASY!"
		ls_Value = cs_DacEasy
	CASE "FLATFILE!"
		ls_Value = cs_FlatFileExport
	CASE "SAP!"
		ls_Value = cs_SAP
	CASE "NONE!"
		ls_Value = cs_None 
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
		CASE cs_BusinessWorks 
			la_Value = "BUSINESSWORKS!"
		CASE cs_BusinessWorksGold5
			la_Value = "BUSINESSWORKSGOLD5!"
		CASE cs_PeachTree 
			la_Value = "PEACHTREE!"
		CASE cs_QB 
			la_Value = "QUICKBOOKS!"
		CASE cs_QB2002Direct 
			la_Value = "QUICKBOOKSDIRECT2002!"
		CASE cs_QB2003Direct 
			la_Value = "QUICKBOOKSDIRECT2003!"
		CASE cs_Dynamics45 
			la_Value = "DYNAMICS4AND5!"
		CASE cs_Dynamics6 
			la_Value = "DYNAMICS6!"
		CASE cs_Dynamics7 
			la_Value = "DYNAMICS7!"
		CASE cs_DacEasy 
			la_Value = "DACEASY!"
		CASE cs_FlatFileExport 
			la_Value = "FLATFILE!"
		CASE cs_SAP
			la_Value = "SAP!"
		CASE cs_None 
			la_Value = "NONE!"
	END CHOOSE		
	This.of_SetSetting(20,Upper(la_Value),lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue
end function

on n_cst_setting_accpkgs.create
call super::create
end on

on n_cst_setting_accpkgs.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Accounting Package."
isa_MultiChoice[] = {cs_BusinessWorks	& 
						  ,cs_BusinessWorksGold5 &
						  ,cs_PeachTree		&
						  ,cs_QB					&
						  ,cs_QB2002Direct	&
						  ,cs_QB2003Direct	&
						  ,cs_Dynamics45		&
						  ,cs_Dynamics6		&
						  ,cs_Dynamics7		&
						  ,cs_DacEasy			&
						  ,cs_FlatFileExport &
						  ,cs_SAP            &
						  ,cs_None}
end event

