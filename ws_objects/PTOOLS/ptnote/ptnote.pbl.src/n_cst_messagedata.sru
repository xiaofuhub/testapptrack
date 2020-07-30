$PBExportHeader$n_cst_messagedata.sru
forward
global type n_cst_messagedata from n_cst_base
end type
end forward

global type n_cst_messagedata from n_cst_base
end type
global n_cst_messagedata n_cst_messagedata

type variables
CONSTANT String	cs_ShipmentTemplate = "SHIPMENTTEMPLATE"

Private:
s_commdevicemessage	istr_message
String	is_unitid
String	is_EquipmentRef
String	is_LastPositionLocation
String	is_LastPositionLat
String	is_LastPositionLong
String	is_Text
String	is_MessageType
String	is_outboundTemplate
String	is_LastMessageNumber
String	is_EventNotes
String	is_Container
String	is_Chassis
String	is_Trailer
String	is_Tractor
String	is_EventType
String	is_SiteCodeName
String	is_DriverRef
String	is_DriverID
String	is_DriverDutyStatus
String	is_SourceEntityType


Long	il_EventID
Long	il_ShipmentID
Long	il_ContainerID
Long	il_TrailerID

Long	il_TractorID

Long	il_SourceEntityId  //Equipment/Employee

Date	id_LastPositionDate
time	it_LastPositionTime

s_Parm	istra_Parms[]

n_cst_msg	inv_SpecialFields
end variables

forward prototypes
public function integer of_setdeviceunitid (string as_value)
public function string of_getdeviceunitid ()
public function integer of_setequipmentref (string as_value)
public function string of_getequipmentref ()
public function integer of_setlastpositionlocation (string as_Value)
public function string of_getlastpositionlocation ()
public function integer of_setlastpositionlat (string as_Value)
public function string of_getlastpositionlat ()
public function int of_setlastpositionlong (string as_Value)
public function string of_getlastpositionlong ()
public function integer of_setmessagetext (string as_Value)
public function string of_getmessagetext ()
public function string of_getmessagetype ()
public function int of_setmessagetype (string as_Value)
public function int of_setoutboundtemplate (string as_Value)
public function string of_getoutboundtemplate ()
public function int of_setlastmessagenumber (string as_Value)
public function string of_getlastmessagenumber ()
public function integer of_seteventnotes (string as_Value)
public function string of_geteventnotes ()
public function int of_setcontainer (string as_Value)
public function string of_getcontainer ()
public function int of_setchassis (string as_Value)
public function string of_getchassis ()
public function int of_seteventid (long al_EventID)
public function long of_geteventid ()
public function long of_getshipmentid ()
public function int of_setshipmentid (long al_ShipmentID)
public function int of_setlastpositiondate (date ad_Value)
public function date of_getlastpositiondate ()
public function int of_setlastpositiontime (time at_Value)
public function time of_getlastpositiontime ()
public function integer of_setshipmenttemplate (String as_Value)
public function string of_getshipmenttemplate ()
public function integer of_appendtomessagetext (string as_Value)
public function long of_getcontainerid ()
public function long of_setcontainerid (long al_ContainerID)
public subroutine of_seteventtype (string as_value)
public function string of_geteventtype ()
public subroutine of_setsitecodename (string as_value)
public function string of_getsitecodename ()
public function integer of_settrailer (string as_value)
public function string of_gettrailer ()
public function integer of_setdriverref (string as_value)
public function string of_getdriverref ()
public function integer of_gettrailerid (ref long al_trailerid)
public function integer of_settractorid ()
public function long of_gettractorid ()
public function string of_getlastpositionlat (string as_format)
public function string of_getlastpositionlong (string as_format)
public function string of_getlastpositionlatlong (string as_format)
public function n_cst_msg of_getspecialfields ()
public function integer of_setspecialfield (string as_label, string as_message)
public function integer of_setsourceentityid (long al_eqid)
public function long of_getsourceentityid ()
public function integer of_setdriverid (string as_id)
public function integer of_setdriverdutystatus (string as_value)
public function long of_getdriverid ()
public function string of_getdriverdutystatus ()
public function string of_getsourceentitytype ()
public function integer of_setsourceentitytype (string as_type)
end prototypes

public function integer of_setdeviceunitid (string as_value);// the unit id is the number given to the actual device by the distibuter

