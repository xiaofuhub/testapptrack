$PBExportHeader$w_itin.srw
$PBExportComments$PTDISP.     The itinerary window.
forward
global type w_itin from w_child
end type
type uo_multiday from u_cst_integerspin within w_itin
end type
type st_multiday from statictext within w_itin
end type
type st_ip_6 from statictext within w_itin
end type
type st_ip_7 from statictext within w_itin
end type
type st_ip_8 from statictext within w_itin
end type
type st_ip_9 from statictext within w_itin
end type
type st_ip_10 from statictext within w_itin
end type
type st_ip_11 from statictext within w_itin
end type
type st_ip_12 from statictext within w_itin
end type
type st_ip_13 from statictext within w_itin
end type
type st_ip_14 from statictext within w_itin
end type
type st_ip_15 from statictext within w_itin
end type
type st_ip_16 from statictext within w_itin
end type
type st_ip_17 from statictext within w_itin
end type
type st_ip_18 from statictext within w_itin
end type
type dw_itin_print from datawindow within w_itin
end type
type cb_selectiondetails from commandbutton within w_itin
end type
type vsb_date from vscrollbar within w_itin
end type
type sle_date from singlelineedit within w_itin
end type
type st_datelabel from statictext within w_itin
end type
type st_ip_19 from statictext within w_itin
end type
type st_ip_5 from statictext within w_itin
end type
type st_ip_20 from statictext within w_itin
end type
type st_ip_21 from statictext within w_itin
end type
type st_ip_4 from statictext within w_itin
end type
type st_ip_3 from statictext within w_itin
end type
type st_ip_2 from statictext within w_itin
end type
type st_ip_1 from statictext within w_itin
end type
type st_ip_0 from statictext within w_itin
end type
type dw_itin from datawindow within w_itin
end type
type tab_type from tab within w_itin
end type
type tp_driver from userobject within tab_type
end type
type tp_driver from userobject within tab_type
end type
type tp_tractor from userobject within tab_type
end type
type tp_tractor from userobject within tab_type
end type
type tp_trailer from userobject within tab_type
end type
type tp_trailer from userobject within tab_type
end type
type tp_container from userobject within tab_type
end type
type tp_container from userobject within tab_type
end type
type tp_external from userobject within tab_type
end type
type tp_external from userobject within tab_type
end type
type tab_type from tab within w_itin
tp_driver tp_driver
tp_tractor tp_tractor
tp_trailer tp_trailer
tp_container tp_container
tp_external tp_external
end type
type dw_detail from u_dw_eventdetail within w_itin
end type
type cb_goto from u_cb within w_itin
end type
type dw_tripdetail from u_dw_tripdetail within w_itin
end type
type tab_route from tab within w_itin
end type
type tabpage_details from userobject within tab_route
end type
type st_tabjump from statictext within tabpage_details
end type
type cb_4 from u_cb within tabpage_details
end type
type ddlb_1 from dropdownlistbox within tabpage_details
end type
type st_2 from statictext within tabpage_details
end type
type cb_document from u_cb within tabpage_details
end type
type cb_2 from u_cb within tabpage_details
end type
type cb_1 from u_cb within tabpage_details
end type
type cb_map from u_cb within tabpage_details
end type
type cb_cashadvance from u_cb within tabpage_details
end type
type tabpage_details from userobject within tab_route
st_tabjump st_tabjump
cb_4 cb_4
ddlb_1 ddlb_1
st_2 st_2
cb_document cb_document
cb_2 cb_2
cb_1 cb_1
cb_map cb_map
cb_cashadvance cb_cashadvance
end type
type tabpage_assignments from u_cst_eventrouting_assignments within tab_route
end type
type tabpage_assignments from u_cst_eventrouting_assignments within tab_route
end type
type tabpage_shipment from u_cst_eventrouting_shipment within tab_route
end type
type tabpage_shipment from u_cst_eventrouting_shipment within tab_route
end type
type tabpage_clipboard from u_cst_eventrouting_clipboard within tab_route
end type
type tabpage_clipboard from u_cst_eventrouting_clipboard within tab_route
end type
type tab_route from tab within w_itin
tabpage_details tabpage_details
tabpage_assignments tabpage_assignments
tabpage_shipment tabpage_shipment
tabpage_clipboard tabpage_clipboard
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//Int	si_instance
////end modification Shared Variables by appeon  20070730
end variables

global type w_itin from w_child
boolean visible = false
integer x = 5
integer y = 276
integer width = 3662
integer height = 1996
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean border = false
long backcolor = 12632256
event ncmousemove pbm_ncmousemove
event type integer ue_removeevents ( )
event type integer ue_displayitinerary ( integer ai_type,  long al_id,  date ad_date )
event type integer ue_refreshitinerary ( boolean ab_defaultscroll )
event ue_ipanswer ( integer ai_ipclicked )
event type integer ue_routerequest ( integer ai_requesttype,  long al_insertionevent,  integer ai_insertionstyle,  date ad_insertiondate )
event type integer ue_rerouteevents ( )
event ue_showeventmenu ( long al_row )
event ue_showedilist ( long al_event )
event ue_splitfront ( )
event ue_splitback ( )
event ue_splitboth ( )
event ue_refreshequipment ( )
event type integer ue_getselecteditintype ( )
uo_multiday uo_multiday
st_multiday st_multiday
st_ip_6 st_ip_6
st_ip_7 st_ip_7
st_ip_8 st_ip_8
st_ip_9 st_ip_9
st_ip_10 st_ip_10
st_ip_11 st_ip_11
st_ip_12 st_ip_12
st_ip_13 st_ip_13
st_ip_14 st_ip_14
st_ip_15 st_ip_15
st_ip_16 st_ip_16
st_ip_17 st_ip_17
st_ip_18 st_ip_18
dw_itin_print dw_itin_print
cb_selectiondetails cb_selectiondetails
vsb_date vsb_date
sle_date sle_date
st_datelabel st_datelabel
st_ip_19 st_ip_19
st_ip_5 st_ip_5
st_ip_20 st_ip_20
st_ip_21 st_ip_21
st_ip_4 st_ip_4
st_ip_3 st_ip_3
st_ip_2 st_ip_2
st_ip_1 st_ip_1
st_ip_0 st_ip_0
dw_itin dw_itin
tab_type tab_type
dw_detail dw_detail
cb_goto cb_goto
dw_tripdetail dw_tripdetail
tab_route tab_route
end type
global w_itin w_itin

type variables
Public:
Constant Integer	ci_RouteRequest_Route = 1
Constant Integer	ci_RouteRequest_ReRoute = 2
Constant Integer	ci_RouteRequest_NewEvent = 3
Constant Integer	ci_RouteRequest_Clipboard = 4
Constant Integer	ci_RouteRequest_Assignment = 5

protected:
integer 		numst = 21, &
		stloop
statictext 		st_ip[0 to 21]
w_dispatch 	w_disp
w_map 		iw_map
w_map_streets	iw_mapstreets
w_pcreport 	reportwin
string 		scroll_column = "co_name"

public:

boolean 	force_tab, &
	hold_redraw, &
	scroll_select, &
	scroll_on

long 	itin_id, &
	last_ship, &
	scroll_firstvis, &
	scroll_targets[]

integer 	whats_on, &
	itin_type

date 	itin_date
datastore 	ds_test, &
	ds_ship_itin

s_eq_info 	itin_equip
s_emp_info 	itin_driver

n_cst_toolmenu_manager 	inv_cst_toolmenu_manager
n_cst_Bso_PSR_Manager 	inv_PSR_Man
n_cst_beo_Shipment 	inv_Shipment
n_cst_bso_Dispatch 	inv_dispatch 
//begin modification Shared Variables by appeon  20070730
Int	si_instance
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer show_ip ()
public function integer get_ships (long ships_to_get[])
public function integer display_itin (integer new_type, long new_id, date new_date)
public function long show_pop (long rcl_row, dwobject rcl_dwo)
public function integer cntns_on_trlr (datastore ds_source, long source_row, long trlr_id, boolean after_event, ref long cntn1_id, ref long cntn2_id)
public subroutine setref_ext ()
public subroutine jump_ship (long ship_id, boolean ask_first)
public subroutine deact_on_conf (long target_row)
private subroutine wf_quickprint_delrecs ()
public subroutine items_on_truck (long al_targetrow)
private subroutine wf_synceventfocus ()
public function integer wf_displaytrip (long al_id)
private function w_dispatch wf_getparent ()
private function integer wf_predisplay ()
private function integer wf_display (boolean ab_scroll)
public function string wf_getcontext ()
protected subroutine jump_select (integer ai_targettype, boolean ab_alwaysshowdialog)
private subroutine wf_setdatedisplay (readonly boolean ab_switch)
private function n_cst_bso_dispatch wf_getdispatchmanager ()
public function long wf_getselectedshipments (ref long ala_ids[], boolean ab_usecurrent)
public function integer wf_getselectedeventids (ref long ala_ids[], readonly boolean ab_usecurrent)
public function integer wf_getselectedevents (ref n_cst_beo_event anva_events[])
public subroutine wf_displaypositionreport (long al_row, boolean ab_lastrecorded)
public function integer wf_route (long ala_targets[], long al_insertionevent, integer ai_insertionstyle)
public function integer wf_setscroll (long al_firstvisibleid, long ala_targetids[], boolean ab_selecttargets)
public function integer wf_setscroll (long ala_targetids[], boolean ab_selecttargets)
public function integer wf_setscroll (boolean ab_selecttargets)
public function integer wf_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg)
public function integer wf_setshares ()
public subroutine wf_printpagesetup ()
public function date wf_resolveambiguousipdate (date ad_date1, date ad_date2)
public function integer wf_route (long ala_targets[], long al_insertionevent, integer ai_insertionstyle, date ad_insertiondate)
public function integer wf_getmultidaysvalue ()
public function integer wf_validateassociation (long ala_targets[], long al_insertionevent, integer ai_insertionstyle, date ad_insertiondate)
public function integer clear_ip ()
public function integer wf_showalerts (boolean ab_allalerts)
public function integer wf_showalerts ()
public function integer wf_create_toolmenu ()
public function integer wf_process_request (string as_request)
public function n_cst_alertmanager wf_getalertmanager ()
public function integer wf_getinstance ()
protected function integer wf_getreports (ref s_toolmenu astra_menuitems[])
private function integer wf_processreportrequest (string as_file)
private function integer wf_processitineraryreport (ref string as_file)
protected function long wf_getdriverid ()
protected function long wf_getpowerunitid ()
protected function long wf_getcontainerid ()
protected function long wf_gettrailerid ()
private function integer wf_getitineraryreportarguments (string as_file, ref n_cst_msg anv_args)
private function integer wf_processpsr (readonly n_cst_msg anv_msg)
public function integer wf_overrideshiptype ()
public function integer wf_validatedisasociation (long ala_targets[])
public function integer wf_setredraw (boolean ab_switch)
public function integer wf_setholdredraw (boolean ab_value)
end prototypes

event ncmousemove;//if whats_on > 0 then this.postevent("mousemove")
end event

event type integer ue_removeevents();//Returns : 1, 0 = No Selection or user cancel, -1 = Error

Long		lla_Ids[], &
			ll_Count, &
			ll_CurrentRow
String	ls_MessageHeader = "Remove Events", &
			ls_ErrorMessage = "Could not process request."
Boolean	lb_RefreshDisplay
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnva_Errors[]

Integer	li_Return = 1


IF li_Return = 1 THEN

	//If nothing is selected, select and scroll to the current row (if there is one.)

	IF dw_Itin.GetSelectedRow ( 0 ) < 1 THEN

		dw_Itin.Event ue_SelectCurrentRow ( TRUE /*ScrollToRow*/ )

	END IF

END IF


IF li_Return = 1 THEN

	//Get the selected event ids (get selected ONLY -- don't use current -- it should have
	//been selected above, if nothing else was selected already.)

	ll_Count = This.wf_GetSelectedEventIds ( lla_Ids, FALSE /*Don't use current*/ )

	CHOOSE CASE ll_Count

	CASE IS > 0

		IF MessageBox ( ls_MessageHeader, "OK to remove the selected events?", &
			Question!, OKCancel!, 1 ) = 1 THEN

			//OK

		ELSE
			//User cancelled
			li_Return = 0
			ls_ErrorMessage = ""  //Clear the error message, so we don't put up a message.

		END IF	

	CASE 0
		li_Return = 0
		ls_ErrorMessage = "No events are selected."

	CASE ELSE
		li_Return = -1
		ls_ErrorMessage += "(Error determining target selection.)"

	END CHOOSE

END IF


IF li_Return = 1 THEN

	lnv_Dispatch = This.wf_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN
		ls_ErrorMessage += "(Could not resolve dispatch manager reference.)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	/////////////////////////////////////////////////////////////////
	//This block of code is copied (and modified) from remove_finish

	Long	ll_FirstSelectedRow, &
			ll_FirstVisibleRow, &
			ll_FirstVisibleId, &
			lla_TargetIds[]
	
	ll_FirstSelectedRow = dw_Itin.GetSelectedRow ( 0 )

	ll_FirstVisibleRow = Long ( dw_Itin.Describe ( "DataWindow.FirstRowOnPage" ) )

	if ll_FirstSelectedRow <= ll_FirstVisibleRow and ll_FirstSelectedRow > 0 then
		ll_FirstVisibleRow = ll_FirstSelectedRow - 1
	end if

	if ll_FirstVisibleRow > 0 then
		ll_FirstVisibleId = dw_Itin.Object.de_Id [ ll_FirstVisibleRow ]
	else
		ll_FirstVisibleId = 0
	end if

	if ll_FirstSelectedRow > 1 then
		lla_TargetIds [ 1 ] = dw_Itin.Object.de_Id [ ll_FirstSelectedRow - 1 ]
	end if

	if ll_FirstVisibleId > 0 or Upperbound ( lla_TargetIds ) = 1 then
		This.wf_SetScroll ( ll_FirstVisibleId, lla_TargetIds, FALSE /*Don't Select Targets*/ )
	end if

	This.wf_SetRedraw ( FALSE )
	This.Hold_Redraw = TRUE
	
//	//This seems to be behaving itself here???  So, I'll comment it for now...
//	//Windows GPF if focus is on last row and it is deleted (if there's only one row, it's ok)
//	Long	ll_CurrentRow
//	ll_CurrentRow = dw_Itin.GetRow ( )
//	IF ll_CurrentRow > 1 THEN
//		IF ll_CurrentRow = dw_Itin.RowCount THEN
//			dw_Itin.SetRow ( 1 )
//		END IF
//	END IF

	//End of copied block
	/////////////////////////////////////////////////////////////////
	
	
/////// Validate removal request

	IF THIS.wf_validatedisasociation( lla_Ids ) = 1 THEN

		CHOOSE CASE lnv_Dispatch.of_Remove ( lla_Ids )
	
			CASE 1
				//Success
		
			CASE -1
				//Error
				li_Return = -1
		
				IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
		
					//There are errors to process -- Get the error text
					ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
		
					//Now that we've got what we need, clear the error list.
					lnv_Dispatch.ClearOFRErrors ( )
		
				ELSE
					ls_ErrorMessage = ""
		
				END IF
		
				IF Len ( ls_ErrorMessage ) > 0 THEN		
					//OK -- We got an error message above.  Use it.
				ELSE
					ls_ErrorMessage = "An unspecified error occurred while attempting to "+&
						"remove events.  (of_Remove)"
				END IF
		
			CASE ELSE
				//Unexpected return value
				li_Return = -1
		
				ls_ErrorMessage = "An unexpected return error occurred while attempting "+&
					"to remove events.  (of_Remove)"
	
		END CHOOSE
	
		//Regardless of the return now, refresh the display since things could have been
		//modified by the attempt.
	
		lb_RefreshDisplay = TRUE
	ELSE		
		tab_type.SetRedraw ( TRUE ) 
		This.wf_SetRedraw ( TRUE )
		
	END IF
	
	
	IF li_Return <= 0 AND Len ( ls_ErrorMessage ) > 0 THEN
	
		MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )
	
	END IF


	IF lb_RefreshDisplay THEN
	
		//Refresh the itinerary, but don't use default scroll behavior -- use the custom behavior set above.
	
		IF This.Event ue_RefreshItinerary ( FALSE /*Don't use default scroll behavior*/ ) = 1 THEN
			//OK
		ELSE
			//A display error message will already have been shown.  So, just put things in perspective.
			MessageBox ( ls_MessageHeader, "Changes made to the itinerary may not be reflected in the display." )
		END IF
	
		/////////////////////////////////////////////////////////////////
		//In remove_finish, we would refresh the shipment routing window, too.
		/////////////////////////////////////////////////////////////////
	
	END IF

END IF

RETURN li_Return



////////////////////////////////////////

//This is all the code from remove_finish

//long currow, first_selected
//currow = dw_itin.getrow()
//
//first_selected = dw_itin.getselectedrow(0)
//scroll_firstvis = integer(dw_itin.describe("datawindow.firstrowonpage"))
//if first_selected <= scroll_firstvis and first_selected > 0 then &
//	scroll_firstvis = first_selected - 1
//if scroll_firstvis > 0 then scroll_firstvis = dw_itin.object.de_id[scroll_firstvis] &
//	else scroll_firstvis = 0
//scroll_targets = blank_longs.longar
//if first_selected > 1 then scroll_targets[1] = dw_itin.object.de_id[first_selected - 1]
//if scroll_firstvis > 0 or upperbound(scroll_targets) = 1 then
//	scroll_select = false
//	scroll_on = true
//end if
//
//wf_SetRedraw ( FALSE )
//hold_redraw = true
//
//if currow = dw_itin.rowcount() and currow > 1 then dw_itin.setrow(1)
////Windows GPF if focus is on last row and it is deleted (if there's only one row, it's ok)
//
//gf_rows_sync(ds_sync, null_dw, w_disp.ds_events, null_dw, filter!, false, false)
//if display_itin(itin_type, itin_id, itin_date) < 1 then beep(5)
//ds_test.reset()
//ds_more.reset()
//if isvalid(shipwin) then shipwin.refresh_display()
end event

event ue_displayitinerary;//Displays the requested itinerary, and presents error messages if the request fails.

//Returns : 1, -1

String	ls_MessageHeader = "Display Itinerary"

Integer	li_Return = 1


IF li_Return = 1 THEN

	CHOOSE CASE This.Display_Itin ( ai_Type, al_Id, ad_Date )
	
	CASE -2
		messagebox(ls_MessageHeader, "The itinerary you have requested contains updates "+&
			"to information already used in this window.  This may cause conflicts in saving "+&
			"your changes.  You should attempt to save now, before continuing.", exclamation!)
		li_Return = -1

	CASE -1
		messagebox(ls_MessageHeader, "Could not retrieve the requested itinerary.", &
			exclamation!)
		li_Return = -1

	END CHOOSE

END IF

RETURN li_Return
end event

event ue_refreshitinerary;//Refreshes the current itinerary, and displays any error messages.
//(Actually, ue_DisplayItinerary displays the messages.)

//Returns : 1, -1

Integer	li_Type
Long		ll_Id
Date		ld_Date

Integer	li_Return = 1


IF li_Return = 1 THEN

	li_Type = This.Itin_Type
	ll_Id = This.Itin_Id
	ld_Date = This.Itin_Date

	IF ab_DefaultScroll THEN
		//Set the default scroll behavior -- focus to current row, and don't select.
		This.wf_SetScroll ( FALSE )
	END IF

	CHOOSE CASE This.Event ue_DisplayItinerary ( li_Type, ll_Id, ld_Date )

	CASE 1
		//OK

	CASE ELSE
		li_Return = -1

	END CHOOSE

END IF


RETURN li_Return
end event

event ue_ipanswer(integer ai_ipclicked);Integer	li_RequestType, &
			li_InsertionStyle
Long		ll_BeforeRow, &
			ll_RowCount, &
			ll_InsertionEvent
Date		ld_InsertionDate

Integer	li_Return = 1

//Initialize the insertion values to null
SetNull ( ld_InsertionDate )
SetNull ( ll_InsertionEvent )
SetNull ( li_InsertionStyle )

//Record the request type, then clear the request flag.
li_RequestType = This.Whats_On
This.Whats_On = 0

//Clear the insertion point display.
for stloop = 0 to numst
	st_ip[stloop].visible = false
	st_ip[stloop].textcolor = 16777215
next


IF IsNull ( ai_IPClicked ) THEN
	li_Return = 0
END IF


IF li_Return = 1 THEN

	ll_BeforeRow = integer(dw_itin.describe("datawindow.firstrowonpage")) + ai_IPClicked
	
	CHOOSE CASE ll_BeforeRow

	CASE IS > 0
		//OK -- No changes needed.

	CASE 0
		ll_BeforeRow = 1

	CASE ELSE
		li_Return = -1

	END CHOOSE

END IF


Date 	ld_Before
Date	ld_After

IF li_Return = 1 THEN
	
	ll_RowCount = dw_Itin.RowCount ( )
	ld_InsertionDate = This.Itin_Date
		
	IF ll_BeforeRow <= ll_RowCount AND ll_BeforeRow > 0 THEN
	
		//We have a row to insert before -- use it.			
		li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_Before
		ll_InsertionEvent = dw_Itin.Object.de_Id [ ll_BeforeRow ]
		
		//check the date before it and the date after it 
		IF ll_BeforeRow >= 2 THEN
			ld_Before = dw_Itin.Object.de_arrdate [ ll_BeforeRow - 1]
			ld_After = dw_Itin.Object.de_arrdate [ ll_BeforeRow ]
			
			IF ld_Before <> ld_After THEN
				ld_InsertionDate = THIS.wf_Resolveambiguousipdate( ld_Before, ld_After )
			ELSE
				ld_InsertionDate = ld_After
			END IF
		
		END IF
			
	ELSEIF ll_RowCount > 0 THEN
	
		//Insert after the last event in this day's itinerary.
		li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_After
		ll_InsertionEvent = dw_Itin.Object.de_Id [ ll_RowCount ]
		ld_InsertionDate  = dw_Itin.Object.de_arrdate [ ll_RowCount ]
	
	ELSE
	
		//There are no events in this day's itinerary -- just route to the end of the day.
		li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfDay
		SetNull ( ll_InsertionEvent )  //Parameter not needed -- No events for this day
	
	END IF

END IF


//Notify tab_Route of what's going on, even if we haven't succeeded in getting an IP, 
//or even if the request did not originate from the routing dialog window.

tab_Route.Event ue_IPAnswer ( li_RequestType, ld_InsertionDate, &
	ll_InsertionEvent, li_InsertionStyle )


//If the request is a type that we resolve here, take further action, if appropriate.  

CHOOSE CASE li_RequestType

CASE ci_RouteRequest_NewEvent, ci_RouteRequest_Clipboard, ci_RouteRequest_Route, &
	ci_RouteRequest_Reroute

	//Only take further action on Reroute if we succeeded in getting an IP.

	IF li_Return = 1 THEN

		This.Event ue_RouteRequest ( li_RequestType, ll_InsertionEvent, li_InsertionStyle,ld_InsertionDate   )

	END IF

END CHOOSE
end event

event type integer ue_routerequest(integer ai_requesttype, long al_insertionevent, integer ai_insertionstyle, date ad_insertiondate);//This is mainly a rehash of some old code, so it's fairly awkward in spots.

//Returns : 1, -1  (Will return 1 if user cancels)

Long		lla_Targets[]
String	ls_MessageHeader = "Route Request", &
			ls_ErrorMessage = "Could not process routing request.~n~nRequest cancelled."


Integer	li_Return = 1


IF li_Return = 1 THEN

	CHOOSE CASE ai_RequestType
	
	CASE ci_RouteRequest_Route, ci_RouteRequest_Clipboard
		ls_MessageHeader = "Route Events"
	
	CASE ci_RouteRequest_Reroute
		ls_MessageHeader = "Reroute Events"
	
	CASE ci_RouteRequest_NewEvent
		ls_MessageHeader = "Add Event"
	
	CASE ELSE  //Unexpected Request Type value
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	IF IsNull ( Itin_Id ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE ai_RequestType
	
	CASE ci_RouteRequest_Route, ci_RouteRequest_Clipboard, ci_RouteRequest_NewEvent
	
		IF tab_Route.Event ue_GetRoutingIds ( lla_Targets ) = -1 THEN
			ls_ErrorMessage = ""
			li_Return = -1
		END IF
	
	CASE ci_RouteRequest_ReRoute
	
		This.wf_GetSelectedEventIds ( lla_Targets, FALSE /*Don't use current if nothing selected*/ )
	
	//	This.Post wf_Route ( ai_RequestType, ll_BeforeRow )
	//	RETURN 1
	
		//Why were we posting this????
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	CHOOSE CASE This.wf_Route ( lla_Targets, al_InsertionEvent, ai_InsertionStyle , ad_insertiondate )

	CASE 1
		//OK

	CASE 0
		//User cancelled -- still return 1

	CASE -1
		//Error
		ls_ErrorMessage = ""  //wf_Route provides its own error notification.
		li_Return = -1

	CASE ELSE
		//Unexpected return value.
		//If wf_Route failed, it would notify, so I'm going to treat this as success.

	END CHOOSE

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )
END IF

RETURN li_Return


//	// check whether there are any ship seq violations
//	// if its a trailer (or straight job, or container), is it the right trailer;  
//	// 	are any of those selected already routed?
//	// ???if its a tractor/driver, is there a trailer assigned?
//elseif ai_RequestType = ci_RouteRequest_ReRoute then
//	if itinevsel < 1 then return -1
//	// if any of those selected are hooks, drops, on.d., off.d., are they the only 
//	// 	event selected
//	//		do they contradict each other, eg. hook after drop, two od's, >3 hooks
//	//		???do they cause any pus/dels to become unassigned
//	// if they are pu's, dels, do they violate any ship_seqs
//	//		???do they remain assigned to a trlr/sj/cntn
//	// 	do they switch from one trlr to another, and if so, do they switch the entire grp
//end if
end event

event ue_rerouteevents;//Returns : 1 (Reroute mode entered), 0 = No Selection or user cancel, -1 = Error

String	ls_MessageHeader = "Reroute Events", &
			ls_ErrorMessage

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF dw_Itin.GetSelectedRow ( 0 ) < 1 THEN

		CHOOSE CASE dw_Itin.Event ue_SelectCurrentRow ( TRUE /*ScrollToRow*/ )

		CASE 1
			//OK, current row was selected successfully.

		CASE ELSE
			ls_ErrorMessage = "No events are selected."
			li_Return = 0

		END CHOOSE

	END IF

END IF


IF li_Return = 1 THEN

	This.show_ip()
	This.whats_on = w_Itin.ci_RouteRequest_ReRoute
	This.tab_type.setfocus()

END IF


IF li_Return <= 0 AND Len ( ls_ErrorMessage ) > 0 THEN

	MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )

END IF


RETURN li_Return
end event

event ue_showeventmenu(long al_row);any 		laa_parm_values[]
String 	lsa_parm_labels[]
String	ls_TempType
String	ls_AddType
String	ls_PopRtn
Long		ll_EventID
Long		ll_ShipmentID
Long		ll_return = 1
Long		ll_TempEventID
Long		ll_SelectedRow
Long		lla_SelectedRows[]
Long		lla_NewID[]
Long		ll_NewID


S_Parm					lstr_Parm
n_cst_Msg				lnv_Msg
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_LicenseManager	lnv_License
n_cst_Beo_Event		lnv_Event
n_cst_Beo_Shipment	lnv_Shipment

ll_SelectedRow = 0 

dw_itin.SetRedraw ( FALSE )

lnv_Event = CREATE n_cst_beo_Event
lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Dispatch = wf_GetDispatchManager ( )

// prevent GPF if focus is on the last row
IF dw_itin.RowCount ( ) > 0 AND al_row = dw_itin.RowCount ( ) THEN
	dw_itin.SetRow ( 1 ) 
END IF

THIS.wf_ConstructSwitchingOptions ( al_Row , lnv_Msg )

IF lnv_Msg.of_Get_Parm ( "LABELS" , lstr_Parm ) <> 0 THEN
	lsa_parm_labels = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "VALUES" , lstr_Parm ) <> 0 THEN
	laa_parm_values = lstr_Parm.ia_Value
END IF

	lnv_Event.of_SetSource ( dw_itin)
	lnv_Event.of_setSourceRow ( al_Row )
	ll_EventID = lnv_Event.of_GetID () 
	
	ll_ShipmentID = lnv_Event.of_GetShipment ( )
	IF ll_ShipmentID > 0 THEN
		lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_getShipmentCache( ) )
		lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Event.of_SetShipment ( lnv_Shipment )
	END IF
//begin midification by appeon 20070731
//invoke constant form n_cst_appeon_constant
//IF gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", lnv_Event ) <> n_cst_privsmanager.ci_True THEN
	IF gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", lnv_Event ) <> appeon_constant.ci_True THEN
//end midification by appeon	
	ll_Return = -1
END IF


IF isValid ( lnv_Dispatch ) AND ll_Return=1 THEN
	IF lnv_License.of_HasEDI214License ( ) THEN
		IF lnv_Dispatch.of_checkEDIupdate(ll_EventID) = 1 THEN
			
			IF UpperBound ( lsa_Parm_Labels ) > 0 THEN
				lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
				laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
			END IF
			
			lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
			laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "New EDI Message"
		
			lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
			laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "EDI Message List"
			
		END IF
	END IF
ELSE
	ll_return = -1
END IF

lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"

lsa_parm_labels[ UpperBound ( lsa_Parm_Labels ) + 1 ] = "ADD_ITEM"
laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "Add &Alert"


IF ll_Return <> -1 THEN
	ls_PopRtn = f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
END IF

if ll_return = 1 AND Len ( ls_PopRtn ) > 0 then
	
	//lnv_Event.of_SetSource ( dw_itin)
	//lnv_Event.of_setSourceRow ( al_Row )
	
	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ))
	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ))
	lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ))
	
