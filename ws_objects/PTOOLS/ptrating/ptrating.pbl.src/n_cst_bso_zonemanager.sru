$PBExportHeader$n_cst_bso_zonemanager.sru
forward
global type n_cst_bso_zonemanager from n_cst_bso
end type
end forward

global type n_cst_bso_zonemanager from n_cst_bso
end type
global n_cst_bso_zonemanager n_cst_bso_zonemanager

type variables
Constant integer	ci_locationtype_site = 1
Constant integer	ci_locationtype_zip = 2
Constant integer	ci_locationtype_citystate = 3
Constant integer	ci_locationtype_state = 4

Constant string	cs_locationtype_site = "SITE"
Constant string	cs_locationtype_zip = "ZIP"
//Constant string	cs_locationtype_citystate = "CITY STATE"
Constant string	cs_locationtype_state = "STATE"

protected:
n_ds		ids_Cache


end variables

forward prototypes
public function string of_getlocationtype ()
public function integer of_getzonesforzip (string asa_zips[], ref string asa_zones[])
public function integer of_getzonesforstate (string asa_states[], ref string asa_zones[])
public function long of_cacheall ()
private function long of_filtercache (string as_location, integer ai_type)
public function long of_findzoneforlocation (string as_location, integer ai_type, ref string asa_zones[])
public function long of_findlocationforzone (string as_zone, integer ai_type, ref string asa_location[])
private function long of_filtercache (string as_zone)
public subroutine of_resetcache ()
end prototypes

public function string of_getlocationtype ();//return as an edit code table list
string	ls_valuelist

ls_ValueList = cs_locationtype_site + "~t" + string(ci_locationtype_site) +&
					"/" + cs_locationtype_zip + "~t" + string(ci_locationtype_zip) +&
					"/" + cs_locationtype_state + "~t" + string(ci_locationtype_state) + "/"
					
return ls_valuelist					

end function

