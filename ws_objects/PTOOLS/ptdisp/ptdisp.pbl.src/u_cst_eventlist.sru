$PBExportHeader$u_cst_eventlist.sru
forward
global type u_cst_eventlist from u_base
end type
type dw_events from u_dw_eventlist within u_cst_eventlist
end type
type uo_ip2 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip3 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip4 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip1 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip5 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip7 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip8 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip6 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip9 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip10 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip11 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip12 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip13 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip14 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip15 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip16 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip17 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip18 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip19 from u_cst_insertionpoint within u_cst_eventlist
end type
type uo_ip20 from u_cst_insertionpoint within u_cst_eventlist
end type
type st_itin_ind from statictext within u_cst_eventlist
end type
type st_move from statictext within u_cst_eventlist
end type
type cb_1 from commandbutton within u_cst_eventlist
end type
type cb_2 from commandbutton within u_cst_eventlist
end type
end forward

global type u_cst_eventlist from u_base
integer width = 3346
integer height = 536
long backcolor = 12632256
event type n_cst_beo_shipment ue_getshipment ( )
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event type window ue_getparentwindow ( )
event ue_mousemove pbm_mousemove
event ue_eventadded ( long al_row )
event ue_postrefresh ( )
event ue_losefocus pbm_bnkillfocus
event type integer ue_showdetail ( long al_row )
event ue_eventdeleted ( )
event type integer ue_moveevent ( long al_newposition )
event ue_sitechanged ( long al_row,  long al_old,  long al_new )
event type integer ue_chassispuchanged ( long al_site )
event type integer ue_chassisrtnchanged ( long al_site )
event type integer ue_trailerpuchanged ( long al_site )
event type integer ue_trailerrtnchanged ( long al_site )
event type integer ue_rowchanged ( long al_newrow )
event ue_origindestchanged ( )
event type integer ue_validateevents ( )
event type integer ue_yardmoveadded ( long al_eventid )
event type long ue_getxpos ( )
event type long ue_getypos ( )
event type integer ue_jumptoitinerary ( long al_row )
event ue_refreshshipment ( )
event ue_yardstorageadded ( )
dw_events dw_events
uo_ip2 uo_ip2
uo_ip3 uo_ip3
uo_ip4 uo_ip4
uo_ip1 uo_ip1
uo_ip5 uo_ip5
uo_ip7 uo_ip7
uo_ip8 uo_ip8
uo_ip6 uo_ip6
uo_ip9 uo_ip9
uo_ip10 uo_ip10
uo_ip11 uo_ip11
uo_ip12 uo_ip12
uo_ip13 uo_ip13
uo_ip14 uo_ip14
uo_ip15 uo_ip15
uo_ip16 uo_ip16
uo_ip17 uo_ip17
uo_ip18 uo_ip18
uo_ip19 uo_ip19
uo_ip20 uo_ip20
st_itin_ind st_itin_ind
st_move st_move
cb_1 cb_1
cb_2 cb_2
end type
global u_cst_eventlist u_cst_eventlist

type variables
StaticText	ist_Test
w_EventDetail	iw_Details


Private:
u_cst_insertionPoint iuo_ip[ ]
Boolean	ib_Move
end variables

forward prototypes
private function integer of_showip ()
private function integer of_getvisiblecount ()
private function integer of_constructswitchingoptions (long al_Row, ref n_cst_Msg anv_Msg)
public function integer of_showdetails (long al_row)
private function integer of_resetpointers (u_cst_insertionPoint auo_Exclude)
private function integer of_hideip ()
public function integer of_resetpointers ()
public function integer of_sharedata (datastore ads_source)
public subroutine of_resetrange ()
public function integer of_insertevent (long al_insertrow)
protected function Long of_getfirstrowonpage ()
public function integer of_deleteevents ()
public function long of_geteventcount ()
public function Boolean of_ismoveenabled ()
public function integer of_setmoveenabled (boolean ab_Value)
public function boolean of_hasfrontchassissplit ()
public function boolean of_hasbackchassissplit ()
public function integer of_setfrontchassissplitsite (long al_id)
public function integer of_setbackchassissplitsite (long al_id)
public function long of_getchassispulocation ()
public function long of_getchassisrtnlocation ()
public function long of_find (String as_FindString)
public function integer of_scrolltotofirstselectedevent ()
public function datawindow of_geteventsource ()
public function long of_getrow ()
public subroutine of_setredraw (boolean ab_Value)
public function integer of_getselectedeventids (ref long ala_ids[], boolean ab_UseCurrent)
public function long of_getsites (ref long ala_CoIds[])
public function integer of_setcontext (string as_context, readonly n_cst_beo_shipment anv_shipment)
public function integer of_setfocus (long al_Row, string as_Column)
public function integer of_sharedataoff ()
public function n_cst_beo_Event of_geteventforrow (long al_Row)
end prototypes

