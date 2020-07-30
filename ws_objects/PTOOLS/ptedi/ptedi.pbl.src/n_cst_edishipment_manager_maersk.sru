$PBExportHeader$n_cst_edishipment_manager_maersk.sru
forward
global type n_cst_edishipment_manager_maersk from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_maersk from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_maersk n_cst_edishipment_manager_maersk

type variables
Constant String	cs_MaerskScac = "MAEU"
end variables

forward prototypes
protected function datastore of_getpendingdatastore ()
protected function string of_getmovedirection ()
protected function integer of_getstopgroup (integer ai_stop, ref n_cst_edisegment anva_segments[])
protected function boolean of_ismoveintermodal ()
protected function boolean of_isstopdelivergroup (string as_stoptype)
protected function boolean of_isstoppickupgroup (string as_stoptype)
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_setitemdataintermodal ()
protected function integer of_addintermodalitemsifneeded ()
protected function integer of_processeventdata ()
protected function integer of_prepareshipmentforupdate ()
protected function integer of_cancelshipment ()
end prototypes

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
//	Description	: Gets pending shipments from importedshipments table for (Maersk) and places in datastore
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:04/06/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////



DataStore		lds_Pending
String			ls_Scac

lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )

ls_Scac = THIS.cs_MaerskScac

lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and sendersCode = '" + ls_Scac + "'")



RETURN lds_Pending
end function

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
// 		Date	:04/07/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////



Long		i
Long		ll_Count
Long		ll_StopCount
String	lsa_Events[]
String	ls_Value
String	ls_Direction
String	ls_StopCode
	
n_cst_edisegment	lnva_Segments[]


THIS.of_GetSegments( "AT5", lnva_Segments)
ll_Count = UpperBound ( lnva_Segments )

FOR i = 1 TO ll_Count
	lnva_segments[i].of_getvalue( {1} , ls_Value )
	CHOOSE CASE ls_Value
		
		CASE "EMT" 
			ls_Direction = cs_OneWay

		CASE "IP"
			ls_Direction = cs_Import
	
		CASE "XP"
			ls_Direction = cs_Export

		CASE "DM"
				// Domestic Move.  Inbound or Oubound move type yet to be determined.
				// Maersk believes we can use the length of the N1_04 to determine direction.
				// A len of 7 is a terminal or depot, a len of 5 is a customer.
						
				// Get all of the N1 segments
			THIS.of_GetSegments( "N1", lnva_Segments)
			ll_StopCount = UpperBound ( lnva_Segments )
			
				// Make sure we find at least 1 stop
			IF ll_StopCount > 0 THEN
				lnva_segments[1].of_getvalue( {4} , ls_StopCode )

				IF Len ( ls_StopCode ) = 7 THEN
					ls_Direction = cs_Import
						// If the first N1_04 is len 7 then it's a terminal and therefore an import.
				ELSE
					ls_Direction = cs_Export
						// IF the first N1_04 is not len 7 then it's a shipper and therefore an export.
				END IF
				
			ELSE  // We did not find any stops. use default of One-Way.  Should not see this.
			
			END IF

		CASE "TRM" 
			// Termination.  Type of move to be determined.
			// For now lets default to one way move.
			ls_Direction = cs_OneWay

	END CHOOSE
NEXT


// if we still did not find it them default to oneway
IF Len ( ls_Direction ) = 0 THEN
	ls_Direction = cs_OneWay
END IF


RETURN  ls_Direction	


end function

