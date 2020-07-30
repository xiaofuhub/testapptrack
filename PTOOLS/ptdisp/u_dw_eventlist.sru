$PBExportHeader$u_dw_eventlist.sru
forward
global type u_dw_eventlist from u_dw_eventdetail
end type
end forward

global type u_dw_eventlist from u_dw_eventdetail
integer width = 3355
integer height = 428
string dataobject = "d_shipmentevents"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
event ue_mousemove pbm_mousemove
event ue_showeventmenu ( long al_row )
event ue_scrolltofirstselectedevent ( )
event type integer ue_addevent ( long al_row,  string as_type )
event type integer ue_showedilist ( long al_event )
event type integer ue_validateevents ( )
event ue_deleteevent ( )
event type integer ue_addchassissplit ( long al_row )
event ue_actioneventadded ( )
event type integer ue_addyardmove ( long al_row )
event type integer ue_preaddchassissplit ( long al_row )
event type integer ue_addcrossdock ( long al_row )
event ue_keydown ( )
event ue_showeventselections ( long al_row )
event type long ue_getxpos ( )
event type long ue_getypos ( )
event ue_scrollleft ( )
event ue_jumptoitinerary ( long al_row )
event ue_refreshshipment ( )
event type integer ue_setrow ( long al_row )
event type integer ue_continueroutingfornewevent ( long al_targetrow )
event type integer ue_addstreetturn ( long al_row )
event ue_addalert ( long al_row )
event type long ue_addbobtailset ( long al_row )
event ue_yardstorageadded ( )
end type
global u_dw_eventlist u_dw_eventlist

type variables
boolean	ib_YardMove
Long	il_YardRow

Private:
boolean	ib_NeedHighlight
String	is_NoteContext

n_cst_beo_Event	inv_Event
end variables

forward prototypes
private function integer of_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg)
public function integer of_markasnonroutable (long al_row)
public function integer of_switchroutablestatus (long al_row)
public function integer of_allowedit (boolean ab_value)
public function integer of_validateeventchange (long al_row)
public function integer of_makecontextmodifications ()
public subroutine of_scrollleft ()
public subroutine of_scrollright ()
public function integer of_switchhideonbillstatus (long al_Row)
protected function integer of_bobtailadded (long al_row)
end prototypes

event ue_showeventmenu(long al_row);// RDT 5-26-03 Change setItem to use beo_event
any 		laa_parm_values[]
String 	lsa_parm_labels[]
String	ls_TempType
String	ls_AddType
String	ls_PopRtn
String	ls_MenuText
Long		ll_EventID
Long		ll_ShipmentID
Long		ll_return = 1
Long		ll_TempEventID
Long		ll_SelectedRow
Long		lla_SelectedRows[]
Long		lla_NewID[]
Long		ll_NewID
Long		ll_SiteID
Long		ll_ndx, &
			ll_Selectedcount
Boolean	lb_AlterItins

Int	li_Return

S_Parm					lstr_Parm
n_cst_Msg				lnv_Msg
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_LicenseManager	lnv_License
n_cst_Beo_Event		lnv_Event
n_cst_Beo_Shipment	lnv_Shipment
n_cst_Privileges_Events	lnv_privs
ll_SelectedRow = 0 

lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF NOT ( IsValid( lnv_Dispatch ) AND isValid ( lnv_Shipment )  ) THEN 
	RETURN 															//////////     EARLY RETURN !!!!!!! \\\\\\\
END IF
lb_AlterItins = lnv_Privs.of_Allowalteritins( )

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
THIS.SetRedraw ( FALSE )

lnv_Event = CREATE n_cst_beo_Event 
lnv_Event.of_SetShipment( This.Event ue_GetShipment() ) //RDT 8-27-03
IF lb_AlterItins THEN
	THIS.of_ConstructSwitchingOptions ( al_Row , lnv_Msg )
END IF

IF lnv_Msg.of_Get_Parm ( "LABELS" , lstr_Parm ) <> 0 THEN
	lsa_parm_labels = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "VALUES" , lstr_Parm ) <> 0 THEN
	laa_parm_values = lstr_Parm.ia_Value
END IF

lnv_Event.of_SetSource ( THIS )
lnv_Event.of_setSourceRow ( al_Row )

ll_EventID = lnv_Event.of_GetID () 

IF isValid ( lnv_Dispatch ) THEN
	IF lnv_License.of_HasEDI214License ( ) THEN
	
		if lnv_Dispatch.of_checkEDIupdate(ll_EventID) = 1 then
			
			lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
			laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
			
			lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
			laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "New EDI Message"
		
			lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
			laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "EDI Message List"
		END IF
	END IF
else
	ll_return = -1
END IF

IF ll_Return <> -1 THEN
	IF lnv_Shipment.of_AllowEditBill ( ) AND lb_AlterItins THEN
		IF NOT lnv_Shipment.of_isnonrouted( ) THEN
			IF THIS.object.disp_events_routable [ al_row ] = 'F' THEN
				ls_MenuText = "Mark as Routable"
			ELSE
				ls_MenuText = "Mark as Non-Routable"
			END IF
			IF UpperBound (lsa_parm_labels ) > 0 THEN 
				lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
				laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
			END IF
			
			lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
			laa_parm_values[UpperBound ( laa_parm_values ) + 1] = ls_MenuText
		END IF
		
		IF NOT lnv_Event.of_GetHideOnBill ( ) THEN
			ls_MenuText = "Hide on Bill"
		ELSE
			ls_MenuText = "Show on Bill"
		END IF
				
		lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = ls_MenuText
		
		lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Delete Event"
		
		
		
	END IF
	

	IF UpperBound (lsa_parm_labels ) > 0 THEN 
		lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
	END IF
	
	
	lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Jump To Itinerary"
	

	lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Add &Alert"
		
END IF

IF ll_Return <> -1 THEN
	ls_PopRtn = f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
END IF


