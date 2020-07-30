$PBExportHeader$n_cst_routing_pcmiler.sru
forward
global type n_cst_routing_pcmiler from n_cst_routing
end type
end forward

global type n_cst_routing_pcmiler from n_cst_routing
end type
global n_cst_routing_pcmiler n_cst_routing_pcmiler

type prototypes

/*********************************************************************
* INITIALIZATION FUNCTIONS
*********************************************************************/
function long PCMSSetDebug( long levl ) library "pcmsrv32.dll"
function long PCMSGetDebug( ) library "pcmsrv32.dll"
function int PCMSOpenServer( long hAppInst, long hWnd ) library "pcmsrv32.dll"
function int PCMSCloseServer( int server ) library "pcmsrv32.dll"
function long PCMSIsValid( int server ) library "pcmsrv32.dll"
function long PCMSGetErrorString( long errorCode, ref string buffer, long bufSize ) library "pcmsrv32.dll" alias for "PCMSGetErrorString;Ansi"
function long PCMSGetError( ) library "pcmsrv32.dll"
function long PCMSAbout( string which, ref string buffer, long bufSize ) library "pcmsrv32.dll" alias for "PCMSAbout;Ansi"

/*********************************************************************
* SIMPLE INTERFACE
*********************************************************************/
function long PCMSCalcDistance( int serv, string orig, string dest ) library "pcmsrv32.dll" alias for "PCMSCalcDistance;Ansi"
function long PCMSCalcDistance2( int serv, string orig, string dest, long routeType ) library "pcmsrv32.dll" alias for "PCMSCalcDistance2;Ansi"
function long PCMSCalcDistance3( int serv, string orig, string dest, long routeType, &
	ref long minutes ) library "pcmsrv32.dll" alias for "PCMSCalcDistance3;Ansi"
function long PCMSCheckPlaceName( int serv, string cityZip ) library "pcmsrv32.dll" alias for "PCMSCheckPlaceName;Ansi"
function long PCMSCityToLatLong( int serv, string name, ref string buffer, long bufSize) library "pcmsrv32.dll" alias for "PCMSCityToLatLong;Ansi"
function long PCMSLatLongToCity( int serv, string latlong, ref string buffer, long bufSize ) library "pcmsrv32.dll" alias for "PCMSLatLongToCity;Ansi"

/*********************************************************************
* OPTIONS
*********************************************************************/
subroutine PCMSSetCalcType( long trip, long routeType ) library "pcmsrv32.dll"
function long PCMSGetCalcType( long trip ) library "pcmsrv32.dll"
subroutine PCMSSetBordersOpen( long trip, long _open ) library "pcmsrv32.dll"
subroutine PCMSSetKilometers( long trip ) library "pcmsrv32.dll"
subroutine PCMSSetCost( long trip, long cost ) library "pcmsrv32.dll"
subroutine PCMSSetUseShapePts( long trip, long onOff ) library "pcmsrv32.dll"
function long PCMSGetCost( long trip ) library "pcmsrv32.dll"
subroutine PCMSSetMiles( long trip ) library "pcmsrv32.dll"
subroutine PCMSSetHubMode( long trip, long onOff ) library "pcmsrv32.dll"
subroutine PCMSSetResequence( long trip, long changeDest ) library "pcmsrv32.dll"
subroutine PCMSSetAlphaOrder( long trip, long alphaOrder ) library "pcmsrv32.dll"
subroutine PCMSSetOptions( long trip, long opts ) library "pcmsrv32.dll"
function long PCMSGetOptions( long trip ) library "pcmsrv32.dll"
function long PCMSNumLegs( long trip ) library "pcmsrv32.dll"
subroutine PCMSDefaults( long trip ) library "pcmsrv32.dll"
subroutine PCMSConvertLLToPlace( long trip, long yesNo ) library "pcmsrv32.dll"
subroutine PCMSSetBreakHours( long trip, long hours ) library "pcmsrv32.dll"
function long PCMSGetBreakHours( long trip ) library "pcmsrv32.dll"
subroutine PCMSSetBreakWaitHours( long trip, long hours ) library "pcmsrv32.dll"
function long PCMSGetBreakWaitHours( long trip ) library "pcmsrv32.dll"
subroutine PCMSSetCustomMode( long trip, long onOff ) library "pcmsrv32.dll"
subroutine PCMSSetOldMode( long trip, long onOff ) library "pcmsrv32.dll"
function long PCMSAFLinks( long trip, long favor ) library "pcmsrv32.dll"
function long PCMSAFLoad( int serv, string filename ) library "pcmsrv32.dll" alias for "PCMSAFLoad;Ansi"
function long PCMSAFSave( int serv ) library "pcmsrv32.dll"
function long PCMSCalcDistToRoute( long trip, string location ) library "pcmsrv32.dll" alias for "PCMSCalcDistToRoute;Ansi"

/*********************************************************************
* COMPLEX INTERFACE
*********************************************************************/
function long PCMSNewTrip( int serv ) library "pcmsrv32.dll"
subroutine PCMSDeleteTrip( long trip ) library "pcmsrv32.dll"
function long PCMSCalcTrip( long trip, string orig, string dest ) library "pcmsrv32.dll" alias for "PCMSCalcTrip;Ansi"
function long PCMSCalculate( long trip ) library "pcmsrv32.dll"
function long PCMSOptimize( long trip ) library "pcmsrv32.dll"
function long PCMSGetDuration( long trip ) library "pcmsrv32.dll"
function long PCMSAddStop( long trip, string stop ) library "pcmsrv32.dll" alias for "PCMSAddStop;Ansi"
function long PCMSSetLoaded( long trip, long which, long loaded ) library "pcmsrv32.dll"
function long PCMSDeleteStop( long trip, long which ) library "pcmsrv32.dll"
function long PCMSGetStop( long trip, long which, ref string buffer, long bufSize ) library "pcmsrv32.dll" alias for "PCMSGetStop;Ansi"
function long PCMSNumStops( long trip ) library "pcmsrv32.dll"
subroutine PCMSClearStops( long trip ) library "pcmsrv32.dll"
function long PCMSLookup( long trip, string city, long easyMatch ) library "pcmsrv32.dll" alias for "PCMSLookup;Ansi"
function long PCMSGetMatch( long trip, long which, ref string buffer, long bufSize ) library "pcmsrv32.dll" alias for "PCMSGetMatch;Ansi"
function long PCMSGetFmtMatch( long trip, long which, ref string buffer, long bufSize, &
	long zipLen, long cityName, long countyLen ) library "pcmsrv32.dll" alias for "PCMSGetFmtMatch;Ansi"
function long PCMSNumMatches( long trip ) library "pcmsrv32.dll"
function long PCMSGetLocAtMiles( long trip, long miles, ref string pLocation, long size ) &
	library "pcmsrv32.dll" alias for "PCMSGetLocAtMiles;Ansi"
function long PCMSGetLocAtMinutes( long trip, long minutes, ref string pLocation, long size ) &
	library "pcmsrv32.dll" alias for "PCMSGetLocAtMinutes;Ansi"
function long PCMSGetLegInfo( long trip, long legnum, ref s_leginfo leginfotype ) library "pcmsrv32.dll" alias for "PCMSGetLegInfo;Ansi"

/*********************************************************************
* REPORT DATA
*********************************************************************/
function long PCMSGetRpt( long trip, long rptNum, ref string buffer, long bufSize ) &
	library "pcmsrv32.dll" alias for "PCMSGetRpt;Ansi"
function long PCMSNumRptBytes( long trip, long rptNum ) library "pcmsrv32.dll"
function long PCMSGetRptLine( long trip, long rptNum, long lineNum, ref string buffer, &
	long bufSize ) library "pcmsrv32.dll" alias for "PCMSGetRptLine;Ansi"
function long PCMSNumRptLines( long trip, long rptNum ) library "pcmsrv32.dll"
function long PCMSGetNumSegments( long trip ) library "pcmsrv32.dll"

end prototypes

type variables
int ii_serverid = 0
int ii_calctype = 0
integer		il_bordersopen
decimal	ic_milecost