//	ll_EventID = lnv_Event.of_GetID () 
	
	DO 
		ll_SelectedRow = dw_itin.GetSelectedRow ( ll_SelectedRow )
		IF ll_SelectedRow > 0 THEN
			lla_SelectedRows [ UpperBound ( lla_SelectedRows ) + 1 ] = ll_SelectedRow
		END IF
	LOOP WHILE ll_SelectedRow > 0
	

	CHOOSE CASE ls_PopRtn
	
		CASE "NEW EDI MESSAGE"
			lnv_Dispatch.of_CreateNewEdiMessage ( ll_EventID )
			
		CASE "EDI MESSAGE LIST"
			THIS.Event ue_ShowEdiList ( ll_eventid )

		CASE "CONVERT TO DISMOUNT" , "CONVERT TO DISMOUNT AND ADD MOUNT"
			ls_TempType =  lnv_Event.of_GetType ( )
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Dismount ) = 1 THEN
			
				IF ls_TempType = gc_Dispatch.cs_EventType_Deliver AND &
					 ls_PopRtn = "CONVERT TO DISMOUNT AND ADD MOUNT" THEN
					ll_ShipmentID = lnv_Event.of_GetShipment ( )
					// add a Mount After the Dismount event if the old event was a shipment Del.
					IF ll_ShipmentID > 0 THEN
						lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
						lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
						lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Mount , lnv_Event.of_GetShipSeq ( ) + 1 , lnv_Dispatch , ll_NewID )
						THIS.wf_Route ( {ll_NewID} , ll_EventID , gc_Dispatch.ci_InsertionStyle_After )					
					END IF
				END IF
			END IF
			
		CASE "CONVERT TO DROP" , "CONVERT TO DROP AND ADD HOOK"
			ls_TempType =  lnv_Event.of_GetType ( )
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Drop ) = 1 THEN
			
				IF ls_TempType = gc_Dispatch.cs_EventType_Deliver AND  &
					ls_PopRtn = "CONVERT TO DROP AND ADD HOOK" THEN
					
					ll_ShipmentID = lnv_Event.of_GetShipment ( )
					// add a Hook After the DROP event
					IF ll_ShipmentID > 0 THEN
						lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
						lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
						lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_HOOK , lnv_Event.of_GetShipSeq ( ) + 1 , lnv_Dispatch , ll_NewID )
					END IF
					THIS.wf_Route ( {ll_NewID} , ll_EventID , gc_Dispatch.ci_InsertionStyle_After )					
				END IF
			END IF
				
					
		CASE "CONVERT TO MOUNT" , "CONVERT TO MOUNT AND INSERT DISMOUNT"
			ls_TempType =  dw_itin.GetItemString ( al_Row , "de_event_type" ) 
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Mount ) = 1 THEN
			
				IF ls_TempType = gc_Dispatch.cs_EventType_PickUp AND & 
					ls_PopRtn = "CONVERT TO MOUNT AND INSERT DISMOUNT" THEN
					
					ll_ShipmentID = lnv_Event.of_GetShipment ( )
					// add a Dismount before the Mount event
					IF ll_ShipmentID > 0 THEN
						lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
						lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
						lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_Dismount , lnv_Event.of_GetShipSeq ( )  , lnv_Dispatch , ll_NewID )
					END IF
					THIS.wf_Route ( {ll_NewID} , ll_EventID , gc_Dispatch.ci_InsertionStyle_Before )					
				END IF
			END IF
			
		CASE "CONVERT TO HOOK" , "CONVERT TO HOOK AND INSERT DROP"
			ls_TempType =  dw_itin.GetItemString ( al_Row , "de_event_type" ) 
			IF lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Hook ) = 1 THEN
			
				IF ls_TempType = gc_Dispatch.cs_EventType_PickUp AND &
					ls_PopRtn = "CONVERT TO HOOK AND INSERT DROP" THEN
					
					ll_ShipmentID = lnv_Event.of_GetShipment ( )
					// add a DROP before the HOOK event
					IF ll_ShipmentID > 0 THEN
						lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
						lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
						lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
						lnv_Shipment.of_AddEvent ( gc_Dispatch.cs_EventType_DROP , lnv_Event.of_GetShipSeq ( )  , lnv_Dispatch , ll_NewID )
					END IF
					THIS.wf_Route ( {ll_NewID} , ll_EventID , gc_Dispatch.ci_InsertionStyle_Before )
				END IF
			END IF
			
			
		CASE "CONVERT TO PICKUP"  // and,  if the previous event is a Drop or dismount, Remove it
			
			IF UpperBound ( lla_SelectedRows ) = 2 THEN
				
				IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent

					//find the row that will be switched to the pickup
					lnv_Event.of_SetSourceRow ( lla_selectedRows [1] )
					IF lnv_Event.of_GetShipment ( ) > 0  THEN
						ll_EventID = lnv_Event.of_GetID ( )
						ls_TempType = dw_itin.GetItemString ( lla_selectedRows [2] , "de_event_type" )
						ll_TempEventID = dw_itin.GetItemNumber ( lla_selectedRows [2] , "de_ID" )
						ll_ShipmentID = lnv_Event.of_GetShipment ( )
					ELSE
						lnv_Event.of_SetSourceRow ( lla_SelectedRows[2] )
						IF lnv_Event.of_GetShipment ( ) > 0 THEN
							ll_EventID = lnv_Event.of_GetID ( )
							ls_TempType = dw_itin.GetItemString ( lla_selectedRows [1] , "de_event_type" )
							ll_TempEventID = dw_itin.GetItemNumber ( lla_selectedRows [1] , "de_ID" )
							ll_ShipmentID = lnv_Event.of_GetShipment ()
						END IF
					END IF
				
					
					IF lnv_Dispatch.of_SwitchToPickUP ( ll_EventID  ) = 1 THEN
						ll_ShipmentID = lnv_Event.of_GetShipment ( )
							
						lnv_Dispatch.of_Remove ( {ll_TempEventID} )  // remove the routing b/f deletion
						IF ll_ShipmentID > 0 THEN
							lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
							lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
							lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
							lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )					
							lnv_Shipment.of_RemoveEvents ( {ll_TempEventID} , lnv_Dispatch )
						END IF		
						
					END IF
				END IF
			ELSE
				lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_PickUp )
			END IF
			
			
		CASE "CONVERT TO DELIVER"
			
			IF UpperBound ( lla_SelectedRows ) = 2 THEN
				
				IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent

					//find the row that will be switched to the pickup
					lnv_Event.of_SetSourceRow ( lla_selectedRows [1] )
					IF lnv_Event.of_GetShipment ( ) > 0  THEN
						ll_EventID = lnv_Event.of_GetID ( )
						ls_TempType = dw_itin.GetItemString ( lla_selectedRows [2] , "de_event_type" )
						ll_TempEventID = dw_itin.GetItemNumber ( lla_selectedRows [2] , "de_ID" )
						ll_ShipmentID = lnv_Event.of_GetShipment ( )
					ELSE
						lnv_Event.of_SetSourceRow ( lla_SelectedRows[2] )
						IF lnv_Event.of_GetShipment ( ) > 0 THEN
							ll_EventID = lnv_Event.of_GetID ( )
							ls_TempType = dw_itin.GetItemString ( lla_selectedRows [1] , "de_event_type" )
							ll_TempEventID = dw_itin.GetItemNumber ( lla_selectedRows [1] , "de_ID" )
							ll_ShipmentID = lnv_Event.of_GetShipment ()
						END IF
					END IF
				
					
					IF lnv_Dispatch.of_SwitchToDeliver ( ll_EventID  ) = 1 THEN
						ll_ShipmentID = lnv_Event.of_GetShipment ( )
							
						lnv_Dispatch.of_Remove ( {ll_TempEventID} )  // remove the routing b/f deletion
						IF ll_ShipmentID > 0 THEN
							lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
							lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
							lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
							lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )					
							lnv_Shipment.of_RemoveEvents ( {ll_TempEventID} , lnv_Dispatch )
						END IF		
						
					END IF
				END IF
			ELSE
				lnv_Dispatch.of_SwitchEventType ( ll_EventID , gc_Dispatch.cs_EventType_Deliver )
			END IF
			
	END CHOOSE 

	THIS.Event ue_RefreshItinerary ( TRUE )
	
	IF ls_PopRtn = "ADD ALERT" THEN
		lnv_Event.of_adduseralert( )
	END IF
END IF

DESTROY ( lnv_Event )
DESTROY ( lnv_Shipment )

dw_itin.SetRedraw ( TRUE )
end event

event ue_showedilist;n_cst_bso_Dispatch lnv_Dispatch

lnv_Dispatch = wf_GetDispatchManager ( )
IF isValid ( lnv_Dispatch ) THEN
	lnv_Dispatch.of_ViewEDIList ( al_event  )
END IF
end event

event ue_splitfront;tab_route.Event ue_SplitFront ( )
end event

event ue_splitback;tab_route.Event ue_SplitBack ( )

end event

event ue_splitboth;tab_route.Event ue_SplitBoth ( )
end event

event ue_refreshequipment;tab_route.tabpage_shipment.of_RefreshEquipment ( )
end event

event type integer ue_getselecteditintype();Int	li_Return

CHOOSE CASE tab_type.Selectedtab
		
	CASE 1 // DRIVER
		li_Return = gc_Dispatch.ci_ItinType_Driver
	CASE 2 // Tractor
		li_Return = gc_Dispatch.ci_ItinType_PowerUnit
	CASE 3 // Trailer
		li_Return = gc_Dispatch.ci_ItinType_TrailerChassis
	CASE 4 // Container
		li_Return = gc_Dispatch.ci_itintype_container
	CASE 5 // Trip
		li_Return = gc_Dispatch.ci_itintype_trip
END CHOOSE

RETURN li_Return
end event

public function integer show_ip ();Long	ll_EventCount
Integer	li_IPIndex

ll_EventCount = dw_Itin.RowCount ( )

FOR li_IPIndex = 0 TO This.NumSt

	IF ll_EventCount >= li_IPIndex THEN
		st_ip [ li_IPIndex ].Visible = TRUE
	END IF

NEXT

RETURN 1
end function

public function integer get_ships (long ships_to_get[]);//Currently, this function pays no attention to statuses in the target, ds_ship_itin

integer num_to_get, result
long checkid, checkloop, ships_to_retr[], primrows, filtrows, numfound
n_cst_anyarraysrv lnv_anyarray

ds_ship_itin.reset()
ds_ship_itin.setfilter("")

num_to_get = upperbound(ships_to_get)
if num_to_get < 1 then return -1

for checkloop = 1 to num_to_get
	result = w_disp.retr_ship(ships_to_get[checkloop])
	if result < 1 then return result
next

primrows = w_disp.ds_events.rowcount()
filtrows = w_disp.ds_events.filteredcount()

if primrows > 0 then
	for checkloop = 1 to primrows
		checkid = w_disp.ds_events.object.de_shipment_id[checkloop]
		if checkid > 0 then
			if lnv_anyarray.of_FindLong(ships_to_get, checkid, 1, num_to_get) > 0 then
				w_disp.ds_events.rowscopy(checkloop, checkloop, primary!, ds_ship_itin, &
					9999, primary!)
				numfound ++
			end if
		end if
	next
end if

if filtrows > 0 then
	for checkloop = 1 to filtrows
		checkid = w_disp.ds_events.object.de_shipment_id.filter[checkloop]
		if checkid > 0 then
			if lnv_anyarray.of_FindLong(ships_to_get, checkid, 1, num_to_get) > 0 then
				w_disp.ds_events.rowscopy(checkloop, checkloop, filter!, ds_ship_itin, &
					9999, primary!)
				numfound ++
			end if
		end if
	next
end if

return 1
end function

public function integer display_itin (integer new_type, long new_id, date new_date);IF new_type = gc_Dispatch.ci_ItinType_Trip THEN
	RETURN wf_DisplayTrip ( new_id )
END IF

integer result

s_eq_info new_equip
s_emp_info new_driver

boolean scroll_on_here
scroll_on_here = scroll_on
scroll_on = false

//This was added in 3.0.03, to fix the problem of being able to use the tabs to move 
//between itineraries without clearing the insertion pointers.  (BF0004)
clear_ip ( )


//// added b.c. the shares needed to be turned off b.c. of PB 8 
//w_disp.ds_events.sharedata(dw_itin)
//w_disp.ds_events.sharedata(dw_detail)

n_cst_LicenseManager	lnv_LicenseManager

wf_SetRedraw ( FALSE )

//dw_itin.post setredraw(true)
//dw_detail.post setredraw(true)


//I was going to change this next line to the commented code below, but it turns
//out the thing I thought I'd need it for didn't after all.  So, I'm going to 
//leave it alone, but it might be helpful to make this change for other circumstances.

if isnull(new_date) then new_date = date(datetime(today()))

//IF IsNull ( New_Date ) THEN
//
//	IF IsNull ( This.Itin_Date ) THEN
//		New_Date = Date ( DateTime ( Today ( ) ) )
//	ELSE
//		New_Date = This.Itin_Date
//	END IF
//
//END IF


if daysafter(lnv_LicenseManager.of_GetLicenseExpiration ( ), new_date) > 7 then 
	messagebox("Display Itinerary", lnv_LicenseManager.of_GetExpirationNotice ( ) +&
		"You cannot work with itineraries that are more than 7 days past the expiration "+&
		"date.  Please contact Profit Tools to extend your registration.", exclamation!)
	wf_SetRedraw ( TRUE )
	return -1
end if

//MULTI
Date	ld_maxDate
ld_MaxDate = RelativeDate ( new_date ,THIS.wf_getmultidaysvalue( ) )
//result = w_disp.retr_itin(new_type, new_id, new_date, new_date, false)
result = w_disp.retr_itin(new_type, new_id, new_date, ld_MaxDate, false)
if result < 1 then
	wf_SetRedraw ( TRUE )
	return result
end if

if new_type = 100 then
	new_driver.em_id = new_id
	if gf_emp_info(w_disp.ds_emp, null_str, null_str, new_driver) < 1 then
		wf_SetRedraw ( TRUE )
		return -1
	end if
else
	new_equip.eq_id = new_id
	if gf_eq_info(w_disp.ds_equip, null_str, null_str, new_equip) < 1 then
		wf_SetRedraw ( TRUE )
		return -1
	end if
end if

//hold_redraw never used to be set until now.  It now is set prior to calling the function
//in some instances (such as when a rows_sync precedes display itin).  I'm not certain
//whether just setting it back to false in the failure circumstances above is sufficient, 
//or whether further row calibration may be required.  I don't have time to investigate, 
//and the handling of this may change further if we go with the alternative proposed
//in rowfocuschanged of dw_itin.

wf_PreDisplay ( )
//THIS.wf_SetShares ( )

//MULTI
String	ls_Filter 
ls_Filter = w_disp.wf_GetItinFilter(new_type, new_id, new_date , ld_maxDate)
//MessageBox ("Filter" , ls_Filter )
dw_itin.setfilter(ls_Filter)
dw_itin.setsort(w_disp.itin_sort(new_type, new_id))

itin_id = new_id
itin_driver = new_driver
itin_equip = new_equip
sle_date.text = upper(string(new_date, "m/d/yy (ddd.)"))
wf_SetDateDisplay ( TRUE )
itin_date = new_date
itin_type = new_type

if itin_type = 100 then
	w_disp.title = "Itinerary for " + itin_driver.em_fn + " " + itin_driver.em_ln + &
		" " + upper(string(itin_date, "m/d/yy (ddd.)"))
else
	w_disp.title = "Itinerary for " + gf_eqref(itin_equip.eq_type, itin_equip.eq_ref) + &
		" " + upper(string(itin_date, "m/d/yy (ddd.)"))
end if

//Set context here each time in case changing from a different context (trip view, etc.)
dw_Detail.of_SetContext ( gc_Dispatch.cs_Context_Itinerary )
wf_Display ( scroll_on_here )

Force_Tab = TRUE
tab_Type.SelectTab ( Itin_Type / 100 )

THIS.Post wf_ShowAlerts ( )

return 1
end function

public function long show_pop (long rcl_row, dwobject rcl_dwo);n_cst_numerical lnv_numerical
if lnv_numerical.of_IsNullOrNotPos(rcl_row) then return -1

string 	obname
String	obname2
String	msgstr
String	ls_Work
String	ls_Request
string 	lsa_parm_labels[]
any 		laa_parm_values[]
long 		ll_id
long		checkloop
long		foundrow
long  	firstrow
long		numskipped
long		ll_SelectedCount
long		lla_SelectedRows[]
long		lla_Empty[]
char	 	check_type

Int		li_Count

n_cst_msg lnv_cst_msg
s_parm lstr_parm
n_cst_Dws	lnv_Dws
n_cst_beo_Event	lnv_Event


n_cst_LicenseManager	lnv_LicenseManager

lnv_Event = CREATE n_cst_beo_Event

obname = rcl_dwo.name
obname2 = obname

choose case obname
	case "co_name"
		obname2 = "de_site"
end choose

ll_SelectedCount = lnv_Dws.of_SelectedCount ( dw_Itin, lla_SelectedRows )

dw_itin.setredraw(false)
if ll_SelectedCount > 0 and not dw_Itin.IsSelected ( rcl_row ) then
	dw_itin.selectrow(0, false)
	ll_SelectedCount = 0
	lla_SelectedRows = lla_Empty
end if
dw_itin.setrow(rcl_row)
dw_itin.setredraw(true)

choose case obname2
case "de_site"
	ll_id = dw_itin.getitemnumber(rcl_row, obname2)
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "COMPANY"
	lsa_parm_labels[2] = "CO_ID"
	laa_parm_values[2] = ll_id
	if dw_itin.isselected(rcl_row) and ll_SelectedCount > 1 then
		lsa_parm_labels[3] = "ADD_ITEM"
		laa_parm_values[3] = "-"
		lsa_parm_labels[4] = "ADD_ITEM"
		laa_parm_values[4] = "Duplicate &Site"
	end if
	IF lnv_LicenseManager.of_HasCommunicationsLicense() THEN
		lsa_parm_labels[5] = "ADD_ITEM"
		laa_parm_values[5] = "-"
		lsa_parm_labels[6] = "ADD_ITEM"
		laa_parm_values[6] = "&Last Recorded Position Report"	
		lsa_parm_labels[7] = "ADD_ITEM"
		laa_parm_values[7] = "&Current Position Report"
		IF ll_SelectedCount > 1 THEN
			lsa_parm_labels[8] = "ADD_ITEM"
			laa_parm_values[8] = "Send Outbound &Message [Shipment]"
		ELSE
			lsa_parm_labels[8] = "ADD_ITEM"
			laa_parm_values[8] = "Send Outbound &Message [Event]"
		END IF
		lsa_parm_labels[9] = "ADD_ITEM"
		laa_parm_values[9] = "Send &Directions"
		lsa_parm_labels[10] = "ADD_ITEM"
		laa_parm_values[10] = "Send &Free Form Text"
		
	END IF
	choose case f_pop_standard(lsa_parm_labels, laa_parm_values)
	case "DUPLICATE SITE"
		s_co_info lstr_co_info
		lstr_co_info.co_id = ll_id
		lstr_co_info.co_name = dw_itin.object.co_name[rcl_row]
		lstr_co_info.co_city = dw_itin.object.co_city[rcl_row]
		lstr_co_info.co_state = dw_itin.object.co_state[rcl_row]
		lstr_co_info.co_tz = dw_itin.object.co_tz[rcl_row]
		lstr_co_info.co_pcm = dw_itin.object.co_pcm[rcl_row]
		msgstr = lstr_co_info.co_name
		if len(lstr_co_info.co_city) > 0 and len(lstr_co_info.co_state) > 0 then &
			msgstr += " (" + lstr_co_info.co_city + ", " + lstr_co_info.co_state + ")"
		msgstr = "OK to set " + msgstr + " as the site for the selected events?~n~n"+&
			"(Any events that are associated with a shipment or that have been confirmed "+&
			"as completed will be skipped.)"
		if messagebox("Duplicate Site", msgstr, question!, okcancel!) = 2 then return 0
		firstrow = dw_itin.getselectedrow(0)
		dw_detail.setredraw(false)
		dw_itin.setredraw(false)
		foundrow = 0
		do
			foundrow = dw_itin.getselectedrow(foundrow)
			if foundrow > 0 then
				if foundrow = rcl_row or dw_itin.object.de_site[foundrow] = ll_id then
					continue
				elseif dw_itin.object.de_conf[foundrow] = "T" or &
					dw_itin.object.de_shipment_id[foundrow] > 0 then
						numskipped ++
						continue
				else
						w_disp.ds_events.object.de_site[foundrow] = lstr_co_info.co_id
						w_disp.ds_events.object.co_name[foundrow] = lstr_co_info.co_name
						w_disp.ds_events.object.co_city[foundrow] = lstr_co_info.co_city
						w_disp.ds_events.object.co_state[foundrow] = lstr_co_info.co_state
						w_disp.ds_events.object.co_tz[foundrow] = lstr_co_info.co_tz
						w_disp.ds_events.object.co_pcm[foundrow] = lstr_co_info.co_pcm
				end if
			end if
		loop while foundrow > 0
		w_disp.wf_reset_times(firstrow, "ITIN!")
		dw_itin.selectrow(0, false)
		ll_SelectedCount = 0
		lla_SelectedRows = lla_Empty
		dw_itin.setredraw(true)
		dw_detail.setredraw(true)
		if numskipped > 0 then
			messagebox("Duplicate Site", "Process complete.~n~n" +string(numskipped) +&
				" selected event(s) were skipped.", exclamation!)
		end if
	case "LAST RECORDED POSITION REPORT"
		
		this.wf_DisplayPositionReport (rcl_row, TRUE)

	case "CURRENT POSITION REPORT"
		
		this.wf_DisplayPositionReport (rcl_row, FALSE)
	case "SEND OUTBOUND MESSAGE [SHIPMENT]", "SEND OUTBOUND MESSAGE [EVENT]"
		lstr_parm.is_label = "AUTOSELECT"
		lstr_parm.ia_value = TRUE
		lnv_cst_msg.of_add_parm(lstr_parm)
		w_disp.Event ue_SendOutBoundMessage(lnv_cst_msg)
	case "SEND DIRECTIONS"
		lstr_Parm.is_Label = "AUTOSELECT"
		lstr_Parm.ia_Value = TRUE
		lnv_cst_msg.of_Add_Parm (lstr_Parm)
		lstr_Parm.is_Label = "TOPICARRAY"
		lstr_Parm.ia_Value = {n_cst_constants.cs_ReportTopic_COMPANY}
		lnv_cst_msg.of_Add_Parm ( lstr_Parm )
		w_disp.Event ue_SendOutBoundMessage(lnv_cst_msg)
	case "SEND FREE FORM TEXT"
		lstr_Parm.is_Label = "AUTOSELECT"
		lstr_Parm.ia_Value = TRUE
		lnv_cst_msg.of_Add_Parm (lstr_Parm)
		w_disp.Event ue_SendFreeFormMessage(lnv_cst_msg)
	end choose

case "p_driv"
	
	check_type = dw_itin.object.de_event_type[rcl_row]
	ll_id = dw_itin.getitemnumber(rcl_row, "de_driver")
	if ll_id > 0 then
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "&Employee Info"
		
		lsa_parm_labels[2] = "ADD_ITEM"
		laa_parm_values[2] = "Add &Alert"
		
	end if
	
	choose case f_pop_standard(lsa_parm_labels, laa_parm_values)
		case "EMPLOYEE INFO"
				ls_Request = "DETAILS!"
		CASE "ADD ALERT"
			ls_Request = "ADDALERT!"
	end choose
	
	if Len ( ls_Request ) > 0 THEN
		lstr_parm.is_label = "TOPIC"
		lstr_parm.ia_value = "EMPLOYEE!"
		lnv_cst_msg.of_add_parm(lstr_parm)

		lstr_parm.is_label = "REQUEST"
		lstr_parm.ia_value = ls_Request
		lnv_cst_msg.of_add_parm(lstr_parm)

		lstr_parm.is_label = "TARGET_ID"
		lstr_parm.ia_value = ll_id
		lnv_cst_msg.of_add_parm(lstr_parm)

		f_process_standard(lnv_cst_msg)
	end if

case "p_trlr1", "p_trlr2", "p_trlr3", "p_cntn01", "p_trac", "p_st"

	//Note : We only support "p_cntn01", not "p_cntn02" and "p_cntn03" because each of these is
	//not really a specific container but a container "set" (one or two) at the corresponding
	//chassis position.  So, we interpret "p_cntn01" as the first container (normally, the only
	//container), and ignore the rest.  If the user wants info on those they can go up to the 
	//itin tab, select the specific equipment, and get details there.
	
	ll_id = 0
	choose case obname2
	case "p_trlr1", "p_trlr2", "p_trlr3"
		ll_id = dw_itin.getitemnumber(rcl_row, "de_trailer" + right(obname2, 1))
	case "p_cntn01"
		ll_id = dw_itin.getitemnumber(rcl_row, "de_container" + right(obname2, 1))
	case "p_trac", "p_st"
		ll_id = dw_itin.getitemnumber(rcl_row, "de_tractor")
	end choose

	
	
	li_Count ++
	if not obname2 = "p_trac" then
		lsa_parm_labels[li_Count] = "ADD_ITEM"
		laa_parm_values[li_Count] = "&Items on Truck"
	end if
	
	li_Count ++
	lsa_parm_labels[li_Count] = "ADD_ITEM"
	laa_parm_values[li_Count] = "&Equipment Details"
	
	li_Count ++
	lsa_parm_labels[li_Count] = "ADD_ITEM"
	laa_parm_values[li_Count] = "Copy &Ref. #"

	IF NOT ( obname2 = "p_trac" OR obname2 = "p_st" ) THEN

		lnv_Event.of_SetSource ( dw_Itin )
		lnv_Event.of_SetSourceRow ( rcl_row )

		IF lnv_Event.of_IsInterchangeCapable ( ) THEN
			
			li_Count ++
			lsa_parm_labels[li_Count] = "ADD_ITEM"

			IF lnv_Event.of_IsAssociation ( ) THEN
				laa_parm_values[li_Count] = "Set as Origination"
			ELSE
				laa_parm_values[li_Count] = "Set as Termination"
			END IF

		END IF

	END IF
	
	li_Count ++
	lsa_parm_labels[li_Count] = "ADD_ITEM"
	laa_parm_values[li_Count] = "Add &Alert"


	choose case f_pop_standard(lsa_parm_labels, laa_parm_values)

		case "ITEMS ON TRUCK"
			post items_on_truck(rcl_row)
	
		case "EQUIPMENT DETAILS"
			
			if ll_id > 0 then
				if ll_id > 10000000 then
					lstr_parm.is_label = "TOPIC"
					lstr_parm.ia_value = "EQUIPMENT!"
					lnv_cst_msg.of_add_parm(lstr_parm)
	
					lstr_parm.is_label = "REQUEST"
					lstr_parm.ia_value = "DETAILS!"
					lnv_cst_msg.of_add_parm(lstr_parm)
	
					lstr_parm.is_label = "TARGET_ID"
					lstr_parm.ia_value = ll_id
					lnv_cst_msg.of_add_parm(lstr_parm)
	
					f_process_standard(lnv_cst_msg)
				else
					messagebox("Equipment Details", "Cannot display details for this piece of "+&
						"equipment until you have saved your changes.")
				end if
			end if
	
		CASE "COPY REF. #"
	
			//Note:  This section references the following columns with calculated names
			//REFERENCES: trlr1_ref, trlr2_ref, trlr3_ref, cntn1_ref, cntn2_ref, cntn3_ref, 
			//REFERENCES: cntn4_ref, trac_ref, acteq_ref
	
			CHOOSE CASE obname2
	
			CASE "p_trlr1", "p_trlr2", "p_trlr3"
				ls_Work = Right ( obname2, 5 )
	
			CASE "p_cntn01"
				ls_Work = "cntn1"
	
			CASE "p_trac", "p_st"
				ls_Work = "trac"
	
			CASE ELSE
				MessageBox ( "Copy Ref. #", "Could not process request.  Request cancelled.", Exclamation! )
				DESTROY ( lnv_Event )
				RETURN -1
	
			END CHOOSE
	
			ls_Work += "_ref"
	
			ClipBoard ( dw_Itin.GetItemString ( rcl_row, ls_Work ) )
	
		CASE "SET AS ORIGINATION", "SET AS TERMINATION"
	
			w_Disp.Event ue_ProcessInterchange ( lnv_Event.of_GetId ( ) )
		
		CASE "ADD ALERT"
			if ll_id > 10000000 then
				n_cst_beo_Equipment2	lnv_Eq
				lnv_Eq = CREATE n_cst_beo_Equipment2
				lnv_Eq.of_SetSourceID (ll_id )
				lnv_Eq.of_Adduseralert( )
				DESTROY ( lnv_Eq )
			ELSE
				messagebox("Equipment Alert", "Cannot create an alert for this piece of "+&
					"equipment until you have saved your changes.")
			END IF
			
	end choose


case "comp_ship_letter", "comp_ship_stops", "comp_tempnum"
	ll_id = dw_itin.object.de_shipment_id[rcl_row]
	if ll_id > 0 then
		lsa_parm_labels[1] = "MENU_TYPE"
		laa_parm_values[1] = "SHIPMENT_PASS_OPEN"
		lsa_parm_labels[2] = "TARGET_ID"
		laa_parm_values[2] = ll_id
//***	
		Long	lla_Ids[], ll_Count
		Boolean	lb_UseCurrent = TRUE
		
		ll_Count = wf_GetSelectedShipments ( lla_Ids, lb_UseCurrent )
		
		lsa_parm_labels[3] = "DOCUMENT"
		laa_parm_values[3] = n_cst_Constants.cs_Document_DeliveryReceipt
			
		lsa_parm_labels[4] = "TOPIC"
		laa_parm_values[4] = "SHIPMENT"
		
		lsa_parm_labels[5] = "DATAWINDOW"
		laa_parm_values[5] = dw_itin
		
		lsa_parm_labels[6] = "MATCHCOLUMN"
		laa_parm_values[6] = "de_shipment_id"
		
		IF ll_Count > 1 THEN
			lsa_parm_labels[7] = "TARGET_IDS"
			laa_parm_values[7] = lla_Ids
		END IF		
//***	
		choose case f_pop_standard(lsa_parm_labels, laa_parm_values)
		case "DETAILS!"
			post jump_ship(ll_id, false)
		end choose
	end if


case "comp_arr", "comp_dep"

	dw_Itin.Event ue_TimeClicked ( rcl_row )


end choose

DESTROY ( lnv_Event )

return 1

//failure:
//messagebox("Error", "Could not process request.~n~nRequest cancelled.", exclamation!)
//return -1
end function

public function integer cntns_on_trlr (datastore ds_source, long source_row, long trlr_id, boolean after_event, ref long cntn1_id, ref long cntn2_id);long source_count
string ml_check
integer trlr_pos, trlr_cntns, pos1, pos2, checkloop
n_cst_numerical lnv_numerical
n_cst_anyarraysrv lnv_anyarray
n_cst_Events	lnv_Events

setnull(cntn1_id)
setnull(cntn2_id)

if isvalid(ds_source) then source_count = ds_source.rowcount() else return -1
if lnv_numerical.of_IsNullOrNotPos(source_count) or source_row > source_count then return -1

for checkloop = 1 to 4
	if checkloop < 4 then pos1 = checkloop + 2 else pos1 = checkloop + 6
	if w_disp.getid(pos1, ds_source, source_row, primary!, false) = trlr_id then
		trlr_pos = checkloop
		exit
	end if
next
if trlr_pos = 0 then return -1
//Note: doing things in this order means that even if there are no containers, if the
//trailer id requested is not present, a -1, not a 0, will be returned

if after_event then
	s_longs ids
	lnv_Events.of_WhatsLeft (ds_source, source_row, 300, trlr_id, ids, ml_check)
	trlr_pos = lnv_anyarray.of_FindLong(ids.longar, trlr_id, 3, 5) - 2
	if lnv_numerical.of_IsNullOrNotPos(trlr_pos) or trlr_pos > 3 then return -1
	if len(ml_check) > 0 then
		pos1 = integer(mid(ml_check, trlr_pos * 2 - 1, 1))
		pos2 = integer(mid(ml_check, trlr_pos * 2, 1))
		if pos1 > 0 then
			trlr_cntns ++
			cntn1_id = ids.longar[pos1 + 5]
		end if
		if pos2 > 0 then
			trlr_cntns ++
			cntn2_id = ids.longar[pos2 + 5]
		end if
	end if
else
	ml_check = ds_source.object.de_multi_list[source_row]
	if len(ml_check) > 0 then
		pos1 = integer(mid(ml_check, trlr_pos * 2 - 1, 1))
		pos2 = integer(mid(ml_check, trlr_pos * 2, 1))
		if pos1 > 0 then
			trlr_cntns ++
			cntn1_id = w_disp.getid(pos1 + 5, ds_source, source_row, primary!, false)
		end if
		if pos2 > 0 then
			trlr_cntns ++
			cntn2_id = w_disp.getid(pos2 + 5, ds_source, source_row, primary!, false)
		end if
	end if
end if

return trlr_cntns
end function

public subroutine setref_ext ();n_cst_numerical lnv_numerical
if lnv_numerical.of_IsNullOrNotPos ( dw_Itin.RowCount ( ) ) then return

n_cst_ShipmentManager lnv_ShipmentMgr
n_ds lds_Ships
lds_Ships = lnv_ShipmentMgr.of_Get_DS_Ship( )

long markloop, foundrow, ship_id, global_rows
integer ship_count, event_count
string ship_list

global_rows = lds_Ships.rowcount()

for markloop = 1 to w_disp.ds_events.rowcount()
	ship_id = w_disp.ds_events.object.de_shipment_id[markloop]
	if ship_id > 0 then
		if pos(ship_list, "q" + string(ship_id) + "q") > 0 then continue
		ship_count ++
		foundrow = lds_Ships.find("ds_id = " + string(ship_id), 1, global_rows)
		if foundrow > 0 then event_count = lds_Ships.object.event_count[foundrow] &
			else event_count = -1
		ship_list += string(char(64 + ship_count))
		if event_count >= 0 then ship_list += string(string(event_count), "@@") &
			else ship_list += " ?"
		ship_list += "q" + string(ship_id) + "q"
	end if
next

dw_itin.modify("st_ship_list.text = '" + ship_list + "'")

dw_itin_Print.modify("st_ship_list.text = '" + ship_list + "'")
end subroutine

public subroutine jump_ship (long ship_id, boolean ask_first);string lsa_parm_labels[]
any laa_parm_values[]
Long	ll_ShipHandle
Boolean lb_isOpen
Integer	li_SaveAndOpen = 1
Long	ll_CurrentId
Long	li_Return = 1
Boolean	lb_JumpShip = TRUE
Integer	li_RemoteOpen = 1

n_cst_bso_Dispatch	lnv_Dispatch

if ask_first then
	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "Display &Shipment"
	if f_pop_standard(lsa_parm_labels, laa_parm_values) = "" then return
end if


IF IsValid ( inv_Windowstate ) THEN
	inv_windowstate.of_Savestate( )
	THIS.wf_SetWindowstate( FALSE )
	si_instance --
END IF

w_disp.wf_DisplayShipment(ship_id, false)
///* Begining of the  new window instance code MFS 2006 */
//IF w_disp.wf_RetrieveOpenShipment(ship_id) > 0 THEN
//	lb_isOpen = w_disp.wf_isShipmentOpen( ship_id, ll_ShipHandle)
//	li_RemoteOpen = w_disp.wf_AlertRemoteOpenShipment(ship_id)
//END IF
//
////w_disp.wf_displayShip ( 110 )
//
//IF li_RemoteOpen = 1 THEN
//	IF lb_isOpen AND ll_ShipHandle <>  Handle(w_disp) THEN  // try and restore
//		
//		
//		lb_JumpShip = FALSE  // FALSE b.c the shipment is already open and we are going to try anf find/restore it	
//		
//		
//		lnv_Dispatch = wf_GetDispatchManager()
//		IF IsValid ( lnv_Dispatch ) THEN
//			IF lnv_Dispatch.Event pt_UpdatesPending ( ) = 1 THEN
//				// tell the user that it is in their best interest to try and save b.c since the shipment
//				// they are trying to jump to is already open we want to avoid the DB error 3 
//				// by saving this dispatch instance and then jumping to the already open instance.
//				li_SaveAndOpen = MessageBox("Save Changes?", "Changes to the itinerary should be saved before accessing " + &
//								"the shipment window to avoid saving conflict.~r~nSelect OK to save changes and jump to the shipment window.",&
//								Exclamation!, OKCANCEL!, 1) 
//								
//				IF li_SaveAndOpen = 1 THEN
//					IF w_disp.Save() < 0 THEN
//						// error saving so we want to stop. We don't want to Jump and we don't want to 
//						// try and restore anything
//						li_Return = -1
//					END IF
//				ELSE
//					li_Return = -1
//				END IF	
//			END IF
//		END IF
//		
//		IF li_Return = 1 THEN
//						
//			ll_CurrentId = Send(ll_ShipHandle, 1025, 0, 0)//triggers event ue_getshipmentid() on w_disp
//				
//			//Here the shipment is already open so we are going to try to restore it instead of opening a new one
//			//If the shipment id in window we are tyring to restore does not match the id in the database
//				//try to refresh the shipment window with the correct id.
//			IF ll_CurrentId > 0 THEN
//				IF ll_CurrentId <> ship_id THEN
//					IF Send(ll_ShipHandle, 1024, 0, ship_id) <> 1 THEN // Refresh the window with the correct id (by triggering the event ue_forcejumpshipment
//						lb_JumpShip = TRUE  				  // which calls wf_jumpshipment on shipwin)
//						// lb_JumpShip = TRUE  b.c we couldn't refresh to the right shipment so we just want to jump the the shipment they want to see.
//					END IF
//				END IF
//				//Try to restore window
//				IF Send(ll_ShipHandle, 274, 61728, 0)  = -1 THEN  // Restores open shipment window if minimized	
//					lb_JumpShip = TRUE  	// b.c. we couldn't restore the shipment so we want to perform the default operation of jump ship
//				END IF		
//			ELSE
//				lb_JumpShip = TRUE  // couldn't resolve the shipments
//			END IF
//			
//		END IF
//		
//	END IF
//ELSE //User canceled request because another user had shipment open
//	lb_JumpShip = FALSE
//	li_Return = -1 
//END IF
/* End of the New Window script MFS 2006 */


