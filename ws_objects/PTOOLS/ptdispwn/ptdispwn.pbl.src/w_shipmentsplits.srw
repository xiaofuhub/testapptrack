$PBExportHeader$w_shipmentsplits.srw
forward
global type w_shipmentsplits from w_response
end type
type dw_parent from u_dw_shipment within w_shipmentsplits
end type
type dw_children from u_dw_shipment within w_shipmentsplits
end type
type st_1 from u_st within w_shipmentsplits
end type
type st_parent from u_st within w_shipmentsplits
end type
type st_children from u_st within w_shipmentsplits
end type
type cb_1 from u_cb within w_shipmentsplits
end type
type cb_2 from u_cb within w_shipmentsplits
end type
type cb_3 from u_cb within w_shipmentsplits
end type
type cb_4 from u_cb within w_shipmentsplits
end type
type st_targetid from u_st within w_shipmentsplits
end type
type cb_nonrouted from u_cb within w_shipmentsplits
end type
type cb_duplicate from u_cb within w_shipmentsplits
end type
type uo_items from u_2dw_rowselection within w_shipmentsplits
end type
end forward

global type w_shipmentsplits from w_response
integer x = 110
integer y = 16
integer width = 3479
integer height = 2256
string title = "Shipment Splits"
long backcolor = 80269524
dw_parent dw_parent
dw_children dw_children
st_1 st_1
st_parent st_parent
st_children st_children
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
st_targetid st_targetid
cb_nonrouted cb_nonrouted
cb_duplicate cb_duplicate
uo_items uo_items
end type
global w_shipmentsplits w_shipmentsplits

type variables
Private:
n_cst_bso_Dispatch	inv_Dispatch
Long			il_CurrentShipmentID
n_cst_msg		inv_msg

n_ds			ids_items
n_cst_beo_item		inv_Item

boolean			ib_closeandjump
end variables

forward prototypes
public function integer wf_setcurrentshipmentid (readonly long al_currentshipmentid)
public function long wf_getcurrentshipmentid ()
public function integer wf_retrieveshipmentsplits (readonly long al_shipmentids[])
public function integer wf_refreshdisplay ()
public function integer wf_retrieveshipment (readonly long al_shipmentid)
public subroutine wf_closeandjump (readonly long al_jumpid)
public function long wf_getparentid ()
public function boolean wf_currentshipmenthasparent ()
public function integer wf_validatechildselection (long al_selectedchildid, ref string as_resultingerrormessaage)
public function integer wf_validateparentselection (long al_selectedparentid, ref string as_resultingerrormessage)
public function long wf_selectshipmentid ()
public subroutine wf_rerateitems ()
public function integer wf_copycache ()
public function integer wf_setdwblobs ()
end prototypes

public function integer wf_setcurrentshipmentid (readonly long al_currentshipmentid);il_CurrentShipmentID = al_CurrentShipmentID
RETURN 1
end function

public function long wf_getcurrentshipmentid ();RETURN il_currentshipmentid
end function

public function integer wf_retrieveshipmentsplits (readonly long al_shipmentids[]);// returns 1, -1  ( assumed failure -1 )

Int	li_Return = -1

IF isValid ( inv_Dispatch ) THEN
	CHOOSE CASE inv_Dispatch.of_RetrieveShipmentSplits( al_shipmentids ) 
		CASE 1, 0  // general success
			li_Return = 1
			
			
		CASE -1  // Error  
			MessageBox ( "Retrieve Shipment Splits" , "An error occurred while attempting" + &
								+" to retrieve the requested information.  Request cancelled.")
							
								
		CASE -2  // DB conflict
			MessageBox ( "Retrieve Shipment Splits", "A check with the database indicates that the "+&
						"information that you are working with has been updated by another user. " +&
						"This may cause conflicts in saving your changes. "+&
						"You should attempt to save now, before continuing.  Request cancelled." )
			
	END CHOOSE
END IF
				
	
RETURN li_Return
end function

public function integer wf_refreshdisplay ();// RDT 6-11-03 Removed GetFullState & SetFullState due to "issues" in PB 8.0 and use RowsCopy instead.

////RETURNS 1, -1  
//
//// check return placement
//
Long	ll_ID, &
		ll_Row, &
		ll_RowCount
		
Int	li_Return = -1
Blob	lblb_State
String	ls_ParentFilter
String	ls_ChildrenFilter
DataStore  lds_CacheCopy

dw_Parent.SetReDraw (FALSE)
dw_Children.SetReDraw (FALSE)

inv_Dispatch.of_CopyShipmentCache ( lds_CacheCopy )

IF IsValid ( lds_CacheCopy ) THEN
	ll_id = THIS.wf_getCurrentShipmentID ( )
	
	// set up the "parent" dw
	ls_ParentFilter = inv_Dispatch.of_GetShipmentParentFilter ( ll_ID )
	IF Not ISNull (ls_ParentFilter )  THEN
		dw_Parent.SetTransObject ( SQLCA )
		
		// RDT 6-11-03 Commented section - Start 
		//lds_CacheCopy.setFilter (ls_ParentFilter)
		//lds_CacheCopy.Filter ( )
		//lds_CacheCopy.GetFullState ( lblb_State )
		//dw_Parent.SetFullState ( lblb_State )
		// RDT 6-11-03 Commented section - end 
		
		dw_Parent.Reset()			
		lds_CacheCopy.RowsCopy( 1, lds_CacheCopy.RowCount() +1, Primary!, dw_Parent, 1, Primary!)
		lds_CacheCopy.RowsCopy( 1, lds_CacheCopy.FilteredCount() +1, Filter!, dw_Parent, 1, Filter!)
		lds_CacheCopy.RowsCopy( 1, lds_CacheCopy.DeletedCount() +1, Delete!, dw_Parent, 1, Delete!)

		dw_Parent.setFilter (ls_ParentFilter)
		dw_Parent.Filter ( )

	END IF
	
	// now set up the "children" dw
	ls_ChildrenFilter = inv_Dispatch.of_GetShipmentChildFilter ( ll_ID )

	IF Not IsNull ( ls_ChildrenFilter ) THEN
		dw_Children.SetTransObject ( SQLCA )
		
		// RDT 6-11-03 Commented section - start 
		//	lds_CacheCopy.setFilter (ls_ChildrenFilter)
		//	lds_CacheCopy.Filter ( )		
		//lds_CacheCopy.GetFullState ( lblb_State )
		//dw_Children.SetFullState ( lblb_State )
		// RDT 6-11-03 Commented section - end 		

		dw_Children.Reset ( )	
		lds_CacheCopy.RowsCopy( 1, lds_CacheCopy.RowCount() +1, Primary!, dw_Children, 1, Primary!)
		lds_CacheCopy.RowsCopy( 1, lds_CacheCopy.FilteredCount() +1, Filter!, dw_Children, 1, Filter!)
		lds_CacheCopy.RowsCopy( 1, lds_CacheCopy.DeletedCount() +1, Delete!, dw_Children, 1, Delete!)

		dw_Children.SetFilter (ls_ChildrenFilter)
		dw_Children.Filter ( )
		dw_Children.ResetUpdate ( )

	END IF
	
	li_Return = 1  
	
