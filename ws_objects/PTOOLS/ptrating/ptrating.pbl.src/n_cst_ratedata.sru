$PBExportHeader$n_cst_ratedata.sru
forward
global type n_cst_ratedata from nonvisualobject
end type
end forward

global type n_cst_ratedata from nonvisualobject
end type
global n_cst_ratedata n_cst_ratedata

type variables
private:
decimal	ic_totalcount, &
	ic_totalquantity, &
	ic_totalmiles, &
	ic_totalweight, &
	ic_totalcharge,&
	ic_rate, &
	ic_Freightpayablepercentage, &
	ic_Accesspayablepercentage
long	il_rateid,&
	il_billtoid,&
	il_originid,&
	il_destinationid,&
	il_shipid, &
	il_Amounttype
integer	ii_category
date	id_lastused
string	is_itemtype, &
	is_itemeventtype, &
	is_originzone, &
	is_originzip, &
	is_originstate, &
	is_originlocator, &
	is_destinationzone, &
	is_destinationzip, &
	is_destinationstate, &
	is_destinationlocator, &
	is_ratetype, &
	is_ratetypedescription, &
	is_ratetablename, &
	is_description, &
	is_codename, &
	isa_CodeSubstitution[], &
	isa_CodeFallback[], &
	is_CodenameSearchOrder, &
	isa_CodenameSearchOrder[]
boolean	ib_useminimum, &
	ib_usemaximum, &
	ib_useshipmiles, &
	ib_replacenonetype, &
	ib_reversezonesearch, &
	ib_ModifyLastUsedDate, &
	ib_showpicklist=TRUE, &
	ib_UsedSubstitution, &
	ib_UsedFallback, &
	ib_UsedBilltoOverride, &
	ib_codenamedefault, &	
	ib_SearchOrderSet, &
	ib_CombinedRate, &
	ib_LookAtShipmentCode, &
	ib_MinMaxApplied
	


end variables