is_UnitID = as_Value
RETURN 1
end function

public function string of_getdeviceunitid ();RETURN is_unitid
end function

public function integer of_setequipmentref (string as_value);is_EquipmentRef = as_Value
THIS.of_SetTractorID ( )

RETURN 1
end function

public function string of_getequipmentref ();RETURN is_EquipmentRef
end function

public function integer of_setlastpositionlocation (string as_Value);is_LastPositionLocation = as_Value

RETURN 1
end function

public function string of_getlastpositionlocation ();RETURN is_LastPositionLocation
end function

public function integer of_setlastpositionlat (string as_Value);is_LastPositionLat = as_Value
RETURN 1
end function

public function string of_getlastpositionlat ();RETURN Trim ( is_LastPositionLat )
end function

public function int of_setlastpositionlong (string as_Value);is_LastPositionLong = as_Value
RETURN 1
end function

public function string of_getlastpositionlong ();RETURN Trim ( is_LastPositionLong )
end function

public function integer of_setmessagetext (string as_Value);is_Text = as_Value
RETURN 1
end function

public function string of_getmessagetext ();RETURN is_Text
end function

public function string of_getmessagetype ();RETURN is_MessageType
end function

public function int of_setmessagetype (string as_Value);is_MessageType = as_Value
RETURN 1
end function

public function int of_setoutboundtemplate (string as_Value);is_OutboundTemplate = as_Value
RETURN 1
end function

public function string of_getoutboundtemplate ();RETURN is_OutboundTemplate

end function

public function int of_setlastmessagenumber (string as_Value);is_lastMessageNumber	= as_Value
RETURN 1
end function

public function string of_getlastmessagenumber ();RETURN is_LastMessagenumber

end function

public function integer of_seteventnotes (string as_Value);is_Eventnotes = as_Value
RETURN 1
end function

public function string of_geteventnotes ();RETURN is_EventNotes
end function

public function int of_setcontainer (string as_Value);is_Container = as_Value
RETURN 1
end function

public function string of_getcontainer ();RETURN is_Container
end function

public function int of_setchassis (string as_Value);is_Chassis = as_Value
RETURN 1
end function

public function string of_getchassis ();RETURN is_Chassis
end function

public function int of_seteventid (long al_EventID);il_EventID = al_EventID
RETURN 1
end function

public function long of_geteventid ();RETURN il_EventID
end function

public function long of_getshipmentid ();RETURN il_ShipmentID
end function

public function int of_setshipmentid (long al_ShipmentID);il_ShipmentID = al_ShipmentID
RETURN 1
end function

public function int of_setlastpositiondate (date ad_Value);id_LastPositionDate = ad_Value 
RETURN 1
end function

public function date of_getlastpositiondate ();RETURN id_LastPositionDate
end function

public function int of_setlastpositiontime (time at_Value);it_LastPositiontime = at_Value
RETURN 1
end function

public function time of_getlastpositiontime ();RETURN it_LastPositionTime
end function

public function integer of_setshipmenttemplate (String as_Value);Int	li_ParmCount 
li_ParmCount = UpperBound ( istra_parms )

li_ParmCount ++
istra_parms[ li_ParmCount ].is_Label = cs_ShipmentTemplate
istra_parms[ li_ParmCount ].ia_Value = as_Value

RETURN 1
end function

public function string of_getshipmenttemplate ();Int	li_ParmCount
Int 	i
String	ls_Return

SetNull ( ls_Return )

li_ParmCount = UpperBound ( istra_parms )

FOR i = 1 TO li_ParmCount
	
	IF istra_parms[ i ].is_Label = cs_shipmenttemplate THEN
		ls_Return = istra_parms[ i ].ia_Value
		EXIT
	END IF
	
NEXT

RETURN ls_Return
end function

public function integer of_appendtomessagetext (string as_Value);is_Text += as_Value
RETURN 1
end function

public function long of_getcontainerid ();RETURN il_ContainerID
end function

public function long of_setcontainerid (long al_ContainerID);il_ContainerID = al_ContainerID
RETURN 1
end function

public subroutine of_seteventtype (string as_value);is_EventType = as_Value
end subroutine

public function string of_geteventtype ();RETURN is_EventType
end function

public subroutine of_setsitecodename (string as_value);is_SiteCodeName = as_Value
end subroutine

