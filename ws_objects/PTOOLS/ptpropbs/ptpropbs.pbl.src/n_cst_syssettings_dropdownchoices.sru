$PBExportHeader$n_cst_syssettings_dropdownchoices.sru
forward
global type n_cst_syssettings_dropdownchoices from n_cst_syssettings
end type
end forward

global type n_cst_syssettings_dropdownchoices from n_cst_syssettings
end type
global n_cst_syssettings_dropdownchoices n_cst_syssettings_dropdownchoices

type variables
Protected:

String 	isa_MultiChoice[]



end variables

forward prototypes
public function integer of_getarray (ref string asa_array[])
public function long of_removealpha (string as_stringvalue)
public function string of_removenumeric (string as_stringvalue)
end prototypes

public function integer of_getarray (ref string asa_array[]);Int li_ReturnValue = -1 
IF UpperBound(isa_MultiChoice[]) > 0 THEN
	asa_array[] = isa_MultiChoice[]
	li_ReturnValue = 1 
END IF

Return li_ReturnValue

end function

public function long of_removealpha (string as_stringvalue);/*
Removes the Alpha part from the passed default fright amount type and returns pure number based values
for diaplay purposes.
*/

Int li_Len
Int li_Ctr
Char lc_value
Long ll_Value 
String ls_Value
String ls_StringValue 


ls_StringValue  = as_StringValue

li_Len = Len(ls_StringValue)

FOR li_Ctr = 1 TO li_Len
	lc_Value = MID(ls_StringValue,li_Ctr,1)
	
	IF IsNumber(lc_Value) THEN
		ls_Value = ls_Value + lc_Value

	END IF	
NEXT
ll_Value  = Long(ls_Value)
	
Return ll_Value
end function

public function string of_removenumeric (string as_stringvalue);/*
Removes the Numeric part from the default freight amount type(s) and returns pure character based values
for diaplay purposes.
*/

Int li_Len
Int li_Ctr
Char lc_value
String ls_Value 
String ls_StringValue 

ls_StringValue  = as_StringValue

n_cst_String lnv_String

li_Len = Len(ls_StringValue)

FOR li_Ctr = 1 TO li_Len
	lc_Value = MID(ls_StringValue,li_Ctr,1)
	
	IF lnv_String.of_IsAlpha(lc_Value) OR lnv_String.of_IsWhiteSpace(lc_Value) THEN
		ls_Value = ls_Value + lc_Value
	END IF	
NEXT
	
Return ls_Value
end function

on n_cst_syssettings_dropdownchoices.create
call super::create
end on

on n_cst_syssettings_dropdownchoices.destroy
call super::destroy
end on

