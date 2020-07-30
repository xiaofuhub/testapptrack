$PBExportHeader$u_dw_itemlist.sru
forward
global type u_dw_itemlist from u_dw
end type
end forward

global type u_dw_itemlist from u_dw
integer width = 3451
integer height = 368
string dataobject = "d_itemlist"
boolean hscrollbar = true
boolean hsplitscroll = true
event ue_postselection ( )
end type
global u_dw_itemlist u_dw_itemlist

type variables
Private:
Boolean	ib_AllowUserSelection
Long	ila_EventsCompleted[]
Long	ila_Events[]
Long	il_CurrentEvent
Long	ila_Shipments[]
n_cst_bso_Dispatch	inv_Dispatch  //Added 4.0.41 8/19/05 BKW
end variables

forward prototypes
public function integer of_merge (powerobject apo_source)
public function integer of_addshipments (long ala_ids[])
public function integer of_addshipment (long al_id)
public function integer of_removeshipments (long ala_ids[])
public function integer of_removeshipment (long al_id)
private function string of_getdataobject ()
public function long of_gettotalweight (boolean ab_selectedonly)
public function integer of_setallowuserselection (boolean ab_allow)
private function boolean of_getallowuserselection ()
public function integer of_setshipmentlist (long ala_ids[])
public function decimal of_gettotalcharges (boolean ab_selectedonly)
public function integer of_seteventscompleted (long ala_ids[])
private function long of_geteventscompleted (ref long ala_ids[])
private function integer of_processeventscompleted (powerobject apo_items, powerobject apo_events)
public function integer of_setcurrentevent (long al_id)
public function integer of_setevents (long ala_ids[])
private function long of_getevents (ref long ala_ids[])
private function long of_getcurrenteventindex ()
public function integer of_setreporttitle (string as_title)
public function integer of_getshipments (ref long ala_ids[])
public function integer of_setdispatchmanager (n_cst_bso_dispatch anv_dispatch)
public function integer of_hidecharges ()
end prototypes

public function integer of_merge (powerobject apo_source);DataWindow	ldw_Source
DataStore	lds_Source, &
				lds_Empty
n_cst_Dws	lnv_Dws
Integer		li_Return

lnv_Dws.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

This.SetRedraw ( FALSE )

CHOOSE CASE gf_Rows_Sync ( lds_Source, ldw_Source, lds_Empty, This, Primary!, TRUE, TRUE )

CASE 1
	This.Sort ( )
	li_Return = 1

CASE ELSE //-1
	li_Return = -1

END CHOOSE

This.SetRedraw ( TRUE )

Event Post ue_PostSelection ( )

RETURN li_Return
end function

public function integer of_addshipments (long ala_ids[]);DataStore	lds_Items, &
				lds_Events
Long			ll_EventCount, &
				ll_EventIndex, &
				ll_ItemCount, &
				ll_ItemIndex
Integer		li_ShipSeq, &
				li_Return
n_cst_ShipmentManager	lnv_ShipmentMgr
n_cst_beo_Event	lnv_Event
n_cst_beo_Item		lnv_Item
n_cst_beo_Company	lnv_Company

SetPointer ( HourGlass!)


lnv_Item = CREATE n_cst_Beo_Item


lds_Items = CREATE DataStore
lds_Items.DataObject = of_GetDataObject ( )
lds_Items.SetTransObject ( SQLCA )

ila_shipments = ala_ids[]

ll_ItemCount = lds_Items.Retrieve ( ala_Ids )

CHOOSE CASE ll_ItemCount

CASE -1
	li_Return = -1
	GOTO Cleanup

CASE 0
	li_Return = 1
	GOTO Cleanup

END CHOOSE


ll_EventCount = lnv_ShipmentMgr.of_GetShipmentEvents ( lds_Events, ala_Ids )
lnv_Item.of_SetSource ( lds_Items )
lnv_Item.of_SetEventSource ( lds_Events )

