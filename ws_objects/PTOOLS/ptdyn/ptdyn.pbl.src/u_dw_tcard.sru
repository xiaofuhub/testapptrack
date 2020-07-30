$PBExportHeader$u_dw_tcard.sru
forward
global type u_dw_tcard from u_dw
end type
end forward

global type u_dw_tcard from u_dw
string dragicon = "Asterisk!"
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
event type string ue_getcategory ( )
event type string ue_getidcolumn ( )
event type boolean ue_istcard ( )
event type integer ue_getitinassignment ( long al_row,  ref integer ai_itintype,  ref long al_itinid )
event ue_removerowfromfilter ( )
event ue_clearwatchlist ( )
event ue_savewatchlist ( )
event ue_keydown pbm_dwnkey
event ue_seticon ( )
end type
global u_dw_tcard u_dw_tcard

type variables
PUBLIC:

Window 	iw_parent
Boolean	ib_isWatchlist			//enables menu item


end variables

forward prototypes
public function integer of_setparentwindow (window aw_parent)
public function window of_getparentwindow ()
public function integer of_watchlistlogic (dragobject adrg_source, long al_row, dwobject adwo_dwo)
public subroutine of_setwatchlist ()
public function boolean of_iswatchlist ()
public function integer of_getidcolumn ()
end prototypes

event type string ue_getcategory();//meant to be overridden by descendents
return ""
end event

event type string ue_getidcolumn();//used to be overriden by ancestors, modified to eliminate this
//now the unique id column is always the first column
return "#1"
end event

event type boolean ue_istcard();//Intended to be called using triggerevent to determine whether a given object is a Tcard.

RETURN TRUE
end event

event type integer ue_getitinassignment(long al_row, ref integer ai_itintype, ref long al_itinid);//To be implemented by descendants

//Returns by reference the ItinType and ItinId of the requested al_Row (or the current row if al_row is null)
//Returns : 1 (Success, value determined and passed out by ref), 0 (Does not apply to this Tcard), -1 (Error)

RETURN 0
end event

event ue_removerowfromfilter();//The following removes the current row id from the filter, removing the item from the 
//watchlist.
Long		ll_posOpenParenth 
Int		li_max
Int		li_index
Int		li_index2

Long		ll_posCloseParenth
Long		ll_currentRow
Long		ll_itemStringLength

String 		ls_uniqueColName
String		ls_uniqueId
String		ls_filter
String		ls_ids
String		ls_next
String		ls_newFilter

String		lsa_ids[]
String		lsa_ids2[]

Boolean		lb_removed

n_cst_string lnv_arrayService


	

