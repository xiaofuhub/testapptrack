$PBExportHeader$w_quickmatch.srw
forward
global type w_quickmatch from w_popup
end type
type cb_close from commandbutton within w_quickmatch
end type
type st_pcmnotconnected from statictext within w_quickmatch
end type
type tab_quickmatch from tab within w_quickmatch
end type
type tabpage_shipment from userobject within tab_quickmatch
end type
type cb_undoshipments from commandbutton within tabpage_shipment
end type
type cb_restrictshipment from commandbutton within tabpage_shipment
end type
type st_or2 from statictext within tabpage_shipment
end type
type st_or from statictext within tabpage_shipment
end type
type sle_stateinto from singlelineedit within tabpage_shipment
end type
type st_stateinto from statictext within tabpage_shipment
end type
type sle_cityinto from singlelineedit within tabpage_shipment
end type
type st_cityinto from statictext within tabpage_shipment
end type
type st_stateoutof from statictext within tabpage_shipment
end type
type st_cityoutof from statictext within tabpage_shipment
end type
type sle_stateoutof from singlelineedit within tabpage_shipment
end type
type st_zipinto from statictext within tabpage_shipment
end type
type sle_zipinto from singlelineedit within tabpage_shipment
end type
type st_zipoutof from statictext within tabpage_shipment
end type
type sle_zipoutof from singlelineedit within tabpage_shipment
end type
type lb_locationinto from listbox within tabpage_shipment
end type
type lb_locationoutof from listbox within tabpage_shipment
end type
type cbx_outof from checkbox within tabpage_shipment
end type
type cbx_into from checkbox within tabpage_shipment
end type
type st_miles from statictext within tabpage_shipment
end type
type sle_miles from singlelineedit within tabpage_shipment
end type
type st_within from statictext within tabpage_shipment
end type
type sle_cityoutof from singlelineedit within tabpage_shipment
end type
type tabpage_shipment from userobject within tab_quickmatch
cb_undoshipments cb_undoshipments
cb_restrictshipment cb_restrictshipment
st_or2 st_or2
st_or st_or
sle_stateinto sle_stateinto
st_stateinto st_stateinto
sle_cityinto sle_cityinto
st_cityinto st_cityinto
st_stateoutof st_stateoutof
st_cityoutof st_cityoutof
sle_stateoutof sle_stateoutof
st_zipinto st_zipinto
sle_zipinto sle_zipinto
st_zipoutof st_zipoutof
sle_zipoutof sle_zipoutof
lb_locationinto lb_locationinto
lb_locationoutof lb_locationoutof
cbx_outof cbx_outof
cbx_into cbx_into
st_miles st_miles
sle_miles sle_miles
st_within st_within
sle_cityoutof sle_cityoutof
end type
type tabpage_de from userobject within tab_quickmatch
end type
type cb_undode from commandbutton within tabpage_de
end type
type cb_restrictde from commandbutton within tabpage_de
end type
type rb_both from radiobutton within tabpage_de
end type
type rb_equipment from radiobutton within tabpage_de
end type
type rb_driver from radiobutton within tabpage_de
end type
type st_or1 from statictext within tabpage_de
end type
type sle_state from singlelineedit within tabpage_de
end type
type st_state1 from statictext within tabpage_de
end type
type sle_city from singlelineedit within tabpage_de
end type
type st_city1 from statictext within tabpage_de
end type
type st_zip1 from statictext within tabpage_de
end type
type sle_zip from singlelineedit within tabpage_de
end type
type lb_location from listbox within tabpage_de
end type
type rb_all from radiobutton within tabpage_de
end type
type rb_currentorlast from radiobutton within tabpage_de
end type
type rb_current from radiobutton within tabpage_de
end type
type st_miles1 from statictext within tabpage_de
end type
type sle_milesde from singlelineedit within tabpage_de
end type
type st_within1 from statictext within tabpage_de
end type
type st_location1 from statictext within tabpage_de
end type
type gb_driverlocation from groupbox within tabpage_de
end type
type gb_restriction from groupbox within tabpage_de
end type
type tabpage_de from userobject within tab_quickmatch
cb_undode cb_undode
cb_restrictde cb_restrictde
rb_both rb_both
rb_equipment rb_equipment
rb_driver rb_driver
st_or1 st_or1
sle_state sle_state
st_state1 st_state1
sle_city sle_city
st_city1 st_city1
st_zip1 st_zip1
sle_zip sle_zip
lb_location lb_location
rb_all rb_all
rb_currentorlast rb_currentorlast
rb_current rb_current
st_miles1 st_miles1
sle_milesde sle_milesde
st_within1 st_within1
st_location1 st_location1
gb_driverlocation gb_driverlocation
gb_restriction gb_restriction
end type
type tab_quickmatch from tab within w_quickmatch
tabpage_shipment tabpage_shipment
tabpage_de tabpage_de
end type
type cb_view from commandbutton within w_quickmatch
end type
type st_unrecognizedlocations from statictext within w_quickmatch
end type
end forward

global type w_quickmatch from w_popup
integer width = 1938
integer height = 1704
string title = "Quick Match "
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
event type integer ue_dragdrop ( dragobject adrg_source,  unsignedlong aul_index,  listbox alb_listbox )
event type integer ue_displayfailedmatches ( long ala_failedmatches[] )
cb_close cb_close
st_pcmnotconnected st_pcmnotconnected
tab_quickmatch tab_quickmatch
cb_view cb_view
st_unrecognizedlocations st_unrecognizedlocations
end type
global w_quickmatch w_quickmatch

type variables
DataWindow			idw_SourceDW 

PowerObject			ipo_Source

u_dw_QuickMatch	idw_QuickMatch

n_ds			ids_Entity  //Row being targeted from SourceDw

n_cst_String		inv_StringService

n_cst_routing		inv_routing

n_cst_RestrictionCriteria		inv_Criteria

Constant String		cs_CurrentPosition = "Current Position"
Constant String		cs_LastReported = "Last Reported"
Constant String		cs_Stop = "Stop"
Constant String		cs_EndRoute = "End Route"
Constant String		cs_EndTrip = "End Trip"

Constant String		cs_Into = "Into"
Constant String		cs_OutOf = "Outof"


boolean	ib_pcmilerconnected, &
			ib_oldpcmilerversion, &
			ib_pcmilerstreets
			
			
n_cst_msg	inv_msg  // Holds the list of failed matches for w_colist to display
end variables

forward prototypes
public function integer of_setquickmatchdw (u_dw adw_dw)
public function integer of_pcmconnect ()
public function integer of_locationcheck (ref singlelineedit asle_city, ref singlelineedit asle_state, ref singlelineedit asle_zip, ref string as_foundpcm)
public function integer of_insertshipmentlocations (u_dw adw_source, datastore ads_entity, listbox alb_listbox)
public function integer of_insertequipmentlocations (u_dw adw_source, datastore ads_entity, listbox alb_listbox)
public function integer of_insertdriverlocations (u_dw adw_source, n_ds ads_entity, listbox alb_listbox)
end prototypes

event type integer ue_dragdrop(dragobject adrg_source, unsignedlong aul_index, listbox alb_listbox);n_ds	lds_Entity

Integer li_Return = 0
u_dw 		ldw_Dw
Long		ll_CurrentRow 


IF adrg_source.TypeOf() = DataWindow! THEN
	ldw_dw = adrg_source
	ll_CurrentRow  = ldw_Dw.GetRow()
	
	IF ll_CurrentRow > 0 THEN
		lds_Entity = CREATE n_ds
		lds_Entity.DataObject = ldw_Dw.dataObject
		ldw_Dw.RowsCopy( ll_CurrentRow, ldw_Dw.RowCount(), Primary!, lds_Entity, 1, Primary! )

	END IF
	
	
	IF isValid(adrg_source) THEN
		//Clear old items
		alb_listbox.Reset()
		
		
		IF adrg_source.ClassName() = "u_dw_tcard_drivers" THEN
			li_Return = of_InsertDriverLocations(ldw_Dw, lds_Entity, alb_ListBox)
		ELSEIF adrg_source.ClassName() = "u_dw_tcard_equipment" THEN
			of_InsertEquipmentLocations(ldw_Dw, lds_Entity, alb_ListBox)
		ELSEIF adrg_source.ClassName() = "u_dw_tcard_shipments" THEN
			li_Return = of_InsertShipmentLocations(ldw_dw, lds_Entity, alb_listbox)
		END IF
	
	END IF //end if isvalid(ipo_adrg_source)


