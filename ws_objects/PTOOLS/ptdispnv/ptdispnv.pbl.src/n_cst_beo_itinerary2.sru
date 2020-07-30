$PBExportHeader$n_cst_beo_itinerary2.sru
forward
global type n_cst_beo_itinerary2 from pt_n_cst_beo
end type
end forward

global type n_cst_beo_itinerary2 from pt_n_cst_beo
end type
global n_cst_beo_itinerary2 n_cst_beo_itinerary2

type variables
Protected n_cst_bso_Dispatch	inv_Dispatch
Protected DataStore	ids_EventCache
Protected DataStore	ids_ShipmentStopData

//This is used to record shipments that should be excluded
//from calculations like of_GetShipmentCount or 
//of_GetTotalWeight, because the script using the itinerary
//object knows they've already been counted in another
//pass.  
Protected Long	ila_ExcludedShipments[]

//These are used to record the row range once it's set.
//They are initialized to null in the constructor.
Protected Long	il_FirstEventRow
Protected Long	il_LastEventRow
Protected Long	il_PriorEventRow

//These are used to record the start and end date of the
//requested range, regardless of the day that the first and
//last event happens to fall on.  They are initialized to null
//in the constructor.
Protected Date	id_Start
Protected Date	id_End

//These are used to record the type and id for the range.
//They are initialized to null in the constructor.
Protected Integer	ii_ItinType
Protected Long	il_ItinId

//This flag is set if it's determined there are zero rows
//in an otherwise legitimate range, so that computations
//can avoid unnecessary overhead where possible.
Protected Boolean	ib_NoRowsInRange = FALSE

Protected n_cst_Trip	inv_Trip
Protected Boolean		ib_DestroyTripOnDestroy = TRUE

Protected Boolean		ib_DiscardOptional = FALSE
Protected Long		il_RouteType /*Init. to null*/

//These values are initialized to null in constructor, and reset
//to null when the range is changed.
Protected Decimal {2}	ic_FreightRevenue
Protected Decimal {2}	ic_Payables



n_cst_beo_event	inva_NextEvents[]
n_cst_beo_event	inva_Events[]
n_cst_beo_event	inva_LastConfirmedEvents[]


boolean	ib_NextCached
boolean	ib_EventsCached
boolean	ib_LastConfirmedCached
end variables

forward prototypes
public function integer of_seteventcache (datastore ads_eventcache)
public function datastore of_geteventcache ()
public function integer of_setdispatchmanager (n_cst_bso_dispatch anv_dispatch)
public function integer of_getfirsteventrow (ref long al_row)
public function integer of_getlasteventrow (ref long al_row)
public function integer of_getfirstlasteventrow (ref long al_firsteventrow, ref long al_lasteventrow)
public function integer of_gettrip (ref n_cst_trip anv_trip, boolean ab_createifneeded)
public function integer of_inittrip (ref n_cst_msg anv_msg)
public function integer of_gettrip (ref n_cst_trip anv_trip)
public function decimal of_gettotalmiles ()
public function decimal of_getloadedmiles ()
public function decimal of_getemptymiles ()
public function decimal of_getbobtailmiles ()
public function decimal of_getdeadheadmiles ()
public function long of_geteventtypecount (string as_type)
public function long of_getpickupcount ()
public function long of_getdeliverycount ()
public function long of_gethookcount ()
public function long of_getdropcount ()
public function long of_getmountcount ()
public function long of_getdismountcount ()
public function decimal of_getshipmentcount ()
public function long of_getstopcount ()
public function long of_getstopoffcount ()
public function long of_getworkingstopcount ()
public function decimal of_gettotalweight ()
public function n_cst_bso_dispatch of_getdispatchmanager ()
public function decimal of_getfreightrevenue ()
public function long of_getshipmentids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes)
public function long of_setrange (n_cst_msg anv_msg)
public function long of_getshipmentstopdata (ref datastore ads_data)
public function decimal of_getitineraryhourstotal ()
public function long of_getdriverids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes)
public function string of_getdriverlist ()
public function string of_getpowerunitlist ()
public function long of_getpowerunitids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes)
public function date of_getstartdate ()
public function date of_getenddate ()
public function integer of_getitintype ()
public function long of_getitinid ()
public function string of_getitineraryfor ()
public function integer of_istripopen (long al_row, ref boolean ab_open)
public function long of_getexcludedshipments (ref long ala_excludedshipments[])
public function long of_getshipmentids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes, boolean ab_useexclude)
public function decimal of_getshipmentcount (boolean ab_useexclude)
public function decimal of_gettotalweight (boolean ab_useexclude)
public function long of_appendexcludedshipments (long ala_ids[])
public function long of_setexcludedshipments (long ala_ids[])
public function integer of_clearexcludedshipments ()
protected function integer of_markshipmentstopdataexcluded ()
public function long of_appendexcludedshipmentsforrange ()
public function long of_geteventcount ()
public function string of_getshipmentlist (boolean ab_useexclude)
public function decimal of_getpayables ()
public function long of_geteventids (ref long ala_ids[])
public function long of_getlocationoptionalcount ()
public function string of_getoriginlocation ()
public function string of_getdestinationlocation ()
public function long of_gettrailerids (ref long ala_ids[], boolean ab_shrinkdupes)
public function long of_getcontainerids (ref long ala_ids[], boolean ab_shrinkdupes)
public function string of_gettrailerlist ()
public function string of_getcontainerlist ()
public function integer of_setdiscardoptional (boolean ab_value)
public function integer of_setroutetype (long al_value)
public function integer of_setdestroytripondestroy (boolean ab_switch)
public function integer of_geteventlist (ref n_cst_beo_event anva_beo[])
public function integer of_getnexteventlist (ref n_cst_beo_event anva_beo[])
public function integer of_getlastconfirmedevent (ref n_cst_beo_event anva_event[])
public function string of_getpowerunitnotes ()
public function string of_gettrailernotes ()
public function string of_getcontainernotes ()
public function long of_getlastconfirmedeventrow ()
public function string of_getlastconfirmeddriver ()
public function boolean of_validateeventid (long al_eventid)
private function integer of_destroy (ref n_cst_beo_Event anva_Events[])
public function integer of_getshipmenttypes (ref long ala_types[])
public function long of_getshipment (ref n_cst_beo_shipment anva_shipment[])
public function integer of_getshipmenttypes (n_cst_beo_shipment anva_shipment[], ref long ala_types[])
public function long of_getshipment (long ala_id[], ref n_cst_beo_shipment anva_shipment[])
public subroutine of_reseteventlist ()
public function integer of_geteventlist (ref n_cst_beo_event anva_event[], boolean ab_useexclude)
public function long of_getshipmentstopdata (ref datastore ads_data, boolean ab_payables)
public function decimal of_getfreightrevenue (boolean ab_payable)
public function decimal of_gettotalweight (boolean ab_useexclude, boolean ab_payables)
public function integer of_resetstopdata ()
public function integer of_getshipmenttypes (long ala_id[], ref long ala_types[])
end prototypes

public function integer of_seteventcache (datastore ads_eventcache);//Returns: 1, -1

Integer	li_Return = 1

ids_EventCache = ads_EventCache

RETURN li_Return
end function

public function datastore of_geteventcache ();RETURN ids_EventCache
end function

public function integer of_setdispatchmanager (n_cst_bso_dispatch anv_dispatch);//Returns : 1, -1

Integer	li_Return = 1

inv_Dispatch = anv_Dispatch

IF IsValid ( anv_Dispatch ) THEN

	//Call of_CacheEventCompanies, in order to ensure that all companies 
	//referenced in events are cached.
	anv_Dispatch.of_CacheEventCompanies ( )

	//Set the event cache
	This.of_SetEventCache ( anv_Dispatch.of_GetEventCache ( ) )

END IF

RETURN li_Return
end function

public function integer of_getfirsteventrow (ref long al_row);//Returns : 1 = Row successfully identified, and it's in the primary buffer.
// 0 = No rows in range flag has been set, so there is no firsteventrow, 
// -1 = : Above conditions not met.
//Row number passed out in al_Row if successful, al_Row set to null if returning 0 or -1.

Integer	li_Return = -1
SetNull ( al_Row )

IF ib_NoRowsInRange THEN
	li_Return = 0
ELSEIF il_FirstEventRow > 0 THEN
	al_Row = il_FirstEventRow
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_getlasteventrow (ref long al_row);//Returns : 1 = Row successfully identified, and it's in the primary buffer.
// 0 = No rows in range flag has been set, so there is no lasteventrow, 
// -1 = : Above conditions not met.
//Row number passed out in al_Row if successful, al_Row set to null if returning 0 or -1.

Integer	li_Return = -1
SetNull ( al_Row )

IF ib_NoRowsInRange THEN
	li_Return = 0
ELSEIF il_LastEventRow > 0 THEN
	al_Row = il_LastEventRow
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_getfirstlasteventrow (ref long al_firsteventrow, ref long al_lasteventrow);//Returns : 1 = Both rows successfully identified, they're in the primary buffer, 
// and the last row is >= the first row.   
//  0 = No rows in range flag has been set, so there is no firsteventrow, 
// -1 = : Above conditions not met.
//Row numbers passed out in al_FirstEventRow and al_LastEventRow if successful, 
//both reference values set to null if returning 0 or -1.


Integer	li_Return = 1

IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetFirstEventRow ( al_FirstEventRow )
	
	CASE 1
		//OK
	
	CASE 0  //No rows in range
		li_Return = 0
		
	CASE ELSE
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetLastEventRow ( al_LastEventRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		li_Return = 0

	CASE ELSE
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN
	IF al_LastEventRow < al_FirstEventRow THEN
		li_Return = -1
	END IF
END IF

IF li_Return < 1 THEN
	SetNull ( al_FirstEventRow )
	SetNull ( al_LastEventRow )
END IF

RETURN li_Return
end function

public function integer of_gettrip (ref n_cst_trip anv_trip, boolean ab_createifneeded);//Returns : 1 = Valid Trip Available, Passed out by ref, -1 = Trip Not Available

//This version of of_GetTrip should generally be used to re-reference an already 
//initialized trip, not to initialize a new trip.

//Although this version of the function will initialize a trip with default options, 
//you should usually call of_InitTrip with the message object to initialize the trip.
//With that version, explanatory information is available if there's a problem with
//stops or locators, which is not available here.  If you don't want to set any options
//with that version, just pass in an empty message object, as we do here.

n_cst_Msg	lnv_Msg
n_cst_Trip	lnv_Trip

Integer	li_Return = -1

IF IsValid ( inv_Trip ) THEN
	//No action necessary
ELSEIF ab_CreateIfNeeded THEN
	This.of_InitTrip ( lnv_Msg )
END IF

IF IsValid ( inv_Trip ) THEN
	li_Return = 1
END IF

anv_Trip = inv_Trip

RETURN li_Return
end function

public function integer of_inittrip (ref n_cst_msg anv_msg);//Return Values : 1 = Successfully built trip, 0 = Trip is known to have at least one bad locator, 
//-1 = Error

//Note : If there are no rows in the itinerary range, this function will NOT currently populate
//a prior stop into the trip, even if there is one.  The trip will be empty.

//If it's a driver itinerary, stops will have CalcNext set to false between END TRIP and NEW TRIP,
//since we don't want to calculate mileage between end of one trip and beginning of the next one.
//Extra stops between END TRIP and NEW TRIP will be omitted (as will previous event, if a trip is 
//not open at the first event.)

//List of valid inbound parameters to anv_Msg :
//"DiscardOptional"		Boolean		Optional		If not specified, ib_DiscardOptional value will
//																be used.  If that's null, FALSE will be used.
//"RouteType"				Long			Optional		If not specified, il_RouteType value will be used.
//																If that's null, the System Default will be used.

//List of outbound parameters that this function may add to anv_Msg :
//"Ids"						Long Array	Company Ids with missing locators
//"Dates"					Date Array	List of dates that have events with null sites
//"Origin"					String		PCM Locator for the trip origin (which may be the prior event)
//"Destination"			String		PCM Locator for the trip desination

n_cst_Trip	lnv_Trip
n_cst_beo_Event	lnv_Event
Long			ll_EventCount, &
				ll_Row, &
				ll_StopIndex
s_Parm		lstr_Parm
n_cst_bso	lnv_Context
String		ls_Stop
Long			lla_BadLocators[]
Date			lda_BadDates[] 
Long			ll_TempCoId
String		ls_Origin
String		ls_Destination

Boolean		lb_DiscardOptionalLocations, &
				lb_LocationOptional, &
				lb_NoRows, &
				lb_TripOpen, /*Only used when lb_Driver = TRUE*/ &
				lb_Driver 	//Flag to indicate whether this is a driver itinerary, which triggers
								//Driver-specific trip definition, described above.
DataStore	lds_EventCache
Long			ll_FirstRow, &
				ll_LastRow
DWBuffer		le_Buffer
DWObject		ldwo_Site, &
				ldwo_Pcm, &
				ldwo_Type

Integer	li_Return = 1

lnv_Event = CREATE n_cst_beo_Event

//If there's an existing trip instance, destroy it.

IF IsValid ( inv_Trip ) THEN
	DESTROY inv_Trip
END IF

SetNull ( ls_Origin )


IF li_Return = 1 THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		lnv_Event.of_SetSource ( lds_EventCache )
		ldwo_Type = lds_EventCache.Object.de_Event_Type
		ldwo_Site = lds_EventCache.Object.de_Site
		ldwo_Pcm = lds_EventCache.Object.co_Pcm
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF This.of_GetItinType ( ) = gc_Dispatch.ci_ItinType_Driver THEN
		lb_Driver = TRUE
	END IF

END IF


IF li_Return = 1 THEN

	IF anv_Msg.of_Get_Parm ( "DISCARDOPTIONAL" , lstr_parm ) > 0 THEN
		lb_discardOptionalLocations = lstr_Parm.ia_Value
		IF IsNull ( lb_DiscardOptionalLocations ) THEN
			li_Return = -1
		END IF
	ELSEIF NOT IsNull ( ib_DiscardOptional ) THEN
		lb_DiscardOptionalLocations = ib_DiscardOptional
	//ELSE
		//Keep default of FALSE
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Trip = CREATE n_cst_Trip
	
	IF anv_Msg.of_Get_Parm ( "RouteType", lstr_Parm ) > 0 THEN
		lnv_Trip.of_SetRouteType ( lstr_Parm.ia_Value )
	ELSEIF NOT IsNull ( il_RouteType ) THEN
		lnv_Trip.of_SetRouteType ( il_RouteType )
	//ELSE
		//Allow the trip to use the system default
	END IF

END IF
	
	
IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		lb_NoRows = TRUE

	CASE ELSE
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_NoRows = FALSE AND lb_Driver = TRUE THEN

	CHOOSE CASE This.of_IsTripOpen ( ll_FirstRow, lb_TripOpen )

	CASE 1 //Value successfully determined
		//No action needed

	CASE 0 //Could not definitively determine whether open or not, but not due to error
		//Assume open
		lb_TripOpen = TRUE

	CASE ELSE //-1 = Error, or unexpected value
		li_Return = -1

	END CHOOSE

END IF


//If appropriate, add prior event to the trip.
//Note : If no rows in range, prior event will NOT be added.
//Note : If this is a driver itinerary and a trip is not open at the first event, 
//prior event will NOT be added.

IF li_Return = 1 AND lb_NoRows = FALSE AND NOT ( lb_Driver AND lb_TripOpen = FALSE ) THEN  

	//Add the stop for the prior event, if there is one.  Do not use the location of the event if the
	//event's type is a LocationOptional type and the flag was set to discard the optional.

	FOR ll_Row = ll_FirstRow - 1 TO 1 STEP -1

		ls_Stop = "" 
		ll_TempCoID = 0

		lnv_Event.of_SetSourceRow ( ll_Row )
		
		lb_LocationOptional = lnv_Event.of_IsLocationOptional ( )

		IF lb_DiscardOptionalLocations AND lb_LocationOptional THEN
			//Event is location optional, and we don't want location optional events
			//in the trip, even if they have locators.  So, skip it.
			CONTINUE
		END IF
		

		ll_TempCoId = ldwo_Site.Primary [ ll_Row ]

		IF IsNull ( ll_TempCoId ) THEN

			IF lb_LocationOptional THEN
				//The event does not have a site assigned, and the event is LocationOptional.
				//Skip over it.  (Note: This will NOT skip over LocationOptional events that
				//have sites assigned, but those sites have bad locators.  Those will be flagged, below.)
				CONTINUE
			END IF

		ELSE

			ls_Stop = ldwo_Pcm.Primary [ ll_Row ]

		END IF

		
		IF isNull ( ls_Stop ) OR Len ( ls_Stop ) = 0 THEN // if the pcm is bad 

			ls_Stop = ""
			li_Return = 0

			//record the co id to give to anyone who may care
			IF isNull ( ll_TempCoID ) OR ll_TempCoID = 0 THEN // record the date since that is the best data we can provide
				lda_BadDates [ UpperBound ( lda_BadDates ) + 1 ] = lnv_Event.of_getDateArrived ( )
			ELSE
				lla_BadLocators[ upperBound( lla_BadLocators ) + 1 ] = ll_TempCoID
			END IF

		END IF

		ll_StopIndex = lnv_Trip.of_AddStop ( ls_Stop )

		//Set the stop type flag according to the event type

		CHOOSE CASE ldwo_Type.Primary [ ll_Row ]

		CASE gc_Dispatch.cs_EventType_Bobtail
			lnv_Trip.of_SetBobtail ( ll_StopIndex )

		CASE gc_Dispatch.cs_EventType_Deadhead
			lnv_Trip.of_SetDeadhead ( ll_StopIndex )

		CASE ELSE
			lnv_Trip.of_SetLoaded ( ll_StopIndex )

		END CHOOSE
		

		IF IsNull ( ls_Origin ) THEN
			ls_Origin = ls_Stop
		END IF

		//Set the row we've determined is the prior event to the instance variable.
		il_PriorEventRow = ll_Row

		EXIT

	NEXT

END IF



IF li_Return = 1 AND lb_NoRows = FALSE THEN

	FOR ll_Row = ll_FirstRow TO ll_LastRow
		
		ls_Stop = "" 
		ll_TempCoID = 0

		IF lb_Driver THEN
			IF lb_TripOpen THEN
				IF ldwo_Type.Primary [ ll_Row ] = gc_Dispatch.cs_EventType_EndTrip THEN
					//Flag that trip is closed (after this event.)
					lb_TripOpen = FALSE
				END IF
			ELSE
				//Trip is not open now.  Jump ahead to where the next trip starts (if there is one.)
				ll_Row = lds_EventCache.Find ( "de_event_type = 'O'", ll_Row, ll_LastRow )
				IF ll_Row > 0 THEN
					//Found the start of the next trip.  Flag that we're open (after this event), and proceed.
					lb_TripOpen = TRUE
				ELSE
					//No more trips open within the range.  No more stops to be added.
					EXIT
				END IF
			END IF
		END IF

		lnv_Event.of_SetSourceRow ( ll_Row )
		
		lb_LocationOptional = lnv_Event.of_IsLocationOptional ( )

		IF lb_DiscardOptionalLocations AND lb_LocationOptional THEN
			//Event is location optional, and we don't want location optional events
			//in the trip, even if they have locators.  So, skip it.
			CONTINUE
		END IF
		

		ll_TempCoId = ldwo_Site.Primary [ ll_Row ]

		IF IsNull ( ll_TempCoId ) THEN

			IF lb_LocationOptional THEN
				//The event does not have a site assigned, and the event is LocationOptional.
				//Skip over it.  (Note: This will NOT skip over LocationOptional events that
				//have sites assigned, but those sites have bad locators.  Those will be flagged, below.)
				CONTINUE
			END IF

		ELSE

			ls_Stop = ldwo_Pcm.Primary [ ll_Row ]

		END IF
		
		IF isNull ( ls_Stop ) OR Len ( ls_Stop ) = 0 THEN // if the pcm is bad 

			ls_Stop = ""
			li_Return = 0

			//record the co id to give to anyone who may care
			IF isNull ( ll_TempCoID ) OR ll_TempCoID = 0 THEN // record the date since that is the best data we can provide
				lda_BadDates [ UpperBound ( lda_BadDates ) + 1 ] = lnv_Event.of_getDateArrived ( )
			ELSE
				lla_BadLocators[ upperBound( lla_BadLocators ) + 1 ] = ll_TempCoID
			END IF

		END IF

		ll_StopIndex = lnv_Trip.of_AddStop ( ls_Stop )

		//Set the stop type flag according to the event type

		CHOOSE CASE ldwo_Type.Primary [ ll_Row ]

		CASE gc_Dispatch.cs_EventType_Bobtail
			lnv_Trip.of_SetBobtail ( ll_StopIndex )

		CASE gc_Dispatch.cs_EventType_Deadhead
			lnv_Trip.of_SetDeadhead ( ll_StopIndex )

		CASE ELSE
			lnv_Trip.of_SetLoaded ( ll_StopIndex )

		END CHOOSE

		//If we're loading the trip for a driver, and we're between END TRIP and NEW TRIP, turn the mileage
		//calculations off for the upcoming leg.
		IF lb_Driver THEN
			IF lb_TripOpen = FALSE THEN
				lnv_Trip.of_SetCalcNext ( ll_StopIndex, FALSE )
			END IF
		END IF

		IF IsNull ( ls_Origin ) THEN
			ls_Origin = ls_Stop
		END IF
		
	NEXT

	ls_Destination = ls_Stop

END IF


CHOOSE CASE li_Return

CASE 1, 0
	inv_Trip = lnv_Trip

CASE ELSE
	DESTROY lnv_Trip

END CHOOSE


IF UpperBound ( lla_BadLocators ) > 0 THEN
	lstr_Parm.is_Label = "IDS"
	lstr_Parm.ia_Value = lla_BadLocators
	anv_msg.of_Add_Parm ( lstr_Parm )
END IF
	
IF UpperBound ( lda_BadDates ) > 0 THEN
	lstr_Parm.is_Label = "DATES"
	lstr_Parm.ia_Value = lda_BadDates
	anv_msg.of_Add_Parm ( lstr_Parm )
END IF


//Prevent set of null value to any variable in lstr_Parm -- it won't take.
IF IsNull ( ls_Origin ) THEN
	ls_Origin = ""
END IF

lstr_Parm.is_Label = "ORIGIN"
lstr_Parm.ia_Value = ls_Origin
anv_msg.of_Add_Parm ( lstr_Parm )


//Prevent set of null value to any variable in lstr_Parm -- it won't take.
IF IsNull ( ls_Destination ) THEN
	ls_Destination = ""
END IF

lstr_Parm.is_Label = "DESTINATION"
lstr_Parm.ia_Value = ls_Destination
anv_msg.of_Add_Parm ( lstr_Parm )

DESTROY ldwo_Type
DESTROY ldwo_Site
DESTROY ldwo_Pcm
DESTROY ( lnv_Event ) 


RETURN li_Return
end function

public function integer of_gettrip (ref n_cst_trip anv_trip);//Passes out the trip, if it's been created.  If it hasn't, this won't create it.
//If you want to CreateIfNeeded, use the overloaded version of the function, 
//or of_InitTrip  (of_InitTrip is the preferred approach, because it provides 
//more feedback if the trip couldn't be created properly.)

Integer	li_Return = 1

IF IsValid ( inv_Trip ) THEN
	anv_Trip = inv_Trip
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function decimal of_gettotalmiles ();//Caclulate the total miles for the itinerary.  If the trip has not
//previously been initialized with of_InitTrip, it will be initialized
//through of_GetTrip with default settings.  It is generally recommended
//that you initailize the trip yourself, though, to ensure intended settings
//are applied.

n_cst_Trip	lnv_Trip
Decimal	lc_Distance
Long		ll_Minutes
Boolean	lb_Success

IF This.of_GetTrip ( lnv_Trip, TRUE /*CreateIfNeeded*/ ) = 1 THEN

	IF lnv_Trip.of_Calculate ( lc_Distance, ll_Minutes ) THEN
		lb_Success = TRUE
	END IF

END IF


IF NOT lb_Success THEN
	SetNull ( lc_Distance )
END IF


RETURN lc_Distance
end function

public function decimal of_getloadedmiles ();//Caclulate the loaded miles for the itinerary.  If the trip has not
//previously been initialized with of_InitTrip, it will be initialized
//through of_GetTrip with default settings.  It is generally recommended
//that you initailize the trip yourself, though, to ensure intended settings
//are applied.

n_cst_Trip	lnv_Trip
Decimal	lc_Distance
Long		ll_Minutes
Boolean	lb_Success

IF This.of_GetTrip ( lnv_Trip, TRUE /*CreateIfNeeded*/ ) = 1 THEN

	IF lnv_Trip.of_GetLoaded ( lc_Distance, ll_Minutes ) THEN
		lb_Success = TRUE
	END IF

END IF


IF NOT lb_Success THEN
	SetNull ( lc_Distance )
END IF


RETURN lc_Distance
end function

public function decimal of_getemptymiles ();//Caclulate the empty miles for the itinerary.  If the trip has not
//previously been initialized with of_InitTrip, it will be initialized
//through of_GetTrip with default settings.  It is generally recommended
//that you initailize the trip yourself, though, to ensure intended settings
//are applied.

n_cst_Trip	lnv_Trip
Decimal	lc_Distance
Long		ll_Minutes
Boolean	lb_Success

IF This.of_GetTrip ( lnv_Trip, TRUE /*CreateIfNeeded*/ ) = 1 THEN

	IF lnv_Trip.of_GetEmpty ( lc_Distance, ll_Minutes ) THEN
		lb_Success = TRUE
	END IF

END IF


IF NOT lb_Success THEN
	SetNull ( lc_Distance )
END IF


RETURN lc_Distance
end function

public function decimal of_getbobtailmiles ();//Caclulate the bobtail miles for the itinerary.  If the trip has not
//previously been initialized with of_InitTrip, it will be initialized
//through of_GetTrip with default settings.  It is generally recommended
//that you initailize the trip yourself, though, to ensure intended settings
//are applied.

n_cst_Trip	lnv_Trip
Decimal	lc_Distance
Long		ll_Minutes
Boolean	lb_Success

IF This.of_GetTrip ( lnv_Trip, TRUE /*CreateIfNeeded*/ ) = 1 THEN

	IF lnv_Trip.of_GetBobtail ( lc_Distance, ll_Minutes ) THEN
		lb_Success = TRUE
	END IF

END IF


IF NOT lb_Success THEN
	SetNull ( lc_Distance )
END IF


RETURN lc_Distance
end function

public function decimal of_getdeadheadmiles ();//Caclulate the deadhead miles for the itinerary.  If the trip has not
//previously been initialized with of_InitTrip, it will be initialized
//through of_GetTrip with default settings.  It is generally recommended
//that you initailize the trip yourself, though, to ensure intended settings
//are applied.

n_cst_Trip	lnv_Trip
Decimal	lc_Distance
Long		ll_Minutes
Boolean	lb_Success

IF This.of_GetTrip ( lnv_Trip, TRUE /*CreateIfNeeded*/ ) = 1 THEN

	IF lnv_Trip.of_GetDeadhead ( lc_Distance, ll_Minutes ) THEN
		lb_Success = TRUE
	END IF

END IF


IF NOT lb_Success THEN
	SetNull ( lc_Distance )
END IF


RETURN lc_Distance
end function

public function long of_geteventtypecount (string as_type);//Returns : Number of Events of the requested type (>= 0).  Null if cannot be determined.

Long	ll_Row, &
		ll_FirstRow, &
		ll_LastRow
DataStore	lds_EventCache
n_cst_beo_Event	lnv_Event

Long	ll_Count = 0
Boolean	lb_Finished = FALSE

lnv_Event = CREATE n_cst_beo_Event

IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		//Ok, but we now know our result should be zero.
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		lnv_Event.of_SetSource ( lds_EventCache )
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	FOR ll_Row = ll_FirstRow TO ll_LastRow
	
		lnv_Event.of_SetSourceRow ( ll_Row )

		CHOOSE CASE lnv_Event.of_IsType ( as_Type )

		CASE TRUE
			ll_Count ++

		CASE FALSE
			//No action needed

		CASE ELSE  //Null
			SetNull ( ll_Count )
			lb_Finished = TRUE
			EXIT

		END CHOOSE
	
	NEXT

END IF

DESTROY ( lnv_Event ) 

RETURN ll_Count
end function

public function long of_getpickupcount ();//Returns : Number of Pickups in the itinerary (>= 0), Null if cannot be determined.

RETURN This.of_GetEventTypeCount ( gc_Dispatch.cs_EventType_Pickup )
end function

public function long of_getdeliverycount ();//Returns : Number of Deliveries in the itinerary (>= 0), Null if cannot be determined.

RETURN This.of_GetEventTypeCount ( gc_Dispatch.cs_EventType_Deliver )
end function

public function long of_gethookcount ();//Returns : Number of Hooks in the itinerary (>= 0), Null if cannot be determined.

RETURN This.of_GetEventTypeCount ( gc_Dispatch.cs_EventType_Hook )
end function

public function long of_getdropcount ();//Returns : Number of Drops in the itinerary (>= 0), Null if cannot be determined.

RETURN This.of_GetEventTypeCount ( gc_Dispatch.cs_EventType_Drop )
end function

public function long of_getmountcount ();//Returns : Number of Mounts in the itinerary (>= 0), Null if cannot be determined.

RETURN This.of_GetEventTypeCount ( gc_Dispatch.cs_EventType_Mount )
end function

public function long of_getdismountcount ();//Returns : Number of Dismounts in the itinerary (>= 0), Null if cannot be determined.

RETURN This.of_GetEventTypeCount ( gc_Dispatch.cs_EventType_Dismount )
end function

public function decimal of_getshipmentcount ();//Forward request to overloaded version, using default value for ab_UseExclude (TRUE)
//Return value is explained in the overloaded version.
//The ab_UseExclude setting is explained in the of_GetShipmentIds function.

RETURN This.of_GetShipmentCount ( TRUE /*UseExclude*/ )
end function

public function long of_getstopcount ();//Returns : Number of Stops (>= 0).  Events at the same site in succession
//are counted as one stop.  Null sites are counted as stops.

Long	ll_Row, &
		ll_FirstRow, &
		ll_LastRow, &
		ll_PreviousSite, &
		ll_CurrentSite
DataStore	lds_EventCache
n_cst_beo_Event	lnv_Event

Long	ll_Count = 0
Boolean	lb_Finished = FALSE

lnv_Event = CREATE n_cst_beo_Event


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		//Ok, but now we know our result is zero.
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		lnv_Event.of_SetSource ( lds_EventCache )
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	SetNull ( ll_PreviousSite ) //****NEED TO REVISE FOR ACTUAL PREVIOUS SITE*****
	//(BUT, this was the way it was in beo_itinerary too.)

	FOR ll_Row = ll_FirstRow TO ll_LastRow
	
		lnv_Event.of_SetSourceRow ( ll_Row )

		//Don't consider LocationOptional, PMService, and Scale events in calculating how many stops there were.
		IF lnv_Event.of_IsLocationOptional ( ) THEN
			CONTINUE
		ELSEIF lnv_Event.of_IsType ( gc_Dispatch.cs_EventType_PMService ) THEN
			CONTINUE
		ELSEIF lnv_Event.of_IsType ( gc_Dispatch.cs_EventType_Scale ) THEN
			CONTINUE
		END IF
	
		ll_CurrentSite = lnv_Event.of_GetSite ( )
	
		IF ll_CurrentSite = ll_PreviousSite THEN
			//Sites match.  Don't count this event as a stop.
		ELSE
			ll_Count ++
		END IF
	
		ll_PreviousSite = ll_CurrentSite
	
	NEXT

END IF

DESTROY ( lnv_Event ) 


RETURN ll_Count
end function

public function long of_getstopoffcount ();//Not yet implemented
Long ll_long
return ll_long
end function

public function long of_getworkingstopcount ();//Returns : Number of Working Stops (>= 0).  (Working Stops excludes New Trips, End Trips.)
//Events at the same site in succession are counted as one stop.  Null sites are counted as stops.

Long	ll_Row, &
		ll_FirstRow, &
		ll_LastRow, &
		ll_PreviousSite, &
		ll_CurrentSite
Boolean	lb_ThisSiteCounted, &
			lb_Working
DataStore	lds_EventCache
n_cst_beo_Event	lnv_Event

Long	ll_Count = 0
Boolean	lb_Finished = FALSE

lnv_Event = CREATE n_cst_Beo_Event

IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		//OK, but now we know our result should be zero.
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		lnv_Event.of_SetSource ( lds_EventCache )
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	SetNull ( ll_PreviousSite ) //****NEED TO REVISE FOR ACTUAL PREVIOUS SITE*****
	//(BUT, this is the way it was in beo_Itinerary, too.)

	FOR ll_Row = ll_FirstRow TO ll_LastRow
	
		lnv_Event.of_SetSourceRow ( ll_Row )

		ll_CurrentSite = lnv_Event.of_GetSite ( )
		lb_Working = lnv_Event.of_IsWorkingStop ( )
	
		//Disregard Non-Working LocationOptional, PMService, and Scale events in determining stops
		IF lnv_Event.of_IsLocationOptional ( ) THEN
			IF lb_Working = FALSE THEN  //Will be, as things stand now.
				CONTINUE
			END IF
		ELSEIF lnv_Event.of_IsType ( gc_Dispatch.cs_EventType_PMService ) THEN
			IF lb_Working = FALSE THEN  //Will be, as things stand now.
				CONTINUE
			END IF
		ELSEIF lnv_Event.of_IsType ( gc_Dispatch.cs_EventType_Scale ) THEN
			IF lb_Working = FALSE THEN  //Will be, as things stand now.
				CONTINUE
			END IF
		END IF
	
		IF ll_CurrentSite = ll_PreviousSite THEN
			IF lb_ThisSiteCounted THEN
				//Sites match, and site has already been counted.  Don't count this event.
			ELSEIF lb_Working THEN
				ll_Count ++
				lb_ThisSiteCounted = TRUE
			END IF
		ELSE
			IF lb_Working THEN
				ll_Count ++
				lb_ThisSiteCounted = TRUE
			ELSE
				lb_ThisSiteCounted = FALSE
			END IF
		END IF
	
		ll_PreviousSite = ll_CurrentSite
	
	NEXT

END IF

DESTROY ( lnv_Event )

RETURN ll_Count
end function

public function decimal of_gettotalweight ();//Call the overloaded version, with ab_UseExclude = TRUE

RETURN This.of_GetTotalWeight ( TRUE /*UseExclude*/ )
end function

public function n_cst_bso_dispatch of_getdispatchmanager ();RETURN inv_Dispatch
end function

public function decimal of_getfreightrevenue ();RETURN THIS.of_Getfreightrevenue( FALSE )
end function

public function long of_getshipmentids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes);//Forward request to overloaded version, using default value for ab_UseExclude (TRUE)
//The ab_UseExclude setting is explained in the notes for the overloaded version.

