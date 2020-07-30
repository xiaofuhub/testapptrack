$PBExportHeader$n_cst_ship_type.sru
forward
global type n_cst_ship_type from nonvisualobject
end type
end forward

shared variables
//begin modification Shared Variables by appeon  20070730
//n_ds						ids_defaultDivsCache		//added by dan for default divisions
//int						si_instantiatedCount		//used to count the number of times this was instantiated
//end modification Shared Variables by appeon  20070730
end variables

global type n_cst_ship_type from nonvisualobject autoinstantiate
end type

type variables
//begin modification Shared Variables by appeon  20070730
//n_ds						ids_defaultDivsCache		//added by dan for default divisions
int						si_instantiatedCount		//used to count the number of times this was instantiated
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer of_refresh ()
public function integer of_find_default (string as_category, ref long al_foundrow)
public function integer of_find (long al_target_id, ref long al_foundrow)
public function boolean of_ready (boolean ab_force_refresh)
public function integer of_get_object (long al_id, ref n_cst_object anv_object)
public function integer of_populate (dwobject adwo_target)
public function integer of_gettypelist (readonly string as_category, readonly boolean ab_activeonly, ref long ala_ids[])
public function integer of_gettypelist (readonly string as_category, readonly boolean ab_activeonly, ref string as_typelist)
public function integer of_getcodetable (string as_category, boolean ab_activeonly, long ala_required[], ref string as_codetable)
public function integer of_populate (dwobject adwo_target, string as_category, boolean ab_activeonly, long ala_required[])
public function boolean of_isactive (readonly long al_id)
public function integer of_getname (readonly long al_id, ref string as_name)
public function long of_getdefaultdivisionscache (ref n_ds ads_cache)
public function integer of_getemployeedivisiondefault (string as_templateshiptype, ref n_cst_beo_shiptype anv_shiptypebeo)
public function integer of_savedivisiondefaults ()
public function integer of_divsmodifiedcount ()
end prototypes

public function integer of_refresh ();boolean lb_failed
long ll_rowcount, ll_row
datastore lds_shiptype_back
string ls_dbstring, ls_work
n_cst_string lnv_string

setpointer(hourglass!)

if not isvalid(gds_shiptype) then
	gds_shiptype = create datastore
	gds_shiptype.dataobject = "d_shiptype_list"
	gds_shiptype.settransobject(sqlca)
elseif gds_shiptype.rowcount() > 0 then
	lds_shiptype_back = create datastore
	lds_shiptype_back.dataobject = "d_shiptype_list"
	lds_shiptype_back.object.data.primary = gds_shiptype.object.data.primary
end if

ll_rowcount = gds_shiptype.retrieve()

if ll_rowcount = -1 then
	rollback ;
	lb_failed = true
	goto shiptype_cleanup
else
	commit ;
end if

