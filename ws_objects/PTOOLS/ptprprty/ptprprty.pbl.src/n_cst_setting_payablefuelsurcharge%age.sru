$PBExportHeader$n_cst_setting_payablefuelsurcharge%age.sru
forward
global type n_cst_setting_payablefuelsurcharge%age from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_payablefuelsurcharge%age from n_cst_syssettings_sle
end type
global n_cst_setting_payablefuelsurcharge%age n_cst_setting_payablefuelsurcharge%age

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(131,la_Value)

ls_Value = String(la_Value)

Return ls_Value


end function

public function integer of_savevalue (any aa_value);Int 		li_ReturnValue = 1
Int		li_Decimal
Int		li_Truncate
String	ls_Value

Decimal{12} ldec_Value

n_cst_Settings lnv_settings

//Truncate to 12 decimal places
ls_Value = aa_Value
li_Decimal = Pos(ls_Value, ".")
li_Truncate = li_Decimal + 12
ls_Value = Left(ls_Value, li_Truncate)

ldec_Value = Dec(ls_Value)

IF Not IsNull(ldec_Value) THEN
	This.of_SetSetting(131,ldec_Value,lnv_settings.cs_datatype_decimal)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue


end function

on n_cst_setting_payablefuelsurcharge%age.create
call super::create
end on

on n_cst_setting_payablefuelsurcharge%age.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Payable Fuel Surcharge Percentage."
end event