public function integer of_getzonesforzip (string asa_zips[], ref string asa_zones[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetZonesForZip
//  
//	Access		:public
//
//	Arguments	:asa_zips[]
//					 asa_zones[] by reference
//
//	Return		:integer
//					 number of entries in array
//						
//	Description	:Pass out a list of zones for the passed in zips
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

Int		li_ZipCount
Int		i,j
Long		ll_ZoneCount
String	lsa_TempZones[]
String	lsa_Zones[]
String 	ls_CurrentZip

n_cst_AnyArraySrv	lnv_Array

li_ZipCount = UpperBound ( asa_Zips )

For i = 1 TO li_ZipCount 
	ls_CurrentZip =  asa_Zips [i]
	ll_ZoneCount = THIS.of_FindZoneForLocation ( ls_CurrentZip , ci_locationtype_zip , lsa_TempZones )
	FOR j = 1 TO ll_ZoneCount
		lsa_Zones [ UpperBound ( lsa_Zones ) + 1] = lsa_TempZones[j]		
	NEXT
NEXT

lnv_Array.of_GetShrinked( lsa_Zones , TRUE , TRUE )
asa_zones = lsa_Zones

RETURN UpperBound ( asa_zones )
end function

public function integer of_getzonesforstate (string asa_states[], ref string asa_zones[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetZonesForState
//  
//	Access		:public
//
//	Arguments	:asa_states[]
//					 asa_zones[] by reference
//
//	Return		:integer
//					 number of entries in array
//						
//	Description	:Pass out a list of zones for the passed in states
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

Int		li_StateCount
Int		i,j
Long		ll_ZoneCount
String	lsa_TempZones[]
String	lsa_Zones[]
String 	ls_CurrentState

n_cst_AnyArraySrv	lnv_Array

li_StateCount = UpperBound ( asa_States )

For i = 1 TO li_StateCount 
	ls_CurrentState =  asa_States [i]
	ll_ZoneCount = THIS.of_FindZoneForLocation ( ls_CurrentState , ci_locationtype_State , lsa_TempZones )
	FOR j = 1 TO ll_ZoneCount
		lsa_Zones [ UpperBound ( lsa_Zones ) + 1] = lsa_TempZones[j]		
	NEXT
NEXT

lnv_Array.of_GetShrinked( lsa_Zones , TRUE , TRUE )
asa_zones = lsa_Zones

RETURN UpperBound ( asa_zones )
end function

public function long of_cacheall ();Long	ll_Return = -1

IF ISValid ( ids_cache ) THEN

	ids_cache.setTransobject ( sqlca )
	SetPointer(Hourglass!)
	ll_Return = ids_cache.Retrieve ( )
	commit;
END IF

Return ll_Return
end function

private function long of_filtercache (string as_location, integer ai_type);string ls_filter

ids_Cache.SetFilter('')
ids_Cache.Filter()

if ids_Cache.Rowcount() = 0 then
	this.of_CacheAll()
end if

if len(trim(as_location)) = 0 and ai_type = 0 then
	ls_Filter = ''
else
	if ai_type = ci_locationtype_zip then
		if Match(left(as_location,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
			//canadian postal
			ls_Filter = "left(zonelocation_location,7) = '" + left(as_Location,7) + "' AND zonelocation_type = " + String ( ai_Type )	
		else
			ls_Filter = "left(zonelocation_location,5) = '" + left(as_Location,5) + "' AND zonelocation_type = " + String ( ai_Type )
		end if
	else
		ls_Filter = "zonelocation_location = '" + as_Location + "' AND zonelocation_type = " + String ( ai_Type )
	end if
end if

ids_Cache.SetFilter(ls_Filter)
ids_Cache.Filter()
	
return ids_Cache.RowCount() 
	

end function

public function long of_findzoneforlocation (string as_location, integer ai_type, ref string asa_zones[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_FindZoneForLocation
//  
//	Access		:public
//
//	Arguments	:as_location
//					 ai_type
//					 asa_zone[] by reference
//
//	Return		:long
//					 how many in array
//						
//	Description	:Pass out a list of zones for the passed in location
//					 and its type(zip, site, state)
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

Long		ll_Return
Long		i
String	lsa_Zones[]

n_cst_anyarraySrv	lnv_ArraySrv

IF NOT isNull ( as_location ) THEN

	ll_Return = this.of_FilterCache(as_location, ai_type)
	
	For i = 1 TO ll_Return
		lsa_Zones[i] = ids_cache.object.Zone_name [i]
	NEXT
		
	lnv_ArraySrv.of_GetShrinked ( lsa_Zones , TRUE , TRUE )
	ll_Return = UpperBound ( lsa_Zones )
	asa_Zones = lsa_Zones
END IF
	
RETURN ll_Return 
end function

public function long of_findlocationforzone (string as_zone, integer ai_type, ref string asa_location[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_FindLocationForZone
//  
//	Access		:public
//
//	Arguments	:as_zone
//					 ai_type
//					 asa_location[] by reference
//
//	Return		:long
//					 how many in array
//						
//	Description	:Pass out a list of locations for the passed in zone
//					 and type(zip, site, state)
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

Long		ll_Return
Long		i
String	lsa_Locations[]

n_cst_anyarraySrv	lnv_ArraySrv

IF NOT isNull ( as_zone ) THEN

	ll_Return = this.of_FilterCache(as_zone)
	
	For i = 1 TO ll_Return
		if ids_cache.object.ZoneLocation_Type [i] = ai_type then
			lsa_Locations[i] = ids_cache.object.ZoneLocation_Location [i]
		end if
	NEXT
		
	lnv_ArraySrv.of_GetShrinked ( lsa_Locations , TRUE , TRUE )
	ll_Return = UpperBound ( lsa_Locations )
	asa_location = lsa_Locations
END IF
	
RETURN ll_Return 
end function

private function long of_filtercache (string as_zone);string ls_filter

ids_Cache.SetFilter('')
ids_Cache.Filter()

if ids_Cache.Rowcount() = 0 then
	this.of_CacheAll()
end if

if len(trim(as_zone)) = 0 then
	ls_Filter = ''
else
	ls_Filter = " AND zonelocation_zonename = '" + as_zone + "' "
end if

ids_Cache.SetFilter(ls_Filter)
ids_Cache.Filter()
	
return ids_Cache.RowCount() 
	
end function

public subroutine of_resetcache ();ids_cache.reset()
end subroutine

on n_cst_bso_zonemanager.create
call super::create
end on

on n_cst_bso_zonemanager.destroy
call super::destroy
end on

event destructor;call super::destructor;DESTROY ids_cache
end event

event constructor;call super::constructor;ids_cache = create n_ds
ids_cache.dataobject = "d_Zonelocationlookup_ds"


end event

