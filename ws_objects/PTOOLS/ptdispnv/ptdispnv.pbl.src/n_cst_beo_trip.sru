$PBExportHeader$n_cst_beo_trip.sru
$PBExportComments$Trip (Persistent Class from PBL map PTDisp) //@(*)[152122892|1127]
forward
global type n_cst_beo_trip from n_cst_beo
end type
end forward

global type n_cst_beo_trip from n_cst_beo
end type
global n_cst_beo_trip n_cst_beo_trip

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.

//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Protected n_cst_beo_Event	inva_EventList[]
Protected Boolean		ib_HasEventList = FALSE

Constant String	cs_Status_Open = "K"
Constant String	cs_Status_Authorized = "N"
Constant String	cs_Status_AuditRequired = "Q"
Constant String	cs_Status_Audited = "T"
Constant String	cs_Status_History = "W"

Constant String	cs_Status_ValueList = "OPEN~tK/AUTHORIZED~tN/AUDIT REQ.~tQ/AUDITED~tT/HISTORY~tW/"
end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly string as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function Long of_GetId ()
public function Integer of_SetId (Long al_id)
public function Decimal of_GetPayablestotal ()
public function Integer of_SetPayablestotal (Decimal ad_payablestotal)
public function String of_GetStatus ()
public function Integer of_SetStatus (String as_status)
public function String of_GetDriver ()
public function Integer of_SetDriver (String as_driver)
public function Date of_GetTripdate ()
public function Integer of_SetTripdate (Date ad_tripdate)
public function Integer of_GetMiles ()
public function Integer of_SetMiles (Integer ai_miles)
public function Long of_GetTotalweight ()
public function Integer of_SetTotalweight (Long al_totalweight)
public function String of_GetCarriertripnumber ()
public function Integer of_SetCarriertripnumber (String as_carriertripnumber)
public function String of_GetInternalnote ()
public function Integer of_SetInternalnote (String as_internalnote)
public function String of_GetEquipmenttype ()
public function Integer of_SetEquipmenttype (String as_equipmenttype)
public function String of_GetEquipmentnumber ()
public function Integer of_SetEquipmentnumber (String as_equipmentnumber)
public function String of_GetChassisnumber ()
public function Integer of_SetChassisnumber (String as_chassisnumber)
public function string of_getcarriername ()
public function Boolean of_isstatusactive ()
public function Boolean of_isstatusrestricted ()
public function Boolean of_isstatushistory ()
public function Boolean of_isstatusactive (string as_status)
public function Boolean of_isstatusrestricted (string as_status)
public function Boolean of_isstatushistory (string as_status)
public function Boolean of_isstatusaudited ()
public function Boolean of_isstatusaudited (string as_status)
public function integer of_checklocations ()
public function integer of_seteventlist (ref n_cst_beo_event anva_eventlist[])
public function long of_geteventlist (ref n_cst_beo_event anva_eventlist[])
public function long of_getcarrierid ()
public function long of_getdestinationid ()
public function long of_getoriginid ()
public function integer of_setcarrierid (long al_carrierid)
public function integer of_setdestinationid (long al_destinationid)
public function integer of_setoriginid (long al_originid)
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_trip")
inv_bcm.RegisterAttribute("id", "long") //@(*)[152123017|1128]
inv_bcm.SetKey("id")
inv_bcm.RegisterAttribute("equipmenttype", "character(1)") //@(*)[152123070|1129]
inv_bcm.RegisterAttribute("equipmentnumber", "character(15)") //@(*)[152123112|1130]
inv_bcm.RegisterAttribute("chassisnumber", "string(15)") //@(*)[152123153|1131]
inv_bcm.RegisterAttribute("originid", "long") //@(*)[152123194|1132]
inv_bcm.RegisterAttribute("destinationid", "long") //@(*)[152123277|1134]
inv_bcm.RegisterAttribute("payablestotal", "decimal") //@(*)[152123373|1136]
inv_bcm.RegisterAttribute("status", "character(1)") //@(*)[152123469|1138]
inv_bcm.RegisterAttribute("driver", "character(20)") //@(*)[152123620|1141]
inv_bcm.RegisterAttribute("tripdate", "date") //@(*)[152123675|1142]
inv_bcm.RegisterAttribute("miles", "integer") //@(*)[152123730|1143]
inv_bcm.RegisterAttribute("totalweight", "long") //@(*)[152123785|1144]
inv_bcm.RegisterAttribute("carriertripnumber", "string(15)") //@(*)[152123991|1148]
inv_bcm.RegisterAttribute("internalnote", "string(32767)") //@(*)[152124052|1149]
//@(data)--

