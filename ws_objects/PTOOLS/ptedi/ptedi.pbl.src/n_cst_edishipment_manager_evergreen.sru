$PBExportHeader$n_cst_edishipment_manager_evergreen.sru
forward
global type n_cst_edishipment_manager_evergreen from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_evergreen from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_evergreen n_cst_edishipment_manager_evergreen

type variables
Constant String	cs_EvergreenScac = "EVERGREEN"
end variables

forward prototypes
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function datastore of_getpendingdatastore ()
protected function string of_getmovedirection ()
protected function boolean of_ismoveintermodal ()
protected function boolean of_isstopdelivergroup (string as_stoptype)
protected function boolean of_isstoppickupgroup (string as_stoptype)
protected function integer of_getstopgroup (integer ai_stop, ref n_cst_edisegment anva_segments[])
protected function integer of_setitemdataintermodal ()
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_cancelshipment ()
protected function integer of_prepareshipmentforupdate ()
protected function integer of_processshipmentdata ()
end prototypes

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
// 		Date	:03/31/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////



Int		li_EventCount
Long		i
Long		ll_Count
String	lsa_Events[]
String	ls_Value

	
n_cst_edisegment	lnva_Segments[]

THIS.of_GetSegments( "N9", lnva_Segments)

ll_Count = UpperBound ( lnva_Segments )
FOR i = 1 TO ll_Count
	
	lnva_segments[i].of_getvalue( {2} , ls_Value )
	
	CHOOSE CASE ls_Value
			
		CASE "CP", "EP", "LL", "LM", "OW", "RD", "RF", "TM" 
			// use this value as the move type indicator
			EXIT
			
	END CHOOSE
	
NEXT


IF i <= ll_Count THEN  // we left the loop early, and found a value to check

	CHOOSE CASE ls_Value

		CASE "CP", "EP", "OW" 	// CP = Chassis Reposition, EP = Empty Reposition, OW = One Way
			
			lsa_Events[1] = gc_dispatch.cs_eventtype_hook
			lsa_Events[2] = gc_dispatch.cs_eventtype_drop
			li_EventCount = 2
			
		CASE "LL", "LM", "RD"	// LL = Load out-Load back, LM = Load out-Empty Back, RD = Round Trip Drop
			
			lsa_Events[1] = gc_dispatch.cs_eventtype_hook
			lsa_Events[2] = gc_dispatch.cs_eventtype_drop
			li_EventCount = 2
		
		CASE "RF"	// RF = Round Trip Live 
		 	
			 IF THIS.of_getmovedirection( ) = "I" THEN
				 	lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_deliver
					li_EventCount = 2
					
				ELSEIF THIS.of_getmovedirection( ) = "E" THEN
					lsa_Events[1] = gc_dispatch.cs_eventtype_pickup
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					li_EventCount = 2
					
				ELSE
			END IF
						
			
		
		CASE "TM"	// Triangle Move
			
			//  This would appear to be what it sounds like.  
			//  A one way involving three pcs of equipment and three locations.
			//  Did not receive a sample from Evergreen for analysis
			
			lsa_Events[1] = gc_dispatch.cs_eventtype_hook
			lsa_Events[2] = gc_dispatch.cs_eventtype_drop
			lsa_Events[3] = gc_dispatch.cs_eventtype_hook
			lsa_Events[4] = gc_dispatch.cs_eventtype_drop
			lsa_Events[5] = gc_dispatch.cs_eventtype_hook
			lsa_Events[6] = gc_dispatch.cs_eventtype_drop
			li_EventCount = 6
		
	END CHOOSE
			
			

END IF
	// What do we want to do if we don't find one of these for some reason?

asa_eventtypes[] = lsa_Events

RETURN li_EventCount
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
//	Description	: Gets pending shipments from importedshipments table for (EVERGREEN) and places in datastore
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:03/31/2006
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

ls_Scac = THIS.cs_evergreenscac

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
//	Description	: Check for a One Way move first, If not found then Check for Import or Export move. 
//					  If we can't determine move then default to One Way.
//
//
// 	Written by	:Samuel Towle
// 		Date	:03/31/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////



