$PBExportHeader$n_cst_edishipment_manager_nyklogistics.sru
forward
global type n_cst_edishipment_manager_nyklogistics from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_nyklogistics from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_nyklogistics n_cst_edishipment_manager_nyklogistics

type variables
Constant String	cs_NYKLogisticsScac = "GRSF"
Constant String	cs_NYKLogisticsScac2 = "NYKT"
end variables

forward prototypes
protected function datastore of_getpendingdatastore ()
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function string of_getmovedirection ()
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
//	Description	: Gets pending shipments from importedshipments table for NYK and places in datastore
//
//
//
// 	Written by	:John Biron
// 		Date	:01/23/2007
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

DataStore		lds_Pending
String			ls_Scac
String			ls_Scac2

lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )

//nyk could use GRSF or NYKT - looking for both to cover all bases
ls_Scac = THIS.cs_NYKLogisticsScac		//GRSF
ls_Scac2 = THIS.cs_NYKLogisticsScac2		//NYKT

lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and sendersCode in ('" + ls_Scac + "','" + ls_Scac2 + "')")

RETURN lds_Pending
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
// 	Written by	:John Biron
// 		Date	:01/23/2007
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

protected function integer of_geteventstructure (ref string asa_eventtypes[]);
///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_geteventstructure
//  
//	Access		:Private
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
// 	Written by	:John Biron
// 		Date	:01/23/2007
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////

String	lsa_Events[]
Int		li_EventCount
Long		ll_RowCount
Long		i
String	ls_CurrentEvent
String	ls_Temp
Int		li_SegmentCount
Boolean	lb_DoneInd
	
n_cst_edisegment	lnva_Segments[]

lb_DoneInd = FALSE


li_SegmentCount = THIS.of_GetSegments( "L11", lnva_Segments )

IF li_SegmentCount > 0 THEN
			
	FOR i = 1 to li_SegmentCount
		lnva_Segments[i].of_getvalue( {1}, ls_Temp )
			
		//Empty repos are one way hook/drop.
		IF ls_Temp = "EMPTY REPO" THEN
			lsa_Events[1] = gc_dispatch.cs_eventtype_hook
			lsa_Events[2] = gc_dispatch.cs_eventtype_drop
			lb_DoneInd = TRUE
			li_EventCount = 2
		END IF
				
	NEXT
END IF

IF lb_DoneInd = FALSE THEN
	li_SegmentCount = THIS.of_GetSegments( "NTE", lnva_Segments )

	IF li_SegmentCount > 0 THEN

		FOR i = 1 TO li_SegmentCount
		
			lnva_Segments[i].of_getvalue( {2}, ls_Temp )
			//These are all hook/drop.  We are setting each in an individual case statement
			//to allow for easy modfication if necessary.
			CHOOSE CASE UPPER(ls_Temp)
				CASE "DRAYAGE SPOT TO LOAD"		//round trip export
					lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					lb_DoneInd = TRUE
					li_EventCount = 2
	
				CASE "DRAYAGE SPOT TO UNLOAD"		//round trip import
					lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					lb_DoneInd = TRUE
					li_EventCount = 2

				CASE "DRAYAGE PULL FROM DEST EMPTY"		//one-way
					lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					lb_DoneInd = TRUE
					li_EventCount = 2

				CASE "DRAYAGE PULL FROM ORIGIN LOADED"		//one-way
					lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					lb_DoneInd = TRUE
					li_EventCount = 2

				CASE "DRAYAGE DROP AND HOOK TO LOAD"		//round trip export
					lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					lb_DoneInd = TRUE
					li_EventCount = 2

				CASE "DRAYAGE DROP AND HOOK TO UNLOAD"		//round trip import
					lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					lb_DoneInd = TRUE
					li_EventCount = 2

				CASE "DRAYAGE LIVE DELIVERY"		//live import
					lsa_Events[1] = gc_dispatch.cs_eventtype_hook
					lsa_Events[2] = gc_dispatch.cs_eventtype_deliver
					lb_DoneInd = TRUE
					li_EventCount = 2

				CASE "DRAYAGE LIVE PICK-UP"		//live export
					lsa_Events[1] = gc_dispatch.cs_eventtype_pickup
					lsa_Events[2] = gc_dispatch.cs_eventtype_drop
					lb_DoneInd = TRUE
					li_EventCount = 2

			END CHOOSE
		NEXT
	END IF
END IF

//If we did not find any of the usual cases, process normally.
IF lb_DoneInd = FALSE THEN
	
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
				// this is not good, i know, but such is the world of EDI
				// since HUB uses DR for deramp and ramp for loading
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