RETURN This.of_GetShipmentIds ( ala_Ids, ab_ShrinkNulls, ab_ShrinkDupes, TRUE /*UseExclude*/ )
end function

public function long of_setrange (n_cst_msg anv_msg);//Returns : >=0 : Number of rows in the specified range, -1 = Error

//Required Parameters in the Message Object are :
//ItinType  (Note : Trip is not really supported on the object yet, 
//				because of differences in date handling)
//ItinId
//StartDate AND EndDate   OR   OneDate

DataStore	lds_Events
Integer		li_ItinType
Long	ll_ItinId, &
		ll_FoundRow, &
		ll_FirstRow, &
		ll_LastRow, &
		ll_RowCount
Date	ld_Start, &
		ld_End
s_Parm	lstr_Parm
Boolean	lb_RetainExcludedShipments

Long	ll_Return = 0

SetNull ( ll_FirstRow )  //So we can easily distinguish if it's been set or not.
SetNull ( ll_LastRow )  //So we can easily distinguish if it's been set or not.

//Clear the NoRowsInRange flag, the first and last row, and the start and end dates.
ib_NoRowsInRange = FALSE
SetNull ( ii_ItinType )
SetNull ( il_ItinId )
SetNull ( il_FirstEventRow )
SetNull ( il_LastEventRow )
SetNull ( il_PriorEventRow )  //Unlike first and last event row, which will be set below,
										//this one only gets set in of_InitTrip.
SetNull ( id_Start )
SetNull ( id_End )

SetNull ( ic_FreightRevenue )
SetNull ( ic_Payables )

//Destroy the shipment stop data datastore, since it will not apply to this new range.
DESTROY ids_ShipmentStopData

//Destroy the routing trip, since it will not apply to this new range.
DESTROY inv_Trip

//Initialize the local ItinType, ItinId, and date variables with null.
SetNull ( li_ItinType )
SetNull ( ll_ItinId )
SetNull ( ld_Start )
SetNull ( ld_End )

//Unless the RetainExcludedShipments parameter is provided (and true), clear the 
//excluded shipments list.

lb_RetainExcludedShipments = FALSE

IF ll_Return = 0 THEN

	IF anv_Msg.of_Get_Parm ( "RetainExcludedShipments", lstr_Parm ) > 0 THEN
		lb_RetainExcludedShipments = lstr_Parm.ia_Value
		IF IsNull ( lb_RetainExcludedShipments ) THEN
			lb_RetainExcludedShipments = FALSE
		END IF
	END IF
	
	IF lb_RetainExcludedShipments = FALSE THEN
		This.of_ClearExcludedShipments ( )
	END IF

END IF


IF ll_Return = 0 THEN

	//Get the ItinType and ItinId, if specified (they're required).
	
	IF anv_Msg.of_Get_Parm ( "ItinType", lstr_Parm ) > 0 THEN
		li_ItinType = lstr_Parm.ia_Value
	END IF
	
	IF anv_Msg.of_Get_Parm ( "ItinId", lstr_Parm ) > 0 THEN
		ll_ItinId = lstr_Parm.ia_Value
	END IF
	
	//Validate the ItinType and ItinId (verify they were specified.)
	//(We could get fancier, and also check the type value itself, 
	//ie. look for unrecognized value, or screen for trip, which is
	//not really supported on the object as a whole right now.)
	
	IF IsNull ( li_ItinType ) OR IsNull ( ll_ItinId ) THEN
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	lds_Events = This.of_GetEventCache ( )
	
	IF IsValid ( lds_Events ) THEN
		ll_RowCount = lds_Events.RowCount ( )
	ELSE
		ll_Return = -1
	END IF

END IF


//Get a start date and end date value, if specified (they're required).

IF anv_Msg.of_Get_Parm ( "OneDate", lstr_Parm ) > 0 THEN

	ld_Start = lstr_Parm.ia_Value
	ld_End = lstr_Parm.ia_Value

ELSE

	IF anv_Msg.of_Get_Parm ( "StartRow", lstr_Parm ) > 0 THEN
		ll_FirstRow = lstr_Parm.ia_Value
		IF ll_FirstRow > 0 AND ll_FirstRow <= ll_RowCount THEN
			ld_Start = lds_Events.Object.de_ArrDate [ ll_FirstRow ]
		ELSE
			ll_Return = -1
		END IF
	ELSEIF anv_Msg.of_Get_Parm ( "StartDate", lstr_Parm ) > 0 THEN
		ld_Start = lstr_Parm.ia_Value
	END IF

	IF anv_Msg.of_Get_Parm ( "EndRow", lstr_Parm ) > 0 THEN
		ll_LastRow = lstr_Parm.ia_Value
		IF ll_LastRow > 0 AND ll_LastRow <= ll_RowCount THEN
			ld_End = lds_Events.Object.de_ArrDate [ ll_LastRow ]
		ELSE
			ll_Return = -1
		END IF
	ELSEIF anv_Msg.of_Get_Parm ( "EndDate", lstr_Parm ) > 0 THEN
		ld_End = lstr_Parm.ia_Value
	END IF

END IF


IF ll_Return = 0 THEN

	//Validate the start date value
	
	IF IsNull ( ld_Start ) THEN
		ll_Return = -1
	ELSE
		//Strip off any unwanted time component that may be on the date passed in.
		ld_Start = Date ( DateTime ( ld_Start ) )
	END IF
	
	//Validate the end date value
	
	IF IsNull ( ld_End ) THEN
		ll_Return = -1
	ELSE
		//Strip off any unwanted time component that may be on the date passed in.
		ld_End = Date ( DateTime ( ld_End ) )
	END IF

END IF


IF ll_Return = 0 THEN

	CHOOSE CASE ll_RowCount

	CASE IS > 0

		IF IsNull ( ll_FirstRow ) THEN

			ll_FirstRow = lds_Events.Find ( "de_arrdate < " + String ( Date ( DateTime ( ld_Start ) ), "yyyy-mm-dd" ), &
				ll_RowCount, 1 ) + 1
	
			//If the value for Find above is 0, it does not mean there's no rows in the range.
			//It means there's no row prior to the range.  We know that there are 
			//rows in the ds from checks above, so the first row in the range is 
			//the first row in the ds.

		END IF


		IF IsNull ( ll_LastRow ) THEN

			ll_LastRow = lds_Events.Find ( "de_arrdate <= " + String ( Date ( DateTime ( ld_End ) ), &
				"yyyy-mm-dd" ), ll_RowCount, 1 )
	
			//If the value for Find above is 0, there are no rows in the range.

		END IF


		IF ll_FirstRow > 0 AND ll_LastRow >= ll_FirstRow THEN
			ll_Return = ( ll_LastRow - ll_FirstRow ) + 1
			il_FirstEventRow = ll_FirstRow
			il_LastEventRow = ll_LastRow
		ELSE
			//Assume no rows in range, although there are conceivably some failure scenarios.
			//Allow ll_Return to be 0
		END IF

	CASE 0  //No rows in datastore -- no rows in range
		//Allow ll_Return to be 0

	CASE ELSE
		ll_Return = -1

	END CHOOSE

END IF



//If we've determined there are no rows in the range, flag it that so computations can avoid
//unnecessary overhead, where possible.

IF ll_Return = 0 THEN
	ib_NoRowsInRange = TRUE
END IF

//If we have a valid range, set the start and end dates to the instance variables.

IF ll_Return >= 0 THEN
	ii_ItinType = li_ItinType
	il_ItinId = ll_ItinId
	id_Start = ld_Start
	id_End = ld_End
END IF

RETURN ll_Return
end function

public function long of_getshipmentstopdata (ref datastore ads_data);Long	lla_ShrunkList[], &
		ll_ShrunkCount, &
		lla_FullList[], &
		ll_FullCount, &
		ll_CalcRows, &
		ll_Index, &
		ll_Row, &
		ll_Id, &
		ll_StopCount
DataStore	lds_Data
DWObject		ldwo_StopCount

Long		ll_Return //=0
Boolean	lb_Finished = FALSE


IF IsValid ( ads_Data ) THEN
	DESTROY ads_Data
END IF


//If we've already loaded the ShipmentStopData datastore on a previous call for this range,
//use what we've got.  (Calls to of_SetRange destroy the datastore, so it will be forced to
//recreate on subsequent calls.)

IF IsValid ( ids_ShipmentStopData ) THEN

	lds_Data = ids_ShipmentStopData
	ll_CalcRows = lds_Data.RowCount ( )

	IF ll_CalcRows >= 0 THEN
		ll_Return = ll_CalcRows
	ELSE
		ll_Return = -1
	END IF

	lb_Finished = TRUE

END IF


IF lb_Finished = FALSE THEN

	ll_FullCount = This.of_GetShipmentIds ( lla_FullList, FALSE /*Do not Shrink Nulls*/, &
		FALSE /*Do not shrink dupes*/, FALSE /*Don't exclude ids in of_GetExcludedShipments*/ )
	//We want the whole list.  Excluded shipments will be included in the retrieval, but
	//flagged as such, so that subsequent processing can provide both Excluded and 
	//and non-Excluded calculation options.  If we didn't retrieve them here, those
	//functions would not be able to support the non-Excluded calculations.
	
	IF ll_FullCount > 0 THEN
		ll_ShrunkCount = This.of_GetShipmentIds ( lla_ShrunkList, TRUE /*Shrink Nulls*/, &
			TRUE /*Shrink dupes*/, FALSE /*Don't exclude ids in of_GetExcludedShipments*/ )
	ELSEIF ll_FullCount = 0 THEN
		//OK, but no need to get the shrunk list, above.  We now know the shipment stop count is 0.
		lb_Finished = TRUE
	ELSE
		//Null, or unexpected value.
		ll_Return = -1
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN
	IF ll_ShrunkCount > 0 THEN
		//OK
	ELSEIF ll_ShrunkCount = 0 THEN
		//OK, but we now know the revenue will be zero, because we have no shipment events.
		//A fullcount > 0 can shrink down to zero, because fullcount will include all the 
		//entries, even if they're null.
		lb_Finished = TRUE
	ELSE
		ll_Return = -1
		lb_Finished = TRUE
	END IF
END IF

IF lb_Finished = FALSE THEN

	lds_Data = CREATE DataStore
	lds_Data.DataObject = "d_ShipmentStopData"
	lds_Data.SetTransObject ( SQLCA )
	ldwo_StopCount = lds_Data.Object.StopCount

	ll_CalcRows = lds_Data.Retrieve ( lla_ShrunkList )
	COMMIT ;

	//Note on this choose case : the CalcRows should match ll_ShrunkCount.  I'm enforcing that
	//comparison here, although we could possibly go with the looser version that's commented out.

	CHOOSE CASE ll_CalcRows

	CASE ll_ShrunkCount
		//OK