forward prototypes
public subroutine of_setratetype (string as_ratetype)
public subroutine of_setoriginid (long al_companyid)
public subroutine of_setdestinationid (long al_companyid)
public subroutine of_setbilltoid (long al_companyid)
public function decimal of_gettotalcount ()
public subroutine of_settotalcount (decimal ac_count)
public subroutine of_settotalcharge (decimal ic_charge)
public function decimal of_gettotalcharge ()
public subroutine of_setshipid (long al_shipid)
public function long of_getoriginid ()
public function long of_getdestinationid ()
public function long of_getbilltoid ()
public function long of_getshipid ()
public subroutine of_setoriginzone (string as_zone)
public subroutine of_setdestinationzone (string as_zone)
public function string of_getoriginzone ()
public function string of_getdestinationzone ()
public function string of_getratetype ()
public function decimal of_getrate ()
public subroutine of_setrate (decimal ac_rate)
public subroutine of_setuseminimum (boolean ab_set)
public subroutine of_setusemaximum (boolean ab_set)
public function boolean of_useminimum ()
public function boolean of_usemaximum ()
public subroutine of_settotalquantity (decimal ac_count)
public subroutine of_settotalmiles (decimal ac_count)
public subroutine of_settotalweight (decimal ac_count)
public function decimal of_gettotalweight ()
public function decimal of_gettotalquantity ()
public function decimal of_gettotalmiles ()
public subroutine of_setratetypedescription (string as_description)
public function string of_getratetypedescription ()
public subroutine of_setreplacenonetype (boolean ab_set)
public function boolean of_replacenonetype ()
public subroutine of_setoriginzip (string as_zip)
public subroutine of_setdestinationzip (string as_zip)
public subroutine of_setoriginstate (string as_state)
public subroutine of_setdestinationstate (string as_state)
public function string of_getoriginzip ()
public function string of_getoriginstate ()
public function string of_getdestinationzip ()
public function string of_getdestinationstate ()
public subroutine of_setratetablename (string as_name)
public function string of_getratetablename ()
public function integer of_getcategory ()
public subroutine of_setcategory (integer ai_value)
public function string of_getdescription ()
public subroutine of_setdescription (string as_value)
public function string of_getcodename ()
public function date of_getlastuseddate ()
public subroutine of_setlastuseddate (date ad_lastused)
public subroutine of_setcodename (string as_value)
public subroutine of_setreversezonesearch (boolean ab_set)
public function boolean of_usereversezonesearch ()
public function string of_getcodenamesearchorder ()
public function long of_getcodenamesearchorder (ref string asa_value[])
public subroutine of_setcodenamesearchorder (string as_value)
public subroutine of_setcodenamesearchorder (string asa_value[])
public subroutine of_setshowpicklist (boolean ab_set)
public function boolean of_showpicklist ()
public subroutine of_setusedsubstitution (boolean ab_set)
public subroutine of_setusedfallback (boolean ab_set)
public function boolean of_usedsubstitution ()
public function boolean of_usedfallback ()
public function string of_getoriginlocator ()
public function string of_getdestinationlocator ()
public subroutine of_setoriginlocator (string as_value)
public subroutine of_setdestinationlocator (string as_value)
public function decimal of_calculatemiles (string as_origin, string as_destination)
public function string of_getitemtype ()
public subroutine of_setitemtype (string as_value)
public subroutine of_setcodenamedefault (boolean ab_value)
public function boolean of_iscodenamedefault ()
public subroutine of_setamounttype (long al_value)
public function long of_getamounttype ()
public subroutine of_setitemeventtype (string as_value)
public function string of_getitemeventtype ()
public function decimal of_gettotalmiles (boolean ab_checkshipment)
public subroutine of_setuseshipmiles (boolean ab_set)
public function boolean of_useshipmiles ()
public subroutine of_setusedbilltooverride (boolean ab_set)
public function boolean of_usedbilltooverride ()
public subroutine of_setpayablepercentage (string as_value)
public function decimal of_getfreightpayablepercentage ()
public function decimal of_getaccesspayablepercentage ()
public function long of_getrateid ()
public subroutine of_setrateid (long al_value)
public function decimal of_getrate (boolean ab_setlastdateused)
public function boolean of_issearchorderset ()
public function boolean of_getfallback ()
public subroutine of_setcombinedrate (boolean ab_value)
public function boolean of_iscombinedrate ()
public function boolean of_lookatshipmentcode ()
public function boolean of_getminmaxapplied ()
public function integer of_setminmaxapplied (boolean ab_value)
end prototypes

public subroutine of_setratetype (string as_ratetype);is_ratetype = as_ratetype
end subroutine

public subroutine of_setoriginid (long al_companyid);il_originid = al_companyid
end subroutine

public subroutine of_setdestinationid (long al_companyid);il_destinationid = al_companyid
end subroutine

public subroutine of_setbilltoid (long al_companyid);il_billtoid = al_companyid
end subroutine

public function decimal of_gettotalcount ();return ic_totalcount
end function

public subroutine of_settotalcount (decimal ac_count);ic_totalcount = ac_count
end subroutine

public subroutine of_settotalcharge (decimal ic_charge);ic_totalcharge = ic_charge
end subroutine

public function decimal of_gettotalcharge ();return ic_totalcharge
end function

public subroutine of_setshipid (long al_shipid);il_shipid = al_shipid
end subroutine

public function long of_getoriginid ();return il_originid
end function

public function long of_getdestinationid ();return il_destinationid
end function

public function long of_getbilltoid ();return il_billtoid
end function

public function long of_getshipid ();return il_shipid
end function

public subroutine of_setoriginzone (string as_zone);is_originzone = as_zone
end subroutine

public subroutine of_setdestinationzone (string as_zone);is_destinationzone = as_zone
end subroutine

public function string of_getoriginzone ();return is_originzone
end function

public function string of_getdestinationzone ();return is_destinationzone
end function

public function string of_getratetype ();return is_ratetype
end function

public function decimal of_getrate ();//call the overload and set the last used date

decimal	lc_rate

lc_rate = this.of_getrate(true)

return lc_rate
end function

public subroutine of_setrate (decimal ac_rate);ic_rate = ac_rate
end subroutine

public subroutine of_setuseminimum (boolean ab_set);ib_useminimum = ab_set
end subroutine