protected function string of_getmovedirection ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_getmovedirection
//  
//	Access		:Private
//
//	Arguments	:NONE
//			
//
//	Return		:String
//						one of 3 constant values representing the direction on the intermodal move.
//						
//	Description	: look for the position of the DR (deramp) event in the stop list. this, is assume, is pretty HUB specific.
//
//
//
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int					li_SegmentCount
Int					i
String				ls_Value
String				ls_Direction
String				ls_OneWaySites

Boolean	lb_DoneInd
	
n_cst_edisegment	lnva_Segments[]
n_cst_edisegment	lnva_StopSegments[]

lb_DoneInd = FALSE

IF lb_DoneInd = FALSE THEN
	li_SegmentCount = THIS.of_GetSegments( "L11", lnva_Segments )
	IF li_SegmentCount > 0 THEN
			
		FOR i = 1 to li_SegmentCount
			lnva_Segments[i].of_getvalue( {1}, ls_Value )
			
			//Empty repos are one way hook/drop.
			IF UPPER(ls_Value) = "EMPTY REPO" THEN
				ls_Direction = cs_OneWay
				lb_DoneInd = TRUE
			END IF
		NEXT
	END IF
END IF

IF lb_DoneInd = FALSE THEN
	li_SegmentCount = THIS.of_GetSegments( "NTE", lnva_Segments )

	IF li_SegmentCount > 0 THEN

		FOR i = 1 TO li_SegmentCount
		
			lnva_Segments[i].of_getvalue( {2}, ls_Value )

			CHOOSE CASE UPPER(ls_Value)
				CASE "DRAYAGE SPOT TO LOAD"
					ls_Direction = cs_Export
					lb_DoneInd = TRUE
					
				CASE "DRAYAGE PULL FROM ORIGIN LOADED"
					ls_Direction = cs_OneWay
					lb_DoneInd = TRUE
	
				CASE "DRAYAGE DROP AND HOOK TO LOAD"
					ls_Direction = cs_Export
					lb_DoneInd = TRUE
		
				CASE "DRAYAGE SPOT TO UNLOAD"
					ls_Direction = cs_Import
					lb_DoneInd = TRUE
			
				CASE "DRAYAGE PULL FROM DEST EMPTY"
					ls_Direction = cs_OneWay
					lb_DoneInd = TRUE
		
				CASE "DRAYAGE DROP AND HOOK TO UNLOAD"
					ls_Direction = cs_Import
					lb_DoneInd = TRUE

				CASE "DRAYAGE LIVE DELIVERY"
					ls_Direction = cs_Import
					lb_DoneInd = TRUE
					
				CASE "DRAYAGE LIVE PICK-UP"
					ls_Direction = cs_Export
					lb_DoneInd = TRUE
					
			END CHOOSE
		NEXT
	END IF	
END IF

IF lb_DoneInd = FALSE THEN
	li_SegmentCount = THIS.of_Getsegments( "S5", lnva_Segments )
	// populate stop list
	ls_OneWaySites = THIS.of_Getonewaystopsites( )

	IF li_SegmentCount > 0 THEN

		THIS.of_Getstopgroup ( 1 , lnva_StopSegments )	
		IF THIS.of_Getsegments( "S5", lnva_StopSegments ,lnva_Segments) > 0 THEN
			lnva_Segments[1].of_getvalue( {2} , ls_Value )		
			IF ls_Value = "DT" THEN // Drop Trailer as first stop
				ls_Direction = cs_Export
			END IF
		END IF

	// if that did not tell us anything then check for origin/destination ramps
		IF Len ( ls_Direction ) = 0 THEN
			li_SegmentCount = THIS.of_GetSegments( "S5", lnva_Segments)
	
			IF li_SegmentCount > 0 THEN
				lnva_Segments[1].of_getvalue( {2} , ls_Value )
				IF ls_Value = "DR" THEN
					ls_Direction = cs_Import

					lnva_Segments[li_SegmentCount].of_getvalue( {2} , ls_Value )
					IF ls_Value = "DR" THEN
						ls_Direction = cs_OneWay
					END IF
				ELSE
					lnva_Segments[li_SegmentCount].of_getvalue( {2} , ls_Value )
					IF ls_Value = "DR" THEN
						ls_Direction = cs_Export
					END IF
				END IF
			END IF
		END IF	
	END IF
END IF

// if we still did not find it them default to oneway
IF Len ( ls_Direction ) = 0 THEN
	ls_Direction = cs_OneWay
END IF

RETURN  ls_Direction	

end function

on n_cst_edishipment_manager_nyklogistics.create
call super::create
end on

on n_cst_edishipment_manager_nyklogistics.destroy
call super::destroy
end on

