$PBExportHeader$u_dw_shipmentlist.sru
forward
global type u_dw_shipmentlist from u_dw
end type
end forward

global type u_dw_shipmentlist from u_dw
integer width = 2272
boolean controlmenu = true
boolean hscrollbar = true
boolean hsplitscroll = true
boolean livescroll = false
event ue_shipmentdetail ( long al_row )
event type long ue_cacheretrieve ( boolean ab_refreshcache,  boolean ab_forcereload )
event type integer ue_getcache ( ref datastore ads_cache,  boolean ab_refreshcache )
event type integer ue_setloadbuilder ( boolean ab_switch )
event type integer ue_updateloadbuilder ( )
event type long ue_getselectedids ( ref long ala_ids[] )
event type integer ue_details ( )
event type integer ue_new ( )
event type integer ue_duplicate ( )
event type integer ue_ratelookup ( )
event type integer ue_document ( )
event type integer ue_setview ( string as_displayname )
event ue_copytext ( string as_columnname )
event ue_processkey pbm_dwnkey
event ue_shownotes ( long al_shipmentid )
event ue_loadbuilder ( )
end type
global u_dw_shipmentlist u_dw_shipmentlist

type variables
n_cst_Mediator_DataManager    inv_Mediator

Protected:
Boolean	ib_CacheRetrieve = FALSE
DateTime	idt_CacheUpdated

String	is_PreFilter
String	is_ManualFilter
String	is_SelectedItem
w_LoadBuilder	iw_LoadBuilder
Long	il_NormalFooterHeight
Long	il_PrintFooterHeight = 0


end variables

forward prototypes
public function integer of_setprefilter (string as_prefilter)
public subroutine of_moverowsup ()
public subroutine of_moverowsdown ()
public subroutine of_moverowstop ()
public subroutine of_moverowsbottom ()
public function integer of_selectallrows ()
public function integer of_unselectallrows ()
public subroutine of_getselectedshipmentids (ref long ala_shipmentids[])
public subroutine of_getselectedshipmentids (ref any aaa_shipmentids[], string as_keycolumn)
public subroutine of_setselecteditem (string as_value)
public function boolean of_storemanualfilter ()
public subroutine of_processpsr (readonly n_cst_msg anv_msg)
public function integer of_hidecharges ()
end prototypes

event ue_shipmentdetail;Long	ll_Row, &
		ll_Id
n_cst_ShipmentManager	lnv_ShipmentManager

IF This.RowCount ( ) > 0 THEN

	IF al_Row > 0 THEN
	
		ll_Row = al_Row
	
	ELSE
	
		ll_Row = This.GetSelectedRow ( 0 )
	
		IF ll_Row > 0 THEN
	
			//OK
	
		ELSE
	
			ll_Row = This.GetRow ( )
	
		END IF
	
	END IF

END IF


IF ll_Row > 0 THEN

	ll_Id = This.Object.ds_Id [ ll_Row ]
	lnv_ShipmentManager.of_OpenShipment ( ll_Id )

END IF
end event

event ue_cacheretrieve;//Returns : >= 0 Reload of the datawindow performed, number of resulting primary buffer rows returned
// -1 = Error, -2 = Reload not necessary (ab_ForceReload = FALSE and no changes were present in cache)

String		ls_PreFilter, &
				ls_Filter
Long			ll_FilteredCount, &
				ll_SelectedCount, &
				lla_SelectedIds[], &
				ll_Ndx, &
				ll_Row
DataStore	lds_Cache
Boolean		lb_Finished
n_cst_ShipmentManager	lnv_ShipmentManager

Long	ll_Return = 0

IF lb_Finished = FALSE THEN

	IF This.Event ue_GetCache ( lds_Cache, ab_RefreshCache ) = 0 THEN
		ll_Return = -1
		lb_Finished = TRUE
	END IF

END IF

IF lb_Finished = FALSE THEN

	IF ab_ForceReload = FALSE THEN

		IF idt_CacheUpdated = lnv_ShipmentManager.of_Get_Updated_Ships ( ) THEN
			ll_Return = -2
			lb_Finished = TRUE
		END IF

	END IF

END IF

IF lb_Finished = FALSE THEN

	//Capture the ids of rows currently selected, so that selection can be restored after
	//the rows are reloaded.
	ll_SelectedCount = This.Event ue_GetSelectedIds ( lla_SelectedIds )

	IF lds_Cache.RowCount ( ) > 0 THEN

		This.SetRedraw ( FALSE )

		//Clear the current data.
		This.Reset ( )

		lds_Cache.RowsCopy ( 1, lds_Cache.RowCount ( ), Primary!, This, 9999, Primary! )
		idt_CacheUpdated = lnv_ShipmentManager.of_Get_Updated_Ships ( )

		//Capture the current filter, so we can restore it after pre-filter processing.
		ls_Filter = This.Describe ( "DataWindow.Table.Filter" ) 
		IF ls_Filter = "?" THEN
			ls_Filter = ""
		END IF

		//Apply the pre-filter.
		ls_PreFilter = is_PreFilter
		This.SetFilter ( ls_PreFilter )
		This.Filter ( )
		ll_FilteredCount = This.FilteredCount ( )

		//Discard any rows screened out by the pre-filter.
		IF ll_FilteredCount > 0 THEN
			This.RowsDiscard ( 1, ll_FilteredCount, Filter! )
		END IF

		//Restore the original filter, captured above.
		This.SetFilter ( ls_Filter )
		This.Filter ( )
		This.Sort ( )
		ll_Return = This.RowCount ( )

		//Restore any row selections, captured above.
		FOR ll_Ndx = 1 TO ll_SelectedCount
			ll_Row = This.Find ( "ds_id = " + String ( lla_SelectedIds [ ll_Ndx ] ), &
				1, ll_Return )
			//Note : We have to scroll to row here, not after all the selections are made, 
			//because the selection service will deselect everything else if we scrolltorow after.
			IF ll_Row > 0 THEN
				IF ll_Ndx = 1 THEN
					This.ScrollToRow ( ll_Row )
				END IF
				This.SelectRow ( ll_Row, TRUE )
			END IF
		NEXT

		This.SetRedraw ( TRUE )
		lb_Finished = TRUE

	ELSE
		//Clear the current data.
		This.Reset ( )
		lb_Finished = TRUE
		ll_Return = 0

	END IF

END IF

RETURN ll_Return
end event

event ue_getcache;n_cst_ShipmentManager	lnv_ShipmentManager

Integer	li_Return = 0

IF ab_RefreshCache OR lnv_ShipmentManager.of_Get_Retrieved_Ships ( ) = FALSE THEN
	lnv_ShipmentManager.of_RefreshShipments ( FALSE /*Don't refresh trips, too*/ )
END IF

ads_Cache = lnv_ShipmentManager.of_Get_DS_Ship ( )

IF IsValid ( ads_Cache ) THEN
	li_Return = 1
END IF

RETURN li_Return
end event

event ue_setloadbuilder;//Returns : 1 = Requested action taken, 
//0 = Requested state already in effect.  If request is TRUE and window has been minimized,
//it will be restored.
//-1 = Error.

Integer	li_Return = -1

IF IsNull ( ab_Switch ) THEN
	//li_Return = -1

ELSEIF IsValid ( iw_LoadBuilder ) = ab_Switch THEN

	li_Return = 0

	//If the window is already open, restore it if it's been minimized.
	IF IsValid ( iw_LoadBuilder ) THEN
		iw_LoadBuilder.WindowState = Normal!
	END IF

ELSEIF ab_Switch = TRUE THEN
	Open ( iw_LoadBuilder )
	This.Event ue_UpdateLoadBuilder ( )
	li_Return = 1

ELSEIF ab_Switch = FALSE THEN
	Close ( iw_LoadBuilder )
	li_Return = 1

END IF

RETURN li_Return
end event

event ue_updateloadbuilder;//Returns : 1 = Load builder open, and display updated.
//0 = Load builder not open, so request does not apply and has been ignored.
//-1 = Error (not currently implemented)

Long	lla_Ids[]

Integer	li_Return = 0

IF IsValid ( iw_LoadBuilder ) THEN

	This.Event ue_GetSelectedIds ( lla_Ids )
	iw_LoadBuilder.wf_SetShipmentList ( lla_Ids )
	li_Return = 1

END IF

RETURN li_Return
end event

event ue_getselectedids;//Returns : >= 0 (The number of rows selected.  The corresponding ids are 
//passed out in ala_Ids )

Long	ll_SelectedCount, &
		lla_SelectedIds[], &
		ll_Row

//IF This.GetSelectedRow ( 0 ) > 0 THEN
//	lla_SelectedIds = This.Object.ds_id.Selected
//	ll_SelectedCount = UpperBound ( lla_SelectedIds )
//END IF

This.SetRedraw ( TRUE )

DO

	ll_Row = This.GetSelectedRow ( ll_Row )

	IF ll_Row > 0 THEN
		ll_SelectedCount ++
		lla_SelectedIds [ ll_SelectedCount ] = This.Object.ds_id [ ll_Row ]
	END IF

LOOP WHILE ll_Row > 0

ala_Ids = lla_SelectedIds

RETURN ll_SelectedCount
end event

event ue_details;Long	lla_Ids[]
n_cst_ShipmentManager	lnv_ShipmentManager

This.Event ue_GetSelectedIds ( lla_Ids )

lnv_ShipmentManager.of_OpenShipments ( lla_Ids )

RETURN 1
end event

event ue_duplicate;

Long		ll_Row, &
			ll_Id
			
Long		lla_SelectedRows[]
Long		lla_SelectedIDs[]
Long		ll_SelectedCount
Long		i

