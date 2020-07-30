$PBExportHeader$n_cst_companies.sru
forward
global type n_cst_companies from nonvisualobject
end type
end forward

global type n_cst_companies from nonvisualobject
end type
global n_cst_companies n_cst_companies

type variables
protected:
datastore ids_cache
s_co_info istr_null_info

Public:
CONSTANT String  cs_CompanyRole_BillTo = "BillTo"
CONSTANT String   cs_CompanyRole_Agent = "Agent"
CONSTANT String   cs_CompanyRole_Forwarder = "Forwarder"
CONSTANT String   cs_CompanyRole_EventSite = "EventSite"
CONSTANT String   cs_CompanyRole_None = "None"
end variables

forward prototypes
public function integer of_cache (ref long ala_ids[], boolean ab_force_refresh)
public function integer of_cache (long al_id, boolean ab_force_refresh)
public function long of_find (long al_target_id)
public function integer of_get_info (long al_target_id, ref s_co_info astr_target, boolean ab_force_refresh)
public function long of_find (string as_code_name)
public function integer of_get_address (long al_target, string as_type, boolean ab_include_name, ref string as_address)
public function integer of_sync (powerobject apo_source)
protected function integer of_validate_carrier (long al_target, ref string as_warning)
public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_target_row)
public function string of_make_location (string as_city, string as_state, string as_zip, string as_usnon, string as_country, string as_type)
public function integer of_get_address (long al_target, string as_option_list, ref string as_address)
public function string of_make_location (string as_city, string as_state)
public function integer of_getcodename (long al_target, ref string as_value)
public function integer of_exportlist ()
public function string of_formatzip (string as_value)
public function string of_formatphone (string as_value, boolean ab_useformat)
public function boolean of_usephoneformat (string as_usnon)
public function string of_formatmc (string as_value)
public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_targetrow, readonly string asa_source_alias[], readonly string asa_target_alias[])
public function datastore of_getcache ()
public function integer of_qbexport (readonly long ala_ids[])
public function integer of_makeentity (long al_companyid, ref long al_entityid)
public function integer of_getentity (long al_companyid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery)
public function integer of_getentity (long al_companyid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup)
public function integer of_cacheall ()
public function long of_doesaccountingidexist (readonly string as_accountingid)
public function integer of_validateaccountingids (boolean ab_openWindow)
public function long of_createnewcompany (string as_companyname, string as_codename, string as_locator)
public function integer of_settemplateondocument (ref n_cst_document anv_document, long al_companyid)
public function n_cst_beo_company of_select (string as_searchvalue)
public function n_cst_beo_company of_select (string as_searchvalue, boolean ab_allowhold, boolean ab_notify)
public function long of_getfacilities (long al_coid, ref n_cst_beo_company anva_company[])
public function long of_find (string as_fullname, string as_zip)
public function long of_getcompanybyalias (long al_context, string as_contextcompanyid)
public function integer of_defaultaliaslisttocoref (long al_context)
public function integer of_deletealiaslistforcontext (long al_context)
public function n_cst_beo_company of_select (string as_searchvalue, boolean ab_allowhold, boolean ab_notify, string as_type)
public function string of_getdocumenttransfermethod (long al_company, n_cst_document anv_document)
public function integer of_getdocumentsettings (long al_coid, n_cst_document anv_document, ref n_cst_documentsettings anv_settings)
public function integer of_select (ref s_co_info astr_company, string as_type, boolean ab_search, string as_search, boolean ab_validate, long al_validate, boolean ab_allow_hold, boolean ab_notify, boolean ab_allow_new)
public function integer of_select (ref s_co_info astr_company, string as_type, boolean ab_search, string as_search, boolean ab_validate, long al_validate, boolean ab_allow_hold, boolean ab_notify)
public function integer of_select (ref s_co_info astr_company, string as_type, boolean ab_search, string as_search, boolean ab_validate, long al_validate, boolean ab_allow_hold, boolean ab_notify, boolean ab_allow_new, boolean ab_suppress_newwindow)
end prototypes

public function integer of_cache (ref long ala_ids[], boolean ab_force_refresh);//Returns :  1 = Success (even if one or more requested companies don't exist)
//				-1 = Error

//NOTE: the array of ids passed in (ala_ids) is submitted to gf_shrink_array.  It may
//be modified in the process.  If the calling script needs the array untouched, it should
//make a copy and submit that instead.

integer li_expected, li_retrieved, li_checkloop, li_retnval
long lla_retr_ids[], ll_foundrow, ll_cache_rows
datastore lds_retr
n_cst_numerical lnv_numerical

n_cst_anyarraysrv lnv_anyarray
lnv_anyarray.of_GetShrinked(ala_ids, "NULLS~tDUPES")

ll_cache_rows = ids_cache.rowcount()

if ab_force_refresh = false and ll_cache_rows > 0 then
	//If force refresh is false and there are rows in the cache, we'll exclude ids
	//already in the cache from the retrieval list.
	for li_checkloop = 1 to upperbound(ala_ids)
		if ids_cache.find("co_id = " + string(ala_ids[li_checkloop]), 1, ll_cache_rows) > 0 &
			then continue
		li_expected ++
		lla_retr_ids[li_expected] = ala_ids[li_checkloop]
	next
else
	li_expected = upperbound(ala_ids)
	lla_retr_ids = ala_ids
end if

if lnv_numerical.of_IsNullOrNotPos(li_expected) then return 1

lds_retr = create datastore
lds_retr.dataobject = "d_company_cache"
lds_retr.settransobject(sqlca)

li_retrieved = lds_retr.retrieve(lla_retr_ids)

if li_retrieved = -1 then
	rollback ;
	li_retnval = -1
else
	commit ;
	if li_retrieved > 0 then
		if ab_force_refresh = false then
			//None of the rows retrieved should be in the cache, based on the weeding out 
			//process above, so we can do a straight copy
			lds_retr.rowscopy(1, li_retrieved, primary!, ids_cache, ll_cache_rows + 1, primary!)
		else
			//Some of the rows retrieved may already be in the cache, so we must avoid dupes
			gf_rows_sync(lds_retr, null_dw, ids_cache, null_dw, primary!, true, true)
		end if
	end if

//	if li_retrieved = li_expected then li_retnval = 1 else li_retnval = -1

	li_retnval = 1
end if

if ab_force_refresh and li_retrieved < li_expected then
	//If not all of the expected companies were retrieved (or, more likely, the retrieve
	//simply failed) and force_refresh is true, we should get rid of the cached info, if any, 
	//for the companies that were not retrieved.
	for li_checkloop = 1 to upperbound(lla_retr_ids)
		if lds_retr.find("co_id = " + string(lla_retr_ids), 1, li_retrieved) > 0 then continue
			//(This syntax is fine even if li_retrieved = -1 from a retrieve failure, above)
		ll_foundrow = ids_cache.find("co_id = " + string(lla_retr_ids), 1, ids_cache.rowcount())
		if ll_foundrow > 0 then ids_cache.rowsdiscard(ll_foundrow, ll_foundrow, primary!)
	next
end if

destroy lds_retr
return li_retnval
end function

public function integer of_cache (long al_id, boolean ab_force_refresh);long lla_ids[]

lla_ids[1] = al_id

return of_cache(lla_ids, ab_force_refresh)
end function

public function long of_find (long al_target_id);//Return Values:  >0 = success (a positive row in the cache), 0 = Not Found (No error), 
//						-1 = Error.  
// The function returns 0 for a null al_target_id (Not Found).
// The function will not return null.

long ll_foundrow
n_cst_numerical lnv_numerical

if lnv_numerical.of_IsNullOrNotPos(al_target_id) then return 0

ll_foundrow = ids_cache.find("co_id = " + string(al_target_id), 1, ids_cache.rowcount())
if ll_foundrow > 0 then return ll_foundrow

if of_cache(al_target_id, true) = -1 then return -1

ll_foundrow = ids_cache.find("co_id = " + string(al_target_id), 1, ids_cache.rowcount())
if isnull(ll_foundrow) then return -1
return ll_foundrow
end function

public function integer of_get_info (long al_target_id, ref s_co_info astr_target, boolean ab_force_refresh);//Return Values: 1 = Success, 0 = ID not found (no error), -1 = Error
//		An al_target_id of null will return 1, with astr_target containing null info.
//		astr_target will be set to either the valid info or null info for all return codes.

long ll_foundrow
astr_target = istr_null_info

if isnull(al_target_id) then return 1

if ab_force_refresh then
	if of_cache(al_target_id, ab_force_refresh) = -1 then return -1
end if

ll_foundrow = of_find(al_target_id)

if ll_foundrow > 0 then
	astr_target.co_id = ids_cache.object.co_id[ll_foundrow]
	astr_target.co_name = ids_cache.object.co_name[ll_foundrow]
	astr_target.co_addr1 = ids_cache.object.co_addr1[ll_foundrow]
	astr_target.co_addr2 = ids_cache.object.co_addr2[ll_foundrow]
	astr_target.co_city = ids_cache.object.co_city[ll_foundrow]
	astr_target.co_state = ids_cache.object.co_state[ll_foundrow]
	astr_target.co_zip = ids_cache.object.co_zip[ll_foundrow]
	astr_target.co_usnon = ids_cache.object.co_usnon[ll_foundrow]
	astr_target.co_country = ids_cache.object.co_country[ll_foundrow]
	astr_target.co_bill_same = ids_cache.object.co_bill_same[ll_foundrow]
	astr_target.co_bill_name = ids_cache.object.co_bill_name[ll_foundrow]
	astr_target.co_bill_addr1 = ids_cache.object.co_bill_addr1[ll_foundrow]
	astr_target.co_bill_addr2 = ids_cache.object.co_bill_addr2[ll_foundrow]
	astr_target.co_bill_city = ids_cache.object.co_bill_city[ll_foundrow]
	astr_target.co_bill_state = ids_cache.object.co_bill_zip[ll_foundrow]
	astr_target.co_bill_usnon = ids_cache.object.co_bill_usnon[ll_foundrow]
	astr_target.co_bill_country = ids_cache.object.co_bill_country[ll_foundrow]
	astr_target.co_bill_acctcode = ids_cache.object.co_bill_acctcode[ll_foundrow]
	astr_target.co_status = ids_cache.object.co_status[ll_foundrow]
	astr_target.co_facility_of = ids_cache.object.co_facility_of[ll_foundrow]
	astr_target.co_tz = ids_cache.object.co_tz[ll_foundrow]
	astr_target.co_pcm = ids_cache.object.co_pcm[ll_foundrow]
	astr_target.co_allow_billing = ids_cache.object.co_allow_billing[ll_foundrow]
	return 1
