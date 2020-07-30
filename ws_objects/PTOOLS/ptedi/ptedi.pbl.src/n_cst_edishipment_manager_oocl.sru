$PBExportHeader$n_cst_edishipment_manager_oocl.sru
forward
global type n_cst_edishipment_manager_oocl from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_oocl from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_oocl n_cst_edishipment_manager_oocl

type variables
Constant String	cs_OOCLScac = "OOCLIES"
end variables

forward prototypes
protected function datastore of_getpendingdatastore ()
protected function integer of_cancelshipment ()
protected function integer of_prepareshipmentforupdate ()
protected function integer of_initializeexistingshipment (string as_delnum, string as_contnum)
protected function string of_getmovedirection ()
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function boolean of_ismoveintermodal ()
protected function integer of_getstopgroup (integer ai_stop, ref n_cst_edisegment anva_segments[])
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_processshipmentdata ()
protected function integer of_processeventdata ()
end prototypes

protected function datastore of_getpendingdatastore ();
///////////////////////////////////////////////////////////////////////////////
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
//	Description	: Gets pending shipments from importedshipments table for OOCL and 
//places in datastore
//
//
//
// 	Written by	:John Biron
// 		Date	:11/01/2006
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

ls_Scac = THIS.cs_OOCLScac

lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and sendersCode = '" + ls_Scac + "'")

RETURN lds_Pending
end function

protected function integer of_cancelshipment ();Int		li_Return
String	ls_delnum
int		i
long		ll_count
String	ls_value
int		ll_EquipmentCount
String	ls_temp
String	ls_Prefix
String	ls_Number
String	ls_ContainerNumber

n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segments[]
n_Cst_EDIsegment		lnva_EquipmentSegments[]

li_Return = 1

//Get edireference number
IF li_Return = 1 THEN
	IF THIS.of_GetSegments( "L11", lnva_Segments) > 0 THEN
		ll_Count = UpperBound ( lnva_Segments )
					
		FOR i = 1 TO ll_Count
					
			lnva_Segments[i].of_getvalue( {2} , ls_Value )
						
			IF ls_Value = '9R' THEN
				IF lnva_Segments[i].of_Getvalue( {1}, ls_delnum ) <> 1 THEN
					li_Return = -1
				END IF			
			END IF
		NEXT
	END IF
END IF

//Get container number
ll_EquipmentCount = THIS.of_Getsegments( "N7" , lnva_EquipmentSegments )

IF ll_Equipmentcount <> 1 THEN
	li_Return = -1
ELSE
	IF lnva_EquipmentSegments[1].of_getvalue( {1}, ls_temp) = 1 THEN
		ls_Prefix = ls_temp
	END IF
	
	IF lnva_EquipmentSegments[1].of_getvalue( {2}, ls_temp) = 1 THEN
		ls_Number = ls_temp
	END IF

	ls_ContainerNumber = ls_Prefix + ls_Number
END IF

IF li_Return = 1 THEN
	IF THIS.of_Initializeexistingshipment( ls_delnum, ls_ContainerNumber ) <> 1 THEN
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

protected function integer of_prepareshipmentforupdate ();//Finds the delivery number and container number that will be used to
//determine the unique shipment.

Int		li_Return
Int		li_ItemCount
Int		i
Long		ll_NewID
String	ls_delnum
long		ll_count
String	ls_value
int		ll_EquipmentCount
String	ls_temp
String	ls_Prefix
String	ls_Number
String	ls_ContainerNumber


n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDIsegment		lnva_Segments[]
n_cst_beo_Item			lnva_Items[]
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event
n_Cst_EDIsegment		lnva_EquipmentSegments[]

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
		

//Get delivery number number
IF li_Return = 1 THEN
	IF THIS.of_GetSegments( "L11", lnva_Segments) > 0 THEN
		ll_Count = UpperBound ( lnva_Segments )
					
		FOR i = 1 TO ll_Count
					
			lnva_Segments[i].of_getvalue( {2} , ls_Value )
						
			IF ls_Value = '9R' THEN
				IF lnva_Segments[i].of_Getvalue( {1}, ls_delnum ) <> 1 THEN
					li_Return = -1
				END IF			
			END IF
		NEXT
	END IF
END IF

//Get container number
ll_EquipmentCount = THIS.of_Getsegments( "N7" , lnva_EquipmentSegments )

IF ll_Equipmentcount <> 1 THEN
	li_Return = -1