for ll_row = 1 to ll_rowcount
	ls_dbstring = gds_shiptype.object.st_dbstring[ll_row]
	gds_shiptype.object.st_name[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "NAME")
	gds_shiptype.object.st_status[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "STATUS")
	//Entries for LOGO_ID, DYN_AR, DYN_SLS are only included in the string if they have values
	gds_shiptype.object.st_logo[ll_row] = long(lnv_string.of_ExtractDelimited(ls_dbstring, "LOGO_ID"))

	//The ifs on the following two entries are for backward compatibility.  Once we get
	//the existing dbs converted, they can be removed.  See also DYN_CO, below.

	if pos(ls_dbstring, "DYN_AR") > 0 then
		gds_shiptype.object.st_accounting_ar[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "DYN_AR")
	else
		gds_shiptype.object.st_accounting_ar[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "ACCT_AR")
	end if
	if pos(ls_dbstring, "DYN_SLS") > 0 then
		gds_shiptype.object.st_accounting_sales[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "DYN_SLS")
	else
		gds_shiptype.object.st_accounting_sales[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "ACCT_SLS")
	end if

	gds_ShipType.Object.st_Accounting_AccessorialSales [ ll_Row ] = &
		lnv_String.of_ExtractDelimited ( ls_DBString, "ACCT_ACCESSORIALSALES" )

	//Entries for DEFAULT, BROKERAGE, and EXPEDITE are only included if they are true (=T)
	//Therefore, a null returned by lnv_string.of_ExtractDelimited needs to be converted to "F"
	gds_shiptype.object.st_default[ll_row] = &
		substitute(lnv_string.of_ExtractDelimited(ls_dbstring, "DEFAULT"), null_str, "F")
	gds_shiptype.object.st_brokerage[ll_row] = &
		substitute(lnv_string.of_ExtractDelimited(ls_dbstring, "BROKERAGE"), null_str, "F")
	gds_shiptype.object.st_expedite[ll_row] = &
		substitute(lnv_string.of_ExtractDelimited(ls_dbstring, "EXPEDITE"), null_str, "F")


	//Entries for TYPEONLY AND DIVISIONONLY are only included if they are true (=T)
	//Therefore, a null returned by lnv_string.of_ExtractDelimited needs to be converted to "F"
	gds_shiptype.object.st_TypeOnly[ll_row] = &
		substitute(lnv_string.of_ExtractDelimited(ls_dbstring, "TYPEONLY"), null_str, "F")
	gds_shiptype.object.st_DivisionOnly[ll_row] = &
		substitute(lnv_string.of_ExtractDelimited(ls_dbstring, "DIVISIONONLY"), null_str, "F")
	gds_shiptype.object.intermodal[ll_row] = &
		substitute(lnv_string.of_ExtractDelimited(ls_dbstring, "INTERMODAL"), null_str, "F")


	//Entries for TERMS, REMIT_01 - 05, DYN_CO, and BILLSEQ are only included in the string 
	//if they have values
	gds_shiptype.object.st_terms[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "TERMS")
	gds_shiptype.object.st_remit_01[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "REMIT_01")
	gds_shiptype.object.st_remit_02[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "REMIT_02")
	gds_shiptype.object.st_remit_03[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "REMIT_03")
	gds_shiptype.object.st_remit_04[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "REMIT_04")
	gds_shiptype.object.st_remit_05[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "REMIT_05")

	//The if on the following entry is for backward compatibility.  Once we get the existing
	//dbs converted, it can be removed.  See also DYN_AR and DYN_SLS, above.

	if pos(ls_dbstring, "DYN_CO") > 0 then
		gds_shiptype.object.st_accounting_company[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "DYN_CO")
	else
		gds_shiptype.object.st_accounting_company[ll_row] = lnv_string.of_ExtractDelimited(ls_dbstring, "ACCT_CO")
	end if

	gds_shiptype.object.st_billing_sequence[ll_row] = long(lnv_string.of_ExtractDelimited(ls_dbstring, "BILLSEQ"))
next

shiptype_cleanup:

if lb_failed then
	gds_shiptype.reset()
	if isvalid(lds_shiptype_back) then
		if lds_shiptype_back.rowcount() > 0 then &
			gds_shiptype.object.data.primary = lds_shiptype_back.object.data.primary
	end if
end if

gds_shiptype.resetupdate()
destroy lds_shiptype_back

if lb_failed then
	return -1
else
	gstr_list_settings.b_shiptypes_retrieved = true
	return 1
end if
end function

public function integer of_find_default (string as_category, ref long al_foundrow);//Note:  "DIVISION" is not a supported category here.

string ls_find //= "st_status = 'K' and st_default = 'T' and st_divisiononly = 'F' and st_brokerage = ",,,  AND intermodal <> 'T'
long ll_row

al_foundrow = 0

if this.of_ready(false) = false then return -1

choose case as_category
case "BROKERAGE"
	ls_find = "st_status = 'K' and st_default = 'T' and st_divisiononly = 'F' AND intermodal <> 'T' and st_brokerage = "
	ls_find += "'T'"
case "DISPATCH"
	ls_find = "st_status = 'K' and st_default = 'T' and st_divisiononly = 'F' AND intermodal <> 'T' and st_brokerage = "
	ls_find += "'F'"
CASE "INTERMODAL"
	ls_find = "st_status = 'K' and st_default = 'T' and intermodal = 'T' "
	
case else
	return -1
end choose

ll_row = gds_shiptype.find(ls_find, 1, gds_shiptype.rowcount())

choose case ll_row
case is > 0
	al_foundrow = ll_row
	return 1
case 0
	return 0
case else
	return -1
end choose
end function

public function integer of_find (long al_target_id, ref long al_foundrow);//Returns:  1, 0, -1  Note: Null al_Target_Id returns 1, not 0  (Change this???)

long ll_row
integer li_attempt

al_foundrow = 0

if isnull(al_target_id) then return 1

if this.of_ready(false) = false then return -1

for li_attempt = 1 to 2
	//A second attempt will be made if the first find comes up 0 and a refresh is successful
	ll_row = gds_shiptype.find("st_id = " + string(al_target_id), 1, gds_shiptype.rowcount())
	choose case ll_row
	case is > 0
		al_foundrow = ll_row
		return 1
	case 0
		if li_attempt = 1 then
			if this.of_refresh() = -1 then return -1
		else
			return 0
		end if
	case else
		return -1
	end choose
