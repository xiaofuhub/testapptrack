$PBExportHeader$u_cst_eventrouting_clipboard.sru
forward
global type u_cst_eventrouting_clipboard from u_cst_eventrouting
end type
type cb_1 from u_cb within u_cst_eventrouting_clipboard
end type
type cb_2 from u_cb within u_cst_eventrouting_clipboard
end type
type gb_7 from groupbox within u_cst_eventrouting_clipboard
end type
type gb_5 from groupbox within u_cst_eventrouting_clipboard
end type
type gb_6 from groupbox within u_cst_eventrouting_clipboard
end type
type gb_3 from groupbox within u_cst_eventrouting_clipboard
end type
type gb_2 from groupbox within u_cst_eventrouting_clipboard
end type
type gb_1 from groupbox within u_cst_eventrouting_clipboard
end type
type cb_4 from u_cb within u_cst_eventrouting_clipboard
end type
type cb_5 from u_cb within u_cst_eventrouting_clipboard
end type
type cb_6 from u_cb within u_cst_eventrouting_clipboard
end type
type cb_7 from u_cb within u_cst_eventrouting_clipboard
end type
type cb_8 from u_cb within u_cst_eventrouting_clipboard
end type
type cb_9 from u_cb within u_cst_eventrouting_clipboard
end type
type st_route from statictext within u_cst_eventrouting_clipboard
end type
type cb_optimize from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_all from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_pickups from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_deliveries from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_reverseorder from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_importpickups from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_importdeliveries from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_totals from u_cb within u_cst_eventrouting_clipboard
end type
type st_1 from statictext within u_cst_eventrouting_clipboard
end type
type sle_drivetime from singlelineedit within u_cst_eventrouting_clipboard
end type
type sle_mileage from singlelineedit within u_cst_eventrouting_clipboard
end type
type st_mileage from statictext within u_cst_eventrouting_clipboard
end type
type sle_low from singlelineedit within u_cst_eventrouting_clipboard
end type
type sle_totaltime from singlelineedit within u_cst_eventrouting_clipboard
end type
type sle_high from singlelineedit within u_cst_eventrouting_clipboard
end type
type st_2 from statictext within u_cst_eventrouting_clipboard
end type
type st_3 from statictext within u_cst_eventrouting_clipboard
end type
type cb_invert from commandbutton within u_cst_eventrouting_clipboard
end type
type cb_route from u_cb within u_cst_eventrouting_clipboard
end type
type gb_4 from groupbox within u_cst_eventrouting_clipboard
end type
type dw_list from u_dw_eventlist within u_cst_eventrouting_clipboard
end type
end forward

global type u_cst_eventrouting_clipboard from u_cst_eventrouting
integer height = 784
event type integer ue_clear ( )
event type integer ue_clearselected ( )
event type integer ue_append ( )
event ue_routemode ( )
event ue_optimize ( )
event ue_moveup ( )
event ue_movedown ( )
event ue_movetop ( )
event ue_movebottom ( )
event ue_selectpickups ( )
event ue_selectdeliveries ( )
event ue_reverseorder ( )
event ue_insertdeliveries ( )
event ue_showrmbmenu ( )
event type integer ue_processrequest ( string as_request )
event ue_importpickups ( )
event ue_importdeliveries ( )
event type integer ue_importevents ( long ala_shipmentids[],  string as_types )
event type integer ue_loadevents ( long ala_eventids[] )
event ue_showtotals ( )
event ue_hidetotals ( )
event ue_rowclicked ( )
event type integer ue_gotoshipment ( long al_row )
event type n_cst_beo_shipment ue_getshipment ( )
cb_1 cb_1
cb_2 cb_2
gb_7 gb_7
gb_5 gb_5
gb_6 gb_6
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
st_route st_route
cb_optimize cb_optimize
cb_all cb_all
cb_pickups cb_pickups
cb_deliveries cb_deliveries
cb_reverseorder cb_reverseorder
cb_importpickups cb_importpickups
cb_importdeliveries cb_importdeliveries
cb_totals cb_totals
st_1 st_1
sle_drivetime sle_drivetime
sle_mileage sle_mileage
st_mileage st_mileage
sle_low sle_low
sle_totaltime sle_totaltime
sle_high sle_high
st_2 st_2
st_3 st_3
cb_invert cb_invert
cb_route cb_route
gb_4 gb_4
dw_list dw_list
end type
global u_cst_eventrouting_clipboard u_cst_eventrouting_clipboard

type variables
Private:
Boolean	ib_Origin
Boolean	ib_Destination
Boolean	ib_CalculateTotals

Long	il_DriveMinutes


end variables

forward prototypes
protected function integer of_getselectedrows (ref long ala_rows[])
private function integer of_movetotop (long al_Row, ref dataStore ads_Source)
private function datastore of_getoptimizationdatastore ()
private function integer of_insertoptimized (datastore ads_source)
private function String of_getoppositemove (string as_Source)
public function n_cst_trip of_createtrip ()
private function integer of_getrmbmenu (ref string asa_lables[], ref any aaa_values[])
public function integer of_geteventidsforloading (ref long ala_eventids[], string as_type, long ala_shipmentids[])
private function integer of_removeexistingids (ref long ala_eventids[])
public function n_cst_trip of_createtrip (boolean ab_interactive)
protected function integer of_calculatetotals ()
protected function string of_calculatedrivetime ()
protected function string of_calculatemileage ()
protected function string of_calculatetotaltimes ()
public function integer of_getdeliverweights (long al_eventid)
protected function string of_calculatetotalweight ()
public function integer of_calculaterunningweight ()
public function boolean of_allitemsassigned (long al_shipmentid)
public function long of_getlowvalue ()
public function long of_gethighvalue ()
public function integer of_calculateshipmentweight (long al_shipment)
public function long of_getpickupweights (long al_eventid)
public function string of_convertpcm (string as_PCM)
private function boolean of_includeevent (n_cst_beo_event anv_event, string as_group, long ala_shipmentids[])
end prototypes

event ue_clear;//Clear the display list, and set that (empty) list to the clipboard.

Integer	li_Return = 1

dw_List.Reset ( )
dw_List.Event ue_SetListAsClipboard ( )

RETURN li_Return
end event

event ue_clearselected;//Clear selected rows from the display list, and set the remaining list as the clipboard.

Long	ll_RowCount, &
		ll_Row

Integer	li_Return = 1


ll_RowCount = dw_List.RowCount ( )

FOR ll_Row = ll_RowCount TO 1 STEP -1

	IF dw_List.IsSelected ( ll_Row ) THEN
		dw_List.RowsDiscard ( ll_Row, ll_Row, Primary! )
	END IF

NEXT

dw_List.Event ue_SetListAsClipboard ( )

RETURN li_Return
end event

event ue_append;//Append selected itinerary rows to the display list, and set the new list to the clipboard.

Long	ll_ItinRows, &
		ll_ItinRow, &
		ll_EventId, &
		ll_FoundRow
Boolean	lb_CopyThisRow
DataWindow	ldw_Itin
w_Itin		lw_Itinerary

Integer	li_Return = 1

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN

	ldw_Itin = lw_Itinerary.dw_Itin
	ll_ItinRows = ldw_Itin.RowCount ( )

	//If no rows are selected in the itinerary, scroll the display to the current row, since that
	//will be the row that we're copying.

	IF ldw_Itin.GetSelectedRow ( 0 ) = 0 AND ll_ItinRows > 0 THEN
		ll_ItinRow = ldw_Itin.GetRow ( )
		IF ll_ItinRow > 0 THEN
			ldw_Itin.ScrollToRow ( ll_ItinRow )
		END IF
	END IF

	//Turn redraw off to avoid flicker when copying multiple rows.
	dw_List.SetRedraw ( FALSE )

	
	//Loop through the itinerary and copy the appropriate rows.

	FOR ll_ItinRow = 1 TO ll_ItinRows

		lb_CopyThisRow = FALSE

		//If there are rows selected in the itinerary, copy this row only if it is selected.
		//If there are no rows selected in the itineary, copy this row if it is the current row.

		IF ldw_Itin.GetSelectedRow ( 0 ) > 0 THEN

			IF ldw_Itin.IsSelected ( ll_ItinRow ) THEN
				lb_CopyThisRow = TRUE
			END IF

		ELSE

			IF ldw_Itin.GetRow ( ) = ll_ItinRow THEN
				lb_CopyThisRow = TRUE
			END IF

		END IF


		IF lb_CopyThisRow THEN

			ll_EventId = ldw_Itin.Object.de_Id [ ll_ItinRow ]
			ll_FoundRow = dw_List.Find ( "de_Id = " + String ( ll_EventId ), 1, 9999 )
			
			 

			IF ll_FoundRow > 0 THEN
				dw_List.RowsDiscard ( ll_FoundRow, ll_FoundRow, Primary! )
			END IF

			ldw_Itin.RowsCopy ( ll_ItinRow, ll_ItinRow, Primary!, dw_List, 9999, Primary! )
			
			dw_list.Event ue_EventAdded ( ll_EventID )
			
		END IF

	NEXT

	dw_List.SetRedraw ( TRUE )

	dw_List.Event ue_SetListAsClipboard ( )
	dw_list.SetFocus()


ELSE
	li_Return = -1

END IF

RETURN li_Return
end event

event ue_routemode;//Display the insertion pointers on w_Itin, and tell it we're asking to route
//from the clipboard.

w_Itin	lw_Itinerary

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN

	//If no rows are selected, select them all.
	IF dw_List.GetSelectedRow ( 0 ) = 0 AND dw_List.RowCount ( ) > 0 THEN
		dw_List.SelectRow ( 0, TRUE )
	END IF

	This.Event ue_SetRouteModeIndicator ( TRUE )

	lw_Itinerary.show_ip()
	lw_Itinerary.whats_on = lw_Itinerary.ci_RouteRequest_Clipboard
	lw_Itinerary.tab_type.setfocus()

END IF

end event