END IF

Return li_Return
end event

event type integer ue_displayfailedmatches(long ala_failedmatches[]);Long	ll_NumUnRecognized
Long	li_Parm
s_parm 		lstr_parm

IF NOT isNull(ala_FailedMatches) THEN
	ll_NumUnRecognized = UpperBound(ala_FailedMatches)
	
	IF ll_NumUnRecognized > 0 THEN
		inv_msg.of_Reset()
		lstr_parm.is_Label = "IDS"
		lstr_parm.ia_Value = ala_failedMatches
		li_Parm = inv_msg.of_add_Parm(lstr_Parm)
		lstr_parm.is_Label = "CLOSEONDOUBLECLICK"
		lstr_parm.ia_Value = TRUE
		li_Parm = inv_msg.of_add_Parm(lstr_Parm)
		IF li_Parm = 1 THEN
			st_PCMNotConnected.Visible = FALSE 
			cb_view.Visible = TRUE
			IF ll_NumUnRecognized > 1 THEN
				st_UnrecognizedLocations.Text = String(ll_NumUnRecognized) + " Unrecognized locations were found. Click to display."
			ELSE
				st_UnrecognizedLocations.Text = String(ll_NumUnRecognized) + " Unrecognized location was found. Click to display."
			END IF
			st_UnrecognizedLocations.Visible = TRUE
		ELSE
			cb_view.Visible = FALSE
			st_UnrecognizedLocations.Visible = FALSE
		END IF
	ELSE
		
		st_UnrecognizedLocations.Visible = FALSE
		cb_View.Visible = FALSE
	END IF
ELSE
	st_UnrecognizedLocations.Visible = FALSE
	cb_View.Visible = FALSE
END iF


Return 1
end event

public function integer of_setquickmatchdw (u_dw adw_dw);//idw_QuickMatch is the datawindow that processes the drag drop 
//And opens this window

idw_QuickMatch = adw_dw
Return 1
end function

public function integer of_pcmconnect ();/***************************************************************************************
NAME: 	of_PCMconnnect

ACCESS:	Public
		
ARGUMENTS: 	(none)  

RETURNS:		integer
	
DESCRIPTION:
			Makes Connection to PCM
			
			Returns 1 if connected
			Returns -1 if not connected

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11/02/05
	
***************************************************************************************/


Integer	li_Return
n_cst_trip	lnv_trip
n_cst_licensemanager	lnv_licensemanager

lnv_trip = Create n_cst_trip


IF pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() OR &
			lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler )) THEN
	IF lnv_trip.of_connect(inv_routing) THEN
		IF inv_routing.of_isvalid() THEN
			ib_pcmilerconnected = True
			li_Return = 1
			IF inv_routing.of_isoldpcmilerversion() THEN
				ib_oldpcmilerversion = True
			END IF
			IF inv_routing.of_isstreets() THEN
				ib_pcmilerstreets = True
			END IF
		ELSE
			ib_pcmilerconnected = False
			li_Return = -1
		END IF
	ELSE
		ib_pcmilerconnected = False
		li_Return = -1
	END IF
END IF

Return li_Return
end function

public function integer of_locationcheck (ref singlelineedit asle_city, ref singlelineedit asle_state, ref singlelineedit asle_zip, ref string as_foundpcm);/***************************************************************************************
NAME: 	of_LocationCheck

ACCESS:	Public
		
ARGUMENTS: 	(ref singleLineEdit asle_city,ref singleLineEdit asle_state,ref singleLineEdit asle_zip, ref string as_foundpcm)  

RETURNS:		integer
	
DESCRIPTION:
			Takes A city state and zip SLE by ref and performs a routing locationcheck on the values of the SLE
				IF the location check is successful the SLEs are updated with the correct values
					and the ls_FoundPCM is passed by ref
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11/02/05
	
***************************************************************************************/


long		li_Return
long		ll_radius

string	ls_city, &
			ls_state, &
			ls_zip, &
			ls_locater, &
			ls_foundpcm
			
boolean	lb_oldpcmilerversion, &
			lb_pcmilerstreets

if ib_pcmilerconnected then
	//get city/state or zip
	ls_city = trim(asle_city.text)
	ls_state = trim(asle_state.text)
	ls_zip = trim(asle_zip.text)

	if trim(ls_city) = "CITY" or len(trim(ls_city)) = 0 THEN
		//Nothing entered
		//try zip
		if isnumber(ls_zip) then
			ls_locater = trim(ls_zip)
			li_Return = 1
		else
			//nothing entered
			li_return = -1
		end if
	else
		if trim(ls_state) = "ST" or len(trim(ls_state)) = 0 then
			//nothing entered
			//try zip
			if isnumber(ls_zip) then
				ls_locater = trim(ls_zip)
				li_Return = 1
			else
				//nothing entered
				li_return = -1
			end if
		else
			if trim(ls_city) = "CITY" or len(trim(ls_city)) = 0 THEN

				//Nothing entered
				li_return = -1
			else
				if lb_oldpcmilerversion then
					ls_locater = trim(ls_city) + " " + trim(ls_state)
					li_Return = 1
				else
					ls_locater = trim(ls_city) + ", " + trim(ls_state)
					li_Return = 1
				end if	
			end if
		end if
	end if
			
	if len( trim( ls_locater ) ) = 0 then
		li_return = -1
	end if

	if li_return = 1 then
		if inv_routing.of_locationcheck(ls_locater, ls_foundpcm, false) > 0 then
			asle_city.text = inv_routing.of_getpartoflocater(ls_foundpcm,"CITY",true)
			asle_state.text = inv_routing.of_getpartoflocater(ls_foundpcm,"STATE",true)
			asle_zip.text = inv_routing.of_getpartoflocater(ls_foundpcm,"ZIPCODE",true)
			as_FoundPCM = ls_FoundPCM
		else
			li_return = -1
		end if
	end if

else
	li_return = -1
end if

Return li_Return
end function

public function integer of_insertshipmentlocations (u_dw adw_source, datastore ads_entity, listbox alb_listbox);/***************************************************************************************
NAME: 	of_InsertShipmentLocations

ACCESS:	Public
		
ARGUMENTS: 	(dragobject adrg_Source, datastore ads_entity, listbox alb_listbox)  

RETURNS:		none
	
DESCRIPTION:
			IF the Dw Source is a retrieval type, Locations are Inserted
			based on Tag information
			
			IF the Dw Source is a Cache Type, locations are Inserted based
			on the first 4 NextEvents
			
			Returns 1 If one or more rows are inserted
			Returns 0 If no Rows are inserted

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11/02/05
	
***************************************************************************************/


Integer	li_Return = 0
Long		ll_Index
Long		ll_Max
Long		ll_Site
Long		ll_Item
Long		ll_Ind

String	ls_Tag
String	ls_Select
String	ls_Type
String	ls_City
String	ls_State
String	ls_LocationStatus
String	ls_Location
String	ls_Coltype
String	ls_PCM
String	ls_FoundPCM
String	ls_FoundCity
String	ls_FoundState
String	ls_ComputeName
String	lsa_ObjList[]
s_co_info lstr_company
n_cst_Events	lnv_Events
n_cst_dssrv		lnv_dssrv