ELSE
	IF lnva_EquipmentSegments[1].of_getvalue( {1}, ls_temp) = 1 THEN
		ls_Prefix = ls_temp
	END IF
	
	IF lnva_EquipmentSegments[1].of_getvalue( {2}, ls_temp) = 1 THEN
		ls_Number = ls_temp
	END IF

	ls_ContainerNumber = ls_Prefix + ls_Number
END IF

IF li_Return = 1 THEN
	IF THIS.of_Initializeexistingshipment( ls_delnum, ls_ContainerNumber ) <> 1 THEN
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	THIS.of_AddIntermodalitemsifneeded( )
END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end function

protected function integer of_initializeexistingshipment (string as_delnum, string as_contnum);//uses a combo of the delivery number and container number to find the shipment instead of
//the B204.

Int		li_Return
String	ls_delnum
String	ls_contnum
String	ls_OpenStatus
String	ls_PendingStatus
Long		ll_Count
Long		ll_ProvCount
Long		ll_ShipID
Boolean	lb_Cont

n_cst_beo_Item			lnva_Items[]
n_cst_beo_Shipment	lnv_Shipment
n_Cst_Bso_Dispatch	lnv_Dispatch

li_Return = 1
ls_OpenStatus = gc_Dispatch.cs_shipmentstatus_open
ls_PendingStatus = gc_Dispatch.cs_shipmentstatus_Offered
ls_delnum = as_delnum
ls_contnum = as_contnum
lb_Cont = TRUE

IF li_Return = 1 THEN
	Select Count ( ds_id ) Into :ll_Count From disp_Ship, outside_equip, equipment where edireference = :ls_delnum AND disp_Ship.ds_id=outside_equip.shipment and outside_equip.oe_id=equipment.eq_id and equipment.eq_ref= :ls_contnum AND ( ds_Status = :ls_OpenStatus OR ds_Status = :ls_PendingStatus); 

	CHOOSE CASE sqlca.sqlCode
		CASE 0,100
			Commit;
		CASE ELSE 
			RollBack;
			li_Return = -1
		END CHOOSE
END IF

IF li_Return = 1 THEN
	CHOOSE Case ll_Count			
		CASE is > 1 //Error, Won't be able to resovle shipment							
			li_Return = -1
			THIS.of_Adderror( "More than one active shipment contains the delivery number " + ls_delnum + " and the container number " + ls_contnum + "." )
		CASE 1 
			Select ds_id Into :ll_ShipID From disp_Ship, outside_equip, equipment where edireference = :ls_delnum AND disp_Ship.ds_id=outside_equip.shipment and outside_equip.oe_id=equipment.eq_id and equipment.eq_ref= :ls_contnum AND ( ds_Status = :ls_OpenStatus OR ds_Status = :ls_PendingStatus); 
			IF sqlca.sqlCode = 0 THEN
				Commit;
			ELSE 
				RollBack;
				li_Return = -1
				THIS.of_Adderror( "Shipment " + String ( ll_ShipID ) + " was found but could not be successfully selected for modification.[select failed]" )
			END IF
		CASE ELSE
			//Just in case container has already been updated in PT but not at OOCL
			//Checks for original empty slot number that was stored in Custom10
			Select count (ds_id) Into :ll_ProvCount from disp_ship where edireference = :ls_delnum AND Custom10 = :ls_contnum AND ( ds_Status = :ls_OpenStatus OR ds_Status = :ls_PendingStatus);
			
			CHOOSE Case ll_ProvCount			
				CASE is > 1 //Error, Won't be able to resovle shipment							
					li_Return = -1
					THIS.of_Adderror( "More than one active shipment contains the delivery number " + ls_delnum + " and the container number " + ls_contnum + "." )
				CASE 1 
					Select ds_id Into :ll_ShipID From disp_Ship where edireference= :ls_delnum AND Custom10= :ls_contnum AND ( ds_Status = :ls_OpenStatus OR ds_Status = :ls_PendingStatus); 
					IF sqlca.sqlCode = 0 THEN
						Commit;
					ELSE 
						RollBack;
						li_Return = -1
						THIS.of_Adderror( "Shipment " + String ( ll_ShipID ) + " was found but could not be successfully selected for modification.[select failed]" )
					END IF
				CASE ELSE
					//Since it is possible OOCL will send a shipment with bad info that does not get
					//created, if they send an update to a shipment that does not exist, we will try
					//to create said shipment.  This way, we should not miss any shipments.
					IF THIS.of_createshipment() = 1 THEN
						//Set lb_cont bit to false to make sure this function does not try to update
						//the shipment that was just created.
						lb_Cont = FALSE
						li_Return = 1
					ELSE
						THIS.of_Adderror( "The existing shipment could not be found using the delivery number " + ls_delnum + " and the container number " + ls_contnum + "." )
						li_Return = -1
					END IF
			END CHOOSE
		END CHOOSE