IF this.of_isWatchList() AND this.rowCount() > 0  THEN
	
	ll_currentRow = this.getRow()
	
	IF ll_currentRow > 0 THEN
		ls_uniqueColName = "#1"
		ls_uniqueId = string(this.getItemNumber(ll_currentRow , 1))

		li_index2 = 0
		ls_filter = this.describe("datawindow.table.filter")
		ls_filter = trim(ls_filter)
		
		//gets the list of ids from within the parenthesis as a string,
		//then it removes the value that needs to be removed,
		//then puts it into an array with spaces in it called lsa_ids
		ll_posOpenParenth = pos(ls_filter, "(" )
		ll_posCloseParenth = pos(ls_filter, ")" )
		
		//position count inside of the parenthesis exclusive
		ll_itemStringLength = (ll_posCloseParenth - ll_posOpenParenth) -1
		ls_ids = mid(ls_filter, ll_posOpenParenth+1, ll_itemStringLength )
		
		//ls_ids = Replace ( ls_ids, pos(ls_ids, ls_uniqueId), len(ls_uniqueId), "" )
		lnv_arrayService.of_parseToArray(ls_ids, "," , lsa_ids )
		li_max = upperBound(lsa_ids)
		
		ls_ids = ""
		
		//rebuild id string from array
		for li_index = 1 to li_max

			//if we want to add the item then put it into the new array
			IF  ls_uniqueId <> trim(lsa_ids[li_index]) THEN		
				li_index2++
				lsa_ids2[li_index2] = trim(lsa_ids[li_index])

			END IF
			
		next
		
		li_max = upperBOund(lsa_ids2)
		FOR li_index = 1 TO li_index2
			ls_ids += trim(lsa_ids2[li_index])						
			
			IF (li_index) < li_max  THEN
				ls_next = trim(lsa_ids2[li_index+1])		//next result in array
				
				IF  trim(lsa_ids2[li_index]) <> ""  AND ls_next <> ")" THEN
					ls_ids += ", "
					
				END IF
			END IF
		NEXT
		
		IF li_max = 0 THEN
			ls_ids = ""
		END IF
		
		//build the new filter if there are still some ids, otherwise
		//display nothing
		IF len(ls_ids) > 0 THEN
			ls_newFilter = Mid(ls_filter, 1, ll_posOpenParenth)
			ls_newFilter = ls_newFilter + ls_ids 
			IF pos(ls_newFilter, ")") =0 THEN
				ls_newFilter = ls_newFilter + " )"
			END IF
		ELSE
			//display nothing
			ls_newFilter = "4=3"
		END IF
		
		
		this.setFilter(ls_newfilter)
		
		this.Filter()
		this.Sort()
			
	
		
	END IF	
END IF


end event

event ue_clearwatchlist();//Watchlist logic checks for a filter where the expression is always false to clear it.
IF this.of_isWatchlist( ) THEN
	this.setFilter("4=3")
	this.filter()
END IF
end event

event ue_savewatchlist();//This function saves the watchlist filter as a user setting.
String	ls_filter
String	ls_myclassName

ls_myclassName = this.classname()
IF isValid( inv_myPropManager ) AND this.of_isWatchlist( ) THEN	
	ls_filter = this.describe( "datawindow.table.filter")
	IF ls_filter <> "?" AND ls_filter <> "!" THEN
		inv_myPropManager.of_saveToMode(1/*save user setting*/, is_ObjectName, il_instanceNum, is_parentName, "filter", ls_filter, ls_myClassName, cs_myType)
	end if
	
END IF
end event

event ue_keydown;IF ib_isWatchlist THEN
	IF KeyDown (KeyDelete!) THEN
		this.event ue_removerowfromfilter( )
	END IF
END IF

end event

public function integer of_setparentwindow (window aw_parent);/***************************************************************************************
NAME: 			of_setParentWindow

ACCESS:			public
		
ARGUMENTS: 		
							(window)

RETURNS:			integer
	
DESCRIPTION:	If the window is not valid, then set it and return 1
	If the window already exists then return 0
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : dan and maury	7-29-05
	

***************************************************************************************/



IF NOT isValid(iw_parent) THEN
	iw_parent = aw_parent
	return 1
ELSEIF iw_parent = aw_parent THEN
	return 0
ELSE 
	return -1
END IF
end function

public function window of_getparentwindow ();return iw_parent
end function

public function integer of_watchlistlogic (dragobject adrg_source, long al_row, dwobject adwo_dwo);/***************************************************************************************
NAME: 		of_watchlistlogic	

ACCESS:		public	
		
ARGUMENTS: 		
							(dragobject , long, dwobject)

RETURNS:			integer
	
DESCRIPTION:	 the following is only relevent to Tcards, but is relevent to all
 tcards that could potentially be watchlists.  All decendents of tcards
 can be watchlists.  But the dragservice  is on u_dw and doesn't necessarily
 handle drag drop specific of watchlists.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : dan and maury 7-29-05
	

***************************************************************************************/

String 		ls_filter
String 		ls_thisCat
String 		ls_sourceCat
String 		ls_uniqueId
String 		ls_uniqueColName
Long 	 		ll_sourceRow
Long 			ls_return

u_dw_Tcard 			ldw_source


