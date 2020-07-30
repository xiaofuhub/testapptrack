$PBExportHeader$n_cst_edishipment_manager_tyson_foods.sru
forward
global type n_cst_edishipment_manager_tyson_foods from n_cst_edishipment_manager
end type
end forward

global type n_cst_edishipment_manager_tyson_foods from n_cst_edishipment_manager
end type
global n_cst_edishipment_manager_tyson_foods n_cst_edishipment_manager_tyson_foods

type variables
Constant String	cs_Tyson_Foods_SCAC = "006903702"
end variables

forward prototypes
protected function datastore of_getpendingdatastore ()
protected function integer of_addnonintermodalitems ()
protected function integer of_processitemdata ()
public function integer of_settotals (ref n_cst_beo_item anv_item)
end prototypes

protected function datastore of_getpendingdatastore ();// S.A.T 5/4/06 -- We want to process the Tyson Foods and Tyson Fresh Meats in the same manner
// Tyson_Foods = 006903702
// Tyson_Fresh_Meats = 4022412367
// Same GS_06 for Test and Production.

DataStore		lds_Pending
String		ls_Scac
lds_Pending = CREATE Datastore
lds_Pending.DataObject = "d_importedshipments"
lds_Pending.SetTransObject(SQLCA )

ls_Scac = THIS.cs_Tyson_Foods_SCAC



lds_Pending.SetSqlselect( "Select * From importedShipments where processed = 0 and ( sendersCode = '" + ls_Scac + "' OR sendersCode = '4022412367') ")



RETURN lds_Pending
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
//	Description	: 
//
//
//
// 	Written by	:Samule Towle
// 		Date	:05/15/2006
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//							8/28/06  S.A.T.  Use S5_05 when no OID segments sent.
//	
//////////////////////////////////////////////////////////////////////////////

// Tyson indicates that occaisionally the use the same OID segment split between two different deliveries.
// That kind of defeats the whole purpose of item matching segments
// ***  8/25/06 *** If it is an iter-warehouse move, they don't send an OID at all

Any		la_Value
Boolean	lb_TakeSegment
Boolean	lb_LineHaulSet
Dec		lc_Acc
Dec		lc_Fgt
Int		li_eventcount
Int		li_StopCount
Int		li_Return = 1
Int		i
Int		li_KeyIndex
Int		li_KeyItem
Int		li_PickIndex
Int		li_DeliverIndex
Int		li_CheckItem
Int		li_CheckItemCount
Int		li_CheckPickIndex
Int		li_CheckDeliverIndex
Int		li_ItemCount
Int		li_ItemIndex
Int		li_AllignCount
Long		ll_SegmentCount
Long		ll_CheckItemID
Long		ll_NewItemID
Long		lla_AllignedItemIds[]
Long		ll_ItemID
Long		ll_Start
Long		ll_End
Long		ll_ChargeStart
Long		ll_ChargeEnd
String	ls_KeyValue
String	ls_KeySegment
String	ls_KeyElement
String	ls_KeyNote
String	ls_StopType
String	lsa_AllignedValues[]
String	ls_CheckNote
String	lsa_TempKeyValues[]
String	ls_Acc
String	ls_Fgt
String	ls_FFNote
String	ls_FFString
String	ls_CurrentSegment
String	ls_ChargeList = 'FSC,FUEL SURCHARGE,MINIMUM CHARGE,Stop,STOP Charges,UNLOADING,PALLET EXCHANGE,CONTINUOUS MOVE 1,CONTINUOUS MOVE 2,COMMERCIAL ZONE,COMMODITY SURCHARGE,QUICK PAY,PREMIUM SERVICE CHARGE,UTILIZATION'
String	ls_FindList[]



n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_csT_beo_Item			lnv_Item
n_cst_ediSegment		lnva_StopSegments[]
n_cst_beo_Item			lnva_ItemList[]




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

// I'm doing this first so I can search for a linehaul freight charge.
// Combine Transaction NTE segments into single string.
lb_LineHaulSet = False

