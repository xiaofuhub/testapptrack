$PBExportHeader$n_cst_edishipment_manager_hubgroup.sru
forward
global type n_cst_edishipment_manager_hubgroup from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_hubgroup from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_hubgroup n_cst_edishipment_manager_hubgroup

type variables
Private:
Constant String	cs_HUBScac = "HUBG"


// instructions that HUB may send, if you add one here make sure to add to the list in 
// of_getInstructions
Constant String	cs_PullLoaded = "Pull Loaded from Pickup"
Constant String	cs_DropEmpty  = "Drop Empty at Pickup"
Constant String	cs_DropLoaded  = "Drop Loaded at Delivery"
Constant String	cs_StaywithPickup  = "Stay with Pickup"
Constant String	cs_StaywithDelivery  = "Stay with Delivery"


end variables

forward prototypes
protected function integer of_addequipment ()
protected function integer of_geteventstructure (ref string asa_eventtypes[])
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[])
protected function integer of_addevents (ref n_cst_beo_event anva_events[])
private function string of_getinstructions ()
protected function integer of_getequipmentsegments (ref n_cst_edisegment anva_eqsegments[])
protected function integer of_additems ()
protected function datastore of_getpendingdatastore ()
protected function boolean of_ismoveintermodal ()
protected function integer of_setitemdataintermodal ()
protected function integer of_setcharges (n_cst_beo_item anv_targetitem)
protected function integer of_setfreightcharge (ref n_cst_beo_item anv_freightitem)
end prototypes

protected function integer of_addequipment ();Long		ll_EquipmentCount
Long		i
Int		li_Return = 1
String	ls_temp
String	ls_Prefix
String	ls_Number
Long		ll_Number
Boolean	lb_CreateTemp
Boolean	lb_Reload
Int		li_tempCount
Long		ll_ShipmentID
Long		ll_EquipmentID

n_cst_beo_Shipment	lnv_Shipment
n_cst_EquipmentManager	lnv_EqMan
n_cst_beo_Equipment2	lnv_Equipment
n_Cst_edisegment		lnva_EquipmentSegments[]
n_cst_Bso_Dispatch	lnv_Disp

lnv_Shipment = THIS.of_GEtShipment ( )
IF isValid ( lnv_Shipment ) THEN
	ll_ShipmentID = lnv_Shipment.of_GetID ( ) 
END IF

ll_EquipmentCount = THIS.of_GetEquipmentsegments( lnva_EquipmentSegments )
//ll_EquipmentCount = THIS.of_Getsegments( "N7" , lnva_EquipmentSegments )
FOR i = 1 TO ll_EquipmentCount
	
	lb_Reload = FALSE
	
	IF lnva_EquipmentSegments[i].of_getvalue( {1}, ls_temp) = 1 THEN
		ls_Prefix = ls_temp
	END IF
	
	IF lnva_EquipmentSegments[i].of_getvalue( {2}, ls_temp) = 1 THEN
		ls_Number = ls_temp
	END IF
	
	// 1st, check to see if the equipment already exists on another shipment
	ll_EquipmentID = lnv_EqMan.of_GetIdFromRef ( ls_Prefix + ls_Number )
	
	CHOOSE CASE ll_EquipmentID
			
		CASE -1
			THIS.of_Adderror( "More than one active piece of equipment was found with the number " + ls_Prefix + ls_Number + "."  )
		CASE is > 0	
			lnv_Disp = THIS.of_GetDispatch( )
		
			lnv_Disp.of_Retrieveequipment( {ll_EquipmentID} )
			lnv_Equipment = CREATE n_cst_beo_Equipment2
			lnv_Equipment.of_SetAllowFilterSet( TRUE ) 
			lnv_Equipment.of_SetSource ( lnv_Disp.of_GetEquipmentcache( ) )
			lnv_Equipment.of_SetSourceID ( ll_EquipmentID )
			
			IF IsNull ( lnv_Equipment.of_GetReloadshipment( ) ) THEN
				lb_Reload = TRUE
				lnv_Equipment.of_SetReloadshipment(ll_ShipmentID)
			END IF
			DESTROY ( lnv_Equipment )
			
	END CHOOSE
		
	IF Not lb_Reload THEN

		IF Len ( ls_Prefix ) = 0 THEN
			IF Len ( ls_Number ) > 0 THEN
				IF isNumber ( ls_Number ) THEN
					ll_Number = Long ( ls_Number )
					IF ll_Number = 0 THEN
						lb_CreateTemp = TRUE
					END IF
				END IF
			ELSE
				lb_CreateTemp = TRUE
			END IF
		END IF
		
		lnv_equipment = THIS.of_getnewequipment( )
		
		IF lb_CreateTemp THEN
			li_tempCount ++
			ls_Temp = "UNK" + String ( li_tempCount ) + "-" + String ( ll_ShipmentID )
		END IF
		
		IF isValid ( lnv_Equipment ) AND lb_CreateTemp THEN
			lnv_Equipment.of_SetNumber( ls_Temp )
		END IF
		
		DESTROY ( lnv_Equipment )
		
	END IF
	