Long		i
Long		ll_Count
String	ls_Value
String	ls_Direction
	
n_cst_edisegment	lnva_Segments[]
THIS.of_GetSegments( "N9", lnva_Segments)
ll_Count = UpperBound ( lnva_Segments )

FOR i = 1 TO ll_Count
	lnva_segments[i].of_getvalue( {2} , ls_Value )
	CHOOSE CASE ls_Value
		
		CASE "OW" 
			ls_Direction = cs_OneWay
			
			EXIT
			// We found a one way exit loop early.
		
	END CHOOSE
NEXT

//  If we don't find a one way look for inbound or outbound indicators.

IF Len ( ls_Direction ) = 0 THEN
	FOR i = 1 TO ll_Count
		lnva_segments[i].of_getvalue( {2} , ls_Value )
		CHOOSE CASE ls_Value		
			
			CASE "I"
				ls_Direction = cs_Import
				EXIT
				
			CASE "O"
				ls_Direction = cs_Export
				EXIT			
				
		END CHOOSE
		//  If we find a value exit loop early.  No need to continue.
		
		
	NEXT
END IF

// if we still did not find it them default to oneway
IF Len ( ls_Direction ) = 0 THEN
	ls_Direction = cs_OneWay
END IF


RETURN  ls_Direction	


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
//	Description	: Determine if move is intermodal.  We assume evergreen orders are always intermodal.
//					  
//
// 	Written by	:Samuel Towle
// 		Date	:03/31/2006
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
// 		Date	:03/31/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "DT" , "DZ"
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
// 		Date	:03/31/06
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////


Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "PU", "OT", "RZ"
		lb_Return = TRUE
		
	CASE ELSE
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
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
// 		Date	:03/31/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_TakeSegment
Int		li_Return
Int		li_StopSegments
Int		li_StopNumber
Long		ll_SegmentCount
Long		i
String	ls_CurrentSegment
String	ls_StopValue


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
			
			CASE "DT", "DZ", "PU", "OT", "RZ" 
				IF li_StopNumber = ai_stop THEN
					lb_TakeSegment = TRUE
				ELSE
					lb_TakeSegment = FALSE
				END IF
				li_StopNumber ++
					// These are the qualifiers we want.
					// Check to see if stop number matches the stop we are looking for
					
			CASE "BT", "CN", "SF", "SH"
				lb_TakeSegment = FALSE
					// ignore these qualifiers for the N1
					
		END CHOOSE	
		
	ELSEIF ls_CurrentSegment = "L3" OR ls_CurrentSegment = "SE" THEN
		lb_TakeSegment = FALSE
			// We are at the end of the transaction ignore these also
			
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
// 		Date	:03/31/06
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//										8/24/06 S.A.T.  removed IF statements to process item data
//                                    regardless of freight or accessorial charges.
//	
//////////////////////////////////////////////////////////////////////////////


Dec {2}	lc_Freight
Dec {2}	lc_Acc
Int		li_Return = 1
Int		li_ItemCount
Int		li_Null
String	ls_Freight
String	ls_Acc


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
		//Evergreen uses the 'charges' element 5 for freight charges S.A.T 3/28/06
		IF IsNumber ( ls_Freight ) THEN
			lc_Freight = Dec ( Left ( ls_Freight , Len ( ls_Freight ) - 2 ) + "." + Right ( ls_Freight , 2 ) )		
		END IF
	
		//IF lc_Freight > 0 THEN    //  S.A.T.  8/24/06 Removed because we want to do the mappings even without any amount.    
			
			ids_itemmapping.SetFilter ( "itemtype = 'L'" )
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
				
		//END IF    // S.A.T.  8/24/06
	
		/////////////////////////  ACC ITEMS
		
		lnva_ItemList = lnva_EmptyItemList
		lnva_Itemsegments[ 1 ].of_getvalue( {6}, ls_Acc)		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec ( Left ( ls_Acc , Len ( ls_Acc ) - 2 ) + "." + Right ( ls_Acc , 2 ) )
		END IF
		
		// IF lc_Acc > 0 THEN    //  S.A.T.  8/24/06 Removed because we want to do the mappings even without any amount.    

			ids_itemmapping.SetFilter ( "itemtype = 'A'" )
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
			
		// END IF    // S.A.T.  8/24/06
	
	END IF
	
	//
	
	
