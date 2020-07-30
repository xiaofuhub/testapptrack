$PBExportHeader$u_cst_eventrouting_shipment.sru
$PBExportComments$Started code for chassis split and stop off
forward
global type u_cst_eventrouting_shipment from u_cst_eventrouting
end type
type cb_9 from u_cb within u_cst_eventrouting_shipment
end type
type cb_route from u_cb within u_cst_eventrouting_shipment
end type
type st_route from statictext within u_cst_eventrouting_shipment
end type
type cb_jump from commandbutton within u_cst_eventrouting_shipment
end type
type cb_select from commandbutton within u_cst_eventrouting_shipment
end type
type st_1 from statictext within u_cst_eventrouting_shipment
end type
type sle_shipnum from singlelineedit within u_cst_eventrouting_shipment
end type
type dw_shipment from u_dw within u_cst_eventrouting_shipment
end type
type dw_selection from u_dw_reflist within u_cst_eventrouting_shipment
end type
type dw_assignmentlist from u_dw_eqassignlist within u_cst_eventrouting_shipment
end type
type sle_equipment from singlelineedit within u_cst_eventrouting_shipment
end type
type cb_create from commandbutton within u_cst_eventrouting_shipment
end type
type dw_equipment from u_dw_eqlist within u_cst_eventrouting_shipment
end type
type cb_1 from commandbutton within u_cst_eventrouting_shipment
end type
type uo_ip1 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type uo_ip2 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type uo_ip3 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type uo_ip4 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type uo_ip8 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type uo_ip6 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type uo_ip5 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type uo_ip7 from u_cst_insertionpoint within u_cst_eventrouting_shipment
end type
type dw_ship_itin from u_dw_eventlist within u_cst_eventrouting_shipment
end type
end forward

global type u_cst_eventrouting_shipment from u_cst_eventrouting
integer height = 756
event ue_routemode ( )
event ue_postconstructor ( )
event type integer ue_checkselection ( boolean ab_verifychange,  boolean ab_notifynone )
event type integer ue_assignequipment ( string as_ref )
event type integer ue_clearshipment ( )
event type integer ue_refreshevents ( )
event type integer ue_displayshipment ( long al_id )
event type integer ue_linkequipment ( long al_equipmentid )
event type integer ue_newequipment ( string as_eqref )
event ue_createnewequipment ( )
event type integer ue_removeevents ( )
event type integer ue_addeventnote ( n_cst_msg anv_msg,  long ala_ids[],  n_cst_beo_shipment anv_shipment )
event ue_changestatus ( )
event type integer ue_sitemove ( long al_insertion,  string as_site,  n_cst_msg anv_msg )
event ue_splitfront ( )
event ue_splitback ( )
event ue_splitboth ( )
event type integer ue_assignlinkedequipment ( readonly string as_type,  readonly string as_ref,  readonly long al_id )
event type integer ue_assignreferencedequipment ( readonly long al_eqid )
event type integer ue_autoassignnewequipment ( long al_eqid )
event ue_mousemove pbm_mousemove
event type n_cst_beo_shipment ue_getshipment ( )
event ue_sitechanged ( )
event ue_shipmentchanged ( )
cb_9 cb_9
cb_route cb_route
st_route st_route
cb_jump cb_jump
cb_select cb_select
st_1 st_1
sle_shipnum sle_shipnum
dw_shipment dw_shipment
dw_selection dw_selection
dw_assignmentlist dw_assignmentlist
sle_equipment sle_equipment
cb_create cb_create
dw_equipment dw_equipment
cb_1 cb_1
uo_ip1 uo_ip1
uo_ip2 uo_ip2
uo_ip3 uo_ip3
uo_ip4 uo_ip4
uo_ip8 uo_ip8
uo_ip6 uo_ip6
uo_ip5 uo_ip5
uo_ip7 uo_ip7
dw_ship_itin dw_ship_itin
end type
global u_cst_eventrouting_shipment u_cst_eventrouting_shipment

type variables
Protected:
Long	il_ShipmentId
String	is_ShipmentNumber
n_cst_Ship_Type	inv_ShipTypeManager


statictext st_ip[0 to 8]
Constant Int ci_NumIP = 0

DataStore ids_orfin_events


Private:
u_cst_insertionPoint iuo_ip[ ]	
n_cst_beo_Shipment	inv_Shipment
Boolean 	ib_AllowModifyShipment
Boolean	ib_AllowModifyItin
end variables

forward prototypes
public subroutine refresh_display ()
public function integer of_displayshipment (long al_id)
public function integer of_displayevents (long al_id)
public function integer of_clearshipment ()
protected function integer of_setreferences (long al_id)
public function integer of_showip ()
public function integer of_clearip ()
public function integer of_getcoidfromcode (string as_code)
public function datastore of_getshipmentcache ()
public function dataStore of_geteventcache ()
public function datastore of_getitemcache ()
public function integer of_managesplits ()
protected function integer of_fillref1withequipment (string as_ref, string as_type)
public function string of_gettypeforreftype (integer ai_reftype)
protected function integer of_fillrefwithequipment (string as_ref, string as_type)
public function integer of_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg)
public function string of_getequipmenttype (readonly long al_EqID)
public function long of_geteqidfromcache (readonly string as_ref, readonly long ai_shipmentid)
public function integer of_refreshequipment ()
public function integer of_evaluateforreload (long al_eqid)
public function integer of_displayequipmentforshipment (long al_id)
private function integer of_resetpointers (u_cst_insertionpoint auo_exclude)
public function long of_getfirstrowonpage ()
public function integer of_getvisiblecount ()
public function integer of_insertevent (long al_insertrow)
public function n_cst_beo_Shipment of_getshipment ()
private function integer of_setenablement ()
end prototypes

event ue_routemode;//Display the insertion pointers on w_Itin, and tell it we're asking to route
//shipment events (ci_RouteRequest_Route).

w_Itin	lw_Itinerary

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN

	CHOOSE CASE This.Event ue_CheckSelection ( FALSE /*Don't verify auto-selection*/, TRUE /*Notify for None*/ )

	CASE 1  //OK

		This.Event ue_SetRouteModeIndicator ( TRUE )
	
		lw_Itinerary.show_ip()
		lw_Itinerary.whats_on = lw_Itinerary.ci_RouteRequest_Route
		lw_Itinerary.tab_type.setfocus()
//		 THIS.POST Event ue_RefreshEvents ( )
		
	//CASE 0, -1   Don't need to handle other cases.

	END CHOOSE

END IF

end event

event ue_postconstructor();w_Itin					lw_Itinerary
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_numerical		lnv_numerical
DataStore				lds_ShipmentCache
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_cst_beo_Shipment
lw_Itinerary = This.Event ue_GetItineraryWindow ( )
lnv_Dispatch = This.Event ue_GetDispatchManager ( )

if lnv_numerical.of_IsNullOrNotPos(lw_Itinerary.last_ship) then return

/////////////////////
//Added 3.0.02, to deal with the fact that lw_Itinerary.last_ship can now be non-routed.
IF IsValid ( lnv_Dispatch ) THEN
	lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )
END IF

lnv_Shipment.of_SetSource ( lds_ShipmentCache )
lnv_Shipment.of_SetSourceId ( lw_Itinerary.last_ship )

IF lnv_Shipment.of_IsRoutable ( ) THEN
	//It's routable -- proceed
ELSE
	//It's not routable -- don't load it.
	RETURN
END IF
/////////////////////


This.of_DisplayShipment ( lw_Itinerary.Last_Ship )

DESTROY ( lnv_Shipment )
end event

event ue_checkselection;//Returns : 1 if there are rows selected and those rows are approved, 0 if there are no 
//rows or user cancelled (didn't approve), -1 if an error occurs.

Long		ll_Row
//Boolean	lb_SelectionMade
String	ls_MessageHeader = "Event Selection"

Integer	li_Return = 1

//If no rows are selected but there are rows in the dw, see if we can make a selection.
//(If rows are already selected in the dw, just go with that selection.)

IF dw_Ship_Itin.GetSelectedRow ( 0 ) = 0 THEN

	ll_Row = dw_Ship_Itin.GetRow ( )

	CHOOSE CASE ll_Row

	CASE IS > 0

		dw_Ship_Itin.SelectRow ( ll_Row, TRUE )

		IF ab_VerifyChange THEN

			IF MessageBox ( ls_MessageHeader, "OK to route the selected events?", &
				Question!, OKCancel! ) = 1 THEN

				//OK

			ELSE

				//User cancelled.  Flag it in the return value.
				li_Return = 0

			END IF

		END IF

//	ll_RowCount = dw_Ship_Itin.RowCount ( )
//
//	CHOOSE CASE ll_RowCount
//
//	CASE IS > 0
//
//		//There are rows in the dw.  Loop through them and select any that have not
//		//been routed.
//
//		lb_SelectionMade = FALSE
//
//		FOR ll_Row = 1 TO ll_RowCount
//
//			IF IsNull ( dw_Ship_Itin.Object.de_Trailer [ ll_Row ] ) AND &
//				IsNull ( dw_Ship_Itin.Object.de_ArrDate [ ll_Row ] ) THEN
//
//				//Event has not been routed.  Select it.
//				dw_Ship_Itin.SelectRow ( ll_Row, TRUE )
//				lb_SelectionMade = TRUE
//
//			END IF
//			
//		NEXT
//
//		IF lb_SelectionMade = FALSE THEN
//
//			//All the events were already routed.  Select them all.
//			dw_Ship_Itin.SelectRow ( 0, TRUE )
//			lb_SelectionMade = TRUE
//
//		END IF
//
//		//Since there's currently no way to avoid making the change above, 
//		//I won't handle lb_SelectionMade = FALSE here.
//
//		IF ab_VerifyChange THEN
//
//			IF MessageBox ( ls_MessageHeader, "OK to route the selected events?", &
//				Question!, OKCancel! ) = 1 THEN
//
//				//OK
//
//			ELSE
//
//				//User cancelled.  Flag it in the return value.
//				li_Return = 0
//
//			END IF
//
//		END IF


	CASE 0

		//There are no rows in the dw.

		li_Return = 0

		IF ab_NotifyNone THEN
			MessageBox ( ls_MessageHeader, "There are no events available." )
		END IF

	CASE ELSE  //Error, unexpected return

		li_Return = -1
		MessageBox ( ls_MessageHeader, "Error processing event selection." )

	END CHOOSE

END IF


RETURN li_Return
end event

event ue_assignequipment;//Returns : 1, -1

//Return -1 unless overridden and implemented in the descendant.

RETURN -1
end event

event ue_clearshipment;//Returns : 1, -1

Long		ll_Null
SetNull ( ll_Null )

Integer	li_Return = 1


