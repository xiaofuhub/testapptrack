$PBExportHeader$n_cst_setting_newtripendtripcompany.sru
forward
global type n_cst_setting_newtripendtripcompany from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_newtripendtripcompany from n_cst_syssettings_sle
end type
global n_cst_setting_newtripendtripcompany n_cst_setting_newtripendtripcompany

forward prototypes
public function integer of_savevalue (any aa_value)
public function string of_getvalue ()
public function integer of_getvalue (ref long ala_value[])
end prototypes

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
Long	ll_Value

n_cst_Settings lnv_settings

ll_Value = Long (aa_Value)


IF This.of_SetSetting(201, ll_Value, lnv_settings.cs_datatype_long ) <> 1 THEN
	li_ReturnValue = -1
END IF


Return li_ReturnValue
end function

public function string of_getvalue ();Long ll_Value
String 	ls_Value
Any 		la_Value

n_cst_beo_Company	lnv_Company
n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(201,la_Value)

ll_Value = Long(la_Value)

IF Not IsNull(ll_Value) THEN
	gnv_cst_companies.of_Cache( ll_Value , FALSE )
	lnv_Company = CREATE n_cst_beo_Company
	
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_Setsourceid( ll_Value )
	
	ls_Value = lnv_Company.of_Getname( )
	DESTROY ( lnv_Company)
END IF

Return ls_Value

end function

public function integer of_getvalue (ref long ala_value[]);Long ll_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(201,la_Value)

ll_Value = Long(la_Value)
IF ll_Value > 0 THEN
	ala_value[] = {ll_Value}
END IF

RETURN 1

end function

on n_cst_setting_newtripendtripcompany.create
call super::create
end on

on n_cst_setting_newtripendtripcompany.destroy
call super::destroy
end on

event constructor;call super::constructor;is_propertytextlabel = "Default New Trip/End Trip Company Site."
end event