String	ls_Message, &
			ls_MessageHeader = "Duplicate Shipment", &
			ls_Text
		
Int		li_Type

Integer	li_Return = 1

n_cst_Msg	lnv_msg
S_Parm		lstr_Parm

IF IsValid ( inv_rowselect ) THEN
	ll_SelectedCount = inv_rowselect.of_SelectedCount ( lla_SelectedRows )
END IF

IF ll_SelectedCount = 1 THEN
	
	ll_Row = lla_SelectedRows[1]
	
	ll_Id = This.Object.ds_Id [ ll_Row ]
	lstr_Parm.ia_Value = ll_ID
	lstr_Parm.is_Label = "SHIPMENT"
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	ls_Text = This.object.Shipment_Ref1Text [ ll_Row ]
	li_Type = This.object.Shipment_Ref1Type [ ll_Row ]

	IF Not isNull ( ls_Text ) AND ( li_Type = 20 OR li_Type = 26 OR li_Type = 28 ) THEN

		lstr_Parm.is_Label = "EQREF"
		lstr_Parm.ia_Value =  This.object.Shipment_Ref1Text [ ll_Row ]
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		IF li_Type = 20 THEN
			lstr_Parm.ia_Value = 'C'
		ELSEIF li_Type = 26 THEN 
			lstr_Parm.ia_Value = 'B'
		ELSE
			lstr_Parm.ia_Value = 'H'
		END IF
		lstr_Parm.is_Label = "TYPE"
		lnv_Msg.of_Add_Parm  ( lstr_Parm ) 
		
	
	END IF

ELSEIF ll_selectedCount > 1 THEN
	
	FOR i = 1 TO ll_SelectedCount 
		lla_SelectedIDs [i] = This.Object.ds_Id [ lla_SelectedRows[i] ]
	NEXT
	
	lstr_Parm.ia_Value = lla_SelectedIDs
	lstr_Parm.is_Label = "MULTIPLESHIPMENTS"
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
ELSE
	
	ls_Message = "Please select a shipment to duplicate."
	li_Return = 0
END IF



IF li_Return = 1 THEN
	OpenWithParm ( w_DuplicateWithEquipment, lnv_msg )

ELSEIF li_Return < 1 AND Len ( ls_Message ) > 0 THEN
	MessageBox ( ls_MessageHeader, ls_Message )
END IF

RETURN li_Return
end event

event ue_ratelookup;//Returns : 1 = Success, 0 = No selection / No action, -1 = Error (currently not implemented)

Long	lla_Ids[]

Integer	li_Return = 0

IF This.Event ue_GetSelectedIds ( lla_Ids ) > 0 THEN

	// Create attrib object
	n_cst_rate_attribs lnv_attribs
	
	// Fill in company ID
	lnv_attribs.of_setShipmentIds ( lla_Ids )
	
	// Open window
	OpensheetWithParm ( w_rate_query, lnv_attribs, gnv_App.of_GetFrame ( ), 0, LAYERED! )

	li_Return = 1

END IF

RETURN li_Return
end event

event type integer ue_document();// This is triggered by the button on the window
//Returns : 1 = Success, 0 = No selection / No action, -1 = Error (currently not implemented)

datawindow	ldw_Source
n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
//n_cst_Beo_Event	lnva_Events[]
Long	lla_Ids[]

Integer	li_Return = 0

IF This.Event ue_GetSelectedIds ( lla_Ids ) > 0 THEN

	lstr_Parm.is_Label = "DOCUMENT"
	lstr_Parm.ia_Value = n_cst_Constants.cs_Document_DeliveryReceipt
	lnv_Msg.of_Add_Parm (lstr_Parm)
		
	lstr_Parm.is_Label = "TOPIC"
	lstr_Parm.ia_Value = "SHIPMENT"
	lnv_Msg.of_Add_Parm (lstr_Parm)
			
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = lla_Ids
	lnv_Msg.of_Add_Parm (lstr_Parm)
	
	ldw_Source = This
	lstr_Parm.is_Label = "DATAWINDOW"
	lstr_Parm.ia_Value = ldw_Source
	lnv_Msg.of_Add_Parm ( lstr_Parm )	
	
	lstr_Parm.is_Label = "MATCHCOLUMN"
	lstr_Parm.ia_Value = "ds_id"
	lnv_Msg.of_Add_Parm (lstr_Parm)
	
	OpenWithParm  ( w_DocumentSelection, lnv_Msg )
	
	IF isValid(Message.PowerObjectParm) THEN
		IF Message.PowerObjectParm.ClassName() = "n_cst_msg" THEN
			This.of_processpsr( Message.PowerObjectParm )	// RDT 4-1-03 
		END IF
	END IF
	li_Return = 1

END IF

RETURN li_Return
end event

event type integer ue_setview(string as_displayname);//Returns : 1, -1 (Currently not implemented)

Boolean	lb_CustomRequested = FALSE, &
			lb_ObjectChange = FALSE, &
			lb_NewSort = FALSE, &
			lb_NewFilter = FALSE
//String	ls_StandardCode
String	ls_NewDataObject, &
			ls_Sort, &
			ls_Filter, &
			ls_RequestedSort, &
			ls_RequestedFilter
Long		lla_SelectedIds[], &
			ll_SelectedCount, &
			ll_FirstRow, &
			ll_FirstVisibleId, &
			ll_LastRow, &
			ll_LastVisibleId, &
			ll_Row, &
			ll_RowCount, &
			ll_FilteredCount, &
			ll_DeletedCount, &
			ll_Index
n_cst_Dws	lnv_Dws
DataStore	lds_Copy

Integer	li_Return = 1


n_cst_privsmanager	lnv_privsManager

//Get the id for the first and last row currently visible on the page, and
//the ids of any rows that are selected.  This will be used to try to recreate
//the selection and scroll position later.


ll_FirstRow = Long ( This.Describe ( "Datawindow.FirstRowOnPage" ) )

IF ll_FirstRow > 0 THEN

	ll_FirstVisibleId = This.Object.ds_id [ ll_FirstRow ]

END IF


ll_LastRow = Long ( This.Describe ( "Datawindow.LastRowOnPage" ) )

IF ll_LastRow > 0 THEN

	ll_LastVisibleId = This.Object.ds_id [ ll_LastRow ]

END IF


IF This.GetSelectedRow ( 0 ) > 0 THEN

	lla_SelectedIds = This.Object.ds_id.Selected
	ll_SelectedCount = UpperBound ( lla_SelectedIds )

END IF


//See if the DisplayName passed in is one of the standard system views.  If so, record
//the equivalent code letter, if not, set lb_CustomRequested = TRUE

CHOOSE CASE as_DisplayName

CASE "Overview", "Locations"	//**"Locations" SHOULD NOW BE UNREFERENCED AND OBSOLETE 3.6.00**
//	ls_StandardCode = "L"
	ls_NewDataObject = "d_shipmentlist_overview"
	
	if len(trim(is_manualfilter)) > 0 then
		ls_RequestedFilter = is_ManualFilter
		lb_NewFilter = TRUE
	end if

CASE "Appointments"
//	ls_StandardCode = "D"
	ls_NewDataObject = "d_shipmentlist_appointments"
CASE "Next Stop"		//**THIS SHOULD NOW BE UNREFERENCED AND OBSOLETE 3.6.00**
//	ls_StandardCode = "C"
	ls_NewDataObject = "d_shipmentlist_nextstop"
CASE "Billing Info", "Other Info"
//	ls_StandardCode = "T"
	ls_NewDataObject = "d_shipmentlist_billing"
//CASE "Intermodal"		//No longer supported?
//	ls_StandardCode = "I"

//New data objects for 3.6.00

CASE "Inbound Pending"
	ls_NewDataObject = "d_shipmentlist_inbound_pending"
	ls_RequestedFilter = "(shipment_movecode='I') AND (IsNull(Shipment_releasedate) AND IsNull(Shipment_LastFreeDate) AND Shipment_RoutedEventCount=0)"
	lb_NewFilter = TRUE

CASE "Inbound Loads"
	ls_NewDataObject = "d_shipmentlist_inbound_loads"
	ls_RequestedFilter = "(shipment_movecode='I') AND (Shipment_Delivered = 'F') AND NOT (IsNull(Shipment_releasedate) AND IsNull(Shipment_LastFreeDate) AND Shipment_RoutedEventCount=0)"
	lb_NewFilter = TRUE

CASE "Inbound Returns"
	ls_NewDataObject = "d_shipmentlist_inbound_returns"
	ls_RequestedFilter = "(shipment_movecode='I') AND (Shipment_Delivered = 'T')"
	lb_NewFilter = TRUE

CASE "Outbound Empties"
	ls_NewDataObject = "d_shipmentlist_outbound_empties"
	ls_RequestedFilter = "(shipment_movecode='E') AND NOT (Shipment_PickedUp = 'T' OR (NextEvent_SiteId = Origin_Id AND (NextEvent_Type = 'PU' OR NextEvent_Type = 'HK' OR NextEvent_Type = 'MT')))"
	lb_NewFilter = TRUE

CASE "Outbound Loading"
	ls_NewDataObject = "d_shipmentlist_outbound_loads"  //SAME DATAOBJECT FOR OUTBOUND LOADING AND OUTBOUND READY
	ls_RequestedFilter = "(shipment_Movecode='E') AND (NextEvent_SiteId = Origin_Id AND (NextEvent_Type = 'HK' OR NextEvent_Type = 'MT') AND IsNull (Shipment_LoadedAtCustomerDate))"
	lb_NewFilter = TRUE

