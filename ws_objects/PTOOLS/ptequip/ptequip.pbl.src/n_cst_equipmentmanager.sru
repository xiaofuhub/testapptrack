$PBExportHeader$n_cst_equipmentmanager.sru
forward
global type n_cst_equipmentmanager from n_cst_base
end type
end forward

shared variables
//begin modification Shared Variables by appeon  20070730
//n_ds 	sds_equip
//boolean 	sb_equip_retrieved
//datetime 	sdt_equip_refreshed, &
//	sdt_equip_updated, &
//	sdt_LastChange
//long 	sl_counter
//s_eq_info sstr_null_info
//end modification Shared Variables by appeon  20070730

end variables

global type n_cst_equipmentmanager from n_cst_base autoinstantiate
end type

type variables
Constant String cs_TRAC = 'T'
Constant String cs_STRT = 'S'
Constant String cs_VAN  = 'N'
Constant String cs_TRLR = 'V'
Constant String cs_FLBD = 'F'
Constant String cs_REFR = 'R'
Constant String cs_TANK = 'K'
Constant String cs_RBOX = 'B'
Constant String cs_CHAS = 'H'
Constant String cs_CNTN = 'C'

Constant String cs_display_TRAC = "TRAC"
Constant String cs_display_STRT = "STRT"
Constant String cs_display_VAN  = "VAN"
Constant String cs_display_TRLR = "TRLR"
Constant String cs_display_FLBD = "FLBD"
Constant String cs_display_REFR = "REFR"
Constant String cs_display_TANK = "TANK"
Constant String cs_display_RBOX = "RBOX"
Constant String cs_display_CHAS = "CNTN"
Constant String cs_display_CNTN = "CHAS"

Constant String cs_Status_Active = 'K'

Constant Long cl_PermIDStart = 10000001

Constant int ci_FreeTimeStart_Notify  = 1
Constant int ci_FreeTimeStart_Outgate  = 2

//begin modification Shared Variables by appeon  20070730
//n_ds 	sds_equip
boolean 	sb_equip_retrieved
datetime 	sdt_equip_refreshed, &
	sdt_equip_updated, &
	sdt_LastChange
long 	sl_counter
s_eq_info sstr_null_info
//end modification Shared Variables by appeon  20070730

end variables

forward prototypes
public function integer of_cache (ref long ala_ids[], boolean ab_force_refresh)
public function integer of_cache (long al_id, boolean ab_force_refresh)
public function long of_find (long al_target_id)
public function integer of_sync (powerobject apo_source)
public function integer of_select (ref s_eq_info astr_equip, string as_search, string as_equip_type, boolean ab_active_only)
protected function integer of_get_info (long al_target_id, ref s_eq_info astr_target, datastore ads_local, boolean ab_force_refresh)
public function integer of_get_info (long al_target_id, ref s_eq_info astr_target, boolean ab_force_refresh)
public function integer of_get_info (long al_target_id, ref s_eq_info astr_target, datastore ads_local)
public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_target_row)
public function integer of_type_to_category (string as_type)
public function boolean of_valid_category (integer ai_category)
public function integer of_get_description (long al_target, string as_type, ref string as_description)
public function long of_eq_info (datastore ds_local, string find_ref, string find_type, ref s_eq_info eqs)
public function integer of_sync (powerobject apo_source, boolean ab_allrows, boolean ab_alldata)
public function integer of_copycache (powerobject apo_target)
public function integer of_refreshactive ()
public function integer of_getcurrentevent (long al_id, ref n_cst_msg anv_msg)
public subroutine of_openitinerary (long al_id, date ad_date)
public function long of_local_eq (long al_id, any aa_target)
public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_targetrow, readonly string asa_source_alias[], readonly string asa_target_alias[])
public function n_ds of_get_ds_equipment ()
public function boolean of_get_retrieved_equip ()
public subroutine of_set_retrieved_equip (boolean ab_switch)
public function datetime of_get_refreshtime_equip ()
public subroutine of_set_refreshtime_equip (datetime adt_datetime)
public function datetime of_get_updatetime_equip ()
public subroutine of_set_updatetime (datetime adt_datetime)
public function integer of_refresh ()
public function integer of_getcache (ref n_cst_bcm anv_cache)
public function integer of_refreshcalculations ()
public function integer of_refreshcalculations (readonly n_cst_bcm anv_bcm)
public function string of_gettypelist (readonly integer ai_category)
public function string of_gettypefilter (readonly string as_column, readonly integer ai_category)
public subroutine of_opendriveritinerary (readonly long al_id, readonly date ad_date)
public function integer of_getitintype (readonly string as_equipmenttype)
public function string of_getdescriptions (long ala_ids[], string as_describetype, boolean ab_describeerrors, boolean ab_ignorenulls)
public function boolean of_cancarrycontainer (string as_type)
protected function long of_retrievewithcompanyinfo (ref datastore ads_work, string as_where, boolean ab_retain_ds, boolean ab_sync)
public function long of_retrievewithcompanyinfo (ref datastore ads_work, string as_where)
public function long of_retrieve (ref datastore ads_work, string as_where)
public function long of_retrieve (ref datastore ads_work, long ala_ids[], boolean ab_withcompanyinfo)
public function string of_getdisplayvalue (character ac_type)
public function long of_getidfromref (string as_ref)
public function integer of_smartsearch (string as_eqref, string as_type, string as_status, ref long ala_eqid[])
public function integer of_lastfreedate (date adt_date)
public function integer of_addequipmenttoshipment (long al_EqID, long al_ShipmentID)
public function integer of_removetempequipment ()
public function boolean of_isequipmentrouted (n_cst_beo_equipment2 anv_equipment, n_cst_bso_dispatch anv_dispatch)
public function boolean of_isequipmentrouted (long al_eqid, string as_eqtype, n_cst_bso_dispatch anv_dispatch)
public function integer of_parseisocode (string as_isocode, ref string as_lengthcode, ref string as_gooseneckandheight, ref string as_description)
public function long of_getequipmentid (string as_eqtype, string as_refnum)
public function integer of_displayroutemap (long ala_ids[], date ad_start, date ad_end, w_map aw_map)
public function integer of_displayunroutedstops (w_map aw_map)
public function boolean of_isunknownequipment (long ala_eqids[])
private function integer of_equifact (string as_strcheck)
public function integer of_validatecheckdigit (string as_eqref, ref string as_error)
public function integer of_validatecheckdigit (string as_eqref, ref string as_error, boolean ab_required)
public function integer of_validatecheckdigit (string as_eqref, ref string as_error, boolean ab_required, boolean ab_validate)
private function integer of_splitalphanumeric (string as_source, ref string as_alpha, ref string as_numeric)
public function integer of_calculatecheckdigit (string as_eqref)
public function long of_existsequipment (string as_eqref, string as_eqtype, string as_eqstatus, ref string asa_dupes[])
public function long of_existsequipment (string as_eqref, datastore ads_cache, ref string asa_dupes[])
private function string of_getexistsequipmentfindstring (string as_eqref, string as_eqtype, string as_eqstatus)
public function long of_existsindatabase (string as_eqref, string as_eqtype, string as_eqstatus, ref string asa_dupes[])
public function long of_existsincache (datastore ads_cache, string as_eqref, string as_eqtype, string as_eqstatus)
public function long of_existsincache (datastore ads_cache, string as_eqref, string as_eqtype, string as_eqstatus, ref long al_row)
public function integer of_updateunknownequipment (long al_equipmentid, string as_newref, n_cst_beo_shipment anv_shipment)
public function integer of_adderror (string as_error)
public function integer of_geterrors (ref string asa_errors[])
public function long of_existsequipment (string as_eqref, ref string asa_dupes[])
public function long of_existsequipment (string as_eqref, datastore ads_cache, string as_eqtype, string as_eqstatus, ref string asa_dupes[])
public function string of_get_ds_equipment_dataobject ()
end prototypes

public function integer of_cache (ref long ala_ids[], boolean ab_force_refresh);//NOTE: the array of ids passed in (ala_ids) is submitted to gf_shrink_array.  It may
//be modified in the process.  If the calling script needs the array untouched, it should
//make a copy and submit that instead.

long ll_expected, ll_retrieved, ll_checkloop, lla_retr_ids[], ll_foundrow, ll_cache_rows
datastore lds_retr
string ls_work, ls_where

n_cst_numerical lnv_numerical
n_cst_anyarraysrv lnv_anyarray
n_cst_sql	lnv_Sql
lnv_anyarray.of_GetShrinked (ala_ids, TRUE /*Nulls*/, TRUE /*Dupes*/ )

ll_cache_rows = sds_equip.rowcount()

if ab_force_refresh = false and ll_cache_rows > 0 then
	//If force refresh is false and there are rows in the cache, we'll exclude ids
	//already in the cache from the retrieval list.
	for ll_checkloop = 1 to upperbound(ala_ids)
		if sds_equip.find("eq_id = " + string(ala_ids[ll_checkloop]), 1, ll_cache_rows) > 0 &
			then continue
		ll_expected ++
		lla_retr_ids[ll_expected] = ala_ids[ll_checkloop]
	next
else
	ll_expected = upperbound(ala_ids)
	lla_retr_ids = ala_ids
end if

if lnv_numerical.of_IsNullOrNotPos(ll_expected) then return 1

ls_where = "WHERE eq_id " + lnv_Sql.of_MakeInClause ( lla_Retr_Ids )
																						 	
ll_retrieved = this.of_retrieveWithCompanyInfo(lds_retr, ls_where, true /*retain*/ , true/*Sync*/)

if ab_force_refresh and ll_retrieved < ll_expected then
	//If not all of the expected ids were retrieved (or, more likely, the retrieve
	//simply failed) and force_refresh is true, we should get rid of the cached info, if any, 
	//for the ids that were not retrieved.
	for ll_checkloop = 1 to upperbound(lla_retr_ids)
		if lds_retr.find("eq_id = " + string(lla_retr_ids), 1, ll_retrieved) > 0 then continue
			//(This syntax is fine even if ll_retrieved = -1 from a retrieve failure, above)
		ll_foundrow = sds_equip.find("eq_id = " + string(lla_retr_ids), 1, sds_equip.rowcount())
		if ll_foundrow > 0 then sds_equip.rowsdiscard(ll_foundrow, ll_foundrow, primary!)
	next
end if

destroy lds_retr

if ll_retrieved = -1 then
	return -1
else
//	if ll_retrieved = ll_expected then return 1 else return -1

	return 1
end if
end function

public function integer of_cache (long al_id, boolean ab_force_refresh);long lla_ids[]

lla_ids[1] = al_id

return of_cache(lla_ids, ab_force_refresh)
end function

public function long of_find (long al_target_id);//Return Values: > 0 = success (a positive row in the cache), 0 = Not Found (No error), 
//						-1 = Error.  
// The function returns 0 for a null al_target_id (Not Found).
// The function will not return null.

long ll_foundrow
n_cst_numerical lnv_numerical

if lnv_numerical.of_IsNullOrNotPos(al_target_id) then return 0

ll_foundrow = sds_equip.find("eq_id = " + string(al_target_id), 1, sds_equip.rowcount())
if ll_foundrow > 0 then return ll_foundrow

if of_cache(al_target_id, true) = -1 then return -1

ll_foundrow = sds_equip.find("eq_id = " + string(al_target_id), 1, sds_equip.rowcount())
if isnull(ll_foundrow) then return -1
return ll_foundrow
end function

public function integer of_sync (powerobject apo_source);Boolean	lb_AllRows, &
			lb_AllData

lb_AllRows = TRUE
lb_AllData = TRUE

RETURN of_Sync ( apo_Source, lb_AllRows, lb_AllData )
end function

public function integer of_select (ref s_eq_info astr_equip, string as_search, string as_equip_type, boolean ab_active_only);//Return Values
// 1 : Selection made.  Info in astr_company.
//			IMPORTANT!! : The user can select "no equipment" (an empty as_search).
//			This gives a return value of 1 but an astr_equip.eq_id of null.
// 0 : No selection made (select process cancelled).
//-1 : Error

datastore lds_retr
string ls_where, ls_work
long ll_retrieved, ll_id
integer li_retnval, li_ndx
n_cst_numerical lnv_numerical

astr_equip = sstr_null_info
as_search = upper(trim(as_search))
as_equip_type = trim(as_equip_type)

if lnv_numerical.of_IsNullOrNotPos(len(as_search)) then return 1

if ab_active_only then
	//This is temporary, until we bring the active list into this object's cache (which
	//will require changes to the dispatch scripts.)  Until then, the two have to coexist.

	if gf_eq_info(null_ds, as_search, as_equip_type, astr_equip) > 0 then
		if astr_equip.eq_id > 0 then return 1
	end if
	astr_equip = sstr_null_info
	return 0
end if

ls_where = "WHERE eq_ref = '" + as_search + "'"

if len(as_equip_type) > 0 and isnumber(as_equip_type) then
	choose case integer(as_equip_type)
	case 200
		as_equip_type = "TSN"
	case 300
		as_equip_type = "VFRKBH"
	case 400
		as_equip_type = "C"
	case else
		return -1
	end choose
end if

