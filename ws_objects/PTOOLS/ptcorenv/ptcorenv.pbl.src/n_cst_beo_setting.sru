$PBExportHeader$n_cst_beo_setting.sru
forward
global type n_cst_beo_setting from pt_n_cst_beo
end type
end forward

global type n_cst_beo_setting from pt_n_cst_beo autoinstantiate
end type

type variables
Private:
ParmType	ie_DataType
end variables

forward prototypes
public function integer of_setvalue (string as_value)
public function integer of_setdatatype (parmtype ae_datatype)
public function parmtype of_getdatatype ()
protected function string of_getvaluecolumn ()
protected function any of_getvalue ()
public function string of_getdisplayvalue ()
end prototypes

public function integer of_setvalue (string as_value);Any		la_Value
Integer	li_Return = 1

CHOOSE CASE of_GetDataType ( )

CASE TypeString!
	la_Value = as_Value

CASE TypeLong!
	IF IsNumber ( as_Value ) THEN
		la_Value = Long ( as_Value )
	ELSE
		li_Return = -1
	END IF

CASE TypeInteger!
	IF IsNumber ( as_Value ) THEN
		la_Value = Integer ( as_Value )
	ELSE
		li_Return = -1
	END IF

CASE TypeDecimal!
	IF IsNumber ( as_Value ) THEN
		la_Value = Dec ( as_Value )
	ELSE
		li_Return = -1
	END IF

CASE ELSE
	li_Return = -1

END CHOOSE


IF li_Return = 1 THEN
	li_Return = of_SetAny ( of_GetValueColumn ( ), la_Value )
END IF

RETURN li_Return
end function

public function integer of_setdatatype (parmtype ae_datatype);ie_DataType = ae_DataType

RETURN 1
end function

public function parmtype of_getdatatype ();RETURN ie_DataType
end function

protected function string of_getvaluecolumn ();String	ls_ValueColumn

CHOOSE CASE of_GetDataType ( )

CASE TypeString!
	ls_ValueColumn = "ss_String"

CASE TypeInteger!, TypeLong!
	ls_ValueColumn = "ss_Long"

CASE TypeDecimal!
	ls_ValueColumn = "ss_Dec"

CASE ELSE
	SetNull ( ls_ValueColumn )

END CHOOSE

RETURN ls_ValueColumn
end function

protected function any of_getvalue ();RETURN of_GetValue ( of_GetValueColumn ( ), of_GetDataType ( ) )
end function

public function string of_getdisplayvalue ();ParmType	le_DataType
String	ls_DisplayValue
Any		la_Value

le_DataType = This.of_GetDataType ( )
la_Value = This.of_GetValue ( This.of_GetValueColumn ( ), le_DataType )

CHOOSE CASE le_DataType

CASE TypeDecimal!
	//Allow for up to 12 digit precision, but don't show extra zeroes
	ls_DisplayValue = String ( la_Value, "#,##0.0###########" )

CASE ELSE
	ls_DisplayValue = String ( la_Value )

END CHOOSE

RETURN ls_DisplayValue
end function

on n_cst_beo_setting.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_setting.destroy
TriggerEvent( this, "destructor" )
end on