CASE "Outbound Ready"   //Logic changed 3.7.00 10/1/03 BKW   A live PU was not showing on any list after original hook was confirmed until PU was also confirmed.
	//Logic changed 10/1/03 was included in 3.7.00 and 3.7.01 but was then dropped accidentally.
	//It was not in 3.7.02 through 3.8.06.  It was reintroduced in 3.8.07
	ls_NewDataObject = "d_shipmentlist_outbound_loads"  //SAME DATABOJECT FOR OUTBOUND LOADING AND OUTBOUND READY
	ls_RequestedFilter = "(Shipment_Movecode='E') AND (Shipment_PickedUp = 'T' OR (NextEvent_SiteId = Origin_Id AND (NextEvent_Type = 'PU' OR ((NextEvent_Type = 'HK' OR NextEvent_Type = 'MT') AND NOT IsNull (Shipment_LoadedAtCustomerDate)))))"
	lb_NewFilter = TRUE

CASE "One Ways"  //Added 3.6.b2  The others were 3.6.b1
	ls_NewDataObject = "d_shipmentlist_oneways"
	ls_RequestedFilter = "shipment_movecode='O'"
	lb_NewFilter = TRUE

CASE ELSE
	lb_CustomRequested = TRUE
END CHOOSE


IF lb_CustomRequested = FALSE THEN

	//If the standard data object requested is already being used, keep it, 
	//otherwise, record that we'll need to change it (the data
	//will need to be copied if the dataobject is changed.)

	IF This.DataObject = ls_NewDataObject THEN
		//No change needed
	ELSE
		lb_ObjectChange = TRUE
	END IF

ELSE

	//We always need to change the dataobject in order to clear the existing
	//columns and start with a clean slate.  The data will need to be copied.

	lb_ObjectChange = TRUE

END IF


//If we're going to have an object change, back up the data so we can copy it back in.
//We're going to do this rather than a "refresh" because of the different contexts this
//object is used in, ie. summary, search, etc.  We want to go with whatever the thing is
//currently displaying, without worrying about the source.

IF lb_ObjectChange = TRUE THEN

	lds_Copy = CREATE DataStore
	lds_Copy.DataObject = "d_ShipmentCache"

	ll_RowCount = This.RowCount ( )
	ll_FilteredCount = This.FilteredCount ( )
	ll_DeletedCount = This.DeletedCount ( )

	This.RowsCopy ( 1, ll_RowCount, Primary!, lds_Copy, 9999, Primary! )
	This.RowsCopy ( 1, ll_FilteredCount, Filter!, lds_Copy, 9999, Filter! )
	This.RowsCopy ( 1, ll_DeletedCount, Delete!, lds_Copy, 9999, Delete! )




	//Changing the dataobject will clear the current sort.  
	//Capture the current sort so we can reset it.

//	See the note on filter for an explanation on the describe call here
	
	This.of_SetAutoSort ( TRUE )

//	IF IsValid ( This.inv_Sort ) THEN
//		ls_Sort = This.inv_Sort.of_GetSort ( )
//	END IF

	// Return the current sort for the datawindow.
	ls_Sort = THIS.Describe ("DataWindow.Table.Sort")
	
	// A questionmark indicates no sort set.
	If ls_Sort='?' Then ls_Sort = ''




	//Changing the dataobject will clear the current filter.  
	//Capture the current filter so we can reset it.

	This.of_SetAutoFilter ( TRUE )

// needed to change the above call from of_setFilter ( ) TO of_SetAUTOfilter ( ) 
// to get the processing to go through the ue_AutoFilter Event.
// therefore the describe call was assed to get the filter since with the autoFilter 
//	call the inv_Filtermay not be valid

//	IF IsValid ( This.inv_Filter ) THEN
//		ls_Filter = This.inv_Filter.of_GetFilter ( )
//	END IF

	// Get the current filter
	ls_filter = THIS.Describe ( "DataWindow.Table.Filter" ) 
	
	// A questionmark indicates no filter set.
	If ls_filter='?' Then ls_filter = ''


END IF


This.SetRedraw ( FALSE )


//Change the display to the standard or custom view requested.

IF lb_CustomRequested = FALSE THEN

	IF lb_ObjectChange THEN

		This.DataObject = ls_NewDataObject

		//Changing dataobject triggers redraw, turn it off again.
		This.SetRedraw ( FALSE )

	END IF


	//Set the view indicator.
//	This.Modify ( "txt_disp_ind.text = '" + ls_StandardCode + "'" )


	//Adjust the header height appropriately.   No longer needed, not using the "I" view.

//	IF ls_StandardCode = "I" THEN
//		This.Object.DataWindow.header.height=140
//	ELSE
//		This.Object.DataWindow.header.height=80
//	END IF


ELSE

	//Set the Custom dataobject.
	//We always need to change the dataobject in order to clear the existing
	//columns and start with a clean slate.  The data will need to be refreshed.

	This.DataObject = "d_ShipmentListCustom"
	//Changing dataobject triggers redraw, turn it off again.
	This.SetRedraw ( FALSE )


	//Set up the new view.
	lnv_Dws.of_SetCustomView ( This, "ShipmentList", as_DisplayName, FALSE /*Don't handle redraw*/, &
		ls_RequestedSort, ls_RequestedFilter )


	IF NOT IsNull ( ls_RequestedSort ) THEN
		//ls_Sort = ls_RequestedSort      Now done below
		lb_NewSort = TRUE
	END IF

	IF NOT IsNull ( ls_RequestedFilter ) THEN
		//ls_Filter = ls_RequestedFilter  Now done below.
		lb_NewFilter = TRUE
	END IF

END IF



//Added 3.6.00

IF lb_NewSort THEN
	ls_Sort = ls_RequestedSort
END IF


IF lb_NewFilter THEN

	ls_Filter = ls_RequestedFilter

ELSEIF Len ( ls_Filter ) > 0 THEN

	CHOOSE CASE MessageBox ( "Change View", "Do you want to clear the filter and show all shipments ('YES') or "+&
		"show just the shipments from the previous view? ('NO')", Question!, YesNo!, 1 )

	CASE 1  //Clear the filter
		ls_Filter = ""
		lb_NewFilter = TRUE

	CASE 2  //Retain the filter
		//No action needed

	CASE ELSE  //Unexpected return value  -- clear the filter j.i.c.
		ls_Filter = ""
		lb_NewFilter = TRUE

	END CHOOSE

END IF

//END of addition


IF lb_ObjectChange THEN

	//If the object has changed, we need to call SetTransObject again, because this gets cleared
	//when the object changes.

	This.SetTransObject ( SQLCA )

	//If the data object changed, we need to re-initialize the Status, RefLabel, 
	//and ShipType code tables, and then reload the data itself.

	//The following is common to the search screen and u_ship_list

	n_cst_ShipmentManager	lnv_ShipmentManager
	n_cst_Ship_Type			lnv_ShipType
	DWObject						ldwo_ShipType
	
	//Populate the status code table
	This.Modify ( "Shipment_BillingStatus.Edit.CodeTable = Yes "+&
		"shipment_BillingStatus.Values = '" + lnv_ShipmentManager.of_GetStatusCodeTable ( ) + "'" )
	
	//Populate the reference lists
	lnv_ShipmentManager.of_PopulateReferenceLists ( This )
	
	//Populate shipment type list
	ldwo_ShipType = This.Object.Shipment_ShipTypeId
	lnv_ShipType.of_Populate ( ldwo_ShipType )
	DESTROY ldwo_ShipType
	
	//This shows or hides the Total Charges summary based on settings and privileges.
	lnv_ShipmentManager.of_PrepareSummaryDisplay ( This )


	//Copy the rows we "backed up" before the change of dataobject back in.

	lds_Copy.RowsCopy ( 1, ll_RowCount, Primary!, This, 9999, Primary! )
	lds_Copy.RowsCopy ( 1, ll_FilteredCount, Filter!, This, 9999, Filter! )
	lds_Copy.RowsCopy ( 1, ll_DeletedCount, Delete!, This, 9999, Delete! )

	DESTROY lds_Copy

END IF


//**NOTE:  THIS SECTION HAD BEEN INSIDE THE lb_ObjectChange CONDITION, ABOVE.
//HOWEVER, IN THE 6/30 BUILD OF 3-5-B3, WE BEGAN USING THE SAME D.O. FOR 2 VIEWS,
//AND THIS WAS PREVENTING THE FILTER BEING APPLIED.  IT SEEMS THAT THIS SHOULD
//BE OUTSIDE THE CONDITION IN ANY CASE.  --BKW


//If there was a previous sort and / or filter, reapply them, since changing
//the dataobject has stripped them off.  If a new sort and / or filter was 
//requested, it needs to be applied, even if it's "nothing".

IF Len ( ls_Sort ) > 0 OR lb_NewSort = TRUE THEN
	This.SetSort ( ls_Sort )
END IF

IF Len ( ls_Filter ) > 0 OR lb_NewFilter = TRUE THEN

	if as_DisplayName = "Overview" then
		This.SetFilter ( ls_Filter )
	else
		if len(trim(is_ManualFilter)) > 0 then
			if len(trim(ls_filter)) > 0 then
				This.SetFilter ("(" + is_ManualFilter + ") and " + ls_Filter)
			else
				This.SetFilter ("(" + is_ManualFilter + ")")
			end if
		else
			This.SetFilter ( ls_Filter )
		end if
	end if
		
END IF

//If a new filter was specified, we need to filter.  If it's an old filter,
//the rows are already right, so we don't have to.

IF lb_NewFilter = TRUE THEN
	This.Filter ( )
END IF

//If there is a new filter or a new sort, we need to sort the rows.
//Otherwise, they're alredy sorted properly.