else
	return ll_foundrow
end if
end function

public function long of_find (string as_code_name);long ll_foundrow, ll_target_id
n_cst_numerical lnv_numerical

as_code_name = trim(as_code_name)
if left(as_code_name, 1) = "/" then as_code_name = trim(right(as_code_name, len(as_code_name) - 1))

if lnv_numerical.of_IsNullOrNotPos(len(as_code_name)) then return 0

ll_foundrow = ids_cache.find("co_code_name = '" + as_code_name + "'", 1, ids_cache.rowcount())
if ll_foundrow > 0 then return ll_foundrow

select co_id into :ll_target_id from companies where co_code_name = :as_code_name ;

choose case sqlca.sqlcode
case 0
	commit ;
case 100
	commit ;
	return 0
case else
	rollback ;
	return -1
end choose

if of_cache(ll_target_id, true) = -1 then return -1

ll_foundrow = ids_cache.find("co_code_name = '" + as_code_name + "'", 1, ids_cache.rowcount())
return ll_foundrow
end function

public function integer of_get_address (long al_target, string as_type, boolean ab_include_name, ref string as_address);//Return Values: 1 = Success, 0 = ID not found (no error), -1 = Error
//		An al_target ID of null will return 1, with as_address = null
//		as_address will be set to either the valid address or null for all return codes

long ll_foundrow
string ls_work, ls_address, ls_modifier, ls_name, ls_attn, ls_addr1, ls_addr2, ls_city, ls_state, ls_zip, &
	ls_usnon, ls_country, ls_bill_attn, ls_bill_attn_text

as_address = null_str

if isnull(al_target) then return 1

ll_foundrow = of_find(al_target)

if ll_foundrow > 0 then
	choose case as_type
	case "BILLING!", "BILLING_OR_WARNING!"
		if as_type = "BILLING_OR_WARNING!" then
			if ids_cache.object.co_allow_billing[ll_foundrow] = "F" then
				as_address = "**NEEDS BILLING AUTHORIZATION**"
				return 1
			end if
		end if

		if ids_cache.object.co_bill_same[ll_foundrow] = "F" then ls_modifier = "co_bill_" &
			else ls_modifier = "co_"
		ls_bill_attn = ids_cache.getitemstring(ll_foundrow, "co_bill_attn")
		ls_bill_attn_text = trim(ids_cache.getitemstring(ll_foundrow, "co_bill_attn_text"))

		ls_work = ""

		choose case ls_bill_attn
		case "N" //No attention line
			//No processing needed
		case "O" //Text only
			if len(ls_bill_attn_text) > 0 then ls_work += "ATTN: " + ls_bill_attn_text
		case "F" //'Accounts Payable' First
			ls_work += "ATTN: ACCOUNTS PAYABLE"
			if len(ls_bill_attn_text) > 0 then ls_work += " – " + ls_bill_attn_text
		case "L" //'Accounts Payable' Last
			ls_work += "ATTN: "
			if len(ls_bill_attn_text) > 0 then ls_work += ls_bill_attn_text + " – "
			ls_work += "ACCOUNTS PAYABLE"
		end choose

		ls_attn = ls_work

	case "PHYSICAL!"
		ls_modifier = "co_"

	end choose

	ls_name = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "name"))
	ls_addr1 = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "addr1"))
	ls_addr2 = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "addr2"))
	ls_city = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "city"))
	ls_state = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "state"))
	ls_zip = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "zip"))
	ls_usnon = ids_cache.getitemstring(ll_foundrow, ls_modifier + "usnon")
	ls_country = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "country"))

	if len(ls_name) > 0 and ab_include_name then ls_address += ls_name + "~r~n"
	if len(ls_attn) > 0 then ls_address += ls_attn + "~r~n"
	if len(ls_addr1) > 0 then ls_address += ls_addr1 + "~r~n"
	if len(ls_addr2) > 0 then ls_address += ls_addr2 + "~r~n"
	if len(ls_city) > 0 then
		ls_work = ""
		ls_work += ls_city
		if ls_usnon = "U" then
			if len(ls_state) = 2 then
				if not ls_state = "MX" then ls_work += ", " + ls_state
				if len(ls_zip) > 0 then
					ls_work += "  "
					if pos("AB BC MB NB NF NT NS ON PE PQ QC SK YK MX", ls_state) > 0 then
						ls_work += ls_zip
					elseif len(ls_zip) > 5 then
						ls_work += string(ls_zip, "@@@@@-@@@@")
					else
						ls_work += ls_zip
					end if
				end if
				if ls_state = "MX" then
					ls_work += "  MEXICO"
				elseif pos("AB BC MB NB NF NT NS ON PE PQ QC SK YK", ls_state) > 0 then
					ls_work += "  CANADA"
				end if
			end if
		else
			if len(ls_zip) > 0 then ls_work += "  " + ls_zip
			if len(ls_country) > 0 then ls_work += "  " + ls_country
		end if
		ls_address += ls_work + "~r~n"
	end if
	as_address = ls_address
	return 1
else
	return ll_foundrow
end if
end function

public function integer of_sync (powerobject apo_source);datawindow ldw_source
datastore lds_source

if isvalid(apo_source) then
	choose case apo_source.typeof()
	case datawindow!
		ldw_source = apo_source
	case datastore!
		lds_source = apo_source
	case else
		return -1
	end choose
else
	return -1
end if

return gf_rows_sync(lds_source, ldw_source, ids_cache, null_dw, primary!, true, true)
end function

protected function integer of_validate_carrier (long al_target, ref string as_warning);datastore lds_carrier_info
date ld_liability_exp, ld_cargo_exp
integer li_return, lia_problems[7]

as_warning = ""

lds_carrier_info = create datastore
lds_carrier_info.dataobject = "d_carrier_cert"
lds_carrier_info.settransobject(sqlca)

choose case lds_carrier_info.retrieve(al_target)
case 1  //al_target is a carrier
	commit ;
	li_return = 1

	//The checks here were originally done in the trip screen.  I've had to suspend the
	//hazmat checking feature until we have some way of allowing the trip screen to indicate
	//whether it needs that item checked.

	ld_liability_exp = lds_carrier_info.object.bc_liability_exp[1]
	ld_cargo_exp = lds_carrier_info.object.bc_cargo_exp[1]

//	if hazcheck > 0 and not lds_carrier_info.object.bc_hazmat[1] = "T" then lia_problems[1] ++

	if isnull(ld_liability_exp) then
		lia_problems[2] ++
	elseif daysafter(today(), ld_liability_exp) < 1 then
		lia_problems[3] ++
	elseif daysafter(today(), ld_liability_exp) < 14 then
		lia_problems[4] ++
	end if

	if isnull(ld_cargo_exp) then
		lia_problems[5] ++
	elseif daysafter(today(), ld_cargo_exp) < 1 then
		lia_problems[6] ++
	elseif daysafter(today(), ld_cargo_exp) < 14 then
		lia_problems[7] ++
	end if

//	if lia_problems[1] > 0 then as_warning += "There are hazmat items in this trip, and "+&
//		"the carrier you have selected does not have hazmat authority on file.~n~n"
	if lia_problems[2] > 0 then as_warning += "The selected carrier's liability insurance "+&
		"expiration date is not on file.~n~n"
	if lia_problems[3] > 0 then as_warning += "The liability insurance on file for the "+&
		"selected carrier has expired.~n~n"
	if lia_problems[4] > 0 then as_warning += "The liability insurance on file for the "+&
		"selected carrier expires within two weeks.~n~n"
	if lia_problems[5] > 0 then as_warning += "The selected carrier's cargo insurance "+&
		"expiration date is not on file.~n~n"
	if lia_problems[6] > 0 then as_warning += "The cargo insurance on file for the "+&
		"selected carrier has expired.~n~n"
	if lia_problems[7] > 0 then as_warning += "The cargo insurance on file for the "+&
		"selected carrier expires within two weeks.~n~n"

case 0  //al_target is not a carrier
	commit ;
	li_return = 0
case else  //error
	rollback ;
	li_return = -1
end choose

destroy lds_carrier_info

return li_return
end function

public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_target_row);string lsa_source_alias[], lsa_target_alias[]

return this.of_copy_by_column(al_id, apo_target, al_target_row, &
	lsa_source_alias, lsa_target_alias)
end function

public function string of_make_location (string as_city, string as_state, string as_zip, string as_usnon, string as_country, string as_type);//Arguments: expecting "SIMPLE!" or "FULL!" for as_type

string ls_location
setnull(ls_location)

//Added Trims 2.2.01
as_City = Trim ( as_City )
as_State = Trim ( as_State )
as_Zip = Trim ( as_Zip )
as_Country = Trim ( as_Country )

if len(as_city) > 0 then
	ls_location = ""
	ls_location += as_city
	if as_usnon = "U" then
		if len(as_state) = 2 then
			if as_type = "SIMPLE!" or not as_state = "MX" then ls_location += ", " + as_state
			if as_type = "FULL!" then
				if len(as_zip) > 0 then
					ls_location += "  "
					if pos("AB BC MB NB NF NT NS ON PE PQ QC SK YK MX", as_state) > 0 then
						ls_location += as_zip
					elseif len(as_zip) > 5 then
						ls_location += string(as_zip, "@@@@@-@@@@")
					else
						ls_location += as_zip
					end if
				end if
				if as_state = "MX" then
					ls_location += "  MEXICO"
				elseif pos("AB BC MB NB NF NT NS ON PE PQ QC SK YK", as_state) > 0 then
					ls_location += "  CANADA"
				end if
			end if
		end if
	else
		if len(as_zip) > 0 and as_type = "FULL!" then ls_location += "  " + as_zip
		if len(as_country) > 0 then ls_location += "  " + as_country
	end if