IF li_Return = 1 THEN

	//Forward the request to of_ClearShipment.
	IF This.of_ClearShipment ( ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF


//Provide error notification if not successful.

IF li_Return = -1 THEN

	MessageBox ( "Clear Shipment Selection", "Error attempting to clear display.  Request cancelled." )

END IF


RETURN li_Return
end event

event ue_refreshevents;String	ls_ErrorMessage = "Could not refresh event list.  "

Integer	li_Return = 1


IF li_Return = 1 THEN

	//Screen for null id.  Would not be a problem to make the call with null, but it's not necessary.

	IF IsNull ( il_ShipmentId ) THEN

		//No action needed.

	ELSEIF	il_ShipmentID > 0 THEN

		CHOOSE CASE This.of_DisplayEvents ( il_ShipmentId )
	
		CASE 1
			//OK
	
		CASE 0
			ls_ErrorMessage += "The selected shipment has been deleted "+&
				"in this window, and is not available for display."
			li_Return = -1
	
		CASE -1
			ls_ErrorMessage += "Could not retrieve shipment information from database."
			li_Return = -1
	
		CASE -2
			ls_ErrorMessage += "Information on the selected shipment has been modified "+&
				"since it was originally retrieved for this window.  This may cause conflicts "+&
				"in saving your changes.  You should attempt to save now, before continuing."
			li_Return = -1
	
		CASE ELSE
			//Go with baseline error message.
			li_Return = -1
	
		END CHOOSE


	END IF

END IF


IF li_Return < 1 AND Len ( ls_ErrorMessage ) > 0 THEN

	ls_ErrorMessage += "~n~nThe current shipment selection will be cleared."
	MessageBox ( "Refresh Display -- Shipment Routing", ls_ErrorMessage, Exclamation! )

END IF


RETURN li_Return
end event

event type integer ue_displayshipment(long al_id);String	ls_ErrorMessage

Integer	li_Return = 1


IF li_Return = 1 THEN

	CHOOSE CASE This.of_DisplayShipment ( al_Id )

	CASE 1
		//OK
		//dw_assignmentlist.Retrieve ( al_id )
		
		
	CASE 0
		ls_ErrorMessage = "The shipment you have selected has been deleted "+&
			"in this window, and is not available for display.~n~nRequest cancelled."
		li_Return = 0

	CASE -1
		ls_ErrorMessage = "Could not retrieve shipment information from "+&
			"database.~n~nRequest cancelled."
		li_Return = -1

	CASE -2
		ls_ErrorMessage = "Information on this shipment has been modified "+&
			"since it was originally retrieved for this window.  This may cause conflicts "+&
			"in saving your changes.  You should attempt to save now, before continuing.~n~n"+&
			"The shipment selection request is cancelled."
		li_Return = -2

	CASE ELSE
		ls_ErrorMessage = "Error attempting to display shipment information.~n~n"+&
			"Request cancelled."
		li_Return = -1


	END CHOOSE

END IF


IF li_Return < 1 AND Len ( ls_ErrorMessage ) > 0 THEN

	MessageBox ( "Shipment Routing", ls_ErrorMessage, Exclamation! )

END IF

// If we have a shipment then allow them to link equipment
//cb_Create.Enabled = li_Return = 1

RETURN li_Return
end event

event ue_linkequipment;Int	li_Return = -1

IF il_ShipmentID > 0 AND al_equipmentid > 0 THEN
	li_Return = 1
END IF

IF li_Return = 1 THEN

	UPDATE "outside_equip"  
	SET "shipment" = :il_ShipmentID  
	WHERE "outside_equip"."oe_id" = :al_equipmentid ;
	
	IF sqlca.sqlcode <> 0 then
		rollback;
		li_Return = -1
	ELSE
		COMMIT;
	END IF
END IF

RETURN li_Return
end event

event type integer ue_newequipment(string as_eqref);Long			ll_ShipmentID
Integer		li_Return = 1
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm
s_Eq_Info	lstr_Equipment

IF il_ShipmentID > 0 THEN
	ll_ShipmentID = il_ShipmentID
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN

	lstr_Equipment.eq_type = "34"
	
	//Indicate that we want to pass info out, not save.
	lstr_Equipment.eq_Id = 0  //Null = Pass info out, don't save ;  0 = Save new equipment
	lstr_Equipment.eq_ref = as_eqref
	
	
	lstr_Parm.is_Label = "EQSTRUCT" 
	lstr_Parm.ia_Value = lstr_Equipment
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "SHIPMENT" 
	lstr_Parm.ia_Value =  ll_ShipmentID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	//DEK 5-22-07
	lstr_Parm.is_Label = "SHIPMENTBEO"
	lstr_Parm.ia_Value =  this.event ue_getshipment( )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
	openwithparm(w_eq_newout, lnv_Msg )
	lstr_Equipment = message.powerobjectparm
	
	IF lstr_Equipment.eq_id = 0 THEN
		li_Return = 0 //0 indicates cancel; id is null if info was specified
	ELSE
		THIS.Event ue_AutoAssignNewEquipment ( lstr_Equipment.eq_id )
		IF THIS.of_FillRefWithEquipment ( lstr_Equipment.eq_ref , lstr_Equipment.eq_Type ) = 1 THEN
		//	THIS.of_DisplayShipment ( il_ShipmentID ) 
			sle_Equipment.Text = ""
		ELSE
	 	    //Event ue_AssignEquipment ( lstr_Equipment.eq_ref )
		END IF
	END IF
	

END IF


RETURN li_Return
end event

event ue_createnewequipment();String		ls_Where
String		ls_Text
String		ls_CDerror
String		ls_Dupes
String		ls_FindString
String		ls_Type
String		lsa_Dupes[]
Long			ll_EqId
Long			i
Long			ll_DupCount
Long			ll_FindRow
Long			ll_Shipment
Int			li_Rtn	= 1
Int			li_NewRtn

DataStore					lds_Results
n_cst_EquipmentManager	lnv_Manager
n_cst_bso_Dispatch		lnv_Dispatch
n_ds							lds_EquipmentCache

ls_Text = TRIM ( sle_equipment.Text ) 

//Validate Check digit on containers
IF UPPER(Mid(ls_Text, 4, 1)) = "U" THEN //4th letter 'U' denotes container
	IF lnv_Manager.of_ValidateCheckDigit(ls_Text, ls_CDerror) <> 1 THEN
		MessageBox ("Equipment Validation" , ls_CDerror )
		li_Rtn = 0 //Cancel
	END IF
END IF
 
IF Len ( ls_Text ) > 0 AND li_Rtn = 1 THEN

	/*OLD DUPE CHECK
	ls_Where = "WHERE eq_Status = ~~'K~~' AND eq_ref = ~~'" + ls_Text + "~~'"
	lnv_Manager.of_Retrieve (  lds_Results ,ls_Where )
	
	CHOOSE CASE lds_Results.RowCount()...
	*/
	
	/*NEW DUPE CHECK 4/03/07*/
	
	lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
	IF IsValid ( lnv_Dispatch ) THEN
		lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )
		IF NOT IsValid(lds_EquipmentCache) THEN
			li_Rtn = -1
		END IF
	ELSE
		li_Rtn = -1
	END IF
	
	IF li_Rtn = 1 THEN
		ll_EqId = lnv_Manager.of_ExistsEquipment(ls_Text, lds_EquipmentCache, lsa_Dupes) 
		CHOOSE CASE ll_EqId
				
			CASE 0 // EQUIPMENT DNE
				
				// CREATE new Linked Equipment
				li_NewRtn = THIS.Event ue_NewEquipment ( ls_Text )
				IF  li_NewRtn = -1 THEN
					MessageBox ( "New Equipment" , "An error occurred while attempting to create a new piece of equipment." )
					li_Rtn = -1
				ELSEIF li_NewRtn = 0 THEN  // user canceled
					li_Rtn = 0
				ELSE
					// event above will assign the equipment
				END IF
				
				
			CASE IS > 0 //Exists
				
				//Get the linked status and type from the cache or db
				ls_FindString = "eq_ref = '" + ls_Text + "' AND eq_status = 'K'"
				ll_FindRow = lds_EquipmentCache.Find(ls_FindString, 1, lds_EquipmentCache.RowCount())
				IF ll_FindRow > 0 THEN
					ll_Shipment = lds_EquipmentCache.object.equipmentLease_Shipment [ll_FindRow]
					ls_Type = lds_EquipmentCache.object.eq_type[ll_FindRow]
				ELSE
					SELECT "Shipment"
					INTO :ll_Shipment 
					FROM "outside_equip" 
					WHERE "outside_equip"."oe_id" = :ll_EqId;
					COMMIT;
					
					SELECT "eq_type"
					INTO :ls_Type
					FROM "equipment" 
					WHERE "equipment"."eq_id" = :ll_EqId;
					COMMIT;
					
				END IF
				
				//Linking/Reload logic
				IF isNull(ll_Shipment) THEN
					IF MessageBox ( "Specified Equipment" , "A piece of equipment already exists " + & 
						+"with the reference number you sepcifed. However the equipment is not currently" + &
						" associated to a shipment.~r~n~r~nClick OK to use this equipment and to link it " + &
						"to this shipment.  OR~r~nClick Cancel to stop the processing.", INFORMATION! , OKCANCEL! , 1 ) = 1 THEN
						// use the equipment		
						
						// NEED TO DO AN UPDATE ON THE EQUIPMENT HERE
						IF THIS.Event ue_LinkEquipment ( ll_EqId ) <> 1 THEN
							MessageBox ( "Linking Equipment" , "An error occurred while attempting to link the existing piece of equipment to this shipment." )
							li_Rtn = -1
						ELSE
							THIS.Event ue_AutoAssignNewEquipment ( ll_EqId )
							THIS.of_FillRefWithEquipment (  ls_Text , ls_Type )
						END IF
						
					ELSE 
						// stop the processing
						li_Rtn = -1
					END IF
					
				ELSE // The equipment is linked to a shipment
					
					IF THIS.of_EvaluateForReload ( ll_EqId ) = 1 THEN
						THIS.of_FillRefWithEquipment (  ls_Text , ls_Type )
						THIS.Event ue_AutoAssignNewEquipment ( ll_EqId )
					END IF
					
	//				IF MessageBox ( "Specified Equipment" , "A piece of equipment already exists " + & 
	//					+"with the reference number you sepcifed. In addition the equipment is " + &
	//					+"linked to shipment " + String ( lds_Results.object.equipmentLease_Shipment [ 1 ] ) + &
	//					+" and can not be created again. Do you want to cancel and view this shipment now?" , QUESTION! , YESNO! , 2 ) = 1 THEN
	//					// display the shipment
	//					THIS.Event ue_DisplayShipment ( lds_Results.object.equipmentLease_Shipment [ 1 ] )
	//					li_Rtn = -1
	//				ELSE
	//					// stop the processing
	//					li_rtn = -1
	//					
	//				END IF
					
				END IF
				
			CASE -2 // MULTIPLES FOUND   /// I WILL NEED TO FURTHER THE PROCESSING HERE
				
				ll_DupCount = UpperBound(lsa_Dupes)
				FOR i = 1 TO ll_DupCount
					ls_Dupes += lsa_dupes[i] + "~r~n"
				NEXT
				MessageBox("Specified Equipment" , "Multiple pieces of equipment exist with the specified number. Processing will stop.~r~n" + & 
							  "Duplicate reference numbers:~r~n" + ls_Dupes, INFORMATION! )
				li_Rtn = -1
			CASE ELSE
				//Error
				
		END CHOOSE 
		
		IF li_Rtn = 1 THEN
			THIS.of_DisplayEquipmentForShipment ( il_ShipmentID )
			//dw_assignmentlist.Retrieve ( il_ShipmentID )
			sle_equipment.Text = ""
		END IF
		
	END IF
	
ELSE 
	//THIS.Event ue_ClearEquipmentSelection ( )
	//li_Rtn = -1
END IF


DESTROY lds_Results
end event

event type integer ue_removeevents();Long	ll_SelectedRow
Long	lla_Ids[]
Int	li_Return
dataStore	lds_Shipment
DataStore	lds_Events
DataStore	lds_Items
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnva_Errors[]
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.event ue_getshipment( )
lnv_Dispatch = This.Event ue_GetDispatchManager ()

lds_Shipment = lnv_Dispatch.of_GetShipmentCache ( )
lds_Events = lnv_Dispatch.of_GetEventCache ( )
lds_Items = lnv_Dispatch.of_GetItemCache ( )

lnv_Shipment.of_SetSource ( lds_Shipment )
lnv_Shipment.of_SetSourceID ( il_ShipmentId )
lnv_Shipment.of_SetEventSource ( lds_Events )
lnv_Shipment.of_SetItemSource ( lds_Items )
	
ll_SelectedRow = 0 

//Modified 2-7-07 to use new Priv if the shipment is billed
String ls_privFunction

IF lnv_shipment.of_isbilled( ) THEN
	ls_privFunction = appeon_constant.cs_ModifyBilledShip
ELSE
	ls_privFunction = "ModifyShipment"
END IF	
//////////////////////////

IF gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, lnv_Shipment ) = appeon_constant.ci_True THEN
	
	DO 
		
		ll_SelectedRow = dw_ship_itin.GetSelectedRow ( ll_SelectedRow )
		IF ll_SelectedRow > 0 THEN
			lla_Ids [ UpperBound ( lla_IDs ) + 1 ] =  dw_ship_itin.object.de_id[ll_SelectedRow]
		END IF
	LOOP WHILE ll_SelectedRow > 0
	
	IF UpperBound ( lla_IDs ) = 0 THEN  // try for the selected row
		IF dw_ship_itin.GEtRow () > 0 THEN
			dw_ship_itin.SelectRow ( dw_Ship_Itin.GEtRow () , TRUE )
			lla_IDs [ 1 ] = dw_ship_itin.object.de_id[dw_Ship_Itin.GEtRow ()]
			dw_ship_itin.SelectRow ( dw_ship_itin.GEtRow () , TRUE )
		END IF
	END IF
	
	IF UpperBound ( lla_Ids ) > 0 THEN
		IF messagebox("Delete Event", "Okay to delete the selected event(s)?", question!, okcancel!, 2) = 1 then
		
			lnv_Shipment.of_RemoveEvents ( lla_IDs , lnv_Dispatch )
			THIS.Event ue_DisplayShipment ( il_ShipmentID )
			dw_ship_itin.SelectRow ( 0 , FALSE )
			li_Return = 1
		END IF
	END IF
END IF

RETURN li_return 
end event

event ue_addeventnote;Any		la_Value
String	ls_Event
String	ls_Note
String 	ls_Existing
Long		ll_ID
Long		i
Long		ll_Count

S_Parm	lstr_parm

w_eventNoteWizard 	lw_eventNoteWizard 
n_cst_EventNote	lnv_EventNote
n_cst_Settings	lnv_Settings
n_cst_beo_Event	lnva_EventList[]
n_cst_beo_Event	lnv_Event


anv_Shipment.of_GetEventList ( lnva_EventList )
ll_Count = UpperBound  ( lnva_EventList )
	
IF anv_Msg.of_Get_Parm ( "EVENT" , lstr_Parm ) <> 0 THEN
	ls_Event = lstr_Parm.ia_Value
END IF

lnv_Settings.of_GetSetting ( 86 , la_Value )

IF String ( la_Value )  =  "YES!" THEN

	CHOOSE CASE UPPER ( ls_Event )
			
		CASE "CHASSIS"
			IF UpperBound ( ala_ids ) > 0 THEN
				ll_ID = ala_ids [ UpperBound ( ala_ids ) ]
			END IF
		
		CASE "YARD"
			IF UpperBound ( ala_ids ) > 0 THEN
				ll_ID = ala_ids [ 1 ]
			END IF
			
	END CHOOSE
	
	FOR i = 1 TO ll_Count
		IF lnva_EventList [ i ].of_GetID ( ) = ll_ID THEN
			lnv_Event = lnva_EventList [ i ]
			lnv_Event.of_SetAllowFilterSet ( TRUE )
			dw_ship_itin.SetRow ( lnv_Event.of_GetShipSeq () )
			EXIT 
		END IF
	NEXT


	OpenWithParm ( lw_eventNoteWizard , ls_Event )
	lnv_EventNote = Message.PowerobjectParm
	
	IF IsValid ( lnv_EventNote ) THEN  
		ls_Note = lnv_EventNote.of_GetNote ( )
		
		IF Len ( ls_Note ) > 0 THEN			
			ls_Existing	= lnv_Event.of_GetNote ( )
			
			If IsNull ( ls_Existing ) THEN
				lnv_Event.of_SetNote ( ls_Note )
			ELSE
				
				IF lnv_EventNote.of_Append ( ) THEN
					lnv_Event.of_SetNote ( ls_Existing + "~r~n"+ls_Note )
				ELSE
					lnv_Event.of_SetNote ( ls_Note + "~r~n" + ls_Existing )
				END IF
				
			END IF
		END IF
	END IF
	
	
	DESTROY lnv_eventNote

			
END IF


FOR i = 1 TO ll_Count 
	DESTROY ( lnva_EventList[ i ] )
NEXT
DESTROY ( anv_shipment )

RETURN 1
end event

event ue_changestatus();n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Dispatch = This.Event ue_GetDispatchManager ( )
lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache(  ) )
lnv_Shipment.of_SetSourceId ( il_ShipmentID )
lnv_Shipment.of_SetAllowFilterSet ( TRUE )

lnv_Shipment.of_SetEventSource (  lnv_Dispatch.of_GetEventCache ( ) )
lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )

IF lnv_Shipment.of_ChangeStatus ( lnv_Dispatch  ) = 1 THEN
	
END IF

DESTROY lnv_Shipment
end event

event type integer ue_sitemove(long al_insertion, string as_site, n_cst_msg anv_msg);String	ls_SelectedType
Long		ll_SiteID
Long		lla_NewIds[]
Long		ll_InsertionPoint
Boolean	lb_Continue = TRUE, &
			lb_backsplit, &
			lb_frontsplit
Int		li_Return = 1

S_PArm	lstr_Parm

n_Cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch


ll_InsertionPoint	= al_insertion
ls_SelectedType	= as_site
lnv_Dispatch 	= THIS.Event ue_GetDispatchManager ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

//lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
//lnv_Shipment.of_SetSourceID ( il_ShipmentID )

//lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
//lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )

lstr_Parm.is_Label = "ROWCOUNT"
lstr_Parm.ia_Value = dw_ship_itin.RowCount ( )
anv_msg.of_Add_Parm ( lstr_Parm )

ll_SiteID = of_GetCoIDfromCode ( ls_SelectedType ) 
IF ll_SiteID = -1  THEN
	IF MessageBox ( "New Site" , "The company reference could not be resolved. Do you want to continue anyway?" , QUESTION! , YESNO! , 2 ) = 2 THEN
		lb_Continue = FALSE
	END IF
END IF

IF lb_Continue THEN
	 IF lnv_Shipment.of_AddSiteMove ( ll_SiteID , ll_insertionPoint , lnv_Dispatch , lla_NewIds, anv_msg ) = 1 THEN
				
		if anv_msg.of_get_parm("SPLITBACK", lstr_parm) <> 0 then
			lb_backsplit = lstr_parm.ia_value
		end if
		if anv_msg.of_get_parm("SPLITFRONT", lstr_parm) <> 0 then
			lb_frontsplit = lstr_parm.ia_value
		end if

		if lb_backsplit then
			lnv_Shipment.of_AddBackChassisSplitItem ( lnv_Dispatch ) 
		end if
		if lb_frontsplit then
			lnv_Shipment.of_AddFrontChassisSplitItem ( lnv_Dispatch ) 
		END IF
		
		Any	la_Value 	
		n_Cst_Settings	lnv_Settings	
		lnv_Settings.of_GetSetting ( 86 , la_Value )
		IF String ( la_Value )  =  "YES!" THEN
			dw_ship_itin.Post Event ue_AddEventNote (  ll_insertionPoint , "CHASSIS") 
		END IF
		
	 END IF
	
	THIS.Event ue_DisplayShipment ( il_ShipmentID )
//	IF lnv_Shipment.of_AddSiteMove ( ll_SiteID , ll_InsertionPoint, lnv_Dispatch , lla_NewIds , anv_msg) = 1 THEN
//		THIS.Event ue_DisplayShipment ( il_ShipmentID )
//	ELSE
//		li_Return = -1
//	END IF
END IF


