$PBExportHeader$n_cst_setting_compemailnotrecipients.sru
forward
global type n_cst_setting_compemailnotrecipients from n_cst_syssettings_generic_populate
end type
end forward

global type n_cst_setting_compemailnotrecipients from n_cst_syssettings_generic_populate
end type
global n_cst_setting_compemailnotrecipients n_cst_setting_compemailnotrecipients

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
public function integer of_getvalue (ref string asa_value[])
public function string of_getcolheader ()
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(256,ls_Value,lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(256,la_Value)

ls_Value = String(la_Value)

Return ls_Value
end function

public function integer of_getvalue (ref string asa_value[]);// parse and return 
Int li_ReturnValue = 1  
Int li_Len
Int li_Ctr
Int li_Pos

String ls_Value

String lsa_RowValues[]

ls_Value = THIS.of_getvalue( )

n_cst_String lnv_String

lnv_String.of_Parsetoarray(ls_Value,is_delimiter,lsa_RowValues[])

IF UpperBound(lsa_RowValues) > 0 THEN
	asa_Value = lsa_RowValues
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue

end function

public function string of_getcolheader ();Return is_colname
end function

event constructor;call super::constructor;is_PropertyTextlabel = "New Company Email Notification Recipients."
is_colname				= "Email Address"
is_delimiter			= ';'
end event

on n_cst_setting_compemailnotrecipients.create
call super::create
end on

on n_cst_setting_compemailnotrecipients.destroy
call super::destroy
end on

