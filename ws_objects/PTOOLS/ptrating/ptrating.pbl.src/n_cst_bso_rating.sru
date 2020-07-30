$PBExportHeader$n_cst_bso_rating.sru
forward
global type n_cst_bso_rating from n_cst_bso
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//n_ds		sds_rate, &
//		sds_rateDefaults, &
//		sds_ratenames
//
//n_cst_bso_zonemanager	snv_ZoneManager
////end modification Shared Variables by appeon  20070730
//
//
end variables

global type n_cst_bso_rating from n_cst_bso
end type
global n_cst_bso_rating n_cst_bso_rating

type variables
Constant  String cs_RateUnit_Flat = "FLAT"
Constant  String cs_RateUnit_Pound = "POUND"
Constant  String cs_RateUnit_100Pound = "CWT"
Constant  String cs_RateUnit_Ton = "TON"
Constant  String cs_RateUnit_Piece = "PIECE"
Constant  String cs_RateUnit_PerMile = "MILE"
Constant  String cs_RateUnit_PerUnit = "UNIT"
Constant  String cs_RateUnit_Gallon = "GALLON"
Constant  String cs_RateUnit_Class = "CLASS"
Constant  String cs_RateUnit_Minimum = "MINIMUM"
Constant  String cs_RateUnit_Maximum = "MAXIMUM"
Constant  String cs_RateUnit_None = "NONE"

Constant  String cs_RateUnit_Code_Pound = "1"
Constant  String cs_RateUnit_Code_100Pound = "2"
Constant  String cs_RateUnit_Code_Ton = "3"
Constant  String cs_RateUnit_Code_Piece = "4"
Constant  String cs_RateUnit_Code_Gallon ="5"
Constant  String cs_RateUnit_Code_None = "Z"
Constant  String cs_RateUnit_Code_Flat = "F"
Constant  String cs_RateUnit_Code_Class = "C"
Constant  String cs_RateUnit_Code_PerMile = "M"
Constant  String cs_RateUnit_Code_PerUnit = "U"
Constant  String cs_RateUnit_Code_Minimum = "N"
Constant  String cs_RateUnit_Code_Maximum = "X"

Constant	String cs_CodenameList_Stopoff = "STOPOFF"
Constant	String cs_CodenameList_ChassisSplit = "CHASSISSPLIT"
Constant	String cs_CodenameList_SearchOrder = "SEARCHORDER"

CONSTANT Long cl_itemfreight_list = 123
CONSTANT Long cl_chassissplit_list = 124
CONSTANT Long cl_stopoff_list = 125
CONSTANT Long cl_FuelSurcharge_list = 140
CONSTANT Long cl_PerDiem_list = 141
CONSTANT Long cl_AutoCreatedAccessorialCharge_list = 196
CONSTANT Long cl_BobTail_list = 254

CONSTANT String cs_itemfreight_list = 'Freight Items'
CONSTANT String cs_chassissplit_list = 'Chassis Pickup/Return'
CONSTANT String cs_stopoff_list = 'Stopoff'
CONSTANT String cs_custom_list = 'Custom'
CONSTANT String cs_FuelSurcharge_list = 'Fuel Surcharge'
CONSTANT String cs_PerDiem_list = 'Per Diem'
CONSTANT String cs_AutoCreatedAccessorialCharge_list = 'Auto Added Charges'
CONSTANT String cs_BobTail_list = 'Bobtail item'



Private:
string		isa_origsite_zone[], &
		isa_origzip_zone[], &
		isa_origstate_zone[], &
		isa_destsite_zone[], &
		isa_destzip_zone[], &
		isa_deststate_zone[], &
		is_WhatChanged, &
		is_codeoverride
long		il_customerid=0
boolean		ib_includenonetype
boolean		ib_interactivemode
boolean		ib_customertable
boolean		ib_recalculate
boolean		ib_originzonesfound
boolean		ib_destzonesfound

Boolean		ib_NeedToDetermineDestZones = True
Boolean		ib_NeedToDetermineOrigZones = True


end variables

forward prototypes
public function string of_getunitlabel (string as_UnitCode)
public function long of_searchfornonetype (n_cst_beo_shipment anva_shipment[])
public function n_ds of_getratecache (boolean ab_create)
public function integer of_compareorigin (n_cst_ratedata anv_ratedata, integer ai_type, ref string asa_matchorig[], ref string asa_matchdest[])
private subroutine of_setcustomerid (n_cst_beo_shipment anv_shipment)
public function n_ds of_setratetable (string as_tablename, string as_origin, string as_destination)
public subroutine of_filterdestination (ref string asa_matchorig[], ref string asa_matchdest[])
public function integer of_getorigindestinationzone (ref n_cst_ratedata anv_ratedata)
public function long of_cache (n_cst_ratedata anv_ratedata)
public function long of_getratetablename (n_cst_ratedata anv_ratedata, ref string as_ratetablename, ref string as_codename)
public subroutine of_filterratecache (string as_codename)
public function integer of_getratetablezones (string as_codename, ref string asa_zones[])
private function string of_getbreakunit (string as_codename)
protected function integer of_getoriginlocationzones (n_cst_ratedata anv_ratedata)
protected function integer of_getdestinationlocationzones (n_cst_ratedata anv_ratedata)
public subroutine of_initialize ()
public function string of_getratedescription (ref n_cst_ratedata anv_ratedata)
public function n_ds of_getratedefaultcache ()
public function n_ds of_getratetablenamecache ()
public subroutine of_reverseorigindestination (ref n_cst_ratedata anv_ratedata)
public function boolean of_usereversesearch ()
public function integer of_getratetablelist (ref n_cst_ratedata anv_ratedata)
public function integer of_calculate (ref n_cst_ratedata anv_ratedata, boolean ab_reversesearch)
public function integer of_autorate (n_cst_beo_shipment anv_shipment, n_cst_beo_item anva_item[], ref n_cst_ratedata anva_ratedata[], integer ai_category)
public function boolean of_iscodenamedefault (string as_codename, ref n_cst_ratedata anv_ratedata)
public subroutine of_destroycache ()
public function long of_filtercache (n_cst_ratedata anv_ratedata, boolean ab_zones)
private subroutine of_getamountitemtype (ref n_cst_ratedata anv_ratedata)
public subroutine of_setorigin (n_cst_beo_shipment anv_shipment, ref n_cst_ratedata anv_ratedata)
private subroutine of_setorigin (n_cst_beo_company anv_company, ref n_cst_ratedata anv_ratedata)
private subroutine of_setdestination (n_cst_beo_company anv_company, ref n_cst_ratedata anv_ratedata)
public subroutine of_setdestination (n_cst_beo_shipment anv_shipment, ref n_cst_ratedata anv_ratedata)
public function long of_setitemsource (n_cst_beo_shipment anva_shipment[], ref n_cst_beo_item anva_item[], boolean ab_combinedfreight)
public function integer of_autorate (n_cst_beo_shipment anva_shipment[], ref n_cst_ratedata anva_ratedata[], integer ai_category, boolean ab_combinedfreight)
public subroutine of_setcombineditems (n_cst_beo_item anva_item[], ref n_cst_ratedata anva_ratedata[])
public subroutine of_autorate (ref n_cst_ratedata anva_ratedata[], boolean ab_showpicklist)
public subroutine of_setrecalculate (boolean ab_set)
public function boolean of_recalculate ()
public subroutine of_getratetablebyeventtype (ref n_cst_ratedata anv_ratedata, string as_eventtype)
public function boolean of_hasautorate ()
public function boolean of_haseditrights (string as_itemtype)
public subroutine of_resetcache ()
public subroutine of_resetratecache ()
public subroutine of_resetzonecache ()
public function n_cst_bso_zonemanager of_getzonemanager ()
public subroutine of_setwhatchanged (string as_value)
public function string of_getwhatchanged ()
public function integer of_settotalcharge (ref n_cst_ratedata anv_ratedata, boolean ab_zones, ref string as_errormessage)
public subroutine of_setorigin (long al_value, ref n_cst_ratedata anv_ratedata)
public subroutine of_setdestination (long al_value, ref n_cst_ratedata anv_ratedata)
public subroutine of_setcodeoverride (string as_value)
public function string of_getcodeoverride ()
public function integer of_getcodedefaultlist (long al_coid, integer ai_whichlist, ref string asa_resultlist[])
public function long of_getamounttype (ref n_cst_ratedata anv_ratedata)
public function boolean of_checknextbreak (string as_codename)
protected subroutine of_settotalitemcount (n_cst_beo_item anva_item[], n_cst_beo_shipment anv_shipment, ref n_cst_ratedata anva_ratedata[])
public function integer of_getrateidfororigindestination (string asa_originzone[], string asa_destinationzone[], ref long ala_rateid[])
public function integer of_getbilltofororigindestination (string asa_originzone[], string asa_destinationzone[], ref long al_indexfound)
public function boolean of_usereversesearchforsettlements ()
public function string of_getvaluelist (boolean ab_includenone)
public function integer of_getcodedefaultlist (long al_coid, integer ai_whichlist, ref string asa_resultlist[], boolean ab_combine)
public function long of_getamounttype (string as_ratecode)
public function string of_getratedescription (string as_ratecode, long al_billtoid)
end prototypes

public function string of_getunitlabel (string as_UnitCode);String	ls_Return
CHOOSE CASE UPPER ( as_UnitCode )
		
	CASE appeon_constant.cs_RateUnit_Code_Pound
		ls_Return = appeon_constant.cs_RateUnit_Pound		
	CASE appeon_constant.cs_RateUnit_Code_100Pound
		ls_Return = appeon_constant.cs_RateUnit_100Pound 
	CASE appeon_constant.cs_RateUnit_Code_Ton 
		ls_Return = appeon_constant.cs_RateUnit_Ton 
	CASE appeon_constant.cs_RateUnit_Code_Piece 
		ls_Return = appeon_constant.cs_RateUnit_Piece 
	CASE appeon_constant.cs_RateUnit_Code_Gallon 
		ls_Return = appeon_constant.cs_RateUnit_Gallon 
	CASE appeon_constant.cs_RateUnit_Code_None
		ls_Return = appeon_constant.cs_RateUnit_None 
	CASE appeon_constant.cs_RateUnit_Code_Flat 
		ls_Return = appeon_constant.cs_RateUnit_Flat 
	CASE appeon_constant.cs_RateUnit_Code_Class 
		ls_Return = appeon_constant.cs_RateUnit_Class 
	CASE appeon_constant.cs_RateUnit_Code_PerMile 
		ls_Return = appeon_constant.cs_RateUnit_PerMile 
	CASE appeon_constant.cs_RateUnit_Code_PerUnit 
		ls_Return = appeon_constant.cs_RateUnit_PerUnit 
	CASE appeon_constant.cs_RateUnit_Code_Minimum 
		ls_Return = appeon_constant.cs_RateUnit_Minimum 
		
END CHOOSE
RETURN ls_Return 
end function