IF isValid(adw_Source) AND isValid(ads_entity) THEN

	
	//find out if the dataobject has a select statement or not
	ls_Select = adw_Source.Describe("Datawindow.Table.Select")
	
	IF ls_Select = "?" OR ls_Select = "!" THEN
		ls_Select = ""
	END IF
	
	
	
	IF len( ls_select ) > 0 THEN //Non-Cache
		
		//Search Computed Fields for tags
		lnv_dssrv = CREATE n_cst_dssrv
		lnv_dssrv.of_SetRequestor(ads_entity)
		
		lnv_dssrv.of_GetObjects( lsa_ObjList[], "compute", "*", false)
		ll_Max = UpperBound(lsa_ObjList[])
		IF  ll_Max > 0 AND NOT isNull(lsa_ObjList[])THEN
			FOR ll_Index = 1 TO ll_Max
				ls_ComputeName = lsa_ObjList[ll_Index]
				ls_Tag = ads_entity.Describe(ls_ComputeName + ".Tag")
				IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
					ls_LocationStatus = inv_StringService.of_GetKeyValue (ls_Tag, "Restrict", ";")
					ls_ColType = inv_StringService.of_GetKeyValue (ls_Tag, "RestrictColType", ";")
					IF ls_LocationStatus = cs_Into OR ls_LocationStatus = cs_OutOf THEN
						IF ls_ColType = "Id" THEN
							ll_Site = ads_entity.GetItemNumber(1, ls_ComputeName)
							IF gnv_cst_companies.of_get_info(ll_site, lstr_company, False) = 1 THEN
								ls_PCM = lstr_company.co_pcm
							ELSE
								SetNull(ls_PCM)
							END IF
						
						ELSEIF ls_ColType = "Locator" THEN
							ls_PCM = ads_entity.GetItemString(1, ls_ComputeName)
						END IF
							
						IF NOT isNull(ls_PCM) AND ls_PCM <> "" THEN
							IF ib_PCMilerConnected AND isValid(inv_Routing) THEN
								IF inv_routing.of_LocationCheck(ls_PCM, ls_FoundPCM, False) > 0 THEN
									ls_FoundCity =  inv_routing.of_GetPartOfLocater(ls_FoundPCM, "CITY", True)
									ls_FoundState = inv_routing.of_GetPartOfLocater(ls_FoundPCM, "STATE", True)

									ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState)
								END IF
							END IF
						END IF
					
					END IF
					
				END IF
			NEXT
		END IF
		
		
		
		//Search Columns for Tags
		IF isValid( ads_entity.Object ) THEN 
			ll_Max = Long(ads_entity.Object.DataWindow.Column.Count)
			FOR ll_Index = 1 to ll_Max
				ls_Tag = ads_entity.Describe("#"+String(ll_Index)+".Tag")
				IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
					ls_LocationStatus = inv_StringService.of_GetKeyValue (ls_Tag, "Restrict", ";")
					ls_ColType = inv_StringService.of_GetKeyValue (ls_Tag, "RestrictColType", ";")
					IF ls_LocationStatus = cs_Into OR ls_LocationStatus = cs_OutOf THEN
						IF ls_ColType = "Id" THEN
							ll_Site = ads_entity.GetItemNumber(1, ll_Index)
							IF gnv_cst_companies.of_get_info(ll_site, lstr_company, False) = 1 THEN
								ls_PCM = lstr_company.co_pcm
							ELSE
								SetNull(ls_PCM)
							END IF
						
						ELSEIF ls_ColType = "Locator" THEN
							ls_PCM = ads_entity.GetItemString(1, ll_Index)
						END IF
							
						IF NOT isNull(ls_PCM) AND ls_PCM <> "" THEN
							IF ib_PCMilerConnected AND isValid(inv_Routing) THEN
								IF inv_routing.of_LocationCheck(ls_PCM, ls_FoundPCM, False) > 0 THEN
									ls_FoundCity =  inv_routing.of_GetPartOfLocater(ls_FoundPCM, "CITY", True)
									ls_FoundState = inv_routing.of_GetPartOfLocater(ls_FoundPCM, "STATE", True)
									ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState)
									li_Return = 1
								END IF
							END IF
						END IF
					
					END IF
					
				END IF
			NEXT
		END IF
		
	ELSE//refresh from cache
		FOR ll_Index = 1 TO 4 // 4 nextevents
			IF ll_Index = 1 THEN
				ls_City = ads_entity.GetItemString(1, "nextevent_city")
				ls_State = ads_entity.GetItemString(1, "nextevent_state")
				IF NOT isNull(ls_City) AND NOT isNull(ls_State) THEN
					alb_listbox.AddItem(ls_City + ", " + ls_State)
					alb_ListBox.SelectItem(1)
					li_Return = 1
				END IF
			ELSE
				ls_City = ads_entity.GetItemString(1, "nextevent"+String(ll_Index)+"_city")
				ls_State = ads_entity.GetItemString(1, "nextevent"+String(ll_Index)+"_state")
				IF NOT isNull(ls_City) AND NOT isNull(ls_State) THEN
					alb_listbox.AddItem(ls_City + ", " + ls_State)
					li_Return = 1
				END IF
			END IF
		NEXT

	END IF
	
//Trigger SelectionChanged on selected row
	
	IF alb_ListBox.TotalItems() > 0 THEN
		ll_Ind = alb_listbox.SelectedIndex()
		IF ll_Ind > 0 THEN
			alb_ListBox.Event SelectionChanged(ll_ind)
		END IF
	END IF
	
	
END IF //end if isvalid...

Return li_Return
end function

public function integer of_insertequipmentlocations (u_dw adw_source, datastore ads_entity, listbox alb_listbox);/***************************************************************************************
NAME: 	of_InsertEquipmentLocations

ACCESS:	Public
		
ARGUMENTS: 	(dragobject adrg_Source, datastore ads_entity, listbox alb_listbox)  

RETURNS:		none
	
DESCRIPTION:
			IF the Dw Source is a retrieval type, Locations are Inserted 
			based on Tag information
			
			IF the Dw Source is a Cache Type....(doesn't do anything yet)
			
			Returns 1 if any items are inserted
			Returns 0 if no items are inserted
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/31/05
	
***************************************************************************************/

Integer	li_Return = 0
Long		ll_Index
Long		ll_Max
Long		ll_Site
LOng		ll_Item
Long		ll_Ind

String	ls_Select
String	ls_Tag
String	ls_LocationStatus
String	ls_Location
String	ls_Type
String	ls_Coltype
String	ls_PCM
String	ls_FoundPCM
String	ls_FoundCity
String	ls_FoundState
String	ls_ComputeName

String	lsa_ObjList[]

n_cst_dssrv		lnv_dssrv
s_co_info 		lstr_company

