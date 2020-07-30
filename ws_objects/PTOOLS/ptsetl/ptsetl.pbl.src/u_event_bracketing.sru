$PBExportHeader$u_event_bracketing.sru
forward
global type u_event_bracketing from u_base
end type
type st_2 from statictext within u_event_bracketing
end type
type cb_lockblock from commandbutton within u_event_bracketing
end type
type dw_items from u_dw within u_event_bracketing
end type
type dw_list from u_dw within u_event_bracketing
end type
type st_1 from statictext within u_event_bracketing
end type
type cb_block from commandbutton within u_event_bracketing
end type
type cb_dwn from u_cb within u_event_bracketing
end type
type cb_up from u_cb within u_event_bracketing
end type
type cb_clear from commandbutton within u_event_bracketing
end type
type cb_autoblock from commandbutton within u_event_bracketing
end type
type cb_clearall from commandbutton within u_event_bracketing
end type
end forward

global type u_event_bracketing from u_base
integer width = 3611
integer height = 1932
boolean border = true
long backcolor = 12632256
long tabbackcolor = 67108864
long picturemaskcolor = 536870912
event ue_lockblock ( )
event ue_showitems ( boolean ab_show )
event ue_showpaysplit ( )
event ue_showamounts ( long ala_event[] )
event ue_hideamounts ( )
event ue_eventchanged ( long ala_event[] )
event ue_setfocus ( string as_where )
st_2 st_2
cb_lockblock cb_lockblock
dw_items dw_items
dw_list dw_list
st_1 st_1
cb_block cb_block
cb_dwn cb_dwn
cb_up cb_up
cb_clear cb_clear
cb_autoblock cb_autoblock
cb_clearall cb_clearall
end type
global u_event_bracketing u_event_bracketing

type variables
Constant String	cs_lock_button_text = "&Lock"
Constant String	cs_unlock_button_text = "Un&lock"
Constant String	cs_showitem_button_text = "Show &Item"
Constant String	cs_hideitem_button_text = "Hide &Item"

PRIVATE:
boolean		ib_blocklocked
boolean		ib_multimodelock
boolean		ib_lockfeatureon
long		il_FirstBlockRow
long		il_LastBlockRow
n_cst_eventblock	inva_EventBlock[]
n_cst_beo_itinerary2 	inv_Itinerary
STRING		is_OriginalItemSelect

end variables

forward prototypes
public subroutine of_setitemshiplist (long ala_ids[])
public subroutine of_seteventlist (n_ds ads_events)
public function boolean of_isblocklocked ()
public subroutine of_lockfeature (boolean ab_lock)
private function long of_getselectedblockfirstrow ()
private function long of_getselectedblocklastrow ()
private function long of_lockblock (boolean ab_lock)
private subroutine of_lockblockbuttontext (long al_row)
public function long of_getselectedblockfirstrow (long al_rangefirstevent, long al_rangelastevent)
public function long of_getselectedblocklastrow (long al_RangeFirstEvent, long al_RangeLastEvent)
public function long of_getselectedblock (ref n_cst_eventblock anva_eventblock[])
public function boolean of_getmultimodelock ()
public subroutine of_setmultimodelock (boolean ab_multimode)
public function long of_geteventblock (ref n_cst_EventBlock anva_EventBlock[])
private function long of_getlockblock (ref n_cst_eventblock anva_eventblock[])
public subroutine of_setitinerary (n_cst_beo_itinerary2 anv_Itinerary)
public subroutine of_seteventdisplay ()
public subroutine of_processblock ()
public subroutine of_cleareventblock ()
public subroutine of_reset ()
public subroutine of_setinitialbrackets (string asa_Brackets[])
public function long of_getbrackets (ref string asa_Brackets[])
public subroutine of_disablecontrols ()
public subroutine of_enablecontrols ()
public subroutine of_nextavailableblock ()
public function long of_getselectedevent ()
public subroutine of_setrowfocus (long al_eventid)
public subroutine of_removelock (boolean ab_keepprimary, long al_arraylocation)
public subroutine of_setaccessorialindicator (n_cst_bso_transactionmanager anv_transactionmanager, long ala_amountid[])
public subroutine of_setpaysplitcolumn (n_cst_bso_transactionmanager anv_transactionmanager, long ala_amountid[])
public function integer of_getpoints (ref long al_originid, ref long al_destinationid)
public subroutine of_seteventrow (long al_eventid)
public function integer of_seteventcounts ()
end prototypes

event ue_setfocus(string as_where);
choose case as_where
	case "AVAILABLE TEMPLATE"
		dw_list.selectrow(0, false)
		
end choose
	
	
end event

public subroutine of_setitemshiplist (long ala_ids[]);string	ls_Ids, &
			ls_Sql, &
			ls_ModString, &
			ls_rc, &
			ls_Inclause, &
			ls_WhereClause

//load items
n_cst_sql		lnv_SQL

IF upperbound ( ala_Ids )  > 0 THEN
	ls_InClause = lnv_Sql.of_MakeInClause ( ala_ids[] )
	ls_WhereClause = ' where ~~"disp_items~~".~~"di_shipment_id~~" ' + ls_InClause
	if len(trim(is_OriginalItemSelect)) > 0 then
		//already have it
	else
		is_OriginalItemSelect = dw_items.Object.Datawindow.Table.Select
	end if

	dw_items.Object.Datawindow.Table.Select = is_OriginalItemSelect + ls_WhereClause
	dw_items.SetTransObject(SQLCA)
	dw_items.Retrieve()
	
ELSE
	dw_Items.Reset()
END IF


end subroutine

public subroutine of_seteventlist (n_ds ads_events);long	ll_RowCount, &
		ll_Ndx, &
		ll_NewRow
string	lsa_BlankBracket[]
n_cst_dws	lnv_dws

setnull(ll_NewRow)

//note: need some way to filter (from display) the events from the previous 7 days in the cache 

ll_RowCount = ads_events.RowCount()

dw_List.SetRedraw(FALSE)

FOR ll_Ndx = 1 to ll_RowCount
	lnv_dws.of_copy_by_column ( ads_events, ll_Ndx, dw_List, ll_NewRow )
NEXT

//of_SetInitialBrackets (lsa_BlankBracket)
dw_list.GroupCalc ( )
dw_list.triggerevent(rowfocuschanged!)
dw_List.SetRedraw(TRUE)

end subroutine

public function boolean of_isblocklocked ();return ib_blocklocked
end function

public subroutine of_lockfeature (boolean ab_lock);/*	
	
	disable/enable lock button

*/

cb_lockblock.enabled = ab_lock
ib_lockfeatureon = ab_lock
end subroutine

private function long of_getselectedblockfirstrow ();/*
	Find the top of the selected block. One or more rows may be selected within
	the block so the selected rows need to be searched to make sure more than
	one block has not been selected.
	
	Return first row of block
	Return -1 if more than one top of block found
*/
long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_Return, &
		ll_BracketCount

boolean	lb_FoundBracket

ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )

IF ll_SelectedRowCount > 0 THEN

	ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )
	
//look for TOP and BOTTOM or TOPANDBOTTOM and lock the block

	//First make sure multiple TOP brackets are not selected
	FOR ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
		
		IF dw_List.object.bracket_type[ll_RowNdx] = "TOP" OR &
			dw_List.object.bracket_type[ll_RowNdx] = "TOPANDBOTTOM" THEN
			ll_BracketCount ++
		END IF
		
	NEXT
	
	IF ll_BracketCount > 1 THEN
		ll_Return = -1
	END IF
	//Find top of block
	IF ll_Return = 0 THEN
		choose case dw_List.object.bracket_type[ll_SelectedStartRow] 
				
			case "TOP"	//already at top
				ll_Return = ll_SelectedStartRow
				
			case "TOPANDBOTTOM"
				IF ll_SelectedRowCount = 1 THEN
					ll_Return = ll_SelectedStartRow
					
				ELSE
					//more than one block selected, reject
					ll_Return = -1
					
				END IF
				
			case else
				//search backwards for top of block
				lb_FoundBracket = FALSE
				FOR ll_RowNdx = ll_SelectedStartRow to 1 STEP -1
					
					IF dw_List.object.bracket_type[ll_RowNdx] = "TOP" THEN
						lb_FoundBracket = TRUE
						ll_Return = ll_RowNdx
						EXIT
					END IF
					
				NEXT
				IF NOT lb_FoundBracket THEN
					ll_Return = -1
				END IF
				
		end choose
		
	END IF

END IF

return ll_Return
end function

private function long of_getselectedblocklastrow ();long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_Ndx, &
		ll_RowNdx, &
		ll_RowCount, &
		ll_Return, &
		ll_BracketCount

boolean	lb_FoundBracket, &
			lb_TopandBottomFound

ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )

IF ll_SelectedRowCount > 0 THEN

	ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )
	
	//First make sure multiple BOTTOM brackets are not selected
	FOR ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
		
		IF dw_List.object.bracket_type[ll_RowNdx] = "BOTTOM" THEN
			ll_BracketCount ++
		END IF
		
	NEXT
	
	IF ll_BracketCount > 1 THEN
		ll_Return = -1
	END IF
	//Find BOTTOM of block
	IF ll_Return = 0 THEN
		choose case dw_List.object.bracket_type[ll_SelectedEndRow] 
				
			case "BOTTOM"	//already have BOTTOM
				ll_Return = ll_SelectedEndRow
				
			case "TOPANDBOTTOM"
				IF ll_SelectedRowCount = 1 THEN
					ll_Return = ll_SelectedStartRow
					
				ELSE
					//more than one block selected, reject
					ll_Return = -1
					
				END IF
				
			case else
				//search forwards for BOTTOM of block
				lb_FoundBracket = FALSE
				FOR ll_RowNdx = ll_SelectedStartRow to ll_RowCount
					
					IF dw_List.object.bracket_type[ll_RowNdx] = "BOTTOM" THEN
						ll_Return = ll_RowNdx
						lb_FoundBracket = TRUE
						EXIT
					END IF
					
				NEXT
				IF NOT lb_FoundBracket THEN
					ll_Return = -1
				END IF
				
		end choose
	END IF
END IF


RETURN ll_Return
end function

