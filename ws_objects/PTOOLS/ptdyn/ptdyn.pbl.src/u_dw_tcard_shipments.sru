$PBExportHeader$u_dw_tcard_shipments.sru
forward
global type u_dw_tcard_shipments from u_dw_tcard
end type
end forward

global type u_dw_tcard_shipments from u_dw_tcard
string title = "Shipments"
string icon = "shipment1.ico"
event ue_shipmentdetail ( long al_row )
event ue_copytext ( string as_columnname )
event ue_shownotes ( long al_shipmentid )
event type integer ue_duplicate ( )
event type integer ue_setloadbuilder ( boolean ab_switch )
event type integer ue_updateloadbuilder ( )
event type long ue_getselectedids ( ref long ala_ids[] )
event ue_loadbuilder ( )
end type
global u_dw_tcard_shipments u_dw_tcard_shipments

type variables
Protected:
w_LoadBuilder	iw_LoadBuilder
end variables

forward prototypes
public function integer of_setrestriction (boolean ab_switch)
end prototypes

event ue_shipmentdetail(long al_row);//Copied from u_dw_ShipmentList
//Changed hard reference to ds_id to a read of the first column

Long	ll_Row, &
		ll_Id
n_cst_ShipmentManager	lnv_ShipmentManager

IF This.RowCount ( ) > 0 THEN

	IF al_Row > 0 THEN
	
		ll_Row = al_Row
	
	ELSE
	
		ll_Row = This.GetSelectedRow ( 0 )
	
		IF ll_Row > 0 THEN
	
			//OK
	
		ELSE
	
			ll_Row = This.GetRow ( )
	
		END IF
	
	END IF

END IF


IF ll_Row > 0 THEN

	ll_Id = This.GetItemNumber ( ll_Row, 1 )  //Revise later??
	
	IF	lnv_shipmentManager.of_shipmentexists( ll_id ) THEN
		lnv_ShipmentManager.of_OpenShipment ( ll_Id )
	ELSE
		Messagebox("Open Shipment", "The shipment "+string( ll_id )+" does not exist. It is likely to have been deleted." )
		this.setredraw( FALSE )
		this.event ue_reload( )
		THIS.setRedraw( true )
	END IF
END IF
end event

event ue_copytext(string as_columnname);Long	lla_SelectedRows [ ]
Long	ll_Count
Long	i
String	lsa_Working[]
String	ls_Temp

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


IF isValid ( inv_rowselect ) THEN
	
	SetPointer ( HOURGLASS! )
	
	ll_Count = inv_rowselect.of_SelectedCount ( lla_SelectedRows )	
	
	IF ll_Count = 0 THEN  // use current
		IF THIS.GetRow ( ) > 0 THEN
			lla_SelectedRows [1] = THIS.GetRow ( )
			ll_Count = 1
		END IF
		
	END IF
	
	FOR i = 1 TO ll_Count
		ls_Temp = TRIM ( THIS.GetItemString ( lla_SelectedRows[i] , as_columnname ) )
		IF Len ( ls_Temp ) > 0 THEN
			lsa_Working [ UpperBound ( lsa_Working ) + 1 ] = ls_Temp
		END IF
	NEXT
			
	lstr_Parm.is_Label = "TEXT"
	lstr_Parm.ia_Value = lsa_Working
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	openWithParm ( w_RefTextFormat , lnv_Msg )
			
END IF


end event

event ue_shownotes(long al_shipmentid);n_cst_Msg lnv_Msg
s_parm lstr_parm

lstr_parm.is_label = "TARGET_ID"
lstr_parm.ia_value = al_ShipmentId

lnv_Msg.of_add_parm(lstr_parm)

OpenWithParm(w_NoteShower,lnv_Msg)
end event

event type Int ue_duplicate();

Long		ll_Row, &
			ll_Id
			
Long		lla_SelectedRows[]
Long		lla_SelectedIDs[]
Long		ll_SelectedCount
Long		i

String	ls_Message, &
			ls_MessageHeader = "Duplicate Shipment", &
			ls_Text
		
Int		li_Type

Integer	li_Return = 1

n_cst_Msg	lnv_msg
S_Parm		lstr_Parm