IF isValid(adw_Source) AND isValid(ads_Entity) THEN
	
	
	//find out if the dataobject has a select statement or not
	ls_Select = adw_Source.Describe("Datawindow.Table.Select")
	
	IF ls_Select = "?" OR ls_Select = "!" THEN
		ls_Select = ""
	END IF
	
	
	IF len( ls_select ) > 0 THEN //Retrieval
	
		IF isValid( ads_Entity.Object ) THEN 
			//Search Tags in Computed Fields
			lnv_dssrv = CREATE n_cst_dssrv
			lnv_dssrv.of_SetRequestor(ads_entity)
			lnv_dssrv.of_GetObjects(lsa_ObjList[], "compute", "*", false)
			ll_Max = UpperBound(lsa_ObjList[])
			IF  ll_Max > 0 AND NOT isNull(lsa_ObjList[])THEN
				FOR ll_Index = 1 TO ll_Max
					ls_ComputeName = lsa_ObjList[ll_Index]
					ls_Tag = ads_entity.Describe(ls_ComputeName + ".Tag")
					IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
						//Get the Status from the Tag (cs_CurrentPosition, cs_LastReported, cs_Stop, cs_EndRoute, cs_EndTrip)
						ls_LocationStatus = inv_StringService.of_GetKeyValue (ls_Tag, "Restrict", ";")
						//Get the Restriction type from the tag (Locator or Id)
						ls_ColType = inv_StringService.of_GetKeyValue (ls_Tag, "RestrictColType", ";")
						ls_LocationStatus = Trim(ls_LocationStatus)
						ls_ColType = Trim(ls_ColType)
						IF ls_ColType = "Id" THEN
							ll_Site = ads_entity.GetItemNumber(1, ls_ComputeName)
							IF gnv_cst_companies.of_get_info(ll_site, lstr_company, False) = 1 THEN
								ls_PCM = lstr_company.co_pcm
							ELSE
								SetNull(ls_PCM)
							END IF
							
						ELSEIF ls_ColType = "Locator" THEN
							ls_PCM = ads_entity.GetItemString(1, ls_ComputeName)
						END IF
						
						IF NOT isNull(ls_PCM) AND ls_PCM <> "" THEN
							IF isValid(inv_Routing) THEN
								IF ib_PCMilerConnected AND inv_routing.of_LocationCheck(ls_PCM, ls_FoundPCM, False) > 0 THEN
									ls_FoundCity =  inv_routing.of_GetPartOfLocater(ls_FoundPCM, "CITY", True)
									ls_FoundState = inv_routing.of_GetPartOfLocater(ls_FoundPCM, "STATE", True)
								
									//Insert Current and Last Reported at Top and append all other locations
									IF ls_LocationStatus = cs_CurrentPosition OR ls_LocationStatus = cs_LastReported THEN
										ll_Item = alb_listbox.InsertItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")", 0)
										alb_listbox.Selectitem(ll_Item)
										li_Return = 1
									ELSEIF ls_LocationStatus = cs_Stop THEN
										ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")")
										li_Return = 1
									ELSEIF ls_LocationStatus = cs_EndRoute OR ls_LocationStatus = cs_EndTrip THEN
										ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")")
										li_Return = 1
									END IF
								END IF
							END IF
						END IF
						
					END IF
				NEXT
				Destroy	lnv_dssrv
			END IF
			
			
			//Search Tags in Columns
			ll_Max = Long(ads_Entity.Object.DataWindow.Column.Count)
			FOR ll_Index = 1 to ll_Max
				ls_Tag = ads_Entity.Describe("#"+String(ll_Index)+".Tag")
				IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
					//Get the Status from the Tag (cs_CurrentPosition, cs_LastReported, cs_Stop, cs_EndRoute, cs_EndTrip)
					ls_LocationStatus = inv_StringService.of_GetKeyValue (ls_Tag, "Restrict", ";")
					//Get the Restriction type from the tag (Locator or Id)
					ls_ColType = inv_StringService.of_GetKeyValue (ls_Tag, "RestrictColType", ";")
					ls_LocationStatus = Trim(ls_LocationStatus)
					ls_ColType = Trim(ls_ColType)
					IF ls_ColType = "Id" THEN
						ll_Site = ads_Entity.GetItemNumber(1, ll_Index)
						IF gnv_cst_companies.of_get_info(ll_site, lstr_company, False) = 1 THEN
							ls_PCM = lstr_company.co_pcm
						ELSE
							SetNull(ls_PCM)
						END IF

						
					ELSEIF ls_ColType = "Locator" THEN
						ls_PCM = ads_Entity.GetItemString(1, ll_Index)
					END IF
					
					IF NOT isNull(ls_PCM) AND ls_PCM <> "" THEN
						IF ib_PCMilerConnected AND isValid(inv_Routing) THEN
							IF inv_routing.of_LocationCheck(ls_PCM, ls_FoundPCM, False) > 0 THEN
								ls_FoundCity =  inv_routing.of_GetPartOfLocater(ls_FoundPCM, "CITY", True)
								ls_FoundState = inv_routing.of_GetPartOfLocater(ls_FoundPCM, "STATE", True)
								
								//Insert Current and Last Reported at Top and append all other locations
								IF ls_LocationStatus = cs_CurrentPosition OR ls_LocationStatus = cs_LastReported THEN
									alb_listbox.Selectitem(ll_Item)
									ll_Item = alb_listbox.InsertItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")", 0)
									li_Return = 1
								ELSEIF ls_LocationStatus = cs_Stop THEN
									ll_Item = alb_listbox.InsertItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")", 2)
									li_Return = 1
								ELSEIF ls_LocationStatus = cs_EndRoute OR ls_LocationStatus = cs_EndTrip THEN
									ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")")
									li_Return = 1
								END IF
							END IF
						END IF
					END IF
					
				END IF
			NEXT
			
			//Trigger SelectionChanged on selected row
			IF alb_ListBox.TotalItems() > 0 THEN
				ll_Ind = alb_listbox.SelectedIndex()
				IF ll_Ind > 0 THEN
					alb_ListBox.Event SelectionChanged(ll_ind)
				END IF
			END IF
			
		END IF
		
		
		
	ELSE//refresh from cache
	
		//no cache for drivers yet
		
	END IF
		
END IF 

Return li_Return
end function

public function integer of_insertdriverlocations (u_dw adw_source, n_ds ads_entity, listbox alb_listbox);/***************************************************************************************
NAME: 	of_InsertDriverLocations

ACCESS:	Public
		
ARGUMENTS: 	(dragobject adrg_Source, datastore ads_entity, listbox alb_listbox)  

RETURNS:		none
	
DESCRIPTION:
			IF the Dw Source is a retrieval type, Locations are Inserted 
			based on Tag information
			
			IF the Dw Source is a Cache Type....(doesn't do anything yet)
			
			Returns 1 if any items are inserted
			Returns 0 if no items are inserted
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/31/05
	
***************************************************************************************/

Integer	li_Return = 0
Long		ll_Index
Long		ll_Max
Long		ll_Site
LOng		ll_Item
Long		ll_Ind

String	ls_Select
String	ls_Tag
String	ls_LocationStatus
String	ls_Location
String	ls_Type
String	ls_Coltype
String	ls_PCM
String	ls_FoundPCM
String	ls_FoundCity
String	ls_FoundState
String	ls_ComputeName

String	lsa_ObjList[]

n_cst_dssrv		lnv_dssrv
s_co_info 		lstr_company