FOR ll_ItemIndex = 1 TO ll_ItemCount

	lnv_Item.of_SetSourceRow ( ll_ItemIndex )

	IF lnv_Item.of_GetPickupEvent ( lnv_Event ) = 1 THEN
		IF lnv_Event.of_GetSite ( lnv_Company ) = 1 THEN
			lds_Items.Object.Origin_Name [ ll_ItemIndex ] = lnv_Company.of_GetName ( )
			lds_Items.Object.Origin_Location [ ll_ItemIndex ] = lnv_Company.of_GetLocation ( )
		END IF
	END IF

	IF lnv_Item.of_GetDeliverEvent ( lnv_Event ) = 1 THEN
		IF lnv_Event.of_GetSite ( lnv_Company ) = 1 THEN
			lds_Items.Object.Dest_Name [ ll_ItemIndex ] = lnv_Company.of_GetName ( )
			lds_Items.Object.Dest_Location [ ll_ItemIndex ] = lnv_Company.of_GetLocation ( )
		END IF
	END IF

NEXT

of_ProcessEventsCompleted ( lds_Items, lds_Events )

IF of_Merge ( lds_Items ) = 1 THEN

	//***Note : This would not work for incremental additions.  It would clear the old items.
	This.SetRedraw ( FALSE )
	of_ProcessEventsCompleted ( This, lds_Events )
	This.SetRedraw ( TRUE )

	li_Return = 1
ELSE //-1
	li_Return = -1
END IF

Cleanup:
DESTROY lds_Items
DESTROY lds_Events
DESTROY lnv_Company
DESTROY ( lnv_Item )

RETURN li_Return
end function

public function integer of_addshipment (long al_id);RETURN of_AddShipments ( { al_Id } )
end function

public function integer of_removeshipments (long ala_ids[]);Long	ll_ShipmentCount, &
		ll_ShipmentIndex, &
		ll_Id, &
		ll_ItemCount, &
		ll_ItemIndex

ll_ShipmentCount = UpperBound ( ala_Ids )

This.SetRedraw ( FALSE )

FOR ll_ShipmentIndex = 1 TO ll_ShipmentCount

	ll_Id = ala_Ids [ ll_ShipmentIndex ]
	ll_ItemCount = This.RowCount ( )

	FOR ll_ItemIndex = ll_ItemCount TO 1 STEP -1

		IF This.GetItemNumber ( ll_ItemIndex, "di_shipment_id" ) = ll_Id THEN

			This.RowsDiscard ( ll_ItemIndex, ll_ItemIndex, Primary! )

		END IF

	NEXT

NEXT

This.SetRedraw ( TRUE )

Event Post ue_PostSelection ( )

RETURN 1
end function

public function integer of_removeshipment (long al_id);RETURN of_RemoveShipments ( { al_Id } )
end function

private function string of_getdataobject ();RETURN This.DataObject
end function

public function long of_gettotalweight (boolean ab_selectedonly);Long	ll_ItemCount
Long	lla_Weights[], &
		ll_Total

ll_ItemCount = This.RowCount ( )

IF ll_ItemCount > 0 THEN

	IF ab_SelectedOnly = TRUE THEN

		IF This.GetSelectedRow ( 0 ) > 0 THEN

			lla_Weights = This.Object.di_TotItemWeight.Selected

		END IF

	ELSE

		lla_Weights = This.Object.di_TotItemWeight.Primary

	END IF

END IF

n_cst_anyarraysrv lnv_anyarray
ll_Total = lnv_anyarray.of_SummLong( lla_Weights )

RETURN ll_Total
end function

public function integer of_setallowuserselection (boolean ab_allow);IF IsNull ( ab_Allow ) THEN
	RETURN -1
ELSE
	ib_AllowUserSelection = ab_Allow
	RETURN 1
END IF
end function

private function boolean of_getallowuserselection ();RETURN ib_AllowUserSelection
end function

public function integer of_setshipmentlist (long ala_ids[]);//This should be revised to incrementally add & discard, rather than starting over each time

This.Reset ( )

of_AddShipments ( ala_Ids )

RETURN 1
end function

public function decimal of_gettotalcharges (boolean ab_selectedonly);Long	ll_ItemCount, &
		ll_Count, &
		ll_Index
Decimal	lca_Charges[], &
			lc_Total

ll_ItemCount = This.RowCount ( )

IF ll_ItemCount > 0 THEN

	IF ab_SelectedOnly = TRUE THEN

		IF This.GetSelectedRow ( 0 ) > 0 THEN

			lca_Charges = This.Object.di_Our_ItemAmt.Selected

		END IF

	ELSE

		lca_Charges = This.Object.di_Our_ItemAmt.Primary

	END IF

