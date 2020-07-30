$PBExportHeader$n_cst_trip.sru
forward
global type n_cst_trip from nonvisualobject
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//// Routing object
//n_cst_routing snv_routing
//long sl_routing_count = 0
//integer	si_serverid
////end modification Shared Variables by appeon  20070730
//
end variables

global type n_cst_trip from nonvisualobject
event ue_options_changed ( )
end type
global n_cst_trip n_cst_trip

type variables
// Data storage
n_cst_trip_attribs ids_data

// Errors data
public long il_err_code
public string is_err_message

// Calculation option
long il_option = 0
boolean ib_hubmode
boolean ib_bordersopen

//pcmiler product info
string	is_productname
string	is_productversion

//PCMiler Trip ID  (Added 2/22/05 BKW)
//Prior to adding this, if a trip was instantiated, the ID was not internally retained.
Private Long		il_TripId

//begin modification Shared Variables by appeon  20070730
// Routing object
//n_cst_routing snv_routing
long sl_routing_count = 0
integer	si_serverid
//end modification Shared Variables by appeon  20070730

end variables

forward prototypes
public function boolean of_setloaded (long al_index)
public function boolean of_getlasterror (ref long al_code, ref string as_message)
public function boolean of_getlasterror (ref long al_code)
public subroutine of_destroy ()
public function long of_addstop (string as_stop)
public function long of_insertstop (string as_stop, long al_index)
public function long of_getstopscount ()
public function long of_getstop (datastore ads_data, long al_index)
public function long of_setstops (datastore ads_data)
public function long of_getinvalidstops (n_cst_trip_attribs ads_data)
public function boolean of_createrouting ()
public function boolean of_warning ()
public subroutine of_deleterouting ()
public function boolean of_calculate (ref decimal ad_distance, ref long al_minutes)
public function boolean of_calculate (ref decimal ad_distance, ref long al_minutes, long al_index)
public function boolean of_calculate (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to)
public function boolean of_deletestop (long al_index)
public subroutine of_setlayer (string as_layer)
public function n_cst_routing of_getrouting ()
public subroutine of_setrouting (n_cst_routing anv_routing)
public subroutine of_incrouting ()
public subroutine of_decrouting ()
public function long of_getroutingcount ()
public function boolean of_setbobtail (long al_index)
public function boolean of_setdeadhead (long al_index)
public function boolean of_setempty (long al_index)
public function boolean of_gettotal (ref decimal ad_distance, ref long al_minutes)
public function boolean of_gettotal (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to)
public function boolean of_gettotal (ref decimal ad_distance, ref long al_minutes, long al_index)
public function boolean of_getloaded (ref decimal ad_distance, ref long al_minutes, long al_index)
public function boolean of_getloaded (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to)
public function boolean of_getloaded (ref decimal ad_distance, ref long al_minutes)
public function boolean of_getbobtail (ref decimal ad_distance, ref long al_minutes, long al_index)
public function boolean of_getbobtail (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to)
public function boolean of_getbobtail (ref decimal ad_distance, ref long al_minutes)
public function boolean of_getdeadhead (ref decimal ad_distance, ref long al_minutes, long al_index)
public function boolean of_getdeadhead (ref decimal ad_distance, ref long al_minutes)
public function boolean of_getdeadhead (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to)
public function boolean of_getempty (ref decimal ad_distance, ref long al_minutes, long al_index)
public function boolean of_getempty (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to)
public function boolean of_getempty (ref decimal ad_distance, ref long al_minutes)
public function boolean of_setroutetype (long al_routetype)
public function boolean of_setcalcnext (long al_index, boolean ab_switch)
public function boolean of_calculate (ref decimal ac_distance, ref long al_minutes, long al_from, long al_to, long al_state)
public function boolean of_isconnected ()
public function integer of_disconnect ()
public function long of_getstops (ref datastore ads_data)
public function boolean of_connect (ref n_cst_routing anv_routing)
public function long of_gettripstops (long al_trip)
public subroutine of_deletetrip (long al_trip)
public function long of_createtrip ()
public function boolean of_calculatetrip (long al_trip, integer ai_option, integer ai_type, decimal ac_cost, ref decimal ac_distance, ref long al_minutes)
public function boolean of_clearstops (long al_trip)
public subroutine of_sethubmode (long al_trip, boolean ab_mode)
public subroutine of_setbordersopen (long al_trip, boolean ab_open)
public function boolean of_gethubmode ()
public function boolean of_getbordersopen ()
public function long of_getroutetype ()
public function long of_addtripstop (long al_trip, string as_stop)
public function long of_calculate (long al_trip)
public function integer of_optimize (ref n_cst_trip_attribs anv_attribs, boolean ab_FixDestination)
public function long of_getreport (long al_num, string as_borders, ref string as_data)
public function integer of_deletetrip ()
public function long of_gettripid ()
end prototypes