END IF
ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()


RETURN li_Return
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
// 		Date	:03/31/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////


Int		li_Return = 1
Int		li_EventCount
Int		i
Long		lla_NewEventIds[]
String	ls_ExistingEvents

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
			
		CASE "R" // DROP  /// we should not get this.
			
			lnv_Shipment.of_Addevents( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
			lnv_Shipment.of_Addevents( {'H','R'} , 3 , lnv_Dispatch , lla_NewEventIds )
			
			IF UpperBound ( lla_NewEventIds ) = 2 THEN
				
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] ) 				
				//lnv_Event.of_Setimportreference( 1 )
				
				THIS.of_GetStopgroup( 2 , lnva_segments )
				THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
				
				lnv_Event.of_SetSourceID ( lla_NewEventIds[2] )
				//lnv_Event.of_Setimportreference( 2 )
				
			END IF
			
		CASE "HR" // HOOK DROP	// WE EXPECT THIS ONE
			
			CHOOSE CASE THIS.of_GetMovedirection( )
					
				CASE cs_export
					// we are adding the event to the beginning of the existing events 
					// because this is an export shipment and we want to know about the 
					// hook at the cust and the drop at the ramp and the assigned numbers have
					// already been put on the last hook and drop.
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
										
				CASE cs_Import
					
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
				CASE cs_oneway
					
				CASE ELSE
					li_Return = -1
					
			END CHOOSE
		
			
		CASE "HD"  /*HOOK DELIVER   WE EXPECT THIS ONE */ , "HP" // Hook Pickup 
			// add drop
			lnv_Shipment.of_Addevents ( {'R'} , 3 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				THIS.of_getstopgroup( 1, lnva_segmentsResults )			
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )				
			END IF
			
		CASE "PR" // PickUp DroP ///// WE EXPECT THIS ONE
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

protected function integer of_cancelshipment ();//  4/27/06 S.A.T. 
// Evergreen does not use the B2_04 so we can't use it when processing a cancel.
// The shippers ID number, SID, is uniquely identified by the N9_02 element when the qualifier 01 = SI
// The import reference mapping for the shipment uses the N9 segment.
// Need to find the correct N9 segment and compare that value to the import reference.
Int		i
Int		li_Return
Long		ll_Count
String	ls_ImportReference
String	ls_Value

n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segment[]

li_Return = 1

IF li_Return = 1 THEN
	IF THIS.of_GetSegments ( "N9" , lnva_Segment ) > 0 THEN	// We should have an N9 
		ll_Count = UpperBound ( lnva_Segment )						// Get count of N9 segments

		FOR i = 1 TO ll_Count											// Loop through each N9
			lnva_segment[i].of_getvalue( {1} , ls_Value )
			CHOOSE CASE ls_Value
	
				CASE "SI" 														// When we find the SI qualifier
																					// Get the import reference  
					IF lnva_Segment[i].of_Getvalue( {2}, ls_ImportReference ) <> 1 THEN
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

protected function integer of_prepareshipmentforupdate ();//  4/27/06 S.A.T. 
// Evergreen does not use the B2_04 so we can't use it when processing a change.
// The shipment identifier, SID, is uniquely identified by the N9_02 element when the qualifie 01 = SI
// The import reference mapping for the shipment uses the N9 segment.
// Need to find the correct N9 segment and compare that value to the import reference


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
	IF THIS.of_GetSegments ( "N9" , lnva_Segment ) > 0 THEN	// We should have an N9 
		ll_Count = UpperBound ( lnva_Segment )						// Get count of N9 segments

		FOR i = 1 TO ll_Count											// Loop through each N9
			lnva_segment[i].of_getvalue( {1} , ls_Value )
			CHOOSE CASE ls_Value
		
			CASE "SI" 														// When we find the SI qualifier
																				// Get the import reference  
				IF lnva_Segment[i].of_Getvalue( {2}, ls_ImportReference ) <> 1 THEN
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