next
end function

public function boolean of_ready (boolean ab_force_refresh); if gstr_list_settings.b_shiptypes_retrieved = false or ab_force_refresh then
	if this.of_refresh() = -1 then return false
end if

return true
end function

public function integer of_get_object (long al_id, ref n_cst_object anv_object);long ll_row

destroy anv_object

choose case of_find(al_id, ll_row)
case 1
	anv_object = create n_cst_shiptype
	gds_shiptype.rowscopy(ll_row, ll_row, primary!, anv_object.ids_data, 9999, primary!)
	anv_object.ids_data.resetupdate()
	return 1
case 0
	return 0
case else
	return -1
end choose
end function

public function integer of_populate (dwobject adwo_target);CONSTANT String	ls_Category = "ALL"
CONSTANT Boolean	lb_ActiveOnly = FALSE

Long		lla_Required[]

RETURN of_Populate ( adwo_Target, ls_Category, lb_ActiveOnly, lla_Required )
end function

public function integer of_gettypelist (readonly string as_category, readonly boolean ab_activeonly, ref long ala_ids[]);//Returns:  >= 0 (Number of Ids in the result list), -1 = Error

//Note:  With the addition of "DIVISION" as a category in 2.7.01, the previously existing
//categories ("DISPATCH", "BROKERAGE", "ALL") now mean "all dispatch TYPES", 
//"all brokerage TYPES", "all TYPES", but EXCLUDING divisions.  So, we've added checks for 
//DivisionOnly to the include code for those categories.

Long	ll_Row, &
		ll_RowCount, &
		ll_Check, &
		lla_Ids[]
Integer	li_Count
Boolean	lb_Include, lb_Active, lb_TypeOnly, lb_DivisionOnly
n_cst_Numerical	lnv_Numerical

Integer	li_Return = 0

//Clear reference array.
ala_Ids = lla_Ids


if this.of_ready(false) then

	ll_RowCount = gds_ShipType.RowCount ( )

	for ll_row = 1 to ll_RowCount

		lb_include = false
		ll_check = gds_shiptype.object.st_id[ll_row]
		if lnv_numerical.of_IsNullOrNotPos(ll_check) then continue

		lb_Active = gds_shiptype.object.st_status[ll_row] = "K"
		lb_TypeOnly = gds_shiptype.object.st_TypeOnly[ll_row] = "T"
		lb_DivisionOnly = gds_shiptype.object.st_DivisionOnly[ll_row] = "T"

		if lb_active or ab_activeonly = false then
			choose case as_category
			case "BROKERAGE"
				if gds_shiptype.object.st_brokerage[ll_row] = "T" then lb_include = true

				//Preempt the above determination if the DivisionOnly flag is set.
				IF lb_DivisionOnly THEN lb_Include = FALSE

			case "DISPATCH"
				if gds_shiptype.object.st_brokerage[ll_row] = "F" then lb_include = true

				//Preempt the above determination if the DivisionOnly flag is set.
				IF lb_DivisionOnly THEN lb_Include = FALSE

			case "ALL"
				lb_include = true

				//Preempt the above determination if the DivisionOnly flag is set.
				IF lb_DivisionOnly THEN lb_Include = FALSE

			CASE "DIVISION"
				lb_Include = TRUE

				//Preempt the above determination if the TypeOnly flag is set.
				IF lb_TypeOnly THEN lb_Include = FALSE

			end choose
		end if

		if lb_include then
			li_Count ++
			lla_Ids [ li_Count ] = ll_Check
		end if
	next

	ala_Ids = lla_Ids
	li_Return = li_Count

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function integer of_gettypelist (readonly string as_category, readonly boolean ab_activeonly, ref string as_typelist);//Returns:  >= 0 (Number of Ids in the result list), -1 = Error

String	ls_TypeList
Long		lla_Ids[]
n_cst_String	lnv_String

Integer	li_Return = 0

li_Return = This.of_GetTypeList ( as_Category, ab_ActiveOnly, lla_Ids )

IF li_Return > 0 THEN

	lnv_String.of_ArrayToString ( lla_Ids, ", ", ls_TypeList )

END IF

as_TypeList = ls_TypeList

RETURN li_Return
end function

public function integer of_getcodetable (string as_category, boolean ab_activeonly, long ala_required[], ref string as_codetable);//Returns: 1, -1 (Could not retrieve Type List)