public function string of_getsitecodename ();return is_SiteCodeName
end function

public function integer of_settrailer (string as_value);is_Trailer = as_value

RETURN 1
end function

public function string of_gettrailer ();RETURN is_Trailer
end function

public function integer of_setdriverref (string as_value);is_driverref = as_value

RETURN 1
end function

public function string of_getdriverref ();return is_Driverref
end function

public function integer of_gettrailerid (ref long al_trailerid);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetTrailerId
//  
//	Access		:public
//
//	Arguments	:al_trailerid by reference
//
//	Return		:integer
//					1 = valid trailer id
//				  -1 = invalid trailer id
//					0 = no trailer specified
//						
//	Description	:
//
//			Get the trailer reference number and look up the id.
//
// Written by	:Norm LeBlanc
// 		Date	:12/21/2004
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//


String	ls_Ref
Long		ll_EqID
Int		li_Return 

n_cst_EquipmentManager	lnv_EquipmentManager

ls_Ref = THIS.of_GetTrailer ( )

IF Len ( ls_Ref ) > 0 THEN

	ll_eqID = lnv_EquipmentManager.of_Getequipmentid( 'V', ls_Ref)
//	ll_EqID = lnv_EquipmentManager.of_GetIDFromRef ( ls_Ref )
	IF ll_EqID > 0 THEN
		al_trailerid = ll_EqID 
		li_Return = 1
	ELSE
		li_Return = -1
	END IF
ELSE
	li_return = 0
END IF

RETURN li_Return

end function

public function integer of_settractorid ();String	ls_Ref
Long		ll_EqID
Int		li_Return 

n_cst_EquipmentManager	lnv_EquipmentManager

ls_Ref = THIS.of_GetEquipmentRef ( )

IF Len ( ls_Ref ) > 0 THEN
	ll_eqID = lnv_EquipmentManager.of_Getequipmentid( 'T', ls_Ref)
//	ll_EqID = lnv_EquipmentManager.of_GetIDFromRef ( ls_Ref )
	IF ll_EqID > 0 THEN
		il_tractorid = ll_EqID 
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function long of_gettractorid ();RETURN il_tractorid
end function

public function string of_getlastpositionlat (string as_format);//Get the LastPositionLat value, and render it in the format requested.
//Currently, the only supported format is "HMSD"

String	ls_Raw, &
			ls_Hours, &
			ls_Minutes, &
			ls_Seconds, &
			ls_Decimal, &
			ls_Return
		
Decimal	lc_Decimal, &
			lc_Work


ls_Raw = This.of_GetLastPositionLat ( )


CHOOSE CASE as_Format
		
	CASE "HMSD"
		
		IF Match ( ls_Raw, "[NS]+" ) THEN 
			
			//ls_Raw is already in HMSD format.  No need to convert.
			ls_Return = ls_Raw
			
		ELSE
			
			//ls_Raw is in decimal format.  Convert to HMSD.  *This is Norm's code.*
			
			lc_decimal = dec ( ls_Raw )
			
			//hours
			ls_hours= string (int(lc_decimal),"000")
			
			//minutes
			ls_decimal = string ( lc_decimal )
			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
			ls_minutes = string ( lc_work, "00")
			
			//seconds
			ls_decimal = string ( lc_work )
			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
			ls_seconds =  string ( lc_work, "00")
			
			ls_Return = ls_hours + ls_minutes + ls_seconds + "N"  //**WHAT ABOUT "S" ???**
			
		END IF
			
	CASE ELSE
		
		//Unrecognized format.   Return null
		
		SetNull ( ls_Return )
			
END CHOOSE


RETURN ls_Return
end function

public function string of_getlastpositionlong (string as_format);//Get the LastPositionLong value, and render it in the format requested.
//Currently, the only supported format is "HMSD"

String	ls_Raw, &
			ls_Hours, &
			ls_Minutes, &
			ls_Seconds, &
			ls_Decimal, &
			ls_Return
		
Decimal	lc_Decimal, &
			lc_Work


ls_Raw = This.of_GetLastPositionLong ( )