end if

return ls_location
end function

public function integer of_get_address (long al_target, string as_option_list, ref string as_address);//Return Values: 1 = Success, 0 = ID not found (no error), -1 = Error
//		An al_target ID of null will return 1, with as_address = null or a description
//			value, depending on whether DESCRIBE_NULL! was passed.
//		as_address will be set to either the valid address or null for all return codes

integer li_ndx
long ll_foundrow
string ls_work, ls_address, ls_modifier, ls_name, ls_attn, ls_addr1, ls_addr2, ls_city, ls_state, ls_zip, &
	ls_usnon, ls_country, ls_bill_attn, ls_bill_attn_text, lsa_options[]

string ls_type = "PHYSICAL!"
boolean lb_include_name = true
boolean lb_include_streets = true
boolean lb_include_zip = true
boolean lb_describe_null = false

n_cst_string lnv_string
lnv_string.of_ParseToArray(as_option_list, "~t", lsa_options)

for li_ndx = 1 to upperbound(lsa_options)
	choose case lsa_options[li_ndx]
	case "PHYSICAL!", "BILLING!", "BILLING_OR_WARNING!"
		ls_type = lsa_options[li_ndx]
	case "NO_NAME!"
		lb_include_name = false
	case "NO_STREETS!"
		lb_include_streets = false
	case "NO_ZIP!"
		lb_include_zip = false
	case "DESCRIBE_NULL!"
		lb_describe_null = true
	end choose
next

as_address = null_str

if isnull(al_target) or al_target = 0 then

	//!!!!! 0 Provision added to deal with object.xx_column.primary giving 0, not null

	if lb_describe_null then as_address = "[NOT SPECIFIED]"
	return 1
end if

ll_foundrow = of_find(al_target)

if ll_foundrow > 0 then
	choose case ls_type
	case "BILLING!", "BILLING_OR_WARNING!"
		if ls_type = "BILLING_OR_WARNING!" then
			if ids_cache.object.co_allow_billing[ll_foundrow] = "F" then
				as_address = "**NEEDS BILLING AUTHORIZATION**"
				return 1
			end if
		end if

		if ids_cache.object.co_bill_same[ll_foundrow] = "F" then ls_modifier = "co_bill_" &
			else ls_modifier = "co_"
		ls_bill_attn = ids_cache.getitemstring(ll_foundrow, "co_bill_attn")
		ls_bill_attn_text = trim(ids_cache.getitemstring(ll_foundrow, "co_bill_attn_text"))

		ls_work = ""

		choose case ls_bill_attn
		case "N" //No attention line
			//No processing needed
		case "O" //Text only
			if len(ls_bill_attn_text) > 0 then ls_work += "ATTN: " + ls_bill_attn_text
		case "F" //'Accounts Payable' First
			ls_work += "ATTN: ACCOUNTS PAYABLE"
			if len(ls_bill_attn_text) > 0 then ls_work += " – " + ls_bill_attn_text
		case "L" //'Accounts Payable' Last
			ls_work += "ATTN: "
			if len(ls_bill_attn_text) > 0 then ls_work += ls_bill_attn_text + " – "
			ls_work += "ACCOUNTS PAYABLE"
		end choose

		ls_attn = ls_work

	case "PHYSICAL!"
		ls_modifier = "co_"

	end choose

	ls_name = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "name"))
	ls_addr1 = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "addr1"))
	ls_addr2 = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "addr2"))
	ls_city = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "city"))
	ls_state = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "state"))
	ls_zip = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "zip"))
	ls_usnon = ids_cache.getitemstring(ll_foundrow, ls_modifier + "usnon")
	ls_country = trim(ids_cache.getitemstring(ll_foundrow, ls_modifier + "country"))

	if len(ls_name) > 0 and lb_include_name then ls_address += ls_name + "~r~n"
	if len(ls_attn) > 0 then ls_address += ls_attn + "~r~n"
	if len(ls_addr1) > 0 and lb_include_streets then ls_address += ls_addr1 + "~r~n"
	if len(ls_addr2) > 0 and lb_include_streets then ls_address += ls_addr2 + "~r~n"
	if len(ls_city) > 0 then
		ls_work = ""
		ls_work += ls_city
		if ls_usnon = "U" then
			if len(ls_state) = 2 then
				if not ls_state = "MX" then ls_work += ", " + ls_state
				if len(ls_zip) > 0 and lb_include_zip then
					ls_work += "  "
					if pos("AB BC MB NB NF NT NS ON PE PQ QC SK YK MX", ls_state) > 0 then
						ls_work += ls_zip
					elseif len(ls_zip) > 5 then
						ls_work += string(ls_zip, "@@@@@-@@@@")
					else
						ls_work += ls_zip
					end if
				end if
				if ls_state = "MX" then
					ls_work += "  MEXICO"
				elseif pos("AB BC MB NB NF NT NS ON PE PQ QC SK YK", ls_state) > 0 then
					ls_work += "  CANADA"
				end if
			end if
		else
			if len(ls_zip) > 0 and lb_include_zip then ls_work += "  " + ls_zip
			if len(ls_country) > 0 then ls_work += "  " + ls_country
		end if
		ls_address += ls_work + "~r~n"
	end if
	as_address = ls_address
	return 1
else
	return ll_foundrow
end if
end function

public function string of_make_location (string as_city, string as_state);String	ls_Zip, &
			ls_UsNon, &
			ls_Country

SetNull ( ls_Zip )
SetNull ( ls_Country )
ls_UsNon = "U"

RETURN of_Make_Location ( as_City, as_State, ls_Zip, ls_UsNon, ls_Country, "SIMPLE!" )
end function

public function integer of_getcodename (long al_target, ref string as_value);Long	ll_FoundRow

SetNull ( as_Value )

ll_FoundRow = of_Find ( al_Target )

CHOOSE CASE ll_FoundRow
CASE IS > 0
	as_Value = ids_Cache.Object.co_code_name [ ll_FoundRow ]
	RETURN 1
CASE 0
	RETURN 0
CASE ELSE
	RETURN -1
END CHOOSE

end function

public function integer of_exportlist ();DataStore	lds_Source, &
				lds_Target
String		ls_Select, &
				ls_MessageHeader, &
				ls_SourceColumn, &
				ls_TargetColumn, &
				lsa_SourceColumns[], &
				lsa_TargetColumns[], &
				ls_Title, &
				ls_PathName, &
				ls_FileName, &
				ls_Extension, &
				ls_Filter, &
				ls_CancelWarning
Integer		li_Return, &
				li_TargetColumnCount, &
				li_SourceColumnId, &
				li_TargetColumnId
Long			ll_RowCount, &
				ll_Row
n_cst_Dws	lnv_Dws
n_cst_File	lnv_File

SetPointer ( HourGlass! )

ls_MessageHeader = "Export Company List"

IF gnv_App.of_GetUserId ( ) <> "PTADMIN" THEN
	MessageBox ( ls_MessageHeader, "Only the Profit Tools Administrator is authorized "+&
		"to perform this procedure.~n~nRequest cancelled." )
	li_Return = 0
	GOTO CleanUp
END IF 

//Create Export DataStore
lds_Target = CREATE DataStore
lds_Target.DataObject = "d_CompanyExport"
lds_Target.SetTransObject ( SQLCA )

//Create Retrieval DataStore

ls_Select = "SELECT * FROM companies LEFT OUTER JOIN brok_carriers"

lds_Source = lnv_Dws.of_CreateDataStore ( ls_Select )

IF NOT IsValid ( lds_Source ) THEN
	GOTO Failure
END IF

lds_Source.SetFilter ( "co_Status <> 'D'" )
lds_Source.SetSort ( "co_Name ASC, co_Id ASC" )

//Retrieve Company Information

ll_RowCount = lds_Source.Retrieve ( )

CHOOSE CASE ll_RowCount
CASE -1
	ROLLBACK ;
	GOTO Failure
CASE 0
	COMMIT ;
	MessageBox ( ls_MessageHeader, "There are no companies to export." )
	li_Return = 0
	GOTO CleanUp
CASE ELSE
	COMMIT ;
END CHOOSE

//Initialize rows in the target  (Not actually needed against current target)

FOR ll_Row = 1 TO ll_RowCount
	lds_Target.InsertRow ( ll_Row )
NEXT

//Copy Information

li_TargetColumnCount = Integer ( lds_Target.Object.DataWindow.Column.Count )