//IF lb_JumpShip THEN
//	//////  this was the old/existing code in the script
//	if not isvalid(w_disp.shipwin) then open(w_disp.shipwin, w_disp)
//
//	this.setredraw(false)
//
//	choose case w_disp.shipwin.display_ship(ship_id)
//		case -2
//			this.setredraw(true)
//			messagebox("Display Shipment", "Information on this shipment has been modified "+&
//				"since it was originally retrieved for this window.  This may cause conflicts "+&
//				"in saving your changes.  You should attempt to save now, before continuing.~n~n"+&
//				"The shipment selection request is cancelled.", exclamation!)
//			return
//		case -1
//			this.setredraw(true)
//			messagebox("Display Shipment", "Could not retrieve shipment information from "+&
//				"database.~n~nRequest cancelled -- Please retry.", exclamation!)
//			return
//		case 0
//			this.setredraw(true)
//			messagebox("Display Shipment", "The shipment you have selected has been deleted "+&
//				"in this window, and will be removed from the list upon saving.~n~nRequest "+&
//				"cancelled.", exclamation!)
//			return
//	end choose
//	
//	w_disp.wf_set_toolmenu("SHIP!")
//	w_disp.shipwin.show()
//	this.setredraw(true)
//	this.hide()
//END IF
//
///* added for the new window script mfs 2006*/
//IF lb_JumpShip = FALSE AND li_Return = 1 THEN
//	Close(w_disp) 
//END IF


end subroutine

public subroutine deact_on_conf (long target_row);integer drop_cntns, checkloop
long acteq, eqrow
s_eq_info eqs[3]
string msgstr
n_cst_numerical lnv_numerical

acteq = dw_itin.object.de_acteq[target_row]
eqs[1].eq_id = acteq

if gf_eq_info(w_disp.ds_equip, null_str, null_str, eqs[1]) < 1 then return
if dw_itin.object.de_event_type[target_row] = "R" then
	drop_cntns = cntns_on_trlr(w_disp.ds_events, target_row, acteq, false, &
		eqs[2].eq_id, eqs[3].eq_id)
	for checkloop = 2 to 3
		if eqs[checkloop].eq_id > 0 then
			if gf_eq_info(w_disp.ds_equip, null_str, null_str, eqs[checkloop]) < 1 then &
				return
		end if
	next
end if

msgstr = ""
for checkloop = 1 to 3
	if eqs[checkloop].eq_id > 0 then
		if len(msgstr) > 0 then msgstr += " and "
		msgstr += trim(gf_eqref(eqs[checkloop].eq_type, eqs[checkloop].eq_ref))
	end if
next

if messagebox("Confirm Completion", "Would you like to deactivate " + msgstr + "?  " +&
	"(The event you have confirmed is their termination event.)", question!, yesno!, 1) = 2 &
		then return

for checkloop = 1 to 3
	if eqs[checkloop].eq_id > 0 then
		eqrow = gf_local_eq(eqs[checkloop].eq_id, w_disp.ds_equip)
		if lnv_numerical.of_IsNullOrNotPos(eqrow) then goto failure
	end if
next

for checkloop = 1 to 3
	if eqs[checkloop].eq_id > 0 then
		eqrow = gf_local_eq(eqs[checkloop].eq_id, w_disp.ds_equip)
		if eqs[checkloop].eq_outside = "F" then continue //shouldn't happen
		w_disp.ds_equip.object.eq_status[eqrow] = "D"
	end if
next

return

failure:
messagebox("Deactivate Equipment", "Could not process deactivation request.~n~n"+&
	"Request cancelled.", exclamation!)
end subroutine

private subroutine wf_quickprint_delrecs ();Long	lla_Ids[], ll_Count
Boolean	lb_UseCurrent = TRUE

ll_Count = wf_GetSelectedShipments ( lla_Ids, lb_UseCurrent )

IF ll_Count > 0 THEN
	w_Disp.wf_QuickPrint_Delrecs ( lla_Ids )
ELSE
	MessageBox ( "Print Delivery Receipts", "You must select one or more shipment "+&
		"events first." )
END IF


//This was another approach I tested.

//Long	lla_Shipments[], ll_Count
//Boolean	lb_UseCurrent = TRUE
//String	ls_Type = "DELIVERY_RECEIPT!"
//u_Bills	luo_Bills
//n_cst_Billing	lnv_Billing
//
//ll_Count = wf_GetSelectedShipments ( lla_Shipments, lb_UseCurrent )
//
//IF ll_Count > 0 THEN
//
//	lnv_Billing = CREATE n_cst_Billing
//	w_Disp.OpenUserObject ( luo_Bills )
//	
//	luo_Bills.of_Set_Manager ( lnv_Billing )
//	
//	luo_Bills.of_Set_Layout ( ls_Type )
//
//	IF lnv_Billing.of_Retrieve ( lla_Shipments, ls_Type) > 0 THEN
//
//		s_Longs lstr_Selected_Copies
//		lstr_Selected_Copies.longar [ 1 ] = 1
//		lnv_Billing.of_Print ( luo_Bills, lstr_Selected_Copies )
//
//	END IF
//
//	
//	w_Disp.CloseUserObject ( luo_Bills )
//	DESTROY lnv_Billing
//
//END IF
end subroutine

public subroutine items_on_truck (long al_targetrow);Long	lla_Shipments[], &
		lla_Events[], &
		ll_EventCount
String	ls_ReportTitle, &
			ls_Data
w_LoadBuilder	lw_LoadBuilder

ll_EventCount = dw_Itin.RowCount ( )

IF al_TargetRow > 0 THEN

	lla_Shipments = dw_Itin.Object.de_shipment_id [ 1, ll_EventCount ]
	lla_Events = dw_Itin.Object.de_id [ 1, ll_EventCount ]

	Open ( lw_LoadBuilder )
	lw_LoadBuilder.wf_SetDispatchManager ( This.wf_GetDispatchManager ( ) )
	lw_LoadBuilder.wf_SetEvents ( lla_Events )
	lw_LoadBuilder.wf_SetCurrentEvent ( dw_Itin.Object.de_id [ al_TargetRow ] )
	lw_LoadBuilder.wf_SetShipmentList ( lla_Shipments )

	ls_ReportTitle += sle_Date.Text + "  "

	ls_Data = "Start Time: " + String ( dw_Itin.GetItemTime ( 1, "de_arrtime" ), "hh:mm" )
	IF Len ( ls_Data ) > 0 THEN
		ls_ReportTitle += ls_Data + "  "
	END IF

	ls_Data = dw_Detail.GetItemString ( al_TargetRow, "driv_ln" )
	IF Len ( ls_Data ) > 0 THEN
		ls_ReportTitle += Trim ( ls_Data )
	END IF

	ls_Data = dw_Detail.GetItemString ( al_TargetRow, "Trac_Label" )
	IF Len ( ls_Data ) > 0 THEN
		ls_ReportTitle += "  " + Trim ( ls_Data )
	END IF

	ls_Data = dw_Detail.GetItemString ( al_TargetRow, "Trlr_Label" )
	IF Len ( ls_Data ) > 0 THEN
		ls_ReportTitle += "  " + Trim ( ls_Data )
	END IF

	ls_Data = dw_Detail.GetItemString ( al_TargetRow, "Cntn_Label" )
	IF Len ( ls_Data ) > 0 THEN
		ls_ReportTitle += "  " + Trim ( ls_Data )
	END IF

	lw_LoadBuilder.wf_SetReportTitle ( ls_ReportTitle )

END IF
end subroutine

private subroutine wf_synceventfocus ();//This code, (using CurrentRow instead of GetRow) used to be in RowFocusChanged of dw_Itin.
//This was causing a crash in PBDWE when events were routed, however.  Posting it here
//fixed the problem.  The stuff that uses hold_redraw still seemed to behave properly, 
//but there could potentially be some issues there (I didn't investigate thoroughly.)

Long	ll_Row

ll_Row = dw_Itin.GetRow ( )

if ll_Row > 0 then
	
	if not hold_redraw then dw_detail.setredraw(false)
	dw_detail.setcolumn("disp_events_eventreference_1")
	dw_detail.scrolltorow(ll_Row)
	dw_detail.setcolumn(scroll_column)	
	dw_detail.setcolumn("disp_events_eventreference_1")
	//scroll_column = "disp_events_eventreference_1"
	scroll_column = "co_name"
	if not hold_redraw then dw_detail.setredraw(true)
	IF Whats_On = 0 THEN
		dw_detail.setfocus()
	END IF
end if


//Notify tab_Route of the focus change, so it can take appropriate action if needed.

tab_Route.Event ue_RowFocusChanged ( ll_Row )
end subroutine

public function integer wf_displaytrip (long al_id);String	ls_Filter, &
			ls_Sort
Integer	li_Result = 1
Date		ld_Null
Boolean	lb_ScrollOn
n_cst_bso_Dispatch	lnv_Dispatch

SetNull ( ld_Null )

lb_ScrollOn = Scroll_On
Scroll_On = FALSE


//This was added in 3.0.03, to fix the problem of being able to use the tabs to move 
//between itineraries without clearing the insertion pointers.  (BF0004)
clear_ip ( )


wf_SetRedraw ( FALSE )


//License check????

lnv_Dispatch = This.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN
	li_Result = lnv_Dispatch.of_RetrieveTrip ( al_Id )
ELSE
	li_Result = -1
END IF


IF li_Result = 1 THEN

	//Set Trip Detail Display

	dw_TripDetail.SetFilter ( "Trip_Id = " + String ( al_Id ) )
	dw_TripDetail.Event pfc_Retrieve ( )


	//Set Trip Events Display

	ls_Filter = w_Disp.wf_GetItinFilter ( gc_Dispatch.ci_ItinType_Trip, al_Id, ld_Null, ld_Null )
	ls_Sort = w_Disp.Itin_Sort ( gc_Dispatch.ci_ItinType_Trip, al_Id )
	
	wf_PreDisplay ( )
	
	dw_Itin.SetFilter ( ls_Filter )
	dw_Itin.SetSort ( ls_Sort )
	
	Itin_Id = al_Id
	Itin_Type = gc_Dispatch.ci_ItinType_Trip
	wf_SetDateDisplay ( FALSE )

	wf_GetParent ( ).Title = "3rd Party Trip " + String ( al_Id )

	dw_Detail.of_SetContext ( gc_Dispatch.cs_Context_Trip )
	wf_Display ( lb_ScrollOn )
	
	Force_Tab = TRUE
	tab_Type.SelectTab ( Itin_Type / 100 )

	//Verify whether origin and desination are still the same, and adjust if necessary
	dw_TripDetail.Event Post ue_CheckLocations ( )

ELSE
	wf_SetRedraw ( TRUE )

END IF

RETURN li_Result
end function

private function w_dispatch wf_getparent ();RETURN w_Disp
end function

private function integer wf_predisplay ();s_emp_info	lstr_BlankEmployee
s_eq_info	lstr_BlankEquipment

SetNull ( itin_id )
itin_driver = lstr_BlankEmployee
itin_equip = lstr_BlankEquipment
sle_Date.Text = ""
//SetNull ( itin_date )
SetNull ( itin_type )

RETURN 1
end function

private function integer wf_display (boolean ab_scroll);Long	ll_FoundRow, &
		ll_Id, &
		ll_EventCount
n_cst_anyarraysrv lnv_anyarray		

long firstvis_row, target_minrow, target_maxrow, target_rows[], findloop, &
	frop, lrop, direction, passes

Boolean	lb_ShowSelectionDetails


hold_redraw = true


CHOOSE CASE This.wf_GetContext ( )

CASE gc_Dispatch.cs_Context_Trip
	lb_ShowSelectionDetails = TRUE
	uo_multiday.visible =  FALSE
	st_multiday.Visible = FALSE
CASE ELSE
	uo_multiday.visible =  TRUE
	st_multiday.Visible = TRUE
END CHOOSE

cb_SelectionDetails.Visible = lb_ShowSelectionDetails
dw_TripDetail.Hide ( )


ll_EventCount = dw_Itin.RowCount ( )

if ll_EventCount > 0 then
	ll_FoundRow = dw_itin.getrow()
	if ll_FoundRow > 0 then ll_Id = dw_itin.object.de_id[ll_FoundRow]
	dw_itin.setrow(1)
	dw_Detail.ShareDataOff ( )  // THE SHARE DATA OFF AND THE SUBSEQUENT DHARE DATE ON WAS TO FIX A PROBLEM WITH THE EVENT DETAILS NOT BEING SHOWN 3.8 
	dw_Detail.ScrollToRow ( 1 )  //Added to compensate for post vs. trigger scroll sync in 2.2.00
	w_disp.ds_events.ShareData ( dw_detail )
end if

dw_itin.selectrow(0, false)

dw_itin.filter()
dw_itin.sort()

ll_EventCount = dw_itin.rowcount()

if ll_EventCount > 0 then
	if ab_Scroll then
		firstvis_row = dw_itin.find("de_id = " + string(scroll_firstvis), 1, ll_EventCount)
		for findloop = 1 to upperbound(scroll_targets)
			ll_FoundRow = dw_itin.find("de_id = " + string(scroll_targets[findloop]), 1, ll_EventCount)
			if ll_FoundRow > 0 then
				if ll_FoundRow < target_minrow or target_minrow = 0 then target_minrow = ll_FoundRow
				if ll_FoundRow > target_maxrow then target_maxrow = ll_FoundRow
			end if
			target_rows[findloop] = ll_FoundRow
		next
		if target_maxrow > 0 then dw_itin.scrolltorow(target_maxrow)
		if target_minrow > 0 then dw_itin.scrolltorow(target_minrow)
		if firstvis_row > target_minrow and target_minrow > 0 then firstvis_row = target_minrow
		if firstvis_row > 0 then
			do
				passes ++
				frop = integer(dw_itin.describe("datawindow.firstrowonpage"))
				lrop = integer(dw_itin.describe("datawindow.lastrowonpage"))
				if firstvis_row > frop then
					if direction = -1 then exit
					if ll_EventCount > lrop then
						direction = 1
						dw_itin.scrolltorow(lrop + 1)
					end if
				elseif firstvis_row < frop then
					if direction = 1 then exit
					if lnv_anyarray.of_FindLong(target_rows, lrop, null_long, null_long) > 0 then
						exit
					else
						direction = -1
						dw_itin.scrolltorow(frop - 1)
					end if
				else
					exit
				end if
			loop while passes < ll_EventCount //safety valve against infinite loop
		end if
		if target_minrow > 0 then
			ll_FoundRow = target_minrow
		elseif firstvis_row > 0 then
			ll_FoundRow = integer(dw_itin.describe("datawindow.firstrowonpage"))
			if ll_FoundRow > 0 then firstvis_row = firstvis_row else ll_FoundRow = 1
		else
			ll_FoundRow = 1
		end if

		dw_itin.scrolltorow(ll_FoundRow)
		This.wf_SyncEventFocus ( )  //Replaced dw_detail.scrolltorow(ll_FoundRow) in v3.0
		//to fix issue of Name field not being able to get focus when changing itineraries
		//or adding events when previously there had been no events, and focus went to row 1.

		if scroll_select then

//			Commented for 3.5.0
//			if isvalid(shipwin) then
//				shipwin.dw_ship_itin.selectrow(0, false)
//				shipevsel = 0
//			end if

			for findloop = 1 to upperbound(target_rows)
				if target_rows[findloop] > 0 then
					dw_itin.selectrow(target_rows[findloop], true)
				end if
			next
		end if
	else
		ll_FoundRow = 0
		if ll_Id > 0 then ll_FoundRow = dw_itin.find("de_id = " + string(ll_Id), 1, ll_EventCount)
		if ll_FoundRow < 1 then
			ll_FoundRow = dw_itin.find("not (isnull(de_arrtime) and isnull(de_deptime))", &
				ll_EventCount, 1)
			if ll_FoundRow > 0 and ll_FoundRow < ll_EventCount then
				if not (isnull(dw_itin.object.de_arrtime[ll_FoundRow]) or &
					isnull(dw_itin.object.de_deptime[ll_FoundRow])) then ll_FoundRow ++
			end if
		end if
		if ll_FoundRow > 6 and ll_EventCount > numst then
			dw_itin.scrolltorow(ll_EventCount)
			dw_itin.scrolltorow(ll_FoundRow - 1)
		elseif ll_FoundRow < 1 then
			ll_FoundRow = 1
		end if

		dw_itin.scrolltorow(ll_FoundRow)
		This.wf_SyncEventFocus ( )  //Replaced dw_detail.scrolltorow(ll_FoundRow) in v3.0
		//to fix issue of Name field not being able to get focus when changing itineraries
		//or adding events when previously there had been no events, and focus went to row 1.

	end if
end if

wf_GetParent ( ).setrefs()
setref_ext()
wf_GetParent ( ).wf_reset_times(1, "ITIN!")

wf_SetRedraw ( TRUE )

//if this.visible = false then
//	this.show()
//	if isvalid(w_disp.shipwin) then w_disp.shipwin.hide()
//end if

return 1
end function

public function string wf_getcontext ();RETURN dw_Detail.of_GetContext ( )
end function

protected subroutine jump_select (integer ai_targettype, boolean ab_alwaysshowdialog);integer checkloop, rowloop, num_valid, numdr, numeq
Integer	li_SelectedType
Integer	li_TypeParm	//Used when backwards compatibility is needed for functions that
							//don't use the new ItinType constants
long new_id, test_id, ll_ItinRow, drids[], eqids[], lla_ShipmentIds[], ll_ShipmentCount
date new_date
string new_cat
s_anys open_parms, disp_parms
n_cst_anyarraysrv lnv_anyarray
Boolean	lb_ShowDialog
n_cst_LicenseManager	lnv_LicenseManager

ll_ItinRow = dw_itin.getrow()
new_date = itin_date
SetNull ( new_id )

IF ab_AlwaysShowDialog THEN
	lb_ShowDialog = TRUE

ELSEIF ai_TargetType = gc_Dispatch.ci_ItinType_Trip THEN

	//There's no way to figure out which trip from the display, so we'll always show the dialog.
	lb_ShowDialog = TRUE

ELSEIF ll_ItinRow > 0 THEN

	choose case ai_TargetType

	case gc_Dispatch.ci_ItinType_Driver

		li_TypeParm = 1
		new_id = w_disp.getid(li_TypeParm, w_disp.ds_events, ll_ItinRow, primary!, false)

	case gc_Dispatch.ci_ItinType_PowerUnit

		li_TypeParm = 2
		new_id = w_disp.getid(li_TypeParm, w_disp.ds_events, ll_ItinRow, primary!, false)

	case gc_Dispatch.ci_ItinType_TrailerChassis

		for checkloop = 1 to 4

			if checkloop < 4 then
				test_id = w_disp.getid(checkloop + 2, w_disp.ds_events, ll_ItinRow, &
					primary!, false)
			elseif pos("HR", w_disp.ds_events.getitemstring(ll_ItinRow, "de_event_type")) > 0 then
				test_id = w_disp.ds_events.object.de_acteq[ll_ItinRow]
			else
				test_id = 0
			end if

			if test_id > 0 then
				new_id = test_id
				numeq ++
				eqids[numeq] = test_id
			end if

		next

	case gc_Dispatch.ci_ItinType_Container

		for checkloop = 1 to 5

			if checkloop < 5 then
				test_id = w_disp.getid(checkloop + 5, w_disp.ds_events, ll_ItinRow, &
					primary!, false)
			elseif pos("MN", w_disp.ds_events.getitemstring(ll_ItinRow, "de_event_type")) > 0 then
				test_id = w_disp.ds_events.object.de_acteq[ll_ItinRow]
			else
				test_id = 0
			end if

			if test_id > 0 then
				new_id = test_id
				numeq ++
				eqids[numeq] = test_id
			end if

		next

	end choose

	IF numeq > 1 THEN
		lb_ShowDialog = TRUE

	ELSEIF IsNull ( new_id ) THEN
		lb_ShowDialog = TRUE

	ELSE
		li_SelectedType = ai_TargetType

	END IF


END IF


if lb_ShowDialog then

	for rowloop = 1 to w_disp.ds_events.rowcount()
		for checkloop = 1 to 10
			test_id = w_disp.getid(checkloop, w_disp.ds_events, rowloop, primary!, false)
			if test_id > 0 then
				if checkloop = 1 then
					if lnv_anyarray.of_FindLong(drids, test_id, 1, numdr) > 0 then continue
					numdr ++
					drids[numdr] = test_id
				else
					if lnv_anyarray.of_FindLong(eqids, test_id, 1, numeq) > 0 then continue
					numeq ++
					eqids[numeq] = test_id
				end if
			end if
		next
	next

	ll_ShipmentCount = dw_Detail.of_GetShipments ( lla_ShipmentIds )

	IF IsNull ( ai_TargetType ) AND Itin_Type = gc_Dispatch.ci_ItinType_Trip THEN
		ai_TargetType = gc_Dispatch.ci_ItinType_Trip
	END IF

	open_parms.anys[1] = ai_TargetType
	open_parms.anys[2] = "ALL_SHIPS"  //Changed from "ROUTED_ONLY" in 3.0.02
	open_parms.anys[3] = itin_date
	open_parms.anys[4] = null_long
	open_parms.anys[5] = "PASS"
	open_parms.anys[6] = drids
	open_parms.anys[7] = eqids
	open_parms.anys[8] = w_disp.ds_emp
	open_parms.anys[9] = w_disp.ds_equip
	Open_Parms.Anys [ 10 ] = lla_ShipmentIds

	openwithparm(w_itin_select, open_parms)
	disp_parms = message.powerobjectparm

	new_cat = disp_parms.anys[1]

	if new_cat = "ITIN" then
		li_SelectedType = disp_parms.anys[2]
		new_id = disp_parms.anys[3]
		new_date = disp_parms.anys[4]
	elseif new_cat = "SHIP" then
		li_SelectedType = gc_Dispatch.ci_ItinType_Shipment
		new_id = disp_parms.anys[2]
	end if

end if


IF new_id > 0 THEN

	CHOOSE CASE li_SelectedType
	
	CASE gc_Dispatch.ci_ItinType_Driver, &
		gc_Dispatch.ci_ItinType_PowerUnit, &
		gc_Dispatch.ci_ItinType_TrailerChassis, &
		gc_Dispatch.ci_ItinType_Container, &
		gc_Dispatch.ci_ItinType_Trip
	

		Boolean	lb_ApproveSelection = TRUE

		CHOOSE CASE li_SelectedType
				
			CASE gc_Dispatch.ci_ItinType_Trip
				IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Brokerage, "E" ) < 0 THEN
					lb_ApproveSelection = FALSE
				END IF
			CASE ELSE
				IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Dispatch, "E" ) < 0 THEN
					lb_ApproveSelection = FALSE
				END IF
				
		END CHOOSE
		
		
		IF lb_ApproveSelection THEN
			
			choose case display_itin(li_SelectedType, new_id, new_date)
		
			//NOTE: The line above assumes compatibility between the new constants and the old types, 
			//(Driver = 100, PowerUnit = 200, TrailerChassis = 300, and Container = 400)
		
			case -2
				messagebox("Display Itinerary", "The itinerary you have requested contains updates "+&
					"to information already used in this window.  This may cause conflicts in saving "+&
					"your changes.  You should attempt to save now, before continuing.~n~nThe "+&
					"itinerary selection request is cancelled.", exclamation!)
			case -1
				messagebox("Display Itinerary", "Could not retrieve the requested itinerary.~n~n"+&
					"Please retry.", exclamation!)
			end choose
			
		END IF
	
	CASE gc_Dispatch.ci_ItinType_Shipment
		post jump_ship(new_id, false)
	
	END CHOOSE

END IF
end subroutine

private subroutine wf_setdatedisplay (readonly boolean ab_switch);//Show or Hide the Itin Date controls

IF NOT IsNull ( ab_Switch ) THEN
	//st_DateLabel.Visible = ab_Switch
	sle_Date.Enabled = ab_Switch
	vsb_Date.Visible = ab_Switch
END IF
end subroutine

private function n_cst_bso_dispatch wf_getdispatchmanager ();RETURN w_Disp.wf_GetDispatchManager ( )
end function

public function long wf_getselectedshipments (ref long ala_ids[], boolean ab_usecurrent);Long	lla_Rows[], ll_Row, ll_Count, lla_Ids[], ll_Ndx
n_cst_Dws	lnv_Dws
n_cst_anyarraysrv lnv_anyarray

ll_Count = lnv_Dws.of_SelectedCount ( dw_Itin, lla_Rows )

IF ll_Count = 0 AND ab_UseCurrent THEN
	ll_Row = dw_Itin.GetRow ( )
	IF ll_Row > 0 THEN
		ll_Count = 1
		lla_Rows [ 1 ] = ll_Row
	END IF
END IF	

FOR ll_Ndx = 1 TO ll_Count
	lla_Ids [ ll_Ndx ] = dw_Itin.Object.de_shipment_id [ lla_Rows [ ll_Ndx ] ]
NEXT

lnv_anyarray.of_GetShrinked( lla_Ids, "NULLS~tDUPES" )

ll_Count = UpperBound ( lla_Ids )
ala_Ids = lla_Ids

RETURN ll_Count

	

end function

public function integer wf_getselectedeventids (ref long ala_ids[], readonly boolean ab_usecurrent);Long	lla_Rows[], ll_Row, ll_Count, lla_Ids[], ll_Ndx
n_cst_Dws	lnv_Dws
n_cst_anyarraysrv lnv_anyarray


ll_Count = lnv_Dws.of_SelectedCount ( dw_Itin, lla_Rows )

IF ll_Count = 0 AND ab_UseCurrent THEN
	ll_Row = dw_Itin.GetRow ( )
	IF ll_Row > 0 THEN
		ll_Count = 1
		lla_Rows [ 1 ] = ll_Row
	END IF
END IF	

FOR ll_Ndx = 1 TO ll_Count
	lla_Ids [ ll_Ndx ] = dw_Itin.Object.de_id [ lla_Rows [ ll_Ndx ] ]
NEXT

lnv_anyarray.of_GetShrinked( lla_Ids, TRUE /*Shrink Nulls*/, TRUE /*Shrink Dupes*/ )

ll_Count = UpperBound ( lla_Ids )
ala_Ids = lla_Ids

RETURN ll_Count




	

end function

public function integer wf_getselectedevents (ref n_cst_beo_event anva_events[]);Long		ll_IDCount
Long		lla_EventIDs[]
Long		lla_ShipmentIds[], &
			ll_ShipmentCount, &
			ll_ShipmentId
Boolean	lb_UseCurrent = FALSE
Int		i
n_cst_beo_Event	lnva_Events[ ]
n_cst_beo_shipment	lnva_shipment[]
n_cst_bso_Dispatch	lnv_Dispatch

DataStore	lds_Events, &
				lds_Shipments, &
				lds_Items

Boolean	lb_ProvideShipmentReferences = TRUE  //This flag setting is provided so that we could
	//easily override the function to either provide or not provide the shipment references,
	//if we wanted to.  As it stands, it provides the shipment references automatically.

lnv_Dispatch = This.wf_GetDispatchManager ( )
IF IsValid ( lnv_Dispatch ) THEN
	lds_Events = lnv_Dispatch.of_GetEventCache ( )
END IF

ll_IDCount = THIS.wf_GetSelectedEventids ( lla_EventIDs , lb_UseCurrent )

FOR i = 1 TO ll_IDCount
	
	lnva_Events[i] = CREATE n_cst_beo_Event
	lnva_Events[i].of_SetSource ( lds_Events )
	lnva_Events[i].of_SetSourceID ( lla_EventIDs[i] )	

	IF lb_ProvideShipmentReferences THEN

		ll_ShipmentId = lnva_Events [ i ].of_GetShipment ( )

		IF NOT IsNull ( ll_ShipmentId ) THEN
			//Duplicate entries are fine.  We're just getting a list of all references.
			ll_ShipmentCount ++
			lla_ShipmentIds [ ll_ShipmentCount ] = ll_ShipmentId
		END IF

	END IF
		
NEXT


IF lb_ProvideShipmentReferences AND ll_ShipmentCount > 0 THEN

	CHOOSE CASE lnv_Dispatch.of_RetrieveShipments ( lla_ShipmentIds )

	CASE 1, 0 //Success

	CASE -2
		MessageBox ( "Shipment Data Retrieval", "The operation you have requested has identified that "+&
			"shipment information has been modified in the database since it was originally retrieved "+&
			"for this window.  The operation will proceed, but data conflicts could exist.  If you have "+&
			"made changes in this window, you should attempt to save before performing other operations." )

	CASE ELSE //-1
		MessageBox ( "Shipment Data Retrieval", "Could not retrieve related shipment information from "+&
			"database.  The operation you have requested will proceed, but data conflicts could exist." )

	END CHOOSE 

	lds_Shipments = lnv_Dispatch.of_GetShipmentCache ( )
	lds_Items = lnv_Dispatch.of_GetItemCache ( )

	FOR i = 1 TO ll_IDCount

		ll_ShipmentId = lnva_Events [ i ].of_GetShipment ( )

		IF NOT IsNull ( ll_ShipmentId ) THEN

			lnva_shipment [ i ] = CREATE n_cst_beo_shipment
			lnva_shipment [ i ].of_SetSource ( lds_Shipments )
			lnva_shipment [ i ].of_SetSourceId ( ll_ShipmentId )
			lnva_Events [ i ].of_SetShipment ( lnva_shipment [ i ] )

			lnva_Events [ i ].inv_Shipment.of_SetSource ( lds_Shipments )
			lnva_Events [ i ].inv_Shipment.of_SetSourceId ( ll_ShipmentId )
			lnva_Events [ i ].inv_Shipment.of_SetEventSource ( lds_Events )
			lnva_Events [ i ].inv_Shipment.of_SetItemSource ( lds_Items )
		END IF

	NEXT

END IF

anva_Events = lnva_Events
RETURN ll_IDCount
end function

public subroutine wf_displaypositionreport (long al_row, boolean ab_lastrecorded);n_cst_bso_Communication_Manager lnv_Communication

n_cst_beo_Event	lnv_Event
s_co_Info			lstr_Site

Long		ll_PowerUnitId, &
			ll_DriverId, &
			ll_SiteId

Integer	li_Return = 1


IF li_Return = 1 THEN
	
	lnv_Event = CREATE n_cst_beo_Event
	lnv_Event.of_SetSource ( dw_Itin )
	lnv_Event.of_SetSourceRow ( al_Row )
	
	IF lnv_Event.of_HasSource ( ) THEN
		//Get the ids of the power unit and driver assigned to the event.
		ll_PowerUnitId = lnv_Event.of_GetTractorId ( )
		ll_DriverId = lnv_Event.of_GetDriverId ( )
		//Get the company id for the site of the event. 
		//Current position will be reported relative to this location.
		ll_SiteId = lnv_Event.of_GetSite ( )
		gnv_cst_Companies.of_Get_Info ( ll_SiteId, lstr_Site, FALSE /*Don't force refresh*/ )
	ELSE
		li_Return = -1
	END IF
	
	DESTROY lnv_Event
	
END IF


IF li_Return = 1 THEN
	
	lnv_Communication = CREATE n_cst_bso_Communication_Manager

	lnv_Communication.of_DisplayPositionReport ( ll_PowerUnitId, ll_DriverId, lstr_Site, ab_LastRecorded )
	
	DESTROY lnv_Communication

END IF

end subroutine

public function integer wf_route (long ala_targets[], long al_insertionevent, integer ai_insertionstyle);//Returns:  1 = Success, 0 = User Cancelled, -1 = Error

n_cst_bso_Dispatch	lnv_Dispatch
String	ls_MessageHeader = "Event Routing", &
			ls_ErrorMessage = "Could not process request."
n_cst_OFRError		lnva_Errors[]
n_cst_Events	lnv_Events
Int		li_MsgRtn
Integer	li_Return = 1


lnv_Dispatch = This.wf_GetDispatchManager ( )


//Note : We used to check here that the upperbound of the array matched shipevsel or itinevsel
//if the for route type ci_RouteType_Route and ci_RouteType_ReRoute.  This has been dropped.

////////////////////

IF li_Return = 1 THEN
	IF not isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	IF lnv_Events.of_HasNonRoutableMarkedEvents( ala_targets[ ] , lnv_Dispatch.of_GetEventCache ( ) ) THEN
		li_MsgRtn = MessageBox ( "Route Events" , "You have asked to route events that have been marked as Non-Routable. Are you sure you want to do this?" ,Question!, YesNO! , 2) 
		CHOOSE CASE li_MsgRtn
			CASE  1  // mark as routable and continue
				lnv_Events.of_MarkAllEventsAsRoutable ( ala_Targets , lnv_Dispatch.of_GetEventCache ( ) )				
			CASE 2 // bail
				li_Return = 0
		END CHOOSE					
	END IF
END IF

IF li_Return = 1 THEN
	