event ue_mousemove;u_cst_InsertionPoint	lnv_Dummy

THIS.of_ResetPointers ( lnv_Dummy )
end event

event ue_postrefresh;THIS.POST of_ShowIp ( )
THIS.Post of_ResetRange ( )
end event

event ue_showdetail;n_cst_msg	lnv_msg
S_Parm		lstr_parm

IF NOT isValid ( iw_Details ) THEN
	lstr_Parm.is_Label = "ROW"
	lstr_Parm.ia_Value = al_Row
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "SOURCE"
	lstr_Parm.ia_Value = dw_events
	lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	OpenWithParm ( iw_Details , lnv_Msg )

ELSE
	iw_Details.wf_showEvent ( dw_events.GetItemNumber( al_row , "de_id" ) )
END IF


RETURN 1

end event

event ue_eventdeleted();THIS.of_ResetRange()
dw_events.selectrow(0, FALSE)
THIS.Event ue_PostRefresh ( ) 
end event

event type integer ue_moveevent(long al_newposition);Long	ll_SelectedRow
Long	ll_NewPosition
Long	ll_EventCount
Int	li_NewShipSeq
Int	li_i
Boolean	lb_Continue 
Int	li_Return = 0

lb_Continue = TRUE

n_cst_beo_SHipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( ) 

IF IsValid ( lnv_Shipment ) THEN
	lb_Continue = lnv_Shipment.of_MoveEvent ( ) = 1
ELSE
	lb_Continue = FALSE
END IF


ll_SelectedRow = dw_events.GetRow ( )
dw_events.SelectRow ( 0 , FALSE )
dw_events.SelectRow ( ll_SelectedRow , TRUE ) 

ll_NewPosition = al_NewPosition
ll_EventCount = THIS.of_GetEventCount ( ) 

IF ll_SelectedRow = ll_NewPosition or ll_SelectedRow  + 1 = ll_NewPosition THEN // no move
	lb_Continue = FALSE	
END IF

IF lb_Continue THEN
	IF ll_NewPosition = 1 then 
		li_NewShipSeq = 2 
	ELSE
		li_NewShipSeq = 1
	END IF
	
	for li_i = 1 to ll_EventCount
		if li_i = ll_SelectedRow then
			if ll_Newposition > ll_EventCount then
				dw_events.object.de_ship_seq[ li_i ] = ll_EventCount
			else
				dw_events.object.de_ship_seq[ li_i ] = ll_NewPosition
			end if
		else
			dw_events.object.de_ship_seq[ li_i ] = li_NewShipSeq
			li_NewShipSeq ++
			if li_NewShipSeq = ll_NewPosition then
				li_NewShipSeq ++
			END IF
		end if
	next
	li_Return = 1
END IF

dw_events.SelectRow ( 0 , FALSE )
THIS.of_SetMoveEnabled ( FALSE )

RETURN li_Return
end event

event ue_sitechanged;Long ll_RowCount
n_cst_Events	lnv_Events

ll_RowCount = dw_events.RowCount ( ) 

CHOOSE CASE al_row
		
	CASE 1 
		IF lnv_Events.of_hasFrontChassisSplit ( dw_events ) THEN
			THIS.Event ue_ChassisPuChanged ( al_new )
		ELSE
			THIS.Event ue_TrailerPuChanged ( al_new )
		END IF
		
		
	CASE 2
		IF lnv_Events.of_hasFrontChassisSplit ( dw_events ) THEN
			THIS.Event ue_TrailerPuChanged ( al_new )
		END IF
		
	CASE ll_RowCount - 1
		IF lnv_Events.of_hasBackChassisSplit ( dw_events ) THEN
			THIS.Event ue_TrailerRtnChanged ( al_new )
		END IF
		
	CASE ll_RowCount 
		IF lnv_Events.of_hasBackChassisSplit ( dw_events ) THEN
			THIS.Event ue_ChassisRtnChanged ( al_new )
		ELSE
			THIS.Event ue_TrailerRtnChanged ( al_new )
		END IF
		
		
END CHOOSE

THIS.Event ue_PostRefresh ( )


end event

event ue_validateevents;RETURN dw_events.Event ue_ValidateEvents ( )
end event

event ue_getxpos;RETURN THIS.X
end event

event ue_getypos;RETURN THIS.y
end event

private function integer of_showip ();Long	ll_RowCount
Long	ll_Return
Long	ll_FirstRowOnPage
Int	li_IPCount
Int	li_i
Int	li_VisibleCount
u_cst_InsertionPoint luo_IP

li_IPCount = UpperBound ( iuo_ip[] )
li_VisibleCount = THIS.of_GetVisibleCount ( ) + 1
ll_FirstRowOnPage = THIS.of_GetFirstRowOnPage (  )
IF ll_FirstRowOnPage = 0 THEN
	ll_FirstRowOnPage = 1
END IF

