$PBExportHeader$n_cst_setting_defaultshipmentsummary.sru
forward
global type n_cst_setting_defaultshipmentsummary from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaultshipmentsummary from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaultshipmentsummary n_cst_setting_defaultshipmentsummary

type variables
String isa_Types[]
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(163, la_Value)

ls_Value = String(la_Value)

Return ls_Value


end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) THEN
	This.of_SetSetting(163, ls_Value, lnv_settings.cs_datatype_string)
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue


end function

event constructor;call super::constructor;Long	ll_index, &
		ll_Count
		
String lsa_ViewList[]

n_cst_Dws		lnv_Dws

is_PropertyTextlabel = "Default Shipment Summary Display."

isa_MultiChoice[1] = "Overview"
isa_MultiChoice[2] = "Appointments"
isa_MultiChoice[3] = "Billing Info"
isa_MultiChoice[4] = "Inbound Pending"
isa_MultiChoice[5] = "Inbound Loads"
isa_MultiChoice[6] = "Inbound Returns"
isa_MultiChoice[7] = "Outbound Empties"
isa_MultiChoice[8] = "Outbound Loading"
isa_MultiChoice[9] = "Outbound Ready"
isa_MultiChoice[10] = "One Ways" 
	
//Add any custom view definitions to the display option list.

//Get the list.
ll_Count = lnv_Dws.of_GetCustomViewList ( "ShipmentList", lsa_ViewList )

//Add them to the list.

FOR ll_Index = 1 TO ll_Count

	isa_MultiChoice[upperbound(isa_MultiChoice) + 1] = lsa_ViewList [ ll_Index ]

NEXT


end event

on n_cst_setting_defaultshipmentsummary.create
call super::create
end on

on n_cst_setting_defaultshipmentsummary.destroy
call super::destroy
end on