IF isValid(adw_Source) AND isValid(ads_Entity) THEN
	
	
	//find out if the dataobject has a select statement or not
	ls_Select = adw_Source.Describe("Datawindow.Table.Select")
	
	IF ls_Select = "?" OR ls_Select = "!" THEN
		ls_Select = ""
	END IF
	
	
	IF len( ls_select ) > 0 THEN //Retrieval
	
		IF isValid( ads_Entity.Object ) THEN 
			//Search Tags in Computed Fields
			lnv_dssrv = CREATE n_cst_dssrv
			lnv_dssrv.of_SetRequestor(ads_entity)
			lnv_dssrv.of_GetObjects(lsa_ObjList[], "compute", "*", false)
			ll_Max = UpperBound(lsa_ObjList[])
			IF  ll_Max > 0 AND NOT isNull(lsa_ObjList[])THEN
				FOR ll_Index = 1 TO ll_Max
					ls_ComputeName = lsa_ObjList[ll_Index]
					ls_Tag = ads_entity.Describe(ls_ComputeName + ".Tag")
					IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
						//Get the Status from the Tag (cs_CurrentPosition, cs_LastReported, cs_Stop, cs_EndRoute, cs_EndTrip)
						ls_LocationStatus = inv_StringService.of_GetKeyValue (ls_Tag, "Restrict", ";")
						//Get the Restriction type from the tag (Locator or Id)
						ls_ColType = inv_StringService.of_GetKeyValue (ls_Tag, "RestrictColType", ";")
						ls_LocationStatus = Trim(ls_LocationStatus)
						ls_ColType = Trim(ls_ColType)
						IF ls_ColType = "Id" THEN
							ll_Site = ads_entity.GetItemNumber(1, ls_ComputeName)
							IF gnv_cst_companies.of_get_info(ll_site, lstr_company, False) = 1 THEN
								ls_PCM = lstr_company.co_pcm
							ELSE
								SetNull(ls_PCM)
							END IF
							
						ELSEIF ls_ColType = "Locator" THEN
							ls_PCM = ads_entity.GetItemString(1, ls_ComputeName)
						END IF
						
						IF NOT isNull(ls_PCM) AND ls_PCM <> "" THEN
							IF ib_pcmilerconnected AND isValid(inv_Routing) THEN
								IF inv_routing.of_LocationCheck(ls_PCM, ls_FoundPCM, False) > 0 THEN
									ls_FoundCity =  inv_routing.of_GetPartOfLocater(ls_FoundPCM, "CITY", True)
									ls_FoundState = inv_routing.of_GetPartOfLocater(ls_FoundPCM, "STATE", True)
								
									//Insert Current and Last Reported at Top and append all other locations
									IF ls_LocationStatus = cs_CurrentPosition OR ls_LocationStatus = cs_LastReported THEN
										ll_Item = alb_listbox.InsertItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")", 0)
										alb_listbox.Selectitem(ll_Item)
										li_Return = 1
									ELSEIF ls_LocationStatus = cs_Stop THEN
										ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")")
										li_Return = 1
									ELSEIF ls_LocationStatus = cs_EndRoute OR ls_LocationStatus = cs_EndTrip THEN
										ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")")
										li_Return = 1
									END IF
								END IF
							END IF
						END IF
						
					END IF
				NEXT
				Destroy	lnv_dssrv
			END IF
			
			
			//Search Tags in Columns
			ll_Max = Long(ads_Entity.Object.DataWindow.Column.Count)
			FOR ll_Index = 1 to ll_Max
				ls_Tag = ads_Entity.Describe("#"+String(ll_Index)+".Tag")
				IF ls_Tag <> "?" AND ls_Tag <> "!" THEN
					//Get the Status from the Tag (cs_CurrentPosition, cs_LastReported, cs_Stop, cs_EndRoute, cs_EndTrip)
					ls_LocationStatus = inv_StringService.of_GetKeyValue (ls_Tag, "Restrict", ";")
					//Get the Restriction type from the tag (Locator or Id)
					ls_ColType = inv_StringService.of_GetKeyValue (ls_Tag, "RestrictColType", ";")
					ls_LocationStatus = Trim(ls_LocationStatus)
					ls_ColType = Trim(ls_ColType)
					IF ls_ColType = "Id" THEN
						ll_Site = ads_Entity.GetItemNumber(1, ll_Index)
						IF gnv_cst_companies.of_get_info(ll_site, lstr_company, False) = 1 THEN
							ls_PCM = lstr_company.co_pcm
						ELSE
							SetNull(ls_PCM)
						END IF
						
					ELSEIF ls_ColType = "Locator" THEN
						ls_PCM = ads_Entity.GetItemString(1, ll_Index)
					END IF
					
					IF NOT isNull(ls_PCM) AND ls_PCM <> "" THEN
						IF ib_pcmilerconnected AND isValid(inv_Routing) THEN
							IF inv_routing.of_LocationCheck(ls_PCM, ls_FoundPCM, False) > 0 THEN
								ls_FoundCity =  inv_routing.of_GetPartOfLocater(ls_FoundPCM, "CITY", True)
								ls_FoundState = inv_routing.of_GetPartOfLocater(ls_FoundPCM, "STATE", True)
								
								//Insert Current and Last Reported at Top and append all other locations
								IF ls_LocationStatus = cs_CurrentPosition OR ls_LocationStatus = cs_LastReported THEN
									alb_listbox.Selectitem(ll_Item)
									ll_Item = alb_listbox.InsertItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")", 0)
									li_Return = 1
								ELSEIF ls_LocationStatus = cs_Stop THEN
									ll_Item = alb_listbox.InsertItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")", 2)
									li_Return = 1
								ELSEIF ls_LocationStatus = cs_EndRoute OR ls_LocationStatus = cs_EndTrip THEN
									ll_Item = alb_listbox.AddItem(ls_FoundCity + ", " + ls_FoundState + ", (" + ls_LocationStatus + ")")
									li_Return = 1
								END IF
							END IF
						END IF
					END IF
					
				END IF
			NEXT
			
			//Trigger SelectionChanged on selected row
			IF alb_ListBox.TotalItems() > 0 THEN
				ll_Ind = alb_listbox.SelectedIndex()
				IF ll_Ind > 0 THEN
					alb_ListBox.Event SelectionChanged(ll_ind)

				END IF
			END IF
			
		END IF
		
		
		
	ELSE//refresh from cache
	
		//no cache for drivers yet
		
	END IF
		
END IF 

Return li_Return
end function

on w_quickmatch.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_pcmnotconnected=create st_pcmnotconnected
this.tab_quickmatch=create tab_quickmatch
this.cb_view=create cb_view
this.st_unrecognizedlocations=create st_unrecognizedlocations
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_pcmnotconnected
this.Control[iCurrent+3]=this.tab_quickmatch
this.Control[iCurrent+4]=this.cb_view
this.Control[iCurrent+5]=this.st_unrecognizedlocations
end on

on w_quickmatch.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_pcmnotconnected)
destroy(this.tab_quickmatch)
destroy(this.cb_view)
destroy(this.st_unrecognizedlocations)
end on

event open;long		ll_sourceRow
Integer	li_Connect
u_dw	ldw_TempDw

cb_view.Visible = FALSE
st_unrecognizedlocations.Visible = FALSE
st_pcmnotconnected.Visible = FALSE

IF isValid(Message.PowerObjectParm) THEN
	ipo_Source = Message.PowerObjectParm 
END IF

IF isValid(ipo_Source) THEN
	IF ipo_Source.TypeOf() = DataWindow! THEN
		idw_SourceDW = ipo_Source
		ll_sourceRow = idw_SourceDw.getRow()
		
		IF ll_sourceRow > 0 THEN
			//Store Current Row of adw_Source into ids_Entity to preserve the row
			ids_Entity = CREATE n_ds
			ids_Entity.DataObject = idw_SourceDw.DataObject
			idw_SourceDw.RowsCopy( ll_sourceRow, idw_SourceDw.RowCount(), Primary!, ids_Entity, 1, primary! )
			//Connect to PCM
			li_Connect = of_PCMConnect()
			IF li_Connect = 1 THEN
				st_PCMNotConnected.Visible = FALSE
			ELSE
				st_PCMNotConnected.Text = "PC Miler Not Connected:~r~nRestrictions will be based on exact city/state matches."
				st_PCMNotConnected.Visible = TRUE
			END IF
			
			tab_quickmatch.tabpage_de.Event ue_initializedata( ipo_Source, ids_Entity)
			tab_quickmatch.tabpage_shipment.Event ue_InitializeData(ipo_Source, ids_Entity)
			IF ipo_Source.ClassName() = "u_dw_tcard_drivers" THEN
				This.of_Insertdriverlocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_shipment.lb_locationoutof)
				This.of_Insertdriverlocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_shipment.lb_locationinto)
				This.of_Insertdriverlocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_de.lb_location)
			ELSEIF ipo_Source.ClassName() = "u_dw_tcard_equipment" THEN
				This.of_InsertEquipmentlocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_shipment.lb_locationoutof)
				This.of_InsertEquipmentlocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_shipment.lb_locationinto)
				This.of_InsertEquipmentlocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_de.lb_location)
			ELSEIF ipo_Source.ClassName() = "u_dw_tcard_shipments" THEN
				This.of_InsertShipmentLocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_shipment.lb_locationoutof)
				This.of_InsertShipmentLocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_shipment.lb_locationinto)
				This.of_InsertShipmentLocations( idw_SourceDW, ids_Entity, tab_quickmatch.tabpage_de.lb_location)
				tab_quickmatch.POST selecttab(2)
			END IF
			
		END IF	
	ELSE
		//No Source Row is necessary, just open window
	END IF
	
	
END IF

end event

event close;Destroy 	ids_Entity

Destroy 	inv_Criteria
end event

type cb_close from commandbutton within w_quickmatch
integer x = 1554
integer y = 1488
integer width = 343
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean cancel = true
end type

event clicked;close(w_quickmatch)
end event

type st_pcmnotconnected from statictext within w_quickmatch
integer x = 55
integer y = 1476
integer width = 1326
integer height = 124
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "PC Miler Not Connected: Restrictions will be based on exact city/state matches."
boolean focusrectangle = false
end type