RETURN li_Return		
end event

event ue_splitfront;String	ls_SelectedType
Long		ll_InsertionPoint
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

ll_insertionPoint = 1
ls_SelectedType = String ( Message.LongParm , "address" )

lstr_Parm.is_Label = "SPLITFRONT"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "SPLITBACK"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

THIS.Event ue_SiteMove ( ll_insertionPoint , ls_SelectedType , lnv_Msg )
end event

event ue_splitback();String	ls_SelectedType
Long		ll_SiteID
Long		lla_NewIds[]
Long		ll_InsertionPoint
Boolean	lb_Continue = TRUE
n_cst_msg	lnv_Msg
S_parm		lstr_Parm
n_Cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch


lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( ) 


//lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
//lnv_Shipment.of_SetSourceID ( il_ShipmentID )

//lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
//lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )

ll_InsertionPoint = lnv_Shipment.of_GetEventCount ( ) 
ll_InsertionPoint ++
ls_SelectedType = String ( Message.LongParm , "address" )


lstr_Parm.is_Label = "SPLITBACK"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "SPLITFRONT"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )


THIS.Event ue_SiteMove ( ll_InsertionPoint , ls_SelectedType , lnv_Msg )
end event

event ue_splitboth();String	ls_SelectedType
Long		ll_SiteID
Long		lla_NewIds[]
Long		ll_InsertionPoint
Boolean	lb_Continue = TRUE
n_cst_msg	lnv_Msg
S_parm		lstr_Parm
n_Cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Dispatch = THIS.Event ue_GetDispatchManager ( ) 

lnv_Shipment = THIS.Event ue_GetShipment ( )

//lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
//lnv_Shipment.of_SetSourceID ( il_ShipmentID )

//lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
//lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )

ll_InsertionPoint = lnv_Shipment.of_GetEventCount ( ) 
ll_InsertionPoint ++
ls_SelectedType = String ( Message.LongParm , "address" )


lstr_Parm.is_Label = "SPLITBACK"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "SPLITFRONT"
lstr_Parm.ia_Value = TRUE
lnv_Msg.of_Add_Parm ( lstr_Parm )


THIS.Event ue_SiteMove ( ll_InsertionPoint , ls_SelectedType , lnv_Msg )

end event

event type integer ue_autoassignnewequipment(long al_eqid);n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_Event		lnva_Events[]
n_Cst_AnyArraySrv		lnv_Array

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Shipment = THIS.Event ue_GetShipment ( )


lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN
//	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ))
//	lnv_SHipment.of_SetSourceID ( il_ShipmentId )
//	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( )) 
	
	lnv_Dispatch.of_RetrieveEquipmentForShipment ( il_ShipmentId )
	
	lnv_Equipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) )
	lnv_Equipment.of_SetSourceID ( al_eqid )
	
	
	IF lnv_Shipment.of_HasSource ( ) THEN
		lnv_Shipment.of_GetRoutedEvents ( lnva_Events )
		lnv_Dispatch.of_AssessEquipmentAssignment ( {lnv_Equipment} , lnva_Events , lnv_SHipment )
	END IF
	
END IF
lnv_Array.of_Destroy ( lnva_Events )

DESTROY ( lnv_Equipment )

RETURN 1
end event

event ue_mousemove;u_cst_InsertionPoint	lnv_Dummy

THIS.of_ResetPointers ( lnv_Dummy )


end event

event type n_cst_beo_shipment ue_getshipment();n_cst_bso_Dispatch	lnv_disp
lnv_Disp = THIS.Event ue_GetDispatchmanager ( )
IF isValid ( lnv_disp ) THEN
	
	lnv_Disp.of_Retrieveshipment( il_shipmentid )
	inv_SHipment.of_SetAllowFilterSet ( TRUE ) 
	inv_SHipment.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) )
	inv_SHipment.of_SetSourceID ( il_shipmentid )
	inv_SHipment.of_SetItemSource ( lnv_Disp.of_GetItemcache( ) )
	inv_SHipment.of_SetEventSource ( lnv_Disp.of_GetEventcache( ) )
	inv_Shipment.of_SetContext( lnv_Disp )
		
END IF

RETURN inv_shipment

end event

public subroutine refresh_display ();w_Itin	lw_Itinerary
n_cst_bso_Dispatch	lnv_Dispatch
Long		ll_ShipmentId

lw_Itinerary = This.Event ue_GetItineraryWindow ( )
lnv_Dispatch = This.Event ue_GetDispatchManager ( )
ll_ShipmentId = This.il_ShipmentId

if IsNull ( ll_ShipmentId ) then
	return
end if




integer result
result = lw_Itinerary.get_ships( {ll_ShipmentId} )
if result < 1 then
	if result < 0 then messagebox("Shipment Itinerary", "Could not refresh display."+&
		"~n~nDisplay will be cleared.", exclamation!)
	is_ShipmentNumber = ""
	sle_shipnum.text = ""
	dw_ship_itin.reset()
	lw_Itinerary.last_ship = 0
	SetNull ( ll_ShipmentId )
	return
end if

long selrow, selid
selrow = dw_ship_itin.getrow()
if selrow > 0 then selid = dw_ship_itin.object.de_id[selrow]

dw_ship_itin.setredraw(false)

dw_ship_itin.reset()

integer shiprows
shiprows = lw_Itinerary.ds_ship_itin.rowcount()

if shiprows > 0 then
	dw_ship_itin.object.data.primary = lw_Itinerary.ds_ship_itin.object.data.primary
	lw_Itinerary.ds_ship_itin.reset()
	dw_ship_itin.sort()
	if selid > 0 then
		selrow = dw_ship_itin.find("de_id = " + string(selid), 1, shiprows)
		if selrow > 0 then dw_ship_itin.scrolltorow(selrow)
	end if
end if

dw_ship_itin.setredraw(true)
end subroutine

public function integer of_displayshipment (long al_id);//Note : al_Id = Null will be interpreted as a request to clear the current selection.

//Returns : 1, 0, -1, -2  (The dispatch retrieval return codes.)

Integer	li_Result
Long		ll_SourceRow, &
			lla_RequiredShipTypes[]
dwBuffer	le_SourceBuffer
dwObject	ldwo_ShipType
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
DataStore				lds_ShipmentCache

Integer	li_Return = 1

IF li_Return = 1 THEN
	lnv_Shipment = CREATE n_cst_beo_Shipment
	
	IF NOT IsValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Dispatch = This.Event ue_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lds_ShipmentCache = lnv_Dispatch.of_GetShipmentCache ( )

	IF NOT IsValid ( lds_ShipmentCache ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	li_Result = This.of_DisplayEvents ( al_Id )

	CHOOSE CASE li_Result

	CASE 1
		//Success

	CASE 0, -1, -2
		li_Return = li_Result

	CASE ELSE
		//Unexpected return.
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND NOT IsNull ( al_Id ) THEN

	dw_Shipment.Reset ( )

	lnv_Shipment.of_SetSource ( lds_ShipmentCache )
	lnv_Shipment.of_SetSourceId ( al_Id )

	IF lnv_Shipment.of_GetSourceRow ( ll_SourceRow, le_SourceBuffer, FALSE /*Don't Create*/ ) = 1 THEN

		IF lds_ShipmentCache.RowsCopy ( ll_SourceRow, ll_SourceRow, le_SourceBuffer, &
			dw_Shipment, 9999, Primary! ) = 1 THEN

			dw_Shipment.SetItemStatus ( 1, 0, Primary!, DataModified! )
			dw_Shipment.SetItemStatus ( 1, 0, Primary!, NotModified! )

			ldwo_ShipType = dw_Shipment.Object.ds_ship_type
			lla_RequiredShipTypes[1] = dw_Shipment.Object.ds_ship_type[1]
			
			inv_ShipTypeManager.of_Populate ( ldwo_ShipType, "ALL", TRUE, &
				lla_RequiredShipTypes)
			
			DESTROY ldwo_ShipType


		END IF

	END IF
	
	//Modified 2-7-07 to use new Priv Function if the shipment is billed
	String	ls_privFunction
	IF lnv_Shipment.of_isBilled( ) THEN
		ls_privFunction = appeon_constant.cs_ModifyBilledShip
	ELSE
		ls_privFunction = "ModifyShipment"
	END IF
	//////////////////////
	CHOOSE CASE gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, lnv_Shipment )
	
		CASE appeon_constant.ci_FALSE
			ib_allowmodifyshipment = FALSE
			
		CASE ELSE
			ib_allowmodifyshipment = TRUE
	END CHOOSE
	
	CHOOSE CASE gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary" , lnv_Shipment )
	
		CASE appeon_constant.ci_FALSE
			ib_allowmodifyitin = FALSE
			
		CASE ELSE
			ib_allowmodifyitin = TRUE
	END CHOOSE
	
	THIS.of_setenablement( )
	
END IF


IF li_Return = 1 THEN

	//Update the references that record what shipment we're looking at.
	This.of_SetReferences ( al_Id )
	THIS.of_DisplayEquipmentForShipment ( al_ID )
	//dw_assignmentlist.of_SetCache ( lnv_Dispatch, al_id )
	//dw_assignmentlist.Retrieve ( al_Id )
	
ELSE

	//Restore the previous shipment references, in case it had been changed in the attempt.
	This.of_SetReferences ( il_ShipmentId )

END IF

// If we have a shipment then allow them to link equipment
cb_Create.Enabled = li_Return = 1

dw_ship_itin.SetFocus ( )

DESTROY ( lnv_Shipment )

THIS.Event ue_ShipmentChanged ( )

RETURN li_Return
end function

public function integer of_displayevents (long al_id);//Note : al_Id = Null is a valid request, and will be carried out by clearing the event display.

//Returns : 1, 0, -1, -2  (The dispatch retrieval return set)


Integer	li_Result
Long		ll_CurrentRow, &
			ll_EventId, &
			ll_RowCount
w_Itin	lw_Itinerary

Boolean	lb_Finished = FALSE  //Used to flag whether we finish early, because of null al_Id
Integer	li_Return = 1


IF li_Return = 1 AND lb_Finished = FALSE THEN

	IF IsNull ( al_Id ) THEN
		dw_Ship_Itin.Reset ( )
		lb_Finished = TRUE
	END IF

END IF


