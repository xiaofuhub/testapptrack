$PBExportHeader$n_cst_setting_newdispatchshippayformat.sru
forward
global type n_cst_setting_newdispatchshippayformat from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_newdispatchshippayformat from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_newdispatchshippayformat n_cst_setting_newdispatchshippayformat

type variables

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(96,la_Value)

ls_Value = Upper(String(la_Value))

CHOOSE CASE ls_Value
	CASE "ITEM!"
		ls_Value = cs_Item
	CASE "FREIGHTACCESSORIAL!"
		ls_Value = cs_Freight_AccTotals
	CASE "GRANDTOTAL!"
		ls_Value = cs_GrandTotal
END CHOOSE		

Return ls_Value



end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

CHOOSE CASE ls_Value
	CASE cs_Item
		la_Value = "ITEM!" 
	CASE cs_Freight_AccTotals
		la_Value = "FREIGHTACCESSORIAL!" 
	CASE cs_GrandTotal
		la_Value = "GRANDTOTAL!" 
END CHOOSE		

This.of_SetSetting(96,la_Value,lnv_settings.cs_datatype_string)

Return 1



end function

on n_cst_setting_newdispatchshippayformat.create
call super::create
end on

on n_cst_setting_newdispatchshippayformat.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Receivable and Payables Format for New Dispatch Shipment."
isa_MultiChoice[] = {cs_Item					& 
						  ,cs_Freight_AccTotals	&
						  ,cs_GrandTotal}		  

end event