END IF

dw_Parent.SetReDraw (TRUE)
dw_Children.SetReDraw (TRUE)
	
RETURN li_Return

end function

public function integer wf_retrieveshipment (readonly long al_shipmentid);// returns 1, -1  ( assumed failure -1 )

Int	li_Return = -1

IF isValid ( inv_Dispatch ) THEN
	CHOOSE CASE inv_Dispatch.of_RetrieveShipments( {al_shipmentid} ) 
		CASE 1, 0  // general success
			li_Return = 1
			
			
		CASE -1  // Error  
			MessageBox ( "Retrieve Shipment" , "An error occurred while attempting" + &
								+" to retrieve the requested shipment.  Request cancelled.")
							
								
		CASE -2  // DB conflict
			MessageBox ( "Retrieve Shipment", "A check with the database indicates that the "+&
						"information that you are working with has been updated by another user. " +&
						"This may cause conflicts in saving your changes. "+&
						"You should attempt to save now, before continuing.  Request cancelled." )
			
	END CHOOSE
END IF
				
	
RETURN li_Return
end function

public subroutine wf_closeandjump (readonly long al_jumpid);n_cst_msg	lnv_msg
S_Parm 		lstr_Parm
SetPointer ( HOURGLASS! )

lstr_Parm.is_Label = "JUMPID"
lstr_Parm.ia_Value = al_jumpid
lnv_Msg.of_Add_Parm (lstr_Parm )

this.wf_rerateitems()
ib_closeandjump = true
CloseWithReturn ( THIS , lnv_Msg )

end subroutine

public function long wf_getparentid ();RETURN dw_Parent.Event ue_GetParentID ( )
end function

public function boolean wf_currentshipmenthasparent ();boolean	lb_Rtn

IF dw_Parent.RowCount ( ) > 0 THEN
	lb_Rtn = TRUE
END IF

RETURN lb_Rtn 
end function

public function integer wf_validatechildselection (long al_selectedchildid, ref string as_resultingerrormessaage);Long		ll_CurrentShipID
LOng		ll_ParentID
Long		ll_NewShipID
String	ls_ErrorMessage

Int		li_Return = 1

ll_CurrentShipID = THIS.wf_GetCurrentShipmentID ( )
ll_NewShipID     = al_selectedchildid
ll_ParentID       = THIS.wf_GEtParentID ( )

IF ll_NewShipID = ll_CurrentShipID THEN
	ls_ErrorMessage = "You can't assign a shipment as its own child."
	li_Return = -1

ELSEIF ll_NewShipID = ll_parentID THEN
	ls_ErrorMessage = "The selected shipment is already assigned as the parent of shipment " +&
							+ String ( ll_CurrentShipID )+ "."
							li_Return = -1

END IF

IF li_Return = -1 THEN
	as_ResultingErrorMessaage = ls_ErrorMessage
END IF

RETURN li_Return
end function

public function integer wf_validateparentselection (long al_selectedparentid, ref string as_resultingerrormessage);/* This event will determine if the id passed in already exists as an entry in the "children"
   datawindow. 
	
	Returns: # > 0   row number of the found id
	         0       id not found
				# < 0   error
				
				
*/

String	ls_ErrorMessage
Long 		ll_FindRtn
Long		ll_CurrentShipID

Int		li_Return = 1

ll_CurrentShipID = THIS.wf_GetCurrentShipmentID ( )

IF ll_CurrentShipID = al_SelectedParentID THEN
	ls_ErrorMessage = "You can't assign a shipment as its own parent."
	li_Return = -1
ELSE

	ll_FindRtn = dw_children.Find ( "ds_id = " + String ( al_SelectedParentID ) , 1 , dw_children.RowCount ( ) )
	
	IF ll_FindRtn > 0 THEN
		ls_ErrorMessage = "The selected shipment is already assigned as a child of this shipment.  Request cancelled."
		li_Return = -1
	ELSEIF ll_FindRtn < 0 THEN
		ls_ErrorMessage = "An error occurred while attempting to validate your selection.  Request cancelled."
		li_Return = -1
	END IF
	
END IF

IF li_Return = -1 THEN
	as_ResultingErrorMessage = ls_ErrorMessage
END IF
	
		
RETURN li_Return
end function

public function long wf_selectshipmentid ();s_anys open_parms, disp_parms
Long		ll_Id
String	ls_Category

open_parms.anys[1] = gc_Dispatch.ci_ItinType_Shipment
open_parms.anys[2] = "ALL_SHIPS"
open_parms.anys[3] = null_date
open_parms.anys[4] = null_long
open_parms.anys[5] = "PASS"

openwithparm(w_itin_select, open_parms)

disp_parms = message.powerobjectparm

ls_Category = disp_parms.anys[1]

if ls_Category = "SHIP" then
	ll_Id = disp_parms.anys[2]
end if

RETURN ll_Id 
end function

public subroutine wf_rerateitems ();integer	li_return = 1

long	ll_row, &
		ll_rowcount, &
		ll_id, &
		ll_shipId
		
string	ls_codename, &
			ls_taglist, &
			ls_Changed, &
			ls_newvalue

n_cst_AnyArraySrv		lnv_ArraySrv

