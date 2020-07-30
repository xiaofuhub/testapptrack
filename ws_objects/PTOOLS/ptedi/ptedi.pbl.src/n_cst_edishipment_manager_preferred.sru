$PBExportHeader$n_cst_edishipment_manager_preferred.sru
forward
global type n_cst_edishipment_manager_preferred from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_preferred from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_preferred n_cst_edishipment_manager_preferred

type variables
Constant String	cs_PreferredScac = "7323242000"
end variables

forward prototypes
protected function datastore of_getpendingdatastore ()
protected function boolean of_ismoveintermodal ()
protected function integer of_getstopgroup (integer ai_stop, ref n_cst_edisegment anva_segments[])
protected function boolean of_isstopdelivergroup (string as_stoptype)
protected function boolean of_isstoppickupgroup (string as_stoptype)
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_processeventdata ()
protected function integer of_addnonintermodalitems ()
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
//	Description	: Gets pending shipments from importedshipments table for 
//					  Preferred Freezer and places in datastore
//
//
// 	Written by	:Samuel Towle
// 		Date	:06/22/2006
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

ls_Scac = THIS.cs_PreferredScac

lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and sendersCode = '" + ls_Scac + "'")



RETURN lds_Pending
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
// 		Date	:06/22/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////



Boolean	lb_Return

lb_Return = FALSE

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
// 		Date	:06/22/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_TakeSegment
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
			
			CASE "ST", "SF" //  Headwater changed from CN to ST.
				IF li_StopNumber = ai_stop THEN
					lb_TakeSegment = TRUE
				ELSE
					lb_TakeSegment = FALSE
				END IF
				li_StopNumber ++
					// These are the qualifiers we want.
					// Check to see if stop number matches the stop we are looking for
					
			CASE "DE"
				lb_TakeSegment = FALSE
					// ignore these qualifiers for the N1
					
		END CHOOSE	
		
	ELSEIF ls_CurrentSegment = "S5" OR ls_CurrentSegment = "LAD" OR ls_CurrentSegment = "L3" OR ls_CurrentSegment = "SE" THEN
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

protected function boolean of_isstopdelivergroup (string as_stoptype);


Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "ST"
		lb_Return = TRUE
		
	CASE ELSE
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
		
		
		
end function

protected function boolean of_isstoppickupgroup (string as_stoptype);


Boolean	lb_Return

CHOOSE CASE as_stoptype
		
		
	CASE "SF"
		lb_Return = TRUE
		
	CASE ELSE
		lb_Return = FALSE
		
END CHOOSE

RETURN lb_Return
		
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
// 		Date	:06/22/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

//	Preferred sends a total of 3 N1 segments.  The first is a DE qualifier which is not part of the event 
//	Structure.  Next is the SF and the ST which are part of the event structure.
//	Ignore anything that is not an SF or a ST
//	Do not add to event count if not an SF or ST


Int		li_SegmentCount
Int		li_EventCount
Long		i
String	ls_CurrentEvent
String	ls_Temp
String	lsa_Events[]

	
n_cst_edisegment	lnva_Segments[]
	
li_SegmentCount = THIS.of_Getsegments( "N1", lnva_Segments )

FOR i = 1 TO li_SegmentCount
	
	lnva_Segments[i].of_getvalue( {1}, ls_Temp )
	
	CHOOSE CASE ls_Temp
							
		CASE  "SF"
			ls_CurrentEvent = gc_dispatch.cs_eventtype_pickup
			li_EventCount ++
			lsa_Events[ li_EventCount ] = ls_CurrentEvent
			
		CASE	"ST"
			ls_CurrentEvent =	gc_dispatch.cs_eventtype_deliver	
			li_EventCount ++
			lsa_Events[ li_EventCount ] = ls_CurrentEvent
	
	END CHOOSE 

NEXT
	
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
//	Description	: In Preferred Freezer, they send the pickup at the freezer
//					  location and the deliver to the consignee location, we need 
//					  to add cross-dock events into the shipment. 
//
//
// 	Written by	:Samuel Towle
// 		Date	:06/22/2006
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
			
				
		CASE "PD" // Pickup Deliver == We should always see this
			// Add the cross dock Deliver and Pickup to the middle  
			
			lnv_Shipment.of_Addevents( {'D','P'} , 2 , lnv_Dispatch , lla_NewEventIds )
					
		CASE ELSE // do nothing
			
			
	END CHOOSE
	
	
	DESTROY ( lnv_Event )
	
END IF

RETURN li_Return
end function