IF lb_NewSort = TRUE OR lb_NewFilter THEN
	This.Sort ( )
END IF


//**END OF SECTION TAKEN OUTSIDE THE lb_ObjectChanged CONDITION.



//Grab the rowcount now being displayed, for use in find operations below.
ll_RowCount = This.RowCount ( )


//Attempt to scroll the page to the same position it was when we started, and select the
//same rows (if any were selected coming in.)  By scrolling to the last row AND the first
//row, we can force the display to include both row extremes -- ie, the display row list the
//user was looking at before changing the view.


IF ll_LastVisibleId > 0 THEN

	ll_Row = This.Find ( "ds_id = " + String ( ll_LastVisibleId ), 1, ll_RowCount )

	IF ll_Row > 0 THEN
		This.ScrollToRow ( ll_Row )
	END IF

END IF



IF ll_FirstVisibleId > 0 THEN

	ll_Row = This.Find ( "ds_id = " + String ( ll_FirstVisibleId ), 1, ll_RowCount )

	IF ll_Row > 0 THEN
		This.ScrollToRow ( ll_Row )
	END IF

END IF


IF ll_SelectedCount > 0 THEN

	This.SelectRow ( 0, FALSE )

	FOR ll_Index = 1 TO ll_SelectedCount

		ll_Row = This.Find ( "ds_id = " + String ( lla_SelectedIds [ ll_Index ] ), 1, ll_RowCount )

		IF ll_Row > 0 THEN
			This.SelectRow ( ll_Row, TRUE )
		END IF

	NEXT

END IF

/////ADDED 1-29-07 by DAN
lnv_privsmanager = gnv_app.of_getPrivsmanager( )
IF lnv_privsManager.of_getUserpermissionfromfn( "View Charges") <> 1 THEN
	this.of_hidecharges( )
END IF
//
This.SetRedraw ( TRUE )

RETURN li_Return
end event

event ue_copytext;Long	lla_SelectedRows [ ]
Long	ll_Count
Long	i
String	lsa_Working[]
String	ls_Temp

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm


IF isValid ( inv_rowselect ) THEN
	
	SetPointer ( HOURGLASS! )
	
	ll_Count = inv_rowselect.of_SelectedCount ( lla_SelectedRows )	
	
	FOR i = 1 TO ll_Count
		ls_Temp = TRIM ( THIS.GetItemString ( lla_SelectedRows[i] , as_columnname ) )
		IF Len ( ls_Temp ) > 0 THEN
			lsa_Working [ UpperBound ( lsa_Working ) + 1 ] = ls_Temp
		END IF
	NEXT
			
	lstr_Parm.is_Label = "TEXT"
	lstr_Parm.ia_Value = lsa_Working
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	openWithParm ( w_RefTextFormat , lnv_Msg )
			
END IF


end event

event ue_processkey;IF key = KeyA! AND keyflags = 2 THEN

	THIS.SelectRow ( 0 , TRUE )
	
END IF
end event

event ue_shownotes(long al_shipmentid);n_cst_Msg lnv_Msg
s_parm lstr_parm

lstr_parm.is_label = "TARGET_ID"
lstr_parm.ia_value = al_ShipmentId

lnv_Msg.of_add_parm(lstr_parm)

OpenWithParm(w_NoteShower,lnv_Msg)
end event

event ue_loadbuilder();THIS.event ue_setloadbuilder( TRUE )
end event

public function integer of_setprefilter (string as_prefilter);//Record the new pre-filter value.  The change will not take effect
//until the datawindow is re-retrieved.

is_PreFilter = as_PreFilter

RETURN 1
end function

public subroutine of_moverowsup ();Long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_BeforeRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, & 
		ll_RowFound, & 	
		ll_StartRow
		
ll_RowCount 	= This.RowCount()

IF ll_RowCount <= 0 THEN
	RETURN
END IF

ll_StartRow = 0

FOR ll_RowNdx = 1 TO ll_RowCount
	ll_RowFound	 = This.GetSelectedRow(ll_StartRow)	
	IF ll_RowFound = 0 THEN
		EXIT
	END IF
	This.SelectRow(ll_RowFound,FALSE)
	lla_Selected[ll_RowNdx] = ll_RowFound
	ll_StartRow = ll_RowFound
NEXT


ll_SelectedRowCount = UpperBound ( lla_Selected )

IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount
		
		ll_SelectedStartRow 	= lla_Selected[ll_RowNdx]
		ll_SelectedEndRow		= lla_Selected[ll_RowNdx]
		ll_BeforeRow			= lla_Selected[ll_RowNdx] - 1
		
		IF (ll_SelectedStartRow = 1 AND ll_SelectedRowCount = 1) THEN
			This.SelectRow(1,TRUE)
		ELSE
			IF This.RowsMove(ll_SelectedStartRow,ll_SelectedEndRow,Primary!, & 
									This,ll_BeforeRow,Primary! )	= 1 THEN
				This.SelectRow(ll_SelectedStartRow,False)
				This.SelectRow(ll_BeforeRow,TRUE)
			END IF			
		END IF	
	NEXT
	
END IF

This.SetFocus()


/*------------------------------------------------------------*/
// // Logic from u_cst_eventrouting_clipboard for moveup
/*
Any laa_Selected[]

String ls_KeyColumn
String ls_expression

Long	ll_SelectedStartRow
Long	ll_SelectedEndRow
Long	ll_BeforeRow
Long	ll_SelectedRowCount
Long	ll_RowNdx
Long 	ll_RowCount
Long 	ll_StartRow
Long	ll_RowFound
Long  ll_HoldRow


/**** Change this "key column" according to your requirement.
of_Getselectedshipmentids method will take care of the datatype of "key column"
and return an array of type any
*/

ls_KeyColumn = 'ds_id'
		
ll_RowCount = This.RowCount()

This.of_Getselectedshipmentids(laa_Selected,ls_KeyColumn)

ll_SelectedRowCount = UpperBound(laa_Selected)

IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount
	
		ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [ll_RowNdx] )
		ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)
//		ll_SelectedStartRow = THIS.Find ( "de_id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )

		CHOOSE CASE ll_SelectedStartRow
			CASE 0 	//problem
				
			CASE 1	//No move necessary
				ll_HoldRow = ll_SelectedStartRow
				EXIT 
				
			CASE ELSE
				
				IF ll_RowNdx = 1 THEN
					ll_BeforeRow = ll_SelectedStartRow - 1
					ll_HoldRow = ll_SelectedStartRow
				ELSE
					ll_BeforeRow ++
				END IF
				
				ll_SelectedEndRow = ll_SelectedStartRow
				THIS.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, THIS, ll_BeforeRow, Primary! )
				
		END CHOOSE
		
	NEXT
	
		//set row selections
		THIS.SelectRow ( 0, FALSE)
		//first row to highlight
		
		ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [1] )
		ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)
		//ll_SelectedStartRow = THIS.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
		
			ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [ll_SelectedRowCount] )
			ll_SelectedEndRow = This.Find ( ls_expression,1,ll_RowCount)
		//ll_SelectedEndRow = THIS.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

		FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
			
			THIS.SelectRow (ll_RowNdx, TRUE)

			IF ll_RowNdx = ll_SelectedStartRow THEN
				THIS.SetRow ( ll_RowNdx)
			END IF				

		next
	
ELSE
	ll_SelectedStartRow = THIS.GetRow()
	ll_SelectedEndRow = THIS.GetRow()
	IF ll_SelectedStartRow = 1 THEN
		//No move necessary
	ELSE
		ll_BeforeRow = ll_SelectedStartRow - 1
		THIS.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, THIS, ll_BeforeRow, Primary! )
	END IF
	
END IF

THIS.SetFocus()
*/
end subroutine

public subroutine of_moverowsdown ();Any laa_Selected[]

String ls_KeyColumn
String ls_expression

Long	ll_SelectedStartRow
Long	ll_SelectedEndRow
Long	ll_BeforeRow
Long	ll_SelectedRowCount
Long	ll_RowNdx
Long 	ll_RowCount
Long 	ll_StartRow
Long	ll_RowFound


/**** Change this "key column" according to your requirement.
of_Getselectedshipmentids method will take care of the datatype of "key column"
and return an array of type any
*/

ls_KeyColumn = 'ds_id'
		
ll_RowCount = This.RowCount()

This.of_Getselectedshipmentids(laa_Selected,ls_KeyColumn)

ll_SelectedRowCount = UpperBound(laa_Selected)

IF ll_SelectedRowCount > 0 THEN

	ls_expression  = ls_KeyColumn + " = " + String(laa_Selected [ll_SelectedRowCount])
	ll_SelectedEndRow = This.Find ( ls_expression,1,ll_RowCount)
	
	IF ll_SelectedEndRow = ll_RowCount THEN
		//No move necessary
	ELSE
		FOR ll_RowNdx = 1 TO ll_SelectedRowCount 
			ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [ll_RowNdx] )
			ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)
	
			CHOOSE CASE ll_SelectedStartRow
				CASE 0 	//problem
					
				CASE ELSE
					
					IF ll_RowNdx = 1 THEN
						ll_BeforeRow = ll_SelectedEndRow + 2
					END IF
					
					ll_SelectedEndRow = ll_SelectedStartRow
					This.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, This, ll_BeforeRow, Primary! )
					
			END CHOOSE
			
		NEXT

		//set row selections
		This.SelectRow ( 0, FALSE)
		//first row to highlight
		ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [1] )
		ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)		
		
		ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [ll_SelectedRowCount] )		
		ll_SelectedEndRow = This.Find ( ls_expression,1,ll_RowCount)		
		
		FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
			
			This.SelectRow (ll_RowNdx, TRUE)

			IF ll_RowNdx = ll_SelectedStartRow THEN
				This.SetRow ( ll_RowNdx)
			END IF				

		next
				
	END IF
	