NEXT


RETURN li_Return
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
//
//
//
// 	Written by	:Rick Zacher
// 		
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
Int		li_Return = 1
Long		ll_newID
String	ls_Value
String	ls_Instructions

n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_beo_shipment	lnv_Shipment
n_cst_beo_Event		lnv_Event
n_cst_edisegment	lnva_Segments[]

	
IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF Not IsValid ( lnv_Shipment ) THEN
		li_Return = -1
		THIS.of_AddError ( "Shipment returned was not valid.")
	END IF
END IF	
	
IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
		THIS.of_AddError ( "Could not create dispatch object." )
	END IF
END IF

ls_Instructions = THIS.of_getInstructions( )
			
li_SegmentCount = THIS.of_Getsegments( "S5", lnva_Segments )

FOR i = 1 TO li_SegmentCount
	
	lnva_Segments[i].of_getvalue( {2}, ls_Temp )
	
	CHOOSE CASE ls_Temp
							
		CASE  "LD" ,"PL" ,"CL", "PA" , "AL" ,"RT"
			
			IF ls_Instructions = cs_pullloaded THEN
				ls_CurrentEvent = gc_dispatch.cs_eventtype_Hook
			ELSE
				ls_CurrentEvent = gc_dispatch.cs_eventtype_pickup			
			END IF
			
		CASE	"CU" , "PU" , "UL" ,"LE" , "SL", "SU" ,"DT" 
			
			IF ls_Instructions = cs_dropempty OR ls_Instructions = cs_droploaded THEN
				ls_CurrentEvent =	gc_dispatch.cs_eventtype_Drop
			ELSE // I left the default be a deliver since it does not appear as though hib sends
				//   instructions for highway moves.
				ls_CurrentEvent =	gc_dispatch.cs_eventtype_deliver	
			END IF
			
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
	
	// we need to set this import reference here
	lnv_SHipment.of_Addevent(lsa_Events[ li_EventCount ] , i, lnv_Dispatch ,ll_NewID )
	lnv_Shipment.of_GetEvent( li_EventCount ,lnv_Event)
	IF isValid ( lnv_Event ) THEN
		lnv_Event.of_setAllowfilterset( TRUE )
		lnva_Segments[i].of_getvalue( {1}, ls_Value )
		lnv_Event.of_Setimportreference( Long ( ls_Value ) )		
	END IF
	
	DESTROY ( lnv_Event )

NEXT
	



asa_eventtypes[] = lsa_Events

RETURN li_EventCount


/*
//AL "Advance Loading"
CL "Complete"
CN "Consolidate"
//CU "Complete Unload"
DR "Deramp and Ramp for Subsequent Loading"
//DT "Drop Trailer"
HT "Heat the Shipment"
IN "Inspection"
//LD "Load"
//LE "Spot for Load Exchange (Export)"
//PA "Pick-up Pre-loaded Equipment"
//PL "Part Load"
//PU "Part Unload"
//RT "Retrieval of Trailer"
//SL "Spot for Load"
//SU "Spot for Unload"
TL "Transload"
//UL "Unload"
WL "Weigh Loaded"
*/
	




end function

protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[]);///////////////////////////////////////////////////////////////////////////////
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
//	Description	: this where we try to figure out what type of move we are being sent and create the correct event structure in the 
//					  shipment. I.E. if we are only sent a Drop stop, we will then add the first implied hook and the implied Hook and drop 
//					  at the end of the shipment.
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
Int		li_Return = 1
Int		li_EventCount
Int		i
Long		lla_NewEventIds[]
String	ls_ExistingEvents
String	ls_Instructions

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
	lnva_EventList = anva_events
	li_EventCount = UpperBound ( lnva_EventList )
	
	FOR i = 1 TO li_EventCount 
		ls_ExistingEvents += UPPER ( lnva_EventList[i].of_GetType ( ) )
		DESTROY ( lnva_EventList[i] )
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

			
		CASE "HR" // HOOK DROP
			ls_Instructions = THIS.of_Getinstructions( )
			// Add second Hook and DROP  
			// only if this is not a one way
			IF lnv_Shipment.of_getMovecode( ) <> "O" and ls_instructions <> cs_pullloaded THEN
			// if instructions are not cs_pullloaded then
			
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
			// add drop
			lnv_Shipment.of_Addevents ( {'R'} , 3 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )				
			END IF
			
		CASE "PR" // PickUp Drop
						
			// Add First hook
			lnv_Shipment.of_Addevents ( {'H'} , 1 , lnv_Dispatch , lla_NewEventIds )
			IF UpperBound ( lla_NewEventIds ) = 1 THEN					
				lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
				THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )					
			END IF
			
		CASE ELSE // do nothing
			
			
	END CHOOSE
	
	
	DESTROY ( lnv_Event )
	
END IF

RETURN li_Return
end function

protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[]);Int		li_Return = 1
Int		li_EventCount
Int		i

li_EventCount = UpperBound ( anva_eventlist )

FOR i = 1 TO li_EventCount
	anva_eventlist[i].of_setAllowFilterSet ( TRUE )
NEXT

THIS.of_Applyeventstructurelogic( anva_EventList )

RETURN li_Return



end function

protected function integer of_addevents (ref n_cst_beo_event anva_events[]);///////////////////////////////////////////////////////////////////////////////
//
//	Name			: of_addevents
//  
//	Access		: Private
//
//	Arguments	: n_cst_beo_Event	[] by reference
//			
//
//	Return		: Int # of events
//					
//						
//	Description	: this does the acual addition of the events to the shipment and initializes them
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
String	lsa_Events[]
Int	li_EventCount 
Int	li_Return = 1
Long	ll_NewID
Int	i

n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_beo_Shipment	lnv_Shipment



IF li_Return = 1 THEN
	lnv_Dispatch = THIS.of_Getdispatch( )
	IF NOT isValid ( lnv_Dispatch ) THEN
		li_Return = -1
		THIS.of_AddError ( "Could not create dispatch object." )
	END IF
END IF


IF li_Return = 1 THEN
	lnv_Shipment = THIS.of_Getshipment( )
	IF Not IsValid ( lnv_Shipment ) THEN
		li_Return = -1
		THIS.of_AddError ( "Shipment returned was not valid.")
	END IF
END IF


IF li_Return = 1 THEN
	li_EventCount = THIS.of_GetEventStructure( lsa_Events )
END IF

IF li_Return = 1 THEN
	lnv_SHipment.of_GetEventlist( anva_events[] )
	li_Return = UpperBound ( anva_events )
	THIS.of_Initializenewevents( anva_events[] )		
END IF
	
RETURN li_Return  
end function

private function string of_getinstructions ();String	 ls_Return
String	ls_Instructions
Int		li_Count
Int		i

n_cst_edisegment	lnva_Instructions[]

li_Count = THIS.of_Getsegments( "AT5", lnva_Instructions ) 
	
FOR i = 1 TO li_Count
	lnva_Instructions[i].of_getvalue( {3}, ls_Instructions )
	CHOOSE CASE ls_Instructions
		CASE cs_dropempty, cs_droploaded , cs_pullloaded , cs_staywithdelivery , cs_staywithpickup
			ls_Return = ls_Instructions
			EXIT 
	END CHOOSE
NEXT
	

			
RETURN ls_Return
end function

protected function integer of_getequipmentsegments (ref n_cst_edisegment anva_eqsegments[]);Long		ll_EquipmentCount
Long		i
Int		li_Return = 1
Int		li_Keep
String	ls_temp

n_Cst_edisegment		lnva_EquipmentSegments[]
n_Cst_edisegment		lnva_KeepSegments[]

IF THIS.of_Ismoveintermodal( ) THEN
	ll_EquipmentCount = THIS.of_Getsegments( "N7" , lnva_EquipmentSegments )
END IF