private:
n_cst_mapping	inv_mapping
boolean		ib_bordersopen=true
boolean		ib_hubmode
end variables

forward prototypes
public function boolean of_destroy ()
public function long of_setdebug (long al_level)
public function long of_getdebug ()
public function string of_about (string as_which)
private function boolean of_isvalid ()
public function boolean of_setcalctype (integer ai_option)
public function integer of_getcalctype ()
public function boolean of_citytolatlong (string as_city, ref string as_latlong)
public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes)
public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance)
public function boolean of_latlongtocity (string as_latlong, ref string as_city)
public function string of_lookup (string as_place, long al_easy)
public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes, long al_option)
public function long of_getreport (long al_trip, long al_num, ref string as_data)
private function boolean of_setloaded (long al_trip, long al_index, boolean ab_switch)
public function integer of_addstop (long al_trip, string as_stop)
public function long of_createtrip ()
public subroutine of_deletetrip (long al_trip)
public function long of_getlastsyserror (ref long al_errcode, ref string as_errmsg)
public subroutine of_settripoptions (long al_trip, n_cst_trip_attribs ads_data)
public function long of_getreport (long al_num, n_cst_trip_attribs ads_data, ref string as_data, long al_option)
public function boolean of_create (ref integer ai_serverid)
public function boolean of_validplacename (string as_place)
public function boolean of_isoldpcmilerversion ()
public function boolean of_isstreets ()
public function string of_lookup (string as_place, boolean ab_exactmatch, boolean ab_partialmatch, boolean ab_showpicklist)
public function string of_getmatches (long al_trip)
public function integer of_showpicklist (s_strings astr_selectionlist)
public function boolean of_validatestateabreviation (string as_state)
public function string of_getpartoflocater (string as_locater, string as_whichpart, boolean ab_pcmilerlocater)
public function integer of_locationcheck (string as_checklocation, ref string as_foundlocation, boolean ab_exactmatch)
public function long of_gettripduration (long al_trip)
public function long of_gettripstops (long al_trip)
public subroutine of_cleanupmap ()
public subroutine of_clearstops (long al_trip)
public function string of_latlongtocity (string as_latlong)
public function boolean of_disconnect ()
public function decimal of_calculatetrip (string as_origin, string as_destination, long al_trip, integer ai_option, integer ai_type, ref decimal ac_distance, ref long al_minutes, ref decimal ac_cost)
public function decimal of_getmilecost ()
public subroutine of_setmilecost (decimal ac_milecost)
public function string of_makelocator (string as_city, string as_state, string as_zip)
public function string of_stripcounty (string as_locator)
public function integer of_timezonesearch (string as_locator)
public function string of_citylatlong (string as_locater)
public subroutine of_sethubmode (long al_trip, boolean ab_mode)
public function long of_calculate (long al_trip, integer ai_option, integer ai_type)
public function long of_gettripleginfo (long al_trip, long al_legnum, ref s_leginfo astr_leginfo)
public function long of_getnumlegs (long al_trip)
public function boolean of_optimize (n_cst_trip_attribs ads_data, long al_option, boolean ab_fixdestination)
public function boolean of_iscanadianpostalinstalled ()
public function boolean of_islatlondecimal (string as_value)
public function string of_decimaltodms (string as_value)
public subroutine of_setbordersopen (string as_value)
end prototypes

public function boolean of_destroy ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Destroy
//
//	Access:  			public
//
//	Arguments:			None
//		
//
//	Returns:  			TRUE if PCMSCloseServer successfull
//	
//
//	Description:		Stop connection to active server
//
//
//////////////////////////////////////////////////////////////////////////////

/*
		comment by norm
		
	We want the server to always be connected. This logic was moved to the
	of_disconnect method and must be exolicitly called. It will be called 
	from the destructor of n_cst_appmanager by way of of_dsiconnect in n_cst_trip.
*/

boolean lb_retval
//n_cst_licensemanager	lnv_licensemanager
//
//lb_retval = PCMSCloseServer( ii_serverid ) > 0
//if lb_retval then ii_serverid = 0
//lnv_licensemanager.of_setpcmilerserverid(0)
return lb_retval

end function

public function long of_setdebug (long al_level);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetDebug
//
//	Access:  			public
//
//	Arguments:
//		al_level			New debug level
//
//	Returns:  			Previous debug level
//	
//
//	Description:		Set new debug level
//
//
//////////////////////////////////////////////////////////////////////////////

return PCMSSetDebug( al_level )
end function

public function long of_getdebug ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetDebug
//
//	Access:  			public
//
//	Arguments:			None
//		
//
//	Returns:  			current debug level
//	
//
//	Description:		Get current debug level
//
//
//////////////////////////////////////////////////////////////////////////////

return PCMSGetDebug( )
end function

public function string of_about (string as_which);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_About
//
//	Access:  			public
//
//	Arguments:
//		as_which			An NAME of the internal DLL resource
//
//	Returns:  			string, containing string value
//	
//
//	Description:		Get internal DLL resource value by NAME
//
//
//////////////////////////////////////////////////////////////////////////////

string ls_about
ls_about = Space( 240 )
if this.PCMSAbout( as_which, ls_about, 240 ) > 0 then 
	return ls_about
else
	return "Data not found!"
end if
end function

private function boolean of_isvalid ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_IsValid
//
//	Access:  			private
//
//	Arguments:			None
//
//	Returns:  			string, containing string value
//	
//
//	Description:		Check if server connection is valid
//
//
//////////////////////////////////////////////////////////////////////////////

return ( PCMSIsValid( ii_serverid ) = 1 )
end function

public function boolean of_setcalctype (integer ai_option);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetCalcType
//
//	Access:  			public
//
//	Arguments:
//		ai_option		Type of calculation
//
//	Returns:  			TRUE if argument is valid
//	
//
//	Description:		Set calculation type
//
//
//////////////////////////////////////////////////////////////////////////////

if ai_option < 0 or ai_option > 4 or isnull(ai_option) then return FALSE
ii_calctype = ai_option
return TRUE
end function

public function integer of_getcalctype ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetCalcType
//
//	Access:  			public
//
//	Arguments:			None
//
//	Returns:  			int, current calculation type
//	
//
//	Description:		Get internal calculation type
//
//
//////////////////////////////////////////////////////////////////////////////

return ii_calctype
end function

public function boolean of_citytolatlong (string as_city, ref string as_latlong);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_CityToLatLong
//
//	Access:  			public
//
//	Arguments:
//		as_city			string, city name
//		as_latlong		string, latlong name
//
//	Returns:  			TRUE if OK
//
//	Description:		Make name conversation from city to latlong style
//
//
//////////////////////////////////////////////////////////////////////////////

// Make conversation
as_latlong = Space( 256 )
if PCMSCityToLatLong ( ii_serverid, as_city, as_latlong, 256 ) > 0 then return TRUE

// If error - check city name
long ll_check
ll_check = PCMSCheckPlaceName( ii_serverid, as_city )
if ll_check <> 1 then
	il_err_code = -1001
	is_err_message = "Invalid city name"
	return FALSE
end if

// If other error
of_GetLastSysError( il_err_code, is_err_message )
return FALSE




end function

public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Calculate
//
//	Access:  			public
//
//	Arguments:
//		as_origin		string, origin name
//		as_destination	string, destination name
//		al_distance		ref long distance
//		al_minutes		ref long minutes
//
//	Returns:  			integer retval code:
//								1 		- OK
//								<0 	- System error ( use of_GetLastError to understand )
//								-1002	- Invalid origin
//								-1003 - Invalid destination
//	
//
//	Description:		Make milage calculation
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_distance, ll_minutes

// Check parameters
if Len( as_origin ) = 0 or IsNull( as_origin ) then goto invalid_origin
if Len( as_destination ) = 0 or IsNull( as_destination ) then goto invalid_destination

// Make calculation
ll_distance = PCMSCalcDistance3( ii_serverid, as_origin, as_destination, this.of_GetCalctype( ), ll_minutes )

