$PBExportHeader$n_cst_dlk_equipmentcache.sru
$PBExportComments$NOTE: Sets IsClassDlk = TRUE in Constructor //@(*)[81116332|890:bdm]<nosync>
forward
global type n_cst_dlk_equipmentcache from n_cst_dlk
end type
end forward

global type n_cst_dlk_equipmentcache from n_cst_dlk
end type
global n_cst_dlk_equipmentcache n_cst_dlk_equipmentcache

forward prototypes
protected function Long RetrieveDataStore (Datastore ads_datastore, Any aa_args[])
public function integer modifywhereclause ()
end prototypes

protected function Long RetrieveDataStore (Datastore ads_datastore, Any aa_args[]);//@(text)(recreate=yes)<retrieve>
return super::RetrieveDataStore(ads_datastore, aa_args)
//@(text)--

end function

public function integer modifywhereclause ();//This first part is a copy of what Riverton generates
      
string ls_syntax
string ls_append
integer li_loop,li_end
any la_quotedargs[]

ls_syntax = ids_view.GetSqlSelect()

li_end = UpperBound(iany_args)
for li_loop = 1 to li_end
   if not isNull(iany_args[li_loop]) then
      la_quotedargs[li_loop] = iany_args[li_loop]
   end if
next

this.SetQuotes(la_quotedargs[])

//This is where Riverton's generated case handling goes.  I've deleted that here.

//@(text)--


//Custom Retrieval Extensions

Boolean	lb_Custom
n_cst_Sql	lnv_Sql

CHOOSE CASE is_dlk_relation

CASE "Refresh"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"equipment~".~"timestamp~" > " + String(la_quotedargs[1]) +&
		" OR ~"outside_equip~".~"timestamp~" > " + String(la_quotedargs[1])

CASE "Ids"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"equipment~".~"eq_id~"" + lnv_Sql.of_MakeInClause ( la_QuotedArgs[1] )


CASE "IdArray"
	lb_Custom = TRUE
	ls_Append = " WHERE ~"equipment~".~"eq_id~"" + lnv_Sql.of_MakeInClause ( la_QuotedArgs[1] )

END CHOOSE

IF lb_Custom = TRUE AND &
	ls_Append <> "" THEN

	//If there is an existing WHERE clause, strip it off
	Long	ll_WherePos
	ll_WherePos = Pos ( ls_Syntax, "WHERE" )

	IF ll_WherePos > 0 THEN
		ls_Syntax = Left ( ls_Syntax, ll_WherePos - 1 )
	END IF

	//Append the new where clause
   ls_syntax = ls_syntax + ls_append
   if ids_view.SetSqlSelect(ls_syntax) < 0 then
      this.PushException("modifywhereclause")
      return -1
   end if

END IF

//@(text)(recreate=yes)<Return status>
return 1
//@(text)--

end function

on n_cst_dlk_equipmentcache.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dlk_equipmentcache.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetDataSource("d_equipmentcache")
inv_bcm.AddClass("n_cst_beo_equipment", TRUE)
//@(data)--