//	scroll_firstvis = integer(dw_itin.describe("datawindow.firstrowonpage"))
//	if scroll_firstvis > 0 then scroll_firstvis = dw_itin.object.de_id[scroll_firstvis] &
//		else scroll_firstvis = 0
//	scroll_targets = ala_Targets
//	scroll_select = true
//	scroll_on = true

	This.wf_SetScroll ( ala_Targets, TRUE /*Select Targets*/ )
	
	This.wf_SetRedraw ( FALSE )
	This.Hold_Redraw = TRUE
	
	
	/////////TEST EQUIUPMENT VALIDATION \\\\\\\\\\\\\\\\\\\\\\\\\\\
	IF THIS.wf_validatedisasociation( ala_targets[] ) <> 1 THEN
		li_Return = 0
		THIS.wf_Setredraw( TRUE )
	ELSE
		IF THIS.wf_validateassociation( ala_Targets , al_InsertionEvent,al_InsertionEvent,itin_date) <> 1 THEN
			li_Return = 0
			This.wf_SetRedraw ( TRUE )
		END IF
	END IF
	
	
	//IF THIS.wf_validateassociation( ala_Targets , al_InsertionEvent,al_InsertionEvent,itin_date) <> 1 THEN
	//	li_Return = 0
	//	This.wf_SetRedraw ( TRUE )
	//END IF
END IF

IF li_Return = 1 THEN
	
	//Any errors in of_Route will be reported via OFRError.  Clear the error list.
	lnv_Dispatch.ClearOFRErrors ( )
	
	CHOOSE CASE lnv_Dispatch.of_Route ( ala_Targets, itin_type, itin_id, itin_date, 0, al_InsertionEvent, ai_InsertionStyle )
	
	CASE 1  //Success.  Refresh display.  (Moved below)
	
		//if display_itin(itin_type, itin_id, itin_date) < 1 then beep(5)	
		//if ai_RequestType = ci_RouteRequest_Route and isvalid(shipwin) then shipwin.refresh_display()
	
	CASE 0  //User cancelled.

		li_Return = 0
		This.wf_SetRedraw ( TRUE )
	
	CASE ELSE //-1 Failure, or unexpected return value.

		li_Return = -1

		IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN

			//There are errors to process -- Get the error text
			ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )

			//Now that we've got what we need, clear the error list.
			lnv_Dispatch.ClearOFRErrors ( )

		ELSE
			ls_ErrorMessage = ""

		END IF

		IF Len ( ls_ErrorMessage ) > 0 THEN		
			//OK -- We got an error message above.  Use it.
		ELSE
			ls_ErrorMessage = "Unspecified error attempting to perform request.  (of_Route)"
		END IF

		MessageBox ( ls_MessageHeader, ls_ErrorMessage + "~n~nRequest cancelled.", Exclamation! )
	
	END CHOOSE

END IF


IF li_Return <> 0 THEN  //1, -1

	//For -1 (Error, Unexpected return value), instead of just redrawing, we have to redisplay the itinerary, 
	//in case of_Route made any changes in the course of failing.
	if display_itin(itin_type, itin_id, itin_date) < 1 then beep(5)

END IF

THIS.wf_SetRedraw( TRUE )
RETURN li_Return
end function

public function integer wf_setscroll (long al_firstvisibleid, long ala_targetids[], boolean ab_selecttargets);//Set the instance variables that control scrolling with the values passed in, 
//and turn scroll mode on  ( Scroll_On = TRUE )

//Returns : 1, -1 (Currently not implemented)

Integer	li_Return = 1

This.Scroll_Firstvis = al_FirstVisibleId
This.Scroll_Targets = ala_TargetIds
This.Scroll_Select = ab_SelectTargets
This.Scroll_On = TRUE

RETURN li_Return
end function

public function integer wf_setscroll (long ala_targetids[], boolean ab_selecttargets);//Determine the first visible id here, then forward the request to the main version.

//Returns : 1 , -1

Long	ll_FirstVisibleId, &
		ll_FirstVisibleRow

Integer	li_Return = 1

ll_FirstVisibleRow = Long ( dw_Itin.Describe ( "DataWindow.FirstRowOnPage" ) )

IF ll_FirstVisibleRow > 0 THEN
	ll_FirstVisibleId = dw_Itin.Object.de_Id [ ll_FirstVisibleRow ]
ELSE
	ll_FirstVisibleId = 0  //Should we use null??  The old code was using 0.
END IF

IF This.wf_SetScroll ( ll_FirstVisibleId, ala_TargetIds, ab_SelectTargets ) = 1 THEN
	//OK
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function integer wf_setscroll (boolean ab_selecttargets);//Determine the current row, and forward it as the scroll target to the next higher version.

//Returns : 1, 0, -1
//(0 means there is no current row, so we didn't turn scroll on -- this return value does not
//apply to the higher versions of the function.)

Long	ll_CurrentRow, &
		ll_CurrentId

Integer	li_Return = 1

IF li_Return = 1 THEN

	ll_CurrentRow = dw_Itin.GetRow ( )

	IF ll_CurrentRow > 0 THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	ll_CurrentId = dw_Itin.Object.de_Id [ ll_CurrentRow ]

	IF This.wf_SetScroll ( { ll_CurrentId }, ab_SelectTargets ) = 1 THEN

		//OK

	ELSE

		li_Return = -1

	END IF

END IF


RETURN li_Return
end function

public function integer wf_constructswitchingoptions (long al_row, ref n_cst_msg anv_msg);String	ls_PreviousType
String	ls_NextType
String	lsa_ParmLabel[]
Any		laa_ParmValue[]
Boolean	lb_HasShipment
Boolean	lb_Continue = TRUE
Long	ll_SelectedRow
Long	lla_SelectedRows[]
Long	ll_SelectedCount
Long	ll_Row 
Long	ll_RowCount
Long	ll_EventID
Long	ll_Shipment1
Long	ll_Shipment2

Int	li_Rtn

s_Parm	lstr_Parm


n_cst_beo_Event	lnv_Event1
n_cst_beo_Event	lnv_Event2


lnv_Event1 = CREATE n_cst_beo_Event
lnv_Event2 = CREATE n_cst_beo_Event 

ll_RowCount = dw_itin.RowCount ( )
ll_Row = al_Row

DO 
	
	ll_SelectedRow = dw_itin.GetSelectedRow ( ll_SelectedRow )
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
			lnv_Event1.of_SetSource ( dw_itin )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [1] )
			ls_NextType = lnv_Event1.of_GetType ( )
			
		CASE lla_SelectedRows [ 2 ]
			lnv_Event1.of_SetSource ( dw_itin )
			lnv_Event1.of_SetSourceRow ( lla_SelectedRows [2] )
			ls_PreviousType = lnv_Event1.of_GetType ( )
	END CHOOSE

END IF

IF ll_Row > 0 AND ll_Row <= ll_RowCount THEN
	lnv_Event1.of_SetSource ( dw_itin )
	lnv_Event1.of_SetSourceRow ( ll_Row )
	
	ll_EventID = lnv_Event1.of_GetID ( )
	lb_HasShipment = lnv_Event1.of_GetShipment ( ) > 0 
	
	

	CHOOSE CASE ll_SelectedCount
			
		CASE 1
			IF NOT lnv_Event1.of_IsConfirmed ( ) THEN
				IF lnv_Event1.of_isbobtailevent( ) THEN
				ELSE
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
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook and insert Drop"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Hook"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount and insert Dismount"
														
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Mount"
								
							END IF
							
							
						CASE gc_Dispatch.cs_EventType_Deliver
							IF lb_HasShipment THEN
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Drop and add Hook"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount"
								
								lsa_ParmLabel[ UpperBound ( lsa_ParmLabel ) + 1 ] =  "ADD_ITEM"
								laa_ParmValue[ UpperBound ( laa_ParmValue ) + 1 ] = "Convert to Dismount and add Mount"
							END IF
								
							
							
					END CHOOSE
				END IF
			END IF
			
		CASE 2
			IF lla_SelectedRows[2] = lla_SelectedRows[1] + 1 THEN // the 2 rows are adjacent
				lnv_Event1.of_SetSource ( dw_itin )
				lnv_Event1.of_SetSourceRow ( lla_SelectedRows [ 1 ] )
				
				lnv_Event2.of_SetSource ( dw_itin )
				lnv_Event2.of_SetSourceRow ( lla_SelectedRows [ 2 ] )
				
				ll_Shipment1 = lnv_Event1.of_GetShipment ( )
				ll_Shipment2 = lnv_Event2.of_GetShipment ( )
				IF lnv_Event1.of_IsDeliverGroup ( ) AND lnv_Event2.of_IsPickupGroup ( ) THEN
					IF NOT ( lnv_Event1.of_IsConfirmed ( ) OR lnv_Event2.of_IsConfirmed ( )  ) THEN
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

public function integer wf_setshares ();w_disp.ds_events.sharedata(dw_itin)
w_disp.ds_events.sharedata(dw_detail)

RETURN 1
end function

public subroutine wf_printpagesetup ();
dw_itin.Object.companies_dispatchinstructions.X = 1
dw_itin.Object.comp_ship_ind.x= 5
dw_itin.Object.comp_tz_adj.x= 10
dw_itin.Object.cc_depstr.x= 15
dw_itin.Object.cc_arrstr.x= 20
dw_itin.Object.leg_mins.x= 25
dw_itin.Object.interch.x= 30

dw_itin.Object.companies_dispatchinstructions.y = 300
dw_itin.Object.comp_ship_ind.y= 300
dw_itin.Object.comp_tz_adj.y= 300
dw_itin.Object.cc_depstr.y= 300
dw_itin.Object.cc_arrstr.y= 300
dw_itin.Object.leg_mins.y= 300
dw_itin.Object.interch.y= 300

end subroutine

public function date wf_resolveambiguousipdate (date ad_date1, date ad_date2);Date 		ld_Return
String	ls_Date
s_Parm	lstr_Parm
n_cst_msg	lnv_Msg

lstr_Parm.is_label = "DATE1"
lstr_Parm.ia_value = ad_Date1
lnv_msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "DATE2"
lstr_Parm.ia_value = ad_Date2
lnv_msg.of_Add_Parm ( lstr_Parm )

OpenWithParm ( w_ResolveDate, lnv_Msg )


ls_Date = Message.stringparm

IF isdate ( ls_Date ) THEN
	ld_Return = Date ( ls_Date )
ELSE
	SetNull ( ld_Return ) 
END IF

RETURN ld_Return
	
	




end function

public function integer wf_route (long ala_targets[], long al_insertionevent, integer ai_insertionstyle, date ad_insertiondate);//Returns:  1 = Success, 0 = User Cancelled, -1 = Error

n_cst_bso_Dispatch	lnv_Dispatch
String	ls_MessageHeader = "Event Routing", &
			ls_ErrorMessage = "Could not process request."
n_cst_OFRError		lnva_Errors[]	
n_cst_Events	lnv_Events
Int		li_MsgRtn
Integer	li_Return = 1


lnv_Dispatch = This.wf_GetDispatchManager ( )


//Note : We used to check here that the upperbound of the array matched shipevsel or itinevsel
//if the for route type ci_RouteType_Route and ci_RouteType_ReRoute.  This has been dropped.

////////////////////

IF li_Return = 1 THEN
	IF not isValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	IF lnv_Events.of_HasNonRoutableMarkedEvents( ala_targets[ ] , lnv_Dispatch.of_GetEventCache ( ) ) THEN
		li_MsgRtn = MessageBox ( "Route Events" , "You have asked to route events that have been marked as Non-Routable. Are you sure you want to do this?" ,Question!, YesNO! , 2) 
		CHOOSE CASE li_MsgRtn
			CASE  1  // mark as routable and continue
				lnv_Events.of_MarkAllEventsAsRoutable ( ala_Targets , lnv_Dispatch.of_GetEventCache ( ) )				
			CASE 2 // bail
				li_Return = 0
		END CHOOSE					
	END IF
END IF

IF li_Return = 1 THEN
	
//	scroll_firstvis = integer(dw_itin.describe("datawindow.firstrowonpage"))
//	if scroll_firstvis > 0 then scroll_firstvis = dw_itin.object.de_id[scroll_firstvis] &
//		else scroll_firstvis = 0
//	scroll_targets = ala_Targets
//	scroll_select = true
//	scroll_on = true

	This.wf_SetScroll ( ala_Targets, TRUE /*Select Targets*/ )
	
	This.wf_SetRedraw ( FALSE )
	This.Hold_Redraw = TRUE
	
	//Any errors in of_Route will be reported via OFRError.  Clear the error list.
	lnv_Dispatch.ClearOFRErrors ( )
	
	
	/////////TEST EQUIUPMENT VALIDATION \\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	IF THIS.wf_validatedisasociation( ala_targets[] ) <> 1 THEN
		li_Return = 0
		THIS.wf_Setredraw( TRUE )
	ELSE
		IF THIS.wf_validateassociation( ala_Targets , al_InsertionEvent,al_InsertionEvent,ad_insertiondate) <> 1 THEN
			li_Return = 0
			This.wf_SetRedraw ( TRUE )
		END IF
	END IF
END IF

IF li_Return = 1 THEN
	
	CHOOSE CASE lnv_Dispatch.of_Route ( ala_Targets, itin_type, itin_id, ad_insertiondate, 0, al_InsertionEvent, ai_InsertionStyle )
	
	CASE 1  //Success.  Refresh display.  (Moved below)
	
		//if display_itin(itin_type, itin_id, itin_date) < 1 then beep(5)	
		//if ai_RequestType = ci_RouteRequest_Route and isvalid(shipwin) then shipwin.refresh_display()
	
	CASE 0  //User cancelled.

		li_Return = 0
		This.wf_SetRedraw ( TRUE )
	
	CASE ELSE //-1 Failure, or unexpected return value.

		li_Return = -1

		IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN

			//There are errors to process -- Get the error text
			ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )

			//Now that we've got what we need, clear the error list.
			lnv_Dispatch.ClearOFRErrors ( )

		ELSE
			ls_ErrorMessage = ""

		END IF

		IF Len ( ls_ErrorMessage ) > 0 THEN		
			//OK -- We got an error message above.  Use it.
		ELSE
			ls_ErrorMessage = "Unspecified error attempting to perform request.  (of_Route)"
		END IF

		MessageBox ( ls_MessageHeader, ls_ErrorMessage + "~n~nRequest cancelled.", Exclamation! )
	
	END CHOOSE

END IF


IF li_Return <> 0 THEN  //1, -1

	//For -1 (Error, Unexpected return value), instead of just redrawing, we have to redisplay the itinerary, 
	//in case of_Route made any changes in the course of failing.
	if display_itin(itin_type, itin_id, itin_date ) < 1 then beep(5)

END IF

THIS.wf_SetRedraw( TRUE )

RETURN li_Return
end function

public function integer wf_getmultidaysvalue ();RETURN uo_MultiDay.of_GetValue ( )
end function

public function integer wf_validateassociation (long ala_targets[], long al_insertionevent, integer ai_insertionstyle, date ad_insertiondate);Int	li_Return = 1
Int	li_Problems

n_Cst_Bso_Dispatch	lnv_Disp
lnv_Disp = THIS.wf_GetDispatchmanager( )
n_cst_bso_validation	lnv_Validation
li_Problems = lnv_Disp.of_Validaterouterequest( ala_targets[] , al_insertionevent ,ad_insertiondate, itin_type, itin_id )
//li_Problems = lnv_Disp.of_Validateassociations(ala_targets[],al_insertionevent, ad_insertiondate, itin_type, itin_id, 0 , 0 )
IF li_Problems > 0 THEN
	lnv_Validation = lnv_Disp.of_getValidation( )
END IF	

IF IsValid ( lnv_Validation ) THEN
	IF lnv_Validation.of_dowecontinue( ) THEN 
		li_Return = 1 
	ELSE
		li_Return = 0
	END IF
END IF


RETURN li_Return
end function

public function integer clear_ip ();//Call IPAnswer with a null insertion point, which instructs it to cancel the request


Integer	li_Null
SetNull ( li_Null )

This.Event ue_IPAnswer ( li_Null )

RETURN 1
end function

public function integer wf_showalerts (boolean ab_allalerts);Long	ll_Count
Long	i
pt_n_cst_beo	lnva_Entities[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_AlertManager	lnv_AlertManager

lnv_AlertManager = THIS.wf_GetAlertManager ( )

ll_Count = dw_itin.RowCount ( ) 
FOR i = 1 TO ll_Count
	
	lnva_Entities[ UpperBound (lnva_Entities) + 1 ] = CREATE n_cst_beo_Event
	lnva_Entities[ UpperBound (lnva_Entities) ].of_SetSource ( dw_itin ) 
	lnva_Entities[ UpperBound (lnva_Entities) ].of_SetSourceID ( dw_itin.object.de_id[i] )
	
	lnva_Entities[ UpperBound (lnva_Entities) ].of_GetReferencedEntities( lnva_Entities )
	
NEXT

lnv_shipment = tab_route.tabpage_shipment.of_GetShipment ( ) 
IF isvalid ( lnv_Shipment ) THEN
	lnv_Shipment.of_GetReferencedentities( lnva_Entities )
	lnva_Entities[ UpperBound (lnva_Entities) + 1 ] = lnv_Shipment
END IF
IF ab_allalerts THEN
	lnv_AlertManager.of_ShowAllalerts( lnva_Entities )
ELSE
	lnv_AlertManager.of_Showalerts( lnva_Entities )
END IF
n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_Destroy ( lnva_Entities )


RETURN 1


end function

public function integer wf_showalerts ();RETURN THIS.wf_Showalerts( FALSE )
end function

public function integer wf_create_toolmenu ();
s_toolmenu lstr_toolmenu
s_toolmenu lstra_Reportmenu[]

if isvalid(inv_cst_toolmenu_manager) then return 0

inv_cst_toolmenu_manager = create n_cst_toolmenu_manager
inv_cst_toolmenu_manager.of_set_parent(this)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "ShowAlerts!"
lstr_toolmenu.s_menuitem_text = "Show All &Alerts"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)


//inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "OVERRIDE_SHIPTYPE!"
//lstr_toolmenu.s_menuitem_text = "&Override Shipment Type"
//inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

/////////////
Int	li_Count
Int	i

li_Count = THIS.wf_GetReports(lstra_Reportmenu)

IF li_Count > 0 THEN
	inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")
END IF
FOR i = 1 TO li_Count
	inv_cst_toolmenu_manager.of_add_toolmenu(lstra_Reportmenu[i])
NEXT


return 1


end function

public function integer wf_process_request (string as_request);choose case as_request
		
		
CASE "ShowAlerts!"
	THIS.wf_Showalerts( TRUE )
//CASE "OVERRIDE_SHIPTYPE!"
//	THIS.wf_OverrideShiptype( )
CASE ELSE
	IF LEFT ( as_request , Len ( "REPORT%" )) = "REPORT%" THEN
		THIS.wf_Processreportrequest( as_request )
	END IF
end choose

RETURN 1


end function

public function n_cst_alertmanager wf_getalertmanager ();RETURN wf_getdispatchmanager( ).of_GetAlertManager ( )
end function

public function integer wf_getinstance ();RETURN si_instance
end function

protected function integer wf_getreports (ref s_toolmenu astra_menuitems[]);String	ls_Root
String	ls_Path
String	ls_File
Int		i
Int	li_Count

s_ToolMenu	lstra_MenuItems[]
n_cst_filesrvwin32	lnv_FileSrv
lnv_FileSrv = CREATE n_cst_filesrvwin32

n_cst_dirattrib		lnv_DirAttrib[]

n_cst_setting_templatespathfolder	lnv_TemplatePath
lnv_TemplatePath = CREATE	n_cst_setting_templatespathfolder

ls_Root = lnv_TemplatePath.of_GetValue()
ls_Root += "Reports\Itinerary\"

//ls_File = "itinReport.psr"
//ls_Path = "REPORT%C:\Profit Tools\Reports\Itinerary\" + ls_File + "!" 

li_Count = lnv_FileSrv.of_Dirlist( ls_Root + "*.psr", 0, lnv_DirAttrib )

FOR i = 1 TO li_Count

 
	inv_cst_toolmenu_manager.of_make_default(lstra_MenuItems[i], FALSE, true)
	lstra_MenuItems[i].s_name = "REPORT%" + ls_Root +  String ( lnv_DirAttrib[i].is_filename ) + "!"
	lstra_MenuItems[i].s_menuitem_text = lnv_DirAttrib[i].is_filename

NEXT

astra_menuitems[] = lstra_MenuItems



DESTROY ( lnv_TemplatePath )
DESTROY ( lnv_FileSrv )
RETURN li_Count

end function

private function integer wf_processreportrequest (string as_file);//Note: The value in as_file will be in the form "REPORT%C:\Profit Tools\Reports\Itinerary\ItinReport.psr!"
// so we are going to have to clean it up before we process it

String	ls_File


ls_File = Mid ( as_file , Pos (as_file ,'%') + 1 , Len ( as_file ) - ( pos (as_file ,'%')) - 1 )


// Currently we are only processing Itinerary reports. In the future we can parse the path to identify
// what type of report it is.

THIS.wf_Processitineraryreport( ls_File )

RETURN 1
end function

private function integer wf_processitineraryreport (ref string as_file);n_Cst_msg	lnv_Msg
s_Parm	lstr_Parm
IF THIS.wf_getitineraryreportArguments( as_File , lnv_Msg ) > 0 THEN

	lstr_Parm.is_label = "FILE"
	lstr_Parm.ia_value = as_File
	lnv_Msg.of_Add_parm( lstr_Parm )
	
	w_reportviewer_itinerary	lw_Report
	openSheetWithPArm ( lw_Report , lnv_Msg, gnv_app.of_GetFrame( )  )
	
	IF isValid( lw_report ) THEN
		lw_report.setFocus( )
	END IF
END IF
Return 1
end function

protected function long wf_getdriverid ();// If we are on the driver itin then we can pass itin_id back, otherwise we have
// to do some additional processing

Long	ll_Return 

ll_Return = -1


IF itin_type = gc_dispatch.ci_ItinType_Driver THEN
	ll_Return = itin_id
ELSE
	// we are going to get all of the drivers being shown on the screen and
	// if there is more than one we are going to display a pick list with the 
	// one driver that has focus defaulted.
	
	Long	ll_RowCount
	Long	i
	Long	lla_Ids[]
	Long	ll_RowId 
	Long	ll_Row
	Blob	lblb_State
		
	n_cst_Msg	lnv_Msg
	s_Parm		lstr_Parm
	DataStore	lds_Temp
	
	n_cst_AnyArraySrv	lnv_Array
	
	ll_RowCount = dw_itin.RowCount( )
	
	FOR i = 1 To ll_RowCount
		lla_Ids [i] = dw_itin.GetItemNumber( i,"de_driver")
	NEXT
	
	lnv_Array.of_Getshrinked( lla_Ids, TRUE, TRUE )
	
	IF UpperBound ( lla_Ids ) = 1 THEN
		
		ll_Return = lla_Ids [1]
		
	ELSEIF UpperBound ( lla_Ids ) > 0 THEN
				
		lds_Temp = CREATE DataStore
		
		lds_Temp.DataObject = 'd_DriverpickList'
		lds_Temp.SetTransObject ( SQLCA )
		lds_Temp.Retrieve ( lla_Ids )
				
		lds_Temp.GetFullState ( lblb_State ) 
				
		lstr_Parm.is_Label = "FULLSTATE"
		lstr_Parm.ia_Value = lblb_State
		lnv_msg.of_Add_parm( lstr_Parm )
		
		lstr_Parm.is_Label = "TITLE"
		lstr_Parm.ia_Value = "Select Driver For Report"
		lnv_msg.of_Add_parm( lstr_Parm )
		
		OpenWithParm ( w_PickList , lnv_msg )
	
		ll_RowId = Message.Doubleparm
		
		IF ll_RowId > 0 THEN
			ll_Row = lds_Temp.getrowfromrowid( ll_RowId )
			IF ll_Row > 0 THEN
				ll_Return = lds_Temp.GetItemNumber(  ll_Row , "di_id")
			END IF
		ELSE
			ll_Return = 0
		END IF
			
		Destroy ( lds_Temp )	
		
	END IF

END IF

RETURN ll_Return


end function

protected function long wf_getpowerunitid ();// If we are on the Powerunit itin then we can pass itin_id back, otherwise we have
// to do some additional processing

Long	ll_Return 

ll_Return = -1


IF itin_type = gc_dispatch.ci_ItinType_PowerUnit THEN
	ll_Return = itin_id
ELSE
	// we are going to get all of the PowerUnits being shown on the screen and
	// if there is more than one we are going to display a pick list 
	
	Long	ll_RowCount
	Long	i
	Long	lla_Ids[]
	Long	ll_RowId 
	Long	ll_Row
	Blob	lblb_State
		
	n_cst_Msg	lnv_Msg
	s_Parm		lstr_Parm
	DataStore	lds_Temp
	
	
		
	n_cst_presentation_equipmentsummary	lnv_Pres
	n_cst_AnyArraySrv	lnv_Array
	
	ll_RowCount = dw_itin.RowCount( )
	
	FOR i = 1 To ll_RowCount
		lla_Ids [i] = dw_itin.GetItemNumber( i,"de_tractor")
	NEXT
	
	lnv_Array.of_Getshrinked( lla_Ids, TRUE, TRUE )
	
	IF UpperBound ( lla_Ids ) = 1 THEN
		
		ll_Return = lla_Ids [1]
		
	ELSEIF UpperBound ( lla_Ids ) > 0 THEN
				
		lds_Temp = CREATE DataStore
		
		lds_Temp.DataObject = 'd_EquipmentpickList'
		lds_Temp.SetTransObject ( SQLCA )
		lds_Temp.Retrieve ( lla_Ids )
	
		lnv_Pres.of_Setpresentation( lds_Temp )
				
		lds_Temp.GetFullState ( lblb_State ) 
				
		lstr_Parm.is_Label = "FULLSTATE"
		lstr_Parm.ia_Value = lblb_State
		lnv_msg.of_Add_parm( lstr_Parm )
		
		lstr_Parm.is_Label = "TITLE"
		lstr_Parm.ia_Value = "Select Powerunit For Report"
		lnv_msg.of_Add_parm( lstr_Parm )
		
		OpenWithParm ( w_PickList , lnv_msg )
	
		ll_RowId = Message.Doubleparm
		
		IF ll_RowId > 0 THEN
			ll_Row = lds_Temp.getrowfromrowid( ll_RowId )
			IF ll_Row > 0 THEN
				ll_Return = lds_Temp.GetItemNumber(  ll_Row , "eq_id")
			END IF
		ELSE
			ll_Return = 0
		END IF
			
		Destroy ( lds_Temp )	
		
	END IF

END IF

RETURN ll_Return


end function

protected function long wf_getcontainerid ();Long	ll_Return 

ll_Return = -1



// we are going to get all of the traiers being shown on the screen and
// if there is more than one we are going to display a pick list 
Long	ll_RowCount
Long	i
Long	lla_Ids[]
Long	ll_RowId 
Long	ll_Row
Blob	lblb_State
Long	ll_Count
	
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
DataStore	lds_Temp
n_cst_presentation_equipmentsummary	lnv_Pres
n_cst_AnyArraySrv	lnv_Array

ll_RowCount = dw_itin.RowCount( )

FOR i = 1 To ll_RowCount
	ll_Count ++
	lla_Ids [ll_Count] = dw_itin.GetItemNumber( i,"de_container1")
	
	ll_Count ++
	lla_Ids [ll_Count] = dw_itin.GetItemNumber( i,"de_container2")
	
	ll_Count ++
	lla_Ids [ll_Count] = dw_itin.GetItemNumber( i,"de_container3")
	
	ll_Count ++
	lla_Ids [ll_Count] = dw_itin.GetItemNumber( i,"de_container4")
NEXT

lnv_Array.of_Getshrinked( lla_Ids, TRUE, TRUE )

IF UpperBound ( lla_Ids ) = 1 THEN
	
	ll_Return = lla_Ids [1]
	
ELSEIF UpperBound ( lla_Ids ) > 0 THEN
			
	lds_Temp = CREATE DataStore
	
	lds_Temp.DataObject = 'd_EquipmentpickList'
	lds_Temp.SetTransObject ( SQLCA )
	lds_Temp.Retrieve ( lla_Ids )

	lnv_Pres.of_Setpresentation( lds_Temp )
			
	lds_Temp.GetFullState ( lblb_State ) 
			
	lstr_Parm.is_Label = "FULLSTATE"
	lstr_Parm.ia_Value = lblb_State
	lnv_msg.of_Add_parm( lstr_Parm )
	
	lstr_Parm.is_Label = "TITLE"
	lstr_Parm.ia_Value = "Select Container For Report"
	lnv_msg.of_Add_parm( lstr_Parm )
	
	OpenWithParm ( w_PickList , lnv_msg )

	ll_RowId = Message.Doubleparm
	
	IF ll_RowId > 0 THEN
		ll_Row = lds_Temp.getrowfromrowid( ll_RowId )
		IF ll_Row > 0 THEN
			ll_Return = lds_Temp.GetItemNumber(  ll_Row , "eq_id")
		END IF
	ELSE
		ll_Return = 0
	END IF
		
	Destroy ( lds_Temp )	
	
END IF

RETURN ll_Return


end function

protected function long wf_gettrailerid ();// If we are on the Container itin then we can pass itin_id back, otherwise we have
// to do some additional processing

Long	ll_Return 

ll_Return = -1


// we are going to get all of the trailers being shown on the screen and
// if there is more than one we are going to display a pick list 
Long	ll_RowCount
Long	i
Long	lla_Ids[]
Long	ll_RowId 
Long	ll_Row
Blob	lblb_State
Long	ll_Count
	
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
DataStore	lds_Temp
n_cst_presentation_equipmentsummary	lnv_Pres
n_cst_AnyArraySrv	lnv_Array

ll_RowCount = dw_itin.RowCount( )

FOR i = 1 To ll_RowCount
	ll_Count ++
	lla_Ids [ll_Count] = dw_itin.GetItemNumber( i,"de_Trailer1")
	
	ll_Count ++
	lla_Ids [ll_Count] = dw_itin.GetItemNumber( i,"de_Trailer2")
	
	ll_Count ++
	lla_Ids [ll_Count] = dw_itin.GetItemNumber( i,"de_Trailer3")
	
NEXT

lnv_Array.of_Getshrinked( lla_Ids, TRUE, TRUE )

IF UpperBound ( lla_Ids ) = 1 THEN
	
	ll_Return = lla_Ids [1]
	
ELSEIF UpperBound ( lla_Ids ) > 0 THEN
			
	lds_Temp = CREATE DataStore
	
	lds_Temp.DataObject = 'd_EquipmentpickList'
	lds_Temp.SetTransObject ( SQLCA )
	lds_Temp.Retrieve ( lla_Ids )


	lnv_Pres.of_Setpresentation( lds_Temp )
			
	lds_Temp.GetFullState ( lblb_State ) 
			
	lstr_Parm.is_Label = "FULLSTATE"
	lstr_Parm.ia_Value = lblb_State
	lnv_msg.of_Add_parm( lstr_Parm )
	
	lstr_Parm.is_Label = "TITLE"
	lstr_Parm.ia_Value = "Select Trailer/Chassis For Report"
	lnv_msg.of_Add_parm( lstr_Parm )
	
	OpenWithParm ( w_PickList , lnv_msg )

	ll_RowId = Message.Doubleparm
	
	IF ll_RowId > 0 THEN
		ll_Row = lds_Temp.getrowfromrowid( ll_RowId )
		IF ll_Row > 0 THEN
			ll_Return = lds_Temp.GetItemNumber(  ll_Row , "eq_id")
		END IF
	ELSE
		ll_Return = 0
	END IF
		
	Destroy ( lds_Temp )	
	
END IF



RETURN ll_Return


end function

private function integer wf_getitineraryreportarguments (string as_file, ref n_cst_msg anv_args);//Default is ItinType, ItinID, StartDate, EndDate

Int	li_ItinType
Long	ll_itInID
Date	ld_StartDate
Date	ld_EndDate
Long	ll_Return = 1

n_ds	lds_Temp
lds_Temp = CREATE n_ds

lds_Temp.DataObject = as_file

n_Cst_Dssrv	lnv_Dssrv

lnv_Dssrv = CREATE n_Cst_dssrv


lnv_Dssrv.of_SetRequestor( lds_Temp )
String	lsa_ArgNames[]
String	lsa_ArgTypes[]

IF lnv_Dssrv.of_dwarguments( lsa_ArgNames, lsa_ArgTypes ) = 4 THEN
	
	CHOOSE CASE Upper ( lsa_ArgNames[2] )
			
		CASE "DRIVERID"
			ll_ItinId = THIS.wf_GetDriverID ( )
		CASE "POWERUNITID" 
			ll_ItinId = THIS.wf_GetpowerUnitID ( )
		CASE "CONTAINERID"
			ll_ItinId = THIS.wf_GetContainerID ( )			
		CASE "CHASSISID" , "TRAILERID"
			ll_ItinId = THIS.wf_GetTrailerID ( )
	END CHOOSE
	
	
	
END IF
IF ll_itInID = 0 THEN
	ll_Return = 0
ELSEIF ll_itInID = -1 THEN
	ll_Return = -1
ELSE
	n_cst_Msg	lnv_Msg
	s_parm	lstr_Parm
	
	li_ItinType = itin_type
	ld_StartDate = itin_date
	ld_EndDate = RelativeDate ( itin_date , THIS.wf_Getmultidaysvalue( ) )
	
	
	
	lstr_parm.is_label = "TYPE"
	lstr_Parm.ia_value = li_ItinType
	lnv_Msg.of_Add_parm( lstr_Parm )
	
	lstr_parm.is_label = "ID"
	lstr_Parm.ia_value = ll_itInID
	lnv_Msg.of_Add_parm( lstr_Parm )
	
	lstr_parm.is_label = "STARTDATE"
	lstr_Parm.ia_value = ld_StartDate
	lnv_Msg.of_Add_parm( lstr_Parm )
	
	lstr_parm.is_label = "ENDDATE"
	lstr_Parm.ia_value = ld_endDate
	lnv_Msg.of_Add_parm( lstr_Parm )
	
	
	anv_args = lnv_Msg
	
