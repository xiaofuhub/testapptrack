$PBExportHeader$n_cst_edishipment_manager_chrobinson_int.sru
forward
global type n_cst_edishipment_manager_chrobinson_int from n_cst_edishipment_manager_chrobinson
end type
end forward

global type n_cst_edishipment_manager_chrobinson_int from n_cst_edishipment_manager_chrobinson
end type
global n_cst_edishipment_manager_chrobinson_int n_cst_edishipment_manager_chrobinson_int

type variables
Constant String	cs_CHRobinsonIntScac = "RBIN"
end variables

forward prototypes
protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[])
protected function integer of_applyeventstructurelogic (ref n_cst_beo_event anva_events[])
protected function string of_getmovedirection ()
protected function integer of_processeventdata ()
protected function integer of_additems ()
protected function integer of_processitemdata ()
protected function datastore of_getpendingdatastore ()
protected function integer of_addintermodalitemsifneeded ()
protected function integer of_setitemdataintermodal ()
end prototypes

protected function integer of_initializenewevents (ref n_cst_beo_event anva_eventlist[]);Int		li_Return = 1
Int		li_EventCount
Int		i
Any		la_Value

n_cst_edisegment lnva_segments[]

li_EventCount = UpperBound ( anva_eventlist )

FOR i = 1 TO li_EventCount
	anva_eventlist[i].of_setAllowFilterSet ( TRUE )
	
	// set the import reference = to the L11/FSN value
	THIS.of_GetStopgroup( i , lnva_segments[] )
	IF THIS.of_getValue( "L11","1" ,"2=FSN", lnva_segments, la_Value ) = 1 THEN
		anva_EventList[i].of_Setimportreference ( Integer ( la_Value )	 )
	END IF
NEXT

THIS.of_Applyeventstructurelogic( anva_EventList )


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
				THIS.of_GetSegments( "MS3", lnva_segmentsResults )				
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )
				
			END IF
			
		CASE "HR" // HOOK DROP	// WE EXPECT THIS ONE
			
			CHOOSE CASE THIS.of_GetMovedirection( )
					
				CASE cs_export
					// we are adding the event to the beginning of the existing events 
					// because this is an export shipment and CHR want to know about the 
					// hook at the cust and the drop at the ramp and the assigned numbers have
					// already been put on the last hook and drop.
					lnv_Shipment.of_Addevents( {'H','R'} , 1 , lnv_Dispatch , lla_NewEventIds )
					IF Upperbound ( lla_NewEventIds ) = 2 THEN
						lnv_Event.of_SetSourceID ( lla_NewEventIds[1] )
						
						IF THIS.of_GetSegments( "L11", lnva_segments )	> 0 THEN // mapping for L11/LU will need to be added to the PSR						
						ELSE							
							THIS.of_GetStopgroup( 2 , lnva_segments )	
						END IF
						
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
				THIS.of_GetSegments( "L11", lnva_segmentsResults )	// mapping for L11/LU will need to be added to the PSR
				THIS.of_Setdataonbeo( lnv_Event , ids_eventmapping , lnva_segmentsResults )					
			END IF
			
		CASE ELSE // do nothing
			
			
	END CHOOSE
	
	
	DESTROY ( lnv_Event )
	
END IF

RETURN li_Return
end function

protected function string of_getmovedirection ();//
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
//	Description	: CHR sends the L11, SI value to indicate the move type. this is what we will use
//						IPU - intermodal Pick up
//						IDL - Intermodal Delivery
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
String				ls_Value
String				ls_Direction
Any					la_Value


IF THIS.of_Getvalue( "L11", "1" ,"2=SI", inva_segments , la_Value ) = 1 THEN

	CHOOSE CASE String ( la_Value )
			
		CASE "IPU" 
			ls_Direction = cs_Export
			
		CASE "IDL"
			ls_Direction = cs_Import
			
		CASE ELSE
			ls_Direction = cs_oneway
			
	END CHOOSE
	
END IF

RETURN ls_Direction

end function

protected function integer of_processeventdata ();Int		li_Return = 1
Int		li_EventCount
Int		i
String	ls_Zip
String	ls_Name
Any		la_Value
Long		ll_Site
String	ls_Condition
Int		li_ImportRef

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
	
		li_ImportRef = lnva_Events[i].of_GetImportreference( )
		
		// this gets access to the specific stop group
		IF li_ImportRef >= 0 THEN
			ls_Condition = "2=FSN,"
			ls_Condition += "1=" + String ( li_ImportRef )
				
			THIS.of_GetStopgroupbycondition( "L11" , ls_Condition , lnva_Segments )
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
			
		END IF
	
		DESTROY ( lnva_Events[i] )
		
	NEXT
