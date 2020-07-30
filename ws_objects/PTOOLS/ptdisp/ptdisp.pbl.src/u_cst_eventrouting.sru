$PBExportHeader$u_cst_eventrouting.sru
forward
global type u_cst_eventrouting from u_base
end type
end forward

global type u_cst_eventrouting from u_base
integer width = 3534
integer height = 788
long backcolor = 12632256
event type w_itin ue_getitinerarywindow ( )
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event type long ue_getroutingids ( ref long ala_ids[] )
event type integer ue_autoroute ( )
event ue_setroutemodeindicator ( boolean ab_switch )
event ue_itineraryrowchanged ( long al_row )
event ue_ipanswer ( integer ai_requesttype,  date ad_insertiondate,  long al_insertionevent,  integer ai_insertionstyle )
event type boolean ue_iseventrouting ( )
event type integer ue_performassociationvalidation ( long ala_eventids[],  long al_insertionevent,  date ad_insertiondate,  integer ai_assignmenttype,  long al_assignmentid )
event type integer ue_performdisassociationvalidation ( long al_eventid,  integer ai_unassignmenttype,  long al_unassignmentid )
end type
global u_cst_eventrouting u_cst_eventrouting

forward prototypes
public function integer of_displayitinerary (integer ai_type, long al_id, date ad_date)
public function integer of_refreshitinerary (boolean ab_defaultscroll)
end prototypes

event ue_getroutingids;//Override in descendant to provide a list of ids that a route command should route.
//Unless overridden, the event fails by default.

//Returns the number of ids in ala_Ids if successful, or -1 if unsuccessful.

//If failing or providing an empty list of ids, the event is expected to notify and explain
//the situation to the user, if any notification and explanation is desired.

Long	lla_Empty[]

ala_Ids = lla_Empty

RETURN -1
end event

event ue_autoroute;//Returns:  1 = Success, 0 = User Cancelled, or Nothing Selected to Route, -1 = Error

//Declare the appropriate insertion style and event, and forward processing
//to of_Route.

Long		lla_EventIds[]
w_Itin	lw_Itinerary
Integer	li_InsertionStyle
Long		ll_InsertionEvent
String	ls_ErrorMessage

Integer	li_Return = 1


IF li_Return = 1 THEN

	//Note  : ue_GetRoutingIds provides it's own error or "none available" messages,
	//if appropriate.  So, if this doesn't work, we don't want another error message.

	CHOOSE CASE This.Event ue_GetRoutingIds ( lla_EventIds )

	CASE IS > 0
		//OK

	CASE 0
		ls_ErrorMessage = ""
		li_Return = 0

	CASE -1  //Error
		ls_ErrorMessage = ""
		li_Return = -1

	CASE ELSE  //Unexpected return value -- Provide our own message, since we don't know what happened.
		ls_ErrorMessage = "Unexpected return error while attempting to auto-route. (A)"
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )

	IF NOT IsValid ( lw_Itinerary ) THEN
		ls_ErrorMessage = "Could not resolve itinerary window reference."
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	//Set InsertionEvent and InsertionStyle parameters appropriately for Auto-Route
	//InsertionEvent will be null because InsertionStyle_EndOfRoute does not require an insertion event.
	li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_EndOfRoute
	SetNull ( ll_InsertionEvent )

	CHOOSE CASE lw_Itinerary.wf_Route ( lla_EventIds, ll_InsertionEvent, li_InsertionStyle )

	CASE 1  //Success
		//OK

	CASE 0  //User cancelled
		li_Return = 0

	CASE ELSE //-1
		ls_ErrorMessage = ""
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	MessageBox ( "Auto-Route Events", ls_ErrorMessage, Exclamation! )
END IF

RETURN li_Return
end event

event ue_ipanswer;This.Event ue_SetRouteModeIndicator ( FALSE )
end event

event ue_iseventrouting;//Always return TRUE.  Can be used by the outside world to determine whether a u.o.
//(in a tab control, for example) has EventRouting interface.

RETURN TRUE
end event

public function integer of_displayitinerary (integer ai_type, long al_id, date ad_date);//Forwards the request to ue_DisplayItinerary on the itinerary window, 
//which displays an error message if an error occurs.

//Returns : 1, -1

w_Itin	lw_Itinerary

Integer	li_Return = 1


IF li_Return = 1 THEN

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )

	IF NOT IsValid ( lw_Itinerary ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF lw_Itinerary.Event ue_DisplayItinerary ( ai_Type, al_Id, ad_Date ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF

RETURN li_Return
end function

public function integer of_refreshitinerary (boolean ab_defaultscroll);//Forwards the request to ue_RefreshItinerary on the itinerary window, 
//which displays an error message if an error occurs.

//Returns : 1, -1

w_Itin	lw_Itinerary

Integer	li_Return = 1


IF li_Return = 1 THEN

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )

	IF NOT IsValid ( lw_Itinerary ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF lw_Itinerary.Event ue_RefreshItinerary ( ab_DefaultScroll ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

END IF

RETURN li_Return
end function

event destructor;call super::destructor;//Extending ancestor

//If we're in Route mode, clear the request on iw_Itinerary.

w_Itin	lw_Itinerary

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN
	IF lw_Itinerary.Whats_On = lw_Itinerary.ci_RouteRequest_Clipboard THEN
		lw_Itinerary.Clear_ip ( )
	END IF
END IF
end event

on u_cst_eventrouting.create
call super::create
end on

on u_cst_eventrouting.destroy
call super::destroy
end on