event ue_optimize;Long		lla_SelectedRows[]
Long		ll_Count
Long		i,j
String 	ls_Site
String 	ls_CoPcm
String 	lsa_result[]
Long		ll_StartRow = 1
Long		ll_StartPos 
Long		ll_EndPos = 1
DataStore lds_Source
n_cst_String	lnv_String

n_cst_routing_pcmiler	lnv_Routing
n_cst_Trip				lnv_Trip
n_cst_trip_attribs	lnv_Attribs
lnv_Attribs = CREATE n_cst_trip_attribs
lnv_Routing = CREATE n_cst_routing_pcmiler

SetPointer ( HOURGLASS! )

lnv_Trip = THIS.of_CreateTrip (  )

IF IsValid ( lnv_Trip ) THEN
	lnv_Trip.of_Optimize ( lnv_Attribs , ib_Destination )

	lds_Source = THIS.of_GetOptimizationDataStore ( )
	ll_Count = lds_Source.RowCount () 
	
	IF ib_Origin THEN
		ll_EndPos = 2
	END IF

	IF ib_Destination THEN
		ll_StartPos = lnv_Attribs.RowCount ( )  - 1
	ELSE 
		ll_StartPos = lnv_Attribs.RowCount ( )
	END IF

//
//n_cst_Msg	lnv_Msg
//S_Parm		lstr_Parm
//Blob			lblb_State
//
//lnv_Attribs.GetFullState ( lblb_State )
//lstr_PArm.is_Label = "BLOB"
//lstr_Parm.ia_Value = lblb_State 
//lnv_Msg.of_Add_Parm ( lstr_Parm )
//
//OpenWithParm ( w_OptimizedStops , lnv_Msg )
//
//
//
	
	
	FOR i = ll_StartPos TO ll_EndPos STEP -1
		
		ls_Site = Upper ( TRIM (  lnv_Attribs.GetItemString ( i , "stop" ) ) )
		
		IF lnv_Routing.of_isLatLonDecimal ( ls_Site ) THEN
			lnv_String.of_ParsetoArray ( ls_Site , "," , lsa_Result )
			IF UpperBound ( lsa_Result ) = 3 THEN
				ls_Site = lnv_Routing.of_DecimalToDms ( lsa_Result[1] )
				ls_Site += ","
				ls_Site += lnv_Routing.of_DecimalToDms ( lsa_Result[2] )
			END IF
		END IF
		
		FOR j = ll_StartRow TO ll_Count 
			
			ls_CoPcm = UPPER ( TRIM ( lds_Source.GetItemString ( j , "co_pcm" ) ) ) 
			
			
			IF POS (ls_Site , ls_CoPcm ) > 0 THEN
				THIS.of_MoveToTop ( j , lds_Source )
				ll_StartRow ++ 
				EXIT 
			END IF
			
		NEXT
		
	NEXT
	
	THIS.of_InsertOptimized ( lds_Source )
	dw_List.SelectRow ( 0 , FALSE )
	
	FOR i = 1 TO ll_Count
		dw_List.SelectRow ( i , TRUE )
	NEXT

END IF


dw_list.SetRedraw ( TRUE )	

IF isValid ( lnv_Trip ) THEN
	DESTROY  ( lnv_Trip )
END IF
IF isValid ( lnv_Routing ) THEN
	DESTROY  ( lnv_Routing )
END IF
end event

event ue_moveup;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_BeforeRow, &
		ll_HoldRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount
		
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected

ll_SelectedRowCount = upperbound ( lla_Selected )
IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount
	
		ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )

		CHOOSE CASE ll_SelectedStartRow
			CASE 0 	//problem
				
			CASE 1	//No move necessary
				ll_HoldRow = ll_SelectedStartRow
				EXIT 
				
			CASE ELSE
				
				IF ll_RowNdx = 1 THEN
					ll_BeforeRow = ll_SelectedStartRow - 1
					ll_HoldRow = ll_SelectedStartRow
				ELSE
					ll_BeforeRow ++
				END IF
				
				ll_SelectedEndRow = ll_SelectedStartRow
				dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
				
		END CHOOSE
		
	NEXT
	
		//set row selections
		dw_list.SelectRow ( 0, FALSE)
		//first row to highlight
		ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
		ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

		FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
			
			dw_list.SelectRow (ll_RowNdx, TRUE)

			IF ll_RowNdx = ll_SelectedStartRow THEN
				dw_list.SetRow ( ll_RowNdx)
			END IF				

		next
	
ELSE
	ll_SelectedStartRow = dw_list.GetRow()
	ll_SelectedEndRow = dw_list.GetRow()
	IF ll_SelectedStartRow = 1 THEN
		//No move necessary
	ELSE
		ll_BeforeRow = ll_SelectedStartRow - 1
		dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
	END IF
	
END IF

dw_List.Event ue_SetListAsClipboard ( )

dw_list.SetFocus()


end event

event ue_movedown;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_BeforeRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_HoldRow
		
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected

ll_SelectedRowCount = upperbound ( lla_Selected )
IF ll_SelectedRowCount > 0 THEN

	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )
	IF ll_SelectedEndRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_HoldRow = ll_SelectedEndRow + 2
		FOR ll_RowNdx = 1 TO ll_SelectedRowCount 
		
			ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )
	
			CHOOSE CASE ll_SelectedStartRow
				CASE 0 	//problem
					
				CASE ELSE
					
					IF ll_RowNdx = 1 THEN
						ll_BeforeRow = ll_SelectedEndRow + 2
					END IF
					
					ll_SelectedEndRow = ll_SelectedStartRow
					dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
					
			END CHOOSE
			
		NEXT

		//set row selections
		dw_list.SelectRow ( 0, FALSE)
		//first row to highlight
		ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
		ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

		FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
			
			dw_list.SelectRow (ll_RowNdx, TRUE)

			IF ll_RowNdx = ll_SelectedStartRow THEN
				dw_list.SetRow ( ll_RowNdx)
			END IF				

		next
				
	END IF
	
ELSE
	ll_SelectedStartRow = dw_list.GetRow()
	ll_SelectedEndRow = dw_list.GetRow()
	IF ll_SelectedStartRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_BeforeRow = ll_SelectedEndRow + 2
		dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
		dw_list.SelectRow (ll_SelectedStartRow, FALSE)
		dw_list.SelectRow (ll_SelectedStartRow + 1, TRUE)
		dw_list.SetRow ( ll_SelectedStartRow + 1)
	END IF
	
END IF

dw_List.Event ue_SetListAsClipboard ( )

dw_list.SetFocus()

end event

event ue_movetop;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_BeforeRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount
		
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected

ll_SelectedRowCount = upperbound ( lla_Selected )
IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount
	
		ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )

		CHOOSE CASE ll_SelectedStartRow
			CASE 0 	//problem
				
			CASE 1	//No move necessary
				EXIT 
				
			CASE ELSE
				
				IF ll_RowNdx = 1 THEN
					ll_BeforeRow =  1
				ELSE
					ll_BeforeRow ++
				END IF
				
				ll_SelectedEndRow = ll_SelectedStartRow
				dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
			
		END CHOOSE
		
	NEXT
	
	//set row selections
	dw_list.SelectRow ( 0, FALSE)
	//first row to highlight
	ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

	FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
		
		dw_list.SelectRow (ll_RowNdx, TRUE)

		IF ll_RowNdx = ll_SelectedStartRow THEN
			dw_list.SetRow ( ll_RowNdx)
		END IF				

	next
	
ELSE
	ll_SelectedStartRow = dw_list.GetRow()
	ll_SelectedEndRow = dw_list.GetRow()
	IF ll_SelectedStartRow = 1 THEN
		//No move necessary
	ELSE
		ll_BeforeRow = 1
		dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
	END IF
	
END IF

dw_List.Event ue_SetListAsClipboard ( )

dw_list.SetFocus()


	

end event

event ue_movebottom;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_BeforeRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_HoldRow
		
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected

ll_SelectedRowCount = upperbound ( lla_Selected )
IF ll_SelectedRowCount > 0 THEN

	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )
	IF ll_SelectedEndRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_HoldRow = ll_SelectedEndRow + 2
		FOR ll_RowNdx = 1 TO ll_SelectedRowCount 
		
			ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )
	
			CHOOSE CASE ll_SelectedStartRow
				CASE 0 	//problem
					
				CASE ELSE
					
					IF ll_RowNdx = 1 THEN
						ll_BeforeRow = ll_RowCount + 1
					END IF
					
					ll_SelectedEndRow = ll_SelectedStartRow
					dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
					
			END CHOOSE
			
		NEXT
		//set row selections
		dw_list.SelectRow ( 0, FALSE)
		//first row to highlight
		ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
		ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

		FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
			
			dw_list.SelectRow (ll_RowNdx, TRUE)

			IF ll_RowNdx = ll_SelectedStartRow THEN
				dw_list.SetRow ( ll_RowNdx)
			END IF				

		next
		
	END IF
	
ELSE
	ll_SelectedStartRow = dw_list.GetRow()
	ll_SelectedEndRow = dw_list.GetRow()
	IF ll_SelectedStartRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_BeforeRow = ll_RowCount + 1
		dw_list.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_list, ll_BeforeRow, Primary! )
	END IF
	
END IF

dw_List.Event ue_SetListAsClipboard ( )

dw_list.SetFocus()

end event

event ue_selectpickups;Long	ll_RowCount 
Long	i

n_cst_beo_event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

ll_RowCount = dw_List.RowCount ( )
lnv_Event.of_SetSource ( dw_List )


FOR i = 1 TO ll_RowCount 
	lnv_Event.of_SetSourceRow ( i )
	
	IF lnv_Event.of_HasSource () THEN
		IF lnv_Event.of_IsPickUpGroup () THEN
			dw_List.SelectRow ( i , TRUE )
		END IF
	END IF
	
NEXT

IF ib_CalculateTotals THEN
	THIS.of_CalculateTotals ( )
END IF