// If error - make validation of places
long ll_check
if ll_distance < 0 then  //Vladimir had < 1
	// Check origin
	ll_check = PCMSCheckPlaceName( ii_serverid, as_origin )
	if ll_check <> 1 then goto invalid_origin
	// Check destination
	ll_check = PCMSCheckPlaceName( ii_serverid, as_destination )
	if ll_check <> 1 then goto invalid_destination
	// Check system error
	goto system_error
end if

ad_distance = ll_distance / 10.0		// Result must be in miles
al_minutes = ll_minutes
return 1

invalid_origin:
	il_err_code = -1002
	is_err_message = "Invalid origin name"
	return il_err_code

invalid_destination:
	il_err_code = -1003
	is_err_message = "Invalid destination name"
	return il_err_code

system_error:
	of_GetLastSysError( il_err_code, is_err_message )
	return il_err_code

end function

public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Calculate
//
//	Access:  			public
//
//	Arguments:
//		as_origin		string, origin name
//		as_destination	string, destination name
//		al_distance		ref long distance
//
//	Returns:  			integer retval code:
//								1 		- OK
//								<0 	- System error ( use of_GetLastError to understand )
//								-1002	- Invalid origin
//								-1003 - Invalid destination
//	
//
//	Description:		Make milage calculation
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_minutes
return this.of_Calculate( as_origin, as_destination, ad_distance, ll_minutes )

end function

public function boolean of_latlongtocity (string as_latlong, ref string as_city);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_ToLatLongCity
//
//	Access:  			public
//
//	Arguments:
//		as_latlong		string, latlong name
//		as_city			ref string, city name
//
//	Returns:  			TRUE if OK
//
//	Description:		Make name conversation from latlong to city style
//
//
//////////////////////////////////////////////////////////////////////////////

// Make conversation
as_city = Space( 256 )
if PCMSLatLongToCity( ii_serverid, as_latlong, as_city, 256 ) > 0 then return TRUE

// If error - check city name
long ll_check
ll_check = PCMSCheckPlaceName( ii_serverid, as_city )
if ll_check <> 1 then
	il_err_code = -1000
	is_err_message = "Invalid latlong name"
	return FALSE
end if

// If other error
of_GetLastSysError( il_err_code, is_err_message )
return FALSE



end function

public function string of_lookup (string as_place, long al_easy);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Lookup
//
//	Access:  			public
//
//	Arguments:
//		as_place			string, place name
//		ai_easy			gc_Routing.EXACT_MATCH or gc_Routing.PARTIAL_MATCH
//
//	Returns:  			string ( "~n" delimited list of matches )
//	
//
//	Description:		Create place list matches
//
//
//////////////////////////////////////////////////////////////////////////////

string	ls_matches, &
			ls_nocomma
long		ll_Pos
// Check parameters
if IsNull( as_place ) or Len( as_place ) = 0 then 
	il_err_code = -1005
	is_err_message = "Invalid place name"
	return ""
end if
if al_easy <> appeon_constant.EXACT_MATCH and al_easy <> appeon_constant.PARTIAL_MATCH then 
	il_err_code = -1006
	is_err_message = "Invalid function parameter(s)"
	return ""
end if

// Create "phantom" trip
long ll_trip
ll_trip = of_CreateTrip( )
if ll_trip < 1 then 
	of_GetLastSysError( il_err_code, is_err_message )
	return ls_matches
end if

// Get count of matches
long ll_count
ll_count = PCMSLookup( ll_trip, as_place, al_easy )

if ll_count = 0 then
	if this.of_isoldpcmilerversion() then
		//try without comma
		ll_pos = pos(as_place,',')
		if ll_pos > 0 then
			ls_nocomma = replace(as_place, ll_Pos, 1, '')
			ll_count = PCMSLookup( ll_trip, ls_nocomma, al_easy )
		end if
	end if
end if

if ll_count = 0 then goto clearall

// Get all matches
ls_matches = this.of_getmatches(ll_trip)

clearall:
	// Delete "phantom" trip
	of_DeleteTrip( ll_trip )
	return ls_matches
end function

public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes, long al_option);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Calculate
//
//	Access:  			public
//
//	Arguments:
//		as_origin		string, origin name
//		as_destination	string, destination name
//		al_distance		ref long distance
//		al_minutes		ref long minutes
//		al_option		long trip calc option
//
//	Returns:  			integer retval code:
//								1 		- OK
//								<0 	- System error ( use of_GetLastError to understand )
//								-1002	- Invalid origin
//								-1003 - Invalid destination
//	
//
//	Description:		Make milage calculation
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_minutes
decimal ld_distance

// Check parameters
if Len( as_origin ) = 0 or IsNull( as_origin ) then goto invalid_origin
if Len( as_destination ) = 0 or IsNull( as_destination ) then goto invalid_destination

// Try to calculate through cache
if this.of_FindInCache( as_origin, as_destination, ld_distance, ll_minutes, al_option ) then
	// Set Output variables if item founded in cache seccessfully
	ad_distance = ld_distance
	al_minutes = ll_minutes
else
	// If cache not active or item not found, make direct calculation
	long ll_distance
	ll_distance = this.PCMSCalcDistance3( ii_serverid, as_origin, as_destination, al_option, ll_minutes )
	// If error - make validation of places
	long ll_check
	if ll_distance < 0 then   //Vladimir had < 1
		// Check origin
		ll_check = PCMSCheckPlaceName( ii_serverid, as_origin )
		if ll_check <> 1 then goto invalid_origin
		// Check destination
		ll_check = PCMSCheckPlaceName( ii_serverid, as_destination )
		if ll_check <> 1 then goto invalid_destination
		// Check system error
		goto system_error
	end if
	// Update cache object
	this.of_AddIntoCache( as_origin, as_destination, ll_distance / 10.0 , ll_minutes, al_option )
	// Set Output variables
	ad_distance = ll_distance / 10.0		// Result must be in miles
	al_minutes = ll_minutes
end if

return 1

invalid_origin:
	il_err_code = -1002
	is_err_message = "Invalid origin name"
	return il_err_code

invalid_destination:
	il_err_code = -1003
	is_err_message = "Invalid destination name"
	return il_err_code

system_error:
	of_GetLastSysError( il_err_code, is_err_message )
	return il_err_code

end function

public function long of_getreport (long al_trip, long al_num, ref string as_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetReport
//
//	Access:  			public
//
//	Arguments:
//		al_trip			long TRIP_ID
//		al_num			long report number ( from 0 to 2 )
//		as_data			ref string report buffer
//
//	Returns:  			length of data or error code
//	
//
//	Description:		Get report data for trip
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_trip ) then
	il_err_code = -1007
	is_err_message = "Invalid TRIP_ID"
	return il_err_code
end if
if IsNull( al_num ) or al_num < 0 or al_num > 2 then
	il_err_code = -1008
	is_err_message = "Invalid report number"
	return il_err_code
end if

// Get report lines count 
long ll_index, ll_lines
ll_lines = PCMSNumRptLines( al_trip, al_num )
as_data = ""
string ls_line
for ll_index = 1 to ll_lines
	ls_line = Space( 256 )
	PCMSGetRptLine( al_trip, al_num, ll_index, ls_line, 256 )
	if len(trim(ls_line)) > 0 then
		as_data += ls_line + "~r~n"
	end if
next
return Len( as_data )
end function

private function boolean of_setloaded (long al_trip, long al_index, boolean ab_switch);return TRUE

end function

public function integer of_addstop (long al_trip, string as_stop);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_AddStop
//
//	Access:  			private
//
//	Arguments:
//		al_trip			long TRIP_ID
//		as_stop			string, stop name
//
//	Returns:  			integer retval code:
//								1 		- OK
//								<0 	- System error ( use of_GetLastError to understand )
//								-1005	- Invalid stop name
//
//	Description:		Add new stop into trip
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if Len( trim (as_stop ) ) = 0 or IsNull( as_stop ) then goto invalid_stop

// Add stop into trip
long ll_retval
ll_retval = PCMSAddStop( al_trip, as_stop )