IF li_Return = 1 AND lb_Finished = FALSE THEN

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )

	IF NOT IsValid ( lw_Itinerary ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 AND lb_Finished = FALSE THEN

	li_Result = lw_Itinerary.Get_Ships ( { al_Id } )

	CHOOSE CASE li_Result

	CASE 1
		//OK

	CASE 0, -1, -2
		li_Return = li_Result

	CASE ELSE
		//Unexpected return value
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 AND lb_Finished = FALSE THEN

	ll_CurrentRow = dw_ship_itin.getrow()
	IF ll_CurrentRow > 0 THEN
		ll_EventId = dw_ship_itin.object.de_id[ll_CurrentRow]
	END IF
	
	dw_ship_itin.setredraw(false)
	dw_ship_itin.reset()
	
	ll_RowCount = lw_Itinerary.ds_ship_itin.rowcount()
	
	if ll_RowCount > 0 then
		dw_ship_itin.object.data.primary = lw_Itinerary.ds_ship_itin.object.data.primary
		lw_Itinerary.ds_ship_itin.reset()
		dw_ship_itin.sort()
		if ll_EventId > 0 then
			ll_CurrentRow = dw_ship_itin.find("de_id = " + string(ll_EventId), 1, ll_RowCount)
			if ll_CurrentRow > 0 then dw_ship_itin.scrolltorow(ll_CurrentRow)
		end if
	end if
	
	dw_ship_itin.setredraw(true)

END IF

IF li_Return = 1 THEN
	THIS.of_showip( )
ELSE
	THIS.of_Clearip( )
END IF

//n_cst_bso_Dispatch	lnv_Dispatch	
//lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
//
//lnv_Dispatch.of_RetrieveShipment( al_id )
//lnv_Dispatch.of_filterShipment( al_id )
//MessageBox ( "A" , lnv_Dispatch.of_GetShipmentcache( ).ShareData( dw_Ship_itin  ) )
//




RETURN li_Return
end function

public function integer of_clearshipment ();//Returns : 1, -1

Long		ll_Null
SetNull ( ll_Null )

Integer	li_Return = 1


IF li_Return = 1 THEN

	//Forward the request to of_DisplayShipment.
	IF This.of_DisplayShipment ( ll_Null ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF


RETURN li_Return
end function

protected function integer of_setreferences (long al_id);w_Itin	lw_Itinerary

Integer	li_Return = 1


IF li_Return = 1 THEN

	//Update the internal references.

	IF IsNull ( al_Id ) THEN
		is_ShipmentNumber = ""
	ELSE
		is_ShipmentNumber = String ( al_Id )		
	END IF

	sle_Shipnum.Text = is_ShipmentNumber
	il_ShipmentId = al_Id


	//Update the reference on the itinerary window, if we have access to it.

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )

	IF IsValid ( lw_Itinerary ) THEN

		IF IsNull ( al_Id ) THEN
			//Using "0" here because that's what the old code did -- maybe look into null?
			lw_Itinerary.last_ship = 0
		ELSE
			lw_Itinerary.last_ship = al_Id
		END IF

	END IF


END IF


RETURN li_Return
end function

public function integer of_showip ();Long	ll_RowCount
Long	ll_Return = 1
Long	ll_FirstRowOnPage
Int	li_IPCount
Int	li_i
Int	li_VisibleCount
u_cst_InsertionPoint luo_IP


li_IPCount = UpperBound ( iuo_ip[] )
li_VisibleCount = THIS.of_GetVisibleCount ( ) 
IF li_VisibleCount > 0 THEN   //  this takes care of not showing the first
	li_VisibleCount ++  			//  ip unless there is a shipment being 
END IF								//  displayed
	
ll_FirstRowOnPage = THIS.of_GetFirstRowOnPage (  )
IF ll_FirstRowOnPage = 0 THEN
	ll_FirstRowOnPage = 1
END IF

FOR li_i = 1 TO li_IPCount
	iuo_ip[ li_i ].of_SetVisible ( li_i <= li_VisibleCount )
	iuo_IP[ li_i ].of_AssignNumber ( ll_FirstRowOnPage ) 
	ll_FirstRowOnPage ++
NEXT


RETURN ll_Return



end function

public function integer of_clearip ();//Long	i
//
//for i = 0 to ci_NumIP
//
//	st_ip[i].visible = false
//	st_ip[i].textcolor = 16777215
//next
//
//return 1

u_cst_InsertionPoint	lnv_Dummy

THIS.of_ResetPointers ( lnv_Dummy )
RETURN 1
end function

public function integer of_getcoidfromcode (string as_code);Long	ll_FoundRow
Long	ll_CompanyID = -1
String	ls_Value
n_cst_Beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

IF Left ( as_code , 1 ) =  "/" THEN
	ls_Value = Right ( as_Code , Len ( as_Code  ) - 1 )
Else 
	ls_Value = as_Code
END IF


ll_FoundRow = gnv_cst_companies.of_Find ( ls_Value ) 

IF ll_FoundRow > 0 THEN
	
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceRow ( ll_FoundRow )
	
	ll_CompanyID = lnv_Company.of_getID ( ) 
	
END IF

DESTROY lnv_Company

RETURN ll_CompanyID
	

end function

public function datastore of_getshipmentcache ();n_cst_bso_Dispatch	lnv_Dispatch
dataStore	lds_Cache

lnv_Dispatch = THIS.Event	ue_GetDispatchManager () 
lds_Cache =  lnv_Dispatch.of_GetShipmentCache ( )
//lnv_Dispatch.of_RetrieveShipment ( il_ShipmentID )
//MessageBox ( "ROW COUNT" , lds_Cache.RowCount ( ) )
RETURN lds_Cache
end function

public function dataStore of_geteventcache ();RETURN THIS.Event ue_GetDispatchManager ( ).of_GetEventCache ( )
end function

public function datastore of_getitemcache ();RETURN THIS.Event ue_GetDispatchManager ( ).of_GetItemCache ( )
end function

public function integer of_managesplits ();n_cst_msg	lnv_msg
s_Parm		lstr_Parm

Long	ll_ID
Long	ll_JumpID

n_cst_Bso_Dispatch	lnv_Dispatch
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

ll_ID = il_shipmentid
IF IsValid ( lnv_Dispatch ) AND ll_ID > 0 THEN
	
	
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = ll_ID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "DISPATCHOBJECT"
	lstr_Parm.ia_Value = lnv_Dispatch
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
	OpenWithParm ( w_ShipmentSplits , lnv_Msg )

	IF isValid ( message.powerobjectParm ) THEN
		
		lnv_Msg = message.powerobjectParm
		IF lnv_Msg.of_Get_Parm ( "JUMPID" ,lstr_Parm ) <> 0 THEN
			ll_JumpID = lstr_Parm.ia_Value
		END IF
		
	END IF
	

ELSE
	messageBox ( "Manage Splits" , "An error occurred while attempting to load the shipment. Request Cancelled.")
END IF

IF ll_JumpID > 0 THEN
	//Call wf_JumpShipment, forcing redisplay of current id, if that's what was selected.
	w_Itin	lw_Itinerary
	lw_Itinerary = THIS.Event ue_GetItineraryWindow ( )
	lw_Itinerary.post jump_ship( ll_JumpID , FALSE)
			
END IF
	
RETURN 1
end function

protected function integer of_fillref1withequipment (string as_ref, string as_type);// THIS method will only fill in the ref 1 text if the field is empty and the types match
Int		li_Ref1Type
Int		li_Ref2Type
Int		li_Ref3Type
String	ls_ExistingRef1Value
String	ls_ExistingRef2Value
String	ls_ExistingRef3Value
String 	ls_Ref1Type
String 	ls_Ref2Type
String 	ls_Ref3Type
String	ls_SetColumn
Int		li_Return = -1

n_cst_Bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( )

lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
lnv_Dispatch.of_RetrieveShipment ( il_ShipmentID )
//lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
//lnv_Shipment.of_SetSourceId ( il_ShipmentID ) 
//lnv_Shipment.of_SetAllowFilterSet ( TRUE )


IF dw_Shipment.RowCount ( ) > 0 THEN
	
	li_Return = 0
	
	li_Ref1Type = dw_Shipment.GetItemNumber ( 1 , "ds_Ref1_type" )
	li_Ref2Type = dw_Shipment.GetItemNumber ( 1 , "ds_Ref2_type" )
	li_Ref3Type = dw_Shipment.GetItemNumber ( 1 , "ds_Ref3_type" )
	
	ls_ExistingRef1Value = dw_Shipment.GetItemString ( 1 , "ds_Ref1_text" )
	ls_ExistingRef2Value = dw_Shipment.GetItemString ( 1 , "ds_Ref2_text" )
	ls_ExistingRef3Value = dw_Shipment.GetItemString ( 1 , "ds_Ref3_text" )
	
	ls_Ref1Type = THIS.of_GetTypeForRefType ( li_Ref1Type )
	ls_Ref2Type = THIS.of_GetTypeForRefType ( li_Ref2Type )
	ls_Ref3Type = THIS.of_GetTypeForRefType ( li_Ref3Type )
	
	CHOOSE CASE as_Type
			
		CASE ls_Ref1Type
			IF isNull ( ls_ExistingRef1Value ) THEN
				IF dw_Shipment.setItem ( 1 , "ds_Ref1_text" , as_ref ) = 1 THEN
					IF lnv_Shipment.of_SetRef1Text ( as_Ref ) = 1 THEN
						li_Return = 1
					END IF
				END IF
			END IF
			
		CASE ls_Ref2type
			IF isNull ( ls_ExistingRef2Value ) THEN
				IF dw_Shipment.setItem ( 1 , "ds_Ref2_text" , as_ref ) = 1 THEN
					IF lnv_Shipment.of_SetRef2Text ( as_Ref ) = 1 THEN
						li_Return = 1
					END IF
				END IF
			END IF
			
		CASE ls_Ref3type
			IF isNull ( ls_ExistingRef3Value ) THEN
				IF dw_Shipment.setItem ( 1 , "ds_Ref3_text" , as_ref ) = 1 THEN
					IF lnv_Shipment.of_SetRef3Text ( as_Ref ) = 1 THEN
						li_Return = 1
					END IF
				END IF
			END IF
			
	END CHOOSE
	
END IF


RETURN li_Return


end function

public function string of_gettypeforreftype (integer ai_reftype);//String	ls_Rtn
//
//CHOOSE CASE ai_RefType
//		
//	CASE 28
//		ls_Rtn = 'H'
//		
//	CASE 26
//		ls_Rtn = 'B'
//		
//	CASE 20
//		ls_Rtn = 'C'
//		
//END CHOOSE
//
//RETURN ls_Rtn
//
n_Cst_ShipmentManager	lnv_ShipmentManager

RETURN lnv_ShipmentManager.of_GetEqtypeForRefType ( ai_reftype )
end function

protected function integer of_fillrefwithequipment (string as_ref, string as_type);
Int		li_Ref1Type
Int		li_Ref2Type
Int		li_Ref3Type
String	ls_ExistingRef1Value
String	ls_ExistingRef2Value
String	ls_ExistingRef3Value
String 	ls_Ref1Type
String 	ls_Ref2Type
String 	ls_Ref3Type
String	ls_SetColumn
Int		li_Return = -1

n_cst_Bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( )

lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
lnv_Dispatch.of_RetrieveShipment ( il_ShipmentID )
//lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
//lnv_Shipment.of_SetSourceId ( il_ShipmentID ) 
//lnv_Shipment.of_SetAllowFilterSet ( TRUE )


IF dw_Shipment.RowCount ( ) > 0 THEN
	
	li_Return = 0
	
//	li_Ref1Type = lnv_Shipment.of_GetRef1Type ( ) 
//	li_Ref2Type = lnv_Shipment.of_GetRef2Type ( ) 
//	li_Ref3Type = lnv_Shipment.of_GetRef3Type ( ) 
	
	
	li_Ref1Type = dw_Shipment.GetItemNumber ( 1 , "ds_Ref1_type" )
	li_Ref2Type = dw_Shipment.GetItemNumber ( 1 , "ds_Ref2_type" )
	li_Ref3Type = dw_Shipment.GetItemNumber ( 1 , "ds_Ref3_type" )
	
	ls_ExistingRef1Value = dw_Shipment.GetItemString ( 1 , "ds_Ref1_text" )
	ls_ExistingRef2Value = dw_Shipment.GetItemString ( 1 , "ds_Ref2_text" )
	ls_ExistingRef3Value = dw_Shipment.GetItemString ( 1 , "ds_Ref3_text" )
//	
//	ls_ExistingRef1Value = lnv_Shipment.of_GetRef1Text (  )
//	ls_ExistingRef2Value = lnv_Shipment.of_GetRef2Text (  )
//	ls_ExistingRef3Value = lnv_Shipment.of_GetRef3Text (  )
	
	ls_Ref1Type = THIS.of_GetTypeForRefType ( li_Ref1Type )
	ls_Ref2Type = THIS.of_GetTypeForRefType ( li_Ref2Type )
	ls_Ref3Type = THIS.of_GetTypeForRefType ( li_Ref3Type )
	
	CHOOSE CASE as_Type
			
		CASE ls_Ref1Type
			IF isNull ( ls_ExistingRef1Value ) OR Len  ( ls_ExistingRef1Value ) = 0 THEN
				IF dw_Shipment.setItem ( 1 , "ds_Ref1_text" , as_ref ) = 1 THEN
					IF lnv_Shipment.of_SetRef1Text ( as_Ref ) = 1 THEN
						li_Return = 1
					END IF
				END IF
			END IF
			
		CASE ls_Ref2type
			IF isNull ( ls_ExistingRef2Value )OR Len  ( ls_ExistingRef2Value ) = 0 THEN
				IF dw_Shipment.setItem ( 1 , "ds_Ref2_text" , as_ref ) = 1 THEN
					IF lnv_Shipment.of_SetRef2Text ( as_Ref ) = 1 THEN
						li_Return = 1
					END IF
				END IF
			END IF
			
		CASE ls_Ref3type
			IF isNull ( ls_ExistingRef3Value ) OR Len  ( ls_ExistingRef3Value ) = 0 THEN
				IF dw_Shipment.setItem ( 1 , "ds_Ref3_text" , as_ref ) = 1 THEN
					IF lnv_Shipment.of_SetRef3Text ( as_Ref ) = 1 THEN
						li_Return = 1
					END IF
				END IF
			END IF
			
	END CHOOSE
	
END IF

RETURN li_Return


end function

public function integer of_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg);String	ls_PreviousType
String	ls_NextType
String	lsa_ParmLabel[]
Any		laa_ParmValue[]
Boolean	lb_HasShipment
Boolean	lb_Continue = TRUE
Long	ll_SelectedRow
Long	lla_SelectedRows[]
Long	ll_SelectedCount
Long	ll_Row 
Long	ll_RowCount
Long	ll_EventID
Long	ll_Shipment1
Long	ll_Shipment2

Int	li_Rtn

s_Parm	lstr_Parm

n_cst_beo_Event	lnv_Event1
n_cst_beo_Event	lnv_Event2

lnv_Event1 = CREATE n_cst_beo_Event
lnv_Event2 = CREATE n_cst_beo_Event

ll_RowCount = dw_ship_itin.RowCount ( )
ll_Row = al_Row

DO 
	
	ll_SelectedRow = dw_ship_itin.GetSelectedRow ( ll_SelectedRow )
	IF ll_SelectedRow > 0 THEN
		lla_SelectedRows [ UpperBound ( lla_SelectedRows ) + 1 ] = ll_SelectedRow
	END IF
	
LOOP WHILE ll_SelectedRow > 0

ll_SelectedCount = UpperBound ( lla_SelectedRows )
IF ll_SelectedCount = 0 THEN  // set the row passed in as a selected row
	ll_SelectedCount = 1
	lla_SelectedRows [ 1 ] = ll_Row
END IF

IF ll_SelectedCount = 2 THEN
	
	CHOOSE CASE ll_Row
			
		CASE lla_SelectedRows [ 1 ]
			lnv_Event1.of_SetSource ( dw_ship_itin )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [1] )
			ls_NextType = lnv_Event1.of_GetType ( )
			
		CASE lla_SelectedRows [ 2 ]
			lnv_Event1.of_SetSource ( dw_ship_itin )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [2] )
			ls_PreviousType = lnv_Event1.of_GetType ( )
	END CHOOSE

END IF

IF ll_Row > 0 AND ll_Row <= ll_RowCount THEN
	lnv_Event1.of_SetSource ( dw_ship_itin )
	lnv_Event1.of_SetSourceRow ( ll_Row )
	
	ll_EventID = lnv_Event1.of_GetID ( )
	lb_HasShipment = lnv_Event1.of_GetShipment ( ) > 0 
	
	
	CHOOSE CASE ll_SelectedCount
			
		CASE 1
			IF Not ( lnv_Event1.of_IsConfirmed ( )  ) THEN
				IF NOT lnv_Event1.of_IsBobtailevent( ) THEN
					CHOOSE CASE lnv_Event1.of_GetType( )
					
						CASE gc_Dispatch.cs_EventType_Drop
							
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
					
								IF lb_HasShipment THEN
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
									IF ll_Row = ll_RowCount THEN								
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Add Chassis Return"
									END IF								
								END IF
						
						CASE gc_Dispatch.cs_EventType_Dismount
							
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
								
								IF lb_HasShipment THEN
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
								END IF
						
						CASE gc_Dispatch.cs_EventType_Hook
					
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
								
								IF lb_HasShipment THEN
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
									IF ll_Row = 1 THEN								
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Add Chassis Pickup"								
									END IF								
								END IF
					
						CASE gc_Dispatch.cs_EventType_Mount
							
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
					
								IF lb_HasShipment THEN
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
								END IF
								
							
						CASE gc_Dispatch.cs_EventType_Pickup
							IF lb_HasShipment THEN
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook and Drop"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount and Dismount"
														
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
								
							END IF
							
							
						CASE gc_Dispatch.cs_EventType_Deliver
							IF lb_HasShipment THEN
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop and Hook"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount and Mount"
							END IF
								
					END CHOOSE
				END IF
			END IF
			
		CASE 2
			IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent

				lnv_Event1.of_SetSource ( dw_ship_itin )
				lnv_Event1.of_SetSourceRow ( lla_SelectedRows [ 1 ] )
				
				lnv_Event2.of_SetSource ( dw_ship_itin )
				lnv_Event2.of_SetSourceRow ( lla_SelectedRows [ 2 ] )
				
				IF lnv_Event1.of_IsDeliverGroup ( ) AND lnv_Event2.of_IsPickupGroup ( ) THEN
				
					ll_Shipment1 = lnv_Event1.of_GetShipment ( )
					
					ll_Shipment2 = lnv_Event2.of_GetShipment ( )
					IF NOT ( lnv_Event1.of_IsConfirmed ( ) OR lnv_Event2.of_IsConfirmed ( ) ) THEN
						CHOOSE CASE lnv_Event1.of_GetType( )
						
							CASE gc_Dispatch.cs_EventType_Drop , gc_Dispatch.cs_EventType_Dismount , gc_Dispatch.cs_EventType_Hook , &
								gc_Dispatch.cs_EventType_Mount 
				
								// determine the other type to put in the message
					
								IF ll_Shipment1 > 0 OR ll_Shipment2 > 0 THEN
									IF ll_Shipment1 > 0 AND  ll_Shipment2 > 0 THEN
										IF ll_Shipment1 <> ll_Shipment2 THEN // bail
											lb_Continue = FALSE
										END IF
									END IF
									
									IF lb_Continue THEN
									
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
										
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
									END IF
							END IF
					
						END CHOOSE
					END IF
				ELSE
					
					CHOOSE CASE al_Row
						CASE 1 , 2
							IF lnv_Event1.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook AND &
								lnv_Event2.of_GetType( ) = gc_Dispatch.cs_EventType_Mount  THEN
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Remove Chassis Pickup"
								
							END IF
							
							
						CASE ll_RowCount , ll_RowCount - 1
							IF lnv_Event1.of_GetType ( ) = gc_Dispatch.cs_EventType_Dismount AND &
								lnv_Event2.of_GetType( ) = gc_Dispatch.cs_EventType_Drop  THEN
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Remove Chassis Return"
								
							END IF																				
					END CHOOSE
				END IF
			END IF
	END CHOOSE
	

END IF




lstr_Parm.is_label = "LABELS"
lstr_Parm.ia_Value = lsa_ParmLabel
anv_msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "VALUES"
lstr_Parm.ia_Value = laa_ParmValue
anv_msg.of_Add_Parm ( lstr_Parm )

DESTROY lnv_Event1
DESTROY lnv_Event2

Return li_Rtn


end function

public function string of_getequipmenttype (readonly long al_EqID);String	ls_Return
Long	ll_Find

