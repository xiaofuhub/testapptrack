$PBExportHeader$n_cst_beo_event.sru
forward
global type n_cst_beo_event from pt_n_cst_beo
end type
end forward

global type n_cst_beo_event from pt_n_cst_beo
event type integer ue_eventconfirmed ( )
end type
global n_cst_beo_event n_cst_beo_event

type variables
Public:
n_cst_beo_Shipment	inv_Shipment

Private:
Constant String	cs_StartSiteDelimiter = "<<"
Constant String	cs_EndSiteDelimiter = ">>"
end variables

forward prototypes
public function string of_getconfirmed ()
public function boolean of_isconfirmed ()
public function long of_getsite ()
public function boolean of_hassite ()
public function integer of_getsite (ref n_cst_beo_company anv_company)
public function string of_getlocation ()
public function long of_getid ()
public function long of_getshipment ()
public function integer of_getshipmentsequence ()
public function integer of_setshipment (readonly n_cst_beo_shipment anv_shipment)
public function integer of_setconfirmed (readonly string as_value)
public function integer of_setconfirmedby (readonly string as_value)
public function integer of_confirm ()
public function boolean of_hasshipment ()
public function long of_gettrip ()
public function boolean of_isthirdparty ()
public function date of_getscheduleddate ()
public function time of_getscheduledtime ()
public function string of_gettype ()
public function boolean of_ishook ()
public function boolean of_istype (readonly string as_Type)
public function boolean of_isdrop ()
public function decimal of_getfreightrevenue ()
public function boolean of_isworkingstop ()
public function date of_getdatearrived ()
public function date of_getdatearrived (readonly boolean ab_requireconfirmation)
public function time of_gettimearrived ()
public function time of_gettimedeparted ()
public function time of_gettimearrived (readonly boolean ab_requireconfirmation)
public function time of_gettimedeparted (readonly boolean ab_requireconfirmation)
public function string of_getnote ()
public function string of_getnote (readonly boolean ab_requireconfirmation)
public function date of_getdatedeparted ()
public function string of_getwhoconfirmed ()
public function string of_getstatus ()
public function time of_getduration ()
public function integer of_getsite (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache)
public function string of_getappointmentnumber ()
public function long of_getassignmentbyindex (integer ai_index)
public function long of_getdriverid ()
public function long of_gettractorid ()
public function long of_gettrailer1id ()
public function long of_gettrailer2id ()
public function long of_gettrailer3id ()
public function long of_getcontainer1id ()
public function long of_getcontainer2id ()
public function long of_getcontainer3id ()
public function long of_getcontainer4id ()
public function long of_getacteqid ()
public function long of_getactpos ()
public function string of_getmultilist ()
public function boolean of_keepwithdroppedtrailer (long al_trailerid)
public function boolean of_ispassive ()
public function integer of_whatsleft (integer ai_RelativeToType, long al_RelativeToId, ref s_longs astr_Ids, ref string as_MultiList)
public function boolean of_isassignment ()
public function boolean of_islocationoptional ()
public function boolean of_ispickupgroup ()
public function boolean of_isdelivergroup ()
public function integer of_setdatearrived (readonly date ad_value)
public function integer of_settimearrived (readonly time at_value)
public function integer of_settimedeparted (readonly time at_value)
public function boolean of_isnonrouted ()
public function integer of_setnote (readonly string as_value)
public function integer of_appendnote (readonly string as_value)
public function string of_getcontainerlist ()
public function boolean of_ismount ()
public function boolean of_isdismount ()
public function string of_getdescriptionbyindex (integer ai_index, string as_describetype)
public function string of_gettrailerlist ()
public function string of_getpowerunit ()
public function string of_getdriver ()
public function integer of_settype (readonly string as_value)
public function integer of_assignbyindex (integer ai_index, long al_id, boolean ab_sequence, decimal ac_sequence)
public function integer of_clearrouting (boolean ab_cleartimesandconf)
public function integer of_setmultilist (readonly string as_value)
public function integer of_setactpos (readonly long al_value)
public function integer of_getlocaltimezone ()
public function integer of_getbasetimezone ()
public function time of_getlocaltime (date adt_basedate, time adt_basetime)
public function date of_getlocaldate (date ad_basedate, time ad_basetime)
public function integer of_getcontainerlist (ref long ala_ids[], readonly boolean ab_Append)
public function integer of_gettrailerlist (ref long ala_ids[], readonly boolean ab_Append)
public function integer of_getactiveassignments (ref long ala_drivers[], ref long ala_powerunits[], ref long ala_trailerchassis[], ref long ala_containers[])
public function integer of_getactiveassignments (ref long ala_drivers[], ref long ala_equipment[])
public function integer of_getassignments (ref long ala_drivers[], ref long ala_powerunits[], ref long ala_trailerchassis[], ref long ala_containers[])
public function integer of_getassignments (ref long ala_drivers[], ref long ala_equipment[])
public function boolean of_isactiveinassignment (integer ai_type, long al_id)
public function integer of_getassignments (ref n_cst_dispatchids anv_dispatchids)
public function integer of_getbaseforassignment (ref integer ai_basetype, ref long al_baseid, integer ai_targettype, long al_targetid, boolean ab_assign)
public function integer of_setsite (readonly long al_value)
public function integer of_unconfirm ()
public function boolean of_isinterchangecapable ()
public function boolean of_isassociation ()
public function boolean of_isdissociation ()
public function boolean of_istermination ()
public function integer of_getfreightcarryingequipment (ref long ala_powerunits[], ref long ala_trailers[], ref long ala_containers[])
public function boolean of_hasfreightcarryingequipment ()
public function integer of_setid (long al_Value)
public function integer of_setshipment (long al_value)
public function integer of_setshipseq (long al_value)
public function long of_getshipseq ()
public function boolean of_allowmakemount ()
public function boolean of_allowmakedismount ()
public function boolean of_isrouted ()
public function boolean of_hasactivetrailerchassiscontainer ()
public function boolean of_hasactivecontainer ()
public function decimal of_getfreightsplit ()
public function decimal of_getaccessorialsplit ()
public function long of_getsitefromnote ()
public function integer of_setsiteineventnote (long al_site)
public function integer of_setscheduleddate (date ad_value)
public function integer of_setscheduledtime (time at_value)
public function integer of_setreference (string as_value)
public function string of_getreference ()
public function string of_getnotificationtemplate ()
public function string of_getnotificationsubject ()
public function integer of_getnotificationtargets (ref long ala_contactids[])
public function boolean of_isnotificationworthy ()
public function integer of_setroutable (string as_value)
public function string of_getroutable ()
public function boolean of_sendnotification ()
private function boolean of_istypepickup ()
private function boolean of_istypedrop ()
public function boolean of_isorigin (readonly long al_id)
public function boolean of_isdestination (readonly long al_id)
public function boolean of_sendnotification (long al_companyid)
public function integer of_seteventcontacts (long ala_contacts[])
public function integer of_geteventcontacts (ref long ala_contacts[])
public function integer of_addcontactid (long al_contactid)
public function integer of_removecontactid (readonly long al_contactid)
public function boolean of_isassigned (integer ai_type, long al_id)
public function boolean of_iscrossdock ()
public function Boolean of_gethideonbill ()
public function integer of_sethideonbill (boolean ab_value)
public function integer of_getshipment (ref n_cst_beo_shipment anv_shipment)
public function boolean of_isorigin (long ala_id[])
public function boolean of_isdestination (long ala_id[])
public function integer of_addcompaniestoevent ()
public function integer of_setsitebyref (string as_companyref)
public function long of_getimportreference ()
public function integer of_setimportreference (long al_value)
public function date of_getearliestdate ()
public function date of_getlatestdate ()
public function time of_getearliesttime ()
public function time of_getlatesttime ()
public function integer of_setlatesttime (readonly time at_value)
public function integer of_setlatestdate (date ad_value)
public function integer of_setearliestdate (date ad_value)
public function integer of_setearliesttime (readonly time at_value)
public function decimal of_getdriverseq ()
public function decimal of_gettractorseq ()
public function decimal of_gettrailer1seq ()
public function decimal of_gettrailer2seq ()
public function decimal of_gettrailer3seq ()
public function decimal of_getcontainer1seq ()
public function decimal of_getcontainer2seq ()
public function decimal of_getcontainer3seq ()
public function decimal of_getcontainer4seq ()
public function decimal of_gettripseq ()
public function integer of_getreferencedentities (ref pt_n_cst_beo anv_objects[])
public function integer of_setappointmentnumber (string as_value)
public function integer of_setstatus (readonly string as_value)
public function integer of_replaceunknownequipment (string as_type, string as_newvalue)
public function long of_getdivisionid ()
public function integer of_setcrossdock (long al_value)
public function boolean of_hasactivetrailercontainer ()
public function boolean of_hasactivetrailerchassiscontainer (boolean ab_allowunknownchassis)
public function boolean of_isbobtailevent ()
public function integer of_getbobtaileventids (ref long al_origineventid, ref long al_desteventid)
public function integer of_setbobtaillocations (long al_originevent, long al_destevent)
end prototypes

public function string of_getconfirmed ();RETURN This.of_GetValue ( "de_conf", TypeString! )
end function

public function boolean of_isconfirmed ();Boolean	lb_Result

IF This.of_GetConfirmed ( ) = "T" THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function long of_getsite ();RETURN This.of_GetValue ( "de_site", TypeLong! )
end function

public function boolean of_hassite ();Boolean	lb_Result