//	CASE IS > 0
//		//OK
//
//	CASE 0
//		//Ok, but we now know there's no shipment stop data.
//		lb_Finished = TRUE

	CASE ELSE
		ll_Return = -1
		lb_Finished = TRUE

	END CHOOSE

END IF

IF lb_Finished = FALSE THEN

	FOR ll_Index = 1 TO ll_FullCount

		IF IsNull ( lla_FullList [ ll_Index ] ) THEN
			CONTINUE
		ELSEIF lla_FullList [ ll_Index ] = ll_Id THEN
			//Same Id as on the last pass.  Use StopCount from last pass
		ELSE
			ll_Id = lla_FullList [ ll_Index ]
			ll_Row = lds_Data.Find ( "ShipmentId = " + String ( ll_Id ), 1, ll_CalcRows )
			IF ll_Row > 0 THEN
				ll_StopCount = ldwo_StopCount.Primary [ ll_Row ]
			ELSE
				ll_Return = -1
				lb_Finished = TRUE
				EXIT
			END IF
		END IF

		ll_StopCount ++

		IF ll_Row > 0 THEN  //Should be, if we made it here.
			ldwo_StopCount.Primary [ ll_Row ] = ll_StopCount
		ELSE
			ll_Return = -1
			lb_Finished = TRUE
			EXIT
		END IF

	NEXT

END IF


IF lb_Finished = FALSE THEN

	IF ll_CalcRows >= 0 THEN
		ll_Return = ll_CalcRows
	ELSE
		ll_Return = -1
	END IF

	lb_Finished = TRUE

END IF

DESTROY ldwo_StopCount

IF ll_Return >= 0 THEN
	ids_ShipmentStopData = lds_Data
	This.of_MarkShipmentStopDataExcluded ( )
	ads_Data = lds_Data
ELSE
	DESTROY lds_Data
END IF

RETURN ll_Return
end function

public function decimal of_getitineraryhourstotal ();//Returns : Total itinerary hours (time between new trips and end trips)
//for the itinerary range, or null if cannot be determined.

DataStore	lds_EventCache
Long			ll_FirstRow, &
				ll_LastRow, &
				ll_CacheCount, &
				ll_Seconds, &
				ll_TotalSeconds, &
				ll_Row, &
				ll_SearchStart  //, &
				//ll_NewTripRow, &
				//ll_EndTripRow
DWObject		ldwo_Type, &
				ldwo_DateArrived, &
				ldwo_TimeArrived, &
				ldwo_TimeDeparted
Boolean		lb_NoRows, &
				lb_OpenAtFirstEvent, &
				lb_OpenAtLastEvent, &
				lb_LastCalc
Date			ld_RangeStart, &
				ld_RangeEnd, &
				ld_First, &
				ld_Last, &
				ld_Work
Time			lt_Work, &
				lt_Arrived, &
				lt_Departed
DateTime		ldt_CalcStart, &
				ldt_CalcEnd
n_cst_DateTime	lnv_DateTime

Decimal		lc_Return


IF lc_Return = 0 THEN

	ld_RangeStart = This.of_GetStartDate ( )

	IF IsNull ( ld_RangeStart ) THEN
		SetNull ( lc_Return )
	END IF

END IF


IF lc_Return = 0 THEN

	ld_RangeEnd = This.of_GetEndDate ( )

	IF IsNull ( ld_RangeEnd ) THEN
		SetNull ( lc_Return )
	END IF

END IF


IF lc_Return = 0 THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		ll_CacheCount = lds_EventCache.RowCount ( )
		ldwo_Type = lds_EventCache.Object.de_Event_Type
		ldwo_DateArrived = lds_EventCache.Object.de_ArrDate
		ldwo_TimeArrived = lds_EventCache.Object.de_ArrTime
		ldwo_TimeDeparted = lds_EventCache.Object.de_DepTime
	ELSE
		SetNull ( lc_Return )
	END IF

END IF


IF lc_Return = 0 THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		lb_NoRows = TRUE

	CASE ELSE
		SetNull ( lc_Return )

	END CHOOSE

END IF


IF lc_Return = 0 AND lb_NoRows = FALSE THEN

	ld_First = ldwo_DateArrived.Primary [ ll_FirstRow ]

	IF IsNull ( ld_First ) THEN
		SetNull ( lc_Return )
	END IF

END IF


IF lc_Return = 0 AND lb_NoRows = FALSE THEN

	ld_Last = ldwo_DateArrived.Primary [ ll_LastRow ]

	IF IsNull ( ld_Last ) THEN
		SetNull ( lc_Return )
	END IF

END IF


//Note : By not doing processing here if lb_NoRows = TRUE, we'll be returning zero in situations
//where there's a trip spanning the range but with all events falling outside of it.  We should
//probably revise this, for consistency's sake.

IF lc_Return = 0 AND lb_NoRows = FALSE THEN

//	REPLACED BY CALL TO of_IsTripOpen, below
//
//	ll_NewTripRow = lds_EventCache.Find ( "de_event_type = 'O'", ll_FirstRow, ll_CacheCount )
//	ll_EndTripRow = lds_EventCache.Find ( "de_event_type = 'F'", ll_FirstRow, ll_CacheCount )
//
//	IF ll_NewTripRow > 0 AND ll_EndTripRow > 0 THEN
//
//		IF ll_EndTripRow < ll_NewTripRow THEN
//			lb_OpenAtFirstEvent = TRUE
//		ELSE
//			//Not open at first event
//		END IF
//
//	ELSEIF ll_NewTripRow > 0 THEN
//
//		//Not open at first event.
//
//	ELSEIF ll_EndTripRow > 0 THEN
//
//		lb_OpenAtFirstEvent = TRUE
//
//	ELSE
//
//		ll_NewTripRow = lds_EventCache.Find ( "de_event_type = 'O'", ll_FirstRow, 1 )
//		ll_EndTripRow = lds_EventCache.Find ( "de_event_type = 'F'", ll_FirstRow, 1 )
//
//		IF ll_NewTripRow > ll_EndTripRow THEN
//			lb_OpenAtFirstEvent = TRUE
//		ELSEIF ll_EndTripRow > ll_NewTripRow THEN
//			//Not open at first event
//		ELSE
//			//Cannot determine for sure -- treat it like it is open.
//			lb_OpenAtFirstEvent = TRUE
//		END IF
//
//	END IF
//
//	END SECTION REPLACED BY CALL TO of_IsTripOpen


	CHOOSE CASE This.of_IsTripOpen ( ll_FirstRow, lb_OpenAtFirstEvent )

	CASE 1 //Value successfully determined
		//No action needed

	CASE 0 //Could not definitively determine whether open or not, but not due to error
		//Assume open
		lb_OpenAtFirstEvent = TRUE

	CASE ELSE //-1 = Error, or unexpected value
		SetNull ( lc_Return )

	END CHOOSE

END IF


IF lc_Return = 0 AND lb_NoRows = FALSE THEN

	SetNull ( ldt_CalcStart )
	SetNull ( ldt_CalcEnd )


	IF lb_OpenAtFirstEvent THEN

		IF ll_FirstRow > 1 THEN

			FOR ll_Row = ll_FirstRow - 1 TO 1 STEP -1

				ld_Work = ldwo_DateArrived.Primary [ ll_Row ]

				IF ld_Work = ld_First THEN

					//!!We should check that this departed time isn't actually a carry over to the next
					//day, and adjust accordingly if it is.  Maybe a get datetimedeparted (base, local) 
					//on the beo?
					lt_Arrived = ldwo_TimeArrived.Primary [ ll_Row ]
					lt_Departed = ldwo_TimeDeparted.Primary [ ll_Row ]

					IF lt_Departed < lt_Arrived THEN
						ld_Work = RelativeDate ( ld_Work, 1 )
						lt_Work = lt_Departed
					ELSEIF IsNull ( lt_Departed ) THEN
						lt_Work = lt_Arrived
					ELSE
						lt_Work = lt_Departed
					END IF

//		Replaced by date-rollover sensitive processing, above.
//					lt_Work = ldwo_TimeDeparted.Primary [ ll_Row ]
//					IF IsNull ( lt_Work ) THEN
//						lt_Work = ldwo_TimeArrived.Primary [ ll_Row ]
//					END IF

					IF NOT IsNull ( lt_Work ) THEN
						ldt_CalcStart = DateTime ( ld_Work, lt_Work )
					END IF

				ELSE

					//We're outside the range limits.  Give up, and use the range limit as the CalcStart.
					EXIT

				END IF

			NEXT

		END IF

		//If we weren't able to determine a start point, start at midnight on the start of the range.
		IF IsNull ( ldt_CalcStart ) THEN
			ldt_CalcStart = DateTime ( ld_RangeStart )
		END IF

	END IF


	ll_SearchStart = ll_FirstRow

	DO

		IF IsNull ( ldt_CalcStart ) THEN
			//We're looking for a start-of-calc event

			IF ll_SearchStart <= ll_CacheCount THEN
				ll_Row = lds_EventCache.Find ( "de_event_type = 'O'", ll_SearchStart, ll_CacheCount )
			ELSE
				ll_Row = 0
			END IF

			IF ll_Row > 0 THEN

				//Set ll_SearchStart ahead so it's ready for the next pass through the loop, if any.
				ll_SearchStart = ll_Row + 1

				ld_Work = ldwo_DateArrived.Primary [ ll_Row ]

				IF ld_Work > ld_RangeEnd THEN
					//We're off the end of the range -- flag that we're finished
					lb_LastCalc = TRUE
					CONTINUE  //This will exit us, in effect.
				ELSE

					//Note : this sequence doesn't need the date-rollover processing for TimeDeparted, because
					//if we have an arrival time, we'll use it, and it's only if we have both values and the
					//TimeDeparted is less than the TimeArrived that we flag rollover.

					lt_Work = ldwo_TimeArrived.Primary [ ll_Row ]
					IF IsNull ( lt_Work ) THEN
						lt_Work = ldwo_TimeDeparted.Primary [ ll_Row ]
						IF IsNull ( lt_Work ) THEN
							//!!!!Big problem -- now we have run forward looking for another time????

							//For now, throw the trip out???!!!
							//Continue the loop, and look for another trip.
							CONTINUE
						END IF
					END IF

					ldt_CalcStart = DateTime ( ld_Work, lt_Work )

				END IF

			ELSE  //No more new intervals to calculate.
				lb_LastCalc = TRUE
			END IF


		ELSE
			//We're looking for an end-of-calc event

			IF ll_SearchStart <= ll_CacheCount THEN
				ll_Row = lds_EventCache.Find ( "de_event_type = 'F'", ll_SearchStart, ll_CacheCount )
			ELSE
				ll_Row = 0
			END IF

			IF ll_Row > 0 THEN

				//Set ll_SearchStart ahead so it's ready for the next pass through the loop, if any.
				//If that start point puts us off the end of the cache, flag that this is the last calc.
				ll_SearchStart = ll_Row + 1
				IF ll_SearchStart > ll_CacheCount THEN
					lb_LastCalc = TRUE
				END IF

				ld_Work = ldwo_DateArrived.Primary [ ll_Row ]

				IF ld_Work > ld_RangeEnd THEN
					//We're off the end of the range -- go up to midnight (Calc'd as 00:00 of next day)
					ldt_CalcEnd = DateTime ( RelativeDate ( ld_RangeEnd, 1 ) )
					lb_LastCalc = TRUE
				ELSE
					//!!We should check that this departed time isn't actually a carry over to the next
					//day, and adjust accordingly if it is.  Maybe a get datetimedeparted (base, local) 
					//on the beo?

					lt_Arrived = ldwo_TimeArrived.Primary [ ll_Row ]
					lt_Departed = ldwo_TimeDeparted.Primary [ ll_Row ]

					IF lt_Departed < lt_Arrived THEN
						ld_Work = RelativeDate ( ld_Work, 1 )
						lt_Work = lt_Departed
					ELSEIF IsNull ( lt_Departed ) THEN
						IF IsNull ( lt_Arrived ) THEN
							//!!!!Big problem -- now we have to backtrack????

							//For now, throw the trip out???!!!
							SetNull ( ldt_CalcStart )
							CONTINUE
						ELSE
							lt_Work = lt_Arrived
						END IF
					ELSE
						lt_Work = lt_Departed
					END IF

//		Replaced by date-rollover sensitive processing, above.
//					lt_Work = ldwo_TimeDeparted.Primary [ ll_Row ]
//					IF IsNull ( lt_Work ) THEN
//						lt_Work = ldwo_TimeArrived.Primary [ ll_Row ]
//						IF IsNull ( lt_Work ) THEN
//							//!!!!Big problem -- now we have to backtrack????
//
//							//For now, throw the trip out???!!!
//							SetNull ( ldt_CalcStart )
//							CONTINUE
//
//						END IF
//					END IF

					ldt_CalcEnd = DateTime ( ld_Work, lt_Work )

				END IF

			ELSE
				//Set to midnight at end of range (Calc'd as 00:00 of next day)
				ldt_CalcEnd = DateTime ( RelativeDate ( ld_RangeEnd, 1 ) )
				lb_LastCalc = TRUE

			END IF

			IF NOT IsNull ( ldt_CalcEnd ) THEN

				ll_Seconds = lnv_DateTime.of_SecondsAfter ( ldt_CalcStart, ldt_CalcEnd )

				//If the calculation makes sense, add it to the total.  If not, throw the trip out.
				IF ll_Seconds > 0 THEN
					ll_TotalSeconds += ll_Seconds
				END IF

			END IF

			//Clear both calc values so the next pass through the loop (if this isn't flagged as lb_LastCalc)
			//will look for the start of a new calc range.
			SetNull ( ldt_CalcStart )
			SetNull ( ldt_CalcEnd )

		END IF

	LOOP UNTIL lb_LastCalc = TRUE

END IF

IF lc_Return = 0 THEN

	lc_Return = Round ( ll_TotalSeconds / 3600, 2 )

END IF

DESTROY ldwo_Type
DESTROY ldwo_DateArrived
DESTROY ldwo_TimeArrived
DESTROY ldwo_TimeDeparted

RETURN lc_Return
end function

public function long of_getdriverids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes);//Returns : Number of drivers listed in the result.  Null if cannot be determined.

Long	ll_FirstRow, &
		ll_LastRow, &
		lla_List[]
DataStore	lds_EventCache
n_cst_AnyArraySrv	lnv_AnyArray

Long		ll_Count = 0
Boolean	lb_Finished = FALSE

//Clear reference array.
ala_Ids = lla_List


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range -- we know that the driver count will be zero.
		//Allow count to stay zero, and flag that we're done
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		//OK
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	IF ll_FirstRow > 0 AND ll_LastRow >= ll_FirstRow THEN

		lla_List = lds_EventCache.Object.de_driver [ ll_FirstRow, ll_LastRow ]

		ll_Count = lnv_AnyArray.of_GetShrinked ( lla_List, ab_ShrinkNulls, ab_ShrinkDupes )

		IF ll_Count >= 0 THEN
			ala_Ids = lla_List
		ELSE
			SetNull ( ll_Count )
			lb_Finished = TRUE
		END IF

	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END IF