END IF

IF lb_Cont = TRUE THEN
	IF li_Return = 1 THEN
		lnv_Dispatch = THIS.of_getdispatch( )
		IF lnv_Dispatch.of_retrieveshipment( ll_ShipID ) <> 1 THEN
			li_Return = -1
			THIS.of_AddError ( "Could not retrieve shipment." )
		ELSE
			lnv_Dispatch.of_FilterShipment ( ll_ShipID )
		END IF
	END IF

	IF li_Return = 1 THEN
		lnv_Shipment = THIS.of_GetShipment ( )
		IF Not isValid ( lnv_Shipment ) THEN
			li_Return = -1
			THIS.of_Adderror( "Could not get a valid shipment." )
		END IF
	END IF

	IF li_Return = 1 THEN
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_getshipmentcache( ) )
		lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_getItemcache( ) )
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_getEventcache( ) )
		lnv_Shipment.of_SetSourceID ( ll_ShipID )
		lnv_Shipment.of_SetAllowFilterSet ( TRUE )
		lnv_Shipment.of_SetContext ( lnv_Dispatch )
	END IF

	IF li_Return = 1 THEN
		IF NOT THIS.of_IsMoveintermodal( ) THEN
		
			// delete all of the imported items
			lnv_Shipment.of_GetItemsforeventtype( n_Cst_constants.cs_ItemEventType_Imported, lnva_Items )
			int	li_ItemCount
			Int	i
			li_ItemCount = upperBound ( lnva_Items )
			FOR i = 1 TO li_ItemCount 
				lnv_Shipment.of_Removeitem( lnva_Items[i])
				DESTROY ( lnva_Items[i] )
			NEXT
		END IF
	END IF
END IF
	
Return li_Return
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
// 	Written by	:John Biron
// 		Date	:
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//							2007-03-14, SAT, re write.
//////////////////////////////////////////////////////////////////////////////


//		All export moves will be sent with an N1_01 of "AB"  for first stop
//		All import moves will be sent with an N1_01 of "RT"  for last stop
//		All one way moves will not have either of the qualifiers.
//
//		Look at the N1 qualifiers and determine move code.

Int		i
Long		ll_Count
Long		ll_StopCount
String	ls_Direction
String	ls_StopCode
String	ls_StopQualifier
	
n_cst_edisegment	lnva_StopSegments[]
n_cst_edisegment	lnva_N1Segments[]

ll_StopCount = 0
ls_StopCode = ""
// Get the number of stops by counting the N1 segments ... 
// Don't count the "BT" Bill to segment.
THIS.of_GetSegments( "N1", lnva_N1Segments )
ll_Count = UpperBound ( lnva_N1Segments )

FOR i = 1 to ll_Count	
	lnva_N1Segments[i].of_getvalue( {1} , ls_StopQualifier )		
	CHOOSE CASE ls_StopQualifier  // These are stops
		CASE "AB", "PW", "RD", "RT", "SF", "ST"
			ll_StopCount ++			
	END CHOOSE
NEXT

// Get the segments for the first stop
THIS.of_GetStopGroup ( 1 , lnva_StopSegments[] )

// Find the N1 segment
THIS.of_GetSegments( "N1", lnva_StopSegments[], lnva_N1Segments[])

// Find element 1
IF UpperBound ( lnva_N1Segments ) > 0 THEN // should be 1 but jic
	lnva_N1Segments[1].of_getvalue( {1} , ls_StopCode )
	IF ls_StopCode = "AB" THEN
		ls_Direction = cs_Export
	END IF
END IF

IF Len ( ls_Direction ) = 0 THEN  // keep on lookin'
	ls_StopCode = ""
	// Get the segments for the last stop (upperbound)
	THIS.of_GetStopGroup ( ll_StopCount , lnva_StopSegments[] )

	// Find the N1 segment
	THIS.of_GetSegments( "N1", lnva_StopSegments[], lnva_N1Segments[])

	// Find element 1
	IF UpperBound ( lnva_N1Segments ) > 0 THEN // should be but jic
		lnva_N1Segments[1].of_getvalue( {1} , ls_StopCode )
		IF ls_StopCode = "RT" THEN
			ls_Direction = cs_Import		
		END IF
	END IF