//@(data)(recreate=yes)<Column Map>
this.MapAttribute("equipment_id", "n_cst_beo_equipment", "id")
this.MapAttribute("equipment_type", "n_cst_beo_equipment", "type")
this.MapAttribute("equipment_number", "n_cst_beo_equipment", "number")
this.MapAttribute("equipment_leased", "n_cst_beo_equipment", "leased")
this.MapAttribute("equipment_status", "n_cst_beo_equipment", "status")
this.MapAttribute("equipment_length", "n_cst_beo_equipment", "length")
this.MapAttribute("equipment_width", "n_cst_beo_equipment", "width")
this.MapAttribute("equipment_volume", "n_cst_beo_equipment", "volume")
this.MapAttribute("equipment_axles", "n_cst_beo_equipment", "axles")
this.MapAttribute("equipment_air", "n_cst_beo_equipment", "air")
this.MapAttribute("equipment_spec1", "n_cst_beo_equipment", "spec1")
this.MapAttribute("equipment_spec2", "n_cst_beo_equipment", "spec2")
this.MapAttribute("equipment_spec3", "n_cst_beo_equipment", "spec3")
this.MapAttribute("equipment_spec4", "n_cst_beo_equipment", "spec4")
this.MapAttribute("equipment_spec5", "n_cst_beo_equipment", "spec5")
this.MapAttribute("equipment_user1", "n_cst_beo_equipment", "user1")
this.MapAttribute("equipment_user2", "n_cst_beo_equipment", "user2")
this.MapAttribute("equipment_user3", "n_cst_beo_equipment", "user3")
this.MapAttribute("equipment_user4", "n_cst_beo_equipment", "user4")
this.MapAttribute("equipment_user5", "n_cst_beo_equipment", "user5")
this.MapAttribute("equipment_notes", "n_cst_beo_equipment", "notes")
this.MapAttribute("equipment_currentevent", "n_cst_beo_equipment", "currentevent")
this.MapAttribute("equipment_nextevent", "n_cst_beo_equipment", "nextevent")
this.MapAttribute("equipmentlease_leasedfrom", "n_cst_beo_equipmentlease", "leasedfrom")
this.MapAttribute("equipmentlease_onbehalfof", "n_cst_beo_equipmentlease", "onbehalfof")
this.MapAttribute("equipmentlease_bookingnumber", "n_cst_beo_equipmentlease", "bookingnumber")
this.MapAttribute("equipmentlease_timeout", "n_cst_beo_equipmentlease", "timeout")
this.MapAttribute("equipmentlease_timein", "n_cst_beo_equipmentlease", "timein")
this.MapAttribute("equipmentlease_originationevent", "n_cst_beo_equipmentlease", "originationevent")
this.MapAttribute("equipmentlease_terminationevent", "n_cst_beo_equipmentlease", "terminationevent")
this.MapAttribute("equipmentlease_user1", "n_cst_beo_equipmentlease", "user1")
this.MapAttribute("equipmentlease_user2", "n_cst_beo_equipmentlease", "user2")
this.MapAttribute("equipmentlease_notes", "n_cst_beo_equipmentlease", "notes")
this.MapAttribute("equipmentlease_oe_id", "n_cst_beo_equipmentlease", "oe_id")
this.MapAttribute("equipmentlease_fkequipmentleasetype", "n_cst_beo_equipmentlease", "fkequipmentleasetype")
//@(data)--