if ll_return = 1 AND Len ( ls_PopRtn ) > 0 then
	
	// we need to set the row to one all the time since some later processing may remove
	// rows and we will get a GPF if the focus is on the last row when processing happens
	
	IF THIS.RowCount ( ) > 0 THEN
		THIS.SetRow ( 1 ) 
	END IF
		
	DO 
		
		ll_SelectedRow = THIS.GetSelectedRow ( ll_SelectedRow )
		IF ll_SelectedRow > 0 THEN
			lla_SelectedRows [ UpperBound ( lla_SelectedRows ) + 1 ] = ll_SelectedRow
		END IF
		
	LOOP WHILE ll_SelectedRow > 0
	lnv_Event.of_setSourceRow ( al_Row )									// RDT 5-26-03 
	IF UpperBound( laa_parm_values ) > 0 THEN
		CHOOSE CASE ls_PopRtn
				
			CASE "PICKUP"
				//THIS.SetItem ( al_Row , "de_event_type" , 'P' )			// RDT 5-26-03 
				lnv_Event.of_SetType ( "P") 										// RDT 5-26-03 
				THIS.post SetColumn ( "co_Name" ) 
				THIS.of_pickupAdded ( al_Row ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "DELIVER"
				//THIS.SetItem ( al_Row , "de_event_type" , 'D' )			// RDT 5-26-03 
				lnv_Event.of_SetType ( "D" ) 										// RDT 5-26-03 
				THIS.post SetColumn ( "co_Name" ) 
				THIS.of_DeliverAdded ( al_Row ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "HOOK"
				//THIS.SetItem ( al_Row , "de_event_type" , 'H' )			// RDT 5-26-03 
				lnv_Event.of_SetType ( "H" ) 										// RDT 5-26-03 
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "DROP"
				//THIS.SetItem ( al_Row , "de_event_type" , 'R' )			// RDT 5-26-03 
				lnv_Event.of_SetType ( "R" ) 										// RDT 5-26-03 
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "MOUNT"
				//THIS.SetItem ( al_Row , "de_event_type" , 'M' )			// RDT 5-26-03 
				lnv_Event.of_SetType ( "M" ) 										// RDT 5-26-03 
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "DISMOUNT"				
				//THIS.SetItem ( al_Row , "de_event_type" , 'N' )			// RDT 5-26-03 
				lnv_Event.of_SetType ( "N" ) 										// RDT 5-26-03 
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "YARD MOVE"
				THIS.Event ue_AddYardMove ( al_Row )					
			CASE "X-DOCK" // CrosDock
				THIS.Event ue_AddCrossDock ( al_Row )							
			CASE "CHASSIS SPLIT" // chassis split
				THIS.Event ue_PreAddChassisSplit ( al_Row ) 
			
			CASE "INTERCHANGE" 
				THIS.Event ue_AddStreetTurn ( al_Row ) 
				
			CASE "MARK AS ROUTABLE", "MARK AS NON-ROUTABLE"
				ll_SelectedCount = upperbound(lla_SelectedRows)
				if ll_SelectedCount > 0 then
					for ll_ndx = 1 to ll_Selectedcount
						THIS.of_SwitchRoutableStatus ( lla_SelectedRows[ll_ndx] ) 
					next
				else
					THIS.of_SwitchRoutableStatus ( al_row ) 
				end if 
				
			CASE "HIDE ON BILL" , "SHOW ON BILL"
				ll_SelectedCount = upperbound(lla_SelectedRows)
				if ll_SelectedCount > 0 then
					for ll_ndx = 1 to ll_Selectedcount
						THIS.of_SwitchHideOnBillStatus ( lla_SelectedRows[ll_ndx] )
					next
				else
					THIS.of_SwitchHideOnBillStatus ( al_row ) 
				end if
			
			CASE "DELETE EVENT"
				THIS.SetRow ( al_Row )
				THIS.Event ue_DeleteEvent ( )
			
			CASE "NEW EDI MESSAGE"
				lnv_Dispatch.of_CreateNewEdiMessage ( ll_EventID )
				
			CASE "EDI MESSAGE LIST"
				THIS.Event ue_ShowEdiList ( ll_eventID )
				
			CASE "JUMP TO ITINERARY"
				THIS.Post Event ue_JumpToItinerary ( al_row )
				
			CASE "ADD ALERT"
				THIS.Post Event ue_AddAlert ( al_Row )
					
			CASE "CONVERT TO DISMOUNT" ,"CONVERT TO DISMOUNT AND MOUNT"
				ls_TempType =  THIS.GetItemString ( al_Row , "de_event_type" ) 
				IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Dismount ) = 1 THEN
					IF ls_TempType = gc_Dispatch.cs_EventType_Deliver AND &
						ls_PopRtn = "CONVERT TO DISMOUNT AND MOUNT" THEN
						// add a Mount After the Dismount event
						ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Mount , al_Row + 1 , lnv_Dispatch , ll_NewId , ll_SiteID )	
						li_Return = lnv_Dispatch.of_DuplicateRouting ( ll_EventID , {ll_NewId}, gc_dispatch.ci_InsertionStyle_After )						
						THIS.post event ue_RefreshShipment ( )
					END IF
				END IF
				
				
			CASE "CONVERT TO DROP" ,"CONVERT TO DROP AND HOOK"
				ls_TempType =  THIS.GetItemString ( al_Row , "de_event_type" ) 
				IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Drop ) = 1 THEN
					IF ls_TempType = gc_Dispatch.cs_EventType_Deliver AND &
						ls_PopRtn = "CONVERT TO DROP AND HOOK" THEN
						// add a Hook After the DROP event
						ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Hook , al_Row + 1 , lnv_Dispatch , ll_NewId , ll_SiteID )
						li_Return = lnv_Dispatch.of_DuplicateRouting ( ll_EventID , {ll_NewId}, gc_dispatch.ci_InsertionStyle_After )												
						THIS.post event ue_RefreshShipment ( )
					END IF
				END IF
						
			CASE "CONVERT TO MOUNT" ,"CONVERT TO MOUNT AND DISMOUNT"
				ls_TempType =  THIS.GetItemString ( al_Row , "de_event_type" ) 
				IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Mount ) = 1 THEN
					IF ls_TempType = gc_Dispatch.cs_EventType_PickUp AND &
						ls_PopRtn = "CONVERT TO MOUNT AND DISMOUNT" THEN
						// add a Dismount before the HOOK event
						ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Dismount , al_Row , lnv_Dispatch , ll_NewId , ll_SiteID  )
						li_Return = lnv_Dispatch.of_DuplicateRouting ( ll_EventID , {ll_NewId}, gc_dispatch.ci_InsertionStyle_before )												
						THIS.post event ue_RefreshShipment ( )
					END IF
				END IF
				
				
			CASE "CONVERT TO HOOK" , "CONVERT TO HOOK AND DROP"
				ls_TempType =  THIS.GetItemString ( al_Row , "de_event_type" ) 
				IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Hook ) = 1 THEN
					IF ls_TempType = gc_Dispatch.cs_EventType_PickUp  AND &
						ls_PopRtn = "CONVERT TO HOOK AND DROP" THEN
						// add a DROP before the HOOK event
						ll_SiteID = THIS.GetItemNumber ( al_Row , "de_Site" ) 
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_DROP , al_Row , lnv_Dispatch , ll_NewId , ll_SiteID )
						li_Return = lnv_Dispatch.of_DuplicateRouting ( ll_EventID , {ll_NewId}, gc_dispatch.ci_InsertionStyle_before )																		
						THIS.post event ue_RefreshShipment ( )
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
						//	THIS.of_pickupAdded ( al_Row ) 	
							lnv_Dispatch.of_Remove ( {ll_TempEventID} )  // remove the routing b/f deletion
							IF IsValid ( lnv_Shipment ) THEN												
								lnv_Shipment.of_RemoveEvents ( {ll_TempEventID} , lnv_Dispatch )
							END IF		
							
						END IF
					END IF
				ELSE
					lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_PickUp )
					// we are not going to call this now b.c. it adds the stopoff item which is not right.
					//THIS.of_pickupAdded ( al_Row ) 
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
						ELSE
							lnv_Event.of_SetSourceRow ( lla_SelectedRows[2] )
							IF lnv_Event.of_IsPickupGroup ( ) THEN
								ll_EventID = lnv_Event.of_GetID ( )
								ls_TempType = THIS.GetItemString ( lla_selectedRows [1] , "de_event_type" )
								ll_TempEventID = THIS.GetItemNumber ( lla_selectedRows [1] , "de_ID" )
							END IF
						END IF
					
						
						IF lnv_Dispatch.of_SwitchToDeliver ( ll_EventID  ) = 1 THEN	
							//THIS.of_DeliverAdded ( al_Row ) 
							lnv_Dispatch.of_Remove ( {ll_TempEventID} )  // remove the routing b/f deletion
							IF IsValid ( lnv_Shipment ) THEN				
								lnv_Shipment.of_RemoveEvents ( {ll_TempEventID} , lnv_Dispatch )
							END IF		
							
						END IF
					END IF
				ELSE
					lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Deliver )
					// we are not going to call this now b.c. it adds the stopoff item which is not right.
					//THIS.of_DeliverAdded ( al_Row ) 
				END IF
			
			CASE "ADD YARD STORAGE"
				THIS.SetRow ( al_row )
				IF lnv_Shipment.of_AddYardstorageitem( THIS.of_getevent( ) ) = 1 THEN
					THIS.event ue_yardstorageadded( )
				END IF
				
		END CHOOSE 

	END IF
end if

IF ll_Return = 1 THEN
	THIS.Event ue_Refresh ( )
END IF

THIS.SelectRow ( 0, FALSE )
THIS.Post SetRedraw ( TRUE )

DESTROY ( lnv_Event ) 

end event

event ue_showedilist;n_cst_bso_Dispatch lnv_Dispatch

lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
IF isValid ( lnv_Dispatch ) THEN
	lnv_Dispatch.of_ViewEDIList ( al_event )
END IF

RETURN 1
end event

event ue_validateevents;Long	ll_RowCount
Long	ll_i
int	li_Return = 1
String	ls_EventType

ll_RowCount = THIS.RowCount ( )

FOR ll_i = 1 TO ll_RowCount 
	ls_EventType = THIS.GetItemString ( ll_i , "de_event_type" ) 
	IF IsNull ( ls_EventType ) OR ls_EventType = "" THEN
		li_Return = -1
		MessageBox ( "Event Types" , "Please select an event type for each event." )
		Exit
	END IF
NEXT 

RETURN li_Return
end event

event ue_deleteevent();
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_shipment	lnv_Shipment
Long	ll_SelectedRow
Long	lla_Ids[]
Long 	i
Boolean	lb_Imported
Boolean	lb_Continue = TRUE
Boolean	lb_Routed


//RDT 8-27-03 -START
Long	ll_Site, &
		lla_AllSiteIds[], &
		ll_EventCount, &
		ll_EventId, &
		ll_FindId
		
n_cst_beo_Event lnva_Event[]		
n_cst_AnyArraySrv lnv_ArraySrv
//RDT 8-27-03 - End

n_cst_Privileges_Events	lnv_Privs
IF NOT lnv_Privs.of_Allowalteritins( ) THEN 
	MessageBox ( "Delete Event" , "You are not authorized to make this change." )
	RETURN 
END IF


lnv_Dispatch = This.Event ue_GetDispatchManager ()
lnv_Shipment = THIS.Event ue_GetShipment ( ) 