ll_SegmentCount = UpperBound ( inva_segments )
FOR i = 1 TO ll_SegmentCount
	
	ls_CurrentSegment = inva_segments[i].of_getsegmentid( )
	IF ls_CurrentSegment = "NTE" THEN
		inva_segments[i].of_getValue ( {2} , ls_FFNote  )
		IF NOT ISNULL ( ls_FFNote ) THEN
			lb_TakeSegment = TRUE
		ELSE
			lb_TakeSegment = FALSE
		END IF
	ELSEIF ls_CurrentSegment = "N1" OR ls_CurrentSegment = "N7" OR ls_CurrentSegment = "S5" THEN
		lb_TakeSegment = FALSE
		EXIT  // I leave the loop once I see an N1, N7 or S5.  I don't want stop notes.
	END IF
	
	IF lb_TakeSegment THEN
		ls_FFString += ls_FFNote
	END IF

NEXT		

IF li_Return = 1 THEN
	li_StopCount = THIS.of_GetSegments( "S5",lnva_StopSegments)
	
	FOR i = 1 TO li_StopCount	
		
		THIS.of_GetStopgroup( i , lnva_StopSegments )
		IF THIS.of_Getvalue( "S5" , "2", "", lnva_StopSegments , la_Value ) = 1 THEN
			ls_StopType = STRING ( la_Value )
		ELSE
			CONTINUE
		END IF
		
		//  ****  Begin changes 8/28/06 S.A.T. ****
		//  We look for the matching segments and elements first to determine item count.
		//  If not found we'll use alternative S5_05 instead.
		//		
		//		li_ItemCount = THIS.of_GetItemcount( lnva_StopSegments, ls_KeySegment, Integer ( ls_KeyElement ) , lsa_TempKeyValues )
		//
		
		
		li_ItemCount = THIS.of_GetItemcount( lnva_StopSegments, ls_KeySegment, Integer ( ls_KeyElement ) , lsa_TempKeyValues )
		IF li_ItemCount = 0 THEN
			li_ItemCount = THIS.of_GetItemcount( lnva_StopSegments, 'S5', Integer ( '5' ) , lsa_TempKeyValues )
			ls_KeySegment = 'S5'
			ls_KeyElement = '5'
			
		END IF
		
		//  ****  End changed 8/28/06  S.A.T. ****
		
		// Check each stop see if it is a pu type.
		IF THIS.of_ISstoppickupgroup( ls_StopType ) THEN
						
			FOR li_ItemIndex = 1 TO li_ItemCount
			
				ll_NewItemID = lnv_Shipment.of_AddItem ( "L" , lnv_Dispatch ) 
				IF ll_NewItemID > 0 THEN
					lnv_Item.of_SetSourceID ( ll_NewItemID )
					lnv_Item.of_SetEventtypeflag( n_cst_Constants.cs_ItemEventType_ImportedFreight )
					lnv_Item.of_SetPuevent( i )
					lnv_Item.of_SetNote( lsa_TempKeyValues [ li_ItemIndex ])  // this is set here so that 
					// I can look up the items and set the totals on them later
					IF li_ItemIndex = 1 AND NOT lb_LineHaulSet THEN       														// Set Freight Charges on First Freight Item
						ll_Start = POS ( ls_FFString, 'LineHaul Amount' )							// Search Note string name.
						IF ll_Start > 0 THEN																	// Found it.
							ll_ChargeStart = POS (ls_FFString, '$', ll_Start ) + 1				// Find the $ symbol preceeding the charge and add 1
							ll_ChargeEnd = POS ( ls_FFString, '.', ll_Start ) + 2					// Find the decimal in the charge following the charge name and add two for the decimal value.
							ls_Fgt = MID ( ls_FFString, ll_ChargeStart, (ll_ChargeEnd - ll_ChargeStart) + 1 ) // Need to account for inclusive char.
							IF IsNumber ( ls_Fgt ) THEN
								lc_Fgt = Dec (ls_Fgt ) 
							END IF
							IF lc_Fgt >= 0  THEN
								lnv_Item.of_SetRateType ( 'F' )
								lnv_Item.of_SetAmount ( lc_Fgt )
							END IF
							lb_LineHaulSet = True
						END IF
					END IF
					li_AllignCount ++
					lsa_AllignedValues[ li_AllignCount ] = lsa_TempKeyValues[li_ItemIndex]
					lla_AllignedItemIds [ li_AllignCount ] = ll_NewItemID
					
				ELSE
					li_Return = -1
					THIS.of_Adderror( "Could not create all freight items. " )
				END IF
						
			NEXT
		
		// If it is not then see if it is a deliver
		ELSEIF  THIS.of_ISstopdelivergroup( ls_StopType ) THEN
			
			
			FOR li_ItemIndex = 1 TO li_ItemCount 							// loop through all of delvery items
				
				ls_KeyValue = lsa_TempKeyValues[li_ItemIndex]
			
				FOR li_KeyIndex = 1 TO li_AllignCount  
					IF lsa_AllignedValues [li_KeyIndex] = ls_KeyValue THEN
						ll_NewItemID = lla_AllignedItemIds [li_KeyIndex]
						IF ll_NewItemID > 0 THEN
							lnv_Item.of_SetSourceID ( ll_NewItemID )		
							lnv_Item.of_SetDelevent( i )						// Set the delevent whenever a match is found
						END IF
					END IF
				NEXT
			NEXT
		END IF
		
	
		ll_NewItemID = 0
		
	NEXT