private function long of_lockblock (boolean ab_lock);/*
	All locked blocks are kept in an array of n_cst_eventblock.  Keeping track of 
	selected and nonselected blocks can be tricky.  In order to simplify this the array will
	be initialized each time.  The current locked blocks will be added back into the array
	and then the selected ones will be found and will be appropriately locked/unlocked as long
	as the selected block types are not mixed ( locked vs unlocked).
	
	
	return  0 = successfull
	       -1 = couldn't lock/unlock block
*/

long	ll_Return, &
		ll_Ndx, &
		ll_RowNdx, &
		ll_FirstBlockRow, &
		ll_LastBlockRow, &
		ll_Unblockcount, &
		ll_Blockcount, &
		ll_ProcessedCount, &
		ll_ArrayCount

n_cst_eventblock	lnva_EventBlock[], &
						lnva_BlankBlock[], &
						lnva_LockBlock[], &
						lnva_Selected[]
						
/*	If the user is trying to select one and there is already one selected,
	then let's make sure we are in multimode before we continue
*/

IF THIS.of_GetEventBlock ( lnva_EventBlock ) > 0 THEN
	IF ab_lock THEN
		IF THIS.of_GetMultiModeLock ( ) = FALSE THEN
			messagebox ( "Lock Block", "You are in single lock mode and cannot select more " + &
						"than one block until you have selected a template or entered a manual " + &
						"amount")
			ll_Return = -1
		END IF
	END IF
END IF

IF ll_Return = 0 THEN
	
	//let's get the nonselected locked blocks 
	this.of_GetLockBlock (lnva_LockBlock)
	
	ll_ArrayCount = this.of_GetSelectedBlock (lnva_Selected)
	IF ll_ArrayCount > 0 THEN
		//check for mixed types
		FOR ll_Ndx = 1 to ll_ArrayCount
			
			choose case lnva_Selected[ll_Ndx].of_GetStatus ( )
				case 'Y'
					ll_Blockcount ++
				case else //'N' or null
					ll_Unblockcount ++	
			end choose
			
		NEXT

		IF ll_BlockCount > 0 and ll_Unblockcount > 0 THEN
			//mixed blocks
			IF ab_lock THEN
				messagebox ( "Block Locking", &
					"When selecting multiple blocks to lock, " +&
					"please make sure that all the selected blocks haven't already been locked.")
			ELSE
				messagebox ( "Block Unlocking", &
					"When selecting multiple blocks to unlock, " +&
					"please make sure that all the selected blocks haven't already been unlocked.")
				
			END IF
		ELSE
			
			//	Lock/Unlock blocks
			FOR ll_Ndx = 1 to ll_ArrayCount
				
				ll_FirstBlockRow = lnva_Selected[ll_Ndx].of_GetFirstDisplayRow ( )
				ll_LastBlockRow = lnva_Selected[ll_Ndx].of_GetLastDisplayRow ( )
				
				FOR ll_RowNdx = ll_FirstBlockRow  to ll_LastBlockRow
						IF ab_lock THEN
							dw_List.object.lockblock[ll_RowNdx] = "Y"
						ELSE
							dw_List.object.lockblock[ll_RowNdx] = "N"
							dw_list.object.bracket_type[ll_RowNdx] = ''
						END IF
					NEXT
			NEXT
				
		END IF	
	END IF
END IF


IF ll_Return = 0 THEN
	lnva_EventBlock = lnva_BlankBlock
	lnva_EventBlock = lnva_LockBlock
	if ab_lock = false then //removing lock(s)
		if upperbound(lnva_lockblock) = 0 then
			ib_blocklocked = ab_lock
		else
			//there are still blocks locked
			//don't change instance
		end if
	else
		ib_blocklocked = ab_lock
	end if
		
	IF ab_lock THEN
		
		ll_ArrayCount = upperbound ( lnva_Selected ) 
		
		FOR ll_Ndx = 1 to ll_ArrayCount
			lnva_EventBlock [ upperbound (lnva_EventBlock) + 1 ] = lnva_Selected [ll_Ndx]
		NEXT
		
		inva_EventBlock = lnva_EventBlock
		
	ELSE
		IF upperbound(lnva_EventBlock) = 0 	THEN
			this.of_SetMultiModeLock ( FALSE ) 
		END IF
		inva_EventBlock = lnva_EventBlock
	END IF

	this.of_LockBlockButtonText ( ll_FirstBlockRow )
	
END IF
	
return ll_Return

end function

private subroutine of_lockblockbuttontext (long al_row);IF al_row > 0 THEN
	CHOOSE CASE dw_list.object.LockBlock[al_row]
		CASE 'Y'
			cb_lockblock.text = cs_unlock_button_text
			cb_lockblock.enabled = TRUE
		CASE 'P'
			cb_lockblock.text = cs_lock_button_text
			cb_lockblock.enabled = FALSE
		CASE ELSE
			cb_lockblock.text = cs_lock_button_text
			cb_lockblock.enabled = TRUE
	END CHOOSE
END IF



end subroutine

public function long of_getselectedblockfirstrow (long al_rangefirstevent, long al_rangelastevent);/*
	Find the top of the selected block. One or more rows may be selected within
	the block so the selected rows need to be searched to make sure more than
	one block has not been selected.
	
	Return first row of block
	Return -1 if more than one top of block found
*/
long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_Return, &
		ll_BracketCount

boolean	lb_FoundBracket

ll_RowCount = dw_list.RowCount()

ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( al_rangefirstevent ), 1, ll_RowCount )
ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( al_rangelastevent ), 1, ll_RowCount )
	
//Find top of block
choose case dw_List.object.bracket_type[ll_SelectedStartRow] 
		
	case "TOP", "TOPANDBOTTOM"//already at top
		ll_Return = ll_SelectedStartRow
			
	case else
		//search backwards for top of block
		lb_FoundBracket = FALSE
		FOR ll_RowNdx = ll_SelectedEndRow to ll_SelectedStartRow STEP -1
			
			IF dw_List.object.bracket_type[ll_RowNdx] = "TOP" THEN
				lb_FoundBracket = TRUE
				ll_Return = ll_RowNdx
				EXIT
			END IF
			
		NEXT
		IF NOT lb_FoundBracket THEN
			ll_Return = -1
		END IF
		
end choose

return ll_Return
end function

public function long of_getselectedblocklastrow (long al_RangeFirstEvent, long al_RangeLastEvent);long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_Ndx, &
		ll_RowNdx, &
		ll_RowCount, &
		ll_Return, &
		ll_BracketCount

boolean	lb_FoundBracket, &
			lb_TopandBottomFound

ll_RowCount = dw_list.RowCount()

ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( al_rangefirstevent ), 1, ll_RowCount )
ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( al_rangelastevent ), 1, ll_RowCount )
	
//Find BOTTOM of block
choose case dw_List.object.bracket_type[ll_SelectedStartRow] 
		
	case "BOTTOM", "TOPANDBOTTOM"
			ll_Return = ll_SelectedStartRow
		
	case else
		//search forwards for BOTTOM of block
		lb_FoundBracket = FALSE
		FOR ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
			
			IF dw_List.object.bracket_type[ll_RowNdx] = "BOTTOM" THEN
				ll_Return = ll_RowNdx
				lb_FoundBracket = TRUE
				EXIT
			END IF
			
		NEXT
		IF NOT lb_FoundBracket THEN
			ll_Return = -1
		END IF
		
end choose

RETURN ll_Return
end function

public function long of_getselectedblock (ref n_cst_eventblock anva_eventblock[]);/*
		Get first and last row of all selected blocks and pass back
		in reference structure.
		
		Also check for mixed block types
		
		return number of blocks in structure
		
*/

string	ls_Status

integer	li_Return = 1

long	lla_Selected[], &
		lla_EventID[], &
		ll_StartDisplayRow, &
		ll_EndDisplayRow, &
		ll_SelectedRowCount, & 
		ll_Ndx, &
		ll_RowNdx, &
		ll_SourceRow, &
		ll_Count, &
		ll_SearchNdx, &
		ll_RowCount, &
		ll_Return, &
		ll_ArrayCount, &
		ll_CacheCount, &
		ll_EventId

boolean	lb_SelectedBlock, &
			lb_FoundBottom

n_ds	lds_EventCache

ll_RowCount = dw_list.RowCount()
IF ISVALID ( inv_Itinerary ) THEN
	lds_EventCache = inv_Itinerary.of_GetEventCache ( )
ELSE
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ll_CacheCount = lds_eventcache.RowCount()
	lla_Selected = dw_list.object.de_id.selected
	ll_SelectedRowCount = upperbound ( lla_Selected )
	
	FOR ll_RowNdx = 1 to ll_RowCount
		
		//We will always be starting at the top of a block
		ll_StartDisplayRow = ll_RowNdx		
		choose case dw_List.object.bracket_type[ll_StartDisplayRow] 
			
			case "TOP"	
				//Search for bottom
				FOR ll_SearchNdx = ll_RowNdx to ll_RowCount
					
					IF dw_List.object.bracket_type[ll_SearchNdx] = "BOTTOM" THEN
						ll_EndDisplayRow = ll_SearchNdx
						lb_FoundBottom = true
						EXIT
					END IF
					
				NEXT
				
			case "TOPANDBOTTOM"
				ll_EndDisplayRow = ll_RowNdx		
				lb_FoundBottom = true
			case else
				ll_EndDisplayRow = ll_RowNdx	
				lb_FoundBottom = false
		end choose
	
	//	if lb_FoundBottom = false then
	//		exit
	//	end if
		
		lb_SelectedBlock = FALSE
		setnull(ls_Status)
	
		//See if there are any selected rows in this block
		FOR ll_SearchNdx = 1 to ll_SelectedRowCount
		
			IF dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SearchNdx] ), ll_StartDisplayRow, ll_EndDisplayRow ) > 0 THEN
				lb_SelectedBlock = TRUE
				EXIT
			END IF
	
		NEXT
			
		IF lb_SelectedBlock THEN
			ls_Status = dw_list.object.lockblock[ll_StartDisplayRow]
			ll_ArrayCount ++
			anva_EventBlock[ll_ArrayCount] = Create n_cst_EventBlock
			anva_EventBlock[ll_ArrayCount].of_SetFirstDisplayRow ( ll_StartDisplayRow )
			anva_EventBlock[ll_ArrayCount].of_SetLastdisplayRow ( ll_EndDisplayRow )
			anva_EventBlock[ll_ArrayCount].of_SetStatus ( ls_Status )
			anva_EventBlock[ll_ArrayCount].of_SetStartDate ( dw_List.object.de_arrdate[ll_StartDisplayRow] )
			anva_EventBlock[ll_ArrayCount].of_SetOriginId ( dw_List.object.de_site[ll_StartDisplayRow] )
			anva_EventBlock[ll_ArrayCount].of_SetEndDate ( dw_List.object.de_arrdate[ll_EndDisplayRow] )
			anva_EventBlock[ll_ArrayCount].of_SetDestinationId ( dw_List.object.de_site[ll_EndDisplayRow] )		
				
			//find first source row
			ll_EventID = dw_list.object.de_id[ll_StartDisplayRow]
			ll_SourceRow  = lds_eventcache.Find ( "de_id = " + String (ll_EventID), 1, ll_CacheCount )
			anva_EventBlock[ll_ArrayCount].of_SetFirstSourceRow ( ll_SourceRow )
			
			//find last source row
			ll_EventID = dw_list.object.de_id[ll_EndDisplayRow]
			ll_SourceRow  = lds_eventcache.Find ( "de_id = " + String (ll_EventID), 1, ll_CacheCount )
			anva_EventBlock[ll_ArrayCount].of_SetLastSourceRow ( ll_SourceRow )
						
			FOR ll_Ndx = ll_StartDisplayRow to ll_EndDisplayRow
				ll_Count ++
				lla_EventID[ll_Count] = dw_list.object.de_id[ll_Ndx]
			NEXT
	
			anva_EventBlock[ll_ArrayCount].of_SetEventIdList ( lla_EventID )
			anva_EventBlock[ll_ArrayCount].of_SetRowCount ( upperbound ( lla_EventId ) )
			
			IF this.of_GetMultiModeLock () = TRUE THEN
				anva_EventBlock[ll_ArrayCount].of_SetPrimaryBlock (FALSE)
			ELSE
				anva_EventBlock[ll_ArrayCount].of_SetPrimaryBlock (TRUE)
			END IF 
			
		ELSE	//
			
		END IF
		
		ll_RowNdx = ll_EndDisplayRow
		
		
	NEXT