//Special handling of CarrierId

//CarrierId is custom implemented, because HOW wouldn't generate it as an attribute
//because it's a foreign key.  For other references, browse this object and the dlk 
//for carrierid.

inv_bcm.RegisterAttribute("carrierid", "integer")

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "brok_trips", "bt_id")
   inv_bcm.MapDBColumn("equipmenttype", "brok_trips", "bt_eq_type")
   inv_bcm.MapDBColumn("equipmentnumber", "brok_trips", "bt_eq_ref")
   inv_bcm.MapDBColumn("chassisnumber", "brok_trips", "bt_chassis_ref")
   inv_bcm.MapDBColumn("originid", "brok_trips", "bt_origin_id")
   inv_bcm.MapDBColumn("destinationid", "brok_trips", "bt_findest_id")
   inv_bcm.MapDBColumn("payablestotal", "brok_trips", "bt_paycar_tot")
   inv_bcm.MapDBColumn("status", "brok_trips", "bt_pmtstatus")
   inv_bcm.MapDBColumn("driver", "brok_trips", "bt_driver")
   inv_bcm.MapDBColumn("tripdate", "brok_trips", "bt_tripdate")
   inv_bcm.MapDBColumn("miles", "brok_trips", "bt_miles")
   inv_bcm.MapDBColumn("totalweight", "brok_trips", "bt_weight")
   inv_bcm.MapDBColumn("carriertripnumber", "brok_trips", "bt_tripnum")
   inv_bcm.MapDBColumn("internalnote", "brok_trips", "bt_trip_comment")
end if 
//@(text)--

//Special handling of CarrierId  (see note above)

if inv_bcm.defaultDLK() then
	inv_bcm.MapDBColumn("carrierid", "brok_trips", "bt_carrier_id")
end if

return 1
end function

