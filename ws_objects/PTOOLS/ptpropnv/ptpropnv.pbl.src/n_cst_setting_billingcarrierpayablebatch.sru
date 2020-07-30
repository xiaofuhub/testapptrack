$PBExportHeader$n_cst_setting_billingcarrierpayablebatch.sru
forward
global type n_cst_setting_billingcarrierpayablebatch from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_billingcarrierpayablebatch from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_billingcarrierpayablebatch n_cst_setting_billingcarrierpayablebatch

type variables



end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(100,la_Value)

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

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE THIS.cs_No 
		la_Value = "NO!"
	CASE THIS.cs_Yes
	la_Value = "YES!"
	CASE THIS.cs_AskEachTime
	la_Value = "ASK!"
END CHOOSE	

This.of_SetSetting(100,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_billingcarrierpayablebatch.create
call super::create
end on

on n_cst_setting_billingcarrierpayablebatch.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Create Carrier Payables Batch During Billing."
isa_MultiChoice[] 	= {cs_yes,cs_no,cs_AskEachTime}


end event