//Note:  With the addition of "DIVISION" as a category in 2.7.01, the previously existing
//categories ("DISPATCH", "BROKERAGE", "ALL") now mean "all dispatch TYPES", 
//"all brokerage TYPES", "all TYPES", but EXCLUDING divisions.  So, we've added checks for 
//DivisionOnly to the include code for those categories.

string ls_shiptypes, ls_work
integer li_ndx, li_required_count
long ll_row, ll_check, ll_RowCount
boolean lb_include, lb_Active, lb_TypeOnly, lb_DivisionOnly
n_cst_anyarraysrv lnv_anyarray
n_cst_numerical lnv_numerical

Integer	li_Return = 1

li_required_count = upperbound(ala_required)

if this.of_ready(false) then

	for li_ndx = 1 to li_required_count
		if lnv_numerical.of_IsNullOrNotPos(ala_required[li_ndx]) then
			continue
		elseif this.of_find(ala_required[li_ndx], ll_row) = 1 then
			ls_work = trim(gds_shiptype.object.st_name[ll_row])
			if isnull(ls_work) then ls_work = "" //shouldn't happen
		else
			ls_work = "[TYPE UNAVAILABLE]"
		end if
		if len(ls_shiptypes) > 0 then ls_shiptypes += "/"
		ls_shiptypes += ls_work + "~t" + string(ala_required[li_ndx])
	next

	ll_RowCount = gds_ShipType.RowCount ( )

	for ll_row = 1 to ll_RowCount
		lb_include = false
		ll_check = gds_shiptype.object.st_id[ll_row]
		if lnv_numerical.of_IsNullOrNotPos(ll_check) then continue
		if li_required_count > 0 then
			if lnv_anyarray.of_Find(ala_required, ll_check, 1, li_required_count) > 0 then continue
		end if

		lb_Active = gds_shiptype.object.st_status[ll_row] = "K"
		lb_TypeOnly = gds_shiptype.object.st_TypeOnly[ll_row] = "T"
		lb_DivisionOnly = gds_shiptype.object.st_DivisionOnly[ll_row] = "T"

		if lb_Active or ab_ActiveOnly = false then
			choose case as_category
			case "BROKERAGE"
				if gds_shiptype.object.st_brokerage[ll_row] = "T" then lb_include = true

				//Preempt the above determination if the DivisionOnly flag is set.
				IF lb_DivisionOnly THEN lb_Include = FALSE

			case "DISPATCH"
				if gds_shiptype.object.st_brokerage[ll_row] = "F" then lb_include = true

				//Preempt the above determination if the DivisionOnly flag is set.
				IF lb_DivisionOnly THEN lb_Include = FALSE

			case "ALL"
				lb_include = true

				//Preempt the above determination if the DivisionOnly flag is set.
				IF lb_DivisionOnly THEN lb_Include = FALSE

			CASE "DIVISION"
				lb_Include = TRUE

				//Preempt the above determination if the TypeOnly flag is set.
				IF lb_TypeOnly THEN lb_Include = FALSE
//				
//			CASE "INTERMODAL"
//				
//				lb_include  = gds_shiptype.object.st_Intermodal [ll_row] = "T" 
				
				

			end choose
		end if

		if lb_include then
			if len(ls_shiptypes) > 0 then ls_shiptypes += "/"
			ls_work = trim(gds_shiptype.object.st_name[ll_row])
			if isnull(ls_work) then ls_work = "" //shouldn't happen

			IF lb_Active = FALSE THEN
				ls_Work = "{" + ls_Work + "}"
			END IF

			ls_shiptypes += ls_work + "~t" + string(ll_check)
		end if
	next

else

	li_Return = -1

	for li_ndx = 1 to li_required_count
		if lnv_numerical.of_IsNullOrNotPos(ala_required[li_ndx]) then
			continue
		else
			ls_work = "[TYPE UNAVAILABLE]"
		end if
		if len(ls_shiptypes) > 0 then ls_shiptypes += "/"
		ls_shiptypes += ls_work + "~t" + string(ala_required[li_ndx])
	next

end if

as_CodeTable = ls_shiptypes

return li_Return
end function

public function integer of_populate (dwobject adwo_target, string as_category, boolean ab_activeonly, long ala_required[]);String ls_CodeTable

if not isvalid(adwo_target) then return -1

if upper(adwo_target.type) = "COLUMN" then
else
	return -1
end if

This.of_GetCodeTable ( as_Category, ab_ActiveOnly, ala_Required, ls_CodeTable )

adwo_target.values = ls_CodeTable

