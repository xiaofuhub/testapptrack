$PBExportHeader$n_cst_setting_invoicesize.sru
forward
global type n_cst_setting_invoicesize from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_invoicesize from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_invoicesize n_cst_setting_invoicesize

type variables
Protected:

CONSTANT String	cs_HalfSheet = "Half Sheet"
CONSTANT String	cs_FullSheet = "Full Sheet"

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(21,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "FULL_PAGE!" THEN
	ls_Value = THIS.cs_fullsheet
ELSE
	ls_Value = THIS.cs_halfsheet
END IF

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF ls_Value = THIS.cs_halfsheet  THEN
	la_Value = "HALF_PAGE!"
ELSE
	la_Value = "FULL_PAGE!"
END IF

This.of_SetSetting(21,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_invoicesize.create
call super::create
end on

on n_cst_setting_invoicesize.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Invoice Size."
isa_MultiChoice[] = {cs_halfsheet,cs_fullsheet}



end event

