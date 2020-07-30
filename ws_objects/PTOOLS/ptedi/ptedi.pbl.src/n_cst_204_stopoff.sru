$PBExportHeader$n_cst_204_stopoff.sru
forward
global type n_cst_204_stopoff from n_base
end type
end forward

global type n_cst_204_stopoff from n_base autoinstantiate
end type

type variables
String 	is_StopNumber
String	is_StopReason
String	is_ServiceCode
String 	is_Weight
String 	is_WeightCode 
String 	is_NumberofUnitsShipped 
String 	is_UnitofMeasure 
String 	is_Volume
String 	is_VolumeUnit
String 	is_Description 
String 	is_StandardPointLoc 
String 	is_AccomplishCode 
String 	is_DateQualifier 
String 	is_Date 
String 	is_TimeQualifier 
String 	is_Time 
String 	is_TimeCode
String 	is_Note 
String 	is_Name 
String	is_Reference
end variables

forward prototypes
public subroutine of_setstopnumber (string as_Value)
public subroutine of_setweight (string as_Value)
public subroutine of_setweightcode (string as_Value)
public subroutine of_setnumberofunits (string as_Value)
public subroutine of_setunitofmeasure (string as_Value)
public subroutine of_setvolume (string as_Value)
public subroutine of_setvolumeunit (string as_Value)
public subroutine of_setdescription (string as_Value)
public subroutine of_setstandardpointlocation (string as_Value)
public subroutine of_setaccomplishcode (string as_Value)
public subroutine of_setdatequalifier (string as_Value)
public subroutine of_setdate (string as_Value)
public subroutine of_settimequalifier (string as_Value)
public subroutine of_settime (string as_Value)
public subroutine of_settimecode (string as_Value)
public subroutine of_setnote (string as_Value)
public subroutine of_setname (string as_Value)
public subroutine of_setstopreason (string as_Value)
public subroutine of_setservicecode (string as_Value)
public function string of_getstoptype ()
public function Long of_getsite ()
public function date of_getdate ()
public function string of_getstringsite ()
public function time of_gettime ()
public function string of_getnote ()
public function integer of_setreference (string as_Value)
public function string of_getreference ()
end prototypes

public subroutine of_setstopnumber (string as_Value);is_StopNumber = as_Value
end subroutine

public subroutine of_setweight (string as_Value);is_Weight = as_Value

end subroutine

public subroutine of_setweightcode (string as_Value);is_WeightCode = as_Value
end subroutine

public subroutine of_setnumberofunits (string as_Value);is_NumberofUnitsShipped  = as_Value
end subroutine

public subroutine of_setunitofmeasure (string as_Value);is_UnitofMeasure  = as_Value
end subroutine

public subroutine of_setvolume (string as_Value);is_Volume = as_Value
end subroutine

public subroutine of_setvolumeunit (string as_Value);is_VolumeUnit = as_value
end subroutine

public subroutine of_setdescription (string as_Value);is_Description  = as_value
end subroutine

public subroutine of_setstandardpointlocation (string as_Value);is_StandardPointLoc  = as_value
end subroutine

public subroutine of_setaccomplishcode (string as_Value);is_AccomplishCode  = as_Value
end subroutine

public subroutine of_setdatequalifier (string as_Value);is_DateQualifier  = as_Value
end subroutine

public subroutine of_setdate (string as_Value);is_Date  = as_Value
end subroutine

public subroutine of_settimequalifier (string as_Value);is_TimeQualifier  = as_Value
end subroutine

public subroutine of_settime (string as_Value);is_Time  = as_Value
end subroutine

public subroutine of_settimecode (string as_Value);is_TimeCode = as_Value
end subroutine

public subroutine of_setnote (string as_Value);is_Note  = as_value
end subroutine

public subroutine of_setname (string as_Value);is_Name  = as_Value
end subroutine

public subroutine of_setstopreason (string as_Value);is_StopReason = as_Value 
end subroutine

public subroutine of_setservicecode (string as_Value);is_ServiceCode = as_Value
end subroutine

public function string of_getstoptype ();String	ls_Return 
IF Len ( is_ServiceCode ) > 0 THEN
	ls_Return = is_ServiceCode
ELSE
	ls_Return = "P" // pu by default
END IF
RETURN ls_Return


end function

public function Long of_getsite ();Long	ll_Return
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

ll_Return = gnv_cst_companies.of_Find ( is_name )
IF ll_Return > 0 THEN
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceRow ( ll_Return )
	ll_Return = lnv_Company.of_GetID ( )
END IF

DESTROY lnv_Company

RETURN ll_Return
end function

public function date of_getdate ();Date	ld_Return 
String	ls_Temp 

SetNull ( ld_Return ) 

IF Len ( is_Date ) > 0 THEN

					//MONTH											DAY 												
	ls_Temp = Mid ( is_Date , 5 , 2 ) + "/" + Right ( is_Date , 2 ) +"/" + Left ( is_Date , 4 )
	
	IF isDate ( ls_Temp ) THEN
		ld_Return = Date ( ls_Temp ) 
	END IF

END IF

RETURN ld_Return
end function

public function string of_getstringsite ();RETURN is_Name
end function

public function time of_gettime ();Time	lt_Return
SetNull ( lt_Return ) 
IF isTime ( is_time ) THEN
	lt_Return = Time ( is_Time )
END IF

RETURN lt_Return
	
end function

public function string of_getnote ();RETURN is_note
end function

public function integer of_setreference (string as_Value);is_Reference = as_Value
RETURN 1
end function

public function string of_getreference ();RETURN is_Reference
end function

on n_cst_204_stopoff.create
TriggerEvent( this, "constructor" )
end on

on n_cst_204_stopoff.destroy
TriggerEvent( this, "destructor" )
end on