public subroutine of_setusemaximum (boolean ab_set);ib_usemaximum = ab_set
end subroutine

public function boolean of_useminimum ();return ib_useminimum
end function

public function boolean of_usemaximum ();return ib_usemaximum
end function

public subroutine of_settotalquantity (decimal ac_count);ic_totalquantity = ac_count
end subroutine

public subroutine of_settotalmiles (decimal ac_count);ic_totalmiles = ac_count
end subroutine

public subroutine of_settotalweight (decimal ac_count);ic_totalweight = ac_count
end subroutine

public function decimal of_gettotalweight ();return ic_totalweight
end function

public function decimal of_gettotalquantity ();return ic_totalquantity
end function

public function decimal of_gettotalmiles ();decimal	lc_TotalMiles

string	ls_OriginLocator, &
			ls_DestinationLocator
			
lc_TotalMiles = ic_TotalMiles
this.of_setuseshipmiles(FALSE)

if lc_TotalMiles = 0 or isnull(lc_TotalMiles) then
	//get miles from ship origin to destination
	ls_OriginLocator = this.Of_GetOriginLocator()
	if len(trim(ls_OriginLocator)) > 0 then
		//we have origin
	else
		//try zip
		ls_OriginLocator = this.Of_GetOriginzip()
	end if
	ls_DestinationLocator = this.of_GetDestinationLocator()
	if len(trim(ls_DestinationLocator)) > 0 then
		//we have destination
	else
		ls_DestinationLocator = this.Of_GetDestinationzip()
	end if
	if len(trim(ls_OriginLocator)) = 0 or isnull(ls_OriginLocator) or &
		len(trim(ls_DestinationLocator)) = 0 or isnull(ls_DestinationLocator) then
		//no miles
	else
		lc_totalmiles = this.of_CalculateMiles(ls_OriginLocator, ls_DestinationLocator)
		if lc_totalmiles > 0 then
			this.of_setuseshipmiles(TRUE)
			this.of_settotalmiles(lc_totalmiles)
		end if
	end if
end if

return lc_totalmiles
end function

public subroutine of_setratetypedescription (string as_description);string	ls_description

choose case as_description
	case	appeon_constant.cs_RateUnit_Code_Flat	
		ls_description = appeon_constant.cs_RateUnit_Flat
	case appeon_constant.cs_RateUnit_Code_Pound
		ls_description = appeon_constant.cs_RateUnit_Pound
	case appeon_constant.cs_RateUnit_Code_100Pound
		ls_description = appeon_constant.cs_RateUnit_100Pound
	case appeon_constant.cs_RateUnit_Code_Ton
		ls_description = appeon_constant.cs_RateUnit_Ton
	case appeon_constant.cs_RateUnit_Code_Piece
		ls_description = appeon_constant.cs_RateUnit_Piece
	case appeon_constant.cs_RateUnit_Code_PerMile
		ls_description = appeon_constant.cs_RateUnit_PerMile
	case appeon_constant.cs_RateUnit_Code_PerUnit
		ls_description = appeon_constant.cs_RateUnit_PerUnit
	case appeon_constant.cs_RateUnit_Code_Gallon
		ls_description = appeon_constant.cs_RateUnit_Gallon
	case appeon_constant.cs_RateUnit_Code_Class
		ls_description = appeon_constant.cs_RateUnit_Class
	case appeon_constant.cs_RateUnit_Code_Minimum
		ls_description = appeon_constant.cs_RateUnit_Minimum
	case appeon_constant.cs_RateUnit_Code_Maximum
		ls_description = appeon_constant.cs_RateUnit_Maximum
	case appeon_constant.cs_RateUnit_Code_None
		ls_description = appeon_constant.cs_RateUnit_None
end choose

is_ratetypedescription = ls_description
end subroutine

public function string of_getratetypedescription ();return is_ratetypedescription
end function

public subroutine of_setreplacenonetype (boolean ab_set);ib_replacenonetype = ab_set
end subroutine

public function boolean of_replacenonetype ();return ib_replacenonetype
end function