END IF

DESTROY ( lnv_Dssrv )
DESTROY ( lds_Temp ) 

RETURN ll_Return
end function

private function integer wf_processpsr (readonly n_cst_msg anv_msg);//
/***************************************************************************************
NAME			: wf_ProcessPSR
ACCESS		: Private 
ARGUMENTS	: String		PSR File Name (path incl.)
RETURNS		: Integer	(1=Success, -1=Failure)
DESCRIPTION	: Opens the PSR View window
					The PSR window will call the PSR Manager 
REVISION		: RDT 4-1-03
***************************************************************************************/
Long		lla_ShipId[], &
			ll_Upper

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
		ll_Upper = UpperBound(lla_ShipId[])
	END IF
END IF

// check for ".psr" in file name
If Upper( Right( ls_filename , 4 ) ) = ".PSR" Then 
	
	IF ll_Upper < 1 THEN //IF shipment ids were not passed in, get current id
		ll_Upper = this.wf_GetSelectedShipments ( lla_ShipId[], TRUE )
	END IF
	
	
	
	If ll_Upper > 0 Then 
	
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

Return li_Return 

end function

public function integer wf_overrideshiptype ();Integer	li_Return = 1
/*Integer	li_Type
Long		i, ll_EventCount
Long		ll_EventIds[]
n_cst_Msg	lnv_Msg
s_parm	lstr_Parm

n_cst_beo_Event 	lnv_Events[]

This.wf_GetSelectedEventIds( ll_EventIds[], FALSE )
This.wf_GetSelectedEvents(lnv_Events[])

IF UpperBound(ll_EventIds[]) > 0 THEN
	
	lstr_Parm.is_Label = "IDS"
	lstr_Parm.ia_Value = ll_EventIds[]
	lnv_Msg.of_Add_Parm( lstr_Parm )
	
	OpenWithParm(w_ShipmentTypeOveride, lnv_Msg, This)
	
	
	IF isValid(Message.PowerObjectParm) THEN
		lnv_Msg = Message.PowerObjectParm
		
		IF lnv_Msg.of_Get_parm( "OVERRIDETYPE", lstr_Parm) > 0 THEN
			li_Type = lstr_Parm.ia_Value
		ELSE
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF
ELSE
	MessageBox("Shipment type override", "Please select event(s) to override.")
	li_Return = -1
END IF


IF li_Return = 1 THEN
	
	ll_EventCount = UpperBound(lnv_Events[])
	FOR i = 1 TO ll_EventCount
		IF lnv_Events[i].of_GetShipment() > 0 THEN // if event is a shipment event, allow override
			IF NOT isNull(li_Type) THEN
				lnv_Events[i].of_SetShipTypeOverride(li_Type)
			END IF
		END IF
	NEXT
	
END IF


*/
Return li_Return

end function

public function integer wf_validatedisasociation (long ala_targets[]);// loop through all of the events and get all of the assignments.

// i thinkg we will need to determin if the event is an association event or not. 
Int	li_Return = 1
Int	li_EventCount
Int	i
Long	lla_Drivers[]
Long	lla_PowerUnits[]
Long	lla_TrailerChassis[]


Long	lla_Container[]
Int	li_EqIndex
n_Cst_beo_Event	lnva_Events[]
Int	li_Problems

n_Cst_Bso_Dispatch	lnv_Disp
Long	ll_Row

//ll_Row = dw_itin.GetRow ( )
//dw_itin.SelectRow( 0 , FALSE )
//dw_itin.SelectRow( ll_Row , TRUE )

//li_EventCount = THIS.wf_Getselectedevents( lnva_Events )

n_cst_beo_Event	lnv_CurrentEvent
lnv_Disp = THIS.wf_GetDispatchmanager( )
n_cst_Events	lnv_Events

lnv_Disp.of_GetEventlist( ala_targets[] , lnva_Events, TRUE )
li_EventCount = UpperBound ( lnva_Events )

FOR i = 1 TO li_EventCount
	
	lnv_CurrentEvent = lnva_Events[i]
	IF IsNull ( lnv_CurrentEvent.of_GetDatearrived( ) ) THEN
		CONTINUE
	END IF
	
	IF lnv_Events.of_istypedissociation( lnv_CurrentEvent.of_GetType ( ) ) THEN
		lnv_CurrentEvent.of_getactiveassignments( lla_Drivers, lla_PowerUnits, lla_TrailerChassis ,  lla_Container )
		FOR li_EqIndex = 1 TO UpperBound ( lla_Container )	
			li_Problems += lnv_Disp.of_Validatedisassociation( lnv_CurrentEvent.of_GetID ( ) , gc_dispatch.ci_ItinType_Container , lla_Container[ li_EqIndex ], itin_type , itin_id )
		NEXT
		
		FOR li_EqIndex = 1 TO UpperBound ( lla_TrailerChassis )	
			li_Problems += lnv_Disp.of_Validatedisassociation( lnv_CurrentEvent.of_GetID ( ) , gc_dispatch.ci_ItinType_TrailerChassis , lla_TrailerChassis[ li_EqIndex ], itin_type , itin_id )
		NEXT
	ELSE // the 'trickle' effect is not an issue, but, we do have to check that we can modify the target event
		//begin midification by appeon 20070731
		//invoke constant form n_cst_appeon_constant
		//IF gnv_app.of_getprivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", lnv_CurrentEvent ) <> n_cst_privsmanager.ci_TRUE THEN
			IF gnv_app.of_getprivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", lnv_CurrentEvent ) <> appeon_constant.ci_TRUE THEN
		//end midification by appeon
			// message box is formatted to look like the other messages that may come from the validation object
			MessageBox ( "Association Validation" , "The following problems were discovered:~r~nYour privileges do not permit you to make this modification." , Exclamation! )
			li_Return = 0
			
		END IF	
		
		
	END IF
	
NEXT

n_cst_bso_validation	lnv_Validation
IF li_Problems > 0 THEN
	lnv_Validation = lnv_Disp.of_getValidation( )
END IF	

IF IsValid ( lnv_Validation ) THEN
	IF lnv_Validation.of_dowecontinue( ) THEN 
		li_Return = 1 
	ELSE
		li_Return = 0
	END IF
END IF

n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_Destroy( lnva_Events )

RETURN li_Return


end function

public function integer wf_setredraw (boolean ab_switch);Integer	li_Return

IF ab_Switch = TRUE THEN
	Hold_Redraw = FALSE
END IF

IF dw_Itin.SetRedraw ( ab_Switch ) = 1 AND &
	dw_Detail.SetRedraw ( ab_Switch ) = 1 THEN

	li_Return = 1

ELSE

	li_Return = -1

END IF

RETURN li_Return
end function

public function integer wf_setholdredraw (boolean ab_value);hold_redraw = ab_value
RETURN 1
end function

event open;/* A FEW NOTES ON THE STRANGE BEHAVIOR OF THE SHARED DATAWINDOWS AND ITS IMPACT ON SCRIPTS

Basically, the problem boils down to the fact that the sharing is not truly complete, and
that certain functions carried out on the target datawindows give different results than
the same functions carried out on the base datastores.  If there are two filtered rows, for
example, dw_itin.filteredcount() may return 0 and w_disp.ds_events.filteredcount() will
return 2.  This happens even if the function that put the rows there in the first place
(rowscopy, for example) was called on dw_itin, and dw_itin should presumably have been 
aware.  The solution is to call the functions against the base datastore, not the target 
datawindows, in these cases -- the base datastore gives the right answer.  Another even
stranger manifestation of this is the fact that a statement like 
val = dw_itin.object.de_arrtime.filter[2] can succeed, while 
val = dw_itin.getitemtime(2, "de_arrtime", filter!, false) will fail.  This is apparently
because the two statements are processed differently by powerbuilder, with the first 
going directly to the data and the second doing a preliminary (and false) check of the
filteredcount.

Unfortunately, we can't just convert all the references to the base datastore, though, 
because in some cases it is the datawindows that give the right answer and the datastores
that give the wrong one.  This is usually the case with display-related information, such
as selections and current rows.  For example, dw_itin.getrow() gives the right answer, 
while w_disp.ds_events.getrow() gives a different one (1, I think.)  Another variation is 
that vals[] = dw_itin.object.de_arrtime.selected does not populate the array, even if there 
are rows selected, apparently because the dot notation causes processing to bypass the 
datawindow and go directly to the underlying info, but in this case only the datawindow
has the info requested.  In this case, you need to do a getselectedrow loop against 
dw_itin (w_disp.ds_events.getselectedrow(x) will also give the wrong answer).

In the general strangeness category, if focus is on the last row of a datawindow and you
delete that row, you get a Windows GPF.  This does not happen if there is only one row, 
and you can get around it by using setrow before calling delete.  This comes up in w_ship.

Coordinating redraws is too hit-or-miss to even warrant discussion.

The bottom line, for all of this, is don't assume anything.  Just because something
ought to work does not mean that it will.  Verify that the results and values you expect
are the ones that are actually being delivered.   */


// RDT 8-6-03 added code to manage dw_itin_print

w_disp = this.parentwindow()

si_instance ++



this.x = 0
this.y = 0

//Some of the routing scripts require that there be an Itin_Date, even though it
//doesn't end up being used for the new 3rd Party Trip routing.  Although the real
//solution would be to remove those requirements, this is a workaround that enables
//the trip routing to function when the window opens directly to a trip, and there
//is no Itin_Date specified.

//***NOTE*** n_cst_Events.of_SequenceRange will malfunction without Date ( DateTime ( 
//provision to trim the time component off the date.******
Itin_Date = Date ( DateTime ( Today ( ) ) )

//Added 3.5.0
SetNull ( Last_Ship )

/////

st_ip[0] = st_ip_0
st_ip[1] = st_ip_1
st_ip[2] = st_ip_2
st_ip[3] = st_ip_3
st_ip[4] = st_ip_4
st_ip[5] = st_ip_5
st_ip[6] = st_ip_6
st_ip[7] = st_ip_7
st_ip[8] = st_ip_8
st_ip[9] = st_ip_9
st_ip[10] = st_ip_10
st_ip[11] = st_ip_11
st_ip[12] = st_ip_12
st_ip[13] = st_ip_13
st_ip[14] = st_ip_14
st_ip[15] = st_ip_15
st_ip[16] = st_ip_16
st_ip[17] = st_ip_17
st_ip[18] = st_ip_18
st_ip[19] = st_ip_19
st_ip[20] = st_ip_20
st_ip[21] = st_ip_21


ds_test = create datastore
ds_test.dataobject = "d_itin"

ds_ship_itin = create datastore
ds_ship_itin.dataobject = "d_ship_itin"

ds_test.settransobject(sqlca)
ds_ship_itin.settransobject(sqlca)

THIS.wf_SetShares ( )

//w_disp.ds_events.sharedata(dw_itin)
//w_disp.ds_events.sharedata(dw_detail)
THIS.ib_DisableCloseQuery = TRUE
dw_itin_print.visible = FALSE // RDT 8-6-03



THIS.of_SetResize ( TRUE ) 
inv_Resize.of_Register ( tab_route , inv_Resize.scaleright )
inv_Resize.of_Register ( tab_type , inv_Resize.scalerightbottom )
inv_Resize.of_Register ( dw_itin , inv_Resize.scalerightbottom )
inv_Resize.of_Register ( cb_goto , inv_Resize.FixedRight )
inv_Resize.of_Register ( sle_date , inv_Resize.FixedRight )
inv_Resize.of_Register ( st_datelabel , inv_Resize.FixedRight )
inv_Resize.of_Register ( vsb_date , inv_Resize.FixedRight )
THIS.Width = w_disp.Width
THIS.Height = w_Disp.Height - 100

n_cst_setting_numberofitindays	lnv_ItinDays
lnv_ItinDays = CREATE n_cst_setting_numberofitindays
uo_multiday.of_setvalue( Integer ( lnv_ItinDays.of_getvalue( ) ) )
uo_Multiday.of_SetBounds( 0/*lowerbound*/, 364/*Upperbound*/, 30/*Warn*/)
DESTROY ( lnv_ItinDays )





THIS.Post Event pfc_postopen( )


string modstring

//New-End Trip Sign
modstring = 'CREATE bitmap(band=detail filename="~~"off.bmp~~"~tif ( de_event_type = ~~"O~~", ~~"on.bmp~~", ~~"off.bmp~~" )" x="1651" y="632" height="37" width="42" border="0"  name=p_of visible="0~tif ( pos ( ~~"OF~~", de_event_type ) > 0, 1, 0 )" )'
dw_detail.modify(modstring)

//S.T.
modstring = 'CREATE bitmap(band=detail filename="~~"st.bmp~~"~tcase ( trac_type when ~~"N~~" then ~~"van.bmp~~" else ~~"st.bmp~~" )" x="1719" y="614" height="65" width="119" border="0"  name=p_st visible="0~tif ( de_tractor > 0 and not trac_type = ~~"T~~", 1, 0 )" )'
dw_detail.modify(modstring)

//Trailer1
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr1_length >= 40, case ( trlr1_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr1_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="1779" y="614" height="65" width="229~tif ( trlr1_length >= 40, 229, 115 )" border="0"  name=p_trlr1 visible="0~tif ( de_trailer1 > 0, 1, 0 )" )'
dw_detail.modify(modstring)
dw_detail.SetPosition("p_wheels", "", true)

//Trailer2
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr2_length >= 40, case ( trlr2_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr2_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2007~tif ( trlr1_length >= 40, 2007, 1893 )" y="614" height="65" width="229~tif ( trlr2_length >= 40, 229, 115 )" border="0"  name=p_trlr2 visible="0~tif ( de_trailer2 > 0, 1, 0 )" )'
dw_detail.modify(modstring)

//Trailer3
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr3_length >= 40, case ( trlr3_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr3_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2236~tif ( trlr1_length >= 40 and trlr2_length >= 40, 2236, if ( trlr1_length >= 40 or trlr2_length >= 40, 2122, 2007 ) )" y="614" height="65" width="229~tif ( trlr3_length >= 40, 229, 115 )" border="0"  name=p_trlr3 visible="0~tif ( de_trailer3 > 0, 1, 0 )" )'
dw_detail.modify(modstring)

//Container Set 1     x = 1779 (trlr1.x) + 5
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 1, 2 ) + ~~".bmp~~"" x="1784" y="614" height="45" width="225" border="0"  name=p_cntn01 visible="0~tif ( Integer ( Mid ( ContainerMap, 1, 2 ) ) > 0, 1, 0 )" )'
dw_detail.modify(modstring)

//Container Set 2
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 3, 2 ) + ~~".bmp~~"" x="2007~tif ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~", 2007, 1893 ) + 5" y="614" height="45" width="225" border="0"  name=p_cntn02 visible="0~tif ( Integer ( Mid ( ContainerMap, 3, 2 ) ) > 0, 1, 0 )" )'
dw_detail.modify(modstring)

//Container Set 3
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 5, 2 ) + ~~".bmp~~"" x="2236~tif ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) and ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 2236, if ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) or ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 2122, 2007 ) ) + 5" y="614" height="45" width="225" border="0"  name=p_cntn03 visible="0~tif ( Integer ( Mid ( ContainerMap, 5, 2 ) ) > 0, 1, 0 )" )'
dw_detail.modify(modstring)




////ActTrlr
//modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( acteq_length >= 40, case ( acteq_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( acteq_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2323~tif ( de_trailer1 > 0 and de_trailer2 > 0, if ( trlr1_length >= 40 and trlr2_length >= 40, 2323, if ( trlr1_length >= 40 or trlr2_length >= 40, 2209, 2094 ) ), if ( de_trailer1 > 0, if ( trlr1_length >= 40, 2094, 1980 ), 1898 ) )" y="564" height="65" width="229~tif ( acteq_length >= 40, 229, 115 )" border="0"  name=p_trlract visible="0~tif ( de_acteq > 0 and pos(~~"HR~~", de_event_type) > 0, 1, 0 )" )'
//dw_detail.modify(modstring)

////Hook-Drop Sign
//modstring = 'CREATE bitmap(band=detail filename="~~"drop.bmp~~"~tif ( de_event_type = ~~"H~~", if ( interch > 0, ~~"hookic.bmp~~", ~~"hook.bmp~~" ), if ( interch > 0, ~~"dropic.bmp~~", ~~"drop.bmp~~" ) )" x="2259~tif ( de_trailer1 > 0 and de_trailer2 > 0, if ( trlr1_length >= 40 and trlr2_length >= 40, 2259, if ( trlr1_length >= 40 or trlr2_length >= 40, 2145, 2030 ) ), if ( de_trailer1 > 0, if ( trlr1_length >= 40, 2030, 1916 ), 1834 ) )" y="580" height="37" width="42" border="0"  name=p_hr visible="0~tif ( pos(~~"HR~~", de_event_type) > 0, 1, 0 )" )'
//dw_detail.modify(modstring)