FOR li_i = 1 TO li_IPCount
	iuo_ip[ li_i ].of_SetVisible ( li_i <= li_VisibleCount )
	iuo_IP[ li_i ].of_AssignNumber ( ll_FirstRowOnPage ) 
	ll_FirstRowOnPage ++
NEXT

RETURN ll_Return



end function

private function integer of_getvisiblecount ();Long	ll_FirstRow
Long	ll_LastRow
Int	li_Return


ll_FirstRow = THIS.of_getFirstRowOnPage ( )
ll_LastRow = Long ( dw_events.Object.DataWindow.LastRowOnPage )

IF dw_events.RowCount ( ) <> 0 THEN
	
	IF ll_LastRow <> ll_FirstRow THEN
		li_Return = ll_LastRow - ll_FirstRow 
	END IF
	
	li_Return ++

END IF

RETURN li_Return


end function

private function integer of_constructswitchingoptions (long al_Row, ref n_cst_Msg anv_Msg);String	ls_PreviousType
String	ls_NextType
String	lsa_ParmLabel[]
Any		laa_ParmValue[]
Boolean	lb_HasShipment
Boolean	lb_Continue = TRUE
Long		ll_SelectedRow
Long		lla_SelectedRows[]
Long		ll_SelectedCount
Long		ll_Row 
Long		ll_RowCount
Long		ll_EventID
Long		ll_Shipment1
Long		ll_Shipment2

Int		li_Rtn

s_Parm	lstr_Parm


n_cst_beo_Event	lnv_Event1
n_cst_beo_Event	lnv_Event2

lnv_Event1 = CREATE n_cst_beo_Event
lnv_Event2 = CREATE n_cst_beo_Event

ll_RowCount = dw_events.RowCount ( )
ll_Row = al_Row

DO 
	
	ll_SelectedRow = dw_events.GetSelectedRow ( ll_SelectedRow )
	IF ll_SelectedRow > 0 THEN
		lla_SelectedRows [ UpperBound ( lla_SelectedRows ) + 1 ] = ll_SelectedRow
	END IF
	
LOOP WHILE ll_SelectedRow > 0

ll_SelectedCount = UpperBound ( lla_SelectedRows )
IF ll_SelectedCount = 0 THEN  // set the row passed in as a selected row
	ll_SelectedCount = 1
	lla_SelectedRows [ 1 ] = ll_Row
END IF

IF ll_SelectedCount = 2 THEN
	
	CHOOSE CASE ll_Row
			
		CASE lla_SelectedRows [ 1 ]
			lnv_Event1.of_SetSource ( dw_events )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [1] )
			ls_NextType = lnv_Event1.of_GetType ( )
			
		CASE lla_SelectedRows [ 2 ]
			lnv_Event1.of_SetSource ( dw_events )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [2] )
			ls_PreviousType = lnv_Event1.of_GetType ( )
	END CHOOSE

END IF

IF ll_Row > 0 AND ll_Row <= ll_RowCount THEN
	lnv_Event1.of_SetSource ( dw_events )
	lnv_Event1.of_SetSourceRow ( ll_Row )
	
	ll_EventID = lnv_Event1.of_GetID ( )
	lb_HasShipment = lnv_Event1.of_GetShipment ( ) > 0 
	
	
	CHOOSE CASE ll_SelectedCount
			
		CASE 1
			IF NOT lnv_Event1.of_IsConfirmed ( ) THEN
				CHOOSE CASE lnv_Event1.of_GetType( )
				
					CASE gc_Dispatch.cs_EventType_Drop
						
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
				
							IF lb_HasShipment THEN
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
							END IF
					
					CASE gc_Dispatch.cs_EventType_Dismount
						
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
							
							IF lb_HasShipment THEN
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
							END IF
					
					CASE gc_Dispatch.cs_EventType_Hook
				
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
							
							IF lb_HasShipment THEN
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
							END IF
				
					CASE gc_Dispatch.cs_EventType_Mount
						
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
				
							IF lb_HasShipment THEN
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
							END IF
							
						
					CASE gc_Dispatch.cs_EventType_Pickup
						IF lb_HasShipment THEN
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook and Drop"
							
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
							
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount and Dismount"
													
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
							
						END IF
						
						
					CASE gc_Dispatch.cs_EventType_Deliver
						IF lb_HasShipment THEN
							
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
							
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop and Hook"
							
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
							
							lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
							laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount and Mount"
						END IF
							
						
						
				END CHOOSE
			END IF
					
			
			
		CASE 2
			IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent
				lnv_Event1.of_SetSource ( dw_events )
				lnv_Event1.of_SetSourceRow ( lla_SelectedRows [ 1 ] )
				
				lnv_Event2.of_SetSource ( dw_events )
				lnv_Event2.of_SetSourceRow ( lla_SelectedRows [ 2 ] )
				
				ll_Shipment1 = lnv_Event1.of_GetShipment ( )
				ll_Shipment2 = lnv_Event2.of_GetShipment ( )
				IF lnv_Event1.of_IsDeliverGroup ( ) AND lnv_Event2.of_IsPickupGroup ( ) THEN
					IF Not ( lnv_Event1.of_IsConfirmed ( ) OR lnv_Event2.of_IsConfirmed ( ) ) THEN
						
						CHOOSE CASE lnv_Event1.of_GetType( )
						
							CASE gc_Dispatch.cs_EventType_Drop , gc_Dispatch.cs_EventType_Dismount , gc_Dispatch.cs_EventType_Hook , &
									gc_Dispatch.cs_EventType_Mount 
									
									// determine the other type to put in the message
						
									IF ll_Shipment1 > 0 OR ll_Shipment2 > 0 THEN
										IF ll_Shipment1 > 0 AND  ll_Shipment2 > 0 THEN
											IF ll_Shipment1 <> ll_Shipment2 THEN // bail
												lb_Continue = FALSE
											END IF
										END IF
										
										IF lb_Continue THEN
											
											lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
											laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Deliver"
											
											lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
											laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Pickup"
										END IF
									END IF
								
						
						END CHOOSE
					END IF
				END IF
			END IF
		END CHOOSE
	
