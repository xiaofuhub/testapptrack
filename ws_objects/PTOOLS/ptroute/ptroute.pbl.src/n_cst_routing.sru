$PBExportHeader$n_cst_routing.sru
forward
global type n_cst_routing from nonvisualobject
end type
end forward

shared variables

end variables

global type n_cst_routing from nonvisualobject
end type
global n_cst_routing n_cst_routing

type variables
CONSTANT String 	cs_Locater_State = "STATE"
CONSTANT String	cs_Locater_Zipcode = "ZIPCODE"
CONSTANT String 	cs_Locater_City = "CITY"
CONSTANT String 	cs_Locater_County = "COUNTY"
CONSTANT String 	cs_Locater_Street = "STREET"

// Reference to external cache
private n_cst_routing_cache inv_cache

// Requester data
private powerobject ipo_requester
private string is_requester_event_name

// Errors data
public long il_err_code
public string is_err_message
end variables

forward prototypes
public subroutine of_setrequester (powerobject apo_object, string as_event)
public function long of_setdebug (long al_level)
public function long of_getdebug ()
public function string of_about (string as_which)
public function boolean of_getlasterror (ref long al_code, ref string as_message)
public function boolean of_getlasterror (ref long al_code)
public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance)
public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes)
public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes, long al_option)
public function boolean of_warning ()
public function long of_getreport (long al_num, n_cst_trip_attribs ads_data, ref string as_data, long al_option)
public subroutine of_cacheconnect (n_cst_routing_cache anv_cache)
public subroutine of_cachedisconnect ()
public function n_cst_routing_cache of_getcache ()
public subroutine of_setcache (n_cst_routing_cache anv_cache)
public function boolean of_findincache (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes, long al_option)
public subroutine of_addintocache (string as_origin, string as_destination, decimal ad_distance, long al_minutes, long al_option)
public function boolean of_isvalid ()
public function string of_lookup (string as_place, long al_easy)
public function boolean of_destroy ()
public function boolean of_create (ref integer ai_serverid)
public function boolean of_validplacename (string as_place)
public function boolean of_isoldpcmilerversion ()
public function boolean of_isstreets ()
public function string of_getstreetaddress (string as_location)
public function boolean of_validatestateabreviation (string as_state)
public function string of_addresstolatlong (string as_address)
public function string of_getpartoflocater (string as_locater, string as_whichpart, boolean ab_pcmilerlocater)
public function string of_stripcounty (string as_locater)
public function integer of_locationcheck (string as_checklocation, ref string as_foundlocation, boolean as_exactmatch)
public function long of_createtrip ()
public function long of_gettripduration (long al_trip)
public function long of_gettripstops (long al_trip)
public subroutine of_deletetrip (long al_trip)
public function string of_latlongtoaddress (string as_address)
public function integer of_addstop (long al_trip, string as_stop)
public subroutine of_cleanupmap ()
public subroutine of_clearstops (long al_trip)
public function string of_latlongtocity (string as_latlong)
public function boolean of_disconnect ()
public function decimal of_calculatetrip (string as_origin, string as_destination, long al_trip, integer ai_options, integer ai_type, ref decimal ac_distance, ref long al_minutes, ref decimal ac_cost)
public function decimal of_getmilecost ()
public subroutine of_setmilecost (decimal ac_milecost)
public function string of_makelocator (string as_city, string as_state, string as_zip)
public function string of_makelocator (string as_city, string as_state, string as_zip, string as_street)
public function integer of_timezonesearch (string as_locator)
public function integer of_citytolaytlong (string as_locater)
public subroutine of_sethubmode (long al_trip, boolean ab_mode)
public function long of_calculate (long al_trip, integer ai_option, integer ai_type)
public function long of_getnumlegs (long al_trip)
public function long of_gettripleginfo (long al_trip, long al_leg, ref s_leginfo astr_leginfo)
public function boolean of_optimize (n_cst_trip_attribs ads_data, long al_option, boolean ab_FixDestination)
public function boolean of_iscanadianpostalinstalled ()
public function boolean of_islatlondecimal (string as_Value)
public function string of_decimaltodms (string as_Value)
public subroutine of_setbordersopen (string as_value)
end prototypes

public subroutine of_setrequester (powerobject apo_object, string as_event);ipo_requester = apo_object
is_requester_event_name = as_event
end subroutine

public function long of_setdebug (long al_level);this.of_Warning( )
return 0
end function

public function long of_getdebug ();this.of_Warning( )
return 0
end function

public function string of_about (string as_which);this.of_warning( )
return ""
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

public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance);this.of_warning( )
return -1
end function

public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes);this.of_warning( )
return -1
end function

public function integer of_calculate (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes, long al_option);this.of_warning( )
return -1
end function

public function boolean of_warning ();MessageBox( this.ClassName( ), "Feature not supported", StopSign! )
return FALSE
end function

public function long of_getreport (long al_num, n_cst_trip_attribs ads_data, ref string as_data, long al_option);of_warning( )
return 0