END IF

return upperbound ( anva_EventBlock )

end function

public function boolean of_getmultimodelock ();return ib_multimodelock
end function

public subroutine of_setmultimodelock (boolean ab_multimode);ib_multimodelock = ab_multimode
end subroutine

public function long of_geteventblock (ref n_cst_EventBlock anva_EventBlock[]);long ll_ArrayCount

ll_ArrayCount = upperbound ( inva_eventblock ) 

IF ll_ArrayCount > 0 THEN
	anva_eventblock = inva_eventblock
END IF

return ll_ArrayCount
end function

private function long of_getlockblock (ref n_cst_eventblock anva_eventblock[]);integer	li_Return = 1

long	lla_EventID[], &
		lla_Blank[], &
		lla_Selected[], &
		ll_SelectedRowCount, &
		ll_StartDisplayRow, &
		ll_EndDisplayRow, &
		ll_Ndx, &
		ll_RowNdx, &
		ll_Count, &
		ll_SearchNdx, &
		ll_SourceRow, &
		ll_CacheCount, &
		ll_RowCount, &
		ll_ArrayCount, &
		ll_EventID

boolean	lb_SelectedBlock, &
			lb_FoundBottom

n_ds	lds_EventCache
ll_RowCount = dw_list.RowCount()
IF ISVALID ( inv_Itinerary ) THEN
	lds_EventCache = inv_Itinerary.of_GetEventCache ( )
ELSE
	li_return = -1
END IF

IF li_Return = 1 THEN
	ll_CacheCount = lds_eventcache.RowCount()
	lla_Selected = dw_list.object.de_id.selected
	ll_SelectedRowCount = upperbound ( lla_Selected )
	
	FOR ll_RowNdx = 1 to ll_RowCount
		
		//We will always be starting at the top of a block
		ll_StartDisplayRow = ll_RowNdx	
		lb_FoundBottom = false
		choose case dw_List.object.bracket_type[ll_StartDisplayRow] 
			
			case "TOP"	
				//Search for bottom
				FOR ll_SearchNdx = ll_RowNdx to ll_RowCount
					
					IF dw_List.object.bracket_type[ll_SearchNdx] = "BOTTOM" THEN
						ll_EndDisplayRow = ll_SearchNdx
						lb_FoundBottom = true
						EXIT
					END IF
					
				NEXT
				
			case "TOPANDBOTTOM"
				ll_EndDisplayRow = ll_RowNdx		
				lb_FoundBottom = true
				
			case else
				ll_EndDisplayRow = ll_RowNdx	
				lb_FoundBottom = false
				
		end choose
	
	//	if lb_FoundBottom = false then
	//		exit
	//	end if
		
		lb_SelectedBlock = FALSE
		//See if there are any selected rows in this block
		FOR ll_SearchNdx = 1 to ll_SelectedRowCount
		
			IF dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SearchNdx] ), ll_StartDisplayRow, ll_EndDisplayRow ) > 0 THEN
				lb_SelectedBlock = TRUE
				EXIT
			END IF
	
		NEXT
	
		IF lb_SelectedBlock THEN
			//SKIP
		ELSE
			IF dw_list.object.lockblock[ll_StartDisplayRow] = 'Y' THEN //add back to eventblock object array
			
				ll_ArrayCount ++
				anva_EventBlock[ll_ArrayCount] = Create n_cst_EventBlock
				anva_EventBlock[ll_ArrayCount].of_SetFirstDisplayRow ( ll_StartDisplayRow )
				anva_EventBlock[ll_ArrayCount].of_SetLastDisplayRow ( ll_EndDisplayRow )
				anva_EventBlock[ll_ArrayCount].of_SetStatus ( 'Y' )
				anva_EventBlock[ll_ArrayCount].of_SetStartDate ( dw_List.object.de_arrdate[ll_StartDisplayRow] )
				anva_EventBlock[ll_ArrayCount].of_SetOriginId ( dw_List.object.de_site[ll_StartDisplayRow] )
				anva_EventBlock[ll_ArrayCount].of_SetEndDate ( dw_List.object.de_arrdate[ll_EndDisplayRow] )
				anva_EventBlock[ll_ArrayCount].of_SetDestinationId ( dw_List.object.de_site[ll_EndDisplayRow] )
	
				//find first source row
				ll_EventID = dw_list.object.de_id[ll_StartDisplayRow]
				ll_SourceRow  = lds_eventcache.Find ( "de_id = " + String (ll_EventID), 1, ll_CacheCount )
				anva_EventBlock[ll_ArrayCount].of_SetFirstSourceRow ( ll_SourceRow )
				
				//find last source row
				ll_EventID = dw_list.object.de_id[ll_EndDisplayRow]
				ll_SourceRow  = lds_eventcache.Find ( "de_id = " + String (ll_EventID), 1, ll_CacheCount )
				anva_EventBlock[ll_ArrayCount].of_SetLastSourceRow ( ll_SourceRow )
	
				ll_Count = 0	
				lla_EventID = lla_Blank
				FOR ll_Ndx = ll_StartdisplayRow to ll_EndDisplayRow
					ll_Count ++
					lla_EventID[ll_Count] = dw_list.object.de_id[ll_Ndx]
				NEXT
		
				anva_EventBlock[ll_ArrayCount].of_SetEventIdList ( lla_EventID )
				anva_EventBlock[ll_ArrayCount].of_SetRowCount ( upperbound ( lla_EventId ) )
				
				IF this.of_GetMultiModeLock () = TRUE THEN
					anva_EventBlock[ll_ArrayCount].of_SetPrimaryBlock (FALSE)
				ELSE
					anva_EventBlock[ll_ArrayCount].of_SetPrimaryBlock (TRUE)
				END IF 
				
			END IF
			
		END IF
		
		ll_RowNdx = ll_EndDisplayRow
		
		
	NEXT
END IF

return upperbound ( anva_eventblock )
end function

public subroutine of_setitinerary (n_cst_beo_itinerary2 anv_Itinerary);inv_Itinerary = anv_Itinerary
end subroutine

public subroutine of_seteventdisplay ();long	ll_FirstRow, &
		ll_LastRow, &
		lla_Ids [], &
		ll_index, &
		ll_count, &
		ll_rowcount, &
		ll_eventid, &
		ll_shipid, &
		ll_shipcount, &
		ll_index2
		
string	ls_shipmenttype

n_ds	lds_EventCache, &
		lds_EventRange

n_cst_beo_Event		lnva_Event[]
n_cst_beo_Shipment	lnva_Shipment[]

lds_EventRange = CREATE n_ds
lds_EventRange.SetTransObject(SQLCA)
lds_EventRange.dataobject='d_itin'
	
IF ISVALID ( inv_Itinerary ) 	THEN	
	dw_list.reset()
	inv_Itinerary.of_GetFirstLastEventRow(ll_FirstRow, ll_LastRow)
	lds_EventCache = inv_Itinerary.of_GetEventCache ( )
	lds_EventCache.RowsCopy ( ll_FirstRow, ll_LastRow, Primary!, lds_EventRange, 1, Primary! )
	this.of_SetEventList ( lds_EventRange ) 
	
	//set shipment types
	inv_Itinerary.of_GetShipmentIds ( lla_Ids, TRUE, TRUE, FALSE )
	ll_shipcount = inv_Itinerary.of_GetShipment ( lla_Ids, lnva_Shipment )
	
	ll_rowcount = dw_list.rowcount()
	for ll_index = 1 to ll_rowcount
		ll_shipId = dw_list.object.de_shipment_id[ll_index]
		if ll_shipid > 0 then
			for ll_index2 = 1 to ll_shipcount
				if ll_shipId = lnva_Shipment[ll_index2].of_Getid() then
					ls_shipmenttype = lnva_Shipment[ll_index2].of_GetShipmenttype( )
					dw_list.object.shipmenttype[ll_index] = ls_shipmenttype
					exit
				end if
			next
		end if
	next
		
	//get shipment list
	inv_Itinerary.of_GetShipmentIds ( lla_Ids, TRUE, TRUE, FALSE )
	
	//load items
	this.of_SetItemShipList ( lla_Ids )

//	lds_EventRange.RowsCopy ( ll_FirstRow, ll_LastRow, Primary!, dw_list, 1, Primary! )
	
END IF 

destroy (lds_EventRange)
end subroutine

