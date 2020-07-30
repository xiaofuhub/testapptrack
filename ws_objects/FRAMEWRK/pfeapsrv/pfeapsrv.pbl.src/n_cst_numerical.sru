$PBExportHeader$n_cst_numerical.sru
$PBExportComments$Extension Numerical service
forward
global type n_cst_numerical from pfc_n_cst_numerical
end type
end forward

global type n_cst_numerical from pfc_n_cst_numerical
end type

forward prototypes
public function long of_setbit (long al_decimal, unsignedinteger ai_bit, boolean ab_value)
public function boolean of_isnullorneg (long al_value)
public function boolean of_isnullornotpos (long al_value)
public function integer of_getprecision (decimal ad_value)
end prototypes

public function long of_setbit (long al_decimal, unsignedinteger ai_bit, boolean ab_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		  of_SetBit
//
//	Access:			 public
//
//	Arguments:
//	al_Decimal		Decimal value on which to set the specified bit.
//	ai_Bit			Position bit from right to left on the Decimal value.
//	ab_Value			Whether the bit should be turned on (TRUE) or off (FALSE).
//
//	Returns:		 long
//						The result of the operation.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:   Sets the nth binary bit of a decimal number to 1 or 0.
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Result

IF IsNull ( al_Decimal ) OR &
	IsNull ( ai_Bit ) OR &
	IsNull ( ab_Value ) THEN

	SetNull ( ll_Result )

ELSEIF of_GetBit ( al_Decimal, ai_Bit ) = ab_Value THEN

	//Bit is already set properly
	ll_Result = al_Decimal

ELSE

	IF ab_Value = TRUE THEN
		ll_Result = al_Decimal + 2 ^ ( ai_Bit - 1 )
	ELSE
		ll_Result = al_Decimal - 2 ^ ( ai_Bit - 1 )
	END IF

END IF

RETURN ll_Result
end function

public function boolean of_isnullorneg (long al_value);return ( IsNull( al_value ) or al_value < 0 )
end function

public function boolean of_isnullornotpos (long al_value);return ( IsNull( al_value ) or al_value <= 0 )
end function

public function integer of_getprecision (decimal ad_value);// Your version
//integer li_temp
//for li_temp = 0 to 18
//	if truncate(ad_value, li_temp) = ad_value then exit
//next
//return li_temp

// My version ( without any cycle )
string ls_value
ls_value = string( ad_value )
int li_pos
li_pos = Pos( ls_value, "." )
if li_pos > 0 then return Len( ls_value ) - li_pos
return 0


end function

on n_cst_numerical.create
TriggerEvent( this, "constructor" )
end on

on n_cst_numerical.destroy
TriggerEvent( this, "destructor" )
end on