END IF

lstr_Parm.is_label = "LABELS"
lstr_Parm.ia_Value = lsa_ParmLabel
anv_msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "VALUES"
lstr_Parm.ia_Value = laa_ParmValue
anv_msg.of_Add_Parm ( lstr_Parm )

DESTROY ( lnv_Event1 )
DESTROY ( lnv_Event2 )


Return li_Rtn


end function

public function integer of_showdetails (long al_row);n_cst_msg	lnv_msg
S_Parm		lstr_parm

IF NOT isValid ( iw_Details ) THEN
	lstr_Parm.is_Label = "ROW"
	lstr_Parm.ia_Value = al_Row
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "SOURCE"
	lstr_Parm.ia_Value = dw_events
	lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	OpenWithParm ( iw_Details , lnv_Msg )

ELSE
	iw_Details.wf_showEvent ( dw_events.GetItemNumber( al_row , "de_id" ) )
END IF


RETURN 1

end function

private function integer of_resetpointers (u_cst_insertionPoint auo_Exclude);Int	li_Count
Int	li_i

li_Count = UpperBound ( iuo_ip[] )

FOR li_i = 1 TO li_Count
	IF iuo_ip[ li_i ] <> auo_Exclude THEN
		iuo_ip[ li_i ].of_Reset ( )
	END IF
NEXT 

RETURN 1


end function

private function integer of_hideip ();Long	ll_RowCount
Long	ll_Return
Int	li_IPCount
Int	li_i
Int	li_VisibleCount
u_cst_InsertionPoint luo_IP

li_IPCount = UpperBound ( iuo_ip[] )

FOR li_i = 1 TO li_IPCount
	iuo_ip[ li_i ].of_Reset ( )
	iuo_ip[ li_i ].of_SetVisible ( FALSE )
NEXT

RETURN 1
end function

public function integer of_resetpointers ();u_cst_InsertionPoint	luo_Dummy

THIS.of_ResetPointers ( luo_Dummy )

RETURN 1
end function

public function integer of_sharedata (datastore ads_source);Int	li_Return
li_Return = ads_Source.ShareData ( dw_events )
THIS.of_ResetRange ( )
THIS.of_ShowIP ( )
dw_events.of_makeContextModifications ( ) 
RETURN li_Return

end function

public subroutine of_resetrange ();Long	ll_FirstRow
Long	ll_LastRow
Long	ll_EventCount

ll_EventCount = dw_events.RowCount ( ) 

ll_FirstRow = integer(dw_events.describe("datawindow.firstrowonpage"))
ll_LastRow = integer(dw_events.describe("datawindow.lastrowonpage"))

st_itin_ind.text = "Itin&erary: " + string( ll_FirstRow ) + " to " + string( ll_LastRow ) + " of " + string( ll_EventCount )
THIS.of_ShowIP ( )
end subroutine

public function integer of_insertevent (long al_insertrow);Int	li_Return = -1
long	lla_NewIDs []
Long	ll_InsertRow
String	lsa_Types[]

n_cst_Beo_Shipment lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event1
n_cst_beo_Event		lnv_Event2

lnv_Event1 = THIS.of_GetEventforrow( al_insertrow - 1)
lnv_Event2 = THIS.of_GetEventforrow( al_insertrow  )

lnv_Dispatch= THIS.Event ue_GetDispatchManager( )
lnv_Shipment = THIS.Event ue_GetShipment ( )