protected function integer of_processeventdata ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_processeventdata
//  
//	Access		:Protected
//
//	Arguments	:None
//						
//			
//
//	Return		:int 1 if success -1 if failure
//					
//						
//	Description	:Sets data on BEO using eventmapping.psr file
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:06/22/2006
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
	
	FOR i = 1 TO li_EventCount
		
		IF lnva_Events[i].of_IsConfirmed( ) THEN
			CONTINUE 
		END IF
		lnva_Events[i].of_SetAllowFilterSet ( TRUE )
		
		THIS.of_Getstopgroup( lnva_Events[i].of_GetImportReference( ) , lnva_Segments )
		
		// this is where the data gets processed and set
		IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
			li_Return = -1
		END IF
		
		// this gets access to the specific stop group
		THIS.of_Getstopgroup( lnva_Events[i].of_GetImportReference( ) , lnva_Segments )	
		IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
			li_Return = -1
		END IF
		
		// Special processing to set the first cross-dock site 
		//	Event should not have an importreference.
		// Use the data from stop group 1 and pass it to the mapping for the cross-dock events.

		IF ISNULL ( lnva_Events[i].of_GetImportReference( ) ) THEN
			THIS.of_Getstopgroup( lnva_Events[1].of_GetImportReference( ) , lnva_Segments )	
			IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
				li_Return = -1
			END IF
		END IF



	NEXT		
	
	//  Destroy all after processing is complete.
		
	FOR i = 1 TO li_EventCount
		DESTROY ( lnva_Events[i] )
	NEXT	
END IF


RETURN li_Return










end function

protected function integer of_addnonintermodalitems ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addnonintermodalitems
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
//	Description	: 
//
//
//
// 	Written by	:Samuel Towle
// 		Date	:07/10/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

Any		la_Value
Int		li_EventCount
Int		li_StopCount
Int		li_Return = 1
Int		i
Int		j
Int		li_Seq
Int		li_KeyCount
Int		li_KeyIndex
Long		ll_NewItemID
Long		ll_ImpRef
Long		lla_ItemIds[]
String	lsa_KeyValue[]
String	ls_KeyValue
String	ls_StopType
String	ls_KeySegment
String	ls_KeyElement


n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_cst_ediSegment		lnva_StopSegments[]
n_cst_beo_Event		lnva_Events[]

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
	li_StopCount = THIS.of_GetSegments( "N1",lnva_StopSegments)
	
	
	
	FOR i = 1 TO li_StopCount	
		
		THIS.of_GetStopgroup( i , lnva_StopSegments )
		IF THIS.of_Getvalue( "N1" , "1", "", lnva_StopSegments , la_Value ) = 1 THEN
			ls_StopType = STRING ( la_Value )
		ELSE
			CONTINUE
		END IF
		
		
		// for each stop see if it is a pu type 
		IF THIS.of_ISstoppickupgroup( ls_StopType ) THEN
		// if it is then create an item. 
			ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_cst_Constants.cs_ItemEventType_ImportedFreight )
				lnv_Item.of_SetPuevent( i )
				IF THIS.of_Getvalue( ls_KeySegment , ls_KeyElement , "", lnva_StopSegments , la_Value ) = 1 THEN
					ls_KeyValue = STRING ( la_Value )
				ELSE
					li_Return = -1
					THIS.of_Adderror( "Could not create all items by the key value. " )
				END IF
				li_KeyCount ++
				lla_ItemIds [ li_KeyCount] = ll_NewItemID
				lsa_KeyValue [ li_KeyCount ] = ls_KeyValue
				
				
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create all items. " )
			END IF
			
			
		// if it is not then see if it is a deliver
		ELSEIF  THIS.of_ISstopdelivergroup( ls_StopType ) THEN
			
		// if it is then find the corresponding item and set its deliver index.
			IF THIS.of_Getvalue( ls_KeySegment , ls_KeyElement , "", lnva_StopSegments , la_Value ) = 1 THEN
				ls_KeyValue = STRING ( la_Value )
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not populate stop index by the key value. " )
			END IF
			
			FOR li_KeyIndex = 1 TO li_KeyCount  // i intentionally do not bail once i find it.
				IF lsa_KeyValue [li_KeyIndex] = ls_KeyValue THEN
					ll_NewItemID = lla_ItemIds [li_KeyIndex]
				END IF
			NEXT
			
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				// Find the event with the import reference that matches the stop group
				// Set the item deliver event to the shipment sequence number.
				li_EventCount = lnv_Shipment.of_GetEventList(lnva_Events )
				FOR j = 1 to li_EventCount
					IF NOT ISNULL ( lnva_Events[j].of_GetImportReference( ) ) THEN	
			
						ll_ImpRef = lnva_Events[j].of_GetImportReference ( )			// Gets the import reference
						IF ll_ImpRef = i THEN													// Compare the stop count and import ref
							li_Seq = lnva_Events[j].of_GetShipSeq ( )						// Gets the the event number sequence
							lnv_Item.of_SetDelevent( li_Seq )								// Sets Deliver event to sequence number
						END IF
					END IF
			
					DESTROY ( lnva_Events[j] )
				NEXT

			END IF
		END IF
		

	NEXT
END IF


DESTROY ( lnv_Item )
RETURN li_Return
end function

on n_cst_edishipment_manager_preferred.create
call super::create
end on

on n_cst_edishipment_manager_preferred.destroy
call super::destroy
end on