public subroutine of_setoriginzip (string as_zip);is_originzip = as_zip
end subroutine

public subroutine of_setdestinationzip (string as_zip);is_destinationzip = as_zip
end subroutine

public subroutine of_setoriginstate (string as_state);is_originstate = as_state
end subroutine

public subroutine of_setdestinationstate (string as_state);is_destinationstate = as_state
end subroutine

public function string of_getoriginzip ();return is_originzip
end function

public function string of_getoriginstate ();return is_originstate
end function

public function string of_getdestinationzip ();return is_destinationzip
end function

public function string of_getdestinationstate ();return is_destinationstate
end function

public subroutine of_setratetablename (string as_name);is_ratetablename = as_name
end subroutine

public function string of_getratetablename ();return is_ratetablename
end function

public function integer of_getcategory ();return ii_category
end function

public subroutine of_setcategory (integer ai_value);ii_category = ai_value
end subroutine

public function string of_getdescription ();return is_description
end function

public subroutine of_setdescription (string as_value);is_description = as_value
end subroutine

public function string of_getcodename ();long		ll_index, &
			ll_Arraycount, &
			ll_subcount, &
			ll_search, &
			ll_ndx2
			
string	ls_value, &
			lsa_sublist[], &
			lsa_search[], &
			ls_search

n_cst_string	lnv_String

ls_Value = is_codename

if len(trim(ls_Value)) > 0 then
	//any substitutions
	ll_Arraycount = upperbound(isa_CodeSubstitution)
	for ll_index = 1 to ll_Arraycount
		//substitution list ( code, substitution )
		ll_subcount = lnv_string.of_ParseToArray(isa_CodeSubstitution[ll_index], ',', lsa_sublist )
		if ll_subcount > 0 then
			if ls_Value = lsa_sublist[1] then
				for ll_ndx2 = 2 to ll_subcount
					ll_search ++
					lsa_search[ll_search] = lsa_SubList[ll_ndx2]
				next
				this.of_setcodenamesearchorder(lsa_search)
				lnv_string.of_arraytostring(lsa_search, ',', ls_search)
				this.of_setcodenamesearchorder(ls_search)
				ib_SearchOrderSet = true
				this.of_SetCodename(ls_Value)
				this.of_SetUsedsubstitution(true)
				EXIT
			end if
		end if
	next		
end if

return ls_Value
end function

public function date of_getlastuseddate ();return id_lastused
end function

public subroutine of_setlastuseddate (date ad_lastused);id_lastused = ad_lastused
end subroutine

public subroutine of_setcodename (string as_value);

/*
	if the argument is a list of substitutions and fallbacks 
	they will be set without setting the code name
	
	pattern for substitution/fallback
	
	:SHIP(ABC,XYZ=DEF;DEF,EFG):JKL(JKL,LAX):%F(75)  
	
	SHIP indicates to look to the shipment for the codename. The () contains
	the substition (ABC,XYZ=DEF substitute DEF for ABC and XYZ) and the
	fallback (DEF,EFG if DEF is not found then use EFG). The second ':' is to
	be used if the first part fails.

	%F indicates a percentage of the freight revenue. The () contains the
	percent.  If there is no pay amount specified on the item and no rate code
	found then this is the percentage of the charge amount.
	
	If there is no SHIP and only the second part then don't look at the shipment
	for a codename.
		
	
	Modification History 
	3-18-07  BKW   Changed so that Fixed Table format templates would force the use of the fixed table
						for freight lines only, not accessorials
	
*/


long		ll_index, &
			ll_index2, &
			ll_pos, &
			ll_Arraycount, &
			ll_codecount, &
			ll_subindex, &
			ll_subcount
			
string	ls_value, &
			ls_pattern, &
			ls_codename, &
			ls_codelist, &
			ls_fallback, &
			lsa_fallback[], &
			lsa_list[], &
			lsa2_list[], &
			ls_Substitution, &
			lsa_subfalllist[], &
			lsa_sublist[],&
			lsa_codename[]

n_cst_string	lnv_String

ls_Value = as_Value