IF IsValid ( inv_rowselect ) THEN
	ll_SelectedCount = inv_rowselect.of_SelectedCount ( lla_SelectedRows )
END IF

IF ll_SelectedCount = 1 THEN
	
	ll_Row = lla_SelectedRows[1]
	
	ll_Id = This.Object.ds_Id [ ll_Row ]
	lstr_Parm.ia_Value = ll_ID
	lstr_Parm.is_Label = "SHIPMENT"
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	ls_Text = This.object.Shipment_Ref1Text [ ll_Row ]
	li_Type = This.object.Shipment_Ref1Type [ ll_Row ]

	IF Not isNull ( ls_Text ) AND ( li_Type = 20 OR li_Type = 26 OR li_Type = 28 ) THEN

		lstr_Parm.is_Label = "EQREF"
		lstr_Parm.ia_Value =  This.object.Shipment_Ref1Text [ ll_Row ]
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		IF li_Type = 20 THEN
			lstr_Parm.ia_Value = 'C'
		ELSEIF li_Type = 26 THEN 
			lstr_Parm.ia_Value = 'B'
		ELSE
			lstr_Parm.ia_Value = 'H'
		END IF
		lstr_Parm.is_Label = "TYPE"
		lnv_Msg.of_Add_Parm  ( lstr_Parm ) 
		
	
	END IF

ELSEIF ll_selectedCount > 1 THEN
	
	FOR i = 1 TO ll_SelectedCount 
		lla_SelectedIDs [i] = This.Object.ds_Id [ lla_SelectedRows[i] ]
	NEXT
	
	lstr_Parm.ia_Value = lla_SelectedIDs
	lstr_Parm.is_Label = "MULTIPLESHIPMENTS"
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
ELSE
	
	ls_Message = "Please select a shipment to duplicate."
	li_Return = 0
END IF



IF li_Return = 1 THEN
	OpenWithParm ( w_DuplicateWithEquipment, lnv_msg )

ELSEIF li_Return < 1 AND Len ( ls_Message ) > 0 THEN
	MessageBox ( ls_MessageHeader, ls_Message )
END IF

RETURN li_Return
end event

event type integer ue_setloadbuilder(boolean ab_switch);//Returns : 1 = Requested action taken, 
//0 = Requested state already in effect.  If request is TRUE and window has been minimized,
//it will be restored.
//-1 = Error.

Integer	li_Return = -1

IF IsNull ( ab_Switch ) THEN
	//li_Return = -1

ELSEIF IsValid ( iw_LoadBuilder ) = ab_Switch THEN

	li_Return = 0

	//If the window is already open, restore it if it's been minimized.
	IF IsValid ( iw_LoadBuilder ) THEN
		iw_LoadBuilder.WindowState = Normal!
	END IF

ELSEIF ab_Switch = TRUE THEN
	
	Long	lla_Ids[]
	THIS.event ue_getselectedids( lla_Ids )
	
	Open ( iw_LoadBuilder )
	
	
	
//	This.Event ue_UpdateLoadBuilder ( )
	iw_loadbuilder.wf_setshipmentlist( lla_Ids )
	li_Return = 1

ELSEIF ab_Switch = FALSE THEN
	Close ( iw_LoadBuilder )
	li_Return = 1

END IF

RETURN li_Return
end event

event type integer ue_updateloadbuilder();//Returns : 1 = Load builder open, and display updated.
//0 = Load builder not open, so request does not apply and has been ignored.
//-1 = Error (not currently implemented)

Long	lla_Ids[]
Long	lla_Rows[]
Long	i
Integer	li_Return = 0

IF IsValid ( iw_LoadBuilder ) THEN

	IF IsValid ( inv_rowselect ) THEN
		inv_rowselect.of_Selectedcount( lla_rows )
		FOR i = 1 TO UpperBound ( lla_Rows ) 
			lla_Ids [ i] = THIS.GetItemNumber ( lla_Rows[i] , "ds_id" ) 
		NEXT
	END IF
	//This.Event ue_GetSelectedIds ( lla_Ids )
	iw_LoadBuilder.wf_SetShipmentList ( lla_Ids )
	li_Return = 1

END IF

RETURN li_Return
end event