DataStore	lds_Cache
n_cst_bso_Dispatch	lnv_Disp

lnv_Disp = THIS.Event ue_GetDispatchManager ( )

IF isValid ( lnv_Disp ) THEN
	lds_Cache = lnv_Disp.of_GetEquipmentCache ( )	
END IF

IF IsValid ( lds_Cache ) THEN
	ll_Find = lds_Cache.Find ( "eq_ID = " + String ( al_EqID ), 1, lds_Cache.RowCount ( ) )
END IF

IF ll_Find > 0 THEN
	ls_Return = lds_Cache.GetItemString ( ll_Find  , "eq_type" ) 	
END IF

RETURN ls_Return
end function

public function long of_geteqidfromcache (readonly string as_ref, readonly long ai_shipmentid);Long	ll_Return
Long	ll_Find

DataStore	lds_Cache
n_cst_bso_Dispatch	lnv_Disp

lnv_Disp = THIS.Event ue_GetDispatchManager ( )

IF isValid ( lnv_Disp ) THEN
	lds_Cache = lnv_Disp.of_GetEquipmentCache ( )	
END IF

IF IsValid ( lds_Cache ) THEN
	ll_Find = lds_Cache.Find ( "eq_ref = '" + String ( as_ref ) + "' AND equipmentlease_shipment = " + String ( ai_shipmentid ) , 1, lds_Cache.RowCount ( ) )
END IF

IF ll_Find > 0 THEN
	ll_Return = lds_Cache.GetItemNumber ( ll_Find  , "eq_id" ) 	
END IF

RETURN ll_Return
end function

public function integer of_refreshequipment ();dw_assignmentlist.Reset ( ) 
dw_assignmentlist.of_SetCache ( THIS.Event ue_GetDispatchManager ( ), il_ShipmentId )
RETURN 1
end function

public function integer of_evaluateforreload (long al_eqid);Int		li_Return = -1
Boolean	lb_Relink
String	ls_Message

n_Cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_Beo_Equipment2	lnv_Equipment
n_Cst_settings			lnv_Settings

lnv_Equipment = CREATE n_Cst_beo_Equipment2
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

lb_Relink = lnv_Settings.of_AllowShipmentChangeofLinkedEquipment (  )
lnv_Equipment.of_SetAllowFilterSet ( TRUE ) 

IF isValid ( lnv_Dispatch ) THEN
	
	lnv_Dispatch.of_RetrieveEquipment ( {al_eqid} )
	
	lnv_Equipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) )
	lnv_Equipment.of_SetSourceID ( al_EqID )
	
//	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) ) 
//	lnv_SHipment.of_SetSourceID ( il_ShipmentID  ) 
	
	IF lb_Relink THEN
					
		ls_Message = "The equipment specifed: " + lnv_Equipment.of_getNumber ( ) + " is currently linked to shipment " + String ( lnv_Equipment.of_GetShipment ( ) ) + & 
															". Do you want to link it to shipment " + String ( il_ShipmentID ) + " instead?~r~nBe sure to calculate all needed charges for the original shipment before re-linking."
		
		CHOOSE CASE  MessageBox ( "Specified Equipment" , ls_Message , Question! , YesNo! , 1) 
			CASE 1 // yes change the link
				
				IF THIS.Event ue_LinkEquipment ( al_eqid ) <> 1 THEN
					MessageBox ( "Linking Equipment" , "An error occurred while attempting to link the existing piece of equipment to this shipment." )
					li_Return = -1
				ELSE
					li_Return = 1
				END IF
				
			CASE ELSE
				li_Return = -1
				
		END CHOOSE 
	ELSE
	
	
		IF lnv_Shipment.of_GetMoveCode ( ) = gc_dispatch.cs_MoveCode_Export THEN
	
			IF lnv_Equipment.of_GetReloadShipment ( ) > 0 THEN
				li_Return = -1
				MessageBox( "Equipment Reference" ,"The equipment specified already exists and has been reloaded. " )
			ELSE
				
//				UPDATE "outside_equip"  
//				SET "reloadshipment" = :il_ShipmentID  
//				WHERE "outside_equip"."oe_id" = :al_eqid ;
//				
//				IF sqlca.sqlcode <> 0 then
//					rollback;
//					li_Return = -1
//				ELSE
//					COMMIT;
//				END IF
							
				
				//THIS.of_InsertExistingEquipmentForReload ( ll_EqID , al_Row )	
				IF lnv_Equipment.of_setReloadShipment ( il_ShipmentID ) <> 1 THEN
					MessageBox ( "Equipment Reload" , "An error occurred while attepting to assign the specified equipment to this shipment." )
				ELSE
					li_Return = 1
				END IF
			END IF
			
		ELSE
			li_Return = -1
			MessageBox( "Equipment Reference" ,"The equipment specified already exists. Equipment can only be reloaded on export shipments." )				
		END IF
	END IF

END IF

DESTROY ( lnv_Equipment )

RETURN li_Return






end function

public function integer of_displayequipmentforshipment (long al_id);Long	ll_Row	
Long	li_EqCount
Int	i

n_cst_bso_Dispatch	lnv_Disp
n_cst_beo_Equipment2	lnva_Equipment[]

lnv_Disp = THIS.Event ue_GetDispatchManager ( )

IF isValid ( lnv_Disp ) THEN

	li_EqCount = lnv_Disp.of_GetEquipmentforShipment ( al_id, lnva_Equipment )
	dw_assignmentlist.Reset ( )
	FOR i = 1 TO li_EqCount
		ll_Row = dw_assignmentlist.insertRow ( 0 ) 		
		IF ll_Row > 0 THEN
			dw_assignmentlist.SetItem ( ll_row , "equipment_type" , lnva_Equipment[i].of_GetType (  )  )				
			dw_assignmentlist.SetItem ( ll_row , "equipment_eq_Ref" , lnva_Equipment[i].of_GetNumber ( ) )
			dw_assignmentlist.SetItem ( ll_row , "equipment_eq_id" , lnva_Equipment[i].of_GetID ( )  ) 
			dw_assignmentlist.SetItem ( ll_row , "equipment_eq_Status" , lnva_Equipment[i].of_GetStatus ( )  )
		END IF
		DESTROY ( lnva_Equipment[i] ) 
	NEXT
	
END IF

RETURN 1
end function

private function integer of_resetpointers (u_cst_insertionpoint auo_exclude);Int	li_Count
Int	li_i

li_Count = UpperBound ( iuo_ip[] )

FOR li_i = 1 TO li_Count
	IF iuo_ip[ li_i ] <> auo_Exclude THEN
		iuo_ip[ li_i ].of_Reset ( )
	END IF
NEXT 

RETURN 1
end function

public function long of_getfirstrowonpage ();RETURN Long ( dw_ship_itin .Object.DataWindow.FirstRowOnPage ) 
end function

public function integer of_getvisiblecount ();Long	ll_FirstRow
Long	ll_LastRow
Int	li_Return


ll_FirstRow = THIS.of_getFirstRowOnPage ( )
ll_LastRow = Long ( dw_ship_itin.Object.DataWindow.LastRowOnPage )

IF dw_ship_itin.RowCount ( ) <> 0 THEN
	
	IF ll_LastRow <> ll_FirstRow THEN
		li_Return = ll_LastRow - ll_FirstRow 
	END IF
	
	li_Return ++

END IF

RETURN li_Return
end function

public function integer of_insertevent (long al_insertrow);Int	li_Return = -1
long	lla_NewIDs []
Long	ll_InsertRow
String	lsa_Types[]

n_cst_Beo_Shipment lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Dispatch= THIS.Event ue_GetDispatchManager( )


IF isValid ( lnv_Shipment ) AND IsValid ( lnv_Dispatch ) THEN
	
//	IF gnv_app.of_getPrivsmanager( ).of_GetUserpermissionfromfn( "ModifyShipment", lnv_Shipment ) = appeon_constant.ci_True THEN
PowerObject lpo_Parent
lpo_Parent = THIS.GetParent ( ) 
DO
	IF IsValid ( lpo_Parent ) THEN
		IF lpo_Parent.Classname( ) = "w_itin" THEN
			lpo_Parent.Dynamic wf_SetHoldRedraw ( TRUE )
			lpo_Parent.Dynamic wf_SetRedraw ( FALSE ) 
			EXIT
		END IF
		lpo_Parent = lpo_Parent.GetParent ( ) 
	END IF
	
Loop While isValid ( lpo_Parent )	
	
		//lnv_Dispatch.of_Retrieveshipment( il_shipmentid )
		lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceID ( il_shipmentid )
		lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemcache( ) )
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventcache( ) )
		IF lnv_Shipment.of_AddEvent ( ) = 1 THEN
			
			ll_InsertRow = al_InsertRow
			lsa_types [ 1 ]  = ""	
			lnv_Shipment.of_AddEvents ( lsa_Types , ll_InsertRow , lnv_Dispatch , lla_NewIds )
			
			//THIS.Event ue_EventAdded ( ll_InsertRow )
			dw_ship_itin.Post SetRow ( ll_InsertRow )
			dw_ship_itin.ScrollToRow ( ll_InsertRow )
			dw_ship_itin.Post SetColumn ( "de_event_type" )
			dw_ship_itin.Post SetFocus ( )
			dw_ship_itin.Post Event ue_ShowEventSelections ( ll_InsertRow )
			li_Return = 1
			//lnv_Dispatch.Post of_FilterShipment ( lnv_Shipment.of_GetID ( ) )
		END IF
	//END IF
END IF
	

RETURN li_Return
end function

public function n_cst_beo_Shipment of_getshipment ();IF il_shipmentid > 0 THEN
	n_cst_bso_Dispatch	lnv_Disp
	n_cst_beo_Shipment 	lnv_Shipment
	lnv_Shipment = CREATE n_cst_beo_Shipment
	
	lnv_Disp = event ue_getdispatchmanager( )
	IF isValid ( lnv_Disp ) THEN
		lnv_Shipment.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceID ( il_shipmentid ) 
		lnv_Shipment.of_SetItemSource ( lnv_Disp.of_getItemCache ( ) ) 
		lnv_Shipment.of_SetEventSource ( lnv_Disp.of_GetEventCache ( ) )
	END IF
END IF

RETURN lnv_Shipment
			

end function

private function integer of_setenablement ();cb_1.enabled = ib_allowmodifyshipment
cb_9.Enabled = ib_Allowmodifyitin
cb_route.Enabled = ib_Allowmodifyitin
//dw_ship_itin.Enabled = ab_value

Return 1
end function

on u_cst_eventrouting_shipment.create
int iCurrent
call super::create
this.cb_9=create cb_9
this.cb_route=create cb_route
this.st_route=create st_route
this.cb_jump=create cb_jump
this.cb_select=create cb_select
this.st_1=create st_1
this.sle_shipnum=create sle_shipnum
this.dw_shipment=create dw_shipment
this.dw_selection=create dw_selection
this.dw_assignmentlist=create dw_assignmentlist
this.sle_equipment=create sle_equipment
this.cb_create=create cb_create
this.dw_equipment=create dw_equipment
this.cb_1=create cb_1
this.uo_ip1=create uo_ip1
this.uo_ip2=create uo_ip2
this.uo_ip3=create uo_ip3
this.uo_ip4=create uo_ip4
this.uo_ip8=create uo_ip8
this.uo_ip6=create uo_ip6
this.uo_ip5=create uo_ip5
this.uo_ip7=create uo_ip7
this.dw_ship_itin=create dw_ship_itin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_9
this.Control[iCurrent+2]=this.cb_route
this.Control[iCurrent+3]=this.st_route
this.Control[iCurrent+4]=this.cb_jump
this.Control[iCurrent+5]=this.cb_select
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_shipnum
this.Control[iCurrent+8]=this.dw_shipment
this.Control[iCurrent+9]=this.dw_selection
this.Control[iCurrent+10]=this.dw_assignmentlist
this.Control[iCurrent+11]=this.sle_equipment
this.Control[iCurrent+12]=this.cb_create
this.Control[iCurrent+13]=this.dw_equipment
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.uo_ip1
this.Control[iCurrent+16]=this.uo_ip2
this.Control[iCurrent+17]=this.uo_ip3
this.Control[iCurrent+18]=this.uo_ip4
this.Control[iCurrent+19]=this.uo_ip8
this.Control[iCurrent+20]=this.uo_ip6
this.Control[iCurrent+21]=this.uo_ip5
this.Control[iCurrent+22]=this.uo_ip7
this.Control[iCurrent+23]=this.dw_ship_itin
end on

on u_cst_eventrouting_shipment.destroy
call super::destroy
destroy(this.cb_9)
destroy(this.cb_route)
destroy(this.st_route)
destroy(this.cb_jump)
destroy(this.cb_select)
destroy(this.st_1)
destroy(this.sle_shipnum)
destroy(this.dw_shipment)
destroy(this.dw_selection)
destroy(this.dw_assignmentlist)
destroy(this.sle_equipment)
destroy(this.cb_create)
destroy(this.dw_equipment)
destroy(this.cb_1)
destroy(this.uo_ip1)
destroy(this.uo_ip2)
destroy(this.uo_ip3)
destroy(this.uo_ip4)
destroy(this.uo_ip8)
destroy(this.uo_ip6)
destroy(this.uo_ip5)
destroy(this.uo_ip7)
destroy(this.dw_ship_itin)
end on

event ue_setroutemodeindicator;//Toggles the route mode display indicator on or off, according to ab_Switch.

IF NOT IsNull ( ab_Switch ) THEN
	cb_Route.Visible = NOT ab_Switch
	st_Route.Visible = ab_Switch
END IF
end event

event destructor;call super::destructor;w_Itin	lw_Itinerary
lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF lw_Itinerary.whats_on = lw_Itinerary.ci_RouteRequest_Route THEN
	lw_Itinerary.clear_ip()
END IF

DESTROY ( inv_Shipment )
end event

event constructor;call super::constructor;//dw_ship_itin.settransobject(sqlca)
inv_Shipment = CREATE n_cst_beo_Shipment

dw_ship_itin.modify("st_routed.visible = '1' comp_routed.visible = '1'")
dw_ship_itin.modify("de_event_type.Protect = ~"0~tIF (  IsNull ( de_Trailer ) AND IsNull ( de_ArrDate ), 0 , 1 )~"" ) 
dw_ship_itin.modify("st_confirmed.visible = '1' comp_confirmed.visible = '1'")
dw_ship_itin.modify("st_miles.visible = '0' leg_miles.visible = '0'")
dw_ship_itin.modify("st_time.visible = '0' comp_leg_time.visible = '0'")
dw_ship_itin.modify("st_arrive.visible = '0' comp_arr.visible = '0'")
dw_ship_itin.modify("st_depart.visible = '0' comp_dep.visible = '0'")
dw_ship_itin.modify("st_tz.visible = '0' co_tz.visible = '0'")

iuo_ip[1] = uo_ip1
iuo_ip[2] = uo_ip2
iuo_ip[3] = uo_ip3
iuo_ip[4] = uo_ip4
iuo_ip[5] = uo_ip5
iuo_ip[6] = uo_ip6
iuo_ip[7] = uo_ip7
iuo_ip[8] = uo_ip8

THIS.of_Showip( )

This.Event Post ue_PostConstructor ( )

ids_orfin_events = create datastore
ids_orfin_events.dataobject = "d_itin"
ids_orfin_events.settransobject(sqlca)
end event

event ue_getroutingids;call super::ue_getroutingids;//Override ancestor to provide a list of event ids to route based on user selection
//in this panel.