if len(trim(ls_Value)) > 0 then
	if pos(ls_value, ':') > 0 then
		ll_codecount = lnv_string.of_ParseToArray(ls_value, ':', lsa_list )
		for ll_index = 1 to ll_codecount
			ls_Pattern= lsa_list[ll_index]
			ls_codename = upper(left(ls_pattern, pos(ls_pattern,'(', 1) - 1))
			if trim(ls_codename) = 'SHIP' then
				//code will come from shipment
				ib_LookAtShipmentCode = true
			elseif left(ls_codename,1) = '%' then
				//set % for calculation
				this.of_SetPayablePercentage(ls_Pattern)
				continue
			//Condition added 3-18-07 BKW.  If we are specifying tables instead of using :SHIP in pyables, this should apply
			//to Freight payables only, not to Accessorials.  Without this condition, accessorials were paying based on 
			//the tables specified for freight.
			elseif This.of_GetItemType ( ) = n_cst_Constants.cs_ItemType_Accessorial AND &
				This.of_GetCategory ( ) = n_cst_Constants.ci_Category_Payables THEN
				//To make this condition work, I had to add an of_SetCategory call to n_cst_bso_Payable.of_SetRateData
				//It was not being set and was coming in here with of_GetCategory returning 0, because it hadn't been set.
				//I'm not sure if this only comes in here for payables or if this might get tangled up with rating without this change.
				//However, I'm also not sure that Category = 0 may not also happen during rating, for the same problem exposure, 
				//so I didn't want to take Category = payables or Category = 0.
				ls_CodeName = 'SHIP'
				ib_LookAtShipmentCode = true
			else
				is_codename = trim(ls_codename)	
				if len(trim(ls_codename)) > 0 then
					if of_LookAtShipmentCode() then
						//add to fallback list for ship code
						isa_codefallback[upperbound(isa_codefallback) + 1] = "SHIP," + ls_codename
					else
						//make it search order
						lsa_codename[1] = ls_codename
						//nwl 8/24/04
						ls_codelist = mid(ls_pattern, pos(ls_pattern,'(', 1) + 1, (pos(ls_pattern,')', 1) - 1) - pos(ls_pattern,'(', 1))
						ll_subcount = lnv_string.of_ParseToArray(ls_codelist, ',', lsa2_list )
						//build comma separated entry - code,substitution
						for ll_subindex = 1 to  ll_Subcount
							ls_codename = ls_codename + ',' + lsa2_list[ll_subindex] 
							lsa_codename[ll_subindex + 1] = lsa2_list[ll_subindex]
						next

						this.of_setcodenamesearchorder(lsa_codename)
						this.of_setcodenamesearchorder(ls_codename)
						ib_SearchOrderSet = true
					END IF
				end if
			end if
			//get everything inside ()
			ls_codelist = mid(ls_pattern, pos(ls_pattern,'(', 1) + 1, (pos(ls_pattern,')', 1) - 1) - pos(ls_pattern,'(', 1))
			
			//substitution/fallback list
			ll_Arraycount = lnv_string.of_ParseToArray(ls_codelist, ';', lsa_subfalllist )
			for ll_index2 = 1 to ll_Arraycount
				ll_pos = pos(lsa_subfalllist[ll_index2],'=')
				if ll_pos > 0 then
					//substitution list ( comma separated list = substitution )
					ll_subcount = lnv_string.of_ParseToArray(lsa_subfalllist[ll_index2], '=', lsa_sublist )
					//1st is sublist, 2nd is substitution
					if ll_subcount > 0 then
						ls_Substitution = lsa_sublist[2]
						ll_subcount = lnv_string.of_ParseToArray(lsa_sublist[1], ',', lsa2_list )
						//build comma separated entry - code,substitution
						for ll_subindex = 1 to  ll_Subcount
							isa_CodeSubstitution[upperbound(isa_CodeSubstitution) + 1] = lsa2_list[ll_subindex] + ',' + ls_substitution 
						next
					end if
				else
					if trim(ls_codename) = 'SHIP' then
						//shouldn't be a comma seperated list for 'SHIP'
					else
						//add list to search order
						ls_fallback = ls_codename + ',' + lsa_subfalllist[ll_index2]
						lnv_string.of_ParseToArray(ls_fallback, ',', lsa_fallback )
						this.of_setcodenamesearchorder(lsa_fallback)
						this.of_setcodenamesearchorder(ls_fallback)
						ib_SearchOrderSet = true
					end if
				end if
			next	
		next
	else
		is_codename = ls_value
	end if	
