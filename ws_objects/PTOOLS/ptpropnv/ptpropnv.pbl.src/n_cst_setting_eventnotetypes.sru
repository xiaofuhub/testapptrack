﻿$PBExportHeader$n_cst_setting_eventnotetypes.sru
forward
global type n_cst_setting_eventnotetypes from n_cst_syssettings_generic_populate
end type
end forward

global type n_cst_setting_eventnotetypes from n_cst_syssettings_generic_populate
end type
global n_cst_setting_eventnotetypes n_cst_setting_eventnotetypes

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
public function string of_getcolheader ()
public function integer of_getvalue (ref string asa_value[])
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(87,la_Value)

ls_Value = String(la_Value)

Return ls_Value
end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

//Messagebox('ls_Value',ls_Value)
IF Not IsNull(ls_Value) THEN
	// Check for masking before saving
	This.of_SetSetting(87,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

public function string of_getcolheader ();Return is_colname
end function

public function integer of_getvalue (ref string asa_value[]);// parse and return 
Int li_ReturnValue = 1  

String ls_Value
String lsa_RowValues[]

n_cst_String lnv_String

ls_Value = THIS.of_getvalue( )

lnv_String.of_Parsetoarray(ls_Value,is_delimiter,lsa_RowValues[])

IF UpperBound(lsa_RowValues) > 0 THEN
	asa_Value = lsa_RowValues
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue
end function

on n_cst_setting_eventnotetypes.create
call super::create
end on

on n_cst_setting_eventnotetypes.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "List of Types For Event Note."
is_colname				= "Types for Event Note"
is_delimiter			= ','
end event

