$PBExportHeader$n_cst_204_equipment.sru
forward
global type n_cst_204_equipment from n_base
end type
end forward

global type n_cst_204_equipment from n_base autoinstantiate
end type

type variables
String	is_EquipmentInital
String	is_EquipmentNumber
String	is_Weight
String	is_WeightQualifier
String	is_TareWeight
String	is_WeightAllowance
String	is_Volume
String	is_VolumeQualifier
String	is_OwnershipCode
String	is_DescriptionCode
String	is_Scac
String	is_Temp
String	is_Position
String	is_Length
String	is_TareQualCode
String	is_WeightUnitCode
String	is_CheckDigit
String	is_TypeOfService
String	is_Height
String	is_Width
String	is_EquipmentType
String	is_CarTypeCode


end variables

forward prototypes
public function integer of_setequipmentinitial (string as_Value)
public function string of_getequipmentinitial ()
public function int of_setequipmentnumber (string as_Value)
public function string of_getequipmentnumber ()
public function int of_setweightqualifier (string as_Value)
public function string of_getweightqualifier ()
public function int of_setvolumequalifier (string as_Value)
public function string of_getvolumequlifier ()
public function int of_setownershipcode (string as_Value)
public function string of_getownershipcode ()
public function int of_setdescriptioncode (string as_Value)
public function string of_getdescription ()
public function string of_getdescriptioncode ()
public function int of_setscac (string as_Value)
public function string of_getscac ()
public function integer of_settemperature (string as_Value)
public function string of_gettemperature ()
public function string of_getposition ()
public function int of_setposition (string as_Value)
public function int of_settarequalcode (string as_Value)
public function string of_gettarequalcode ()
public function string of_getweightunitvaluecode ()
public function int of_settypeofservice (string as_Value)
public function string of_gettypeofservice ()
public function int of_setequipmenttype (string as_Value)
public function string of_getequipmenttype ()
public function int of_setcartypecode (string as_Value)
public function string of_getcartypecode ()
public function string of_getcheckdigit ()
public function string of_getheight ()
public function string of_getlength ()
public function string of_gettareweight ()
public function string of_getvolume ()
public function string of_getweight ()
public function string of_getweightallowance ()
public function string of_getwidth ()
public function integer of_setcheckdigit (string as_value)
public function integer of_setheight (string as_value)
public function integer of_setlength (string as_value)
public function integer of_settareweight (string as_value)
public function integer of_setvolume (string as_value)
public function integer of_setweight (string as_value)
public function integer of_setweightallowance (string as_value)
public function integer of_setwidth (string as_value)
public function integer of_setweightunitcode (string as_Value)
end prototypes

public function integer of_setequipmentinitial (string as_Value);is_EquipmentInital = as_Value 
RETURN 1
end function

public function string of_getequipmentinitial ();RETURN is_EquipmentInital
end function

public function int of_setequipmentnumber (string as_Value);is_EquipmentNumber = as_Value
RETURN 1
end function

public function string of_getequipmentnumber ();RETURN is_EquipmentNumber
end function

public function int of_setweightqualifier (string as_Value);is_WeightQualifier	= as_Value
RETURN 1
end function

public function string of_getweightqualifier ();RETURN is_WeightQualifier
end function

public function int of_setvolumequalifier (string as_Value);is_VolumeQualifier = as_Value
RETURN 1
end function

public function string of_getvolumequlifier ();RETURN is_VolumeQualifier
end function

public function int of_setownershipcode (string as_Value);is_OwnershipCode = as_Value
RETURN 1
end function

public function string of_getownershipcode ();RETURN is_OwnershipCode
end function

public function int of_setdescriptioncode (string as_Value);is_DescriptionCode = as_Value
RETURN 1
end function

public function string of_getdescription ();RETURN is_DescriptionCode
end function

public function string of_getdescriptioncode ();RETURN is_DescriptionCode
end function

public function int of_setscac (string as_Value);is_Scac = as_Value
RETURN 1
end function

public function string of_getscac ();RETURN is_Scac
end function

public function integer of_settemperature (string as_Value);is_Temp = as_Value
RETURN 1
end function

public function string of_gettemperature ();RETURN is_Temp
end function

public function string of_getposition ();RETURN is_Position
end function

public function int of_setposition (string as_Value);is_Position = as_Value
RETURN 1
end function

public function int of_settarequalcode (string as_Value);is_TareQualCode = as_Value

RETURN 1
end function

public function string of_gettarequalcode ();RETURN is_TareQualCode
end function

public function string of_getweightunitvaluecode ();RETURN is_WeightUnitCode
end function

public function int of_settypeofservice (string as_Value);is_TypeOfService = as_Value
RETURN 1
end function

public function string of_gettypeofservice ();RETURn is_TypeOfService
end function

public function int of_setequipmenttype (string as_Value);is_EquipmentType = as_Value
Return 1
end function

public function string of_getequipmenttype ();RETURN is_EquipmentType
end function

public function int of_setcartypecode (string as_Value);is_CarTypeCode = as_Value
RETURN 1
end function

public function string of_getcartypecode ();RETURN is_CarTypeCode
end function

public function string of_getcheckdigit ();RETURN is_CheckDigit
end function

public function string of_getheight ();RETURN is_Height
end function

public function string of_getlength ();RETURN is_Length
end function

public function string of_gettareweight ();RETURN is_TareWeight
end function

public function string of_getvolume ();RETURN is_Volume
end function

public function string of_getweight ();RETURN is_Weight
end function

public function string of_getweightallowance ();Return is_WeightAllowance
end function

public function string of_getwidth ();RETURN is_Width
end function

public function integer of_setcheckdigit (string as_value);is_CheckDigit = as_Value
RETURN 1
end function

public function integer of_setheight (string as_value);is_Height = as_value
RETURN 1
end function

public function integer of_setlength (string as_value);is_Length = as_Value
RETURN 1
end function

public function integer of_settareweight (string as_value);is_TareWeight = as_Value
RETURN 1
end function

public function integer of_setvolume (string as_value);is_Volume = as_Value
RETURN 1
end function

public function integer of_setweight (string as_value);is_Weight = as_Value
RETURN 1
end function

public function integer of_setweightallowance (string as_value);is_WeightAllowance = as_Value
RETURN 1
end function

public function integer of_setwidth (string as_value);is_Width = as_Value
RETURN 1
end function

public function integer of_setweightunitcode (string as_Value);is_WeightUnitCode = as_Value
Return 1
end function

on n_cst_204_equipment.create
TriggerEvent( this, "constructor" )
end on

on n_cst_204_equipment.destroy
TriggerEvent( this, "destructor" )
end on