DESTROY ( lnv_Event )



end event

event ue_selectdeliveries;Long	ll_RowCount 
Long	i

n_cst_beo_event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

ll_RowCount = dw_List.RowCount ( )
lnv_Event.of_SetSource ( dw_List )

FOR i = 1 TO ll_RowCount 
	lnv_Event.of_SetSourceRow ( i )
	
	IF lnv_Event.of_HasSource () THEN
		IF lnv_Event.of_IsDeliverGroup () THEN
			dw_List.SelectRow ( i , TRUE )
		END IF
	END IF
	
NEXT

IF ib_CalculateTotals THEN
	THIS.of_CalculateTotals ( )
END IF

DESTROY lnv_Event
end event

event ue_reverseorder;Long	lla_SelectedRows[]
Long	i
long	ll_Count
Long	ll_Index = 1
Int 	li_Rtn

DataStore	lds_Temp
lds_Temp = Create DataStore
lds_Temp.DataObject = "d_ship_itin"

ll_Count = THIS.of_GetSelectedRows ( lla_SelectedRows )

IF ll_Count = 0 THEN
	dw_List.SelectRow ( 0 , TRUE ) 
	ll_Count = THIS.of_GetSelectedRows ( lla_SelectedRows )
END IF

dw_List.SetRedraw ( FALSE ) 

FOR i = 1 TO ll_Count
	li_Rtn = dw_List.RowsCopy ( lla_SelectedRows [ i ] , lla_SelectedRows [ i ] , PRIMARY! , lds_Temp, 999,PRIMARY! )
NEXT


FOR i = ll_Count TO  1 STEP -1
	IF lds_Temp.RowsCopy ( i , i , PRIMARY! , dw_List , lla_SelectedRows [ ll_Index ] + 1 , PRIMARY! ) = 1 THEN
		li_Rtn = dw_List.DeleteRow ( lla_SelectedRows [ ll_Index ] )
		ll_Index ++
	END IF
NEXT


FOR i = 1 TO ll_Count 
	dw_List.SelectRow ( lla_SelectedRows [i] , TRUE )
NEXT
	
dw_List.SetRedraw ( TRUE ) 

IF isValid ( lds_Temp ) THEN
	Destroy ( lds_Temp ) 
END IF

IF ib_CalculateTotals THEN
	THIS.of_CalculateTotals ( )
END IF



end event

event ue_insertdeliveries;Long		ll_DeliveryCount
Long		ll_Count
Long		lla_SelectedRows[]
Long		i
Long		ll_CurrentShipID
Long		ll_CurrentShipSeq
Long		ll_FindRow
String	ls_EventType
String	ls_Find

n_cst_beo_event	lnv_Event
DataStore			lds_Deliveries

lnv_Event = CREATE n_cst_beo_Event

lds_Deliveries	= CREATE DataStore
lds_Deliveries.DataObject = "d_ship_itin"

dw_List.SetRedraw ( FALSE ) 
dw_List.SelectRow ( 0 , FALSE )

THIS.Event ue_SelectDeliveries ( ) 

ll_DeliveryCount = THIS.of_GetSelectedRows ( lla_SelectedRows )

FOR i = ll_DeliveryCount TO 1 STEP -1 
	dw_List.RowsMove ( lla_SelectedRows[i] , lla_Selectedrows[i] , PRIMARY! , lds_Deliveries , 1 , PRIMARY! )
NEXT

ll_Count = dw_List.RowCount ( )

lnv_Event.of_SetSource ( dw_List )

FOR i = ll_Count TO 1 STEP - 1 
	
	lnv_Event.of_SetSourceRow ( i )
	
	ll_CurrentShipID = lnv_Event.of_GetShipment ( )
	ll_CurrentShipSeq = lnv_Event.of_GetShipmentSequence () 
	
	ls_EventType = THIS.of_GetOppositeMove ( lnv_Event.of_GetType ( ) )

	ls_Find = "de_event_type = '" + ls_EventType + "' AND de_Shipment_id = " + String ( ll_CurrentShipID ) + &
		+ " and de_ship_seq > " + String ( ll_CurrentShipSeq ) 
			
	ll_FindRow = lds_Deliveries.Find ( ls_Find ,1 , 999  )
	
	IF ll_FindRow > 0 THEN
		lds_deliveries.RowsMove ( ll_FindRow , ll_FindRow , PRIMARY! , dw_List , i + 1 , PRIMARY! )
	END IF
	
NEXT

dw_List.SetRedraw ( TRUE ) 
IF isValid ( lds_Deliveries ) THEN
	DESTROY lds_Deliveries
END IF

DESTROY lnv_Event
end event

event ue_showrmbmenu;any 		laa_parm_values[]
String 	lsa_parm_labels[]
Long		ll_EventID, &
			ll_return = 1, &
			ll_ShipmentID

THIS.of_GetRMBMenu ( lsa_parm_labels[] , laa_parm_values[] )

IF UpperBound( laa_parm_values ) > 0 THEN
	THIS.Event ue_ProcessRequest (  f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values ) )
END IF

end event

event ue_processrequest;CHOOSE CASE UPPER ( as_request )
		
	CASE "IMPORT PICKUPS"
		THIS.Event ue_ImportPickUps ( )
		
	CASE "IMPORT DELIVERIES"
		THIS.Event ue_ImportDeliveries ( )
		
END CHOOSE
RETURN 1
end event

event ue_importpickups;Long		lla_ShipmentIDS[]
Long		lla_EventIds[]
Long		i	
Long		ll_EventCount

n_cst_AnyArraySrv	lnv_Array
IF dw_List.RowCount ( ) > 0 THEN
	lla_ShipmentIDS = dw_list.object.de_shipment_id.Primary
	lnv_Array.of_GetShrinked ( lla_ShipmentIDS , TRUE, TRUE )
	
	THIS.of_GetEventidsForLoading ( lla_EventIds , "PICKUP" , lla_ShipmentIDS )
	
	THIS.Event ue_LoadEvents ( lla_EventIds )
END IF

ll_EventCount = UpperBound ( lla_EventIDs )
FOR i = 1 TO ll_EventCount
	dw_List.Event ue_EventAdded ( lla_EventIDS[i] )
NEXT


//ls_PUtypes = gc_Dispatch.cs_EventType_Pickup +&
//				 gc_Dispatch.cs_EventType_Hook   +&
//				 gc_Dispatch.cs_EventType_Mount
//				 
//THIS.Event ue_ImportEvents ( lla_ShipmentIDS , ls_PUtypes )
end event

event ue_importdeliveries;Long		lla_ShipmentIDS[]
Long		lla_EventIds[]
Long		i
Long		ll_EventCount

n_cst_anyarraysrv	lnv_Array
IF dw_List.RowCount ( ) > 0 THEN
	lla_ShipmentIDS = dw_list.object.de_shipment_id.Primary
	lnv_Array.of_GetShrinked ( lla_ShipmentIDS , TRUE, TRUE )
	
	
	THIS.of_GetEventidsForLoading ( lla_EventIds , "DELIVER" , lla_ShipmentIDS )
	
	THIS.Event ue_LoadEvents ( lla_EventIds )
END IF

ll_EventCount = UpperBound ( lla_EventIDs )
FOR i = 1 TO ll_EventCount
	dw_List.Event ue_EventAdded ( lla_EventIDS[i] )
NEXT

//ls_Deltypes = gc_Dispatch.cs_EventType_Deliver + &
//			 	 gc_Dispatch.cs_EventType_Drop + &
//			    gc_Dispatch.cs_EventType_Dismount
//			
//THIS.Event ue_ImportEvents ( lla_ShipmentIDS , ls_DelTypes )
end event

event ue_importevents;



//*************************** THIS was code to import directly From the shipment
//String	ls_Filter
//String	ls_InString
//Long		ll_ShipmentCount
//Long		i
//String	ls_OldFilter
//
//DataStore	lds_Events
//lds_Events = CREATE DataStore
//
//n_cst_anyarraysrv	lnv_Array
//PowerObject	lpo_EventSource
//n_cst_bso_Dispatch	lnv_Dispatch
//n_cst_dws	lnv_Dws
//
//ll_ShipmentCount = Upperbound ( ala_shipmentids[] )
//
//ls_InString  = "("
//FOR i = 1 To ll_ShipmentCount
//	ls_InString += String ( ala_shipmentids[] [i] )
//	IF i <> ll_ShipmentCount THEN
//		ls_InString += "," 	
//	END IF
//NEXT
//ls_InString	+= ")"
//
//lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
//lnv_Dispatch.of_RetrieveShipments ( ala_shipmentids )
//
//lpo_EventSource = lnv_Dispatch.of_getEventCache (  )
//lds_Events.Dataobject = lnv_Dws.of_GetDataObject ( lpo_EventSource )
//
//lnv_dws.of_RowsCopy ( lpo_EventSource , 1 , lnv_Dws.of_RowCount ( lpo_EventSource ) , PRIMARY! , lds_Events, 9999 , PRIMARY! )
//lnv_dws.of_RowsCopy ( lpo_EventSource , 1 , lnv_Dws.of_FilteredCount ( lpo_EventSource ) , Filter! , lds_Events, 9999 , PRIMARY! )
//
//ls_Filter = "de_shipment_id in " + ls_InString + " and Pos ( '" + UPPER ( as_types ) + "' ,de_event_Type ) > 0"
//
//lds_Events.SetFilter	( ls_Filter )
//lds_Events.Filter ( )
//
//lds_Events.RowsCopy ( 1 , lds_Events.RowCount( ) , PRIMARY! , dw_list, 9999 , PRIMARY! )
//DESTROY ( lds_Events )
Return -1
//
end event

event ue_loadevents;String ls_FindString	
Long	ll_IDCount
Long	i
Long	ll_FoundRow

ll_IdCount = UpperBound ( ala_eventids[] )

n_ds	lds_EventCache
n_cst_Bso_Dispatch	lnv_Dispatch