////Container1
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn1_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="1783~tcase ( pos ( de_multi_list, ~~"1~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"1~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 8, 120, 5 ) else 1783 )" y="564" height="45" width="225~tif ( cntn1_length >= 40, 225, 110 )" border="0"  name=p_cntn1 visible="0~tif ( de_container1 > 0, 1, 0 )" )'
//dw_detail.modify(modstring)
//
////Container2
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn2_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="1898~tcase ( pos ( de_multi_list, ~~"2~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"2~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 8, 120, 5 ) else 1898 )" y="564" height="45" width="225~tif ( cntn2_length >= 40, 225, 110 )" border="0"  name=p_cntn2 visible="0~tif ( de_container2 > 0, 1, 0 )" )'
//dw_detail.modify(modstring)
//
////Container3
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn3_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="2012~tcase ( pos ( de_multi_list, ~~"3~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"3~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 8, 120, 5 ) else 2012 )" y="564" height="45" width="225~tif ( cntn3_length >= 40, 225, 110 )" border="0"  name=p_cntn3 visible="0~tif ( de_container3 > 0, 1, 0 )" )'
//dw_detail.modify(modstring)
//
////Container4
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn4_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="2126~tcase ( pos ( de_multi_list, ~~"4~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"4~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 8, 120, 5 ) else 2126 )" y="564" height="45" width="225~tif ( cntn4_length >= 40, 225, 110 )" border="0"  name=p_cntn4 visible="0~tif ( de_container4 > 0, 1, 0 )" )'
//dw_detail.modify(modstring)
//
////ActCntn
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( acteq_length >= 40, if ( de_event_type = ~~"M~~", if ( interch > 0, ~~"4umic.bmp~~", ~~"4um.bmp~~" ), if ( interch > 0, ~~"4unic.bmp~~", ~~"4un.bmp~~" ) ), if ( de_event_type = ~~"M~~", if ( interch > 0, ~~"2umic.bmp~~", ~~"2um.bmp~~" ), if ( interch > 0, ~~"2unic.bmp~~", ~~"2un.bmp~~" ) ) )" x="2241~tcase ( pos ( de_multi_list, ~~"5~~" ) when 1, 2 then 1779 + if ( pos ( de_multi_list, ~~"5~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 8, 120, 5 ) else 2241 )" y="564" height="45" width="225~tif ( acteq_length >= 40, 225, 110 )" border="0"  name=p_cntnact visible="0~tif ( de_acteq > 0 and pos ( ~~"MN~~", de_event_type ) > 0, 1, 0 )" )'
//dw_detail.modify(modstring)

//dw_detail.setredraw(true)


//New-End Trip Sign
modstring = 'CREATE bitmap(band=detail filename="~~"off.bmp~~"~tif ( de_event_type = ~~"O~~", ~~"on.bmp~~", ~~"off.bmp~~" )" x="2629" y="16" height="37" width="42" border="0"  name=p_of visible="0~tif ( pos ( ~~"OF~~", de_event_type ) > 0, 1, 0 )" )'
dw_itin.modify(modstring)
modstring = 'CREATE bitmap(band=detail filename="~~"off.bmp~~"~tif ( de_event_type = ~~"O~~", ~~"on.bmp~~", ~~"off.bmp~~" )" x="2529" y="16" height="37" width="42" border="0"  name=p_of visible="0~tif ( pos ( ~~"OF~~", de_event_type ) > 0, 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03



//S.T.
modstring = 'CREATE bitmap(band=detail filename="~~"st.bmp~~"~tcase ( trac_type when ~~"N~~" then ~~"van.bmp~~" else ~~"st.bmp~~" )" x="2698" y="1" height="65" width="119" border="0"  name=p_st visible="0~tif ( de_tractor > 0 and not trac_type = ~~"T~~", 1, 0 )" )'
dw_itin.modify(modstring)
modstring = 'CREATE bitmap(band=detail filename="~~"st.bmp~~"~tcase ( trac_type when ~~"N~~" then ~~"van.bmp~~" else ~~"st.bmp~~" )" x="2598" y="1" height="65" width="119" border="0"  name=p_st visible="0~tif ( de_tractor > 0 and not trac_type = ~~"T~~", 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03

//Trailer1  ///////////////////////////////////////////////////
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr1_length >= 40, case ( trlr1_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr1_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2757" y="1" height="65" width="229~tif ( trlr1_length >= 40, 229, 115 )" border="0"  name=p_trlr1 visible="0~tif ( de_trailer1 > 0, 1, 0 )" )'
dw_itin.modify(modstring)
dw_itin.SetPosition("p_wheels", "", true)

modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr1_length >= 40, case ( trlr1_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr1_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2657" y="1" height="65" width="229~tif ( trlr1_length >= 40, 229, 115 )" border="0"  name=p_trlr1 visible="0~tif ( de_trailer1 > 0, 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03
dw_itin_Print.SetPosition("p_wheels", "", true)	// RDT 8-6-03

//Trailer2  ///////////////////////////////////////////////////
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr2_length >= 40, case ( trlr2_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr2_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2986~tif ( trlr1_length >= 40, 2986, 2871 )" y="1" height="65" width="229~tif ( trlr2_length >= 40, 229, 115 )" border="0"  name=p_trlr2 visible="0~tif ( de_trailer2 > 0, 1, 0 )" )'
dw_itin.modify(modstring)

modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr2_length >= 40, case ( trlr2_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr2_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="2886~tif ( trlr1_length >= 40, 2886, 2771 )" y="1" height="65" width="229~tif ( trlr2_length >= 40, 229, 115 )" border="0"  name=p_trlr2 visible="0~tif ( de_trailer2 > 0, 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03

//Trailer3  ///////////////////////////////////////////////////
modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr3_length >= 40, case ( trlr3_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr3_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="3137~tif ( trlr1_length >= 40 and trlr2_length >= 40, 3137, if ( trlr1_length >= 40 or trlr2_length >= 40, 3100, 2986 ) )" y="1" height="65" width="229~tif ( trlr3_length >= 40, 229, 115 )" border="0"  name=p_trlr3 visible="0~tif ( de_trailer3 > 0, 1, 0 )" )'
dw_itin.modify(modstring)

modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( trlr3_length >= 40, case ( trlr3_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( trlr3_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="3037~tif ( trlr1_length >= 40 and trlr2_length >= 40, 3037, if ( trlr1_length >= 40 or trlr2_length >= 40, 3000, 2886 ) )" y="1" height="65" width="229~tif ( trlr3_length >= 40, 229, 115 )" border="0"  name=p_trlr3 visible="0~tif ( de_trailer3 > 0, 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03

//Container Set 1   x = 2757 (trlr1.x) + 5  ///////////////////////////////////////////////////
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 1, 2 ) + ~~".bmp~~"" x="2762" y="1" height="45" width="225" border="0"  name=p_cntn01 visible="0~tif ( Integer ( Mid ( ContainerMap, 1, 2 ) ) > 0, 1, 0 )" )'
dw_itin.modify(modstring)

modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 1, 2 ) + ~~".bmp~~"" x="2762" y="1" height="45" width="225" border="0"  name=p_cntn01 visible="0~tif ( Integer ( Mid ( ContainerMap, 1, 2 ) ) > 0, 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03

//Container Set 2  ///////////////////////////////////////////////////
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 3, 2 ) + ~~".bmp~~"" x="2985~tif ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~", 2985, 2871 ) + 5" y="1" height="45" width="225" border="0"  name=p_cntn02 visible="0~tif ( Integer ( Mid ( ContainerMap, 3, 2 ) ) > 0, 1, 0 )" )'
dw_itin.modify(modstring)

modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 3, 2 ) + ~~".bmp~~"" x="2885~tif ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~", 2885, 2771 ) + 5" y="1" height="45" width="225" border="0"  name=p_cntn02 visible="0~tif ( Integer ( Mid ( ContainerMap, 3, 2 ) ) > 0, 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03

//Container Set 3  ///////////////////////////////////////////////////
modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 5, 2 ) + ~~".bmp~~"" x="3237~tif ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) and ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 3214, if ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) or ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 3100, 2985 ) ) + 5" y="1" height="45" width="225" border="0"  name=p_cntn03 visible="0~tif ( Integer ( Mid ( ContainerMap, 5, 2 ) ) > 0, 1, 0 )" )'
dw_itin.modify(modstring)

modstring = 'CREATE bitmap(band=detail filename="~~"11.bmp~~"~tMid ( ContainerMap, 5, 2 ) + ~~".bmp~~"" x="3137~tif ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) and ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 3114, if ( ( trlr1_length >= 40 OR Mid ( ContainerMap, 1, 2 ) > ~~"10~~" ) or ( trlr2_length >= 40 OR Mid ( ContainerMap, 3, 2 ) > ~~"10~~" ), 3000, 2885 ) ) + 5" y="1" height="45" width="225" border="0"  name=p_cntn03 visible="0~tif ( Integer ( Mid ( ContainerMap, 5, 2 ) ) > 0, 1, 0 )" )'
dw_itin_Print.modify(modstring)						// RDT 8-6-03


////ActTrlr
//modstring = 'CREATE bitmap(band=detail filename="~~"trlr.bmp~~"~tif ( acteq_length >= 40, case ( acteq_type when ~~"H~~" then ~~"4z.bmp~~" when ~~"F~~" then ~~"4f.bmp~~" else ~~"trlr.bmp~~" ), case ( acteq_type when ~~"H~~" then ~~"2z.bmp~~" when ~~"F~~" then ~~"2f.bmp~~" else ~~"pup.bmp~~" ) )" x="3301~tif ( de_trailer1 > 0 and de_trailer2 > 0, if ( trlr1_length >= 40 and trlr2_length >= 40, 3301, if ( trlr1_length >= 40 or trlr2_length >= 40, 3187, 3073 ) ), if ( de_trailer1 > 0, if ( trlr1_length >= 40, 3073, 2958 ), 2876 ) )" y="1" height="65" width="229~tif ( acteq_length >= 40, 229, 115 )" border="0"  name=p_trlract visible="0~tif ( de_acteq > 0 and pos(~~"HR~~", de_event_type) > 0, 1, 0 )" )'
//dw_itin.modify(modstring)
//
////Hook-Drop Sign
//modstring = 'CREATE bitmap(band=detail filename="~~"drop.bmp~~"~tif ( de_event_type = ~~"H~~", if ( interch > 0, ~~"hookic.bmp~~", ~~"hook.bmp~~" ), if ( interch > 0, ~~"dropic.bmp~~", ~~"drop.bmp~~" ) )" x="3237~tif ( de_trailer1 > 0 and de_trailer2 > 0, if ( trlr1_length >= 40 and trlr2_length >= 40, 3237, if ( trlr1_length >= 40 or trlr2_length >= 40, 3123, 3009 ) ), if ( de_trailer1 > 0, if ( trlr1_length >= 40, 3009, 2894 ), 2812 ) )" y="16" height="37" width="42" border="0"  name=p_hr visible="0~tif ( pos(~~"HR~~", de_event_type) > 0, 1, 0 )" )'
//dw_itin.modify(modstring)
//
////Container1
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn1_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="2762~tcase ( pos ( de_multi_list, ~~"1~~" ) when 1, 2 then 2757 + if ( pos ( de_multi_list, ~~"1~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"1~~" ) = 8, 120, 5 ) else 1783 )" y="1" height="45" width="225~tif ( cntn1_length >= 40, 225, 110 )" border="0"  name=p_cntn1 visible="0~tif ( de_container1 > 0, 1, 0 )" )'
//dw_itin.modify(modstring)
//
////Container2
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn2_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="2876~tcase ( pos ( de_multi_list, ~~"2~~" ) when 1, 2 then 2757 + if ( pos ( de_multi_list, ~~"2~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"2~~" ) = 8, 120, 5 ) else 1898 )" y="1" height="45" width="225~tif ( cntn2_length >= 40, 225, 110 )" border="0"  name=p_cntn2 visible="0~tif ( de_container2 > 0, 1, 0 )" )'
//dw_itin.modify(modstring)
//
////Container3
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn3_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="2990~tcase ( pos ( de_multi_list, ~~"3~~" ) when 1, 2 then 2757 + if ( pos ( de_multi_list, ~~"3~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"3~~" ) = 8, 120, 5 ) else 2012 )" y="1" height="45" width="225~tif ( cntn3_length >= 40, 225, 110 )" border="0"  name=p_cntn3 visible="0~tif ( de_container3 > 0, 1, 0 )" )'
//dw_itin.modify(modstring)
//
////Container4
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( cntn4_length >= 40, ~~"4u.bmp~~", ~~"2u.bmp~~" )" x="3105~tcase ( pos ( de_multi_list, ~~"4~~" ) when 1, 2 then 2757 + if ( pos ( de_multi_list, ~~"4~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"4~~" ) = 8, 120, 5 ) else 2126 )" y="1" height="45" width="225~tif ( cntn4_length >= 40, 225, 110 )" border="0"  name=p_cntn4 visible="0~tif ( de_container4 > 0, 1, 0 )" )'
//dw_itin.modify(modstring)
//
////ActCntn
//modstring = 'CREATE bitmap(band=detail filename="~~"4u.bmp~~"~tif ( acteq_length >= 40, if ( de_event_type = ~~"M~~", if ( interch > 0, ~~"4umic.bmp~~", ~~"4um.bmp~~" ), if ( interch > 0, ~~"4unic.bmp~~", ~~"4un.bmp~~" ) ), if ( de_event_type = ~~"M~~", if ( interch > 0, ~~"2umic.bmp~~", ~~"2um.bmp~~" ), if ( interch > 0, ~~"2unic.bmp~~", ~~"2un.bmp~~" ) ) )" x="3219~tcase ( pos ( de_multi_list, ~~"5~~" ) when 1, 2 then 2757 + if ( pos ( de_multi_list, ~~"5~~" ) = 2, 120, 5 ) when 3, 4 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr2.x~~" ), 7, len ( describe ( ~~"p_trlr2.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 4, 120, 5 ) when 5, 6 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlr3.x~~" ), 7, len ( describe ( ~~"p_trlr3.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 6, 120, 5 ) when 7, 8 then integer ( describe ( ~~"evaluate ( ~' ~~" + mid ( describe ( ~~"p_trlract.x~~" ), 7, len ( describe ( ~~"p_trlract.x~~" ) ) - 7 ) + ~~" ~', ~~" + string ( getrow () ) + ~~")~~" ) ) + if ( pos ( de_multi_list, ~~"5~~" ) = 8, 120, 5 ) else 3219 )" y="1" height="45" width="225~tif ( acteq_length >= 40, 225, 110 )" border="0"  name=p_cntnact visible="0~tif ( de_acteq > 0 and pos ( ~~"MN~~", de_event_type ) > 0, 1, 0 )" )'
//dw_itin.modify(modstring)
end event

on w_itin.create
int iCurrent
call super::create
this.uo_multiday=create uo_multiday
this.st_multiday=create st_multiday
this.st_ip_6=create st_ip_6
this.st_ip_7=create st_ip_7
this.st_ip_8=create st_ip_8
this.st_ip_9=create st_ip_9
this.st_ip_10=create st_ip_10
this.st_ip_11=create st_ip_11
this.st_ip_12=create st_ip_12
this.st_ip_13=create st_ip_13
this.st_ip_14=create st_ip_14
this.st_ip_15=create st_ip_15
this.st_ip_16=create st_ip_16
this.st_ip_17=create st_ip_17
this.st_ip_18=create st_ip_18
this.dw_itin_print=create dw_itin_print
this.cb_selectiondetails=create cb_selectiondetails
this.vsb_date=create vsb_date
this.sle_date=create sle_date
this.st_datelabel=create st_datelabel
this.st_ip_19=create st_ip_19
this.st_ip_5=create st_ip_5
this.st_ip_20=create st_ip_20
this.st_ip_21=create st_ip_21
this.st_ip_4=create st_ip_4
this.st_ip_3=create st_ip_3
this.st_ip_2=create st_ip_2
this.st_ip_1=create st_ip_1
this.st_ip_0=create st_ip_0
this.dw_itin=create dw_itin
this.tab_type=create tab_type
this.dw_detail=create dw_detail
this.cb_goto=create cb_goto
this.dw_tripdetail=create dw_tripdetail
this.tab_route=create tab_route
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_multiday
this.Control[iCurrent+2]=this.st_multiday
this.Control[iCurrent+3]=this.st_ip_6
this.Control[iCurrent+4]=this.st_ip_7
this.Control[iCurrent+5]=this.st_ip_8
this.Control[iCurrent+6]=this.st_ip_9
this.Control[iCurrent+7]=this.st_ip_10
this.Control[iCurrent+8]=this.st_ip_11
this.Control[iCurrent+9]=this.st_ip_12
this.Control[iCurrent+10]=this.st_ip_13
this.Control[iCurrent+11]=this.st_ip_14
this.Control[iCurrent+12]=this.st_ip_15
this.Control[iCurrent+13]=this.st_ip_16
this.Control[iCurrent+14]=this.st_ip_17
this.Control[iCurrent+15]=this.st_ip_18
this.Control[iCurrent+16]=this.dw_itin_print
this.Control[iCurrent+17]=this.cb_selectiondetails
this.Control[iCurrent+18]=this.vsb_date
this.Control[iCurrent+19]=this.sle_date
this.Control[iCurrent+20]=this.st_datelabel
this.Control[iCurrent+21]=this.st_ip_19
this.Control[iCurrent+22]=this.st_ip_5
this.Control[iCurrent+23]=this.st_ip_20
this.Control[iCurrent+24]=this.st_ip_21
this.Control[iCurrent+25]=this.st_ip_4
this.Control[iCurrent+26]=this.st_ip_3
this.Control[iCurrent+27]=this.st_ip_2
this.Control[iCurrent+28]=this.st_ip_1
this.Control[iCurrent+29]=this.st_ip_0
this.Control[iCurrent+30]=this.dw_itin
this.Control[iCurrent+31]=this.tab_type
this.Control[iCurrent+32]=this.dw_detail
this.Control[iCurrent+33]=this.cb_goto
this.Control[iCurrent+34]=this.dw_tripdetail
this.Control[iCurrent+35]=this.tab_route
end on

on w_itin.destroy
call super::destroy
destroy(this.uo_multiday)
destroy(this.st_multiday)
destroy(this.st_ip_6)
destroy(this.st_ip_7)
destroy(this.st_ip_8)
destroy(this.st_ip_9)
destroy(this.st_ip_10)
destroy(this.st_ip_11)
destroy(this.st_ip_12)
destroy(this.st_ip_13)
destroy(this.st_ip_14)
destroy(this.st_ip_15)
destroy(this.st_ip_16)
destroy(this.st_ip_17)
destroy(this.st_ip_18)
destroy(this.dw_itin_print)
destroy(this.cb_selectiondetails)
destroy(this.vsb_date)
destroy(this.sle_date)
destroy(this.st_datelabel)
destroy(this.st_ip_19)
destroy(this.st_ip_5)
destroy(this.st_ip_20)
destroy(this.st_ip_21)
destroy(this.st_ip_4)
destroy(this.st_ip_3)
destroy(this.st_ip_2)
destroy(this.st_ip_1)
destroy(this.st_ip_0)
destroy(this.dw_itin)
destroy(this.tab_type)
destroy(this.dw_detail)
destroy(this.cb_goto)
destroy(this.dw_tripdetail)
destroy(this.tab_route)
end on

event close;destroy ds_ship_itin
destroy ds_test

if isvalid(iw_map) then close(iw_map)
if isvalid(iw_mapstreets) then close (iw_mapstreets)
if isvalid(reportwin) then close(reportwin)

destroy inv_cst_toolmenu_manager

// RDT 4-1-03 Start 

If IsValid ( inv_PSR_Man  ) Then Destroy inv_PSR_Man	
If IsValid ( inv_shipment ) Then Destroy inv_shipment
If IsValid ( inv_dispatch ) Then Destroy inv_dispatch
// RDT 4-1-03 End 

IF IsValid ( inv_Windowstate ) THEN
	inv_windowstate.of_Savestate( )
END IF

THIS.wf_SetWindowstate( FALSE )

si_instance --

end event

event mousemove;if whats_on < 1 then return

if isnull(xpos) or isnull(ypos) or xpos < st_ip[0].x or xpos > st_ip[0].x + st_ip[0].width &
	or ypos < st_ip[0].y or ypos > st_ip[numst].y + st_ip[numst].height then
	for stloop = 0 to numst
		st_ip[stloop].textcolor = 16777215
	next
	return
end if

for stloop = 0 to numst
	if ypos >= st_ip[stloop].y and ypos < st_ip[stloop].y + st_ip[stloop].height then &
		st_ip[stloop].textcolor = 255 else st_ip[stloop].textcolor = 16777215
next
end event

event mousedown;Integer	li_IPClicked

IF This.Whats_On > 0 THEN

	SetNull ( li_IPClicked )

	if xpos < st_ip[0].x or xpos > st_ip[0].x + st_ip[0].width &
		or ypos < st_ip[0].y or ypos > st_ip[numst].y + st_ip[numst].height then

		//Click was outside the ip area

	else
	
		for stloop = 0 to numst
			if ypos >= st_ip[stloop].y and ypos < st_ip[stloop].y + st_ip[stloop].height and &
				st_ip[stloop].visible and st_ip[stloop].textcolor = 255 then
		
				li_IPClicked = stloop		
				EXIT
		
			end if
		next

	end if

	This.Event ue_IPAnswer ( li_IPClicked )

END IF
end event

event show;dw_detail.post setfocus()

THIS.wf_SetWindowState ( TRUE )
end event

event rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]

lsa_parm_labels[1] = "MENU_TYPE"
laa_parm_values[1] = "PRINT"
lsa_parm_labels[2] = "PRINT_OBJECT"
laa_parm_values[2] = w_disp
f_pop_standard(lsa_parm_labels, laa_parm_values)
end event

event pfc_postopen;call super::pfc_postopen;n_cst_Dws	lnv_Dws
THIS.Width = w_disp.Width
THIS.Height = w_Disp.Height
//THIS.event resize( 0 ,w_disp.Width -25, w_Disp.Height - 100 )
lnv_Dws.of_CreateHighlight ( dw_itin )
end event

event resize;If IsValid (inv_resize) Then
	inv_resize.Event pfc_Resize (sizetype, newwidth ,newheight )
End If
RETURN 1
end event

type uo_multiday from u_cst_integerspin within w_itin
integer x = 2025
integer y = 1032
integer width = 197
integer height = 84
end type

event ue_valuechanged;call super::ue_valuechanged;SetPointer ( HourGlass! )
Parent.Display_itin( itin_type , itin_id , itin_date )
end event

on uo_multiday.destroy
call u_cst_integerspin::destroy
end on

type st_multiday from statictext within w_itin
integer x = 2226
integer y = 1044
integer width = 283
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Multi-day"
boolean focusrectangle = false
end type

type st_ip_6 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1604
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_7 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1672
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_8 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1740
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_9 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1808
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_10 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1876
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_11 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1944
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_12 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2012
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_13 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2080
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_14 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2148
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_15 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2216
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_16 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2284
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_17 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2352
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_18 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2420
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type dw_itin_print from datawindow within w_itin
event dwnmousemove pbm_dwnmousemove
event type integer ue_selectcurrentrow ( boolean ab_scrolltorow )
event type integer ue_duplicatetimes ( long al_baserow )
event type integer ue_defaulttimes ( )
event type integer ue_timeclicked ( long al_row )
event type integer ue_assigntoevent ( long al_eventrow,  string as_eqtype,  string as_eqref,  long al_eqid )
integer x = 101
integer y = 1956
integer width = 3470
integer height = 292
string dataobject = "d_itin_print"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_selectcurrentrow;//Returns : 1 (CurrentRow selected), 0 (No current row), -1 (Currently not implemented)

Long		ll_CurrentRow

Integer	li_Return = 1


IF li_Return = 1 THEN

	ll_CurrentRow = This.GetRow ( )

	IF ll_CurrentRow > 0 THEN

		This.SelectRow ( 0, FALSE )

		IF ab_ScrollToRow THEN
			This.ScrollToRow ( ll_CurrentRow )
		END IF

		This.SelectRow ( ll_CurrentRow, TRUE )

	ELSE
		li_Return = 0

	END IF

END IF


RETURN li_Return
end event

event type integer ue_duplicatetimes(long al_baserow);Time		lt_BaseTimeArrived, &
			lt_BaseTimeDeparted, &
			lt_Check, &
			lt_TimeArrived, &
			lt_TimeDeparted
Boolean	lb_ExistingTimes, &
			lb_ConfirmEvents
String	ls_MessageHeader = "Duplicate Times", &
			ls_Message, &
			ls_ComputedTime, &
			ls_UserId
Long		ll_FirstRow, &
			ll_Row, &
			ll_Id
Integer	li_SkippedCount
n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
Boolean	lb_redisplay

lnv_Event = CREATE n_cst_beo_Event

Integer	li_Return = 1


IF li_Return = 1 THEN

	ll_FirstRow = This.GetSelectedRow ( 0 )
	
	IF ll_FirstRow > 0 THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF al_BaseRow > 0 AND al_BaseRow <= This.RowCount ( ) THEN
		//OK
	//ELSEIF IsNull ( al_BaseRow ) THEN
		//Could implement some way of determining the row, if it wasn't specified.
		//Not going to bother with this now, though.
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( This )
	lnv_Event.of_SetSourceRow ( al_BaseRow )

	lt_BaseTimeArrived = lnv_Event.of_GetTimeArrived ( )
	lt_BaseTimeDeparted = lnv_Event.of_GetTimeDeparted ( )

	//Set verification message.
	ls_Message = "OK to set " + string(lt_BaseTimeArrived, "h:mm AM/PM") + " and " +&
		string(lt_BaseTimeDeparted, "h:mm AM/PM") + " as the arrival and departure times "+&
		"for these events?"

	//Scan selected rows to see if there are any existing arrival or departure
	//times specified that will be overwritten, and if so, set a flag so we
	//can warn the user.

	ll_Row = 0

	do

		ll_Row = This.getselectedrow(ll_Row)

		if ll_Row > 0 then

			lnv_Event.of_SetSourceRow ( ll_Row )

			//Check TimeArrived.
			lt_Check = lnv_Event.of_GetTimeArrived ( )

			if isnull(lt_Check) or lt_Check = lt_BaseTimeArrived then
				//No conflict.  Proceed.
			ELSE
				//Time would be overwritten.  Set warning flag.
				lb_ExistingTimes = true
				EXIT
			END IF

			//Check TimeDeparted
			lt_Check = lnv_Event.of_GetTimeDeparted ( )

			if isnull(lt_Check) or lt_Check = lt_BaseTimeDeparted then
				//No conflict.  Proceed.
			ELSE
				//Time would be overwritten.  Set warning flag.
				lb_ExistingTimes = true
				EXIT
			END IF

		end if

	loop while ll_Row > 0


	//If there were existing times, add that warning to the verification message.

	IF lb_ExistingTimes THEN
		ls_Message += "~n~n(Other existing times will be overwritten.)"
	END IF


	//Verify operation with user using message values prepared above.
	
	IF messagebox( ls_MessageHeader, ls_Message, question!, okcancel!, 1) = 2 THEN
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF messagebox ( ls_MessageHeader, "Do you also want to confirm the events as "+&
		"completed?~n~n(Any events that have not been fully assigned will be "+&
		"skipped.)", question!, yesno!, 1) = 1 THEN
	
		lb_ConfirmEvents = true
	
	END IF


	//Get the dispatch manager.
	lnv_Dispatch = Parent.wf_GetDispatchManager ( )


	//Set redraw false to avoid flicker.
	
	dw_detail.setredraw(false)
	This.setredraw(false)
	
	
	//Perform set time processing.
	
	ll_Row = 0
	
	do
		ll_Row = This.getselectedrow(ll_Row)
	
		if ll_Row > 0 then

			lnv_Event.of_SetSourceRow ( ll_Row )
	
			lt_TimeArrived = lnv_Event.of_GetTimeArrived ( )
			lt_TimeDeparted = lnv_Event.of_GetTimeDeparted ( )
	
			IF lt_TimeArrived = lt_BaseTimeArrived THEN
				//Times already match
			ELSE
				IF lnv_Event.of_SetTimeArrived ( lt_BaseTimeArrived ) = 1 THEN
					//OK
				ELSE
					//Error
				END IF
			END IF

			IF lt_TimeDeparted = lt_BaseTimeDeparted THEN
				//Times already match
			ELSE
				IF lnv_Event.of_SetTimeDeparted ( lt_BaseTimeDeparted ) = 1 THEN
					//OK
				ELSE
					//Error
				END IF
			END IF
	
	
			//If the flag is set to confirm events, attempt to do so for this event.

			IF lb_ConfirmEvents THEN
	
				ll_Id = lnv_Event.of_GetId ( )

				IF IsValid ( lnv_Dispatch ) AND NOT IsNull ( ll_Id ) THEN
					parent.setRedraw( false )	//added for bobtail
					CHOOSE CASE lnv_Dispatch.of_ConfirmEvent ( ll_Id, TRUE /*Interactive*/ )
	
					CASE 1
						//OK, confirmed
						tab_route.Event ue_EventsConfirmed ( )
						/////////DAN ADDED 1- 24-07
						// I needed to do this for autoaddbobtailevents
						n_cst_setting_autoaddbobtail lnv_setting
						lnv_setting = create n_cst_setting_autoaddbobtail
						IF lnv_setting.of_getValue( ) = lnv_setting.cs_yes THEN
							//display_itin( itin_type , itin_id, itin_date )  	//DEK: 3-29-07 moved to after loop
							lb_redisplay = true
						END IF
						DESTROY lnv_setting
						//////////////////////////
					CASE 0
						//Was already confirmed.
	
					CASE -1
						//Could not be confirmed
						li_SkippedCount ++
	
					CASE ELSE
						//Unexpected return
						li_SkippedCount ++
	
					END CHOOSE
					parent.setRedraw( true )	//added for bobtail
				ELSE
					li_SkippedCount ++

				END IF
	
			END IF
	
		end if
	
	loop while ll_Row > 0
	
	//DEK 3-29-07, I moved this to here because similar functionality in ue_defaulttimes
	//was getting messed up as a result of the rows becoming deselected in the loop 
	//as a result of the following display call.  THis should probably happen outside
	//the loop any how as I suspect we'd have the same problem here.
	IF lb_redisplay THEN
		display_itin( itin_type , itin_id, itin_date )
	END IF
	//////////////////////////////////////////
	
	w_disp.wf_reset_times(ll_FirstRow, "ITIN!")
	
	This.selectrow(0, false)
	This.setredraw(true)
	dw_detail.setredraw(true)
	
	IF li_SkippedCount > 0 THEN
		messagebox( ls_MessageHeader, "Times were set successfully.~n~n" +&
			string(li_SkippedCount) + " event(s) could not be confirmed.", exclamation!)
	END IF

END IF

DESTROY ( lnv_Event )

RETURN li_Return
end event

event type integer ue_defaulttimes();Time		lt_TimeArrived, &
			lt_TimeDeparted
Boolean	lb_ConfirmEvents, &
			lb_AllowConf, &
			lb_NoSelection
String	ls_MessageHeader = "Accept Default Times", &
			ls_Message, &
			ls_ComputedTime
Long		ll_FirstRow, &
			ll_Row, &
			ll_Id
Integer	li_SkippedCount
n_cst_beo_Event		lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
Boolean	lb_redisplay
lnv_Event = CREATE n_cst_beo_Event

Integer	li_Return = 1


IF li_Return = 1 THEN

	ll_FirstRow = This.GetSelectedRow ( 0 )
	
	IF ll_FirstRow > 0 THEN
		//OK
	ELSE
		lb_NoSelection = TRUE
		ll_FirstRow = This.GetRow ( )
	END IF

	IF ll_FirstRow > 0 THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	//Set verification message.
	ls_Message = "OK to accept the calculated times for these events?" +&
		"~n~n(Any times already entered will not be changed.)"


	//Verify operation with user.
	
	IF messagebox( ls_MessageHeader, ls_Message, question!, okcancel!, 1) = 2 THEN
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF messagebox ( ls_MessageHeader, "Do you also want to confirm the events as "+&
		"completed?~n~n(Any events that have not been fully assigned will be "+&
		"skipped.)", question!, yesno!, 1) = 1 THEN
	
		lb_ConfirmEvents = true
	
	END IF

	//Initialize the source for the event beo.
	lnv_Event.of_SetSource ( This )  //The old code set values on the cache.  Should this??

	//Get the dispatch manager.
	lnv_Dispatch = Parent.wf_GetDispatchManager ( )


	//Set redraw false to avoid flicker.
	
	dw_detail.setredraw(false)
	This.setredraw(false)
	
	
	//Perform set time processing.
	
	ll_Row = 0
	
	do

		IF lb_NoSelection THEN

			IF ll_Row = 0 THEN
				//First pass through.  Use the current row.
				ll_Row = ll_FirstRow
			ELSE
				//Second pass through.  We're done.
				ll_Row = 0
			END IF

		ELSE

			ll_Row = This.getselectedrow(ll_Row)

		END IF

	
		if ll_Row > 0 then

			lnv_Event.of_SetSourceRow ( ll_Row )
			lb_AllowConf = TRUE
	
			lt_TimeArrived = lnv_Event.of_GetTimeArrived ( )
			lt_TimeDeparted = lnv_Event.of_GetTimeDeparted ( )
	
			IF IsNull ( lt_TimeArrived ) THEN

				//If user has not already specified a time, try to set computed value.

				ls_ComputedTime = This.Object.cc_ArrStr [ ll_Row ]

				IF IsTime ( ls_ComputedTime ) THEN
					IF lnv_Event.of_SetTimeArrived ( Time ( ls_ComputedTime ) ) = 1 THEN
						//OK
					ELSE
						//Error, or value was rejected.
						lb_AllowConf = FALSE
					END IF
				ELSE
					lb_AllowConf = FALSE
				END IF

			END IF


			IF IsNull ( lt_TimeDeparted ) THEN

				//If user has not already specified a time, try to set computed value.

				ls_ComputedTime = This.Object.cc_DepStr [ ll_Row ]

				IF IsTime ( ls_ComputedTime ) THEN
					IF lnv_Event.of_SetTimeDeparted ( Time ( ls_ComputedTime ) ) = 1 THEN
						//OK
					ELSE
						//Error, or value was rejected.
						lb_AllowConf = FALSE
					END IF
				ELSE
					lb_AllowConf = FALSE
				END IF

			END IF
	
	
			//If the flag is set to confirm events, attempt to do so for this event.

			IF lb_ConfirmEvents AND lb_AllowConf THEN

				ll_Id = lnv_Event.of_GetId ( )

				IF IsValid ( lnv_Dispatch ) AND NOT IsNull ( ll_Id ) THEN
					parent.setRedraw( false )	//added for bobtail
					CHOOSE CASE lnv_Dispatch.of_ConfirmEvent ( ll_Id, TRUE /*Interactive*/ )
	
					CASE 1
						//OK, confirmed
						tab_route.Event ue_EventsConfirmed ( )
						/////////DAN ADDED 1- 24-07
						// I needed to do this for autoaddbobtailevents
						n_cst_setting_autoaddbobtail lnv_setting
						lnv_setting = create n_cst_setting_autoaddbobtail
						IF lnv_setting.of_getValue( ) = lnv_setting.cs_yes THEN
							//display_itin( itin_type , itin_id, itin_date )	//DEK 3-29-07 moved to after loop
							lb_redisplay = true
						END IF
						DESTROY lnv_setting
						//////////////////////////
					CASE 0
						//Was already confirmed.
	
					CASE -1
						//Could not be confirmed
						li_SkippedCount ++
	
					CASE ELSE
						//Unexpected return
						li_SkippedCount ++
	
					END CHOOSE
					parent.setRedraw( true )	//added for bobtail
				ELSE
					li_SkippedCount ++

				END IF
	
			END IF
	
		end if
	
	loop while ll_Row > 0
	
	//DEK 3-29-07, I moved this to here because similar functionality in ue_defaulttimes
	//was getting messed up as a result of the rows becoming deselected in the loop 
	//as a result of the following display call.  THis should probably happen outside
	//the loop any how as I suspect we'd have the same problem here.
	IF lb_redisplay THEN
		display_itin( itin_type , itin_id, itin_date )
	END IF
	//////////////////////////////////////////
	
	w_disp.wf_reset_times(ll_FirstRow, "ITIN!")
	
	This.selectrow(0, false)
	This.setredraw(true)
	dw_detail.setredraw(true)
	
	IF li_SkippedCount > 0 THEN
		messagebox( ls_MessageHeader, "Times were set successfully.~n~n" +&
			string(li_SkippedCount) + " event(s) could not be confirmed.", exclamation!)
	END IF

END IF

DESTROY (lnv_Event)

RETURN li_Return
end event

event ue_timeclicked;Time		lt_ClickedTimeArrived, &
			lt_ClickedTimeDeparted
Long		ll_SelectedCount, &
			lla_SelectedIds[]
Integer	li_Result
String	lsa_parm_labels[]
Any		laa_parm_values[]
n_cst_beo_Event	lnv_Event
n_cst_Dws			lnv_Dws

Integer	li_Return = 1

lnv_Event = CREATE n_cst_beo_Event

IF li_Return = 1 THEN

	IF al_Row > 0 AND al_Row <= This.RowCount ( ) THEN
		//OK
	//ELSEIF IsNull ( al_Row ) THEN
		//Could implement some way of determining the row, if it wasn't specified.
		//Not going to bother with this now, though.
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( This )
	lnv_Event.of_SetSourceRow ( al_Row )

	lt_ClickedTimeArrived = lnv_Event.of_GetTimeArrived ( )
	lt_ClickedTimeDeparted = lnv_Event.of_GetTimeDeparted ( )

	ll_SelectedCount = lnv_Dws.of_SelectedCount ( This, lla_SelectedIds )


	//If both TimeArrived and TimeDeparted have been specified in the row clicked, 
	//and more than one target row is selected, give the user the duplicate times option.
	
	IF ll_SelectedCount > 1 AND &
		NOT (isnull(lt_ClickedTimeArrived) or isnull(lt_ClickedTimeDeparted)) THEN
	
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "&Duplicate Times"
	
	END IF
	
	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "&Accept Default Times"


	//Display popup menu to determine which type of time processing the user wants.
	
	CHOOSE CASE f_pop_standard ( lsa_parm_labels, laa_parm_values )
	
	CASE "DUPLICATE TIMES"

		li_Result = This.Event ue_DuplicateTimes ( al_Row )

		CHOOSE CASE li_Result

		CASE 1, 0, -1
			li_Return = li_Result

		CASE ELSE
			li_Return = -1

		END CHOOSE

	CASE "ACCEPT DEFAULT TIMES"
	
		li_Result = This.Event ue_DefaultTimes ( )

		CHOOSE CASE li_Result

		CASE 1, 0, -1
			li_Return = li_Result

		CASE ELSE
			li_Return = -1

		END CHOOSE

	
	CASE ELSE  //User cancel
		li_Return = 0
	
	END CHOOSE

END IF

DESTROY ( lnv_Event )


RETURN li_Return
end event

event ue_assigntoevent;Date	ld_Null 
Long	ll_EventID
Int	li_ItinType

SetNull ( ld_Null )
SetNull ( ll_EventID )

THIS.SetRow ( al_eventrow )
n_cst_EquipmentManager	lnv_Equip

li_ItinType = lnv_Equip.of_GetItinType ( as_eqtype )

tab_route.tabpage_Assignments.Event ue_Select ( li_ItinType , al_eqid )
tab_route.tabpage_Assignments.Event ue_Refresh ( )
tab_route.tabpage_Assignments.Event ue_Assign ( li_ItinType , al_eqid , ld_Null , ll_EventID , gc_Dispatch.ci_InsertionStyle_assignment , FALSE )

wf_SetRedraw ( TRUE )
RETURN 1
end event

event constructor;n_cst_LicenseManager	lnv_LicenseManager
Integer	li_BaseTimeZone
n_cst_Dws	lnv_Dws
n_cst_Events	lnv_Events

lnv_Dws.of_CreateHighlight ( This )

li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )
This.Modify ( "comp_tz_home.Expression = '" + String ( li_BaseTimeZone ) + "'" )

This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
end event

type cb_selectiondetails from commandbutton within w_itin
integer x = 1943
integer y = 1028
integer width = 274
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Details"
end type

event clicked;CHOOSE CASE Parent.wf_GetContext ( )

CASE gc_Dispatch.cs_Context_Trip

	IF NOT IsNull ( Itin_Id ) THEN
		dw_tripdetail.of_setitinerarydw ( dw_itin )
		dw_TripDetail.Show ( )
		dw_TripDetail.SetFocus ( )
		dw_detail.of_CacheCompanies ( )
	END IF

END CHOOSE
end event

type vsb_date from vscrollbar within w_itin
integer x = 3173
integer y = 1028
integer width = 55
integer height = 84
boolean stdwidth = false
end type

event lineup;date new_date
n_cst_string lnv_string
new_date = lnv_string.of_SpecialDate(sle_date.text)

if isnull(new_date) then
	if isdate(left(sle_date.text, 8)) then
		new_date = date(left(sle_date.text, 8))
	elseif isdate(left(sle_date.text, 7)) then
		new_date = date(left(sle_date.text, 7))
	elseif isdate(left(sle_date.text, 6)) then
		new_date = date(left(sle_date.text, 6))
	else
		beep(1)
		return
	end if
end if

new_date = relativedate(new_date, 1)

if keydown(keycontrol!) then
	sle_date.selecttext(1, len(sle_date.text))
	sle_date.replacetext(upper(string(new_date, "m/d/yy (ddd.)")))
	//Replacetext is used so that the control knows the text has changed
	sle_date.selecttext(1, len(sle_date.text))
	sle_date.setfocus()
else
	if display_itin(itin_type, itin_id, new_date) < 1 then
		messagebox("Change Itinerary Date", "Could not process request.~n~nPlease retry.", &
			exclamation!)
	end if
	dw_detail.setfocus()
end if
end event

event rbuttondown;parent.setfocus() //To trigger modified of sle_date
end event

event linedown;date new_date
n_cst_string lnv_string
new_date = lnv_string.of_SpecialDate(sle_date.text)

if isnull(new_date) then
	if isdate(left(sle_date.text, 8)) then
		new_date = date(left(sle_date.text, 8))
	elseif isdate(left(sle_date.text, 7)) then
		new_date = date(left(sle_date.text, 7))
	elseif isdate(left(sle_date.text, 6)) then
		new_date = date(left(sle_date.text, 6))
	else
		beep(1)
		return
	end if
end if

new_date = relativedate(new_date, -1)

if keydown(keycontrol!) then
	sle_date.selecttext(1, len(sle_date.text))
	sle_date.replacetext(upper(string(new_date, "m/d/yy (ddd.)")))
	//Replacetext is used so that the control knows the text has changed
	sle_date.selecttext(1, len(sle_date.text))
	sle_date.setfocus()
else
	if display_itin(itin_type, itin_id, new_date) < 1 then
		messagebox("Change Itinerary Date", "Could not process request.~n~nPlease retry.", &
			exclamation!)
	end if
	dw_detail.setfocus()
end if
end event

type sle_date from singlelineedit within w_itin
event ue_wheelscroll pbm_vscroll
integer x = 2734
integer y = 1028
integer width = 434
integer height = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_wheelscroll;// RDT 7-18-03 
Message.Processed = True
end event

event modified;date new_date
n_cst_string lnv_string
new_date = lnv_string.of_SpecialDate(this.text)

if isnull(new_date) then
	if isdate(left(this.text, 8)) then
		new_date = date(left(this.text, 8))
	elseif isdate(left(this.text, 7)) then
		new_date = date(left(this.text, 7))
	elseif isdate(left(this.text, 6)) then
		new_date = date(left(this.text, 6))
	else
		beep(1)
		goto failure
	end if
end if

if display_itin(itin_type, itin_id, new_date) < 1 then
	messagebox("Change Itinerary Date", "Could not process request.~n~nPlease retry.", &
		exclamation!)
	goto failure
end if

dw_detail.setfocus()

return

failure:
this.text = upper(string(itin_date, "m/d/yy (ddd.)"))
this.selecttext(1, len(this.text))
end event

type st_datelabel from statictext within w_itin
integer x = 2542
integer y = 1028
integer width = 178
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Date:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_ip_19 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2488
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_5 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1536
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_20 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2556
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_21 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 2624
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_4 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1468
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_3 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1400
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_2 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1332
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_1 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1264
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type st_ip_0 from statictext within w_itin
boolean visible = false
integer x = 18
integer y = 1196
integer width = 55
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 16777215
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
boolean focusrectangle = false
end type

type dw_itin from datawindow within w_itin
event dwnmousemove pbm_dwnmousemove
event type integer ue_selectcurrentrow ( boolean ab_scrolltorow )
event type integer ue_duplicatetimes ( long al_baserow )
event type integer ue_defaulttimes ( )
event type integer ue_timeclicked ( long al_row )
event type integer ue_assigntoevent ( long al_eventrow,  string as_eqtype,  string as_eqref,  long al_eqid )
event ue_keydown pbm_dwnkey
integer x = 101
integer y = 1136
integer width = 3479
integer height = 776
string dataobject = "d_itin"
boolean vscrollbar = true
boolean livescroll = true
end type

event dwnmousemove;if whats_on > 0 then parent.postevent("mousemove")
end event

event ue_selectcurrentrow;//Returns : 1 (CurrentRow selected), 0 (No current row), -1 (Currently not implemented)

Long		ll_CurrentRow

Integer	li_Return = 1


IF li_Return = 1 THEN

	ll_CurrentRow = This.GetRow ( )

	IF ll_CurrentRow > 0 THEN

		This.SelectRow ( 0, FALSE )

		IF ab_ScrollToRow THEN
			This.ScrollToRow ( ll_CurrentRow )
		END IF

		This.SelectRow ( ll_CurrentRow, TRUE )

	ELSE
		li_Return = 0

	END IF

END IF


RETURN li_Return
end event

event type integer ue_duplicatetimes(long al_baserow);Time		lt_BaseTimeArrived, &
			lt_BaseTimeDeparted, &
			lt_Check, &
			lt_TimeArrived, &
			lt_TimeDeparted
Boolean	lb_ExistingTimes, &
			lb_ConfirmEvents
String	ls_MessageHeader = "Duplicate Times", &
			ls_Message, &
			ls_ComputedTime, &
			ls_UserId
Long		ll_FirstRow, &
			ll_Row, &
			ll_Id
Integer	li_SkippedCount
boolean	lb_redisplay
n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
lnv_Event = CREATE n_cst_beo_Event

Integer	li_Return = 1


IF li_Return = 1 THEN

	ll_FirstRow = This.GetSelectedRow ( 0 )
	
	IF ll_FirstRow > 0 THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF al_BaseRow > 0 AND al_BaseRow <= This.RowCount ( ) THEN
		//OK
	//ELSEIF IsNull ( al_BaseRow ) THEN
		//Could implement some way of determining the row, if it wasn't specified.
		//Not going to bother with this now, though.
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( This )
	lnv_Event.of_SetSourceRow ( al_BaseRow )

	lt_BaseTimeArrived = lnv_Event.of_GetTimeArrived ( )
	lt_BaseTimeDeparted = lnv_Event.of_GetTimeDeparted ( )

	//Set verification message.
	ls_Message = "OK to set " + string(lt_BaseTimeArrived, "h:mm AM/PM") + " and " +&
		string(lt_BaseTimeDeparted, "h:mm AM/PM") + " as the arrival and departure times "+&
		"for these events?"

	//Scan selected rows to see if there are any existing arrival or departure
	//times specified that will be overwritten, and if so, set a flag so we
	//can warn the user.

	ll_Row = 0

	do

		ll_Row = This.getselectedrow(ll_Row)

		if ll_Row > 0 then

			lnv_Event.of_SetSourceRow ( ll_Row )

			//Check TimeArrived.
			lt_Check = lnv_Event.of_GetTimeArrived ( )

			if isnull(lt_Check) or lt_Check = lt_BaseTimeArrived then
				//No conflict.  Proceed.
			ELSE
				//Time would be overwritten.  Set warning flag.
				lb_ExistingTimes = true
				EXIT
			END IF

			//Check TimeDeparted
			lt_Check = lnv_Event.of_GetTimeDeparted ( )

			if isnull(lt_Check) or lt_Check = lt_BaseTimeDeparted then
				//No conflict.  Proceed.
			ELSE
				//Time would be overwritten.  Set warning flag.
				lb_ExistingTimes = true
				EXIT
			END IF

		end if

	loop while ll_Row > 0


	//If there were existing times, add that warning to the verification message.

	IF lb_ExistingTimes THEN
		ls_Message += "~n~n(Other existing times will be overwritten.)"
	END IF


	//Verify operation with user using message values prepared above.
	
	IF messagebox( ls_MessageHeader, ls_Message, question!, okcancel!, 1) = 2 THEN
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN
	
	//begin midification by appeon 20070731
	//invoke constant form n_cst_appeon_constant
	//IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "ConfirmEvents", inv_Shipment ) = n_cst_privsmanager.ci_True THEN
	IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "ConfirmEvents", inv_Shipment ) = appeon_constant.ci_True THEN
	//end midification by appeon
	//IF lnv_Privs.of_Allowconfirmation( ) THEN
		IF messagebox ( ls_MessageHeader, "Do you also want to confirm the events as "+&
			"completed?~n~n(Any events that have not been fully assigned will be "+&
			"skipped.)", question!, yesno!, 1) = 1 THEN
		
			lb_ConfirmEvents = true
		
		END IF
	END IF


	//Get the dispatch manager.
	lnv_Dispatch = Parent.wf_GetDispatchManager ( )

	lnv_Event.of_SetContext ( lnv_Dispatch ) 

	//Set redraw false to avoid flicker.
	
	dw_detail.setredraw(false)
	This.setredraw(false)
	
	
	//Perform set time processing.
	
	ll_Row = 0
	
	do
		ll_Row = This.getselectedrow(ll_Row)
	
		if ll_Row > 0 then

			lnv_Event.of_SetSourceRow ( ll_Row )
	
			lt_TimeArrived = lnv_Event.of_GetTimeArrived ( )
			lt_TimeDeparted = lnv_Event.of_GetTimeDeparted ( )
	
			IF lt_TimeArrived = lt_BaseTimeArrived THEN
				//Times already match
			ELSE
				IF lnv_Event.of_SetTimeArrived ( lt_BaseTimeArrived ) = 1 THEN
					//OK
				ELSE
					//Error
				END IF
			END IF

			IF lt_TimeDeparted = lt_BaseTimeDeparted THEN
				//Times already match
			ELSE
				IF lnv_Event.of_SetTimeDeparted ( lt_BaseTimeDeparted ) = 1 THEN
					//OK
				ELSE
					//Error
				END IF
			END IF
	
	
			//If the flag is set to confirm events, attempt to do so for this event.

			IF lb_ConfirmEvents THEN
	
				ll_Id = lnv_Event.of_GetId ( )

				IF IsValid ( lnv_Dispatch ) AND NOT IsNull ( ll_Id ) THEN
					parent.setRedraw( false )	//added for bobtail
					CHOOSE CASE lnv_Dispatch.of_ConfirmEvent ( ll_Id, TRUE /*Interactive*/ )
	
					CASE 1
						//OK, confirmed
						tab_route.Event ue_EventsConfirmed ( )
						/////////DAN ADDED 1- 24-07
						// I needed to do this for autoaddbobtailevents
						n_cst_setting_autoaddbobtail lnv_setting
						lnv_setting = create n_cst_setting_autoaddbobtail
						IF lnv_setting.of_getValue( ) = lnv_setting.cs_yes THEN
							//display_itin( itin_type , itin_id, itin_date )  //DEK 3-29-07 moved to after loop
							lb_redisplay = true
						END IF
						DESTROY lnv_setting
						//////////////////////////
					CASE 0
						//Was already confirmed.
	
					CASE -1
						//Could not be confirmed
						li_SkippedCount ++
	
					CASE ELSE
						//Unexpected return
						li_SkippedCount ++
	
					END CHOOSE
					parent.setRedraw( true )	//added for bobtail
				ELSE
					li_SkippedCount ++

				END IF
	
			END IF
	
		end if
	
	loop while ll_Row > 0
	
	//DEK 3-29-07, I moved this to here because similar functionality in ue_defaulttimes
	//was getting messed up as a result of the rows becoming deselected in the loop 
	//as a result of the following display call.  THis should probably happen outside
	//the loop any how as I suspect we'd have the same problem here.
	IF lb_redisplay THEN
		display_itin( itin_type , itin_id, itin_date )
	END IF
	//////////////////////////////////////////
	
	
	w_disp.wf_reset_times(ll_FirstRow, "ITIN!")
	
	This.selectrow(0, false)
	This.setredraw(true)
	dw_detail.setredraw(true)
	
	IF li_SkippedCount > 0 THEN
		messagebox( ls_MessageHeader, "Times were set successfully.~n~n" +&
			string(li_SkippedCount) + " event(s) could not be confirmed.", exclamation!)
	END IF