FOR li_TargetColumnId = 1 TO li_TargetColumnCount

	ls_SourceColumn = ""
	ls_TargetColumn = Lower ( lds_Target.Describe ( "#" + String ( li_TargetColumnId ) + ".Name" ) )

	CHOOSE CASE ls_TargetColumn
	CASE "id"
		ls_SourceColumn = "companies_co_id"
	CASE "codename"
		ls_SourceColumn = "companies_co_code_name"
	CASE "name"
		ls_SourceColumn = "companies_co_name"
	CASE "address1"
		ls_SourceColumn = "companies_co_addr1"
	CASE "address2"
		ls_SourceColumn = "companies_co_addr2"
	CASE "city"
		ls_SourceColumn = "companies_co_city"
	CASE "state"
		ls_SourceColumn = "companies_co_state"
	CASE "zip"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatZip ( lds_Source.GetItemString ( ll_Row, "companies_co_zip" ) ) )
		NEXT
	CASE "phone1"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatPhone ( lds_Source.GetItemString ( ll_Row, "companies_co_phone1" ), &
				of_UsePhoneFormat ( lds_Source.GetItemString ( ll_Row, "companies_co_usnon" ) ) ) )
		NEXT
	CASE "phone2"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatPhone ( lds_Source.GetItemString ( ll_Row, "companies_co_phone2" ), &
				of_UsePhoneFormat ( lds_Source.GetItemString ( ll_Row, "companies_co_usnon" ) ) ) )
		NEXT
	CASE "fax"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatPhone ( lds_Source.GetItemString ( ll_Row, "companies_co_fax" ), &
				of_UsePhoneFormat ( lds_Source.GetItemString ( ll_Row, "companies_co_usnon" ) ) ) )
		NEXT
	CASE "allow_billing"
		FOR ll_Row = 1 TO ll_RowCount
			CHOOSE CASE lds_Source.GetItemString ( ll_Row, "companies_co_allow_billing" )
			CASE "T"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "Y" )
			CASE "F"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "N" )
			END CHOOSE
		NEXT
	CASE "accounting_id"
		ls_SourceColumn = "companies_co_bill_acctcode"
	CASE "bill_different"
		//NOTE: Value needs to be converted AND REVERSED
		FOR ll_Row = 1 TO ll_RowCount
			CHOOSE CASE lds_Source.GetItemString ( ll_Row, "companies_co_bill_same" )
			CASE "T"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "N" )
			CASE "F"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "Y" )
			END CHOOSE
		NEXT
	CASE "bill_name"
		ls_SourceColumn = "companies_co_bill_name"
	CASE "bill_address1"
		ls_SourceColumn = "companies_co_bill_addr1"
	CASE "bill_address2"
		ls_SourceColumn = "companies_co_bill_addr2"
	CASE "bill_city"
		ls_SourceColumn = "companies_co_bill_city"
	CASE "bill_state"
		ls_SourceColumn = "companies_co_bill_state"
	CASE "bill_zip"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatZip ( lds_Source.GetItemString ( ll_Row, "companies_co_bill_zip" ) ) )
		NEXT
	CASE "bill_phone1"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatPhone ( lds_Source.GetItemString ( ll_Row, "companies_co_bill_phone1" ), &
				of_UsePhoneFormat ( lds_Source.GetItemString ( ll_Row, "companies_co_bill_usnon" ) ) ) )
		NEXT
	CASE "bill_phone2"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatPhone ( lds_Source.GetItemString ( ll_Row, "companies_co_bill_phone2" ), &
				of_UsePhoneFormat ( lds_Source.GetItemString ( ll_Row, "companies_co_bill_usnon" ) ) ) )
		NEXT
	CASE "bill_fax"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatPhone ( lds_Source.GetItemString ( ll_Row, "companies_co_bill_fax" ), &
				of_UsePhoneFormat ( lds_Source.GetItemString ( ll_Row, "companies_co_bill_usnon" ) ) ) )
		NEXT
	CASE "carrier"
		FOR ll_Row = 1 TO ll_RowCount
			IF lds_Source.GetItemNumber ( ll_Row, "companies_bc_id" ) > 0 THEN
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "Y" )
			ELSE
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "N" )
			END IF
		NEXT
	CASE "federal_id"
		ls_SourceColumn = "companies_bc_fedid"
	CASE "common"
		FOR ll_Row = 1 TO ll_RowCount
			CHOOSE CASE lds_Source.GetItemString ( ll_Row, "companies_bc_common" )
			CASE "T"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "Y" )
			CASE "F"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "N" )
			END CHOOSE
		NEXT
	CASE "common_mc"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatMC ( lds_Source.GetItemString ( ll_Row, "companies_bc_common_mc" ) ) )
		NEXT
	CASE "broker"
		FOR ll_Row = 1 TO ll_RowCount
			CHOOSE CASE lds_Source.GetItemString ( ll_Row, "companies_bc_broker" )
			CASE "T"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "Y" )
			CASE "F"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "N" )
			END CHOOSE
		NEXT
	CASE "broker_mc"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatMC ( lds_Source.GetItemString ( ll_Row, "companies_bc_broker_mc" ) ) )
		NEXT
	CASE "contract"
		FOR ll_Row = 1 TO ll_RowCount
			CHOOSE CASE lds_Source.GetItemString ( ll_Row, "companies_bc_contract" )
			CASE "T"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "Y" )
			CASE "F"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "N" )
			END CHOOSE
		NEXT
	CASE "contract_mc"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				of_FormatMC ( lds_Source.GetItemString ( ll_Row, "companies_bc_contract_mc" ) ) )
		NEXT
	CASE "hazmat"
		FOR ll_Row = 1 TO ll_RowCount
			CHOOSE CASE lds_Source.GetItemString ( ll_Row, "companies_bc_hazmat" )
			CASE "T"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "Y" )
			CASE "F"
				lds_Target.SetItem ( ll_Row, ls_TargetColumn, "N" )
			END CHOOSE
		NEXT
	CASE "liability"
		ls_SourceColumn = "companies_bc_liability_amt"
	CASE "liability_exp"
		ls_SourceColumn = "companies_bc_liability_exp"
	CASE "cargo"
		ls_SourceColumn = "companies_bc_cargo_amt"
	CASE "cargo_exp"
		ls_SourceColumn = "companies_bc_cargo_exp"
	CASE "bond"
		ls_SourceColumn = "companies_bc_bond_amt"
	CASE "last_update"
		FOR ll_Row = 1 TO ll_RowCount
			lds_Target.SetItem ( ll_Row, ls_TargetColumn, &
				Date ( lds_Source.GetItemDateTime ( ll_Row, "companies_bc_lastupdt" ) ) )
		NEXT
	END CHOOSE

	IF Len ( ls_SourceColumn ) > 0 THEN

		li_SourceColumnId = Integer ( lds_Source.Describe ( ls_SourceColumn + ".Id" ) )

		IF li_SourceColumnId > 0 THEN

			lds_Target.Object.Data [ 1, li_TargetColumnId, ll_RowCount, li_TargetColumnId ] = &
				lds_Source.Object.Data [ 1, li_SourceColumnId, ll_RowCount, li_SourceColumnId ]

		ELSE
			//Error Processing?
		END IF

	END IF

NEXT

//Doing a parameter-less SaveAs on the target datastore fails (-1 Return).
//Apparently, this functionality isn't supported on datastores, even though the docs
//say it is.

ls_Title = "Specifiy Export File Location"
ls_PathName = "export.xls"
ls_FileName = ""
ls_Extension = "xls"
ls_Filter = "Excel Files (*.xls), *.xls"  //"Excel Files (*.xls), *.xls, All Files (*.*), *.*"
ls_CancelWarning = "The company list will not be exported."

IF lnv_File.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
	ls_Filter, ls_CancelWarning ) = -1 THEN

		li_Return = 0
		GOTO CleanUp
END IF

IF lds_Target.SaveAs ( ls_PathName, Excel!, TRUE ) = -1 THEN
	GOTO Failure
END IF

li_Return = 1
GOTO CleanUp

Failure:
MessageBox ( ls_MessageHeader, "Could not export company list.  Please retry.", &
	Exclamation! )
li_Return = -1

CleanUp:
DESTROY lds_Source
DESTROY lds_Target
RETURN li_Return
end function

public function string of_formatzip (string as_value);String	ls_Result

as_Value = Upper ( Trim ( as_Value ) )

//NOTE : Having a match as the first (only) condition was causing a GPF

IF Len ( as_Value ) = 9 THEN
	IF Match ( as_Value, "^[0-9]+$" ) THEN
		ls_Result = Left ( as_Value, 5 ) + "-" + Right ( as_Value, 4 )
	ELSE
		ls_Result = as_Value
	END IF
ELSE
	ls_Result = as_Value
END IF

RETURN ls_Result
end function

public function string of_formatphone (string as_value, boolean ab_useformat);String	ls_Result

as_Value = Upper ( Trim ( as_Value ) )

IF ab_UseFormat THEN
	ls_Result = String ( Left ( as_Value, 10 ), "(@@@) @@@-@@@@" )
	IF Len ( as_Value ) > 10 THEN
		ls_Result += " x " + Mid ( as_Value, 11 )
	END IF
ELSE
	ls_Result = as_Value
END IF

RETURN ls_Result

end function

public function boolean of_usephoneformat (string as_usnon);CHOOSE CASE as_UsNon
CASE "U"
	RETURN TRUE
CASE "N"
	RETURN FALSE
CASE ELSE
	RETURN FALSE
END CHOOSE
end function

public function string of_formatmc (string as_value);String	ls_Result

as_Value = Upper ( Trim ( as_Value ) )

IF Len ( as_Value ) > 6 THEN
	ls_Result = String ( as_Value, "@@@@@@ (@@@)" )
ELSE
	ls_Result = as_Value
END IF

RETURN ls_Result
end function

public function integer of_copy_by_column (long al_id, powerobject apo_target, long al_targetrow, readonly string asa_source_alias[], readonly string asa_target_alias[]);//This function is similar to n_cst_dws.of_copy_by_column, but instead of passing a data 
//source and row, you pass a source id, and that gets mapped to the source row in the cache.
//This is very similar to n_cst_Equipment.of_Copy_By_Column

//Return Values: 1 = Success, 0 = ID not found (no error), -1 = Error

n_cst_numerical lnv_numerical
integer li_target_count, li_target_ndx
long ll_source_row
string lsa_target_columns[], ls_TargetColumn
s_co_info lstr_company
n_cst_dws lnv_Dws

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

if lnv_Dws.of_copy_by_column(ids_cache, ll_source_row, apo_target, al_TargetRow, &
	asa_source_alias, asa_target_alias) < 1 then return -1

for li_target_ndx = 1 to li_target_count

	ls_TargetColumn = lsa_target_columns[li_target_ndx]

	choose case ls_TargetColumn  //These are special cases (target columns not in the cache)
	case "xco_location"
		if this.of_get_info(al_id, lstr_company, false) = -1 then
			return -1
		else
			lnv_Dws.of_SetItem ( apo_Target, al_TargetRow, ls_TargetColumn, &
				this.of_make_location(lstr_company.co_city, lstr_company.co_state, &
				lstr_company.co_zip, lstr_company.co_usnon, lstr_company.co_country, &
				"SIMPLE!"))
		end if
	end choose

next

return 1
end function