END IF
//  Now that we have freight items created, now need to consolidate items with same pickup and delivery indexes.
//  Going to stash the Matching PO Numbers for the duplicate events in the item Notes filed.
//  If I Combine the BLNum fields, I risk exceeding the BLNum field length.
//  I think it is best to utilize the aligned item list of ids.  Then work with each id number rather than
//  just a simple count.


IF li_AllignCount > 1 THEN														// We don't need to check for dupes if 1 item or less
	
	FOR li_KeyItem = 1 TO li_AllignCount									// Look at each item in list
		ll_ItemID = lla_AllignedItemIds [ li_KeyItem ]					// Get the item id from the list
		IF lnv_Item.of_SetSourceID ( ll_ItemID ) = 1 THEN						// Have valid item.  Use as source for values
			li_PickIndex = lnv_Item.of_GetPickupEvent( )							// Get the starting pickup index		
			li_DeliverIndex = lnv_Item.of_GetDeliverEvent( )					// Get the starting deliver index
			ls_KeyNote = lnv_Item.of_GetNote( )										// Get the starting Note 
			li_CheckItemCount = li_KeyItem + 1										// Start comparing the next item from current index
			
			IF li_CheckItemCount <= li_AllignCount THEN							// Bail if we reach the end of the item list
				FOR li_CheckItem = li_CheckItemCount TO li_AllignCount		// Look at the rest of the items in list
					ll_CheckItemID = lla_AllignedItemIds [ li_CheckItem ] 	// Get the item id to check
					IF lnv_Item.of_SetSourceID ( ll_CheckItemID ) = 1 THEN	// Have Valid item. Set as source for values
						li_CheckPickIndex = lnv_Item.of_GetPickupEvent( )		// Get the pickup index value to check
						li_CheckDeliverIndex = lnv_Item.of_GetDeliverEvent( ) // Get the deliver index value to check
						ls_CheckNote = lnv_Item.of_GetNote( )						// Get the Note

						
						IF (li_CheckPickIndex = li_PickIndex AND li_CheckDeliverIndex = li_DeliverIndex) THEN // Found two items with matching indexes
							ls_KeyNote = ls_KeyNote + " " + ls_CheckNote 		// Combine the Notes 
							lnv_Item.of_SetSourceID ( ll_ItemID )					// Set source back to starting point
							lnv_Item.of_SetNote ( ls_KeyNote )						// Set the combined Notes on the source
																					
							lnv_Item.of_SetSourceID ( ll_CheckItemID )			// Set source to the duplicate id.
							lnv_Shipment.of_RemoveItem ( lnv_Item )				// Delete the CheckItemID duplicate
							
						END IF	 // No match found
					END IF 		// Not a valid item id.  Go to Next.	
				NEXT
			END IF			// Reached the end of the Check Item list.	
		END IF  				// Not a valid item id.  Go to Next.	
	NEXT