lnv_Dispatch = THIS.Event ue_GetDispatchManager ()
lds_EventCache = lnv_Dispatch.of_GetEventCache ( )

For i = ll_IDCount  TO 1 STEP -1
	ls_FindString = "de_id = " + String ( ala_eventids[i] ) 
	ll_FoundRow = lds_EventCache.Find ( ls_FindString , 1 , 9999 )
	IF	ll_FoundRow > 0 THEN
		lds_EventCache.RowsCopy ( ll_FoundRow , ll_foundRow , PRIMARY! , dw_list, 9999 , PRIMARY! )
	END IF
	
NEXT
	
RETURN 1


end event

event ue_showtotals;Long	lla_SelectedRows []
dw_List.SetRedraw ( FALSE )

ib_CalculateTotals = TRUE

dw_list.Height = 608

cb_totals.Text = "&Hide"

dw_List.modify("st_weight.visible = '1' cntn4_length.visible = '1'")
dw_List.modify("st_instructions.visible = '1' companies_dispatchinstructions.visible = '1'")
dw_List.modify("st_Runningweight.visible = '1' cntn3_length.visible = '1'")
dw_list.modify("st_Shipmentweight.visible = '1' cntn2_length.visible = '1'")
dw_list.modify("st_ApptDate.visible = '1' de_apptDate.visible = '1' de_apptTime.visible = '1' ")

dw_list.Object.DataWindow.HorizontalScrollSplit = 261


//IF THIS.of_GetSelectedRows ( lla_SelectedRows ) = 0 THEN
//	dw_List.SelectRow ( 0 , TRUE ) 
//	THIS.of_CalculateTotals ( ) 
//	dw_List.SelectRow ( 0 , FALSE ) 
//END IF

dw_List.Post SetRedraw ( TRUE )
THIS.SetRedraw ( TRUE )
end event

event ue_hidetotals;dw_List.SetRedraw ( FALSE )

//dw_List.HSplitScroll= FALSE
//dw_List.hscrollbar = FALSE

ib_CalculateTotals = FALSE
dw_list.Height = 756
cb_totals.Text = "S&how"

sle_mileage.Text = ""
sle_drivetime.Text = ""
sle_totaltime.Text = ""
//sle_totalweight.Text = ""

dw_List.modify("st_Runningweight.visible = '0' cntn3_length.visible = '0'")
dw_list.modify("st_weight.visible = '0' cntn4_length.visible = '0'")
dw_List.modify("st_instructions.visible = '0' companies_dispatchinstructions.visible = '0'")
dw_list.modify("st_Shipmentweight.visible = '0' cntn2_length.visible = '0'")
dw_list.modify("st_ApptDate.visible = '0' de_apptDate.visible = '0' de_apptTime.visible = '0'" )

dw_list.Object.DataWindow.HorizontalScrollSplit = 0
dw_List.Object.DataWindow.HorizontalScrollPosition = 0 
dw_List.SetRedraw ( TRUE )

THIS.SetRedraw ( TRUE )
end event

event ue_rowclicked;THIS.Post of_CalculateTotals ( )
end event

event ue_gotoshipment;Long	 	ll_ShipmentID
String 	lsa_parm_labels[]
Any		laa_parm_values[]
n_cst_beo_Event	lnv_Event
w_Itin	lw_Itinerary

lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( dw_list )
lnv_Event.of_SetSourceRow ( al_Row )

ll_ShipmentID = lnv_Event.of_GetShipment ( )

IF ll_ShipmentId > 0 THEN
	
	lw_Itinerary = THIS.Event ue_GetItineraryWindow ( )
			
	lw_Itinerary.post jump_ship(ll_ShipmentId, FALSE)
	
END IF

DESTROY ( lnv_Event ) 

RETURN 1
end event

protected function integer of_getselectedrows (ref long ala_rows[]);Long	ll_Count
n_cst_Dws	lnv_Dws
//ll_Count = dw_list.inv_RowSelect.of_SelectedCount ( ala_rows[] )
ll_Count = lnv_Dws.of_SelectedCount ( dw_list , ala_rows[] )
RETURN ll_Count
end function

private function integer of_movetotop (long al_Row, ref dataStore ads_Source);Long	ll_BeforeRow = 1
		


ads_Source.RowsMove ( al_Row, al_Row, Primary!, ads_Source, ll_BeforeRow, Primary! )

//dw_List.Event ue_SetListAsClipboard ( )

//dw_list.SetFocus()

RETURN 1
	

end function

private function datastore of_getoptimizationdatastore ();Long			lla_SelectedRows[]
Long			ll_Count
Long			i

DataStore	lds_Return

lds_Return = CREATE DataStore
lds_Return.dataobject = "d_ship_itin"

ll_Count = THIS.of_GetSelectedRows ( lla_SelectedRows )

FOR i = ll_Count TO 1 STEP -1
	dw_list.RowsMove ( lla_SelectedRows[i], lla_SelectedRows[i], PRIMARY!, lds_Return , 1 ,PRIMARY! )
	
NEXT 


RETURN lds_Return

end function

private function integer of_insertoptimized (datastore ads_source);Long	i
Long	ll_Count

ll_Count = ads_Source.RowCount() 

FOR i = ll_Count TO 1 STEP -1
	
	ads_Source.RowsMove ( i , i , PRIMARY! , dw_List , 1 , PRIMARY! )
	
NEXT 

RETURN 1
end function

private function String of_getoppositemove (string as_Source);String	ls_Return 


CHOOSE CASE as_Source
		
	CASE gc_Dispatch.cs_EventType_Deliver
		ls_Return = gc_Dispatch.cs_EventType_Pickup
		
	CASE gc_Dispatch.cs_EventType_Pickup
		ls_Return = gc_Dispatch.cs_EventType_Deliver		
		
	CASE gc_Dispatch.cs_EventType_NewTrip
		ls_Return = gc_Dispatch.cs_EventType_EndTrip
		
	CASE gc_Dispatch.cs_EventType_EndTrip
		ls_Return = gc_Dispatch.cs_EventType_NewTrip
		
	CASE gc_Dispatch.cs_EventType_Hook
		ls_Return = gc_Dispatch.cs_EventType_Drop	
		
	CASE 	gc_Dispatch.cs_EventType_Drop	
		ls_Return = gc_Dispatch.cs_EventType_Hook
		
	CASE  gc_Dispatch.cs_EventType_Mount
		ls_Return = gc_Dispatch.cs_EventType_Dismount 
		
	CASE	gc_Dispatch.cs_EventType_Dismount	
		ls_Return = gc_Dispatch.cs_EventType_Mount

END CHOOSE

RETURN ls_Return
end function

public function n_cst_trip of_createtrip ();RETURN THIS.of_CreateTrip ( TRUE )
end function

private function integer of_getrmbmenu (ref string asa_lables[], ref any aaa_values[]);Long	ll_EventCount
Long	i
Long	ll_LabelCount
Long	ll_ValueCount
String	ls_FirstType
Boolean	lb_PU
Boolean	lb_Del
Boolean	lb_Continue = TRUE
String	lsa_parm_labels []
Any		laa_parm_values []

n_cst_Beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

/******************************************************************************
	This section is used to determine if the event types are all the same, and if 
	so to supply the right menu message
******************************************************************************/	

	lnv_Event.of_SetSource ( dw_list )
	ll_EventCount = dw_list.RowCount ( )
	
	IF	ll_EventCount > 0 THEN
		lnv_Event.of_SetSourceRow ( 1 )
		
		
		lb_PU = lnv_Event.of_IsPickUpGroup ( ) 
		lb_Del = lnv_Event.of_IsDeliverGroup ( )
		
		IF NOT ( lb_PU OR lb_Del ) THEN
			lb_Continue = FALSE
		END IF
		
		
	END IF
	IF lb_Continue THEN
		FOR i = 2 TO ll_EventCount
		
			lnv_Event.of_SetSourceRow ( i )
			
			lb_Continue = ( (lnv_Event.of_IsPickupGroup ( ) = lb_PU) AND ( NOT (lnv_Event.of_IsDeliverGroup ( ) =  lb_PU ) ) )
			IF NOT lb_Continue THEN
				EXIT
			END IF
		
			
		
		NEXT
	END IF
	
	IF lb_Continue THEN
		
		ll_LabelCount ++
		ll_ValueCount ++
		
		lsa_parm_labels[ ll_LabelCount ] = "ADD_ITEM"
		
		IF lb_PU THEN
			laa_parm_values[ ll_ValueCount ] = "Import Deliveries"
		ELSE
			laa_parm_values[ ll_ValueCount ] = "Import Pickups"
		END IF
		
	END IF
	
/*********************************************************************************/

asa_Lables = lsa_parm_labels
aaa_Values = laa_parm_values
	
DESTROY ( lnv_Event )
	
RETURN 1
end function

public function integer of_geteventidsforloading (ref long ala_eventids[], string as_type, long ala_shipmentids[]);Int	li_EventCount
Int	i
Long	lla_EventIds[]
Int	li_Count
n_ds						lds_EventSource
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lnv_Dispatch = THIS.Event ue_GetDispatchManager ( ) 
lds_EventSource = lnv_Dispatch.of_GetEventCache ( )
lnv_Event.of_SetSource ( lds_EventSource )

li_EventCount = lds_EventSource.RowCount ( )

FOR i = 1 TO li_EventCount
	lnv_Event.of_SetSourceRow ( i )	
	IF THIS.of_IncludeEvent ( lnv_Event , as_type , ala_shipmentids  ) THEN
		li_Count ++
		lla_EventIds [ li_Count ] = lnv_Event.of_GetID ( )
	END IF
NEXT

THIS.of_RemoveExistingIDs ( lla_EventIDs )

ala_Eventids = lla_EventIds []

DESTROY ( lnv_Event )

RETURN UpperBound ( lla_EventIds[] )
end function

private function integer of_removeexistingids (ref long ala_eventids[]);Long	lla_ExistingIds[]
Int	li_ExistingCount
Long	lla_KeepList[]
Int	li_KeepIndex
Int	i,j
Int	li_Count