end function

public subroutine of_cacheconnect (n_cst_routing_cache anv_cache);inv_cache = anv_cache
end subroutine

public subroutine of_cachedisconnect ();n_cst_routing_cache lnv_cache
inv_cache = lnv_cache
end subroutine

public function n_cst_routing_cache of_getcache ();return inv_cache
end function

public subroutine of_setcache (n_cst_routing_cache anv_cache);inv_cache = anv_cache
end subroutine

public function boolean of_findincache (string as_origin, string as_destination, ref decimal ad_distance, ref long al_minutes, long al_option);if IsValid( this.of_GetCache( ) ) then
	return this.of_GetCache( ).of_Find( as_origin, as_destination, ad_distance, al_minutes, al_option )
else
	return FALSE
end if
end function

public subroutine of_addintocache (string as_origin, string as_destination, decimal ad_distance, long al_minutes, long al_option);// Update cache object if it's valid
if IsValid( this.of_GetCache( ) ) then 
	this.of_GetCache( ).of_Add( as_origin, as_destination, ad_distance, al_minutes, al_option )
end if

end subroutine

public function boolean of_isvalid ();return this.of_Warning( )
end function

public function string of_lookup (string as_place, long al_easy);this.of_warning( )
return ""
end function

public function boolean of_destroy ();return this.of_Warning( )
end function

public function boolean of_create (ref integer ai_serverid);return this.of_Warning( )
end function

public function boolean of_validplacename (string as_place);return this.of_Warning( )
end function

public function boolean of_isoldpcmilerversion ();return this.of_Warning( )
end function

public function boolean of_isstreets ();return this.of_Warning( )
end function

public function string of_getstreetaddress (string as_location);this.of_warning( )
return ""
end function

public function boolean of_validatestateabreviation (string as_state);return this.of_Warning( )
end function

public function string of_addresstolatlong (string as_address);this.of_warning( )
return ""
end function

public function string of_getpartoflocater (string as_locater, string as_whichpart, boolean ab_pcmilerlocater);this.of_warning( )
return ""
end function

public function string of_stripcounty (string as_locater);this.of_warning( )
return ""
end function

public function integer of_locationcheck (string as_checklocation, ref string as_foundlocation, boolean as_exactmatch);this.of_warning( )
return -1
end function

public function long of_createtrip ();this.of_warning( )
return -1
end function

public function long of_gettripduration (long al_trip);this.of_warning( )
return -1
end function

public function long of_gettripstops (long al_trip);this.of_warning( )
return -1
end function

public subroutine of_deletetrip (long al_trip);this.of_Warning( )
end subroutine

public function string of_latlongtoaddress (string as_address);this.of_warning( )
return ""
end function

public function integer of_addstop (long al_trip, string as_stop);this.of_warning( )
return -1
end function

public subroutine of_cleanupmap ();this.of_warning()
end subroutine

public subroutine of_clearstops (long al_trip);this.of_warning()
end subroutine

public function string of_latlongtocity (string as_latlong);this.of_warning( )
return ""
end function

public function boolean of_disconnect ();return this.of_warning()

end function

public function decimal of_calculatetrip (string as_origin, string as_destination, long al_trip, integer ai_options, integer ai_type, ref decimal ac_distance, ref long al_minutes, ref decimal ac_cost);this.of_warning( )
return -1
end function

public function decimal of_getmilecost ();this.of_Warning( )
return 0
end function

public subroutine of_setmilecost (decimal ac_milecost);this.of_Warning( )

end subroutine

public function string of_makelocator (string as_city, string as_state, string as_zip);this.of_warning()
return ''
end function

public function string of_makelocator (string as_city, string as_state, string as_zip, string as_street);this.of_warning()
return ''
end function

public function integer of_timezonesearch (string as_locator);this.of_warning()
return -1
end function

public function integer of_citytolaytlong (string as_locater);this.of_warning()
return -1
end function

public subroutine of_sethubmode (long al_trip, boolean ab_mode);this.of_warning()
end subroutine

public function long of_calculate (long al_trip, integer ai_option, integer ai_type);this.of_warning()
return -1
end function

public function long of_getnumlegs (long al_trip);this.of_warning()
return -1
end function

public function long of_gettripleginfo (long al_trip, long al_leg, ref s_leginfo astr_leginfo);this.of_warning()
return -1

end function

public function boolean of_optimize (n_cst_trip_attribs ads_data, long al_option, boolean ab_FixDestination);// implemented by descendant
return THIS.of_Warning ( )
end function

public function boolean of_iscanadianpostalinstalled ();return this.of_Warning( )
end function

public function boolean of_islatlondecimal (string as_Value);RETURN false
end function

public function string of_decimaltodms (string as_Value);return ""
end function

public subroutine of_setbordersopen (string as_value);this.of_warning()
end subroutine

on n_cst_routing.create
TriggerEvent( this, "constructor" )
end on

on n_cst_routing.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;this.of_Destroy( )
end event

