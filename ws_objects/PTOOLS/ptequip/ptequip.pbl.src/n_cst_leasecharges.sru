$PBExportHeader$n_cst_leasecharges.sru
forward
global type n_cst_leasecharges from n_base
end type
end forward

global type n_cst_leasecharges from n_base
end type
global n_cst_leasecharges n_cst_leasecharges

type variables
Private:
Dec	ica_PeriodCharges[]
String	isa_PeriodRanges[]
Int	iia_PeriodQty[]
Dec	ica_PeriodRate[]
end variables

forward prototypes
public function integer of_setcharges (integer ai_Period, dec ac_Value)
public function dec of_getcharges (integer ai_Period)
public function int of_getchargeperiods ()
public function decimal of_gettotalcharges ()
public function integer of_setdaterange (integer ai_period, string as_value)
public function integer of_setperiodrange (integer ai_period, string as_value)
public function string of_getperiodrange (integer ai_Period)
public function integer of_setperiodrate (integer ai_Period, dec ac_Value)
public function decimal of_getrate (integer ai_period)
public function int of_getqty (integer ai_Period)
public function integer of_setqty (integer ai_Period, integer ai_Value)
end prototypes

public function integer of_setcharges (integer ai_Period, dec ac_Value);Int	li_Return = -1

IF ai_Period > 0 THEN
	ica_PeriodCharges [ ai_Period ] = ac_Value
	li_Return = 1
END IF

RETURN li_Return
end function

public function dec of_getcharges (integer ai_Period);Dec lc_Return
IF ai_Period <= UpperBound ( ica_periodcharges[] ) THEN
	lc_Return = ica_periodcharges[ai_Period]
END IF

RETURN lc_Return
	
end function

public function int of_getchargeperiods ();RETURN UpperBound ( ica_periodcharges[] )
end function

public function decimal of_gettotalcharges ();Int	li_Count
Int	i
Dec 	lc_Total

li_Count = THIS.of_GetChargePeriods ( )
FOR i = 1 TO li_Count
	lc_Total += THIS.of_GetCharges ( i )
NEXT

RETURN lc_Total

end function

public function integer of_setdaterange (integer ai_period, string as_value);RETURN 1
end function

public function integer of_setperiodrange (integer ai_period, string as_value);Int	li_Return = -1

IF ai_Period > 0 THEN
	isa_PeriodRanges [ ai_Period ] = as_value
	li_Return = 1
END IF

RETURN li_Return
end function

public function string of_getperiodrange (integer ai_Period);String	ls_Return
IF ai_Period <= UpperBound ( isa_periodranges[] ) THEN
	ls_Return = isa_periodranges[ai_Period]
END IF

RETURN ls_Return
	
end function

public function integer of_setperiodrate (integer ai_Period, dec ac_Value);Int	li_Return = -1

IF ai_Period > 0 THEN
	ica_PeriodRate[] [ ai_Period ] = ac_Value
	li_Return = 1
END IF

RETURN li_Return
end function

public function decimal of_getrate (integer ai_period);Dec lc_Return
IF ai_Period <= UpperBound ( ica_PeriodRate[] ) THEN
	lc_Return = ica_PeriodRate[ai_Period]
END IF

RETURN lc_Return
	
end function

public function int of_getqty (integer ai_Period);Int	li_Return
IF ai_Period <= UpperBound ( iia_PeriodQty[] ) THEN
	li_Return = iia_PeriodQty[ai_Period]
END IF

RETURN li_Return
end function

public function integer of_setqty (integer ai_Period, integer ai_Value);Int	li_Return = -1

IF ai_Period > 0 THEN
	iia_PeriodQty [ ai_Period ] = ai_Value
	li_Return = 1
END IF

RETURN li_Return
end function

on n_cst_leasecharges.create
TriggerEvent( this, "constructor" )
end on

on n_cst_leasecharges.destroy
TriggerEvent( this, "destructor" )
end on

