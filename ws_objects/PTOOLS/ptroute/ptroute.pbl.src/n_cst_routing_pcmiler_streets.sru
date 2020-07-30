$PBExportHeader$n_cst_routing_pcmiler_streets.sru
forward
global type n_cst_routing_pcmiler_streets from n_cst_routing_pcmiler
end type
end forward

global type n_cst_routing_pcmiler_streets from n_cst_routing_pcmiler
end type
global n_cst_routing_pcmiler_streets n_cst_routing_pcmiler_streets

type prototypes

// Initialization functions
Function Integer PCMSOpenServer (Long appInst, Long hWnd) LIBRARY "PMWSSRV.DLL"
Function Integer PCMSCloseServer (Integer serverID) LIBRARY "PMWSSRV.DLL"

// Info functions
Function Long PCMSSetDebug (Long debugLevel) LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetDebug () LIBRARY "PMWSSRV.DLL"
Function Long PCMSIsValid (Integer serverID) LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetError () LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetErrorString (Long errorCode, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetErrorString;Ansi"
Function Long PCMSAbout (String topic, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSAbout;Ansi"

// Simple functions
Function Long PCMSCalcDistance (Integer serverID, String orig, String dest) LIBRARY "PMWSSRV.DLL" alias for "PCMSCalcDistance;Ansi"
Function Long PCMSCalcDistance2 (Integer serverID, String orig, String dest, Long routeType) LIBRARY "PMWSSRV.DLL" alias for "PCMSCalcDistance2;Ansi"
Function Long PCMSCalcDistance3 (Integer serverID, String orig, String dest, Long routeType, REF Long Longhours) LIBRARY "PMWSSRV.DLL" alias for "PCMSCalcDistance3;Ansi"
Function Long PCMSCheckPlaceName (Integer serverID, String cityZip) LIBRARY "PMWSSRV.DLL" alias for "PCMSCheckPlaceName;Ansi"

// Trip management
Function Long PCMSNewTrip (Integer serverID) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSDeleteTrip (Long tripID) LIBRARY "PMWSSRV.DLL"

// Trip options, stops, etc.
Function Long PCMSCalcTrip (Long tripID, String orig, String dest) LIBRARY "PMWSSRV.DLL" alias for "PCMSCalcTrip;Ansi"
Function Long PCMSCalculate (Long tripID) LIBRARY "PMWSSRV.DLL"
Function Long PCMSOptimize (Long tripID) LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetDuration (Long tripID) LIBRARY "PMWSSRV.DLL"
Function Long PCMSAddStop (Long tripID, String stopName) LIBRARY "PMWSSRV.DLL" alias for "PCMSAddStop;Ansi"
Function Long PCMSGetStop (Long tripID, Long which, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetStop;Ansi"
Function Long PCMSNumStops (Long tripID) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSClearStops (Long tripID) LIBRARY "PMWSSRV.DLL"

// Lookup Functions
Function Long PCMSLookup (Long tripID, String cityZip, long easy) LIBRARY "PMWSSRV.DLL" alias for "PCMSLookup;Ansi"
Function Long PCMSGetMatch (Long tripID, Long index, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetMatch;Ansi"
Function Long PCMSNumMatches (Long tripID) LIBRARY "PMWSSRV.DLL"
Function Long PCMSCityToLatLong (Integer serverID, String City, REF String buffer, Long buflen) LIBRARY "PMWSSRV.DLL" alias for "PCMSCityToLatLong;Ansi"
Function Long PCMSLatLongToCity (Integer serverID, String LatLong, REF String buffer, Long buflen) LIBRARY "PMWSSRV.DLL" alias for "PCMSLatLongToCity;Ansi"
Function Long PCMSAddressToLatLong (Integer serverID, String Address, REF String buffer, Long buflen) LIBRARY "PMWSSRV.DLL" alias for "PCMSAddressToLatLong;Ansi"
Function Long PCMSLatLongToAddress (Integer serverID, String LatLong, REF String buffer, Long buflen) LIBRARY "PMWSSRV.DLL" alias for "PCMSLatLongToAddress;Ansi"

Function Long PCMSGetFmtMatch(Long trip, long which, &
	REF String buffer, Long bufSize, long zipLen, long cityLen,&
	 long countyLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetFmtMatch;Ansi"
Function Long PCMSGetFmtMatch2(Long trip, long which, REF string addrBuf,&
		 long addrLen, REF string cityBuf, long cityLen, &
		REF string stateBuf, long stateLen, REF string zipBuf, long zipLen, &
		REF string countyBuf, long countyLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetFmtMatch2;Ansi"
// Report functions
Function Long PCMSGetRpt (Long tripID, Long rptNum, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetRpt;Ansi"
Function Long PCMSNumRptBytes (Long tripID, Long rptNum) LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetRptLine (Long tripID, Long rptNum, Long lineNum, REF String buffer, Long bufLen) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetRptLine;Ansi"
Function Long PCMSNumRptLines (Long tripID, Long rptNum) LIBRARY "PMWSSRV.DLL"

// Trip options
SUBROUTINE PCMSSetCalcType (Long tripID, Long routeType) LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetCalcType (Long tripID) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetBordersOpen (Long tripID, Long isOpen) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetKilometers (Long tripID) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetMiles (Long tripID) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetHubMode (Long tripID, Long onOff) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetResequence (Long tripID, Long changeDest) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetAlphaOrder (Long tripID, Long alphaOrder) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetOptions (Long tripID, Long options) LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetCost (Long tripID) LIBRARY "PMWSSRV.DLL"
Function Long PCMSGetOptions (Long tripID) LIBRARY "PMWSSRV.DLL"
Function Long PCMSNumLegs (Long tripID) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSDefaults (Long tripID) LIBRARY "PMWSSRV.DLL"
SUBROUTINE PCMSSetVehicleType (Long tripID, Long onOff) LIBRARY "PMWSSRV.DLL"
subroutine PCMSSetCost( long trip, long cost ) LIBRARY "PMWSSRV.DLL"
subroutine PCMSSetUseShapePts( long trip, long onOff ) LIBRARY "PMWSSRV.DLL"
subroutine PCMSConvertLLToPlace( long trip, long yesNo ) LIBRARY "PMWSSRV.DLL"
subroutine PCMSSetBreakHours( long trip, long hours ) LIBRARY "PMWSSRV.DLL"
subroutine PCMSSetBreakWaitHours( long trip, long hours ) LIBRARY "PMWSSRV.DLL"
subroutine PCMSSetCustomMode( long trip, long onOff ) LIBRARY "PMWSSRV.DLL"
function long PCMSGetLocAtMiles( long trip, long miles, ref string pLocation, long size ) &
	LIBRARY "PMWSSRV.DLL" alias for "PCMSGetLocAtMiles;Ansi"
function long PCMSGetLocAtMinutes( long trip, long minutes, ref string pLocation, long size ) &
	LIBRARY "PMWSSRV.DLL" alias for "PCMSGetLocAtMinutes;Ansi"
function long PCMSGetLegInfo( long trip, long legnum, ref s_leginfo leginfotype ) LIBRARY "PMWSSRV.DLL" alias for "PCMSGetLegInfo;Ansi"

// Utility functions
Function Long PCMSStrLen (REF String buffer) LIBRARY "PMWSSRV.DLL" alias for "PCMSStrLen;Ansi"


end prototypes

type variables
private:
n_cst_mapping_streets	inv_mapping_streets
end variables

forward prototypes
public subroutine of_test (string as_address)
public function boolean of_isstreets ()
public function string of_getmatches (long al_trip)
public function string of_getstreetaddress (string as_location)
public function string of_getcity (string as_location)
public function string of_getstate (string as_location)
public function string of_addresstolatlong (string as_address)
public function string of_getpartoflocater (string as_locater, string as_whichpart, boolean ab_pcmilerlocater)
public function string of_getzipcode (string as_location)
public function string of_latlongtoaddress (string as_latlong)
public subroutine of_cleanup ()
public function boolean of_validplacename (string as_place)
public function integer of_calculate (string as_origin, string as_destination, ref decimal ac_distance, ref long al_minutes, long al_option)
public function string of_makelocator (string as_city, string as_state, string as_zip, string as_street)
public function string of_stripcounty (string as_locator)
public function integer of_timezonesearch (string as_locator)
public function string of_makelocator (string as_city, string as_state, string as_zip)
public function boolean of_iscanadianpostalinstalled ()
public function integer of_locationcheck (string as_checklocation, ref string as_foundlocation, boolean ab_exactmatch)
public function boolean of_isoldpcmilerversion ()
end prototypes

public subroutine of_test (string as_address);Integer	li_pcms
long		ll_buffer = 256, &
			ll_ndx, &
			ll_matches, &
			ll_trip, &
			ll_lookup=0
string	ls_buffer, &
			ls_version, &
			ls_address = "LYMAN, ME; 1 CLARKSWOODS RD", &
			ls_match

ls_buffer=space(ll_buffer)

//ll_trip = this.PCMSNewTrip( li_pcms )
//ll_matches = this.PCMSLookup(ll_trip, ls_address, ll_lookup)
//ll_matches = this.PCMSNumMatches (ll_trip)
//for ll_ndx = 0 to (ll_matches - 1)
//	ls_match = ""
//	ls_match = space(256)
//	this.pcmsgetmatch(ll_trip, ll_ndx, ls_match, 256)
//next


end subroutine

public function boolean of_isstreets ();return TRUE
end function

public function string of_getmatches (long al_trip);// Get all matches

long	ll_index, &
		ll_count
string	ls_buffer, &
			ls_address, &
			ls_city, &
			ls_State, &
			ls_County, &
			ls_zip, &
			ls_matches

ll_count = PCMSNumMatches( al_trip )

for ll_index = 0 to ll_count - 1
	ls_buffer = Space(256)
	ls_address = space(100)
	ls_city = space(50)
	ls_State = space(50)
	ls_zip = space(5)
	ls_County = space(1)
	//eliminate county
	this.PCMSGetFmtMatch2(al_trip, ll_index, ls_address,&
		 100, ls_city, 50, ls_State, 50, ls_zip, 5, ls_County, 0)
	ls_buffer = ls_zip + ' ' + ls_city + ', ' + ls_state + '; ' + ls_address
	if Len( ls_buffer ) > 0 then ls_matches += ls_buffer + "~n"
next

return Left( ls_matches, Len( ls_matches ) - 1 )


end function

public function string of_getstreetaddress (string as_location);/*
	Return a street address for a location.  It is assumed that the 
	location is valid so an exact find will be done. This method is
	using Streets to parse out the street rather than trying to do
	it through some other parsing routine.

*/
string	ls_address, &
			ls_city, &
			ls_State, &
			ls_County, &
			ls_zip, &
			ls_matches

integer	li_return=1
long ll_count

// Create "phantom" trip
long ll_trip
ll_trip = of_CreateTrip( )
if ll_trip < 1 then 
	of_GetLastSysError( il_err_code, is_err_message )
	li_return = -1
end if


if li_return = 1 then
	// Get count of matches
	ll_count = PCMSLookup( ll_trip, as_location, 1 )
	if ll_count = 0 then
		li_return = -1
	end if
end if


if li_return = 1 then
	// Get all matches

	ll_count = PCMSNumMatches( ll_trip )
	//expecting only 1

	ls_address = space(100)
	ls_city = space(50)
	ls_State = space(50)
	ls_zip = space(5)
	ls_County = space(100)

	this.PCMSGetFmtMatch2(ll_trip, 0, ls_address, 100, ls_city, 0, ls_State, 0, ls_zip, 0, ls_County, 0)
		 
	if Len( ls_address ) > 0 then 
		ls_matches = ls_address
	else
		ls_matches = ''
	end if
	
end if

// Delete "phantom" trip
of_DeleteTrip( ll_trip )

return upper(ls_matches)
end function

public function string of_getcity (string as_location);/*
	Return a city for a location.  It is assumed that the 
	location is valid so an exact find will be done. This method is
	using Streets to parse out the street rather than trying to do
	it through some other parsing routine.

*/
string	ls_address, &
			ls_city, &
			ls_State, &
			ls_County, &
			ls_zip, &
			ls_matches, &
			ls_location			

integer	li_return=1

long	ll_count, &
		ll_pos

ll_Pos = pos(as_location, ';')
if ll_pos > 0 then
	ls_location = left ( as_location, ll_Pos - 1 )
else
	ls_location = as_location	
end if

// Create "phantom" trip
long ll_trip
ll_trip = of_CreateTrip( )
if ll_trip < 1 then 
	of_GetLastSysError( il_err_code, is_err_message )
	li_return = -1
end if


if li_return = 1 then
	// Get count of matches
	ll_count = PCMSLookup( ll_trip, ls_location, 1 )
	
	//***there could a problem here when converting latlong to address 
	//the returned address is not found on exact try alfred, me
	if ll_count = 0 then
		li_return = -1
	end if
end if


if li_return = 1 then
	// Get all matches

	ll_count = PCMSNumMatches( ll_trip )
	//expecting only 1

	ls_address = space(100)
	ls_city = space(50)
	ls_State = space(50)
	ls_zip = space(5)
	ls_County = space(100)

	this.PCMSGetFmtMatch2(ll_trip, 0, ls_address, 0, ls_city, 50, ls_State, 0, ls_zip, 0, ls_County, 0)
		 
	if Len( ls_city ) > 0 then 
		ls_matches = ls_city
	end if
	
end if

// Delete "phantom" trip
of_DeleteTrip( ll_trip )

return upper(ls_matches)
end function

public function string of_getstate (string as_location);/*
	Return a state for a location.  It is assumed that the 
	location is valid so an exact find will be done. This method is
	using Streets to parse out the street rather than trying to do
	it through some other parsing routine.

*/
string	ls_address, &
			ls_city, &
			ls_State, &
			ls_County, &
			ls_zip, &
			ls_matches, &
			ls_location
			
integer	li_return=1
long	ll_count, &
		ll_pos

ll_Pos = pos(as_location, ';')
if ll_pos > 0 then
	ls_location = left ( as_location, ll_Pos - 1 )
else
	ls_location = as_location	
end if

// Create "phantom" trip
long ll_trip
ll_trip = of_CreateTrip( )
if ll_trip < 1 then 
	of_GetLastSysError( il_err_code, is_err_message )
	li_return = -1
end if


if li_return = 1 then
	// Get count of matches
	ll_count = PCMSLookup( ll_trip, ls_location, 1 )
	if ll_count = 0 then
		li_return = -1
	end if
end if


if li_return = 1 then
	// Get all matches

	ll_count = PCMSNumMatches( ll_trip )
	//expecting only 1

	ls_address = space(100)
	ls_city = space(50)
	ls_State = space(50)
	ls_zip = space(5)
	ls_County = space(100)

	this.PCMSGetFmtMatch2(ll_trip, 0, ls_address, 0, ls_city, 0, ls_State, 50, ls_zip, 0, ls_County, 0)
		 
	if Len( ls_state ) > 0 then 
		ls_matches = ls_state
	end if
	
end if

// Delete "phantom" trip
of_DeleteTrip( ll_trip )

return upper(ls_matches)
end function

public function string of_addresstolatlong (string as_address);long		ll_buflen = 256, &
			ll_Pos
string	ls_buffer

ls_buffer=space(ll_buflen)

//if the locater has a ';' then if there is no street after it,
//trim it off

ll_Pos = pos(as_address, ';')
if ll_pos > 0 then
	if len (trim ( right ( as_address, len ( as_address ) - ll_pos ) ) ) = 0  then
		as_address = left ( as_address, ll_Pos - 1 )
	end if
end if


if this.PCMSAddressToLatLong (ii_serverid, as_address, ls_buffer, ll_buflen) < 0 then
	ls_buffer = ''
end if

return ls_buffer

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

//if the locater has a ';' then if there is no street after it,
//trim it off

ll_Pos = pos(as_locater, ';')
if ll_pos > 0 then
	if len (trim ( right ( as_locater, len ( as_locater ) - ll_pos ) ) ) = 0  then
		as_locater = left ( as_locater, ll_Pos - 1 )
	end if
end if

if ab_pcmilerlocater then
	
	choose case upper ( as_whichpart )
	
	case this.cs_Locater_ZipCode
		ls_return=this.of_getzipcode(as_locater)
		
	case this.cs_Locater_City
		ls_return=this.of_getcity(as_locater)
	
	case this.cs_Locater_State
		ls_return=this.of_getstate(as_locater)
	//		//	first strip of zip if there is one
	//		if isnumber ( left ( as_locater, 1 ) ) then
	//			as_locater = right ( as_locater, len ( as_locater ) - 6 )
	//		end if
	//		
	//		ll_pos = pos ( as_locater,"," )
	//	
	//		if ll_pos > 0 then
	//			ls_return = trim ( right ( as_locater, len(as_locater) - ll_pos ) )
	//		else 
	//			//bad locater
	//			ls_return = ''
	//		end if
	
	case this.cs_Locater_Street
//		ls_return=this.of_getstreetaddress(as_locater)
		ll_Pos = pos(as_locater, ';')
		if ll_pos > 0 then
			ls_return = trim ( right ( as_locater, len(as_locater) - ll_Pos ) )
		end if
			
	case else
		ls_Return = " "
		
	end choose
else
		ll_Pos = pos(as_locater, ';')
		if ll_pos > 0 then
			ls_locater = trim ( left ( as_locater, ll_Pos - 1 ) )
		else
			ls_locater = as_locater
		end if
	ls_return = Super::function of_getpartoflocater(ls_locater, as_whichpart, ab_pcmilerlocater )
end if

return upper(ls_return)

end function

public function string of_getzipcode (string as_location);/*
	Return a ZIP for a location.  It is assumed that the 
	location is valid so an exact find will be done. This method is
	using Streets to parse out the ADDRESS rather than trying to do
	it through some other parsing routine.

*/
string	ls_address, &
			ls_city, &
			ls_State, &
			ls_County, &
			ls_zip, &
			ls_matches, &
			ls_location

integer	li_return=1
long	 ll_count, &
		 ll_pos

////if the locater has a ';' then trim it and street off ,
////a zip can't be found for a specific street 
//
ll_Pos = pos(as_location, ';')
if ll_pos > 0 then
	ls_location = left ( as_location, ll_Pos - 1 )
else
	ls_location = as_location	
end if


// Create "phantom" trip
long ll_trip
ll_trip = of_CreateTrip( )
if ll_trip < 1 then 
	of_GetLastSysError( il_err_code, is_err_message )
	li_return = -1
end if


if li_return = 1 then
	// Get count of matches
	ll_count = PCMSLookup( ll_trip, ls_location, 1 )
	if ll_count = 0 then
		li_return = -1
	end if
end if


if li_return = 1 then
	// Get all matches

	ll_count = PCMSNumMatches( ll_trip )
	//expecting only 1

	ls_address = space(100)
	ls_city = space(50)
	ls_State = space(50)
	ls_zip = space(5)
	ls_County = space(100)

	this.PCMSGetFmtMatch2(ll_trip, 0, ls_address, 0, ls_city, 0, ls_State, 0, ls_zip, 5, ls_County, 0)
		 
	if Len( ls_zip ) > 0 then 
		ls_matches = ls_zip
	end if
	
end if

// Delete "phantom" trip
of_DeleteTrip( ll_trip )

return ls_matches
end function

public function string of_latlongtoaddress (string as_latlong);Integer	li_pcms
long		ll_buflen = 256, &
			ll_return
string	ls_buffer, &
			ls_version

ls_buffer=space(ll_buflen)
ll_Return = this.PCMSLatLongToAddress (ii_serverid, as_latlong, ls_buffer, ll_buflen)

ls_version = this.of_about("ProductVersion")
choose case ls_version
	case "4.0", "1.0"
		//no miles to trim in return value
	case else
		//trim miles off
		ls_buffer = right(ls_buffer,len(ls_buffer) - 4)
end choose

return ls_buffer


end function

public subroutine of_cleanup ();inv_mapping_streets = create n_cst_mapping_streets
inv_mapping_streets.of_cleanup ()
destroy inv_mapping_streets
end subroutine

public function boolean of_validplacename (string as_place);long	ll_pos

boolean	lb_valid

//if the locater has a ';' then if there is no street after it,
//trim it off

ll_Pos = pos(as_place, ';')
if ll_pos > 0 then
	if len (trim ( right ( as_place, len ( as_place ) - ll_pos ) ) ) = 0  then
		as_place = left ( as_place, ll_Pos - 1 )
	end if
end if

if pcmscheckplacename(ii_serverid, as_place) > 0 then
	lb_valid=true
end if

return  lb_valid

end function

public function integer of_calculate (string as_origin, string as_destination, ref decimal ac_distance, ref long al_minutes, long al_option);//override to check locater for semicolon and then call ancestor.
//
//If the locater has a semicolon and no street after it then
//it needs to be stripped off because ALK can't be bothered to 
//accept something they gave to me in the first place.
long		ll_pos	
string	ls_origin, &
			ls_destination

			//origin
ll_Pos = pos(as_origin, ';')
if ll_pos > 0 then
	if len (trim ( right ( as_origin, len ( as_origin ) - ll_pos ) ) ) = 0  then
		ls_origin = left ( as_origin, ll_Pos - 1 )
	end if
end if
if len(ls_origin) = 0 then
	ls_origin = as_origin
end if

		//destination
ll_Pos = pos(as_destination, ';')
if ll_pos > 0 then
	if len (trim ( right ( as_destination, len ( as_destination ) - ll_pos ) ) ) = 0  then
		ls_destination = left ( as_destination, ll_Pos - 1 )
	end if
end if
if len(ls_destination) = 0 then
	ls_destination = as_destination
end if

return Super::function of_calculate(ls_origin, ls_destination, ac_distance, al_minutes, al_option )		

end function

public function string of_makelocator (string as_city, string as_state, string as_zip, string as_street);/*
	If a street address is included then check it with city, state no zip
	I'm assuming that there is a better chance of the street being correct
	for the city/state combo than the zip/street combo.  In PCMiler Streets
	you check zip or city/state but not both.
	
	If a valid locator is found then it will be converted to latlong.
	If it is not valid then return an empty string
	
*/
string	ls_locator, &
			ls_return, &
			ls_foundlocator

long	ll_pos			
	
if isnull(as_street) or len(trim(as_street)) = 0 then
	//if there is no street then this is treated the same as a wrong street
	//no locator
	ls_return = ''
else
//	ls_return = Super::function of_makelocator(as_city, as_state, ''/*no zip*/ )
//	if len(ls_return) > 0 then		
		ls_return = trim(as_city) + ", " + trim(as_state)
		//add street and try with that, else no locator
		ls_return += '; ' + trim(as_street)
		if this.of_locationcheck(ls_return, ls_foundlocator, true ) > 0 then
		//convert to latlong
			ls_foundlocator = this.of_addresstolatlong(ls_return)
			if len(trim(ls_foundlocator)) = 0 then
				ls_return = ''
			else
				ls_return = ls_foundlocator
			end if
		else
			ls_return = ''
		end if

//	end if
end if

return ls_return

end function

public function string of_stripcounty (string as_locator);string ls_locater
long	ll_Pos

ls_locater =  Super::function of_stripcounty(as_locator )

ll_Pos = pos(ls_locater, ';')
if ll_pos > 0 then
	ls_locater = left ( ls_locater, ll_Pos - 1 )
end if

return ls_locater


end function

public function integer of_timezonesearch (string as_locator);//if in latlong format change to address for to get state


return Super::function of_timezonesearch(as_locator )

end function

public function string of_makelocator (string as_city, string as_state, string as_zip);string	ls_locator, &
			ls_return, &
			ls_foundlocator

long	ll_pos			
	
ls_return = Super::function of_makelocator(as_city, as_state, as_zip )

if len(ls_return) > 0 then			
	//convert to latlong
	ls_foundlocator = this.of_addresstolatlong(ls_return)
	if len(trim(ls_foundlocator)) = 0 then
		ls_return = ''
	else
		ls_return = ls_foundlocator
	end if
else
	ls_return = ''
end if

return ls_return

end function

public function boolean of_iscanadianpostalinstalled ();return Super::function of_iscanadianpostalinstalled ( )
end function

public function integer of_locationcheck (string as_checklocation, ref string as_foundlocation, boolean ab_exactmatch);integer	li_return
long		ll_pos

li_return = Super::function of_locationcheck(as_checklocation, as_foundlocation, ab_exactmatch )

//if the locater has a ';' then if there is no street after it,
//trim it off

ll_Pos = pos(as_foundlocation, ';')
if ll_pos > 0 then
	if len (trim ( right ( as_foundlocation, len ( as_foundlocation ) - ll_pos ) ) ) = 0  then
		as_foundlocation = left ( as_foundlocation, ll_Pos - 1 )
	end if
end if

return li_return
end function

public function boolean of_isoldpcmilerversion ();return false
end function

on n_cst_routing_pcmiler_streets.create
TriggerEvent( this, "constructor" )
end on

on n_cst_routing_pcmiler_streets.destroy
TriggerEvent( this, "destructor" )
end on