type tab_quickmatch from tab within w_quickmatch
integer x = 41
integer y = 60
integer width = 1856
integer height = 1396
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_shipment tabpage_shipment
tabpage_de tabpage_de
end type

on tab_quickmatch.create
this.tabpage_shipment=create tabpage_shipment
this.tabpage_de=create tabpage_de
this.Control[]={this.tabpage_shipment,&
this.tabpage_de}
end on

on tab_quickmatch.destroy
destroy(this.tabpage_shipment)
destroy(this.tabpage_de)
end on

type tabpage_shipment from userobject within tab_quickmatch
event type integer ue_initializedata ( powerobject apo_source,  n_ds ads_entity )
event type integer ue_storeshipmentcriteria ( )
integer x = 18
integer y = 112
integer width = 1819
integer height = 1268
long backcolor = 12632256
string text = "Shipments"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_undoshipments cb_undoshipments
cb_restrictshipment cb_restrictshipment
st_or2 st_or2
st_or st_or
sle_stateinto sle_stateinto
st_stateinto st_stateinto
sle_cityinto sle_cityinto
st_cityinto st_cityinto
st_stateoutof st_stateoutof
st_cityoutof st_cityoutof
sle_stateoutof sle_stateoutof
st_zipinto st_zipinto
sle_zipinto sle_zipinto
st_zipoutof st_zipoutof
sle_zipoutof sle_zipoutof
lb_locationinto lb_locationinto
lb_locationoutof lb_locationoutof
cbx_outof cbx_outof
cbx_into cbx_into
st_miles st_miles
sle_miles sle_miles
st_within st_within
sle_cityoutof sle_cityoutof
end type

event type integer ue_initializedata(powerobject apo_source, n_ds ads_entity);/***************************************************************************************
NAME: 	ue_initializeData

ACCESS:	Public
		
ARGUMENTS: 	(none)  

RETURNS:		Integer
	
DESCRIPTION:


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/31/05
	
***************************************************************************************/
String	ls_Type

n_cst_events	lnv_events


IF apo_Source.ClassName() = "u_dw_tcard_drivers" THEN
	cbx_outof.Checked = TRUE
	cbx_into.Checked = FALSE
ELSEIF apo_Source.ClassName() = "u_dw_tcard_shipments" THEN
	ls_Type =  ids_Entity.GetItemString(1, "nextevent_type")
	ls_Type = lnv_Events.of_gettypedatavalueshort(ls_type) //Convert to 1 char
	IF lnv_Events.of_IsTypeDeliverGroup(ls_Type) THEN
		cbx_into.Checked = TRUE
		cbx_outof.Checked = FALSE
	ELSEIF lnv_Events.of_IsTypePickupGroup(ls_Type) THEN
		cbx_outof.Checked = TRUE
		cbx_into.Checked = FALSE
	END IF
END IF

Return 1
	
end event

event type integer ue_storeshipmentcriteria();/***************************************************************************************
NAME: 	ue_StoreShipmentCriteria

ACCESS:	Public
		
ARGUMENTS: 	(none)  

RETURNS:		integer
	
DESCRIPTION:
			Criteria is stored in inv_Criteria Object

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11/02/05
	
***************************************************************************************/

Integer	li_Return = 1
Integer 	li_Result
String	ls_FoundPCM

IF NOT isValid(inv_Criteria) THEN
	inv_Criteria = CREATE n_cst_RestrictionCriteria
END iF

IF cbx_outof.Checked THEN
	IF ib_PCMilerConnected THEN
		li_Result = of_LocationCheck(sle_CityOutof, sle_stateoutof, sle_zipoutof, ls_FoundPCM)
		IF li_Result = 1 THEN
			inv_Criteria.is_outOf_foundPCM = ls_FoundPCM
		END IF
	END IF
	inv_Criteria.ib_outof = True
	inv_Criteria.is_OutOfCity = Trim( sle_cityoutof.Text )
	inv_Criteria.is_OutOfState = Trim( sle_stateoutof.Text )
	IF IsNumber(sle_zipoutof.Text) THEN
		inv_Criteria.il_outZip = Long(sle_zipoutof.Text)
	END IF
ELSE
	inv_Criteria.ib_outof = FALSE
END IF
	
IF cbx_into.Checked THEN
	IF ib_PCMilerConnected THEN
		li_Result = of_LocationCheck(sle_CityInto, sle_stateinto, sle_zipinto, ls_FoundPCM)
		IF li_Result = 1 THEN
			inv_Criteria.is_Into_foundPCM = ls_FoundPCM
		END IF
	END IF
	inv_Criteria.ib_into = True
	inv_Criteria.is_IntoCity = TRIM( sle_cityInto.Text )
	inv_Criteria.is_IntoState = TRIM( sle_stateInto.Text )
	IF IsNumber(sle_zipinto.Text) THEN
		inv_Criteria.il_intoZip = Long(sle_zipinto.Text)
	END IF
ELSE
	inv_Criteria.ib_into = FALSE
END IF


inv_Criteria.is_Tab = "SHIPMENTS"
IF isNumber(sle_miles.Text) THEN
	inv_Criteria.il_withinDistance = Long(sle_Miles.Text)
END IF



Return li_Return



end event

on tabpage_shipment.create
this.cb_undoshipments=create cb_undoshipments
this.cb_restrictshipment=create cb_restrictshipment
this.st_or2=create st_or2
this.st_or=create st_or
this.sle_stateinto=create sle_stateinto
this.st_stateinto=create st_stateinto
this.sle_cityinto=create sle_cityinto
this.st_cityinto=create st_cityinto
this.st_stateoutof=create st_stateoutof
this.st_cityoutof=create st_cityoutof
this.sle_stateoutof=create sle_stateoutof
this.st_zipinto=create st_zipinto
this.sle_zipinto=create sle_zipinto
this.st_zipoutof=create st_zipoutof
this.sle_zipoutof=create sle_zipoutof
this.lb_locationinto=create lb_locationinto
this.lb_locationoutof=create lb_locationoutof
this.cbx_outof=create cbx_outof
this.cbx_into=create cbx_into
this.st_miles=create st_miles
this.sle_miles=create sle_miles
this.st_within=create st_within
this.sle_cityoutof=create sle_cityoutof
this.Control[]={this.cb_undoshipments,&
this.cb_restrictshipment,&
this.st_or2,&
this.st_or,&
this.sle_stateinto,&
this.st_stateinto,&
this.sle_cityinto,&
this.st_cityinto,&
this.st_stateoutof,&
this.st_cityoutof,&
this.sle_stateoutof,&
this.st_zipinto,&
this.sle_zipinto,&
this.st_zipoutof,&
this.sle_zipoutof,&
this.lb_locationinto,&
this.lb_locationoutof,&
this.cbx_outof,&
this.cbx_into,&
this.st_miles,&
this.sle_miles,&
this.st_within,&
this.sle_cityoutof}
end on

on tabpage_shipment.destroy
destroy(this.cb_undoshipments)
destroy(this.cb_restrictshipment)
destroy(this.st_or2)
destroy(this.st_or)
destroy(this.sle_stateinto)
destroy(this.st_stateinto)
destroy(this.sle_cityinto)
destroy(this.st_cityinto)
destroy(this.st_stateoutof)
destroy(this.st_cityoutof)
destroy(this.sle_stateoutof)
destroy(this.st_zipinto)
destroy(this.sle_zipinto)
destroy(this.st_zipoutof)
destroy(this.sle_zipoutof)
destroy(this.lb_locationinto)
destroy(this.lb_locationoutof)
destroy(this.cbx_outof)
destroy(this.cbx_into)
destroy(this.st_miles)
destroy(this.sle_miles)
destroy(this.st_within)
destroy(this.sle_cityoutof)
end on

type cb_undoshipments from commandbutton within tabpage_shipment
integer x = 1326
integer y = 1116
integer width = 466
integer height = 112
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Undo Restriction"
end type