protected function integer of_processshipmentdata ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_ProcessShipmentData
//  
//	Access		:Protected
//
//	Arguments	:
//			
//
//	Return		:	1 Success, -1 Failure
//						
//						
//	Description	:  Parses selected data and sets data on shipment.
//					  
//
// 	Written by	:Samuel Towle
// 		Date	:09/14/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							
//							01/19/2007, SAT, Added code to reset releasedate and time values	
//												  to what they were on the ancestor.
//////////////////////////////////////////////////////////////////////////////


Int		i
Int		li_Return
Long		ll_Count
Long		ll_Length
Long		ll_Position
String	ls_Separator = '-'
String	ls_Temp
String	ls_Value
String	ls_Vessel
String	ls_Voyage

Date		ld_ReleaseDate
Time		lt_ReleaseTime

// Start JBiron - 11/29/06
Int		li_YearToday
String	ls_PUNumber
String	ls_LFDate
String	ls_LFDateTemp
String	ls_LFDateMonth
String	ls_LFDateDay
String	ls_LFDateYear
String	ls_TrimTemp
// End JBiron - 11/29/06

n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDISegment		lnva_Segment[]

li_Return = 1

//  Process ancestor script first
IF SUPER::Of_ProcessShipmentData() <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
		THIS.of_AddError ( "Could not create dispatch object." )
	END IF
END IF
//  Make sure shipment is valid
IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF Not IsValid ( lnv_Shipment ) THEN
		li_Return = -1
		THIS.of_AddError ( "Shipment returned was not valid.")
	END IF
END IF