n_cst_RateData			lnva_rateData[]
n_cst_LicenseManager	lnv_LicenseManager
n_cst_beo_item			lnva_item[]
n_cst_string			lnv_String
n_ds						lds_items

IF lnv_LicenseManager.of_HasAutoRatingLicensed ( )  THEN
	lds_Items = inv_Dispatch.of_GetItemCache ( )
	ll_rowcount = lds_items.rowcount()
	for ll_row = 1 to ll_rowcount
		ll_ID = lds_items.object.di_item_id [ ll_Row ]
		lnva_Item [ ll_row ] = CREATE n_cst_Beo_Item
		lnva_Item [ ll_row ].of_SetSource ( lds_items )
		lnva_Item [ ll_row ].of_SetSourceid ( ll_ID )

		lnva_Item [ ll_row ].of_SetOriginalValueMode ( TRUE )
		ll_shipId = lnva_Item [ ll_row ].of_GetShipment ( )
		lnva_Item [ ll_row ].of_SetOriginalValueMode ( FALSE )
		
		if ll_shipId = lnva_Item [ ll_row ].of_GetShipment ( ) then
			//no change
			CONTINUE
		else
			//rerate
			ls_codename = lnva_Item [ ll_row ].of_Getratecodename ( )
			IF upper(ls_codename) = 'CUSTOM' or isnull(ls_codename) or len(trim(ls_codename)) = 0 then
				//don't rerate
			ELSE
				IF lnva_Item [ ll_row ].of_autorate ( lnva_rateData) = -1 then
					//error
					li_return = -1
				ELSE
					setpointer(HourGlass!)
					lnva_Item [ ll_row ].of_applyautorate ( lnva_rateData)
					lnv_ArraySrv.of_Destroy ( lnva_RateData )
				END IF	
			END IF
			if li_return = 1 then
				//even if we didn't rerate we still want to record that it was an itemsplit
				ls_taglist = lnva_item[ll_row].of_GetTagList() 
				ls_changed = lnv_string.of_GetKeyValue(ls_taglist,'Changed',',')
				ls_newvalue = 'ItemSplit from shipment ' + string(ll_shipId)
				if len(trim(ls_changed)) > 0 then
					//replace old value
					lnv_String.of_SetKeyvalue(ls_taglist,'Changed,', ls_newvalue, ',')
				else
					//new value
					ls_taglist += ',Changed=' + ls_newvalue
				end if
				lnva_Item [ ll_row ].of_SetTaglist(ls_taglist)
			end if
		end if
		
	next

//if isvalid(lds_items) then
//	destroy lds_items
//end if
for ll_row = 1 to ll_rowcount
	if isvalid(lnva_Item [ ll_row ]) then
		destroy lnva_Item [ ll_row ]
	end if
next

END IF

end subroutine

public function integer wf_copycache ();// RDT 4-11-03 added Rowscopy and removed lds_NoFilter
int  		li_Return 
String 	ls_Filter 

uo_items.of_Redraw(FALSE, "LEFT")
uo_items.of_Redraw(FALSE, "RIGHT")

n_ds lds_Temp 
n_ds lds_NoFilter

lds_Temp = Create n_ds
lds_Temp.DataObject = 'd_items'


uo_Items.of_SetSource(lds_Temp)

//lds_NoFilter = ids_Items
//lds_NoFilter.SetFilter("")
//lds_NoFilter.Filter()
//lds_NoFilter.RowsCopy(1, lds_NoFilter.RowCount() +1, Primary!, uo_Items.of_GetSource(), 1, Primary!)  

// RDT 4-11-03
ids_Items.RowsCopy(1, ids_Items.RowCount() +1, Primary!, lds_Temp, 1, Primary!)  
ids_Items.RowsCopy(1, ids_Items.FilteredCount() +1, Filter! , lds_Temp, 1, Primary!)  

// copy from main to left
uo_Items.of_DuplicateMain("LEFT")

// copy from main to right
uo_Items.of_DuplicateMain("RIGHT")

Destroy lds_Temp

// Reset Filter on left
ls_Filter = "di_shipment_id = " + String( This.wf_GetCurrentShipmentId() ) 
uo_Items.of_SetFilter(ls_Filter ,"LEFT") 

dw_children.TriggerEvent("RowFocusChanged")  

uo_items.of_Redraw(TRUE, "LEFT")
uo_items.of_Redraw(TRUE, "RIGHT")

Return li_Return 

end function

public function integer wf_setdwblobs ();// RDT 112002 Added all code below

//RDT 6-25-03 Turn sharedataoff for PB8.0
inv_Item.Of_SetUseCache( FALSE )

integer	li_Return 
Blob 		lblob_temp
n_ds 		lds_temp

SetPointer ( HOURGLASS! )

uo_items.of_Redraw(FALSE, "Left")
uo_items.of_Redraw(FALSE, "Right")

ids_Items.ShareDataOFF() // RDT 6-25-03

//Create objects 
lds_Temp = Create n_ds
lds_Temp.DataObject = 'd_items'

// copy rows from cache to lds_Temp (cache has item details. I need an item list)
ids_Items.RowsCopy(1, ids_Items.RowCount() +1, Primary!, lds_Temp, 1, Primary!)  
ids_Items.RowsCopy(1, ids_Items.FilteredCount() +1, Filter!, lds_Temp, 1, Filter!) 

// Load into user object left datawindow
lds_Temp.GetFullState( lblob_temp )
uo_items.of_SetDWBlob ( lblob_temp, "LEFT" )

// Turn off Filter
lds_temp.SetFilter("")	
lds_temp.Filter()

// Load into user object right datawindow
lds_Temp.GetFullState( lblob_temp )
uo_items.of_SetDWBlob ( lblob_temp, "RIGHT" )

// set Title and filter on Left 
string ls_filter 
uo_Items.of_setLeftTitle ( "Items for "+ String ( wf_getCurrentShipmentID() ) )
ls_Filter = "di_shipment_id = " + String ( wf_getCurrentShipmentID() )
uo_Items.of_SetFilter(ls_Filter, "LEFT")
uo_Items.of_SetKeyColumn("di_item_id")

// set the row selection style
uo_Items.of_SetRowSelect( 2, "LEFT" )			 
uo_Items.of_SetRowSelect( 2, "RIGHT" )