event type long ue_getselectedids(ref long ala_ids[]);//Returns : >= 0 (The number of rows selected.  The corresponding ids are 
//passed out in ala_Ids )

Long	ll_SelectedCount, &
		lla_SelectedIds[], &
		ll_Row

//IF This.GetSelectedRow ( 0 ) > 0 THEN
//	lla_SelectedIds = This.Object.ds_id.Selected
//	ll_SelectedCount = UpperBound ( lla_SelectedIds )
//END IF

This.SetRedraw ( TRUE )

DO

	ll_Row = This.GetSelectedRow ( ll_Row )

	IF ll_Row > 0 THEN
		ll_SelectedCount ++
		lla_SelectedIds [ ll_SelectedCount ] = This.Object.ds_id [ ll_Row ]
	END IF

LOOP WHILE ll_Row > 0

ala_Ids = lla_SelectedIds

RETURN ll_SelectedCount
end event

event ue_loadbuilder();THIS.event ue_setloadbuilder( TRUE )
end event

public function integer of_setrestriction (boolean ab_switch);Integer	li_Return = NO_ACTION

//Check arguments
If IsNull(ab_switch) Then
	li_Return = FAILURE
ELSEIF ab_Switch THEN
	IF IsNull(inv_restriction) Or Not IsValid (inv_restriction) THEN
		inv_restriction = Create n_cst_dwsrv_restrict_shipments		
		inv_restriction.of_SetRequestor ( THIS )
		li_Return = SUCCESS
	END IF
ELSE 
	IF IsValid (inv_restriction) THEN
		Destroy inv_restriction
		Return SUCCESS
	END IF	
END IF

Return li_Return
end function

on u_dw_tcard_shipments.create
end on

on u_dw_tcard_shipments.destroy
end on