END IF

// if we did not find and "AB" or "RT" then default to oneway
IF Len ( ls_Direction ) = 0 THEN
	ls_Direction = cs_OneWay
END IF

RETURN  ls_Direction	
end function

protected function integer of_geteventstructure (ref string asa_eventtypes[]);///////////////////////////////////////////////////////////////////////////////
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
//					Uses the N1 segments instead of S5
//
//
//
// 	Written by	:John Biron
// 		Date	:11/07/06
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							2007-03-14, SAT, Added "AB" and "RT" to case statement.
//			Per Steve Burgess 3/14/07
//			If the check box in job order for drop and pull is checked then S5(02) = DT  (drop and Pull)
//       If the check box in Job order for drop and pull is blank then S5(02) = CU  (Complete Unload)
//	
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_live
Int		li_EventCount
Int		li_S5Count
Int		li_SegmentCount
Int		li_Count
Long		ll_RowCount
Long		i
String	ls_CurrentEvent
String	ls_Temp
String	ls_ServiceType
String	lsa_Events[]
	
n_cst_edisegment	lnva_Segments[]

//	Check for live vs drop and pull indicator (S5_02)
li_S5Count = This.of_Getsegments ( "S5", lnva_Segments )
FOR li_Count = 1 to li_S5Count
	lnva_Segments[li_Count].of_getvalue( {2}, ls_ServiceType )
	
	CHOOSE CASE ls_ServiceType
		
		CASE "DT"
			lb_live = FALSE
			
		CASE "CU", "CL"
			lb_live = TRUE
			
	END CHOOSE
NEXT

li_SegmentCount = THIS.of_Getsegments( "N1", lnva_Segments )

FOR i = 1 TO li_SegmentCount
	
	lnva_Segments[i].of_getvalue( {1}, ls_Temp )
	
	CHOOSE CASE ls_Temp
							
		CASE  "PW" 
			IF lb_live THEN
				ls_CurrentEvent = gc_dispatch.cs_eventtype_pickup
			ELSE
				ls_CurrentEvent = gc_dispatch.cs_eventtype_hook
			END IF
			
		CASE "SF" , "AB"
			ls_CurrentEvent = gc_dispatch.cs_eventtype_hook
		
		CASE "RD"
			IF lb_live THEN
				ls_CurrentEvent = gc_dispatch.cs_eventtype_deliver
			ELSE
				ls_CurrentEvent = gc_dispatch.cs_eventtype_drop
			END IF
	
		CASE  "ST" , "RT"
			
			ls_CurrentEvent = gc_dispatch.cs_eventtype_drop
			
		CASE ELSE  //do nothing

	END CHOOSE 
		
	IF Len ( ls_CurrentEvent ) > 0 THEN
		li_EventCount ++
		lsa_Events[ li_EventCount ] = ls_CurrentEvent
	END IF
		
NEXT
	
asa_eventtypes[] = lsa_Events

RETURN li_EventCount
end function

protected function boolean of_ismoveintermodal ();Boolean	lb_Return

	//All OOCL moves are intermodal
	lb_Return = TRUE

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
//					Uses S5 on first stop and N1 segments on the rest
//
//
// 	Written by	:John Biron
// 		Date	:11/07/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//							3/14/07, SAT, Reverted to older version code and added qualifiers.
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_TakeSegment
Int		li_Return
Int		li_StopSegments
Int		li_StopNumber
Long		ll_SegmentCount
Long		i
String	ls_CurrentSegment
String	ls_StopValue
Boolean	lb_S5Ind


n_cst_edisegment	lnva_StopSegments[]


ll_SegmentCount = UpperBound ( inva_segments )
li_StopNumber = 1


//  Reverted to old code ST 3/14/07