if len(as_equip_type) > 0 then
	ls_work = ""
	for li_ndx = 1 to len(as_equip_type)
		if li_ndx > 1 then ls_work += ", "
		ls_work += "'" + mid(as_equip_type, li_ndx, 1) + "'"
	next
	ls_where += " and eq_type in (" + ls_work + ")"
end if

if ab_active_only then
	ls_where += " and eq_status = 'K'"
else
	ls_where += " and eq_status <> 'X'"
end if

ll_retrieved = this.of_retrieveWithCompanyInfo(lds_retr, ls_where, TRUE/*retain*/ ,false /*sync*/)
//This CREATEs lds_retr.  We need to destroy it later.

if ll_retrieved < 1 then
	li_retnval = ll_retrieved
else

	if ll_retrieved = 1 then
		ll_id = lds_retr.object.eq_id[1]
	else
		g_tempstr = "LOCAL_ONLY!"
		openwithparm(w_equip_select, lds_retr)
		ll_id = message.doubleparm
	end if

	if ll_id > 0 then
		if this.of_get_info(ll_id, astr_equip, lds_retr) = 1 then li_retnval = 1 &
			else li_retnval = -1
	else
		li_retnval = 0
	end if

end if

destroy lds_retr

return li_retnval
end function

protected function integer of_get_info (long al_target_id, ref s_eq_info astr_target, datastore ads_local, boolean ab_force_refresh);//Don't call the function in this form directly.  Use one of the subsidiary versions.

//Return Values: 1 = Success, 0 = ID not found (no error), -1 = Error
//		An al_target_id of null will return 1, with astr_target containing null info.
//		astr_target will be set to either the valid info or null info for all return codes.

//WARNING!! of_get_description calls this function.  We need to be aware of endless loop
//issues if this function ever needs to call of_get_description.

long ll_foundrow
s_co_info lstr_company
datastore lds_source

astr_target = sstr_null_info

if isnull(al_target_id) then return 1
if ab_force_refresh and isvalid(ads_local) then return -1

if ab_force_refresh then
	if of_cache(al_target_id, ab_force_refresh) = -1 then return -1
elseif isvalid(ads_local) then
	ll_foundrow = ads_local.find("eq_id = " + string(al_target_id), 1, ads_local.rowcount())
	if ll_foundrow > 0 then lds_source = ads_local
end if

if not isvalid(lds_source) then
	lds_source = sds_equip
	ll_foundrow = of_find(al_target_id)
end if

if ll_foundrow > 0 then
	astr_target.eq_id = lds_source.object.eq_id[ll_foundrow]
	astr_target.eq_type = lds_source.object.eq_type[ll_foundrow]
	astr_target.eq_ref = lds_source.object.eq_ref[ll_foundrow]
	astr_target.eq_outside = lds_source.object.eq_outside[ll_foundrow]
	astr_target.eq_status = lds_source.object.eq_status[ll_foundrow]
	astr_target.eq_length = lds_source.object.eq_length[ll_foundrow]
	astr_target.eq_height = lds_source.object.eq_height[ll_foundrow]
//	astr_target.eq_volume = lds_source.object.eq_volume[ll_foundrow]
	astr_target.eq_axles = lds_source.object.eq_axles[ll_foundrow]
	astr_target.eq_air = lds_source.object.eq_air[ll_foundrow]
	astr_target.eq_spec1 = lds_source.object.eq_spec1[ll_foundrow]
	astr_target.eq_spec2 = lds_source.object.eq_spec2[ll_foundrow]
	astr_target.eq_spec3 = lds_source.object.eq_spec3[ll_foundrow]
	astr_target.eq_spec4 = lds_source.object.eq_spec4[ll_foundrow]
	astr_target.eq_spec5 = lds_source.object.eq_spec5[ll_foundrow]
	astr_target.eq_cur_event = lds_source.object.eq_cur_event[ll_foundrow]
	astr_target.eq_next_event = lds_source.object.eq_next_event[ll_foundrow]
	astr_target.oe_from = lds_source.object.oe_from[ll_foundrow]
	astr_target.oe_for = lds_source.object.oe_for[ll_foundrow]
	astr_target.oe_booknum = lds_source.object.oe_booknum[ll_foundrow]
	astr_target.oe_out = lds_source.object.oe_out[ll_foundrow]
	astr_target.oe_in = lds_source.object.oe_in[ll_foundrow]
	astr_target.oe_orig_event = lds_source.object.oe_orig_event[ll_foundrow]
	astr_target.oe_term_event = lds_source.object.oe_term_event[ll_foundrow]
	astr_target.fkequipmentleasetype = lds_source.object.equipmentlease_fkequipmentleasetype[ll_foundrow]

	if gnv_cst_companies.of_get_info(astr_target.oe_from, lstr_company, false) = 1 then &
		astr_target.from_name = lstr_company.co_name
	if gnv_cst_companies.of_get_info(astr_target.oe_for, lstr_company, false) = 1 then &
		astr_target.for_name = lstr_company.co_name

	return 1
else
	return ll_foundrow
end if
end function

public function integer of_get_info (long al_target_id, ref s_eq_info astr_target, boolean ab_force_refresh);datastore lds_local

return this.of_get_info(al_target_id, astr_target, lds_local, ab_force_refresh)
end function

public function integer of_get_info (long al_target_id, ref s_eq_info astr_target, datastore ads_local);boolean lb_force_refresh = false

return this.of_get_info(al_target_id, astr_target, ads_local, lb_force_refresh)
end function

public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_target_row);string lsa_source_alias[], lsa_target_alias[]

return this.of_copy_by_column(al_id, apo_target, al_target_row, &
	lsa_source_alias, lsa_target_alias)
end function

public function integer of_type_to_category (string as_type);//Return values:  2 (Tractors), 3 (Trailers), 4 (Containers), null (invalid type)

//Note : These are equivalent to n_cst_Constants.ci_EquipmentCategory_PowerUnits, 
//n_cst_Constants.ci_EquipmentCategory_TrailerChassis, and
//n_cst_Constants.ci_EquipmentCategory_Containers

integer li_category

choose case as_type
case "T", "S", "N"
	li_category = 2
case "V", "F", "R", "K", "B", "H"
	li_category = 3
case "C"
	li_category = 4
case else
	setnull(li_category)
end choose

return li_category
end function

public function boolean of_valid_category (integer ai_category);boolean lb_valid

choose case ai_category
case 1, 2, 3, 4
	lb_valid = true
end choose

return lb_valid
end function

public function integer of_get_description (long al_target, string as_type, ref string as_description);//Return Values: 1 = Success, 0 = ID not found (no error), -1 = Error
//		An al_target ID of null will return 1, with as_description = null
//		as_description will be set to either the valid description or null for all return codes

//Modifications:
//3.0.08 BKW  Added "REF_ONLY!" option, eliminated some in-code returns.

integer li_result
string ls_work, ls_description
s_eq_info lstr_equip

Integer	li_Return = 1

SetNull ( as_description )
if isnull(al_target) then return 1

li_result = This.of_get_info(al_target, lstr_equip, false)

CHOOSE CASE li_result

CASE IS > 0
	//Got equipment info ok.

CASE 0  //Equipment not found.
	li_Return = 0

CASE ELSE //-1  Error, or unexpected result value.
	li_Return = -1

END CHOOSE


IF li_Return = 1 THEN

	ls_work = ""

	choose case as_type

	case "SPECS!"

		if lstr_equip.eq_length > 0 then
			ls_work += string(lstr_equip.eq_length, "0")
			choose case lstr_equip.eq_type
			case "H", "C"
				//96 width gets confused with 9'6'' high-cube height
			case else
				if lstr_equip.eq_height > 0 then ls_work += " - " + string(lstr_equip.eq_height, "0")
			end choose
		end if
		ls_description += ls_work

	case "SHORT_REF!", "LONG_REF!", "REF_ONLY!"

		choose case as_type

		case "SHORT_REF!"
			choose case lstr_equip.eq_type
			case "Z"
				ls_work = "----"
			case "T"
				ls_work = "TRAC"
			case "S"
				ls_work = "STRT"
			case "N"
				ls_work = "VAN"
			case "V"
				ls_work = "TRLR"
			case "F"
				ls_work = "FLBD"
			case "R"
				ls_work = "REFR"
			case "K"
				ls_work = "TANK"
			case "B"
				ls_work = "RBOX"
			case "C"
				ls_work = "CNTN"
			case "H"
				ls_work = "CHAS"
			end choose
		case "LONG_REF!"
			choose case lstr_equip.eq_type
			case "Z"
				ls_work = "----"
			case "T"
				ls_work = "TRACTOR"
			case "S"
				ls_work = "STRAIGHT TRUCK"
			case "N"
				ls_work = "VAN"
			case "V"
				ls_work = "TRAILER"
			case "F"
				ls_work = "FLATBED"
			case "R"
				ls_work = "REEFER"
			case "K"
				ls_work = "TANKER"
			case "B"
				ls_work = "RAILBOX"
			case "C"
				ls_work = "CONTAINER"
			case "H"
				ls_work = "CHASSIS"
			end choose

		CASE "REF_ONLY!"
			//Don't label the equipment type.

		CASE ELSE  //Unexpected formatting value
			li_Return = -1

		END CHOOSE


		if li_Return = 1 THEN

			IF len(trim(lstr_equip.eq_ref)) > 0 then

				IF Len ( ls_Work ) > 0 THEN
					ls_Work += " "
				END IF
	
				ls_work += trim(lstr_equip.eq_ref) // + " "
	
				//IMPORTANT!!! : This drops the trailing space that we had in gf_eqref, 
				//for various bizarre reasons in dispatch.  Keep this in mind when doing
				//a conversion.
				ls_description = ls_work
	
			else
				li_Return = -1

			END IF

		end if

	end choose

END IF


IF li_Return = 1 THEN
	as_description = ls_description
END IF

RETURN li_Return
end function

public function long of_eq_info (datastore ds_local, string find_ref, string find_type, ref s_eq_info eqs);//*****THIS IS A RELOCATION OF gf_eq_info(), for legacy purposes.*****
//I tried to alter it as little as possible, even though some of the services 
//are duplicated elsewhere in this object.


long sourcerow, global_rows, local_rows, local_ids[], foundid, numlocal, numtotal, foundrow
string findstr, msgstr
datastore ds_source
n_cst_anyarraysrv lnv_anyarray

global_rows = sds_equip.rowcount()
if isvalid(ds_local) then local_rows = ds_local.rowcount()

if isnull(find_ref) and isnull(find_type) then
	if eqs.eq_id > 0 then
		if local_rows > 0 then &
			sourcerow = ds_local.find("eq_id = " + string(eqs.eq_id), 1, local_rows)
		if sourcerow > 0 then
			ds_source = ds_local
		elseif eqs.eq_id > 10000000 then
			sourcerow = of_find(eqs.eq_id)
			if sourcerow > 0 then ds_source = sds_equip else return sourcerow
		else
			return 0
		end if
	else
		return -1
	end if
else
	find_ref = trim(find_ref)
	if len(find_ref) > 0 then

//		if sb_equip_retrieved = false then
//			if gf_refresh("EQUIP") = -1 then return -1
//			global_rows = sds_equip.rowcount()
//		end if
		if sb_equip_retrieved = false then
			if of_RefreshActive ( ) = -1 then return -1
			global_rows = sds_equip.rowcount()
		end if


		findstr = "eq_ref = '" + find_ref + "' and eq_status = 'K'"
		if isnumber(find_type) then
			choose case integer(find_type)
				case 200
					find_type = "TSN"
				case 300
					find_type = "VFRKBH"
				case 400
					find_type = "C"
				case else
					return -1
			end choose
		end if
		if len(find_type) > 0 then findstr += " and pos('" + find_type + "', eq_type) > 0"
		if local_rows > 0 then
			do
				foundrow = ds_local.find(findstr, foundrow + 1, local_rows)
				if foundrow > 0 then
					numlocal ++
					local_ids[numlocal] = ds_local.object.eq_id[foundrow]
					sourcerow = foundrow
				end if
			loop while foundrow > 0 and foundrow < local_rows
			numtotal = numlocal
			foundrow = 0
		end if
		if global_rows > 0 then
			do
//				foundrow = sds_equip.find(findstr, foundrow + 1, global_rows)
				foundrow = sds_equip.find(findstr, foundrow + 1, global_rows)
				if foundrow > 0 then
//					foundid = sds_equip.object.eq_id[foundrow]
					foundid = sds_equip.object.eq_id[foundrow]
					if numlocal > 0 then
						if lnv_anyarray.of_FindLong(local_ids, foundid, 1, numlocal) > 0 then continue
					end if
					numtotal ++
					sourcerow = foundrow
				end if
			loop while foundrow > 0 and foundrow < global_rows
		end if
	end if
	if numtotal = 1 then
//		if numlocal = 1 then ds_source = ds_local else ds_source = sds_equip
		if numlocal = 1 then ds_source = ds_local else ds_source = sds_equip
	else
		if numtotal > 1 then
			msgstr = "There is more than one piece of active equipment of the required type "+&
				"with the reference number that you specified.  Please use the selection "+&
				"list instead."
			numtotal *= -1
		elseif len(find_ref) > 0 then
			msgstr = "Could not find active equipment of the required type with the "+&
				"reference number that you specified.  You may need to edit your entry, "+&
				"or refresh the equipment list."
		else
			msgstr = "The reference number you have entered is invalid.~n~nPlease edit "+&
				"your entry and retry."
		end if
		messagebox("Equipment Selection", msgstr, exclamation!)
		return numtotal
	end if