END IF

//  Accessorials.  
//  Tyson will not send accessorials in the L3 segment, charges are listed in the NTE segment.
//  Need to read in the NTE segments then parse them and use the parsed values for description and charges for Acc.
//  I'm setting the description and charges for the accessorials here.



n_cst_edisegment	lnva_NoteSegments[]

//  Load list of charges into array for searching.
//  I would like to have a way to get this list externally so it there were any changes we would not have to re-code.

ll_Start=1
FOR i =1 to 14
	ll_End = POS ( ls_ChargeList, ',', ll_Start )
	IF ll_End > 0 THEN // still working list found a comma
		ls_FindList[i] = MID ( ls_ChargeList, ll_Start, ll_End - ll_Start ) 
		ll_Start = ll_End + 1
	END IF

	IF ll_End = 0 THEN // comma not found, give me last of list
		ls_FindList[i] = MID ( ls_ChargeList, ll_Start, LEN ( ls_ChargeList ) - ll_Start )
	END IF
	
NEXT

// Search the note string using the array list of standard charges

FOR i = 1 to UPPERBOUND ( ls_FindList )
	ll_Start = POS ( ls_FFString, ls_FindList[i] )								// Search Note string for each charge name.
	IF ll_Start > 0 THEN																	// Found it.
		ll_ChargeStart = POS (ls_FFString, '$', ll_Start ) + 1				// Find the $ symbol preceeding the charge and add 1
		ll_ChargeEnd = POS ( ls_FFString, '.', ll_Start ) + 2					// Find the decimal in the charge following the charge name and add two for the decimal value.
	ls_Acc = MID ( ls_FFString, ll_ChargeStart, (ll_ChargeEnd - ll_ChargeStart) + 1 ) // Need to account for inclusive char.
		IF IsNumber ( ls_Acc ) THEN
			lc_Acc = Dec (ls_Acc ) 
		END IF
		IF lc_Acc >= 0  THEN
			ll_NewItemID = lnv_Shipment.of_AddItem ( "A" , lnv_Dispatch )  // Create new accessorial item
			IF ll_NewItemID > 0 THEN
				lnv_Item.of_SetSourceID ( ll_NewItemID )				
				lnv_Item.of_SetEventtypeflag( n_Cst_Constants.cs_itemeventtype_importedAcc )
				lnv_Item.of_SetDescription ( ls_FindList [i] )					// Set the description to the found charge string
				lnv_Item.of_SetRateType ( "F" )										// Set rate type to Flat
				lnv_Item.of_SetAmount ( lc_Acc )										// Set the charges on the acc item.
			ELSE
				li_Return = -1
				THIS.of_Adderror( "Could not create an accessorial item for " + ls_FindList [ i ] + "." )
			END IF
		END IF
	END IF			// Charge not found

NEXT

DESTROY ( lnv_Item )
RETURN li_Return


end function

protected function integer of_processitemdata ();
Any		la_Value
Boolean	lb_UsePicks
Dec		lc_TestForAmount
Dec		lc_Miles
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
Int		li_Count
Long		ll_Origin
Long		ll_Dest
String	ls_StopType
Any 		la_Miles

n_Cst_beo_Item		lnv_CurrentItem
n_cst_beo_Item		lnva_EmptyItemList[]