Long	lla_EventIds[]

Long	ll_Return

CHOOSE CASE This.Event ue_CheckSelection ( FALSE /*Don't verify auto-selection*/, FALSE /*Notify for None*/ )

CASE 1  //OK

	IF dw_Ship_Itin.GetSelectedRow ( 0 ) > 0 THEN
		lla_EventIds = dw_Ship_Itin.Object.de_Id.Selected
	END IF

//CASE 0, -1  Don't need to handle other cases.

END CHOOSE

ala_Ids = lla_EventIds
ll_Return = UpperBound ( ala_Ids )

RETURN ll_Return
end event

type cb_9 from u_cb within u_cst_eventrouting_shipment
integer x = 1874
integer y = 28
integer width = 370
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Aut&o-Route"
end type

event clicked;Parent.Event ue_AutoRoute ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type cb_route from u_cb within u_cst_eventrouting_shipment
integer x = 2267
integer y = 28
integer width = 265
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "&Route"
end type

event clicked;Parent.Event ue_RouteMode ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type st_route from statictext within u_cst_eventrouting_shipment
boolean visible = false
integer x = 2267
integer y = 32
integer width = 265
integer height = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
string text = "Route"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_jump from commandbutton within u_cst_eventrouting_shipment
integer x = 1111
integer y = 28
integer width = 334
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "From &Itin."
end type

event clicked;w_Itin	lw_Itinerary
lw_Itinerary = Parent.Event ue_GetItineraryWindow ( )


sle_shipnum.post selecttext(1, 99)
sle_shipnum.post setfocus()
n_cst_numerical lnv_numerical

long selid, foundrow
string rejstr

foundrow = lw_Itinerary.dw_itin.getrow()
if lnv_numerical.of_IsNullOrNotPos(foundrow) then
	rejstr = "There are no events in the intinerary to match from."
	goto reject
end if

selid = lw_Itinerary.dw_itin.object.de_shipment_id[foundrow]
if lnv_numerical.of_IsNullOrNotPos(selid) then
	rejstr = "The current event in the itinerary is not a part of a shipment."
	goto reject
end if

if selid = il_ShipmentId then return

Parent.Event ue_DisplayShipment ( selid )

return

reject:
messagebox("Select Shipment From Itinerary", rejstr + "~n~nRequest cancelled.", &
	exclamation!)
end event

type cb_select from commandbutton within u_cst_eventrouting_shipment
integer x = 896
integer y = 28
integer width = 192
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&List"
end type

event clicked;w_Itin	lw_Itinerary
lw_Itinerary = Parent.Event ue_GetItineraryWindow ( )


long selid
n_cst_numerical lnv_numerical

open(w_ship_select)  //The window does not allow selection of non-routed shipments
selid = message.doubleparm

sle_shipnum.post selecttext(1, 99)
sle_shipnum.post setfocus()

if lnv_numerical.of_IsNullOrNotPos(selid) then return
if selid = il_ShipmentId then return

Parent.Event ue_DisplayShipment ( selid )
end event

type st_1 from statictext within u_cst_eventrouting_shipment
integer x = 32
integer y = 36
integer width = 265
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean enabled = false
string text = "&Shipment:"
boolean focusrectangle = false
end type

type sle_shipnum from singlelineedit within u_cst_eventrouting_shipment
event lbuttondown pbm_lbuttondown
event ue_key pbm_keydown
event ue_dblclick pbm_lbuttondblclk
integer x = 306
integer y = 40
integer width = 571
integer height = 72
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
integer accelerator = 115
borderstyle borderstyle = stylelowered!
end type

event lbuttondown;this.post setfocus()
end event

event ue_key;String	ls_Value

IF key = KeyDownArrow! THEN

	ls_Value = Trim ( sle_shipnum.Text )

	IF left(ls_Value, 2) = "//" and len(ls_Value) > 2 then  // searching on container
		ls_Value = TRIM ( right(ls_Value, len(ls_Value) - 2) )
		IF dw_selection.of_RetrieveWithRef ( ls_Value ) <> -1 THEN
			dw_selection.SetFocus ( )
		ELSE
			MessageBox ( "Equipment Lookup" , "An error occurred while attempting to find an associated shipment." )
		END IF
	ELSE
		dw_Equipment.of_Retrieve ( ls_Value )
		dw_Equipment.SetFocus ( )
		
		
	END IF
END IF

RETURN 0
end event

event ue_dblclick;w_Itin	lw_Itinerary
String lsa_parm_labels[]
Any	 laa_parm_values[]

IF il_ShipmentId > 0 THEN
	SetPointer ( HOURGLASS! )
	
	lw_Itinerary = Parent.Event ue_GetItineraryWindow ( )
	lw_Itinerary.post jump_ship(il_ShipmentId, FALSE)
	
END IF


end event

event getfocus;This.Post selecttext(1, len(this.text))
end event

event modified;w_Itin	lw_Itinerary

lw_Itinerary = Parent.Event ue_GetItineraryWindow ( )


this.post selecttext(1, 99)

long 		sel_id
string 	typed_val, new_shipnum, sel_dorb
String	ls_Lookup

typed_val = trim(this.text)

if match(typed_val, "^[0-9]+-TMP$") then typed_val = left(typed_val, len(typed_val) - 4)

IF left(typed_val, 2) = "//" and len(typed_val) > 2 then  // searching on container
	ls_Lookup = right(typed_val, len(typed_val) - 2)
	IF dw_selection.of_RetrieveWithRef ( ls_Lookup ) <> -1 THEN
		dw_selection.SetFocus ( )
	ELSE
		MessageBox ( "Equipment Lookup" , "An error occurred while attempting to find an associated shipment." )
	END IF
ELSEIF KeyDown ( KeyDownArrow! ) THEN
	ls_Lookup = typed_Val
	dw_equipment.of_Retrieve ( ls_Lookup )
	dw_Equipment.SetFocus ( )
ELSE
	if IsNumber ( typed_val ) then
	
		sel_id = Long ( typed_val )
		select ds_dorb into :sel_dorb from disp_ship
			where ds_id = :sel_id ;
	
	elseif left(typed_val, 1) = "/" and len(typed_val) > 1 then
	
		new_shipnum = right(typed_val, len(typed_val) - 1)
		select ds_id, ds_dorb into :sel_id, :sel_dorb from disp_ship
			where ds_pronum = :new_shipnum ;
	else
		goto failure
	
	end if
	
	choose case sqlca.sqlcode
		case 0
			commit ;
		case 100
			commit ;
			goto failure
		case else
			rollback ;
			goto failure
	end choose
	
	if sel_dorb = "T" then
		sel_dorb = sel_dorb
	else
		messagebox("Select Shipment", "Only routed dispatch shipments may be selected "+&
			"in this window.~n~nRequest cancelled.", exclamation!)
		this.text = is_ShipmentNumber
		return
	end if
	
	Parent.Event ue_DisplayShipment ( sel_id )
END IF
return

failure:
messagebox("Select Shipment", "Could not process selection request.~n~nRequest "+&
	"cancelled.", exclamation!)
this.text = is_ShipmentNumber
end event

event rbuttondown;w_Itin	lw_Itinerary
String lsa_parm_labels[]
Any	 laa_parm_values[]

IF il_ShipmentId > 0 THEN
	
	lw_Itinerary = Parent.Event ue_GetItineraryWindow ( )

	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "Display &Shipment"
	
	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "Split &Billing"
	
	lsa_parm_labels[3] = "ADD_ITEM"
	laa_parm_values[3] = "Change Status"
	

	CHOOSE CASE f_pop_standard(lsa_parm_labels, laa_parm_values) 
	
		CASE "SPLIT BILLING"
			Parent.of_ManageSplits ( )
			
		CASE "DISPLAY SHIPMENT"
			
			lw_Itinerary.post jump_ship(il_ShipmentId, FALSE)
			
		CASE "CHANGE STATUS"
			Parent.Event ue_ChangeStatus ( )
			
	END CHOOSE
END IF


end event

type dw_shipment from u_dw within u_cst_eventrouting_shipment
event type integer ue_createlinkedequipment ( long al_shipid,  string as_ref )
integer x = 2080
integer y = 340
integer width = 1445
integer height = 400
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_shipmentroutingview"
borderstyle borderstyle = stylebox!
end type

event ue_createlinkedequipment;Long				ll_ShipID
Any				la_Value
Boolean			lb_CreateEquipment
String			ls_MessageHeader
Int				li_SelectionType
Long				ll_SelectionID
Int				li_Return = 1

n_cst_Msg		lnv_Msg
S_Parm			lstr_Parm
s_Eq_Info		lstr_NewEquipment
s_Eq_Info		lstr_Equipment
n_cst_Settings	lnv_Settings

dataStore		lds_Equip
n_cst_EquipmentManager	lnv_EquipmentManager
//CHECK TO SEE IF WE HAVE A SHIPMENT ID


ll_ShipID = al_shipid

IF ll_ShipID > 0 THEN
	lstr_Parm.is_Label = "SHIPMENT"
	lstr_Parm.ia_Value = ll_ShipID 
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	lb_CreateEquipment = TRUE
END IF
	


IF  ll_ShipID > 0 THEN
	
ELSE
	IF lnv_Settings.of_GetSetting ( 82 , la_Value ) = 1 THEN
		IF STRING ( la_Value ) = "YES!" THEN
			lb_CreateEquipment = TRUE
		END IF
	END IF
END IF

IF lb_CreateEquipment THEN

	lnv_EquipmentManager.of_Retrieve (  lds_Equip , "WHERE eq_ref = '" + as_ref + "' and eq_status = 'K'" )
	IF lds_Equip.RowCount () = 0 THEN
	
		IF MessageBox ( ls_MessageHeader, "The equipment you have specified does not exist.  "+&
			"Do you want to create new Leased Equipment with that number?", Question!, YesNo!, 1 ) = 1 THEN
	
			lstr_NewEquipment.eq_Type = "34"  //Allow entry of TrailerChassis or Container
			lstr_NewEquipment.eq_Ref = as_ref
			
			//Indicate that we want to save the new equipment, not just pass the info out.
			lstr_NewEquipment.eq_Id = 0  //Null = Pass info out, don't save ;  0 = Save new equipment
	
			lstr_Parm.is_Label = "EQSTRUCT"
			lstr_Parm.ia_Value = lstr_NewEquipment 
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			OpenWithParm ( w_Eq_NewOut, lnv_Msg )
			lstr_NewEquipment = Message.PowerObjectParm
	
			IF lstr_NewEquipment.eq_Id > 0 THEN
	
				//A valid piece of equipment has been created.
				lstr_Equipment = lstr_NewEquipment
				li_SelectionType = lnv_EquipmentManager.of_GetItinType ( lstr_Equipment.eq_Type )
				ll_SelectionId = lstr_Equipment.eq_Id
				
	//			Event ue_Select ( li_SelectionType, ll_SelectionId )
			
			ELSE
	
				//User Cancelled
				li_Return = 0
				
			END IF
	
		ELSE
	
			li_Return = 0
		END IF
	END IF
ELSE 
	// should not happen
	MessageBox ( "Creation of Equipment", "The creation of equipment not linked to a shipment is not allowed. To create a piece of linked equipment, go to the shipment tab OR select a shipment event for the desired shipment." )					
END IF


DESTROY lds_Equip

RETURN li_Return
end event

event constructor;n_cst_ShipmentManager	lnv_ShipmentMgr
lnv_ShipmentMgr.of_PopulateReferenceLists ( This )


//Populate ShipType List!!


This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )
end event

event buttonclicked;Integer	li_Ref1Type
String	ls_Ref1Text, &
			ls_MessageHeader = "Assign Equipment"
Long		ll_ShipID
Long		ll_EqID
//n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm



Integer	li_Return = 1  //Used as a flag, not an actual return value.

lnv_shipment = CREATE n_cst_beo_shipment

IF Row > 0 THEN
	CHOOSE CASE Lower ( dwo.Name ) 
		CASE "cb_assign" 
			n_cst_Privileges_Events	lnv_Privs
			IF NOT lnv_Privs.of_allowalteritins() THEN
				li_Return = 0
			END IF
			IF li_Return = 1 THEN
		
				lnv_Shipment.of_SetSource ( This )
				lnv_Shipment.of_SetSourceRow ( Row )
				ll_ShipID = lnv_Shipment.of_GetID ( )
				ls_Ref1Text = lnv_Shipment.of_GetRef1Text ( )
			
				IF Len ( ls_Ref1Text ) > 0 AND ll_ShipID > 0 THEN
					//OK
				ELSE
					li_Return = 0
				END IF
			
			END IF
			
			
			IF li_Return = 1 THEN
			
				li_Ref1Type = lnv_Shipment.of_GetRef1Type ( )
			
				CHOOSE CASE li_Ref1Type
			
				CASE 20, 23, 26 , 28 //Container #, Trailer #, Railbox # , chassis #
					ll_EqID = PARENT.of_GetEqIDFromCache ( ls_Ref1Text , ll_ShipID ) 
			
//					IF THIS.Event ue_CreateLinkedEquipment ( ll_ShipID , ls_Ref1Text ) <> 1 THEN
//						li_Return = -2  // this will cause silent failure
//					END IF
					//OK
			
				CASE ELSE
			
					ls_Ref1Text = ""
					li_Return = 0
			
				END CHOOSE
			
			END IF
			
			
			CHOOSE CASE li_Return
			
			CASE 1, 0
			
				//We're having a problem with the focus rectange staying on the button, even though the focus
				//leaves.  I tried setting a column, calling setredraw, and calling setfocus, but nothing helped.
			
				PARENT.Event ue_AssignReferencedEquipment ( ll_EqID )
		
	//			Parent.Event ue_AssignEquipment ( ls_Ref1Text )
			
			//CASE 0
			//
			//	MessageBox ( ls_MessageHeader, "An equipment reference has not been specified for this shipment." )
			
			CASE -1
			
				MessageBox ( ls_MessageHeader, "Could not process request.  Request cancelled." )
			
			END CHOOSE
		
		
		CASE "cb_more"
			lstr_Parm.is_Label = "SOURCE"
			lstr_Parm.ia_Value = THIS
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "ROW"
			lstr_Parm.ia_Value = ROW
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "EDITABLE"
			lstr_Parm.ia_Value = FALSE
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "DISPATCHOBJECT"
			lstr_Parm.ia_Value = Parent.Event ue_GetDispatchManager ( )
			lnv_Msg.of_Add_Parm ( lstr_Parm )

		
			OpenWithParm ( w_ShipmentDetail , lnv_Msg )
		
	END CHOOSE

END IF


DESTROY ( lnv_Shipment )

/////////////////////////////////////////////////////////////////////

//This was the button code.