end if


end subroutine

public subroutine of_setreversezonesearch (boolean ab_set);ib_reversezonesearch = ab_set
end subroutine

public function boolean of_usereversezonesearch ();return ib_reversezonesearch
end function

public function string of_getcodenamesearchorder ();return is_codenamesearchorder
end function

public function long of_getcodenamesearchorder (ref string asa_value[]);asa_value = isa_codenamesearchorder
return upperbound(asa_value)
end function

public subroutine of_setcodenamesearchorder (string as_value);is_codenamesearchorder = as_value
end subroutine

public subroutine of_setcodenamesearchorder (string asa_value[]);isa_codenamesearchorder = asa_value
end subroutine

public subroutine of_setshowpicklist (boolean ab_set);//the defualt is true
ib_showpicklist = ab_set
end subroutine

public function boolean of_showpicklist ();/*
	If the n_cst_bso_rating can't find the appropriate rate table
	then open a window to provide the user with a pick list.  
*/
return ib_showpicklist
end function

public subroutine of_setusedsubstitution (boolean ab_set);ib_usedsubstitution = ab_set
end subroutine

public subroutine of_setusedfallback (boolean ab_set);ib_usedfallback = ab_set
end subroutine

public function boolean of_usedsubstitution ();return ib_usedsubstitution
end function

public function boolean of_usedfallback ();return ib_usedfallback
end function

public function string of_getoriginlocator ();return is_originlocator
end function

public function string of_getdestinationlocator ();return is_destinationlocator
end function

public subroutine of_setoriginlocator (string as_value);is_originlocator = as_value
end subroutine

public subroutine of_setdestinationlocator (string as_value);is_destinationlocator = as_value
end subroutine

public function decimal of_calculatemiles (string as_origin, string as_destination);integer		li_return = 1
long			ll_Tripid, &
				ll_TotalMinutes
decimal		lc_miles

n_cst_trip				lnv_trip
n_cst_routing			lnv_routing
n_cst_trip_attribs	lds_data
n_cst_LicenseManager	lnv_LicenseManager

if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or lnv_LicenseManager.of_haspcmilerlicense()) then
	
	lnv_trip = create n_cst_trip
	if lnv_trip.of_connect(lnv_routing) then
		if lnv_routing.of_isvalid() then
			lds_data = create n_cst_trip_attribs
			li_return = 1
		else
			li_return = -1 
		end if
	else
		li_return = -1
	end if

else
	li_return = -1 
	//no license
end if

if li_return = 1 then
	lnv_trip.of_addstop(as_origin)
	lnv_trip.of_addstop(as_destination)
	ll_tripid = lnv_trip.of_createtrip()
	
	//31 is a bitwise value for route type (alphaorder, open borders, hub mode, changedest).
	//it is the defualt used in the pcmiler window.
	//need to investigate value
	
	lnv_trip.of_calculatetrip(ll_tripid, 31, 0, 0, lc_miles, ll_totalminutes)
	
	destroy lnv_trip
	destroy lds_data
	
end if

return lc_miles
end function

public function string of_getitemtype ();return is_itemtype
end function

public subroutine of_setitemtype (string as_value);is_itemtype = as_value
end subroutine

public subroutine of_setcodenamedefault (boolean ab_value);ib_codenamedefault = ab_value
end subroutine

public function boolean of_iscodenamedefault ();//	Is the codename that was used for the rate information one
//	of the codenames on the company table or system setting

return ib_codenamedefault
end function

public subroutine of_setamounttype (long al_value);il_Amounttype = al_value
end subroutine

public function long of_getamounttype ();return il_Amounttype
end function

public subroutine of_setitemeventtype (string as_value);is_itemeventtype = as_value
end subroutine

public function string of_getitemeventtype ();return is_itemeventtype
end function