//----------------------------------------------------------------

ls_filter = this.describe("datawindow.table.filter")
ls_filter = trim(ls_filter)

IF this.of_isWatchList() THEN
	//edit filter to add the appropriate drop

	
	
	//create an event that returns to compare to source
	//if the source type matches the this event triggered, then
	//it is ok to add the person to this list, this can be done
	//by editing the filter string dynamically
	
	IF this.TriggerEvent("ue_getCategory") = 1 AND adrg_source.triggerEvent("ue_getCategory") = 1 THEN
		ldw_source = adrg_source
		ls_thisCat	 = this.EVENT ue_getCategory()
		ls_sourceCat = ldw_source.EVENT ue_getCategory()
		ll_sourceRow = ldw_source.getRow()

		//if the source type matches this type
		IF ls_thisCat = ls_sourceCat AND ll_sourceRow > 0 THEN
		 	ls_uniqueColName = this.EVENT ue_getIdColumn()			//right now it always returns "#1"
			//ls_uniqueId = string(ldw_source.getItemNumber(ll_sourceRow,ls_uniqueColName))
			ls_uniqueId = string(ldw_source.getItemNumber(ll_sourceRow,1))
			
			//if the id isn't already in the filter
			IF pos(ls_filter, ls_uniqueId) = 0 THEN
				IF ls_filter <> "4=3" THEN 
					ls_filter = mid(ls_filter,1, (len(ls_filter)-1) ) 		//strip off ')'
					ls_filter = ls_filter +", " + ls_uniqueId + ")"			//create new filter
				ELSE
					ls_filter = this.Event ue_getIdColumn() + " in ( " +ls_uniqueId +" )"
					
				END IF	
				
				 
				this.setFilter(ls_filter)
				this.filter()
				this.sort()
				ls_return = 1
			END IF
				 
		END IF
	END IF
ELSE
	ls_return = -1
END IF
return ls_return
end function

public subroutine of_setwatchlist ();/***************************************************************************************
NAME: 	of_setWatchlist		

ACCESS:		public	
		
ARGUMENTS: 		
							none

RETURNS:			none
	
DESCRIPTION:  Intended to be called by anything that changes the filter on this object.
		This functionality will determin if it is a watchlist and make appropriate changes.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : dan and maury 7-29-05
	

***************************************************************************************/

String 	ls_filter 
String 	ls_uniqueId
Boolean 	lb_m1
Boolean 	lb_m2
Boolean 	lb_m3
Boolean 	lb_m4
Int 		li_messageRes

ls_uniqueId = this.Event ue_getIdColumn()
ls_uniqueId = "^"+ls_uniqueId + " +in +([0-9, ]+)" 

ls_filter = this.describe("datawindow.table.filter")
ls_filter = trim(ls_filter)


//if ls_filter is in the form "uniqueColName in (id1, id2, id3,)" THEN
//set ib_isWatchList = true otherwise false
//if true then change name to watch list

lb_m1 = Match(ls_filter, ls_uniqueId)


IF (lb_m1  OR ls_filter = "4=3")  THEN
	ib_isWatchList = true				//to enable menu
	

	IF pos(this.title,"WatchList:") = 0 THEN
		this.title = "WatchList: "+ this.title
	END IF
	
	//if its a watchlist, we don't want them to mess with the filter
	This.of_SetFilter ( False )
	
ELSE
	ib_isWatchList = false				//to disable the menu
	IF pos( this.title, "WatchList:") > 0 THEN
		this.title = Replace(this.title, 1, 11,"")
	END IF
	
	//if its not a watchlist, we they can mess with the filter 
	This.of_SetFilter ( TRUE )

	IF IsValid ( This.inv_Filter ) THEN
		This.inv_Filter.of_SetStyle ( 2 )  //1, 2
	END IF
END IF
end subroutine

