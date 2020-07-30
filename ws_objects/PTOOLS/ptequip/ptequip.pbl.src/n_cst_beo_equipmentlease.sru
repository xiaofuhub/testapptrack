$PBExportHeader$n_cst_beo_equipmentlease.sru
$PBExportComments$EquipmentLease (Persistent Class from PBL map PTData) //@(*)[75782811|875]
forward
global type n_cst_beo_equipmentlease from n_cst_beo
end type
end forward

global type n_cst_beo_equipmentlease from n_cst_beo
end type
global n_cst_beo_equipmentlease n_cst_beo_equipmentlease

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_beo inv_equipment //@(*)[75782811|875:equipment]<nosync>
private n_cst_beo inv_equipmentleasetype //@(*)[75782811|875:equipmentleasetype]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function Long of_GetOe_id ()
public function Integer of_SetOe_id (Long al_oe_id)
public function Long of_GetLeasedfrom ()
public function Integer of_SetLeasedfrom (Long al_leasedfrom)
public function Long of_GetOnbehalfof ()
public function Integer of_SetOnbehalfof (Long al_onbehalfof)
public function String of_GetBookingnumber ()
public function Integer of_SetBookingnumber (String as_bookingnumber)
public function datetime of_gettimeout ()
public function Integer of_SetTimeout (DateTime ad_timeout)
public function datetime of_gettimein ()
public function Integer of_SetTimein (DateTime ad_timein)
public function Long of_GetOriginationevent ()
public function Integer of_SetOriginationevent (Long al_originationevent)
public function Long of_GetTerminationevent ()
public function Integer of_SetTerminationevent (Long al_terminationevent)
public function Integer of_GetFkequipmentleasetype ()
public function Integer of_SetFkequipmentleasetype (Integer ai_fkequipmentleasetype)
public function String of_GetUser1 ()
public function Integer of_SetUser1 (String as_user1)
public function String of_GetUser2 ()
public function Integer of_SetUser2 (String as_user2)
public function String of_GetNotes ()
public function Integer of_SetNotes (String as_notes)
public function DateTime of_GetTimestamp ()
public function Integer of_SetTimestamp (DateTime ad_timestamp)
public function n_cst_beo of_GetEquipment ()
public function n_cst_beo of_GetEquipment (String as_query)
public function Integer of_SetEquipment (n_cst_beo anv_equipment)
public function n_cst_beo of_GetEquipmentleasetype ()
public function n_cst_beo of_getequipmentleasetype (string as_query)
public function Integer of_SetEquipmentleasetype (n_cst_beo anv_equipmentleasetype)
public function datetime of_getfreetimeexpiration ()
public function decimal of_getcharges ()
public function integer of_setequipmentdirectly (n_cst_beo anv_Equipment)
public function integer of_getcharges (ref n_Cst_LeaseCharges anv_LeaseCharges)
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_equipmentlease")
inv_bcm.RegisterRelationshipAttribute("oe_id", "long", "n_cst_beo_equipment", "id", "equipment")
inv_bcm.SetKey("oe_id")
inv_bcm.RegisterAttribute("leasedfrom", "long") //@(*)[75782894|876]
inv_bcm.RegisterAttribute("onbehalfof", "long") //@(*)[75782921|877]
inv_bcm.RegisterAttribute("bookingnumber", "character(15)") //@(*)[75782963|878]
inv_bcm.RegisterAttribute("timeout", "datetime") //@(*)[75782990|879]
inv_bcm.RegisterAttribute("timein", "datetime") //@(*)[75783031|880]
inv_bcm.RegisterAttribute("originationevent", "long") //@(*)[75783072|881]
inv_bcm.RegisterAttribute("terminationevent", "long") //@(*)[75783100|882]
inv_bcm.RegisterRelationshipAttribute("fkequipmentleasetype", "integer", "n_cst_beo_equipmentleasetype", "id", "equipmentleasetype")
inv_bcm.RegisterAttribute("user1", "string(32767)") //@(*)[63839188|928]
inv_bcm.RegisterAttribute("user2", "string(32767)") //@(*)[63853192|929]
inv_bcm.RegisterAttribute("notes", "string(32767)") //@(*)[63738021|927]
inv_bcm.RegisterAttribute("timestamp", "datetime") //@(*)[66898644|939]
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("oe_id", "outside_equip", "oe_id")
   inv_bcm.MapDBColumn("leasedfrom", "outside_equip", "oe_from")
   inv_bcm.MapDBColumn("onbehalfof", "outside_equip", "oe_for")
   inv_bcm.MapDBColumn("bookingnumber", "outside_equip", "oe_booknum")
   inv_bcm.MapDBColumn("timeout", "outside_equip", "oe_out")
   inv_bcm.MapDBColumn("timein", "outside_equip", "oe_in")
   inv_bcm.MapDBColumn("originationevent", "outside_equip", "oe_orig_event")
   inv_bcm.MapDBColumn("terminationevent", "outside_equip", "oe_term_event")
   inv_bcm.MapDBColumn("fkequipmentleasetype", "outside_equip", "fkEquipmentLeaseType")
   inv_bcm.MapDBColumn("user1", "outside_equip", "User1")
   inv_bcm.MapDBColumn("user2", "outside_equip", "User2")
   inv_bcm.MapDBColumn("notes", "outside_equip", "Notes")
   inv_bcm.MapDBColumn("timestamp", "outside_equip", "timestamp")