lla_ExistingIDs = dw_List.Object.de_id.Primary
li_ExistingCount = UpperBound ( lla_ExistingIDS )

li_Count = UpperBound( ala_EventIds )

FOR i = 1 TO li_Count
	FOR j = 1 TO li_ExistingCount
		IF ala_EventIds[i] = lla_Existingids[j] THEN
			EXIT
		END IF
	NEXT
	IF j > li_ExistingCount THEN
		li_KeepIndex ++
		lla_KeepList[ li_KeepIndex ] = ala_EventIds [ i ]
	END IF
NEXT

ala_eventids = lla_KeepList

RETURN 1
end function

public function n_cst_trip of_createtrip (boolean ab_interactive);/** 
**		this method will return n_cst_trip populated from the selected rows. It will not  
**	add an entry to the trip if the row does not have a pcm locator.
**
**	If The user cancels the trip will be set null and returned
**
**/

Boolean	lb_Continue = TRUE
Long		lla_SelectedRows[]
Long		ll_Count
Long		i
String	ls_Origin
String	ls_Destination
String	ls_Locator
String	lsa_Locators[]
Long		lla_BadRows[]
n_cst_Msg	lnv_Msg
S_Parm	lstr_Parm
n_cst_Trip	lnv_Trip

ll_Count = THIS.of_GetSelectedRows ( lla_SelectedRows )

IF ab_interactive THEN
	Open ( w_OriginDestination )
	lnv_Msg = Message.PowerobjectParm
	
	IF lnv_Msg.OF_Get_Parm ( "ORIGIN" , lstr_Parm ) <> 0 THEN
		ls_Origin = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.OF_Get_Parm ( "DESTINATION" , lstr_Parm ) <> 0 THEN
		ls_Destination = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "CONTINUE" , lstr_Parm ) <> 0 THEN
		lb_Continue = lstr_Parm.ia_Value
	END IF
END IF

IF lb_Continue THEN
	
	lnv_Trip = CREATE n_cst_Trip
	dw_list.SetRedraw ( FALSE )
	
	IF Len ( ls_Origin ) > 0 THEN
		ib_Origin = TRUE
		lsa_Locators [ UpperBound ( lsa_Locators ) + 1 ] = ls_Origin
	ELSE
		ib_Origin = FALSE
	END IF
	
	FOR i = 1 TO ll_Count
		
		ls_Locator = dw_list.GetItemString ( lla_SelectedRows [ i ] , "co_pcm" )
		IF ( Not isNull ( ls_Locator ) ) AND Len ( ls_Locator ) > 0 THEN
			lsa_Locators [ UpperBound ( lsa_Locators ) + 1 ] = ls_Locator 
		ELSE
			lla_BadRows [ Upperbound  ( lla_BadRows ) + 1 ] = lla_SelectedRows [i]
//			dw_list.SelectRow ( lla_SelectedRows [i] , FALSE )
		END IF
	
	NEXT
	
	IF Len ( ls_Destination ) > 0 THEN
		ib_Destination = TRUE
		lsa_Locators [ UpperBound ( lsa_Locators ) + 1 ] = ls_Destination
	ELSE
		ib_Destination = FALSE
	END IF
	
	
	ll_Count =  UpperBound ( lla_BadRows )
	IF ll_Count > 0 AND ab_interactive THEN
		IF MessageBox ( "Calculate Trip" , String ( ll_Count ) + " rows do not have sites specified with valid locators. Do you want continue with the calculation without these sites?", QUESTION! , YESNO! , 2 ) = 2 THEN
			SetNull ( lnv_Trip )
			dw_List.SelectRow ( 0 , FALSE )
		END IF
	END IF
	
	IF isValid ( lnv_Trip ) THEN
		ll_Count = UpperBound ( lsa_Locators )
		FOR i = 1 TO ll_Count
			lnv_Trip.of_AddStop ( lsa_Locators[ i ] )
		NEXT
	END IF
END IF

dw_list.SetRedraw ( TRUE )

RETURN lnv_Trip
end function

protected function integer of_calculatetotals ();// the order of the calls is important
sle_mileage.Text =  THIS.of_CalculateMileage( )  
sle_drivetime.Text = THIS.of_CalculateDriveTime ( )
sle_totaltime.Text = THIS.of_CalculateTotalTimes ( )
//sle_totalweight.Text = THIS.of_CalculateTotalWeight ( )
THIS.of_CalculateRunningWeight ( )
sle_low.Text = String ( THIS.of_GetLowValue ( ) )
sle_high.Text = String ( THIS.of_GetHighValue ( ) )
RETURN 1

end function

protected function string of_calculatedrivetime ();n_cst_Trip	lnv_Trip
Long		ll_Minutes
Decimal	lc_Distance
Long		ll_Hours
Long		ll_Mins

String	ls_Return

lnv_Trip = THIS.of_CreateTrip ( FALSE  ) // don't ask for origin/dest 

IF il_DriveMinutes > 0 THEN  // try the instance first
	ll_Hours =  il_DriveMinutes / 60 
	ll_Mins = MOD ( il_DriveMinutes , 60 )
	ls_Return = String ( String ( ll_Hours ) +":" + String (  ll_Mins, "00" )  ) 
	
ELSE  // Try and calculate

	IF IsValid ( lnv_Trip ) THEN
		lnv_Trip.of_Calculate( lc_Distance , il_DriveMinutes )
		
		ll_Hours =  il_DriveMinutes / 60 
		ll_Mins = MOD ( il_DriveMinutes , 60 )
		ls_Return = String ( String ( ll_Hours ) +":" + String (  ll_Mins, "00" )  ) 
			
	END IF
END IF

RETURN ls_Return
end function

protected function string of_calculatemileage ();n_cst_Trip	lnv_Trip
Long	ll_Minutes
Decimal{2}	lc_Distance
Long		ll_Hours
Long		ll_Mins

String ls_Return

lnv_Trip = THIS.of_CreateTrip ( FALSE  ) // don't ask for origin/dest 

IF IsValid ( lnv_Trip ) THEN
	lnv_Trip.of_Calculate( lc_Distance , il_DriveMinutes )
	ls_Return = String ( lc_Distance	)
END IF

RETURN ls_Return
end function

protected function string of_calculatetotaltimes ();Long		lla_Rows[]
Long		ll_RowCount 
Long		i
Time		lt_duration
Long		ll_TotalMinutes
Int		li_Hours
String	lsa_Result[]
String 	ls_Return
Decimal	lc_Distance
Long		ll_minutes

n_cst_Trip	lnv_Trip


n_cst_beo_Event	lnv_Event
n_cst_beo_Company	lnv_Company
n_cst_String	lnv_String

lnv_Event = CREATE n_cst_beo_Event

ll_RowCount = THIS.of_GetSelectedRows ( lla_Rows )

FOR i = 1 TO ll_RowCount
	
	lnv_Event.of_SetSource ( dw_list )
	lnv_Event.of_SetSourceRow ( i )
	
	lnv_Event.of_GetSite ( lnv_Company )
	
	lt_duration = lnv_Company.of_GetDefaultDuration (  ) 	
	
	lnv_String.of_ParseToArray ( String ( lt_Duration) , ":" , lsa_Result )
	
	IF UpperBound ( lsa_Result ) > 1 THEN
		li_Hours = Integer ( lsa_Result [1] )
		ll_minutes = Integer ( lsa_Result [2] )
	END IF
	
	ll_TotalMinutes += li_Hours * 60
	ll_TotalMinutes += ll_minutes

NEXT

IF il_DriveMinutes > 0 THEN // try the instance
	ll_TotalMinutes += il_DriveMinutes
ELSE
	lnv_Trip = THIS.of_CreateTrip ( FALSE  ) // don't ask for origin/dest 
	IF IsValid ( lnv_Trip ) THEN
		lnv_Trip.of_Calculate( lc_Distance , il_DriveMinutes )
		ll_TotalMinutes += il_DriveMinutes
	END IF
END IF


li_Hours =  ll_TotalMinutes / 60 
ll_minutes = MOD ( ll_TotalMinutes , 60 )
ls_Return = String ( String ( li_Hours ) +":" + String (  ll_minutes, "00" )  ) 
		
DESTROY ( lnv_Event ) 
DESTROY lnv_Company

RETURN ls_Return

end function

public function integer of_getdeliverweights (long al_eventid);Long		ll_EventID
Long		ll_Shipment
String	ls_Find
Int		li_Seq
Long		ll_Weight

n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event


ll_EventID = al_EventID

lnv_Event.of_SetSource ( dw_list )
lnv_Event.of_SetSourceID ( ll_EventID )

li_Seq = lnv_Event.of_getShipSeq ( )
ll_Shipment = lnv_Event.of_GetShipment ( )

SELECT sum ( di_totitemweight ) INTO :ll_Weight 
FROM disp_items
WHERE di_Shipment_id = :ll_Shipment AND di_del_event  = :li_seq;

CHOOSE CASE SQLCA.sqlCode		
	CASE Is	< 0 
		RollBack;
	CASE ELSE	
		COMMIT ;
END CHOOSE

DESTROY ( lnv_Event )

RETURN ll_Weight
end function

protected function string of_calculatetotalweight ();String	ls_Temp
Long		ll_Count
Long		i
Long		ll_Total
Long		lla_SelectedRows[]

ll_Count = THIS.of_GetSelectedRows ( lla_SelectedRows )

FOR i = 1 TO ll_Count 
	ll_Total += dw_list.object.cntn4_length[ lla_SelectedRows[i] ]
NEXT

ls_Temp = String ( ll_Total )

RETURN ls_Temp
end function

public function integer of_calculaterunningweight ();Long	ll_RowCount
Long	i,j
Long	ll_Previous
Long	ll_Start
Long	lla_SelectedRows[]
Long	ll_SelectedCount
Long	ll_Null
SetNull ( ll_Null )
Boolean	lb_Clear

  ll_SelectedCount = THIS.of_GetSelectedRows ( lla_SelectedRows )

