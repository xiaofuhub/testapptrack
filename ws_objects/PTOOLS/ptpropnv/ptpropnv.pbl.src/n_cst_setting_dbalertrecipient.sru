$PBExportHeader$n_cst_setting_dbalertrecipient.sru
forward
global type n_cst_setting_dbalertrecipient from n_cst_syssettings_generic_populate
end type
end forward

global type n_cst_setting_dbalertrecipient from n_cst_syssettings_generic_populate
end type
global n_cst_setting_dbalertrecipient n_cst_setting_dbalertrecipient

forward prototypes
protected function integer of_savevalues (long ala_values[])
public function integer of_getvalue (ref long ala_value[])
end prototypes

protected function integer of_savevalues (long ala_values[]);Int li_ReturnValue = 1


This.of_Setusersetting( 202, ala_values[] )


Return li_ReturnValue
end function

public function integer of_getvalue (ref long ala_value[]);Long	lla_Values[]

n_cst_Settings lnv_settings

lnv_settings.of_Getusersforsetting( 202, lla_Values)

ala_value[] = lla_Values

Return UpperBound ( ala_value[] )

end function

on n_cst_setting_dbalertrecipient.create
call super::create
end on

on n_cst_setting_dbalertrecipient.destroy
call super::destroy
end on

event constructor;call super::constructor;is_PropertyTextlabel = "Database Alert Recipient"
is_colname				= "Employee"
end event