IF isValid ( lnv_Shipment ) AND IsValid ( lnv_Dispatch ) THEN
	IF lnv_Shipment.of_AddEvent ( ) = 1 THEN
		
		li_return = 1
		
		IF IsValid ( lnv_Event1 ) AND isValid ( lnv_Event2 )  THEN
			IF lnv_Event1.of_Isbobtailevent( ) AND lnv_Event2.of_Isbobtailevent( )THEN
				MessageBox ( "Add Event" , "You are not allowed to split bobtail events." )
				li_Return = -1
			END IF
		END IF
		
		IF li_Return = 1 THEN
		
			ll_InsertRow = al_InsertRow
			lsa_types [ 1 ]  = ""	
			lnv_Shipment.of_AddEvents ( lsa_Types , ll_InsertRow , lnv_Dispatch , lla_NewIds )
			
			THIS.Event ue_EventAdded ( ll_InsertRow )
			dw_events.Post SetRow ( ll_InsertRow )
			dw_Events.ScrollToRow ( ll_InsertRow )
			dw_events.Post SetColumn ( "de_event_type" )
			dw_events.Post SetFocus ( )
			dw_events.Post Event ue_ShowEventSelections ( ll_InsertRow )
			li_Return = 1
		END IF
	END IF
END IF
	
RETURN li_Return
end function

protected function Long of_getfirstrowonpage ();RETURN Long ( dw_events.Object.DataWindow.FirstRowOnPage ) 
end function

public function integer of_deleteevents ();dw_events.Event ue_DeleteEvent ()


RETURN 1
end function

public function long of_geteventcount ();RETURN dw_events.RowCount ( ) 
end function

public function Boolean of_ismoveenabled ();RETURN ib_Move
end function

public function integer of_setmoveenabled (boolean ab_Value);st_Move.Visible = ab_Value
ib_Move = ab_Value
RETURN 1
end function

public function boolean of_hasfrontchassissplit ();Boolean	lb_Return
n_cst_events	lnv_Events

//lb_Return = lnv_Events.of_HasFrontChassisSplit ( dw_Events )

RETURN lb_Return


end function

public function boolean of_hasbackchassissplit ();Boolean	lb_Return
n_cst_events	lnv_Events

//lb_Return = lnv_Events.of_HasBackChassisSplit ( dw_Events )

RETURN lb_Return


end function

public function integer of_setfrontchassissplitsite (long al_id);Int	li_Return = -1
n_cst_Events	lnv_Events

//IF lnv_Events.of_SetFrontChassisSplitSite ( al_ID , dw_events ) = 1 THEN
//	li_Return = 1
//END IF

RETURN li_Return
end function

public function integer of_setbackchassissplitsite (long al_id);Int	li_Return = -1
n_cst_Events	lnv_Events

//IF lnv_Events.of_SetBackChassisSplitSite ( al_ID , dw_events ) = 1 THEN
//	li_Return = 1
//END IF

RETURN li_Return
end function

public function long of_getchassispulocation ();Long				ll_Return
n_cst_Events	lnv_Events

//ll_Return = lnv_Events.of_GetChassisPuLocation ( dw_Events )

RETURN ll_Return 

end function

public function long of_getchassisrtnlocation ();Long				ll_Return
n_cst_Events	lnv_Events

//ll_Return = lnv_Events.of_GetChassisRtnLocation ( dw_Events )

RETURN ll_Return 

end function

public function long of_find (String as_FindString);RETURN dw_events.Find ( as_FindString  ,1 , dw_events.RowCount ( ) )
end function

public function integer of_scrolltotofirstselectedevent ();//Scroll to the first selected event, if that event is not already current.
//If the first selected event already has focus, or if there are no selected events,
//no action will be taken.

Long	ll_FirstSelected, &
		ll_Current

ll_FirstSelected = dw_events.GetSelectedRow ( 0 )
ll_Current = dw_events.GetRow ( )

IF ll_FirstSelected > 0 THEN
	IF ll_FirstSelected = ll_Current THEN
		//OK
	ELSE
		dw_events.ScrollToRow ( ll_FirstSelected )
		Yield ( )  //To allow scoll sync processing to finish, ahead of other code in calling script
	END IF
END IF
RETURN 1
end function

public function datawindow of_geteventsource ();RETURN dw_events
end function

public function long of_getrow ();RETURN dw_events.GetRow ( )
end function

public subroutine of_setredraw (boolean ab_Value);dw_events.SetRedraw ( ab_Value ) 
end subroutine

public function integer of_getselectedeventids (ref long ala_ids[], boolean ab_UseCurrent);Long	ll_Count
Long	lla_Rows[]
Long	lla_Ids []
Long	ll_i
Long	ll_Row

n_cst_anyArraySrv	lnv_AnyArray
n_cst_dws	lnv_dws


ll_Count = lnv_Dws.of_SelectedCount ( dw_events, lla_Rows )

IF ll_Count = 0 AND ab_UseCurrent THEN
	ll_Row = dw_events.GetRow ( )
	IF ll_Row > 0 THEN
		ll_Count = 1
		lla_Rows [ 1 ] = ll_Row
	END IF
END IF	

FOR ll_i = 1 TO ll_Count
	lla_Ids [ ll_i ] = dw_events.Object.de_id [ lla_Rows [ ll_i ] ]