public function long of_searchfornonetype (n_cst_beo_shipment anva_shipment[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SearchforNoneType
//  
//	Access		:public
//
//	Arguments	:anva_shipment[] by reference
//
//	Return		:long
//					 nunber of 'none' types
//						
//	Description	:Determine and set indicator for including items with a 'none' rate type.
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

long	ll_ndx, &
		ll_ndx2, &
		ll_shipcount, &
		ll_itemcount, &
		ll_nonecount
Int	 li_result
		
n_cst_beo_item		lnva_item[]

ll_shipcount = upperbound(anva_shipment)

for ll_ndx = 1 to ll_shipcount
	
	if isvalid(anva_shipment[ll_ndx]) then
		//ok
	else
		continue
	end if
	
	ll_itemcount = anva_shipment[ll_ndx].of_getitemlist(lnva_item)
	for ll_ndx2 = 1 to ll_itemcount
		if lnva_item[ll_ndx2].of_gettype() = n_cst_constants.cs_ItemType_Freight then
			if lnva_item[ll_ndx2].of_getratetype() = appeon_constant.cs_RateUnit_Code_None  then
				ll_nonecount ++
			end if
		end if
		DESTROY ( lnva_item [ ll_ndx2 ] )
	next
	
next

if ll_nonecount > 0 then
	//Dan, need  to check scheduler
	IF NOT gnv_app.of_runningscheduledtask( ) THEN	
		li_result = messagebox("Rate Type", "Some freight item(s) have 'NONE' as the rate type. " + &
					" Should they be included in the rating ?", Question!, YesNo!, 1 )
	ELSE
		li_result = 2				
	END IF
	choose case li_result
	//-------------------------
		case 1
			ib_includenonetype = true
		case 2
			ib_includenonetype = false
	end choose
else
	ib_includenonetype = false
end if

return ll_nonecount

end function

public function n_ds of_getratecache (boolean ab_create);//create the datastore for retrieving rates, will be reset for each shipment

IF NOT IsValid ( sds_rate ) THEN

	n_cst_Dws	lnv_Dws

	IF lnv_Dws.of_CreateDataStoreByDataObject ( "d_rate_ds", sds_rate, TRUE ) = 1 THEN
		sds_rate.of_SetBase ( TRUE )
	END IF

END IF

return sds_rate



end function

public function integer of_compareorigin (n_cst_ratedata anv_ratedata, integer ai_type, ref string asa_matchorig[], ref string asa_matchdest[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_CompareOrigin
//  
//	Access		:public
//
//	Arguments	:anva_ratedata[] by reference,
//					 ai_type,
//					 asa_matchorig[],
//					 asa_matchdest
//
//	Return		:integer
//					 1 success
//					 -1 failure
//						
//	Description	:Based on ai_type ( site, zip, state ) grab the appropriate instance array.
//					 Search through the rate tables for a hit. If one is found then take 
//					 the corresponding destination zone and see if it matches the one on the rate table.
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


long	ll_origzone_index, &
		ll_origarray_index, &
		ll_destzone_index, &
		ll_matchcount, &
		ll_origzone_count, &
		ll_destzone_count, &
		ll_rowcount, &
		ll_found, &
		ll_listcount
		
string	lsa_origcompare_zone[], &
			ls_originzone, &
			ls_destzone, &
			lsa_zones[], &
			lsa_blank[], &
			lsa_list[]
			
//ll_origarray_count = upperbound(isa_tableorigzone)

ll_rowcount = sds_rate.RowCount()
sds_rate.setsort('originzone A, destzone A')
sds_rate.sort()

choose case ai_type
	case snv_zonemanager.ci_locationtype_site
		lsa_origcompare_zone = isa_origsite_zone
		
	case snv_zonemanager.ci_locationtype_zip
		lsa_origcompare_zone = isa_origzip_zone

	case snv_zonemanager.ci_locationtype_state
		lsa_origcompare_zone = isa_origstate_zone
		
end choose

ll_origzone_count = upperbound(lsa_origcompare_zone) 

/*
	loop thru lsa_comparezone , take each entry and search thru filtered rate cache of origin zones
	if one is found then see if dest site,zip,state compare to the same row, when found exit dest loop.
	if a dest is found then on the next pass do not proceed to a wider zone eg if a dest site was 
	found don't look at zip or state zones
		
*/

if ll_origzone_count = 0 then
	//do we have a specific zone to match
	ls_originzone = anv_ratedata.of_getoriginzone()
	if len(trim(ls_originzone)) = 0 or isnull(ls_originzone) then
		//no
	else
		lsa_origcompare_zone[1] = ls_originzone
		ll_origzone_count = 1
	end if
end if

for ll_origzone_index = 1 to ll_origzone_count	//origin zone matches
	if ll_rowcount	> 0 then //array of elible zones to match to

		ll_found = 1
	
		DO	
			ll_found = sds_rate.find("originzone = '" + lsa_origcompare_zone[ll_origzone_index] + "'", ll_found, ll_rowcount)
			if ll_found > 0 then
				//we have an origin zone in the array, now let's see if the corresponding dest zone matches
				//and add to matched zone arrays
				
				//specific zone first
				ls_destzone = anv_ratedata.of_getDestinationzone()
				if len(trim(ls_destzone)) = 0 or isnull(ls_destzone) then
					//no
				else
					if ls_destzone = sds_rate.object.destzone[ll_found] then
						ll_matchcount ++
						asa_matchorig[ll_matchcount] = sds_rate.object.originzone[ll_found]
						asa_matchdest[ll_matchcount] = sds_rate.object.destzone[ll_found]
					end if
				end if
	
			end if
			choose case ll_found
				case 0
					//do nothing
				case is < ll_rowcount
					ll_found ++
				case else
					ll_found = 0
			end choose
					
		LOOP UNTIL ll_found = 0
	end if
next

for ll_origzone_index = 1 to ll_origzone_count	//origin zone matches
	if ll_rowcount	> 0 then //array of elible zones to match to

		ll_found = 1
	
		DO	
			ll_found = sds_rate.find("originzone = '" + lsa_origcompare_zone[ll_origzone_index] + "'", ll_found, ll_rowcount)
			if ll_found > 0 then
				//we have an origin zone in the array, now let's see if the corresponding dest zone matches
				//and add to matched zone arrays
				
				//site first
				ll_destzone_count = upperbound(isa_destsite_zone)
				for ll_destzone_index = 1 to ll_destzone_count  
					if isa_destsite_zone[ll_destzone_index] = sds_rate.object.destzone[ll_found] then
						ll_matchcount ++
						asa_matchorig[ll_matchcount] = sds_rate.object.originzone[ll_found]
						asa_matchdest[ll_matchcount] = sds_rate.object.destzone[ll_found]
					end if
				next
				
	
			end if
			choose case ll_found
				case 0
					//do nothing
				case is < ll_rowcount
					ll_found ++
				case else
					ll_found = 0
			end choose
					
		LOOP UNTIL ll_found = 0
	end if
next

for ll_origzone_index = 1 to ll_origzone_count	//origin zone matches
	if ll_rowcount	> 0 then //array of elible zones to match to

		ll_found = 1
	
		DO	
			ll_found = sds_rate.find("originzone = '" + lsa_origcompare_zone[ll_origzone_index] + "'", ll_found, ll_rowcount)
			if ll_found > 0 then
				//we have an origin zone in the array, now let's see if the corresponding dest zone matches
				//and add to matched zone arrays
				
				//look for dest zip zones
				ll_destzone_count = upperbound(isa_destzip_zone)
				for ll_destzone_index = 1 to ll_destzone_count  
					if isa_destzip_zone[ll_destzone_index]  = sds_rate.object.destzone[ll_found] then
						ll_matchcount ++
						asa_matchorig[ll_matchcount] = sds_rate.object.originzone[ll_found]
						asa_matchdest[ll_matchcount] = sds_rate.object.destzone[ll_found]
					end if
				next		
	
			end if
			choose case ll_found
				case 0
					//do nothing
				case is < ll_rowcount
					ll_found ++
				case else
					ll_found = 0
			end choose
					
		LOOP UNTIL ll_found = 0
	end if
next

for ll_origzone_index = 1 to ll_origzone_count	//origin zone matches
	if ll_rowcount	> 0 then //array of elible zones to match to

		ll_found = 1
	
		DO	
			ll_found = sds_rate.find("originzone = '" + lsa_origcompare_zone[ll_origzone_index] + "'", ll_found, ll_rowcount)
			if ll_found > 0 then
				//we have an origin zone in the array, now let's see if the corresponding dest zone matches
				//and add to matched zone arrays
				
				//look for dest state zones
				ll_destzone_count = upperbound(isa_deststate_zone)
				for ll_destzone_index = 1 to ll_destzone_count  
					if isa_deststate_zone[ll_destzone_index] = sds_rate.object.destzone[ll_found] then
						ll_matchcount ++
						asa_matchorig[ll_matchcount] = sds_rate.object.originzone[ll_found]
						asa_matchdest[ll_matchcount] = sds_rate.object.destzone[ll_found]
					end if
				next
	
			end if
			choose case ll_found
				case 0
					//do nothing
				case is < ll_rowcount
					ll_found ++
				case else
					ll_found = 0
			end choose
					
		LOOP UNTIL ll_found = 0
	end if
next

ll_matchcount = upperbound(asa_matchorig)
if ll_matchcount > 0 then
	for ll_origzone_index = 1 to ll_matchcount
		//make a list
		ls_originzone = asa_matchorig[ll_origzone_index]
		ls_destzone = asa_matchdest[ll_origzone_index]
		lsa_zones[ll_origzone_index] = ls_originzone + "," + ls_destzone
	next

	n_cst_anyarraysrv lnv_arraysrv
	n_cst_string	lnv_string
	
	//shrink the list
	lnv_ArraySrv.of_GetShrinked ( lsa_zones , TRUE , TRUE )
	
	//put them back
	ll_matchcount = upperbound(lsa_zones)
	asa_matchorig = lsa_blank
	asa_matchdest = lsa_blank
	for ll_origzone_index = 1 to ll_matchcount
		ll_listcount = lnv_string.of_ParseToArray(lsa_zones[ll_origzone_index], ',', lsa_list )
		if ll_listcount > 1 then
			asa_matchorig[ll_origzone_index] = lsa_list[1]
			asa_matchdest[ll_origzone_index] = lsa_list[2]
		end if
	next

end if

return upperbound(asa_matchorig)
			
			
			
end function

private subroutine of_setcustomerid (n_cst_beo_shipment anv_shipment);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetCustomerID
//  
//	Access		:private
//
//	Arguments	:anv_shipment
//
//	Return		:none
//						
//	Description	:set instance to billto id for rate table information.
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


n_cst_beo_company	lnv_company
IF isValid ( anv_Shipment ) THEN
	anv_shipment.of_getbilltocompany(lnv_company,true)
	if isvalid(lnv_company) then
		il_customerid = lnv_company.of_getid()
	end if
END IF

DESTROY lnv_Company





end subroutine

public function n_ds of_setratetable (string as_tablename, string as_origin, string as_destination);long	ll_rowcount

string	ls_originalselect, &
			ls_sql
n_ds	lds_rate

lds_rate = this.of_getratecache(false)

if isvalid(lds_rate) then
	if lds_rate.rowcount() > 0 then
		ls_OriginalSelect =lds_rate.Object.DataWindow.Table.Select
		ls_sql = 'and ~~"rate~~".~~"ratetablename~~" = ' + "'" + as_tablename + "'" +&
					' and ~~"rate~~".~~"originzonename~~" = ' + "'" + as_origin + "'" +&
					' and ~~"rate~~".~~"destinationzonename~~" = ' + "'" + as_destination + "'" 
		lds_rate.Object.DataWindow.Table.Select = ls_OriginalSelect + ls_sql 

		//this retrieves customer and base
		lds_rate.retrieve(il_customerid)		
		commit;
		if ib_customertable then
			//Filter customer tables only
			lds_rate.setfilter('customerid = ' + string(il_customerid))
			lds_rate.filter()
		end if
		
		ll_rowcount = lds_rate.rowcount()
		if ll_rowcount = 0 then
			//look at base tables
			lds_rate.setfilter('customerid = 0')
			lds_rate.filter()
		end if
			
	end if
end if

return lds_rate

end function

public subroutine of_filterdestination (ref string asa_matchorig[], ref string asa_matchdest[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_FilterDestination
//  
//	Access		:public
//
//	Arguments	:asa_matchorig by reference
//					 asa_matchdest by reference
//
//	Return		:none
//						
//	Description	:Filter the arrays down to the most specific dest zone.
//					 Site, zip, state.  Pass out the filtered arrays
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

long	ll_destzone_index, &
		ll_match_index, &
		ll_destzone_count, &
		ll_matchcount, &
		ll_filtercount
		
string	lsa_matchorig[], &		
			lsa_matchdest[], &
			lsa_blank[]
			
boolean	lb_DestSite, &
			lb_DestZip, &
			lb_DestState

ll_matchcount = upperbound(asa_matchdest)
ll_destzone_count = upperbound(isa_destsite_zone)

//if a destination was sent in to rating then there won't be any in the 
//instance list.
//Send the array back out unaltered	- nwl 11/03/04

if ll_destzone_count = 0 then
	if ll_matchcount > 0 then
		//send back out
		lsa_matchorig = asa_matchorig
		lsa_matchdest = asa_matchdest
	end if
end if


//site first
for ll_destzone_index = 1 to ll_destzone_count  

	for ll_match_index = 1 to ll_matchcount

		if isa_destsite_zone[ll_destzone_index] = asa_matchdest[ll_match_index] then
			if not lb_DestSite then
				lb_DestSite=true
				ll_filtercount = 0
				lsa_matchorig = lsa_blank
				lsa_matchdest = lsa_blank
			end if
			ll_filtercount ++
			lsa_matchorig[ll_filtercount] = asa_matchorig[ll_match_index]
			lsa_matchdest[ll_filtercount] = asa_matchdest[ll_match_index]
		end if
		
	next
	
next

if NOT lb_DestSite then
	//look for dest zip zones
	ll_destzone_count = upperbound(isa_destzip_zone)
	for ll_destzone_index = 1 to ll_destzone_count  

		for ll_match_index = 1 to ll_matchcount
	
			if isa_destzip_zone[ll_destzone_index]  = asa_matchdest[ll_match_index] then
				if not lb_DestZip then
					lb_DestZip=true
					ll_filtercount = 0
					lsa_matchorig = lsa_blank
					lsa_matchdest = lsa_blank
				end if
				ll_filtercount ++
				lsa_matchorig[ll_filtercount] = asa_matchorig[ll_match_index]
				lsa_matchdest[ll_filtercount] = asa_matchdest[ll_match_index]
			end if
			
		next
		
	next
	
end if
	
if NOT lb_DestSite AND NOT lb_DestZip then
	//look for dest state zones
	ll_destzone_count = upperbound(isa_deststate_zone)
	for ll_destzone_index = 1 to ll_destzone_count  

		for ll_match_index = 1 to ll_matchcount
	
			if isa_deststate_zone[ll_destzone_index] = asa_matchdest[ll_match_index] then
				lb_DestState=true
				ll_filtercount ++
				lsa_matchorig[ll_filtercount] = asa_matchorig[ll_match_index]
				lsa_matchdest[ll_filtercount] = asa_matchdest[ll_match_index]
			end if
			
		next
		
	next
	
end if

asa_matchorig = lsa_matchorig
asa_matchdest = lsa_matchdest

end subroutine

public function integer of_getorigindestinationzone (ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetOriginDestinationZone
//  
//	Access		:public
//
//	Arguments	:anva_ratedata[] by reference
//
//	Return		:integer
//					 1 success
//					 -1 failure
//						
//	Description	:Set the Origin and Destination zone on the ratedata objects.
//					Origin zone takes precedence. Get origin/destination pair.
//					The search hierarchy is site,zip,state. If more than one pair 
//					is found then send the list to a response window for the user
//					to pick one.
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//		5-25-07 MFS - Only get the orig/dest location zones if we have not already done so.
//						  This is for performance reasons (see of_autorate revision history). 
//	
//////////////////////////////////////////////////////////////////////////////
//


string	lsa_origcompare_zone[], &
			lsa_destcompare_zone[], &
			lsa_matchorig[], &
			lsa_matchdest[], &
			lsa_tablezones[], &
			lsa_zone[], &
			lsa_blank[], &
			ls_OriginZone, &
			ls_DestinationZone, &
			ls_errormessage, &
			ls_inclause
	
long		ll_ndx, &
			ll_ndx2, &
			ll_ratecount, &
			ll_tablezonecount, &
			ll_indexfound, &
			lla_billtoid[], &
			lla_rateid[]
		
integer	li_ndx, &
			li_msgcount, &
			li_return=1

boolean	lb_match, &
			lb_origlocationfound, &
			lb_destlocationfound
			
n_cst_string	lnv_string
n_cst_sql		lnv_sql
n_cst_anyarraySrv	lnv_ArraySrv
n_ds				lds_origindestselection
w_ratetableselection	lw_ratetable
n_cst_msg	lnv_Msg
s_parm	lstr_Parm
n_cst_OFRError	lnv_Error




if isvalid(anv_ratedata) then
	
	this.of_filterratecache(anv_ratedata.of_getcodename())

	if li_return = 1 then	
		ls_OriginZone = anv_ratedata.of_GetOriginZone()
		if len(trim(ls_OriginZone)) = 0 or isnull(ls_OriginZone) then
			
			IF ib_NeedToDetermineOrigZones THEN //MFS 5/25/07

				if this.of_GetOriginLocationZones(anv_ratedata) = -1 then
					//errormessage set in called method
					li_return = -1 
				end if
				
			END IF
		else
			ib_originzonesfound = true
		end if
	end if
	
	if li_return = 1 then
		ls_DestinationZone = anv_ratedata.of_GetDestinationZone()
		if len(trim(ls_DestinationZone)) = 0 or isnull(ls_DestinationZone) then
			
			IF ib_NeedToDetermineDestZones THEN //MFS 5/25/07
			
				if this.of_GetDestinationLocationZones(anv_ratedata) = -1 then
					//errormessage set in called method
					li_return = -1 
				end if
				
			END IF
		else
			ib_destzonesfound = true
		end if	
	end if
	
	if li_return = 1 then
		
		if this.of_compareorigin(anv_ratedata, &
										 appeon_constant.ci_locationtype_site, &
										 lsa_matchorig, lsa_matchdest) > 0 then
			lb_match = true
		else
			lb_match = false
		end if
		
		if lb_match then
			if upperbound(lsa_matchorig) > 1 then
				//more than one table matched
				//user needs to choose
				//messaging below
			end if
		else
			
			if this.of_compareorigin(anv_ratedata, &
											 appeon_constant.ci_locationtype_zip,&
											 lsa_matchorig, lsa_matchdest) > 0 then
				lb_match = true
			else
				lb_match = false
			end if
			
			if lb_match then
				if upperbound(lsa_matchorig) > 1 then
					//more than one table matched
					//user needs to choose
				end if
			else
				
				if this.of_compareorigin(anv_ratedata, &
												 appeon_constant.ci_locationtype_state,&
												 lsa_matchorig, lsa_matchdest) > 0 then
					lb_match = true
				else
					lb_match = false
				end if
			end if
			
		end if
		
		
		if lb_match = true then
			
			if upperbound(lsa_matchorig) > 1 then
			
				//filter to most specific dest zone, if more than one of those then pick
				THIS.of_filterdestination ( lsa_matchorig, lsa_matchdest )
			
				if upperbound(lsa_matchorig) > 1 then
					
					//still more than one 
					//check for a billto override
					if this.of_GetBilltofororigindestination( lsa_matchorig, lsa_matchdest, ll_indexfound) = 1 then
						//one override, use it
						anv_ratedata.of_setoriginzone(lsa_matchorig[ll_indexfound])
						anv_ratedata.of_setdestinationzone(lsa_matchdest[ll_indexfound])
						
					else
					
						//get rate ids for the origin/destination pairs
						if this.of_Getrateidfororigindestination( lsa_matchorig, lsa_matchdest, lla_rateid) > 0 then
							//make in clause and filter cache to the rateids and send to the window
							ls_InClause = lnv_Sql.of_MakeInClause ( lla_rateid )
							sds_rate.setfilter("id " + ls_inclause)
							sds_rate.filter()
							lds_origindestselection = create n_ds
							lds_origindestselection.dataobject = 'd_origindestselection'
							lds_origindestselection.settransobject(sqlca)
							sds_rate.ShareData(lds_origindestselection)
							
						end if
						
						lstr_Parm.is_Label = "ORIGIN"
						lstr_Parm.ia_Value = lsa_matchorig
						lnv_Msg.of_Add_Parm (lstr_Parm)
				
						lstr_Parm.is_Label = "DESTINATION"
						lstr_Parm.ia_Value = lsa_matchdest
						lnv_Msg.of_Add_Parm (lstr_Parm)
						
						lstr_Parm.is_Label = "DATASOURCE"
						lstr_Parm.ia_Value = lds_origindestselection
						lnv_Msg.of_Add_Parm (lstr_Parm)
						
						lstr_Parm.is_Label = "RATEDATA"
						lstr_Parm.ia_Value = anv_ratedata
						lnv_Msg.of_Add_Parm (lstr_Parm)
						
						
				
				
						//Dan change, check scheduler first
						IF NOT gnv_app.of_runningscheduledtask( ) THEN								
							openwithparm ( lw_ratetable, lnv_msg )
						END IF
						//-----------------------------------
						
						lnv_Msg = message.powerobjectparm
						
						
						if isvalid(lnv_msg) then
							li_MsgCount = 	lnv_msg.of_get_count()
							FOR li_Ndx = 1 to li_MsgCount
								lnv_msg.of_get_parm(li_ndx, lstr_parm)
								
								CHOOSE CASE upper(lstr_parm.is_label)
											
									CASE "ORIGIN"
										anv_ratedata.of_setoriginzone(lstr_Parm.ia_Value )
										
									CASE "DESTINATION"
										anv_ratedata.of_setdestinationzone(lstr_Parm.ia_Value )
														
								END CHOOSE
							NEXT
						end if
						lds_origindestselection.sharedataoff()
						destroy lds_origindestselection
						
					end if
				else
					anv_ratedata.of_setoriginzone(lsa_matchorig[1])
					anv_ratedata.of_setdestinationzone(lsa_matchdest[1])
							
				end if
			else
				anv_ratedata.of_setoriginzone(lsa_matchorig[1])
				anv_ratedata.of_setdestinationzone(lsa_matchdest[1])
			end if
		else
			li_return = -1
			ls_errormessage = "No rate defined for the selected origin/destination locations."

		end if
		
	end if
	
end if

if li_return = -1 then

	if len (ls_errormessage) > 0 then
		lnv_Error = This.AddOFRError ( )
		if IsValid ( lnv_Error ) then
			lnv_Error.SetErrorMessage ( ls_ErrorMessage )
		end if
	end if

end if

/*
	loop through all the origin site zones found for this origin location
	see if any of them match one of the rate table origin zones
	if a match is found then see if any of the destination site zones for destination location
	matches the corresponding rate table destination
*/
if li_return = 0 then
	//zoneless table change back to 1
	li_return = 1
end if

return li_return
end function

public function long of_cache (n_cst_ratedata anv_ratedata);//read ratedata object for codename and add to cache
//return 1 if added or already there 0 if not
long			ll_CacheCount, &
				ll_return=0
				
string		ls_FindString, &
				ls_sql, &
				ls_originalfilter, &
				ls_originalselect, &
				ls_codename

this.of_GetRateCache(true/*create*/)
ll_CacheCount = sds_rate.rowcount()
ll_CacheCount += sds_rate.FilteredCount()

if ll_CacheCount > 0 then
	ls_originalfilter = sds_rate.object.datawindow.table.filter
	if ls_originalfilter='?' then
		ls_originalfilter=''
	end if
	sds_rate.setfilter('')
	sds_rate.filter()
end if

ll_CacheCount = sds_rate.rowcount()

if isvalid(anv_ratedata) then

	ls_codename = anv_ratedata.of_GetCodename() 
	ls_FindString += "codename = '" + ls_codename + "'"

	if ll_CacheCount > 0 then
		// is rate table already in the cache.
		if sds_rate.find(ls_FindString, 1, ll_CacheCount) > 0 then
			ll_return = 1
		else
			ll_return = 0
		end if
	end if

	if ll_return = 0 then
		if sds_rate.Retrieve() > 0 then
			commit;
			ll_return = 1
		end if
		
		commit;
	end if
	
end if

if ll_CacheCount > 0 then
	sds_rate.setfilter(ls_originalfilter)
	sds_rate.filter()
end if

return ll_return

end function

public function long of_getratetablename (n_cst_ratedata anv_ratedata, ref string as_ratetablename, ref string as_codename);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetRateTableName
//  
//	Access		:public
//
//	Arguments	:anv_ratedata
//					 as_ratetablename by reference
//					 as_codename by reference
//
//	Return		:long
//					  1 = success
//					 -1 - failure
//						
//	Description	:Open a window and present the user a list of rate tables to choose from.
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

long		ll_rowcount, &
			ll_ndx, &
			ll_arraycount, &
			ll_return, &
			ll_null, &
			ll_row
			
string	ls_ratetablename, &
			ls_codename, &
			lsa_ratetablename[], &
			ls_filter, &
			lsa_amounttypes[], &
			ls_amounttypes

integer	li_Ndx, &
			li_MsgCount
boolean	lb_found
n_cst_presentation_ratetable	lnv_RateTablePres
n_cst_presentation_amounttype lnv_presentationamounttype
s_parm	lstr_Parm
n_cst_String	lnv_string
n_cst_OFRerror	lnv_error
n_ds		lds_ratenames
w_ratetableselection	lw_ratetable
n_cst_msg	lnv_Msg

setnull(ll_null)

lds_ratenames = this.of_GetRatetablenameCache()
lnv_presentationamounttype.of_getbyitemtype(anv_ratedata.of_getitemtype(), lsa_amounttypes )
lnv_string.of_arraytostring(lsa_amounttypes, ',', ls_amounttypes)

if isnull(il_customerid) or il_customerid = 0 then
	ls_filter = 'ratelinkbillable_billtoid = 0'
else
	ls_filter ='(ratelinkbillable_billtoid = ' + string(il_customerid) + ' or ratelinkbillable_billtoid = 0)'
end if
ls_filter += " and (ratetable_amounttype in (" + ls_amounttypes + ") or isnull(ratetable_amounttype))"
lds_ratenames.SetFilter(ls_Filter)
ll_return = lds_ratenames.Filter()
if lds_ratenames.RowCount() > 0 then

	if lds_ratenames.rowcount() = 0 then
		//open for base table selection
		lstr_Parm.is_Label = "CUSTOMERID"
		lstr_Parm.ia_Value = ll_null
		lnv_Msg.of_Add_Parm (lstr_Parm)
	else
		lstr_Parm.is_Label = "CUSTOMERID"
		lstr_Parm.ia_Value = il_customerid
		lnv_Msg.of_Add_Parm (lstr_Parm)
	end if
	lstr_Parm.is_Label = "DATASOURCE"
	lstr_Parm.ia_Value = lds_ratenames
	lnv_Msg.of_Add_Parm (lstr_Parm)


	lnv_RateTablePres.of_setpresentation( lds_ratenames )
	lnv_presentationamounttype.of_Setpresentation( lds_ratenames )

	//Dan check with scheduler first
	IF not gnv_app.of_runningscheduledtask( ) THEN	
		openwithparm ( lw_ratetable, lnv_msg )
	END IF
	//-----------------------------
	
	lnv_Msg = message.powerobjectparm
	
	if isvalid(lnv_msg) then
		li_MsgCount = 	lnv_msg.of_get_count()
		FOR li_Ndx = 1 to li_MsgCount
			lnv_msg.of_get_parm(li_ndx, lstr_parm)
			
			CHOOSE CASE upper(lstr_parm.is_label)
						
				CASE "NAME"
					ls_ratetablename = lstr_Parm.ia_Value 
					
				CASE "CODENAME"
					ls_codename = lstr_Parm.ia_Value 
					
				CASE "TYPE"
					CHOOSE CASE lstr_Parm.ia_Value 
						CASE "CUSTOMER"
							ib_customertable = true
						CASE ELSE
							ib_customertable = false
					END CHOOSE
									
			END CHOOSE
		NEXT
	end if
	
	if len ( Trim ( ls_ratetablename ) ) = 0 then
		//user cancelled
		lnv_Error = This.AddOFRError ( )
	
		if IsValid ( lnv_Error ) then
			lnv_Error.SetErrorMessage ( "Cancelled" )
		end if

	end if

end if

as_ratetablename = ls_ratetablename
as_codename = ls_codename

if len(ls_ratetablename) > 0 then
	ll_return = 1
else
	ll_return = -1
end if

lds_ratenames.SetFilter('')
lds_ratenames.Filter()

return ll_return

end function

public subroutine of_filterratecache (string as_codename);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_FilterRateCache
//  
//	Access		:public
//
//	Arguments	:as_codename
//
//	Return		:none
//						
//	Description	:Filter the rate table cache to the passed in rate table name.
//					 If the instance setting is for a customer specific table then
//					 include that in the filter.
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


string	ls_filter

if sds_rate.rowcount() > 0 then
	
	if ib_customertable then
		ls_filter = "codename = '" + as_codename + "'" 
	else
			
		ls_filter = "codename = '" + as_codename + "' and customerid = 0"
	end if
	
	sds_rate.setfilter(ls_filter) 
	sds_rate.filter()
end if

end subroutine

public function integer of_getratetablezones (string as_codename, ref string asa_zones[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_Gettablezones
//  
//	Access		:public
//
//	Arguments	:as_codename
//					 asa_zones[] by reference
//
//	Return		:integer
//					-1 = no table match in cache
//					 0 = zoneless tables
//					 > 0 number of entries in array
//						
//	Description	:Pass out an array of origin, destination zones for the rate table.
//				 	 Each element of the array will contain the origin and destination
//				 	seperated by a comma.
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


long	ll_rowcount, &
		ll_ndx
		
integer	li_return

string	ls_origin, &
			ls_destination
			
//n_ds	lds_rate

this.of_filterratecache(as_codename)
//lds_rate = this.of_getratecache(true)
ll_rowcount = sds_rate.rowcount()
if ll_rowcount > 0 then
	for ll_ndx = 1 to ll_rowcount
		ls_origin = sds_rate.object.originzone[ll_ndx]
		ls_destination = sds_rate.object.destzone[ll_ndx]
		asa_zones[upperbound(asa_zones) + 1] = ls_origin + "," + ls_destination
	next
	li_return = upperbound(asa_zones)
else
	li_return = -1 
end if
	
return li_return
end function

private function string of_getbreakunit (string as_codename);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetBreakUnit
//  
//	Access		:public
//
//	Arguments	:as_codename
//
//	Return		:string
//					 the break unit
//						
//	Description	:Get the break unit from passed in rate table. Set to null if not found.
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

string	ls_breakunit

if len(trim(as_codename)) > 0 then

	  SELECT "ratetable"."breakunit"  
		 INTO :ls_breakunit  
		 FROM "ratetable"  
		WHERE "ratetable"."codename" = :as_codename   ;
	
	commit;
	
	choose case sqlca.sqlcode
			
		case 100
			setnull(ls_breakunit)
	
		case 0
			//found unit
			
		case else
			setnull(ls_breakunit)
			
	end choose

else

	setnull(ls_breakunit)
	
end if


return ls_breakunit
end function

protected function integer of_getoriginlocationzones (n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetOriginLocationZones
//  
//	Access		:public
//
//	Arguments	:anva_ratedata[] by reference
//
//	Return		:integer
//					 1 success
//					 -1 failure
//						
//	Description	:Setting instance arrays for the zones found for the
//					 site, zip, state based on the origin on the ratedata object.
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
integer	li_return = 1

string	ls_errormessage

n_cst_OFRError	lnv_error


snv_ZoneManager.of_findzoneforlocation(string(anv_ratedata.of_getoriginid()),snv_zonemanager.ci_locationtype_site, isa_origsite_zone)
snv_ZoneManager.of_findzoneforlocation(anv_ratedata.of_getoriginzip(),snv_zonemanager.ci_locationtype_zip, isa_origzip_zone)
snv_ZoneManager.of_findzoneforlocation(anv_ratedata.of_getoriginstate(),snv_zonemanager.ci_locationtype_state, isa_origstate_zone)

if upperbound(isa_origsite_zone) = 0 and &
	upperbound(isa_origzip_zone) = 0 and &
	upperbound(isa_origstate_zone) = 0 then
	li_return = -1
	ib_originzonesfound = false
	ls_errormessage = "The origin location was not found in any of the defined rating zones."
else
	ib_originzonesfound = true
	ib_NeedToDetermineOrigZones = False //MFS 5/25/07 
end if
	


if li_return = -1 then

	if len (ls_errormessage) > 0 then
		lnv_Error = This.AddOFRError ( )
		if IsValid ( lnv_Error ) then
			lnv_Error.SetErrorMessage ( ls_ErrorMessage )
		end if
	end if
end if

return li_return
end function

protected function integer of_getdestinationlocationzones (n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetDestinationLocationZones
//  
//	Access		:public
//
//	Arguments	:anva_ratedata[] by reference
//
//	Return		:integer
//					 1 success
//					 -1 failure
//						
//	Description	:Setting instance arrays for the zones found for the
//					 site, zip, state based on the destination on the ratedata object.
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
integer	li_return = 1

string	ls_errormessage

n_cst_OFRError	lnv_error


snv_zonemanager.of_findzoneforlocation(string(anv_ratedata.of_getdestinationid()),snv_zonemanager.ci_locationtype_site, isa_destsite_zone)
snv_zonemanager.of_findzoneforlocation(anv_ratedata.of_getdestinationzip(),snv_zonemanager.ci_locationtype_zip, isa_destzip_zone)
snv_zonemanager.of_findzoneforlocation(anv_ratedata.of_getdestinationstate(),snv_zonemanager.ci_locationtype_state, isa_deststate_zone)

if upperbound(isa_destsite_zone) = 0 and &
	upperbound(isa_destzip_zone) = 0 and &
	upperbound(isa_deststate_zone) = 0 then
	li_return = -1
	ib_destzonesfound = false
	ls_errormessage = "The destination location was not found in any of the defined rating zones."
else
	ib_destzonesfound = true
	ib_NeedToDetermineDestZones = False //MFS 5/25/07
end if


if li_return = -1 then

	if len (ls_errormessage) > 0 then
		lnv_Error = This.AddOFRError ( )
		if IsValid ( lnv_Error ) then
			lnv_Error.SetErrorMessage ( ls_ErrorMessage )
		end if
	end if
end if

return li_return
end function

public subroutine of_initialize ();string	lsa_blank[]

isa_origsite_zone = lsa_Blank
isa_origzip_zone = lsa_Blank
isa_origstate_zone = lsa_Blank
isa_destsite_zone = lsa_Blank
isa_destzip_zone = lsa_Blank
isa_deststate_zone = lsa_Blank
il_customerid=0
ib_includenonetype = FALSE
ib_interactivemode = FALSE
ib_customertable = FALSE

end subroutine

public function string of_getratedescription (ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetRateDescription
//  
//	Access		:public
//
//	Arguments	:anv_ratedata by reference
//
//	Return		:string
//					 the rate table description
//						
//	Description	:Call overloaded method with ratecode and billtoid. 
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

string	ls_Description, &
			ls_Codename
			
long		ll_BillToId, &
			ll_Return = 1
			

if ll_Return = 1 then
	ll_BillToId = anv_ratedata.of_GetBillToId()
	if isnull(ll_BillToId) then
		ll_BillToId = 0
	end if

	ls_Codename = anv_ratedata.of_GetCodename()
	if isnull(ls_Codename) or len(trim(ls_Codename)) = 0 then
		ll_Return = -1
	end if
end if

if ll_Return = 1 then
	ls_Description = this.of_GetRatedescription( ls_Codename, ll_BillToId )
	
	if len(trim(ls_Description)) > 0 then
		anv_ratedata.of_SetDescription(ls_Description)
	end if
end if

return ls_Description

end function

public function n_ds of_getratedefaultcache ();
IF NOT IsValid ( sds_rateDefaults ) THEN

	n_cst_Dws	lnv_Dws

	IF lnv_Dws.of_CreateDataStoreByDataObject ( "d_ratedefaults", sds_rateDefaults, TRUE ) = 1 THEN
		sds_rateDefaults.of_SetBase ( TRUE )
	END IF

	sds_rateDefaults.Retrieve()
	commit;
	
END IF

return sds_rateDefaults


end function

public function n_ds of_getratetablenamecache ();
IF NOT IsValid ( sds_ratenames ) THEN

	n_cst_Dws	lnv_Dws

	IF lnv_Dws.of_CreateDataStoreByDataObject ( "d_ratenames", sds_ratenames, TRUE ) = 1 THEN
		sds_ratenames.of_SetBase ( TRUE )
	END IF

	sds_ratenames.Retrieve()
	commit;
END IF

return sds_ratenames
end function

public subroutine of_reverseorigindestination (ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_ReverseOriginDestination
//  
//	Access		:public
//
//	Arguments	:anv_ratedata by reference
//
//	Return		:none
//						
//	Description	:Swap the origin and destination information on the ratedata object.
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//		5-25-07 MFS - Reversed instance arrays for the zones (see below).
//	
//////////////////////////////////////////////////////////////////////////////
//


long		ll_Originid, &
			ll_DestId
			
string	ls_Originzone, &
			ls_OriginState, &
			ls_OriginZip, &
			ls_OriginLocator, &
			ls_DestZone, &
			ls_DestState, &
			ls_DestZip, &
			ls_DestLocator
		
String	lsa_TempSite[]
String	lsa_TempZip[]
String	lsa_TempState[]

ls_Originzone = anv_ratedata.of_GetOriginZone()
ll_Originid = anv_ratedata.of_GetOriginId()
ls_OriginState = anv_ratedata.of_GetOriginState()
ls_OriginZip = anv_ratedata.of_GetOriginZip()
ls_OriginLocator = anv_ratedata.of_GetOriginLocator()

ls_DestZone = anv_ratedata.of_GetDestinationZone()
ll_DestId = anv_ratedata.of_GetDestinationId()
ls_DestState = anv_ratedata.of_GetDestinationState()
ls_DestZip = anv_ratedata.of_GetDestinationZip()
ls_DestLocator = anv_ratedata.of_GetDestinationLocator()

anv_ratedata.of_SetOriginZone(ls_DestZone)
anv_ratedata.of_SetOriginId(ll_DestId)
anv_ratedata.of_SetOriginState(ls_DestState)
anv_ratedata.of_SetOriginZip(ls_DestZip)			
anv_ratedata.of_SetOriginLocator(ls_DestLOcator)			

anv_ratedata.of_SetDestinationZone(ls_Originzone)
anv_ratedata.of_SetDestinationId(ll_Originid)
anv_ratedata.of_SetDestinationState(ls_OriginState)
anv_ratedata.of_SetDestinationZip(ls_OriginZip)
anv_ratedata.of_SetDestinationLocator(ls_OriginLocator)

/*MFS - 5/25/07 - We do not re-initialze the zones for every rate table anymore (see of_autorate comments).
						Therefore we must swap the ones we have stored in order for the reverse search to work
*/ 
lsa_TempSite = isa_Origsite_zone
lsa_TempZip = isa_origzip_zone
lsa_TempState = isa_origstate_zone

isa_origsite_zone = isa_destsite_zone
isa_Origstate_zone = isa_deststate_zone
isa_origzip_zone = isa_destzip_zone

isa_destsite_zone = lsa_TempSite
isa_deststate_zone = lsa_TempState
isa_destzip_zone = lsa_TempZip
/* end 5/25/07 */

end subroutine

public function boolean of_usereversesearch ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_UseReverseSearch
//  
//	Access		:public
//
//	Arguments	:none
//
//	Return		:boolean
//						
//	Description	:Get system setting. This determines if the the origin and destination
//					 should be swapped if a rate table is not found for origin/destination.
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


Integer	li_Return
boolean	lb_reversesearch
any		la_value

n_cst_settings lnv_Settings

li_Return = 1

IF lnv_Settings.of_GetSetting ( 122 , la_value ) <> 1 THEN
	//default
	lb_reversesearch = true
else
	IF STRING ( la_Value ) = "YES!" THEN
		lb_reversesearch = true
	else
		lb_reversesearch = false
	end if
END IF

return lb_reversesearch
end function

public function integer of_getratetablelist (ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetRateTableList
//  
//	Access		:public
//
//	Arguments	:anv_ratedata by reference
//
//	Return		:integer
//						
//	Description	:This will set the rate table search order on the ratedata object
//					 for freight items only.
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


//for freight items only

string	lsa_list[], &
			ls_list, &
			ls_itemeventtype

long		ll_count, &
			ll_BilltoId

any		la_value

n_cst_settings 	lnv_Settings
n_cst_string		lnv_string

ls_itemeventtype = anv_ratedata.of_GetItemEventType()

/*

if len(trim(ls_itemeventtype)) = 0 or isnull(ls_itemeventtype) then
	if anv_ratedata.of_GetItemType() = n_cst_constants.cs_itemtype_freight then
		ll_BilltoId = anv_Ratedata.of_GetBilltoId()
		
		ll_Count = THIS.of_GetCodeDefaultList ( ll_BillToID , cl_itemfreight_list , lsa_list )
		lnv_String.of_ArrayToString ( lsa_List , ',' , ls_List )

		if ll_count > 0 then
			anv_ratedata.of_SetCodenameSearchOrder(lsa_list)
			anv_ratedata.of_SetCodenameSearchOrder(ls_list)
		end if

	end if
else
	this.of_GetRatetableByEventType(anv_ratedata, ls_itemeventtype)										 	
end if
 
 
 I am commenting this code and replacing it with the code to follow. The reason is because Items marked as Imported Freight 
 were being thrown into the of_GetRatetableByEventType method and that was not coming back with meaningful results. 
 Therfor I am going to explicitly look for the 3 flags that the of_GetRateByEventType is currently responding to and If I find
 it I am going to send it in, if not I am going to treat it as a normal Item
 
 Note: I am not changing what this method is possibly returning, even though there seems to be a big hole with ll_count
 
 
*/

IF ls_itemeventtype = n_cst_constants.cs_ItemEventType_FrontChassisSplit OR &
	ls_itemeventtype =  n_cst_constants.cs_ItemEventType_BackChassisSplit OR &
	ls_itemeventtype =  n_cst_constants.cs_ItemEventType_StopOff OR &
	ls_itemeventtype =  n_cst_constants.cs_ItemEventType_Bobtail THEN

	this.of_GetRatetableByEventType(anv_ratedata, ls_itemeventtype)
	
ELSE
	
	if anv_ratedata.of_GetItemType() = n_cst_constants.cs_itemtype_freight then
		ll_BilltoId = anv_Ratedata.of_GetBilltoId()
		
		ll_Count = THIS.of_GetCodeDefaultList ( ll_BillToID , cl_itemfreight_list , lsa_list )
		lnv_String.of_ArrayToString ( lsa_List , ',' , ls_List )

		if ll_count > 0 then
			anv_ratedata.of_SetCodenameSearchOrder(lsa_list)
			anv_ratedata.of_SetCodenameSearchOrder(ls_list)
		end if

	end if
	

	
END IF
	






return ll_count

end function

public function integer of_calculate (ref n_cst_ratedata anv_ratedata, boolean ab_reversesearch);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_calculate
//  
//	Access		:public
//
//	Arguments	:anva_ratedata[] by reference
//					 ab_reversesearch
//
//	Return		:integer
//					 1 got a charge
//					 0 no charge
//					 -1 error
//						
//	Description	:Try finding a rate table for the origin/destination.
//					If not found then reverse them if set in the system setting.
//					If not found by zone then look for a zoneless table.
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

integer	li_Return = 1
string	ls_errormessage, &
			ls_originzone, &
			ls_destzone
boolean	lb_LookForZoneless
n_cst_ofrerror	lnv_error

//retrieve rows into the cache based on what we have for properties on ratedata
this.of_Cache( anv_Ratedata )
this.of_FilterCache(anv_RateData, true)

this.of_GetRateDescription(anv_Ratedata)
this.of_GetAmountType(anv_Ratedata)
this.of_getamountitemtype(anv_Ratedata)

//origin/destination info on ratedata objects already set
if this.of_getorigindestinationzone( anv_Ratedata ) = 1 then
	This.ClearOFRErrors ( )
	if this.of_settotalcharge( anv_Ratedata, true, ls_errormessage ) < 1 then
		if Len ( ls_ErrorMessage ) > 0 then			
			lnv_Error = This.AddOFRError ( )				
			if IsValid ( lnv_Error ) then
				lnv_Error.SetErrorMessage ( ls_ErrorMessage )
			end if			
		end if
		li_return = -1
	end if

else
	//try reverse zone search
	if ab_ReverseSearch then
		anv_Ratedata.of_SetReverseZoneSearch(ab_ReverseSearch)
		//reverse origin and dest zones
		this.of_ReverseOriginDestination(anv_Ratedata)	
		this.of_FilterCache(anv_RateData, true)

		This.ClearOFRErrors ( )
		if this.of_getorigindestinationzone( anv_Ratedata ) = 1 then
			This.ClearOFRErrors ( )
			this.of_settotalcharge( anv_Ratedata, true, ls_errormessage )
			lb_LookForZoneless = false
		else
			lb_LookForZoneless = true
		end if
		//set zones back
		this.of_ReverseOriginDestination(anv_Ratedata)	
		this.of_FilterCache(anv_RateData, true)

	else
		lb_LookForZoneless = true
	end if
		
	if lb_LookForZoneless then
		//look for a rate table with a matching rate code that has no
		//origin/dest zones associated with it
		this.of_FilterCache(anv_RateData, false)
		if this.of_settotalcharge( anv_Ratedata, false, ls_errormessage ) < 1 then
				//reset errors and add new error
				This.ClearOFRErrors ( )
				if Len ( ls_ErrorMessage ) > 0 then			
					lnv_Error = This.AddOFRError ( )				
					if IsValid ( lnv_Error ) then
						lnv_Error.SetErrorMessage ( ls_ErrorMessage )
					end if			
				end if
			li_return = -1
		end if
	end if

end if

if li_return = 1 then
	//commenting this to see if a zero rate can be passed out
//	if anv_Ratedata.of_GetTotalCharge() = 0 then
//		li_return = 0
//	else
//		//we got a rate, clear the errors
		This.ClearOFRErrors ( )
//	end if
end if

return li_return
end function

public function integer of_autorate (n_cst_beo_shipment anv_shipment, n_cst_beo_item anva_item[], ref n_cst_ratedata anva_ratedata[], integer ai_category);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_autorate
//  
//	Access		:public
//
//	Arguments	:anv_shipment
//					 anva_item[]
//					 anva_ratedata[] by reference
//					 ai_category	`	billable or payables
//
//	Return		:integer
//						
//	Description	:
//
//			This method will populate the ratedata object with the appropriate data
//			from the shipment and the items. The ratedata will then be passed	on to 
//			the overloaded fuction.
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

integer	li_return = 1

long		ll_ndx, &
			ll_max, &
			ll_shipmentcount, &
			ll_rowcount, &
			ll_origin, &
			ll_destination
			
string	ls_errormessage, &
			ls_ratetablename

n_cst_ratedata			lnva_ratedata[]
n_cst_OFRError	lnv_Error
n_cst_events	lnv_Events
n_cst_beo_shipment	lnva_shipment[]

lnva_shipment[1] = anv_shipment
lnva_ratedata = anva_ratedata

//checking for at least one valid shipment and using it to set billtoid as customer
//when looking for rate tables

if ai_category = n_cst_constants.ci_category_payables then
	//don't check license
else
	if this.of_hasAutorate ( ) then
		li_return = 1
	else
		li_return = -1
	end if
end if

if li_return = 1 then
	IF isvalid(lnva_shipment[1]) then
		
		//this will create a rate data object
		this.of_settotalitemcount(anva_item, lnva_shipment[1], lnva_ratedata)
	
		//set billto id as customer for rate table information
		this.of_setcustomerid(lnva_shipment[1])
		ll_max = upperbound(lnva_ratedata)
		for ll_ndx = 1 to ll_max
			lnva_ratedata[ll_ndx].of_setbilltoid(il_customerid)
			lnva_ratedata[ll_ndx].of_setcategory(ai_category)
		next
		choose case ai_category
			case n_cst_constants.ci_category_receivables
				this.of_autorate(lnva_ratedata, false /*show picklist*/)
//				this.of_autorate(lnva_ratedata, true /*show picklist*/)
			case n_cst_constants.ci_category_payables
				this.of_autorate(lnva_ratedata, false /*show picklist*/)
			case else
				this.of_autorate(lnva_ratedata, true /*show picklist*/)
		end choose
	
	end if

	anva_ratedata = lnva_ratedata

end if

return li_return
end function

public function boolean of_iscodenamedefault (string as_codename, ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_isCodeNameDefault
//  
//	Access		:public
//
//	Arguments	:as_codename
//					 anv_ratedata by reference
//
//	Return		:boolean
//						
//	Description	:Search the company and system code search list for the as_codename.
//					 If the code was not found in the list then set the ratedata object
//					 and return false.
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

long	ll_ndx, &
		ll_count
		
string	lsa_list[]

boolean	lb_found

ll_count = anv_ratedata.of_GetCodenameSearchOrder(lsa_list)

for ll_ndx = 1 to ll_count
	if lsa_list[ll_ndx] = as_codename then
		lb_found = true
		exit
	end if
next

//set object property
anv_ratedata.of_SetCodenamedefault(lb_found)

return lb_found
end function

public subroutine of_destroycache ();//rate cache
if isvalid(sds_rate) then
	destroy sds_rate
end if
//zone cache
if isvalid(snv_zonemanager) then
	destroy snv_zonemanager
end if
//ratedefault cache
if isvalid(sds_rateDefaults) then
	destroy sds_rateDefaults
end if
//ratename cache
if isvalid(sds_ratenames) then
	destroy sds_ratenames
end if

end subroutine

public function long of_filtercache (n_cst_ratedata anv_ratedata, boolean ab_zones);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_FilterCache
//  
//	Access		:public
//
//	Arguments	:anv_ratedata
//					 ab_zones
//
//	Return		:long
//						
//	Description	:Filter the rate table based on the parameters in the 
//					 ratedata object.
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
long		ll_billtoid, &
			ll_CacheCount

string	ls_filter, &
			ls_codename

ls_codename = anv_ratedata.of_GetCodename() 
ls_filter += "codename = '" + ls_codename + "'"
ll_BilltoId = anv_ratedata.of_GetBilltoId()
if isnull(ll_BilltoId) or ll_BilltoId = 0 then
	ls_filter += " and billtoid = 0"
else
	ls_filter += " and (billtoid = " + string(ll_billtoid) + " or billtoid = 0)"
end if

if ab_zones then
	if len(trim(anv_ratedata.of_GetOriginZone())) > 0 then
		ls_filter += ' and originzone = ' + "'" + anv_ratedata.of_GetOriginZone() + "'"
	end if
	
	if len(trim(anv_ratedata.of_GetDestinationZone())) > 0 then
		ls_filter += ' and destzone = ' + "'" + anv_ratedata.of_GetDestinationZone() + "'"
	end if
else
	ls_filter += ' and isnull(originzone) and isnull(destzone)' 
end if

ls_filter += " and category = " + string(anv_ratedata.of_GetCategory())


sds_rate.Setfilter(ls_filter)
sds_rate.filter()

sds_rate.SetSort("destzone A, Ratebreak A")
sds_rate.Sort()

return sds_rate.rowcount()

end function

private subroutine of_getamountitemtype (ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetAmountItemType
//  
//	Access		:private
//
//	Arguments	:anv_ratedata by reference
//
//	Return		:none
//						
//	Description	:Set the Itemtype (freight or accessorial) on the ratedata object
//					 based on the amount type on the ratedata object.
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
long		ll_ndx, &
			ll_Arraycount, &
			ll_AmountType
string	lsa_Freighttypes[], &
			lsa_AccessTypes[], &
			ls_itemtype
			
n_cst_presentation_AmountType		lnv_Amounttype
lnv_Amounttype.of_getbyitemtype(n_cst_constants.cs_itemtype_freight, lsa_Freighttypes )
lnv_Amounttype.of_getbyitemtype(n_cst_constants.cs_itemtype_Accessorial, lsa_AccessTypes )

ll_AmountType = anv_ratedata.of_GetAmountType()

ll_arraycount = upperbound(lsa_freighttypes)
for ll_ndx = 1 to ll_Arraycount
	if string(ll_amounttype) = lsa_freighttypes[ll_ndx] then
		ls_itemtype = n_cst_constants.cs_itemtype_freight
		exit
	end if
next

if len(ls_itemtype) = 0 then
	ll_ArrayCount = upperbound(lsa_AccessTypes)
	for ll_ndx = 1 to ll_ArrayCount
		if string(ll_AmountType) = lsa_AccessTypes[ll_ndx] then
			ls_itemtype = n_cst_constants.cs_itemtype_Accessorial
			exit
		end if
	next
end if

if len(ls_itemtype) > 0 then
	anv_ratedata.of_SetItemType(ls_itemtype)
end if
end subroutine

public subroutine of_setorigin (n_cst_beo_shipment anv_shipment, ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetOrigin
//  
//	Access		:public
//
//	Arguments	:anv_shipment
//					 anv_ratedata by reference
//
//	Return		:none
//						
//	Description	:Get the a destination company object from the shipment 
//					 and call the overloaded method.
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

long	ll_ndx, &
		ll_ratecount
n_cst_beo_company	lnv_company

IF IsValid ( anv_Shipment ) THEN
	anv_shipment.of_getorigin(lnv_company,true)
	if isvalid(lnv_Company) then
		this.of_SetOrigin(lnv_Company, anv_ratedata)
	end if
END IF

DESTROY lnv_Company
end subroutine

private subroutine of_setorigin (n_cst_beo_company anv_company, ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetOrigin
//  
//	Access		:private
//
//	Arguments	:anv_company
//					 anv_ratedata by reference
//
//	Return		:none
//						
//	Description	:set the site, state, zip and pcm locator on the ratedata object.
//					 If there is no zip code then try to get it from the pcm locator.
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
string	ls_zip, &
			ls_locator
			
IF IsValid ( anv_Company ) THEN
	if isvalid(anv_ratedata) then
		anv_ratedata.of_setoriginid(anv_company.of_getid())
		anv_ratedata.of_setoriginstate(anv_company.of_getstate())
		ls_locator = anv_company.of_getpcm()
		anv_ratedata.of_setoriginlocator(ls_locator)
		ls_zip = anv_company.of_getzip()
		if len(trim(ls_zip)) > 0 then
			//zip ok
		else
			//try to get from pcm locator
			n_cst_LicenseManager	lnv_LicenseManager
			if lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler ) then
				if lnv_LicenseManager.of_usepcmilerstreets() then
					//locator is latlong, we have no zipcode
				else
					if Match(left(ls_locator,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
						//canadian postal
						ls_zip = left(ls_locator,7)
					else
						if isnumber ( left ( ls_locator, 1) ) then
							ls_zip = left ( ls_locator,5 ) 
						end if
					end if
				end if
			end if
		end if
		anv_ratedata.of_setoriginzip(ls_zip)
	end if
END IF

end subroutine

private subroutine of_setdestination (n_cst_beo_company anv_company, ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetDestination
//  
//	Access		:private
//
//	Arguments	:anv_company
//					 anv_ratedata by reference
//
//	Return		:none
//						
//	Description	:set the site, state, zip and pcm locator on the ratedata object.
//					 If there is no zip code then try to get it from the pcm locator.
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

string	ls_zip, &
			ls_locator
			
IF IsValid ( anv_Company ) THEN
	if isvalid(anv_ratedata) then
		anv_ratedata.of_setdestinationid(anv_company.of_getid())
		anv_ratedata.of_setdestinationstate(anv_company.of_getstate())	
		ls_locator = anv_company.of_getpcm()
		anv_ratedata.of_setdestinationlocator(ls_locator)	
		ls_zip = anv_company.of_getzip()
		if len(trim(ls_zip)) > 0 then
			//zip ok
		else
			//try to get from pcm locator
			n_cst_LicenseManager	lnv_LicenseManager
			if lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler ) then
				if lnv_LicenseManager.of_usepcmilerstreets() then
					//locator is latlong, we have no zipcode
				else
					if Match(left(ls_locator,7), "^[A-Za-z][0-9][A-Za-z][ ][0-9][A-Za-z][0-9]$") then
						//canadian postal
						ls_zip = left(ls_locator,7)
					else
						if isnumber ( left ( ls_locator, 1) ) then
							ls_zip = left ( ls_locator,5 ) 
						end if
					end if
				end if
			end if
		end if
		anv_ratedata.of_setdestinationzip(ls_zip)	
	end if
END IF


end subroutine

public subroutine of_setdestination (n_cst_beo_shipment anv_shipment, ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetDestination
//  
//	Access		:public
//
//	Arguments	:anv_shipment
//					 anv_ratedata by reference
//
//	Return		:none
//						
//	Description	:Get the a destination company object from the shipment 
//					 and call the overloaded method.
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

long	ll_ndx, &
		ll_ratecount
n_cst_beo_company	lnv_company

IF isValid ( anv_Shipment ) THEN
	anv_shipment.of_getdestination(lnv_company,true)
	IF isValid ( lnv_Company ) THEN
		this.of_SetDestination(lnv_Company, anv_ratedata)
	END IF
END IF

DESTROY 	lnv_Company

end subroutine

public function long of_setitemsource (n_cst_beo_shipment anva_shipment[], ref n_cst_beo_item anva_item[], boolean ab_combinedfreight);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetItemSource
//  
//	Access		:public
//
//	Arguments	:anva_shipment[]
//					 anva_item[] be reference
//					 ab_combinedfreight
//
//	Return		:long
//						
//	Description	:Get all the items from the shipment .
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
long	ll_shipcount, &
		ll_itemcount, &
		ll_beocount, &
		ll_ndx, &
		ll_ndx2
		
n_cst_beo_item		lnva_item[], &
						lnva_empty[]

ll_shipcount=upperbound(anva_shipment)

for ll_ndx = 1 to ll_shipcount

	if isvalid(anva_shipment[ll_ndx]) then
		//ok
	else
		continue
	end if
	lnva_item = lnva_empty
	ll_itemcount = anva_shipment[ll_ndx].of_GetItemlist ( lnva_item )
	for ll_ndx2 = 1 to ll_itemcount
		//n_cst_constants.cs_ItemType_Freight
		//n_cst_constants.cs_ItemType_Accessorial
		if	ab_combinedfreight then
			if lnva_item[ll_ndx2].of_gettype() = n_cst_constants.cs_ItemType_Freight then
				
				// added this becaus the apply freight rate skips the custom rates when applying 
				// the freight rate. therefore we do not want to add up the amounts of custom items
				// if we are not applying the combined rate to them
				IF lnva_item[ll_ndx2].of_getRatecodename( ) = "CUSTOM" THEN
					DESTROY lnva_item[ll_ndx2]
					CONTINUE
				END IF
				
				
			//if ratetype = none then we still get the item and set the ratetype based on
			//the rateunit in the rate table selected
				ll_beocount = upperbound(anva_item) + 1
				anva_item[ll_beocount] = lnva_item[ll_ndx2]
			else
				destroy lnva_item[ll_ndx2]
			end if
		else
			ll_beocount = upperbound(anva_item) + 1
			anva_item[ll_beocount] = lnva_item[ll_ndx2]			
		end if
	next
	
next

return upperbound(anva_item)
end function

public function integer of_autorate (n_cst_beo_shipment anva_shipment[], ref n_cst_ratedata anva_ratedata[], integer ai_category, boolean ab_combinedfreight);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_autorate
//  
//	Access		:public
//
//	Arguments	:anv_shipment
//					 anva_ratedata[] by reference
//					 ai_category
//					 ab_combinedfreight
//
//	Return		:integer
//						
//
//	Description	:
//
//			This method will get all the items from the shipments and populate the
//			ratedata object.  The ratedata will then be passed	on to 
//			the overloaded fuction.
//
//			It is assumed that the biiltoid, origin, and destination of the shipments being
//			passed to this method are all the same. There is no validation to verify that.
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

integer	li_return = 1

long		ll_ndx, &
			ll_max, &
			ll_shipmentcount, &
			ll_rowcount
string	ls_errormessage, &
			ls_ratetablename
boolean	lb_showpicklist

n_cst_OFRError	lnv_Error
n_cst_beo_item			lnva_item[]
n_cst_ratedata			lnva_ratedata[]
n_cst_AnyArraySrv		lnv_ArraySrv

ll_shipmentcount = upperbound(anva_shipment)
lnva_ratedata = anva_ratedata

//n_cst_beo_company lnv_company
if ai_category = n_cst_constants.ci_category_payables then
	//don't check license
else
	
	if this.of_hasAutorate ( ) then
		li_return = 1
	else
		li_return = -1
	end if
end if

if li_return = 1 then

	IF isvalid(anva_shipment[1]) then
		
	//i don't think we need this
	//	this.of_searchfornonetype(anva_shipment)
	
		//get freight item beos only
		//this gets all items for all shipments
		if this.of_setitemsource(anva_shipment, lnva_item, ab_combinedfreight ) = 0 then
			li_return = -1
			ls_errormessage = "There are no items to rate."
		end if
	
		if li_return = 1 then
			//create rate data objects for all of the different item rate types
			if ab_combinedfreight then
				this.of_setcombineditems(lnva_item, lnva_ratedata)
				ll_max = upperbound(lnva_ratedata)
				for ll_ndx = 1 to ll_max
					this.of_setorigin(anva_shipment[1], lnva_ratedata[ll_ndx])
					this.of_setdestination(anva_shipment[1], lnva_ratedata[ll_ndx])
					lnva_ratedata[ll_ndx].of_Setcombinedrate( true )
				next
				lb_showpicklist=true
			else
				this.of_settotalitemcount(lnva_item, anva_shipment[1], lnva_ratedata)
				//origin and dest were set in previous method
				lb_showpicklist=false
			end if
			
		end if
	
		//set billto id as customer for rate table information
		this.of_setcustomerid(anva_shipment[1])
		ll_max = upperbound(lnva_ratedata)
		for ll_ndx = 1 to ll_max
			lnva_ratedata[ll_ndx].of_setbilltoid(il_customerid)
			lnva_ratedata[ll_ndx].of_setcategory(ai_category)
		next
			
		this.of_autorate(lnva_ratedata, lb_showpicklist)
		
	end if
	anva_ratedata = lnva_ratedata
end if

if li_return = -1 then
	if Len ( ls_ErrorMessage ) > 0 then

		lnv_Error = This.AddOFRError ( )
	
		if IsValid ( lnv_Error ) then
			lnv_Error.SetErrorMessage ( ls_ErrorMessage )
		end if

	end if
end if

lnv_ArraySrv.of_Destroy ( lnva_item )

return li_return
end function

public subroutine of_setcombineditems (n_cst_beo_item anva_item[], ref n_cst_ratedata anva_ratedata[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetCombinedItems
//  
//	Access		:public
//
//	Arguments	:anva_item,
//					 anva_ratedata by reference
//
//	Return		:none
//						
//	Description	:Used when checking rate breaks based on combined amounts ie add all weight,
//					 all miles, all quantities
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

integer	li_return

decimal	lc_value, &
			lc_miles, &
			lc_quantity, &
			lc_weight
			
long		ll_itemcount, &
			ll_ndx
			
ll_itemcount = upperbound(anva_item)

for ll_ndx = 1 to ll_itemcount
	
	//Not allowing for more than one rate data object
	if upperbound(anva_ratedata) > 0 then
		if isvalid(anva_ratedata[1]) then
		//already created
		else
			anva_ratedata[1] = Create n_cst_RateData
		end if
	else
		anva_ratedata[1] = Create n_cst_RateData
	end if

	if ll_ndx = 1 then
		anva_ratedata[1].of_setitemtype(anva_item[ll_ndx].of_gettype())
		anva_ratedata[1].of_setAmounttype(anva_item[ll_ndx].of_getAmounttype())
		anva_ratedata[1].of_setCodename(anva_item[ll_ndx].of_GetRateCodename())
		anva_ratedata[1].of_SetItemEventType(anva_item[ll_ndx].of_getEventTypeFlag()) //nwl 6/28
		
	end if

//	anva_ratedata[1].of_setreplacenonetype(ib_includenonetype)
		
	lc_weight = anva_item[ll_ndx].of_gettotalweight()
	lc_quantity = anva_item[ll_ndx].of_getquantity()
	lc_miles = anva_item[ll_ndx].of_getmiles()

	anva_ratedata[1].of_settotalquantity(lc_quantity + anva_ratedata[1].of_gettotalquantity())
	anva_ratedata[1].of_settotalweight(lc_weight + anva_ratedata[1].of_gettotalweight())
	anva_ratedata[1].of_settotalmiles(lc_miles + anva_ratedata[1].of_gettotalmiles())


next



end subroutine

public subroutine of_autorate (ref n_cst_ratedata anva_ratedata[], boolean ab_showpicklist);
///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_autorate
//  
//	Access		:public
//
//	Arguments	:anva_ratedata[] by reference
//					 ab_showpicklist
//
//	Return		:none
//						
//	Description	:Using the code search set on the ratedata object look for the 
//					rate table and set the rate and charge on the ratedata object.
//
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	2-27-07 BKW  Changes to allow code subtitution processing for accessorial payables
//	3-18-07 BKW  Added condition to prevent code substitution processing for CUSTOM accessorials
// 5-25-07 MFS  Reduced the number of times we initialize the Orig/Dest site/zip/sate insatnce arrays
//					 for performance reasons. We should only be doing this once for every ratedata that has a
//					 unique orig/dest combination (Not once for every rate codename).
//	
//////////////////////////////////////////////////////////////////////////////
//

integer	li_return = 1

long		ll_ratedatacount, &
			ll_ndx, &
			ll_Codendx, &
			ll_Codecount, &
			ll_found, &
			ll_null

string	ls_errormessage, &
			ls_ratetablename, &
			ls_list, &
			ls_codename, &
			ls_test, &
			ls_originzone, &
			ls_destzone, &
			lsa_codename[], &
			lsa_blank[]
			
boolean	lb_reversesearch, &
			lb_codenamespecified, &
			lb_tablefound
			
n_cst_OFRError		lnv_Error
n_cst_AnyArraySrv	lnv_ArraySrv
n_cst_ratedata		lnva_ratedata[]

setnull(ll_null)

ll_ratedatacount = upperbound(anva_ratedata)
lnva_ratedata = anva_ratedata

//this was replaced with setting based on category nwl
//lb_reversesearch = this.of_UseReverseSearch()

//MFS 5/25/07 - lets re-determine the zones for every autorate for now
ib_NeedToDetermineOrigZones = True
ib_NeedToDetermineDestZones = True 

for ll_ndx = 1 to ll_ratedatacount
	
	if lnva_ratedata[ll_ndx].of_GetCategory() = n_cst_constants.ci_category_payables then
		lb_reversesearch = this.of_UseReverseSearchforSettlements()
	else
		lb_reversesearch = this.of_UseReverseSearch()
	end if

	ls_codename = ''
	lsa_codename = lsa_blank
	ls_ratetablename = ''

	//set billto id as customer for rate table information
	il_customerid = lnva_ratedata[ll_ndx].of_getbilltoid()
	ls_ratetablename = lnva_ratedata[ll_ndx].of_GetRateTableName()
	ls_codename = lnva_ratedata[ll_ndx].of_GetCodeName()
	if lnva_ratedata[ll_ndx].of_IsSearchOrderSet() then
		//searchorder is only used for freight items -- NOT ANYMORE 2-27-07 BKW (see next ELSEIF and comment)
		CHOOSE CASE lnva_ratedata[ll_ndx].of_getItemType ( )	
			CASE n_cst_constants.cs_itemtype_freight
				ls_codename = ''

			//The following condition was added 2-27-07 BKW in order to enables payable code subtitutions for accessorials
			//It is not clear whether it would be a problem and/or useful to enalbe code substitutions for 
			//all accessorials, including receivables.  We are restricting it to payables for now to minimize the potential
			//scope of impact of this emergency change.
			CASE n_cst_Constants.cs_ItemType_Accessorial
				IF lnva_RateData [ ll_Ndx ].of_GetCategory ( ) = n_cst_Constants.ci_Category_Payables THEN
					IF Upper ( ls_Codename ) <> 'CUSTOM' THEN  //Condition added 3-18-07 BKW to avoid paying custom accessorials
						ls_Codename = ''
					END IF
				END IF
		END CHOOSE
	end if
	//do we already have a search list
	ls_list = lnva_ratedata[ll_ndx].of_GetCodenameSearchOrder()
	if len(trim(ls_list)) = 0 or isnull(ls_list) then
		//set default search list
		this.of_GetRatetableList(lnva_ratedata[ll_ndx])
	end if
	
	// if condition added by Rick And Norm on Phone 6/13/03
	IF lnva_ratedata[ll_ndx].of_getItemType ( ) = n_cst_constants.cs_itemtype_freight THEN	
		if this.of_recalculate() then
			choose case this.of_getWhatChanged()
				case appeon_constant.cs_Action_ChangedBillto		//, & appeon_constant.cs_Action_ChangedOrigin, & appeon_constant.cs_Action_ChangedDestination
					//start clean through order list
					
					
					// I am not going to clear the codename if the item is an 
					// auto created Item
					
					IF lnva_ratedata[ll_ndx].of_getitemeventtype( ) =  n_cst_constants.cs_itemeventtype_MoveAccessorial THEN
						// Don't Clear it
					ELSE			
						ls_codename = ''   // THIS was the only line of code in the case condition prior to the 
												//  change for 4.0.37
					END IF
						
				case appeon_constant.cs_Action_ChangedCodename 
					
			end choose
		end if
	END IF
	
	if len(trim(ls_Codename)) = 0 then
		lb_codenamespecified = false
		//if a codename wasn't specified then check default list
		lnva_ratedata[ll_ndx].of_GetCodenameSearchOrder(lsa_codename)

		if upperbound(lsa_Codename) = 0 then	
			
			if not ab_showpicklist then
				
				IF lnva_RateData [ ll_Ndx ].of_GetCategory ( ) = n_cst_Constants.ci_Category_Payables THEN
					
					//Condition added 2-27-07 BKW.  Since parms have not authorized show picklist, 
					//don't authorize picklist based on Rating system setting if we are rating payables.
					//Because no context info is avail during settlements, the popup doesn't make sense there.
					//So -- do nothing.
					
				ELSE
				
					//check system setting for showing list
					n_cst_setting_ShowBillRateCodeList	lnv_ShowLIst
					
					lnv_ShowLIst = CREATE n_cst_setting_ShowBillRateCodeList
					IF lnv_ShowLIst.of_getvalue( ) = lnv_ShowLIst.cs_yes THEN
						ab_showpicklist = TRUE
					ELSE
						ab_showpicklist = FALSE
					END IF
					
					DESTROY ( lnv_ShowLIst )
					
				END IF
				
			end if
			
			//present a picklist
			if ab_showpicklist then
				if this.of_getratetablename(lnva_ratedata[ll_ndx], ls_ratetablename, ls_codename) = -1 then
					//no rate table, exit
					li_return = -1//was commented
				else
					//set table information on rate data objects
					lnva_ratedata[ll_ndx].of_setratetablename(ls_ratetablename)

					lnva_ratedata[ll_ndx].of_setcodename(ls_codename)
					lsa_Codename[1] = ls_codename
				end if
			end if
		end if
	else
		//is specified codename different from default list, freight items only
		if lnva_Ratedata[ll_ndx].of_GetItemType() = n_cst_constants.cs_ItemType_Freight then
			this.of_IsCodenameDefault(ls_Codename, lnva_Ratedata[ll_ndx])
		end if
		lb_codenamespecified = true
		lsa_Codename[1] = ls_Codename
	end if
	
	/* MFS - 5/25/07 - Determine if we need to re-initialize the zone instance arrays (Once per ratedata obj AT MOST!)*/
	IF ll_ndx - 1 > 0 THEN
		IF lnva_ratedata[ll_ndx].of_getoriginid ()  = lnva_ratedata[ll_ndx - 1].of_getoriginid ( ) AND &
			lnva_ratedata[ll_ndx].of_getDestinationId ( )  = lnva_ratedata[ll_ndx - 1].of_getDestinationID ( ) AND &
			lnva_ratedata[ll_ndx].of_getBillToID ( )  = lnva_ratedata[ll_ndx - 1].of_getBillToID ( )  THEN
			// there is no need to re-initialize the zones again.
			
		ELSE
			//force of_getorigindestinationzone to find the zones
			ib_NeedToDetermineDestZones = True
			ib_NeedToDetermineOrigZones = True
			isa_origsite_zone = lsa_Blank
			isa_origzip_zone = lsa_Blank
			isa_origstate_zone = lsa_Blank
			isa_destsite_zone = lsa_Blank
			isa_destzip_zone = lsa_Blank
			isa_deststate_zone = lsa_Blank
		END IF
	END IF
	/*end 5/25/07*/
	
	ll_CodeCount = upperbound(lsa_Codename)
	for ll_Codendx = 1 to ll_CodeCount
		
//		I commented this b.c. it was causing ass items to have their rates cleared. <<*>>
//		if lsa_Codename[ll_Codendx] = 'CUSTOM' THEN
//			CONTINUE
//		end if

		/*MFS - 5/25/07 - commented out and moved above for loop for performance reasons.
				  We do not want to re-initailize the zones for every rate table. 
		isa_origsite_zone = lsa_Blank
		isa_origzip_zone = lsa_Blank
		isa_origstate_zone = lsa_Blank
		isa_destsite_zone = lsa_Blank
		isa_destzip_zone = lsa_Blank
		isa_deststate_zone = lsa_Blank
		*/
		
		lnva_ratedata[ll_ndx].of_SetCodename(lsa_Codename[ll_Codendx])
		lnva_ratedata[ll_ndx].of_SetAmounttype(0)  //force a reset of amounttype in of_calculate
		if this.of_calculate(lnva_ratedata[ll_ndx], lb_reversesearch) = 1 then
			lb_tablefound = true
			exit //a rate table was found, stop search
		else
			lnva_ratedata[ll_ndx].of_setratetablename('')
			lnva_ratedata[ll_ndx].of_SetCodename('')
		end if	
	next
	if lb_tablefound then
		//no need for fallback
	else
		//FALLBACK IS REGULAR FREIGHT ONLY
		if lnva_Ratedata[ll_ndx].of_GetItemType() = n_cst_constants.cs_ItemType_Freight then
			choose case lnva_Ratedata[ll_ndx].of_GetItemEventType()
				case n_cst_constants.cs_ItemEventType_FrontChassisSplit, &
					  n_cst_constants.cs_ItemEventType_BackChassisSplit, &
					  n_cst_constants.cs_ItemEventType_StopOff, &
					  n_cst_constants.cs_ItemEventType_Bobtail
					  
					  //don't use fallback
				case else
					lnva_ratedata[ll_ndx].of_setratetablename('')
					lnva_ratedata[ll_ndx].of_SetCodename('')
					//see if there is a fallback code and use that
					if lnva_ratedata[ll_ndx].of_getFallback() then
						if this.of_calculate(lnva_ratedata[ll_ndx], lb_reversesearch) = 1 then
							lnva_ratedata[ll_ndx].of_SetUsedFallback(true)
							exit //a rate table was found, stop search
						else
							//if table wasn't found for orig/dest
							ls_originzone = lnva_ratedata[ll_ndx].of_GetOriginZone()
							ls_destzone = lnva_ratedata[ll_ndx].of_GetDestinationZone()
							if isnull(ls_originzone) or len(trim(ls_originzone)) = 0 or &
								isnull(ls_destzone) or len(trim(ls_destzone)) = 0 then
								if lb_codenamespecified then
									choose case lnva_ratedata[ll_ndx].of_GetItemType()
										case n_cst_constants.cs_ItemType_Accessorial
											lnva_ratedata[ll_ndx].of_SetCodename('CUSTOM')
											This.ClearOFRErrors ( )
										case n_cst_constants.cs_ItemType_Freight
									end choose
								end if
							end if	
						end if
					end if					
			end choose			
		end if
		
	end if
	//if there was a problem rating one item then none of the items will be rated
	if this.GetErrorCount() > 0 then
		exit
		li_return = -1
	end if

next

if li_return = 1 then
	//no errors modify last used date
	for ll_ndx = 1 to ll_ratedatacount
		lnva_ratedata[ll_ndx].of_SetLastUsedDate(Today())
	next
	anva_ratedata = lnva_ratedata
end if

end subroutine

public subroutine of_setrecalculate (boolean ab_set);ib_recalculate = ab_set
end subroutine

public function boolean of_recalculate ();return ib_recalculate
end function

public subroutine of_getratetablebyeventtype (ref n_cst_ratedata anv_ratedata, string as_eventtype);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetRateTableByEventType
//  
//	Access		:public
//
//	Arguments	:anv_ratedata by reference
//					 as_eventtype
//
//	Return		:none
//						
//	Description	:This will set the rate table search order on the ratedata object
//					 based on the event type. It will first look to see if there is 
//					 a billto specific search list and then add the system search 
//					 to the end of that list.
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

any		la_value
long		ll_count, &
			ll_systemid, &
			ll_billtoid
string	ls_list, &
			lsa_list[]

n_cst_settings 	lnv_Settings
n_cst_string		lnv_string

// NOTE: IF you add a case to the Choose Case statement here you will need to add it 
// to of_getRateTableList ( )


choose case as_eventtype
	
	case n_cst_constants.cs_ItemEventType_FrontChassisSplit, n_cst_constants.cs_ItemEventType_BackChassisSplit
		ll_systemid = 124
		
	case n_cst_constants.cs_ItemEventType_StopOff
		ll_systemid = 125
	
	CASE n_cst_constants.cs_ItemEventType_Bobtail
		ll_Systemid = 254
	
end choose
	
ll_BilltoId = anv_Ratedata.of_GetBilltoId()

IF ll_BilltoId > 0 THEN
	//check for company specific ratetable(s)
	IF lnv_Settings.of_GetcodeDefaultSetting (ll_BilltoId, ll_systemid , la_value ) <> 1 THEN
		//no default
	else
		ls_list = string ( la_Value )
	end if 
END IF

//check system setting

IF lnv_Settings.of_GetcodeDefaultSetting (0, ll_systemid , la_value ) <> 1 THEN
	//no default
else
	if len(trim(ls_list)) = 0 or isnull(ls_list) then
		ls_list = string ( la_Value )
	else
		ls_list += ',' + string ( la_Value )
	end if
end if 

if len(trim(ls_list)) > 0 then
	ll_count = lnv_string.of_ParseToArray(ls_list, ',', lsa_list )
	if ll_count > 0 then
		anv_ratedata.of_SetCodenameSearchOrder(lsa_list)
		anv_ratedata.of_SetCodenameSearchOrder(ls_list)
	end if
end if


end subroutine

public function boolean of_hasautorate ();boolean	lb_rate

n_cst_LicenseManager	lnv_LicenseManager


if lnv_LicenseManager.of_HasAutoRatingLicensed ( ) then
	//ok
	lb_rate = true
else
	//no license, no rating - no message will be displayed
	lb_rate = false
end if

//put back on 7-27-06 because we couldn't stop it from autorating during edi even though we want it to.
//edited out by dan on 2-1-2006 it is now possible to autorate an imported shipment
//IF gnv_App.of_Runningscheduledtask( ) THEN
//	lb_Rate = FALSE
//END IF
//-----------------------------
if lb_rate then
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_AutoRating, "E" ) >= 0 THEN
		lb_rate = true
	else
		//all licenses taken modulelock will display a message unless scheduled task is running, 
		//then it will log an error.
		lb_rate = false
	end if
end if

return lb_rate
end function

public function boolean of_haseditrights (string as_itemtype);n_cst_Privileges	lnv_Privileges
n_cst_LicenseManager	lnv_LicenseManager
n_cst_Settings	lnv_Settings
Any	la_Value
long	ll_id
Boolean	lb_Allow = FALSE

choose case as_itemtype
	case n_cst_constants.cs_itemtype_freight
		ll_id = 127
	case n_cst_constants.cs_itemtype_accessorial
		ll_id = 128
end choose

CHOOSE CASE lnv_Settings.of_GetSetting ( ll_id, la_Value )

CASE 1

	CHOOSE CASE String ( la_Value )

	CASE "ENTRY!"
		lb_Allow = lnv_Privileges.of_HasEntryRights ( )

	CASE "AUDIT!"
		lb_Allow = lnv_Privileges.of_HasAuditRights ( )

	CASE "ADMIN!"
		lb_Allow = lnv_Privileges.of_HasAdministrativeRights ( )

	CASE "PTADMIN!"
		lb_Allow = lnv_Privileges.of_HasSysAdminRights ( )

	CASE "ALL!"
		lb_Allow = true

	CASE "NONE!"
		//Do not allow

	CASE ELSE
		//Unexpected value.
		//Do not allow

	END CHOOSE

CASE 0
	//Value not specified  --  Use default policy.
	lb_Allow = lnv_Privileges.of_HasEntryRights ( )

CASE -1
	//Error
	//Do not allow

CASE ELSE
	//Unexpected return
	//Do not allow

END CHOOSE

return lb_allow
end function

public subroutine of_resetcache ();//rate cache
if isvalid(sds_rate) then
	destroy sds_rate
end if
//ratedefault cache
if isvalid(sds_rateDefaults) then
	destroy sds_rateDefaults
end if
//ratename cache
if isvalid(sds_ratenames) then
	destroy sds_ratenames
end if

end subroutine

public subroutine of_resetratecache ();//rate cache
if isvalid(sds_rate) then
	destroy sds_rate
end if
//ratedefault cache
if isvalid(sds_rateDefaults) then
	destroy sds_rateDefaults
end if
//ratename cache
if isvalid(sds_ratenames) then
	destroy sds_ratenames
end if

end subroutine

public subroutine of_resetzonecache ();setpointer(hourglass!)
snv_Zonemanager.of_Resetcache()
setpointer(hourglass!)
snv_Zonemanager.of_cacheall()


end subroutine

public function n_cst_bso_zonemanager of_getzonemanager ();return snv_zonemanager
end function

public subroutine of_setwhatchanged (string as_value);is_WhatChanged = as_value
end subroutine

public function string of_getwhatchanged ();return is_WhatChanged
end function

public function integer of_settotalcharge (ref n_cst_ratedata anv_ratedata, boolean ab_zones, ref string as_errormessage);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetTotalCharge
//  
//	Access		:public
//
//	Arguments	:anva_ratedata[] by reference,
//					 ab_zones, 
//					 as_errormessage
//
//	Return		:integer
//					 1 success
//					 -1 failure
//						
//	Description	:Set the filter for the rate table cache base on the ratedata object nad
//					 the boolean (which determines if the search is by zones or zoneless).
//					 If a break is found then if this.of_CheckNextBreak() is true then
//					 check to see if the next break would be cheaper.
//
//					 The error message will be passed oot and the calling script will determine
//					 what to do with the message.
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
integer	li_return = 1

long	ll_rowcount, &
		ll_ratedatacount, &
		ll_breakndx, &
		ll_rateid, &
		ll_minrateid, &
		ll_maxrateid, &
		ll_ndx, &
		ll_foundndx

decimal {2} lc_value, &	
				lc_test

decimal	lc_tablebreak, &
			lc_rate, &
			lc_minimum, &
			lc_maximum, &
			lc_charge, &
			lc_nextcharge

string	ls_breakunit, &
			ls_errormessage, &
			ls_originzone, &
			ls_destinationzone, &
			ls_test

boolean	lb_minimumcharge, &
			lb_maximumcharge, &
			lb_onebreak

if isvalid(anv_ratedata) then
	//continue
else
	ls_ErrorMessage = "Invalid Ratedata Object"
	li_return = -1
end if

if li_return = 1 then
	
	this.of_FilterCache(anv_RateData, ab_zones)
	ll_rowcount = sds_rate.rowcount()

	sds_rate.setsort('codename A, billtoid D, ratebreak A')
	sds_rate.sort()
	
	//set new breakunit
	ls_breakunit = this.of_getbreakunit( anv_ratedata.of_getcodename() )	
	
	if ll_rowcount > 0 then
		
		//have a rate table, search for rate
		
	
		/*		get value based on break unit	*/
		if ls_breakunit = this.cs_RateUnit_Code_Flat then
			//should be only 1 row switch to the rate unit for the row
			ls_breakunit = sds_rate.object.rateunit[1]
			anv_ratedata.of_settotalcount(1)
			lb_onebreak = true
		else
			lb_onebreak = false
		end if

		choose case ls_breakunit
			case this.cs_RateUnit_Code_Pound
				lc_value = anv_ratedata.of_gettotalweight()
				anv_ratedata.of_settotalcount(lc_value)

			case this.cs_RateUnit_Code_100Pound, this.cs_RateUnit_Code_Class, this.cs_RateUnit_Code_Ton
				
				//convert weight values
				choose case ls_breakunit
						
					case this.cs_RateUnit_Code_Class
						lc_value = anv_ratedata.of_gettotalweight()
						lc_value = lc_value / 100 
						anv_ratedata.of_settotalcount(lc_value)
			
					case this.cs_RateUnit_Code_100Pound
						lc_value = anv_ratedata.of_gettotalweight()
						lc_value = lc_value / 100 
						anv_ratedata.of_settotalcount(lc_value)
				
					case this.cs_RateUnit_Code_Ton
						lc_value = anv_ratedata.of_gettotalweight()
						lc_value = lc_value / 2000 
						anv_ratedata.of_settotalcount(lc_value)
				
				end choose

			case this.cs_RateUnit_Code_Gallon, this.cs_RateUnit_Code_Piece, &
					this.cs_RateUnit_Code_PerUnit
				lc_value = anv_ratedata.of_gettotalquantity()
				anv_ratedata.of_settotalcount(lc_value)
				
			case this.cs_RateUnit_Code_PerMile
				lc_value = anv_ratedata.of_gettotalmiles()
				anv_ratedata.of_settotalcount(lc_value)
				
		end choose			
		
		if lc_value = 0 then		
			choose case ls_breakunit
				case this.cs_RateUnit_Code_Pound, this.cs_RateUnit_Code_100Pound, &
					  this.cs_RateUnit_Code_Class, this.cs_RateUnit_Code_Ton
					ls_errormessage = "An item weight is required when using the " +&
											anv_ratedata.of_getcodename() + " rate table."
					li_return = -1
				case this.cs_RateUnit_Code_Gallon, this.cs_RateUnit_Code_Piece, &
						this.cs_RateUnit_Code_PerUnit
					ls_errormessage = "An item quantity is required when using the " +&
											anv_ratedata.of_getcodename() + " rate table."
					li_return = -1
				case this.cs_RateUnit_Code_PerMile
					ls_errormessage = "Item miles are required when using the " +&
											anv_ratedata.of_getcodename() + " rate table."
					li_return = -1					
				case this.cs_RateUnit_Code_Flat, this.cs_rateunit_code_minimum, &
					  this.cs_rateunit_code_maximum, this.cs_rateunit_code_none
					lb_onebreak = true
				case else
					//no break units for this item
					//this shouldn't happen because a table can't be saved without them.
					ls_errormessage = "No break units for the table"
					li_return = -1
			end choose
		end if

		if li_return = 1 then
			//set ratetype on ratedata object to breakunit
			anv_ratedata.of_setratetype(ls_breakunit)
			
			//loop thru rate table for each ratedata object
			
			if (ll_rowcount = 1 and (sds_rate.object.ratebreak[1] = 0 or isnull(sds_rate.object.ratebreak[1]))) or &
				lb_onebreak then 
				//there are no breaks, just take the rate from the row
				//check the rate unit to see if rate should be treated as a rate or a total value
				choose case sds_rate.object.rateunit[1]
						
					case this.cs_RateUnit_Code_minimum, this.cs_RateUnit_Code_maximum, &
						  this.cs_RateUnit_Code_none, this.cs_RateUnit_Code_flat
						  
						lc_rate = sds_rate.object.rate[1]
						lc_charge = sds_rate.object.rate[1]
						anv_ratedata.of_settotalcharge(lc_charge)
						anv_ratedata.of_setrate(lc_rate)
						anv_ratedata.of_setrateid(sds_rate.object.id[1])
						
					case else
						lc_rate = sds_rate.object.rate[1]
						lc_charge = lc_rate * lc_value
						anv_ratedata.of_settotalcharge(lc_charge)
						anv_ratedata.of_setrate(lc_rate)
						anv_ratedata.of_setrateid(sds_rate.object.id[1])
				end choose		
				
				if sds_rate.object.billtoid[1] > 0 then
					anv_ratedata.of_SetUsedBilltoOverride(true)
				else
					anv_ratedata.of_SetUsedBilltoOverride(false)
				end if		

			else
				for ll_breakndx = 1 to ll_rowcount
					lc_tablebreak = sds_rate.object.ratebreak[ll_breakndx]
					if lc_tablebreak < 0 then
						choose case lc_tablebreak 
							case -2	//min
								if lb_minimumcharge then
									//already set
								else
									lb_minimumcharge = true
									lc_minimum = sds_rate.object.rate[ll_breakndx]
									ll_minrateid = sds_rate.object.id[ll_breakndx]
								end if
							case -1	//max
								if lb_maximumcharge then
									//already set
								else
									lb_maximumcharge = true
									lc_maximum = sds_rate.object.rate[ll_breakndx]
									ll_maxrateid = sds_rate.object.id[ll_breakndx]
								end if
						end choose					
						CONTINUE			
					end if
						
					if lc_value > lc_tablebreak then
						ll_foundndx = ll_breakndx
						//continue on to next break
					else	
						ll_foundndx = ll_breakndx
						if ll_foundndx > 0 then
							lc_rate = sds_rate.object.rate[ll_foundndx]
							ll_rateid = sds_rate.object.id[ll_foundndx]
							/*	
								if the table rate unit is different than the table break unit 
								then get the matching value type for the calculation
								
							*/
							
							if sds_rate.object.rateunit[ll_foundndx] <> ls_breakunit then
								//set ratetype on ratedata object to rateunit
								anv_ratedata.of_setratetype(sds_rate.object.rateunit[ll_foundndx])
			
								choose case sds_rate.object.rateunit[ll_foundndx]
									case this.cs_RateUnit_Code_Pound
										lc_value = anv_ratedata.of_gettotalweight()
									case this.cs_RateUnit_Code_100Pound, this.cs_rateunit_code_class									
										lc_value = anv_ratedata.of_gettotalweight() / 100
									case this.cs_RateUnit_Code_Ton								
										lc_value = anv_ratedata.of_gettotalweight() / 2000
									case this.cs_RateUnit_Code_Gallon, this.cs_RateUnit_Code_Piece, &
											this.cs_RateUnit_Code_PerUnit
										lc_value = anv_ratedata.of_gettotalquantity()								
									case this.cs_RateUnit_Code_PerMile
										lc_value = anv_ratedata.of_gettotalmiles()
										
								end choose	
							else
								//ratetype already set to breakunit
							end if
							choose case sds_rate.object.rateunit[ll_foundndx]								
								case this.cs_RateUnit_Code_minimum, this.cs_RateUnit_Code_maximum, &
									  this.cs_RateUnit_Code_none, this.cs_RateUnit_Code_flat
									lc_charge = lc_rate					
								case else
									lc_charge = lc_rate * lc_value
							end choose		

							if anv_Ratedata.of_GetCategory() = n_cst_constants.ci_Category_Payables then
								//skip next break checking, not for pay tables
							else
								//check rate from next break to see if it would be cheaper	
								if this.of_CheckNextBreak(anv_ratedata.of_getcodename()) then
									if (ll_breakndx + 1) > ll_rowcount then
										//no next break
									else
										//if this break and the next break is a whole number and
										ls_test = string(sds_rate.object.ratebreak[ll_breakndx])
										if integer(right(ls_test, (len(ls_test) - pos(ls_test,'.')))) = 0 then
											//whole number check next break
											ls_test = string(sds_rate.object.ratebreak[ll_breakndx + 1])
											if integer(right(ls_test, (len(ls_test) - pos(ls_test,'.')))) = 0 then	
												//both are whole numbers
												
												//if the rate units are both the same
												if sds_rate.object.rateunit[ll_breakndx] = sds_rate.object.rateunit[ll_breakndx + 1] then
											
													//break + 1 * the next lower rate
													
													//convert break for proper calculation
													choose case sds_rate.object.rateunit[ll_foundndx]
														case this.cs_RateUnit_Code_100Pound, this.cs_rateunit_code_class									
															lc_test = (sds_rate.object.ratebreak[ll_breakndx] + 1) / 100
														case this.cs_RateUnit_Code_Ton								
															lc_test = (sds_rate.object.ratebreak[ll_breakndx] + 1) / 2000
														case else
															lc_test = sds_rate.object.ratebreak[ll_breakndx] + 1
															
													end choose	
													
													lc_nextcharge = lc_test * sds_rate.object.rate[ll_breakndx + 1]
													if lc_nextcharge < lc_charge then
														lc_charge = lc_nextcharge
														lc_rate = lc_nextcharge
														anv_ratedata.of_setratetype(this.cs_RateUnit_Code_Flat)												
													end if
												
												end if	
											end if
										end if
									end if
								end if
							end if
						else
							//first break
							lc_rate = sds_rate.object.rate[ll_breakndx]
							ll_rateid = sds_rate.object.id[ll_breakndx]
							lc_charge = lc_value * lc_rate
						end if	
						
						if sds_rate.object.billtoid[ll_breakndx] > 0 then
							anv_ratedata.of_SetUsedBilltoOverride(true)
						else
							anv_ratedata.of_SetUsedBilltoOverride(false)
						end if
				
						EXIT	
						
					end if
				next

				if ll_foundndx = ll_rowcount then
					if lc_value > sds_rate.object.ratebreak[ll_rowcount] then
						if lc_charge = 0  then
							//no charge was calculated because the value was bigger than breaks, use maximum amount
							if lb_maximumcharge then
								anv_ratedata.of_setusemaximum(true)
								lc_charge = lc_maximum
								lc_rate = lc_maximum
							else
								ls_errormessage = "Amount exceeded last break and there is no maximum defined for the rate table."
								li_return = -1
							end if
						end if
					end if
				end if
				
				if lc_charge > 0 then
					//check against minimum charge
					if lc_charge < lc_minimum then
						lc_charge = lc_minimum
						lc_rate = lc_minimum
						ll_rateid = ll_minrateid
						anv_ratedata.of_setuseminimum(true)
					end if
					//check against maximum charge
					if lc_charge > lc_maximum then
						if lb_maximumcharge then
							lc_charge = lc_maximum
							anv_ratedata.of_setusemaximum(true)
							lc_rate = lc_maximum
							ll_rateid = ll_maxrateid
						end if
					end if
					
					anv_ratedata.of_settotalcharge(lc_charge)
					anv_ratedata.of_setrate(lc_rate)
					anv_ratedata.of_setrateid(ll_rateid)
					
				else
					//no break found 
					//if there is no break return minimum or maximum
					if lb_minimumcharge then
						anv_ratedata.of_setuseminimum(true)
						anv_ratedata.of_settotalcharge(lc_minimum)
						anv_ratedata.of_setrate(lc_minimum)
						anv_ratedata.of_setrateid(ll_minrateid)
					elseif lb_maximumcharge then
						anv_ratedata.of_setusemaximum(true)
						anv_ratedata.of_settotalcharge(lc_maximum)
						anv_ratedata.of_setrate(lc_maximum)
						anv_ratedata.of_setrateid(ll_maxrateid)
					end if
				end if 
			end if
			
		end if
	else
		if ab_zones then
			ls_errormessage = "There is no " + anv_ratedata.of_GetCodename() + " rate defined for originzone - " +&
							anv_ratedata.of_GetOriginZone() + ", destination zone - " + anv_ratedata.of_GetDestinationZone()
			li_return = -1
		else
			ls_OriginZone = anv_ratedata.of_GetOriginZone()
			ls_DestinationZone = anv_ratedata.of_GetDestinationZone()		

			if ib_originzonesfound or ib_destzonesfound or &
				len(trim(ls_DestinationZone)) > 0 or len(trim(ls_OriginZone)) > 0 then
				ls_errormessage = "No rate defined for Origin/Destination locations."
			else
				ls_errormessage = "Zoneless table search failed."
			end if
			li_return = -1
		end if
	end if //end of table search
	
end if
	
if li_return = -1 then
	as_errormessage = ls_errormessage
end if

return li_return
end function

public subroutine of_setorigin (long al_value, ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetOrigin
//  
//	Access		:public
//
//	Arguments	:al_value
//					 anv_ratedata by reference
//
//	Return		:long
//						
//	Description	:Use al_value to get a beo_company and call the overloaded method.
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

n_cst_beo_company	lnv_company

//if it's already set don't overwrite

IF al_value > 0 THEN
	lnv_company = CREATE n_cst_beo_company
	
	//check the company cache
	gnv_cst_Companies.of_Cache ( al_value, FALSE )

	lnv_Company.of_SetUseCache ( TRUE )
	
	IF lnv_Company.of_SetSourceId ( al_value ) = 1 THEN
		IF lnv_Company.of_HasSource ( ) THEN
			this.of_SetOrigin(lnv_Company, anv_Ratedata)
		END IF
	END IF

END IF

if isvalid(lnv_Company) then
	destroy lnv_Company
end if
end subroutine

public subroutine of_setdestination (long al_value, ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetDestination
//  
//	Access		:public
//
//	Arguments	:al_value
//					 anv_ratedata by reference
//
//	Return		:none
//						
//	Description	:Use al_value to get a beo_company and call the overloaded method.
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

n_cst_beo_company	lnv_company

IF al_value > 0 THEN
	lnv_company = CREATE n_cst_beo_company
	
	//check the company cache
	gnv_cst_Companies.of_Cache ( al_value, FALSE )

	lnv_Company.of_SetUseCache ( TRUE )
	
	IF lnv_Company.of_SetSourceId ( al_value ) = 1 THEN
		IF lnv_Company.of_HasSource ( ) THEN
			this.of_SetDestination(lnv_Company, anv_Ratedata)
		END IF
	END IF

END IF

if isvalid(lnv_Company) then
	destroy lnv_Company
end if
end subroutine

public subroutine of_setcodeoverride (string as_value);is_codeoverride = as_value
end subroutine

public function string of_getcodeoverride ();return is_codeoverride
end function

public function integer of_getcodedefaultlist (long al_coid, integer ai_whichlist, ref string asa_resultlist[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetCodeDefaultList
//  
//	Access		:public
//
//	Arguments	:al_coid,
//					 ai_whichlist, (freight, stopoff, etc)
//					 asa_resultlist by reference
//
//	Return		:integer
//					 number of entries in asa_resultlist
//						
//	Description	:Check Company first then system.
//					
//
// Written by	:Norm LeBlanc
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	8/2/5 <<*>> checked system settings
//////////////////////////////////////////////////////////////////////////////
//



n_cst_setting_appendratecodesearchlist	lnv_Append
lnv_Append = CREATE n_cst_setting_appendratecodesearchlist

Boolean	lb_Append
lb_Append = lnv_Append.of_GetValue( ) = lnv_Append.cs_yes

RETURN THIS.of_Getcodedefaultlist( al_coid , ai_whichlist, asa_resultlist, lb_Append )
	

/*
Long		ll_Count
Long		ll_CompanyID
Any		la_Value
String	ls_List
String	lsa_Results[]

n_cst_Settings	lnv_Settings
n_cst_String	lnv_String

ll_CompanyID = al_coid

IF ll_CompanyID > 0 THEN
	//check for company specific ratetable(s)
	IF lnv_Settings.of_GetcodeDefaultSetting ( ll_CompanyID, ai_whichlist , la_value ) <> 1 THEN
		//no default
	else
		ls_list = string ( la_Value )
	end if 
END IF
		
//check system setting
IF lnv_Settings.of_GetcodeDefaultSetting (0, ai_whichlist , la_value ) <> 1 THEN
	//no default
else
	if len(trim(ls_list)) = 0 or isnull(ls_list) then
		ls_list = string ( la_Value )
	else
		ls_list += ',' + string ( la_Value )
	end if
end if

if len(trim(ls_list)) > 0 then
	ll_count = lnv_string.of_ParseToArray(ls_list, ',', lsa_Results )	
END IF

asa_resultlist = lsa_Results


RETURN ll_Count
*/
end function

public function long of_getamounttype (ref n_cst_ratedata anv_ratedata);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetAmountType
//  
//	Access		:public
//
//	Arguments	:anv_ratedata by reference
//
//	Return		:long
//					 the amount type on the rate data object
//						
//	Description	:Set the Amounttype on the ratedata object based on the amount type
//					 on the rate table. If the ratadata already has an amount type then don't replace it 
//					 otherwise take the amounttype from the rate table if there is one.
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

string	ls_Codename
long		ll_amounttype

ll_amounttype = anv_ratedata.of_GetAmounttype()
if ll_amounttype = 0 or isnull(ll_amounttype) then
	ls_Codename = anv_ratedata.of_GetCodename()
	ll_amounttype = this.of_GetAmountType(ls_Codename)
	if ll_amounttype > 0 then
		anv_ratedata.of_SetAmounttype(ll_amounttype)
	end if
end if

return ll_amounttype
end function

public function boolean of_checknextbreak (string as_codename);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_CheckNextBreak
//  
//	Access		:public
//
//	Arguments	:as_codename
//
//	Return		:boolean
//						
//	Description	:Check for the system setting. It will contain a comma seperated
//					 list of rate table names.  
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


any	la_value

long		ll_count

string	ls_list, &
			lsa_list[]
			
boolean	lb_return = false

n_cst_settings lnv_Settings
n_cst_string	lnv_string

IF lnv_Settings.of_GetSetting ( 93 , la_value ) <> 1 THEN
	//no default
	lb_return = False
else
	ls_list = string ( la_Value )
	if lnv_string.of_ParseToArray(ls_list, ',', lsa_list ) > 0 then
		ll_Count = UpperBound ( lsa_list )
	end if
end if 

if ll_Count > 0 then
	IF Len ( as_codename ) > 0 THEN
		n_cst_anyarraysrv lnv_anyarray
		IF lnv_anyarray.of_Find( lsa_list, as_codename, 1, ll_Count ) > 0 THEN
			lb_return = true
		END IF
	END IF
end if

return lb_return

end function

protected subroutine of_settotalitemcount (n_cst_beo_item anva_item[], n_cst_beo_shipment anv_shipment, ref n_cst_ratedata anva_ratedata[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_SetTotalItemCount
//  
//	Access		:protected
//
//	Arguments	:anva_item[]
//					 anv_shipment
//					 anva_ratedata[] reference
//
//	Return		:none
//
//	Description	:Loop through the items and create ratedata objects.
//					Items of the same type and ratecode will be combined into one
//					ratedata object with the counts being added together.
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

string	ls_billto, &
			ls_orig, &
			ls_dest, &
			ls_taglist,&
			ls_rateeventtype, &
			ls_itemeventtype, &
			ls_codeoverride, &
			ls_codename
			
integer	li_return

decimal	lc_value, &
			lc_miles, &
			lc_quantity, &
			lc_weight
			
long		ll_itemcount, &
			ll_ratedatacount, &
			ll_found, &
			ll_Ratendx, &
			ll_ndx, &
			ll_origin, &
			ll_destination

n_cst_events		lnv_Events
n_cst_ratedata		lnva_RateData[]
n_cst_string		lnv_string
lnva_Ratedata = anva_RateData
ll_itemcount = upperbound(anva_item)

//this is new logic, break out by OurRatecodename
//add items by type and codename, and itemeventtype

for ll_ndx = 1 to ll_itemcount
	
	// this is a kluge that needs to be fixed to use 'THE POWER OF AUTO RATING'
	CHOOSE CASE anva_item[ll_ndx].of_getEventTypeFlag()
			
		CASE n_cst_constants.cs_ItemEventType_PerDiem
			
			CONTINUE // dont touch perdiem charges
			
		CASE n_cst_constants.cs_ItemEventType_FuelSurcharge 
			
			anva_item[ll_ndx].of_SetAmount ( 0 )

			CONTINUE 
	END CHOOSE
	// END OF KLUGE <<*>>
	
	
	ls_taglist = anva_item[ll_ndx].of_GetTagList()
	//look for a custom rate
	if anva_item[ll_ndx].of_GetRateCodename() = 'CUSTOM' then	
		ls_billto = lnv_string.of_GetKeyValue(ls_taglist,'BillTo',',')
		if len(trim(ls_billto)) > 0 then
			//don't rate
			CONTINUE
		else
			//if there is an orig/dest in the taglist use it for rating
			ls_orig = lnv_string.of_GetKeyValue(ls_taglist,'Originzone',',')
			ls_dest = lnv_string.of_GetKeyValue(ls_taglist,'Destinationzone',',')
		end if
	
	end if

	if this.of_Recalculate() then
		choose case this.of_GetWhatChanged()
			case appeon_constant.cs_Action_ChangedBillto
			//recalculate specials with new billto
			case appeon_constant.cs_Action_ChangedOrigin, appeon_constant.cs_Action_ChangedDestination
				choose case anva_item[ll_ndx].of_getEventTypeFlag()
					case n_cst_constants.cs_ItemEventType_FrontChassisSplit, &
						  n_cst_constants.cs_ItemEventType_BackChassisSplit, &
						  n_cst_constants.cs_ItemEventType_StopOff, &
						  n_cst_constants.cs_ItemEventType_FuelSurcharge, &
						  n_cst_constants.cs_ItemEventType_bobtail
						  CONTINUE
				end choose
		end choose
	end if	
	
	//Has a rate data object already been created for this rate code?
	ll_ratedatacount = upperbound(lnva_Ratedata)
	ll_found = 0
	
	for ll_ratendx = 1 to ll_RateDatacount
		if lnva_Ratedata[ll_RateNdx].of_GetItemType() = anva_item[ll_ndx].of_gettype() then
			if lnva_Ratedata[ll_RateNdx].of_GetCodename() = anva_item[ll_ndx].of_GetRateCodename() then
				ls_rateeventtype = lnva_Ratedata[ll_RateNdx].of_GetItemEventType()
				ls_itemeventtype = anva_item[ll_ndx].of_getEventTypeFlag()
				if (isnull(ls_rateeventtype) and isnull(ls_itemeventtype)) or (ls_rateeventtype = ls_itemeventtype) then
					ll_found = ll_Ratendx
					exit
				end if
			end if
		end if
	next
	
	if ll_found = 0 then
		ll_RateDatacount ++
		ll_found = ll_RateDatacount
		lnva_Ratedata[ll_found] = Create n_cst_RateData
		lnva_Ratedata[ll_found].of_setitemtype(anva_item[ll_ndx].of_gettype())
		  // new condition added 6/13/03 by Norm and Rick on Phone
		IF anva_item[ll_ndx].of_gettype() = n_cst_constants.cs_itemtype_accessorial OR &
			anva_Item[ll_ndx].of_GetEventTypeFlag() = n_cst_constants.cs_ItemEventType_MoveAccessorial THEN
			// I added the check for the move accessorial on 7/26/05 <<*>>
			
			
			lnva_Ratedata[ll_found].of_SetCodename( anva_item[ll_ndx].of_getratecodename () )
		ELSE		
			if this.of_recalculate()  then 
				//don't use old codename
			else
				ls_codeoverride = this.of_GetCodeOverride()
				if len(trim(ls_codeoverride)) > 0 then
					//this will set substitions and fallbacks
					lnva_Ratedata[ll_found].of_SetCodename(ls_codeoverride)
					ls_codename = lnva_Ratedata[ll_found].of_GetCodename()
					if len(trim(ls_codename)) > 0 then
						//code was already set
					else
						//we will look at item ratecode first
						lnva_Ratedata[ll_found].of_setCodename(anva_item[ll_ndx].of_GetRateCodename())
					end if
				else
					lnva_Ratedata[ll_found].of_setCodename(anva_item[ll_ndx].of_GetRateCodename())
				end if
			end if
		END IF
		
		//set origin/destination info on ratedata object
		choose case anva_item[ll_ndx].of_getEventTypeFlag()
			case n_cst_constants.cs_ItemEventType_FrontChassisSplit, n_cst_constants.cs_ItemEventType_BackChassisSplit
				
				lnv_Events.of_GetSitesforEventflag(anv_shipment.of_GetEventSource(), anva_item[ll_ndx].of_getEventTypeFlag(), &
																 ll_origin, ll_destination)
																 
				if len(trim(ls_orig)) > 0 then
					this.of_setorigin(long(ls_orig), lnva_ratedata[ll_found])
				else
					this.of_setorigin(ll_origin, lnva_Ratedata[ll_found])
				end if
				if len(trim(ls_dest)) > 0 then
					this.of_setdestination(long(ls_dest), lnva_ratedata[ll_found])	
				else
					this.of_setdestination(ll_destination, lnva_Ratedata[ll_found])			
				end if
				
			case n_cst_constants.cs_ItemEventType_StopOff ,n_cst_constants.cs_ItemEventType_bobtail
				if len(trim(ls_orig)) > 0 then
					this.of_setorigin(long(ls_orig), lnva_ratedata[ll_found])
				else
					this.of_setorigin(anv_shipment, lnva_Ratedata[ll_found])
				end if
				if len(trim(ls_dest)) > 0 then
					this.of_setdestination(long(ls_dest), lnva_ratedata[ll_found])	
				else
					this.of_setdestination(anv_shipment, lnva_Ratedata[ll_found])			
				end if
				  
				  
			case else
				if len(trim(ls_orig)) > 0 then
					this.of_setorigin(long(ls_orig), lnva_ratedata[ll_found])
				else
					this.of_setorigin(anv_shipment, lnva_Ratedata[ll_found])
				end if
				if len(trim(ls_dest)) > 0 then
					this.of_setdestination(long(ls_dest), lnva_ratedata[ll_found])	
				else
					this.of_setdestination(anv_shipment, lnva_Ratedata[ll_found])			
				end if
		end choose

		lnva_ratedata[ll_found].of_setItemEventType(anva_item[ll_ndx].of_getEventTypeFlag())
				
	end if
	
//	if anva_item[ll_ndx].of_gettype() = n_cst_constants.cs_ItemType_Freight then
//		lnva_Ratedata[ll_found].of_setreplacenonetype(ib_includenonetype)
//	end if
		
	lc_weight = anva_item[ll_ndx].of_gettotalweight()
	lc_quantity = anva_item[ll_ndx].of_getquantity()
	lc_miles = anva_item[ll_ndx].of_getmiles()
	
	if anva_item[ll_ndx].of_gettype() = n_cst_constants.cs_ItemType_Freight then
		choose case this.of_GetWhatChanged()
			case appeon_constant.cs_Action_ChangedOrigin, appeon_constant.cs_Action_ChangedDestination
				lc_miles = 0  //force item to use shipment totalmiles
		end choose	
	end if

	lnva_Ratedata[ll_found].of_settotalquantity(lc_quantity + lnva_Ratedata[ll_found].of_gettotalquantity())
	lnva_Ratedata[ll_found].of_settotalweight(lc_weight + lnva_Ratedata[ll_found].of_gettotalweight())
	if lnva_Ratedata[ll_found].of_GetCategory() = n_cst_constants.ci_Category_Payables then
		//don't use item miles we calculate itinerary miles which should already be on the ratedata object
	else
		lnva_Ratedata[ll_found].of_settotalmiles(lc_miles + lnva_Ratedata[ll_found].of_gettotalmiles(FALSE)) //don't check orig/dest miles
	end if
	
next

anva_ratedata = lnva_Ratedata

end subroutine

public function integer of_getrateidfororigindestination (string asa_originzone[], string asa_destinationzone[], ref long ala_rateid[]);integer	li_return

long	ll_found, &
		ll_ndx, &
		ll_origincount, &
		ll_destcount, &
		ll_rowcount

ll_rowcount = sds_rate.rowcount()
ll_origincount = upperbound(asa_originzone)
ll_destcount = upperbound(asa_destinationzone)

for ll_ndx = 1 to ll_origincount
	
	if ll_destcount < ll_ndx then
		
		exit
		
	else
		
		DO	
			ll_found = sds_rate.find("originzone = '" + asa_originzone[ll_ndx] + &
									"' and destzone = '" + asa_destinationzone[ll_ndx] + "'", ll_found, ll_rowcount)
	
			if ll_found > 0 then
				ala_rateid[ll_ndx] = sds_rate.object.id[ll_found]
			end if
			
			choose case ll_found
				case 0
					//do nothing
				case is < ll_rowcount
					ll_found ++
				case else
					ll_found = 0
			end choose
					
		LOOP UNTIL ll_found = 0

	end if
	
next

li_return = upperbound(ala_rateid)

return li_return
end function

public function integer of_getbilltofororigindestination (string asa_originzone[], string asa_destinationzone[], ref long al_indexfound);integer	li_return

long	ll_found, &
		ll_ndx, &
		ll_origincount, &
		ll_destcount, &
		ll_id, &
		ll_billtoid, &
		ll_rowcount

boolean	lb_MultipleBillto

ll_rowcount = sds_rate.rowcount()
ll_origincount = upperbound(asa_originzone)
ll_destcount = upperbound(asa_destinationzone)

for ll_ndx = 1 to ll_origincount
	
	if ll_destcount < ll_ndx then
		
		exit
		
	else
		
		DO	
			ll_found = sds_rate.find("originzone = '" + asa_originzone[ll_ndx] + &
									"' and destzone = '" + asa_destinationzone[ll_ndx] + "'", ll_found, ll_rowcount)
									
			if ll_found > 0 then
				ll_id = sds_rate.object.billtoid[ll_found]
				if ll_id = 0 then
					//base table
				else
					if ll_billtoid > 0 then
						//already have one
						if ll_billtoid = ll_id then
							//same one 
						else
							//more than one 
							ll_billtoid = 0
							lb_multipleBillto = true
							al_Indexfound = 0
							exit
						end if
					else
						al_Indexfound = ll_ndx
						ll_billtoid = ll_id
					end if
				end if
			end if
			
			choose case ll_found
				case 0
					//do nothing
				case is < ll_rowcount
					ll_found ++
				case else
					ll_found = 0
			end choose
					
		LOOP UNTIL ll_found = 0

		if lb_multipleBillto then
			exit
		end if
		 
	end if
	
next

if al_indexfound > 0 then 
	li_return = 1
else
	li_return = 0 
end if

return li_return
end function

public function boolean of_usereversesearchforsettlements ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_UseReverseSearchSettlements
//  
//	Access		:public
//
//	Arguments	:none
//
//	Return		:boolean
//						
//	Description	:Get system setting. This determines if the the origin and destination
//					 should be swapped if a rate table is not found for origin/destination.
//
//
// Written by	:Norm LeBlanc
// 		Date	:08/23/04
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//


Integer	li_Return
boolean	lb_reversesearch

n_cst_setting_reverseoridesSettlements	lnv_Setting

lnv_Setting = create n_cst_setting_reverseoridesSettlements

IF lnv_Setting.of_Getvalue( ) = lnv_Setting.cs_Yes THEN
	lb_reversesearch = TRUE
ELSE
	lb_reversesearch = FALSE
END IF

destroy lnv_setting

return lb_reversesearch
end function

public function string of_getvaluelist (boolean ab_includenone);//return as an edit code table list
string	ls_valuelist

ls_ValueList = cs_RateUnit_Pound + "~t" + cs_RateUnit_Code_Pound +&
					"/" + cs_RateUnit_100Pound + "~t" + cs_RateUnit_Code_100Pound +&
					"/" + cs_RateUnit_Ton + "~t" + cs_RateUnit_Code_Ton +&
					"/" + cs_RateUnit_PerMile + "~t" + cs_RateUnit_Code_PerMile +&
					"/" + cs_RateUnit_PerUnit + "~t" + cs_RateUnit_Code_PerUnit +&
					"/" + cs_RateUnit_Piece + "~t" + cs_RateUnit_Code_Piece +&
					"/" + cs_RateUnit_Gallon + "~t" + cs_RateUnit_Code_Gallon +&
					"/" + cs_RateUnit_Flat + "~t" + cs_RateUnit_Code_Flat +&
					"/" + cs_RateUnit_Class + "~t" + cs_RateUnit_Code_Class +&
					"/" + cs_RateUnit_Minimum + "~t" + cs_RateUnit_Code_Minimum +&
					"/" + cs_RateUnit_Maximum + "~t" + cs_RateUnit_Code_Maximum
					
if ab_includenone then					
	ls_ValueList = ls_ValueList +&
					"/" + cs_RateUnit_None + "~t" + cs_RateUnit_Code_None +"/"
else
	ls_ValueList = ls_ValueList + "/"
end if
					
return ls_valuelist					
end function

public function integer of_getcodedefaultlist (long al_coid, integer ai_whichlist, ref string asa_resultlist[], boolean ab_combine);Long		ll_Count
Long		ll_CompanyID
Any		la_Value
String	ls_List
String	lsa_Results[]


n_cst_Settings	lnv_Settings
n_cst_String	lnv_String
	
ll_CompanyID = al_coid

IF ll_CompanyID > 0 THEN
	//check for company specific ratetable(s)
	IF lnv_Settings.of_GetcodeDefaultSetting ( ll_CompanyID, ai_whichlist , la_value ) <> 1 THEN
		//no default
	else
		ls_list = string ( la_Value )
	end if 
	
	If isNull ( ls_List ) THEN
		ls_List = ''
	END IF
	
			
END IF

// we will combine if we are told to OR if there is no default found for a company

IF ab_Combine OR Len ( ls_List ) = 0 THEN
	
	if ls_list = 'N/A' then
		ls_list = ''
	end if

	//check system setting
	IF lnv_Settings.of_GetcodeDefaultSetting (0, ai_whichlist , la_value ) <> 1 THEN
		//no default
	else
		if len(trim(ls_list)) = 0 or isnull(ls_list) then
			ls_list = string ( la_Value )
		else
			ls_list += ',' + string ( la_Value )
		end if
	end if
end if

// in case we are not appending we don't want to pass out N/A
if ls_list = 'N/A' then
	ls_list = ''
end if

if len(trim(ls_list)) > 0 then
	ll_count = lnv_string.of_ParseToArray(ls_list, ',', lsa_Results )	
END IF

asa_resultlist = lsa_Results
	
	
return ll_Count
end function

public function long of_getamounttype (string as_ratecode);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetAmountType
//  
//	Access		:public
//
//	Arguments	:as_ratecode
//
//	Return		:long
//					 the amount type on the rate data object
//						
//	Description	:Overload method for ratecode without ratedata object
//
// Written by	:Norm LeBlanc
// 		Date	:01/04/2005
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

string	ls_findstring

long		ll_count, &
			ll_foundrow, &
			ll_amounttype
			
n_ds		lds_Ratenames

if isnull(as_ratecode) or len(trim(as_ratecode)) = 0 then
	ll_amounttype = 0
else
	lds_Ratenames = This.of_GetRatetablenameCache()
	ll_count = lds_Ratenames.RowCount()
	
	if ll_count > 0 then
		ls_findstring = "ratetable_codename = '" + as_ratecode + "'" 
		ll_foundrow = lds_Ratenames.Find(ls_findstring, 1, ll_count)
		if ll_foundrow > 0 then
			ll_amounttype = lds_Ratenames.object.ratetable_amounttype[ll_foundrow]
		end if
	end if	
end if
	
return ll_amounttype
end function

public function string of_getratedescription (string as_ratecode, long al_billtoid);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_GetRateDescription
//  
//	Access		:public
//
//	Arguments	:as_ratecode, 
//					 al_billtoid
//
//	Return		:string
//					 the rate table description
//						
//	Description	:First look for override description in the ratedefaults table. 
//					 If no override then look for a default description in the ratetable. 
//					 If there is no override or default then set as empty string. 
//
// Written by	:Norm LeBlanc
// 		Date	:01/04/2005
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

string	ls_Description, &
			ls_Codename, &
			ls_findstring

long		ll_BillToId, &
			ll_count, &
			ll_foundrow, &
			ll_Return = 1
			
n_ds		lds_RateDefaults, &
			lds_Ratenames

if ll_Return = 1 then
	ll_BillToId = al_BillToId
	if isnull(ll_BillToId) then
		ll_BillToId = 0
	end if


	ls_Codename = as_RateCode
	if isnull(ls_Codename) or len(trim(ls_Codename)) = 0 then
		ll_Return = -1
	end if
end if

if ll_Return = 1 then
	/* try ratedefaults	*/
	lds_RateDefaults = this.of_GetRateDefaultCache()
	ll_count = lds_RateDefaults.Rowcount()
	if ll_count > 0 then
		ls_Findstring = "billtoid = " + string(ll_billtoId) + " and codename = '" + ls_codename + "'"
		ll_foundrow = lds_RateDefaults.find(ls_findstring, 1, ll_count) 
		if ll_foundrow > 0 then
			ls_Description = lds_RateDefaults.object.overridedescription[ll_foundrow]
		else
			/*	try ratetable	*/
			lds_Ratenames = This.of_GetRatetablenameCache()
			ll_count = lds_Ratenames.RowCount()
			if ll_count > 0 then
				ls_findstring = "ratetable_codename = '" + ls_codename + "'" 
				ll_foundrow = lds_Ratenames.Find(ls_findstring, 1, ll_count)
				if ll_foundrow > 0 then
					ls_Description = lds_Ratenames.object.ratetable_defaultdescription[ll_foundrow]
				end if
			end if
		end if 
	else
		/*	try ratetable	*/
		lds_Ratenames = This.of_GetRatetablenameCache()
		ll_count = lds_Ratenames.RowCount()
		if ll_count > 0 then
			ls_findstring = "ratetable_codename = '" + ls_codename + "'" 
			ll_foundrow = lds_Ratenames.Find(ls_findstring, 1, ll_count)
			if ll_foundrow > 0 then
				ls_Description = lds_Ratenames.object.ratetable_defaultdescription[ll_foundrow]
			end if
		end if
	
	end if
end if

return ls_Description

end function

on n_cst_bso_rating.create
call super::create
end on

on n_cst_bso_rating.destroy
call super::destroy
end on

event destructor;call super::destructor;////rate cache
//if isvalid(sds_rate) then
//	destroy sds_rate
//end if
////zone cache
//if isvalid(snv_zonemanager) then
//	destroy snv_zonemanager
//end if
////ratedefault cache
//if isvalid(sds_rateDefaults) then
//	destroy sds_rateDefaults
//end if
////ratename cache
//if isvalid(sds_ratenames) then
//	destroy sds_ratenames
//end if
//
end event

event constructor;call super::constructor;if isvalid(snv_zonemanager) then
	//already created
else
	SetPointer(Hourglass!)
	snv_zonemanager = create n_cst_bso_zonemanager

	snv_zonemanager.of_CacheAll()
end if

end event