END IF


RETURN ll_Count
end function

public function string of_getdriverlist ();//Returns : A semicolon (actually, space semicolon space) delimited list of drivers 
//in the itinerary range (in the order they're first encountered, with no repetition), 
//or Null if cannot be determined.  If we get a valid id list and then can't resolve one
//or more descriptions, we write an error notification into the list.  So, you won't get
//null if there's an error resolving an individual id.
//Driver names are in Last, First format.

Long	lla_Ids[], &
		ll_Count, &
		ll_Index
String	ls_Work
n_cst_EmployeeManager	lnv_EmployeeManager

String	ls_List

ll_Count = This.of_GetDriverIds ( lla_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

IF IsNull ( ll_Count ) THEN

	SetNull ( ls_List )

ELSEIF ll_Count = 0 THEN

	//Return empty list (empty string)

ELSE

	FOR ll_Index = 1 TO ll_Count

		IF lnv_EmployeeManager.of_DescribeEmployee ( lla_Ids [ ll_Index ], ls_Work, &
			appeon_constant.ci_DescribeType_LastFirst ) = 1 THEN

		ELSE
			ls_Work = "ERROR: VALUE N/A ( ID = "
			IF IsNull ( lla_Ids [ ll_Index ] ) THEN
				ls_Work += "NULL"
			ELSE
				ls_Work += String ( lla_Ids [ ll_Index ] )
			END IF
			ls_Work += ")"
		END IF

		IF Len ( ls_List ) > 0 THEN
			ls_List += " ; "
		END IF
		ls_List += ls_Work

	NEXT

END IF

RETURN ls_List
end function

public function string of_getpowerunitlist ();//Returns : A semicolon (actually, space semicolon space) delimited list of power units 
//in the itinerary range (in the order they're first encountered, with no repetition), 
//or Null if cannot be determined.  If we get a valid id list and then can't resolve one
//or more descriptions, we write an error notification into the list.  So, you won't get
//null if there's an error resolving an individual id.

Long	lla_Ids[], &
		ll_Count
n_cst_EquipmentManager	lnv_EquipmentManager

String	ls_List

ll_Count = This.of_GetPowerUnitIds ( lla_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

IF IsNull ( ll_Count ) THEN

	SetNull ( ls_List )

ELSEIF ll_Count = 0 THEN

	//Return empty list (empty string)

ELSE

	ls_List = lnv_EquipmentManager.of_GetDescriptions ( lla_Ids, "SHORT_REF!", &
		TRUE /*Describe Errors*/, FALSE /*Don't ignore nulls*/ )

	//Using the Don't Ignore Nulls option because there shouldn't be any nulls, 
	//since we shrunk them, above.  So, if there are any, it's an error and
	//should be noted.

END IF

RETURN ls_List
end function

public function long of_getpowerunitids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes);//Returns : Number of power units listed in the result.  Null if cannot be determined.

Long	ll_FirstRow, &
		ll_LastRow, &
		lla_List[]
DataStore	lds_EventCache
n_cst_AnyArraySrv	lnv_AnyArray

Long		ll_Count = 0
Boolean	lb_Finished = FALSE

//Clear reference array.
ala_Ids = lla_List


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range -- we know that the power unit count will be zero.
		//Allow count to stay zero, and flag that we're done
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		//OK
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	IF ll_FirstRow > 0 AND ll_LastRow >= ll_FirstRow THEN

		lla_List = lds_EventCache.Object.de_tractor [ ll_FirstRow, ll_LastRow ]

		ll_Count = lnv_AnyArray.of_GetShrinked ( lla_List, ab_ShrinkNulls, ab_ShrinkDupes )

		IF ll_Count >= 0 THEN
			ala_Ids = lla_List
		ELSE
			SetNull ( ll_Count )
			lb_Finished = TRUE
		END IF

	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END IF

END IF


RETURN ll_Count
end function

public function date of_getstartdate ();RETURN id_Start
end function

public function date of_getenddate ();RETURN id_End
end function

public function integer of_getitintype ();RETURN ii_ItinType
end function

public function long of_getitinid ();RETURN il_ItinId
end function

public function string of_getitineraryfor ();Integer	li_ItinType
Long		ll_ItinId
String	ls_Description
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_EquipmentManager	lnv_EquipmentManager

Integer	li_Return = 1
String	ls_Return


IF li_Return = 1 THEN

	li_ItinType = This.of_GetItinType ( )
	ll_ItinId = This.of_GetItinId ( )
	
	IF IsNull ( li_ItinType ) OR IsNull ( ll_ItinId ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE li_ItinType

	CASE gc_Dispatch.ci_ItinType_Driver

		IF lnv_EmployeeManager.of_DescribeEmployee ( ll_ItinId, ls_Description, &
			appeon_constant.ci_DescribeType_LastFirst ) = 1 THEN

			ls_Return = ls_Description

		END IF

	CASE gc_Dispatch.ci_Itintype_PowerUnit, &
		gc_Dispatch.ci_ItinType_TrailerChassis, &
		gc_Dispatch.ci_ItinType_Container

		IF lnv_EquipmentManager.of_Get_Description ( ll_ItinId, &
			"SHORT_REF!", ls_Description ) = 1 THEN

			ls_Return = ls_Description

		END IF

	CASE gc_Dispatch.ci_ItinType_Trip
	//Trip is not really supported on the object as a whole, though!!

		ls_Return = "TRIP " + String ( ll_ItinId )

	CASE ELSE  //Unexpected type
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = -1 THEN
	ls_Return = "ERROR: VALUE N/A ( ID = "
	IF IsNull ( ll_ItinId ) THEN
		ls_Return += "NULL"
	ELSE
		ls_Return += String ( ll_ItinId )
	END IF
	ls_Return += ")"
END IF


RETURN ls_Return
end function

public function integer of_istripopen (long al_row, ref boolean ab_open);//Returns : 1 = Success (Value passed out in ab_Open), 0 = No error, but
//value cannot be definitively determined (Null passed out in ab_Open), 
//-1 = Error (Null passed out in ab_Open)
//Indicates whether a trip is open GOING IN to the specified event row.
//(Thus, the function would return FALSE for a New Trip row, 
//TRUE for and End Trip row.)
//al_Row must be >= 1, but can be greater than the rowcount (which would
//determine trip status coming out of the last row.)

DataStore	lds_EventCache
Long			ll_CacheCount, &
				ll_NewTripRow, &
				ll_EndTripRow

Integer		li_Return = 0


SetNull ( ab_Open )


//Validate al_Row parameter (see notes above.)

IF li_Return = 0 THEN

	IF IsNull ( al_Row ) OR al_Row < 1 THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 0 THEN

	lds_EventCache = This.of_GetEventCache ( )
	
	IF IsValid ( lds_EventCache ) THEN
		ll_CacheCount = lds_EventCache.RowCount ( )
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 0 AND al_Row <= ll_CacheCount THEN

	ll_NewTripRow = lds_EventCache.Find ( "de_event_type = 'O'", al_Row, ll_CacheCount )
	ll_EndTripRow = lds_EventCache.Find ( "de_event_type = 'F'", al_Row, ll_CacheCount )

	IF ll_NewTripRow > 0 AND ll_EndTripRow > 0 THEN

		IF ll_EndTripRow < ll_NewTripRow THEN
			ab_Open = TRUE
			li_Return = 1
		ELSE
			ab_Open = FALSE
			li_Return = 1
		END IF

	ELSEIF ll_NewTripRow > 0 THEN

		ab_Open = FALSE
		li_Return = 1

	ELSEIF ll_EndTripRow > 0 THEN

		ab_Open = TRUE
		li_Return = 1

	END IF

END IF


IF li_Return = 0 AND al_Row > 0 THEN
	
	ll_NewTripRow = lds_EventCache.Find ( "de_event_type = 'O'", al_Row, 1 )
	ll_EndTripRow = lds_EventCache.Find ( "de_event_type = 'F'", al_Row, 1 )

	IF ll_NewTripRow > ll_EndTripRow THEN
		ab_Open = TRUE
		li_Return = 1
	ELSEIF ll_EndTripRow > ll_NewTripRow THEN
		ab_Open = FALSE
		li_Return = 1
	END IF

END IF


RETURN li_Return
end function

public function long of_getexcludedshipments (ref long ala_excludedshipments[]);//Returns : The number of elements in the array.  The array is passed out by reference.

ala_ExcludedShipments = ila_ExcludedShipments

RETURN UpperBound ( ala_ExcludedShipments )
end function

public function long of_getshipmentids (ref long ala_ids[], boolean ab_shrinknulls, boolean ab_shrinkdupes, boolean ab_useexclude);//Returns : Number of elements listed in the result (which may be more than the number of
//unique shipments in the result, if either ab_ShrinkNulls or ab_ShrinkDupes is FALSE.  
//If ab_UseExclude is TRUE (or Null), ids will be excluded from the list if they are
//in the list provided by of_GetExcludedShipments.  If ab_UseExclude = FALSE, this setting
//will be ignored, and all shipment ids in the range will be provided.  IF ab_ShrinkNulls
//is TRUE, excluded values will be shrunk out, otherwise they'll be nulled.
//Returns Null if the list cannot be determined.

Long	ll_FirstRow, &
		ll_LastRow, &
		lla_List[], &
		lla_ExcludedShipments[], &
		ll_ExcludedCount
DataStore	lds_EventCache
n_cst_AnyArraySrv	lnv_AnyArray

Long		ll_Count = 0
Boolean	lb_Finished = FALSE

//Clear reference array.
ala_Ids = lla_List


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range -- we know that the shipment count will be zero.
		//Allow count to stay zero, and flag that we're done
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		//OK
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	IF ll_FirstRow > 0 AND ll_LastRow >= ll_FirstRow THEN

		lla_List = lds_EventCache.Object.de_shipment_id [ ll_FirstRow, ll_LastRow ]

		IF ab_UseExclude OR IsNull ( ab_UseExclude ) THEN

			ll_ExcludedCount = This.of_GetExcludedShipments ( lla_ExcludedShipments )

			IF ll_ExcludedCount > 0 THEN

				lnv_AnyArray.of_RemoveLong ( lla_List, lla_ExcludedShipments, &
					FALSE /*Don't shrink excluded.*/ )
				//Excluded values will be nulled out, so they can be shrunk or not shrunk
				//according to the parameters below.

			END IF

		END IF


		ll_Count = lnv_AnyArray.of_GetShrinked ( lla_List, ab_ShrinkNulls, ab_ShrinkDupes )

		IF ll_Count >= 0 THEN
			ala_Ids = lla_List
		ELSE
			SetNull ( ll_Count )
			lb_Finished = TRUE
		END IF

	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END IF

END IF


RETURN ll_Count
end function

public function decimal of_getshipmentcount (boolean ab_useexclude);//Returns : Number of Shipments (Loads) in the itinerary (>= 0), Null if cannot be determined.
//Note: The return value is implemented as a decimal in case we want to count "partial" loads, 
//(ie., loads handled by more than one driver), but at present this interpretation is not
//implemented and the return value will be a whole number.


Decimal	lc_Count
Long		lla_Ids[]

//Note : If ids_ShipmentStopData has been initialized, we could use the rowcount on that
//instead of this direct id count, which would be faster, but I'm going to leave it like this
//for now for consistency's sake.

lc_Count = This.of_GetShipmentIds ( lla_Ids, TRUE /*ShrinkNulls*/, TRUE /*ShrinkDupes*/, &
	ab_UseExclude )

IF lc_Count >= 0 THEN
	//OK
ELSE
	SetNull ( lc_Count )
END IF

RETURN lc_Count
end function

public function decimal of_gettotalweight (boolean ab_useexclude);RETURN THIS.of_GetTotalweight( ab_useexclude , FALSE )
end function

public function long of_appendexcludedshipments (long ala_ids[]);//Returns : >= 0 The number of excluded shipments in the array, after it is shrunk.
// -1 = Error

Long	lla_ExcludedShipments[], &
		ll_ExcludedCount
n_cst_AnyArraySrv	lnv_Arrays

Long	ll_Return = 0

ll_ExcludedCount = This.of_GetExcludedShipments ( lla_ExcludedShipments )

IF ll_ExcludedCount > 0 THEN
	lnv_Arrays.of_AppendLong ( lla_ExcludedShipments, ala_Ids )
ELSE
	lla_ExcludedShipments = ala_Ids
END IF

ll_Return = This.of_SetExcludedShipments ( lla_ExcludedShipments )

IF ll_Return >= 0 THEN
	//OK
ELSE
	ll_Return = -1
END IF

RETURN ll_Return
end function

public function long of_setexcludedshipments (long ala_ids[]);//Returns : >= 0 The number of excluded shipments in the array, after it is shrunk.
// -1 = Error

n_cst_AnyArraySrv	lnv_Arrays
Long	ll_Return

ll_Return = lnv_Arrays.of_GetShrinked ( ala_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink dupes*/ )

IF ll_Return >= 0 THEN
	ila_ExcludedShipments = ala_Ids
	This.of_MarkShipmentStopDataExcluded ( )
ELSE
	ll_Return = -1
END IF

RETURN ll_Return
end function

public function integer of_clearexcludedshipments ();//Clears the excluded shipment list.
//Returns : 1, -1

Long	lla_Empty[]

Integer	li_Return = -1

IF This.of_SetExcludedShipments ( lla_Empty ) = 0 THEN
	li_Return = 1
END IF

RETURN li_Return
end function

protected function integer of_markshipmentstopdataexcluded ();//If the ShipmentStopData datastore has been instantiated, this function marks it with any
//shipments that have been designated as "excluded."  Existing markings are cleared first, 
//so this function can be used to reset the markings after a change in the excluded list.

//If the ShipmentStopData datastore has not been instantiated, this function does nothing --
//it DOES NOT instantiate the datastore if it has not already been created elsewhere.

//Returns : 1 = Success, 0 = ids_ShipmentStopData not instantiated, no processing necessary, 
//-1 = Error

DataStore	lds_Data
Long			ll_RowCount, &
				ll_ExcludedCount, &
				lla_ExcludedShipments[], &
				lla_Zeroes[], &
				ll_Index, &
				ll_Id, &
				ll_Row
DWObject		ldwo_Excluded

Integer		li_Return = 1


IF li_Return = 1 THEN

	lds_Data = ids_ShipmentStopData  //Don't call of_GetShipmentStopData, because we don't want to
	//force the datastore to be created if it's not already.
	
	IF IsValid ( lds_Data ) THEN
		ll_RowCount = lds_Data.RowCount ( )
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 AND ll_RowCount > 0 THEN

	//First, clear all the existing "Excluded" flags by zeroing them out.

	ldwo_Excluded = lds_Data.Object.Excluded

	//Initialized the "Zeroes" array by putting an entry at the upperbound.  All entries below that
	//will be initialized by the system to 0 also.
	lla_Zeroes [ ll_RowCount ] = 0

	//Set these values onto the rows.
	ldwo_Excluded.Primary [ 1, ll_RowCount ] = lla_Zeroes


	//Now, go through and mark any excluded shipments with a 1.

	ll_ExcludedCount = This.of_GetExcludedShipments ( lla_ExcludedShipments )

	FOR ll_Index = 1 TO ll_ExcludedCount

		ll_Id = lla_ExcludedShipments [ ll_Index ]

		IF IsNull ( ll_Id ) THEN
			CONTINUE
		END IF

		ll_Row = lds_Data.Find ( "ShipmentId = " + String ( ll_Id ), 1, ll_RowCount )
		IF ll_Row > 0 THEN 
			ldwo_Excluded.Primary [ ll_Row ] = 1
		//ELSE
			//Not a problem if it's not found --it just may not be represented in the range
		END IF

	NEXT

END IF

//Cleanup
DESTROY ldwo_Excluded

RETURN li_Return
end function

public function long of_appendexcludedshipmentsforrange ();//Appends the excluded shipment list with any shipment ids represented in the current range
//that have not already been excluded.

//Returns : >= 0 The number of shipments ADDED to the exclude list (NOT the new absolute # in the list)
//-1 = Error

Long	lla_Ids[], &
		ll_Count, &
		ll_Return

ll_Count = This.of_GetShipmentIds ( lla_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/, &
	TRUE /*Use Excluded settings -- Remove already excluded shipments from the list*/ )

CHOOSE CASE ll_Count

CASE IS > 0

	This.of_AppendExcludedShipments ( lla_Ids )
	ll_Return = ll_Count

CASE 0
	ll_Return = 0

CASE ELSE
	ll_Return = -1

END CHOOSE

RETURN ll_Return
end function

public function long of_geteventcount ();//Returns : Number of Events in the range (>= 0).  Null if cannot be determined.

Long	ll_FirstRow, &
		ll_LastRow

Long	ll_Count = 0


CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

CASE 1
	ll_Count = ( ll_LastRow - ll_FirstRow ) + 1

	IF ll_Count >= 1 THEN
		//OK
	ELSE
		SetNull ( ll_Count )
	END IF

CASE 0  //No rows in range
	//Ok, but we now know our result should be zero.

CASE ELSE
	SetNull ( ll_Count )

END CHOOSE


RETURN ll_Count
end function

public function string of_getshipmentlist (boolean ab_useexclude);//Returns a list of shipments in the itinerary range, separated by commas.

//Returns : The list, or empty string if no values.  Does not return null.

Long	lla_Ids[], &
		ll_Count
n_cst_String	lnv_String

String	ls_Return

ll_Count = This.of_GetShipmentIds ( lla_Ids, TRUE /*Shrink nulls*/, TRUE /*Shrink Dupes*/, &
	ab_UseExclude )

IF ll_Count > 0 THEN

	lnv_String.of_ArrayToString ( lla_Ids, ", ", ls_Return )

	IF IsNull ( ls_Return ) THEN
		ls_Return = ""
	END IF

END IF

RETURN ls_Return
end function

public function decimal of_getpayables ();Boolean	lb_Finished
Long		lla_Ids[], &
			ll_Count
DataStore	lds_Total

Decimal {2}	lc_Result  //=0

IF lb_Finished = FALSE THEN

	IF NOT IsNull ( ic_Payables ) THEN
		lc_Result = ic_Payables
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	ll_Count = This.of_GetEventIds ( lla_Ids )

	IF IsNull ( ll_Count ) THEN
		SetNull ( lc_Result )
		lb_Finished = TRUE
	ELSEIF ll_Count = 0 THEN
		//No events, so no payables.  Allow value to be zero.
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	lds_Total = CREATE DataStore
	lds_Total.DataObject = "d_PaySplitsTotal_Events"
	lds_Total.SetTransObject ( SQLCA )

	CHOOSE CASE lds_Total.Retrieve ( lla_Ids )

	CASE 1  //Successfully retrieved one total row.
		lc_Result = lds_Total.Object.SplitsTotal [ 1 ]
		lb_Finished = TRUE

	CASE ELSE  //Error
		SetNull ( lc_Result )
		lb_Finished = TRUE

	END CHOOSE

	DESTROY lds_Total

END IF

IF NOT IsNull ( lc_Result ) THEN
	ic_Payables = lc_Result
END IF

RETURN lc_Result
end function

public function long of_geteventids (ref long ala_ids[]);//Get a list of all the event ids in the range.
//Returns : Number of Event Ids in the result array (>= 0).  Null if cannot be determined.

Long	ll_Row, &
		ll_FirstRow, &
		ll_LastRow, &
		lla_Ids[]
DataStore	lds_EventCache

Boolean	lb_Finished = FALSE

Long	ll_Count = 0

IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		//Ok, but we now know our result should be zero.
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		//OK
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	lla_Ids = lds_EventCache.Object.de_Id [ ll_FirstRow, ll_LastRow ]
	ll_Count = UpperBound ( lla_Ids )
	lb_Finished = TRUE

END IF

//Feed the id list back out, even if it's empty.
ala_Ids = lla_Ids

RETURN ll_Count
end function

public function long of_getlocationoptionalcount ();//Returns : Number of Events in the range that are LocationOptional (>= 0).
//Null if cannot be determined.

Long	ll_FirstRow, &
		ll_LastRow, &
		ll_Row
n_cst_Events	lnv_Events
DataStore		lds_EventCache
DWObject			ldwo_EventType

Long	ll_Count = 0


CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

CASE 1

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN

		ldwo_EventType = lds_EventCache.Object.de_Event_Type

		FOR ll_Row = ll_FirstRow TO ll_LastRow

			IF lnv_Events.of_IsTypeLocationOptional ( ldwo_EventType.Primary [ ll_Row ] ) THEN
				ll_Count ++
			END IF

		NEXT

	ELSE
		SetNull ( ll_Count )

	END IF

CASE 0  //No rows in range
	//Ok, but we now know our result should be zero.

CASE ELSE
	SetNull ( ll_Count )

END CHOOSE


RETURN ll_Count
end function

public function string of_getoriginlocation ();//Returns : Location, empty string (no first event), or null (cannot be determined)

//Note : This function will use the prior event row as the origin, if one exists.  Otherwise,
//it will use the first event row.  Therefore, it is necessary for of_InitTrip to have been
//performed, since that is what determines the prior row.  If the calling script wishes to 
//supply parameters to of_InitTrip or to get locator/site errors back from it, it needs to
//perform those calls BEFORE calling this function.

Long		ll_Row
n_cst_beo_Event	lnv_Event
n_cst_Trip			lnv_Trip

Boolean	lb_Finished
String	ls_Return

lnv_Event = CREATE n_cst_beo_Event

//Force trip to initialize if it hasn't already.  We need the prior event to be determined,
//and it's the initialization of the trip (via of_InitTrip) that does it.
//If of_GetTrip fails, we won't fail here -- we'll just take that to mean there's no prior event.
This.of_GetTrip ( lnv_Trip, TRUE /*Create If Needed*/ )


IF IsNull ( il_PriorEventRow ) THEN

	//There is no prior event row.
	//Use the first event row (if there is one) as the origin row.

	CHOOSE CASE This.of_GetFirstEventRow ( ll_Row )
	
	CASE 1 //Got it.
		//Proceed.
	
	CASE 0 //No events, therefore no row
	
		//Allow ls_Return to be empty string
		lb_Finished = TRUE
	
	CASE ELSE  //-1
	
		SetNull ( ls_Return )
		lb_Finished = TRUE
	
	END CHOOSE

ELSE
	//A prior event row has been determined.  Use it as the origin row.
	ll_Row = il_PriorEventRow

END IF


IF lb_Finished = FALSE THEN

	lnv_Event.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_Event.of_SetSourceRow ( ll_Row )

	ls_Return = lnv_Event.of_GetLocation ( )

END IF

DESTROY ( lnv_Event )


RETURN ls_Return
end function

public function string of_getdestinationlocation ();//Returns : Location, empty string (no last event), or null (cannot be determined)

Long		ll_Row
n_cst_beo_Event	lnv_Event

String	ls_Return

lnv_Event = CREATE n_cst_beo_Event

CHOOSE CASE This.of_GetLastEventRow ( ll_Row )

CASE 1 //Got it.

	lnv_Event.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_Event.of_SetSourceRow ( ll_Row )

	ls_Return = lnv_Event.of_GetLocation ( )

CASE 0 //No events, therefore no row

	//Allow ls_Return to be empty string

CASE ELSE  //-1

	SetNull ( ls_Return )

END CHOOSE

DESTROY ( lnv_Event )

RETURN ls_Return
end function

public function long of_gettrailerids (ref long ala_ids[], boolean ab_shrinkdupes);//Returns : Number of trailers listed in the result.  Null if cannot be determined.

Long	ll_FirstRow, &
		ll_LastRow, &
		ll_Row, &
		lla_List[]
DataStore	lds_EventCache
n_cst_AnyArraySrv	lnv_AnyArray
n_cst_beo_Event	lnv_Event

Long		ll_Count = 0
Boolean	lb_Finished = FALSE

lnv_Event = CREATE n_cst_beo_Event

//Clear reference array.
ala_Ids = lla_List


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range -- we know that the trailer count will be zero.
		//Allow count to stay zero, and flag that we're done
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		//OK
		lnv_Event.of_SetSource ( lds_EventCache )
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	FOR ll_Row = ll_FirstRow TO ll_LastRow

		lnv_Event.of_SetSourceRow ( ll_Row )
		lnv_Event.of_GetTrailerList ( lla_List, TRUE /*Append to the array*/ )

	NEXT

	ll_Count = lnv_AnyArray.of_GetShrinked ( lla_List, TRUE /*Shrink Nulls (but, there shouldn't be any)*/, &
		ab_ShrinkDupes )

	IF ll_Count >= 0 THEN
		ala_Ids = lla_List
	ELSE
		SetNull ( ll_Count )
	END IF

	lb_Finished = TRUE

END IF

DESTROY ( lnv_Event )

RETURN ll_Count
end function

public function long of_getcontainerids (ref long ala_ids[], boolean ab_shrinkdupes);//Returns : Number of containers listed in the result.  Null if cannot be determined.

Long	ll_FirstRow, &
		ll_LastRow, &
		ll_Row, &
		lla_List[]
DataStore	lds_EventCache
n_cst_AnyArraySrv	lnv_AnyArray
n_cst_beo_Event	lnv_Event

Long		ll_Count = 0
Boolean	lb_Finished = FALSE

lnv_Event = CREATE n_cst_beo_Event

//Clear reference array.
ala_Ids = lla_List


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range -- we know that the container count will be zero.
		//Allow count to stay zero, and flag that we're done
		lb_Finished = TRUE

	CASE ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		//OK
		lnv_Event.of_SetSource ( lds_EventCache )
	ELSE
		SetNull ( ll_Count )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	FOR ll_Row = ll_FirstRow TO ll_LastRow

		lnv_Event.of_SetSourceRow ( ll_Row )
		lnv_Event.of_GetContainerList ( lla_List, TRUE /*Append to the array*/ )

	NEXT

	ll_Count = lnv_AnyArray.of_GetShrinked ( lla_List, TRUE /*Shrink Nulls (but, there shouldn't be any)*/, &
		ab_ShrinkDupes )

	IF ll_Count >= 0 THEN
		ala_Ids = lla_List
	ELSE
		SetNull ( ll_Count )
	END IF

	lb_Finished = TRUE

END IF

DESTROY ( lnv_Event ) 

RETURN ll_Count
end function

public function string of_gettrailerlist ();//Returns : A semicolon (actually, space semicolon space) delimited list of trailers 
//in the itinerary range (in the order they're first encountered, with no repetition), 
//or Null if cannot be determined.  If we get a valid id list and then can't resolve one
//or more descriptions, we write an error notification into the list.  So, you won't get
//null if there's an error resolving an individual id.

Long	lla_Ids[], &
		ll_Count
n_cst_EquipmentManager	lnv_EquipmentManager

String	ls_List

ll_Count = This.of_GetTrailerIds ( lla_Ids, TRUE /*Shrink Dupes*/ )

IF IsNull ( ll_Count ) THEN

	SetNull ( ls_List )

ELSEIF ll_Count = 0 THEN

	//Return empty list (empty string)

ELSE

	ls_List = lnv_EquipmentManager.of_GetDescriptions ( lla_Ids, "SHORT_REF!", &
		TRUE /*Describe Errors*/, FALSE /*Don't ignore nulls*/ )

	//Using the Don't Ignore Nulls option because there shouldn't be any nulls, 
	//since they're already shrunk out, above.  So, if there are any, it's an error and
	//should be noted.

END IF

RETURN ls_List
end function

public function string of_getcontainerlist ();//Returns : A semicolon (actually, space semicolon space) delimited list of containers 
//in the itinerary range (in the order they're first encountered, with no repetition), 
//or Null if cannot be determined.  If we get a valid id list and then can't resolve one
//or more descriptions, we write an error notification into the list.  So, you won't get
//null if there's an error resolving an individual id.

Long	lla_Ids[], &
		ll_Count
n_cst_EquipmentManager	lnv_EquipmentManager

String	ls_List

ll_Count = This.of_GetContainerIds ( lla_Ids, TRUE /*Shrink Dupes*/ )

IF IsNull ( ll_Count ) THEN

	SetNull ( ls_List )

ELSEIF ll_Count = 0 THEN

	//Return empty list (empty string)

ELSE

	ls_List = lnv_EquipmentManager.of_GetDescriptions ( lla_Ids, "SHORT_REF!", &
		TRUE /*Describe Errors*/, FALSE /*Don't ignore nulls*/ )

	//Using the Don't Ignore Nulls option because there shouldn't be any nulls, 
	//since they're already shrunk out, above.  So, if there are any, it's an error and
	//should be noted.

END IF

RETURN ls_List
end function

public function integer of_setdiscardoptional (boolean ab_value);//Change the DiscardOptional default, which is used by of_InitTrip, 
//if a parameter is not supplied directly.  Note : This will NOT change
//or destroy an EXISTING trip that has already been created with of_InitTrip.

//If null is provided here, of_InitTrip will use the default value FALSE.

//Returns : 1, -1

ib_DiscardOptional = ab_Value

RETURN 1
end function

public function integer of_setroutetype (long al_value);//Change the RouteType default, which is used by of_InitTrip, 
//if a parameter is not supplied directly.  Note : This will NOT change
//or destroy an EXISTING trip that has already been created with of_InitTrip.

//If null is supplied, of_InitTrip will use the system default route type.

//Returns : 1, -1

il_RouteType = al_Value

RETURN 1
end function

public function integer of_setdestroytripondestroy (boolean ab_switch);Integer	li_Return = 1

IF IsNull ( ab_Switch ) THEN
	li_Return = -1
ELSE
	ib_DestroyTripOnDestroy = ab_Switch
END IF

RETURN li_Return

end function

public function integer of_geteventlist (ref n_cst_beo_event anva_beo[]);IF NOT ib_eventscached THEN

	Long	i
	Int	li_Index
	
	FOR i = il_firsteventrow TO il_lasteventrow
		li_Index ++	
		anva_Beo[li_Index] = CREATE n_cst_beo_Event
		anva_Beo[li_Index].of_SetSource ( ids_eventcache )
		anva_Beo[li_Index].of_SetSourceRow ( i )
	NEXT
	
	inva_events = anva_Beo
	ib_eventscached = TRUE

ELSE
	anva_Beo = inva_events
	li_index = UpperBound ( anva_beo[] )
END IF 
RETURN li_Index

end function

public function integer of_getnexteventlist (ref n_cst_beo_event anva_beo[]);// this method will return a list of events. the first event will be the first unconfirmed 
// event in the itinerary after the last confirmed event

IF NOT ib_nextcached THEN
	
	Long	i
	Long	ll_FirstRow
	Long	ll_LastConfirmed
	Int	li_Index
	
	// First find the last confirmed event
	ll_LastConfirmed = ids_eventcache.Find ( "de_conf='T'", il_lasteventrow ,il_firsteventrow )
	
	IF ll_LastConfirmed < il_lasteventrow THEN
		// find the first unconfirmed event in the itinerary after the last confirmed
		ll_FirstRow = ids_eventcache.Find ( "de_conf='F'", ll_LastConfirmed, il_lasteventrow )
	
	
	
		FOR i = ll_FirstRow TO il_lasteventrow	
			li_Index ++	
			anva_Beo[li_Index] = CREATE n_cst_beo_Event
			anva_Beo[li_Index].of_SetSource ( ids_eventcache )
			anva_Beo[li_Index].of_SetSourceRow ( i )
		NEXT
		
	END IF
	
	FOR i = 1 TO UpperBound ( inva_NextEvents )
		DESTROY ( inva_NextEvents[i] )
	NEXT
	
	inva_nextevents = anva_Beo
	ib_nextcached = TRUE
ELSE
	anva_Beo = inva_nextevents
END IF

RETURN li_Index

end function

public function integer of_getlastconfirmedevent (ref n_cst_beo_event anva_event[]);
IF NOT ib_lastconfirmedcached THEN
	Long	i
	Long	ll_FirstRow
	Int	li_Index
	
	// find the Last confirmed event in the itinerary 
	// by searching backwards
	ll_FirstRow = ids_eventcache.Find ( "de_conf='T'", il_lasteventrow ,il_firsteventrow )
	
	IF ll_FirstRow > 0 THEN
		li_Index ++	
		anva_Event[li_Index] = CREATE n_cst_beo_Event
		anva_event[li_Index].of_SetSource ( ids_eventcache )
		anva_event[li_Index].of_SetSourceRow ( ll_FirstRow )
	END IF
	
	FOR i = 1 TO UpperBound ( inva_lastconfirmedevents )
		DESTROY ( inva_lastconfirmedevents [i] )
	NEXT
	
	inva_lastconfirmedevents = anva_event
	ib_lastconfirmedcached = TRUE
	
ELSE
	anva_event = inva_lastconfirmedevents
	li_Index = UpperBound ( anva_event )
	
END IF

RETURN li_Index

end function

public function string of_getpowerunitnotes ();String	ls_Return 
String	ls_note
Long		lla_Ids[]
Long		ll_Count
Long		i


n_cst_bcm	lnv_Cache
n_cst_beo_equipment	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_equipment"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

this.of_getpowerunitids ( lla_Ids, TRUE, TRUE )


//n_cst_EquipmentManager	lnv_Manager
//
//lnv_Manager.of_GetCache ( lnv_Cache )
//

ll_Count = UpperBound ( lla_Ids )
IF ll_Count > 0 THEN
	IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
		li_Return = 0
	END IF
END IF



IF li_Return = 0 THEN

	FOR i = 1 TO ll_Count
		
		lnv_Beo = lnv_Cache.getBeo("equipment_id=" + String ( lla_Ids[i] ) )
		IF isValid(lnv_Beo) THEN
			IF i <> 1 THEN
				ls_Return += " ; "
			END IF
			ls_Note = lnv_Beo.of_GetNotes ( )
			IF Len ( ls_Note ) > 0 THEN
				ls_Return += ls_Note
			END IF
		END IF
	
	NEXT
END IF


RETURN ls_Return

end function

public function string of_gettrailernotes ();String	ls_Return 
String	ls_Note
Long		lla_Ids[]
Long		ll_Count
Long		i

n_cst_bcm	lnv_Cache
n_cst_beo_equipment	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_equipment"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

this.of_getTrailerids ( lla_Ids, TRUE )


ll_Count = UpperBound ( lla_Ids )
IF ll_Count > 0 THEN
	IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
		li_Return = 0
	END IF
END IF



IF li_Return = 0 THEN

	FOR i = 1 TO ll_Count
		
		lnv_Beo = lnv_Cache.getBeo("equipment_id=" + String ( lla_Ids[i] ) )
		IF isValid(lnv_Beo) THEN
			IF i <> 1 THEN
				ls_Return += " ; "
			END IF
			ls_Note = lnv_Beo.of_GetNotes ( )
			IF len ( ls_Note ) > 0 THEN			
				ls_Return += ls_Note
			END IF
		END IF
	
	NEXT
END IF


RETURN ls_Return

end function

public function string of_getcontainernotes ();String	ls_Return 
String	ls_Note
Long		lla_Ids[]
Long		ll_Count
Long		i

n_cst_bcm	lnv_Cache
n_cst_beo_equipment	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_equipment"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

this.of_getContainerids ( lla_Ids, TRUE )


ll_Count = UpperBound ( lla_Ids )
IF ll_Count > 0 THEN
	IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
		li_Return = 0
	END IF
END IF



IF li_Return = 0 THEN

	FOR i = 1 TO ll_Count
		
		lnv_Beo = lnv_Cache.getBeo("equipment_id=" + String ( lla_Ids[i] ) )
		IF isValid(lnv_Beo) THEN
			IF i <> 1 THEN
				ls_Return += " ; "
			END IF
			ls_Note = lnv_Beo.of_GetNotes ( )
			IF Len ( ls_note ) > 0 THEN
				ls_Return += ls_Note
			END IF
				
		END IF
	
	NEXT
END IF


RETURN ls_Return

end function

public function long of_getlastconfirmedeventrow ();Long	ll_LastConfirmed

IF isValid ( ids_eventcache ) THEN
	ll_LastConfirmed = ids_eventcache.Find ( "de_conf='T'", il_lasteventrow ,il_firsteventrow )
END IF

RETURN ll_LastConfirmed
end function

public function string of_getlastconfirmeddriver ();
String	ls_Return

n_cst_beo_Event	lnva_Event[]

THIS.of_GetLastConfirmedEvent ( lnva_Event )

IF UpperBound ( lnva_Event ) > 0 THEN
	ls_Return = lnva_Event[1].of_GetDriver ( )
END IF


RETURN ls_Return
end function

public function boolean of_validateeventid (long al_eventid);/***************************************************************************************
NAME: 			of_ValidateEventID

ACCESS:			Public
	
ARGUMENTS: 		Long
					Event id

RETURNS:			Boolean
	
DESCRIPTION:	This method will return true id the event id passed in is part of the 
					itinerary


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	CREATED April 12, 2002 RPZ




***************************************************************************************/
Long	lla_EventIDs[]
Int	li_Count
Int	i = 1

THIS.of_GetEventIds ( lla_EventIds )

li_Count = UpperBound ( lla_EventIds )

FOR i = 1 TO li_Count
	IF al_EventID = lla_EventIds[i] THEN 
		EXIT
	END IF
NEXT

RETURN NOT i > li_Count

end function

private function integer of_destroy (ref n_cst_beo_Event anva_Events[]);
Int	li_Count
Int	i

li_Count = UpperBound ( anva_Events[] )
FOR i = 1 TO li_count
	DESTROY ( anva_Events[i] )
NEXT

RETURN 1
end function

public function integer of_getshipmenttypes (ref long ala_types[]);integer	li_return=1
Long		lla_Id[]


/*MFS 6/7/07 - There is no need to retrieve the entire shipment here
this.of_GetShipment( lnva_Shipment )

this.of_GetShipmentTypes(lnva_Shipment, lla_ShipmentType)
*/

/*MFS 6/7/07 - Lets just get the types instead*/

This.of_Getshipmentids( lla_id, true, true)

This.of_GetShipmentTypes(lla_Id, ala_Types)

Return li_return
end function

public function long of_getshipment (ref n_cst_beo_shipment anva_shipment[]);long	lla_id[], &
		ll_shipmentcount, &
		ll_shipmentindex, &
		ll_BeoCount

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_shipment	lnva_ShipmentBeo[]
n_ds	lds_ShipmentCache
		
this.of_Getshipmentids( lla_id, true, true)

this.of_GetShipment( lla_id, lnva_ShipmentBeo)
anva_shipment = lnva_ShipmentBeo

return upperbound(lnva_shipmentbeo)
end function

public function integer of_getshipmenttypes (n_cst_beo_shipment anva_shipment[], ref long ala_types[]);integer	li_return=1

long		ll_shipmentindex, &
			ll_shipmentcount, &
			ll_shipmenttype, &
			lla_shipmenttype[], &
			ll_arraycount
			
n_cst_anyarraysrv		lnv_Arraysrv

ll_shipmentcount = upperbound(anva_shipment)

for ll_shipmentindex = 1 to ll_shipmentcount
	ll_shipmenttype = 0
	ll_shipmenttype = anva_shipment[ll_shipmentindex].of_GetType()
	if ll_shipmenttype > 0 then
		ll_arraycount ++
		lla_shipmenttype[ll_arraycount] = ll_shipmenttype
	end if
next

lnv_Arraysrv.of_GetShrinked ( lla_shipmenttype, TRUE /*Shrink Nulls */, TRUE /*Shrink dupes */)

ala_types = lla_shipmenttype

return li_return
end function

public function long of_getshipment (long ala_id[], ref n_cst_beo_shipment anva_shipment[]);long	ll_shipmentcount, &
		ll_shipmentindex, &
		ll_BeoCount

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_shipment	lnva_ShipmentBeo[]

n_ds			lds_ShipmentCache, &
				lds_ItemCache, &
				lds_EventCache

ll_shipmentCount = upperbound ( ala_Id )
ll_BeoCount = upperbound ( anva_Shipment)

lnv_Dispatch = this.of_GetDispatchManager()

IF isValid ( lnv_Dispatch ) THEN
	//got one
else
	lnv_Dispatch = create n_cst_bso_dispatch
	this.of_SetDispatchManager(lnv_Dispatch)
end if
	
lnv_Dispatch.of_RetrieveShipments ( ala_Id )
lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )
lds_ItemCache = lnv_Dispatch.of_GetItemCache()
lds_EventCache = lnv_Dispatch.of_GetEventCache()

IF isValid ( lds_ShipmentCache ) THEN
	lds_ShipmentCache.SetFilter ( "" )
	lds_ShipmentCache.SetSort ( "ds_id A" )
	lds_ShipmentCache.Filter ( )
	lds_ShipmentCache.Sort ( )
	
	FOR ll_ShipmentIndex = 1 TO ll_ShipmentCount

		ll_BeoCount ++
		lnva_ShipmentBeo [ ll_BeoCount ] = CREATE n_cst_beo_shipment
		lnva_ShipmentBeo [ ll_BeoCount ].of_SetSource ( lds_ShipmentCache )
		lnva_ShipmentBeo [ ll_BeoCount ].of_SetSourceId ( ala_Id [ ll_ShipmentIndex ] )
		lnva_ShipmentBeo [ ll_BeoCount ].of_SetItemSource(lds_ItemCache)
		lnva_ShipmentBeo [ ll_BeoCount ].of_SetEventSource(lds_EventCache)

	NEXT
END IF

anva_shipment = lnva_ShipmentBeo

return upperbound(lnva_shipmentbeo)
end function

public subroutine of_reseteventlist ();//this will force of_GetEventList to use the eventcache based on the new first and last row
ib_EventsCached = false
end subroutine

public function integer of_geteventlist (ref n_cst_beo_event anva_event[], boolean ab_useexclude);integer	li_return, &
			li_index, &
			li_count
			
long		ll_ship, &
			ll_ExcludeCount, &
			lla_ExcludedShipments[], &
			ll_null

n_cst_AnyArraySrv		lnv_ArraySrv
n_cst_beo_event		lnva_event[], &
							lnva_excludeevent[]
setnull(ll_null)

li_count = this.of_geteventlist(lnva_event)

if ab_useexclude then

	ll_ExcludeCount = This.of_GetExcludedShipments ( lla_ExcludedShipments )
		
	if ll_ExcludeCount > 0 then
		for li_index = 1 to li_count
			
			ll_ship = lnva_event[li_index].of_Getshipment()
			
			if ll_ship > 0 then
				if lnv_ArraySrv.of_find(lla_ExcludedShipments, ll_ship, ll_null, ll_null) > 0 then
					//exclude
				else
					
					lnva_excludeevent[upperbound(lnva_excludeevent) + 1] = lnva_event[li_index]
					
				end if
			end if
			
		next
	else
		lnva_excludeevent = lnva_event
	end if
	
	anva_event = lnva_excludeevent
	
else
	
	anva_event = lnva_event

end if

return upperbound(anva_event)
end function

public function long of_getshipmentstopdata (ref datastore ads_data, boolean ab_payables);Long	lla_ShrunkList[], &
		ll_ShrunkCount, &
		lla_FullList[], &
		ll_FullCount, &
		ll_CalcRows, &
		ll_Index, &
		ll_Row, &
		ll_Id, &
		ll_StopCount
DataStore	lds_Data
DWObject		ldwo_StopCount

Long		ll_Return //=0
Boolean	lb_Finished = FALSE


IF IsValid ( ads_Data ) THEN
	DESTROY ads_Data
END IF

//If we've already loaded the ShipmentStopData datastore on a previous call for this range,
//use what we've got.  (Calls to of_SetRange destroy the datastore, so it will be forced to
//recreate on subsequent calls.)

IF IsValid ( ids_ShipmentStopData ) THEN

	lds_Data = ids_ShipmentStopData
	ll_CalcRows = lds_Data.RowCount ( )

	IF ll_CalcRows >= 0 THEN
		ll_Return = ll_CalcRows
	ELSE
		ll_Return = -1
	END IF

	lb_Finished = TRUE

END IF


IF lb_Finished = FALSE THEN

	ll_FullCount = This.of_GetShipmentIds ( lla_FullList, FALSE /*Do not Shrink Nulls*/, &
		FALSE /*Do not shrink dupes*/, FALSE /*Don't exclude ids in of_GetExcludedShipments*/ )
	//We want the whole list.  Excluded shipments will be included in the retrieval, but
	//flagged as such, so that subsequent processing can provide both Excluded and 
	//and non-Excluded calculation options.  If we didn't retrieve them here, those
	//functions would not be able to support the non-Excluded calculations.
	
	IF ll_FullCount > 0 THEN
		ll_ShrunkCount = This.of_GetShipmentIds ( lla_ShrunkList, TRUE /*Shrink Nulls*/, &
			TRUE /*Shrink dupes*/, FALSE /*Don't exclude ids in of_GetExcludedShipments*/ )
	ELSEIF ll_FullCount = 0 THEN
		//OK, but no need to get the shrunk list, above.  We now know the shipment stop count is 0.
		lb_Finished = TRUE
	ELSE
		//Null, or unexpected value.
		ll_Return = -1
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN
	IF ll_ShrunkCount > 0 THEN
		//OK
	ELSEIF ll_ShrunkCount = 0 THEN
		//OK, but we now know the revenue will be zero, because we have no shipment events.
		//A fullcount > 0 can shrink down to zero, because fullcount will include all the 
		//entries, even if they're null.
		lb_Finished = TRUE
	ELSE
		ll_Return = -1
		lb_Finished = TRUE
	END IF
END IF

IF lb_Finished = FALSE THEN

	lds_Data = CREATE DataStore
	IF NOT ab_payables THEN
		lds_Data.DataObject = "d_ShipmentStopData"
	ELSE
		lds_Data.DataObject = "d_ShipmentStopDataPayable"
	END IF
	lds_Data.SetTransObject ( SQLCA )
	ldwo_StopCount = lds_Data.Object.StopCount

	ll_CalcRows = lds_Data.Retrieve ( lla_ShrunkList )
	COMMIT ;

	//Note on this choose case : the CalcRows should match ll_ShrunkCount.  I'm enforcing that
	//comparison here, although we could possibly go with the looser version that's commented out.

	CHOOSE CASE ll_CalcRows

	CASE ll_ShrunkCount
		//OK

//	CASE IS > 0
//		//OK
//
//	CASE 0
//		//Ok, but we now know there's no shipment stop data.
//		lb_Finished = TRUE

	CASE ELSE
		ll_Return = -1
		lb_Finished = TRUE

	END CHOOSE

END IF

IF lb_Finished = FALSE THEN

	FOR ll_Index = 1 TO ll_FullCount

		IF IsNull ( lla_FullList [ ll_Index ] ) THEN
			CONTINUE
		ELSEIF lla_FullList [ ll_Index ] = ll_Id THEN
			//Same Id as on the last pass.  Use StopCount from last pass
		ELSE
			ll_Id = lla_FullList [ ll_Index ]
			ll_Row = lds_Data.Find ( "ShipmentId = " + String ( ll_Id ), 1, ll_CalcRows )
			IF ll_Row > 0 THEN
				ll_StopCount = ldwo_StopCount.Primary [ ll_Row ]
			ELSE
				ll_Return = -1
				lb_Finished = TRUE
				EXIT
			END IF
		END IF

		ll_StopCount ++

		IF ll_Row > 0 THEN  //Should be, if we made it here.
			ldwo_StopCount.Primary [ ll_Row ] = ll_StopCount
		ELSE
			ll_Return = -1
			lb_Finished = TRUE
			EXIT
		END IF

	NEXT

END IF


IF lb_Finished = FALSE THEN

	IF ll_CalcRows >= 0 THEN
		ll_Return = ll_CalcRows
	ELSE
		ll_Return = -1
	END IF

	lb_Finished = TRUE

END IF

DESTROY ldwo_StopCount

IF ll_Return >= 0 THEN
	ids_ShipmentStopData = lds_Data
	This.of_MarkShipmentStopDataExcluded ( )
	ads_Data = lds_Data
ELSE
	DESTROY lds_Data
END IF

RETURN ll_Return
end function

public function decimal of_getfreightrevenue (boolean ab_payable);//Returns : Value for freight revenue, or null if cannot be determined.

//The value is a composite of two calculations, one for stops whose shipments do not
//have splits assigned, and the other for stops whose shipments do have splits assigned.

String		ls_Result
DataStore	lds_Calc, &
				lds_EventCache
Boolean		lb_Finished
Long			ll_Row, &
				ll_FirstRow, &
				ll_LastRow
DWObject		ldwo_FreightSplit
Decimal {2}	lc_FreightSplit

Decimal {2}	lc_Result  //=0


IF lb_Finished = FALSE THEN

	//Check the instance variable to see if a value has already been determined.
	//If so, use it, and flag that we're finished.

	IF NOT IsNull ( ic_FreightRevenue ) THEN
		lc_Result = ic_FreightRevenue
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetShipmentStopData ( lds_Calc , ab_Payable )
	
	CASE IS > 0  //Return value is the number of shipment entries.  We have revenue stops.
	
		//The StopRevenue value on d_ShipmentStopData only fills in for shipments that 
		//DO NOT have revenue splits assigned.  So, the value we're pulling here is only
		//for stops whose shipments do not have splits assigned.  For stops whose shipments
		//do have splits assigned, we'll pull those split values directly from the stops
		//themselves, in the calculation that follows.

		ls_Result = lds_Calc.Describe ( "Evaluate ( 'Sum ( StopRevenue FOR All )', 1 )" )
		IF IsNumber ( ls_Result ) THEN
			lc_Result = Dec ( ls_Result )
		ELSE
			SetNull ( lc_Result )
		END IF
	
	CASE 0  //No shipment stops
		//No revenue -- Allow lc_Result to be zero
		//With no shipment stops, there can be no revenue, from this calculation or the next one.
		lb_Finished = TRUE
	
	CASE ELSE  // -1 : Error
		SetNull ( lc_Result )
		lb_Finished = TRUE
	
	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.of_GetFirstLastEventRow ( ll_FirstRow, ll_LastRow )

	CASE 1
		//OK

	CASE 0  //No rows in range
		//Shouldn't happen, given the conditions above.  Nothing to add to the result.
		lb_Finished = TRUE

	CASE ELSE  //Error
		SetNull ( lc_Result )
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF IsValid ( lds_EventCache ) THEN
		ldwo_FreightSplit = lds_EventCache.Object.de_FreightSplit
	ELSE
		SetNull ( lc_Result )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	ll_Row = ll_FirstRow

	DO

		ll_Row = lds_EventCache.Find ( "de_FreightSplit <> 0", ll_Row, ll_LastRow )
	
		IF ll_Row > 0 THEN

//			NOTE : Doing the following calculation this way produced incorrect results
//			(without extensive testing, it seemed like the value already in lc_Result
//			was being doubled, instead of having the value from the dwo added to it.)
//			So, I replaced this code with reading the dwo value out to a variable, then
//			adding to it, and that worked fine.
//			lc_Result += ldwo_FreightSplit.Primary [ ll_Row ]

			lc_FreightSplit = ldwo_FreightSplit.Primary [ ll_Row ]
			lc_Result += lc_FreightSplit

			ll_Row ++ //Advance row so we start the next search after the row just found.

		END IF

	LOOP WHILE ll_Row > 0 AND ll_Row <= ll_LastRow

END IF


DESTROY ldwo_FreightSplit

//If we successfully determined a value, store it on the instance variable.
IF NOT IsNull ( lc_Result ) THEN
	ic_FreightRevenue = lc_Result
END IF

RETURN lc_Result
end function

public function decimal of_gettotalweight (boolean ab_useexclude, boolean ab_payables);//Returns : Total weight hauled in the itinerary, or null if cannot be determined.

String	ls_Result
DataStore	lds_Calc
String	ls_Expression

Decimal	lc_Result  //=0

CHOOSE CASE This.of_GetShipmentStopData ( lds_Calc , ab_payables )

CASE IS > 0

	IF ab_UseExclude OR IsNull ( ab_UseExclude ) THEN
		ls_Expression = "Evaluate ( 'Sum ( ( TotalWeight * ( 1 - Excluded ) ) FOR All )', 1 )"
	ELSE
		ls_Expression = "Evaluate ( 'Sum ( TotalWeight FOR All )', 1 )"
	END IF

	ls_Result = lds_Calc.Describe ( ls_Expression )
	IF IsNumber ( ls_Result ) THEN
		lc_Result = Dec ( ls_Result )
	ELSE
		SetNull ( lc_Result )
	END IF

CASE 0  //No shipment stops
	//No revenue -- Allow lc_Result to be zero

CASE ELSE  // -1 : Error
	SetNull ( lc_Result )

END CHOOSE

RETURN lc_Result
end function

public function integer of_resetstopdata ();DESTROY ( ids_shipmentstopdata )
RETURN 1
end function

public function integer of_getshipmenttypes (long ala_id[], ref long ala_types[]);Integer	li_Return = 1
Long		lla_shipmenttype[]
Long		lla_Id[]
Long		ll_Count
Long		i

			
n_cst_beo_shipment	lnva_shipment[]
n_cst_anyarraysrv		lnv_Arraysrv
DataStore				lds_ShipTypes

lds_ShipTypes = Create DataStore
lds_ShipTypes.DataObject = "d_shipmentshiptype"
lds_ShipTypes.SetTransObject(SQLCA)

IF UpperBound(ala_Id) > 0 THEN
	
	IF lds_ShipTypes.Retrieve(ala_Id) = -1 THEN
		li_Return = -1
		RollBack;
	ELSE
		Commit;
	END IF

	IF li_Return = 1 THEN
		ll_Count = lds_ShipTypes.RowCount()
		FOR i = 1 TO ll_Count
			lla_ShipmentType[i] = lds_ShipTypes.GetItemNumber(i, "ds_ship_type")
		NEXT
	END IF
	
	lnv_Arraysrv.of_GetShrinked ( lla_ShipmentType, True, True)
	
END IF


ala_types = lla_shipmenttype

Destroy(lds_ShipTypes)

Return li_Return
end function

on n_cst_beo_itinerary2.create
call super::create
end on

on n_cst_beo_itinerary2.destroy
call super::destroy
end on

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "TOTALMILES"
			aa_Value = This.of_GetTotalMiles ( )
			
		CASE "LOADEDMILES"
			aa_Value = This.of_GetLoadedMiles ( )
			
		CASE "EMPTYMILES"
			aa_Value = This.of_GetEmptyMiles ( )
			
		CASE "BOBTAILMILES"
			aa_Value = This.of_GetBobtailMiles ( )
			
		CASE "DEADHEADMILES"
			aa_Value = This.of_GetDeadheadMiles ( )
			
		CASE "FREIGHTREVENUE"
			aa_Value = This.of_GetFreightRevenue ( )

		CASE "PAYABLES"
			aa_Value = This.of_GetPayables ( )
			
		CASE "TOTALWEIGHT"
			aa_Value = This.of_GetTotalWeight ( )
			
		CASE "SHIPMENTS"
			aa_Value = This.of_GetShipmentCount ( )
			
		CASE "STOPS"
			aa_Value = This.of_GetStopCount ( )
			
		CASE "STOPOFFS"
			aa_Value = This.of_GetStopOffCount ( )
			
		CASE "WORKINGSTOPS"
			aa_Value = This.of_GetWorkingStopCount ( )
			
		CASE "EVENTS"
			aa_Value = This.of_GetEventCount ( )

		CASE "PICKUPS"
			aa_Value = This.of_GetPickupCount ( )
			
		CASE "DELIVERIES"
			aa_Value = This.of_GetDeliveryCount ( )
			
		CASE "HOOKS"
			aa_Value = This.of_GetHookCount ( )
			
		CASE "DROPS"
			aa_Value = This.of_GetDropCount ( )
			
		CASE "MOUNTS"
			aa_Value = This.of_GetMountCount ( )
			
		CASE "DISMOUNTS"
			aa_Value = This.of_GetDismountCount ( )

		CASE "DRIVERLIST"
			aa_Value = This.of_GetDriverList ( )

		CASE "POWERUNITLIST"
			aa_Value = This.of_GetPowerUnitList ( )

		CASE "TRAILERLIST"
			aa_Value = This.of_GetTrailerList ( )

		CASE "CONTAINERLIST"
			aa_Value = This.of_GetContainerList ( )

		CASE "STARTDATE"
			aa_Value = This.of_GetStartDate ( )

		CASE "ENDDATE"
			aa_Value = This.of_GetEndDate ( )

		CASE "ITINERARYFOR"
			aa_Value = This.of_GetItineraryFor ( )

		CASE "ITINERARYHOURS"
			aa_Value = This.of_GetItineraryHoursTotal ( )

		CASE "SHIPMENTLIST"
			aa_Value = This.of_GetShipmentList ( TRUE /*UseExclude*/ )

		CASE "ORIGINLOCATION"
			aa_Value = This.of_GetOriginLocation ( )

		CASE "DESTINATIONLOCATION"
			aa_Value = This.of_GetDestinationLocation ( )
		
// new tags as of Feb, 19 2002		
		CASE "POWERUNITNOTES"
			aa_Value = THIS.of_GetPowerUnitNotes ( )
				
		CASE "TRAILERNOTES"
			aa_Value = THIS.of_GetTrailerNotes ( )
			
		CASE "CONTAINERNOTES"
			aa_Value = THIS.of_GetContainerNotes ( )
		
		CASE "LASTCONFIRMEDDRIVER"
			aa_Value = THIS.of_GetLastConfirmedDriver ( )
			
		
		
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
			
		CASE  "FREIGHTREVENUE"
			as_Format = "0.00##"
			
		CASE "TOTALMILES", "LOADEDMILES", "EMPTYMILES", "BOBTAILMILES", "DEADHEADMILES", &
			"SHIPMENTS", "TOTALWEIGHT"

			as_Format =  "0.0##"

		CASE "STARTDATE", "ENDDATE"
			as_Format = "m/d/yy"

		CASE ELSE
			li_Return = 0
			
	END CHOOSE

END IF 

RETURN li_Return
end event

event constructor;call super::constructor;SetNull ( il_FirstEventRow )
SetNull ( il_LastEventRow )
SetNull ( il_PriorEventRow )

SetNull ( id_Start )
SetNull ( id_End )
SetNull ( ii_ItinType )
SetNull ( il_ItinId )

SetNull ( ic_FreightRevenue )
SetNull ( ic_Payables )

SetNull ( il_RouteType )

RETURN AncestorReturnValue
end event

event destructor;//DESTROY inv_Trip ??????
//We are not currently destroying inv_Trip on n_cst_beo_Itinerary2 in the Destructor.  
//This is possibly because outside objects can get a reference to the trip, and I didn't want to step on them.  
//The only outside reference I see at this point is in n_cst_beo_FuelTax.of_ProcessFuelTax.  
//We could change this over to a setting that would conditionally destroy, but I'd like the default in that case 
//to be to destroy, so the current call may need to set the setting in Fuel Tax.

//Conditionally destroy the trip.  This is so that other scripts have the option of keeping
//the trip once the itinerary object goes out of scope.  The default is TRUE (destroy the trip.)

IF ib_DestroyTripOnDestroy = TRUE THEN
	DESTROY inv_Trip
END IF

DESTROY ids_ShipmentStopData
THIS.of_Destroy ( inva_events[] )
THIS.of_Destroy ( inva_lastconfirmedevents[] )
THIS.of_Destroy ( inva_nextevents[] )
end event

event ue_getobject;call super::ue_getobject;//Extending Ancestor to provide object support for this class.

//See ancestor script for explanation of return codes.

Integer	li_Return
Long		ll_CompanyId
Any		laa_Beo[]
n_cst_beo_Event	lnva_Events[]

li_Return = AncestorReturnValue
aaa_Beo = laa_Beo


IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_ObjectName ) )

	CASE "NEXTEVENT"  
		THIS.of_GetNextEventList ( lnva_Events )
		aaa_beo = lnva_Events
		
	CASE "EVENT"
		THIS.of_GetEventList ( lnva_Events )
		aaa_beo = lnva_Events
	
	CASE "LASTCONFIRMEDEVENT"
		THIS.of_GetLastConfirmedEvent ( lnva_Events )
		aaa_Beo = lnva_Events
	
	CASE ELSE
		li_Return = 0
			
	END CHOOSE

END IF

RETURN li_Return
end event