FOR i = 1 TO ll_EquipmentCount
	
	IF lnva_EquipmentSegments[i].of_getvalue( {2}, ls_temp) = 1 THEN
		// we are not going to create equipment when HUB sends 00000000 for a container number
		IF Long ( ls_temp ) > 0 THEN
			li_Keep ++
			lnva_KeepSegments [ li_Keep ] = lnva_EquipmentSegments[i]
		END IF
	END IF	
	
NEXT

anva_eqsegments[] = lnva_keepSegments
li_Return = li_Keep

RETURN li_Return
end function

protected function integer of_additems ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_additems
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		: Int 
//						1 success
//						-1 Failure
//						
//	Description	:  Hub sends items in the same way in both intermodal moves and HW moves.
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
Int	li_return = 1

IF THIS.of_Ismoveintermodal( ) THEN
	IF THIS.of_addintermodalitemsifneeded( ) <> 1 THEN
		li_Return = -1
	END IF
ELSE
	IF THIS.of_AddNonIntermodalItems ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

RETURN li_Return
end function

protected function datastore of_getpendingdatastore ();String			ls_Scac
DataStore		lds_Pending

lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )
ls_Scac = THIS.cs_HUBScac

lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and ( sendersCode = '" + ls_Scac + "' OR sendersCode = 'HUBTEST') ")



RETURN lds_Pending
end function

protected function boolean of_ismoveintermodal ();RETURN SUPER::of_ismoveintermodal( ) OR THIS.of_Getinstructions( ) = THIS.cs_DropEmpty
end function

protected function integer of_setitemdataintermodal ();Int		li_Return = 1
Int		li_ItemCount
Int		li_Null
String	ls_Freight
String	ls_Acc
Dec {2}	lc_Freight
Dec {2}	lc_Acc

n_cst_edisegment		lnva_ItemSegments[]
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
	IF THIS.of_GetSegments( "L3",lnva_ItemSegments) > 0 THEN
		/////////////////////////  FREIGHT ITEMS		
		
		lnva_Itemsegments[ 1 ].of_getvalue( {3}, ls_Freight)
		IF IsNumber ( ls_Freight ) THEN
			lc_Freight = Dec ( Left ( ls_Freight , Len ( ls_Freight ) - 2 ) + "." + Right ( ls_Freight , 2 ) )		
		END IF
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
					
		/////////////////////////  ACC ITEMS
		
		lnva_ItemList = lnva_EmptyItemList
		lnva_Itemsegments[ 1 ].of_getvalue( {6}, ls_Acc)
		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec ( Left ( ls_Acc , Len ( ls_Acc ) - 2 ) + "." + Right ( ls_Acc , 2 ) )
		END IF
		
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
	
	END IF
	
END IF

ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()

RETURN li_Return

end function

protected function integer of_setcharges (n_cst_beo_item anv_targetitem);Int		li_Return = 1
Int		li_ItemCount
String	ls_TotalCharge
String	ls_Acc
String	ls_Qty
Dec {2}	lc_Freight
Dec {2}	lc_Acc
Dec {2}	lc_Total
Int		li_Qty