//@(data)(recreate=yes)<map>
this.RegisterUpdateTable("equipment")
this.MapDBColumn("equipment_id", "equipment", "eq_id", 1)
this.MapDBColumn("equipment_type", "equipment", "eq_type", 0)
this.MapDBColumn("equipment_number", "equipment", "eq_ref", 0)
this.MapDBColumn("equipment_leased", "equipment", "eq_outside", 0)
this.MapDBColumn("equipment_status", "equipment", "eq_status", 0)
this.MapDBColumn("equipment_length", "equipment", "eq_length", 0)
this.MapDBColumn("equipment_width", "equipment", "eq_height", 0)
this.MapDBColumn("equipment_volume", "equipment", "eq_volume", 0)
this.MapDBColumn("equipment_axles", "equipment", "eq_axles", 0)
this.MapDBColumn("equipment_air", "equipment", "eq_air", 0)
this.MapDBColumn("equipment_spec1", "equipment", "eq_spec1", 0)
this.MapDBColumn("equipment_spec2", "equipment", "eq_spec2", 0)
this.MapDBColumn("equipment_spec3", "equipment", "eq_spec3", 0)
this.MapDBColumn("equipment_spec4", "equipment", "eq_spec4", 0)
this.MapDBColumn("equipment_spec5", "equipment", "eq_spec5", 0)
this.MapDBColumn("equipment_user1", "equipment", "User1", 0)
this.MapDBColumn("equipment_user2", "equipment", "User2", 0)
this.MapDBColumn("equipment_user3", "equipment", "User3", 0)
this.MapDBColumn("equipment_user4", "equipment", "User4", 0)
this.MapDBColumn("equipment_user5", "equipment", "User5", 0)
this.MapDBColumn("equipment_notes", "equipment", "Notes", 0)
this.MapDBColumn("equipment_currentevent", "equipment", "eq_cur_event", 0)
this.MapDBColumn("equipment_nextevent", "equipment", "eq_next_event", 0)
this.MapDBColumn("equipmentlease_leasedfrom", "outside_equip", "oe_from", 0)
this.MapDBColumn("equipmentlease_onbehalfof", "outside_equip", "oe_for", 0)
this.MapDBColumn("equipmentlease_bookingnumber", "outside_equip", "oe_booknum", 0)
this.MapDBColumn("equipmentlease_timeout", "outside_equip", "oe_out", 0)
this.MapDBColumn("equipmentlease_timein", "outside_equip", "oe_in", 0)
this.MapDBColumn("equipmentlease_originationevent", "outside_equip", "oe_orig_event", 0)
this.MapDBColumn("equipmentlease_terminationevent", "outside_equip", "oe_term_event", 0)
this.MapDBColumn("equipmentlease_user1", "outside_equip", "User1", 0)
this.MapDBColumn("equipmentlease_user2", "outside_equip", "User2", 0)
this.MapDBColumn("equipmentlease_notes", "outside_equip", "Notes", 0)
this.MapDBColumn("equipmentlease_oe_id", "outside_equip", "oe_id", 1)
this.MapDBColumn("equipmentlease_fkequipmentleasetype", "outside_equip", "fkEquipmentLeaseType", 0)
//@(data)--

//Needed to set this in order to force call to modifywhereclause for custom retrievals
SetIsClassDlk ( TRUE )
end event

event ofr_retrieve;call super::ofr_retrieve;Long		ll_RowCount, &
			ll_Row, &
			ll_Count, &
			lla_Companies[], &
			ll_Current, &
			ll_Origination, &
			ll_Termination

String	ls_Description

DWObject	ldwo_CurrentEvent_fkCompany, &
			ldwo_CurrentEvent_Site, &
			ldwo_CurrentEvent_City, &
			ldwo_CurrentEvent_State, &
			ldwo_CurrentEvent_TimeZone, &
			ldwo_CurrentEvent_PCM, &
			&
			ldwo_EquipmentLease_OriginationSite, &
			ldwo_OriginationEvent_Site, &
			ldwo_OriginationEvent_City, &
			ldwo_OriginationEvent_State, &
			ldwo_OriginationEvent_TimeZone, &
			ldwo_OriginationEvent_PCM, &
			&
			ldwo_EquipmentLease_TerminationSite, &
			ldwo_TerminationEvent_Site, &
			ldwo_TerminationEvent_City, &
			ldwo_TerminationEvent_State, &
			ldwo_TerminationEvent_TimeZone, &
			ldwo_TerminationEvent_PCM, &
			&
			ldwo_CurrentEvent_DriverId, &
			ldwo_CurrentEvent_Driver

s_co_Info	lstr_Company
n_cst_EmployeeManager	lnv_EmployeeMgr
n_cst_EquipmentManager	lnv_EquipmentMgr
n_cst_Companies			lnv_CompanyMgr
Boolean		lb_GotIt

lnv_CompanyMgr = gnv_cst_Companies
ll_RowCount = ids_View.RowCount ( )


//Get handles to all company information columns, and cache the referenced companies.