n_Cst_beo_Event		lnva_EventList[]
n_cst_edisegment		lnva_StopSegments[]
n_cst_edisegment		lnva_Segments[]
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

	// Looping through the stops and counting the groups. 
	
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
		IF li_PickupCount > li_DeliverCount THEN
			lb_UsePicks = TRUE
		ELSE
			lb_UsePicks = FALSE
		END IF
		
	NEXT	
		
	li_EventCount = lnv_Shipment.of_GetEventlist( lnva_EventList )
	
	li_ItemCount = lnv_Shipment.of_Getitemsforeventtype( n_cst_constants.cs_ItemEventType_ImportedFreight  , lnva_ItemList)
	ids_itemmapping.SetFilter ( "itemtype = 'L'" )
	ids_itemmapping.Filter ()

	FOR li_ItemGroup = 1 TO li_ItemCount
	
		
		lnv_CurrentItem = lnva_ItemList[li_ItemGroup]
		
		THIS.of_Settotals( lnv_CurrentItem )

		
		//  If the item has charges, Set the mileage value if exists.
		lc_TestForAmount = lnv_CurrentItem.of_GetBillingAmount ( )
		IF lc_TestForAmount > 0 THEN
			li_Count = THIS.of_GetSegments ( "L11", lnva_Segments )
			FOR i = 1 TO li_Count
				IF THIS.of_GetValue ( "L11", "1", "2=ZZ", lnva_Segments, la_Miles ) = 1 THEN
					IF ISNUMBER ( la_Miles ) THEN
						lc_Miles = DEC ( la_Miles )
						lnv_CurrentItem.of_SetMiles ( lc_Miles )
					END IF
				END IF
			NEXT
		END IF
		
		
		
		IF lb_UsePicks THEN
			//  I left this just about the same, with the exception of the itemmapping.
			//  Basically just mapping the item description using the itemmapping psr.
			//  The rest is done in code.
			
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
				//THIS.of_SetDataonbeo( lnv_CurrentItem, ids_itemmapping )
				THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping , lnva_StopSegments )
			END IF
			
		ELSE	
			// get the deliver event number
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
				//THIS.of_SetDataonbeo( lnv_CurrentItem, ids_itemmapping )
				THIS.of_setdataonbeo( lnv_CurrentItem , ids_itemmapping , lnva_StopSegments )
			END IF
					
			DESTROY ( lnv_CurrentItem )
		END IF		
	NEXT	
END IF

lnv_Array.of_Destroy( lnva_EventList )

ids_itemmapping.SetFilter ( "" )
ids_itemmapping.Filter ()

RETURN li_Return


end function

public function integer of_settotals (ref n_cst_beo_item anv_item);///////////////////////////////////////////////////////////////////////////////////////////////////

// In order to populate the items correctly, need to see if there are more pickups or deliveries
// Want to use the S5 data from the stop group with the higher group count.
// IF there is 1 pick and 3 drops, then the deliver events will contain the specific counts and weights.
// If there is 3 picks and 1 drop, the pick events will contain the counts and weights.
// In the case where pick and deliver counts are equal, I'll use the deliver stops.


Boolean	lb_UsePicks
Any		la_Value
Int		li_Stop
Int		i
Int		li_Count
Int		li_StopCount
Int		li_DeliverCount
Int		li_PickupCount
Long		ll_Units
Long		ll_Weight
String	ls_Temp
String	ls_ItemNote
String	ls_StopType
String	ls_TempItemNote
Constant	int	ci_WeightPos = 3
Constant	int	ci_UnitPos = 5

n_cst_edisegment	lnva_Segments[]
n_cst_edisegment	lnva_DataSegment[]
n_cst_edisegment	lnva_MatchSegments[]
n_Cst_beo_Item		lnv_Item

lnv_Item = anv_Item

// Looping through the stops and counting the groups. 

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
	IF li_PickupCount > li_DeliverCount THEN
		lb_UsePicks = TRUE
	ELSE
		lb_UsePicks = FALSE
	END IF
	
NEXT	
// Get the item Note string
// I combine the Notes for duplicate items. 
// I will need to use the first item matching number and not the whole string

ls_TempItemNote = lnv_Item.of_GetReference()
IF Pos ( ls_TempItemNote, ' ' ) > 0 THEN
	ls_ItemNote = Left ( ls_TempItemNote  , Pos ( ls_TempItemNote, ' ' ) -1 )
ELSE
	ls_ItemNote = ls_TempItemNote
END IF

// If more pickups then use data from the pickup events otherwise use the deliver events

IF lb_UsePicks THEN
	li_Stop = lnv_Item.of_GetPickupEvent ( )
ELSE
	li_Stop = lnv_Item.of_GetDeliverEvent ( ) 				
END IF