return 1
end function

public function boolean of_isactive (readonly long al_id);//Returns:  TRUE, FALSE, Null (Cannot retrieve or find type, other unexpected error)

//Note:  The original intended use for this function was replaced by using the function
//on the beo.  This function may be unreferenced.

Long		ll_FoundRow
Boolean	lb_Active

IF This.of_Find ( al_Id, ll_FoundRow ) = 1 THEN
	lb_Active = gds_shiptype.object.st_status[ll_FoundRow] = "K"
ELSE
	SetNull ( lb_Active )
END IF

RETURN lb_Active
end function

public function integer of_getname (readonly long al_id, ref string as_name);//Passes out the Name of the requested ShipType.
//Returns : 1, 0, -1

Long		ll_Row
Integer	li_Return = 1

SetNull ( as_Name )

CHOOSE CASE This.of_Find ( al_id, ll_row )

CASE 1
	IF ll_Row > 0 THEN  //This is necessary b.c. of_Find returns 1 for null id
		as_Name = gds_ShipType.Object.st_Name [ ll_Row ]
	ELSE
		li_Return = 0
	END IF

CASE 0
	li_Return = 0

CASE ELSE
	li_Return =  -1

END CHOOSE

RETURN li_Return
end function

public function long of_getdefaultdivisionscache (ref n_ds ads_cache);//
//returns the cache of default divisions for  all the app users.
Long	ll_toMax
Long	lla_ids[]
IF not isValid( ids_defaultDivsCache ) THEN
	ids_defaultDivsCache = create n_ds
	ids_defaultDivsCache.dataObject = "d_employeedivisiondefaults"
	ids_defaultDivsCache.settransobject( SQLCA )
	
	ll_toMax = ids_defaultDivsCache.retrieve(  )
	commit;
ELSE
	ll_tomax = ids_defaultdivscache.rowCount()
END IF

ids_defaultdivscache.setFilter( "" )
ids_defaultdivscache.filter()
ads_cache = ids_defaultDivsCache

RETURN ll_toMax

end function

public function integer of_getemployeedivisiondefault (string as_templateshiptype, ref n_cst_beo_shiptype anv_shiptypebeo);Long		li_Return = 1
Long		ll_DivisionId
Long		ll_EmId
Long		ll_RowCount
Long		ll_FindRow
String	ls_FindString


n_ds	lds_DivDefaults

n_cst_beo_ShipType lnv_Shiptypebeo

ll_EmId = gnv_App.of_GetNumericUserId()

This.of_GetDefaultDivisionsCache(lds_DivDefaults)

lds_DivDefaults.SetFilter("em_id = " + String(ll_EmId))
lds_DivDefaults.Filter()

ll_RowCount = lds_DivDefaults.RowCount()
IF ll_RowCount > 0 THEN
	
	ls_FindString = "shiptype = '" + as_templateshiptype + "'"
	ll_FindRow = lds_DivDefaults.Find(ls_FindString, 1, ll_RowCount)
	IF ll_FindRow > 0 THEN
		ll_DivisionId = lds_DivDefaults.GetItemNumber(ll_FindRow, "division")
		
		lnv_ShipTypeBeo = Create n_cst_beo_ShipType
		lnv_ShipTypeBeo.of_SetUseCache(True)
		lnv_ShipTypeBeo.of_Setsourceid( ll_DivisionId )
		
		anv_shiptypebeo = lnv_ShipTypeBeo
	ELSE
		li_Return = -1 //no user shiptype found for this category
	END IF
ELSE
	li_Return = -1 //no shiptype set up for this user
END IF


Return li_Return
end function

public function integer of_savedivisiondefaults ();Int li_Return = 1
//added by Dan to save the default cache
IF isValid( ids_defaultdivscache ) THEN
	IF ids_defaultdivscache.update() = 1 THEN
		commit;
		li_return = 1
	ELSE
		li_return = -1
		rollback;
	END IF
END IF

RETURN li_return
end function

public function integer of_divsmodifiedcount ();int li_Return
IF isValid( ids_defaultDivsCache ) THEN
	li_Return = ids_defaultdivscache.modifiedCount()
END IF
RETURN li_return
end function

on n_cst_ship_type.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ship_type.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;si_instantiatedcount++
end event

event destructor;si_instantiatedCount --

//if there aren't anymore instances of this alive, destroy the cache
IF si_instantiatedCount	 = 0 THEN
	IF isValid( ids_defaultdivscache ) THEN
		destroy ids_defaultdivscache
	END IF
END IF
end event

