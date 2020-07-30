$PBExportHeader$n_cst_edishipment_manager_jb_hunt.sru
forward
global type n_cst_edishipment_manager_jb_hunt from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_jb_hunt from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_jb_hunt n_cst_edishipment_manager_jb_hunt

type variables
Constant String	cs_JBHuntScac = "HJBT"
end variables

forward prototypes
protected function string of_getmovedirection ()
protected function datastore of_getpendingdatastore ()
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_setitemdataintermodal ()
protected function integer of_addnonintermodalitems ()
protected function integer of_setitemdatanonintermodal ()
protected function boolean of_ismoveintermodal ()
end prototypes

protected function string of_getmovedirection ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getmovedirection
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		:String
//						one of 3 constant values representing the direction on the intermodal move.
//						
//	Description	: Check for a One Way, Import or Export move. 
//
//
// 	Written by	:Samuel Towle
// 		Date	:10/12/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////


// We can use the length of the N1_04 to determine move direction direction.
// A terminal location will have a 2 char identifier.
// If the first stop is a terminal then direction is inbound.
// IF last stop is a terminal then direction is outbound
// If First and last stop are both terminals then move is a one way.


Boolean	lb_FirstStop
Boolean	lb_LastStop
Long		ll_StopCount
String	ls_Direction
String	ls_StopCode
	
n_cst_edisegment	lnva_Segments[]
n_cst_edisegment	lnva_StopSegments[]
n_cst_edisegment	lnva_Segment[]


// Get the number of stops by counting the S5 segments
THIS.of_GetSegments( "S5", lnva_Segments )
ll_StopCount = UpperBound ( lnva_Segments )

// Get the segments for the first stop
THIS.of_GetStopGroup ( 1 , lnva_StopSegments[] )

// Find the N1 segment
THIS.of_GetSegments( "N1", lnva_StopSegments[], lnva_Segment[])

// Find element 4

lnva_Segment[1].of_getvalue( {4} , ls_StopCode )
IF Len ( ls_StopCode ) = 2 THEN
	lb_FirstStop = TRUE
ELSE
	lb_FirstStop = FALSE
END IF



// Get the segments for the last stop (upperbound)
THIS.of_GetStopGroup ( ll_StopCount , lnva_StopSegments[] )

// Find the N1 segment
THIS.of_GetSegments( "N1", lnva_StopSegments[], lnva_Segment[])

// Find element 4
lnva_Segment[1].of_getvalue( {4} , ls_StopCode )
IF Len ( ls_StopCode ) = 2 THEN
	lb_LastStop = TRUE
ELSE
	lb_LastStop = FALSE
END IF

IF lb_FirstStop = TRUE AND lb_LastStop = FALSE THEN
	ls_Direction = cs_Import
	
ELSEIF lb_FirstStop = FALSE AND lb_LastStop = TRUE THEN
	ls_Direction = cs_Export
	
ELSE
	ls_Direction = cs_OneWay
END IF

// "TF" = import, "FT" = export, "TT" or "FF" = one way / other			

	
// We did not find enough stops. use default of One-Way.  Should not see this.

// if we did not find it them default to oneway
IF Len ( ls_Direction ) = 0 THEN
	ls_Direction = cs_OneWay
END IF


RETURN  ls_Direction	


end function

protected function datastore of_getpendingdatastore ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getpendingdatastore
//  
//	Access		:Protected
//
//	Arguments	: 
//						
//
//	Return		: datastore
//					
//						
//	Description	: Gets pending shipments from importedshipments table for (JB Hunt) and places in datastore
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:10/12/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							12/29/06, SAT, Added additional SCAC HJBI
//		
//////////////////////////////////////////////////////////////////////////////



DataStore		lds_Pending
String			ls_Scac

lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )

ls_Scac = THIS.cs_JBHuntScac

// lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and sendersCode = '" + ls_Scac + "'")
lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and ( sendersCode = '" + ls_Scac + "' OR sendersCode = 'HJBI') ")