event clicked;IF isValid(idw_QuickMatch) THEN
	idw_QuickMatch.Event ue_UndoRestriction("SHIPMENT")
	This.Enabled = FALSE
END IF




end event

type cb_restrictshipment from commandbutton within tabpage_shipment
integer x = 841
integer y = 1116
integer width = 466
integer height = 112
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Restrict Shipments"
end type

event clicked;Integer 	li_Return

li_Return = Parent.Event ue_StoreShipmentCriteria()


IF li_Return = 1 AND isValid(idw_QuickMatch) THEN
		idw_QuickMatch.Event ue_dwrestrict(inv_Criteria)
		cb_undoshipments.Enabled = TRUE
END IF


Destroy inv_Criteria
end event

type st_or2 from statictext within tabpage_shipment
integer x = 969
integer y = 672
integer width = 87
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "OR"
boolean focusrectangle = false
end type

type st_or from statictext within tabpage_shipment
integer x = 32
integer y = 672
integer width = 87
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "OR"
boolean focusrectangle = false
end type

type sle_stateinto from singlelineedit within tabpage_shipment
integer x = 1627
integer y = 556
integer width = 137
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

type st_stateinto from statictext within tabpage_shipment
integer x = 1495
integer y = 568
integer width = 142
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "State:"
boolean focusrectangle = false
end type

type sle_cityinto from singlelineedit within tabpage_shipment
integer x = 1074
integer y = 560
integer width = 398
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_cityinto from statictext within tabpage_shipment
integer x = 969
integer y = 572
integer width = 114
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "City:"
boolean focusrectangle = false
end type

type st_stateoutof from statictext within tabpage_shipment
integer x = 567
integer y = 572
integer width = 137
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "State:"
boolean focusrectangle = false
end type

type st_cityoutof from statictext within tabpage_shipment
integer x = 32
integer y = 576
integer width = 110
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "City:"
boolean focusrectangle = false
end type

type sle_stateoutof from singlelineedit within tabpage_shipment
integer x = 695
integer y = 560
integer width = 137
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

type st_zipinto from statictext within tabpage_shipment
integer x = 1152
integer y = 672
integer width = 238
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Zip code:"
boolean focusrectangle = false
end type

type sle_zipinto from singlelineedit within tabpage_shipment
integer x = 1390
integer y = 664
integer width = 384
integer height = 80
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_zipoutof from statictext within tabpage_shipment
integer x = 224
integer y = 672
integer width = 215
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Zip code:"
boolean focusrectangle = false
end type

type sle_zipoutof from singlelineedit within tabpage_shipment
integer x = 439
integer y = 664
integer width = 398
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type lb_locationinto from listbox within tabpage_shipment
integer x = 969
integer y = 96
integer width = 800
integer height = 360
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event dragdrop;Integer li_Return

li_Return = w_quickmatch.Event ue_dragDrop(source, index, this)

IF li_Return = 1 THEN
	cbx_into.Checked = TRUE
END If
end event

event selectionchanged;String	ls_Item
String	lsa_CityState[]
ls_Item = This.SelectedItem()

inv_StringService.of_parsetoarray( ls_Item, ",", lsa_CityState)

IF UpperBound(lsa_CityState) > 1 THEN
	sle_cityInto.Text = lsa_CityState[1]
	sle_stateInto.Text = lsa_CityState[2]
END IF
end event

type lb_locationoutof from listbox within tabpage_shipment
integer x = 27
integer y = 92
integer width = 809
integer height = 360
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
integer tabstop[] = {0}
borderstyle borderstyle = stylelowered!
end type

event dragdrop;Integer li_Return
li_Return = w_quickmatch.Event ue_dragDrop(source, index, this)

IF li_Return = 1 THEN
	cbx_outof.Checked = TRUE
END IF
end event

event selectionchanged;String	ls_Item
String	lsa_CityState[]
ls_Item = This.SelectedItem()

inv_StringService.of_parsetoarray( ls_Item, ",", lsa_CityState)

IF UpperBound(lsa_CityState) > 1 THEN
	sle_cityoutof.Text = lsa_CityState[1]
	sle_stateoutof.Text = lsa_CityState[2]
END IF
end event

type cbx_outof from checkbox within tabpage_shipment
integer x = 27
integer y = 12
integer width = 238
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Out of"
end type

type cbx_into from checkbox within tabpage_shipment
integer x = 974
integer y = 16
integer width = 183
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Into"
end type

type st_miles from statictext within tabpage_shipment
integer x = 1344
integer y = 940
integer width = 128
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "miles"
boolean focusrectangle = false
end type

type sle_miles from singlelineedit within tabpage_shipment
integer x = 914
integer y = 932
integer width = 402
integer height = 80
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "10"
borderstyle borderstyle = stylelowered!
end type

type st_within from statictext within tabpage_shipment
integer x = 750
integer y = 940
integer width = 151
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Within"
boolean focusrectangle = false
end type

type sle_cityoutof from singlelineedit within tabpage_shipment
integer x = 142
integer y = 564
integer width = 398
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type tabpage_de from userobject within tab_quickmatch
event type integer ue_initializedata ( powerobject apo_source,  n_ds ads_entity )
event type integer ue_storedecriteria ( )
integer x = 18
integer y = 112
integer width = 1819
integer height = 1268
long backcolor = 12632256
string text = "Driver/Equipment"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_undode cb_undode
cb_restrictde cb_restrictde
rb_both rb_both
rb_equipment rb_equipment
rb_driver rb_driver
st_or1 st_or1
sle_state sle_state
st_state1 st_state1
sle_city sle_city
st_city1 st_city1
st_zip1 st_zip1
sle_zip sle_zip
lb_location lb_location
rb_all rb_all
rb_currentorlast rb_currentorlast
rb_current rb_current
st_miles1 st_miles1
sle_milesde sle_milesde
st_within1 st_within1
st_location1 st_location1
gb_driverlocation gb_driverlocation
gb_restriction gb_restriction
end type

event type integer ue_initializedata(powerobject apo_source, n_ds ads_entity);/***************************************************************************************
NAME: 	ue_initializeData

ACCESS:	Public
		
ARGUMENTS: 	(none)  

RETURNS:		Integer
	
DESCRIPTION:
			Initializes Data

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 10/31/05
	
***************************************************************************************/
rb_current.Checked = TRUE
rb_both.Checked = TRUE

Return 1



end event

event type integer ue_storedecriteria();/***************************************************************************************
NAME: 	ue_StoreShipmentCriteria

ACCESS:	Public
		
ARGUMENTS: 	(none)  

RETURNS:		integer
	
DESCRIPTION:
			Criteria is stored in inv_Criteria Object

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Maury 11/02/05
	
***************************************************************************************/


Integer 	li_Return = 1
Integer	li_Result
String	ls_FoundPCM

IF NOT isValid(inv_Criteria) THEN
	inv_Criteria = CREATE n_cst_RestrictionCriteria
END iF

IF rb_current.Checked THEN
	inv_Criteria.ib_current = True
	inv_Criteria.ib_alllocations = False
	inv_Criteria.ib_firstlast = False
ELSEIF rb_currentorlast.Checked THEN
	inv_Criteria.ib_firstlast = True
	inv_Criteria.ib_current = False
	inv_Criteria.ib_alllocations = False
ELSEIF rb_all.Checked THEN
	inv_Criteria.ib_alllocations = True
	inv_Criteria.ib_firstlast = False
	inv_Criteria.ib_current = False
END IF

IF isNumber(sle_milesde.Text) THEN
	inv_Criteria.il_withinDistance = Long(sle_Milesde.Text)
END IF

IF rb_both.Checked = True THEN
	inv_Criteria.is_Tab = "DRIVER_EQUIP"
ELSEIF rb_equipment.Checked = TRUE THEN
	inv_Criteria.is_Tab = "EQUIPMENT"
ELSEIF rb_driver.Checked = True THEN	
	inv_Criteria.is_Tab = "DRIVERS"
END IF