//Integer	li_Ref1Type
//String	ls_Ref1Text, &
//			ls_MessageHeader = "Assign Equipment"
//
//n_cst_bso_Dispatch	lnv_Dispatch
//n_cst_beo_Shipment	lnv_Shipment
//
//
//Integer	li_Return = 1
//
//IF li_Return = 1 THEN
//
//	lnv_Dispatch = Parent.Event ue_GetDispatchManager ( )
//	
//	IF IsValid ( lnv_Dispatch ) THEN
//	
//		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
//		lnv_Shipment.of_SetSourceId ( il_ShipmentId )
//
//	ELSE
//
//		li_Return = -1
//
//	END IF
//
//END IF
//
//
//IF li_Return = 1 THEN
//
//	ls_Ref1Text = lnv_Shipment.of_GetRef1Text ( )
//
//	IF Len ( ls_Ref1Text ) > 0 THEN
//		//OK
//	ELSE
//		li_Return = 0
//	END IF
//
//END IF
//
//
//IF li_Return = 1 THEN
//
//	li_Ref1Type = lnv_Shipment.of_GetRef1Type ( )
//
//	CHOOSE CASE li_Ref1Type
//
//	CASE 20, 23, 26  //Container #, Trailer #, Railbox #
//
//		//OK
//
//	CASE ELSE
//
//		ls_Ref1Text = ""
//		li_Return = 0
//
//	END CHOOSE
//
//END IF
//
//
//CHOOSE CASE li_Return
//
//CASE 1, 0
//
//	Parent.Event ue_AssignEquipment ( ls_Ref1Text )
//
////CASE 0
////
////	MessageBox ( ls_MessageHeader, "An equipment reference has not been specified for this shipment." )
//
//CASE -1
//
//	MessageBox ( ls_MessageHeader, "Could not process request.  Request cancelled." )
//
//END CHOOSE
end event

type dw_selection from u_dw_reflist within u_cst_eventrouting_shipment
boolean visible = false
integer x = 306
integer y = 116
integer width = 2423
integer height = 488
integer taborder = 130
boolean bringtotop = true
end type

event ue_selectionchanged;Parent.Event ue_DisplayShipment ( al_id )
//THIS.Visible = FALSE
RETURN 1
end event

event losefocus;THIS.Visible = FALSE
RETURN 0
end event

event ue_key;call super::ue_key;IF Key = KeyEscape! THEN
	sle_shipnum.SetFocus ()
END IF
RETURN 0
end event

type dw_assignmentlist from u_dw_eqassignlist within u_cst_eventrouting_shipment
integer x = 2080
integer y = 140
integer width = 1445
integer height = 196
integer taborder = 110
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;n_cst_Presentation_EquipmentSummary	lnv_Pres
lnv_Pres.of_SetPresentation ( THIS )

THIS.SetTransObject (  SQLCA ) 

end event

event buttonclicked;
//String	ls_equipment
//			
//IF Row > 0 AND Lower ( dwo.Name ) = "cb_assign" THEN
//
//
//	ls_Equipment = THIS.Object.equipment_eq_Ref [ row ]
//	Parent.Event ue_AssignEquipment ( ls_Equipment )
//
//END IF	
//	
String	ls_EqType
String	ls_Ref
Long		ll_EqID

ls_EqType = THIS.of_GetSelectedType ( )
ls_Ref = THIS.of_GetSelectedRef ( )
ll_EqID = THIS.of_GetSelectedID ( )
		
n_cst_Privileges_Events	lnv_Privs
IF lnv_Privs.of_allowalteritins( ) THEN
	IF Len ( ls_EqType ) > 0 AND Len ( ls_Ref ) > 0 AND ROW > 0  AND ll_EqID > 0 THEN
		PARENT.Event ue_assignLinkedEquipment ( ls_EqType , ls_Ref , ll_EqID )
	END IF
ELSE
	MessageBox ( "Assign Equipment" , "You are not authorized to make this change." )
END IF
end event

event ue_getshipment;call super::ue_getshipment;return parent.event ue_getshipment( )
end event

type sle_equipment from singlelineedit within u_cst_eventrouting_shipment
event ue_keydown pbm_keydown
integer x = 2674
integer y = 40
integer width = 466
integer height = 72
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;IF key = KEYENTER! THEN
	PARENT.Event ue_CreateNewEquipment ( )
END IF
end event

type cb_create from commandbutton within u_cst_eventrouting_shipment
integer x = 3163
integer y = 28
integer width = 274
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Create"
end type

event clicked;PARENT.Event ue_CreateNewEquipment ()

//String		ls_Where
//String		ls_Text
//Int			li_Rtn	= 1
//
//DataStore					lds_Results
//n_cst_EquipmentManager	lnv_Manager
//
//ls_Text = TRIM ( sle_equipment.Text ) 
//
//IF Len ( ls_Text ) > 0 THEN
//	ls_Where = "WHERE eq_Status = ~~'K~~' AND eq_ref = ~~'" + ls_Text + "~~'"
//	lnv_Manager.of_Retrieve (  lds_Results ,ls_Where )
//	
//	CHOOSE CASE lds_Results.RowCount ( )
//			
//		CASE 0 // EQUIPMENT DNE
//			
//			// CREATE new Linked Equipment
//			IF PARENT.Event ue_NewEquipment ( ls_Text ) = -1 THEN
//				MessageBox ( "New Equipment" , "An error occurred while attempting to create a new piece of equipment." )
//				li_Rtn = -1
//			ELSE
//				// event above will assign the equipment
//			END IF
//			
//		CASE 1
//			
//			IF IsNull ( lds_Results.object.equipmentLease_Shipment [ 1 ] ) THEN
//				IF MessageBox ( "Specified Equipment" , "A piece of equipment already exists " + & 
//					+"with the reference number you sepcifed. However the equipment is not currently" + &
//					" associated to a shipment.~r~n~r~nClick OK to use this equipment and to link it " + &
//					"to this shipment.  OR~r~nClick Cancel to stop the processing.", INFORMATION! , OKCANCEL! , 1 ) = 1 THEN
//					// use the equipment		
//					
//					// NEED TO DO AN UPDATE ON THE EQUIPMENT HERE
//					IF PARENT.Event ue_LinkEquipment ( lds_Results.object.eq_id [ 1 ] ) <> 1 THEN
//						MessageBox ( "Linking Equipment" , "An error occurred while attempting to link the existing piece of equipment to this shipment." )
//						li_Rtn = -1
//					ELSE
//						PARENT.Event ue_AssignEquipment ( ls_Text )
//					END IF
//					
//				ELSE 
//					// stop the processing
//					li_Rtn = -1
//					//THIS.Event ue_ClearEquipmentSelection ( )
//				END IF
//				
//			ELSE // The equipment is linked to a shipment
//				IF MessageBox ( "Specified Equipment" , "A piece of equipment already exists " + & 
//					+"with the reference number you sepcifed. In addition the equipment is " + &
//					+"linked to shipment " + String ( lds_Results.object.equipmentLease_Shipment [ 1 ] ) + &
//					+" and can not be created again. Do you want to cancel and view this shipment now?" , QUESTION! , YESNO! , 2 ) = 1 THEN
//					// display the shipment
//					PARENT.Event ue_DisplayShipment ( lds_Results.object.equipmentLease_Shipment [ 1 ] )
//					
//					
//					li_Rtn = -1
//				ELSE
//					// stop the processing
//					li_rtn = -1
//					
//				END IF
//				
//			END IF
//			
//		CASE is >= 1 // MULTIPLES FOUND   /// I WILL NEED TO FURTHER THE PROCESSING HERE
//		 	MessageBox( "Specified Equipment" , "Multiple pieces of equipment exist with the specified number. Processing will stop." )
//			li_Rtn = -1
//			
//	END CHOOSE 
//	
//	IF li_Rtn = 1 THEN
//		// 
//		dw_assignmentlist.Retrieve ( il_ShipmentID )
//		
//	END IF
//	
//ELSE 
//	//THIS.Event ue_ClearEquipmentSelection ( )
//	//li_Rtn = -1
//END IF
//
//RETURN li_Rtn
end event

type dw_equipment from u_dw_eqlist within u_cst_eventrouting_shipment
boolean visible = false
integer x = 306
integer y = 116
integer height = 488
integer taborder = 40
boolean bringtotop = true
end type

event losefocus;THIS.Visible = FALSE
end event

event ue_selectionchanged;
long		ll_Row
Long		ll_SelectionID

ll_Row = al_Row

IF ll_Row > 0 THEN
	ll_SelectionID = THIS.getItemNumber ( ll_Row , "outside_equip_shipment" )
	IF ll_SelectionID > 0 THEN
		Parent.Event ue_DisplayShipment ( ll_SelectionID )
		sle_shipnum.SetFocus ( )
	END IF
END IF


RETURN 1
end event

event ue_key;call super::ue_key;IF Key = KeyEscape! THEN
	sle_shipnum.SetFocus ()
END IF
RETURN 0
end event

type cb_1 from commandbutton within u_cst_eventrouting_shipment
integer x = 1467
integer y = 28
integer width = 384
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete &Events"
end type

event clicked;PARENT.Event ue_RemoveEvents ( )
PARENT.Event ue_RefreshEvents ( )
end event

event constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type uo_ip1 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 196
integer width = 114
integer height = 64
integer taborder = 130
end type

on uo_ip1.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type uo_ip2 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 268
integer width = 114
integer height = 64
integer taborder = 140
end type

on uo_ip2.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type uo_ip3 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 332
integer width = 114
integer height = 64
integer taborder = 140
end type

on uo_ip3.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type uo_ip4 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 400
integer width = 114
integer height = 64
integer taborder = 150
end type

on uo_ip4.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type uo_ip8 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 672
integer width = 114
integer height = 64
integer taborder = 160
end type

on uo_ip8.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type uo_ip6 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 536
integer width = 114
integer height = 64
integer taborder = 150
end type

on uo_ip6.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type uo_ip5 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 468
integer width = 114
integer height = 64
integer taborder = 140
end type

on uo_ip5.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type uo_ip7 from u_cst_insertionpoint within u_cst_eventrouting_shipment
integer y = 600
integer width = 114
integer height = 64
integer taborder = 150
end type

on uo_ip7.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;call super::ue_clicked;Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
end event

type dw_ship_itin from u_dw_eventlist within u_cst_eventrouting_shipment
event ue_loaddriveritinerary ( long al_row )
event ue_loadtractoritinerary ( long al_row )
integer x = 114
integer y = 140
integer width = 1961
integer height = 580
integer taborder = 170
string dataobject = "d_ship_itin"
end type

event ue_loaddriveritinerary(long al_row);Long	lla_Driver[]
Long	lla_PowerUnit[]
Date	ld_DateArrived
n_cst_bso_Dispatch	lnv_Dispatch

n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lnv_Dispatch = Parent.Event ue_GetDispatchManager () 

lnv_Event.of_SetSource ( dw_ship_itin ) 
lnv_Event.of_SetSourceRow ( al_row )

lnv_Event.of_GetAssignments ( lla_Driver , lla_PowerUnit )
ld_DateArrived = lnv_Event.of_getDateArrived ( ) 


IF UpperBound ( lla_Driver ) > 0 THEN
	Parent.Event ue_GetItineraryWindow ( ).display_itin(gc_Dispatch.ci_itinType_driver, lla_Driver[1], ld_DateArrived)
END IF

DESTROY lnv_Event
end event

event ue_loadtractoritinerary(long al_row);Long	lla_Driver[]
Long	lla_PowerUnit[]
Date	ld_DateArrived
n_cst_bso_Dispatch	lnv_Dispatch

n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lnv_Dispatch = Parent.Event ue_GetDispatchManager () 

lnv_Event.of_SetSource ( dw_ship_itin ) 
lnv_Event.of_SetSourceRow ( al_row )

lnv_Event.of_GetAssignments ( lla_Driver , lla_PowerUnit )
ld_DateArrived = lnv_Event.of_getDateArrived ( ) 


IF UpperBound ( lla_PowerUnit ) > 0 THEN
	Parent.Event ue_GetItineraryWindow ( ).display_itin(gc_Dispatch.ci_itinType_Powerunit, lla_PowerUnit[1], ld_DateArrived)
END IF

DESTROY lnv_Event
end event

event ue_getshipment;call super::ue_getshipment;RETURN Parent.Event ue_GetShipment ( )
end event

event ue_getdispatchmanager;call super::ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatchManager ( ) 
end event

event constructor;call super::constructor;n_cst_LicenseManager	lnv_LicenseManager
Integer	li_BaseTimeZone
n_cst_Dws		lnv_Dws
n_cst_Events	lnv_Events

lnv_Dws.of_CreateHighlight ( This )

li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )
This.Modify ( "comp_tz_home.Expression = '" + String ( li_BaseTimeZone ) + "'" )

This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
end event

event rbuttondown;// over ride
any 		laa_parm_values[]
String 	lsa_parm_labels[]

IF Row > 0 AND ib_allowmodifyshipment THEN
	THIS.SetRow ( ROW )


	CHOOSE CASE dwo.name
			
		CASE "de_event_type" 
			THIS.SetRow ( row )
			THIS.Post Event ue_ShowEventMenu ( row )
			
	END CHOOSE
ELSEIF ib_Allowmodifyshipment THEN
	
	n_cst_Privileges_Events	lnv_Privs
	IF THIS.Enabled = lnv_Privs.of_allowalteritins( ) THEN
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "&Delete Selected Events"
			
				
		IF UpperBound( laa_parm_values ) > 0 THEN
			CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
					
				CASE "DELETE SELECTED EVENTS"
					IF PARENT.Event ue_RemoveEvents ( ) = 1 THEN
						PARENT.Event ue_RefreshEvents ( )
					END IF
					
			END CHOOSE
		END IF
	END IF
	
END IF
end event

event ue_showeventmenu;// OVERRIDE
any 		laa_parm_values[]
String 	lsa_parm_labels[]
String	ls_TempType
String	ls_AddType
String	ls_PopRtn
Long		ll_EventID
Long		ll_ShipmentID
Long		ll_return = 1
Long		ll_TempEventID
Long		ll_SelectedRow
Long		lla_SelectedRows[]
Long		lla_NewID[]
Long		ll_NewID
Long		ll_SiteID

S_Parm					lstr_Parm
n_cst_Msg				lnv_Msg
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_LicenseManager	lnv_License
n_cst_Beo_Event		lnv_Event
n_cst_Beo_Shipment	lnv_Shipment
n_cst_ShipmentManager	lnv_ShipmentManager

ll_SelectedRow = 0 

THIS.SetRedraw ( FALSE )
PowerObject lpo_Parent
lpo_Parent = THIS.GetParent ( ) 
DO
	IF IsValid ( lpo_Parent ) THEN
		IF lpo_Parent.Classname( ) = "w_itin" THEN
			lpo_Parent.Dynamic wf_SetHoldRedraw ( TRUE )
			lpo_Parent.Dynamic wf_SetRedraw ( FALSE ) 
			EXIT
		END IF
		lpo_Parent = lpo_Parent.GetParent ( ) 
	END IF
	
Loop While isValid ( lpo_Parent )


lnv_Event = CREATE n_cst_beo_event
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

IF THIS.RowCount ( ) > 0 AND al_row = THIS.RowCount ( ) THEN
	THIS.SetRow ( 1 ) 
END IF
n_cst_Privileges_Events	lnv_Privs
IF lnv_Privs.of_allowAlteritins( ) THEN
	PARENT.of_ConstructSwitchingOptions ( al_Row , lnv_Msg )
END IF

IF lnv_Msg.of_Get_Parm ( "LABELS" , lstr_Parm ) <> 0 THEN
	lsa_parm_labels = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "VALUES" , lstr_Parm ) <> 0 THEN
	laa_parm_values = lstr_Parm.ia_Value
END IF



IF isValid ( lnv_Dispatch ) THEN
	
	IF UpperBound ( lsa_Parm_Labels ) > 0 THEN
		lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
	END IF
	
	lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Load Driver Itinerary"

	lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Load Tractor Itinerary"
	
ELSE
	ll_return = -1
END IF


IF ll_Return <> -1 THEN
	ls_PopRtn = f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
END IF