protected function integer setattribute (readonly string as_name, readonly any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
int li_rc

li_rc = super::SetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "id" 
   return of_SetId(Long(aa_value))
 case "equipmenttype" 
   return of_SetEquipmenttype(String(aa_value))
 case "equipmentnumber" 
   return of_SetEquipmentnumber(String(aa_value))
 case "chassisnumber" 
   return of_SetChassisnumber(String(aa_value))
 case "originid" 
   return of_SetOriginid(Long(aa_value))
 case "destinationid" 
   return of_SetDestinationid(Long(aa_value))
 case "payablestotal" 
   return of_SetPayablestotal(Dec(aa_value))
 case "status" 
   return of_SetStatus(String(aa_value))
 case "driver" 
   return of_SetDriver(String(aa_value))
 case "tripdate" 
   return of_SetTripdate(Convert(aa_value, TypeDate!))
 case "miles" 
   return of_SetMiles(Integer(aa_value))
 case "totalweight" 
   return of_SetTotalweight(Long(aa_value))
 case "carriertripnumber" 
   return of_SetCarriertripnumber(String(aa_value))
 case "internalnote" 
   return of_SetInternalnote(String(aa_value))
end choose

//@(text)--


//Special handling for CarrierId

//CarrierId is custom implemented, because HOW wouldn't generate it as an attribute
//because it's a foreign key.  For other references, browse this object and the dlk 
//for carrierid.

CHOOSE CASE as_Name

CASE "carrierid"
	RETURN This.of_SetCarrierId ( Long ( aa_Value ) )

END CHOOSE


//@(text)(recreate=yes)<return value>
return 0
//@(text)--

end function

protected function integer getattribute (readonly String as_name, ref any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
integer li_rc

li_rc = super::GetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "id" 
   aa_value = of_GetId()
   li_rc = 1
 case "equipmenttype" 
   aa_value = of_GetEquipmenttype()
   li_rc = 1
 case "equipmentnumber" 
   aa_value = of_GetEquipmentnumber()
   li_rc = 1
 case "chassisnumber" 
   aa_value = of_GetChassisnumber()
   li_rc = 1
 case "originid" 
   aa_value = of_GetOriginid()
   li_rc = 1
 case "destinationid" 
   aa_value = of_GetDestinationid()
   li_rc = 1
 case "payablestotal" 
   aa_value = of_GetPayablestotal()
   li_rc = 1
 case "status" 
   aa_value = of_GetStatus()
   li_rc = 1
 case "driver" 
   aa_value = of_GetDriver()
   li_rc = 1
 case "tripdate" 
   aa_value = of_GetTripdate()
   li_rc = 1
 case "miles" 
   aa_value = of_GetMiles()
   li_rc = 1
 case "totalweight" 
   aa_value = of_GetTotalweight()
   li_rc = 1
 case "carriertripnumber" 
   aa_value = of_GetCarriertripnumber()
   li_rc = 1
 case "internalnote" 
   aa_value = of_GetInternalnote()
   li_rc = 1
end choose

//@(text)--


//Special Handling of CarrierId

//CarrierId is custom implemented, because HOW wouldn't generate it as an attribute
//because it's a foreign key.  For other references, browse this object and the dlk 
//for carrierid.

IF li_rc = 0 THEN

	CHOOSE CASE as_Name

	CASE "carrierid"
		aa_Value = This.of_GetCarrierId ( )
		li_rc = 1

	END CHOOSE

END IF


//Computed columns

IF li_rc = 0 THEN

	//Note: Values are initialized in order to avoid sending back 
	//an untyped any when value is null

	CHOOSE CASE Lower ( as_Name )

	CASE Lower ( "Trip_CarrierName" )
		aa_Value = ""
		aa_Value = This.of_GetCarrierName ( )
		li_rc = 1

	END CHOOSE

END IF


//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[152123017|1128:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_SetId (Long al_id);//@(*)[152123017|1128:id:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "id" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_SystemField, cb_Unrestricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("id", al_id) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetPayablestotal ();//@(*)[152123373|1136:payablestotal:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("payablestotal")
//@(text)--

end function

public function Integer of_SetPayablestotal (Decimal ad_payablestotal);//@(*)[152123373|1136:payablestotal:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "payablestotal" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF

IF li_rc > 0 THEN
	IF ad_PayablesTotal < 0 THEN
		This.Event ue_RejectEdit ( This.cs_RejectEdit_Negative )
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("payablestotal", ad_payablestotal) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetStatus ();//@(*)[152123469|1138:status:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("status")
//@(text)--

end function

public function Integer of_SetStatus (String as_status);//@(*)[152123469|1138:status:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "status" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

n_cst_Privileges	lnv_Privileges

//Do preliminary validation of the change.

IF li_rc > 0 THEN

	IF This.of_IsStatusRestricted ( ) AND This.of_IsStatusRestricted ( as_Status ) THEN

		//User is attempting to toggle between two restricted statuses.  See if they can edit
		//info for this object at all, and then let the normal processing that checks whether
		//they can set a restricted status take over (below.)  The idea here is to let them toggle
		//between restricted statuses, even if they can't edit other parts of a restricted trip.

		IF This.ApproveEdit ( cb_UserField, cb_Unrestricted ) < 1 THEN
			//User cannot edit info for this object at all
			li_rc = -1
		END IF

	ELSE

		//Perform normal status restriction checks.

		IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
			li_rc = -1
		END IF

	END IF

END IF


//If user is trying to set special statuses, see if they're authorized to do so

IF This.of_IsStatusHistory ( as_Status ) THEN

	IF lnv_Privileges.of_Trip_SetStatusHistory ( ) THEN
		//User is authorized to set status to history
	ELSE
		This.Event ue_RejectEdit ( This.cs_RejectEdit_NotAuthorized )
		li_rc = -1
	END IF

ELSEIF This.of_IsStatusAudited ( as_Status ) THEN

	IF lnv_Privileges.of_Trip_SetStatusAudited ( ) THEN
		//User is authorized to set status to audited
	ELSE
		This.Event ue_RejectEdit ( This.cs_RejectEdit_NotAuthorized )
		li_rc = -1
	END IF

ELSEIF This.of_IsStatusRestricted ( as_Status ) THEN

	IF lnv_Privileges.of_Trip_SetStatusRestricted ( ) THEN
		//User is authorized to set status to restricted
	ELSE
		This.Event ue_RejectEdit ( This.cs_RejectEdit_NotAuthorized )
		li_rc = -1
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("status", as_status) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetDriver ();//@(*)[152123620|1141:driver:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("driver")
//@(text)--

end function

public function Integer of_SetDriver (String as_driver);//@(*)[152123620|1141:driver:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "driver" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("driver", as_driver) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Date of_GetTripdate ();//@(*)[152123675|1142:tripdate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("tripdate")
//@(text)--

end function

public function Integer of_SetTripdate (Date ad_tripdate);//@(*)[152123675|1142:tripdate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "tripdate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("tripdate", ad_tripdate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetMiles ();//@(*)[152123730|1143:miles:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("miles")
//@(text)--

end function

public function Integer of_SetMiles (Integer ai_miles);//@(*)[152123730|1143:miles:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "miles" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF

IF li_rc > 0 THEN
	IF ai_Miles < 0 THEN
		This.Event ue_RejectEdit ( This.cs_RejectEdit_Negative )
		li_rc = -1
	END IF
END IF

//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("miles", ai_miles) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetTotalweight ();//@(*)[152123785|1144:totalweight:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("totalweight")
//@(text)--

end function

public function Integer of_SetTotalweight (Long al_totalweight);//@(*)[152123785|1144:totalweight:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "totalweight" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF

IF li_rc > 0 THEN
	IF al_TotalWeight < 0 THEN
		This.Event ue_RejectEdit ( This.cs_RejectEdit_Negative )
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("totalweight", al_totalweight) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetCarriertripnumber ();//@(*)[152123991|1148:carriertripnumber:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("carriertripnumber")
//@(text)--

end function

public function Integer of_SetCarriertripnumber (String as_carriertripnumber);//@(*)[152123991|1148:carriertripnumber:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "carriertripnumber" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("carriertripnumber", as_carriertripnumber) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetInternalnote ();//@(*)[152124052|1149:internalnote:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("internalnote")
//@(text)--

end function

public function Integer of_SetInternalnote (String as_internalnote);//@(*)[152124052|1149:internalnote:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "internalnote" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Unrestricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("internalnote", as_internalnote) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEquipmenttype ();//@(*)[152123070|1129:equipmenttype:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("equipmenttype")
//@(text)--

end function

public function Integer of_SetEquipmenttype (String as_equipmenttype);//@(*)[152123070|1129:equipmenttype:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "equipmenttype" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("equipmenttype", as_equipmenttype) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEquipmentnumber ();//@(*)[152123112|1130:equipmentnumber:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("equipmentnumber")
//@(text)--

end function

public function Integer of_SetEquipmentnumber (String as_equipmentnumber);//@(*)[152123112|1130:equipmentnumber:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "equipmentnumber" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("equipmentnumber", as_equipmentnumber) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetChassisnumber ();//@(*)[152123153|1131:chassisnumber:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("chassisnumber")
//@(text)--

end function

public function Integer of_SetChassisnumber (String as_chassisnumber);//@(*)[152123153|1131:chassisnumber:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "chassisnumber" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("chassisnumber", as_chassisnumber) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function string of_getcarriername ();//@(*)[6241658|1234]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

String	ls_CarrierName
Long		ll_CarrierId
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

//Get the carrier's id
ll_CarrierId = This.of_GetCarrierId ( )

//Force the company into the cache, if it's not already there
gnv_cst_Companies.of_Cache ( ll_CarrierId, FALSE /*Don't Force refresh*/ )

//Set the beo as that company
lnv_Company.of_SetUseCache ( TRUE )
lnv_Company.of_SetSourceId ( ll_CarrierId )

//Get the company name  (will be null if company DNE)
ls_CarrierName = lnv_Company.of_GetName ( )

DESTROY lnv_Company

RETURN ls_CarrierName
end function

public function Boolean of_isstatusactive ();//@(*)[47496540|1245]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusActive ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusrestricted ();//@(*)[47515063|1246]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusRestricted ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatushistory ();//@(*)[47539295|1247]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusHistory ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusactive (string as_status);//@(*)[47304317|1239]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE as_Status

CASE cs_Status_Open

	//Status is in "Active" category
	lb_Result = TRUE

CASE cs_Status_Authorized, &
	cs_Status_AuditRequired

	//Status is in "Restricted" category
	//No processing needed

CASE cs_Status_Audited

	//Status is in "Audited" category
	//No processing needed

CASE cs_Status_History

	//Status is in "History" category
	//No processing needed

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function Boolean of_isstatusrestricted (string as_status);//@(*)[47403799|1241]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE as_Status

CASE cs_Status_Open

	//Status is in "Active" category
	//No processing needed

CASE cs_Status_Authorized, &
	cs_Status_AuditRequired

	//Status is in "Restricted" category
	lb_Result = TRUE

CASE cs_Status_Audited

	//Status is in "Audited" category
	//No processing needed

CASE cs_Status_History

	//Status is in "History" category
	//No processing needed

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function Boolean of_isstatushistory (string as_status);//@(*)[47459236|1243]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE as_Status

CASE cs_Status_Open

	//Status is in "Active" category
	//No processing needed

CASE cs_Status_Authorized, &
	cs_Status_AuditRequired

	//Status is in "Restricted" category
	//No processing needed

CASE cs_Status_Audited

	//Status is in "Audited" category
	//No processing needed

CASE cs_Status_History

	//Status is in "History" category
	lb_Result = TRUE

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function Boolean of_isstatusaudited ();//@(*)[55486367|1251]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusAudited ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusaudited (string as_status);//@(*)[55502523|1252]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE as_Status

CASE cs_Status_Open

	//Status is in "Active" category
	//No processing needed

CASE cs_Status_Authorized, &
	cs_Status_AuditRequired

	//Status is in "Restricted" category
	//No processing needed

CASE cs_Status_Audited

	//Status is in "Audited" category
	lb_Result = TRUE

CASE cs_Status_History

	//Status is in "History" category
	//No processing needed

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function integer of_checklocations ();//@(*)[58877881|1257]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Using the trip event list submitted, this function will verify whether the 
//trip origin and desination are still the same, and adjust OriginId and
//DestinationId, if necessary.

//Returns :  1 = Success, changes made
//				 0 = Success, no changes necessary
//				-1 = Error

//Note: Events are assumed to already be in trip sequence in the array

Long	ll_EventCount, &
		ll_OriginId, &
		ll_DestinationId, &
		ll_CurrentOriginId, &
		ll_CurrentDestinationId
n_cst_beo_Event	lnva_EventList[]

Boolean	lb_ChangesMade = FALSE
Integer	li_Return = 0


ll_CurrentOriginId = This.of_GetOriginId ( )
ll_CurrentDestinationId = This.of_GetDestinationId ( )


ll_EventCount = This.of_GetEventList ( lnva_EventList )

IF ll_EventCount = -1 THEN

	li_Return = -1

ELSE

	IF ll_EventCount > 0 THEN
		ll_OriginId = lnva_EventList [ 1 ].of_GetSite ( )
	
	ELSE
		SetNull ( ll_OriginId )
	
	END IF
	
	IF ll_EventCount > 1 THEN
		ll_DestinationId = lnva_EventList [ ll_EventCount ].of_GetSite ( )
	
	ELSE
		SetNull ( ll_DestinationId )
	
	END IF
	
	
	IF ( ll_OriginId = ll_CurrentOriginId ) OR &
		( IsNull ( ll_OriginId ) AND IsNull ( ll_CurrentOriginId ) ) THEN
	
		//Origin is already correct.  No changes needed.
	
	ELSE
	
		This.SetActionSource ( ci_ActionSource_System )
	
		IF This.of_SetOriginId ( ll_OriginId ) > 0 THEN
			lb_ChangesMade = TRUE
		END IF
	
		This.RestoreActionSource ( )
	
	END IF
	
	
	IF ( ll_DestinationId = ll_CurrentDestinationId ) OR &
		( IsNull ( ll_DestinationId ) AND IsNull ( ll_CurrentDestinationId ) ) THEN
	
		//Destination is already correct.  No changes needed.
	
	ELSE
	
		This.SetActionSource ( ci_ActionSource_System )
	
		IF This.of_SetDestinationId ( ll_DestinationId ) > 0 THEN
			lb_ChangesMade = TRUE
		END IF
	
		This.RestoreActionSource ( )
	
	END IF

	IF lb_ChangesMade THEN
		li_Return = 1
	END IF

END IF




RETURN li_Return
end function

public function integer of_seteventlist (ref n_cst_beo_event anva_eventlist[]);//This is a temporary attribute, until the trip can get its own event list
//through the bso context.  Scripts that call methods or events that use
//the list (CheckLocations and Delete) should set the list before calling.

inva_EventList = anva_EventList[]

//Set the flag to indicate the event list is "fresh" enough to be used.
//Scripts that use the event list should set the flag back to false when
//they're done, to force the list to be reset before being used again.
//Otherwise, we have no way of knowing if the list may have changed.

ib_HasEventList = TRUE

RETURN 1
end function

public function long of_geteventlist (ref n_cst_beo_event anva_eventlist[]);//Returns:  >=0 : The number of elements in the array, if successful
//				-1  : Failure

//Note:  Sets the "freshness" flag to false.  (See SetEventList for more explanation)

Long	ll_Return = -1

IF ib_HasEventList THEN

	anva_EventList = inva_EventList
	ll_Return = UpperBound ( anva_EventList )

	//Set the "freshness" flag to false
	ib_HasEventList = FALSE

END IF

RETURN ll_Return
end function

public function long of_getcarrierid ();//CarrierId is custom implemented, because HOW wouldn't generate it as an attribute
//because it's a foreign key.  For other references, browse this object and the dlk 
//for carrierid.

RETURN GetValue ( "carrierid" )
end function

public function long of_getdestinationid ();//@(*)[152123277|1134:destinationid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("destinationid")
//@(text)--

end function

public function long of_getoriginid ();//@(*)[152123194|1132:originid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("originid")
//@(text)--

end function

public function integer of_setcarrierid (long al_carrierid);//CarrierId is custom implemented, because HOW wouldn't generate it as an attribute
//because it's a foreign key.  For other references, browse this object and the dlk 
//for carrierid.

integer li_rc = 1

// Validation logic for "originid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_SystemField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


if li_rc > 0 then
   if SetValue("carrierid", al_CarrierId) < 1 then
      li_rc = -1
   end if
end if

return li_rc

end function

public function integer of_setdestinationid (long al_destinationid);//@(*)[152123277|1134:destinationid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "destinationid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_SystemField, cb_Unrestricted ) < 1 THEN
		//The thinking on making this unrestricted is that if the Destination has actually
		//changed, we might as well go ahead and record it, regardless of status.
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("destinationid", al_destinationid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function integer of_setoriginid (long al_originid);//@(*)[152123194|1132:originid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "originid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_SystemField, cb_Unrestricted ) < 1 THEN
		//The thinking on making this unrestricted is that if the Origin has actually
		//changed, we might as well go ahead and record it, regardless of status.
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("originid", al_originid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

on n_cst_beo_trip.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_trip.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

event ue_alloweditrestricted;call super::ue_alloweditrestricted;//EXTENDING ANCESTOR to provide class-specific processing.

Boolean	lb_Allow
n_cst_Privileges	lnv_Privileges

lb_Allow = AncestorReturnValue

//If Ancestor did not reject change, see if it passes further criteria.

IF lb_Allow THEN

	//Note: "Restricted" in this event's name means restricted in the broad sense.
	//There are three categories of restricted, one of which is named "Restricted".

	IF This.of_IsStatusRestricted ( ) THEN

		lb_Allow = lnv_Privileges.of_Trip_EditRestricted ( )

	ELSEIF This.of_IsStatusAudited ( ) THEN

		lb_Allow = lnv_Privileges.of_Trip_EditAudited ( )

	ELSEIF This.of_IsStatusHistory ( ) THEN

		lb_Allow = lnv_Privileges.of_Trip_EditHistory ( )

	END IF

END IF

RETURN lb_Allow
end event

event ue_allowuseredit;call super::ue_allowuseredit;//EXTENDING ANCESTOR to provide class-specific processing.

Boolean	lb_Allow
n_cst_Privileges	lnv_Privileges

lb_Allow = AncestorReturnValue

//If Ancestor did not reject change, see if it passes further criteria.

IF lb_Allow THEN

	lb_Allow = lnv_Privileges.of_Trip_Edit ( )

END IF

RETURN lb_Allow
end event

event ofr_predelete;call super::ofr_predelete;//Extending Ancestor

//	returns:			integer
//						1		OK for delete
//						<> 1	Disallow delete

n_cst_beo_Event	lnva_EventList[]
Long		ll_EventCount
String	ls_ErrorMessage
n_cst_OFRError		lnv_Error
n_cst_Privileges	lnv_Privileges

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 1 THEN

	//Verify whether user has authority to delete this trip.
	//Set error message for this section, in case it's needed.
	ls_ErrorMessage = "You are not authorized to delete this trip."

	IF This.AllowEdit ( cb_UserField, cb_Restricted ) THEN

		IF lnv_Privileges.of_Trip_Delete ( ) THEN

			//User has authority to delete this trip.

		ELSE
			li_Return = -1

		END IF

	ELSE
		li_Return = -1

	END IF


	IF li_Return = 1 THEN
	
		//Verify that there are no events routed to the trip.
	
		ll_EventCount = This.of_GetEventList ( lnva_EventList )
	
		IF ll_EventCount = 0 THEN
	
			//No events are routed to the trip.
	
		ELSEIF ll_EventCount > 0 THEN
	
			ls_ErrorMessage = "Cannot delete a trip that has events routed to it.~n"+&
				"Please remove the events and retry."
			li_Return = -1
	
		ELSE
	
			ls_ErrorMessage = "Could not process request.  Request cancelled."
			li_Return = -1
	
		END IF
	
	END IF

	IF li_Return = -1 THEN

		lnv_Error = This.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )
		lnv_Error.SetMessageHeader ( "Delete Trip" )

	END IF

END IF

RETURN li_Return
end event