end if

eqs.eq_id = ds_source.object.eq_id[sourcerow]
eqs.eq_type = ds_source.object.eq_type[sourcerow]
eqs.eq_ref = ds_source.object.eq_ref[sourcerow]
eqs.eq_outside = ds_source.object.eq_outside[sourcerow]
eqs.eq_status = ds_source.object.eq_status[sourcerow]
eqs.eq_length = ds_source.object.eq_length[sourcerow]
eqs.eq_height = ds_source.object.eq_height[sourcerow]
eqs.eq_axles = ds_source.object.eq_axles[sourcerow]
eqs.eq_air = ds_source.object.eq_air[sourcerow]
eqs.eq_spec1 = ds_source.object.eq_spec1[sourcerow]
eqs.eq_spec2 = ds_source.object.eq_spec2[sourcerow]
eqs.eq_spec3 = ds_source.object.eq_spec3[sourcerow]
eqs.eq_spec4 = ds_source.object.eq_spec4[sourcerow]
eqs.eq_spec5 = ds_source.object.eq_spec5[sourcerow]
eqs.eq_cur_event = ds_source.object.eq_cur_event[sourcerow]
eqs.eq_next_event = ds_source.object.eq_next_event[sourcerow]

eqs.oe_from = ds_source.object.oe_from[sourcerow]
eqs.oe_for = ds_source.object.oe_for[sourcerow]
eqs.oe_booknum = ds_source.object.oe_booknum[sourcerow]
eqs.oe_out = ds_source.object.oe_out[sourcerow]
eqs.oe_in = ds_source.object.oe_in[sourcerow]
eqs.oe_orig_event = ds_source.object.oe_orig_event[sourcerow]
eqs.oe_term_event = ds_source.object.oe_term_event[sourcerow]
eqs.fkequipmentleasetype = ds_source.object.equipmentlease_fkequipmentleasetype[sourcerow]

return 1
end function

public function integer of_sync (powerobject apo_source, boolean ab_allrows, boolean ab_alldata);Integer	li_Return, &
			li_Buffer
Long		ll_RowCount, &
			ll_Count, &
			ll_Row, &
			lla_Ids []
DWBuffer	le_Buffer

DataWindow	ldw_Source
DataStore	lds_Source
n_cst_Dws	lnv_Dws
n_cst_Dx		ldx_Source

n_cst_ShipmentManager	lnv_ShipmentMgr

IF ldx_Source.of_SetRequestor ( apo_Source ) = -1 THEN
	RETURN -1
END IF

ldx_Source.of_ResolveRequestor ( ldw_Source, lds_Source )

li_Return = gf_Rows_Sync ( lds_Source, ldw_Source, sds_equip, null_dw, Primary!, ab_AllRows, ab_AllData )

IF li_Return = 1 THEN
	sdt_equip_updated = DateTime ( Today ( ), Now ( ) )
END IF

FOR li_Buffer = 1 TO 3

	le_Buffer = lnv_Dws.of_GetBuffer ( li_Buffer )

	CHOOSE CASE le_Buffer

	CASE Primary!

		ll_RowCount = ldx_Source.of_RowCount ( )
		IF ll_RowCount > 0 THEN
			IF ldx_Source.of_ResolveRequestor ( ) = DataWindow! THEN
				lla_Ids = ldw_Source.Object.eq_id.Primary
			ELSE
				lla_Ids = lds_Source.Object.eq_id.Primary
			END IF
		END IF
		ll_Count = ll_RowCount

	CASE Filter!, Delete!

		IF le_Buffer = Filter! THEN
			ll_RowCount = ldx_Source.of_FilteredCount ( )
		ELSE
			ll_RowCount = ldx_Source.of_DeletedCount ( )
		END IF

		FOR ll_Row = 1 TO ll_RowCount
			ll_Count ++
			lla_Ids [ ll_Count ] = ldx_Source.of_GetItemNumber ( ll_Row, "eq_id", le_Buffer, FALSE )
		NEXT

	END CHOOSE

NEXT
// I commented this because the resulting processing was putting single char values in the current event
// column in the shipment summary cache. Also the entire processing is not needed functionality anymore.
//<<*>>
//lnv_ShipmentMgr.of_UpdateEquipment ( lla_Ids )

//////////////TESTING --- DELETE THIS
//String	ls_Message
//
//FOR ll_Row = 1 TO ll_Count
//	ls_Message += String ( lla_Ids [ ll_Row ] ) + " "
//NEXT
//
//MessageBox ( "Test", ls_Message )
//
//////////////////////////////////


RETURN li_Return
end function

public function integer of_copycache (powerobject apo_target);n_cst_Dws	lnv_Dws
DataWindow	ldw_Target
DataStore	lds_Target

if sb_equip_retrieved = false then
//	if gf_refresh("EQUIP") = -1 then
	IF of_RefreshActive ( ) = -1 THEN
		RETURN -1
	END IF
end if

IF sds_equip.RowCount ( ) > 0 THEN
	
	CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )
	CASE DataWindow!
		ldw_Target.Object.Data.Primary = sds_equip.Object.Data.Primary
	CASE DataStore!
		lds_Target.Object.Data.Primary = sds_equip.Object.Data.Primary
	CASE ELSE
		RETURN -1
	END CHOOSE

END IF

RETURN 1
end function

public function integer of_refreshactive ();DataStore	lds_Work
Boolean		lb_RetainWork, &
				lb_SyncToCache
String		ls_Where

lb_RetainWork = FALSE
lb_SyncToCache = TRUE
ls_Where = "WHERE eq_status = 'K'"

IF of_RetrieveWithCompanyInfo ( lds_Work, ls_Where, lb_RetainWork, lb_SyncToCache ) = -1 THEN
	RETURN -1
ELSE
	sb_equip_retrieved = true
	sdt_equip_refreshed = datetime(today(), now())
	sdt_equip_updated = sdt_equip_refreshed
	RETURN 1
END IF
end function

public function integer of_getcurrentevent (long al_id, ref n_cst_msg anv_msg);Long	ll_Row
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
n_cst_Conversion	lnv_Conversion

ll_Row = of_Find ( al_Id )

IF ll_Row > 0 THEN

	lstr_Parm.is_Label = "ID"
	lnv_Conversion.of_SetAnyTypeLong ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = sds_equip.Object.eq_cur_event [ ll_Row ]
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	lstr_Parm.is_Label = "TYPE"
	lnv_Conversion.of_SetAnyTypeString ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = sds_equip.Object.curev_type [ ll_Row ]
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	lstr_Parm.is_Label = "SITE"
	lnv_Conversion.of_SetAnyTypeLong ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = sds_equip.Object.curev_site [ ll_Row ]
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	lstr_Parm.is_Label = "ARRDATE"
	lnv_Conversion.of_SetAnyTypeDate ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = sds_equip.Object.curev_arrdate [ ll_Row ]
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	lstr_Parm.is_Label = "ARRTIME"
	lnv_Conversion.of_SetAnyTypeTime ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = sds_equip.Object.curev_arrtime [ ll_Row ]
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	lstr_Parm.is_Label = "DEPTIME"
//	lnv_Conversion.of_SetAnyTypeTime ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = sds_equip.Object.curev_deptime [ ll_Row ]
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	anv_Msg = lnv_Msg
	RETURN 1

ELSE

	anv_Msg = lnv_Msg
	RETURN 0

END IF
end function

public subroutine of_openitinerary (long al_id, date ad_date);//s_Anys		lstr_Open
w_Dispatch	lw_Dispatch
Integer		li_Type
s_Eq_Info	lstr_Equipment
n_cst_AppServices	lnv_AppServices
S_Parm		lstr_Parm
n_cst_Msg	lnv_Msg


IF This.of_Get_Info ( al_Id, lstr_Equipment, FALSE ) = 1 THEN

	li_Type = This.of_GetItinType ( lstr_Equipment.eq_Type )
//
//	lstr_Open.Anys [ 1 ] = "ITIN"
//	lstr_Open.Anys [ 2 ] = li_Type
//	lstr_Open.Anys [ 3 ] = al_Id
//	lstr_Open.Anys [ 4 ] = ad_Date
	
	lstr_Parm.is_Label = "CATEGORY"
	lstr_Parm.ia_Value = "ITIN"
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "TYPE"
	lstr_Parm.ia_Value = li_Type
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "ID"
	lstr_Parm.ia_Value = al_Id
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "DATE"
	lstr_Parm.ia_Value = ad_Date
	lnv_msg.of_Add_Parm ( lstr_Parm ) 	
	


	OpenSheetWithParm ( lw_Dispatch, lnv_msg, lnv_AppServices.of_GetFrame ( ), 0, Layered! )

ELSE

	MessageBox ( "Display Itinerary", "Could not process request.  Request cancelled.", &
		Exclamation! )

END IF
end subroutine

public function long of_local_eq (long al_id, any aa_target);//*****THIS IS A RELOCATION OF gf_local_eq(), for legacy purposes.*****
//I tried to alter it as little as possible, for safety reasons.

//Note: Passing the dw/ds as an any was an early experiment.  This needs to be revised, 
//but I don't want to propagate those changes in the code without changing the way this
//object is called, too.  So, I'm just going to patch the code for now.

n_cst_numerical lnv_numerical

PowerObject	apo_Target  //I'm going to pretend this is the argument, instead of the any
apo_Target = aa_Target


Long	ll_FoundRow, &
		ll_TargetCount
String	ls_Expression
DataWindow	ldw_Target
DataStore	lds_Target
n_cst_Dws	lnv_Dws


//Check that the id requested is valid

IF lnv_numerical.of_IsNullOrNotPos ( al_Id ) THEN
	RETURN -1
END IF


//Look to see if the id requested is already in the target, and if so, return the row

ll_TargetCount = lnv_Dws.of_RowCount ( apo_Target )
ls_Expression = "eq_id = " + String ( al_Id )
ll_FoundRow = lnv_Dws.of_Find ( apo_Target, ls_Expression, 1, ll_TargetCount )

IF ll_FoundRow > 0 THEN
	RETURN ll_FoundRow
END IF


//Look for the id requested in the cache

ll_FoundRow = of_Find ( al_Id )

IF ll_FoundRow > 0 THEN

	//Copy the cache information to the target, and return the new row number

	ll_TargetCount ++

	CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

	CASE DataWindow!
		sds_equip.RowsCopy ( ll_FoundRow, ll_FoundRow, Primary!, ldw_Target, ll_TargetCount, Primary! )
		ldw_Target.SetItemStatus ( ll_TargetCount, 0, Primary!, DataModified! )
		ldw_Target.SetItemStatus ( ll_TargetCount, 0, Primary!, NotModified! )

	CASE DataStore!
		sds_equip.RowsCopy ( ll_FoundRow, ll_FoundRow, Primary!, lds_Target, ll_TargetCount, Primary! )
		lds_Target.SetItemStatus ( ll_TargetCount, 0, Primary!, DataModified! )
		lds_Target.SetItemStatus ( ll_TargetCount, 0, Primary!, NotModified! )

	CASE ELSE
		RETURN -1

	END CHOOSE

	RETURN ll_TargetCount

END IF


//Couldn't locate the requested id

RETURN -1
end function

public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_targetrow, readonly string asa_source_alias[], readonly string asa_target_alias[]);//This function is similar to n_cst_dws.of_copy_by_column, but instead of passing a data 
//source and row, you pass a source id, and that gets mapped to the source row in the cache.
//This is very similar to n_cst_Companies.of_Copy_By_Column

integer li_target_count, li_target_ndx
long ll_source_row
string lsa_target_columns[], ls_TargetColumn, ls_Work
s_co_info lstr_company
n_cst_Dws	lnv_Dws
n_cst_numerical lnv_numerical

choose case apo_target.typeof()
case datawindow!, datastore!
	//Types are valid.  No processing needed.
case else
	return -1
end choose

ll_source_row = of_find(al_id)
if ll_source_row < 1 then return ll_source_row

li_target_count = lnv_Dws.of_get_column_list(apo_target, lsa_target_columns)

IF lnv_numerical.of_IsNullOrNotPos ( al_TargetRow ) THEN
	al_TargetRow = lnv_Dws.of_InsertRow ( apo_Target, 0 )
END IF

if lnv_Dws.of_copy_by_column(sds_equip, ll_source_row, apo_target, al_TargetRow, &
	asa_source_alias, asa_target_alias) < 1 then return -1

for li_target_ndx = 1 to li_target_count

	ls_TargetColumn = lsa_target_columns[li_target_ndx]

	choose case ls_TargetColumn  //These are special cases (target columns not in the cache)
	case "from_name", "xx_from_name"
		if gnv_cst_companies.of_get_info(sds_equip.object.oe_from[ll_source_row], lstr_company, false) = 1 then
			lnv_Dws.of_SetItem ( apo_Target, al_TargetRow, ls_TargetColumn, lstr_Company.co_Name )
		end if
	case "for_name", "xx_for_name"
		if gnv_cst_companies.of_get_info(sds_equip.object.oe_for[ll_source_row], lstr_company, false) = 1 then
			lnv_Dws.of_SetItem ( apo_Target, al_TargetRow, ls_TargetColumn, lstr_Company.co_Name )
		end if
	case "description", "xx_description"
		if this.of_get_description(al_id, "SPECS!", ls_Work) = 1 then
			lnv_Dws.of_SetItem ( apo_Target, al_TargetRow, ls_TargetColumn, ls_Work )
		end if
	end choose