ll_RowCount = dw_list.RowCount ( )

FOR i = 1 to ll_RowCount
	lb_Clear = TRUE
	for j = 1 to ll_SelectedCount
		if i = lla_SelectedRows[j] THEN
			lb_Clear = FALSE
			EXIT
		END IF
	NEXT
	
	IF lb_Clear THEN
		dw_List.Object.cntn3_Length[i] = ll_Null
	END IF 
	
NEXT



IF ll_RowCount > 0 AND ll_SelectedCount > 0 THEN
	ll_Start = dw_list.object.cntn4_Length [ lla_SelectedRows[1] ]
	dw_list.object.cntn3_Length [ lla_SelectedRows[1] ] = ll_Start
	
	FOR i = 2 TO ll_SelectedCount
		
		dw_list.object.cntn3_Length[ lla_SelectedRows[i] ] = dw_list.object.cntn3_Length[lla_SelectedRows[i - 1] ] + dw_list.object.cntn4_Length [ lla_SelectedRows[i]  ]
	NEXT
END IF

RETURN 1








/*									 (control list )
procedure Backtrack(formula,  variables      , labeling)
{

	make a copy of the formula.
	
	if Coltroll list has literals then
		{
		
			editorRtn = callEditor ( formula , literals )
			if editorRtn = 1 // success
				return true;
			ELSE if ( editorRtn = 0 ) //  don't know
				return BackTrack( formula from editor , Literals )
			else
				return false;
		
		}
   
	Else
		{
		    choose an unassigned variable, say x, and give it the value
           false. Throughout formula, if a clause includes the literal x,
           erase the entire clause; if a clause includes ~x, erase the
           ~x. Report the result of: 
			  
				IF  ( call editor )  // if the editor returns 1 then success
			  		return true // hard rtn
				Else if the editor return is 0 then //unknown
					return backtrack ( formula from editor , control list )
				ELSE // the instantiation failed swith signs and use old list
					return backTrack ( oldList , switchedsign )
			  



*/
end function

public function boolean of_allitemsassigned (long al_shipmentid);Boolean	lb_Rtn = TRUE
Long		ll_ItemCount


SELECT Count ( di_item_Id ) INTO :ll_ItemCount 
FROM disp_items 
WHERE di_Shipment_id = :al_shipmentid AND (di_Item_type = 'L' ) AND ( di_Pu_Event is null OR di_Del_Event is null );
	COMMIT ;

IF  ll_ItemCount > 0 THEN
	lb_Rtn = FALSE
END IF

RETURN lb_Rtn


















//Long		ll_EventID
//Long		ll_Shipment
//boolean  lb_Return = TRUE
//Int		li_FetchRtn
//Int		li_Seq
//Setnull ( li_Seq )
//ll_Shipment = al_ShipmentID
//
//// Declare cursor emp_curs for employee table 
//
//// retrieval.
//DECLARE Item_curs CURSOR FOR 
//	SELECT di_item_id FROM disp_items
//	WHERE di_Shipment_id = :ll_Shipment  AND ( di_pu_event = null OR di_del_event = null);
//
//
//// Execute the SELECT statement with 
//
//OPEN Item_curs;
//
//// At this point, if there are no errors, 
//// the cursor is available for further
//// processing.
//
//// Go get the first row from the result set.
//Do 
//	FETCH NEXT Item_curs INTO :ll_EventID;
//	
//	li_FetchRtn = SQLCA.sqlCode
//
//	CHOOSE CASE li_FetchRtn
//		CASE -1
//			EXIT
//		CASE  0 , 100
//			IF ll_EventID > 0 THEN
//				MessageBox ( "event id" , ll_EventID )
//				lb_Return = FALSE
//				EXIT
//			END IF
//		CASE ELSE
//			//EXIT
//	END CHOOSE
//	
//	
//LOOP WHILE li_FetchRtn <> 100
//
//close Item_Curs;
//
//COMMIT;
//
//
//RETURN lb_Return
end function

public function long of_getlowvalue ();Long	ll_RowCount
Long	i,j
long	ll_Min
Long	ll_Temp

ll_RowCount = dw_list.RowCount ( )
IF ll_RowCount > 0 THEN
	
	FOR j = 1 to ll_RowCount
		ll_Min = dw_list.object.cntn3_length [ j ]
		IF Not IsNull ( ll_Min  ) THEN
			EXIT
		END IF
	NEXT
	
	FOR i = j To ll_RowCount
		ll_Temp = dw_list.object.cntn3_length [ i ]
		IF ll_Temp < ll_Min THEN
			ll_Min = ll_Temp
		END IF
	NEXT
END IF


RETURN ll_Min
end function

public function long of_gethighvalue ();Long	ll_RowCount
Long	i,j
long	ll_Max
Long	ll_Temp

ll_RowCount = dw_list.RowCount ( )
IF ll_RowCount > 0 THEN
	
	FOR j = 1 to ll_RowCount
		ll_Max = dw_list.object.cntn3_length [ j ]
		IF Not IsNull ( ll_Max  ) THEN
			EXIT
		END IF
	NEXT
	
	FOR i = j To ll_RowCount
		ll_Temp = dw_list.object.cntn3_length [ i ]
		IF ll_Temp > ll_Max THEN
			ll_Max = ll_Temp
		END IF
	NEXT
END IF



RETURN ll_Max
end function

public function integer of_calculateshipmentweight (long al_shipment);Long	ll_Weight


SELECT ds_Total_Weight INTO :ll_Weight 
FROM disp_Ship 
WHERE ds_ID = :al_shipment ;

CHOOSE CASE SQLCA.sqlCode		
	CASE Is	< 0 
		RollBack;
	CASE ELSE	
		COMMIT ;
END CHOOSE


RETURN ll_Weight
end function

public function long of_getpickupweights (long al_eventid);Long		ll_EventID
Long		ll_Shipment
String	ls_Find
Int		li_Seq
Long		ll_Weight

n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_Cst_beo_Event

ll_EventID = al_EventID

lnv_Event.of_SetSource ( dw_list )
lnv_Event.of_SetSourceID ( ll_EventID )

li_Seq = lnv_Event.of_getShipSeq ( )
ll_Shipment = lnv_Event.of_GetShipment ( )

SELECT sum ( di_totitemweight ) INTO :ll_Weight 
FROM disp_items
WHERE di_Shipment_id = :ll_Shipment AND di_pu_event  = :li_seq;

CHOOSE CASE SQLCA.sqlCode		
	CASE Is	< 0 
		RollBack;
	CASE ELSE	
		COMMIT ;
END CHOOSE

DESTROY ( lnv_Event )

RETURN ll_Weight
end function

public function string of_convertpcm (string as_PCM);RETURN ""
//
//Boolean 	lb_Match
//String 	ls_MatchString
//String	lsa_Results[]
//n_cst_String	lnv_String
//
//lnv_String.of_ParseToArray ( as_PCM , "," , lsa_Result )
//// if streets locator
//// should be in the form of lsa_Result [ 1 ] = XXX.XXXXD // decimal lat/lon
////												   [ 2 ] = XXX.XXXXD // decimal lat/lon
////													[ 3 ] = SS 			 // state 
//
//ls_MatchString = "^[0-9*][0-9*][0-9].[0-9]*[NESW]$"
//
//
//IF UpperBound ( lsa_Result ) = 3 THEN
//	
//	IF match (lsa_Result [1], ls_MatchString ) AND &
//		match (lsa_Result [2], ls_MatchString ) AND &
//		match (lsa_Result [3], "^[A-Z][A-Z]$" ) THEN
//		
//		
//		
//	
//	
//
//
end function

private function boolean of_includeevent (n_cst_beo_event anv_event, string as_group, long ala_shipmentids[]);Boolean	lb_Return
Long	ll_ShipmentCount
Long	i

IF Not isValid ( anv_Event ) THEN
	RETURN lb_Return 
END IF

ll_ShipmentCount = UpperBound	( ala_ShipmentIDs )

CHOOSE CASE UPPER ( as_Group )
		
	CASE "PICKUP"
		
		FOR i = 1 TO ll_ShipmentCount 
			IF anv_Event.of_GetShipment ( ) = ala_ShipmentIDs[i] THEN 
				EXIT
			END IF
		NEXT 
		
		IF anv_Event.of_IsPickupGroup ( ) AND i <= ll_ShipmentCount THEN
			lb_Return = TRUE
		END IF
		
	CASE "DELIVER"
		FOR i = 1 TO ll_ShipmentCount 
			IF anv_Event.of_GetShipment ( ) = ala_ShipmentIDs[i] THEN 
				EXIT
			END IF
		NEXT 
		
		IF anv_Event.of_IsDeliverGroup ( ) AND i <= ll_ShipmentCount THEN
			lb_Return = TRUE
		END IF
		
END CHOOSE

RETURN lb_Return
			
end function

