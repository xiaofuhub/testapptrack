$PBExportHeader$n_cst_conversion.sru
$PBExportComments$Extension Conversion service
forward
global type n_cst_conversion from pfc_n_cst_conversion
end type
end forward

global type n_cst_conversion from pfc_n_cst_conversion
end type
global n_cst_conversion n_cst_conversion

forward prototypes
public subroutine of_setanytypestring (ref any aa_target)
public subroutine of_setanytypelong (ref any aa_target)
public subroutine of_setanytypeinteger (ref any aa_target)
public subroutine of_setanytypedate (ref any aa_target)
public subroutine of_setanytypetime (ref any aa_target)
public subroutine of_setanytypedatetime (ref any aa_target)
public subroutine of_setanytypechar (ref any aa_target)
public subroutine of_setanytypeboolean (ref any aa_target)
public subroutine of_setanytypedouble (ref any aa_target)
public subroutine of_setanytypedecimal (ref any aa_target)
public subroutine of_setanytypereal (ref any aa_target)
public subroutine of_setanytypeblob (ref any aa_target)
public subroutine of_setanytypeuint (ref any aa_target)
public subroutine of_setanytypeulong (ref any aa_target)
public subroutine of_setanytypeany (ref any aa_target)
public subroutine of_setanytype (ref any aa_target, parmtype ae_type)
end prototypes

public subroutine of_setanytypestring (ref any aa_target);//Initializes an any variable to type string, and sets its value to null

String	ls_Set
aa_Target = ls_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypelong (ref any aa_target);//Initializes an any variable to type long, and sets its value to null

Long	ll_Set
aa_Target = ll_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypeinteger (ref any aa_target);//Initializes an any variable to type integer, and sets its value to null

Integer	li_Set
aa_Target = li_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypedate (ref any aa_target);//Initializes an any variable to type date, and sets its value to null

Date	ld_Set
aa_Target = ld_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypetime (ref any aa_target);//Initializes an any variable to type time, and sets its value to null

Time	lt_Set
aa_Target = lt_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypedatetime (ref any aa_target);//Initializes an any variable to type datetime, and sets its value to null

DateTime	ldt_Set
aa_Target = ldt_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypechar (ref any aa_target);//Initializes an any variable to type char, and sets its value to null

Char	lch_Set
aa_Target = lch_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypeboolean (ref any aa_target);//Initializes an any variable to type boolean, and sets its value to null

Boolean	lb_Set
aa_Target = lb_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypedouble (ref any aa_target);//Initializes an any variable to type double, and sets its value to null

Double	ldbl_Set
aa_Target = ldbl_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypedecimal (ref any aa_target);//Initializes an any variable to type decimal, and sets its value to null

Decimal	lc_Set
aa_Target = lc_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypereal (ref any aa_target);//Initializes an any variable to type real, and sets its value to null

Real	lr_Set
aa_Target = lr_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypeblob (ref any aa_target);//Initializes an any variable to type blob, and sets its value to null

Blob	lbb_Set
aa_Target = lbb_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypeuint (ref any aa_target);//Initializes an any variable to type unint, and sets its value to null

Uint	lui_Set
aa_Target = lui_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypeulong (ref any aa_target);//Initializes an any variable to type ulong, and sets its value to null

ULong	lul_Set
aa_Target = lul_Set

SetNull ( aa_Target )
end subroutine

public subroutine of_setanytypeany (ref any aa_target);//Initializes an any variable to type any, and sets its value to null

Any	la_Set
aa_Target = la_Set

//SetNull ( aa_Target )
end subroutine

public subroutine of_setanytype (ref any aa_target, parmtype ae_type);CHOOSE CASE ae_Type

CASE	TypeBoolean!
	of_SetAnyTypeBoolean ( aa_Target )

CASE	TypeDate!
	of_SetAnyTypeDate ( aa_Target )

CASE	TypeDateTime!
	of_SetAnyTypeDateTime ( aa_Target )

CASE	TypeDecimal!
	of_SetAnyTypeDecimal ( aa_Target )

CASE	TypeDouble!
	of_SetAnyTypeDouble ( aa_Target )

CASE	TypeInteger!
	of_SetAnyTypeInteger ( aa_Target )

CASE	TypeLong!
	of_SetAnyTypeLong ( aa_Target )

CASE	TypeReal!
	of_SetAnyTypeReal ( aa_Target )

CASE	TypeString!
	of_SetAnyTypeString ( aa_Target )

CASE	TypeTime!
	of_SetAnyTypeTime ( aa_Target )

CASE	TypeUint!
	of_SetAnyTypeUint ( aa_Target )

CASE	TypeLong!
	of_SetAnyTypeLong ( aa_Target )

CASE	TypeUnknown!
	of_SetAnyTypeAny ( aa_Target )

END CHOOSE
end subroutine

on n_cst_conversion.create
TriggerEvent( this, "constructor" )
end on

on n_cst_conversion.destroy
TriggerEvent( this, "destructor" )
end on

