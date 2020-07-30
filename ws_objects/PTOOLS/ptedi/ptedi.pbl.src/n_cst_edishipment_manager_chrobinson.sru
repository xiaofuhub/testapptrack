$PBExportHeader$n_cst_edishipment_manager_chrobinson.sru
forward
global type n_cst_edishipment_manager_chrobinson from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_chrobinson from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_chrobinson n_cst_edishipment_manager_chrobinson

type variables
Constant String	cs_CHRobinsonTLScac = "RBTW"
end variables

forward prototypes
private function integer of_settotals (ref n_cst_beo_item anv_item)
protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[])
protected function integer of_processeventdata ()
protected function integer of_additems ()
protected function integer of_processitemdata ()
protected function datastore of_getpendingdatastore ()
end prototypes

private function integer of_settotals (ref n_cst_beo_item anv_item);Int		li_PU
Int		i
Int		li_Count
Long		ll_Units
Long		ll_Weight
String	ls_Temp
String	ls_ItemRef
Constant	int	ci_WeightPos = 7
Constant	int	ci_UnitPos = 5

n_cst_edisegment	lnva_Segments[]
n_Cst_beo_Item	lnv_Item

lnv_Item = anv_item

ls_ItemRef = lnv_Item.of_GetReference()
li_Pu = lnv_Item.of_GetPickupEvent ( )

IF li_PU > 0 THEN
	THIS.of_Getstopgroup( li_PU , lnva_Segments )
	THIS.of_GetSegments( "OID", lnva_Segments, lnva_Segments )
	li_Count = UpperBound ( lnva_Segments ) 
	FOR i = 1 TO li_Count
		
		IF lnva_Segments[i].of_Meetscondition( "2=" + ls_ItemRef  ) > 0 THEN
			
			lnva_Segments[i].of_Getvalue( {ci_UnitPos} , ls_Temp )
			IF isNumber ( ls_Temp ) THEN
				ll_Units += Long ( ls_Temp )				
			END IF
			
			lnva_Segments[i].of_Getvalue( {ci_WeightPos} , ls_Temp )
			IF isNumber ( ls_Temp ) THEN
				ll_Weight += Long ( ls_Temp )
			END IF
						
		END IF
				
	NEXT
	
	lnv_Item.of_Setquantity( ll_Units )
	lnv_Item.of_Settotalweight( ll_Weight )
	
END IF


RETURN 1

end function

protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[]);Int		li_Return = 1
Int		li_EventCount
Int		i

n_cst_edisegment lnva_segments[]


li_EventCount = UpperBound ( anva_eventlist )

FOR i = 1 TO li_EventCount
	anva_eventlist[i].of_setAllowFilterSet ( TRUE )
	anva_EventList[i].of_Setimportreference ( i )	
NEXT

THIS.of_Applyeventstructurelogic( anva_EventList )


RETURN li_Return



end function

protected function integer of_processeventdata ();Int		li_Return = 1
Int		li_EventCount
Int		i
String	ls_Zip
String	ls_Name
Any		la_Value
Long		ll_Site
Int		li_ImportRef

n_cst_edisegment		lnva_Segments[]
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
		
		li_ImportRef = lnva_Events[i].of_GetImportreference( )
				
		THIS.of_Getstopgroup( li_ImportRef , lnva_Segments )	
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
		
		DESTROY ( lnva_Events[i] )
	NEXT
END IF


RETURN li_Return










end function

protected function integer of_additems ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addItems
//  
//	Access		:Private
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
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
Int	li_StopCount
Int	li_Return = 1
Int	i
Int	li_KeyCount
Int	li_KeyIndex
Any	la_Value
String	ls_StopType
Long	ll_NewItemID
Long	lla_AllignedItemIds[]



String	ls_KeyValue

String	ls_KeySegment
String	ls_KeyElement


Int	li_AllignCount
String	lsa_AllignedValues[]
Int	li_ItemCount
Int	li_ItemIndex
String	lsa_TempKeyValues[]