END IF

//Would like to use the decimal equivalent of f_Array_Sum, when we have one

ll_Count = UpperBound ( lca_Charges )

FOR ll_Index = 1 TO ll_Count
	IF NOT IsNull ( lca_Charges [ ll_Index ] ) THEN
		lc_Total += lca_Charges [ ll_Index ]
	END IF
NEXT

RETURN lc_Total
end function

public function integer of_seteventscompleted (long ala_ids[]);ila_EventsCompleted = ala_Ids

RETURN 1
end function

private function long of_geteventscompleted (ref long ala_ids[]);ala_Ids = ila_EventsCompleted

RETURN UpperBound ( ala_Ids )
end function

private function integer of_processeventscompleted (powerobject apo_items, powerobject apo_events);//Modified 4.0.41 8/19/05 BKW   Changes enable items whose actual pickup or delivery is
//not in the itinerary to be included in the items on truck list, so long as there are 
//representative events from the shipment in the itinerary.

Long	lla_Events[], &
		ll_EventCount, &
		ll_ItemCount, &
		ll_ItemIndex, &
		ll_CurrentEventIndex, &
		ll_Index, &
		ll_PickupSequence, &
		ll_DeliverySequence, &
		ll_CurrentEventShipmentId, /*Added 4.0.41 BKW, here down*/ &
		ll_CurrentEventItinRow, &
		ll_CurrentEventShipSeq, &
		ll_ItemShipmentId, &
		ll_ItinRow, &
		ll_ItinCount, &
		ll_BackwardSeq, &
		ll_ForwardSeq, &
		ll_PickupSeq, &
		ll_DeliverSeq
Boolean	lb_PickupExists, &
			lb_PickedUp, &
			lb_DeliveryExists, &
			lb_Delivered, &
			lb_Current, &
			lb_IsOnTruck, &
			lb_BackwardIsDeliverGroup, &
			lb_ForwardIsPickupGroup
String	ls_Find
n_cst_Dws	lnv_Dws
n_cst_beo_Item	lnv_Item
n_cst_beo_Event	lnv_Event, &
						lnv_ItinEvent  //Added 4.0.41 BKW
n_cst_AnyArraySrv	lnv_AnyArray
DataStore			lds_Itin  //Added 4.0.41 BKW

lnv_Item = CREATE n_cst_beo_Item
lnv_ItinEvent = CREATE n_cst_beo_Event

ll_EventCount = This.of_GetEvents ( lla_Events )

//If my understanding is right, lla_Events will only be populated if LoadBuilder is being used from the itinerary.
//So, if this is from the shipment summary, for example, we'll be exiting here.  8/19/05 BKW

IF ll_EventCount = 0 THEN
	RETURN 1
END IF


ll_CurrentEventIndex = This.of_GetCurrentEventIndex ( )

ll_ItemCount = lnv_Dws.of_RowCount ( apo_Items )

lnv_Item.of_SetSource ( apo_Items )
lnv_Item.of_SetEventSource ( apo_Events )

IF IsValid ( inv_Dispatch ) THEN
	
	lds_Itin = inv_Dispatch.of_GetEventCache ( )
	
	IF IsValid ( lds_Itin ) THEN
		
		ll_ItinCount = lds_Itin.RowCount ( )
		
		lnv_ItinEvent.of_SetSource ( lds_Itin )
		
		lnv_ItinEvent.of_SetSourceId ( il_CurrentEvent )
		
		ll_CurrentEventShipmentId = lnv_ItinEvent.of_GetShipment ( )
		ll_CurrentEventItinRow = lnv_ItinEvent.of_GetSourceRow ( )
		ll_CurrentEventShipSeq = lnv_ItinEvent.of_GetShipSeq ( )
		
		
	END IF
	
END IF