RETURN lds_Pending
end function

protected function integer of_geteventstructure (ref string asa_eventtypes[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_geteventstructure
//  
//	Access		:Protected
//
//	Arguments	:string[]
//						types of events making up the shipment
//			
//
//	Return		:int # of events
//					
//						
//	Description	:translates the types of stops in the file to event types
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:10/19/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//
//	Hunt only uses 4 stop codes for intermodal and non intermodal shipments.
//
//	CL - Complete Load
//	PL - Partial Load
// CU - Complete Unload
// PU - Partial Unload
//
//	There is nothing to indicate a drop and pull move.
// We will always assume live pick up or delivery.
//
// In the case of an intermodal move, I use the move direction I, E, or O to 
// determine which event will be the hook or the drop.
//
//	Events for standard move should look like this. 
//
//	Import "HD"
//	Export "PR"
// OneWay "HR"
//
// Hunt does have multi-pickup and multi-deliver moves
//
// Import "HDD", "HDDD", etc..
//	Export "PPR", "PPPR", etc..
//


String	lsa_Events[]
Int		li_EventCount
Long		i
String	ls_CurrentEvent
String	ls_Direction
String	ls_Temp
Int		li_SegmentCount
	
n_cst_edisegment	lnva_Segments[]
	

IF THIS.of_Ismoveintermodal( ) THEN
	ls_Direction = THIS.of_GetMoveDirection ( )
	
	li_SegmentCount = THIS.of_Getsegments( "S5", lnva_Segments )
	
	FOR i = 1 TO li_SegmentCount
		
		lnva_Segments[i].of_getvalue( {2}, ls_Temp )
		
		CHOOSE CASE ls_Temp
								
			CASE  "PL" ,"CL"
				IF ls_Direction = "E" THEN
					// Move is an Export, event should be a pickup
					ls_CurrentEvent = gc_dispatch.cs_eventtype_pickup
				ELSE
					// Move is an Import or OneWay, event should be a hook
					ls_CurrentEvent = gc_dispatch.cs_eventtype_hook
				END IF
				
			CASE	"CU" , "PU"
				IF ls_Direction = "I" THEN
					// Move is an Import, event should be a deliver.
					ls_CurrentEvent =	gc_dispatch.cs_eventtype_deliver	
				ELSE
					// Move is an Export or OneWay, event should be drop
					ls_CurrentEvent = gc_dispatch.cs_eventtype_drop
				END IF
				
			CASE ELSE
				ls_CurrentEvent = gc_dispatch.cs_eventtype_misc
		END CHOOSE 
		
		li_EventCount ++
		lsa_Events[ li_EventCount ] = ls_CurrentEvent
		
	NEXT

ELSE  // not intermodal
	// Process the old way.

	
	li_SegmentCount = THIS.of_Getsegments( "S5", lnva_Segments )
	
	FOR i = 1 TO li_SegmentCount
		
		lnva_Segments[i].of_getvalue( {2}, ls_Temp )
		
		CHOOSE CASE ls_Temp
								
			CASE  "LD" ,"PL" ,"CL"
				ls_CurrentEvent = gc_dispatch.cs_eventtype_pickup
				
			CASE	"CU" , "PU" , "UL"
				ls_CurrentEvent =	gc_dispatch.cs_eventtype_deliver	
				
			CASE "PA" , "AL" ,"RT"
				ls_CurrentEvent = gc_dispatch.cs_eventtype_hook
				
			CASE "LE" , "SL", "SU" ,"DT" 
				
				ls_CurrentEvent = gc_dispatch.cs_eventtype_drop
				
			CASE "DR" 
			
				IF i = 1 THEN
					ls_CurrentEvent = gc_dispatch.cs_eventtype_hook
				ELSE
					ls_CurrentEvent = gc_dispatch.cs_eventtype_drop
				END IF
				
			CASE ELSE
				ls_CurrentEvent = gc_dispatch.cs_eventtype_misc
		END CHOOSE 
		
		li_EventCount ++
		lsa_Events[ li_EventCount ] = ls_CurrentEvent
		
	NEXT
	
END IF


asa_eventtypes[] = lsa_Events

RETURN li_EventCount

end function

protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_applyeventstructurelogic
//  
//	Access		:Protected
//
//	Arguments	:n_Cst_beo_event[]
//						this is the list of events existing in the shipment
//			
//
//	Return		:int
//						1 success
//						-1 falure
//			
//						
//	Description	: this where we try to figure out what type of move we are being sent and create the correct event structure in the 
//					  shipment. I.E. if we are only sent a Drop stop, we will then add the first implied hook and the implied Hook and drop 
//					  at the end of the shipment.
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:10/19/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//
// Because Hunt could send multi-pick or multi-deliver intermodal moves,
// I need to look at the move direction and the events.
//
// An export could look like "PPR", or "PPPR" etc.
// An import could look like "HDD", or "HDDD" etc.
// Still need to add the implied hook and drop events
//
// Don't add any events if move is non-intermodal.
//

Int		li_Return = 1
Int		li_EventCount
Int		i
Long		lla_NewEventIds[]
String	ls_CheckEvents
String	ls_ExistingEvents

n_cst_Beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnva_EventList[]
n_cst_beo_Event		lnv_Event
n_cst_edisegment 		lnva_segments[]
n_cst_edisegment 		lnva_segmentsResults[]
n_cst_edisegment 		lnva_FinalResults[]

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnva_EventList = anva_events[]
	li_EventCount = UpperBound ( lnva_EventList )
	
	FOR i = 1 TO li_EventCount 
		ls_ExistingEvents += UPPER ( lnva_EventList[i].of_GetType ( ) )
	NEXT
	
	IF len ( ls_ExistingEvents ) = 0 OR isNull ( ls_ExistingEvents ) THEN
		li_Return = -1
	END IF
END IF



IF li_Return = 1 THEN
	
	IF THIS.of_IsMoveIntermodal( ) THEN	
		
		lnv_Event = CREATE n_Cst_beo_Event
		lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventcache( ) )
		lnv_Event.of_SetAllowFilterSet ( TRUE ) 
		
		IF lnv_Shipment.of_getMovecode( ) = "E" THEN
			ls_CheckEvents = Right(ls_ExistingEvents, 2)
		ELSE
			ls_CheckEvents = Left(ls_ExistingEvents, 2)
		END IF
		
		CHOOSE CASE ls_CheckEvents
				
			CASE "R" // DROP
				
				lnv_Shipment.of_Addevents( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
				lnv_Shipment.of_Addevents( {'H','R'} , 3 , lnv_Dispatch , lla_NewEventIds )
				
				IF UpperBound ( lla_NewEventIds ) = 2 THEN
					
					lnv_Event.of_SetSourceID ( lla_NewEventIds[1] ) 				
					lnv_Event.of_Setimportreference( 1 )
					
					THIS.of_GetStopgroup( 2 , lnva_segments )
					THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
					
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
					
					lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
					lnv_Event.of_Setimportreference( 2 )
					THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
					
				END IF
				
			CASE "HR" // HOOK DROP
				// We should only see this during a One Way move, but I left it here in the event Hunt
				// begins sending drop and pull indicators.
				// Add second Hook and DROP  
				// only if this is not a one way
				IF lnv_Shipment.of_getMovecode( ) <> "O" THEN
				
				
					lnv_Shipment.of_Addevents( {'H','R'} , 3 , lnv_Dispatch , lla_NewEventIds )
					
					IF UpperBound ( lla_NewEventIds ) = 2 THEN
						
						lnv_Event.of_SetSourceID ( lla_NewEventIds[1] ) 				
						lnv_Event.of_Setimportreference( 2 )
						
						THIS.of_GetStopgroup( 2 , lnva_segments )
						THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
						
						THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
						
						lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
						THIS.of_GetSegments( "MS3", lnva_segmentsResults )		
						
						THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
										
					ELSE				
						li_Return = -1
					END IF
				END IF
				
			CASE "HD"  /*HOOK DELIVER*/ , "HP" // Hook Pickup
				// add drop to the end of the event list
				lnv_Shipment.of_Addevents ( {'R'} , ( li_EventCount + 1 ) , lnv_Dispatch , lla_NewEventIds )
				IF UpperBound ( lla_NewEventIds ) = 1 THEN
					// Look to first event for site information and set on new event
					lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
					THIS.of_getstopgroup( 1, lnva_segmentsResults )	
					// I'm looking to the N1 only to set the site and nothing else
					THIS.of_GetSegments( "N1",lnva_segmentsResults, lnva_FinalResults )
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_FinalResults )				
				END IF
				
			CASE "PR" // PickUp Drop
				// Add Hook as first event
				lnv_Shipment.of_Addevents ( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
				IF UpperBound ( lla_NewEventIds ) = 1 THEN
					// Look to last event for site information and set on new event
					lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
					THIS.of_GetStopgroup( li_EventCount , lnva_segmentsResults )
					// I'm looking to the N1 only to set the site and nothing else
					THIS.of_GetSegments( "N1",lnva_segmentsResults, lnva_FinalResults )
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_FinalResults )					
				END IF
				
			CASE ELSE // do nothing
				
				
		END CHOOSE
		
		
		DESTROY ( lnv_Event )
	ELSE
		// Don't do anything to non-intermodal shipment
	END IF
END IF

RETURN li_Return
end function

protected function integer of_setitemdataintermodal ();
Int		li_Return = 1
Int		li_SegmentCount
Int		li_ItemCount
Int		li_ItemGroup
String	ls_StopType
Int		li_Null
String	ls_Freight
String	ls_Acc
Dec {2}	lc_Freight
Dec {2}	lc_Acc

n_cst_edisegment	lnva_ItemSegments[]

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnva_ItemList[]
n_cst_beo_Item			lnva_EmptyItemList[]
SetNull ( li_Null )

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF	
END IF

// this needs to be re-thought
IF li_Return = 1 THEN

	
	IF THIS.of_GetSegments( "L3",lnva_ItemSegments) > 0 THEN
		/////////////////////////  FREIGHT ITEMS
		lnva_Itemsegments[ 1 ].of_getvalue( {5}, ls_Freight)
		IF IsNumber ( ls_Freight ) THEN
			lc_Freight = Dec ( Left ( ls_Freight , Len ( ls_Freight ) - 2 ) + "." + Right ( ls_Freight , 2 ) )		
		END IF
	
		IF lc_Freight > 0 THEN
			
			ids_itemmapping.SetFilter ( "itemtype = 'L' AND movetype = 'I'" )
			ids_itemmapping.Filter ()
			
			lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedFreight , lnva_ItemList)
			li_ItemCount = UpperBound ( lnva_ItemList ) 
			IF li_ItemCount > 0 THEN	// there should only be one of these
				
				IF THIS.of_setdataonbeo( lnva_ItemList[1], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Data could not be set on the Freight item" )
				END IF
				
				lnva_ItemList[1].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[1].of_setamount( lc_Freight )	
				DESTROY ( lnva_ItemList[1] )				
			END IF
				
		END IF
	
		/////////////////////////  ACC ITEMS

		
		lnva_ItemList = lnva_EmptyItemList
		lnva_Itemsegments[ 1 ].of_getvalue( {6}, ls_Acc)		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec ( Left ( ls_Acc , Len ( ls_Acc ) - 2 ) + "." + Right ( ls_Acc , 2 ) )
		END IF
		
		IF lc_Acc > 0 THEN
			ids_itemmapping.SetFilter ( "itemtype = 'A' AND movetype = 'I'" )
			ids_itemmapping.Filter ()
			
			lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedAcc , lnva_ItemList)
			li_ItemCount = UpperBound ( lnva_ItemList ) 
			IF li_ItemCount > 0 THEN	// there should only be one of these
				
				IF THIS.of_setdataonbeo( lnva_ItemList[1], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Data could not be set on the Accessorial item" )
				END IF
				lnva_ItemList[1].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[1].of_setamount( lc_Acc )	
				DESTROY ( lnva_ItemList[1] )
			END IF
			
		END IF
	
	END IF
	
	//
	
	
END IF
ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()


RETURN li_Return


end function

protected function integer of_addnonintermodalitems ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addnonintermodalItems
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		:Int
//						1 success
//						-1 failure					
//						
//	Description	: Creates non intermodal items and sets pickup and delivery indexes
//
//
//
// 	Written by	:Samule Towle
// 			Date	: 11/16/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							
//	
//////////////////////////////////////////////////////////////////////////////
//
// Hunt doesn't have a segment that can be used for item matching values.
// If there is a single pick with multi drops, or single drop with multi picks
// I can use the single event for the pickup or deliver indexes.
// If there are multi picks and multi drops, there will be no way to match pick 
// and deliver indexes unless the piece counts match.
//



Any		la_Value
Boolean	lb_UsePicks
Boolean	lb_FirstPick
int		li_PickupCount
int		li_DeliverCount
Int		li_StopCount
Int		li_Return = 1
Int		i
Int		li_LastDeliver
Int		li_FirstPick
Int		li_ItemIndex
Long		ll_NewItemID
String	ls_KeyValue
String	ls_KeySegment
String	ls_KeyElement
String	ls_StopType
String	ls_Value

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_cst_ediSegment		lnva_StopSegments[]



IF li_Return = 1 THEN
	IF THIS.of_Getitemmatchingvalues( ls_KeySegment , ls_KeyElement ) <> 1 THEN
		li_Return = -1
		THIS.of_AddError ( "Could not get the item matching values from the company profile." ) 
	END IF
END IF


IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch ( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Item = Create n_Cst_beo_Item
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetShipment ( lnv_Shipment )
	lnv_Item.of_SetAllowFilterSet ( TRUE ) 
END IF

IF li_Return = 1 THEN

	// Find out how many pickups and deliveries in shipment.
	// If single pickup with multi deliveries or single delivery with multiple pickup,
	// we will know the pickup or deliver index automatically. 
	li_StopCount = THIS.of_GetSegments( "S5",lnva_StopSegments)
	FOR i = 1 TO li_StopCount	
		THIS.of_GetStopgroup( i , lnva_StopSegments )
		IF THIS.of_Getvalue( "S5" , "2", "", lnva_StopSegments , la_Value ) = 1 THEN
			ls_StopType = STRING ( la_Value )
		ELSE
			CONTINUE
		END IF
		IF THIS.of_IsStopDeliverGroup ( ls_StopType ) THEN
			li_DeliverCount ++
			li_LastDeliver = i
		END IF
		IF THIS.of_IsStopPickupGroup ( ls_StopType ) THEN
			li_PickupCount ++
			IF li_PickupCount = 1 THEN
				IF NOT lb_FirstPick THEN
					li_FirstPick = i
					lb_FirstPick = TRUE
				END IF
			END IF
		END IF
	NEXT
	// Do we get data from picks or drops?
	IF li_PickupCount > li_DeliverCount THEN
		lb_UsePicks = TRUE
	ELSE
		lb_UsePicks = FALSE
	END IF
	// Try to use item matching for the stops to set pickup and deliver indexes.
	// If there is no matching segments, check to see which has the greater stop count.
	//
	// Use the first pickup as the pickup index and each delivery if there are more deliveries than pickups
	// Use the last deliver as the deliver index and each pickup if there are more pickups than deliveries
	FOR i = 1 TO li_StopCount		
		THIS.of_GetStopgroup( i , lnva_StopSegments )
		IF THIS.of_Getvalue( "S5" , "2", "", lnva_StopSegments , la_Value ) = 1 THEN
			ls_StopType = STRING ( la_Value )
		ELSE
			CONTINUE
		END IF
		IF lb_UsePicks THEN
			IF THIS.of_ISstoppickupgroup( ls_StopType ) THEN
				ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
				IF ll_NewItemID > 0 THEN
					lnv_Item.of_SetSourceID ( ll_NewItemID )
					lnv_Item.of_SetEventtypeflag( n_cst_Constants.cs_ItemEventType_ImportedFreight )
					lnv_Item.of_SetPuevent( i )
					
					THIS.of_GetStopGroup ( i, lnva_StopSegments )
					IF THIS.of_Getvalue ( ls_KeySegment, ls_KeyElement, "", lnva_StopSegments, la_Value ) = 1 THEN
						ls_KeyValue = STRING ( la_Value )
					ELSE
						CONTINUE
					END IF
					FOR li_ItemIndex = i + 1 to li_StopCount							
						THIS.of_GetStopGroup ( li_ItemIndex, lnva_StopSegments )
						IF THIS.of_Getvalue ( ls_KeySegment, ls_KeyElement, "", lnva_StopSegments, la_Value ) = 1 THEN
							ls_Value = STRING ( la_Value )
						ELSE
							CONTINUE
						END IF
						IF ls_Value = ls_KeyValue THEN
							lnv_Item.of_SetDelevent ( li_ItemIndex )
						END IF
					NEXT
					// If we don't match then set to last delivery.
					IF ISNULL (lnv_Item.of_GetDeliverEvent( ) ) THEN
						lnv_Item.of_SetDelEvent( li_LastDeliver )
					END IF
				ELSE
					li_Return = -1
					THIS.of_Adderror( "Could not create all freight items. " )
				END IF
			END IF
			// If it is a deliver, try to use item matching to set the deliver index.
		ELSE
			IF THIS.of_ISstopdelivergroup( ls_StopType ) THEN
				ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
				IF ll_NewItemID > 0 THEN
					lnv_Item.of_SetSourceID ( ll_NewItemID )
					lnv_Item.of_SetEventtypeflag( n_cst_Constants.cs_ItemEventType_ImportedFreight )
					lnv_Item.of_SetDelevent( i )
					THIS.of_GetStopGroup ( i, lnva_StopSegments )
					IF THIS.of_Getvalue ( ls_KeySegment, ls_KeyElement, "", lnva_StopSegments, la_Value ) = 1 THEN
						ls_KeyValue = STRING ( la_Value )
					ELSE
						CONTINUE
					END IF
					FOR li_ItemIndex = 1 to i - 1							
						THIS.of_GetStopGroup ( li_ItemIndex, lnva_StopSegments )
						IF THIS.of_Getvalue ( ls_KeySegment, ls_KeyElement, "", lnva_StopSegments, la_Value ) = 1 THEN
							ls_Value = STRING ( la_Value )
						ELSE
							CONTINUE
						END IF

						IF ls_Value = ls_KeyValue THEN
							lnv_Item.of_SetPuevent ( li_ItemIndex )
						END IF
					NEXT
					// If we don't find a match, set to first pickup
					IF ISNULL (lnv_Item.of_GetPickupEvent( ) ) THEN
						lnv_Item.of_SetPuEvent( li_FirstPick )
					END IF  
				ELSE
					li_Return = -1
					THIS.of_Adderror( "Could not create all freight items. " )
				END IF
			END IF
		END IF
		ll_NewItemID = 0
	NEXT
END IF

DESTROY ( lnv_Item )
RETURN li_Return


end function

protected function integer of_setitemdatanonintermodal ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_setitemdatanonintermodal
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		:Int
//						1 success
//						-1 failure					
//						
//	Description	: Determines which item populates with which stop info from transaction and sets data 
//						using item mapping.
//
//
// 	Written by	:Samule Towle
// 			Date	: 11/17/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							
//	
//////////////////////////////////////////////////////////////////////////////
//  We need to look to different segments to populate the item details for the intermodal 
//  and non intermodal shipments.  I have added an additional column to the Item Mapping
//  It contains a movetype column.  It uses a list box to select Intermodal (I) or Non-Intermodal (N)
//  Before we set the data using the mappings, I set the filter to use both the itemtype and movetype.
//
// There is only one charge indicated in the L3, I will set it on the first freight item.


Any		la_Value
Boolean	lb_LineHaulSet
Boolean	lb_UsePicks
Dec		lc_Fgt
Int		i	
Int		li_Return = 1
Int		li_ItemCount
Int		li_ItemGroup
Int		li_Null
Int		li_EventCount
Int		li_FreightInd
Int		li_EDIStop
Int		li_EventIndex
Int		li_StopCount
Int		li_DeliverCount
Int		li_PickupCount
Int		li_RefCheck
Long		ll_ImportRef
Long		ll_Origin
Long		ll_Dest
Long		ll_ValueCheck
String	ls_Freight
String	ls_StopType



n_cst_beo_Item			lnv_CurrentItem
n_cst_beo_Event		lnva_EventList[]
n_cst_edisegment		lnva_StopSegments[]
n_cst_edisegment		lnva_Segments[]
n_cst_edisegment		lnva_TestSegments[]
n_cst_beo_Event		lnv_Event
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnva_ItemList[]
n_cst_AnyArraySrv		lnv_Array


SetNull ( li_Null )
lb_LineHaulSet = False

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	
	IF lnv_Shipment.of_getOriginevent( lnv_Event ) = 1 THEN
		ll_Origin = lnv_Event.of_GetShipseq( )
		DESTROY ( lnv_Event )
	END IF
	
	IF lnv_Shipment.of_getDestinationEvent( lnv_Event ) = 1 THEN
		ll_Dest = lnv_Event.of_GetShipseq( )
		DESTROY ( lnv_Event )
	END IF
	
END IF

IF li_Return = 1 THEN
	
	// Get the freight charges if they exist
	THIS.of_GetSegments( "L3", lnva_Segments )
	lnva_segments[1].of_getvalue( {5} , ls_Freight )
	IF IsNumber ( ls_Freight ) THEN
		lc_Fgt = Dec ( Left ( ls_Freight , Len ( ls_Freight ) - 2 ) + "." + Right ( ls_Freight , 2 ) )	
	END IF
	
	// We are going to use the details for the largest stop type count.
	// If we have more pickups than deliveries, we'll set the item data from the pickup stops.
	// If we have an equal or greater number of deliveries, we'll use the item data from the deliveries.
	
	// Loop through the stops and count the pickups and delivers. 
	// Then use the greater of the two.
	
	li_StopCount = THIS.of_GetSegments( "S5",lnva_Segments)
	FOR i = 1 TO li_StopCount	
		
		THIS.of_GetStopgroup( i , lnva_Segments )
		IF THIS.of_Getvalue( "S5" , "2", "", lnva_Segments , la_Value ) = 1 THEN
			ls_StopType = STRING ( la_Value )
		ELSE
			CONTINUE
		END IF
		IF THIS.of_IsStopDeliverGroup ( ls_StopType ) THEN
			li_DeliverCount ++
		END IF
		IF THIS.of_IsStopPickupGroup ( ls_StopType ) THEN
			li_PickupCount ++
		END IF
	NEXT		

	IF li_PickupCount > li_DeliverCount THEN
		lb_UsePicks = TRUE
	ELSE
		lb_UsePicks = FALSE
	END IF
		
	//  Now we know which freight index (pickup or delivery) to look at when setting item details.	

//	li_EventCount = lnv_Shipment.of_GetEventlist( lnva_EventList )
	

	//  How many events do we have to set.	
	
	li_ItemCount = lnv_Shipment.of_Getitemsforeventtype( n_cst_constants.cs_ItemEventType_ImportedFreight  , lnva_ItemList)
	ids_itemmapping.SetFilter ( "itemtype = 'L' AND movetype = 'N'" )
	ids_itemmapping.Filter ()

	FOR li_ItemGroup = 1 TO li_ItemCount

		lnv_CurrentItem = lnva_ItemList[li_ItemGroup]
		
		// get the pickup or delivery index for the item.
		li_EDIStop = 0
		IF lb_UsePicks THEN
			li_FreightInd = lnv_CurrentItem.of_getpickupevent( )
		ELSE
			li_FreightInd = lnv_CurrentItem.of_getdeliverevent( )			
		END IF
		
		//  Find the event that matches the freight index and get it's import reference.  
		li_EventCount = lnv_Shipment.of_GetEventList(lnva_EventList ) 
		For li_EventIndex = 1 TO li_EventCount
			IF lnva_EventList[li_EventIndex].of_Getshipseq( ) = li_FreightInd THEN
				ll_ImportRef = lnva_EventList[li_EventIndex].of_Getimportreference( )
				//ls_ImportRef = STRING ( ll_ImportRef )
				EXIT
			END IF
		NEXT
		// Find the stop group with the matching import reference
		FOR li_RefCheck = 1 to li_EventCount
			IF THIS.of_GetStopgroup( li_RefCheck , lnva_TestSegments ) > 0 THEN
				IF THIS.of_Getvalue( "L11" , "1", "2=QN", lnva_TestSegments , la_Value ) = 1 THEN
					ll_ValueCheck = LONG ( la_Value )
				ELSE
					CONTINUE
				END IF
					
			END IF
			IF ll_ValueCheck = ll_ImportRef THEN
				li_EDIStop = li_RefCheck
				EXIT
			END IF
			
		NEXT
		//  If we don't find a stop group default to using the group that matches the freight index
		IF li_EDIStop = 0 THEN
			li_EDIStop = li_FreightInd
		END IF
		//  Get the stop group and set the item data			
		IF THIS.of_GetStopgroup( li_EDIStop , lnva_StopSegments ) > 0 THEN		
			THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping , lnva_StopSegments[] )
			IF NOT lb_LineHaulSet THEN 
				IF lc_Fgt >= 0  THEN
					lnv_CurrentItem.of_SetRateType ( 'F' )
					lnv_CurrentItem.of_SetAmount ( lc_Fgt )
				END IF
				lb_LineHaulSet = True
			END IF
		END IF
		
							
		DESTROY ( lnv_CurrentItem )
			
	NEXT	
END IF

lnv_Array.of_Destroy( lnva_EventList )

ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()


RETURN li_Return


end function

protected function boolean of_ismoveintermodal ();//////////////////////////////////////////////////////////////////////////////////
//
//		JB Hunt is not consistently sending an MS3 X when shipment is intermodal.
//		Using the N1_04 instead.  All terminals and piers with have a 2 digit qualifier
//		Checking N1_04 for a length of 2 and exiting early if I find one.
//
//		SAT 12/29/06
//
//////////////////////////////////////////////////////////////////////////////////


Boolean	lb_Return
Int		i
Int		li_SegmentCount
String	ls_Value

n_cst_edisegment	lnva_Segments[]

li_SegmentCount = THIS.of_Getsegments( "N1", lnva_Segments )

IF li_SegmentCount > 0 THEN
	FOR i = 1 to li_SegmentCount
		lnva_Segments[i].of_getvalue( {4}, ls_Value )
		IF LEN ( ls_Value ) = 2 THEN 
			lb_Return = TRUE
			
			EXIT
		END IF
	NEXT
END IF


RETURN lb_Return
end function

on n_cst_edishipment_manager_jb_hunt.create
call super::create
end on

on n_cst_edishipment_manager_jb_hunt.destroy
call super::destroy
end on