public function datastore of_getcache ();RETURN ids_Cache
end function

public function integer of_qbexport (readonly long ala_ids[]);DataStore	lds_Source, &
				lds_Target
String		ls_Select, &
				ls_MessageHeader, &
				ls_SourceColumn, &
				ls_TargetColumn, &
				lsa_SourceColumns[], &
				lsa_TargetColumns[], &
				ls_Title, &
				ls_PathName, &
				ls_FileName, &
				ls_Extension, &
				ls_Filter, &
				ls_CancelWarning, &
				ls_Value, &
				lsa_Address[5], &
				lsa_BlankAddress[5]
Integer		li_Return, &
				li_TargetColumnCount, &
				li_SourceColumnId, &
				li_TargetColumnId, &
				li_Ndx
Long			ll_RowCount, &
				ll_Row, &
				ll_SourceRow
n_cst_Dws	lnv_Dws
n_cst_File	lnv_File
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

//NOTE:  This currently does nothing with the id array passed in.  It just retrieves everything, 
//and exports that.  Also, it uses the physical address, even if there's a billing address specified
//(the billing address functionality hasn't been built into the beo yet.)


//Initialize target column array
lsa_TargetColumns = {"!CUST", "NAME", "BADDR1", "BADDR2", "BADDR3", "BADDR4", "BADDR5", "PHONE1", "PHONE2", "FAXNUM", "CTYPE", "TERMS", "TAXABLE", "COMPANYNAME"}


//Set up datastore to hold batch information for export

lds_Target = lnv_Dws.of_CreateDataStore ( UpperBound ( lsa_TargetColumns ) )

IF NOT IsValid ( lds_Target ) THEN
	GOTO Failure
END IF


//Put column headers into datastore

SetPointer ( Hourglass! )

ll_Row = lds_Target.InsertRow ( 0 )

for li_TargetColumnId = 1 to upperbound(lsa_TargetColumns)
	lds_Target.object.data.primary[ll_row, li_TargetColumnId] = lsa_TargetColumns[li_TargetColumnId]
next

//*****



//Create Retrieval DataStore

ls_Select = "SELECT * FROM companies"

lds_Source = lnv_Dws.of_CreateDataStore ( ls_Select )

IF NOT IsValid ( lds_Source ) THEN
	GOTO Failure
END IF

lds_Source.SetFilter ( "co_Status <> 'D'" )
lds_Source.SetSort ( "co_Name ASC, co_Id ASC" )

//Retrieve Company Information

ll_RowCount = lds_Source.Retrieve ( )

CHOOSE CASE ll_RowCount
CASE -1
	ROLLBACK ;
	GOTO Failure
CASE 0
	COMMIT ;
	MessageBox ( ls_MessageHeader, "There are no companies to export." )
	li_Return = 0
	GOTO CleanUp
CASE ELSE
	COMMIT ;
END CHOOSE

lnv_Company.of_SetSource ( lds_Source )


//Copy Information

FOR ll_SourceRow = 1 TO ll_RowCount

	lnv_Company.of_SetSourceRow ( ll_SourceRow )

	ll_Row = lds_Target.InsertRow ( 0 )

	//Determine Address Info

	li_Ndx = 0
	lsa_Address = lsa_BlankAddress

	ls_Value = lnv_Company.of_GetName ( )
	IF Len ( ls_Value ) > 0 THEN
		li_Ndx ++
		lsa_Address [ li_Ndx ] = ls_Value
	END IF

	ls_Value = lnv_Company.of_GetAddress1 ( )
	IF Len ( ls_Value ) > 0 THEN
		li_Ndx ++
		lsa_Address [ li_Ndx ] = ls_Value
	END IF

	ls_Value = lnv_Company.of_GetAddress2 ( )
	IF Len ( ls_Value ) > 0 THEN
		li_Ndx ++
		lsa_Address [ li_Ndx ] = ls_Value
	END IF

	ls_Value = lnv_Company.of_GetLocationPostal ( )
	IF Len ( ls_Value ) > 0 THEN
		li_Ndx ++
		lsa_Address [ li_Ndx ] = ls_Value
	END IF


	for li_TargetColumnId = 1 to upperbound(lsa_TargetColumns)

		CHOOSE CASE lsa_TargetColumns [ li_TargetColumnId ]

		CASE "!CUST"
			ls_Value = "CUST"

		CASE "NAME"
			ls_Value = lnv_Company.of_GetName ( )

		CASE "BADDR1"
			ls_Value = lsa_Address [ 1 ]

		CASE "BADDR2"
			ls_Value = lsa_Address [ 2 ]

		CASE "BADDR3"
			ls_Value = lsa_Address [ 3 ]

		CASE "BADDR4"
			ls_Value = lsa_Address [ 4 ]

		CASE "BADDR5"
			ls_Value = lsa_Address [ 5 ]

		CASE "PHONE1"
			ls_Value = lnv_Company.of_FormatPhone1 ( )

		CASE "PHONE2"
			ls_Value = lnv_Company.of_FormatPhone2 ( )

		CASE "FAXNUM"
			ls_Value = lnv_Company.of_FormatFax ( )

		CASE "CTYPE"
			ls_Value = "Commercial"

		CASE "TERMS"
			ls_Value = "Net 30"

		CASE "TAXABLE"
			ls_Value = "N"

		CASE "COMPANYNAME"
			ls_Value = lnv_Company.of_GetName ( )

		CASE ELSE
			ls_Value = ""

		END CHOOSE

		lds_Target.object.data.primary[ll_row, li_TargetColumnId] = ls_value

	next

NEXT

//***********

//Doing a parameter-less SaveAs on the target datastore fails (-1 Return).
//Apparently, this functionality isn't supported on datastores, even though the docs
//say it is.

ls_Title = "Specifiy Export File Location"
ls_PathName = "ptcust.iif"
ls_FileName = ""
ls_Extension = "iif"
ls_Filter = "IIF Files (*.iif), *.iif"  //"IIF Files (*.iif), *.iif, All Files (*.*), *.*"
ls_CancelWarning = "The company list will not be exported."

IF lnv_File.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
	ls_Filter, ls_CancelWarning ) = -1 THEN

		li_Return = 0
		GOTO CleanUp
END IF

IF lds_Target.SaveAs ( ls_PathName, Text!, FALSE ) = -1 THEN
	GOTO Failure
END IF

li_Return = 1
GOTO CleanUp

Failure:
MessageBox ( ls_MessageHeader, "Could not export company list.  Please retry.", &
	Exclamation! )
li_Return = -1

CleanUp:
DESTROY lds_Source
DESTROY lds_Target
DESTROY lnv_Company

RETURN li_Return
end function

public function integer of_makeentity (long al_companyid, ref long al_entityid);//Returns : 1 = Success (Entity Added ), 0 = Entity already exists, no action taken, -1 = Error

Long	ll_EntityId
Integer	li_Return

li_Return = -1
SetNull ( al_EntityId )


Constant Boolean	lb_AllowCreate = FALSE
Constant Boolean	lb_CreateQuery = FALSE

CHOOSE CASE This.of_GetEntity ( al_CompanyId, ll_EntityId, lb_AllowCreate, lb_CreateQuery )

CASE 1
	al_EntityId = ll_EntityId
	li_Return = 0

CASE 0

	Long	ll_NextId
	Constant Boolean	cb_Commit = TRUE
		
	IF gnv_App.of_GetNextId ( "n_cst_beo_entity", ll_NextId, cb_Commit ) = 1 THEN
	
		INSERT INTO Entity ( Id, fkCompany ) VALUES ( :ll_NextId, :al_CompanyId ) ;

		IF SQLCA.SqlCode = 0 THEN
			COMMIT ;
			al_EntityId = ll_NextId
			li_Return = 1
		ELSE
			ROLLBACK ;
		END IF
		
	END IF
	
CASE ELSE //-1
	//Error.  Allow to fail.

END CHOOSE



RETURN li_Return
end function