end if 
//@(text)--


return 1
end function

protected function integer setattribute (readonly String as_name, readonly any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
int li_rc

li_rc = super::SetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "oe_id" 
   return of_SetOe_id(Long(aa_value))
 case "leasedfrom" 
   return of_SetLeasedfrom(Long(aa_value))
 case "onbehalfof" 
   return of_SetOnbehalfof(Long(aa_value))
 case "bookingnumber" 
   return of_SetBookingnumber(String(aa_value))
 case "timeout" 
   return of_SetTimeout(Convert(aa_value, TypeDateTime!))
 case "timein" 
   return of_SetTimein(Convert(aa_value, TypeDateTime!))
 case "originationevent" 
   return of_SetOriginationevent(Long(aa_value))
 case "terminationevent" 
   return of_SetTerminationevent(Long(aa_value))
 case "fkequipmentleasetype" 
   return of_SetFkequipmentleasetype(Integer(aa_value))
 case "user1" 
   return of_SetUser1(String(aa_value))
 case "user2" 
   return of_SetUser2(String(aa_value))
 case "notes" 
   return of_SetNotes(String(aa_value))
 case "timestamp" 
   return of_SetTimestamp(Convert(aa_value, TypeDateTime!))
end choose

//@(text)--

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
 case "oe_id" 
   aa_value = of_GetOe_id()
   li_rc = 1
 case "leasedfrom" 
   aa_value = of_GetLeasedfrom()
   li_rc = 1
 case "onbehalfof" 
   aa_value = of_GetOnbehalfof()
   li_rc = 1
 case "bookingnumber" 
   aa_value = of_GetBookingnumber()
   li_rc = 1
 case "timeout" 
   aa_value = of_GetTimeout()
   li_rc = 1
 case "timein" 
   aa_value = of_GetTimein()
   li_rc = 1
 case "originationevent" 
   aa_value = of_GetOriginationevent()
   li_rc = 1
 case "terminationevent" 
   aa_value = of_GetTerminationevent()
   li_rc = 1
 case "fkequipmentleasetype" 
   aa_value = of_GetFkequipmentleasetype()
   li_rc = 1
 case "user1" 
   aa_value = of_GetUser1()
   li_rc = 1
 case "user2" 
   aa_value = of_GetUser2()
   li_rc = 1
 case "notes" 
   aa_value = of_GetNotes()
   li_rc = 1
 case "timestamp" 
   aa_value = of_GetTimestamp()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Long of_GetOe_id ();//@(*)[75782139|858:oe_id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("oe_id")
//@(text)--

end function

public function Integer of_SetOe_id (Long al_oe_id);//@(*)[75782139|858:oe_id:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "oe_id" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("oe_id", al_oe_id) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetLeasedfrom ();//@(*)[75782894|876:leasedfrom:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("leasedfrom")
//@(text)--

end function

public function Integer of_SetLeasedfrom (Long al_leasedfrom);//@(*)[75782894|876:leasedfrom:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "leasedfrom" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("leasedfrom", al_leasedfrom) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetOnbehalfof ();//@(*)[75782921|877:onbehalfof:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("onbehalfof")
//@(text)--

end function

public function Integer of_SetOnbehalfof (Long al_onbehalfof);//@(*)[75782921|877:onbehalfof:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "onbehalfof" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("onbehalfof", al_onbehalfof) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetBookingnumber ();//@(*)[75782963|878:bookingnumber:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("bookingnumber")
//@(text)--

end function

public function Integer of_SetBookingnumber (String as_bookingnumber);//@(*)[75782963|878:bookingnumber:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "bookingnumber" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("bookingnumber", as_bookingnumber) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function datetime of_gettimeout ();//@(*)[75782990|879:timeout:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>
//return GetValue("timeout")
//@(text)--

//Column does not actually contain values.  We need to assemble the values from the 
//EquipmentLease_OriginationDate and EquipmentLease_OriginationTime fields.

//NOTE : The approach used here is a carry-over from the way we used to do this when
//these values came from an event join (pre 3.5.0)  These calls could (and should)
//be replaced with a simple Get call now that these values exist on EquipmentLease itself.
/* 
	RDT 12-05-02 Changed to account for Notify and Outgate values. 
	If FreetimeStart = 1 (Notify) use the notify date and time date from disp_ship
	If FreeTimeStart = 2 (OutGate) use the origination date and time date
	NOTE: Same logic exists in n_cst_beo_EquipmentLease2. 
	The Current menu of the Shipment calls this function.
*/ 

DataStore	lds_View
n_cst_Bcm	lnv_Bcm
Long			ll_ViewRow, &
				ll_EquipID
				
Date			ld_Origination
Time			lt_Origination
DateTime		ldt_TimeOut

SetNull ( ld_Origination )
SetNull ( lt_Origination )
SetNull ( ldt_TimeOut )

lnv_Bcm = This.GetBcm ( )
lds_View = lnv_Bcm.GetView ( )
ll_ViewRow = lds_View.GetRowFromRowID ( This.GetBeoIndex ( ) )

//If column exists on the view, get the value
IF Len ( lds_View.Describe ( "EquipmentLease_OriginationDate.Name" ) ) > 0 THEN 
	
	// RDT 12-05-02 new code - Start 
	If lds_View.GetItemNumber ( ll_ViewRow, "freetimestart" ) = 1 then 			
		ll_EquipId = lds_View.GetItemNumber ( ll_ViewRow, "equipment_id")
		
		SELECT "disp_ship"."releasedate", "disp_ship"."releasetime"
		INTO 	 :ld_Origination, :lt_Origination
		FROM 	 "disp_ship", "outside_equip"  
		WHERE   ( "outside_equip"."shipment" = "disp_ship"."ds_id" ) and ("outside_equip"."oe_id" = :ll_EquipID );
		
		if SQLCA.SqlCode = -1 Then 															
			SetNull ( ld_Origination )
			SetNull ( lt_Origination )
			ROLLBACK;
		else 
			COMMIT;
		end if
		
		If NOT IsNull( ld_Origination ) Then 												
			
			if IsNull ( lt_Origination ) then												
				lt_Origination = 00:00:00
			end if																					
			
			ldt_TimeOut = DateTime ( ld_Origination, lt_Origination )	
		End If																								
		
	Else																										
		// RDT 12-05-02 new code - End
		ld_Origination = lds_View.GetItemDate ( ll_ViewRow, "EquipmentLease_OriginationDate" )
		IF NOT IsNull ( ld_Origination ) THEN
			
			//If column exists on the view, get the value
			IF Len ( lds_View.Describe ( "EquipmentLease_OriginationTime.Name" ) ) > 0 THEN
				
				lt_Origination = lds_View.GetItemTime ( ll_ViewRow, "EquipmentLease_OriginationTime" )
				//New in 3.5.0 : If the OriginationTime is null, use midnight (that morning.)
				//(We used to give a null back if there was no time specified on the event.)
				
				IF IsNull ( lt_Origination ) THEN
					lt_Origination = 00:00:00
				END IF								
				
				ldt_TimeOut = DateTime ( ld_Origination, lt_Origination )			
			END IF									
			
		END IF									
		
	END IF										
	
END IF	

RETURN ldt_TimeOut
end function

public function Integer of_SetTimeout (DateTime ad_timeout);//@(*)[75782990|879:timeout:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "timeout" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("timeout", ad_timeout) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function datetime of_gettimein ();//@(*)[75783031|880:timein:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>
//return GetValue("timein")
//@(text)--

//Column does not actually contain values.  We need to assemble the values from the 
//EquipmentLease_TerminationDate and EquipmentLease_TerminationTime fields.

//NOTE : The approach used here is a carry-over from the way we used to do this when
//these values came from an event join (pre 3.5.0)  These calls could (and should)
//be replaced with a simple Get call now that these values exist on EquipmentLease itself.

DataStore	lds_View
n_cst_Bcm	lnv_Bcm
Long			ll_ViewRow
Date			ld_Termination
Time			lt_Termination
DateTime		ldt_TimeIn

SetNull ( ld_Termination )
SetNull ( lt_Termination )
SetNull ( ldt_TimeIn )

lnv_Bcm = This.GetBcm ( )
lds_View = lnv_Bcm.GetView ( )
ll_ViewRow = lds_View.GetRowFromRowID ( This.GetBeoIndex ( ) )

//If column exists on the view, get the value
IF Len ( lds_View.Describe ( "EquipmentLease_TerminationDate.Name" ) ) > 0 THEN

	ld_Termination = lds_View.GetItemDate ( ll_ViewRow, "EquipmentLease_TerminationDate" )

	IF NOT IsNull ( ld_Termination ) THEN
	
		//If column exists on the view, get the value
		IF Len ( lds_View.Describe ( "EquipmentLease_TerminationTime.Name" ) ) > 0 THEN

			lt_Termination = lds_View.GetItemTime ( ll_ViewRow, "EquipmentLease_TerminationTime" )
	
			//New in 3.5.0 : If time is null, use just before midnight that evening.
			//(Previously we would give a null value if the time was not specified on the event.)

			IF IsNull ( lt_Termination ) THEN
				lt_Termination = 23:59:59
			END IF

			ldt_TimeIn = DateTime ( ld_Termination, lt_Termination )

		END IF
	END IF
END IF

RETURN ldt_TimeIn
end function

public function Integer of_SetTimein (DateTime ad_timein);//@(*)[75783031|880:timein:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "timein" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("timein", ad_timein) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetOriginationevent ();//@(*)[75783072|881:originationevent:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("originationevent")
//@(text)--

end function

public function Integer of_SetOriginationevent (Long al_originationevent);//@(*)[75783072|881:originationevent:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "originationevent" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("originationevent", al_originationevent) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetTerminationevent ();//@(*)[75783100|882:terminationevent:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("terminationevent")
//@(text)--

end function

public function Integer of_SetTerminationevent (Long al_terminationevent);//@(*)[75783100|882:terminationevent:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "terminationevent" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("terminationevent", al_terminationevent) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetFkequipmentleasetype ();//@(*)[74094561|584:fkequipmentleasetype:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fkequipmentleasetype")
//@(text)--

end function

public function Integer of_SetFkequipmentleasetype (Integer ai_fkequipmentleasetype);//@(*)[74094561|584:fkequipmentleasetype:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fkequipmentleasetype" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fkequipmentleasetype", ai_fkequipmentleasetype) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetUser1 ();//@(*)[63839188|928:user1:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user1")
//@(text)--

end function

public function Integer of_SetUser1 (String as_user1);//@(*)[63839188|928:user1:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "user1" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("user1", as_user1) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetUser2 ();//@(*)[63853192|929:user2:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user2")
//@(text)--

end function

public function Integer of_SetUser2 (String as_user2);//@(*)[63853192|929:user2:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "user2" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("user2", as_user2) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetNotes ();//@(*)[63738021|927:notes:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("notes")
//@(text)--

end function

public function Integer of_SetNotes (String as_notes);//@(*)[63738021|927:notes:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "notes" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("notes", as_notes) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function DateTime of_GetTimestamp ();//@(*)[66898644|939:timestamp:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("timestamp")
//@(text)--

end function

public function Integer of_SetTimestamp (DateTime ad_timestamp);//@(*)[66898644|939:timestamp:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "timestamp" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("timestamp", ad_timestamp) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_GetEquipment ();//@(*)[58729747|916:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetEquipment(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetEquipment (String as_query);//@(*)[58729747|916]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_equipment = GetRelationship( inv_equipment, "n_cst_dlkc_equipment",  "equipment", "equipmentlease", as_query, "n_cst_beo_equipment" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_equipment
//@(text)--

end function

public function Integer of_SetEquipment (n_cst_beo anv_equipment);//@(*)[58729747|916:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_equipment,"equipment") = 1 then
inv_equipment = anv_equipment
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function n_cst_beo of_GetEquipmentleasetype ();//@(*)[63106059|918:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetEquipmentleasetype(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_getequipmentleasetype (string as_query);//@(*)[63106059|918]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>
//inv_equipmentleasetype = GetRelationship( inv_equipmentleasetype, "n_cst_dlkc_equipmentleasetype",  "equipmentleasetype", "equipmentlease", as_query, "n_cst_beo_equipmentleasetype" )
//@(text)--

//@(text)(recreate=no)<Return BEO>
//return inv_equipmentleasetype
//@(text)--


//Override to get beo from global cache, instead of retrieving it.  NOTE: This does not force retrieval of
//a new beo that was not originally retrieved in the cache.

n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Long			ll_fkLeaseType

IF IsValid ( inv_EquipmentLeaseType ) THEN

	lnv_Beo = inv_EquipmentLeaseType

ELSE

	ll_fkLeaseType = This.of_GetfkEquipmentLeaseType ( )
	
	IF NOT IsNull ( ll_fkLeaseType ) THEN
	
		IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_EquipmentLeaseType", lnv_Cache, TRUE, TRUE ) = 1 THEN
		
			lnv_Beo = lnv_Cache.GetBeo ( "EquipmentLeaseType_Id = " + String ( ll_fkLeaseType ) )

			IF IsValid ( lnv_Beo ) THEN
				inv_EquipmentLeaseType = lnv_Beo
			END IF
		
		END IF
	END IF
END IF

RETURN lnv_Beo
end function

public function Integer of_SetEquipmentleasetype (n_cst_beo anv_equipmentleasetype);//@(*)[63106059|918:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_equipmentleasetype,"equipmentleasetype") = 1 then
inv_equipmentleasetype = anv_equipmentleasetype
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function datetime of_getfreetimeexpiration ();//@(*)[160813001|979]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


DateTime ldt_Expiration
DateTime ldt_OutDateTime
Date     ld_ExpirationDate
Time 	 lt_ExpirationTime
n_cst_beo_EquipmentLeaseType	lnv_LeaseType


lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

IF IsValid ( lnv_LeaseType ) THEN

	ldt_OutDateTime = This.of_GetTimeOut ( )

	lnv_LeaseType.of_GetFreeTimeExpiration ( Date (ldt_OutDateTime ), Time ( ldt_OutDateTime ) , & 
									ld_ExpirationDate ,	lt_ExpirationTime )
	ldt_Expiration = DateTime(ld_ExpirationDate , lt_ExpirationTime )

ELSE
	SetNull ( ldt_Expiration )

END IF

RETURN ldt_Expiration



end function

public function decimal of_getcharges ();//@(*)[160782788|978]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>
//@(text)--


DateTime	ldt_Out, &
			ldt_In
Decimal	lc_Charges
n_cst_beo_EquipmentLeaseType	lnv_LeaseType

lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

IF IsValid ( lnv_LeaseType ) THEN

	ldt_Out = This.of_GetTimeOut ( )
	ldt_In = This.of_GetTimeIn ( )

	lnv_LeaseType.of_GetCharges ( Date ( ldt_Out ), Time ( ldt_Out ), &
		Date ( ldt_In ), Time ( ldt_In ), lc_Charges )

ELSE
	SetNull ( lc_Charges )

END IF

RETURN lc_Charges
end function

public function integer of_setequipmentdirectly (n_cst_beo anv_Equipment);inv_equipment = anv_Equipment
RETURN 1
end function

public function integer of_getcharges (ref n_Cst_LeaseCharges anv_LeaseCharges);
DateTime	ldt_Out, &
			ldt_In
Int		li_Rtn = 1
n_cst_beo_EquipmentLeaseType	lnv_LeaseType

lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

IF IsValid ( lnv_LeaseType ) THEN

	ldt_Out = This.of_GetTimeOut ( )
	ldt_In = This.of_GetTimeIn ( )

	lnv_LeaseType.of_GetCharges ( Date ( ldt_Out ), Time ( ldt_Out ), &
		Date ( ldt_In ), Time ( ldt_In ), anv_LeaseCharges )

ELSE
	li_Rtn = -1
END IF

RETURN li_Rtn
end function

on n_cst_beo_equipmentlease.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_equipmentlease.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("oe_id")
this.SetRequired("fkequipmentleasetype")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