ELSE
	ll_SelectedStartRow = This.GetRow()
	ll_SelectedEndRow = This.GetRow()
	IF ll_SelectedStartRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_BeforeRow = ll_SelectedEndRow + 2
		This.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, This, ll_BeforeRow, Primary! )
		This.SelectRow (ll_SelectedStartRow, FALSE)
		This.SelectRow (ll_SelectedStartRow + 1, TRUE)
		This.SetRow ( ll_SelectedStartRow + 1)
	END IF
	
END IF

This.SetFocus()

//------------------------------------------------------
// Original code by Zach where no key column is available. 
// Gotta re-visit it again.

/*
Long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_AfterRow, &
		ll_SelectedRowCount, & 
		ll_RowCount, & 
		ll_RowFound, & 	
		ll_StartRow, & 
		ll_RowNdx, & 
		ll_RowSelected, & 
		ll_RowIdFromRow, & 
		ll_OriRowSelected

ll_RowCount = This.RowCount()

IF ll_RowCount <= 0 THEN
	RETURN
END IF

ll_StartRow = 0

FOR ll_RowNdx = 1 TO ll_RowCount
	ll_RowFound	 = This.GetSelectedRow(ll_StartRow)	
	IF ll_RowFound = 0 THEN
		EXIT
	END IF
	This.SelectRow(ll_RowFound,FALSE)
	lla_Selected[ll_RowNdx] = ll_RowFound
	ll_StartRow = ll_RowFound
NEXT

ll_SelectedRowCount = UpperBound (lla_Selected)

IF ll_SelectedRowCount > 0 THEN
	ll_OriRowSelected = ll_SelectedRowCount
	ll_AfterRow = ll_SelectedRowCount + 2
	Do while ll_SelectedRowCount > 0
////////////
		ll_SelectedStartRow =  lla_Selected[ll_SelectedRowCount]
		CHOOSE CASE ll_SelectedStartRow
			CASE	0 // Problem
			
			CASE ELSE
				ll_SelectedEndRow = ll_SelectedStartRow
				This.RowsMove(ll_SelectedStartRow,ll_SelectedEndRow,Primary!,This,ll_AfterRow,Primary! )
		END CHOOSE

////////////
		/*
		ll_SelectedStartRow = lla_Selected[ll_SelectedRowCount]
		ll_SelectedEndRow   = ll_SelectedStartRow
		ll_AfterRow = ll_SelectedEndRow + 2
		
		IF (ll_SelectedStartRow = ll_RowCount AND ll_SelectedRowCount = 1) THEN
			This.SelectRow(ll_RowCount,TRUE)
		ELSEIF ll_SelectedRowCount = 1 AND ll_OriRowSelected = 1 THEN
			This.RowsMove(ll_SelectedStartRow,ll_SelectedEndRow,Primary!,This,ll_AfterRow, Primary!)
			ll_RowIdFromRow = This.GetRowIdFromRow(ll_SelectedEndRow)
			This.SelectRow(ll_RowIdFromRow,TRUE)
//			This.SelectRow(ll_SelectedEndRow + 1,TRUE)
			This.SelectRow(ll_SelectedEndRow,FALSE)
		ELSEIF ll_SelectedRowCount > 1 THEN
			This.RowsMove(ll_SelectedStartRow,ll_SelectedEndRow,Primary!,This,ll_AfterRow, Primary!)
			ll_RowIdFromRow = This.GetRowIdFromRow(ll_SelectedEndRow)
			This.SelectRow(ll_RowIdFromRow,TRUE)
		END IF
		ll_SelectedRowCount --
		*/
		ll_SelectedRowCount --
	Loop
	
	//Set row selections
	This.SelectRow(0,FALSE)
	//First row to highlight
	
	/*
	ll_SelectedStartRow = lla_Selected [1]
	
	ll_SelectedEndRow = lla_Selected [ll_OriRowSelected] 
	
	

	FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow
		This.SelectRow (ll_RowNdx, TRUE)

		IF ll_RowNdx = ll_SelectedStartRow THEN
			This.SetRow ( ll_RowNdx)
		END IF				
	NEXT
	*/
	
	FOR ll_RowNdx = 1 TO ll_OriRowSelected	
		This.SelectRow (This.GetRowIdFromRow(lla_Selected [ll_RowNdx]) , TRUE)
	NEXT
	
END IF

THIS.SetFocus()
*/
end subroutine

public subroutine of_moverowstop ();Long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_TopRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, & 
		ll_RowFound, & 	
		ll_StartRow
		
ll_RowCount 	= This.RowCount()

IF ll_RowCount <= 0 THEN
	RETURN
END IF

ll_StartRow = 0

// This FOR Loop determines how many rows are selected.
FOR ll_RowNdx = 1 TO ll_RowCount
	ll_RowFound	 = This.GetSelectedRow(ll_StartRow)	
	IF ll_RowFound = 0 THEN
		EXIT
	END IF
	This.SelectRow(ll_RowFound,FALSE)
	lla_Selected[ll_RowNdx] = ll_RowFound
	ll_StartRow = ll_RowFound
NEXT

ll_SelectedRowCount = upperbound ( lla_Selected )

IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount
		
		ll_SelectedStartRow 	= lla_Selected[ll_RowNdx]
		ll_SelectedEndRow		= lla_Selected[ll_RowNdx]
		ll_TopRow				= ll_RowNdx
		
		IF (ll_SelectedStartRow = 1 AND ll_SelectedRowCount = 1) THEN
			This.SelectRow(1,TRUE)
		ELSEIF This.RowsMove(ll_SelectedStartRow,ll_SelectedEndRow,Primary!, &
						This,ll_TopRow,Primary!)	= 1 THEN
			This.SelectRow(ll_SelectedStartRow,FALSE)						
			This.SelectRow(ll_TopRow,TRUE)
		END IF
	NEXT
END IF

This.SetFocus()


/*---------------------------------------------------------*/
// Logic from u_cst_eventrouting_clipboard for movetop
/*
Any laa_Selected[]

String ls_KeyColumn
String ls_expression

Long	ll_SelectedStartRow
Long	ll_SelectedEndRow
Long	ll_BeforeRow
Long	ll_SelectedRowCount
Long	ll_RowNdx
Long 	ll_RowCount
Long 	ll_StartRow
Long	ll_RowFound


/**** Change this "key column" according to your requirement.
of_Getselectedshipmentids method will take care of the datatype of "key column"
and return an array of type any
*/
		
ls_KeyColumn = 'ds_id'
		
ll_RowCount = This.RowCount()

This.of_Getselectedshipmentids(laa_Selected,ls_KeyColumn)

ll_SelectedRowCount = UpperBound(laa_Selected)

IF ll_SelectedRowCount > 0 THEN

	FOR ll_RowNdx = 1 to ll_SelectedRowCount

		ls_expression  	  = ls_KeyColumn + " = " + String ( laa_Selected [ll_RowNdx] )
		ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)

		//ll_SelectedStartRow = THIS.Find ( "de_id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )

		CHOOSE CASE ll_SelectedStartRow
			CASE 0 	//problem
				
			CASE 1	//No move necessary
				EXIT 
				
			CASE ELSE
				
				IF ll_RowNdx = 1 THEN
					ll_BeforeRow =  1
				ELSE
					ll_BeforeRow ++
				END IF
				
				ll_SelectedEndRow = ll_SelectedStartRow
				THIS.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, THIS, ll_BeforeRow, Primary! )
			
		END CHOOSE
		
	NEXT
	
	//set row selections
	THIS.SelectRow ( 0, FALSE)
	//first row to highlight

	ls_expression  	  = ls_KeyColumn + " = " + String ( laa_Selected [1] )
	ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)

	//ll_SelectedStartRow = THIS.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	
	ls_expression  	  = ls_KeyColumn + " = " + String ( laa_Selected [ll_SelectedRowCount] )
	ll_SelectedEndRow   = This.Find ( ls_expression,1,ll_RowCount)
	
	//ll_SelectedEndRow = THIS.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

	FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
		
		THIS.SelectRow (ll_RowNdx, TRUE)

		IF ll_RowNdx = ll_SelectedStartRow THEN
			THIS.SetRow ( ll_RowNdx)
		END IF				

	NEXT
	
ELSE
	ll_SelectedStartRow = THIS.GetRow()
	ll_SelectedEndRow = THIS.GetRow()
	IF ll_SelectedStartRow = 1 THEN
		//No move necessary
	ELSE
		ll_BeforeRow = 1
		THIS.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, THIS, ll_BeforeRow, Primary! )
	END IF
	
END IF

THIS.SetFocus()

*/	

end subroutine

public subroutine of_moverowsbottom ();Any laa_Selected[]

String ls_KeyColumn
String ls_expression

Long	ll_SelectedStartRow
Long	ll_SelectedEndRow
Long	ll_BeforeRow
Long	ll_SelectedRowCount
Long	ll_RowNdx
Long 	ll_RowCount
Long 	ll_StartRow
Long	ll_RowFound


/**** Change this "key column" according to your requirement.
of_Getselectedshipmentids method will take care of the datatype of "key column"
and return an array of type any
*/

ls_KeyColumn = 'ds_id'
		
ll_RowCount = This.RowCount()

This.of_Getselectedshipmentids(laa_Selected,ls_KeyColumn)

ll_SelectedRowCount = UpperBound(laa_Selected)