IF ll_return = 1 AND Len ( ls_PopRtn ) > 0 then
	
	lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventCache ( ) )
	lnv_Event.of_setSourceID (  THIS.GetItemNumber ( al_row , "de_id" ) )
	ll_EventID = lnv_Event.of_GetID () 
	
	
	DO 
		
		ll_SelectedRow = THIS.GetSelectedRow ( ll_SelectedRow )
		IF ll_SelectedRow > 0 THEN
			lla_SelectedRows [ UpperBound ( lla_SelectedRows ) + 1 ] = ll_SelectedRow
		END IF
		
	LOOP WHILE ll_SelectedRow > 0
	
	
	CHOOSE CASE ls_PopRtn
			
			
		CASE "LOAD DRIVER ITINERARY"
			THIS.Event ue_LoadDriverItinerary ( al_row )
				
		CASE "LOAD TRACTOR ITINERARY"
			THIS.Event ue_LoadTractorItinerary ( al_row )
	

		CASE "CONVERT TO DISMOUNT" ,"CONVERT TO DISMOUNT AND MOUNT"
			ls_TempType =  dw_ship_itin.GetItemString ( al_Row , "de_event_type" ) 
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Dismount ) = 1 THEN
				IF ls_TempType = gc_Dispatch.cs_EventType_Deliver AND &
					ls_PopRtn = "CONVERT TO DISMOUNT AND MOUNT" THEN
					// add a Mount After the Dismount event
					ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
					lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Mount , al_Row + 1 , lnv_Dispatch , ll_NewId , ll_SiteID )
	//				lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Mount , al_Row + 1 , lnv_Dispatch , ll_NewId )
				END IF
			END IF
			
			
		CASE "CONVERT TO DROP" ,"CONVERT TO DROP AND HOOK"
			ls_TempType =  dw_ship_itin.GetItemString ( al_Row , "de_event_type" ) 
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Drop ) = 1 THEN
				IF ls_TempType = gc_Dispatch.cs_EventType_Deliver AND &
					ls_PopRtn = "CONVERT TO DROP AND HOOK" THEN
					// add a Hook After the DROP event
					ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
					lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Hook , al_Row + 1 , lnv_Dispatch , ll_NewId , ll_SiteID )
				END IF
			END IF
					
		CASE "CONVERT TO MOUNT" ,"CONVERT TO MOUNT AND DISMOUNT"
			ls_TempType =  dw_ship_itin.GetItemString ( al_Row , "de_event_type" ) 
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Mount ) = 1 THEN
				IF ls_TempType = gc_Dispatch.cs_EventType_PickUp AND &
					ls_PopRtn = "CONVERT TO MOUNT AND DISMOUNT" THEN
					// add a Dismount before the HOOK event
					ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
					lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Dismount , al_Row , lnv_Dispatch , ll_NewId , ll_SiteID  )
					//lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Dismount , al_Row , lnv_Dispatch , ll_NewId )
				END IF
			END IF
			
			
		CASE "CONVERT TO HOOK" , "CONVERT TO HOOK AND DROP"
			ls_TempType =  dw_ship_itin.GetItemString ( al_Row , "de_event_type" ) 
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Hook ) = 1 THEN
				IF ls_TempType = gc_Dispatch.cs_EventType_PickUp  AND &
					ls_PopRtn = "CONVERT TO HOOK AND DROP" THEN
					// add a DROP before the HOOK event
					ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
					lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_DROP , al_Row , lnv_Dispatch , ll_NewId , ll_SiteID )
				//	lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_DROP , al_Row , lnv_Dispatch , ll_NewId )
				END IF	
			END IF
			
			
			
		CASE "CONVERT TO PICKUP"  // and,  if the previous event is a Drop or dismount, Remove it
			
			IF UpperBound ( lla_SelectedRows ) = 2 THEN
				
				IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent

					//find the row that will be switched to the pickup
					lnv_Event.of_SetSourceRow ( lla_selectedRows [1] )
					
					IF lnv_Event.of_IsPickupGroup ( )  THEN
						ll_EventID = lnv_Event.of_GetID ( )
						ls_TempType = THIS.GetItemString ( lla_selectedRows [2] , "de_event_type" )
						ll_TempEventID = THIS.GetItemNumber ( lla_selectedRows [2] , "de_ID" )
					ELSE
						lnv_Event.of_SetSourceRow ( lla_SelectedRows[2] )
						IF lnv_Event.of_IsPickupGroup ( ) THEN
							ll_EventID = lnv_Event.of_GetID ( )
							ls_TempType = THIS.GetItemString ( lla_selectedRows [1] , "de_event_type" )
							ll_TempEventID = THIS.GetItemNumber ( lla_selectedRows [1] , "de_ID" )
						END IF
					END IF
				
					
					IF lnv_Dispatch.of_SwitchToPickUP ( ll_EventID  ) = 1 THEN
						THIS.of_Pickupadded( al_row )	
						lnv_Dispatch.of_Remove ( {ll_TempEventID} )  // remove the routing b/f deletion
						IF il_ShipmentID > 0 THEN
							
						//	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
						//lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )					
							lnv_Shipment.of_RemoveEvents ( {ll_TempEventID} , lnv_Dispatch )
						END IF	
						
						
					END IF
				END IF
			ELSE				
				lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_PickUp )
				THIS.of_Pickupadded( al_row )	
			END IF
			
		CASE "CONVERT TO DELIVER"
			
			IF UpperBound ( lla_SelectedRows ) = 2 THEN
				
				IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent

					//find the row that will be switched to the pickup
					lnv_Event.of_SetSourceRow ( lla_selectedRows [1] )
					IF lnv_Event.of_IsPickupGroup ( )  THEN
						ll_EventID = lnv_Event.of_GetID ( )
						ls_TempType = THIS.GetItemString ( lla_selectedRows [2] , "de_event_type" )
						ll_TempEventID = THIS.GetItemNumber ( lla_selectedRows [2] , "de_ID" )
					ELSE  // try the second selected row
						lnv_Event.of_SetSourceRow ( lla_SelectedRows[2] )
						IF lnv_Event.of_IsPickupGroup ( ) THEN
							ll_EventID = lnv_Event.of_GetID ( )
							ls_TempType = THIS.GetItemString ( lla_selectedRows [1] , "de_event_type" )
							ll_TempEventID = THIS.GetItemNumber ( lla_selectedRows [1] , "de_ID" )
						END IF
					END IF
					
					IF lnv_Dispatch.of_SwitchToDeliver ( ll_EventID  ) = 1 THEN
						THIS.of_DeliverAdded( al_row )
						lnv_Dispatch.of_Remove ( {ll_TempEventID} )  // remove the routing b/f deletion
						IF il_ShipmentID > 0 THEN
						//	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
						//	lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )					
							lnv_Shipment.of_RemoveEvents ( {ll_TempEventID} , lnv_Dispatch )
						END IF		
						
					END IF
				END IF
			ELSE
				lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Deliver )
				THIS.of_DeliverAdded( al_row )
			END IF
			
			
		CASE "ADD CHASSIS PICKUP"  ,"ADD CHASSIS RETURN" 
			THIS.Event ue_AddChassisSplit ( al_row )
			
			
		CASE "REMOVE CHASSIS PICKUP"
			lnv_ShipmentManager.of_Removefrontchassissplit( lnv_Shipment, lnv_dispatch )
			
			
		CASE "REMOVE CHASSIS RETURN"
			lnv_ShipmentManager.of_RemoveBackChassissplit( lnv_Shipment, lnv_dispatch )
			
	END CHOOSE 
	
	Parent.Post of_DisplayShipment ( il_ShipmentID )
	PARENT.Event ue_GetItineraryWindow ( ).Post Event ue_RefreshItinerary ( TRUE )
	
END IF

dw_ship_itin.SetRedraw ( TRUE )

//DESTROY ( lnv_Shipment )
DESTROY ( lnv_Event )


end event

event itemchanged;// over ride w. call to super
Int	li_Return



IF THIS.GetItemString ( row , 'de_conf' ) = 'T' THEN
	MessageBox ("Event Information" , "Changes cannot be made to confirmed events." )
	li_Return = 2 // Reject the data value but allow the focus to change
ELSE
	IF ib_allowmodifyshipment THEN
		li_Return = SUPER::event itemchanged( Row , dwo , data )
		
		//IF li_Return = 0 THEN 
			Parent.of_Displayshipment( il_shipmentid )
		//END IF
	ELSE
		li_Return = 2
	END IF
END IF	

RETURN li_Return
end event

event ue_refreshshipment;call super::ue_refreshshipment;Parent.of_displayevents ( il_ShipmentID )
end event

event ue_addcrossdock;call super::ue_addcrossdock;IF ancestorReturnValue = 1 THEN
	PARENT.Event ue_GetItineraryWindow ( ).Event ue_RefreshItinerary ( TRUE )
	THIS.Post Event ue_SetRow ( al_row ) 
	THIS.Post SetColumn ( "co_name" )
	THIS.Post SetFocus ( )
END IF



RETURN AncestorReturnValue
end event

event ue_addyardmove;call super::ue_addyardmove;IF ancestorReturnValue = 1 THEN
	PARENT.Event ue_GetItineraryWindow ( ).Event ue_RefreshItinerary ( TRUE )
	THIS.Post Event ue_SetRow ( al_row ) 
	THIS.Post SetColumn ( "co_name" )
	THIS.Post SetFocus ( )
END IF

RETURN AncestorReturnValue
end event

event ue_showeventselections;call super::ue_showeventselections;//MessageBox ( "a" ,"Adding Descendant ue_ShowEventSelection" )
Long		ll_return = 1
Long		ll_EventID

n_cst_beo_Shipment	lnv_Shipment
n_cst_Bso_Dispatch	lnv_Dispatch

n_cst_beo_Event lnv_event 					
lnv_event = Create n_cst_beo_Event		

lnv_Dispatch = THIS.Event ue_GetDispatchmanager ( )
lnv_Shipment = THIS.event ue_getshipment( )

IF al_Row > 0 THEN
	ll_EventID = THIS.GetItemNumber ( al_row , "de_id" )
END IF

IF isValid ( lnv_Dispatch ) THEN
	lnv_Event.of_SetSource( lnv_Dispatch.of_geteventcache( ) )
	lnv_event.of_SetSourceID ( ll_EventID	 )
END IF

lnv_Event.of_SetShipment( lnv_Shipment )
lnv_Event.of_SetAllowFilterSet ( TRUE ) 

THIS.SetRedraw ( FALSE )
IF IsNull ( lnv_Event.of_GetType ( ) ) OR lnv_Event.of_GetType ( ) = "" THEN
	lnv_Shipment.of_removeEvents( {ll_EventID} ,lnv_Dispatch, TRUE )
END IF


//IF ll_Return = 1 THEN
//	THIS.Event ue_Refresh ( )
//END IF

THIS.SelectRow ( 0, FALSE )
THIS.SetRedraw ( TRUE )
PowerObject lpo_Parent
lpo_Parent = THIS.GetParent ( ) 
DO
	IF IsValid ( lpo_Parent ) THEN
		IF lpo_Parent.Classname( ) = "w_itin" THEN
			
			lpo_Parent.Dynamic wf_SetRedraw ( TRUE ) 
			EXIT
		END IF
		lpo_Parent = lpo_Parent.GetParent ( ) 
	END IF
	
Loop While isValid ( lpo_Parent )

Destroy ( lnv_event )	


end event

event ue_preaddchassissplit;Long		ll_EventID

n_cst_beo_Shipment	lnv_Shipment
n_cst_Bso_Dispatch	lnv_Dispatch

n_cst_beo_Event lnv_event 					
lnv_event = Create n_cst_beo_Event		

lnv_Dispatch = THIS.Event ue_GetDispatchmanager ( )
lnv_Shipment = THIS.event ue_getshipment( )

THIS.SetRow ( al_row )

IF al_Row > 0 THEN
	ll_EventID = THIS.GetItemNumber ( al_row , "de_id" )
END IF

IF isValid ( lnv_Dispatch ) THEN
	lnv_Event.of_SetSource( lnv_Dispatch.of_geteventcache( ) )
	lnv_event.of_SetSourceID ( ll_EventID	 )
END IF

lnv_Event.of_SetShipment( lnv_Shipment )
lnv_Event.of_SetAllowFilterSet ( TRUE ) 

THIS.SetRedraw ( FALSE )
IF IsNull ( lnv_Event.of_GetType ( ) ) OR lnv_Event.of_GetType ( ) = "" THEN
//	lnv_Event.of_SetType ( gc_dispatch.cs_eventtype_misc ) // we need a type to delete it
	lnv_Shipment.of_removeEvents( {ll_EventID} ,lnv_Dispatch, TRUE )
END IF

THIS.Event ue_AddChassisSplit ( al_row ) 
//THIS.Event ue_ActionEventAdded ( )

THIS.SetRedraw ( TRUE )

Destroy ( lnv_event )
PARENT.Event ue_GetItineraryWindow ( ).Post Event ue_RefreshItinerary ( TRUE )
THIS.SetColumn( "co_name" )

RETURN 1
end event

event ue_changesite;call super::ue_changesite;IF AncestorReturnValue = 1 THEN
	Parent.event ue_SiteChanged ( )
END IF

RETURN AncestorReturnValue
end event

event ue_addbobtailset;// RDT 5-26-03 Changed to use beo_Event

Long		ll_Return 
Long		ll_RowCount 
Long		lla_NewIds[]
Boolean	lb_Front
Boolean	lb_Back
Boolean	lb_Continue = TRUE
String	ls_message
Long		ll_OriginEvent
Long		ll_DestEvent

THIS.SetRedraw ( FALSE ) 

n_cst_bso_Dispatch	lnv_Dispatch
lnv_Dispatch = THIS.Event ue_getDispatchManager ( )

n_cst_beo_shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )


n_cst_beo_Event  lnv_Event					
lnv_Event = Create n_cst_beo_Event  	
IF IsValid ( lnv_Dispatch ) THEN
	lnv_Event.of_SetAllowFilterSet ( TRUE )
	lnv_Event.of_SetSource( lnv_Dispatch.of_geteventcache( ) ) 			
END IF

IF lnv_Shipment.of_AddEvents ( {''} , al_row   , lnv_Dispatch , lla_NewIds[] ) = 1 THEN

	THIS.event ue_RefreshShipment ( )			
	
	lnv_Dispatch.of_FilterShipment ( lnv_Shipment.of_GetID () )
	ll_OriginEvent = lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row ,"de_id" )
	ll_DestEvent = lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row + 1 ,"de_id" )
	
	lnv_Event.of_SetSourceID ( ll_OriginEvent  )															
	lnv_Event.of_SetType( gc_Dispatch.cs_Eventtype_Hook  )
	lnv_Event.of_SetBobtailLocations ( ll_OriginEvent , ll_DestEvent ) 
	
	lnv_Event.of_SetSourceID ( ll_DestEvent )
	lnv_Event.of_SetType( gc_Dispatch.cs_Eventtype_Drop )	
	lnv_Event.of_SetBobtailLocations ( ll_OriginEvent , ll_DestEvent ) 
	
	
	THIS.of_BobtailAdded ( al_Row ) 

	IF al_Row > 1 THEN
		lla_NewIds [ UpperBound ( lla_NewIds ) + 1 ] = lnv_Event.of_GetID ( )
		//lnv_Dispatch.of_DuplicateRouting ( lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row - 1 ,"de_id" )  ,lla_NewIds, gc_dispatch.ci_InsertionStyle_After )												
		THIS.Post event ue_RefreshShipment ( )			
	END IF
END IF
	
Destroy ( lnv_Event )  

THIS.Post SetRedraw ( TRUE ) 
RETURN ll_Return
end event