FOR ll_ItemIndex = ll_ItemCount TO 1 STEP -1

	lb_PickupExists = FALSE
	lb_PickedUp = FALSE
	lb_DeliveryExists = FALSE
	lb_Delivered = FALSE
	lb_Current = FALSE
	lb_IsOnTruck = FALSE
	ll_PickupSequence = 0
	ll_DeliverySequence = 9999

	lnv_Item.of_SetSourceRow ( ll_ItemIndex )
	
	
	ll_ItemShipmentId = 0
	ll_ItinRow = 0
	ll_BackwardSeq = 0
	ll_ForwardSeq = 0
	ll_PickupSeq = 0
	ll_DeliverSeq = 0
	ls_Find = ""
	lb_BackwardIsDeliverGroup = FALSE
	lb_ForwardIsPickupGroup = FALSE

	
	IF IsValid ( lds_Itin ) THEN
		
		ll_ItemShipmentId = lnv_Item.of_GetShipment ( )
		ls_Find = "de_shipment_id = " + String ( ll_ItemShipmentId )
		
		//Look in the itinerary from the current event backward for an event in the same shipment as this item.
		
		ll_ItinRow = lds_Itin.Find ( ls_Find, ll_CurrentEventItinRow, 1 )
		
		IF ll_ItinRow > 0 THEN
		
			lnv_ItinEvent.of_SetSourceRow ( ll_ItinRow )
			ll_BackwardSeq = lnv_ItinEvent.of_GetShipSeq ( )
			lb_BackwardIsDeliverGroup = lnv_ItinEvent.of_IsDeliverGroup ( )
		
		END IF
		
		
		//Look in the itinerary from the the current event forward for an event in the same shipment as this item.

		ll_ItinRow = lds_Itin.Find ( ls_Find, ll_CurrentEventItinRow, ll_ItinCount )
		
		IF ll_ItinRow > 0 THEN
		
			lnv_ItinEvent.of_SetSourceRow ( ll_ItinRow )
			ll_ForwardSeq = lnv_ItinEvent.of_GetShipSeq ( )
			lb_ForwardIsPickupGroup = lnv_ItinEvent.of_IsPickupGroup ( )
			
		END IF
		
		
		ll_PickupSeq = lnv_Item.of_GetPickupEvent ( )
		ll_DeliverSeq = lnv_Item.of_GetDeliverEvent ( )
		
		
		//Change zeroes to null for purposes of comparisons below.
		
		IF ll_PickupSeq < 0 THEN
			SetNull ( ll_PickupSeq )
		END IF
		
		IF ll_DeliverSeq < 0 THEN
			SetNull ( ll_DeliverSeq )
		END IF
		
		
		IF ll_BackwardSeq > 0 THEN
			
			IF ll_DeliverSeq <= ll_BackwardSeq THEN
				
				//The delivery happens on or before the first event, looking backward.
				//It's delivered.
				
				lb_Delivered = TRUE
				lb_DeliveryExists = TRUE
				
				lb_PickedUp = TRUE  //Must be picked up if delivered
				lb_PickupExists = TRUE
				
				//If the deliver happens on the current event, flag it.
				
				IF ll_DeliverSeq = ll_BackwardSeq THEN
					IF ll_ItinRow = ll_CurrentEventItinRow THEN
						lb_Current = TRUE
					END IF
				END IF
				
			ELSEIF ll_PickupSeq > ll_BackwardSeq THEN
				
				//The pickup happens after the first event, looking backward.
				//It's not picked up
				
				lb_PickupExists = TRUE
				
			ELSEIF ll_PickupSeq <= ll_BackwardSeq OR IsNull ( ll_PickupSeq ) THEN
				
				//The pickup happens on or before the first event, looking backward.
				//It's picked up.
				
				lb_PickedUp = TRUE
				lb_PickupExists = TRUE
				
				//If the pickup happens on the current event, flag it.
				
				IF ll_PickupSeq = ll_BackwardSeq THEN
					IF ll_ItinRow = ll_CurrentEventItinRow THEN
						lb_Current = TRUE
					END IF
				END IF
				
				
				IF ll_ForwardSeq > 0 THEN
					//Ok, we've got something to evaluate delivery against, below.
				ELSE
					IF lb_BackwardIsDeliverGroup THEN
						//There's no forward event, and the backward event is deliver group.
						//It's delivered as far as this itinerary is concerned.
						lb_Delivered = TRUE
						lb_DeliveryExists = TRUE
					END IF
				END IF
				
			END IF
			
		END IF
		
		
		//If we already know it's delivered, don't need to check further.
		//Only perform the following section if we don't know whether it's delivered.
		
		IF ll_ForwardSeq > 0 AND lb_Delivered = FALSE THEN
			
			IF ll_PickupSeq < ll_ForwardSeq OR IsNull ( ll_PickupSeq ) THEN
				
				//The pickup happens before the first event, looking forward.
				
				IF lb_ForwardIsPickupGroup THEN
					//Since the first forward event is a pickup, don't consider the
					//items on the truck, unless to to a backward event, earlier.
					lb_PickupExists = TRUE
					
				ELSE
				
					//Since the first forward event is a deliver, consider the items
					//on the truck.
					lb_PickedUp = TRUE
					lb_PickupExists = TRUE
					
				END IF
				
			ELSEIF ll_PickupSeq = ll_ForwardSeq THEN
				
				//The pickup happens on the first event, looking forward.
				lb_PickupExists = TRUE
				
				IF ll_ItinRow = ll_CurrentEventItinRow THEN
					
					//The pickup happens on the current event, so, it's picked up.
					
					lb_PickedUp = TRUE
					lb_Current = TRUE
					
				ELSE
					
					//The pickup happens after the current event, so it's not picked up.
					
				END IF
				
			END IF
			
			
			IF ll_DeliverSeq < ll_ForwardSeq THEN
				
				//The deliver happens before the first event looking forward, 
				//so we've already delivered.
				
				lb_Delivered = TRUE
				lb_DeliveryExists = TRUE
				
			ELSEIF ll_DeliverSeq = ll_ForwardSeq THEN
				
				//The deliver happens on the first event, looking forward.
				
				lb_DeliveryExists = TRUE
				
				IF ll_ItinRow = ll_CurrentEventItinRow THEN
					
					//The first event looking forward is the current event,
					//so we're delivering on the current event.
					lb_Delivered = TRUE
					lb_Current = TRUE
					
				ELSE
					
					//The first event looking forward comes after the current event,
					//so we have not delivered yet.
					
				END IF
				