IF ll_RowCount > 0 THEN

	//If there are rows to work on, instantiate column references, and cache any
	//referenced companies.  If no rows, they won't be needed.

	ldwo_CurrentEvent_fkCompany = ids_View.Object.CurrentEvent_fkCompany
	ldwo_CurrentEvent_Site = ids_View.Object.CurrentEvent_Site
	ldwo_CurrentEvent_City = ids_View.Object.CurrentEvent_City
	ldwo_CurrentEvent_State = ids_View.Object.CurrentEvent_State
	ldwo_CurrentEvent_TimeZone = ids_View.Object.CurrentEvent_TimeZone
	ldwo_CurrentEvent_PCM = ids_View.Object.CurrentEvent_PCM

	ldwo_EquipmentLease_OriginationSite = ids_View.Object.EquipmentLease_OriginationSite
	ldwo_OriginationEvent_Site = ids_View.Object.OriginationEvent_Site
	ldwo_OriginationEvent_City = ids_View.Object.OriginationEvent_City
	ldwo_OriginationEvent_State = ids_View.Object.OriginationEvent_State
	ldwo_OriginationEvent_TimeZone = ids_View.Object.OriginationEvent_TimeZone
	ldwo_OriginationEvent_PCM = ids_View.Object.OriginationEvent_PCM

	ldwo_EquipmentLease_TerminationSite = ids_View.Object.EquipmentLease_TerminationSite
	ldwo_TerminationEvent_Site = ids_View.Object.TerminationEvent_Site
	ldwo_TerminationEvent_City = ids_View.Object.TerminationEvent_City
	ldwo_TerminationEvent_State = ids_View.Object.TerminationEvent_State
	ldwo_TerminationEvent_TimeZone = ids_View.Object.TerminationEvent_TimeZone
	ldwo_TerminationEvent_PCM = ids_View.Object.TerminationEvent_PCM

	lla_Companies = ldwo_CurrentEvent_fkCompany.Primary
	gnv_cst_Companies.of_Cache ( lla_Companies, FALSE )

	lla_Companies = ldwo_EquipmentLease_OriginationSite.Primary
	gnv_cst_Companies.of_Cache ( lla_Companies, FALSE )

	lla_Companies = ldwo_EquipmentLease_TerminationSite.Primary
	gnv_cst_Companies.of_Cache ( lla_Companies, FALSE )

	//Peform freetime and charges calculations
	lnv_EquipmentMgr.of_RefreshCalculations ( inv_Bcm )

END IF


//Loop through the rows to lookup and assign CurrentEvent site information.

FOR ll_Row = 1 TO ll_RowCount

	ll_Current = ldwo_CurrentEvent_fkCompany.Primary[ ll_Row ]

	IF NOT IsNull ( ll_Current ) THEN

		//The null check is for speed -- it would run fine without it

		IF ll_Current = lstr_Company.co_id THEN
			lb_GotIt = TRUE
		ELSEIF lnv_CompanyMgr.of_get_info(ll_Current, lstr_company, false) = 1 THEN
			lb_GotIt = TRUE
		ELSE
			lb_GotIt = FALSE
		END IF

		if lb_GotIt then
			ldwo_CurrentEvent_Site.Primary[ ll_Row ] = lstr_company.co_name
			ldwo_CurrentEvent_City.Primary[ ll_Row ] = lstr_company.co_city
			ldwo_CurrentEvent_State.Primary[ ll_Row ] = lstr_company.co_state
			ldwo_CurrentEvent_TimeZone.Primary[ ll_Row ] = lstr_company.co_tz
			ldwo_CurrentEvent_PCM.Primary[ ll_Row ] = lstr_company.co_pcm
		end if

	END IF

NEXT


//Loop through the rows to lookup and assign Origination and Termination site information.
//(Note:  These are kept together because there is a high likelihood they're the same
//for a give piece of outside equipment.)