on u_cst_eventrouting_clipboard.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_7=create gb_7
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.st_route=create st_route
this.cb_optimize=create cb_optimize
this.cb_all=create cb_all
this.cb_pickups=create cb_pickups
this.cb_deliveries=create cb_deliveries
this.cb_reverseorder=create cb_reverseorder
this.cb_importpickups=create cb_importpickups
this.cb_importdeliveries=create cb_importdeliveries
this.cb_totals=create cb_totals
this.st_1=create st_1
this.sle_drivetime=create sle_drivetime
this.sle_mileage=create sle_mileage
this.st_mileage=create st_mileage
this.sle_low=create sle_low
this.sle_totaltime=create sle_totaltime
this.sle_high=create sle_high
this.st_2=create st_2
this.st_3=create st_3
this.cb_invert=create cb_invert
this.cb_route=create cb_route
this.gb_4=create gb_4
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.gb_7
this.Control[iCurrent+4]=this.gb_5
this.Control[iCurrent+5]=this.gb_6
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_5
this.Control[iCurrent+11]=this.cb_6
this.Control[iCurrent+12]=this.cb_7
this.Control[iCurrent+13]=this.cb_8
this.Control[iCurrent+14]=this.cb_9
this.Control[iCurrent+15]=this.st_route
this.Control[iCurrent+16]=this.cb_optimize
this.Control[iCurrent+17]=this.cb_all
this.Control[iCurrent+18]=this.cb_pickups
this.Control[iCurrent+19]=this.cb_deliveries
this.Control[iCurrent+20]=this.cb_reverseorder
this.Control[iCurrent+21]=this.cb_importpickups
this.Control[iCurrent+22]=this.cb_importdeliveries
this.Control[iCurrent+23]=this.cb_totals
this.Control[iCurrent+24]=this.st_1
this.Control[iCurrent+25]=this.sle_drivetime
this.Control[iCurrent+26]=this.sle_mileage
this.Control[iCurrent+27]=this.st_mileage
this.Control[iCurrent+28]=this.sle_low
this.Control[iCurrent+29]=this.sle_totaltime
this.Control[iCurrent+30]=this.sle_high
this.Control[iCurrent+31]=this.st_2
this.Control[iCurrent+32]=this.st_3
this.Control[iCurrent+33]=this.cb_invert
this.Control[iCurrent+34]=this.cb_route
this.Control[iCurrent+35]=this.gb_4
this.Control[iCurrent+36]=this.dw_list
end on

on u_cst_eventrouting_clipboard.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_7)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.st_route)
destroy(this.cb_optimize)
destroy(this.cb_all)
destroy(this.cb_pickups)
destroy(this.cb_deliveries)
destroy(this.cb_reverseorder)
destroy(this.cb_importpickups)
destroy(this.cb_importdeliveries)
destroy(this.cb_totals)
destroy(this.st_1)
destroy(this.sle_drivetime)
destroy(this.sle_mileage)
destroy(this.st_mileage)
destroy(this.sle_low)
destroy(this.sle_totaltime)
destroy(this.sle_high)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_invert)
destroy(this.cb_route)
destroy(this.gb_4)
destroy(this.dw_list)
end on

event destructor;call super::destructor;//Extending ancestor

//If we're in Route mode, clear the request on iw_Itinerary.

w_Itin	lw_Itinerary

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN
	IF lw_Itinerary.Whats_On = lw_Itinerary.ci_RouteRequest_Clipboard THEN
		lw_Itinerary.Clear_ip ( )
	END IF
END IF
end event

event ue_getroutingids;//Override ancestor to provide a list of event ids to route based on user selection
//in this panel.

Long	lla_EventIds[]

Long	ll_Return

//If no rows are selected, select them all.
IF dw_List.GetSelectedRow ( 0 ) = 0 AND dw_List.RowCount ( ) > 0 THEN
	dw_List.SelectRow ( 0, TRUE )
END IF

IF dw_List.GetSelectedRow ( 0 ) > 0 THEN
	lla_EventIds = dw_List.Object.de_Id.Selected
END IF

ala_Ids = lla_EventIds
ll_Return = UpperBound ( ala_Ids )

RETURN ll_Return
end event

event ue_setroutemodeindicator;//Toggles the route mode display indicator on or off, according to ab_Switch.

IF NOT IsNull ( ab_Switch ) THEN
	cb_Route.Visible = NOT ab_Switch
	st_Route.Visible = ab_Switch
END IF
end event

event constructor;call super::constructor;n_cst_LicenseManager	lnv_LicenseManager
Boolean	lb_HasMegaRoute
Boolean	lb_AllowOptimize = TRUE

lb_HasMegaRoute = lnv_LicenseManager.of_HasRouteOptimizer ( ) 

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) or &
	lnv_LicenseManager.of_usepcmilerstreets() THEN
	//ok to proceed
	IF pcmm_inst = FALSE THEN
		lb_AllowOptimize = FALSE
	end if
else
		lb_AllowOptimize = FALSE
END IF

IF lb_AllowOptimize THEN
	if lnv_LicenseManager.of_getpcmilerserverid() > 0 then
		//connected
	else
		lb_AllowOptimize = FALSE
	end if
END IF


IF Not lb_AllowOptimize THEN
	cb_optimize.Enabled = FALSE
END IF

IF NOT lb_HasMegaRoute THEN  // we don't want to include this below sine it may be disabled 
									 // because of PCM
	cb_optimize.Enabled = FALSE
END IF

cb_importdeliveries.Enabled = lb_HasMegaRoute
cb_importpickups.Enabled = lb_HasMegaRoute
cb_totals.Enabled = lb_HasMegaRoute
cb_reverseorder.Enabled = lb_HasMegaRoute


end event

type cb_1 from u_cb within u_cst_eventrouting_clipboard
integer x = 1833
integer y = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Appe&nd"
end type

event clicked;Parent.Event ue_Append ( )
end event

type cb_2 from u_cb within u_cst_eventrouting_clipboard
integer x = 2231
integer y = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Repla&ce"
end type

event clicked;IF Parent.Event ue_Clear ( ) = 1 THEN
	Parent.Event ue_Append ( )
END IF
end event

type gb_7 from groupbox within u_cst_eventrouting_clipboard
integer x = 3104
integer y = 16
integer width = 393
integer height = 212
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
string text = "Totals"
end type

type gb_5 from groupbox within u_cst_eventrouting_clipboard
integer x = 2674
integer y = 476
integer width = 827
integer height = 284
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
string text = "Row Manipulation"
end type

type gb_6 from groupbox within u_cst_eventrouting_clipboard
integer x = 1792
integer y = 476
integer width = 859
integer height = 284
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
string text = "Selection"
end type

type gb_3 from groupbox within u_cst_eventrouting_clipboard
integer x = 1792
integer y = 252
integer width = 859
integer height = 208
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
string text = "Move Clipboard Selection"
end type

type gb_2 from groupbox within u_cst_eventrouting_clipboard
integer x = 2674
integer y = 16
integer width = 393
integer height = 212
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
string text = "Remove"
end type

type gb_1 from groupbox within u_cst_eventrouting_clipboard
integer x = 1792
integer y = 16
integer width = 859
integer height = 212
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
string text = "Selected Itin. Rows to Clipboard"
end type

type cb_4 from u_cb within u_cst_eventrouting_clipboard
integer x = 2715
integer y = 100
integer width = 320
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "&Selected"
end type

event clicked;Parent.Event ue_ClearSelected ( )
end event

type cb_5 from u_cb within u_cst_eventrouting_clipboard
integer x = 1833
integer y = 336
integer width = 169
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "&Up"
end type

event clicked;Parent.Event ue_MoveUp ( )
end event

type cb_6 from u_cb within u_cst_eventrouting_clipboard
integer x = 2016
integer y = 336
integer width = 169
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "D&wn"
end type

event clicked;Parent.Event ue_MoveDown ( )
end event

type cb_7 from u_cb within u_cst_eventrouting_clipboard
integer x = 2231
integer y = 336
integer width = 169
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "&Top"
end type

event clicked;PARENT.Event ue_MoveTop ( )
end event

type cb_8 from u_cb within u_cst_eventrouting_clipboard
integer x = 2414
integer y = 336
integer width = 169
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "&Btm"
end type

event clicked;PARENT.EVENT ue_MoveBottom ()
end event

type cb_9 from u_cb within u_cst_eventrouting_clipboard
integer x = 2715
integer y = 340
integer width = 366
integer taborder = 140
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

type st_route from statictext within u_cst_eventrouting_clipboard
boolean visible = false
integer x = 3122
integer y = 348
integer width = 334
integer height = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
string text = "&Route"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_optimize from commandbutton within u_cst_eventrouting_clipboard
integer x = 3113
integer y = 548
integer width = 352
integer height = 88
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Optimi&ze"
end type

event clicked;n_cst_licenseManager	lnv_LicenseManager
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_RouteOptimizer, "E" ) >= 0 THEN
	PARENT.Event ue_Optimize ( )
END IF
end event

type cb_all from commandbutton within u_cst_eventrouting_clipboard
integer x = 2231
integer y = 548
integer width = 352
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&All"
end type

event clicked;dw_List.SelectRow ( 0 , TRUE )

IF ib_CalculateTotals THEN
	PARENT.Post of_CalculateTotals ( )
END IF

//Parent.Event ue_Optimize ( )
end event

type cb_pickups from commandbutton within u_cst_eventrouting_clipboard
integer x = 1833
integer y = 548
integer width = 352
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Pickups"
end type

event clicked;dw_List.SelectRow ( 0 , FALSE )
Parent.Event ue_SelectPickups ( )
//Parent.Event ue_Optimize ( )
end event

type cb_deliveries from commandbutton within u_cst_eventrouting_clipboard
integer x = 1833
integer y = 648
integer width = 352
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Deliveries"
end type

event clicked;dw_List.SelectRow ( 0 , FALSE )
Parent.Event ue_SelectDeliveries ( )
//Parent.Event ue_Optimize ( )
end event

type cb_reverseorder from commandbutton within u_cst_eventrouting_clipboard
integer x = 3113
integer y = 652
integer width = 352
integer height = 88
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Re&v. Order"
end type

event clicked;n_cst_licenseManager	lnv_LicenseManager
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_RouteOptimizer, "E" ) >= 0 THEN
	Parent.Event ue_ReverseOrder ( )
END IF
end event

type cb_importpickups from commandbutton within u_cst_eventrouting_clipboard
integer x = 2715
integer y = 548
integer width = 366
integer height = 88
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Import PU"
end type

event clicked;n_cst_licenseManager	lnv_LicenseManager
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_RouteOptimizer, "E" ) >= 0 THEN
	Parent.Event ue_ImportPickups ( )
END IF
end event

type cb_importdeliveries from commandbutton within u_cst_eventrouting_clipboard
integer x = 2715
integer y = 652
integer width = 366
integer height = 88
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Import De&l."
end type