// **I think this condition has already been adequately handled by other means. BKW
//			ELSEIF ll_DeliverSeq > ll_ForwardSeq THEN
//				
//				//The deliver happens after the first event, looking forward.
//				lb_DeliveryExists = TRUE
				
			END IF
			
		END IF
		
	END IF
	
	
	//This section, which is the old code, is still needed to determine the ll_PickupSequence and
	//ll_DeliverySequence values.  The part that sets the lb_ values should now be redundant, 
	//but it should also not be in conflict with what is done above, and I'm leaving it in in case 
	//there's a scenario where this processing is reached with lds_Itin not valid.

	IF lnv_Item.of_GetPickupEvent ( lnv_Event ) = 1 THEN
		
		ll_Index = lnv_anyarray.of_FindLong ( lla_Events, lnv_Event.of_GetId ( ), 1, ll_EventCount )

		IF ll_Index > 0 THEN
			lb_PickupExists = TRUE
			ll_PickupSequence = ll_Index

			IF ll_Index <= ll_CurrentEventIndex THEN
				lb_PickedUp = TRUE

				IF ll_Index = ll_CurrentEventIndex THEN
					lb_Current = TRUE
				END IF

			END IF

		END IF

	END IF

	IF lnv_Item.of_GetDeliverEvent ( lnv_Event ) = 1 THEN
		
		ll_Index = lnv_anyarray.of_FindLong ( lla_Events, lnv_Event.of_GetId ( ), 1, ll_EventCount )

		IF ll_Index > 0 THEN
			lb_DeliveryExists = TRUE
			ll_DeliverySequence = ll_Index

			IF ll_Index <= ll_CurrentEventIndex THEN
				lb_Delivered = TRUE

				IF ll_Index = ll_CurrentEventIndex THEN
					lb_Current = TRUE
				END IF

			END IF

		END IF

	END IF


	IF lb_Current THEN
		lb_IsOnTruck = TRUE

	ELSEIF lb_Delivered THEN
		lb_IsOnTruck = FALSE

	ELSEIF lb_PickedUp THEN
		lb_IsOnTruck = TRUE

	ELSEIF lb_PickupExists THEN
		lb_IsOnTruck = FALSE

	ELSEIF lb_DeliveryExists THEN
		lb_IsOnTruck = TRUE

	ELSE
		lb_IsOnTruck = FALSE

	END IF
	

	
	//If the item has no pickup or deliver sequence specified, set the ll_PickupSequence and/or
	//ll_DeliverySequence indicators to null, so it can be visually distinguished in the display
	//from items whose pickup and delivery event is known, but just not in the current itinerary.
	//This is for presentation reasons only and is not intended to affect other processing.
	
	IF IsNull ( ll_PickupSeq ) THEN
		SetNull ( ll_PickupSequence )
	END IF
	
	IF IsNull ( ll_DeliverSeq ) THEN
		SetNull ( ll_DeliverySequence )
	END IF
	


	IF lb_IsOnTruck THEN
		lnv_Dws.of_SetItem ( apo_Items, ll_ItemIndex, "PickupSequence", ll_PickupSequence )
		lnv_Dws.of_SetItem ( apo_Items, ll_ItemIndex, "DeliverySequence", ll_DeliverySequence )

		IF lb_Current THEN
			lnv_Dws.of_SelectRow ( apo_Items, ll_ItemIndex, TRUE )
		END IF
	ELSE
		lnv_Dws.of_RowsDiscard ( apo_Items, ll_ItemIndex, ll_ItemIndex, Primary! )
	END IF