// ************** S.A.T. 8/25/06  Utilize S5 for qty and weight values regardless of OID segments
//
//  Tyson says that for shipments to customers there will be an OID segment.
//  Shipments between wharehouse facilities will not have an OID segment.




//IF li_Stop > 0 THEN
//	THIS.of_Getstopgroup( li_Stop , lnva_Segments )  						// Get the stop group for the event
//	THIS.of_GetSegments( "OID", lnva_Segments, lnva_MatchSegments )	// Grab the OID segments
//	li_Count = UpperBound ( lnva_MatchSegments ) 							// Count the OID segments
//	FOR i = 1 TO li_Count
//		
//		IF lnva_MatchSegments[i].of_Meetscondition( "2=" + ls_ItemNote  ) > 0 THEN  // OID matches item reference
//			THIS.of_GetSegments( "S5", lnva_Segments, lnva_DataSegment ) 				// Grab the S5 segment for stop group
//			lnva_DataSegment[1].of_Getvalue( {ci_UnitPos} , ls_Temp ) 					// Get QTY value
//			IF isNumber ( ls_Temp ) THEN		
//				ll_Units = Long ( ls_Temp )				
//			END IF
//			
//			lnva_DataSegment[1].of_Getvalue( {ci_WeightPos} , ls_Temp )					// Get Weight value
//			IF isNumber ( ls_Temp ) THEN
//				ll_Weight = Long ( ls_Temp )
//			END IF
//						
//		END IF
//				
//	NEXT
//	
//	lnv_Item.of_Setquantity( ll_Units ) 		// Set item QTY
//	lnv_Item.of_Settotalweight( ll_Weight )	// Set item Weight
//	
//END IF
//


IF li_Stop > 0 THEN
	THIS.of_Getstopgroup( li_Stop , lnva_Segments )  						// Get the stop group for the event
	THIS.of_GetSegments( "OID", lnva_Segments, lnva_MatchSegments )	// Grab the OID segments
	li_Count = UpperBound ( lnva_MatchSegments ) 							// Count the OID segments
	IF li_Count > 0 THEN																// OID exists process this way		
		
		FOR i = 1 TO li_Count
			
			IF lnva_MatchSegments[i].of_Meetscondition( "2=" + ls_ItemNote  ) > 0 THEN  // OID matches item reference
				THIS.of_GetSegments( "S5", lnva_Segments, lnva_DataSegment ) 				// Grab the S5 segment for stop group
				lnva_DataSegment[1].of_Getvalue( {ci_UnitPos} , ls_Temp ) 					// Get QTY value
				IF isNumber ( ls_Temp ) THEN		
					ll_Units = Long ( ls_Temp )				
				END IF
				
				lnva_DataSegment[1].of_Getvalue( {ci_WeightPos} , ls_Temp )					// Get Weight value
				IF isNumber ( ls_Temp ) THEN
					ll_Weight = Long ( ls_Temp )
				END IF
							
			END IF
					
		NEXT
	ELSE																						// OID does'nt exist process this way
		THIS.of_GetSegments( "S5", lnva_Segments, lnva_DataSegment ) 				// Grab the S5 segment for stop group REGARDLESS
		lnva_DataSegment[1].of_Getvalue( {ci_UnitPos} , ls_Temp ) 					// Get QTY value
		IF isNumber ( ls_Temp ) THEN		
			ll_Units = Long ( ls_Temp )				
		END IF
		
		lnva_DataSegment[1].of_Getvalue( {ci_WeightPos} , ls_Temp )					// Get Weight value
		IF isNumber ( ls_Temp ) THEN
			ll_Weight = Long ( ls_Temp )
		END IF
	END IF
	
	lnv_Item.of_Setquantity( ll_Units ) 		// Set item QTY
	lnv_Item.of_Settotalweight( ll_Weight )	// Set item Weight
	
	//  *****************END Changes 8/25/06
	
END IF


RETURN 1

end function

on n_cst_edishipment_manager_tyson_foods.create
call super::create
end on

on n_cst_edishipment_manager_tyson_foods.destroy
call super::destroy
end on