IF isValid ( lnv_Shipment ) AND isValid ( lnv_Dispatch ) THEN
	
	ll_SelectedRow = 0 
	
	DO 
		
		ll_SelectedRow = THIS.GetSelectedRow ( ll_SelectedRow )
		IF ll_SelectedRow > 0 THEN
			lla_Ids [ UpperBound ( lla_IDs ) + 1 ] =  THIS.object.de_id[ll_SelectedRow]
		END IF
		
	LOOP WHILE ll_SelectedRow > 0
	
	IF UpperBound ( lla_IDs ) = 0 THEN  // try for the selected row
		IF THIS.GEtRow () > 0 THEN
			lla_IDs [ 1 ] = THIS.object.de_id[ THIS.GEtRow () ]
			THIS.SelectRow ( THIS.GEtRow () , TRUE )
		END IF
	END IF
	
	//Windows GPF if focus is on last row and it is deleted (if only one row, it's ok)
	IF  THIS.RowCount ( ) > 0 THEN
		THIS.setrow(1)
	END IF
	
	
	IF UpperBound ( lla_Ids ) > 0 THEN
		IF messagebox("Delete Event", "Okay to delete the selected event(s)?", question!, okcancel!, 2) = 1 then

			// RDT 8-27-03 -Start
			// get SITE id's from events marked for delete
			
			ll_EventCount = lnv_shipment.of_GetEventList(lnva_Event[])
			For i = 1 to ll_EventCount 
				ll_EventId = lnva_Event[i].of_GetId() 
				ll_FindID = lnv_ArraySrv.of_findlong ( lla_Ids[], ll_EventId, 1, ll_EventCount)
				If IsNull ( ll_FindId ) then 
					// skip it
				else // it is found so Check for EDI Import as well as Get the site for notification reasons
					IF lnva_Event[i].of_Getimportreference( ) >= 0 THEN
						lb_Imported = TRUE
					END IF
					// get site id
					ll_Site = lnva_Event[i].of_getsite ( )
					/// add to array
					lnv_ArraySrv.of_appendlong ( lla_AllSiteIds, {ll_Site} )
				End if
				IF lnva_Event[i].of_IsRouted( ) THEN
					lb_Routed = TRUE
				END IF
			Next
			
					
			lnv_ArraySrv.of_Destroy(lnva_Event[])
			
			
			
			// RDT 8-27-03 -End
			
			IF lb_Imported AND lb_Continue THEN
				IF MessageBox ( "Deleting Imported Events" , "One or more of the events you have selected to delete originated from a file import. This value is used to report status information. It is recomended that the events not be deleted.~r~nDo you want to DELETE the events anyway?" , QUESTION!, YESNO!, 2 ) <> 1 THEN
					lb_Continue = FALSE
				END IF
			END IF
			
			IF lb_Continue THEN			
				lnv_Shipment.of_RemoveEvents ( lla_IDs , lnv_Dispatch )				
				lnv_Shipment.of_RemoveDeletedEventSite( lla_AllSiteIds ) // RDT 8-27-03			
				THIS.SelectRow ( 0 , FALSE )
			END IF
		END IF
	END IF
END IF

RETURN

end event

event ue_addchassissplit;Long						lla_NewIds []
Long						ll_insertionPoint
Long						ll_SiteID 
Long						ll_RowCount 
Long						ll_SetRow
String					ls_WhichOne
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_msg				lnv_Msg
S_Parm					lstr_Parm

lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

ll_RowCount = THIS.RowCount ( )

lstr_Parm.is_Label = "ROWCOUNT"
lstr_Parm.ia_Value = ll_RowCount
lnv_msg.of_Add_Parm ( lstr_Parm )

IF al_row = ll_RowCount THEN
	ls_WhichOne = "BACK"
	
	
	ll_InsertionPoint = ll_RowCount + 1
	
	lstr_Parm.is_Label = "SPLITFRONT"
	lstr_Parm.ia_Value = FALSE
	lnv_msg.of_Add_Parm ( lstr_Parm )


	lstr_Parm.is_Label = "SPLITBACK"
	lstr_Parm.ia_Value = TRUE
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
ELSE
	
	ls_WhichOne = "FRONT"
	ll_InsertionPoint = al_Row
	
	lstr_Parm.is_Label = "SPLITFRONT"
	lstr_Parm.ia_Value = TRUE
	lnv_msg.of_Add_Parm ( lstr_Parm )


	lstr_Parm.is_Label = "SPLITBACK"
	lstr_Parm.ia_Value = FALSE
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
END IF

IF isValid ( lnv_Dispatch ) AND isValid ( lnv_Shipment ) THEN

	 IF lnv_Shipment.of_AddSiteMove ( ll_SiteID , ll_insertionPoint , lnv_Dispatch , lla_NewIds, lnv_msg ) = 1 THEN
		//
		THIS.Post SetRow ( ll_InsertionPoint ) 
		THIS.Post SetColumn ( "co_name" )
		THIS.Post SetFocus ( )
		//
		
		IF ls_WhichOne = "FRONT" THEN
			lnv_Shipment.of_AddFrontChassisSplitItem ( lnv_Dispatch ) 
		ELSE
			lnv_Shipment.of_AddBackChassisSplitItem ( lnv_Dispatch ) 			
		END IF
		
		Any	la_Value 	
		n_Cst_Settings	lnv_Settings	
		lnv_Settings.of_GetSetting ( 86 , la_Value )
		IF String ( la_Value )  =  "YES!" THEN
			THIS.Post Event ue_AddEventNote (  al_row , "CHASSIS") 
		END IF
		
		
		
	 END IF
	 
END IF

RETURN 1

end event

event type integer ue_addyardmove(long al_row);// RDT 5-26-03 Changed to use beo_Event
Long		ll_Return 
Long		ll_RowCount 
Long		lla_NewIds[]
Boolean	lb_Front
Boolean	lb_Back
Boolean	lb_Continue = TRUE
String	ls_message
Long		ll_Site
Long		ll_EventID
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

n_cst_beo_shipment	lnv_Shipment
n_Cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event  		lnv_Event			

lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Event = Create n_cst_beo_Event  	
SetPointer ( Hourglass! )



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


IF IsValid ( lnv_Dispatch ) THEN
	lnv_Event.of_SetSource( lnv_Dispatch.of_geteventcache( ) ) 			
END IF

lnv_Event.of_SetShipment( lnv_Shipment ) 
lnv_Event.of_SetAllowFilterSet ( TRUE ) 

n_cst_setting_poolsyards	lnv_Yards
lnv_Yards = CREATE n_cst_setting_poolsyards
IF Len ( lnv_Yards.of_GetValue ( ) ) > 0 THEN 

	CHOOSE CASE Messagebox ( "Yard Move" , "Do you want to see a list of yards and pools?" , QUESTION! , YESNOCANCEL!,1 ) 
	
		CASE 1 // show the list
			open ( w_YardsandPools ) 
			IF isValid ( Message.PowerObjectParm ) THEN
				lnv_Msg = Message.PowerObjectParm
				IF lnv_Msg.of_Get_Parm ( "COID" , lstr_Parm ) <> 0  THEN
					ll_Site = lstr_Parm.ia_Value 
				END IF
			END IF
			
			
		CASE 2 // no
			
		CASE 3 // CANCEL
			lb_Continue = FALSE
		
	END CHOOSE
END IF

DESTROY ( lnv_Yards)

IF lb_Continue THEN
	IF lnv_Shipment.of_AddYardMove(ll_Site, al_row,lnv_Dispatch, lla_NewIds[] , THIS.GetItemnumber( al_Row, "de_id" )) = 1 THEN
		
		THIS.Event ue_ActionEventAdded ( )	
		THIS.Post Event ue_SetRow ( al_row ) 
		IF ll_Site > 0 THEN
			ib_YardMove = TRUE
			is_noteContext = "YARD"
			il_YArdRow = al_row 
			THIS.Post Event ue_ChangeSite (al_row , ll_Site )
		ELSE
			THIS.Post SetColumn ( "co_name" )
			THIS.Post SetFocus ( )
			ib_YardMove = TRUE
			is_noteContext = "YARD"
			il_YArdRow = al_row
		END IF
		ll_Return = 1
		
		
		IF al_Row > 1 THEN
			lla_NewIds [ UpperBound ( lla_NewIds ) + 1 ] = lnv_Event.of_GetID ( )
	   	lnv_Dispatch.of_DuplicateRouting ( THIS.GetItemNumber ( al_row - 1  , "de_id" )  , lla_NewIds , gc_dispatch.ci_InsertionStyle_After )												
			THIS.post event ue_RefreshShipment ( )			
		END IF				
		
	END IF
ELSE
	ll_Return = -1
END IF

Destroy  ( lnv_Event ) 

RETURN ll_Return 
end event

event type integer ue_preaddchassissplit(long al_row);Long		ll_Return = -1
Long		ll_RowCount 
Long		lla_NewIds[]
Boolean	lb_Front
Boolean	lb_Back
Boolean	lb_Continue = TRUE
String	ls_message

n_cst_beo_shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )
ll_RowCount = THIS.RowCount ( )



CHOOSE CASE al_row
		
	case 1 
		lb_Front = TRUE
		lb_Back = FALSE
	CASE ll_RowCount 
		lb_Front = FALSE
		lb_Back = TRUE
	CASE ELSE 
		lb_Continue = FALSE
		ls_Message =  "The addition of a chassis split is not valid here."
END CHOOSE 