event ue_getcategory;/***************************************************************************************
NAME: 		getCategory	

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			string
	
DESCRIPTION: 	returns the category of this type
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/

//overides ancestor
return "shipments"
end event

event ue_getidcolumn;call super::ue_getidcolumn;/***************************************************************************************
NAME: 			ue_getIDCol

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			String
	
DESCRIPTION:	
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/

return ancestorReturnValue
end event

event ue_seticon;//overides ancestor, allows this type of dw to choose its own drag icon
//based on data specific to this kind of window
//end comment by appeon 20070727

end event

event ue_setdragicon;call super::ue_setdragicon;/***************************************************************************************
NAME: 		ue_setdragicon 	

ACCESS:			Public
		
ARGUMENTS: 		
							None

RETURNS:			None
	
DESCRIPTION:	Logic for choosing an icon for this kind of tcard
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/


this.DragIcon = "shipment1.ico"
end event

event ue_getcacheds;//overrides ancestor

Datastore 	lds_Cache

n_cst_ShipmentManager	lnv_ShipmentManager

lnv_ShipmentManager.of_refreshShipments(false)
lds_Cache = lnv_ShipmentManager.of_get_ds_ship( )
return lds_Cache
end event

event dragdrop;call super::dragdrop;//IF a driver or piece of equipment is dropped on the shipment, then do autorouting and make
//the assigment.
Integer	li_ItinType
Long		ll_ItinId, &
			ll_ShipmentId, &
			ll_Null
Date		ld_ItinDate
String	ls_ColType
Long		ll_ComputeRow
Boolean	lb_ForceItinSelect

u_dw_Tcard	ldw_Tcard
n_cst_ShipmentManager	lnv_ShipmentManager



SetNull ( ll_Null )


//this is logic for dealing with groups, it will reset the current row
//if the thing dropped on is a header or trailer and set the current row
//to the first row in the group.
IF row = 0 THEN
	row = this.of_doGroupRowCalculation( )
	IF row = -1 THEN
		row = 0
	END IF
END IF


IF IsValid ( Source ) AND Row > 0 THEN
	
	IF Source.TriggerEvent ( "ue_IsTcard" ) = 1 THEN
		
		ldw_Tcard = Source
		
		ll_ShipmentId = This.GetItemNumber ( Row, 1 )  //Revise!?
		ld_ItinDate = Date ( DateTime ( Today ( ) ) ) //Strip Unwanted time component   Revise?!
		
		//Check if routedate compute exists
		ls_ColType = ldw_Tcard.Describe("routedate.coltype")
		IF Upper(ls_ColType) = "DATETIME" THEN //if compute does not exist ("!", "?")
			//Compute in header can be accessed with firstrowonpage
			ll_ComputeRow = Long(ldw_Tcard.Describe("DataWindow.FirstRowOnPage"))
			IF ll_ComputeRow > 0 THEN
				ld_ItinDate = Date(ldw_Tcard.GetItemDateTime(ll_ComputeRow, "routedate"))
			END IF
		END IF 
		
		
		IF KeyDown( KeyControl! ) THEN
			lb_ForceItinSelect = TRUE //Show Intin selection window even if all intin values are known
		END IF	
		
		IF ldw_Tcard.Event ue_GetItinAssignment ( ll_Null, li_ItinType, ll_ItinId ) = 1 THEN
			
			lnv_ShipmentManager.of_AutoRoute ( li_ItinType, ll_ItinId, ld_ItinDate, ll_ShipmentId, lb_ForceItinSelect)
			//call refresh on the main window
			//*******Refresh only if the cache has been updated******** 
			//handled by window
			this.inv_myPropManager.EVENT post ue_requestRefresh()
		END IF
		
	END IF
	
END IF

end event

event ue_dropnotify;call super::ue_dropnotify;Integer	li_itinType
Long		ll_ItinId, &
			ll_ShipmentId, &
			ll_row, &
			ll_Null
			
Date		ld_ItinDate
String	ls_ColType
Long		ll_ComputeRow
Boolean	lb_ForceItinSelect
//If this object was dropped on the target object, and the target object is a Tcard, then
//we want to know what the Itinerary assignement is.  IF the object is a driver or equipment,
//then it goes ahead to do the autorouting.
u_dw_Tcard	ldw_Tcard
n_cst_ShipmentManager	lnv_ShipmentManager

SetNull ( ll_Null )
ll_row = this.getRow( )

IF IsValid ( adrg_target ) AND al_row > 0  THEN
	
	IF adrg_Target.TriggerEvent ( "ue_IsTcard" ) = 1 THEN
		
		ldw_Tcard = adrg_target
		
		
		ll_ShipmentId = This.GetItemNumber ( ll_row, 1 )  //Revise!?
		ld_ItinDate = Date ( DateTime ( Today ( ) ) ) //Strip Unwanted time component   Revise?!
		
		//Check if routedate compute exists
		ls_ColType = ldw_Tcard.Describe("routedate.coltype")
		IF Upper(ls_ColType) = "DATETIME" THEN //if compute does not exist ("!", "?")
			//Compute in header can be accessed with firstrowonpage
			ll_ComputeRow = Long(ldw_Tcard.Describe("DataWindow.FirstRowOnPage"))
			IF ll_ComputeRow > 0 THEN
				ld_ItinDate = Date(ldw_Tcard.GetItemDateTime(ll_ComputeRow, "routedate"))
			END IF
		END IF 
		
		
		IF KeyDown( KeyControl! ) THEN
			lb_ForceItinSelect = TRUE //Show Intin selection window even if all intin values are known
		END IF	
	
		IF ldw_Tcard.Event ue_GetItinAssignment ( ll_Null, li_ItinType, ll_ItinId ) = 1 THEN
			
			lnv_ShipmentManager.of_AutoRoute ( li_ItinType, ll_ItinId, ld_ItinDate, ll_ShipmentId, lb_ForceItinSelect)
			
		END IF
		
	END IF
	
END IF
Return 1
end event

event rbuttonup;//Overriding ancestor script to intervene with special popup selections for certain objects.
//If no special processing is appropriate, forwards request to ancestor for default processing.
// RDT 8-20-03 Refresh if Auto Routing
// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos

// BKW 02-09-04 3.8.02 Change logic for handling right click on next event info.
//   This is now specific to whether you're clicking on powerunit or driver fields.
//   The nextevent fields that have actions associated are powerunit_..., driver_..., and site


string	ls_Name, &
			ls_IdColumn, &
			lsa_parm_labels[]
any		laa_parm_values[]

Long		ll_EquipmentId, &
			ll_NextEventId
Date		ld_ItineraryDate
Integer	li_ItinType
n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_ShipmentManager	lnv_ShipmentManager

Long	ll_Return = 0

Boolean	lb_AdminMode

lb_AdminMode = of_isAdminMode()

// Added AdminMode Check 11/17/05 MFS

IF ib_rmbmenu AND NOT IsNull ( dwo ) AND NOT lb_AdminMode THEN

	ls_Name = Lower ( dwo.Name )



	//These checks were added 3.6.00 (after 3.6.b3) BKW 7/20/03
	//These checks were modified in 3.8.02 BKW 2/8/04

	//Checks for Row > 0 added 3.7.00 BKW 10/1/03, to prevent invalid row/col crash if right click was on header.
	//This change was included in 3.7.00 and 3.7.01, and then accidentally dropped from 3.7.02 through 3.8.06.
	//It was reintroduced in 3.8.07

	IF Match ( ls_Name, "^nextevent_driver" ) AND Row > 0 THEN

		//Note: We cannot do the same special processing for nextevent2, 3, & 4 because we don't have
		//their routing info like we do for nextevent.

		ls_IdColumn = "NextEvent_Driver_Id"
		
	ELSEIF Match ( ls_Name, "^nextevent_powerunit" ) AND Row > 0 THEN

		//Note: We cannot do the same special processing for nextevent2, 3, & 4 because we don't have
		//their routing info like we do for nextevent.

		ls_IdColumn = "NextEvent_PowerUnit_Id"

	ELSEIF Match ( ls_Name, "^lastconfirmed" ) AND Row > 0 THEN

		//This may be trumped by the siteid checks in the CHOOSE CASE, below
		ls_IdColumn = "LastConfirmed_Id"

	END IF		
	


	choose case ls_Name

	case "billto_name"
		ls_IdColumn = "billto_id"

	case "origin_name", "origin_name_d"
		ls_IdColumn = "origin_id"

	case "destination_name", "destination_name_d"
		ls_IdColumn = "destination_id"

	case "shipment_invoicenumber", "ds_id"
		ls_IdColumn = "ds_id"

	CASE "nextevent_site"
		ls_IdColumn = "NextEvent_SiteId"

	CASE "nextevent2_site"
		ls_IdColumn = "NextEvent2_SiteId"

	CASE "nextevent3_site"
		ls_IdColumn = "NextEvent3_SiteId"

	CASE "nextevent4_site"
		ls_IdColumn = "NextEvent4_SiteId"

	CASE "lastconfirmed_site"
		ls_IdColumn = "LastConfirmed_SiteId"
	
/////////////////

// These two were replaced by different processing, above, 3.6.00 BKW

//	CASE "nextevent_type", "nextevent_date", "nextevent_time", "nextevent_location"
//		ls_IdColumn = "NextEvent_Id"

//	CASE "lastconfirmed_type", "lastconfirmed_date", "lastconfirmed_time", "lastconfirmed_location"
//		ls_IdColumn = "LastConfirmed_Id"

/////////////////
		
	CASE "shipment_ref1text" , "shipment_ref2text" , "shipment_ref3text"
		
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "Copy Text"
	
		IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "COPY TEXT" THEN
			THIS.Event ue_CopyText ( ls_Name )
		END IF
		ll_Return = 1
	
	// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos
	CASE "p_shipnotesfull", "p_shipnotesempty"
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "View Notes"
		IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "VIEW NOTES" THEN
			THIS.event ue_ShowNotes(This.Object.ds_id[row])	
		END IF
		ll_Return = 1
	// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos		
		
	end choose
	
	//----------Changed by Dan ------------------------------------------------------
	//this is logic for dealing with groups, it will reset the current row
	//if the thing dropped on is a header or trailer and set the current row
	//to the first row in the group.
	IF row = 0 THEN
		row = this.of_doGroupRowCalculation( )
		IF row = -1 THEN
			row = 0
		END IF
	END IF
	//--------------------------------------------------------------------------------
	//If any of the above logic based on the various column & object names set an ls_IdColumn value 
	//for special action, perform that processing now.
	
	CHOOSE CASE ls_IdColumn
	
	CASE "billto_id", "origin_id", "destination_id", "NextEvent_SiteId", "NextEvent2_SiteId", &
		"NextEvent3_SiteId", "NextEvent4_SiteId", "LastConfirmed_SiteId"

		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "COMPANY"
		lsa_parm_labels[2] = "CO_ID"
		laa_parm_values[2] = this.getitemnumber(row, ls_IdColumn)
		if ls_IdColumn = "billto_id" then
			lsa_parm_labels[3] = "ADDRESS_TYPE"
			laa_parm_values[3] = "BILLING"
		end if

		f_pop_standard(lsa_parm_labels, laa_parm_values)

		ll_Return = 1
	
	CASE "ds_id"
		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "SHIPMENT_PERFORM_OPEN"
		lsa_parm_labels[2] = "TARGET_ID"
		laa_parm_values[2] = this.getitemnumber(row, ls_IdColumn)
		lsa_parm_labels[3] = "DATAWINDOW"
		laa_parm_values[3] = THIS
		
		IF This.GetSelectedRow ( 0 ) > 0 THEN
			
			lsa_parm_labels[4] = "TARGET_IDS"
			laa_parm_values[4] = This.Object.ds_id.Selected
			
		END IF
	
		// f_pop_standard(lsa_parm_labels, laa_parm_values)													// RDT 8-13-03 
		If f_pop_standard(lsa_parm_labels, laa_parm_values) = "AUTOROUTE_SHIPMENT!" Then 			// RDT 8-13-03 
			//This.Event ue_CacheRetrieve ( FALSE /* no refresh cache*/, FALSE  /*no Force reload*/ )// RDT 8-13-03 
			inv_mypropmanager.event ue_requestrefresh( )
		End If																												// RDT 8-13-03 
		

		ll_Return = 1
	
	CASE "LastConfirmed_Id"
	
		ll_EquipmentId = This.GetItemNumber ( Row, "nextevent_equipment_id" )
		//Note:  Although this looks like a mistake (getting an equipment id for "LastConfirmed_Id"
		//from the "nextevent_equipment_id" field, it's actually not.  The contents of that field
		//have been reinterpreted in 3.8 (to be the freight-carrying equipment or bare chassis used
		//for the last confirmed event -- or the event prior to the first unconfirmed event).
		//However, the field name could not be changed, so it's now a misnomer, although in most
		//cases except cross dock the equipment will turn out to be the same.
	
		ld_ItineraryDate = This.GetItemDate ( Row, "LastConfirmed_Date" )
	
		IF NOT ( IsNull ( ll_EquipmentId ) OR IsNull ( ld_ItineraryDate ) ) THEN
	
			lsa_Parm_Labels [ 1 ] = "ADD_ITEM"
			laa_Parm_Values [ 1 ] = "&Itinerary"
		
			CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
			CASE "ITINERARY"
		
				lnv_EquipmentManager.of_OpenItinerary ( ll_EquipmentId, ld_ItineraryDate )
		
			END CHOOSE

			//By putting this here, if there's no date, they get the default popup instead.
			//Is this what we want???
			ll_Return = 1
		
		END IF
		
	CASE "NextEvent_Driver_Id", "NextEvent_PowerUnit_Id"
		
		//Give user an option to show the itinerary for the Driver or PowerUnit they're right-clicking on
		//for the date that the event's been routed.
		
		lsa_Parm_Labels [ 1 ] = "ADD_ITEM"
		laa_Parm_Values [ 1 ] = "&Itinerary"
	
		CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
				
		CASE "ITINERARY"

	
			//We don't actually have id fields for the powerunit or driver in the datastore, so we'll call 
			//a service function with the event id and itin type we want, and let it figure out the routing 
			//date and the PowerUnit or Driver assigned to that event.
			
			//Get the event id.
			ll_NextEventId = This.GetItemNumber( Row, "NextEvent_Id" )
			
			
			//Determine the ItinType value.
			
			CHOOSE CASE ls_IdColumn
					
			CASE "NextEvent_Driver_Id"
				li_ItinType = gc_Dispatch.ci_ItinType_Driver
				
			CASE "NextEvent_PowerUnit_Id"
				li_ItinType = gc_Dispatch.ci_ItinType_PowerUnit
					
			END CHOOSE
			
			
			//Call the service function to open the itinerary window.		
			lnv_ShipmentManager.of_openitinerary( ll_NextEventId, li_ItinType)
	
		END CHOOSE


		//Now, prevent the sort / filter / find popup.
		ll_Return = 1
		
		
	END CHOOSE