n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_cst_ediSegment	lnva_StopSegments[]

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
	li_StopCount = THIS.of_GetSegments( "S5",lnva_StopSegments)
	
	FOR i = 1 TO li_StopCount	
		
		THIS.of_GetStopgroup( i , lnva_StopSegments )
		IF THIS.of_Getvalue( "S5" , "2", "", lnva_StopSegments , la_Value ) = 1 THEN
			ls_StopType = STRING ( la_Value )
		ELSE
			CONTINUE
		END IF
		
		li_ItemCount = THIS.of_GetItemcount( lnva_StopSegments, ls_KeySegment, Integer ( ls_KeyElement ) , lsa_TempKeyValues )

		// for each stop see if it is a pu type 
		IF THIS.of_ISstoppickupgroup( ls_StopType ) THEN
						
			FOR li_ItemIndex = 1 TO li_ItemCount
			
				ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
				IF ll_NewItemID > 0 THEN
					lnv_Item.of_SetSourceID ( ll_NewItemID )
					lnv_Item.of_SetEventtypeflag( n_cst_Constants.cs_ItemEventType_ImportedFreight )
					lnv_Item.of_SetPuevent( i )
					lnv_Item.of_SetBlnum( lsa_TempKeyValues [ li_ItemIndex ])  // this is set here so that 
					// i can look up the items and set the totals on them later
										
					li_AllignCount ++
					lsa_AllignedValues[ li_AllignCount ] = lsa_TempKeyValues[li_ItemIndex]
					lla_AllignedItemIds [ li_AllignCount ] = ll_NewItemID
					
				ELSE
					li_Return = -1
					THIS.of_Adderror( "Could not create all items. " )
				END IF
						
			NEXT
			
			
			
			
		// if it is not then see if it is a deliver
		ELSEIF  THIS.of_ISstopdelivergroup( ls_StopType ) THEN
			
			
			FOR li_ItemIndex = 1 TO li_ItemCount // loop through all of delvery items
				
				ls_KeyValue = lsa_TempKeyValues[li_ItemIndex]
			
				FOR li_KeyIndex = 1 TO li_AllignCount  
					IF lsa_AllignedValues [li_KeyIndex] = ls_KeyValue THEN
						ll_NewItemID = lla_AllignedItemIds [li_KeyIndex]
					END IF
				NEXT
				
			NEXT
			
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetDelevent( i )
			END IF
		END IF
		
	
		ll_NewItemID = 0
		
	NEXT
END IF



/////////
n_Cst_EdiSegment	lnva_ItemSegments[]
Dec	lc_Acc
String	ls_Acc
// add an accessorial item if an accessorial amount exists in the L5 segment
li_ItemCount = THIS.of_GetSegments( "L3",lnva_ItemSegments)
	FOR i = 1 TO li_ItemCount	
		
		
		lnva_Itemsegments[ li_ItemCount ].of_getvalue( {6}, ls_Acc)
		
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec (ls_Acc ) 
		END IF
		IF lc_Acc > 0  THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "A" , lnv_Dispatch ) 
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedAcc )			
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create an accessorial item. " )
			END IF
		END IF

	NEXT



/////////

DESTROY ( lnv_Item )
RETURN li_Return
end function

protected function integer of_processitemdata ();Int		li_Return = 1
Int		li_SegmentCount
Int		li_ItemCount
Int		li_ItemGroup
String	ls_StopType
Int		li_Null
Int		li_EventCount
Int		li_FreightInd
Int		li_EDIStop
Int		li_EventIndex
Long		ll_Origin
Long		ll_Dest
Boolean	lb_TotalsSet

n_Cst_beo_Item	lnv_CurrentItem
n_cst_beo_Item	lnva_EmptyItemList[]