CHOOSE CASE as_Format
		
	CASE "HMSD"
		
		IF Match ( ls_Raw, "[EW]+" ) THEN 
			
			//ls_Raw is already in HMSD format.  No need to convert.
			ls_Return = ls_Raw
			
		ELSE
			
			//ls_Raw is in decimal format.  Convert to HMSD.  *This is Norm's code.*
			
			lc_decimal = dec ( ls_Raw )
			
			//hours
			ls_hours= string (int(lc_decimal),"000")
			
			//minutes
			ls_decimal = string ( lc_decimal )
			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
			ls_minutes = string ( lc_work, "00")
			
			//seconds
			ls_decimal = string ( lc_work )
			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
			ls_seconds =  string ( lc_work, "00")
			
			ls_Return = ls_hours + ls_minutes + ls_seconds + "W"  //**WHAT ABOUT "E" ???**
			
		END IF
			
	CASE ELSE
		
		//Unrecognized format.   Return null
		
		SetNull ( ls_Return )
			
END CHOOSE


RETURN ls_Return
end function

public function string of_getlastpositionlatlong (string as_format);//Renders LastPositionLat and LastPositionLong in the requested format.
//The only format currently supported is "HMSD"  (hrs min sec direction)

String	ls_Lat, &
			ls_Long, &
			ls_Return

CHOOSE CASE as_Format
		
	CASE "HMSD"
		
		ls_Lat = This.of_GetLastPositionLat ( as_Format )
		ls_Long = This.of_GetLastPositionLong ( as_Format )
		
		IF ls_Lat > "" AND ls_Long > "" THEN
			ls_Return = ls_Lat + "," + ls_Long
		ELSE
			SetNull ( ls_Return )
		END IF
		
	CASE ELSE
		
		SetNull ( ls_Return )
		
END CHOOSE


RETURN ls_Return
end function

public function n_cst_msg of_getspecialfields ();Return inv_SpecialFields


end function

public function integer of_setspecialfield (string as_label, string as_message);String	ls_Tag
String	ls_Value
Long		ll_Start
Long		ll_End
Long		ll_Length
Integer	li_Return
s_parm	lstr_Parm

ll_Start = Pos(as_label, "[") + 1
ll_End = Pos(as_Label, "]")

IF ll_Start <> 0 AND ll_End <> 0 THEN
	//Find Tag in as_message
	ll_Length = ll_End - ll_Start
	ls_Tag = Mid(as_label , ll_Start, ll_Length)
	ls_Value = as_Message
	IF Len(ls_Value) > 0 AND Len ( ls_Tag ) > 0 THEN
		lstr_Parm.is_Label = ls_Tag
		lstr_Parm.ia_Value = ls_Value
		inv_SpecialFields.of_add_parm(lstr_Parm)
	ELSE
		li_Return = 1
	END IF
		
ELSE
	li_Return = -1
END IF

Return li_Return
end function

public function integer of_setsourceentityid (long al_eqid);il_SourceEntityId = al_eqid

Return 1
end function

public function long of_getsourceentityid ();Return il_SourceEntityId
end function

public function integer of_setdriverid (string as_id);is_Driverid = as_id
RETURN 1
end function

public function integer of_setdriverdutystatus (string as_value);string	ls_Duty
String	ls_Value
Int		li_Return = 1

ls_Value = Upper ( Trim ( as_value ) )


CHOOSE CASE ls_Value	
	CASE "ON" , "1" 
		ls_Duty = "ON"
	CASE "OFF" , "0" 
		ls_Duty = "OFF"
	CASE ELSE
		IF Pos ( ls_Value , "ON"  ) > 0 THEN
			ls_Duty = "ON"
		ELSEIF Pos ( ls_Value , "OFF"  ) > 0 THEN
			ls_Duty = "OFF"
		ELSE
			li_Return = -1			
		END IF
END CHOOSE

is_Driverdutystatus = ls_Duty
RETURN li_Return
end function

public function long of_getdriverid ();Long	ll_ID
IF IsNumber (is_driverid ) THEN
	ll_ID = Long ( is_driverid )
END IF

RETURN ll_ID
end function

public function string of_getdriverdutystatus ();RETURN is_driverdutystatus 
end function

public function string of_getsourceentitytype ();Return is_SourceEntityType
end function

public function integer of_setsourceentitytype (string as_type);is_SourceEntityType = as_Type

Return 1
end function

on n_cst_messagedata.create
call super::create
end on

on n_cst_messagedata.destroy
call super::destroy
end on

event constructor;call super::constructor;SetNull ( id_lastpositiondate )
SetNull ( it_lastpositiontime )
end event