END IF

DESTROY ( lnv_Event )

RETURN li_Return
end event

event type integer ue_defaulttimes();Time		lt_TimeArrived, &
			lt_TimeDeparted
Boolean	lb_ConfirmEvents, &
			lb_AllowConf, &
			lb_NoSelection
String	ls_MessageHeader = "Accept Default Times", &
			ls_Message, &
			ls_ComputedTime
Long		ll_FirstRow, &
			ll_Row, &
			ll_Id
Integer	li_SkippedCount
n_cst_beo_Event		lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Event = CREATE n_cst_beo_Event

Integer	li_Return = 1

IF li_Return = 1 THEN

	ll_FirstRow = This.GetSelectedRow ( 0 )
	
	IF ll_FirstRow > 0 THEN
		//OK
	ELSE
		lb_NoSelection = TRUE
		ll_FirstRow = This.GetRow ( )
	END IF

	IF ll_FirstRow > 0 THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	//Set verification message.
	ls_Message = "OK to accept the calculated times for these events?" +&
		"~n~n(Any times already entered will not be changed.)"


	//Verify operation with user.
	
	IF messagebox( ls_MessageHeader, ls_Message, question!, okcancel!, 1) = 2 THEN
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN
	
	//IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "ConfirmEvents", inv_Shipment ) = n_cst_privsmanager.ci_True OR NOT IsValid ( inv_shipment ) THEN
	//IF lnv_Privs.of_Allowconfirmation( )  THEN
		IF messagebox ( ls_MessageHeader, "Do you also want to confirm the events as "+&
			"completed?~n~n(Any events that have not been fully assigned will be "+&
			"skipped.)", question!, yesno!, 1) = 1 THEN
		
			lb_ConfirmEvents = true
		
		END IF
	//END IF

	//Initialize the source for the event beo.
	lnv_Event.of_SetSource ( This )  //The old code set values on the cache.  Should this??

	//Get the dispatch manager.
	lnv_Dispatch = Parent.wf_GetDispatchManager ( )
	IF Not isValid ( inv_shipment ) THEN
		inv_Shipment = CREATE n_cst_beo_Shipment
	END IF
	inv_shipment.of_SetSource( lnv_Dispatch.of_GetShipmentCache ( ) )
	lnv_Event.of_SetContext ( lnv_Dispatch ) 

	//Set redraw false to avoid flicker.
	
	dw_detail.setredraw(false)
	This.setredraw(false)
	
	
	//Perform set time processing.
	
	// DEK 3-28-07---------------------
	//We get  a list of all the row ids that are currently selected, so that
	//i can find them in the list after bobtail logic goes through.  Before 
	//we did the bobtail stuff, it could get the next selected row over and over
	//but the bobtail logic messes up the the selected rows(not actually the 
	//bobtail logic, but the fact that we need to redisplay the
	//results after the bobtail logic.), so instead I get
	//the ids of all the events in the selected rows, and then find those ids
	//to do processing on them.
	ll_Row = 0
	long ll_index = 1
	Long	lla_selectedRows[]
	Long	ll_deId
	Boolean	lb_redisplay
	
	
	do

		IF lb_NoSelection THEN

			IF ll_Row = 0 THEN

				//First pass through.  Use the current row.
				ll_Row = ll_FirstRow
			ELSE
				//Second pass through.  We're done.
				ll_Row = 0
			END IF

		ELSE
			ll_Row = This.getselectedrow(ll_Row)
		END IF

	
		if ll_Row > 0 then

			lnv_Event.of_SetSourceRow ( ll_Row )
			lb_AllowConf = TRUE
	
			lt_TimeArrived = lnv_Event.of_GetTimeArrived ( )
			lt_TimeDeparted = lnv_Event.of_GetTimeDeparted ( )
	
			IF IsNull ( lt_TimeArrived ) THEN

				//If user has not already specified a time, try to set computed value.

				ls_ComputedTime = This.Object.cc_ArrStr [ ll_Row ]

				IF IsTime ( ls_ComputedTime ) THEN
					IF lnv_Event.of_SetTimeArrived ( Time ( ls_ComputedTime ) ) = 1 THEN
						//OK
					ELSE
						//Error, or value was rejected.
						lb_AllowConf = FALSE
					END IF
				ELSE
					lb_AllowConf = FALSE
				END IF

			END IF


			IF IsNull ( lt_TimeDeparted ) THEN

				//If user has not already specified a time, try to set computed value.

				ls_ComputedTime = This.Object.cc_DepStr [ ll_Row ]

				IF IsTime ( ls_ComputedTime ) THEN
					IF lnv_Event.of_SetTimeDeparted ( Time ( ls_ComputedTime ) ) = 1 THEN
						//OK
					ELSE
						//Error, or value was rejected.
						lb_AllowConf = FALSE
					END IF
				ELSE
					lb_AllowConf = FALSE
				END IF

			END IF
			
			
			// Get the shipment for the event and make sure that privs allow them to conf.			
			inv_shipment.of_SetSourceID ( lnv_Event.of_Getshipment( ) )
			IF inv_shipment.of_HasSource ( ) THEN
				//begin midification by appeon 20070731
//invoke constant form n_cst_appeon_constant
//IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "ConfirmEvents", inv_Shipment ) = n_cst_privsmanager.ci_False THEN
		IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "ConfirmEvents", inv_Shipment ) = appeon_constant.ci_False THEN
	//end midification by appeon

		lb_AllowConf = FALSE
				END IF			
			END IF
			
	
	
			//If the flag is set to confirm events, attempt to do so for this event.

			IF lb_ConfirmEvents AND lb_AllowConf THEN

				ll_Id = lnv_Event.of_GetId ( )

				IF IsValid ( lnv_Dispatch ) AND NOT IsNull ( ll_Id ) THEN
					parent.setRedraw( false )	//added for bobtail
					CHOOSE CASE lnv_Dispatch.of_ConfirmEvent ( ll_Id, TRUE /*Interactive*/ )
	
					CASE 1
						//OK, confirmed
						tab_route.Event ue_EventsConfirmed ( )
						/////////DAN ADDED 1- 24-07
						
						// I needed to do this for autoaddbobtailevents
						n_cst_setting_autoaddbobtail lnv_setting
						lnv_setting = create n_cst_setting_autoaddbobtail
						IF lnv_setting.of_getValue( ) = lnv_setting.cs_yes THEN
							//display_itin( itin_type , itin_id, itin_date )	//DEK: 3-29-07 I don't want to do this here, it messes up multiselected row logic for accepting defaults.
							lb_redisplay = true
						END IF
						DESTROY lnv_setting
						//////////////////////////
					CASE 0
						//Was already confirmed.
	
					CASE -1
						//Could not be confirmed
						li_SkippedCount ++
	
					CASE ELSE
						//Unexpected return
						li_SkippedCount ++
	
					END CHOOSE
					parent.setRedraw( true )	//added for bobtail
				ELSE
					li_SkippedCount ++

				END IF
	
			END IF
	
		end if
	
	loop while ll_Row > 0
	
	//DEK: 3-29-07  I moved this to here because multiselecting and auto accepting
	//default times when bobtail is on, was not working.  Its because calling
	//this function in the loop deselected the rows.  It should have been
	//outside of the loop in the first place most likely.
	IF lb_redisplay THEN
		display_itin( itin_type , itin_id, itin_date )
	END IF
	///////////////////////////////////////////
	
	w_disp.wf_reset_times(ll_FirstRow, "ITIN!")
	
	This.selectrow(0, false)
	This.setredraw(true)
	dw_detail.setredraw(true)
	
	IF li_SkippedCount > 0 THEN
		messagebox( ls_MessageHeader, "Times were set successfully.~n~n" +&
			string(li_SkippedCount) + " event(s) could not be confirmed.", exclamation!)
	END IF

END IF

DESTROY (lnv_Event)

RETURN li_Return
end event

event type integer ue_timeclicked(long al_row);Time		lt_ClickedTimeArrived, &
			lt_ClickedTimeDeparted
Long		ll_SelectedCount, &
			lla_SelectedIds[]
Integer	li_Result
String	lsa_parm_labels[]
Any		laa_parm_values[]
n_cst_beo_Event	lnv_Event
n_cst_Dws			lnv_Dws

Integer	li_Return = 1


//begin midification by appeon 20070731
//invoke constant form n_cst_appeon_constant
//IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "EditEventTimes", inv_shipment ) = n_cst_privsmanager.ci_FALSE THEN
IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "EditEventTimes", inv_shipment ) = appeon_constant.ci_FALSE THEN

//end midification by appeon
//IF Not ( lnv_Privs.of_edittimes( ) ) THEN

	RETURN -1
END IF



lnv_Event = CREATE n_cst_beo_Event

IF li_Return = 1 THEN

	IF al_Row > 0 AND al_Row <= This.RowCount ( ) THEN
		//OK
	//ELSEIF IsNull ( al_Row ) THEN
		//Could implement some way of determining the row, if it wasn't specified.
		//Not going to bother with this now, though.
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( This )
	lnv_Event.of_SetSourceRow ( al_Row )

	lt_ClickedTimeArrived = lnv_Event.of_GetTimeArrived ( )
	lt_ClickedTimeDeparted = lnv_Event.of_GetTimeDeparted ( )

	ll_SelectedCount = lnv_Dws.of_SelectedCount ( This, lla_SelectedIds )


	//If both TimeArrived and TimeDeparted have been specified in the row clicked, 
	//and more than one target row is selected, give the user the duplicate times option.
	
	IF ll_SelectedCount > 1 AND &
		NOT (isnull(lt_ClickedTimeArrived) or isnull(lt_ClickedTimeDeparted)) THEN
	
		lsa_parm_labels[1] = "ADD_ITEM"
		laa_parm_values[1] = "&Duplicate Times"
	
	END IF
	
	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "&Accept Default Times"


	//Display popup menu to determine which type of time processing the user wants.
	
	CHOOSE CASE f_pop_standard ( lsa_parm_labels, laa_parm_values )
	
	CASE "DUPLICATE TIMES"

		li_Result = This.Event ue_DuplicateTimes ( al_Row )

		CHOOSE CASE li_Result

		CASE 1, 0, -1
			li_Return = li_Result

		CASE ELSE
			li_Return = -1

		END CHOOSE

	CASE "ACCEPT DEFAULT TIMES"
	
		li_Result = This.Event ue_DefaultTimes ( )

		CHOOSE CASE li_Result

		CASE 1, 0, -1
			li_Return = li_Result

		CASE ELSE
			li_Return = -1

		END CHOOSE

	
	CASE ELSE  //User cancel
		li_Return = 0
	
	END CHOOSE

END IF

DESTROY ( lnv_Event )


RETURN li_Return
end event

event ue_assigntoevent;Date	ld_Null 
Long	ll_EventID
Int	li_ItinType

SetNull ( ld_Null )
SetNull ( ll_EventID )

THIS.SetRow ( al_eventrow )
n_cst_EquipmentManager	lnv_Equip

li_ItinType = lnv_Equip.of_GetItinType ( as_eqtype )

tab_route.tabpage_Assignments.Event ue_Select ( li_ItinType , al_eqid )
tab_route.tabpage_Assignments.Event ue_Refresh ( )
tab_route.tabpage_Assignments.Event ue_Assign ( li_ItinType , al_eqid , ld_Null , ll_EventID , gc_Dispatch.ci_InsertionStyle_assignment , FALSE )

wf_SetRedraw ( TRUE )
RETURN 1
end event

event ue_keydown;IF key = KeyA! AND keyflags = 2 THEN

	THIS.SelectRow ( 0 , TRUE )
	
END IF
end event

event clicked;Boolean	lb_WasSelected, &
			lb_IsSelected, &
			lb_ShiftDown, &
			lb_CtrlDown
Long		ll_ShipmentId, &
			ll_Row, &
			ll_RowCount

lb_ShiftDown = KeyDown ( KeyShift! )
lb_CtrlDown = KeyDown ( KeyControl! )

if whats_on > 0 then clear_ip()

integer currow
currow = this.getrow()

//Commented for 3.5.0
//if isvalid(shipwin) then shipwin.dw_ship_itin.selectrow(0, false)
//shipevsel = 0

lb_WasSelected = This.IsSelected ( Row )
gf_multiselect(this, row)
lb_IsSelected = This.IsSelected ( Row )


//Perform Automatic Shipment Event Selection, if the shipment indicator for a shipment event
//was clicked.  If the shipment event was selected, select the other shipment events.  If it
//was deselected, deselect the other shipment events.  If the indicator was clicked with shift
//down as part of a range selection, do not perform shipment select processing.

IF Row > 0 THEN

	CHOOSE CASE dwo.Name
	
	CASE "comp_ship_letter", "comp_ship_stops"  //Components of the shipment stop indicator
	
		ll_ShipmentId = This.Object.de_Shipment_Id [ Row ]
	
		IF lb_WasSelected = lb_IsSelected THEN
	
			//Selection didn't change -- no action needed.
	
		ELSEIF lb_ShiftDown THEN
	
			//Range selection - don't do shipment selection
	
		ELSEIF NOT IsNull ( ll_ShipmentId ) THEN

			ll_RowCount = This.RowCount ( )

			FOR ll_Row = 1 TO ll_RowCount

				IF This.Object.de_Shipment_Id [ ll_Row ] = ll_ShipmentId THEN

					IF This.IsSelected ( ll_Row ) = lb_IsSelected THEN
						//Selection states match -- no action needed
					ELSE
						This.SelectRow ( ll_Row, lb_IsSelected )
					END IF

				END IF

			NEXT

		END IF
	CASE "de_arrdate"
		Parent.display_itin( itin_type , itin_id, THIS.GetItemDate ( row , String (dwo.name) ) )
		
		
	END CHOOSE	

END IF


if row = 0 then
//	Eliminated for PB6 Conversion
//	this.setredraw(false)
//	this.post setrow(currow)
//	this.post setredraw(true)
elseif currow <> row then
	choose case dwo.name
		case "comp_arr"
			scroll_column = "de_arrtime"
		case "comp_dep"
			scroll_column = "de_deptime"
	end choose
end if


THIS.SetFocus ( )  // I added this so the dw can get focus and support Ctrl-a

end event

event rowfocuschanged;//if currentrow > 0 then
//	if not hold_redraw then dw_detail.setredraw(false)
//	dw_detail.setcolumn("de_note")
//	dw_detail.scrolltorow(currentrow)
//	dw_detail.setcolumn(scroll_column)
//	scroll_column = "co_name"
//	if not hold_redraw then dw_detail.setredraw(true)
//	dw_detail.setfocus()
//end if


IF HOLD_redraw = FALSE THEN
	This.SetRedraw ( TRUE )  //To force redraw of highlight
END IF

Post wf_SyncEventFocus ( )

//We could potentially switch to something like what follows.  It would improve 
//performance somewhat.  It would require some revisions to display_itin(), however,
//so I'm not going to get into it now.  It's too risky.
//
//if currentrow > 0 and not hold_redraw then
//	dw_detail.setredraw(false)
//	dw_detail.setcolumn("de_note")
//	dw_detail.scrolltorow(currentrow)
//	dw_detail.setcolumn(scroll_column)
//	scroll_column = "co_name"
//	dw_detail.setredraw(true)
//	dw_detail.setfocus()
//end if
end event

event rbuttondown;// RDT 8-6-03 remove blank pages
string lsa_parm_labels[]
any laa_parm_values[]

IF upper(dwo.type) = "DATAWINDOW" then
	dw_itin_print.Reset()
	dw_itin.RowsCopy(1, dw_itin.RowCount(), Primary!, dw_itin_print, 1, Primary!)		// RDT 8-6-03 
	
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	//laa_parm_values[2] = this																			// RDT 8-6-03 
	laa_parm_values[2] =	dw_itin_print																	// RDT 8-6-03 

	f_pop_standard(lsa_parm_labels, laa_parm_values)
ELSEIF dwo.name = "de_event_type" THEN
	
	
	n_cst_Privileges_Events	lnv_Privs
	IF lnv_Privs.of_Allowalteritins( ) THEN
		dw_itin.SetRow ( row )
		PARENT.Post Event ue_ShowEventMenu ( row )
	END IF
	
else
	show_pop(row, dwo)
end if

end event

event constructor;
n_cst_LicenseManager	lnv_LicenseManager
Integer	li_BaseTimeZone

n_cst_Events	lnv_Events

Int	li_ShowDisp
li_ShowDisp = ProfileInt ( gnv_App.of_GetAppIniFile ( ), "DispatchedField", "Show", 0 )
IF li_ShowDisp = 1 THEN
	THIS.object.de_Status.Visible = 1
	THIS.object.t_Status.Visible = 1
END IF


li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )
This.Modify ( "comp_tz_home.Expression = '" + String ( li_BaseTimeZone ) + "'" )

This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
	
// RDT 8-11-03 - Start
//This.Object.companies_dispatchinstructions.X = 1
//This.Object.comp_ship_ind.x= 1
//This.Object.comp_tz_adj.x= 1
//This.Object.cc_depstr.x= 1
//This.Object.cc_arrstr.x= 1
//This.Object.leg_mins.x= 1
//This.Object.interch.x= 1
//
//This.Object.companies_dispatchinstructions.y = 1
//This.Object.comp_ship_ind.y= 1
//This.Object.comp_tz_adj.y= 1
//This.Object.cc_depstr.y= 1
//This.Object.cc_arrstr.y= 1
//This.Object.leg_mins.y= 1
//This.Object.interch.y= 1

//This.Object.companies_dispatchinstructions.visible = 0
//This.Object.comp_ship_ind.visible = 0
//This.Object.comp_tz_adj.visible = 0
//This.Object.cc_depstr.visible = 0
//This.Object.cc_arrstr.visible = 0
//This.Object.leg_mins.visible = 0
//This.Object.interch.visible = 0
// RDT 8-11-03 - End 
end event

event rowfocuschanging;This.SetRedraw ( FALSE )  //Needed for proper redraw of highlight
end event

event doubleclicked;//If the user doubleclicked the shipment indicator on a shipment event row, jump to the shipment.

Long	ll_ShipmentId

IF Row > 0 THEN

	CHOOSE CASE dwo.Name
	
	CASE "comp_ship_letter", "comp_ship_stops"  //Components of the shipment stop indicator
	
		ll_ShipmentId = This.Object.de_Shipment_Id [ Row ]

		IF NOT IsNull ( ll_ShipmentId ) THEN
			Parent.Post Jump_Ship ( ll_ShipmentId, FALSE /*Don't show selection dialog*/ )
		END IF
		
	CASE else
		
			dw_detail.post setredraw(false)
			dw_detail.post setcolumn("de_note")
			dw_detail.post setcolumn("co_name")
			dw_detail.post setredraw(true)
			dw_detail.post setfocus()
			tab_route.Post SelectTab ( 1 )
		
	END CHOOSE

END IF
end event

event dragdrop;Long		ll_EqID
String	ls_EqType
String	ls_Ref
dataWindow	ldw_AssignmentList

CHOOSE CASE source.ClassName ( ) 
		
	CASE "dw_assignmentlist"
	
		ldw_AssignmentList = source
		ls_EqType = ldw_AssignmentList.Dynamic of_GetSelectedType ( )
		ls_Ref = ldw_AssignmentList.Dynamic of_GetSelectedRef ( )
		ll_EqID = ldw_AssignmentList.Dynamic of_GetSelectedID ( )
		

		//wf_SyncEventFocus ( )
		IF Len ( ls_EqType ) > 0 AND Len ( ls_Ref ) > 0 AND ROW > 0  AND ll_EqID > 0 THEN
			THIS.Event ue_assignToEvent ( Row , ls_EqType , ls_Ref , ll_EqID )
		END IF		
	
		
END CHOOSE

end event

event dragwithin;IF source.ClassName ( ) = "dw_assignmentlist" THEN
	Long	ll_RowCount	
	Long	i
	ll_RowCount = THIS.RowCount ( )
	For i = 1 TO ll_RowCount 
		IF Row = i THEN
			THIS.SelectRow ( i , TRUE ) 
		ELSE
			THIS.SelectRow ( i , FALSE ) 
		END IF
	NEXT
END IF
end event

event dragleave;Long	ll_RowCount	
Long	i
ll_RowCount = THIS.RowCount ( )
For i = 1 TO ll_RowCount 
	THIS.SelectRow ( i , FALSE )
NEXT
end event

type tab_type from tab within w_itin
event mousemove pbm_mousemove
integer x = 78
integer y = 1020
integer width = 3534
integer height = 920
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_driver tp_driver
tp_tractor tp_tractor
tp_trailer tp_trailer
tp_container tp_container
tp_external tp_external
end type

event mousemove;if whats_on > 0 then parent.postevent("mousemove")
end event

on tab_type.create
this.tp_driver=create tp_driver
this.tp_tractor=create tp_tractor
this.tp_trailer=create tp_trailer
this.tp_container=create tp_container
this.tp_external=create tp_external
this.Control[]={this.tp_driver,&
this.tp_tractor,&
this.tp_trailer,&
this.tp_container,&
this.tp_external}
end on

on tab_type.destroy
destroy(this.tp_driver)
destroy(this.tp_tractor)
destroy(this.tp_trailer)
destroy(this.tp_container)
destroy(this.tp_external)
end on

event selectionchanging;if force_tab then
	force_tab = false
	return 0
end if

return 1
end event

event losefocus;if whats_on > 0 then clear_ip()
end event

event clicked;Boolean	lb_AlwaysShowDialog
Integer	li_TargetType

CHOOSE CASE Index

CASE 1
	li_TargetType = gc_Dispatch.ci_ItinType_Driver

CASE 2
	li_TargetType = gc_Dispatch.ci_ItinType_PowerUnit

CASE 3
	li_TargetType = gc_Dispatch.ci_ItinType_TrailerChassis

CASE 4
	li_TargetType = gc_Dispatch.ci_ItinType_Container

CASE 5
	li_TargetType = gc_Dispatch.ci_ItinType_Trip

CASE ELSE
	SetNull ( li_TargetType )

END CHOOSE


IF NOT IsNull ( li_TargetType ) THEN

	if keydown(keyshift!) or keydown(keycontrol!) then
		lb_AlwaysShowDialog = true
	end if

	post jump_select( li_TargetType, lb_AlwaysShowDialog )

END IF
end event

type tp_driver from userobject within tab_type
integer x = 18
integer y = 112
integer width = 3497
integer height = 792
long backcolor = 12632256
string text = "Driver"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 553648127
end type

type tp_tractor from userobject within tab_type
integer x = 18
integer y = 112
integer width = 3497
integer height = 792
long backcolor = 12632256
string text = "Tractor / S.T."
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tp_trailer from userobject within tab_type
integer x = 18
integer y = 112
integer width = 3497
integer height = 792
long backcolor = 12632256
string text = "Trailer / Chassis"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tp_container from userobject within tab_type
integer x = 18
integer y = 112
integer width = 3497
integer height = 792
long backcolor = 12632256
string text = "Container"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tp_external from userobject within tab_type
integer x = 18
integer y = 112
integer width = 3497
integer height = 792
long backcolor = 12632256
string text = "3rd Party"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_detail from u_dw_eventdetail within w_itin
event ue_wheelscroll pbm_vscroll
integer x = 32
integer y = 100
integer taborder = 20
boolean bringtotop = true
end type

event ue_wheelscroll;// RDT 7-18-03 
Message.Processed = True

end event

event itemchanged;call super::itemchanged;n_cst_beo_Event		lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnva_Errors[]
String	ls_ErrorMessage

Long	ll_Return
ll_Return = AncestorReturnValue

lnv_Event = CREATE n_cst_beo_Event

choose case dwo.name
		
case "de_conf"

	lnv_Dispatch = Parent.wf_GetDispatchManager ( )
	//If there's an error, we'll want to get the error message, so clear the error stack.
	lnv_Dispatch.ClearOFRErrors ( )
	
	lnv_Event.of_SetSource ( This )
	lnv_Event.of_SetSourceRow ( Row )

	if data = "T" then
		parent.setredraw( false )
		IF lnv_Dispatch.of_ConfirmEvent ( lnv_Event.of_GetId ( ), TRUE /*Interactive*/ ) = -1 THEN

			IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
				//There are errors to process -- Get the error text
				ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
			ELSE
				ls_ErrorMessage = "Could not confirm event completion.~n(Unspecified error.)"
			END IF

			MessageBox ( "Confirm Event Completion", ls_ErrorMessage )
			This.SetText ( "F" )
			DESTROY (lnv_Event)
			parent.setredraw( true )  //added for bobtail on 2-15-07
			RETURN 2
		ELSE
			//THIS.of_EventConfirmed ( lnv_Event )
			/////////DAN ADDED 1- 24-07
			// I needed to do this for autoaddbobtailevents
			n_cst_setting_autoaddbobtail lnv_setting
			lnv_setting = create n_cst_setting_autoaddbobtail
			IF lnv_setting.of_getValue( ) = lnv_setting.cs_yes THEN
				display_itin( itin_type , itin_id, itin_date ) 
			END IF
			DESTROY lnv_setting
			//////////////////////////
		END IF
		 parent.setredraw( true )
	else
		//The column is protected if it's confirmed and part of a shipment.  So, there's a hidden check
		//here that the event is not part of a shipment.  We would need to make sure the shipment is ok 
		//with what's happening if it is a shipment event.
		//begin midification by appeon 20070731
//invoke constant form n_cst_appeon_constant
//IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "UnconfirmEvents", inv_shipment ) = n_cst_privsmanager.ci_True THEN
		IF gnv_App.of_getprivsmanager( ).of_getuserpermissionfromfn( "UnconfirmEvents", inv_shipment ) = appeon_constant.ci_True THEN
	//end midification by appeon

		IF lnv_Dispatch.of_UnconfirmEvent ( lnv_Event.of_GetId ( ), TRUE /*Interactive*/ ) = -1 THEN
	
				IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
					//There are errors to process -- Get the error text
					ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
				ELSE
					ls_ErrorMessage = "Could not clear event confirmation.~n(Unspecified error.)"
				END IF
	
				MessageBox ( "Clear Event Confirmation", ls_ErrorMessage )
				This.SetText ( "T" )
				DESTROY (lnv_Event)
				RETURN 2
	
			END IF
		ELSE
			MessageBox ( "Clear Event Confirmation", "You are not authorized to make this change." )
			RETURN 2
		END IF

	end if

	//Commented for 3.5.0
	//if isvalid(shipwin) then shipwin.post refresh_display()
	THIS.of_CheckNotifications ( lnv_Event )
	
end choose

DESTROY (lnv_Event)

RETURN ll_Return
end event

event rbuttondown;// override 
// RDT 5-13-03 Added p_notificationNone
string lsa_parm_labels[]
any laa_parm_values[]

if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this
	f_pop_standard(lsa_parm_labels, laa_parm_values)
elseIF dwo.Name = "p_notificationactive"  OR  &
	    dwo.Name = "p_notificationsuccess" OR  &
		 dwo.Name = "p_notificationerror"   OR  &
		 dwo.Name = "p_notificationNone"   THEN
	THIS.Event ue_RightClickOnNotificationIcon ( dwo )			
ELSE
	
	show_pop(row, dwo)
end if

end event

event ue_setscrollcolumn;call super::ue_setscrollcolumn;scroll_column = as_ScrollColumn
end event

event constructor;call super::constructor;This.of_SetEventList ( dw_Itin )
end event

event ue_postdatetimeedit;call super::ue_postdatetimeedit;n_cst_licensemanager	lnv_licensemanager

IF lnv_LicenseManager.of_HasEDI214License() THEN
	//save event for edi message
	n_cst_bso_dispatch	lnv_dispatch
	n_cst_beo_event		lnv_event
	
	lnv_Event = CREATE n_cst_beo_Event
	
	lnv_Dispatch = Parent.wf_GetDispatchManager ( )
	lnv_Event.of_SetSource ( This )
	lnv_Event.of_SetSourceRow ( al_row )
	lnv_Event.of_SetContext(lnv_Dispatch)
	
	choose case as_colname
		case "de_arrdate"
			lnv_Event.of_SetDateArrived(date(as_data))
			
		case "de_arrtime"
			lnv_Event.of_SetTimeArrived(time(as_data))
			
		case "de_deptime"
			lnv_Event.of_SetTimeDeparted(time(as_data))
	
		case "de_apptdate"
			lnv_Event.of_SetScheduleddate(date(as_data))
			
		case "de_appttime"
			lnv_Event.of_SetScheduledtime(time(as_data))
			
	end choose
		
	destroy lnv_event	

end if
	
w_disp.wf_reset_times(al_Row, "ITIN!")
this.setredraw(true)
dw_itin.setredraw(true)
end event

event ue_postchangesite;//Provide PostChangeSite processing specific to this instance.

w_disp.post wf_reset_times(al_Row, "ITIN!")
this.post setredraw(true)
dw_itin.post setredraw(true)


n_Cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company
lnv_Company.of_Setusecache( TRUE )
lnv_Company.of_SetSourceID ( al_new )
Parent.wf_GetAlertmanager( ).of_ShowAlerts ( {lnv_Company} ) 
DESTROY ( lnv_Company )

end event

event ue_getnotificationerror;RETURN Parent.wf_GetDispatchManager ( ).of_GetnotificationManager ( ).of_GetNotificationError ( anv_ptbeo )
end event

event ue_checknotifications;RETURN Parent.wf_GetDispatchManager ( ).of_GetnotificationManager ( ).of_CheckNotificationStatus ( anv_ptbeo )
end event

event ue_cancelnotification;RETURN Parent.wf_GetDispatchManager ( ).of_GetnotificationManager ( ).of_RemovePendingNotification ( anv_event )
end event

event ue_getshipment;Long		ll_Ship
Long		ll_Row

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( )

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ll_Ship = THIS.GetItemNumber ( ll_Row , "de_shipment_id" )
END IF


IF ll_Ship > 0 THEN	
	IF isValid ( lnv_Dispatch ) THEN		
		lnv_Dispatch.of_RetrieveShipment ( ll_Ship )
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceID ( ll_Ship )
		lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
		lnv_Shipment.of_SetEventsource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Shipment.of_SetAllowFilterSet ( TRUE ) 
		lnv_Shipment.of_SetContext ( lnv_Dispatch )
	END IF
END IF

RETURN lnv_Shipment
end event

event ue_getdispatchmanager;RETURN Parent.wf_GetDispatchManager ( )
end event

event rowfocuschanged;call super::rowfocuschanged;THIS.of_Defaultrestrictions( )
end event

type cb_goto from u_cb within w_itin
integer x = 3255
integer y = 1020
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "&Go To..."
end type

event clicked;Long	ll_Null
SetNull ( ll_Null )

Parent.Post Jump_Select ( ll_Null, TRUE )
end event

type dw_tripdetail from u_dw_tripdetail within w_itin
event ue_trippayable ( )
boolean visible = false
integer x = 398
integer y = 252
integer taborder = 40
boolean bringtotop = false
end type

event ue_trippayable;String	ls_Filter
String	ls_Label
Long		ll_Type
Long		ll_SetRtn
Long		ll_Filter
Long		ll_Count
Long		ll_EntityID
Long		ll_CarrierID
Long		ll_CurrentRow
Int		li_Return = 1
Boolean	lb_Continue = TRUE