IF li_Return = 1 THEN
	//  *** SAT 01/19/2007 ***
	//  As a result of setting the pickup number here, the release date/time is also set.
	//	 We are going to get the values if they have been set and restore them once the pickup is set.
	ld_ReleaseDate = lnv_Shipment.of_GetReleaseDate()
	lt_ReleaseTime = lnv_Shipment.of_GetReleaseTime()
	//  *** SAT 01/19/2007 ***
	
	
	//  Get list of N9 segments looking for the V3 which contains vessel and voyage separated by a hyphen '-'
	//  Vessel data is on the left, voyage data on the right.
	
	IF THIS.of_GetSegments ( "N9" , lnva_Segment ) > 0 THEN		// We should have an N9 
		ll_Count = UpperBound ( lnva_Segment )								// Get count of N9 segments

		FOR i = 1 TO ll_Count													// Loop through each N9
			lnva_segment[i].of_getvalue( {1} , ls_Value )
			CHOOSE CASE ls_Value
		
				CASE "V3" 																// When we find the V3 qualifier
																							// Parse the value  
					IF lnva_Segment[i].of_Getvalue( {2}, ls_Temp ) <> 1 THEN
						li_Return = -1
						THIS.of_AddError ( "Could not get value for Vessel / Voyage." )
					END IF				
					
					ll_Length = LEN ( ls_Temp )
					ll_Position = POS ( ls_Temp, ls_Separator )								// Search the string for hypen.
					IF ll_Position > 0 THEN																	// Found it.
						
						ls_Vessel = LEFT ( ls_Temp,( ll_Position - 1 ) ) 			
						lnv_SHipment.of_SetVessel ( ls_Vessel )
						
						ls_Voyage = RIGHT ( ls_Temp,( ll_Length - ll_Position ) ) 			
						lnv_SHipment.of_SetVoyage ( ls_Voyage )
									
					END IF
				
				//Start JBIRON - 11/29/06
				//Separate PU number and last free date passed in N9 with P8 qualifier
				//Also populates pickup by date with LFD value
				//If the LFD can not be figured out for any reason, the pickup number defaults to the whole string
				CASE "P8"
					IF lnva_Segment[i].of_Getvalue( {2}, ls_Temp ) <> 1 THEN
						li_Return = -1
						THIS.of_AddError ( "Could not get value for PU Number / Last Free Date / Pickup By Date." )
					END IF				

					ls_TrimTemp = TRIM ( ls_Temp )
					ll_Length = LEN ( ls_TrimTemp )
					
					CHOOSE CASE ll_Length
						
						//less than 19, we use the whole string
						CASE IS < 19
							ls_PUNumber = ls_TrimTemp
						
						//greater than 23, we use the whole string because we don't know what we're looking at
						CASE IS > 23
							ls_PUNumber = ls_TrimTemp
							
						CASE 19
							//Empty dates are passed as a "/".
							//Trim the slash and put the rest in pickup number
							IF RIGHT ( ls_TrimTemp, 1 ) = '/' THEN
								ls_PUNumber = TRIM ( LEFT ( ls_TrimTemp, 18 ) )
							ELSE
								ls_PUNumber = ls_TrimTemp
							END IF

						CASE ELSE // length = 20-23
							//Everything from character 19 on should be the LFD
							ls_LFDateTemp = RIGHT( ls_TrimTemp, ll_Length - 18 )

							//Assuming that the shortest date string can be 3
							//1 digit month, separator, 1 digit day
							IF LEN( TRIM ( ls_LFDateTemp ) ) > 2 THEN
								ls_Separator = '/'
								ll_Length = LEN ( ls_LFDateTemp )
								ll_Position = POS ( ls_LFDateTemp, ls_Separator )
								ls_LFDateMonth = LEFT ( ls_LFDateTemp, ( ll_Position - 1 ) )
								ls_LFDateDay = RIGHT ( ls_LFDateTemp, ( ll_Length - ll_Position ) )
								li_YearToday = YEAR ( TODAY() )
								
								IF isnumber ( ls_LFDateMonth ) AND isNumber ( ls_LFDateDay ) THEN																
									//We are assuming it is possible to get an LFD from the past.
									//Also assuming no LFD is more than 3 months in the future
									IF MONTH ( TODAY() ) - INTEGER( ls_LFDateMonth ) > 8 THEN
										ls_LFDateYear = String( li_YearToday + 1 )
									ELSE
										ls_LFDateYear = String( li_YearToday )
									END IF
							
									ls_LFDate = ls_LFDateMonth + "-" + ls_LFDateDay + "-" + ls_LFDateYear
								
									IF STRING ( DATE( ls_LFDate ) ) = '1/1/1900' THEN
										//Default to the whole string for pickup number
										ls_PUNumber = ls_TrimTemp
										THIS.of_AddError ( "Could not set Last Free Date and Pickup By Date." )
									ELSE
										ls_PUNumber = TRIM ( LEFT ( ls_TrimTemp, 18 ) )
										lnv_Shipment.of_setLastFreeDate ( DATE ( ls_LFDate ) )
										lnv_Shipment.of_setPickupByDate ( DATE ( ls_LFDate ) )
									END IF
									
								ELSE // not quite sure what we are lookin at
									ls_PUNumber = ls_TrimTemp									
								END IF
							ELSE
								//Default to the trimmed string
								ls_PUNumber = ls_TrimTemp
							END IF
						END CHOOSE
					
						lnv_Shipment.of_setPickupNumber ( ls_PUNumber )
						
						// *** SAT 01/19/2007 *** 
						// Resetting the release date and time to the values we began with.
						lnv_Shipment.of_setReleaseDate ( ld_ReleaseDate )
						lnv_Shipment.of_setReleaseTime ( lt_ReleaseTime )
						// *** SAT 01/19/2007 ***
						
				//END JBIRON - 11/29/06					
			END CHOOSE
		
		NEXT
		
	ELSE
		li_Return = -1
		THIS.of_AddError ( "Specified segment not found." )
	END IF

END IF

RETURN li_Return
end function

on n_cst_edishipment_manager_evergreen.create
call super::create
end on

on n_cst_edishipment_manager_evergreen.destroy
call super::destroy
end on