IF ll_SelectedRowCount > 0 THEN
	
	ls_expression  = ls_KeyColumn + " = " + String(laa_Selected [ll_SelectedRowCount])
	ll_SelectedEndRow = This.Find ( ls_expression,1,ll_RowCount)
	
	IF ll_SelectedEndRow = ll_RowCount THEN
		//No move necessary
	ELSE
		FOR ll_RowNdx = 1 TO ll_SelectedRowCount 

			ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [ll_RowNdx] )
			ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)
	
			CHOOSE CASE ll_SelectedStartRow
				CASE 0 	//problem
					
				CASE ELSE
					
					IF ll_RowNdx = 1 THEN
						ll_BeforeRow = ll_RowCount + 1
					END IF
					
					ll_SelectedEndRow = ll_SelectedStartRow
					THIS.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, THIS, ll_BeforeRow, Primary! )
					
			END CHOOSE
			
		NEXT
		//set row selections
		THIS.SelectRow ( 0, FALSE)
		//first row to highlight
		ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [1] )
		ll_SelectedStartRow = This.Find ( ls_expression,1,ll_RowCount)		

		ls_expression  = ls_KeyColumn + " = " + String ( laa_Selected [ll_SelectedRowCount] )		
		ll_SelectedEndRow = This.Find ( ls_expression,1,ll_RowCount)		

		FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
			
			THIS.SelectRow (ll_RowNdx, TRUE)

			IF ll_RowNdx = ll_SelectedStartRow THEN
				THIS.SetRow ( ll_RowNdx)
			END IF				

		next
		
	END IF
	
ELSE
	ll_SelectedStartRow = THIS.GetRow()
	ll_SelectedEndRow = THIS.GetRow()
	IF ll_SelectedStartRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_BeforeRow = ll_RowCount + 1
		THIS.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, THIS, ll_BeforeRow, Primary! )
	END IF
	
END IF

THIS.SetFocus()

//------------------------------------------------------
// Original code by Zach where no key column is available. 
// Gotta re-visit it again.

/*
Long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_BottomRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, & 
		ll_RowFound, & 	
		ll_StartRow, & 
		ll_OriRowSelected
				
ll_RowCount 	= This.RowCount()

IF ll_RowCount <= 0 THEN
	RETURN
END IF

ll_StartRow = 0


// This FOR Loop determines how many rows are selected.
FOR ll_RowNdx = 1 TO ll_RowCount
	ll_RowFound	 = This.GetSelectedRow(ll_StartRow)	
	IF ll_RowFound = 0 THEN
		EXIT
	END IF
	This.SelectRow(ll_RowFound,FALSE)
	lla_Selected[ll_RowNdx] = ll_RowFound
	ll_StartRow = ll_RowFound
NEXT

ll_SelectedRowCount = upperbound ( lla_Selected )

IF ll_SelectedRowCount > 0 THEN
	ll_OriRowSelected = ll_SelectedRowCount
	ll_BottomRow = ll_RowCount + 1
	Do While ll_SelectedRowCount <> 0
		ll_SelectedStartRow 	= lla_Selected[ll_SelectedRowCount]
		ll_SelectedEndRow		= ll_SelectedStartRow
		
		IF (ll_SelectedStartRow = 1 AND ll_RowCount = 1) THEN
			This.SelectRow(1,TRUE)
		ELSEIF (ll_SelectedStartRow = ll_RowCount AND ll_RowCount > 1) THEN
			This.SelectRow(ll_RowCount,TRUE)
		ELSEIF ll_SelectedRowCount = 1 AND ll_OriRowSelected = 1 THEN	
			This.RowsMove(ll_SelectedStartRow,ll_SelectedEndRow,Primary!, &
								This,ll_BottomRow,Primary!) 
			This.SelectRow(ll_SelectedEndRow,FALSE)																
			This.SelectRow(ll_RowCount,TRUE)			
		ELSE
			This.RowsMove(ll_SelectedStartRow,ll_SelectedEndRow,Primary!, &
								This,ll_BottomRow,Primary!) 
			This.SelectRow(ll_SelectedEndRow,FALSE)																					
			IF ll_BottomRow > ll_ROwCount THEN
				ll_BottomRow = ll_ROwCount
			END IF
//			This.SelectRow(ll_BottomRow,TRUE)
			This.SelectRow(This.GetRowIDFromRow(ll_SelectedEndRow),TRUE)
		END IF			
		
		ll_SelectedRowCount --
		ll_BottomRow -- 			
	Loop
END IF

This.SetFocus()

*/
end subroutine

public function integer of_selectallrows ();Return This.SelectRow(0, TRUE)
end function

public function integer of_unselectallrows ();Return This.SelectRow(0, FALSE)
end function

public subroutine of_getselectedshipmentids (ref long ala_shipmentids[]);Long ll_Ctr
Long ll_RowCount
Long ll_StartRow
Long ll_RowFound
Long lla_Selected[]

ll_RowCount = This.RowCount()
ll_StartRow = 0

FOR ll_Ctr = 1 TO ll_RowCount
	ll_RowFound	 = This.GetSelectedRow(ll_StartRow)	
	IF ll_RowFound = 0 THEN
		EXIT
	END IF
	lla_Selected[ll_Ctr] = This.Object.ds_id[ll_RowFound]	
	This.SelectRow(ll_RowFound,FALSE)
	ll_StartRow = ll_RowFound
NEXT

ala_shipmentids = lla_Selected
end subroutine

public subroutine of_getselectedshipmentids (ref any aaa_shipmentids[], string as_keycolumn);Long ll_Ctr
Long ll_RowCount
Long ll_StartRow
Long ll_RowFound

Any laa_shipmentids[]

String ls_ColType

ll_RowCount = This.RowCount()

ll_StartRow = 0

ls_ColType = Upper(This.Describe(as_keycolumn + ".ColType"))

FOR ll_Ctr = 1 TO ll_RowCount
	ll_RowFound	 = This.GetSelectedRow(ll_StartRow)	
	IF ll_RowFound = 0 THEN
		EXIT
	END IF

	CHOOSE CASE ls_ColType
		CASE 'LONG'		
			laa_shipmentids[ll_Ctr] = THIS.GetItemNumber(ll_RowFound,as_keycolumn)
			
		CASE 'CHAR(32766)' // For string	
			laa_shipmentids[ll_Ctr] = THIS.GetItemString(ll_RowFound,as_keycolumn)
			
		CASE 'CHAR(1)' // For Character
			laa_shipmentids[ll_Ctr] = THIS.GetItemString(ll_RowFound,as_keycolumn)
			
		CASE 'DATE'
			laa_shipmentids[ll_Ctr] = THIS.GetItemDate(ll_RowFound,as_keycolumn)			
			
		CASE 'DATETIME'
			laa_shipmentids[ll_Ctr] = THIS.GetItemDateTime(ll_RowFound,as_keycolumn)						
			
		CASE 'TIME'
			laa_shipmentids[ll_Ctr] = THIS.GetItemTime(ll_RowFound,as_keycolumn)						
			
		CASE 'DECIMAL(2)'										
			laa_shipmentids[ll_Ctr] = THIS.GetItemDecimal(ll_RowFound,as_keycolumn)						
			
	END CHOOSE		
	
	This.SelectRow(ll_RowFound,FALSE)
	ll_StartRow = ll_RowFound
NEXT

aaa_shipmentids = laa_shipmentids


end subroutine

public subroutine of_setselecteditem (string as_value);is_SelectedItem = as_Value
end subroutine

public function boolean of_storemanualfilter ();any	la_value

boolean	lb_Store

n_cst_settings lnv_Settings

IF lnv_Settings.of_GetSetting ( 165 , la_value ) <> 1 THEN
	//default
	lb_Store = false
else
	IF STRING ( la_Value ) = "YES!" THEN
		lb_Store = true
	else
		lb_Store = false
	end if
END IF

return lb_store
end function

public subroutine of_processpsr (readonly n_cst_msg anv_msg);/***************************************************************************************
NAME			: of_ProcessPSR
ACCESS		: Private 
ARGUMENTS	: String		PSR File Name (path incl.)
RETURNS		: Integer	(1=Success, -1=Failure)
DESCRIPTION	: Opens the PSR View window
					The PSR window will call the PSR Manager 
REVISION		: RDT 4-1-03
***************************************************************************************/
Long		lla_ShipId[]
		
Integer li_Return = 1, li_Counter
String	ls_FileName

n_cst_Msg	lnv_msg
s_parm		lstr_parm


				
IF isValid(anv_Msg) THEN
	IF anv_Msg.of_Get_Parm("TEMPLATE", lstr_Parm) <> 0 THEN
		ls_FileName = lstr_Parm.ia_Value
	END IF
	IF anv_msg.of_Get_Parm("SHIPMENTIDS", lstr_Parm) <> 0 THEN
		lla_ShipId[] = lstr_Parm.ia_Value
	END IF
END IF

// check for ".psr" in file name
If Upper( Right( ls_filename , 4 ) ) = ".PSR" Then
	
	IF UpperBound(lla_ShipId) < 1 THEN //IF shipment ids were not passed in, get selected
		This.Event ue_GetSelectedIds ( lla_ShipId )
	END IF

	If UpperBound( lla_ShipId ) > 0 Then
	
			lstr_Parm.is_label = "FILENAME"
			lstr_Parm.ia_value = ls_filename
			lnv_Msg.of_Add_Parm( lstr_Parm )
			
			lstr_Parm.is_label = "SHIPMENTID"
			lstr_Parm.ia_value =  lla_ShipId
			lnv_Msg.of_Add_Parm( lstr_Parm )
			
			W_Psr_Viewer	lw_Psr
			
			OpenSheetWithParm ( lw_psr, lnv_msg, gnv_App.of_GetFrame ( ),0 , Layered! )
	End If