IF lb_Continue THEN
	lb_Continue = lnv_Shipment.of_AllowChassisMove ( lb_Front , lb_Back )	
	ls_Message = "The existing event structure does not permit the addition of a chassis split."
END IF

IF lb_Continue THEN
	IF MessageBox ( "Add Chassis Split" , "Are you sure you want to add a chassis split here?" , Question! , YESNO! , 1 ) = 1 THEN
		THIS.Event ue_AddChassisSplit ( al_row ) 
		THIS.Event ue_ActionEventAdded ( )
		ll_Return = 1
	ELSE 
		ll_Return = -1
	END IF
		
ELSE 
	MessageBox ( "Chassis Split" , ls_Message )
	ll_Return = -1
END IF

RETURN ll_Return
end event

event type integer ue_addcrossdock(long al_row);// RDT 5-26-03 Changed to use beo_Event

Long		ll_Return 
Long		ll_RowCount 
Long		lla_NewIds[]
Boolean	lb_Front
Boolean	lb_Back
Boolean	lb_Continue = TRUE
String	ls_message

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
lnv_Event.of_SetShipment( lnv_Shipment ) 

n_cst_CrossDock	lnv_CrossDock
lnv_CrossDock = CREATE n_cst_CrossDock



Long	ll_DockID

ll_DockID = lnv_CrossDock.of_Getselecteddock( )


IF ll_DockID >= 0 THEN
	// I didn't send in the deliver b.c it would create a stop off item for the deliver
	// which would not be right in the case of a x-dock
	IF lnv_Shipment.of_AddEvents ( {''} , al_row   , lnv_Dispatch , lla_NewIds[] ) = 1 THEN

		//THIS.event ue_RefreshShipment ( )		
		THIS.Event ue_ActionEventAdded ( )		
	//	lnv_Dispatch.of_FilterShipment ( lnv_Shipment.of_GetID () )
		
		lnv_Event.of_SetSourceID ( lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row ,"de_id" ) )															
		lnv_Event.of_SetType( gc_Dispatch.cs_Eventtype_Deliver  )	
		
		lnv_Event.of_SetSourceID ( lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row + 1 ,"de_id" ) )
		lnv_Event.of_SetType( gc_Dispatch.cs_Eventtype_Pickup  )	

		IF al_Row > 1 THEN
			lla_NewIds [ UpperBound ( lla_NewIds ) + 1 ] = lnv_Event.of_GetID ( )
	   	lnv_Dispatch.of_DuplicateRouting ( lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row - 1 ,"de_id" )  ,lla_NewIds, gc_dispatch.ci_InsertionStyle_After )												
			THIS.Post event ue_RefreshShipment ( )			
		END IF

		THIS.SetFocus ( )
		THIS.Post Event ue_SetRow ( al_row ) 
		THIS.Post SetColumn ( "co_name" )
		THIS.Post SetFocus ( )
		ib_YardMove = TRUE
		is_NoteContext = "CROSSDOCK"
		il_YArdRow = al_row
		ll_Return = 1
		IF ll_DockID > 0 THEN
			THIS.Event ue_ChangeSite (al_row , ll_DockID )
		END IF
		
		
	END IF
ELSE
	ll_Return = -1
END IF

Destroy ( lnv_CrossDock )
Destroy ( lnv_Event )  

THIS.SetRedraw ( TRUE ) 
RETURN ll_Return
end event

event ue_showeventselections(long al_row);// RDT 5-26-03 Changed to use n_cst_beo_event
any 		laa_ParmValue[]
String 	lsa_ParmLabel[]
String	ls_PopRtn
Long		ll_return = 1
Long		ll_NewID
Long		ll_SiteID
Long		ll_EventID
Boolean	lb_ContiueRouting


n_cst_beo_Event lnv_event 					// RDT 5-26-03 
lnv_event = Create n_cst_beo_Event		// RDT 5-26-03 
n_cst_beo_Shipment	lnv_Shipment
//lnv_Event.of_SetSource ( THIS ) 			// RDT 5-26-03

n_cst_Bso_Dispatch	lnv_Dispatch
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
THIS.SetRedraw ( FALSE )

IF ProfileString ( gnv_App.of_getappinifile( ) , "MISCEVENT","ALLOW", "NO" ) = "YES" THEN
	lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
	laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Misc"
END IF

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Pickup"

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Deliver"

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Hook"

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "D&rop"

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Mount"

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Dismou&nt"

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Yard Move"

lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&X-Dock"

if al_row = 1 or al_row = THIS.RowCount ( )  THEN
	lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
	laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Chassis Split"
END IF

IF ProfileString ( gnv_App.of_getappinifile( ) , "BOBTAILEVENT","ALLOW", "NO" ) = "YES" THEN
	lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
	laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Bobtail"
END IF


IF ll_Return <> -1 THEN
	ls_PopRtn = f_Pop_Standard ( lsa_ParmLabel, laa_ParmValue )
END IF