END IF


//If the request has not already been handled by special processing above, forward the
//request to the ancestor for default processing.

IF ll_Return = 0 THEN

	ll_Return = Super::Event rButtonUp ( xpos, ypos, row, dwo )

END IF


RETURN ll_Return
end event

event doubleclicked;call super::doubleclicked;//Extending ancestor

//----------Changed by Dan ------------------------------------------------------
//this is logic for dealing with groups, it will reset the current row
//if the thing dropped on is a header or trailer and set the current row
//to the first row in the group.
IF row = 0 THEN
	row = this.of_doGroupRowCalculation( )
	IF row = -1 THEN
		row = 0
	END IF
END IF
//--------------------------------------------------------------------------------

IF Row > 0 THEN
	This.Event ue_ShipmentDetail ( Row )
END IF
end event

event clicked;//OVERIDES ancestor, but code from ancestors is executed After Redraw is turned off

Long	ll_return
This.SetRedraw(FALSE)
ll_return = Super::Event clicked(xpos, ypos, row, dwo)
IF KeyDown( KeyShift! ) OR KeyDown( KeyControl! ) THEN
	//Turn on the Multi-Row select service

ELSE
	String	ls_Band
	
	ls_Band = GetbandAtPointer( )
	IF ls_Band = "detail" THEN
		//tHIS.selectRow( row, FALSE )
	END IF
