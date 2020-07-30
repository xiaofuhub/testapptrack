$PBExportHeader$n_cst_setting_invoicebillalign.sru
forward
global type n_cst_setting_invoicebillalign from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_invoicebillalign from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_invoicebillalign n_cst_setting_invoicebillalign

type variables
Protected:

CONSTANT String	cs_LeftSide	 = "Left Side"
CONSTANT String	cs_RightSide = "Right Side"

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(22,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "BILLTO_LEFT!" THEN
	ls_Value = THIS.cs_leftside
ELSE
	ls_Value = THIS.cs_rightside
END IF

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF ls_Value = THIS.cs_LeftSide  THEN
	la_Value = "BILLTO_LEFT!"
ELSE
	la_Value = "BILLTO_RIGHT!"
END IF

This.of_SetSetting(22,la_Value,lnv_settings.cs_datatype_string)

Return 1

end function

on n_cst_setting_invoicebillalign.create
call super::create
end on

on n_cst_setting_invoicebillalign.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Invoice Billto Alignment."
isa_MultiChoice[] 	= {cs_LeftSide,cs_RightSide}


end event