// If error - make validation of places
long ll_check
if ll_retval < 1 then
	// Check origin
	ll_check = PCMSCheckPlaceName( ii_serverid, as_stop )
	if ll_check <> 1 then goto invalid_stop
	// Check system error
	goto system_error
end if

return ll_retval

invalid_stop:
	il_err_code = -1005
	is_err_message = "Invalid stop name"
	return il_err_code

system_error:
	of_GetLastSysError( il_err_code, is_err_message )
	return il_err_code

end function

public function long of_createtrip ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_CreateTrip
//
//	Access:  			public
//
//	Arguments:			None
//
//	Returns:  			long, TRIP_ID
//	
//
//	Description:		Create new trip
//
//
//////////////////////////////////////////////////////////////////////////////

long ll_retval, ll_count
ll_retval = PCMSNewTrip( ii_serverid )
if ll_retval < 1 then
	of_GetLastSysError( il_err_code, is_err_message )
	return il_err_code
end if
return ll_retval
end function

public subroutine of_deletetrip (long al_trip);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_DeleteTrip
//
//	Access:  			public
//
//	Arguments:
//		al_trip			TRIP_ID
//
//	Returns:  			None
//	
//
//	Description:		Delete trip with TRIP_ID = al_trip
//
//
//////////////////////////////////////////////////////////////////////////////

PCMSDeleteTrip( al_trip )
end subroutine

public function long of_getlastsyserror (ref long al_errcode, ref string as_errmsg);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_GetLastSysError
//
//	Access:  			public
//
//	Arguments:
//		al_errcode		place for returning error code
//		as_errmsg		place for returning error message
//
//	Returns:  			error code
//	
//
//	Description:		Get current dll's error code and error message
//
//
//////////////////////////////////////////////////////////////////////////////

// Get error code and message string
long ll_retval
al_errcode = PCMSGetError( )
as_errmsg = Space( 256 )
ll_retval = PCMSGetErrorString( al_errcode, as_errmsg, long( 256 ) )
return al_errcode
end function

public subroutine of_settripoptions (long al_trip, n_cst_trip_attribs ads_data);//This functionality has not been verified, as to functionality and defaults.
//the calls to it have been commented out

// Set ALL trip options
 PCMSSetBordersOpen( al_trip, ads_data.il_borders_open )
if ads_data.is_unit = "miles" then
	PCMSSetKilometers( al_trip )
else
	PCMSSetMiles( al_trip )
end if
PCMSSetCost( al_trip, ads_data.id_cost )
PCMSSetUseShapePts( al_trip, ads_data.il_use_shape_pts )
PCMSSetHubMode( al_trip, ads_data.il_hub_mode )
PCMSSetAlphaOrder( al_trip, ads_data.il_alpha_order )
PCMSConvertLLToPlace( al_trip, ads_data.il_convert_ll_to_place )
PCMSSetBreakHours( al_trip, ads_data.il_break_hours )
PCMSSetBreakWaitHours( al_trip, ads_data.il_break_wait_hours )
PCMSSetCustomMode( al_trip, ads_data.il_custom_mode )

end subroutine

public function long of_getreport (long al_num, n_cst_trip_attribs ads_data, ref string as_data, long al_option);// Check input parameters
if IsNull( ads_data ) or not IsValid( ads_data ) then
	il_err_code = -1008
	is_err_message = "Invalid trip data"
	return il_err_code
end if
if IsNull( al_num ) or al_num < 0 or al_num > 2 then
	il_err_code = -1007
	is_err_message = "Invalid report number"
	return il_err_code
end if

// Create trip
long ll_trip
ll_trip = of_CreateTrip( )
if ll_trip < 1 then
	of_GetLastSysError( il_err_code, is_err_message )
	return il_err_code
end if

//This functionality has not been verified, as to functionality and defaults.
//So, we're going to skip it for now.
//of_SetTripOptions( ll_trip, ads_data )
if isnull(al_option) then
	//leave as default
else
	This.PCMSSetCalcType( ll_trip, al_option )
end if
if isnull(il_BordersOpen) then
	//leave as default
else
	this.PCMSSetBordersOpen( ll_trip, il_BordersOpen)
end if

// Add all stops into trip
long ll_index, ll_count
ll_count = ads_data.RowCount( )
for ll_index = 1 to ll_count
	if of_AddStop( ll_trip, ads_data.GetItemString( ll_index, "stop" ) ) < 1 then 
		of_GetLastSysError( il_err_code, is_err_message )
		of_DeleteTrip( ll_trip )
		return il_err_code
	end if
	of_SetLoaded( ll_trip, ll_index, ( ads_data.GetItemNumber( ll_index, "loaded" ) = appeon_constant.STATE_LOADED ) )
next

// Prepare report data
long ll_dist
ll_dist = PCMSCalculate( ll_trip )
if ll_dist < 1 then
	of_GetLastSysError( il_err_code, is_err_message )
	of_DeleteTrip( ll_trip )
	return il_err_code
end if

// Get report data
long ll_size
ll_size = of_GetReport( ll_trip, al_num, as_data )
if ll_size < 1 then
	of_GetLastSysError( il_err_code, is_err_message )
	of_DeleteTrip( ll_trip )
	return il_err_code
end if
	

// Delete trip
of_DeleteTrip( ll_trip )

// Return
return ll_size

end function

public function boolean of_create (ref integer ai_serverid);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Create
//
//	Access:  			public
//
//	Arguments:			None
//		
//
//	Returns:  			TRUE if PCMSOpenServer successfull
//	
//
//	Description:		Start connection to active server
//
//
//////////////////////////////////////////////////////////////////////////////
integer	li_serverid
boolean	lb_licensed
n_cst_licensemanager	lnv_licensemanager

if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or &
		lnv_LicenseManager.of_haspcmilerlicense()) then
		lb_licensed = true
else
	lb_licensed = false
end if

if lb_licensed then
	li_serverid = lnv_LicenseManager.of_getpcmilerserverid ()
	if li_serverid > 0 then
		ii_serverid = li_serverid
	else
		ii_serverid = this.PCMSOpenServer( 0, 0 )
		lnv_LicenseManager.of_setpcmilerserverid (ii_serverid)
	end if
else
	//no license	
end if

if ii_serverid > 0 then
	ai_serverid = ii_serverid
end if
return ( ii_serverid > 0 )
end function

public function boolean of_validplacename (string as_place);boolean	lb_valid

if pcmscheckplacename(ii_serverid, as_place ) > 0 then
	lb_valid=true
end if

return  lb_valid
end function

public function boolean of_isoldpcmilerversion ();//this should be change to do only once and store an instance that can be checked

// version 11 did not have a comma between the city state.
// versions after that did.
boolean	lb_oldformat
string	ls_locater, &
			ls_match
long		ll_trip, &
			ll_match
			
ll_trip = PCMSNewTrip(ii_serverid)


//lookup zip and check 
ls_locater="03857"
ll_match = PCMSLookup(ll_trip, ls_locater, 1)
if ll_match > 0 then
	ls_match = space(128)
	PCMSGetMatch(ll_trip, 0, ls_match, 128)
	IF pos ( ls_match, ',',1 ) = 0 then 
		lb_OldFormat=TRUE
	ELSE
		lb_OldFormat=FALSE
	END IF
end if
PCMSDeleteTrip(ll_trip)

return lb_OldFormat


end function

public function boolean of_isstreets ();return FALSE
end function

public function string of_lookup (string as_place, boolean ab_exactmatch, boolean ab_partialmatch, boolean ab_showpicklist);string	ls_match, &
			ls_exactmatch, &
			lsa_partialmatch[]

integer	li_partialmatch, &
			li_selected, &
			li_ndx
			
s_strings lstr_SelectionList
n_cst_string	lnv_string

if ab_exactmatch then
	ls_exactmatch = this.of_lookup(as_place, 1 )
end if

if ab_partialmatch then
	ls_match = this.of_lookup(as_place, 0 )
	if len(ls_match) > 0 then
		lnv_string.of_parsetoarray(ls_match, "~n", lsa_partialmatch)
		li_partialmatch=upperbound(lsa_partialmatch)
	end if