event clicked;n_cst_licenseManager	lnv_LicenseManager
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_RouteOptimizer, "E" ) >= 0 THEN
	Parent.Event ue_ImportDeliveries ( )
END IF
end event

type cb_totals from u_cb within u_cst_eventrouting_clipboard
integer x = 3145
integer y = 100
integer width = 320
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "S&how"
end type

event clicked;n_cst_LicenseManager	lnv_LicenseManager
IF ib_CalculateTotals THEN
	Parent.Event ue_HideTotals ( )
ELSE
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_RouteOptimizer, "E" ) >= 0 THEN
		Parent.Event ue_ShowTotals ( )
	END IF
END IF
end event

type st_1 from statictext within u_cst_eventrouting_clipboard
integer x = 571
integer y = 636
integer width = 238
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean enabled = false
string text = "Drive Time"
boolean focusrectangle = false
end type

type sle_drivetime from singlelineedit within u_cst_eventrouting_clipboard
integer x = 571
integer y = 692
integer width = 238
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_mileage from singlelineedit within u_cst_eventrouting_clipboard
integer x = 297
integer y = 692
integer width = 261
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_mileage from statictext within u_cst_eventrouting_clipboard
integer x = 297
integer y = 636
integer width = 261
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean enabled = false
string text = "Mileage"
boolean focusrectangle = false
end type

type sle_low from singlelineedit within u_cst_eventrouting_clipboard
integer x = 1289
integer y = 692
integer width = 224
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_totaltime from singlelineedit within u_cst_eventrouting_clipboard
integer x = 823
integer y = 692
integer width = 238
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_high from singlelineedit within u_cst_eventrouting_clipboard
integer x = 1527
integer y = 692
integer width = 224
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within u_cst_eventrouting_clipboard
integer x = 1280
integer y = 636
integer width = 398
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean enabled = false
string text = "Run. Low  /  High"
boolean focusrectangle = false
end type

type st_3 from statictext within u_cst_eventrouting_clipboard
integer x = 823
integer y = 636
integer width = 238
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
boolean enabled = false
string text = "Total Time"
boolean focusrectangle = false
end type

type cb_invert from commandbutton within u_cst_eventrouting_clipboard
integer x = 2231
integer y = 648
integer width = 352
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Inv&ert"
end type

event clicked;dw_list.Event ue_InvertSelection ( )


end event

type cb_route from u_cb within u_cst_eventrouting_clipboard
integer x = 3113
integer y = 340
integer taborder = 150
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

type gb_4 from groupbox within u_cst_eventrouting_clipboard
integer x = 2674
integer y = 252
integer width = 827
integer height = 208
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29409472
string text = "Route"
end type

type dw_list from u_dw_eventlist within u_cst_eventrouting_clipboard
event type integer ue_refreshfromclipboard ( )
event type integer ue_setlistasclipboard ( )
event type integer ue_eventadded ( long al_eventid )
event type integer ue_getweight ( long al_eventid )
event ue_invertselection ( )
integer x = 14
integer y = 16
integer width = 1742
integer height = 756
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ship_itin"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_refreshfromclipboard;//Returns:  1, -1

n_cst_bso_Dispatch	lnv_Dispatch
n_ds	lds_Clipboard
Long	ll_RowCount

Integer	li_Return = 1

IF li_Return = 1 THEN

	lnv_Dispatch = Parent.Event ue_GetDispatchManager ( )

	IF IsValid ( lnv_Dispatch ) THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ll_RowCount = lnv_Dispatch.of_CopyEventClipboard ( lds_Clipboard )

	IF ll_RowCount >= 0 THEN

		This.Reset ( )
		lds_Clipboard.RowsCopy ( 1, ll_RowCount, Primary!, This, 9999, Primary! )

	ELSE

		li_Return = -1

	END IF

END IF


RETURN li_Return
end event

event ue_setlistasclipboard;n_cst_bso_Dispatch	lnv_Dispatch
Long	lla_Ids[]

Integer	li_Return = 1


IF li_Return = 1 THEN

	lnv_Dispatch = Parent.Event ue_GetDispatchManager ( )

	IF IsValid ( lnv_Dispatch ) THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF This.RowCount ( ) > 0 THEN
		lla_Ids = This.Object.de_Id.Primary
	END IF

	IF lnv_Dispatch.of_SetEventClipboard ( lla_Ids ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF


RETURN li_Return
end event

event ue_eventadded;//IF ib_CalculateTotals THEN
	THIS.Event ue_GetWeight ( al_eventid )
//END IF


RETURN 1
end event

event ue_getweight;Long		ll_Find
Long		ll_EventID
Long		ll_Shipment
String	ls_Find
Int		li_Seq
Int		li_Weight
Int		li_TotalWeight
Int		li_FetchRtn
Int		li_Return
String	ls_SelCol
Long		ll_ShipmentWeight
Boolean	lb_AllAssigned
n_cst_beo_Event	lnv_Event


lnv_Event = CREATE n_cst_beo_Event

ll_EventID = al_EventID

lnv_Event.of_SetSource ( THIS )
lnv_Event.of_SetSourceID ( ll_EventID )

li_Seq = lnv_Event.of_getShipSeq ( )
ll_Shipment = lnv_Event.of_GetShipment ( )

ll_ShipmentWeight = PARENT.of_CalculateShipmentWeight ( ll_Shipment )


lb_AllAssigned = PARENT.of_AllItemsAssigned ( ll_Shipment )

IF lnv_Event.of_IsPickupGroup ( ) THEN
	li_Totalweight	= PARENT.of_GetPickupWeights ( ll_EventID )
ELSE
	li_Totalweight	= 	PARENT.of_GetDeliverWeights ( ll_EventID ) * -1
END IF

 
ll_Find = THIS.Find ( "de_id = " + String ( ll_EventID )  , 1 , 999 ) 
IF ll_Find > 0 THEN
	THIS.Object.cntn4_length[ll_Find] = li_TotalWeight
	THIS.Object.cntn2_length[ll_Find] = ll_ShipmentWeight
	if Not lb_AllAssigned then
		THIS.Object.cntn2_ref[ll_Find] = "1"
	ELSE
		THIS.Object.cntn2_ref[ll_Find] = ""
	END IF
		
END IF

DESTROY ( lnv_Event ) 
//MessageBox( "Total Weight" , li_TotalWeight )

RETURN 1

end event

event ue_invertselection;Long	ll_RowCount 
Long 	i

THIS.SetRedraw ( FALSE )

ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount 
	THIS.SelectRow ( i , Not THIS.IsSelected ( i ) )
NEXT


THIS.SetRedraw ( TRUE )

IF ib_CalculateTotals THEN
	PARENT.of_CalculateTotals ( )
END IF
end event

event clicked;//override ancestor
gf_multiselect(this, row)
THIS.SetRow ( row )

IF Row = 0 THEN
	THIS.SelectRow ( 0 , FALSE )
END IF

IF ib_CalculateTotals THEN
	PARENT.Post of_CalculateTotals ( )
END IF


end event

event constructor;call super::constructor;//override ancestor
//Not going to show this for now.  If we do, we'll need more room, and we'll
//need to refresh the clipboard display after routing.
//This.modify("st_routed.visible = '1' comp_routed.visible = '1'")
//This.modify("st_confirmed.visible = '1' comp_confirmed.visible = '1'")

This.modify("st_miles.visible = '0' leg_miles.visible = '0'")
This.modify("st_time.visible = '0' comp_leg_time.visible = '0'")
This.modify("st_arrive.visible = '0' comp_arr.visible = '0'")
This.modify("st_depart.visible = '0' comp_dep.visible = '0'")
This.modify("st_tz.visible = '0' co_tz.visible = '0'")

This.modify("comp_tz_adj.visible = '0'" )
This.modify("cc_depstr.visible = '0'")
This.modify("cc_arrstr.visible = '0'")
This.modify("leg_miles.visible = '0'")
This.modify("leg_mins.visible = '0' ")
This.modify("interch.visible = '0'")

This.modify("de_event_type.protect = '1' ")
This.modify("co_name.protect = '1' ")


//THIS.hscrollbar = FALSE
//THIS.HSplitScroll= TRUE
THIS.SetRedraw ( TRUE )

//This was in the open of the window...  We'll see how it does here.
This.Event Post ue_RefreshFromClipboard ( )

n_cst_LicenseManager	lnv_LicenseManager
Integer	li_BaseTimeZone
//n_cst_Dws		lnv_Dws
n_cst_Events	lnv_Events

//Going to use RowFocusIndicator instead
//lnv_Dws.of_CreateHighlight ( This )

//li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )
//This.Modify ( "comp_tz_home.Expression = '" + String ( li_BaseTimeZone ) + "'" )
//
//This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
//	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
//
This.of_SetRowManager ( TRUE )
This.of_SetRowSelect ( TRUE )
This.inv_RowSelect.of_SetStyle ( 1 )
This.SetRowFocusIndicator ( FocusRect! )

This.of_SetInsertable ( FALSE )
end event

event rbuttondown;any 		laa_parm_values[]
String 	lsa_parm_labels[]
// over ride
THIS.SelectRow ( row , NOT this.IsSelected ( Row ) )

//IF Row > 0 THEN
//	THIS.SetRow ( ROW )
//END IF
//

CHOOSE CASE dwo.name
		
	CASE "cntn2_length" 
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "&GoTo Shipment"
			
		IF UpperBound( laa_parm_values ) > 0 THEN
			CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
					
				CASE "GOTO SHIPMENT"
					Parent.Event ue_GotoShipment ( row )
					
				CASE "LOAD TRACTOR ITINERARY"
					
			END CHOOSE
		END IF
END CHOOSE

end event

event rowfocuschanged;//override ancestor
IF ib_CalculateTotals THEN
	//PARENT.Post Event ue_RowClicked ( )
	PARENT.Post of_CalculateTotals ( )
END IF


end event

event ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatchManager ( ) 
end event