NEXT

lnv_anyarray.of_GetShrinked( lla_Ids, "NULLS~tDUPES" )

ll_Count = UpperBound ( lla_Ids )
ala_Ids = lla_Ids

RETURN ll_Count


end function

public function long of_getsites (ref long ala_CoIds[]);Long	lla_Ids[]
Long	ll_Count
Long	ll_i

n_cst_AnyArraySrv	lnv_ArraySrv

ll_Count = dw_events.RowCount ( )

FOR ll_i = 1 TO ll_Count 
	
	lla_Ids[ ll_i ] = dw_events.GetItemNumber ( ll_i , "de_Site" )

NEXT

lnv_ArraySrv.of_GetShrinked ( lla_Ids , TRUE , TRUE )

ala_CoIds = lla_Ids

RETURN ll_Count





end function

public function integer of_setcontext (string as_context, readonly n_cst_beo_shipment anv_shipment);return dw_events.of_SetContext ( as_context , anv_shipment  )
end function

public function integer of_setfocus (long al_Row, string as_Column);IF al_Row > 0 THEN
	dw_events.SetRow ( al_Row )
END IF

IF Len ( as_Column ) > 0 THEN
	dw_Events.SetColumn ( as_Column ) 
END IF

dw_Events.SetFocus ( )

RETURN 1

end function

public function integer of_sharedataoff ();RETURN dw_events.ShareDataOff ( )
end function

public function n_cst_beo_Event of_geteventforrow (long al_Row);n_Cst_Beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( dw_events )
lnv_Event.of_SetSourceRow ( al_Row )

RETURN lnv_Event
end function

on u_cst_eventlist.create
int iCurrent
call super::create
this.dw_events=create dw_events
this.uo_ip2=create uo_ip2
this.uo_ip3=create uo_ip3
this.uo_ip4=create uo_ip4
this.uo_ip1=create uo_ip1
this.uo_ip5=create uo_ip5
this.uo_ip7=create uo_ip7
this.uo_ip8=create uo_ip8
this.uo_ip6=create uo_ip6
this.uo_ip9=create uo_ip9
this.uo_ip10=create uo_ip10
this.uo_ip11=create uo_ip11
this.uo_ip12=create uo_ip12
this.uo_ip13=create uo_ip13
this.uo_ip14=create uo_ip14
this.uo_ip15=create uo_ip15
this.uo_ip16=create uo_ip16
this.uo_ip17=create uo_ip17
this.uo_ip18=create uo_ip18
this.uo_ip19=create uo_ip19
this.uo_ip20=create uo_ip20
this.st_itin_ind=create st_itin_ind
this.st_move=create st_move
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_events
this.Control[iCurrent+2]=this.uo_ip2
this.Control[iCurrent+3]=this.uo_ip3
this.Control[iCurrent+4]=this.uo_ip4
this.Control[iCurrent+5]=this.uo_ip1
this.Control[iCurrent+6]=this.uo_ip5
this.Control[iCurrent+7]=this.uo_ip7
this.Control[iCurrent+8]=this.uo_ip8
this.Control[iCurrent+9]=this.uo_ip6
this.Control[iCurrent+10]=this.uo_ip9
this.Control[iCurrent+11]=this.uo_ip10
this.Control[iCurrent+12]=this.uo_ip11
this.Control[iCurrent+13]=this.uo_ip12
this.Control[iCurrent+14]=this.uo_ip13
this.Control[iCurrent+15]=this.uo_ip14
this.Control[iCurrent+16]=this.uo_ip15
this.Control[iCurrent+17]=this.uo_ip16
this.Control[iCurrent+18]=this.uo_ip17
this.Control[iCurrent+19]=this.uo_ip18
this.Control[iCurrent+20]=this.uo_ip19
this.Control[iCurrent+21]=this.uo_ip20
this.Control[iCurrent+22]=this.st_itin_ind
this.Control[iCurrent+23]=this.st_move
this.Control[iCurrent+24]=this.cb_1
this.Control[iCurrent+25]=this.cb_2
end on

on u_cst_eventlist.destroy
call super::destroy
destroy(this.dw_events)
destroy(this.uo_ip2)
destroy(this.uo_ip3)
destroy(this.uo_ip4)
destroy(this.uo_ip1)
destroy(this.uo_ip5)
destroy(this.uo_ip7)
destroy(this.uo_ip8)
destroy(this.uo_ip6)
destroy(this.uo_ip9)
destroy(this.uo_ip10)
destroy(this.uo_ip11)
destroy(this.uo_ip12)
destroy(this.uo_ip13)
destroy(this.uo_ip14)
destroy(this.uo_ip15)
destroy(this.uo_ip16)
destroy(this.uo_ip17)
destroy(this.uo_ip18)
destroy(this.uo_ip19)
destroy(this.uo_ip20)
destroy(this.st_itin_ind)
destroy(this.st_move)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;THIS.of_SetResize ( TRUE )
dw_events.hscrollbar = FALSE 
inv_Resize.of_Register ( dw_events , 'ScaleToRight&Bottom' )