n_cst_edisegment	lnva_ItemSegments[]

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnva_ItemList[]
n_cst_beo_Item			lnva_EmptyItemList[]

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
	
	/*
	 the total amount of the shipment in the L305 segment the accessorial charges are sent in
	the L306 segment. Therefore the freight charge is L305 - L306
	
	*/
	
		
	IF THIS.of_GetSegments( "L3",lnva_ItemSegments) > 0 THEN
		/////////////////////////  Total Charge - Acc Charge = FREIGHT charge
		lnva_Itemsegments[ 1 ].of_getvalue( {5}, ls_TotalCharge)
		lnva_Itemsegments[ 1 ].of_getvalue( {6}, ls_Acc )
		
		IF IsNumber ( ls_TotalCharge ) AND IsNumber ( ls_Acc ) THEN
			lc_Total = Dec ( Left ( ls_TotalCharge , Len ( ls_TotalCharge ) - 2 ) + "." + Right ( ls_TotalCharge , 2 ) )		
			lc_Acc = Dec ( Left ( ls_Acc , Len ( ls_Acc ) - 2 ) + "." + Right ( ls_Acc , 2 ) )		
			
			lc_Freight = lc_Total - lc_Acc
			
		END IF
	
		IF lc_Freight > 0 THEN
			
			lnva_Itemsegments[ 1 ].of_getvalue( {11}, ls_Qty )
			li_Qty = Integer ( ls_Qty )
			IF li_Qty <= 0 THEN
				li_Qty = 1 
			END IF
			
			
			ids_itemmapping.SetFilter ( "itemtype = 'L'" )
			ids_itemmapping.Filter ()
			
			lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedFreight , lnva_ItemList)
			li_ItemCount = UpperBound ( lnva_ItemList ) 
			IF li_ItemCount > 0 THEN	
				lnva_ItemList[1].of_setquantity( li_Qty )
				IF THIS.of_setdataonbeo( lnva_ItemList[1], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Data could not be set on the Freight item" )
				END IF
				
				lnva_ItemList[1].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[1].of_setamount( lc_Freight )	

				DESTROY ( lnva_ItemList[1] )	
				lnva_ItemList = lnva_EmptyItemList
			END IF
				
		END IF
		
		
		IF lc_Acc > 0 THEN	
			
			li_Qty = 1 
			ids_itemmapping.SetFilter ( "itemtype = 'A'" )
			ids_itemmapping.Filter ()
			
			lnv_Shipment.of_Getitemsforeventtype( n_cst_Constants.cs_ItemEventType_ImportedAcc , lnva_ItemList)
			li_ItemCount = UpperBound ( lnva_ItemList ) 
			IF li_ItemCount > 0 THEN	
				lnva_ItemList[1].of_setquantity( li_Qty )
				IF THIS.of_setdataonbeo( lnva_ItemList[1], ids_itemmapping ) <> 1 THEN
					li_Return = -1
					THIS.of_AddError( "Data could not be set on the Freight item" )
				END IF
				
				lnva_ItemList[1].of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
				lnva_ItemList[1].of_setamount( lc_Acc )	

				DESTROY ( lnva_ItemList[1] )				
			END IF
				
		END IF

	END IF
		
END IF
ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()


RETURN li_Return


end function

protected function integer of_setfreightcharge (ref n_cst_beo_item anv_freightitem);Int		li_Return = 1
Int		li_ItemCount
String	ls_TotalCharge
String	ls_Acc
String	ls_Qty
Dec {2}	lc_Freight
Dec {2}	lc_Acc
Dec {2}	lc_Total
Int		li_Qty

n_cst_edisegment	lnva_ItemSegments[]

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnv_FreightItem
n_cst_beo_Item			lnva_EmptyItemList[]

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

lnv_FreightItem = anv_freightitem

IF li_Return = 1 THEN
	
	/*
	 the total amount of the shipment in the L305 segment the accessorial charges are sent in
	the L306 segment. Therefore the freight charge is L305 - L306
	
	*/
	
		
	IF THIS.of_GetSegments( "L3",lnva_ItemSegments) > 0 THEN
		/////////////////////////  Total Charge - Acc Charge = FREIGHT charge
		lnva_Itemsegments[ 1 ].of_getvalue( {5}, ls_TotalCharge)
		lnva_Itemsegments[ 1 ].of_getvalue( {6}, ls_Acc )
		
		IF IsNumber ( ls_TotalCharge ) AND IsNumber ( ls_Acc ) THEN
			lc_Total = Dec ( Left ( ls_TotalCharge , Len ( ls_TotalCharge ) - 2 ) + "." + Right ( ls_TotalCharge , 2 ) )		
			lc_Acc = Dec ( Left ( ls_Acc , Len ( ls_Acc ) - 2 ) + "." + Right ( ls_Acc , 2 ) )		
			
			lc_Freight = lc_Total - lc_Acc
			
		END IF
	
		IF lc_Freight > 0 THEN
			
			lnva_Itemsegments[ 1 ].of_getvalue( {11}, ls_Qty )
			li_Qty = Integer ( ls_Qty )
			IF li_Qty <= 0 THEN
				li_Qty = 1 
			END IF
						
			lnv_FreightItem.of_setquantity( li_Qty )
					
			lnv_FreightItem.of_Setratetype( appeon_constant.cs_RateUnit_Code_Flat)
			lnv_FreightItem.of_setamount( lc_Freight )					
		END IF
		
	END IF
		
END IF

RETURN li_Return


end function

on n_cst_edishipment_manager_hubgroup.create
call super::create
end on

on n_cst_edishipment_manager_hubgroup.destroy
call super::destroy
end on