FOR i = 1 TO ll_SegmentCount	
		// Look through all segments
	ls_CurrentSegment = inva_segments[i].of_getsegmentid( )
	IF ls_CurrentSegment = "N1" THEN
			// Find all N1 segments
		inva_segments[i].of_getValue ( {1} , ls_StopValue  )
	
		CHOOSE CASE ls_StopValue
			
			CASE "SF", "PW", "RD", "ST", "AB", "RT"  // Added AB and RT 3/14/07 SAT
				IF li_StopNumber = ai_stop THEN

					lb_TakeSegment = TRUE
				ELSE
					lb_TakeSegment = FALSE
				END IF
				li_StopNumber ++
					// These are the qualifiers we want.
					// Check to see if stop number matches the stop we are looking for
					
			CASE "BT"
				lb_TakeSegment = FALSE
					// ignore these qualifiers for the N1
					
		END CHOOSE	
		
	ELSEIF ls_CurrentSegment = "L3" OR ls_CurrentSegment = "SE" OR ls_CurrentSegment = "L5" THEN
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





/*

lb_S5Ind = FALSE

FOR i = 1 TO ll_SegmentCount	
		// Look through all segments
	ls_CurrentSegment = inva_segments[i].of_getsegmentid( )
	IF ls_CurrentSegment = "N1" THEN
			// Find all N1 segments
		inva_segments[i].of_getValue ( {1} , ls_StopValue  )
	
		CHOOSE CASE ls_StopValue
			
			CASE "SF", "PW", "RD", "ST"
				IF lb_S5Ind = TRUE THEN
					lb_S5Ind = FALSE
				ELSE
					IF li_StopNumber = ai_stop THEN
						lb_TakeSegment = TRUE
					ELSE
						lb_TakeSegment = FALSE
					END IF
					li_StopNumber ++
					// These are the qualifiers we want.
					// Check to see if stop number matches the stop we are looking for
				ENd IF
					
			CASE "BT"
				lb_TakeSegment = FALSE
				// ignore these qualifiers for the N1
					
		END CHOOSE
	
	ELSEIF ls_CurrentSegment = "S5" THEN
			lb_S5Ind = TRUE
			
			IF li_StopNumber = ai_stop THEN
				lb_TakeSegment = TRUE
			ELSE
				lb_TakeSegment = FALSE
			END IF
			li_StopNumber ++
		
	ELSEIF ls_CurrentSegment = "L3" OR ls_CurrentSegment = "SE" OR ls_CurrentSegment = "L5" THEN
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

*/
end function

protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[]);//////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_applyeventstructurelogic
//  
//	Access		:Private
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
//	Description	: 	this where we try to figure out what type of move we are being sent and 
//						create the correct event structure in the shipment. I.E. if we are only 
//						sent a Drop stop, we will then add the first implied hook and the implied 
//						Hook and drop at the end of the shipment.
//
//
//
// 	Written by	: John Biron
// 		Date	: 11/10/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//							3/14/07, SAT, Modified the HHR and HRR looking at wrong stop group.
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
					THIS.of_GetStopgroup( 1 , lnva_segments )
					THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
					
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
									
				ELSE				
					li_Return = -1
				END IF
			END IF
			
		CASE "HD"  /*HOOK DELIVER*/ , "HP" // Hook Pickup
			// add drop
			lnv_Shipment.of_Addevents ( {'R'} , 3 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
					THIS.of_GetStopgroup( 1 , lnva_segments )
					THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
					
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
			END IF
			
		CASE "PR" // PickUp Drop
			// Add First hook
			lnv_Shipment.of_Addevents ( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN					
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
					THIS.of_GetStopgroup( 2 , lnva_segments )
					THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
					
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
			END IF
			
		CASE "HHR" // HOOK HOOK DROP  
			// Insert DROP in position 2
			lnv_Shipment.of_Addevents ( {'R'} , 2 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN					
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
					THIS.of_GetStopgroup( 2 , lnva_segments )
					THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
					
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
			END IF	

		CASE "HRR" // HOOK DROP DROP
			// Insert HOOK in position 3
			lnv_Shipment.of_Addevents ( {'H'} , 3 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN					
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
					THIS.of_GetStopgroup( 2 , lnva_segments )
					THIS.of_GetSegments( "N1",lnva_segments, lnva_segmentsResults )
					
					THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
			END IF				
		
		CASE ELSE // do nothing
			 
			
	END CHOOSE
	
	
	DESTROY ( lnv_Event )
	
END IF

RETURN li_Return
end function

protected function integer of_processshipmentdata ();
///////////////////////////////////////////////////////////////////////////////
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
//	Description	:  Parses selected data and sets data on shipment.  Attemps to find
//						pickup numbers, cutoff date, and lfd in the notes.
//					  
//
// 	Written by	:John Biron
// 		Date	:
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int		i
Int		li_Return
Long		ll_Count
Long		ll_Length
Long		ll_Position
String	ls_Temp
String	ls_Value

//Movecode variables
String	ls_movedirection

//Cutoff date variables
String	ls_CutYear
String	ls_CutMonth
String	ls_CutDay
String	ls_CutTime
String	ls_CutDate
String	ls_CutHour
String	ls_CutMin

//Pickup number variables
String	ls_CatNote
Boolean	lb_PUNumInd
String	ls_ContInit
String	ls_ContSerial
String	ls_ContNum
String	ls_NoteSeg
String	ls_PUNum
Int		li_Stop
Int		li_CheckDigit

//Last free date variables
String	ls_LFDMonth
String	ls_LFDDay
String	ls_LFDYear
String	ls_LFDTemp
Integer	li_YearToday
String	ls_LFDate
String	ls_Separator


n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_beo_Shipment	lnv_Shipment
n_Cst_EDISegment		lnva_Segment[]
n_cst_EquipmentManager		lnv_EquipmentManager

li_Return = 1
ls_LFDTemp = ""

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
	
//Set move code
	CHOOSE CASE THIS.of_GetMoveDirection ( )
				
		CASE cs_export
			ls_MoveDirection = "E"
				
		CASE cs_import
			ls_MoveDirection = "I"
			
		CASE cs_Oneway
			ls_MoveDirection = "O"

		CASE ELSE
			ls_MoveDirection = ""
	END CHOOSE
	lnv_SHipment.of_SetMoveCode ( ls_MoveDirection )
	
	//Get pickup number if it is not passed in an L11
	lb_PUNumInd = FALSE
	
	//Check for pickup number in L11 segment
	IF THIS.of_GetSegments ( "L11" , lnva_Segment ) > 0 THEN
		ll_Count = UpperBound ( lnva_Segment )								
		
		FOR i = 1 TO ll_Count													
			lnva_segment[i].of_getvalue( {3} , ls_Value )
			
			IF ls_Value = "P8" THEN
				lb_PUNumInd = TRUE
			END IF
		NEXT
	END IF
	
	//If pickup number not found, get container number to grep for in the NTE segments
	IF lb_PUNumInd = FALSE THEN
		ls_CatNote = ""
	
		IF THIS.of_GetSegments ( "N7" , lnva_Segment ) > 0 THEN
			ll_Count = UpperBound ( lnva_Segment )								
	
			IF ll_Count = 1 THEN
				lnva_segment[1].of_getvalue( {1} , ls_ContInit )
				lnva_segment[1].of_getvalue( {2} , ls_ContSerial )
				
				ls_ContNum = ls_ContInit + ls_ContSerial

				li_CheckDigit=lnv_EquipmentManager.of_calculatecheckdigit(ls_ContNum)
			ELSE
				//Set to TRUE to prevent looking in the NTE loop
				lb_PUNumInd = TRUE				
			END IF
		ELSE
			//Set to TRUE to prevent looking in the NTE loop
			lb_PUNumInd = TRUE
		END IF
	END IF

//We are going to loop thru the NTE segments only once to find as many as 3
//different pieces of info.

	IF THIS.of_GetSegments ( "NTE" , lnva_Segment ) > 0 THEN
		ll_Count = UpperBound ( lnva_Segment )

		FOR i = 1 TO ll_Count
			lnva_segment[i].of_getvalue( {2} , ls_Value )

			//Get cutoff date/time if it can be found
			//It is passed in an NTE segment as such:
			//NTE*OTH*CUTOFF:20060926160000
			ll_Position = POS ( ls_Value, "CUTOFF:" )
			
			IF ll_Position > 0 THEN
			
				ls_CutYear = Mid(ls_Value, 8, 4)
				ls_CutMonth = Mid(ls_Value, 12, 2)
				ls_CutDay = Mid(ls_Value, 14, 2)
				ls_CutHour = Mid(ls_Value, 16, 2)
				ls_CutMin = Mid(ls_Value, 18, 2)
				
				ls_CutDate = ls_CutMonth + "-" + ls_CutDay + "-" + ls_CutYear
				ls_CutTime = ls_CutHour + ":" + ls_CutMin

				IF STRING ( DATE( ls_CutDate ) ) = '1/1/1900' THEN
					THIS.of_AddError ( "Could not set Cutoff Date." )
				ELSE
					lnv_Shipment.of_setCutoffDate ( DATE ( ls_CutDate ) )
				END IF
				
				IF STRING ( TIME( ls_CutTime ) ) = "00:00:00.000000" THEN
					THIS.of_AddError ( "Could not set Cutoff Time." )
				ELSE
					lnv_Shipment.of_setCutoffTime( TIME( ls_CutTime ) )
				END IF
			END IF				
				
			//Concatenate NTE03 values for further processing to find pickup numbers
			//Set field to max length of 80 to make sure segments don't run together
			ls_NoteSeg = ls_Value
			DO UNTIL LEN( ls_NoteSeg ) = 80
				ls_NoteSeg = ls_NoteSeg + " "
			LOOP
				
			//concatenate the NTE02 segments into one string
			ls_CatNote = ls_CatNote + UPPER( ls_NoteSeg )
				
				
			//Get last free date from NTE segment.  Passed as such:
			//NTE*OTH*lfd 10-4 / all at nsrr / pick up#'s  : tolu300181  2917 gatu085191  1169 oolu903
			IF LEFT(ls_Value,3) = "lfd" THEN

				li_Stop = 0
				ll_Position = 5
	
				DO UNTIL li_Stop = 1
					ls_Temp = MID(ls_Value,ll_Position,1)
					IF ls_Temp = " " THEN
						li_Stop = 1
					ELSE
						ls_LFDTemp = ls_LFDTemp + ls_Temp
						ll_Position++
					END IF
				LOOP
				
			END IF

		NEXT
		
	END IF
	
	IF LEN(ls_LFDTemp) > 0 THEN
		
		ll_Length = LEN ( ls_LFDTemp )
					
		CHOOSE CASE ll_Length
						
			//less than 3, we can not use the value
			CASE IS < 3
				THIS.of_AddError ( "Could not set Last Free Date" )
						
			//greater than 5, we can not use the value
			CASE IS > 5
				THIS.of_AddError ( "Could not set Last Free Date" )
							
			CASE ELSE // length = 3-5
			//Assuming that the shortest date string can be 3
			//1 digit month, separator, 1 digit day
			ls_Separator = '-'
			ll_Position = POS ( ls_LFDTemp, ls_Separator )
			ls_LFDMonth = LEFT ( ls_LFDTemp, ( ll_Position - 1 ) )
			ls_LFDDay = RIGHT ( ls_LFDTemp, ( ll_Length - ll_Position ) )
			li_YearToday = YEAR ( TODAY() )
								
			IF isnumber ( ls_LFDMonth ) AND isNumber ( ls_LFDDay ) THEN																
				//We are assuming it is possible to get an LFD from the past.
				//Also assuming no LFD is more than 3 months in the future
				
				IF MONTH ( TODAY() ) - INTEGER( ls_LFDMonth ) > 8 THEN
					ls_LFDYear = String( li_YearToday + 1 )
				ELSE
					ls_LFDYear = String( li_YearToday )
				END IF
							
				ls_LFDate = ls_LFDMonth + "-" + ls_LFDDay + "-" + ls_LFDYear
								
				IF STRING ( DATE( ls_LFDate ) ) = '1/1/1900' THEN
					THIS.of_AddError ( "Could not set Last Free Date." )
				ELSE
					lnv_Shipment.of_setLastFreeDate ( DATE ( ls_LFDate ) )
					lnv_Shipment.of_setPickupByDate ( DATE ( ls_LFDate ) )
				END IF
			END IF
		END CHOOSE
		
	END IF

	//Look for pickup number in concatenated string
	IF lb_PUNumInd = FALSE THEN
		//Look for the container number with checkdigit in the string
		ll_Position = POS(ls_CatNote, ls_ContNum + string(li_CheckDigit))

		IF ll_Position > 0 THEN
			//Add 11 to the position to set the search start position 
			//to the first after the container number
			ll_Position = ll_Position + 11
			li_Stop = 0
		ELSE
			ll_Position = POS(ls_CatNote, ls_ContNum)
			
			IF ll_Position > 0 THEN
				//Add 10 to the position to set the search start position 
				//to the first after the container number
				ll_Position = ll_Position + 10
				li_Stop = 0
			ELSE
				li_Stop = 1
			END IF
		END IF	

	
		DO UNTIL li_Stop = 1
			//Search one character at a time
			ls_Temp = MID(ls_CatNote,ll_Position,1)
		
			//There is usually, but not always, a space or two after the container number
			//Skip the spaces
			IF ls_Temp = " " THEN
				IF LEN(TRIM(ls_PUNum)) > 0 THEN
					//Stop if the pu number has length and we hit a space
					//We assume that pickup numbers will not have spaces
					li_Stop = 1
				END IF
			ELSE
				ls_PUNum = ls_PUNum + ls_Temp
			END IF
		
			//Stop when we reach the end of the line
			IF ll_Position >= LEN(ls_CatNote) THEN
				li_Stop = 1
			ELSE
				ll_Position++
			END IF
		LOOP
	
		IF LEN(TRIM(ls_PUNum)) > 0 THEN
			lnv_shipment.of_setpickupnumber( ls_PUNum )
		END IF
	END IF

ELSE
		li_Return = -1
		THIS.of_AddError ( "Additional EDI processing failed." )
END IF

RETURN li_Return
end function

protected function integer of_processeventdata ();Int		li_Return = 1
Int		li_EventCount
String	ls_Filter
String	ls_type
Int		li_Seq
Int		i
//Boolean	lb_Intermodal
String	ls_Zip
String	ls_Name
Any		la_Value
Long		ll_Site
String	ls_ExistingEvents
Boolean	lb_UpdateOrigin
Int		li_IRCnt

n_cst_edisegment	lnva_Segments[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Event		lnva_Events[]

lb_UpdateOrigin = TRUE
li_IRCnt = 0


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
	
//	lb_Intermodal = THIS.of_Ismoveintermodal( )
	
	FOR i = 1 TO li_EventCount
		
		IF lnva_Events[i].of_IsConfirmed( ) THEN
			CONTINUE 
		END IF
		lnva_Events[i].of_SetAllowFilterSet ( TRUE )
		
//		IF	lb_Intermodal THEN
//			ls_Type = lnva_Events[i].of_Gettype ( )
//			li_Seq = lnva_Events[i].of_GetShipSeq ( )
//			ls_Filter = "Eventtype = '" +  ls_Type + String (li_Seq) + "'"
//			ids_Eventmapping.SetFilter( ls_Filter )
//			ids_Eventmapping.Filter ( )
//			lnva_Segments = inva_segments
//		ELSE		
			THIS.of_Getstopgroup( lnva_Events[i].of_GetImportReference( ) , lnva_Segments )					
//		END IF
		
		// this is where the data gets processed and set
		IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
			li_Return = -1
		END IF
		
		// this gets access to the specific stop group
		THIS.of_Getstopgroup( lnva_Events[i].of_GetImportReference( ) , lnva_Segments )	
		IF THIS.of_Setdataonbeo( lnva_Events[i] , ids_Eventmapping , lnva_Segments) <> 1 THEN  
			li_Return = -1
		END IF
		
		///// special processing to try and set the site if it is null
		IF IsNull ( lnva_Events[i].of_GetSite ( ) ) THEN
			THIS.of_getvalue( "N1", "2", "", lnva_Segments, la_Value)	
			ls_Name = String ( la_Value )
			THIS.of_getvalue( "N4", "3", "", lnva_Segments, la_Value)	
			ls_Zip = String ( la_Value )
			ll_Site = gnv_cst_companies.of_Find ( ls_Name , ls_Zip )
			IF ll_Site > 0 THEN
				lnva_Events[i].of_SetSite( ll_Site )
			END IF		
		END IF
	
		IF NOT isNull(lnva_Events[i].of_GetImportReference()) THEN
			li_IRCnt++
		END IF

		
		ls_ExistingEvents += UPPER ( lnva_Events[i].of_GetType ( ) )
	
		
//		DESTROY ( lnva_Events[i] )
	NEXT
END IF

IF len ( ls_ExistingEvents ) = 0 OR isNull ( ls_ExistingEvents ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN //and li_IRCnt = 3 THEN

	CHOOSE CASE ls_ExistingEvents
				
		CASE "HPR" 
			lnv_Shipment.of_setorigin(lnva_Events[2].of_getsite())
			
		CASE "HRHR"
			CHOOSE CASE THIS.of_GetMoveDirection ( )
				CASE cs_export
					lnv_Shipment.of_setorigin(lnva_Events[3].of_getsite())
						
				CASE cs_import
					lnv_Shipment.of_setfinaldestination(lnva_Events[2].of_getsite())
				
			END CHOOSE
							
	END CHOOSE
END IF



n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_Destroy( lnva_Events )

RETURN li_Return
end function

on n_cst_edishipment_manager_oocl.create
call super::create
end on

on n_cst_edishipment_manager_oocl.destroy
call super::destroy
end on