NEXT

DESTROY lnv_Item
DESTROY lnv_ItinEvent

RETURN 1
end function

public function integer of_setcurrentevent (long al_id);il_CurrentEvent = al_Id
RETURN 1
end function

public function integer of_setevents (long ala_ids[]);ila_Events = ala_Ids
RETURN 1
end function

private function long of_getevents (ref long ala_ids[]);ala_Ids = ila_Events

RETURN UpperBound ( ala_Ids )
end function

private function long of_getcurrenteventindex ();n_cst_AnyArraySrv	lnv_AnyArray
RETURN lnv_anyarray.of_FindLong ( ila_Events, il_CurrentEvent, 1, UpperBound ( ila_Events ) )
end function

public function integer of_setreporttitle (string as_title);Integer	li_Return

li_Return = -1

IF This.Modify ( "st_Title.Text = '" + as_Title + "'" ) = "" THEN
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_getshipments (ref long ala_ids[]);ala_ids[]  = ila_Shipments

RETURN UpperBound ( ala_ids[] )
end function

public function integer of_setdispatchmanager (n_cst_bso_dispatch anv_dispatch);Integer	li_Return = 1

IF IsValid ( anv_Dispatch ) THEN
	inv_Dispatch = anv_Dispatch
ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

public function integer of_hidecharges ();//Created by Dan 1-30-07 To hide anything that displays a rate or charge.

Int	li_Return
String	ls_Temp
this.Modify("di_our_itemamt.Visible=0")
this.Modify("di_pay_itemamt.Visible=0")

//this hides the description when the type is FSC because the description contains rate information
this.Modify("di_description.Visible='1~tIf(di_item_type=~"A~",0,1)'")

RETURN li_return

end function

event clicked;call super::clicked;IF of_GetAllowUserSelection ( ) = TRUE THEN
	gf_MultiSelect ( This, Row )
	Event Post ue_PostSelection ( )
END IF

RETURN AncestorReturnValue
end event

event rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]
n_cst_AppServices	lnv_AppServices

if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this

	lnv_AppServices.of_SetFocusFrame ( )  //This is to prevent the popmenu position being skewed

	f_pop_standard(lsa_parm_labels, laa_parm_values)

	This.SetFocus ( )

end if
end event

event constructor;n_cst_privsManager	lnv_manager
of_SetAutoSort ( TRUE )

//added by dan 1-30-07
lnv_manager = gnv_app.of_getPrivsmanager( )
IF lnv_manager.of_getUserpermissionfromfn( "View Charges" ) <> 1 THEN
	this.of_hidecharges( )
END IF
//////////////////////
end event

event ue_autosort;call super::ue_autosort;IF AncestorReturnValue = SUCCESS THEN

	inv_Sort.of_SetExclude ( { "cf_ItemCount", "cf_TotalPieces", "cf_TotalWeight" } )

END IF

RETURN AncestorReturnValue
end event

on u_dw_itemlist.create
end on

on u_dw_itemlist.destroy
end on