IF ib_PCMilerConnected THEN
	li_Result = of_LocationCheck(sle_City, sle_state, sle_zip, ls_FoundPCM)
	IF li_Result = 1 THEN
		inv_Criteria.is_Into_foundPCM = ls_FoundPCM
	END IF
END IF
inv_Criteria.is_IntoCity = TRIM( sle_city.Text )
inv_Criteria.is_IntoState = TRIM( sle_state.Text )
IF IsNumber(sle_zip.Text) THEN
	inv_Criteria.il_IntoZip = Long(sle_zip.Text)
END IF

Return li_Return



end event

on tabpage_de.create
this.cb_undode=create cb_undode
this.cb_restrictde=create cb_restrictde
this.rb_both=create rb_both
this.rb_equipment=create rb_equipment
this.rb_driver=create rb_driver
this.st_or1=create st_or1
this.sle_state=create sle_state
this.st_state1=create st_state1
this.sle_city=create sle_city
this.st_city1=create st_city1
this.st_zip1=create st_zip1
this.sle_zip=create sle_zip
this.lb_location=create lb_location
this.rb_all=create rb_all
this.rb_currentorlast=create rb_currentorlast
this.rb_current=create rb_current
this.st_miles1=create st_miles1
this.sle_milesde=create sle_milesde
this.st_within1=create st_within1
this.st_location1=create st_location1
this.gb_driverlocation=create gb_driverlocation
this.gb_restriction=create gb_restriction
this.Control[]={this.cb_undode,&
this.cb_restrictde,&
this.rb_both,&
this.rb_equipment,&
this.rb_driver,&
this.st_or1,&
this.sle_state,&
this.st_state1,&
this.sle_city,&
this.st_city1,&
this.st_zip1,&
this.sle_zip,&
this.lb_location,&
this.rb_all,&
this.rb_currentorlast,&
this.rb_current,&
this.st_miles1,&
this.sle_milesde,&
this.st_within1,&
this.st_location1,&
this.gb_driverlocation,&
this.gb_restriction}
end on

on tabpage_de.destroy
destroy(this.cb_undode)
destroy(this.cb_restrictde)
destroy(this.rb_both)
destroy(this.rb_equipment)
destroy(this.rb_driver)
destroy(this.st_or1)
destroy(this.sle_state)
destroy(this.st_state1)
destroy(this.sle_city)
destroy(this.st_city1)
destroy(this.st_zip1)
destroy(this.sle_zip)
destroy(this.lb_location)
destroy(this.rb_all)
destroy(this.rb_currentorlast)
destroy(this.rb_current)
destroy(this.st_miles1)
destroy(this.sle_milesde)
destroy(this.st_within1)
destroy(this.st_location1)
destroy(this.gb_driverlocation)
destroy(this.gb_restriction)
end on

type cb_undode from commandbutton within tabpage_de
integer x = 1376
integer y = 1120
integer width = 407
integer height = 112
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Undo Restriction"
end type

event clicked;IF isValid(idw_QuickMatch) THEN
	IF rb_driver.Checked THEN
		idw_QuickMatch.Event ue_UndoRestriction("DRIVERS")
	ELSEIF rb_equipment.Checked THEN
		idw_QuickMatch.Event ue_UndoRestriction("EQUIPMENT")
	ELSEIF rb_both.Checked THEN
		idw_QuickMatch.Event ue_UndoRestriction("DRIVER_EQUIP")
	END IF
	
	This.Enabled = FALSE
END IF




This.Enabled = FALSE
end event

type cb_restrictde from commandbutton within tabpage_de
integer x = 713
integer y = 1120
integer width = 635
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Restrict Drivers/Equipment"
end type

event clicked;Integer 	li_Return

li_Return = tab_quickmatch.tabpage_DE.Event ue_StoreDECriteria()



IF li_Return = 1 AND isValid(idw_QuickMatch) THEN
		idw_QuickMatch.Event ue_dwrestrict(inv_Criteria)
		cb_undoDE.Enabled = TRUE
END IF


Destroy inv_Criteria
end event

type rb_both from radiobutton within tabpage_de
integer x = 1115
integer y = 968
integer width = 576
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Driver And Equipment"
end type

event clicked;cb_restrictde.Text = "Restrict Drivers/Equipment"
end event

type rb_equipment from radiobutton within tabpage_de
integer x = 1115
integer y = 876
integer width = 320
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Equipment"
end type

event clicked;cb_restrictde.Text = "Restrict Equipment"
end event

type rb_driver from radiobutton within tabpage_de
integer x = 1115
integer y = 788
integer width = 219
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Driver"
end type

event clicked;cb_restrictde.Text = "Restrict Drivers"
end event

type st_or1 from statictext within tabpage_de
integer x = 64
integer y = 1012
integer width = 82
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "OR"
boolean focusrectangle = false
end type

type sle_state from singlelineedit within tabpage_de
integer x = 855
integer y = 876
integer width = 128
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 2
borderstyle borderstyle = stylelowered!
end type

type st_state1 from statictext within tabpage_de
integer x = 722
integer y = 892
integer width = 137
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "State:"
boolean focusrectangle = false
end type

type sle_city from singlelineedit within tabpage_de
integer x = 151
integer y = 884
integer width = 535
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_city1 from statictext within tabpage_de
integer x = 50
integer y = 892
integer width = 110
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "City:"
boolean focusrectangle = false
end type

type st_zip1 from statictext within tabpage_de
integer x = 393
integer y = 1004
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "zip code:"
boolean focusrectangle = false
end type

type sle_zip from singlelineedit within tabpage_de
integer x = 622
integer y = 996
integer width = 361
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type lb_location from listbox within tabpage_de
integer x = 247
integer y = 480
integer width = 745
integer height = 360
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event dragdrop;Integer li_Return

li_Return = w_quickmatch.Event ue_dragDrop(source, index, this)
end event

event selectionchanged;String	ls_Item
String	lsa_CityState[]
ls_Item = This.SelectedItem()

inv_StringService.of_parsetoarray( ls_Item, ",", lsa_CityState)

IF UpperBound(lsa_CityState) > 1 THEN
	sle_city.Text = lsa_CityState[1]
	sle_state.Text = lsa_CityState[2]
END IF
end event

type rb_all from radiobutton within tabpage_de
integer x = 82
integer y = 228
integer width = 645
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "All Scheduled Events"
end type

type rb_currentorlast from radiobutton within tabpage_de
integer x = 82
integer y = 144
integer width = 896
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Current Location Or Last Event"
end type

type rb_current from radiobutton within tabpage_de
integer x = 82
integer y = 64
integer width = 517
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Current Location"
end type

type st_miles1 from statictext within tabpage_de
integer x = 626
integer y = 372
integer width = 128
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "miles"
boolean focusrectangle = false
end type

type sle_milesde from singlelineedit within tabpage_de
integer x = 187
integer y = 360
integer width = 402
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "10"
borderstyle borderstyle = stylelowered!
end type

type st_within1 from statictext within tabpage_de
integer x = 32
integer y = 372
integer width = 151
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Within"
boolean focusrectangle = false
end type

type st_location1 from statictext within tabpage_de
integer x = 41
integer y = 468
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Location:"
boolean focusrectangle = false
end type

type gb_driverlocation from groupbox within tabpage_de
integer x = 27
integer y = 12
integer width = 978
integer height = 320
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Driver Location"
end type

type gb_restriction from groupbox within tabpage_de
integer x = 1088
integer y = 724
integer width = 699
integer height = 364
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Restrict"
end type

type cb_view from commandbutton within w_quickmatch
integer x = 46
integer y = 1480
integer width = 251
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Display"
end type

event clicked;IF isValid(inv_msg) THEN
	OpenWithParm(w_CoList, inv_msg )
ELSE
	MessageBox("No Unrecognized Locations", "No Unrecognized Locations were found")
END IF
end event

type st_unrecognizedlocations from statictext within w_quickmatch
integer x = 46
integer y = 1552
integer width = 1385
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
string text = "unrecognized locations were found. Click to display."
boolean focusrectangle = false
end type