n_Cst_beo_Event		lnva_EventList[]
n_cst_edisegment		lnva_StopSegments[]
n_cst_beo_Event		lnv_Event
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Item			lnva_ItemList[]
n_cst_AnyArraySrv		lnv_Array

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
	
	li_EventCount = lnv_Shipment.of_GetEventlist( lnva_EventList )
	
	li_ItemCount = lnv_Shipment.of_Getitemsforeventtype( n_cst_constants.cs_ItemEventType_ImportedFreight  , lnva_ItemList)
	ids_itemmapping.SetFilter ( "itemtype = 'L'" )
	ids_itemmapping.Filter ()
	FOR li_ItemGroup = 1 TO li_ItemCount
	

		lnv_CurrentItem = lnva_ItemList[li_ItemGroup]
		
		THIS.of_Settotals( lnv_CurrentItem )
					
		IF lnv_CurrentItem.of_GetPickupevent( ) = ll_Origin AND lnv_CurrentItem.of_GetDeliverevent( ) = ll_Dest THEN
			 this.of_SetCharges ( lnv_CurrentItem ) 
			lb_TotalsSet = True			
		END IF
		
		/* I added this block on March 3rd because the old processing was not getting
		the correct stop group in the case where users were putting in yard moves or 
		cross docks. The old processing was doing this:
			IF THIS.of_GetStopgroup( nv_CurrentItem.of_getdeliverevent( ) , lnva_StopSegments ) > 0 THEN	
		and in the event that the user put in a yard move, the freight that was pointing to ship_seq 2
		would now be pointing to 4 and there might not be a stop group 4 */
			
		// get the pickup event number
		// then get the edi stop number from that event
		// then get the stop segments for that stop number.
		li_EDIStop = 0
		li_FreightInd = lnv_CurrentItem.of_getpickupevent( )
		For li_EventIndex = 1 TO li_EventCount
			IF lnva_EventList[li_EventIndex].of_Getshipseq( ) = li_FreightInd THEN
				li_EdiStop = lnva_EventList[li_EventIndex].of_Getimportreference( )
				EXIT
			END IF
		NEXT
		IF li_EDIStop = 0 THEN
			li_EDIStop = li_FreightInd
		END IF
					
		IF THIS.of_GetStopgroup( li_EDIStop , lnva_StopSegments ) > 0 THEN		
			THIS.of_SetDataonbeo( lnv_CurrentItem, ids_itemmapping )
			THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping , lnva_StopSegments )
		END IF
		
		
		// get the pickup event number
		// then get the edi stop number from that event
		// then get the stop segments for that stop number.
		li_EDIStop = 0
		li_FreightInd = lnv_CurrentItem.of_getdeliverevent( )
		For li_EventIndex = 1 TO li_EventCount
			IF lnva_EventList[li_EventIndex].of_Getshipseq( ) = li_FreightInd THEN
				li_EdiStop = lnva_EventList[li_EventIndex].of_Getimportreference( )
				EXIT
			END IF
		NEXT
		IF li_EDIStop = 0 THEN
			li_EDIStop = li_FreightInd
		END IF
		
		IF THIS.of_GetStopgroup( li_EDIStop , lnva_StopSegments ) > 0 THEN		
			THIS.of_SetDataonbeo( lnv_CurrentItem, ids_itemmapping )
			THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping , lnva_StopSegments )
		END IF
		
		
		DESTROY ( lnv_CurrentItem )
			
	NEXT
	
	
	IF Not lb_TotalsSet THEN
				
		li_ItemCount = lnv_Shipment.of_GetItemList( lnva_ItemList, n_cst_Constants.cs_ItemType_Freight )
		THIS.of_SetCharges ( lnva_ItemList[li_ItemCount] )
		lnv_Array.of_Destroy( lnva_ItemList )
		
	END IF
	
	
END IF


IF li_Return = 1 THEN
	lnva_ItemList = lnva_EmptyItemList
	lnv_Shipment.of_Getitemsforeventtype( n_cst_constants.cs_ItemEventType_Importedacc  , lnva_ItemList)
	li_ItemCount = UpperBound ( lnva_ItemList ) 
	
	ids_itemmapping.SetFilter ( "itemtype = 'A'" )
	ids_itemmapping.Filter ()
	
	FOR li_ItemGroup = 1 TO li_ItemCount
		THIS.of_setacccharge( lnva_ItemList[li_ItemGroup] )		
		THIS.of_setdataonbeo( lnva_ItemList[li_ItemGroup] , ids_itemmapping )
	
		
	NEXT
	
	
	lnv_Array.of_Destroy( lnva_ItemList )
END IF

lnv_Array.of_Destroy( lnva_EventList )

ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()

RETURN li_Return


end function

protected function datastore of_getpendingdatastore ();DataStore		lds_Pending
String	ls_Scac

lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )

ls_Scac = THIS.cs_chrobinsonTLscac

// S.A.T 5/4/06 -- We want to process the CH_ROBINSON test SCAC in the same manner as the production SCAC
//lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and sendersCode = '" + ls_Scac + "'")
lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and ( sendersCode = '" + ls_Scac + "' OR sendersCode = 'RBTWTEST') ")

RETURN lds_Pending
end function

on n_cst_edishipment_manager_chrobinson.create
call super::create
end on

on n_cst_edishipment_manager_chrobinson.destroy
call super::destroy
end on