iuo_ip[1] = uo_ip1
iuo_ip[2] = uo_ip2
iuo_ip[3] = uo_ip3
iuo_ip[4] = uo_ip4
iuo_ip[5] = uo_ip5
iuo_ip[6] = uo_ip6
iuo_ip[7] = uo_ip7
iuo_ip[8] = uo_ip8
iuo_ip[9] = uo_ip9
iuo_ip[10] = uo_ip10
iuo_ip[11] = uo_ip11
iuo_ip[12] = uo_ip12
iuo_ip[13] = uo_ip13
iuo_ip[14] = uo_ip14
iuo_ip[15] = uo_ip15
iuo_ip[16] = uo_ip16
iuo_ip[17] = uo_ip17
iuo_ip[18] = uo_ip18
iuo_ip[19] = uo_ip19
iuo_ip[20] = uo_ip20





end event

event resize;call super::resize;this.post of_ShowIP ( )
end event

type dw_events from u_dw_eventlist within u_cst_eventlist
integer x = 123
integer y = 76
integer width = 3205
integer height = 452
integer taborder = 30
boolean bringtotop = true
boolean hscrollbar = true
end type

event doubleclicked;Parent.Event ue_ShowDetail ( row )
end event

event ue_mousemove;Parent.Event ue_MouseMove ( flags ,xpos , ypos )  
end event

event ue_getdispatchmanager;Return Parent.Event ue_GetDispatchManager ( )
end event

event ue_getshipment;Return Parent.event ue_GetShipment ( ) 
end event

event scrollvertical;Parent.of_ResetRange ( )
PARENT.of_ShowIP ( )
end event

event ue_deleteevent;call super::ue_deleteevent;PARENT.Event ue_EventDeleted ( ) 
end event

event ue_postchangesite;Parent.Event ue_SiteChanged ( al_row, al_old , al_new )
end event

event constructor;call super::constructor;Long		ll_ColumnCount	
Long		ll_i
String	ls_ColumnName
String	ls_ModifyRtn
String	ls_EventDisplay


//Display Tractor, Driver, or Both
n_cst_setting_EventListDisplay	lnv_EventDisplay

lnv_EventDisplay = Create	n_cst_setting_EventListDisplay
ls_EventDisplay = lnv_EventDisplay.of_GetValue( )
Destroy	lnv_EventDisplay
IF ls_EventDisplay = appeon_constant.cs_Both THEN
	This.Modify("trac_ref.Visible=1")
	This.Modify("driv_ref.Visible=1")
ELSEIF ls_EventDisplay = n_cst_setting_EventListDisplay.cs_Tractor THEN
	This.Modify("trac_ref.Visible=1")
	This.Modify("driv_ref.Visible=0")
ELSEIF ls_EventDisplay = appeon_constant.cs_Driver THEN
	This.Modify("trac_ref.Visible=0")
	This.Modify("driv_ref.Visible=1")
END IF

ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )

FOR ll_i = 1 TO ll_ColumnCount
	ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )
	
	
	CHOOSE CASE ls_ColumnName 
			
		CASE "de_event_type" , "co_name" , "leg_miles" , "co_tz" , "de_note" , "de_conf" , "trac_ref" , "de_arrdate", "driv_ref"
			// leave normal size
			
			
		CASE ELSE
			ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".Width=0")
		
	END CHOOSE
	
NEXT

// computed fields are not accounted for in get column count
THIS.Modify( "comp_confirmed.Width=0")
THIS.Modify( "comp_routed.Width=0")
THIS.Modify( "comp_tz_adj.Width=0")
THIS.Post of_AllowEdit ( TRUE ) 


end event

event ue_actioneventadded;PARENT.Event ue_PostRefresh ( )
end event

event losefocus;//cs_EventType_Misc
//n_cst_beo_Shipment	lnv_Shipment
//
//lnv_Shipment = Event ue_GetShipment ( ) 
//IF isValid ( lnv_Shipment ) THEN
//	//lnv_shipment.of_setUnspecifiedEventType ( gc_dispatch.cs_EventType_Misc )
//END IF 
THIS.of_ScrollLeft ( ) 
THIS.AcceptText () 
end event

event rowfocuschanged;call super::rowfocuschanged;PARENT.event ue_RowChanged ( currentrow )
end event

event ue_origindestchanged;Parent.Event ue_OriginDestChanged (  )
end event

event ue_refresh;Parent.Event ue_PostRefresh ( )
end event

event ue_getxpos;Return Parent.Event ue_GetXPos ( ) 
end event

event ue_getypos;Return Parent.Event ue_GetYPos ( ) 
end event

event ue_jumptoitinerary;Parent.Event ue_JumpToItinerary ( al_Row )
end event