public subroutine of_processblock ();long	ll_ArrayCount, &
		ll_Ndx, &
		ll_FirstBlockRow, &
		ll_LastBlockRow, &
		ll_RowNdx

boolean	lb_adjust

n_cst_EventBlock	lnva_EventBlock[]
n_cst_setting_InteractiveSelectionFilter	lnv_SelectionFilter
	
lnv_SelectionFilter = create n_cst_setting_InteractiveSelectionFilter
	
IF lnv_SelectionFilter.of_Getvalue( ) = lnv_SelectionFilter.cs_Yes THEN
	lb_adjust = true
ELSE
	lb_adjust = false
END IF

ll_ArrayCount = this.of_GetEventBlock ( lnva_EventBlock ) 

FOR ll_Ndx = 1 to ll_ArrayCount
	
	ll_FirstBlockRow = lnva_EventBlock[ll_Ndx].of_GetFirstDisplayRow ( )
	ll_LastBlockRow = lnva_EventBlock[ll_Ndx].of_GetLastDisplayRow ( )
	
	IF lb_adjust THEN
		if ll_firstBlockRow  > 1 then
			ll_FirstBlockRow = ll_FirstBlockRow - 1
		end if
	END IF
	
	FOR ll_RowNdx = ll_FirstBlockRow  to ll_LastBlockRow
		dw_list.object.bracket_type[ll_RowNdx] = ''
		dw_list.object.lockblock[ll_RowNdx] = ''
//		dw_List.Object.processcount[ll_RowNdx] = dw_List.Object.processcount[ll_RowNdx] + 1
	NEXT
	
NEXT

this.of_LockBlockButtonText ( ll_FirstBlockRow )
ib_blocklocked = FALSE

destroy lnv_SelectionFilter


end subroutine

public subroutine of_cleareventblock ();n_cst_eventblock	lnva_BlankBlock []

inva_eventblock = lnva_BlankBlock
end subroutine

public subroutine of_reset ();long	lla_Ids[]

n_cst_EventBlock	lnva_EventBlock []
this.of_SetItemShipList ( lla_Ids )

dw_list.Reset()

ib_blocklocked = FALSE

ib_multimodelock = FALSE

inva_eventblock = lnva_EventBlock


 

end subroutine

public subroutine of_setinitialbrackets (string asa_Brackets[]);//note: bracketing pickup type to deliver type event, anything outside of a pickup/deliver 
//will get a topandbottom bracket

long	ll_RowCount, &
		ll_Ndx, &
		ll_ArrayCount
string	ls_EventType
boolean	lb_NewBracketGroup

n_cst_events lnv_EventType

ll_RowCount = dw_list.RowCount()
ll_ArrayCount = upperbound(asa_Brackets)
IF ll_ArrayCount > 0  THEN
	//if bracket count doesn't match rowcount then don't attempt bracketing
	IF ll_RowCount = ll_ArrayCount THEN
		FOR ll_Ndx = 1 to ll_ArrayCount
			dw_list.object.bracket_type[ll_Ndx] = asa_Brackets[ll_Ndx]
		NEXT
	END IF
ELSE
	FOR ll_Ndx = 1 to ll_RowCount
		ls_EventType = dw_list.object.de_event_type[ll_Ndx]
		IF lnv_EventType.of_IsTypePickupGroup ( ls_EventType ) THEN
			IF lb_NewBracketGroup THEN
				dw_list.object.bracket_type[ll_Ndx]='NONE'
			ELSE
				dw_list.object.bracket_type[ll_Ndx]='TOP'
				lb_NewBracketGroup = TRUE
			END IF
		ELSE
			IF lnv_EventType.of_IsTypeDeliverGroup ( ls_EventType ) THEN
				IF NOT lb_NewBracketGroup THEN
					dw_list.object.bracket_type[ll_Ndx -1]='NONE'
					dw_list.object.bracket_type[ll_Ndx]='BOTTOM'
				ELSE
					dw_list.object.bracket_type[ll_Ndx]='BOTTOM'
					lb_NewBracketGroup = FALSE
				END IF
			ELSE
				IF lb_NewBracketGroup THEN
					dw_list.object.bracket_type[ll_Ndx]='NONE'
				ELSE
					dw_list.object.bracket_type[ll_Ndx]='TOPANDBOTTOM'
				END IF
			END IF
		END IF
	NEXT
	
END IF

dw_list.GroupCalc()

end subroutine

public function long of_getbrackets (ref string asa_Brackets[]);long	ll_RowCount, &
		ll_Ndx

ll_RowCount = dw_list.RowCount()
FOR ll_Ndx = 1 to ll_RowCount
	asa_Brackets[ll_Ndx] = dw_list.object.bracket_type[ll_Ndx]
NEXT

return upperbound(asa_Brackets)
end function

public subroutine of_disablecontrols ();cb_dwn.enabled = FALSE
cb_up.enabled = FALSE
cb_block.enabled = FALSE
cb_clear.enabled = FALSE
cb_autoblock.enabled = FALSE
cb_clearall.enabled = FALSE
cb_lockblock.enabled = FALSE
dw_items.enabled = FALSE

end subroutine

public subroutine of_enablecontrols ();cb_dwn.enabled = TRUE
cb_up.enabled = TRUE
cb_block.enabled = TRUE
cb_clear.enabled = TRUE
cb_autoblock.enabled = TRUE
cb_clearall.enabled = TRUE
cb_lockblock.enabled = TRUE
dw_items.enabled = TRUE
dw_list.enabled = TRUE
dw_list.SetFocus ( )
end subroutine

public subroutine of_nextavailableblock ();long	ll_FoundRow
string	ls_FindString

//ll_FoundRow = dw_list.find("processcount = 0",1,dw_List.RowCount())
//IF ll_FoundRow > 0 THEN
//	//ok
//else
	//get the current row and advance 1
	ll_foundrow = dw_list.GetRow()
	ll_foundrow ++
//END IF

dw_List.ScrollToRow(ll_FoundRow)
dw_list.selectrow(0,false)
dw_list.selectrow(ll_foundrow, true)
dw_list.setfocus()

end subroutine

public function long of_getselectedevent ();return dw_list.object.de_id[dw_list.GetRow()]
end function

public subroutine of_setrowfocus (long al_eventid);long	ll_row

ll_Row = dw_list.find('de_id = ' + string(al_eventid), 1, dw_list.rowcount())
if ll_row > 0 then
	dw_list.Scrolltorow(ll_row)
	dw_list.selectrow(0, false)
	dw_list.selectrow(ll_row, true)
end if
end subroutine

public subroutine of_removelock (boolean ab_keepprimary, long al_arraylocation);long	ll_Row, &
		ll_RowNdx, &
		ll_ArrayCount, &
		ll_Ndx, &
		ll_FirstBlockRow, &
		ll_LastBlockRow

n_cst_EventBlock	lnva_EventBlock[], &
						lnva_BlankBlock[]

ll_ArrayCount = upperbound ( inva_eventblock )
if al_arraylocation > 0 then
	//removing the block at this location from the object array
	for ll_RowNdx = 1 to ll_ArrayCount
		if ll_RowNdx <> al_arraylocation then
			ll_Ndx ++
			lnva_EventBlock[ll_Ndx] = inva_EventBlock[ll_rowndx]
		end if
	next
	cb_clear.TriggerEvent(clicked!)
	inva_EventBlock = lnva_EventBlock
else
	//remove everything except primary based on argument
	IF ll_ArrayCount > 0 THEN
		lnva_EventBlock[1] = inva_eventblock[1]
	END IF
	
	FOR ll_Ndx = 1 to ll_ArrayCount
	
		ll_FirstBlockRow = inva_eventblock[ll_Ndx].of_GetFirstDisplayRow ( )
		ll_LastBlockRow = inva_eventblock[ll_Ndx].of_GetLastDisplayRow ( )
	
		FOR ll_RowNdx = ll_FirstBlockRow  to ll_LastBlockRow
				dw_List.object.lockblock[ll_RowNdx] = "N"
		NEXT
		
	NEXT
	
	IF ab_keepprimary then
		
		IF upperbound ( lnva_EventBlock ) > 0 THEN
			//lock primary block
			ll_Row = lnva_EventBlock[1].of_GetFirstDisplayRow ( )
			dw_List.SelectRow ( 0, FALSE ) 
			dw_List.SelectRow ( ll_Row, TRUE )
			THIS.of_LockBlock ( TRUE )
		END IF
		
	END IF
end if
end subroutine

public subroutine of_setaccessorialindicator (n_cst_bso_transactionmanager anv_transactionmanager, long ala_amountid[]);long	ll_PayCount, &
		ll_Payndx, &
		ll_EventCount, &
		ll_EventRow, &
		ll_findrow, &
		ll_shipndx, &
		ll_itemndx, &
		ll_EventId, &
		lla_shipid[], &
		ll_ShipId, &
		ll_shipcount, &
		ll_itemcount, &
		ll_accesscount, &
		ll_amountcount, &
		j
		
string	ls_FilterString	, &
			ls_amountid

n_ds		lds_PaySplitCache		

n_cst_String			lnv_String
n_cst_beo_shipment	lnva_Shipment[]
n_cst_beo_item			lnva_Item[]
n_cst_beo_event		lnv_event

lds_PaySplitCache = anv_TransactionManager.of_GetPaySplitCache(true)

//this.setredraw(false)

lnv_String.of_Arraytostring(ala_Amountid, ',', ls_amountid)
ls_FilterString = "amountid in ( " + ls_amountid + ") and " + &
						"itemtype = '" + n_cst_constants.cs_ItemType_Accessorial + "'"
						
lds_PaySplitCache.SetFilter(ls_FilterString)
lds_PaySplitCache.filter()
ll_PayCount = lds_PaySplitCache.rowcount()

ll_EventCount = dw_List.RowCount()

//loop thru the amounts and adjust counts for any events in this itinerary
for ll_Payndx = 1 to ll_Paycount
	
	ll_EventId = lds_PaySplitCache.object.eventid[ll_Payndx]
	ll_Eventrow = dw_list.find("de_id = " + string(ll_EventId), 1, ll_EventCount)
	IF ll_EventRow > 0 THEN
		dw_List.Object.accessorial_indicator[ll_EventRow] = ''
		j = dw_List.Object.accessorialcount[ll_EventRow]
		if isnull(j) then
			dw_List.Object.accessorialcount[ll_EventRow] = 1
		else
			dw_List.Object.accessorialcount[ll_EventRow] = &
						dw_List.Object.accessorialcount[ll_EventRow] + 1 
		end if
																
	END IF