END IF

RETURN li_Return






end function

protected function integer of_additems ();RETURN THIS.of_Addintermodalitemsifneeded( )
end function

protected function integer of_processitemdata ();///////////////////////////////////////////////////////////////////////////////
//
//    Name            :of_ProcessItemData
// 
//    Access        :Protected
//
//    Arguments    :NONE
//           
//
//    Return        :Int
//                   
//                   
//                   
//                       
//    Description    : Set Freight Charges and Accessorial charges from L3 segment
//                                       
//
//     Written by    :Rick ??
//         Date    :  ????-??-??
//
//////////////////////////////////////////////////////////////////////////////
//
//    Revision History    :date, name, comment
//                        2007-02-08, SAT, Freight and Accessorial charges now being sent in L11 segments
//                        This is now done by of_SetItemDataIntermodal( )
//
//////////////////////////////////////////////////////////////////////////////






RETURN THIS.of_SetItemDataIntermodal( )

/*
Int        li_Return = 1
Int        li_ItemCount
String    ls_TotalCharge
String    ls_Acc
String    ls_Qty
Dec {2}    lc_Freight
Dec {2}    lc_Acc
Dec {2}    lc_Total
Int        li_Qty

n_cst_edisegment    lnva_ItemSegments[]

n_cst_beo_Shipment    lnv_Shipment
n_cst_bso_Dispatch    lnv_Dispatch
n_cst_beo_Item            lnva_ItemList[]
n_cst_beo_Item            lnva_EmptyItemList[]

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
    CH ROBINSON sends the total amount of the shipment in the L305 segment the accessorial charges are sent in
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
            IF li_ItemCount > 0 THEN    // there should only be one of these
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
            IF li_ItemCount > 0 THEN    // there should only be one of these
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

*/
end function

protected function datastore of_getpendingdatastore ();DataStore		lds_Pending
String		ls_Scac
lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )

ls_Scac = THIS.cs_chrobinsonIntScac

// S.A.T 5/4/06 -- We want to process the CH_ROBINSON test SCAC in the same manner as the production SCAC
// lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and sendersCode = '" + ls_Scac + "'")
lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and ( sendersCode = '" + ls_Scac + "' OR sendersCode = 'RBINTEST') ")



RETURN lds_Pending
end function

protected function integer of_addintermodalitemsifneeded ();///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_addintermodalitemsifneeded
//  
//	Access		:Protected
//
//	Arguments	:NONE
//			
//
//	Return		:Int 
//					1 = success
//					-1 = Failure
//					
//						
//	Description	: CH Robinson send the total charge accross in the L305 segment. They send the Accessorial
//						charge accross in the L#06 Segment. Therefore the freight charge is L305 - L306
//					
// 	Written by	:Rick Zacher
// 		Date	:mm/dd/yyyy
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//				2007-02-07, Samuel Towle, Changes made by CH Robinson in December 2006 now have individual charges in L11 segments
//				Count L11 segments with "22" qualifier and create items.  Then use item mapping to populate.					
//				
//				2007-02-12, Samuel Towle, The L11 will consist of a 3 digit code (static) plus a dash and description (dynamic)
//				We will look to the static code only.
//////////////////////////////////////////////////////////////////////////////


	
Int		li_ItemCount
Int		li_Return = 1
Int		i
Int		li_AccItemCount
Int		li_FreightItemCount
Int		li_FreightCount
Int		li_AccCount
Int		li_LElevenCount
Long		ll_NewItemID
String	ls_ItemType
String	ls_qualifier



n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_csT_beo_Item			lnva_Items[]
n_cst_ediSegment		lnva_ItemSegments[]
n_cst_ediSegment		lnva_LElevenSegments[]
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
// Not all L11 segments will have charges only the ones with a '22' qualifier.

li_ItemCount = 0	// Reset Item Count
IF li_Return = 1 THEN

	li_LElevenCount = THIS.of_GetSegments( "L11",lnva_ItemSegments)
	// Check each L11 segment.  If it's a charge segment increment item count and store in array
	FOR i = 1 to li_LElevenCount
		lnva_Itemsegments[ i ].of_getvalue( {2}, ls_qualifier)
		IF ls_qualifier = "22" THEN
			li_ItemCount ++
			lnva_LElevenSegments[ li_ItemCount ] = lnva_Itemsegments[ i ]
		END IF
	NEXT

	FOR i = 1 TO li_ItemCount		
		lnva_LElevenSegments[ i ].of_getvalue( {3}, ls_ItemType)
		IF left (ls_ItemType,3) = "400" THEN							// Look at the 3 char code only 2007-02-12
			li_FreightItemCount ++
		ELSE
			li_AccItemCount ++
		END IF
	NEXT	
	
	
	FOR i = 1 TO li_ItemCount		
		lnva_LElevenSegments[ i ].of_getvalue( {3}, ls_ItemType)
		//  If there are more freight items in the txn than on the shipment, add another freight item.
		IF left ( ls_ItemType, 3 ) = "400" AND li_FreightCount < li_FreightItemCount THEN	// Look at the 3 char code only 2007-02-12
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
		IF left (ls_ItemType, 3) <> "400" AND li_AccCount < li_AccItemCount THEN		// Look at the 3 char code only 2007-02-12
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

