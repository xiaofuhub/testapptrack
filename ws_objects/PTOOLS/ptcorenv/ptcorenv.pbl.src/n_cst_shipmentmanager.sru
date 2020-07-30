$PBExportHeader$n_cst_shipmentmanager.sru
forward
global type n_cst_shipmentmanager from n_cst_base
end type
type os_event from structure within n_cst_shipmentmanager
end type
end forward

type os_event from structure
	long		il_id
	string		is_type
	long		il_site
	date		id_appointment
	time		it_appointment
	date		id_arrive
	time		it_arrive
	time		it_depart
	string		is_confirmed
	string		is_assigned
	string		is_dispatched
	string		is_arrived
end type

shared variables
////These are being used solely for performance reasons.
////The SELECT * statements were just too slow too repeat
////every time.
////begin modification Shared Variables by appeon  20070730
//String	ss_ShipmentSyntax, &
//	ss_EventSyntax, &
//	ss_ItemSyntax
//
//n_ds 	sds_ship, &
//	sds_trip
//boolean 	sb_ships_retrieved, &
//	sb_trips_retrieved
//string	ss_ships_last_change
//integer	si_ships_filter
//datetime	sdt_ships_refreshed, &
//	sdt_ships_updated, &
//	sdt_LastShipmentCacheWrite, &
//	sdt_trips_refreshed, &
//	sdt_trips_updated
//long	sl_counter = 0
//
////Contains the full file name & path for the (current) cache file.
////Initialized to null in constructor.
//String	ss_ShipmentCacheFile
//
////In 3.5.15, capability was added to define multiple cache
////file codes, with restricted retrievals.  If this is in effect, the
////code and retrieval restriction will be listed in these variables.
////ss_ShipmentCacheWhereClauseExtension is initialized to null in constructor.
//String	ss_ShipmentCacheCode = "Default"
//String	ss_ShipmentCacheWhereClauseExtension
//
//Long sla_TotalEventIds[]
//Long sl_totaleventidsCtr
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_shipmentmanager from n_cst_base autoinstantiate
end type

type prototypes

end prototypes

type variables
n_cst_bso_Dispatch	inv_Dispatch
private boolean		ib_autoratingmode
private n_cst_ratedata	inva_ratedata[]
// RDT 8-13-03 
Private String		is_RouteType

////begin modification Shared Variables by appeon  20070730
//String	ss_ShipmentSyntax, &
//	ss_EventSyntax, &
//	ss_ItemSyntax
//
//boolean 	sb_ships_retrieved, &
//	sb_trips_retrieved
//string	ss_ships_last_change
//integer	si_ships_filter
//datetime	sdt_ships_refreshed, &
//	sdt_ships_updated, &
//	sdt_LastShipmentCacheWrite, &
//	sdt_trips_refreshed, &
//	sdt_trips_updated
////long	sl_counter = 0
//
////Contains the full file name & path for the (current) cache file.
////Initialized to null in constructor.
//String	ss_ShipmentCacheFile
//
////In 3.5.15, capability was added to define multiple cache
////file codes, with restricted retrievals.  If this is in effect, the
////code and retrieval restriction will be listed in these variables.
////ss_ShipmentCacheWhereClauseExtension is initialized to null in constructor.
//String	ss_ShipmentCacheCode = "Default"
//String	ss_ShipmentCacheWhereClauseExtension
//
//Long sla_TotalEventIds[]
//Long sl_totaleventidsCtr
////end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer of_populatereferencelists (powerobject apo_target)
private function integer of_getreferencelist (ref string asa_list[])
public function string of_convertreference (integer ai_id)
public function long of_newcrossdockshipment (long ala_dockids[])
public function long of_newcrossdockshipment ()
public function integer of_getnextshipmentid (ref long al_id)
public function integer of_getmaxshipmentid (ref long al_id)
public function integer of_getmaxitemid (ref long al_id)
public function integer of_getnexteventid (ref long al_id)
public function integer of_getnextitemid (ref long al_id)
public function long of_newshipment ()
private function integer of_setshipmentdefaults (datastore ads_target)
private function integer of_seteventdefaults (datastore ads_target)
private function integer of_setitemdefaults (datastore ads_target)
public subroutine of_openshipment (long al_id)
public function long of_newbrokerageshipment (long al_trip, long al_carrier)
public function long of_newbrokerageshipment ()
public function long of_newnonroutedshipment ()
public function datastore of_createshipmentdatastore (boolean ab_setdefaults)
public function datastore of_createeventdatastore (boolean ab_setdefaults)
public function datastore of_createitemdatastore (boolean ab_setdefaults)
public function integer of_getshipmentsorts (ref n_cst_msg anv_msg)
public function string of_converttmp (long al_shipmentid)
public subroutine of_loadbuilder (long ala_ids[])
public subroutine of_openshipments (long ala_ids[])
public function long of_getshipmentevents (ref datastore ads_target, long ala_ids[])
public function integer of_refreshshipments (boolean ab_refreshtrips)
private function integer of_populateeventstructure (datastore ads_source, long al_row, ref os_event astr_target)
public function integer of_updateequipment (long ala_ids[])
private function integer of_getequipmentevent (long al_id, ref os_event astr_event, boolean ab_forcerefresh)
private function integer of_populateeventstructure (ref os_event astr_event)
private function integer of_writeeventinfo (datastore ads_target, long al_row, string as_type, os_event astr_event)
public function n_ds of_get_ds_ship ()
public function n_ds of_get_ds_trip ()
public function boolean of_get_retrieved_ships ()
public function boolean of_get_retrieved_trips ()
public function datetime of_get_refreshed_ships ()
public subroutine of_set_retrieved_ships (boolean ab_switch)
public subroutine of_set_retrieved_trips (boolean ab_switch)
public function datetime of_get_refreshed_trips ()
public function datetime of_get_updated_ships ()
public function datetime of_get_updated_trips ()
public subroutine of_set_refreshed_ships (datetime adt_datetime)
public subroutine of_set_refreshed_trips (datetime adt_datetime)
public subroutine of_set_updated_trips (datetime adt_datetime)
public subroutine of_set_updated_ships (datetime adt_datetime)
public function string of_get_lastchange_ships ()
public subroutine of_set_lastchange_ships (string as_datetime)
public function integer of_get_filter_ships ()
public subroutine of_set_filter_ships (integer ai_filter)
public function integer of_preparesummarydisplay (readonly datawindow adw_target)
public function integer of_getfuelsurcharge (ref decimal ac_fuelsurcharge)
public subroutine of_opentrip (readonly long al_id)
public function long of_newtrip ()
public function boolean of_shipmentexists (readonly long al_id)
public function integer of_getcustomfuelsurchargedescription (ref string as_description)
public function datastore of_createshipmententries (ref n_cst_msg anv_msg)
public function datastore of_createevententries (ref n_cst_msg anv_msg)
public function datastore of_createitementries (ref n_cst_msg anv_msg)
public function boolean of_getinitializeapptdates ()
public function long of_newshipment (n_cst_msg anv_msg)
public function boolean of_isnonrouted (readonly long al_id)
public function integer of_loadshipmentcachefromfile ()
public function integer of_getshipmentcachefile (ref string as_filename)
public function string of_getstatuscodetable ()
public function string of_getstatusdisplayvalue (string as_datavalue)
public function string of_getstatusdatavalue (string as_displayvalue)
public function integer of_makenonrouted (long ala_ids[], boolean ab_confirmevents)
public function integer of_duplicateshipment (ref n_cst_msg anv_msg)
private function integer of_copyshipment (long al_rowtocopy, long al_newshipid, n_cst_msg anv_msg, ref n_ds ads_shipment)
private function integer of_copyitems (long al_nextshipmentid, ref n_ds ads_items, n_cst_msg anv_msg)
private function integer of_getorigevent (n_ds ads_source, ref n_cst_msg anv_msg)
private function integer of_gettermevent (n_ds ads_source, ref n_cst_msg anv_msg)
private function integer of_copyevents (long al_shipmentid, ref n_ds ads_events, n_cst_msg anv_msg, ref n_cst_msg anv_eventsmsg)
private function integer of_getsitesforduplication (readonly n_cst_msg anv_msg, readonly n_cst_msg anv_eventmsg, ref n_cst_msg anv_rtn_msg)
public function boolean of_doesshipmenthaveequipmentlinked (long al_shipmentid)
public subroutine of_setautoratingmode (boolean ab_mode)
public function boolean of_isautoratingmode ()
public subroutine of_setratedata (n_cst_ratedata anva_ratedata[])
public subroutine of_getratedata (ref n_cst_ratedata anva_ratedata[])
private function integer of_updateshipment (long al_shipmentid, ref n_cst_edi_204_record anv_204record)
private function integer of_setshipmentdata (ref n_cst_beo_shipment anv_shipment, ref n_cst_edi_204_record anv_204record)
private function integer of_setitemdata (ref n_cst_beo_item anv_item, ref n_cst_edi_204_record anv_204record)
public function integer of_createshipment (ref n_cst_edi_204_record anv_204record)
private function integer of_addstopsfrom204 (ref n_cst_edi_204_record anv_204, ref n_cst_beo_shipment anv_shipment, ref n_cst_bso_dispatch anv_dispatch)
public function integer of_import204shipmentfile (string as_filepath)
public function long of_newnonroutedbrokerage ()
public function integer of_populateextendedshipmentdata (datastore ads_target)
public function long of_getidfromtemplate (string as_Template)
public function integer of_createshipment (n_cst_messagedata anv_msgdata, ref n_cst_msg anv_msg)
private function integer of_cancelshipment (long al_shipmentid, ref n_cst_edi_204_record anv_204record)
public function integer of_setshipmentcachecode (string as_code)
public function string of_getshipmentcachecode ()
public subroutine of_openshipment (long al_id, n_cst_msg anv_msg)
public function integer of_validateref1text (ref n_cst_beo_shipment anv_shipment)
public function integer of_removefrontchassissplit (n_cst_beo_shipment anv_shipment, n_cst_bso_dispatch anv_dispatch)
public function integer of_removebackchassissplit (n_cst_beo_shipment anv_shipment, n_cst_bso_dispatch anv_dispatch)
public function string of_getcompanyroleinshipment (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company)
public function integer of_setintermodalorigindest (ref n_cst_beo_shipment anv_shipment)
private function integer of_initializenewintermodal (long al_shipmentid)
private function integer of_createintermodalevents (n_cst_msg anv_msg, ref datastore ads_target)
private function integer of_setcustomtext (ref n_cst_beo_shipment anv_shipment, n_cst_edi_204_record anv_204)
public function long of_getallcompanies (readonly n_cst_beo_shipment anv_shipment[], ref long ala_coid[])
public function integer of_setorigindestination (n_cst_beo_shipment anv_shipment, long al_eventid, long al_originalsiteid, long al_newsiteid)
public function long of_crosscheckreffields (ref n_cst_beo_shipment anv_shipment, unsignedlong aul_sourcefields, unsignedlong aul_targetfields, boolean ab_openonly, ref long ala_shipmentids[])
public function integer of_existingequipmententered (long al_eqid, long al_shipmentid)
public function string of_geteqtypeforreftype (integer ai_type)
public function integer of_checkequipmentbysmartsearch (string as_ref, string as_type, long ala_IgnoreShipments[], ref long ala_shipments[])
public function integer of_initializecontacts (long al_shipmentid)
public function integer of_reftypechanged (integer ai_whichone, n_cst_beo_shipment anv_shipment)
public function integer of_autoroute (long al_shipmentid)
public function integer of_autoroute (long ala_eventids[])
public function boolean of_autoroutelicensecheck ()
public function integer of_autoroute (long ala_eventids[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save)
public subroutine of_setroutetype (string as_RouteType)
public function string of_getroutetype ()
public function integer of_autoroute (readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save)
public function integer of_autoroutegetevents (readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, ref long ala_eventids[])
public function integer of_autoroutegetevents (readonly long al_shipmentid, n_cst_bso_dispatch anv_dispatch, ref long ala_eventids[], boolean ab_makeselection)
public function long of_addparentidstolist (unsignedlong ala_originalids[], ref unsignedlong ala_completelist[])
public function long of_addparentidstolist (long ala_originalids[], ref long ala_completelist[])
public function integer of_autoroute (readonly long ala_shipment[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist)
public function integer of_autoroute (readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist)
public function integer of_openshipmentlistorder (long ala_shipmentid[])
public function integer of_autorouterepos ()
public function long of_addparentidstolist (unsignedlong al_startid, ref unsignedlong al_endid)
public function integer of_openitinerary (long al_eventid, integer ai_itintype)
private function integer of_initializeshipment (long al_shipmentid)
public function string of_getfuelsurchargetype ()
public function integer of_createshipmentsfordeliveryreceipt (ref n_cst_beo_shipment anv_sourceshipment, ref n_cst_beo_shipment anva_delrecshipments[])
private function integer of_lookforequipment (n_cst_beo_shipment anv_shipment, ref string as_equipmentnumber, string as_eqtype)
public function integer of_process204 (ref n_cst_edi_204_record anv_204record, long al_sourcecompanyid)
private function integer of_processreal204 (ref n_cst_edi_204_record anv_204record, long al_sourcecompanyid)
public function long of_findshipmentbyinvoicenumber (string as_invoicenumber)
public function long of_findshipmentbyreftext (string as_text, boolean ab_excludeequipmenttypes)
public function integer of_validateref1text (long al_shipmentid, string as_reftype, string as_refvalue)
public function integer of_processcrossdocksforinvoice (n_cst_beo_shipment anv_shipment)
public function integer of_getfuelsurcharge (ref decimal ac_fuelsurcharge, ref n_cst_beo_shipment anv_shipment)
public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long ala_eventids[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_forceitinselect)
public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long ala_eventids[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save)
public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist, boolean ab_forceitinselect)
protected function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist)
public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long al_shipmentid, boolean ab_forceitinselect)
public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long al_shipmentid)
public function long of_getdivision (long al_tmpnum)
private function integer of_duplicateshipment (ref n_cst_msg anv_msg, boolean ab_createequipment)
public function integer of_createequipment (n_cst_msg anv_msg, n_cst_msg anv_eventsmsg, long al_shipid)
private function datastore of_getftesource (long ala_shipments[])
end prototypes

public function integer of_populatereferencelists (powerobject apo_target);String	ls_List, &
			lsa_List [], &
			lsa_ColumnList [], &
			ls_Command
Integer	li_Ndx, &
			li_Count, &
			li_ColumnCount
n_cst_Dws	lnv_Dws
DataWindow	ldw_Target
DataStore	lds_Target
Object	le_Type

le_Type = lnv_Dws.of_ResolvePowerObject ( apo_Target, ldw_Target, lds_Target )

li_Count = of_GetReferenceList ( lsa_List )

FOR li_Ndx = 1 TO li_Count
	ls_List += lsa_List [ li_Ndx ] + "~t" + String ( li_Ndx - 1 ) + "/"
NEXT

ls_List = Substitute ( ls_List, "'", "~~~'" )

lsa_ColumnList = {"ds_ref1_type", "ds_ref2_type", "ds_ref3_type", &
	"shipment_ref1type", "shipment_ref2type", "shipment_ref3type"}
li_ColumnCount = UpperBound (lsa_ColumnList)

FOR li_Ndx = 1 TO li_ColumnCount

	ls_Command = lsa_ColumnList [ li_Ndx ] + ".Values = '" + ls_List + "'"

	//If an attempted column does not exist, modify will fail harmlessly

	CHOOSE CASE le_Type
	CASE DataWindow!
		ldw_Target.Modify ( ls_Command )
	CASE DataStore!
		lds_Target.Modify ( ls_Command )
	END CHOOSE

NEXT

RETURN 1
end function

private function integer of_getreferencelist (ref string asa_list[]);String	lsa_List[]
Integer	li_Count


n_cst_ReferenceList lnv_ReferenceList
lnv_ReferenceList = CREATE n_cst_ReferenceList

/* Originally coded. 
//WARNING:  It is critically important that the order of these entries not be changed.  Their position is used by of_PopulateReferenceLists to calculate the corresponding data value.  If you change the position, you change the values.  Append values ONLY!

				   //0		 1				   2		   3			4				5				6			7				8					9				  10				11			12					13				14				15				16				17				18			 19				20					21				22          23             24          25            26          27            28           29			    30          31			 32				33
lsa_List = {"[NONE]", "SHIPPER'S #", "REF #", "P.O. #", "PRO #", "AIRBILL #", "ORDER #", "S.O. #", "WORK ORDER #", "RELEASE #", "CONTROL #", "SLIP #", "TICKET #", "CARRIER #", "TRIP #", "MASTER BL #", "AUTH. #", "ENTRY #", "BOOKING #", "RECEIPT #", "CONTAINER #", "SEAL #", "FWDR REF #", "TRAILER #", "PICKUP #", "MANIFEST #", "RAILBOX #", "CUSTOMER #" , "CHASSIS #" , "LOAD #" , "PRENOTE #", "CUSTOMS #" , "I.T. #" , "CLAIM #"}
li_Count = UpperBound ( lsa_List )
asa_List = lsa_List

*/

// zmc - 2-18-04
lsa_List[] = {""}

IF lnv_ReferenceList.of_GetReferenceList( lsa_List, appeon_constant.cs_ReferenceType) = 1 THEN
	li_Count = UpperBound ( lsa_List )
	asa_List = lsa_List
END IF

DESTROY(lnv_ReferenceList)

RETURN li_Count
end function

public function string of_convertreference (integer ai_id);String	lsa_List[], &
			ls_Return
Integer	li_Count, &
			li_Ndx
			
li_Ndx = ai_Id + 1

li_Count = of_GetReferenceList ( lsa_List )

IF li_Ndx > 0 AND li_Ndx <= li_Count THEN
	ls_Return = lsa_List [ li_Ndx ]
ELSE
	SetNull ( ls_Return )
END IF

RETURN ls_Return
end function

public function long of_newcrossdockshipment (long ala_dockids[]);Long	ll_ShipmentId
n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm
n_cst_Conversion	lnv_Conversion

lstr_Parm.is_Label = "Style"
lstr_Parm.ia_Value = "CROSSDOCK!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DockId"
lnv_Conversion.of_SetAnyTypeLong ( lstr_Parm.ia_Value )
lstr_Parm.ia_Value = ala_DockIds [ 1 ]
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_ShipmentId = This.of_NewShipment ( lnv_Msg )

RETURN ll_ShipmentId
end function

public function long of_newcrossdockshipment ();Long		ll_DockId, &
			lla_DockIds[], &
			ll_Return, &
			lla_SelectedIndexes[]
String	ls_MessageHeader, &
			lsa_DockDescriptions[], &
			ls_Result
Integer	li_DockCount, &
			li_Ndx
n_cst_CrossDock	lnv_CrossDock
s_Strings	lstr_Strings
n_cst_String	lnv_String

ls_MessageHeader = "New Cross-Dock Shipment"

n_cst_privileges	lnv_Privs
IF NOT lnv_Privs.of_HasEntryRights () THEN
	Messagebox ( "New Shipment" , "You are not authorized to create new shipments." )
	RETURN -1
END IF
	

lnv_CrossDock = CREATE n_cst_CrossDock

li_DockCount = lnv_CrossDock.of_GetDockDescriptions ( lla_DockIds, lsa_DockDescriptions )

CHOOSE CASE li_DockCount

CASE IS > 1

	lstr_Strings.Strar [ 1 ] = ls_MessageHeader
	lstr_Strings.Strar [ 2 ] = "Please select a dock location."

	FOR li_Ndx = 1 TO li_DockCount
		lstr_Strings.Strar [ 4 + li_Ndx ] = lsa_DockDescriptions [ li_Ndx ]
	NEXT

	OpenWithParm ( w_List_Sel, lstr_Strings )
	ls_Result = Message.StringParm

	lnv_String.of_ParseToArray ( ls_Result, "q", lla_SelectedIndexes )

	IF UpperBound ( lla_SelectedIndexes ) > 0 THEN

		ll_Return = of_NewCrossDockShipment ( { lla_DockIds [ lla_SelectedIndexes [ 1 ] ] } )

	ELSE

		ll_Return = 0

	END IF

CASE 1
	ll_Return = of_NewCrossDockShipment ( { lla_DockIds [ 1 ] } )

CASE 0
	MessageBox ( ls_MessageHeader, "No docks have been defined.~n~nRequest cancelled." )
	ll_Return = -1

CASE ELSE
	MessageBox ( ls_MessageHeader, "Could not retrieve dock information from database.~n~n" +&
		"Request cancelled.", Exclamation! )
	ll_Return = -1

END CHOOSE

DESTROY lnv_CrossDock
RETURN ll_Return
end function

public function integer of_getnextshipmentid (ref long al_id);//Return Values : 1 = Success, -1 = Failure

Long		ll_NewID
Integer	li_Return

IF gnv_App.of_GetNextid( "n_cst_beo_shipment", ll_NewID , TRUE ) = 1 THEN
	al_id = ll_NewID
	li_Return = 1 
ELSE
	li_Return = -1
END IF

RETURN li_Return

/* Changed for 4.0
n_cst_numerical lnv_numerical

IF of_GetMaxShipmentId ( ll_Max ) = 1 THEN
	IF lnv_numerical.of_IsNullOrNotPos ( ll_Max ) THEN
		ll_Max = 0
	END IF
	al_Id = ll_Max + 1
	li_Return = 1
ELSE
	SetNull ( al_Id )
	li_Return = -1
END IF
*/

end function

public function integer of_getmaxshipmentid (ref long al_id);//Return Values : 1 = Success (even if there is no max value), -1 = Failure

String		ls_Table, &
				ls_Column
n_cst_Dws	lnv_Dws

ls_Table = "disp_ship"
ls_Column = "ds_id"

RETURN lnv_Dws.of_GetMaxValue ( ls_Table, ls_Column, al_Id )
end function

public function integer of_getmaxitemid (ref long al_id);//Return Values : 1 = Success (even if there is no max value), -1 = Failure

String		ls_Table, &
				ls_Column
n_cst_Dws	lnv_Dws

ls_Table = "disp_items"
ls_Column = "di_item_id"

RETURN lnv_Dws.of_GetMaxValue ( ls_Table, ls_Column, al_Id )
end function

public function integer of_getnexteventid (ref long al_id);//Return Values : 1 = Success, -1 = Failure

Long		ll_NewID
Integer	li_Return

IF gnv_App.of_GetNextid( "n_cst_beo_event", ll_NewID , TRUE ) = 1 THEN
	al_id = ll_NewID
	li_Return = 1 
ELSE
	li_Return = -1
END IF

/*
		////  CHANGED for 4.0
		
IF of_GetMaxEventId ( ll_NewID ) = 1 THEN
	IF lnv_numerical.of_IsNullOrNotPos ( ll_NewID ) THEN
		ll_Max = 0
	END IF
	al_Id = ll_Max + 1
	li_Return = 1
ELSE
	SetNull ( al_Id )
	li_Return = -1
END IF
*/ 

RETURN li_Return
end function

public function integer of_getnextitemid (ref long al_id);//Return Values : 1 = Success, -1 = Failure

Long		ll_NewID
Integer	li_Return

IF gnv_App.of_GetNextid( "n_cst_beo_item", ll_NewID , TRUE ) = 1 THEN
	al_id = ll_NewID
	li_Return = 1 
ELSE
	li_Return = -1
END IF


/*

	// Changed in 4.0

IF of_GetMaxItemId ( ll_Max ) = 1 THEN
	IF lnv_numerical.of_IsNullOrNotPos ( ll_Max ) THEN
		ll_Max = 0
	END IF
	al_Id = ll_Max + 1
	li_Return = 1
ELSE
	SetNull ( al_Id )
	li_Return = -1
END IF
*/
RETURN li_Return
end function

public function long of_newshipment ();n_cst_Msg	lnv_Msg
n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Dispatch ) THEN
	RETURN This.of_NewShipment ( lnv_Msg )

ELSEIF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Brokerage ) THEN
	RETURN This.of_NewBrokerageShipment ( )

ELSEIF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_OrderEntry ) THEN
	RETURN This.of_NewNonRoutedShipment ( )

ELSE
	lnv_LicenseManager.of_DisplayModuleNotice ( "New Shipment" )
	RETURN 0

END IF
end function

private function integer of_setshipmentdefaults (datastore ads_target);string	ls_setting, &
			ls_format
			
any		la_setting			



n_cst_settings	lnv_settings

ads_Target.Modify ( "ds_PpCol.Initial = 'Z'" )
ads_Target.Modify ( "ds_EqOnBill.Initial = 'T'" )
ads_Target.Modify ( "ds_Total_Miles.Initial = '0'" )
ads_Target.Modify ( "ds_Total_Weight.Initial = '0'" )
ads_Target.Modify ( "ds_Hazmat.Initial = 'F'" )
ads_Target.Modify ( "ds_Expedite.Initial = 'F'" )
ads_Target.Modify ( "ds_LH_TotAmt.Initial = '0'" )
ads_Target.Modify ( "ds_Disc_Amt.Initial = '0'" )
ads_Target.Modify ( "ds_Disc_Pct.Initial = '0'" )
ads_Target.Modify ( "ds_AC_TotAmt.Initial = '0'" )
ads_Target.Modify ( "ds_Bill_Charge.Initial = '0'" )
ads_Target.Modify ( "ds_Pay_LH_TotAmt.Initial = '0'" )
ads_Target.Modify ( "ds_Pay_AC_TotAmt.Initial = '0'" )
ads_Target.Modify ( "ds_Pay_TotAmt.Initial = '0'" )
ads_Target.Modify ( "ds_SalesCom_Amt.Initial = '0'" )
ads_Target.Modify ( "ds_Status.Initial = '" + gc_Dispatch.cs_ShipmentStatus_Open + "'" ) //This wasn't a DB default
ads_Target.Modify ( "ds_IntSig.Initial = '1'" )
//check system setting for default
IF lnv_Settings.of_GetSetting ( 96 , la_Setting ) <> 1 THEN
	ads_Target.Modify ( "ds_Bill_Format.Initial = 'I'" )
ELSE
	ls_Setting = string ( la_Setting ) 
	
	CHOOSE CASE ls_Setting
			
		CASE "ITEM!"			
			ls_format = "I"
			
		CASE "FREIGHTACCESSORIAL!"
			ls_format = "L"
			
		CASE"GRANDTOTAL!"
			ls_format = "G"
			
		CASE ELSE //DEFAULT
			ls_format = "I"
			
	END CHOOSE
	
	ads_Target.Modify ( "ds_Bill_Format.Initial = '" + ls_format + "'")
	
END IF

//check system setting for default
IF lnv_Settings.of_GetSetting ( 97 , la_Setting ) <> 1 THEN
	ads_Target.Modify ( "ds_Pay_Format.Initial = 'I'" )
ELSE
	ls_Setting = string ( la_Setting ) 
	
	CHOOSE CASE ls_Setting
			
		CASE "ITEM!"			
			ls_format = "I"
			
		CASE "FREIGHTACCESSORIAL!"
			ls_format = "L"
			
		CASE"GRANDTOTAL!"
			ls_format = "G"
			
		CASE ELSE //DEFAULT
			ls_format = "I"
			
	END CHOOSE
	
	ads_Target.Modify ( "ds_Pay_Format.Initial = '" + ls_format + "'")
	
END IF

ads_Target.Modify ( "ds_Ref1_Type.Initial = '0'" )
ads_Target.Modify ( "ds_Ref2_Type.Initial = '0'" )
ads_Target.Modify ( "ds_Ref3_Type.Initial = '0'" )

RETURN 1
end function

private function integer of_seteventdefaults (datastore ads_target);ads_Target.Modify ( "de_Tractor_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Trailer_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Driver_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Conf.Initial = 'F'" )
ads_Target.Modify ( "de_Intsig.Initial = '1'" )
//ads_Target.Modify ( "de_Locked.Initial = 'N'" )      //This wasn't a DB default
//ads_Target.Modify ( "de_Status.Initial = 'K'" )	     //This wasn't a DB default
ads_Target.Modify ( "de_Duration.Initial = '00:30'" )
ads_Target.Modify ( "de_Trailer1_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Trailer2_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Trailer3_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Container1_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Container2_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Container3_Seq.Initial = '0'" )
ads_Target.Modify ( "de_Container4_Seq.Initial = '0'" )
ads_Target.Modify ( "de_ActEq_Seq.Initial = '0'" )
ads_Target.Modify ( "de_ActPos.Initial = '0'" )

RETURN 1
end function

private function integer of_setitemdefaults (datastore ads_target);ads_Target.Modify ( "di_Qty.Initial = '1'" )
ads_Target.Modify ( "di_WeightPerUnit.Initial = '0'" )
ads_Target.Modify ( "di_TotItemWeight.Initial = '0'" )
ads_Target.Modify ( "di_Our_RateType.Initial = 'Z'" )
ads_Target.Modify ( "di_Our_Rate.Initial = '0'" )
ads_Target.Modify ( "di_Our_ItemAmt.Initial = '0'" )
ads_Target.Modify ( "di_Miles.Initial = '0'" )
ads_Target.Modify ( "di_Hazmat.Initial = 'F'" )

ads_Target.Modify ( "di_Pay_Rate.Initial = '0'" )
ads_Target.Modify ( "di_Pay_ItemAmt.Initial = '0'" )

RETURN 1
end function

public subroutine of_openshipment (long al_id);//n_cst_ratedata	lnva_ratedata[]
//w_Dispatch	lw_Dispatch
//n_cst_AppServices	lnv_AppServices
//
//S_Parm	lstr_Parm
n_cst_Msg	lnv_Msg

THIS.of_OpenShipment  ( al_id , lnv_Msg ) 
//
//lstr_Parm.is_label = "CATEGORY"
//lstr_Parm.ia_Value = "SHIP"
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//lstr_Parm.is_label = "ID"
//lstr_Parm.ia_Value = al_Id
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//
//if this.of_isautoratingmode() then
//	this.of_getratedata(lnva_ratedata)
//	lstr_Parm.is_label = "RATEDATA"
//	lstr_Parm.ia_Value =  lnva_ratedata
//	lnv_Msg.of_Add_Parm ( lstr_Parm )
//end if
//
//OpenSheetWithParm ( lw_Dispatch, lnv_Msg, lnv_AppServices.of_GetFrame ( ), 0, Original! )
end subroutine

public function long of_newbrokerageshipment (long al_trip, long al_carrier);//NOTE:  This version of the function can be eliminated.
//We just need to revise the overloaded version to call of_NewShipment directly, 
//and check for any other direct references elsewhere in the application.
//The brokeragetrip and brokerage carrier entries are now unused.


Long	ll_ShipmentId
n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm

lstr_Parm.is_Label = "Style"
lstr_Parm.ia_Value = "BROKERAGE!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

IF al_Trip > 0 THEN
	lstr_Parm.is_Label = "BrokerageTrip"
	lstr_Parm.ia_Value = al_Trip
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF al_Carrier > 0 THEN
	lstr_Parm.is_Label = "BrokerageCarrier"
	lstr_Parm.ia_Value = al_Carrier
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

ll_ShipmentId = This.of_NewShipment ( lnv_Msg )

RETURN ll_ShipmentId
end function

public function long of_newbrokerageshipment ();Long	ll_Trip, &
		ll_Carrier

SetNull ( ll_Trip )
SetNull ( ll_Carrier )

RETURN of_NewBrokerageShipment ( ll_Trip, ll_Carrier )
end function

public function long of_newnonroutedshipment ();Long	ll_ShipmentId
n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm

lstr_Parm.is_Label = "Style"
lstr_Parm.ia_Value = "NONROUTED!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_ShipmentId = This.of_NewShipment ( lnv_Msg )

RETURN ll_ShipmentId
end function

public function datastore of_createshipmentdatastore (boolean ab_setdefaults);DataStore	lds_New
String		ls_Select, &
				ls_Syntax, &
				ls_Presentation, &
				ls_Error

IF Len ( ss_ShipmentSyntax ) > 0 THEN
	ls_Syntax = ss_ShipmentSyntax
ELSE
	ls_Select = "SELECT * FROM disp_ship"
	ls_Syntax = SQLCA.SyntaxFromSQL ( ls_Select, ls_Presentation, ls_Error )
	ss_ShipmentSyntax = ls_Syntax
END IF

lds_New = CREATE DataStore
lds_New.Create ( ls_Syntax )
lds_New.SetTransObject ( SQLCA )

IF ab_SetDefaults THEN
	of_SetShipmentDefaults ( lds_New )
END IF

RETURN lds_New
end function

public function datastore of_createeventdatastore (boolean ab_setdefaults);DataStore	lds_New
String		ls_Select, &
				ls_Syntax, &
				ls_Presentation, &
				ls_Error

IF Len ( ss_EventSyntax ) > 0 THEN
	ls_Syntax = ss_EventSyntax
ELSE
	ls_Select = "SELECT * FROM disp_events"
	ls_Syntax = SQLCA.SyntaxFromSQL ( ls_Select, ls_Presentation, ls_Error )
	ss_EventSyntax = ls_Syntax
END IF

lds_New = CREATE DataStore
lds_New.Create ( ls_Syntax )
lds_New.SetTransObject ( SQLCA )

IF ab_SetDefaults THEN
	of_SetEventDefaults ( lds_New )
END IF

RETURN lds_New
end function

public function datastore of_createitemdatastore (boolean ab_setdefaults);DataStore	lds_New
String		ls_Select, &
				ls_Syntax, &
				ls_Presentation, &
				ls_Error

IF Len ( ss_ItemSyntax ) > 0 THEN
	ls_Syntax = ss_ItemSyntax
ELSE
	ls_Select = "SELECT * FROM disp_items"
	ls_Syntax = SQLCA.SyntaxFromSQL ( ls_Select, ls_Presentation, ls_Error )
	ss_ItemSyntax = ls_Syntax
END IF

lds_New = CREATE DataStore
lds_New.Create ( ls_Syntax )
lds_New.SetTransObject ( SQLCA )

IF ab_SetDefaults THEN
	of_SetItemDefaults ( lds_New )
END IF

RETURN lds_New
end function

public function integer of_getshipmentsorts (ref n_cst_msg anv_msg);s_Parm	lstr_Parm
Integer	li_SortCount

anv_Msg.of_Reset ( )

lstr_Parm.is_Label = "ShipDt, TMP#"
lstr_Parm.ia_Value = "shipment_shipdate A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ShipDt, BillTo"
lstr_Parm.ia_Value = "shipment_shipdate A, billto_name A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ShipDt, Origin"
lstr_Parm.ia_Value = "shipment_shipdate A, origin_name A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ShipDt, O. Loc."
lstr_Parm.ia_Value = "shipment_shipdate A, origin_state A, origin_city A, origin_name A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ShipDt, Dest."
lstr_Parm.ia_Value = "shipment_shipdate A, destination_name A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "ShipDt, D. Loc."
lstr_Parm.ia_Value = "shipment_shipdate A, destination_state A, destination_city A, destination_name A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Type, OL, Appt"
lstr_Parm.ia_Value = "LookupDisplay ( shipment_shiptypeid ) A, origin_state A, origin_city A, " +&
	"shipment_scheduledpickupdate A, shipment_scheduledpickuptime A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Type, DL, Appt"
lstr_Parm.ia_Value = "LookupDisplay ( shipment_shiptypeid ) A, destination_state A, destination_city A, " +&
	"shipment_scheduleddeliverydate A, shipment_scheduleddeliverytime A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Shipment Type"
lstr_Parm.ia_Value = "LookupDisplay ( shipment_shiptypeid ) A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "TMP#"
lstr_Parm.ia_Value = "ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "BillTo"
lstr_Parm.ia_Value = "billto_name A, shipment_shipdate A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Origin"
lstr_Parm.ia_Value = "origin_name A, shipment_shipdate A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Origin Loc."
lstr_Parm.ia_Value = "origin_state A, origin_city A, origin_name A, shipment_shipdate A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Destination"
lstr_Parm.ia_Value = "destination_name A, shipment_shipdate A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Dest. Loc."
lstr_Parm.ia_Value = "destination_state A, destination_city A, destination_name A, shipment_shipdate A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Equipment"
lstr_Parm.ia_Value = "nextevent_equipment_description A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Next Dt/Tm"
lstr_Parm.ia_Value = "nextevent_date A, nextevent_time A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Next Site"
lstr_Parm.ia_Value = "nextevent_site A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Next Loc."
lstr_Parm.ia_Value = "nextevent_state A, nextevent_city A, nextevent_site A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Last Dt/Tm"
lstr_Parm.ia_Value = "lastconfirmed_date A, lastconfirmed_time A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Last Site"
lstr_Parm.ia_Value = "lastconfirmed_site A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Last Loc."
lstr_Parm.ia_Value = "lastconfirmed_state A, lastconfirmed_city A, lastconfirmed_site A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Billing Status"
lstr_Parm.ia_Value = "shipment_billingstatus A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Cust Ref #"
lstr_Parm.ia_Value = "shipment_ref1text A, ds_id A"
anv_Msg.of_Add_Parm ( lstr_Parm )

li_SortCount = anv_Msg.of_Get_Count ( )

RETURN li_SortCount
end function

public function string of_converttmp (long al_shipmentid);RETURN String ( al_ShipmentId, "0000" )
end function

public subroutine of_loadbuilder (long ala_ids[]);//Elaborate
end subroutine

public subroutine of_openshipments (long ala_ids[]);Long	ll_Count, &
		ll_Ndx

ll_Count = UpperBound ( ala_Ids )

IF ll_Count > 5 THEN

	IF MessageBox ( "Shipment Details", "Are you sure you want to display details for "+&
		String ( ll_Count ) + " shipments?", Question!, YesNo! ) = 2 THEN

		RETURN

	END IF

END IF

FOR ll_Ndx = 1 TO UpperBound ( ala_Ids )

	Post of_OpenShipment ( ala_Ids [ ll_Ndx ] )

NEXT
end subroutine

public function long of_getshipmentevents (ref datastore ads_target, long ala_ids[]);String	ls_Select
Long		ll_Count, &
			ll_Ndx, &
			ll_Return, &
			lla_Sites[]

n_cst_anyarraysrv lnv_anyarray
ll_Count = lnv_anyarray.of_GetShrinked( ala_Ids, "NULLS~tDUPES" )

DESTROY ads_Target

ads_Target = of_CreateEventDataStore ( FALSE )

IF ll_Count > 0 THEN

	ls_Select = ads_Target.Object.DataWindow.Table.Select
	
	ls_Select += " WHERE de_shipment_id IN ("
	ls_Select += String ( ala_Ids [ 1 ] )

	FOR ll_Ndx = 2 TO ll_Count
		ls_Select += ", " + String ( ala_Ids [ ll_Ndx ] )
	NEXT

	ls_Select += ")"

	ads_Target.Object.DataWindow.Table.Select = ls_Select

	IF ads_Target.Retrieve ( ) = -1 THEN
		ROLLBACK ;
		ll_Return = -1
	ELSE
		COMMIT ;
		ll_Return = ads_Target.RowCount ( )

		IF ll_Return > 0 THEN

			lla_Sites = ads_Target.Object.de_Site.Primary
			gnv_cst_Companies.of_Cache ( lla_Sites, FALSE )

		END IF

	END IF

ELSE
	ll_Return = 0

END IF

RETURN ll_Return
end function

public function integer of_refreshshipments (boolean ab_refreshtrips);////Revised 4.0.45 9/1/05 BKW to cross check timestamps already retrieved in the cache
////with timestamps that come in from the id check.  Dirty reads were occasionally getting lodged 
////in the cache.  This change will cause this situation to be recognized and corrected.
//
//boolean lb_Failed
//
//setpointer(hourglass!)
//
//DataStore lds_ShipChanges, lds_ShipIds, lds_TripBackup
//DWObject ldwo_ShipChangesTimestamp, ldwo_CheckId, ldwo_CacheId, ldwo_CheckTimestamp, ldwo_CacheTimestamp
//
//long ll_CurrentShipmentCount, ll_CacheCount, ll_ShipChangesCount, ll_CheckRow, ll_CacheRow, &
//	ll_CheckId, ll_CacheId, ll_TimestampRetrCount, lla_TimestampRetrIds[]
//string ls_Select, ls_CheckTimestamp, ls_MaxTimestamp, ls_TimestampInClause
//
//String	ls_ShipmentCacheFile
//Long		ll_ShipRow
//Boolean	lb_ShipmentCacheChanges, &
//			lb_CheckTimestamps
//n_cst_DateTime		lnv_DateTime
//n_cst_Sql			lnv_Sql
//
//if ab_RefreshTrips then
//	if sds_trip.rowcount() > 0 then
//		lds_TripBackup = create datastore
//		lds_TripBackup.dataobject = "d_trip_list"
//		lds_TripBackup.object.data.primary = sds_trip.object.data.primary
//	end if
//	if sds_trip.retrieve() = -1 then
//		rollback ;
//		lb_Failed = true
//		goto ship_cleanup
//	else
//		commit ;
//	end if
//end if
//
//
////If it's been at least 30 minutes since last refresh (which will include the first attempt, due to the
////way sdt_ships_refreshed is initialized), attempt to load the most recent cache from the cachefile.
////If it hasn't been at least that long, just do the manual refresh.
////If this doesn't succeed, we'll just pull the whole list manually.
////Note: Calling of_LoadShipmentCacheFromFile will call of_GetShipmentCacheFile, which will initialize
////the values for ss_ShipmentCacheCode and ss_ShipmentCacheWhereClauseExtension
//
//IF lnv_DateTime.of_SecondsAfter ( sdt_Ships_Refreshed, DateTime ( Today ( ), Now ( ) ) ) > 1800 THEN
//	This.of_LoadShipmentCacheFromFile ( )
//END IF
//
//
////Creation and determination of select statement for lds_ShipChanges was here prior to 4.0.45  Moved 9/1/05 BKW
//
//
////This section will see if any rows in the cache should no longer be there (due to deletion,
////the fact that they are no longer in current shipments, or -- if this is a custom cache -- the 
////fact that they no longer meet the criteria for this custom cache.)
//
////We're going to retrieve a list of all the ids that currently qualify for this cache, and if 
////there's any rows in the cache not in this id list, we'll remove them.
//
//ll_CacheCount = sds_ship.rowcount()
//
//if ll_CacheCount > 0 then
//
//	lds_ShipIds = create datastore
//	lds_ShipIds.dataobject = "d_current_shipment_ids"
//	lds_ShipIds.settransobject(sqlca)
//	lds_ShipIds.setsort("cs_id A")
//
//
//	//Added 3.5.19 BKW.  Limit the retrieve to the criteria for the custom cache (if any.)
//	//(This had been omitted between 3.5.15 and 3.5.18, and was causing rows not to drop
//	//out of a custom cache if they no longer met custom cache criteria.)
//	
//	IF Len ( ss_ShipmentCacheWhereClauseExtension ) > 0 THEN
//		ls_Select = lds_ShipIds.object.datawindow.table.select
//		ls_Select += " AND ( " + ss_ShipmentCacheWhereClauseExtension + " )"
//		lds_ShipIds.object.datawindow.table.select = ls_Select
//	END IF
//
//
//	ll_CurrentShipmentCount = lds_ShipIds.retrieve()
//	if ll_CurrentShipmentCount = -1 then
//		rollback ;
//		lb_Failed = true
//		goto ship_cleanup
//	elseif ll_CurrentShipmentCount = 0 then
//		commit ;
//		sds_ship.reset()
//		lb_ShipmentCacheChanges = TRUE
//		goto ship_cleanup
//	end if
//
//end if
//
//
////Retrieve of lds_ShipChanges was here prior to 4.0.45.  Moved below 4.0.45 9/1/05 BKW
////The move is so that any shipments in the cache whose timestamp is less than the ss_ships_last_change
////(the max timestamp in the cache) but does not match the timestamp in the table can be identified 
////and forced to be included in the refresh.
//
//
////Record in a boolean whether we have the info we need to do timestamp comparisons, for fast access in loop.
//
//IF sb_ships_retrieved and len(ss_ships_last_change) > 0 THEN
//	lb_CheckTimestamps = TRUE
//END IF
//
//
//if ll_CacheCount > 0 and ll_CurrentShipmentCount > 0 then
//	
//	sds_ship.setsort("ds_id A")
//	sds_ship.sort()
//	ll_CheckRow = 1
//	ll_CacheRow = 1
//	ldwo_CheckId = lds_ShipIds.object.cs_id
//	ldwo_CacheId = sds_ship.object.ds_id
//	
//	ldwo_CheckTimestamp = lds_ShipIds.Object.cs_timestamp
//	ldwo_CacheTimestamp = sds_Ship.Object.cs_timestamp
//	
//	do
//		
//		ll_CheckId = ldwo_CheckId.primary[ll_CheckRow]
//
//		do
//
//			ll_CacheId = ldwo_CacheId.primary[ll_CacheRow]
//			
//			if ll_CacheId < ll_CheckId then
//				sds_ship.rowsdiscard(ll_CacheRow, ll_CacheRow, primary!)
//				ll_CacheCount --
//				lb_ShipmentCacheChanges = TRUE
//				continue
//			elseif ll_CacheId > ll_CheckId then
//				exit
//			else
//				
//				//Added 4.0.45 9/1/05 BKW
//				//The ids match.  Cross-check the timestamps.  If the timestamp in the table is 
//				//greater than the ss_ships_last_change timestamp, that row will be refreshed normally
//				//due to the timestamp criteria.  If the timestamp in the table is <= ss_ships_last_change 
//				//AND it is DIFFERENT from the timestamp in the cache, this is an update that got skipped
//				//over due to a dirty read and we need to record that id so we can include that id explicitly 
//				//in the refresh request.  (Note:  We could actually just record all the ids whose timestamps,
//				//don't match but I thought it would be better to avoid that for performance reasons.)
//				
//				//Changing isolation level for these queries to prevent dirty reads in the first place is probably 
//				//not a viable option since the query would wait for all write locks on the rows being queried to
//				//be released, which could severely degrade performance.  So, this approach does not attempt to
//				//prevent a dirty read, but rather to "catch it" on the next pass and correct the data.
//				
//				//This change was implemented due to some occasional dirty read scenarios in the field.
//				
//				IF lb_CheckTimestamps THEN  	//If we don't have ss_ships_last_change, can't do these comparisons
//														//In that case, all rows will be refreshed later, so it's ok.
//				
//					ls_CheckTimeStamp = ldwo_CheckTimeStamp.Primary [ ll_CheckRow ]
//					
//					IF ls_CheckTimeStamp > ss_ships_last_change THEN
//						
//						//OK, change will be caught by timestamp comparison in where clause
//						
//					ELSEIF ls_CheckTimeStamp = ldwo_CacheTimeStamp.Primary [ ll_CacheRow ] THEN
//						
//						//OK, the timestamp in the cache matches the timestamp in the table.
//						//No change needed.
//						
//					ELSE
//						//The timestamp in the cache is less than the timestamp in the table,
//						//but is less than the max timestamp in the cache.  Need to force retrieval
//						//for this id.
//						
//						ll_TimestampRetrCount ++
//						lla_TimestampRetrIds [ ll_TimestampRetrCount ] = ll_CacheId
//						
//					END IF
//					
//				END IF
//				
//				//////End 4.0.45 addition
//				
//				ll_CacheRow ++
//			end if
//			
//		loop while ll_CacheRow <= ll_CacheCount
//		
//		if ll_CacheRow > ll_CacheCount then exit
//		
//		ll_CheckRow ++
//		
//	loop while ll_CheckRow <= ll_CurrentShipmentCount
//	
//	if ll_CacheRow <= ll_CacheCount then
//		sds_ship.rowsdiscard(ll_CacheRow, ll_CacheCount, primary!)
//		ll_CacheCount = ll_CacheRow - 1
//		lb_ShipmentCacheChanges = TRUE
//	end if
//	
//end if
//
//
////Moved from earlier position 4.0.45 9/1/05 BKW   
////Changed position in order to include the problem-timestamp ids from the preceding section in the where clause.
//
//lds_ShipChanges = create datastore
//lds_ShipChanges.dataobject = "d_current_shipments"
//lds_ShipChanges.settransobject(sqlca)
//
//ls_Select = lds_ShipChanges.object.datawindow.table.select
//
////if sb_ships_retrieved and len(ss_ships_last_change) > 0 then
//IF lb_CheckTimestamps THEN   //This boolean now captures the condition above.
//
//	IF ll_TimestampRetrCount > 0 THEN
//		ls_TimestampInClause = lnv_Sql.of_MakeInClause ( lla_TimestampRetrIds )
//	END IF
//
//	ls_Select += " AND "
//	
//
//	IF Len ( ls_TimestampInClause ) > 0 THEN
//		ls_Select += "( ( ~~~"current_shipments~~~".~~~"cs_id~~~" " + ls_TimestampInClause + " ) OR "
//	END IF
//	
//	ls_Select += "( ~~~"current_shipments~~~".~~~"timestamp~~~" > ~'" + ss_ships_last_change + "~' )"
//	
//	IF Len ( ls_TimestampInClause ) > 0 THEN
//		ls_Select += " )"  //Close the additional parenthesis opened due to the OR condition.
//	END IF
//	
//end if
//	
//
////Added 3.5.15 BKW.  This was being done as a separate step until 4.0.45, reading the select that had already
////been set, tacking on the additional extension, and setting it back.  I've combined it here.  9/1/05 BKW
//
//IF Len ( ss_ShipmentCacheWhereClauseExtension ) > 0 THEN
//	ls_Select += " AND ( " + ss_ShipmentCacheWhereClauseExtension + " )"
//END IF
//
////End of combined code
//
////Set the assembled select statement onto the datastore.
//
//lds_ShipChanges.object.datawindow.table.select = ls_Select
//	
//
//
//
////Moved from earlier position 4.0.45 9/1/05 BKW
//
//ll_ShipChangesCount = lds_ShipChanges.retrieve()
//if ll_ShipChangesCount = -1 then
//	rollback ;
//	lb_Failed = true
//	goto ship_cleanup
//else
//	commit ;
//end if
//
//
//if ll_ShipChangesCount > 0 then
//
//	IF This.of_PopulateExtendedShipmentData ( lds_ShipChanges ) = 1 THEN
//		//OK
//	ELSE
//		lb_Failed = TRUE
//		GOTO ship_cleanup
//	END IF
//
//	ldwo_ShipChangesTimestamp = lds_ShipChanges.object.cs_timestamp
//
//	for ll_ShipRow = 1 to ll_ShipChangesCount
//		ls_CheckTimestamp = ldwo_ShipChangesTimestamp.primary[ll_ShipRow]
//		if ls_CheckTimestamp > ls_MaxTimestamp then ls_MaxTimestamp = ls_CheckTimestamp
//	next
//
//	if gf_rows_sync(lds_ShipChanges, null_dw, sds_ship, null_dw, primary!, true, true) = 1 then
//		lb_ShipmentCacheChanges = TRUE
//	else
//		lb_Failed = true
//		goto ship_cleanup
//	end if
//
//end if
//
//ship_cleanup:
//
//if lb_Failed and ab_RefreshTrips then
//	sds_trip.reset()
//	if isvalid(lds_TripBackup) then
//		if lds_TripBackup.rowcount() > 0 then &
//			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
//	end if
//end if
//
//DESTROY lds_TripBackup
//DESTROY lds_ShipChanges
//DESTROY lds_ShipIds
//DESTROY ldwo_ShipChangesTimestamp
//DESTROY ldwo_CheckTimestamp
//DESTROY ldwo_CacheTimestamp
//DESTROY ldwo_CheckId
//DESTROY ldwo_CacheId
//
//if lb_Failed then
//	return -1
//else
//	sb_ships_retrieved = true
//	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
//		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
//		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
//		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
//		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
//		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
//		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
//			ss_ships_last_change = ls_MaxTimestamp
//		END IF
//	END IF
//	sdt_ships_refreshed = datetime(today(), now())
//	sdt_ships_updated = sdt_ships_refreshed
//	if ab_RefreshTrips then
//		sb_trips_retrieved = true
//		sdt_trips_refreshed = sdt_ships_refreshed
//		sdt_trips_updated = sdt_ships_refreshed
//	end if
//
//	IF lb_ShipmentCacheChanges THEN
//
//		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
//			//This workstation has written the file out within the last hour -- don't do it this time
//
//		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
//			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
//				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
//			END IF
//		END IF
//
//	END IF
//
//	return 1
//end if
//
//Revised 4.0.45 9/1/05 BKW to cross check timestamps already retrieved in the cache
//with timestamps that come in from the id check.  Dirty reads were occasionally getting lodged 
//in the cache.  This change will cause this situation to be recognized and corrected.

boolean lb_Failed

setpointer(hourglass!)

DataStore lds_ShipChanges, lds_ShipIds, lds_TripBackup
DWObject ldwo_ShipChangesTimestamp, ldwo_CheckId, ldwo_CacheId, ldwo_CheckTimestamp, ldwo_CacheTimestamp

long ll_CurrentShipmentCount, ll_CacheCount, ll_ShipChangesCount, ll_CheckRow, ll_CacheRow, &
	ll_CheckId, ll_CacheId, ll_TimestampRetrCount, lla_TimestampRetrIds[]
string ls_Select, ls_CheckTimestamp, ls_MaxTimestamp, ls_TimestampInClause

String	ls_ShipmentCacheFile
Long		ll_ShipRow
Boolean	lb_ShipmentCacheChanges, &
			lb_CheckTimestamps
n_cst_DateTime		lnv_DateTime
n_cst_Sql			lnv_Sql

if ab_RefreshTrips then
	if sds_trip.rowcount() > 0 then
		lds_TripBackup = create datastore
		lds_TripBackup.dataobject = "d_trip_list"
		lds_TripBackup.object.data.primary = sds_trip.object.data.primary
	end if
	if sds_trip.retrieve() = -1 then
		rollback ;
		lb_Failed = true
		if lb_Failed and ab_RefreshTrips then
	sds_trip.reset()
	if isvalid(lds_TripBackup) then
		if lds_TripBackup.rowcount() > 0 then &
			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
	end if
end if

DESTROY lds_TripBackup
DESTROY lds_ShipChanges
DESTROY lds_ShipIds
DESTROY ldwo_ShipChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_ships_retrieved = true
	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
			ss_ships_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_ships_refreshed = datetime(today(), now())
	sdt_ships_updated = sdt_ships_refreshed
	if ab_RefreshTrips then
		sb_trips_retrieved = true
		sdt_trips_refreshed = sdt_ships_refreshed
		sdt_trips_updated = sdt_ships_refreshed
	end if

	IF lb_ShipmentCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
			END IF
		END IF

	END IF

	return 1
end if


	else
		commit ;
	end if
end if


//If it's been at least 30 minutes since last refresh (which will include the first attempt, due to the
//way sdt_ships_refreshed is initialized), attempt to load the most recent cache from the cachefile.
//If it hasn't been at least that long, just do the manual refresh.
//If this doesn't succeed, we'll just pull the whole list manually.
//Note: Calling of_LoadShipmentCacheFromFile will call of_GetShipmentCacheFile, which will initialize
//the values for ss_ShipmentCacheCode and ss_ShipmentCacheWhereClauseExtension

IF lnv_DateTime.of_SecondsAfter ( sdt_Ships_Refreshed, DateTime ( Today ( ), Now ( ) ) ) > 1800 THEN
	//optimize performance , comment by appeon 20080801
	//This.of_LoadShipmentCacheFromFile ( )
	
END IF


//Creation and determination of select statement for lds_ShipChanges was here prior to 4.0.45  Moved 9/1/05 BKW


//This section will see if any rows in the cache should no longer be there (due to deletion,
//the fact that they are no longer in current shipments, or -- if this is a custom cache -- the 
//fact that they no longer meet the criteria for this custom cache.)

//We're going to retrieve a list of all the ids that currently qualify for this cache, and if 
//there's any rows in the cache not in this id list, we'll remove them.

ll_CacheCount = sds_ship.rowcount()

if ll_CacheCount > 0 then

	lds_ShipIds = create datastore
	lds_ShipIds.dataobject = "d_current_shipment_ids"
	lds_ShipIds.settransobject(sqlca)
	lds_ShipIds.setsort("cs_id A")


	//Added 3.5.19 BKW.  Limit the retrieve to the criteria for the custom cache (if any.)
	//(This had been omitted between 3.5.15 and 3.5.18, and was causing rows not to drop
	//out of a custom cache if they no longer met custom cache criteria.)
	
	IF Len ( ss_ShipmentCacheWhereClauseExtension ) > 0 THEN
		ls_Select = lds_ShipIds.object.datawindow.table.select
		ls_Select += " AND ( " + ss_ShipmentCacheWhereClauseExtension + " )"
		lds_ShipIds.object.datawindow.table.select = ls_Select
	END IF


	ll_CurrentShipmentCount = lds_ShipIds.retrieve()
	if ll_CurrentShipmentCount = -1 then
		rollback ;
		lb_Failed = true
		if lb_Failed and ab_RefreshTrips then
	sds_trip.reset()
	if isvalid(lds_TripBackup) then
		if lds_TripBackup.rowcount() > 0 then &
			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
	end if
end if

DESTROY lds_TripBackup
DESTROY lds_ShipChanges
DESTROY lds_ShipIds
DESTROY ldwo_ShipChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_ships_retrieved = true
	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
			ss_ships_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_ships_refreshed = datetime(today(), now())
	sdt_ships_updated = sdt_ships_refreshed
	if ab_RefreshTrips then
		sb_trips_retrieved = true
		sdt_trips_refreshed = sdt_ships_refreshed
		sdt_trips_updated = sdt_ships_refreshed
	end if

	IF lb_ShipmentCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
			END IF
		END IF

	END IF

	return 1
end if


	elseif ll_CurrentShipmentCount = 0 then
		commit ;
		sds_ship.reset()
		lb_ShipmentCacheChanges = TRUE
		if lb_Failed and ab_RefreshTrips then
	sds_trip.reset()
	if isvalid(lds_TripBackup) then
		if lds_TripBackup.rowcount() > 0 then &
			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
	end if
end if

DESTROY lds_TripBackup
DESTROY lds_ShipChanges
DESTROY lds_ShipIds
DESTROY ldwo_ShipChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_ships_retrieved = true
	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
			ss_ships_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_ships_refreshed = datetime(today(), now())
	sdt_ships_updated = sdt_ships_refreshed
	if ab_RefreshTrips then
		sb_trips_retrieved = true
		sdt_trips_refreshed = sdt_ships_refreshed
		sdt_trips_updated = sdt_ships_refreshed
	end if

	IF lb_ShipmentCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
			END IF
		END IF

	END IF

	return 1
end if


	end if

end if


//Retrieve of lds_ShipChanges was here prior to 4.0.45.  Moved below 4.0.45 9/1/05 BKW
//The move is so that any shipments in the cache whose timestamp is less than the ss_ships_last_change
//(the max timestamp in the cache) but does not match the timestamp in the table can be identified 
//and forced to be included in the refresh.


//Record in a boolean whether we have the info we need to do timestamp comparisons, for fast access in loop.

IF sb_ships_retrieved and len(ss_ships_last_change) > 0 THEN
	lb_CheckTimestamps = TRUE
END IF


if ll_CacheCount > 0 and ll_CurrentShipmentCount > 0 then
	
	sds_ship.setsort("ds_id A")
	sds_ship.sort()
	ll_CheckRow = 1
	ll_CacheRow = 1
	ldwo_CheckId = lds_ShipIds.object.cs_id
	ldwo_CacheId = sds_ship.object.ds_id
	
	ldwo_CheckTimestamp = lds_ShipIds.Object.cs_timestamp
	ldwo_CacheTimestamp = sds_Ship.Object.cs_timestamp
	
	do
		
		ll_CheckId = ldwo_CheckId.primary[ll_CheckRow]

		do

			ll_CacheId = ldwo_CacheId.primary[ll_CacheRow]
			
			if ll_CacheId < ll_CheckId then
				sds_ship.rowsdiscard(ll_CacheRow, ll_CacheRow, primary!)
				ll_CacheCount --
				lb_ShipmentCacheChanges = TRUE
				continue
			elseif ll_CacheId > ll_CheckId then
				exit
			else
				
				//Added 4.0.45 9/1/05 BKW
				//The ids match.  Cross-check the timestamps.  If the timestamp in the table is 
				//greater than the ss_ships_last_change timestamp, that row will be refreshed normally
				//due to the timestamp criteria.  If the timestamp in the table is <= ss_ships_last_change 
				//AND it is DIFFERENT from the timestamp in the cache, this is an update that got skipped
				//over due to a dirty read and we need to record that id so we can include that id explicitly 
				//in the refresh request.  (Note:  We could actually just record all the ids whose timestamps,
				//don't match but I thought it would be better to avoid that for performance reasons.)
				
				//Changing isolation level for these queries to prevent dirty reads in the first place is probably 
				//not a viable option since the query would wait for all write locks on the rows being queried to
				//be released, which could severely degrade performance.  So, this approach does not attempt to
				//prevent a dirty read, but rather to "catch it" on the next pass and correct the data.
				
				//This change was implemented due to some occasional dirty read scenarios in the field.
				
				IF lb_CheckTimestamps THEN  	//If we don't have ss_ships_last_change, can't do these comparisons
														//In that case, all rows will be refreshed later, so it's ok.
				
					ls_CheckTimeStamp = ldwo_CheckTimeStamp.Primary [ ll_CheckRow ]
					
					IF ls_CheckTimeStamp > ss_ships_last_change THEN
						
						//OK, change will be caught by timestamp comparison in where clause
						
					ELSEIF ls_CheckTimeStamp = ldwo_CacheTimeStamp.Primary [ ll_CacheRow ] THEN
						
						//OK, the timestamp in the cache matches the timestamp in the table.
						//No change needed.
						
					ELSE
						//The timestamp in the cache is less than the timestamp in the table,
						//but is less than the max timestamp in the cache.  Need to force retrieval
						//for this id.
						
						ll_TimestampRetrCount ++
						lla_TimestampRetrIds [ ll_TimestampRetrCount ] = ll_CacheId
						
					END IF
					
				END IF
				
				//////End 4.0.45 addition
				
				ll_CacheRow ++
			end if
			
		loop while ll_CacheRow <= ll_CacheCount
		
		if ll_CacheRow > ll_CacheCount then exit
		
		ll_CheckRow ++
		
	loop while ll_CheckRow <= ll_CurrentShipmentCount
	
	if ll_CacheRow <= ll_CacheCount then
		sds_ship.rowsdiscard(ll_CacheRow, ll_CacheCount, primary!)
		ll_CacheCount = ll_CacheRow - 1
		lb_ShipmentCacheChanges = TRUE
	end if
	
end if


//Moved from earlier position 4.0.45 9/1/05 BKW   
//Changed position in order to include the problem-timestamp ids from the preceding section in the where clause.

lds_ShipChanges = create datastore
lds_ShipChanges.dataobject = "d_current_shipments"
lds_ShipChanges.settransobject(sqlca)

ls_Select = lds_ShipChanges.object.datawindow.table.select

//if sb_ships_retrieved and len(ss_ships_last_change) > 0 then
IF lb_CheckTimestamps THEN   //This boolean now captures the condition above.

	IF ll_TimestampRetrCount > 0 THEN
		ls_TimestampInClause = lnv_Sql.of_MakeInClause ( lla_TimestampRetrIds )
	END IF

	ls_Select += " AND "
	

	IF Len ( ls_TimestampInClause ) > 0 THEN
		ls_Select += "( ( ~~~"current_shipments~~~".~~~"cs_id~~~" " + ls_TimestampInClause + " ) OR "
	END IF
	
	ls_Select += "( ~~~"current_shipments~~~".~~~"timestamp~~~" > ~'" + ss_ships_last_change + "~' )"
	
	IF Len ( ls_TimestampInClause ) > 0 THEN
		ls_Select += " )"  //Close the additional parenthesis opened due to the OR condition.
	END IF
	
end if
	

//Added 3.5.15 BKW.  This was being done as a separate step until 4.0.45, reading the select that had already
//been set, tacking on the additional extension, and setting it back.  I've combined it here.  9/1/05 BKW

IF Len ( ss_ShipmentCacheWhereClauseExtension ) > 0 THEN
	ls_Select += " AND ( " + ss_ShipmentCacheWhereClauseExtension + " )"
END IF

//End of combined code

//Set the assembled select statement onto the datastore.

lds_ShipChanges.object.datawindow.table.select = ls_Select
	



//Moved from earlier position 4.0.45 9/1/05 BKW

ll_ShipChangesCount = lds_ShipChanges.retrieve()
if ll_ShipChangesCount = -1 then
	rollback ;
	lb_Failed = true
	if lb_Failed and ab_RefreshTrips then
	sds_trip.reset()
	if isvalid(lds_TripBackup) then
		if lds_TripBackup.rowcount() > 0 then &
			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
	end if
end if

DESTROY lds_TripBackup
DESTROY lds_ShipChanges
DESTROY lds_ShipIds
DESTROY ldwo_ShipChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_ships_retrieved = true
	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
			ss_ships_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_ships_refreshed = datetime(today(), now())
	sdt_ships_updated = sdt_ships_refreshed
	if ab_RefreshTrips then
		sb_trips_retrieved = true
		sdt_trips_refreshed = sdt_ships_refreshed
		sdt_trips_updated = sdt_ships_refreshed
	end if

	IF lb_ShipmentCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
			END IF
		END IF

	END IF

	return 1
end if


else
	commit ;
end if


if ll_ShipChangesCount > 0 then
	//optimize performance , comment by appeon 20080801
	IF This.of_PopulateExtendedShipmentData ( lds_ShipChanges ) = 1 THEN
		//IF 1 = 1 THEN
		//OK
	ELSE
		lb_Failed = TRUE
		if lb_Failed and ab_RefreshTrips then
	sds_trip.reset()
	if isvalid(lds_TripBackup) then
		if lds_TripBackup.rowcount() > 0 then &
			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
	end if
end if

DESTROY lds_TripBackup
DESTROY lds_ShipChanges
DESTROY lds_ShipIds
DESTROY ldwo_ShipChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_ships_retrieved = true
	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
			ss_ships_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_ships_refreshed = datetime(today(), now())
	sdt_ships_updated = sdt_ships_refreshed
	if ab_RefreshTrips then
		sb_trips_retrieved = true
		sdt_trips_refreshed = sdt_ships_refreshed
		sdt_trips_updated = sdt_ships_refreshed
	end if

	IF lb_ShipmentCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
			END IF
		END IF

	END IF

	return 1
end if


	END IF

	ldwo_ShipChangesTimestamp = lds_ShipChanges.object.cs_timestamp

	for ll_ShipRow = 1 to ll_ShipChangesCount
		ls_CheckTimestamp = ldwo_ShipChangesTimestamp.primary[ll_ShipRow]
		if ls_CheckTimestamp > ls_MaxTimestamp then ls_MaxTimestamp = ls_CheckTimestamp
	next

	if gf_rows_sync(lds_ShipChanges, null_dw, sds_ship, null_dw, primary!, true, true) = 1 then
		lb_ShipmentCacheChanges = TRUE
	else
		lb_Failed = true
		if lb_Failed and ab_RefreshTrips then
	sds_trip.reset()
	if isvalid(lds_TripBackup) then
		if lds_TripBackup.rowcount() > 0 then &
			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
	end if
end if

DESTROY lds_TripBackup
DESTROY lds_ShipChanges
DESTROY lds_ShipIds
DESTROY ldwo_ShipChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_ships_retrieved = true
	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
			ss_ships_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_ships_refreshed = datetime(today(), now())
	sdt_ships_updated = sdt_ships_refreshed
	if ab_RefreshTrips then
		sb_trips_retrieved = true
		sdt_trips_refreshed = sdt_ships_refreshed
		sdt_trips_updated = sdt_ships_refreshed
	end if

	IF lb_ShipmentCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
			END IF
		END IF

	END IF

	return 1
end if


	end if

end if

//ship_cleanup:

if lb_Failed and ab_RefreshTrips then
	sds_trip.reset()
	if isvalid(lds_TripBackup) then
		if lds_TripBackup.rowcount() > 0 then &
			sds_trip.object.data.primary = lds_TripBackup.object.data.primary
	end if
end if

DESTROY lds_TripBackup
DESTROY lds_ShipChanges
DESTROY lds_ShipIds
DESTROY ldwo_ShipChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_ships_retrieved = true
	if ll_ShipChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		IF ls_MaxTimestamp > ss_Ships_Last_Change THEN
			ss_ships_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_ships_refreshed = datetime(today(), now())
	sdt_ships_updated = sdt_ships_refreshed
	if ab_RefreshTrips then
		sb_trips_retrieved = true
		sdt_trips_refreshed = sdt_ships_refreshed
		sdt_trips_updated = sdt_ships_refreshed
	end if

	IF lb_ShipmentCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastShipmentCacheWrite, sdt_Ships_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetShipmentCacheFile ( ls_ShipmentCacheFile ) = 1 THEN
			IF sds_Ship.SaveAs ( ls_ShipmentCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastShipmentCacheWrite = sdt_Ships_Refreshed  /*Now*/
			END IF
		END IF

	END IF

	return 1
end if


end function

private function integer of_populateeventstructure (datastore ads_source, long al_row, ref os_event astr_target);//Modified 3.6.00 BKW to set "Assigned" if routed to 3rd party trip.

os_Event	lstr_Event
Integer	li_Return

IF al_Row > 0 AND al_Row <= ads_Source.RowCount ( ) THEN
	lstr_Event.il_Id = ads_Source.Object.de_id [ al_Row ]
	lstr_Event.is_Type = ads_Source.Object.de_event_type [ al_Row ]
	lstr_Event.il_Site = ads_Source.Object.de_site [ al_Row ]
	lstr_Event.id_Appointment = ads_Source.Object.de_apptdate [ al_Row ]
	lstr_Event.it_Appointment = ads_Source.Object.de_appttime [ al_Row ]
	lstr_Event.id_Arrive = ads_Source.Object.de_arrdate [ al_Row ]
	lstr_Event.it_Arrive = ads_Source.Object.de_arrtime [ al_Row ]
	lstr_Event.it_Depart = ads_Source.Object.de_deptime [ al_Row ]
	lstr_Event.is_Confirmed = ads_Source.Object.de_Conf [ al_Row ]

	IF NOT IsNull ( ads_Source.Object.de_Tractor [ al_Row ] ) THEN
		lstr_Event.is_Assigned = "T"
	ELSEIF NOT IsNull ( ads_Source.Object.de_Driver [ al_Row ] ) THEN
		lstr_Event.is_Assigned = "T"
	ELSEIF NOT IsNull ( ads_Source.Object.de_Trailer [ al_Row ] ) THEN  //Added 3.6.00 BKW : capture 3rd party trip.
		lstr_Event.is_Assigned = "T"
	ELSE
		lstr_Event.is_Assigned = "F"
	END IF

	IF IsNull ( lstr_Event.id_Arrive ) OR IsNull ( lstr_Event.it_Arrive ) THEN
		lstr_Event.is_Arrived = "F"
	ELSE
		lstr_Event.is_Arrived = "T"
	END IF

	IF ads_Source.Object.de_Status [ al_Row ] = "T" THEN
		lstr_Event.is_Dispatched = "T"
	ELSE
		lstr_Event.is_Dispatched = "F"
	END IF

	li_Return = 1
ELSE
	This.of_PopulateEventStructure ( lstr_Event )
	li_Return = -1
END IF

astr_Target = lstr_Event

RETURN li_Return
end function

public function integer of_updateequipment (long ala_ids[]);Long	lla_Ids[], &
		ll_Count, &
		ll_Ndx, &
		ll_EquipId, &
		ll_ShipRow, &
		ll_ShipCount
Boolean	lb_Matched, &
			lb_Changes
os_Event	lstr_Event

CONSTANT Boolean	lb_ForceRefresh = FALSE

IF sb_Ships_Retrieved = FALSE THEN
	RETURN 0
END IF

lla_Ids = ala_Ids
n_cst_anyarraysrv lnv_anyarray
ll_Count = lnv_anyarray.of_GetShrinked( lla_Ids, "NULLS~tDUPES" )

ll_ShipCount = sds_ship.RowCount ( )

FOR ll_Ndx = 1 TO ll_Count

	ll_EquipId = lla_Ids [ ll_Ndx ]
	ll_ShipRow = 0
	lb_Matched = FALSE

	DO
		ll_ShipRow = sds_ship.Find ( "cc_Equip_Id = " + String ( ll_EquipId ), ll_ShipRow + 1, ll_ShipCount )

		IF ll_ShipRow > 0 THEN

			lb_Changes = TRUE

			IF lb_Matched = FALSE THEN
				of_GetEquipmentEvent ( ll_EquipId, lstr_Event, lb_ForceRefresh )
				lb_Matched = TRUE
			END IF

			of_WriteEventInfo ( sds_ship, ll_ShipRow, "CurrentEvent!", lstr_Event )

		END IF

	LOOP WHILE ll_ShipRow > 0 AND ll_ShipRow < ll_ShipCount

NEXT

IF lb_Changes THEN
	sdt_Ships_Updated = DateTime ( Today ( ), Now ( ) )
END IF

RETURN 1
end function

private function integer of_getequipmentevent (long al_id, ref os_event astr_event, boolean ab_forcerefresh);Integer		li_Return
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
n_cst_EquipmentManager lnv_EquipmentMgr

//First, populate blank in case subsequent conditions aren't met
of_PopulateEventStructure ( astr_event )

IF ab_ForceRefresh THEN
	lnv_EquipmentMgr.of_Cache ( al_Id, TRUE )
END IF

IF lnv_EquipmentMgr.of_GetCurrentEvent ( al_Id, lnv_Msg ) = 1 THEN

	//Unload data from message into event structure

	IF lnv_Msg.of_Get_Parm ( "ID", lstr_Parm ) > 0 THEN
		astr_event.il_Id = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "TYPE", lstr_Parm ) > 0 THEN
		astr_event.is_Type = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "SITE", lstr_Parm ) > 0 THEN
		astr_event.il_Site = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "ARRDATE", lstr_Parm ) > 0 THEN
		astr_event.id_Arrive = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "ARRTIME", lstr_Parm ) > 0 THEN
		astr_event.it_Arrive = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "DEPTIME", lstr_Parm ) > 0 THEN
		astr_event.it_Depart = lstr_Parm.ia_Value
	END IF

	SetNull ( astr_event.id_Appointment )
	SetNull ( astr_event.it_Appointment )

	li_Return = 1

ELSE

	li_Return = -1

END IF

RETURN li_Return
end function

private function integer of_populateeventstructure (ref os_event astr_event);SetNull ( astr_Event.il_Id )
SetNull ( astr_Event.is_Type )
SetNull ( astr_Event.il_Site )
SetNull ( astr_Event.id_Appointment )
SetNull ( astr_Event.it_Appointment )
SetNull ( astr_Event.id_Arrive )
SetNull ( astr_Event.it_Arrive )
SetNull ( astr_Event.it_Depart )
SetNull ( astr_Event.is_Confirmed )
SetNull ( astr_Event.is_Assigned )
SetNull ( astr_Event.is_Dispatched )
SetNull ( astr_Event.is_Arrived )

RETURN 1
end function

private function integer of_writeeventinfo (datastore ads_target, long al_row, string as_type, os_event astr_event);s_Co_Info	lstr_Company
String		ls_Location

gnv_cst_Companies.of_Get_Info ( astr_Event.il_Site, lstr_Company, FALSE )
ls_Location = gnv_cst_Companies.of_Make_Location ( lstr_Company.co_City, lstr_Company.co_State )

CHOOSE CASE as_Type

CASE "NextStop!"

	//NOTE : This part is not currently being used.  Before it can be, it needs to be
	//updated to use the Appointment / Arrive distinction now coded in of_RefreshShipments.

	ads_Target.SetItem ( al_Row, "cc_NextEvent_Id", astr_Event.il_Id )
	ads_Target.SetItem ( al_Row, "cc_NextEvent_Type", astr_Event.is_Type )
	ads_Target.SetItem ( al_Row, "cc_NextEvent_Site", astr_Event.il_Site )
	ads_Target.SetItem ( al_Row, "cc_NextEvent_Date", astr_Event.id_Appointment )
	ads_Target.SetItem ( al_Row, "cc_NextEvent_Time", astr_Event.it_Appointment )

	ads_Target.SetItem ( al_Row, "cc_NextEvent_Company", lstr_Company.co_Name )
	ads_Target.SetItem ( al_Row, "cc_NextEvent_City", lstr_Company.co_City )
	ads_Target.SetItem ( al_Row, "cc_NextEvent_State", lstr_Company.co_State )
	ads_Target.SetItem ( al_Row, "cc_NextEvent_Location", ls_Location )

CASE "CurrentEvent!"

	ads_Target.SetItem ( al_Row, "cc_CurEvent_Id", astr_Event.il_Id )
	ads_Target.SetItem ( al_Row, "cc_CurEvent_Type", astr_Event.is_Type )
	ads_Target.SetItem ( al_Row, "cc_CurEvent_Site", astr_Event.il_Site )
	ads_Target.SetItem ( al_Row, "cc_CurEvent_Date", astr_Event.id_Arrive )
	ads_Target.SetItem ( al_Row, "cc_CurEvent_Time", astr_Event.it_Arrive )

	ads_Target.SetItem ( al_Row, "cc_CurEvent_Company", lstr_Company.co_Name )
	ads_Target.SetItem ( al_Row, "cc_CurEvent_City", lstr_Company.co_City )
	ads_Target.SetItem ( al_Row, "cc_CurEvent_State", lstr_Company.co_State )
	ads_Target.SetItem ( al_Row, "cc_CurEvent_Location", ls_Location )

END CHOOSE

RETURN 1
end function

public function n_ds of_get_ds_ship ();return sds_ship
end function

public function n_ds of_get_ds_trip ();return sds_trip
end function

public function boolean of_get_retrieved_ships ();return sb_ships_retrieved
end function

public function boolean of_get_retrieved_trips ();return sb_trips_retrieved
end function

public function datetime of_get_refreshed_ships ();return sdt_ships_refreshed
end function

public subroutine of_set_retrieved_ships (boolean ab_switch);sb_ships_retrieved = ab_switch
end subroutine

public subroutine of_set_retrieved_trips (boolean ab_switch);sb_trips_retrieved = ab_switch
end subroutine

public function datetime of_get_refreshed_trips ();return sdt_trips_refreshed
end function

public function datetime of_get_updated_ships ();return sdt_ships_updated
end function

public function datetime of_get_updated_trips ();return sdt_trips_updated
end function

public subroutine of_set_refreshed_ships (datetime adt_datetime);sdt_ships_refreshed = adt_datetime
end subroutine

public subroutine of_set_refreshed_trips (datetime adt_datetime);sdt_trips_refreshed = adt_datetime
end subroutine

public subroutine of_set_updated_trips (datetime adt_datetime);sdt_trips_updated = adt_datetime
end subroutine

public subroutine of_set_updated_ships (datetime adt_datetime);sdt_ships_updated = adt_datetime
end subroutine

public function string of_get_lastchange_ships ();return ss_ships_last_change
end function

public subroutine of_set_lastchange_ships (string as_datetime);ss_ships_last_change = as_datetime
end subroutine

public function integer of_get_filter_ships ();return si_ships_filter
end function

public subroutine of_set_filter_ships (integer ai_filter);si_ships_filter = ai_filter
end subroutine

public function integer of_preparesummarydisplay (readonly datawindow adw_target);//Returns:  1, -1

n_cst_Privileges	lnv_Privileges
Integer	li_Return = 1

IF IsValid ( adw_Target ) THEN

	IF lnv_Privileges.of_ShipmentSummary_ViewTotalCharges ( ) = FALSE THEN
	
		adw_Target.Modify ( "comp_custbill_tot.Visible=0 comp_custbill_tot_t.Visible=0" )
	
	END IF

ELSE
	li_Return = -1

END IF


RETURN li_Return
end function

public function integer of_getfuelsurcharge (ref decimal ac_fuelsurcharge);//Returns:   1 = Success (value returned by reference in ac_FuelSurcharge)
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

Decimal	lc_FuelSurcharge
Integer	li_SqlCode

Integer	li_Return = 1


//Attempt to retrieve Fuel Surcharge Value from database

SELECT ss_Dec INTO :lc_FuelSurcharge FROM System_Settings WHERE ss_Id = 28 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	
	
	// added the = to the > to make >= be an ok value.
	// this is because we want to have the ability to have the mojority of companies
	// without a fsc and a couple with an override. 
	IF lc_FuelSurcharge >= 0 THEN
		//Value is OK
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	ac_FuelSurcharge = lc_FuelSurcharge
ELSE
	SetNull ( ac_FuelSurcharge )
END IF

RETURN li_Return
end function

public subroutine of_opentrip (readonly long al_id);Date					ld_Null
w_Dispatch			lw_Dispatch
n_cst_AppServices	lnv_AppServices
n_cst_msg			lnv_Msg
S_Parm				lstr_Parm

SetNull ( ld_Null )

lstr_Parm.is_Label = "CATEGORY"
lstr_Parm.ia_Value = "ITIN"
lnv_msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "TYPE"
lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Trip
lnv_msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "ID"
lstr_Parm.ia_Value = al_Id
lnv_msg.of_Add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "DATE"
lstr_Parm.ia_Value =  ld_Null
lnv_msg.of_Add_Parm ( lstr_Parm ) 


OpenSheetWithParm ( lw_Dispatch, lnv_msg, lnv_AppServices.of_GetFrame ( ), 0, LAYERED! )
end subroutine

public function long of_newtrip ();//Long	ll_TripId
//n_cst_numerical lnv_numerical
//
////These are placeholders, in case we want to provide options
//Boolean	lb_OpenTrip = TRUE
//Boolean	lb_Notify = TRUE
//n_cst_privileges	lnv_Privs
//IF NOT lnv_Privs.of_HasEntryRights () THEN
//	Messagebox ( "New Shipment" , "You are not authorized to create new shipments." )
//	RETURN -1
//END IF
//select max(bt_id) into :ll_TripId from brok_trips ;
//if sqlca.sqlcode <> 0 then goto failure
//if lnv_numerical.of_IsNullOrNeg(ll_TripId) then ll_TripId = 0
//
//ll_TripId ++
//
//insert into brok_trips (bt_id, bt_pmtstatus, bt_pay_format)
//	values (:ll_TripId, 'K', 'U') ;
//
//if sqlca.sqlcode <> 0 then goto failure
//commit ;
//if sqlca.sqlcode <> 0 then goto failure
//
//IF lb_OpenTrip THEN
//	This.of_OpenTrip ( ll_TripId )
//END IF
//
//return ll_TripId
//
//failure:
//
//rollback ;
//
//IF lb_Notify THEN
//	messagebox("Add New Trip", "Could not add new trip to database -- Please retry.", &
//		exclamation!)
//END IF
//
//return -1
Long	ll_TripId
n_cst_numerical lnv_numerical

//These are placeholders, in case we want to provide options
Boolean	lb_OpenTrip = TRUE
Boolean	lb_Notify = TRUE
n_cst_privileges	lnv_Privs
IF NOT lnv_Privs.of_HasEntryRights () THEN
	Messagebox ( "New Shipment" , "You are not authorized to create new shipments." )
	RETURN -1
END IF
select max(bt_id) into :ll_TripId from brok_trips ;
if sqlca.sqlcode <> 0 then
	rollback ;

IF lb_Notify THEN
	messagebox("Add New Trip", "Could not add new trip to database -- Please retry.", &
		exclamation!)
END IF

return -1
end if	
if lnv_numerical.of_IsNullOrNeg(ll_TripId) then ll_TripId = 0

ll_TripId ++

insert into brok_trips (bt_id, bt_pmtstatus, bt_pay_format)
	values (:ll_TripId, 'K', 'U') ;

if sqlca.sqlcode <> 0 then 
	rollback ;

IF lb_Notify THEN
	messagebox("Add New Trip", "Could not add new trip to database -- Please retry.", &
		exclamation!)
END IF

return -1
end if	
commit ;
if sqlca.sqlcode <> 0 then
	rollback ;

IF lb_Notify THEN
	messagebox("Add New Trip", "Could not add new trip to database -- Please retry.", &
		exclamation!)
END IF

return -1
end if	

IF lb_OpenTrip THEN
	This.of_OpenTrip ( ll_TripId )
END IF

return ll_TripId

//failure:
//
//rollback ;
//
//IF lb_Notify THEN
//	messagebox("Add New Trip", "Could not add new trip to database -- Please retry.", &
//		exclamation!)
//END IF
//
//return -1
end function

public function boolean of_shipmentexists (readonly long al_id);//Returns:  TRUE, FALSE, Null = Error, cannot determine

Long	ll_Test
Boolean	lb_Result

SELECT ds_id INTO :ll_Test FROM disp_ship WHERE ds_id = :al_Id ;

CHOOSE CASE SQLCA.SqlCode

CASE 0
	lb_Result = TRUE

CASE 100
	lb_Result = FALSE

CASE ELSE
	SetNull ( lb_Result )

END CHOOSE

COMMIT ;

RETURN lb_Result
end function

public function integer of_getcustomfuelsurchargedescription (ref string as_description);//Returns:   1 = Success (value returned by reference in ac_FuelSurcharge)
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1


//Attempt to retrieve Fuel Surcharge Value from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 30 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	as_Description = ls_Description
ELSE
	SetNull ( as_Description )
END IF

RETURN li_Return
end function

public function datastore of_createshipmententries (ref n_cst_msg anv_msg);//// RDT 7-17-03 Added Parent id to shipment if in message object
//// MFS 5/15/06 Added user default division (shiptype) lookup
//
//Long			ll_ParentShipID 		// RDT 7-17-03 
//
//Long			ll_NextId, &
//				ll_Row, &
//				ll_ShipType, &
//				ll_Work
//DataStore	lds_Target
//String		ls_Category, &
//				ls_Style, &
//				ls_Expedite, &
//				ls_ModLog, &
//				ls_Pronum
//Date			ld_Today
//Time			lt_Now
//Boolean		lb_UserDefaultShipType
//
//s_Parm		lstr_Parm
//
//n_cst_Ship_Type		lnv_ShipType
//n_cst_beo_ShipType	lnv_ShipTypeBeo
//n_cst_privsManager	lnv_manager
//
//n_cst_Conversion		lnv_Conversion
//
//n_cst_setting_advancedprivs	lnv_AdvancedPrivSetting
//
//
//ls_Category = "DISPATCH"	//Unless overridden later
//ls_expedite = "F"				//Unless overridden later
//
//ld_Today = Date ( DateTime ( Today ( ) )) 
//lt_now = Now ( )
//
//
//IF anv_Msg.of_Get_Parm ( "Style", lstr_Parm ) > 0 THEN
//	ls_Style = lstr_Parm.ia_Value
//ELSE
//	ls_Style = "STANDARD!"
//END IF
//
//IF anv_Msg.of_Get_Parm ( "PARENTSHIPMENTID" , lstr_Parm ) <> 0 THEN		// RDT 7-17-03 
//	ll_ParentShipID = lstr_Parm.ia_Value 											// RDT 7-17-03 
//ELSE 																							// RDT 7-17-03 
//	SetNull( ll_ParentShipID )															// RDT 7-17-03 
//END IF																						// RDT 7-17-03 
//
//
//CHOOSE CASE ls_Style
//CASE "STANDARD!"
//CASE "CONTAINER!" 
//	ls_Category = "INTERMODAL"
//CASE "CROSSDOCK!"
//CASE "NONROUTED!"
//CASE "BROKERAGE!", "NONROUTEDBROKERAGE!"	
//	ls_Category = "BROKERAGE"
//CASE "EMPTY!"
//	// this is used by edi
//CASE ELSE
//	GOTO CleanUp
//END CHOOSE
//
////Check if we should look up ship types by user defaults
////lnv_AdvancedPrivSetting	= CREATE n_cst_setting_AdvancedPrivs 
//lnv_manager = gnv_app.of_getprivsmanager( )
////modified by Dan 5-31-2006
//IF lnv_manager.of_useadvancedprivs( ) /*lnv_AdvancedPrivSetting.of_GetValue( ) = n_cst_setting_AdvancedPrivs.cs_Yes */THEN
//	lb_UserDefaultShipType = TRUE
//END IF
////Destroy	lnv_AdvancedPrivSetting
//
//IF lb_UserDefaultShipType THEN
//	
//	CHOOSE CASE ls_Style //user default divisions will support the following
//	CASE "CROSSDOCK!"
//		ls_Category = "CROSSDOCK"
//	CASE "NONROUTED!"
//		ls_Category = "NONROUTED"
//	CASE "NONROUTEDBROKERAGE!"
//		ls_Category = "NONROUTEDBROKERAGE"
//	END CHOOSE
//	
//	//Get shiptype (division) id from user defaults
//	lnv_ShipType.of_GetEmployeeDivisionDefault(ls_Category, lnv_ShipTypeBeo)
//	IF isValid(lnv_ShipTypeBeo) THEN
//		IF lnv_manager.of_Getuserpermissionfromfn( "ModifyShipment", lnv_ShipTypeBeo.of_getid( ) ) = lnv_Manager.ci_true THEN
//			ll_ShipType = lnv_ShipTypeBeo.of_GetId()
//			IF lnv_ShipTypeBeo.of_isExpedite() THEN
//				ls_Expedite = "T"
//			END IF
//		ELSE
//			SetNull(ll_Shiptype)
//			MessageBox("Create Shipment", "You have conflicting settings between your default Shipment Type and privileges for that Shipment Type.", &
//						Exclamation!, OK!)
//			GOTO CleanUp			
//		END IF
//	ELSE
//		SetNull(ll_Shiptype)
//		MessageBox("Create Shipment", "Your division default privilege is not properly set up.", &
//						Exclamation!, OK!)
//		GOTO CleanUp
//	END IF
//	
//ELSE
//
//	//!! This is bad access policy, and should be changed.
//	CHOOSE CASE lnv_ShipType.of_Find_Default ( ls_Category, ll_Row )
//	CASE 1
//		ll_ShipType = gds_ShipType.Object.st_Id [ ll_Row ]
//		IF gds_ShipType.Object.st_Expedite [ ll_Row ] = "T" THEN
//			ls_Expedite = "T"
//		END IF
//	CASE 0
//		SetNull ( ll_ShipType )
//	CASE -1
//		GOTO CleanUp
//	END CHOOSE
//	
//END IF
//
//ls_ModLog = String ( Today ( ), "m/d/yy" ) + "~t" + String ( Now ( ), "h:mmA/P" ) + "~t" +&
//	"CREATED~t~t" + gnv_App.of_GetUserId ( ) + "~r~n"
//
//IF NOT of_GetNextShipmentId ( ll_NextId ) = 1 THEN
//	GOTO CleanUp
//END IF
//
//ls_Pronum = String ( ll_NextId, "0000") + "-TMP"
//
//
//lds_Target = of_CreateShipmentDataStore ( TRUE )
//
//IF IsValid ( lds_Target ) THEN
//
//	ll_Row = lds_Target.InsertRow ( 0 )
//
//	lds_Target.Object.ds_Id [ ll_Row ] = ll_NextId
//	lds_Target.Object.ds_Pronum [ ll_Row ] = ls_Pronum
//	lds_Target.Object.ds_Expedite [ ll_Row ] = ls_Expedite
//	lds_Target.Object.ds_Ship_Type [ ll_Row ] = ll_ShipType
//	lds_Target.Object.ds_Mod_Log [ ll_Row ] = ls_ModLog
//	lds_Target.Object.PrenoteDate [ ll_Row ] = ld_Today
//	lds_Target.Object.prenoteTime [ ll_Row ] = lt_Now
//	lds_Target.Object.prenoteuser [ ll_Row ] = gnv_App.of_GetUserId ( )
//
//	lds_Target.Object.ds_ParentId [ ll_Row ] = ll_ParentShipID // RDT 7-17-03
//	
//	CHOOSE CASE ls_Style
//			
////	CASE "BROKERAGE!"
////
////		lds_Target.Object.ds_Dorb [ ll_Row ] = "B"
////
////		IF anv_Msg.of_Get_Parm ( "BrokerageTrip", lstr_Parm ) > 0 THEN
////			ll_Work = lstr_Parm.ia_Value
////		ELSE
////			SetNull ( ll_Work )
////		END IF
////		lds_Target.Object.ds_Brok_Trip [ ll_Row ] = ll_Work
////
////		IF anv_Msg.of_Get_Parm ( "BrokerageCarrier", lstr_Parm ) > 0 THEN
////			ll_Work = lstr_Parm.ia_Value
////		ELSE
////			SetNull ( ll_Work )
////		END IF
////		lds_Target.Object.ds_Pay1_Id [ ll_Row ] = ll_Work
//	CASE "CONTAINER!"
//		lds_Target.Object.ds_Dorb [ ll_Row ] = "T"
//		IF anv_Msg.of_Get_Parm ( "DIRECTION", lstr_Parm ) > 0 THEN
//			CHOOSE CASE String ( lstr_Parm.ia_Value )
//				CASE "IMPORT"
//					lds_Target.Object.MoveCode [ ll_Row ] = "I"
//				CASE "EXPORT"
//					lds_Target.Object.MoveCode [ ll_Row ] = "E"
//				CASE "ONEWAY"
//					lds_Target.Object.MoveCode [ ll_Row ] = "O"
//			END CHOOSE
//		END IF
//		
//
//	CASE "NONROUTED!", "NONROUTEDBROKERAGE!"	
//		lds_Target.Object.ds_Dorb [ ll_Row ] = "D"
//	CASE ELSE
//		lds_Target.Object.ds_Dorb [ ll_Row ] = "T"
//	END CHOOSE
//
//	lstr_Parm.is_Label = "ShipmentId"
//	lnv_Conversion.of_SetAnyTypeLong ( lstr_Parm.ia_Value )
//	lstr_Parm.ia_Value = ll_NextId
//	anv_Msg.of_Add_Parm ( lstr_Parm )
//
//ELSE
//	GOTO CleanUp
//END IF
//
//
//CleanUp:
//
//RETURN lds_Target
// RDT 7-17-03 Added Parent id to shipment if in message object
// MFS 5/15/06 Added user default division (shiptype) lookup

Long			ll_ParentShipID 		// RDT 7-17-03 

Long			ll_NextId, &
				ll_Row, &
				ll_ShipType, &
				ll_Work
DataStore	lds_Target
String		ls_Category, &
				ls_Style, &
				ls_Expedite, &
				ls_ModLog, &
				ls_Pronum
Date			ld_Today
Time			lt_Now
Boolean		lb_UserDefaultShipType

s_Parm		lstr_Parm

n_cst_Ship_Type		lnv_ShipType
n_cst_beo_ShipType	lnv_ShipTypeBeo
n_cst_privsManager	lnv_manager

n_cst_Conversion		lnv_Conversion

n_cst_setting_advancedprivs	lnv_AdvancedPrivSetting


ls_Category = "DISPATCH"	//Unless overridden later
ls_expedite = "F"				//Unless overridden later

ld_Today = Date ( DateTime ( Today ( ) )) 
lt_now = Now ( )


IF anv_Msg.of_Get_Parm ( "Style", lstr_Parm ) > 0 THEN
	ls_Style = lstr_Parm.ia_Value
ELSE
	ls_Style = "STANDARD!"
END IF

IF anv_Msg.of_Get_Parm ( "PARENTSHIPMENTID" , lstr_Parm ) <> 0 THEN		// RDT 7-17-03 
	ll_ParentShipID = lstr_Parm.ia_Value 											// RDT 7-17-03 
ELSE 																							// RDT 7-17-03 
	SetNull( ll_ParentShipID )															// RDT 7-17-03 
END IF																						// RDT 7-17-03 


CHOOSE CASE ls_Style
CASE "STANDARD!"
CASE "CONTAINER!" 
	ls_Category = "INTERMODAL"
CASE "CROSSDOCK!"
CASE "NONROUTED!"
CASE "BROKERAGE!", "NONROUTEDBROKERAGE!"	
	ls_Category = "BROKERAGE"
CASE "EMPTY!"
	// this is used by edi
CASE ELSE
	RETURN lds_Target
END CHOOSE

//Check if we should look up ship types by user defaults
//lnv_AdvancedPrivSetting	= CREATE n_cst_setting_AdvancedPrivs 
lnv_manager = gnv_app.of_getprivsmanager( )
//modified by Dan 5-31-2006
IF lnv_manager.of_useadvancedprivs( ) /*lnv_AdvancedPrivSetting.of_GetValue( ) = n_cst_setting_AdvancedPrivs.cs_Yes */THEN
	lb_UserDefaultShipType = TRUE
END IF
//Destroy	lnv_AdvancedPrivSetting

IF lb_UserDefaultShipType THEN
	
	CHOOSE CASE ls_Style //user default divisions will support the following
	CASE "CROSSDOCK!"
		ls_Category = "CROSSDOCK"
	CASE "NONROUTED!"
		ls_Category = "NONROUTED"
	CASE "NONROUTEDBROKERAGE!"
		ls_Category = "NONROUTEDBROKERAGE"
	END CHOOSE
	
	//Get shiptype (division) id from user defaults
	lnv_ShipType.of_GetEmployeeDivisionDefault(ls_Category, lnv_ShipTypeBeo)
	IF isValid(lnv_ShipTypeBeo) THEN
		IF lnv_manager.of_Getuserpermissionfromfn( "ModifyShipment", lnv_ShipTypeBeo.of_getid( ) ) = lnv_Manager.ci_true THEN
			ll_ShipType = lnv_ShipTypeBeo.of_GetId()
			IF lnv_ShipTypeBeo.of_isExpedite() THEN
				ls_Expedite = "T"
			END IF
		ELSE
			SetNull(ll_Shiptype)
			MessageBox("Create Shipment", "You have conflicting settings between your default Shipment Type and privileges for that Shipment Type.", &
						Exclamation!, OK!)
			RETURN lds_Target		
		END IF
	ELSE
		SetNull(ll_Shiptype)
		MessageBox("Create Shipment", "Your division default privilege is not properly set up.", &
						Exclamation!, OK!)
		RETURN lds_Target
	END IF
	
ELSE

	//!! This is bad access policy, and should be changed.
	CHOOSE CASE lnv_ShipType.of_Find_Default ( ls_Category, ll_Row )
	CASE 1
		ll_ShipType = gds_ShipType.Object.st_Id [ ll_Row ]
		IF gds_ShipType.Object.st_Expedite [ ll_Row ] = "T" THEN
			ls_Expedite = "T"
		END IF
	CASE 0
		SetNull ( ll_ShipType )
	CASE -1
		RETURN lds_Target
	END CHOOSE
	
END IF

ls_ModLog = String ( Today ( ), "m/d/yy" ) + "~t" + String ( Now ( ), "h:mmA/P" ) + "~t" +&
	"CREATED~t~t" + gnv_App.of_GetUserId ( ) + "~r~n"

IF NOT of_GetNextShipmentId ( ll_NextId ) = 1 THEN
	RETURN lds_Target
END IF

ls_Pronum = String ( ll_NextId, "0000") + "-TMP"


lds_Target = of_CreateShipmentDataStore ( TRUE )

IF IsValid ( lds_Target ) THEN

	ll_Row = lds_Target.InsertRow ( 0 )

	lds_Target.Object.ds_Id [ ll_Row ] = ll_NextId
	lds_Target.Object.ds_Pronum [ ll_Row ] = ls_Pronum
	lds_Target.Object.ds_Expedite [ ll_Row ] = ls_Expedite
	lds_Target.Object.ds_Ship_Type [ ll_Row ] = ll_ShipType
	lds_Target.Object.ds_Mod_Log [ ll_Row ] = ls_ModLog
	lds_Target.Object.PrenoteDate [ ll_Row ] = ld_Today
	lds_Target.Object.prenoteTime [ ll_Row ] = lt_Now
	lds_Target.Object.prenoteuser [ ll_Row ] = gnv_App.of_GetUserId ( )

	lds_Target.Object.ds_ParentId [ ll_Row ] = ll_ParentShipID // RDT 7-17-03
	
	CHOOSE CASE ls_Style
			
//	CASE "BROKERAGE!"
//
//		lds_Target.Object.ds_Dorb [ ll_Row ] = "B"
//
//		IF anv_Msg.of_Get_Parm ( "BrokerageTrip", lstr_Parm ) > 0 THEN
//			ll_Work = lstr_Parm.ia_Value
//		ELSE
//			SetNull ( ll_Work )
//		END IF
//		lds_Target.Object.ds_Brok_Trip [ ll_Row ] = ll_Work
//
//		IF anv_Msg.of_Get_Parm ( "BrokerageCarrier", lstr_Parm ) > 0 THEN
//			ll_Work = lstr_Parm.ia_Value
//		ELSE
//			SetNull ( ll_Work )
//		END IF
//		lds_Target.Object.ds_Pay1_Id [ ll_Row ] = ll_Work
	CASE "CONTAINER!"
		lds_Target.Object.ds_Dorb [ ll_Row ] = "T"
		IF anv_Msg.of_Get_Parm ( "DIRECTION", lstr_Parm ) > 0 THEN
			CHOOSE CASE String ( lstr_Parm.ia_Value )
				CASE "IMPORT"
					lds_Target.Object.MoveCode [ ll_Row ] = "I"
				CASE "EXPORT"
					lds_Target.Object.MoveCode [ ll_Row ] = "E"
				CASE "ONEWAY"
					lds_Target.Object.MoveCode [ ll_Row ] = "O"
			END CHOOSE
		END IF
		

	CASE "NONROUTED!", "NONROUTEDBROKERAGE!"	
		lds_Target.Object.ds_Dorb [ ll_Row ] = "D"
	CASE ELSE
		lds_Target.Object.ds_Dorb [ ll_Row ] = "T"
	END CHOOSE

	lstr_Parm.is_Label = "ShipmentId"
	lnv_Conversion.of_SetAnyTypeLong ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = ll_NextId
	anv_Msg.of_Add_Parm ( lstr_Parm )

ELSE
	RETURN lds_Target
END IF


//CleanUp:

RETURN lds_Target
end function

public function datastore of_createevententries (ref n_cst_msg anv_msg);//Long			ll_NextId, &
//				ll_RowCount, &
//				ll_Row, &
//				ll_ShipmentId, &
//				ll_DockId
//String		ls_Style
//String		ls_Direction 
//
//Long			ll_Pier				//  drop if one way
//Long			ll_FreightLoc		//  hoop if one way
//
//DataStore	lds_Target
//s_Parm		lstr_Parm
//n_cst_Conversion	lnv_Conversion
//n_cst_numerical lnv_numerical
//
//IF anv_Msg.of_Get_Parm ( "Style", lstr_Parm ) > 0 THEN
//	ls_Style = lstr_Parm.ia_Value
//ELSE
//	ls_Style = "STANDARD!"
//END IF
//
//IF anv_Msg.of_Get_Parm ( "ShipmentId", lstr_Parm ) > 0 THEN
//	ll_ShipmentId = lstr_Parm.ia_Value
//END IF
//
//IF lnv_numerical.of_IsNullOrNotPos ( ll_ShipmentId ) THEN
//	GOTO CleanUp
//END IF
//
//lds_Target = of_CreateEventDataStore ( TRUE )
//
//IF IsValid ( lds_Target ) THEN
//
//	CHOOSE CASE ls_Style
//	CASE "STANDARD!", "NONROUTED!", "BROKERAGE!", "NONROUTEDBROKERAGE!"
//		ll_Row = lds_Target.InsertRow ( 0 )
//		lds_Target.Object.de_Event_Type [ ll_Row ] = "P"
//		ll_Row = lds_Target.InsertRow ( 0 )
//		lds_Target.Object.de_Event_Type [ ll_Row ] = "D"
//
//	CASE "CONTAINER!"
//		THIS.of_CreateIntermodalEvents ( anv_Msg , lds_Target )		
//		
//
//	CASE "CROSSDOCK!"
//		IF anv_Msg.of_Get_Parm ( "DockId", lstr_Parm ) > 0 THEN
//			ll_DockId = lstr_Parm.ia_Value
//		END IF
//		IF ll_DockId < 1 THEN
//			SetNull ( ll_DockId )
//		END IF
//
//		ll_Row = lds_Target.InsertRow ( 0 )
//		lds_Target.Object.de_Event_Type [ ll_Row ] = "P"
//		ll_Row = lds_Target.InsertRow ( 0 )
//		lds_Target.Object.de_Event_Type [ ll_Row ] = "D"
//		lds_Target.Object.de_Site [ ll_Row ] = ll_DockId
//		ll_Row = lds_Target.InsertRow ( 0 )
//		lds_Target.Object.de_Event_Type [ ll_Row ] = "P"
//		lds_Target.Object.de_Site [ ll_Row ] = ll_DockId
//		ll_Row = lds_Target.InsertRow ( 0 )
//		lds_Target.Object.de_Event_Type [ ll_Row ] = "D"
//	CASE "EMPTY!"
//		// this is used by edi
//	CASE ELSE
//		DESTROY lds_Target
//		GOTO CleanUp
//	END CHOOSE
//	
//	Time 	lt_Duration
//	String	ls_Duration
//	Time	lt_CoTime
//	Time	lt_SettingTime
//	n_Cst_beo_Company	lnv_Company
//	lnv_Company = CREATE n_cst_beo_Company 
//	lnv_Company.of_SetUsecache( TRUE )
//	SetNull ( lt_SettingTime )
//	n_cst_setting_defaulteventduration lnv_Duration
//	lnv_Duration = CREATE n_cst_setting_defaulteventduration
//	ls_Duration	 = Trim(lnv_Duration.of_GetValue( ))
//	IF IsTime(ls_Duration) THEN
//		lt_SettingTime = Time(ls_Duration)
//	END IF
//	
//	DESTROY ( lnv_Duration )
//
//	ll_RowCount = lds_Target.RowCount ( )
//
//	FOR ll_Row = 1 TO ll_RowCount
//		lt_Duration = lt_SettingTime
//		lnv_Company.of_SetSourceid ( lds_Target.Object.de_Site [ ll_Row ] )
//		lt_CoTime = lnv_Company.of_GetDefaultduration( )
//		IF Not IsNull ( lt_CoTime ) THEN
//			lt_Duration = lt_CoTime
//		END IF
//			
//			
//		
//		IF NOT isNull ( lt_Duration ) THEN
//			lds_Target.Object.de_Duration [ ll_Row ] = lt_Duration
//		END IF
//		
//		of_GetNextEventId ( ll_NextId ) 
//		 
//		lds_Target.Object.de_Id [ ll_Row ] = ll_NextId 
//		lds_Target.Object.de_Shipment_Id [ ll_Row ] = ll_ShipmentId
//		lds_Target.Object.de_Ship_Seq [ ll_Row ] = ll_Row
////		IF ls_Style = "BROKERAGE!" THEN
////			lds_Target.Object.de_Trailer_Seq [ ll_Row ] = 5000
////		END IF
//	NEXT
//
//	lstr_Parm.is_Label = "EventCount"
//	lnv_Conversion.of_SetAnyTypeLong ( lstr_Parm.ia_Value )
//	lstr_Parm.ia_Value = ll_RowCount
//	anv_Msg.of_Add_Parm ( lstr_Parm )
//
//ELSE
//	GOTO CleanUp
//END IF
//
//
//CleanUp:
//
//Destroy ( lnv_Company )
//
//RETURN lds_Target
Long			ll_NextId, &
				ll_RowCount, &
				ll_Row, &
				ll_ShipmentId, &
				ll_DockId
String		ls_Style
String		ls_Direction 

Long			ll_Pier				//  drop if one way
Long			ll_FreightLoc		//  hoop if one way

DataStore	lds_Target
s_Parm		lstr_Parm
n_cst_Conversion	lnv_Conversion
n_cst_numerical lnv_numerical
Time 	lt_Duration
	String	ls_Duration
	Time	lt_CoTime
	Time	lt_SettingTime
	n_Cst_beo_Company	lnv_Company

IF anv_Msg.of_Get_Parm ( "Style", lstr_Parm ) > 0 THEN
	ls_Style = lstr_Parm.ia_Value
ELSE
	ls_Style = "STANDARD!"
END IF

IF anv_Msg.of_Get_Parm ( "ShipmentId", lstr_Parm ) > 0 THEN
	ll_ShipmentId = lstr_Parm.ia_Value
END IF

IF lnv_numerical.of_IsNullOrNotPos ( ll_ShipmentId ) THEN
	Destroy ( lnv_Company )

RETURN lds_Target
END IF

lds_Target = of_CreateEventDataStore ( TRUE )

IF IsValid ( lds_Target ) THEN

	CHOOSE CASE ls_Style
	CASE "STANDARD!", "NONROUTED!", "BROKERAGE!", "NONROUTEDBROKERAGE!"
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "P"
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "D"

	CASE "CONTAINER!"
		THIS.of_CreateIntermodalEvents ( anv_Msg , lds_Target )		
		

	CASE "CROSSDOCK!"
		IF anv_Msg.of_Get_Parm ( "DockId", lstr_Parm ) > 0 THEN
			ll_DockId = lstr_Parm.ia_Value
		END IF
		IF ll_DockId < 1 THEN
			SetNull ( ll_DockId )
		END IF

		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "P"
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "D"
		lds_Target.Object.de_Site [ ll_Row ] = ll_DockId
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "P"
		lds_Target.Object.de_Site [ ll_Row ] = ll_DockId
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "D"
	CASE "EMPTY!"
		// this is used by edi
	CASE ELSE
		DESTROY lds_Target
		Destroy ( lnv_Company )

RETURN lds_Target
	END CHOOSE
	
	
	lnv_Company = CREATE n_cst_beo_Company 
	lnv_Company.of_SetUsecache( TRUE )
	SetNull ( lt_SettingTime )
	n_cst_setting_defaulteventduration lnv_Duration
	lnv_Duration = CREATE n_cst_setting_defaulteventduration
	ls_Duration	 = Trim(lnv_Duration.of_GetValue( ))
	IF IsTime(ls_Duration) THEN
		lt_SettingTime = Time(ls_Duration)
	END IF
	
	DESTROY ( lnv_Duration )

	ll_RowCount = lds_Target.RowCount ( )

	FOR ll_Row = 1 TO ll_RowCount
		lt_Duration = lt_SettingTime
		lnv_Company.of_SetSourceid ( lds_Target.Object.de_Site [ ll_Row ] )
		lt_CoTime = lnv_Company.of_GetDefaultduration( )
		IF Not IsNull ( lt_CoTime ) THEN
			lt_Duration = lt_CoTime
		END IF
			
			
		
		IF NOT isNull ( lt_Duration ) THEN
			lds_Target.Object.de_Duration [ ll_Row ] = lt_Duration
		END IF
		
		of_GetNextEventId ( ll_NextId ) 
		 
		lds_Target.Object.de_Id [ ll_Row ] = ll_NextId 
		lds_Target.Object.de_Shipment_Id [ ll_Row ] = ll_ShipmentId
		lds_Target.Object.de_Ship_Seq [ ll_Row ] = ll_Row
//		IF ls_Style = "BROKERAGE!" THEN
//			lds_Target.Object.de_Trailer_Seq [ ll_Row ] = 5000
//		END IF
	NEXT

	lstr_Parm.is_Label = "EventCount"
	lnv_Conversion.of_SetAnyTypeLong ( lstr_Parm.ia_Value )
	lstr_Parm.ia_Value = ll_RowCount
	anv_Msg.of_Add_Parm ( lstr_Parm )

ELSE
	Destroy ( lnv_Company )

RETURN lds_Target
END IF


//CleanUp:

Destroy ( lnv_Company )

RETURN lds_Target
end function

public function datastore of_createitementries (ref n_cst_msg anv_msg);Long			ll_NextId, &
				ll_ShipmentId, &
				ll_Row
Integer		li_PickupEvent, &
				li_DeliverEvent, &
				li_EventCount, &
				li_CreateCount, &
				li_CreateIndex, &
				li_amounttypeid

any			la_value

DataStore	lds_Target
s_Parm		lstr_Parm
n_cst_numerical lnv_numerical
n_cst_settings lnv_Settings

//Get ShipmentId from anv_Msg  (value is required)

IF anv_Msg.of_Get_Parm ( "ShipmentId", lstr_Parm ) > 0 THEN
	ll_ShipmentId = lstr_Parm.ia_Value
END IF

IF lnv_numerical.of_IsNullOrNotPos ( ll_ShipmentId ) THEN
	GOTO CleanUp
END IF

//Get PickupEvent, DeliverEvent, and EventCount from anv_Msg  (First 2 are optional)

IF anv_Msg.of_Get_Parm ( "PickupEvent", lstr_Parm ) > 0 THEN
	li_PickupEvent = lstr_Parm.ia_Value
END IF

IF anv_Msg.of_Get_Parm ( "DeliverEvent", lstr_Parm ) > 0 THEN
	li_DeliverEvent = lstr_Parm.ia_Value
END IF

IF anv_Msg.of_Get_Parm ( "EventCount", lstr_Parm ) > 0 THEN
	li_EventCount = lstr_Parm.ia_Value
END IF

//If PickupEvent and DeliverEvent weren't specified, determine default values

IF li_PickupEvent > 0 AND li_PickupEvent <= li_EventCount THEN
	//PickupEvent is valid
ELSE
	li_PickupEvent = Min ( li_EventCount, 1 )
END IF

IF li_DeliverEvent > li_PickupEvent AND li_DeliverEvent <= li_EventCount THEN
	//DeliverEvent is valid
ELSE
	li_DeliverEvent = li_EventCount
END IF


//Get the number of items to create, if specified.

IF anv_Msg.of_Get_Parm ( "FreightItemCount", lstr_Parm ) > 0 THEN
	li_CreateCount = lstr_Parm.ia_Value
ELSE
	li_CreateCount = 1
END IF


//IF NOT of_GetNextItemId ( ll_NextId ) = 1 THEN
//	GOTO CleanUp
//END IF

//Create Item datastore

lds_Target = of_CreateItemDataStore ( TRUE )

//Insert information
//freight
if lnv_Settings.of_GetSetting ( 98 , la_value ) > 0 then
	li_amounttypeid = integer(la_value)
end if

IF IsValid ( lds_Target ) THEN

	FOR li_CreateIndex = 1 TO li_CreateCount
		of_GetNextItemId ( ll_NextId )
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.di_Item_Id [ ll_Row ] = ll_NextId
		lds_Target.Object.di_Shipment_Id [ ll_Row ] = ll_ShipmentId
		lds_Target.Object.di_Item_Type [ ll_Row ] = "L"
		lds_Target.Object.di_PU_Event [ ll_Row ] = li_PickupEvent
		lds_Target.Object.di_Del_Event [ ll_Row ] = li_DeliverEvent
		lds_Target.object.amounttype[ll_Row] = li_amounttypeid
		lds_Target.object.accountingType [ ll_Row] = n_cst_Constants.cs_AccountingType_Both	
	NEXT

ELSE
	GOTO CleanUp
END IF

CleanUp:

RETURN lds_Target
end function

public function boolean of_getinitializeapptdates ();Any		la_Value
Boolean	lb_Result = TRUE  //TRUE is default

n_cst_Settings	lnv_Settings

CHOOSE CASE lnv_Settings.of_GetSetting ( 63, la_Value )

CASE 1

	//Values are "YES!" and "NO!"
	IF Upper ( String ( la_Value ) ) = "NO!" THEN
		lb_Result = FALSE
	END IF

CASE 0
	//No value specified.  Use default.

CASE ELSE  //-1
	//Value cannot be determined.  Use default.

END CHOOSE

RETURN lb_Result
end function

public function long of_newshipment (n_cst_msg anv_msg);//// RDT 6-09-03 of_InitializeContacts
//Long			ll_ShipmentId, &
//				ll_Row, &
//				ll_Return
//Boolean		lb_OpenShipment, &
//				lb_Notify
//String		ls_BillType
//String 		ls_Value
//DataStore	lds_Shipments, &
//				lds_Events, &
//				lds_Items
//s_Parm		lstr_Parm
//
//int 		li_errorCount
//int		i
//String	ls_ErrorString
//
//n_cst_OFRError lnva_Error[]
//n_cst_OFRError_Collection lnv_ErrorCollection
//n_Cst_Privileges	lnv_Privs
//
//IF NOT lnv_Privs.of_HasEntryRights () THEN
//	Messagebox ( "New Shipment" , "You are not authorized to create new shipments." )
//	RETURN -1
//END IF
//	
//
//
//n_Cst_beo_Shipment	lnv_Shipment
//lnv_Shipment = CREATE n_Cst_beo_Shipment
//
//ll_Return = -1
//
//IF anv_Msg.of_Get_Parm ( "Notify", lstr_Parm ) > 0 THEN
//	lb_Notify = lstr_Parm.ia_Value
//ELSE
//	lb_Notify = TRUE
//END IF
//
//lds_Shipments = This.of_CreateShipmentEntries ( anv_Msg )
//IF IsValid ( lds_Shipments ) THEN
//	IF anv_Msg.of_Get_Parm ( "ShipmentId", lstr_Parm ) > 0 THEN
//		ll_ShipmentId = lstr_Parm.ia_Value
//	ELSE
//		GOTO CleanUp
//	END IF
//ELSE
//	GOTO CleanUp
//END IF
//
//lds_Events = This.of_CreateEventEntries ( anv_Msg )
//IF IsValid ( lds_Events ) THEN
//
//ELSE
//	GOTO CleanUp
//END IF
//
////Will need to add ability to set origin and findest here, based on the events created.
////The current types implemented don't use this.
//
//lds_Items = This.of_CreateItemEntries ( anv_Msg )
//
//IF IsValid ( lds_Items ) THEN
//
//ELSE
//	GOTO CleanUp
//END IF
//
//IF ll_ShipmentID > 0 THEN
//	lnv_Shipment.of_SetSource ( lds_Shipments )
//	lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
//	lnv_Shipment.of_SetEventSource ( lds_Events )
//	lnv_Shipment.of_SetItemSource ( lds_Items )
//	lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 
//// RDT 6-09-03 	lnv_Shipment.of_CleanContactList (  ) // sets the contacts 
//END IF
//
//IF lds_Shipments.Update ( ) = -1 THEN
//	ROLLBACK ;
//	GOTO CleanUp
//END IF
//
//IF lds_Events.Update ( ) = -1 THEN
//	ROLLBACK ;
//	GOTO CleanUp
//END IF
//
//IF lds_Items.Update ( ) = -1 THEN
//	ROLLBACK ;
//	GOTO CleanUp
//END IF
//
//COMMIT ;
//
//IF SQLCA.SqlCode <> 0 THEN
//	ROLLBACK ;
//	GOTO CleanUp
//END IF
//
//IF sb_Ships_Retrieved THEN
//	//The above condition should be incorporated into the function, but the function
//	//is so variable-heavy, I didn't want to call it unless necessary for now.
//
//	this.of_RefreshShipments ( FALSE )
//END IF
//
//IF anv_Msg.of_Get_Parm ( "STYLE", lstr_Parm ) > 0 THEN
//	IF lstr_Parm.ia_Value = "CONTAINER!" THEN
//		THIS.of_InitializeNewIntermodal ( ll_ShipmentID )
//	END IF
//END IF
//
//// zmc - 2-10-04
//// Set Default System Settings here.
//IF THIS.of_InitializeShipment(ll_ShipmentID) = -1  AND lb_Notify THEN
//	lnv_ErrorCollection = This.GetOFRErrorCollection ( )
//	lnv_Errorcollection.GetErrorArray( lnva_Error )
//	li_ErrorCount = upperBound(lnva_Error)
//	
//	For i = 1 TO li_ErrorCount
//		ls_ErrorString += string( lnva_Error[i].getErrorMessage() )
//	next 
//	MessageBox("New Shipment",ls_ErrorString)
//END IF
//
//// RDT 6-09-03 -Start
//n_cst_licensemanager lnv_License
//IF lnv_License.of_hasnotificationlicense ( ) THEN
//	This.of_InitializeContacts( ll_ShipmentId )
//END IF
//// RDT 6-09-03 -end
//
//IF anv_Msg.of_Get_Parm ( "Display", lstr_Parm ) > 0 THEN
//	lb_OpenShipment = lstr_Parm.ia_Value
//ELSE
//	lb_OpenShipment = TRUE
//END IF
//
//IF lb_OpenShipment THEN
//	This.of_OpenShipment ( ll_ShipmentId )
//END IF
//
//ll_Return = ll_ShipmentId
//
//CleanUp:
//
//DESTROY lds_Shipments
//DESTROY lds_Events
//DESTROY lds_Items
//DESTROY lnv_Shipment
//
//IF ll_Return = -1 THEN
//	IF lb_Notify THEN
//		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
//			"Please retry.", Exclamation! )
//	END IF
//END IF
//
//RETURN ll_Return


// RDT 6-09-03 of_InitializeContacts
Long			ll_ShipmentId, &
				ll_Row, &
				ll_Return
Boolean		lb_OpenShipment, &
				lb_Notify
String		ls_BillType
String 		ls_Value
DataStore	lds_Shipments, &
				lds_Events, &
				lds_Items
s_Parm		lstr_Parm

int 		li_errorCount
int		i
String	ls_ErrorString

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection
n_Cst_Privileges	lnv_Privs

IF NOT lnv_Privs.of_HasEntryRights () THEN
	Messagebox ( "New Shipment" , "You are not authorized to create new shipments." )
	RETURN -1
END IF
	


n_Cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_Cst_beo_Shipment

ll_Return = -1

IF anv_Msg.of_Get_Parm ( "Notify", lstr_Parm ) > 0 THEN
	lb_Notify = lstr_Parm.ia_Value
ELSE
	lb_Notify = TRUE
END IF

lds_Shipments = This.of_CreateShipmentEntries ( anv_Msg )
IF IsValid ( lds_Shipments ) THEN
	IF anv_Msg.of_Get_Parm ( "ShipmentId", lstr_Parm ) > 0 THEN
		ll_ShipmentId = lstr_Parm.ia_Value
	ELSE
		DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
	END IF
ELSE
	DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
END IF

lds_Events = This.of_CreateEventEntries ( anv_Msg )
IF IsValid ( lds_Events ) THEN

ELSE
	DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
END IF

//Will need to add ability to set origin and findest here, based on the events created.
//The current types implemented don't use this.

lds_Items = This.of_CreateItemEntries ( anv_Msg )

IF IsValid ( lds_Items ) THEN

ELSE
	DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
END IF

IF ll_ShipmentID > 0 THEN
	lnv_Shipment.of_SetSource ( lds_Shipments )
	lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
	lnv_Shipment.of_SetEventSource ( lds_Events )
	lnv_Shipment.of_SetItemSource ( lds_Items )
	lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 
// RDT 6-09-03 	lnv_Shipment.of_CleanContactList (  ) // sets the contacts 
END IF

IF lds_Shipments.Update ( ) = -1 THEN
	ROLLBACK ;
DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
END IF

IF lds_Events.Update ( ) = -1 THEN
	ROLLBACK ;
	DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
END IF

IF lds_Items.Update ( ) = -1 THEN
	ROLLBACK ;
	DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
END IF

COMMIT ;

IF SQLCA.SqlCode <> 0 THEN
	ROLLBACK ;
	DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
END IF

IF sb_Ships_Retrieved THEN
	//The above condition should be incorporated into the function, but the function
	//is so variable-heavy, I didn't want to call it unless necessary for now.

	this.of_RefreshShipments ( FALSE )
END IF

IF anv_Msg.of_Get_Parm ( "STYLE", lstr_Parm ) > 0 THEN
	IF lstr_Parm.ia_Value = "CONTAINER!" THEN
		THIS.of_InitializeNewIntermodal ( ll_ShipmentID )
	END IF
END IF

// zmc - 2-10-04
// Set Default System Settings here.
IF THIS.of_InitializeShipment(ll_ShipmentID) = -1  AND lb_Notify THEN
	lnv_ErrorCollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.GetErrorArray( lnva_Error )
	li_ErrorCount = upperBound(lnva_Error)
	
	For i = 1 TO li_ErrorCount
		ls_ErrorString += string( lnva_Error[i].getErrorMessage() )
	next 
	MessageBox("New Shipment",ls_ErrorString)
END IF

// RDT 6-09-03 -Start
n_cst_licensemanager lnv_License
IF lnv_License.of_hasnotificationlicense ( ) THEN
	This.of_InitializeContacts( ll_ShipmentId )
END IF
// RDT 6-09-03 -end

IF anv_Msg.of_Get_Parm ( "Display", lstr_Parm ) > 0 THEN
	lb_OpenShipment = lstr_Parm.ia_Value
ELSE
	lb_OpenShipment = TRUE
END IF

IF lb_OpenShipment THEN
	This.of_OpenShipment ( ll_ShipmentId )
END IF

ll_Return = ll_ShipmentId

//CleanUp:

DESTROY lds_Shipments
DESTROY lds_Events
DESTROY lds_Items
DESTROY lnv_Shipment

IF ll_Return = -1 THEN
	IF lb_Notify THEN
		MessageBox ( "Add New Shipment", "Could not add new shipment to database.~n~n"+&
			"Please retry.", Exclamation! )
	END IF
END IF

RETURN ll_Return
end function

public function boolean of_isnonrouted (readonly long al_id);//Returns:  TRUE, FALSE, Null = Error, or cannot determine

String	ls_Dorb
Boolean	lb_Result

SELECT ds_dorb INTO :ls_Dorb FROM disp_ship WHERE ds_id = :al_Id ;

CHOOSE CASE SQLCA.SqlCode

CASE 0
	IF ls_Dorb = "D" THEN
		lb_Result = TRUE
	ELSE
		lb_Result = FALSE
	END IF

CASE 100  //Row not found -- shipment does not exist.
	SetNull ( lb_Result )

CASE ELSE //Error
	SetNull ( lb_Result )

END CHOOSE

COMMIT ;

RETURN lb_Result
end function

public function integer of_loadshipmentcachefromfile ();n_cst_dws	lnv_Dws
DataStore	lds_Temp
String		ls_MaxTimeStamp, &
				ls_CacheFile
Long			ll_RowCount, &
				ll_Attempts
Integer		li_FileHandle
Time			lt_FirstAttempt, &
				lt_LastAttempt

Integer	li_Return = 1


IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetShipmentCacheFile ( ls_CacheFile )

	CASE 1
		//OK

	CASE 0
		li_Return = 0

	CASE ELSE //-1
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	lt_FirstAttempt = Now ( )

	DO

		li_FileHandle = FileOpen ( ls_CacheFile, LineMode!, Read!, LockWrite! )
		lt_LastAttempt = Now ( )
		ll_Attempts ++

		IF IsNull ( li_FileHandle ) THEN
			li_FileHandle = -1
			EXIT
		END IF

		//If we didn't get a file handle, we'll retry provided the time limit hasn't expired.
		//Yield processing to other threads, though, so we don't completely tie up the machine
		//for the attempt interval.

		IF li_FileHandle = -1 THEN
			Yield ( )
		END IF

	LOOP UNTIL li_FileHandle >= 0 OR SecondsAfter ( lt_FirstAttempt, lt_LastAttempt ) >= 5 /*Time Limit*/

	//In testing on a 4 second attempt interval, there were 4 attempts when the file was on a network, 
	//and 3160 attempts when the file was local.  However, if the file is local, it shouldn't be tied up
	//anyway, so we wouldn't really have all those attempts.

//	MessageBox ( String ( ll_Attempts ) + " Attempts", String ( li_FileHandle ) +&
//		" " + String ( lt_FirstAttempt, "h:mm:ss.fffff" ) + " " + String ( lt_LastAttempt, "h:mm:ss.ffffff" ) )


	IF li_FileHandle = -1 THEN
		li_Return = -1

	ELSEIF lnv_Dws.of_CreateDataStoreByDataObject ( ls_CacheFile, lds_Temp, TRUE ) = 1 THEN
	
		lds_Temp.SetSort ( "cs_timestamp A" )
		lds_Temp.Sort ( )
		ll_RowCount = lds_Temp.RowCount ( )
	
	ELSE
	
		li_Return = -1
	
	END IF

	IF li_FileHandle >= 0 THEN
		FileClose ( li_FileHandle )
	END IF

END IF


IF li_Return = 1 THEN

	IF ll_RowCount > 0 /*AND It's the right version*/ THEN

		ls_MaxTimeStamp = lds_Temp.Object.cs_TimeStamp [ ll_RowCount ]

		IF Len ( ls_MaxTimeStamp ) > 0 THEN
			//OK
		ELSE
			li_Return = -1
		END IF

	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF ls_MaxTimeStamp > ss_Ships_Last_Change THEN

		sds_Ship.Reset ( )

		//Checking the success of rowscopy and the failure handling was added 3.6.b2 BKW 5-11-03
		//This enables the program to recognize cache file structure changes (via rowscopy failure)
		//and automatically recreate the cache file on an as-needed basis.

		IF lds_Temp.RowsCopy ( 1, ll_RowCount, Primary!, sds_Ship, 9999, Primary! ) = 1 THEN

	//		Alternative Method : Replace existing cache with new one.
	//		DESTROY sds_Ship
	//		sds_Ship = lds_Temp
	
			sb_ships_retrieved = true
			ss_ships_last_change = ls_MaxTimeStamp
			sdt_ships_refreshed = datetime(today(), now())
			sdt_ships_updated = sdt_ships_refreshed

		ELSE

			//The "normal" reason for this rowscopy to fail would be the first time the cache has been loaded after
			//a program version update that changes its structure.  This will force a reload from scratch and an 
			//overwrite of the existing outdated cache file.

			li_Return = -1

			//If we had previously retrieved the cache successfully, reset the flags to indicate we no 
			//longer have it.  Note:  These are the same flags set when changing the cache code.

			IF sb_Ships_Retrieved = TRUE THEN
	
				sb_Ships_Retrieved = FALSE
				
				sdt_ships_refreshed = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
				sdt_ships_updated = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
				sdt_LastShipmentCacheWrite = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
				
				//si_ships_filter = 0
				ss_ships_last_change = ""

			END IF

		END IF

	ELSE
		li_Return = 0

	END IF

END IF


DESTROY lds_Temp

//If Alternative Method (Replacing Cache rather than copying rows) is used, we would conditionally destroy temp.
//IF li_Return < 1 THEN
//	DESTROY lds_Temp
//END IF

RETURN li_Return
end function

public function integer of_getshipmentcachefile (ref string as_filename);//Returns : 1, 0, -1

any	la_Path
n_cst_settings lnv_Settings
String	ls_IniFile, &
			ls_Extension

Integer	li_Return = 1


IF IsNull ( ss_ShipmentCacheFile ) THEN

	//This is the first request for the value.  Look up the CacheFilePath and see if it exists.

	IF lnv_Settings.of_GetSetting ( 68 , la_path ) = 1 THEN

		ss_ShipmentCacheFile = Trim ( String ( la_Path ) )

		IF Len ( ss_ShipmentCacheFile ) > 0 THEN

			IF Right ( ss_ShipmentCacheFile, 1 ) = "\" THEN
				//OK, leave it alone
			ELSE
				ss_ShipmentCacheFile += "\"
			END IF


			//If ss_ShipmentCacheCode has been specified, try to get a setting for it in the ini file.
			//If this succeeds, use the ss_ShipmentCacheCode as the psr name.
			//If not, clear the code, so that "shipsum.psr" will be used, below.
			//Note that "default.psr" is the default restricted summary, while "shipsum.psr" is the 
			//default unrestricted summary.

			IF NOT IsNull ( ss_ShipmentCacheCode ) THEN

				ls_IniFile = gnv_App.of_GetAppIniFile ( )
	
				ls_Extension = ProfileString ( ls_IniFile, "ShipSum", ss_ShipmentCacheCode, "" )
	
				IF Len ( ls_Extension ) > 0 THEN
	
					ss_ShipmentCacheWhereClauseExtension = ls_Extension
					ss_ShipmentCacheFile += ss_ShipmentCacheCode + ".psr"

				ELSE
	
					SetNull ( ss_ShipmentCacheCode )
					SetNull ( ss_ShipmentCacheWhereClauseExtension )

				END IF

			ELSE

				//Since we don't have a code, clear the W.C.E., just in case it hasn't been already.
				SetNull ( ss_ShipmentCacheWhereClauseExtension )

			END IF


			//If the CacheCode was null coming in, or if it's been set to null above, use the 
			//"universal" cache file, "shipsum.psr"

			IF IsNull ( ss_ShipmentCacheCode ) THEN

				ss_ShipmentCacheFile += "shipsum.psr"

			END IF


		ELSE
			ss_ShipmentCacheFile = ""
			li_Return = 0

		END IF

	ELSE
		ss_ShipmentCacheFile = ""
		li_Return = 0

	END IF

ELSEIF ss_ShipmentCacheFile = "" THEN

	//We've already checked, and the path hasn't been specified.
	li_Return = 0

ELSE

	//Value is present.  Use it.

END IF


IF li_Return = 1 THEN
	as_FileName = ss_ShipmentCacheFile
END IF

RETURN li_Return
end function

public function string of_getstatuscodetable ();//When ready, add after "Quoted"
//	"PENDING~t" + gc_Dispatch.cs_ShipmentStatus_Pending + "/"+&

//Display value QUOTED was changed to QUOTE in 3.0.12

Constant String	ls_CodeTable = &
	"TEMPLATE~t" + gc_Dispatch.cs_ShipmentStatus_Template + "/"+&
	"QUOTE~t" + gc_Dispatch.cs_ShipmentStatus_Quoted + "/"+&
	"OFFERED~t" + gc_Dispatch.cs_ShipmentStatus_Offered + "/"+&
	"DECLINED~t" + gc_Dispatch.cs_ShipmentStatus_DECLINED + "/"+&
	"OPEN~t" + gc_Dispatch.cs_ShipmentStatus_Open + "/"+&
	"AUTHORIZED~t" + gc_Dispatch.cs_ShipmentStatus_Authorized + "/"+&
	"AUDIT REQ.~t" + gc_Dispatch.cs_ShipmentStatus_AuditRequired + "/"+&
	"AUDITED~t" + gc_Dispatch.cs_ShipmentStatus_Audited + "/"+&
	"BILLED~t" + gc_Dispatch.cs_ShipmentStatus_Billed + "/"+&
	"CANCELLED~t" + gc_Dispatch.cs_ShipmentStatus_Cancelled + "/"

RETURN 	ls_CodeTable
end function

public function string of_getstatusdisplayvalue (string as_datavalue);//Returns : The display value if determined, Null if cannot be determined.

n_cst_String	lnv_String

String	ls_CodeTable, &
			ls_Display

ls_CodeTable = This.of_GetStatusCodeTable ( )

ls_Display = lnv_String.of_GetCodeTableDisplayValue ( as_DataValue, ls_CodeTable )

RETURN ls_Display
end function

public function string of_getstatusdatavalue (string as_displayvalue);String	ls_CodeTable, &
			ls_DataValue
n_cst_String	lnv_String

ls_CodeTable = This.of_GetStatusCodeTable ( )

ls_DataValue = lnv_String.of_GetCodeTableDataValue ( as_DisplayValue, ls_CodeTable )

RETURN ls_DataValue
end function

public function integer of_makenonrouted (long ala_ids[], boolean ab_confirmevents);//Returns : 1, -1 = Complete Failure (NOT individual shipment failure), 0 = User Cancel

//Convert the shipments in ala_ids to non-routed, if possible.

//Passing in a Null value for ab_ConfirmEvents causes a prompt to the user.

//Things that can prevent a shipment being converted are:
//Shipment contains routed assignment events (hooks, drops, mounts, dismounts.)
//(Shipments containing routed pickups and deliveries can be converted.)

/*
	Modified to include equipment that is linked to the shipment in the list of
	equipment that is deactivated. 3/15/07

*/

n_cst_bso_Dispatch	lnv_Dispatch
DataStore		lds_ShipmentCache, &
					lds_EventCache, &
					lds_ItemCache, &
					lds_EquipmentCache
n_cst_beo_Shipment	lnv_Shipment, &
							lnv_EmptyShipment
							
n_cst_beo_Event		lnva_Events[]

n_cst_String			lnv_String
n_cst_Sql				lnv_Sql
n_cst_AnyArraySrv		lnv_Arrays
Long	ll_RowCount, &
		ll_Row, &
		ll_EventCount, &
		ll_EquipmentCount, &
		ll_Index, &
		ll_Id, &
		lla_EquipmentIds[], &
		lla_EventIds[], &
		lla_Empty[], &
		lla_Skipped_NonRouted[], &
		lla_Skipped_RoutedAssignment[], &
		lla_Skipped_UpdateError[], &
		lla_NonConfirmable[], &
		ll_SkippedCount_NonRouted, &
		ll_SkippedCount_RoutedAssignment, &
		ll_SkippedCount_UpdateError, &
		ll_NonConfirmableCount, &
		ll_UpdatedCount
Boolean	lb_HasRoutedAssignment, &
			lb_UpdateError, &
			lb_NonConfirmable
String	ls_ConfirmedBy, &
			ls_Skipped_NonRouted, &
			ls_Skipped_RoutedAssignment, &
			ls_Skipped_UpdateError, &
			ls_NonConfirmable, &
			ls_Message, &
			ls_EquipmentInClause, &
			ls_EventInClause, &
			ls_Update
String	ls_MessageHeader = "Convert Shipments to Non-Routed"

Integer	li_Return = 1
Int		li_EqCount
n_Cst_beo_Equipment2	lnva_equipment[]

//Just two in-code returns to do pre-screening.
Boolean	lb_AllowModOfShipment
DataStore	lds_Temp

Long	i, ll_findRow, ll_currid

IF gnv_app.of_Getprivsmanager( ).of_useadvancedprivs( ) THEN
	lb_AllowModOfShipment = TRUE
	lds_Temp = CREATE DataStore
	lds_Temp.DataObject = "d_shipmentshiptype"
	lds_Temp.SetTransObject ( SQLCA )
	ll_RowCount = lds_Temp.retrieve( ala_ids[] )
	Commit;
				
	//Added By dan 2-7-07 to check a new PrivFunction if the shipment we are talking about is billed or not	
	n_cst_beo_shipment	lnva_shipments[]
	Long	ll_type
	String	ls_privFunction
	inv_dispatch.of_getshipments( ala_ids, lnva_shipments )			

	ll_rowCount = upperBound( lnva_shipments )
	/////////////////////			
	FOR i = 1 TO ll_RowCount
		ll_currid = lnva_shipments[i].of_getId( )
		ll_findRow = lds_temp.find( "ds_id = "+ string( ll_currid ), 1, lds_temp.RowCount())
		IF ll_findRow > 0 THEN
			ll_type = lds_temp.getItemNumber( ll_findRow, "ds_ship_type" ) 
		END IF
		///Added 2-7-07
		IF lnva_shipments[i].of_isBilled() THEN
			ls_privFunction = n_cst_privsManager.cs_ModifyBilledShip
		ELSE
			ls_privFunction = "ModifyShipment"
		END IF
		///////////////////////////////////////
		IF gnv_App.of_GetPrivsmanager( ).of_getuserpermissionfromfn( ls_privFunction , ll_type ) = n_cst_privsmanager.ci_FALSE THEN
			lb_AllowModOfShipment = FALSE
			EXIT
		END IF
		Destroy lnva_shipments[i]
	NEXT
	DESTROY ( lds_Temp )
	
	IF NOT lb_AllowModOfShipment THEN
		MessageBox (ls_MessageHeader , "You do not have rights to modify one or more of the selected shipments. Request Cancelled." )
		RETURN 0
	END IF

END IF




IF MessageBox ( ls_MessageHeader, "OK to convert these " + String ( UpperBound ( ala_Ids ) ) +&
	" shipment(s) to Non-Routed?", Question!, OKCancel!, 1 ) = 2 THEN

	//User cancel
	RETURN 0

END IF


IF IsNull ( ab_ConfirmEvents ) THEN

	CHOOSE CASE MessageBox ( ls_MessageHeader, "Do you want to confirm all events for the target "+&
		"shipment(s) as completed?", Question!, YesNoCancel!, 1 )

	CASE 1
		ab_ConfirmEvents = TRUE

	CASE 2
		ab_ConfirmEvents = FALSE

	CASE ELSE
		//User Cancel
		RETURN 0

	END CHOOSE

END IF

//From here on out, no more in-code returns.

//Get the current user's id, for use in event confirmations later, if appropriate.
ls_ConfirmedBy = gnv_App.of_GetUserId ( )

//Pull the shipment ids from the target list, and retrieve those shipments in the dispatch manager.
lnv_Dispatch = CREATE n_cst_bso_Dispatch
lnv_Dispatch.of_RetrieveShipments ( ala_Ids )

//**Temporary Workaround -- See Notes in n_cst_bso_Dispatch.of_RetrieveShipments ( )
//We need to unfilter all the retrieved items and events, so that PB will assign them
//PBRowIds and so that they'll be visible to the GetEventList and GetShipmentList methods
//on the shipment beo's.  Also, we need to sort the events in shipment sequence order so
//that the GetEventList method will return the events in that order.

lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )
lds_EventCache = lnv_Dispatch.of_GetEventCache ( )
lds_ItemCache = lnv_Dispatch.of_GetItemCache ( )
lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )

IF IsValid ( lds_ShipmentCache ) THEN
	lds_ShipmentCache.SetFilter ( "" )
	lds_ShipmentCache.SetSort ( "ds_id A" )
	lds_ShipmentCache.Filter ( )
	lds_ShipmentCache.Sort ( )
ELSE
	li_Return = -1
END IF

IF IsValid ( lds_EventCache ) THEN
	lds_EventCache.SetFilter ( "" )
	lds_EventCache.SetSort ( "de_ship_seq A" )
	lds_EventCache.Filter ( )
	lds_EventCache.Sort ( )
ELSE
	li_Return = -1
END IF

IF IsValid ( lds_ItemCache ) THEN
	lds_ItemCache.SetFilter ( "" )
	lds_ItemCache.Filter ( )
ELSE
	li_Return = -1
END IF


IF li_Return = 1 THEN

	ll_RowCount = lds_ShipmentCache.RowCount ( )

	FOR ll_Row = 1 TO ll_RowCount

		//With just resetting the beo source row, we were having runaway memory issues.
		//So, clear the beo's from the previous pass, to prevent runaway memory issues.
		DESTROY ( lnv_Shipment ) 
		lnv_Shipment = CREATE n_cst_beo_Shipment
		
		
		//lnva_Events = lnva_EmptyEvents
		//I tried a GarbageCollect ( ) here, but it crashed, and didn't turn out to be necessary

		lnv_Shipment.of_SetSource ( lds_ShipmentCache )
		lnv_Shipment.of_SetEventSource ( lds_EventCache )
		lnv_Shipment.of_SetItemSource ( lds_ItemCache )

		lnv_Shipment.of_SetSourceRow ( ll_Row )

//		Not necessary, because we only hit the event list once, below.
//		lnv_Shipment.of_LockEventList ( "MakeNonRouted" )
//		lnv_Shipment.of_LockItemList ( "MakeNonRouted" )

		ll_Id = lnv_Shipment.of_GetId ( )

		IF lnv_Shipment.of_IsNonRouted ( ) THEN
			ll_SkippedCount_NonRouted ++
			lla_Skipped_NonRouted [ ll_SkippedCount_NonRouted ] = ll_Id
			CONTINUE
		END IF
		
		// get event list will destroy the events passed in before assigning new ones
		ll_EventCount = lnv_Shipment.of_GetEventList ( lnva_Events )
		lla_EventIds = lla_Empty
		lla_EquipmentIds = lla_Empty
		lb_HasRoutedAssignment = FALSE
		lb_UpdateError = FALSE
		lb_NonConfirmable = FALSE
		
		
		
		li_EqCount = lnv_Shipment.of_GetLinkedequipment( lnva_equipment )
		FOR ll_Index = 1 TO li_EqCount
			lla_EquipmentIds [ll_Index] = lnva_equipment[ll_Index].of_GetID ( )
			DESTROY (lnva_equipment[ll_Index])
		NEXT



		FOR ll_Index = 1 TO ll_EventCount

			IF lnva_Events [ ll_Index ].of_IsAssignment ( ) THEN

				//If DateArrived or a 3rd Party Trip is specified, the event is Routed
				//Note: It's currently not possible for an assignment event to be routed
				//to a 3rd party trip, but I'd rather not build in that assumption here.
				IF NOT ( IsNull ( lnva_Events [ ll_Index ].of_GetDateArrived ( ) ) &
					AND IsNull ( lnva_Events [ ll_Index ].of_GetTrip ( ) ) ) THEN

					lb_HasRoutedAssignment = TRUE
					EXIT

				END IF
			END IF

		NEXT

		IF lb_HasRoutedAssignment THEN

			ll_SkippedCount_RoutedAssignment ++
			lla_Skipped_RoutedAssignment [ ll_SkippedCount_RoutedAssignment ] = ll_Id
			CONTINUE

		END IF


		IF lb_UpdateError = FALSE THEN

			FOR ll_Index = 1 TO ll_EventCount

				lla_EventIds [ ll_Index ] = lnva_Events [ ll_Index ].of_GetId ( )
	
				lnva_Events [ ll_Index ].of_GetTrailerList ( lla_EquipmentIds, TRUE /*Append to List*/ )
				lnva_Events [ ll_Index ].of_GetContainerList ( lla_EquipmentIds, TRUE /*Append to List*/ )
	
				IF lnva_Events [ ll_Index ].of_ClearRouting ( FALSE /*Don't clear times and conf*/ ) = -1 THEN
					lb_UpdateError = TRUE
					EXIT
				END IF

				//If the event is not already a plain pickup or delivery, convert it to one
				//based on whether it's a pickup group event (hook, mount) or deliver group.
				IF lnva_Events [ ll_Index ].of_IsType ( gc_Dispatch.cs_EventType_Pickup ) THEN
					//OK
				ELSEIF lnva_Events [ ll_Index ].of_IsType ( gc_Dispatch.cs_EventType_Deliver ) THEN
					//OK
				ELSEIF lnva_Events [ ll_Index ].of_IsPickupGroup ( ) THEN
					lnva_Events [ ll_Index ].of_SetType ( gc_Dispatch.cs_EventType_Pickup )
				ELSEIF lnva_Events [ ll_Index ].of_IsDeliverGroup ( ) THEN
					lnva_Events [ ll_Index ].of_SetType ( gc_Dispatch.cs_EventType_Deliver )
				ELSE
					lb_UpdateError = TRUE
					EXIT
				END IF

				IF ab_ConfirmEvents THEN
					IF lnva_Events [ ll_Index ].of_IsConfirmed ( ) = FALSE THEN
						
						IF lnva_Events [ ll_Index ].of_HasSite ( ) = FALSE OR gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "ConfirmEvents", lnva_Events [ ll_Index ] ) <> n_cst_privsmanager.ci_True THEN
							IF lb_NonConfirmable = FALSE THEN //First problem event for this shipment
								ll_NonConfirmableCount ++
								lla_NonConfirmable [ ll_NonConfirmableCount ] = ll_Id
								lb_NonConfirmable = TRUE
							END IF
						ELSE  //Event is confirmable
							lnva_Events [ ll_Index ].of_SetConfirmedBy ( ls_ConfirmedBy )
							lnva_Events [ ll_Index ].of_SetConfirmed ( "T" )
						END IF
					END IF
				END IF

			NEXT

		END IF

		IF lb_UpdateError = FALSE THEN
		
			IF lnv_Shipment.of_SetCategory ( "D" /*NonRouted*/ ) = 1 THEN
				//OK
			ELSE
				lb_UpdateError = TRUE
			END IF

		END IF

		IF lb_UpdateError = FALSE THEN

			CHOOSE CASE lnv_Dispatch.Event pt_Save ( )
		
			CASE 1  //Success
				//OK
		
			CASE -1  //Failure
				lb_UpdateError = TRUE
		
			CASE ELSE  //Unexpected result
				lb_UpdateError = TRUE
		
			END CHOOSE

		END IF

		IF lb_UpdateError = FALSE THEN

			ll_EquipmentCount = lnv_Arrays.of_GetShrinked ( lla_EquipmentIds, TRUE /*Nulls*/, TRUE /*Dupes*/ )

			IF ll_EquipmentCount > 0 THEN

				ls_EquipmentInClause = lnv_Sql.of_MakeInClause ( lla_EquipmentIds )
				ls_EventInClause = lnv_Sql.of_MakeInClause ( lla_EventIds )

				//Set the deleted status for any outside equipment we've encountered whose origination event
				//is part of the shipment.  Because a routed assginment event would have caused the shipment
				//to be skipped, we can assume that because we see the origination in the shipment, the origination
				//is not routed, and therefore nothing else would be routed to the equipment, so it can be deleted.

				ls_Update = "UPDATE equipment, outside_equip SET eq_status = 'X' WHERE eq_id = oe_id AND "+&
					"eq_id " + ls_EquipmentInClause + " AND ( oe_orig_event " + ls_EventInClause + " OR oe_orig_event IS NULL )"									
					//Added null condition 3.5.18 BKW.  Since oe_orig_event is no longer automatically set, equipment 
					//that had been created after the shipment was created was often not being removed, since it didn't
					//have an oe_orig_event.


				EXECUTE IMMEDIATE :ls_Update ;
				COMMIT ;

				//For example:
				//update equipment, outside_equip set eq_status = 'X' where eq_id = oe_id and 
				//eq_id in (10000241, 10000242) and oe_orig_event in (2716, 2717, 2718, 2719)

			END IF

		END IF


		IF lb_UpdateError THEN
			ll_SkippedCount_UpdateError ++
			lla_Skipped_UpdateError [ ll_SkippedCount_UpdateError ] = ll_Id

			lds_ShipmentCache.ResetUpdate ( )
			lds_EventCache.ResetUpdate ( )
			lds_ItemCache.ResetUpdate ( )
			lds_EquipmentCache.ResetUpdate ( )
			CONTINUE
		END IF

		ll_UpdatedCount ++
		
	NEXT

END IF


IF li_Return = 1 THEN

	ls_Message += String ( ll_UpdatedCount ) + " of " + String ( ll_RowCount ) +&
		" shipment(s) requested were successfully converted to non-routed.~n~n"

	IF ll_NonConfirmableCount > 0 THEN
		lnv_String.of_ArrayToString ( lla_NonConfirmable, ", ", ls_NonConfirmable )
		ls_Message += String ( ll_NonConfirmableCount ) +&
			" shipment(s) contained events that could not be confirmed:~n" +&
			ls_NonConfirmable + "~n~n"
	END IF

	IF ll_SkippedCount_NonRouted > 0 THEN
		lnv_String.of_ArrayToString ( lla_Skipped_NonRouted, ", ", ls_Skipped_NonRouted )
		ls_Message += String ( ll_SkippedCount_NonRouted ) +&
			" shipment(s) were skipped because they were already NonRouted:~n" +&
			ls_Skipped_NonRouted + "~n~n"
	END IF

	IF ll_SkippedCount_RoutedAssignment > 0 THEN
		lnv_String.of_ArrayToString ( lla_Skipped_RoutedAssignment, ", ", ls_Skipped_RoutedAssignment )
		ls_Message += String ( ll_SkippedCount_RoutedAssignment ) +&
			" shipment(s) were skipped because they contained routed assignment events "+&
			"(Hooks, Drops, Mounts, or Dismounts):~n" +&
			ls_Skipped_RoutedAssignment + "~n~n"
	END IF

	IF ll_SkippedCount_UpdateError > 0 THEN
		lnv_String.of_ArrayToString ( lla_Skipped_UpdateError, ", ", ls_Skipped_UpdateError )
		ls_Message += String ( ll_SkippedCount_UpdateError ) +&
			" shipment(s) were skipped because of errors during update:~n" +&
			ls_Skipped_UpdateError + "~n~n"
	END IF

ELSE
	ls_Message = "Could not process request."

END IF

DESTROY lnv_Dispatch
DESTROY ( lnv_Shipment )


FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_Events[ i ] )
NEXT

MessageBox ( ls_MessageHeader, ls_Message )

RETURN li_Return
end function

public function integer of_duplicateshipment (ref n_cst_msg anv_msg);Return This.of_DuplicateShipment(anv_msg, TRUE)
end function

private function integer of_copyshipment (long al_rowtocopy, long al_newshipid, n_cst_msg anv_msg, ref n_ds ads_shipment);// RDT 7-17-03 get parent id from message object
Long		ll_ParentShipID  		// RDT 7-17-03 

String	ls_EquipRef
Boolean	lb_Items = TRUE
Boolean	lb_Payables = TRUE
Boolean	lb_RefLabels = TRUE
Boolean 	lb_RefValues = TRUE 
Boolean	lb_ShipNote = TRUE
Boolean	lb_BillNote = TRUE
Boolean	lb_NonRouted = FALSE
Boolean	lb_Template = FALSE
Boolean	lb_CustomFields = TRUE
Boolean	lb_Intermodal = TRUE
Boolean	lb_Seal = FALSE
Boolean	lb_CopyAll = TRUE   // this is used in an attempt to increase perfomance.  
Boolean	lb_Freight
Boolean	lb_Acc
String	ls_DorB
String	ls_ModLog
String	ls_EquipType
String	ls_Null
String	ls_ShipmentStatus = gc_Dispatch.cs_ShipmentStatus_Open
String	ls_User
Int		li_Ref2Label
String	ls_Ref2Text
Int		li_Ref3Label
String	ls_Ref3Text
String	ls_PaymentTerms

Long		ll_eqType
Long		ll_RowCount
Long		ll_Null
Date		ld_ShipDate
Int		li_Null
Date		ld_NullDate
Time		lt_NullTime
n_cst_Msg	lnv_msg
S_Parm		lstr_Parm
n_cst_LicenseManager	lnv_LicenseMgr

lnv_Msg = anv_Msg
SetNull ( ls_Null )
SetNull ( ll_NUll )
SetNull ( li_Null )
SetNull ( ld_NullDate )
SetNUll ( lt_NullTime )


ls_User = gnv_App.of_GetUserId ( )
ls_ModLog = string(today(), "m/d/yy") + "~t" + string(now(), "h:mmA/P") + "~t" +&
	"CREATED~t~t" + ls_User + "~r~n"

// check for any special duplication requests 
IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_Items , lstr_Parm ) <> 0 THEN
	lb_Items = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_FreightItems , lstr_Parm ) <> 0 THEN
	lb_Freight = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_AccItems , lstr_Parm ) <> 0 THEN
	lb_Acc = lstr_Parm.ia_Value
END IF



IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_Payables , lstr_Parm ) <> 0 THEN
	lb_Payables = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_RefLabels , lstr_Parm ) <> 0 THEN
	lb_RefLabels = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_RefValues , lstr_Parm ) <> 0 THEN
	lb_RefValues = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_ShipNote , lstr_Parm ) <> 0 THEN
	lb_ShipNote = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_BillNote , lstr_Parm ) <> 0 THEN
	lb_BillNote = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_NonRouted , lstr_Parm ) <> 0 THEN
	lb_NonRouted = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_CustomFields , lstr_Parm ) <> 0 THEN
	lb_CustomFields = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_Intermodal , lstr_Parm ) <> 0 THEN
	lb_Intermodal = lstr_Parm.ia_Value
	lb_CopyAll = FALSE
END IF

IF lnv_Msg.of_Get_Parm ( "TEMPLATE" , lstr_Parm ) <> 0 THEN
	lb_Template = lstr_Parm.ia_Value 
END IF

IF lnv_Msg.of_Get_Parm ( "DATE" , lstr_Parm ) <> 0 THEN
	IF isNull ( lstr_Parm.ia_Value ) THEN
		SetNull ( ld_ShipDate )
		ld_ShipDate = Date ( DateTime ( ld_ShipDate ) ) 
	ELSE
		ld_ShipDate = lstr_Parm.ia_Value 
	END IF
END IF

IF lnv_Msg.of_Get_Parm ( "SEAL" , lstr_Parm ) <> 0 THEN
	lb_Seal = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "SHIPMENTSTATUS" , lstr_Parm ) <> 0 THEN
	ls_ShipmentStatus = String ( lstr_Parm.ia_Value )
END IF

IF lnv_Msg.of_Get_Parm ( "PAYMENTTERMS" , lstr_Parm ) <> 0 THEN
	ls_PaymentTerms = String ( lstr_Parm.ia_Value )
END IF

// THIS Needs to trump any previous setting
IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) = FALSE AND &
	lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) = FALSE THEN
	lb_NonRouted = TRUE
END IF


IF lnv_Msg.of_Get_Parm ( "EQUIPREF" , lstr_Parm ) <> 0 THEN
	ls_EquipRef = lstr_Parm.ia_Value 
END IF

IF lnv_Msg.of_Get_Parm ( "EQUIPTYPE" , lstr_Parm ) <> 0 THEN
	ls_EquipType = lstr_Parm.ia_Value 
	
	CHOOSE CASE ls_EquipType
			
		CASE 'B' // RAIL BOX
			ll_eqType = 26
		CASE 'C' 
			ll_EqType = 20
		CASE 'H'
			ll_EqType = 28  // chassis
	END CHOOSE
	
END IF


IF lnv_Msg.of_Get_Parm ( "REF2LABEL" , lstr_Parm ) <> 0 THEN
	li_Ref2Label = Integer ( lstr_Parm.ia_Value  )
END IF
IF lnv_Msg.of_Get_Parm ( "REF2TEXT" , lstr_Parm ) <> 0 THEN
	ls_Ref2Text = lstr_Parm.ia_Value 
END IF
IF lnv_Msg.of_Get_Parm ( "REF3LABEL" , lstr_Parm ) <> 0 THEN
	li_Ref3Label = Integer ( lstr_Parm.ia_Value )
END IF
IF lnv_Msg.of_Get_Parm ( "REF3TEXT" , lstr_Parm ) <> 0 THEN
	ls_Ref3Text = lstr_Parm.ia_Value 
END IF


ads_Shipment.RowsCopy (al_RowToCopy, al_RowToCopy, PRIMARY!, ads_Shipment, ads_Shipment.RowCount ( ) + 1, PRIMARY! )
// use the fact that the shipment just added is at the end ( rowCount ) of the ds

ll_RowCount = ads_Shipment.RowCount ( )

ads_Shipment.SetItem ( ll_RowCount , "ds_Ship_Date" , ld_ShipDate )
ads_Shipment.SetItem ( ll_RowCount , "ds_id" , al_NewShipID )
ads_Shipment.SetItem ( ll_RowCount , "ds_status" , ls_ShipmentStatus )
ads_Shipment.SetItem ( ll_RowCount , "ds_proNum" , THIS.of_Converttmp ( al_newshipid ) + "-TMP")

ads_Shipment.SetItem ( ll_RowCount , "ds_mod_Log" , ls_ModLog )
ads_Shipment.SetItem ( ll_RowCount , "ds_intsig" , 1 )
ads_Shipment.SetItem ( ll_RowCount , "paymentterms" , ls_PaymentTerms )
SetNull ( ld_ShipDate )
ads_Shipment.SetItem ( ll_RowCount , "ds_bill_date" , ld_ShipDate )

IF lnv_Msg.of_Get_Parm ( "PARENTSHIPMENTID" , lstr_Parm ) <> 0 THEN			// RDT 7-17-03 
	ll_ParentShipID = lstr_Parm.ia_Value 												// RDT 7-17-03 
	ads_Shipment.SetItem ( ll_RowCount , "ds_parentid" , ll_ParentShipID ) 	// RDT 7-17-03 
Else																								// RDT 7-17-03 
	ads_Shipment.SetItem ( ll_RowCount , "ds_parentid" , li_Null ) 		
END IF																							// RDT 7-17-03 


ads_Shipment.SetItem ( ll_RowCount , "ds_pay1_id" , ll_Null ) //carrier

IF Not lb_Seal OR Not lb_Intermodal THEN
	ads_Shipment.SetItem ( ll_RowCount , "seal" , ls_null )
END IF


// if the copy is a routed shipment and the source shipment has
// equipment specified in the ref1 field then we don't want to 
// copy it. so...
IF Not lb_NonRouted THEN // it is going to be a routed copy so..
	CHOOSE CASE  ads_Shipment.GetItemNumber ( ll_RowCount , "ds_ref1_type" )
		CASE 20,26,28 // If the type specifies equipment
			// clear the ref1 text 
			ads_Shipment.SetItem ( ll_RowCount , "ds_ref1_text" , ls_Null )
		END CHOOSE 

	// Do the same thing as above but for Ref2
	CHOOSE CASE  ads_Shipment.GetItemNumber ( ll_RowCount , "ds_ref2_type" )
		CASE 20,26,28 // If the type specifies equipment
			// clear the ref2 text 
			ads_Shipment.SetItem ( ll_RowCount , "ds_ref2_text" , ls_Null )
		END CHOOSE 

	// And for ref 3
	CHOOSE CASE  ads_Shipment.GetItemNumber ( ll_RowCount , "ds_ref3_type" )
		CASE 20,26,28 // If the type specifies equipment
			// clear the ref3 text 
			ads_Shipment.SetItem ( ll_RowCount , "ds_ref3_text" , ls_Null )
		END CHOOSE 
END IF



IF NOT lb_CopyAll THEN  // reset the selected items 

	IF NOT lb_items THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_total_weight" , 0 )
		ads_Shipment.SetItem ( ll_RowCount , "ds_hazmat" , 'F' )
//		IF UPPER ( ads_Shipment.GetItemString ( ll_RowCount , "ds_bill_format" ) ) = "I" THEN 
//			ads_Shipment.SetItem ( ll_RowCount , "ds_lh_totamt" , 0 )
//			ads_Shipment.SetItem ( ll_RowCount , "ds_disc_amt" , 0 )
//			ads_Shipment.SetItem ( ll_RowCount , "ds_disc_pct" , 0 )
//			ads_Shipment.SetItem ( ll_RowCount , "ds_ac_totamt" , 0 )
//			ads_Shipment.SetItem ( ll_RowCount , "ds_bill_charge" , 0 )
//		END IF
		IF UPPER ( ads_Shipment.GetItemString ( ll_RowCount , "ds_pay_format" ) ) = "I" THEN 
			ads_Shipment.SetItem ( ll_RowCount , "ds_pay_lh_totamt" , 0 )
			ads_Shipment.SetItem ( ll_RowCount , "ds_pay_ac_totamt" , 0 )
			ads_Shipment.SetItem ( ll_RowCount , "ds_pay_totamt" , 0 )
		END IF
		
	END IF
	
	
//	IF UPPER ( ads_Shipment.GetItemString ( ll_RowCount , "ds_bill_format" ) ) = "I" THEN
//		IF NOT lb_Freight THEN
//		// if the shipment bill format is per-item clear the item amount in
//	
	

	IF Not lb_ShipNote THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_ship_Comment" , ls_Null )
	END IF
	
	IF Not lb_BillNote THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_bill_Comment" , ls_Null )
	END IF
	
	IF Not lb_Payables THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_pay_lh_totamt" , 0 )
		ads_Shipment.SetItem ( ll_RowCount , "ds_pay_ac_totamt" , 0 )
		ads_Shipment.SetItem ( ll_RowCount , "ds_salescom_amt" , 0 )
		ads_Shipment.SetItem ( ll_RowCount , "ds_pay_totamt" , 0 )
	END IF
	

	IF Not lb_RefLabels OR NOT lb_RefValues THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref1_text" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref2_text" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref3_text" , ls_Null )
	END IF 
	

	IF NOT lb_RefLabels THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref1_type" , 0 )
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref2_type" , 0 )
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref3_type" , 0 )				
	END IF
	
	IF li_Ref2Label > 0 THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref2_type" , li_Ref2Label )
		IF Len ( ls_Ref2Text ) > 0 THEN
			ads_Shipment.SetItem ( ll_RowCount , "ds_ref2_text" , ls_Ref2Text )
		END IF
	END IF
	
	IF li_Ref3Label > 0 THEN
		ads_Shipment.SetItem ( ll_RowCount , "ds_ref3_type" , li_Ref3Label )
		IF  Len ( ls_Ref3Text ) > 0 THEN
			ads_Shipment.SetItem ( ll_RowCount , "ds_ref3_text" , ls_Ref3Text )
		END IF
	END IF
	
	
	
	
	IF NOT lb_CustomFields THEN
		ads_Shipment.SetItem ( ll_RowCount , "custom1" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "custom2" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "custom3" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "custom4" , ls_Null)	
		ads_Shipment.SetItem ( ll_RowCount , "custom5" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "custom6" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "custom7" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "custom8" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "custom9" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "custom10" , ls_Null)	
	END IF

	IF NOT lb_Intermodal THEN
		ads_Shipment.SetItem ( ll_RowCount , "movetype" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "originport" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "destinationport" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "line" , ls_Null)	
		ads_Shipment.SetItem ( ll_RowCount , "vessel" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "voyage" , ls_Null )	
		
		ads_Shipment.SetItem ( ll_RowCount , "cutoffdate" , ld_NullDate )	
		ads_Shipment.SetItem ( ll_RowCount , "cutofftime" , lt_NullTime )
		ads_Shipment.SetItem ( ll_RowCount , "cutoffby",  ls_Null ) 
		ads_Shipment.SetItem ( ll_RowCount , "cutoffuser",ls_Null )  
	
		ads_Shipment.SetItem ( ll_RowCount , "arrivaldate" , ld_NullDate )	
		ads_Shipment.SetItem ( ll_RowCount , "arrivaltime" , lt_NullTime)	
		ads_Shipment.SetItem ( ll_RowCount , "arrivedby",  ls_Null ) 
		ads_Shipment.SetItem ( ll_RowCount , "arriveduser", ls_Null )  
			
		ads_Shipment.SetItem ( ll_RowCount , "lastfreedate" , ld_NullDate )	
		ads_Shipment.SetItem ( ll_RowCount , "lastfreetime" , lt_NullTime)	
		ads_Shipment.SetItem ( ll_RowCount , "lfdby",   ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "lfduser",   ls_Null )
		
		ads_Shipment.SetItem ( ll_RowCount , "booking" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "bookingnumberby",   ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "bookingnumberuser",  ls_Null )
		
		
		ads_Shipment.SetItem ( ll_RowCount , "masterbl" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "housebl" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "forwarderref" , ls_Null)	
		ads_Shipment.SetItem ( ll_RowCount , "agentref" , ls_Null )	
		ads_Shipment.SetItem ( ll_RowCount , "forwarder" , ll_Null )
		ads_Shipment.SetItem ( ll_RowCount , "agent" , ll_Null )
//		clear prenote and ETA stuff
		ads_Shipment.SetItem ( ll_RowCount , "prenotedate" , ld_NullDate )	
		ads_Shipment.SetItem ( ll_RowCount , "prenotetime" , lt_NullTime )
		ads_Shipment.SetItem ( ll_RowCount , "prenoteby" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "prenoteuser" , ls_Null )
		
		ads_Shipment.SetItem ( ll_RowCount , "etadate" , ld_NullDate )	
		ads_Shipment.SetItem ( ll_RowCount , "etatime" , lt_NullTime )
		ads_Shipment.SetItem ( ll_RowCount , "etaby" , ls_Null )
		ads_Shipment.SetItem ( ll_RowCount , "etauser" , ls_Null )
	ELSE
		// see if we copied any data for each set of columns and if so set the current user in the corresponding column
		IF Not IsNull ( ads_Shipment.GetItemDate ( ll_RowCount , "lastfreedate" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemTime ( ll_RowCount , "lastfreetime" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemString ( ll_RowCount , "lfdby" ) ) THEN
		
			ads_Shipment.SetItem ( ll_RowCount , "lfduser",   ls_User )
			
		END IF
		
		IF Not IsNull ( ads_Shipment.GetItemDate ( ll_RowCount , "cutoffdate" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemTime ( ll_RowCount , "cutofftime" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemString ( ll_RowCount , "cutoffby" ) ) THEN
		
			ads_Shipment.SetItem ( ll_RowCount , "cutoffuser",ls_User ) 
			
		END IF
		
		IF Not IsNull ( ads_Shipment.GetItemDate ( ll_RowCount , "arrivaldate" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemTime ( ll_RowCount , "arrivaltime" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemString ( ll_RowCount , "arrivedby" ) ) THEN
		
			ads_Shipment.SetItem ( ll_RowCount , "arriveduser", ls_User )  
			
		END IF
		
		IF Not IsNull ( ads_Shipment.GetItemString ( ll_RowCount , "booking" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemString ( ll_RowCount , "bookingnumberby" ) ) THEN
		
			ads_Shipment.SetItem ( ll_RowCount , "bookingnumberuser",  ls_User )  
			
		END IF
		
		IF Not IsNull ( ads_Shipment.GetItemDate ( ll_RowCount , "prenotedate" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemTime ( ll_RowCount , "prenotetime" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemString ( ll_RowCount , "prenoteby" ) ) THEN
	
			ads_Shipment.SetItem ( ll_RowCount , "prenoteuser" , ls_User ) 
			
		END IF
		
		IF Not IsNull ( ads_Shipment.GetItemDate ( ll_RowCount , "etadate" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemTime ( ll_RowCount , "etatime" ) ) OR &
			Not IsNull ( ads_Shipment.GetItemString ( ll_RowCount , "etaby" ) ) THEN
	
			ads_Shipment.SetItem ( ll_RowCount , "etauser" , ls_User )
			
		END IF
		
		
		
	END IF

END IF

// <<*>> 7/21/05
ads_Shipment.SetItem ( ll_RowCount , "dispatchedby", ls_Null )	 


ads_Shipment.SetItem ( ll_RowCount , "groundeddate", ld_NullDate )	 
ads_Shipment.SetItem ( ll_RowCount , "groundedtime", lt_NullTime )
ads_Shipment.SetItem ( ll_RowCount , "groundedby", ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "groundeduser", ls_Null )

ads_Shipment.SetItem ( ll_RowCount , "pickupnumber",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "pickupnumberby",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "pickupnumberuser",   ls_Null )



ads_Shipment.SetItem ( ll_RowCount , "releasedate",   ld_NullDate )	
ads_Shipment.SetItem ( ll_RowCount , "releasetime",   lt_NullTime )
ads_Shipment.SetItem ( ll_RowCount , "releaseby",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "releaseuser",  ls_Null )

ads_Shipment.SetItem ( ll_RowCount , "pickupbydate",   ld_NullDate )	
ads_Shipment.SetItem ( ll_RowCount , "pickupbytime",   lt_NullTime )
ads_Shipment.SetItem ( ll_RowCount , "pickupbyby",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "pickupbyuser",ls_Null )

ads_Shipment.SetItem ( ll_RowCount , "delbydate",   ld_NullDate )	
ads_Shipment.SetItem ( ll_RowCount , "delbytime",   lt_NullTime )
ads_Shipment.SetItem ( ll_RowCount , "delbyby", ls_Null )  
ads_Shipment.SetItem ( ll_RowCount , "delbyuser", ls_Null ) 

ads_Shipment.SetItem ( ll_RowCount , "emptyatcustomerdate",   ld_NullDate )	
ads_Shipment.SetItem ( ll_RowCount , "emptyatcustomertime",   lt_NullTime )
ads_Shipment.SetItem ( ll_RowCount , "emptyatcustomerby",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "emptyatcustomeruser", ls_Null )  

ads_Shipment.SetItem ( ll_RowCount , "loadedatcustomerdate",   ld_NullDate )	
ads_Shipment.SetItem ( ll_RowCount , "loadedatcustomertime",   lt_NullTime )
ads_Shipment.SetItem ( ll_RowCount , "loadedatcustomerby",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "loadedatcustomeruser", ls_Null )  

ads_Shipment.SetItem ( ll_RowCount , "railbillnumber",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "railbillnumberuser", ls_Null )  

ads_Shipment.SetItem ( ll_RowCount , "railbilleddate",   ld_NullDate )	
ads_Shipment.SetItem ( ll_RowCount , "railbilledby",   ls_Null )
ads_Shipment.SetItem ( ll_RowCount , "railbilleduser", ls_Null )

ads_Shipment.SetItem ( ll_RowCount , "edireference", ls_Null )



IF lb_Template THEN
	ads_Shipment.SetItem ( ll_RowCount , "ds_ref1_text" , ls_Null )
//	ads_Shipment.SetItem ( ll_RowCount , "ds_ref1_type" , 0)		
END IF	

IF Len ( ls_EquipRef ) > 0 THEN
	ads_Shipment.SetItem ( ll_RowCount , "ds_ref1_text" , ls_EquipRef )
	ads_Shipment.SetItem ( ll_RowCount , "ds_ref1_type" , ll_EqType )		
END IF	

IF NOT lb_NonRouted THEN
	ls_DorB = "T" 
ELSE 
	ls_DorB = "D" 
END IF

ads_Shipment.SetItem ( ll_RowCount , "ds_dorb" , ls_DorB )	

Long	ll_BillTo

ll_BillTo = ads_Shipment.GetItemNumber ( ll_RowCount , "ds_billto_id" )
IF ll_BillTo > 0 AND lnv_LicenseMgr.of_HasDocumentttansfer( ) THEN
	n_Cst_bso_Document_Manager	lnv_DocMan
	lnv_DocMan = CREATE n_Cst_bso_Document_Manager
	lnv_DocMan.of_Addtransferrequestforcompany( ll_BillTo , al_newshipid )
	lnv_DocMan.event pt_save( )
	DESTROY ( lnv_DocMan )
END IF




RETURN 1
end function

private function integer of_copyitems (long al_nextshipmentid, ref n_ds ads_items, n_cst_msg anv_msg);Int	j
Long	ll_NextItemID
Long	ll_ItemCount
decimal	lc_null
Boolean	lb_BLNum
Boolean	lb_Payables=true
Boolean	lb_Freight = TRUE
Boolean	lb_Acc = TRUE
String	ls_Null
S_Parm	lstr_parm
SetNull ( ls_Null )
setnull(lc_null)
Char	lc_Type

//THIS.of_GetNextItemID ( ll_NextItemID )
IF anv_msg.of_Get_Parm ( "BLNUM" , lstr_Parm ) <> 0 THEN
	lb_BLNum = lstr_parm.ia_Value
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_Payables , lstr_Parm ) <> 0 THEN
	lb_Payables = lstr_Parm.ia_Value
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_FreightItems , lstr_Parm ) <> 0 THEN
	lb_Freight = lstr_Parm.ia_Value
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_AccItems , lstr_Parm ) <> 0 THEN
	lb_Acc = lstr_Parm.ia_Value
END IF


ll_ItemCount = ads_Items.RowCount ( )
FOR  j = 1 To ll_ItemCount // alter the items
	
	lc_Type = ads_Items.GetItemString ( j, "di_Item_Type" )
	
	IF ( lc_Type = "L" and Not lb_Freight ) OR ( lc_Type = "A" and NOT lb_Acc ) THEN
		CONTINUE
	END IF
	
	THIS.of_GetNextItemID ( ll_NextItemID )
	
	ads_Items.RowsCopy (j, j, PRIMARY!, ads_Items,ads_Items.RowCount ( ) + 1,PRIMARY! )
		
	ads_Items.SetItem ( ads_Items.RowCount ( ) , "di_item_id" , ll_NextItemID )
	ads_Items.SetItem ( ads_Items.RowCount ( ) , "di_Shipment_id" , al_NextShipmentID )
	IF NOT lb_BLNum THEN
		ads_Items.SetItem ( ads_Items.RowCount ( ) , "di_blnum" , ls_Null )
	END IF
	if not lb_payables then
		ads_Items.SetItem ( ads_Items.RowCount ( ) , "di_pay_itemamt" , lc_Null )
		ads_Items.SetItem ( ads_Items.RowCount ( ) , "di_pay_rate" , lc_Null )
		ads_Items.SetItem ( ads_Items.RowCount ( ) , "di_pay_ratetype" , appeon_constant.cs_RateUnit_Code_None  )
	end if
	
	
NEXT
		
Return 1
end function

private function integer of_getorigevent (n_ds ads_source, ref n_cst_msg anv_msg);Long	ll_FindRow
Long	ll_Hook
Long	ll_Mount

S_Parm		lstr_parm

IF Not isValid ( ads_Source ) THEN
	RETURN -1
END IF

// look for the first hook
ll_FindRow = ads_Source.Find ( "de_event_type = '" + gc_Dispatch.cs_EventType_hook + "'" , 1, 999 )
IF ll_FindRow > 0 THEN
	ll_Hook = ads_Source.object.de_id [ ll_FindRow ]
	ll_FindRow = 0
END IF

//look for the first mount
ll_FindRow = ads_Source.Find ( "de_event_type = '" + gc_Dispatch.cs_EventType_Mount +"'" , 1, 999 )
IF ll_FindRow > 0 THEN
	ll_Mount = ads_Source.object.de_id [ ll_FindRow ]
	ll_FindRow = 0
END IF

lstr_Parm.is_Label = "HOOK"
lstr_parm.ia_Value = ll_Hook
anv_msg.of_add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "MOUNT"
lstr_parm.ia_Value = ll_Mount
anv_msg.of_add_Parm ( lstr_Parm ) 



RETURN 1

end function

private function integer of_gettermevent (n_ds ads_source, ref n_cst_msg anv_msg);Long	ll_FindRow
Long	ll_drop
Long	ll_Dismount

S_Parm		lstr_parm

IF Not isValid ( ads_Source ) THEN
	RETURN -1
END IF

// look for the first drop
ll_FindRow = ads_Source.Find ( "de_event_type = '" + gc_Dispatch.cs_EventType_drop + "'" , 1, 999 )
IF ll_FindRow > 0 THEN
	ll_drop = ads_Source.object.de_id [ ll_FindRow ]
	ll_FindRow = 0
END IF

//look for the first dismount
ll_FindRow = ads_Source.Find ( "de_event_type = '" + gc_Dispatch.cs_EventType_disMount +"'" , 1, 999 )
IF ll_FindRow > 0 THEN
	ll_Dismount = ads_Source.object.de_id [ ll_FindRow ]
	ll_FindRow = 0
END IF

lstr_Parm.is_Label = "DROP"
lstr_parm.ia_Value = ll_drop
anv_msg.of_add_Parm ( lstr_Parm ) 

lstr_Parm.is_Label = "DISMOUNT"
lstr_parm.ia_Value = ll_Dismount
anv_msg.of_add_Parm ( lstr_Parm ) 

RETURN 1

end function

private function integer of_copyevents (long al_shipmentid, ref n_ds ads_events, n_cst_msg anv_msg, ref n_cst_msg anv_eventsmsg);Long	ll_NextEventID
Long	j
Long	ll_EventCount
Long	ll_DestinationID
Long	ll_OriginID
Long	ll_RowCount
Boolean	lb_IncludeItems = TRUE
Boolean	lb_NonRouted 
Boolean	lb_Template 
Boolean	lb_ConfirmEvents
Boolean	lb_CopyNotes
Boolean	lb_KeepDates
Boolean	lb_KeepTimes

Long	ll_Hook
Long	ll_Mount
Long	ll_Drop
Long	ll_DisMount

Long	ll_Null	
Date	ld_Null
Time	lt_Null
Int	li_Null
String	ls_Null

Integer		li_Index, &
				li_Min, &
				li_Max
				
S_Parm 	lstr_Parm

SetNull  ( ll_Null )
SetNull  ( lt_Null )
SetNull  ( ld_Null )
SetNull 	( ls_Null )
SetNull 	( li_Null )

n_cst_Events	lnv_Events
n_cst_Beo_Event	lnv_Event  
n_cst_String	lnv_String
n_ds				lds_TempEvents

lds_TempEvents = CREATE n_ds
lds_TempEvents.DataObject = ads_events.DataObject 

lnv_Event = CREATE n_cst_beo_event

IF anv_Msg.of_Get_Parm ( "TEMPLATE" , lstr_parm ) <> 0 THEN
	lb_Template = lstr_Parm.ia_Value	
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_NonRouted , lstr_parm ) <> 0 THEN
	lb_NonRouted = lstr_Parm.ia_Value	
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_Items , lstr_parm ) <> 0 THEN
	lb_IncludeItems = lstr_Parm.ia_Value	
END IF

IF anv_Msg.of_Get_Parm ( "CONFIRMEVENTS" , lstr_Parm ) <> 0 THEN
	lb_ConfirmEvents = lstr_Parm.ia_Value
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_EventNotes , lstr_parm ) <> 0 THEN
	lb_CopyNotes = lstr_Parm.ia_Value	
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_EventDates , lstr_parm ) <> 0 THEN
	lb_KeepDates = lstr_Parm.ia_Value	
END IF

IF anv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_EventTimes , lstr_parm ) <> 0 THEN
	lb_KeepTimes = lstr_Parm.ia_Value	
END IF

//THIS.of_GetNextEventID ( ll_NextEventID )


ll_EventCount =  ads_Events.RowCount ( )

FOR j = 1 TO ll_EventCount  // alter the events

	IF THIS.of_GetNextEventID ( ll_NextEventID ) <> 1 THEN
		CONTINUE
	END IF

	// copy one row at a time to the newEvent ds and change what is neccessary
	ads_Events.RowsCopy (j, j, PRIMARY!, lds_TempEvents,lds_TempEvents.RowCount ( ) + 1,PRIMARY! )
	
	ll_RowCount = lds_TempEvents.RowCount ( )
	
	lds_TempEvents.SetItem ( ll_RowCount , "de_id" , ll_NextEventID )
	lds_TempEvents.SetItem ( ll_RowCount , "de_Shipment_id" , al_ShipmentID )
	
	lnv_Event.of_SetSource ( lds_TempEvents )
	lnv_Event.of_SetSourceID ( ll_NextEventID )
	
	
	// clear the routing info
	lnv_Events.of_GetMinMaxIndex ( li_Min, li_Max )

	FOR li_Index = li_Min TO li_Max
		lnv_Event.of_AssignByIndex ( li_Index, ll_Null, TRUE, 0 )
	NEXT
	
	li_Index = gc_Dispatch.ci_Assignment_Trip
	lnv_Event.of_AssignByIndex ( li_Index, ll_Null, TRUE, 0 )
		
		
	//Clear out the other info
	lds_TempEvents.SetItem ( ll_RowCount , "de_apptdate" , ld_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_appttime" , lt_null )
	
	
	lds_TempEvents.SetItem ( ll_RowCount , "de_apptnum" , ls_null )
	
//	IF NOT lb_NonRouted THEN  // if it is a non-routed shipment then don't clear the dates/times
//		lds_TempEvents.SetItem ( ll_RowCount , "de_arrdate" , ld_null )
//		lds_TempEvents.SetItem ( ll_RowCount , "de_arrtime" , lt_null )
//		lds_TempEvents.SetItem ( ll_RowCount , "de_depdate" , ld_null )
//		lds_TempEvents.SetItem ( ll_RowCount , "de_deptime" , lt_null )
//	END IF


	IF NOT lb_KeepDates THEN
		lds_TempEvents.SetItem ( ll_RowCount , "de_arrdate" , ld_null )
		lds_TempEvents.SetItem ( ll_RowCount , "de_depdate" , ld_null )
		
	END IF
	
	IF NOT lb_KeepTimes THEN
		lds_TempEvents.SetItem ( ll_RowCount , "de_arrtime" , lt_null )
		lds_TempEvents.SetItem ( ll_RowCount , "de_deptime" , lt_null )
	END IF
	
	lds_TempEvents.SetItem ( ll_RowCount , "de_odom" , li_null )
	
	IF lb_ConfirmEvents OR lds_TempEvents.GetItemString ( ll_RowCount , "disp_events_Routable" ) = 'F' THEN
		lds_TempEvents.SetItem ( ll_RowCount , "de_conf" , 'T' )
		lds_TempEvents.SetItem ( ll_RowCount , "de_whoconf" , gnv_app.of_getUserID ( ) )		
	ELSE		
		lds_TempEvents.SetItem ( ll_RowCount , "de_conf" , 'F' )
		lds_TempEvents.SetItem ( ll_RowCount , "de_whoconf" , ls_null )
	END IF
	
	lds_TempEvents.SetItem ( ll_RowCount , "de_intsig" , 1 )
	lds_TempEvents.SetItem ( ll_RowCount , "de_locked" , ls_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_gallons" , li_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_price" , li_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_status" , ls_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_eta" , lt_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_multi_list" , ls_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_acteq" , li_null )
	lds_TempEvents.SetItem ( ll_RowCount , "de_acteq_seq" , 0 )	
	lds_TempEvents.SetItem ( ll_RowCount , "disp_events_bobtailoriginevent" , li_null )	
	lds_TempEvents.SetItem ( ll_RowCount , "disp_events_bobtaildestinationevent" , li_null )	
	
	// check for the conditional copies
	IF NOT lb_IncludeItems THEN
		lds_TempEvents.SetItem ( ll_RowCount , "de_Freightsplit" , li_null )
		lds_TempEvents.SetItem ( ll_RowCount , "de_accesssplit" , li_null )	
	END IF
	
	IF NOT lb_CopyNotes THEN
		//IF NOT lb_Template THEN
			lds_TempEvents.SetItem ( ll_RowCount , "de_note" , ls_null )
		//END IF
	END IF
				
	//ll_NextEventID ++
		
NEXT

n_cst_beo_event	lnv_Event1
n_cst_beo_event	lnv_Event2
n_cst_beo_event	lnv_Event3
n_cst_beo_event	lnv_Event4

lnv_Event1 = CREATE n_cst_beo_Event
lnv_Event2 = CREATE n_cst_beo_Event
lnv_Event3 = CREATE n_cst_beo_Event
lnv_Event4 = CREATE n_cst_beo_Event

Long	ll_BTOrigin
Long	ll_BTDest
lnv_Event.of_SetSource ( ads_events )
lnv_Event1.of_SetSource ( ads_events )
lnv_Event2.of_SetSource ( ads_events )

lnv_Event3.of_SetSource ( lds_TempEvents )
lnv_Event4.of_SetSource ( lds_TempEvents )


FOR j = 1 TO ads_events.RowCount ( )
	
	lnv_Event.of_SetSource ( ads_events )
	lnv_Event.of_SetSourceRow( j )
	IF lnv_Event.of_Isbobtailevent( ) THEN
		
		lnv_Event.of_GetBobtaileventids( ll_BTOrigin, ll_BTDest )
		lnv_Event1.of_SetSourceID ( ll_BTOrigin ) 				
		lnv_Event2.of_SetSourceID ( ll_BTDest )
		
		lnv_Event3.of_SetSourceRow ( lnv_Event1.of_GetShipseq( ) )
		lnv_Event4.of_SetSourceRow ( lnv_Event2.of_GetShipSeq( ) )
		
		lnv_Event3.of_SetBobtaillocations( lnv_Event3.of_GetID ( ) ,lnv_Event4.of_GetID ( ) )
		lnv_Event4.of_SetBobtaillocations( lnv_Event3.of_GetID ( ) ,lnv_Event4.of_GetID ( ) )
		j ++
		
	END IF
	
NEXT

lds_TempEvents.RowsCopy (1, lds_TempEvents.RowCount ( ), PRIMARY!, ads_Events,ads_Events.RowCount ( ) + 1,PRIMARY! )

DESTROY lnv_Event
DESTROY lnv_Event1
DESTROY lnv_Event2
DESTROY lnv_Event3
DESTROY lnv_Event4

Return 1
end function

private function integer of_getsitesforduplication (readonly n_cst_msg anv_msg, readonly n_cst_msg anv_eventmsg, ref n_cst_msg anv_rtn_msg);Long		ll_OriginSite
Long		ll_TerminationSite
String	ls_Origin
String	ls_Term
String	ls_Type

Int		li_Return = 1

DataStore	lds_Events
n_cst_beo_Event	lnv_Event
S_Parm	lstr_Parm

lnv_Event = CREATE n_cst_beo_Event

IF anv_Msg.of_Get_Parm ( "ORIGINSITE" , lstr_Parm ) <> 0 THEN
	ll_OriginSite = lstr_Parm.ia_Value
END IF

IF anv_Msg.of_Get_Parm ( "TERMINATIONSITE" , lstr_Parm ) <> 0 THEN
	ll_TerminationSite = lstr_Parm.ia_Value
END IF


IF ll_OriginSite = 0 OR ll_TerminationSite = 0 THEN
	lds_Events = inv_Dispatch.of_GetEventCache ( )

	IF anv_Msg.of_Get_Parm ( "EQUIPTYPE" , lstr_Parm ) <> 0 THEN
		ls_Type =  Trim ( lstr_Parm.ia_Value )
	END IF
	
	
	CHOOSE CASE ls_Type
		CASE 'C'
			ls_Origin = "MOUNT"
			ls_Term = "DISMOUNT"
			
		CASE ELSE
			ls_Origin = "HOOK"
			ls_Term = "DROP"
			
	END CHOOSE
	IF ll_OriginSite = 0 THEN
		IF anv_EventMsg.of_Get_Parm ( ls_Origin , lstr_Parm ) <> 0 THEN
			ll_OriginSite = lstr_Parm.ia_Value
			lnv_Event.of_SetSource ( lds_Events )
			lnv_Event.of_SetSourceID ( ll_OriginSite )
			IF lnv_Event.of_HasSource ( ) THEN
				ll_OriginSite = lnv_Event.of_GetSite ( )
			END IF
		ELSE
			li_Return = -1
		END IF
	END IF
	
	IF ll_TerminationSite = 0 THEN
		IF anv_EventMsg.of_Get_Parm ( ls_Term , lstr_Parm ) <> 0 THEN
			ll_TerminationSite = lstr_Parm.ia_Value
			lnv_Event.of_SetSource ( lds_Events )
			lnv_Event.of_SetSourceID ( ll_TerminationSite )
			IF lnv_Event.of_HasSource ( ) THEN
				ll_TerminationSite = lnv_Event.of_GetSite ( )
			END IF
		ELSE
			li_Return = -1
		END IF
	END IF
	
END IF

anv_Rtn_Msg.of_Reset ( )
IF ll_OriginSite <> 0 THEN
	lstr_Parm.is_Label = "ORIGINSITE"
	lstr_Parm.ia_Value = ll_OriginSite
	anv_Rtn_msg.of_Add_Parm ( lstr_Parm )
END IF

IF ll_TerminationSite <> 0 THEN
	lstr_Parm.is_Label = "TERMINATIONSITE"
	lstr_Parm.ia_Value = ll_TerminationSite
	anv_Rtn_msg.of_Add_Parm ( lstr_Parm )
END IF

DESTROY ( lnv_Event )


RETURN li_Return
			
		
	

end function

public function boolean of_doesshipmenthaveequipmentlinked (long al_shipmentid);String	ls_Where

n_cst_EquipmentManager	lnv_Equip
DataStore	lds_Results

ls_Where = "WHERE eq_status ='K' AND outside_equip.shipment = " + STRING ( al_ShipmentID ) 

lnv_Equip.of_Retrieve ( lds_Results , ls_Where ) 

RETURN lds_Results.RowCount ( ) >= 1
end function

public subroutine of_setautoratingmode (boolean ab_mode);ib_autoratingmode = ab_mode
end subroutine

public function boolean of_isautoratingmode ();return ib_autoratingmode
end function

public subroutine of_setratedata (n_cst_ratedata anva_ratedata[]);inva_ratedata = anva_ratedata
end subroutine

public subroutine of_getratedata (ref n_cst_ratedata anva_ratedata[]);anva_ratedata = inva_ratedata
end subroutine

private function integer of_updateshipment (long al_shipmentid, ref n_cst_edi_204_record anv_204record);/*

This method will make the following changes to the shipment:
	
	1) IFF the sites in the event notes match the sites for the event then 
			If the site in the file is different it will become the new site,
	2) IF the number of stops in the file is different then the stops in the file will become 
		the new set of stops.
	3) Freight info will be updated


*/
Boolean				lb_Continue = TRUE
Long					ll_ExistingStopCount
Long					ll_SiteFromEvent
Long					ll_SiteFromNote
Long					ll_FileSite
Long					lla_EventIDs[]
Long					ll_EventCount
Long					ll_NewitemID
Long					ll_ItemCount
String				ls_ErrorMessage
Int					li_Set
Dec					lc_Weight
Dec					lc_Qty
String				ls_FreightDesc
Long					ll_StopOffCount
Long					i
String				ls_WeightQual
Int					li_Return = 1
Date					ld_StopDate
Time					lt_StopTime

DataStore				lds_Items
DataStore				lds_Shipments
n_cst_Bso_Dispatch	lnv_Dispatch
n_cst_Beo_Shipment	lnv_Shipment
n_cst_beo_Item			lnv_Item
n_cst_beo_Event		lnva_Events[]
n_cst_beo_Event		lnv_CurrentEvent
n_cst_beo_Company		lnv_Company

lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Dispatch = CREATE n_cst_bso_Dispatch
lnv_Item 	 = CREATE n_cst_beo_Item

IF al_shipmentid > 0 THEN
	
	anv_204record.of_SetShipmentID ( al_ShipmentID )
	
	// set up the shipment beo	
	lnv_Dispatch.of_RetrieveShipment ( al_shipmentid )
	lds_Shipments = lnv_Dispatch.of_GetShipmentCache ( ) 
	lnv_Shipment.of_Setsource ( lds_Shipments )
	lnv_Shipment.of_SetSourceId ( al_shipmentid ) 
	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache () )
	lnv_Shipment.of_SetAllowFilterSet  ( TRUE )
	
	// get the stop count for the shipment
	ll_ExistingStopCount = lnv_Shipment.of_geteventlist ( lnva_Events )
	
	// get the stop count for the 204 message
	ll_StopOffCount = anv_204record.of_GetStopCount ( ) 
		
	// compare the two values and see if a change is warrented
	IF ll_StopOffCount <> ll_ExistingStopCount THEN
		
		//  remove all the existing stops 
		lnv_Shipment.of_GetEventIDs ( lla_EventIDs )
		IF lnv_Shipment.of_RemoveEvents ( lla_EventIDs , lnv_Dispatch ,FALSE ) = -1 THEN
			li_Return = -1
			ls_ErrorMessage += "Could not remove events to make changes."
			lb_Continue = FALSE
		ELSE
			// replace stops
			THIS.of_addStopsFrom204 ( anv_204record , lnv_Shipment , lnv_Dispatch )
		END IF
		
	ELSE
	
		// now check to see if the sites match the original
		 
		FOR i = 1 TO ll_ExistingStopCount
			
			lnv_CurrentEvent = lnva_Events[i]
			lnv_CurrentEvent.of_SetAllowFilterSet ( TRUE )
			
			// get the site for the current event 
			IF lnv_CurrentEvent.of_getsite ( lnv_company ) = 1 THEN
				ll_SiteFromEvent = lnv_Company.of_GetID ( )
			ELSE
				SetNull ( ll_SiteFromEvent ) 
			END IF
			
			// get and parse the event note for event i
			ll_SiteFromNote = lnv_CurrentEvent.of_GetSiteFromNote ( )
			
			// compare the 2 sites					
			IF ll_SiteFromNote = ll_SiteFromEvent OR & 
			Isnull ( ll_SiteFromNote ) AND isNull ( ll_SiteFromEvent  )THEN
				
				// get the site from the file
				ll_FileSite = anv_204record.of_GetSite ( i )
				IF ll_FileSite > 0 THEN
					li_Set =	lnv_CurrentEvent.of_SetSite ( ll_FileSite )
				  	li_Set =	lnv_CurrentEvent.of_setSiteInEventNote ( ll_FileSite ) 
				ELSE
					li_Return = -1
					ls_ErrorMessage += "Could not add site to event [" + anv_204record.of_GetStringSite ( i ) + "]. "
				END IF				
				
				ld_StopDate = anv_204record.of_GetStopDate ( i )
				IF NOT isNull ( ld_StopDate ) THEN
					lnv_CurrentEvent.of_setScheduledDate ( ld_StopDate )
				END IF
				
				lt_StopTime = anv_204record.of_GetStopTime ( i )
				IF NOT isNull ( lt_StopTime ) THEN
					lnv_CurrentEvent.of_setScheduledTime ( lt_StopTime )
				END IF
		
			END IF
		NEXT
		
	END IF   
	
	IF lb_Continue THEN
		lnv_Shipment.of_SetDefaultOrigin ( )
		lnv_Shipment.of_SetDefaultDestination ( )	
		
		// Now set the Comodity description and amounts
				
		lds_Items = lnv_Dispatch.of_GetItemCache ( )
		lnv_Shipment.of_SetItemSource ( lds_Items )
	
		ls_FreightDesc = anv_204record.of_GetDescription ( ) 
		lc_Weight 		= anv_204record.of_GetWeight ( ) 
		lc_Qty			= anv_204record.of_GetQty ( ) 
		
		IF Len ( ls_FreightDesc ) > 0 OR  lc_Weight > 0 OR lc_Qty > 0  THEN
			
			lnv_Shipment.of_removeFreightItems ( lnv_Dispatch )
			ll_NewItemID = lnv_Shipment.of_AddItem ( "FREIGHT!", lnv_Dispatch )
			
			lnv_Item.of_SetSource ( lds_Items )
			lnv_Item.of_SetSourceId ( ll_NewItemID )
			lnv_Item.of_SetShipment ( lnv_Shipment )
			
			THIS.of_SetItemData ( lnv_Item , anv_204record )
			
		END IF
		
		IF anv_204record.of_IsReal204 ( ) THEN
			THIS.of_SetShipmentData ( lnv_Shipment , anv_204record )
		END IF
		
		IF lnv_Dispatch.Event pt_Save ( ) <> 1 THEN
			li_Return = -1
			ls_ErrorMessage += "Could not save the changes to the shipment. "
		END IF
	END IF
	
END IF

anv_204record.of_SetSuccessfulImportFlag ( li_Return = 1 )
anv_204Record.of_SetErrorText ( ls_ErrorMessage )

DESTROY ( lnv_Dispatch )
DESTROY ( lnv_Shipment )
DESTROY ( lnv_Item )
DESTROY lnv_Company


FOR i = 1 TO ll_EventCount 
	DESTROY ( lnva_Events[ i ] )
NEXT

RETURN li_Return


end function

private function integer of_setshipmentdata (ref n_cst_beo_shipment anv_shipment, ref n_cst_edi_204_record anv_204record);Int		li_Return = 1
long		ll_BillToID
String	ls_AttemptedBillTo
String	ls_ErrorText
Long		ll_ShipmentID
Dec {2}  lc_ShipmentCharge




IF Not isValid ( anv_Shipment ) THEN
	li_Return = -1
	ls_ErrorText = "Shipment not valid in set shipment data."
END IF


IF li_Return = 1 THEN
	
//	ll_ShipmentID = anv_Shipment

	lc_ShipmentCharge = anv_204Record.of_GetTotalCharge ( )
	IF lc_ShipmentCharge > 0 THEN
		IF anv_Shipment.of_SetNetCharge ( lc_ShipmentCharge ) <> 1 THEN
			li_Return = -1
			ls_ErrorText +="Could not set the shipment charge total. "
		END IF
	END IF
	
	IF anv_Shipment.of_SetBillingFormat ( anv_204Record.of_GetbillFormat ( ) ) <> 1 THEN
		li_Return = -1
		ls_ErrorText +="Could not set the billing format. "
	END IF

	IF anv_Shipment.of_SetRequiredEquipment ( anv_204Record.of_GetRequiredEquipment ( ) ) <> 1 THEN
		li_Return = -1
		ls_ErrorText +="Could not set the required equipment. "
	END IF

	IF anv_Shipment.of_SetShipmentComments ( anv_204Record.of_GetShipmentNote ( ) ) <> 1 THEN
		li_Return = -1
		ls_ErrorText +="Could not set the shipment comments. "
	END IF
	
	IF anv_Shipment.of_SetBillingComments ( anv_204Record.of_GetBillNotes ( ) ) <> 1 THEN
		li_Return = -1
		ls_ErrorText +="Could not set the billing comments. "
	END IF
	
	IF anv_Shipment.of_SetRef1Text ( anv_204Record.of_GetRef1Text ( ) ) <> 1 OR &
		anv_Shipment.of_SetRef1Type  ( anv_204Record.of_GetRef1Type ( ) ) <> 1 THEN //BL NUM
		
		li_Return = -1
		ls_ErrorText += "Could not set the Ref 1 field. " 
		
	END IF
	
	IF anv_Shipment.of_SetRef2Text ( anv_204Record.of_GetRef2Text ( ) ) <> 1 OR &
		anv_Shipment.of_SetRef2Type  ( anv_204Record.of_GetRef2Type ( ) ) <> 1 THEN 
		
		li_Return = -1
		ls_ErrorText += "Could not set the Ref 2 field. "
		
	END IF
	
	
	IF anv_Shipment.of_SetRef3Text ( anv_204Record.of_GetRef3Text ( ) ) <> 1 OR &
		anv_Shipment.of_SetRef3Type  ( anv_204Record.of_GetRef3Type ( ) ) <> 1 THEN
		
		li_Return = -1
		ls_ErrorText += "Could not set the Ref 3 field. "
		
	END IF 
	
	IF THIS.of_SetCustomText ( anv_Shipment , anv_204record ) <> 1 THEN
		li_Return = -1
		ls_ErrorText += "Could not set the Custom Text field. "
	END IF
	
	anv_Shipment.of_SetImportReference ( anv_204Record.of_GetEDIshipmentIDNumber ( ) )
	
	anv_Shipment.of_SetShipDate ( anv_204Record.of_GetShipmentDate ( ) )
	
	// if a bill to has been specified then set it
	ls_AttemptedBillTo = anv_204Record.of_GetAttemptedBillToName ( )
	IF Len ( Trim ( ls_AttemptedBillTo ) ) > 0 THEN
		ll_BillToID = anv_204Record.of_GetBillToID ( )
		IF ll_BillToID > 0 THEN
			anv_Shipment.of_SetBillToID ( ll_BillToID )
		ELSE
			ls_ErrorText += "Could not set the BillTo for [" + ls_AttemptedBillTo +"]. "
			li_Return = -1
		END IF
	END IF
	
	

END IF

	

anv_204Record.of_SetErrorText ( ls_Errortext )
anv_204Record.of_SetsuccessfulImportFlag ( li_Return = 1 )

RETURN li_Return 
end function

private function integer of_setitemdata (ref n_cst_beo_item anv_item, ref n_cst_edi_204_record anv_204record);Int		li_Return = 1
String	ls_ErrorText
String	ls_FreightDesc
String	ls_WeightQual
Dec		lc_Weight
Dec		lc_Qty
Dec		lc_FreightRate

ls_FreightDesc 	= anv_204record.of_GetDescription ( ) 
lc_Weight 			= anv_204record.of_GetWeight ( ) 
ls_WeightQual		= anv_204record.of_GEtWeightQualifier ( ) 
lc_Qty				= anv_204record.of_GetQty ( ) 
lc_FreightRate    = anv_204record.of_GetFreightRate ( 1 ) 


IF lc_FreightRate > 0  THEN
	ls_WeightQual = appeon_constant.cs_rateunit_code_flat
END IF
	

anv_Item.of_SetAllowFilterSet ( TRUE ) 

IF anv_Item.of_SetPuEvent ( 1 )  <> 1 THEN
	li_Return = -1
	ls_ErrorText += "Could not set the Pickup event on the item. "
END IF


IF anv_Item.of_SetDelEvent ( anv_204record.of_getStopCount ( ) ) <> 1 THEN
	li_Return = -1
	ls_ErrorText += "Could not set the Delivery event on the item. "
END IF


IF anv_Item.of_SetDescription ( ls_FreightDesc ) <> 1 THEN
	li_Return = -1
	ls_ErrorText += "Could not set the item description. "
END IF


IF anv_Item.of_SetQuantity ( lc_Qty ) <> 1 THEN
	li_Return = -1
	ls_ErrorText += "Could not set the item quantity. "
END IF

IF anv_Item.of_SetTotalWeight ( lc_Weight )  <> 1 THEN
	li_Return = -1
	ls_ErrorText += "Could not set the item weight. "
END IF

IF anv_Item.of_SetRateType ( ls_WeightQual ) <> 1 THEN
	li_Return = -1
	ls_ErrorText += "Could not set the weight qualifier. "
END IF

IF	anv_Item.of_setRate (lc_FreightRate) <> 1 THEN
	li_Return = -1
	ls_ErrorText += "Could not set the item rate. "
END IF


anv_204record.of_SetErrorText ( ls_ErrorText )
anv_204record.of_SetSuccessfulImportFlag ( li_Return = 1 ) 


RETURN li_Return 
end function

public function integer of_createshipment (ref n_cst_edi_204_record anv_204record);Long						ll_NewShipmentID
Long						ll_EventCount
Long						lla_EventIDs[]
Int						li_Return = 1
String					ls_ErrorText
Int						i
Boolean					lb_HaveShipment
DataStore				lds_Items
DataStore				lds_Shipments
n_cst_msg				lnv_Msg
S_Parm					lstr_Parm
n_cst_Bso_Dispatch	lnv_Dispatch
n_cst_Beo_Shipment	lnv_Shipment
n_cst_beo_Item			lnva_Items[]
n_cst_beo_Item			lnv_Item
Time 		lt_FirstAttempt

lnv_Dispatch = CREATE n_cst_bso_Dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment

lstr_Parm.is_Label = "Display"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Notify"  // upon failure 
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

FOR i = 1 TO 5 

	ll_NewShipmentID = THIS.of_NewShipment ( lnv_Msg )
	IF ll_NewShipmentID > 0 THEN
		lb_HaveShipment = TRUE
		EXIT
	ELSE
		// we want to wait a bit here before we try to get a new ship id
		// so we will spin here for 5 seconds
		lt_FirstAttempt = Now ( )
		DO 
		
		LOOP UNTIL SecondsAfter ( lt_FirstAttempt, NOW ( ) ) >= 5 
		
	END IF

NEXT



IF ll_NewShipmentId > 0 THEN

	
	// set the shipment id on the record to be referenced later
	anv_204record.of_SetShipmentid ( ll_NewShipmentID )
	// retrieve the shipment
	lnv_Dispatch.of_RetrieveShipment ( ll_NewShipmentID )
	// get the shipment cache
	lds_Shipments = lnv_Dispatch.of_GetShipmentCache ( ) 
	// set the shipment source
	lnv_Shipment.of_Setsource ( lds_Shipments )
	lnv_Shipment.of_SetSourceId ( ll_NewShipmentID ) 
	lnv_Shipment.of_SetAllowFilterSet  ( TRUE )
	
	IF NOT lnv_Shipment.of_HasSource (  ) THEN
		li_Return = -1
		ls_ErrorText = "Could not aquire a handle to the new shipment."
	END IF
	
ELSE 
	ls_ErrorText = "Could not create a shipment."
	li_Return = -1
END IF
	
	
	
	
/*  Start setting data values*/
/*  First we are going to take care of the shipment level info */	
IF lb_HaveShipment THEN
	
	// set the event source on the shipment
	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )				
	IF THIS.of_SetShipmentData ( lnv_Shipment , anv_204Record ) <> 1 THEN
		li_Return = -1
	END IF

END IF


IF lb_HaveShipment THEN
		
	/* Now Make the Event entries */
	lnv_Shipment.of_GetEventIDs ( lla_EventIDs )
	
	// a new shipment has 2 default events assigned to it, we are going 
	// to get rid of them here
	lnv_Shipment.of_RemoveEvents ( lla_EventIDs , lnv_Dispatch )

	// add the stop list from the import file
	IF THIS.of_AddStopsFrom204 ( anv_204record , lnv_Shipment , lnv_Dispatch ) <> 1 THEN
		li_Return = -1
	END IF
	
	// record the number of stops added
	ll_EventCount = lnv_Shipment.of_GEtEventCount ( )
	
	lnv_Shipment.of_SetDefaultDestination ( )	
	lnv_Shipment.of_SetDefaultOrigin ( )
	
END IF


	
/* Now make the item entries  */
IF lb_HaveShipment THEN		
	// add this here so it doesn't ask to delete items when the events are removed
	lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Shipment.of_GetItemList ( lnva_Items )
	
	IF UpperBound ( lnva_Items ) = 1 THEN // should be by default
		
		
		
		lnv_Item = lnva_Items[1]
		
		//lnv_Item.of_SetShipment ( lnv_Shipment.of_GetID ( )  )
		lnv_Item.of_SetShipment ( lnv_Shipment )
		IF THIS.of_SetItemData ( lnv_Item  , anv_204record ) <> 1 THEN
			li_Return = -1
		END IF
		
	END IF
END IF


// even if li_Return = -1 we are still going to try and save if we have a shipment
// id to try and save any info we might have
IF lb_HaveShipment THEN
	IF lnv_Dispatch.Event pt_Save ( ) <> 1 THEN
		ls_ErrorText = "Could not save the new shipment."
		li_Return = -1
	END IF
END IF

anv_204record.of_SetSuccessfulImportFlag ( li_Return = 1 )
anv_204record.of_SetErrortext ( ls_ErrorText )

Int li_count 
li_count = UpperBound ( lnva_Items )
FOR i = 1 TO li_Count
	Destroy (lnva_Items [i] )
NEXT

DESTROY ( lnv_Dispatch )
DESTROY ( lnv_Shipment )

Return li_return
end function

private function integer of_addstopsfrom204 (ref n_cst_edi_204_record anv_204, ref n_cst_beo_shipment anv_shipment, ref n_cst_bso_dispatch anv_dispatch);Long		ll_Site
Long		ll_StopOffCount
Long		ll_NewEventID
Long  	i
Long		ll_ShipmentID
String	ls_EventType
String	ls_ErrorMessage
Int		li_SetRtn
Int		li_Return = 1
Boolean	lb_DateSet
Date		ld_StopDate
Time		lt_stopTime


n_cst_beo_Event	lnv_Event
datastore	lds_Events


lnv_Event = CREATE n_cst_beo_Event

IF Not isValid ( anv_Shipment ) THEN
	li_Return = -1
	ls_ErrorMessage = "Shipment not valid in add stops."
END IF

IF li_Return = 1 THEN
	ll_ShipmentID = anv_Shipment.of_GetID ( )
		
	lds_Events = anv_Dispatch.of_GetEventCache ( )
	
	lnv_Event.of_SetSource ( lds_Events )
	
	ll_StopOffCount = anv_204.of_GetStopCount ( ) 
	FOR i = 1 TO ll_StopOffCount
		
		ls_EventType = anv_204.of_GetEventType ( i )
		ll_Site = anv_204.of_GetSite ( i )
		
		li_SetRtn = anv_Shipment.of_addevent ( ls_EventType, i/* Insertion point */, anv_Dispatch, ll_NewEventID )
		
		li_SetRtn = lnv_Event.of_SetSourceID ( ll_NewEventID )
		li_SetRtn = lnv_Event.of_SetAllowFilterSet ( TRUE )
		
		ld_StopDate = anv_204.of_GetStopDate ( i )
		IF NOT isNull ( ld_StopDate ) THEN
			lnv_Event.of_setScheduledDate ( ld_StopDate )
		END IF

		lt_StopTime = anv_204.of_GetStopTime ( i )
		IF NOT isNull ( lt_StopTime ) THEN
			lnv_Event.of_setScheduledTime ( lt_StopTime )
		END IF
		
			
		IF ll_Site > 0 THEN	
			li_SetRtn = lnv_Event.of_SetSite ( ll_Site )
		ELSE
			li_Return = -1
			ls_ErrorMessage += "Could not set a site for the event [" + anv_204.of_getStringSite ( i ) + "]."
		END IF
		
		li_SetRtn = lnv_Event.of_SetShipment ( ll_ShipmentID )
	 	lnv_Event.of_SetReference ( anv_204.of_GetStopReference ( i ) )
	
		lnv_Event.of_SetNote ( anv_204.of_GetEventNote ( i ) ) 
		
		// Set The original site in the event note so it can be compared later
		li_SetRtn = lnv_Event.of_setSiteInEventNote ( ll_Site )
	
	NEXT
END IF

anv_204.of_SetSuccessfulImportFlag ( li_Return = 1 )
anv_204.of_SetErrorText ( ls_ErrorMessage )

DESTROY lnv_Event

RETURN li_Return
	
	
end function

public function integer of_import204shipmentfile (string as_filepath);//Not called anymore

//Long		i
//Long		ll_Count
//Int		li_Success
//Int		li_Fail
//String	ls_Target
//String	ls_Source
//String	lsa_Files[]
//Int		li_FileCount
//Int		j
//String	ls_Drive
//String	ls_Path
//String	ls_FileName
//String	ls_ErrorMsg
//String	ls_ImportDirectory
//Boolean	lb_NeedToImport = FALSE
//String	ls_Type
//String	ls_TargetFileName
//
//SetNull ( ls_Source )
//
//n_cst_filesrvwin32	lnv_FileSrv
//n_cst_edi_204_Record	lnva_Records[]
//n_cst_edi_Transaction_204	lnv_Edi_204
//n_cst_dirattrib	lnva_DirAttribs[]
//n_cst_edishipment_manager	lnv_EdiManager
//n_cst_setting_edi204version	lnv_EdiVersion
//n_cst_licensemanager	lnv_LicenseManager
//
//
//IF NOT lnv_LicenseManager.of_HasEDI204License ( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
//	RETURN 0
//END IF
//
//STRING	ls_EDIVersion
//
//
//lnv_EdiManager = CREATE n_cst_edishipment_manager
//lnv_Edi_204 = CREATE n_cst_edi_Transaction_204
//lnv_FileSrv = CREATE n_cst_filesrvwin32
//
//// get the location to move the spent import files to
//ls_Target = Trim ( lnv_Edi_204.of_GetSpentFileLocation ( ) )
//
//IF Right ( ls_Target , 1 ) <> "\" THEN
//	ls_Target += "\"
//END IF
//
//ls_ImportDirectory =Trim ( lnv_Edi_204.of_GetImportFilePath ( ) )
//	
//IF Right ( ls_ImportDirectory , 1 ) <> "\" THEN 	
//	ls_ImportDirectory += "\" 
//END IF
//		
//// get a list of all the files in the specified directory		
//li_FileCount = lnv_FileSrv.of_dirlist ( ls_ImportDirectory+"*.*", 0, lnva_DirAttribs )		
//
//FOR j = 1 TO li_FileCount
//	ls_ErrorMsg = ""
//	ls_FileName = lnva_DirAttribs[j].is_FileName
//	
//	IF lnv_EdiManager.of_Getfileformat( ls_ImportDirectory + ls_FileName , ls_Type , ls_EDIVersion ) = 1 THEN
//	
//		// we are going to do a major processing split here because the functionality
//		//	of the multiple versions was getting dangerously tangled up.
//	
//		IF ls_EdiVersion = lnv_EdiVersion.cs_ediversion_direct OR ls_EdiVersion = lnv_EdiVersion.cs_ediversion_directwithautoreply THEN
//		
//			lnv_EDIManager.of_Import204filesintopending( ls_ImportDirectory + ls_FileName )
//			lb_NeedToImport = TRUE
//		ELSE
//		
//			// old stuff
//			lnv_Edi_204.of_ImportFile ( ls_ImportDirectory + ls_FileName )		
//			ll_Count = lnv_Edi_204.of_GetRecords ( lnva_Records )
//			FOR i = 1 TO ll_Count 
//				IF THIS.of_Process204 ( lnva_Records[i] ) = 1 THEN
//					li_Success ++
//				ELSE
//					li_Fail ++
//				END IF
//			NEXT
//			
//		END IF
//		
//		IF FileExists ( ls_Target + ls_FileName ) THEN
//			// we are going to add on the date and time to the file, otherwise we would not 
//			// be able to move it, and that would cause problems.
//			ls_TargetFileName = String ( Today () , "YYMMDD" ) + String (Now(),"HHMMSS" ) + "-" + ls_FileName
//			//229	is the lengh limit on file names. so...
//			IF Len ( ls_TargetFileName ) >= 229 THEN 
//					ls_TargetFileName = Left ( ls_TargetFileName , 229 )
//			END IF
//			
//			
//		ELSE
//			ls_TargetFileName = ls_FileName
//		END IF
//		
//		IF lnv_FileSrv.of_FileRename ( ls_ImportDirectory + ls_FileName , ls_Target + ls_TargetFileName  ) <> 1 THEN
//			ls_ErrorMsg = "COULD NOT MOVE IMPORT FILE. "
//		END IF
//		
//	ELSE
//		ls_ErrorMsg = "COULD NOT RESOLVE FILE TYPE. "
//	END IF
//	lnv_Edi_204.of_WriteErrorLog ( ls_ErrorMsg )
//			
//	
//NEXT
//
//IF lb_NeedToImport THEN
//	lnv_EdiManager.of_Processpendingshipments( )
//END IF
//
//
//IF ls_EdiVersion = lnv_EdiVersion.cs_ediversion_directwithautoreply THEN
//	n_cst_edishipmentreview lnv_EDIReview
//	lnv_EDIReview = CREATE n_Cst_EDIShipmentReview
//	
//	lnv_EDIReview.of_Retrieveandacceptall( )
//	
//	DESTROY ( lnv_EDIReview )
//	
//	
//END IF
//
//DESTROY ( lnv_EdiManager )
//DESTROY ( lnv_Edi_204 )
//DESTROY ( lnv_FileSrv )
RETURN -1  
end function

public function long of_newnonroutedbrokerage ();Long	ll_ShipmentId
n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm

lstr_Parm.is_Label = "Style"
lstr_Parm.ia_Value = "NONROUTEDBROKERAGE!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_ShipmentId = This.of_NewShipment ( lnv_Msg )

RETURN ll_ShipmentId
end function

public function integer of_populateextendedshipmentdata (datastore ads_target);// BKW 02-09-04 3.8.02 Change logic for handling NextEvent_Equipment_... fields
// BKW 03-16-04 3.8.07 Force Shipment_PickedUp and Shipment_Delivered to be "T" or "F", not null.
//								Previous code was allowing null when the origin or dest could not be determined, 
//								which could then throw off filters based on these columns.
// BKW 05-27-04 3.9.00 Add GetShipmentFTE logic (it used to be in the dataobjects)
// BKW 05-27-04 3.9.00 Rename a few old-style variables to current naming conventions, and rearrange some variable 
// 							declarations for improved readability.  (No material, functional changes)


SetPointer ( HourGlass! )


DWObject ldwo_Billto_Id, ldwo_Billto_Name, ldwo_Billto_SalesRep, ldwo_OriginId, origin_name, origin_city, origin_state, &
	ldwo_FindestId, findest_name, findest_city, findest_state, ldwo_Carrier_Id, ldwo_Carrier_Name
DWObject cs_timestamp

DWObject	ldwo_NextEvent_Site, ldwo_NextEvent_Company, ldwo_NextEvent_City, ldwo_NextEvent_State, ldwo_NextEvent_Location
DWObject	ldwo_CurEvent_Site, ldwo_CurEvent_Company, ldwo_CurEvent_City, ldwo_CurEvent_State, ldwo_CurEvent_Location

DWObject	ldwo_NextEvent_Id, ldwo_NextEvent_Type, ldwo_NextEvent_Date, ldwo_NextEvent_Time, ldwo_NextEvent_Assigned, ldwo_NextEvent_Dispatched, ldwo_NextEvent_Arrived
DWObject	ldwo_CurEvent_Id, ldwo_CurEvent_Type, ldwo_CurEvent_Date, ldwo_CurEvent_Time

DWObject ldwo_NextEvent2_Type, ldwo_NextEvent2_SiteId, ldwo_NextEvent2_Site, ldwo_NextEvent2_City, &
	ldwo_NextEvent2_State, ldwo_NextEvent2_Date, ldwo_NextEvent2_Time, ldwo_NextEvent2_Assigned

DWObject ldwo_NextEvent3_Type, ldwo_NextEvent3_SiteId, ldwo_NextEvent3_Site, ldwo_NextEvent3_City, &
	ldwo_NextEvent3_State, ldwo_NextEvent3_Date, ldwo_NextEvent3_Time, ldwo_NextEvent3_Assigned

DWObject ldwo_NextEvent4_Type, ldwo_NextEvent4_SiteId, ldwo_NextEvent4_Site, ldwo_NextEvent4_City, &
	ldwo_NextEvent4_State, ldwo_NextEvent4_Date, ldwo_NextEvent4_Time, ldwo_NextEvent4_Assigned


DWObject ldwo_Equip_Description, ldwo_TotalPieces, ldwo_FTE, ldwo_SourceFTE

DWObject	ldwo_ScheduledPickupDate, ldwo_ScheduledPickupTime, ldwo_PickedUp, ldwo_DatePickedUp, ldwo_TimePickedUp, &
			ldwo_ScheduledDeliveryDate, ldwo_ScheduledDeliveryTime, ldwo_Delivered, ldwo_DateDelivered, ldwo_TimeDelivered

//This set of item dwo's is for the source datastore
DWObject	ldwo_RateType, ldwo_Rate, ldwo_Charges, ldwo_Miles
DWObject	ldwo_PayRateType, ldwo_PayRate, ldwo_Payables

//This set of item dwo's is for the target datastore
DWObject	ldwo_Item1_RateType, ldwo_Item1_Rate, ldwo_Item1_Charges, ldwo_Item1_Miles
DWObject	ldwo_Item1_PayRateType, ldwo_Item1_PayRate, ldwo_Item1_Payables

DWObject	ldwo_NextEvent_PowerUnit_Type, ldwo_NextEvent_PowerUnit_Number, &
			ldwo_NextEvent_Trailer_Type, ldwo_NextEvent_Trailer_Number, &
			ldwo_NextEvent_Container_Type, ldwo_NextEvent_Container_Number, &
			ldwo_NextEvent_Driver_FirstName, ldwo_NextEvent_Driver_LastName, ldwo_NextEvent_Driver_CodeName

DWObject	ldwo_EventCache_PowerUnit_Type, ldwo_EventCache_PowerUnit_Number, ldwo_EventCache_PowerUnit_Id, &
			ldwo_EventCache_Trailer_Type, ldwo_EventCache_Trailer_Number, ldwo_EventCache_Trailer_id, &
			ldwo_EventCache_Container_Type, ldwo_EventCache_Container_Number, ldwo_EventCache_Container_Id, &
			ldwo_EventCache_Driver_FirstName, ldwo_EventCache_Driver_LastName, ldwo_EventCache_Driver_CodeName


DWObject ldwo_Shipment_Pickupby
DWObject ldwo_Shipment_delby
DWObject ldwo_Movecode
DWObject ldwo_CutoffDate
DWObject ldwo_CutoffTime
DWObject ldwo_Cutoff
DWObject	ldwo_lastFree
DWObject	ldwo_lastFreeDate
DWObject	ldwo_lastFreeTime
DWObject ldwo_ShipmentFTE
DWObject	ldwo_ShipmentEarliestFreightDeadline
DWObject	ldwo_shipmentearliestfreedeadline
DWObject	ldwo_FreightDeadLineType
DWObject	ldwo_FreeDeadLineType
Dwobject	ldwo_EarliestDeadline
Dwobject ldwo_LoadedEmpty
Dwobject	ldwo_LoadedAtCustomerDate
Dwobject ldwo_EmptyAtCustomerDate
Dwobject	ldwo_ShipEq1Type
Dwobject ldwo_ShipEq1Length
Dwobject ldwo_ShipEq1Ref
Dwobject ldwo_ShipEq1LeaseLine
Dwobject ldwo_ShipEq1LeaseType
Dwobject ldwo_ShipEq1Notes
Dwobject	ldwo_ShipEq2Type
Dwobject ldwo_ShipEq2Length
Dwobject ldwo_ShipEq2Ref
Dwobject ldwo_ShipEq2LeaseLine
Dwobject ldwo_ShipEq2LeaseType
Dwobject	ldwo_ShipEq2Notes



String	ls_Select, &
			ls_Scenario, &
			ls_Work, &
			ls_City, &
			ls_State, &
			ls_ShipmentCacheFile, &
			ls_ShipmentInClause, &
			ls_EquipType, &
			ls_EquipNumber, &
			lsa_EquipmentSourceAlias[], &
			lsa_EquipmentTargetAlias[]
Long		ll_ReadLoop, &
			ll_ChangedShipmentCount, &
			ll_ShipRow, &
			ll_LastConfRow, &
			ll_FirstUnconfRow, &
			ll_ShipmentId, &
			ll_EquipID, &
			ll_EquipCheck, &
			ll_CompanyId, &
			ll_EventCount, &
			ll_ItemCount, &
			ll_OriginSite, &
			ll_FindestSite, &
			ll_OriginRow, &
			ll_FindestRow, &
			ll_Row, &
			lla_ChangedShipments[], &
			lla_CacheCompanies[], &
			ll_Check, &
			ll_FTERow, &
			ll_FTERowCount
Integer	li_Index, &
			li_SqlCode
Boolean	lb_RefreshIndividualEquipment
Date		ld_FTE  //FreeTimeExpiration

String		ls_DeadlineType
String		ls_LoadedEmpty
DateTime 	ldtm_Delby
dateTime 	ldtm_Pickup
DateTime 	ldtm_Cutoff
DateTime		ldtm_LastFree
DateTime		ldtm_FTE
DateTime		ldtm_EarliestFreightDeadline
DateTime		ldtm_FreeDeadline
DateTime		ldtm_EarliestDeadLine

Long			ll_ShipEquipCount

Time			lt_Temp


Date	ld_temp
DateTime	ldtm_PickUpFromShip
DateTime ldtm_PickUpEvents
DateTime	ldtm_DeliverFromShipment
DateTime	ldtm_DeliverFromEvents
DateTime	ldtm_CutoffFromShipment
DateTime	ldtm_CutoffFromEvents					
DateTime	ldtma_Compare[]	
DateTime ldtma_Empty[]
Int	li_DateIndex


os_Event		lstr_CurrentEvent, &
				lstr_NextEvent, &
				lstr_OriginEvent, &
				lstr_FindestEvent

n_cst_Dws	lnv_Dws
n_cst_Sql	lnv_Sql
DataStore	lds_Event, &
				lds_Item, &
				lds_FTE, &
				lds_ShipEquip

n_cst_beo_Company		lnv_Company
n_cst_numerical		lnv_Numerical
n_cst_equipmentmanager	lnv_EquipmentMgr
n_cst_bso_Rating		lnv_Rating
n_cst_Events			lnv_Events





Boolean	lb_ProcessExtended = TRUE


Boolean	lb_Failed = FALSE

lnv_Company = CREATE n_cst_beo_Company

lb_ProcessExtended = profileString	 ( Gnv_app.of_Getappinifile( ) , "ExtendedShipmentData" , "Level1" , "YES" ) = "YES"


//lsa_CompanySourceAlias = {"co_name", "co_city", "co_state"}
//lsa_CompanyCurrentAlias = {"cc_CurEvent_Company", "cc_CurEvent_City", "cc_CurEvent_State"}
//lsa_CompanyNextAlias = {"cc_NextEvent_Company", "cc_NextEvent_City", "cc_NextEvent_State"}

//lsa_EquipmentSourceAlias = {"eq_id", "eq_type", "eq_ref"}
//lsa_EquipmentTargetAlias = {"cc_equip_id", "cc_equip_type", "cc_equip_ref"}


//**Changed in this version from retrieval in original.
IF IsValid ( ads_Target ) THEN
	ll_ChangedShipmentCount = ads_Target.RowCount ( )
ELSE
	lb_Failed = TRUE
	//GOTO Ship_Cleanup
	IF lb_Failed THEN
		RETURN -1
	ELSE
		RETURN 1
	END IF
END IF

//begin optimize performance , comment by appeon 20080801
//IF lnv_EquipmentMgr.of_Get_Retrieved_Equip( ) = FALSE OR &
//	sb_Ships_Retrieved = FALSE THEN  //Not sure why this second condition is necessary??
//	IF lnv_EquipmentMgr.of_RefreshActive ( ) = 1 THEN
//		lb_RefreshIndividualEquipment = FALSE
//	ELSE
//		lb_RefreshIndividualEquipment = TRUE
//	END IF
//ELSE
//	lb_RefreshIndividualEquipment = TRUE
//END IF
lb_RefreshIndividualEquipment = FALSE
//end optimize performance , comment by appeon 20080801

if ll_ChangedShipmentCount > 0 then

	lnv_Rating = CREATE n_cst_bso_Rating  //Will be used for getting rate type display values

	lla_ChangedShipments = ads_Target.Object.ds_id.Primary
	ls_ShipmentInClause = lnv_Sql.of_MakeInClause ( lla_ChangedShipments )

	//3.6.00 BKW

//	ls_Select = "SELECT de_id, de_event_type, de_site, de_apptdate, de_appttime, de_arrdate, de_arrtime, de_deptime, de_shipment_id, de_ship_seq, de_conf, de_driver, de_tractor, de_trailer1, de_container1, de_acteq, de_status FROM disp_events WHERE de_shipment_id "
//	ls_Select += ls_ShipmentInClause
//
//	lds_Event = lnv_Dws.of_CreateDataStore ( ls_Select )

	lds_Event = CREATE DataStore
	lds_Event.DataObject = "d_eventsforshipmentcache"
	lds_Event.SetTransObject ( SQLCA )

	// END CHANGE


	ls_Select = "SELECT di_item_id, di_shipment_id, di_item_type, di_qty, di_our_ratetype, di_our_rate, di_our_itemamt, di_pay_ratetype, di_pay_rate, di_pay_itemamt, di_miles FROM disp_items WHERE di_shipment_id "
	ls_Select += ls_ShipmentInClause

	lds_Item = lnv_Dws.of_CreateDataStore ( ls_Select )
	
	
	IF lds_Item.Retrieve ( ) = -1 THEN
		ROLLBACK ;
		lb_Failed = TRUE
		//GOTO ship_cleanup
		IF lb_Failed THEN
			RETURN -1
		ELSE
			RETURN 1
		END IF
	END IF


	IF lds_Event.Retrieve ( lla_ChangedShipments ) = -1 THEN   //3.6.00 BKW  Now using dataobject with retr. argument.
		ROLLBACK ;
		lb_Failed = TRUE
		//GOTO ship_cleanup
		IF lb_Failed THEN
			RETURN -1
		ELSE
			RETURN 1
		END IF
	ELSE
		COMMIT ;
	END IF
	
	/*     <<*>> Changed to new approach b.c. the stored procedure was taking too long 9/21/06
	//Added 3.9.00 5-27-04 BKW   Set up the FreeTimeExpiration datastore
	lds_FTE = CREATE DataStore
	lds_FTE.DataObject = "d_shipment_fte"
	lds_FTE.SetTransObject ( SQLCA )
	
	//Added 3.9.00 5-27-04 BKW   Retrieve the FreeTimeExpiration datastore for the changed shipments
	
	
	ll_FTERowCount = lds_FTE.Retrieve ( lla_ChangedShipments )
	COMMIT ;
	
	IF ll_FTERowCount = ll_ChangedShipmentCount THEN
		//OK
	ELSE
		lb_Failed = TRUE
		GOTO Ship_Cleanup
	END IF
	*/
	
	lds_FTE = THIS.of_GetFtesource( lla_ChangedShipments )
	IF isValid ( lds_FTE ) THEN
		ll_FTERowCount = lds_FTE.RowCount ( )
	ELSE
		//GOTO Ship_Cleanup
		IF lb_Failed THEN
			RETURN -1
		ELSE
			RETURN 1
		END IF
	END IF
	
	// Setup the equipment DO
	IF lb_ProcessExtended THEN
		lds_ShipEquip = CREATE DataStore
		lds_ShipEquip.DataObject = "d_shipmentequipment_forcache"
		lds_ShipEquip.SettransObject ( SQLCA )
		lds_ShipEquip.Retrieve ( lla_ChangedShipments )
		COMMIT ;
	END IF



	//Both lds_Item and lds_Event will be filtered by shipment, so the sort needed is only for rows within a shipment.

	lds_Item.SetSort ( "di_item_type D, di_item_id A" )

	lds_Event.SetSort ( "de_ship_seq A" )

	ldwo_NextEvent_Id = ads_Target.Object.cc_NextEvent_Id
	ldwo_NextEvent_Type = ads_Target.Object.cc_NextEvent_Type
	ldwo_NextEvent_Date = ads_Target.Object.cc_NextEvent_Date
	ldwo_NextEvent_Time = ads_Target.Object.cc_NextEvent_Time
	ldwo_NextEvent_Site = ads_Target.Object.cc_NextEvent_Site
	ldwo_NextEvent_Assigned = ads_Target.Object.NextEvent_Assigned
	ldwo_NextEvent_Dispatched = ads_Target.Object.NextEvent_Dispatched
	ldwo_NextEvent_Arrived = ads_Target.Object.NextEvent_Arrived

	ldwo_NextEvent_PowerUnit_Type = ads_Target.Object.NextEvent_PowerUnit_Type
	ldwo_NextEvent_PowerUnit_Number = ads_Target.Object.NextEvent_PowerUnit_Number
	ldwo_NextEvent_Trailer_Type = ads_Target.Object.NextEvent_Trailer_Type
	ldwo_NextEvent_Trailer_Number = ads_Target.Object.NextEvent_Trailer_Number
	ldwo_NextEvent_Container_Type = ads_Target.Object.NextEvent_Container_Type
	ldwo_NextEvent_Container_Number = ads_Target.Object.NextEvent_Container_Number
	ldwo_NextEvent_Driver_FirstName = ads_Target.Object.NextEvent_Driver_FirstName
	ldwo_NextEvent_Driver_LastName = ads_Target.Object.NextEvent_Driver_LastName
	ldwo_NextEvent_Driver_CodeName = ads_Target.Object.NextEvent_Driver_CodeName
	
	ldwo_CurEvent_Id = ads_Target.Object.cc_CurEvent_Id
	ldwo_CurEvent_Type = ads_Target.Object.cc_CurEvent_Type
	ldwo_CurEvent_Date = ads_Target.Object.cc_CurEvent_Date
	ldwo_CurEvent_Time = ads_Target.Object.cc_CurEvent_Time
	ldwo_CurEvent_Site = ads_Target.Object.cc_CurEvent_Site

	ldwo_Equip_Description = ads_Target.Object.cc_Equip_Description
	ldwo_TotalPieces = ads_Target.Object.Shipment_TotalPieces
	ldwo_FTE = ads_Target.Object.FreeTimeExpiration

	ldwo_Billto_Id = ads_Target.object.ds_billto_id
	ldwo_Billto_Name = ads_Target.object.billto_name
	ldwo_Billto_SalesRep = ads_Target.object.billto_salesrep
	ldwo_OriginId = ads_Target.object.ds_origin_id
	origin_name = ads_Target.object.origin_name
	origin_city = ads_Target.object.origin_city
	origin_state = ads_Target.object.origin_state
	ldwo_FindestId = ads_Target.object.ds_findest_id
	findest_name = ads_Target.object.findest_name
	findest_city = ads_Target.object.findest_city
	findest_state = ads_Target.object.findest_state
	ldwo_Carrier_Id = ads_Target.Object.ds_pay1_id
	ldwo_Carrier_Name = ads_Target.Object.Carrier_Name
	cs_timestamp = ads_Target.object.cs_timestamp

	ldwo_NextEvent_Company = ads_Target.Object.cc_NextEvent_Company
	ldwo_NextEvent_City = ads_Target.Object.cc_NextEvent_City
	ldwo_NextEvent_State = ads_Target.Object.cc_NextEvent_State
	ldwo_NextEvent_Location = ads_Target.Object.cc_NextEvent_Location

	ldwo_NextEvent2_Type = ads_Target.Object.NextEvent2_Type
	ldwo_NextEvent2_SiteId = ads_Target.Object.NextEvent2_SiteId
	ldwo_NextEvent2_Site = ads_Target.Object.NextEvent2_Site
	ldwo_NextEvent2_City = ads_Target.Object.NextEvent2_City
	ldwo_NextEvent2_State = ads_Target.Object.NextEvent2_State
	ldwo_NextEvent2_Date = ads_Target.Object.NextEvent2_Date
	ldwo_NextEvent2_Time = ads_Target.Object.NextEvent2_Time
	ldwo_NextEvent2_Assigned = ads_Target.Object.NextEvent2_Assigned

	ldwo_NextEvent3_Type = ads_Target.Object.NextEvent3_Type
	ldwo_NextEvent3_SiteId = ads_Target.Object.NextEvent3_SiteId
	ldwo_NextEvent3_Site = ads_Target.Object.NextEvent3_Site
	ldwo_NextEvent3_City = ads_Target.Object.NextEvent3_City
	ldwo_NextEvent3_State = ads_Target.Object.NextEvent3_State
	ldwo_NextEvent3_Date = ads_Target.Object.NextEvent3_Date
	ldwo_NextEvent3_Time = ads_Target.Object.NextEvent3_Time
	ldwo_NextEvent3_Assigned = ads_Target.Object.NextEvent3_Assigned

	ldwo_NextEvent4_Type = ads_Target.Object.NextEvent4_Type
	ldwo_NextEvent4_SiteId = ads_Target.Object.NextEvent4_SiteId
	ldwo_NextEvent4_Site = ads_Target.Object.NextEvent4_Site
	ldwo_NextEvent4_City = ads_Target.Object.NextEvent4_City
	ldwo_NextEvent4_State = ads_Target.Object.NextEvent4_State
	ldwo_NextEvent4_Date = ads_Target.Object.NextEvent4_Date
	ldwo_NextEvent4_Time = ads_Target.Object.NextEvent4_Time
	ldwo_NextEvent4_Assigned = ads_Target.Object.NextEvent4_Assigned

	ldwo_CurEvent_Company = ads_Target.Object.cc_CurEvent_Company
	ldwo_CurEvent_City = ads_Target.Object.cc_CurEvent_City
	ldwo_CurEvent_State = ads_Target.Object.cc_CurEvent_State
	ldwo_CurEvent_Location = ads_Target.Object.cc_CurEvent_Location

	ldwo_ScheduledPickupDate = ads_Target.Object.cc_Origin_Date
	ldwo_ScheduledPickupTime = ads_Target.Object.cc_Origin_Time
	ldwo_PickedUp = ads_Target.Object.cc_Origin_Conf
	ldwo_DatePickedUp = ads_Target.Object.Shipment_DatePickedUp
	ldwo_TimePickedUp = ads_Target.Object.Shipment_TimePickedUp

	ldwo_ScheduledDeliveryDate = ads_Target.Object.cc_Findest_Date
	ldwo_ScheduledDeliveryTime = ads_Target.Object.cc_Findest_Time
	ldwo_Delivered = ads_Target.Object.cc_Findest_Conf
	ldwo_DateDelivered = ads_Target.Object.Shipment_DateDelivered
	ldwo_TimeDelivered = ads_Target.Object.Shipment_TimeDelivered

	//Set up the item dwo's for the source datastore

	ldwo_RateType = lds_Item.Object.di_our_ratetype
	ldwo_Rate = lds_Item.Object.di_our_rate
	ldwo_Charges = lds_Item.Object.di_our_itemamt
	ldwo_Miles = lds_Item.Object.di_miles

	ldwo_PayRateType = lds_Item.Object.di_pay_ratetype
	ldwo_PayRate = lds_Item.Object.di_pay_rate
	ldwo_Payables = lds_Item.Object.di_pay_itemamt

	//Set up the item dwo's for the target datastore

	ldwo_Item1_RateType = ads_Target.Object.Item1_RateType
	ldwo_Item1_Rate = ads_Target.Object.Item1_Rate
	ldwo_Item1_Charges = ads_Target.Object.Item1_Charges
	ldwo_Item1_Miles = ads_Target.Object.Item1_Miles

	ldwo_Item1_PayRateType = ads_Target.Object.Item1_PayRateType
	ldwo_Item1_PayRate = ads_Target.Object.Item1_PayRate
	ldwo_Item1_Payables = ads_Target.Object.Item1_Payables

	//Set up the equipment and driver dwo's for the event datastore
	//Note : For trailer and container, we are hitting de_Trailer1 and de_Container1
	//If doubles are involved on a hook / drop / mount / dismount, it is possible that the equipment
	//listed may not be the "active" equipment.

	ldwo_EventCache_PowerUnit_Type = lds_Event.Object.Tractor_Type
	ldwo_EventCache_PowerUnit_Number = lds_Event.Object.Tractor_Ref
	ldwo_EventCache_PowerUnit_Id = lds_Event.Object.de_Tractor
	ldwo_EventCache_Trailer_Type = lds_Event.Object.Trailer_Type
	ldwo_EventCache_Trailer_Number = lds_Event.Object.Trailer_Ref
	ldwo_EventCache_Trailer_id = lds_Event.Object.de_Trailer1
	ldwo_EventCache_Container_Type = lds_Event.Object.Container_Type
	ldwo_EventCache_Container_Number = lds_Event.Object.Container_Ref
	ldwo_EventCache_Container_Id = lds_Event.Object.de_Container1
	ldwo_EventCache_Driver_FirstName = lds_Event.Object.driver_fn
	ldwo_EventCache_Driver_LastName = lds_Event.Object.driver_ln
	ldwo_EventCache_Driver_CodeName = lds_Event.Object.driver_ref
	
	//Set up the FTESource dwo's   Added 3.9.00 5-27-04 BKW
	ldwo_SourceFTE = lds_FTE.Object.FreeTimeExpiration



	// New for DYNAMIC VIEWS <<*>>
	IF lb_ProcessExtended THEN
		ldwo_Shipment_Pickupby = ads_Target.Object.Shipment_PickupBy
		ldwo_shipment_delby = ads_Target.Object.Shipment_Delby
		ldwo_Movecode = ads_Target.Object.movecode
		ldwo_Cutoff = ads_Target.Object.shipment_cutoff
		ldwo_cutoffdate = ads_Target.Object.cutoffdate
		ldwo_cutoffTime = ads_Target.Object.cutoffTime
		ldwo_lastFreeDate = ads_Target.Object.LastFreeDate
		ldwo_LastFreeTime = ads_target.object.lastfreetime
		ldwo_LastFree = ads_target.object.Shipment_LastFree
		ldwo_ShipmentFTE	= ads_Target.object.Shipment_FTE
		ldwo_ShipmentEarliestFreightDeadline = ads_Target.object.shipment_earliestfreightdeadline
		ldwo_shipmentearliestfreedeadline = ads_Target.object.shipment_earliestfreedeadline
		ldwo_FreightDeadLineType = ads_Target.object.shipment_earliestfreightdeadlineType
		ldwo_FreeDeadLineType = ads_Target.object.shipment_earliestfreedeadlineType
		ldwo_EarliestDeadline = ads_Target.object.shipment_earliestdeadline
		ldwo_LoadedEmpty = ads_Target.object.shipment_needsloadedempty  
		ldwo_EmptyAtCustomerDate = ads_Target.object.EmptyAtCustomerDate 
		ldwo_LoadedAtCustomerDate = ads_Target.object.LoadedAtCustomerDate 
		//
		ldwo_ShipEq1Type = ads_target.object.LinkedEq1Type
		ldwo_ShipEq1Length = ads_target.object.LinkedEq1Length
		ldwo_ShipEq1Ref = ads_target.object.LinkedEq1Ref
		ldwo_ShipEq1LeaseLine  = ads_target.object.LinkedEq1LeaseLine
		ldwo_ShipEq1LeaseType = ads_target.object.LinkedEq1LeaseType
		ldwo_ShipEq1Notes = ads_target.object.LinkedEq1Notes
		
		ldwo_ShipEq2Type = ads_target.object.LinkedEq2Type
		ldwo_ShipEq2Length = ads_target.object.LinkedEq2Length
		ldwo_ShipEq2Ref = ads_target.object.LinkedEq2Ref
		ldwo_ShipEq2LeaseLine = ads_target.object.LinkedEq2LeaseLine
		ldwo_ShipEq2LeaseType = ads_target.object.LinkedEq2LeaseType
		ldwo_ShipEq2Notes = ads_target.object.LinkedEq2notes
	END IF
/*	begin optimize performance , comment by appeon 20080801
	FOR ll_ShipRow = 1 TO ll_ChangedShipmentCount

		ll_ShipmentId = ads_Target.GetItemNumber ( ll_ShipRow, "ds_id" )
		
		//First, try filtering to just freight items.  We need just the freight items for 
		//total pieces, if there are any.  Then, if we have freight items we'll use the 
		//first one for item1.  If we don't have any, we'll refilter to include accessorials,
		//which can be used as item1 if there aren't any freight items.

		//di_item_type = 'L' is the filter for "Freight"

		lds_Item.SetFilter ( "di_item_type = 'L' AND di_shipment_id = " + String ( ll_ShipmentId ) )
		lds_Item.Filter ( )
		lds_Item.Sort ( )

		ll_ItemCount = lds_Item.RowCount ( )

		IF ll_ItemCount > 0 THEN

			ldwo_TotalPieces.Primary [ ll_ShipRow ] = Dec ( lds_Item.Describe ( "Evaluate ( 'SUM (di_qty FOR ALL)', 1 )" ) )

		ELSE

			//There weren't any freight items.  Refilter to see if there's any accessorials.

			lds_Item.SetFilter ( "di_shipment_id = " + String ( ll_ShipmentId ) )
			lds_Item.Filter ( )
			lds_Item.Sort ( )
	
			ll_ItemCount = lds_Item.RowCount ( )

		END IF

		//Now, if we have any items (with freight taking priority), pull item1 information
		//from the first item row.

		IF ll_ItemCount > 0 THEN

			ldwo_Item1_RateType.Primary [ ll_ShipRow ] = lnv_Rating.of_GetUnitLabel ( ldwo_RateType.Primary [ 1 ] )
			ldwo_Item1_Rate.Primary [ ll_ShipRow ] = ldwo_Rate.Primary [ 1 ]
			ldwo_Item1_Charges.Primary [ ll_ShipRow ] = ldwo_Charges.Primary [ 1 ]
			ldwo_Item1_Miles.Primary [ ll_ShipRow ] = ldwo_Miles.Primary [ 1 ]
		
			ldwo_Item1_PayRateType.Primary [ ll_ShipRow ] = lnv_Rating.of_GetUnitLabel ( ldwo_PayRateType.Primary [ 1 ] )
			ldwo_Item1_PayRate.Primary [ ll_ShipRow ] = ldwo_PayRate.Primary [ 1 ]
			ldwo_Item1_Payables.Primary [ ll_ShipRow ] = ldwo_Payables.Primary [1 ]

		END IF


		lds_Event.SetFilter ( "de_shipment_id = " + String ( ll_ShipmentId ) )
		lds_Event.Filter ( )
		lds_Event.Sort ( )

		ll_EventCount = lds_Event.RowCount ( )
		IF lnv_numerical.of_IsNullOrNotPos ( ll_EventCount ) THEN
			CONTINUE
		END IF
		
		
		IF lb_ProcessExtended THEN
			// Filter the equipment
			
			IF ll_ShipmentID = 110 THEN
				ll_ShipmentID = 110
			END IF
				
			lds_ShipEquip.SetFilter ( "shipment = " + String ( ll_ShipmentId ) + " OR reloadshipment = " + String ( ll_ShipmentId ) )
			lds_ShipEquip.Filter ( )	
			lds_ShipEquip.Sort ( )
			ll_ShipEquipCount = lds_ShipEquip.RowCount ( )
			
			IF ll_ShipEquipCount > 0 THEN
				ldwo_ShipEq1Type.Primary [ ll_ShipRow ] = lds_ShipEquip.GetItemString ( 1 , "type" )
				ldwo_ShipEq1Length.Primary [ ll_ShipRow ] = lds_ShipEquip.GetItemNumber ( 1 , "Length" )
				ldwo_ShipEq1Ref.Primary [ ll_ShipRow ] =  lds_ShipEquip.GetItemString ( 1 , "ref" )
				ldwo_ShipEq1LeaseLine.Primary [ll_ShipRow ] = lds_ShipEquip.GetItemString ( 1 , "equipmentleasetype_line" )
				ldwo_ShipEq1LeaseType.Primary [ll_ShipRow ] = lds_ShipEquip.GetItemString ( 1 , "equipmentleasetype_Type" )
				ldwo_ShipEq1Notes.Primary [ ll_shipRow ] = Left ( lds_ShipEquip.GetItemString ( 1 , "notes" ), 30 )
				IF ll_ShipEquipCount > 1 THEN
					ldwo_ShipEq2Type.Primary [ ll_ShipRow ] = lds_ShipEquip.GetItemString ( 2 , "type" )
					ldwo_ShipEq2Length.Primary [ ll_ShipRow ] = lds_ShipEquip.GetItemNumber ( 2 , "Length" )
					ldwo_ShipEq2Ref.Primary [ ll_ShipRow ] =  lds_ShipEquip.GetItemString ( 2 , "ref" )
					ldwo_ShipEq2LeaseLine.Primary [ll_ShipRow ] = lds_ShipEquip.GetItemString ( 2 , "equipmentleasetype_line" )
					ldwo_ShipEq2LeaseType.Primary [ll_ShipRow ] = lds_ShipEquip.GetItemString ( 2 , "equipmentleasetype_Type" )
					ldwo_ShipEq2Notes.Primary [ ll_shipRow ] = Left ( lds_ShipEquip.GetItemString ( 2 , "notes" ) , 30 )
				END IF
				
				
			END IF
			
		END IF
		
		
		
		
		

//////////////////////   This was moved from the end of the loop to the beginning 3.6.00 BKW, so that the origin
//									and destination rows would be available to the equipment loop.

		//Determine origin and destination events

		ll_OriginSite = ldwo_OriginId.Primary [ ll_ShipRow ]
		ll_FindestSite = ldwo_FindestId.Primary [ ll_ShipRow ]

		ll_OriginRow = lds_Event.Find ( "de_Site = " + String ( ll_OriginSite ) +&
			" AND Pos ( 'PHM', de_Event_Type ) > 0", 1, ll_EventCount )  //Replaced RowCount() with ll_EventCount 3.6.00 BKW

		ll_FindestRow = lds_Event.Find ( "de_Site = " + String ( ll_FindestSite ) +&
			"AND Pos ( 'DRN', de_Event_Type ) > 0", 1, ll_EventCount )  //Replaced RowCount() with ll_EventCount 3.6.00 BKW
		//Note: If it's ambiguous, we want the first delivery that meets the criteria here


		//Populate lstr_OriginEvent
		This.of_PopulateEventStructure ( lds_Event, ll_OriginRow, lstr_OriginEvent )

		// BKW 03-16-04 3.8.07 Force Shipment_PickedUp and Shipment_Delivered to be "T" or "F", not null.
		IF IsNull ( lstr_OriginEvent.is_Confirmed ) THEN
			lstr_OriginEvent.is_Confirmed = "F"
		END IF

		//Populate lstr_FindestEvent
		This.of_PopulateEventStructure ( lds_Event, ll_FindestRow, lstr_FindestEvent )

		// BKW 03-16-04 3.8.07 Force Shipment_PickedUp and Shipment_Delivered to be "T" or "F", not null.

		IF IsNull ( lstr_FindestEvent.is_Confirmed ) THEN
			lstr_FindestEvent.is_Confirmed = "F"
		END IF
		

		//Copy origin information to datastore
		ldwo_ScheduledPickupDate.Primary [ ll_ShipRow ] = lstr_OriginEvent.id_Appointment
		ldwo_ScheduledPickupTime.Primary [ ll_ShipRow ] = lstr_OriginEvent.it_Appointment
		ldwo_PickedUp.Primary [ ll_ShipRow ] = lstr_OriginEvent.is_Confirmed
		ldwo_DatePickedUp.Primary [ ll_ShipRow ] = lstr_OriginEvent.id_Arrive
		ldwo_TimePickedUp.Primary [ ll_ShipRow ] = lstr_OriginEvent.it_Arrive

		//Copy findest information to datastore
		ldwo_ScheduledDeliveryDate.Primary [ ll_ShipRow ] = lstr_FindestEvent.id_Appointment
		ldwo_ScheduledDeliveryTime.Primary [ ll_ShipRow ] = lstr_FindestEvent.it_Appointment
		ldwo_Delivered.Primary [ ll_ShipRow ] = lstr_FindestEvent.is_Confirmed
		ldwo_DateDelivered.Primary [ ll_ShipRow ] = lstr_FindestEvent.id_Arrive
		ldwo_TimeDelivered.Primary [ ll_ShipRow ] = lstr_FindestEvent.it_Arrive


//////////////////


		//Determine which scenario we're dealing with

		//Find the last confirmed ROUTABLE row  :  'T' or Null means routable = TRUE

		ll_LastConfRow = lds_Event.Find ( "de_conf = 'T' AND ( routable = 'T' OR IsNull ( routable ) )", ll_EventCount, 1 )

		IF ll_LastConfRow > 0 THEN
			IF ll_LastConfRow < ll_EventCount THEN
				ll_FirstUnconfRow = ll_LastConfRow + 1
			ELSE
				SetNull ( ll_FirstUnconfRow )
				ls_Scenario = "ALL_CONFIRMED!"
			END IF
		ELSE
			ll_FirstUnconfRow = 1
		END IF

		//If we have a candidate row, take it or the first row after it that is not confirmed but IS routable
		//If there are no such rows, then everything forward from the lastconfirmed row is not routable, and the 
		//shipment should be listed as having no next stop.

		IF ll_FirstUnconfRow > 0 THEN

			ll_FirstUnconfRow = lds_Event.Find ( "de_conf = 'F' AND ( routable = 'T' OR IsNull ( routable ) )", &
				ll_FirstUnconfRow, ll_EventCount )

			IF ll_FirstUnconfRow > 0 THEN
				IF IsNull ( lds_Event.GetItemTime ( ll_FirstUnconfRow , "de_arrtime" ) ) THEN
					ls_Scenario = "BETWEEN_STOPS!"
				ELSE
					ls_Scenario = "AT_STOP!"
				END IF
			ELSE
				SetNull ( ll_FirstUnconfRow )
				ls_Scenario = "ALL_CONFIRMED!"
			END IF

		END IF

		//Gather appropriate info based on the scenario determination

		CHOOSE CASE ls_Scenario

		CASE "ALL_CONFIRMED!"
//			//Determine Equipment		3.6.00  Now done separately, below.
//			This.of_DetermineEquipment ( lds_Event, ll_EventCount, ll_EquipId )

			//Populate lstr_NextEvent
			//There is no next event
			This.of_PopulateEventStructure (lds_Event, 0, lstr_NextEvent )

			//Populate lstr_CurrentEvent
			This.of_PopulateEventStructure ( lds_Event, ll_EventCount, lstr_CurrentEvent )

		CASE "BETWEEN_STOPS!", "AT_STOP!"
//			//Determine Equipment
//			This.of_DetermineEquipment ( lds_Event, ll_FirstUnconfRow, ll_EquipId )

			//Populate lstr_NextEvent
			This.of_PopulateEventStructure ( lds_Event, ll_FirstUnconfRow, lstr_NextEvent )

			//Populate lstr_CurrentEvent
			This.of_PopulateEventStructure ( lds_Event, ll_LastConfRow, lstr_CurrentEvent )

		END CHOOSE


		//Clear these variables so that the logic below can populate them cleanly.

		SetNull ( ll_EquipId )
		SetNull ( ls_EquipType )
		SetNull ( ls_EquipNumber )


		//Write information into ads_Target  (company details will be written later, 
		//after all necessary companies are cached.)

		IF lstr_NextEvent.il_Id > 0 THEN

			ldwo_NextEvent_Id.Primary [ ll_ShipRow ] = lstr_NextEvent.il_Id
			ldwo_NextEvent_Type.Primary [ ll_ShipRow ] = lnv_Events.of_GetTypeDisplayValueShort ( lstr_NextEvent.is_Type )
			ldwo_NextEvent_Site.Primary [ ll_ShipRow ] = lstr_NextEvent.il_Site
			ldwo_NextEvent_Assigned.Primary [ ll_ShipRow ] = lstr_NextEvent.is_Assigned
			ldwo_NextEvent_Dispatched.Primary [ ll_ShipRow ] = lstr_NextEvent.is_Dispatched
			ldwo_NextEvent_Arrived.Primary [ ll_ShipRow ] = lstr_NextEvent.is_Arrived

			IF IsNull ( lstr_NextEvent.id_Arrive ) THEN
				ldwo_NextEvent_Date.Primary [ ll_ShipRow ] = lstr_NextEvent.id_Appointment
				ldwo_NextEvent_Time.Primary [ ll_ShipRow ] = lstr_NextEvent.it_Appointment
			ELSE
				ldwo_NextEvent_Date.Primary [ ll_ShipRow ] = lstr_NextEvent.id_Arrive
				IF IsNull ( lstr_NextEvent.it_Arrive ) AND &
					lstr_NextEvent.id_Arrive = lstr_NextEvent.id_Appointment THEN
						ldwo_NextEvent_Time.Primary [ ll_ShipRow ] = lstr_NextEvent.it_Appointment
				ELSE
						ldwo_NextEvent_Time.Primary [ ll_ShipRow ] = lstr_NextEvent.it_Arrive
				END IF
			END IF


			IF ll_FirstUnconfRow > 0 THEN  //Should be -- that's the source of lstr_NextEvent

				//Copy all the info for PowerUnit, Trailer, and Container into the shipment datastore.  

				ll_EquipCheck = ldwo_EventCache_PowerUnit_Id.Primary [ ll_FirstUnconfRow ]

				IF ll_EquipCheck > 0 THEN

					ll_EquipId = ll_EquipCheck
					ls_EquipType = ldwo_EventCache_PowerUnit_Type.Primary [ ll_FirstUnconfRow ]
					ls_EquipNumber = ldwo_EventCache_PowerUnit_Number.Primary [ ll_FirstUnconfRow ]

					ldwo_NextEvent_PowerUnit_Type.Primary [ ll_ShipRow ] = ls_EquipType
					ldwo_NextEvent_PowerUnit_Number.Primary [ ll_ShipRow ] = ls_EquipNumber

				END IF


				ll_EquipCheck = ldwo_EventCache_Trailer_Id.Primary [ ll_FirstUnconfRow ]

				IF ll_EquipCheck > 0 THEN

					ll_EquipId = ll_EquipCheck
					ls_EquipType = ldwo_EventCache_Trailer_Type.Primary [ ll_FirstUnconfRow ]
					ls_EquipNumber = ldwo_EventCache_Trailer_Number.Primary [ ll_FirstUnconfRow ]

					ldwo_NextEvent_Trailer_Type.Primary [ ll_ShipRow ] = ls_EquipType
					ldwo_NextEvent_Trailer_Number.Primary [ ll_ShipRow ] = ls_EquipNumber

				END IF


				ll_EquipCheck = ldwo_EventCache_Container_Id.Primary [ ll_FirstUnconfRow ]

				IF ll_EquipCheck > 0 THEN

					ll_EquipId = ll_EquipCheck
					ls_EquipType = ldwo_EventCache_Container_Type.Primary [ ll_FirstUnconfRow ]
					ls_EquipNumber = ldwo_EventCache_Container_Number.Primary [ ll_FirstUnconfRow ]

					ldwo_NextEvent_Container_Type.Primary [ ll_ShipRow ] = ls_EquipType
					ldwo_NextEvent_Container_Number.Primary [ ll_ShipRow ] = ls_EquipNumber

				END IF


				ldwo_NextEvent_Driver_FirstName.Primary [ ll_ShipRow ] = ldwo_EventCache_Driver_FirstName.Primary [ ll_FirstUnconfRow ]
				ldwo_NextEvent_Driver_LastName.Primary [ ll_ShipRow ] = ldwo_EventCache_Driver_LastName.Primary [ ll_FirstUnconfRow ]
				ldwo_NextEvent_Driver_CodeName.Primary [ ll_ShipRow ] = ldwo_EventCache_Driver_CodeName.Primary [ ll_FirstUnconfRow ]

			END IF

		END IF


		//Now, we're going to determine the freight-carrying equipment (or chassis) that was used on 
		//the event PRIOR to the next event, or on the last confirmed event, if there is no next event.
		//(Note: This means this will be blank until at least one event is confirmed.)
		//Note: We will be recording chassis info, NOT container info, on a container move.
		//The idea here is that you may be using either company or borrowed chassis, but the container will 
		//always be borrowed, so in terms of "Equipment" for the event, we'll record what might be yours.

		//Note: This is a change from 3.7 to 3.8.  In 3.7, this field was used to show the freight-carrying
		//equipment on the next event, with no looking backwards.  Prior to 3.7, there was looking backwards,
		//using different logic, which was abandoned, because it was ambiguous where the value had come from,
		//and could therefore be misleading.
		
		//Note: This re-interpretation of the contents of these fields makes the column names used in the 
		//d_shipmentlist_xxxx data objects (which the user sees in sort / filter dialogs, etc.) a misnomer.
		//It's really not "nextevent_equipment_..." anymore, it's really now "lastconfirmed_equipment_..."
		//(Although, in most cases except cross dock, these will in fact turn out to be the same, since the
		//freight carrying equipment only changes in a crossdock situation.)
		//But, changing the names on these columns could be an adventure, particularly given the custom
		//shipment summary definitions that are out there, so I'm not going to mess with that now.
		//Could be a subject to reconsider in the future, however.  --BKW


		//Clear these variables so that the logic below can populate them, if possible,
		//and we'll be able to tell if it couldn't if they're still null afterwards.

		SetNull ( ll_EquipId )
		SetNull ( ls_EquipType )
		SetNull ( ls_EquipNumber )

		ll_Check = 0

		IF ll_FirstUnconfRow > 1 THEN
			
			ll_Check = ll_FirstUnconfRow - 1
			
		ELSEIF ll_LastConfRow > 0 THEN
			
			ll_Check = ll_LastConfRow
			
		END IF
		
		
		//If we determined a row, now see if we can get the freight-carrying equipment (or chassis) for
		//that event.  We'll look at trailer/chassis first, using that if it's specified, then at power unit, 
		//only using that if it's freight-carrying equipment, (ie. a Straight Truck or Van).
		
		IF ll_Check > 0 THEN
			

//			NOT GOING TO USE CONTAINER INFO, BUT THIS IS WHAT WE'D NEED IF WE DID.  NOTE THAT DOING THIS
//			WOULD REQUIRE YOU TO REMOVE THE LINE THAT FOLLOWS THIS COMMENT WHERE WE GET THE TRAILER ID 
//			INTO ll_EquipCheck NO MATTER WHAT.

//			ll_EquipCheck = ldwo_EventCache_Container_Id.Primary [ ll_Check ]
//
//			IF ll_EquipCheck > 0 THEN
//
//				ll_EquipId = ll_EquipCheck
//				ls_EquipType = ldwo_EventCache_Container_Type.Primary [ ll_Check ]
//				ls_EquipNumber = ldwo_EventCache_Container_Number.Primary [ ll_Check ]
//				
//				//Since we've got a value now, clear ll_EquipCheck so the next check doesn't execute.
//				ll_EquipCheck = 0
//
//			ELSE
//				
//				//We don't have a container, so get the value for the next check.
//				ll_EquipCheck = ldwo_EventCache_Trailer_Id.Primary [ ll_Check ]
//
//			END IF


			ll_EquipCheck = ldwo_EventCache_Trailer_Id.Primary [ ll_Check ]

			IF ll_EquipCheck > 0 THEN

				ll_EquipId = ll_EquipCheck
				ls_EquipType = ldwo_EventCache_Trailer_Type.Primary [ ll_Check ]
				ls_EquipNumber = ldwo_EventCache_Trailer_Number.Primary [ ll_Check ]
				
				//Since we've got a value now, clear ll_EquipCheck so the next check doesn't execute.
				ll_EquipCheck = 0
				
			ELSE
				
				//We don't have a trailer/chassis, so get the value for the next check.
				ll_EquipCheck = ldwo_EventCache_PowerUnit_Id.Primary [ ll_Check ]				

			END IF


			IF ll_EquipCheck > 0 THEN
				
				ls_EquipType = ldwo_EventCache_PowerUnit_Type.Primary [ ll_Check ]
				
				CHOOSE CASE ls_EquipType
						
				CASE "S" /*StraightTruck*/, "N" /*VAN*/

					ll_EquipId = ll_EquipCheck
					ls_EquipType = ldwo_EventCache_PowerUnit_Type.Primary [ ll_Check ]
					ls_EquipNumber = ldwo_EventCache_PowerUnit_Number.Primary [ ll_Check ]
					
				CASE ELSE
					
					//Power Unit is not freight-carrying.  Don't use it for this value.
					
					//Clear out what we read into ls_EquipType.  This shouldn't be used w.o. ll_EquipId 
					//being set, but just so there's no unintended values carrying through in the variables.
					
					ls_EquipType = ""
					
				END CHOOSE
				
			//ELSE
				
				//Nothing more to check.  We don't have a value for this field.

			END IF


			//If any of the above logic has determined the freight-carrying equipment (or chassis) 
			//used for the previous event, write that info into the datastore.
	
			IF ll_EquipId > 0 THEN
	
				ads_Target.Object.cc_Equip_Id [ ll_ShipRow ] = ll_EquipId
				ads_Target.Object.cc_Equip_Type [ ll_ShipRow ] = ls_EquipType
				ads_Target.Object.cc_Equip_Ref [ ll_ShipRow ] = ls_EquipNumber
				ads_Target.Object.cc_Equip_Description [ ll_ShipRow ] = ls_EquipNumber
				//The description field was intended for having the type info like "STRT" or "TRLR", 
				//but since we don't have a convenient source of that here, just use the equip number.
	
			END IF

		END IF



		IF ll_FirstUnconfRow > 0 THEN

			li_Index = 1
			ll_Row = ll_FirstUnconfRow

			DO UNTIL li_Index >= 4 OR ll_Row >= ll_EventCount

			//It's really the = that should stop this, but we'll use >= for insurance coming in.

				li_Index ++
				ll_Row ++

				This.of_PopulateEventStructure ( lds_Event, ll_Row, lstr_NextEvent )

				IF lstr_NextEvent.il_Id > 0 THEN
		
					CHOOSE CASE li_Index

					CASE 2
						ldwo_NextEvent2_Type.Primary [ ll_ShipRow ] = lnv_Events.of_GetTypeDisplayValueShort ( lstr_NextEvent.is_Type )
						ldwo_NextEvent2_SiteId.Primary [ ll_ShipRow ] = lstr_NextEvent.il_Site
						ldwo_NextEvent2_Date.Primary [ ll_ShipRow ] = lstr_NextEvent.id_Appointment
						ldwo_NextEvent2_Time.Primary [ ll_ShipRow ] = lstr_NextEvent.it_Appointment
						ldwo_NextEvent2_Assigned.Primary [ ll_ShipRow ] = lstr_NextEvent.is_Assigned

					CASE 3
						ldwo_NextEvent3_Type.Primary [ ll_ShipRow ] = lnv_Events.of_GetTypeDisplayValueShort ( lstr_NextEvent.is_Type )
						ldwo_NextEvent3_SiteId.Primary [ ll_ShipRow ] = lstr_NextEvent.il_Site
						ldwo_NextEvent3_Date.Primary [ ll_ShipRow ] = lstr_NextEvent.id_Appointment
						ldwo_NextEvent3_Time.Primary [ ll_ShipRow ] = lstr_NextEvent.it_Appointment
						ldwo_NextEvent3_Assigned.Primary [ ll_ShipRow ] = lstr_NextEvent.is_Assigned

					CASE 4
						ldwo_NextEvent4_Type.Primary [ ll_ShipRow ] = lnv_Events.of_GetTypeDisplayValueShort ( lstr_NextEvent.is_Type )
						ldwo_NextEvent4_SiteId.Primary [ ll_ShipRow ] = lstr_NextEvent.il_Site
						ldwo_NextEvent4_Date.Primary [ ll_ShipRow ] = lstr_NextEvent.id_Appointment
						ldwo_NextEvent4_Time.Primary [ ll_ShipRow ] = lstr_NextEvent.it_Appointment
						ldwo_NextEvent4_Assigned.Primary [ ll_ShipRow ] = lstr_NextEvent.is_Assigned

					END CHOOSE
		
				END IF

			LOOP

		END IF


		IF lstr_CurrentEvent.il_Id > 0 THEN
			ldwo_CurEvent_Id.Primary [ ll_ShipRow ] = lstr_CurrentEvent.il_Id
			ldwo_CurEvent_Type.Primary [ ll_ShipRow ] = lnv_Events.of_GetTypeDisplayValueShort ( lstr_CurrentEvent.is_Type )
			ldwo_CurEvent_Site.Primary [ ll_ShipRow ] = lstr_CurrentEvent.il_Site
			ldwo_CurEvent_Date.Primary [ ll_ShipRow ] = lstr_CurrentEvent.id_Arrive
			ldwo_CurEvent_Time.Primary [ ll_ShipRow ] = lstr_CurrentEvent.it_Arrive
		END IF


//		This approach was not possible due to PB Crash when attempting RPC Call to a stored procedure that returns 
//		a value as opposed to a stored procedure by reference

//		//GetShipmentFTE (FreeTimeExpiration)  Added 3.9.00 BKW 5/27/04  
//		
//		SetNull ( ld_FTE )
//		
//		//This is an RPC to a stored procedure.  There's no commit in the stored procedure, so I'm going to commit here.
//		ld_FTE = SQLCA.GetShipmentFTE ( ll_ShipmentID )
//		
//		li_SqlCode = SQLCA.SqlCode
//		COMMIT ;
//		
//		CHOOSE CASE li_SqlCode
//				
//			CASE 0
//
//				IF NOT IsNull ( ld_FTE ) THEN
//					ldwo_FTE.Primary [ ll_ShipRow ] = ld_FTE
//				END IF
//				
//			CASE ELSE
//				
//				lb_Failed = TRUE
//				GOTO Ship_Cleanup
//				
//		END CHOOSE


		//Load Shipment Free Time Expiration   Added 3.9.00 BKW 5/27/04
		
		ll_FTERow = lds_FTE.Find ( "ds_id = " + String ( ll_ShipmentId ), 1, ll_FTERowCount )
		
		IF ll_FTERow > 0 THEN
			
			ld_FTE = ldwo_SourceFTE.Primary [ ll_FTERow ]
			
			IF NOT IsNull ( ld_FTE ) THEN
				
				ldwo_FTE.Primary [ ll_ShipRow ] = ld_FTE
				
			END IF
			
//		ELSE   Since retrieval succeeded earlier, this is unlikely, and failure does not seem necessary here...
//			
//			lb_Failed = TRUE
//			GOTO Ship_Cleanup
			
		END IF



/////////////////////////////////////|||||||||***************|||||||||||||||||||||\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
		
		// populate the new Datetime objects <<*>>
		
		IF lb_ProcessExtended	THEN
			
			IF ll_ShipmentId = 89 THEN
				ll_ShipmentId = 89 
			END IF
					
			SetNull ( ldtm_Pickup )
			SetNull ( ldtm_PickUpFromShip )
			SetNull ( ldtm_PickUpEvents )			
			IF lstr_OriginEvent.is_Confirmed = 'T' THEN			
			ELSE													
			// get the pickup date/time from the shipment to compare with the values on the event
				ld_temp = ads_Target.Object.pickupbydate[ll_ShipRow]
				lt_Temp = ads_Target.Object.pickupbytime[ll_ShipRow]	
				IF isNull ( lt_Temp ) THEN							
					lt_Temp = Time ( "23:59:00" )
				END IF
				ldtm_PickUpFromShip =	DateTime ( ld_temp , lt_Temp 	)					
				
				
				IF isNull ( lstr_OriginEvent.it_Appointment ) THEN
					lt_Temp = Time ( "23:59:00" )
				ELSE 
					lt_Temp = lstr_OriginEvent.it_Appointment
				END IF
				ldtm_PickUpEvents = DateTime ( lstr_OriginEvent.id_Appointment, lt_Temp )
				
				
				IF ldtm_pickUpEvents < ldtm_PickUpFromShip OR isNull(ldtm_PickUpFromShip) THEN
					ldtm_Pickup = ldtm_pickUpEvents
				ELSE
					ldtm_Pickup = ldtm_PickUpFromShip
				END IF
			END IF
			ldwo_Shipment_Pickupby.Primary [ ll_ShipRow ] = ldtm_Pickup
			
			
			
			SetNull ( ldtm_Delby )  // in export the drop by is the delby
			SetNull ( ldtm_DeliverFromShipment )
			SetNull ( ldtm_DeliverFromEvents )
			IF lstr_FindestEvent.is_Confirmed = 'T' THEN
			ELSE
				IF  (  (ldwo_Movecode.Primary [ ll_ShipRow ] ='E') AND (lstr_OriginEvent.is_Confirmed = 'T' OR (ldwo_NextEvent_Site.primary [ ll_ShipRow ] = ll_OriginSite AND (ldwo_NextEvent_Type.Primary [ ll_ShipRow ] = 'HK' OR ldwo_NextEvent_Type.Primary [ ll_ShipRow ] = 'MT')  ) ) ) THEN					
				ELSE								
					ld_temp = ads_Target.Object.delbydate[ll_ShipRow]
					lt_Temp = ads_Target.Object.delbytime[ll_ShipRow]	
					IF isNull ( lt_Temp ) THEN							
						lt_Temp = Time ( "23:59:00" )
					END IF
					ldtm_DeliverFromShipment =	DateTime ( ld_temp , lt_Temp )
						
					IF IsNull ( lstr_FindestEvent.it_Appointment ) THEN
						lt_Temp = Time ( "23:59:00" )
					ELSE
						lt_Temp = lstr_FindestEvent.it_Appointment					
					END IF
					ldtm_DeliverFromEvents = DateTime ( lstr_FindestEvent.id_Appointment, lt_Temp )	
					
					IF ldtm_DeliverFromShipment < ldtm_DeliverFromEvents OR isNull(ldtm_DeliverFromEvents)THEN
						ldtm_Delby = ldtm_DeliverFromShipment
					ELSE
						ldtm_Delby = ldtm_DeliverFromEvents
					END IF
					
				END IF
			END IF
			ldwo_shipment_delby.primary [ ll_shiprow ] = ldtm_Delby
			
			
			////////////////
			/////%%%%%%%%%%					
			setNull ( ldtm_Cutoff )		
			SetNull ( ldtm_CutoffFromEvents )
			SetNull ( ldtm_CutoffFromShipment )
			IF isNull ( ldwo_cutoffTime.Primary [ ll_ShipRow ] ) THEN
				ldtm_CutoffFromShipment = DateTime ( Date ( ldwo_CutoffDate.Primary [ ll_ShipRow ] ), 23:59:00 )
			ELSE
				ldtm_CutoffFromShipment = DateTime ( ldwo_cutoffDate.Primary [ ll_ShipRow ], ldwo_cutoffTime.Primary [ ll_ShipRow ] )
			END IF
			
			IF ldwo_Movecode.Primary [ ll_ShipRow ] <>'I' THEN
				IF IsNull ( lstr_FindestEvent.it_Appointment ) THEN
					lt_Temp = Time ( "23:59:00" )
				ELSE
					lt_Temp = lstr_FindestEvent.it_Appointment					
				END IF
				
				ldtm_CutoffFromEvents = DateTime ( lstr_FindestEvent.id_Appointment, lt_Temp )	
			END IF
			
			IF ldtm_CutoffFromShipment < ldtm_CutoffFromEvents OR isNull(ldtm_CutoffFromEvents)THEN
				ldtm_Cutoff = ldtm_CutoffFromShipment
			ELSE
				ldtm_Cutoff = ldtm_CutoffFromEvents
			END IF					
			ldwo_Cutoff.primary [ ll_shiprow ] = ldtm_Cutoff
			//////%%%%%%%%%%
			//////////////////
			
			SetNull ( ldtm_LastFree )			
			IF IsNull ( lstr_OriginEvent.is_Confirmed = 'T' ) THEN			
			ELSE
				IF isNull ( ldwo_LastFreeTime.Primary[ ll_shipRow ] ) THEN
					lt_Temp = Time ( "23:59:00" )
				ELSE
					lt_Temp = ldwo_LastFreeTime.Primary[ ll_shipRow ]
				END IF
				ldtm_LastFree = DateTime ( ldwo_LastFreeDate.primary [ ll_ShipRow ], lt_Temp )
			END IF
			ldwo_LastFree.primary [ ll_shiprow ] = ldtm_LastFree
																
			SetNull ( ldtm_FTE ) 
			IF Not IsNull ( ldwo_FTE.Primary [ ll_ShipRow ] ) THEN
				ldtm_FTE = DateTime ( ldwo_FTE.Primary [ ll_ShipRow ] , Time ( "23:59:00" ) )
			END IF
			ldwo_ShipmentFTE.Primary [ll_ShipRow] = ldtm_FTE
			
			
			//shipment_earliestfreightdeadline 
			SetNull ( ldtm_EarliestFreightDeadline )					
						IF Not isNull ( ldtm_Pickup ) THEN
				ldtma_Compare [ UpperBound ( ldtma_Compare ) + 1 ] = ldtm_Pickup
			END IF
			IF Not isNull ( ldtm_Delby ) THEN
				ldtma_Compare [ UpperBound ( ldtma_Compare ) + 1 ] = ldtm_Delby
			END IF
			IF Not isNull ( ldtm_Cutoff ) THEN
				ldtma_Compare [ UpperBound ( ldtma_Compare ) + 1 ] = ldtm_Cutoff
			END IF
 			IF UpperBound ( ldtma_Compare ) > 0 THEN
				ldtm_EarliestFreightDeadline = ldtma_Compare[1]
			END IF				
			FOR li_DateIndex = 2 TO UpperBound ( ldtma_Compare )
				IF ldtma_Compare [li_DateIndex] < ldtm_EarliestFreightDeadline THEN
					ldtm_EarliestFreightDeadline = ldtma_Compare [li_DateIndex]
				END IF
			NEXT
			ldwo_ShipmentEarliestFreightDeadline.Primary [ ll_ShipRow ] = ldtm_EarliestFreightDeadline	
										
	
	//		shipment_earliestfreightdeadlinetype 
			SetNull ( ls_DeadlineType )
			CHOOSE CASE ldtm_EarliestFreightDeadline
				CASE ldtm_Cutoff
					IF ldwo_Movecode.Primary [ ll_ShipRow ] ='O' THEN
						ls_DeadlineType = "Del"
					ELSE
						ls_DeadlineType = "Cut"
					END IF
				CASE ldtm_delby
					ls_DeadlineType = "Del"
				CASE ldtm_Pickup
					ls_DeadlineType = "PU"
				CASE ELSE
					ls_deadlineType = ""
			END CHOOSE
			ldwo_FreightDeadLineType.primary [ ll_ShipRow ] = ls_DeadlineType
												
	//		shipment_earliestfreedeadline
			SetNull ( ldtm_FreeDeadline )
			IF (ldwo_Movecode.Primary [ ll_ShipRow ] <>'E') AND (lstr_OriginEvent.is_Confirmed = 'T' ) THEN
				// use the FTE
				ldtm_FreeDeadline = ldtm_FTE
			ELSE
				IF ldtm_LastFree < ldtm_FTE OR isNull ( ldtm_FTE ) THEN
					ldtm_FreeDeadline = ldtm_LastFree
				ELSE
					ldtm_FreeDeadline = ldtm_FTE
				END IF
			END IF
			ldwo_shipmentearliestfreedeadline.Primary [ ll_Shiprow ] = ldtm_FreeDeadline
			
			
			//shipment_earliestfreedeadlinetype  
			SetNull ( ls_DeadlineType )
			CHOOSE CASE ldtm_FreeDeadline
				CASE ldtm_LastFree
					ls_DeadlineType = "Lfd"
				CASE ldtm_FTE
					ls_DeadlineType = "Rtn"
				CASE ELSE
					ls_deadlineType = ""
			END CHOOSE
			ldwo_FreeDeadLineType.primary [ ll_ShipRow ] = ls_DeadlineType
			
									
		//	shipment_earliestdeadline  
			SetNull ( ldtm_EarliestDeadLine )
			IF isNull ( ldtm_FreeDeadline ) THEN
				//ldtm_FreeDeadline = DateTime ( Date ( "12/31/2010" ) )
			END IF
			IF ldtm_EarliestFreightDeadline < ldtm_FreeDeadline OR isNull ( ldtm_FreeDeadline ) THEN
				ldtm_EarliestDeadLine = ldtm_EarliestFreightDeadline
			ELSE
				ldtm_EarliestDeadLine = ldtm_FreeDeadline
			END IF
			ldwo_EarliestDeadline.Primary [ ll_shiprow ] = ldtm_EarliestDeadLine
	
		//	shipment_needsloadedempty  
			SetNull ( ls_loadedEmpty )
			CHOOSE CASE ldwo_Movecode.Primary [ ll_ShipRow ] 
				CASE 'I'
					IF lstr_FindestEvent.is_Confirmed = 'T' AND ldwo_NextEvent_Site.primary [ ll_ShipRow ] = ll_FindestSite AND isNull (  ldwo_EmptyAtCustomerDate.primary[ ll_ShipRow ] ) THEN
						ls_LoadedEmpty = 'E?'
					ELSE
						ls_LoadedEmpty = ""
					END IF
					
				CASE 'E'
					
					IF lstr_OriginEvent.is_Confirmed = 'T' THEN
						ls_LoadedEmpty = ""
					ELSEIF  ldwo_NextEvent_Site.primary [ ll_ShipRow ] = ll_originSite AND isNull ( ldwo_LoadedAtCustomerDate.primary[ ll_ShipRow ] ) AND (ldwo_NextEvent_Type.Primary [ ll_ShipRow ] = 'HK' OR ldwo_NextEvent_Type.Primary [ ll_ShipRow ] = 'MT')THEN
						ls_LoadedEmpty = 'L?'						
					ELSE
						ls_LoadedEmpty = ""
					END IF
				
			END CHOOSE	
			ldwo_LoadedEmpty.primary [ ll_Shiprow ] = ls_LoadedEmpty
		END IF																												
	
	
		ldtma_Compare = ldtma_Empty

		
	/////////////////////////////////////|||||||||***************|||||||||||||||||||||\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

	NEXT
*/
//end optimize performance , comment by appeon 20080801
	//Load company information

	for ll_ReadLoop = 1 to ll_ChangedShipmentCount
		lla_CacheCompanies[ll_ReadLoop * 9 - 8] = ldwo_Carrier_Id.Primary[ll_ReadLoop]
		lla_CacheCompanies[ll_ReadLoop * 9 - 7] = ldwo_NextEvent2_SiteId.Primary[ll_ReadLoop]
		lla_CacheCompanies[ll_ReadLoop * 9 - 6] = ldwo_NextEvent3_SiteId.Primary[ll_ReadLoop]
		lla_CacheCompanies[ll_ReadLoop * 9 - 5] = ldwo_NextEvent4_SiteId.Primary[ll_ReadLoop]
		lla_CacheCompanies[ll_ReadLoop * 9 - 4] = ads_Target.GetItemNumber ( ll_ReadLoop, "cc_CurEvent_Site" )
		lla_CacheCompanies[ll_ReadLoop * 9 - 3] = ads_Target.GetItemNumber ( ll_ReadLoop, "cc_NextEvent_Site" )
		lla_CacheCompanies[ll_ReadLoop * 9 - 2] = ldwo_Billto_Id.primary[ll_ReadLoop]
		lla_CacheCompanies[ll_ReadLoop * 9 - 1] = ldwo_OriginId.primary[ll_ReadLoop]
		lla_CacheCompanies[ll_ReadLoop * 9] = ldwo_FindestId.primary[ll_ReadLoop]
	next
	gnv_cst_companies.of_cache(lla_CacheCompanies, false)

	//Point the company beo at the cache
	lnv_Company.of_SetUseCache ( TRUE )

	for ll_ShipRow = 1 to ll_ChangedShipmentCount

		ll_CompanyId = ldwo_NextEvent_Site.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			ldwo_NextEvent_Company.Primary [ ll_ShipRow ] = lnv_Company.of_GetName ( )
			ldwo_NextEvent_City.Primary [ ll_ShipRow ] = lnv_Company.of_GetCity ( )
			ldwo_NextEvent_State.Primary [ ll_ShipRow ] = lnv_Company.of_GetState ( )
			ldwo_NextEvent_Location.Primary [ ll_ShipRow ] = lnv_Company.of_GetLocation ( )
		END IF


		ll_CompanyId = ldwo_NextEvent2_SiteId.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			ldwo_NextEvent2_Site.Primary [ ll_ShipRow ] = lnv_Company.of_GetName ( )
			ldwo_NextEvent2_City.Primary [ ll_ShipRow ] = lnv_Company.of_GetCity ( )
			ldwo_NextEvent2_State.Primary [ ll_ShipRow ] = lnv_Company.of_GetState ( )
		END IF


		ll_CompanyId = ldwo_NextEvent3_SiteId.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			ldwo_NextEvent3_Site.Primary [ ll_ShipRow ] = lnv_Company.of_GetName ( )
			ldwo_NextEvent3_City.Primary [ ll_ShipRow ] = lnv_Company.of_GetCity ( )
			ldwo_NextEvent3_State.Primary [ ll_ShipRow ] = lnv_Company.of_GetState ( )
		END IF


		ll_CompanyId = ldwo_NextEvent4_SiteId.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			ldwo_NextEvent4_Site.Primary [ ll_ShipRow ] = lnv_Company.of_GetName ( )
			ldwo_NextEvent4_City.Primary [ ll_ShipRow ] = lnv_Company.of_GetCity ( )
			ldwo_NextEvent4_State.Primary [ ll_ShipRow ] = lnv_Company.of_GetState ( )
		END IF


		ll_CompanyId = ldwo_CurEvent_Site.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			ldwo_CurEvent_Company.Primary [ ll_ShipRow ] = lnv_Company.of_GetName ( )
			ldwo_CurEvent_City.Primary [ ll_ShipRow ] = lnv_Company.of_GetCity ( )
			ldwo_CurEvent_State.Primary [ ll_ShipRow ] = lnv_Company.of_GetState ( )
			ldwo_CurEvent_Location.Primary [ ll_ShipRow ] = lnv_Company.of_GetLocation ( )
		END IF


		ll_CompanyId = ldwo_Billto_Id.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			ldwo_Billto_Name.Primary [ ll_ShipRow ] = lnv_Company.of_GetBillingName ( )
			ldwo_Billto_SalesRep.Primary [ ll_ShipRow ] = lnv_Company.of_GetSalesRep ( )
		END IF

		ll_CompanyId = ldwo_OriginId.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			origin_name.primary[ll_ShipRow] = lnv_Company.of_GetName ( )
			origin_city.primary[ll_ShipRow] = lnv_Company.of_GetCity ( )
			origin_state.primary[ll_ShipRow] = lnv_Company.of_GetState ( )
		END IF


		ll_CompanyId = ldwo_FindestId.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			findest_name.primary[ll_ShipRow] = lnv_Company.of_GetName ( )
			findest_city.primary[ll_ShipRow] = lnv_Company.of_GetCity ( )
			findest_state.primary[ll_ShipRow] = lnv_Company.of_GetState ( )
		END IF


		ll_CompanyId = ldwo_Carrier_Id.Primary [ ll_ShipRow ]

		IF NOT IsNull ( ll_CompanyId ) THEN
			lnv_Company.of_SetSourceId ( ll_CompanyId )
			ldwo_Carrier_Name.Primary[ll_ShipRow] = lnv_Company.of_GetName ( )
		END IF

	next

end if
//begin comment by appeon 20070801
//modify goto statement
//ship_cleanup:
//
//DESTROY ldwo_Billto_Id
//DESTROY ldwo_Billto_Name
//DESTROY ldwo_Billto_SalesRep
//DESTROY ldwo_OriginId
//DESTROY origin_name
//DESTROY origin_city
//DESTROY origin_state
//DESTROY ldwo_FindestId
//DESTROY findest_name
//DESTROY findest_city
//DESTROY findest_state
//DESTROY ldwo_Carrier_Id
//DESTROY ldwo_Carrier_Name
//DESTROY cs_timestamp
//
//DESTROY ldwo_CurEvent_Id
//DESTROY ldwo_CurEvent_Type
//DESTROY ldwo_CurEvent_Date
//DESTROY ldwo_CurEvent_Time
//
//DESTROY ldwo_CurEvent_Company
//DESTROY ldwo_CurEvent_City
//DESTROY ldwo_CurEvent_State
//DESTROY ldwo_CurEvent_Location
//DESTROY ldwo_CurEvent_Site
//
//DESTROY ldwo_NextEvent_Id
//DESTROY ldwo_NextEvent_Type
//DESTROY ldwo_NextEvent_Date
//DESTROY ldwo_NextEvent_Time
//DESTROY ldwo_NextEvent_Assigned
//DESTROY ldwo_NextEvent_Dispatched
//DESTROY ldwo_NextEvent_Arrived
//
//DESTROY ldwo_NextEvent_Company
//DESTROY ldwo_NextEvent_City
//DESTROY ldwo_NextEvent_State
//DESTROY ldwo_NextEvent_Location
//DESTROY ldwo_NextEvent_Site
//
//DESTROY ldwo_NextEvent2_Type
//DESTROY ldwo_NextEvent2_SiteId
//DESTROY ldwo_NextEvent2_Site
//DESTROY ldwo_NextEvent2_City
//DESTROY ldwo_NextEvent2_State
//DESTROY ldwo_NextEvent2_Date
//DESTROY ldwo_NextEvent2_Time
//DESTROY ldwo_NextEvent2_Assigned
//
//DESTROY ldwo_NextEvent3_Type
//DESTROY ldwo_NextEvent3_SiteId
//DESTROY ldwo_NextEvent3_Site
//DESTROY ldwo_NextEvent3_City
//DESTROY ldwo_NextEvent3_State
//DESTROY ldwo_NextEvent3_Date
//DESTROY ldwo_NextEvent3_Time
//DESTROY ldwo_NextEvent3_Assigned
//
//DESTROY ldwo_NextEvent4_Type
//DESTROY ldwo_NextEvent4_SiteId
//DESTROY ldwo_NextEvent4_Site
//DESTROY ldwo_NextEvent4_City
//DESTROY ldwo_NextEvent4_State
//DESTROY ldwo_NextEvent4_Date
//DESTROY ldwo_NextEvent4_Time
//DESTROY ldwo_NextEvent4_Assigned
//
//DESTROY ldwo_Equip_Description
//DESTROY ldwo_TotalPieces
//DESTROY ldwo_FTE
//DESTROY ldwo_SourceFTE
//
//DESTROY ldwo_ScheduledPickupDate
//DESTROY ldwo_ScheduledPickupTime
//DESTROY ldwo_PickedUp
//DESTROY ldwo_DatePickedUp
//DESTROY ldwo_TimePickedUp
//DESTROY ldwo_ScheduledDeliveryDate
//DESTROY ldwo_ScheduledDeliveryTime
//DESTROY ldwo_Delivered
//DESTROY ldwo_DateDelivered
//DESTROY ldwo_TimeDelivered
//
//DESTROY ldwo_RateType
//DESTROY ldwo_Rate
//DESTROY ldwo_Charges
//DESTROY ldwo_Miles
//
//DESTROY ldwo_PayRateType
//DESTROY ldwo_PayRate
//DESTROY ldwo_Payables
//
//DESTROY ldwo_Item1_RateType
//DESTROY ldwo_Item1_Rate
//DESTROY ldwo_Item1_Charges
//DESTROY ldwo_Item1_Miles
//
//DESTROY ldwo_Item1_PayRateType
//DESTROY ldwo_Item1_PayRate
//DESTROY ldwo_Item1_Payables
//
//DESTROY ldwo_NextEvent_PowerUnit_Type
//DESTROY ldwo_NextEvent_PowerUnit_Number
//DESTROY ldwo_NextEvent_Trailer_Type
//DESTROY ldwo_NextEvent_Trailer_Number
//DESTROY ldwo_NextEvent_Container_Type
//DESTROY ldwo_NextEvent_Container_Number
//DESTROY ldwo_NextEvent_Driver_FirstName
//DESTROY ldwo_NextEvent_Driver_LastName
//DESTROY ldwo_NextEvent_Driver_CodeName
//
//DESTROY ldwo_EventCache_PowerUnit_Type
//DESTROY ldwo_EventCache_PowerUnit_Number
//DESTROY ldwo_EventCache_PowerUnit_Id
//DESTROY ldwo_EventCache_Trailer_Type
//DESTROY ldwo_EventCache_Trailer_Number
//DESTROY ldwo_EventCache_Trailer_id
//DESTROY ldwo_EventCache_Container_Type
//DESTROY ldwo_EventCache_Container_Number
//DESTROY ldwo_EventCache_Container_Id
//DESTROY ldwo_EventCache_Driver_FirstName
//DESTROY ldwo_EventCache_Driver_LastName
//DESTROY ldwo_EventCache_Driver_CodeName
//
//DESTROY lds_Event
//DESTROY lds_Item
//DESTROY lds_FTE
//DESTROY lnv_Company
//DESTROY lnv_Rating
//
//
//IF lb_ProcessExtended THEN
//	DESTROY	ldwo_Shipment_Pickupby
//	DESTROY 	ldwo_Shipment_delby
//	DESTROY 	ldwo_Movecode
//	DESTROY 	ldwo_CutoffDate
//	DESTROY 	ldwo_CutoffTime
//	DESTROY 	ldwo_Cutoff
//	DESTROY	ldwo_lastFree
//	DESTROY	ldwo_lastFreeDate
//	DESTROY	ldwo_lastFreeTime
//	DESTROY 	ldwo_ShipmentFTE
//	DESTROY	ldwo_ShipmentEarliestFreightDeadline
//	DESTROY	ldwo_shipmentearliestfreedeadline
//	DESTROY	ldwo_FreightDeadLineType
//	DESTROY	ldwo_FreeDeadLineType
//	DESTROY	ldwo_EarliestDeadline
//	DESTROY 	ldwo_LoadedEmpty
//	DESTROY	ldwo_LoadedAtCustomerDate
//	DESTROY 	ldwo_EmptyAtCustomerDate
//	DESTROY	ldwo_ShipEq1Type
//	DESTROY 	ldwo_ShipEq1Length
//	DESTROY 	ldwo_ShipEq1Ref
//	DESTROY 	ldwo_ShipEq1LeaseLine
//	DESTROY 	ldwo_ShipEq1LeaseType
//	DESTROY 	ldwo_ShipEq1Notes
//	DESTROY	ldwo_ShipEq2Type
//	DESTROY 	ldwo_ShipEq2Length
//	DESTROY 	ldwo_ShipEq2Ref
//	DESTROY 	ldwo_ShipEq2LeaseLine
//	DESTROY 	ldwo_ShipEq2LeaseType
//	DESTROY 	ldwo_ShipEq2Notes
//END IF
//
//end comment by appeon 20070801
IF lb_Failed THEN
	RETURN -1
ELSE
	RETURN 1
END IF


end function

public function long of_getidfromtemplate (string as_Template);
long	ll_Return
Long	ll_RowCount
Long	ll_FindRtn
String	ls_Template

DataStore	lds_Templates

lds_Templates = CREATE DataStore
lds_Templates.Dataobject = "d_templateList"
lds_Templates.SetTransObject ( SQLCA )

ls_Template = Upper (TRIM ( as_Template ) )

ll_RowCount = lds_Templates.Retrieve ( )
IF ll_RowCount > 0 THEN
	ll_FindRtn = lds_Templates.Find ( "ds_ref1_Text = '" + ls_Template + "'" , 1, ll_RowCount + 1 )
	IF ll_FindRtn > 0 THEN
		ll_Return = lds_Templates.GetItemNumber ( ll_FindRtn , "ds_id" )
	END IF
END IF

DESTROY ( lds_Templates )

RETURN ll_Return


	
end function

public function integer of_createshipment (n_cst_messagedata anv_msgdata, ref n_cst_msg anv_msg);Int		li_Return = 1
Int		li_CreateRtn
String	ls_template
String	ls_EqRef
Long		ll_ShipmentID
Long		ll_Equipment

S_Parm	lstr_Parm
n_cst_Msg	lnv_Msg


IF Not isValid ( anv_msgdata ) THEN
	RETURN -1									/// EARLY RETURN
END IF


ls_Template = anv_msgdata.of_GetShipmentTemplate ( )
ll_ShipmentID = THIS.of_GetIDFromTemplate ( ls_Template )

IF ll_ShipmentID > 0 THEN
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = ll_ShipmentID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "TEMPLATE"
	lstr_Parm.ia_Value = TRUE
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "COUNT"
	lstr_Parm.ia_Value = 1
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "DATE"
	lstr_Parm.ia_Value = Today ( )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	li_CreateRtn = THIS.of_DuplicateShipment ( lnv_Msg )
	
	IF li_CreateRtn <> 1 THEN
		li_Return = -1
	ELSE
		anv_msg = lnv_Msg
	END IF
	

END IF


RETURN li_Return
end function

private function integer of_cancelshipment (long al_shipmentid, ref n_cst_edi_204_record anv_204record);String		ls_ErrorText
Int			li_Return = 1
DataStore	lds_Shipments
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Dispatch = CREATE n_cst_bso_Dispatch

anv_204Record.of_SetShipmentID ( al_shipmentid )	
// set up the shipment beo	
lnv_Dispatch.of_RetrieveShipment ( al_shipmentid )
lds_Shipments = lnv_Dispatch.of_GetShipmentCache ( ) 
lnv_Shipment.of_Setsource ( lds_Shipments )
lnv_Shipment.of_SetSourceId ( al_shipmentid ) 
lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache () )
lnv_Shipment.of_SetAllowFilterSet  ( TRUE )
	
IF lnv_Shipment.of_SetStatus ( gc_dispatch.cs_shipmentstatus_cancelled ) <> 1 THEN
	ls_ErrorText += "could not set the status to canceled. " 
END IF
	

IF lnv_Dispatch.Event pt_Save ( ) <> 1 THEN
	ls_ErrorText += "Could not save the canceled shipment."
	li_Return = -1
END IF

anv_204record.of_SetSuccessfulImportFlag ( li_Return = 1 )
anv_204Record.of_SetErrorText ( ls_ErrorText )


DESTROY ( lnv_Shipment )
DESTROY ( lnv_Dispatch )

RETURN li_Return
end function

public function integer of_setshipmentcachecode (string as_code);//Changing the code will require that the summary be refreshed from scratch next time.
//So, clear the cache and reset all the appropriate flags, so that this will be done on refresh.
//If code is already set to the requested value, there's no need to force a reset -- 
//don't take any action.

n_cst_IniFile	lnv_IniFile
String	ls_AppIniFile, &
			lsa_Keys[], &
			ls_Response, &
			ls_MessageHeader = "Set Cache View"
Integer	li_Selection, &
			li_Index, &
			li_KeyCount
s_Strings	lstr_SelectionList
w_List_Sel	lw_Selection


IF as_Code = "ASK!" THEN
	
	ls_AppIniFile = gnv_App.of_GetAppIniFile ( )
	
	li_KeyCount = lnv_IniFile.of_GetKeys ( ls_AppIniFile, "ShipSum", lsa_Keys )
	
	CHOOSE CASE li_KeyCount
			
	CASE IS > 0  //Keys identified successfully.


		//Set the message header for the selection dialog.
		lstr_SelectionList.strar[1] = "Set Cache View"

		//Build the message text for the selection dialog.
		lstr_SelectionList.strar[2] = "Which cache view would you like to use?"
		
		//Loop through the keys and load them as selection options.
		//(Selection options are listed in the structure in postions 5 and up)
		//If one of the options is the current selection, indicate that in structure -- 
		//that option will be the default selection.  If no selection is indicated,
		//the dialog will highlight the first value  (the parameter is optional).
		
		FOR li_Index = 1 TO li_KeyCount
			
			lstr_SelectionList.strar [ li_Index + 4 ] = lsa_Keys [ li_Index ]
			
			IF lsa_Keys [ li_Index ] = ss_ShipmentCacheCode THEN
				lstr_SelectionList.strar [ 3 ] = String ( li_Index )
			END IF
			
		NEXT

		//Open the selection window.
		openwithparm(lw_Selection, lstr_SelectionList)

		//Get the selection response value.
		ls_Response = message.stringparm

		//Parse the selection out of the return value (there's a "q" on the end of it,
		//for who-knows-what reason).
		if len(ls_Response) > 0 then 
			li_Selection = integer(left(ls_Response, len(ls_Response) - 1))
		end if

		
		IF li_Selection > 0 THEN

			as_Code = lsa_Keys [ li_Selection ]
			
		ELSE
		
			//No selection made.  Use the current value.
			as_Code = ss_ShipmentCacheCode
			
		END IF
	
	CASE 0  //No keys defined.
		MessageBox ( ls_MessageHeader, "No cache view definitions are available.~n~n"+&
			"This feature can be used to break up the shipment summary into separate "+&
			"caches based on job function or operating unit.  For more information, "+&
			"contact Profit Tools tech support.~n~nThe standard cache view definition will "+&
			"be used." )
		SetNull ( as_Code )
		
	CASE -1
		MessageBox ( ls_MessageHeader, "There was a file error attempting to access the "+&
			"cache view settings in ~"" + ls_AppIniFile + "~".  The current cache view "+&
			"will be used." )
		as_Code = ss_ShipmentCacheCode
			
	CASE -2
		
		IF IsNull ( ls_AppIniFile ) THEN
			ls_AppIniFile = "[No File Specified]"
		END IF
		
		MessageBox ( ls_MessageHeader, "No cache view definitions are available.  "+&
			"The file ~"" + ls_AppIniFile + "~" could not be found.  The current cache "+&
			"view will be used." )
		as_Code = ss_ShipmentCacheCode
			
	CASE ELSE
		
		IF IsNull ( ls_AppIniFile ) THEN
			ls_AppIniFile = "[No File Specified]"
		END IF
		
		MessageBox ( ls_MessageHeader, "Unexpected return error attempting to access "+&
			"cache view settings in ~"" + ls_AppIniFile + "~".  The current cache view "+&
			"will be used." )
		as_Code = ss_ShipmentCacheCode

	END CHOOSE
	
END IF



IF ss_ShipmentCacheCode = as_Code THEN
	
	//Code is already set to the requested value.  No processing needed.
	
ELSE

	sds_Ship.Reset ( )
	sb_Ships_Retrieved = FALSE
	
	sdt_ships_refreshed = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sdt_ships_updated = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sdt_LastShipmentCacheWrite = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	
	//si_ships_filter = 0
	ss_ships_last_change = ""
	
	//These will be set by of_GetShipmentCacheFile, next time it is called.
	SetNull ( ss_ShipmentCacheFile )
	SetNull ( ss_ShipmentCacheWhereClauseExtension )
	
	ss_ShipmentCacheCode = as_Code
	
END IF

RETURN 1
end function

public function string of_getshipmentcachecode ();RETURN ss_ShipmentCacheCode
end function

public subroutine of_openshipment (long al_id, n_cst_msg anv_msg);n_cst_ratedata	lnva_ratedata[]
w_Dispatch	lw_Dispatch
n_cst_AppServices	lnv_AppServices

S_Parm	lstr_Parm
n_cst_Msg	lnv_Msg

lnv_Msg = anv_msg

lstr_Parm.is_label = "CATEGORY"
lstr_Parm.ia_Value = "SHIP"
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "ID"
lstr_Parm.ia_Value = al_Id
lnv_Msg.of_Add_Parm ( lstr_Parm )


if this.of_isautoratingmode() then
	this.of_getratedata(lnva_ratedata)
	lstr_Parm.is_label = "RATEDATA"
	lstr_Parm.ia_Value =  lnva_ratedata
	lnv_Msg.of_Add_Parm ( lstr_Parm )
end if

OpenSheetWithParm ( lw_Dispatch, lnv_Msg, lnv_AppServices.of_GetFrame ( ), 0, LAYERED! )
end subroutine

public function integer of_validateref1text (ref n_cst_beo_shipment anv_shipment);// RDT 12-06-02 Added code to check second and third reference numbers.
integer	li_Return = 1

Int		li_RefType
			
string	ls_WhereClause, &
			ls_Value, &
			ls_SQL, &
			ls_OriginalSelect, &
			ls_ModString//, &
		//	ls_RefTypes				// RDT 12-06-02 		
			
Boolean	lb_ValidateRef
Boolean	lb_ValidateBL

String	ls_Status
String	ls_Type
String	ls_Find

long		lla_Ids[], &
			ll_RowCount, &
			ll_Ndx, &
			ll_ArrayCount
Any		la_Setting
String	ls_Setting

n_cst_Settings	lnv_Settings
datastore 	lds_Ship, &
				lds_Item
				
n_cst_Sql	lnv_Sql
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
w_Search		lw_Search
n_cst_LicenseManager	lnv_LicenseMgr
n_cst_EquipmentManager 	lnv_Equip
n_cst_beo_Shipment		lnv_Shipment

lnv_Shipment = anv_Shipment	

string	ls_Temp
ls_Temp = String ( now ( ) )

//ls_Value = String ( this.object.ds_ref1_text[1] )
ls_Value = lnv_Shipment.of_GetRef1Text ( )  

IF isnull (ls_Value) or len ( trim ( ls_Value ) ) = 0 THEN
	li_Return = -1
END IF
	
//system_setting for Validate Primary Reference #
IF lnv_Settings.of_GetSetting ( 70 , la_Setting ) <> 1 THEN
	
ELSE
	ls_Setting = string ( la_Setting ) 
	
	CHOOSE CASE ls_Setting
			
		CASE "YES!"			
			lb_ValidateRef=TRUE
							
		CASE "NO!"
			lb_ValidateRef=FALSE
			
	END CHOOSE
END IF

//If system seting for Validate against BL#/Ref# 
IF lnv_Settings.of_GetSetting ( 71 , la_Setting ) <> 1 THEN
ELSE
	ls_Setting = string ( la_Setting ) 
	
	CHOOSE CASE ls_Setting
			
		CASE "YES!"			
			lb_ValidateBL = TRUE
							
		CASE "NO!"
			lb_ValidateBl = FALSE
			
	END CHOOSE
END IF

//CHECK SETTING FOR OPEN / ALL
IF lnv_Settings.of_GetSetting ( 72 , la_Setting ) <> 1 THEN
	
ELSE
	ls_Setting = string ( la_Setting ) 
	
	CHOOSE CASE ls_Setting
			
		CASE "OPEN!", "ALL!"			
			ls_Status = ls_Setting
							
		CASE ELSE //DEFAULT
			ls_Status = "OPEN!"
			
	END CHOOSE
END IF
	
	

	
IF li_Return = 1 THEN
	
	IF lb_ValidateREf THEN
		//Get shipments with matching values
		lds_Ship = CREATE DataStore
		lds_Ship.dataobject = "d_shipmentlist"
		lds_Ship.SetTransObject ( SQLCA )
		ls_OriginalSelect = lds_Ship.Describe("DataWindow.Table.Select")


 		ls_SQL = " where disp_ship.ds_ref1_text = ~~'" + ls_Value + "~~'" 	

		// RDT 12-05-02 - start 
		
	//	ls_SQL = "where disp_ship.ds_ref1_text = ~~'" + ls_Value + "~~' "
	//	ls_SQL = ls_sql + "OR ( disp_ship.ds_ref2_type in ( "+ ls_RefTypes +" ) and disp_ship.ds_ref2_text = ~~'" + ls_Value + "~~' )" 
	//	ls_SQL = ls_sql + "OR ( disp_ship.ds_ref3_type in ( "+ ls_RefTypes +" ) and disp_ship.ds_ref3_text = ~~'" + ls_Value + "~~' )" 
		// RDT 12-05-02 - end

		IF ls_Status = "OPEN!" THEN
			ls_SQL += " and disp_ship.ds_status <> ~~'" + gc_dispatch.cs_ShipmentStatus_Billed + "~~'" 
		END IF
		ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_sql + "'"
		lds_Ship.Modify(ls_ModString)
		ll_RowCount = lds_Ship.Retrieve()
		commit;		//<<*>>
		FOR ll_Ndx = 1 to ll_RowCount
			ll_ArrayCount ++
			lla_Ids[ll_ArrayCount] = lds_Ship.object.ds_id[ll_Ndx]
		NEXT
	END IF
	
	IF lb_ValidateBl THEN
		//get items with matching values
		lds_Item = CREATE DataStore
		lds_Item.dataobject = "d_itemselection"
		lds_Item.SetTransObject ( SQLCA )
		ls_OriginalSelect = lds_Item.Describe("DataWindow.Table.Select")
		ls_SQL = " AND disp_items.di_blnum = ~~'" + ls_Value + "~~'"  
		IF ls_Status = "OPEN!" THEN
			ls_SQL += " and disp_ship.ds_status <> ~~'" + gc_dispatch.cs_ShipmentStatus_Billed + "~~'" 
		END IF
		ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_sql + "'"
		lds_Item.Modify(ls_ModString)
		ll_RowCount = lds_Item.Retrieve()
		Commit;
		FOR ll_Ndx = 1 to ll_RowCount
			ll_ArrayCount ++
			lla_Ids[ll_ArrayCount] = lds_Item.object.di_shipment_id[ll_Ndx]
		NEXT
	END IF
	
	//if any returned then ask to display search list
	IF upperbound ( lla_Ids ) > 0 THEN
	
		IF MessageBox ( "Primary Reference Cross Check", "This number has been used in other shipments. "+&
			"Do you want to display a search list of the shipments ?", &
			Information!, YesNo!, 1 ) = 1 THEN
	
			ls_WhereClause = " WHERE ds_id " + lnv_Sql.of_MakeInClause ( lla_Ids )
			IF ls_Status = "OPEN!" THEN
				ls_SQL += " and ds_status <> ~~'" + gc_dispatch.cs_ShipmentStatus_Billed + "~~'" 
			END IF
			lstr_Parm.is_Label = "ShipmentWhereClause"
			lstr_Parm.ia_Value = ls_WhereClause
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			OpenSheetWithParm ( lw_Search, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
			
		END IF
		
	END IF


	IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) = TRUE OR &
		lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) = TRUE THEN
		IF lnv_Shipment.of_IsNonRouted ( ) = FALSE THEN
			li_RefType = lnv_Shipment.of_GetRef1Type ( ) //.object.ds_ref1_Type[1] 
			IF ( li_RefType = 20 OR li_RefType = 26 OR li_RefType = 28 ) AND Len ( Trim ( ls_Value ) ) > 0 THEN // container #
				DataStore	lds_Find
				S_eq_Info	lstr_equip
				
				
				IF li_RefType = 20 THEN
					ls_Type = 'C'
				ELSEIF li_RefType = 26  THEN
					ls_Type = 'B'
				ELSE 
					ls_Type = 'H'
				END IF
				
				ls_Find = "WHERE eq_ref = '" + ls_Value + "' AND eq_type = '" + ls_Type + "'"
				lnv_Equip.of_Retrieve( lds_Find , ls_Find)
				
				CHOOSE CASE lds_Find.RowCount ( )
						
					CASE 0 // Equip DNE
						IF MessageBox ( "Outside Equipment", "The equipment you have specified does not exist.  "+&
						"Do you want to create new Leased Equipment with that number?", Question!, YesNo!, 1 ) = 1 THEN
							lstr_Equip.eq_ref = ls_Value
							lstr_Equip.eq_type = '34'
							lstr_Equip.eq_id = 0
							
							lnv_Msg.of_Reset ( )
							lstr_Parm.is_label = "EQSTRUCT"
							lstr_Parm.ia_Value = lstr_Equip
							lnv_Msg.of_Add_Parm ( lstr_Parm )
							
							
							lstr_Parm.is_label = "SHIPMENT"
							lstr_Parm.ia_Value = lnv_Shipment.of_GetID ( )
							lnv_Msg.of_Add_Parm ( lstr_Parm )
							
							
							
							OpenWithParm ( w_eq_NewOut , lnv_Msg )
							lstr_Equip = message.PowerobjectParm
							IF lstr_Equip.eq_id > 0 THEN // equipment created
								lnv_Shipment.of_SetRef1Text ( lstr_Equip.eq_ref )
//								this.object.ds_ref1_text[1] = lstr_Equip.eq_ref  // if in the create window 
							END IF															// they change the ref then
//							THIS.SetRedraw ( TRUE ) //force refresh			  // we want to show it here
																					
						END IF
						
					CASE 1 // THE Equip exists
						THIS.of_ExistingEquipmentEntered ( lds_Find.object.eq_id [ 1 ] , lnv_Shipment.of_GetID ( ) )
						//MessageBox("Specified Equipment" , "The equipment specifed has previously been created." , INFORMATION! )
						
					CASE IS > 1 // multiples exist
						MessageBox("Specified Equipment" , "More than one piece of equipment already exists with that reference number." , INFORMATION! )				
		
					CASE ELSE 
						// ERROR
				END CHOOSE
				
			END IF
		END IF
	END IF
	
END IF
 
//sync value 
choose case lnv_Shipment.of_GetRef1Type ( )
	case 15
		lnv_Shipment.of_SetMasterBl ( trim(ls_Value) )
		//this.object.masterbl[1] = trim(ls_Value)
	case 18
		lnv_Shipment.of_SetBookingNumber( trim(ls_Value) )
	//	this.object.booking[1] = trim(ls_Value)
	case 21
		lnv_Shipment.of_SetSeal ( trim(ls_Value) )
	//	this.object.seal[1] = trim(ls_Value)
	case 22
		lnv_Shipment.of_SetForwarderRef ( trim(ls_Value) )
	//	this.object.forwarderref[1] = trim(ls_Value)
end choose
//
IF IsValid ( lds_Find ) THEN
	DESTROY lds_Find
END IF

IF IsValid ( lds_Item ) THEN
	DESTROY lds_Item
END IF

IF IsValid ( lds_Ship ) THEN
	DESTROY lds_Ship
END IF


ls_Temp += " " + String  ( now () )

//MessageBox ( "Time" , ls_Temp )

RETURN li_Return

end function

public function integer of_removefrontchassissplit (n_cst_beo_shipment anv_shipment, n_cst_bso_dispatch anv_dispatch);// need to change the hook mount to a hook and swap sites
// and remove the front chassis split item
Long	i
long	ll_ItemCount
Int	li_Return = 1
n_cst_beo_Event	lnv_Event 
n_cst_beo_Item		lnva_Items[]
n_cst_anyarraysrv	lnv_ArraySrv
lnv_Event = CREATE n_cst_beo_Event

PowerObject lpo_EventCache

lpo_EventCache = anv_Dispatch.of_GetEventCache ( )
//remove the first event ( hook ) 
lnv_Event.of_SetSource ( lpo_EventCache )
lnv_Event.of_SetSourceRow ( 1 ) 


IF lnv_Event.of_hasSource ( ) THEN
	IF anv_Shipment.of_RemoveEvents ( {lnv_Event.of_GetID ( )}, anv_dispatch   ) <> 1 THEN
		li_Return = -1
	ELSE
		anv_Shipment.of_RemoveDeletedEventSite ( {lnv_Event.of_GetSite( )} )
	END IF	
END IF

IF li_Return = 1 THEN
// change the mount to a hook
	lnv_Event.of_SetSourceRow ( 1 ) 
	anv_dispatch.of_MountToHook ( lnv_Event.of_GetID ( ) )
END IF

IF li_Return = 1 THEN
	ll_ItemCount = anv_Shipment.of_GetItemsForEventType ( n_cst_constants.cs_itemeventtype_frontchassissplit  , lnva_Items ) 
	FOR i = 1 TO ll_ItemCount 
		anv_Shipment.of_RemoveItem ( lnva_Items[i].of_GetID ( ) , anv_dispatch ) 
	NEXT 
	
END IF



lnv_ArraySrv.of_Destroy( lnva_items )
DESTROY ( lnv_Event ) 

RETURN li_Return
end function

public function integer of_removebackchassissplit (n_cst_beo_shipment anv_shipment, n_cst_bso_dispatch anv_dispatch);// need to change the dismount drop to a drop 
// and remove the back chassis split item
Long	i
long	ll_ItemCount
Int	li_Return = 1
n_cst_beo_Event	lnv_Event 
n_cst_beo_Item		lnva_Items[]
n_cst_anyarraysrv	lnv_ArraySrv
n_cst_dws			lnv_dws
lnv_Event = CREATE n_cst_beo_Event

PowerObject lpo_EventCache

lpo_EventCache = anv_Dispatch.of_GetEventCache ( )
//remove the last event ( drop ) 
lnv_Event.of_SetSource ( lpo_EventCache )
lnv_Event.of_SetSourceRow ( lnv_dws.of_RowCount ( lpo_EventCache ) ) 


IF lnv_Event.of_hasSource ( ) THEN
	IF anv_Shipment.of_RemoveEvents ( {lnv_Event.of_GetID ( )}, anv_dispatch   ) <> 1 THEN
		li_Return = -1
	ELSE
		anv_Shipment.of_RemoveDeletedEventSite ( {lnv_Event.of_GetSite( )} )
	END IF	
END IF

IF li_Return = 1 THEN
// change the dismount to a drop
	lnv_Event.of_SetSourceRow ( lnv_dws.of_RowCount ( lpo_EventCache ) ) 
	anv_dispatch.of_DismountToDrop ( lnv_Event.of_GetID ( ) )
END IF

IF li_Return = 1 THEN
	ll_ItemCount = anv_Shipment.of_GetItemsForEventType ( n_cst_constants.cs_itemeventtype_Backchassissplit  , lnva_Items ) 
	FOR i = 1 TO ll_ItemCount 
		anv_Shipment.of_RemoveItem ( lnva_Items[i].of_GetID ( ) , anv_dispatch ) 
	NEXT 	
END IF

lnv_ArraySrv.of_Destroy( lnva_items )
DESTROY ( lnv_Event ) 

RETURN li_Return
end function

public function string of_getcompanyroleinshipment (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company);Long		ll_BillTO
Long		ll_Forwarder
Long		ll_Agent
Long		lla_Event[]
Long		ll_EventCount
Long		ll_i
Long		ll_CoID
Int		li_Null
String	ls_ReturnRole

Int	li_Return = 1
n_cst_beo_Event		lnva_EventList[]
n_cst_beo_Company		lnv_Company
n_cst_beo_Shipment	lnv_Shipment
n_cst_AnyArraySrv		lnv_ArraySrv

SetNull ( li_Null )

IF li_Return = 1 THEN	
	IF IsValid ( anv_Shipment ) THEN
		lnv_Shipment = anv_Shipment
	ELSE
		li_Return = -1
	END IF
END IF
	
IF li_Return = 1 THEN	
	IF IsValid ( anv_Company ) THEN
		lnv_Company = anv_Company
	ELSE
		li_Return = -1
	END IF
END IF
	
IF li_Return = 1 THEN 
	ll_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList ) 
	FOR ll_i = 1 TO ll_EventCount
		lla_Event[ ll_i ] = lnva_EventList[ ll_i ].of_GetSite( )
	NEXT
	
	lnv_ArraySrv.of_GetShrinked ( lla_Event , TRUE , TRUE ) 
	lnv_ArraySrv.of_Destroy ( lnva_EventList )
		
END IF
	
IF li_Return = 1 THEN
	ll_BillTo = lnv_Shipment.of_GetBillTo ( )
	ll_Forwarder = lnv_Shipment.of_GetForwarder ( )
	ll_Agent = lnv_Shipment.of_GetAgent ( )
END IF

IF li_Return = 1 THEN
	ll_CoID = lnv_Company.of_GetID ( )
	IF ll_CoID > 0 THEN
	ELSE 
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	// billto
	IF ll_CoID = ll_BillTo THEN
		IF Len ( ls_ReturnRole ) > 0 THEN
			ls_ReturnRole += ", "
		END IF
		ls_ReturnRole += n_cst_Companies.cs_CompanyRole_BillTo 
	END IF
	
	// Agent
	IF ll_CoID = ll_Agent THEN
		IF Len ( ls_ReturnRole ) > 0 THEN
			ls_ReturnRole += ", "
		END IF
		ls_ReturnRole += n_cst_Companies.cs_CompanyRole_Agent
	END IF
	
	// Forwarder
	IF ll_CoID = ll_Forwarder THEN
		IF Len ( ls_ReturnRole ) > 0 THEN
			ls_ReturnRole += ", "
		END IF
		ls_ReturnRole += n_cst_Companies.cs_CompanyRole_Forwarder
	END IF
	
	//Event
	IF lnv_ArraySrv.of_Find ( lla_Event , ll_CoID , li_Null , li_Null ) > 0 THEN
		IF Len ( ls_ReturnRole ) > 0 THEN
			ls_ReturnRole += ", "
		END IF
		ls_ReturnRole += n_cst_Companies.cs_CompanyRole_EventSite
	END IF
	
	IF Len ( ls_ReturnRole ) = 0 THEN
		ls_ReturnRole = n_cst_Companies.cs_CompanyRole_None
	END IF
	
END IF


RETURN ls_ReturnRole







end function

public function integer of_setintermodalorigindest (ref n_cst_beo_shipment anv_shipment);/* This method should be called to intitialize the origin and destination of a new intermodal shipment. It is not capable of
determining the origin and destination of a shipment with yard moves and other non-native events in the list.*/
Boolean		lb_Continue = TRUE
Long			ll_OriginalOrigin
Long			ll_OriginalDest
Long			ll_Origin
Long			ll_Dest
Int			li_EventCount
Int			i
Int			li_Return = 1
String		ls_Direction 

n_cst_Beo_Event	lnva_Events[]
n_Cst_AnyArraySrv	lnv_ArraySrv
n_cst_Events	lnv_Events
DataStore	lds_EventSource
n_cst_beo_Event	lnv_Event


lnv_Event	= CREATE n_cst_beo_Event

lb_COntinue = IsValid ( anv_shipment )

IF lb_Continue THEN
	lds_EventSource = anv_Shipment.of_GetEventSource ( )
	lb_Continue = IsValid ( lds_EventSource )
END IF

IF lb_Continue THEN
	ls_Direction = anv_Shipment.of_GetMoveCode ( )
	ll_OriginalOrigin = anv_Shipment.of_GetOrigin ( ) 
	ll_OriginalDest = anv_Shipment.of_Getdestination ( )
END IF


IF lb_Continue THEN
	CHOOSE CASE ls_Direction 
		CASE "I" // import
				
			ll_Origin = lnv_events.of_getTrailerpulocation ( lds_EventSource )				
			ll_Dest = anv_Shipment.of_getfirstdelid ( )
			IF ll_Dest > 0 THEN
				lnv_Event.of_SetSource ( lds_EventSource ) 
				lnv_Event.of_SetSourceID ( ll_Dest )
				ll_Dest = lnv_Event.of_GetSite ( )
			END IF
				
		CASE "E" // EXPORT 
						
			li_EventCount = anv_Shipment.of_GetEventList ( lnva_Events )
			FOR i = li_EventCount TO 1 STEP -1
				IF lnva_Events[i].of_IsPickupGroup ( ) THEN
					ll_Origin = lnva_Events[i].of_GetSite ( )
					EXIT
				END IF
			NEXT 
			lnv_ArraySrv.of_Destroy ( lnva_Events )
			ll_Dest = lnv_events.of_getTrailerRtnlocation ( lds_EventSource )								
						
			
		CASE "O" // one way
			
			ll_Origin = anv_Shipment.of_getfirstPuID ( )
			IF ll_Origin > 0 THEN
				lnv_Event.of_SetSource ( lds_EventSource ) 
				lnv_Event.of_SetSourceID ( ll_Origin )
				ll_Origin = lnv_Event.of_GetSite ( )
			END IF
			
			ll_Dest = anv_Shipment.of_getfirstdelid ( )
			IF ll_Dest > 0 THEN
				lnv_Event.of_SetSource ( lds_EventSource ) 
				lnv_Event.of_SetSourceID ( ll_Dest )
				ll_Dest = lnv_Event.of_GetSite ( )
			END IF
		
	END CHOOSE
	
END IF

IF lb_Continue THEN
	IF ISNull ( ll_OriginalOrigin ) OR ll_Origin <> ll_OriginalOrigin THEN
		anv_Shipment.of_setorigin ( ll_Origin )
	END IF
	IF ISNull ( ll_OriginalDest ) OR ll_Dest <> ll_OriginalDest THEN
		anv_Shipment.of_SetFinalDestination ( ll_Dest )
	END IF
	li_Return = 1
END IF

Destroy ( lnv_Event )

RETURN li_Return

end function

private function integer of_initializenewintermodal (long al_shipmentid);Int	li_Return = 1
Int	li_Count
Int	i
Int	li_null

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Item			lnva_ItemList[]

lnv_Shipment = Create	n_cst_beo_Shipment
lnv_Dispatch = CREATE n_Cst_bso_Dispatch

SetNull ( li_Null  )

lnv_Dispatch.of_RetrieveShipment ( al_ShipmentID )
lnv_Dispatch.of_FilterShipment ( al_ShipmentID )

lnv_SHipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache () )
lnv_Shipment.of_SetSourceID ( al_ShipmentID ) 
lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache () )
lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache () )

li_Count = lnv_Shipment.of_GetItemList ( lnva_ItemList ) 
FOR i = 1 TO li_Count
	lnva_ItemList[i].of_SetPuEvent ( li_Null )
	lnva_ItemList[i].of_SetDelEvent ( li_Null )	
	DESTROY ( lnva_ItemList[i] )	
NEXT


THIS.of_SetIntermodalOriginDest ( lnv_Shipment ) 
//lnv_Shipment.of_SetPreNoteDate ( ld_Today )
//lnv_Shipment.of_SetPreNoteTime ( lt_Now )
lnv_Shipment.of_setPreNoteUser ( gnv_App.of_GetUserId ( ) )

IF lnv_Dispatch.Event pt_Save ( ) <> 1 THEN
	li_Return = -1
END IF

DESTROY ( lnv_Shipment )
DESTROY ( lnv_Dispatch ) 

RETURN li_Return
end function

private function integer of_createintermodalevents (n_cst_msg anv_msg, ref datastore ads_target);String	ls_Direction 
Long	ll_Pier
Long	ll_FreightLoc
Long	ll_Row
Boolean	lb_PU
Boolean	lb_Del
S_Parm		lstr_Parm
DataStore	lds_Target

lds_Target = ads_Target

IF anv_msg.of_Get_Parm ( "DIRECTION" , lstr_Parm ) > 0 THEN
	ls_Direction  = lstr_Parm.ia_Value
END IF

IF anv_msg.of_Get_Parm ( "PIER" , lstr_Parm ) > 0 THEN
	ll_PIER  = Long ( lstr_Parm.ia_Value )
END IF

IF anv_msg.of_Get_Parm ( "FREIGHTLOC" , lstr_Parm ) > 0 THEN
	ll_FreightLoc  = Long ( lstr_Parm.ia_Value )
END IF

IF anv_msg.of_Get_Parm ( "DROP" , lstr_Parm ) > 0 THEN
	ll_PIER  = Long ( lstr_Parm.ia_Value )
END IF

IF anv_msg.of_Get_Parm ( "HOOK" , lstr_Parm ) > 0 THEN
	ll_FreightLoc  = Long ( lstr_Parm.ia_Value )
END IF

IF anv_msg.of_Get_Parm ( "PICKUP" , lstr_Parm ) > 0 THEN
	lb_PU = lstr_Parm.ia_Value
END IF

IF anv_msg.of_Get_Parm ( "DELIVER" , lstr_Parm ) > 0 THEN
	lb_Del  = lstr_Parm.ia_Value
END IF


CHOOSE CASE ls_Direction 
		
	CASE "ONEWAY" 
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "H"
		lds_Target.Object.de_Site [ ll_Row ] = ll_FreightLoc
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "R"
		lds_Target.Object.de_Site [ ll_Row ] = ll_Pier
		
	CASE "IMPORT" , "EXPORT"
		
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "H"
		lds_Target.Object.de_Site [ ll_Row ] = ll_Pier
		
		IF lb_Del THEN
			ll_Row = lds_Target.InsertRow ( 0 )
			lds_Target.Object.de_Event_Type [ ll_Row ] = "D"
			lds_Target.Object.de_Site [ ll_Row ] = ll_FreightLoc	
		END IF
		
		IF lb_PU THEN
			ll_Row = lds_Target.InsertRow ( 0 )
			lds_Target.Object.de_Event_Type [ ll_Row ] = "P"
			lds_Target.Object.de_Site [ ll_Row ] = ll_FreightLoc
		END IF
		
		IF NOT lb_PU AND NOT lb_Del THEN
			
			ll_Row = lds_Target.InsertRow ( 0 )
			lds_Target.Object.de_Event_Type [ ll_Row ] = "R"
			lds_Target.Object.de_Site [ ll_Row ] = ll_FreightLoc
			
			ll_Row = lds_Target.InsertRow ( 0 )
			lds_Target.Object.de_Event_Type [ ll_Row ] = "H"
			lds_Target.Object.de_Site [ ll_Row ] = ll_FreightLoc
			
		END IF
		
		ll_Row = lds_Target.InsertRow ( 0 )
		lds_Target.Object.de_Event_Type [ ll_Row ] = "R"
		lds_Target.Object.de_Site [ ll_Row ] = ll_Pier
		
	
		
	CASE ELSE
		
END CHOOSE

RETURN 1
end function

private function integer of_setcustomtext (ref n_cst_beo_shipment anv_shipment, n_cst_edi_204_record anv_204);String	ls_Value
Int		li_I
Int		li_Return = 1

CONSTANT Int	ci_CustomCount = 10

FOR li_i = 1 TO ci_CustomCount
	ls_Value = anv_204.of_GetCustomText ( String (li_i) )
	IF Not IsNull ( ls_Value ) THEN
		IF anv_shipment.of_SetCustomText ( ls_Value , li_i ) <> 1 THEN
			li_Return = -1
		END IF
	END IF
NEXT

RETURN li_Return
end function

public function long of_getallcompanies (readonly n_cst_beo_shipment anv_shipment[], ref long ala_coid[]);/***************************************************************************************
NAME			: of_GetAllCompanies
ACCESS		: Public 
ARGUMENTS	: n_Cst_Beo_Shipment Array (anv_shipment[] )
			 	  Long Array					(Company ids)

RETURNS		: Integer		(Number of Companies)
DESCRIPTION	: Retrieves all companies associated with the shipments

REVISION		: RDT 
***************************************************************************************/

Long		ll_EventCount

Long		ll_i, &
			ll_ShipCount, &
			ll_ShipMax
			
Long		ll_CoID, &
			ll_BillTo, &
			ll_Forwarder, & 
			ll_Agent 
		
Int		li_Null

Int	li_Return = 1

n_cst_beo_Event		lnva_EventList[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_AnyArraySrv		lnv_ArraySrv

SetNull ( li_Null )
ll_ShipMax = UpperBound( anv_shipment[] )

For ll_ShipCount = 1 to ll_ShipMax
	
	IF li_Return = 1 THEN	
		IF IsValid ( anv_Shipment [ll_ShipCount] ) THEN
			lnv_Shipment = anv_Shipment[ll_ShipCount]
		ELSE
			li_Return = -1
		END IF
	END IF
		
	IF li_Return = 1 THEN 
		ll_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList ) 
		FOR ll_i = 1 TO ll_EventCount
			ala_coid [ ll_i ] = lnva_EventList[ ll_i ].of_GetSite( )
		NEXT
	END IF
		
	IF li_Return = 1 THEN
		ala_coid[ UpperBound( ala_coid) + 1 ] = lnv_Shipment.of_GetBillTo ( )
		ala_coid[ UpperBound( ala_coid) + 1 ] = lnv_Shipment.of_GetForwarder ( )
		ala_coid[ UpperBound( ala_coid) + 1 ] = lnv_Shipment.of_GetAgent ( )
	END IF

Next

lnv_ArraySrv.of_GetShrinked ( ala_coid, TRUE , TRUE ) 
lnv_ArraySrv.of_Destroy ( lnva_EventList )

li_Return = UpperBound( ala_coid ) 

RETURN li_Return 







end function

public function integer of_setorigindestination (n_cst_beo_shipment anv_shipment, long al_eventid, long al_originalsiteid, long al_newsiteid);//RDT 8-22-03 

Long		ll_Origin
Long		ll_Dest
Long		ll_OriginalSiteID
Long		ll_NewSiteID

Boolean	lb_PU
Boolean	lb_SetValue
Int		li_NewPosition
Int		li_OriginPosition
Int		li_DestPosition
Int		li_EventCount
Int		i

n_cst_beo_Event		lnva_OLDEvent[]
n_cst_beo_Event		lnva_NEWEvent[]

n_cst_AnyArraySrv		lnv_Array
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Event		lnv_Event
n_cst_beo_Event		lnva_EventList[]
n_cst_Settings			lnv_Settings

lnv_Event = CREATE n_Cst_beo_Event

lnv_Shipment = anv_Shipment

lnv_Event.of_SetSource ( lnv_Shipment.of_GetEventSource ( ) )
lnv_Event.of_SetSourceID ( al_EventID )	
lb_Pu = lnv_Event.of_IsPickupGroup ( )
li_NewPosition = lnv_Event.of_GetShipSeq ( ) // this is the position of the event being changed
						// we will use it to see if the event being changed is before(pu) it or after it(del)
ll_OriginalSiteID = al_OriginalSiteID
ll_NewSiteID = al_NewSiteID

IF isValid ( lnv_Shipment ) THEN
	
	CHOOSE CASE lb_PU
			
		CASE TRUE
			
			ll_Origin = lnv_Shipment.of_GetOrigin (  )
			
			IF IsNull ( ll_Origin ) THEN
				lb_SetValue = TRUE
			ELSEIF lnv_Shipment.of_IsIntermodal ( ) THEN
				lb_SetValue = ll_OriginalSiteID = ll_Origin  
			ELSEIF lnv_Settings.of_ProcessOrFin ( ) THEN
				IF ll_OriginalSiteID = ll_Origin THEN
					lb_SetValue = TRUE
				ELSE
					li_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList )

					FOR i = 1 TO li_EventCount
						IF lnva_EventList[i].of_isPickupGroup ( ) and lnva_EventList[i].of_GetSite ( ) = ll_Origin THEN
							li_OriginPosition = lnva_EventList[i].of_GetShipSeq ( ) 
							EXIT
						END IF
					NEXT
					lb_SetValue = li_NewPosition < li_OriginPosition 
				END IF
			END IF
					
			IF lb_SetValue THEN
				
				lnv_Shipment.of_SetOrigin ( ll_NewSiteID )
				lnv_Shipment.of_ResetEventContacts( )	//RDT 8-22-03 

				
			END IF

			
		CASE FALSE  // deliver event changed
			
			ll_Dest = lnv_Shipment.of_GetDestination (  )
			
			IF IsNull ( ll_Dest ) THEN
				lb_SetValue = TRUE
			ELSEIF lnv_Shipment.of_IsIntermodal ( ) THEN
				lb_SetValue = ll_OriginalSiteID = ll_Dest  
			ELSEIF lnv_Settings.of_ProcessOrFin ( ) THEN
				IF ll_OriginalSiteID = ll_Dest THEN
					lb_SetValue = TRUE
				ELSE
					li_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList )
					FOR i = 1 TO li_EventCount
						IF lnva_EventList[i].of_isDeliverGroup ( ) and lnva_EventList[i].of_GetSite ( ) = ll_Dest THEN
							li_DestPosition = lnva_EventList[i].of_GetShipSeq ( ) 

							EXIT
						END IF
					NEXT
					
					lb_SetValue = li_NewPosition > li_DestPosition 
				END IF
			END IF
					
			IF lb_SetValue THEN

				lnv_Shipment.of_SetFinalDestination ( ll_NewSiteID )
				lnv_Shipment.of_ResetEventContacts(  )	//RDT 8-22-03 

			END IF
			
			
	END CHOOSE

END IF

lnv_Array.of_Destroy ( lnva_EventList )
lnv_Array.of_Destroy ( lnva_OLDEvent)
lnv_Array.of_Destroy ( lnva_NewEvent)

DESTROY ( lnv_Event ) 

RETURN 1
end function

public function long of_crosscheckreffields (ref n_cst_beo_shipment anv_shipment, unsignedlong aul_sourcefields, unsignedlong aul_targetfields, boolean ab_openonly, ref long ala_shipmentids[]);String	ls_Source1Text
String	ls_Source2Text
String	ls_Source3Text

String	ls_Where

Boolean	lb_Source1
Boolean	lb_Source2
Boolean	lb_Source3

Boolean	lb_Target1
Boolean	lb_Target2
Boolean	lb_Target3
Long		lla_Ids[]
Long		ll_RowCount

n_cst_numerical	lnv_Numerical

DataStore	lds_Result
lds_Result = CREATE DataStore

lds_Result.DataObject = "d_refcrosscheckresult"
lds_Result.SetTransobject ( SQLCA )



lb_Source1 = lnv_Numerical.of_GetBit ( aul_SourceFields , 1 ) 
lb_Source2 = lnv_Numerical.of_GetBit ( aul_SourceFields , 2 ) 
lb_Source3 = lnv_Numerical.of_GetBit ( aul_SourceFields , 3 ) 

lb_Target1 = lnv_Numerical.of_GetBit ( aul_TargetFields , 1 ) 
lb_Target2 = lnv_Numerical.of_GetBit ( aul_TargetFields , 2 ) 
lb_Target3 = lnv_Numerical.of_GetBit ( aul_TargetFields , 3 ) 


IF isValid ( anv_Shipment ) THEN
	ls_Source1Text =  anv_Shipment.of_GetRef1Text ( )
	ls_Source2Text =  anv_Shipment.of_GetRef2Text ( )
	ls_Source3Text =  anv_Shipment.of_GetRef3Text ( )
END IF


// If the value is null we are not going to check it								
lb_Source1 =  ( NOT (  lb_Source1 AND isNull ( ls_Source1Text ) )) AND lb_Source1 
lb_Source2 =  ( NOT (  lb_Source2 AND isNull ( ls_Source2Text ) )) AND lb_Source2 
lb_Source3 =  ( NOT (  lb_Source3 AND isNull ( ls_Source3Text ) )) AND lb_Source3 
	
IF lb_Target1 THEN 
	IF lb_Source1 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref1_text = '" + ls_Source1Text  + "' "
	END IF
	//disp_ship.ds_ref2_text = ~~'" + ls_Value + "~~'
	IF lb_Source2 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref1_text = '" + ls_Source2Text + "' "
	END IF
	
	IF lb_Source3 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref1_text = '" + ls_Source3Text + "' "
	END IF
END IF




IF lb_Target2 THEN 
	IF lb_Source1 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref2_text = '" + ls_Source1Text + "' "
	END IF
	
	IF lb_Source2 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref2_text = '" + ls_Source2Text + "' "
	END IF
	
	IF lb_Source3 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref2_text = '" + ls_Source3Text + "' "
	END IF
END IF



IF lb_Target3 THEN 
	IF lb_Source1 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref3_text = '" + ls_Source1Text + "' "
	END IF
	
	IF lb_Source2 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref3_text = '" + ls_Source2Text + "' "
	END IF
	
	IF lb_Source3 THEN
		IF Len ( ls_Where ) > 0 THEN
			ls_Where += " OR "
		END IF
		ls_Where += "ds_ref3_text = '" + ls_Source3Text + "' "
	END IF
END IF

IF Len ( ls_Where ) > 0 THEN
	ls_Where = " Where (" + ls_Where + ") AND ds_id <> " + String ( anv_Shipment.of_GetID ( )  )
	IF ab_OpenOnly THEN
		ls_Where += " AND ds_Status = 'K' "
	END IF
	
	lds_Result.object.datawindow.Table.Select = "select ds_id from disp_ship" + ls_Where
	
	ll_RowCount = lds_Result.Retrieve ( )
	
	IF ll_RowCount = -1 THEN
		ROLLBACK;
	ELSE
		Commit;
	END IF
		
	IF ll_RowCount > 0 THEN 
		lla_Ids =  lds_Result.object.ds_id.Primary 
	END IF
END IF

ala_ShipmentIDs[] = lla_Ids

DESTROY ( lds_Result )

RETURN ll_RowCount






end function

public function integer of_existingequipmententered (long al_eqid, long al_shipmentid);boolean		lb_AllowChange
String		ls_Find
String		ls_Message
String		ls_EqRef
Long			ll_Shipment
Long			ll_RowCount

Int			li_Return = 1

DataStore	lds_Find

n_cst_settings	lnv_Settings
n_cst_EquipmentManager 	lnv_Equip

ls_Find = "WHERE eq_id = " + String ( al_EqID ) 
lnv_Equip.of_Retrieve( lds_Find , ls_Find)
ll_RowCount = lds_Find.RowCount ( )
IF ll_RowCount <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	lb_AllowChange = lnv_Settings.of_AllowShipmentChangeofLinkedEquipment ( )
	ll_Shipment = lds_Find.object.equipmentlease_shipment [ 1 ]
	ls_EqRef = lds_Find.object.eq_ref [ 1 ]
	
	IF IsNull ( ll_Shipment ) THEN // it is not linked
	

		IF MessageBox ( "Specified Equipment" , "A piece of equipment already exists " + & 
			+"with the reference number you specified. However the equipment is not currently" + &
			" associated to a shipment.~r~n~r~nDo you want to link it to this shipment", QUESTION! , YESNO! , 1 ) = 1 THEN
						
			// NEED TO DO AN UPDATE ON THE EQUIPMENT HERE
			IF lnv_Equip.of_AddEquipmentToShipment ( al_EqID , al_ShipmentID )  <> 1 THEN
				MessageBox ( "Linking Equipment" , "An error occurred while attempting to link the existing piece of equipment to this shipment." )
				li_Return = -1			
			END IF
			
		ELSE // stop the processing
			li_Return = -1
		END IF
				
	ELSE  // the equipment is linked
	
		IF lb_AllowChange THEN
		
			ls_Message = "The equipment specifed: " + ls_EqRef + " is currently linked to shipment " + String ( ll_Shipment ) + & 
															". Do you want to link it to shipment " + String ( al_ShipmentID ) + " instead?~r~nBe sure to calculate all needed charges for the original shipment before re-linking."
					
			CHOOSE CASE MessageBox ( "Specified Equipment" , ls_Message , Question! , YesNo! , 1) 
				CASE 1 // yes change the link
					IF lnv_Equip.of_AddEquipmentToShipment ( al_EqID , al_ShipmentID ) <> 1 THEN
						li_Return = -1
					END IF
					
				CASE ELSE
					// no, don't change the assignment
					
					
			END CHOOSE
		ELSE
			MessageBox("Specified Equipment" , "The equipment specified has previously been created." , INFORMATION! )
		END IF
		
	END IF
END IF

DESTROY  ( lds_Find )

RETURN li_Return
end function

public function string of_geteqtypeforreftype (integer ai_type);n_cst_EquipmentManager	lnv_EqMan

String	ls_Rtn

CHOOSE CASE ai_Type
		
	CASE 28
		ls_Rtn = lnv_EqMan.cs_CHAS
		//ls_Rtn = 'H'
		
	CASE 26
		ls_Rtn = lnv_EqMan.cs_RBOX
		//ls_Rtn = 'B'		
		
	CASE 20
		ls_Rtn = lnv_EqMan.cs_CNTN
		//ls_Rtn = 'C'
		
	CASE 23
		ls_Rtn = lnv_EqMan.cs_TRLR
		//ls_Rtn = 'V'
		
		
END CHOOSE

RETURN ls_Rtn

end function

public function integer of_checkequipmentbysmartsearch (string as_ref, string as_type, long ala_IgnoreShipments[], ref long ala_shipments[]);String	ls_Ref
String	ls_Type
String	ls_Status
Long		lla_ShipmentIds []
Long		lla_EqIds [] 
Long		ll_Count
Long		i
Long		ll_ShipmentCount


n_Cst_AnyArraySrv	lnv_Array
DataStore	lds_Shipments
n_cst_equipmentmanager	lnv_EqManager

lds_Shipments = CREATE DataStore
lds_Shipments.DataObject = "d_EquipmentShipment"
lds_Shipments.SetTransObject ( SQLCA )


ls_Ref = as_Ref
ls_Type = as_Type
ls_Status = 'K'


lnv_EqManager.of_smartsearch ( ls_Ref , ls_Type, ls_Status , lla_EqIds )

IF UpperBound ( lla_EqIds ) > 0 THEN
	ll_Count = lds_Shipments.Retrieve ( lla_EqIds )
	FOR i = 1 TO ll_Count
		ll_ShipmentCount ++
		lla_ShipmentIds[ll_ShipmentCount] = lds_Shipments.object.outside_equip_shipment[i]
		
		ll_ShipmentCount ++
		lla_ShipmentIds[ll_ShipmentCount] = lds_Shipments.object.outside_equip_reloadshipment[i]
	NEXT
	
	
END IF

lnv_Array.of_removelong ( lla_ShipmentIds, ala_IgnoreShipments, FALSE )
lnv_Array.of_getShrinked ( lla_ShipmentIds , TRUE , TRUE ) 

Destroy lds_Shipments
ala_Shipments[]  = lla_ShipmentIds

RETURN UpperBound ( lla_ShipmentIds )
end function

public function integer of_initializecontacts (long al_shipmentid);// RDT 6-09-03 New method
Int	li_Return = 1

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = Create	n_cst_beo_Shipment
lnv_Dispatch = CREATE n_Cst_bso_Dispatch


lnv_Dispatch.of_RetrieveShipment ( al_ShipmentID )
lnv_Dispatch.of_FilterShipment ( al_ShipmentID ) 

lnv_SHipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache () )
lnv_Shipment.of_SetSourceID ( al_ShipmentID ) 
lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache () )
lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache () )

lnv_Shipment.of_CleanContactlist()

IF lnv_Dispatch.Event pt_Save ( ) <> 1 THEN
	li_Return = -1
END IF

DESTROY ( lnv_Shipment )
DESTROY ( lnv_Dispatch ) 

RETURN li_Return
end function

public function integer of_reftypechanged (integer ai_whichone, n_cst_beo_shipment anv_shipment);Int		li_Return = 1
Int		li_Type
Int		li_EqCount
Int		li_EqIndex
String	ls_RefText
String	ls_NewValue
String	ls_EqType

n_Cst_AnyArraySrv			lnv_Array
n_cst_equipmentmanager	lnv_EqMan
n_Cst_beo_Equipment2		lnva_Equipment[]


IF li_Return = 1 THEN
	IF NOT isValid ( anv_Shipment ) THEN
		li_Return = -1
	END IF
END IF



IF li_Return = 1 THEN
	CHOOSE CASE ai_WhichOne			
		CASE 1
			li_Type = anv_Shipment.of_GetRef1Type ( )
			ls_RefText = anv_Shipment.of_GetRef1Text ( )
		CASE 2
			li_Type = anv_Shipment.of_GetRef2Type ( )
			ls_RefText = anv_Shipment.of_GetRef2Text ( )
		CASE 3
			li_Type = anv_Shipment.of_GetRef3Type ( )
			ls_RefText = anv_Shipment.of_GetRef3Text ( )
		CASE ELSE
			li_Return = -1
	END CHOOSE
END IF

IF NOT ( IsNull ( ls_RefText ) OR Len ( Trim ( ls_RefText ) ) = 0  ) THEN
	li_Return = 0
END IF


IF li_Return = 1 THEN
	CHOOSE CASE li_Type 
					
		CASE 20/*container*/,23/*trailer*/,26/*Rail Box*/,28/*chassis*/
			CHOOSE CASE	li_Type
				CASE 20/*container*/				
					ls_EqType = lnv_EqMan.cs_cntn
				CASE 23/*trailer*/
					ls_EqType = lnv_EqMan.cs_trlr
				CASE 26/*Rail Box*/
					ls_EqType = lnv_EqMan.cs_rbox
				CASE 28/*chassis*/
					ls_EqType = lnv_EqMan.cs_chas
			END CHOOSE
			
			// do equipment thing
			THIS.of_Lookforequipment( anv_shipment , ls_NewValue, ls_EqType)
			IF Len ( ls_NewValue ) = 0 THEN
				li_Return = 0
			END IF
//			anv_Shipment.of_getEquipmentList ( lnva_Equipment )
//			li_EqCount = UpperBound ( lnva_Equipment )
//			FOR li_EqIndex = 1 TO li_EqCount
//				IF lnva_Equipment[li_EqIndex].of_GetType ( ) = ls_EqType THEN
//					ls_NewValue =  lnva_Equipment[li_EqIndex].of_GetNumber ( )
//					EXIT
//				END IF
//			NEXT
//			lnv_Array.of_Destroy ( lnva_Equipment )		
										
		CASE 21/*seal*/ 
			ls_NewValue = anv_Shipment.of_GetSeal ( ) 
		CASE 24/*PU #*/
			ls_NewValue = anv_Shipment.of_GetPickUpNumber ( ) 
		CASE 18/*Booking*/ 
			ls_NewValue = anv_Shipment.of_GetBooking ( ) 
		CASE 15/*master bl*/ 
			ls_NewValue = anv_Shipment.of_getMasterBl ( )
		CASE 22/*fwdr Ref*/ 
			ls_NewValue = anv_Shipment.of_getforwarderref ( )
			
		CASE ELSE
			li_Return = 0
			// can't do anything
	END CHOOSE
	
END IF

IF li_Return = 1 THEN

	CHOOSE CASE ai_WhichOne			
		CASE 1
			IF anv_Shipment.of_SetRef1Text ( ls_NewValue )  <> 1 THEN
				li_Return = -1
			END IF
		CASE 2
			IF anv_Shipment.of_SetRef2Text ( ls_NewValue )  <> 1 THEN
				li_Return = -1
			END IF 
		CASE 3
			IF anv_Shipment.of_SetRef3Text ( ls_NewValue )  <> 1 THEN
				li_Return = -1
			END IF
	END CHOOSE		

END IF



RETURN li_Return

end function

public function integer of_autoroute (long al_shipmentid);//Forward this request to the fully overloaded version.  Pass null values for ItinType, ItinId, and ItinDate, 
//which will cause the other function to prompt for them.

Integer	li_ItinType
Long		ll_ItinId
Date		ld_ItinDate

SetNull ( li_ItinType )
SetNull ( ll_ItinId )
SetNull ( ld_ItinDate )

RETURN This.of_AutoRoute ( li_ItinType, ll_ItinId, ld_ItinDate, al_ShipmentId )
end function

public function integer of_autoroute (long ala_eventids[]);//#2
// Args: ala_EventIds[]

// Determine target Itin.

// Get dispatch from Event Ids and call of_AutoRate(ala_Events, dispatch, ab_save) 
//MessageBox("RICH of_AutoRoute( ala_EventIds[] )","#2 Start")
Integer	li_Return = 1

Long		ll_EquipmentId 

n_cst_LicenseManager lnv_LicenseManager
n_cst_beo_Event lnv_Event

IF this.of_AutoRouteLicenseCheck( ) Then 
	// ok
Else
	li_Return = -1
End if

If li_Return = 1 Then 
		// setup dispatch 
	n_cst_bso_Dispatch 	lnv_Dispatch 
	lnv_Dispatch = Create n_cst_bso_Dispatch 
	lnv_Dispatch.of_RetrieveEvents ( ala_Eventids[] )
	
	li_Return = This.of_AutoRoute(ala_eventids[], lnv_Dispatch, TRUE /*ab_save*/ )
	
	Destroy ( lnv_Dispatch) 
End If

Return li_Return 
end function

public function boolean of_autoroutelicensecheck ();// RDT 8-13-03

Boolean 	lb_Return = TRUE 
String	ls_Messagetext
n_Cst_Privileges			lnv_Privs
n_cst_LicenseManager		lnv_LicenseManager

// check dispatch 
IF lnv_LicenseManager.of_GetLicensed ( n_cst_constants.cs_module_dispatch) OR &
	lnv_LicenseManager.of_GetLicensed ( n_cst_constants.cs_module_Brokerage ) Then 
	// added the check for brokerage for issue 2305
	// continue
Else
	lb_Return = False 
	ls_Messagetext = "~nNot Licensed for Dispatch/Brokerage."
End if

IF lb_Return THEN
	IF NOT lnv_Privs.of_HasEntryrights( ) THEN
		
		ls_Messagetext = "You do not have sufficient rights to perform this function."
		lb_Return = FALSE
		
	END IF
	
END IF

If NOT lb_Return Then 
	ls_Messagetext += "~nAuto Routing cannot be processed."
	MessageBox("Auto Route" , ls_Messagetext)
End If

Return lb_Return 
end function

public function integer of_autoroute (long ala_eventids[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save);//Forward this request to the fully overloaded version.  Pass null values for ItinType, ItinId, and ItinDate, 
//which will cause the other function to prompt for them.

Integer	li_ItinType
Long		ll_ItinId
Date		ld_ItinDate

SetNull ( li_ItinType )
SetNull ( ll_ItinId )
SetNull ( ld_ItinDate )

RETURN This.of_AutoRoute ( li_ItinType, ll_ItinId, ld_ItinDate, ala_EventIds, anv_Dispatch, ab_Save )
end function

public subroutine of_setroutetype (string as_RouteType);// 
is_RouteType = as_RouteType
end subroutine

public function string of_getroutetype ();Return is_RouteType
end function

public function integer of_autoroute (readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save);RETURN THIS.of_AutoRoute( al_shipmentid ,  anv_dispatch , ab_save , TRUE )

end function

public function integer of_autoroutegetevents (readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, ref long ala_eventids[]);RETURN THIS.of_AutoRouteGetEvents ( al_shipmentid , anv_dispatch , ala_eventids[] , TRUE ) 

end function

public function integer of_autoroutegetevents (readonly long al_shipmentid, n_cst_bso_dispatch anv_dispatch, ref long ala_eventids[], boolean ab_makeselection);integer 	li_Return, &
			li_null

Long 		ll_null

n_cst_msg	lnv_msg
s_Parm	lstr_parm

n_ds	lds_Events

n_cst_beo_Shipment lnv_Shipment
n_cst_alertmanager	lnv_AlertManager
lnv_AlertManager = CREATE n_cst_alertmanager

// get shipments from dispatch
		
	lnv_Shipment = CREATE n_cst_beo_Shipment
	anv_dispatch.of_RetrieveShipment(al_shipmentid) //Added by ZMC as per RZ for Auto Route Repos
	anv_dispatch.of_FilterShipment(al_shipmentid) 	//Added by ZMC as per RZ for Auto Route Repos
	lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache ( ) )
	lnv_Shipment.of_SetSourceID ( al_shipmentid )	
	lnv_Shipment.of_SetEventSource ( anv_Dispatch.of_GetEventCache ( ) )
	
	lnv_AlertManager.of_showalerts( {lnv_Shipment} )

	If anv_Dispatch.of_SetRef() = -1 then 
		MessageBox("Auto Route "," Program error anv_Dispatch.of_SetRef() Failed" )
	End if

	// ----- open window so user can select events ----- //

		lds_events = anv_Dispatch.of_geteventcache ( )
	lds_Events = lnv_Shipment.of_GetEventSource()
	
	lstr_Parm.is_Label = "EVENTDATASTORE"
	lstr_Parm.ia_Value = lds_events
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "MAKESELECTION"
	lstr_Parm.ia_Value = ab_makeSelection
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "DISPATCH"
	lstr_Parm.ia_Value = anv_Dispatch
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "SHIPMENT"
	lstr_Parm.ia_Value = lnv_Shipment
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	OpenWithParm( w_Event_Route, lnv_msg )
	
	lnv_msg.of_Reset()
	lnv_msg =  Message.PowerObjectParm
	
	If NOT IsValid( lnv_msg) Then 
		//  user must have close window with "X" or ALT+F4
		li_Return = -1
	Else
		
		// ----- Check results from window select events ----- //
		if lnv_msg.of_get_parm ( "EVENTS" , lstr_parm ) > 0 THEN
			ala_Eventids = lstr_Parm.ia_Value
		end if
		
		if lnv_msg.of_get_parm ( "ROUTETYPE" , lstr_parm ) > 0 THEN
			is_RouteType = lstr_Parm.ia_Value
		end if
	
		if lnv_msg.of_get_parm ( "NOEVENTS" , lstr_parm ) > 0 THEN
			// no events were selected so stop processing
			li_Return = -1
		end if
	End If
	
DESTROY ( lnv_Shipment ) 
DESTROY ( lnv_AlertManager )
	
Return li_Return 
end function

public function long of_addparentidstolist (unsignedlong ala_originalids[], ref unsignedlong ala_completelist[]);String		ls_Select
Long			ll_Count
Long			i
Long			ll_Return
uLong			lula_Working[]
DataStore	lds_Ids
n_cst_anyarraysrv	lnv_Array

lds_Ids = CREATE DataStore
lds_Ids.DataObject = 'd_parentshipmentlookup'
lds_Ids.SetTransObject(SQLCA)

ll_Count = lds_Ids.Retrieve ( ala_originalids[] )
IF ll_Count > 0 THEN
	FOR i = 1 TO ll_Count
		lula_Working[i] = lds_Ids.object.ds_Parentid [i]
	NEXT
END IF

lnv_Array.of_Appendlong( lula_Working[] , ala_OriginalIds[] )
lnv_Array.of_Getshrinked( lula_Working[] , TRUE, TRUE )

ala_completelist = lula_Working
ll_Return = UpperBound ( ala_completelist[] )

DESTROY ( lds_Ids )

RETURN ll_Return

end function

public function long of_addparentidstolist (long ala_originalids[], ref long ala_completelist[]);String		ls_Select
Long			ll_Count
Long			i
Long			ll_Return
Long			lla_Working[]
DataStore	lds_Ids
n_cst_anyarraysrv	lnv_Array

lds_Ids = CREATE DataStore
lds_Ids.DataObject = 'd_parentshipmentlookup'
lds_Ids.SetTransObject(SQLCA)

ll_Count = lds_Ids.Retrieve ( ala_OriginalIds[] )
IF ll_Count > 0 THEN
	FOR i = 1 TO ll_Count
		lla_Working[i] = lds_Ids.object.ds_Parentid [i]
	NEXT
END IF

lnv_Array.of_Appendlong( lla_Working[] , ala_OriginalIds[] )
lnv_Array.of_Getshrinked( lla_Working[] , TRUE, TRUE )

ala_completelist = lla_Working
ll_Return = UpperBound ( ala_completelist[] )

DESTROY ( lds_Ids )

RETURN ll_Return

end function

public function integer of_autoroute (readonly long ala_shipment[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist);// #1
// Args: ala_shipmentid[], anv_dispatch, ab_save,ab_promptforeventlist
// Rtrn: 1 = Success, 0 = User Cancelled, -1 = Failure
// This will get the target events to route.
// Get shipment from dispatch
// get events from shipment
//messagebox("RICH","#1 Args: al_shipmentid, anv_dispatch, ab_save")

Long		lla_shipmentId[],ll_RowCount
Long 		lla_eventids[]
Long 		lla_ResetArray[]

Int	li_Return = 1
Int	li_Ctr
Int 	li_Ctr1
Int 	li_EventCount 

lla_shipmentId = ala_shipment[]
ll_RowCount = UpperBound(lla_shipmentId)

IF ll_RowCount > 0 THEN
	IF NOT ab_promptforeventlist THEN
		n_cst_beo_Shipment lnv_Shipment
		lnv_Shipment = CREATE n_cst_beo_Shipment		
		n_Cst_beo_Event	lnva_EventList []
		n_Cst_beo_Event	lnva_ResetEventList[]
		
		FOR li_Ctr = 1 TO ll_RowCount
			anv_dispatch.of_RetrieveShipment(lla_shipmentId[li_Ctr])
			anv_dispatch.of_FilterShipment(lla_shipmentId[li_Ctr])
			lnv_Shipment.of_SetSource(anv_Dispatch.of_GetShipmentCache ())
			lnv_Shipment.of_SetSourceid(lla_shipmentId[li_Ctr])
			lnv_Shipment.of_SetEventSource(anv_Dispatch.of_GetEventCache ( ) )
			lnv_Shipment.of_SetItemSource ( anv_Dispatch.of_GetItemCache ( ) )
			lnv_Shipment.of_GetEventList(lnva_EventList [])
			li_EventCount  = UpperBound(lnva_EventList)
			
			FOR li_Ctr1 = 1 TO li_EventCount 
				lla_eventids[Upperbound(lla_eventids) + 1] = lnva_EventList[li_Ctr1].of_GetID ( )
				DESTROY (lnva_EventList[li_Ctr1])
			NEXT
			lnva_EventList = lnva_ResetEventList
		NEXT	
		DESTROY (lnv_Shipment)
		IF UPPERBOUND(lla_eventids) > 0 THEN
			li_Return = This.of_autoroute(lla_eventids,anv_dispatch,ab_save) 
		END IF
		lla_eventids = lla_ResetArray
		
	ElSE // if ab_promptforeventlist = TRUE THEN do as follows
		
		FOR li_Ctr = 1 TO ll_RowCount
			IF of_AutoRoute( lla_shipmentId[li_Ctr], anv_dispatch,ab_save,ab_promptforeventlist) <> 1 THEN
				li_Return = -1
				EXIT
			END IF
		NEXT
	END IF
ELSE
	MessageBox("Auto Route Repos","No Shipment ID(s) Selected")
END IF

Return li_Return
end function

public function integer of_autoroute (readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist);//Forward this request to the fully overloaded version.  Pass null values for ItinType, ItinId, and ItinDate, 
//which will cause the other function to prompt for them.

Integer	li_ItinType
Long		ll_ItinId
Date		ld_ItinDate

SetNull ( li_ItinType )
SetNull ( ll_ItinId )
SetNull ( ld_ItinDate )

RETURN This.of_AutoRoute ( li_ItinType, ll_ItinId, ld_ItinDate, al_ShipmentId, anv_Dispatch, &
	ab_Save, ab_PromptForEventList )
end function

public function integer of_openshipmentlistorder (long ala_shipmentid[]);w_ShipmentListOrder_routerepos lw_ShipmentListOrder 

s_parm lstr_parm
n_cst_msg lnv_msg

lstr_parm.is_label = "TARGET_IDS"
lstr_Parm.ia_Value = ala_shipmentid[]
lnv_msg.of_add_parm(lstr_parm)

Return OpenSheetWithParm(lw_ShipmentListOrder,lnv_msg,gnv_App.of_GetFrame(), 0, Original!)



end function

public function integer of_autorouterepos ();Int li_Return = 1
Long lla_ShipmentId[]
n_cst_privileges_events	lnv_Privs
IF lnv_Privs.of_AllowAlteritins( ) THEN
	Open (w_AutoReposEquipmentInput)
	
	s_parm lstr_parm
	n_cst_msg lnv_msg
	
	lnv_msg = Message.Powerobjectparm
	
	IF IsValid(lnv_msg) THEN
		IF lnv_msg.of_Get_parm ( "SHIPMENTID", lstr_Parm) <> 0 THEN
			lla_ShipmentId[] = lstr_Parm.ia_Value
		End If
		This.of_Openshipmentlistorder(lla_ShipmentId)
	ELSE
		li_Return = -1
	END IF
ELSE
	MessageBox ( "Route Repos" , "You are not authorized to make this change." )
	li_Return = -1
END IF

Return li_Return
end function

public function long of_addparentidstolist (unsignedlong al_startid, ref unsignedlong al_endid);String		ls_Select
Long			ll_Count
Long			i
Long			ll_Return
uLong			lula_Working[]
DataStore	lds_Ids
n_cst_anyarraysrv	lnv_Array

lds_Ids = CREATE DataStore
lds_Ids.DataObject = 'd_parentshipmentlookupid'
lds_Ids.SetTransObject(SQLCA)

ll_Count = lds_Ids.Retrieve (al_startid,al_endid)
IF ll_Count > 0 THEN
	FOR i = 1 TO ll_Count
		lula_Working[i] = lds_Ids.object.ds_Parentid [i]
	NEXT
END IF

//lnv_Array.of_Appendlong( lula_Working[] , ala_OriginalIds[])
lnv_Array.of_Getshrinked( lula_Working[] , TRUE, TRUE )

//ala_completelist = lula_Working
ll_Return = UpperBound ( lula_Working)

DESTROY ( lds_Ids )

RETURN ll_Return

end function

public function integer of_openitinerary (long al_eventid, integer ai_itintype);/*	
This method will open the itin for specified event. It only supports driver and 
Powerunit itineraries at this point

*/

Int		li_Return
Long		ll_TargetID
Date		ld_ItinDate
String	ls_Message

w_Dispatch	lw_Dispatch
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

li_Return = 1
ls_Message = "An error occurred while attempting to display the itinerary."

IF li_Return = 1 THEN
	IF IsNull ( al_eventid ) THEN
		ls_Message = "Could not display the itinerary requested.  The request must be for a specific stop or event."
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	IF IsNull ( ai_itintype ) THEN
		ls_Message = "Invalid itinerary specified."
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	
	CHOOSE CASE ai_itintype
			
		CASE gc_dispatch.ci_itintype_driver 
			
			SELECT "disp_events"."de_driver" ,  "disp_events"."de_arrdate"
    			INTO :ll_TargetID  , :ld_ItinDate
   			FROM "disp_events"  
  				WHERE "disp_events"."de_id" = :al_EventID ;
				  
			IF SQLCA.SQLCODE = -1 THEN
				RollBack;
				li_Return = -1
				// use default err msg
			ELSE 
				COMMIT;
			END IF
		
			
		CASE gc_dispatch.ci_itintype_powerunit
			 
			SELECT "disp_events"."de_tractor" , "disp_events"."de_arrdate"
    			INTO :ll_TargetID  , :ld_ItinDate
    			FROM "disp_events"  
   			WHERE "disp_events"."de_id" = :al_EventID;
					
			IF SQLCA.SQLCODE = -1 THEN
				RollBack;
				li_Return = -1
				// use default err msg
			ELSE 
				COMMIT;
			END IF
		

		CASE ELSE
			li_Return = -1
			ls_Message = "Profit Tools could not display the itinerary requested."
			
			
	END CHOOSE		
	
END IF

IF li_Return = 1 THEN
	IF IsNull ( ll_TargetID ) OR isNull ( ld_ItinDate ) THEN
		
		li_Return = -1
		

		IF IsNull ( ld_ItinDate ) THEN
			
			ls_Message = "Could not display the itinerary requested.  The event is not currently routed."
			
		ELSE			
		
			CHOOSE CASE ai_itintype
				
				CASE gc_dispatch.ci_itintype_driver 
					
					ls_Message = "Could not display the itinerary requested.  A driver is not currently assigned to the event."
					
				CASE gc_dispatch.ci_itintype_powerunit
					
					ls_Message = "Could not display the itinerary requested.  A power unit is not currently assigned to the event."
					
				CASE ELSE
				
					// use default err msg
					
			END CHOOSE
			
		END IF
		
	END IF
END IF

IF li_Return = 1 THEN
	lstr_Parm.is_Label = "CATEGORY"
	lstr_Parm.ia_Value = "ITIN"
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "TYPE"
	lstr_Parm.ia_Value = ai_itintype
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "ID"
	lstr_Parm.ia_Value = ll_TargetID
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "DATE"
	lstr_Parm.ia_Value = ld_ItinDate
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	
	OpenSheetWithParm ( lw_Dispatch, lnv_msg, gnv_app.of_GetFrame ( ), 0, Layered! )
END IF

IF li_Return <> 1 THEN
	IF len ( ls_Message ) > 0 THEN
		MessageBox ( "Itinerary Selection" , ls_Message )
	END IF
END IF

RETURN li_Return
end function

private function integer of_initializeshipment (long al_shipmentid);// zmc - 2-10-04
// Code here to set any partcular settings to columns on shipment window if 
// those columns have a property in system settings.
Int 		li_Return 
String 	ls_BillType
String 	ls_Value
String	ls_TodaysDate
String	ls_Message
Boolean	lb_save
Boolean	lb_continue

n_cst_ofrError lnv_Error



n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment

n_cst_setting_DefaultBillType lnv_BillType
lnv_BillType = CREATE n_cst_setting_DefaultBillType

n_cst_setting_DefaultShipmentDate lnv_ShipmentDate  
lnv_ShipmentDate = CREATE n_cst_setting_DefaultShipmentDate

lnv_Dispatch = CREATE n_Cst_bso_Dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_Dispatch.of_RetrieveShipment ( al_ShipmentID )
lnv_Dispatch.of_FilterShipment 	( al_ShipmentID )

lnv_Shipment.of_SetSource     ( lnv_Dispatch.of_GetShipmentCache () )
lnv_Shipment.of_SetSourceID   ( al_ShipmentID ) 
lnv_Shipment.of_SetEventSource( lnv_Dispatch.of_GetEventCache () )
lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache () )
lnv_Shipment.of_SetContext( lnv_Dispatch )

/*
//Get system setting for default Bill Type.
*/

lb_Continue = TRUE
ls_BillType = Trim(lnv_BillType.of_GetValue( ))
CHOOSE CASE ls_BillType
	CASE lnv_BillType.cs_unclassified
		ls_Value = "Z" 
	CASE lnv_BillType.cs_prepaid
		ls_Value = "P" 
	CASE lnv_BillType.cs_collect
		ls_Value = "C"			
	CASE lnv_BillType.cs_3rdparty
		ls_Value = "T"			
	CASE ELSE 
		lb_Continue = FALSE
END CHOOSE

IF lb_Continue THEN
	IF lnv_shipment.of_setPrepaidCollect(ls_Value) = 1 THEN
		lb_save = TRUE
	ELSE
		lb_Continue = FALSE		
	END IF	
END IF 

IF NOT lb_Continue THEN
	ls_Message += "~r~nFailed to initialize default bill type to system setting."
END IF


/*
		//Get system setting for setting today's date.
*/
lb_Continue = TRUE   // reset the continue flag for the next set of processing
ls_TodaysDate = Trim(lnv_ShipmentDate.of_GetValue( ))

IF IsNull(ls_TodaysDate) OR (Len(ls_TodaysDate) = 0) THEN
	lb_Continue = FALSE
END IF

IF lb_Continue THEN
	IF  Upper(ls_TodaysDate) = Upper(lnv_ShipmentDate.cs_yes) THEN
		IF lnv_shipment.of_SetShipDate(Today()) = 1 THEN
			lb_Save = TRUE
		ELSE
			lb_Continue = FALSE
		END IF
	END IF
END IF
	
IF NOT lb_Continue THEN
	ls_Message += "~r~nFailed to initialize shipment date."
END IF

// save if needed
IF lb_Save THEN
	IF lnv_Dispatch.Event pt_Save ( ) <> 1 THEN
		li_Return = -1
		ls_Message += "~r~nInitialization of shipment could not be saved."
	ELSE
		li_Return = 1
	END IF
END IF

IF Len ( ls_Message ) > 0 THEN
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage( ls_Message )
	li_Return = -1 
END IF

DESTROY ( lnv_Shipment )
DESTROY ( lnv_Dispatch ) 
DESTROY ( lnv_BillType )
DESTROY ( lnv_ShipmentDate)

Return li_Return
end function

public function string of_getfuelsurchargetype ();//Returns:   1 = Success (value returned by reference in ac_FuelSurcharge)
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

Integer	li_SqlCode
Integer	li_Return = 1
String	ls_SurchargeType

n_cst_setting_BillFuelSurchargeType	lnv_SurchargeType

lnv_SurchargeType = create n_cst_setting_BillFuelSurchargeType
if isvalid(lnv_SurchargeType) then
	ls_SurchargeType = upper(lnv_SurchargeType.of_GetValue())
else
	li_Return = -1
end if

IF li_Return = 1 THEN
	//have value
ELSE
	SetNull ( ls_SurchargeType )
END IF

destroy lnv_SurchargeType

RETURN ls_SurchargeType
end function

public function integer of_createshipmentsfordeliveryreceipt (ref n_cst_beo_shipment anv_sourceshipment, ref n_cst_beo_shipment anva_delrecshipments[]);//Int		li_ItemCount
Int		i
Int		li_PuIndex
Int		li_DelIndex
Int		li_EventCount
//Int		li_FilterCount
Long		lla_ItemIds[]
//String	lsa_Filters[]

n_cst_beo_Shipment	lnva_ReturnShipments[]

lnva_ReturnShipments = anva_delrecshipments[]

li_EventCount = anv_Sourceshipment.of_GetEventCount ( )

FOR li_PuIndex = 1 TO li_EventCount - 1
	FOR li_DelIndex = li_PuIndex + 1 TO li_EventCount	
		IF anv_Sourceshipment.of_getfreightitemsforpudelpair( li_PuIndex, li_DelIndex, lla_ItemIds) > 0 THEN
			lnva_ReturnShipments[UpperBound ( lnva_ReturnShipments) + 1 ] = CREATE n_Cst_beo_Shipment
			lnva_ReturnShipments[UpperBound ( lnva_ReturnShipments)].of_SetSource ( anv_sourceshipment.of_GetSource () )
			lnva_ReturnShipments[UpperBound ( lnva_ReturnShipments)].of_SetSourceID ( anv_sourceshipment.of_GetSourceID ()  )
			lnva_ReturnShipments[UpperBound ( lnva_ReturnShipments)].of_SetEventSource ( anv_sourceshipment.of_GetEventSource () )
			lnva_ReturnShipments[UpperBound ( lnva_ReturnShipments)].of_SetItemSource ( anv_sourceshipment.of_GetItemSource () )
			lnva_ReturnShipments[UpperBound ( lnva_ReturnShipments)].of_SetDeliveryMode(li_PuIndex, li_DelIndex )
			lnva_ReturnShipments[UpperBound ( lnva_ReturnShipments)].of_Setdelrecitems( lla_ItemIds )			
			
		//	MessageBox ( "Index" , String ( li_PuIndex )+ " - " + string ( li_DelIndex ))
		END IF
	NEXT
NEXT

anva_delrecshipments[] = lnva_ReturnShipments

//DESTROY ( lds_itemCopy )

RETURN UpperBound ( anva_delrecshipments[] )
end function

private function integer of_lookforequipment (n_cst_beo_shipment anv_shipment, ref string as_equipmentnumber, string as_eqtype);n_cst_bso	lnv_Context
n_cst_beo_Event	lnva_Events[]
n_cst_bso_Dispatch	lnv_Disp
n_cst_beo_equipment2 anva_equipment[]
Long	lla_Dummy[]
Long	lla_Keep[]
Int	i
String	ls_Ref
Long		ll_Find
int	li_Count
DataStore	lds_Cache

n_cst_beo_Equipment2	lnv_Eq
lnv_Context = anv_shipment.of_getContext()


If IsValid ( lnv_Context ) THEN
	lnv_Disp = lnv_Context
	
	li_Count = lnv_Disp.of_getequipmentforshipment( anv_shipment.of_GetID ( ) , anva_equipment )
	FOR i = 1 TO li_Count
		IF anva_equipment[i].of_GetType ( ) = as_eqtype THEN
			ls_Ref = anva_equipment[i].of_GetNumber()
			EXIT
		END IF
	NEXT
		
	IF Len (ls_Ref) = 0 THEN
		
		lds_Cache = lnv_Disp.of_GetEquipmentcache( )
		
		// we didn't find it attached to the shipment look at the events
		li_Count = anv_Shipment.of_GetEventList ( lnva_Events )
		CHOOSE CASE as_eqtype
			CASE "C" // container
				
				FOR i = 1 TO li_Count
					lnva_Events[i].of_GetAssignments( lla_Dummy, lla_Dummy, lla_Dummy, lla_Keep )
					IF UpperBound (lla_Keep ) > 0 THEN
						lnv_Disp.of_retrieveequipment( lla_Keep )
						lds_Cache = lnv_Disp.of_GetEquipmentcache( )
						ll_Find = lds_Cache.Find ( "eq_id = " + String (lla_Keep[1] ) , 1 ,lds_Cache.RowCount ()  )
						IF ll_Find > 0 THEN
							ls_Ref = lds_cache.GetItemString ( ll_Find , "eq_ref" )
							EXIT 
						END IF
					END IF
						
				NEXT
			CASE ELSE
	
				FOR i = 1 TO li_Count
					lnva_Events[i].of_GetAssignments( lla_Dummy, lla_Dummy, lla_Keep, lla_Dummy)
					IF UpperBound (lla_Keep ) > 0 THEN
						lnv_Disp.of_retrieveequipment( lla_Keep )						
						ll_Find = lds_Cache.Find ( "eq_id = " + String (lla_Keep[1] ) + " AND eq_type = '" + String (as_eqtype ) + "'",1,  lds_Cache.RowCount ()  )
						IF ll_Find > 0 THEN
							ls_Ref = lds_cache.GetItemString ( ll_Find , "eq_ref" )
							EXIT 
						END IF
					END IF
				NEXT
		END CHOOSE
		
		
	END IF
	
	
END IF

as_equipmentnumber = ls_Ref

RETURN 1
end function

public function integer of_process204 (ref n_cst_edi_204_record anv_204record, long al_sourcecompanyid);// This method will determine if the 204 shipment needs to be created or updated
Int		li_Return = 1
Long		ll_ShipID
Long		ll_Count
String 	ls_RefNum
String	ls_FindStatus
Boolean	lb_Real204
String	ls_AllowUpdates

ls_FindStatus = gc_Dispatch.cs_ShipmentStatus_Open

SetPointer ( HOURGLASS! )

ls_RefNum = anv_204Record.of_GetBlNum ( )
lb_Real204 = anv_204Record.of_isReal204 ( )

IF lb_Real204 THEN
	THIS.of_ProcessReal204 ( anv_204Record, al_sourcecompanyid )
	
ELSE
	
	// first we need to check the number of shipments with the specified ref number
	Select Count ( ds_id ) Into :ll_Count From disp_Ship where ds_Ref1_Text = :ls_RefNum AND ds_Ref1_type = 15 AND ds_Status = :ls_FindStatus;
	
	CHOOSE CASE sqlca.sqlCode
		CASE 0,100
		Commit;
	CASE ELSE 
		RollBack;
		li_Return = -1
	END CHOOSE
	
	
	IF li_Return = 1 THEN
		CHOOSE Case ll_Count
				
			CASE is > 1 //Error, Won't be able to resovle shipment							
				
			CASE 1 
				
				  SELECT "edi204profile"."allowupdates"  
					 INTO :ls_AllowUpdates  
					 FROM "edi204profile"  
					WHERE "edi204profile"."companyid" = :al_SourceCompanyID  ;
					
           IF sqlca.sqlCode = 0 THEN
					Commit;
				ELSE 
					RollBack;
					li_Return = -1
				END IF				
				
				Select ds_id into :ll_ShipID From disp_Ship where ds_Ref1_Text = :ls_RefNum AND ds_Ref1_type = 15 AND ds_Status = :ls_FindStatus;
				IF sqlca.sqlCode = 0 THEN
					Commit;
				ELSE 
					RollBack;
					li_Return = -1
				END IF
				
				IF ll_ShipID > 0 AND ls_AllowUpdates = "T" THEN
					IF THIS.of_UpdateShipment ( ll_ShipID , anv_204Record ) <> 1 THEN
						li_Return = -1
					END IF
				ELSE
					li_Return = 1
				END IF
				
			CASE 0 
				IF THIS.of_CreateShipment ( anv_204Record ) <> 1 THEN
					li_Return = -1 
				END IF
				
		END CHOOSE
	END IF
END IF

IF li_Return = -1 AND ll_ShipID > 0 THEN
	
	anv_204Record.of_SetErrorText ( "Target Shipment:" + String ( ll_ShipID ) )
	
END IF

RETURN li_Return
end function

private function integer of_processreal204 (ref n_cst_edi_204_record anv_204record, long al_sourcecompanyid);String 	ls_OrderType
Int		li_Return = 1
Long		ll_Count
String	ls_RefNum
String	ls_FindStatus 
Long		ll_ShipID
String	ls_error
String	ls_AllowUpdates
String	ls_AllowCancel



ls_FindStatus = gc_Dispatch.cs_ShipmentStatus_Open
ls_OrderType = anv_204Record.of_GetOrderType ( )
ls_RefNum = anv_204Record.of_GetediShipmentIdNumber ( )

// first we need to check the number of shipments with the specified ref number
Select Count ( ds_id ) Into :ll_Count From disp_Ship where edireference = :ls_RefNum AND ds_Status = :ls_FindStatus;

CHOOSE CASE sqlca.sqlCode
	CASE 0,100
	Commit;
CASE ELSE 
	RollBack;
	li_Return = -1
END CHOOSE

IF li_Return = 1 THEN
	CHOOSE Case ll_Count
			
		CASE is > 1 //Error, Won't be able to resovle shipment							
			
		CASE 1 
			Select ds_id into :ll_ShipID From disp_Ship where edireference = :ls_RefNum AND ds_Status = :ls_FindStatus;
			IF sqlca.sqlCode = 0 THEN
				Commit;
			ELSE 
				RollBack;
				li_Return = -1
			END IF
			
	END CHOOSE
END IF


CHOOSE CASE ls_OrderType
		
	CASE "00" // original
		IF THIS.of_CreateShipment ( anv_204Record ) <> 1 THEN
			li_Return = -1 
		END IF
	CASE "01"  // cancel
		
		SELECT "edi204profile"."allowcancel"  
		 INTO :ls_AllowCancel  
		 FROM "edi204profile"  
		WHERE "edi204profile"."companyid" = :al_SourceCompanyID  ;
		
		Commit;
		
		
		IF ll_ShipID > 0 THEN
			IF ls_AllowCancel = 'T' THEN
				IF THIS.of_CancelShipment ( ll_ShipID , anv_204Record ) <> 1 THEN
					li_Return = -1
				ELSE 
					ls_error = "Shipment canceled. "
					li_Return = -1 // doing this to force the use of the new message
				END IF
			ELSE
				li_Return = -1 // doing this to force the use of the new message
				ls_error = "Shipment not cancelled due to setting. "
				IF ls_RefNum <> "" THEN
					ls_Error += "[" + ls_RefNum + "]"
				END IF
			END IF
		ELSE
			li_Return = -1
			ls_error += "Could not resolve shipment to cancel. " 
		END IF
		
	CASE "04"  // change
		
		SELECT "edi204profile"."allowupdates"  
		 INTO :ls_AllowUpdates  
		 FROM "edi204profile"  
		WHERE "edi204profile"."companyid" = :al_SourceCompanyID  ;
		
		Commit;
		
		IF ll_ShipID > 0 THEN
			IF ls_AllowUpdates = 'T' THEN
				IF THIS.of_UpdateShipment ( ll_ShipID , anv_204Record ) <> 1 THEN
					li_Return = -1
				END IF
			ELSE
				li_Return = -1 // doing this to force the use of the new message
				ls_error = "Shipment not updated due to setting. "
				IF ls_RefNum <> "" THEN
					ls_Error += "[" + ls_RefNum + "]"
				END IF
			END IF
		ELSE
			ls_error = "Unable to resolve shipment to change. "
			IF ls_RefNum <> "" THEN
				ls_Error += "[" + ls_RefNum + "]"
			END IF
			li_Return = -1
		END IF
		
		
END CHOOSE

anv_204record.of_SetSuccessfulImportFlag ( li_Return = 1 )
anv_204Record.of_SetErrorText ( ls_error )

RETURN li_Return
end function

public function long of_findshipmentbyinvoicenumber (string as_invoicenumber);Long	ll_Shipment
Long	ll_Count


Select Count ( ds_id ) into :ll_Count
From Disp_ship 
where "ds_pronum" = :as_invoicenumber ;

IF ll_Count = 1 THEN
	Select ds_id into :ll_Shipment
	From Disp_ship 
	where "ds_pronum" = :as_invoicenumber ;
END IF

Commit;

RETURN ll_Shipment
end function

public function long of_findshipmentbyreftext (string as_text, boolean ab_excludeequipmenttypes);Long	ll_Shipment = -1
Long	ll_Count

IF NOT ab_excludeequipmenttypes THEN
	Select Count (ds_id) into :ll_count
	From Disp_ship
	where ds_ref1_text = :as_Text OR ds_ref2_text = :as_Text OR ds_ref3_text = :as_Text;
	
	IF ll_Count = 1 THEN
		Select Count (ds_id) into :ll_count
		From Disp_ship
		where ds_ref1_text = :as_Text OR ds_ref2_text = :as_Text OR ds_ref3_text = :as_Text;
	END IF

ELSE
	
	
	Select Count (ds_id) into :ll_count
	From Disp_ship
	where ( ds_ref1_text = :as_Text  AND ds_Ref1_Type not in (20,23,26,28 ) ) 
		OR ( ds_ref2_text = :as_Text  AND ds_Ref2_Type not in (20,23,26,28 ) ) 
		OR ( ds_ref3_text = :as_Text  AND ds_Ref3_Type not in (20,23,26,28 ) );
		
	IF ll_Count = 1 THEN
		Select ds_id into :ll_Shipment
		From Disp_ship
		where ( ds_ref1_text = :as_Text  AND ds_Ref1_Type not in (20,23,26,28 ) ) 
			OR ( ds_ref2_text = :as_Text  AND ds_Ref2_Type not in (20,23,26,28 ) ) 
			OR ( ds_ref3_text = :as_Text  AND ds_Ref3_Type not in (20,23,26,28 ) );
	END IF
		
	
END IF

commit;

RETURN ll_Shipment
end function

public function integer of_validateref1text (long al_shipmentid, string as_reftype, string as_refvalue);// RDT 12-06-02 Added code to check second and third reference numbers.
integer	li_Return = 1
	
string	ls_WhereClause, &
			ls_Value, &
			ls_SQL, &
			ls_OriginalSelect, &
			ls_ModString
		
Boolean	lb_ValidateRef
Boolean	lb_ValidateBL

String	ls_Status

long		lla_Ids[], &
			ll_RowCount, &
			ll_Ndx, &
			ll_ArrayCount

datastore 	lds_Ship, &
				lds_Item
//				
n_cst_Sql	lnv_Sql
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
w_Search		lw_Search


n_cst_setting_validateprimref	lnv_ValPrimRef
lnv_ValPrimRef = CREATE n_cst_setting_validateprimref
lb_ValidateRef = lnv_ValPrimRef.of_Getvalue( ) = lnv_valPrimRef.cs_yes
DESTROY ( lnv_ValPrimRef )


n_cst_setting_validateitemblref	lnv_ValBL
lnv_ValBL = CREATE n_cst_setting_validateitemblref
lb_ValidateBL = lnv_ValBL.of_Getvalue( ) = lnv_ValBL.cs_yes
DESTROY ( lnv_ValBL )

n_cst_setting_shipprimrefval	lnv_StatusToValidate
lnv_StatusToValidate = CREATE n_cst_setting_shipprimrefval
ls_Status = Upper ( lnv_StatusToValidate.of_Getvalue( ) )
DESTROY ( lnv_StatusToValidate )


ls_Value = as_refvalue


IF isnull (ls_Value) or len ( trim ( ls_Value ) ) = 0 THEN
	RETURN 1
END IF
	

	
IF li_Return = 1 THEN
	
	IF lb_ValidateREf THEN
		//Get shipments with matching values
		lds_Ship = CREATE DataStore
		lds_Ship.dataobject = "d_shipmentlist"
		lds_Ship.SetTransObject ( SQLCA )
		ls_OriginalSelect = lds_Ship.Describe("DataWindow.Table.Select")
		
 		ls_SQL = " where disp_ship.ds_ref1_text = ~~'" + ls_Value + "~~'" 	

		IF ls_Status = "OPEN" THEN
			ls_SQL += " and disp_ship.ds_status <> ~~'" + gc_dispatch.cs_ShipmentStatus_Billed + "~~'" 
		END IF
		ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_sql + "'"
		lds_Ship.Modify(ls_ModString)
		ll_RowCount = lds_Ship.Retrieve()
		commit;		//<<*>>
		FOR ll_Ndx = 1 to ll_RowCount
			ll_ArrayCount ++
			lla_Ids[ll_ArrayCount] = lds_Ship.object.ds_id[ll_Ndx]
		NEXT
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	IF lb_ValidateBl THEN
		//get items with matching values
		lds_Item = CREATE DataStore
		lds_Item.dataobject = "d_itemselection"
		lds_Item.SetTransObject ( SQLCA )
		ls_OriginalSelect = lds_Item.Describe("DataWindow.Table.Select")
		ls_SQL = " AND disp_items.di_blnum = ~~'" + ls_Value + "~~'"  
		IF ls_Status = "OPEN" THEN
			ls_SQL += " and disp_ship.ds_status <> ~~'" + gc_dispatch.cs_ShipmentStatus_Billed + "~~'" 
		END IF
		ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_sql + "'"
		lds_Item.Modify(ls_ModString)
		ll_RowCount = lds_Item.Retrieve()
		Commit;
		FOR ll_Ndx = 1 to ll_RowCount
			ll_ArrayCount ++
			lla_Ids[ll_ArrayCount] = lds_Item.object.di_shipment_id[ll_Ndx]
		NEXT
	END IF
END IF

IF li_Return = 1 THEN
	//if any returned then ask to display search list
	IF upperbound ( lla_Ids ) > 0 THEN
	
		IF MessageBox ( "Primary Reference Cross Check", "This number has been used in other shipments. "+&
			"Do you want to display a search list of the shipments ?", &
			Information!, YesNo!, 1 ) = 1 THEN
	
			ls_WhereClause = " WHERE ds_id " + lnv_Sql.of_MakeInClause ( lla_Ids )
			IF ls_Status = "OPEN" THEN
				ls_SQL += " and ds_status <> ~~'" + gc_dispatch.cs_ShipmentStatus_Billed + "~~'" 
			END IF
			lstr_Parm.is_Label = "ShipmentWhereClause"
			lstr_Parm.ia_Value = ls_WhereClause
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			OpenSheetWithParm ( lw_Search, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
			
		END IF
		
	END IF

END IF



///////////////////  MOVE THE STUFF BELOW OUT OF HERE \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


/*
	IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) = TRUE OR &
		lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) = TRUE THEN
		IF lnv_Shipment.of_IsNonRouted ( ) = FALSE THEN
			li_RefType = lnv_Shipment.of_GetRef1Type ( ) //.object.ds_ref1_Type[1] 
			IF ( li_RefType = 20 OR li_RefType = 26 OR li_RefType = 28 ) AND Len ( Trim ( ls_Value ) ) > 0 THEN // container #
				DataStore	lds_Find
				S_eq_Info	lstr_equip
				
				
				IF li_RefType = 20 THEN
					ls_Type = 'C'
				ELSEIF li_RefType = 26  THEN
					ls_Type = 'B'
				ELSE 
					ls_Type = 'H'
				END IF
				
				ls_Find = "WHERE eq_ref = '" + ls_Value + "' AND eq_type = '" + ls_Type + "'"
				lnv_Equip.of_Retrieve( lds_Find , ls_Find)
				
				CHOOSE CASE lds_Find.RowCount ( )
						
					CASE 0 // Equip DNE
						IF MessageBox ( "Outside Equipment", "The equipment you have specified does not exist.  "+&
						"Do you want to create new Leased Equipment with that number?", Question!, YesNo!, 1 ) = 1 THEN
							lstr_Equip.eq_ref = ls_Value
							lstr_Equip.eq_type = '34'
							lstr_Equip.eq_id = 0
							
							lnv_Msg.of_Reset ( )
							lstr_Parm.is_label = "EQSTRUCT"
							lstr_Parm.ia_Value = lstr_Equip
							lnv_Msg.of_Add_Parm ( lstr_Parm )
							
							
							lstr_Parm.is_label = "SHIPMENT"
							lstr_Parm.ia_Value = lnv_Shipment.of_GetID ( )
							lnv_Msg.of_Add_Parm ( lstr_Parm )
							
							
							
							OpenWithParm ( w_eq_NewOut , lnv_Msg )
							lstr_Equip = message.PowerobjectParm
							IF lstr_Equip.eq_id > 0 THEN // equipment created
								lnv_Shipment.of_SetRef1Text ( lstr_Equip.eq_ref )
//								this.object.ds_ref1_text[1] = lstr_Equip.eq_ref  // if in the create window 
							END IF															// they change the ref then
//							THIS.SetRedraw ( TRUE ) //force refresh			  // we want to show it here
																					
						END IF
						
					CASE 1 // THE Equip exists
						THIS.of_ExistingEquipmentEntered ( lds_Find.object.eq_id [ 1 ] , lnv_Shipment.of_GetID ( ) )
						//MessageBox("Specified Equipment" , "The equipment specifed has previously been created." , INFORMATION! )
						
					CASE IS > 1 // multiples exist
						MessageBox("Specified Equipment" , "More than one piece of equipment already exists with that reference number." , INFORMATION! )				
		
					CASE ELSE 
						// ERROR
				END CHOOSE
				
			END IF
		END IF
	END IF
	
END IF
 

//

IF IsValid ( lds_Find ) THEN
	DESTROY lds_Find
END IF
*/
IF IsValid ( lds_Item ) THEN
	DESTROY lds_Item
END IF

IF IsValid ( lds_Ship ) THEN
	DESTROY lds_Ship
END IF




//MessageBox ( "Time" , ls_Temp )




RETURN li_Return

end function

public function integer of_processcrossdocksforinvoice (n_cst_beo_shipment anv_shipment);Int		li_Return
Int		i
Int		li_RowCount
Boolean	lb_HideDocks
Long		lla_DockRows[]



n_cst_crossdock	lnv_CrossDocks
n_cst_setting_crossdockoninvoice	lnv_HideSetting

lnv_HideSetting = CREATE n_cst_setting_crossdockoninvoice
lnv_CrossDocks = CREATE n_cst_crossdock

li_Return = 1

lnv_CrossDocks.of_Getdockrows( anv_Shipment.of_GetEventSource ( ), lla_DockRows ) 

li_RowCount = UpperBound ( lla_DockRows )

IF li_RowCount > 0 THEN
	CHOOSE CASE lnv_HideSetting.of_Getvalue( )
			
		CASE n_cst_setting_crossdockoninvoice.cs_alwayshide
			lb_HideDocks = TRUE
		CASE n_cst_setting_crossdockoninvoice.cs_AlwaysShow
			lb_HideDocks = FALSE	
		CASE n_cst_setting_crossdockoninvoice.cs_ask
			lb_HideDocks =	MessageBox ( "Hide Cross-Docks" , "Do you want to hide the cross-dock events on the invoice?" , Question!, YesNo!, 1 ) = 1
			
	END CHOOSE
	
END IF

IF lb_HideDocks THEN
	
	
	n_cst_beo_Event	lnv_Event
	lnv_Event = CREATE n_cst_beo_Event
	
	lnv_Event.of_SetSource ( anv_Shipment.of_GetEventSource ( ) )
	
	FOR i = 1 TO li_RowCount 
		
		lnv_Event.of_SetSourceRow ( lla_DockRows[i] )
		lnv_Event.of_Sethideonbill( TRUE )
		
	NEXT
	
	DESTROY ( lnv_Event ) 

END IF

DESTROY ( lnv_HideSetting )
DESTROY ( lnv_CrossDocks )
RETURN li_Return

end function

public function integer of_getfuelsurcharge (ref decimal ac_fuelsurcharge, ref n_cst_beo_shipment anv_shipment);//Returns:   1 = Success (value returned by reference in ac_FuelSurcharge)
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

Decimal	lc_FuelSurcharge
Integer	li_SqlCode
Boolean	lb_HasSurcharge
Integer	li_Return = 1

n_cst_beo_Company	lnv_Company

IF isValid ( anv_shipment ) THEN

	IF li_Return = 1 THEN
		IF anv_shipment.of_GetBillToCompany ( lnv_Company , TRUE ) > 0 THEN
			IF lnv_Company.of_HasSource ( ) THEN
				IF lnv_Company.of_HasCustomFuelSurcharge ( ) THEN
					lc_FuelSurcharge = lnv_Company.of_GetCustomFuelSurcharge ( )
					lb_HasSurcharge = TRUE
				END IF
			END IF
		END IF
	END IF
	
END IF

IF NOT lb_HasSurcharge THEN

	//Attempt to retrieve Fuel Surcharge Value from database
	
	SELECT ss_Dec INTO :lc_FuelSurcharge FROM System_Settings WHERE ss_Id = 28 ;
	
	li_SqlCode = SQLCA.SqlCode
	
	COMMIT ;
	
	
	//Evaluate retrieval result
	
	CHOOSE CASE li_SqlCode
	
	CASE 100		//Value not defined
		li_Return = 0
	
	CASE 0		//Success.  Validate value.
		
		
		// added the = to the > to make >= be an ok value.
		// this is because we want to have the ability to have the mojority of companies
		// without a fsc and a couple with an override. 
		IF lc_FuelSurcharge >= 0 THEN
			//Value is OK
		ELSE
			li_Return = 0
		END IF
	
	CASE ELSE	//Error
		li_Return = -1
	
	END CHOOSE
END IF

	
//Set Reference Parameters and Return	
IF li_Return = 1 THEN
	ac_FuelSurcharge = lc_FuelSurcharge
ELSE
	SetNull ( ac_FuelSurcharge )
END IF

RETURN li_Return
end function

public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long ala_eventids[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_forceitinselect);//Revised by overloading to include option to pass in ai_ItinType, al_ItinId, and ad_ItinDate, instead of
//determining them by prompting.  Also eliminated one subsequent call and now perform processing here.  9/30/05 BKW  

//anv_Dispatch probably does not need to be by reference, but I've maintained that convention because all of the
//other versions of the function have it by reference.


Long		ll_EquipmentId, &
			ll_null, &
			lla_DriverIds[], &
			ll_insertioneventid, & 
			ll_ConfirmedCount, & 
			ll_RoutedCount, & 
			ll_Index, & 
			ll_EventCount, & 
			lla_EventIds[]

Integer	li_Return = 1, &
			li_null, &
			li_itintype, &
			li_InsertionStyle
			
Date		ld_ItinDate

Int	li_MsgRtn

String 	ls_SelectionCategory, &
			ls_ErrorMessage 

s_Anys						lstr_OpenParms, &
								lstr_Selection

s_eq_info					lstr_Equip
n_cst_beo_event 			lnva_Events[]
n_cst_LicenseManager 	lnv_LicenseManager
n_cst_bso_RouteManager	lnv_RouteManager
n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_OFRError				lnva_Errors[]
n_cst_Events				lnv_Events

n_cst_anyarraysrv lnv_arraysrv


li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfRoute
SetNull ( ll_InsertionEventId )

SetNull( li_null )
SetNull( ll_null )


anv_Dispatch.of_GetEventlist ( ala_eventids[], lnva_Events[], TRUE /*ab_retrieveifneeded*/)
//

//Pull the event ids from the event list, and count how many are confirmed and routed

IF li_Return = 1 THEN

	ll_ConfirmedCount = 0
	ll_RoutedCount = 0
	ll_EventCount = UpperBound(ala_eventids)
	
	IF ll_EventCount > 0 THEN
		FOR ll_Index = 1 TO ll_EventCount
	
			lla_EventIds [ ll_Index ] = lnva_Events [ ll_Index ].of_GetId ( )
	
			IF lnva_Events [ ll_Index ].of_IsConfirmed ( ) THEN
	
				ll_ConfirmedCount ++
	
			END IF
			
			IF lnva_Events [ ll_Index ].of_IsRouted( ) THEN
	
				ll_RoutedCount ++
				
			END IF
	
		NEXT
	END IF	

	IF ll_ConfirmedCount > 0 THEN  
		IF MessageBox ( "Auto-Route CONFIRMED Events", String ( ll_ConfirmedCount ) + " Event(s) in the leg you have "+&
			"selected are already routed and confirmed complete.  ARE YOU SURE YOU WANT TO REMOVE THESE "+& 
			"ROUTING CONFIRMATIONS AND ASSIGN THESE EVENTS TO SOMEONE ELSE?", Exclamation!, OKCancel!, 2 ) = 2 THEN
			li_Return = 0  //Action cancelled by user.
		END IF
	END IF
	
	IF li_Return = 1 THEN
		IF ll_RoutedCount > 0 THEN

			IF MessageBox ( "Auto-Route ROUTED Events", String ( ll_RoutedCount ) + " Event(s) in the leg you have "+&
				"selected are already routed.  ARE YOU SURE YOU WANT TO "+& 
				"ASSIGN THESE EVENTS TO SOMEONE ELSE?", Exclamation!, OKCancel!, 2 ) = 2 THEN
				li_Return = 0  //Action cancelled by user.
			END IF

		END IF
	END IF
END IF

//

IF li_Return = 1 THEN

	IF IsNull ( ai_ItinType ) OR IsNull ( al_ItinId ) THEN
	
		IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_RouteManager ) THEN
			ll_EquipmentId = lnv_RouteManager.of_GetRouteEquipmentId ( lnva_Events, is_RouteType )
	
			IF anv_Dispatch.of_GetEquipmentInfo ( ll_EquipmentId, lstr_Equip ) = 1 THEN
				li_ItinType = lnv_EquipmentManager.of_GetItinType ( lstr_Equip.eq_Type )
			END IF
	
		END IF
		
	ELSEIF ai_ItinType > 0 AND al_ItinId > 0 THEN
		
		ll_EquipmentId = al_ItinId
		li_ItinType = ai_ItinType
		
	ELSE
		
		SetNull ( ll_EquipmentId )
		SetNull ( li_ItinType )
		
	END IF
	
	
	ld_ItinDate = Date ( DateTime ( ad_ItinDate ) )
	
END IF


IF li_Return = 1 AND ( IsNull ( li_ItinType ) OR IsNull ( ll_EquipmentId ) OR IsNull ( ld_ItinDate ) OR ab_ForceItinSelect) THEN
	
	IF IsNull ( ld_ItinDate ) THEN
		ld_ItinDate = Date ( DateTime ( Today ( ) ) )
	END IF
	
	IF li_ItinType > 0 THEN
		lstr_OpenParms.Anys [ 1 ] = li_ItinType
	ELSE
		lstr_OpenParms.Anys [ 1 ] = li_Null //Use Default
	END IF
	lstr_OpenParms.anys[2] = "ALL_SHIPS" //changed from "ROUTED_ONLY" in 3.0.02
	lstr_OpenParms.anys[3] = ld_ItinDate
	lstr_OpenParms.anys[4] = ll_Null  //Dead Parameter
	lstr_OpenParms.anys[5] = "PASS"
	lstr_OpenParms.anys[6] = {0}
	
	//** 4/17/06 - Maury
	CHOOSE CASE li_ItinType
		CASE gc_Dispatch.ci_ItinType_Driver //driver
			IF ll_EquipmentId > 0 THEN
				lstr_OpenParms.anys[6] = {ll_EquipmentId}
			END IF
		CASE gc_Dispatch.ci_ItinType_Trip //trip
			IF ll_EquipmentId > 0 THEN
				lstr_OpenParms.anys[11] = {ll_EquipmentId}
			END IF
		CASE ELSE	
			IF ll_EquipmentId > 0 Then 
				lstr_OpenParms.anys[7] = {ll_EquipmentId}
			END IF
	END CHOOSE
	//** end 4/17/06 - Maury
	
	openwithparm(w_itin_select, lstr_OpenParms)
	
	lstr_Selection = message.powerobjectparm

	ls_SelectionCategory = lstr_Selection.anys[1]


	IF ls_SelectionCategory = "ITIN" THEN

		li_ItinType = lstr_Selection.anys[2]
		ll_EquipmentId = lstr_Selection.anys[3]

////		//Note:  This date will be null if user selected a trip.  That's ok for EndOfRoute style.
//		ld_ItinDate = lstr_Selection.anys[4]
//		ld_ItinDate = Date ( DateTime ( ld_ItinDate ) )
//    moved this from here to down below because we could get an ABE if they selected Shipment as the route target.
	ELSEIF ls_SelectionCategory = "NONE" OR ls_SelectionCategory = "SHIP" THEN
		li_Return = 0 // user cancelled
		
	END IF
	
	IF li_Return = 1 THEN
		ld_ItinDate = lstr_Selection.anys[4]
		ld_ItinDate = Date ( DateTime ( ld_ItinDate ) )
	END IF
	
END IF


IF li_Return = 1 THEN
   IF anv_dispatch.of_Validaterouterequest( ala_eventids[] , ll_InsertionEventId ,ld_ItinDate, li_ItinType, ll_EquipmentId ) > 0 THEN
	//IF anv_dispatch.of_Validateassociations( ala_eventids, ll_InsertionEventId, ld_ItinDate, li_ItinType, ll_EquipmentId , 0 , 0 ) > 0 THEN
		IF NOT anv_dispatch.of_GetValidation ( ).of_DoWeContinue( ) THEN
			li_Return = 0
		END IF
	END IF
END IF

IF li_Return = 1 THEN
	
// Eliminated this call and shifted the processing here 9/30/05 BKW
//
//	IF this.of_autoroute( li_itintype, ll_EquipmentId, ala_eventids[],  anv_dispatch, ab_save )	<> 1 THEN 	// ZMC
//		li_Return = -1
//	END IF


	IF anv_Dispatch.of_Route ( ala_eventids[], li_ItinType, ll_EquipmentId, &
		ld_ItinDate, 0 /*DateScaleStyle!*/, ll_InsertionEventId, li_InsertionStyle ) = 1 THEN
	
		If ab_save Then 
			anv_dispatch.Event pt_save() 
			Destroy( anv_Dispatch )
		End If
		
	ELSE
		
		li_Return = -1
	
	END IF 

END IF

lnv_arraysrv.of_destroy ( lnva_Events )

Return li_Return
end function

public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long ala_eventids[], ref n_cst_bso_dispatch anv_dispatch, boolean ab_save);Return This.of_Autoroute( ai_itintype, al_itinid, ad_itindate, ala_eventids[], anv_dispatch, ab_save, FALSE/*ab_ForceItinSelect*/)
end function

public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist, boolean ab_forceitinselect);//This overloaded version created 9/30/05 BKW.  It is the same processing as before, but forwards the supplied
//itin arguments to the next call in the chain.

// #1
// Args: al_shipmentid, anv_dispatch, ab_save
// Rtrn: 1 = Success, 0 = User Cancelled, -1 = Failure
// This will get the target events to route.
// Get shipment from dispatch
// get events from shipment
//messagebox("RICH","#1 Args: al_shipmentid, anv_dispatch, ab_save")

Long		ll_EventCount, &
			lla_EventIds[], &
			ll_Index, &
			ll_routablecount, &
			ll_ConfirmedCount, &
			ll_RoutedCount

Integer	i, &
			li_Return = 1 

n_Cst_beo_Event	lnva_EventList []
Int	li_EventCount 
n_cst_beo_Shipment	lnv_Shipment 
		

n_cst_beo_Event	lnva_Events[], &
						lnva_RoutableEvents[], &
						lnva_BlankEvent[]

n_cst_anyarraysrv lnv_arraysrv

String	ls_ErrorMessage = "Could not process Auto Route request."

IF this.of_AutoRouteLicenseCheck( ) Then 
	// ok
Else
	li_Return = 0 // this will prevent message from display
End if

IF NOT IsValid(anv_Dispatch) THEN 
	li_Return = -1
	ls_ErrorMessage = "Dispatch not valid"
END IF

IF li_Return = 1 THEN
	IF ab_promptforeventlist THEN
		// Get Event from user
		If This.of_AutoRouteGetEvents ( al_shipmentid, anv_dispatch, lla_eventids[] ) = -1 then
			// user canceled
			ls_ErrorMessage =""
			li_Return = -1
		End If
	ELSE
		
		anv_dispatch.of_RetrieveShipment(al_Shipmentid)
		anv_dispatch.of_FilterShipment(al_Shipmentid)
		lnv_Shipment = CREATE n_cst_beo_Shipment
		lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache () )
		lnv_Shipment.of_SetSourceID ( al_SHipmentID )
		lnv_Shipment.of_SetEventSource ( anv_Dispatch.of_GetEventCache ( ) )
		lnv_Shipment.of_SetItemSource ( anv_Dispatch.of_GetItemCache ( ) )
		
		li_EventCount = lnv_Shipment.of_GetEventList ( lnva_EventList )
		FOR i = 1 TO li_EventCount 
			lla_eventids[ i ] = lnva_EventList[i].of_GetID ( )
			DESTROY ( lnva_EventList[i] )
		NEXT
		
		DESTROY ( lnv_Shipment)
	END IF
END IF

//remove non_routable events from the list
IF li_Return = 1 THEN
		ll_EventCount = anv_dispatch.of_geteventlist ( lla_eventids[], lnva_events[], FALSE /*ab_retrieveifneeded*/ )
	
	FOR ll_Index = 1 to ll_EventCount
		
		IF lnva_Events [ ll_Index ].of_GetRoutable ( ) = 'F' THEN
			//don't include
		else
			ll_routablecount ++
			lnva_RoutableEvents[ll_routablecount] = lnva_Events [ ll_Index ]
		END IF
		
	NEXT
	
	lnva_Events		= lnva_BlankEvent
	lnva_Events		= lnva_RoutableEvents
	ll_EventCount	= upperbound(lnva_Events)

	// If no events, no need to continue. Set li_Return to -1 and message = ""
	If ll_EventCount < 1 then
		ls_ErrorMessage =""
		li_Return = -1
	End If

END IF

IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	MessageBox ("Auto Route", ls_ErrorMessage, Exclamation!)
END IF

// Destroy
lnv_arraysrv.of_destroy ( lnva_Events )
lnv_arraysrv.of_destroy ( lnva_BlankEvent ) 
lnv_arraysrv.of_destroy ( lnva_RoutableEvents) 


IF li_Return = 1 then
	IF This.of_AutoRoute(ai_ItinType, al_ItinId, ad_ItinDate, lla_EventIds, anv_dispatch, ab_save, ab_forceitinselect) <> 1 THEN 
		li_Return = -1
	END IF	
End If

Return li_Return

end function

protected function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, readonly long al_shipmentid, ref n_cst_bso_dispatch anv_dispatch, boolean ab_save, boolean ab_promptforeventlist);Return This.of_AutoRoute( ai_itintype, al_itinid, ad_itindate, al_shipmentid, anv_dispatch, ab_save, ab_promptforeventlist, FALSE/*ab_ForceItinSelect*/)
end function

public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long al_shipmentid, boolean ab_forceitinselect);//This overloaded version created 9/30/05 BKW.  It is the same processing as before, but forwards the supplied
//itin arguments to the next call in the chain.

// #1
//Arg: al_shipmentid
// setup dispatch from shipment id and call of_autoroute
Integer  li_Return = 1
//MessageBox("RICH"," #1/Arg: al_shipmentid")

n_cst_beo_Shipment lnv_Shipment

n_cst_bso_Dispatch 		lnv_Dispatch 
lnv_Dispatch = CREATE n_cst_bso_Dispatch

IF this.of_AutoRouteLicenseCheck( ) Then 
	// ok
Else
	li_Return = -1
End if

If li_Return = 1 then 

	lnv_Dispatch.of_RetrieveShipment ( al_shipmentid )

	lnv_Dispatch.of_filterShipment ( al_shipmentid )

	li_Return = this.of_AutoRoute ( ai_ItinType, al_ItinId, ad_ItinDate, al_ShipmentId, lnv_Dispatch, True /*ab_save*/, True /*ab_PromptForEventList*/, ab_ForceItinSelect)

End If

destroy (lnv_Dispatch) 

Return li_Return 
end function

public function integer of_autoroute (integer ai_itintype, long al_itinid, date ad_itindate, long al_shipmentid);Return This.of_Autoroute(ai_itintype, al_itinid, ad_itindate, al_shipmentid, FALSE /*ab_ForceItinSelect*/)
end function

public function long of_getdivision (long al_tmpnum);//written by dan 5-5-2006 to return the division of the shipment
//associated with the tmp number passed in.  Returns -1 if the
//division is null or the temp number doesn't exist
Long	ll_division
Long	ll_tmpNum

ll_tmpNum = al_tmpNum

SELECT "ds_ship_type"
INTO :ll_division
FROM "disp_ship"  
WHERE "disp_ship"."ds_id" = :ll_tmpNum;
COMMIT;


IF SQLCA.SQLCode = -1 OR SQLCA.SQLCODE = 100 THEN 

  //MessageBox("SQL error", SQLCA.SQLErrText)
//undefined division

	ll_division = -1
END IF


RETURN ll_division
end function

private function integer of_duplicateshipment (ref n_cst_msg anv_msg, boolean ab_createequipment);Integer		li_Return = 1
Long			ll_ShipId
Long			ll_ShipmentCount
Long			ll_ChildCount
Long			i, j, k
Long			ll_MsgCount
Long			ll_NextShipmentID
Long			lla_NewSiteIds []
Long			lla_NewShipmentIDs[]
Long			lla_ChildShipments[]
Long			lla_ShipId[]  //single shipment id
Boolean		lb_Retrieve = TRUE
Boolean		lb_Items = TRUE
Boolean		lb_NonRouted = FALSE
Boolean		lb_DuplicateChildren
String		ls_PaymentTerms
String		ls_Label

n_cst_LicenseManager	lnv_LicenseMgr

n_cst_beo_Shipment	lnv_Shipment

n_cst_Msg	lnv_EventsMsg
n_cst_Msg	lnv_MsgCopy

n_ds	lds_Events
n_ds	lds_Items
n_ds	lds_Shipment

n_cst_Msg	lnv_Msg
s_parm		lstr_Parm

lnv_Msg	= anv_Msg

lnv_Shipment = CREATE n_cst_beo_Shipment

//IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_Items , lstr_Parm ) <> 0 THEN
//	lb_Items = lstr_Parm.ia_Value
//END IF

IF lnv_Msg.of_Get_Parm ( "SHIPMENTID" , lstr_Parm ) <> 0 THEN
	ll_ShipID = lstr_Parm.ia_Value 
END IF

IF lnv_Msg.of_Get_Parm ( "COUNT" , lstr_Parm ) <> 0 THEN
	ll_ShipmentCount = lstr_Parm.ia_Value 
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_CopyChild , lstr_Parm ) <> 0 THEN
	 lb_DuplicateChildren = lstr_Parm.ia_Value
	 IF lb_DuplicateChildren THEN
		 lla_ShipId[1] = ll_ShipId
		 inv_Dispatch.of_GetShipmentChild( lla_ShipId[], lla_ChildShipments[])
	 END IF
END IF

IF lnv_Msg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_NonRouted , lstr_Parm ) <> 0 THEN
	lb_NonRouted = lstr_Parm.ia_Value
END IF


//this will trump the parameter above
IF lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) = FALSE AND &
	lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch ) = FALSE THEN
	lb_NonRouted = TRUE
END IF


IF lnv_msg.of_Get_Parm ( "DISPATCH" , lstr_Parm ) <> 0 THEN
	inv_Dispatch = lstr_Parm.ia_Value 
	lb_Retrieve = FALSE
END IF

IF lb_Retrieve THEN
	inv_Dispatch.of_RetrieveShipment ( ll_ShipID ) 
	inv_Dispatch.of_FilterShipment ( ll_ShipID )
END IF
	
lds_shipment = inv_Dispatch.of_GetShipmentCache ( )
lds_events = inv_Dispatch.of_GetEventCache ( )
lds_items = inv_Dispatch.of_GetItemCache ( )

//Retrieve all the shipment, Event and item info
IF isValid(lds_Shipment) THEN
	IF ll_ShipID > 0 THEN
		lnv_Shipment.of_SetSource ( lds_shipment )
		lnv_Shipment.of_SetSourceID ( ll_ShipID )
		
		lnv_Shipment.of_SetEventSource ( lds_events )
		lnv_Shipment.of_SetItemSource ( lds_items )
	ELSE
		li_Return = -1
	END IF
ELSE	
	li_Return = -1
END IF

IF li_Return = 1 THEN

	lds_shipment.Modify ( "ds_id.Update=Yes" )
	lds_events.Modify ( "de_id.Update=Yes" )
	lds_items.Modify ( "di_id.Update=Yes" )
	
	FOR i = 1 TO ll_ShipmentCount  // copy the shipment
		
		IF THIS.of_GetNextShipmentID ( ll_NextShipmentID ) = 1 THEN
			
			ls_PaymentTerms = ''

			if lnv_Shipment.Of_Determinepaymentterms('', ls_PaymentTerms) = 1 then
				lstr_Parm.ia_Value = ls_PaymentTerms
				lstr_Parm.is_label = 'PAYMENTTERMS'
				lnv_Msg.of_add_parm( lstr_parm )
			end if

			THIS.of_CopyShipment ( i, ll_NextShipmentID , lnv_msg , lds_shipment)
			
			THIS.of_GetOrigEvent ( lds_events , lnv_EventsMsg )
			THIS.of_GetTermEvent ( lds_events , lnv_EventsMsg )
			THIS.of_CopyEvents ( ll_NextShipmentID ,lds_events, lnv_msg , lnv_EventsMsg )
			
			IF lb_Items THEN
				THIS.of_CopyItems ( ll_NextShipmentID , lds_items, lnv_msg  )
			END IF
			
			lla_NewShipmentIDs [ i ] = ll_NextShipmentID
			
			lnv_Shipment.of_SetSourceid( ll_NextShipmentID )
			lnv_Shipment.of_Calculate( )
		
			IF lb_NonRouted = FALSE THEN
				IF ab_CreateEquipment THEN
					THIS.of_CreateEquipment ( lnv_Msg , lnv_EventsMsg, ll_NextShipmentID )
				END IF
			END IF
			

			//Shipment must be saved before associated equipment here.
			//Cannot just call pt_save because equipment cache is saved first in pt_SAVE
			
			//Update shipment, event, and item cache.
			IF li_Return = 1 THEN
				IF lds_Shipment.Update() <> 1 THEN
					li_Return = -1
				END IF
			END IF
			IF li_Return = 1 THEN
				IF lds_Events.Update() <> 1 THEN
					li_Return = -1
				END IF
			END IF
			
			IF li_Return = 1 THEN
				IF lds_Items.Update() <> 1 THEN
					li_Return = -1
				END IF
			END IF
			
			IF li_Return = 1 THEN
				Commit;
			ELSE
				RollBack;
			END IF
			
			//PT save
			IF li_Return = 1 THEN
				IF inv_Dispatch.Event pt_save ( ) <> 1 THEN //This will save any created equipment
					li_Return = -1
				END IF
			END IF
					
			//Child duplication
			IF li_Return = 1 THEN
				
				IF lb_DuplicateChildren THEN
	
					//duplicate children shipments
					ll_ChildCount = UpperBound(lla_ChildShipments[])
	
					ll_MsgCount = lnv_Msg.of_Get_Count()
					FOR j = 1 TO ll_ChildCount
						//initilize child message object
						lnv_MsgCopy.of_Reset ( )
						FOR k = 1 TO ll_MsgCount
							IF lnv_Msg.of_Get_parm( k, lstr_Parm) <> 0 THEN
								ls_Label = lstr_Parm.is_Label
								IF ls_Label <> "COUNT" AND ls_Label <> "SHIPMENTID" AND ls_Label <> "PARENTSHIPMENTID" THEN
									lnv_MsgCopy.of_Add_Parm(lstr_Parm)
								END IF
							END IF
						NEXT
						
						lstr_parm.is_Label = "COUNT"
						lstr_Parm.ia_Value = 1
						lnv_MsgCopy.of_Add_Parm ( lstr_parm )
						
						lstr_parm.is_Label = "SHIPMENTID"
						lstr_Parm.ia_Value = lla_ChildShipments[j]
						lnv_MsgCopy.of_Add_Parm ( lstr_parm )
						
						lstr_parm.is_Label = "PARENTSHIPMENTID" 
						lstr_Parm.ia_Value = ll_NextShipmentID 
						lnv_MsgCopy.of_Add_Parm ( lstr_parm )
						
						IF This.of_DuplicateShipment( lnv_MsgCopy, False) <> 1 THEN
							li_Return = -1
							EXIT
						END IF
							
					NEXT
				END IF
				
			END IF
			
		END IF
		
		IF li_Return = -1 THEN
			EXIT // One shipment failed, bail out
		END IF
		
	NEXT


	IF li_Return = 1 THEN
		THIS.of_RefreshShipments ( FALSE ) // false = don't refresh trips
		
		lstr_Parm.is_Label = "NEWIDS"
		lstr_Parm.ia_Value = lla_NewShipmentIDs
		anv_msg.of_Add_Parm ( lstr_parm )
		
	END IF 

END IF

DESTROY ( lnv_Shipment )

Return li_Return	

end function

public function integer of_createequipment (n_cst_msg anv_msg, n_cst_msg anv_eventsmsg, long al_shipid);/*Revised 8/16/06 MFS - pt_save ( ) of inv_Dispatch commented out 
							  save now done in of_duplicateShipment()*/  
Long		ll_Lease
String	ls_BookingNum
Long		ll_Len
Long		ll_Height
String	ls_BehalfOf
String	ls_Air
String	ls_Type
String	ls_Ref
String	ls_WhereClause
String	ls_Null
DateTime	ldt_Null
Long		ll_newRow
Long		ll_NewID
Long		ll_FoundRow
Long		ll_OriginSite
Long		ll_TermSite
Long		ll_Null
Int		li_Return = 1


S_Parm	lstr_Parm
n_cst_msg	lnv_Msg
n_cst_Msg	lnv_SitesMsg
S_eq_Info	lstr_Equip

n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_Beo_Equipment2		lnv_Equipment
n_cst_Beo_EquipmentLease2		lnv_Lease

n_cst_Numerical lnv_Numerical
DataStore	lds_Equip
DataStore	lds_Search

n_ds		lds_EquipCache

SetNull ( ls_Null )
SetNull ( ldt_Null )
SetNull  ( ll_Null )
SetNull ( ll_Lease )

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Lease = CREATE n_cst_Beo_EquipmentLease2

lds_Equip = CREATE DataStore
lds_Equip.DataObject = "d_equip_list"
lnv_msg = anv_msg


IF lnv_Msg.of_Get_Parm ( "EQUIPREF" , lstr_Parm ) <> 0 THEN
	 ls_Ref = Trim( lstr_Parm.ia_Value )
END IF

IF lnv_Msg.of_Get_Parm ( "EQUIPTYPE" , lstr_Parm ) <> 0 THEN
	ls_Type =  Trim ( lstr_Parm.ia_Value )
END IF




IF THIS.of_GetSitesForDuplication ( anv_Msg , anv_eventsmsg , lnv_SitesMsg ) <> 1 THEN
	li_Return = -1
END IF

IF lnv_SitesMsg.of_Get_Parm ( "ORIGINSITE" , lstr_Parm ) <> 0 THEN
	ll_OriginSite = lstr_Parm.ia_Value 
END IF

IF lnv_SitesMsg.of_Get_Parm ( "TERMINATIONSITE" , lstr_Parm ) <> 0 THEN
	ll_TermSite =  lstr_Parm.ia_Value 
END IF



IF Len ( ls_Ref ) > 0 AND Len ( ls_Type ) > 0 AND li_Return = 1 THEN

	lds_Equip.SetTransObject ( SQLCA )
	lds_Equip.Retrieve ( )
	

	lds_EquipCache = inv_Dispatch.of_GetEquipmentCache ( )
	
	// check to see if the equipment already exists 

	ls_WhereClause = "WHERE eq_ref = '" + ls_Ref + "' and eq_status = 'K'"
	if len(ls_Type) > 0 then 
		ls_WhereClause += " and eq_type = '" + ls_Type +"'"
	END IF
	
	lnv_EquipmentManager.of_Retrieve  (  lds_Search ,ls_WhereClause  )
	IF lds_Search.RowCount ( ) = 0 THEN // equipment doesn't exist
	
	
		IF lnv_msg.of_Get_Parm ( "BOOKINGNUMBER" , lstr_Parm ) <> 0 THEN
			ls_BookingNum =  lstr_Parm.ia_Value 
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "EQUIPLEN" , lstr_Parm ) <> 0 THEN
			ll_Len =  lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "EQUIPHEIGHT" , lstr_Parm ) <> 0 THEN
			ll_Height =  lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "EQUIPAIR" , lstr_Parm ) <> 0 THEN
			ls_Air = lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "BEHALFOF" , lstr_Parm ) <> 0 THEN
			ls_BehalfOf = lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "LEASETYPE" , lstr_Parm ) <> 0 THEN
			ll_Lease = lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "EQUIPREF" , lstr_Parm ) <> 0 THEN
			 ls_Ref =  lstr_Parm.ia_Value
		END IF
		
		ll_NewRow = lds_EquipCache.InsertRow ( 0 )
		Int	li_SetRtn
		IF ll_NewRow > 0 THEN	
			
			IF gnv_app.of_GetNextId( "equipment",ll_newid, TRUE ) = -1 THEN
			//select max(eq_id) into :ll_NewID from equipment ;
			//if sqlca.sqlcode <> 0 then 
				MessageBox ( "New Equipment" , "An error occurred while attempting to aquire a new ID for the equipment." )
			//	li_Return = -1
			//	COMMIT;
			ELSE
			//	COMMIT;
			//	IF lnv_Numerical.of_IsNullOrNotPos( ll_NewID ) THEN 
			//		ll_NewID = 10000000
			//	END IF
				
			//	ll_NewID ++


				li_SetRtn = lnv_Equipment.of_SetSource ( lds_EquipCache )
				
				
				lds_EquipCache.object.eq_id[ ll_NewRow ] = ll_NewID
				lds_EquipCache.object.oe_id[ ll_NewRow ] = ll_NewID
				li_SetRtn = lnv_Equipment.of_SetSourceRow ( ll_NewRow )
				
				
				li_SetRtn =	lnv_Equipment.of_SetNumber ( ls_ref )
				li_SetRtn =	lnv_Equipment.of_SetType ( ls_type )
				li_SetRtn =	lnv_Equipment.of_SetId ( ll_NewID )
				li_SetRtn = lnv_Equipment.of_SetStatus ( 'K' ) // active
				li_SetRtn = lnv_Equipment.of_Setleased ( 'T' ) // true
				li_SetRtn =	lnv_Equipment.of_SetLength ( ll_Len )
				li_SetRtn =	lnv_Equipment.of_SetWidth ( ll_Height )				
				li_SetRtn =	lnv_Equipment.of_SetAir ( ls_Air )
				
				li_SetRtn =	lnv_Equipment.of_SetNotes( ls_Null )
				
				li_SetRtn =	lnv_Equipment.of_SetcurEvent ( ll_Null )
				li_SetRtn =	lnv_Equipment.of_SetNextEvent ( ll_Null )
				
				
				li_SetRtn = lnv_Lease.of_SetSource ( lds_EquipCache )
				li_SetRtn = lnv_Lease.of_SetSourceRow ( ll_NewRow )
			
				li_SetRtn =	lnv_Lease.of_SetBookingNumber ( ls_BookingNum )
				li_SetRtn =	lnv_Lease.of_SetfkEquipmentLeaseType ( ll_Lease )
			   li_SetRtn =	lnv_Lease.of_SetOnBehalfOf ( ls_BehalfOf )
				
				li_SetRtn =	lnv_Lease.of_SetOriginationSite ( ll_OriginSite )
				li_SetRtn =	lnv_Lease.of_SetTerminationSite ( ll_TermSite )
				
				li_SetRtn =	lnv_Lease.of_SetShipmentID ( al_ShipID )
				
				li_SetRtn =	lnv_Lease.of_SetTimein ( ldt_Null )
				li_SetRtn =	lnv_Lease.of_SetTimeout ( ldt_Null )
				li_SetRtn =	lnv_Lease.of_SetNotes ( ls_Null )
				
				li_SetRtn =		lnv_Lease.of_Setoe_ID ( ll_NewID )
				
				//inv_Dispatch.Event pt_save ( )
				
			END IF
			
		END IF
	END IF	
	
	  
END IF

DESTROY  lds_Equip
DESTROY  lnv_Lease
DESTROY  lnv_Equipment

RETURN li_Return

end function

private function datastore of_getftesource (long ala_shipments[]);Long	ll_FTEPrimaryCount
Long	ll_FTEReloadCount

DataStore 	lds_FTE
DataStore	lds_FtePrimary
DataStore	lds_FteReload

lds_FtePrimary = CREATE DataStore
lds_FtePrimary.DataObject = "d_shipment_fte_Primary"
lds_FtePrimary.SetTransObject ( SQLCA )
	
lds_FteReload = CREATE DataStore
lds_FteReload.DataObject = "d_shipment_fte_Reload"
lds_FteReload.SetTransObject ( SQLCA )
ll_FTEPrimaryCount = lds_FtePrimary.Retrieve ( ala_Shipments[] )
ll_FTEReloadCount = lds_FteReload.Retrieve ( ala_Shipments[] )
Commit;

IF ll_FTEReloadCount > 0 THEN
	lds_FteReload.RowsMove( 1 , ll_FTEReloadCount ,  PRIMARY! , lds_FtePrimary , 999 ,PRIMARY!  )
END IF

lds_FtePrimary.SetSort ( "freetimeexpiration A" ) 
lds_FtePrimary.Sort ( ) 

DESTROY ( lds_FteReload )

RETURN lds_FtePrimary	
	
end function

on n_cst_shipmentmanager.create
call super::create
end on

on n_cst_shipmentmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;if not IsValid( sds_trip ) and not IsValid( sds_ship ) then
	sl_counter = 1
	sds_trip = create n_ds
	sds_trip.DataObject = "d_trip_list"
	sds_trip.SetTransObject( sqlca )
	sb_trips_retrieved = FALSE
	sdt_trips_refreshed = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sdt_trips_updated = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sds_ship = create n_ds
	sds_ship.DataObject = "d_shipmentcache"
	sds_ship.SetTransObject( sqlca )
	sb_ships_retrieved = FALSE
	sdt_ships_refreshed = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sdt_ships_updated = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sdt_LastShipmentCacheWrite = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	si_ships_filter = 0
	ss_ships_last_change = ""
	SetNull ( ss_ShipmentCacheFile )
	SetNull ( ss_ShipmentCacheWhereClauseExtension )
else
	sl_counter ++
end if

inv_Dispatch = CREATE n_cst_bso_Dispatch
end event

event destructor;call super::destructor;sl_counter --

//The following would destroy the caches when the last shipment manager
//instance is destroyed.  This is not what we want currently, however.

//if sl_counter = 0 then
//	Destroy sds_trip
//	Destroy sds_ship
//end if

Destroy inv_Dispatch
end event