event ue_options_changed;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  				ue_options_changed
//
//	Access:  			public
//
//	Arguments:
//
//	Returns:  			None
//	
//
//	Description:		Reset all calculation results
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_count, ll_index
ll_count = ids_data.RowCount( )
for ll_index = 1 to ll_count
	ids_data.SetItem( ll_index, "valid", 0 )
next
end event

public function boolean of_setloaded (long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetLoaded
//
//	Access:  			public
//
//	Arguments:
//		al_index			long stop index
//		
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Set one stop loaded
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_index ) or al_index < 1 or al_index > ids_data.RowCount( ) then
	il_err_code = -1004
	is_err_message = "Stop index out of bound"
	return FALSE
end if

// Set loaded
return ( ids_data.SetItem( al_index, "loaded", appeon_constant.STATE_LOADED ) = 1 )

end function

public function boolean of_getlasterror (ref long al_code, ref string as_message);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetLastError
//
//	Access:  			public
//
//	Arguments:
//		al_code			place for returning error code
//		as_message		place for returning error message
//
//	Returns:  			TRUE if error code <> 0
//	
//
//	Description:		Get current error code and error message
//
//
//////////////////////////////////////////////////////////////////////////////

// Get error code and message string
al_code = il_err_code
as_message = is_err_message

// Clear interval variables
il_err_code = 0
is_err_message = ""

// Return TRUE if any error occur
if al_code = 0 then 
	return FALSE
else 
	return TRUE
end if
end function

public function boolean of_getlasterror (ref long al_code);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetLastError
//
//	Access:  			public
//
//	Arguments:
//		al_code			place for returning error code
//
//	Returns:  			TRUE if error code <> 0
//	
//
//	Description:		Get current error code and error message
//
//
//////////////////////////////////////////////////////////////////////////////

// Get error code and message string
al_code = il_err_code

// Clear interval variables
il_err_code = 0
is_err_message = ""

// Return TRUE if any error occur
if al_code = 0 then 
	return FALSE
else 
	return TRUE
end if
end function

public subroutine of_destroy ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Destroy
//
//	Access:  			public
//
//	Arguments:			None
//		
//
//	Returns:  			None
//	
//
//	Description:		UnInitialize internal structures
//
//
//////////////////////////////////////////////////////////////////////////////

of_DeleteRouting( )
Destroy ids_data

end subroutine

public function long of_addstop (string as_stop);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_AddStop
//
//	Access:  			public
//
//	Arguments:
//		as_stop			string stopname
//		
//
//	Returns:  			long index of new stop
//	
//
//	Description:		Add new stop at the end of trip
//
//
//////////////////////////////////////////////////////////////////////////////


/* Commented by Brian --  We want to be able to create the whole trip, 
	whether the stops turn out to be valid or not.  */
// Check input parameters
//if IsNull( as_stop ) or Len( as_stop ) = 0 then
//	il_err_code = -1002
//	is_err_message = "Ivalid stop name"
//	return il_err_code
//end if

// Add new stop into internal DataStore ( at the end )
long ll_row
ll_row = ids_data.InsertRow( 0 )
ids_data.SetItem( ll_row, "stop", as_stop )

// Get previous stop state (STATE_LOADED, STATE_BOBTAIL or STATE_DEADHEAD) and set the same
if( ll_row > 1 ) then
	ids_data.SetItem( ll_row, "loaded", ids_data.GetItemNumber( ll_row - 1, "loaded" ) )
//else
	//No previous stop -- use column default, which is STATE_LOADED
end if

return ll_row
end function

