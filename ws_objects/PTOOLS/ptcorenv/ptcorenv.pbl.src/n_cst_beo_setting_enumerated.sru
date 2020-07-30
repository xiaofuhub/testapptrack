$PBExportHeader$n_cst_beo_setting_enumerated.sru
forward
global type n_cst_beo_setting_enumerated from n_cst_beo_setting
end type
end forward

global type n_cst_beo_setting_enumerated from n_cst_beo_setting
end type

type variables
Private:
String	isa_DisplayValues[]
Any	iaa_DataValues[]
end variables

forward prototypes
public function long of_getvaluecount ()
public function integer of_addvalue (any aa_datavalue, string as_displayvalue)
public function string of_getdisplayvalue (long al_index)
protected function long of_getnextindex ()
public function integer of_setvalue (string as_value)
protected function integer of_setvalue (long al_index)
public function long of_getdisplaylist (ref string asa_list[])
private function integer of_getdatavalue (long al_index, ref any aa_value)
public function string of_getdisplayvalue ()
private function long of_find (any aa_value)
end prototypes

public function long of_getvaluecount ();RETURN UpperBound ( isa_DisplayValues )
end function

public function integer of_addvalue (any aa_datavalue, string as_displayvalue);Long	ll_Index
Integer	li_Return

ll_Index = of_GetNextIndex ( )

IF ll_Index > 0 THEN
	iaa_DataValues [ ll_Index ] = aa_DataValue
	isa_DisplayValues [ ll_Index ] = as_DisplayValue
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function string of_getdisplayvalue (long al_index);String	ls_DisplayValue

IF al_Index <= of_GetValueCount ( ) AND &
	al_Index > 0 THEN

	ls_DisplayValue = isa_DisplayValues [ al_Index ]

ELSE
	SetNull ( ls_DisplayValue )

END IF

RETURN ls_DisplayValue
end function

protected function long of_getnextindex ();Long	ll_Index

ll_Index = of_GetValueCount ( )

IF ll_Index >= 0 THEN
	ll_Index ++
ELSE
	ll_Index = 1
END IF

RETURN ll_Index
end function

public function integer of_setvalue (string as_value);Long	ll_Count, &
		ll_Ndx, &
		ll_Match
Integer	li_Return

ll_Count = of_GetValueCount ( )

FOR ll_Ndx = 1 TO ll_Count

	IF Upper ( of_GetDisplayValue ( ll_Ndx ) ) = Upper ( as_Value ) THEN

		ll_Match = ll_Ndx
		EXIT

	END IF

NEXT

IF ll_Match > 0 THEN

	li_Return = of_SetValue ( ll_Match )

ELSE

	li_Return = 0

END IF

RETURN li_Return
end function

protected function integer of_setvalue (long al_index);Any	la_Value
Integer	li_Return

IF of_GetDataValue ( al_Index, la_Value ) = 1 THEN
	li_Return = of_SetAny ( of_GetValueColumn ( ), la_Value )
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function long of_getdisplaylist (ref string asa_list[]);Long	ll_Count, &
		ll_Ndx
String	lsa_List[]

ll_Count = of_GetValueCount ( )

FOR ll_Ndx = 1 TO ll_Count

	lsa_List [ ll_Ndx ] = of_GetDisplayValue ( ll_Ndx )

NEXT

asa_List = lsa_List
ll_Count = UpperBound ( asa_List )

RETURN ll_Count
end function

private function integer of_getdatavalue (long al_index, ref any aa_value);Any	la_DataValue
Integer	li_Return

IF al_Index <= of_GetValueCount ( ) AND &
	al_Index > 0 THEN

	la_DataValue = iaa_DataValues [ al_Index ]
	li_Return = 1

ELSE

	li_Return = 0

END IF

aa_Value = la_DataValue

RETURN li_Return
end function

public function string of_getdisplayvalue ();Any	la_DataValue
Long	ll_Index

IF of_HasSource ( ) THEN
	la_DataValue = of_GetValue ( )
	ll_Index = of_Find ( la_DataValue )
END IF

RETURN of_GetDisplayValue ( ll_Index )
end function

private function long of_find (any aa_value);Long	ll_Count, &
		ll_Ndx, &
		ll_Match
Any	la_Value

ll_Count = of_GetValueCount ( )

FOR ll_Ndx = 1 TO ll_Count

	IF of_GetDataValue ( ll_Ndx, la_Value ) = 1 THEN

		IF aa_Value = la_Value THEN
			ll_Match = ll_Ndx
			EXIT
		END IF

	END IF

NEXT

RETURN ll_Match
end function

on n_cst_beo_setting_enumerated.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_setting_enumerated.destroy
TriggerEvent( this, "destructor" )
end on