next

if isvalid(inv_Itinerary) then
	inv_Itinerary.of_GetShipmentIds ( lla_ShipId, TRUE, TRUE, FALSE )
	ll_ShipCount = inv_itinerary.of_getShipment(lla_ShipId, lnva_Shipment)
end if

//now let's look lor any unlinked or unaccounted for amounts
FOR ll_Shipndx = 1 TO ll_ShipCount
	
	//get the accessorial items
	ll_itemcount = lnva_Shipment[ll_Shipndx].of_GetItemList(lnva_Item, n_cst_constants.cs_ItemType_Accessorial) 
	ll_ShipId = lnva_Shipment[ll_Shipndx].of_GetId()
	
	ls_FilterString = "Shipmentid = " + string(ll_ShipId) + " and " + &
							"itemtype = '" + n_cst_constants.cs_ItemType_Accessorial + "'"
							
	lds_PaySplitCache.SetFilter(ls_FilterString)
	lds_PaySplitCache.filter()
	
	//get the counts for this shipment
	ll_amountcount = lds_PaySplitCache.rowcount()

	ll_accesscount = 0
	
	//get a count of accessorials excluding fuel surcharge
	
	FOR ll_Itemndx = 1 to ll_itemcount
		
		if lnva_Item[ll_Itemndx].of_GetEventTypeFlag () =  n_Cst_Constants.cs_ItemEventType_FuelSurcharge then
			continue
		end if		
		
		CHOOSE CASE lnva_Item[ll_Itemndx].of_GetAccountingType()
				
			CASE n_cst_constants.cs_AccountingType_Billable
				continue
			CASE n_cst_constants.cs_AccountingType_Payable, n_cst_constants.cs_AccountingType_Both 				
				//check category
				CHOOSE CASE lnva_Item[ll_Itemndx].of_GetAmounttypeCategory()
					CASE n_cst_constants.ci_category_receivables
						continue
					CASE n_cst_constants.ci_category_payables, n_cst_constants.ci_category_both
						ll_accesscount ++
				END CHOOSE
				
		END CHOOSE
				
	NEXT
	
	if ll_accesscount = ll_amountcount then 
		//we're done, none unaccounted for
	else
		//WE MAY HAVE TOO MANY AMOUNTS, HOW DO WE LET THE USER KNOW
		
		/*
			if an item is linked to an event and that event has no amount then flag the event
			if an item is unlinked and has no amount then flag the first shipment event in this
			itinerary
		*/
		
		FOR ll_Itemndx = 1 to ll_itemcount
			
			if lnva_Item[ll_Itemndx].of_GetEventTypeFlag () =  n_Cst_Constants.cs_ItemEventType_FuelSurcharge then
				continue
			end if		
			
			//Check accounting type
			CHOOSE CASE lnva_Item[ll_Itemndx].of_GetAccountingType()
					
				CASE n_cst_constants.cs_AccountingType_Billable
					continue
				CASE n_cst_constants.cs_AccountingType_Payable, n_cst_constants.cs_AccountingType_Both 				
					//check category
					choose case lnva_Item[ll_Itemndx].of_GetAmounttypeCategory()
						case n_cst_constants.ci_category_receivables
							continue
						case n_cst_constants.ci_category_payables, n_cst_constants.ci_category_both
							//Is it linked to an event?
							lnva_Item[ll_Itemndx].of_GetPickupevent( lnv_Event )
							if isvalid(lnv_event) then		
								//Does it have an amount?
								ll_EventId = lnv_Event.of_Getid()
								ll_findrow = lds_PaySplitCache.find("eventid = " + string(ll_EventId) + " and " + &
												"itemtype = '" + n_cst_constants.cs_ItemType_Accessorial + "'", 1, ll_PayCount)
								IF ll_findrow > 0 THEN
									//ok
									continue
								else
									//Is the event for this driver?
									ll_Eventrow = dw_list.find("de_id = " + string(ll_EventId), 1, ll_EventCount)
									IF ll_EventRow > 0 THEN
										j = dw_List.Object.accessorialcount[ll_EventRow]
										if isnull(j) then
											dw_List.Object.accessorialcount[ll_EventRow] = 0
										end if
										dw_List.Object.accessorial_indicator[ll_EventRow] = 'A'
												
									else
										//linked but not to this driver and not paid
										//do we need to let the user know this
//										ll_Eventrow = dw_list.find("de_shipment_id = " + string(ll_ShipId), 1, ll_EventCount)
//										IF ll_EventRow > 0 THEN
//											//sets to red
//											j = dw_List.Object.accessorialcount[ll_EventRow]
//											if isnull(j) then
//												dw_List.Object.accessorialcount[ll_EventRow] = 0
//											end if
//											dw_List.Object.accessorial_indicator[ll_EventRow] = 'A'
//										end if	
					
										
									END IF
									
								END IF
															
							else
								//unlinked, mark first event 
								ll_Eventrow = dw_list.find("de_shipment_id = " + string(ll_ShipId), 1, ll_EventCount)
								IF ll_EventRow > 0 THEN
									//sets to red
									j = dw_List.Object.accessorialcount[ll_EventRow]
									if isnull(j) then
										dw_List.Object.accessorialcount[ll_EventRow] = 0
									end if
									dw_List.Object.accessorial_indicator[ll_EventRow] = 'A'
								end if	
							end if
													
					end choose
					
			END CHOOSE
			
		NEXT
	end if
NEXT

lds_PaySplitCache.SetFilter('')
lds_PaySplitCache.filter()

//this.setredraw(true)
end subroutine

public subroutine of_setpaysplitcolumn (n_cst_bso_transactionmanager anv_transactionmanager, long ala_amountid[]);//this is to indicate that freight pay is associated with the events
long	ll_PayCount, &
		ll_EventCount, &
		ll_EventRow, &
		ll_Ndx, &
		ll_PayNdx, &
		ll_ArrayCount, &
		ll_EventId
		
string	ls_FilterString

n_ds	lnv_PaySplitCache

lnv_PaySplitCache = anv_TransactionManager.of_GetPaySplitCache(true)
ll_PayCount = lnv_PaySplitCache.RowCount()
ll_EventCount = dw_List.RowCount()
ll_ArrayCount = upperbound(ala_AmountId)
this.setredraw(false)

IF ll_PayCount > 0 THEN
	FOR ll_Ndx = 1 to ll_ArrayCount
		ls_FilterString = "amountid = " + string(ala_AmountId[ll_Ndx]) + " and " + &
								"itemtype = '" + n_cst_constants.cs_ItemType_Freight + "'"
								
		lnv_PaySplitCache.SetFilter(ls_FilterString)
		lnv_PaySplitCache.filter()

		ll_Paycount = lnv_PaysplitCache.Rowcount()
		
		for ll_Payndx = 1 to ll_paycount
			
			ll_EventId = lnv_PaySplitCache.object.eventid[ll_Payndx]
			ll_EventRow = dw_list.find("de_id = " + string(ll_EventId), 1, ll_EventCount)
			IF ll_EventRow > 0 THEN
				dw_List.Object.processcount[ll_EventRow] = dw_List.Object.processcount[ll_EventRow] + 1 
			END IF
			
		next 
		
	NEXT
END IF

lnv_PaySplitCache.SetFilter('')
lnv_PaySplitCache.filter()

this.setredraw(true)
end subroutine

public function integer of_getpoints (ref long al_originid, ref long al_destinationid);integer	li_ndx, &
			li_MsgCount, &
			li_return = 1

long		ll_origin, &
			ll_destination
			
w_OriginDestinationSelection	lw_Points

s_parm		lstr_parm
n_cst_msg	lnv_Points

//Set points
lnv_Points.of_Reset()
lstr_Parm.is_Label = "ORIGINID"
lstr_Parm.ia_Value = al_OriginId
lnv_Points.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_Label = "DESTINATIONID"
lstr_Parm.ia_Value = al_DestinationId
lnv_Points.of_Add_Parm ( lstr_Parm )

openwithparm ( lw_Points, lnv_Points )

lnv_Points = message.powerobjectparm

if isvalid(lnv_Points) then
	li_MsgCount = 	lnv_Points.of_get_count()
	FOR li_Ndx = 1 to li_MsgCount
		lnv_Points.of_get_parm(li_ndx, lstr_parm)
		
		CHOOSE CASE upper(lstr_parm.is_label)
					
			CASE "ORIGIN"
				ll_origin = lstr_Parm.ia_Value 
				
			CASE "DESTINATION"
				ll_destination = lstr_Parm.ia_Value 
				
		END CHOOSE
	NEXT
	
	if ll_origin > 0 then 
		al_originid = ll_origin
	else
		li_return = -1
	end if
	
	if li_return = 1 then
		if ll_Destination > 0 then
			al_Destinationid = ll_Destination
		else
			li_return = -1
		end if
	end if
		
end if


return li_return

end function

public subroutine of_seteventrow (long al_eventid);long	ll_foundrow

if al_eventid > 0 then
	ll_foundrow = dw_list.find("de_id = " + string(al_eventid), 1, dw_list.rowcount())
	if ll_foundrow > 0 then
		dw_list.scrolltorow( ll_foundrow )
		dw_list.selectrow( 0, false)
		dw_list.selectrow(ll_foundrow, true)
	end if
end if
end subroutine

public function integer of_seteventcounts ();Long	ll_RowCount
Long	ll_Row
Long	ll_EventCount
Long	ll_Shipment
Long	ll_temp

ll_RowCount = dw_list.RowCount ( ) 


FOR ll_Row = 1 TO ll_RowCount
	ll_Temp = dw_list.GetItemNumber ( ll_Row , "de_shipment_id" )
	IF ll_Temp = ll_Shipment THEN
		// use the old value
	ELSE
		// get a new value
		ll_Shipment = ll_Temp
		Select Count ( de_id )
		into :ll_EventCount
		FROM disp_Events
		Where de_Shipment_id = :ll_Shipment;
		
		Commit;
	
	END IF
		
	dw_list.SetItem ( ll_Row , "EventCount" , ll_EventCount )
	
NEXT


RETURN 1


end function