public function long of_insertstop (string as_stop, long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_InsertStop
//
//	Access:  			public
//
//	Arguments:
//		as_stop			string stopname
//		al_index			index of new stop
//		
//
//	Returns:  			long index of new stop
//	
//
//	Description:		Add new stop at the end of trip
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( as_stop ) or Len( as_stop ) = 0 then
	il_err_code = -1002
	is_err_message = "Ivalid stop name"
	return il_err_code
end if
if IsNull( al_index ) or al_index < 1 or al_index > ids_data.RowCount( ) then
	il_err_code = -1003
	is_err_message = "Ivalid stop index"
	return il_err_code
end if

// Insert new stop into internal DataStore
long ll_row
ll_row = ids_data.InsertRow( al_index )
ids_data.SetItem( ll_row, "stop", as_stop )


IF ll_row > 1 THEN

	// Get previous stop state (LOADED, BOBTAIL or DEADHEAD) and set the same
	ids_data.SetItem( ll_row, "loaded", ids_data.GetItemNumber( ll_row - 1, "loaded" ) )

ELSEIF ll_Row = 1 AND ids_Data.RowCount ( ) > 1 THEN

	//The stop we've inserted is the first in the trip, but there's other stops after it.
	//Use the state from the following stop.
	ids_data.SetItem( ll_row, "loaded", ids_data.GetItemNumber( ll_row + 1, "loaded" ) )

//ELSE
	//The stop we've added is the first and only stop in the trip.  Use the column default, 
	//which is STATE_LOADED.

END IF

// Reset calculation data for next ( after inserted ) stop
if ids_data.RowCount( ) > al_index then
	ids_data.SetItem( al_index + 1, "distance", 0.0 )
	ids_data.SetItem( al_index + 1, "minutes", 0 )
end if

return ll_row

end function

public function long of_getstopscount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetInvalidStops
//
//	Access:  			public
//
//	Arguments:			None
//		
//
//	Returns:  			long count of all stops or error code
//	
//
//	Description:		Return count of all stops
//
//
//////////////////////////////////////////////////////////////////////////////

return ids_data.RowCount( )

end function

public function long of_getstop (datastore ads_data, long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetStop
//
//	Access:  			public
//
//	Arguments:
//		ads_data			datastore stop
//		
//
//	Returns:  			long count of copied stops or error code
//	
//
//	Description:		Return list of copied stops
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_index ) or al_index < 1 or al_index > ids_data.RowCount( ) then
	il_err_code = -1004
	is_err_message = "Stop index out of bound"
	return il_err_code
end if

// Make copy of one stop
ads_data.Reset( )
return ids_data.RowsCopy( al_index, al_index, Primary!, ads_data, 1, Primary! )

end function

public function long of_setstops (datastore ads_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetStops
//
//	Access:  			public
//
//	Arguments:
//		ads_data			datastore stops
//		
//
//	Returns:  			long count of all stops or error code
//	
//
//	Description:		Set list of all stops
//
//
//////////////////////////////////////////////////////////////////////////////

// Make copy of all stops
ids_data.Reset( )
ads_data.RowsCopy( 1, ids_data.RowCount( ), Primary!, ids_data, 1, Primary! )
return ids_data.RowCount( )

end function

public function long of_getinvalidstops (n_cst_trip_attribs ads_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetInvalidStops
//
//	Access:  			public
//
//	Arguments:
//		ads_data			datastore stops
//		
//
//	Returns:  			long count of invalid stops or error code
//	
//
//	Description:		Return list of invalid stops
//
//
//////////////////////////////////////////////////////////////////////////////

// Make copy of invalid stops
long ll_index, ll_count, ll_counter
ll_count = ids_data.RowCount( )
ads_data.Reset( )
for ll_index = 1 to ll_count
	if ids_data.GetItemNumber( ll_index, "valid" ) = 0 then
		ids_data.RowsCopy( ll_index, ll_index, Primary!, ads_data, ads_data.RowCount( ) + 1, Primary! )
		ll_counter ++
	end if
next
return ll_counter

end function

public function boolean of_createrouting ();boolean	lb_created
string	ls_routingobject
n_cst_licensemanager	lnv_licensemanager
n_cst_routing lnv_routing

lnv_routing = this.of_GetRouting( )

if IsNull( lnv_routing ) or not IsValid( lnv_routing ) then
	if pcms_inst AND lnv_LicenseManager.of_usePCMilerStreets() then
		ls_routingobject = "n_cst_routing_pcmiler_streets"
	elseif pcms_inst AND lnv_LicenseManager.of_hasPCMilerlicense() then
		ls_routingobject = "n_cst_routing_pcmiler"
	else
		//no pcmiler license
		ls_routingobject = ''
	end if
	if len(ls_routingobject) > 0 then
		lnv_routing = Create using ls_routingobject
		this.of_SetRouting( lnv_routing )
		if not lnv_routing.of_Create(si_serverid) then
			il_err_code = -1005 
			is_err_message = "Cannot create routing object"
			this.of_DeleteRouting( )
			lb_created=false
		else
			lnv_routing.of_SetRequester( this, "ue_options_changed" )	
			lb_created=true
		end if
	else
		il_err_code = -9999
		is_err_message = "No PCMiler license found"
	end if
else
	//already created
	lb_created=true
end if

return lb_created

end function

public function boolean of_warning ();MessageBox( this.ClassName( ), "Feature not supported", StopSign! )
return FALSE
end function

public subroutine of_deleterouting ();if IsValid( snv_routing ) then
	this.of_DecRouting( )
	//if this.of_GetRoutingCount( ) = 0 then Destroy snv_routing
	//Commented by Brian.  We want to keep the shared instance, even
	//if there are no current subscribers.
end if
end subroutine

public function boolean of_calculate (ref decimal ad_distance, ref long al_minutes);//Forward request to overloaded version, with null start and end points, 
//indicating min and max endpoints of the range.

Long	ll_Null

SetNull ( ll_Null )

RETURN This.of_Calculate ( ad_Distance, al_Minutes, ll_Null, ll_Null )
end function

public function boolean of_calculate (ref decimal ad_distance, ref long al_minutes, long al_index);//Forward request to overloaded version, with the stop indicated as the range.

RETURN This.of_Calculate ( ad_Distance, al_Minutes, al_Index, al_Index )
end function

public function boolean of_calculate (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to);//Forward request to overloaded version, with ANY as state parameter.

RETURN This.of_Calculate ( ad_Distance, al_Minutes, al_From, al_To, appeon_constant.STATE_ANY )
end function

public function boolean of_deletestop (long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_DeleteStop
//
//	Access:  			public
//
//	Arguments:			None
//		
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Delete one stop in trip
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_index ) or al_index < 1 or al_index > ids_data.RowCount( ) then
	il_err_code = -1004
	is_err_message = "Stop index out of bound"
	return FALSE
end if

// Delete one row
boolean lb_retval
lb_retval = ( ids_data.DeleteRow( al_index ) = 1 )

// Reset calculation data for next ( after deleted ) stop
if ids_data.RowCount( ) >= al_index then
	ids_data.SetItem( al_index, "distance", 0.0 )
	ids_data.SetItem( al_index, "minutes", 0 )
end if
return lb_retval
end function

public subroutine of_setlayer (string as_layer);ids_data.is_layer = as_layer
end subroutine

public function n_cst_routing of_getrouting ();return snv_routing
end function

public subroutine of_setrouting (n_cst_routing anv_routing);snv_routing = anv_routing
end subroutine

public subroutine of_incrouting ();sl_routing_count ++
end subroutine

public subroutine of_decrouting ();sl_routing_count --
end subroutine

public function long of_getroutingcount ();return sl_routing_count
end function

public function boolean of_setbobtail (long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetBobtail
//
//	Access:  			public
//
//	Arguments:
//		al_index			long stop index
//		
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Set one stop loaded
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_index ) or al_index < 1 or al_index > ids_data.RowCount( ) then
	il_err_code = -1004
	is_err_message = "Stop index out of bound"
	return FALSE
end if

// Set BOBTAIL
return ( ids_data.SetItem( al_index, "loaded", appeon_constant.STATE_BOBTAIL ) = 1 )

end function

public function boolean of_setdeadhead (long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetDeadhead
//
//	Access:  			public
//
//	Arguments:
//		al_index			long stop index
//		
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Set one stop loaded
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_index ) or al_index < 1 or al_index > ids_data.RowCount( ) then
	il_err_code = -1004
	is_err_message = "Stop index out of bound"
	return FALSE
end if

// Set DEADHEAD
return ( ids_data.SetItem( al_index, "loaded", appeon_constant.STATE_DEADHEAD ) = 1 )

end function

public function boolean of_setempty (long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetEmpty
//
//	Access:  			public
//
//	Arguments:
//		al_index			long stop index
//		
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Set one stop loaded
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_index ) or al_index < 1 or al_index > ids_data.RowCount( ) then
	il_err_code = -1004
	is_err_message = "Stop index out of bound"
	return FALSE
end if

// Set empty (the same as DEADHEAD)
return ( ids_data.SetItem( al_index, "loaded", appeon_constant.STATE_DEADHEAD ) = 1 )

end function

public function boolean of_gettotal (ref decimal ad_distance, ref long al_minutes);//Forward request to overloaded version, with null start and end points, 
//indicating min and max endpoints of the range.

Long	ll_Null

SetNull ( ll_Null )

RETURN This.of_GetTotal ( ad_Distance, al_Minutes, ll_Null, ll_Null )
end function

public function boolean of_gettotal (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to);//Forward request to of_Calculate, with ANY as the state parameter.

RETURN This.of_Calculate ( ad_Distance, al_Minutes, al_From, al_To, appeon_constant.STATE_ANY )
end function

public function boolean of_gettotal (ref decimal ad_distance, ref long al_minutes, long al_index);//Forward request to overloaded version, with the stop indicated as the range.

RETURN This.of_GetTotal ( ad_Distance, al_Minutes, al_Index, al_Index )
end function

public function boolean of_getloaded (ref decimal ad_distance, ref long al_minutes, long al_index);//Forward request to overloaded version, with the stop indicated as the range.

RETURN This.of_GetLoaded ( ad_Distance, al_Minutes, al_Index, al_Index )
end function

public function boolean of_getloaded (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to);//Forward request to of_Calculate, with LOADED as the state parameter.

RETURN This.of_Calculate ( ad_Distance, al_Minutes, al_From, al_To, appeon_constant.STATE_LOADED )
end function

public function boolean of_getloaded (ref decimal ad_distance, ref long al_minutes);//Forward request to overloaded version, with null start and end points, 
//indicating min and max endpoints of the range.

Long	ll_Null

SetNull ( ll_Null )

RETURN This.of_GetLoaded ( ad_Distance, al_Minutes, ll_Null, ll_Null )
end function

public function boolean of_getbobtail (ref decimal ad_distance, ref long al_minutes, long al_index);//Forward request to overloaded version, with the stop indicated as the range.

RETURN This.of_GetBobtail ( ad_Distance, al_Minutes, al_Index, al_Index )
end function

public function boolean of_getbobtail (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to);//Forward request to of_Calculate, with BOBTAIL as the state parameter.

RETURN This.of_Calculate ( ad_Distance, al_Minutes, al_From, al_To, appeon_constant.STATE_BOBTAIL )
end function

public function boolean of_getbobtail (ref decimal ad_distance, ref long al_minutes);//Forward request to overloaded version, with null start and end points, 
//indicating min and max endpoints of the range.

Long	ll_Null

SetNull ( ll_Null )

RETURN This.of_GetBobtail ( ad_Distance, al_Minutes, ll_Null, ll_Null )
end function

public function boolean of_getdeadhead (ref decimal ad_distance, ref long al_minutes, long al_index);//Forward request to overloaded version, with the stop indicated as the range.

RETURN This.of_GetDeadhead ( ad_Distance, al_Minutes, al_Index, al_Index )
end function

public function boolean of_getdeadhead (ref decimal ad_distance, ref long al_minutes);//Forward request to overloaded version, with null start and end points, 
//indicating min and max endpoints of the range.

Long	ll_Null

SetNull ( ll_Null )

RETURN This.of_GetDeadhead ( ad_Distance, al_Minutes, ll_Null, ll_Null )
end function

public function boolean of_getdeadhead (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to);//Forward request to of_Calculate, with DEADHEAD as the state parameter.

RETURN This.of_Calculate ( ad_Distance, al_Minutes, al_From, al_To, appeon_constant.STATE_DEADHEAD )
end function

public function boolean of_getempty (ref decimal ad_distance, ref long al_minutes, long al_index);//Forward request to overloaded version, with the stop indicated as the range.

RETURN This.of_GetEmpty ( ad_Distance, al_Minutes, al_Index, al_Index )
end function

public function boolean of_getempty (ref decimal ad_distance, ref long al_minutes, long al_from, long al_to);//Forward request to of_Calculate, with EMPTY as the state parameter.

RETURN This.of_Calculate ( ad_Distance, al_Minutes, al_From, al_To, appeon_constant.STATE_EMPTY )
end function

public function boolean of_getempty (ref decimal ad_distance, ref long al_minutes);//Forward request to overloaded version, with null start and end points, 
//indicating min and max endpoints of the range.

Long	ll_Null

SetNull ( ll_Null )

RETURN This.of_GetEmpty ( ad_Distance, al_Minutes, ll_Null, ll_Null )
end function

public function boolean of_setroutetype (long al_routetype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetRouteType
//
//	Access:  			public
//
//	Arguments:
//		al_RouteType	long RouteType
//		
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Set calculation option
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if al_RouteType < 0 or al_RouteType > 4 then
	il_err_code = -1006
	is_err_message = "Ivalid route type"
	return FALSE
end if

// If real option stay the same
if il_option = al_RouteType then 
	return TRUE
else
	il_option = al_RouteType
	// Make all stops "invalid"
	this.Event ue_options_changed( )
end if
return TRUE
end function

public function boolean of_setcalcnext (long al_index, boolean ab_switch);Long	ll_Value

Boolean	lb_Return = TRUE

IF al_Index > 0 AND al_Index <= ids_Data.RowCount ( ) AND IsNull ( ab_Switch ) = FALSE THEN

	IF ab_Switch THEN
		ll_Value = 1
	ELSE
		ll_Value = 0
	END IF

	ids_Data.SetItem ( al_Index, "CalcNext", ll_Value )

ELSE
	lb_Return = FALSE

END IF

RETURN lb_Return
end function

public function boolean of_calculate (ref decimal ac_distance, ref long al_minutes, long al_from, long al_to, long al_state);//Null values for al_From or al_To will be replaced with the lower or upper endpoint of the trip.
//A null value for al_State will be replaced with appeon_constant.STATE_ANY
//The values for al_From and al_To represent legs, not stops: thus 2 to 2 represents leg 2 to leg 2,
//(ie stop 1 to stop 2).  Leg 1 always calculates to zero, because there's no origin stop for it
//(ie stop 0 to stop 1 does not make sense.)

Decimal	lc_Distance, &
			lc_TotalDistance
Long		ll_Minutes, &
			ll_TotalMinutes, &
			ll_Stop, &
			ll_State, &
			ll_RowCount
Integer	li_Valid
String 	ls_Origin, &
			ls_Destination
Boolean	lb_FirstPass = TRUE
DataStore	lds_Data
DWObject		ldwo_CalcNext, &
				ldwo_Valid, &
				ldwo_Distance, &
				ldwo_Minutes, &
				ldwo_Stop, &
				ldwo_State

Boolean	lb_Return = TRUE
Boolean	lb_Finished = FALSE


IF lb_Finished = FALSE THEN

	IF IsNull ( al_State ) THEN
		al_State = appeon_constant.STATE_ANY
	END IF

	lds_Data = ids_Data

	IF IsValid ( lds_Data ) THEN

		ll_RowCount = lds_Data.RowCount ( )

		IF ll_RowCount > 1 THEN

			ldwo_CalcNext = lds_Data.Object.CalcNext
			ldwo_Valid = lds_Data.Object.Valid
			ldwo_Distance = lds_Data.Object.Distance
			ldwo_Minutes = lds_Data.Object.Minutes
			ldwo_Stop = lds_Data.Object.Stop
			ldwo_State = lds_Data.Object.Loaded

		ELSE
			//Can't have mileage results without more than one stop -- return success with zeroes
			lb_Finished = TRUE

		END IF

	ELSE
		il_err_code = -1003  //??Not sure what to call this.
		is_err_message = "Invalid data cache."
		lb_return = FALSE
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	//If we were passed nulls values for al_From or al_To, 
	//use the values for the endpoints of the trip.

	IF IsNull ( al_From ) THEN
		al_From = 1
	END IF

	IF IsNull ( al_To ) THEN
		al_To = ll_RowCount
	END IF

END IF


IF lb_Finished = FALSE THEN

	FOR ll_Stop = al_From TO al_To

		lc_Distance = 0
		ll_Minutes = 0

		IF ll_Stop < 2 THEN
			//Can't have miles for first stop, because there's no origin.
			//So, continue without adding anything to the totals.
			//(This also handles an al_From < 1 gracefully.)
			CONTINUE
		ELSEIF ll_Stop > ll_RowCount THEN
			//No more legs to calculate against.  The upper limit specified is off the end
			//of the range.  We're done.
			EXIT
		END IF
	
		//If the origin stop has CalcNext set to false, 
		//continue without adding anything to the totals.
		IF ldwo_CalcNext.Primary [ ll_Stop - 1 ] = 0 THEN
			CONTINUE
		END IF

		IF al_State = appeon_constant.STATE_ANY THEN
			//Always count the leg

		ELSE
			//We need to check whether to count the leg.

			ll_State = ldwo_State.Primary [ ll_Stop ]
	
			CHOOSE CASE ll_State
	
			CASE appeon_constant.STATE_LOADED
	
				CHOOSE CASE al_State
	
				CASE appeon_constant.STATE_LOADED
					//Count it.

				CASE ELSE
					CONTINUE

				END CHOOSE

			CASE appeon_constant.STATE_BOBTAIL

				CHOOSE CASE al_State

				CASE appeon_constant.STATE_BOBTAIL, appeon_constant.STATE_EMPTY
					//Count it

				CASE ELSE
					CONTINUE

				END CHOOSE

			CASE appeon_constant.STATE_DEADHEAD

				CHOOSE CASE al_State

				CASE appeon_constant.STATE_DEADHEAD, appeon_constant.STATE_EMPTY
					//Count it

				CASE ELSE
					CONTINUE

				END CHOOSE

			END CHOOSE

		END IF


		li_Valid = ldwo_Valid.Primary [ ll_Stop ]
		
		// Check if stop is valid
		if li_valid = 1 then

			// If stop is valid
			lc_Distance = ldwo_Distance.Primary [ ll_Stop ]
			ll_Minutes = ldwo_Minutes.Primary [ ll_Stop ]

		else

			// If stop is not valid
			ls_Origin = ldwo_Stop.Primary [ ll_Stop - 1 ]
			ls_Destination = ldwo_Stop.Primary [ ll_Stop ]

			// Create routing object if necessary
			if not This.of_CreateRouting ( ) then
				il_err_code = -1005
				is_err_message = "Cannot create routing service."
				lb_return = FALSE
				lb_Finished = TRUE
				EXIT
			end if

			// Make calculation through routing object
			if snv_routing.of_Calculate ( ls_origin, ls_destination, lc_Distance, ll_minutes, &
				il_option ) < 1 then

				il_err_code = -1006
				is_err_message = "Cannot make routing calculation."
				lb_return = FALSE
				//Keep going and finish the calculation, even though it's not going to be complete.

			else

				// Make current stop valid and calculated
				ldwo_Valid.Primary [ ll_Stop ] = 1
				ldwo_Distance.Primary [ ll_Stop ] = lc_Distance
				ldwo_Minutes.Primary [ ll_Stop ] = ll_Minutes

				//Not sure if this is really necessary.  Vladimir was doing this.
				// If previous stop is first stop - make it valid too
				if ll_Stop = 2 then
					ldwo_Valid.Primary [ 1 ] = 1
				end if

			end if

		end if

		// Add the values just looked up or calculated to the totals.
		IF lc_Distance >= 0 AND ll_Minutes >= 0 THEN

			lc_TotalDistance += lc_Distance
			ll_TotalMinutes += ll_Minutes

		END IF

	NEXT

END IF

//Clean up
DESTROY ldwo_CalcNext
DESTROY ldwo_Valid
DESTROY ldwo_Distance
DESTROY ldwo_Minutes
DESTROY ldwo_Stop
DESTROY ldwo_State


//Even if we didn't succeed, write the local Distance and Minutes values out.
ac_Distance = lc_TotalDistance
al_Minutes = ll_TotalMinutes

RETURN lb_Return
end function

public function boolean of_isconnected ();return (si_serverid > 0)
end function

public function integer of_disconnect ();integer	li_return=1

n_cst_routing lnv_routing

if this.of_isconnected() then
	lnv_routing = this.of_GetRouting( )
	if isvalid(lnv_routing) then
		lnv_routing.of_disconnect()
		lnv_routing.of_destroy()
		si_serverid = 0
		if isvalid(snv_routing) then
			destroy snv_routing
		end if
	else
		li_return = -1
	end if

end if

return li_return
end function

public function long of_getstops (ref datastore ads_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetStops
//
//	Access:  			public
//
//	Arguments:
//		ads_data			datastore stops
//		
//
//	Returns:  			long count of all stops or error code
//	
//
//	Description:		Return list of all stops
//
//
//////////////////////////////////////////////////////////////////////////////

// Make copy of all stops
IF IsValid ( ads_Data ) THEN
	ads_data.Reset( )
	ids_data.RowsCopy( 1, ids_data.RowCount( ), Primary!, ads_data, 1, Primary! )
	return ads_data.RowCount( )
ELSE
	RETURN -1
END IF
end function

public function boolean of_connect (ref n_cst_routing anv_routing);boolean	lb_connected
string	ls_routingobject

n_cst_licensemanager	lnv_licensemanager
n_cst_routing lnv_routing

IF gnv_App.of_Attemptpcmilerconnection( ) THEN

	lnv_routing = this.of_GetRouting( )
	
	if IsNull( lnv_routing ) or not IsValid( lnv_routing ) then
		// Create routing object if necessary
		if not This.of_CreateRouting ( ) then
			il_err_code = -1005
			is_err_message = "Cannot create routing service."
			lb_connected = false
		else
			lb_connected = true
		end if
	else
		//already connected
		lb_connected = true
	end if
	
	if lb_connected then
		anv_routing = this.of_getrouting()
	end if
END IF
return lb_connected
end function

public function long of_gettripstops (long al_trip);return snv_routing.of_gettripstops(al_trip)
end function

public subroutine of_deletetrip (long al_trip);if isvalid(snv_routing) then
	snv_routing.of_deletetrip(al_trip)
end if
end subroutine

public function long of_createtrip ();//Modified 2/22/05 BKW to capture the TripId into the instance variable.
//Prior to this, it was just returning the Id and not retaining it.

Long	ll_TripId

ll_TripId = snv_Routing.of_CreateTrip()

IF ll_TripId > 0 THEN
	il_TripId = ll_TripId
END IF

RETURN ll_TripId

end function

public function boolean of_calculatetrip (long al_trip, integer ai_option, integer ai_type, decimal ac_cost, ref decimal ac_distance, ref long al_minutes);Decimal	lc_Distance, &
			lc_TotalDistance, &
			lc_cost
Long		ll_Minutes, &
			ll_TotalMinutes, &
			ll_Stop, &
			ll_stopcount, &
			ll_State, &
			ll_RowCount, &
			ll_legcount
			
Integer	li_Valid
String 	ls_Origin, &
			ls_Destination, &
			ls_laststop, &
			ls_locater
Boolean	lb_FirstPass = TRUE
DataStore	lds_Data
DWObject		ldwo_CalcNext, &
				ldwo_Valid, &
				ldwo_Distance, &
				ldwo_Minutes, &
				ldwo_Stop, &
				ldwo_State, &
				ldwo_Cost

Boolean	lb_Return = TRUE
Boolean	lb_Finished = FALSE
s_leginfo	lstr_leginfo
IF lb_Finished = FALSE THEN

	lds_Data = ids_Data

	IF IsValid ( lds_Data ) THEN

		ll_RowCount = lds_Data.RowCount ( )

		IF ll_RowCount > 1 THEN

			ldwo_CalcNext = lds_Data.Object.CalcNext
			ldwo_Valid = lds_Data.Object.Valid
			ldwo_Distance = lds_Data.Object.Distance
			ldwo_Minutes = lds_Data.Object.Minutes
			ldwo_Stop = lds_Data.Object.Stop
			ldwo_State = lds_Data.Object.Loaded
			ldwo_Cost = lds_Data.Object.Cost

		ELSE
			//Can't have mileage results without more than one stop -- return success with zeroes
			lb_Finished = TRUE

		END IF

	ELSE
		il_err_code = -1003  //??Not sure what to call this.
		is_err_message = "Invalid data cache."
		lb_return = FALSE
		lb_Finished = TRUE
	END IF

END IF

IF lb_Finished = FALSE THEN
	//add stop to pcmiler
	for ll_stop = 1 to ll_rowcount
		snv_routing.of_addstop(al_trip,lds_Data.Object.Stop[ll_stop])
	next
	
	snv_routing.of_setmilecost(ac_cost)
	
END IF

//
IF lb_Finished = FALSE THEN

	snv_routing.of_Calculate (al_trip, ai_option, &
				ai_type ) 
	ll_legcount = snv_routing.of_getnumlegs(al_trip)
	
	FOR ll_Stop = 2 TO ll_RowCount

		lc_Distance = 0
		ll_Minutes = 0

		if snv_routing.of_gettripleginfo(al_trip,ll_stop - 2, lstr_leginfo ) > 0 then
	
			// Make current stop valid and calculated
			ldwo_Valid.Primary [ ll_Stop ] = 1
			lc_Distance = dec(lstr_leginfo.legmiles)
			ll_Minutes = long(dec(lstr_leginfo.leghours) * 60)
			ldwo_Distance.Primary [ ll_Stop ] = lc_Distance
			ldwo_Minutes.Primary [ ll_Stop ] = ll_Minutes
			ldwo_cost.primary [ ll_stop ] = dec(lstr_leginfo.legcost)
		end if
		
		// Add the values just looked up or calculated to the totals.
		IF lc_Distance >= 0 AND ll_Minutes >= 0 THEN

			lc_TotalDistance += lc_Distance
			ll_TotalMinutes += ll_Minutes

		END IF

	NEXT

END IF

//Clean up
DESTROY ldwo_CalcNext
DESTROY ldwo_Valid
DESTROY ldwo_Distance
DESTROY ldwo_Minutes
DESTROY ldwo_Stop
DESTROY ldwo_State
DESTROY ldwo_Cost


//Even if we didn't succeed, write the local Distance and Minutes values out.
ac_Distance = lc_TotalDistance
al_Minutes = ll_TotalMinutes

RETURN lb_Return
end function

public function boolean of_clearstops (long al_trip);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_ClearStops
//
//	Access:  			public
//
//	Arguments:			None
//		
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Delete all stops from trip
//
//
//////////////////////////////////////////////////////////////////////////////
if al_trip > 0 then
	if isvalid(snv_routing) then
		snv_routing.of_clearstops(al_trip)
	end if
end if
return ( ids_data.Reset( ) = 1 )
end function

public subroutine of_sethubmode (long al_trip, boolean ab_mode);if isvalid(snv_routing) then
//	snv_routing.of_sethubmode(al_trip, ab_mode)
end if
ib_hubmode = ab_mode

end subroutine

public subroutine of_setbordersopen (long al_trip, boolean ab_open);
if isvalid(snv_routing) then
	//this is being set by the bitwise option
//	snv_routing.of_setbordersopen(al_trip, ab_open)
end if
ib_bordersopen = ab_open

end subroutine

public function boolean of_gethubmode ();return ib_hubmode
end function

public function boolean of_getbordersopen ();return ib_bordersopen
end function

public function long of_getroutetype ();return il_option 
end function

public function long of_addtripstop (long al_trip, string as_stop);return 1
end function

public function long of_calculate (long al_trip);//return snv_routing.of_calculate(al_trip)
return 1
end function

public function integer of_optimize (ref n_cst_trip_attribs anv_attribs, boolean ab_FixDestination);Int	li_Return = -1

n_cst_trip_attribs	lnv_Attribs
n_cst_Routing	lnv_Routing



THIS.of_CreateRouting ( )
lnv_Routing = THIS.of_GetRouting ( ) 

IF isValid ( lnv_Routing ) THEN

	IF IsValid ( anv_Attribs ) THEN
		THIS.of_GetStops ( anv_Attribs )
	
		IF lnv_Routing.of_Optimize ( anv_Attribs , 0 , ab_FixDestination  ) THEN
			THIS.of_SetStops ( anv_Attribs )
			li_Return = 1
		END IF
	END IF
	
END IF


RETURN li_Return
end function

public function long of_getreport (long al_num, string as_borders, ref string as_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_AddStop
//
//	Access:  			public
//
//	Arguments:
//		as_stop			string stopname
//		
//
//	Returns:  			long index of new stop
//	
//
//	Description:		Add new stop at the end of trip
//
//
//////////////////////////////////////////////////////////////////////////////

// Create routing object if necessary
if not of_CreateRouting ( ) then
	il_err_code = -1005
	is_err_message = "Cannot create routing"
	return il_err_code
end if

// Prepare report data through routing object
long ll_size
//setborders
snv_routing.of_SetBordersOpen(as_borders)

ll_size = snv_routing.of_GetReport( al_num, ids_data, as_data, il_option )
if ll_size < 1 then
	long ll_err
	string ls_err
	snv_routing.of_GetLastError( ll_err, ls_err )
	il_err_code = ll_err
	is_err_message = ls_err
	return ll_err
end if
return ll_size
end function

public function integer of_deletetrip ();//Delete the trip instance recorded in il_TripId
//Returns 1 = Success, 0 = No Trip Instance, -1 = Error

Integer	li_Return = 1

IF il_TripId > 0 THEN
	This.of_DeleteTrip ( il_TripId )   //There's no return code on this function
	il_TripId = 0
ELSE
	li_Return = 0
END IF

RETURN li_Return
end function

public function long of_gettripid ();RETURN il_TripId
end function

on n_cst_trip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_trip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;This.of_Destroy( )
end event

event constructor;ids_data = Create n_cst_trip_attribs
end event

