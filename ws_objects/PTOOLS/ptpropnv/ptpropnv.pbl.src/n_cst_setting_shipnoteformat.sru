$PBExportHeader$n_cst_setting_shipnoteformat.sru
forward
global type n_cst_setting_shipnoteformat from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_shipnoteformat from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_shipnoteformat n_cst_setting_shipnoteformat

type variables
Protected:

CONSTANT String	cs_Single 		= "One Single Note"

Public:
CONSTANT String	cs_Individual	= "Individual Notes"

end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(147,la_Value)

ls_Value = String(la_Value)

IF ls_Value = "INDIVIDUAL!" THEN
	ls_Value = THIS.cs_Individual
ELSE
	ls_Value = THIS.cs_Single
END IF

Return ls_Value



end function

public function integer of_savevalue (any aa_value);Any 		la_Value
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF ls_Value = THIS.cs_Single  THEN
	la_Value = "ONENOTE!"
ELSE
	la_Value = "INDIVIDUAL!"
END IF

This.of_SetSetting(147,la_Value,lnv_settings.cs_datatype_string)

Return 1



end function

on n_cst_setting_shipnoteformat.create
call super::create
end on

on n_cst_setting_shipnoteformat.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Shipment Note Format."
isa_MultiChoice[] 	= {cs_Single,cs_Individual}


end event