end if

if ab_showpicklist then
	
	if li_partialmatch > 0 then
		//Build the message header for the selection dialog.
		lstr_SelectionList.strar[1] = "Location Selection" 
	
		//Build the message text for the selection dialog.
		lstr_SelectionList.strar[2] = "PC*Miler has found multiple locations matching your request.  "+&
			"Please select one."
		for li_ndx = 1 to li_partialmatch
			lstr_SelectionList.strar[li_ndx + 4] = lsa_partialmatch[li_ndx]
		next
		li_selected = this.of_showpicklist(lstr_SelectionList)
		if li_selected > 0 and li_selected <= li_partialmatch then
			ls_exactmatch = lsa_partialmatch[li_selected]
		else
			ls_exactmatch = ''
		end if
	end if
end if	

return ls_exactmatch

end function

public function string of_getmatches (long al_trip);// Get all matches

long	ll_index, &
		ll_count
string	ls_buffer, &
			ls_matches

ll_count = PCMSNumMatches( al_trip )

for ll_index = 0 to ll_count - 1
	ls_buffer = Space( 256)
//	if this.of_isoldpcmilerversion() then
//		PCMSGetMatch( al_trip, ll_index, ls_buffer, 256 )
//	else
		PCMSGetMatch( al_trip, ll_index, ls_buffer, 256 )
//	end if
	ls_buffer = RightTrim( LeftTrim( ls_buffer ) )
	if Len( ls_buffer ) > 0 then ls_matches += ls_buffer + "~n"
next

return Left( ls_matches, Len( ls_matches ) - 1 )


end function

public function integer of_showpicklist (s_strings astr_selectionlist);string	ls_response			
integer	li_selected

w_list_sel	lw_selectionlist

openwithparm(lw_selectionlist, astr_selectionlist)
ls_response = message.stringparm
if len(ls_response) > 0 then 
	li_selected = integer(left(ls_response, len(ls_response) - 1))
end if

return li_selected


end function

public function boolean of_validatestateabreviation (string as_state);/*----------------------------------------------------------------------------------
Purpose-----------
  This function returns 1 if sent value is valid state or providence.  
  This function returns -1 if an invalid stare or providence was sent.

Arguements--------
	check_state:  state to be verfied
------------------------------------------------------------------------------------*/
boolean	lb_isvalid = true
if len(trim(as_state)) = 0 or isnull(as_state) then
	lb_isvalid = false
end if 
if lb_isvalid then
	choose case as_state
		case "HI"
			lb_isvalid = true
		case "AK"
			lb_isvalid = true
		case "CA", "NV", "WA", "YK"
			lb_isvalid = true
		case "AZ", "CO", "MT", "NM", "UT", "WY", "AB"
			lb_isvalid = true
		case "AL", "AR", "IL", "IA", "LA", "MN", "MS", "MO", "OK", &
			"WI", "MB"
			lb_isvalid = true
		case "CT", "DE", "DC", "GA", "ME", "MD", "MA", "NH", &
			"NJ", "NY", "NC", "OH", "PA", "RI", "SC", "VT", "VA", "WV", "PQ", "QC"
			lb_isvalid = true
		case "NB", "NF", "NS", "PE"
			lb_isvalid = true
		case "ID", "OR", "BC", "KS", "NE", "ND", "SD", "TX", "SK", "FL", &
			"IN", "KY", "MI", "TN", "ON", "NT", "MX"
			lb_isvalid = true
		case else
			lb_isvalid = false
	end choose
end if
return lb_isvalid

end function

public function string of_getpartoflocater (string as_locater, string as_whichpart, boolean ab_pcmilerlocater);/*
	This method is for user entered locaters or pcmiler locaters.
	
	The boolean argument is to differentiate between a user entered or code
	built locater and a PCMiler generated locater.
	If it is generated the the county needs to be stripped out.
*/
string 	ls_Return, &
			ls_locater
Long		ll_pos, &
			ll_pos2, &
			ll_length, &
			ll_ndx
			

//we need to remove the county first
if ab_pcmilerlocater then
	ls_locater = this.of_stripcounty(as_locater)
else
	ls_locater = as_locater
end if

choose case upper ( as_whichpart )

