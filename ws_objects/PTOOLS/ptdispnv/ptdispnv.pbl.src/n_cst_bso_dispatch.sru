$PBExportHeader$n_cst_bso_dispatch.sru
$PBExportComments$Dispatch (Non-persistent Class from PBL map PTDisp) //@(*)[80908862|1352]
forward
global type n_cst_bso_dispatch from n_cst_bso
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_dispatch sn_n_cst_bso_dispatch_a[] //@(*)[80908862|1352:n]<nosync>
Integer sn_n_cst_bso_dispatch_c //@(*)[80908862|1352:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_dispatch from n_cst_bso
event ue_resetunmodifiables ( )
event ue_setmodlogs ( )
event type integer ue_replacetemporaryequipids ( ref long ala_temporaryids[],  ref long ala_permanentids[] )
event type integer ue_adjustcurrentevents ( )
event ue_presave ( )
end type
global n_cst_bso_dispatch n_cst_bso_dispatch

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_ds ids_eventcache //@(*)[90809851|1378]
private String is_eventselectstatement //@(*)[92794769|1384]
private n_ds ids_equipmentcache //@(*)[92108343|1383]
private n_ds ids_itinerarylist //@(*)[90979034|1379]
private n_ds ids_shipmentcache //@(*)[21509225|1418]
private n_ds ids_itemcache //@(*)[21566612|1419]
private Integer ii_routetype //@(*)[57241104|1528]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Public Constant String	cs_DataObject_Event = "d_itin"
Public Constant String	cs_DataObject_Item = "d_item_details"
Public Constant String	cs_DataObject_Shipment = "d_ship_info"
Public Constant String	cs_DataObject_Equipment = "d_equip_list"

Private Boolean	ib_TripsCached = FALSE
Private Boolean	ib_ItinerariesCached = FALSE
Private Boolean	ib_ShipmentsCached = FALSE

Protected Long	ila_EventClipboard[]
Protected Long	ila_EDI214events[]
Protected n_cst_DispatchIds	inva_ReferenceLists[]


n_cst_bso_Notification_Manager	inv_NoteManager


PROTECTED:
n_cst_bso_EdiManager	inv_EdiManager
n_cst_EquipmentPosting	inv_EquipmentPosting
n_cst_bso_document_manager	inv_DocumentManager
n_cst_bso_EdiManager_322	inv_322Manager
n_cst_ediexportshipmentmanager inv_exportShipmentManager

Private:
int	ii_TempEqID
n_cst_bso_validation	inv_Validation
n_cst_AlertManager	inv_AlertManager

end variables

forward prototypes
public function Integer of_retrieveitinerary (integer ai_type, long al_id, date ad_min, date ad_max)
public function integer of_retrieveitinerary (integer ai_type, long al_id, date ad_min, date ad_max, boolean ab_needsprior)
public function integer of_retrievetrip (long al_id)
public function integer of_retrieveevents (long al_id, string as_whereclause)
public function integer of_retrieveevents (long al_id, date ad_start, date ad_end, string as_whereclause)
public function n_ds of_GetEventcache ()
public function Integer of_SetEventcache (n_ds an_eventcache)
public function String of_GetEventselectstatement ()
public function Integer of_SetEventselectstatement (String as_eventselectstatement)
public function n_ds of_GetEquipmentcache ()
public function Integer of_SetEquipmentcache (n_ds an_equipmentcache)
public function n_ds of_GetItinerarylist ()
public function Integer of_SetItinerarylist (n_ds an_itinerarylist)
public function String of_getitineraryfilter (integer ai_type, long al_id, date ad_date)
public function String of_getitinerarysort (integer ai_type, long al_id)
public function Integer of_mergeevents (datastore ads_source)
public function n_cst_bcm of_gettrips ()
public function Long of_copyitinerary (integer ai_type, long al_id, date ad_min, date ad_max, ref datastore ads_copy)
public function integer of_retrieveshipment (long al_id)
public function n_ds of_GetShipmentcache ()
public function Integer of_SetShipmentcache (n_ds an_shipmentcache)
public function n_ds of_GetItemcache ()
public function Integer of_SetItemcache (n_ds an_itemcache)
public function integer of_retrieveshipments (long ala_ids[])
public function integer of_populateshipmentdata (ref n_cst_beo_shipment an_shipments[], n_ds ads_target)
public function String of_getitineraryfilter (integer ai_type, long al_id, date ad_min, date ad_max)
public function long of_geteventlist (long ala_ids[], ref n_cst_beo_event an_eventlist[], boolean ab_retrieveifneeded)
public function Integer of_cacheeventcompanies ()
public function Integer of_GetRoutetype ()
public function Integer of_SetRoutetype (Integer ai_routetype)
public function boolean of_hastripscached ()
public function boolean of_hasitinerariescached ()
public function boolean of_hasshipmentscached ()
protected function integer of_settripscached (readonly boolean ab_switch)
protected function integer of_setitinerariescached (readonly boolean ab_switch)
protected function integer of_setshipmentscached (readonly boolean ab_switch)
public function integer of_retrieveshipmentsplits (long ala_ids[])
public function integer of_copyshipmentcache (ref datastore ads_copy)
public function string of_getshipmentparentfilter (readonly long al_id)
public function string of_getshipmentchildfilter (readonly long al_id)
public function integer of_route (long ala_targets[], integer ai_type, long al_id, date ad_insertiondate, integer ai_datescalestyle, long al_insertionevent, integer ai_insertionstyle)
public function boolean of_isequipmentitinerary (readonly integer ai_type)
public function integer of_getequipmentinfo (readonly long al_id, ref s_eq_info astr_equip)
public function integer of_seteventclipboard (long ala_eventclipboard[])
public function integer of_cleareventclipboard ()
public function long of_copyeventclipboard (ref datastore ads_copy)
public function long of_geteventclipboard (ref long ala_eventclipboard[])
public function integer of_retrieveevents (long ala_eventids[])
public function long of_filteritinerary (datastore ads_target, integer ai_type, long al_id, date ad_min, date ad_max)
public function long of_filteritinerary (integer ai_type, long al_id, date ad_min, date ad_max)
public function integer of_newevents (string asa_types[], ref long ala_ids[])
public function integer of_unassign (long al_baseevent, integer ai_targettype, long al_targetid)
public function integer of_unassignall (long ala_baseevents[])
public function integer of_remove (long ala_eventids[])
public function integer of_assign (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle)
public function integer of_addreferencelist (n_cst_dispatchids anv_referencelist)
public function long of_getreferencelists (ref n_cst_dispatchids anva_referencelists[])
public function integer of_clearreferencelists ()
public function integer of_resettimes (string as_context, date ad_context)
public function integer of_filtershipment (long al_id)
public function integer of_assign (long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate)
public function integer of_retrieveequipment (long ala_ids[])
public function integer of_unconfirmevent (long al_id, boolean ab_interactive)
public function integer of_unconfirmevents (long ala_ids[], boolean ab_interactive)
public function long of_retrieveequipment (string as_whereclause)
public function long of_retrieveequipmentforshipment (long al_id)
public function integer of_deleteequipmentforshipment (long al_shipmentid, ref n_cst_msg anv_results)
public function integer of_deleteequipment (long ala_ids[], ref n_cst_msg anv_results)
protected function n_cst_bso_EdiManager of_getedimanager ()
public function integer of_viewedilist (long al_event)
public function long of_checkediupdate (long al_event)
public function integer of_createnewedimessage (long al_eventid)
public function long of_getequipmentforshipment (long al_shipmentid, ref long ala_equipmentids[])
public function integer of_droptodismount (long al_eventid)
public function integer of_dismounttodrop (long al_eventid)
public function integer of_hooktomount (long al_eventid)
public function integer of_mounttohook (long al_eventid)
public function integer of_pickuptohook (long al_eventid)
public function integer of_pickuptomount (long al_eventid)
public function integer of_delivertodrop (long al_eventid)
public function integer of_delivertodismount (long al_eventid)
public function integer of_dismountordroptodeliver (long al_eventid)
public function integer of_mountorhooktopickup (long al_eventid)
public function integer of_switcheventtype (long al_eventid, string as_towhat)
public function integer of_switchtopickup (long al_eventid)
public function integer of_switchtodeliver (long al_eventid)
public function integer of_processinterchange (long al_eventid, boolean ab_interactive)
public function n_cst_beo_itinerary2 of_getitinerary (integer ai_type, long al_id, date ad_min, date ad_max)
public function integer of_confirmevent (long al_id, boolean ab_interactive)
public function integer of_createmessage ()
public function n_cst_bso_Notification_Manager of_getnotificationmanager ()
protected function integer of_sendpendingmessages ()
public subroutine of_addedi214event (long al_event)
public subroutine of_clearedi214events ()
public function long of_getedi214events (ref long ala_events[])
public function integer of_retrieveitems (long ala_item[])
public function integer of_gettempeqid ()
public function integer of_deleteshipment (long al_ShipmentID)
public function long of_getequipmentforshipment (long al_ShipmentID, ref n_cst_beo_Equipment2 anva_Equipment[])
public function integer of_getshipmentchild (long ala_shipid[], ref long ala_childid[])
public function integer of_assessequipmentassignment (n_cst_beo_event anva_events[])
public function integer of_assessequipmentassignment (n_cst_beo_equipment2 anva_equipment[], n_cst_beo_event anva_eventlist[], n_cst_beo_shipment anv_shipment)
public function integer of_equipmentaddedtoshipment (n_cst_beo_Equipment2 anv_Equipment, n_cst_beo_Shipment anv_Shipment)
private function integer of_routenewequipment ()
private function integer of_assessassociationassignments (n_cst_beo_shipment anv_shipment, n_cst_beo_event anv_currentevent, n_cst_beo_equipment2 anva_containerlist[], n_cst_beo_equipment2 anva_chassislist[], n_cst_beo_event anva_eventlist[], integer ai_curentindex)
private function integer of_assessdissociationassignments (n_cst_beo_event anv_currentevent, n_cst_beo_equipment2 anva_containerlist[], n_cst_beo_equipment2 anva_chassislist[])
public function integer of_equipmentreloaded (n_cst_beo_equipment2 anv_equipment)
public function integer of_equipmentreloadcanceled (n_cst_beo_equipment2 anv_equipment)
public function integer of_duplicaterouting (long al_sourceeventid, long ala_targeteventids[], integer ai_insertionstyle)
public function integer of_setref ()
public function integer of_allowendtripnewtripremoval (long al_endtripid, long al_newtripid)
public function integer of_allowendtripremoval (long al_endtripid)
public function integer of_assignbyreroute (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle)
public function n_cst_equipmentposting of_getequipmentposting ()
public function n_cst_bso_Validation of_getvalidation ()
public function integer of_validateassociations (long ala_eventids[], long al_insertionevent, date ad_insertiondate, integer ai_itintype, long al_itinid, integer ai_assignmenttype, long al_assignmentid)
public function integer of_assignwithvalidation (long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate)
private function integer of_getlookbackstring (n_cst_beo_event anv_targetevent, integer ai_targettype, ref string as_lookback)
private function long of_getlookbackeventid (n_cst_beo_event anv_event, integer ai_targettype, long al_targetid, ref long al_lookbackeventid)
public function integer of_validateassignment (long al_targetevent, integer ai_assignmenttype, long al_assignmentid, integer ai_itintype, long al_itinid)
private function integer of_getlookforwardstring (n_cst_beo_event anv_targetevent, integer ai_targettype, string as_lookbacktype, ref string as_lookforward)
private function long of_getlookforwardeventid (n_cst_beo_event anv_event, integer ai_targettype, long al_targetid, string as_lookbackeventtype, ref long al_lookforwardeventid)
public function boolean of_isassignmentrequestbackwards (integer ai_targettype, n_cst_beo_event anv_event)
public function integer of_validaterouterequest (long ala_eventids[], long al_insertionevent, date ad_insertiondate, integer ai_itintype, long al_itinid)
public function integer of_validatedisassociation (long al_targetevent, integer ai_assignmenttype, long al_assignmentid, integer ai_itintype, long al_itinid)
public function integer of_assignbyreroute (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, boolean ab_validaterequest)
public function integer of_assign (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, boolean ab_validateonreroute)
public function n_cst_bso_document_manager of_getdocumentmanager ()
public function n_Cst_alertManager of_getalertmanager ()
private function n_Cst_bso_EdiManager_322 of_get322manager ()
public function long of_getshipments (long ala_shipmentids[], ref n_cst_beo_shipment anva_shipments[])
public function boolean of_verifybobtail (ref n_cst_beo_event anv_event)
public function integer of_autoaddbobtail (n_cst_beo_event anv_event)
public function integer of_autoaddbobtail (integer ai_itintype, long al_id, date ad_date, long al_eventid)
public function n_cst_ediexportshipmentmanager of_getexportshipmentmanager ()
public function integer of_newevents (string asa_types[], long ala_sites[], ref long ala_ids[])
end prototypes

event ue_resetunmodifiables;long dsloop, bufloop, rowloop, colloop, bufrows[3]
dwbuffer markbuf
datastore ds_target
string columns[], clear_it[]

for dsloop = 1 to 2

	if dsloop = 1 then

		IF IsValid ( ids_ShipmentCache ) THEN
			ds_target = ids_ShipmentCache
		ELSE
			CONTINUE
		END IF

	ELSE

		IF IsValid ( ids_EventCache ) THEN
			ds_target = ids_EventCache
		ELSE
			CONTINUE
		END IF

	END IF


	bufrows[1] = ds_target.rowcount()
	bufrows[2] = ds_target.filteredcount()
	bufrows[3] = ds_target.deletedcount()
	if bufrows[1] + bufrows[2] + bufrows[3] = 0 then continue
	if dsloop = 1 then
		columns = {"billto_name", "pay1_name", "billto_address"}
	else
		columns = clear_it
		columns = {"co_name", "co_city", "co_state", "co_zip", "co_tz", "co_pcm", &
			"cc_depstr", "cc_arrstr", "driv_fn", "driv_ln", "driv_ref", "trac_type", &
			"trac_ref", "trlr1_type", "trlr1_ref", "trlr1_length", "trlr2_type", "trlr2_ref", &
			"trlr2_length", "trlr3_type", "trlr3_ref", "trlr3_length", "cntn1_ref", &
			"cntn1_length", "cntn2_ref", "cntn2_length", "cntn3_ref", "cntn3_length", &
			"cntn4_ref", "cntn4_length", "acteq_type", "acteq_ref", "acteq_length", &
			"leg_miles", "leg_mins", "interch", "containermap"}
	end if
	for bufloop = 1 to 3
		if bufrows[bufloop] > 0 then
			choose case bufloop

				case 1
					markbuf = primary!
				case 2
					markbuf = filter!
				case 3
					markbuf = delete!
			end choose
			for rowloop = 1 to bufrows[bufloop]
				for colloop = 1 to upperbound(columns)
					ds_target.setitemstatus(rowloop, columns[colloop], markbuf, notmodified!)
				next
			next
		end if
	next
next
end event

event ue_setmodlogs();//Old code ported from w_Dispatch

string mod_log, ls_StatusDisplay
char status_c, status_o
long markloop, ll_RowCount
n_cst_ShipmentManager	lnv_ShipmentManager
DataStore	lds_Ships

lds_Ships = This.of_GetShipmentCache ( )
ll_RowCount = lds_Ships.RowCount ( )

for markloop = 1 to ll_RowCount
	if lds_Ships.getitemstatus(markloop, 0, primary!) = notmodified! then continue
	mod_log = lds_Ships.object.ds_mod_log[markloop]  // removed .original <<*>>
	
	IF Len ( mod_log ) > 30000 THEN
		CONTINUE 
	END IF
	
	if isnull(mod_log) then mod_log = ""
	mod_log += string(today(), "m/d/yy") + "~t" + string(now(), "h:mmA/P") + "~t"
	status_c = lds_Ships.object.ds_status[markloop]
	status_o = lds_Ships.object.ds_status.original[markloop]

	if status_c = status_o then
		mod_log += "MODIFIED~t~t"
	else

		ls_StatusDisplay = lnv_ShipmentManager.of_GetStatusDisplayValue ( status_c )

		IF status_c = gc_Dispatch.cs_ShipmentStatus_Authorized OR &
			status_c = gc_Dispatch.cs_ShipmentStatus_AuditRequired OR &
			status_c = gc_Dispatch.cs_ShipmentStatus_Template OR &
			status_c = gc_Dispatch.cs_ShipmentStatus_Cancelled OR & 
			status_c = gc_Dispatch.cs_ShipmentStatus_Declined THEN

			//(The difference here is for alignment reasons, based on the length of the
			//status description.)
			mod_log += ls_StatusDisplay + "~t"

		ELSEIF Len ( ls_StatusDisplay ) > 0 THEN
			mod_log += ls_StatusDisplay + "~t~t"

		ELSE
			mod_log += "MODIFIED~t~t"

		END IF

	end if

	mod_log += gnv_App.of_GetUserId ( ) + "~r~n"
	lds_Ships.object.ds_mod_log[markloop] = mod_log
next
end event

event type integer ue_replacetemporaryequipids(ref long ala_temporaryids[], ref long ala_permanentids[]);//Old code ported from w_Dispatch
//Returns: 1 = Success, 0 = Nothing to process, -1 = Error

if upperbound(ala_TemporaryIds) = 0 or upperbound(ala_PermanentIds) = 0 then return 0

n_cst_anyarraysrv lnv_anyarray
n_cst_EquipmentManager	lnv_EqManager

integer bufloop, colloop
long foundrow, ndx, equip_rows, bufrows[2], rowloop, rows_moved, checkid
dwobject colobj[8], &
	ldwo_MultiList				//Added 3.6.00 BKW
Integer	li_EquipType		//Added 3.6.00 BKW
String	ls_MultiList		//Added 3.6.00 BKW
Boolean	lb_Match				//Added 3.6.00 BKW
n_cst_Events	lnv_Events	//Added 3.6.00 BKW

//Existing script was old (pre-3.5) and therefore did not include multi-list processing.
//This script was unused in 3.5, and therefore had not been revised until it was again
//going to be used in 3.6
//Note that the acteq processing is (I think) not necessary as that column is not used
//anymore, but this like other references to it should be removed together.

DataStore	lds_Equip, &
				lds_Events

lds_Equip = This.of_GetEquipmentCache ( )
lds_Events = This.of_GetEventCache ( )


colobj[1] = lds_Events.object.de_trailer1
colobj[2] = lds_Events.object.de_trailer2
colobj[3] = lds_Events.object.de_trailer3
colobj[4] = lds_Events.object.de_container1
colobj[5] = lds_Events.object.de_container2
colobj[6] = lds_Events.object.de_container3
colobj[7] = lds_Events.object.de_container4
colobj[8] = lds_Events.object.de_acteq
ldwo_MultiList = lds_Events.object.de_multi_list

equip_rows = lds_Equip.rowcount()

bufrows[1] = lds_Events.rowcount()
bufrows[2] = lds_Events.filteredcount()

for rowloop = bufrows[2] to 1 step -1
	for colloop = 1 to 8
		checkid = colobj[colloop].filter[rowloop]
		if checkid > 0 then
			if lnv_anyarray.of_FindLong(ala_TemporaryIds, checkid, null_long, null_long) > 0 then
				//Note that no explicit MultiList check is necessary here, because in order for the id
				//to be in MultiList, it must also be in one of the 8 individual id columns that we check already.
				rows_moved ++
				lds_Events.rowsmove(rowloop, rowloop, filter!, &
					lds_Events, bufrows[1] + rows_moved, primary!)
				exit
			end if
		end if
	next
next

for ndx = 1 to upperbound(ala_TemporaryIds)

	for rowloop = 1 to bufrows[1] + rows_moved

		//3.6.00 Added logic to flag whether we've encountered the id on this row, so we know whether to attempt
		//MultiList replacement.
		lb_Match = FALSE
		SetNull ( li_EquipType )   //This will get set if we find a match
		//

		for colloop = 1 to 8

			if colobj[colloop].primary[rowloop] = ala_TemporaryIds[ndx] then

				colobj[colloop].primary[rowloop] = ala_PermanentIds[ndx]

				//Added 3.6.00

				lb_Match = TRUE

				CHOOSE CASE colloop

				CASE 1 TO 3

					//The first 3 columns we're checking are Trailer columns.
					li_EquipType = gc_Dispatch.ci_ItinType_TrailerChassis

				CASE 4 TO 7

					//The next 4 columns we're checking are Container columns.
					li_EquipType = gc_Dispatch.ci_ItinType_Container

				CASE ELSE

					//Shouldn't happen, since acteq is no longer in use.
					//If it does, we don't know what the equipment type is.
					//Don't bother attempting the multilist processing.
					lb_Match = FALSE

				END CHOOSE

				//END of addition

			end if
		next

		//Added 3.6.00
	
		IF lb_Match = TRUE THEN

			ls_MultiList = ldwo_MultiList.Primary [ rowloop ]

			IF Len ( ls_MultiList ) > 0 THEN

				IF lnv_Events.of_RemoveFromMultiList ( ls_MultiList, li_EquipType, ala_TemporaryIds[ndx], ls_MultiList ) = 1 THEN

					IF lnv_Events.of_AddToMultiList ( ls_MultiList, li_EquipType, ala_PermanentIds[ndx], ls_MultiList ) = 1 THEN

						ldwo_MultiList.Primary [ rowloop ] = ls_MultiList

					END IF

				END IF

			END IF

		END IF

		//End of Addition

	next

	if equip_rows > 0 then
		foundrow = lds_Equip.find("eq_id = " + string(ala_TemporaryIds[ndx]), 1, equip_rows)
		if foundrow > 0 then
			lds_Equip.object.eq_id[foundrow] = ala_PermanentIds[ndx]
			if not isnull(lds_Equip.object.oe_id[foundrow]) then &
				lds_Equip.object.oe_id[foundrow] = ala_PermanentIds[ndx]
		end if
	end if

next

if rows_moved > 0 then &
	lds_Events.rowsmove(bufrows[1] + 1, bufrows[1] + rows_moved, primary!, &
		lds_Events, bufrows[2], filter!)

for colloop = 1 to 8
	destroy colobj[colloop]
next


// <<*>> 6.17.03
// when we sync the two caches, any equipment that was just assigned a perm id will be in the eqmanager cache twice,
// once with the temp id and once w. the perm id. 
// I think ideally the 'replace code' above should look at the eq cache in the equipment manager and replace the ids 
// there. that way when the sync happens the eq will already exist and not be coppied in twice
IF lnv_EqManager.of_Sync ( lds_Equip ) = 1 THEN
	lnv_EqManager.of_RemoveTempEquipment ( )
END IF

IF isValid ( inv_Equipmentposting ) THEN
	inv_equipmentposting.of_Replacetempeqids( ala_temporaryids[] , ala_permanentids[] )
END IF


return 1
end event

event ue_adjustcurrentevents;n_cst_anyarraysrv lnv_anyarray
n_cst_Events	lnv_Events

long ids[], curevs[], checkloop, checkid, idloop, testid, numids, eqrow, evrow
integer pos1, pos2
date arrdates[], checkdate
decimal {12} seqs[], checkseq
time arrtime[2], checktime
boolean set_ok, original_value
DataStore	lds_EventCache, &
				lds_EventCopy, &
				ds_equip
n_cst_beo_Event	lnv_Event
Long	ll_CopyCount, &
		lla_EventIds[], &
		ll_Index

lds_EventCache = This.of_GetEventCache ( )

lds_EventCopy = create datastore
lds_EventCopy.dataobject = appeon_constant.cs_DataObject_Event  //Compiles as constant, not instance.
lds_EventCopy.settransobject(sqlca)

lnv_Event = CREATE n_cst_beo_Event


//lds_EventCopy.reset()
lds_EventCopy.setfilter("")

if lds_EventCache.rowcount() > 0 then &
	lds_EventCopy.object.data.primary = lds_EventCache.object.data.primary
if lds_EventCache.filteredcount() > 0 then &
	lds_EventCopy.object.data.filter = lds_EventCache.object.data.filter

lds_EventCopy.filter()
ll_CopyCount = lds_EventCopy.RowCount ( )

ds_Equip = This.of_GetEquipmentCache ( )


IF ll_CopyCount > 0 THEN
	lla_EventIds = lds_EventCopy.Object.de_Id.Primary
	ll_CopyCount = UpperBound ( lla_EventIds )
END IF

lnv_Event.of_SetSource ( lds_EventCache )

FOR ll_Index = 1 TO ll_CopyCount

	lnv_Event.of_SetSourceId ( lla_EventIds [ ll_Index ] )

	lnv_Event.of_SetOriginalValueMode ( TRUE )
	arrtime[1] = lnv_Event.of_GetTimeArrived ( )

	lnv_Event.of_SetOriginalValueMode ( FALSE )
	arrtime[2] = lnv_Event.of_GetTimeArrived ( )

	if (isnull(arrtime[1]) and not isnull(arrtime[2])) or &
		(isnull(arrtime[2]) and not isnull(arrtime[1])) then

		for pos1 = 1 to 2
			if pos1 = 2 then original_value = true else original_value = false
			lnv_Event.of_SetOriginalValueMode ( original_value )
			for pos2 = 2 to 10
				testid = lnv_Event.of_GetAssignmentByIndex ( pos2 )
				if testid > 0 then
					if lnv_anyarray.of_FindLong(ids, testid, 1, numids) > 0 then continue
					numids ++
					ids[numids] = testid
				end if
			next
		next

	end if

NEXT


//for bufloop = 1 to 2
//	choose case bufloop
//		case 1
//			loopbuf = primary!
//		case 2
//			loopbuf = filter!
//	end choose
//	for checkloop = 1 to bufrows[bufloop]
//		arrtime[1] = lds_EventCache.getitemtime(checkloop, "de_arrtime", loopbuf, true)
//		arrtime[2] = lds_EventCache.getitemtime(checkloop, "de_arrtime", loopbuf, false)
//		if (isnull(arrtime[1]) and not isnull(arrtime[2])) or &
//			(isnull(arrtime[2]) and not isnull(arrtime[1])) then
//				for pos1 = 1 to 2
//					if pos1 = 2 then original_value = true else original_value = false
//					for pos2 = 2 to 10
//						testid = getid(pos2, lds_EventCache, checkloop, loopbuf, original_value)
//						if testid > 0 then
//							if lnv_anyarray.of_FindLong(ids, testid, 1, numids) > 0 then continue
//							numids ++
//							ids[numids] = testid
//						end if
//					next
//				next
//		end if
//	next
//next


for idloop = 1 to numids
	curevs[idloop] = 0
	arrdates[idloop] = null_date
	seqs[idloop] = null_dec
next


lnv_Event.of_SetSource ( lds_EventCopy )
lnv_Event.of_SetOriginalValueMode ( FALSE )

for checkloop = 1 to ll_CopyCount

	checkdate = lds_EventCopy.object.de_arrdate[checkloop]
	checktime = lds_EventCopy.object.de_arrtime[checkloop]
	if isnull(checkdate) or isnull(checktime) then continue

	lnv_Event.of_SetSourceRow ( checkloop )

	for pos1 = 2 to 10

		testid = lnv_Event.of_GetAssignmentByIndex ( pos1 )

		pos2 = lnv_anyarray.of_FindLong(ids, testid, 1, numids)

		if pos2 > 0 then
			if pos1 = 10 then
				checkseq = lds_EventCopy.object.de_acteq_seq[checkloop]
			else
				checkseq = lnv_Events.of_GetSequenceByIndex ( lnv_Events.of_GetTypeForIndex (pos1), &
					testid, lds_EventCopy, checkloop, primary!)
			end if
			if datetime(arrdates[pos2]) > datetime(checkdate) or &
				(datetime(arrdates[pos2]) = datetime(checkdate) and seqs[pos2] > checkseq) &
					then continue
			curevs[pos2] = lla_EventIds [ checkloop ]
			arrdates[pos2] = checkdate
			seqs[pos2] = checkseq
		end if

	next

next


for idloop = 1 to numids
	set_ok = false
	eqrow = gf_local_eq(ids[idloop], ds_equip)
	if eqrow > 0 then
		if curevs[idloop] > 0 then
			evrow = lds_EventCopy.find("de_id = " + string(curevs[idloop]), 1, ll_CopyCount)
			if evrow > 0 then
				ds_equip.object.eq_cur_event[eqrow] = curevs[idloop]
				ds_equip.object.curev_type[eqrow] = lds_EventCopy.object.de_event_type[evrow]
				ds_equip.object.curev_site[eqrow] = lds_EventCopy.object.de_site[evrow]
				ds_equip.object.curev_arrdate[eqrow] = lds_EventCopy.object.de_arrdate[evrow]
				ds_equip.object.curev_arrtime[eqrow] = lds_EventCopy.object.de_arrtime[evrow]
				ds_equip.object.curev_deptime[eqrow] = lds_EventCopy.object.de_deptime[evrow]
				ds_equip.object.curev_shipment_id[eqrow] = lds_EventCopy.object.de_shipment_id[evrow]
				ds_equip.object.curev_conf[eqrow] = lds_EventCopy.object.de_conf[evrow]
				ds_equip.object.curevco_name[eqrow] = lds_EventCopy.object.co_name[evrow]
				ds_equip.object.curevco_city[eqrow] = lds_EventCopy.object.co_city[evrow]
				ds_equip.object.curevco_state[eqrow] = lds_EventCopy.object.co_state[evrow]
				ds_equip.object.curevco_tz[eqrow] = lds_EventCopy.object.co_tz[evrow]
				ds_equip.object.curevco_pcm[eqrow] = lds_EventCopy.object.co_pcm[evrow]
				set_ok = true
			end if
		end if
		if not set_ok then
			ds_equip.object.eq_cur_event[eqrow] = null_long
			ds_equip.object.curev_type[eqrow] = null_str
			ds_equip.object.curev_site[eqrow] = null_long
			ds_equip.object.curev_arrdate[eqrow] = null_date
			ds_equip.object.curev_arrtime[eqrow] = null_time
			ds_equip.object.curev_deptime[eqrow] = null_time
			ds_equip.object.curev_shipment_id[eqrow] = null_long
			ds_equip.object.curev_conf[eqrow] = null_str
			ds_equip.object.curevco_name[eqrow] = null_str
			ds_equip.object.curevco_city[eqrow] = null_str
			ds_equip.object.curevco_state[eqrow] = null_str
			ds_equip.object.curevco_tz[eqrow] = null_int
			ds_equip.object.curevco_pcm[eqrow] = null_str
		end if
	end if
next

DESTROY lds_EventCopy
DESTROY lnv_Event

return 1
end event

event ue_presave();n_cst_Settings	lnv_Settings
n_cst_privileges_Events	lnv_Privs

IF lnv_Privs.of_AllowAlteritins( ) THEN
	THIS.of_RouteNewEquipment ( )
END IF
If IsValid ( inv_NoteManager ) Then 
	IF lnv_Settings.of_CreateAccNotification ( ) THEN
		inv_NoteManager.of_CheckForAccessorialNotifications ( THIS )
		inv_NoteManager.of_RemoveUnwarrantedNotifications(THIS) 
	END IF
End If
end event

public function Integer of_retrieveitinerary (integer ai_type, long al_id, date ad_min, date ad_max);//@(*)[89704463|1359]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=opt)<return value>
Integer li_integer
return li_integer
//@(text)--

end function

public function integer of_retrieveitinerary (integer ai_type, long al_id, date ad_min, date ad_max, boolean ab_needsprior);//@(*)[89809058|1364]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:  1 = Success, -1 = Error, -2 = Original value conflict

long checkloop, foundrow, start_start, start_end, end_start, end_end, testrow, testid, &
	orig_event, term_event
string itin_cat, sel_ext, findstr, ls_MinDate, ls_MaxDate
date check_start, check_end, test_date, prior_date, todays_date
integer result
boolean absorbed, delete_rows[]
n_cst_anyarraysrv lnv_anyarray

Date	ld_Min, &
		ld_Max, &
		ld_PriorMin, &
		ld_PriorMax

n_ds	lds_ItineraryList, &
		lds_EquipmentCache, &
		lds_EventCache

DataStore	lds_EventWork
s_eq_Info	lstr_Equipment

Date	ld_Null
SetNull ( ld_Null )

String	ls_Null
SetNull ( ls_Null )

ld_Min = ad_Min
ld_Max = ad_Max
Int	li_DaysBackToCache

n_cst_setting_daysofitintocache lnv_DaysBackToCache
lnv_DaysBackToCache = CREATE n_cst_setting_daysofitintocache
li_DaysBackToCache = Integer ( lnv_DaysBackToCache.of_GetValue () ) * -1
DESTROY  ( lnv_DaysBackToCache )

//li_DaysBackToCache = -30

lds_ItineraryList = This.of_GetItineraryList ( )
lds_EquipmentCache = This.of_GetEquipmentCache ( )
lds_EventCache = This.of_GetEventCache ( )

//If the request is for a trip, redirect processing and return.

IF ai_Type = gc_Dispatch.ci_ItinType_Trip THEN
	RETURN This.of_RetrieveTrip ( al_Id )
END IF


//This provision is for temporary equipment.  If we're creating it here, 
//then by definition we've got the whole history.
if ai_Type >= 300 and (al_Id > 0 and al_Id < 1000) then return 1


setnull(prior_date)
todays_date = date(datetime(today()))

ls_MinDate = string(ld_Min, "yyyy-mm-dd")
ls_MaxDate = string(ld_Max, "yyyy-mm-dd")

if ai_Type = 100 then
	itin_cat = "M"
else
	itin_cat = "Q"
	lstr_Equipment.eq_id = al_Id
	if gf_eq_info(lds_EquipmentCache, ls_Null, ls_Null, lstr_Equipment) < 1 then return -1
end if

lds_ItineraryList.setfilter("itin_cat = '" + itin_cat + "' and itin_id = " + string(al_Id))
lds_ItineraryList.filter()
lds_ItineraryList.sort()

//if itin_cat = "Q" and lstr_Equipment.eq_outside = "T" then
//	if lds_ItineraryList.rowcount() > 0 then return 1 //You have all or nothing
//	//We go to the database for the orig and term values rather than the cache because
//	//we are trying to establish the retrieval span AS IT EXISTS IN THE DATABASE, and
//	//the cache may not accurately reflect this.
//	select de_arrdate into :ld_Min from disp_events where de_id = 
//		(select oe_orig_event from outside_equip where oe_id = :al_Id ) ;
//	choose case sqlca.sqlcode
//		case 0
//			commit ;
//		case -1
//			rollback ;
//			return -1
//		case 100
//			commit ;
//			return -1
//	end choose
//	if isnull(ld_Min) then goto add_to_lists
//	//As we get more confident about the fail-safeness of the termination event system, 
//	//we may want to revise the following (case 0, in particular) to use the term. date
//	//even when it falls within the past week.
//	if daysafter(ld_Min, todays_date) < 7 then
//		setnull(ld_Max)
//	else
//		select de_arrdate into :ld_Max from disp_events where de_id = 
//			(select oe_term_event from outside_equip where oe_id = :al_Id ) ;
//		choose case sqlca.sqlcode
//			case 0
//				commit ;
//				if daysafter(ld_Max, todays_date) < 7 then setnull(ld_Max)
//			case -1
//				rollback ;
//				return -1
//			case 100
//				commit ;
//				setnull(ld_Max)
//		end choose
//	end if

//else

	if isnull(ld_Max) then
		findstr = "start_date <= " + ls_MinDate + " and isnull(end_date)"
	else
		findstr = "start_date <= " + ls_MinDate + " and (end_date >= " + ls_MaxDate +&
			" or isnull(end_date))"
	end if

	foundrow = lds_ItineraryList.find(findstr, 1, lds_ItineraryList.rowcount())

	if foundrow > 0 then

		if ab_NeedsPrior then
			
			lds_EventWork = CREATE DataStore
			lds_EventWork.DataObject = appeon_constant.cs_DataObject_Event  //Compiles as constant, not instance.
			lds_EventWork.SetTransObject ( SQLCA )

			lds_EventWork.SetFilter ( This.of_GetItineraryFilter ( ai_Type, al_Id, ld_Null ) )
			lds_EventWork.SetSort ( This.of_GetItinerarySort ( ai_Type, al_Id ) )
			if lds_EventCache.rowcount() > 0 then &
				lds_EventWork.object.data.primary = lds_EventCache.object.data.primary
			if lds_EventCache.filteredcount() > 0 then &
				lds_EventWork.object.data.filter = lds_EventCache.object.data.filter
			lds_EventWork.filter()
			lds_EventWork.sort()
			findstr = "de_arrdate < " + ls_MinDate
			testrow = lds_EventWork.find(findstr, lds_EventWork.rowcount(), 1)
			if testrow > 0 then
				test_date = lds_EventWork.object.de_arrdate[testrow]
				if daysafter(lds_ItineraryList.object.start_date[foundrow], test_date) >= 0 then
					DESTROY lds_EventWork
					return 1
				end if
			end if

			DESTROY lds_EventWork

		else
			return 1
		end if

	end if

	if ab_NeedsPrior then

		ld_PriorMax = RelativeDate ( ld_Min, -1 )
		ld_PriorMin = RelativeDate ( ld_Min, li_DaysBackToCache )  //Go back 30 days looking for a prior event.

		choose case ai_Type
			case 100
				select max(de_arrdate) into :prior_date from disp_events
				where (de_arrdate between :ld_PriorMin and :ld_PriorMax) and (disp_events.de_driver = :al_Id) ;
			case 200
				select max(de_arrdate) into :prior_date from disp_events
				where (de_arrdate between :ld_PriorMin and :ld_PriorMax) and (disp_events.de_tractor = :al_Id) ;
			case 300
				select max(de_arrdate) into :prior_date from disp_events
				where (de_arrdate between :ld_PriorMin and :ld_PriorMax) and (:al_Id in (disp_events.de_trailer1, 
				disp_events.de_trailer2, disp_events.de_trailer3)) ;
			case 400
				select max(de_arrdate) into :prior_date from disp_events
				where (de_arrdate between :ld_PriorMin and :ld_PriorMax) and (:al_Id in (disp_events.de_container1, 
				disp_events.de_container2, disp_events.de_container3, 
				disp_events.de_container4)) ;
		end choose

		if sqlca.sqlcode = 0 then
			commit ;
		else
			rollback ;
			return -1
		end if

		if foundrow > 0 and isnull(prior_date) then return 1

		//We could potentially get more sophisticated here, checking whether we 
		//have the date in another sequence and bridging the gap.  This would 
		//probably involve checking whether the actual event ids were the same,
		//and would be fairly risky and complex.

	end if

	if daysafter(ld_Max, todays_date) < 7 then setnull(ld_Max)
	if daysafter(ld_Min, todays_date) < 7 then &
		ld_Min = relativedate(ld_Min, -1)
	if daysafter(ld_Min, prior_date) < 0 then ld_Min = prior_date

//end if

ls_MinDate = string(ld_Min, "yyyy-mm-dd")
ls_MaxDate = string(ld_Max, "yyyy-mm-dd")

if isnull(ld_Max) then
	sel_ext = "WHERE (disp_events.de_arrdate >= :min_date)"
else
	sel_ext = "WHERE (disp_events.de_arrdate between :min_date and :max_date)"
end if

choose case ai_Type
	case 100
		sel_ext += " and (disp_events.de_driver = :retrid)"
	case 200
		sel_ext += " and (disp_events.de_tractor = :retrid)"
	case 300
		sel_ext += " and (:retrid in (disp_events.de_trailer1, " +&
			"disp_events.de_trailer2, disp_events.de_trailer3))"
	case 400
		sel_ext += " and (:retrid in (disp_events.de_container1, " +&
			"disp_events.de_container2, disp_events.de_container3, "+&
			"disp_events.de_container4))"
	case else
		return -1
end choose

result = This.of_RetrieveEvents ( al_Id, ld_Min, ld_Max, sel_ext )

if result < 1 then return result

//This label was only used for the eq_outside processing.
//add_to_lists:

//Commented for 3.5.0 on 8/16/01.  Not sure why we were grabbing this...
//if ai_Type > 100 then gf_local_eq(al_Id, lds_EquipmentCache)
//

//We may want to handle this in a more sophisticated fashion later on, such as pulling
//local copies for all referenced equipment, rather that just the main one.  This has
//some potential problems as well, though, since values like termination event could
//be changed elsewhere for a referenced trailer whose itinerary was not fully retrieved.

//if itin_cat = "Q" and lstr_Equipment.eq_outside = "T" then
//	lds_ItineraryList.insertrow(0)
//	lds_ItineraryList.object.itin_cat[1] = "Q"
//	lds_ItineraryList.object.itin_id[1] = al_Id
//	lds_ItineraryList.object.start_date[1] = ld_Null
//	lds_ItineraryList.object.end_date[1] = ld_Null
//else
	lds_ItineraryList.insertrow(1)
	lds_ItineraryList.object.itin_cat[1] = itin_cat
	lds_ItineraryList.object.itin_id[1] = al_Id
	lds_ItineraryList.object.start_date[1] = ld_Min
	lds_ItineraryList.object.end_date[1] = ld_Max
	for checkloop = 2 to lds_ItineraryList.rowcount()
		ld_Min = lds_ItineraryList.object.start_date[1]
		ld_Max = lds_ItineraryList.object.end_date[1]
		check_start = lds_ItineraryList.object.start_date[checkloop]
		check_end = lds_ItineraryList.object.end_date[checkloop]
		absorbed = false
		start_start = daysafter(ld_Min, check_start)
		if isnull(ld_Max) then
			start_end = -1
		else
			start_end = daysafter(ld_Max, check_start)
		end if
		if isnull(check_end) then
			end_start = 1
		else
			end_start = daysafter(ld_Min, check_end)
		end if
		if isnull(check_end) and isnull(ld_Max) then
			end_end = 0
		elseif isnull(check_end) then
			end_end = 1
		elseif isnull(ld_Max) then
			end_end = -1
		else
			end_end = daysafter(ld_Max, check_end)
		end if
		if start_start <= 0 and end_start >= -1 then
			lds_ItineraryList.object.start_date[1] = check_start
			absorbed = true
		end if
		if end_end >= 0 and start_end <= 1 then
			lds_ItineraryList.object.end_date[1] = check_end
			absorbed = true
		end if
		if start_start >= 0 and end_end <= 0 then absorbed = true
		if absorbed then delete_rows[checkloop] = true else delete_rows[checkloop] = false
	next
	for checkloop = upperbound(delete_rows) to 2 step -1
		if delete_rows[checkloop] then
			lds_ItineraryList.rowsdiscard(checkloop, checkloop, primary!)
		end if
	next
//end if



//if morerows > 0 then
//	for checkloop = 1 to morerows
//		checkship = ds_more.object.de_shipment_id[checkloop]
//		if checkship > 0 then
//			if isnull(lnv_anyarray.of_FindLong(shipments, checkship, 1, upperbound(shipments))) and &
//				isnull(lnv_anyarray.of_FindLong(newships, checkship, 1, upperbound(newships))) then &
//					newships[upperbound(newships) + 1] = checkship
//		end if
//	next
//end if

//choose case ai_Type
//	case 100
//		drivers[upperbound(drivers) + 1] = al_Id
//	case 200
//		tractors[upperbound(tractors) + 1] = al_Id
//	case 300
//		trailers[upperbound(trailers) + 1] = al_Id
//	case 400
//		containers[upperbound(containers) + 1] = al_Id
//end choose

//if upperbound(newships) > 0 then
//	if retr_ships(newships, false) = -1 then
//		beep(5)
//		// shipment retrieval problem
//	end if
//end if


//Since we've retrieved a new itinerary, set the ItinerariesCached flag.
This.of_SetItinerariesCached ( TRUE )

return 1
end function

public function integer of_retrievetrip (long al_id);//@(*)[91304081|1380]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns :  1 = Success
//				-1 = Error
//				-2 = Original Value Conflict

Integer	li_Return = -1

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query
String	ls_WhereClause

lnv_database = gnv_bcmmgr.GetDatabase()


//Retrieve the trip information.

If IsValid(lnv_database) Then

   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument ( al_Id )
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_trip","","")

	IF IsValid ( lnv_Bcm ) THEN

		CHOOSE CASE lnv_Bcm.GetCount ( )

		CASE IS > 0
			This.Cache ( lnv_Bcm, TRUE /*DestroySource*/ )
			//Error Check!!
			li_Return = 1

		CASE 0  //No rows matching query
			//Fail

		CASE ELSE
			//Fail

		END CHOOSE

	ELSE
		//This is where flow goes if Retrieve Failed

	END IF

ELSE
	//A severed DB connection doesn't trigger this.

End If



//If all ok so far, Retrieve Events for Trip

IF li_Return = 1 THEN

	ls_WhereClause = "WHERE (disp_events." + gc_Dispatch.cs_Column_Trip  + " = :retrid)"
	
	li_Return = This.of_RetrieveEvents ( al_Id, ls_WhereClause )
	
	
	CHOOSE CASE li_Return
	
	CASE 1, -1, -2
		//Expected Values
	CASE ELSE
		li_Return = -1
	
	END CHOOSE

END IF


//If we were successful, set the TripsCached flag.

IF li_Return = 1 THEN
	This.of_SetTripsCached ( TRUE )
END IF


RETURN li_Return
end function

public function integer of_retrieveevents (long al_id, string as_whereclause);//@(*)[90401145|1375]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:  1 = Success, -1 = Error, -2 = Original value conflict

Date	ld_Null

SetNull ( ld_Null )

RETURN This.of_RetrieveEvents ( al_Id, ld_Null, ld_Null, as_WhereClause )
end function

public function integer of_retrieveevents (long al_id, date ad_start, date ad_end, string as_whereclause);//@(*)[90260543|1370]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:  1 = Success, -1 = Error, -2 = Original value conflict

String	ls_Select
Long		lla_Companies[], &
			ll_EventCount

Integer	li_Result = 1

ls_Select = This.of_GetEventSelectStatement ( )

DataStore	lds_EventWork
lds_EventWork = CREATE DataStore
lds_EventWork.DataObject = appeon_constant.cs_DataObject_Event  //Compiles as constant, not instance.
lds_EventWork.SetTransObject ( SQLCA )

lds_EventWork.object.datawindow.table.select = ls_Select + as_WhereClause

//Not necessary with creating a new local datastore
//lds_EventWork.reset()
//lds_EventWork.setfilter("")

ll_EventCount = lds_EventWork.retrieve( al_Id, ad_Start, ad_End )

if ll_EventCount = -1 then
	rollback ;
	li_Result = -1
else
	commit ;

//	Should we add this here??
//	IF ll_EventCount > 0 THEN
//		lla_Companies = lds_EventWork.Object.de_Site.Primary
//		gnv_cst_Companies.of_Cache ( lla_Companies, FALSE /*Do Not Force Refresh*/ )
//	END IF

	li_Result = This.of_MergeEvents ( lds_EventWork )
end if


CHOOSE CASE li_Result

CASE 1, -1, -2
	//Expected Values

CASE ELSE
	li_Result = -1

END CHOOSE

DESTROY lds_EventWork

RETURN li_Result
end function

public function n_ds of_GetEventcache ();//@(*)[90809851|1378:g]<nosync>//@(-)Do not edit, move or copy this line//

//If the event cache has not yet been instantiated, create it.

IF NOT IsValid ( ids_EventCache ) THEN

	n_cst_dws	lnv_Dws
	String		ls_Select

	IF lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Event, ids_EventCache, TRUE ) = 1 THEN

		ids_EventCache.of_SetBase ( TRUE )

		ls_Select = ids_EventCache.Object.DataWindow.Table.Select
		ls_Select = Replace ( ls_Select, Pos ( ls_Select, "WHERE" ), 9999, "" )
		This.of_SetEventSelectStatement ( ls_Select )

	END IF

END IF

//@(text)(recreate=yes)<body>

return ids_eventcache
//@(text)--

end function

public function Integer of_SetEventcache (n_ds an_eventcache);//@(*)[90809851|1378:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ids_eventcache = an_eventcache
return 1
//@(text)--

end function

public function String of_GetEventselectstatement ();//@(*)[92794769|1384:g]<nosync>//@(-)Do not edit, move or copy this line//

//If value is not initialized, call of_GetEventCache to force initialization.

IF is_EventSelectStatement = "" THEN
	This.of_GetEventCache ( )
END IF

//@(text)(recreate=yes)<body>

return is_eventselectstatement
//@(text)--

end function

public function Integer of_SetEventselectstatement (String as_eventselectstatement);//@(*)[92794769|1384:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

is_eventselectstatement = as_eventselectstatement
return 1
//@(text)--

end function

public function n_ds of_GetEquipmentcache ();//@(*)[92108343|1383:g]<nosync>//@(-)Do not edit, move or copy this line//

//If the equipment cache has not yet been instantiated, create it.

IF NOT IsValid ( ids_EquipmentCache ) THEN

	n_cst_Dws	lnv_Dws

	IF lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Equipment, ids_EquipmentCache, TRUE ) = 1 THEN
		ids_EquipmentCache.of_SetBase ( TRUE )
	END IF

END IF

//@(text)(recreate=yes)<body>

return ids_equipmentcache
//@(text)--

end function

public function Integer of_SetEquipmentcache (n_ds an_equipmentcache);//@(*)[92108343|1383:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ids_equipmentcache = an_equipmentcache
return 1
//@(text)--

end function

public function n_ds of_GetItinerarylist ();//@(*)[90979034|1379:g]<nosync>//@(-)Do not edit, move or copy this line//

//If the itinerary list has not yet been instantiated, create it.

IF NOT IsValid ( ids_ItineraryList ) THEN

	ids_ItineraryList = CREATE n_ds
	ids_ItineraryList.DataObject = "d_Itin_Retlist"
	//Transobject??  (No transobject was assigned in the old code)
	ids_ItineraryList.of_SetBase ( TRUE )

END IF

//@(text)(recreate=yes)<body>

return ids_itinerarylist
//@(text)--

end function

public function Integer of_SetItinerarylist (n_ds an_itinerarylist);//@(*)[90979034|1379:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ids_itinerarylist = an_itinerarylist
return 1
//@(text)--

end function

public function String of_getitineraryfilter (integer ai_type, long al_id, date ad_date);//@(*)[99340663|1385]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


RETURN This.of_GetItineraryFilter ( ai_Type, al_Id, ad_Date, ad_Date )
end function

public function String of_getitinerarysort (integer ai_type, long al_id);//@(*)[99515658|1389]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


String	ls_Sort = "datetime(de_arrdate) A, "

//Datetime is used because arrdate by itself causes sorting errors due to the
//unpredictable time component

CHOOSE CASE ai_Type

CASE 100
	ls_Sort += "de_driver_seq A"

CASE 200
	ls_Sort += "de_tractor_seq A"

CASE 300
	ls_Sort += "if(de_trailer1 = " + string(al_Id) + ", de_trailer1_seq, " +&
		"if(de_trailer2 = " + string(al_Id) + ", de_trailer2_seq, if(de_trailer3 = " +&
		string(al_Id) + ", de_trailer3_seq, de_acteq_seq)))) A"

CASE 400
	ls_Sort += "if(de_container1 = " + string(al_Id) + ", de_container1_seq, " +&
		"if(de_container2 = " + string(al_Id) + ", de_container2_seq, " +&
		"if(de_container3 = " + string(al_Id) + ", de_container3_seq, " +&
		"if(de_container4 = " + string(al_Id) + ", de_container4_seq, de_acteq_seq))))) A"

CASE gc_Dispatch.ci_ItinType_Trip
	//**Do Not Use de_ArrDate as primary sort column**
	ls_Sort = gc_Dispatch.cs_Column_TripSeq + " A"

CASE ELSE  //Unexpected Type Request  (Added 2.4.00)
	SetNull ( ls_Sort )

END CHOOSE

RETURN ls_Sort
end function

public function Integer of_mergeevents (datastore ads_source);//@(*)[101425202|1392]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:  1 = Success, -1 = Error, -2 = Original value conflict

n_cst_anyarraysrv lnv_anyarray

long sourcerows, primrows, filtrows, delrows, checkloop, source_id, source_intsig, &
	primids[], filtids[], delids[], foundrows[]

n_ds	lds_EventCache

lds_EventCache = This.of_GetEventCache ( )

sourcerows = ads_Source.rowcount()

if sourcerows = -1 then return -1
if sourcerows = 0 then return 1

primrows = lds_EventCache.rowcount()
if primrows > 0 then
	primids = lds_EventCache.object.de_id.primary
	if upperbound(primids) <> primrows then return -1
end if

filtrows = lds_EventCache.filteredcount()
if filtrows > 0 then
	filtids = lds_EventCache.object.de_id.filter
	if upperbound(filtids) <> filtrows then return -1
end if

delrows = lds_EventCache.deletedcount()
if delrows > 0 then
	delids = lds_EventCache.object.de_id.delete
	if upperbound(delids) <> delrows then return -1
end if

for checkloop = 1 to sourcerows
	source_id = ads_Source.object.de_id[checkloop]
	source_intsig = ads_Source.object.de_intsig[checkloop]
	foundrows[checkloop] = lnv_anyarray.of_FindLong(primids, source_id, 1, primrows)
	if foundrows[checkloop] > 0 then
		if lds_EventCache.object.de_intsig.primary.original[foundrows[checkloop]] = &
			source_intsig then continue else return -2
	end if
	foundrows[checkloop] = lnv_anyarray.of_FindLong(filtids, source_id, 1, filtrows)
	if foundrows[checkloop] > 0 then
		if lds_EventCache.object.de_intsig.filter.original[foundrows[checkloop]] = &
			source_intsig then continue else return -2
	end if
	foundrows[checkloop] = lnv_anyarray.of_FindLong(delids, source_id, 1, delrows)
	if foundrows[checkloop] > 0 then
		if lds_EventCache.object.de_intsig.delete.original[foundrows[checkloop]] = &
			source_intsig then continue else return -2
	end if
next

for checkloop = 1 to sourcerows
	if foundrows[checkloop] > 0 then continue
	ads_Source.rowscopy(checkloop, checkloop, primary!, &
		lds_EventCache, filtrows + 1, filter!)
	filtrows ++
	lds_EventCache.setitemstatus(filtrows, 0, filter!, datamodified!)
	lds_EventCache.setitemstatus(filtrows, 0, filter!, notmodified!)
next

ads_Source.reset()

return 1
end function

public function n_cst_bcm of_gettrips ();//@(*)[35057808|1394]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_Bcm	lnv_Bcm

//This should probably autocreate, but bso will need to be extended to give that option.
This.GetCache ( "n_cst_dlkc_trip", lnv_Bcm )
//Error Check !!

RETURN lnv_Bcm
end function

public function Long of_copyitinerary (integer ai_type, long al_id, date ad_min, date ad_max, ref datastore ads_copy);//@(*)[38138977|1397]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: >=0 (The number of rows in the itinerary), -1 = Error

DataStore	lds_EventCache
n_cst_Dws	lnv_Dws
Long			ll_RowCount

Long			ll_Return = 0

IF ll_Return = 0 THEN

	lds_EventCache = This.of_GetEventCache ( )
	
	IF NOT IsValid ( lds_EventCache ) THEN
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	IF IsValid ( ads_Copy ) THEN
		ads_Copy.Reset ( )
	ELSEIF lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Event, ads_Copy, TRUE ) = 1 THEN
		//Created OK
	ELSE
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	ads_Copy.SetFilter ( This.of_GetItineraryFilter ( ai_Type, al_Id, ad_Min, ad_Max ) )
	ads_Copy.SetSort ( This.of_GetItinerarySort ( ai_Type, al_Id ) )
	
	IF lds_EventCache.RowCount ( ) > 0 THEN
		ads_Copy.Object.Data.Primary = lds_EventCache.Object.Data.Primary
	END IF
	
	IF lds_EventCache.FilteredCount ( ) > 0 THEN
		ads_Copy.Object.Data.Filter = lds_EventCache.Object.Data.Filter
	END IF
	
	ads_Copy.ResetUpdate ( )
	
	ads_Copy.Filter ( )
	ads_Copy.Sort ( )

	ll_RowCount = ads_Copy.RowCount ( )

	IF ll_RowCount >= 0 THEN
		ll_Return = ll_RowCount
	ELSE
		ll_Return = -1
	END IF

END IF


RETURN ll_Return
end function

public function integer of_retrieveshipment (long al_id);//@(*)[21815749|1420]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns : 1 = Success (either was retrieved or was already cached), 
//				0 = Shipment has been deleted, -1 = Failure, -2 = Original Value Conflict
//
//NOTE : The return values on this version differ slightly from the return values on 
//the multi-shipment version, of_RetrieveShipments.  For this version, return value of
//0 means the shipment has been deleted.  For the multi-shipment version, it means that
//no new shipments were retrieved, possibly because they were already cached.


//Carry over from w_Dispatch
n_cst_numerical lnv_numerical
if lnv_numerical.of_IsNullOrNotPos ( al_Id ) then return -1

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment

Integer	li_Return = 1

CHOOSE CASE This.of_RetrieveShipments ( { al_Id } )

CASE 1, 0

	lnv_Shipment.of_SetSource ( This.of_GetShipmentCache ( ) )
	lnv_Shipment.of_SetSourceId ( al_id )

	IF lnv_Shipment.of_IsDeleted ( ) THEN
		li_Return = 0
	ELSEIF NOT lnv_Shipment.of_HasSource ( ) THEN
		li_Return = -1
	END IF

CASE -1
	li_Return = -1

CASE -2
	li_Return = -2

END CHOOSE

DESTROY  ( lnv_Shipment )

RETURN li_Return
end function

public function n_ds of_GetShipmentcache ();//@(*)[21509225|1418:g]<nosync>//@(-)Do not edit, move or copy this line//

//If the shipment cache has not yet been instantiated, create it.

IF NOT IsValid ( ids_ShipmentCache ) THEN

	n_cst_Dws	lnv_Dws

	IF lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Shipment, ids_ShipmentCache, TRUE ) = 1 THEN
		ids_ShipmentCache.of_SetBase ( TRUE )
	END IF

END IF


//@(text)(recreate=yes)<body>

return ids_shipmentcache
//@(text)--

end function

public function Integer of_SetShipmentcache (n_ds an_shipmentcache);//@(*)[21509225|1418:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ids_shipmentcache = an_shipmentcache
return 1
//@(text)--

end function

public function n_ds of_GetItemcache ();//@(*)[21566612|1419:g]<nosync>//@(-)Do not edit, move or copy this line//

//If the item cache has not yet been instantiated, create it.

IF NOT IsValid ( ids_ItemCache ) THEN

	n_cst_Dws	lnv_Dws

	IF lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Item, ids_ItemCache, TRUE ) = 1 THEN
		ids_ItemCache.of_SetBase ( TRUE )
	END IF

END IF


//@(text)(recreate=yes)<body>

return ids_itemcache
//@(text)--

end function

public function Integer of_SetItemcache (n_ds an_itemcache);//@(*)[21566612|1419:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ids_itemcache = an_itemcache
return 1
//@(text)--

end function

public function integer of_retrieveshipments (long ala_ids[]);//@(*)[34333195|1423]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns : 1 = Sucess, 0 = No new shipments retrieved (may have already been cached), 
//				-1 = Failure, -2 = Original value conflict

//NOTE : The return values on this version differ slightly from the return values on 
//the single-shipment version, of_RetrieveShipment (namely, the meaning of return value 0)
//See the note in that function for details.


long checkloop, bufrows, ll_co_id, ll_foundrow
integer bufloop, li_Result
dwbuffer checkbuf
string ls_WhereClause, ls_InClause, ls_address
s_co_info lstr_company

n_ds	lds_ShipmentCache, &
		lds_ItemCache
n_cst_beo_Shipment	lnv_Shipment
Long	lla_UnretrievedIds[], &
		ll_UnretrievedIdCount, &
		ll_InboundIdCount, &
		ll_Index, &
		ll_ItemCount, &
		ll_ShipmentCount, &
		ll_Row, &
		ll_Null, &
		lla_Companies[]
Date	ld_Null
String		ls_ShipmentSelect, &
				ls_EventSelect, &
				ls_ItemSelect
DataStore	lds_ShipmentWork, &
				lds_EventWork, &
				lds_ItemWork
n_cst_dws	lnv_Dws
n_cst_sql	lnv_Sql
n_cst_SqlAttrib	lnva_SqlAttrib[], &
						lnva_BlankSqlAttrib[]
n_cst_AnyArraySrv	lnv_AnyArraySrv


String	ls_Name
Long		ll_Length

Integer	li_Return = 1

SetNull ( ll_Null )
SetNull ( ld_Null )

lnv_Shipment = CREATE n_cst_beo_Shipment

lds_ShipmentCache = This.of_GetShipmentCache ( )
lnv_Shipment.of_SetSource ( lds_ShipmentCache )

ll_InboundIdCount = lnv_AnyArraySrv.of_GetShrinked ( ala_Ids, "NULLS~tDUPES" )

FOR ll_Index = 1 TO ll_InboundIdCount

	IF NOT IsNull ( ala_Ids [ ll_Index ] ) THEN

		lnv_Shipment.of_SetSourceId ( ala_Ids [ ll_Index ] )

		IF lnv_Shipment.of_HasSource ( ) THEN

			//Shipment is already in the cache.  Don't re-retrieve it.

		ELSE
			ll_UnretrievedIdCount ++
			lla_UnretrievedIds [ ll_UnretrievedIdCount ] = ala_Ids [ ll_Index ]

		END IF

	END IF

NEXT




//for bufloop = 1 to 3
//	choose case bufloop
//		case 1
//			checkbuf = primary!
//			bufrows = lds_ShipmentCache.rowcount()
//		case 2
//			checkbuf = filter!
//			bufrows = lds_ShipmentCache.filteredcount()
//		case 3
//			checkbuf = delete!
//			bufrows = lds_ShipmentCache.deletedcount()
//	end choose
//	for checkloop = 1 to bufrows
//		if lds_ShipmentCache.getitemnumber(checkloop, "ds_id", checkbuf, false) = retrid then
//			if checkbuf = delete! then return 0 else return 1
//		end if
//	next
//next

//ds_ships_a.setfilter("")
//ds_ships_a.reset()
//
//ds_items_a.setfilter("")
//ds_items_a.reset()

IF ll_UnretrievedIdCount > 0 THEN

	lds_ItemCache = This.of_GetItemCache ( )

	lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Shipment, lds_ShipmentWork, FALSE )
	lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Event, lds_EventWork, FALSE )
	lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Item, lds_ItemWork, FALSE )
	
	ls_InClause = lnv_Sql.of_MakeInClause ( lla_UnretrievedIds )


	//Prepare and set Event select statement

	ls_EventSelect = This.of_GetEventSelectStatement ( )
	ls_WhereClause = "WHERE (disp_events.de_shipment_id " + ls_InClause + " )"
	lds_EventWork.Object.Datawindow.Table.Select = ls_EventSelect + ls_WhereClause
//	lds_EventWork.setfilter("")
//	lds_EventWork.reset()


	//Prepare and set Shipment select statement

	ls_ShipmentSelect = lds_ShipmentWork.Object.Datawindow.Table.Select

	lnva_SqlAttrib = lnva_BlankSqlAttrib
	lnv_Sql.of_Parse ( ls_ShipmentSelect, lnva_SqlAttrib )
	lnva_SqlAttrib[1].s_Where = "ds_id " + ls_InClause
	ls_ShipmentSelect = lnv_Sql.of_Assemble ( lnva_SqlAttrib )

	lds_ShipmentWork.Object.Datawindow.Table.Select = ls_ShipmentSelect


	//Prepare and set Item select statement

	ls_ItemSelect = lds_ItemWork.Object.Datawindow.Table.Select

	lnva_SqlAttrib = lnva_BlankSqlAttrib
	lnv_Sql.of_Parse ( ls_ItemSelect, lnva_SqlAttrib )
	lnva_SqlAttrib[1].s_Where = "di_shipment_id " + ls_InClause
	ls_ItemSelect = lnv_Sql.of_Assemble ( lnva_SqlAttrib )

	lds_ItemWork.Object.Datawindow.Table.Select = ls_ItemSelect


	IF li_Return = 1 THEN
		if lds_ShipmentWork.Retrieve ( ll_Null ) = -1 then
			rollback ;
			li_Return = -1
		end if
	END IF
	
	IF li_Return = 1 THEN
		if lds_ItemWork.Retrieve ( ll_Null ) = -1 then
			rollback ;
			li_Return = -1
		end if
	END IF
	
	IF li_Return = 1 THEN
		if lds_EventWork.Retrieve ( ll_Null, ld_Null, ld_Null ) = -1 then
			rollback ;
			li_Return = -1
		end if
	END IF
	
	IF li_Return = 1 THEN

		commit ;


		IF lds_EventWork.RowCount ( ) > 0 THEN
			lla_Companies = lds_EventWork.Object.de_Site.Primary
			gnv_cst_Companies.of_Cache ( lla_Companies, FALSE /*Do Not Force Refresh*/ )
		END IF

		//****NOTE : The merge processing here for Events and Items places the rows directly into the
		//filter buffer, in order to avoid messing with the display if the data is being shared with
		//a visual datawindow.  This creates a problem, however, because the PBRowId is not assigned
		//unless the row goes through the primary buffer (a PB Bug??).  This causes a problem for beo 
		//processing.  We'll need to resolve this somehow.*****

	
		li_Result = This.of_MergeEvents ( lds_EventWork )
		CHOOSE CASE li_Result
		CASE 1
			//Success
		CASE -1, -2
			li_Return = li_Result
		CASE ELSE //Unexpected value
			li_Return = -1
		END CHOOSE
		

		//**NOTE** This section assumes that this method is the only retrieval source for items.
		//It simply copies items in without checking for whether they've been previously retrieved.
		//This is a remnant of the old context-specific retrieval process in w_Dispatch, and should
		//definitely be generalized.

		bufrows = lds_ItemCache.filteredcount()
		ll_ItemCount = lds_ItemWork.RowCount ( )
		
		for checkloop = 1 to ll_ItemCount
			bufrows ++
			lds_ItemWork.rowscopy(checkloop, checkloop, primary!, lds_ItemCache, bufrows, filter!)
			lds_ItemCache.setitemstatus(bufrows, 0, filter!, datamodified!)
			lds_ItemCache.setitemstatus(bufrows, 0, filter!, notmodified!)
		next
		

		ll_ShipmentCount = lds_ShipmentWork.RowCount ( )

		FOR ll_Row = 1 TO ll_ShipmentCount

			//Lookup Billto Company
			
			ll_co_id = lds_ShipmentWork.object.ds_billto_id [ ll_Row ]
			
			if gnv_cst_companies.of_get_info(ll_co_id, lstr_company, false) = 1 then
				 
				 
				ls_Name = ""
				
				Select Length (co_comments) into :ll_Length FROM Companies where co_id = :ll_co_id;
				Commit;
				
				IF ll_Length > 0 THEN
					ls_Name = "*"
				END IF
				
				if lstr_company.co_bill_same = "F" then
					ls_Name += lstr_company.co_bill_name
				else
					ls_Name += lstr_company.co_name
				end if
						
				lds_ShipmentWork.object.billto_name [ ll_Row ] = ls_Name

				
				IF gnv_cst_companies.of_get_address(ll_co_id, "BILLING_OR_WARNING!", false, ls_address) = 1 THEN
					 lds_ShipmentWork.object.billto_address [ ll_Row ] = ls_address
				END IF
			end if
			
			//Lookup Pay1 Company
			
			ll_co_id = lds_ShipmentWork.object.ds_pay1_id [ ll_Row ]
			
			if gnv_cst_companies.of_get_info(ll_co_id, lstr_company, false) = 1 then &
				lds_ShipmentWork.object.pay1_name [ ll_Row ] = lstr_company.co_name
			
			//Copy to central datastore and set status as unmodified.
			
			bufrows = lds_ShipmentCache.filteredcount() + 1
			lds_ShipmentWork.rowscopy(ll_Row, ll_Row, primary!, lds_ShipmentCache, bufrows, filter!)
			lds_ShipmentCache.setitemstatus(bufrows, 0, filter!, datamodified!)
			lds_ShipmentCache.setitemstatus(bufrows, 0, filter!, notmodified!)

		NEXT

	END IF

ELSE
	li_Return = 0

END IF


//If we were successful, set the ShipmentsCached flag.

IF li_Return = 1 THEN
	This.of_SetShipmentsCached ( TRUE )
END IF

DESTROY lds_ShipmentWork
DESTROY lds_EventWork
DESTROY lds_ItemWork
DESTROY lnv_Shipment

RETURN li_Return
end function

public function integer of_populateshipmentdata (ref n_cst_beo_shipment an_shipments[], n_ds ads_target);//@(*)[31643760|1425]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

String	lsa_Columns[], &
			ls_Value
String	ls_ColumnValue
String	ls_ColumnName
String	ls_Tag
Integer	li_ColumnCount, &
			li_ColumnIndex
Long		ll_ShipmentCount, &
			ll_ShipmentIndex, &
			ll_Row, &
			ll_LastCompanyId, &
			ll_BilltoId
Int		li_Return = 1


n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

//Note: Company processing assumes companies are already cached.
lnv_Company.of_SetUseCache ( TRUE )
SetNull ( ll_LastCompanyId )

Constant String	cs_LockId = "appeon_constant.of_PopulateShipmentData"

ads_Target.of_SetBase ( TRUE )
li_ColumnCount = ads_Target.inv_Base.of_GetObjects ( lsa_Columns, "column", "*", FALSE )
ll_ShipmentCount = UpperBound ( an_Shipments )

FOR ll_ShipmentIndex = 1 TO ll_ShipmentCount
	
	IF Not isValid ( an_Shipments [ ll_ShipmentIndex ] ) THEN
		CONTINUE
	END IF
	ll_BilltoId = an_Shipments [ ll_ShipmentIndex ].of_GetBillto ( )

	an_Shipments [ ll_ShipmentIndex ].of_LockEventList ( cs_LockId )
	an_Shipments [ ll_ShipmentIndex ].of_LockItemList ( cs_LockId )

	ll_Row = ads_Target.InsertRow ( 0 )

	FOR li_ColumnIndex = 1 TO li_ColumnCount
	
		SetNull ( ls_Value )
		
		//Check to see if the Column has a tag value, and if so use it
		ls_ColumnName = lsa_Columns [ li_ColumnIndex ] 
		ls_Tag = Trim ( ads_target.Describe( ls_ColumnName +".Tag" ) )
		IF Len ( ls_Tag ) > 0 AND  (  ls_Tag <> "?" AND ls_Tag <> "!" )  THEN
			ls_ColumnValue = Lower ( ls_Tag ) 
		ELSE
			ls_ColumnValue = Lower ( ls_ColumnName )
		END IF

		
		CHOOSE CASE ls_ColumnValue

		CASE Lower ( "Shipment_Id" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetId ( ), "0000" )

		CASE Lower ( "Shipment_ShipDate" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetShipDate ( ) )

		CASE Lower ( "Shipment_Ref1Label" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetRef1Label ( )

		CASE Lower ( "Shipment_Ref1Text" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetRef1Text ( )

		CASE Lower ( "Shipment_Ref2Label" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetRef2Label ( )

		CASE Lower ( "Shipment_Ref2Text" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetRef2Text ( )

		CASE Lower ( "Shipment_Ref3Label" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetRef3Label ( )

		CASE Lower ( "Shipment_Ref3Text" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetRef3Text ( )

		CASE Lower ( "Shipment_Status" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetDispatchStatus ( )

		CASE Lower ( "Shipment_OriginLocation" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetOriginLocation ( )

		CASE Lower ( "Shipment_DestinationLocation" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetDestinationLocation ( )

		CASE Lower ( "Shipment_TotalPieces" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetTotalPieces ( ), "0.0##" )

		CASE Lower ( "Shipment_TotalWeight" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetTotalWeight ( ), "0" )

		CASE Lower ( "Shipment_BLNumbers" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetBLNumbers ( )

		CASE Lower ( "Shipment_ScheduledPickupDate" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetScheduledPickupDate ( ) )

		CASE Lower ( "Shipment_ScheduledPickupTime" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetScheduledPickupTime ( ), "hh:mm" )

		CASE Lower ( "Shipment_ScheduledDeliveryDate" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetScheduledDeliveryDate ( ) )

		CASE Lower ( "Shipment_ScheduledDeliveryTime" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetScheduledDeliveryTime ( ), "hh:mm" )

		CASE Lower ( "Shipment_DatePickedUp" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetDatePickedUp ( ) )

		CASE Lower ( "Shipment_TimePickedUp" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetTimePickedUp ( ), "hh:mm" )

		CASE Lower ( "Shipment_DateDelivered" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetDateDelivered ( ) )

		CASE Lower ( "Shipment_TimeDelivered" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetTimeDelivered ( ), "hh:mm" )

		CASE Lower ( "Shipment_POD" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetPOD ( )

		CASE Lower ( "Shipment_InvoiceNumber" )
			ls_Value = an_Shipments [ ll_ShipmentIndex ].of_GetInvoiceNumber ( )

		CASE Lower ( "Shipment_InvoiceDate" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetInvoiceDate ( ) )

		CASE Lower ( "Shipment_GrossCharges" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetGrossCharges ( ), "0.00" )

		CASE Lower ( "Shipment_NetCharges" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetNetCharges ( ), "0.00" )

		CASE Lower ( "Shipment_FreightCharges" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetFreightCharges ( ), "0.00" )

		CASE Lower ( "Shipment_AccessorialCharges" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetAccessorialCharges ( ), "0.00" )

		CASE Lower ( "Shipment_AdjustedNetCharges" )
			ls_Value = String ( an_Shipments [ ll_ShipmentIndex ].of_GetAdjustedNetCharges ( ), "0.00" )

		CASE Lower ( "Shipment_BilltoName" ), Lower ( "Shipment_BilltoCodeName" )

			IF IsNull ( ll_BilltoId ) THEN
				//Leave ls_Value as null

			ELSE

				IF ll_BilltoId = ll_LastCompanyId THEN
					//Leave the company beo as is.
				ELSE
					lnv_Company.of_SetSourceId ( ll_BilltoId )
					ll_LastCompanyId = ll_BilltoId
				END IF

				CHOOSE CASE Lower ( lsa_Columns [ li_ColumnIndex ] )

				CASE Lower ( "Shipment_BilltoName" )
					ls_Value = lnv_Company.of_GetName ( )

				CASE Lower ( "Shipment_BilltoCodeName" )
					ls_Value = lnv_Company.of_GetCodeName ( )

				END CHOOSE

			END IF

		CASE ELSE

			an_Shipments [ ll_ShipmentIndex ].of_GetValueString ( ls_ColumnValue, ls_Value )

		END CHOOSE

		IF NOT IsNull ( ls_Value ) THEN
			ads_Target.inv_Base.of_SetItem ( ll_Row, lsa_Columns [ li_ColumnIndex ], &
				ls_Value )
		END IF

	NEXT

	an_Shipments [ ll_ShipmentIndex ].of_ReleaseEventList ( cs_LockId )
	an_Shipments [ ll_ShipmentIndex ].of_ReleaseItemList ( cs_LockId )

NEXT

DESTROY lnv_Company

RETURN 1
end function

public function String of_getitineraryfilter (integer ai_type, long al_id, date ad_min, date ad_max);//@(*)[57034856|1428]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


String	ls_Filter

ad_Min = Date ( DateTime ( ad_Min ) )
ad_Max = Date ( DateTime ( ad_Max ) )


CHOOSE CASE ai_Type

CASE 100
	ls_Filter = "de_driver = " + string(al_Id)

CASE 200
	ls_Filter = "de_tractor = " + string(al_Id)

CASE 300
	ls_Filter = "(de_trailer1 = " + string(al_Id) + " or de_trailer2 = " + string(al_Id) +&
		" or de_trailer3 = " + string(al_Id) + " or de_acteq = " + string(al_Id) + ")"

CASE 400
	ls_Filter = "(de_container1 = " + string(al_Id) + " or de_container2 = " +&
		string(al_Id) + " or de_container3 = " + string(al_Id) +&
		"or de_container4 = " + string(al_Id) + " or de_acteq = " + string(al_Id) + ")"

CASE gc_Dispatch.ci_ItinType_Trip
	ls_Filter = gc_Dispatch.cs_Column_Trip + " = " + String ( al_Id )

CASE ELSE  //Unexpected Type Value (Added 2.4.00)
	SetNull ( ls_Filter )

end choose

//IF a value was determined above, add date restrictions to it.

IF NOT IsNull ( ls_Filter ) THEN

	IF ai_Type = gc_Dispatch.ci_ItinType_Trip THEN
		//No date restrictions needed.  Display the whole trip.

	ELSEIF IsNull ( ad_Min ) AND IsNull ( ad_Max ) THEN
		ls_Filter += " and not isnull(de_arrdate)"

	ELSEIF IsNull ( ad_Min ) THEN
		ls_Filter += " and de_arrdate <= " + String ( ad_Max, "yyyy-mm-dd" )

	ELSEIF IsNull ( ad_Max ) THEN
		ls_Filter += " and de_arrdate >= " + String ( ad_Min, "yyyy-mm-dd" )

	ELSEIF ad_Min = ad_Max THEN
		ls_Filter += " and de_arrdate = " + String ( ad_Min, "yyyy-mm-dd" )

	ELSE
		ls_Filter += " and de_arrdate >= " + String ( ad_Min, "yyyy-mm-dd" ) +&
			" and de_arrdate <= " + String ( ad_Max, "yyyy-mm-dd" )

	END IF

END IF

RETURN ls_Filter
end function

public function long of_geteventlist (long ala_ids[], ref n_cst_beo_event an_eventlist[], boolean ab_retrieveifneeded);//@(*)[54269630|1433]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns:  -1 = Total Failure, >= 0 The number of events in the list that are valid.  
//(This is not necessarily the upperbound of the array.  The upperbound of the array 
//will always match the number of ids submitted, unless the function fails entirely.

//Note:  RetrieveIfNeeded processing has not been implemented!!

n_ds	lds_EventCache, &
		lds_ShipmentCache, &
		lds_ItemCache
n_cst_beo_Event	lnva_EventList[]
Long	ll_IdCount, &
		ll_Index, &
		ll_ValidCount

Long	ll_Return = 0

ll_IdCount = UpperBound ( ala_Ids )

Int	i
Int	li_Count

li_Count = UpperBound ( an_eventlist[] )
FOR i = 1 TO li_Count 
	DESTROY ( an_eventlist[i] )
NEXT



IF ll_Return = 0 THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF NOT IsValid ( lds_EventCache ) THEN
		ll_Return = -1
	END IF

END IF



IF ll_Return = 0 THEN

	lds_ShipmentCache = This.of_GetShipmentCache ( )

	IF NOT IsValid ( lds_ShipmentCache ) THEN
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	lds_ItemCache = This.of_GetItemCache ( )

	IF NOT IsValid ( lds_ItemCache ) THEN
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	FOR ll_Index = 1 TO ll_IdCount
	
		lnva_EventList [ ll_Index ] = CREATE n_cst_Beo_Event
		
		lnva_EventList [ ll_Index ].of_SetSource ( lds_EventCache )
		lnva_EventList [ ll_Index ].of_SetSourceId ( ala_Ids [ ll_Index ] )

		lnva_EventList [ ll_Index ].of_SetContext ( THIS )
		
		//***I'm really not sure we want to do this, but it's an attempt to get FreightRevenue working.
		lnva_EventList [ ll_Index ].inv_Shipment = CREATE n_cst_Beo_Shipment
		lnva_EventList [ ll_Index ].inv_Shipment.of_SetSource ( lds_ShipmentCache )
		lnva_EventList [ ll_Index ].inv_Shipment.of_SetEventSource ( lds_EventCache )
		lnva_EventList [ ll_Index ].inv_Shipment.of_SetItemSource ( lds_ItemCache )
		lnva_EventList [ ll_Index ].inv_Shipment.of_SetSourceId ( &
			lnva_EventList [ ll_Index ].of_GetShipment ( ) )
		///////////////

		IF lnva_EventList [ ll_Index ].of_HasSource ( ) THEN
			ll_ValidCount ++
		ELSE
			//Need to Implement RetrieveIfNeeded Processing
		END IF

	NEXT

	ll_Return = ll_ValidCount
	an_EventList = lnva_EventList

END IF


RETURN ll_Return
end function

public function Integer of_cacheeventcompanies ();//@(*)[59556653|1464]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


n_ds	lds_EventCache
Long	lla_PrimaryIds[], &
		lla_FilterIds[], &
		lla_DeleteIds[]

Integer	li_Return = 1

lds_EventCache = This.of_GetEventCache ( )

IF IsValid ( lds_EventCache ) THEN

	IF lds_EventCache.RowCount ( ) > 0 THEN
		lla_PrimaryIds = lds_EventCache.Object.de_Site.Primary
		gnv_cst_Companies.of_Cache ( lla_PrimaryIds, FALSE /*Don't force refresh*/ )
	END IF

	IF lds_EventCache.FilteredCount ( ) > 0 THEN
		lla_FilterIds = lds_EventCache.Object.de_Site.Filter
		gnv_cst_Companies.of_Cache ( lla_FilterIds, FALSE /*Don't force refresh*/ )
	END IF

	IF lds_EventCache.DeletedCount ( ) > 0 THEN
		lla_DeleteIds = lds_EventCache.Object.de_Site.Delete
		gnv_cst_Companies.of_Cache ( lla_DeleteIds, FALSE /*Don't force refresh*/ )
	END IF

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function Integer of_GetRoutetype ();//@(*)[57241104|1528:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return ii_routetype
//@(text)--

end function

public function Integer of_SetRoutetype (Integer ai_routetype);//@(*)[57241104|1528:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ii_routetype = ai_routetype
return 1
//@(text)--

end function

public function boolean of_hastripscached ();RETURN ib_TripsCached
end function

public function boolean of_hasitinerariescached ();RETURN ib_ItinerariesCached
end function

public function boolean of_hasshipmentscached ();RETURN ib_ShipmentsCached
end function

protected function integer of_settripscached (readonly boolean ab_switch);//Returns: 1 = Value Changed, 0 = Values already match -- No action taken, -1 = Failure

Integer	li_Return = -1

IF IsNull ( ab_Switch ) THEN
	//Value not Valid -- Fail
ELSEIF ib_TripsCached = ab_Switch THEN
	//Values alread match -- Return No Action
	li_Return = 0
ELSE
	ib_TripsCached = ab_Switch
	li_Return = 1
END IF

RETURN li_Return
end function

protected function integer of_setitinerariescached (readonly boolean ab_switch);//Returns: 1 = Value Changed, 0 = Values already match -- No action taken, -1 = Failure

Integer	li_Return = -1

IF IsNull ( ab_Switch ) THEN
	//Value not Valid -- Fail
ELSEIF ib_ItinerariesCached = ab_Switch THEN
	//Values alread match -- Return No Action
	li_Return = 0
ELSE
	ib_ItinerariesCached = ab_Switch
	li_Return = 1
END IF

RETURN li_Return
end function

protected function integer of_setshipmentscached (readonly boolean ab_switch);//Returns: 1 = Value Changed, 0 = Values already match -- No action taken, -1 = Failure

Integer	li_Return = -1

IF IsNull ( ab_Switch ) THEN
	//Value not Valid -- Fail
ELSEIF ib_ShipmentsCached = ab_Switch THEN
	//Values alread match -- Return No Action
	li_Return = 0
ELSE
	ib_ShipmentsCached = ab_Switch
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_retrieveshipmentsplits (long ala_ids[]);//Returns : 1 = Sucess, 
//				-1 = Failure, -2 = Original value conflict

n_cst_beo_Shipment	lnv_Shipment
Integer	li_Index, &
			li_TargetCount, &
			li_ChildCount
Long		lla_Parents[], &
			lla_Children[]
n_cst_Dws	lnv_Dws
DataStore	lds_ChildLookup

Integer	li_Return = 1

lnv_Shipment = CREATE n_cst_beo_Shipment


//Retrieve the Shipments that we're getting the splits for.

CHOOSE CASE This.of_RetrieveShipments ( ala_Ids )

CASE 1, 0

	//Loop through the shipments and get their parents, if any.

	li_TargetCount = UpperBound ( ala_Ids )

	FOR li_Index = 1 TO li_TargetCount

		lnv_Shipment.of_SetSource ( This.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceId ( ala_ids [ li_Index ] )
	
		IF lnv_Shipment.of_HasSource ( ) THEN
			lla_Parents [ li_Index ] = lnv_Shipment.of_GetParentId ( )
		END IF

	NEXT

CASE -1
	li_Return = -1

CASE -2
	li_Return = -2

CASE ELSE  //Unexpected Return Value
	li_Return = -1

END CHOOSE


IF li_Return = 1 THEN

	//If all ok so far, get a list of any referencing children in the database
	//(Any referencing shipments in the cache are already cached)

	IF lnv_Dws.of_CreateDataStoreByDataObject ( "d_ChildShipmentLookup", lds_ChildLookup, FALSE /*NO PFC*/ ) = 1 THEN
		li_ChildCount = lds_ChildLookup.Retrieve ( ala_Ids )
		COMMIT ;

		CHOOSE CASE li_ChildCount

		CASE IS > 0
			lla_Children = lds_ChildLookup.Object.ds_Id.Primary

		CASE 0
			//No action needed.

		CASE ELSE
			li_Return = -1

		END CHOOSE
	ELSE
		li_Return = -1
	END IF

END IF


//Note : The following two retrieves could be consolidated, if we combined the two id arrays.

IF li_Return = 1 THEN

	//If all ok so far, retrieve the Child shipments

	CHOOSE CASE This.of_RetrieveShipments ( lla_Children )

	CASE 1, 0
		//Ok

	CASE -1
		li_Return = -1

	CASE -2
		li_Return = -2

	CASE ELSE  //Unexpected return value
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	//If all ok so far, retrieve the Parent shipments

	CHOOSE CASE This.of_RetrieveShipments ( lla_Parents )

	CASE 1, 0
		//Ok

	CASE -1
		li_Return = -1

	CASE -2
		li_Return = -2

	CASE ELSE  //Unexpected return value
		li_Return = -1

	END CHOOSE

END IF


DESTROY lds_ChildLookup
DESTROY lnv_Shipment

RETURN li_Return
end function

public function integer of_copyshipmentcache (ref datastore ads_copy);//Returns: 1 = Success, -1 = Error

DataStore	lds_ShipmentCache
n_cst_Dws	lnv_Dws

Integer		li_Return = 1

IF li_Return = 1 THEN

	lds_ShipmentCache = This.of_GetShipmentCache ( )
	
	IF NOT IsValid ( lds_ShipmentCache ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF IsValid ( ads_Copy ) THEN
		ads_Copy.Reset ( )
	ELSEIF lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Shipment, ads_Copy, TRUE ) = 1 THEN
		//Created OK
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

//	ads_Copy.SetFilter ( This.of_GetItineraryFilter ( ai_Type, al_Id, ad_Min, ad_Max ) )
//	ads_Copy.SetSort ( This.of_GetItinerarySort ( ai_Type, al_Id ) )
	
	IF lds_ShipmentCache.RowCount ( ) > 0 THEN
		ads_Copy.Object.Data.Primary = lds_ShipmentCache.Object.Data.Primary
	END IF
	
	IF lds_ShipmentCache.FilteredCount ( ) > 0 THEN
		ads_Copy.Object.Data.Filter = lds_ShipmentCache.Object.Data.Filter
	END IF
	
	ads_Copy.ResetUpdate ( )
	
//	ads_Copy.Filter ( )
//	ads_Copy.Sort ( )

END IF


RETURN li_Return
end function

public function string of_getshipmentparentfilter (readonly long al_id);//Returns: The filter to display the parent (or lack thereof), or null if the filter
//cannot be determined (most likely because the target shipment has not been cached, 
//so its parent cannot be determined.)

String	ls_Filter
Long		ll_ParentId
n_cst_beo_Shipment	lnv_Shipment

SetNull ( ls_Filter )

lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_Shipment.of_SetSource ( This.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetSourceId ( al_Id )

IF lnv_Shipment.of_HasSource ( ) THEN

	ll_ParentId = lnv_Shipment.of_GetParentId ( )

	IF IsNull ( ll_ParentId ) THEN
		//No Parent.  Set filter to display nothing.
		ls_Filter = "1=2"
	ELSE
		//Set the filter to display the parent.
		ls_Filter = "ds_id = " + String ( ll_ParentId )
	END IF

END IF

DESTROY ( lnv_Shipment )

RETURN ls_Filter
end function

public function string of_getshipmentchildfilter (readonly long al_id);//Returns: The filter needed to display the child shipments for the requested parent shipment, 
//or null if the filter cannot be determined.  The only circumstance where this filter will
//not be determined is if al_id is null.  Note that you will get a valid filter back whether the
//child shipments have been retrieved or not.

String	ls_Filter

//If al_id is null, ls_Filter will come out null in this expression.
ls_Filter = gc_Dispatch.cs_Column_ParentId + " = " + String ( al_Id )

RETURN ls_Filter
end function

public function integer of_route (long ala_targets[], integer ai_type, long al_id, date ad_insertiondate, integer ai_datescalestyle, long al_insertionevent, integer ai_insertionstyle);//Returns: 1 = Success, 0 = User Cancelled, -1 = Error

n_ds		lds_Insertion
Long		ll_InsertionCount, &
			ll_InsertionRow, &
			ll_TargetCount, &
			ll_Target, &
			ll_Row, &
			ll_FirstRow, &
			ll_LastRow, &
			ll_CheckId, &
			ll_EventId, &
			lla_Ids[], &
			lla_SelectionIds[], &
			lla_ActiveDrivers[], &
			lla_ActivePowerUnits[], &
			lla_ActiveTrailerChassis[], &
			lla_ActiveContainers[], &
			lla_Drivers[], &
			lla_PowerUnits[], &
			lla_TrailerChassis[], &
			lla_Containers[]
Integer	li_Index, &
			li_SelectionCount, &
			li_SelectedIndex, &
			li_Min, &
			li_Max
dwBuffer	le_Buffer
Boolean	lb_HasPrevious, &
			lb_HasFollowing, &
			lb_SelectionRequired, &
			lb_UnlinkedEndTrip, &
			lb_TargetsAfterUnlinkedEndTrip, &
			lb_EndTripPrior
s_Strings	lstr_SelectionList
String	ls_MultiList, &
			ls_CompanyName, &
			ls_Response, &
			ls_FirstTripType, &
			ls_LastTripType, &
			ls_Type, &
			ls_Work
			
Long		lla_NewTripCompany[] // will only be one element
Int		li_Temp

Decimal {12}	lc_LowerLimit
Decimal {12}	lc_UpperLimit
Date		ld_RetrieveStart, &
			ld_RoutingDate

s_eq_info	lstr_Equip, &
				lstr_TestEquip
w_List_Sel	lw_Selection

n_cst_AnyArraySrv lnv_AnyArray

n_cst_beo_Event	lnva_Targets [], &
						lnv_PreviousEvent, &
						lnv_FollowingEvent, &
						lnv_Event, &
						lnv_CacheEvent

n_cst_Events		lnv_Events
DataStore			lds_EventCache

n_cst_OFRError 	lnva_Errors[], &
						lnv_Error

n_cst_setting_newtripendtripcompany	lnv_Site

Date	ld_Null
SetNull ( ld_Null )

DataWindow	ldw_Null

//Strip the unintended (and highly problematic) time component of the date.
ad_InsertionDate = Date ( DateTime ( ad_InsertionDate ) )

String	ls_ErrorMessage = "Could not process request."

Integer	li_Return = 1

lnv_PreviousEvent = CREATE n_cst_beo_Event
lnv_FollowingEvent = CREATE n_cst_beo_Event
lnv_Event = CREATE n_cst_beo_Event
lnv_CacheEvent = CREATE n_cst_beo_Event

lds_EventCache = This.of_GetEventCache ( )
int i
////////
Long	ll_OriginBTEvent
Long	ll_DestBTEvent
SetNull ( ll_OriginBTEvent ) 
SetNull ( ll_DestBTEvent )

lnv_Event.of_SetSource ( lds_EventCache )

FOR i = 1 TO UpperBound ( ala_targets[] )
	lnv_Event.of_SetSourceID ( ala_targets[i] )
	IF lnv_Event.of_IsBobtailevent( ) THEN
		lnv_Event.of_getbobtaileventids( ll_OriginBTEvent, ll_DestBTEvent )
	END IF
NEXT

ala_targets[UpperBound ( ala_targets[] ) + 1 ] = ll_OriginBTEvent
ala_targets[UpperBound ( ala_targets[] ) + 1 ] = ll_DestBTEvent
//lnv_AnyArray.of_insertlong(ala_targets, ll_DestBTEvent )
//lnv_AnyArray.of_insertlong(ala_targets, ll_OriginBTEvent)

///////


//Verify that ad_InsertionDate has been supplied, if it's required for ai_Type.
//For now, we'll require an InsertionDate value for all Itin Types except Trip.

IF IsNull ( ad_InsertionDate ) THEN


	CHOOSE CASE ai_Type

	CASE gc_Dispatch.ci_ItinType_Trip
		//OK.

	CASE ELSE
		ls_ErrorMessage += "~n(Target Date value is required.)"
		li_Return = -1

	END CHOOSE

END IF


//If the insertion itinerary is an equipment itinerary, get the s_eq_info structure.

IF This.of_IsEquipmentItinerary ( ai_Type ) THEN

	IF This.of_GetEquipmentInfo ( al_Id, lstr_Equip ) < 1 THEN
		ls_ErrorMessage += "~n(Could not resolve equipment information.)"
		li_Return = -1
	END IF

	//??Should we have a check that verifies the type of the equipment matches the ai_Type value??
	//This is not done explicitly now, and the code will cross up the routings if crossed-up types are supplied.

END IF


//Eliminate nulls and duplicates from the target array, and verify that there are events to insert

IF li_Return = 1 THEN

	ll_TargetCount = lnv_AnyArray.of_GetShrinked ( ala_Targets, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

	IF ll_TargetCount > 0 THEN
		//OK, proceed
	ELSE
		ls_ErrorMessage += "~n(No events to route.)"
		li_Return = -1
	END IF

END IF


//This section added 3.6.00 (after 3.6.b3) BKW  7/20/03  See notes below...

ld_RetrieveStart = ad_InsertionDate		//Setup the default value, subject to change, next...

IF li_Return = 1 AND ai_Type <> gc_Dispatch.ci_ItinType_Trip THEN

	//If we're not dealing with a trip, check the target events and see if any of them are in the
	//insertion itinerary prior to the insertion date.  If so, we'll retrieve from the earliest routing date 
	//on these events (plus prior event), rather than just from the insertion date (plus prior event.)
	//This is to prevent a problem that can occur if the target events constitute the complete itinerary for the
	//first day with events prior to the routing date.  What happens (and this was an issue through 3.6.b3),
	//is that the retrieval thinks it has prior events, so it doesn't go back any earlier than these events,
	//but then these events get removed and routed, and so then there's no longer any prior events, so 
	//you end up losing the assignment(s) that should be carried into the insertion (a driver, for example,
	//if re-routing the events to a tractor itinerary.)   3.6.00 7/20/03 BKW

	lnv_Event.of_SetSource ( lds_EventCache)

	FOR ll_Target = 1 TO ll_TargetCount

		//Note:  Checking date first, then of_IsAssigned cuts down on processing, as opposed to the reverse.

		lnv_Event.of_SetSourceId ( ala_Targets [ ll_Target ] )
		ld_RoutingDate = lnv_Event.of_GetDateArrived ( )

		IF ld_RoutingDate < ld_RetrieveStart THEN

			IF lnv_Event.of_IsAssigned ( ai_Type, al_Id ) THEN

				ld_RetrieveStart = ld_RoutingDate

			END IF

		END IF

	NEXT

END IF

//END OF NEW SECTION  7/20/03


//Retrieve the insertion itinerary from ld_RetrieveStart forward, including the prior event, if any.

IF li_Return = 1 THEN

	//Note:  If the itinerary is already retrieved, this will not hit the database.

	//Note:  Until 3.6.00 7/20/03, ad_InsertionDate was used instead of ld_RetrieveStart.
	//			ld_RetrieveStart was implemented and substituted here to take care of a problem described above.

	CHOOSE CASE This.of_RetrieveItinerary ( ai_Type, al_Id, ld_RetrieveStart, ld_Null, TRUE /*NeedsPrior*/ )

	CASE 1	
		//Retrieved OK
	
	CASE -1
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "A check with the database indicates that information needed "+&
			"to process this request has changed since your last save.  You should attempt "+&
			"to save now, before continuing."
		li_Return = -1

	CASE ELSE  //Unexpected return value.
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)"
		li_Return = -1
	
	END CHOOSE

END IF


//of_UnassignAll will attempt to clear event confirmations, so we don't have to here.


//Remove any associations/dissociations that the target events are performing.  These would be cleared from
//the target events themselves later on, but this step is necessary so that the associations/dissociations don't 
//get left orphaned on the events that follow the target events, even though the target events have been 
//routed elsewhere.

IF li_Return = 1 THEN

	//If of_UnassignAll fails, we'll be reading the failure error.  Make sure the Error list is clear.
	This.ClearOFRErrors ( )

	//Prep a work variable with the base error message for this operation, which would be used for both
	//failure and unexpected return value, below.
	ls_Work = "In order to perform the routing request, any existing assignments peformed by the " +&
		"events must first be cleared."

	CHOOSE CASE This.of_UnassignAll ( ala_Targets )

	CASE 1
		//OK

	CASE -1

		ls_ErrorMessage = ls_Work

		IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
			//There are errors to process -- Get the error text
			ls_Work = lnva_Errors[1].GetErrorMessage ( )
		ELSE
			ls_Work = ""
		END IF

		IF Len ( ls_Work ) > 0 THEN
			ls_ErrorMessage += "  The following error(s) occurred when attempting to clear the "+&
				"assignments:~n~n" + ls_Work + "~n"
		ELSE
			ls_ErrorMessage += "~n~nThere was an unidentified error when attempting to clear the assignments."
		END IF

		li_Return = -1

	CASE ELSE  //Unexpected return value

		ls_ErrorMessage = ls_Work + "~n~nThere was an unexpected return error when attempting to clear the assignments."
		li_Return = -1

	END CHOOSE

END IF


//Copy the whole insertion itinerary to a work datastore, so we can work with it.

IF li_Return = 1 THEN

	ll_InsertionCount = This.of_CopyItinerary ( ai_Type, al_Id, ld_Null, ld_Null, lds_Insertion )

	IF ll_InsertionCount = -1 THEN
		ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)"
		li_Return = -1
	END IF

END IF


//If the requested insertion style is StartOfRoute or EndOfRoute, check whether we have assignment
//events in the target. If so, change the insertion style to StartOfTrip or EndOfTrip.

IF li_Return = 1 AND ( ai_InsertionStyle = gc_Dispatch.ci_InsertionStyle_StartOfRoute &
	OR ai_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfRoute ) THEN

	lnv_Event.of_SetSource ( lds_Insertion )

	FOR ll_Target = 1 TO ll_TargetCount

		lnv_Event.of_SetSourceId ( ala_Targets [ ll_Target ] )

		IF lnv_Event.of_IsAssignment ( ) THEN

			CHOOSE CASE ai_InsertionStyle

			CASE gc_Dispatch.ci_InsertionStyle_StartOfRoute
				ai_InsertionStyle = gc_Dispatch.ci_InsertionStyle_StartOfTrip

			CASE gc_Dispatch.ci_InsertionStyle_EndOfRoute
				ai_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfTrip

			END CHOOSE

			//Change has been made.  No need to continue further.
			EXIT

		END IF

	NEXT

END IF


//Find the insertion point

IF li_Return = 1 THEN

	CHOOSE CASE lnv_Events.of_GetInsertionPoint ( lds_Insertion, ai_Type, al_Id, ad_InsertionDate, &
		al_InsertionEvent, ai_InsertionStyle, ll_InsertionRow, ls_Work /*ErrorText*/ )

	CASE 1
		//Success

	CASE -1

		//Failure

		IF Len ( ls_Work ) > 0 THEN

			ls_ErrorMessage = ls_Work

		ELSE

			ls_ErrorMessage += "~n(Unspecified error determining insertion point.)"

		END IF

		li_Return = -1

	CASE ELSE

		//Unexpected return value

		ls_ErrorMessage += "~n(Unexpected return error determining insertion point.)"
		li_Return = -1

	END CHOOSE

END IF


//Move the target rows to the insertion point.

IF li_Return = 1 THEN

	//Set the lb_EndTripPrior flag to false at the outset of the loop.
	lb_EndTripPrior = FALSE
	
	FOR ll_Target = 1 TO ll_TargetCount
		
		lnva_Targets [ ll_Target ] = CREATE n_cst_beo_Event
		lnva_Targets [ ll_Target ].of_SetSource ( lds_Insertion )
		lnva_Targets [ ll_Target ].of_SetSourceId ( ala_Targets [ ll_Target ] )

		//Find the target, Check event type if we're routing to a trip, and move it to the insertion point.
		IF lnva_Targets [ ll_Target ].of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't Create*/ ) = 1 THEN

			//Don't allow passive or assignment types in trips, for now.

			IF ai_Type = gc_Dispatch.ci_ItinType_Trip THEN

				IF lnva_Targets [ ll_Target ].of_IsPassive ( ) THEN
					ls_ErrorMessage += "~n(Request includes event types not yet supported in trips.)"
					li_Return = -1
					EXIT
				END IF

				IF lnva_Targets [ ll_Target ].of_IsAssignment ( ) THEN
					ls_ErrorMessage += "~n(Cannot perform operation on selected event types.)"
					li_Return = -1
					EXIT
				END IF

			ELSE

				//If both driver and tractor are assigned at the insertion point, routing of 
				//NewTrip and EndTrip events may not be allowed.  So, we need to see if there 
				//are any of these so we can reference it later.

				ls_Type = lnva_Targets [ ll_Target ].of_GetType ( )

				CHOOSE CASE ls_Type

				CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_EndTrip
					
					IF ls_FirstTripType = "" THEN
						ls_FirstTripType = ls_Type
					END IF

					ls_LastTripType = ls_Type

				END CHOOSE

				IF lb_EndTripPrior = TRUE THEN

					//Event from the prior pass was an end trip.  See if it's immediately
					//followed by a new trip.  If not, we need to flag the fact, because
					//if both driver and tractor are assigned at the insertion point, this
					//will not be allowed.

					IF ls_Type = gc_Dispatch.cs_EventType_NewTrip THEN
						//New trip immediately follows the end trip.
						//OK, and reset flag.
						lb_EndTripPrior = FALSE
					ELSE
						//Something other than a New Trip is following the end trip.
						//Flag this, because depending on the circumstances, this will
						//not be allowed, and flag the fact that there was at least one
						//additional target event after the Unlinked End Trip.
						lb_UnlinkedEndTrip = TRUE
						lb_TargetsAfterUnlinkedEndTrip = TRUE
					END IF

				ELSEIF ls_Type = gc_Dispatch.cs_EventType_EndTrip THEN

					//Flag that this was an end trip, for use in the next pass.
					lb_EndTripPrior = TRUE

				END IF

			END IF

			li_Temp = lds_Insertion.RowsMove ( ll_Row, ll_Row, le_Buffer, lds_Insertion, ll_InsertionRow, Primary! )
		ELSE
			ls_ErrorMessage += "~n(Could not resolve beo source -- Target Event " + String ( ll_Target ) + ", Pre-RM.)"
			li_Return = -1
			EXIT
		END IF

		//Find the new row number of the target, and set the insertion point as one row greater.
		//(This is needed because the row may have been in the insertion itinerary, and therefor skew
		//the row numbering when it's moved.)
		IF lnva_Targets [ ll_Target ].of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't Create*/ ) = 1 THEN
			IF le_Buffer = Primary! AND ll_Row > 0 THEN
				ll_InsertionRow = ll_Row + 1
			ELSE
				ls_ErrorMessage += "~n(Invalid beo buffer/row -- Target Event " + String ( ll_Target ) + ", Post-RM.)"
				li_Return = -1
				EXIT
			END IF
		ELSE
			ls_ErrorMessage += "~n(Could not resolve beo source -- Target Event " + String ( ll_Target ) + ", Post-RM.)"
			li_Return = -1
			EXIT
		END IF
		
		
//		<<*>> moved here from above on 9/15/05
		CHOOSE CASE ls_Type
			CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_EndTrip				
				////// IF a default site for NEW/END TRIPS are specified set it here. <<*>> 8/25/05
				IF IsNull ( lnva_Targets [ ll_Target ].of_GetSite () ) THEN
					
					lnv_Site = CREATE n_cst_setting_newtripendtripcompany
					lnv_Site.of_GetValue( lla_NewTripCompany  )
					IF UpperBound ( lla_newTripCompany ) > 0 THEN
						lnva_Targets[ ll_Target ].of_SetAllowfilterset( TRUE )
						lnva_Targets[ ll_Target ].of_Setsite( lla_newTripCompany[1] )
						lnva_Targets[ ll_Target ].of_SetAllowfilterset( FALSE )
					END IF
					
					DESTROY ( lnv_Site )
				END IF		
		END CHOOSE	
		

	NEXT


	//If we finished the loop with an End Trip, set the lb_UnlinkedEndTrip flag.

	IF lb_EndTripPrior = TRUE THEN

		lb_UnlinkedEndTrip = TRUE

	END IF

END IF


//Now that the targets are moved, identify the previous and following events.
//(The orginal "Previous Event" or "Following Event" may have been one of the events moved, 
//so we need to redetermine these.)

IF li_Return = 1 THEN

	//Identify the Previous Event, based on the position of the first target event
	//(There may not be a previous event -- Do we need any special verification??)

	IF lnva_Targets [ 1 ].of_GetSourceRow ( ll_FirstRow, le_Buffer, FALSE /*Don't Create*/ ) = 1 THEN
		IF le_Buffer = Primary! AND ll_FirstRow > 0 THEN
			lnv_PreviousEvent.of_SetSource ( lds_Insertion )
			lnv_PreviousEvent.of_SetSourceRow ( ll_FirstRow - 1 )
			IF lnv_PreviousEvent.of_HasSource ( ) = TRUE THEN
				lb_HasPrevious = TRUE
			END IF
		ELSE
			ls_ErrorMessage += "~n(Invalid beo buffer/row -- First Event, Post-RM.)"
			li_Return = -1
		END IF
	ELSE
		ls_ErrorMessage += "~n(Could not resolve beo source -- First Event, Post-RM.)"
		li_Return = -1
	END IF

	//Identify the Following Event, based on the position of the last target event
	//(There may not be a following event -- Do we need any special verification??)

	IF lnva_Targets [ ll_TargetCount ].of_GetSourceRow ( ll_LastRow, le_Buffer, FALSE /*Don't Create*/ ) = 1 THEN
		IF le_Buffer = Primary! AND ll_LastRow > 0 THEN
			lnv_FollowingEvent.of_SetSource ( lds_Insertion )
			lnv_FollowingEvent.of_SetSourceRow ( ll_LastRow + 1 )
			IF lnv_FollowingEvent.of_HasSource ( ) = TRUE THEN
				lb_HasFollowing = TRUE
			END IF
		ELSE
			ls_ErrorMessage += "~n(Invalid beo buffer/row -- Last Event, Post-RM.)"
			li_Return = -1
		END IF
	ELSE
		ls_ErrorMessage += "~n(Could not resolve beo source -- Last Event, Post-RM.)"
		li_Return = -1
	END IF

END IF


//Clear the routing assignments on the routed events.  (Note : This is NOT the same as of_UnassignAll, 
//which would strip just the associations/dissociations being performed by the event and carry those 
//changes forward.  This just clears any and all assignments, from this event only.  So, the event must
//already have had any associations/dissociations cleared from it by this point.  This is done with the
//call to of_UnassignAll, earlier.)

IF li_Return = 1 THEN

	FOR ll_Row = ll_FirstRow TO ll_LastRow

		IF lnv_Events.of_ClearRouting ( lds_Insertion, ll_Row, FALSE /*Don't Clear Times & Conf*/ ) = 1 THEN
			//OK
		ELSE
			ls_ErrorMessage += "~n(Could not clear current target event routing.)"
			li_Return = -1
			EXIT
		END IF

	NEXT

END IF


//Make the new routing assignments on the routed events, checking for conflicts.

IF li_Return = 1 THEN			//NEED TO CHECK EVENT TYPES!!!!!!!

	CHOOSE CASE ai_Type
	
	CASE gc_Dispatch.ci_ItinType_Trip    //NEED TO CHECK EVENT TYPES!!!!!!!
	
		for ll_Row = ll_FirstRow to ll_LastRow
			lnv_Events.of_AssignByIndex ( gc_Dispatch.ci_Assignment_Trip, al_Id, lds_Insertion, ll_Row, true, 0)
			//lds_Insertion.object.de_arrdate[ll_Row] = ???? //**Change This**
		next
	
		IF ll_FirstRow > 1 THEN
			lc_LowerLimit = lnv_Events.of_GetSequenceByIndex ( gc_Dispatch.ci_ItinType_Trip, al_Id, lds_Insertion, &
				ll_FirstRow - 1, Primary! )
		ELSE
			SetNull ( lc_LowerLimit )
		END IF
	
		IF ll_LastRow < lds_Insertion.RowCount ( ) THEN
			lc_UpperLimit = lnv_Events.of_GetSequenceByIndex ( gc_Dispatch.ci_ItinType_Trip, al_Id, lds_Insertion, &
				ll_LastRow + 1, Primary! )
		ELSE
			SetNull ( lc_UpperLimit )
		END IF
	
		CHOOSE CASE lnv_Events.of_SequenceRange ( lds_Insertion, ll_FirstRow, ll_LastRow, gc_Dispatch.ci_ItinType_Trip, &
			al_Id, lc_LowerLimit, lc_UpperLimit )
		CASE 1
			//OK
		CASE ELSE
			ls_ErrorMessage += "~n(Could not sequence event range -- trip routing.)"
			li_Return = -1
		END CHOOSE
	
	
	CASE ELSE		//NEED TO CHECK EVENT TYPES!!!!!!!
	
//		Commented for 3.5.0 since orig/term is going to be handled differently.  But, is any processing needed here? 

//		//Check that we're not violating Origination or Termination policy, by putting
//		//target events before the origination or after the termination.
//
//		IF ai_Type = gc_Dispatch.ci_ItinType_TrailerChassis OR &
//			ai_Type = gc_Dispatch.ci_ItinType_Container THEN
//	
//			if lstr_equip.eq_outside = "T" then
//				if ll_FirstRow < 2 then
//					ls_ErrorMessage = "The origination event must be the first event in an outside "+&
//						"equipment itinerary."
//					li_Return = -1
//
//				elseif lstr_equip.oe_term_event > 0 then
//					ll_Row = lds_Insertion.find("de_id = " + string(lstr_equip.oe_term_event), &
//						1, ll_FirstRow - 1)
//					if ll_Row > 0 then
//						ls_ErrorMessage = "The termination event must be the last event in an outside "+&
//							"equipment itinerary."
//						li_Return = -1
//					end if
//				end if
//			end if
//	
//		END IF

//
		IF li_Return = 1 THEN

			//Get the remainder at the beginning of the target range.	
			lnv_Events.of_GetRemainder ( lds_Insertion, ll_FirstRow - 1, ai_Type, al_Id, lla_Ids )

		END IF


		//If there are new trip and/or end trip events in what we're routing, we need to check 
		//whether both a driver and tractor are assigned at the insertion point -- if so, if the
		//first trip event being routed is an end trip and there are no events in the itinerary 
		//after the insertion point, the routing will be allowed, otherwise, it will not be allowed
		//because we will not be able to carry the dissociation forward.  (Could we find a way to 
		//do this?  Maybe call of_Assign for the end trip, even though the assignment is implicit, 
		//and let that do the carry-forward processing?

		IF li_Return = 1 AND ls_FirstTripType > "" THEN

			IF IsNull ( lla_Ids [ gc_Dispatch.ci_MinIndex_Driver ] ) OR &
				IsNull ( lla_Ids [ gc_Dispatch.ci_MinIndex_PowerUnit ] ) THEN

				//At least one of the two is null.  OK.

			ELSE

				CHOOSE CASE ls_FirstTripType

				CASE gc_Dispatch.cs_EventType_NewTrip

					ls_ErrorMessage = "You have requested to route a New Trip event into an "+&
						"existing trip in the itinerary where both driver and power unit have been assigned.  "+&
						"This is not permitted.  You must first close the existing trip with an End Trip."
					li_Return = -1

				CASE ELSE  //Should be gc_Dispatch.cs_EventType_EndTrip

					IF ( lb_TargetsAfterUnlinkedEndTrip ) OR &
						( lb_UnlinkedEndTrip AND lb_HasFollowing ) THEN

						ls_ErrorMessage = "Both driver and power unit have been assigned "+&
							"at the position you have indicated.  As a result, any End Trip "+&
							"events must be immediately followed by New Trip events, so the "+&
							"driver and tractor assignments can carry forward.  If your "+&
							"intention is to clear these assignments, you may then do so "+&
							"on the individual New Trip events."
						li_Return = -1

					END IF

				END CHOOSE

			END IF

		END IF


		IF li_Return = 1 THEN

			//Make the Assignments by taking the remainder we got at the beginning of the target range, 
			//and just setting it all the way through.
			
			lnv_Events.of_GetMinMaxIndex ( li_Min, li_Max )

			for li_Index = li_Min to li_Max
				for ll_Row = ll_FirstRow to ll_LastRow
					lnv_Events.of_AssignByIndex (li_Index, lla_Ids[li_Index], lds_Insertion, ll_Row, true, 0)
					lds_Insertion.object.de_arrdate[ll_Row] = ad_InsertionDate   //Scale!!
					//lds_Insertion.object.de_multi_list[ll_Row] = ls_MultiList  No longer appropriate.
				next
			next
	
			//Set the sequence values for the target range.
			
			for li_Index = li_Min to li_Max
				CHOOSE CASE lnv_Events.of_SequenceRange (lds_Insertion, ll_FirstRow, ll_LastRow, &
					lnv_Events.of_GetTypeForIndex (li_Index), lla_Ids[li_Index], &
					lds_Insertion, ll_FirstRow - 1, lds_Insertion, ll_LastRow + 1)
				CASE 1
					//OK
				CASE ELSE
					ls_ErrorMessage += "~n" + gc_Dispatch.cs_ErrorText_SequenceRange
					li_Return = -1  //Flag error, but continue the loop anyway.
				END CHOOSE
			next

		END IF
	

		IF li_Return = 1 THEN

			//Deal with actpos settings.
	
			lnv_Event.of_SetSource ( lds_Insertion )
			
			for ll_Row = ll_FirstRow to ll_LastRow
		
				//Condition added 3.0.00 to skip over passive types.
				//Additional condition added with dispatch changes to skip over assignment types,
				//since these are also now potentially in the target range.

				lnv_Event.of_SetSourceRow ( ll_Row )
				IF lnv_Event.of_IsPassive ( ) THEN
					CONTINUE
				ELSEIF lnv_Event.of_IsAssignment ( ) THEN
					CONTINUE
				END IF
		
				ll_CheckId = lds_Insertion.object.de_actpos[ll_Row]
				if lnv_AnyArray.of_FindLong(lla_Ids, ll_CheckId, 2, 9) > 0 then continue
				lds_Insertion.object.de_actpos[ll_Row] = 0
				lb_SelectionRequired = true
			next
			
			if lb_SelectionRequired then
	
				for li_Index = gc_Dispatch.ci_MinIndex_PowerUnit to gc_Dispatch.ci_MaxIndex_Container
					IF This.of_GetEquipmentInfo ( lla_Ids[li_Index], lstr_TestEquip ) > 0 THEN
						if pos("SNVFRKBC", lstr_TestEquip.eq_type) > 0 then
							li_SelectionCount ++
							lla_SelectionIds[li_SelectionCount] = lla_Ids[li_Index]
							lstr_SelectionList.strar[li_SelectionCount + 4] = gf_eqref(lstr_TestEquip.eq_type, lstr_TestEquip.eq_ref)
						end if
					END IF
				next
	
				if li_SelectionCount > 1 then
					for ll_Row = ll_FirstRow to ll_LastRow
		
						//Condition added 3.0.00 to skip over passive types.
						//Additional condition added with dispatch changes to skip over assignment types,
						//since these are also now potentially in the target range.

						lnv_Event.of_SetSourceRow ( ll_Row )
						IF lnv_Event.of_IsPassive ( ) THEN
							CONTINUE
						ELSEIF lnv_Event.of_IsAssignment ( ) THEN
							CONTINUE
						END IF
		
						if lds_Insertion.object.de_actpos[ll_Row] = 0 then
	
							//Build the message header for the selection dialog.
							lstr_SelectionList.strar[1] = "Equipment Selection - Event #" +&
								string(ll_Row - ll_FirstRow + 1)
	
							//Build the message text for the selection dialog.
							lstr_SelectionList.strar[2] = "Which equipment would you like to use for the "
	
							choose case lds_Insertion.object.de_event_type[ll_Row]
							case "P"
								lstr_SelectionList.strar[2] += "PICKUP"
							case "D"
								lstr_SelectionList.strar[2] += "DELIVERY"
							case else  //Unexpected event type
								ls_ErrorMessage += "~n(Unexpected event type, selection required.)"
								li_Return = -1
								EXIT
							end choose
	
							ls_CompanyName = lds_Insertion.object.co_name[ll_Row]
	
							if len(trim(ls_CompanyName)) > 0 then
								//Name is fine -- use it.
							else
								ls_CompanyName = "[UNSPECIFIED LOCATION]"
							end if
							lstr_SelectionList.strar[2] += " at " + ls_CompanyName + "?"
	
							//Set the selection default -- 0 first time through, last selection
							//on subsequent passes through the loop.
							lstr_SelectionList.strar[3] = string(li_SelectedIndex)

	
							
							
							For i = 1 TO 10 
								Yield ( ) 
							NEXT

							//Open the selection window.
							openwithparm(lw_Selection, lstr_SelectionList)
	
							//Get the selection response value.
							ls_Response = message.stringparm
	
							if len(ls_Response) > 0 then li_SelectedIndex = integer(left(ls_Response, len(ls_Response) - 1))
							if li_SelectedIndex > 0 and li_SelectedIndex <= li_SelectionCount then
								lds_Insertion.object.de_actpos[ll_Row] = lla_SelectionIds[li_SelectedIndex]
							else
								li_Return = 0  //Assume cancel, not error.  Return "User Cancel".
								EXIT
							end if
	
						end if
					next
	
				elseif li_SelectionCount = 1 then
					for ll_Row = ll_FirstRow to ll_LastRow
		
						//Condition added 3.0.00 to skip over passive types.
						//Additional condition added with dispatch changes to skip over assignment types,
						//since these are also now potentially in the target range.

						lnv_Event.of_SetSourceRow ( ll_Row )
						IF lnv_Event.of_IsPassive ( ) THEN
							CONTINUE
						ELSEIF lnv_Event.of_IsAssignment ( ) THEN
							CONTINUE
						END IF
		
						if lds_Insertion.object.de_actpos[ll_Row] = 0 then &
							lds_Insertion.object.de_actpos[ll_Row] = lla_SelectionIds[1]
					next

//				Commented for 3.5.0 -- this restriction will no longer apply.
//				else
//					ls_ErrorMessage = "There is no freight-carrying equipment assigned at the position you "+&
//						"have indicated."
//					li_Return = -1
				end if

			end if

		END IF
		
		/*  Neither Request Type currently has action associated
		
		//if request_type = ci_RouteRequest_Route then
			//No action needed.  But, we could...
			// check whether there are any ship seq violations
			// if its a trailer (or straight job, or container), is it the right trailer;  
			// 	are any of those selected already routed?
		
		//elseif request_type = ci_RouteRequest_ReRoute then
			//No action needed.  But, we could...
			// if any of those selected are hooks, drops, on.d., off.d., are they the only 
			// 	event selected
			//		do they contradict each other, eg. hook after drop, two od's, >3 hooks
			//		???do they cause any pus/dels to become unassigned
			// if they are pu's, dels, do they violate any ship_seqs
			//		???do they remain assigned to a trlr/sj/cntn
			// 	do they switch from one trlr to another, and if so, do they switch the entire grp
		//end if
		
		*/
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	//lds_Insertion.SaveAs ( "c:\test\route.xls", Excel!, TRUE )	
	lds_EventCache = This.of_GetEventCache ( )
	gf_rows_sync(lds_Insertion, ldw_Null, lds_EventCache, ldw_Null, filter!, false, false)

END IF


//Loop through the target range in lds_Insertion and examine each event for whether it should
//have any assignments made to it.  The actual evaluation of each event will happen against the
//cache, so we see the latest assignments as things get modified.  lds_Insertion will just give
//us the proper range and sequence of events to evaluate.

IF li_Return = 1 THEN

	//Initialize the beo's we'll be using here.
	lnv_Event.of_SetSource ( lds_Insertion )
	lnv_CacheEvent.of_SetSource ( lds_EventCache )
	

	//Loop through the target range.

	FOR ll_Row = ll_FirstRow to ll_LastRow

		lnv_Event.of_SetSourceRow ( ll_Row )

		//If the event is not an assignment event, there's no need to evaluate it -- it can't do anything.

		IF lnv_Event.of_IsAssignment ( ) = FALSE THEN
			CONTINUE
		END IF

		//Set up the CacheEvent for use below.

		ll_EventId = lnv_Event.of_GetId ( )
		lnv_CacheEvent.of_SetSourceId ( ll_EventId )


		CHOOSE CASE lnv_Event.of_GetType ( )

		CASE gc_Dispatch.cs_EventType_Drop, gc_Dispatch.cs_EventType_Dismount

			//Now, switch to using the cache events, since those will have the latest assignments
			//as things get modified.

			CHOOSE CASE lnv_CacheEvent.of_GetActiveAssignments ( lla_ActiveDrivers, lla_ActivePowerUnits, &
				lla_ActiveTrailerChassis, lla_ActiveContainers )

			CASE 1, 0
				//OK, evaluate this one.

			CASE ELSE  //-1, or unexpected return.
				CONTINUE

			END CHOOSE


			CHOOSE CASE lnv_CacheEvent.of_GetAssignments ( lla_Drivers, lla_PowerUnits, &
				lla_TrailerChassis, lla_Containers )

			CASE 1  //Unlike GetActiveAssignments, there is no 0 return.
				//OK, continue with the evaluation.

			CASE ELSE  //-1, or unexpected return
				CONTINUE

			END CHOOSE


			//If there's any containers assigned to the event that aren't getting dissociated,
			//dissociate them.

			IF UpperBound ( lla_Containers ) > UpperBound ( lla_ActiveContainers ) THEN

				li_Max = UpperBound ( lla_Containers )

				FOR li_Index = 1 TO li_Max

					IF UpperBound ( lla_ActiveContainers ) = 0 THEN

						//We didn't have any active, so whatever we've got should be added.

					ELSEIF lnv_CacheEvent.of_IsActiveInAssignment ( &
						gc_Dispatch.ci_ItinType_Container, lla_Containers [ li_Index ] ) THEN

						//This container was one of the active ones.  Skip it.
						CONTINUE

					END IF

					CHOOSE CASE This.of_Assign ( ll_EventId, gc_Dispatch.ci_ItinType_Container, &
						lla_Containers [ li_Index ], ad_InsertionDate )

					CASE 1
						//OK, assignment was successful.

					CASE -1
						//Assignment was not successful.  I'd like to relay an explanation of what
						//was attempted and why it failed.  But, I'm not going to fail over it.

					CASE ELSE
						//Unexpected return value.
						//Again, an relay of what was attempted and why it failed would be good, 
						//but again, no need to fail.

					END CHOOSE

				NEXT

			END IF


			//If we're dealing with a drop and there's any TrailerChassis assigned to the event
			//that aren't being dissociated, dissociate them.

			IF UpperBound ( lla_TrailerChassis ) > UpperBound ( lla_ActiveTrailerChassis ) AND &
				lnv_CacheEvent.of_IsDrop ( ) THEN

				li_Max = UpperBound ( lla_TrailerChassis )

				FOR li_Index = 1 TO li_Max

					IF UpperBound ( lla_ActiveTrailerChassis ) = 0 THEN

						//We didn't have any active, so whatever we've got should be added.

					ELSEIF lnv_CacheEvent.of_IsActiveInAssignment ( &
						gc_Dispatch.ci_ItinType_TrailerChassis, lla_TrailerChassis [ li_Index ] ) THEN

						//This TrailerChassis was one of the active ones.  Skip it.
						CONTINUE

					END IF

					CHOOSE CASE This.of_Assign ( ll_EventId, gc_Dispatch.ci_ItinType_TrailerChassis, &
						lla_TrailerChassis [ li_Index ], ad_InsertionDate )

					CASE 1
						//OK, assignment was successful.

					CASE -1
						//Assignment was not successful.  I'd like to relay an explanation of what
						//was attempted and why it failed.  But, I'm not going to fail over it.

					CASE ELSE
						//Unexpected return value.
						//Again, an relay of what was attempted and why it failed would be good, 
						//but again, no need to fail.

					END CHOOSE

				NEXT

			END IF

		END CHOOSE

	NEXT

END IF

// this will do the appropriate equipment assignments to
// the events we just routed
IF li_Return = 1 THEN
	THIS.of_AssessEquipmentAssignment ( lnva_Targets ) 
END IF

IF li_Return = -1 THEN

	This.ClearOFRErrors ( )
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )

END IF

lnv_AnyArray.of_Destroy ( lnva_Targets )
DESTROY lds_Insertion

DESTROY  lnv_PreviousEvent
DESTROY  lnv_FollowingEvent
DESTROY  lnv_Event 
DESTROY  lnv_CacheEvent

RETURN li_Return
end function

public function boolean of_isequipmentitinerary (readonly integer ai_type);//Returns:  TRUE if positively identified as Equipment Itinerary type, FALSE otherwise

Boolean	lb_Return = FALSE

CHOOSE CASE ai_Type

CASE 	gc_Dispatch.ci_ItinType_PowerUnit, &
		gc_Dispatch.ci_ItinType_TrailerChassis, &
		gc_Dispatch.ci_ItinType_Container

		lb_Return = TRUE

END CHOOSE

RETURN lb_Return
end function

public function integer of_getequipmentinfo (readonly long al_id, ref s_eq_info astr_equip);//Wrap of legacy function to simplify parameters.  Will attempt to return
//an s_eq_info structure for the requested id, checking the instance cache
//first, and the global cache second.

//Returns: 1 = Success, -1 = Failure
//(This is different from the service function, which returns a row value)

n_cst_EquipmentManager	lnv_EquipmentManager
s_eq_info	lstr_Equip
String		ls_Null

Integer	li_Return = 1

lstr_Equip.eq_id = al_Id
SetNull ( ls_Null )

IF lnv_EquipmentManager.of_Eq_Info ( This.of_GetEquipmentCache ( ), &
	ls_Null, ls_Null, lstr_Equip ) > 0 THEN

	//Got equipment info ok.

ELSE
	li_Return = -1

END IF

astr_Equip = lstr_Equip
RETURN li_Return
end function

public function integer of_seteventclipboard (long ala_eventclipboard[]);//Returns:  1, -1  (Only 1 is possible, at present)

n_cst_AnyArraySrv	lnv_AnyArray

lnv_AnyArray.of_GetShrinked ( ala_EventClipboard, "NULLS~tDUPES" )

ila_EventClipBoard = ala_EventClipboard

RETURN 1
end function

public function integer of_cleareventclipboard ();//Returns:  1, -1  (Only 1 is possible, at present)

Long	lla_EventClipboard[]

ila_EventClipboard = lla_EventClipboard

RETURN 1
end function

public function long of_copyeventclipboard (ref datastore ads_copy);//Returns: >=0 (The number of rows in the clipboard), -1 = Error

DataStore	lds_EventCache
n_cst_Dws	lnv_Dws
Long			ll_RowCount, &
				lla_EventClipboard[], &
				ll_ClipboardCount, &
				ll_Index, &
				ll_Row
dwBuffer		le_Buffer
n_cst_beo_Event	lnv_Event

Long			ll_Return = 0

lnv_Event = CREATE n_cst_beo_Event

IF ll_Return = 0 THEN

	lds_EventCache = This.of_GetEventCache ( )
	
	IF NOT IsValid ( lds_EventCache ) THEN
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	IF IsValid ( ads_Copy ) THEN
		ads_Copy.Reset ( )
	ELSEIF lnv_Dws.of_CreateDataStoreByDataObject ( cs_DataObject_Event, ads_Copy, TRUE ) = 1 THEN
		//Created OK
	ELSE
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	ll_ClipboardCount = This.of_GetEventClipboard ( lla_EventClipboard )
	lnv_Event.of_SetSource ( lds_EventCache )

	FOR ll_Index = 1 TO ll_ClipboardCount

		lnv_Event.of_SetSourceId ( lla_EventClipboard [ ll_Index ] )

		IF lnv_Event.of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't Create*/ ) = 1 THEN

			ll_RowCount ++
			lds_EventCache.RowsCopy ( ll_Row, ll_Row, le_Buffer, ads_Copy, ll_RowCount, Primary! )
			//Set Status to NotModified! ???

		ELSE
			ll_Return = -1   //Flag the error, but continue to populate the datastore

		END IF

	NEXT

END IF


IF ll_Return = 0 THEN

	ll_RowCount = ads_Copy.RowCount ( )

	IF ll_RowCount >= 0 THEN
		ll_Return = ll_RowCount
	ELSE
		ll_Return = -1
	END IF

END IF

DESTROY ( lnv_Event ) 

RETURN ll_Return
end function

public function long of_geteventclipboard (ref long ala_eventclipboard[]);//Returns:  >=0 : The number of events in the clipboard

Long	ll_Return

ala_EventClipboard = ila_EventClipboard
ll_Return = UpperBound ( ala_EventClipboard )

RETURN ll_Return
end function

public function integer of_retrieveevents (long ala_eventids[]);//Returns:  1 = Success, -1 = Error, -2 = Original value conflict

String	ls_WhereClause
n_cst_Sql	lnv_Sql

Long	ll_Null
Date	ld_Null

SetNull ( ll_Null )
SetNull ( ld_Null )

ls_WhereClause = " WHERE de_id " + lnv_Sql.of_MakeInClause ( ala_EventIds )

RETURN This.of_RetrieveEvents ( ll_Null, ld_Null, ld_Null, ls_WhereClause )
end function

public function long of_filteritinerary (datastore ads_target, integer ai_type, long al_id, date ad_min, date ad_max);//Returns : >= 0 (The number of rows in the target, once filtered), -1 = Error
//Target is filtered (and sorted) to the requested itinerary range.
//No screening of the parameters is performed -- it is assumed the request is valid.
//It is assumed that the data to support the request is already loaded in ads_Target.

Long	ll_Return = 0


IF ll_Return = 0 THEN

	IF NOT IsValid ( ads_Target ) THEN
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	ads_Target.SetFilter ( This.of_GetItineraryFilter ( ai_Type, al_Id, ad_Min, ad_Max ) )
	ads_Target.SetSort ( This.of_GetItinerarySort ( ai_Type, al_Id ) )
	
	ads_Target.Filter ( )
	ads_Target.Sort ( )
	
	ll_Return = ads_Target.RowCount ( )
	
	IF ll_Return >= 0 THEN
		//OK
	ELSE
		ll_Return = -1
	END IF

END IF


RETURN ll_Return
end function

public function long of_filteritinerary (integer ai_type, long al_id, date ad_min, date ad_max);//Overload to perform filtering, for the cache.

RETURN This.of_FilterItinerary ( This.of_GetEventCache ( ), ai_Type, al_Id, ad_Min, ad_Max )
end function

public function integer of_newevents (string asa_types[], ref long ala_ids[]);Long	lla_NoSites[]

Return This.of_NewEvents(asa_Types, lla_NoSites, ala_Ids)
end function

public function integer of_unassign (long al_baseevent, integer ai_targettype, long al_targetid);RETURN 1
end function

public function integer of_unassignall (long ala_baseevents[]);return 1
end function

public function integer of_remove (long ala_eventids[]);RETURN -1
end function

public function integer of_assign (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle);//Returns : 1, -1 , -2 = validation failed   
//					
//Note:  li_Return is set to 99 temporarily if the request is forwarded to of_AssignByReroute and succeeds, 
//			so that intervening processing is skipped, but it is set back to 1 at the end of the script

DataStore	lds_Cache, &
				lds_Base, &
				lds_Target, &
				lds_Lookback
DataWindow	ldw_Null  //For use with calls to gf_Rows_Sync

n_cst_beo_Event	lnv_Event, &
						lnv_BaseEvent, &
						lnv_AfterEvent, &
						lnv_WorkEvent
						
n_cst_Events		lnv_Events
n_cst_beo_Equipment2			lnv_Equipment
n_cst_beo_EquipmentLease2	lnv_EquipmentLease

Date		ld_AssignmentDate, &
			ld_Null, &
			ld_Lookback_Date
Long		ll_FirstBaseRow, &
			ll_LastBaseRow, &
			ll_BaseCount, &
			ll_BeforeRow, &
			ll_AfterRow, &
			ll_FirstTargetRow, &
			ll_LastTargetRow, &
			ll_TargetCount, &
			lla_Ids[], &
			ll_Row, &
			ll_CurrentSite, &
			ll_PreviousSite, &
			lla_Drivers[], &
			lla_Tractors[], &
			lla_TrailerChassis[], &
			lla_Containers[], &
			ll_ChassisId, &
			ll_PossibleOriginationEvent, &
			ll_PossibleTerminationEvent, &
			ll_PossibleClearedTerminationEvent, &
			lla_Empty[], &
			lla_Confirmed[], &
			ll_ConfirmedCount, &
			ll_Lookback_BaseId, &
			ll_Lookback_Count, &
			ll_DriverId, &
			ll_TractorId
String	ls_EventType, &
			ls_MultiList, &
			ls_Work, &
			ls_SiteMessage, &
			ls_Lookback_Find
Boolean	lb_Association = TRUE, &
			lb_DissociatedInBase, &
			lb_Continue, &
			lb_PossibleOrigTermChanges, &
			lb_Lookback, &
			lb_Lookback_Found //, &
//			lb_DissociatedInTarget, &
//			lb_ChangesInTarget
Integer	li_Result, &
			li_Pass, &
			li_Lookback_BaseType, &
			li_Lookback_Index
n_cst_OFRError		lnv_Error, &
						lnva_Errors[]

String	ls_ErrorMessage = "Could not process request."

Integer	li_Return = 1

SetNull ( ld_Null )
SetNull ( ll_ChassisId )	//If we're assigning a container and it turns out we should assign
									//a chassis with it, this will be set to the chassis id.

lnv_Equipment = CREATE n_cst_beo_equipment2
lnv_EquipmentLease =  CREATE n_cst_beo_EquipmentLease2
lnv_Event = CREATE n_cst_beo_Event
lnv_AfterEvent = CREATE n_cst_beo_Event
lnv_BaseEvent = CREATE n_cst_beo_Event
lnv_WorkEvent = CREATE n_cst_beo_Event

SetNull ( ll_PossibleOriginationEvent )
SetNull ( ll_PossibleTerminationEvent )
SetNull ( ll_PossibleClearedTerminationEvent )

lds_Cache = This.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_Cache )
lnv_Event.of_SetSourceId ( al_BaseEvent )  //Note:  This, along with al_BaseEvent, may be changed by Lookback processing.

//Get ld_AssignmentDate in a clean form, stripping off any unintended time component.
ld_AssignmentDate = Date ( DateTime ( lnv_Event.of_GetDateArrived ( ) ) )

ll_DriverId = lnv_Event.of_GetDriverId ( )
ll_TractorId = lnv_Event.of_GetTractorId ( )



/////NEW in 3.6.b3


IF li_Return = 1 THEN

	IF lnv_Event.of_IsAssigned ( ai_TargetType, al_TargetId ) THEN

		//The requested target is already present on the event.

		//Nothing special we can do here.  Flow through and try processing the request normally.

	ELSEIF ai_TargetType = gc_Dispatch.ci_ItinType_Driver AND NOT IsNull ( ll_DriverId ) THEN

		//A driver is already assigned.  Nothing special we can do here.  (Reject request now?? Not sure about dissoc.)

	ELSEIF ai_TargetType = gc_Dispatch.ci_ItinType_PowerUnit AND NOT IsNull ( ll_TractorId ) THEN

		//A power unit is already assigned.  Nothing special we can do here.  (Reject request now?? Not sure about dissoc.)


	ELSE   //(the requested target is not already present on the event)

		//A tractor can only be "assigned" via a new trip, although it can be active in the
		//assginment on a Hook/Mount.  However, with Hook/Mount, the TrailerChassis/Containers
		//are "assigned".  So, with respect to tractor, we are only concerned with NewTrip, below.

		CHOOSE CASE ai_TargetType

		CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit

			CHOOSE CASE lnv_Event.of_GetType ( )

			CASE gc_Dispatch.cs_EventType_NewTrip
				//Association can be made on this event.  No need to look back.

			CASE ELSE
				
				IF IsNull ( ll_DriverId ) AND IsNull ( ll_TractorId ) THEN
					
					//Event is routed to either a trailer or container itinerary.  In this scenario,
					//we are going to see if the range the event is in (a Hook-Drop range if event
					//is currently routed to a trailer, a Hook/Mount-Dismount/Drop range if event is 
					//currently routed to a container) can be routed to the Driver or PowerUnit itin
					//requested in Target Type & ID, and then the trailer or container that the event
					//is currently routed to reassigned.  
					
					This.ClearOFRErrors ( )
					
					CHOOSE CASE This.of_AssignByReroute( ai_BaseType, al_BaseId, al_BaseEvent, ai_TargetType, &
							al_TargetId, ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle )
							
					CASE 1	//Success
						li_Return = 99  //Will be set back to 1 later, but we need to skip intervening processing
						
					CASE 0	//User cancelled
						ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
							"as part of the assignment request was cancelled.  This cancels the assignment request."
						li_Return = -1   //Return codes for this function are only 1, -1
						
					CASE -1	//Error

						IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
							ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
						END IF
				
						IF Len ( ls_ErrorMessage ) > 0 THEN
							//OK
						ELSE
							ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
								"as part of the assignment request was unsuccessful."
						END IF
				
						ls_ErrorMessage += "~n~nThe requested assignment was not performed."
						li_Return = -1
						
						
					CASE -2	//of_AssignByReroute determined that there is no special handling appropriate.
						//This was the only hope for this scenario.  Fail.  
						
						ls_ErrorMessage += "~n(The assignment would have to be performed by rerouting events to the "+&
							"driver/tractor itinerary, but this is not possible in this routing situation.)"
						li_Return = -1
						
					CASE -3 // the assignment validation failed
						ls_ErrorMessage = "Assignment Validation failed" // we will get any errors from the validation object
						li_Return = -2										// But just in case we miss a call
						
					CASE ELSE	//Unexpected return
						ls_ErrorMessage += "~n(An attempt to reroute events from the trailer or container itinerary "+&
							"as part of the assignment request produced an unexpected return code.)"
						li_Return = -1
						
					END CHOOSE
					
				ELSE   //This is the logic that was here prior to 3.9.00
				
					lb_Lookback = TRUE
					ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_NewTrip + "'"
					
				END IF

			END CHOOSE

		CASE gc_Dispatch.ci_ItinType_TrailerChassis

			CHOOSE CASE lnv_Event.of_GetType ( )

			CASE gc_Dispatch.cs_EventType_Hook
				//Association can be made on this event.  No need to look back.

			CASE ELSE
				lb_Lookback = TRUE
				ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'"

			END CHOOSE

		CASE gc_Dispatch.ci_ItinType_Container

			CHOOSE CASE lnv_Event.of_GetType ( )

			CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
				//Association can be made on this event.  No need to look back.

			CASE ELSE
				lb_Lookback = TRUE
				ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'" + " OR " +&
					"de_event_type = '" + gc_Dispatch.cs_EventType_Mount + "'"

			END CHOOSE

		CASE ELSE	//Unexpected value

			//Just try to process the request as normal in case something below can handle this.

		END CHOOSE

	END IF


	IF lb_Lookback = TRUE THEN

		IF NOT IsNull ( ll_TractorId ) THEN

			li_Lookback_BaseType = gc_Dispatch.ci_ItinType_PowerUnit
			ll_Lookback_BaseId = ll_TractorId

		ELSEIF NOT IsNull ( ll_DriverId ) THEN

			li_Lookback_BaseType = gc_Dispatch.ci_ItinType_Driver
			ll_Lookback_BaseId = ll_DriverId

		ELSE

			//No frame of reference to look back with.  Cancel the Lookback attempt.
			lb_Lookback = FALSE

		END IF

	END IF

END IF


IF li_Return = 1 AND lb_LookBack = TRUE THEN

	FOR li_Lookback_Index = 1 TO 3

		CHOOSE CASE li_LookBack_Index

		CASE 1

			ld_Lookback_Date = ld_AssignmentDate	//Just look at the day the event is on

		CASE 2

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -3 )  //Look back 3 days

		CASE 3

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -7 )  //Look back 7 days

		END CHOOSE


		CHOOSE CASE This.of_RetrieveItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, ld_AssignmentDate, FALSE /*Don't need Prior*/ )
		
		CASE 1
			//Retrieved OK
		
		CASE -1
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (L)"
			li_Return = -1
			EXIT  //Exit the Lookback loop
	
		CASE -2
			ls_ErrorMessage = "A check with the database indicates that information needed "+&
				"to process this request has changed since your last save.  You should attempt "+&
				"to save now, before continuing.  (L)"
			li_Return = -1
			EXIT  //Exit the Lookback loop
	
		CASE ELSE  //Unexpected return value.
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (L)"
			li_Return = -1
			EXIT  //Exit the lookback loop
	
		END CHOOSE


		IF li_Lookback_Index = 1 THEN  //Looking at the same day the target event is on.

			ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_AssignmentDate, &
				ld_AssignmentDate, lds_Lookback )

			IF ll_Lookback_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookback loop
			END IF


			//Find the assignment event in the lookback itinerary datastore.
			
			lnv_WorkEvent.of_SetSource ( lds_Lookback )
			lnv_WorkEvent.of_SetSourceId ( al_BaseEvent )
		
			//Try to find a source row in the primary buffer only.
			ll_Row = lnv_WorkEvent.of_GetSourceRow ( )
		
			IF ll_Row > 0 THEN
				//OK
			ELSE
				ls_ErrorMessage += "~n(Could not identify assignment row.)  (L)"
				li_Return = -1
				EXIT //Exit the lookback loop
			END IF


			IF ll_Row > 1 THEN

				ll_Row = lds_Lookback.Find ( ls_Lookback_Find, ll_Row - 1, 1 )  //Search backwards, find the first eligible row.

				CHOOSE CASE ll_Row

				CASE IS > 0

					lnv_WorkEvent.of_SetSourceRow ( ll_Row )
					al_BaseEvent = lnv_WorkEvent.of_GetId ( )
					lb_Lookback_Found = TRUE
					EXIT  //Now, try to process the assignment on the new BaseEvent

				CASE 0

					//No eligible row found, continue on in the loop to look further backwards

				CASE ELSE

					ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
					li_Return = -1
					EXIT  //Exit the lookback loop

				END CHOOSE

			//ELSE

				//The BaseEvent row is the first row on the day.
				//Continue on in the loop to look further backwards.

			END IF

		ELSE

			//We're looking back prior to the day the originally requested event is on.

			//Get everything from the lookback date to the day before the originally requested event is on.

			ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, &
				RelativeDate ( ld_AssignmentDate, -1 ), lds_Lookback )

			IF ll_Lookback_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookback loop
			END IF


			IF ll_Lookback_Count > 0 THEN

				ll_Row = lds_Lookback.Find ( ls_Lookback_Find, ll_Lookback_Count, 1 )  //Search backwards, find the first eligible row.

				CHOOSE CASE ll_Row

				CASE IS > 0

					lnv_WorkEvent.of_SetSourceRow ( ll_Row )
					al_BaseEvent = lnv_WorkEvent.of_GetId ( )
					lb_Lookback_Found = TRUE

					//  ****DO WE NEED TO DO ANYTHING TO ad_InsertionDate IN THIS CASE???******

					EXIT  //Now, try to process the assignment on the new BaseEvent

				CASE 0

					//No eligible row found, continue on in the loop to look further backwards, 
					//or, if this is the last pass, finish the loop unsuccessfully

				CASE ELSE

					ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
					li_Return = -1
					EXIT  //Exit the lookback loop

				END CHOOSE

			//ELSE

				//Nothing to search.  Continue on in the loop to look further backwards, 
				//or, if this is the last pass, finish the loop unsuccessfully

			END IF

		END IF

	NEXT  //li_Lookback_Index


	IF li_Return = 1 THEN

		IF lb_Lookback_Found = TRUE THEN
			//OK.  Point lnv_Event at the new BaseEvent we've identified.
			lnv_Event.of_SetSourceId ( al_BaseEvent )
		ELSE
			//No eligible event was found.
			ls_ErrorMessage += "~n(No events in the prior week were capable of making the assignment requested.)"
			li_Return = -1
		END IF

	END IF

END IF


/////End of NEW section in 3.6.b3


//If the base type and id weren't passed in, determine them from the event.
//Note : If this turns out right, I may eliminate these parameters entirely.

IF li_Return = 1 AND IsNull ( ai_BaseType ) AND IsNull ( al_BaseId ) THEN

	lnv_Event.of_ClearErrors ( )

	CHOOSE CASE lnv_Event.of_GetBaseForAssignment ( ai_BaseType, al_BaseId, ai_TargetType, &
		al_TargetId, TRUE /*Assignment Request*/ )

	CASE 1
		//OK

	CASE ELSE

		ls_Work = lnv_Event.of_GetErrorString ( )

		IF Len ( ls_Work ) > 0 THEN
			ls_ErrorMessage = ls_Work
		ELSE
			ls_ErrorMessage += "~n(Unspecified error evaluating request in of_GetBaseForAssignment.)"
		END IF

		li_Return = -1

	END CHOOSE

END IF


//Retrieve the base itinerary from the assignment point forward, with prior event 
//(Actually, prior event wouldn't be needed if we already have the prior event on the same day -- 
//should we check for that?)

IF li_Return = 1 THEN

	CHOOSE CASE This.of_RetrieveItinerary ( ai_BaseType, al_BaseId, ld_AssignmentDate, ld_Null, TRUE /*Needs Prior*/ )
	
	CASE 1
		//Retrieved OK
	
	CASE -1
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (B)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "A check with the database indicates that information needed "+&
			"to process this request has changed since your last save.  You should attempt "+&
			"to save now, before continuing.  (B)"
		li_Return = -1

	CASE ELSE  //Unexpected return value.
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (B)"
		li_Return = -1

	END CHOOSE

END IF


li_Pass = 0

DO WHILE li_Return = 1 AND li_Pass < 2 //li_Pass will be =0 here 1st time thru, =1 2nd time

	li_Pass ++

	//If this is Pass 2, Re-initialize values that may have been set on the previous pass.

	IF li_Pass = 2 THEN

		ll_BaseCount = 0
		ll_FirstBaseRow = 0
		ll_TargetCount = 0
		ll_BeforeRow = 0
		ll_AfterRow = 0
		lla_Ids = lla_Empty
		ll_ConfirmedCount = 0
		lla_Confirmed = lla_Empty
		lnv_BaseEvent.of_ClearSource ( )
		lnv_AfterEvent.of_ClearSource ( )
		lnv_WorkEvent.of_ClearSource ( )

	END IF

	//Note : ll_Confirmed count and lla_Confirmed will be used to track confirmed events THAT MUST BE
	//UNCONFIRMED in order to complete the processing.  This may or may not be the absolute number of 
	//confirmed events.


	//Copy the base itinerary out to a datastore so we can work with it.
	
	IF li_Return = 1 THEN
	
		//Copy everything we've got for the base id.  We'll have everything from the prior event forward,
		//but we may have a discontinuous jumble of things prior to that.
	
		ll_BaseCount = This.of_CopyItinerary ( ai_BaseType, al_BaseId, ld_Null, ld_Null, lds_Base )
	
		IF ll_BaseCount = -1 THEN
			ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (B)"
			li_Return = -1
		ELSE
			lnv_WorkEvent.of_SetSource ( lds_Base )
		END IF
	
	END IF


	//Find the assignment event in the base itinerary datastore.
	
	IF li_Return = 1 THEN
	
		lnv_BaseEvent.of_SetSource ( lds_Base )
		lnv_BaseEvent.of_SetSourceId ( al_BaseEvent )
	
		//ll_FirstBaseRow = lds_Base.Find ( "de_id = " + String ( al_BaseEvent ), 1, ll_BaseCount )
	
		//Try to find a source row in the primary buffer only.
		ll_FirstBaseRow = lnv_BaseEvent.of_GetSourceRow ( )
	
		IF ll_FirstBaseRow > 0 THEN
			//OK
		ELSE
			ls_ErrorMessage += "~n(Could not identify assignment row.)  (B)"
			li_Return = -1
		END IF
	
	END IF


	//Evaluate the assignment event.  (Only necessary on the first pass)
	
	IF li_Return = 1 AND li_Pass = 1 THEN
	
		ls_EventType = lds_Base.Object.de_Event_Type [ ll_FirstBaseRow ]
	
		IF lnv_Events.of_IsTypeAssignment ( ls_EventType ) THEN
	
			IF lnv_Events.of_IsTypeDeliverGroup ( ls_EventType ) THEN
				lb_Association = FALSE
			END IF
	
		ELSE
	
			ls_ErrorMessage = "The requested event is not an assignment event."
			li_Return = -1
	
		END IF
	
	END IF
	
	
	//Retrieve the target itinerary from the assignment point forward, with prior event 
	//(Only necessary on first pass)
	//(Actually, prior event wouldn't be needed if we already have the prior event on the same day -- 
	//should we check for that?).  (We don't need the target if this is a dissociation, since the
	//target is already part of the base.)
	
	IF li_Return = 1 AND lb_Association = TRUE AND li_Pass = 1 THEN
	
		CHOOSE CASE This.of_RetrieveItinerary ( ai_TargetType, al_TargetId, ld_AssignmentDate, ld_Null, TRUE /*Needs Prior*/ )
		
		CASE 1
			//Retrieved OK
		
		CASE -1
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (T)"
			li_Return = -1
	
		CASE -2
			ls_ErrorMessage = "A check with the database indicates that information needed "+&
				"to process this request has changed since your last save.  You should attempt "+&
				"to save now, before continuing.  (T)"
			li_Return = -1
	
		CASE ELSE  //Unexpected return value.
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (T)"
			li_Return = -1
	
		END CHOOSE
	
	END IF


	//Copy the target itinerary out to a datastore so we can work with it.
	//(We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		//Copy everything we've got for the target id.  We'll have everything from the prior event forward,
		//but we may have a discontinuous jumble of things prior to that.
	
		ll_TargetCount = This.of_CopyItinerary ( ai_TargetType, al_TargetId, ld_Null, ld_Null, lds_Target )
	
		IF ll_TargetCount = -1 THEN
			ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (T)"
			li_Return = -1
		END IF
	
	END IF


	//Find the insertion point in the target itinerary datastore.
	//(We don't need this if this is a dissociation.)
	
	//If it's before the first row (or there are no rows), ll_AfterRow should be set to 0.
	//If it's after the last row (or there are no rows), ll_BeforeRow should be set to null.
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
	
		CHOOSE CASE ai_InsertionStyle
	
		CASE gc_Dispatch.ci_InsertionStyle_Assignment
	
			li_Result = lnv_Events.of_GetInsertionPoint ( lds_Base, ai_BaseType, al_BaseId, al_BaseEvent, &
				lds_Target, ai_TargetType, al_TargetId, ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle, &
				ll_BeforeRow /*Ref*/, ls_Work /*Gets Error Text*/ )
	
		CASE ELSE
	
			li_Result = lnv_Events.of_GetInsertionPoint ( lds_Target, ai_TargetType, al_TargetId, &
				ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle, ll_BeforeRow /*Ref*/, &
				ls_Work /*Gets Error Text*/ )
	
		END CHOOSE
	
	
		CHOOSE CASE li_Result
	
		CASE 1
	
			//ll_BeforeRow should be > 0, based on success of of_GetInsertionPoint
	
			IF ll_BeforeRow > ll_TargetCount THEN
	
				//Note : If there are no rows, we will come here, because ll_BeforeRow will be 1 and
				//ll_TargetCount will be 0.
	
				ll_AfterRow = ll_TargetCount
				SetNull ( ll_BeforeRow )
	
			ELSEIF ll_BeforeRow > 0 THEN
	
				ll_AfterRow = ll_BeforeRow - 1
	
			ELSE
				ls_ErrorMessage += "~n(Unexpected insertion row value returned from of_GetInsertionPoint.)"
				li_Return = -1
	
			END IF
	
		CASE -1
	
			ls_ErrorMessage = ls_Work
			li_Return = -1
	
			//Note : If ai_InsertionStyle = ci_InsertionStyle_EmptyDay and the day was not empty, 
			//the message will come back with "(IPRQ)" in it.  This will be passed along here, and
			//can be checked by the calling script to see if that was the problem.
	
		CASE ELSE
	
			ls_ErrorMessage += "~n(Unexpected return error for of_GetInsertionPoint.)"
			li_Return = -1
	
		END CHOOSE
	
	END IF


	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		//These two conditions are not mutually exclusive.  They could both be true.  But, I think it's 
		//sufficient to check one of them.  Or, neither of them might be true, in which case there's
		//no date conflict, so we're ok.
	
		IF ll_BeforeRow <= ll_TargetCount AND ll_BeforeRow > 0 THEN
	
			//We've got an actual row for ll_BeforeRow, so make sure that it falls on or after the 
			//assignment date, as a cross-check.
	
			IF DaysAfter ( ld_AssignmentDate, lds_Target.Object.de_ArrDate [ ll_BeforeRow ] ) >= 0 THEN
				//Insertion point is on or after the assignment date -- we're ok.
			ELSE
				//Insertion point is before the assignment date -- we're not ok.
				ls_ErrorMessage += "~n(Attempting to insert before an event routed prior to the assignment date.)"
				li_Return = -1
			END IF
	
		ELSEIF ll_AfterRow <= ll_TargetCount AND ll_AfterRow > 0 THEN
	
			//We've got an actual row for ll_AfterRow, so make sure that it falls on or before the 
			//assignment date, as a cross-check.
	
			IF DaysAfter ( ld_AssignmentDate, lds_Target.Object.de_ArrDate [ ll_AfterRow ] ) <= 0 THEN
				//Insertion point is on or before the assignment date -- we're ok.
			ELSE
				//Insertion point is after the assignment date -- we're not ok.
				ls_ErrorMessage += "~n(Attempting to insert after an event routed later than the assignment date.)"
				li_Return = -1
			END IF
	
		END IF
	
	END IF


	//Set up the lnv_AfterEvent beo.  (We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE AND ll_AfterRow > 0 THEN
	
		lnv_AfterEvent.of_SetSource ( lds_Target )
		lnv_AfterEvent.of_SetSourceRow ( ll_AfterRow )
	
	END IF


	//Get the remainder at the insertion point in the target itinerary.
	//(We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		IF lnv_Events.of_GetRemainder ( lds_Target, ll_AfterRow, ai_TargetType, al_TargetId, lla_Ids ) = -1 THEN
			li_Return = -1
		END IF
	
	END IF


	//Check whether the assignment conflicts with existing assignments at the insertion point in the target.
	//(We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		//***Convert these references to use the new Constants***
	
		CHOOSE CASE ai_TargetType
	
		CASE gc_Dispatch.ci_ItinType_Driver
	
			IF NOT IsNull ( lla_Ids [2] ) THEN
				ls_ErrorMessage += "The driver is already assigned to a power unit at the position you have indicated."
				li_Return = -1
			END IF
	
		CASE gc_Dispatch.ci_ItinType_PowerUnit
	
			IF NOT IsNull ( lla_Ids [1] ) THEN
				ls_ErrorMessage += "The power unit is already assigned to a driver at the position you have indicated."
				li_Return = -1
			END IF
	
		CASE ELSE
	
			IF NOT ( IsNull ( lla_Ids [ 1 ] ) AND IsNull ( lla_Ids [ 2 ] ) ) THEN
				ls_ErrorMessage += "The equipment you've requested is already assigned to a driver and/or power unit "+&
					"at the position you have indicated."
				li_Return = -1
			END IF
	
		END CHOOSE
	
	END IF
	
	
	//*****************************  NEW SECTION 3.9.00
	
	
	IF li_Return = 1 AND ( ai_TargetType = gc_Dispatch.ci_ItinType_TrailerChassis OR &
		ai_TargetType = gc_Dispatch.ci_ItinType_Container ) AND &
		DaysAfter ( ad_InsertionDate, lnv_AfterEvent.of_GetDateArrived ( ) ) = 0 THEN
		
		IF lnv_AfterEvent.of_GetDriverId ( ) > 0 OR lnv_AfterEvent.of_GetTractorId ( ) > 0 THEN  
			
			//The suggested insertion point immediately follows an event that's routed to a driver or tractor.
			//This is not a candidate for of_AssignByReroute.  We're looking for "loose events" at the end of
			//the trailer or container itinerary (events that are routed only to the trailer or container, with
			//no driver/tractor assigned.)
		
		ELSE
			
			//Unlike the other of_AssignByReroute, where the base was already a Trailer or Container itin 
			//and the target was a Driver or Tractor, here we have the reverse -- a base of Driver or Tractor, 
			//and a target of trailer or container, and we're going to HANDLE this by flip-flopping and requesting
			//an of_AssignByReroute on the AfterEvent in the Trailer/Container itin, with the driver or tractor
			//being assigned.

			This.ClearOFRErrors ( )

			CHOOSE CASE This.of_AssignByReroute ( ai_TargetType, al_TargetId, lnv_AfterEvent.of_GetId ( ), &
					ai_BaseType, al_BaseId, ad_InsertionDate, al_BaseEvent, gc_Dispatch.ci_InsertionStyle_After )
					
					//Using gc_Dispatch.ci_InsertionStyle_After signals of_AssignByReroute that it should
					//use the Hook or Mount in al_BaseEvent and insert itself into the driver / tractor 
					//itinerary immediately after that event.
					
			CASE 1	//Success
				li_Return = 99  //Will be set back to 1 later, but we need to skip intervening processing
				
			CASE 0	//User cancelled
				ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
					"as part of the assignment request was cancelled.  This cancels the assignment request."
				li_Return = -1   //Return codes for this function are only 1, -1
				
			CASE -1	//Error

				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
					ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
				END IF
		
				IF Len ( ls_ErrorMessage ) > 0 THEN
					//OK
				ELSE
					ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
						"as part of the assignment request was unsuccessful."
				END IF
		
				ls_ErrorMessage += "~n~nThe requested assignment was not performed."
				li_Return = -1
				
				
			CASE -2	//of_AssignByReroute determined that there is no special handling appropriate, that the
						//request should be processed conventionally.
						
				//Do not change return code.  Allow processing to continue normally.
				
			CASE -3 // the assignment validation failed
						ls_ErrorMessage = "Assignment Validation failed." // we will get any errors from the validation object
																						// but just in case we miss a call
						li_Return = -2
						
						
						
			CASE ELSE	//Unexpected return
				ls_ErrorMessage += "~n(An attempt to reroute events from the trailer or container itinerary "+&
					"as part of the assignment request produced an unexpected return code.)"
				li_Return = -1
				
			END CHOOSE
	
		END IF
		
	END IF
	
	
	//*****************************  END NEW SECTION 3.9.00


	//Make the actual changes to the event that performs the association (or dissociation).
	
	IF li_Return = 1 THEN
	
		IF lnv_Events.of_Assign ( lds_Base, ll_FirstBaseRow, ai_TargetType, al_TargetId ) = 1 THEN
			//OK
		ELSE
			ls_ErrorMessage = "The requested assignment is invalid."
			li_Return = -1
		END IF
	
	END IF


	//Carry the assignment forward and make adjustments to the events that follow.
	//Stop when the assignment change no longer has forward impact.
	
	IF li_Return = 1 THEN
	
		ll_LastBaseRow = ll_FirstBaseRow
	
		FOR ll_Row = ll_FirstBaseRow + 1 TO ll_BaseCount

			IF lb_Association = FALSE THEN

				lnv_WorkEvent.of_SetSourceRow ( ll_Row )

				IF lnv_WorkEvent.of_IsConfirmed ( ) = FALSE THEN
					//OK
				ELSE
					ll_ConfirmedCount ++
					lla_Confirmed [ ll_ConfirmedCount ] = lnv_WorkEvent.of_GetId ( )
				END IF

			END IF

	
			lnv_Events.of_GetRemainder ( lds_Base, ll_Row - 1, ai_BaseType, al_BaseId, lla_Ids )
	
			IF lnv_Events.of_Adjust ( lds_Base, ll_Row, ai_BaseType, al_BaseId, lla_Ids, &
				ai_TargetType, al_TargetId, lb_Association, lb_DissociatedInBase ) = 1 THEN
				//OK
			ELSE
				li_Return = -1
				EXIT
			END IF
	
			ll_LastBaseRow = ll_Row
	
			IF lb_DissociatedInBase = TRUE THEN
	
				//If this is an association, of_Adjust unassigned the thing we're assigning.
	
				//If this is a dissociation, of_Adjust has determined that the event we just processed
				//formerly performed the same dissociation.
	
				//Either way, we can stop now.
	
				EXIT
	
			END IF
	
		NEXT
	
	END IF


	IF li_Return = 1 AND lb_Association AND lb_DissociatedInBase = FALSE AND ll_BeforeRow > 0 THEN
	
	// The equipment / driver we're assigning didn't get dissociated by any of the base events, and there's
	//	events after the intertion point in the target itinerary.
	
	//	I originally thought we'd allow this, but it's complicated both in terms of of_Adjust processing, and
	// in terms of applying the sequence #s to whatever the target has inherited from the base.  There's also
	// multi-day issues to contend with.  So, I think the best policy for now is to disallow it.  If the user
	// wants to bring those target events over, they'd have to re-route them to the base using the clipboard,
	// then make the assignment.  Perhaps we could offer some help with that by remembering which piece of
	// equipment they were working with, and having it readily available to the assignment window as a selection.
	
	//	The commented code below did work, for the limited amount I had tested it, but it did not handle multi-day
	//	issues or sequence # assignments.
	
		ls_ErrorMessage = "The equipment you're assigning would not get unassigned here, and "+&
			"events have already been routed to it later on.  This would create a conflict.  "+&
			"This request cannot be processed."
		li_Return = -1
	
	//////////////////////////////
	
	//	//Since the equipment / driver we're assigning didn't get dissociated by any of the base events,
	//	//now we need to carry forward into the target and adjust the assignments on those events.
	//
	//	//Get the remainder at the last base row.  Those assignments must now carry forward into the target.
	//	lnv_Events.of_GetRemainder ( lds_Base, ll_LastBaseRow, ai_BaseType, al_BaseId, lla_Ids )
	//
	//	ll_FirstTargetRow = ll_BeforeRow
	//	//ll_LastTargetRow = ll_BeforeRow
	//
	//	FOR ll_Row = ll_FirstTargetRow /*Not +1 here*/ TO ll_TargetCount
	//
	//		//Here, ai_TargetType/al_TargetId is both the perspective and the assignment.
	//
	//		IF lnv_Events.of_Adjust ( lds_Target, ll_Row, ai_TargetType, al_TargetId, lla_Ids, &
	//			ai_TargetType, al_TargetId, TRUE /*Association*/, lb_DissociatedInTarget ) = 1 THEN
	//			//OK -- flag that we need to sync the target ds back into the cache.
	//			lb_ChangesInTarget = TRUE
	//		ELSE
	//			li_Return = -1
	//			EXIT
	//		END IF
	//
	//		ll_LastTargetRow = ll_Row
	//
	//		IF lb_DissociatedInTarget = TRUE THEN
	//			//of_Adjust unassigned the thing we're assigning.  We can stop.
	//			EXIT
	//		END IF
	//
	//		//May not be necessary to do this at the last row, if we don't end up using the ids outside the loop.
	//		lnv_Events.of_GetRemainder ( lds_Target, ll_Row, ai_TargetType, al_TargetId, lla_Ids )
	//
	//	NEXT
		
	END IF


	IF li_Return = 1 AND ll_ConfirmedCount > 0 THEN

		//The unassignment processing went smoothly, but there were confirmed events
		//in the affected range.  If this is the first attempt, we'll try to unconfirm
		//the events, and if successful, perform a 2nd attempt.  If this is the 2nd
		//attempt, something has gone wrong, and we'll fail.

		IF li_Pass = 1 THEN

			This.ClearOFRErrors ( )

			CHOOSE CASE This.of_UnconfirmEvents ( lla_Confirmed, FALSE /*Non-interactive*/ )

			CASE 1
				//OK.  Jump over the processing that would finish out this pass, and just
				//try the processing over again now that everything's unconfirmed.

				CONTINUE
		
			CASE -1
				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
					ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
				END IF
		
				IF Len ( ls_ErrorMessage ) > 0 THEN
					//OK
				ELSE
					ls_ErrorMessage = "Unspecified error attempting to unconfirm events."
				END IF
		
				ls_ErrorMessage += "~n~nThe requested unassignment was not performed."
				li_Return = -1
		
			CASE ELSE
		
				//Unexpected return value.
		
				ls_ErrorMessage = "Unexpected return error attempting to unconfirm events."
				ls_ErrorMessage += "~n~nThe requested assignment was not performed."
				li_Return = -1
		
			END CHOOSE

		ELSE

			//Shouldn't happen.  We should only be making a 2nd attempt if we were
			//able to unconfirm everything.

			ls_ErrorMessage = "Could not unconfirm " + String ( ll_ConfirmedCount ) +&
				" affected events.  The requested assignment was not performed."
			li_Return = -1

		END IF

	END IF


	//If we've reached this point (ie, we didn't CONTINUE, above), we're done and we need to exit the loop.

	EXIT

LOOP


//Apply sequence numbers to the range the new assignment has been applied to.
//(We don't need this if this is a dissociation.)

IF li_Return = 1 AND lb_Association = TRUE THEN

	lnv_Events.of_SequenceRange ( lds_Base, ll_FirstBaseRow, ll_LastBaseRow, ai_TargetType, al_TargetId, &
		lds_Target, ll_AfterRow, lds_Target, ll_BeforeRow )

END IF


//If we're associating a container or trailer, cross check the previous site with the site specified for
//the base event.  If there is no site specified for the base event and there is a site specified for the
//previous event, set the previous event site as the site for the base event.

IF li_Return = 1 AND lb_Association = TRUE AND ll_AfterRow > 0 THEN

	lb_Continue = TRUE

	IF lb_Continue = TRUE THEN

		CHOOSE CASE ai_TargetType
	
		CASE gc_Dispatch.ci_ItinType_Container, gc_Dispatch.ci_ItinType_TrailerChassis

			//We need to continue.

		CASE ELSE

			//We're done.
			lb_Continue = FALSE

		END CHOOSE

	END IF


	IF lb_Continue = TRUE THEN

		ll_CurrentSite = lnv_BaseEvent.of_GetSite ( )
		ll_PreviousSite = lnv_AfterEvent.of_GetSite ( )

		IF ll_CurrentSite = ll_PreviousSite THEN

			//OK

		ELSEIF IsNull ( ll_CurrentSite ) THEN

			IF NOT IsNull ( ll_PreviousSite ) THEN

				lnv_BaseEvent.of_SetSite ( ll_PreviousSite )

			END IF

		ELSE

			ls_SiteMessage = "The site specified for the event does not match the position of the equipment."

		END IF

	END IF

END IF


//If we're assigning a TrailerChassis or Container, check whether there are possible
//origination and/or termination changes.

IF li_Return = 1 AND ( ai_TargetType = gc_Dispatch.ci_ItinType_TrailerChassis OR &
	ai_TargetType = gc_Dispatch.ci_ItinType_Container ) THEN

	IF lb_Association = TRUE THEN

		IF lnv_BaseEvent.of_IsConfirmed ( ) THEN
			ll_PossibleOriginationEvent = al_BaseEvent
		END IF

		IF lb_DissociatedInBase = TRUE THEN

			lnv_Event.of_SetSource ( lds_Base )
			lnv_Event.of_SetSourceRow ( ll_LastBaseRow )

			IF lnv_Event.of_IsConfirmed ( ) THEN
				ll_PossibleTerminationEvent = lnv_Event.of_GetId ( )
			END IF

		END IF

	ELSEIF lb_Association = FALSE THEN

		IF lnv_BaseEvent.of_IsConfirmed ( ) THEN
			ll_PossibleTerminationEvent = al_BaseEvent
		END IF

		IF lb_DissociatedInBase = TRUE THEN

			//This event would (should) have been unconfirmed, above, which would make
			//this logic unnecessary.  But, I'm going to include this processing anyway, 
			//in case it wasn't, or in case the unconfirmation logic above changes.

			lnv_Event.of_SetSource ( lds_Base )
			lnv_Event.of_SetSourceRow ( ll_LastBaseRow )

			IF lnv_Event.of_IsConfirmed ( ) THEN
				ll_PossibleClearedTerminationEvent = lnv_Event.of_GetId ( )
			END IF

		END IF

	END IF


	//Based on the processing above, flag whether we have possible origination and/or
	//termination changes.

	IF IsNull ( ll_PossibleOriginationEvent ) AND &
		IsNull ( ll_PossibleTerminationEvent ) AND &
		IsNull ( ll_PossibleClearedTerminationEvent ) THEN

		lb_PossibleOrigTermChanges = FALSE

	ELSE

		lb_PossibleOrigTermChanges = TRUE

	END IF

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE THEN

	CHOOSE CASE This.of_RetrieveEquipment ( { al_TargetId } )

	CASE 1
		//OK

	CASE -1
		ls_ErrorMessage += "~n(Error retrieving equipment information.)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage += "~n(Original value conflict retrieving equipment.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Unexpected return error retrieving equipment.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN
	lnv_Equipment.of_SetSource ( This.of_GetEquipmentCache ( ) )
	lnv_Equipment.of_SetSourceId ( al_TargetId )
END IF 

IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE THEN
	IF lnv_Equipment.of_IsLeased ( ) = TRUE THEN
		lnv_EquipmentLease.of_SetSource ( This.of_GetEquipmentCache ( ) )
		lnv_EquipmentLease.of_SetSourceId ( al_TargetId )
	ELSE
		lb_PossibleOrigTermChanges = FALSE
	END IF

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE AND &
	NOT IsNull ( ll_PossibleClearedTerminationEvent ) THEN

	CHOOSE CASE lnv_EquipmentLease.of_ClearTermination ( ll_PossibleClearedTerminationEvent )

	CASE 1
		//OK -- Cleared successfully

	CASE 0
		//OK -- Wasn't the termination

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Error evaluating existing termination.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating existing termination.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE AND &
	NOT IsNull ( ll_PossibleOriginationEvent ) THEN

	CHOOSE CASE lnv_EquipmentLease.of_ProposeOrigination ( ll_PossibleOriginationEvent, &
		lds_Base, FALSE /*Non-interactive*/ )

	CASE 1
		//OK -- Origination Set
		
	CASE 0
		//OK -- Proposed origination not used

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Error evaluating origination information.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating origination information.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE AND &
	NOT IsNull ( ll_PossibleTerminationEvent ) THEN

	CHOOSE CASE lnv_EquipmentLease.of_ProposeTermination ( ll_PossibleTerminationEvent, &
		lds_Base, FALSE /*Non-interactive*/ )

	CASE 1
		//OK -- Termination Set

	CASE 0
		//OK -- Proposed termination not used

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Error evaluating termination information.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating termination information.)"
		li_Return = -1

	END CHOOSE

END IF


//If we're associating a container using a hook and if the previous target event (ll_AfterRow) dissociated it,
//see if a chassis was dissociated too (ie, dropped with the container.)  If so, provided there's not already
//a chassis assigned, associate that chassis, too.
//(Note : We won't associate the chassis if we're mounting, since that probably means we're using a different
//chassis.  Also, we won't associate the container if we're hooking the chassis, because that probably means 
//the user is trying to hook just the chassis.)

IF li_Return = 1 AND lb_Association = TRUE AND ll_AfterRow > 0 THEN

	lb_Continue = TRUE

	IF lb_Continue = TRUE THEN

		IF lnv_BaseEvent.of_IsHook ( ) THEN
			//OK, continue
		ELSE
			lb_Continue = FALSE
		END IF

	END IF

	IF lb_Continue = TRUE THEN

		CHOOSE CASE ai_TargetType
	
		CASE gc_Dispatch.ci_ItinType_Container

			//OK, continue.

		CASE ELSE

			//We're done.
			lb_Continue = FALSE

		END CHOOSE

	END IF

//	IF lb_Continue = TRUE THEN
//
//		//If we've already got a chassis and no containers, don't continue.
//
//	END IF

	IF lb_Continue = TRUE THEN

		//Determine the dropped chassis (if there was one), and attempt to assign it.

		IF lnv_AfterEvent.of_GetActiveAssignments ( lla_Drivers, lla_Tractors, &
			lla_TrailerChassis, lla_Containers ) = 1 THEN

			//OK

		ELSE

			//I'm not going to fail over this, but we can't continue trying to indentify a chassis, either.
			lb_Continue = FALSE

		END IF

	END IF


	IF lb_Continue = TRUE THEN

		//If we dropped ONE TrailerChassis, attempt to use it as the chassis.
		//Note : We could check that it's container-capable, but 99+% of the time it would be, 
		//so I'm not going to bother.  The assignment attempt itself will screen for whether it's
		//already assigned to this sequence and not let it be assigned twice, so we don't have to 
		//check for that.

		IF UpperBound ( lla_TrailerChassis ) = 1 THEN

			ll_ChassisId = lla_TrailerChassis [ 1 ]

		END IF

	END IF

END IF


IF li_Return = 1 THEN

	//Can't use MergeEvents here.  That's intended for new retrieval only.

	gf_Rows_Sync ( lds_Base, ldw_Null, lds_Cache, ldw_Null, Filter! /*NewRowBuf*/, &
		FALSE /*Only Modified Rows*/, FALSE /*Only modified data*/ )

END IF


//Can't be changes in target, now.
//
//IF li_Return = 1 AND lb_ChangesInTarget THEN
//
//	//Can't use MergeEvents here.  That's intended for new retrieval only.
//
//	gf_Rows_Sync ( lds_Target, ldw_Null, lds_Cache, ldw_Null, Filter! /*NewRowBuf*/, &
//		FALSE /*Only Modified Rows*/, FALSE /*Only modified data*/ )
//
//END IF


IF li_Return = 1 AND IsNull ( ll_ChassisId ) = FALSE THEN

	This.of_Assign ( ai_BaseType, al_BaseId, al_BaseEvent, &
		gc_Dispatch.ci_ItinType_TrailerChassis, ll_ChassisId, ld_Null, &
		lnv_AfterEvent.of_GetId ( ), gc_Dispatch.ci_InsertionStyle_After )

	This.ClearOFRErrors ( )

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	This.ClearOFRErrors ( ) //Processing above may have loaded some.
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF


IF li_Return = 99 THEN  //Request was handled successfully by of_AssignByReroute

	li_Return = 1  //Now that we've skipped the intervening processing, set the external return back to 1
	
END IF


IF li_Return = 1 THEN
	n_cst_EquipmentPosting	lnv_EqPosting

	lnv_EqPosting = THIS.of_GetEquipmentposting( )
	IF IsValid ( lnv_EqPosting ) THEN
		lnv_EqPosting.of_RemoveHave( lnv_Equipment )
	END IF
END IF





DESTROY ( lnv_EquipmentLease )
DESTROY ( lnv_AfterEvent )
DESTROY ( lnv_BaseEvent )
DESTROY ( lnv_WorkEvent )
DESTROY ( lnv_Event )
DESTROY ( lnv_Equipment )

DESTROY lds_Base		//This was not here prior to 3.6.b3, may have been a memory leak.  BKW
DESTROY lds_Target	//This was not here prior to 3.6.b3, may have been a memory leak.  BKW
DESTROY lds_Lookback

RETURN li_Return
end function

public function integer of_addreferencelist (n_cst_dispatchids anv_referencelist);//Adds the reference list passed in to the collection of reference lists on the object.

//Returns : 1, -1

Integer	li_Return = 1

IF IsValid ( anv_ReferenceList ) THEN

	inva_ReferenceLists [ UpperBound ( inva_ReferenceLists ) + 1 ] = anv_ReferenceList

ELSE

	li_Return = -1

END IF

RETURN li_Return
end function

public function long of_getreferencelists (ref n_cst_dispatchids anva_referencelists[]);//Returns : >= 0 (The number of elements in the array, all of which will be valid -- 
//null elements are scanned for and removed from the instance array before the array 
//is returned.)

//Note : Calling this function may CHANGE the instance array, making it have FEWER ELEMENTS
//than before it was called.  No one should hold onto old counts for this array!

Long	ll_CurrentCount, &
		ll_ActualCount, &
		ll_Index
n_cst_DispatchIds	lnva_ActualList[]

ll_CurrentCount = UpperBound ( inva_ReferenceLists )

FOR ll_Index = 1 TO ll_CurrentCount

	IF IsValid ( inva_ReferenceLists [ ll_Index ] ) THEN
		ll_ActualCount ++
		lnva_ActualList [ ll_ActualCount ] = inva_ReferenceLists [ ll_Index ]
	END IF

NEXT

inva_ReferenceLists = lnva_ActualList
anva_ReferenceLists = inva_ReferenceLists

RETURN ll_ActualCount
end function

public function integer of_clearreferencelists ();//Returns : 1, -1 (Currently not implemented)

n_cst_DispatchIds	lnva_ReferenceLists[], &
						lnva_Empty[]
Long	ll_Count, &
		ll_Index

Integer	li_Return = 1

ll_Count = This.of_GetReferenceLists ( lnva_ReferenceLists )

FOR ll_Index = 1 TO ll_Count

	DESTROY lnva_ReferenceLists [ ll_Index ]

NEXT

//Replace the now skeletal array with an empty one.
inva_ReferenceLists = lnva_Empty

RETURN li_Return
end function

public function integer of_resettimes (string as_context, date ad_context);//Returns : 1, -1

n_cst_Events	lnv_Events

Integer	li_Return = 1

IF lnv_Events.of_ResetTimes ( This.of_GetEventCache ( ), as_Context, ad_Context ) = 1 THEN

	//OK

ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

public function integer of_filtershipment (long al_id);DataStore	lds_ShipmentCache, &
				lds_EventCache, &
				lds_ItemCache
String		ls_Id

Integer		li_Return = 1


IF li_Return = 1 THEN

	IF IsNull ( al_Id ) THEN
		li_Return = -1
	ELSE
		ls_Id = String ( al_Id )
	END IF

END IF


IF li_Return = 1 THEN

	lds_ShipmentCache = This.of_GetShipmentCache ( )

	IF NOT IsValid ( lds_ShipmentCache ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lds_EventCache = This.of_GetEventCache ( )

	IF NOT IsValid ( lds_EventCache ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN
	
	lds_ItemCache = This.of_GetItemCache ( )
	
	IF NOT IsValid ( lds_ItemCache ) THEN
		li_Return = -1
	END IF

END IF

IF li_Return = 1 THEN

	lds_ShipmentCache.setfilter("ds_id = " + ls_Id)
	lds_ShipmentCache.filter()
	
	lds_ItemCache.setfilter("di_shipment_id = " + ls_Id)
	lds_ItemCache.setsort("eventflag A, di_item_type D, di_item_id A")
	lds_ItemCache.filter()
	lds_ItemCache.sort()
	
	lds_EventCache.setfilter("de_shipment_id = " + ls_Id)
	lds_EventCache.setsort("de_ship_seq A")
	lds_EventCache.filter()
	lds_EventCache.sort()

END IF

RETURN li_Return
end function

public function integer of_assign (long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate);//This is a simplified overload of the function for use with the assignment insertion style.

Integer	li_Null
Long		ll_Null

SetNull ( li_Null )
SetNull ( ll_Null )

Integer	li_Return

li_Return = This.of_Assign ( li_Null, ll_Null /*Base Type and Id*/, al_BaseEvent, &
	ai_TargetType, al_TargetId, ad_InsertionDate, ll_Null /*Insertion Event*/, &
	gc_Dispatch.ci_InsertionStyle_Assignment )

RETURN li_Return
end function

public function integer of_retrieveequipment (long ala_ids[]);//Returns : 1 = Sucess, -1 = Failure, -2 = Original Value Conflict (Not currently implemented)
//Note : Not retrieving the number of (unique, non-null) ids provided will be flagged as failure, 
//although any rows that WERE retrieved in this situation will be cached.
//Note : We're deliberately NOT checking for original value conflict on this.
//There would be too much potential for "soft" conflicts to cause failure.

n_cst_AnyArraySrv			lnv_Arrays
n_cst_equipmentmanager	lnv_EqManager

Long			ll_Count, &
				ll_RetrievalCount
Long			ll_I
String		ls_Where

n_cst_Sql	lnv_Sql


Integer	li_Return = 1


IF li_Return = 1 THEN
	
	ll_Count = lnv_Arrays.of_GetShrinked ( ala_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )
	
	// remove temp ids
	FOR ll_i = 1 TO ll_Count
		IF ala_Ids[ll_i] < lnv_EqManager.cl_permidstart THEN
			SetNull ( ala_Ids[ll_i] )
		END IF
	NEXT

	ll_Count = lnv_Arrays.of_GetShrinked ( ala_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

	IF ll_Count > 0 THEN
		
		ls_Where = " WHERE eq_id " + lnv_Sql.of_MakeInClause ( ala_Ids )

	END IF

END IF


IF li_Return = 1 AND ll_Count > 0 THEN

	ll_RetrievalCount = This.of_RetrieveEquipment ( ls_Where )

	CHOOSE CASE ll_RetrievalCount

	CASE IS > 0

		//Check whether the number we got was the number we expected, and if not, indicate failure.

		IF ll_RetrievalCount <> ll_Count THEN
			li_Return = -1
		END IF

	CASE 0, -1
		//0 = No rows retrieved, -1 = Retrieve Failed
		li_Return = -1

	CASE ELSE
		//Unexpected return value
		li_Return = -1

	END CHOOSE

END IF

RETURN li_Return
end function

public function integer of_unconfirmevent (long al_id, boolean ab_interactive);//Returns : 1, 0 (No action, event had not been confirmed), -1


n_cst_beo_Event	lnv_Event
n_cst_beo_EquipmentLease2	lnv_EquipmentLease
n_cst_LicenseManager	lnv_LicenseManager

String	ls_ErrorMessage = "Could not clear event confirmation."

Boolean	lb_InterchangeCapable

Long		lla_ActiveDrivers[], &
			lla_ActiveEquipment[], &
			ll_EventId, &
			ll_SiteId

Integer	li_ActiveEquipmentCount, &
			li_Index

n_cst_OFRError		lnv_Error

Integer	li_Return = 1

lnv_EquipmentLease = CREATE n_cst_beo_EquipmentLease2
lnv_Event = CREATE n_cst_beo_Event

IF li_Return = 1 THEN

	IF IsNull ( al_Id ) THEN
		ls_ErrorMessage += "~n(Null event id.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_Event.of_SetSourceId ( al_Id )

	IF lnv_Event.of_HasSource ( ) THEN

		//OK

	ELSE
		//Try retrieving it.

		CHOOSE CASE This.of_RetrieveEvents ( { al_Id } )

		CASE 1

			//Event was retrieved successfully.  See if we get a source now.

			IF lnv_Event.of_HasSource ( ) THEN
				//OK
			ELSE
				ls_ErrorMessage += "~n(Could not resolve event source.)"
				li_Return = -1
			END IF

		CASE -1

			//Error


			ls_ErrorMessage += "~n(Error retrieving event information.)"
			li_Return = -1

		CASE -2

			//Original value conflict.
			//(This probably shouldn't happen, since if we had the event, we would have 
			//gotten a vaild source in the first place.)

			ls_ErrorMessage += "~n(The event has been modified in the database since it "+&
				"was retrieved.)"
			li_Return = -1

		END CHOOSE
		
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsConfirmed ( ) = FALSE THEN
		ls_ErrorMessage += "~n(The event had not been confirmed.)"
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	lb_InterchangeCapable = lnv_Event.of_IsInterchangeCapable ( )

	CHOOSE CASE lb_InterchangeCapable

	CASE TRUE, FALSE
		//OK

	CASE ELSE
		//Could not evaluate.
		ls_ErrorMessage += "~n(Could not evaluate event type.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_InterchangeCapable THEN


	CHOOSE CASE lnv_Event.of_GetActiveAssignments ( lla_ActiveDrivers, &
		lla_ActiveEquipment )

	CASE 1, 0
		//OK  (1 means something on both sides of the assignment, 0 means not)

		li_ActiveEquipmentCount = UpperBound ( lla_ActiveEquipment )

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Could not evaluate equipment assignments.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating equipment assignments.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_InterchangeCapable AND li_ActiveEquipmentCount > 0 THEN

	CHOOSE CASE This.of_RetrieveEquipment ( lla_ActiveEquipment )

	CASE 1
		//OK

	CASE -1
		ls_ErrorMessage += "~n(Error retrieving equipment information.)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage += "~n(Original value conflict retrieving equipment.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Unexpected return error retrieving equipment.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	//Fixed in 3.5.01 -- Need to set this in case the event is in the filter buffer.
	lnv_Event.of_SetAllowFilterSet ( TRUE )


	CHOOSE CASE lnv_Event.of_Unconfirm ( )

	CASE 1
		//Event was unconfirmed successfully -- OK

		IF lnv_LicenseManager.of_HasEDI214License() THEN 
			n_cst_bso_edimanager lnv_edimanager
			lnv_edimanager = this.of_getedimanager()
			if isvalid(lnv_edimanager) then
				lnv_EDIManager.of_DeleteFrompendingcache( lnv_EDIManager.cl_transaction_set_214, {al_id}, 'EVENT')
//				lnv_EdIManager.of_deletemessage(this, al_id,'DEPART')			
			end if
		END IF
			
		IF lnv_LicenseManager.of_HasNotificationLicense() THEN
			THIS.of_GetNotificationManager ( ).of_RemovePendingNotification ( lnv_Event )
		END IF

	CASE 0
		//Event had not been confirmed
		//(This shouldn't happen, given the check earlier in the script.)
		ls_ErrorMessage += "~n(The event had not been confirmed.)"
		li_Return = 0

	CASE -1
		//Could not unconfirm event.
		ls_ErrorMessage = "Cannot clear event confirmation because the following "+&
			"problems have been detected:~n~n" + lnv_Event.of_GetErrorString ( )
		li_Return = -1

	CASE ELSE
		//Unexpected return.
		ls_ErrorMessage += "~n(Unexpected return error.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_InterchangeCapable AND li_ActiveEquipmentCount > 0 THEN

	ll_EventId = lnv_Event.of_GetId ( )

	lnv_EquipmentLease.of_SetSource ( This.of_GetEquipmentCache ( ) )

	IF lnv_Event.of_IsAssociation ( ) THEN

		FOR li_Index = 1 TO li_ActiveEquipmentCount

			//Not all the equipment here is necessarily going to be outside equipment, so some of
			//these calls may fail due to no source.  Also, at present, everything that's outside
			//equipment is a candidate for origination and termination, but it's possible that 
			//other scenarios could arise where that would not be true.

			lnv_EquipmentLease.of_SetSourceId ( lla_ActiveEquipment [ li_Index ] )

			IF lnv_EquipmentLease.of_GetOriginationEvent ( ) = ll_EventId THEN

				lnv_EquipmentLease.of_ClearOrigination ( )

			END IF

		NEXT

	ELSEIF lnv_Event.of_IsDissociation ( ) THEN

		FOR li_Index = 1 TO li_ActiveEquipmentCount

			lnv_EquipmentLease.of_SetSourceId ( lla_ActiveEquipment [ li_Index ] )

			IF lnv_EquipmentLease.of_GetTerminationEvent ( ) = ll_EventId THEN

				lnv_EquipmentLease.of_ClearTermination ( )

			END IF

		NEXT

	//ELSE
		//It should have been either an association or a dissociation.
		//This shouldn't happen -- I'm going to ignore, since it's too late to fail, anyway.
	END IF

END IF


IF li_Return < 1 AND Len ( ls_ErrorMessage ) > 0 THEN
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

DESTROY lnv_Event
DESTROY lnv_EquipmentLease

RETURN li_Return
end function

public function integer of_unconfirmevents (long ala_ids[], boolean ab_interactive);//Returns : 1, -1
//1 = All events that were previously confirmed were unconfirmed successfully.
//-1 = Not all events were unconfirmed, due to conflicts or errors.  (Note that all
//events that could be unconfirmed were, though.  -1 does not imply no changes made.)

Long		ll_Count, &
			ll_Index

n_cst_OFRError	lnva_Errors[], &
					lnv_Error

String	ls_ErrorMessage = "Could not unconfirm events.", &
			ls_EventMessage

n_cst_AnyArraySrv	lnv_Arrays

Integer	li_Return = 1


IF li_Return = 1 THEN

	ll_Count = lnv_Arrays.of_GetShrinked ( ala_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

	IF ll_Count >= 0 THEN

		//OK

	ELSE

		ls_ErrorMessage += "~n(Could not resolve target array.)"
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	FOR ll_Index = 1 TO ll_Count

		This.ClearOFRErrors ( )
		ls_EventMessage = ""

		CHOOSE CASE This.of_UnconfirmEvent ( ala_Ids [ ll_Index ], ab_Interactive )

		CASE 1
			//Event unconfirmed successfully.  OK.

		CASE 0
			//Event was not confirmed.  OK.

		CASE -1

			This.GetOFRErrors ( lnva_Errors )

			IF UpperBound ( lnva_Errors ) > 0 THEN
				ls_EventMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
			END IF

			IF Len ( ls_EventMessage ) > 0 THEN
				//OK
			ELSE
				ls_EventMessage = "Unspecified error on unconfirm."
			END IF

			li_Return = -1

		CASE ELSE

			ls_EventMessage = "Unexpected return error on unconfirm."
			li_Return = -1

		END CHOOSE

		IF Len ( ls_EventMessage ) > 0 THEN
			ls_ErrorMessage += "~nEvent " + String ( ala_Ids [ ll_Index ] ) + ": " +&
				ls_EventMessage
		END IF

		//Even if we failed on this event, continue with the rest of the loop.
		//We'll attempt all the events, and report back on those that failed.

	NEXT

END IF


IF li_Return = -1 THEN

	This.ClearOFRErrors ( )

	IF Len ( ls_ErrorMessage ) > 0 THEN

		lnv_Error = This.AddOFRError ( )
	
		IF IsValid ( lnv_Error ) THEN
			lnv_Error.SetErrorMessage ( ls_ErrorMessage )
		END IF

	END IF

END IF


RETURN li_Return
end function

public function long of_retrieveequipment (string as_whereclause);//Returns : >= 0 (The number of rows retrieved, which may or may not have already been cached),
//-1 = Failure, -2 = Original Value Conflict (Not currently implemented)
//Note : We're deliberately NOT checking for original value conflict on this.
//There would be too much potential for "soft" conflicts to cause failure.

n_cst_EquipmentManager	lnv_EquipmentManager

Long			ll_Count, &
				ll_CacheCount, &
				ll_RetrievalCount, &
				ll_Row, &
				ll_Id

DataStore	lds_Cache, &
				lds_Retrieval


Long			ll_Return = 0


IF ll_Return = 0 THEN

	lds_Cache = This.of_GetEquipmentCache ( )

	IF IsValid ( lds_Cache ) THEN
		ll_CacheCount = lds_Cache.RowCount ( )
	ELSE
		ll_Return = -1
	END IF

END IF



IF ll_Return = 0 THEN

	ll_RetrievalCount = lnv_EquipmentManager.of_Retrieve ( lds_Retrieval, as_WhereClause )

	CHOOSE CASE ll_RetrievalCount

	CASE IS >= 0

		//OK

	CASE -1
		//Retrieve Failed
		ll_Return = -1

	CASE ELSE
		//Unexpected return value
		ll_Return = -1

	END CHOOSE

END IF


//Loop through the retrieval datastore and discard any rows that are already cached.

IF ll_Return = 0 THEN

	FOR ll_Row = ll_RetrievalCount TO 1 STEP -1

		ll_Id = lds_Retrieval.Object.eq_Id [ ll_Row ]

		IF lds_Cache.Find ( "eq_id = " + String ( ll_Id ), 1, ll_CacheCount ) > 0 THEN
			lds_Retrieval.RowsDiscard ( ll_Row, ll_Row, Primary! )
		END IF

	NEXT

END IF


//See how many new (uncached) rows we've ended up with.

IF ll_Return = 0 THEN

	ll_Count = lds_Retrieval.RowCount ( )

END IF


//Copy the new rows (if any) into the cache

IF ll_Return = 0 AND ll_Count > 0 THEN

	IF lds_Retrieval.RowsCopy ( 1, ll_Count, Primary!, lds_Cache, ll_CacheCount + 1, Primary! ) = 1 THEN

		FOR ll_Row = ( ll_CacheCount + 1 ) TO ( ll_CacheCount + ll_RetrievalCount )

			lds_Cache.SetItemStatus ( ll_Row, 0, Primary!, DataModified! )
			lds_Cache.SetItemStatus ( ll_Row, 0, Primary!, NotModified! )

		NEXT

	ELSE
		ll_Return = -1

	END IF

END IF


IF ll_Return = 0 THEN

	ll_Return = ll_RetrievalCount

END IF


RETURN ll_Return
end function

public function long of_retrieveequipmentforshipment (long al_id);Long		ll_Return = 0
Long		ll_RetrievalCount
Long		ll_Count, &
			ll_CacheCount, &
			ll_Row, &
			ll_Id

String	ls_Where
String	ls_OriginalSelect
String	ls_Select

DataStore	lds_Cache, &
				lds_Retrieval

n_cst_EquipmentManager	lnv_EquipmentManager

n_cst_Sql			lnv_Sql

n_cst_SqlAttrib	lnva_OrigSqlAttrib[]
n_cst_SqlAttrib	lnva_SqlAttrib[]

IF ll_Return = 0 THEN

    IF IsNull ( al_Id ) THEN
        ll_Return = -1
    END IF

END IF

/*MFS 6/5/07 - Pulled code out of of_RetrieveEquipment so that we can manipulate the select for performance enhancements  
IF ll_Return = 0 AND lb_retrieve THEN

    ls_Where = "WHERE eq_id IN ( SELECT outside_equip.oe_id FROM outside_equip "+&
        "WHERE outside_equip.shipment = " + String ( al_Id ) + " OR outside_equip.reloadshipment = " + String ( al_id ) + " ) "

    ll_RetrievalCount = This.of_RetrieveEquipment ( ls_Where )

    CHOOSE CASE ll_RetrievalCount

    CASE IS >= 0, -1, -2
        //Expected return values.
        ll_Return = ll_RetrievalCount

    CASE ELSE
        //Unexpected return value.
        ll_Return = -1

    END CHOOSE

END IF
*/

IF ll_Return = 0 THEN

    IF IsNull ( al_Id ) THEN
        ll_Return = -1
    END IF

END IF

//Get Cache
IF ll_Return = 0 THEN
	
	lds_Cache = This.of_GetEquipmentCache ( )

	IF IsValid ( lds_Cache ) THEN
		ll_CacheCount = lds_Cache.RowCount ( )
	ELSE
		ll_Return = -1
	END IF
	
END IF

//Set up select statement for UNION
IF ll_Return = 0 THEN
	
	lds_Retrieval = Create Datastore
	lds_Retrieval.DataObject = lnv_EquipmentManager.of_Get_Ds_Equipment_Dataobject()
	lds_Retrieval.SetTransObject(SQLCA)
	
	ls_OriginalSelect = lds_Retrieval.Object.Datawindow.Table.Select
	lnv_Sql.of_parse(ls_OriginalSelect, lnva_OrigSqlAttrib) 
	
	IF UpperBound(lnva_OrigSqlAttrib) > 0 THEN
		
		lnva_SqlAttrib[1] = lnva_OrigSqlAttrib[1]
		lnva_SqlAttrib[2] = lnva_OrigSqlAttrib[1]
		
		lnva_SqlAttrib[1].s_Where = "outside_equip.shipment = " + String ( al_Id )
		lnva_SqlAttrib[2].s_Where = "outside_equip.reloadshipment = " + String ( al_id )
		
		//This will UNION the 2 select statements (better than OR for performance)
		ls_Select = lnv_Sql.of_Assemble(lnva_SqlAttrib)
		
		lds_Retrieval.Modify("Datawindow.Table.Select = '" + ls_Select + "'")
		
	ELSE
		ll_Return = -1
	END IF
	
END IF

//Retrieval
IF ll_Return = 0 THEN
	
	ll_RetrievalCount = lds_Retrieval.Retrieve()

	IF ll_RetrievalCount = -1 THEN
		Rollback;
		ll_Return = -1
	ELSE
		Commit;
	END IF
	
END IF


//Loop through the retrieval datastore and discard any rows that are already cached.

IF ll_Return = 0 THEN

	FOR ll_Row = ll_RetrievalCount TO 1 STEP -1

		ll_Id = lds_Retrieval.Object.eq_Id [ ll_Row ]

		IF lds_Cache.Find ( "eq_id = " + String ( ll_Id ), 1, ll_CacheCount ) > 0 THEN
			lds_Retrieval.RowsDiscard ( ll_Row, ll_Row, Primary! )
		END IF

	NEXT

END IF


//See how many new (uncached) rows we've ended up with.

IF ll_Return = 0 THEN

	ll_Count = lds_Retrieval.RowCount ( )

END IF


//Copy the new rows (if any) into the cache

IF ll_Return = 0 AND ll_Count > 0 THEN

	IF lds_Retrieval.RowsCopy ( 1, ll_Count, Primary!, lds_Cache, ll_CacheCount + 1, Primary! ) = 1 THEN

		FOR ll_Row = ( ll_CacheCount + 1 ) TO ( ll_CacheCount + ll_RetrievalCount )

			lds_Cache.SetItemStatus ( ll_Row, 0, Primary!, DataModified! )
			lds_Cache.SetItemStatus ( ll_Row, 0, Primary!, NotModified! )

		NEXT

	ELSE
		ll_Return = -1

	END IF

END IF


IF ll_Return = 0 THEN

	ll_Return = ll_RetrievalCount

END IF


Destroy(lds_Retrieval)


Return ll_Return

end function

public function integer of_deleteequipmentforshipment (long al_shipmentid, ref n_cst_msg anv_results);//Returns : 1 = Successfully deleted all equipment for shipment, 
//-1 = Did not successfully delete all equipment for shipment.

String	ls_ErrorMessage = "Could not delete equipment.", &
			ls_Find
Long		ll_EquipmentCount, &
			lla_TargetIds[], &
			ll_TargetCount, &
			ll_RowCount, &
			ll_FoundRow
Long		ll_ReloadShipment
DataStore	lds_Equipment
n_cst_beo_Equipment2	lnv_Equipment
n_cst_OFRError	lnv_Error


Integer	li_Return = 1

//Retrieve any equipment linked to the shipment.

lnv_Equipment = CREATE n_cst_beo_Equipment2

IF li_Return = 1 THEN

	ll_EquipmentCount = This.of_RetrieveEquipmentForShipment ( al_ShipmentId )

	CHOOSE CASE ll_EquipmentCount

	CASE IS >= 0
		
		//OK -- (Value is the number of equipment associated with this shipment.)

	CASE -1
		ls_ErrorMessage += "~n(Error retrieving equipment information.)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage += "~n(Original value conflict retrieving equipment information.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Unexpected return error retrieving equipment information.)"
		li_Return = -1

	END CHOOSE

END IF


//If any equipment is linked to the shipment, get the equipment cache for use below.

IF li_Return = 1 AND ll_EquipmentCount > 0 THEN

	lds_Equipment = This.of_GetEquipmentCache ( )

	IF NOT IsValid ( lds_Equipment ) THEN
		ls_ErrorMessage += "~n(Invalid equipment cache.)"
		li_Return = -1
	END IF

END IF

//If any equipment is linked to the shipment, deal with it.

IF li_Return = 1 AND ll_EquipmentCount > 0 THEN

	//Commented the eq_status part -- let the other function screen for this.
	ls_Find = "equipmentlease_shipment = " + String ( al_ShipmentId ) //+ " AND eq_status <> 'X'"
	ll_RowCount = lds_Equipment.RowCount ( )
	lnv_Equipment.of_SetSource ( lds_Equipment )

	ll_FoundRow = 0

	DO

		ll_FoundRow = lds_Equipment.Find ( ls_Find, ll_FoundRow + 1, ll_RowCount )

		IF ll_FoundRow > 0 THEN

			lnv_Equipment.of_SetSourceRow ( ll_FoundRow )
			ll_ReloadShipment = lnv_Equipment.of_GetReloadShipment ( )
			IF ll_ReloadShipment > 0 THEN
				THIS.of_EquipmentReloadCanceled ( lnv_Equipment ) 
				lnv_Equipment.of_Setshipment ( ll_ReloadShipment )
			ELSE

				ll_TargetCount ++
				lla_TargetIds [ ll_TargetCount ] = lnv_Equipment.of_GetId ( )
				
			END IF

		END IF

	LOOP WHILE ll_FoundRow > 0 AND ll_FoundRow < ll_RowCount

END IF


// check for equipment being reloaded
IF li_Return = 1 AND ll_EquipmentCount > 0 THEN

	//Commented the eq_status part -- let the other function screen for this.
	ls_Find = "reloadshipment = " + String ( al_ShipmentId ) //+ " AND eq_status <> 'X'"
	ll_RowCount = lds_Equipment.RowCount ( )
	lnv_Equipment.of_SetSource ( lds_Equipment )

	ll_FoundRow = 0

	DO

		ll_FoundRow = lds_Equipment.Find ( ls_Find, ll_FoundRow + 1, ll_RowCount )

		IF ll_FoundRow > 0 THEN

			lnv_Equipment.of_SetSourceRow ( ll_FoundRow )
			ll_ReloadShipment = lnv_Equipment.of_GetReloadShipment ( )
			IF ll_ReloadShipment > 0 THEN
				THIS.of_EquipmentReloadCanceled ( lnv_Equipment ) 
			ELSE

				ll_TargetCount ++
				lla_TargetIds [ ll_TargetCount ] = lnv_Equipment.of_GetId ( )
			END IF

		END IF

	LOOP WHILE ll_FoundRow > 0 AND ll_FoundRow < ll_RowCount

END IF
//



IF li_Return = 1 AND ll_TargetCount > 0 THEN

	CHOOSE CASE This.of_DeleteEquipment ( lla_TargetIds, anv_Results )

	CASE 1

		//OK

	CASE -1

		//Failed.

		//Other version will provide OFR message.  Clear the one here.
		ls_ErrorMessage = ""
		li_Return = -1

	CASE ELSE

		//Unexpected return.

		//Other version may have provided an OFR message, but we can't be sure.

		ls_ErrorMessage += "~n(Unexpected return error deleting equipment.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN

	lnv_Error = This.AddOFRError ( )

	IF IsValid ( lnv_Error ) THEN

		lnv_Error.SetErrorMessage ( ls_ErrorMessage )

	END IF

END IF

DESTROY ( lnv_Equipment ) 

RETURN li_Return
end function

public function integer of_deleteequipment (long ala_ids[], ref n_cst_msg anv_results);//Returns : 1 (All requested equipment deleted), -1 (Not all requested equipment deleted)

String	ls_ErrorMessage = "Could not delete equipment.", &
			ls_EquipmentMessages, &
			lsa_DeletedStatuses[], &
			ls_Work
Long		ll_TargetCount, &
			lla_NonDeletedIds[], &
			ll_NonDeletedCount, &
			lla_DeletedIds[], &
			ll_DeletedCount, &
			ll_Index
DataStore	lds_Equipment
n_cst_beo_Equipment2	lnv_Equipment
n_cst_AnyArraySrv		lnv_Arrays
s_Parm	lstr_Parm
n_cst_Msg	lnv_Msg
n_cst_OFRError	lnv_Error

Integer	li_Return = 1

lnv_Equipment = CREATE n_cst_beo_Equipment2

//Retrieve any equipment linked to the shipment.

IF li_Return = 1 THEN

	CHOOSE CASE This.of_RetrieveEquipment ( ala_Ids )

	CASE 1
		
		//OK

	CASE -1
		ls_ErrorMessage += "~n(Error retrieving equipment information.)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage += "~n(Original value conflict retrieving equipment information.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Unexpected return error retrieving equipment information.)"
		li_Return = -1

	END CHOOSE

END IF


//If any equipment is linked to the shipment, get the equipment cache for use below.

IF li_Return = 1 THEN

	lds_Equipment = This.of_GetEquipmentCache ( )

	IF NOT IsValid ( lds_Equipment ) THEN
		ls_ErrorMessage += "~n(Invalid equipment cache.)"
		li_Return = -1
	END IF

END IF


//If we've already failed at this point, we need to flag that none of the equipment was deleted.

IF li_Return = -1 THEN

	//Transfer the whole id list over
	lla_NonDeletedIds = ala_Ids

	//Shrink the list, and get a count.
	ll_NonDeletedCount = lnv_Arrays.of_GetShrinked ( lla_NonDeletedIds, &
		TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

END IF


//If all is still well, attempt to delete the equipment.

IF li_Return = 1 THEN

	ll_TargetCount = UpperBound ( ala_Ids )
	lnv_Equipment.of_SetSource ( lds_Equipment )

	ls_EquipmentMessages = ""

	FOR ll_Index = 1 TO ll_TargetCount

		lnv_Equipment.of_SetSourceId ( ala_Ids [ ll_Index ] )

		CHOOSE CASE lnv_Equipment.of_Delete ( )

		CASE 1
			//OK
			ll_DeletedCount ++
			lla_DeletedIds [ ll_DeletedCount ] = ala_Ids [ ll_Index ]
			lsa_DeletedStatuses [ ll_DeletedCount ] = lnv_Equipment.of_GetStatus ( )

		CASE 0, -1

			ll_NonDeletedCount ++
			lla_NonDeletedIds [ ll_NonDeletedCount ] = ala_Ids [ ll_Index ]

			ls_Work = lnv_Equipment.of_GetNumber ( )

			IF IsNull ( ls_Work ) OR Len ( Trim ( ls_Work ) ) = 0 THEN
				ls_Work = "[EQUIPMENT REF N.A.]"
			END IF

			//Note : This call clears the message list when it's done.
			ls_Work += "~n" + lnv_Equipment.of_GetErrorString ( )

			IF NOT IsNull ( ls_Work ) THEN
				ls_EquipmentMessages += ls_Work + "~n~n"
			END IF

		CASE ELSE

			ll_NonDeletedCount ++
			lla_NonDeletedIds [ ll_NonDeletedCount ] = ala_Ids [ ll_Index ]

			ls_Work = lnv_Equipment.of_GetNumber ( )

			IF IsNull ( ls_Work ) OR Len ( Trim ( ls_Work ) ) = 0 THEN
				ls_Work = "[EQUIPMENT REF N.A.]"
			END IF

			ls_Work += "~n" + "Could not delete equipment.~n(Unexpected return error.)"

			IF NOT IsNull ( ls_Work ) THEN
				ls_EquipmentMessages += ls_Work + "~n~n"
			END IF

		END CHOOSE

	NEXT

	IF ll_NonDeletedCount > 0 AND Len ( ls_EquipmentMessages ) > 0 THEN

		ls_ErrorMessage += "~n~n" + ls_EquipmentMessages
		li_Return = -1

	END IF

END IF


//Whether we succeeded or not, pass out the results information.

lstr_Parm.is_Label = "DeletedIds"
lstr_Parm.ia_Value = lla_DeletedIds
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DeletedStatuses"
lstr_Parm.ia_Value = lsa_DeletedStatuses
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "NonDeletedIds"
lstr_Parm.ia_Value = lla_NonDeletedIds
lnv_Msg.of_Add_Parm ( lstr_Parm )

anv_Results = lnv_Msg


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN

	lnv_Error = This.AddOFRError ( )

	IF IsValid ( lnv_Error ) THEN
		lnv_Error.SetErrorMessage ( ls_ErrorMessage )
	END IF

END IF

DESTROY ( lnv_Equipment ) 

RETURN li_Return
end function

protected function n_cst_bso_EdiManager of_getedimanager ();IF Not ISValid ( inv_EdiManager ) THEN
	inv_EdiManager = CREATE n_cst_bso_EdiManager
END IF

RETURN inv_EdiManager

end function

public function integer of_viewedilist (long al_event);long	ll_Return = 1

n_cst_Bso_EdiManager	lnv_Edi
lnv_EDI = THIS.of_GetEdiManager ( )

IF Not IsValid ( lnv_Edi ) THEN
	ll_Return =  -1
END IF

if ll_return = 1 then
	if lnv_edi.of_CheckShipperEDIUpdate(this, al_event, false) = 1 then
		lnv_EDI.of_ViewPendingTransactions( this, al_event )
	else
		ll_return = -1
	end if
end if

RETURN ll_Return

end function

public function long of_checkediupdate (long al_event);long	ll_return = 1
n_cst_bso_EdiManager		lnv_EDI
//n_cst_beo_event			lnv_event
lnv_EDI = THIS.of_GetEdiManager ( )

IF Not IsValid ( lnv_Edi ) THEN
	ll_return = -1
END IF
if ll_return = 1 then
	if lnv_edi.of_CheckShipperEDIUpdate(this, al_event, false) = 1 then
		ll_return = 1
	else
		ll_return = -1
	end if
end if
return ll_return

end function

public function integer of_createnewedimessage (long al_eventid);n_cst_Msg		lnv_Msg
S_Parm 			lstr_Parm

n_cst_bso_EdiManager		lnv_EDI

lnv_EDI = THIS.of_GetEdiManager ( )

IF Not IsValid ( lnv_Edi ) THEN
	RETURN -1
END IF

lstr_Parm.is_Label = "EVENTID"
lstr_Parm.ia_Value = al_EventID
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DISPATCH"
lstr_Parm.ia_Value = THIS
lnv_Msg.of_Add_Parm ( lstr_Parm )

lnv_EDI.of_NewMessage ( lnv_Msg )

RETURN 1



end function

public function long of_getequipmentforshipment (long al_shipmentid, ref long ala_equipmentids[]);Long	ll_Return
Long	i
Long	lla_Ids[]

n_cst_beo_Equipment2	lnva_Equipment[]

ll_Return = THIS.of_GetEquipmentForShipment ( al_shipmentid , lnva_Equipment[] )

ala_equipmentids[] = lla_Ids

FOR i = 1 TO ll_Return
	ala_equipmentids [i] = lnva_Equipment[i].of_GetID ( )
NEXT 

RETURN ll_Return
	
////Returns : >= 0 (Success.  The number indicates how many equipment ids are returned.)
////-1 : Error
//
//Long	ll_FoundRow, &
//		ll_RowCount, &
//		ll_Count, &
//		lla_EquipmentIds[]
//String		ls_Find
//DataStore	lds_Equipment
//n_cst_beo_Equipment2	lnv_Equipment
//
////Clear the reference array.
//ala_EquipmentIds = lla_EquipmentIds
//
//Long	ll_Return = 0
//
//lnv_Equipment = CREATE n_cst_beo_Equipment2
//
//IF ll_Return = 0 THEN
//
//	CHOOSE CASE This.of_RetrieveEquipmentForShipment ( al_ShipmentId )
//
//	CASE IS >= 0
//		//OK
//		//Note : Even if we get a 0 on the retrieval, we should still do a find below, 
//		//since something may have been associated in the cache but not saved yet.
//
//	CASE ELSE
//		ll_Return = -1
//
//	END CHOOSE
//
//END IF
//
//
//IF ll_Return = 0 THEN
//
//	lds_Equipment = This.of_GetEquipmentCache ( )
//
//	IF NOT IsValid ( lds_Equipment ) THEN
//		ll_Return = -1
//	END IF
//
//END IF
//
//
//IF ll_Return = 0 THEN
//
//	ls_Find = "equipmentlease_shipment = " + String ( al_ShipmentId ) + " OR reloadShipment = " + String ( al_ShipmentId )
//	ll_RowCount = lds_Equipment.RowCount ( )
//	ll_FoundRow = 0
//	lnv_Equipment.of_SetSource ( lds_Equipment )
//
//	DO
//
//		ll_FoundRow = lds_Equipment.Find ( ls_Find, ll_FoundRow + 1, ll_RowCount )
//
//		IF ll_FoundRow > 0 THEN
//
//			ll_Count ++
//			lnv_Equipment.of_SetSourceRow ( ll_FoundRow )
//			lla_EquipmentIds [ ll_Count ] = lnv_Equipment.of_GetId ( )
//
//		END IF
//
//	LOOP WHILE ll_FoundRow > 0 AND ll_FoundRow < ll_RowCount
//
//	IF ll_Count > 0 THEN
//
//		ala_EquipmentIds = lla_EquipmentIds
//		ll_Return = ll_Count
//
//	END IF
//
//END IF
//
//
//DESTROY ( lnv_Equipment )
//
//RETURN ll_Return
end function

public function integer of_droptodismount (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	ll_ChassisCount
Int	i
Int	li_UnassignRtn
Int	li_ErrorCount
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Drop THEN

	lnv_Event.of_getActiveAssignments ( lla_Other, lla_Other, lla_Chassis , lla_Other )
	
	ll_ChassisCount = Upperbound ( lla_Chassis )
	
	FOR i = 1 TO ll_ChassisCount
		
		li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] )
		IF li_UnassignRtn = -1 THEN
			// read out error messages
			li_Return = -1
			THIS.GetOFRErrors ( lnva_Errors )
			li_ErrorCount = UpperBound ( lnva_Errors )
			EXIT
		END IF
	NEXT
	
	IF li_Return = 1 THEN
		// change the event label to Mount
		lnv_Event.of_SetAllowFilterSet( TRUE )
		lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_DisMount )
	END IF
ELSE
	li_Return = -1
END IF


IF li_ErrorCount > 0 THEN 
	ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
	MessageBox ( "Drop to Dismount" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event )

RETURN li_Return

end function

public function integer of_dismounttodrop (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	ll_ChassisCount
Int	i
Int	li_assignRtn
Int	li_ErrorCount
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Dismount THEN

	IF li_Return = 1 THEN
		// change the event label to Mount
		lnv_Event.of_SetAllowFilterSet( TRUE )
		lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Drop )
	END IF

	lnv_Event.of_getassignments ( lla_Other, lla_Other, lla_Chassis , lla_Other )
	
	ll_ChassisCount = Upperbound ( lla_Chassis )
	

	FOR i = 1 TO ll_ChassisCount
		li_assignRtn = THIS.of_assign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] , lnv_Event.of_GetDateArrived ( ) )
		IF li_assignRtn = -1 THEN
			// read out error messages
			li_Return = -1
			THIS.GetOFRErrors ( lnva_Errors )
			li_ErrorCount = UpperBound ( lnva_Errors )
			EXIT
		END IF
	NEXT
	
	
ELSE
	li_Return = -1
END IF


IF li_ErrorCount > 0 THEN 
	ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
	MessageBox ( "Dismount to Drop" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event )

RETURN li_Return

end function

public function integer of_hooktomount (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	ll_ChassisCount
Int	i
Int	li_UnassignRtn
Int	li_ErrorCount
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event


lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook THEN

	lnv_Event.of_getActiveAssignments ( lla_Other, lla_Other, lla_Chassis , lla_Other )
	
	ll_ChassisCount = Upperbound ( lla_Chassis )
	
	FOR i = 1 TO ll_ChassisCount
		
		li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] )
		IF li_UnassignRtn = -1 THEN
			// read out error messages
			li_Return = -1
			THIS.GetOFRErrors ( lnva_Errors )
			li_ErrorCount = UpperBound ( lnva_Errors )
			EXIT
		END IF
	NEXT
	
	IF li_Return = 1 THEN
		// change the event label to Mount
		lnv_Event.of_SetAllowFilterSet( TRUE )
		lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Mount )
	END IF
ELSE
	li_Return = -1
END IF


IF li_ErrorCount > 0 THEN 
	ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
	MessageBox ( "Hook to Mount" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event )

RETURN li_Return

end function

public function integer of_mounttohook (long al_eventid);Int		li_Return = 1
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Mount THEN

	// change the event label to Hook
	lnv_Event.of_SetAllowFilterSet( TRUE )
	IF lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Hook ) <> 1 THEN
		li_Return = -1
		ls_ErrorMessage = "The event could not be successfully changed to a hook."
	END IF
	
ELSE
	li_Return = -1
	ls_ErrorMessage = "The event submited was not a mount."
END IF

IF li_Return = -1 THEN 
	MessageBox ( "Mount to Hook" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event )

RETURN li_Return

end function

public function integer of_pickuptohook (long al_eventid);Int		li_Return = 1
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lds_EventCache = THIS.of_GetEventCache ( )
lnv_Event = CREATE n_cst_beo_Event
lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Pickup THEN

	// change the event label to Hook
	lnv_Event.of_SetAllowFilterSet( TRUE )
	IF lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Hook ) <> 1 THEN
		li_Return = -1
		ls_ErrorMessage = "The event could not be successfully changed to a hook."
	END IF
	
ELSE
	li_Return = -1
	ls_ErrorMessage = "The event submited was not a Pickup."
END IF

IF li_Return = -1 THEN 
	MessageBox ( "Pickup to Hook" ,  ls_ErrorMessage )
END IF

DESTROY ( lnv_Event )
	

RETURN li_Return

end function

public function integer of_pickuptomount (long al_eventid);Int		li_Return = 1
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lds_EventCache = THIS.of_GetEventCache ( )
lnv_Event = CREATE n_cst_beo_Event
lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Pickup THEN

	// change the event label to Mount
	lnv_Event.of_SetAllowFilterSet( TRUE )
	IF lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Mount) <> 1 THEN
		li_Return = -1
		ls_ErrorMessage = "The event could not be successfully changed to a Mount."
	END IF
	
ELSE
	li_Return = -1
	ls_ErrorMessage = "The event submited was not a Pickup."
END IF

IF li_Return = -1 THEN 
	MessageBox ( "Pickup to Mount" ,  ls_ErrorMessage )
END IF

DESTROY ( lnv_Event )
	

RETURN li_Return

end function

public function integer of_delivertodrop (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	lla_Containers[]
Long	ll_ContainerCount
Long	ll_ChassisCount
Int	i
Int	li_assignRtn
Int	li_ErrorCount
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Deliver THEN

	IF li_Return = 1 THEN
		// change the event label to Drop
		lnv_Event.of_SetAllowFilterSet( TRUE )
		lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Drop )
	END IF

	lnv_Event.of_getassignments ( lla_Other, lla_Other, lla_Chassis , lla_Containers )
	
	ll_ChassisCount = Upperbound ( lla_Chassis )
	ll_ContainerCount = UpperBound ( lla_Containers )
	

	FOR i = 1 TO ll_ChassisCount
		li_assignRtn = THIS.of_assign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] , lnv_Event.of_GetDateArrived ( ) )
		IF li_assignRtn = -1 THEN
			// read out error messages
			li_Return = -1
			THIS.GetOFRErrors ( lnva_Errors )
			li_ErrorCount = UpperBound ( lnva_Errors )
			EXIT
		END IF
	NEXT
	
	IF li_Return <> -1 THEN
		FOR i = 1 TO ll_ContainerCount
			li_assignRtn = THIS.of_assign ( al_EventID, gc_Dispatch.ci_ItinType_Container , lla_Containers[i] , lnv_Event.of_GetDateArrived ( ) )
			IF li_assignRtn = -1 THEN
				// read out error messages
				li_Return = -1
				THIS.GetOFRErrors ( lnva_Errors )
				li_ErrorCount = UpperBound ( lnva_Errors )
				EXIT
			END IF
		NEXT
	END IF
	
ELSE
	li_Return = -1
END IF


IF li_ErrorCount > 0 THEN 
	ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
	MessageBox ( "Deliver to Drop" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event )

RETURN li_Return

end function

public function integer of_delivertodismount (long al_eventid);Int	li_Return = 1
Long	lla_Containers[]
Long	lla_Other []
Long	ll_ContainerCount
Int	i
Int	li_assignRtn
Int	li_ErrorCount
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )
IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Deliver THEN

	IF li_Return = 1 THEN
		// change the event label to Drop
		lnv_Event.of_SetAllowFilterSet( TRUE )
		lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Dismount )
	END IF

	lnv_Event.of_getassignments ( lla_Other, lla_Other, lla_Other , lla_Containers )
	
	ll_ContainerCount = Upperbound ( lla_Containers )
	

	FOR i = 1 TO ll_ContainerCount
		li_assignRtn = THIS.of_assign ( al_EventID, gc_Dispatch.ci_ItinType_Container , lla_Containers[i] , lnv_Event.of_GetDateArrived ( ) )
		IF li_assignRtn = -1 THEN
			// read out error messages
			li_Return = -1
			THIS.GetOFRErrors ( lnva_Errors )
			li_ErrorCount = UpperBound ( lnva_Errors )
			EXIT
		END IF
	NEXT
	
	
ELSE
	li_Return = -1
END IF


IF li_ErrorCount > 0 THEN 
	ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
	MessageBox ( "Deliver to Dismount" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event )

RETURN li_Return

end function

public function integer of_dismountordroptodeliver (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	ll_ChassisCount
Long	lla_Containers[]
Long	ll_ContainerCount
Long	ll_ShipmentID
Int	i
Int	li_UnassignRtn
Int	li_ErrorCount
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )


ll_ShipmentID = lnv_Event.of_GetShipment ( )


IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Dismount OR &
   lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Drop THEN

//	IF ll_ShipmentID > 0 THEN
// do i also need te remove any containers

		

		lnv_Event.of_getActiveAssignments ( lla_Other, lla_Other, lla_Chassis , lla_Containers )
		
		ll_ChassisCount = Upperbound ( lla_Chassis )
		ll_ContainerCount =  UpperBound ( lla_Containers )
		
		FOR i = 1 TO ll_ChassisCount
			li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] )
			IF li_UnassignRtn = -1 THEN
				// read out error messages
				li_Return = -1
				THIS.GetOFRErrors ( lnva_Errors )
				li_ErrorCount = UpperBound ( lnva_Errors )
				ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
				EXIT
			END IF
		NEXT
		
		IF li_Return <> -1 THEN
			FOR i = 1 TO ll_ContainerCount 
				li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_Container , lla_Containers[i] )
				IF li_UnassignRtn = -1 THEN
					// read out error messages
					li_Return = -1
					THIS.GetOFRErrors ( lnva_Errors )
					li_ErrorCount = UpperBound ( lnva_Errors )
					ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
					EXIT
				END IF
			NEXT
		END IF
		
		IF li_Return = 1 THEN
			// change the event label to Deliver
			lnv_Event.of_SetAllowFilterSet( TRUE )
			lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Deliver )
		END IF

//	ELSE
//		ls_ErrorMessage = "Only shipment events can be changed to a Deliver event."
//		li_Return = -1
//	END IF		
ELSE
	li_Return = -1
	ls_ErrorMessage = "The event is not a dismount or a drop. Process stopped."
END IF


IF Len (ls_ErrorMessage ) > 0 THEN 
	MessageBox ( "Change Event to Deliver" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event ) 	

RETURN li_Return

end function

public function integer of_mountorhooktopickup (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	ll_ChassisCount
Int	i
Int	li_UnassignRtn
Int	li_ErrorCount
Long	ll_ShipmentID
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )


ll_ShipmentID = lnv_Event.of_GetShipment ( )


IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook OR &
   lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Mount THEN
	
	//IF ll_ShipmentID > 0 THEN  // amke sure the event is a shipment event

		lnv_Event.of_getActiveAssignments ( lla_Other, lla_Other, lla_Chassis , lla_Other )
		
		ll_ChassisCount = Upperbound ( lla_Chassis )
		
		FOR i = 1 TO ll_ChassisCount
			
			li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] )
			IF li_UnassignRtn = -1 THEN
				// read out error messages
				li_Return = -1
				THIS.GetOFRErrors ( lnva_Errors )
				li_ErrorCount = UpperBound ( lnva_Errors )
				ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
				EXIT
			END IF
		NEXT
		
		IF li_Return = 1 THEN
			// change the event label to PickUp
			lnv_Event.of_SetAllowFilterSet( TRUE )
			lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Pickup )
		END IF
//	ELSE
//		ls_ErrorMessage = "Only shipment events can be converted to a Pick up."
//		
//	END IF
ELSE
	li_Return = -1
	ls_ErrorMessage = "The event type is not a Mount or Hook. Process stopped."
END IF


IF Len ( ls_ErrorMessage ) > 0 THEN 
	MessageBox ( "Change Event to Pickup" ,  ls_ErrorMessage )
END IF
	
DESTROY ( lnv_Event )
	

RETURN li_Return

end function

public function integer of_switcheventtype (long al_eventid, string as_towhat);String 	ls_CurrentType
Int		li_Rtn

n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( THIS.of_GetEventCache ( ) )
lnv_Event.of_SetSourceID ( al_EventID )

ls_CurrentType = lnv_Event.of_GetType ( )



CHOOSE CASE as_ToWhat
		
		
	CASE gc_Dispatch.cs_EventType_Dismount
		
		IF ls_CurrentType = gc_Dispatch.cs_EventType_Drop THEN
			li_Rtn = THIS.of_DropToDismount ( al_EventID )
		ELSEIF ls_CurrentType = gc_Dispatch.cs_EventType_Deliver THEN
			li_Rtn = THIS.of_DeliverToDismount ( al_EventID )
		END IF
		
		
	CASE gc_Dispatch.cs_EventType_Drop
		
		IF ls_CurrentType = gc_Dispatch.cs_EventType_Dismount THEN
			li_Rtn = THIS.of_DismountToDrop ( al_EventID )
		ELSEIF ls_CurrentType = gc_Dispatch.cs_EventType_Deliver THEN
			li_Rtn = THIS.of_DeliverToDrop ( al_EventID )
		END IF
		
		
	CASE gc_Dispatch.cs_EventType_Mount
		
		IF ls_CurrentType = gc_Dispatch.cs_EventType_Pickup THEN
			li_Rtn = THIS.of_PickupToMount ( al_EventID )
		ELSEIF ls_CurrentType = gc_Dispatch.cs_EventType_Hook THEN
			li_Rtn = THIS.of_HookToMount ( al_EventID )
		END IF
		

	CASE gc_Dispatch.cs_EventType_Hook
		
		IF ls_CurrentType = gc_Dispatch.cs_EventType_Mount THEN
			li_Rtn = THIS.of_MountToHook ( al_EventID )
		ELSEIF ls_CurrentType = gc_Dispatch.cs_EventType_Pickup THEN
			li_Rtn = THIS.of_PickupToHook ( al_EventID )
		END IF
		
	CASE gc_Dispatch.cs_EventType_PickUp
		
		IF ls_CurrentType = gc_Dispatch.cs_EventType_Mount OR &
			ls_CurrentType = gc_Dispatch.cs_EventType_Hook THEN
			li_Rtn = THIS.of_MountOrHookToPickup ( al_EventID )
		END IF
				
	CASE gc_Dispatch.cs_EventType_Deliver
		
		IF ls_CurrentType = gc_Dispatch.cs_EventType_Dismount OR &
		   ls_CurrentType = gc_Dispatch.cs_EventType_Drop THEN
			li_Rtn = THIS.of_DismountOrDropToDeliver ( al_EventID )
		END IF
		

END CHOOSE

DESTROY lnv_Event

Return li_Rtn 

end function

public function integer of_switchtopickup (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	lla_Containers []
Long	ll_ChassisCount
Long	ll_ContainerCount

Int	i
Int	li_UnassignRtn
Int	li_ErrorCount
Long	ll_ShipmentID
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )


ll_ShipmentID = lnv_Event.of_GetShipment ( )


//IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook OR &
//   lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Mount THEN
//	
	//IF ll_ShipmentID > 0 THEN  // amke sure the event is a shipment event

		lnv_Event.of_getActiveAssignments ( lla_Other, lla_Other, lla_Chassis , lla_Containers )
		
		ll_ChassisCount = Upperbound ( lla_Chassis )
		ll_ContainerCount = Upperbound ( lla_Containers )
		
		FOR i = 1 TO ll_ChassisCount
			
			li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] )
			IF li_UnassignRtn = -1 THEN
				// read out error messages
				li_Return = -1
				THIS.GetOFRErrors ( lnva_Errors )
				li_ErrorCount = UpperBound ( lnva_Errors )
				ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
				EXIT
			END IF
		NEXT
		
		IF li_Return = 1 THEN
				
			FOR i = 1 TO ll_ContainerCount
				
				li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_Container , lla_Containers[i] )
				IF li_UnassignRtn = -1 THEN
					// read out error messages
					li_Return = -1
					THIS.GetOFRErrors ( lnva_Errors )
					li_ErrorCount = UpperBound ( lnva_Errors )
					ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
					EXIT
				END IF
			NEXT
		END IF
		
		
		IF li_Return = 1 THEN
			// change the event label to PickUp
			lnv_Event.of_SetAllowFilterSet( TRUE )
			lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Pickup )
		END IF
//	ELSE
//		ls_ErrorMessage = "Only shipment events can be converted to a Pick up."
//		
//	END IF
//ELSE
//	li_Return = -1
//	ls_ErrorMessage = "The event type is not a Mount or Hook. Process stopped."
//END IF
//

IF Len ( ls_ErrorMessage ) > 0 THEN 
	MessageBox ( "Change Event to Pickup" ,  ls_ErrorMessage )
END IF
	
DESTROY lnv_Event

RETURN li_Return

end function

public function integer of_switchtodeliver (long al_eventid);Int	li_Return = 1
Long	lla_Chassis[]
Long	lla_Other []
Long	lla_Containers []
Long	ll_ChassisCount
Long	ll_ContainerCount

Int	i
Int	li_UnassignRtn
Int	li_ErrorCount
Long	ll_ShipmentID
String	ls_ErrorMessage

n_ds	lds_EventCache
n_cst_OFRError	lnva_Errors[]
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lds_EventCache = THIS.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_EventCache ) 
lnv_Event.of_SetSourceID ( al_EventID )


ll_ShipmentID = lnv_Event.of_GetShipment ( )


//IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook OR &
//   lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Mount THEN
//	
	//IF ll_ShipmentID > 0 THEN  // amke sure the event is a shipment event

		lnv_Event.of_getActiveAssignments ( lla_Other, lla_Other, lla_Chassis , lla_Containers )
		
		ll_ChassisCount = Upperbound ( lla_Chassis )
		ll_ContainerCount = Upperbound ( lla_Containers )
		
		FOR i = 1 TO ll_ChassisCount
			
			li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_TrailerChassis , lla_Chassis[i] )
			IF li_UnassignRtn = -1 THEN
				// read out error messages
				li_Return = -1
				THIS.GetOFRErrors ( lnva_Errors )
				li_ErrorCount = UpperBound ( lnva_Errors )
				ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
				EXIT
			END IF
		NEXT
		
		IF li_Return = 1 THEN
				
			FOR i = 1 TO ll_ContainerCount
				
				li_UnassignRtn = THIS.of_unassign ( al_EventID, gc_Dispatch.ci_ItinType_Container , lla_Containers[i] )
				IF li_UnassignRtn = -1 THEN
					// read out error messages
					li_Return = -1
					THIS.GetOFRErrors ( lnva_Errors )
					li_ErrorCount = UpperBound ( lnva_Errors )
					ls_ErrorMessage = lnva_Errors[ li_ErrorCount ].getErrorMessage ( )
					EXIT
				END IF
			NEXT
		END IF
		
		
		IF li_Return = 1 THEN
			// change the event label to PickUp
			lnv_Event.of_SetAllowFilterSet( TRUE )
			lnv_Event.of_Settype ( gc_Dispatch.cs_EventType_Deliver )
		END IF
//	ELSE
//		ls_ErrorMessage = "Only shipment events can be converted to a Pick up."
//		
//	END IF
//ELSE
//	li_Return = -1
//	ls_ErrorMessage = "The event type is not a Mount or Hook. Process stopped."
//END IF
//

IF Len ( ls_ErrorMessage ) > 0 THEN 
	MessageBox ( "Change Event to Pickup" ,  ls_ErrorMessage )
END IF
	
DESTROY lnv_Event	

RETURN li_Return

end function

public function integer of_processinterchange (long al_eventid, boolean ab_interactive);//Returns : 1, -1

n_cst_beo_Event	lnv_Event
n_cst_beo_EquipmentLease2	lnv_EquipmentLease

String	ls_ErrorMessage = "Could not set origination / termination."

Boolean	lb_InterchangeCapable, &
			lb_Origination

Long		lla_ActiveDrivers[], &
			lla_ActiveEquipment[], &
			ll_EventId, &
			ll_SiteId

Integer	li_ActiveEquipmentCount, &
			li_Index

Date		ld_ProposedDate
Time		lt_ProposedTime

n_cst_OFRError		lnv_Error

Integer	li_Return = 1

lnv_EquipmentLease = CREATE  n_cst_beo_EquipmentLease2
lnv_Event = CREATE n_cst_beo_Event

IF li_Return = 1 THEN

	IF IsNull ( al_EventId ) THEN
		ls_ErrorMessage += "~n(Null event id.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_Event.of_SetSourceId ( al_EventId )

	IF lnv_Event.of_HasSource ( ) THEN

		//OK

	ELSE
		//Try retrieving it.

		CHOOSE CASE This.of_RetrieveEvents ( { al_EventId } )

		CASE 1

			//Event was retrieved successfully.  See if we get a source now.

			IF lnv_Event.of_HasSource ( ) THEN
				//OK
			ELSE
				ls_ErrorMessage += "~n(Could not resolve event source.)"
				li_Return = -1
			END IF

		CASE -1

			//Error

			ls_ErrorMessage += "~n(Error retrieving event information.)"
			li_Return = -1

		CASE -2

			//Original value conflict.
			//(This probably shouldn't happen, since if we had the event, we would have 
			//gotten a vaild source in the first place.)

			ls_ErrorMessage += "~n(The event has been modified in the database since it "+&
				"was retrieved.)"
			li_Return = -1

		END CHOOSE
		
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsAssociation ( ) THEN

		lb_Origination = TRUE

		//Re-calibrate the base error message to reflect origination.  
		//This is not an error here, though.

		ls_ErrorMessage = "Could not set origination."

	ELSEIF lnv_Event.of_IsDissociation ( ) THEN

		lb_Origination = FALSE

		//Re-calibrate the base error message to reflect origination.  
		//This is not an error here, though.

		ls_ErrorMessage = "Could not set termination."

	ELSE

		ls_ErrorMessage += "~n(Could not evaluate event type.)"
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE lnv_Event.of_IsConfirmed ( )

	CASE TRUE
		//OK

	CASE FALSE
		ls_ErrorMessage += "~n(The event has not been confirmed.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Could not evaluate event confirmation.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	lb_InterchangeCapable = lnv_Event.of_IsInterchangeCapable ( )

	CHOOSE CASE lb_InterchangeCapable

	CASE TRUE
		//OK

	CASE FALSE
		ls_ErrorMessage += "~n(The event cannot be used as an origination / termination.)"
		li_Return = -1

	CASE ELSE
		//Could not evaluate.
		ls_ErrorMessage += "~n(Could not evaluate event type.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	CHOOSE CASE lnv_Event.of_GetActiveAssignments ( lla_ActiveDrivers, &
		lla_ActiveEquipment )

	CASE 1, 0
		//OK  (1 means something on both sides of the assignment, 0 means not)

		li_ActiveEquipmentCount = UpperBound ( lla_ActiveEquipment )

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Could not evaluate equipment assignments.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating equipment assignments.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND li_ActiveEquipmentCount > 0 THEN

	CHOOSE CASE This.of_RetrieveEquipment ( lla_ActiveEquipment )

	CASE 1
		//OK

	CASE -1
		ls_ErrorMessage += "~n(Error retrieving equipment information.)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage += "~n(Original value conflict retrieving equipment.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Unexpected return error retrieving equipment.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND li_ActiveEquipmentCount > 0 THEN

	ll_EventId = lnv_Event.of_GetId ( )
	ll_SiteId = lnv_Event.of_GetSite ( )
	ld_ProposedDate = lnv_Event.of_GetDateArrived ( )
	lt_ProposedTime = lnv_Event.of_GetTimeArrived ( )
	
	
	n_ds	lds_Temp
	Long	ll_Temp
	
	lds_Temp = This.of_GetEquipmentCache ( )
	ll_Temp = lds_Temp.RowCount ( )
	ll_Temp = lds_Temp.FilteredCount ( )
	
	lnv_EquipmentLease.of_SetSource ( lds_Temp )

	IF lb_Origination = TRUE THEN

		FOR li_Index = 1 TO li_ActiveEquipmentCount

			//Not all the equipment here is necessarily going to be outside equipment, so some of
			//these calls may fail due to no source.  Also, at present, everything that's outside
			//equipment is a candidate for origination and termination, but it's possible that 
			//other scenarios could arise where that would not be true.  That could probably be
			//handled within of_ProposeOrigination, though.

			lnv_EquipmentLease.of_SetSourceId ( lla_ActiveEquipment [ li_Index ] )
			lnv_EquipmentLease.of_ProposeOrigination ( ll_EventId, ll_SiteId, ld_ProposedDate, &
				lt_ProposedTime, ab_Interactive )

		NEXT

	ELSE

		FOR li_Index = 1 TO li_ActiveEquipmentCount

			lnv_EquipmentLease.of_SetSourceId ( lla_ActiveEquipment [ li_Index ] )
			lnv_EquipmentLease.of_ProposeTermination ( ll_EventId, ll_SiteId, ld_ProposedDate, &
				lt_ProposedTime, ab_Interactive )

		NEXT

	END IF

END IF


IF li_Return < 1 AND Len ( ls_ErrorMessage ) > 0 THEN
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

DESTROY ( lnv_Event ) 
DESTROY ( lnv_EquipmentLease )

RETURN li_Return
end function

public function n_cst_beo_itinerary2 of_getitinerary (integer ai_type, long al_id, date ad_min, date ad_max);Date	ld_Null	
Int	li_ReturnValue = 1
S_Parm	lstr_Parm
n_cst_Msg	lnv_Range

n_cst_beo_Itinerary2	lnv_Itin

SetNull ( ld_Null )

IF li_ReturnValue = 1 THEN

	IF THIS.of_RetrieveItinerary ( ai_type, al_Id, ad_Min , ad_Max , TRUE ) = 1 THEN
	
		//Retrieved OK
		//Filter the itinerary into the primary buffer.  Use null limits -- we want all the events retrieved.
		THIS.of_FilterItinerary ( ai_type, al_Id, ld_Null, ld_Null )
	
	ELSE
		li_ReturnValue = -1
	END IF

END IF

IF li_ReturnValue = 1 THEN

	lstr_Parm.is_Label = "StartDate"
	lstr_Parm.ia_Value = ad_Min
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EndDate"
	lstr_Parm.ia_Value = ad_Max
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = ai_type
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = al_Id
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lnv_Itin = CREATE n_cst_beo_Itinerary2
	
	lnv_Itin.of_SetDispatchManager ( THIS )
	lnv_Itin.of_SetRange ( lnv_Range )

END IF

Return lnv_Itin
end function

public function integer of_confirmevent (long al_id, boolean ab_interactive);//Returns : 1, 0 (No action, event was already confirmed), -1

n_cst_LicenseManager	lnv_LicenseManager
n_cst_settings			lnv_Settings
n_cst_beo_Event	lnv_Event
//n_cst_beo_EquipmentLease2	lnv_EquipmentLease
n_cst_OFRError		lnva_Errors[]

String	ls_autoAddBob

String	ls_ErrorMessage = "Could not confirm event.", &
			ls_ConfirmationType, &
			ls_EDI214Code

Boolean	lb_InterchangeCapable, &
			lb_Association, &
			lb_Termination

Long		lla_ActiveDrivers[], &
			lla_ActiveEquipment[]

Integer	li_ActiveEquipmentCount, &
			li_Index, &
			li_Pass

n_cst_EventConfirmationOptions	lnv_EventConfirmationOptions

n_cst_OFRError		lnv_Error

Integer	li_Return = 1

lnv_Event = CREATE n_cst_beo_Event

IF li_Return = 1 THEN

	IF IsNull ( al_Id ) THEN
		ls_ErrorMessage += "~n(Null event id.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_Event.of_SetSourceId ( al_Id )
	lnv_Event.of_SetContext ( THIS ) 

	IF lnv_Event.of_HasSource ( ) THEN

		//OK

	ELSE
		//Try retrieving it.

		CHOOSE CASE This.of_RetrieveEvents ( { al_Id } )

		CASE 1

			//Event was retrieved successfully.  See if we get a source now.

			IF lnv_Event.of_HasSource ( ) THEN
				//OK
			ELSE
				ls_ErrorMessage += "~n(Could not resolve event source.)"
				li_Return = -1
			END IF

		CASE -1

			//Error

			ls_ErrorMessage += "~n(Error retrieving event information.)"
			li_Return = -1

		CASE -2

			//Original value conflict.
			//(This probably shouldn't happen, since if we had the event, we would have 
			//gotten a vaild source in the first place.)

			ls_ErrorMessage += "~n(The event has been modified in the database since it "+&
				"was retrieved.)"
			li_Return = -1

		END CHOOSE
		
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsConfirmed ( ) THEN
		ls_ErrorMessage += "~n(The event was already confirmed.)"
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	lb_InterchangeCapable = lnv_Event.of_IsInterchangeCapable ( )

	CHOOSE CASE lb_InterchangeCapable

	CASE TRUE, FALSE
		//OK

	CASE ELSE
		//Could not evaluate.
		ls_ErrorMessage += "~n(Could not evaluate event type.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_InterchangeCapable THEN

	CHOOSE CASE lnv_Event.of_GetActiveAssignments ( lla_ActiveDrivers, &
		lla_ActiveEquipment )

	CASE 1, 0
		//OK  (1 means something on both sides of the assignment, 0 means not)

		li_ActiveEquipmentCount = UpperBound ( lla_ActiveEquipment )

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Could not evaluate equipment assignments.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating equipment assignments.)"
		li_Return = -1

	END CHOOSE

END IF


//Commented because this will now be done in of_ProcessInterchange, so it shouldn't be
//necessary here.

//IF li_Return = 1 AND lb_InterchangeCapable AND li_ActiveEquipmentCount > 0 THEN
//
//	CHOOSE CASE This.of_RetrieveEquipment ( lla_ActiveEquipment )
//
//	CASE 1
//		//OK
//
//	CASE -1
//		ls_ErrorMessage += "~n(Error retrieving equipment information.)"
//		li_Return = -1
//
//	CASE -2
//		ls_ErrorMessage += "~n(Original value conflict retrieving equipment.)"
//		li_Return = -1
//
//	CASE ELSE
//		ls_ErrorMessage += "~n(Unexpected return error retrieving equipment.)"
//		li_Return = -1
//
//	END CHOOSE
//
//END IF


IF li_Return = 1 THEN

	lnv_EventConfirmationOptions = CREATE n_cst_EventConfirmationOptions

	FOR li_Pass = 1 TO 2

		CHOOSE CASE li_Pass

		CASE 1
			ls_ConfirmationType = appeon_constant.cs_EventConfirmation

		CASE 2
			ls_ConfirmationType = appeon_constant.cs_TerminationEventConfirmation

			//Screen whether the event is a termination event.  If not, we should not check 
			//the termination event requirements, so we can CONTINUE.  We don't just ask 
			//of_IsTermination right off the bat because there may be some overhead in this call.

			IF lb_InterchangeCapable = FALSE THEN
				CONTINUE
			ELSEIF lnv_Event.of_IsDissociation ( ) = FALSE THEN
				lb_Association = TRUE
				CONTINUE
			ELSEIF lnv_Event.of_IsTermination ( ) = TRUE THEN
				lb_Termination = TRUE
			ELSE
				CONTINUE
			END IF

		END CHOOSE


		lnv_EventConfirmationOptions.ClearOFRErrors ( )
	
		CHOOSE CASE lnv_EventConfirmationOptions.of_CheckRequirements ( This, al_Id, &
			ls_ConfirmationType )
	
		CASE 1
			//Requirements met.
	
		CASE -1
	
			//Requirements not met, or error.
	
			IF lnv_EventConfirmationOptions.GetOFRErrors ( lnva_Errors ) > 0 THEN
	
				//There are errors to process -- Get the error text
				ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
	
			ELSE
				ls_ErrorMessage = ""
	
			END IF
	
			IF Len ( ls_ErrorMessage ) > 0 THEN
				//OK
			ELSE
				ls_ErrorMessage = "Unspecified error checking confirmation requirements."
			END IF
	
			ls_ErrorMessage = "Cannot confirm completion because the following "+&
				"problems have been detected:~n~n" + ls_ErrorMessage
	
			li_Return = -1
	
		CASE ELSE
	
			//Unexpected return value.
			ls_ErrorMessage += "~n(Unexpected return error checking confirmation requirements.)"
	
			li_Return = -1

	
		END CHOOSE

		IF li_Return = -1 THEN
			EXIT
		END IF

	NEXT

END IF


IF li_Return = 1 THEN

	CHOOSE CASE lnv_Event.of_Confirm ( )

	CASE 1
		
		//Event was confirmed successfully -- OK
		IF lnv_LicenseManager.of_HasEDI214License() OR lnv_LicenseManager.of_HasEDI322License() THEN  //CHANGED FOR EDI322 (Added 322 Condition)
			n_cst_bso_edimanager lnv_edimanager
			lnv_edimanager = this.of_getedimanager()
			if isvalid(lnv_edimanager) then
				lnv_EdIManager.of_newmessage(this, al_id,'DEPART')			
			end if
		END IF
		
		IF lnv_LicenseManager.of_Hasedi322license( ) THEN
			
			
			
			n_Cst_bso_Edimanager_322 lnv_322Manager
			lnv_322Manager = THIS.of_Get322manager( )
			
			String	ls_322Status
			
			IF lnv_322Manager.of_IsCanidate ( lnv_Event , this.of_GetShipmentCache ( ) ) THEN
			
				IF	ab_interactive THEN
					
					CHOOSE CASE lnv_322Manager.of_getStatusFromUser ( ls_322Status )
							
						CASE 1 // they selected a status. Send it in
							lnv_322Manager.of_CreateMsg ( lnv_Event , ls_322Status ) 
							
						CASE ELSE // they cancelled, record cancell.
							lnv_322Manager.of_RecordCancel ( lnv_Event ) 
							
					END CHOOSE
				ELSE // not interactive (Mobile comm)
					SetNull ( ls_322Status ) // null will cause the status to be set to needsData.
					lnv_322Manager.of_CreateMsg ( lnv_Event , ls_322Status ) 
					
				END IF
			END IF			
			
		
		END IF
		
		
		
		
		IF lnv_LicenseManager.of_HasNotificationLicense() & 
			AND lnv_Settings.of_CreateEventNote ( ) &
			AND lnv_Event.of_isNotificationWorthy ( ) THEN
			
			THIS.of_GetNotificationManager ( ).of_CreatePendingNotification ( lnv_Event )
			
		END IF
			
			

	CASE 0
		//Event was already confirmed
		//(This shouldn't happen, given the check earlier in the script.)
		ls_ErrorMessage += "~n(The event was already confirmed.)"
		li_Return = 0

	CASE -1
		//Could not confirm event.
		ls_ErrorMessage = "Cannot confirm completion because the following "+&
			"problems have been detected:~n~n" + lnv_Event.of_GetErrorString ( )
		li_Return = -1

	CASE ELSE
		//Unexpected return.
		ls_ErrorMessage += "~n(Unexpected return error.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_InterchangeCapable AND li_ActiveEquipmentCount > 0 &
	AND ( lb_Association = TRUE OR lb_Termination = TRUE ) THEN

	//Note on the condition above :  If it's not an association, make sure it's a
	//termination, not just a plain old drop.

	This.ClearOFRErrors ( )

	//Note on the 2nd parameter of the following call (which is an Interactive parameter):
	//Even if interactive is permitted by ab_Interactive = TRUE, only go interactive
	//for termination.  Origination would be too much of a nuisance, because every 
	//event confirmed after the origination was initially recorded would cause a prompt 
	//to the user, because the date/time being proposed would be later than the existing one.

	CHOOSE CASE This.of_ProcessInterchange ( al_Id, ( ab_Interactive AND lb_Termination ) )

	CASE 1  //Success

		//OK

	CASE -1  //Failure

		IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN

			ls_ErrorMessage += "~n" + lnva_Errors [ 1 ].GetErrorMessage ( )

		END IF

		li_Return = -1

	CASE ELSE  //Unexpected return

		ls_ErrorMessage += "~n(Unexpected return error processing origination / termination information.)"
		li_Return = -1

	END CHOOSE

END IF

//////ADDED BY DAN 1-23-2007
IF li_Return = 1 THEN
	n_cst_setting_autoaddbobtail	lnv_setting
	lnv_setting = create n_cst_setting_autoaddbobtail
	ls_autoAddBob = lnv_setting.of_getValue()
	IF ls_autoAddBob = lnv_setting.cs_yes THEN
		this.of_autoaddbobtail( lnv_event )
	END IF
END IF
/////////////////////////////

IF li_Return < 1 AND Len ( ls_ErrorMessage ) > 0 THEN
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

DESTROY lnv_EventConfirmationOptions
DESTROY ( lnv_Event )

RETURN li_Return
end function

public function integer of_createmessage ();/*
	this is currently for edi 214 but could potentially be used for other 
	messages based on the event arrdate or arrtime changing

	if arrival date or time has changed then add a new message
	if depart date or time has changed then add a new message
	
	note: currently edimanager is not looking at filtered row. Should it?
*/
long	ll_row, &
		ll_rowcount, &
		lla_EventIds[]
		
time	lt_old_arrival, &
		lt_new_arrival, &
		lt_old_schedule, &
		lt_new_schedule

date	ld_old_arrival, &
		ld_new_arrival, &
		ld_old_schedule, &
		ld_new_schedule
		
integer	li_return = 1

DataStore	lds_EventCache, &
				lds_EventCopy
				
n_cst_beo_Event	lnv_Event
n_cst_licensemanager	lnv_licensemanager
n_cst_bso_edimanager lnv_edimanager

IF lnv_LicenseManager.of_HasEDI214License() THEN
	//continue
else
	li_return = -1
end if

if li_return = 1 then
	lds_EventCache = This.of_GetEventCache ( )
	lnv_Event = CREATE n_cst_beo_Event
	lds_EventCache.RowCount ( )
	
	//get possible events
	ll_rowcount = this.of_GetEDI214Events(lla_EventIds)
	
//	lnv_edimanager = this.of_getedimanager()
	
	lnv_Event.of_SetSource ( lds_EventCache )
	
	FOR ll_Row = 1 TO ll_rowcount
	
		lnv_Event.of_SetSourceId ( lla_EventIds [ ll_Row ] )
	
		lnv_Event.of_SetOriginalValueMode ( TRUE )
		lt_old_arrival = lnv_Event.of_GetTimeArrived ( )
		ld_old_arrival = lnv_Event.of_GetDateArrived ( )
		lt_old_schedule = lnv_Event.of_GetScheduledtime ( )
		ld_old_schedule = lnv_Event.of_GetScheduleddate ( )
		
		lnv_Event.of_SetOriginalValueMode ( FALSE )
		lt_new_arrival = lnv_Event.of_GetTimeArrived ( )
		ld_new_arrival = lnv_Event.of_GetDateArrived ( )
		lt_new_schedule = lnv_Event.of_GetScheduledtime ( )
		ld_new_schedule = lnv_Event.of_GetScheduleddate ( )
		
		if isnull(lt_new_arrival) or isnull(ld_new_arrival) then
			
			//no message
			
		else
			
			if (isnull(lt_old_arrival) or (not isnull(lt_old_arrival) and (lt_new_arrival <> lt_old_arrival))) or &
				(isnull(ld_old_arrival) or (not isnull(ld_old_arrival) and (ld_new_arrival <> ld_old_arrival))) then
		
				lnv_edimanager = this.of_getedimanager()
				if isvalid(lnv_edimanager) then	
					lnv_EdIManager.of_newmessage(this, lla_EventIds [ ll_Row ], 'ARRIVE')			
				end if
				
			end if
			
		end if
		
		if isnull(lt_new_schedule) or isnull(ld_new_schedule) then
			
			//no message
			
		else
			
			if (isnull(lt_old_schedule) or (not isnull(lt_old_schedule) and (lt_new_schedule <> lt_old_schedule))) or &
				(isnull(ld_old_schedule) or (not isnull(ld_old_schedule) and (ld_new_schedule <> ld_old_schedule))) then
		
				lnv_edimanager = this.of_getedimanager()
				if isvalid(lnv_edimanager) then	
					lnv_EdIManager.of_newmessage(this, lla_EventIds [ ll_Row ], 'SCHEDULE')			
				end if
				
			end if
			
		end if
		
	NEXT
	
	DESTROY lnv_event

	this.of_ClearEDI214Events()
	
end if


return li_return
end function

public function n_cst_bso_Notification_Manager of_getnotificationmanager ();IF not isValid ( inv_noteManager ) THEN
	inv_notemanager = CREATE n_cst_bso_Notification_Manager
END IF

RETURN inv_notemanager
end function

protected function integer of_sendpendingmessages ();THIS.of_GetNotificationManager ( ).of_SendPendingNotifications ( ) 
RETURN 1
end function

public subroutine of_addedi214event (long al_event);//Adds the event passed in to the collection of possible edi214 events on the object.

/*
	This could be called more than once for the same event ( time and date changed ).
	We don't want any duplicates in the array. If there is already one in the array
	then check against it before adding. If there is more than one in the array then
	add it and shrink the array for dupes
*/

n_cst_anyarraysrv			lnv_Arraysrv

if upperbound(ila_EDI214Events) = 1 then
	if ila_EDI214Events[1] = al_event then
		//don't add
	else
		ila_EDI214Events[2] = al_event
	end if
else
	ila_edi214events[ UpperBound ( ila_edi214events ) + 1 ] = al_event
	if upperbound(ila_EDI214Events) > 1 then
		lnv_Arraysrv.of_getshrinked(ila_edi214events,true,true)
	end if
end if


end subroutine

public subroutine of_clearedi214events ();Long	lla_edi214events[]

ila_edi214events = lla_edi214events

end subroutine

public function long of_getedi214events (ref long ala_events[]);//Returns:  >=0 : The number of events in the clipboard

Long	ll_Return

ala_events = ila_edi214events
ll_Return = UpperBound ( ala_events )

RETURN ll_Return
end function

public function integer of_retrieveitems (long ala_item[]);//
/***************************************************************************************
NAME			: of_RetrieveItems	
ACCESS		: Public
ARGUMENTS	: Long 			(item id)
RETURNS		: Integer		(1 = Success, -1 = failed)
DESCRIPTION	: This will retrieve the shipment id for the item.
					Then it will retrieve the items for the shipment.
					
					Due to time constraints, this was the most expeditious method. 
					The embeded SQL should be removed and coded like the Events are.
					This also retrieves the shipment and should be removed when rewritten.

REVISION		: RDT 092602
***************************************************************************************/
Long 		ll_ShipmentID
String	ls_ItemList

integer 	li_Return 
Integer	li_Count

Choose Case UpperBound(ala_item[])
	case 0
		li_Return = -1
	Case 1
			ls_ItemList = String(ala_item[1])
	Case Else
		ls_ItemList = String(ala_item[1])
		For li_Count = 2 to Upperbound( ala_item[] )
			ls_ItemList = ls_ItemList + "," + String(ala_item[li_Count] )
		Next
End Choose

// When we have time, this should be recoded like the events are. 
SELECT "di_shipment_id"  
 INTO  :ll_ShipmentID
 FROM "disp_items"  
 WHERE "di_item_id" in (:ls_ItemList) ;

If SQLCA.SQLCODE = 0 Then 
	COMMIT ; 
	li_Return = 1
else
	ROLLBACK ;
		li_Return = -1
End If

If li_return = 1 Then 
	This.of_RetrieveShipment ( ll_ShipmentID )
End IF

Return li_Return 
end function

public function integer of_gettempeqid ();ii_tempEqId ++
RETURN ii_tempEqId 
end function

public function integer of_deleteshipment (long al_ShipmentID);Int	li_Return = -1
Long	ll_Row

ll_Row = ids_shipmentcache.Find ( "ds_Id = " + String ( al_ShipmentID ) , 1 , ids_shipmentcache.RowCount ( ) )
IF ll_Row > 0 THEN 
	IF ids_shipmentcache.DeleteRow ( ll_Row ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return

end function

public function long of_getequipmentforshipment (long al_ShipmentID, ref n_cst_beo_Equipment2 anva_Equipment[]);//Returns : >= 0 (Success.  The number indicates how many equipment ids are returned.)
//-1 : Error

Long	ll_FoundRow, &
		ll_RowCount, &
		ll_Count, &
		lla_EquipmentIds[]
String		ls_Find
DataStore	lds_Equipment
n_cst_beo_Equipment2	lnva_Equipment[]

Long	ll_Return = 0

IF ll_Return = 0 THEN

	CHOOSE CASE This.of_RetrieveEquipmentForShipment ( al_ShipmentId )

	CASE IS >= 0
		//OK
		//Note : Even if we get a 0 on the retrieval, we should still do a find below, 
		//since something may have been associated in the cache but not saved yet.

	CASE ELSE
		ll_Return = -1

	END CHOOSE

END IF


IF ll_Return = 0 THEN

	lds_Equipment = This.of_GetEquipmentCache ( )

	IF NOT IsValid ( lds_Equipment ) THEN
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	ls_Find = "equipmentlease_shipment = " + String ( al_ShipmentId ) + " OR reloadShipment = " + String ( al_ShipmentId )
	ll_RowCount = lds_Equipment.RowCount ( )
	ll_FoundRow = 0
	

	DO

		ll_FoundRow = lds_Equipment.Find ( ls_Find, ll_FoundRow + 1, ll_RowCount )

		IF ll_FoundRow > 0 THEN

			ll_Count ++
			lnva_Equipment[ll_Count] = CREATE n_cst_beo_Equipment2
			lnva_Equipment[ll_Count].of_SetSource ( lds_Equipment )
			lnva_Equipment[ll_Count].of_SetSourceRow ( ll_FoundRow )
		

		END IF

	LOOP WHILE ll_FoundRow > 0 AND ll_FoundRow < ll_RowCount

	IF ll_Count > 0 THEN

		anva_Equipment[] = lnva_Equipment
		ll_Return = ll_Count

	END IF

END IF

RETURN ll_Return
end function

public function integer of_getshipmentchild (long ala_shipid[], ref long ala_childid[]);//Returns : 1 = Sucess, 
//				-1 = Failure, -2 = Original value conflict

Integer	li_ChildCount
			
Long		lla_Children[]

n_cst_Dws	lnv_Dws
DataStore	lds_ChildLookup

Integer	li_Return = 1


IF lnv_Dws.of_CreateDataStoreByDataObject ( "d_ChildShipmentLookup", lds_ChildLookup, FALSE /*NO PFC*/ ) = 1 THEN
	li_ChildCount = lds_ChildLookup.Retrieve ( ala_shipid )
	COMMIT ;

	CHOOSE CASE li_ChildCount

	CASE IS > 0
		lla_Children = lds_ChildLookup.Object.ds_Id.Primary

	CASE 0
		//No action needed.

	CASE ELSE
		li_Return = -1

	END CHOOSE
ELSE
	li_Return = -1
END IF


DESTROY lds_ChildLookup

ala_childid = lla_Children

RETURN li_Return
end function

public function integer of_assessequipmentassignment (n_cst_beo_event anva_events[]);/***************************************************************************************
NAME: 			of_AssessEquipmentAssignment

ACCESS:			Public
		
ARGUMENTS: 		anva_Events[ ]  Array of events assessment. these events may belong to multiple shipments

RETURNS:			 1	success
					 0	no action taken
					-1 error
		
DESCRIPTION:  
			
	This method will determine the equipment to be routed to the events passed in.
	If events belonging to multiple shipments are passed in then, they will be grouped by shipment and passed to the 
	overloaded version of this method.
	all equipment on the shipment will be passed to the overloaded version

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	May 14 2004 Created <<*>> RPZ




***************************************************************************************/

Int	li_Return
Int	li_EventCount
Int	li_EventIndex
Int	li_ShipmentCount 
Int	li_ShipmentIndex
Int	li_SetRtn
Long	ll_WorkingShipmentID
Long	ll_CheckShip
Boolean	lb_HaveID
String	ls_Modlog


n_Cst_AnyArraySrv		lnv_Array
n_Cst_beo_Event		lnv_CurrentEvent
n_cst_beo_Event		lnva_ShipmentEventList []
n_cst_beo_Event		lnva_EmptyEventList []
n_cst_Beo_Event		lnva_Events []

n_cst_beo_Equipment2	lnva_Equipment[]
n_cst_beo_Equipment2	lnva_EmptyEquipment[]
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_cst_beo_Shipment 

lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 

lnva_Events = anva_events[]

li_Return = 1

li_EventCount = UpperBound ( lnva_Events[] ) 

IF li_EventCount > 0 THEN
	// we are going to add a sentinal to the end of the array so that we are guaranteed the IF 
	// condition in the following loop executes on the last itteration
	li_EventCount ++
	lnva_Events [ li_EventCount ] = CREATE n_cst_beo_Event
	//	this is the only event we will destroy. all others should be destroyed by calling script	
ELSE
	li_Return = -1
END IF


/*
Break into shipment blocks. Notice that we are not concerned with which shipment the non-shipment events 
belong to. of_AssessEquipmentAssignment only attempts to assign to shipment events, therefore it doesn't matter for
us here which block they are grouped with
*/
IF li_Return = 1 THEN	
	FOR li_EventIndex = 1 TO li_EventCount
		lnv_CurrentEvent = lnva_Events[ li_EventIndex ]
		IF Not isValid ( lnv_CurrentEvent ) THEN
			li_Return = -1
			EXIT 
		END IF
		
		IF NOT lb_HaveID THEN  // set the workingShipmentID to the first event
			ll_WorkingShipmentID = lnv_CurrentEvent.of_GetShipment ( )	
			IF Not IsNull ( ll_WorkingShipmentID ) THEN 
				lb_HaveID = TRUE
			END IF
		END IF
		
		ll_CheckShip = lnv_CurrentEvent.of_GetShipment ( )
		IF ( li_EventIndex = li_EventCount ) OR ( ll_CheckShip <> ll_WorkingShipmentID AND Not IsNull ( ll_CheckShip ) AND Not isNull ( ll_WorkingShipmentID ) )THEN 
			// submit the group of events and the equipment for that shipment to the next method
			THIS.of_RetrieveShipment ( ll_WorkingShipmentID )
					
			lnv_Shipment.of_SetSource ( THIS.of_GetShipmentCache (  ) )
			lnv_Shipment.of_SetSourceID (ll_WorkingShipmentID )
			lnv_Shipment.of_SetEventSource( THIS.of_GetEventCache ( ) )
			lnv_Shipment.of_SetItemSource ( THIS.of_GetItemCache ( ) ) 
			
			THIS.of_GetEquipmentForShipment ( ll_WorkingShipmentID , lnva_Equipment )			
		
			THIS.of_AssessEquipmentAssignment ( lnva_Equipment[] , lnva_ShipmentEventList [] , lnv_Shipment ) 
				
			ls_ModLog = string(today(), "m/d/yy") + "~t" + string(now(), "h:mmA/P") + "~t"
			ls_ModLog += "ROUTED~t~t"
			ls_ModLog += gnv_App.of_GetUserId ( ) + "~r~n"
			lnv_Shipment.of_AddToModLog ( ls_ModLog )			
			
			// destroy and clear
			lnv_Array.of_Destroy ( lnva_Equipment ) 
			lnva_Equipment = lnva_EmptyEquipment

			// clear the list
			lnva_ShipmentEventList = lnva_EmptyEventList			
			lnv_Shipment.of_ResetEqCache ( )
			
			IF Not isNull ( ll_CheckShip ) THEN
				ll_WorkingShipmentID = ll_CheckShip
			END IF
			
			// Notice here that we are adding this to the list here. Otherwise it would get skipped
			lnva_ShipmentEventList [ UpperBound ( lnva_ShipmentEventList ) + 1]  = lnv_CurrentEvent
			
		ELSE //Add to the collection of events belonging to the current shipment
			
			lnva_ShipmentEventList [ UpperBound ( lnva_ShipmentEventList ) + 1]  = lnv_CurrentEvent
			
		END IF
		
	NEXT
END IF



DESTROY ( lnva_Events [ li_EventCount ] ) // this is the one we created
DESTROY lnv_Shipment

RETURN li_Return





end function

public function integer of_assessequipmentassignment (n_cst_beo_equipment2 anva_equipment[], n_cst_beo_event anva_eventlist[], n_cst_beo_shipment anv_shipment);/***************************************************************************************
NAME: 			of_AssessEquipmentAssignment

ACCESS:			Public
		
ARGUMENTS: 		anva_equipment[]  = the equipment to route/assign
					anva_eventlist[]	= the target event list ( Belonging to same shipment or non-shipment)
					anv_shipment 		= the shipment the equipment and events belong to


RETURNS:			 1 = success 
					 0 = no action taken
					-1 = Error
					!!!	Need to determine how/what to return assigment failure from the assignment loop  !!!
	
DESCRIPTION:

		this method will determine which piece(s) of equipment to route to which event and attempt to 
		route it.
		


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	May 15 2003 CREATED <<*>> RPZ




***************************************************************************************/
Int	li_EventCount
Int	li_EventIndex
Int	li_EqCount
Int	li_EqIndex
Int	li_CntnCount
Int	li_ChassCount
Int	li_Return 
Int	li_assessRtn

Boolean	lb_AssociationMode

n_Cst_EquipmentManager	lnv_EqManager
n_cst_beo_Equipment2 lnva_EquipmentList[]
n_Cst_Beo_Equipment2	lnva_Cntn[]
n_Cst_Beo_Equipment2	lnva_Chas[]
n_cst_beo_Event		lnv_CurrentEvent
n_cst_beo_Event		lnva_Eventlist []
n_csT_beo_Shipment	lnv_Shipment

li_Return = 1

lnva_EventList = anva_eventlist[]
lnv_Shipment = anv_shipment
lnva_EquipmentList = anva_equipment[]

li_EventCount = UpperBound( lnva_Eventlist )
li_EqCount = UpperBound ( lnva_EquipmentList )

IF li_EqCount <= 0 THEN
	li_Return = -1
END IF

IF li_EventCount <=0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	FOR li_EqIndex = 1 TO li_EqCount
		If isValid ( lnva_EquipmentList [ li_EqIndex ] ) THEN
			
			IF lnva_EquipmentList [ li_EqIndex ] .of_GetStatus ( ) = lnv_EqManager.cs_Status_Active THEN
						
				CHOOSE CASE lnva_EquipmentList [ li_EqIndex ].of_getCategory ( )
						
					CASE n_Cst_Constants.ci_EquipmentCategory_Containers
						li_CntnCount ++
						lnva_Cntn [ li_CntnCount ] = lnva_EquipmentList [ li_EqIndex ]
						
					CASE n_Cst_Constants.ci_EquipmentCategory_TrailerChassis
						li_ChassCount ++
						lnva_Chas [ li_ChassCount ] = lnva_EquipmentList [ li_EqIndex ]
						
				END CHOOSE		
				
			END IF
		END IF
	NEXT
END IF

IF li_Return = 1 THEN
	FOR li_EventIndex = 1 TO li_EventCount
		If Not isValid ( lnva_Eventlist [ li_EventIndex ] ) THEN
			li_Return = -1
			EXIT 
		END IF
	NEXT
END IF

IF Not IsValid ( lnv_Shipment ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
		
	FOR li_EventIndex = 1 TO li_EventCount 

		lnv_CurrentEvent = lnva_Eventlist [ li_EventIndex ]
		IF IsNull ( lnv_CurrentEvent.of_GetShipment ( ) ) OR lnv_CurrentEvent.of_isbobtailevent( ) THEN
			CONTINUE
		END IF
			
		// we need to see if the list of events we were given begins with disosciaton events. if it does we need to 
		// make the appropriate assignments to them. after that we will only make assignments to association events.		
		IF NOT lnv_CurrentEvent.of_isassociation ( ) THEN 
			IF lb_AssociationMode THEN
				CONTINUE 
			ELSEIF lnv_CurrentEvent.of_isdissociation ( ) THEN
				
				li_assessRtn = THIS.of_AssessDissociationAssignments ( lnv_CurrentEvent , lnva_Cntn , lnva_Chas ) 									
				
			END IF
			
		ELSE
			lb_AssociationMode = TRUE
			li_assessRtn = THIS.of_AssessAssociationAssignments ( lnv_Shipment , lnv_CurrentEvent , lnva_Cntn , lnva_Chas , lnva_Eventlist , li_EventIndex ) 					

		END IF 
			
	NEXT

END IF

RETURN li_Return
end function

public function integer of_equipmentaddedtoshipment (n_cst_beo_Equipment2 anv_Equipment, n_cst_beo_Shipment anv_Shipment);/*




*/

Int	li_Return = 1
Int	li_EventCount
Int	li_EventIndex
Int	li_RoutedCount

n_cst_AnyArraySrv	lnv_Array
n_CsT_beo_Event	lnva_RoutedEvents[]
n_cst_beo_Event	lnva_EventList[]


IF Not isValid ( anv_Shipment ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	anv_Shipment.of_GetEventList ( lnva_EventList )
	li_EventCount = UpperBound ( lnva_EventList )
END IF

FOR li_EventIndex = 1 To li_EventCount 
	IF lnva_EventList[li_EventIndex].of_IsRouted ( ) THEN
		li_RoutedCount ++
		lnva_RoutedEvents [ li_RoutedCount ] = lnva_EventList [ li_EventIndex ]
		
//	ELSE
		
		
		
	END IF
	
NEXT

IF li_Return = 1 THEN
	
	IF li_RoutedCount > 0 THEN
				
		CHOOSE CASE THIS.of_AssessEquipmentAssignment ( {anv_Equipment} , lnva_RoutedEvents , anv_Shipment ) 
				
			CASE 1 
				li_Return = 1
			CASE 0 
				li_Return = 0
			CASE ELSE
				li_Return = -1
				
		END CHOOSE
		
		
	END IF
	
END IF

lnv_Array.of_Destroy( lnva_EventList )


RETURN li_Return



end function

private function integer of_routenewequipment ();
Int	li_Return = 1
Long	ll_EqIndex
Long	ll_EqCount
Long	ll_ShipID

n_cst_beo_Shipment	lnv_Shipment
n_Cst_beo_Equipment2	lnv_Equipment
n_Cst_beo_Event		lnva_RoutedEvents[]
n_cst_AnyArraySrv		lnv_Array
n_ds	lds_EqCache
n_cst_equipmentmanager	lnv_Eqman

lds_EqCache = ids_equipmentcache // calling get might instantiate it


IF Not IsValid ( lds_eqCache ) THEN
	li_Return = 0
END IF


IF li_Return = 1 THEN
	ll_EqCount = lds_eqCache.RowCount ( )
	
	FOR ll_EqIndex = 1 TO ll_EqCount 
		
		IF lds_eqCache.GetItemString ( ll_EqIndex, "eq_status" ) <> 'K' THEN
			CONTINUE
		END IF		
		
		IF lds_eqCache.GetItemStatus ( ll_EqIndex, "equipmentlease_shipment", PRIMARY! ) <> NotModified! THEN
			
			ll_ShipID = lds_eqCache.GetItemNumber (  ll_EqIndex , "equipmentlease_shipment" )
			
			lnv_Shipment = CREATE n_Cst_beo_Shipment
			lnv_Equipment = CREATE n_cst_beo_Equipment2
		
			lnv_Equipment.of_SetSource ( lds_EqCache )
			lnv_Equipment.of_SetSourceRow ( ll_EqIndex )
			IF lnv_Equipment.of_GetSourceID ( ) < lnv_Eqman.cl_PermIDStart THEN  // the equipment is new so try to route it.
																										//if it is old don't touch the routing simply because the user made a change to the eq.
	
				THIS.of_RetrieveShipment ( ll_ShipID )
				lnv_Shipment.of_SetSource ( THIS.of_GetShipmentCache ( ) )
				lnv_Shipment.of_SetSourceID ( ll_ShipID ) 
				lnv_Shipment.of_SetEventSource ( THIS.of_GEtEventCache ( ) )
				
				IF lnv_Shipment.of_GetRoutedEvents ( lnva_RoutedEvents ) > 0 THEN
					THIS.of_AssessEquipmentAssignment ( {lnv_Equipment} , lnva_RoutedEvents , lnv_Shipment )
				END IF
			END IF
			
			DESTROY ( lnv_Shipment ) 
			DESTROY ( lnv_Equipment )
			lnv_Array.of_Destroy ( lnva_RoutedEvents )
			
		END IF
		
		IF lds_eqCache.GetItemStatus ( ll_EqIndex, "reloadshipment", PRIMARY! ) <> NotModified! THEN
			
			ll_ShipID = lds_eqCache.GetItemNumber (  ll_EqIndex , "reloadshipment" )
		
			lnv_Shipment = CREATE n_Cst_beo_Shipment
			lnv_Equipment = CREATE n_cst_beo_Equipment2
		
			lnv_Equipment.of_SetSource ( lds_EqCache )
			lnv_Equipment.of_SetSourceRow ( ll_EqIndex )
			IF lnv_Equipment.of_GetSourceID ( ) < lnv_Eqman.cl_PermIDStart THEN								
			
				THIS.of_RetrieveShipment ( ll_ShipID )
				lnv_Shipment.of_SetSource ( THIS.of_GetShipmentCache ( ) )
				lnv_Shipment.of_SetSourceID ( ll_ShipID ) 
				lnv_Shipment.of_SetEventSource ( THIS.of_GEtEventCache ( ) )
				
				IF lnv_Shipment.of_GetRoutedEvents ( lnva_RoutedEvents ) > 0 THEN
					THIS.of_AssessEquipmentAssignment ( {lnv_Equipment} , lnva_RoutedEvents , lnv_Shipment )
				END IF
			END IF
			
			DESTROY ( lnv_Shipment ) 
			DESTROY ( lnv_Equipment )
			lnv_Array.of_Destroy ( lnva_RoutedEvents )
					
		END IF
		
	NEXT
	
END IF

RETURN li_Return
end function

private function integer of_assessassociationassignments (n_cst_beo_shipment anv_shipment, n_cst_beo_event anv_currentevent, n_cst_beo_equipment2 anva_containerlist[], n_cst_beo_equipment2 anva_chassislist[], n_cst_beo_event anva_eventlist[], integer ai_curentindex);/***************************************************************************************
NAME: 			of_assessAssociationAssignments 

ACCESS:			PRIVATE
	
ARGUMENTS: 		anv_shipment, the shipment the equipment belongs to
					anv_currentevent, the event the equipment will be assigned to 
					anva_containerlist[], the list of containers/rboxes for assessment
					anva_chassislist[],  the list of Chassis/Trailers for assessment
					anva_eventlist[], the entire event list under assessment
					ai_curentindex, the index of anv_currentevent in anva_eventlist

RETURNS:			 the result of this.of_Assign
					 1 = success 
					 0 = no action 
					-1 = error
					
			!!!	Need to determine how/what to return assigment failure from the assignment loop  !!!
					
	
DESCRIPTION:
		This method is used to determine how to assign equipment to the current event.
		It looks at whether the current event is a HOOK, HOOK + MOUNT(next event), or
		just a mount.
		It will assign Chassis to Hooks, Containers to Mount, If there is no mount in the
		Event list the containers will also be assigned to the Hook.
		
		if the proposed equipment is assigned to the event ( even in a passive assignment ) then
		that piece of equipment is skipped.
		


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	CREATED	May 21, 2003 <<*>> RPZ



***************************************************************************************/
Int		li_NextEventShipSeq
Int		i
Int		li_EventCount
Int		li_EventIndex
Int		li_CntnCount
Int		li_CntnIndex
Int		li_ChassCount
Int		li_ChassIndex
Int		li_AssignRtn
Int		li_Return = 1
Boolean	lb_Hook
Boolean	lb_Mount
Boolean	lb_HaveMount
Boolean	lb_CurrentEventIsMount

n_Cst_beo_Event		lnva_EventList[]
n_Cst_beo_Event		lnv_NextEvent
n_cst_beo_Event		lnv_CurrentEvent
n_cst_beo_Shipment	lnv_Shipment
n_Cst_beo_Equipment2	lnva_Cntn[]
n_cst_beo_Equipment2	lnva_Chas[]
n_cst_EquipmentPosting	lnv_EqPosting

lnv_EqPosting = THIS.of_GetEquipmentposting( )
lnv_CurrentEvent = anv_CurrentEvent
lnv_Shipment = anv_Shipment
lnva_EventList = anva_EventList[]
lnva_Chas = anva_ChassisList[]
lnva_Cntn = anva_ContainerList[]

li_EventCount = UpperBound ( lnva_EventList )
li_CntnCount = UpperBound ( lnva_Cntn )
li_ChassCount = UpperBound ( lnva_Chas )
li_EventIndex = ai_CurentIndex

IF Not IsValid ( lnv_CurrentEvent ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	lb_Hook = lnv_CurrentEvent.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook
	lb_CurrentEventISMount = lnv_CurrentEvent.of_GetType ( ) = gc_Dispatch.cs_EventType_Mount
END IF

IF li_Return = 1 THEN
	IF lb_Hook THEN
		
		li_NextEventShipSeq = lnv_CurrentEvent.of_GetShipSeq ( ) + 1
		lnv_Shipment.of_GetEvent ( li_NextEventShipSeq , lnv_NextEvent ) 
		IF isValid ( lnv_NextEvent ) THEN
			lb_Mount = lnv_NextEvent.of_GetType ( ) = gc_Dispatch.cs_EventType_Mount
		END IF
		
		IF lb_Mount THEN
			// we know that there is a mount in the shipment but,
			// we need to see if the mount was given to us in the list
			FOR i = li_EventIndex TO li_EventCount 
				IF lnva_Eventlist [ i ].of_GetID ( ) = lnv_NextEvent.of_getID ( ) THEN 
					lb_HaveMount = TRUE
				END IF					
			NEXT
						
			IF lb_HaveMount THEN		// if the mount was not given to us then we will only assign chassis						
				FOR li_CntnIndex = 1 TO li_CntnCount					
					// if the equipment is assigned to the event then skip it
					IF NOT lnv_NextEvent.of_IsAssigned ( gc_dispatch.ci_itintype_container , lnva_Cntn [li_CntnIndex].of_GetID ( ) )  THEN 
//						li_assignRtn = THIS.of_assignwithvalidation ( lnv_NextEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_Container , lnva_Cntn [li_CntnIndex].of_GetID ( ) , lnv_NextEvent.of_GetDateArrived ( )  )						
						li_assignRtn = THIS.of_assign ( lnv_NextEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_Container , lnva_Cntn [li_CntnIndex].of_GetID ( ) , lnv_NextEvent.of_GetDateArrived ( )  )
						IF li_AssignRtn = 1 THEN
							lnv_EqPosting.of_Removehave( lnva_Cntn [li_CntnIndex] )
						END IF 
					END IF
				NEXT			
			END IF
												
			FOR li_ChassIndex = 1 TO li_ChassCount				
				IF NOT lnv_CurrentEvent.of_IsAssigned ( gc_dispatch.ci_itintype_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) ) THEN
//					li_assignRtn = THIS.of_assignwithvalidation ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )		
					li_assignRtn = THIS.of_assign ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
					IF li_AssignRtn = 1 THEN
						lnv_EqPosting.of_Removehave( lnva_Chas [li_ChassIndex] )
					END IF
				END IF
			NEXT	
			
			
		ELSE // there is no mount, so assign the containers and chassis to the current hook
					
			FOR li_CntnIndex = 1 TO li_CntnCount
				IF NOT lnv_CurrentEvent.of_IsAssigned ( gc_dispatch.ci_itintype_container , lnva_Cntn [li_CntnIndex].of_GetID ( ) )  THEN 
//					li_assignRtn = THIS.of_assignwithvalidation ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_Container , lnva_Cntn [li_CntnIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
					li_assignRtn = THIS.of_assign ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_Container , lnva_Cntn [li_CntnIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
					IF li_AssignRtn = 1 THEN
						lnv_EqPosting.of_Removehave( lnva_Cntn [li_CntnIndex] )
					END IF
				END IF
			NEXT
					
			FOR li_ChassIndex = 1 TO li_ChassCount
				IF NOT lnv_CurrentEvent.of_IsAssigned ( gc_dispatch.ci_itintype_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) ) THEN
//					li_assignRtn = THIS.of_assignwithvalidation ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
					li_assignRtn = THIS.of_assign ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
					IF li_AssignRtn = 1 THEN
						lnv_EqPosting.of_Removehave( lnva_Chas [li_ChassIndex] )
					END IF
				END IF
			NEXT
							
		END IF // the case for determining if a mount was next
		
	ELSEIF lb_CurrentEventISMount THEN
				
		FOR li_CntnIndex = 1 TO li_CntnCount
			IF NOT lnv_CurrentEvent.of_IsAssigned ( gc_dispatch.ci_itintype_container , lnva_Cntn [li_CntnIndex].of_GetID ( ) )  THEN 
//				li_assignRtn = THIS.of_assignwithvalidation ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_Container , lnva_Cntn [li_CntnIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
				li_assignRtn = THIS.of_assign ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_Container , lnva_Cntn [li_CntnIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
				IF li_AssignRtn = 1 THEN
					lnv_EqPosting.of_Removehave( lnva_Cntn [li_CntnIndex] )
				END IF
			END IF
		NEXT
		
		FOR li_ChassIndex = 1 TO li_ChassCount
			IF NOT lnv_CurrentEvent.of_IsAssigned ( gc_dispatch.ci_itintype_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) ) THEN
//				li_assignRtn = THIS.of_assignwithvalidation ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
				li_assignRtn = THIS.of_assign ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
				IF li_AssignRtn = 1 THEN
					lnv_EqPosting.of_Removehave( lnva_Chas [li_ChassIndex] )
				END IF
			END IF
		NEXT
							
	END IF
	
END IF

IF li_Return = -1 THEN
	li_AssignRtn = -1
END IF

RETURN li_AssignRtn
end function

private function integer of_assessdissociationassignments (n_cst_beo_event anv_currentevent, n_cst_beo_equipment2 anva_containerlist[], n_cst_beo_equipment2 anva_chassislist[]);/***************************************************************************************
NAME: 			of_assessdissociationAssignments 

ACCESS:			PRIVATE
	
ARGUMENTS: 		anv_currentevent, the dissociation event to assign equipment
					anva_containerlist[], the list of containers/rboxes for assessment
					anva_chassislist[],  the list of Chassis/Trailers for assessment
					
RETURNS:			 the result of this.of_Assign
					 1 = success 
					 0 = no action 
					-1 = error
					
			!!!	Need to determine how/what to return assigment failure from the assignment loop  !!!
					
	
DESCRIPTION:
		
		THIS method will assign containers and chassis to the current event if it either a Drop or Dismount 
		since of_Assign will look back and make the assignment to the appropriate association event
		 
		
		if the proposed equipment is assigned to the event ( even in a passive assignment ) then
		that piece of equipment is skipped.
		


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	CREATED	May 21, 2003 <<*>> RPZ



***************************************************************************************/
Int		li_CntnCount
Int		li_CntnIndex
Int		li_ChassCount
Int		li_ChassIndex
Int		li_AssignRtn
Int		li_Return = 1

n_cst_beo_Event		lnv_CurrentEvent
n_Cst_beo_Equipment2	lnva_Cntn[]
n_cst_beo_Equipment2	lnva_Chas[]

lnv_CurrentEvent = anv_CurrentEvent
lnva_Chas = anva_ChassisList[]
lnva_Cntn = anva_ContainerList[]

li_CntnCount = UpperBound ( lnva_Cntn )
li_ChassCount = UpperBound ( lnva_Chas )

IF Not isValid ( lnv_CurrentEvent ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	FOR li_CntnIndex = 1 TO li_CntnCount
		IF NOT lnv_CurrentEvent.of_IsAssigned ( gc_dispatch.ci_itintype_container , lnva_Cntn [li_CntnIndex].of_GetID ( ) )  THEN 
			li_assignRtn = THIS.of_assign ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_Container , lnva_Cntn [li_CntnIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )										
		END IF
	NEXT
		
	FOR li_ChassIndex = 1 TO li_ChassCount				
		IF NOT lnv_CurrentEvent.of_IsAssigned ( gc_dispatch.ci_itintype_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) ) THEN
			li_assignRtn = THIS.of_assign ( lnv_CurrentEvent.of_GetID (  ) , gc_Dispatch.ci_ItinType_TrailerChassis , lnva_Chas [li_ChassIndex].of_GetID ( ) , lnv_CurrentEvent.of_GetDateArrived ( )  )
		END IF
	NEXT	
					
END IF

IF li_Return = -1 THEN
	li_AssignRtn = -1
END IF

RETURN li_AssignRtn
end function

public function integer of_equipmentreloaded (n_cst_beo_equipment2 anv_equipment);Long	ll_ImportShipment
Long	ll_ExportShipment
Int	li_EventCount
Int	li_Return = 1
n_Cst_Events			lnv_Events
n_Cst_AnyArraySrv		lnv_ArraySrv
n_Cst_beo_Event		lnva_EventList[]
n_Cst_beo_Event		lnv_Event1
n_Cst_beo_Event		lnv_Event2
n_cst_EquipmentPosting	lnv_EqPosting
n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment 


lnv_Shipment.of_SetSource ( THIS.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 

IF li_Return = 1 THEN
	IF NOT IsValid ( anv_Equipment ) THEN
		li_Return = -1
	END IF	
END IF	

IF li_Return = 1 THEN
	lnv_EqPosting = THIS.of_GetEquipmentposting( )
	IF IsValid ( lnv_EqPosting ) THEN		
		inv_equipmentposting.of_Removehave( anv_equipment )		
	END IF
END IF


// Export shipment first ( need to check for front chassis split when marking events as non-routable)
IF li_Return = 1 THEN
	ll_ExportShipment = anv_Equipment.of_GetReloadShipment ( ) 
	IF ll_ExportShipment > 0 THEN
		lnv_Shipment.of_SetSourceID ( ll_ExportShipment )
		
		IF Not lnv_Shipment.of_HasSource ( )  THEN
			THIS.of_RetrieveShipment ( ll_ExportShipment )
			lnv_Shipment.of_SetSourceID ( ll_ExportShipment ) 
		END IF
		
		IF lnv_Shipment.of_HasSource ( ) THEN
			
			lnv_Shipment.of_SetEventsource ( THIS.of_GetEventCache ( ) )
			li_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList )
			
			IF li_EventCount > 0 THEN
				
				lnv_Event1 = lnva_EventList[1]
				lnv_Event1.of_SetAllowFilterSet ( TRUE  ) 
				
				IF lnv_Shipment.of_HasFrontChassisSplit ( ) THEN 
					
					IF IsNull ( lnv_Event1.of_GetDateArrived ( )  ) THEN
						lnv_Event1.of_SetRoutable ( "F" )	 // hook
					END IF
					
					lnv_Event2 = lnva_EventList[2]					
					lnv_Event2.of_SetAllowFilterSet ( TRUE  ) 					
					IF IsNull ( lnv_Event2.of_GetDateArrived ( )  ) THEN
						lnv_Event2.of_SetRoutable ( "F" )   // drop
					END IF
					
				ELSE
					
					IF lnv_Event1.of_GetType ( ) = gc_dispatch.cs_EventType_Hook AND IsNull ( lnv_Event1.of_GetDateArrived ( )  ) THEN						
						lnv_Event1.of_SetRoutable ( "F" )
					END IF
					
				END IF
			END IF		
		END IF
			
	END IF
	
	lnv_ArraySrv.of_Destroy ( lnva_EventList ) 
	
END IF

// Import Shipment Next  ( need to check for Back chassis split when marking events as non-routable)
IF li_Return = 1 THEN
	ll_ImportShipment = anv_Equipment.of_GetShipment ( ) 
	IF ll_ImportShipment > 0 THEN
		lnv_Shipment.of_SetSourceID ( ll_ImportShipment )
		
		IF Not lnv_Shipment.of_HasSource ( )  THEN
			THIS.of_RetrieveShipment ( ll_ImportShipment )
			lnv_Shipment.of_SetSourceID ( ll_ImportShipment ) 
		END IF
		
		IF lnv_Shipment.of_HasSource ( ) THEN
			lnv_Shipment.of_SetEventsource ( THIS.of_GetEventCache ( ) )
			
			li_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList )
			
			IF li_EventCount > 0 THEN
				
				lnv_Event1 = lnva_EventList[ li_EventCount ]
				lnv_Event1.of_SetAllowFilterSet ( TRUE  ) 
				
				IF lnv_Shipment.of_HasBackChassisSplit ( ) THEN
										
					
					IF IsNull ( lnv_Event1.of_GetDateArrived ( )  ) THEN
						lnv_Event1.of_SetRoutable ( "F" )
					END IF
					
					
					lnv_Event2 = lnva_EventList[ li_EventCount - 1 ]
					lnv_Event2.of_SetAllowFilterSet ( TRUE  )
					IF IsNull ( lnv_Event2.of_GetDateArrived ( )  ) THEN
						lnv_Event2.of_SetRoutable ( "F" )
					END IF
					
				ELSE
					
					IF lnv_Event1.of_GetType ( ) = gc_dispatch.cs_EventType_drop AND IsNull ( lnv_Event1.of_GetDateArrived ( )  ) THEN
						lnv_Event1.of_SetRoutable ( "F" )
					END IF
					
				END IF
			END IF
						
		END IF
			
	END IF
	
	lnv_ArraySrv.of_Destroy ( lnva_EventList ) 
	
END IF

DESTROY ( lnv_Shipment )

RETURN li_Return
end function

public function integer of_equipmentreloadcanceled (n_cst_beo_equipment2 anv_equipment);Long	ll_ImportShipment
Long	ll_ExportShipment
Int	li_EventCount
Int	li_Return = 1
Long	ll_NULL
n_Cst_Events			lnv_Events
n_Cst_AnyArraySrv		lnv_ArraySrv
n_Cst_beo_Event		lnva_EventList[]

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment 


lnv_Shipment.of_SetSource ( THIS.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 

SetNull ( ll_NULL )

IF li_Return = 1 THEN
	IF NOT IsValid ( anv_Equipment ) THEN
		li_Return = -1
	END IF	
END IF	


// Export shipment first ( need to check for front chassis split when marking events as routable)
IF li_Return = 1 THEN
	ll_ExportShipment = anv_Equipment.of_GetReloadShipment ( ) 
	IF ll_ExportShipment > 0 THEN
		lnv_Shipment.of_SetSourceID ( ll_ExportShipment )
		
		IF Not lnv_Shipment.of_HasSource ( )  THEN
			THIS.of_RetrieveShipment ( ll_ExportShipment )
			lnv_Shipment.of_SetSourceID ( ll_ExportShipment ) 
		END IF
		
		IF lnv_Shipment.of_HasSource ( ) THEN
			lnv_Shipment.of_SetEventsource ( THIS.of_GetEventCache ( ) )
			li_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList )
			
			IF li_EventCount > 0 THEN
				IF lnv_Shipment.of_HasFrontChassisSplit ( ) THEN  
					lnva_EventList[1].of_SetAllowFilterSet ( TRUE  ) 
					lnva_EventList[2].of_SetAllowFilterSet ( TRUE  ) 
					lnva_EventList[1].of_SetRoutable ( "T" )	 // hook
					lnva_EventList[2].of_SetRoutable ( "T" )   // drop
				ELSE
					IF lnva_EventList[1].of_GetType ( ) = gc_dispatch.cs_EventType_Hook THEN
						lnva_EventList[1].of_SetAllowFilterSet ( TRUE  ) 
						lnva_EventList[1].of_SetRoutable ( "T" )
					END IF
					
				END IF
			END IF
			
			
			
		END IF
			
	END IF
	
	lnv_ArraySrv.of_Destroy ( lnva_EventList ) 
	
END IF

// Import Shipment Next  ( need to check for Back chassis split when marking events as routable)
IF li_Return = 1 THEN
	ll_ImportShipment = anv_Equipment.of_GetShipment ( ) 
	IF ll_ImportShipment > 0 THEN
		lnv_Shipment.of_SetSourceID ( ll_ImportShipment )
		
		IF Not lnv_Shipment.of_HasSource ( )  THEN
			THIS.of_RetrieveShipment ( ll_ImportShipment )
			lnv_Shipment.of_SetSourceID ( ll_ImportShipment ) 
		END IF
		
		IF lnv_Shipment.of_HasSource ( ) THEN
			lnv_Shipment.of_SetEventsource ( THIS.of_GetEventCache ( ) )
			li_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList )
			
			IF li_EventCount > 0 THEN
				IF lnv_Shipment.of_HasBackChassisSplit ( ) THEN
					lnva_EventList[ li_EventCount ].of_SetAllowFilterSet ( TRUE  )
					lnva_EventList[ li_EventCount - 1 ].of_SetAllowFilterSet ( TRUE  )
					lnva_EventList[ li_EventCount ].of_SetRoutable ( "T" )
					lnva_EventList[ li_EventCount - 1 ].of_SetRoutable ( "T" )
				ELSE
					IF lnva_EventList[ li_EventCount ].of_GetType ( ) = gc_dispatch.cs_EventType_drop THEN
						lnva_EventList[ li_EventCount ].of_SetAllowFilterSet ( TRUE  )
						lnva_EventList[ li_EventCount ].of_SetRoutable ( "T" )
					END IF
					
				END IF
			END IF
						
		END IF
			
	END IF
	
	lnv_ArraySrv.of_Destroy ( lnva_EventList ) 
	
END IF

IF li_Return = 1 THEN
	anv_equipment.of_SetReloadShipment ( ll_NULL )
END IF

DESTROY ( lnv_Shipment )

RETURN li_Return
end function

public function integer of_duplicaterouting (long al_sourceeventid, long ala_targeteventids[], integer ai_insertionstyle);Date 	ld_RoutingDate
Long	lla_PowerEquipment[]
Long	lla_DontCare[]
Int	li_RouteRtn
Int	li_Return = 1
n_Cst_privileges_events	lnv_Privs
n_cst_beo_Event	lnv_SourceEvent

lnv_SourceEvent = CREATE n_cst_beo_Event
IF lnv_Privs.of_Allowalteritins( ) THEN

	THIS.of_RetrieveEvents ( {al_SourceEventID} ) 
	
	lnv_SourceEvent.of_SetSource ( THIS.of_GetEventCache ( ) ) 
	lnv_SourceEvent.of_SetSourceID ( al_SourceEventID )
	
	IF lnv_SourceEvent.of_hasSource ( ) THEN
		ld_RoutingDate = lnv_SourceEvent.of_GetDateArrived ( )
		lnv_SourceEvent.of_getassignments ( lla_DontCare, lla_PowerEquipment, lla_DontCare, lla_DontCare )
	ELSE
		li_Return = -1
	END IF
	
	IF li_Return = 1 THEN
		IF UpperBound ( lla_PowerEquipment ) > 0 THEN
			li_RouteRtn = THIS.of_Route (ala_TargetEventids[], gc_dispatch.ci_ItinType_PowerUnit, lla_PowerEquipment[1], &
												  ld_RoutingDate, 0 /*DateScaleStyle!*/, al_SourceEventID , ai_InsertionStyle ) 
			IF li_RouteRtn <> 1 THEN
				li_Return = -1
			END IF
			
		ELSE						
			li_Return = 0
		END IF
	END IF
ELSE
	li_Return = 0
END IF

DESTROY ( lnv_SourceEvent )

RETURN li_Return
end function

public function integer of_setref ();// RDT 8-13-03 This was copied from w_dispatch.setref() with minor modifications and tested with event auto routing.
// Returns 1=Success, -1=failed

integer 	evrows, &
			li_Return = 1, &
			checkloop, &
			markloop, &
			displen, &
			prevlen

long 		dispid, &
			previd[3], &
			ev_id

string 	disptype, &
			dispref, &
			prevtype[2 to 3], &
			prevref[3], &
			dispfn, &
			displn, &
			prevfn, &
			prevln, &
			col_hdr

char 		check_type

n_cst_Events	lnv_Events

datastore 	ds_emp

s_eq_info 	find_eqs
s_emp_info 	find_ems

// PreProcess tests
If This.of_hasshipmentscached ( ) Then 
	// continue
Else
	li_Return = -1
End If

If IsValid( ids_eventcache ) Then 
	// continue
Else
	li_Return = -1
End If


If li_Return = 1 then 
	ds_emp = create datastore
	ds_emp.dataobject = "d_emp_list"
	
	evrows = ids_eventcache.rowcount()
	
	if evrows < 1 then 
		li_return = -1
	End If

End If

If li_Return = 1 then 	
	
	dwObject	ldwo_Trailer1Type, &
				ldwo_Trailer1Length, &
				ldwo_Trailer2Type, &
				ldwo_Trailer2Length, &
				ldwo_Trailer3Type, &
				ldwo_Trailer3Length, &
				ldwo_Container1Length, &
				ldwo_Container2Length, &
				ldwo_Container3Length, &
				ldwo_Container4Length, &
				ldwo_ContainerMap
	
	ldwo_Trailer1Type = ids_EventCache.Object.Trlr1_Type
	ldwo_Trailer1Length = ids_EventCache.Object.Trlr1_Length
	ldwo_Trailer2Type = ids_EventCache.Object.Trlr2_Type
	ldwo_Trailer2Length = ids_EventCache.Object.Trlr2_Length
	ldwo_Trailer3Type = ids_EventCache.Object.Trlr3_Type
	ldwo_Trailer3Length = ids_EventCache.Object.Trlr3_Length
	ldwo_Container1Length = ids_EventCache.Object.Cntn1_Length
	ldwo_Container2Length = ids_EventCache.Object.Cntn2_Length
	ldwo_Container3Length = ids_EventCache.Object.Cntn3_Length
	ldwo_Container4Length = ids_EventCache.Object.Cntn4_Length
	ldwo_ContainerMap = ids_EventCache.Object.ContainerMap
	
	
	for markloop = 1 to evrows
		setnull(dispfn)
		setnull(displn)
		setnull(dispref)
		dispid = ids_EventCache.object.de_driver[markloop]
		if dispid > 0 then
			if previd[1] = dispid then
				dispfn = prevfn
				displn = prevln
				dispref = prevref[1]
			else
				find_ems.em_id = dispid
				if gf_emp_info(ds_emp, null_str, null_str, find_ems) > 0 then
					dispfn = find_ems.em_fn
					displn = find_ems.em_ln
					dispref = find_ems.em_ref
					previd[1] = dispid
					prevfn = dispfn
					prevln = displn
					prevref[1] = dispref
				end if
			end if
		end if
		ids_EventCache.object.driv_fn[markloop] = dispfn
		ids_EventCache.object.driv_ln[markloop] = displn
		ids_EventCache.object.driv_ref[markloop] = dispref
		for checkloop = 2 to 10
			setnull(disptype)
			setnull(dispref)

			setnull(displen)
			choose case checkloop
				case 2
					dispid = ids_EventCache.object.de_tractor[markloop]
					col_hdr = "trac"
				case 3
					dispid = ids_EventCache.object.de_trailer1[markloop]
					col_hdr = "trlr1"
				case 4
					dispid = ids_EventCache.object.de_trailer2[markloop]
					col_hdr = "trlr2"
				case 5
					dispid = ids_EventCache.object.de_trailer3[markloop]
					col_hdr = "trlr3"
				case 6
					dispid = ids_EventCache.object.de_container1[markloop]
					col_hdr = "cntn1"
				case 7
					dispid = ids_EventCache.object.de_container2[markloop]
					col_hdr = "cntn2"
				case 8
					dispid = ids_EventCache.object.de_container3[markloop]
					col_hdr = "cntn3"
				case 9
					dispid = ids_EventCache.object.de_container4[markloop]
					col_hdr = "cntn4"
				case 10
					dispid = ids_EventCache.object.de_acteq[markloop]
					col_hdr = "acteq"
			end choose
			if dispid > 0 then
				if previd[2] = dispid then
					disptype = prevtype[2]
					dispref = prevref[2]
				elseif previd[3] = dispid then
					disptype = prevtype[3]
					dispref = prevref[3]
					displen = prevlen
				else
					find_eqs.eq_id = dispid
					if gf_eq_info(ids_EquipmentCache, null_str, null_str, find_eqs) > 0 then
						disptype = find_eqs.eq_type
						dispref = find_eqs.eq_ref
						displen = find_eqs.eq_length
						if checkloop = 2 then
							prevtype[2] = disptype
							prevref[2] = dispref
						elseif (checkloop > 2 and checkloop < 6) or checkloop = 10 then
							prevtype[3] = disptype
							prevref[3] = dispref
							prevlen = displen
						end if
					end if
				end if
			end if
			if checkloop < 6 or checkloop > 9 then &
				ids_EventCache.setitem(markloop, col_hdr + "_type", disptype)
			ids_EventCache.setitem(markloop, col_hdr + "_ref", dispref)
			if checkloop > 2 then &
				ids_EventCache.setitem(markloop, col_hdr + "_length", displen)
		next
	
		ids_EventCache.object.interch[markloop] = null_long
		check_type = ids_EventCache.object.de_event_type[markloop]
		if pos("HRMN", check_type) > 0 then
			ev_id = ids_EventCache.object.de_id[markloop]
			find_eqs.eq_id = ids_EventCache.object.de_acteq[markloop]
			if gf_eq_info(ids_EquipmentCache, null_str, null_str, find_eqs) > 0 then
				choose case check_type
					case "H", "M"
						if find_eqs.oe_orig_event = ev_id then &
							ids_EventCache.object.interch[markloop] = 1
					case "R", "N"
						if find_eqs.oe_term_event = ev_id then &
							ids_EventCache.object.interch[markloop] = 1
				end choose
			end if
		end if
	
		ldwo_ContainerMap.Primary [ markloop ] = lnv_Events.of_GetContainerMap ( &
			ldwo_Trailer1Type.Primary [ markloop ], &
			ldwo_Trailer1Length.Primary [ markloop ], &
			ldwo_Trailer2Type.Primary [ markloop ], &
			ldwo_Trailer2Length.Primary [ markloop ], &
			ldwo_Trailer3Type.Primary [ markloop ], &
			ldwo_Trailer3Length.Primary [ markloop ], &
			ldwo_Container1Length.Primary [ markloop ], &
			ldwo_Container2Length.Primary [ markloop ], &
			ldwo_Container3Length.Primary [ markloop ], &
			ldwo_Container4Length.Primary [ markloop ] )
	
	next
	
	DESTROY ldwo_Trailer1Type
	DESTROY ldwo_Trailer1Length
	DESTROY ldwo_Trailer2Type
	DESTROY ldwo_Trailer2Length
	DESTROY ldwo_Trailer3Type
	DESTROY ldwo_Trailer3Length
	DESTROY ldwo_Container1Length
	DESTROY ldwo_Container2Length
	DESTROY ldwo_Container3Length
	DESTROY ldwo_Container4Length
	DESTROY ldwo_ContainerMap
	
End If //li_Return = 1	

If IsValid( ds_emp ) Then 
	Destroy( ds_emp ) 
End if

Return li_Return 
end function

public function integer of_allowendtripnewtripremoval (long al_endtripid, long al_newtripid);//This function will determine if it is ok to remove an EndTrip event and a NewTrip event together.  
//The pair must meet several criteria in order for this to be approved:
//1)	The EndTrip and NewTrip must be assigned to the same Driver and PowerUnit (or to the same 
//		Driver OR PowerUnit, if they're only assigned to one or the other)
//2)	The NewTrip event must immediately follow the EndTrip event in BOTH the Driver and PowerUnit 
//		itineraries.

//The function assumes the EndTrip and NewTrip events are already in the cache.

//Returns:
// 1 = OK to remove the EndTrip / NewTrip combination.
// 0 = Not a scenario we can evaluate here, try removal by normal remove handling.
//-1 = Not ok to remove the EndTrip / NewTrip combination, due to conflict, or processing error

//Created 3.9.00 4/15/04 BKW


Long		ll_EndTripDriver, &
			ll_EndTripPowerUnit, &
			ll_NewTripDriver, &
			ll_NewTripPowerUnit, &
			ll_Count
Date		ld_EndTripDate, &
			ld_NewTripDate
String	ls_ErrorMessage
Decimal	lc_EndTripDriverSeq, &
			lc_EndTripPowerUnitSeq, &
			lc_NewTripDriverSeq, &
			lc_NewTripPowerUnitSeq

n_cst_beo_Event	lnv_EndTrip, &
						lnv_NewTrip
						
DataStore			lds_PowerUnit, &
						lds_Driver

Date		ld_Null
SetNull ( ld_Null )

Integer	li_Return = 1


//Create a beo for the EndTrip and NewTrip by pointing at the cache.  Then, get some basic info off it that we need.

IF li_Return = 1 THEN

	lnv_EndTrip = CREATE n_cst_beo_Event

	lnv_EndTrip.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_EndTrip.of_SetSourceId ( al_EndTripId )
	
	
	IF lnv_EndTrip.of_IsType ( gc_Dispatch.cs_EventType_EndTrip ) THEN
		
		ld_EndTripDate = lnv_EndTrip.of_GetDateArrived ( )
		ll_EndTripDriver = lnv_EndTrip.of_GetDriverId ( )
		lc_EndTripDriverSeq = lnv_EndTrip.of_GetDriverSeq ( )
		ll_EndTripPowerUnit = lnv_EndTrip.of_GetTractorId ( )
		lc_EndTripPowerUnitSeq = lnv_EndTrip.of_GetTractorSeq ( )
				
	ELSE
		li_Return = -1
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	lnv_NewTrip = CREATE n_cst_beo_Event
	
	lnv_NewTrip.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_NewTrip.of_SetSourceId ( al_NewTripId )
	

	IF lnv_NewTrip.of_IsType ( gc_Dispatch.cs_EventType_NewTrip ) THEN

		ld_NewTripDate = lnv_NewTrip.of_GetDateArrived ( )
		ll_NewTripDriver = lnv_NewTrip.of_GetDriverId ( )
		lc_NewTripDriverSeq = lnv_NewTrip.of_GetDriverSeq ( )
		ll_NewTripPowerUnit = lnv_NewTrip.of_GetTractorId ( )
		lc_NewTripPowerUnitSeq = lnv_NewTrip.of_GetTractorSeq ( )
		
	ELSE
		li_Return = -1
		
	END IF
	
END IF


//Do a basic check that the NewTrip isn't routed to a date prior to the EndTrip.  If it is, this is a 
//scenario we can't assess here, and should be tried with conventional remove logic.

IF li_Return = 1 THEN
	
	IF DaysAfter ( ld_EndTripDate, ld_NewTripDate ) < 0 THEN
		
		li_Return = 0
		
	END IF
	
END IF


//Verify whether the EndTrip and NewTrip are assigned to the same drivers and powerunits, and whether the new trip
//follows the end trip.  If the new trip precedes the end trip, this is not a scenario we can evaluate here, and
//will have to be assessed with conventional remove logic.

IF li_Return = 1 THEN
	
	IF ll_EndTripDriver = ll_NewTripDriver AND ll_EndTripPowerUnit = ll_NewTripPowerUnit THEN
		
		IF DaysAfter ( ld_EndTripDate, ld_NewTripDate ) > 0 THEN
			
			//New trip is after end trip -- we can evaluate here.  Proceed with subsequent checks.
			
		ELSEIF lc_NewTripPowerUnitSeq > lc_EndTripPowerUnitSeq AND lc_NewTripDriverSeq > lc_EndTripDriverSeq THEN
			
			//We already know they're on the same day, based on previous date comparisons.
			//By Seq values, New trip is after end trip -- we can evaluate here.  Proceed with subsequent checks.
			
		ELSE
			
			//New trip is before end trip -- we cannot evaluate here.  Flag to process with conventional logic.
			
			li_Return = 0
			
		END IF
		
	ELSEIF ll_EndTripDriver = ll_NewTripDriver AND IsNull ( ll_EndTripPowerUnit ) AND IsNull ( ll_NewTripPowerUnit ) THEN
		
		IF DaysAfter ( ld_EndTripDate, ld_NewTripDate ) > 0 THEN
			
			//New trip is after end trip -- we can evaluate here.  Proceed with subsequent checks.
			
		ELSEIF lc_NewTripDriverSeq > lc_EndTripDriverSeq THEN  //We already know they're on the same day.
			
			//We already know they're on the same day, based on previous date comparisons.
			//By Seq values, New trip is after end trip -- we can evaluate here.  Proceed with subsequent checks.
			
		ELSE
			
			//New trip is before end trip -- we cannot evaluate here.  Flag to process with conventional logic.
			
			li_Return = 0
			
		END IF

		
	ELSEIF ll_EndTripPowerUnit = ll_NewTripPowerUnit AND IsNull ( ll_EndTripDriver ) AND IsNull ( ll_NewTripDriver ) THEN
		
		IF DaysAfter ( ld_EndTripDate, ld_NewTripDate ) > 0 THEN
			
			//New trip is after end trip -- we can evaluate here.  Proceed with subsequent checks.
			
		ELSEIF lc_NewTripPowerUnitSeq > lc_EndTripPowerUnitSeq THEN
			
			//We already know they're on the same day, based on previous date comparisons.
			//By Seq values, New trip is after end trip -- we can evaluate here.  Proceed with subsequent checks.
			
		ELSE
			
			//New trip is before end trip -- we cannot evaluate here.  Flag to process with conventional logic.
			
			li_Return = 0
			
		END IF
		
	ELSE
		
		//They NewTrip and EndTrip are not assigned to the same Drivers & PowerUnits.
		//This is not a scenario that can be handled either here or by conventional remvoe logic.
		//Go ahead and reject it.
		li_Return = -1
		
	END IF
	
END IF



//Retrieve the PowerUnit itinerary from the EndTrip point forward.  (We DON'T need the prior event) 

IF li_Return = 1 THEN

	CHOOSE CASE This.of_RetrieveItinerary ( gc_Dispatch.ci_ItinType_PowerUnit, ll_EndTripPowerUnit, ld_EndTripDate, ld_Null, FALSE /*Don't Need Prior*/ )
	
	CASE 1
		//Retrieved OK
	
	CASE -1
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (B)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "A check with the database indicates that information needed "+&
			"to process this request has changed since your last save.  You should attempt "+&
			"to save now, before continuing.  (B)"
		li_Return = -1

	CASE ELSE  //Unexpected return value.
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (B)"
		li_Return = -1

	END CHOOSE

END IF


//Copy the PowerUnit itinerary out to a datastore so we can work with it.

IF li_Return = 1 THEN

	//Copy everything we've got for the base id.  We'll have everything from the prior event forward,
	//but we may have a discontinuous jumble of things prior to that.

	ll_Count = This.of_CopyItinerary ( gc_Dispatch.ci_ItinType_PowerUnit, ll_EndTripPowerUnit, ld_Null, ld_Null, lds_PowerUnit )

	IF ll_Count = -1 THEN
		ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (B)"
		li_Return = -1
	ELSE
		lnv_EndTrip.of_SetSource ( lds_PowerUnit )
		lnv_EndTrip.of_SetSourceId ( al_EndTripId )
		
		lnv_NewTrip.of_SetSource ( lds_PowerUnit )
		lnv_NewTrip.of_SetSourceId ( al_NewTripId )
		
		IF lnv_EndTrip.of_GetSourceRow ( ) + 1 = lnv_NewTrip.of_GetSourceRow ( ) THEN
			//OK
		ELSE
			//The EndTrip is not immediately followed by the NewTrip.  Do not approve the request.
			li_Return = -1
		END IF
		
	END IF

END IF


//Retrieve the Driver itinerary from the EndTrip point forward.  (We DON'T need the prior event) 

IF li_Return = 1 THEN

	CHOOSE CASE This.of_RetrieveItinerary ( gc_Dispatch.ci_ItinType_Driver, ll_EndTripDriver, ld_EndTripDate, ld_Null, FALSE /*Don't Need Prior*/ )
	
	CASE 1
		//Retrieved OK
	
	CASE -1
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (B)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "A check with the database indicates that information needed "+&
			"to process this request has changed since your last save.  You should attempt "+&
			"to save now, before continuing.  (B)"
		li_Return = -1

	CASE ELSE  //Unexpected return value.
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (B)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	//Copy everything we've got for the base id.  We'll have everything from the prior event forward,
	//but we may have a discontinuous jumble of things prior to that.

	ll_Count = This.of_CopyItinerary ( gc_Dispatch.ci_ItinType_Driver, ll_EndTripDriver, ld_Null, ld_Null, lds_Driver )

	IF ll_Count = -1 THEN
		ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (B)"
		li_Return = -1
	ELSE
		lnv_EndTrip.of_SetSource ( lds_Driver )
		lnv_EndTrip.of_SetSourceId ( al_EndTripId )
		
		lnv_NewTrip.of_SetSource ( lds_Driver )
		lnv_NewTrip.of_SetSourceId ( al_NewTripId )
		
		IF lnv_EndTrip.of_GetSourceRow ( ) + 1 = lnv_NewTrip.of_GetSourceRow ( ) THEN
			//OK
		ELSE
			//The EndTrip is not immediately followed by the NewTrip.  Do not approve the request.
			li_Return = -1
		END IF
		
	END IF

END IF


DESTROY lnv_EndTrip
DESTROY lnv_NewTrip
DESTROY lds_PowerUnit
DESTROY lds_Driver

RETURN li_Return
end function

public function integer of_allowendtripremoval (long al_endtripid);//This function will determine if it is ok to remove an EndTrip event.  This will be for one of 2 reasons:
//1)  The EndTrip is missing either a Driver assignment or a PowerUnit assignment (meaning it's not doing
//		anything assignment-wise right now anyway, and can therefore be safely removed.)
//2)  The EndTrip is the last event in BOTH the driver and tractor intineraries to which it is assigned.  
//		In that case, since nothing comes after it, it can be removed with no problems.

//The function assumes the end trip event is already in the cache.

//Returns:
// 1 = OK to remove the EndTrip
//-1 = Not ok to remove the EndTrip, due to conflict, or processing error

//Created 3.9.00 4/15/04 BKW


Long		ll_EndTripDriver, &
			ll_EndTripPowerUnit, &
			ll_Count
Date		ld_EndTripDate
String	ls_ErrorMessage

Boolean	lb_CheckNeeded = TRUE  //Will be set to false if either the driver or powerunit is not assigned.
			
n_cst_beo_Event	lnv_EndTrip, &
						lnv_WorkEvent
						
DataStore			lds_Work

Date		ld_Null
SetNull ( ld_Null )

Integer	li_Return = 1


//Create a beo for the EndTrip by pointing at the cache.  Then, get some basic info off it that we need.

IF li_Return = 1 THEN

	lnv_EndTrip = CREATE n_cst_beo_Event

	lnv_EndTrip.of_SetSource ( This.of_GetEventCache ( ) )
	lnv_EndTrip.of_SetSourceId ( al_EndTripId )
	
	IF lnv_EndTrip.of_IsType ( gc_Dispatch.cs_EventType_EndTrip ) THEN
		
		ll_EndTripDriver = lnv_EndTrip.of_GetDriverId ( )
		ll_EndTripPowerUnit = lnv_EndTrip.of_GetTractorId ( )
		ld_EndTripDate = lnv_EndTrip.of_GetDateArrived ( )
		
		//If either the driver or powerunit is not assigned, flag that the full check is not needed.
		IF IsNull ( ll_EndTripDriver ) OR IsNull ( ll_EndTripPowerUnit ) THEN
			lb_CheckNeeded = FALSE
		END IF
		
	ELSE
		li_Return = -1
		
	END IF
	
END IF



//Retrieve the PowerUnit itinerary from the EndTrip point forward.  (We DON'T need the prior event) 

IF li_Return = 1 AND lb_CheckNeeded THEN

	CHOOSE CASE This.of_RetrieveItinerary ( gc_Dispatch.ci_ItinType_PowerUnit, ll_EndTripPowerUnit, ld_EndTripDate, ld_Null, FALSE /*Don't Need Prior*/ )
	
	CASE 1
		//Retrieved OK
	
	CASE -1
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (B)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "A check with the database indicates that information needed "+&
			"to process this request has changed since your last save.  You should attempt "+&
			"to save now, before continuing.  (B)"
		li_Return = -1

	CASE ELSE  //Unexpected return value.
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (B)"
		li_Return = -1

	END CHOOSE

END IF


//Copy the PowerUnit itinerary out to a datastore so we can work with it.

IF li_Return = 1 AND lb_CheckNeeded THEN

	lnv_WorkEvent = CREATE n_cst_beo_Event

	//Copy everything we've got for the base id.  We'll have everything from the prior event forward,
	//but we may have a discontinuous jumble of things prior to that.

	ll_Count = This.of_CopyItinerary ( gc_Dispatch.ci_ItinType_PowerUnit, ll_EndTripPowerUnit, ld_Null, ld_Null, lds_Work )

	IF ll_Count = -1 THEN
		ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (B)"
		li_Return = -1
	ELSE
		lnv_WorkEvent.of_SetSource ( lds_Work )
		lnv_WorkEvent.of_SetSourceRow ( ll_Count )
		
		IF lnv_WorkEvent.of_GetId ( ) = al_EndTripId THEN
			//OK
		ELSE
			//The EndTrip is not the last event in the itinerary.  Do not approve the request.
			li_Return = -1
		END IF
		
	END IF

END IF


//Retrieve the Driver itinerary from the EndTrip point forward.  (We DON'T need the prior event) 

IF li_Return = 1 AND lb_CheckNeeded THEN

	CHOOSE CASE This.of_RetrieveItinerary ( gc_Dispatch.ci_ItinType_Driver, ll_EndTripDriver, ld_EndTripDate, ld_Null, FALSE /*Don't Need Prior*/ )
	
	CASE 1
		//Retrieved OK
	
	CASE -1
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (B)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "A check with the database indicates that information needed "+&
			"to process this request has changed since your last save.  You should attempt "+&
			"to save now, before continuing.  (B)"
		li_Return = -1

	CASE ELSE  //Unexpected return value.
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (B)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_CheckNeeded THEN

	IF NOT IsValid ( lnv_WorkEvent ) THEN   //Should already have been created, but check j.i.c.
		lnv_WorkEvent = CREATE n_cst_beo_Event
	END IF

	//Copy everything we've got for the base id.  We'll have everything from the prior event forward,
	//but we may have a discontinuous jumble of things prior to that.

	ll_Count = This.of_CopyItinerary ( gc_Dispatch.ci_ItinType_Driver, ll_EndTripDriver, ld_Null, ld_Null, lds_Work )

	IF ll_Count = -1 THEN
		ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (B)"
		li_Return = -1
	ELSE
		lnv_WorkEvent.of_SetSource ( lds_Work )
		lnv_WorkEvent.of_SetSourceRow ( ll_Count )
		
		IF lnv_WorkEvent.of_GetId ( ) = al_EndTripId THEN
			//OK
		ELSE
			//The EndTrip is not the last event in the itinerary.  Do not approve the request.
			li_Return = -1
		END IF
		
	END IF

END IF


DESTROY lnv_EndTrip
DESTROY lnv_WorkEvent
DESTROY lds_Work

RETURN li_Return
end function

public function integer of_assignbyreroute (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle);RETURN THIS.of_Assignbyreroute( ai_basetype,  al_baseid, al_baseevent,  ai_targettype, al_targetid, ad_insertiondate,al_insertionevent,  ai_insertionstyle, TRUE  )
//
//
//
//
////Returns: 1 = Success, 0 = User Cancelled, -1 = Error, -2 = No events qualified for special of_AssignByReroute processing,
////			  -3  = Assignment validation Failed
////If -2 is returned, no changes were made to the cache, and normal of_Assign processing should be attempted, if possible.
//
////This function is specialized assignment logic for a specific scenario: the assignment of a driver or tractor
////to an event (and usually, in effect, an event range), that is currently routed to a trailer or container
////itinerary.  As such, ai_BaseType is expected to be either gc_Dispatch.ci_ItinType_Trailer or
////gc_Dispatch.ci_ItinType_Container.  ai_TargetType is expected to be either gc_Dispatch.ci_ItinType_Driver or
////gc_Dispatch.ci_ItinType_PowerUnit.
//
////If permissable, the assignment will be accomplished by rerouting the affected range of events that are currently
////in the trailer or container itin to the driver or tractor, and then making the assignment of the trailer or container
////onto the association event (a Hook or Mount), which has either been identified in the Trailer / Container itinerary,
////or is already routed to the driver/tractor, and has been passed in using al_InsertionEvent  (if the association
////event is supposed to come from the Trailer/Container itin, al_InsertionEvent should be passed in null.)
//
////If ai_InsertionStyle is ci_InsertionStyle_After and a Hook (for Trailer or Container basetypes) or a
////Mount (for Container basetypes) is passed in as al_InsertionEvent, we'll use that event for the
////assignment, and route the events from the Trailer or Container itin immediately after it.
////The Drop / Dismount, if any, may come from either itin, but if there is a drop or dismount
////already routed to the trailer / container itin, it will be used.  Note that the trailer / container
////events being re-routed will come between the Hook / Mount and any other events already routed
////to the Driver / Tractor after that.
//
//
//DataStore	lds_Cache, &
//				lds_Lookback
//
//n_cst_beo_Event	lnv_Event, &
//						lnv_AfterEvent, &
//						lnv_WorkEvent
//						
//
//Date		ld_AssignmentDate, &
//			ld_Null, &
//			ld_Lookback_Date
//Long		ll_Row, &
//			lla_Drivers[], &
//			lla_Tractors[], &
//			lla_TrailerChassis[], &
//			lla_Containers[], &
//			ll_Lookback_BaseId, &
//			ll_Lookback_Count
//String	ls_Lookback_Find, &
//			ls_Dissociation_Find
//Boolean	lb_Lookback_Found
//Integer	li_Lookback_BaseType, &
//			li_Lookback_Index
//n_cst_OFRError		lnv_Error, &
//						lnva_Errors[]
//
//String	ls_ErrorMessage = "Could not process request."
//
//
//Boolean	lb_CurrentlyOnTrailer, &
//			lb_CurrentlyOnContainer, &
//			lb_HasDissociationEvent, &
//			lb_AssociationInTarget	//Used to identify if the association event is in the Target Itin (ie, the Driver/Tractor),
//											//or in the Base Itin (ie, the Trailer/Container where the base event is routed.)
//Long		ll_CurrentTrailerId, &
//			ll_CurrentContainerId, &
//			ll_CurrentId, &
//			ll_StartingRow, &
//			lla_Equipment[], &
//			ll_EventId, &
//			ll_RerouteEventCount, &
//			lla_RerouteEventIds[], &
//			ll_AssociationEventId, &
//			ll_AssociationEventRow, &
//			ll_DissociationEventId, &
//			ll_DissociationEventRow, &
//			ll_BaseEventRow, &
//			ll_Route_InsertionEvent, &
//			ll_Assignment_InsertionEvent, &
//			ll_Null
//Integer	li_CurrentType, &
//			li_Route_InsertionStyle, &
//			li_Assignment_InsertionStyle, &
//			li_Null
//Date		ld_AssociationEventDate, &
//			ld_EventDate
//
//
//Integer	li_Return = 1
//
//SetNull ( ll_Null )
//SetNull ( li_Null )
//
//SetNull ( ld_Null )
//
//lnv_Event = CREATE n_cst_beo_Event
//lnv_AfterEvent = CREATE n_cst_beo_Event
//lnv_WorkEvent = CREATE n_cst_beo_Event
//
//
//lds_Cache = This.of_GetEventCache ( )
//
//lnv_Event.of_SetSource ( lds_Cache )
//lnv_Event.of_SetSourceId ( al_BaseEvent )  //Note:  This, along with al_BaseEvent, may be changed by Lookback processing.
//
////Get ld_AssignmentDate in a clean form, stripping off any unintended time component.
//ld_AssignmentDate = Date ( DateTime ( lnv_Event.of_GetDateArrived ( ) ) )
//
//
//IF ai_InsertionStyle = gc_Dispatch.ci_InsertionStyle_After AND NOT IsNull ( al_InsertionEvent ) THEN
//	
//	//This is an attempt to use the of_AssignByReroute processing when the Hook or Mount is already in
//	//the tractor or driver itin.  Make sure the al_InsertionEvent and ai_BaseType make sense for this request.
//	
//	//Set the flag to distinguish this variety of request.
//	lb_AssociationInTarget = TRUE
//	
//	lnv_AfterEvent.of_SetSource ( lds_Cache ) 
//	lnv_AfterEvent.of_SetSourceId ( al_InsertionEvent )
//	
//	ll_AssociationEventId = al_InsertionEvent
//	ld_AssociationEventDate = lnv_AfterEvent.of_GetDateArrived ( )
//	

//	IF DaysAfter ( ad_InsertionDate, ld_AssociationEventDate ) = 0 THEN
//		//OK
//	ELSE
//		ls_ErrorMessage += "~n(There was a conflict in routing dates.  The InsertionDate and AssociationEventDate were different.)  (ABR)"
//		li_Return = -1
//	END IF
//	
//	
//	//Tack this problem on to the previous one, if they're both not what we expect.
//	
//	CHOOSE CASE lnv_AfterEvent.of_GetType ( )
//			
//		CASE gc_Dispatch.cs_EventType_Hook
//			
//			IF ai_BaseType = gc_Dispatch.ci_ItinType_TrailerChassis OR ai_BaseType = gc_Dispatch.ci_ItinType_Container THEN
//				
//				//OK
//				
//			ELSE
//				
//				ls_ErrorMessage += "~n(Unexpected BaseType and EventType parameter pairing.)  (ABR-H)"
//				li_Return = -1
//				
//			END IF
//			
//		CASE gc_Dispatch.cs_EventType_Mount
//			
//			IF ai_BaseType = gc_Dispatch.ci_ItinType_Container THEN
//				
//				//OK
//				
//			ELSE
//
//				ls_ErrorMessage += "~n(Unexpected BaseType and EventType parameter pairing.)  (ABR-M)"
//				li_Return = -1
//				
//			END IF
//			
//		CASE ELSE
//			
//			ls_ErrorMessage += "~n(Unexpected EventType parameter.)  (ABR)"
//			li_Return = -1
//			
//	END CHOOSE
//	
//END IF
//
//
//
////Verify that the trailer or container is the only thing assigned to the base event.  
////(If the base event is indeed routed to a trailer or container, this should be the case under the 
////current rules, but let's not assume).  If it is the only thing assigned, hold that assignment, 
////so we can reassign it later, if everything works out.  
////If it's not the only thing assigned, fail this request.
//
////Retrieve the trailer or container itinerary, in a lookback loop, and going all the way forward
//
////In the lookback loop, try to find the starting event
//
////Then, determine the ending event  (either there'll be one, or there won't, which means
////the whole thing from the starting event forward has to be rerouted.
//
////Verify that the trailer or container is the only thing assigned to the whole range of events, 
////and that there are no "active" assignments anywhere in the range.
//
////Then, based on those events, attempt to identify an insertionpoint for that whole block of 
////events in the target itinerary.
//
////Then, try to route the block to the insertion point.
//
////Then, try to reassign the equipment to the block (by assigning it to the starting extent event.)
//
////If the reassignment does not succeed, you could still succeed the reroute (?)	
//	
//
//
//
//IF li_Return = 1 THEN
//	
//	//Verify that the trailer or container is the only thing assigned to the base event.  
//	//(If the base event is indeed routed to a trailer or container, this should be the case under the 
//	//current rules, but let's not assume).  If it is the only thing assigned, hold that assignment, 
//	//so we can reassign it later, if everything works out.  
//	//If it's not the only thing assigned, fail this request.	
//
//	CHOOSE CASE lnv_Event.of_GetAssignments ( lla_Drivers, lla_Tractors, lla_TrailerChassis, lla_Containers )
//			
//	CASE 1
//		
//		IF UpperBound ( lla_Drivers ) > 0 OR UpperBound ( lla_Tractors ) > 0 THEN
//			
//			ls_ErrorMessage += "~n(There is already a driver or tractor assigned.)  (ABR)"
//			li_Return = -1
//			
//		ELSEIF UpperBound ( lla_TrailerChassis ) = 1 AND UpperBound ( lla_Containers ) = 0 THEN
//			
//			lb_CurrentlyOnTrailer = TRUE
//			ll_CurrentTrailerId = lla_TrailerChassis [ 1 ]
//			
//			li_CurrentType = gc_Dispatch.ci_ItinType_TrailerChassis
//			ll_CurrentId = ll_CurrentTrailerId
//			
//			ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'"
//			
//			//Note:  This will prevent the re-routing grabbing the front-end of a drop & hook that's 
//			//routed to the trailer/container.  Is this a good thing?
//			
//		ELSEIF UpperBound ( lla_TrailerChassis ) = 0 AND UpperBound ( lla_Containers ) = 1 THEN
//			
//			lb_CurrentlyOnContainer = TRUE
//			ll_CurrentContainerId = lla_Containers [ 1 ]			
//			
//			li_CurrentType = gc_Dispatch.ci_ItinType_Container
//			ll_CurrentId = ll_CurrentContainerId
//			
//			ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'" + " OR " +&
//				"de_event_type = '" + gc_Dispatch.cs_EventType_Mount + "'" 
//				
//			//Note:  This will prevent the re-routing grabbing the front-end of a drop & hook that's 
//			//routed to the trailer/container.  Is this a good thing?
//			
//		ELSE
//			
//			ls_ErrorMessage += "~n(The events are not assigned to a single trailer or container.)  (ABR)"
//			li_Return = -1
//			
//		END IF
//		
//		
//		IF li_Return = 1 AND lb_AssociationInTarget THEN
//			
//			//If the association is in the target, add on to the lookback criteria any NewTrip, EndTrip, 
//			//or anything with a driver or tractor already assigned, or before the association event date, 
//			//or anything that's confirmed (events that could be confirmed with only trailer/container routing
//			//such as cs_EventType_PositionReport, cs_EventType_Repairs, cs_EventType_Reposition, cs_EventType_PMService
//			//will be prevented from getting pulled into an association with tractor/driver that wasn't intended).  
//			//We don't actually need to find an association event, we just need to find the first event we can't 
//			//(or don't want to) re-reoute -- the association event from the target itin will be inserted after this event.
//			ls_Lookback_Find += " OR de_driver > 0 OR de_tractor > 0 OR de_arrdate < " +& 
//				String ( ld_AssociationEventDate, "yyyy-mm-dd" ) + " OR de_conf = 'T'"
//			
//		END IF
//		
//		
//	CASE ELSE  //-1, or unexpected return
//		
//		ls_ErrorMessage += "~n(Could not determine base event assignments.)  (ABR)"
//		li_Return = -1
//		
//	END CHOOSE
//
//END IF
//
//
//IF li_Return = 1 THEN
//	
//	li_Lookback_BaseType = li_CurrentType
//	ll_Lookback_BaseId = ll_CurrentId
//
////	FOR li_Lookback_Index = 1 TO 3
//	FOR li_Lookback_Index = 1 TO 1	//Due to the issues associated with trying to do this for multi-day routes,
//												//I'm just going to look at the day of the request, even though this was
//												//originally coded for looking back further.  I'm keeping the loop code around,
//												//in case we want it, though.
//
//		CHOOSE CASE li_LookBack_Index
//
//		CASE 1
//
//			ld_Lookback_Date = ld_AssignmentDate	//Just look at the day the event is on
//
//		CASE 2
//
//			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -3 )  //Look back 3 days
//
//		CASE 3
//
//			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -7 )  //Look back 7 days
//
//		END CHOOSE
//
//
//		CHOOSE CASE This.of_RetrieveItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, ld_Null /*Go all the way fwd*/, FALSE /*Don't need Prior*/ )
//		
//		CASE 1
//			//Retrieved OK
//		
//		CASE -1
//			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (ABR-L)"
//			li_Return = -1
//			EXIT  //Exit the Lookback loop
//	
//		CASE -2
//			ls_ErrorMessage = "A check with the database indicates that information needed "+&
//				"to process this request has changed since your last save.  You should attempt "+&
//				"to save now, before continuing.  (ABR-L)"
//			li_Return = -1
//			EXIT  //Exit the Lookback loop
//	
//		CASE ELSE  //Unexpected return value.
//			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (ABR-L)"
//			li_Return = -1
//			EXIT  //Exit the lookback loop
//	
//		END CHOOSE
//
//
//		ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, &
//			ld_Null /*Go all the way forward*/, lds_Lookback )
//
//		IF ll_Lookback_Count = -1 THEN
//			ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (ABR-L)"
//			li_Return = -1
//			EXIT  //Exit the lookback loop
//		END IF
//
//
//		//Find the assignment event in the lookback itinerary datastore.
//		
//		lnv_WorkEvent.of_SetSource ( lds_Lookback )
//		lnv_WorkEvent.of_SetSourceId ( al_BaseEvent )
//	
//		//Try to find a source row in the primary buffer only.
//		ll_BaseEventRow = lnv_WorkEvent.of_GetSourceRow ( )
//	
//		IF ll_BaseEventRow > 0 THEN
//			//OK
//		ELSE
//			ls_ErrorMessage += "~n(Could not identify assignment row.)  (ABR-L)"
//			li_Return = -1
//			EXIT //Exit the lookback loop
//		END IF
//
//
//		//Search backwards from the requested row, looking to find the first eligible association row.
//		ll_Row = lds_Lookback.Find ( ls_Lookback_Find, ll_BaseEventRow, 1 )  
//
//		CHOOSE CASE ll_Row
//
//		CASE IS > 0
//
//			IF lb_AssociationInTarget THEN
//				
//				//Barring any of the other checks below interfering, ll_StartingRow will be immediately after the row
//				//we just found.  So, set ll_StartingRow presuming no issues, and if the code below needs to adjust it,
//				//or fail the operation, it will.
//				ll_StartingRow = ll_Row + 1
//				
//
//				//If the "association" event identified was a hook or a mount, (note, "association" is used somewhat loosely
//				//here, since we're really just finding the first event we can't route after the AssociationInTarget event),
//				//then we don't want to jump into this range.  Look forward to find a dissociation event.  If we can find one,
//				//we'll route the association right after that.  If we can't, we'll disqualify the request, and fail.
//				
//				IF ll_Row < ll_BaseEventRow THEN   //If ll_Row = ll_BaseEventRow, we don't need this check.
//				
//					lnv_WorkEvent.of_SetSource ( lds_Lookback )
//					lnv_WorkEvent.of_SetSourceRow ( ll_Row )
//					
//					
//					CHOOSE CASE lnv_WorkEvent.of_GetType ( )
//							
//						CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
//							
//							ls_Dissociation_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Drop + "'"
//							
//							IF lb_CurrentlyOnContainer THEN
//								
//								ls_Dissociation_Find +=  " OR de_event_type = '" + gc_Dispatch.cs_EventType_Dismount + "'"
//								
//							END IF
//							
//							ll_DissociationEventRow = lds_Lookback.Find ( ls_Dissociation_Find, ll_Row + 1, ll_BaseEventRow )
//							
//							
//							IF ll_DissociationEventRow > 0 THEN
//						
//								ll_StartingRow = ll_DissociationEventRow + 1
//								
//							ELSE
//								
//								//The association opened by the Hook or Mount we found does not get closed prior to reaching 
//								//al_BaseEvent.
//								
//								//We do not want to jump into this range, since it probably was intented to stay together 
//								//(not be interrupted by an extraneous Hook/Mount and tractor/driver assignment, which is
//								//what we'd be doing.)
//								
//								//So, attempt having ll_StartingRow be immediately after al_BaseEvent.
//								//The additional checks that follow will determine if this is a valid place to insert or not.
//								
//								ll_StartingRow = ll_BaseEventRow + 1
//								
//							END IF
//							
//							
//							//Clear the value in ll_DissociationEventRow.  The variable is used separately, later.
//							ll_DissociationEventRow = 0
//							
//						CASE ELSE  //Event types other than Hook/Mount
//							
//							//Ok, go ahead and jump in right after the row proposed.  
//							//ll_StartingRow is already set correctly for this.
//							
//					END CHOOSE
//					
//				ELSEIF ll_Row = ll_BaseEventRow THEN   //This should be the only other outcome, based on find parms & CASE statement
//					
//					//Ok, go ahead and jump in right after the row proposed (which is ll_BaseEventRow)
//					//ll_StartingRow is already set correctly for this.
//					
//					
//				ELSE   //Shouldn't happen, based on find parms & CASE statement.
//					
//					ls_ErrorMessage += "~n(Unexpected value for Row / BaseEventRow.)  (ABR)"
//					li_Return = -1
//					EXIT
//					
//				END IF						
//				
//				
//				//Since this section is for lb_AssociationInTarget:
//				
//				//We already have set ll_AssociationEventId and ld_AssociationEventDate at the beginning of the script,
//				//when we set lb_AssociationInTarget = TRUE (they're in the driver/tractor itin), so we don't do that here.
//				
//				
//			ELSE
//
//				//The row we've just identified is the association event.  Get the event id and date for use later.
//			
//				lnv_WorkEvent.of_SetSource ( lds_Lookback )
//				lnv_WorkEvent.of_SetSourceRow ( ll_Row )
//				ll_AssociationEventId = lnv_WorkEvent.of_GetId ( )
//				ld_AssociationEventDate = lnv_WorkEvent.of_GetDateArrived ( )
//				
//				IF IsNull ( ll_AssociationEventId ) OR IsNull ( ld_AssociationEventDate ) THEN
//					ls_ErrorMessage += "~n(Processing Error: Could not determine Association ID or Date.)  (ABR-H)"
//					li_Return = -1
//					EXIT
//				END IF
//
//				ll_StartingRow = ll_Row
//				
//			END IF
//
//			lb_Lookback_Found = TRUE
//			EXIT  //Now, try to process the assignment
//
//		CASE 0
//
//			IF lb_AssociationInTarget THEN
//				
//				//No problematic rows were found.  Assignment can be made from the beginning of the day.
//				
//				ll_StartingRow = 1
//				lb_Lookback_Found = TRUE
//				EXIT
//				
//			ELSE
//
//				//No eligible row found, continue on in the loop to look further backwards
//				
//				//Note that in the single-loop structure we've gone with, this will result in a failure.
//				//However, in a multi-loop structure, we'd just be looking farther back.
//				
//			END IF
//
//		CASE ELSE
//
//			ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (ABR-L)"
//			li_Return = -1
//			EXIT  //Exit the lookback loop
//
//		END CHOOSE
//
//	NEXT  //li_Lookback_Index
//	
//	
//	IF li_Return = 1 THEN
//
//		IF lb_Lookback_Found = TRUE THEN
//			//OK
//		ELSE
//			ls_ErrorMessage += "~n(Could not determine the Hook/Mount to use for the assignment.)  (ABR)"
//			li_Return = -1
//			//Note:  You could potentially interpret the request as just to reassign the events to the
//			//driver/tractor, and take it off the trailer/container.  Or, you could potentiall automatically
//			//insert a hook/mount to make the assignment.  Not going to attempt those at this time, however.
//		END IF
//
//	END IF
//	
//	//Note that if li_Return is still = 1, then we have lb_Lookback_Found = TRUE, and we have a value
//	//for ll_StartingRow, ll_AssociationEventId, and ld_AssociationEventDate
//
//END IF
//
//
////Decided not to do this....
////
////IF li_Return = 1 THEN
////	
////	//We're going to look PRIOR to the assignment event for any other events that should come with it.
////	//These events will have to be on the same day as the assignment event, because they'll need to be
////	//re-routed along with it.
////	
////	//An example would be if the assignment event is a mount, 
////	
////	lnv_WorkEvent.of_SetSource ( lds_Lookback )
////	
////	FOR ll_Row =  ll_AssignmentRow - 1 TO 1 STEP -1
////		
////		lnv_WorkEvent.of_SetSourceRow ( ll_Row )
////		
////		IF lnv_WorkEvent.of_HasSource ( ) THEN
////			//OK
////		ELSE
////			EXIT  //Not going to consider this a fatal error, since we've already identified something to assign.
////					//Although it certainly would be an unexpected & mysterious error.
////		END IF
////		
////		IF DaysAfter ( lnv_WorkEvent.of_GetDateArrived ( ), ld_AssignmentDate ) > 0 THEN
////			//The event we're looking at is on a prior day, and can't be routed with the assignment event.
////			//Exit the loop.  We've grabbed all the events we can.
////
//
//
//
//
//IF li_Return = 1 THEN
//	
//	lnv_WorkEvent.of_SetSource ( lds_Lookback )
//	
//	//Then, determine the ending event  (either there'll be one, or there won't, which means
//	//the whole thing from the starting event forward has to be rerouted.
//	
//	//As we go, verify that the trailer or container is the only thing assigned to the whole range of events, 
//	//and that there are no "active" assignments anywhere in the range
//	
//	//If we go onto a different day without finding a dissociation event, fail.
//	
//	
//	FOR ll_Row = ll_StartingRow TO ll_Lookback_Count
//		
//		lnv_WorkEvent.of_SetSourceRow ( ll_Row )
//		
//		ll_EventId = lnv_WorkEvent.of_GetId ( )
//		ld_EventDate = lnv_WorkEvent.of_GetDateArrived ( )
//		
//		IF IsNull ( ll_EventId ) OR IsNull ( ld_EventDate ) THEN
//			
//			ls_ErrorMessage += "~n(Processing Error: Could not verify dissociation.  Could not determine the ID or Date for an event.)  (ABR-DL)"
//			li_Return = -1
//			EXIT
//			
//		ELSEIF DaysAfter ( ld_AssociationEventDate, ld_EventDate ) <> 0 THEN
//			
//			/*Decided I didn't need to distinguish between lb_AssociationInTarget TRUE/FALSE, since both were going to
//				be failures, and I could use the same error message for both.  I've left the conditional structure, j.i.c.
//			
//			IF lb_AssociationInTarget THEN
//				
//				//I was going to do this....
//				//There might be a dissociation in target, too.  Go ahead and attempt the re-route.
//				//....in which case, I had no code here, I just let it exit the loop at this point, with li_Return = 1
//				//(See the EXIT statement after the END IF, below)
//				
//				//But IF there was NOT a dissociation in the target, the events were getting routed to the tractor/driver, 
//				//and then the assignment was failing because of this event on the later day, which is awkward.
//				//So, I think it's better to disallow the whole operation, unless we can get around that problem.
//				
//				//If we could determine if there's a dissociation in the target (Driver/Tractor Itin), then we could go
//				//ahead and allow the reroute, since the dissociation would be taken care of.
//				
//			*/
//				
//				IF lb_CurrentlyOnContainer THEN
//
//					ls_ErrorMessage += "~n~nThere is no drop or dismount following the assignment on the day you are requesting in the container itinerary, "+&
//						"and there are events routed to the container on a following day.  This situation cannot be processed automatically.  "+&
//						"You will either need to reroute these events to the driver/tractor manually before assigning the container, "+&
//						"or you will need to add a dismount or drop to the end of the container itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
//						"The first event that is routed to the container after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".  (ABR)"
//
////					Another attempt at an explanation
////					ls_ErrorMessage += "~n(There are events pre-routed to the container itinerary on more than one day, "+&
////						"with no driver/tractor assignment and no dismount or drop in between.  This situation cannot be processed automatically.  "+&
////						"You will either need to reroute these events to the driver/tractor manually before assigning the container, "+&
////						"or you will need to add a dismount or drop to the end of the container itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
////						"The first event that is routed to the container after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"
//
////					Another attempt at an explanation....
////					ls_ErrorMessage += "~n(There are events in the container itinerary without a driver/tractor assignment "+&
////						"that should be included in this request, but there are also events routed on a later day, " +&
////						"with no dismount or drop in between.  "+&
////						"You will therefore need to reroute these events to the driver/tractor manually "+&
////						"before assigning the container, or add a drop or dismount to the container itinerary.  The first event that is routed "+&
////						"to the container after the assignment date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"
//					
//				ELSE  //Should be lb_CurrentlyOnTrailer
//
//					ls_ErrorMessage += "~n~nThere is no drop following the assignment on the day you are requesting in the trailer itinerary, "+&
//						"and there are events routed to the trailer on a following day.  This situation cannot be processed automatically.  "+&
//						"You will either need to reroute these events to the driver/tractor manually and then assign the trailer, "+&
//						"or you will need to add a drop to the end of the trailer itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
//						"The first event that is routed to the trailer after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".  (ABR)"
//
////					Another attempt at an explanation...
////					ls_ErrorMessage += "~n(There are events pre-routed to the trailer itinerary on more than one day, "+&
////						"with no driver/tractor assignment and no drop in between.  This situation cannot be processed automatically.  "+&
////						"You will either need to reroute these events to the driver/tractor manually before assigning the trailer, "+&
////						"or you will need to add a drop to the end of the trailer itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
////						"The first event that is routed to the trailer after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"
//					
////					Another attempt at an explanation...
////					ls_ErrorMessage += "~n(There are events in the trailer itinerary without a driver/tractor assignment "+&
////						"that should be included in this request, but there are also events routed on a later day, "+&
////						"with no drop in between.  You will therefore need to reroute these events to the driver/tractor manually "+&
////						"before assigning the trailer, or add a drop to the trailer itinerary.  The first event that is routed "+&
////						"to the trailer after the assignment date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"
//					
//				END IF
//					
//				li_Return = -1
//
//			/*Not distinguishing between lb_AssociatedInTarget TRUE/FALSE
//
//			ELSE
//				
//				//Since the association event is coming from the trailer/container itin, and will be routed after all the other events 
//				//in the target (driver/tractor itin), we're not going to get the dissociation we need.  Fail now.
//				
//				ls_ErrorMessage += ???
//				li_Return = -1
//				
//			END IF
//			
//			*/
//			
//			EXIT
//			
//		ELSE
//			
//			//I'm going to do this here, before all the subsequent checks, because if the checks fail,
//			//the whole operation will fail, and if the checks succeed, this event will definitely be
//			//one of the ones rerouted.  If I hold it to the end of the loop, it could be inadvertently
//			//bypassed if someone were to add a CONTINUE in the loop somewhere.
//			ll_RerouteEventCount ++
//			lla_RerouteEventIds [ ll_RerouteEventCount ] = ll_EventId
//			
//		END IF
//		
//		
//		IF lnv_WorkEvent.of_GetAssignments ( lla_Drivers, lla_Equipment ) = 1 THEN
//			
//			IF UpperBound ( lla_Drivers ) = 0 AND UpperBound ( lla_Equipment ) = 1 THEN
//				
//				IF lla_Equipment [ 1 ] = ll_CurrentId THEN
//					
//					//OK
//					
//				ELSE
//					
//					ls_ErrorMessage += "~n(There are conflicting equipment assignments in the event range.)"
//					li_Return = -1
//					EXIT
//					
//				END IF
//				
//			ELSE
//				
//				ls_ErrorMessage += "~n(There are conflicting driver/equipment assignments in the event range.)"
//				li_Return = -1
//				EXIT
//				
//			END IF
//			
//		ELSE
//			
//			ls_ErrorMessage += "~n(Error evaluating equipment assignments in event range.)"
//			li_Return = -1
//			EXIT
//			
//		END IF
//		
//		
//		CHOOSE CASE lnv_WorkEvent.of_GetType ( )
//				
//			CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_EndTrip
//				
//				//This is an event we can't drop into the driver / tractor itinerary, 
//				//and we can't just reroute the events leading up to this one, because we've got
//				//no closure (no dissociation of the trailer/container), so the routing would
//				//have to carry through this event.
//				
//				ls_ErrorMessage += "~n(There is a NewTrip or EndTrip in the target event range.  This event must be rerouted manually.)"
//				li_Return = -1
//				EXIT
//								
//				
//			CASE gc_Dispatch.cs_EventType_Dismount
//				
//				IF lb_CurrentlyOnContainer THEN  //If we're in trailer itinerary, dismount doesn't matter, keep going
//					
//					//OK, we've hit the dissociation event
//					
//					lb_HasDissociationEvent = TRUE
//					ll_DissociationEventId = ll_EventID
//					ll_DissociationEventRow = ll_Row
//					EXIT
//					
//				END IF
//				
//				
//			CASE gc_Dispatch.cs_EventType_Drop
//				
//				//OK, we've hit the dissociation event, whether we're in a trailer or container itinerary.
//				
//				lb_HasDissociationEvent = TRUE
//				ll_DissociationEventId = ll_EventID
//				ll_DissociationEventRow = ll_Row
//				EXIT
//				
//				
//		END CHOOSE
//				
//	NEXT
//	
//END IF
//				
//
//IF li_Return = 1 THEN
//	
//	//Determine an insertionstyle and insertionevent for when we reassign the trailer or container
//	//to the range. (We'll be re-inserting the range into the trailer / container itinerary after 
//	//the events have been rerouted to the driver/tractor and removed from the trailer/container,
//	//and we want to put them back in the same position they're in now.)
//	
//	lnv_WorkEvent.of_SetSource ( lds_Lookback )
//	
//	IF lb_HasDissociationEvent AND ll_Lookback_Count > ll_DissociationEventRow THEN
//		
//		//We've got a dissociation event, and there's rows after that in the trailer/container itin, 
//		//so the reassignment can happen just before the row that comes after the dissociation event.
//		
//		lnv_WorkEvent.of_SetSourceRow ( ll_DissociationEventRow + 1 )
//		li_Assignment_InsertionStyle = gc_Dispatch.ci_InsertionStyle_Before
//		ll_Assignment_InsertionEvent = lnv_WorkEvent.of_GetId ( )
//		
//	ELSEIF ll_StartingRow > 1 THEN
//		
//		//We don't have a dissociation event, but we have rows before the starting event, so the 
//		//reassignment can happen just after the row that comes before the starting event.
//		
//		lnv_WorkEvent.of_SetSourceRow ( ll_StartingRow - 1 )
//		li_Assignment_InsertionStyle = gc_Dispatch.ci_InsertionStyle_After
//		ll_Assignment_InsertionEvent = lnv_WorkEvent.of_GetId ( )
//		
//	ELSE
//		
//		//Since we've got no dissociation event and no rows before the starting event, we should
//		//have a clean day on ld_AssociationDate, so we can just go with ci_InsertionStyle_Assignment.
//		
//		li_Assignment_InsertionStyle = gc_Dispatch.ci_InsertionStyle_Assignment
//		SetNull ( ll_Assignment_InsertionEvent )
//		
//	END IF	
//
//END IF
//
//////////////////////////////////
////// I am jumping in here I don't know if this is goingi to work but...
////
////IF li_Return = 1 THEN
////	Int	li_problems
////	li_Problems = THIS.of_Validateassignment( ll_AssociationEventId , li_CurrentType, ll_CurrentId , ai_targettype , al_targetid )
////	IF li_problems > 0 THEN	
////		IF NOT inv_validation.of_DoWeContinue( ) THEN
////			li_Return = -3
////		END IF
////	END IF
////END IF
////////////////////////////////////
//
//
//
//
//
//IF li_Return = 1 THEN
//	
//	IF ll_RerouteEventCount > 0 THEN
//	
//		//Depending on which scenario we're dealing with, set the ll_Route_InsertionEvent and li_Route_InsertionStyle
//		
//		IF lb_AssociationInTarget THEN
//			
//			ll_Route_InsertionEvent = al_InsertionEvent
//			li_Route_InsertionStyle = ai_InsertionStyle
//			
//		ELSE
//			
//			SetNull ( ll_Route_InsertionEvent )
//			li_Route_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfRoute
//			
//		END IF
//		
//		
//		//Perform the re-routing.
//		
//		CHOOSE CASE This.of_Route ( lla_RerouteEventIds, ai_TargetType, al_TargetId, ld_AssociationEventDate, &
//				0 /*DateScaleStyle*/, ll_Route_InsertionEvent, li_Route_InsertionStyle )
//				
//			CASE 1	//Success
//				
//				
//			CASE 0	//User cancelled
//				li_Return = 0  //User cancelled
//				
//			CASE -1	//Error
//				ls_ErrorMessage += "~n(Error attempting to route affected trailer/container events to the driver/tractor.)"
//				li_Return = -1
//				
//			CASE ELSE	//Unexpected return
//				ls_ErrorMessage += "~n(Unexpected return value attempting to route affected trailer/container events to the driver/tractor.)"
//				li_Return = -1
//				
//		END CHOOSE
//		
//	ELSE
//		//There are no events that qualify for special of_AssignByReroute processing.  Return -2 so that normal of_Assign
//		//logic can be used instead, if possible.
//		
//		//Note: This should be sufficient to prevent infinite-looping that could otherwise occur between of_Assign
//		//and of_AssignByReroute   (this script calls of_Assign later, once it has moved things around, and that
//		//pass through of_Assign can delegate to of_AssignByReroute again.  At that point, though, there should
//		//be nothing left for special handling, and processing should come here, and get sent back to "normal" of_Assign)
//		
//		li_Return = -2
//		
//	END IF
//	
//END IF
//	
//	
//IF li_Return = 1 THEN
//	
//	lnv_Event.of_SetSource ( lds_Cache )
//	lnv_Event.of_SetSourceId ( ll_AssociationEventId )
//	
//	IF lnv_Event.of_IsAssigned ( li_CurrentType, ll_CurrentId ) THEN
//		
//		//The current equipment has already been assigned, possibly by virtue of being linked shipment equipment, 
//		//or other means.  Do not attempt to reassign it.
//		
//	ELSE
//		
//		//Assign the current equipment to the rerouted range, using the identified association event.
//	
//		This.ClearOFRErrors ( )
//		
//		CHOOSE CASE This.of_Assign ( li_Null, ll_Null, ll_AssociationEventId, li_CurrentType, ll_CurrentId, &
//				ld_AssociationEventDate, ll_Assignment_InsertionEvent, li_Assignment_InsertionStyle )
//				
//			CASE 1	//Success
//				
//				
//			CASE -1	//Error
//				//Explain that the events have been re-routed, but the trailer / container could not be reassigned.
//				
//				//Or, try to put the events back to the trailer / container, where they were???
//				//Leaving things the way things stand, events may end up on the driver/tractor, without the trailer/chassis
//				//assignment coming with them, but that may actually be better than attempting to move them back.
//				//The situations where of_assign would fail -- such as more events on the trailer / container
//				//on subsequent days, with no dissociation event in either itin, would probably result in the
//				//user trying to get all the events re-routed in anyway, so this way, at least they've got some of them
//				//transferred over.
//				
//				
//				ls_ErrorMessage = "Events were rerouted from the trailer/container to the driver/tractor in preparation "+&
//					"for the assignment you requested, but the assignment could not be completed.  If you do not want "+&
//					"these events rerouted, you will need to manually reroute them back, or close this window without "+&
//					"saving your changes.~n~nThe error that prevented the assignment is:~n~n"
//
//					
//				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
//					ls_ErrorMessage += lnva_Errors [ 1 ].GetErrorMessage ( )
//				ELSE
//					ls_ErrorMessage += "[Unspecified Error]"
//				END IF					
//					
//				li_Return = -1
//				
//			CASE ELSE	//Unexpected return
//
//				ls_ErrorMessage = "Events were rerouted from the trailer/container to the driver/tractor in preparation "+&
//					"for the assignment you requested, but the assignment could not be completed, due to an unexpected return value.  If you do not want "+&
//					"these events rerouted, you will need to manually reroute them back, or close this window without "+&
//					"saving your changes.~n~nThe error that prevented the assignment is:~n~n"
//
//					
//				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
//					ls_ErrorMessage += lnva_Errors [ 1 ].GetErrorMessage ( )
//				ELSE
//					ls_ErrorMessage += "[Unspecified Error -- Unexpected Return]"
//				END IF					
//					
//				li_Return = -1
//				
//		END CHOOSE
//		
//	END IF
//	
//END IF
//
//
//IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
//	This.ClearOFRErrors ( ) //Processing above may have loaded some.
//	lnv_Error = This.AddOFRError ( )
//	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
//END IF
//
//
//DESTROY ( lnv_AfterEvent )
//DESTROY ( lnv_WorkEvent )
//DESTROY ( lnv_Event )
//
//DESTROY lds_Lookback
//
//RETURN li_Return
end function

public function n_cst_equipmentposting of_getequipmentposting ();IF Not IsValid ( inv_equipmentposting ) THEN
	inv_equipmentposting = CREATE n_cst_EquipmentPosting
	inv_Equipmentposting.of_SetEquipmentcache( THIS.of_getequipmentcache( ) )
END IF

RETURN inv_Equipmentposting
end function

public function n_cst_bso_Validation of_getvalidation ();RETURN inv_validation
end function

public function integer of_validateassociations (long ala_eventids[], long al_insertionevent, date ad_insertiondate, integer ai_itintype, long al_itinid, integer ai_assignmenttype, long al_assignmentid);RETURN 0
//RETURN THIS.of_Validaterouterequest( ala_eventids[] , al_insertionevent ,ad_insertiondate, ai_itintype, al_itinid,  ai_assignmenttype, al_assignmentid )

Int	li_Return
Int	li_Problems
Long	ll_EventCount
Long	ll_EventIndex
Long	ll_Driver
Long	lla_Drivers[]
Long	lla_Equipment[]
Long	lla_Remainder[]
Long	lla_Trailers[]
Long	lla_Containers[]

Long	ll_FirstRow
Long	ll_insertionEvent
Date	ld_Null 
Int	i

Boolean	lb_Continue 

DataStore		lds_Copy
dwBuffer			le_Buffer
n_cst_Events	lnv_Events

//n_cst_setting_associationvalidation	lnv_PerformValidation
//lnv_PerformValidation = CREATE n_cst_setting_associationvalidation
//lb_Continue = lnv_PerformValidation.of_GetValue ( ) = lnv_PerformValidation.cs_Yes
//DESTROY ( lnv_PerformValidation )
//
//IF NOT lb_Continue THEN
//	RETURN 0 // no problems
//END IF


n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

IF Not isValid ( inv_Validation ) THEN
	inv_Validation = CREATE n_cst_bso_validation
	inv_Validation.of_Setdispatch( THIS )
END IF

inv_Validation.of_ClearErrors( ) 

SetNull ( ld_Null )
ll_EventCount = UpperBound ( ala_eventids[] )

IF IsNull ( al_Insertionevent ) AND ll_EventCount > 0 THEN 
	ll_insertionEvent = ala_Eventids[1]
ELSE
	ll_insertionEvent = al_insertionevent
END IF
	
THIS.of_Retrieveitinerary( ai_itintype , al_itinid , ad_insertiondate , ad_insertiondate ,TRUE )
THIS.of_Copyitinerary( ai_itintype, al_itinid, ld_Null, ld_Null, lds_Copy )

lnv_Event.of_SetSource ( lds_Copy  )
lnv_Event.of_SetSourceID ( ll_insertionEvent )

lnv_Event.of_GetSourceRow ( ll_FirstRow, le_Buffer, FALSE /*Don't Create*/ )

lnv_Events.of_GetRemainder(lds_Copy , ll_FirstRow   , ai_itintype , al_itinid , lla_Remainder )

ll_Driver = lla_Remainder[1]
IF IsNull ( ll_Driver ) THEN
	lnv_Event.of_GetAssignments( lla_Drivers , lla_Equipment )
	IF UpperBound ( lla_Drivers ) > 0 THEN
		ll_Driver = lla_Drivers[1]
	END IF
END IF

// load up the container list
FOR i = gc_dispatch.ci_minindex_container TO  gc_dispatch.ci_Maxindex_container
	lla_Containers[ UpperBound ( lla_Containers ) + 1] = lla_Remainder[i]
NEXT

// Load up the trailer list
FOR i = gc_dispatch.ci_minindex_trailerchassis TO  gc_dispatch.ci_minindex_trailerchassis
	lla_Trailers [ UpperBound ( lla_Trailers ) + 1 ]= lla_Remainder[i]
NEXT

CHOOSE CASE ai_Assignmenttype
		
	CASE gc_dispatch.ci_itintype_container
		lla_Containers[ UpperBound ( lla_Containers ) + 1] = al_assignmentid
	CASE gc_dispatch.ci_itintype_driver
	CASE gc_dispatch.ci_itintype_powerunit
	CASE gc_dispatch.ci_itintype_trailerchassis
		lla_Trailers [ UpperBound ( lla_Trailers ) + 1 ]= al_assignmentid
		

END CHOOSE


FOR ll_EventIndex = 1 TO ll_EventCount

	li_Problems += inv_Validation.of_validateassociation( ll_Driver, lla_Remainder[2], lla_Trailers , lla_Containers , ala_eventids[ll_EventIndex ] , ad_insertiondate)

NEXT 


Destroy ( lds_Copy )
DESTROY ( lnv_Event )

return li_Problems


	
end function

public function integer of_assignwithvalidation (long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate);//This is a simplified overload of the function for use with the assignment insertion style.
/////  not called
Integer	li_Null
Long		ll_Null

SetNull ( li_Null )
SetNull ( ll_Null )

Integer	li_Return
Boolean	lb_Assign = TRUE

Int	li_ProblemCount 

n_Cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event
lnv_Event.of_SetSource ( THIS.of_GetEventCache ( ) )
lnv_Event.of_SetSourceID ( al_baseevent )

Int	li_BaseType
Long	ll_BaseID  

lnv_Event.of_Getbaseforassignment( li_BaseType , ll_BaseID , ai_targettype, al_targetid, TRUE )
li_ProblemCount = THIS.of_validateassignment( al_BaseEvent , ai_targettype , al_targetid , li_BaseType, ll_BaseID) 

IF li_ProblemCount > 0 AND NOT gnv_App.of_runningscheduledtask( ) THEN
	lb_Assign = THIS.of_GetValidation( ).of_DoWecontinue( )
END IF

IF lb_Assign THEN
	li_Return = This.of_Assign ( li_Null, ll_Null /*Base Type and Id*/, al_BaseEvent, &
		ai_TargetType, al_TargetId, ad_InsertionDate, ll_Null /*Insertion Event*/, &
		gc_Dispatch.ci_InsertionStyle_Assignment )
ELSE
	
	li_Return = -1
	
END IF

RETURN li_Return
end function

private function integer of_getlookbackstring (n_cst_beo_event anv_targetevent, integer ai_targettype, ref string as_lookback);Boolean	lb_LookBack
string	ls_LookBack_Find
Int		li_Return = -1

CHOOSE CASE ai_TargetType

CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit

	CHOOSE CASE anv_targetevent.of_GetType ( )

	CASE gc_Dispatch.cs_EventType_NewTrip
		//Association can be made on this event.  No need to look back.

	CASE ELSE
		  //This is the logic that was here prior to 3.9.00
		
			lb_Lookback = TRUE
			ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_NewTrip + "'"				

	END CHOOSE

CASE gc_Dispatch.ci_ItinType_TrailerChassis

	CHOOSE CASE anv_targetevent.of_GetType ( )

	CASE gc_Dispatch.cs_EventType_Hook
		//Association can be made on this event.  No need to look back.

	CASE ELSE
		lb_Lookback = TRUE
		ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'"

	END CHOOSE

CASE gc_Dispatch.ci_ItinType_Container

	CHOOSE CASE anv_targetevent.of_GetType ( )

	CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
		//Association can be made on this event.  No need to look back.

	CASE ELSE
		lb_Lookback = TRUE
		ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'" + " OR " +&
			"de_event_type = '" + gc_Dispatch.cs_EventType_Mount + "'"

	END CHOOSE

CASE ELSE	//Unexpected value

	//Just try to process the request as normal in case something below can handle this.

END CHOOSE

IF lb_LookBack THEN
	li_Return = 1
ELSE
	li_Return = 0  // no need to look back
END IF


as_Lookback = ls_LookBack_Find

RETURN li_Return 


end function

private function long of_getlookbackeventid (n_cst_beo_event anv_event, integer ai_targettype, long al_targetid, ref long al_lookbackeventid);String	ls_LookBackString
Boolean	lb_LookBack
Boolean	lb_LookBack_Found
Long		ll_LookBackID
Long		ll_Row
Long		ll_TractorId
Long		ll_DriverId
Long		ll_Lookback_BaseId
Long		ll_Lookback_Count
Long		ll_BaseEvent
Int		li_Lookback_BaseType
Int		li_Lookback_Index
Date		ld_Lookback_Date
Date		ld_AssignmentDate
String	ls_ErrorMessage
Int		li_Return = 1
Int		li_LookBackStringRtn

DataStore	lds_Lookback
n_cst_beo_Event	lnv_WorkEvent
lnv_WorkEvent = CREATE n_cst_beo_Event


////Get ld_AssignmentDate in a clean form, stripping off any unintended time component.
ld_AssignmentDate = Date ( DateTime ( anv_Event.of_GetDateArrived ( ) ) )

ll_DriverId = anv_Event.of_GetDriverId ( )
ll_TractorId = anv_Event.of_GetTractorId ( )

ll_BaseEvent = anv_event.of_GetID ( )

li_LookBackStringRtn = THIS.of_GetLookbackstring( anv_Event , ai_targettype , ls_LookBackString  )

IF li_LookBackStringRtn = 0 THEN // no need to lookback
	li_Return = 0
ELSEIF li_LookBackStringRtn = 1 THEN
	lb_LookBack = TRUE
	li_Return = 1
ELSE
	li_Return = -1
END IF
	
IF li_Return = 1 THEN
	
	IF lb_Lookback = TRUE THEN
	
		IF NOT IsNull ( ll_TractorId ) THEN
	
			li_Lookback_BaseType = gc_Dispatch.ci_ItinType_PowerUnit
			ll_Lookback_BaseId = ll_TractorId
	
		ELSEIF NOT IsNull ( ll_DriverId ) THEN
	
			li_Lookback_BaseType = gc_Dispatch.ci_ItinType_Driver
			ll_Lookback_BaseId = ll_DriverId
	
		ELSE
	
			//No frame of reference to look back with.  Cancel the Lookback attempt.
			lb_Lookback = FALSE
			li_Return = 0 
	
		END IF
	
	END IF
END IF


IF li_Return = 1 AND lb_LookBack = TRUE THEN

	FOR li_Lookback_Index = 1 TO 3

		CHOOSE CASE li_LookBack_Index

		CASE 1

			ld_Lookback_Date = ld_AssignmentDate	//Just look at the day the event is on

		CASE 2

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -3 )  //Look back 3 days

		CASE 3

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -7 )  //Look back 7 days

		END CHOOSE


		CHOOSE CASE This.of_RetrieveItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, ld_AssignmentDate, FALSE /*Don't need Prior*/ )
		
			CASE 1
				//Retrieved OK
			
			CASE -1
				ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the Lookback loop
		
			CASE -2
				ls_ErrorMessage = "A check with the database indicates that information needed "+&
					"to process this request has changed since your last save.  You should attempt "+&
					"to save now, before continuing.  (L)"
				li_Return = -1
				EXIT  //Exit the Lookback loop
		
			CASE ELSE  //Unexpected return value.
				ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookback loop
	
		END CHOOSE


		IF li_Lookback_Index = 1 THEN  //Looking at the same day the target event is on.

			ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_AssignmentDate, &
				ld_AssignmentDate, lds_Lookback )

			IF ll_Lookback_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookback loop
			END IF


			//Find the assignment event in the lookback itinerary datastore.
			
			lnv_WorkEvent.of_SetSource ( lds_Lookback )
			lnv_WorkEvent.of_SetSourceId ( ll_BaseEvent )
		
			//Try to find a source row in the primary buffer only.
			ll_Row = lnv_WorkEvent.of_GetSourceRow ( )
		
			IF ll_Row > 0 THEN
				//OK
			ELSE
				ls_ErrorMessage += "~n(Could not identify assignment row.)  (L)"
				li_Return = -1
				EXIT //Exit the lookback loop
			END IF


			IF ll_Row > 1 THEN

				ll_Row = lds_Lookback.Find ( ls_LookbackString , ll_Row - 1, 1 )  //Search backwards, find the first eligible row.

				CHOOSE CASE ll_Row

					CASE IS > 0
	
						lnv_WorkEvent.of_SetSourceRow ( ll_Row )
						ll_LookBackID = lnv_WorkEvent.of_GetId ( )
						lb_Lookback_Found = TRUE
						EXIT  //Now, try to process the assignment on the new BaseEvent
	
					CASE 0
	
						//No eligible row found, continue on in the loop to look further backwards
	
					CASE ELSE
	
						ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
						li_Return = -1
						EXIT  //Exit the lookback loop

				END CHOOSE

			//ELSE

				//The BaseEvent row is the first row on the day.
				//Continue on in the loop to look further backwards.

			END IF

		ELSE

			//We're looking back prior to the day the originally requested event is on.

			//Get everything from the lookback date to the day before the originally requested event is on.

			ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, &
				RelativeDate ( ld_AssignmentDate, -1 ), lds_Lookback )

			IF ll_Lookback_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookback loop
			END IF


			IF ll_Lookback_Count > 0 THEN

				ll_Row = lds_Lookback.Find ( ls_LookbackString, ll_Lookback_Count, 1 )  //Search backwards, find the first eligible row.

				CHOOSE CASE ll_Row

					CASE IS > 0
	
						lnv_WorkEvent.of_SetSourceRow ( ll_Row )
						ll_LookBackID = lnv_WorkEvent.of_GetId ( )
						lb_Lookback_Found = TRUE
	
						//  ****DO WE NEED TO DO ANYTHING TO ad_InsertionDate IN THIS CASE???******
	
						EXIT  //Now, try to process the assignment on the new BaseEvent
	
					CASE 0
	
						//No eligible row found, continue on in the loop to look further backwards, 
						//or, if this is the last pass, finish the loop unsuccessfully
	
					CASE ELSE
	
						ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
						li_Return = -1
						EXIT  //Exit the lookback loop

				END CHOOSE

			//ELSE

				//Nothing to search.  Continue on in the loop to look further backwards, 
				//or, if this is the last pass, finish the loop unsuccessfully

			END IF

		END IF

	NEXT  //li_Lookback_Index


	IF li_Return = 1 THEN

		IF lb_Lookback_Found = TRUE THEN
			//OK.  Point lnv_Event at the new BaseEvent we've identified.
			al_lookbackeventid = ll_LookBackID
		ELSE
			//No eligible event was found.
			ls_ErrorMessage += "~n(No events in the prior week were capable of making the assignment requested.)"
			li_Return = -1
		END IF

	END IF

END IF


Destroy ( lnv_WorkEvent )
Destroy ( lds_Lookback )

RETURN li_Return
end function

public function integer of_validateassignment (long al_targetevent, integer ai_assignmenttype, long al_assignmentid, integer ai_itintype, long al_itinid);Date	ld_TargetDate
Date	ld_Null
Int	li_Return = 1
Int	li_LookBackRtn
Int	li_LookForwardRtn
Int	li_Problems
Int	li_EventCount
Int	li_EventIndex
Long	ll_LookBackTargetEvent
Long	ll_LookForwardTargetEvent
Long	lla_Drivers[]
Long	lla_PowerUnits[]
Long	lla_TrailerChass[]
Long	lla_Containers[]
Long	ll_Driver
Long	ll_PowerUnit
Long	ll_StartRow
Long	lla_EMPTY[]
Long	lla_AssignmentRemainder[]
Long	ll_AttachedTractor
Long	ll_AttachedDriver
Boolean	lb_Continue

SetNull ( ld_Null )
DataStore	lds_EventSourceCopy
n_cst_AnyArraySrv	lnv_Array
n_cst_Events	lnv_Events

//n_cst_setting_associationvalidation	lnv_PerformValidation
//lnv_PerformValidation = CREATE n_cst_setting_associationvalidation
//lb_Continue = lnv_PerformValidation.of_GetValue ( ) = lnv_PerformValidation.cs_Yes
//DESTROY ( lnv_PerformValidation )
//
//IF NOT lb_Continue THEN
//	RETURN 0 // no problems
//END IF

IF Not isValid ( inv_Validation ) THEN
	inv_Validation = CREATE n_cst_bso_validation
END IF
inv_Validation.of_Setdispatch( THIS )
inv_Validation.of_clearerrors( )

n_cst_beo_Event	lnv_LookForwardEvent
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event
lnv_LookForwardEvent = CREATE n_cst_Beo_Event

lnv_Event.of_SetSource( THIS.of_GetEventCache ( ) )
lnv_Event.of_SetSourceID ( al_targetevent )

IF NOT lnv_Event.of_HasSource ( ) THEN
	li_Return = -1
END IF

lnv_LookForwardEvent.of_SetSource( THIS.of_GetEventCache ( ) )
lnv_LookForwardEvent.of_SetSourceID ( al_targetevent )

IF NOT lnv_LookForwardEvent.of_HasSource ( ) THEN
	li_Return = -1
END IF

////  get the itinerary for the assignment type. This is incase we are doing a assign by reroute and the tractor/driver is
// coming along with the assignment of the other.
THIS.of_Retrieveitinerary( ai_assignmenttype , al_assignmentid , lnv_Event.of_getdatearrived( ) , lnv_Event.of_getdatearrived( ) ,TRUE )
This.of_CopyItinerary ( ai_assignmenttype , al_assignmentid , ld_Null , ld_Null , lds_EventSourceCopy )
IF lds_EventSourceCopy.RowCount ( ) > 0 THEN
	lnv_Events.of_GetRemainder(lds_EventSourceCopy , 1   , ai_assignmenttype , al_assignmentid , lla_AssignmentRemainder )				
	
	ll_AttachedDriver = lla_AssignmentRemainder[1]
	ll_AttachedTractor = lla_AssignmentRemainder[2]
END IF	
		
//
IF li_Return = 1 THEN
	li_LookBackRtn = THIS.of_GetLookbackeventid( lnv_Event , ai_assignmenttype , al_assignmentid , ll_LookBackTargetEvent )
	IF li_LookBackRtn = 1 THEN	
		lnv_Event.of_SetSourceID ( ll_LookBackTargetEvent )
	ELSEIF li_lookBackRtn = -1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	li_LookForwardRtn = THIS.of_GetLookForwardeventid( lnv_LookForwardEvent , ai_assignmenttype , al_assignmentid , lnv_Event.of_GetType ( ) , ll_LookForwardTargetEvent  )
	IF li_LookForwardRtn = 1 THEN	
		lnv_LookForwardEvent.of_SetSourceID ( ll_LookForwardTargetEvent )
	ELSEIF li_lookForwardRtn = -1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN				
	This.of_CopyItinerary ( ai_itintype , al_ItinID , lnv_Event.of_getdatearrived( ) , &
				ld_Null , lds_EventSourceCopy )		
END IF

IF li_Return = 1 THEN

	/// we are going to have to put this in a loop to check every event the assignment will touch
	li_EventCount = lds_EventSourceCopy.RowCount ( )
	IF li_EventCount <= 0 THEN
		li_Return = 0
	END IF
	
END IF

IF li_Return = 1 THEN // lnv_Event points to assignment row
	
	
	ll_StartRow = lds_EventSourceCopy.Find ( "de_id = " + String ( lnv_Event.of_GetID ( ) ) , 1, lds_EventSourceCopy.rowcount( ) )
	
	IF lnv_LookForwardEvent.of_IsAssignment( ) AND li_LookForwardRtn = 1 THEN
		li_EventCount --  
	END IF
		
	lnv_Event.of_SetSource ( lds_EventSourceCopy ) 
	FOR li_EventIndex = ll_StartRow TO li_EventCount
		
		lnv_Event.of_SetSourceRow ( li_EventIndex )
		
		IF lnv_Events.of_Istypedissociation( lnv_Event.of_GetType ( ) ) THEN
			EXIT // Associations are done
		END IF
		
		lla_drivers = lla_EMPTY 
		lla_powerunits = lla_EMPTY
		lla_trailerchass = lla_EMPTY
		lla_containers = lla_EMPTY
		
		lnv_Event.of_GetAssignments( lla_drivers , lla_powerunits , lla_trailerchass ,lla_containers )
		CHOOSE CASE ai_Assignmenttype
		
			CASE gc_dispatch.ci_itintype_container
				lla_Containers[ UpperBound ( lla_Containers ) + 1] = al_assignmentid
			CASE gc_dispatch.ci_itintype_driver
				lla_drivers [ UpperBound ( lla_Drivers ) + 1 ] = al_assignmentid
				IF ll_AttachedTractor > 0 THEN
					lla_PowerUnits[UpperBound ( lla_PowerUnits ) + 1 ] = ll_AttachedTractor
				END IF
			CASE gc_dispatch.ci_itintype_powerunit
				lla_PowerUnits[UpperBound ( lla_PowerUnits ) + 1 ] = al_assignmentid
				IF ll_AttachedDriver > 0 THEN
					lla_drivers [ UpperBound ( lla_Drivers ) + 1 ] = ll_AttachedDriver
				END IF
			CASE gc_dispatch.ci_itintype_trailerchassis
				lla_trailerchass [ UpperBound ( lla_trailerchass ) + 1 ]= al_assignmentid
		END CHOOSE
		
		IF UpperBound ( lla_Drivers ) > 0 THEN
			ll_Driver = lla_Drivers[1]
		END IF
		
		IF UpperBound ( lla_PowerUnits ) > 0 THEN
			ll_PowerUnit = lla_PowerUnits[1]
		END IF
		
		lnv_Array.of_Getshrinked( lla_Containers, TRUE, TRUE)
		lnv_Array.of_Getshrinked( lla_drivers, TRUE, TRUE )
		lnv_Array.of_Getshrinked( lla_PowerUnits, TRUE, TRUE )
		lnv_Array.of_Getshrinked( lla_trailerchass, TRUE, TRUE )
		
		li_Problems += inv_Validation.of_validateassociation( ll_Driver, ll_PowerUnit , lla_TrailerChass , lla_Containers , lnv_Event.of_GetID ( ) , lnv_Event.of_getdatearrived( ) )
		
	NEXT
	
END IF

DESTROY ( lnv_Event ) 
DESTROY ( lnv_LookForwardEvent ) 

RETURN li_Problems
end function

private function integer of_getlookforwardstring (n_cst_beo_event anv_targetevent, integer ai_targettype, string as_lookbacktype, ref string as_lookforward);Boolean	lb_LookForward
string	ls_LookForward_Find
String	ls_LookBackType
Int		li_Return = -1

ls_LookBackType = as_lookbacktype


CHOOSE CASE ai_TargetType

	CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit
	
		CHOOSE CASE anv_targetevent.of_GetType ( )
	
		CASE gc_Dispatch.cs_EventType_EndTrip
			//Association can be made on this event.  No need to look Forward.
	
		CASE ELSE
					
				lb_LookForward = TRUE
				ls_LookForward_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_EndTrip + "'"				
	
		END CHOOSE
	
	CASE gc_Dispatch.ci_ItinType_TrailerChassis
	
		CHOOSE CASE anv_targetevent.of_GetType ( )
	
		CASE gc_Dispatch.cs_EventType_Drop
			//Association can be made on this event.  No need to look Forward.
	
		CASE ELSE
			lb_LookForward = TRUE
			ls_LookForward_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Drop + "'"
	
		END CHOOSE
	
	CASE gc_Dispatch.ci_ItinType_Container
	
		CHOOSE CASE anv_targetevent.of_GetType ( )
	
		CASE gc_Dispatch.cs_EventType_Drop, gc_Dispatch.cs_EventType_Dismount
			//Association can be made on this event.  No need to look Forward.
	
		CASE ELSE
			lb_LookForward = TRUE
			ls_LookForward_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Drop + "'" + " OR " +&
				"de_event_type = '" + gc_Dispatch.cs_EventType_DisMount + "'"
	
		END CHOOSE
	
	CASE ELSE	//Unexpected value

	

END CHOOSE

IF lb_LookForward THEN
	CHOOSE CASE ls_LookBackType


		CASE gc_Dispatch.cs_EventType_NewTrip
				ls_LookForward_Find += " OR de_event_type = '" + gc_Dispatch.cs_EventType_NewTrip + "'"
				
		CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_mount
			ls_LookForward_Find += " OR de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'" + " OR " +&
				"de_event_type = '" + gc_Dispatch.cs_EventType_mount + "'"
			
			
			
			
	END CHOOSE 
	
END IF

IF lb_LookForward THEN
	li_Return = 1
ELSE
	li_Return = 0  // no need to look back
END IF


as_lookforward = ls_LookForward_Find

RETURN li_Return 


end function

private function long of_getlookforwardeventid (n_cst_beo_event anv_event, integer ai_targettype, long al_targetid, string as_lookbackeventtype, ref long al_lookforwardeventid);String	ls_LookForwardString
Boolean	lb_LookForward
Boolean	lb_LookForward_Found
Long		ll_LookForwardID
Long		ll_Row
Long		ll_TractorId
Long		ll_DriverId
Long		ll_LookForward_BaseId
Long		ll_LookForward_Count
Long		ll_BaseEvent
Int		li_LookForward_BaseType
Int		li_LookForward_Index
Date		ld_LookForward_Date
Date		ld_AssignmentDate
String	ls_ErrorMessage
Int		li_Return = 1
Int		li_LookForwardStringRtn

DataStore	lds_LookForward
n_cst_beo_Event	lnv_WorkEvent
lnv_WorkEvent = CREATE n_cst_beo_Event


////Get ld_AssignmentDate in a clean form, stripping off any unintended time component.
ld_AssignmentDate = Date ( DateTime ( anv_Event.of_GetDateArrived ( ) ) )

ll_DriverId = anv_Event.of_GetDriverId ( )
ll_TractorId = anv_Event.of_GetTractorId ( )

ll_BaseEvent = anv_event.of_GetID ( )

li_LookForwardStringRtn = THIS.of_GetLookForwardstring( anv_Event , ai_targettype , as_lookbackeventtype ,ls_LookForwardString  )

IF li_LookForwardStringRtn = 0 THEN // no need to lookForward
	li_Return = 0
ELSEIF li_LookForwardStringRtn = 1 THEN
	lb_LookForward = TRUE
	li_Return = 1
ELSE
	li_Return = -1
END IF
	
IF li_Return = 1 THEN
	
	IF lb_LookForward = TRUE THEN
	
		IF NOT IsNull ( ll_TractorId ) THEN
	
			li_LookForward_BaseType = gc_Dispatch.ci_ItinType_PowerUnit
			ll_LookForward_BaseId = ll_TractorId
	
		ELSEIF NOT IsNull ( ll_DriverId ) THEN
	
			li_LookForward_BaseType = gc_Dispatch.ci_ItinType_Driver
			ll_LookForward_BaseId = ll_DriverId
	
		ELSE
	
			//No frame of reference to look Forward with.  Cancel the LookForward attempt.
			lb_LookForward = FALSE
			li_Return = 0
	
		END IF
	
	END IF
END IF


IF li_Return = 1 AND lb_LookForward = TRUE THEN

	FOR li_LookForward_Index = 1 TO 3

		CHOOSE CASE li_LookForward_Index

		CASE 1

			ld_LookForward_Date = ld_AssignmentDate	//Just look at the day the event is on

		CASE 2

			ld_LookForward_Date = RelativeDate ( ld_AssignmentDate, 3 )  //Look Forward 3 days

		CASE 3

			ld_LookForward_Date = RelativeDate ( ld_AssignmentDate, 7 )  //Look Forward 7 days

		END CHOOSE


		CHOOSE CASE This.of_RetrieveItinerary ( li_LookForward_BaseType, ll_LookForward_BaseId, ld_LookForward_Date, ld_AssignmentDate, FALSE /*Don't need Prior*/ )
		
			CASE 1
				//Retrieved OK
			
			CASE -1
				ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the LookForward loop
		
			CASE -2
				ls_ErrorMessage = "A check with the database indicates that information needed "+&
					"to process this request has changed since your last save.  You should attempt "+&
					"to save now, before continuing.  (L)"
				li_Return = -1
				EXIT  //Exit the LookForward loop
		
			CASE ELSE  //Unexpected return value.
				ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookForward loop
	
		END CHOOSE


		IF li_LookForward_Index = 1 THEN  //Looking at the same day the target event is on.

			ll_LookForward_Count = This.of_CopyItinerary ( li_LookForward_BaseType, ll_LookForward_BaseId, ld_AssignmentDate, &
				ld_AssignmentDate, lds_LookForward )

			IF ll_LookForward_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookForward loop
			END IF


			//Find the assignment event in the lookForward itinerary datastore.
			
			lnv_WorkEvent.of_SetSource ( lds_LookForward )
			lnv_WorkEvent.of_SetSourceId ( ll_BaseEvent )
		
			//Try to find a source row in the primary buffer only.
			ll_Row = lnv_WorkEvent.of_GetSourceRow ( )
		
			IF ll_Row > 0 THEN
				//OK
			ELSE
				ls_ErrorMessage += "~n(Could not identify assignment row.)  (L)"
				li_Return = -1
				EXIT //Exit the lookForward loop
			END IF


			IF ll_Row > 1 THEN

				ll_Row = lds_LookForward.Find ( ls_LookForwardString , ll_Row + 1, lds_LookForward.RowCount ( ) )  //Search Forwardwards, find the first eligible row.

				CHOOSE CASE ll_Row

					CASE IS > 0
	
						lnv_WorkEvent.of_SetSourceRow ( ll_Row )
						ll_LookForwardID = lnv_WorkEvent.of_GetId ( )
						lb_LookForward_Found = TRUE
						EXIT  //Now, try to process the assignment on the new BaseEvent
	
					CASE 0
	
						//No eligible row found, continue on in the loop to look further Forwardwards
	
					CASE ELSE
	
						ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
						li_Return = -1
						EXIT  //Exit the lookForward loop

				END CHOOSE

			//ELSE

				//The BaseEvent row is the first row on the day.
				//Continue on in the loop to look further Forwardwards.

			END IF

		ELSE

			//We're looking Forward prior to the day the originally requested event is on.

			//Get everything from the lookForward date to the day before the originally requested event is on.

			ll_LookForward_Count = This.of_CopyItinerary ( li_LookForward_BaseType, ll_LookForward_BaseId, ld_LookForward_Date, &
				RelativeDate ( ld_AssignmentDate, 1 ), lds_LookForward )

			IF ll_LookForward_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookForward loop
			END IF


			IF ll_LookForward_Count > 0 THEN
				///////////  I DON'T KNOW IF THIS IS RIGHT   //////////
				ll_Row = lds_LookForward.Find ( ls_LookForwardString, 1, ll_LookForward_Count )  //Search Forwardwards, find the first eligible row.

				CHOOSE CASE ll_Row

					CASE IS > 0
	
						lnv_WorkEvent.of_SetSourceRow ( ll_Row )
						ll_LookForwardID = lnv_WorkEvent.of_GetId ( )
						lb_LookForward_Found = TRUE
	
						//  ****DO WE NEED TO DO ANYTHING TO ad_InsertionDate IN THIS CASE???******
	
						EXIT  //Now, try to process the assignment on the new BaseEvent
	
					CASE 0
	
						//No eligible row found, continue on in the loop to look further Forwardwards, 
						//or, if this is the last pass, finish the loop unsuccessfully
	
					CASE ELSE
	
						ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
						li_Return = -1
						EXIT  //Exit the lookForward loop

				END CHOOSE

			//ELSE

				//Nothing to search.  Continue on in the loop to look further Forwardwards, 
				//or, if this is the last pass, finish the loop unsuccessfully

			END IF

		END IF

	NEXT  //li_LookForward_Index


	IF li_Return = 1 THEN

		IF lb_LookForward_Found = TRUE THEN
			//OK.  Point lnv_Event at the new BaseEvent we've identified.
			al_lookForwardeventid = ll_LookForwardID
		ELSE
			li_Return = 0
			//No eligible event was found.
		//	ls_ErrorMessage += "~n(No events in the prior week were capable of making the assignment requested.)"
		//	li_Return = -1
		END IF

	END IF

END IF


Destroy ( lnv_WorkEvent )
Destroy ( lds_LookForward )

RETURN li_Return
end function

public function boolean of_isassignmentrequestbackwards (integer ai_targettype, n_cst_beo_event anv_event);Boolean	lb_Return

CHOOSE CASE ai_TargetType

	CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit
	
		CHOOSE CASE anv_Event.of_GetType ( )
	
			CASE gc_Dispatch.cs_EventType_NewTrip
				//Association can be made on this event.  No need to look back.
		
			CASE ELSE
				
				IF IsNull ( anv_Event.of_GetDriverID  ()  ) AND IsNull ( anv_Event.of_GetTractorID ( ) ) THEN
					lb_Return = TRUE
				END IF
			END CHOOSE
	
END CHOOSE

RETURN lb_Return 
end function

public function integer of_validaterouterequest (long ala_eventids[], long al_insertionevent, date ad_insertiondate, integer ai_itintype, long al_itinid);Int		li_Return
Int		li_Problems
Int		i
Int		li_EqIndex
Int		li_EqCount
Long		ll_EventCount
Long		ll_EventIndex
Long		ll_Driver
Long		lla_Drivers[]
Long		lla_Equipment[]
Long		lla_Remainder[]
Long		lla_Trailers[]
Long		lla_Containers[]
Long		lla_Empty[]
Long		ll_InsertionRow
Long		ll_FirstRow
Long		ll_insertionEvent
Date		ld_Null 
String	ls_Work
String	ls_PreviousType
Boolean	lb_Continue 

n_cst_beo_Equipment2	lnva_EquipmentList[]
n_cst_EquipmentManager	lnv_EqManager


DataStore		lds_Copy
dwBuffer			le_Buffer
n_cst_Events	lnv_Events
n_cst_Beo_Shipment	lnv_Shipment
n_cst_AnyarraySrv		lnv_Array

SetNull ( ld_Null )

//n_cst_setting_associationvalidation	lnv_PerformValidation
//lnv_PerformValidation = CREATE n_cst_setting_associationvalidation
//lb_Continue = lnv_PerformValidation.of_GetValue ( ) = lnv_PerformValidation.cs_Yes
//DESTROY ( lnv_PerformValidation )
//
//IF NOT lb_Continue THEN
//	RETURN 0 // no problems
//END IF

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

IF Not isValid ( inv_Validation ) THEN
	inv_Validation = CREATE n_cst_bso_validation
	inv_Validation.of_Setdispatch( THIS )
END IF

inv_Validation.of_ClearErrors( ) 

ll_EventCount = UpperBound ( ala_eventids[] )


ll_insertionEvent = al_insertionevent

THIS.of_Retrieveitinerary( ai_itintype , al_itinid , ad_insertiondate , ad_insertiondate ,TRUE )
THIS.of_Copyitinerary( ai_itintype, al_itinid, ld_Null, ld_Null, lds_Copy )

//Find the insertion point
IF isNull ( ll_InsertionEvent ) THEN
	lnv_Events.of_GetInsertionPoint ( lds_Copy, ai_itintype, al_itinid, ad_InsertionDate, &
		al_InsertionEvent, gc_Dispatch.ci_InsertionStyle_EndOfTrip , ll_InsertionRow, ls_Work /*ErrorText*/ )
	
	lnv_Event.of_SetSource ( lds_Copy  )
	lnv_Event.of_SetSourceRow ( ll_InsertionRow - 1 )
	lnv_Event.of_GetSourceRow ( ll_FirstRow, le_Buffer, FALSE /*Don't Create*/ )		

ELSE
	lnv_Event.of_SetSource ( lds_Copy  )
	lnv_Event.of_SetSourceID ( ll_insertionEvent )
	lnv_Event.of_GetSourceRow ( ll_FirstRow, le_Buffer, FALSE /*Don't Create*/ )

END IF


lnv_Events.of_GetRemainder(lds_Copy , ll_FirstRow   , ai_itintype , al_itinid , lla_Remainder )
ll_Driver = lla_Remainder[1]


// load up the container list
FOR i = gc_dispatch.ci_minindex_container TO  gc_dispatch.ci_Maxindex_container
	lla_Containers[ UpperBound ( lla_Containers ) + 1] = lla_Remainder[i]
NEXT

// Load up the trailer list
FOR i = gc_dispatch.ci_minindex_trailerchassis TO  gc_dispatch.ci_Maxindex_trailerchassis
	lla_Trailers [ UpperBound ( lla_Trailers ) + 1 ]= lla_Remainder[i]
NEXT

lnv_Event.of_SetSource ( THIS.of_GetEventCache ( ))

FOR ll_EventIndex = 1 TO ll_EventCount

	lnv_Event.of_SetSourceID ( ala_eventids[ll_EventIndex ] )
	
	IF ls_PreviousType = gc_dispatch.cs_EventType_Dismount THEN
		lla_Containers = lla_Empty
	ELSEIF ls_PreviousType = gc_dispatch.cs_EventType_Drop THEN
		lla_Containers = lla_Empty
		lla_Trailers = lla_Empty
	END IF
	
	IF lnv_EVent.of_GetShipment ( ) > 0 THEN
		//GET THE Equipment for the shipment because it is going to get assigned
		li_EqCount = THIS.of_GetEquipmentForShipment ( lnv_EVent.of_GetShipment ( ) , lnva_EquipmentList )
		FOR li_EqIndex = 1 TO li_EqCount
			If isValid ( lnva_EquipmentList [ li_EqIndex ] ) THEN
				
				IF lnva_EquipmentList [ li_EqIndex ].of_GetStatus ( ) = lnv_EqManager.cs_Status_Active THEN
							
					CHOOSE CASE lnva_EquipmentList [ li_EqIndex ].of_getCategory ( )
							
						CASE n_Cst_Constants.ci_EquipmentCategory_Containers
							lla_Containers[ UpperBound ( lla_Containers ) + 1] = lnva_EquipmentList [ li_EqIndex ].of_GetID ( )
							
						CASE n_Cst_Constants.ci_EquipmentCategory_TrailerChassis
							lla_Trailers [ UpperBound ( lla_Trailers ) + 1 ] = lnva_EquipmentList [ li_EqIndex ].of_GetID ( )
							
					END CHOOSE		
					
				END IF
			END IF
		NEXT		
	END IF
	
	lnv_Array.of_Getshrinked( lla_Containers, TRUE, TRUE)
	lnv_Array.of_Getshrinked( lla_Trailers, TRUE, TRUE )

	li_Problems += inv_Validation.of_validateassociation( ll_Driver, lla_Remainder[2], lla_Trailers , lla_Containers , ala_eventids[ll_EventIndex ] , ad_insertiondate)
	ls_PreviousType = lnv_Event.of_GetType ()
NEXT 


Destroy ( lds_Copy )
DESTROY ( lnv_Event )

return li_Problems





	

end function

public function integer of_validatedisassociation (long al_targetevent, integer ai_assignmenttype, long al_assignmentid, integer ai_itintype, long al_itinid);Date	ld_TargetDate
Date	ld_Null
Int	li_Return = 1
Long	ll_LookBackTargetEvent
Long	ll_LookForwardTargetEvent
Int	li_LookBackRtn
Int	li_LookForwardRtn
Long	lla_Drivers[]
Long	lla_PowerUnits[]
Long	lla_TrailerChass[]
Long	lla_Containers[]
Long	ll_Driver
Long	ll_PowerUnit
Long	ll_StartRow
Int	li_Problems
Int	li_EventCount
Int	li_EventIndex
Long	lla_EMPTY[]
Boolean	lb_Continue


SetNull ( ld_Null )
DataStore	lds_EventSourceCopy
n_cst_AnyArraySrv	lnv_Array

//n_cst_setting_associationvalidation	lnv_PerformValidation
//lnv_PerformValidation = CREATE n_cst_setting_associationvalidation
//lb_Continue = lnv_PerformValidation.of_GetValue ( ) = lnv_PerformValidation.cs_Yes
//DESTROY ( lnv_PerformValidation )
//
//IF NOT lb_Continue THEN
//	RETURN 0 // no problems
//END IF
//
IF Not isValid ( inv_Validation ) THEN
	inv_Validation = CREATE n_cst_bso_validation
END IF
inv_Validation.of_Setdispatch( THIS )
inv_Validation.of_clearerrors( )

n_cst_beo_Event	lnv_LookForwardEvent
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event
lnv_LookForwardEvent = CREATE n_cst_Beo_Event


lnv_Event.of_SetSource( THIS.of_GetEventCache ( ) )
lnv_Event.of_SetSourceID ( al_targetevent )

IF NOT lnv_Event.of_HasSource ( ) THEN
	li_Return = -1
END IF

lnv_LookForwardEvent.of_SetSource( THIS.of_GetEventCache ( ) )
lnv_LookForwardEvent.of_SetSourceID ( al_targetevent )

IF NOT lnv_LookForwardEvent.of_HasSource ( ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	li_LookBackRtn = THIS.of_GetLookbackeventid( lnv_Event , ai_assignmenttype , al_assignmentid , ll_LookBackTargetEvent )
	IF li_LookBackRtn = 1 THEN	
		lnv_Event.of_SetSourceID ( ll_LookBackTargetEvent )
	ELSEIF li_lookBackRtn = -1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	li_LookForwardRtn = THIS.of_GetLookForwardeventid( lnv_LookForwardEvent , ai_assignmenttype , al_assignmentid , lnv_Event.of_GetType ( ) , ll_LookForwardTargetEvent  )
	IF li_LookForwardRtn = 1 THEN	
		lnv_LookForwardEvent.of_SetSourceID ( ll_LookForwardTargetEvent )
	ELSEIF li_lookForwardRtn = -1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	
//	This.of_CopyItinerary ( ai_itintype , al_ItinID , lnv_Event.of_getdatearrived( ) , &
//				lnv_LookForwardEvent.of_getdatearrived( ) , lds_EventSourceCopy )
				
	This.of_CopyItinerary ( ai_itintype , al_ItinID , lnv_Event.of_getdatearrived( ) , &
				ld_Null , lds_EventSourceCopy )
			
END IF

IF li_Return = 1 THEN // lnv_Event points to assignment row
		/// we are going to have to put this in a loop to check every event the assignment will touch
		li_EventCount = lds_EventSourceCopy.RowCount ( )
		
		ll_StartRow = lds_EventSourceCopy.Find ( "de_id = " + String ( lnv_Event.of_GetID ( ) ) , 1, lds_EventSourceCopy.rowcount( ) )
		
		IF ll_StartRow > 0 THEN
		
			IF lnv_LookForwardEvent.of_IsAssignment( ) AND li_LookForwardRtn = 1 THEN
				li_EventCount --  
			END IF
				
		
			lnv_Event.of_SetSource ( lds_EventSourceCopy ) 
			FOR li_EventIndex = ll_StartRow TO li_EventCount
				
				lnv_Event.of_SetSourceRow ( li_EventIndex )
					
				
				lnv_Event.of_GetAssignments( lla_drivers , lla_powerunits , lla_trailerchass ,lla_containers )
				CHOOSE CASE ai_Assignmenttype
				
					CASE gc_dispatch.ci_itintype_container
						lla_Containers[ UpperBound ( lla_Containers ) + 1] = al_assignmentid
					CASE gc_dispatch.ci_itintype_driver
						lla_drivers [ UpperBound ( lla_Drivers ) + 1 ] = al_assignmentid
					CASE gc_dispatch.ci_itintype_powerunit
						lla_PowerUnits[UpperBound ( lla_PowerUnits ) + 1 ] = al_assignmentid
					CASE gc_dispatch.ci_itintype_trailerchassis
						lla_trailerchass [ UpperBound ( lla_trailerchass ) + 1 ]= al_assignmentid
				END CHOOSE
				
				IF UpperBound ( lla_Drivers ) > 0 THEN
					ll_Driver = lla_Drivers[1]
				END IF
				
				IF UpperBound ( lla_PowerUnits ) > 0 THEN
					ll_PowerUnit = lla_PowerUnits[1]
				END IF
				
				lnv_Array.of_Getshrinked( lla_Containers, TRUE, TRUE)
				lnv_Array.of_Getshrinked( lla_drivers, TRUE, TRUE )
				lnv_Array.of_Getshrinked( lla_PowerUnits, TRUE, TRUE )
				lnv_Array.of_Getshrinked( lla_trailerchass, TRUE, TRUE )
				
				li_Problems += inv_Validation.of_validateassociation( ll_Driver, ll_PowerUnit , lla_TrailerChass , lla_Containers , lnv_Event.of_GetID ( ) , lnv_Event.of_getdatearrived( ) )
				
			NEXT
		END IF
	
END IF

DESTROY ( lnv_Event ) 
DESTROY ( lnv_LookForwardEvent ) 

RETURN li_Problems
end function

public function integer of_assignbyreroute (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, boolean ab_validaterequest);//Returns: 1 = Success, 0 = User Cancelled, -1 = Error, -2 = No events qualified for special of_AssignByReroute processing,
//			  -3  = Assignment validation Failed
//If -2 is returned, no changes were made to the cache, and normal of_Assign processing should be attempted, if possible.

//This function is specialized assignment logic for a specific scenario: the assignment of a driver or tractor
//to an event (and usually, in effect, an event range), that is currently routed to a trailer or container
//itinerary.  As such, ai_BaseType is expected to be either gc_Dispatch.ci_ItinType_Trailer or
//gc_Dispatch.ci_ItinType_Container.  ai_TargetType is expected to be either gc_Dispatch.ci_ItinType_Driver or
//gc_Dispatch.ci_ItinType_PowerUnit.

//If permissable, the assignment will be accomplished by rerouting the affected range of events that are currently
//in the trailer or container itin to the driver or tractor, and then making the assignment of the trailer or container
//onto the association event (a Hook or Mount), which has either been identified in the Trailer / Container itinerary,
//or is already routed to the driver/tractor, and has been passed in using al_InsertionEvent  (if the association
//event is supposed to come from the Trailer/Container itin, al_InsertionEvent should be passed in null.)

//If ai_InsertionStyle is ci_InsertionStyle_After and a Hook (for Trailer or Container basetypes) or a
//Mount (for Container basetypes) is passed in as al_InsertionEvent, we'll use that event for the
//assignment, and route the events from the Trailer or Container itin immediately after it.
//The Drop / Dismount, if any, may come from either itin, but if there is a drop or dismount
//already routed to the trailer / container itin, it will be used.  Note that the trailer / container
//events being re-routed will come between the Hook / Mount and any other events already routed
//to the Driver / Tractor after that.


DataStore	lds_Cache, &
				lds_Lookback

n_cst_beo_Event	lnv_Event, &
						lnv_AfterEvent, &
						lnv_WorkEvent
						

Date		ld_AssignmentDate, &
			ld_Null, &
			ld_Lookback_Date
Long		ll_Row, &
			lla_Drivers[], &
			lla_Tractors[], &
			lla_TrailerChassis[], &
			lla_Containers[], &
			ll_Lookback_BaseId, &
			ll_Lookback_Count
String	ls_Lookback_Find, &
			ls_Dissociation_Find
Boolean	lb_Lookback_Found
Integer	li_Lookback_BaseType, &
			li_Lookback_Index
n_cst_OFRError		lnv_Error, &
						lnva_Errors[]

String	ls_ErrorMessage = "Could not process request."


Boolean	lb_CurrentlyOnTrailer, &
			lb_CurrentlyOnContainer, &
			lb_HasDissociationEvent, &
			lb_AssociationInTarget	//Used to identify if the association event is in the Target Itin (ie, the Driver/Tractor),
											//or in the Base Itin (ie, the Trailer/Container where the base event is routed.)
Long		ll_CurrentTrailerId, &
			ll_CurrentContainerId, &
			ll_CurrentId, &
			ll_StartingRow, &
			lla_Equipment[], &
			ll_EventId, &
			ll_RerouteEventCount, &
			lla_RerouteEventIds[], &
			ll_AssociationEventId, &
			ll_AssociationEventRow, &
			ll_DissociationEventId, &
			ll_DissociationEventRow, &
			ll_BaseEventRow, &
			ll_Route_InsertionEvent, &
			ll_Assignment_InsertionEvent, &
			ll_Null
Integer	li_CurrentType, &
			li_Route_InsertionStyle, &
			li_Assignment_InsertionStyle, &
			li_Null
Date		ld_AssociationEventDate, &
			ld_EventDate


Integer	li_Return = 1

SetNull ( ll_Null )
SetNull ( li_Null )

SetNull ( ld_Null )

lnv_Event = CREATE n_cst_beo_Event
lnv_AfterEvent = CREATE n_cst_beo_Event
lnv_WorkEvent = CREATE n_cst_beo_Event


lds_Cache = This.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_Cache )
lnv_Event.of_SetSourceId ( al_BaseEvent )  //Note:  This, along with al_BaseEvent, may be changed by Lookback processing.

//Get ld_AssignmentDate in a clean form, stripping off any unintended time component.
ld_AssignmentDate = Date ( DateTime ( lnv_Event.of_GetDateArrived ( ) ) )


IF ai_InsertionStyle = gc_Dispatch.ci_InsertionStyle_After AND NOT IsNull ( al_InsertionEvent ) THEN
	
	//This is an attempt to use the of_AssignByReroute processing when the Hook or Mount is already in
	//the tractor or driver itin.  Make sure the al_InsertionEvent and ai_BaseType make sense for this request.
	
	//Set the flag to distinguish this variety of request.
	lb_AssociationInTarget = TRUE
	
	lnv_AfterEvent.of_SetSource ( lds_Cache ) 
	lnv_AfterEvent.of_SetSourceId ( al_InsertionEvent )
	
	ll_AssociationEventId = al_InsertionEvent
	ld_AssociationEventDate = lnv_AfterEvent.of_GetDateArrived ( )
	
	IF DaysAfter ( ad_InsertionDate, ld_AssociationEventDate ) = 0 THEN
		//OK
	ELSE
		ls_ErrorMessage += "~n(There was a conflict in routing dates.  The InsertionDate and AssociationEventDate were different.)  (ABR)"
		li_Return = -1
	END IF
	
	
	//Tack this problem on to the previous one, if they're both not what we expect.
	
	CHOOSE CASE lnv_AfterEvent.of_GetType ( )
			
		CASE gc_Dispatch.cs_EventType_Hook
			
			IF ai_BaseType = gc_Dispatch.ci_ItinType_TrailerChassis OR ai_BaseType = gc_Dispatch.ci_ItinType_Container THEN
				
				//OK
				
			ELSE
				
				ls_ErrorMessage += "~n(Unexpected BaseType and EventType parameter pairing.)  (ABR-H)"
				li_Return = -1
				
			END IF
			
		CASE gc_Dispatch.cs_EventType_Mount
			
			IF ai_BaseType = gc_Dispatch.ci_ItinType_Container THEN
				
				//OK
				
			ELSE

				ls_ErrorMessage += "~n(Unexpected BaseType and EventType parameter pairing.)  (ABR-M)"
				li_Return = -1
				
			END IF
			
		CASE ELSE
			
			ls_ErrorMessage += "~n(Unexpected EventType parameter.)  (ABR)"
			li_Return = -1
			
	END CHOOSE
	
END IF



//Verify that the trailer or container is the only thing assigned to the base event.  
//(If the base event is indeed routed to a trailer or container, this should be the case under the 
//current rules, but let's not assume).  If it is the only thing assigned, hold that assignment, 
//so we can reassign it later, if everything works out.  
//If it's not the only thing assigned, fail this request.

//Retrieve the trailer or container itinerary, in a lookback loop, and going all the way forward

//In the lookback loop, try to find the starting event

//Then, determine the ending event  (either there'll be one, or there won't, which means
//the whole thing from the starting event forward has to be rerouted.

//Verify that the trailer or container is the only thing assigned to the whole range of events, 
//and that there are no "active" assignments anywhere in the range.

//Then, based on those events, attempt to identify an insertionpoint for that whole block of 
//events in the target itinerary.

//Then, try to route the block to the insertion point.

//Then, try to reassign the equipment to the block (by assigning it to the starting extent event.)

//If the reassignment does not succeed, you could still succeed the reroute (?)	
	



IF li_Return = 1 THEN
	
	//Verify that the trailer or container is the only thing assigned to the base event.  
	//(If the base event is indeed routed to a trailer or container, this should be the case under the 
	//current rules, but let's not assume).  If it is the only thing assigned, hold that assignment, 
	//so we can reassign it later, if everything works out.  
	//If it's not the only thing assigned, fail this request.	

	CHOOSE CASE lnv_Event.of_GetAssignments ( lla_Drivers, lla_Tractors, lla_TrailerChassis, lla_Containers )
			
	CASE 1
		
		IF UpperBound ( lla_Drivers ) > 0 OR UpperBound ( lla_Tractors ) > 0 THEN
			
			ls_ErrorMessage += "~n(There is already a driver or tractor assigned.)  (ABR)"
			li_Return = -1
			
		ELSEIF UpperBound ( lla_TrailerChassis ) = 1 AND UpperBound ( lla_Containers ) = 0 THEN
			
			lb_CurrentlyOnTrailer = TRUE
			ll_CurrentTrailerId = lla_TrailerChassis [ 1 ]
			
			li_CurrentType = gc_Dispatch.ci_ItinType_TrailerChassis
			ll_CurrentId = ll_CurrentTrailerId
			
			ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'"
			
			//Note:  This will prevent the re-routing grabbing the front-end of a drop & hook that's 
			//routed to the trailer/container.  Is this a good thing?
			
		ELSEIF UpperBound ( lla_TrailerChassis ) = 0 AND UpperBound ( lla_Containers ) = 1 THEN
			
			lb_CurrentlyOnContainer = TRUE
			ll_CurrentContainerId = lla_Containers [ 1 ]			
			
			li_CurrentType = gc_Dispatch.ci_ItinType_Container
			ll_CurrentId = ll_CurrentContainerId
			
			ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'" + " OR " +&
				"de_event_type = '" + gc_Dispatch.cs_EventType_Mount + "'" 
				
			//Note:  This will prevent the re-routing grabbing the front-end of a drop & hook that's 
			//routed to the trailer/container.  Is this a good thing?
			
		ELSE
			
			ls_ErrorMessage += "~n(The events are not assigned to a single trailer or container.)  (ABR)"
			li_Return = -1
			
		END IF
		
		
		IF li_Return = 1 AND lb_AssociationInTarget THEN
			
			//If the association is in the target, add on to the lookback criteria any NewTrip, EndTrip, 
			//or anything with a driver or tractor already assigned, or before the association event date, 
			//or anything that's confirmed (events that could be confirmed with only trailer/container routing
			//such as cs_EventType_PositionReport, cs_EventType_Repairs, cs_EventType_Reposition, cs_EventType_PMService
			//will be prevented from getting pulled into an association with tractor/driver that wasn't intended).  
			//We don't actually need to find an association event, we just need to find the first event we can't 
			//(or don't want to) re-reoute -- the association event from the target itin will be inserted after this event.
			ls_Lookback_Find += " OR de_driver > 0 OR de_tractor > 0 OR de_arrdate < " +& 
				String ( ld_AssociationEventDate, "yyyy-mm-dd" ) + " OR de_conf = 'T'"
			
		END IF
		
		
	CASE ELSE  //-1, or unexpected return
		
		ls_ErrorMessage += "~n(Could not determine base event assignments.)  (ABR)"
		li_Return = -1
		
	END CHOOSE

END IF


IF li_Return = 1 THEN
	
	li_Lookback_BaseType = li_CurrentType
	ll_Lookback_BaseId = ll_CurrentId

//	FOR li_Lookback_Index = 1 TO 3
	FOR li_Lookback_Index = 1 TO 1	//Due to the issues associated with trying to do this for multi-day routes,
												//I'm just going to look at the day of the request, even though this was
												//originally coded for looking back further.  I'm keeping the loop code around,
												//in case we want it, though.

		CHOOSE CASE li_LookBack_Index

		CASE 1

			ld_Lookback_Date = ld_AssignmentDate	//Just look at the day the event is on

		CASE 2

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -3 )  //Look back 3 days

		CASE 3

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -7 )  //Look back 7 days

		END CHOOSE


		CHOOSE CASE This.of_RetrieveItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, ld_Null /*Go all the way fwd*/, FALSE /*Don't need Prior*/ )
		
		CASE 1
			//Retrieved OK
		
		CASE -1
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (ABR-L)"
			li_Return = -1
			EXIT  //Exit the Lookback loop
	
		CASE -2
			ls_ErrorMessage = "A check with the database indicates that information needed "+&
				"to process this request has changed since your last save.  You should attempt "+&
				"to save now, before continuing.  (ABR-L)"
			li_Return = -1
			EXIT  //Exit the Lookback loop
	
		CASE ELSE  //Unexpected return value.
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (ABR-L)"
			li_Return = -1
			EXIT  //Exit the lookback loop
	
		END CHOOSE


		ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, &
			ld_Null /*Go all the way forward*/, lds_Lookback )

		IF ll_Lookback_Count = -1 THEN
			ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (ABR-L)"
			li_Return = -1
			EXIT  //Exit the lookback loop
		END IF


		//Find the assignment event in the lookback itinerary datastore.
		
		lnv_WorkEvent.of_SetSource ( lds_Lookback )
		lnv_WorkEvent.of_SetSourceId ( al_BaseEvent )
	
		//Try to find a source row in the primary buffer only.
		ll_BaseEventRow = lnv_WorkEvent.of_GetSourceRow ( )
	
		IF ll_BaseEventRow > 0 THEN
			//OK
		ELSE
			ls_ErrorMessage += "~n(Could not identify assignment row.)  (ABR-L)"
			li_Return = -1
			EXIT //Exit the lookback loop
		END IF


		//Search backwards from the requested row, looking to find the first eligible association row.
		ll_Row = lds_Lookback.Find ( ls_Lookback_Find, ll_BaseEventRow, 1 )  

		CHOOSE CASE ll_Row

		CASE IS > 0

			IF lb_AssociationInTarget THEN
				
				//Barring any of the other checks below interfering, ll_StartingRow will be immediately after the row
				//we just found.  So, set ll_StartingRow presuming no issues, and if the code below needs to adjust it,
				//or fail the operation, it will.
				ll_StartingRow = ll_Row + 1
				

				//If the "association" event identified was a hook or a mount, (note, "association" is used somewhat loosely
				//here, since we're really just finding the first event we can't route after the AssociationInTarget event),
				//then we don't want to jump into this range.  Look forward to find a dissociation event.  If we can find one,
				//we'll route the association right after that.  If we can't, we'll disqualify the request, and fail.
				
				IF ll_Row < ll_BaseEventRow THEN   //If ll_Row = ll_BaseEventRow, we don't need this check.
				
					lnv_WorkEvent.of_SetSource ( lds_Lookback )
					lnv_WorkEvent.of_SetSourceRow ( ll_Row )
					
					
					CHOOSE CASE lnv_WorkEvent.of_GetType ( )
							
						CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
							
							ls_Dissociation_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Drop + "'"
							
							IF lb_CurrentlyOnContainer THEN
								
								ls_Dissociation_Find +=  " OR de_event_type = '" + gc_Dispatch.cs_EventType_Dismount + "'"
								
							END IF
							
							ll_DissociationEventRow = lds_Lookback.Find ( ls_Dissociation_Find, ll_Row + 1, ll_BaseEventRow )
							
							
							IF ll_DissociationEventRow > 0 THEN
						
								ll_StartingRow = ll_DissociationEventRow + 1
								
							ELSE
								
								//The association opened by the Hook or Mount we found does not get closed prior to reaching 
								//al_BaseEvent.
								
								//We do not want to jump into this range, since it probably was intented to stay together 
								//(not be interrupted by an extraneous Hook/Mount and tractor/driver assignment, which is
								//what we'd be doing.)
								
								//So, attempt having ll_StartingRow be immediately after al_BaseEvent.
								//The additional checks that follow will determine if this is a valid place to insert or not.
								
								ll_StartingRow = ll_BaseEventRow + 1
								
							END IF
							
							
							//Clear the value in ll_DissociationEventRow.  The variable is used separately, later.
							ll_DissociationEventRow = 0
							
						CASE ELSE  //Event types other than Hook/Mount
							
							//Ok, go ahead and jump in right after the row proposed.  
							//ll_StartingRow is already set correctly for this.
							
					END CHOOSE
					
				ELSEIF ll_Row = ll_BaseEventRow THEN   //This should be the only other outcome, based on find parms & CASE statement
					
					//Ok, go ahead and jump in right after the row proposed (which is ll_BaseEventRow)
					//ll_StartingRow is already set correctly for this.
					
					
				ELSE   //Shouldn't happen, based on find parms & CASE statement.
					
					ls_ErrorMessage += "~n(Unexpected value for Row / BaseEventRow.)  (ABR)"
					li_Return = -1
					EXIT
					
				END IF						
				
				
				//Since this section is for lb_AssociationInTarget:
				
				//We already have set ll_AssociationEventId and ld_AssociationEventDate at the beginning of the script,
				//when we set lb_AssociationInTarget = TRUE (they're in the driver/tractor itin), so we don't do that here.
				
				
			ELSE

				//The row we've just identified is the association event.  Get the event id and date for use later.
			
				lnv_WorkEvent.of_SetSource ( lds_Lookback )
				lnv_WorkEvent.of_SetSourceRow ( ll_Row )
				ll_AssociationEventId = lnv_WorkEvent.of_GetId ( )
				ld_AssociationEventDate = lnv_WorkEvent.of_GetDateArrived ( )
				
				IF IsNull ( ll_AssociationEventId ) OR IsNull ( ld_AssociationEventDate ) THEN
					ls_ErrorMessage += "~n(Processing Error: Could not determine Association ID or Date.)  (ABR-H)"
					li_Return = -1
					EXIT
				END IF

				ll_StartingRow = ll_Row
				
			END IF

			lb_Lookback_Found = TRUE
			EXIT  //Now, try to process the assignment

		CASE 0

			IF lb_AssociationInTarget THEN
				
				//No problematic rows were found.  Assignment can be made from the beginning of the day.
				
				ll_StartingRow = 1
				lb_Lookback_Found = TRUE
				EXIT
				
			ELSE

				//No eligible row found, continue on in the loop to look further backwards
				
				//Note that in the single-loop structure we've gone with, this will result in a failure.
				//However, in a multi-loop structure, we'd just be looking farther back.
				
			END IF

		CASE ELSE

			ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (ABR-L)"
			li_Return = -1
			EXIT  //Exit the lookback loop

		END CHOOSE

	NEXT  //li_Lookback_Index
	
	
	IF li_Return = 1 THEN

		IF lb_Lookback_Found = TRUE THEN
			//OK
		ELSE
			ls_ErrorMessage += "~n(Could not determine the Hook/Mount to use for the assignment.)  (ABR)"
			li_Return = -1
			//Note:  You could potentially interpret the request as just to reassign the events to the
			//driver/tractor, and take it off the trailer/container.  Or, you could potentiall automatically
			//insert a hook/mount to make the assignment.  Not going to attempt those at this time, however.
		END IF

	END IF
	
	//Note that if li_Return is still = 1, then we have lb_Lookback_Found = TRUE, and we have a value
	//for ll_StartingRow, ll_AssociationEventId, and ld_AssociationEventDate

END IF


//Decided not to do this....
//
//IF li_Return = 1 THEN
//	
//	//We're going to look PRIOR to the assignment event for any other events that should come with it.
//	//These events will have to be on the same day as the assignment event, because they'll need to be
//	//re-routed along with it.
//	
//	//An example would be if the assignment event is a mount, 
//	
//	lnv_WorkEvent.of_SetSource ( lds_Lookback )
//	
//	FOR ll_Row =  ll_AssignmentRow - 1 TO 1 STEP -1
//		
//		lnv_WorkEvent.of_SetSourceRow ( ll_Row )
//		
//		IF lnv_WorkEvent.of_HasSource ( ) THEN
//			//OK
//		ELSE
//			EXIT  //Not going to consider this a fatal error, since we've already identified something to assign.
//					//Although it certainly would be an unexpected & mysterious error.
//		END IF
//		
//		IF DaysAfter ( lnv_WorkEvent.of_GetDateArrived ( ), ld_AssignmentDate ) > 0 THEN
//			//The event we're looking at is on a prior day, and can't be routed with the assignment event.
//			//Exit the loop.  We've grabbed all the events we can.
//




IF li_Return = 1 THEN
	
	lnv_WorkEvent.of_SetSource ( lds_Lookback )
	
	//Then, determine the ending event  (either there'll be one, or there won't, which means
	//the whole thing from the starting event forward has to be rerouted.
	
	//As we go, verify that the trailer or container is the only thing assigned to the whole range of events, 
	//and that there are no "active" assignments anywhere in the range
	
	//If we go onto a different day without finding a dissociation event, fail.
	
	
	FOR ll_Row = ll_StartingRow TO ll_Lookback_Count
		
		lnv_WorkEvent.of_SetSourceRow ( ll_Row )
		
		ll_EventId = lnv_WorkEvent.of_GetId ( )
		ld_EventDate = lnv_WorkEvent.of_GetDateArrived ( )
		
		IF IsNull ( ll_EventId ) OR IsNull ( ld_EventDate ) THEN
			
			ls_ErrorMessage += "~n(Processing Error: Could not verify dissociation.  Could not determine the ID or Date for an event.)  (ABR-DL)"
			li_Return = -1
			EXIT
			
		ELSEIF DaysAfter ( ld_AssociationEventDate, ld_EventDate ) <> 0 THEN
			
			/*Decided I didn't need to distinguish between lb_AssociationInTarget TRUE/FALSE, since both were going to
				be failures, and I could use the same error message for both.  I've left the conditional structure, j.i.c.
			
			IF lb_AssociationInTarget THEN
				
				//I was going to do this....
				//There might be a dissociation in target, too.  Go ahead and attempt the re-route.
				//....in which case, I had no code here, I just let it exit the loop at this point, with li_Return = 1
				//(See the EXIT statement after the END IF, below)
				
				//But IF there was NOT a dissociation in the target, the events were getting routed to the tractor/driver, 
				//and then the assignment was failing because of this event on the later day, which is awkward.
				//So, I think it's better to disallow the whole operation, unless we can get around that problem.
				
				//If we could determine if there's a dissociation in the target (Driver/Tractor Itin), then we could go
				//ahead and allow the reroute, since the dissociation would be taken care of.
				
			*/
				
				IF lb_CurrentlyOnContainer THEN

					ls_ErrorMessage += "~n~nThere is no drop or dismount following the assignment on the day you are requesting in the container itinerary, "+&
						"and there are events routed to the container on a following day.  This situation cannot be processed automatically.  "+&
						"You will either need to reroute these events to the driver/tractor manually before assigning the container, "+&
						"or you will need to add a dismount or drop to the end of the container itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
						"The first event that is routed to the container after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".  (ABR)"

//					Another attempt at an explanation
//					ls_ErrorMessage += "~n(There are events pre-routed to the container itinerary on more than one day, "+&
//						"with no driver/tractor assignment and no dismount or drop in between.  This situation cannot be processed automatically.  "+&
//						"You will either need to reroute these events to the driver/tractor manually before assigning the container, "+&
//						"or you will need to add a dismount or drop to the end of the container itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
//						"The first event that is routed to the container after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"

//					Another attempt at an explanation....
//					ls_ErrorMessage += "~n(There are events in the container itinerary without a driver/tractor assignment "+&
//						"that should be included in this request, but there are also events routed on a later day, " +&
//						"with no dismount or drop in between.  "+&
//						"You will therefore need to reroute these events to the driver/tractor manually "+&
//						"before assigning the container, or add a drop or dismount to the container itinerary.  The first event that is routed "+&
//						"to the container after the assignment date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"
					
				ELSE  //Should be lb_CurrentlyOnTrailer

					ls_ErrorMessage += "~n~nThere is no drop following the assignment on the day you are requesting in the trailer itinerary, "+&
						"and there are events routed to the trailer on a following day.  This situation cannot be processed automatically.  "+&
						"You will either need to reroute these events to the driver/tractor manually and then assign the trailer, "+&
						"or you will need to add a drop to the end of the trailer itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
						"The first event that is routed to the trailer after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".  (ABR)"

//					Another attempt at an explanation...
//					ls_ErrorMessage += "~n(There are events pre-routed to the trailer itinerary on more than one day, "+&
//						"with no driver/tractor assignment and no drop in between.  This situation cannot be processed automatically.  "+&
//						"You will either need to reroute these events to the driver/tractor manually before assigning the trailer, "+&
//						"or you will need to add a drop to the end of the trailer itinerary on " + String ( ld_AssociationEventDate, "Dddd Mmm d" ) + ".  "+&
//						"The first event that is routed to the trailer after that date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"
					
//					Another attempt at an explanation...
//					ls_ErrorMessage += "~n(There are events in the trailer itinerary without a driver/tractor assignment "+&
//						"that should be included in this request, but there are also events routed on a later day, "+&
//						"with no drop in between.  You will therefore need to reroute these events to the driver/tractor manually "+&
//						"before assigning the trailer, or add a drop to the trailer itinerary.  The first event that is routed "+&
//						"to the trailer after the assignment date is on " + String ( ld_EventDate, "Dddd Mmm d" ) + ".)  (ABR)"
					
				END IF
					
				li_Return = -1

			/*Not distinguishing between lb_AssociatedInTarget TRUE/FALSE

			ELSE
				
				//Since the association event is coming from the trailer/container itin, and will be routed after all the other events 
				//in the target (driver/tractor itin), we're not going to get the dissociation we need.  Fail now.
				
				ls_ErrorMessage += ???
				li_Return = -1
				
			END IF
			
			*/
			
			EXIT
			
		ELSE
			
			//I'm going to do this here, before all the subsequent checks, because if the checks fail,
			//the whole operation will fail, and if the checks succeed, this event will definitely be
			//one of the ones rerouted.  If I hold it to the end of the loop, it could be inadvertently
			//bypassed if someone were to add a CONTINUE in the loop somewhere.
			ll_RerouteEventCount ++
			lla_RerouteEventIds [ ll_RerouteEventCount ] = ll_EventId
			
		END IF
		
		
		IF lnv_WorkEvent.of_GetAssignments ( lla_Drivers, lla_Equipment ) = 1 THEN
			
			IF UpperBound ( lla_Drivers ) = 0 AND UpperBound ( lla_Equipment ) = 1 THEN
				
				IF lla_Equipment [ 1 ] = ll_CurrentId THEN
					
					//OK
					
				ELSE
					
					ls_ErrorMessage += "~n(There are conflicting equipment assignments in the event range.)"
					li_Return = -1
					EXIT
					
				END IF
				
			ELSE
				
				ls_ErrorMessage += "~n(There are conflicting driver/equipment assignments in the event range.)"
				li_Return = -1
				EXIT
				
			END IF
			
		ELSE
			
			ls_ErrorMessage += "~n(Error evaluating equipment assignments in event range.)"
			li_Return = -1
			EXIT
			
		END IF
		
		
		CHOOSE CASE lnv_WorkEvent.of_GetType ( )
				
			CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_EndTrip
				
				//This is an event we can't drop into the driver / tractor itinerary, 
				//and we can't just reroute the events leading up to this one, because we've got
				//no closure (no dissociation of the trailer/container), so the routing would
				//have to carry through this event.
				
				ls_ErrorMessage += "~n(There is a NewTrip or EndTrip in the target event range.  This event must be rerouted manually.)"
				li_Return = -1
				EXIT
								
				
			CASE gc_Dispatch.cs_EventType_Dismount
				
				IF lb_CurrentlyOnContainer THEN  //If we're in trailer itinerary, dismount doesn't matter, keep going
					
					//OK, we've hit the dissociation event
					
					lb_HasDissociationEvent = TRUE
					ll_DissociationEventId = ll_EventID
					ll_DissociationEventRow = ll_Row
					EXIT
					
				END IF
				
				
			CASE gc_Dispatch.cs_EventType_Drop
				
				//OK, we've hit the dissociation event, whether we're in a trailer or container itinerary.
				
				lb_HasDissociationEvent = TRUE
				ll_DissociationEventId = ll_EventID
				ll_DissociationEventRow = ll_Row
				EXIT
				
				
		END CHOOSE
				
	NEXT
	
END IF
				

IF li_Return = 1 THEN
	
	//Determine an insertionstyle and insertionevent for when we reassign the trailer or container
	//to the range. (We'll be re-inserting the range into the trailer / container itinerary after 
	//the events have been rerouted to the driver/tractor and removed from the trailer/container,
	//and we want to put them back in the same position they're in now.)
	
	lnv_WorkEvent.of_SetSource ( lds_Lookback )
	
	IF lb_HasDissociationEvent AND ll_Lookback_Count > ll_DissociationEventRow THEN
		
		//We've got a dissociation event, and there's rows after that in the trailer/container itin, 
		//so the reassignment can happen just before the row that comes after the dissociation event.
		
		lnv_WorkEvent.of_SetSourceRow ( ll_DissociationEventRow + 1 )
		li_Assignment_InsertionStyle = gc_Dispatch.ci_InsertionStyle_Before
		ll_Assignment_InsertionEvent = lnv_WorkEvent.of_GetId ( )
		
	ELSEIF ll_StartingRow > 1 THEN
		
		//We don't have a dissociation event, but we have rows before the starting event, so the 
		//reassignment can happen just after the row that comes before the starting event.
		
		lnv_WorkEvent.of_SetSourceRow ( ll_StartingRow - 1 )
		li_Assignment_InsertionStyle = gc_Dispatch.ci_InsertionStyle_After
		ll_Assignment_InsertionEvent = lnv_WorkEvent.of_GetId ( )
		
	ELSE
		
		//Since we've got no dissociation event and no rows before the starting event, we should
		//have a clean day on ld_AssociationDate, so we can just go with ci_InsertionStyle_Assignment.
		
		li_Assignment_InsertionStyle = gc_Dispatch.ci_InsertionStyle_Assignment
		SetNull ( ll_Assignment_InsertionEvent )
		
	END IF	

END IF

////////////////////////////////
//
				
				
IF li_Return = 1 AND ab_ValidateRequest THEN
	Int	li_problems
	li_Problems = THIS.of_Validateassignment( ll_AssociationEventId , li_CurrentType, ll_CurrentId , ai_targettype , al_targetid )
//	li_Problems = THIS.of_Validateassignment( ll_AssociationEventId , ai_targettype, al_targetid , li_CurrentType , ll_CurrentId )
//li_Problems = THIS.of_ValidateRouterequest(  {ll_AssociationEventId}, ll_Assignment_InsertionEvent,ld_AssociationEventDate, ai_targettype , al_targetid )
	IF li_problems > 0 THEN	
		//IF NOT inv_validation.of_DoWeContinue( ) THEN
			li_Return = -3
	//	END IF
	END IF
END IF

//////////////////////////////////





IF li_Return = 1 THEN
	
	IF ll_RerouteEventCount > 0 THEN
	
		//Depending on which scenario we're dealing with, set the ll_Route_InsertionEvent and li_Route_InsertionStyle
		
		IF lb_AssociationInTarget THEN
			
			ll_Route_InsertionEvent = al_InsertionEvent
			li_Route_InsertionStyle = ai_InsertionStyle
			
		ELSE
			
			SetNull ( ll_Route_InsertionEvent )
			li_Route_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfRoute
			
		END IF
		
		
		//Perform the re-routing.
		
		CHOOSE CASE This.of_Route ( lla_RerouteEventIds, ai_TargetType, al_TargetId, ld_AssociationEventDate, &
				0 /*DateScaleStyle*/, ll_Route_InsertionEvent, li_Route_InsertionStyle )
				
			CASE 1	//Success
				
				
			CASE 0	//User cancelled
				li_Return = 0  //User cancelled
				
			CASE -1	//Error
				ls_ErrorMessage += "~n(Error attempting to route affected trailer/container events to the driver/tractor.)"
				li_Return = -1
				
			CASE ELSE	//Unexpected return
				ls_ErrorMessage += "~n(Unexpected return value attempting to route affected trailer/container events to the driver/tractor.)"
				li_Return = -1
				
		END CHOOSE
		
	ELSE
		//There are no events that qualify for special of_AssignByReroute processing.  Return -2 so that normal of_Assign
		//logic can be used instead, if possible.
		
		//Note: This should be sufficient to prevent infinite-looping that could otherwise occur between of_Assign
		//and of_AssignByReroute   (this script calls of_Assign later, once it has moved things around, and that
		//pass through of_Assign can delegate to of_AssignByReroute again.  At that point, though, there should
		//be nothing left for special handling, and processing should come here, and get sent back to "normal" of_Assign)
		
		li_Return = -2
		
	END IF
	
END IF
	
	
IF li_Return = 1 THEN
	
	lnv_Event.of_SetSource ( lds_Cache )
	lnv_Event.of_SetSourceId ( ll_AssociationEventId )
	
	IF lnv_Event.of_IsAssigned ( li_CurrentType, ll_CurrentId ) THEN
		
		//The current equipment has already been assigned, possibly by virtue of being linked shipment equipment, 
		//or other means.  Do not attempt to reassign it.
		
	ELSE
		
		//Assign the current equipment to the rerouted range, using the identified association event.
	
		This.ClearOFRErrors ( )
		
		CHOOSE CASE This.of_Assign ( li_Null, ll_Null, ll_AssociationEventId, li_CurrentType, ll_CurrentId, &
				ld_AssociationEventDate, ll_Assignment_InsertionEvent, li_Assignment_InsertionStyle )
				
			CASE 1	//Success
				
				
			CASE -1	//Error
				//Explain that the events have been re-routed, but the trailer / container could not be reassigned.
				
				//Or, try to put the events back to the trailer / container, where they were???
				//Leaving things the way things stand, events may end up on the driver/tractor, without the trailer/chassis
				//assignment coming with them, but that may actually be better than attempting to move them back.
				//The situations where of_assign would fail -- such as more events on the trailer / container
				//on subsequent days, with no dissociation event in either itin, would probably result in the
				//user trying to get all the events re-routed in anyway, so this way, at least they've got some of them
				//transferred over.
				
				
				ls_ErrorMessage = "Events were rerouted from the trailer/container to the driver/tractor in preparation "+&
					"for the assignment you requested, but the assignment could not be completed.  If you do not want "+&
					"these events rerouted, you will need to manually reroute them back, or close this window without "+&
					"saving your changes.~n~nThe error that prevented the assignment is:~n~n"

					
				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
					ls_ErrorMessage += lnva_Errors [ 1 ].GetErrorMessage ( )
				ELSE
					ls_ErrorMessage += "[Unspecified Error]"
				END IF					
					
				li_Return = -1
				
			CASE ELSE	//Unexpected return

				ls_ErrorMessage = "Events were rerouted from the trailer/container to the driver/tractor in preparation "+&
					"for the assignment you requested, but the assignment could not be completed, due to an unexpected return value.  If you do not want "+&
					"these events rerouted, you will need to manually reroute them back, or close this window without "+&
					"saving your changes.~n~nThe error that prevented the assignment is:~n~n"

					
				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
					ls_ErrorMessage += lnva_Errors [ 1 ].GetErrorMessage ( )
				ELSE
					ls_ErrorMessage += "[Unspecified Error -- Unexpected Return]"
				END IF					
					
				li_Return = -1
				
		END CHOOSE
		
	END IF
	
END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	This.ClearOFRErrors ( ) //Processing above may have loaded some.
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF


DESTROY ( lnv_AfterEvent )
DESTROY ( lnv_WorkEvent )
DESTROY ( lnv_Event )

DESTROY lds_Lookback

RETURN li_Return
end function

public function integer of_assign (integer ai_basetype, long al_baseid, long al_baseevent, integer ai_targettype, long al_targetid, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, boolean ab_validateonreroute);//Returns : 1, -1 , -2 = validation failed   
//					
//Note:  li_Return is set to 99 temporarily if the request is forwarded to of_AssignByReroute and succeeds, 
//			so that intervening processing is skipped, but it is set back to 1 at the end of the script

DataStore	lds_Cache, &
				lds_Base, &
				lds_Target, &
				lds_Lookback
DataWindow	ldw_Null  //For use with calls to gf_Rows_Sync

n_cst_beo_Event	lnv_Event, &
						lnv_BaseEvent, &
						lnv_AfterEvent, &
						lnv_WorkEvent
						
n_cst_Events		lnv_Events
n_cst_beo_Equipment2			lnv_Equipment
n_cst_beo_EquipmentLease2	lnv_EquipmentLease

Date		ld_AssignmentDate, &
			ld_Null, &
			ld_Lookback_Date
Long		ll_FirstBaseRow, &
			ll_LastBaseRow, &
			ll_BaseCount, &
			ll_BeforeRow, &
			ll_AfterRow, &
			ll_FirstTargetRow, &
			ll_LastTargetRow, &
			ll_TargetCount, &
			lla_Ids[], &
			ll_Row, &
			ll_CurrentSite, &
			ll_PreviousSite, &
			lla_Drivers[], &
			lla_Tractors[], &
			lla_TrailerChassis[], &
			lla_Containers[], &
			ll_ChassisId, &
			ll_PossibleOriginationEvent, &
			ll_PossibleTerminationEvent, &
			ll_PossibleClearedTerminationEvent, &
			lla_Empty[], &
			lla_Confirmed[], &
			ll_ConfirmedCount, &
			ll_Lookback_BaseId, &
			ll_Lookback_Count, &
			ll_DriverId, &
			ll_TractorId
String	ls_EventType, &
			ls_MultiList, &
			ls_Work, &
			ls_SiteMessage, &
			ls_Lookback_Find
Boolean	lb_Association = TRUE, &
			lb_DissociatedInBase, &
			lb_Continue, &
			lb_PossibleOrigTermChanges, &
			lb_Lookback, &
			lb_Lookback_Found //, &
//			lb_DissociatedInTarget, &
//			lb_ChangesInTarget
Integer	li_Result, &
			li_Pass, &
			li_Lookback_BaseType, &
			li_Lookback_Index
n_cst_OFRError		lnv_Error, &
						lnva_Errors[]

String	ls_ErrorMessage = "Could not process request."

Integer	li_Return = 1

SetNull ( ld_Null )
SetNull ( ll_ChassisId )	//If we're assigning a container and it turns out we should assign
									//a chassis with it, this will be set to the chassis id.

lnv_Equipment = CREATE n_cst_beo_equipment2
lnv_EquipmentLease =  CREATE n_cst_beo_EquipmentLease2
lnv_Event = CREATE n_cst_beo_Event
lnv_AfterEvent = CREATE n_cst_beo_Event
lnv_BaseEvent = CREATE n_cst_beo_Event
lnv_WorkEvent = CREATE n_cst_beo_Event

n_cst_beo_Shipment	lnv_Shipment
lnv_Event.of_SetContext ( THIS ) 
lnv_WorkEvent.of_SetContext ( THIS )

SetNull ( ll_PossibleOriginationEvent )
SetNull ( ll_PossibleTerminationEvent )
SetNull ( ll_PossibleClearedTerminationEvent )

lds_Cache = This.of_GetEventCache ( )

lnv_Event.of_SetSource ( lds_Cache )
lnv_Event.of_SetSourceId ( al_BaseEvent )  //Note:  This, along with al_BaseEvent, may be changed by Lookback processing.

//Get ld_AssignmentDate in a clean form, stripping off any unintended time component.
ld_AssignmentDate = Date ( DateTime ( lnv_Event.of_GetDateArrived ( ) ) )

ll_DriverId = lnv_Event.of_GetDriverId ( )
ll_TractorId = lnv_Event.of_GetTractorId ( )



/////NEW in 3.6.b3


IF li_Return = 1 THEN

	IF lnv_Event.of_IsAssigned ( ai_TargetType, al_TargetId ) THEN

		//The requested target is already present on the event.

		//Nothing special we can do here.  Flow through and try processing the request normally.

	ELSEIF ai_TargetType = gc_Dispatch.ci_ItinType_Driver AND NOT IsNull ( ll_DriverId ) THEN

		//A driver is already assigned.  Nothing special we can do here.  (Reject request now?? Not sure about dissoc.)

	ELSEIF ai_TargetType = gc_Dispatch.ci_ItinType_PowerUnit AND NOT IsNull ( ll_TractorId ) THEN

		//A power unit is already assigned.  Nothing special we can do here.  (Reject request now?? Not sure about dissoc.)


	ELSE   //(the requested target is not already present on the event)

		//A tractor can only be "assigned" via a new trip, although it can be active in the
		//assginment on a Hook/Mount.  However, with Hook/Mount, the TrailerChassis/Containers
		//are "assigned".  So, with respect to tractor, we are only concerned with NewTrip, below.

		CHOOSE CASE ai_TargetType

		CASE gc_Dispatch.ci_ItinType_Driver, gc_Dispatch.ci_ItinType_PowerUnit

			CHOOSE CASE lnv_Event.of_GetType ( )

			CASE gc_Dispatch.cs_EventType_NewTrip
				//Association can be made on this event.  No need to look back.

			CASE ELSE
				
				IF IsNull ( ll_DriverId ) AND IsNull ( ll_TractorId ) THEN
					
					//Event is routed to either a trailer or container itinerary.  In this scenario,
					//we are going to see if the range the event is in (a Hook-Drop range if event
					//is currently routed to a trailer, a Hook/Mount-Dismount/Drop range if event is 
					//currently routed to a container) can be routed to the Driver or PowerUnit itin
					//requested in Target Type & ID, and then the trailer or container that the event
					//is currently routed to reassigned.  
					
					This.ClearOFRErrors ( )
					
					CHOOSE CASE This.of_AssignByReroute( ai_BaseType, al_BaseId, al_BaseEvent, ai_TargetType, &
							al_TargetId, ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle , ab_validateonreroute )
							
					CASE 1	//Success
						li_Return = 99  //Will be set back to 1 later, but we need to skip intervening processing
						
					CASE 0	//User cancelled
						ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
							"as part of the assignment request was cancelled.  This cancels the assignment request."
						li_Return = -1   //Return codes for this function are only 1, -1
						
					CASE -1	//Error

						IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
							ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
						END IF
				
						IF Len ( ls_ErrorMessage ) > 0 THEN
							//OK
						ELSE
							ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
								"as part of the assignment request was unsuccessful."
						END IF
				
						ls_ErrorMessage += "~n~nThe requested assignment was not performed."
						li_Return = -1
						
						
					CASE -2	//of_AssignByReroute determined that there is no special handling appropriate.
						//This was the only hope for this scenario.  Fail.  
						
						ls_ErrorMessage += "~n(The assignment would have to be performed by rerouting events to the "+&
							"driver/tractor itinerary, but this is not possible in this routing situation.)"
						li_Return = -1
						
					CASE -3 // the assignment validation failed
						ls_ErrorMessage = "Assignment Validation failed" // we will get any errors from the validation object
						li_Return = -2										// But just in case we miss a call
						
					CASE ELSE	//Unexpected return
						ls_ErrorMessage += "~n(An attempt to reroute events from the trailer or container itinerary "+&
							"as part of the assignment request produced an unexpected return code.)"
						li_Return = -1
						
					END CHOOSE
					
				ELSE   //This is the logic that was here prior to 3.9.00
				
					lb_Lookback = TRUE
					ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_NewTrip + "'"
					
				END IF

			END CHOOSE

		CASE gc_Dispatch.ci_ItinType_TrailerChassis

			CHOOSE CASE lnv_Event.of_GetType ( )

			CASE gc_Dispatch.cs_EventType_Hook
				//Association can be made on this event.  No need to look back.

			CASE ELSE
				lb_Lookback = TRUE
				ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'"

			END CHOOSE

		CASE gc_Dispatch.ci_ItinType_Container

			CHOOSE CASE lnv_Event.of_GetType ( )

			CASE gc_Dispatch.cs_EventType_Hook, gc_Dispatch.cs_EventType_Mount
				//Association can be made on this event.  No need to look back.

			CASE ELSE
				lb_Lookback = TRUE
				ls_Lookback_Find = "de_event_type = '" + gc_Dispatch.cs_EventType_Hook + "'" + " OR " +&
					"de_event_type = '" + gc_Dispatch.cs_EventType_Mount + "'"

			END CHOOSE

		CASE ELSE	//Unexpected value

			//Just try to process the request as normal in case something below can handle this.

		END CHOOSE

	END IF


	IF lb_Lookback = TRUE THEN

		IF NOT IsNull ( ll_TractorId ) THEN

			li_Lookback_BaseType = gc_Dispatch.ci_ItinType_PowerUnit
			ll_Lookback_BaseId = ll_TractorId

		ELSEIF NOT IsNull ( ll_DriverId ) THEN

			li_Lookback_BaseType = gc_Dispatch.ci_ItinType_Driver
			ll_Lookback_BaseId = ll_DriverId

		ELSE

			//No frame of reference to look back with.  Cancel the Lookback attempt.
			lb_Lookback = FALSE

		END IF

	END IF

END IF


IF li_Return = 1 AND lb_LookBack = TRUE THEN

	FOR li_Lookback_Index = 1 TO 3

		CHOOSE CASE li_LookBack_Index

		CASE 1

			ld_Lookback_Date = ld_AssignmentDate	//Just look at the day the event is on

		CASE 2

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -3 )  //Look back 3 days

		CASE 3

			ld_Lookback_Date = RelativeDate ( ld_AssignmentDate, -7 )  //Look back 7 days

		END CHOOSE


		CHOOSE CASE This.of_RetrieveItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, ld_AssignmentDate, FALSE /*Don't need Prior*/ )
		
		CASE 1
			//Retrieved OK
		
		CASE -1
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (L)"
			li_Return = -1
			EXIT  //Exit the Lookback loop
	
		CASE -2
			ls_ErrorMessage = "A check with the database indicates that information needed "+&
				"to process this request has changed since your last save.  You should attempt "+&
				"to save now, before continuing.  (L)"
			li_Return = -1
			EXIT  //Exit the Lookback loop
	
		CASE ELSE  //Unexpected return value.
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (L)"
			li_Return = -1
			EXIT  //Exit the lookback loop
	
		END CHOOSE


		IF li_Lookback_Index = 1 THEN  //Looking at the same day the target event is on.

			ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_AssignmentDate, &
				ld_AssignmentDate, lds_Lookback )

			IF ll_Lookback_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookback loop
			END IF


			//Find the assignment event in the lookback itinerary datastore.
			
			lnv_WorkEvent.of_SetSource ( lds_Lookback )
			lnv_WorkEvent.of_SetSourceId ( al_BaseEvent )

			//Try to find a source row in the primary buffer only.
			ll_Row = lnv_WorkEvent.of_GetSourceRow ( )
		
			IF ll_Row > 0 THEN
				//OK
			ELSE
				ls_ErrorMessage += "~n(Could not identify assignment row.)  (L)"
				li_Return = -1
				EXIT //Exit the lookback loop
			END IF


			IF ll_Row > 1 THEN

				ll_Row = lds_Lookback.Find ( ls_Lookback_Find, ll_Row - 1, 1 )  //Search backwards, find the first eligible row.

				CHOOSE CASE ll_Row

				CASE IS > 0

					lnv_WorkEvent.of_SetSourceRow ( ll_Row )
					al_BaseEvent = lnv_WorkEvent.of_GetId ( )

					lb_Lookback_Found = TRUE
					EXIT  //Now, try to process the assignment on the new BaseEvent

				CASE 0

					//No eligible row found, continue on in the loop to look further backwards

				CASE ELSE

					ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
					li_Return = -1
					EXIT  //Exit the lookback loop

				END CHOOSE

			//ELSE

				//The BaseEvent row is the first row on the day.
				//Continue on in the loop to look further backwards.

			END IF

		ELSE

			//We're looking back prior to the day the originally requested event is on.

			//Get everything from the lookback date to the day before the originally requested event is on.

			ll_Lookback_Count = This.of_CopyItinerary ( li_Lookback_BaseType, ll_Lookback_BaseId, ld_Lookback_Date, &
				RelativeDate ( ld_AssignmentDate, -1 ), lds_Lookback )

			IF ll_Lookback_Count = -1 THEN
				ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (L)"
				li_Return = -1
				EXIT  //Exit the lookback loop
			END IF


			IF ll_Lookback_Count > 0 THEN

				ll_Row = lds_Lookback.Find ( ls_Lookback_Find, ll_Lookback_Count, 1 )  //Search backwards, find the first eligible row.

				CHOOSE CASE ll_Row

				CASE IS > 0

					lnv_WorkEvent.of_SetSourceRow ( ll_Row )
					al_BaseEvent = lnv_WorkEvent.of_GetId ( )
					lb_Lookback_Found = TRUE

					//  ****DO WE NEED TO DO ANYTHING TO ad_InsertionDate IN THIS CASE???******

					EXIT  //Now, try to process the assignment on the new BaseEvent

				CASE 0

					//No eligible row found, continue on in the loop to look further backwards, 
					//or, if this is the last pass, finish the loop unsuccessfully

				CASE ELSE

					ls_ErrorMessage += "~n(Error searching for valid assignment row.)  (L)"
					li_Return = -1
					EXIT  //Exit the lookback loop

				END CHOOSE

			//ELSE

				//Nothing to search.  Continue on in the loop to look further backwards, 
				//or, if this is the last pass, finish the loop unsuccessfully

			END IF

		END IF

	NEXT  //li_Lookback_Index


	IF li_Return = 1 THEN

		IF lb_Lookback_Found = TRUE THEN
			//OK.  Point lnv_Event at the new BaseEvent we've identified.
			lnv_Event.of_SetSourceId ( al_BaseEvent )
		ELSE
			//No eligible event was found.
			ls_ErrorMessage += "~n(No events in the prior week were capable of making the assignment requested.)"
			li_Return = -1
		END IF

	END IF

END IF


/////End of NEW section in 3.6.b3


//If the base type and id weren't passed in, determine them from the event.
//Note : If this turns out right, I may eliminate these parameters entirely.

IF li_Return = 1 AND IsNull ( ai_BaseType ) AND IsNull ( al_BaseId ) THEN

	lnv_Event.of_ClearErrors ( )

	CHOOSE CASE lnv_Event.of_GetBaseForAssignment ( ai_BaseType, al_BaseId, ai_TargetType, &
		al_TargetId, TRUE /*Assignment Request*/ )

	CASE 1
		//OK

	CASE ELSE

		ls_Work = lnv_Event.of_GetErrorString ( )

		IF Len ( ls_Work ) > 0 THEN
			ls_ErrorMessage = ls_Work
		ELSE
			ls_ErrorMessage += "~n(Unspecified error evaluating request in of_GetBaseForAssignment.)"
		END IF

		li_Return = -1

	END CHOOSE

END IF


//Retrieve the base itinerary from the assignment point forward, with prior event 
//(Actually, prior event wouldn't be needed if we already have the prior event on the same day -- 
//should we check for that?)

IF li_Return = 1 THEN

	CHOOSE CASE This.of_RetrieveItinerary ( ai_BaseType, al_BaseId, ld_AssignmentDate, ld_Null, TRUE /*Needs Prior*/ )
	
	CASE 1
		//Retrieved OK
	
	CASE -1
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (B)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "A check with the database indicates that information needed "+&
			"to process this request has changed since your last save.  You should attempt "+&
			"to save now, before continuing.  (B)"
		li_Return = -1

	CASE ELSE  //Unexpected return value.
		ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (B)"
		li_Return = -1

	END CHOOSE

END IF


li_Pass = 0

DO WHILE li_Return = 1 AND li_Pass < 2 //li_Pass will be =0 here 1st time thru, =1 2nd time

	li_Pass ++

	//If this is Pass 2, Re-initialize values that may have been set on the previous pass.

	IF li_Pass = 2 THEN

		ll_BaseCount = 0
		ll_FirstBaseRow = 0
		ll_TargetCount = 0
		ll_BeforeRow = 0
		ll_AfterRow = 0
		lla_Ids = lla_Empty
		ll_ConfirmedCount = 0
		lla_Confirmed = lla_Empty
		lnv_BaseEvent.of_ClearSource ( )
		lnv_AfterEvent.of_ClearSource ( )
		lnv_WorkEvent.of_ClearSource ( )

	END IF

	//Note : ll_Confirmed count and lla_Confirmed will be used to track confirmed events THAT MUST BE
	//UNCONFIRMED in order to complete the processing.  This may or may not be the absolute number of 
	//confirmed events.


	//Copy the base itinerary out to a datastore so we can work with it.
	
	IF li_Return = 1 THEN
	
		//Copy everything we've got for the base id.  We'll have everything from the prior event forward,
		//but we may have a discontinuous jumble of things prior to that.
	
		ll_BaseCount = This.of_CopyItinerary ( ai_BaseType, al_BaseId, ld_Null, ld_Null, lds_Base )
	
		IF ll_BaseCount = -1 THEN
			ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (B)"
			li_Return = -1
		ELSE
			lnv_WorkEvent.of_SetSource ( lds_Base )
		END IF
	
	END IF


	//Find the assignment event in the base itinerary datastore.
	
	IF li_Return = 1 THEN
	
		lnv_BaseEvent.of_SetSource ( lds_Base )
		lnv_BaseEvent.of_SetSourceId ( al_BaseEvent )
	
		//ll_FirstBaseRow = lds_Base.Find ( "de_id = " + String ( al_BaseEvent ), 1, ll_BaseCount )
	
		//Try to find a source row in the primary buffer only.
		ll_FirstBaseRow = lnv_BaseEvent.of_GetSourceRow ( )
	
		IF ll_FirstBaseRow > 0 THEN
			//OK
		ELSE
			ls_ErrorMessage += "~n(Could not identify assignment row.)  (B)"
			li_Return = -1
		END IF
	
	END IF


	//Evaluate the assignment event.  (Only necessary on the first pass)
	
	IF li_Return = 1 AND li_Pass = 1 THEN
	
		ls_EventType = lds_Base.Object.de_Event_Type [ ll_FirstBaseRow ]
	
		IF lnv_Events.of_IsTypeAssignment ( ls_EventType ) THEN
	
			IF lnv_Events.of_IsTypeDeliverGroup ( ls_EventType ) THEN
				lb_Association = FALSE
			END IF
	
		ELSE
	
			ls_ErrorMessage = "The requested event is not an assignment event."
			li_Return = -1
	
		END IF
	
	END IF
	
	
	//Retrieve the target itinerary from the assignment point forward, with prior event 
	//(Only necessary on first pass)
	//(Actually, prior event wouldn't be needed if we already have the prior event on the same day -- 
	//should we check for that?).  (We don't need the target if this is a dissociation, since the
	//target is already part of the base.)
	
	IF li_Return = 1 AND lb_Association = TRUE AND li_Pass = 1 THEN
	
		CHOOSE CASE This.of_RetrieveItinerary ( ai_TargetType, al_TargetId, ld_AssignmentDate, ld_Null, TRUE /*Needs Prior*/ )
		
		CASE 1
			//Retrieved OK
		
		CASE -1
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information.)  (T)"
			li_Return = -1
	
		CASE -2
			ls_ErrorMessage = "A check with the database indicates that information needed "+&
				"to process this request has changed since your last save.  You should attempt "+&
				"to save now, before continuing.  (T)"
			li_Return = -1
	
		CASE ELSE  //Unexpected return value.
			ls_ErrorMessage += "~n(Could not retrieve necessary itinerary information: Unexpected return value.)  (T)"
			li_Return = -1
	
		END CHOOSE
	
	END IF


	//Copy the target itinerary out to a datastore so we can work with it.
	//(We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		//Copy everything we've got for the target id.  We'll have everything from the prior event forward,
		//but we may have a discontinuous jumble of things prior to that.
	
		ll_TargetCount = This.of_CopyItinerary ( ai_TargetType, al_TargetId, ld_Null, ld_Null, lds_Target )
	
		IF ll_TargetCount = -1 THEN
			ls_ErrorMessage += "~n(Could not copy necessary itinerary information.)  (T)"
			li_Return = -1
		END IF
	
	END IF


	//Find the insertion point in the target itinerary datastore.
	//(We don't need this if this is a dissociation.)
	
	//If it's before the first row (or there are no rows), ll_AfterRow should be set to 0.
	//If it's after the last row (or there are no rows), ll_BeforeRow should be set to null.
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
	
		CHOOSE CASE ai_InsertionStyle
	
		CASE gc_Dispatch.ci_InsertionStyle_Assignment
	
			li_Result = lnv_Events.of_GetInsertionPoint ( lds_Base, ai_BaseType, al_BaseId, al_BaseEvent, &
				lds_Target, ai_TargetType, al_TargetId, ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle, &
				ll_BeforeRow /*Ref*/, ls_Work /*Gets Error Text*/ )
	
		CASE ELSE
	
			li_Result = lnv_Events.of_GetInsertionPoint ( lds_Target, ai_TargetType, al_TargetId, &
				ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle, ll_BeforeRow /*Ref*/, &
				ls_Work /*Gets Error Text*/ )
	
		END CHOOSE
	
	
		CHOOSE CASE li_Result
	
		CASE 1
	
			//ll_BeforeRow should be > 0, based on success of of_GetInsertionPoint
	
			IF ll_BeforeRow > ll_TargetCount THEN
	
				//Note : If there are no rows, we will come here, because ll_BeforeRow will be 1 and
				//ll_TargetCount will be 0.
	
				ll_AfterRow = ll_TargetCount
				SetNull ( ll_BeforeRow )
	
			ELSEIF ll_BeforeRow > 0 THEN
	
				ll_AfterRow = ll_BeforeRow - 1
	
			ELSE
				ls_ErrorMessage += "~n(Unexpected insertion row value returned from of_GetInsertionPoint.)"
				li_Return = -1
	
			END IF
	
		CASE -1
	
			ls_ErrorMessage = ls_Work
			li_Return = -1
	
			//Note : If ai_InsertionStyle = ci_InsertionStyle_EmptyDay and the day was not empty, 
			//the message will come back with "(IPRQ)" in it.  This will be passed along here, and
			//can be checked by the calling script to see if that was the problem.
	
		CASE ELSE
	
			ls_ErrorMessage += "~n(Unexpected return error for of_GetInsertionPoint.)"
			li_Return = -1
	
		END CHOOSE
	
	END IF


	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		//These two conditions are not mutually exclusive.  They could both be true.  But, I think it's 
		//sufficient to check one of them.  Or, neither of them might be true, in which case there's
		//no date conflict, so we're ok.
	
		IF ll_BeforeRow <= ll_TargetCount AND ll_BeforeRow > 0 THEN
	
			//We've got an actual row for ll_BeforeRow, so make sure that it falls on or after the 
			//assignment date, as a cross-check.
	
			IF DaysAfter ( ld_AssignmentDate, lds_Target.Object.de_ArrDate [ ll_BeforeRow ] ) >= 0 THEN
				//Insertion point is on or after the assignment date -- we're ok.
			ELSE
				//Insertion point is before the assignment date -- we're not ok.
				ls_ErrorMessage += "~n(Attempting to insert before an event routed prior to the assignment date.)"
				li_Return = -1
			END IF
	
		ELSEIF ll_AfterRow <= ll_TargetCount AND ll_AfterRow > 0 THEN
	
			//We've got an actual row for ll_AfterRow, so make sure that it falls on or before the 
			//assignment date, as a cross-check.
	
			IF DaysAfter ( ld_AssignmentDate, lds_Target.Object.de_ArrDate [ ll_AfterRow ] ) <= 0 THEN
				//Insertion point is on or before the assignment date -- we're ok.
			ELSE
				//Insertion point is after the assignment date -- we're not ok.
				ls_ErrorMessage += "~n(Attempting to insert after an event routed later than the assignment date.)"
				li_Return = -1
			END IF
	
		END IF
	
	END IF


	//Set up the lnv_AfterEvent beo.  (We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE AND ll_AfterRow > 0 THEN
	
		lnv_AfterEvent.of_SetSource ( lds_Target )
		lnv_AfterEvent.of_SetSourceRow ( ll_AfterRow )
	
	END IF


	//Get the remainder at the insertion point in the target itinerary.
	//(We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		IF lnv_Events.of_GetRemainder ( lds_Target, ll_AfterRow, ai_TargetType, al_TargetId, lla_Ids ) = -1 THEN
			li_Return = -1
		END IF
	
	END IF


	//Check whether the assignment conflicts with existing assignments at the insertion point in the target.
	//(We don't need this if this is a dissociation.)
	
	IF li_Return = 1 AND lb_Association = TRUE THEN
	
		//***Convert these references to use the new Constants***
	
		CHOOSE CASE ai_TargetType
	
		CASE gc_Dispatch.ci_ItinType_Driver
	
			IF NOT IsNull ( lla_Ids [2] ) THEN
				ls_ErrorMessage += "The driver is already assigned to a power unit at the position you have indicated."
				li_Return = -1
			END IF
	
		CASE gc_Dispatch.ci_ItinType_PowerUnit
	
			IF NOT IsNull ( lla_Ids [1] ) THEN
				ls_ErrorMessage += "The power unit is already assigned to a driver at the position you have indicated."
				li_Return = -1
			END IF
	
		CASE ELSE
	
			IF NOT ( IsNull ( lla_Ids [ 1 ] ) AND IsNull ( lla_Ids [ 2 ] ) ) THEN
				ls_ErrorMessage += "The equipment you've requested is already assigned to a driver and/or power unit "+&
					"at the position you have indicated."
				li_Return = -1
			END IF
	
		END CHOOSE
	
	END IF
	
	
	//*****************************  NEW SECTION 3.9.00
	
	
	IF li_Return = 1 AND ( ai_TargetType = gc_Dispatch.ci_ItinType_TrailerChassis OR &
		ai_TargetType = gc_Dispatch.ci_ItinType_Container ) AND &
		DaysAfter ( ad_InsertionDate, lnv_AfterEvent.of_GetDateArrived ( ) ) = 0 THEN
		
		IF lnv_AfterEvent.of_GetDriverId ( ) > 0 OR lnv_AfterEvent.of_GetTractorId ( ) > 0 THEN  
			
			//The suggested insertion point immediately follows an event that's routed to a driver or tractor.
			//This is not a candidate for of_AssignByReroute.  We're looking for "loose events" at the end of
			//the trailer or container itinerary (events that are routed only to the trailer or container, with
			//no driver/tractor assigned.)
		
		ELSE
			
			//Unlike the other of_AssignByReroute, where the base was already a Trailer or Container itin 
			//and the target was a Driver or Tractor, here we have the reverse -- a base of Driver or Tractor, 
			//and a target of trailer or container, and we're going to HANDLE this by flip-flopping and requesting
			//an of_AssignByReroute on the AfterEvent in the Trailer/Container itin, with the driver or tractor
			//being assigned.

			This.ClearOFRErrors ( )

			CHOOSE CASE This.of_AssignByReroute ( ai_TargetType, al_TargetId, lnv_AfterEvent.of_GetId ( ), &
					ai_BaseType, al_BaseId, ad_InsertionDate, al_BaseEvent, gc_Dispatch.ci_InsertionStyle_After )
					
					//Using gc_Dispatch.ci_InsertionStyle_After signals of_AssignByReroute that it should
					//use the Hook or Mount in al_BaseEvent and insert itself into the driver / tractor 
					//itinerary immediately after that event.
					
			CASE 1	//Success
				li_Return = 99  //Will be set back to 1 later, but we need to skip intervening processing
				
			CASE 0	//User cancelled
				ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
					"as part of the assignment request was cancelled.  This cancels the assignment request."
				li_Return = -1   //Return codes for this function are only 1, -1
				
			CASE -1	//Error

				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
					ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
				END IF
		
				IF Len ( ls_ErrorMessage ) > 0 THEN
					//OK
				ELSE
					ls_ErrorMessage = "An attempt to reroute events from the trailer or container itinerary "+&
						"as part of the assignment request was unsuccessful."
				END IF
		
				ls_ErrorMessage += "~n~nThe requested assignment was not performed."
				li_Return = -1
				
				
			CASE -2	//of_AssignByReroute determined that there is no special handling appropriate, that the
						//request should be processed conventionally.
						
				//Do not change return code.  Allow processing to continue normally.
				
			CASE -3 // the assignment validation failed
						ls_ErrorMessage = "Assignment Validation failed." // we will get any errors from the validation object
																						// but just in case we miss a call
						li_Return = -2
						
						
						
			CASE ELSE	//Unexpected return
				ls_ErrorMessage += "~n(An attempt to reroute events from the trailer or container itinerary "+&
					"as part of the assignment request produced an unexpected return code.)"
				li_Return = -1
				
			END CHOOSE
	
		END IF
		
	END IF
	
	
	//*****************************  END NEW SECTION 3.9.00


	//Make the actual changes to the event that performs the association (or dissociation).
	
	IF li_Return = 1 THEN
	
		IF lnv_Events.of_Assign ( lds_Base, ll_FirstBaseRow, ai_TargetType, al_TargetId ) = 1 THEN
			//OK
		ELSE
			ls_ErrorMessage = "The requested assignment is invalid."
			li_Return = -1
		END IF
	
	END IF


	//Carry the assignment forward and make adjustments to the events that follow.
	//Stop when the assignment change no longer has forward impact.
	
	IF li_Return = 1 THEN
	
		ll_LastBaseRow = ll_FirstBaseRow
	
		FOR ll_Row = ll_FirstBaseRow + 1 TO ll_BaseCount

			IF lb_Association = FALSE THEN

				lnv_WorkEvent.of_SetSourceRow ( ll_Row )

				IF lnv_WorkEvent.of_IsConfirmed ( ) = FALSE THEN
					//OK
				ELSE
					ll_ConfirmedCount ++
					lla_Confirmed [ ll_ConfirmedCount ] = lnv_WorkEvent.of_GetId ( )
				END IF

			END IF

	
			lnv_Events.of_GetRemainder ( lds_Base, ll_Row - 1, ai_BaseType, al_BaseId, lla_Ids )
	
			IF lnv_Events.of_Adjust ( lds_Base, ll_Row, ai_BaseType, al_BaseId, lla_Ids, &
				ai_TargetType, al_TargetId, lb_Association, lb_DissociatedInBase ) = 1 THEN
				//OK
			ELSE
				li_Return = -1
				EXIT
			END IF
	
			ll_LastBaseRow = ll_Row
	
			IF lb_DissociatedInBase = TRUE THEN
	
				//If this is an association, of_Adjust unassigned the thing we're assigning.
	
				//If this is a dissociation, of_Adjust has determined that the event we just processed
				//formerly performed the same dissociation.
	
				//Either way, we can stop now.
	
				EXIT
	
			END IF
	
		NEXT
	
	END IF


	IF li_Return = 1 AND lb_Association AND lb_DissociatedInBase = FALSE AND ll_BeforeRow > 0 THEN
	
	// The equipment / driver we're assigning didn't get dissociated by any of the base events, and there's
	//	events after the intertion point in the target itinerary.
	
	//	I originally thought we'd allow this, but it's complicated both in terms of of_Adjust processing, and
	// in terms of applying the sequence #s to whatever the target has inherited from the base.  There's also
	// multi-day issues to contend with.  So, I think the best policy for now is to disallow it.  If the user
	// wants to bring those target events over, they'd have to re-route them to the base using the clipboard,
	// then make the assignment.  Perhaps we could offer some help with that by remembering which piece of
	// equipment they were working with, and having it readily available to the assignment window as a selection.
	
	//	The commented code below did work, for the limited amount I had tested it, but it did not handle multi-day
	//	issues or sequence # assignments.
	
		ls_ErrorMessage = "The equipment you're assigning would not get unassigned here, and "+&
			"events have already been routed to it later on.  This would create a conflict.  "+&
			"This request cannot be processed."
		li_Return = -1
	
	//////////////////////////////
	
	//	//Since the equipment / driver we're assigning didn't get dissociated by any of the base events,
	//	//now we need to carry forward into the target and adjust the assignments on those events.
	//
	//	//Get the remainder at the last base row.  Those assignments must now carry forward into the target.
	//	lnv_Events.of_GetRemainder ( lds_Base, ll_LastBaseRow, ai_BaseType, al_BaseId, lla_Ids )
	//
	//	ll_FirstTargetRow = ll_BeforeRow
	//	//ll_LastTargetRow = ll_BeforeRow
	//
	//	FOR ll_Row = ll_FirstTargetRow /*Not +1 here*/ TO ll_TargetCount
	//
	//		//Here, ai_TargetType/al_TargetId is both the perspective and the assignment.
	//
	//		IF lnv_Events.of_Adjust ( lds_Target, ll_Row, ai_TargetType, al_TargetId, lla_Ids, &
	//			ai_TargetType, al_TargetId, TRUE /*Association*/, lb_DissociatedInTarget ) = 1 THEN
	//			//OK -- flag that we need to sync the target ds back into the cache.
	//			lb_ChangesInTarget = TRUE
	//		ELSE
	//			li_Return = -1
	//			EXIT
	//		END IF
	//
	//		ll_LastTargetRow = ll_Row
	//
	//		IF lb_DissociatedInTarget = TRUE THEN
	//			//of_Adjust unassigned the thing we're assigning.  We can stop.
	//			EXIT
	//		END IF
	//
	//		//May not be necessary to do this at the last row, if we don't end up using the ids outside the loop.
	//		lnv_Events.of_GetRemainder ( lds_Target, ll_Row, ai_TargetType, al_TargetId, lla_Ids )
	//
	//	NEXT
		
	END IF


	IF li_Return = 1 AND ll_ConfirmedCount > 0 THEN

		//The unassignment processing went smoothly, but there were confirmed events
		//in the affected range.  If this is the first attempt, we'll try to unconfirm
		//the events, and if successful, perform a 2nd attempt.  If this is the 2nd
		//attempt, something has gone wrong, and we'll fail.

		IF li_Pass = 1 THEN

			This.ClearOFRErrors ( )

			CHOOSE CASE This.of_UnconfirmEvents ( lla_Confirmed, FALSE /*Non-interactive*/ )

			CASE 1
				//OK.  Jump over the processing that would finish out this pass, and just
				//try the processing over again now that everything's unconfirmed.

				CONTINUE
		
			CASE -1
				IF This.GetOFRErrors ( lnva_Errors ) > 0 THEN
					ls_ErrorMessage = lnva_Errors [ 1 ].GetErrorMessage ( )
				END IF
		
				IF Len ( ls_ErrorMessage ) > 0 THEN
					//OK
				ELSE
					ls_ErrorMessage = "Unspecified error attempting to unconfirm events."
				END IF
		
				ls_ErrorMessage += "~n~nThe requested unassignment was not performed."
				li_Return = -1
		
			CASE ELSE
		
				//Unexpected return value.
		
				ls_ErrorMessage = "Unexpected return error attempting to unconfirm events."
				ls_ErrorMessage += "~n~nThe requested assignment was not performed."
				li_Return = -1
		
			END CHOOSE

		ELSE

			//Shouldn't happen.  We should only be making a 2nd attempt if we were
			//able to unconfirm everything.

			ls_ErrorMessage = "Could not unconfirm " + String ( ll_ConfirmedCount ) +&
				" affected events.  The requested assignment was not performed."
			li_Return = -1

		END IF

	END IF


	//If we've reached this point (ie, we didn't CONTINUE, above), we're done and we need to exit the loop.

	EXIT

LOOP


//Apply sequence numbers to the range the new assignment has been applied to.
//(We don't need this if this is a dissociation.)

IF li_Return = 1 AND lb_Association = TRUE THEN

	lnv_Events.of_SequenceRange ( lds_Base, ll_FirstBaseRow, ll_LastBaseRow, ai_TargetType, al_TargetId, &
		lds_Target, ll_AfterRow, lds_Target, ll_BeforeRow )

END IF


//If we're associating a container or trailer, cross check the previous site with the site specified for
//the base event.  If there is no site specified for the base event and there is a site specified for the
//previous event, set the previous event site as the site for the base event.

IF li_Return = 1 AND lb_Association = TRUE AND ll_AfterRow > 0 THEN

	lb_Continue = TRUE

	IF lb_Continue = TRUE THEN

		CHOOSE CASE ai_TargetType
	
		CASE gc_Dispatch.ci_ItinType_Container, gc_Dispatch.ci_ItinType_TrailerChassis

			//We need to continue.

		CASE ELSE

			//We're done.
			lb_Continue = FALSE

		END CHOOSE

	END IF


	IF lb_Continue = TRUE THEN


		ll_CurrentSite = lnv_BaseEvent.of_GetSite ( )
		ll_PreviousSite = lnv_AfterEvent.of_GetSite ( )

		IF ll_CurrentSite = ll_PreviousSite THEN

			//OK

		ELSEIF IsNull ( ll_CurrentSite ) THEN

			IF NOT IsNull ( ll_PreviousSite ) THEN

				lnv_BaseEvent.of_SetSite ( ll_PreviousSite )

			END IF

		ELSE

			ls_SiteMessage = "The site specified for the event does not match the position of the equipment."

		END IF

	END IF

END IF


//If we're assigning a TrailerChassis or Container, check whether there are possible
//origination and/or termination changes.

IF li_Return = 1 AND ( ai_TargetType = gc_Dispatch.ci_ItinType_TrailerChassis OR &
	ai_TargetType = gc_Dispatch.ci_ItinType_Container ) THEN

	IF lb_Association = TRUE THEN

		IF lnv_BaseEvent.of_IsConfirmed ( ) THEN
			ll_PossibleOriginationEvent = al_BaseEvent
		END IF

		IF lb_DissociatedInBase = TRUE THEN

			lnv_Event.of_SetSource ( lds_Base )
			lnv_Event.of_SetSourceRow ( ll_LastBaseRow )

			IF lnv_Event.of_IsConfirmed ( ) THEN
				ll_PossibleTerminationEvent = lnv_Event.of_GetId ( )
			END IF

		END IF

	ELSEIF lb_Association = FALSE THEN

		IF lnv_BaseEvent.of_IsConfirmed ( ) THEN
			ll_PossibleTerminationEvent = al_BaseEvent
		END IF

		IF lb_DissociatedInBase = TRUE THEN

			//This event would (should) have been unconfirmed, above, which would make
			//this logic unnecessary.  But, I'm going to include this processing anyway, 
			//in case it wasn't, or in case the unconfirmation logic above changes.

			lnv_Event.of_SetSource ( lds_Base )
			lnv_Event.of_SetSourceRow ( ll_LastBaseRow )

			IF lnv_Event.of_IsConfirmed ( ) THEN
				ll_PossibleClearedTerminationEvent = lnv_Event.of_GetId ( )
			END IF

		END IF

	END IF


	//Based on the processing above, flag whether we have possible origination and/or
	//termination changes.

	IF IsNull ( ll_PossibleOriginationEvent ) AND &
		IsNull ( ll_PossibleTerminationEvent ) AND &
		IsNull ( ll_PossibleClearedTerminationEvent ) THEN

		lb_PossibleOrigTermChanges = FALSE

	ELSE

		lb_PossibleOrigTermChanges = TRUE

	END IF

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE THEN

	CHOOSE CASE This.of_RetrieveEquipment ( { al_TargetId } )

	CASE 1
		//OK

	CASE -1
		ls_ErrorMessage += "~n(Error retrieving equipment information.)"
		li_Return = -1

	CASE -2
		ls_ErrorMessage += "~n(Original value conflict retrieving equipment.)"
		li_Return = -1

	CASE ELSE
		ls_ErrorMessage += "~n(Unexpected return error retrieving equipment.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN
	lnv_Equipment.of_SetSource ( This.of_GetEquipmentCache ( ) )
	lnv_Equipment.of_SetSourceId ( al_TargetId )
END IF 

IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE THEN
	IF lnv_Equipment.of_IsLeased ( ) = TRUE THEN
		lnv_EquipmentLease.of_SetSource ( This.of_GetEquipmentCache ( ) )
		lnv_EquipmentLease.of_SetSourceId ( al_TargetId )
	ELSE
		lb_PossibleOrigTermChanges = FALSE
	END IF

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE AND &
	NOT IsNull ( ll_PossibleClearedTerminationEvent ) THEN

	CHOOSE CASE lnv_EquipmentLease.of_ClearTermination ( ll_PossibleClearedTerminationEvent )

	CASE 1
		//OK -- Cleared successfully

	CASE 0
		//OK -- Wasn't the termination

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Error evaluating existing termination.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating existing termination.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE AND &
	NOT IsNull ( ll_PossibleOriginationEvent ) THEN

	CHOOSE CASE lnv_EquipmentLease.of_ProposeOrigination ( ll_PossibleOriginationEvent, &
		lds_Base, FALSE /*Non-interactive*/ )

	CASE 1
		//OK -- Origination Set
		
	CASE 0
		//OK -- Proposed origination not used

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Error evaluating origination information.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating origination information.)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_PossibleOrigTermChanges = TRUE AND &
	NOT IsNull ( ll_PossibleTerminationEvent ) THEN

	CHOOSE CASE lnv_EquipmentLease.of_ProposeTermination ( ll_PossibleTerminationEvent, &
		lds_Base, FALSE /*Non-interactive*/ )

	CASE 1
		//OK -- Termination Set

	CASE 0
		//OK -- Proposed termination not used

	CASE -1
		//Error
		ls_ErrorMessage += "~n(Error evaluating termination information.)"
		li_Return = -1

	CASE ELSE
		//Unexpected return
		ls_ErrorMessage += "~n(Unexpected return error evaluating termination information.)"
		li_Return = -1

	END CHOOSE

END IF


//If we're associating a container using a hook and if the previous target event (ll_AfterRow) dissociated it,
//see if a chassis was dissociated too (ie, dropped with the container.)  If so, provided there's not already
//a chassis assigned, associate that chassis, too.
//(Note : We won't associate the chassis if we're mounting, since that probably means we're using a different
//chassis.  Also, we won't associate the container if we're hooking the chassis, because that probably means 
//the user is trying to hook just the chassis.)

IF li_Return = 1 AND lb_Association = TRUE AND ll_AfterRow > 0 THEN

	lb_Continue = TRUE

	IF lb_Continue = TRUE THEN

		IF lnv_BaseEvent.of_IsHook ( ) THEN
			//OK, continue
		ELSE
			lb_Continue = FALSE
		END IF

	END IF

	IF lb_Continue = TRUE THEN

		CHOOSE CASE ai_TargetType
	
		CASE gc_Dispatch.ci_ItinType_Container

			//OK, continue.

		CASE ELSE

			//We're done.
			lb_Continue = FALSE

		END CHOOSE

	END IF

//	IF lb_Continue = TRUE THEN
//
//		//If we've already got a chassis and no containers, don't continue.
//
//	END IF

	IF lb_Continue = TRUE THEN

		//Determine the dropped chassis (if there was one), and attempt to assign it.

		IF lnv_AfterEvent.of_GetActiveAssignments ( lla_Drivers, lla_Tractors, &
			lla_TrailerChassis, lla_Containers ) = 1 THEN

			//OK

		ELSE

			//I'm not going to fail over this, but we can't continue trying to indentify a chassis, either.
			lb_Continue = FALSE

		END IF

	END IF


	IF lb_Continue = TRUE THEN

		//If we dropped ONE TrailerChassis, attempt to use it as the chassis.
		//Note : We could check that it's container-capable, but 99+% of the time it would be, 
		//so I'm not going to bother.  The assignment attempt itself will screen for whether it's
		//already assigned to this sequence and not let it be assigned twice, so we don't have to 
		//check for that.

		IF UpperBound ( lla_TrailerChassis ) = 1 THEN

			ll_ChassisId = lla_TrailerChassis [ 1 ]

		END IF

	END IF

END IF


IF li_Return = 1 THEN

	//Can't use MergeEvents here.  That's intended for new retrieval only.

	gf_Rows_Sync ( lds_Base, ldw_Null, lds_Cache, ldw_Null, Filter! /*NewRowBuf*/, &
		FALSE /*Only Modified Rows*/, FALSE /*Only modified data*/ )

END IF


//Can't be changes in target, now.
//
//IF li_Return = 1 AND lb_ChangesInTarget THEN
//
//	//Can't use MergeEvents here.  That's intended for new retrieval only.
//
//	gf_Rows_Sync ( lds_Target, ldw_Null, lds_Cache, ldw_Null, Filter! /*NewRowBuf*/, &
//		FALSE /*Only Modified Rows*/, FALSE /*Only modified data*/ )
//
//END IF


IF li_Return = 1 AND IsNull ( ll_ChassisId ) = FALSE THEN

	This.of_Assign ( ai_BaseType, al_BaseId, al_BaseEvent, &
		gc_Dispatch.ci_ItinType_TrailerChassis, ll_ChassisId, ld_Null, &
		lnv_AfterEvent.of_GetId ( ), gc_Dispatch.ci_InsertionStyle_After )

	This.ClearOFRErrors ( )

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	This.ClearOFRErrors ( ) //Processing above may have loaded some.
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF


IF li_Return = 99 THEN  //Request was handled successfully by of_AssignByReroute

	li_Return = 1  //Now that we've skipped the intervening processing, set the external return back to 1
	
END IF


IF li_Return = 1 THEN
	n_cst_EquipmentPosting	lnv_EqPosting

	lnv_EqPosting = THIS.of_GetEquipmentposting( )
	IF IsValid ( lnv_EqPosting ) THEN
		lnv_EqPosting.of_RemoveHave( lnv_Equipment )
	END IF
END IF

//IF li_Return = 1 THEN
//	/*
//	Here is what is going on here....If you assign a trailer (as an example) to an event that is not shipment based the
//	shipment summary will not correctly show the trailer on the shipments that the assignment has flowed down to.
//	Issue number 2686
//	*/
///*	Int i 
//	n_cst_beo_Shipment	lnv_Shipment
//	FOR i = ll_FirstBaseRow TO ll_lastBaseRow
//		lnv_event.of_SetSource (lds_Base)
//		lnv_event.of_SetSourceRow ( i )
//		lnv_event.of_getShipment ( lnv_Shipment )
//		IF IsValid ( lnv_Shipment ) THEN
//			lnv_Shipment.of_Markasmodified( )
//			Destroy ( lnv_Shipment ) 
//		END IF
//		
//	NEXT
//	*/	
//END IF



DESTROY ( lnv_EquipmentLease )
DESTROY ( lnv_AfterEvent )
DESTROY ( lnv_BaseEvent )
DESTROY ( lnv_WorkEvent )
DESTROY ( lnv_Event )
DESTROY ( lnv_Equipment )

DESTROY lds_Base		//This was not here prior to 3.6.b3, may have been a memory leak.  BKW
DESTROY lds_Target	//This was not here prior to 3.6.b3, may have been a memory leak.  BKW
DESTROY lds_Lookback

RETURN li_Return
end function

public function n_cst_bso_document_manager of_getdocumentmanager ();IF Not IsValid ( inv_documentmanager ) THEN
	inv_Documentmanager = CREATE n_cst_bso_document_manager
END IF
RETURN inv_documentmanager
end function

public function n_Cst_alertManager of_getalertmanager ();IF Not isValid ( inv_Alertmanager ) THEN
	inv_alertmanager = CREATE n_Cst_AlertManager
END IF
RETURN inv_alertmanager
end function

private function n_Cst_bso_EdiManager_322 of_get322manager ();IF Not isValid ( inv_322manager ) THEN
	inv_322manager = CREATE n_Cst_bso_EdiManager_322
END IF

RETURN inv_322manager
end function

public function long of_getshipments (long ala_shipmentids[], ref n_cst_beo_shipment anva_shipments[]);Long	ll_Return
Long	ll_Count
Long	i
n_cst_Beo_Shipment	lnva_Shipment[]


ll_Count = UpperBound ( ala_shipmentids[] )

IF THIS.of_RetrieveShipments ( ala_shipmentids[] ) >= 0 THEN
	ll_Return = ll_Count
	FOR i = 1 TO ll_Count
		
		lnva_Shipment[i] = CREATE n_Cst_beo_Shipment
		lnva_Shipment[i].of_SetSource ( THIS.of_GetShipmentCache () ) 
		lnva_Shipment[i].of_SetSourceID ( ala_shipmentids[i] )
		lnva_Shipment[i].of_SetEventSource ( THIS.of_GetEventcache( ) )
		lnva_Shipment[i].of_SetItemSource ( THIS.of_GetItemCache ( ) )
		lnva_Shipment[i].of_SetContext( THIS )
	
	NEXT
	anva_shipments[] = lnva_Shipment
ELSE
	ll_Return = -1
END IF

RETURN ll_Return
end function

public function boolean of_verifybobtail (ref n_cst_beo_event anv_event);/*
	Created by Dan 1-22-06
	
	This functions purpose is to return true or false under these circumstances:
	
	TRUE:  The system setting to add autoadd a bobtail is set to true AND
			 The event confirmed is a hook after a drop, at a different location
			 then the drop.

*/

Boolean lb_return 
Long		lla_ids[]
n_cst_beo_Event	lnv_Event

lnv_event = anv_event

IF isValid( lnv_event ) THEN
	this.of_newevents( {"B"}, lla_ids)
END IF

RETURN lb_return
end function

public function integer of_autoaddbobtail (n_cst_beo_event anv_event);/*
	Created By Dan 1-23-07
	
	This function looks for drops followed by hooks on the driver and tractor itinerary, where
	the locations are different.  IF they are, and the hook is confirmed, then it
	automatically puts in a bobtail event between the two.
	
	Returns the value of a appeon_constant.of_route or 0 if there was no bobtail or -1

	if there was an error
*/

int			li_return 
long 			lla_ids[]
Long			ll_eventId
Long			ll_drid
Long			ll_eqId


int			li_insertionstyle = 2
Date			ld_dateArrived

n_cst_beo_event	lnv_event

IF isValid( anv_event ) THEN
	lnv_event = anv_event
ELSE
	li_Return = -1
END IF
	
IF li_Return > -1 THEN
	//Get the equipment id and and driver id off the event
	ll_drId = lnv_event.of_getdriverid( )
	ll_eqId = lnv_event.of_gettractorid( )
	ll_eventId = lnv_event.of_getId( )
	ld_dateArrived = lnv_event.of_getDatearrived( )
	
	//if we are successful at doing it with one then we don't have to look at the other
	li_Return = this.of_autoaddbobtail( gc_dispatch.ci_itintype_powerunit, ll_eqId, ld_dateArrived, ll_eventId) 
	IF li_return <> 1 THEN
		li_Return = this.of_autoAddBobtail( gc_dispatch.ci_itintype_driver, ll_drId, ld_datearrived, ll_eventId)
	END IF
END IF

RETURN li_return
end function

public function integer of_autoaddbobtail (integer ai_itintype, long al_id, date ad_date, long al_eventid);/*
	Created By Dan 1-27-07
	
	RETURNS 1 if it inserted a bobtail event and routed it successfully
			  0 didn't insert
			  -1 error
*/

Datastore	lds_itin	

Boolean	lb_checkBefore
Boolean	lb_checkAfter
Boolean	lb_insertBobtail

int		li_Return 
int		li_InsertionStyle

Long		ll_max
Long		ll_row
Long		ll_row2
Long		ll_dropRow
Long		ll_hookRow

Long		ll_insertionEvent
Long		lla_newIds[]

String	ls_hookSite
string	ls_dropSite
String	ls_findString
String	ls_filter
String	ls_sort
String	ls_eventType
String	ls_eventType2
String	ls_hookConfirmed
String	ls_dropconfirmed
Long		ll_Hooksite
Long		ll_dropsite

Time		lt_arrived, lt_departed
Date		ld_insertionDate, ld_max, ld_min
Datastore lds_work
n_cst_beo_event	lnva_event[]

Constant	string	cs_drop = gc_dispatch.cs_EventType_Drop
Constant	string	cs_hook = gc_dispatch.cs_EventType_Hook
	
IF RELATIVEDATE( ad_date, 1 ) <= today() THEN
	ld_max = RELATIVEDATE( ad_date, 1 )
ELSE
	ld_max = ad_date
END IF

ld_min = RELATIVEDATE( ad_date, -1 )

IF this.of_retrieveitinerary( ai_itinType, al_id, ld_min, ld_max, true /*needs prior*/) = 1 THEN
ELSE
	li_return = -1
END IF

IF li_return > -1 THEN
	lds_itin = this.of_getEventcache( )
	ll_max = lds_itin.rowcount( )
	ls_sort = lds_itin.describe( "datawindow.table.sort" )
	
	lds_work = create datastore
	lds_work.dataobject = lds_itin.dataobject
	lds_work.setTransobject( SQLCA )
	//lds_work.setSort( ls_sort )
	lds_work.setSort( this.of_getitinerarysort( ai_itinType, al_id) )  //changed on 2-27-07.
	lds_itin.rowscopy( 1, lds_itin.filteredCount(), FILTER!, lds_work, 9999, PRIMARY!)
	lds_itin.rowscopy( 1, ll_max, PRIMARY!, lds_work, 9999, PRIMARY! )
	lds_work.sort()
	ll_max = lds_work.rowcount( )
	
	ls_findString = "de_Id = " +String( al_eventid )
END IF

IF li_Return > -1 THEN
	//find the current event in the cache and figure out whether or not we want to look
	//at the next row, or the row before, for our comparison.
	ll_row = lds_work.find( ls_findString, 1, ll_max )
	
	IF ll_Row > 0 THEN
		ls_eventType = lds_work.getItemString( ll_row, "de_event_type")
		
		CHOOSE CASE ls_eventType 
			CASE cs_hook 		
				lb_checkBefore = true
				ll_hookRow = ll_row
			CASE cs_drop 		 
				lb_checkAfter = true
				ll_dropRow = ll_row
		END CHOOSE
	END IF
END IF

IF lb_checkBefore THEN
	//We want to see if the event before was a drop and if the location is diferent then the location of this event
	ll_row2 = ll_row - 1
	IF ll_row2 > 0 THEN
		ls_eventType2 = lds_work.getItemString( ll_row2, "de_event_type")
		IF ls_eventType2 = cs_drop THEN
			ll_dropRow = ll_row2
		END IF
	END IF
END IF

IF lb_checkAfter THEN
	//we want to see if the event after was a hook and if the location is different then this location
	ll_row2 = ll_row + 1
	IF ll_row2 <= ll_max THEN
		ls_eventType2 = lds_work.getItemString( ll_row2, "de_event_type")
		IF ls_eventType2 = cs_hook THEN
			ll_hookRow = ll_row2
		END IF
	END IF
END IF

IF ll_dropRow > 0 AND ll_hookRow > 0 THEN
	//we want to compare the locations of the two rows, if they are different we want to insert
	//a bobtail event.
	ls_hookSite = lds_work.getITemString( ll_hookRow, "co_name" )
	ls_dropSite = lds_work.getITemString( ll_dropRow, "co_name" )
	ll_hooksite = lds_work.getItemNumber( ll_hookrow, "de_site" )
	ll_dropSite = lds_work.getItemNumber( ll_droprow, "de_site" )
	ls_hookConfirmed = lds_work.getITemString( ll_hookRow, "de_conf")
	ls_dropconfirmed = lds_work.getITemString( ll_dropRow, "de_conf")
	lt_arrived = lds_work.getItemTime( ll_hookRow, "comp_arr" )
	lt_departed = lds_work.getItemTime( ll_hookRow, "comp_dep" )
	
	//I do not insert a bobtail if one of the values is null.
	IF ll_hookSite <> ll_dropSite AND ls_hookConfirmed = "T" AND ls_dropconfirmed = "T" THEN
		lb_insertBobtail = True
	END IF
END IF

IF lb_insertBobTail THEN
	//this creates the new event.
	this.of_newevents( {gc_dispatch.cs_EventType_Bobtail}, lla_newids)
	li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_Before
	ll_InsertionEvent = lds_work.Object.de_Id [ ll_hookRow ]			//the event i want to insert it before
	ld_insertionDate = lds_work.Object.de_arrdate [ ll_hookRow ]
	
	li_return = this.of_Route ( lla_newids, ai_itinType, al_id, ld_insertiondate, 0, ll_InsertionEvent, li_InsertionStyle )
	
	
	IF li_return = 1 THEN
		this.of_getEventList( lla_newIds, lnva_event , true )
		IF UpperBound( lla_newIds ) > 0 THEN
			lnva_event[1].of_setAllowfilterset( true )
			lnva_event[1].of_setSite( ll_hookSite )
			lnva_event[1].of_settimearrived( lt_arrived )
			lnva_event[1].of_setTimedeparted( lt_departed )
			lnva_event[1].of_setconfirmed( "T" )

			destroy lnva_event[1]
		END IF
		
	END IF
END IF

Destroy lds_work

RETURN li_return
end function

public function n_cst_ediexportshipmentmanager of_getexportshipmentmanager ();/*
	DEK: 3-23-07, This returns the exported shipment manager
*/
IF not isvalid( inv_exportShipmentManager ) THEN
	inv_exportShipmentManager = create n_cst_ediexportshipmentmanager 
END IF

RETURN inv_exportshipmentmanager
end function

public function integer of_newevents (string asa_types[], long ala_sites[], ref long ala_ids[]);//Add events to the filter buffer in the cache (and to the database), with the requested
//event types.  The ids of the newly created events will be passed out in ala_Ids.

//Returns : 1, -1

DataStore	lds_Events, &
				lds_NewEvents 
Long		ll_Count, &
			ll_Index, &
			ll_Id, &
			lla_Ids[], &
			ll_Row, &
			ll_FilteredCount, &
			ll_SiteCount
DWObject	ldwo_Id

Integer	li_Return = 1
Boolean	lb_Finished = FALSE

String	ls_CoName

n_cst_Beo_Event	lnv_Event

//Clear the reference array.
ala_Ids = lla_Ids

IF lb_Finished = FALSE THEN

	lds_Events = This.of_GetEventCache ( )

	IF NOT IsValid ( lds_Events ) THEN
		li_Return = -1
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	lds_NewEvents = CREATE DataStore
	lds_NewEvents.DataObject = lds_Events.DataObject  //Use the same dataobject as the cache.
	lds_NewEvents.SetTransObject ( SQLCA )

	//Flag the id column as updateable.  It isn't normally in this dataobject.
	lds_NewEvents.Modify ( "de_id.Update = Yes" )

	ldwo_Id = lds_NewEvents.Object.de_Id
	
	lnv_Event = Create n_cst_Beo_Event
	lnv_Event.of_SetSource(lds_NewEvents)

END IF


//IF lb_Finished = FALSE THEN
//
//	SELECT Max ( de_id ) INTO :ll_Id FROM disp_events ;
//
//	IF SQLCA.SqlCode <> 0 THEN
//		li_Return = -1
//		lb_Finished = TRUE
//	END If
//
//END IF

IF lb_Finished = FALSE THEN

	IF IsNull ( ll_Id ) OR ll_Id < 0 THEN
		ll_Id = 0
	END IF

	ll_Count = UpperBound ( asa_Types )
	ll_SiteCount = UpperBound(ala_Sites)

	FOR ll_Index = 1 TO ll_Count

		ll_Row = lds_NewEvents.InsertRow ( 0 )

		IF ll_Row > 0 THEN
			
			gnv_App.of_getnextid( "n_cst_beo_event", ll_Id , TRUE )

			ldwo_Id.Primary [ ll_Row ] = ll_Id

			lnv_Event.of_SetSourceId(ll_id)
			
			IF lnv_Event.of_HasSource ( ) THEN
			
				lnv_Event.of_SetType(asa_Types[ll_Index])
				
				IF ll_SiteCount = ll_Count THEN
					lnv_Event.of_SetSite(ala_Sites[ll_Index])
				END IF
				
				lla_Ids [ ll_Index ] = ll_Id
			ELSE
				li_Return = -1
				lb_Finished = TRUE
			END IF
		ELSE
			//COMMIT ;  //Commit the transaction opened with SELECT MAX above.
			li_Return = -1
			lb_Finished = TRUE
		END IF

	NEXT

END IF

IF lb_Finished = FALSE THEN

	IF lds_NewEvents.Update ( ) = 1 THEN
		COMMIT ;
	ELSE
		ROLLBACK ;
		li_Return = -1
		lb_Finished = TRUE
	END IF

END IF

IF lb_Finished = FALSE THEN

	ll_FilteredCount = lds_Events.FilteredCount ( )

	//These rows will not get PBRowIds in the target because they haven't gone through primary.
	lds_NewEvents.RowsMove ( 1, ll_Count, Primary!, lds_Events, ll_FilteredCount + 1, Filter! )

	FOR ll_Index = 1 TO ll_Count

		ll_Row = ll_FilteredCount + ll_Index
		lds_Events.SetItemStatus ( ll_Row, 0, Filter!, DataModified! )
		lds_Events.SetItemStatus ( ll_Row, 0, Filter!, NotModified! )

	NEXT

END IF

IF li_Return = 1 THEN
	ala_Ids = lla_Ids
END IF

DESTROY lds_NewEvents
Destroy(lnv_Event)

RETURN li_Return
end function

on n_cst_bso_dispatch.create
call super::create
end on

on n_cst_bso_dispatch.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

long	ll_ret
ll_ret=1
n_cst_CacheManager	lnv_CacheManager
lnv_CacheManager = CREATE n_cst_CacheManager
lnv_CacheManager.of_SetAutoCache ( TRUE )
This.SetCacheManager ( lnv_CacheManager )

end event

event destructor;call super::destructor;This.of_ClearReferenceLists ( )

DESTROY ids_EquipmentCache
DESTROY ids_EventCache
DESTROY ids_ItemCache
DESTROY ids_ShipmentCache
DESTROY ids_ItineraryList
if isvalid(inv_edimanager) then
	destroy inv_edimanager
end if

DESTROY ( inv_Equipmentposting )
DESTROY ( inv_Validation )
DESTROY ( inv_Documentmanager )
// RDT 5-06-03 added destroy code
If isValid(inv_NoteManager) then
	Destroy inv_NoteManager
End If

If isValid(inv_alertmanager ) then
	Destroy inv_alertmanager
End If
end event

event pt_updatespending;call super::pt_updatespending;//Extending Ancestor Script in order to check for updates pending on custom cache objects.
// RDT 5-28-03 check for pending updates on notification manager

Integer	li_Return

li_Return = AncestorReturnValue


//Reset the modification status of the unmodifiable columns on special caches.
//(We have to do this every time, because if the save goes through, these columns
//have to be flagged as not modified.)

This.Event ue_ResetUnmodifiables ( )


//If no pending updates were identified so far, check shipments.

IF li_Return = 0 THEN

	IF IsValid ( ids_ShipmentCache ) THEN  

		//Using of_GetShipmentCache could instantiate it unecessarily.

		IF ids_ShipmentCache.of_UpdatesPending ( ) = 1 THEN

			li_Return = 1

		END IF

	END IF

END IF


//If no pending updates were identified so far, check items.

IF li_Return = 0 THEN

	IF IsValid ( ids_ItemCache ) THEN  

		//Using of_GetItemCache could instantiate it unecessarily.

		IF ids_ItemCache.of_UpdatesPending ( ) = 1 THEN

			li_Return = 1

		END IF

	END IF

END IF


//If no pending updates were identified so far, check events.

IF li_Return = 0 THEN

	IF IsValid ( ids_EventCache ) THEN  

		//Using of_GetEventCache could instantiate it unecessarily.

		IF ids_EventCache.of_UpdatesPending ( ) = 1 THEN

			li_Return = 1

		END IF

	END IF

END IF


//If no pending updates were identified so far, check Equipment.

IF li_Return = 0 THEN

	IF IsValid ( ids_EquipmentCache ) THEN  

		//Using of_GetEquipmentCache could instantiate it unecessarily.

		IF ids_EquipmentCache.of_UpdatesPending ( ) = 1 THEN

			li_Return = 1

		END IF

	END IF

END IF

//If no pending updates were identified so far, check edi events
if li_Return = 0 then
	if isvalid ( inv_EdiManager ) then
		if inv_EdiManager.of_updatespending() = 1 then
			li_return = 1
		end if
	end if
end if

// RDT 5-28-03 - Start
IF li_Return = 0 then
	If IsValid ( inv_NoteManager ) Then 
		if inv_NoteManager.of_UpdatesPending( ) = 1 then
			li_Return = 1
		end if 
	End If
END IF
// RDT 5-28-03 - End 

//DEK 3-23-07
iF li_return = 0 THEN
	if isvalid( inv_exportshipmentmanager ) THEN
		IF inv_exportshipmentmanager.of_updatespending( ) = 1 THEN
			li_return = 1
		END IF
	END IF
END IF
//END

RETURN li_Return
end event

event pt_save;// RDT 5-06-03 Centralized Email Processing commented section

//Returns : 1, -1


long markloop, numteq, curmax, teqids[], peqids[], equip_rows, foundrow, rowloop, &
	bufrows[2], rows_moved
integer result
boolean	lb_TripSaveFailed = FALSE, &
			lb_HasEDI214License, &
			lb_HasEDI322License   //CHANGED FOR EDI 322  (Added this variable)

n_cst_LicenseManager	lnv_LicenseManager
n_cst_ShipmentManager lnv_ShipmentMgr
n_cst_EquipmentManager lnv_EquipmentMgr
n_cst_msg					lnv_msg

String	lsa_di_items[]
String	lsa_di_itemsFSC[]
Long i
Long	ll_max

n_ds	lds_Equip, &
				lds_Events, &
				lds_Items, &
				lds_Ships

String	ls_OriginalDBParm

lds_Equip = This.of_GetEquipmentCache ( )
lds_Events = This.of_GetEventCache ( )
lds_Items = This.of_GetItemCache ( )
lds_Ships = This.of_GetShipmentCache ( )
Integer	li_Return = 1

IF lnv_LicenseManager.of_HasEDI214License() THEN
	lb_HasEDI214License = TRUE
ELSE
	lb_HasEDI214License = FALSE
END IF

THIS.Event ue_PreSave () 


//CHANGED FOR EDI 322  (Added)

IF lnv_LicenseManager.of_HasEDI322License() THEN
	lb_HasEDI322License = TRUE
ELSE
	lb_HasEDI322License = FALSE
END IF

//END Change for edi 322


//We should Set Mod Logs for shipments even if only their items or events have been modified.
//This will only set Mod Logs for shipments where disp_ship has been modified directly.

//This part increments intsigs in lds_Ships
rows_moved = 0
bufrows[1] = lds_Ships.rowcount()
bufrows[2] = lds_Ships.filteredcount()
for rowloop = bufrows[2] to 1 step -1
	if lds_Ships.getitemstatus(rowloop, 0, filter!) = datamodified! then
		rows_moved ++
		lds_Ships.rowsmove(rowloop, rowloop, filter!, lds_Ships, &
			bufrows[1] + rows_moved, primary!)
	end if
next
for rowloop = 1 to bufrows[1] + rows_moved
	if lds_Ships.getitemstatus(rowloop, 0, primary!) = datamodified! then &
		lds_Ships.object.ds_intsig[rowloop] = lds_Ships.object.ds_intsig[rowloop] + 1
next
This.Event ue_SetModLogs ( ) //has to be here, while all modified rows are in primary buffer
if rows_moved > 0 then lds_Ships.rowsmove(bufrows[1] + 1, bufrows[1] + rows_moved, &
	primary!, lds_Ships, bufrows[2], filter!)

//This part increments intsigs in lds_Events
rows_moved = 0
bufrows[1] = lds_Events.rowcount()
bufrows[2] = lds_Events.filteredcount()
for rowloop = bufrows[2] to 1 step -1
	if lds_Events.getitemstatus(rowloop, 0, filter!) = datamodified! then
		rows_moved ++
		lds_Events.rowsmove(rowloop, rowloop, filter!, lds_Events, &
			bufrows[1] + rows_moved, primary!)
	end if
next
for rowloop = 1 to bufrows[1] + rows_moved
	if lds_Events.getitemstatus(rowloop, 0, primary!) = datamodified! then &
		lds_Events.object.de_intsig[rowloop] = lds_Events.object.de_intsig[rowloop] + 1
next
if rows_moved > 0 then lds_Events.rowsmove(bufrows[1] + 1, bufrows[1] + rows_moved, &
	primary!, lds_Events, bufrows[2], filter!)


//CHANGED FOR EDI 322

//Prep the edi cache with final times, etc.
if lb_HasEDI214License or lb_HasEDI322License then
	this.of_createmessage()	
end if

//End change for EDI 322


This.Event ue_AdjustCurrentEvents ( )


//Added 3.5.0  -- Previously, we were relying on this getting called by pt_UpdatesPending
//prior to the save, but with things calling pt_Save directly now, we need to have this
//in here, regardless of the extra overhead.
This.Event ue_ResetUnmodifiables ( )


equip_rows = lds_Equip.rowcount()
foundrow = 0

if equip_rows > 0 then
	do
		foundrow = lds_Equip.find("eq_id < 1000", foundrow + 1, equip_rows)
		if foundrow > 0 then
			numteq ++
			teqids[numteq] = lds_Equip.object.eq_id[foundrow]
		end if
	loop while foundrow > 0 and foundrow < equip_rows
	if numteq > 0 then
		
		//select max(eq_id) into :curmax from equipment ;
		//if sqlca.sqlcode <> 0 then goto rollitback		
		//if curmax < 10000000 or isnull(curmax) then curmax = 10000000
		for markloop = 1 to numteq //This is separate so arrays will be balanced if rollback
			gnv_App.of_Getnextid( "equipment", curmax ,true )
			peqids[markloop] = curmax 
		next
		This.Event ue_ReplaceTemporaryEquipIds(teqids, peqids) 
	end if
end if

if lds_Equip.update(false, false) <> 1 then goto rollitback

lds_Equip.modify("eq_id.update = no")
lds_Equip.modify("eq_type.update = no")
lds_Equip.modify("eq_ref.update = no")
lds_Equip.modify("eq_outside.update = no")
lds_Equip.modify("eq_status.update = no")
lds_Equip.modify("eq_length.update = no")
lds_Equip.modify("eq_height.update = no")
lds_Equip.modify("eq_axles.update = no")
lds_Equip.modify("eq_air.update = no")
lds_Equip.modify("eq_spec1.update = no")
lds_Equip.modify("eq_spec2.update = no")
lds_Equip.modify("eq_spec3.update = no")
lds_Equip.modify("eq_spec4.update = no")
lds_Equip.modify("eq_spec5.update = no")
lds_Equip.modify("eq_cur_event.update = no")
lds_Equip.modify("eq_next_event.update = no")
lds_Equip.modify("eq_id.key = no")
lds_Equip.modify("datawindow.table.updatetable = 'outside_equip'")
lds_Equip.modify("oe_id.update = yes")
lds_Equip.modify("oe_from.update = yes")
lds_Equip.modify("oe_for.update = yes")
lds_Equip.modify("oe_booknum.update = yes")
lds_Equip.modify("oe_out.update = yes")
lds_Equip.modify("oe_in.update = yes")
lds_Equip.modify("oe_orig_event.update = yes")
lds_Equip.modify("oe_term_event.update = yes")
lds_Equip.modify("equipmentlease_fkequipmentleasetype.update = yes")
//New columns in 3.5.0
lds_Equip.modify("equipmentlease_user1.update = yes")
lds_Equip.modify("equipmentlease_user2.update = yes")
lds_Equip.modify("equipmentlease_notes.update = yes")
lds_Equip.modify("equipmentlease_shipment.update = yes")
lds_Equip.modify("equipmentlease_originationsite.update = yes")
lds_Equip.modify("equipmentlease_originationdate.update = yes")
lds_Equip.modify("equipmentlease_originationtime.update = yes")
lds_Equip.modify("equipmentlease_terminationsite.update = yes")
lds_Equip.modify("equipmentlease_terminationdate.update = yes")
lds_Equip.modify("equipmentlease_terminationtime.update = yes")
// new columns in 3.5.17
lds_Equip.modify("reloadshipment.update = yes")
lds_Equip.modify("reloaddate.update = yes")
lds_Equip.modify("reloadtime.update = yes")
lds_Equip.modify("reloadfreetimeexpiredate.update = yes")
lds_Equip.modify("reloadfreetimeexpiretime.update = yes")
lds_Equip.modify("notifydate.update = yes")
lds_Equip.modify("notifytime.update = yes")
lds_Equip.modify("amountbilled.update = yes")
lds_Equip.modify("invoicenumber.update = yes" )
lds_Equip.modify("leasefreetimeexpiredate.update = yes" )
lds_Equip.modify("leasefreetimeexpiretime.update = yes" )
lds_Equip.modify("releasedate.update = yes" )
lds_Equip.modify("releasetime.update = yes" )
lds_Equip.modify("equipment_notes.update = no")
lds_Equip.modify("freetimestart.update = no")

lds_Equip.modify("equipment_isocode.update = no" )
//
//lds_Equip.modify("equipmentleasetype_line.update = no")
//lds_Equip.modify("equipmentleasetype_type.update = no")
//



//End of new columns.
lds_Equip.modify("oe_id.key = yes")

result = lds_Equip.update(false, false)

lds_Equip.modify("oe_id.update = no")
lds_Equip.modify("oe_from.update = no")
lds_Equip.modify("oe_for.update = no")
lds_Equip.modify("oe_booknum.update = no")
lds_Equip.modify("oe_out.update = no")
lds_Equip.modify("oe_in.update = no")
lds_Equip.modify("oe_orig_event.update = no")
lds_Equip.modify("oe_term_event.update = no")
lds_Equip.modify("equipmentlease_fkequipmentleasetype.update = no")
//New columns in 3.5.0
lds_Equip.modify("equipmentlease_user1.update = no")
lds_Equip.modify("equipmentlease_user2.update = no")
lds_Equip.modify("equipmentlease_notes.update = no")
lds_Equip.modify("equipmentlease_shipment.update = no")
lds_Equip.modify("equipmentlease_originationsite.update = no")
lds_Equip.modify("equipmentlease_originationdate.update = no")
lds_Equip.modify("equipmentlease_originationtime.update = no")
lds_Equip.modify("equipmentlease_terminationsite.update = no")
lds_Equip.modify("equipmentlease_terminationdate.update = no")
lds_Equip.modify("equipmentlease_terminationtime.update = no")
// new in 3.5.17
lds_Equip.modify("reloadshipment.update = no")
lds_Equip.modify("reloaddate.update = no")
lds_Equip.modify("reloadtime.update = no")
lds_Equip.modify("reloadfreetimeexpiredate.update = no")
lds_Equip.modify("reloadfreetimeexpiretime.update = no")
lds_Equip.modify("notifydate.update = no")
lds_Equip.modify("notifytime.update = no")
lds_Equip.modify("amountbilled.update = no")
lds_Equip.modify("invoicenumber.update = no" )
lds_Equip.modify("leasefreetimeexpiredate.update = no" )
lds_Equip.modify("leasefreetimeexpiretime.update = no" )
lds_Equip.modify("releasedate.update = no" )
lds_Equip.modify("releasetime.update = no" )
lds_Equip.modify("equipment_notes.update = yes")

lds_Equip.modify("equipment_isocode.update = yes" )
//lds_Equip.modify("equipmentleasetype_line.update = no")
//lds_Equip.modify("equipmentleasetype_type.update = no")
//
//End of new columns.
lds_Equip.modify("oe_id.key = no")
lds_Equip.modify("datawindow.table.updatetable = 'equipment'")
lds_Equip.modify("eq_id.update = yes")
lds_Equip.modify("eq_type.update = yes")
lds_Equip.modify("eq_ref.update = yes")
lds_Equip.modify("eq_outside.update = yes")
lds_Equip.modify("eq_status.update = yes")
lds_Equip.modify("eq_length.update = yes")
lds_Equip.modify("eq_height.update = yes")
lds_Equip.modify("eq_axles.update = yes")
lds_Equip.modify("eq_air.update = yes")
lds_Equip.modify("eq_spec1.update = yes")
lds_Equip.modify("eq_spec2.update = yes")
lds_Equip.modify("eq_spec3.update = yes")
lds_Equip.modify("eq_spec4.update = yes")
lds_Equip.modify("eq_spec5.update = yes")
lds_Equip.modify("eq_cur_event.update = yes")
lds_Equip.modify("eq_next_event.update = yes")
lds_Equip.modify("eq_id.key = yes")

if result <> 1 then goto rollitback


//CHANGED FOR EDI 322

IF lb_HasEDI214License THEN
	if isvalid(inv_edimanager) then
		if inv_EDIManager.of_SavePendingcache( ) <> 1 then goto rollitback
	end if
END IF

IF lb_HasEDI322License THEN
	if isvalid(inv_edimanager) then
		if inv_EDIManager.of_Saveeventcache( ) <> 1 then goto rollitback
	end if
END IF


IF lb_HasEDI322License THEN
	if isvalid(inv_322manager ) then
		if inv_322manager.of_hadupdatespending( )THEN
			
			IF inv_322manager.of_savecache( ) <> 1 THEN
				goto RollitBack
			END IF 
			
		END IF
	end if
END IF

//End change for EDI 322

//Turn off binding here for cases where it cannot handle the percision...
ls_OriginalDBParm = SQLCA.DBParm
SQLCA.DBparm = 'DISABLEBIND=1'

if lds_Events.update() <> 1 then goto rollitback

//MFS 5/22/07 - Switch binding back on (zero is the default)
SQLCA.DBparm = 'DISABLEBIND=0' //We must explicitly set it back to 0 here

SQLCA.DBparm = ls_OriginalDBParm


Int li_testres
li_testRes = lds_Items.update(false, false)
//modified by dan to handle multitable update

if  li_testRes <> 1 then goto rollitback

//switch updatable columbs
lds_Items.modify("di_item_id.update = no")
lds_Items.modify("di_shipment_id.update = no")
lds_Items.modify("di_item_type.update = no")
lds_Items.modify("di_qty.update = no")
lds_Items.modify("di_description.update = no")
lds_Items.modify("di_weightperunit.update = no")
lds_Items.modify("di_totitemweight.update = no")
lds_Items.modify("di_our_ratetype.update = no")
lds_Items.modify("di_our_rate.update = no")
lds_Items.modify("di_our_itemamt.update = no")
lds_Items.modify("di_pay_ratetype.update = no")
lds_Items.modify("di_pay_rate.update = no")					
lds_Items.modify("di_pay_itemamt.update = no")
lds_Items.modify("di_miles.update = no")
lds_Items.modify("di_blnum.update = no")					
lds_Items.modify("di_hazmat.update = no")
lds_Items.modify("di_pu_event.update = no")
lds_Items.modify("di_del_event.update = no")
lds_Items.modify("amounttype.update = no")
lds_Items.modify("ratecodename.update = no")
lds_Items.modify("lastratedby.update = no")			
lds_Items.modify("taglist.update = no")
lds_Items.modify("eventflag.update = no")
lds_Items.modify("note.update = no")
lds_Items.modify("accountingtype.update = no")
lds_Items.modify("di_item_id.key = no")				//turn off key column

lds_Items.modify("datawindow.table.updatetable = 'disp_itemlinkfscrate'")
lds_Items.modify("disp_itemlinkfscrate_di_itemfsc_id.key = yes")		//turn on other key column
lds_Items.modify("disp_itemlinkfscrate_rate.update = yes")
lds_Items.modify("disp_itemlinkfscrate_di_itemfsc_id.update = yes")
lds_Items.modify("disp_itemlinkfscrate_type.update = yes")

//discard rows in the delete buffer before the second update call to avoid database error
//all the rows that needed to be deleted in the delete buffer should already be deleted by
// the first half of the update.
lds_Items.rowsdiscard( 1, lds_items.deletedcount(), delete!)
//MessageBox( "pt save dispt", "mod: "+string(lds_items.modifiedCount())+ " rows: "+string(lds_items.rowCount()))

//the following loop was added because on the second half of the update there would be nulls
//in the fscRate for non fuel surcharge items.  Nulls cannot exist in the database for that
//table, so we must set null rows to notmodified.
ll_max = lds_items.rowCount()
FOR i = 1 To ll_max
	IF isNULL(lds_items.getItemNumber( i, "disp_itemlinkfscrate_di_itemfsc_id")) THEN
		//MessageBox("ptsave", "null")
		lds_items.setitemstatus( i, 0, primary!, dataModified!	)		//changes newmodified to new
		lds_items.setitemstatus( i, 0, primary!, NotModified!	)
	ELSE
		
		// get the original value and see if we need to force it to do an insert
		IF IsNull (lds_Items.GetItemnumber( i, "disp_itemlinkfscrate_di_itemfsc_id", PRIMARY!, TRUE ) ) THEN
			lds_items.setitemstatus( i, 0, primary!, NewModified!	)			
		END IF
		
	END IF
NEXT

// now for the filter row
ll_max = lds_items.FilteredCount ( )
FOR i = 1 To ll_max
	IF isNULL(lds_items.getItemNumber( i, "disp_itemlinkfscrate_di_itemfsc_id", FILTER! , FALSE  )) THEN
		lds_items.setitemstatus( i, 0, FILTER!, dataModified!	)		//changes newmodified to new
		lds_items.setitemstatus( i, 0, FILTER!, NotModified!	)
	ELSE
		
		// get the original value and see if we need to force it to do an insert
		IF IsNull (lds_Items.GetItemnumber( i, "disp_itemlinkfscrate_di_itemfsc_id", FILTER!, TRUE ) ) THEN
			lds_items.setitemstatus( i, 0, FILTER!, NewModified!	)			
		END IF
		
	END IF
NEXT

result = lds_Items.update( false, true )
lds_Items.modify("disp_itemlinkfscrate_di_itemfsc_id.key = no")		//turn off new key column
lds_Items.modify("di_item_id.key = yes")		//turn other one back on

//swap the updatable columbs back
lds_Items.modify("di_item_id.update = yes")
lds_Items.modify("di_shipment_id.update = yes")
lds_Items.modify("di_item_type.update = yes")
lds_Items.modify("di_qty.update = yes")
lds_Items.modify("di_description.update = yes")
lds_Items.modify("di_weightperunit.update = yes")
lds_Items.modify("di_totitemweight.update = yes")
lds_Items.modify("di_our_ratetype.update = yes")
lds_Items.modify("di_our_rate.update = yes")
lds_Items.modify("di_our_itemamt.update = yes")
lds_Items.modify("di_pay_ratetype.update = yes")
lds_Items.modify("di_pay_rate.update = yes")
lds_Items.modify("di_pay_itemamt.update = yes")
lds_Items.modify("di_miles.update = yes")
lds_Items.modify("di_blnum.update = yes")
lds_Items.modify("di_hazmat.update = yes")

lds_Items.modify("di_pu_event.update = yes")
lds_Items.modify("di_del_event.update = yes")
lds_Items.modify("amounttype.update = yes")
lds_Items.modify("ratecodename.update = yes")
lds_Items.modify("lastratedby.update = yes")
lds_Items.modify("taglist.update = yes")
lds_Items.modify("eventflag.update = yes")
lds_Items.modify("note.update = yes")
lds_Items.modify("accountingtype.update = yes")

lds_Items.modify("datawindow.table.updatetable = 'disp_items'")
lds_Items.modify("disp_itemlinkfscrate_rate.update = no")
lds_Items.modify("disp_itemlinkfscrate_di_itemfsc_id.update = no")
lds_Items.modify("disp_itemlinkfscrate_type.update = no")

if result <> 1 then goto rollitback

//-----------------------------------------------------------

if lds_Ships.update() <> 1 then goto rollitback
//last to avoid cascade-deleting events or items which lds_Events or lds_Items then also
//tries to delete.

commit ;
if sqlca.sqlcode <> 0 then goto rollitback


IF lnv_licenseManager.of_HasNotificationLicense ( ) THEN
	//	THIS.of_SendPendingMessages ( ) 					// RDT 5-06-03 
	This.of_GetNotificationManager().of_UpdateNotificationTable ( ) 	// RDT 5-06-03 
END IF


//CHANGED FOR EDI 322

if isvalid(inv_edimanager) then

	if inv_EDIManager.of_produce214file () then  //Do we produce the 214/322 file on each save, or not?
																//Note:  This setting/function now indicates for BOTH 214 & 322

		IF lb_HasEDI214License THEN
			lnv_msg.of_Reset ( )
			long	lla_id[]
			
			inv_EDIManager.of_Generate ( appeon_constant.cl_transaction_set_214, lla_id )

			inv_EDIManager.of_resetPendingcache()
			
		END IF

		IF lb_HasEDI322License THEN
			lnv_msg.of_Reset ( )
			inv_EDIManager.of_CreateTransactionSet ( appeon_constant.cl_transaction_set_322, lnv_msg )

			inv_EDIManager.of_resetcache()
			
		END IF

	end if

end if

//END OF CHANGE FOR EDI 322

///// EQUIPMENT POSTING
IF isValid ( inv_Equipmentposting ) THEN
	inv_Equipmentposting.of_Update( )
END IF

//Document Manager
IF isValid ( inv_Documentmanager ) THEN
	inv_Documentmanager.event pt_save( )
END IF


//Update Any Changes made to Trip Info
//**NOTE** This is being done as a separate transaction

CHOOSE CASE SUPER::Event pt_Save ( )

CASE 1  //Success
	//No processing needed

CASE -1  //Failure
	lb_TripSaveFailed = TRUE

CASE ELSE  //Unexpected result
	lb_TripSaveFailed = TRUE

END CHOOSE


//Notify user on failure

IF lb_TripSaveFailed THEN

	MessageBox ( "Save Changes", "Your changes to Trip Details could not be saved.  "+&
		"The rest of your changes were saved successfully." )
	li_Return = -1

END IF
//DEK 3-23-07
IF isValid( inv_exportshipmentmanager ) THEN
	inv_exportshipmentmanager.of_update()
END IF
////////////////
lnv_EquipmentMgr.of_Sync ( lds_Equip, TRUE, TRUE )

lds_Equip.resetupdate()
lds_Events.resetupdate()
lds_Items.resetupdate()
lds_Ships.resetupdate()
//lds_Equip.reset()


//Added this refresh here in 3.6.b2.  Formerly, it was in w_Dispatch.Save()
//Note that this does not refresh the trip cache.  That refresh has to be done by the user if they want it.

IF lnv_ShipmentMgr.of_Get_Retrieved_Ships( ) = TRUE THEN
	lnv_ShipmentMgr.of_RefreshShipments ( FALSE /*Refresh Shipments Only, not Trips*/ )
END IF


RETURN li_Return


rollitback:

li_Return = -1

rollback ;

if numteq > 0 then
	This.Event ue_ReplaceTemporaryEquipIds(peqids, teqids) //This searches for the new ids that were generated
		// and replaces them with the corresponding temporary ones.
	for rowloop = lds_Equip.rowcount() to 1 step -1
		if lds_Equip.object.eq_id[rowloop] >= 1000 then
			lds_Equip.rowsdiscard(rowloop, rowloop, primary!)
		else
			lds_Equip.object.eq_cur_event[rowloop] = null_long
			lds_Equip.object.curev_type[rowloop] = null_str
			lds_Equip.object.curev_site[rowloop] = null_long
			lds_Equip.object.curev_arrdate[rowloop] = null_date
			lds_Equip.object.curev_arrtime[rowloop] = null_time
			lds_Equip.object.curev_deptime[rowloop] = null_time
			lds_Equip.object.curev_shipment_id[rowloop] = null_long
			lds_Equip.object.curev_conf[rowloop] = null_str
			lds_Equip.object.curevco_name[rowloop] = null_str
			lds_Equip.object.curevco_city[rowloop] = null_str
			lds_Equip.object.curevco_state[rowloop] = null_str
			lds_Equip.object.curevco_tz[rowloop] = null_int
			lds_Equip.object.curevco_pcm[rowloop] = null_str
			lds_Equip.setitemstatus(rowloop, "eq_cur_event", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curev_type", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curev_site", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curev_arrdate", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curev_arrtime", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curev_deptime", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curev_shipment_id", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curev_conf", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curevco_name", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curevco_city", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curevco_state", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curevco_tz", primary!, notmodified!)
			lds_Equip.setitemstatus(rowloop, "curevco_pcm", primary!, notmodified!)
		end if
	next
else
	lds_Equip.reset()
end if


RETURN li_Return
end event