FOR ll_Row = 1 TO ll_RowCount

	//I've separated these two from the first one so that the likelihood of getting
	//matches is better.

	ll_Origination = ldwo_EquipmentLease_OriginationSite.Primary[ ll_Row ]
	ll_Termination = ldwo_EquipmentLease_TerminationSite.Primary[ ll_Row ]

	IF NOT IsNull ( ll_Origination ) THEN

		//The null check is for speed -- it would run fine without it

		IF ll_Origination = lstr_Company.co_id THEN
			lb_GotIt = TRUE
		ELSEIF lnv_CompanyMgr.of_get_info(ll_Origination, lstr_company, false) = 1 THEN
			lb_GotIt = TRUE
		ELSE
			lb_GotIt = FALSE
		END IF

		if lb_GotIt then
			ldwo_OriginationEvent_Site.Primary[ ll_Row ] = lstr_company.co_name
			ldwo_OriginationEvent_City.Primary[ ll_Row ] = lstr_company.co_city
			ldwo_OriginationEvent_State.Primary[ ll_Row ] = lstr_company.co_state
			ldwo_OriginationEvent_TimeZone.Primary[ ll_Row ] = lstr_company.co_tz
			ldwo_OriginationEvent_PCM.Primary[ ll_Row ] = lstr_company.co_pcm
		end if

	END IF


	IF NOT IsNull ( ll_Termination ) THEN

		//The null check is for speed -- it would run fine without it

		IF ll_Termination = lstr_Company.co_id THEN
			lb_GotIt = TRUE
		ELSEIF lnv_CompanyMgr.of_get_info(ll_Termination, lstr_company, false) = 1 THEN
			lb_GotIt = TRUE
		ELSE
			lb_GotIt = FALSE
		END IF

		if lb_GotIt then
			ldwo_TerminationEvent_Site.Primary[ ll_Row ] = lstr_company.co_name
			ldwo_TerminationEvent_City.Primary[ ll_Row ] = lstr_company.co_city
			ldwo_TerminationEvent_State.Primary[ ll_Row ] = lstr_company.co_state
			ldwo_TerminationEvent_TimeZone.Primary[ ll_Row ] = lstr_company.co_tz
			ldwo_TerminationEvent_PCM.Primary[ ll_Row ] = lstr_company.co_pcm
		end if

	END IF


NEXT


//Get handles to the driver information columns

IF ll_RowCount > 0 THEN

	ldwo_CurrentEvent_DriverId = ids_View.Object.CurrentEvent_DriverId
	ldwo_CurrentEvent_Driver = ids_View.Object.CurrentEvent_Driver

END IF


//Loop through the rows to lookup and assign CurrentEvent Driver information.

FOR ll_Row = 1 TO ll_RowCount

	ll_Current = ldwo_CurrentEvent_DriverId.Primary[ ll_Row ]

	IF NOT IsNull ( ll_Current ) THEN

		//The null check is for speed -- it would run fine without it

		IF lnv_EmployeeMgr.of_DescribeEmployee ( ll_Current, ls_Description ) = 1 THEN
			ldwo_CurrentEvent_Driver.Primary[ ll_Row ] = ls_Description
		END IF

	END IF

NEXT


DESTROY ldwo_CurrentEvent_fkCompany
DESTROY ldwo_CurrentEvent_Site
DESTROY ldwo_CurrentEvent_City
DESTROY ldwo_CurrentEvent_State
DESTROY ldwo_CurrentEvent_TimeZone
DESTROY ldwo_CurrentEvent_PCM

DESTROY ldwo_EquipmentLease_OriginationSite
DESTROY ldwo_OriginationEvent_Site
DESTROY ldwo_OriginationEvent_City
DESTROY ldwo_OriginationEvent_State
DESTROY ldwo_OriginationEvent_TimeZone
DESTROY ldwo_OriginationEvent_PCM

DESTROY ldwo_EquipmentLease_TerminationSite
DESTROY ldwo_TerminationEvent_Site
DESTROY ldwo_TerminationEvent_City
DESTROY ldwo_TerminationEvent_State
DESTROY ldwo_TerminationEvent_TimeZone
DESTROY ldwo_TerminationEvent_PCM

DESTROY ldwo_CurrentEvent_DriverId
DESTROY ldwo_CurrentEvent_Driver

RETURN AncestorReturnValue
end event