public function integer of_getentity (long al_companyid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
-ab_OpenSetup. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.


*/

//Returns : 1 = Success, 0 = Not Found, -1 = Error

CONSTANT Boolean cb_OpenSetup = FALSE

RETURN This.of_GetEntity ( al_companyid , al_entityid, ab_allowcreate, ab_createquery, cb_OpenSetup )

//
//Long	ll_EntityId
//Boolean	lb_Create
//String	ls_MessageHeader = "Select Company"
//n_cst_Privileges	lnv_Privileges
//Integer	li_Return
//Int		li_MakeRtn
//
//SetNull ( al_EntityId )
//
//
//IF NOT IsNull ( al_CompanyId ) THEN
//
//	SELECT Id INTO :ll_EntityId FROM Entity WHERE fkCompany = :al_CompanyId ;
//	
//	CHOOSE CASE SQLCA.SqlCode
//	
//	CASE 0
//		COMMIT ;
//		al_EntityId = ll_EntityId
//		li_Return = 1
//	
//	CASE 100
//		COMMIT ;
//		li_Return = 0
//	
//		IF ab_AllowCreate THEN
//	
//			//Here, I'm taking CreateQuery to be like a "notify" flag.  If CreateQuery is true, the user will get
//			//feedback depending on their privileges.  If CreateQuery is false, the creation will either happen
//			//or not happen silently, depending on the user's privileges.
//	
//			IF ab_CreateQuery THEN
//	
//				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
//	
//					IF MessageBox ( ls_MessageHeader, "The company you have indicated is not currently set up "+&
//						"to handle transactions.  Do you want to perform the setup now?", Question!, YesNo!, 1 ) = 1 THEN
//		
//						lb_Create = TRUE
//		
//					END IF
//	
//				ELSE
//	
//					MessageBox ( ls_MessageHeader, "The company you have indicated is not currently set up "+&
//						"to handle transactions." )
//	
//				END IF
//	
//			ELSE
//	
//				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
//					lb_Create = TRUE
//				END IF
//	
//			END IF
//	
//		END IF
//	
//	
//		IF lb_Create THEN
//			li_MakeRtn = This.of_MakeEntity ( al_CompanyId, ll_EntityId )
//			CHOOSE CASE  li_MakeRtn
//	
//			CASE -1  //Failed
//				li_Return = -1
//	
//				IF ab_CreateQuery THEN
//					MessageBox ( ls_MessageHeader, "Could not perform setup.  Request cancelled.", Exclamation! )
//				END IF
//		
//			CASE ELSE
//				//Entity was created successfully (or already exists.)
//				al_EntityId = ll_EntityId
//				li_Return = 1
//	
//			END CHOOSE
//			
//			IF li_Return = 1 AND ab_createquery AND li_MakeRtn = 1 THEN
//
//				w_AmountTemplates		lw_AmountTemplates
//				OpenSheetWithParm (lw_AmountTemplates, al_EntityId ,gnv_App.of_GetFrame ( ), 0, Layered!)
//
//			END IF
//			
//	
//		END IF
//	
//	
//	CASE ELSE
//		ROLLBACK ;
//		li_Return = -1
//	
//	END CHOOSE
//	
//ELSE
//	li_Return = 0
//	
//END IF
//
//
//	
//
//
//RETURN li_Return
end function

public function integer of_getentity (long al_companyid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
-ab_OpenSetup. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.

*/
//Returns : 1 = Success, 0 = Not Found, -1 = Error

Long	ll_EntityId
Boolean	lb_Create
String	ls_MessageHeader = "Select Company"
n_cst_Privileges	lnv_Privileges
Integer	li_Return
Int		li_MakeRtn

SetNull ( al_EntityId )


IF NOT IsNull ( al_CompanyId ) THEN

	SELECT Id INTO :ll_EntityId FROM Entity WHERE fkCompany = :al_CompanyId ;
	
	CHOOSE CASE SQLCA.SqlCode
	
	CASE 0
		COMMIT ;
		al_EntityId = ll_EntityId
		li_Return = 1
	
	CASE 100
		COMMIT ;
		li_Return = 0
	
		IF ab_AllowCreate THEN
	
			//Here, I'm taking CreateQuery to be like a "notify" flag.  If CreateQuery is true, the user will get
			//feedback depending on their privileges.  If CreateQuery is false, the creation will either happen
			//or not happen silently, depending on the user's privileges.
	
			IF ab_CreateQuery THEN
	
				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
	
					IF MessageBox ( ls_MessageHeader, "The company you have indicated is not currently set up "+&
						"to handle transactions.  Do you want to perform the setup now?", Question!, YesNo!, 1 ) = 1 THEN
		
						lb_Create = TRUE
		
					END IF
	
				ELSE
	
					MessageBox ( ls_MessageHeader, "The company you have indicated is not currently set up "+&
						"to handle transactions." )
	
				END IF
	
			ELSE
	
				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
					lb_Create = TRUE
				END IF
	
			END IF
	
		END IF
	
	
		IF lb_Create THEN
			li_MakeRtn = This.of_MakeEntity ( al_CompanyId, ll_EntityId )
			CHOOSE CASE  li_MakeRtn
	
			CASE -1  //Failed
				li_Return = -1
	
				IF ab_CreateQuery THEN
					MessageBox ( ls_MessageHeader, "Could not perform setup.  Request cancelled.", Exclamation! )
				END IF
		
			CASE ELSE
				//Entity was created successfully (or already exists.)
				al_EntityId = ll_EntityId
				li_Return = 1
	
			END CHOOSE
			
			IF li_Return = 1 AND ab_OpenSetup AND li_MakeRtn = 1 THEN

				w_tv_AmountTemplates		lw_AmountTemplates
				OpenSheetWithParm (lw_AmountTemplates, al_EntityId ,gnv_App.of_GetFrame ( ), 0, Layered!)

			END IF
			
	
		END IF
	
	
	CASE ELSE
		ROLLBACK ;
		li_Return = -1
	
	END CHOOSE
	
ELSE
	li_Return = 0
	
END IF


	



RETURN li_Return
end function

public function integer of_cacheall ();String		ls_Select
String		ls_ModString
String		ls_OriginalSelect
Long			ll_RetrieveRtn 
Long			ll_Return = -1
String	ls_Rtn

IF ISValid ( ids_cache ) THEN

	ids_cache.setTransobject ( sqlca )
	
	ls_originalselect = ids_cache.Describe("DataWindow.Table.Select")
	
	ls_Select = "SELECT * FROM companies"
	ls_modstring = "DataWindow.Table.Select='" + ls_select + "'"

	ls_Rtn = ids_cache.Modify( ls_modstring )

	// the { 1 } is needed to satisfy the argument for retrieval. but is not used since the select
	// is changed to Select * From ...
	ll_RetrieveRtn = ids_cache.Retrieve ( { 1 } )
	
		
	// since i will be setting the ds as an instance i want to set the select statement
	// back to the original 
	ls_modstring = "DataWindow.Table.Select='" + ls_originalselect + "'"
		
	ids_cache.Modify( ls_modstring )
	
	IF ll_RetrieveRtn >= 0 THEN  // changed to >= b.c. we may be importing companies into a fresh DB
		ll_Return = 1
	END IF

END IF

Return ll_Return
end function

public function long of_doesaccountingidexist (readonly string as_accountingid);// this method checks through the cache to see if the accounting id exists.
//Return Values:  >0 = success (a positive row in the cache), 0 = Not Found (No error), 
//						
// The function returns 0 for a null al_target_id (Not Found).
// The function will not return null.

long ll_foundrow

IF Not IsNull (as_accountingid  ) THEN
	ll_foundrow = ids_cache.find("co_Status = 'K' AND co_bill_acctcode = '" + as_accountingid + "'", 1, ids_cache.rowcount())
END IF	


return ll_foundrow

end function

public function integer of_validateaccountingids (boolean ab_openWindow);Int			i
Long			ll_RetrieveRtn
String 		ls_OriginalSelect
string  		ls_modstring
String		ls_WhereClause
Blob			lblb_State
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


datastore	lds_Companies

lds_Companies = create dataStore
lds_Companies.dataObject = "d_company_list"
lds_Companies.setTransobject ( sqlca )

ls_originalselect = lds_Companies.Describe("DataWindow.Table.Select")

ls_WhereClause = "WHERE ~"companies~".~"co_bill_acctcode~"  is null "
ls_modstring = "DataWindow.Table.Select='" &
	+ ls_originalselect + ls_whereclause + "'"
	
lds_Companies.Modify( ls_modstring )
ll_RetrieveRtn = lds_Companies.Retrieve ( )
if ll_RetrieveRtn = -1 then
	rollback ;
else
	commit ;
end if

IF ab_openwindow THEN
	
	lds_Companies.GetFullState ( lblb_State )
	lstr_Parm.is_label = "STATE"
	lstr_Parm.ia_Value = lblb_State
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_label = "TITLE"
	lstr_Parm.ia_Value = "Compainies Without Accounting Ids (double-click for details)"
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	openWithParm ( w_coList , lnv_Msg )
	
END IF
destroy lds_Companies

return ll_RetrieveRtn
end function

public function long of_createnewcompany (string as_companyname, string as_codename, string as_locator);/**
 * this method will create a new company with the specified info. An entry will not be 
 * made if the specified code name already exists. In addition this method create the 
 *	co name index values.
 * This method was created to be used by the FuelCard import when it creates payable entries
 *
 * Returns : -1 on error
 *           >0  the Company ID of the new Company
 *
 */

String	ls_CodeName
Long		ll_ID
Int		li_Return = 1
String	ls_CoName
boolean  lb_Continue = TRUE
Long		ll_COID
Long		ll_NewRow
Int		li_UpdateRtn
String	ls_Xon1
String	ls_Xon2

dataStore lds_CoInfo 
lds_CoInfo = CREATE DataStore 
lds_CoInfo.dataObject = "d_company_info"
lds_CoInfo.SetTransObject ( sqlca )
	
ls_CodeName = as_CodeName
ls_CoName = as_CompanyName

IF NOT isNull ( ls_CodeName )  AND NOT isNull ( ls_CoName ) THEN

	SELECT co_id INTO :ll_ID FROM companies WHERE co_code_name = :ls_CodeName AND co_status = 'K';
	Commit;
	IF ll_ID > 0 THEN  //CodeName exists, Bad.
		li_Return = -1
	END IF
	
	IF li_Return = 1 THEN
		ll_NewRow = lds_CoInfo.InsertRow ( 0 )
		IF ll_NewRow > 0 THEN
			lds_CoInfo.object.Co_Code_name[ ll_NewRow ] = ls_CodeName
			lds_CoInfo.object.Co_name[ ll_NewRow ] = ls_CoName
			IF NOT IsNull ( as_locator ) THEN
				lds_CoInfo.object.co_pcm[ ll_NewRow ] = as_locator
			END IF
		ELSE
			li_Return = -1
		END IF
	END IF			
END IF

IF li_Return = 1 THEN
	IF gf_coname_index ( ls_CoName , ls_Xon1 , ls_Xon2 ) > 0 THEN  // check this
		lds_CoInfo.object.co_xon_1[ ll_NewRow ] = ls_Xon1
		lds_CoInfo.object.co_xon_2[ ll_NewRow ] = ls_Xon2
	END IF
END IF

IF li_Return = 1 THEN
	
	select max(co_id) into :ll_COID from companies ;
	commit;
	ll_CoID ++
	lds_CoInfo.object.co_id [ ll_NewRow ] = ll_CoID
	
END IF

IF li_Return = 1 THEN
	li_UpdateRtn = lds_CoInfo.Update ( )
	IF	li_UpdateRtn = 1 THEN				
		Commit ;
		li_Return = 1
	ELSE
		li_Return = -1 		
	END IF	
END IF
	
destroy lds_CoInfo
IF li_Return = 1 THEN
	li_Return = ll_CoID
END IF

Return li_Return


end function

public function integer of_settemplateondocument (ref n_cst_document anv_document, long al_companyid);//
/***************************************************************************************
NAME			: of_SetTemplateOnDocument
ACCESS		: Public
ARGUMENTS	: n_cst_document (by ref)
				: Long			  (CompanyId)
RETURNS		: Integer 		  (1=success, -1=fail)
DESCRIPTION	: Pass in the company id and a document. This will set the propper template on the 
					document based on the document type. 

REVISION		: RDT 092602
***************************************************************************************/
Integer	li_Return 
String 	ls_template

li_Return = 1

n_cst_beo_company lnv_Company
lnv_Company = Create n_cst_beo_company 

this.of_cache( al_CompanyId, TRUE )   
lnv_Company.Of_SetUseCache( TRUE ) 
lnv_Company.of_SetSourceID( al_CompanyId )  

If NOT lnv_Company.of_HasSource ( ) Then 
	li_Return = -1 
End If

If li_Return = 1 Then 

	Choose Case anv_document.of_GetDocumentType( ) 
			
		Case appeon_constant.cs_acc
			ls_template = lnv_Company.of_getaccnotetemplate ( )

		Case appeon_constant.cs_event
			ls_template = lnv_Company.of_geteventtemplate ( )
			
		Case appeon_constant.cs_authout
			ls_template = lnv_Company.of_getaccauthtemplate ( )
			
		Case appeon_constant.cs_tir
			ls_template = lnv_Company.of_gettirtemplate ( )
			
		Case appeon_constant.cs_lfd
			ls_template = lnv_Company.of_getlastfreedatetemplate ( )

		Case appeon_constant.cs_shipstat
			ls_template = lnv_Company.of_getstatusrequesttemplate ( )
			
		Case appeon_constant.cs_LoadConfirmation
			ls_template = lnv_Company.of_GetLoadConfirmationtemplate ( )
				
		Case else
			MessageBox("Program Error","Missing case in n_cst_Companies.of_SetTemplateOnDocument")
	End Choose

	If Len( Trim ( ls_template) ) > 0 Then 
		anv_document.of_SetTemplateName ( ls_Template )
	Else
		li_Return = -1
	End If
	
End If

destroy ( lnv_Company ) 

Return li_Return 
end function

public function n_cst_beo_company of_select (string as_searchvalue);boolean lb_allow_hold = TRUE
boolean lb_notify = TRUE

RETURN THIS.of_Select ( as_searchvalue , lb_allow_hold , lb_notify )



end function

public function n_cst_beo_company of_select (string as_searchvalue, boolean ab_allowhold, boolean ab_notify);RETURN THIS.of_Select( as_SearchValue, ab_allowhold, ab_notify, "" )
end function

public function long of_getfacilities (long al_coid, ref n_cst_beo_company anva_company[]);/*
	This method will get all the facilities for the company passed in the argument. 
	
	Return facility company beos in reference argument,
			 
	return = # of facilities
	
*/

string	ls_WhereClause, &
			ls_OriginalSelect, &
			ls_rc, &
			ls_ModString
			
long		lla_Facilities [], &
			ll_Count, &
			ll_FacilityCount, &
			ll_Row
			
n_cst_beo_company		lnva_company[]
							
datastore	lds_Companies
//retrieve facilities of companies in the billtoid and add them to the list
lds_Companies = Create datastore
lds_Companies.dataobject = "d_company_list"
lds_Companies.SetTransObject(SQLCA)
ls_WhereClause = "WHERE co_facility_of = " + string(al_coid) + " AND co_status <> ~~'D~~' "
ls_OriginalSelect = lds_Companies.Describe("DataWindow.Table.Select")
ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_WhereClause + "'"
ls_rc = lds_Companies.Modify(ls_ModString)

IF ls_rc = "" THEN
	ll_Row = lds_Companies.Retrieve()
END IF

IF ll_Row > 0 THEN
	lla_Facilities = lds_Companies.Object.co_id.primary
	ll_FacilityCount = UpperBound ( lla_Facilities )
END IF


gnv_cst_Companies.of_Cache ( lla_Facilities, TRUE )

FOR  ll_Count = 1 to ll_FacilityCount
	//gnv_cst_Companies.of_Cache ( lla_Facilities[ll_count], TRUE ) moved outside of loop for performance issues	
	
	//lnv_company = CREATE n_cst_beo_Company
	lnva_company [ ll_Count ] = CREATE n_cst_beo_Company		
	lnva_company [ ll_Count ].of_SetUseCache ( TRUE )
	lnva_company [ ll_Count ].of_SetSourceId ( lla_Facilities[ll_count] ) 
	
NEXT

DESTROY lds_Companies

anva_company[] = lnva_company

return ll_FacilityCount


end function

public function long of_find (string as_fullname, string as_zip);Long	ll_Return
Long	ll_RowCount

DataStore	lds_Results
lds_Results = CREATE DataStore
lds_Results.Dataobject = "d_companyfind"
lds_Results.SetTransObject( SQLCA )

ll_RowCount = lds_Results.Retrieve ( as_fullname , as_zip )

IF ll_RowCount = 1 THEN	
	ll_Return = lds_Results.GetItemNumber( 1, "co_id" )
END IF

DESTROY ( lds_Results )

RETURN ll_Return
end function

public function long of_getcompanybyalias (long al_context, string as_contextcompanyid);Long	ll_Return
Long	ll_PtCoID
Long	ll_Context
String	ls_ContextCompanyID

ll_Context = al_Context
ls_ContextCompanyID = as_contextcompanyid

  SELECT "companyalias"."ptcoid"  
    INTO :ll_PtCoID  
    FROM "companyalias"  
   WHERE ( "companyalias"."context" = :ll_Context ) AND  
         ( "companyalias"."contextcompanyid" = :ls_ContextCompanyID )   ;
			
			
IF SQLCA.Sqlcode = 0 THEN
	ll_Return = ll_ptCoID
	Commit;
ELSE
	ROLLBACK;
END IF

RETURN ll_Return

end function

public function integer of_defaultaliaslisttocoref (long al_context);Int			li_Return = 1
Long			ll_RowCount
Long			i
String		ls_CodeName
Long			ll_CoID
Int			li_Temp
Long			ll_NewRow

DataStore	lds_Update
lds_Update = Create DataStore
lds_Update.Dataobject = "d_CompanyAlias"
lds_Update.Settransobject( sqlca )


dataStore	lds_Default
lds_Default = Create DataStore
lds_Default.Dataobject = "d_aliasDefault"
lds_Default.Settransobject( sqlca )

DELETE FROM "companyalias"  
   WHERE "companyalias"."context" = :al_Context ;

ll_RowCount = lds_Default.Retrieve( )

FOR i = 1 TO ll_RowCount
	ls_CodeName = lds_Default.GetItemString ( i , "companies_co_code_name" )
	ll_CoID = lds_Default.GetItemNumber ( i , "companies_co_id" )
	
	ll_NewRow = lds_Update.InsertRow ( 0 ) 
	
	IF Len ( ls_CodeName ) > 0 THEN
		li_Temp = lds_Update.Setitem( ll_NewRow , "Context", al_context )
		li_Temp = lds_Update.Setitem( ll_NewRow , "ContextCompanyID", ls_CodeName )
		li_Temp = lds_Update.Setitem( ll_NewRow , "PtCoID", ll_CoID )		
	END IF
	
NEXT

IF lds_Update.Update ( )  = 1 THEN

	commit;
	
ELSE
	Rollback;
	li_Return = -1
END IF

DESTROY ( lds_Default )
DESTROY ( lds_Update )

RETURN li_Return
end function

public function integer of_deletealiaslistforcontext (long al_context);Int	li_Return = 1
DELETE FROM "companyalias"  
   WHERE "companyalias"."context" = :al_Context ;
IF Sqlca.Sqlcode = 0 THEN
	Commit;
ELSE
	Rollback;
	li_Return = -1
END IF

RETURN li_Return
end function

public function n_cst_beo_company of_select (string as_searchvalue, boolean ab_allowhold, boolean ab_notify, string as_type);s_co_info lstr_company
string ls_type
boolean lb_search
string ls_search
boolean lb_validate	
long ll_validate


n_cst_beo_Company		lnv_Co

IF Len ( as_SearchValue ) > 0 THEN
	lb_Search = TRUE 
	ls_Search = as_SearchValue
END IF
	
THIS.of_select ( lstr_company, as_type, lb_search, ls_search, lb_validate,ll_validate,ab_AllowHold, ab_Notify )

IF lstr_Company.co_id > 0 THEN
	lnv_Co = CREATE n_cst_beo_Company
	lnv_Co.of_SetUseCache ( TRUE ) 
	lnv_Co.of_SetSourceID ( lstr_Company.co_id )
END IF

RETURN lnv_Co
end function

public function string of_getdocumenttransfermethod (long al_company, n_cst_document anv_document);String	ls_Return 
String	ls_Mode

// ftp is the default
ls_Return = appeon_constant.cs_TransferMethod_FTP

SELECT "companydocumenttransfersettings"."transfermode"  
 INTO :ls_Mode  
 FROM "companydocumenttransfersettings"  
WHERE "companydocumenttransfersettings"."coid" = :al_company   ;

IF SQLCA.SqlCode <> 0 THEN
	Rollback;
ELSE
	COMMIT;
	ls_Return = ls_Mode
END IF

RETURN ls_Return
end function

public function integer of_getdocumentsettings (long al_coid, n_cst_document anv_document, ref n_cst_documentsettings anv_settings);Int	li_Return
n_Cst_DocumentSettings lnv_Settings	
li_Return = 1

IF isValid ( anv_Settings ) THEN
	DESTROY ( anv_Settings ) 
END IF

lnv_Settings = CREATE n_Cst_DocumentSettings

IF lnv_Settings.of_Setcompanyid( al_coid ) <> 1 THEN
	li_Return = -1
END IF

lnv_Settings.of_settransfermethod( THIS.of_getDocumenttransfermethod( al_coid , anv_document ) )

anv_Settings = lnv_Settings
RETURN li_Return
end function

public function integer of_select (ref s_co_info astr_company, string as_type, boolean ab_search, string as_search, boolean ab_validate, long al_validate, boolean ab_allow_hold, boolean ab_notify, boolean ab_allow_new);Boolean	lb_SuppressNewWindow //do not suppress w_comany_response winodw upon selection of new
Return This.of_select ( astr_company, as_type, ab_search, as_search, ab_validate, al_validate, ab_Allow_Hold, ab_Notify, ab_Allow_New, lb_SuppressNewWindow )
end function

public function integer of_select (ref s_co_info astr_company, string as_type, boolean ab_search, string as_search, boolean ab_validate, long al_validate, boolean ab_allow_hold, boolean ab_notify);Boolean	lb_AllowNew

n_cst_setting_AllowNewCompany		lnv_AllowNew
lnv_AllowNew = Create n_cst_setting_AllowNewCompany
lb_AllowNew = lnv_AllowNew.of_GetValue() = lnv_AllowNew.cs_Yes
Destroy(lnv_AllowNew)


Return This.of_select ( astr_company, as_type, ab_search, as_search, ab_validate, al_validate, ab_Allow_Hold, ab_Notify, lb_AllowNew )




end function

public function integer of_select (ref s_co_info astr_company, string as_type, boolean ab_search, string as_search, boolean ab_validate, long al_validate, boolean ab_allow_hold, boolean ab_notify, boolean ab_allow_new, boolean ab_suppress_newwindow);//Description of Arguments
//
//astr_company : s_co_info by reference  Will contain selected company specs, or null_info
//as_type : string by value (ANY!, BILLTO!, BILLING!, CARRIER!, CARRIER_WITH_WARNINGS!, NEW!)
				//BILLTO! = selected company will be specified as a billto
				//BILLING! = selected company will be billed (the criteria for these may differ)
				//CARRIER! = selected company will be specified as a carrier
				//CARRIER_WITH_WARNINGS! = same as CARRIER!, but with warnings about insurance, etc.
				//NEW! = bypass selection window and bring user directly to w_coname
//ab_search : boolean by value  Whether a search string is being passed
//as_search : string by value   The search string to evaluate, if any
//ab_validate : boolean by value  Whether an id to validate is being passed
//al_validate : long by value  The id to validate, if any
//ab_allow_hold : whether to allow an On Hold company to be selected
//ab_notify : whether to notify user if a selection or validation is rejected
//ab_allow_new : boolean by value  Whether to allow New in the selection window
//ab_suppress_newwindow: whether to suppress w_company_response window upon selection of NEW! (default:false)

//Return Values
// 1 : Selection made, or validation approved.  Info in astr_company.
//			IMPORTANT!! : For as_types other than BILLING!, the user can select not to have 
//			a company, giving a return value of 1 but an astr_company.co_id of null.
//			BILLING! will only return 1 for a "real" company that meets the other criteria.
// 0 : No selection made (select process cancelled), or validation rejected.
//-1 : Error
//-2 : New company requested.  Name available in structure


//!! There's several places in here where we return -1 w.o. an explanation message, 
//		even when ab_notify = true.  We should check on this.  Same thing goes for
//		return 0 when the chosen company turns out to be deleted.


integer li_result
long ll_foundrow, ll_id
string ls_work, ls_carrier_warning, ls_coname, ls_SelectedName
s_strings lstr_open_parms
s_co_info lstr_check
n_cst_numerical lnv_numerical

n_cst_Msg	lnv_Msg
s_Parm 		lstr_Parm

astr_company = istr_null_info
if ab_notify = false then message.stringparm = ""

if ab_search and ab_validate then return -1 //Can't perform both operations

if ab_search then
	as_search = trim(as_search)
	if len(as_search) > 0 then
		if left(as_search, 1) = "/" then
			ll_foundrow = of_find(as_search)
			if ll_foundrow > 0 then ll_id = ids_cache.object.co_id[ll_foundrow]
		end if
	else
		//User has "selected" to have no company, which is legitimate for as_types other
		//than BILLING!.  In these cases, the null_info will be used.
		if as_type = "BILLING!" then
			message.stringparm = "A billto company was not specified."
			return 0
		else
			return 1
		end if
	end if
elseif ab_validate then
	if al_validate > 0 then
		ll_id = al_validate
	elseif isnull(al_validate) then
		//Null company will be approved for as_types other than BILLING!.  
		//In these cases, the null_info will be used.
		if as_type = "BILLING!" then
			message.stringparm = "A billto company was not specified."
			return 0
		else
			return 1
		end if
	else
		//ID is not acceptable
		return 0
	end if
end if

if lnv_numerical.of_IsNullOrNotPos(ll_id) and not ab_validate then
	if isvalid(w_co_select2) then
		//This would happen during a code name search from w_co_select2
		return 0
	else
		IF as_type = "NEW!" THEN
			ll_Id = -2 //new company
		ELSE
			if not ab_search then as_search = ""
			lstr_open_parms.strar[1] = as_search
			if ab_allow_new then lstr_open_parms.strar[2] = "NEW=ENABLED"
			openwithparm(w_co_select2, lstr_open_parms)
			ll_id = message.doubleparm
			ls_SelectedName = message.stringparm
		END IF
		choose case ll_id
		case is > 0 //User made selection
			//No processing needed
		case 0, -1 //No selection, Error
			//In the case of -2, if the user typed a name, it will still be available to 
			//the calling script in message.stringparm
			return ll_id
		case -2 //New
			
			ls_CoName = "*NC"
			IF Len(ls_SelectedName) > 0 THEN
				ls_CoName += ls_SelectedName
			END IF
			
			OpenWithParm(w_coname, ls_CoName)
			ls_CoName = message.stringparm
			
			IF ls_CoName = "*NC" THEN//cancelled, no selection
				Return 0 
			ELSEIF left(ls_CoName, 1) = "*" THEN //chose existing duplicate
				ll_id = Long(replace(ls_CoName, 1, 1, ""))
			ELSE //New company
				
				IF ab_Suppress_NewWindow THEN
					//Calling script will have access to the name in the structure
					astr_company.co_Name = ls_CoName
					Return -2
				ELSE
					lstr_Parm.is_Label = "NEWCOMPANY"
					lstr_Parm.ia_Value = ls_CoName
					lnv_Msg.of_Add_parm( lstr_Parm)
					openwithparm(w_company_response, lnv_Msg)
					ll_Id = Message.DoubleParm
					IF ll_Id > 0 THEN
						//proceed
					ELSE
						Return 0 //company not saved, user cancelled
					END IF
				END IF
				
			END IF

		case else   //Unanticipated return value
			return -1
		end choose
	end if
end if

//User has made a selection which is stored in ll_id

get_info:

li_result = of_get_info(ll_id, lstr_check, false)

choose case li_result
case is > 0
	//No processing needed
case 0, -1
	return li_result
case else
	return -1
end choose

choose case lstr_check.co_status
case "D"  //Deleted
	return 0
end choose

choose case as_type
case "CARRIER!", "CARRIER_WITH_WARNINGS!"
	choose case of_validate_carrier(lstr_check.co_id, ls_carrier_warning)
	case 1  //Company is a carrier.
		//No processing needed.
	case 0  //Company is not a carrier.
		ls_work = lstr_check.co_name + " has not been set up as a carrier."
		if ab_notify then
			messagebox("Select Carrier", ls_work + "~n~nSelection request cancelled.")
		else
			message.stringparm = ls_work
		end if
		return 0
	case else  //Error
		return -1
	end choose
end choose

choose case lstr_check.co_status
case "H"  //On Hold
	if ab_allow_hold = false then
		ls_work = lstr_check.co_name + " is on hold."
		if ab_notify then
			messagebox("Select Company", ls_work + "~n~nSelection request cancelled.")
		else
			message.stringparm = ls_work
		end if
		return 0
	end if
end choose

choose case as_type
case "ANY!"
	//No processing needed
case "BILLTO!", "BILLING!"
	if lstr_check.co_facility_of > 0 then
		ll_id = lstr_check.co_facility_of
		lstr_check = istr_null_info
		goto get_info
	end if
	if lstr_check.co_allow_billing = "F" and as_type = "BILLING!" then
		//Later, it could become a system option whether companies without billing
		//authorization will be allowed as billtos.  For now, we're allowing them, 
		//but the shipments can't be billed until the authorization is given.
		ls_work = lstr_check.co_name + " does not have billing authorization."
		if ab_notify then
			messagebox("Select Company", ls_work + "~n~nSelection request cancelled.")
		else
			message.stringparm = ls_work
		end if
		return 0
	end if
case "CARRIER!"
	//No processing needed
case "CARRIER_WITH_WARNINGS!"
	if len(ls_carrier_warning) > 0 then
		if messagebox("Select Carrier", "WARNING:~n~n" + ls_carrier_warning + "Do you "+&
			"wish to make the change anyway?", exclamation!, yesno!, 1) = 2 then return 0
	end if
end choose

astr_company = lstr_check
return 1
end function

on n_cst_companies.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_companies.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_cache = create datastore
ids_cache.dataobject = "d_company_cache"

setnull(istr_null_info.co_id)
setnull(istr_null_info.co_name)
setnull(istr_null_info.co_addr1)
setnull(istr_null_info.co_addr2)
setnull(istr_null_info.co_city)
setnull(istr_null_info.co_state)
setnull(istr_null_info.co_zip)
setnull(istr_null_info.co_usnon)
setnull(istr_null_info.co_country)
setnull(istr_null_info.co_bill_same)
setnull(istr_null_info.co_bill_name)
setnull(istr_null_info.co_bill_addr1)
setnull(istr_null_info.co_bill_addr2)
setnull(istr_null_info.co_bill_city)
setnull(istr_null_info.co_bill_state)
setnull(istr_null_info.co_bill_zip)
setnull(istr_null_info.co_bill_usnon)
setnull(istr_null_info.co_bill_country)
setnull(istr_null_info.co_bill_acctcode)
setnull(istr_null_info.co_status)
setnull(istr_null_info.co_facility_of)
setnull(istr_null_info.co_tz)
setnull(istr_null_info.co_pcm)
setnull(istr_null_info.co_allow_billing)
end event

event destructor;destroy ids_cache
end event