dw_children.TriggerEvent("RowFocusChanged")  // this also sets the filter on the right uo_Item.window

uo_items.of_Redraw(TRUE, "Left")
uo_items.of_Redraw(TRUE, "Right")

// destroy  objects
Destroy lds_Temp  

Return li_Return 

end function

on w_shipmentsplits.create
int iCurrent
call super::create
this.dw_parent=create dw_parent
this.dw_children=create dw_children
this.st_1=create st_1
this.st_parent=create st_parent
this.st_children=create st_children
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.st_targetid=create st_targetid
this.cb_nonrouted=create cb_nonrouted
this.cb_duplicate=create cb_duplicate
this.uo_items=create uo_items
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parent
this.Control[iCurrent+2]=this.dw_children
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_parent
this.Control[iCurrent+5]=this.st_children
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.st_targetid
this.Control[iCurrent+11]=this.cb_nonrouted
this.Control[iCurrent+12]=this.cb_duplicate
this.Control[iCurrent+13]=this.uo_items
end on

on w_shipmentsplits.destroy
call super::destroy
destroy(this.dw_parent)
destroy(this.dw_children)
destroy(this.st_1)
destroy(this.st_parent)
destroy(this.st_children)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.st_targetid)
destroy(this.cb_nonrouted)
destroy(this.cb_duplicate)
destroy(this.uo_items)
end on

event open;call super::open;Long			ll_ID
Blob			lblb_State
String		ls_PArentFilter
String		ls_ChildrenFilter
DataStore 	lds_Cache
s_Parm		lstr_Parm

n_cst_privsmanager	lnv_manager
//////
//If we add the ability to have the window create and save its own dispatch object, we'll want to remove this.
//For now, I'm going to put this here to be totally sure we won't try to save.  BKW.
ib_DisableCloseQuery = TRUE
//////


// message object is intercepted in the constructor of dw_parent 

IF isValid ( inv_msg ) THEN
	IF inv_Msg.of_Get_Parm ( "SHIPMENTID", lstr_Parm ) <> 0 THEN
		ll_ID = Long (lstr_Parm.ia_Value)
		st_TargetID.text = String ( ll_ID )
	END IF
	
	IF inv_Msg.of_Get_Parm ( "DISPATCHOBJECT" , lstr_Parm ) <> 0 THEN
		inv_Dispatch = lstr_Parm.ia_Value
		ib_disableclosequery = TRUE
	END IF

	THIS.wf_SetCurrentShipmentID ( ll_ID )

	IF THIS.wf_RetrieveShipmentSplits ( {ll_id} ) = 1 THEN
		
		THIS.wf_RefreshDisplay ( )
		
	END IF
ELSE
	messageBox ( "Shipment Splits" , "An error occurred while attempting to open the shipment splits window.~r~nRequest Cancelled.", EXCLAMATION! ) 
	ib_DisableCloseQuery = TRUE
	close ( THIS ) 
END IF

//Added by dan 1-30-07
lnv_manager = gnv_app.of_getPrivsmanager( )

IF lnv_manager.of_getuserpermissionfromfn( "View Charges" ) <> 1 THEN
	Messagebox("Shipment Splits", "You do not have permission to view this window.")
	close(this)
END IF
//////////////
end event

event pfc_postopen;
// RDT 112002 Added all code below
inv_Item = Create n_cst_beo_Item
inv_Item.of_SetAllowFilterSet (TRUE)    // this allows updates to filtered rows
ids_Items = inv_Dispatch.of_GetItemCache ( )
inv_Item.of_SetSource ( ids_Items )

This.wf_SetDWBlobs()		// setup uo_items


end event

event close;call super::close;

If IsValid (inv_Item) Then Destroy( inv_Item )
end event

event closequery;call super::closequery;long li_return

if ib_closeandjump then
	//ok we went thru the funtion
else
	this.post wf_closeandjump(long(st_targetid.text))
	li_return =  1
end if

return li_return
end event