event ue_refreshshipment;Parent.Event ue_RefreshShipment ( ) 
end event

event ue_showeventselections;call super::ue_showeventselections;n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Event		lnv_Event
String	ls_Type

lnv_Event = CREATE n_Cst_beo_Event

lnv_event.of_SetSource ( dw_events  )
lnv_Event.of_SetSourceROw ( al_row )

lnv_Dispatch = THIS.event ue_getdispatchmanager( )
lnv_Shipment = THIS.event ue_getshipment( )

IF isValid ( lnv_Shipment ) AND isValid ( lnv_Dispatch ) THEN

	dw_events.SetRedraw ( FALSE )
	ls_Type = lnv_Event.of_GetType ( )
	IF IsNull ( ls_Type ) OR ls_Type = "" THEN
		lnv_Shipment.of_removeEvents( {lnv_event.of_GetID()} ,lnv_Dispatch, TRUE )
	END IF
	dw_events.SetRedraw ( TRUE )
	
END IF

DESTROY ( lnv_Event )
end event

event ue_yardstorageadded;call super::ue_yardstorageadded;// I had to post this because the way that I go after the item
// on the shipment window needs the items to be done sorting. 

Parent.Post event ue_yardstorageadded( )
end event

type uo_ip2 from u_cst_insertionpoint within u_cst_eventlist
integer y = 204
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip2.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip3 from u_cst_insertionpoint within u_cst_eventlist
integer y = 268
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip3.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip4 from u_cst_insertionpoint within u_cst_eventlist
integer y = 332
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip4.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip1 from u_cst_insertionpoint within u_cst_eventlist
integer y = 140
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip1.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip5 from u_cst_insertionpoint within u_cst_eventlist
integer y = 396
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip5.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip7 from u_cst_insertionpoint within u_cst_eventlist
integer y = 524
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip7.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip8 from u_cst_insertionpoint within u_cst_eventlist
integer y = 588
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip8.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip6 from u_cst_insertionpoint within u_cst_eventlist
integer y = 460
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip6.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip9 from u_cst_insertionpoint within u_cst_eventlist
integer y = 652
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip9.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip10 from u_cst_insertionpoint within u_cst_eventlist
integer y = 716
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip10.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip11 from u_cst_insertionpoint within u_cst_eventlist
integer y = 780
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip11.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip12 from u_cst_insertionpoint within u_cst_eventlist
integer y = 844
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip12.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip13 from u_cst_insertionpoint within u_cst_eventlist
integer y = 908
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip13.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip14 from u_cst_insertionpoint within u_cst_eventlist
integer y = 972
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip14.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip15 from u_cst_insertionpoint within u_cst_eventlist
integer y = 1036
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip15.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip16 from u_cst_insertionpoint within u_cst_eventlist
integer y = 1100
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip16.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip17 from u_cst_insertionpoint within u_cst_eventlist
integer y = 1164
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip17.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip18 from u_cst_insertionpoint within u_cst_eventlist
integer y = 1228
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip18.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip19 from u_cst_insertionpoint within u_cst_eventlist
integer y = 1292
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip19.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type uo_ip20 from u_cst_insertionpoint within u_cst_eventlist
integer y = 1356
integer width = 119
integer height = 56
boolean bringtotop = true
end type

on uo_ip20.destroy
call u_cst_insertionpoint::destroy
end on

event ue_mousemove;call super::ue_mousemove;Parent.of_ResetPointers ( THIS )
end event

event ue_clicked;IF ib_Move THEN
	PARENT.Event ue_MoveEvent ( This.of_GetAssignedNumber ( ) )
ELSE
	Parent.of_InsertEvent ( This.of_GetAssignedNumber ( ) )
END IF
end event

type st_itin_ind from statictext within u_cst_eventlist
integer x = 123
integer y = 8
integer width = 663
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Itin&erary: 0 to 0 of 0"
boolean focusrectangle = false
end type

event clicked;Long	ll_Row
IF dw_events.RowCount ( ) > 0 THEN
	ll_Row = dw_events.GetRow ( ) 
	IF ll_Row = 0 THEN
		ll_Row = 1 
		dw_events.SelectRow ( 1 , TRUE ) 
	END IF
END IF

Parent.Event ue_ShowDetail ( ll_Row )


end event

type st_move from statictext within u_cst_eventlist
boolean visible = false
integer x = 2043
integer width = 1239
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
string text = "Select the event to move, then its new position"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;ib_move = FALSE
THIS.Visible = FALSE
end event

type cb_1 from commandbutton within u_cst_eventlist
integer x = 805
integer y = 16
integer width = 91
integer height = 56
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_events.of_ScrollLeft ( )
end event

type cb_2 from commandbutton within u_cst_eventlist
integer x = 901
integer y = 16
integer width = 91
integer height = 56
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_events.of_ScrollRight ( )



end event