if ll_return = 1 AND Len ( ls_PopRtn ) > 0 then
	
	// we need to set the row to one all the time since some later processing may remove
	// rows and we will get a GPF if the focus is on the last row when processing happens
	
	IF THIS.RowCount ( ) > 0 THEN
		THIS.SetRow ( 1 ) 
	END IF
	
	
	
	IF UpperBound( laa_ParmValue ) > 0 THEN
		CHOOSE CASE ls_PopRtn
				
			CASE "PICKUP"
				//THIS.SetItem ( al_Row , "de_event_type" , 'P' ) 	// RDT 5-26-03
				lnv_event.of_SetType ( "P" ) 								// RDT 5-26-03	
				lb_ContiueRouting = TRUE				
				THIS.post SetColumn ( "co_Name" ) 
				THIS.of_pickupAdded ( al_Row ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "DELIVER"
				//THIS.SetItem ( al_Row , "de_event_type" , 'D' ) 	// RDT 5-26-03
				lnv_event.of_SetType ( "D" ) 								// RDT 5-26-03
				lb_ContiueRouting = TRUE				
				THIS.post SetColumn ( "co_Name" ) 
				THIS.of_DeliverAdded ( al_Row ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "HOOK"
				//THIS.SetItem ( al_Row , "de_event_type" , 'H' ) 	// RDT 5-26-03
				lnv_event.of_SetType ( "H" ) 								// RDT 5-26-03				
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "DROP"
				//THIS.SetItem ( al_Row , "de_event_type" , 'R' ) 	// RDT 5-26-03
				lnv_event.of_SetType ( "R" ) 								// RDT 5-26-03				
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "MOUNT"
				//THIS.SetItem ( al_Row , "de_event_type" , 'M' ) 	// RDT 5-26-03
				lnv_event.of_SetType ( "M" ) 								// RDT 5-26-03								
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "MISC"
				//THIS.SetItem ( al_Row , "de_event_type" , 'M' ) 	// RDT 5-26-03
				lnv_event.of_SetType ( "X" ) 								// RDT 5-26-03								
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "DISMOUNT"				
				//THIS.SetItem ( al_Row , "de_event_type" , 'N' ) 	// RDT 5-26-03
				lnv_event.of_SetType ( "N" ) 								// RDT 5-26-03				
				THIS.post SetColumn ( "co_Name" ) 
				THIS.Post SetRow ( al_Row ) 
				
			CASE "YARD MOVE"
				THIS.Event ue_AddYardMove ( al_Row )					
			CASE "X-DOCK" // CrosDock				
				THIS.Event ue_AddCrossDock ( al_Row )							
			CASE "CHASSIS SPLIT" // chassis split
				THIS.Event ue_PreAddChassisSplit ( al_Row ) 
			CASE "BOBTAIL"
				THIS.Event ue_AddBobtailSet ( al_Row )
				
		END CHOOSE
	END IF
END IF	

THIS.SetFocus ( )
THIS.SetRow ( al_Row ) 
THIS.SetColumn ( "co_name" )

// we will determine if we should continue the routing here 
CHOOSE CASE ls_PopRtn
		
	CASE "DISMOUNT", "MOUNT" , "DROP" ,  "DELIVER" ,"PICKUP"
		lb_ContiueRouting = TRUE
	CASE "HOOK"
		IF al_Row < THIS.RowCount ( )THEN
			lb_ContiueRouting = TRUE 
		END IF
	CASE ELSE 
		lb_ContiueRouting = FALSE
END CHOOSE


IF lb_ContiueRouting THEN
	THIS.Event ue_ContinueRoutingForNewEvent ( al_row )
	THIS.Event ue_RefreshShipment ( )
END IF

IF ll_Return = 1 THEN
	THIS.Event ue_Refresh ( )
END IF



THIS.SelectRow ( 0, FALSE )
THIS.SetRedraw ( TRUE )

Destroy ( lnv_event )	// RDT 5-26-03


end event

event ue_scrollleft;THIS.of_ScrollLeft ( ) 
end event

event ue_setrow;THIS.Post SetRow ( al_row ) 
RETURN 1
end event

event ue_continueroutingfornewevent;Int	li_Return = -1
Int	li_InsertionStyle
Long	ll_SourceID
Long	ll_TargetID
Long	ll_SourceRow
Long	ll_TargetRow  // this is the new event row
n_cst_beo_Event		lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
lnv_Event = CREATE n_cst_beo_Event

ll_TargetRow = al_targetrow
lnv_Event.of_SetSource ( THIS )
lnv_Event.of_SetSourceRow ( ll_TargetRow )
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

IF isValid ( lnv_Dispatch ) THEN
	
	IF lnv_Event.of_HasSource ( ) THEN
		ll_TargetID = lnv_Event.of_GetID ( ) 
		IF lnv_Event.of_IsPickupGroup ( ) THEN
			ll_SourceRow = ll_TargetRow - 1	
			li_InsertionStyle = gc_dispatch.ci_InsertionStyle_After
		ELSEIF lnv_Event.of_IsDeliverGroup ( ) THEN
			ll_SourceRow = ll_TargetRow + 1			
			li_InsertionStyle = gc_dispatch.ci_InsertionStyle_Before
		END IF
		
	END IF
	
	IF ll_SourceRow > 0 AND ll_SourceRow <= THIS.RowCount ( ) THEN
		lnv_Event.of_SetSourceRow ( ll_SourceRow )
		ll_SourceID = lnv_Event.of_GetID ( ) 
	END IF
	
	IF ll_SourceID > 0 THEN
		li_Return = lnv_Dispatch.of_DuplicateRouting ( ll_SourceID , {ll_TargetID} , li_InsertionStyle ) // rtn 1 , 0 , -1
	END IF
	
END IF
DESTROY ( lnv_Event )
RETURN li_Return
end event

event type integer ue_addstreetturn(long al_row);
Long		ll_Return 
Long		lla_NewIds[]
Boolean	lb_Continue = TRUE
Long		ll_Site


n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

n_cst_beo_shipment	lnv_Shipment
n_Cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event  		lnv_Event		



lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Event = Create n_cst_beo_Event  	

IF IsValid ( lnv_Dispatch ) THEN
	lnv_Event.of_SetSource( lnv_Dispatch.of_geteventcache( ) ) 			
END IF

lnv_Event.of_SetShipment( lnv_Shipment ) 
lnv_Event.of_SetAllowFilterSet ( TRUE ) 

n_cst_setting_poolsyards	lnv_Yards
lnv_Yards = CREATE n_cst_setting_poolsyards
IF Len ( lnv_Yards.of_GetValue ( ) ) > 0 THEN 

	CHOOSE CASE Messagebox ( "Equipment Interchange" , "Do you want to see a list of yards and pools?" , QUESTION! , YESNOCANCEL!,1 ) 
	
		CASE 1 // show the list
			open ( w_YardsandPools ) 
			IF isValid ( Message.PowerObjectParm ) THEN
				lnv_Msg = Message.PowerObjectParm
				IF lnv_Msg.of_Get_Parm ( "COID" , lstr_Parm ) <> 0  THEN
					ll_Site = lstr_Parm.ia_Value 
				END IF
			END IF
			
		CASE 2 // no
			
		CASE 3 // CANCEL
			lb_Continue = FALSE
		
	END CHOOSE
END IF
DESTROY (lnv_Yards)

IF lb_Continue THEN
	
	IF lnv_Shipment.of_AddEvents ( { gc_Dispatch.cs_Eventtype_Drop} , al_row , lnv_Dispatch , lla_NewIds[] ) = 1 THEN

		lnv_Dispatch.of_FilterShipment ( lnv_Shipment.of_GetID () )
		lnv_Event.of_SetSourceID (lla_NewIds [1])	
		lnv_Event.of_SetHideonbill( TRUE )
		THIS.Post Event ue_ChangeSite (al_row , ll_Site )
		
		lnv_Event.of_SetSourceID ( lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row + 1,"de_id" ) )	
		lnv_Event.of_SetRoutable( 'F' )

		ll_Return = 1
		IF al_Row > 1 THEN
			lla_NewIds [ UpperBound ( lla_NewIds ) + 1 ] = lnv_Event.of_GetID ( )
	   	lnv_Dispatch.of_DuplicateRouting ( THIS.GetItemNumber ( al_row - 1  , "de_id" )  , lla_NewIds , gc_dispatch.ci_InsertionStyle_After )												
			THIS.post event ue_RefreshShipment ( )			
		END IF
			
	END IF
ELSE
	ll_Return = -1
END IF

Destroy  ( lnv_Event ) 

RETURN ll_Return
end event

event ue_addalert(long al_row);n_cst_beo_Event	lnv_Event
lnv_Event = Create n_cst_beo_event

lnv_Event.of_SetSource ( THIS ) 
lnv_Event.of_SetSourceRow ( al_Row ) 

lnv_Event.of_AddUseralert( )

DESTROY lnv_Event
end event

event type long ue_addbobtailset(long al_row);// RDT 5-26-03 Changed to use beo_Event

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
lnv_Event.of_SetShipment( lnv_Shipment ) 

// I didn't send in the deliver b.c it would create a stop off item for the deliver
// which would not be right in the case of a x-dock
IF lnv_Shipment.of_AddEvents ( {''} , al_row   , lnv_Dispatch , lla_NewIds[] ) = 1 THEN

	THIS.Event ue_ActionEventAdded ( )		
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
	//	lnv_Dispatch.of_DuplicateRouting ( lnv_Dispatch.of_GetEventCache ( ).GetItemNumber ( al_row - 1 ,"de_id" )  ,lla_NewIds, gc_dispatch.ci_InsertionStyle_After )												
		THIS.Post event ue_RefreshShipment ( )			
	END IF
END IF
	
Destroy ( lnv_Event )  

THIS.SetRedraw ( TRUE ) 
RETURN ll_Return
end event

private function integer of_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg);String	ls_PreviousType
String	ls_NextType
String	ls_CheckItem
String	lsa_ParmLabel[]
Any		laa_ParmValue[]
Boolean	lb_HasShipment
Boolean	lb_Continue = TRUE
Long		ll_SelectedRow
Long		lla_SelectedRows[]
Long		ll_SelectedCount
Long		ll_Row 
Long		ll_RowCount
Long		ll_EventID
Long		ll_Shipment1
Long		ll_Shipment2
Boolean	lb_AlterItins
Int		li_Rtn
n_cst_privileges_events	lnv_Privs
s_Parm	lstr_Parm

n_cst_beo_Event	lnv_Event1
n_cst_beo_Event	lnv_Event2

n_Cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.event ue_getshipment( )
//Modified by Dan 2-7-07 to use a new privFunction if it is billed
String 	ls_privFunction
IF isValid( lnv_shipment ) THEN
	IF lnv_shipment.of_isBilled( ) THEN
		ls_privFunction = n_cst_privSmanager.cs_ModifyBilledShip
	ELSE
		ls_privFunction = "ModifyShipment"
	END IF
ELSE
	ls_privFunction = "ModifyShipment"
END IF
///////////////////////////

IF gnv_App.of_GetPrivsmanager( ).of_GetUserpermissionfromfn( ls_privFunction ,lnv_Shipment ) = n_cst_privsmanager.ci_FALSE THEN
	RETURN -1
END IF

lnv_Event1 = CREATE n_cst_beo_Event
lnv_Event2 = CREATE n_cst_beo_Event


lb_AlterItins = lnv_Privs.of_Allowalteritins( )

ll_RowCount = THIS.RowCount ( )
ll_Row = al_Row

DO 
	
	ll_SelectedRow = THIS.GetSelectedRow ( ll_SelectedRow )
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
			lnv_Event1.of_SetSource ( THIS )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [1] )
			ls_NextType = lnv_Event1.of_GetType ( )
			
		CASE lla_SelectedRows [ 2 ]
			lnv_Event1.of_SetSource ( THIS )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [2] )
			ls_PreviousType = lnv_Event1.of_GetType ( )
	END CHOOSE

END IF