case this.cs_Locater_ZipCode
	if this.of_IsCanadianPostalInstalled ( ) theN
		if Match(left(ls_locater,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
			//canadian postal
			ls_return = left(ls_locater,7)
		else
			if isnumber ( left ( ls_locater, 1) ) then
				ls_Return = left ( ls_locater,5 ) 
			end if
		end if
	elseif isnumber ( left ( ls_locater, 1) ) then
		ls_Return = left ( ls_locater,5 ) 
	end if
	
case this.cs_Locater_City
	//	first strip of zip if there is one
	if this.of_IsCanadianPostalInstalled ( ) then
		if Match(left(ls_locater,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
			//canadian postal
			ls_locater = right ( ls_locater, len ( ls_locater ) - 8 )
		else
			if isnumber ( left ( ls_locater, 1 ) ) then
				ls_locater = right ( ls_locater, len ( ls_locater ) - 6 )
			end if
		end if
	elseif isnumber ( left ( ls_locater, 1 ) ) then
		ls_locater = right ( ls_locater, len ( ls_locater ) - 6 )
	end if
	
	ls_locater = trim ( ls_locater )
	ll_length = len(ls_locater)
	
	//city could be more than one name, therefore we must search from the
	//right side of the locater to strip off the state
	
	if this.of_isoldpcmilerversion() then
		ls_return = Trim ( Left ( Upper ( trim ( ls_locater ) ), len(ls_locater) - 3 ) )
//		//no comma entered, there must be a space between city /state
//		for ll_ndx = ll_length to 1 step -1
//			if mid ( ls_locater, ll_ndx, 1) = ' ' then
//				ls_return = left ( ls_locater, ll_Ndx - 1 ) 
//				exit
//			end if
//		next
	else
		for ll_ndx = ll_length to 1 step -1
			if mid ( ls_locater, ll_ndx, 1) = ',' then
				ls_return = left ( ls_locater, ll_Ndx - 1 ) 
				exit
			end if
		next
	end if
	
case this.cs_Locater_State
	//	first strip of zip if there is one
	if this.of_IsCanadianPostalInstalled ( ) then
		if Match(left(ls_locater,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
			//canadian postal
			ls_locater = right ( ls_locater, len ( ls_locater ) - 8 )
		end if
	elseif isnumber ( left ( ls_locater, 1 ) ) then
		ls_locater = right ( ls_locater, len ( ls_locater ) - 6 )
	end if
	
	if this.of_isoldpcmilerversion() then
		//For pcmiler version 11 - state is in position 21 for 2
		ls_return = right ( ls_locater, 2) 
	else
		ll_pos = pos ( ls_locater,"," )
		if ll_pos > 0 then
			ls_return = trim ( right ( ls_locater, len(ls_locater) - ll_pos ) )
		else 
			//bad locater
			ls_return = ''
		end if
	end if

case else
	ls_Return = " "
	
end choose

return upper(ls_return)
end function

public function integer of_locationcheck (string as_checklocation, ref string as_foundlocation, boolean ab_exactmatch);/*
	This function was formerly known as gf_loc_check.
	It was moved here and slightly modified to use the new pcmiler object.
	
	Also a boolean argument is used to determine if this function is to be used
	for an exact match or to show a list if an exact match wasn't found.
		
		true = exact match // no list
*/
SetPointer(HourGlass!)
integer	matches[0 to 1], &
			ll_ndx, &
			ll_max, &
			li_return = 0
			
string	ls_zip, &
			ls_state, &
			ls_city, &
			loc_vals[], &
			ls_match, &
			lsa_match0[], &
			lsa_match1[]

n_cst_string lnv_string

//version and product should have been determined by this object

//matches[1] exact match , if none found try easy match

ls_match = this.of_lookup(as_checklocation, 1 )
if len(ls_match) > 0 then
	lnv_string.of_parsetoarray(ls_match, "~n", lsa_match1)
	matches[1]=upperbound(lsa_match1)
end if

if not ab_exactmatch then
	if matches[1] = 0 then  
		ls_match = this.of_lookup(as_checklocation, 0 )
		if len(ls_match) > 0 then
			lnv_string.of_parsetoarray(ls_match, "~n", lsa_match1)
			matches[1]=upperbound(lsa_match1)
		end if
	end if
end if

if matches[1] > 0 then
	for ll_ndx = 1 to matches[1] 
		loc_vals[ll_ndx] = lsa_match1[ll_ndx]
	next
end if

//matches[0] easy match
if not ab_exactmatch then
	ls_match = this.of_lookup(as_checklocation, 0 )
	if len(ls_match) > 0 then
		lnv_string.of_parsetoarray(ls_match, "~n", lsa_match0)
		matches[0]=upperbound(lsa_match0)
	end if
end if

if not ab_exactmatch then
	if matches[1] = 0 and matches[0] = 0 then
		
	// still no match let's take a closer look at the locater
	
		//Was zip entered by itself
		if isnumber(trim ( as_checklocation )) then
			//try first 3
			ls_zip = this.of_getpartoflocater(as_checklocation, cs_Locater_Zipcode, false)
			if len(ls_zip) > 2 then
				ls_zip = left(ls_zip,3) + "*"
			elseif len (ls_zip) > 1 then
				ls_zip = left(ls_zip,2) + "*"
			else
				messagebox("Invalid Request", "The zipcode is not valid.")	
				li_return = -1
			end if
			ls_match = this.of_lookup(ls_zip, 0 )
			if len(ls_match) > 0 then
				lnv_string.of_parsetoarray(ls_match, "~n", lsa_match0)
				matches[0]=upperbound(lsa_match0)
			end if
			if matches[0] > 0 then
				for ll_ndx = 1 to matches[0] 
					loc_vals[ll_ndx] = lsa_match0[ll_ndx]
				next
			else
				li_return = -1
			end if
		else
			//if not by zip then validate city/state
			//is state valid
			ls_state = this.of_getpartoflocater(as_checklocation, cs_Locater_State, false)
			if not this.of_validatestateabreviation (ls_state) then
				messagebox("Invalid Request", "The state is not valid.")	
				li_return = -1
				
				//*****needlogic here to bail out for invalid state or . instead of comma
			else
				//if state is valid then let's cut the city down to two
				ls_city = left (this.of_getpartoflocater(as_checklocation, cs_Locater_City, false), 2 )
				
				if this.of_isoldpcmilerversion () then
					ls_match = this.of_lookup(ls_city + '* ' + ls_state, 0 )
				else
					ls_match = this.of_lookup(ls_city + '*, ' + ls_state, 0 )
				end if
				
				if len(ls_match) > 0 then
					lnv_string.of_parsetoarray(ls_match, "~n", lsa_match0)
					matches[0]=upperbound(lsa_match0)
				end if
			
				if matches[0] > 0 then
					for ll_ndx = 1 to matches[0] 
						loc_vals[ll_ndx] = lsa_match0[ll_ndx]
					next
				else
					li_return = -1
				end if
			end if
		end if
	end if	
end if

if li_return = 0 then
	//the following logic should remain unchanged
	if matches[1] < 1  and ab_exactmatch then
		as_foundlocation = "Could not verify location with PC*Miler.~n~nNo matches found."
		li_return = -1
	elseif matches[1] = 1 then
		as_foundlocation = loc_vals[1]
		if matches[0] <= 5 then return 2 else return 1
	else
		if ab_exactmatch then
			li_return = 0
		else
			s_strings loc_list
			w_list_sel selwin
			string response
			integer loc_sel
			loc_list.strar[2] = "PC*Miler has found multiple locations matching your request.  "+&
				"Please select one."
			if matches[1] > 0 then
				ll_max = matches[1]
			else
				ll_max = matches[0]
			end if
			for ll_ndx = 1 to ll_max
				loc_list.strar[ll_ndx + 4] = loc_vals[ll_ndx]
			next
			openwithparm(selwin, loc_list)
			response = message.stringparm
			SetPointer(HourGlass!)
			if len(response) > 0 then loc_sel = integer(left(response, len(response) - 1))
			if loc_sel > 0 and loc_sel <= upperbound(loc_vals) then
				as_foundlocation = loc_vals[loc_sel]
				li_return = 2
			else
				li_return = 0
			end if
		end if
	end if
end if

return li_return
end function

public function long of_gettripduration (long al_trip);return pcmsgetduration(al_trip)
end function

public function long of_gettripstops (long al_trip);return pcmsnumstops(al_trip)
end function

public subroutine of_cleanupmap ();inv_mapping = create n_cst_mapping
inv_mapping.of_cleanup ()
destroy inv_mapping
end subroutine

public subroutine of_clearstops (long al_trip);pcmsclearstops(al_trip)
end subroutine

public function string of_latlongtocity (string as_latlong);string	ls_locater
long		ll_buflen=256

ls_locater=space(256)

PCMSLatLongToCity ( ii_serverid , as_latlong, ls_locater, 200)

return ls_locater
end function

public function boolean of_disconnect ();boolean lb_retval
n_cst_licensemanager	lnv_licensemanager

lb_retval = PCMSCloseServer( ii_serverid ) > 0
if lb_retval then ii_serverid = 0
lnv_licensemanager.of_setpcmilerserverid(0)
return lb_retval

end function

public function decimal of_calculatetrip (string as_origin, string as_destination, long al_trip, integer ai_option, integer ai_type, ref decimal ac_distance, ref long al_minutes, ref decimal ac_cost);// Create "phantom" trip
string	ls_version

long	ll_return = 1, &
		ll_setcost, &
		ll_option, &
		ll_bufsize=256, &
		ll_retval, &
		ll_distance
		
decimal	lc_distance, &
			lc_cost, &
			lc_legcost
		
if al_trip < 1 then
	ll_return = -1
end if

if ll_return = 1 then
//	ll_option = pcmsgetoptions(al_trip)
//	if pcmsgetoptions(al_trip) <> ai_option then
//		pcmssetoptions(al_trip, ai_option)
//	end if
//
//	if pcmsgetcalctype(al_trip) <> ai_type then
//		pcmssetcalctype(al_trip, ai_type)
//	end if
	
	if ic_milecost > 0 then
		ll_setcost = long(ic_milecost * 100 )
		pcmssetcost(al_trip,ll_setcost)
	end if
	
	ac_distance = pcmscalctrip(al_trip, as_origin, as_destination) / 10.0
	//this could return -1 if the trip couldn't be calculated
	//change -1 to 0
	if ac_distance < 0 then
		ac_distance = 0
	else
		al_minutes = this.of_gettripduration (al_trip)
		if this.of_isstreets() then
			//returns cost per mile
			lc_cost = PCMSGetCost( al_trip ) / 100.0
			ac_cost = lc_cost * ac_distance
		else
			ls_version = this.of_about("ProductVersion")
			choose case ls_version
				case '11.0', '12.0', '2000.0', '14.0'
					lc_cost = PCMSGetCost( al_trip ) / 100.0
					ac_cost = lc_cost * ac_distance
				case else 	//"15.0" , "16.0" //returns calculated cost
					ac_cost = PCMSGetCost( al_trip ) / 100.0
			end choose
		end if
	end if
end if

// Delete "phantom" trip
of_DeleteTrip( al_trip )

return lc_distance
end function

public function decimal of_getmilecost ();return ic_milecost
end function

public subroutine of_setmilecost (decimal ac_milecost);if isnull(ac_milecost) then
	ic_milecost = 0
else
	ic_milecost = ac_milecost
end if
end subroutine

public function string of_makelocator (string as_city, string as_state, string as_zip);string	ls_locator, &
			ls_foundlocator, &
			ls_return
			
if isnumber(left(as_zip,5)) then
	ls_locator = left(as_zip,5) + ' '
end if
	
if len(trim(as_city)) > 0 and len(trim(as_state)) > 0 then
	if this.of_isoldpcmilerversion() then
		ls_locator += trim(as_city) + " " + trim(as_state)
	else
		ls_locator += trim(as_city) + ", " + trim(as_state)
	end if		
end if

if this.of_locationcheck(ls_locator, ls_foundlocator, true ) > 0 then
	//strip county, not storing that as part of locator
	ls_return = this.of_stripcounty(ls_foundlocator)
else
	ls_return = ''
end if


return ls_return
end function

public function string of_stripcounty (string as_locator);string	ls_locator
long		ll_pos, &
			ll_pos2
			
if this.of_isoldpcmilerversion () then
	//no county in this version
	ls_locator = as_locator
else
	//first locate comma for state then locate space after state and 
	//remove everything after that.
	ll_pos = pos ( as_locator,"," )
	ll_pos2 = pos ( as_locator, ",", ll_pos + 1 )
	if ll_pos2 > 0 then
	//add 1 to ll_pos to avoid possibly getting space between comma and state
//	ll_pos2 = pos ( as_locator," ", ll_pos + 3 ) 
		ls_locator = left(as_locator, ll_pos2 - 1 ) 
	else
		ls_locator = as_locator
		
	end if
	
end if

return ls_locator

end function

public function integer of_timezonesearch (string as_locator);/*----------------------------------------------------------------------------------
Purpose-----------
  This function returns a timezone if it can determine FOR 100 % SURE what the time
zone is.  
Arguements--------
	locater:  state or PCmiler ID.  (Obviously the program will more likely return a 
		tz if the full pcmiler ID is sent.

Return Value -----	
	return value is the timezone or -1 if there is a mistake
------------------------------------------------------------------------------------*/
string	ls_state, &
			ls_city, &
			ls_latlong, &
			ls_long, &
			ls_locater
			
long		ll_lat, &
			ll_long
			
integer tz

ls_state = this.of_getpartoflocater(as_locator,"STATE",TRUE)
ls_city	= this.of_getpartoflocater(as_locator,"CITY",TRUE)

if this.of_isstreets() then
	//already in latlong
	ls_latlong = as_locator
else
	if this.of_isoldpcmilerversion() then
		ls_locater = ls_city + ' ' + ls_state
	else
		ls_locater = ls_city + ', ' + ls_state
	end if
	ls_latlong = this.of_citylatlong(ls_locater)
end if

IF len(ls_state) > 0 then
	choose case ls_state
		case "HI"
			tz = 0
		case "AK"
			tz = 1
		case "CA", "NV", "WA", "YK"
			tz = 2
		case "AZ", "CO", "MT", "NM", "UT", "WY", "AB"
			tz = 3
		case "AL", "AR", "IL", "IA", "LA", "MN", "MS", "MO", "OK", &
			"WI", "MB"
			tz = 4
		case "CT", "DE", "DC", "GA", "ME", "MD", "MA", "NH", &
			"NJ", "NY", "NC", "OH", "PA", "RI", "SC", "VT", "VA", "WV", "PQ", "QC"
			tz = 5
		case "NB", "NF", "NS", "PE"
			tz = 6
		case "ID", "OR", "BC", "KS", "NE", "ND", "SD", "TX", "SK", "FL", &
			"IN", "KY", "MI", "TN", "ON", "NT", "MX"
			tz = -1
		case else
			tz = -1
	end choose
end if
if tz = -1 then
	//couldn' t mactch state let's try latlong

	
	ll_lat = long(left(ls_latlong, 7))
	ls_long = right(ls_latlong, 8)
	ll_long = long(left(ls_long,7))
	
	choose case ls_state
		case "FL"
			if ll_long >= 852401 then
				tz = 4
			elseif ll_long <= 844908 then
				tz = 5
			elseif ls_city = "MARIANNA" then
				tz = 4
			end if
		case "ID"
			if ll_lat >= 455912 then
				tz = 2
			elseif ll_lat <= 452237 then
				tz = 3
			elseif ls_city = "GRANGEVILLE" then
				tz = 2
			end if
		case "IN"
			if ls_city = "EVANSVILLE" or ls_city = "MICHIGAN ls_city" or ls_city = "GARY" or &
				ls_city = "BOONVILLE" or ls_city = "MOUNT VERNON" or ls_city = "VALPARAISO" or &
				ls_city = "MERRILLVILLE" or ls_city = "LAKE STATION" or ls_city = "SCHERERVILLE" or &
				ls_city = "PRINCETON" or ls_city = "LA PORTE" then 
				tz = 4 
			elseif ls_city = "JASPER" then
				tz = 5
			elseif ll_lat > 404348 and ll_long > 862655 then
				tz = -1
			elseif ll_lat < 383123 and ll_long > 864457 then
				tz = -1
			else
				tz = 5
			end if
		case "KS"
			if ll_long <= 1010453 then
				tz = 4
			elseif ls_city = "GOODLAND" then
				tz = 3
			end if
		case "KY"
			if ll_lat >= 380220 or ll_long <= 843235 then
				tz = 5 
			elseif ll_long >= 863154 then 
				tz = 4
			elseif ll_long <= 860251 and ll_lat >= 372741 then
				tz = 5
			elseif ll_long > 850231 and ll_lat < 371120 then
				tz = 4
			elseif ls_city = "SOMERSET" or ls_city = "CAMPBELLSVILL" then
				tz = 5
			end if
		case "MI"
			if ll_long <= 871320 then 
				tz = 5
			elseif ls_city = "MARQUETTE" or ls_city = "NEGAUNEE" or ls_city = "ISHPEMING" & 
				or ls_city = "HOUGHTON" then 
				tz = 5
			elseif ls_city = "IRON MOUNTAIN" or ls_city = "KINGSFORD" then
				tz = 4
			end if
		case "NE"
			if ll_long >= 1012316 then
				tz = 3
			elseif ll_long <= 1004346 then
				tz = 4
			elseif ls_city = "NORTH PLATTE" then 	
				tz = 4
			end if
		case "ND"
			if ll_long <= 1003105 or ll_lat >= 475536 then
				tz = 4
			elseif ls_city = "BISMARCK" then
				tz = 4
			elseif ls_city = "DICKINSON" then 
				tz = 3 
			end if
		case "OR"
			if ll_lat >= 442614 or ll_long >= 1181722 then
				tz = 2
			end if
		case "SD"
			if ll_long >= 1004610 then
				tz = 3
			elseif ll_long <= 1001206 then
				tz = 4
			elseif ls_city = "PIERRE" then
				tz = 4
			end if
		case "TN"
			if ll_long >= 853138 then
				tz = 4
			elseif ll_long <= 844000 then
				tz = 5
			elseif ls_city = "CHATTANOOGA" then
				tz = 5
			elseif ls_city = "CROSSVILLE" then
				tz = 4
			end if
		case "TX"
			if ls_city = "PINE SPRINGS" or ls_city = "NICKEL CREEK" then
				tz = 3
			elseif ll_long >= 1047475 then
				tz = 3
			else
				tz = 4
			end if
		case "BC"
			if ll_long >= 1191559 and ll_lat <= 542838 then
				tz = 2
			end if
		case "ON"
			if ll_long > 901147 then
				tz = 4
			elseif ll_long < 901147 then
				tz = 5
			end if
		case "SK"
			if ll_long <= 1085641 and ll_lat <= 533000 then
				tz = 4
			end if
		case "MX"
			if ll_long <= 1040730 then
				tz = 4
			elseif ls_city = "TIJUANA" then
				tz = 2 
			end if
	end choose
END IF

return tz

end function

public function string of_citylatlong (string as_locater);string	ls_buffer, &
			ls_latlong
long		ll_buflen=256

ls_buffer = space(ll_buflen)

if pcmscitytolatlong(ii_serverid , as_locater, ls_buffer, ll_buflen) > 0 then
	ls_latlong = ls_buffer
end if

return ls_latlong 
end function

public subroutine of_sethubmode (long al_trip, boolean ab_mode);if ab_mode then
	ib_hubmode=true
//	this.PCMSSetHubMode( al_trip, 1 )
else
	ib_hubmode=false
//	this.PCMSSetHubMode( al_trip, 0 )
end if
end subroutine

public function long of_calculate (long al_trip, integer ai_option, integer ai_type);long	ll_retval, &
		ll_setcost, &
		ll_option

ll_option = pcmsgetoptions(al_trip)
if isnull(ai_option) then
	//leave as default
else
	if pcmsgetoptions(al_trip) <> ai_option then
		pcmssetoptions(al_trip, ai_option)
	end if
end if

if isnull(ai_type) then
	//leave as default
else
	if pcmsgetcalctype(al_trip) <> ai_type then
		pcmssetcalctype(al_trip, ai_type)
	end if
end if

if isnull(ic_milecost) then
	//leave as default
else
	if ic_milecost > 0 then
		ll_setcost = long(ic_milecost * 100 )
		pcmssetcost(al_trip,ll_setcost)
	end if
end if

ll_retval = this.pcmscalculate(al_trip)

return ll_retval
end function

public function long of_gettripleginfo (long al_trip, long al_legnum, ref s_leginfo astr_leginfo);long	ll_retval
s_leginfo	lstr_leginfo

ll_retval = PCMSGetLegInfo(al_trip, al_legnum, lstr_leginfo)

astr_leginfo = lstr_leginfo

return ll_retval
end function

public function long of_getnumlegs (long al_trip);return PCMSNumlegs(al_trip)
end function

public function boolean of_optimize (n_cst_trip_attribs ads_data, long al_option, boolean ab_fixdestination);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Optimize
//
//	Access:  			public
//
//	Arguments:
//		ads_data					n_cst_trip_attribs trip data
//		al_option				long trip options
//		ab_FixDestination 	boolean if the destination should be fixed
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Make optimization of trip
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( ads_data ) or not IsValid( ads_data ) then
	il_err_code = -1008
	is_err_message = "Invalid trip data"
	return FALSE
end if

// Create trip
long ll_trip
ll_trip = of_CreateTrip( )
if ll_trip < 1 then
	this.of_GetLastSysError( il_err_code, is_err_message )
	return FALSE
end if

// Add all stops into trip
long ll_index, ll_count
ll_count = ads_data.RowCount( )
for ll_index = 1 to ll_count
	if of_AddStop( ll_trip, ads_data.GetItemString( ll_index, "stop" ) ) < 1 then 
		il_err_code = -1010
		is_err_message = "Cannot add stop into trip"
		return FALSE
	end if
	of_SetLoaded( ll_trip, ll_index, ( ads_data.GetItemNumber( ll_index, "loaded" ) = appeon_constant.STATE_LOADED ) )
next

// Prepare trip
if isnull(al_option) then
	//leave as default
else
	PCMSSetCalcType( ll_trip, al_option )
end if
//This functionality has not been verified, as to functionality and defaults.
//So, we're going to skip it for now.
//of_SetTripOptions( ll_trip, ads_data )

IF ab_FixDestination THEN
	 PCMSSetResequence ( ll_Trip , 0 )
ELSE
	 PCMSSetResequence ( ll_Trip , 1 )
END IF


// Make optimization
long ll_retval
ll_retval = PCMSOptimize( ll_trip )
if ll_retval < 0 then
	this.of_GetLastSysError( il_err_code, is_err_message )
	return FALSE
end if

// Clear target DS and fill it by new data
ads_data.Reset( )
long ll_row
string ls_stop
ll_count = PCMSNumStops( ll_trip )
for ll_index = 0 to ll_count - 1
	ll_row = ads_data.InsertRow( 0 )
	if ll_row < 1 then
		il_err_code = -1012
		is_err_message = "Cannot insert row"
		return FALSE
	end if
	ls_stop = Space( 256 )
	ll_retval = PCMSGetStop( ll_trip, ll_index, ls_stop, 256 )
	if ll_retval < 1 then
		il_err_code = -1013
		is_err_message = "Cannot get stop"
		return FALSE
	end if
	ads_data.SetItem( ll_row, "stop", ls_stop )
next
return TRUE
end function

public function boolean of_iscanadianpostalinstalled ();boolean	lb_installed
string	ls_locater

long		ll_trip, &
			ll_match
			
ll_trip = PCMSNewTrip(ii_serverid)


//lookup zip and check 
ls_locater="L5J 1K9"
ll_match = PCMSLookup(ll_trip, ls_locater, 1)
if ll_match > 0 then
	lb_installed=TRUE
end if
PCMSDeleteTrip(ll_trip)

return lb_installed


end function

public function boolean of_islatlondecimal (string as_value);
Boolean 	lb_Return 
String 	ls_MatchString
String	lsa_Result[]
n_cst_String	lnv_String

lnv_String.of_ParseToArray ( as_Value , "," , lsa_Result )

// if streets locator
// should be in the form of lsa_Result [ 1 ] = XXX.XXXXD // decimal lat/lon
//												   [ 2 ] = XXX.XXXXD // decimal lat/lon
//													[ 3 ] = SS 			 // state 

ls_MatchString = "^[0-9]?[0-9]?[0-9]?[0-9][.][0-9]*[NnWw]$"


IF UpperBound ( lsa_Result ) = 3 THEN
	
	IF match (lsa_Result [1], ls_MatchString ) THEN
		IF	match (lsa_Result [2], ls_MatchString ) THEN 
			IF match (Trim (lsa_Result [3] ), "^[A-Z][A-Z]$" ) THEN
				
				lb_Return = TRUE 
			END IF
		END IF
	END IF
	
END IF

RETURN lb_Return 
		
		
	
	


end function

public function string of_decimaltodms (string as_value);String   ls_Locator
String	ls_Deg
String	ls_Min
String 	ls_Sec
String	ls_Dir
Long		ll_Sec
Long		ll_Min
Long		ll_Deg
Long		ll_DMS
//The whole units of degrees will remain the same (i.e. in 121.135° longitude, start with 121°). 
//Multiply the decimal by 60 (i.e. .135 * 60 = 8.1).
//The whole number becomes the minutes (8').
//Take the remaining decimal and multiply by 60. (i.e. .1 * 60 = 6). 
//The resulting number becomes the seconds (6'). Seconds can remain as a decimal.
//Take your three sets of numbers and put them together, using the symbols for degrees (°), minutes (‘), and seconds (') (i.e. 121°8'6' longitude) 

Dec lc_Work 

ls_Locator =  TRIM ( as_value )

// strip off the direction 
ls_Dir = Right ( ls_Locator , 1 ) 
ls_Locator = Left ( ls_Locator , Len ( ls_Locator ) - 1 )

// get the degrees 
ls_Deg = Left ( ls_Locator , pos ( ls_Locator , "." ) - 1 )
ll_Deg = Long ( ls_Deg )

// remove the degrees 
ls_Locator = Right ( ls_Locator , Len ( ls_Locator ) - pos ( ls_Locator , "." ) + 1)

// use the remainder in decimal form
lc_Work = Dec ( ls_Locator )
// multiply it by 60
lc_Work = lc_Work * 60
// talke the whole number as the minutes
ll_Min = Integer ( Left ( String ( lc_Work ) , pos ( String ( lc_Work ) , "." ) - 1 ) )


ls_Sec = String ( lc_Work )
// use the remainder to calculate the seconds
lc_Work = Dec ( Right ( ls_Sec , Len ( ls_Sec ) - pos ( ls_Sec , "." )  + 1) )
ll_Sec = lc_Work * 60

ls_Locator = String ( ll_Deg, "000" ) + String ( ll_Min,"00" ) + String ( ll_Sec, "00" ) + ls_Dir

return ls_Locator 
end function

public subroutine of_setbordersopen (string as_value);choose case upper(as_value)
	case 'O'
		il_BordersOpen = 1
	case 'C'
		il_BordersOpen = 0
	case else
		setnull(il_bordersopen)
end choose
end subroutine

on n_cst_routing_pcmiler.create
call super::create
end on

on n_cst_routing_pcmiler.destroy
call super::destroy
end on