on u_event_bracketing.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_lockblock=create cb_lockblock
this.dw_items=create dw_items
this.dw_list=create dw_list
this.st_1=create st_1
this.cb_block=create cb_block
this.cb_dwn=create cb_dwn
this.cb_up=create cb_up
this.cb_clear=create cb_clear
this.cb_autoblock=create cb_autoblock
this.cb_clearall=create cb_clearall
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_lockblock
this.Control[iCurrent+3]=this.dw_items
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_block
this.Control[iCurrent+7]=this.cb_dwn
this.Control[iCurrent+8]=this.cb_up
this.Control[iCurrent+9]=this.cb_clear
this.Control[iCurrent+10]=this.cb_autoblock
this.Control[iCurrent+11]=this.cb_clearall
end on

on u_event_bracketing.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_lockblock)
destroy(this.dw_items)
destroy(this.dw_list)
destroy(this.st_1)
destroy(this.cb_block)
destroy(this.cb_dwn)
destroy(this.cb_up)
destroy(this.cb_clear)
destroy(this.cb_autoblock)
destroy(this.cb_clearall)
end on

event constructor;
of_SetResize(TRUE)
inv_resize.of_Register (dw_items, 'FixedtoBottom&ScaleToRight')
inv_resize.of_Register (dw_List, 'Scaletoright&Bottom')

end event

type st_2 from statictext within u_event_bracketing
integer x = 1330
integer y = 52
integer width = 1573
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Page Up/ Page Down to Next Unprocessed (white) Row"
boolean focusrectangle = false
end type

type cb_lockblock from commandbutton within u_event_bracketing
integer x = 558
integer y = 24
integer width = 293
integer height = 92
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Lock"
end type

event clicked;dw_list.SetReDraw(FALSE)

IF THIS.text = cs_lock_button_text  THEN
	cb_block.TriggerEvent(clicked!)
	if parent.of_Lockblock(true) < 0 then
		cb_clear.TriggerEvent(clicked!)
	end if 
ELSE
	parent.of_LockBlock(FALSE)
END IF

dw_list.SetFocus()

dw_list.SetReDraw(TRUE)
parent.triggerevent('ue_LockBlock')

end event

type dw_items from u_dw within u_event_bracketing
integer x = 14
integer y = 1356
integer width = 3122
integer height = 556
integer taborder = 0
string dataobject = "d_interactiveitems"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;THIS.SetTransObject (  sqlca ) 

n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( THIS )

n_cst_Presentation_AmountType	lnv_amountpresentation
n_cst_licensemanager				lnv_licensemanager

lnv_amountpresentation.of_setcategory(n_cst_constants.ci_category_receivables)
lnv_amountpresentation.of_setPresentation ( this )

String	ls_CodeTable

ls_CodeTable = &
	"BILLABLE~t" + n_cst_constants.cs_accountingtype_billable + "/"+&
	"PAYABLE~t" + n_cst_constants.cs_accountingtype_payable + "/"+&
	"BOTH~t" + n_cst_constants.cs_accountingtype_both + "/"
	
	
This.Modify ( "accountingtype.Edit.CodeTable = Yes	accountingtype.Values = '" +  ls_CodeTable+ "' accountingtype.ddlb.allowedit=no accountingtype.ddlb.UseAsBorder=no accountingtype.ddlb.case=upper accountingtype.ddlb.autohscroll=yes accountingtype.ddlb.vscrollbar=no " )             
//This.Modify ( "accountingtype.Edit.CodeTable = Yes	accountingtype.Values = '" +  ls_CodeTable+ "' accountingtype.ddlb.allowedit=no accountingtype.ddlb.UseAsBorder=no accountingtype.ddlb.case=upper accountingtype.ddlb.autohscroll=yes accountingtype.ddlb.vscrollbar=yes " )             


end event

type dw_list from u_dw within u_event_bracketing
event ue_processkey pbm_dwnkey
event type integer ue_showmenu ( string as_column )
event ue_showamounts ( )
event ue_hideamounts ( )
event ue_eventchanged ( )
event ue_displaypoints ( long al_eventid )
integer x = 14
integer y = 144
integer width = 3122
integer height = 1204
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_interactive_itin"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event ue_processkey;Long		ll_Return, &
			ll_row, &
			ll_foundrow
		

CHOOSE CASE Key 
	CASE keyapps!	
		if this.getrow() > 0 then
			this.event ue_showmenu('')		
		end if

		ll_Return = 0

	CASE keydownarrow! , keyuparrow!
		
	CASE keypagedown!
		
		ll_row = this.getrow()
		
		if ll_row > 0 then
			ll_FoundRow = dw_list.find("processcount = 0",ll_row,dw_List.RowCount())
		end if
		
		IF ll_FoundRow > 0 THEN
			this.post ScrollToRow(ll_FoundRow)
			this.post selectrow(0,false)
			this.post selectrow(ll_foundrow, true)
		END IF
			
	CASE keypageup!
		
		ll_row = this.getrow()
		if ll_row > 0 then
			ll_FoundRow = dw_list.find("processcount = 0",ll_row, 1)
		end if
		
		IF ll_FoundRow > 0 THEN
			this.post ScrollToRow(ll_FoundRow)
			this.post selectrow(0,false)
			this.post selectrow(ll_foundrow, true)
		END IF
		
	CASE keytab!
		
	CASE keyenter!
		
		if this.GetSelectedrow(0) > 0 then
			cb_lockblock.event clicked()
			
//			IF cb_lockblock.text = cs_lock_button_text  THEN
//				cb_lockblock.event clicked()
//				this.post selectrow(0, false)
//			end if
		end if
		
	CASE ELSE

			
END CHOOSE

RETURN ll_Return 

end event

event type integer ue_showmenu(string as_column);integer	li_return, &
			li_ndx, &
			li_num_labels, &
			li_num_values

long		ll_row, &
			ll_CompanyId, &
			ll_shipmentid, &
			ll_eventId

any		laa_Parm_Values[]		

string	ls_PopRtn, &
			lsa_parm_labels[]
	
n_cst_AnyArraySrv	lnv_anyarray	
s_parm				lstr_parm
s_anys 				lstr_open
n_cst_msg			lnv_MSG
n_cst_numerical lnv_numerical
w_dispatch 			lw_dispatch
w_company			lw_company
w_Frame				lw_Frame
n_cst_AppServices		lnv_AppServices
n_cst_bso_ImageManager_Pegasus	lnv_ImageManager


lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Display &Shipment"

lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "&Imaging"

lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "View &Notes"

lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
		
lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Company &Details"

lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "&Company Info"
	
if this.object.lockblock[this.getrow()] = 'Y' then
	lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
				
	lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Origin/Destination Points"
	
end if

lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
			
lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Show Ite&ms"
	
lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Hide I&tems"


lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
			
lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Show Linked &Amounts"
	
lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "&Hide Linked Amounts"
	
ls_PopRtn = f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )

if Len ( ls_PopRtn ) > 0 then

	ll_shipmentid = 0
	ll_companyid = 0
	ll_shipmentid = this.getitemnumber(this.getrow(), 'de_shipment_id')
	ll_CompanyId = this.getitemnumber(this.getrow(), "de_site")
	ll_eventId = this.getitemnumber(this.getrow(), "de_id")
	
	CHOOSE CASE ls_PopRtn
			
		CASE "DISPLAY SHIPMENT"
			
			if ll_shipmentid > 0 then
				lstr_Parm.is_Label = "CATEGORY"
				lstr_Parm.ia_Value = "SHIP"
				lnv_msg.of_Add_Parm ( lstr_Parm ) 		
				
				lstr_Parm.is_Label = "ID"
				lstr_Parm.ia_Value = ll_shipmentid
				lnv_msg.of_Add_Parm ( lstr_Parm ) 
				
				lstr_open.anys[1] = "SHIP"
				lstr_open.anys[2] = ll_shipmentid
				
				opensheetwithparm(lw_dispatch, lnv_msg, lnv_AppServices.of_GetFrame ( ), 0, Layered!)
			end if
			
		CASE "IMAGING"
			
			if ll_shipmentid > 0 then
				lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
				lnv_ImageManager.of_ViewImages ( "SHIPMENT" , { ll_shipmentid } , 1)
				DESTROY lnv_ImageManager
			end if
			
		CASE "VIEW NOTES"
			
			if ll_shipmentid > 0 then
				lstr_Parm.is_Label = "TARGET_ID"
				lstr_Parm.ia_Value = ll_shipmentid
				lnv_msg.of_Add_Parm ( lstr_Parm ) 
			
				OpenWithParm( w_NoteShower, lnv_msg)
			end if
			
		CASE "COMPANY DETAILS"	
			
			if ll_companyid > 0 then
				lstr_Parm.is_Label = "ID"
				lstr_Parm.ia_Value = this.getitemnumber(this.getrow(), "de_site")
				lnv_Msg.of_Add_Parm ( lstr_Parm )
			
				OpenWithParm ( w_CompanyDetail, lnv_Msg )
			end if

		CASE "COMPANY INFO"
			
			if ll_companyid > 0 then
				lw_Frame = lnv_AppServices.of_GetFrame ( )
				opensheetwithparm(lw_company, ll_companyid, lw_Frame, 0, original!)
			end if
			
		CASE "ORIGIN/DESTINATION POINTS"
			
			this.event ue_displaypoints( ll_eventid)
			
		CASE "SHOW ITEMS"
			
			this.event ue_hideamounts()
			PARENT.Event ue_showitems(true)

		CASE "HIDE ITEMS"
			
			PARENT.Event ue_showitems(false)			
			
		CASE "SHOW LINKED AMOUNTS"
			
			PARENT.Event ue_showitems(false)			
			this.event ue_showamounts()

		CASE "HIDE LINKED AMOUNTS"
			
			this.event ue_hideamounts()
			
	end choose
	
end if

return li_return
end event

event ue_showamounts();//get the selected row and pass event id

long	lla_event[], &
		ll_row

ll_row = this.GetSelectedrow( 0 )
if ll_row > 0 then
	lla_event[1] = this.object.de_id[ll_row]
	parent.event ue_showAmounts(lla_event)
end if
end event

event ue_hideamounts();parent.event ue_hideAmounts()
end event

event ue_eventchanged();//get the selected row and pass event id

long	lla_event[], &
		ll_row