next

return 1
end function

public function n_ds of_get_ds_equipment ();return sds_equip
end function

public function boolean of_get_retrieved_equip ();return sb_equip_retrieved
end function

public subroutine of_set_retrieved_equip (boolean ab_switch);sb_equip_retrieved = ab_switch
end subroutine

public function datetime of_get_refreshtime_equip ();return sdt_equip_refreshed
end function

public subroutine of_set_refreshtime_equip (datetime adt_datetime);sdt_equip_refreshed = adt_datetime
end subroutine

public function datetime of_get_updatetime_equip ();return sdt_equip_updated
end function

public subroutine of_set_updatetime (datetime adt_datetime);sdt_equip_updated = adt_datetime
end subroutine

public function integer of_refresh ();//Returns: 1, 0 (Refresh Successful, but no changes), -1
//Note:  0 is not currently possible here

//Note : We may ultimately want to make cache destruction like this a function of n_cst_CacheManager.

Constant String	ls_Dlk = "n_cst_dlk_EquipmentCache"
n_cst_bcm	lnv_OldCache, &
				lnv_NewCache

Integer	li_Return = -1
SetPointer ( HourGlass! )

//Get a reference to the current cache, and destroy it in order to force refresh upon next access.

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Dlk, lnv_OldCache, FALSE, FALSE ) = 1 THEN
	gnv_BcmMgr.DestroyBcm ( lnv_OldCache )
END IF