public function decimal of_gettotalmiles (boolean ab_checkshipment);decimal	lc_totalmiles

if ab_checkshipment then
	lc_totalMiles = this.of_GetTotalMiles()
else
	lc_totalmiles = ic_totalmiles
end if

return lc_totalmiles
end function

public subroutine of_setuseshipmiles (boolean ab_set);ib_useshipmiles = ab_set
end subroutine

public function boolean of_useshipmiles ();return ib_useshipmiles
end function

public subroutine of_setusedbilltooverride (boolean ab_set);ib_UsedBilltoOverride = ab_set
end subroutine

public function boolean of_usedbilltooverride ();return ib_UsedBilltoOverride
end function

public subroutine of_setpayablepercentage (string as_value);string	ls_percent, &
			ls_type 

decimal	lc_percent

ls_percent = mid(as_value, pos(as_value,'(', 1) + 1, (pos(as_value,')', 1) - 1) - pos(as_value,'(', 1))
ls_type = upper(left(as_value, pos(as_value,'(', 1) - 1))

if isnumber(ls_percent) then
	lc_percent = dec(ls_percent)
else
	lc_percent = 0
end if

choose case right(ls_type, len(ls_type) - 1)
	case 'F'
		ic_Freightpayablepercentage=lc_percent
	case 'A'
		ic_Accesspayablepercentage=lc_percent
end choose
end subroutine

public function decimal of_getfreightpayablepercentage ();return ic_Freightpayablepercentage
end function

public function decimal of_getaccesspayablepercentage ();return ic_Accesspayablepercentage
end function

public function long of_getrateid ();return il_rateid
end function

public subroutine of_setrateid (long al_value);il_rateid = al_value
end subroutine

public function decimal of_getrate (boolean ab_setlastdateused);date 	ld_lastused
long	ll_rateid
if ab_setlastdateused then
	ld_lastused = this.of_GetLastUsedDate()
	if isdate(string(ld_lastused)) then
		ll_rateid = this.of_GetRateId()
		if ll_rateid > 0 then
			//update lastuseddate
		  UPDATE "rate"  
			  SET "lastuseddate" = :ld_lastused 
			WHERE "rate"."id" = :ll_rateid   ;
			
			IF SQLCA.SQLCode = 0 THEN
				commit;
			ELSE
				rollback;
			END IF

		end if
	end if
end if

return ic_rate
end function

public function boolean of_issearchorderset ();return ib_SearchOrderSet
end function

public function boolean of_getfallback ();//will set the codename on itself to the fallback code if there is one and 
//return a boolean to indicate if it did or not

long		ll_index, &
			ll_Arraycount, &
			ll_Fallbackcount
			
string	ls_value, &
			lsa_Fallbacklist[]

boolean	lb_fallback

n_cst_string	lnv_String

ls_Value = is_codename

if len(trim(ls_Value)) > 0 then
	//any Fallbacks
	ll_Arraycount = upperbound(isa_codefallback)
	for ll_index = 1 to ll_Arraycount
		//Fallbacks ( code, Fallback )
		ll_Fallbackcount = lnv_string.of_ParseToArray(isa_codefallback[ll_index], ',', lsa_Fallbacklist )
		if ll_Fallbackcount > 0 then
			if ls_Value = lsa_Fallbacklist[1] OR lsa_FallBackList[1] = 'SHIP' then
				ls_value = lsa_FallbackList[2]
				this.of_SetCodename(ls_Value)
				lb_fallback = true
				EXIT
			end if
		end if
	next		
end if

return lb_fallback
end function

public subroutine of_setcombinedrate (boolean ab_value);//used for auto rate combined items
ib_CombinedRate = ab_value
end subroutine

public function boolean of_iscombinedrate ();//used for auto rate combined items
return ib_CombinedRate
end function

public function boolean of_lookatshipmentcode ();return ib_LookAtShipmentCode
end function

public function boolean of_getminmaxapplied ();Return ib_minmaxapplied
end function

public function integer of_setminmaxapplied (boolean ab_value);ib_minmaxapplied = ab_value
RETURN 1
end function

on n_cst_ratedata.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ratedata.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