End If



end subroutine

public function integer of_hidecharges ();//created by DAN 1-29-07 to hide charge columbs.


Int	li_Return = 1

this.modify( "comp_custbill_tot.Visible=0" )
this.modify( "comp_custbill_tot_t.Visible=0" )
this.modify( "comp_custbill_tot.Visible=0" )
this.modify( "shipment_netCharges.Visible=0" )
this.modify( "shipment_payables.Visible=0" )
this.modify( "shipment_payables_t.Visible=0" )
this.modify( "shipment_netcharges_t.Visible=0" )

RETURN li_RETURN
end function

event constructor;//Relocated to ue_SetView for User-definable summary.
//This.DataObject = "d_bill_list"
This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )
This.of_SetUpdateable ( FALSE )  //This doesn't seem to have much effect on its own

This.of_SetAutoFind ( TRUE )
This.of_SetAutoSort ( TRUE )
This.of_SetAutoFilter ( TRUE )

THIS.of_SetRowSelect ( TRUE ) 



//Relocated to ue_SetView for User-definable summary.
//
////The following is common to the search screen and u_ship_list
//
//n_cst_ShipmentManager	lnv_ShipmentManager
//n_cst_Ship_Type			lnv_ShipType
//DWObject						ldwo_ShipType
//
////Populate the status code table
//This.Modify ( "ds_Status.Edit.CodeTable = Yes "+&
//	"ds_Status.Values = '" + lnv_ShipmentManager.of_GetStatusCodeTable ( ) + "'" )
//
////Populate the reference lists
//lnv_ShipmentManager.of_PopulateReferenceLists ( This )
//
////Populate shipment type list
//ldwo_ShipType = This.Object.ds_Ship_Type
//lnv_ShipType.of_Populate ( ldwo_ShipType )
//DESTROY ldwo_ShipType
//
////This shows or hides the Total Charges summary based on settings and privileges.
//lnv_ShipmentManager.of_PrepareSummaryDisplay ( This )


//This replaces the gf_MultiSelect processing in the clicked event in w_Search.
//NOTE : There's extra load builder processing in u_ship_list not accounted for here.

This.of_SetRowSelect ( TRUE ) 
This.inv_RowSelect.of_SetStyle ( appeon_constant.appeon_EXTENDED ) 

This.il_NormalFooterHeight = Long ( This.Describe ( "DataWindow.Footer.Height" ) )


//Instantiate the Mediator Object
inv_Mediator = CREATE n_cst_Mediator_DataManager
inv_Mediator.of_RegisterTarget ( THIS , "shipment" )
end event

event ue_autofilter;call super::ue_autofilter;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

String	lsa_ExcludeColumns[]
Integer	li_ExcludeCount
n_cst_AnyArraySrv	lnv_Arrays


IF AncestorReturnValue = SUCCESS THEN


	inv_Filter.of_SetVisibleOnly ( FALSE )
	inv_Filter.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_DBName )

	This.of_SetBase ( TRUE )
	li_ExcludeCount = inv_Base.of_GetObjects(lsa_ExcludeColumns, "compute", "*", FALSE /*Not VisOnly*/) 
	li_ExcludeCount = lnv_Arrays.of_AppendString ( lsa_ExcludeColumns, &
		{ "Shipment_Reserved1", "Shipment_Intsig", "Shipment_PayFormat", "cs_timestamp", &
			"nextevent_id", &
			"nextevent_equipment_id", &
			"nextevent_equipment_description_d", /*The second instance of this column*/ &
			"lastconfirmed_id", &
			"origin_name_d", /*The second instance of this column*/ &
			"destination_name_d" /*The second instance of this column*/ &
			} )

//			This is a list of columns that were being screened prior to 3.5.03, 
//			but are now ok to include in the list because they have intelligible names.
//
//			"Shipment_Ref1Type", "Shipment_Category", & 
//			"nextevent_type", &
//			"nextevent_siteid", &
//			"nextevent_site", &
//			"nextevent_city", &
//			"nextevent_state", &
//			"nextevent_location", &
//			"nextevent_date", &
//			"nextevent_time", &
//			"nextevent_equipment_type", &
//			"nextevent_equipment_number", &
//			"nextevent_equipment_description", &
//			"lastconfirmed_type", &
//			"lastconfirmed_site", &
//			"lastconfirmed_company", &
//			"lastconfirmed_city", &
//			"lastconfirmed_state", &
//			"lastconfirmed_location", &
//			"lastconfirmed_date", &
//			"lastconfirmed_time", &
//			"shipment_scheduledpickupdate", &
//			"shipment_scheduledpickuptime", &
//			"shipment_scheduleddeliverydate", &
//			"shipment_scheduleddeliverytime", &
//			"shipment_pickedup", &
//			"shipment_delivered", &


	inv_Filter.of_SetExclude ( lsa_ExcludeColumns )

END IF

RETURN AncestorReturnValue
end event

event ue_autofind;call super::ue_autofind;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

IF AncestorReturnValue = SUCCESS THEN

	//inv_Find.of_SetVisibleOnly ( FALSE )  NOT Available
	inv_Find.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_DBName )

END IF

RETURN AncestorReturnValue
end event

event ue_autosort;call super::ue_autosort;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

String	lsa_ExcludeColumns[]
Integer	li_ExcludeCount
n_cst_AnyArraySrv	lnv_Arrays

IF AncestorReturnValue = SUCCESS THEN

	inv_Sort.of_SetVisibleOnly ( FALSE )
	inv_Sort.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_DBName )

	This.of_SetBase ( TRUE )
	li_ExcludeCount = inv_Base.of_GetObjects(lsa_ExcludeColumns, "compute", "*", FALSE /*Not VisOnly*/) 
	li_ExcludeCount = lnv_Arrays.of_AppendString ( lsa_ExcludeColumns, &
		{ "Shipment_Reserved1", "Shipment_Intsig", "Shipment_PayFormat", "cs_timestamp", &
			"nextevent_id", &
			"nextevent_equipment_id", &
			"nextevent_equipment_description_d", /*The second instance of this column*/ &
			"lastconfirmed_id", &
			"origin_name_d", /*The second instance of this column*/ &
			"destination_name_d" /*The second instance of this column*/ &
			} )

//			This is a list of columns that were being screened prior to 3.5.03, 
//			but are now ok to include in the list because they have intelligible names.
//
//			"nextevent_type", &
//			"nextevent_siteid", &
//			"nextevent_site", &
//			"nextevent_city", &
//			"nextevent_state", &
//			"nextevent_location", &
//			"nextevent_date", &
//			"nextevent_time", &
//			"nextevent_equipment_type", &
//			"nextevent_equipment_number", &
//			"nextevent_equipment_description", &
//			"lastconfirmed_type", &
//			"lastconfirmed_site", &
//			"lastconfirmed_company", &
//			"lastconfirmed_city", &
//			"lastconfirmed_state", &
//			"lastconfirmed_location", &
//			"lastconfirmed_date", &
//			"lastconfirmed_time", &
//			"shipment_scheduledpickupdate", &
//			"shipment_scheduledpickuptime", &
//			"shipment_scheduleddeliverydate", &
//			"shipment_scheduleddeliverytime", &
//			"shipment_pickedup", &
//			"shipment_delivered", &

	// Note : Unlike filter, we were already including 			"Shipment_Ref1Type", "Shipment_Category"

	inv_Sort.of_SetExclude ( lsa_ExcludeColumns )

END IF

RETURN AncestorReturnValue
end event

event doubleclicked;IF Row > 0 THEN
	This.Event ue_ShipmentDetail ( Row )
END IF
end event

event rbuttonup;//Overriding ancestor script to intervene with special popup selections for certain objects.
//If no special processing is appropriate, forwards request to ancestor for default processing.
// RDT 8-20-03 Refresh if Auto Routing
// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos

// BKW 02-09-04 3.8.02 Change logic for handling right click on next event info.
//   This is now specific to whether you're clicking on powerunit or driver fields.
//   The nextevent fields that have actions associated are powerunit_..., driver_..., and site


string	ls_Name, &
			ls_IdColumn, &
			lsa_parm_labels[]
any		laa_parm_values[]

Long		ll_EquipmentId, &
			ll_NextEventId
Date		ld_ItineraryDate
Integer	li_ItinType
n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_ShipmentManager	lnv_ShipmentManager

Long	ll_Return = 0

IF ib_rmbmenu AND NOT IsNull ( dwo ) THEN

	ls_Name = Lower ( dwo.Name )



	//These checks were added 3.6.00 (after 3.6.b3) BKW 7/20/03
	//These checks were modified in 3.8.02 BKW 2/8/04

	//Checks for Row > 0 added 3.7.00 BKW 10/1/03, to prevent invalid row/col crash if right click was on header.
	//This change was included in 3.7.00 and 3.7.01, and then accidentally dropped from 3.7.02 through 3.8.06.
	//It was reintroduced in 3.8.07

	IF Match ( ls_Name, "^nextevent_driver" ) AND Row > 0 THEN

		//Note: We cannot do the same special processing for nextevent2, 3, & 4 because we don't have
		//their routing info like we do for nextevent.

		ls_IdColumn = "NextEvent_Driver_Id"
		
	ELSEIF Match ( ls_Name, "^nextevent_powerunit" ) AND Row > 0 THEN

		//Note: We cannot do the same special processing for nextevent2, 3, & 4 because we don't have
		//their routing info like we do for nextevent.

		ls_IdColumn = "NextEvent_PowerUnit_Id"

	ELSEIF Match ( ls_Name, "^lastconfirmed" ) AND Row > 0 THEN

		//This may be trumped by the siteid checks in the CHOOSE CASE, below
		ls_IdColumn = "LastConfirmed_Id"

	END IF		
	


	choose case ls_Name

	case "billto_name"
		ls_IdColumn = "billto_id"

	case "origin_name", "origin_name_d"
		ls_IdColumn = "origin_id"

	case "destination_name", "destination_name_d"
		ls_IdColumn = "destination_id"

	case "shipment_invoicenumber", "ds_id"
		ls_IdColumn = "ds_id"

	CASE "nextevent_site"
		ls_IdColumn = "NextEvent_SiteId"

	CASE "nextevent2_site"
		ls_IdColumn = "NextEvent2_SiteId"

	CASE "nextevent3_site"
		ls_IdColumn = "NextEvent3_SiteId"

	CASE "nextevent4_site"
		ls_IdColumn = "NextEvent4_SiteId"

	CASE "lastconfirmed_site"
		ls_IdColumn = "LastConfirmed_SiteId"
	