IF This.of_GetCache ( lnv_NewCache ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


////Returns: 1, 0 (Refresh Successful, but no changes), -1
//
//Constant String	ls_Dlk = "n_cst_dlk_EquipmentCache"
//String	ls_MaxTimeStamp1, &
//			ls_MaxTimeStamp2
//DateTime	ldt_LastChange, &
//			ldt_NewMax1, &
//			ldt_NewMax2, &
//			ldt_NewMax
//Integer	li_Return
//n_cst_bcm		lnv_bcm, &
//					lnv_Cache
//n_cst_database	lnv_database
//n_cst_query		lnv_query
//
//li_Return = -1
//SetPointer ( HourGlass! )
//
//IF gnv_App.inv_CacheManager.of_HasCache ( ls_Dlk ) THEN
//
//	ldt_LastChange = sdt_LastChange
//
//	lnv_database = gnv_bcmmgr.GetDatabase()
//	If IsValid(lnv_database) Then
//		lnv_query = lnv_database.GetQuery()
//		lnv_query.SetArgument( ldt_LastChange )
//		lnv_Bcm = lnv_query.ExecuteQuery(ls_Dlk, "", "Refresh")
//	End If
//
//
//	IF IsValid ( lnv_Bcm ) THEN
//
//		IF lnv_Bcm.GetView().RowCount ( ) > 0 THEN
//
//			ls_MaxTimeStamp1 = lnv_Bcm.GetView().Describe ( "Evaluate ( 'Max ( equipment_timestamp )', 1 )" )
//			ls_MaxTimeStamp2 = lnv_Bcm.GetView().Describe ( "Evaluate ( 'Max ( equipmentlease_timestamp )', 1 )" )
//	
//			IF Len ( ls_MaxTimeStamp1 ) > 1 THEN  //Prevent empty or !
//				ldt_NewMax1 = DateTime ( ls_MaxTimeStamp1 )
//			END IF
//
//			IF Len ( ls_MaxTimeStamp2 ) > 1 THEN  //Prevent empty or !
//				ldt_NewMax2 = DateTime ( ls_MaxTimeStamp2 )
//			END IF
//
//			IF ldt_NewMax1 > ldt_NewMax2 THEN
//				ldt_NewMax = ldt_NewMax1
//			ELSE
//				ldt_NewMax = ldt_NewMax2
//			END IF
//
//			IF ldt_NewMax > sdt_LastChange THEN
//				sdt_LastChange = ldt_NewMax
//				//If there was an error check on of_Cache, below, this should be set after that.
//			END IF
//
//			li_Return = 1
//
//		ELSE
//			li_Return = 0
//
//		END IF
//
//		Constant Boolean	lb_DestroySource = TRUE
//		gnv_App.inv_CacheManager.of_Cache ( lnv_Bcm, lb_DestroySource )
//		//I'm calling this even if there's no rows because we need to destroy the bcm
//
//	END IF
//
//ELSE
//
//	IF gnv_App.inv_CacheManager.of_Cache ( ls_Dlk ) = 1 THEN
//		li_Return = 1
//	END IF
//
//END IF
//
//
////We could conceivably call of_RefreshCalculations here, but at present we're leaving it
////up to the calling script to do that in a separate call if it wants to.
//
//RETURN li_Return
end function

public function integer of_getcache (ref n_cst_bcm anv_cache);//Returns: 1, -1   (Cache is passed back by reference in anv_Cache)
//Will attempt to retrieve the cache, if it hasn't been retrieved already.

n_cst_bcm	lnv_Cache
Integer		li_Return

li_Return = -1


IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlk_EquipmentCache", lnv_Cache, TRUE, TRUE ) = 1 THEN

	li_Return = 1
END IF


anv_Cache = lnv_Cache

RETURN li_Return
end function

public function integer of_refreshcalculations ();//Performs of_RefreshCalculations on the equipment cache, if it exists  (will not
//force create or retrieve if it does not exist already.)
//Returns:  1, 0 (Cache does not exist), -1

n_cst_bcm	lnv_Cache
Integer		li_Return

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlk_EquipmentCache", lnv_Cache, FALSE, FALSE ) = 1 THEN
	li_Return = This.of_RefreshCalculations ( lnv_Cache )
ELSE
	li_Return = 0
END IF

RETURN li_Return
end function

public function integer of_refreshcalculations (readonly n_cst_bcm anv_bcm);//Note:  This function is expecting a bcm with d_EquipmentCache as the view ds.
//This is called by the dlk during retrieval, as well as calls initiated by ui.
//Returns:  1, -1

Long		ll_RowCount, &
			ll_Row

DWObject	ldwo_FreeTimeExpiration, &
			ldwo_Charges, &
			ldwo_LeaseId

n_cst_beo_EquipmentLease	lnv_Lease
DataStore	lds_View
Integer		li_Return

li_Return = 1

IF IsValid ( anv_Bcm ) THEN

	lds_View = anv_Bcm.GetView ( )
	ll_RowCount = lds_View.RowCount ( )
	
	
	IF ll_RowCount > 0 THEN
	
		//If there are rows to work on, instantiate column references, and cache any
		//referenced companies.  If no rows, they won't be needed.
	
		ldwo_FreeTimeExpiration = lds_View.Object.EquipmentLease_FreeTimeExpiration
		ldwo_Charges = lds_View.Object.EquipmentLease_Charges
		ldwo_LeaseId = lds_View.Object.EquipmentLease_oe_id
	
	END IF
	
	
	FOR ll_Row = 1 TO ll_RowCount
	
		IF ldwo_LeaseId.Primary [ ll_Row ] > 0 THEN
	
			lnv_Lease = anv_Bcm.GetAt ( anv_Bcm.GetBeoIndex ( ll_Row ), "n_cst_beo_EquipmentLease" )
		
			IF IsValid ( lnv_Lease ) THEN
		
				ldwo_FreeTimeExpiration.Primary [ ll_Row ] = lnv_Lease.of_GetFreeTimeExpiration ( )
				ldwo_Charges.Primary [ ll_Row ] = lnv_Lease.of_GetCharges ( )
		
			END IF
	
		END IF
	
	NEXT

ELSE
	li_Return = -1

END IF
	

DESTROY ldwo_FreeTimeExpiration
DESTROY ldwo_Charges
DESTROY ldwo_LeaseId

RETURN li_Return
end function

public function string of_gettypelist (readonly integer ai_category);String	ls_TypeList

//Attempt to build requested type list

CHOOSE CASE ai_Category

CASE n_cst_Constants.ci_EquipmentCategory_PowerUnits
	ls_TypeList = "TSN"

CASE n_cst_Constants.ci_EquipmentCategory_TrailerChassis
	ls_TypeList = "VFRKBH"

CASE n_cst_Constants.ci_EquipmentCategory_Containers
	ls_TypeList = "C"

CASE n_cst_Constants.ci_EquipmentCategory_All
	ls_TypeList += This.of_GetTypeList ( n_cst_Constants.ci_EquipmentCategory_PowerUnits )
	ls_TypeList += This.of_GetTypeList ( n_cst_Constants.ci_EquipmentCategory_TrailerChassis )
	ls_TypeList += This.of_GetTypeList ( n_cst_Constants.ci_EquipmentCategory_Containers )

CASE ELSE  //Unrecognized category request
	SetNull ( ls_TypeList )

END CHOOSE

RETURN ls_TypeList
end function

public function string of_gettypefilter (readonly string as_column, readonly integer ai_category);String	ls_TypeList, &
			ls_Filter

SetNull ( ls_Filter )

CHOOSE CASE ai_Category

CASE n_cst_Constants.ci_EquipmentCategory_All
	ls_Filter = ""

CASE ELSE
	ls_TypeList = This.of_GetTypeList ( ai_Category )
	
	IF NOT IsNull ( ls_TypeList ) THEN
		ls_Filter = "Pos ( '" + ls_TypeList + "', " + as_Column + " ) > 0"
	END IF

END CHOOSE

RETURN ls_Filter
end function

public subroutine of_opendriveritinerary (readonly long al_id, readonly date ad_date);w_Dispatch	lw_Dispatch
n_cst_AppServices	lnv_AppServices
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "CATEGORY"
lstr_Parm.ia_Value = "ITIN"
lnv_msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "TYPE"
lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Driver
lnv_msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "ID"
lstr_Parm.ia_Value = al_Id
lnv_msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "DATE"
lstr_Parm.ia_Value = ad_Date
lnv_msg.of_Add_Parm ( lstr_Parm ) 


OpenSheetWithParm ( lw_Dispatch, lnv_msg, lnv_AppServices.of_GetFrame ( ), 0, Layered! )
end subroutine

public function integer of_getitintype (readonly string as_equipmenttype);//Returns:  The ItinType value for the requested equipment type, or Null if
//it cannot be determined.

Integer	li_ItinType

CHOOSE CASE as_EquipmentType

CASE "T", "S", "N"
	li_ItinType = gc_Dispatch.ci_ItinType_PowerUnit

CASE "V", "F", "R", "K", "B", "H"
	li_ItinType = gc_Dispatch.ci_ItinType_TrailerChassis

CASE "C"
	li_ItinType = gc_Dispatch.ci_ItinType_Container

CASE else
	SetNull ( li_ItinType )

END CHOOSE

RETURN li_ItinType
end function

public function string of_getdescriptions (long ala_ids[], string as_describetype, boolean ab_describeerrors, boolean ab_ignorenulls);//Assembles a list of equipment descriptions for the ids provided.
//Returns : The assembled list.

Long		ll_Count, &
			ll_Index
String	ls_Work, &
			ls_List

ll_Count = UpperBound ( ala_Ids )

FOR ll_Index = 1 TO ll_Count

	IF ab_IgnoreNulls = TRUE THEN
		IF IsNull ( ala_Ids [ ll_Index ] ) THEN
			CONTINUE
		END IF
	END IF

	IF This.of_Get_Description ( ala_Ids [ ll_Index ], &
		as_DescribeType, ls_Work ) = 1 THEN
		//OK
	ELSEIF ab_DescribeErrors = TRUE THEN
		ls_Work = "ERROR: VALUE N/A ( ID = "
		IF IsNull ( ala_Ids [ ll_Index ] ) THEN
			ls_Work += "NULL"
		ELSE
			ls_Work += String ( ala_Ids [ ll_Index ] )
		END IF
		ls_Work += ")"
	END IF

	IF Len ( ls_List ) > 0 THEN
		ls_List += " ; "
	END IF
	ls_List += ls_Work

NEXT

RETURN ls_List
end function

public function boolean of_cancarrycontainer (string as_type);//Returns : TRUE, FALSE (the equipment can't carry a container, or can't be determined.)

Boolean	lb_Return = FALSE

CHOOSE CASE as_Type

CASE "H", "F" //Chassis, Flatbed

	lb_Return = TRUE

END CHOOSE

RETURN lb_Return
end function

protected function long of_retrievewithcompanyinfo (ref datastore ads_work, string as_where, boolean ab_retain_ds, boolean ab_sync);Long	ll_Retrieved

ll_Retrieved = THIS.of_RetrieveWithCompanyInfo ( ads_Work , as_Where )

IF ll_Retrieved > 0 THEN

	if ab_sync then
		of_Sync ( ads_Work )
	end if
END IF

if not ab_retain_ds then destroy ads_work

return ll_retrieved
end function

public function long of_retrievewithcompanyinfo (ref datastore ads_work, string as_where);//Return value is the value returned by the datastore retrieve() attempt

Long			ll_retrieved
Long 			ll_checkloop
Long			lla_companies[]
s_co_info	lstr_company
dwobject 	ldwo_curev_site
dwobject		ldwo_curevco_name
dwobject		ldwo_curevco_city
dwobject		ldwo_curevco_state	
dwobject		ldwo_curevco_tz
dwobject		ldwo_curevco_pcm

ll_Retrieved = THIS.of_Retrieve ( ads_work , as_where )

IF ll_Retrieved > 0 THEN
	
	ldwo_curev_site = ads_work.object.curev_site
	ldwo_curevco_name = ads_work.object.curevco_name
	ldwo_curevco_city = ads_work.object.curevco_city
	ldwo_curevco_state = ads_work.object.curevco_state
	ldwo_curevco_tz = ads_work.object.curevco_tz
	ldwo_curevco_pcm = ads_work.object.curevco_pcm

	lla_companies = ldwo_curev_site.primary
	gnv_cst_companies.of_cache(lla_companies, false)

	for ll_checkloop = 1 to ll_retrieved
		if gnv_cst_companies.of_get_info(ldwo_curev_site.primary[ll_checkloop], lstr_company, false) = 1 then
			ldwo_curevco_name.primary[ll_checkloop] = lstr_company.co_name
			ldwo_curevco_city.primary[ll_checkloop] = lstr_company.co_city
			ldwo_curevco_state.primary[ll_checkloop] = lstr_company.co_state
			ldwo_curevco_tz.primary[ll_checkloop] = lstr_company.co_tz
			ldwo_curevco_pcm.primary[ll_checkloop] = lstr_company.co_pcm
		end if
	next

	destroy ldwo_curev_site
	destroy ldwo_curevco_name
	destroy ldwo_curevco_city
	destroy ldwo_curevco_state
	destroy ldwo_curevco_tz
	destroy ldwo_curevco_pcm
	
END IF

return ll_retrieved
end function

public function long of_retrieve (ref datastore ads_work, string as_where);//Return value is the value returned by the datastore retrieve() attempt
/**
* NOTE: This version will not return company info. If you want company info or want to sync 
*       with cache you should use the other over-loaded versions.
*
*
*/
long 			ll_retrieved
string 		ls_select

if isvalid(ads_work) then
	if isvalid(sds_equip) then
		//This is just a precaution.  Nobody should be passing this.
		if ads_work = sds_equip then return -1
	end if
	destroy ads_work
end if

ads_work = create datastore
ads_work.dataobject = sds_equip.dataobject
ads_work.settransobject(sqlca)

ls_select = ads_work.object.datawindow.table.select
ls_select = left(ls_select, pos(ls_select, "WHERE") - 1)

if not isnull(as_where) then ls_select += " " + as_where

ads_work.object.datawindow.table.select = ls_select

ll_retrieved = ads_work.retrieve()

if ll_retrieved = -1 then
	rollback ;
else
	commit ;
end if

return ll_retrieved

end function

public function long of_retrieve (ref datastore ads_work, long ala_ids[], boolean ab_withcompanyinfo);//Returns : >= 0 (The number of rows retrieved), -1 (Error)

n_cst_Sql	lnv_Sql
String		ls_Where

Long	ll_Return


IF ll_Return = 0 THEN

	ls_Where = "WHERE eq_Id " + lnv_Sql.of_MakeInClause ( ala_Ids )

	CHOOSE CASE ab_WithCompanyInfo

	CASE TRUE
		ll_Return = This.of_RetrieveWithCompanyInfo ( ads_Work, ls_Where )

	CASE FALSE
		ll_Return = This.of_Retrieve ( ads_Work, ls_Where )

	CASE ELSE
		ll_Return = -1

	END CHOOSE

END IF


IF IsNull ( ll_Return ) THEN
	ll_Return = -1
END IF


RETURN ll_Return
end function

public function string of_getdisplayvalue (character ac_type);String	ls_Work

choose case Upper ( ac_type ) 
	case "Z"
		ls_work = "----"
	case "T"
		ls_work = "TRAC"
	case "S"
		ls_work = "STRT"
	case "N"
		ls_work = "VAN"
	case "V"
		ls_work = "TRLR"
	case "F"
		ls_work = "FLBD"
	case "R"
		ls_work = "REFR"
	case "K"
		ls_work = "TANK"
	case "B"
		ls_work = "RBOX"
	case "C"
		ls_work = "CNTN"
	case "H"
		ls_work = "CHAS"
end choose

RETURN ls_Work

end function

public function long of_getidfromref (string as_ref);DataStore	lds_Results
String		ls_Where
Long			ll_RowCount
Long			ll_Return = -1

ls_Where = "Where eq_ref = '" + as_Ref + "' AND eq_status = 'K' "

ll_RowCount = THIS.of_Retrieve ( lds_Results , ls_Where )

IF ll_RowCount = 0 THEN
	ll_Return = 0
ELSEIF ll_RowCount = 1 THEN
	ll_Return = lds_Results.GetItemNumber ( ll_RowCount , "eq_id" )
ELSE
	ll_Return = -1
END IF

DESTROY ( lds_Results )
	


Return ll_Return
end function

public function integer of_smartsearch (string as_eqref, string as_type, string as_status, ref long ala_eqid[]);long	ll_eqid, &
		ll_CharCount, &
		ll_DBCharCount, &
		lla_TenForTenId[], &
		lla_ElevenForElevenId[], &
		lla_ExactId[], &
		ll_TenForTen, &
		ll_ElevenForEleven, &
		ll_Exact

string	ls_eqref, &
			ls_TrimmedEqRef, &
			ls_TrimmedDBValue

n_cst_string	lnv_string

ls_TrimmedEqRef = UPPER(lnv_string.of_RemoveNonAlphaNumeric(as_eqref))
ll_Charcount=len(ls_TrimmedEqRef)

/* 
	I'm using a cursor because there could be more than one due to a
	hole that allowed duplicate ref numbers for same equipment type.
*/

if ll_CharCount < 10 or ll_CharCount > 11 then
//*** exact search ***//

 DECLARE ExactSearch CURSOR FOR  
  SELECT "equipment"."eq_ref",   
         "equipment"."eq_id"  
    FROM "equipment"  
   WHERE ( "equipment"."eq_type" = :as_type ) AND  
			( "equipment"."eq_status" = :as_status ) AND
			( "equipment"."eq_ref" = :ls_TrimmedEqRef) ;

	OPEN ExactSearch;
	
	DO WHILE sqlca.sqlcode = 0
	
		ls_eqref=''
		ll_eqid=0
		
		FETCH ExactSearch INTO :ls_eqref, :ll_eqid;
	
		ls_TrimmedDBValue = UPPER( lnv_string.of_RemoveNonAlphaNumeric(ls_eqref) )
		
		if ls_TrimmedEqRef=ls_TrimmedDBValue then
			ll_Exact ++
			lla_ExactId[ll_Exact] = ll_eqid
		  EXIT
		END IF
	
	LOOP
	
	CLOSE ExactSearch;
	
end if

if ll_CharCount = 10 or ll_CharCount = 11 then	
//smartsearch

	/* 
		If length < 10  or > 11 then look for exact match
		otherwise ignore fetched value.
		
		If 10 or 11 then check digit can vary. 
		
		1st pass check 11
		2nd pass drop 11th and check 10.
		
		IF arg len 10 then look for db len of 10 or 11 and ignore 11th
		If arg len 11 then look for db len of 10 or 11 and try 11 for 11.
		If no match then try 10 for 10.
		11 for 11 trumps 10 for 10.		
		
		If 10 or 11 then check digit can vary.

	*/
		//declare cursor once
		 DECLARE SmartSearch CURSOR FOR  
		  SELECT "equipment"."eq_ref",   
					"equipment"."eq_id"  
			 FROM "equipment"  
			WHERE ( "equipment"."eq_type" = 'C' ) AND  
					( "equipment"."eq_status" = 'K' );
	
	if ll_CharCount = 11 then

		OPEN SmartSearch;
		
		DO WHILE sqlca.sqlcode = 0
		
			ls_eqref=''
			ll_eqid=0
		
			FETCH SmartSearch INTO :ls_eqref, :ll_eqid;
			
			//strip non alphas
			ls_TrimmedDBValue = UPPER( lnv_string.of_RemoveNonAlphaNumeric(ls_eqref) )
			ll_DBCharCount=len(ls_TrimmedDBValue)
		
			if ll_DBCharCount = 11 then
				if ls_TrimmedEqRef = ls_TrimmedDBValue then
					ll_ElevenForEleven ++
					lla_ElevenForElevenId[ll_ElevenForEleven] = ll_eqid
				end if
			else
				CONTINUE
			end if
			
		LOOP
		
		CLOSE SmartSearch;
	
	end if

	if ll_CharCount = 10 or upperbound(lla_ElevenForElevenId) = 0 then

		OPEN SmartSearch;
		
		DO WHILE sqlca.sqlcode = 0
		
			ls_eqref=''
			ll_eqid=0

			FETCH NEXT SmartSearch INTO :ls_eqref, :ll_eqid;
			
			//strip non alphas
			ls_TrimmedDBValue = UPPER( lnv_string.of_RemoveNonAlphaNumeric(ls_eqref) )
			ll_DBCharCount=len(ls_TrimmedDBValue)
		
			if ll_DBCharCount = 10 or ll_DBCharCount = 11 then
				if left(ls_TrimmedEqRef,10) = left(ls_TrimmedDBValue, 10) then
					ll_TenForTen ++
					lla_TenForTenId[ll_TenForTen] = ll_eqid
				end if			
			else
				CONTINUE
			end if
		
		LOOP
		
		CLOSE SmartSearch;
		
	end if

end if

ll_eqid = 0

choose case upperbound(lla_ExactId)
	case 0	
		//no id, look at 11 for 11 
		choose case upperbound(lla_ElevenForElevenId)
			case 0
				//no id, look at 10 for 10 
				choose case upperbound(lla_TenForTenId)	
					case 0 
						//no id found
					case else
						ala_eqid = lla_TenForTenId
				end choose
				
			case else
				ala_eqid = lla_ElevenForElevenId		
		end choose
	case else
		ala_eqid = lla_ExactId		
end choose
		
return upperbound(ala_eqid)
end function

public function integer of_lastfreedate (date adt_date);
//
/***************************************************************************************
NAME			: of_LastFreeDate
ACCESS		: Public
ARGUMENTS	: Date		
RETURNS		: integer	(0 = No rows found, 1 = Success, -1 = Failure)
DESCRIPTION	: 

If the shipment is a reload then use the reloadshipmentid and expiration date.

If freetime expires is less than or equal to date argument, save id to report on.
Pass each shipment into the notification manager to create a pending notification. 
Call n_cst_Notification_Manager.of_SendPendingNotifications

A datastore (lds_Results) is created to track activity and report to user. 

REVISION		: RDT 110702
				  RDT 2-14-03 disregard/discard/ignore chassis 
				  RDT 6-11-03 	Changed to save pending notifications, not send.
***************************************************************************************/

blob 		lblob_dwstate
Date		ldt_ExpirationDate
Date		ldt_LastFreeDate
Integer	li_Return = 1
Long		ll_RowCount 
Long		ll_ActiveShipment
Long		i
Long		ll_ReloadShipment
Long		lla_contacts[]
String	ls_Activity
Boolean	lb_Reload
Date		ldt_Today	= TODAY ( )
Date		ldt_Storage
Date		ldt_PerDiem

DataStore						lds_Equip
n_cst_Privileges				lnv_Privileges
n_cst_Msg 						lmsg
s_parm 							lstr_parm
n_Cst_Bso_Dispatch	lnv_Dispatch	
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_company 	lnv_company
n_Cst_Presentation_EquipmentSummary	lnv_EqPres

lds_Equip = CREATE DataStore
lds_Equip.dataObject ="d_expiredActiveEquipment"
lds_Equip.SetTransObject ( SQLCA )

lnv_EqPres.of_SetPresentation ( lds_Equip )

SetPointer(HourGlass!)

lnv_Shipment = CREATE n_Cst_beo_Shipment
lnv_Dispatch = CREATE n_cst_bso_Dispatch



//On LFD for storage, we would notify for containers with LFD = Today
//or Earlier that do not have Del By Date (Delivery Appointment Date)
//specified, and have not already been picked up.
ldt_Storage = adt_date


//On LFD for per diem, we would notify for containers with LFD =
//Tomorrow, Today, or Earlier that do not have Empty / Loaded at Customer
//date specified, and have not already been returned.
// if the query is on a friday then we want to take Sunday into account too.
Int	li_NumberOfDaysToMove

IF DayNumber( adt_date ) = 6 THEN
	li_NumberOfDaysToMove = 2
ELSE
	li_NumberOfDaysToMove = 1
END IF

ldt_PerDiem = RelativeDate ( adt_date , li_NumberOfDaysToMove )


If lnv_Privileges.of_HasTIRLFDRights() Then 
			
	lds_Equip.Retrieve( ldt_Storage , ldt_PerDiem )
	lds_Equip.SetFilter ( "equipment_type <> 'H'" )	
	lds_Equip.Filter ( )
	ll_RowCount = lds_Equip.RowCount ( )

	If ll_RowCount > 0  Then 
		
	Else
		li_Return = 0 // no rows found
	End if
	
	lnv_Shipment.of_SetDocumentType( appeon_constant.cs_lfd )
	
	FOR i = 1 TO ll_RowCount 
		ll_ReloadShipment = lds_Equip.GetItemNumber ( i , "outside_equip_reloadshipment" )
		
		IF Not isNull ( ll_ReloadShipment ) THEN
			ll_ActiveShipment = ll_ReloadShipment 
			ldt_ExpirationDate = lds_Equip.GetItemDate ( i , "outside_equip_reloadFreeTimeExpireDate" )
			//ls_Activity +=  "*"
			lb_Reload = TRUE
		ELSE
			ll_ActiveShipment = lds_Equip.GetItemNumber ( i , "outside_equip_shipment" )
			ldt_ExpirationDate = lds_Equip.GetItemDate ( i , "outside_equip_LeaseFreeTimeExpireDate" )
		END IF
		
		lds_Equip.SetItem ( i , "shipment" , ll_ActiveShipment ) 
		
		lnv_Dispatch.of_RetrieveShipment ( ll_ActiveShipment ) 
		
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceID ( ll_ActiveShipment ) 
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
		
		lnv_Shipment.of_GetBillToCompany ( lnv_Company , TRUE )
		IF isValid ( lnv_Company ) THEN
			lds_Equip.SetItem ( i , "billTo" , lnv_Company.of_GetName ( ) ) 
		END IF
		DESTROY ( lnv_Company )
				
		lnv_Shipment.of_GetOrigin ( lnv_Company , TRUE )
		IF isValid ( lnv_Company ) THEN
			lds_Equip.SetItem ( i , "Origin" , lnv_Company.of_GetName ( ) + ": " +lnv_Company.of_getLocation ( ) ) 
		END IF
		DESTROY ( lnv_Company )
		
		lnv_Shipment.of_GetDestination ( lnv_Company , TRUE )
		IF isValid ( lnv_Company ) THEN
			lds_Equip.SetItem ( i , "Destination" , lnv_Company.of_GetName ( ) + ": " +lnv_Company.of_getLocation ( ) ) 
		END IF
		DESTROY ( lnv_Company )
		
		If lnv_Shipment.of_GetLastFreeDateContacts ( lla_contacts[] ) < 1 Then 
			ls_Activity +=  "No Contacts. "
		Else
			// Create Pending Notification
			lnv_Dispatch.of_GetNotificationManager( ).of_CreatePendingNotification ( lnv_Shipment ) 
		End If					
	
		// Per Diem
		If ldt_ExpirationDate <= ldt_PerDiem THEN 
			if ldt_ExpirationDate = ldt_Today Then 
				IF lb_Reload THEN
					ls_Activity += "Reload LFD Perdiem Expires Today. "
				ELSE
					ls_Activity += "LFD Perdiem Expires Today. "
				END IF
				
			elseIF ldt_ExpirationDate < ldt_Today THEN
				IF lb_Reload THEN
					ls_Activity += "Reload LFD Perdiem Expired "+String(ldt_ExpirationDate,"mm/dd/yy") + ". "
				ELSE
					ls_Activity += "LFD Perdiem Expired "+String(ldt_ExpirationDate,"mm/dd/yy") + ". "
				END IF
				
			ELSE 
				IF lb_Reload THEN
					ls_Activity += "Reload LFD Perdiem Expires "+String(ldt_ExpirationDate,"mm/dd/yy") + ". "
				ELSE
					ls_Activity += "LFD Perdiem Expires "+String(ldt_ExpirationDate,"mm/dd/yy") + ". "
				END IF				
			END IF	
		END IF
		
				
		// Storage
		ldt_LastFreeDate = lnv_Shipment.of_GetLastFreeDate ( )
		If ldt_LastFreeDate <= ldt_Storage THEN 
			
			if ldt_LastFreeDate = ldt_Today Then 			
				ls_Activity += "LFD Storage Expires Today"
			elseIF ldt_LastFreeDate < ldt_Today THEN
				ls_Activity += "LFD Storage Has Passed "+String(ldt_LastFreeDate,"mm/dd/yy")
			ELSE
				ls_Activity += "LFD Storage Has Expires "+String(ldt_LastFreeDate,"mm/dd/yy")
			END IF	
		END IF
		
		
		lds_Equip.SetItem ( i , "Description" , ls_Activity ) 
		ls_Activity = ""
		
		lb_Reload = FALSE
	NEXT	
		
	IF li_Return = 1 then 

		lds_Equip.getFullState(lblob_dwstate)
		// Report to User results and ask for confirmation to send. 
		lstr_Parm.is_Label = "dw"
		lstr_Parm.ia_Value = lblob_dwstate
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "title"
		lstr_Parm.ia_Value = "Review and Confirm Last Free Date"
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "message1"
		lstr_Parm.ia_Value = "Please review and click OK to send Notices,"
		lmsg.of_add_parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "message2"
		lstr_Parm.ia_Value = "or click Cancel to stop the process."
		lmsg.of_add_parm ( lstr_Parm )
		
		OpenWithParm(w_Review_confirm, lmsg )
		if Message.StringParm = "OK" Then
			//RDT 6-11-03 	SetPointer ( HourGlass! ) 
			//RDT 6-11-03 	lnv_Dispatch.of_GetNotificationManager( ).of_SendPendingNotifications ( ) 
			if lnv_dispatch.Event pt_save ( ) = 1 then 
				MessageBox("Last Free Date Notice","Notices will be sent at the next email cycle.")	
			else
				MessageBox("Last Free Date Notice","Notifiation save failed. ~nNotices will not be sent. ~`nPlease try again.")	
			end if
		else 
			MessageBox("Last Free Date Notice","Process canceled by user. ~nNotices will not be sent.")	
		end if
	End If
	
	If li_Return = 0 Then 
		MessageBox("Last Free Date Notice","No expired equipment records found.")	
	End If 
	
	
Else		// no rights to perform this.
	MessageBox("Last Free Date Report ",lnv_Privileges.of_getrestrictmessage ( ) )
	li_Return = -1
End If

Destroy lnv_Dispatch
Destroy lds_Equip
Destroy lnv_Shipment 

	
Return li_Return 



end function

public function integer of_addequipmenttoshipment (long al_EqID, long al_ShipmentID);Int	li_Return

IF al_ShipmentID > 0 AND al_EqID > 0 THEN
	li_Return = 1
END IF

IF li_Return = 1 THEN

	UPDATE "outside_equip"  
	SET "shipment" = :al_ShipmentID  
	WHERE "outside_equip"."oe_id" = :al_EqID ;
	
	IF sqlca.sqlcode <> 0 then
		rollback;
		li_Return = -1
	ELSE
		COMMIT;
	END IF
END IF

RETURN li_Return
end function

public function integer of_removetempequipment ();String	ls_Filter

ls_Filter = "eq_id < " + String ( THIS.cl_PermIDStart )

sds_equip.SetFilter ( ls_Filter )
sds_equip.Filter ( ) 

Long	ll_Count
Long	ll_i
ll_Count = sds_equip.RowCount( )

FOR ll_i = ll_Count TO 1 STEP -1
	sds_equip.DeleteRow ( ll_i )	
NEXT

sds_equip.SetFilter ( "" )
sds_equip.Filter ( ) 

RETURN 1
end function

public function boolean of_isequipmentrouted (n_cst_beo_equipment2 anv_equipment, n_cst_bso_dispatch anv_dispatch);Boolean	lb_Return

n_cst_beo_Equipment2	lnv_Equipment
n_cst_bso_dispatch	lnv_Disp

lnv_Equipment = anv_equipment
lnv_Disp = anv_dispatch

IF isValid ( lnv_Equipment ) AND IsValid ( lnv_Disp ) THEN
	lb_Return =  THIS.of_ISEquipmentRouted( lnv_Equipment.of_GetID ( ) , lnv_Equipment.of_GetType ( ) , lnv_Disp )
END IF

RETURN lb_Return
end function

public function boolean of_isequipmentrouted (long al_eqid, string as_eqtype, n_cst_bso_dispatch anv_dispatch);Boolean	lb_Return
Long		ll_ItinRtn
Date		ld_MinItinDate 
Date		ld_MaxItinDate

n_ds						lds_Itin
n_cst_bso_dispatch	lnv_Disp

lnv_Disp = anv_dispatch

//ld_MinItinDate = RelativeDate ( Today ( ), -14 ) 
//ld_MaxItinDate = RelativeDate ( Today ( ), 14 ) 

SetNull ( ld_MinItinDate )
SetNull ( ld_MaxItinDate )

IF IsValid ( lnv_Disp ) THEN
	ll_ItinRtn = lnv_Disp.of_copyitinerary( THIS.of_GetItinType ( as_eqtype ) , al_eqid , ld_MinItinDate, ld_MaxItinDate , lds_Itin )
	DESTROY ( lds_Itin )
	
	CHOOSE CASE ll_ItinRtn
			
		CASE 0 
			lb_Return = FALSE
			
		CASE is > 0 
			lb_Return = TRUE
			
		CASE ELSE
			SetNull ( lb_Return )
			
	END CHOOSE
END IF

RETURN lb_Return
end function

public function integer of_parseisocode (string as_isocode, ref string as_lengthcode, ref string as_gooseneckandheight, ref string as_description);String	ls_Code
String	ls_Length
String	ls_GooseNeck
String	ls_Description


ls_Code = as_isocode

ls_Length = Mid ( ls_Code, 1, 1 )

ls_GooseNeck = Mid ( ls_Code, 2, 1 )

ls_Description = Mid ( ls_Code, 3 , 2 )

as_lengthcode = ls_Length
as_Gooseneckandheight = ls_GooseNeck
as_Description = ls_Description

RETURN 1

end function

public function long of_getequipmentid (string as_eqtype, string as_refnum);long	ll_eqid


 DECLARE equipcur CURSOR FOR  
  SELECT "DBA"."equipment"."eq_id"  
    FROM "DBA"."equipment"  
   WHERE ( "DBA"."equipment"."eq_type" = :as_eqtype ) AND  
         ( "DBA"."equipment"."eq_ref" = :as_refnum ) AND  
         ( "DBA"."equipment"."eq_status" = 'K' )   
           ;

 OPEN equipcur;
 
 FETCH equipcur INTO :ll_eqid;
 
 CLOSE equipcur;
 
 COMMIT;
 
return ll_eqid
end function

public function integer of_displayroutemap (long ala_ids[], date ad_start, date ad_end, w_map aw_map);//Display routes for the requested ids & date range on the map passed in.

//Returns : 1 (Success), 0 (Nothing to process), -1 (Error)

Long		ll_Count, &
			ll_Index, &
			ll_Id, &
			ll_SkippedCount
Integer	li_Type
String	ls_EquipRef
		
s_eq_Info				lstr_Equipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_AnyArraySrv		lnv_Arrays

Integer	li_Return = 1


IF li_Return = 1 THEN

	//Shrink the id array passed in to eliminate nulls & dupes.
	ll_Count = lnv_Arrays.of_GetShrinked ( ala_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )
	
	IF ll_Count > 0 THEN
		//OK
	ELSE
		//No ids in the shrunk array.  Nothing to process.
		li_Return = 0
	END IF
	
END IF


IF li_Return = 1 THEN

	IF IsNull ( ad_Start ) OR IsNull ( ad_End ) OR DaysAfter ( ad_Start, ad_End ) < 0 THEN
	
		//Invalid date range.
		li_Return = -1
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	IF NOT IsValid ( aw_Map ) THEN
		
		li_Return = -1
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	SetPointer ( HourGlass! )

	FOR ll_Index = 1 to ll_Count
		
		ll_Id = ala_Ids [ ll_Index ]
		
		IF This.of_Get_Info ( ll_Id, lstr_Equipment, FALSE ) = 1 THEN
		
			li_Type = This.of_GetItinType ( lstr_Equipment.eq_Type )

			IF This.of_Get_Description ( ll_Id, "SHORT_REF!", ls_EquipRef ) = 1 THEN
		
				//OK
				
			ELSE
				//Shouldn't happen						
				ls_EquipRef = "[No EqRef Avail]"
				
			END IF
			
		ELSE
			
			ll_SkippedCount ++
			CONTINUE
			
		END IF
		

		DESTROY lnv_Dispatch
		lnv_Dispatch = CREATE n_cst_bso_Dispatch
	
	
		CHOOSE CASE lnv_Dispatch.of_RetrieveItinerary ( li_Type, ll_Id, ad_Start, ad_End, FALSE /*Don't retr prior*/ )
				
			CASE 1
				
				IF lnv_Dispatch.of_FilterItinerary ( li_Type, ll_Id, ad_Start, ad_End ) > 0 THEN  //Retn value is # of rows, once filtered
					
					IF aw_Map.wf_PlotTrip ( lnv_Dispatch.of_GetEventCache ( ), ls_EquipRef /*LayerName*/ ) = 1 THEN
						//OK
					ELSE
						ll_SkippedCount ++
					END IF
					
				END IF
				
			CASE ELSE  //-1 (Error), -2 (Original value conflict)
				
				ll_SkippedCount ++
				
		END CHOOSE
		
	NEXT
	
END IF


DESTROY lnv_Dispatch


IF ll_SkippedCount > 0 THEN
	MessageBox ( "Display Route Map", String ( ll_SkippedCount ) + " requested unit(s) were skipped due to data "+&
		"retrieval errors." )
END IF

RETURN li_Return
end function

public function integer of_displayunroutedstops (w_map aw_map);//Display unrouted shipment events on the map passed in.

//Returns : 1 (Success), 0 (Nothing to process), -1 (Error)

n_cst_bso_Dispatch	lnv_Dispatch
DataStore	lds_Itin

String	ls_Where, &
			ls_ErrorMessage

Long		ll_Null
Date		ld_Null

SetNull ( ll_Null )
SetNull ( ld_Null )

Integer	li_Return = 1


IF li_Return = 1 THEN
	
	IF NOT IsValid ( aw_Map ) THEN
		
		ls_ErrorMessage = "The map window must be open to perform this operation."
		li_Return = -1
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	lnv_Dispatch = CREATE n_cst_bso_Dispatch
	
//	ls_Where = " , current_shipments WHERE de_arrdate IS NULL and de_shipment_id > 0 and exists ( SELECT cs_id FROM current_shipments WHERE cs_id = 

	// current_shipments.cs_assigned IS NOT NULL   :  It's null if it's non-routed.
	// ***AND it not a non-routable
	ls_Where = " , current_shipments WHERE disp_events.de_arrdate IS NULL and disp_events.de_conf = 'F' and IsNull ( disp_events.routable, 'T' ) <> 'F' and current_shipments.cs_id = disp_events.de_shipment_id and current_shipments.cs_assigned IS NOT NULL "
	
	SetPointer ( HourGlass! )
	
	IF lnv_Dispatch.of_RetrieveEvents ( ll_Null, ld_Null, ld_Null, ls_Where ) = 1 THEN
	
		//OK
		lds_Itin = lnv_Dispatch.of_GetEventCache ( )
		
		IF IsValid ( lds_Itin ) THEN
			lds_Itin.SetFilter ( "" )
			lds_Itin.Filter ( )
		ELSE
			li_Return = -1
			ls_ErrorMessage = "Error retrieving data.  Could not access event cache.  Request cancelled."
		END IF
		
	ELSE

		li_Return = -1
		ls_ErrorMessage = "Error retrieving data.  Request cancelled."
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	IF aw_Map.wf_PlotStops ( lds_Itin, "Unassigned Stops" ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
		ls_ErrorMessage = "Error displaying stop data on map."
	END IF
	
END IF


DESTROY lnv_Dispatch


IF li_Return = -1 THEN
	MessageBox ( "Map Unassigned Stops", ls_ErrorMessage )
END IF


RETURN li_Return
end function

public function boolean of_isunknownequipment (long ala_eqids[]);
Boolean	lb_Return
Long		ll_Count
Long		i

Datastore	lds_List
lds_List = CREATE DataStore
lds_List.DataObject = "d_equipmentpicklist"
lds_List.SetTransObject ( SQLCA ) 

IF UpperBound ( ala_eqids ) > 0 THEN
	ll_Count = lds_List.Retrieve ( ala_eqids[] )
	Commit;
	
	FOR i = 1 TO ll_Count	
		IF Left ( Upper ( lds_List.getitemstring( i, "eq_ref" ) ), 3 ) = 'UNK' THEN
			lb_Return = TRUE
			EXIT
		END IF		
	NEXT
	
END IF
Destroy ( lds_List )
RETURN lb_Return   
end function

private function integer of_equifact (string as_strcheck);Integer	li_na, li_ff

li_na = Asc(as_strcheck)

li_ff = li_na

CHOOSE CASE li_ff
	CASE 47 TO 57      		//"0 .. 9"
		li_na = li_na - 48   //0...9
	CASE 65 TO 90				//A...Z
		li_na = li_na - 55	//10..35
		
		IF li_na >= 11 THEN
			li_na ++
		END IF
		
		IF li_na >= 22 THEN
			li_na ++
		END IF
		
		IF li_na >= 33 THEN
			li_na ++
		END IF
		
	CASE ELSE
		li_na = 0
		
END CHOOSE

Return li_na
end function

public function integer of_validatecheckdigit (string as_eqref, ref string as_error);Boolean	lb_RequireCheckDigit

n_cst_setting_requirecheckdigit	lnv_RequireCD

lnv_RequireCD = Create	n_cst_setting_requirecheckdigit
lb_RequireCheckDigit = lnv_RequireCD.of_GetValue() = lnv_RequireCD.cs_YES
Destroy lnv_RequireCD

Return This.of_ValidateCheckDigit(as_eqref, as_error, lb_RequireCheckDigit)

end function

public function integer of_validatecheckdigit (string as_eqref, ref string as_error, boolean ab_required);Boolean	lb_ValidateCheckDigit

n_cst_setting_validatecheckdigit  lnv_ValidateCD

lnv_ValidateCD = Create n_cst_setting_validatecheckdigit
lb_ValidateCheckDigit = lnv_ValidateCD.of_GetValue() = lnv_ValidateCD.cs_Yes
Destroy(lnv_ValidateCD)

Return This.of_ValidateCheckDigit(as_eqref, as_error, ab_Required, lb_ValidatecheckDigit)


end function

public function integer of_validatecheckdigit (string as_eqref, ref string as_error, boolean ab_required, boolean ab_validate);Integer	li_Return = 1
Integer	li_CD 			//Calculated check digit
Integer	li_iCheckDigit	//check digit passed in
String	ls_iCheckDigit //check digit passed in
String	ls_EqRef

Boolean	lb_Provided

n_cst_String	lnv_String

//UNK ref numbers are ok
IF POS(as_eqref, "UNK") > 0 AND POS(as_eqref, "-") > 0 THEN
	Return 1  //------------------MID CODE RETURN
END IF

//Remove non-alpha characters
ls_EqRef = lnv_String.of_RemoveNonAlphaNumeric(as_eqref)

//find out if check digit is provided
ls_iCheckDigit = Mid(ls_EqRef, 11, 1)

IF Len(ls_iCheckDigit) > 0  AND isNumber(ls_iCheckDigit) THEN
	lb_Provided = TRUE
END IF


//If check digit is required, validate
IF li_Return = 1 THEN
	IF ab_Required THEN
		IF NOT lb_Provided THEN
			li_Return = -1
			as_Error = "A check digit is required for equipment reference number " + as_Eqref + "."
		END IF
	END IF
END IF

//If validation of check digit is required, validate
IF li_Return = 1 THEN
	
	IF ab_Validate THEN
		
		IF lb_Provided THEN
			li_iCheckDigit = Integer(ls_iCheckDigit)
			li_CD = This.of_CalculateCheckDigit(ls_EqRef)
			IF li_iCheckDigit <> li_CD THEN
				li_Return = -1 
				as_Error = "Invalid equipment reference number " + as_EqRef + ". Check digit does not pass validation."		
			END IF
		END IF
		
	END IF
	
END IF

Return li_Return

end function

private function integer of_splitalphanumeric (string as_source, ref string as_alpha, ref string as_numeric);Integer	li_Return = 1
String	ls_Alpha 
String	ls_Numeric
String	ls_Source
Char		lch_char
Long		ll_pos = 1
Long		i			
Long		ll_len


n_cst_String	lnv_String

//Check parameters
IF IsNull(as_Source) THEN
	li_Return = -1
END IF

ls_Source = lnv_String.of_RemoveNonAlphaNumeric(as_Source)

IF li_Return = 1 THEN
	ll_Len = Len(ls_Source)
	
	//loop to visit each alpha
	FOR i = 1 TO ll_len
		lch_char = Mid(ls_Source, ll_Pos, 1)
		
		IF lnv_String.of_IsAlpha( lch_Char ) THEN
			ls_Alpha += String(lch_Char)
			ll_Pos ++
		ELSE
			EXIT //We hit numeric portion
		END IF
		
	NEXT
	
	//loop to visit each numeric
	FOR i = ll_Pos TO ll_len
		lch_char = Mid(ls_Source, ll_Pos, 1)
		
		IF IsNumber( lch_Char ) THEN
			ls_Numeric += String(lch_Char)
			ll_Pos ++
		ELSE
			EXIT
		END IF
		
	NEXT
	
END IF

as_alpha = ls_Alpha
as_numeric = ls_Numeric

Return li_Return

end function

public function integer of_calculatecheckdigit (string as_eqref);Integer		li_CheckDigit = -1
Integer		li_ChkDig
Integer		i

String		ls_srtCtrl
String		ls_tc
String		ls_Alpha
String		ls_Numeric

Decimal		lc_td
Decimal		lc_ef
Decimal		lc_pc
Decimal		lc_wf
Decimal		lc_tsum
Decimal		lc_cd

lc_tsum = 0.0

IF Trim(as_eqref) <> "" THEN
	
	li_ChkDig = Integer(Mid(as_eqref, 11, 1)) //Get the check digit
	ls_srtCtrl = Upper(Mid(as_eqref, 1, 10)) //Get the 4 letters, then 6 Digits
	
	ls_Alpha = Mid(ls_srtCtrl, 1, 4)
	
	IF ls_Alpha = "HLCU" THEN //Hapag has different formula (HLCU = 84)
		lc_tsum = 84.0
		FOR i = 5 TO 10
			ls_tc = Mid(ls_srtCtrl, i, 1)
			lc_ef = of_EquiFact(ls_tc)
			lc_wf = 2 ^ (i - 1)
			lc_pc = lc_ef * lc_wf
			lc_tsum += lc_pc
		NEXT
	ELSE
		FOR i = 1 TO 10
			ls_tc = Mid(ls_srtCtrl, i, 1)
			lc_ef = of_EquiFact(ls_tc)
			lc_wf = 2 ^ (i - 1)
			lc_pc = lc_ef * lc_wf
			lc_tsum += lc_pc
		NEXT
	END IF	 
	
	lc_cd = Mod(lc_tsum, 11)
	
	IF lc_cd >= 10 THEN
		lc_cd = 0
	END IF
	
	li_CheckDigit = lc_cd

END IF

Return li_CheckDigit
end function

public function long of_existsequipment (string as_eqref, string as_eqtype, string as_eqstatus, ref string asa_dupes[]);//Use sds_Equip as default search cache
Return This.of_ExistsEquipment(as_eqref, sds_Equip, as_eqtype, as_eqstatus, asa_dupes)
end function

public function long of_existsequipment (string as_eqref, datastore ads_cache, ref string asa_dupes[]);String	ls_EqType = ""  //No eq type match by default
String	ls_EqStatus = "K" //Active eq status match by default

//Default is to search by eqref with no type or status restrictions
Return This.of_ExistsEquipment(as_eqref, ads_cache, ls_EqType, ls_EqStatus, asa_dupes)
end function

private function string of_getexistsequipmentfindstring (string as_eqref, string as_eqtype, string as_eqstatus);String	ls_FindString
String	ls_EqRef
String	ls_Alpha
String	ls_Numeric
Boolean	lb_SubstringSearch

n_cst_String	lnv_String

n_cst_setting_existsequipmentsubstring		lnv_SubStringSearch

lnv_SubStringSearch = Create	n_cst_setting_existsequipmentsubstring
lb_SubStringSearch = (lnv_SubStringSearch.of_GetValue() = lnv_SubStringSearch.cs_Yes)
Destroy(lnv_SubStringSearch)

ls_EqRef = as_EqRef

//Start building find string
ls_FindString = "(eq_ref = '" + ls_EqRef + "'"

IF lb_SubStringSearch THEN
	
	//Remove bs characters
	ls_EqRef = lnv_String.of_RemoveNonAlphaNumeric(ls_EqRef)
	
	This.of_SplitAlphaNumeric(ls_EqRef, ls_Alpha, ls_Numeric)
	
	//MFS 5/30/07 - Only perform substring search if we have 3+ alpha and 6+ numeric
	IF Len(ls_Alpha) >= 3 AND Len(ls_Numeric) >= 6 THEN
			
		//If container remove check digit	
		IF Upper(Mid(ls_Alpha, 4, 1)) = "U" THEN
			IF Len(ls_Numeric) = 7 THEN //Assume check digit and remove
				ls_Numeric = Left(ls_Numeric, 6)
			END IF
		END IF
		
		ls_FindString += " OR eq_ref LIKE '%" + ls_Alpha + "%" + ls_Numeric + "%'"

	END IF
	
END IF

ls_FindString += ")"

IF Len(as_eqtype) > 0 THEN
	ls_FindString += " AND eq_type = '" + as_eqtype + "'"
END IF

IF Len(as_eqstatus) > 0 THEN
	ls_FindString += " AND eq_status = '" + as_eqstatus + "'"
END IF

Return ls_FindString
end function

public function long of_existsindatabase (string as_eqref, string as_eqtype, string as_eqstatus, ref string asa_dupes[]);/***************************************************************************************
NAME: of_ExistsInDatabase			
	
ACCESS: Public		
		
ARGUMENTS: 		string 	as_eqref : eq_ref to search for

					string	as_eqtype : type of eq to find 
												
					string	as_eqstatus: status of eq to find 
												 
					string	as_dupes[]: list of eqref duplicates found (by ref)
RETURNS: Long
	
DESCRIPTION:
		Returns eqid if equipemnt already exists
		
		Returns 0 If equipment does not exist
		
		Return -2 if more than one already exists
		
		Similar conatiner ref with no check digit (TESU123456) and with a check digit (TESU1234567)
		are inclusive.

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 4/13/07 MFS

***************************************************************************************/

Long		ll_EqId
Long		ll_DupCount
Long		i
String	ls_Where

String   ls_FindString	

datastore		lds_Duplicates

lds_Duplicates = Create datastore

IF IsNull ( as_eqref ) THEN
	RETURN 0
END IF

ls_FindString = This.of_GetExistsEquipmentFindString(as_eqref, as_eqtype, as_eqstatus)

ls_Where = "WHERE " + ls_FindString
ll_DupCount = This.of_Retrieve (lds_Duplicates , ls_Where)

IF ll_DupCount = 1 THEN
	ll_EqId = lds_Duplicates.GetItemNumber (ll_DupCount , "eq_id")
ELSEIF ll_DupCount > 1 THEN
	ll_EqId = -2 //Error, found more than one
END IF

//Populate dupes list
FOR i = 1 TO ll_DupCount
	asa_Dupes[i] = lds_Duplicates.GetItemString (i , "eq_ref")
NEXT

Destroy(lds_Duplicates)

Return ll_EqId
end function

public function long of_existsincache (datastore ads_cache, string as_eqref, string as_eqtype, string as_eqstatus);Long	al_Dummy

Return This.of_ExistsInCache(ads_cache, as_eqref, as_eqtype, as_eqstatus, al_Dummy)
end function

public function long of_existsincache (datastore ads_cache, string as_eqref, string as_eqtype, string as_eqstatus, ref long al_row);/***************************************************************************************
NAME: of_ExistsInCache			
	
ACCESS: Public		
		
ARGUMENTS: 		datastore ads_cache : cache to search on

					string 	as_eqref : eq_ref to search for

					string	as_eqtype : type of eq to find 
												
					string	as_eqstatus: status of eq to find 
					
					Long		al_row (by ref)
												 
RETURNS: Long
	
DESCRIPTION:
		Returns eqid if equipemnt exists in cache
		
		Returns 0 If equipment does not exist
		
		Similar conatiner ref with no check digit (TESU123456) and with a check digit (TESU1234567)
		are inclusive.

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 4/13/07 MFS

***************************************************************************************/

Long		ll_EqId
Long		ll_FindRow
String	ls_FindString

IF IsNull ( as_eqref ) THEN
	RETURN 0
END IF

ls_FindString = This.of_GetExistsEquipmentFindString(as_eqref, as_eqtype, as_eqstatus)

IF isValid(ads_cache) THEN
	

	ll_FindRow = ads_Cache.Find(ls_FindString , 1 , ads_cache.RowCount ())
	IF ll_FindRow > 0 THEN
		ll_EqId = ads_Cache.GetItemNumber(ll_FindRow , "eq_id")
		al_Row = ll_FindRow
	END IF

				
END IF

Return ll_EqId
end function

public function integer of_updateunknownequipment (long al_equipmentid, string as_newref, n_cst_beo_shipment anv_shipment);Int	li_Return = 1
Long	ll_Shipment
Long		ll_DupCount
Long		i
String	ls_Dupes
String	ls_EquipmentType
String	ls_OldRef
String	ls_RefText
Long		ll_EqID
String	ls_NewRef
String	lsa_Dupes[]
String	ls_ErrorMsg

ls_ErrorMsg = "Error updating UNK with " + as_newref + "."

ls_NewRef = TRIM ( as_newref )

IF li_Return = 1 THEN
	// check for existing equipment
   // we don't want to create duplicate
	
	/*MFS - 4/16/07 - Old dupe check commented out
	SELECT "equipment"."eq_id"  
   INTO :ll_EQID  
   FROM "equipment"  
   WHERE ( "equipment"."eq_status" = 'K' ) AND  
         ( TRIM ( "equipment"."eq_ref" )  = :ls_NewRef )   ;
	
	COMMIT;
	*/
	
	/*MFS - 4/16/07 - NEW dupe check*/
	ll_EqId = This.of_ExistsEquipment( ls_NewRef, lsa_Dupes)
	
	CHOOSE CASE ll_EqId 
	CASE IS > 0 //exists
		li_Return = 0
		ls_ErrorMsg = "Could not update UNK with " + as_newref + " because it already exists."
	CASE -2 //multiples exist
		li_Return = 0
		ll_DupCount = UpperBound(lsa_Dupes)
		FOR i = 1 TO ll_DupCount
			ls_Dupes += lsa_dupes[i] + "~r~n"
		NEXT
		ls_ErrorMsg = "Could not update UNK with " + as_newref + " because it already exists."
		IF Len(ls_Dupes) > 0 THEN
			ls_ErrorMsg += "~r~nThe following containers must be decativated or removed to preform this operation:~r~n" + ls_Dupes
		END IF
	END CHOOSE

	
END IF

IF li_Return = 1 THEN

	SELECT "equipment"."eq_type",   
         "outside_equip"."shipment",
			"equipment"."eq_ref"
    INTO :ls_EquipmentType,   
         :ll_Shipment,
			:ls_OldRef
    FROM "equipment",   
         "outside_equip"  
   WHERE ( "outside_equip"."oe_id" = "equipment"."eq_id" ) and  
         ( ( "equipment"."eq_id" = :al_equipmentid ) )   ;

	Commit;

END IF

IF li_Return = 1 THEN
// we will need to update the equipment with the new ref number.
	UPDATE "equipment"  
	SET "eq_ref" = :ls_NewRef
	WHERE ( "equipment"."eq_id" = :al_equipmentid );
					
	IF SQLCA.Sqlcode = 0 THEN
		Commit;
	ELSE
		RollBack;
		li_Return = -1
	END IF
END IF


IF li_Return = 1 AND isValid ( anv_Shipment )THEN
	// then we will need to see if the equipment is linked to a shipment.
	// since the equipment we are dealing with is 'unknown' we don't need to worry about reloaded eq	
	IF ll_Shipment = anv_Shipment.of_GetID ( )  THEN
		// if it is then we will need to loop through the reference numbers to 
		// see if we need to populate any of them with the new fields.
		 
		 
		// we need to pull the equipment type off of the equipment. 
		// then we will be able to perform the same type of processing
		// as in in the shipment window.
	
	
		String   ls_EquipmentRef
		
		Int      li_RefType
		Int      li_SetType 
		
		IF IsValid ( anv_Shipment ) AND Len ( as_newref ) > 0 THEN
			
			CHOOSE CASE ls_EquipmentType 
				CASE 'C'
					li_SetType = 20 
				CASE 'B'
					li_SetType = 26
				CASE 'H'
					li_SetType = 28   
				CASE 'V'
					li_SetType = 23
			END CHOOSE
			
			ls_RefText = anv_Shipment.of_GetRef1text ( ) 
			IF isNull ( ls_RefText ) OR  Len ( ls_RefText ) = 0 OR ls_OldRef = ls_RefText THEN 			

				IF li_SetType > 0 THEN
					anv_Shipment.of_SetRef1Type( li_SetType )
					anv_Shipment.of_SetRef1Text ( as_newref )
					// I am using the Settype flag as a way to determine if we should
					// continue to try to set the ref2 fields.
					// since we already set it on the 1st ref no need to try ref2
					li_SetType = 0
					
				END IF   
						
			END IF         
			
					
			ls_RefText = anv_Shipment.of_GetRef2text ( ) 
			IF isNull ( ls_RefText ) OR  Len ( ls_RefText ) = 0 OR ls_OldRef = ls_RefText THEN 			

				IF li_SetType > 0 THEN
					anv_Shipment.of_SetRef2Type( li_SetType )
					anv_Shipment.of_SetRef2Text ( as_newref )
				END IF   
						
			END IF         
			
				
		END IF         
		

	END IF
	
END IF

THIS.of_Cache( al_equipmentid , TRUE )

IF li_Return <> 1 THEN
	This.of_AddError(ls_ErrorMsg)
END IF


RETURN li_Return

end function

public function integer of_adderror (string as_error);n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

lnv_Error.SetErrorMessage( as_Error )
lnv_Error.SetMessageHeader ("Equipment")

Return 1
end function

public function integer of_geterrors (ref string asa_errors[]);integer 		li_ErrorCount
integer		i
String		ls_ErrorString
String		lsa_Errors[]

n_cst_OFRError 				lnva_Error[]
n_cst_OFRError_Collection 	lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_ErrorCollection.geterrorcount( )

FOR i = 1 TO li_ErrorCount
	ls_ErrorString = string( lnva_Error[i].getErrorMessage() )
	lsa_Errors[i] = ls_ErrorString
NEXT

asa_Errors = lsa_Errors

Return li_ErrorCount
end function

public function long of_existsequipment (string as_eqref, ref string asa_dupes[]);Return This.of_ExistsEquipment(as_eqref, sds_Equip, asa_dupes)
end function

public function long of_existsequipment (string as_eqref, datastore ads_cache, string as_eqtype, string as_eqstatus, ref string asa_dupes[]);/***************************************************************************************
NAME: of_ExistsEquipment			
	
ACCESS: Public		
		
ARGUMENTS: 		string as_eqref : eq_ref to search for

					datastore ads_cache : cache to search on 
												 default: sds_equip
					string	as_eqtype : type of eq to find 
												default: search all types
					string	as_eqstatus: status of eq to find 
												 default: searh any status
					string	as_dupes[]: list of eqref duplicates found (by ref)
RETURNS: Long
	
DESCRIPTION:
		Returns eqid if equipemnt already exists
		
		Returns 0 If equipment does not exist
		
		Return -2 if more than one already exists
		
		Returns -1 If Error
		
		Similar conatiner ref with no check digit (TESU123456) and with a check digit (TESU1234567)
		are inclusive.

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created 2/9/07 MFS

***************************************************************************************/
Long		ll_EqId
Long		ll_CacheEqId
Long		ll_FindRow
String	ls_FindString
String	ls_Status
String	ls_FindCache


IF IsNull ( as_eqref ) THEN
	RETURN 0
END IF

//Check DB
ll_EqId = This.of_ExistsInDatabase(as_eqref, as_eqtype, as_eqstatus, asa_Dupes[])


//Check the cache
IF ll_EqId <> -2 THEN
	
	//IF we found it in the db, make sure we have not deactivated it in the cache
	IF ll_EqId > 0 THEN 
		//Look for it in cache with no status restriction
		ll_CacheEqId = This.of_ExistsInCache(ads_cache, as_eqref, as_eqtype, "", ll_FindRow)
		IF ll_FindRow > 0 THEN
			IF ll_EqId = ll_CacheEqId THEN
				ls_Status = ads_Cache.GetItemString(ll_FindRow , "eq_status")
				IF as_EqStatus = "K" AND ls_Status <> "K" THEN
					ll_EqId = 0//This will trump db find, since it has been deactivated
				END IF
			END IF
		END IF
		
	END IF
	
	//Check the cache, if found return that id
	ll_CacheEqId = This.of_ExistsInCache(ads_cache, as_eqref, as_eqtype, as_eqstatus)
	
	IF ll_CacheEqId > 0 THEN
		ll_EqId = ll_CacheEqId
	END IF
	
END IF


Return ll_EqID
end function

public function string of_get_ds_equipment_dataobject ();Return sds_Equip.DataObject
end function

on n_cst_equipmentmanager.create
call super::create
end on

on n_cst_equipmentmanager.destroy
call super::destroy
end on

event constructor;if not IsValid( sds_equip ) then
	sds_equip = create n_ds
	sds_equip.DataObject = "d_equip_list"
	sds_equip.SetTransObject( sqlca )
	sb_equip_retrieved = FALSE
	sdt_equip_refreshed = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sdt_equip_updated = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sl_counter = 1
	setnull(sstr_null_info.eq_id)
	setnull(sstr_null_info.eq_type)
	setnull(sstr_null_info.eq_ref)
	setnull(sstr_null_info.eq_outside)
	setnull(sstr_null_info.eq_status)
	setnull(sstr_null_info.eq_length)
	setnull(sstr_null_info.eq_height)
	setnull(sstr_null_info.eq_volume)
	setnull(sstr_null_info.eq_axles)
	setnull(sstr_null_info.eq_air)
	setnull(sstr_null_info.eq_spec1)
	setnull(sstr_null_info.eq_spec2)
	setnull(sstr_null_info.eq_spec3)
	setnull(sstr_null_info.eq_spec4)
	setnull(sstr_null_info.eq_spec5)
	setnull(sstr_null_info.eq_cur_event)
	setnull(sstr_null_info.eq_next_event)
	setnull(sstr_null_info.oe_from)
	setnull(sstr_null_info.oe_for)
	setnull(sstr_null_info.oe_booknum)
	setnull(sstr_null_info.oe_out)
	setnull(sstr_null_info.oe_in)
	setnull(sstr_null_info.oe_orig_event)
	setnull(sstr_null_info.oe_term_event)
	setnull(sstr_null_info.from_name)
	setnull(sstr_null_info.for_name)	
	setnull(sstr_null_info.fkequipmentleasetype)	
else
	sl_counter ++
end if

end event

event destructor;sl_counter --

//The following would destroy the cache when the last equipment manager
//instance is destroyed.  This is not what we want currently, however.

//if sl_counter = 0 then Destroy sds_equip
end event