public function boolean of_iswatchlist ();/***************************************************************************************
NAME: 			of_iswatchlist

ACCESS:			public
		
ARGUMENTS: 		
							(none)

RETURNS:			boolean
	
DESCRIPTION:	Does a match on the filter to see if this window qualifies as a watchlist 
	Returns true if it is false otherwise
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury 	7-29-05
	

***************************************************************************************/

String 	ls_filter 
String 	ls_uniqueId
Boolean 	lb_m1
Boolean 	lb_m2

Int 		li_messageRes

//ls_uniqueId = this.Event ue_getIdColumn()
ls_uniqueId = "#1"					//column 1 always 
ls_uniqueId = "^#1 +in +([0-9, ]+)" 

ls_filter = this.describe("datawindow.table.filter")
ls_filter = trim(ls_filter)

//if ls_filter is in the form "uniqueColName in (id1, id2, id3)" THEN
//lb_m1 is true
lb_m1 = Match(ls_filter, ls_uniqueId)

//ls_uniqueId = "^"+ls_uniqueId + " +in +([, ]*)" 
ls_uniqueId = ls_uniqueId + "[ ]+in[ ]+([, ]*)"
//lb_m2 is true when the filter is in the form "uniqueColName in ()" OR
//"uniqueColName in (,)" with any number of spaces, which makes it not
//a watchlist
lb_m2 = Match(ls_filter, ls_uniqueId)

//if the first match was true or it is an empty watchlist, then it is a
//watchlist.  lb_m1 can be true if lb_m2 is true, but lb_m2 being true
//is not a valid expression, so it is not a watchlist in this case
//MEssageBox(ls_uniqueId, string ( lb_m1 )+ string(lb_m2))
IF (lb_m1  OR ls_filter = "4=3") AND NOT lb_m2 THEN
	Return true
	ib_isWatchlist = true
ELSE
	Return False
	ib_isWatchlist = false
END IF
end function

public function integer of_getidcolumn ();//DEK 6-17-07, shipments, equipment, and non-cache drivers are 1 by default.  Cache Drivers are 2, because the event id must be in the 1 column for rows sync.

RETURN 1
end function

on u_dw_tcard.create
call super::create
end on

on u_dw_tcard.destroy
call super::destroy
end on

event ue_dropnotify;call super::ue_dropnotify;return 1
end event

event constructor;call super::constructor;post of_setWatchList()
This.of_SetDragService(TRUE)
inv_dragService.of_setDragScroll(true) 
end event

event dragdrop;call super::dragdrop;this.of_watchListLogic(source, row, dwo)
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_removerow.Visible = ib_isWatchlist AND this.of_isWatchList()
am_dw.m_table.m_clearwatchlist.Visible = ib_isWatchlist AND this.of_isWatchList()
am_dw.m_table.m_dash18.visible = am_dw.m_table.m_clearwatchlist.Visible OR am_dw.m_table.m_removerow.Visible
											
end event

event rbuttondown;call super::rbuttondown;//if this is a watchlist then they may have selected a row for removal from the filter
IF this.of_isWatchlist() THEN
	this.setRow( row )
END IF


end event

event ue_reload;call super::ue_reload;//This is a part of refreshing of u_dw 
IF this.of_isWatchlist( ) THEN
	ib_isWatchlist = true
	
ELSE
	ib_isWatchList = false
END IF
return ancestorReturnValue
end event

event ue_setidentifiers;call super::ue_setidentifiers;ib_isWatchlist = true
end event

event lbuttonup;call super::lbuttonup;IF isValid(inv_dragService) THEN
	inv_dragService.of_HideIndicator()
END IF
end event

event clicked;call super::clicked;IF isValid(inv_dragService) THEN
	inv_dragService.of_ShowIndicator()
END IF

end event

event buttonclicked;call super::buttonclicked;CHOOSE CASE Lower (dwo.name)
		
	CASE "cb_removefromwatchlist"
		this.event ue_removerowfromfilter( )
END CHOOSE

		
end event