IF ll_Row > 0 AND ll_Row <= ll_RowCount THEN
	lnv_Event1.of_SetSource ( THIS )
	lnv_Event1.of_SetSourceRow ( ll_Row )
	
	ll_EventID = lnv_Event1.of_GetID ( )
	lb_HasShipment = lnv_Event1.of_GetShipment ( ) > 0 
	
	
	CHOOSE CASE ll_SelectedCount
			
		CASE 1
			
			IF NOT lnv_Event1.of_IsConfirmed ( ) THEN
				IF  lnv_Event1.of_IsRouted ( ) OR  lnv_Event1.of_isbobtailevent( ) THEN
				ELSE
									
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Pickup"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Deliver"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Hook"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "D&rop"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Mount"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Dismou&nt"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Yard Move"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&X-Dock"
					
					lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
					laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Chassis Split"
					IF ll_Row = ll_RowCount AND lnv_Event1.of_gettype( ) = 'R' THEN
						lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
						laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "&Interchange"
					END IF
					
					CHOOSE CASE lnv_Event1.of_GetType ( ) 							
						CASE "H"
							ls_CheckItem = "&Hook"
						CASE "R"
							ls_CheckItem = "D&rop"
						CASE "P"
							ls_CheckItem = "&Pickup"
						CASE "D"
							ls_CheckItem = "&Deliver"
						CASE "M"
							ls_CheckItem = "&Mount"
						CASE "N"
							ls_CheckItem = "Dismou&nt"
					END CHOOSE
					IF Len ( ls_CheckItem ) > 0 THEN
						lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "CHECK"
						laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = ls_CheckItem
					END IF
							
					
				END IF
		//		ELSE
					
					IF  lnv_Privs.of_allowalteritins( ) OR (NOT lnv_Event1.of_IsRouted ( ) AND NOT lnv_Privs.of_allowalteritins( ) )THEN
						IF NOT lnv_Event1.of_Isbobtailevent( ) THEN
						
							CHOOSE CASE lnv_Event1.of_GetType( )
							
								CASE gc_Dispatch.cs_EventType_Drop
									
									IF UpperBound ( lsa_ParmLabel ) > 0 THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "-"
									END IF
									
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
						
									IF lb_HasShipment THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
									END IF
							
								CASE gc_Dispatch.cs_EventType_Dismount
									
									IF UpperBound ( lsa_ParmLabel ) > 0 THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "-"
									END IF
								
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
									
									IF lb_HasShipment THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
									END IF
								
								CASE gc_Dispatch.cs_EventType_Hook
							
									IF UpperBound ( lsa_ParmLabel ) > 0 THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "-"
									END IF
									
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
									
									IF lb_HasShipment THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
									END IF
							
								CASE gc_Dispatch.cs_EventType_Mount
									
									IF UpperBound ( lsa_ParmLabel ) > 0 THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "-"
									END IF
									
									lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
									laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
						
									IF lb_HasShipment THEN
										lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
										laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
									END IF
										
									
								CASE gc_Dispatch.cs_EventType_Pickup
									IF lb_HasShipment THEN
										IF UpperBound ( lsa_ParmLabel ) > 0 THEN
											lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
											laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "-"
										END IF
										
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
										
										IF UpperBound ( lsa_ParmLabel ) > 0 THEN
											lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
											laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "-"
										END IF
										
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
				END IF // allow alter itins
			END IF // Conf
					
			
			
		CASE 2
			IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent
				lnv_Event1.of_SetSource ( THIS )
				lnv_Event1.of_SetSourceRow ( lla_SelectedRows [ 1 ] )
				
				lnv_Event2.of_SetSource ( THIS )
				lnv_Event2.of_SetSourceRow ( lla_SelectedRows [ 2 ] )
				
				ll_Shipment1 = lnv_Event1.of_GetShipment ( )
				ll_Shipment2 = lnv_Event2.of_GetShipment ( )
				IF lnv_Event1.of_IsDeliverGroup ( ) AND lnv_Event2.of_IsPickupGroup ( ) THEN
					IF Not ( lnv_Event1.of_IsConfirmed ( ) OR lnv_Event2.of_IsConfirmed ( ) ) THEN
						IF  lb_AlterItins OR ( NOT ( lnv_Event2.of_IsRouted ( ) OR lnv_Event1.of_IsRouted ( ) )) THEN
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
					END IF
				END IF
			END IF
		END CHOOSE
	
	IF lnv_Event1.of_GetType( ) = 'H' OR lnv_event1.of_gettype( ) = 'R' THEN
		lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
		laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "-"
		
		lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
		laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Add Yard Storage"
	END IF
END IF



lstr_Parm.is_label = "LABELS"
lstr_Parm.ia_Value = lsa_ParmLabel
anv_msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "VALUES"
lstr_Parm.ia_Value = laa_ParmValue
anv_msg.of_Add_Parm ( lstr_Parm )

DESTROY ( lnv_Event1 )
DESTROY ( lnv_Event2 )


Return li_Rtn


end function

public function integer of_markasnonroutable (long al_row);THIS.object.disp_events_routable [al_row]= 'F'
RETURN 1
end function

public function integer of_switchroutablestatus (long al_row);Int	li_Return = 1
Char  lc_NewStatus
Boolean	lb_Continue = TRUE

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( THIS ) 
lnv_Event.of_SetSourceRow ( al_Row ) 
lnv_Event.of_SetShipment ( THIS.Event ue_GetShipment () )

IF lb_Continue THEN
	IF Not lnv_Event.of_HasSource (  )  THEN
		li_Return = -1
		lb_Continue = FALSE 
	END IF
END IF

IF lb_Continue THEN
	IF THIS.object.disp_events_routable [al_row]= 'F' THEN
		lc_NewStatus = 'T'
	ELSE
		lc_NewStatus = 'F'
	END IF
END IF

IF lb_Continue THEN
	IF lnv_Event.of_IsRouted ( ) AND lc_NewStatus = 'F' THEN
		lb_Continue = FALSE
		MessageBox ( "Mark Event as Non-Routable" , "The event selected is already routed and therefore cannot be mark as Non-Routable." )
	END IF
END IF

IF lb_Continue THEN
	lnv_Event.of_SetRoutable ( lc_NewStatus )
END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end function

public function integer of_allowedit (boolean ab_value);n_cst_events	lnv_Events
String			ls_ValueList

IF ab_Value THEN
//	This.Modify ( "de_event_type.Edit.CodeTable = Yes	de_event_type.Values = '" +  lnv_Events.of_GetTypeCodeTableForShipment ( ) + "'de_event_type.ddlb.allowedit=yes" )             
//	//	This.Modify ( "de_event_type.Edit.CodeTable = Yes	de_event_type.Values = '" +  lnv_Events.of_GetTypeCodeTableForShipment ( ) + "' de_event_type.ddlb.allowedit=yes de_event_type.ddlb.UseAsBorder=no de_event_type.ddlb.case=upper de_event_type.ddlb.required=yes de_event_type.ddlb.autohscroll=yes de_event_type.ddlb.vscrollbar=yes " )             
//	of_SetDropDownSearch(true)
//	inv_dropdownsearch.of_Register( "de_event_type" )
//	//THIS.object.de_event_type.protect = 0
//	THIS.object.co_name.protect = 0
//	THIS.object.de_note.protect = 0
	
ELSE
	
	THIS.SetColumn ( "Leg_miles" ) 
	THIS.object.de_event_type.protect = 1
	THIS.object.co_name.protect = 1
	THIS.object.de_note.protect = 1
	
END IF


//
//This.Modify ( "de_event_type.Edit.CodeTable = Yes	de_event_type.Values = '" +  lnv_Events.of_GetTypeCodeTableForShipment ( ) + "' de_event_type.ddlb.allowedit=yes de_event_type.ddlb.UseAsBorder=no de_event_type.ddlb.case=upper de_event_type.ddlb.required=yes de_event_type.ddlb.autohscroll=yes de_event_type.ddlb.vscrollbar=yes " )             


RETURN 1
end function

public function integer of_validateeventchange (long al_row);


return -1
end function

public function integer of_makecontextmodifications ();//Responds to new context settings.

//Returns :  1 = Success
//				-1 = Failure

//Constant String	cs_Context_DispatchShipment = "T"
//Constant String	cs_Context_NonRoutedShipment = "D"
//Constant String	cs_Context_Itinerary = "I"
//Constant String	cs_Context_Trip = "3"

n_cst_beo_Shipment	lnv_Shipment

Constant String	ls_BackgroundByConf = "16777215~tif ( de_conf = 'T', 12648447, 16777215 )"
Constant String	ls_ProtectByConf = "0~tif ( de_conf = 'T', 1, 0 )"

Constant String	ls_BackgroundByConfOrArrdate = "16777215~tif ( de_conf = 'T', 12648447, if ( isnull ( de_arrdate ), 12632256, 16777215 ) )"
Constant String	ls_ProtectByConfOrArrdate = "0~tif ( de_conf = 'T' or isnull ( de_arrdate ), 1, 0 )"

Constant String	ls_BackgroundByConfOrShipment = "16777215~tif ( de_conf = 'T' or ( de_shipment_id > 0 and not isnull ( de_site ) ), 12648447, 16777215 )"
Constant String	ls_ProtectByConfOrShipment = "0~tif ( de_conf = 'T' or ( de_shipment_id > 0 and not isnull ( de_site ) ), 1, 0 )"

Constant String	ls_BackgroundByArrdate = "16777215~tif ( isnull ( de_arrdate ), 12632256, 12648447 )"

Constant String	ls_ItinOrTripConf = "0~tif ( de_conf = 'T' and de_shipment_id > 0, 1, 0 )"

Boolean	lb_Restricted
String	ls_Context, &
			ls_Work

Integer	li_Return = 1

n_cst_Privileges_events	lnv_Privs

lnv_Shipment = THIS.Event ue_GetShipment ( )
ls_Context = This.of_GetContext ( )


//If we're in a shipment context, see if we're in restricted edit mode.

CHOOSE CASE ls_Context

