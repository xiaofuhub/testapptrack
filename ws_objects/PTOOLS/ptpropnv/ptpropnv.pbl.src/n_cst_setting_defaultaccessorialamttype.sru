$PBExportHeader$n_cst_setting_defaultaccessorialamttype.sru
forward
global type n_cst_setting_defaultaccessorialamttype from n_cst_syssettings_dropdownchoices
end type
end forward

global type n_cst_setting_defaultaccessorialamttype from n_cst_syssettings_dropdownchoices
end type
global n_cst_setting_defaultaccessorialamttype n_cst_setting_defaultaccessorialamttype

type variables
Long il_UpperBound
String isa_Types[]
end variables

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();Int li_Ctr
Long ll_Value
String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(99,la_Value)

ll_Value = Long(la_Value)
IF Not IsNull(ll_Value) THEN
	
	FOR li_Ctr = 1 TO il_UpperBound
		ls_Value = String(ll_Value)
		IF Pos(isa_Types[li_Ctr],ls_Value) > 0 THEN
			ls_Value = of_RemoveNumeric(isa_Types[li_Ctr])
			EXIT
		END IF	
	NEXT
END IF

ls_Value = Left(ls_Value,(Len(ls_Value) - 1))

Return ls_Value



end function

public function integer of_savevalue (any aa_value);Int li_Ctr
Long ll_Value
String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

FOR li_Ctr = 1 TO il_UpperBound
	IF Pos(isa_Types[li_Ctr],ls_Value) > 0 THEN
		ll_Value = of_RemoveAlpha(isa_Types[li_Ctr])
		EXIT
	END IF	
NEXT

la_Value = ll_Value

This.of_SetSetting(99,la_Value,lnv_settings.cs_datatype_long)

Return 1
end function

on n_cst_setting_defaultaccessorialamttype.create
call super::create
end on

on n_cst_setting_defaultaccessorialamttype.destroy
call super::destroy
end on

event constructor;call super::constructor;Int li_Ctr
String ls_Type

is_PropertyTextlabel = "Default Accessorial Amount Type."

n_cst_Presentation_AmountType lnv_PresentationAmountType
n_cst_String lnv_String

lnv_PresentationAmountType.Dynamic of_GetByItemType(n_cst_constants.cs_itemtype_Accessorial,isa_Types[])

il_UpperBound = UpperBound(isa_Types)

IF il_UpperBound > 0 THEN
	FOR li_Ctr = 1 TO il_UpperBound
		ls_Type = of_RemoveNumeric(isa_Types[li_Ctr])
		ls_Type = Left(ls_Type,(Len(ls_Type) - 1))
		isa_MultiChoice[li_Ctr] = ls_Type
	NEXT 
ELSE
	MessageBox('System Settings - Default Freight Amount Type.',& 
					'No Freight Amount Types Found.')
END IF
end event