IF of_GetSite ( ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function integer of_getsite (ref n_cst_beo_company anv_company);//Return : 1 = Success (Valid Site Passed Out), 0 = No Site (Null SiteId), -1 = Error

//We're not calling the overloaded version in order to avoid the performance
//hit of passing the AutoInstantiated variable again.

Long		ll_SiteId
Integer	li_Return = -1

ll_SiteId = This.of_GetSite ( )

//Since there are a lot of scripts that assume that the company is valid i commented the check
//to see if the id is valid. 

//IF IsNull ( ll_SiteId ) THEN
//
//	li_Return = 0
//
//ELSE
//
	DESTROY anv_company

	anv_company = CREATE n_cst_beo_Company
	
	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_SiteId ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		ELSE 
			li_Return = 0
		END IF
	END IF

//END IF

RETURN li_Return
end function

public function string of_getlocation ();string	ls_location

n_cst_beo_Company	lnv_Company

of_GetSite ( lnv_Company )

ls_location = lnv_Company.of_GetLocation ( )

DESTROY lnv_Company

RETURN ls_location
end function

public function long of_getid ();RETURN This.of_GetValue ( "de_id", TypeLong! )
end function

public function long of_getshipment ();RETURN of_GetValue ( "de_shipment_id", TypeLong! )
end function

public function integer of_getshipmentsequence ();RETURN This.of_GetValue ( "de_ship_seq", TypeInteger! )
end function

public function integer of_setshipment (readonly n_cst_beo_shipment anv_shipment);//Currently, this is not a change of assignment, just a registration 
//of an existing relationship.

inv_Shipment = anv_Shipment

RETURN 1
end function

public function integer of_setconfirmed (readonly string as_value);RETURN This.of_SetAny ( "de_conf", as_Value )
end function

public function integer of_setconfirmedby (readonly string as_value);RETURN This.of_SetAny ( "de_whoconf", as_Value )
end function

public function integer of_confirm ();//Returns:  SUCCESS, FAILURE, NO_ACTION

String	ls_ConfirmedBy
Boolean	lb_HasSite


Integer	li_Return = 1

IF This.of_IsConfirmed ( ) THEN
	//Event is already confirmed.  Return NO_ACTION
	li_Return = 0

END IF


IF li_Return = 1 THEN

	//This check is included here only for the purpose of validating non-routed events 
	//directly, as is currently done in n_cst_beo_Shipment.of_ConfirmAllEvents.
	//If we can find a way to eliminate that, we can eliminate this, too.
	//It's redundant with the check in n_cst_EventConfirmationOptions.of_CheckRequirements,
	//but that's ok.

	lb_HasSite = This.of_HasSite ( )

	IF THIS.of_IsLocationOptional() THEN
		//don't require
	ELSE
		IF lb_HasSite = FALSE THEN
			This.of_AddError ( "The site for this event has not been specified." )
			li_Return = -1
		END IF
	END IF
	
END IF


IF li_Return = 1 THEN

	ls_ConfirmedBy = gnv_App.of_GetUserId ( )
	This.of_SetConfirmedBy ( ls_ConfirmedBy )
	li_Return = This.of_SetConfirmed ( "T" )
	
	

ELSEIF li_Return = -1 THEN

	IF This.of_GetErrorCount ( ) = 0 THEN
		This.of_AddError ( "An unexpected error has occurred." )
	END IF
	
END IF

RETURN li_Return
end function

public function boolean of_hasshipment ();Boolean	lb_Result

IF This.of_GetShipment ( ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function long of_gettrip ();RETURN This.of_GetValue ( gc_Dispatch.cs_Column_Trip, TypeLong! )
end function

public function boolean of_isthirdparty ();Boolean	lb_Result

IF This.of_GetTrip ( ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function date of_getscheduleddate ();RETURN This.of_GetValue ( "de_apptdate", TypeDate! )
end function

public function time of_getscheduledtime ();RETURN This.of_GetValue ( "de_appttime", TypeTime! )
end function

public function string of_gettype ();RETURN This.of_GetValue ( "de_event_type", TypeString! )
end function

public function boolean of_ishook ();//Returns:  TRUE, FALSE, Null if can't be determined

RETURN This.of_IsType ( gc_Dispatch.cs_EventType_Hook )
end function

public function boolean of_istype (readonly string as_Type);//Returns:  TRUE, FALSE, Null if can't be determined

RETURN This.of_GetType ( ) = as_Type
end function

public function boolean of_isdrop ();//Returns:  TRUE, FALSE, Null if can't be determined

RETURN This.of_IsType ( gc_Dispatch.cs_EventType_Drop )
end function

public function decimal of_getfreightrevenue ();//Returns:  Freight revenue allocation for this event, or null if cannot be determined.
//Note: inv_Shipment must be valid in order for this to succeed.

Decimal {2}	lc_AllocatedRevenue, &
				lc_ShipmentFreightNet
Decimal		lc_AllocationFactor
Long			ll_ShipmentEventCount


IF This.of_HasShipment ( ) = FALSE THEN
	//The event is not associated with a shipment.  Allocated revenue is zero.
	lc_AllocatedRevenue = 0

ELSEIF IsValid ( inv_Shipment ) THEN
	
	IF inv_Shipment.of_HasSource ( ) THEN

		lc_ShipmentFreightNet = inv_Shipment.of_GetNetFreightCharges ( )
	
		IF lc_ShipmentFreightNet <> 0 THEN
	
			///////////////////////////////
			//Note:  This calculation is based on an even per-stop revenue allocation.
			//We could implement other allocation formulas here, based on user preferences.
	
			ll_ShipmentEventCount = inv_Shipment.of_GetEventCount ( )
	
			IF ll_ShipmentEventCount > 0 THEN
				lc_AllocationFactor = 1 / ll_ShipmentEventCount
			ELSE
				SetNull ( lc_AllocationFactor )
			END IF
	
			///////////////////////////////
	
		ELSE
			//Nothing to allocate.  Don't bother to determine allocation factor.
	
		END IF
	
	
		IF NOT ( IsNull ( lc_ShipmentFreightNet ) OR IsNull ( lc_AllocationFactor ) ) THEN
			lc_AllocatedRevenue = lc_ShipmentFreightNet * lc_AllocationFactor
		ELSE
			SetNull ( lc_AllocatedRevenue )
		END IF
	END IF
ELSE
	SetNull ( lc_AllocatedRevenue )

END IF


RETURN lc_AllocatedRevenue
end function

public function boolean of_isworkingstop ();//Returns:  TRUE, FALSE, Null if can't be determined

/* This was one idea...

//Boolean	lb_WorkingStop = FALSE
//
//CHOOSE CASE This.of_GetType ( )
//
//CASE gc_Dispatch.cs_EventType_Hook, &
//	gc_Dispatch.cs_EventType_Drop, &
//	gc_Dispatch.cs_EventType_Mount, &
//	gc_Dispatch.cs_EventType_Dismount, &
//	gc_Dispatch.cs_EventType_Pickup, &
//	gc_Dispatch.cs_EventType_Deliver
//
//	lb_WorkingStop = TRUE
//
//END CHOOSE
//
//RETURN lb_WorkingStop

*/


//Going with this one instead...

RETURN This.of_HasShipment ( )
end function

public function date of_getdatearrived ();RETURN This.of_GetValue ( "de_arrdate", TypeDate! )
end function

public function date of_getdatearrived (readonly boolean ab_requireconfirmation);//If ab_RequireConfirmation = TRUE, then Returns DateArrived if confirmed, null if not.
//Otherwise, returns DateArrived, if one has been specified.

Date	ld_Result
Boolean	lb_AcceptValue = TRUE

IF ab_RequireConfirmation THEN

	IF This.of_IsConfirmed ( ) = FALSE THEN
		lb_AcceptValue = FALSE
	END IF

END IF

IF lb_AcceptValue THEN
	ld_Result = This.of_GetDateArrived ( )
ELSE
	SetNull ( ld_Result )
END IF

RETURN ld_Result
end function

public function time of_gettimearrived ();RETURN This.of_GetValue ( "de_arrtime", TypeTime! )
end function

public function time of_gettimedeparted ();RETURN This.of_GetValue ( "de_deptime", TypeTime! )
end function

public function time of_gettimearrived (readonly boolean ab_requireconfirmation);//If ab_RequireConfirmation = TRUE, then Returns TimeArrived if confirmed, null if not.
//Otherwise, returns TimeArrived, if one has been specified.

Time	lt_Result
Boolean	lb_AcceptValue = TRUE

IF ab_RequireConfirmation THEN

	IF This.of_IsConfirmed ( ) = FALSE THEN
		lb_AcceptValue = FALSE
	END IF

END IF

IF lb_AcceptValue THEN
	lt_Result = This.of_GetTimeArrived ( )
ELSE
	SetNull ( lt_Result )
END IF

RETURN lt_Result
end function

public function time of_gettimedeparted (readonly boolean ab_requireconfirmation);//If ab_RequireConfirmation = TRUE, then Returns TimeDeparted if confirmed, null if not.
//Otherwise, returns TimeDeparted, if one has been specified.

Time	lt_Result
Boolean	lb_AcceptValue = TRUE

IF ab_RequireConfirmation THEN

	IF This.of_IsConfirmed ( ) = FALSE THEN
		lb_AcceptValue = FALSE
	END IF

END IF

IF lb_AcceptValue THEN
	lt_Result = This.of_GetTimeDeparted ( )
ELSE
	SetNull ( lt_Result )
END IF

RETURN lt_Result
end function

public function string of_getnote ();RETURN This.of_GetValue ( "de_note", TypeString! )
end function

public function string of_getnote (readonly boolean ab_requireconfirmation);//If ab_RequireConfirmation = TRUE, then Returns the Note if confirmed, null if not.
//(This can be used for POD, Signature, etc.)
//Otherwise, returns the Note, if one has been specified.

String	ls_Result
Boolean	lb_AcceptValue = TRUE

IF ab_RequireConfirmation THEN


	IF This.of_IsConfirmed ( ) = FALSE THEN
		lb_AcceptValue = FALSE
	END IF

END IF


IF lb_AcceptValue THEN
	ls_Result = This.of_GetNote ( )
ELSE
	SetNull ( ls_Result )
END IF

RETURN ls_Result
end function

public function date of_getdatedeparted ();//Because de_depdate is not stored for events other than non-routed, 
//we'll have to extrapolate the value in cases where it's not stored.

Date	ld_DateArrived
Time	lt_TimeDeparted

Date	ld_Return

//Get the actual value on the column.  If it's there, use it.
//If it's null, try to extrapolate it based on the date arrived.

ld_Return = This.of_GetValue ( "de_depdate", TypeDate! )

IF IsNull ( ld_Return ) THEN

	//Get the date arrived.
	ld_DateArrived = This.of_GetDateArrived ( )

	IF IsNull ( ld_DateArrived ) THEN

		//Leave return value null (we have nothing to go on.)

	ELSE

		//We have a date arrived.  See if we can extrapolate a date departed.

		lt_TimeDeparted = This.of_GetTimeDeparted ( )

		IF IsNull ( lt_TimeDeparted ) THEN

			//Leave return value null (we haven't departed.)

		ELSEIF lt_TimeDeparted < This.of_GetTimeArrived ( ) THEN

			//The time departed is less than the time arrived.  Infer that we're 
			//departing on the day following the date we arrived.
			ld_Return = RelativeDate ( ld_DateArrived, 1 )

		ELSE

			//The time departed is greater than the time arrived, or the time arrived
			//was not specified.  Infer that we're leaving on the same date we arrived.
			ld_Return = ld_DateArrived

		END IF

	END IF

END IF

RETURN ld_Return
end function

public function string of_getwhoconfirmed ();RETURN This.of_GetValue ( "de_whoconf", TypeString! )
end function

public function string of_getstatus ();RETURN This.of_GetValue ( "de_status", TypeString! )
end function

public function time of_getduration ();RETURN This.of_GetValue ( "de_duration", TypeTime! )
end function

public function integer of_getsite (ref n_cst_beo_company anv_company, readonly boolean ab_checkcache);//Return : 1 = Success (Valid Site Passed Out), 0 = No Site (Null SiteId), -1 = Error

//We're not calling the overloaded version in order to avoid the performance
//hit of passing the AutoInstantiated variable again.

Long		ll_SiteId
Integer	li_Return = -1

ll_SiteId = This.of_GetSite ( )

//IF IsNull ( ll_SiteId ) THEN
//
//	li_Return = 0
//
//ELSE

	DESTROY anv_company

	anv_company = CREATE n_cst_beo_Company
	
	IF ab_CheckCache THEN
		gnv_cst_Companies.of_Cache ( ll_SiteId, FALSE )
	END IF

	anv_Company.of_SetUseCache ( TRUE )
	
	IF anv_Company.of_SetSourceId ( ll_SiteId ) = 1 THEN
		IF anv_Company.of_HasSource ( ) THEN
			li_Return = 1
		ELSE 
			li_Return = 0
		END IF
	END IF

//END IF

RETURN li_Return
end function

public function string of_getappointmentnumber ();RETURN This.of_GetValue ( "de_apptnum", TypeString! )
end function

public function long of_getassignmentbyindex (integer ai_index);//This is a port of w_Dispatch.getid()
//ai_Index is just a rename of id_type
//The appropriate source, sourcerow, and sourcebuffer for the beo are used in place of those parameters.
//The function does not support original_value at present.

Long	ll_Id = -1

IF This.of_HasSource ( ) THEN

	choose case ai_Index

	case 1
		ll_Id = This.of_GetDriverId ( )

	case 2
		ll_Id = This.of_GetTractorId ( )

	case 3
		ll_Id = This.of_GetTrailer1Id ( )

	case 4
		ll_Id = This.of_GetTrailer2Id ( )

	case 5
		ll_Id = This.of_GetTrailer3Id ( )

	case 6
		ll_Id = This.of_GetContainer1Id ( )

	case 7
		ll_Id = This.of_GetContainer2Id ( )

	case 8
		ll_Id = This.of_GetContainer3Id ( )

	case 9
		ll_Id = This.of_GetContainer4Id ( )

	case 10
		ll_Id = This.of_GetActEqId ( )

	case gc_Dispatch.ci_Assignment_Trip
		ll_Id = This.of_GetTrip ( )

	end choose

end if

RETURN ll_Id
end function

public function long of_getdriverid ();RETURN This.of_GetValue ( "de_driver", TypeLong! )
end function

public function long of_gettractorid ();RETURN This.of_GetValue ( "de_tractor", TypeLong! )
end function

public function long of_gettrailer1id ();RETURN This.of_GetValue ( "de_trailer1", TypeLong! )
end function

public function long of_gettrailer2id ();RETURN This.of_GetValue ( "de_trailer2", TypeLong! )
end function

public function long of_gettrailer3id ();RETURN This.of_GetValue ( "de_trailer3", TypeLong! )
end function

public function long of_getcontainer1id ();RETURN This.of_GetValue ( "de_container1", TypeLong! )
end function

public function long of_getcontainer2id ();RETURN This.of_GetValue ( "de_container2", TypeLong! )
end function

public function long of_getcontainer3id ();RETURN This.of_GetValue ( "de_container3", TypeLong! )
end function

public function long of_getcontainer4id ();RETURN This.of_GetValue ( "de_container4", TypeLong! )
end function

public function long of_getacteqid ();RETURN This.of_GetValue ( "de_acteq", TypeLong! )
end function

public function long of_getactpos ();RETURN This.of_GetValue ( "de_actpos", TypeLong! )
end function

public function string of_getmultilist ();RETURN This.of_GetValue ( "de_multi_list", TypeString! )
end function

public function boolean of_keepwithdroppedtrailer (long al_trailerid);//Determines whether the event should stay with the trailer being dropped (TRUE), 
//or stay with the tractor (FALSE).

//The processing will leave the event with the tractor, unless a reason is found not to.
//Note that at present all passive events will stay with the tractor.

//This code was extracted from w_itin_add.route_r()

integer markloop, checkloop, pos1
string ml_check
String	ls_Type
long acteq, actpos

Boolean	lb_Result = FALSE

ls_Type = This.of_GetType ( )
acteq = This.of_GetActEqId ( )
actpos = This.of_GetActPos ( )
ml_check = This.of_GetMultiList ( )

CHOOSE CASE ls_Type

CASE gc_Dispatch.cs_EventType_Mount, gc_Dispatch.cs_EventType_Dismount
	pos1 = pos(ml_check, "5")
	pos1 = int((pos1 + 1) / 2)
	IF This.of_GetAssignmentByIndex ( pos1 + 2 ) = al_TrailerId THEN
		lb_Result = TRUE
	END IF

CASE gc_Dispatch.cs_EventType_Pickup, gc_Dispatch.cs_EventType_Deliver
	//See if the event is assigned to the dropped trailer.
	if actpos = al_TrailerId then
		lb_Result = true

	//If not, see if the event is assigned to a container on the dropped trailer. 
	elseif len(ml_check) > 0 then
		for checkloop = 1 to 4

			IF This.of_GetAssignmentByIndex ( checkloop + 5 ) = actpos THEN

				pos1 = pos(ml_check, string(checkloop))
				pos1 = int((pos1 + 1) / 2)

				IF This.of_GetAssignmentByIndex ( pos1 + 2 ) = al_TrailerId THEN
					lb_Result = TRUE
				END IF

				exit

			end if
		next
	end if

CASE gc_Dispatch.cs_EventType_Reposition, gc_Dispatch.cs_EventType_Scale
	//These events are generally related to the trailer, so keep them with the trailer.
	lb_Result = TRUE

END CHOOSE

RETURN lb_Result
end function

public function boolean of_ispassive ();//Determines whether the event has a passive event type (like bobtail).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypePassive ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function integer of_whatsleft (integer ai_RelativeToType, long al_RelativeToId, ref s_longs astr_Ids, ref string as_MultiList);//Returns:  1 = Success, -1 = Error.  Note that there is no validation of the parameters.
//The function will only fail if the source is not supported (primary row in a datastore, not a dw.)

PowerObject	lpo_Source
Long	ll_Row
dwBuffer	le_Buffer
DataStore	lds_Source
DataWindow	ldw_Source
n_cst_Dws	lnv_Dws
n_cst_Events	lnv_Events

Integer	li_Return = 1

//Check that the source type is ok.

IF li_Return = 1 THEN

	lpo_Source = This.of_GetSource ( )
	
	CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( lpo_Source, ldw_Source, lds_Source )
	
	CASE DataStore!
		//Type is ok.
	
	CASE ELSE  //DataWindow!, or nothing
		//Can't process -- processing service only handles datastores.
		li_Return = -1
		
	END CHOOSE

END IF

//Check that the source row is in the primary buffer.

IF li_Return = 1 THEN

	IF This.of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't Create*/ ) = 1 THEN

		IF le_Buffer = Primary! AND ll_Row > 0 THEN
			//Source is ok.
		ELSE
			//Can't process -- processing service requires primary buffer row.
			li_Return = -1
		END IF

	ELSE
		li_Return = -1
	END IF

END IF


//Do the processing.

IF li_Return = 1 THEN

	lnv_Events.of_WhatsLeft ( lds_Source, ll_Row, ai_RelativeToType, al_RelativeToId, astr_Ids, as_MultiList )

END IF
	

RETURN li_Return
end function

public function boolean of_isassignment ();//Determines whether the event has an assignment event type (like New Trip, End Trip, Hook, Drop, Mount, Dismount).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypeAssignment ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function boolean of_islocationoptional ();//Determines whether the event has a type for which location is optional for confirmation (like CheckCall).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypeLocationOptional ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function boolean of_ispickupgroup ();//Determines whether the event has a pickup group type (Pickup, Hook, Mount).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypePickupGroup ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function boolean of_isdelivergroup ();//Determines whether the event has a deliver group type (Deliver, Drop, Dismount).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypeDeliverGroup ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function integer of_setdatearrived (readonly date ad_value);Date		ld_CurrentValue
Boolean	lb_IsThirdParty

Integer	li_Return = 1

IF li_Return = 1 THEN

	IF This.of_IsConfirmed ( ) THEN
		This.of_AddError ( "The event has been confirmed as completed." )
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ld_CurrentValue = This.of_GetDateArrived ( )
	
	IF IsNull ( ld_CurrentValue ) THEN

		IF This.of_IsNonRouted ( ) THEN
			//Allow it
		ELSE
			This.of_AddError ( "The event must be routed in order to set the arrival date." )
			li_Return = -1
		END IF

	ELSE

		IF This.of_IsThirdParty ( ) THEN
			//Allow it.
		ELSEIF This.of_IsNonRouted ( ) THEN
			//Allow it.
		ELSE
			This.of_AddError ( "The event must be rerouted in order to change the arrival date." )
			li_Return = -1
		END IF

	END IF


END IF


IF li_Return = 1 THEN

	//We should set times to null, if date is being set to null.  See u_dw_EventDetail.ue_PostDateTimeEdit

	//Supply error message explanation??  Or let ancestor do it?
	li_Return = This.of_SetAny ( "de_arrdate", ad_Value )

	if li_return = 1 then

		n_cst_licensemanager	lnv_licensemanager

		IF lnv_LicenseManager.of_HasEDI214License() THEN

			//try to add for EDI status
			n_cst_bso lnv_dispatch
			
			lnv_Dispatch = this.of_GetContext()
			if isvalid(lnv_Dispatch) then
				IF lnv_Dispatch.Classname ( ) = "n_cst_bso_dispatch" THEN
					lnv_dispatch.dynamic of_AddEDI214Event(this.of_GetId())
				END IF
			END IF	

		END IF
	
	end if
	
END IF


RETURN li_Return 
end function

public function integer of_settimearrived (readonly time at_value);Date		ld_DateArrived

Integer	li_Return = 1

IF li_Return = 1 THEN

	IF This.of_IsConfirmed ( ) THEN
		This.of_AddError ( "The event has been confirmed as completed." )
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ld_DateArrived = This.of_GetDateArrived ( )
	
	IF IsNull ( ld_DateArrived ) THEN

		This.of_AddError ( "The arrival date has not been specified." )
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	//Supply error message explanation??  Or let ancestor do it?
	li_Return = This.of_SetAny ( "de_arrtime", at_Value )

	if li_return = 1 then
		
		n_cst_licensemanager	lnv_licensemanager

		IF lnv_LicenseManager.of_HasEDI214License() THEN

			//try to add for EDI status
			n_cst_bso lnv_dispatch
			
			lnv_Dispatch = this.of_GetContext()
			if isvalid(lnv_Dispatch) then
				IF lnv_Dispatch.Classname ( ) = "n_cst_bso_dispatch" THEN
					lnv_dispatch.dynamic of_AddEDI214Event(this.of_GetId())
				END IF
			END IF	
		
		END IF
	
	end if
	
END IF


RETURN li_Return
end function

public function integer of_settimedeparted (readonly time at_value);//Note : If the time arrived has not been set (is null), this will set it to be the same as
//the departure time, if all other tests are passed.

Date		ld_DateArrived

Integer	li_Return = 1

IF li_Return = 1 THEN

	IF This.of_IsConfirmed ( ) THEN
		This.of_AddError ( "The event has been confirmed as completed." )
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ld_DateArrived = This.of_GetDateArrived ( )
	
	IF IsNull ( ld_DateArrived ) THEN

		This.of_AddError ( "The arrival date has not been specified." )
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	//If the Arrival Time has not been set yet, make it the same as the departure time.

	IF IsNull ( This.of_GetTimeArrived ( ) ) THEN
		This.of_SetAny ( "de_arrtime", at_Value )
		//Or, should we use This.of_SetTimeArrived??
	END IF

	//Set the departure time.

	//Supply error message explanation??  Or let ancestor do it?
	li_Return = This.of_SetAny ( "de_deptime", at_Value )

	if li_return = 1 then
		
		n_cst_licensemanager	lnv_licensemanager

		IF lnv_LicenseManager.of_HasEDI214License() THEN

			//try to add for EDI status
			n_cst_bso lnv_dispatch
			
			lnv_Dispatch = this.of_GetContext()
			if isvalid(lnv_Dispatch) then
				IF lnv_Dispatch.Classname ( ) = "n_cst_bso_dispatch" THEN
					lnv_dispatch.dynamic of_AddEDI214Event(this.of_GetId())
				END IF
			END IF	
		
		END IF
	
	end if
	
END IF


RETURN li_Return
end function

public function boolean of_isnonrouted ();//Returns : TRUE, FALSE, Null if cannot be determined (Failure in ShipmentManager routine)
//NOTE : This function may call a SQL transaction in lnv_ShipmentManager.of_IsNonRouted

n_cst_ShipmentManager	lnv_ShipmentManager

Boolean	lb_Result = FALSE

IF This.of_HasShipment ( ) THEN
	
	IF isValid ( inv_Shipment ) THEN
		IF inv_Shipment.of_HasSource ( ) THEN
			IF inv_Shipment.of_IsNonRouted ( ) THEN
				lb_Result = TRUE
			END IF
		ELSE
			lb_Result = lnv_ShipmentManager.of_IsNonRouted ( This.of_GetShipment ( ) )
			//NOTE : This may call a SQL transaction
		END IF
	END IF

ELSE

	//If it's not in a shipment, it can't be not non-routed.

END IF

RETURN lb_Result
end function

public function integer of_setnote (readonly string as_value);RETURN This.of_SetAny ( "de_note", as_Value )
end function

public function integer of_appendnote (readonly string as_value);//Same returns as of_SetNote.  Returns -1 if as_Value is null.

String	ls_Note

Integer	li_Return = 1

IF IsNull ( as_Value ) THEN

	li_Return = -1

ELSE

	ls_Note = This.of_GetNote ( )
	
	IF IsNull ( ls_Note ) THEN
		ls_Note = ""
	ELSEIF NOT Right ( ls_Note, 2 ) = "~r~n" THEN
		ls_Note += "~r~n"
	END IF
	
	ls_Note += as_Value

	li_Return = This.of_SetNote ( ls_Note )

END IF

RETURN li_Return
end function

public function string of_getcontainerlist ();//Returns : A list of all container numbers associated with the event, or empty string if there are 
//none.  A container being mounted or dismounted will be listed first.

String	ls_Result, &
			ls_Description
Boolean	lb_IncludeActive  //Flag whether acteq is a container and should be included in the list.
Integer	lia_IndexList[], &
			li_IndexCount, &
			li_Loop

IF This.of_IsMount ( ) THEN
	lb_IncludeActive = TRUE
ELSEIF This.of_IsDismount ( ) THEN
	lb_IncludeActive = TRUE
END IF

IF lb_IncludeActive THEN
	lia_IndexList = { 10, 6, 7, 8, 9 }
ELSE
	lia_IndexList = { 6, 7, 8, 9 }
END IF

li_IndexCount = UpperBound ( lia_IndexList )

FOR li_Loop = 1 TO li_IndexCount

	ls_Description = This.of_GetDescriptionByIndex ( lia_IndexList [ li_Loop ], "SHORT_REF!" )
	//Note : We could, instead, use REF_ONLY!, since there are only containers in the list.
	//But I felt this might be better for consistency with GetTrailerList and GetPowerUnit.

	IF Len ( ls_Description ) > 0 THEN

		IF Len ( ls_Result ) > 0 THEN
			ls_Result += ", "
		END IF

		ls_Result += ls_Description

	END IF

NEXT

RETURN ls_Result
end function

public function boolean of_ismount ();//Returns:  TRUE, FALSE, Null if can't be determined

RETURN This.of_IsType ( gc_Dispatch.cs_EventType_Mount )
end function

public function boolean of_isdismount ();//Returns:  TRUE, FALSE, Null if can't be determined

RETURN This.of_IsType ( gc_Dispatch.cs_EventType_Dismount )
end function

public function string of_getdescriptionbyindex (integer ai_index, string as_describetype);Long		ll_Id
String	ls_Result
n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_EmployeeManager	lnv_EmployeeManager

ll_Id = This.of_GetAssignmentByIndex ( ai_Index )

CHOOSE CASE ai_Index

CASE 1 //Driver
	IF lnv_EmployeeManager.of_DescribeEmployee ( ll_Id, ls_Result, Integer ( as_DescribeType ) ) = 1 THEN
		//Success
	ELSE
		SetNull ( ls_Result )
	END IF

CASE 2 TO 10
	IF lnv_EquipmentManager.of_Get_Description ( ll_Id, as_DescribeType, ls_Result ) = 1 THEN
		//Success
	ELSE
		SetNull ( ls_Result )
	END IF

CASE gc_Dispatch.ci_Assignment_Trip //Trip
	//Needs to be implemented -- Not yet supported.
	SetNull ( ls_Result )

CASE ELSE
	SetNull ( ls_Result )

END CHOOSE

RETURN ls_Result
end function

public function string of_gettrailerlist ();//Returns : A list of all trailer/chassis numbers associated with the event, or empty string if 
//there are none.  A trailer/chassis being hooked or dropped will be listed first.

String	ls_Result, &
			ls_Description
Boolean	lb_IncludeActive  //Flag whether acteq is a trailer/chassis and should be included in the list.
Integer	lia_IndexList[], &
			li_IndexCount, &
			li_Loop

IF This.of_IsHook ( ) THEN
	lb_IncludeActive = TRUE
ELSEIF This.of_IsDrop ( ) THEN
	lb_IncludeActive = TRUE
END IF

IF lb_IncludeActive THEN
	lia_IndexList = { 10, 3, 4, 5 }
ELSE
	lia_IndexList = { 3, 4, 5 }
END IF

li_IndexCount = UpperBound ( lia_IndexList )

FOR li_Loop = 1 TO li_IndexCount

	ls_Description = This.of_GetDescriptionByIndex ( lia_IndexList [ li_Loop ], "SHORT_REF!" )

	IF Len ( ls_Description ) > 0 THEN

		IF Len ( ls_Result ) > 0 THEN
			ls_Result += ", "
		END IF

		ls_Result += ls_Description

	END IF

NEXT

RETURN ls_Result
end function

public function string of_getpowerunit ();//Returns : A SHORT_REF! description (includes type lablel) of the power unit assigned to the event, 
//if any.  Returns empty string if no power unit is assigned.

String	ls_Result, &
			ls_Description
Integer	lia_IndexList[], &
			li_IndexCount, &
			li_Loop

//I'm retaining the IndexList methodology from the trailer and chassis scripts, even though at present
//(and foreseeably) there can only be one power unit.

lia_IndexList = { 2 }

li_IndexCount = UpperBound ( lia_IndexList )

FOR li_Loop = 1 TO li_IndexCount

	ls_Description = This.of_GetDescriptionByIndex ( lia_IndexList [ li_Loop ], "SHORT_REF!" )

	IF Len ( ls_Description ) > 0 THEN

		IF Len ( ls_Result ) > 0 THEN
			ls_Result += ", "
		END IF

		ls_Result += ls_Description

	END IF

NEXT

RETURN ls_Result
end function

public function string of_getdriver ();//Returns : A FirstLast description of the driver assigned to the event, if any.  
//Returns empty string if no driver is assigned.

String	ls_Result, &
			ls_Description

ls_Description = This.of_GetDescriptionByIndex ( 1 /*Driver Index*/, &
	String ( appeon_constant.ci_DescribeType_FirstLast ) )

IF Len ( ls_Description ) > 0 THEN

	ls_Result = ls_Description

END IF

RETURN ls_Result
end function

public function integer of_settype (readonly string as_value);// RDT 5-13-03 added checks for pickup and deliver group

// RDT 5-13-03 Start 
Boolean 	lb_OldPickup, &
			lb_OldDeliver,&
			lb_Process

Integer	li_Return 

lb_Oldpickup = This.of_ispickupgroup ( )
lb_OldDeliver = This.of_isdelivergroup ( )
// RDT 5-13-03 End

li_Return = This.of_SetAny ( "de_event_type", as_Value )

If li_Return = 1 then 
	This.of_AddCompaniesToEvent() //RDT 8-27-03
//	// RDT 5-13-03 Start 
//	If lb_Oldpickup Then 
//		if This.of_ispickupgroup ( ) then 
//			lb_Process = FALSE 
//		else
//			lb_Process = TRUE 
//		end if
//	End If
//	
//	If lb_OldDeliver Then 
//		if This.of_isdelivergroup ( ) then 
//			lb_Process = FALSE 
//		Else
//			lb_Process = TRUE 		
//		end if
//	End If
//	
//	If lb_Process Then 
//		This.of_AddEventToCompanies()
//	End If
//	
//	// RDT 5-13-03 End	
//
End If

Return li_Return 
end function

public function integer of_assignbyindex (integer ai_index, long al_id, boolean ab_sequence, decimal ac_sequence);//Returns:  1, -1

String	ls_AssignmentColumn, &
			ls_SequenceColumn

Integer	li_Return = 1

choose case ai_Index
case 1
	ls_AssignmentColumn = "de_driver"
	ls_SequenceColumn = "de_driver_seq"
case 2
	ls_AssignmentColumn = "de_tractor"
	ls_SequenceColumn = "de_tractor_seq"
case 3
	ls_AssignmentColumn = "de_trailer1"
	ls_SequenceColumn = "de_trailer1_seq"
case 4
	ls_AssignmentColumn = "de_trailer2"
	ls_SequenceColumn = "de_trailer2_seq"
case 5
	ls_AssignmentColumn = "de_trailer3"
	ls_SequenceColumn = "de_trailer3_seq"
case 6
	ls_AssignmentColumn = "de_container1"
	ls_SequenceColumn = "de_container1_seq"
case 7
	ls_AssignmentColumn = "de_container2"
	ls_SequenceColumn = "de_container2_seq"
case 8
	ls_AssignmentColumn = "de_container3"
	ls_SequenceColumn = "de_container3_seq"
case 9
	ls_AssignmentColumn = "de_container4"
	ls_SequenceColumn = "de_container4_seq"
case 10
	ls_AssignmentColumn = "de_acteq"
	ls_SequenceColumn = "de_acteq_seq"

CASE gc_Dispatch.ci_Assignment_Trip
	ls_AssignmentColumn = "de_Trailer"
	ls_SequenceColumn = "de_Trailer_Seq"

CASE ELSE  //Unexpected Type
	li_Return = -1

END CHOOSE


IF li_Return = 1 THEN

	IF This.of_SetAny ( ls_AssignmentColumn, al_Id ) = 1 THEN
		//OK
	ELSE
		//There are actually several error codes from SetAny that we could handle.
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF ab_Sequence THEN
		IF This.of_SetAny ( ls_SequenceColumn, ac_Sequence ) = 1 THEN
			//OK
		ELSE
			//There are actually several error codes from SetAny that we could handle.
			li_Return = -1
		END IF
	END IF

END IF

RETURN li_Return
end function

public function integer of_clearrouting (boolean ab_cleartimesandconf);Integer		li_Index, &
				li_Min, &
				li_Max
n_cst_Events	lnv_Events

Integer		li_Return = 1

Long		ll_Null
String	ls_Null
Date		ld_Null
Time		lt_Null

SetNull ( ll_Null )
SetNull ( ls_Null )
SetNull ( ld_Null )
SetNull ( lt_Null )

lnv_Events.of_GetMinMaxIndex ( li_Min, li_Max )

FOR li_Index = li_Min TO li_Max
	This.of_AssignByIndex ( li_Index, ll_Null, TRUE, 0 )
NEXT

li_Index = gc_Dispatch.ci_Assignment_Trip
This.of_AssignByIndex ( li_Index, ll_Null, TRUE, 0 )


This.of_SetActpos ( 0 )
This.of_SetMultiList ( ls_Null )


IF ab_ClearTimesAndConf THEN

	IF This.of_IsConfirmed ( ) THEN

		IF This.of_HasShipment ( ) = FALSE THEN
			This.of_Unconfirm ( )
		ELSE
			li_Return = -1
		END IF

	END IF

	//???THIS GOES AHEAD AND CLEARS THE DATE & TIMES ANYWAY, EVEN IF li_Return = -1 ???

	This.of_SetAny ( "de_arrdate", ld_Null )
	This.of_SetAny ( "de_arrtime", lt_Null )
	This.of_SetAny ( "de_deptime", lt_Null )

END IF

RETURN li_Return
end function

public function integer of_setmultilist (readonly string as_value);RETURN This.of_SetAny ( "de_multi_list", as_Value )
end function

public function integer of_setactpos (readonly long al_value);RETURN This.of_SetAny ( "de_actpos", al_Value )
end function

public function integer of_getlocaltimezone ();/*
	Get the timezone of the company for this event.
*/
integer	li_TimeZone

n_cst_beo_company		lnv_Company

IF this.of_getsite(lnv_company, TRUE) = 1 THEN
	li_TimeZone = lnv_Company.of_GetTimeZone()
	
ELSE
	li_TimeZone = -1
	
END IF

DESTROY lnv_Company

return li_TimeZone
end function

public function integer of_getbasetimezone ();long ll_BaseTimeZone

//get timezone from system_settings
select ss_long into :ll_BaseTimeZone from system_settings where ss_id = 2 ;

choose case sqlca.sqlcode
case 100
	commit ;
case 0
	commit ;
case else
	rollback ;
end choose

return Integer ( ll_BaseTimeZone ) 

end function

public function time of_getlocaltime (date adt_basedate, time adt_basetime);/*
	Get the difference between base time zone and the timezone of the event site.
	Multiply be seconds and get the relative time.
*/

integer	li_LocalTimeZone, &
			li_BaseTimeZone
			
long		ll_AdjustedOffset			
			
time	ldt_LocalTime

datetime	ldt_BaseDateTime

n_cst_datetime			lnv_DateTime

li_BaseTimeZone =  this.of_GetBaseTimeZone ( )
li_LocalTimeZone = this.of_GetLocalTimeZone ( )
ll_AdjustedOffset = (li_BaseTimeZone - li_LocalTimeZone) * -1
ldt_BaseDateTime = datetime ( adt_BaseDate, adt_BaseTime ) 	
ldt_LocalTime = time ( lnv_DateTime.of_RelativeDateTime(ldt_BaseDateTime, (ll_AdjustedOffset * 3600) ) )

return ldt_LocalTime
end function

public function date of_getlocaldate (date ad_basedate, time ad_basetime);/*
	Get the difference between base time zone and the timezone of the event site.
	Multiply be seconds and get the relative date.
*/

integer	li_LocalTimeZone, &
			li_BaseTimeZone
			
long		ll_AdjustedOffset			
			
date	ldt_LocalDate

datetime	ldt_BaseDateTime

n_cst_datetime			lnv_DateTime

li_BaseTimeZone =  this.of_GetBaseTimeZone ( )
li_LocalTimeZone = this.of_GetLocalTimeZone ( )
ll_AdjustedOffset = (li_BaseTimeZone - li_LocalTimeZone) * -1
if isnull ( ad_BaseTime ) THEN
	ad_BaseTime = TIME("12")	
END IF
ldt_BaseDateTime = datetime ( ad_BaseDate, ad_BaseTime ) 	
ldt_LocalDate = date ( lnv_DateTime.of_RelativeDateTime(ldt_BaseDateTime, (ll_AdjustedOffset * 3600) ) )
					
return ldt_LocalDate
end function

public function integer of_getcontainerlist (ref long ala_ids[], readonly boolean ab_Append);//Returns : A list of all container numbers added from the event
// ab_Append determines if the caller wats to append the ids to array passed in.
// A container being mounted or dismounted will be listed first.

Boolean	lb_IncludeActive  //Flag whether acteq is a container and should be included in the list.
Integer	lia_IndexList[], &
			li_IndexCount, &
			li_Loop, &
			li_Count, &
			li_NumAdded
Long		ll_Id, &
			lla_Empty[]
			
IF ab_Append THEN
	li_Count = UpperBound ( ala_ids[] ) 
ELSE
	li_Count = 0
	ala_Ids = lla_Empty
END IF

IF This.of_IsMount ( ) THEN
	lb_IncludeActive = TRUE
ELSEIF This.of_IsDismount ( ) THEN
	lb_IncludeActive = TRUE
END IF

IF lb_IncludeActive THEN
	lia_IndexList = { 10, 6, 7, 8, 9 }
ELSE
	lia_IndexList = { 6, 7, 8, 9 }
END IF

li_IndexCount = UpperBound ( lia_IndexList )

FOR li_Loop = 1 TO li_IndexCount

	ll_Id = This.of_GetAssignmentByIndex ( lia_IndexList [ li_Loop ] )

	IF NOT IsNull ( ll_Id ) THEN

		li_Count ++
		li_NumAdded ++
		ala_Ids [ li_Count ] = ll_Id

	END IF

NEXT

RETURN li_NumAdded
end function

public function integer of_gettrailerlist (ref long ala_ids[], readonly boolean ab_Append);//Returns : A list of all the trailer numbers added from the event.
//A container being mounted or dismounted will be listed first.
// Ab_Append Determins if the caller wants to append ids to the array passed in.

Boolean	lb_IncludeActive  //Flag whether acteq is a container and should be included in the list.
Integer	lia_IndexList[], &
			li_IndexCount, &
			li_Loop, &
			li_Count,&
			li_NumAdded
Long		ll_Id, &
			lla_Empty[]
			
			
IF ab_Append THEN
	li_Count = UpperBound ( ala_ids[] ) 
ELSE
	li_Count = 0
	ala_Ids = lla_Empty
END IF			

IF This.of_IsHook ( ) THEN
	lb_IncludeActive = TRUE
ELSEIF This.of_IsDrop ( ) THEN
	lb_IncludeActive = TRUE
END IF

IF lb_IncludeActive THEN
	lia_IndexList = { 10, 3, 4, 5 }
ELSE
	lia_IndexList = { 3, 4, 5 }
END IF

li_IndexCount = UpperBound ( lia_IndexList )

FOR li_Loop = 1 TO li_IndexCount

	ll_Id = This.of_GetAssignmentByIndex ( lia_IndexList [ li_Loop ] )

	IF NOT IsNull ( ll_Id ) THEN

		li_Count ++
		li_NumAdded ++
		ala_Ids [ li_Count ] = ll_Id

	END IF

NEXT


RETURN li_NumAdded
end function

public function integer of_getactiveassignments (ref long ala_drivers[], ref long ala_powerunits[], ref long ala_trailerchassis[], ref long ala_containers[]);//Passes out the ids of any drivers / equipment being assigned in an assignment event,
//ie. Drivers and PowerUnits on a New Trip / End Trip, PowerUnits, TrailerChassis, and 
//Containers on a Hook / Drop / Mount / Dismount.

//Returns : 1, 0, -1
//1 = Event is a fully activated assingment event (ie, both sides of the assignment
//have been specified.)  0 = Event is not a fully activated assignment (ie. at least one
//side of the assignment is not specified.) -1 = Error, cannot determine (Will return -1 
//if event type is null, which would only happen at present if source is invalid.)

Integer	li_Min, &
			li_Max, &
			li_Loop, &
			li_Count, &
			li_Index
Long		lla_Empty[], &
			ll_Id
String	ls_EventType, &
			ls_MultiList
n_cst_Events	lnv_Events

Integer	li_Return = 0

ala_Drivers = lla_Empty
ala_PowerUnits = lla_Empty
ala_TrailerChassis = lla_Empty
ala_Containers = lla_Empty

IF li_Return >= 0 THEN

	ls_EventType = This.of_GetType ( )
	
	IF IsNull ( ls_EventType ) THEN

		li_Return = -1
	
	END IF

END IF


IF li_Return >= 0 THEN

	CHOOSE CASE ls_EventType
	
	CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_EndTrip
	
		//Read out any driver assignments
	
		li_Count = 0
	
		FOR li_Index = gc_Dispatch.ci_MinIndex_Driver TO gc_Dispatch.ci_MaxIndex_Driver
	
			ll_Id = This.of_GetAssignmentByIndex ( li_Index )
	
			IF NOT IsNull ( ll_Id ) THEN
	
				li_Count ++
				ala_Drivers [ li_Count ] = ll_Id
	
			END IF
	
		NEXT
	
	
		//Read out any powerunit assignments
	
		li_Count = 0
	
		FOR li_Index = gc_Dispatch.ci_MinIndex_PowerUnit TO gc_Dispatch.ci_MaxIndex_PowerUnit
	
			ll_Id = This.of_GetAssignmentByIndex ( li_Index )
	
			IF NOT IsNull ( ll_Id ) THEN
	
				li_Count ++
				ala_PowerUnits [ li_Count ] = ll_Id
	
			END IF
	
		NEXT

		//Now, check if we've got a fully activated assignment event.

		IF UpperBound ( ala_Drivers ) > 0 AND UpperBound ( ala_PowerUnits ) > 0 THEN

			//Since we've got both driver(s) and PowerUnit(s), we've got a fully activated
			//assignment.

			li_Return = 1

		END IF

	
	CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Drop, &
		gc_Dispatch.cs_EventType_Mount, gc_Dispatch.cs_EventType_Dismount
	
		IF li_Return >= 0 THEN

			ls_MultiList = This.of_GetMultiList ( )
		
			IF lnv_Events.of_ParseMultiList ( ls_MultiList, ala_TrailerChassis, ala_Containers ) = 1 THEN
		
				//OK
		
			ELSE
		
				li_Return = -1
		
			END IF

		END IF

		IF li_Return >= 0 THEN

			//Read out any powerunit assignments
	
			li_Count = 0
		
			FOR li_Index = gc_Dispatch.ci_MinIndex_PowerUnit TO gc_Dispatch.ci_MaxIndex_PowerUnit
		
				ll_Id = This.of_GetAssignmentByIndex ( li_Index )
		
				IF NOT IsNull ( ll_Id ) THEN
		
					li_Count ++
					ala_PowerUnits [ li_Count ] = ll_Id
		
				END IF
		
			NEXT

		END IF


		//Now, check if we've got a fully activated assignment event.

		IF li_Return >= 0 THEN

			IF ( UpperBound ( ala_Drivers ) > 0 OR UpperBound ( ala_PowerUnits ) > 0 ) AND &
				( UpperBound ( ala_TrailerChassis ) > 0 OR UpperBound ( ala_Containers ) > 0 ) THEN

				//We've got drivers and / or powerunits, as well as trailers and/or containers.
				//So, we've got a fully activated assignment.

				li_Return = 1

			END IF

		END IF
	
	END CHOOSE

END IF


RETURN li_Return
end function

public function integer of_getactiveassignments (ref long ala_drivers[], ref long ala_equipment[]);//Forward the request to the version that implements the operation, but then consolidate the 
//PowerUnit, TrailerChassis, and Container arrays into one Equipment array.

//Returns : 1, 0, -1  (The same as the other version).  (Not a blind pass-through, however.)

n_cst_AnyArraySrv	lnv_Arrays
Long		lla_Drivers[], &
			lla_PowerUnits[], &
			lla_Trailers[], &
			lla_Containers[]
Integer	li_Result

Integer	li_Return = 0

li_Result = This.of_GetActiveAssignments ( lla_Drivers, lla_PowerUnits, lla_Trailers, lla_Containers )

CHOOSE CASE li_Result

CASE 1, 0

	//Take the PowerUnits array, and then append the trailer and container arrays onto it.
	ala_Equipment = lla_PowerUnits
	lnv_Arrays.of_AppendLong ( ala_Equipment, lla_Trailers )
	lnv_Arrays.of_AppendLong ( ala_Equipment, lla_Containers )

	//Pass out the driver list as-is.
	ala_Drivers = lla_Drivers

	li_Return = li_Result

CASE ELSE

	li_Return = -1

END CHOOSE


RETURN li_Return
end function

public function integer of_getassignments (ref long ala_drivers[], ref long ala_powerunits[], ref long ala_trailerchassis[], ref long ala_containers[]);//Passes out the ids of any drivers / equipment routed to the event.

//Returns : 1, -1

Integer	li_Min, &
			li_Max, &
			li_Loop, &
			li_Count, &
			li_Index, &
			li_TypeList[]
Long		lla_Empty[], &
			lla_List[], &
			ll_Id
n_cst_Events	lnv_Events

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF This.of_HasSource ( ) = FALSE THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ala_Drivers = lla_Empty
	ala_PowerUnits = lla_Empty
	ala_TrailerChassis = lla_Empty
	ala_Containers = lla_Empty
	
	li_TypeList = { gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit, &
		gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container }
	
	
	FOR li_Loop = 1 TO 4
	
		lnv_Events.of_GetMinMaxIndex ( li_TypeList [ li_Loop ], li_Min, li_Max )
	
		lla_List = lla_Empty
		li_Count = 0
	
		FOR li_Index = li_Min TO li_Max
	
			ll_Id = This.of_GetAssignmentByIndex ( li_Index )
	
			IF NOT IsNull ( ll_Id ) THEN
				li_Count ++
				lla_List [ li_Count ] = ll_Id
			END IF
	
		NEXT
	
		CHOOSE CASE li_TypeList [ li_Loop ]
	
		CASE gc_Dispatch.ci_ItinType_Driver
			ala_Drivers = lla_List
	
		CASE gc_Dispatch.ci_ItinType_PowerUnit
			ala_PowerUnits = lla_List
	
		CASE gc_Dispatch.ci_ItinType_TrailerChassis
			ala_TrailerChassis = lla_List
	
		CASE gc_Dispatch.ci_ItinType_Container
			ala_Containers = lla_List
	
		END CHOOSE
	
	NEXT

END IF

RETURN li_Return
end function

public function integer of_getassignments (ref long ala_drivers[], ref long ala_equipment[]);//Forward the request to the version that implements the operation, but then consolidate the 
//PowerUnit, TrailerChassis, and Container arrays into one Equipment array.

//Returns : 1, -1  (The same as the other version).  (Not a blind pass-through, however.)

n_cst_AnyArraySrv	lnv_Arrays
Long		lla_Drivers[], &
			lla_PowerUnits[], &
			lla_Trailers[], &
			lla_Containers[]
Integer	li_Result

Integer	li_Return = 0

li_Result = This.of_GetAssignments ( lla_Drivers, lla_PowerUnits, lla_Trailers, lla_Containers )

CHOOSE CASE li_Result

CASE 1

	//Take the PowerUnits array, and then append the trailer and container arrays onto it.
	ala_Equipment = lla_PowerUnits
	lnv_Arrays.of_AppendLong ( ala_Equipment, lla_Trailers )
	lnv_Arrays.of_AppendLong ( ala_Equipment, lla_Containers )

	//Pass out the driver list as-is.
	ala_Drivers = lla_Drivers

	li_Return = li_Result

CASE ELSE

	li_Return = -1

END CHOOSE


RETURN li_Return
end function

public function boolean of_isactiveinassignment (integer ai_type, long al_id);//Returns : TRUE, FALSE, Null if cannot be determined.
//FALSE will be returned if the event is not an assignment event.
//FALSE will be returned if a null value is provided for al_Id.

//If a null ai_Type is provided, al_Id will be treated as equipment.

Long	lla_Drivers[], &
		lla_Equipment[], &
		ll_Null
n_cst_AnyArraySrv	lnv_Arrays


Boolean	lb_Return = FALSE

SetNull ( ll_Null )


IF lb_Return = FALSE THEN

	CHOOSE CASE This.of_GetActiveAssignments ( lla_Drivers, lla_Equipment )

	CASE 1, 0
		//OK

	CASE ELSE
		SetNull ( lb_Return )

	END CHOOSE

END IF


IF lb_Return = FALSE THEN

	CHOOSE CASE ai_Type

	CASE gc_Dispatch.ci_ItinType_Driver

		IF lnv_Arrays.of_FindLong ( lla_Drivers, al_Id, ll_Null, ll_Null ) > 0 THEN
			lb_Return = TRUE
		END IF

	CASE ELSE

		IF lnv_Arrays.of_FindLong ( lla_Equipment, al_Id, ll_Null, ll_Null ) > 0 THEN
			lb_Return = TRUE
		END IF

	END CHOOSE

END IF


RETURN lb_Return
end function

public function integer of_getassignments (ref n_cst_dispatchids anv_dispatchids);Long	lla_Drivers[], &
		lla_PowerUnits[], &
		lla_TrailerChassis[], &
		lla_Containers[]
n_cst_DispatchIds	lnv_DispatchIds

Integer	li_Return = 1


IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetAssignments ( lla_Drivers, lla_PowerUnits, lla_TrailerChassis, &
		lla_Containers )

	CASE 1

		lnv_DispatchIds = CREATE n_cst_DispatchIds

		lnv_DispatchIds.of_AddDrivers ( lla_Drivers )
		lnv_DispatchIds.of_AddPowerUnits ( lla_PowerUnits )
		lnv_DispatchIds.of_AddTrailerChassis ( lla_TrailerChassis )
		lnv_DispatchIds.of_AddContainers ( lla_Containers )

	CASE ELSE

		li_Return = -1

	END CHOOSE

END IF


DESTROY anv_DispatchIds

IF li_Return = 1 THEN
	anv_DispatchIds = lnv_DispatchIds
END IF

RETURN li_Return
end function

public function integer of_getbaseforassignment (ref integer ai_basetype, ref long al_baseid, integer ai_targettype, long al_targetid, boolean ab_assign);//Validates that the target type is appropriate for the event, and that a proper base
//is available from which to make the assignment/unassignment (these are passed out 
//by reference if a proper base is available.)  (The "base" is the anchor assignment.)

//Returns : 1 (Target Type is Valid for the event, and a proper base is available)
// -1 = Invalid request, or any other error.

//If returning 1, ai_BaseType and al_BaseId will be set to the base values determined.
//If returning -1, ai_BaseType and al_BaseId will be set to null.


String	ls_EventType, &
			ls_ErrorMessage = "Could not process request."
Integer	li_BaseType
Long		ll_BaseId

Integer	li_Return = 1


SetNull ( li_BaseType )
SetNull ( ll_BaseId )


IF li_Return = 1 THEN

	ls_EventType = This.of_GetType ( )

	//Screen this one special case early so that it doesn't interfere with the logic 
	//flow below.

	IF ai_TargetType = gc_Dispatch.ci_ItinType_TrailerChassis AND &
		( ls_EventType = gc_Dispatch.cs_EventType_Mount OR &
		ls_EventType = gc_Dispatch.cs_EventType_Dismount ) THEN
	
		//Can't mount or dismount a trailer/chassis.
		ls_ErrorMessage = "Cannot mount / dismount a trailer or chassis."
		li_Return = -1
	
	END IF

END IF


//NOTE : This next chunk assumes one power unit and one driver in several places.
//Didn't quite know how to handle it more abstractly, so I implemented it this way...

IF li_Return = 1 THEN

	CHOOSE CASE ls_EventType
	
	CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount, &
		gc_Dispatch.cs_EventType_Drop, gc_Dispatch.cs_EventType_Dismount

		CHOOSE CASE ai_TargetType

		CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container

			//OK -- Now we have to determine the base id.

			//Assumes 1 driver, 1 power unit here...

			ll_BaseId = This.of_GetTractorId ( )

			IF NOT IsNull ( ll_BaseId ) THEN

				li_BaseType = gc_Dispatch.ci_ItinType_PowerUnit

			ELSE

				ll_BaseId = This.of_GetDriverId ( )

				IF NOT IsNull ( ll_BaseId ) THEN
					li_BaseType = gc_Dispatch.ci_ItinType_Driver
				ELSE
					//We should have a base id by now.
					ls_ErrorMessage = "The event must be routed to a driver or tractor itinerary "+&
						"in order to make this change."
					li_Return = -1
				END IF

			END IF

		CASE gc_Dispatch.ci_ItinType_PowerUnit

			ls_ErrorMessage = "Power unit assignments must be changed using New Trip / End Trip "+&
				"events in the driver itinerary, or by routing, re-routing, or removing the "+&
				"selected events in the tractor itinerary."
			li_Return = -1

		CASE gc_Dispatch.ci_ItinType_Driver

			ls_ErrorMessage = "Driver assignments can only be modified using New Trip and End Trip events."
			li_Return = -1

		CASE ELSE  //Unexpected value

			ls_ErrorMessage += "~n(Cannot change assignments for the selected target type.)"
			li_Return = -1

		END CHOOSE
	
	CASE gc_Dispatch.cs_EventType_NewTrip

		CHOOSE CASE ai_TargetType

		CASE gc_Dispatch.ci_ItinType_Driver

			//Assumes 1 driver, 1 power unit here...

			ll_BaseId = This.of_GetTractorId ( )

			IF NOT IsNull ( ll_BaseId ) THEN

				li_BaseType = gc_Dispatch.ci_ItinType_PowerUnit

			ELSE

				IF ab_Assign = TRUE THEN
					ls_ErrorMessage = "In order to assign the driver, the New Trip event must be "+&
						"routed to a driver or tractor itinerary."
				ELSE 
					ls_ErrorMessage = "In order to unassign the driver, the New Trip event must be "+&
						"removed or re-routed."
				END IF

				li_Return = -1

			END IF

			///////

		CASE gc_Dispatch.ci_ItinType_PowerUnit

			//Assumes 1 driver, 1 power unit here...

			ll_BaseId = This.of_GetDriverId ( )

			IF NOT IsNull ( ll_BaseId ) THEN

				li_BaseType = gc_Dispatch.ci_ItinType_Driver

			ELSE

				IF ab_Assign = TRUE THEN
					ls_ErrorMessage = "In order to assign the power unit, the New Trip event must be "+&
						"routed to a driver or power unit itinerary."
				ELSE 
					ls_ErrorMessage = "In order to unassign the power unit, the New Trip event must be "+&
						"removed or re-routed."
				END IF

				li_Return = -1

			END IF

			////////

		CASE ELSE

			ls_ErrorMessage = "Only drivers and power units may be assigned/unassigned using a "+&
				"New Trip event."
			li_Return = -1

		END CHOOSE

	CASE gc_Dispatch.cs_EventType_EndTrip

		ls_ErrorMessage = "Assignments for an End Trip must be changed by routing, "+&
			"re-routing, or removing the event."
		li_Return = -1
	
	CASE ELSE
		//Not an assignment event -- fail
		ls_ErrorMessage = "The event requested is not an assignment event."
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	ai_BaseType = li_BaseType
	al_BaseId = ll_BaseId

ELSE

	IF Len ( ls_ErrorMessage ) > 0 THEN
		This.of_AddError ( ls_ErrorMessage )
	END IF

	SetNull ( ai_BaseType )
	SetNull ( al_BaseId )

END IF


RETURN li_Return
end function

public function integer of_setsite (readonly long al_value);Time	lt_DefaultDuration
n_cst_beo_Company		lnv_Company
n_cst_dws				lnv_Dws
Long						ll_OldSite

Integer	li_Return = 1

ll_OldSite = THIS.of_GetSite ( )

IF li_Return = 1 THEN

	li_Return = This.of_SetAny ( "de_site", al_Value )

END IF

IF isValid ( inv_Shipment ) THEN
	inv_Shipment.of_EventSiteChanged ( ll_OldSite , al_Value , THIS.of_GetID ( ) ) 
ELSE
	//MessageBox ( "Hello", "No Shipment" )
END IF

//MessageBox ( "Hello", String ( li_Return ) )


IF li_Return = 1 THEN

	IF NOT IsNull ( al_Value ) THEN
		//Make sure the requested company is cached.
		gnv_cst_Companies.of_Cache ( al_Value, FALSE )
	//ELSE
		//Not a problem -- we're going to use the beo to set nulls below.
	END IF

	//Change processing
	lnv_Company = CREATE n_cst_beo_Company
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceId ( al_Value )

	//If we have the related company columns on the source, fill them in.
	//Note : If we have one, we'll assume we have them all.  This could be handled
	//individually, though.

	IF lnv_Dws.of_Describe ( This.of_GetSource ( ), "co_name.name" ) = "co_name" THEN

		This.of_SetAny ( "co_name", lnv_Company.of_GetName ( ) )
		This.of_SetAny ( "co_city", lnv_Company.of_GetCity ( ) )
		This.of_SetAny ( "co_state", lnv_Company.of_GetState ( ) )
		This.of_SetAny ( "co_zip", lnv_Company.of_GetZip ( ) )
		This.of_SetAny ( "co_tz", lnv_Company.of_GetTimeZone ( ) )
		This.of_SetAny ( "co_pcm", lnv_Company.of_GetPcm ( ) )

	END IF

	lt_DefaultDuration = lnv_Company.of_GetDefaultDuration ( )
	IF NOT IsNull ( lt_DefaultDuration ) THEN
		This.of_SetAny ( "de_duration", lt_DefaultDuration )
	END IF
	
	
	IF THIS.of_GetRoutable( ) = "F" AND NOT this.of_isconfirmed( )THEN
		THIS.of_confirm ( ) 
	END IF
	

END IF

DESTROY ( lnv_Company )

RETURN li_Return
end function

public function integer of_unconfirm ();//Returns : 1 = Success, 0 (No Action -- Wasn't confirmed to begin with), -1 = Failure

String	ls_Null
SetNull ( ls_Null )

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF This.of_IsConfirmed ( ) = FALSE THEN
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	This.of_SetConfirmed ( "F" )
	This.of_SetConfirmedBy ( ls_Null )

ELSEIF li_Return = -1 THEN

	IF This.of_GetErrorCount ( ) = 0 THEN
		This.of_AddError ( "An unexpected error has occurred." )
	END IF
	
END IF


RETURN li_Return
end function

public function boolean of_isinterchangecapable ();//Determines whether the event has an interchange-capable event type (like Hook, Drop, Mount, Dismount).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypeInterchangeCapable ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function boolean of_isassociation ();//Determines whether the event has an association event type (like New Trip, Hook, Mount).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypeAssociation ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function boolean of_isdissociation ();//Determines whether the event has an dissociation event type (like End Trip, Drop, Dismount).
//Returns TRUE, FALSE, Null = Cannot be determined (null value for event type, eg.)

n_cst_Events	lnv_Events
Boolean	lb_Result

CHOOSE CASE lnv_Events.of_IsTypeDissociation ( This.of_GetType ( ) )

CASE TRUE
	lb_Result = TRUE

CASE FALSE
	lb_Result = FALSE

CASE ELSE  //Null -- Cannot be determined.
	SetNull ( lb_Result )

END CHOOSE

RETURN lb_Result
end function

public function boolean of_istermination ();//Note : This code may call and commit a SQL transaction.

//The function determines whether the event qualifies as a termination, NOT whether
//individual pieces of equipment involved are actually set at terminating there.

//Returns : TRUE, FALSE, Null if cannot be determined.

String	ls_TerminationLocation
Long		ll_Site

Boolean	lb_Return = TRUE

IF lb_Return = TRUE THEN

	CHOOSE CASE This.of_IsInterchangeCapable ( )

	CASE TRUE
		//OK

	CASE FALSE
		lb_Return = FALSE

	CASE ELSE
		//Can't determine.
		SetNull ( lb_Return )

	END CHOOSE

END IF


IF lb_Return = TRUE THEN

	CHOOSE CASE This.of_IsDissociation ( )

	CASE TRUE
		//OK

	CASE FALSE
		lb_Return = FALSE

	CASE ELSE
		//Can't determine.
		SetNull ( lb_Return )

	END CHOOSE

END IF


IF lb_Return = TRUE THEN

	ll_Site = This.of_GetSite ( )

	IF IsNull ( ll_Site ) THEN
		SetNull ( lb_Return )
	END IF

END IF

IF lb_Return = TRUE THEN

	SELECT TerminationLocation INTO :ls_TerminationLocation FROM Companies WHERE co_Id = :ll_Site ;

	CHOOSE CASE SQLCA.SqlCode

	CASE 0

		COMMIT ;

		CHOOSE CASE ls_TerminationLocation

		CASE "T"
			//OK

		CASE "F"
			lb_Return = FALSE

		CASE ELSE
			//Unexpected value
			SetNull ( lb_Return )

		END CHOOSE

	CASE 100

		COMMIT ;

		SetNull ( lb_Return )

	CASE ELSE

		ROLLBACK ;

		SetNull ( lb_Return )

	END CHOOSE

END IF


RETURN lb_Return
end function

public function integer of_getfreightcarryingequipment (ref long ala_powerunits[], ref long ala_trailers[], ref long ala_containers[]);//Returns : 1 = Frieght-carrying equipment is assigned to the event.  It is passed out by ref.
//0 = No freight-carrying equipment is assigned to the event.   -1 = Error

Long		lla_Drivers[], &
			lla_PowerUnits[], &
			lla_TrailerChassis[], &
			lla_Containers[], &
			lla_Retrieve[], &
			lla_Empty[]

Integer	li_Count, &
			li_Index

DataStore	lds_Equipment
n_cst_beo_Equipment2	lnv_Equipment

n_cst_AnyArraySrv	lnv_Arrays
n_cst_EquipmentManager	lnv_EquipmentManager

Integer	li_Return = 0

lnv_Equipment = CREATE n_cst_beo_Equipment2


IF li_Return >= 0 THEN

	CHOOSE CASE This.of_GetAssignments ( lla_Drivers, lla_PowerUnits, &
		lla_TrailerChassis, lla_Containers )

	CASE 1
		//OK

	CASE -1
		//Error
		li_Return = -1

	CASE ELSE
		//Unexpected return value
		li_Return = -1

	END CHOOSE

END IF


IF li_Return >= 0 THEN

	lla_Retrieve = lla_PowerUnits

	IF lnv_Arrays.of_AppendLong ( lla_Retrieve, lla_TrailerChassis ) > 0 THEN

		IF lnv_EquipmentManager.of_Retrieve ( lds_Equipment, lla_Retrieve, &
			FALSE /*Do not fill in company columns*/ ) = -1 THEN

			li_Return = -1

		END IF

	END IF

END IF


IF li_Return >= 0 AND IsValid ( lds_Equipment ) THEN

	lnv_Equipment.of_SetSource ( lds_Equipment )

	//Check the PowerUnits

	li_Count = UpperBound ( lla_PowerUnits )

	FOR li_Index = 1 TO li_Count

		lnv_Equipment.of_SetSourceId ( lla_PowerUnits [ li_Index ] )

		IF lnv_Equipment.of_IsFreightCarrying ( ) = TRUE AND (NOT lnv_EquipmentManager.of_isunknownequipment( {lla_PowerUnits [ li_Index ]}  )  )THEN
			//Leave it in the array.
		ELSE
			SetNull ( lla_PowerUnits [ li_Index ] )
		END IF

	NEXT

	lnv_Arrays.of_GetShrinked ( lla_PowerUnits, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )


	//Check the TrailerChassis

	li_Count = UpperBound ( lla_TrailerChassis )

	FOR li_Index = 1 TO li_Count

		lnv_Equipment.of_SetSourceId ( lla_TrailerChassis [ li_Index ] )

		IF lnv_Equipment.of_IsFreightCarrying ( ) = TRUE AND (NOT lnv_EquipmentManager.of_isunknownequipment( {lla_TrailerChassis [ li_Index ]}  ) ) THEN
			//Leave it in the array.
		ELSE
			SetNull ( lla_TrailerChassis [ li_Index ] )
		END IF

	NEXT

	lnv_Arrays.of_GetShrinked ( lla_TrailerChassis, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )
	
	
	//Check the Containers

	li_Count = UpperBound ( lla_Containers )

	FOR li_Index = 1 TO li_Count

		//lnv_Equipment.of_SetSourceId ( lla_Containers [ li_Index ] )

		IF NOT lnv_EquipmentManager.of_isunknownequipment( {lla_Containers [ li_Index ]} )   THEN
			//Leave it in the array.
		ELSE
			SetNull ( lla_Containers [ li_Index ] )
		END IF

	NEXT

	lnv_Arrays.of_GetShrinked ( lla_Containers, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

END IF


IF li_Return >= 0 THEN

	ala_PowerUnits = lla_PowerUnits
	ala_Trailers = lla_TrailerChassis
	ala_Containers = lla_Containers

	IF UpperBound ( ala_PowerUnits ) > 0 THEN
		li_Return = 1
	ELSEIF UpperBound ( ala_Trailers ) > 0 THEN
		li_Return = 1
	ELSEIF UpperBound ( ala_Containers ) > 0 THEN
		li_Return = 1
	END IF

ELSE

	ala_PowerUnits = lla_Empty
	ala_Trailers = lla_Empty
	ala_Containers = lla_Empty

END IF

DESTROY ( lnv_Equipment )

RETURN li_Return
end function

public function boolean of_hasfreightcarryingequipment ();//Returns : TRUE, FALSE, Null if cannot be determined (due to error)

Long		lla_PowerUnits[], &
			lla_Trailers[], &
			lla_Containers[]


Boolean	lb_Return = FALSE


CHOOSE CASE This.of_GetFreightCarryingEquipment ( lla_PowerUnits, lla_Trailers, lla_Containers )

CASE 1
	//Has freight carrying equipment
	lb_Return = TRUE

CASE 0
	//Does not have freight carrying equipment
	lb_Return = FALSE

CASE -1
	//Error
	SetNull ( lb_Return )

CASE ELSE
	//Unexpected return value
	SetNull ( lb_Return )

END CHOOSE


RETURN lb_Return
end function

public function integer of_setid (long al_Value);RETURN This.of_SetAny ( "de_id", al_Value )
end function

public function integer of_setshipment (long al_value);RETURN This.of_SetAny ( "de_shipment_id", al_Value )
end function

public function integer of_setshipseq (long al_value);RETURN This.of_SetAny ( "de_ship_seq", al_Value )
end function

public function long of_getshipseq ();RETURN This.of_GetValue ( "de_ship_seq", TypeLong! )
end function

public function boolean of_allowmakemount ();Long	lla_Drivers[]
Long	lla_PowerUnits[]
Long	lla_TrailerChassis[]
Long	lla_Containers[]

Boolean	lb_Return = FALSE

IF THIS.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook THEN
	IF THIS.of_GetConfirmed ( ) = "T" THEN
		lb_Return = FALSE
	ELSE

		IF THIS.of_getactiveassignments ( lla_Drivers, lla_PowerUnits, lla_TrailerChassis , lla_Containers ) >= 0 THEN
			IF UpperBound ( lla_TrailerChassis ) > 0 THEN
				lb_Return = FALSE
			ELSE
				lb_Return = TRUE
			END IF	
		END IF
	END IF
END IF

RETURN lb_Return 

end function

public function boolean of_allowmakedismount ();Long	lla_Drivers[]
Long	lla_PowerUnits[]
Long	lla_TrailerChassis[]
Long	lla_Containers[]

Boolean	lb_Return = FALSE

IF THIS.of_GetType ( ) = gc_Dispatch.cs_EventType_DROP THEN
	
	IF THIS.of_GetConfirmed ( ) = "T" THEN
		lb_Return = FALSE
	ELSE
		
		IF THIS.of_getactiveassignments ( lla_Drivers, lla_PowerUnits, lla_TrailerChassis , lla_Containers ) >= 0 THEN
			IF UpperBound ( lla_TrailerChassis ) > 0 THEN
				lb_Return = FALSE
			ELSE
				lb_Return = TRUE
			END IF	
		END IF
		
	END IF
END IF

RETURN lb_Return 

end function

public function boolean of_isrouted ();Long	lla_Dummy[]
Long	lla_Dummy2[]
Long	ll_Trip

Boolean	lb_Routed

THIS.of_GetAssignments ( lla_Dummy , lla_Dummy2 )
ll_Trip = THIS.of_GEttrip ( )

IF ll_Trip > 0 OR UpperBound( lla_Dummy ) > 0 OR UpperBound( lla_Dummy2 ) > 0 THEN
	lb_routed = TRUE
END IF

Return lb_Routed
end function

public function boolean of_hasactivetrailerchassiscontainer ();/*
	modified to exclude UNK equipment when evaluating the assignments. This is only called from
	the event requirement object.

*/


Long		lla_PowerUnits[], &
			lla_Trailers[], &
			lla_Containers[], &
			lla_Drivers []
			
Boolean	lb_Return = FALSE
n_cst_equipmentmanager	lnv_eqMan

CHOOSE CASE This.of_GetActiveAssignments ( lla_Drivers , lla_PowerUnits, lla_Trailers, lla_Containers ) 
		
	CASE 1 , 0		
				
		IF UpperBound ( lla_Trailers ) > 0 OR UpperBound ( lla_Containers ) > 0 THEN
			lb_Return = TRUE
			IF lnv_eqMan.of_isunknownequipment( lla_Trailers ) OR lnv_eqMan.of_isunknownequipment( lla_Containers ) THEN							
				lb_Return = FALSE
			END IF
		END IF

	CASE -1
		//Error
		SetNull ( lb_Return )
	
	CASE ELSE
		//Unexpected return value
		SetNull ( lb_Return )
	
	END CHOOSE
	

RETURN lb_Return
end function

public function boolean of_hasactivecontainer ();/*
	modified to exclude UNK equipment when evaluating the assignments. This is only called from
	the event requirement object.

*/



Long		lla_PowerUnits[], &
			lla_Trailers[], &
			lla_Containers[], &
			lla_Drivers []
			
Boolean	lb_Return = FALSE
n_cst_equipmentmanager	lnv_eqMan


CHOOSE CASE This.of_GetActiveAssignments ( lla_Drivers , lla_PowerUnits, lla_Trailers, lla_Containers ) 
		
	CASE 1 , 0		
	
		IF UpperBound ( lla_Containers ) > 0 THEN
			lb_Return = NOT lnv_eqMan.of_IsUnknownequipment( lla_Containers )
			//lb_Return = TRUE
		END IF

	CASE -1
		//Error
		SetNull ( lb_Return )
	
	CASE ELSE
		//Unexpected return value
		SetNull ( lb_Return )
	
END CHOOSE


RETURN lb_Return
end function

public function decimal of_getfreightsplit ();RETURN This.of_GetValue ( "de_freightsplit", TypeDecimal! )
end function

public function decimal of_getaccessorialsplit ();RETURN This.of_GetValue ( "de_accesssplit", TypeDecimal! )
end function

public function long of_getsitefromnote ();String	ls_note
String	lsa_Result[]
Long		ll_Site
Int		li_Start
Int		li_End

n_cst_String	lnv_String

SetNull ( ll_Site )

ls_Note = THIS.of_GetNote ( ) 

li_Start = Pos ( ls_Note , THIS.cs_StartSiteDelimiter ) 
li_End = Pos ( ls_Note , THIS.cs_EndSiteDelimiter ) 

ls_Note = Mid ( ls_note , li_Start , li_End - li_Start )

lnv_String.of_ParseToArray ( ls_Note , "=" , lsa_Result )
IF upperBound ( lsa_Result ) = 2 THEN
	IF isNumber ( lsa_Result [2] ) THEN
		ll_Site = Long ( lsa_Result [2] )
	END IF
END IF




RETURN ll_Site
end function

public function integer of_setsiteineventnote (long al_site);String	ls_note
String	ls_originalNote
String	ls_NewSite
Int		li_Start
Int		li_End
String	ls_NewNote

n_cst_String	lnv_String

IF Not isNull ( al_Site ) THEN
	ls_NewSite = cs_startsitedelimiter + "SITE="+ String ( al_site ) + cs_endsitedelimiter
	
	ls_originalNote = THIS.of_GetNote ( ) 
	li_Start = Pos ( ls_originalNote , THIS.cs_StartSiteDelimiter ) 
	li_End = Pos ( ls_originalNote , THIS.cs_EndSiteDelimiter ) 
	IF li_Start > 0 AND li_End > 0 THEN
		// ls_Note will be the site tag <<SITE=XXXX>>
		ls_Note = Mid ( ls_originalNote , li_Start , li_End - li_Start + 2 )
	END IF
	
	
	IF TRIM ( ls_Note ) <> "" THEN
		ls_NewNote = lnv_String.of_GlobalReplace ( ls_originalNote , ls_Note , ls_NewSite )
	ELSE
		ls_NewNote = ls_NewSite
		IF NOT isNull ( ls_OriginalNote ) THEN
			ls_NewNote +=" " + ls_OriginalNote 
		END IF
	END IF
	
	THIS.of_SetNote ( ls_NewNote )
END IF

RETURN 1
end function

public function integer of_setscheduleddate (date ad_value);integer	li_return
//Start JBiron Edit
N_cst_Beo_Equipment2	lnva_equipment[]		
n_cst_AnyArraySrv	lnv_Array
n_cst_LicenseManager	lnv_LicMan
n_cst_bso_Dispatch	lnv_Disp
n_cst_bso 				lnv_dispatch
//End Edit

li_return = This.of_Setany ( "de_apptdate", ad_Value )

if li_return = 1 then

	n_cst_licensemanager	lnv_licensemanager

	lnv_Dispatch = this.of_GetContext()
	
	if isvalid(lnv_Dispatch) then

		IF lnv_Dispatch.Classname ( ) = "n_cst_bso_dispatch" THEN
			//try to add for EDI status
			IF lnv_LicenseManager.of_HasEDI214License() THEN
				lnv_dispatch.dynamic of_AddEDI214Event(this.of_GetId())
			END IF
		
			//Moved eq posting function from empty at customer
			IF lnv_LicMan.of_hasequipmentpostinglicense( ) THEN
				
				lnv_Disp = lnv_dispatch

				IF Not IsNull ( ad_value ) THEN
					lnv_Disp.of_GetEquipmentforshipment( THIS.of_GetShipment()  , lnva_equipment )
					lnv_Disp.of_GetEquipmentPosting ( ).of_ProposeHavePostings ( lnva_equipment )
					lnv_Array.of_Destroy( lnva_equipment )
				END IF
			END IF
		END IF	
		//End Edit
	END IF

end if

return li_return
end function

public function integer of_setscheduledtime (time at_value);integer	li_return

li_return = This.of_SetAny ( "de_appttime", at_Value )

if li_return = 1 then

	n_cst_licensemanager	lnv_licensemanager

	IF lnv_LicenseManager.of_HasEDI214License() THEN

		//try to add for EDI status
		n_cst_bso lnv_dispatch
		
		lnv_Dispatch = this.of_GetContext()
		if isvalid(lnv_Dispatch) then
			IF lnv_Dispatch.Classname ( ) = "n_cst_bso_dispatch" THEN
				lnv_dispatch.dynamic of_AddEDI214Event(this.of_GetId())
			END IF
		END IF	

	END IF

end if

return li_return
end function

public function integer of_setreference (string as_value);RETURN This.of_SetAny ( "disp_events_eventreference", as_value )
end function

public function string of_getreference ();RETURN This.of_GetValue ( "disp_events_eventreference", Typestring! )
end function

public function string of_getnotificationtemplate ();Any		la_value
String	ls_Return
n_cst_Settings	lnv_Settings	

IF lnv_Settings.of_GetSetting	( 111, la_Value ) = 1 THEN
	ls_Return = String ( la_Value )
END IF

RETURN ls_Return 
end function

public function string of_getnotificationsubject ();// april 29 2004 switched to use the standard subject line


String	ls_Oldtype
String	ls_Subject

ls_Subject = "Event Update "

IF isValid ( inv_Shipment ) THEN
	ls_OldType = inv_Shipment.of_GetDocumenttype( )
	inv_shipment.of_SetDocumentType ( "" ) // this will cause it to go to the ELSE statement in the shipment and return the base subject
	ls_Subject += inv_Shipment.of_GetNotificationsubject( )
	inv_shipment.of_SetDocumentType ( ls_Oldtype ) 
END IF

RETURN ls_Subject



//// RDT 6-19-03 Remove shipment and add Container on subject line 
//String	ls_Return
//Long	ll_ShipmentID
//
//// RDT 6-19-03 - START
//String ls_RefLabel, ls_RefText, &
//			ls_Container, &
//			ls_Subject = "Event Update "
//
//Integer 	li_Count, li_Upper
//n_cst_anyarraySrv lnv_array
//
//n_cst_beo_equipment2 lnva_equipment[] 
//
//n_cst_equipmentmanager lnv_equipmentmanager 
//
//If IsValid ( inv_Shipment ) Then 
//	li_Upper = inv_Shipment.of_getLinkedequipment ( lnva_equipment[] ) 
//	
//	If li_Upper > 0 then 
//		// loop thru looking for a container
//		For li_Count = 1 to li_Upper
//			if lnva_Equipment[li_count].of_GetType() = lnv_equipmentmanager.cs_cntn Then 
//				ls_Container = lnva_Equipment[li_count].of_GetNumber()
//				Exit
//			end if
//		Next
//		If Len(Trim( ls_Container)) > 0 then
//			ls_Subject += "Container "+ls_Container+ " "
//		End if
//			
//	End If
//
//	
//	ls_RefLabel = inv_Shipment.of_GetRef2Label( )
//	ls_RefText  = inv_Shipment.of_GetRef2Text( )
//
//	lnv_array.of_Destroy( lnva_equipment[] ) 
//
//End if
//
//If Len(Trim( ls_RefLabel ) ) < 1 or IsNull( ls_RefLabel ) or ls_RefLabel = "[NONE]" then 
//		ls_RefLabel = ""
//End If
//
//If Len(Trim( ls_RefText ) ) < 1 or IsNull( ls_RefText ) then 
//		ls_RefText = ""
//End If
//
//ls_Subject += ls_RefLabel + ls_RefText
//
//ls_Return = ls_Subject 
//
//// RDT 6-19-03 - END 
//
//
//// RDT 6-19-03 - COMMENTED SECTION BELOW
////ls_Return = "Event Update" 
////
////ll_ShipmentID = THIS.of_GetShipment (  )
////
////IF ll_ShipmentID > 0 THEN
////	ls_Return += " for shipment " + String ( ll_ShipmentID ) 
////END IF
//
//
//RETURN ls_Return
///*
//
//
//String	ls_Return
//Long	ll_ShipmentID
//
//ls_Return = "Event Update"
//
//ll_ShipmentID = THIS.of_GetShipment (  )
//
//IF ll_ShipmentID > 0 THEN
//	ls_Return += " for shipment " + String ( ll_ShipmentID ) 
//END IF
//
//
//RETURN ls_Return
//*/
end function

public function integer of_getnotificationtargets (ref long ala_contactids[]);// RDT 5-13-03 Contacts are now stored on the event instead of the shipment

Int	li_Return 

li_Return = This.of_GetEventContacts( ala_contactids[ ] ) // RDT 5-13-03 New line 

// RDT 5-13-03 Comment Block - START 
	//Long	ll_ShipmentID
	//n_cst_beo_Shipment	lnv_Shipment
	//n_cst_bso_Dispatch	lnv_Dispatch
	//
	//lnv_Shipment = CREATE n_cst_beo_Shipment
	//lnv_Dispatch = CREATE n_cst_bso_Dispatch
	//
	//ll_ShipmentID = THIS.of_GetShipment (  )
	//
	//IF ll_ShipmentID > 0 THEN
	//	lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
	//	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( )) 
	//	lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
	//END IF
	//
	//
	//IF lnv_Shipment.of_HasSource ( ) THEN
	//   //lnv_Shipment.of_GetNotificationTargets ( ala_ContactIDs[] )
	//	lnv_Shipment.of_GetEventContacts ( ala_ContactIDs[] )
	//	li_Return = UpperBound ( ala_ContactIDs[] )
	//END IF
	//
	//
	//DESTROY ( lnv_Shipment ) 
	//Destroy ( lnv_Dispatch )
// RDT 5-13-03 Comment Block - END 



RETURN li_Return 
end function

public function boolean of_isnotificationworthy ();Boolean lb_Return
String	ls_Routable

ls_Routable = THIS.of_GetRoutable ( ) 
IF IsNull ( ls_Routable ) THEN
	ls_Routable = 'T'
END IF

IF THIS.of_GetShipment ( ) > 0 AND ( THIS.of_isPickupGroup ( ) OR THIS.of_isDeliverGroup ( ) ) AND ls_Routable = 'T' THEN
	
	
	lb_Return = TRUE
END IF

RETURN lb_Return
end function

public function integer of_setroutable (string as_value);Int	li_Return


li_Return = THIS.of_SetAny ( "disp_events_routable" , as_Value )

IF li_Return = 1 THEN
	CHOOSE CASE  as_Value
			
		CASE "T"
			THIS.of_UnConfirm  ( )
			
		CASE "F"
			
			THIS.of_Confirm ( )
	END CHOOSE
END IF

RETURN li_Return
	
end function

public function string of_getroutable ();RETURN THIS.of_getValue ( "disp_events_routable" , TypeString! )
end function

public function boolean of_sendnotification ();//
/***************************************************************************************
NAME			: of_SendNotification
ACCESS		: Public
ARGUMENTS	: none
RETURNS		: Boolean
DESCRIPTION	: Checks systems settings to validate sending of EVENT notification

REVISION		: RDT 12-03-02
				  RDT 5-13-03 added call to of_SendNotification(0)
***************************************************************************************/
//
Boolean 	lb_Return 
//
//Any		la_Value
//
//n_cst_Settings lnv_Settings
//
//lb_Return = TRUE 
//
//IF lnv_Settings.of_GetSetting ( 109 , la_value ) <> 1 THEN
//	lb_Return = FALSE
//END IF
//
//IF String ( la_Value ) <> "YES!" THEN
//	lb_Return  = FALSE		
//END IF		

lb_Return = This.of_SendNotification(0)


Return lb_Return 
end function

private function boolean of_istypepickup ();//
/***************************************************************************************
NAME			: of_isTypePickup
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: boolean
DESCRIPTION	: Checks the current event type against the pickup constant

REVISION		: RDT 5-13-03
***************************************************************************************/
Boolean	lb_Return = FALSE

String	lsa_PickupType[], &
			ls_EventType
			
Integer	li_i, &
			li_ArrayCount

n_cst_String lnv_String

li_ArrayCount = lnv_String.of_ParseToArray( n_cst_constants.cs_notificatioevent_hmp, ",", lsa_PickupType[])

ls_EventType = This.of_GetType()
For li_i = 1 to li_ArrayCount

	if lsa_PickupType[li_i] = ls_EventType Then
		lb_Return = TRUE
	end if

Next

Return lb_Return 
end function

private function boolean of_istypedrop ();//
/***************************************************************************************
NAME			: of_isTypeDrop
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: boolean
DESCRIPTION	: Checks the current event type against the Drop constants

REVISION		: RDT 5-13-03
***************************************************************************************/
Boolean	lb_Return = FALSE

String	lsa_DropType[], &
			ls_EventType
			
Integer	li_i, &
			li_ArrayCount

n_cst_String lnv_String

li_ArrayCount = lnv_String.of_ParseToArray( n_cst_constants.cs_notificatioevent_drn, ",", lsa_DropType[])

ls_EventType = This.of_GetType()
For li_i = 1 to li_ArrayCount

	if lsa_DropType[li_i] = ls_EventType Then
		lb_Return = TRUE
	end if

Next

Return lb_Return 
end function

public function boolean of_isorigin (readonly long al_id);//
/***************************************************************************************
NAME			: of_Isorigin
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: Boolean
DESCRIPTION	: Checks to see if the site on the event is the same as the argument 	
					and the event type is a pickup 

REVISION		: RDT 5-13-03
***************************************************************************************/

Boolean	lb_Return = FALSE

If al_id = This.of_getSite ( ) AND This.of_isPickupGroup( ) Then 
	lb_Return = TRUE
End If

Return lb_Return 

end function

public function boolean of_isdestination (readonly long al_id);//
/***************************************************************************************
NAME			: of_IsDestination
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: Boolean
DESCRIPTION	: Checks to see if the site on the event is the same as the company id argument 
					and the event is a deliver type

REVISION		: RDT 5-13-03
***************************************************************************************/

Boolean	lb_Return = FALSE

If al_id = This.of_getSite ( ) AND This.of_isDeliverGroup( ) Then 
	lb_Return = TRUE
End If

Return lb_Return 

end function

public function boolean of_sendnotification (long al_companyid);///***************************************************************************************
//NAME			: of_SendNotification
//ACCESS		: Public 
//ARGUMENTS	: Long	Company ID
//RETURNS		: Boolean
//DESCRIPTION	: Checks customer record to see if the customer wants this event type.
//
//REVISION		: RDT 5-13-03
//***************************************************************************************/

Boolean 	lb_Return = TRUE

Any		la_Value

n_cst_Settings lnv_Settings

IF lnv_Settings.of_GetSetting ( 109 , la_value ) <> 1 THEN
	lb_Return = FALSE
END IF

IF String ( la_Value ) <> "YES!" THEN
	lb_Return  = FALSE		
END IF		

Return lb_Return

//******************************/
// Please delete me, let me go  /
//******************************/
//String	ls_Origin, &
//			ls_Destination
//
//Boolean 	lb_Return = FALSE, &
//			lb_Inbound, &
//			lb_Outbound
//
//Long		ll_ShipmentId, &
//			ll_ShipOriginID, &
//			ll_ShipDestID
//
//IF al_CompanyId =  0 Then 
//	lb_Return = TRUE
//ELSE 
//
//	n_cst_bso_Dispatch	lnv_Dispatch
//	n_cst_beo_Shipment	lnv_Shipment
//	n_cst_beo_Company		lnv_Company
//	
//	lnv_Dispatch = CREATE n_cst_bso_Dispatch
//	lnv_Shipment = CREATE n_cst_beo_Shipment
//	lnv_Company	 = CREATE n_cst_beo_Company		
//			
//	ll_ShipmentID = THIS.of_GetShipment (  )
//	
//	If ll_ShipmentID > 0 THEN
//		lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
//		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( )) 
//		lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
//	End if
//
//
//	// get company notification settings
//	If NOT lnv_company.of_HasSource() Then 
//		lnv_company.of_Setsourceid ( al_CompanyId )		
//	End if
//	
//	lnv_Company.of_SetUseCache ( TRUE )
//	ls_Destination = lnv_Company.of_GetNotificationEventDestination ( )
//	ls_Origin 		= lnv_Company.of_GetNotificationEventOrigin ( )
//
//	ll_ShipOriginID = lnv_shipment.of_getorigin ( ) 
//	ll_ShipDestID	 = lnv_shipment.of_getdestination ( )
//
//	If This.of_IsPickupGroup() Then 
//		Choose Case ls_Origin 
//			Case n_cst_constants.cs_notificatioevent_orig
//				// check if event is an origin
//				if This.of_IsOrigin( ll_ShipOriginID ) Then 
//					lb_Return = TRUE
//				end if
//	
//			Case n_cst_constants.cs_notificatioevent_hmp
//				// check event type
//				if This.of_IsPickupGroup() Then 
//					lb_Return = TRUE
//				end if
//			Case Else
//				lb_Return = FALSE
//		End Choose
//	End If
//	
//	If This.of_IsDeliverGroup() Then 
//		Choose Case ls_Destination 
//			Case n_cst_constants.cs_notificatioevent_dest
//				// check if event is a Destination 
//				if This.of_isDestination ( ll_ShipDestID ) Then 
//					lb_Return = TRUE
//				end if
//	
//			Case n_cst_constants.cs_notificatioevent_drn
//				// check event type
//				if This.of_isDeliverGroup ( ) Then 
//					lb_Return = TRUE
//				end if
//			Case Else
//				lb_Return = FALSE
//		End Choose
//	End If	
//	
//	DESTROY ( lnv_Shipment ) 
//	Destroy ( lnv_Dispatch )
//	
//END IF 
//
//
//Return lb_Return 

end function

public function integer of_seteventcontacts (long ala_contacts[]);// RDT 5-13-03 Set the contact list on the beo

String			ls_Result
n_cst_String	lnv_String

If IsNull( ala_contacts[] ) OR UpperBound( ala_contacts[] ) < 1 Then 
	SetNull ( ls_Result ) 
Else
	lnv_String.of_ArrayToString ( ala_contacts , "," , ls_Result )
End If

RETURN THIS.of_SetAny ("disp_events_eventcontacts" , ls_Result )
end function

public function integer of_geteventcontacts (ref long ala_contacts[]);// RDT 5-13-03 Returns the contacts for the event
n_cst_string	lnv_String
Int				li_return = 0
Long				lla_Contacts[]
String			ls_Contacts

ls_Contacts = THIS.of_GetValue ( "disp_events_eventcontacts" , TYPESTRING! )

IF Not IsNull ( ls_Contacts ) THEN
	lnv_String.of_ParseToArray ( ls_Contacts , "," , lla_Contacts )
	ala_Contacts = lla_Contacts
	li_Return = UpperBound ( ala_Contacts )
END IF

RETURN li_Return

end function

public function integer of_addcontactid (long al_contactid);//
/***************************************************************************************
NAME			: of_AddContactId
ACCESS		: Public 
ARGUMENTS	: Long		( Contact id )
RETURNS		: Integer	( 1=Success, -1=failed )
DESCRIPTION	: Adds the argument to the contact id column

REVISION		: RDT 5-13-03

***************************************************************************************/

// Get list
// append id to list
String 	ls_CurrentContacts
Long		lla_Contacts[], &
			ll_NumberofContactsOLD, &
			ll_NumberofContactsNEW
			
Integer	li_Return 

n_cst_anyarraysrv lnv_array

ll_NumberofContactsOLD = This.of_GetEventContacts ( lla_contacts[] )

ll_NumberofContactsNEW = lnv_array.of_AppendLong ( lla_contacts[] , {al_contactid} )

This.of_SetEventContacts ( lla_contacts[] )

If ll_NumberofcontactsNEW > ll_NumberofcontactsOLD Then 
	li_Return = 1 
Else
	li_Return = -1
End if

Return li_Return 
end function

public function integer of_removecontactid (readonly long al_contactid);//
/***************************************************************************************
NAME			: of_RemoveContactId
ACCESS		: Public 
ARGUMENTS	: Long		( Contact id )
RETURNS		: Integer	( 1=Success, -1=failed )
DESCRIPTION	: Removes the argument id from the contact id column

REVISION		: RDT 5-13-03

***************************************************************************************/
String 	ls_CurrentContacts
Long		lla_Contacts[], &
			ll_NumberofContactsOLD, &
			ll_NumberofContactsNEW
			
Integer	li_Return 

n_cst_anyarraysrv lnv_array

ll_NumberofContactsOLD = This.of_GetEventContacts ( lla_contacts[] )

ll_NumberofContactsNEW = lnv_array.of_RemoveLong ( lla_contacts[] , {al_contactid}, TRUE /*shrink*/)

This.of_SetEventContacts ( lla_contacts[] )

If ll_NumberofcontactsNEW < ll_NumberofcontactsOLD Then 
	li_Return = 1 
Else
	li_Return = -1
End if

Return li_Return 
end function

public function boolean of_isassigned (integer ai_type, long al_id);//Returns : TRUE, FALSE, Null if cannot be determined.
//FALSE will be returned if a null value is provided for al_Id.

//If a null ai_Type is provided, al_Id will be treated as equipment.

Long	lla_Drivers[], &
		lla_Equipment[], &
		ll_Null
n_cst_AnyArraySrv	lnv_Arrays


Boolean	lb_Return = FALSE

SetNull ( ll_Null )


IF lb_Return = FALSE THEN

	CHOOSE CASE This.of_GetAssignments ( lla_Drivers, lla_Equipment )

	CASE 1, 0
		//OK

	CASE ELSE
		SetNull ( lb_Return )

	END CHOOSE

END IF


IF lb_Return = FALSE THEN

	CHOOSE CASE ai_Type

	CASE gc_Dispatch.ci_ItinType_Driver

		IF lnv_Arrays.of_FindLong ( lla_Drivers, al_Id, ll_Null, ll_Null ) > 0 THEN
			lb_Return = TRUE
		END IF

	CASE ELSE

		IF lnv_Arrays.of_FindLong ( lla_Equipment, al_Id, ll_Null, ll_Null ) > 0 THEN
			lb_Return = TRUE
		END IF

	END CHOOSE

END IF


RETURN lb_Return
end function

public function boolean of_iscrossdock ();//
/***************************************************************************************
NAME			: of_IsCrossDock
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: Boolean
DESCRIPTION	: If the current event is a crossdock, true is returned.

REVISION		: RDT 5-13-03
***************************************************************************************/
Boolean 			lb_Return = False
Integer			i
Long				ll_CrossDockEventCount, &
					lla_CrossDockRows[] 

DataStore		lds_Source
DataWindow		ldw_Source
n_cst_Dws		lnv_Dws

PowerObject		lpo_Source

n_cst_anyarraysrv anv_anyarray

n_cst_Crossdock lnv_Crossdock
lnv_CrossDock = CREATE n_cst_CrossDock

//Check that the source type is ok.
lpo_Source = This.of_getsource ( )

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( lpo_Source , ldw_Source, lds_Source )

CASE DataStore!
	//Type is ok.
	lb_Return = TRUE
	
CASE ELSE  //DataWindow!, or nothing
	//Can't process -- processing service only handles datastores.
	lb_Return = FALSE
	
END CHOOSE

If lb_Return Then 
	
	if lnv_CrossDock.of_Ready ( ) then
		ll_CrossDockEventCount = lnv_CrossDock.of_GetDockRows ( lds_Source, lla_CrossDockRows )
	end If
	
	if ll_CrossDockEventCount > 0 then 
		// find currentrow in array of lla_CrossDockRows
		If anv_anyarray.of_find ( lla_CrossDockRows, This.of_getsourcerow() , 1, UpperBound(lla_CrossDockRows ) ) > 0 Then 
			lb_Return = TRUE
		Else
			lb_Return = FALSE
		End If
	else
		lb_Return = FALSE
	end If
	
End If

Destroy ( lnv_CrossDock ) 

Return lb_Return

end function

public function Boolean of_gethideonbill ();String	ls_Setting
Boolean	lb_Hide

ls_Setting = THIS.of_getValue ( "disp_events_hideonbill" , TypeString! )

IF ls_Setting = 'T' THEN
	lb_Hide = TRUE 
END IF

RETURN lb_Hide
end function

public function integer of_sethideonbill (boolean ab_value);String	ls_Value
Int	li_Return

IF ab_value THEN
	ls_Value = 'T'
ELSE
	ls_Value = 'F'
END IF

li_Return = THIS.of_SetAny ( "disp_events_hideonbill" , ls_Value )

RETURN li_Return
	

end function

public function integer of_getshipment (ref n_cst_beo_shipment anv_shipment);Integer li_Return 

If IsValid( inv_Shipment ) Then 
	anv_Shipment = inv_Shipment
	li_Return = 1
else
	li_Return = -1
end if 

IF li_Return = -1 THEN
	Long	ll_ShipmentID
	ll_ShipmentID = THIS.of_GetShipment ( )
	
	IF ll_ShipmentID > 0 THEN
		n_Cst_bso lnv_Context
			
		lnv_Context = THIS.of_GetContext ( ) 
		IF ISValid ( lnv_Context ) THEN
			IF lnv_Context.Classname( ) = "n_cst_bso_dispatch" THEN
				inv_Shipment = CREATE n_cst_beo_Shipment
				lnv_Context.Dynamic of_RetrieveShipment ( ll_ShipmentID )
				inv_Shipment.of_SetSource ( lnv_Context.Dynamic of_GetShipmentCache ( ) )
				inv_Shipment.of_SetSourceID ( ll_ShipmentID )
				anv_shipment = inv_shipment
				li_Return = 1
			END IF
		END IF		
	END IF
END IF

Return li_Return
end function

public function boolean of_isorigin (long ala_id[]);// RDT 8-22-03 ala_id[]

//loop thru companies to see if any are the origin for this site.
Boolean lb_Return  = FALSE 

Integer i, li_Max

li_Max = UpperBound( ala_id[] )

For i = 1 to li_Max
		If this.of_IsOrigin( ala_id[ i ] ) then 
			lb_Return = TRUE 
		End IF
Next


Return lb_Return 
end function

public function boolean of_isdestination (long ala_id[]);// RDT 8-22-03 of_isDestination( ala_id[])

//loop thru companies to see if any are the destination for this site.
// that would make this event a destination event.
Boolean lb_Return  = FALSE 

Integer i, li_Max

li_Max = UpperBound( ala_id[] )

For i = 1 to li_Max
		If this.of_IsDestination( ala_id[ i ] ) then 
			lb_Return = TRUE 
		End IF
Next


Return lb_Return 
end function

public function integer of_addcompaniestoevent ();// RDT 8-27-03
// get shipment from event
// get all companies from shipment
// clear event contacts
// loop thru companies and add contacts to event if needed

Long	lla_CompanyId[]
Long	lla_Contacts[]
Long	ll_upper
Long	ll_count
n_cst_ContactManager	lnv_ContactManager
lnv_ContactManager = CREATE n_cst_ContactManager

n_cst_beo_Company	lnv_Co
lnv_Co = CREATE n_Cst_beo_Company
lnv_Co.of_SetUseCache ( TRUE ) 


If This.of_IsCrossDock() Then 
	// do nothing. User must manually add contacts for cross docks
Else
	If Isvalid( inv_Shipment ) Then 
		
		n_cst_beo_Event lnv_Event	
		lnv_Event = This
		
		n_cst_ShipmentManager lnv_shipmentManager  
		
		n_cst_bso_Notification_Manager lnv_Notification_Manager 
		lnv_Notification_Manager = create n_cst_bso_Notification_Manager 
		
		//	inv_Shipment.of_GetAllCompanies( lla_Companies)
		lnv_shipmentManager.of_getallcompanies ( {inv_shipment}, lla_companyId[] )
		ll_upper = UpperBound( lla_companyId )
 
		For ll_count = 1 to ll_upper 
			
//			<<*>>
			lnv_Co.of_SetSourceID ( lla_CompanyId[ll_count] )
			// check to see if the contacts belong or should be removed
			If lnv_Notification_Manager.of_isCompanyEvent ( lla_CompanyId[ll_count], lnv_event ) AND lnv_ContactManager.of_doesrolepermitnotification( inv_Shipment, lnv_Co )  Then 
				lnv_Notification_Manager.of_EventCompanyContact ( lla_CompanyId[ll_count], lnv_Event, TRUE /*add company*/)		
			Else
				lnv_Notification_Manager.of_EventCompanyContact ( lla_CompanyId[ll_count], lnv_Event, FALSE /*Remove company*/)						
			End If				
		Next

		
		destroy( lnv_Notification_Manager )
			
	End if
	
End if

DESTROY ( lnv_ContactManager )
DESTROY ( lnv_Co )
Return 1
end function

public function integer of_setsitebyref (string as_companyref);Long	ll_Return = -1
Long	ll_SiteID
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

ll_Return = gnv_cst_companies.of_Find ( as_companyref )
IF ll_Return > 0 THEN
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceRow ( ll_Return )
	ll_SiteID = lnv_Company.of_GetID ( )
	
	IF ll_SiteID > 0 THEN
		IF THIS.of_SetSite ( ll_SiteID ) = 1 THEN
			ll_Return = 1
		END IF
	END IF
END IF

DESTROY lnv_Company

return ll_Return
end function

public function long of_getimportreference ();RETURN This.of_GetValue ( "disp_events_importreference", TypeLong! )
end function

public function integer of_setimportreference (long al_value);RETURN This.of_SetAny ( "disp_events_importreference", al_Value )
end function

public function date of_getearliestdate ();RETURN This.of_GetValue ( "disp_events_earliestDate", TypeDate! )
end function

public function date of_getlatestdate ();RETURN This.of_GetValue ( "disp_events_LatestDate", TypeDate! )
end function

public function time of_getearliesttime ();RETURN This.of_GetValue ( "disp_events_earliestTime", TypeTime! )
end function

public function time of_getlatesttime ();RETURN This.of_GetValue ( "disp_events_LatestTime", TypeTime! )
end function

public function integer of_setlatesttime (readonly time at_value);RETURN  This.of_SetAny ( "disp_events_LatestTime", at_Value )
end function

public function integer of_setlatestdate (date ad_value);RETURN  This.of_Setany ( "disp_events_LatestDate", ad_Value )

end function

public function integer of_setearliestdate (date ad_value);RETURN  This.of_Setany ( "disp_events_EarliestDate", ad_Value )

end function

public function integer of_setearliesttime (readonly time at_value);RETURN  This.of_SetAny ( "disp_events_EarliestTime", at_Value )
end function

public function decimal of_getdriverseq ();RETURN This.of_GetValue ( "de_driver_seq", TypeDecimal! )
end function

public function decimal of_gettractorseq ();RETURN This.of_GetValue ( "de_tractor_seq", TypeDecimal! )
end function

public function decimal of_gettrailer1seq ();RETURN This.of_GetValue ( "de_trailer1_seq", TypeDecimal! )
end function

public function decimal of_gettrailer2seq ();RETURN This.of_GetValue ( "de_trailer2_seq", TypeDecimal! )
end function

public function decimal of_gettrailer3seq ();RETURN This.of_GetValue ( "de_trailer3_seq", TypeDecimal! )
end function

public function decimal of_getcontainer1seq ();RETURN This.of_GetValue ( "de_container1_seq", TypeDecimal! )
end function

public function decimal of_getcontainer2seq ();RETURN This.of_GetValue ( "de_container2_seq", TypeDecimal! )
end function

public function decimal of_getcontainer3seq ();RETURN This.of_GetValue ( "de_container3_seq", TypeDecimal! )
end function

public function decimal of_getcontainer4seq ();RETURN This.of_GetValue ( "de_container4_seq", TypeDecimal! )
end function

public function decimal of_gettripseq ();RETURN This.of_GetValue ( gc_Dispatch.cs_Column_TripSeq, TypeDecimal! )
end function

public function integer of_getreferencedentities (ref pt_n_cst_beo anv_objects[]);Long	lla_Drivers[]
Long	lla_Equipment[]
Long	i
Long	li_Bound
Int	li_Return
Int	li_Count

pt_n_cst_beo	lnva_Returnlist[]
n_cst_beo_Company	lnv_Company

THIS.of_GetSite( lnv_Company )
IF IsValid ( lnv_Company ) THEN
	li_Count ++
	lnva_Returnlist [ li_Count ] = lnv_Company
END IF

THIS.of_Getassignments( lla_Drivers , lla_Equipment )

li_Bound = UpperBound ( lla_Equipment )

FOR i = 1 TO li_Bound
	li_Count ++
	lnva_Returnlist [ li_Count ] = CREATE n_cst_beo_Equipment2
	lnva_Returnlist [ li_Count ].of_SetSourceID ( lla_Equipment[i] )
NEXT

li_Bound = UpperBound ( lla_Drivers )
FOR i = 1 TO li_Bound
	li_Count ++
	lnva_Returnlist [ li_Count ] = CREATE n_cst_beo_Employee2
	lnva_Returnlist [ li_Count ].of_SetSourceID ( lla_Drivers[i] )
NEXT

FOR i = 1 TO li_Count
	lnva_ReturnList[i].of_GetReferencedentities( lnva_ReturnList )
NEXT


li_Count = UpperBound ( anv_objects[] )
FOR i = 1 TO UpperBound ( lnva_ReturnList )
	li_Count ++
	anv_objects [li_Count] = lnva_ReturnList[i]
NEXT

IF THIS.of_GetShipment( ) > 0 THEN
	li_Count ++
	anv_objects [li_Count] = CREATE n_cst_beo_Shipment
	anv_objects [li_Count].of_SetSourceID ( THIS.of_GetShipment( ) )
END IF

li_Return = UpperBound ( anv_objects[] )

RETURN li_Return
end function

public function integer of_setappointmentnumber (string as_value);RETURN This.of_SetAny ( "de_apptnum", as_Value )
end function

public function integer of_setstatus (readonly string as_value);RETURN This.of_SetAny ( "de_status", as_Value )

end function

public function integer of_replaceunknownequipment (string as_type, string as_newvalue);Int	li_Return  = 1
Integer	li_ErrorCount
String	ls_Unknown = "UNK"
String	ls_Ref
String	lsa_Errors[]
Long	lla_Equipment[]
Long	ll_EqID

n_cst_equipmentManager	lnv_EquipMan
CHOOSE CASE as_type 
		
	CASE "CONTAINER"
		
		THIS.of_GetContainerList ( lla_Equipment , FALSE)
		
	CASE "TRAILER" , "CHASSIS" , "RAILBOX" 
		THIS.of_GetTrailerList( lla_Equipment , FALSE)
		
END CHOOSE
		
Long	ll_EqCount
Int	i, j
n_cst_beo_Shipment	lnv_Shipment
ll_EqCount = UpperBound ( lla_Equipment )
THIS.of_GetShipment ( lnv_Shipment )
FOR i = 1 TO ll_EqCount
	
	ll_EqID = lla_Equipment[i]
	
	  SELECT "equipment"."eq_ref"  
    INTO :ls_Ref  
    FROM "equipment"  
   WHERE "equipment"."eq_id" = :ll_EqID ;
	
	COMMIT;

	IF Left ( ls_Ref , 3 ) = "UNK" THEN
		IF lnv_EquipMan.of_updateunknownequipment( ll_EqID, as_newvalue , lnv_Shipment ) <> 1 THEN
			//MFS 4/16/07 - added errors
			li_ErrorCount = lnv_EquipMan.of_GetErrors(lsa_Errors)
			FOR j = 1 TO li_ErrorCount
				This.of_AddError(lsa_Errors[j])
			NEXT
		END IF
	END IF
	
	
NEXT

RETURN li_Return
end function

public function long of_getdivisionid ();Long	ll_Return
ll_Return = 0  

IF isValid ( inv_shipment ) THEN
	
	ll_Return = inv_shipment.of_GetDivisionid( )
	
END IF

RETURN ll_Return
end function

public function integer of_setcrossdock (long al_value);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_setcrossdock
//  
//	Access		: Public
//
//	Arguments	: al_value
//			
//
//	Return		: int
//			
//						
//	Description	: Determine if the current event is part of a cross-dock.
//					  If the 2nd event is a deliver with no import reference, 
//					  assume it's a cross-dock event.
//					  IF the 3rd event is a pickup with no import reference, 
//					  assume it is also a cross-dock event.
//
//						THIS ID USED FOR EDI MAPPINGS ONLY
//
//
// 	Written by	: Samuel Towle
// 		Date	: 06/22/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////



Int		li_Seq
Int		li_Return
String	ls_Type

	
ls_Type = THIS.of_Gettype ( )								// Gets the event type
li_Seq = THIS.of_GetShipSeq ( )								// Gets the the event number sequence

IF ISNULL (THIS.of_GetImportReference( ) ) THEN	
	IF (li_Seq = 2 AND ls_Type = 'D') OR (li_Seq = 3 AND ls_Type = 'P') THEN
		li_Return = THIS.of_SetAny ( "de_site", al_Value )	
	
	END IF
END IF	
	
RETURN li_Return

end function

public function boolean of_hasactivetrailercontainer ();/*
	modified to exclude UNK equipment when evaluating the assignments. This is only called from
	the event requirement object.

*/


Long		lla_PowerUnits[], &
			lla_Trailers[], &
			lla_Containers[], &
			lla_Drivers []

Int		i
Int		li_Count
String	ls_Type
long		ll_ID

			
Boolean	lb_Return = FALSE
n_Cst_AnyArraySrv			lnv_Array
n_cst_equipmentmanager	lnv_eqMan

CHOOSE CASE This.of_GetActiveAssignments ( lla_Drivers , lla_PowerUnits, lla_Trailers, lla_Containers ) 
		
	CASE 1 , 0		
		
		// we need to get rid of any chassis in the trailer array.
		
		li_Count = UpperBound ( lla_Trailers )
		FOR i = 1 TO li_Count
				
			ll_ID = lla_Trailers[i]
			
			SELECT "equipment"."eq_type"  
			INTO :ls_Type  
			FROM "equipment"  
			WHERE eq_id = :ll_ID; 
						  
			IF ls_Type = "H" THEN
				SetNull ( lla_Trailers[i] )
			END IF
			
		NEXT
		Commit;
		
		lnv_Array.of_Getshrinked( lla_Trailers ,TRUE , FALSE )
	
		IF UpperBound ( lla_Trailers ) > 0 OR UpperBound ( lla_Containers ) > 0 THEN
			lb_Return = TRUE
			IF lnv_eqMan.of_isunknownequipment( lla_Trailers ) OR lnv_eqMan.of_isunknownequipment( lla_Containers ) THEN							
				lb_Return = FALSE
			END IF
		END IF

	CASE -1
		//Error
		SetNull ( lb_Return )
	
	CASE ELSE
		//Unexpected return value
		SetNull ( lb_Return )
	
	END CHOOSE
	

RETURN lb_Return
end function

public function boolean of_hasactivetrailerchassiscontainer (boolean ab_allowunknownchassis);/*
	modified to exclude UNK equipment when evaluating the assignments. This is only called from
	the event requirement object.

*/


Long		lla_PowerUnits[], &
			lla_Trailers[], &
			lla_Containers[], &
			lla_Drivers [],&
			lla_Chassis []

Int		i
Int		li_Count
String	ls_Type
long		ll_ID

			
Boolean	lb_Return = FALSE
n_Cst_AnyArraySrv			lnv_Array
n_cst_equipmentmanager	lnv_eqMan

CHOOSE CASE This.of_GetActiveAssignments ( lla_Drivers , lla_PowerUnits, lla_Trailers, lla_Containers ) 
		
	CASE 1 , 0		
			
		li_Count = UpperBound ( lla_Trailers )
		FOR i = 1 TO li_Count
				
			ll_ID = lla_Trailers[i]
			
			SELECT "equipment"."eq_type"  
			INTO :ls_Type  
			FROM "equipment"  
			WHERE eq_id = :ll_ID; 
						  
			IF ls_Type = "H" THEN
				lla_Chassis [ UpperBound ( lla_Chassis ) + 1 ] = lla_Trailers[i]
				SetNull ( lla_Trailers[i] )
			END IF
			
		NEXT
		Commit;
		
		lnv_Array.of_Getshrinked( lla_Trailers ,TRUE , FALSE )
	
		IF UpperBound ( lla_Trailers ) > 0 OR UpperBound ( lla_Containers ) > 0 OR Upperbound ( lla_Chassis ) > 0 THEN
			lb_Return = TRUE
			IF lnv_eqMan.of_isunknownequipment( lla_Trailers ) OR lnv_eqMan.of_isunknownequipment( lla_Containers ) THEN							
				lb_Return = FALSE
			END IF
			
			IF not ab_allowunknownchassis THEN
				IF lnv_eqMan.of_isunknownequipment( lla_Chassis ) THEN
					lb_Return = FALSE
				END IF
			END IF
			
			
		END IF

	CASE -1
		//Error
		SetNull ( lb_Return )
	
	CASE ELSE
		//Unexpected return value
		SetNull ( lb_Return )
	
	END CHOOSE
	

RETURN lb_Return
end function

public function boolean of_isbobtailevent ();Boolean	lb_Return
Long		ll_Orig
Long		ll_Dest
THIS.of_GetBobtaileventids( ll_Orig, ll_Dest )
If isNull ( ll_Orig ) THEN
	ll_Orig = 0
END IF

If isNull ( ll_Dest ) THEN
	ll_Dest = 0
END IF
lb_Return = ll_Orig > 0 OR ll_Dest > 0 
RETURN lb_Return


end function

public function integer of_getbobtaileventids (ref long al_origineventid, ref long al_desteventid);Long	ll_OriginEventID
Long	ll_DestEventID
Int	li_Return

li_Return = 1
al_origineventid = This.of_GetValue ( "disp_events_BobtailOriginEvent", TypeLong! )
al_desteventid = 	This.of_GetValue ( "disp_events_BobtailDestinationEvent", TypeLong! )


RETURN li_Return
end function

public function integer of_setbobtaillocations (long al_originevent, long al_destevent);Int	li_Return
li_Return = This.of_SetAny ( "disp_events_BobtailOriginEvent", al_originevent )
li_Return = THIS.of_SetAny ( "disp_events_BobtailDestinationEvent", al_destevent )

RETURN li_Return
end function

on n_cst_beo_event.create
call super::create
end on

on n_cst_beo_event.destroy
call super::destroy
end on

event constructor;call super::constructor;of_SetKeyColumn ( "de_id" )
is_Topic = "EVENT"
is_documenttype = appeon_constant.cs_event					// RDT 092602 

end event

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "ID"
			aa_Value = This.of_GetID ( )
			
		CASE "TYPE"
			aa_Value = This.of_GetType ( )
			
		CASE "TRIPID"
			aa_Value = This.of_GetTrip ( )
			
		CASE "SITEID"
			aa_Value = This.of_GetSite ( )			
			
		CASE "APPTDATE", "SCHEDULEDDATE", "BASESCHEDULEDDATE"
			aa_Value = This.of_GetScheduledDate ( )
			
		CASE "APPTTIME", "SCHEDULEDTIME", "BASESCHEDULEDTIME"
			aa_Value = This.of_GetScheduledTime ( )
			
		CASE "APPTNUM", "APPOINTMENTNUMBER"
			aa_Value = This.of_GetAppointmentNumber ( )
			
		CASE "DATEARRIVED", "BASEDATEARRIVED"
			aa_Value = This.of_GetDateArrived ( )
			
		CASE "TIMEARRIVED", "BASETIMEARRIVED"
			aa_Value = This.of_GetTimeArrived ( )
			
		CASE "DATEDEPARTED", "BASEDATEDEPARTED"
			aa_Value = This.of_GetDateDeparted ( )
					
		CASE "TIMEDEPARTED", "BASETIMEDEPARTED"
			aa_Value = This.of_GetTimeDeparted ( )
			
		CASE "LOCALSCHEDULEDDATE"
			aa_Value = This.of_GetLocalDate ( This.of_GetScheduledDate ( ), This.of_GetScheduledTime ( ) )
			
		CASE "LOCALSCHEDULEDTIME"
			aa_Value = This.of_GetLocalTime ( This.of_GetScheduledDate ( ), This.of_GetScheduledTime ( ) )
			
		CASE "LOCALDATEARRIVED"
			aa_Value = This.of_GetLocalDate ( This.of_GetDateArrived ( ), This.of_GetTimeArrived ( ) )
			
		CASE "LOCALTIMEARRIVED"
			aa_Value = This.of_GetLocalTime ( This.of_GetDateArrived ( ), This.of_GetTimeArrived ( ) )
			
		CASE "LOCALDATEDEPARTED"
			aa_Value = This.of_GetLocalDate ( This.of_GetDateDeparted ( ), This.of_GetTimeDeparted ( ) )
					
		CASE "LOCALTIMEDEPARTED"
			aa_Value = This.of_GetLocalTime ( This.of_GetDateDeparted ( ), This.of_GetTimeDeparted ( ) )
			
		CASE "SHIPMENTID", "TMP"
			aa_Value = This.of_GetShipment ( )
			
		CASE "SHIPMENTSEQUENCE"
			aa_Value = This.of_GetShipmentSequence ( )
			
		CASE "CONFIRMED"
			aa_Value = This.of_GetConfirmed ( )
			
		CASE "WHOCONFIRMED"
			aa_Value = This.of_GetWhoConfirmed ( )
			
		CASE "DURATION"
			aa_Value = This.of_GetDuration ( )
			
		CASE "NOTE"
			aa_Value = This.of_getNote ( )

		CASE "DRIVER"
			aa_Value = This.of_GetDriver ( )

		CASE "POWERUNIT"
			aa_Value = This.of_GetPowerUnit ( )

		CASE "TRAILERLIST"
			aa_Value = This.of_GetTrailerList ( )

		CASE "CONTAINERLIST"
			aa_Value = This.of_GetContainerList ( )
			
		CASE "FREIGHTSPLIT"
			aa_Value = This.of_GetFreightSplit ( )
			
		CASE "ACCESSORIALSPLIT"
			aa_Value = This.of_GetAccessorialSplit ( )
			
		CASE "REFERENCE"
			aa_Value = 	This.of_GetReference ( )
			
		CASE "IMPORTREFERENCE"
			aa_Value = THIS.of_Getimportreference( )
			
		CASE "EARLIESTDATE"
			aa_Value = This.of_Getearliestdate( )
		
		CASE "EARLIESTTIME"
			aa_Value = This.of_Getearliesttime( )
			
		CASE "LATESTTDATE", "LATESTDATE"
			aa_Value = This.of_GetLatestdate( )
			
		CASE "LATESTTIME"
			aa_Value = This.of_GetLatesttime( )
			
		CASE "SITEID" , "SITEBYALIAS" // alias used by edi
			aa_Value = This.of_getSite ( )
			
		CASE ELSE
			
			li_Return = 0
	END CHOOSE

END IF

RETURN li_Return
end event

event ue_getobject;call super::ue_getobject;//Extending Ancestor to provide object support for this class.

//See ancestor script for explanation of return codes.

Integer	li_Return
Long		ll_CompanyId
Any		laa_Beo[]
n_cst_beo_Company		lnv_Company
n_cst_beo_Shipment	lnv_Shipment

n_Cst_beo_Item	lnva_Items[]
n_cst_beo_Item	lnva_Temp[]
Int	li_ShipSeq
Int	i
Int	li_Count
Int	li_Index
li_Return = AncestorReturnValue
aaa_Beo = laa_Beo


IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_ObjectName ) )

	CASE "SITE"
		
		CHOOSE CASE This.of_GetSite ( lnv_Company, TRUE )
				
			CASE 1  //Request resolved successfully.
				aaa_Beo [ 1 ] = lnv_Company
			CASE 0  //Site is not specified (null).
				//Leave the array empty, but return 1
			CASE ELSE
				li_Return = -1
				
		END CHOOSE

	CASE "SHIPMENT"
		
		IF IsValid ( inv_Shipment ) THEN
			IF This.inv_Shipment.of_HasSource ( ) THEN
				lnv_shipment = create n_cst_beo_shipment
				lnv_shipment.of_Setsource(inv_shipment.of_getsource())
				lnv_shipment.of_setsourceid(inv_shipment.of_getid())
				lnv_shipment.of_seteventsource(inv_shipment.of_getEventsource())
				lnv_shipment.of_setitemsource(inv_shipment.of_getItemsource())
				aaa_Beo [ 1 ] = lnv_Shipment
			END IF
		ELSE
			IF This.of_HasShipment ( ) THEN
				//The event is part of a shipment, but we don't have a handle to it.
				li_Return = -1
			ELSE
				//The event is not part of a shipment.
				//Leave the array empty, but return 1
			END IF
		END IF
		
		
		
	CASE "PUITEMS"
		
		li_ShipSeq = THIS.of_getShipseq( )
		IF IsValid ( inv_Shipment ) THEN
			li_Count = inv_Shipment.of_GetItemlist( lnva_Temp )
			FOR i = 1 TO li_Count
				IF lnva_Temp[i].of_GetPickupevent( ) = li_ShipSeq THEN
					li_Index ++ 
					lnva_Items[li_Index] = lnva_Temp[i]
				ELSE
					DESTROY ( lnva_Temp[i] )
				END IF
			NEXT
		END IF
		aaa_beo[]= lnva_Items
		
	CASE "DELITEMS"
		
		
		li_ShipSeq = THIS.of_getShipseq( )
		IF IsValid ( inv_Shipment ) THEN
			li_Count = inv_Shipment.of_GetItemlist( lnva_Temp )
			FOR i = 1 TO li_Count
				IF lnva_Temp[i].of_getdeliverevent( ) = li_ShipSeq THEN
					li_Index ++ 
					lnva_Items[li_Index] = lnva_Temp[i]
				ELSE
					DESTROY ( lnva_Temp[i] )
				END IF
			NEXT
		END IF
		aaa_beo[]= lnva_Items
		
	CASE "ACCITEMFOREVENT"	
		li_ShipSeq = THIS.of_getShipseq( )
		IF IsValid ( inv_Shipment ) THEN
			li_Count = inv_Shipment.of_GetItemlist( lnva_Temp, "A" )
			FOR i = 1 TO li_Count
				IF lnva_Temp[i].of_getpickupevent( ) = li_ShipSeq THEN
					li_Index ++ 
					lnva_Items[li_Index] = lnva_Temp[i]
				ELSE
					DESTROY ( lnva_Temp[i] )
				END IF
			NEXT
		END IF
		aaa_beo[]= lnva_Items
		
	CASE ELSE
		li_Return = 0
		
	
			
			
			
	END CHOOSE

END IF

RETURN li_Return
end event

event ue_getstringformat;call super::ue_getstringformat;// Extending Ancestor Script.

// Returns: -1 = Error
//           0 = Requested attribute format not found
//           1 = Success

Int li_Return

li_Return = AncestorReturnValue 

IF li_Return = 0 THEN
	
	li_Return = 1 //Changed back later if no match is found.

	CHOOSE CASE  UPPER( Trim ( as_attribute ) ) 
			
		CASE "APPTDATE", "SCHEDULEDDATE", "DATEARRIVED" 
			as_Format = "m/d/yy"
			
		CASE "APPTTIME", "SCHEDULEDTIME", "TIMEARRIVED", "TIMEDEPARTED"
			as_Format = "h:mm am/pm"
			
		CASE "DURATION"
			as_Format = "h:mm"
			
		CASE "FREIGHTSPLIT", "ACCESSORIALSPLIT"
			as_Format = "0.00##"
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE
END IF 

RETURN li_Return
end event

event ue_formatvalue;call super::ue_formatvalue;// Extending Ancestor Script.

// Returns: -1 = Error
//           0 = Requested attribute format not found
//           1 = Success

n_cst_Events	lnv_Events
String			ls_DataValue

Int li_Return

li_Return = AncestorReturnValue 

IF li_Return = 0 THEN
	
	li_Return = 1 //Changed back later if no match is found.

	CHOOSE CASE  UPPER( Trim ( as_attribute ) ) 
			
		CASE "TYPE"

			//Cast the aa_Value to a string
			ls_DataValue = Upper ( Trim ( String ( aa_Value ) ) )

			//Make sure the datavalue is a one-character string
			IF Len ( ls_DataValue ) < 2 THEN  //1 or 0 characters
				//Use the event service to get the formatted value.
				as_FormattedValue = lnv_Events.of_GetTypeDisplayValue ( Char ( ls_DataValue ) )
				IF IsNull ( as_FormattedValue ) THEN
					as_FormattedValue = ""
				END IF
			ELSE
				as_FormattedValue = ""
			END IF
			
		CASE "CONFIRMED"
			
			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.
			
				CASE "T"
					as_FormattedValue = "CONFIRMED"
					
				CASE "F"
					as_FormattedValue = "UNCONFIRMED"
				
				CASE ELSE //Unexpected Value, including null.
					as_FormattedValue = ""
					
			END CHOOSE
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE
END IF 

RETURN li_Return
end event

event ue_setvalueany;call super::ue_setvalueany;Int	li_Return 

IF Len ( as_attribute ) = 0 AND  Len ( String ( aa_value ) ) = 0 THEN
	RETURN 1 // so we can check that the event exists w. a 'triggerevent' call
END IF


CHOOSE CASE Upper ( as_attribute )
		
	CASE "IMPORTREFERENCE"
		li_Return = THIS.of_setimportreference( Long ( aa_Value ) )
		
		
	CASE "SITEBYREF"
		li_Return = THIS.of_SetSiteByRef ( String ( aa_value ) ) 
		
	CASE "TYPE"
		li_Return = This.of_SetType ( String ( aa_value ) )
		
	CASE "TRIPID"
		//li_Return = This.of_SetTripID ( Long ( aa_value ) )
		
	CASE "SITEID" , "SITEBYALIAS" // alias used by edi
		li_Return = This.of_SetSite ( Long ( aa_value ) )	
		
	CASE "CROSSDOCKID"  // S.A.T. 6/26/06
		li_Return = This.of_SetCrossDock ( Long ( aa_value ) )
		
	CASE "APPTDATE", "SCHEDULEDDATE", "BASESCHEDULEDDATE"
		li_Return = This.of_SetScheduledDate ( Date ( aa_value ) )
		
	CASE "APPTTIME", "SCHEDULEDTIME", "BASESCHEDULEDTIME"
		li_Return = This.of_SetScheduledTime (Time ( aa_value ) )
		
	CASE "APPTNUM", "APPOINTMENTNUMBER"
		li_Return = This.of_SetAppointmentNumber ( String ( aa_value ) )
		
	CASE "DATEARRIVED", "BASEDATEARRIVED"
		li_Return = This.of_SetDateArrived ( Date ( aa_value )  )
		
	CASE "TIMEARRIVED", "BASETIMEARRIVED"
		li_Return = This.of_SetTimeArrived ( Time ( aa_Value) )
		
	CASE "DATEDEPARTED", "BASEDATEDEPARTED"
//		li_Return = This.of_SetDateDeparted ( Date ( aa_value )  )
				
	CASE "TIMEDEPARTED", "BASETIMEDEPARTED"
		li_Return = This.of_SetTimeDeparted ( Time ( aa_value ) )
		
	CASE "LOCALSCHEDULEDDATE"
		li_Return =  This.of_SetScheduledDate ( Date ( aa_value )  )
		
	CASE "LOCALSCHEDULEDTIME"
		li_Return =  This.of_SetScheduledTime ( Time ( aa_value )  )
		
	CASE "LOCALDATEARRIVED"
	//	li_Return = This.of_SetDateArrived ( Date ( aa_value ) )
		
	CASE "LOCALTIMEARRIVED"
	//	li_Return =  This.of_SetTimeArrived ( Time ( aa_value ) ) )
		
	CASE "LOCALDATEDEPARTED"
	//	li_Return =  This.of_SetDateDeparted ( ), This.of_SetTimeDeparted ( ) )
				
	CASE "LOCALTIMEDEPARTED"
	//	li_Return = This.of_SetLocalTime ( This.of_SetDateDeparted ( ), This.of_SetTimeDeparted ( ) )
		
	CASE "SHIPMENTID", "TMP"
		li_Return = This.of_SetShipment ( Long ( aa_value )  )
		
	CASE "SHIPMENTSEQUENCE"
	//	li_Return = This.of_SetShipmentSequence ( Long ( aa_value )  )
		
	CASE "CONFIRMED"
		li_Return = This.of_SetConfirmed ( Upper ( String ( aa_value ) ) )
		
	CASE "WHOCONFIRMED"
		//li_Return = This.of_SetWhoConfirmed ( String (aa_value ) )
		
	CASE "DURATION"
//		li_Return = This.of_SetDuration ( Dec ( aa_value ) )
		
	CASE "NOTE"
		li_Return = This.of_SetNote ( Upper ( String ( aa_value ) ) )

	CASE "DRIVER"
//		li_Return = This.of_SetDriver ( Long ( aa_value ) )

	CASE "POWERUNIT"
	//	li_Return = This.of_SetPowerUnit ( Long ( aa_value )  )

	CASE "TRAILERLIST"
	//	li_Return = This.of_SetTrailerList ( )

	CASE "CONTAINERLIST"
	//	li_Return = This.of_SetContainerList ( )
		
	CASE "FREIGHTSPLIT"
	//	li_Return = This.of_SetFreightSplit ( Decimal ( aa_value )  )
		
	CASE "ACCESSORIALSPLIT"
//		li_Return = This.of_SetAccessorialSplit ( )
		
	CASE "REFERENCE"
		li_Return = This.of_SetReference ( Upper ( String ( aa_value ) ) )
		
	CASE "EARLIESTDATE"
		li_Return = This.of_setearliestdate( date ( aa_value ) ) 
		
	CASE "EARLIESTTIME"
		li_Return = This.of_setearliesttime( time ( aa_value ) )
		
	CASE "LATESTDATE"
		li_Return = This.of_setLatestdate( date ( aa_value ) ) 
		
	CASE "LATESTTIME"
		li_Return = This.of_setLatesttime( time ( aa_value ) )

		
	CASE "UNKCNTN"
		li_Return = THIS.of_ReplaceUnknownEquipment ( "CONTAINER" , Upper ( String ( aa_value ) ) )
	
	CASE "UNKCHAS"
		li_Return = THIS.of_ReplaceUnknownEquipment ( "CHASSIS" , Upper ( String ( aa_value ) ) )
		
	CASE "UNKTRLR"
		li_Return = THIS.of_ReplaceUnknownEquipment ( "TRAILER" , Upper ( String ( aa_value ) ) )
		
	CASE "UNKRBOX"
		li_Return = THIS.of_ReplaceUnknownEquipment ( "RAILBOX" , Upper ( String ( aa_value ) ) )
		
	CASE ELSE
		
		li_Return = 0
		
		String	ls_ObjName
		String	ls_Attrib
		Int		li_Pos
		
		n_cst_beo_Shipment	lnv_Shipment
		
		IF POS ( as_attribute , '.' ) > 0 THEN
			
			ls_ObjName = Mid ( as_attribute , 1 , POS ( as_attribute , '.' )  - 1)
			
			IF ls_ObjName = "SHIP" THEN
				ls_Attrib = Mid ( as_attribute , POS ( as_attribute , '.' ) + 1 , Len ( as_attribute ) )
				THIS.of_Getshipment( lnv_Shipment )
				IF isValid ( lnv_Shipment ) THEN
				 li_Return =	lnv_Shipment.Event ue_SetValueAny ( ls_Attrib , aa_value )
				END IF
				
			END IF
			
		END IF
	
END CHOOSE

RETURN li_Return
end event