END IF


This.SetRedraw(TRUE)
return ll_return
end event

event getfocus;call super::getfocus;This.of_SetRowSelect ( TRUE ) 

This.inv_RowSelect.of_SetStyle ( n_cst_dwsrv_RowSelection.Extended ) 
end event

event losefocus;call super::losefocus;This.of_SetRowSelect ( False )
tHIS.selectRow(0, FALSE )
RETURN AncestorReturnValue
end event

event rbuttondown;//Overriding Ancestor
//Invert the Row Selection Caused by Ancestor Script
Long	lla_SelectedRows[]
Int	i
Int	li_Count
Boolean	lb_Select

This.SetRedraw(FALSE)
// get a list of the selected rows
IF isValid(inv_RowSelect) THEN
	This.inv_rowselect.of_SelectedCount( lla_SelectedRows[])
	li_Count = UpperBound ( lla_SelectedRows )
END IF

// call super
Super::Event rbuttondown(xpos, ypos, row, dwo)

FOR i = 1 TO li_Count
	IF lla_SelectedRows [i] = row THEN
		lb_Select = TRUE
		EXIT
	END IF
NEXT

THIS.SelectRow ( Row , lb_Select )

This.SetRedraw(TRUE)
end event

event ue_setidentifiers;call super::ue_setidentifiers;//this.ib_isRestrictable = true
end event

event rowfocuschanged;//OVERIDES ancestor, but code from ancestors is executed After Redraw is turned off

Long	ll_return
This.SetRedraw(FALSE)
ll_return = Super::Event RowFocusChanged(currentrow)
IF KeyDown( KeyShift! ) OR KeyDown( KeyControl! ) THEN

ELSE
		tHIS.selectRow( currentrow, FALSE )

END IF

This.SetRedraw(TRUE)

return ll_return





end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE Lower ( dwo.Name )
//
//CASE Lower ( "cb_Details" )
//	This.Event ue_Details ( )
//
CASE Lower ( "cb_Duplicate" )
	This.Event ue_Duplicate ( )
//
CASE Lower ( "cb_LoadBuilder" )
	This.Event ue_LoadBuilder ( )
//
//CASE Lower ( "cb_RateLookup" )
//	This.Event ue_RateLookup ( )
//
//CASE Lower ( "cb_Document" )
//	This.Event ue_Document ( )
//
END CHOOSE
end event

event lbuttonup;call super::lbuttonup;This.Event Post ue_UpdateLoadBuilder ( )
end event