type cb_help from w_response`cb_help within w_shipmentsplits
integer x = 3374
integer y = 2096
end type

type dw_parent from u_dw_shipment within w_shipmentsplits
event ue_unassign ( )
event ue_assign ( )
event type long ue_getparentid ( )
integer x = 37
integer y = 204
integer width = 3397
integer height = 224
integer taborder = 0
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = false
boolean hsplitscroll = true
end type

event ue_unassign;//li_Return : 1 = Success, 0 = Nothing to unassign (no Parent), -1 = Error
//(Value is not actually returned, as event returns None)

Long	ll_CurrentShipID
Long	ll_NullID
Int	li_SetParentIDRtn
String	ls_ErrorMessage

DataStore	lds_ShipmentCache
n_cst_Beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_cst_Beo_Shipment

Int	li_Return = -1

ls_ErrorMessage = "An error occurred while attempting to unassign the parent."
SetNull (ll_NullID )

IF isValid ( inv_Dispatch ) THEN

	IF Parent.wf_CurrentShipmentHasParent ( ) THEN

		ll_CurrentShipID = Parent.wf_GetCurrentShipmentID ( )
		lds_ShipmentCache = inv_Dispatch.of_GetShipmentCache ( )
		
		lnv_Shipment.of_setSource ( lds_ShipmentCache )
		lnv_Shipment.of_SetSourceID  ( ll_CurrentShipID )
		lnv_Shipment.of_SetAllowFilterSet ( TRUE )
		
		li_SetParentIDRtn = 	lnv_Shipment.of_SetParentID ( ll_NullID )

		IF li_SetParentIDRtn = 1 THEN
			Parent.wf_RefreshDisplay ( )
			li_Return = 1
		ELSEIF li_SetParentIDRtn = -2 THEN // shipment can't be modified
			ls_ErrorMessage = "" // message provided by the shipment object			
		END IF

	ELSE 
		li_Return = 0  //Nothing to unassign.
		ls_ErrorMessage = ""  //No error message needed.
	END IF

END IF

IF li_Return <> 1 AND Len ( ls_ErrorMessage ) > 0 THEN
	MessageBox ("Unassign Parent" , ls_ErrorMessage )
END IF

DESTROY ( lnv_Shipment ) 
end event

event ue_assign;Long	ll_NewShipID
Long	ll_CurrentShipID
Int	li_SetParentIDRtn
Long	ll_ValidateIDRtn
String	ls_ErrorMessage , &
			ls_MessageHeader
String	ls_TempErrorMessage
Boolean	lb_AssignPArent = TRUE

DataStore	lds_ShipmentCache
n_cst_Beo_Shipment	lnv_Shipment

lnv_shipment = CREATE n_cst_beo_Shipment

Int	li_Return = -1

ls_MessageHeader = "Assign Parent"
ls_ErrorMessage = "An error occurred while attempting to assign a new parent ID."
ll_CurrentShipID = Parent.wf_GetCurrentShipmentID ( )

IF Parent.wf_CurrentShipmentHasParent ( ) THEN

	IF MessageBox ( ls_MessageHeader ,"Shipment " + String( ll_CurrentShipId ) + &
			" already has a parent assigned to it. Do you want to assign" + &
			" a different shipment as its parent?" , QUESTION! , YESNO! , 1 ) = 2 THEN
		lb_AssignParent = FALSE
		ls_ErrorMessage = ""
	END IF

END IF


IF isValid ( inv_Dispatch ) AND lb_AssignParent THEN
	
	lds_ShipmentCache = inv_Dispatch.of_GetShipmentCache ( )
	
	lnv_Shipment.of_setSource ( lds_ShipmentCache )
	lnv_Shipment.of_SetSourceID  ( ll_CurrentShipID )
	lnv_Shipment.of_SetAllowFilterSet ( TRUE )
	
	ll_NewShipID = Parent.wf_SelectShipmentID ( )
	
	IF ll_NewShipID = 0 THEN // user canceled out of the selection box
		li_Return = 0
		ls_ErrorMessage = ""

	ELSEIF Parent.wf_ValidateParentSelection ( ll_newShipID , ls_TempErrorMEssage ) = -1 THEN
		ls_ErrorMessage = ls_TempErrorMessage

	ELSEIF ll_NewShipID > 0 AND ll_CurrentShipID > 0 THEN

		IF Parent.wf_RetrieveShipment ( ll_NewShipID ) = 1 THEN

			li_SetParentIDRtn =  lnv_Shipment.of_SetParentID ( ll_NewShipID )

			IF li_SetParentIDRtn = 1 THEN

				Parent.wf_RefreshDisplay ( )
				li_Return = 1
				
			ELSEIF li_SetParentIDRtn = -2 THEN // Shipment has been billed, mod. not allowed
				 // error message provided by shipment object
				ls_ErrorMessage = ""
			END IF							
		
		END IF
		
	END IF
	
END IF


IF li_Return <> 1 AND Len ( ls_ErrorMessage ) > 0 THEN
	MessageBox ("Assign Parent" , ls_ErrorMessage  )
END IF

DESTROY ( lnv_Shipment ) 
end event

event ue_getparentid;//Returns:  Id of parent shipment, or Null if there is no parent or id can't be determined.

//Note:  We had to scrap the beo approach, because it wasn't reading all the values properly.
//I think something related to the dw being populated by SetFullState screws it up.

long	ll_SelectedRow
Long	ll_ParentID
//n_cst_Beo_Shipment	lnv_beo_Shipment

SetNull ( ll_ParentId )

IF THIS.RowCount ( ) = 1 THEN

	ll_SelectedRow = 1

//	lnv_Beo_shipment.of_SetSource (THIS)
//	lnv_Beo_shipment.of_SetSourceRow (ll_SelectedRow)
//	ll_ParentID = lnv_beo_shipment.of_GetId ( )

	ll_ParentId = This.Object.ds_id [ ll_SelectedRow ]
	
END IF

RETURN ll_ParentID
end event

event doubleclicked;//Note:  We had to scrap the beo approach, because it wasn't reading all the values properly.
//I think something related to the dw being populated by SetFullState screws it up.

Long	ll_ID
//n_cst_beo_Shipment	lnv_Shipment

IF row > 0 THEN

//	lnv_Shipment.of_SetSource ( THIS ) 
//	lnv_Shipment.of_SetSourceRow ( Row )
//	ll_ID = lnv_Shipment.of_GetId ( )

	ll_Id = This.Object.ds_id [ Row ]
	PARENT.wf_CloseAndJump ( ll_ID )
	
END IF
end event

event constructor;inv_msg = message.powerobjectParm
//The modify statement was copied here b/c the message object was not 
// comming through unless the event was overriding the ancestor
n_cst_ShipmentManager	lnv_ShipmentManager

This.Modify ( "ds_Status.Edit.CodeTable = Yes "+&
	"ds_Status.Values = '" + lnv_ShipmentManager.of_GetStatusCodeTable ( ) + "'" )


THIS.of_SetInsertable ( FALSE )
THIS.of_SetDeleteable ( FALSE )

end event

type dw_children from u_dw_shipment within w_shipmentsplits
event ue_assign ( long al_id )
event ue_unassign ( )
event type long ue_getselectedchildid ( )
event ue_assignselect ( )
event ue_assignnew ( )
integer x = 37
integer y = 608
integer width = 3397
integer height = 752
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_assign(long al_id);Long	ll_CurrentShipID
Int	li_SetParentIDRtn
String	ls_TempErrorMessage
String	ls_ErrorMessage
String	ls_ParentStatus

DataStore				lds_ShipmentCache // the real deal
n_cst_Beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_cst_beo_Shipment

Int	li_Return = -1

ls_ErrorMessage =  "An error occurred while attempting to assign a new child ID."

IF isValid ( inv_Dispatch ) THEN
		
	ll_CurrentShipID = PARENT.wf_GetCurrentShipmentID ( )
		
	IF Parent.wf_ValidateChildSelection ( al_Id , ls_TempErrorMessage ) = -1 THEN 
		ls_ErrorMessage = ls_TempErrorMessage
	ELSE
		
		IF PARENT.wf_RetrieveShipment ( al_Id ) = 1 THEN
			
			lds_ShipmentCache = inv_Dispatch.of_GetShipmentCache ( )
			
			lnv_Shipment.of_SetSource ( lds_ShipmentCache )
			lnv_Shipment.of_SetSourceId ( ll_CurrentShipId )
			ls_ParentStatus = lnv_Shipment.of_GetStatus()
			
			lnv_Shipment.of_SetSourceID ( al_Id )
			lnv_Shipment.of_SetAllowFilterSet ( TRUE )
			
			li_SetParentIDRtn = lnv_Shipment.of_SetParentID ( ll_CurrentShipID )
			
			IF li_SetParentIDRtn = 1 THEN
				
				IF ls_ParentStatus = gc_Dispatch.cs_ShipmentStatus_Template THEN
					lnv_Shipment.of_SetStatus(gc_Dispatch.cs_ShipmentStatus_Template)
				END IF
				
				PARENT.wf_RefreshDisplay ( )
				li_Return = 1
				
			ELSEIF li_SetParentIDRtn = -2 THEN  // shipment can't be modified
				ls_ErrorMessage = "" // message provided by the shipment object
			END IF
			
		END IF
	
	END IF
	
END IF


IF li_Return <> 1 AND Len ( ls_ErrorMessage ) > 0  THEN
	MessageBox ("Assign Child" ,ls_ErrorMessage )
END IF	

DESTROY ( lnv_Shipment )
end event

event ue_unassign;//Returns: 1 = Successfully unassigned, 0 = Nothing selected to unassign, -1 = Error

Long	ll_NullID
Int	li_SetParentIDRtn
Long	ll_SelectedChildID
String	ls_ErrorMessage

DataStore	lds_ShipmentCache
n_cst_Beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_cst_beo_Shipment

Int	li_Return = -1

SetNull (ll_NullID )
ls_ErrorMessage = "An error occurred while attempting to unassign the child."

IF isValid ( inv_Dispatch ) THEN	
	
	ll_SelectedChildID = This.Event ue_GetSelectedChildID ( )
	
	IF IsNull ( ll_SelectedChildID ) THEN // nothing selected 

		//No action necessary
		li_Return = 0

	ELSE
	
		lds_ShipmentCache = inv_Dispatch.of_GetShipmentCache ( )
		
		lnv_Shipment.of_setSource ( lds_ShipmentCache )
		lnv_Shipment.of_SetSourceID  ( ll_SelectedChildID )
		lnv_Shipment.of_SetAllowFilterSet ( TRUE )
		
		li_SetParentIDRtn = 	lnv_Shipment.of_SetParentID ( ll_NullID )

		IF li_SetParentIDRtn = 1 THEN
			Parent.wf_RefreshDisplay ( )
			li_Return = 1
			
		ELSEIF li_SetParentIDRtn = -2 THEN // shipment can't be modified
			ls_ErrorMessage = ""// message provided by the shipment object			
		END IF
			
	END IF
END IF

IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	MessageBox ("Unassign" , ls_ErrorMessage )
END IF

DESTROY ( lnv_shipment )
end event

event ue_getselectedchildid;//Returns:  Id of selected shipment, or Null if no row is selected or can't be determined.

//Note:  We had to scrap the beo approach, because it wasn't reading all the values properly.
//I think something related to the dw being populated by SetFullState screws it up.

long	ll_SelectedRow
Long	ll_ChildID
//n_cst_Beo_Shipment	lnv_Shipment

SetNull ( ll_ChildId )

ll_SelectedRow = THIS.getRow ( )

IF ll_SelectedRow > 0 THEN
//	lnv_Shipment.of_SetSource (THIS)
//	lnv_Shipment.of_SetSourceRow (ll_SelectedRow)
//	ll_ChildID = lnv_Shipment.of_GetID ( )
	ll_ChildId = This.Object.ds_id [ ll_SelectedRow ]
END IF

RETURN ll_ChildID
end event

event ue_assignselect;Long	ll_ID

ll_ID = PARENT.wf_SelectShipmentID ( )	
IF ll_ID > 0 THEN
	This.Event ue_Assign ( ll_ID )
END IF
end event

event ue_assignnew;Long	ll_ShipmentId
n_cst_Msg	lnv_Msg
s_Parm	lstr_Parm

n_cst_shipmentManager 	lnv_ShipManager


lstr_Parm.is_Label = "Style"
lstr_Parm.ia_Value = "NONROUTED!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "Display"
lstr_Parm.ia_Value = FALSE
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "FreightItemCount"
lstr_Parm.ia_Value = 0
lnv_Msg.of_Add_Parm ( lstr_Parm )
	
lstr_Parm.is_Label = "PARENTSHIPMENTID"
lstr_Parm.ia_Value = il_CurrentShipmentID
lnv_Msg.of_Add_Parm ( lstr_Parm )
	
ll_ShipmentId = lnv_ShipManager.of_NewShipment ( lnv_Msg )


IF ll_ShipmentId > 0 THEN
	This.Event ue_Assign ( ll_ShipmentId )
END IF

end event

event doubleclicked;//Note:  We had to scrap the beo approach, because it wasn't reading all the values properly.
//I think something related to the dw being populated by SetFullState screws it up.

Long	ll_ID
//n_cst_beo_Shipment	lnv_beo_Shipment

IF row > 0 THEN
//	lnv_beo_shipment.of_SetSource ( THIS ) 
//	lnv_beo_shipment.of_SetSourceRow ( Row )
//	ll_ID = lnv_beo_shipment.of_GetID ( )
	ll_Id = This.Object.ds_id [ Row ]
	PARENT.wf_CloseAndJump ( ll_ID )
END IF
end event

event constructor;call super::constructor;THIS.of_SetInsertable ( FALSE )
THIS.of_SetDeleteable ( FALSE )
THIS.of_SetAutoFilter ( TRUE )
THIS.of_SetAutoSort   ( TRUE )
end event

event rowfocuschanged;call super::rowfocuschanged;// RDT 112202 all this is new code for split
// Checks shipment edit state and user rights 
// If all is OK the filters on the right datawindow is set 

Long 		ll_id
String	ls_Filter
Integer	li_Return

n_cst_beo_Shipment lnv_Shipment
lnv_Shipment = Create n_cst_beo_Shipment 
lnv_Shipment.of_SetSource( inv_Dispatch.of_GetShipmentCache( ) )

uo_items.of_Redraw(FALSE, "LEFT")
uo_items.of_Redraw(FALSE, "RIGHT")

// check Current Shipment edit state
lnv_Shipment.of_SetSourceID( parent.wf_GetCurrentShipmentID( ) )
If lnv_Shipment.of_AllowEditBill ( ) = FALSE Then 
	li_Return = -1
End If

// check Childs edit state
If li_Return = 1 Then 
	lnv_Shipment.of_SetSourceID( dw_children.Event ue_GetSelectedChildID()   )
	If lnv_Shipment.of_AllowEditBill ( ) = FALSE Then 
		li_Return = -1
	End If
End If

// get user privilages 
n_cst_Privileges lnv_Privileges

If lnv_Privileges.of_HasSysAdminRights ( ) = TRUE then 
	li_Return = 1	// override of_AllowEditBill ( )
End If

// get the current shipment id and set the title to it. 
If This.RowCount() = 0 Then 
	// if no row then disable move function
	ls_Filter = "1=2" 
	uo_items.of_LeftRightEnable ( FALSE )		
	uo_items.of_RightLeftEnable ( FALSE )		
	uo_items.of_setRighTtitle (" ")
Else
	// set filter on right	
	ll_id = This.GetItemnumber(This.GetRow(), "ds_id")
	uo_items.of_setRighTtitle ("Items for "+ String(ll_id) )
	ls_Filter = "di_shipment_id = " + String ( ll_id )

	uo_items.of_LeftRightEnable ( TRUE )		
	uo_items.of_RightLeftEnable ( TRUE )		

End If

uo_items.of_setFilter( ls_Filter, "RIGHT" )

If li_Return = -1 Then 	
	uo_items.of_LeftRightEnable ( FALSE )		
	uo_items.of_RightLeftEnable ( FALSE )		
End If	

destroy lnv_Shipment

uo_items.of_Redraw(TRUE , "LEFT")
uo_items.of_Redraw(TRUE , "RIGHT")

end event

event clicked;call super::clicked;this.Triggerevent("rowfocuschanged")
end event

type st_1 from u_st within w_shipmentsplits
integer x = 37
integer y = 28
integer width = 443
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Shipment No. :"
end type

type st_parent from u_st within w_shipmentsplits
integer x = 37
integer y = 136
integer width = 251
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
string text = "Parent"
end type

type st_children from u_st within w_shipmentsplits
integer x = 37
integer y = 540
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 128
boolean enabled = true
string text = "&Children"
end type

event clicked;dw_Children.SetFocus ( )
end event

type cb_1 from u_cb within w_shipmentsplits
integer x = 3072
integer y = 96
integer taborder = 40
boolean bringtotop = true
string text = "&Unassign"
end type

event clicked;dw_Parent.Event ue_unassign ( )

end event

type cb_2 from u_cb within w_shipmentsplits
integer x = 2702
integer y = 96
integer taborder = 20
boolean bringtotop = true
string text = "&Assign"
end type

event clicked;dw_Parent.Event ue_Assign ( )
end event

type cb_3 from u_cb within w_shipmentsplits
integer x = 2702
integer y = 508
integer taborder = 70
boolean bringtotop = true
string text = "A&ssign"
end type

event clicked;dw_Children.Event ue_AssignSelect ( )

//parent.wf_SetDWBlobs()		// RDT 12-07-02
parent.wf_CopyCache()	// RDT 12-07-02
end event

type cb_4 from u_cb within w_shipmentsplits
integer x = 3072
integer y = 508
integer taborder = 80
boolean bringtotop = true
string text = "U&nassign"
end type

event clicked;dw_children.Event ue_unassign ( )
		
//parent.wf_SetDWBlobs()		// RDT 12-07-02
parent.wf_CopyCache()	// RDT 12-07-02
end event

type st_targetid from u_st within w_shipmentsplits
integer x = 494
integer y = 28
integer width = 311
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 29425663
string text = ""
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type cb_nonrouted from u_cb within w_shipmentsplits
integer x = 2176
integer y = 508
integer width = 439
integer taborder = 60
boolean bringtotop = true
string text = "Ne&w"
end type

event clicked;dw_Children.Event ue_AssignNew ( )

parent.wf_CopyCache()		// RDT 12-07-02
end event

type cb_duplicate from u_cb within w_shipmentsplits
integer x = 1714
integer y = 508
integer width = 439
integer taborder = 50
boolean bringtotop = true
string text = "&Duplicate"
end type

event clicked;// RDT 7-17-03 Added parent ID to message object and passed to new shipment.
Int			li_Type
String		ls_Text
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
//Long			ll_ParentID


n_cst_shipmentManager 	lnv_ShipManager
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_cst_beo_Shipment

IF il_CurrentShipmentID > 0 THEN
	
	lnv_Shipment.of_SetSource ( inv_Dispatch.of_GetShipmentCache ( ) )
	lnv_Shipment.of_SetSourceID ( il_CurrentShipmentID )
	
	
	ls_Text = lnv_Shipment.of_GetRef1Text ( ) 
	li_Type = lnv_Shipment.of_GetRef1Type ( ) 
	
	IF Not isNull ( ls_Text ) AND ( li_Type = 20 OR li_Type = 26 OR li_Type = 28 ) THEN
		
		lstr_Parm.is_Label = "EQREF"
		lstr_Parm.ia_Value =  ls_Text
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	
		
		IF li_Type = 20 THEN
			lstr_Parm.ia_Value = 'C'
		ELSEIF li_Type = 26  THEN
			lstr_Parm.ia_Value = 'B'
		ELSE 
			lstr_Parm.ia_Value = 'H'
		END IF
		lstr_Parm.is_Label = "TYPE"
		lnv_Msg.of_Add_Parm  ( lstr_Parm ) 
		
		
	END IF
	
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = il_CurrentShipmentID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ALLOWVIEWING"
	lstr_Parm.ia_Value = FALSE
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
	lstr_Parm.is_Label = "SEAL"
	lstr_Parm.ia_Value = TRUE
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "DISPATCH"
	lstr_Parm.ia_Value = inv_Dispatch
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	

	lstr_Parm.is_Label = "SPLITOPTIONS"
	lstr_Parm.ia_Value = TRUE
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "PARENTSHIPMENTID"
	lstr_Parm.ia_Value = il_CurrentShipmentID
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	
	openWithParm ( w_duplicatewithEquipment , lnv_Msg )
	lnv_Msg = Message.PowerobjectParm 
	
	long	lla_NewIDs[]
	Int	i
	IF isValid ( lnv_Msg ) THEN
		IF lnv_Msg.of_Get_Parm ( "NEWIDS" , lstr_Parm ) <> 0 THEN
			lla_NewIds = lstr_Parm.ia_Value 
		END IF
		
		FOR i = 1 TO UpperBound ( lla_NewIds ) 
			dw_children.Event ue_Assign ( lla_NewIds[i] )
		NEXT
	END IF	

END IF

DESTROY ( lnv_Shipment )

parent.wf_CopyCache()	// RDT 12-07-02
end event

type uo_items from u_2dw_rowselection within w_shipmentsplits
integer x = 96
integer y = 1420
integer width = 3273
integer height = 708
integer taborder = 30
boolean bringtotop = true
end type

on uo_items.destroy
call u_2dw_rowselection::destroy
end on

event ue_leftright;/***************************************************************************************
DESCRIPTION	: Items Moved from left to right
REVISION		: RDT 112102
// RDT 4-10-03  Added of_calculatepayable ()

***************************************************************************************/

SetPointer(HourGlass!)

Long		ll_Count, & 
			ll_MaxCount, &
			ll_NewShipmentID, &
			ll_Row

Integer	li_Return = 1

ll_MaxCount = Upperbound( ala_id[] )

// Set to Recalc shipment totals 
n_cst_beo_Shipment lnv_Shipment
lnv_Shipment = Create n_cst_beo_Shipment 
lnv_Shipment.of_SetSource( inv_Dispatch.of_GetShipmentCache() )
lnv_Shipment.of_SetItemSource( inv_Dispatch.of_GetItemCache() )
lnv_Shipment.of_SetEventSource( inv_Dispatch.of_GetEventCache() )
lnv_Shipment.of_SetContext ( inv_Dispatch ) // <<*>> 6/18/03

lnv_Shipment.of_SetAllowFilterSet( TRUE )

ll_NewShipmentID  = dw_children.Event ue_GetSelectedChildID()  

For ll_Count = 1 to ll_MaxCount
	inv_Item.of_SetSourceId ( ala_id[ ll_Count ])
	inv_Item.of_SetShipment ( ll_NewShipmentID  )

Next

// Recalc New Shipment 
lnv_Shipment.of_SetSourceId( ll_NewShipmentID  )
lnv_Shipment.OF_Calculate( )
lnv_Shipment.of_calculatepayable ( ) /* RDT 4-10-03 */
lnv_Shipment.of_RecalcSurcharges ( ) // <<*>> 6/18/03 

// Recalc Old (current) Shipment 
lnv_Shipment.of_SetSourceId( parent.wf_GetCurrentShipmentID( ) )
lnv_Shipment.OF_Calculate( )
lnv_Shipment.of_calculatepayable ( ) /* RDT 4-10-03 */ 
lnv_Shipment.of_RecalcSurcharges ( ) // <<*>> 6/18/03

Parent.wf_CopyCache()

ll_Row = dw_children.GetRow()
dw_children.SetRedraw(FALSE)
Parent.wf_RefreshDisplay ( )
dw_children.ScrollToRow(ll_Row)
dw_children.SetRedraw(TRUE)

If ll_Row = 1 Then dw_children.TriggerEvent("RowFocusChanged")  

Destroy lnv_Shipment 

return li_return
end event

event ue_rightleft;/***************************************************************************************
DESCRIPTION	: Items Moved from Right to Left
                ala_id = item id.
REVISION		: RDT 112102
// RDT 4-10-03  Added of_calculatepayable ()

***************************************************************************************/

SetPointer(HourGlass!)

Long	ll_Count, & 
		ll_MaxCount, &
		ll_NewShipmentID, &
		ll_Row
		
ll_MaxCount = Upperbound( ala_id[] )

// Set to Recalc shipment totals 
n_cst_beo_Shipment lnv_Shipment
lnv_Shipment = Create n_cst_beo_Shipment 
lnv_Shipment.of_SetSource( inv_Dispatch.of_GetShipmentCache() )
lnv_Shipment.of_SetItemSource( inv_Dispatch.of_GetItemCache() )
lnv_Shipment.of_SetEventSource( inv_Dispatch.of_GetEventCache() )
lnv_Shipment.of_SetContext ( inv_Dispatch ) // <<*>> 6/18/03

lnv_Shipment.of_SetAllowFilterSet( TRUE )

ll_NewShipmentID = Parent.wf_GetCurrentShipmentID() 

For ll_Count = 1 to ll_MaxCount
	inv_Item.of_SetSourceId ( ala_id[ ll_Count ] )
	inv_Item.of_SetShipment ( ll_NewShipmentID  )
	
Next

// Recalc New Shipment 
lnv_Shipment.of_SetSourceId( ll_NewShipmentID  )
lnv_Shipment.OF_Calculate( )
lnv_Shipment.of_calculatepayable ( ) /* RDT 4-10-03 */  
lnv_Shipment.of_RecalcSurcharges ( ) // <<*>> 6/18/03   

// Recalc Old Shipment 
lnv_Shipment.of_SetSourceId( dw_children.Event ue_GetSelectedChildID() )
lnv_Shipment.OF_Calculate( )
lnv_Shipment.of_calculatepayable ( ) /* RDT 4-10-03 */
lnv_Shipment.of_RecalcSurcharges ( ) // <<*>> 6/18/03


Parent.wf_CopyCache()

ll_Row = dw_children.GetRow()
dw_children.SetRedraw(FALSE)
Parent.wf_RefreshDisplay ( )
dw_children.ScrollToRow(ll_Row)
dw_children.SetRedraw(TRUE)

If ll_Row = 1 Then dw_children.TriggerEvent("RowFocusChanged")  

Destroy lnv_Shipment 

return 1
end event

event constructor;call super::constructor;uo_items.of_LeftRightEnable ( FALSE)
uo_items.of_RightLeftEnable ( FALSE)
end event