CASE gc_Dispatch.cs_Context_DispatchShipment, gc_Dispatch.cs_Context_NonRoutedShipment

	IF IsValid ( lnv_Shipment ) THEN

		
		IF lnv_Shipment.of_AllowEdit ( ) = FALSE THEN
			lb_Restricted = TRUE
		ELSEIF lnv_Shipment.of_AllowEditBill ( ) = TRUE AND lnv_Privs.of_allowalteritins( ) THEN
			//Based on privileges, user can modify the bill for the current status.
			lb_Restricted = FALSE
		ELSEIF lnv_Shipment.of_AllowRestrictActive ( ) = TRUE AND lnv_Privs.of_allowalteritins( )THEN
			//Force billing is enabled, adding/editing events is allowed, regardless of status.
			lb_Restricted = FALSE
		ELSE
			//None of the allowing conditions were met, so reject.
			lb_Restricted = TRUE
		END IF

		//End change 3.5.20 BKW
		

	ELSE
		li_Return = -1

	END IF

END CHOOSE


//If all ok so far, perform the context modifications.

IF li_Return = 1 THEN
	THIS.SetColumn ( "leg_miles" )
	CHOOSE CASE ls_Context
	
	CASE gc_Dispatch.cs_Context_NonRoutedShipment
	
	
		//co_Name
		IF lb_Restricted THEN
			This.Object.co_Name.Background.Color = 12648447
			This.Object.co_Name.Protect = 1
		ELSE
			This.Object.co_Name.Background.Color = ls_BackgroundByConf
			This.Object.co_Name.Protect = ls_ProtectByConf
		END IF
	

	CASE gc_Dispatch.cs_Context_DispatchShipment
	
	
		//co_Name
		IF lb_Restricted THEN
			This.Object.co_Name.Background.Color = 12648447
			This.Object.co_Name.Protect = 1
		ELSE
			This.Object.co_Name.Background.Color = ls_BackgroundByConf
			This.Object.co_Name.Protect = ls_ProtectByConf
		END IF
//	

//
	CASE gc_Dispatch.cs_Context_Trip
	
		//de_ArrDate
		This.Object.de_ArrDate.Background.Color = ls_BackgroundByConf
		This.Object.de_ArrDate.Protect = ls_ProtectByConf
	
		//de_ArrTime
		This.Object.de_ArrTime.Background.Color = ls_BackgroundByConfOrArrdate
		This.Object.de_ArrTime.Protect = ls_ProtectByConfOrArrdate
	
		//de_DepTime
		This.Object.de_DepTime.Background.Color = ls_BackgroundByConfOrArrdate
		This.Object.de_DepTime.Protect = ls_ProtectByConfOrArrdate
	
		//de_Conf
		This.Object.de_Conf.Protect = ls_ItinOrTripConf
	
		//co_Name
		IF lb_Restricted THEN   //????If we implement trip restrictions
			This.Object.co_Name.Background.Color = 12648447
			This.Object.co_Name.Protect = 1
		ELSE
			This.Object.co_Name.Background.Color = ls_BackgroundByConfOrShipment
			This.Object.co_Name.Protect = ls_ProtectByConfOrShipment
		END IF
	
		This.Object.comp_Loc_ArrDate.Background.Color = 12648447
		This.Object.comp_Loc_DepDate.Background.Color = 12648447
		This.Object.comp_Loc_Arrtime.Background.Color = 12648447
		This.Object.comp_Loc_DepTime.Background.Color = 12648447
	
	CASE ELSE  //Unexpected Context Value
		li_Return = -1
	
	END CHOOSE

END IF

RETURN li_Return
end function

public subroutine of_scrollleft ();IF THIS.RowCount() <> 0 THEN 
	Send(Handle(THIS), 276, 2, 0) 
END IF

end subroutine

public subroutine of_scrollright ();IF THIS.RowCount() <> 0 THEN 
	Send(Handle(THIS), 276, 3, 0) 
END IF

end subroutine

public function integer of_switchhideonbillstatus (long al_Row);Int		li_Return = 1
Boolean  lb_NewStatus
Boolean	lb_Continue = TRUE

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( THIS ) 
lnv_Event.of_SetSourceRow ( al_Row ) 
lnv_Event.of_SetShipment ( THIS.Event ue_GetShipment () )

IF lb_Continue THEN
	IF Not lnv_Event.of_HasSource (  )  THEN
		li_Return = -1
		lb_Continue = FALSE 
	END IF
END IF

IF lb_Continue THEN
	lb_NewStatus = NOT lnv_Event.of_GetHideOnBill ()
	lnv_Event.of_SetHideOnBill ( lb_NewStatus )
END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end function

protected function integer of_bobtailadded (long al_row);n_cst_beo_Shipment	lnv_Shipment
n_cst_Beo_Event		lnv_Event
n_cst_Bso_Dispatch	lnv_Disp
n_cst_Settings			lnv_Settings


lnv_Event = CREATE n_cst_beo_Event	
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Disp = THIS.Event ue_GetDispatchManager ( )

lnv_Event.of_SetSource ( THIS )
lnv_Event.of_SetSourceRow ( al_Row )

IF isValid ( lnv_Shipment ) THEN
	IF lnv_Settings.of_AddStopOffItem ( ) THEN
		lnv_Disp.of_FilterShipment ( lnv_Shipment.of_Getid( ) )
		IF NOT lnv_Shipment.of_Allowitemedit( ) THEN
			IF MessageBox ( "Add Bobtail charge" , "The associated Bobtail charge will not be added since you do not have permissions to alter the shipment's items. Do you want to add the pickup event anyway?", Question!, YESNO!, 1 ) = 2 THEN
				lnv_Shipment.of_Removeevents( {lnv_Event.of_GetID ()} , lnv_Disp )
			END IF
		ELSE
			lnv_Shipment.of_AddBobtailItem ( lnv_Event , lnv_Disp )			
		END IF		
	END IF	
END IF

DESTROY ( lnv_Event )

RETURN 1
end function

event constructor;call super::constructor;
n_cst_LicenseManager	lnv_LicenseManager
Integer	li_BaseTimeZone
n_cst_Dws		lnv_Dws
n_cst_Events	lnv_Events

//lnv_Dws.Post of_CreateHighlight ( This )
ib_NeedHighlight = TRUE

li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )
This.Modify ( "comp_tz_home.Expression = '" + String ( li_BaseTimeZone ) + "'" )

//THIS.of_SetRowSelect ( TRUE ) 
//inv_RowSelect.of_SetStyle ( 2 )

//This.Modify ( "de_event_type.Edit.CodeTable = Yes	de_event_type.Values = '" +  lnv_Events.of_GetTypeCodeTableForShipment ( ) + "' de_event_type.ddlb.allowedit=yes de_event_type.ddlb.UseAsBorder=no de_event_type.ddlb.case=upper de_event_type.ddlb.required=yes de_event_type.ddlb.autohscroll=yes de_event_type.ddlb.vscrollbar=yes " )             
//of_SetDropDownSearch(true)
//inv_dropdownsearch.of_Register( "de_event_type" )


end event

event editchanged;If IsValid(inv_dropdownsearch) Then
	inv_dropdownsearch.event pfc_editchanged(row, dwo, data)
End If	
end event

event rbuttondown;call super::rbuttondown;CHOOSE CASE dwo.name 
		
	CASE "de_event_type"
		IF row > 0 THEN
			THIS.Event ue_ShowEventMenu ( row )
		END IF
		
		
END CHOOSE
end event

event itemchanged;call super::itemchanged;//modified By dan 2-7-07 to use new priv function if it is a billed shipment
N_cst_beo_shipment	lnv_shipment
String	ls_privFunction
lnv_shipment = THIS.Event ue_GetShipment (  ) 

IF isValid( lnv_shipment ) THEN
	IF lnv_shipment.of_isBilled( ) THEN
		ls_privFunction = n_cst_privsManager.cs_ModifyBilledShip 
	ELSE
		ls_privFunction = "ModifyShipment"
	END IF
ELSE
	ls_privFunction = "ModifyShipment"
END IF
	//////////////////
IF gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( ls_privFunction, lnv_shipment ) = n_cst_privsmanager.ci_FALSE THEN
	RETURN 2
END IF
CHOOSE CASE dwo.Name
		
	CASE "de_event_type"
		CHOOSE CASE data
				
			CASE gc_Dispatch.cs_EventAction_YardMove , gc_Dispatch.cs_EventAction_CrossDock , gc_Dispatch.cs_EventAction_ChassisSplit
				RETURN 1
				
			CASE 'P'
				THIS.of_PickupAdded( row )
			CASE 'D' 
				THIS.of_DeliverAdded ( row )
				
		END CHOOSE	

END CHOOSE

RETURN AncestorReturnValue


end event

event itemerror;Long		ll_Return 
Long		ll_RowCount 
Long		lla_NewIds[]
Boolean	lb_Front
Boolean	lb_Back
Boolean	lb_Continue = TRUE
String	ls_message