ll_row = this.GetSelectedrow( 0 )
if ll_row > 0 then
	lla_event[1] = this.object.de_id[ll_row]
	parent.event ue_eventchanged(lla_event)
end if
end event

event ue_displaypoints(long al_eventid);/*
	
*/
long	ll_ndx, &
		ll_count, &
		lla_Eventid[], &
		ll_null, &
		ll_Origin, &
		ll_Destination
		
n_cst_eventblock	lnva_EventBlock[], &
						lnv_EventFound
n_cst_AnyArraySrv	lnv_ArraySrv

setnull(ll_null)
ll_count = parent.of_GetEventBlock(lnva_EventBlock)

For ll_ndx = 1 to ll_count
	//is the event part of a locked block
	
	lnva_EventBlock[ll_ndx].of_GetEventIdList(lla_Eventid)
	if lnv_ArraySrv.of_find(lla_EventId, al_eventid, ll_null, ll_null) > 0 then
		//found it
		lnv_EventFound = lnva_EventBlock[ll_ndx]
		exit
	end if
next

if isvalid(lnv_EventFound) then
	
	ll_Origin = lnv_EventFound.of_GetOriginId()
	ll_Destination = lnv_EventFound.of_GetDestinationId()
	
	if Parent.of_Getpoints( ll_origin, ll_Destination) = 1 then
		if ll_origin > 0 or ll_Destination >= 0 then
			//reset points
			lnv_EventFound.of_SetOriginId(ll_Origin)
			lnv_EventFound.of_SetDestinationId(ll_Destination)
		end if
	END IF								
	
end if
		
	
end event

event constructor;// enable multi-row-select-ability
THIS.of_SetRowSelect ( TRUE ) 
inv_rowselect.of_SetStyle (2) //2 = extended row select service

of_setinsertable ( FALSE )
of_setDeleteable ( FALSE )

of_SetAutoSort ( FALSE )

THIS.SetTransObject (  sqlca ) 

n_cst_Events	lnv_Events

//n_cst_Dws		lnv_Dws
//lnv_Dws.of_CreateHighlight ( This )

This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
	

n_cst_Presentation_Shipment	lnv_Presentation

lnv_Presentation.of_SetPresentation ( This )

	
end event

event rowfocuschanged;call super::rowfocuschanged;long	lla_Selected[], &
		lla_SelectedEvents[], &
		ll_SelectedEventCount, &
		ll_SelectedShipCount, &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_RowCount		

string	ls_Ids, &
			ls_Filter
			
boolean	lb_LockedRow, &
			lb_UnlockedRow
			
n_cst_string	lnv_string

//changed text of Lock Block button based on status of currentrow
IF currentrow > 0 THEN
//	if ib_lockfeatureon then
		parent.of_LockBlockButtonText ( currentrow )
//	end if
END IF
lla_SelectedEvents = this.object.de_id.selected
ll_SelectedEventCount = upperbound ( lla_SelectedEvents )

IF ll_SelectedEventCount > 0 THEN
	
	//Disable cb_lockblock if mixed locked and unlocked rows
	ll_RowCount = this.RowCount()

	ll_SelectedStartRow = this.Find ( "de_id = " + String ( lla_SelectedEvents [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = this.Find ( "de_id = " + String ( lla_SelectedEvents [ll_SelectedEventCount] ), 1, ll_RowCount )

	IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow, ll_SelectedEndRow ) > 0 THEN
		lb_LockedRow = TRUE
	END IF
	IF dw_List.Find ( "lockblock = 'N' or isnull(lockblock) " , ll_SelectedStartRow, ll_SelectedEndRow ) > 0 THEN
		lb_UnlockedRow = TRUE
	END IF
//	if ib_lockfeatureon then
		IF ll_SelectedEventCount > 1 THEN
			IF lb_LockedRow and lb_UnlockedRow THEN
				cb_lockblock.enabled = FALSE
			ELSE
				cb_lockblock.enabled = TRUE
			END IF
		ELSE
			cb_lockblock.enabled = TRUE
		END IF
//	end if
	lla_Selected = this.object.de_shipment_id.selected
	ll_SelectedShipCount = upperbound ( lla_Selected )
	
	IF ll_SelectedShipCount > 0 THEN
		lnv_string.of_ArraytoString ( lla_Selected, ',', ls_ids)
		IF len ( trim ( ls_ids) ) > 0 THEN
			ls_Filter = 'di_shipment_id in ( ' + ls_ids + ' )'
			dw_items.SetFilter ( ls_Filter )
			dw_Items.Filter ( )
			dw_Items.Sort ( )
		END IF
	END IF
	
END IF

this.event ue_eventchanged()
end event

event getfocus;call super::getfocus;THIS.BORDERSTYLE=STYLELOWERED!
if this.getselectedrow(0) > 0 then
	//already selected
else
	long	ll_row
	
	ll_row = this.getrow()
	if ll_row > 0 then 
		//ok
	else
		ll_row = 1
	end if
	
	this.selectrow(ll_row, true)
	
end if
end event

event losefocus;THIS.BORDERSTYLE=STYLERAISED!
//this.selectrow(0, false)
end event

event doubleclicked;//parent.EVENT ue_showpaysplit()

long	ll_id

n_cst_ShipmentManager	lnv_ShipmentManager

IF Row > 0 THEN

	ll_id = this.Object.de_shipment_Id [ Row ]
	
	if ll_id > 0 then
		lnv_ShipmentManager.of_OpenShipment ( ll_id )
	end if

END IF
end event

event clicked;call super::clicked;long	ll_shipmentid

s_parm		lstr_parm
n_cst_msg	lnv_msg

IF Row > 0 THEN
	IF dwo.Name = "p_note" THEN
		ll_shipmentid = this.getitemnumber(this.getrow(), 'de_shipment_id')
		if ll_shipmentid > 0 then
			lstr_Parm.is_Label = "TARGET_ID"
			lstr_Parm.ia_Value = ll_shipmentid
			lnv_msg.of_Add_Parm ( lstr_Parm ) 
		
			OpenWithParm( w_NoteShower, lnv_msg)
			
		end if
	END IF	
END IF
end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case "paysplit"
		//update paysplitcache
end choose
end event

event rbuttondown;call super::rbuttondown;IF row > 0 THEN
	
	this.event ue_showmenu(dwo.name)

END IF


end event

type st_1 from statictext within u_event_bracketing
integer x = 5
integer y = 40
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Selected &Event(s):"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_block from commandbutton within u_event_bracketing
boolean visible = false
integer x = 3255
integer y = 536
integer width = 242
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Block"
end type

event clicked;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_Return
		
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )

IF ll_SelectedRowCount > 0 THEN
	ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )
	
	IF ll_SelectedRowCount = 1 THEN
		dw_list.object.bracket_type[ll_SelectedStartRow] = 'TOPANDBOTTOM'		
	ELSE
		//make sure that none of the selected rows are part of a Locked Block
//		IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow, ll_SelectedEndRow ) > 0 THEN
//			messagebox("Merge", "You can't merge any part of a locked block")
//			ll_Return = -1
//		END IF
	
		IF ll_Return = 0 THEN
			FOR ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
				
				CHOOSE CASE ll_RowNdx
						
					CASE ll_SelectedStartRow 	//Top row
		
						//let's change the prior row first based on this row's bracket type
						CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx]
							CASE 'TOP', 'TOPANDBOTTOM'
								//Prior row must be a BOTTOM or TOPANDBOTTOM bracket
								//No change necessary
								
							CASE 'BOTTOM', 'NONE'
								IF dw_list.object.bracket_type[ll_RowNdx - 1] = 'TOP' THEN
									dw_list.object.bracket_type[ll_RowNdx - 1] = 'TOPANDBOTTOM'
								ELSE
									dw_list.object.bracket_type[ll_RowNdx - 1] = 'BOTTOM'
								END IF
											
						END CHOOSE	
		
						dw_list.object.bracket_type[ll_RowNdx] = 'TOP'
						
					CASE ll_SelectedEndRow 	//BOTTOM ROW
						//let's change the NEXT row first based on this row's bracket type
						CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx]
							CASE 'TOPANDBOTTOM'
								//No change necessary
		
							CASE 'NONE'
								dw_list.object.bracket_type[ll_RowNdx + 1] = 'TOP'
								
							CASE 'TOP' 
								IF dw_list.object.bracket_type[ll_RowNdx + 1] = 'BOTTOM' THEN
									dw_list.object.bracket_type[ll_RowNdx + 1] = 'TOPANDBOTTOM'
								ELSE
									dw_list.object.bracket_type[ll_RowNdx + 1] = 'TOP'
								END IF
							
							CASE 'BOTTOM'
								//No change necessary									
		
						END CHOOSE	
		
						dw_list.object.bracket_type[ll_RowNdx] = 'BOTTOM'		
		
					CASE ELSE	//in between rows
						dw_list.object.bracket_type[ll_RowNdx] = 'NONE'
						
				END CHOOSE		
					
			NEXT
			
		END IF
	END IF
	
	dw_list.GroupCalc ( )
	dw_list.ScrollToRow ( ll_SelectedStartRow )
	//reselect rows
	for ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
		dw_list.Selectrow(ll_RowNdx, true)
	next

ELSE
	//not enough rows to merge
	
END IF

dw_list.SetFocus()


end event

type cb_dwn from u_cb within u_event_bracketing
boolean visible = false
integer x = 3392
integer y = 156
integer width = 169
integer taborder = 0
boolean bringtotop = true
integer weight = 400
string text = "&Dwn"
end type

event clicked;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_Return
		
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )

IF ll_SelectedRowCount > 1 THEN

	ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

	//make sure that none of the selected rows are part of a Locked Block
	IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow, ll_SelectedEndRow ) > 0 THEN
		messagebox("Move", "You can't move any part of a locked block")
		ll_Return = -1
	ELSE
		IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow + 1, ll_SelectedStartRow + 1 ) > 0 THEN
			messagebox("Move", "You cant't move into a locked block")
			ll_Return = -1
		END IF
	END IF
	
	IF ll_Return = 0 THEN
		FOR ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
			
			CHOOSE CASE ll_RowNdx
					
				CASE ll_SelectedStartRow 	//Top row
					CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx]
						CASE 'TOP'
							//Already part of a block, no change necessary
						
						CASE 'TOPANDBOTTOM'
							
						CASE 'BOTTOM', 'NONE'
							//Next row must be a top bracket
							dw_list.object.bracket_type[ll_RowNdx + 1] = 'NONE'
							CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx - 1]
								CASE 'TOP' 
									dw_list.object.bracket_type[ll_RowNdx - 1] = 'TOPANDBOTTOM'
								CASE 'NONE'
									dw_list.object.bracket_type[ll_RowNdx - 1] = 'BOTTOM'
							END CHOOSE
								
					END CHOOSE	
					
					dw_list.object.bracket_type[ll_RowNdx] = 'TOP'
				
				CASE ll_SelectedEndRow 	//BOTTOM ROW
					CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx]
						CASE 'TOP' , 'TOPANDBOTTOM', 'NONE'
							dw_list.object.bracket_type[ll_RowNdx] = 'BOTTOM'
							IF dw_list.object.bracket_type[ll_RowNdx + 1] = 'BOTTOM' THEN
								dw_list.object.bracket_type[ll_RowNdx + 1] = 'TOPANDBOTTOM'
							ELSE
								dw_list.object.bracket_type[ll_RowNdx + 1] = 'TOP'
							END IF
						
						CASE 'BOTTOM'
							dw_list.object.bracket_type[ll_RowNdx] = 'NONE'
							CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx + 1]
								CASE 'TOP'
									dw_list.object.bracket_type[ll_RowNdx + 1] = 'NONE'
								CASE 'TOPANDBOTTOM'
									dw_list.object.bracket_type[ll_RowNdx + 1] = 'BOTTOM'
							END CHOOSE					
										
					END CHOOSE	
					
				CASE ELSE	//in between rows
					dw_list.object.bracket_type[ll_RowNdx] = 'NONE'
					
			END CHOOSE		

				
		NEXT
		
	END IF
	
ELSE
	ll_SelectedStartRow = dw_list.GetRow()
	IF ll_SelectedStartRow > 0 THEN
		IF ll_SelectedStartRow = ll_RowCount THEN
			//Already at the bottom, No move necessary
		ELSE
			
				//make sure that none of the selected rows are part of a Locked Block
				IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow,  ll_SelectedStartRow) > 0 THEN
					messagebox("Move", "You can't move any part of a locked block")
					ll_Return = -1
				ELSE
					IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow + 1, ll_SelectedStartRow  + 1 ) > 0 THEN
						messagebox("Move", "You cant't move into a locked block")
						ll_Return = -1
					END IF
				END IF
			
			IF ll_Return = 0 THEN
				CHOOSE CASE dw_list.object.bracket_type[ll_SelectedStartRow]
					CASE 'TOP', 'NONE' 
						//Already part of a block, no move necessary
						
					CASE 'BOTTOM'
						//Next row must be a top bracket
						dw_list.object.bracket_type[ll_SelectedStartRow] = 'TOP'
						CHOOSE CASE dw_list.object.bracket_type[ll_SelectedStartRow - 1]
							CASE 'NONE' 
								dw_list.object.bracket_type[ll_SelectedStartRow - 1] = 'BOTTOM'
							CASE 'TOP'
								dw_list.object.bracket_type[ll_SelectedStartRow - 1] = 'TOPANDBOTTOM'
						END CHOOSE
						
						CHOOSE CASE dw_list.object.bracket_type[ll_SelectedStartRow + 1]
							CASE 'TOP'
								dw_list.object.bracket_type[ll_SelectedStartRow + 1] = 'NONE'
							CASE 'TOPANDBOTTOM'
								dw_list.object.bracket_type[ll_SelectedStartRow + 1] = 'BOTTOM'
						END CHOOSE
						
					CASE 'TOPANDBOTTOM'
						//Next row must be a BOTTOM bracket
						dw_list.object.bracket_type[ll_SelectedStartRow] = 'TOP'						
						CHOOSE CASE dw_list.object.bracket_type[ll_SelectedStartRow + 1]
							CASE 'TOPANDBOTTOM' 
								dw_list.object.bracket_type[ll_SelectedStartRow + 1] = 'BOTTOM'
							CASE 'TOP'
								dw_list.object.bracket_type[ll_SelectedStartRow + 1] = 'NONE'
						END CHOOSE
		
				END CHOOSE	
				
			END IF
			
		END IF
		
	END IF
	
END IF

dw_list.GroupCalc ( )
dw_list.ScrollToRow ( ll_SelectedStartRow )
	
dw_list.SetFocus()
	
end event

type cb_up from u_cb within u_event_bracketing
boolean visible = false
integer x = 3200
integer y = 156
integer width = 169
integer taborder = 0
boolean bringtotop = true
integer weight = 400
string text = "&Up"
end type

event clicked;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_Return
		
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )

IF ll_SelectedRowCount > 1 THEN

	ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

	//make sure that none of the selected rows are part of a Locked Block
	IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow, ll_SelectedEndRow ) > 0 THEN
		messagebox("Move", "You can't move any part of a locked block")
		ll_Return = -1
	ELSE
		IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow - 1, ll_SelectedStartRow -1 ) > 0 THEN
			messagebox("Move", "You cant't move into a locked block")
			ll_Return = -1
		END IF
	END IF

	IF ll_Return = 0 THEN
		
		FOR ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
			
			CHOOSE CASE ll_RowNdx
					
				CASE ll_SelectedStartRow 	//Top row
					CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx]
						CASE 'TOP', 'TOPANDBOTTOM'
							//Prior row must be a BOTTOM bracket
							dw_list.object.bracket_type[ll_RowNdx - 1] = 'NONE'
							
						CASE 'BOTTOM', 'NONE'
							//Already part of a block, no move necessary
										
					END CHOOSE	
	
					dw_list.object.bracket_type[ll_RowNdx] = 'NONE'
					
				CASE ll_SelectedEndRow 	//BOTTOM ROW
					CHOOSE CASE dw_list.object.bracket_type[ll_RowNdx]
						CASE 'TOP' , 'TOPANDBOTTOM', 'NONE'
							dw_list.object.bracket_type[ll_RowNdx] = 'BOTTOM'
							IF dw_list.object.bracket_type[ll_RowNdx + 1] = 'BOTTOM' THEN
								dw_list.object.bracket_type[ll_RowNdx + 1] = 'TOPANDBOTTOM'
							ELSE
								dw_list.object.bracket_type[ll_RowNdx + 1] = 'TOP'
							END IF
						
						CASE 'BOTTOM'
							//Already part of a block, no move necessary
										
					END CHOOSE	
					
				CASE ELSE	//in between rows
					dw_list.object.bracket_type[ll_RowNdx] = 'NONE'
					
			END CHOOSE		
				
		NEXT
	END IF
	
ELSE
	ll_SelectedStartRow = dw_list.GetRow()
	IF ll_SelectedStartRow > 0 THEN
		IF ll_SelectedStartRow = 1 THEN
			//Already at the top, No move necessary
		ELSE
			
			//make sure that none of the selected rows are part of a Locked Block
			IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow,  ll_SelectedStartRow) > 0 THEN
				messagebox("Move", "You can't move any part of a locked block")
				ll_Return = -1
			ELSE
				IF dw_List.Find ( "lockblock = 'Y'" , ll_SelectedStartRow - 1, ll_SelectedStartRow -1 ) > 0 THEN
					messagebox("Move", "You cant't move into a locked block")
					ll_Return = -1
				END IF
			END IF
			
			IF ll_Return = 0 THEN			
				CHOOSE CASE dw_list.object.bracket_type[ll_SelectedStartRow]
					CASE 'TOP', 'TOPANDBOTTOM'
						//Prior row must be a BOTTOM bracket or TOPANDBOTTOM
						IF dw_list.object.bracket_type[ll_SelectedStartRow - 1] = 'TOPANDBOTTOM' THEN
							dw_list.object.bracket_type[ll_SelectedStartRow - 1] = 'TOP'
						ELSE
							dw_list.object.bracket_type[ll_SelectedStartRow - 1] = 'NONE'
						END IF
						
						IF dw_list.object.bracket_type[ll_SelectedStartRow] = 'TOP' THEN
							// next row for TOP only
							IF dw_list.object.bracket_type[ll_SelectedStartRow + 1] = 'BOTTOM' THEN
								dw_list.object.bracket_type[ll_SelectedStartRow + 1] = 'TOPANDBOTTOM'
							ELSE
								//MUST BE A NONE
								dw_list.object.bracket_type[ll_SelectedStartRow + 1] = 'TOP'
							END IF
						END IF
						
						dw_list.object.bracket_type[ll_SelectedStartRow] = 'BOTTOM'		
						
					CASE 'BOTTOM', 'NONE'
						//Already part of a block, no move necessary
											
				END CHOOSE
			END IF
		END IF
	END IF
END IF

dw_list.GroupCalc ( )
dw_list.ScrollToRow ( ll_SelectedStartRow )
dw_list.SetFocus()


end event

type cb_clear from commandbutton within u_event_bracketing
integer x = 887
integer y = 24
integer width = 242
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Clear"
end type

event clicked;long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount
		
ll_RowCount=dw_list.RowCount()
ll_RowCount = dw_list.RowCount()
lla_Selected = dw_list.object.de_id.selected
ll_SelectedRowCount = upperbound ( lla_Selected )

if ll_SelectedRowCount > 0 then
	ll_SelectedStartRow = dw_List.Find ( "de_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
	ll_SelectedEndRow = dw_List.Find ( "de_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )
	for ll_RowNdx = ll_SelectedStartRow to ll_SelectedEndRow
		dw_list.object.bracket_type[ll_RowNdx]=''
		dw_list.object.lockblock[ll_RowNdx]=''
	next
end if	

end event

type cb_autoblock from commandbutton within u_event_bracketing
boolean visible = false
integer x = 3200
integer y = 284
integer width = 366
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Auto Block"
end type

event clicked;string	lsa_brackets[]

parent.of_SetInitialBrackets(lsa_brackets)
end event

type cb_clearall from commandbutton within u_event_bracketing
boolean visible = false
integer x = 3159
integer y = 404
integer width = 425
integer height = 92
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cl&ear Blocks"
end type

event clicked;long	ll_RowCount, &
		ll_RowNdx

ll_RowCount = dw_list.RowCount()
for ll_RowNdx = 1 to ll_RowCount
	dw_list.object.bracket_type[ll_RowNdx] = ''
next
end event

