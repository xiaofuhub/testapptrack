$PBExportHeader$n_cst_routing_cache.sru
forward
global type n_cst_routing_cache from nonvisualobject
end type
end forward

global type n_cst_routing_cache from nonvisualobject
end type
global n_cst_routing_cache n_cst_routing_cache

type variables
private n_cst_routing_cache_attribs ids_data
private long il_maxrows = 32768
private long il_checkperiod = 100
private long il_inserts = 0
public long il_err_code = 0
public string is_err_message
end variables

forward prototypes
public function boolean of_load (string as_filename)
public function boolean of_getlasterror (ref long al_code, ref string as_message)
public function boolean of_getlasterror (ref long al_code)
public function boolean of_save (string as_filename)
public subroutine of_clearall ()
public function boolean of_add (string as_from, string as_to, decimal ad_distance, long al_minutes, integer ai_option)
private subroutine of_trim ()
public function boolean of_setmaxrows (long al_max)
public function boolean of_setchecktime (long al_max)
public function boolean of_find (string as_from, string as_to, ref decimal ad_distance, ref long al_minutes, integer ai_option)
end prototypes

public function boolean of_load (string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Load
//
//	Access:  			public
//
//	Arguments:
//		as_filename		An FileName with cache saved data
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Load data into cache structure
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( as_filename ) or Len( as_filename ) < 1 or not FileExists( as_filename ) then
	il_err_code = -1001
	is_err_message = "Invalid file name"
	return FALSE
end if

// Clear datastore and load saved data
ids_data.Reset( )
return ( ids_data.ImportFile( as_filename ) > 0 )

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

public function boolean of_save (string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Save
//
//	Access:  			public
//
//	Arguments:
//		as_filename		An FileName 
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Save data into file
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( as_filename ) or Len( as_filename ) < 1 then
	il_err_code = -1001
	is_err_message = "Invalid file name"
	return FALSE
end if

// Save data into the file
return ( ids_data.SaveAs( as_filename, Text!, FALSE ) = 1 )

end function

public subroutine of_clearall ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_ClearAll
//
//	Access:  			public
//
//	Arguments:			None
//
//
//	Returns:  			None
//	
//
//	Description:		Clear all cache data
//
//
//////////////////////////////////////////////////////////////////////////////

ids_data.Reset( )
end subroutine

public function boolean of_add (string as_from, string as_to, decimal ad_distance, long al_minutes, integer ai_option);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Add
//
//	Access:  			public
//
//	Arguments:
//		as_from			string origin
//		as_to				string destination
//		ad_distance		decimal distance
//		al_minute		long minutes
//		ai_option		integer calculation option
//
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Add new member into cache
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( as_from ) or Len( as_from ) < 1 then
	il_err_code = -1002
	is_err_message = "Invalid stop name"
	return FALSE
end if
if IsNull( as_to ) or Len( as_to ) < 1 then
	il_err_code = -1002
	is_err_message = "Invalid stop name"
	return FALSE
end if
if IsNull( ad_distance ) or ad_distance <= 0 then
	il_err_code = -1003
	is_err_message = "Invalid distance value"
	return FALSE
end if
if IsNull( al_minutes ) then
	il_err_code = -1004
	is_err_message = "Invalid minutes value"
	return FALSE
end if
if IsNull( ai_option ) then
	il_err_code = -1005
	is_err_message = "Invalid option value"
	return FALSE
end if

// Prepare origin and destination values
string ls_origin, ls_destination
if as_from > as_to then
	ls_origin = as_from
	ls_destination = as_to
else
	ls_origin = as_to
	ls_destination = as_from
end if

// Make insertion
long ll_row
ll_row = ids_data.InsertRow( 0 )
if ll_row < 1 then return FALSE
ids_data.SetItem( ll_row, "point_from", ls_origin )
ids_data.SetItem( ll_row, "point_to", ls_destination )
ids_data.SetItem( ll_row, "distance", ad_distance )
ids_data.SetItem( ll_row, "minutes", al_minutes )
ids_data.SetItem( ll_row, "option", string( ai_option ) )
ids_data.SetItem( ll_row, "request", DateTime( Today( ), Now( ) ) )
il_inserts ++

// If total count of inserts exeed check level
if il_inserts > il_checkperiod then
	il_inserts = 0
	// Check and trim datastore
	of_Trim( )
end if

return TRUE
end function

private subroutine of_trim ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Trip
//
//	Access:  			private
//
//	Arguments:			None
//
//
//	Returns:  			None
//	
//
//	Description:		Trim oldest data in object
//
//
//////////////////////////////////////////////////////////////////////////////

// Check if trim is necessary and trim
long ll_count
ll_count = ids_data.RowCount( )
if ll_count > il_maxrows then
	ids_data.SetSort( "request d" )
	ids_data.Sort( )
	ids_data.RowsDiscard( il_maxrows, ll_count, Primary! )
end if
end subroutine

public function boolean of_setmaxrows (long al_max);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetMaxRows
//
//	Access:  			public
//
//	Arguments:
//		al_max			long max rows value
//
//
//	Returns:  			None
//	
//
//	Description:		Set max rows value for cache object
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_max ) or al_max < 128 then
	il_err_code = -1006
	is_err_message = "Invalid max rows value"
	return FALSE
end if

// Set
il_maxrows = al_max
return TRUE
end function

public function boolean of_setchecktime (long al_max);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_SetCheckTime
//
//	Access:  			public
//
//	Arguments:
//		al_max			long max times
//
//
//	Returns:  			None
//	
//
//	Description:		Set max insert actions before making check and trim 
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( al_max ) or al_max < 128 then
	il_err_code = -1007
	is_err_message = "Invalid max times value"
	return FALSE
end if

// Set
il_checkperiod = al_max
return TRUE
end function

public function boolean of_find (string as_from, string as_to, ref decimal ad_distance, ref long al_minutes, integer ai_option);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_Find
//
//	Access:  			public
//
//	Arguments:
//		as_from			string origin
//		as_to				string destination
//		ad_distance		decimal distance
//		al_minute		long minutes
//		ai_option		integer calculation option
//
//
//	Returns:  			TRUE if OK
//	
//
//	Description:		Find necessary item in cache and refresh it last request time value
//
//
//////////////////////////////////////////////////////////////////////////////

// Check input parameters
if IsNull( as_from ) or Len( as_from ) < 1 then
	il_err_code = -1002
	is_err_message = "Invalid stop name"
	return FALSE
end if
if IsNull( as_to ) or Len( as_to ) < 1 then
	il_err_code = -1002
	is_err_message = "Invalid stop name"
	return FALSE
end if
if IsNull( ai_option ) then
	il_err_code = -1005
	is_err_message = "Invalid option value"
	return FALSE
end if
ad_distance = 0.0
al_minutes = 0

// Prepare origin and destination values
string ls_origin, ls_destination
if as_from > as_to then
	ls_origin = as_from
	ls_destination = as_to
else
	ls_origin = as_to
	ls_destination = as_from
end if

// Find processing
long ll_row
string ls_find
ls_find = "point_from='" + ls_origin + "' and point_to='" + ls_destination + &
	"' and option='" + string( ai_option ) + "'"
ll_row = ids_data.Find( ls_find, 1, ids_data.RowCount( ) )
if ll_row < 1 then return FALSE

// Get values
ad_distance = ids_data.GetItemNumber( ll_row, "distance" )
al_minutes = ids_data.GetItemNumber( ll_row, "minutes" )

// Refresh last request time value
ids_data.SetItem( ll_row, "request", DateTime( Today( ), Now( ) ) )

return TRUE
end function

on n_cst_routing_cache.create
TriggerEvent( this, "constructor" )
end on

on n_cst_routing_cache.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;ids_data = Create n_cst_routing_cache_attribs
end event

event destructor;Destroy ids_data
end event