protected function integer of_getstopgroup (integer ai_stop, ref n_cst_edisegment anva_segments[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getstopgroup
//  
//	Access		:Protected
//
//	Arguments	: int - stop group you want
//						n_cst_edisegment [] -  the EDI segements that make up the requested stop group.
//
//	Return		: int # of segments that make up the stop group.
//					
//						
//	Description	: gets all the EDI segments that make up a specific stop group. (site, reason, items...)
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:04/06/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////


Int		li_Return
Int		li_StopSegments
int		li_StopNumber
Long		ll_SegmentCount
Long		i
Boolean	lb_TakeSegment
String	ls_CurrentSegment
string	ls_StopValue


n_cst_edisegment	lnva_StopSegments[]


ll_SegmentCount = UpperBound ( inva_segments )
li_StopNumber = 1

FOR i = 1 TO ll_SegmentCount	
		// Look through all segments
	ls_CurrentSegment = inva_segments[i].of_getsegmentid( )
	IF ls_CurrentSegment = "N1" THEN
			// Find all N1 segments
		inva_segments[i].of_getValue ( {1} , ls_StopValue  )
	
		CHOOSE CASE ls_StopValue
			
			CASE "CE", "SH", "UC" 
				IF li_StopNumber = ai_stop THEN
					lb_TakeSegment = TRUE
				ELSE
					lb_TakeSegment = FALSE
				END IF
				li_StopNumber ++
					// These are the qualifiers we want, check to see if stop number matches the stop we are looking for 
		END CHOOSE	
		
	ELSEIF ls_CurrentSegment = "S5" OR ls_CurrentSegment = "L5" OR ls_CurrentSegment = "SE" THEN
		lb_TakeSegment = FALSE
			// We are at the end of the transaction. These are not part of the stop group.
	END IF
	
	IF lb_TakeSegment THEN
		li_StopSegments ++
		lnva_StopSegments [ li_StopSegments ] =  inva_segments[i]
			// get all segments associated with stop segment  N1, N3, N4, etc
	END IF

NEXT

anva_segments[] = lnva_StopSegments
	// put in array and return the total number of segments for all stops
RETURN li_StopSegments

end function

protected function boolean of_ismoveintermodal ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_ismoveintermodal
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		:Boolean
//						
//						
//	Description	: Determine if move is intermodal.  We assume Maersk orders are always intermodal.
//					  
//
// 	Written by	:Samuel Towle
// 		Date	:04/06/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////



Boolean	lb_Return

lb_Return = TRUE

RETURN lb_Return

end function

protected function boolean of_isstopdelivergroup (string as_stoptype);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_isstopdelivergroup
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//

//	Return		:Boolean
//						
//						
//	Description	: Determine if event is a deliver type event.
//					  
//
// 	Written by	:Samuel Towle
// 		Date	:04/06/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "CE" , "UC"
		lb_Return = TRUE
		
	CASE ELSE
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
		
		
end function

protected function boolean of_isstoppickupgroup (string as_stoptype);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_isstoppickupgroup
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		:Boolean
//						
//						
//	Description	: Determine if event is a pickup type event.
//					  
//
// 	Written by	:Samuel Towle
// 		Date	:04/06/06
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////


Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "SH"
		lb_Return = TRUE
		
	CASE ELSE
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
end function

protected function integer of_geteventstructure (ref string asa_eventtypes[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_geteventstructure
//  
//	Access		:Protected
//
//	Arguments	:
//			
//
//	Return		:
//						
//						
//	Description	: Determine what type of move to create and get the correct event structure for the shipment.
//					  
//
// 	Written by	:Samuel Towle
// 		Date	:04/07/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							8/25/06  S.A.T.  Processing for One Way imports and exports.
//	
//////////////////////////////////////////////////////////////////////////////



Int		li_EventCount
Long		ll_Count
Long		i
String	ls_Value
String	lsa_Events[]


	
n_cst_edisegment	lnva_Segments[]

THIS.of_GetSegments( "AT5", lnva_Segments)

ll_Count = UpperBound ( lnva_Segments )
FOR i = 1 TO ll_Count
	
	lnva_segments[i].of_getvalue( {1} , ls_Value )
	
	CHOOSE CASE ls_Value
			
		CASE "DM", "EMT", "IP", "TRM", "XP"
			// These are our move type indicator
			EXIT  // Found one leave early
			
	END CHOOSE
	
NEXT


IF i <= ll_Count THEN  // we left the loop early, and found a value to check

	CHOOSE CASE ls_Value

		CASE "DM"	// DM = Domestic Move, Use Movedirection to determine inbound or outbound.
			
			IF THIS.of_getmovedirection( ) = "I" THEN // if import use this structure
				 	lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_deliver
					li_EventCount = 2
					
				ELSEIF THIS.of_getmovedirection( ) = "E" THEN // if export use this structure
					lsa_Events[1] = gc_dispatch.cs_eventtype_pickup
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					li_EventCount = 2
					
				ELSE
			END IF
		
		CASE "EMT" 	//  EMT = Empty Reposition
			
			lsa_Events[1] = gc_dispatch.cs_eventtype_hook
			lsa_Events[2] = gc_dispatch.cs_eventtype_drop
			li_EventCount = 2

// ***** S.A.T Added 8/25/06 Additional processing for 'OW' OneWay and 'RT' RoundTrip			
//			
//
//		CASE "IP"	// IP = Import Live 
//
//			lsa_Events[1] = gc_dispatch.cs_eventtype_hook
//			lsa_Events[2] = gc_dispatch.cs_eventtype_deliver
//			li_EventCount = 2	
//						
//
//		CASE "XP"	// XP = Export Live
//
//			lsa_Events[1] = gc_dispatch.cs_eventtype_pickup
//			lsa_Events[2] = gc_dispatch.cs_eventtype_drop
//			li_EventCount = 2	
//						
//
		CASE "IP"	// IP = Import 			

		 	THIS.of_GetSegments( "L11", lnva_Segments)
			ll_Count = UpperBound ( lnva_Segments )
			
			FOR i = 1 TO ll_Count
				
				lnva_segments[i].of_getvalue( {1} , ls_Value )
				
				CHOOSE CASE ls_Value
						
					CASE "RT"  // Round Trip move use Hook & Deliver
						
						lsa_Events[1] = gc_dispatch.cs_eventtype_hook
						lsa_Events[2] = gc_dispatch.cs_eventtype_deliver
						li_EventCount = 2	
						
					CASE "OW"  // One way move use Hook & Drop
						
						lsa_Events[1] = gc_dispatch.cs_eventtype_hook
						lsa_Events[2] = gc_dispatch.cs_eventtype_drop
						li_EventCount = 2	
												
				END CHOOSE
				
			NEXT

		CASE "XP"	// XP = Export

		 	THIS.of_GetSegments( "L11", lnva_Segments)
			ll_Count = UpperBound ( lnva_Segments )
			
			FOR i = 1 TO ll_Count
				
				lnva_segments[i].of_getvalue( {1} , ls_Value )
				
				CHOOSE CASE ls_Value
						
					CASE "RT"  // Round Trip move use Pickup & Drop
						
						lsa_Events[1] = gc_dispatch.cs_eventtype_pickup
						lsa_Events[2] = gc_dispatch.cs_eventtype_drop
						li_EventCount = 2	
									
					CASE "OW"  // One way move use Hook & Drop
						
						lsa_Events[1] = gc_dispatch.cs_eventtype_hook
						lsa_Events[2] = gc_dispatch.cs_eventtype_drop
						li_EventCount = 2	
												
				END CHOOSE
				
			NEXT
			
// *************************************  END of changes 8/25/06
	
	CASE "TRM"	// TRM = Termination
			
			//  Waiting for Maersk to explain a termination and all that entails.
			//  Going to treat it like a one way.
			
			lsa_Events[1] = gc_dispatch.cs_eventtype_hook
			lsa_Events[2] = gc_dispatch.cs_eventtype_drop
			li_EventCount = 2
			
		
	END CHOOSE
			
			

END IF
	// What do we want to do if we don't find one of these for some reason?

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
// 		Date	:04/07/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							8/25/06 S.A.T.  Conditional processing for ONE WAY imports and exports.
//	
//////////////////////////////////////////////////////////////////////////////

Int		li_Return = 1
Int		li_EventCount
Int		i
Int		j
Long		ll_count
Long		lla_NewEventIds[]
String	ls_ExistingEvents
String	ls_Value


n_cst_Beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnva_EventList[]
n_cst_beo_Event		lnv_Event
n_cst_edisegment 		lnva_segments[]
n_cst_edisegment 		lnva_segmentsResults[]

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
	
	lnv_Event = CREATE n_Cst_beo_Event
	lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventcache( ) )
	lnv_Event.of_SetAllowFilterSet ( TRUE ) 
	
	CHOOSE CASE ls_ExistingEvents
			
		CASE "HR" // HOOK DROP
			
			CHOOSE CASE THIS.of_GetMovedirection( )
				
				//*******************S.A.T. 8/25/06
				//
				// Have to make a change here to compensate for Maersks ONEWAY-IMPORT and ONEWAY-EXPORT moves
				// Need to check L11 segments for an 'OW' One Way or a 'RT' Round Trip flag.
				// If Round Trip we add the implied events to the shipment.
				// If One Way we only want the Hook and Drop we come in with.
				//
				//
				//				CASE cs_export
				//					
				//					lnv_Shipment.of_Addevents( {'H','R'} , 1 , lnv_Dispatch , lla_NewEventIds )
				//					IF Upperbound ( lla_NewEventIds ) = 2 THEN
				//						lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				//						
				//						THIS.of_GetStopgroup( 2 , lnva_segments )	
				//						THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
				//						
				//						
				//						lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
				//						THIS.of_GetStopgroup( 1 , lnva_segments )		
				//						THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
				//						
				//					ELSE
				//						li_Return = -1
				//					END IF
				//										
				//				CASE cs_Import
				//					
				//					lnv_Shipment.of_Addevents( {'H','R'} , 3 , lnv_Dispatch , lla_NewEventIds )
				//					IF Upperbound ( lla_NewEventIds ) = 2 THEN
				//						lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				//						
				//						THIS.of_GetStopgroup( 2 , lnva_segments )		
				//						THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
				//						
				//						
				//						lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
				//						THIS.of_GetStopgroup( 1 , lnva_segments )		
				//						THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
				//					ELSE 
				//						li_Return = -1
				//					END IF
				//					
					
				CASE cs_export
					
					// we are adding the event to the beginning of the existing events 
					// because this is an export shipment and we want to know about the 
					// hook at the cust and the drop at the ramp and the assigned numbers have
					// already been put on the last hook and drop.
					
					THIS.of_GetSegments( "L11", lnva_Segments)
					ll_Count = UpperBound ( lnva_Segments )
					
					FOR j = 1 TO ll_Count
						
						lnva_segments[j].of_getvalue( {1} , ls_Value )
						
						CHOOSE CASE ls_Value
								
							CASE "RT"  // Round Trip 
								
								lnv_Shipment.of_Addevents( {'H','R'} , 1 , lnv_Dispatch , lla_NewEventIds )
								IF Upperbound ( lla_NewEventIds ) = 2 THEN
									lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
									
									THIS.of_GetStopgroup( 2 , lnva_segments )	
									THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
									
									
									lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
									THIS.of_GetStopgroup( 1 , lnva_segments )		
									THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
									
								ELSE
									li_Return = -1
								END IF
																	
							CASE "OW"  // One way move only use Hook & Drop we came in with 
																				
						END CHOOSE
						
					NEXT
													
				CASE cs_Import
					
					THIS.of_GetSegments( "L11", lnva_Segments)
					ll_Count = UpperBound ( lnva_Segments )
						
					FOR j = 1 TO ll_Count
						
						lnva_segments[j].of_getvalue( {1} , ls_Value )
						
						CHOOSE CASE ls_Value
								
							CASE "RT"  // Round Trip move add the implied events

								lnv_Shipment.of_Addevents( {'H','R'} , 3 , lnv_Dispatch , lla_NewEventIds )
								IF Upperbound ( lla_NewEventIds ) = 2 THEN
									lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
									
									THIS.of_GetStopgroup( 2 , lnva_segments )		
									THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
									
									
									lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
									THIS.of_GetStopgroup( 1 , lnva_segments )		
									THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segments )
								ELSE 
									li_Return = -1
								END IF
																			
							CASE "OW"  // One way move only use Hook & Drop we came in with.
								
						END CHOOSE
						
					NEXT
					//*****************   End Changes S.A.T 8/25/06
				CASE cs_oneway
					
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
		
			
		CASE "HD"  /*HOOK DELIVER  */ , "HP" // HOOK PICKUP 
			// add drop
			lnv_Shipment.of_Addevents ( {'R'} , 3 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				THIS.of_getstopgroup( 1, lnva_segmentsResults )			
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )				
			END IF
			
		CASE "PR" // PICKUP DROP 
			// Add First hook
			lnv_Shipment.of_Addevents ( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN					
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				THIS.of_GetStopgroup( 2 , lnva_segmentsResults )		
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )					
			END IF
			
		CASE ELSE // do nothing
			
			
	END CHOOSE
	
	
	DESTROY ( lnv_Event )
	
END IF

RETURN li_Return
end function

protected function integer of_setitemdataintermodal ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_setitemdataintermodal
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		:integer
//						
//						
//	Description	: Determine what data we use for freight and accessorial items.
//					  
//
// 	Written by	:Samuel Towle
// 		Date	:04/XX/06
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

//  Maersk uses an individual OID segment for each line item.
//  There may be more than one freight and accessory line item in an order.
//  There is no item number provided.
//
//	 OID_01 contains the specific authorization code for the item.
//	 OID_02 is the work order number.  This is the same for all items.
//	 OID_03 is the charge code "400" = freight, "GASFL" "VARFL", "DETDT", etc = acc.
//	 OID_04 is always "C5" cost.  This is the same for all items.
//	 OID_05 is the dollar amount.


Dec {2}	lc_Freight
Dec {2}	lc_Acc
Int		i
Int		li_Count
Int		li_Return = 1
Int		li_ItemCount
Int		li_Null
Int		li_AccItemCount
Int		li_FreightItemCount
String	ls_Freight
String	ls_Acc
String	ls_ReferenceID


n_cst_edisegment	lnva_ItemSegments[]
n_cst_edisegment	lnva_FreightSegments[]
n_cst_edisegment	lnva_AccessorialSegments[]

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


IF li_Return = 1 THEN

	
	IF THIS.of_GetSegments( "OID",lnva_ItemSegments) > 0 THEN
		// We have items
		
		li_Count = UpperBound ( lnva_ItemSegments )
		// We have total number of items
		
		// Get the count of freight and count of accessorial items place into Freight array and Accessorial array
		FOR i = 1 TO li_Count
			lnva_ItemSegments[i].of_getvalue( {3} , ls_ReferenceID )
			IF ls_ReferenceID = "400" THEN
				li_FreightItemCount ++
				lnva_FreightSegments[ li_FreightItemCount ] = lnva_ItemSegments [i]
			ELSE
				li_AccItemCount ++
				lnva_AccessorialSegments[ li_AccItemCount ] = lnva_ItemSegments [i]
			END IF
		NEXT
		
		//  Filter the item list to Freight Items
		ids_itemmapping.SetFilter ( "itemtype = 'L'" )
		ids_itemmapping.Filter ()
		lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedFreight , lnva_ItemList)
				
		//  The counts for the "imported freight" items should match li_FreightItemCount
		//  Don't set freight items if count is not equal.
		
		li_ItemCount = UpperBound ( lnva_ItemList ) 
		IF li_ItemCount = li_FreightItemCount THEN					
			FOR i = 1 to li_FreightItemCount
				lnva_Freightsegments[i].of_getvalue( {5}, ls_Freight)		
		
				IF IsNumber ( ls_Freight ) THEN
					lc_Freight = Dec ( ls_Freight )		
				END IF
			
				// First set data using the entire segment list 
				// Necessary if we want any other segment data to populate into items
				// Such as L5 and AT8 segments where the description and weight are obtained.
			
				// *** if there is more than 1 freight item, what do we set the weight on? ***
			
				IF THIS.of_setdataonbeo( lnva_ItemList[i], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Generic Data could not be set on the Freight item" )
				END IF
		
				// Set the data for the freight items using item mapping for the individal rows 			
				
				IF THIS.of_setdataonbeo( lnva_ItemList [i] , ids_itemmapping , {lnva_FreightSegments[i]} ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Specific Data could not be set on the Freight item" )
				END IF
				
				//	Set Rate type and amount here not in mappings
				lnva_ItemList[i].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[i].of_setamount( lc_Freight )	
	
				DESTROY ( lnva_ItemList[i] )
				
			NEXT
		ELSE
			//  Add error message
			li_Return = -1
			THIS.of_AddError( "Could not set data on Freight Items.  Item counts are not equal" )
		END IF
		
		lnva_ItemList = lnva_EmptyItemList
		
		ids_itemmapping.SetFilter ( "itemtype = 'A'" )
		ids_itemmapping.Filter ()
		lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedAcc , lnva_ItemList)	

		//  The counts for the "imported accessorial" items should match li_AccItemCount
		//  Don't set freight items if count is not equal.
		
		li_ItemCount = UpperBound ( lnva_ItemList ) 
		IF li_ItemCount = li_AccItemCount THEN					
			FOR i = 1 to li_AccItemCount
				lnva_Accessorialsegments[i].of_getvalue( {5}, ls_Acc)
				
				IF IsNumber ( ls_Acc ) THEN
					lc_Acc = Dec ( ls_Acc )
				END IF
				
				IF THIS.of_setdataonbeo( lnva_ItemList[i], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Generic data could not be set on the Accessorial item" )
				END IF
	
				// Set the data for the accessory items using item mapping for the individual rows.			
				
				IF THIS.of_setdataonbeo( lnva_ItemList [i] , ids_itemmapping , {lnva_AccessorialSegments[i]} ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Specific data could not be set on the Freight item" )
				END IF
			
					//	Set Rate type and amount here not in mappings
				lnva_ItemList[i].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[i].of_setamount( lc_Acc )
				
				DESTROY ( lnva_ItemList[i] )
				
			NEXT
		ELSE
			// Add error message
			li_Return = -1
			THIS.of_AddError( "Could not set data on Accessorial Items.  Counts not equal" )
		END IF
	END IF
	
END IF
ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()

RETURN li_Return


end function

protected function integer of_addintermodalitemsifneeded ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addintermodalitemsifneeded
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		:Int 
//					1 = success
//					-1 = Failure
//					
//						
//	Description	: It will see if more items need to be added to the shipment.
//
//
// 	Written by	:Samuel Towle
// 		Date	:04/14/06
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

	
Int		li_ItemCount
Int		li_Return = 1
Int		i
Int		li_AccItemCount
Int		li_FreightItemCount
Int		li_FreightCount
Int		li_AccCount
Long		ll_NewItemID
String	ls_Acc
String	ls_ItemType



n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_csT_beo_Item			lnva_Items[]
n_cst_ediSegment		lnva_ItemSegments[]
n_cst_AnyArraySrv		lnv_ArraySrv

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
	li_FreightCount = lnv_Shipment.of_GetItemsforeventtype( n_Cst_Constants.cs_itemeventtype_importedfreight, lnva_Items )
	lnv_ArraySrv.of_Destroy( lnva_Items )
	li_AccCount	= lnv_Shipment.of_GetItemsforeventtype( n_Cst_Constants.cs_itemeventtype_importedacc , lnva_Items )
	lnv_ArraySrv.of_Destroy( lnva_Items )
END IF

IF li_Return = 1 THEN
	lnv_Item = Create n_Cst_beo_Item
	lnv_Item.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
	lnv_Item.of_SetShipment ( lnv_Shipment )
	lnv_Item.of_SetAllowFilterSet ( TRUE ) 
END IF
//	We need to find out how many freight and acc items in the transaction then compare it to the shipment.
// Then add what is needed.
IF li_Return = 1 THEN
	li_ItemCount = THIS.of_GetSegments( "OID",lnva_ItemSegments)

	FOR i = 1 TO li_ItemCount		
		lnva_Itemsegments[ i ].of_getvalue( {3}, ls_ItemType)
		IF ls_ItemType = "400" THEN
			li_FreightItemCount ++
		ELSE
			li_AccItemCount ++
		END IF
	NEXT	
	
	
	FOR i = 1 TO li_ItemCount		
		lnva_Itemsegments[ i ].of_getvalue( {3}, ls_Acc)
		//  If there are more freight items in the txn than on the shipment, add another freight item.
		IF ls_Acc = "400" AND li_FreightCount < li_FreightItemCount THEN	
			ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedfreight )	
				li_FreightCount ++
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create a freight item. " )
			END IF
		END IF
		// If ther are more accessory items in the txn than on the shipment, add another accessory item.
		IF ls_Acc <> "400" AND li_AccCount < li_AccItemCount THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "A" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedacc )	
				li_AccCount ++
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create an accessorial item. " )
			END IF
		END IF
			
	NEXT
END IF


DESTROY ( lnv_Item )
RETURN li_Return

end function

protected function integer of_processeventdata ();Any		la_Value
Int		li_Return = 1
Int		li_EventCount
Int		li_Seq
Int		i
String	ls_Filter
String	ls_type


n_cst_edisegment	lnva_Segments[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Event		lnva_Events[]


IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_getshipment( )
	IF NOT isValid ( lnv_Shipment ) THEN
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN 
	li_EventCount = lnv_SHipment.of_GetEventList ( lnva_Events )	
END IF

IF li_Return = 1 THEN
	
	
	//  Loop through the events and set fields using data specific to the stop group segments
	FOR i = 1 TO li_EventCount
		//  Check to see if the event is confirmed
		IF isValid ( lnva_Events[i] ) THEN
			IF lnva_Events[i].of_IsConfirmed( ) THEN
				CONTINUE 
			END IF
			lnva_Events[i].of_SetAllowFilterSet ( TRUE )
			// this gets access to the specific stop group
			THIS.of_Getstopgroup( lnva_Events[i].of_GetImportReference( ) , lnva_Segments )	
			IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
				li_Return = -1
			END IF
		END IF
			
	NEXT		
	
	//  Now loop through the events and try to set fields using data from all segments
	//	 For Maersk this is the pickup and delivery date and times.
	
	//	 Only want to set the appt data and times on events that have an import reference.
	
	FOR i = 1 TO li_EventCount
		IF isValid ( lnva_Events[i] ) THEN
			IF lnva_Events[i].of_IsConfirmed( ) THEN
				CONTINUE 
			END IF
		
			lnva_Events[i].of_SetAllowFilterSet ( TRUE )
			
			//  Check to see if there is an import reference.  IF yes then filter and set data.
		
	
			IF NOT ISNULL ( lnva_Events[i].of_GetImportReference( ) ) THEN	
				
				ls_Type = lnva_Events[i].of_Gettype ( )								// Gets the event type
				li_Seq = lnva_Events[i].of_GetShipSeq ( )								// Gets the the event number sequence
				ls_Filter = "Eventtype = '" +  ls_Type + String (li_Seq) + "'"	// builds filter "H1", "R2" etc.
				ids_Eventmapping.SetFilter( ls_Filter )								// Sets filter
				ids_Eventmapping.Filter ( )												// Applies filter
		
				IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping ) <> 1 THEN  
					li_Return = -1
				END IF			
			END IF

//			DESTROY ( lnva_Events[i] )
		END IF
	NEXT
END IF

n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_Destroy(lnva_Events)



RETURN li_Return










end function

protected function integer of_prepareshipmentforupdate ();//  4/26/06 S.A.T. 
// Maersk repeats the work order number in the B2_04 so we can't use it when processing a change.
// The container is uniquely identified by the L11_01 element when the qualifie 02 = ZH
// The import reference mapping for the shipment uses the L11 segment.
// Need to find the correct L11 segment and compare that value to the import reference


Int		li_Return
Int		i
Long		ll_Count
String	ls_ImportReference
String	ls_Value


n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segment[]
n_cst_beo_Item			lnva_Items[]
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event

lnv_Event = CREATE n_cst_beo_Event

li_Return = 1
IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_GetDispatch ( )
	IF NOT IsValid( lnv_Dispatch) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_GetShipment ( )
	IF NOT IsValid( lnv_Shipment) THEN
		li_Return = -1
	END IF
END IF
		

IF li_Return = 1 THEN
	IF THIS.of_GetSegments ( "L11" , lnva_Segment ) > 0 THEN	// We should have an L11 
		ll_Count = UpperBound ( lnva_Segment )						// Get count of L11

		FOR i = 1 TO ll_Count											// Loop through each L11
			lnva_segment[i].of_getvalue( {2} , ls_Value )
			CHOOSE CASE ls_Value
		
			CASE "ZH" 														// When we find the ZH qualifier
																				// Get the import reference  
				IF lnva_Segment[i].of_Getvalue( {1}, ls_ImportReference ) <> 1 THEN
					li_Return = -1
				END IF				

			END CHOOSE
		NEXT

	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN

	IF THIS.of_Initializeexistingshipment( ls_ImportReference ) <> 1 THEN
		li_Return = -1
	END IF

END IF

IF li_Return = 1 THEN
	THIS.of_AddIntermodalitemsifneeded( )
END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end function

protected function integer of_cancelshipment ();//  4/27/06 S.A.T. 
// Maersk repeats the work order number in the B2_04 so we can't use it when processing a cancel.
// The container, AKA shipment, is uniquely identified by the L11_01 element when the qualifier 02 = ZH
// The import reference mapping for the shipment uses the L11 segment.
// Need to find the correct L11 segment and compare that value to the import reference.



Int		i
Int		li_Return
Long		ll_Count
String	ls_ImportReference
String	ls_Value

n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segment[]

li_Return = 1

IF li_Return = 1 THEN
	IF THIS.of_GetSegments ( "L11" , lnva_Segment ) > 0 THEN	// We should have an L11 
		ll_Count = UpperBound ( lnva_Segment )						// Get count of L11 segments

		FOR i = 1 TO ll_Count											// Loop through each L11
			lnva_segment[i].of_getvalue( {2} , ls_Value )
			CHOOSE CASE ls_Value
		
			CASE "ZH" 														// When we find the ZH qualifier
																				// Get the import reference  
				IF lnva_Segment[i].of_Getvalue( {1}, ls_ImportReference ) <> 1 THEN
					li_Return = -1
				END IF				

			END CHOOSE
		NEXT

	ELSE
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_Initializeexistingshipment( ls_ImportReference ) <> 1 THEN
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
	IF lnv_Shipment.of_SetStatus ( gc_dispatch.cs_shipmentstatus_cancelled ) <> 1 THEN
		THIS.of_AddError ( "Could not set the status to cancelled for shipment " + String ( lnv_Shipment.of_GetID ( ) )+ "." )
	END IF
END IF


RETURN li_Return
end function

on n_cst_edishipment_manager_maersk.create
call super::create
end on

on n_cst_edishipment_manager_maersk.destroy
call super::destroy
end on