protected function integer of_setitemdataintermodal ();///////////////////////////////////////////////////////////////////////////////
//
//    Name            :of_setitemdataintermodal
// 
//    Access        :Protected
//
//    Arguments    :NONE
//           
//
//    Return        :integer
//                       
//                       
//    Description    : Determine what data we use for freight and accessorial items.
//                     
//
//     Written by    :Samuel Towle
//         Date    :2007-02-08
//
//////////////////////////////////////////////////////////////////////////////
//
//    Revision History    :date, name, comment
//                2007-02-12, Samuel Towle, The L11 will consist of a 3 digit code (static) plus a dash and description (dynamic)
//                We will look to the static code only.
//
//   
//////////////////////////////////////////////////////////////////////////////

//  CHRobinson now uses an individual L11 segment for each line item.
//  There may be more than one freight and accessory line item in an order.
//  There is no item number provided.
//
//     L11_01 is the dollar amount. (Decimal Number)
//     L11_02 is the qualifier "22" for all items.
//     L11_03 is the Description/charge code "400-Line Haul", "405-Fuel Surcharge (IMDL)" etc.



Dec {2}    lc_Freight
Dec {2}    lc_Acc
Int        i
Int        li_Count
Int        li_Return = 1
Int        li_ItemCount
Int        li_Null
Int        li_AccItemCount
Int        li_FreightItemCount
Int        li_LElevencount
String    ls_Freight
String    ls_Acc
String    ls_ReferenceID
String    ls_qualifier


n_cst_edisegment    lnva_ItemSegments[]
n_cst_edisegment    lnva_FreightSegments[]
n_cst_edisegment    lnva_AccessorialSegments[]
n_cst_edisegment    lnva_LElevenSegments[]

n_cst_beo_Shipment    lnv_Shipment
n_cst_bso_Dispatch    lnv_Dispatch
n_cst_beo_Item            lnva_ItemList[]
n_cst_beo_Item            lnva_EmptyItemList[]
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

li_Count = 0    // Reset Item Count
IF li_Return = 1 THEN

    li_LElevenCount = THIS.of_GetSegments( "L11",lnva_ItemSegments)
   
    // Check each L11 segment.  If it's a charge segment increment item count and store in array
    FOR i = 1 to li_LElevenCount
        lnva_Itemsegments[ i ].of_getvalue( {2}, ls_qualifier)
        IF ls_qualifier = "22" THEN
            li_Count ++
            lnva_LElevenSegments[ li_Count ] = lnva_Itemsegments[ i ]
        END IF
    NEXT

   
    // Get the count of freight and count of accessorial items place into Freight array and Accessorial array
    FOR i = 1 TO li_Count
        lnva_LElevenSegments[i].of_getvalue( {3} , ls_ReferenceID )
        IF left ( ls_ReferenceID, 3 ) = "400" THEN                        // 2007-02-12 Look at 3 char code only
            li_FreightItemCount ++
            lnva_FreightSegments[ li_FreightItemCount ] = lnva_LElevenSegments [i]
        ELSE
            li_AccItemCount ++
            lnva_AccessorialSegments[ li_AccItemCount ] = lnva_LElevenSegments [i]
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
            lnva_Freightsegments[i].of_getvalue( {1}, ls_Freight)       
   
            IF IsNumber ( ls_Freight ) THEN
                lc_Freight = Dec ( ls_Freight )       
            END IF
       
            // First set data using the entire segment list
            // Necessary if we want any other segment data to populate into items

       
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
           
            //    Set Rate type and amount here not in mappings
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
            lnva_Accessorialsegments[i].of_getvalue( {1}, ls_Acc)
           
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
       
                //    Set Rate type and amount here not in mappings
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
ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()

RETURN li_Return


end function

on n_cst_edishipment_manager_chrobinson_int.create
call super::create
end on

on n_cst_edishipment_manager_chrobinson_int.destroy
call super::destroy
end on