//ll_Return = AncestorReturnValue 
n_cst_beo_shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )
ll_RowCount = THIS.RowCount ( )


//     \m/ *_* \m/       \\

CHOOSE CASE dwo.name
		
//	CASE "co_name"
//		ll_Return = 3
	CASE "de_event_type"
	
	
		CHOOSE CASE data
			CASE gc_Dispatch.cs_EventAction_YardMove 
				
				THIS.Event ue_AddYardMove ( row ) 
				RETURN 2
							
				
			CASE gc_Dispatch.cs_EventAction_CrossDock 
				THIS.Event ue_AddCrossDock ( row ) 
				RETURN 2
				
			CASE gc_Dispatch.cs_EventAction_ChassisSplit
				
				IF THIS.Event ue_PreAddChassisSplit ( Row ) = 1 THEN
					ll_Return = 1
				Else
					ll_Return = 3
				END IF
			
			
		END CHOOSE
		
		
END CHOOSE

RETURN ll_Return
end event

event ue_changesite;call super::ue_changesite;
IF ib_YardMove AND il_YardRow = al_row THEN
	Super::Event  ue_ChangeSite ( al_row + 1 , al_id )
	//Super::Event  ue_ChangeSite ( al_row  , al_id )
	
	Any	la_Value 	
	n_Cst_Settings	lnv_Settings	
	lnv_Settings.of_GetSetting ( 86 , la_Value )
	IF String ( la_Value )  =  "YES!"  AND is_NoteContext = "YARD" THEN
		THIS.Post Event ue_AddEventNote (  al_row , is_NoteContext) 
	END IF
	is_NoteContext = ""
	ib_YardMove = FALSE
END IF

RETURN AncestorReturnValue
end event

event clicked;call super::clicked;gf_multiselect(this, row)
THIS.SetRow ( row )
end event

event resize;call super::resize;IF ib_NeedHighlight THEN
	n_cst_Dws		lnv_Dws
	lnv_Dws.Post of_CreateHighlight ( This )
	ib_NeedHighlight = FALSE
END IF

RETURN AncestorReturnValue

end event

event processkey;call super::processkey;// RDT 5-26-03 Changed to use n_cst_beo_event
String	ls_Name
Long		ll_Return
String	ls_OldType
Boolean	lb_Changed
n_Cst_beo_Shipment	lnv_Shipment

n_cst_Beo_Event		lnv_Event								// RDT 5-26-03 
n_cst_bso_Dispatch	lnv_Dispatch


ll_Return = AncestorReturnValue

IF ll_Return = 0 AND THIS.RowCount ( ) > 0 THEN // 0 = Continue processing

	lnv_Shipment = THIS.Event	ue_GetShipment ( )
	lnv_Event = Create n_cst_Beo_Event						// RDT 5-26-03 
	lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )
	IF IsValid ( lnv_Dispatch ) THEN
		lnv_Event.of_SetSource ( lnv_Dispatch.of_geteventcache( ) )		
	ELSE		
		lnv_Event.of_SetSource ( THIS )
	END IF
	
	lnv_Event.of_SetSourceID ( THIS.GetItemNumber ( THIS.GetRow ( ) , "de_id"   )	)	// RDT 5-26-03 
	lnv_Event.of_SetShipment( lnv_Shipment ) // RDT 8-27-03
	
	THIS.SetRedraw ( FALSE ) 
	ls_Name = THIS.GetColumnName ( )
	is_SetColumn = ls_Name
	
	CHOOSE CASE Key 
		CASE keydownarrow! , keypagedown! , keyuparrow! , keypageup! //, keytab!	
			THIS.SetColumn ( "de_note" )
			THIS.Event Post ue_SetColumn ( ) 
			ll_Return = 0
		CASE keytab!
			ll_Return = 0
		CASE ELSE
			
		//Modified By Dan 2-7-07 to check new priv function if it is billed
		String	ls_privsFunction
		IF isValid( lnv_shipment ) THEN
			IF lnv_shipment.of_isBilled( ) THEN
				ls_privsFunction = n_cst_privsManager.cs_ModifyBilledShip
			ELSE  
				ls_privsFunction = "ModifyShipment"
			END IF
		ELSE
			ls_privsFunction = "ModifyShipment"
		END IF
		//////////////////////////
		IF gnv_app.of_getprivsmanager( ).of_Getuserpermissionfromfn( ls_privsFunction, lnv_Shipment ) = n_cst_privsmanager.ci_False THEN
			ll_Return = 1
		ELSE
			IF ls_Name = "de_event_type" THEN
					
					ls_OldType = THIS.GetItemString ( THIS.GetRow () , "de_event_type" )
					
			
					IF isValid ( lnv_Shipment )  THEN
						
						//lnv_Event.Of_SetShipment( lnv_Shipment )
						
						Yield ( )  // without this here the letter typed would stay.
						
						
						CHOOSE CASE Key	
								
							CASE KeyP!	// pickup
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , 'P' )	// RDT 5-26-03 
								lnv_Event.of_SetType( "P" ) 											// RDT 5-26-03 
								THIS.Post of_PickupAdded ( THIS.GetRow ( ) )
								ll_Return = 1 
								
							CASE KeyD! // Deliver
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , 'D' )		// RDT 5-26-03 
								lnv_Event.of_SetType( "D" ) 												// RDT 5-26-03 
								THIS.Post of_DeliverAdded ( THIS.GetRow ( ) )
								ll_Return = 1 
								
							CASE KeyH! // Hook
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , 'H' )		// RDT 5-26-03 
								lnv_Event.of_SetType( "H" ) 												// RDT 5-26-03 
								ll_Return = 1 
								
							CASE KeyR! //Drop
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , 'R' ) 		// RDT 5-26-03 
								lnv_Event.of_SetType( "R" ) 												// RDT 5-26-03 
								ll_Return = 1 
								
							CASE KeyN! //mount 
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , 'N' )		// RDT 5-26-03 
								lnv_Event.of_SetType( "N" ) 												// RDT 5-26-03 
								ll_Return = 1 
								
							CASE KeyM! // dismount
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , 'M' )		// RDT 5-26-03 
								lnv_Event.of_SetType( "M" ) 												// RDT 5-26-03 
								ll_Return = 1 					
								
							CASE KeyY! // Yard Move
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , ls_OldType )		// RDT 5-26-03 
								lnv_Event.of_SetType( ls_OldType ) 												// RDT 5-26-03 
								THIS.Event ue_AddYardMove ( THIS.GetRow ( ) )					
								ll_Return = 1 
			
							CASE KeyX! // CrosDock
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , ls_OldType )		// RDT 5-26-03 
								lnv_Event.of_SetType( ls_OldType ) 												// RDT 5-26-03 
								THIS.Event ue_AddCrossDock ( THIS.GetRow ( ) )		
								ll_Return = 1 
								
							CASE KeyS! // chassis split
								lb_Changed = TRUE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , ls_OldType )		// RDT 5-26-03 
								lnv_Event.of_SetType(ls_OldType ) 												// RDT 5-26-03 
			
								THIS.Event ue_PreAddChassisSplit ( THIS.GetRow ( ) ) 
								ll_Return = 1 
								
							CASE ELSE
								//THIS.SetItem ( THIS.GetRow () , "de_event_type" , ls_OldType )		// RDT 5-26-03 
								lnv_Event.of_SetType(ls_OldType ) 												// RDT 5-26-03 
				
								ll_Return = 1
								
						END CHOOSE
					END IF
				END IF
			END IF
			
	END CHOOSE
	THIS.Post SetRedraw ( TRUE ) 
	
END IF

IF lb_Changed THEN
	THIS.Post SetColumn ( "co_name" )
END IF

Destroy ( lnv_Event )  // RDT 5-26-03 

RETURN ll_Return 

end event

event ue_setcolumn;call super::ue_setcolumn;String	lsa_Names[]
Long		ll_Row
Boolean	lb_Process
Boolean	lb_RestrictedView
Long		ll_RowCount 
Long		i

lb_RestrictedView = gnv_App.of_GetrestrictedView ( )

THIS.SetRedraw ( FALSE ) 
THIS.SelectRow ( 0 , FALSE )


ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount 
	IF Len ( THIS.GetItemString ( i , "co_name" ) ) = 0  THEN
		lb_Process = TRUE
		EXIT
	END IF	
NEXT

ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 AND lb_Process THEN
		
	IF Len ( THIS.GetItemString ( ll_Row , "co_name" ) ) > 0  THEN
		THIS.SetColumn ( THIS.SetColumn ( "de_note") )	
		IF lb_RestrictedView THEN
			THIS.of_ScrollRight ( )
		END IF
	ELSE
		THIS.SetColumn ( "co_name")
		THIS.of_ScrollLeft ( )
	END IF

END IF

THIS.SetRedraw ( TRUE ) 	
end event

event rowfocuschanged;//override
end event

on u_dw_eventlist.create
end on

on u_dw_eventlist.destroy
end on