/////////////////

// These two were replaced by different processing, above, 3.6.00 BKW

//	CASE "nextevent_type", "nextevent_date", "nextevent_time", "nextevent_location"
//		ls_IdColumn = "NextEvent_Id"

//	CASE "lastconfirmed_type", "lastconfirmed_date", "lastconfirmed_time", "lastconfirmed_location"
//		ls_IdColumn = "LastConfirmed_Id"

/////////////////
		
	CASE "shipment_ref1text" , "shipment_ref2text" , "shipment_ref3text"
		
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "Copy Text"
	
		IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "COPY TEXT" THEN
			THIS.Event ue_CopyText ( ls_Name )
		END IF
		ll_Return = 1
	
	// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos
	CASE "p_shipnotesfull", "p_shipnotesempty"
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "View Notes"
		IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "VIEW NOTES" THEN
			THIS.event ue_ShowNotes(This.Object.ds_id[row])	
		END IF
		ll_Return = 1
	// ZMC 12-12-03 Show Shipment notes for AutoRoute Repos		
		
	end choose
	
	
	//If any of the above logic based on the various column & object names set an ls_IdColumn value 
	//for special action, perform that processing now.
	
	CHOOSE CASE ls_IdColumn
	
	CASE "billto_id", "origin_id", "destination_id", "NextEvent_SiteId", "NextEvent2_SiteId", &
		"NextEvent3_SiteId", "NextEvent4_SiteId", "LastConfirmed_SiteId"

		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "COMPANY"
		lsa_parm_labels[2] = "CO_ID"
		laa_parm_values[2] = this.getitemnumber(row, ls_IdColumn)
		if ls_IdColumn = "billto_id" then
			lsa_parm_labels[3] = "ADDRESS_TYPE"
			laa_parm_values[3] = "BILLING"
		end if

		f_pop_standard(lsa_parm_labels, laa_parm_values)

		ll_Return = 1
	
	CASE "ds_id"
		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "SHIPMENT_PERFORM_OPEN"
		lsa_parm_labels[2] = "TARGET_ID"
		laa_parm_values[2] = this.getitemnumber(row, ls_IdColumn)
		lsa_parm_labels[3] = "DATAWINDOW"
		laa_parm_values[3] = THIS
		
		IF This.GetSelectedRow ( 0 ) > 0 THEN
			
			lsa_parm_labels[4] = "TARGET_IDS"
			laa_parm_values[4] = This.Object.ds_id.Selected
			
		END IF
	
		// f_pop_standard(lsa_parm_labels, laa_parm_values)													// RDT 8-13-03 
		If f_pop_standard(lsa_parm_labels, laa_parm_values) = "AUTOROUTE_SHIPMENT!" Then 			// RDT 8-13-03 
			This.Event ue_CacheRetrieve ( FALSE /* no refresh cache*/, FALSE  /*no Force reload*/ )// RDT 8-13-03 
		End If																												// RDT 8-13-03 
		

		ll_Return = 1
	
	CASE "LastConfirmed_Id"
	
		ll_EquipmentId = This.GetItemNumber ( Row, "nextevent_equipment_id" )
		//Note:  Although this looks like a mistake (getting an equipment id for "LastConfirmed_Id"
		//from the "nextevent_equipment_id" field, it's actually not.  The contents of that field
		//have been reinterpreted in 3.8 (to be the freight-carrying equipment or bare chassis used
		//for the last confirmed event -- or the event prior to the first unconfirmed event).
		//However, the field name could not be changed, so it's now a misnomer, although in most
		//cases except cross dock the equipment will turn out to be the same.
	
		ld_ItineraryDate = This.GetItemDate ( Row, "LastConfirmed_Date" )
	
		IF NOT ( IsNull ( ll_EquipmentId ) OR IsNull ( ld_ItineraryDate ) ) THEN
	
			lsa_Parm_Labels [ 1 ] = "ADD_ITEM"
			laa_Parm_Values [ 1 ] = "&Itinerary"
		
			CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
			CASE "ITINERARY"
		
				lnv_EquipmentManager.of_OpenItinerary ( ll_EquipmentId, ld_ItineraryDate )
		
			END CHOOSE

			//By putting this here, if there's no date, they get the default popup instead.
			//Is this what we want???
			ll_Return = 1
		
		END IF
		
	CASE "NextEvent_Driver_Id", "NextEvent_PowerUnit_Id"
		
		//Give user an option to show the itinerary for the Driver or PowerUnit they're right-clicking on
		//for the date that the event's been routed.
		
		lsa_Parm_Labels [ 1 ] = "ADD_ITEM"
		laa_Parm_Values [ 1 ] = "&Itinerary"
	
		CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
				
		CASE "ITINERARY"

	
			//We don't actually have id fields for the powerunit or driver in the datastore, so we'll call 
			//a service function with the event id and itin type we want, and let it figure out the routing 
			//date and the PowerUnit or Driver assigned to that event.
			
			//Get the event id.
			ll_NextEventId = This.GetItemNumber( Row, "NextEvent_Id" )
			
			
			//Determine the ItinType value.
			
			CHOOSE CASE ls_IdColumn
					
			CASE "NextEvent_Driver_Id"
				li_ItinType = gc_Dispatch.ci_ItinType_Driver
				
			CASE "NextEvent_PowerUnit_Id"
				li_ItinType = gc_Dispatch.ci_ItinType_PowerUnit
					
			END CHOOSE
			
			
			//Call the service function to open the itinerary window.		
			lnv_ShipmentManager.of_openitinerary( ll_NextEventId, li_ItinType)
	
		END CHOOSE


		//Now, prevent the sort / filter / find popup.
		ll_Return = 1
		
		
	END CHOOSE

END IF


//If the request has not already been handled by special processing above, forward the
//request to the ancestor for default processing.

IF ll_Return = 0 THEN

	ll_Return = Super::Event rButtonUp ( xpos, ypos, row, dwo )

END IF


RETURN ll_Return
end event

event pfc_print;//Overriding ancestor script.  If the display has r_test (the hatching rectangle)
//move it out of the way of the print operation, and then back once the print completes.

//Either way, we call the ancestor pfc_Print ( )

String	ls_Check

Integer	li_Return

ls_Check = This.Describe ( "r_test.name" )

IF ls_Check = "r_test" THEN
	This.Modify ( "r_test.y = 100" )
END IF

This.Modify ( "DataWindow.Footer.Height = " + String ( il_PrintFooterHeight ) )

li_Return = Super::Event pfc_Print ( )

IF ls_Check = "r_test" THEN
	This.Modify ( "r_test.y = 0" )
END IF

This.Modify ( "DataWindow.Footer.Height = " + String ( il_NormalFooterHeight ) )

RETURN li_Return
end event

event lbuttonup;call super::lbuttonup;//Extending ancestor

//Since RowSelection processing may have changed the selection, 
//update the LoadBuilder.

//Note : RowSelection has not changed after the clicked event finishes.
//You see a one-cycle lag if you put this code there.
//So, this is the appropriate place to intervene, not Clicked.

This.Event Post ue_UpdateLoadBuilder ( )

RETURN AncestorReturnValue
end event

event buttonclicked;CHOOSE CASE Lower ( dwo.Name )

CASE Lower ( "cb_Details" )
	This.Event ue_Details ( )

CASE Lower ( "cb_Duplicate" )
	This.Event ue_Duplicate ( )

CASE Lower ( "cb_LoadBuilder" )
	This.Event ue_SetLoadBuilder ( TRUE )

CASE Lower ( "cb_RateLookup" )
	This.Event ue_RateLookup ( )

CASE Lower ( "cb_Document" )
	This.Event ue_Document ( )

END CHOOSE
end event

event clicked;//override 
Long	ll_Rtn = 0 // Continue Processing

IF Keydown ( KeyAlt! ) THEN
	
	inv_Mediator.of_CreateFilterObject ( dwo , Row ) 
	
ELSE
	ll_Rtn = Super::Event clicked ( xpos,ypos,row,dwo )
END IF

RETURN ll_Rtn
end event

event destructor;call super::destructor;DESTROY inv_Mediator 

THIS.of_SetRowSelect ( FALSE )
end event

on u_dw_shipmentlist.create
end on

on u_dw_shipmentlist.destroy
end on

event pfc_filterdlg;call super::pfc_filterdlg;long	ll_return

ll_return = AncestorReturnValue

if this.of_Storemanualfilter( ) then
	if ll_return = 1 then
		if is_Selecteditem = "Overview" then
			is_ManualFilter = THIS.Describe ( "DataWindow.Table.Filter" ) 
			If is_ManualFilter='?' Then is_ManualFilter = ''
		end if
	end if
end if

return ll_return
end event