n_cst_Beo_AmountType	lnv_AmountType
n_cst_bcm				lnv_Cache
n_cst_beo				lnv_Beo
n_cst_beo_Trip			lnv_Trip
n_cst_msg				lnv_Msg
S_Parm					lstr_parm
n_cst_Companies		lnv_Cos
dataStore 				lds_PreviousAdvances

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

ls_Label = "TRIP_PAYABLE"
lnv_Cos = CREATE n_cst_Companies


IF IsValid ( THIS.inv_UILink ) THEN

	ll_CurrentRow = dw_tripdetail.GetRow ( )
	lnv_Trip = dw_tripdetail.inv_UILink.GetBeo ( ll_CurrentRow )

	IF IsValid ( lnv_Trip ) THEN
		lstr_Parm.is_Label = "TRIP"
		lstr_Parm.ia_Value = lnv_Trip
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		lb_Continue = TRUE
	END IF

END IF

IF lb_Continue THEN
	IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
		li_Return = 0
		lnv_AmountType = lnv_Cache.getBeo("pos(amounttype_tag, '" + ls_Label + "') > 0")
		IF NOT IsValid ( lnv_AmountType  ) THEN
			lb_Continue = FALSE
			// do I want to do this, or do I want to use the fact that a amount type was specified as an indication that they 
			// want to assign trip payables at this time?
			//messageBox( "" , "There is no AmountType specified with the tag 'TRIP_PAYABLE' for the payable. Processing stopped." )
		ELSE
			ll_Type = lnv_AmountType.of_getID ( ) 
		END IF
	END IF
END IF
//
IF lb_Continue THEN
	ll_CarrierID = lnv_Trip.of_GetCarrierID ( )
	IF lnv_Cos.of_GetEntity ( ll_CarrierID , ll_EntityID, TRUE , TRUE  )  <> 1 THEN
		MessageBox ( "Trip Payable" , "The entity selected has not been setup to handle transactions. Request cancelled.")
		li_Return = -1	
		lb_Continue = FALSE
	END IF
END IF


IF lb_Continue THEN
	If Not IsValid ( lds_PreviousAdvances ) THEN
		lds_PreviousAdvances = CREATE DataStore
		lds_PreviousAdvances.DataObject = "d_amountowedlist"
		lds_PreviousAdvances.SetTransObject( SQLCA )	
	END IF

	IF lds_PreviousAdvances.Retrieve ( ) < 0 THEN
		li_Return = -1
	ELSE
	
		ls_Filter = "amountowed_fkentity = " + String ( ll_entityid )+"  AND amountowed_type = " + String ( ll_Type ) +" AND amountowed_trip = '" + String ( lnv_Trip.of_GetID ( ) ) + "'"
	
		ll_SetRtn = lds_PreviousAdvances.SetFilter ( ls_Filter )
		ll_Filter = lds_PreviousAdvances.Filter ( )
		
		IF ll_SetRtn <> 1 OR ll_Filter <> 1 THEN
			li_Return = -1
		ELSE
			ll_Count = lds_PreviousAdvances.RowCount( ) 
			IF ll_Count > 0 THEN
				IF MessageBox ( "Trip Payable" , "There has already been a trip payable assigned to this trip. Do you want to view it now?", QUESTION! , YESNO! , 1 ) <> 1 THEN
					lb_Continue = FALSE
				END IF
			END IF
			
		END IF
	END IF
END IF
IF lb_Continue THEN
	
	OpenWithParm ( w_CashAdvance , lnv_Msg )
END IF

Destroy ( lnv_Cos )
//RETURN li_Return

end event

event task_retrieve;//OVERRIDING ANCESTOR SCRIPT  (CALLS ANCESTOR)

//Before retrieving, specify the DispatchManager to be used for this object, 
//if it hasn't been specified already.

IF NOT IsValid ( This.GetDispatchManager ( ) ) THEN
	This.SetDispatchManager ( Parent.wf_GetDispatchManager ( ) )
END IF

RETURN Super::Event Task_Retrieve ( )
end event

event constructor;call super::constructor;This.Event ue_MakePopup ( )
end event

event ue_checklocations;//OVERRIDING ANCESTOR PLACEHOLDER  (implementation is context specific)

//Collect and submit the event list for the current trip to of_CheckLocations 
//on the trip beo.  of_CheckLocations verifies whether the origin and destination
//are still the same, and adjusts the OriginId and DestinationId if necessary.
//This event is called from wf_DispalyTrip.

n_cst_beo_Event	lnva_EventList[]
n_cst_beo_Trip		lnv_Trip
Long	ll_CurrentRow

dw_Detail.of_GetEvents ( lnva_EventList )

IF IsValid ( inv_UILink ) THEN

	ll_CurrentRow = This.GetRow ( )
	lnv_Trip = inv_UILink.GetBeo ( ll_CurrentRow )

	IF IsValid ( lnv_Trip ) THEN
		lnv_Trip.of_SetEventList ( lnva_EventList )
		lnv_Trip.of_CheckLocations ( )
		inv_UIlink.UpdateRequestor ( ll_CurrentRow )
	END IF

END IF

end event

event pfc_deleterow;call super::pfc_deleterow;//EXTENDING ANCESTOR to perform context-specific processing.

//If row was deleted, perform clean-up.

IF AncestorReturnValue = SUCCESS THEN

	SetNull ( Itin_Id )
	Parent.wf_GetParent().Title += "  (Deleted)"
	This.Hide ( )

END IF

RETURN AncestorReturnValue
end event

event pfc_predeleterow;call super::pfc_predeleterow;//EXTENDING ANCESTOR to perform context-specific processing.

n_cst_beo_Event	lnva_EventList[]
n_cst_beo_Trip		lnv_Trip
Long	ll_CurrentRow

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = CONTINUE_ACTION THEN

	dw_Detail.of_GetEvents ( lnva_EventList )
	
	IF IsValid ( inv_UILink ) THEN
	
		ll_CurrentRow = This.GetRow ( )
		lnv_Trip = inv_UILink.GetBeo ( ll_CurrentRow )
	
		IF IsValid ( lnv_Trip ) THEN
			lnv_Trip.of_SetEventList ( lnva_EventList )
		ELSE
			li_Return = PREVENT_ACTION
			MessageBox ( "Delete Trip", "Could not process request.  Request cancelled.", Exclamation! )
		END IF

	ELSE
		//Any processing??
	
	END IF

END IF


RETURN li_Return

end event

type tab_route from tab within w_itin
event type w_itin ue_getitinerarywindow ( )
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event type long ue_getroutingids ( ref long ala_ids[] )
event ue_rowfocuschanged ( long al_row )
event ue_ipanswer ( integer ai_requesttype,  date ad_insertiondate,  long al_insertionevent,  integer ai_insertionstyle )
event ue_eventsconfirmed ( )
event ue_splitfront ( )
event ue_splitback ( )
event ue_splitboth ( )
integer x = 32
integer width = 3575
integer height = 992
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 29409472
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_details tabpage_details
tabpage_assignments tabpage_assignments
tabpage_shipment tabpage_shipment
tabpage_clipboard tabpage_clipboard
end type

event ue_getitinerarywindow;RETURN Parent
end event

event ue_getdispatchmanager;RETURN Parent.wf_GetDispatchManager ( )
end event

event ue_getroutingids;//Returns : The number of elements in ala_Ids if successful, or -1 if not successful.

Long	lla_Ids[]

Long	ll_Return = -1

//Clear the reference array.
ala_Ids = lla_Ids

//If the selected tab is a type that supports this operation, get the routing ids from it.

IF This.Control [ This.SelectedTab ].TriggerEvent ( "ue_IsEventRouting" ) = 1 THEN

	IF This.Control [ This.SelectedTab ].Dynamic Event ue_GetRoutingIds ( lla_Ids ) >= 0 THEN
		ala_Ids = lla_Ids
		ll_Return = Upperbound ( ala_Ids )
	END IF

END IF

RETURN ll_Return
end event

event ue_rowfocuschanged;//Attempt to refresh the current tab page.
//The page may or may not implement the event.

This.Control [ This.SelectedTab ].TriggerEvent ( "ue_Refresh" )
tabpage_assignments.TriggerEvent ( "ue_Refresh" ) 

end event

event ue_ipanswer;//Forward the insertion point response to the appropriate tabpage.

CHOOSE CASE ai_RequestType

CASE appeon_constant.ci_RouteRequest_NewEvent, appeon_constant.ci_RouteRequest_Reroute, &
	appeon_constant.ci_RouteRequest_Assignment

	This.tabpage_Assignments.Event ue_IPAnswer ( ai_RequestType, ad_InsertionDate, &
		al_InsertionEvent, ai_InsertionStyle )

CASE appeon_constant.ci_RouteRequest_Route

	This.tabpage_Shipment.Event ue_IPAnswer ( ai_RequestType, ad_InsertionDate, &
		al_InsertionEvent, ai_InsertionStyle )

CASE appeon_constant.ci_RouteRequest_Clipboard

	This.tabpage_Clipboard.Event ue_IPAnswer ( ai_RequestType, ad_InsertionDate, &
		al_InsertionEvent, ai_InsertionStyle )

END CHOOSE
end event

event ue_eventsconfirmed;THIS.Tabpage_Shipment.Event ue_Refresh ( )
end event

event ue_splitfront;This.Control [ THIS.SelectedTab ].TriggerEvent ( "ue_splitfront" ) 
end event

event ue_splitback;This.Control [ THIS.SelectedTab ].TriggerEvent ( "ue_splitback" ) 
end event

event ue_splitboth;This.Control [ THIS.SelectedTab ].TriggerEvent ( "ue_splitboth" ) 
end event

event selectionchanged;//If we have a legitimate NewIndex, attempt to trigger the ue_Refresh event on it.
//The page may or may not implement the event.

IF NewIndex > 0 THEN
	This.Control [ NewIndex ].TriggerEvent ( "ue_Refresh" )
END IF
end event

on tab_route.create
this.tabpage_details=create tabpage_details
this.tabpage_assignments=create tabpage_assignments
this.tabpage_shipment=create tabpage_shipment
this.tabpage_clipboard=create tabpage_clipboard
this.Control[]={this.tabpage_details,&
this.tabpage_assignments,&
this.tabpage_shipment,&
this.tabpage_clipboard}
end on

on tab_route.destroy
destroy(this.tabpage_details)
destroy(this.tabpage_assignments)
destroy(this.tabpage_shipment)
destroy(this.tabpage_clipboard)
end on

event selectionchanging;Long	ll_Return = 0   //Allow focus to change


IF ll_Return = 0 THEN

	IF OldIndex = 1 THEN
	
		IF dw_Detail.AcceptText ( ) = -1 THEN
			ll_Return = 1  //Prevent focus change
		END IF
	
	END IF

END IF


//If we're switching to the Itinerary tab, make dw_Detail visible.
//Otherwise, hide it.

IF ll_Return = 0 THEN

	IF NewIndex = 1 THEN
		dw_Detail.Visible = TRUE
	ELSE
		dw_Detail.Visible = FALSE
	END IF

END IF


RETURN ll_Return
end event

type tabpage_details from userobject within tab_route
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 3538
integer height = 868
long backcolor = 12632256
string text = "Details"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_tabjump st_tabjump
cb_4 cb_4
ddlb_1 ddlb_1
st_2 st_2
cb_document cb_document
cb_2 cb_2
cb_1 cb_1
cb_map cb_map
cb_cashadvance cb_cashadvance
end type

on tabpage_details.create
this.st_tabjump=create st_tabjump
this.cb_4=create cb_4
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.cb_document=create cb_document
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_map=create cb_map
this.cb_cashadvance=create cb_cashadvance
this.Control[]={this.st_tabjump,&
this.cb_4,&
this.ddlb_1,&
this.st_2,&
this.cb_document,&
this.cb_2,&
this.cb_1,&
this.cb_map,&
this.cb_cashadvance}
end on

on tabpage_details.destroy
destroy(this.st_tabjump)
destroy(this.cb_4)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.cb_document)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_map)
destroy(this.cb_cashadvance)
end on

type st_tabjump from statictext within tabpage_details
integer x = 2487
integer y = 36
integer width = 274
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "TabJump"
end type

event getfocus;// RDT 7-17-03

SetFocus( dw_detail )
end event

type cb_4 from u_cb within tabpage_details
integer x = 2944
integer y = 368
integer width = 462
integer taborder = 60
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Items on Truc&k"
end type

event clicked;Long	ll_Row

ll_Row = dw_Itin.GetRow  ( )

IF ll_Row > 0 THEN
	Items_on_Truck ( ll_Row )
END IF
end event

type ddlb_1 from dropdownlistbox within tabpage_details
integer x = 3154
integer y = 536
integer width = 325
integer height = 228
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
string item[] = {"BASE","LOCAL"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SelectItem ( 2 )  //Local
end event

event selectionchanged;dw_itin.modify("st_tz_shift.text = '" + string(index - 1) + "'")
w_disp.wf_reset_times(1, "ITIN!")
dw_itin.setredraw(true)
dw_detail.setredraw(true)
end event

type st_2 from statictext within tabpage_details
integer x = 2775
integer y = 544
integer width = 370
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 29409472
boolean enabled = false
string text = "Time Display:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_document from u_cb within tabpage_details
integer x = 3182
integer y = 132
integer width = 329
integer taborder = 50
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Do&cument"
end type

event clicked;// RDT 4-1-03 PSR Processing added at the bottom

//wf_QuickPrint_Delrecs ( )
Long	lla_Ids[], ll_Count
Boolean	lb_UseCurrent = TRUE
boolean	lb_UseEvent

datawindow	ldw_Source
n_cst_Msg	lnv_Msg
s_parm		lstr_Parm
n_cst_Beo_Event	lnva_Events[]


IF wf_GetSelectedEvents ( lnva_Events ) > 0 THEN
	ll_Count = wf_GetSelectedEventIds ( lla_Ids, lb_UseCurrent )
	lb_UseEvent=TRUE
	lstr_Parm.is_Label = "EVENTID"
	lstr_Parm.ia_Value = lla_Ids
	lnv_Msg.of_Add_Parm (lstr_Parm)
//	ll_Count = wf_GetSelectedShipments ( lla_Ids, lb_UseCurrent )
//	lstr_Parm.is_Label = "SHIPMENTID"
//	lstr_Parm.ia_Value = lla_Ids
//	lnv_Msg.of_Add_Parm (lstr_Parm)
	
ELSE		
	ll_Count = wf_GetSelectedShipments ( lla_Ids, lb_UseCurrent )
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = lla_Ids
	lnv_Msg.of_Add_Parm (lstr_Parm)
	
END IF



ll_Count = wf_GetSelectedShipments ( lla_Ids, lb_UseCurrent )

IF ll_Count = 0 THEN
	MessageBox ( "Print Delivery Receipts", "You must select one or more shipment "+&
		"events first." )
ELSE
/*
//	ll_Count = wf_GetSelectedShipments ( lla_Ids, lb_UseCurrent )
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = lla_Ids
	lnv_Msg.of_Add_Parm (lstr_Parm)
	
	lstr_Parm.is_Label = "DOCUMENT"
	lstr_Parm.ia_Value = n_cst_Constants.cs_Document_DeliveryReceipt
	lnv_Msg.of_Add_Parm (lstr_Parm)

	ldw_Source = dw_itin
	lstr_Parm.is_Label = "DATAWINDOW"
	lstr_Parm.ia_Value = ldw_Source
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "MATCHCOLUMN"
	lstr_Parm.ia_Value = "de_shipment_id"
	lnv_Msg.of_Add_Parm (lstr_Parm)

	lstr_Parm.is_Label = "TOPIC"
	lstr_Parm.ia_Value = "SHIPMENT"
	lnv_Msg.of_Add_Parm (lstr_Parm)

*/

	lstr_Parm.is_Label = "DOCUMENT"
	lstr_Parm.ia_Value = n_cst_Constants.cs_Document_DeliveryReceipt
	lnv_Msg.of_Add_Parm (lstr_Parm)

	
	ldw_Source = dw_itin
	lstr_Parm.is_Label = "DATAWINDOW"
	lstr_Parm.ia_Value = ldw_Source
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	IF lb_UseEvent THEN

		lstr_Parm.is_Label = "MATCHCOLUMN"
		lstr_Parm.ia_Value = "de_id"
		lnv_Msg.of_Add_Parm (lstr_Parm)
		
		lstr_Parm.is_Label = "TOPIC"
		lstr_Parm.ia_Value = "EVENT"
		lnv_Msg.of_Add_Parm (lstr_Parm)

		lstr_Parm.is_Label = "EVENTS"
		lstr_Parm.ia_Value = lnva_Events
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	ELSE
		
		lstr_Parm.is_Label = "MATCHCOLUMN"
		lstr_Parm.ia_Value = "de_shipment_id"
		lnv_Msg.of_Add_Parm (lstr_Parm)

		lstr_Parm.is_Label = "TOPIC"
		lstr_Parm.ia_Value = "SHIPMENT"
		lnv_Msg.of_Add_Parm (lstr_Parm)

	END IF
	
	

	
//	openWithParm  ( w_DocumentSelection, anv_cst_msg )
	


	openWithParm  ( w_DocumentSelection, lnv_Msg )		
	
	IF isValid(Message.PowerObjectParm) THEN
		IF Message.PowerObjectParm.ClassName() = "n_cst_msg" THEN
			wf_processpsr( Message.PowerObjectparm)						// RDT 4-1-03 
		END IF
	END IF


END IF
end event

type cb_2 from u_cb within tabpage_details
integer x = 2802
integer y = 132
integer width = 329
integer taborder = 40
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "S&tats"
end type

event clicked;n_cst_msg	lnv_msg
s_Parm		lstr_Parm
w_ItineraryStats		lw_Stats
n_cst_Bso_Dispatch	lnv_Dispatch

lnv_Dispatch = w_disp.wf_GetDispatchManager ( )

IF IsValid ( lnv_Dispatch ) THEN
	lstr_Parm.is_Label = "DISPATCHOBJECT"
	lstr_Parm.ia_Value = lnv_Dispatch
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "Date"
	lstr_Parm.ia_Value = itin_date
	lnv_Msg.of_Add_Parm ( lstr_Parm )
		
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = Itin_Type //gc_Dispatch.ci_ItinType_Driver
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = Itin_Id
	lnv_msg.of_Add_Parm ( lstr_Parm )

	OpenWithParm ( lw_Stats , lnv_Msg )
	
END IF


end event

type cb_1 from u_cb within tabpage_details
integer x = 3182
integer y = 20
integer width = 329
integer taborder = 30
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Drive &Instr."
end type

event clicked;setpointer(HourGlass!)
integer	li_return = 1
long		ll_rowcount, &
			ll_row, &
			ll_ndx, &
			ll_companyid
string 	ls_locator, &
			ls_lastlocator, &
			ls_address
Boolean	lb_ApproveLocations

n_cst_LicenseManager	lnv_LicenseManager
s_mapping 	trips
datastore	lds_source
n_cst_beo_Company	lnv_Company
		
if isvalid(reportwin) then 
	li_return = -1
end if

if li_return = 1 then

	if dw_itin.rowcount() > 1 then
		lds_source = create datastore
		lds_source.DataObject = "d_companyinfo"
		
		lnv_Company = CREATE n_cst_beo_Company

		ll_rowcount = dw_itin.rowcount()
		
		for ll_ndx = 1 to ll_rowcount
			if dw_itin.getitemstring(ll_ndx, "co_pcm") = ls_locator then
				continue  //same as last row
			end if
			ls_locator = dw_itin.getitemstring(ll_ndx, "co_pcm")
			if isnull(ls_locator) or len(trim(ls_locator)) = 0 then 
				continue //can't include without locator
			end if
			
			ll_row = lds_source.insertrow(0)
			
			if ll_row > 0 then
				lds_source.setitem(ll_row, "co_pcm", ls_locator)
				lds_source.setitem(ll_row, "co_city", dw_itin.object.co_city[ll_ndx])
				lds_source.setitem(ll_row, "co_state", dw_itin.object.co_state[ll_ndx])
				lds_source.setitem(ll_row, "co_zip", dw_itin.object.co_zip[ll_ndx])
				
				if lnv_LicenseManager.of_usepcmilerstreets() then
					ll_CompanyId = dw_itin.object.de_site[ll_ndx]
					
					IF NOT IsNull ( ll_CompanyId ) THEN
						gnv_cst_Companies.of_Cache ( ll_CompanyId, FALSE )
					END IF

					//Point the company beo at the cache
					lnv_Company.of_SetUseCache ( TRUE )
		
					IF lnv_Company.of_SetSourceId ( ll_CompanyId ) = 1 THEN
						IF lnv_Company.of_HasSource ( ) THEN
							ls_address = lnv_Company.of_GetAddress1 ( )
							if isnull(ls_address) then
								ls_address = ""
							end if
							lds_source.setitem(ll_row, "co_addr1",ls_address)
						END IF
					END IF
	
				end if
				
				if lb_ApproveLocations then
					//need at least 2 different stops
				else
					if ls_lastlocator = "" then 
						ls_lastlocator = ls_locator
					elseif ls_lastlocator <> ls_locator then
						lb_ApproveLocations = true
					end if
				end if
				
			end if

		next	
	else
		//need at least 2 stops
		lb_ApproveLocations = false
	end if

	if lb_ApproveLocations then
		//ok
	else
		messagebox("Show Driving Instructions", "At least two different locations must appear "+&
						"in the itinerary in order to generate driving instructions.~n~nRequest cancelled.", exclamation!)
		li_return = -1	
	end if
	
end if

if li_return = 1 then

	CHOOSE CASE itin_type
			
		CASE gc_Dispatch.ci_ItinType_Trip
			IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Brokerage, "E" ) < 0 THEN
				li_return = -1	
			END IF
		CASE ELSE
			IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Dispatch, "E" ) < 0 THEN
				li_return = -1	
			END IF
			
	END CHOOSE

end if

IF li_return = 1 THEN

//	trips.dw_source = dw_itin
//	trips.ds_source = null_ds
	trips.dw_source = null_dw
	trips.ds_source = lds_source
	trips.ypos = parent.y + dw_detail.y

	if lnv_LicenseManager.of_usepcmilerstreets() or lnv_LicenseManager.of_haspcmilerlicense() then
		openwithparm(reportwin, trips, w_disp)
	else
		//no license
	end if
	
END IF

destroy	lds_Source
destroy	lnv_company
end event

type cb_map from u_cb within tabpage_details
integer x = 2802
integer y = 20
integer width = 329
integer taborder = 20
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Show &Map"
end type

event clicked;//Easter Eggs

if keydown(keycontrol!) and keydown(keyshift!) then
	openwithparm(w_itin_diag, dw_itin)
	return
elseif keydown(keyshift!) then
	wf_GetDispatchManager().of_GetEquipmentCache().SaveAs ( "c:\test\eqcache.txt", Text!, TRUE )
	return
elseif keydown(keycontrol!) then

	n_cst_EventConfirmationOptions	lnv_EventConfirmationOptions
	lnv_EventConfirmationOptions = CREATE n_cst_EventConfirmationOptions
	lnv_EventConfirmationOptions.of_OpenWindow ( )
	DESTROY lnv_EventConfirmationOptions

//	long checkloop
//	string msgstr
//	date test_date
//	w_disp.ds_retlist.setfilter("")
//	w_disp.ds_retlist.setsort("itin_cat A, itin_id A, start_date A")
//	w_disp.ds_retlist.filter()
//	w_disp.ds_retlist.sort()
//	msgstr = "Primary: " + string(w_disp.ds_retlist.rowcount()) + " Filter: " +&
//		string(w_disp.ds_retlist.filteredcount()) + "~n~n"
//	for checkloop = 1 to w_disp.ds_retlist.rowcount()
//		msgstr += w_disp.ds_retlist.object.itin_cat[checkloop] + " "
//		msgstr += string(w_disp.ds_retlist.object.itin_id[checkloop]) + " "
//		test_date = w_disp.ds_retlist.object.start_date[checkloop]
//		if isnull(test_date) then msgstr += "NULL " &
//			else msgstr += string(test_date, "yyyy-mm-dd") + " "
//		test_date = w_disp.ds_retlist.object.end_date[checkloop]
//		if isnull(test_date) then msgstr += "NULL " &
//			else msgstr += string(test_date, "yyyy-mm-dd") + " "
//		msgstr += "~n"
//	next
//	messagebox("Retlist Values", msgstr)
//	return
end if


//Begin Actual Mapping Code

n_cst_LicenseManager	lnv_LicenseManager
Boolean	lb_ApproveSelection = TRUE
s_mapping maps

if isvalid(iw_map) then return
if isvalid(iw_mapstreets) then return

CHOOSE CASE itin_type
		
	CASE gc_Dispatch.ci_ItinType_Trip
		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Brokerage, "E" ) < 0 THEN
			lb_ApproveSelection = FALSE
		END IF
	CASE ELSE
		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_Constants.cs_Module_Dispatch, "E" ) < 0 THEN
			lb_ApproveSelection = FALSE
		END IF
		
END CHOOSE


IF lb_ApproveSelection THEN

	maps.dw_source = dw_itin
	maps.ds_source = null_ds
	maps.ypos = parent.y + dw_detail.y
	maps.xpos = 1098
	maps.typemap = "R"
	maps.layername = string(itin_date, "m/d/yy")
	
	if lnv_LicenseManager.of_usepcmilerstreets() then
		openwithparm(iw_mapstreets, maps, w_disp)
	elseif lnv_LicenseManager.of_haspcmilerlicense() then
			openwithparm(iw_map, maps, w_disp)
	else
		//no license	
	end if

END IF

end event

type cb_cashadvance from u_cb within tabpage_details
integer x = 3003
integer y = 248
integer width = 329
integer taborder = 70
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Cash &Adv"
end type

event clicked;long	ll_DriverID
Long	ll_EntityID
String	ls_Ref
n_cst_msg	lnv_msg
S_Parm		lstr_Parm
n_cst_beo_Event	lnv_Event

lnv_Event = CREATE n_cst_beo_Event

lnv_Event.of_SetSource ( dw_detail )
lnv_Event.of_SetSourceRow ( dw_detail.GetRow ( ) )

ll_DriverID = lnv_Event.of_GetDriverID ( )

n_cst_EmployeeManager lnv_EmployeeManager

lnv_EmployeeManager.of_GetEntity ( ll_DriverID , ll_EntityID, TRUE, TRUE )

IF ll_EntityID > 0 THEN
	lstr_Parm.is_Label = "ENTITYID"
	lstr_Parm.ia_Value = ll_EntityID
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ENTITYTYPE"
	lstr_Parm.ia_Value = "E"
	lnv_Msg.of_Add_Parm ( lstr_Parm )

	OpenWithParm ( w_CashAdvance , lnv_msg )
ELSE
	open ( w_CashAdvance )
END IF

DESTROY ( lnv_Event ) 
end event

event constructor;n_cst_LicenseManager	lnv_LicenseManager

IF Not lnv_LicenseManager.of_GetLicensed ( n_cst_constants.cs_Module_Settlements ) THEN
	This.Visible = FALSE
END IF
end event

type tabpage_assignments from u_cst_eventrouting_assignments within tab_route
integer x = 18
integer y = 108
integer width = 3538
integer height = 868
string text = "Itinerary"
long tabbackcolor = 12632256
end type

event ue_getitinerarywindow;RETURN Parent.Event ue_GetItineraryWindow ( )
end event

event ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatchManager ( )
end event

event ue_performassociationvalidation;call super::ue_performassociationvalidation;Int	li_Return = 1
Int	li_Problems

n_Cst_Bso_Dispatch	lnv_Disp
lnv_Disp = wf_GetDispatchmanager( )
n_cst_bso_validation	lnv_Validation

n_Cst_beo_Event	lnv_Event
lnv_Event = CREATE n_Cst_beo_Event
lnv_Event.of_setSource ( lnv_Disp.of_GetEventCache( ) )
lnv_Event.of_SetSourceID ( ala_eventids[1] )

IF NOT lnv_Disp.of_Isassignmentrequestbackwards( itin_type , lnv_Event ) THEN

	li_Problems = lnv_Disp.of_Validateassignment( ala_Eventids[1] , ai_assignmenttype , al_assignmentid , itin_type, itin_id )  
	
	IF li_Problems > 0 THEN
		lnv_Validation = lnv_Disp.of_getValidation( )
	END IF	
	
	IF IsValid ( lnv_Validation ) THEN
		IF lnv_Validation.of_dowecontinue( ) THEN 
			li_Return = 1 
		ELSE
			li_Return = 0
		END IF
	END IF
ELSE
	// of assignbyReroute will do the validation
//	MessageBox( "Hey" , "That be backwards" )
	
END IF

DESTROY ( lnv_Event )

RETURN li_Return
end event

event ue_performdisassociationvalidation;call super::ue_performdisassociationvalidation;Int	li_Return = 1
Int	li_Problems
Long	ll_EventCount 
Long	i
n_cst_bso_validation	lnv_Validation
n_Cst_beo_Event		lnva_Events[]
n_Cst_beo_Event		lnv_Event
n_cst_events			lnv_Events
n_Cst_Bso_Dispatch	lnv_Disp

lnv_Disp = wf_GetDispatchmanager( )

dw_itin.SelectRow ( 0 , FALSE )
dw_itin.SelectRow ( dw_itin.GetRow ( ), TRUE )

wf_Getselectedevents( lnva_Events )
ll_EventCount = UpperBound ( lnva_Events )

FOR i = 1 TO ll_EventCount
	IF lnva_Events[i].of_GetID( ) = al_eventid THEN
		lnv_Event = lnva_Events[i]
		EXIT
	END IF
NEXT

IF IsValid ( lnv_Event ) THEN 
	IF lnv_Events.of_istypedissociation( lnv_Event.of_GetType() ) THEN
	
		li_Problems = lnv_Disp.of_ValidateDisassociation (al_eventid, ai_Unassignmenttype , al_Unassignmentid , itin_type, itin_id )  
		
		IF li_Problems > 0 THEN
			lnv_Validation = lnv_Disp.of_getValidation( )
		END IF	
		
		IF IsValid ( lnv_Validation ) THEN
			IF lnv_Validation.of_dowecontinue( ) THEN 
				li_Return = 1 
			ELSE
				li_Return = 0
			END IF
		END IF
	ELSE // the 'trickle' effect is not an issue, but, we do have to check that we can modify the target event
		//begin midification by appeon 20070731
//invoke constant form n_cst_appeon_constant
//IF gnv_app.of_getprivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", lnv_Event ) <> n_cst_privsmanager.ci_TRUE THEN
		IF gnv_app.of_getprivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", lnv_Event ) <> appeon_constant.ci_TRUE THEN
	//end midification by appeon

	// message box is formatted to look like the other messages that may come from the validation object
			MessageBox ( "Association Validation" , "The following problems were discovered:~r~nYour privileges do not permit you to make this modification." , Exclamation! )
			li_Return = 0
			
		END IF			
	END IF
END IF

n_cst_AnyArraySrv	lnv_Array
lnv_Array.of_Destroy( lnva_Events )

RETURN li_Return
end event

event ue_validateunassignall;call super::ue_validateunassignall;RETURN wf_Validatedisasociation( {al_eventid} )
end event

type tabpage_shipment from u_cst_eventrouting_shipment within tab_route
event ue_refresh ( )
integer x = 18
integer y = 108
integer width = 3538
integer height = 868
string text = "Shipment"
long tabbackcolor = 12632256
end type

event ue_refresh;THIS.Event ue_RefreshEvents ( )
end event

event ue_getitinerarywindow;RETURN Parent.Event ue_GetItineraryWindow ( )
end event

event ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatchManager ( )
end event

event ue_assignequipment;//OVERRIDING ANCESTOR -- REQUEST HANDLING IS IMPLEMENTED ON THE DESCENDANT

//Parent.SelectTab ( tabpage_Assignments )
tabpage_Assignments.of_SetSelection ( as_Ref )
IF Len ( as_Ref ) > 0 THEN
	tabpage_Assignments.Event ue_AddRemove ( )
END IF
RETURN 1





end event

event ue_removeevents;call super::ue_removeevents; THIS.Event ue_GetItineraryWindow () .Event ue_RefreshItinerary ( FALSE )
RETURN AncestorReturnValue
end event

event ue_assignlinkedequipment;RETURN dw_itin.Event ue_assignToEvent ( dw_itin.GetRow ( )  , as_type , as_ref , al_id )

end event

event ue_assignreferencedequipment;Int	li_SelectionType
Long	ll_SelectionID
String	ls_Type

n_cst_EquipmentManager	lnv_Equipment


ll_SelectionID = al_eqid
li_SelectionType = lnv_Equipment.of_GetItinType ( THIS.of_GetEquipmentType ( ll_SelectionID )  )

IF tab_route.tabpage_assignments.Event ue_Select ( li_SelectionType, ll_SelectionId ) = 1 THEN
	tab_route.tabpage_assignments.Event ue_AddRemove ( )
END IF

RETURN 1
end event

event ue_autoassignnewequipment;call super::ue_autoassignnewequipment;This.of_DisplayItinerary ( Itin_Type, Itin_Id, Itin_Date )
wf_SetRedraw ( TRUE )
RETURN 1

end event

event ue_sitechanged;call super::ue_sitechanged;wf_GetParent ( ).wf_reset_times(1, "ITIN!")
end event

event ue_shipmentchanged;call super::ue_shipmentchanged;wf_showalerts(  )
end event

type tabpage_clipboard from u_cst_eventrouting_clipboard within tab_route
integer x = 18
integer y = 108
integer width = 3538
integer height = 868
string text = "Clipboard"
long tabbackcolor = 12632256
end type

event ue_getitinerarywindow;RETURN Parent.Event ue_GetItineraryWindow ( )
end event

event ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatchManager ( )
end event

