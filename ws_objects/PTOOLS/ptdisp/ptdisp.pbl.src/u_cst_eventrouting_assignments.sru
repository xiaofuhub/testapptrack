$PBExportHeader$u_cst_eventrouting_assignments.sru
forward
global type u_cst_eventrouting_assignments from u_cst_eventrouting
end type
type gb_3 from groupbox within u_cst_eventrouting_assignments
end type
type tab_newevents from u_tab_newevents within u_cst_eventrouting_assignments
end type
type tab_newevents from u_tab_newevents within u_cst_eventrouting_assignments
end type
type lb_assignmentlist from u_lb within u_cst_eventrouting_assignments
end type
type sle_selection from u_sle within u_cst_eventrouting_assignments
end type
type cb_process from u_cb within u_cst_eventrouting_assignments
end type
type cb_select from u_cb within u_cst_eventrouting_assignments
end type
type gb_5 from groupbox within u_cst_eventrouting_assignments
end type
type gb_2 from groupbox within u_cst_eventrouting_assignments
end type
type gb_1 from groupbox within u_cst_eventrouting_assignments
end type
type st_eventtype from statictext within u_cst_eventrouting_assignments
end type
type cb_unassignall from u_cb within u_cst_eventrouting_assignments
end type
type lb_references from u_lb within u_cst_eventrouting_assignments
end type
type cb_clearreferences from u_cb within u_cst_eventrouting_assignments
end type
type cb_remove from u_cb within u_cst_eventrouting_assignments
end type
type cb_reroute from u_cb within u_cst_eventrouting_assignments
end type
type st_reroute from statictext within u_cst_eventrouting_assignments
end type
type cb_refreshreferences from u_cb within u_cst_eventrouting_assignments
end type
type dw_2 from u_dw_emp_list within u_cst_eventrouting_assignments
end type
type dw_1 from u_dw_eqlist within u_cst_eventrouting_assignments
end type
type cb_1 from commandbutton within u_cst_eventrouting_assignments
end type
end forward

global type u_cst_eventrouting_assignments from u_cst_eventrouting
integer width = 4123
integer height = 852
event type integer ue_refresh ( )
event type integer ue_addremove ( )
event type integer ue_assign ( integer ai_type,  long al_id,  date ad_insertiondate,  long al_insertionevent,  integer ai_insertionstyle,  boolean ab_ipmode )
event type integer ue_unassign ( integer ai_type,  long al_id )
event type integer ue_unassignall ( )
event type integer ue_select ( integer ai_type,  long al_id )
event type integer ue_refreshreferencelists ( )
event type integer ue_refreshreferences ( long al_listindex )
event ue_routemode ( )
event type integer ue_removerequest ( )
event type integer ue_rerouterequest ( )
event ue_createequipment ( string as_eqref )
event type integer ue_validateunassignall ( long al_eventid )
gb_3 gb_3
tab_newevents tab_newevents
lb_assignmentlist lb_assignmentlist
sle_selection sle_selection
cb_process cb_process
cb_select cb_select
gb_5 gb_5
gb_2 gb_2
gb_1 gb_1
st_eventtype st_eventtype
cb_unassignall cb_unassignall
lb_references lb_references
cb_clearreferences cb_clearreferences
cb_remove cb_remove
cb_reroute cb_reroute
st_reroute st_reroute
cb_refreshreferences cb_refreshreferences
dw_2 dw_2
dw_1 dw_1
cb_1 cb_1
end type
global u_cst_eventrouting_assignments u_cst_eventrouting_assignments

type variables
Protected:

n_cst_beo_Event	inv_Event

//This object is our property -- we need to destroy it when 
//this object is destroyed.
n_cst_DispatchIds	inv_AssignmentList

//These objects are NOT our property -- we do not need 
//to destroy them when this object is destroyed (they're
//just references to objects on the dispatch manager.) 
//We CAN destroy them if we want to, though, such as
//is the case if the user requests to delete a particular
//list entry.
n_cst_DispatchIds	inva_ReferenceLists[]
Integer	il_SelectedReferenceList = 0

//Records the type and id of the currently selected target,
//the one you'll add/remove by hitting "process"
Integer	ii_SelectionType
Long	il_SelectionId

Long	il_BaseEvent
//Integer	ii_BaseType
//Long	il_BaseId

//If the display needs to be flopped to get an insertion 
//point, the type and id of the itinerary the user was 
//working with when the request was made will be stored 
//in Launch Type / Id, so we can come back to it.
Date	id_LaunchDate
Integer	ii_LaunchType
Long	il_LaunchId
end variables

forward prototypes
protected function integer of_getdescription (integer ai_type, long al_id, ref string as_description)
public function integer of_setselection (string as_ref)
public function long of_selectdriver ()
end prototypes

event ue_refresh;//Returns : 1 = Success (has a row), 0 (Success, no row), -1

Long		ll_Row
Integer	li_Result, &
			li_Loop, &
			li_ListCount
String	lsa_List[], &
			ls_MultiList, &
			ls_EventType, &
			ls_AssignmentIndicator

n_cst_Events			lnv_Events
w_Itin					lw_Itinerary
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_DispatchIds		lnv_AssignmentList

ListBox	lb_Target
lb_Target = lb_AssignmentList


Integer	li_Return = 1


IF li_Return = 1 THEN

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )
	lnv_Dispatch = This.Event ue_GetDispatchManager ( )

	IF IsValid ( lw_Itinerary ) AND IsValid ( lnv_Dispatch ) THEN

		//OK

	ELSE
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	ll_Row = lw_Itinerary.dw_Itin.GetRow ( )

	//Even if we don't have a row, we still have to reset inv_Event
	inv_Event.of_SetSource ( lnv_Dispatch.of_GetEventCache ( ) )
	inv_Event.of_SetSourceRow ( ll_Row )

	IF ll_Row > 0 THEN

		//OK, we have a row to work with.

		//Get some values we will need to use below.
		ls_EventType = inv_Event.of_GetType ( )
		ls_MultiList = inv_Event.of_GetMultiList ( )

		st_EventType.Text = lnv_Events.of_GetTypeDisplayValue ( inv_Event.of_GetType ( ) )

	ELSE
		li_Return = 0

	END IF

END IF


IF li_Return = 1 THEN

//	li_Result = inv_Event.of_GetAssignments ( lla_Drivers, lla_PowerUnits, lla_TrailerChassis, lla_Containers )
	li_Result = inv_Event.of_GetAssignments ( lnv_AssignmentList )
	
	CHOOSE CASE li_Result
	
	CASE 1   //Success  (means beo is ok, incidentally)

		IF lnv_Events.of_IsTypeAssociation ( ls_EventType ) THEN
			ls_AssignmentIndicator = "+"
		ELSEIF lnv_Events.of_IsTypeDissociation ( ls_EventType ) THEN
			ls_AssignmentIndicator = "x"
//			ls_AssignmentIndicator = "~~"  //Use tilde instead of minus sign for better visibility.
		END IF
	
	CASE ELSE
		li_Return = -1
	
	END CHOOSE

END IF


IF li_Return = 1 THEN

	IF IsValid ( lnv_AssignmentList ) THEN  //Should be

		li_ListCount = lnv_AssignmentList.of_GetDisplayList ( ls_AssignmentIndicator, &
			ls_MultiList, lsa_List )

	END IF

END IF


//Regardless of what the outcome is, reset the list.  
//If we did get values, write them into the list.

lb_Target.SetRedraw ( FALSE )

lb_Target.Reset ( )

FOR li_Loop = 1 TO li_ListCount

	lb_Target.AddItem ( lsa_List [ li_Loop ] )

NEXT

lb_Target.SetRedraw ( TRUE )


//No matter what the outcome, destroy the instance assignment list and replace it with
//the list we've just generated, if it's valid.

DESTROY inv_AssignmentList

IF IsValid ( lnv_AssignmentList ) THEN
	inv_AssignmentList = lnv_AssignmentList
END IF


//Notify user somehow of an error?


RETURN li_Return
end event

event type integer ue_addremove();//Returns : 1, 0 (Nothing selected to add/remove), -1 (Error)
n_cst_privileges_events	lnv_Privs
Integer	li_InsertionStyle

Long		ll_Null
SetNull ( ll_Null )

Date		ld_Null
SetNull ( ld_Null )

Integer	li_Return = 1

IF li_Return = 1 THEN

	IF IsNull ( il_SelectionId ) THEN
		li_Return = 0
	END IF

END IF

IF li_Return = 1 THEN
	
	IF NOT lnv_Privs.of_allowalteritins( ) THEN
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF inv_Event.of_IsActiveInAssignment ( ii_SelectionType, il_SelectionId ) = TRUE THEN

		CHOOSE CASE This.Event ue_Unassign ( ii_SelectionType, il_SelectionId )

		CASE 1
			//OK

		CASE ELSE
			li_Return = -1

		END CHOOSE

	ELSE

		li_InsertionStyle = gc_Dispatch.ci_InsertionStyle_Assignment
		//Have an option to use gc_Dispatch.ci_InsertionStyle_EmptyDay ???

		CHOOSE CASE This.Event ue_Assign ( ii_SelectionType, il_SelectionId, &
			ld_Null /*Unspecified Insertion Date -- will be filled in by ue_Assign*/, &
			ll_Null /*Unspecified Insertion Event -- not needed for this InsertionStyle*/, &
			li_InsertionStyle, FALSE /*We're not in IPMode*/ )

		CASE 1
			//OK

		CASE ELSE
			li_Return = -1

		END CHOOSE

	END IF

END IF


RETURN li_Return
end event

event type integer ue_assign(integer ai_type, long al_id, date ad_insertiondate, long al_insertionevent, integer ai_insertionstyle, boolean ab_ipmode);//Returns : 1, -1 , 0 = user canceled

//Explanation of al_BeforeEvent :  al_BeforeEvent is the id of the event before which
//you want to insert the assignment sequence in the target itinerary.  If you want to
//attempt an unspecified insertion point, make this parameter null.  If of_Assign 
//decides that an insertion point is indeed required, this script will toggle the itinerary
//display to the target itinerary and put the display in insertion point mode, with the
//mode indicator being ci_RouteRequest_Assignment.  If the user does make an insertion 
//point request, this same script will end up being called again, with the insertion point
//specified.

Integer	li_TargetType, &
			li_ItinType, &
			li_Null
Long		ll_TargetId, &
			ll_TargetEvent, &
			ll_ItinId, &
			ll_Null
Date		ld_ItinDate
Boolean	lb_Validate
Boolean	lb_Again

w_Itin					lw_Itinerary
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnva_Errors[]

String	ls_MessageHeader = "Change Assignment", &
			ls_ErrorMessage = "Could not process request."

//Flag to indicate whether changes have or may have been made that require refresh.
//Set to true once this condition occurs.
Boolean	lb_RefreshDisplay = FALSE

//Flag to indicate whether an insertion point is required, on an unspecified IP request.
Boolean	lb_InsertionPointRequired = FALSE


Integer	li_Return = 1

lb_Again = FALSE
lb_Validate = TRUE
SetNull ( li_Null )
SetNull ( ll_Null )


IF li_Return = 1 THEN

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )

	IF NOT IsValid ( lw_Itinerary ) THEN
		li_Return = -1
	ELSE
		li_ItinType = lw_Itinerary.Itin_Type
		ll_ItinId = lw_Itinerary.Itin_Id
		ld_ItinDate = lw_Itinerary.Itin_Date

		//ci_InsertionStyle_EmptyDay and ci_InsertionStyle_Assignment require
		//an InsertionDate.  If one of these insertion styles was specified and
		//no InsertionDate was provided, use the ItinDate.  
		//(This option is used by ue_AddRemove)

		CHOOSE CASE ai_InsertionStyle

		CASE gc_Dispatch.ci_InsertionStyle_EmptyDay, gc_Dispatch.ci_InsertionStyle_Assignment

			IF IsNull ( ad_InsertionDate ) THEN

				ad_InsertionDate = ld_ItinDate

			END IF

		END CHOOSE

	END IF

END IF


IF li_Return = 1 THEN

	lnv_Dispatch = This.Event ue_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	//If we're not in IPMode, we need to determine some settings.  If we are in IPMode, 
	//these settings were determined by this function on the last pass through, when the 
	//IPMode got turned on, and are already on the instance variables.

	IF ab_IPMode = FALSE THEN

		//Record the event the user is targeting, in case we go to an IP operation
		//and the current event changes with the display.
		il_BaseEvent = inv_Event.of_GetId ( )
	
		//Record what the user had been looking at, so we can come back to it, either
		//later in this script, or after an IP operation.
		id_LaunchDate = ld_ItinDate
		ii_LaunchType = li_ItinType
		il_LaunchId = ll_ItinId

	END IF

END IF


IF li_Return = 1 THEN // new validation 
	// we check if the assignment request is backwards and if so skip validation since it will
	// be called by AssignByReroute.
	IF THIS.event ue_performassociationvalidation( {il_BaseEvent}, al_InsertionEvent , ad_InsertionDate , ai_type , al_id ) <> 1 THEN
		li_Return = 0
	END IF
END IF


IF li_Return = 1 THEN
	DO 
		lb_Again = FALSE  // only gets set to true on validation failure.
		lnv_Dispatch.ClearOFRErrors ( )
		
		CHOOSE CASE lnv_Dispatch.of_Assign ( li_Null, ll_Null, /*Pass in null for ai_BaseType and al_BaseId*/ &
			il_BaseEvent, ai_Type, al_Id, ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle , lb_Validate )
	
		CASE 1
			//Assignment was successful.
			lb_RefreshDisplay = TRUE
	
		CASE -1
	
			li_Return = -1
			lb_RefreshDisplay = TRUE  //Will be overridden to false below if it's an IPRQ error
	
			IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
	
				//There are errors to process -- Get the error text
				ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
	
				//Now that we've got what we need, clear the error list.
				lnv_Dispatch.ClearOFRErrors ( )
	
				IF ab_IPMode THEN
	
					ls_ErrorMessage += "~n~nDo you want to specify a different insertion point?"
	
					IF MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation!, YesNo!, 1 ) = 1 THEN
						lb_InsertionPointRequired = TRUE
						lb_RefreshDisplay = FALSE
					END IF
	
					//We already gave the message, so don't give it again later.
					ls_ErrorMessage = ""
	
				ELSEIF Pos ( ls_ErrorMessage, "(IPRQ)" ) > 0 THEN
	
					//The message contains the "(IPRQ)" flag, which is how of_Assign indicates to us 
					//that an insertion point is required on an unspecified insertion point attempt.
					lb_InsertionPointRequired = TRUE
					lb_RefreshDisplay = FALSE
					ls_ErrorMessage = ""
	
				END IF
	
			ELSE
				
			
				ls_ErrorMessage += "~n(Unspecified assignment error.)"
	
			END IF
	
		CASE -2 // AssignmentValidation Failed
			
			IF lnv_Dispatch.of_GetValidation( ).of_DoWeContinue ( ) THEN // this displays the message
				lb_Again = TRUE
				lb_Validate = FALSE
				li_Return = 0
			END IF
			
			
		CASE ELSE
	
			//Unexpected return value
			li_Return = -1
			ls_ErrorMessage += "~n(Unexpected return error on assignment.)"
	
			//We don't know what happened, so we'd better refresh the display.
			lb_RefreshDisplay = TRUE
	
		END CHOOSE
	LOOP WHILE lb_Again
END IF


//If we want an insertion point and we're not already in IPMode, toggle the itinerary
//display to the desired target.

IF lb_InsertionPointRequired AND ab_IPMode = FALSE THEN

	CHOOSE CASE This.of_DisplayItinerary ( ai_Type, al_Id, ld_ItinDate )

	CASE 1
		//OK, we displayed it.

	CASE ELSE

		ls_ErrorMessage = "Could not display the target itinerary, which is needed "+&
			"to process this request."

		//Flag that we no longer want the insertion point.
		lb_InsertionPointRequired = FALSE

		//li_Return is already -1, so there's nothing to change there.

	END CHOOSE

END IF


//If the display operation above succeeded (or was not needed), we're ready for the 
//insertion point.  Go ahead and turn it on.

IF lb_InsertionPointRequired THEN

	//Turn insertion point mode on.
	lw_Itinerary.show_ip()
	lw_Itinerary.whats_on = lw_Itinerary.ci_RouteRequest_Assignment
	lw_Itinerary.tab_type.setfocus()

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN

	MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )

END IF


//Whether we failed or not, refresh the display, unless we've flagged ourselves not to.

IF lb_RefreshDisplay = TRUE THEN

	//Set the scroll so that the event we're assigning to retains focus after the refresh.
	lw_Itinerary.wf_SetScroll ( { il_BaseEvent }, FALSE /*Don't select*/ )


	//Now, perform the refresh.  (We have to use display, not refresh, because we may have 
	//flopped the display to the target itinerary, above.)

	IF This.of_DisplayItinerary ( ii_LaunchType, il_LaunchId, id_LaunchDate ) = 1 THEN
	
		//OK
	
	ELSE
	
		//DisplayItinerary will have already notified of failure.  But, we'll give another message to put
		//things in context.
		MessageBox ( ls_MessageHeader, "Screen display may not reflect changes made." )

		//May be redundant.  But, may be necessary if it didn't get triggered by the 
		//failed redisplay.
		This.Event ue_Refresh ( )

	END IF

END IF


RETURN li_Return
end event

event type integer ue_unassign(integer ai_type, long al_id);Integer	li_TargetType
Long		ll_BaseEvent, &
			ll_TargetId
n_cst_Events			lnv_Events
w_Itin					lw_Itinerary
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnva_Errors[]

String	ls_MessageHeader = "Remove Assignment", &
			ls_ErrorMessage = "Could not process request."


Integer	li_Return = 1


IF li_Return = 1 THEN

	lw_Itinerary = This.Event ue_GetItineraryWindow ( )

	IF NOT IsValid ( lw_Itinerary ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Dispatch = This.Event ue_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ll_BaseEvent = inv_Event.of_GetId ( )
	li_TargetType = ai_Type
	ll_TargetId = al_Id

END IF

IF li_Return = 1 THEN // new validation 
	// we check if the assignment request is backwards and if so skip validation since it will
	// be called by AssignByReroute. 
	//IF lnv_Events.of_istypedissociation( inv_event.of_GetType ( ) ) THEN /// moved this check to the window level
		IF THIS.event ue_performDisassociationvalidation( ll_BaseEvent,  li_TargetType , ll_TargetId ) <> 1 THEN
			li_Return = 0
		END IF
	//END IF
END IF



IF li_Return = 1 THEN

	lnv_Dispatch.ClearOFRErrors ( )

	CHOOSE CASE lnv_Dispatch.of_Unassign ( ll_BaseEvent, li_TargetType, ll_TargetId )

	CASE 1		//Unassignment was successful.

	CASE -1		//Error

		li_Return = -1

		IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN

			//There are errors to process -- Get the error text
			ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )

			//Now that we've got what we need, clear the error list.
			lnv_Dispatch.ClearOFRErrors ( )

		ELSE
			ls_ErrorMessage += "~n(Unspecified error in of_Unassign.)"

		END IF

	CASE ELSE	//Unexpected return value

		li_Return = -1
		ls_ErrorMessage += "~n(Unexpected return error from of_Unassign.)"

	END CHOOSE

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN

	MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )

END IF


//Unlike ue_Assign, we would not have flopped the itinerary above, so the one we want 
//to display actually is the one showing.

//Even if we failed, we need to refresh the itinerary display, because changes could have
//been made.

IF This.of_RefreshItinerary ( TRUE /*Use default scroll behavior*/ ) = 1 THEN

	//OK

ELSE

	//RefreshItinerary will have already notified of failure.  But, we'll give another message to put
	//things in context.
	MessageBox ( ls_MessageHeader, "Screen display may not reflect changes made." )

END IF


RETURN li_Return
end event

event type integer ue_unassignall();//Returns : 1, 0 (No event, no attempt made), -1

//Process UnassignAll for the selected event.

Long	ll_EventId
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnva_Errors[]
String	ls_MessageHeader = "Unassign All"

Integer	li_Return = 1

IF li_Return = 1 THEN

	ll_EventId = inv_Event.of_GetId ( )
	
	IF IsNull ( ll_EventId ) THEN
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Dispatch = This.Event ue_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF

END IF

IF li_Return = 1 THEN
	IF THIS.event ue_validateunassignall( ll_EventId ) <> 1 THEN
		li_Return = 0
	END IF
END IF
	
	

IF li_Return = 1 THEN

	lnv_Dispatch.ClearOFRErrors ( )

	CHOOSE CASE lnv_Dispatch.of_UnassignAll ( { ll_EventId } )

	CASE 1
		//OK

	CASE -1
		li_Return = -1

	CASE ELSE  //Unexpected return
		li_Return = -1

	END CHOOSE

END IF


//Even if we failed, we need to refresh the itinerary display, because changes could have
//been made.

IF This.of_RefreshItinerary ( TRUE /*Use default scroll behavior*/ ) = 1 THEN

	//OK

ELSE

	//RefreshItinerary will have already notified of failure.  But, we'll give another message to put
	//things in context.
	MessageBox ( ls_MessageHeader, "Screen display may not reflect changes made." )

END IF


//Now, refresh the reference list listbox.
//This.Event ue_RefreshReferenceLists ( )

RETURN li_Return
end event

event ue_select;//Returns : 1, -1

String	ls_Description

Integer	li_Return = 1

IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetDescription ( ai_Type, al_Id, ls_Description )

	CASE 1
		//OK

	CASE ELSE
		MessageBox ( "Change Selection", "Could not process selection request -- request cancelled." )
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	ii_SelectionType = ai_Type
	il_SelectionId = al_Id
	sle_selection.Text = ls_Description

END IF


RETURN li_Return
end event

event ue_refreshreferencelists;n_cst_bso_Dispatch	lnv_Dispatch
n_cst_DispatchIds		lnva_ReferenceLists[]
Long		ll_ListCount, &
			ll_Index

Integer	li_Return = 1

IF li_Return = 1 THEN

	lnv_Dispatch = This.Event ue_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	ll_ListCount = lnv_Dispatch.of_GetReferenceLists ( lnva_ReferenceLists )

//	ddlb_ReferenceLists.SetRedraw ( FALSE )
//	ddlb_ReferenceLists.Reset ( )
//
//	FOR ll_Index = 1 TO ll_ListCount
//
//		//Reference Lists that came back from GetReferenceLists should be valid, but I'm 
//		//not going to rely on that here.
//
//		IF IsValid ( lnva_ReferenceLists [ ll_Index ] ) THEN
//			ddlb_ReferenceLists.AddItem ( lnva_ReferenceLists [ ll_Index ].of_GetLabel ( ) )
//		END IF
//
//	NEXT
//
//	//Select the last item in the listbox.  Note: This does not trigger selection changed
//	//on the listbox, and so will not refresh the reference list.  We'll need to call 
//	//ue_RefreshReferences below.
//	ddlb_ReferenceLists.SelectItem ( ll_ListCount )
//
//	ddlb_ReferenceLists.SetRedraw ( TRUE )

	//DO NOT destroy the elements in the existing instance array -- they aren't our property,
	//we're just getting an array of references to them.
	inva_ReferenceLists = lnva_ReferenceLists

	//As described above, calling ddlb_ReferenceLists.SelectItem above does not trigger 
	//selection changed on the listbox.  We need to call ue_RefreshReferences ourselves 
	//for the list index we selected.
	This.Event ue_RefreshReferences ( ll_ListCount )

END IF

RETURN li_Return
end event

event ue_refreshreferences;String	ls_AssignmentIndicator, &
			ls_MultiList, &
			lsa_List[]
Integer	li_ListCount, &
			li_Loop

n_cst_DispatchIds		lnv_DispatchIds

ListBox	lb_Target
lb_Target = lb_References


Boolean	lb_Finished = FALSE
Integer	li_Return = 1


IF lb_Finished = FALSE THEN

	IF al_ListIndex > 0 AND al_ListIndex <= UpperBound ( inva_ReferenceLists ) THEN
		//OK -- Get a handle to the reference list that was selected.
		lnv_DispatchIds = inva_ReferenceLists [ al_ListIndex ]
	ELSE
		li_Return = -1
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	IF IsValid ( lnv_DispatchIds ) THEN  //Should be

		SetNull ( ls_AssignmentIndicator )
		SetNull ( ls_MultiList )

		li_ListCount = lnv_DispatchIds.of_GetDisplayList ( ls_AssignmentIndicator, &
			ls_MultiList, lsa_List )

	END IF

END IF


//Regardless of what the outcome is, reset the list.  
//If we did get values, write them into the list.

lb_Target.SetRedraw ( FALSE )

lb_Target.Reset ( )

FOR li_Loop = 1 TO li_ListCount

	lb_Target.AddItem ( lsa_List [ li_Loop ] )

NEXT

lb_Target.SetRedraw ( TRUE )


IF li_Return = 1 THEN
	il_SelectedReferenceList = al_ListIndex
ELSE
	il_SelectedReferenceList = 0
END IF


RETURN li_Return
end event

event ue_routemode;//Display the insertion pointers on w_Itin, and tell it we're asking to route
//new events.

w_Itin	lw_Itinerary

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN

	This.Event ue_SetRouteModeIndicator ( TRUE )

	lw_Itinerary.show_ip()
	lw_Itinerary.whats_on = lw_Itinerary.ci_RouteRequest_NewEvent
	lw_Itinerary.tab_type.setfocus()

END IF

end event

event ue_removerequest;//Returns : 1, 0 = No Selection or user cancel, -1 = Error

w_Itin	lw_Itinerary
Integer	li_Result

Integer	li_Return = 1

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN

	li_Result = lw_Itinerary.Event ue_RemoveEvents ( )

	CHOOSE CASE li_Result

	CASE 1, 0, -1
		li_Return = li_Result

	CASE ELSE
		//Unexpected return
		li_Return = -1

	END CHOOSE 

END IF

RETURN li_Return
end event

event ue_rerouterequest;//Returns : 1, 0 = No Selection or user cancel, -1 = Error

w_Itin	lw_Itinerary
Integer	li_Result

Integer	li_Return = 1

lw_Itinerary = This.Event ue_GetItineraryWindow ( )

IF IsValid ( lw_Itinerary ) THEN

	li_Result = lw_Itinerary.Event ue_RerouteEvents ( )

	CHOOSE CASE li_Result

	CASE 1
		//Reroute mode was turned on.
		cb_Reroute.Visible = FALSE
		st_Reroute.Visible = TRUE
		li_Return = 1

	CASE 0, -1
		li_Return = li_Result

	CASE ELSE
		//Unexpected return
		li_Return = -1

	END CHOOSE 

END IF

RETURN li_Return
end event

event ue_createequipment;Long				ll_ShipID
Any				la_Value
Boolean			lb_CreateEquipment
String			ls_MessageHeader
Int				li_SelectionType
Long				ll_SelectionID

n_cst_Msg		lnv_Msg
S_Parm			lstr_Parm
s_Eq_Info		lstr_NewEquipment
s_Eq_Info		lstr_Equipment
n_cst_Settings	lnv_Settings

n_cst_EquipmentManager	lnv_EquipmentManager
//CHECK TO SEE IF WE HAVE A SHIPMENT ID

IF inv_Event.of_HasSource ( ) THEN
	ll_ShipID = inv_Event.of_GetShipment  ( )
	
	IF ll_ShipID > 0 THEN
		lstr_Parm.is_Label = "SHIPMENT"
		lstr_Parm.ia_Value = ll_ShipID 
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		lb_CreateEquipment = TRUE
	END IF
	
END IF

IF  ll_ShipID > 0 THEN
	
ELSE
	IF lnv_Settings.of_GetSetting ( 82 , la_Value ) = 1 THEN
		IF STRING ( la_Value ) = "YES!" THEN
			lb_CreateEquipment = TRUE
		END IF
	END IF
END IF

IF lb_CreateEquipment THEN
	IF MessageBox ( ls_MessageHeader, "The equipment you have specified does not exist.  "+&
		"Do you want to create new Leased Equipment with that number?", Question!, YesNo!, 1 ) = 1 THEN

		lstr_NewEquipment.eq_Type = "34"  //Allow entry of TrailerChassis or Container
		lstr_NewEquipment.eq_Ref = as_eqref
		
		//Indicate that we want to save the new equipment, not just pass the info out.
		lstr_NewEquipment.eq_Id = 0  //Null = Pass info out, don't save ;  0 = Save new equipment

		lstr_Parm.is_Label = "EQSTRUCT"
		lstr_Parm.ia_Value = lstr_NewEquipment 
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		OpenWithParm ( w_Eq_NewOut, lnv_Msg )
		lstr_NewEquipment = Message.PowerObjectParm

		IF lstr_NewEquipment.eq_Id > 0 THEN

			//A valid piece of equipment has been created.
			lstr_Equipment = lstr_NewEquipment
			li_SelectionType = lnv_EquipmentManager.of_GetItinType ( lstr_Equipment.eq_Type )
			ll_SelectionId = lstr_Equipment.eq_Id
			
			Event ue_Select ( li_SelectionType, ll_SelectionId )
		
		ELSE
			SetNull ( il_SelectionID )
			ii_SelectionType = 0
			//User Cancelled
			
		END IF

	ELSE
		SetNull ( il_SelectionID )
		ii_SelectionType = 0
	END IF
ELSE 
	MessageBox ( "Creation of Equipment", "The creation of equipment not linked to a shipment is not allowed. To create a piece of linked equipment, go to the shipment tab OR select a shipment event for the desired shipment." )					
END IF
end event

protected function integer of_getdescription (integer ai_type, long al_id, ref string as_description);//Returns : 1, -1  (If -1 condition occurs, we still pass out a description, 
//containing an N/A message.)

//Note : If you have equipment and don't know the type, it's ok to pass in 
//null for ai_Type -- we will process that as equipment.

n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_EquipmentManager	lnv_EquipmentManager
String	ls_Description

Integer	li_Return = 1

IF li_Return = 1 THEN

	CHOOSE CASE ai_Type
	
	CASE gc_Dispatch.ci_ItinType_Driver
	
		IF lnv_EmployeeManager.of_DescribeEmployee ( al_Id, ls_Description, &
			appeon_constant.ci_DescribeType_LastFirst ) = 1 THEN
		
			//Success
		
		ELSE
			ls_Description = "DRIVER: [N/A]"
			IF NOT IsNull ( al_Id ) THEN
				ls_Description += "  (ID=" + String ( al_Id ) + ")"
			END IF

			li_Return = -1
		
		END IF
	
	CASE ELSE
	
		IF lnv_EquipmentManager.of_Get_Description ( al_Id, &
			"SHORT_REF!", ls_Description ) = 1 THEN
	
			//Success
	
		ELSE
			ls_Description = "EQUIPMENT: [N/A]"
			IF NOT IsNull ( al_Id ) THEN
				ls_Description += "  (ID=" + String ( al_Id ) + ")"
			END IF

			li_Return = -1
	
		END IF
	
	END CHOOSE

END IF

//Even if we're returning -1, we'll still pass out the description we've assembled, since it
//contains an error description.
as_Description = ls_Description

RETURN li_Return
end function

public function integer of_setselection (string as_ref);sle_Selection.Text = as_Ref

//uo_equipment.of_SetDisplay ( as_Ref )
sle_Selection.Event Modified ( )


RETURN 1
end function

public function long of_selectdriver ();Date	ld_ItinDate
Long	ll_Return = -1
s_emp_info lstr_EmpInfo

IF isValid ( inv_Event ) THEN
	ld_ItinDate = inv_event.of_GetDatearrived( )

	lstr_EmpInfo.em_type = 2	// drivers
	lstr_EmpInfo.di_date = ld_ItinDate
	lstr_EmpInfo.em_status = "K"  // active
	
	openwithparm(w_emp_list, lstr_EmpInfo)
	
	lstr_EmpInfo = message.powerobjectparm
	if lstr_EmpInfo.em_id > 0 then
		ll_Return = lstr_EmpInfo.em_id
	end if
	
END IF
RETURN ll_Return
end function

on u_cst_eventrouting_assignments.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.tab_newevents=create tab_newevents
this.lb_assignmentlist=create lb_assignmentlist
this.sle_selection=create sle_selection
this.cb_process=create cb_process
this.cb_select=create cb_select
this.gb_5=create gb_5
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_eventtype=create st_eventtype
this.cb_unassignall=create cb_unassignall
this.lb_references=create lb_references
this.cb_clearreferences=create cb_clearreferences
this.cb_remove=create cb_remove
this.cb_reroute=create cb_reroute
this.st_reroute=create st_reroute
this.cb_refreshreferences=create cb_refreshreferences
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.tab_newevents
this.Control[iCurrent+3]=this.lb_assignmentlist
this.Control[iCurrent+4]=this.sle_selection
this.Control[iCurrent+5]=this.cb_process
this.Control[iCurrent+6]=this.cb_select
this.Control[iCurrent+7]=this.gb_5
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_eventtype
this.Control[iCurrent+11]=this.cb_unassignall
this.Control[iCurrent+12]=this.lb_references
this.Control[iCurrent+13]=this.cb_clearreferences
this.Control[iCurrent+14]=this.cb_remove
this.Control[iCurrent+15]=this.cb_reroute
this.Control[iCurrent+16]=this.st_reroute
this.Control[iCurrent+17]=this.cb_refreshreferences
this.Control[iCurrent+18]=this.dw_2
this.Control[iCurrent+19]=this.dw_1
this.Control[iCurrent+20]=this.cb_1
end on

on u_cst_eventrouting_assignments.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.tab_newevents)
destroy(this.lb_assignmentlist)
destroy(this.sle_selection)
destroy(this.cb_process)
destroy(this.cb_select)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_eventtype)
destroy(this.cb_unassignall)
destroy(this.lb_references)
destroy(this.cb_clearreferences)
destroy(this.cb_remove)
destroy(this.cb_reroute)
destroy(this.st_reroute)
destroy(this.cb_refreshreferences)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_1)
end on

event ue_itineraryrowchanged;This.Event ue_Refresh ( )
end event

event destructor;call super::destructor;DESTROY	inv_AssignmentList
DESTROY ( inv_Event )
//Unlike inv_AssignmentList, the objects in inva_ReferenceLists[] are NOT our property,
//so we do not need to destroy them -- we are just holding references to them, they 
//belong to the dispatch manager.  (Although we CAN destroy them, such as when the user
//requests to delete a particular list entry.)
end event

event ue_getroutingids;call super::ue_getroutingids;Return tab_newevents.Event ue_GetRoutingIds(ala_ids)
end event

event ue_setroutemodeindicator;tab_newevents.Event ue_SeTRouteModeIndicator(ab_Switch)
end event

event constructor;call super::constructor;SetNull ( il_SelectionID )
inv_Event = CREATE n_cst_beo_Event
ii_SelectionType = 0
end event

event ue_ipanswer;//Overriding Ancestor

Boolean	lb_Finished = FALSE


IF lb_Finished = FALSE THEN

	CHOOSE CASE ai_RequestType

	CASE appeon_constant.ci_RouteRequest_NewEvent

		SUPER::Event ue_IPAnswer ( ai_RequestType, ad_InsertionDate, al_InsertionEvent, &
			ai_InsertionStyle )

		lb_Finished = TRUE

	CASE appeon_constant.ci_RouteRequest_Reroute

		st_Reroute.Visible = FALSE
		cb_Reroute.Visible = TRUE
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	IF IsNull ( ai_InsertionStyle ) THEN
		//We're being told the insertion request was cleared

		IF ai_RequestType = appeon_constant.ci_RouteRequest_Assignment THEN

			IF This.of_DisplayItinerary ( ii_LaunchType, il_LaunchId, id_LaunchDate ) = 1 THEN

				//OK

			ELSE
		
				//May be redundant.  But, may be necessary if it didn't get triggered by the 
				//failed redisplay.
				This.Event ue_Refresh ( )

			END IF

		END IF

		lb_Finished = TRUE

	END IF

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE This.Event ue_Assign ( ii_SelectionType, il_SelectionId, &
		ad_InsertionDate, al_InsertionEvent, ai_InsertionStyle, TRUE /*IPMode*/ )

	CASE 1
		//OK

	CASE ELSE
		//Failed

	END CHOOSE

END IF
end event

type gb_3 from groupbox within u_cst_eventrouting_assignments
integer x = 782
integer y = 12
integer width = 1294
integer height = 180
integer taborder = 190
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 29409472
string text = "Change Routing"
end type

type tab_newevents from u_tab_newevents within u_cst_eventrouting_assignments
integer x = 50
integer y = 120
integer width = 2075
integer height = 688
integer taborder = 11
boolean perpendiculartext = false
tabposition tabposition = tabsontop!
end type

event ue_autoroute;call super::ue_autoroute;Return Parent.Event ue_AutoRoute()
end event

event ue_getdispatchmanager;call super::ue_getdispatchmanager;Return Parent.Event ue_GetDispatchManager()
end event

event ue_routemode;call super::ue_routemode;Parent.Event ue_RouteMode()
end event

type lb_assignmentlist from u_lb within u_cst_eventrouting_assignments
integer x = 2359
integer y = 408
integer width = 809
integer height = 340
integer taborder = 70
boolean bringtotop = true
boolean sorted = false
integer tabstop[] = {4}
end type

event doubleclicked;Boolean	lb_Finished


IF lb_Finished = FALSE THEN

	IF Index > 0 THEN
		//OK
	ELSE
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	Parent.Event ue_AddRemove ( )

END IF
end event

event selectionchanged;Integer	li_Type
Long		ll_Id
n_cst_DispatchIds	lnv_AssignmentList

Boolean	lb_Finished


IF lb_Finished = FALSE THEN

	IF Index > 0 AND NOT KeyDown ( KeyTab! ) THEN
		//OK
	ELSE
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	IF IsValid ( inv_AssignmentList ) THEN
		lnv_AssignmentList = inv_AssignmentList
	ELSE
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE lnv_AssignmentList.of_GetElement ( Index, li_Type, ll_Id )

	CASE 1
		//OK

	CASE ELSE
		//Error -- Should we notify user??
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE Parent.Event ue_Select ( li_Type, ll_Id )
	
	CASE 1
		//OK -- Selection set successfully.
	
	CASE ELSE
		//Error
		lb_Finished = TRUE
	
	END CHOOSE

END IF
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type sle_selection from u_sle within u_cst_eventrouting_assignments
event lbuttondown pbm_lbuttondown
event ue_key pbm_keydown
integer x = 2354
integer y = 92
integer width = 699
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean autohscroll = true
integer accelerator = 99
end type

event lbuttondown;This.SetFocus ( )
end event

event ue_key;Boolean lb_Employee


IF key = KeyDownArrow! THEN
	
	IF Inv_Event.of_HasSource ( ) THEN
		IF inv_event.of_GEtType ( ) = gc_dispatch.cs_EventType_NewTrip THEN
			lb_Employee = TRUE
		END IF
	END IF
			
	IF lb_Employee THEN
		IF dw_2.of_Retrieve  ( THIS.Text , inv_event.of_getdatearrived( ) ) <> -1 THEN
			dw_2.Visible = TRUE
			dw_2.SetFocus ( )
		ELSE 
			MessageBox ( "Employee selection" , "An error occurred while attempting to find matching employees." )
		END IF
		
	ELSE

		IF dw_1.of_Retrieve  ( THIS.Text ) <> -1 THEN
			dw_1.Visible = TRUE
			dw_1.SetFocus ( )
		ELSE 
			MessageBox ( "Equipment selection" , "An error occurred while attempting to find a matching piece of equipment." )
		END IF
	END IF
	
END IF

RETURN 0
end event

event modified;Integer		li_SelectionType
Long			ll_SelectionId
DataStore	lds_Equip

String		ls_Text, &
				ls_MessageHeader = "Equipment Selection", &
				ls_ErrorMessage = "Error processing selection request.  Request cancelled."

String		ls_Where
Boolean		lb_EnterPressed
Boolean		lb_DownArrow

n_cst_EquipmentManager	lnv_EquipmentManager


Integer	li_Return = 1   //For internal processing purposes.  Not actually being used as the return value.


lb_EnterPressed = KeyDown ( KeyEnter! )
lb_DownArrow = KeyDown ( keyDownArrow! )

IF lb_DownArrow THEN
	li_Return = 0 
END IF

IF li_Return = 1 THEN
	ls_Text = Trim ( This.Text )
	IF Len ( ls_Text ) > 0 THEN
		//OK
	ELSE
		li_Return = 0
	END IF
END IF


IF li_Return = 1 THEN
	
	ls_Where = "WHERE eq_status = ~~'K~~' AND eq_ref = ~~'" + ls_Text + "~~'"
	
	lnv_EquipmentManager.of_Retrieve ( lds_Equip, ls_Where )

	CHOOSE CASE lds_Equip.RowCount ( ) 

	CASE 1  //1 Match Found

		li_SelectionType = lnv_EquipmentManager.of_GetItinType ( lds_Equip.GetItemString ( 1 , "eq_type" )  )
		ll_SelectionId = lds_Equip.GetItemNumber ( 1 , "eq_id" ) 

		IF Parent.Event ue_Select ( li_SelectionType, ll_SelectionId ) = 1 THEN
			//OK -- Selection set successfully.  If Enter was pressed, Trigger add/remove processing.
			//Otherwise, the user may have tabbed or clicked a button, so we shouldn't call ue_AddRemove.
	
			IF lb_EnterPressed THEN
				Parent.Event ue_AddRemove ( )
			END IF
		ELSE
				//Failed -- provides its own error notification.
		END IF


	CASE 0  //No matches found
		
		
		PARENT.EVENT ue_CreateEquipment ( ls_Text )

	CASE IS > 1  //Multiple matches found. 		
		li_Return = 0
		IF dw_1.of_Retrieve ( TRIM ( sle_Selection.Text ) ) > 0 THEN
			MessageBox ( "Specified Equipment" , "There are multiple pieces of equipment with the specified reference number. Please select from the list." ,INFORMATION!)
			dw_1.SetFocus ( )
		ELSE
			MessageBox ( "Specified Equipment" , "There are multiple pieces of equipment with the specified reference number. Please use the selection list." ,INFORMATION!)			
		END IF
		
	CASE -1  //Error

		li_Return = -1
		ls_ErrorMessage += "~n(Could not get equipment info.)"

	END CHOOSE

END IF

IF li_Return = -1 THEN
	MessageBox ( ls_MessageHeader, ls_ErrorMessage )
END IF

DESTROY lds_Equip
end event

type cb_process from u_cb within u_cst_eventrouting_assignments
integer x = 3131
integer y = 76
integer width = 311
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Apply"
end type

event clicked;Parent.Event ue_AddRemove ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type cb_select from u_cb within u_cst_eventrouting_assignments
integer x = 3461
integer y = 76
integer width = 311
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Select..."
end type

event clicked;Integer	li_SelectionType, &
			li_Null
Int		li_SelectedItinType
Long		ll_SelectionId, &
			ll_Null
s_Anys	lstr_Open, &
			lstr_Selection
String	ls_SelectionCategory, &
			ls_Description, &
			ls_MessageHeader = "Add/Remove Selection"
Date		ld_Null

Boolean	lb_Finished


SetNull ( li_Null )
SetNull ( ll_Null )
SetNull ( ld_Null )
w_Itin	lw_Itin

lw_Itin = Parent.event ue_getitinerarywindow( )
IF IsValid ( lw_Itin ) THEN
	li_SelectedItinType = lw_Itin.event ue_getselecteditintype( )
END IF

IF lb_Finished = FALSE THEN
	
	IF inv_event.of_GEtType ( ) = gc_dispatch.cs_EventType_NewTrip AND li_SelectedItinType = gc_Dispatch.ci_ItinType_PowerUnit THEN
		li_SelectionType = gc_Dispatch.ci_ItinType_Driver 
		ll_SelectionId = Parent.of_Selectdriver( )
		IF IsNull ( ll_SelectionId ) OR ll_SelectionId <= 0 THEN
			lb_Finished = TRUE
		END IF
	
	ELSE		
		lstr_Open.Anys [1] = li_Null  //Itin_Type
		lstr_Open.Anys [2] = "ALL_SHIPS"  //Changed from "ROUTED_ONLY" in 3.0.02
		lstr_Open.Anys [3] = ld_Null  //itin_date
		lstr_Open.Anys [4] = ll_Null
		lstr_Open.Anys [5] = "PASS"
		//lstr_Open.Anys [6] = drids
		//lstr_Open.Anys [7] = eqids
		//lstr_Open.Anys [8] = w_disp.ds_emp
		//lstr_Open.Anys [9] = w_disp.ds_equip
		//lstr_Open.Anys [ 10 ] = lla_ShipmentIds
		
		OpenWithParm ( w_itin_select, lstr_Open ) 
		lstr_Selection = Message.PowerObjectParm
		
		ls_SelectionCategory = lstr_Selection.Anys [1]
		
		if ls_SelectionCategory = "ITIN" then
			li_SelectionType = lstr_Selection.Anys [2]
			ll_SelectionId = lstr_Selection.Anys [3]
			//new_date = lstr_Selection.Anys [4]
		elseif ls_SelectionCategory = "SHIP" then
			//	li_SelectedType = gc_Dispatch.ci_ItinType_Shipment
			//	new_id = lstr_Selection.Anys [2]
			lb_Finished = TRUE
		else  //User cancel, for example.
			lb_Finished = TRUE
		end if
	
	END IF

END IF

IF lb_Finished = FALSE THEN

	CHOOSE CASE Parent.Event ue_Select ( li_SelectionType, ll_SelectionId )

	CASE 1
		//OK -- Selection set successfully.  Trigger add/remove processing.
		Parent.Event ue_AddRemove ( )

	CASE ELSE
		lb_Finished = TRUE

	END CHOOSE

END IF
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type gb_5 from groupbox within u_cst_eventrouting_assignments
integer x = 3241
integer y = 228
integer width = 841
integer height = 548
integer taborder = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 29409472
string text = "Assignment Clipboard"
end type

type gb_2 from groupbox within u_cst_eventrouting_assignments
integer x = 2313
integer y = 228
integer width = 896
integer height = 548
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 29409472
string text = "Assignments for Selected Event"
end type

type gb_1 from groupbox within u_cst_eventrouting_assignments
integer x = 2313
integer y = 16
integer width = 1769
integer height = 180
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 29409472
string text = "&Change Assignment"
end type

type st_eventtype from statictext within u_cst_eventrouting_assignments
integer x = 2363
integer y = 308
integer width = 338
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 29409472
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_unassignall from u_cb within u_cst_eventrouting_assignments
integer x = 2734
integer y = 304
integer width = 430
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Unassign All"
end type

event clicked;Parent.Event ue_UnassignAll ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type lb_references from u_lb within u_cst_eventrouting_assignments
integer x = 3278
integer y = 408
integer width = 768
integer height = 340
integer taborder = 90
boolean bringtotop = true
boolean sorted = false
integer tabstop[] = {4}
end type

event doubleclicked;Integer	li_Type, &
			li_ListNumber
Long		ll_Id
n_cst_DispatchIds	lnv_AssignmentList

Boolean	lb_Finished


IF lb_Finished = FALSE THEN

	IF Index > 0 THEN
		//OK
	ELSE
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	li_ListNumber = il_SelectedReferenceList

	IF li_ListNumber > 0 AND li_ListNumber <= UpperBound ( inva_ReferenceLists ) THEN
		//OK
	ELSE
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	IF IsValid ( inva_ReferenceLists [ li_ListNumber ] ) THEN
		lnv_AssignmentList = inva_ReferenceLists [ li_ListNumber ]
	ELSE
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE lnv_AssignmentList.of_GetElement ( Index, li_Type, ll_Id )

	CASE 1
		//OK

	CASE ELSE
		//Error -- Should we notify user??
		lb_Finished = TRUE

	END CHOOSE

END IF


IF lb_Finished = FALSE THEN

	CHOOSE CASE Parent.Event ue_Select ( li_Type, ll_Id )
	
	CASE 1
		//OK -- Selection set successfully.  Trigger add/remove processing.
		Parent.Event ue_AddRemove ( )
	
	CASE ELSE
		//Error -- Should we notify user??
		lb_Finished = TRUE
	
	END CHOOSE

END IF
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type cb_clearreferences from u_cb within u_cst_eventrouting_assignments
integer x = 3570
integer y = 304
integer width = 261
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Clear"
end type

event clicked;String	ls_MessageHeader = "Clear Assignment Clipboard"
Long		ll_ListIndex

Boolean	lb_Finished = FALSE


IF lb_Finished = FALSE THEN

	ll_ListIndex = il_SelectedReferenceList

	IF ll_ListIndex > 0 AND ll_ListIndex <= UpperBound ( inva_ReferenceLists ) THEN
		//OK
	ELSE
		MessageBox ( ls_MessageHeader, "Could not clear the assignment clipboard."+&
			"~n(Could not resolve list reference.)" )
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	//Since the Dispatch object shrinks the array, it wouldn't be safe to just request this
	//by index.  We have to use our own array, which may or may not match the dispatch 
	//manager array.
	DESTROY inva_ReferenceLists [ ll_ListIndex ]

	Parent.Event ue_RefreshReferenceLists ( )

END IF
end event

type cb_remove from u_cb within u_cst_eventrouting_assignments
integer x = 837
integer y = 80
integer width = 334
integer height = 88
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Remove"
end type

event clicked;Parent.Event ue_RemoveRequest ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type cb_reroute from u_cb within u_cst_eventrouting_assignments
integer x = 1193
integer y = 80
integer width = 329
integer height = 88
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Reroute"
end type

event clicked;Parent.Event ue_RerouteRequest ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type st_reroute from statictext within u_cst_eventrouting_assignments
boolean visible = false
integer x = 1157
integer y = 92
integer width = 320
integer height = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
string text = "Reroute"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_refreshreferences from u_cb within u_cst_eventrouting_assignments
integer x = 3282
integer y = 304
integer width = 261
integer height = 88
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Refresh"
end type

event clicked;Parent.Event ue_RefreshReferenceLists ( )
end event

type dw_2 from u_dw_emp_list within u_cst_eventrouting_assignments
boolean visible = false
integer x = 2354
integer y = 164
integer width = 1399
integer height = 524
integer taborder = 20
boolean bringtotop = true
end type

event losefocus;THIS.Visible = FALSE
end event

event clicked;call super::clicked;
long	ll_Row
String	ls_Type
Long		ll_SelectionID
Int		li_SelectionType 


ll_Row = row

IF ll_Row > 0 THEN


	ll_SelectionID = THIS.getItemNumber ( ll_Row , "em_id" )
	
	THIS.Event ue_SelectionMade ( ll_SelectionID )
//	Parent.Event ue_Select ( 100, ll_SelectionId )
//
//	Parent.Event ue_AddRemove ( )
//	sle_Selection.SetFocus ( )
END IF

RETURN 0
end event

event ue_selectionmade;
long	ll_Row
String	ls_Type
Long		ll_SelectionID
Int		li_SelectionType 


ll_Row = THIS.Getrow ( )

IF ll_Row > 0 THEN


	ll_SelectionID = al_empid
	
	Parent.Event ue_Select ( gc_Dispatch.ci_ItinType_Driver, ll_SelectionId )

	Parent.Event ue_AddRemove ( )
	sle_Selection.SetFocus ( )
END IF

RETURN 0
end event

event ue_key;call super::ue_key;long		ll_Row
String	ls_Type
Long		ll_SelectionID
Int		li_SelectionType 

IF key = KeyEnter! THEN

	ll_Row = THIS.GetRow ( ) 
	
	IF ll_Row > 0 THEN
	
		
		ll_SelectionID = THIS.getItemNumber ( ll_Row , "em_id" )
		THIS.Event ue_SelectionMade ( ll_SelectionID )
//		Parent.Event ue_Select ( 100, ll_SelectionId )
//		Parent.Event ue_AddRemove ( )
	
	//	sle_Selection.SetFocus ( )
	END IF
ELSEIF KEY = KeyEscape! THEN
	IF ii_SelectionType > 0 AND il_SelectionId > 0 THEN
		Parent.Event ue_Select ( ii_SelectionType, il_SelectionId )
	END IF
	sle_Selection.SetFocus ( )
	
ELSEIF KEY = KeyUpArrow! THEN
	
	IF THIS.RowCount () = 0 THEN
		sle_Selection.SetFocus ( )
	END IF
	
END IF


RETURN 0
end event

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
THIS.of_SetRowSelect ( TRUE )
inv_RowSelect.of_SetStyle ( 0 )
THIS.SetFilter( "em_status <> 'D' AND not isnull(di_id)" )
THIS.Filter ( )
end event

type dw_1 from u_dw_eqlist within u_cst_eventrouting_assignments
boolean visible = false
integer x = 2354
integer y = 160
integer width = 1536
integer height = 352
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;n_cst_Presentation_equipmentSummary	lnv_Pres
lnv_Pres.of_SetPresentation ( THIS )
THIS.of_SetRowSelect ( TRUE )
inv_RowSelect.of_SetStyle ( 0 )

end event

event losefocus;THIS.Visible = FALSE

end event

event ue_selectionchanged;long	ll_Row
String	ls_Type
Long		ll_SelectionID
Int		li_SelectionType 

n_cst_EquipmentManager	lnv_EquipmentManager

ll_Row = al_row

IF ll_Row > 0 THEN

	ls_Type = THIS.GetItemString ( ll_Row , "equipment_type" )
	li_SelectionType = lnv_EquipmentManager.of_GetItinType ( ls_Type )
	ll_SelectionID = THIS.getItemNumber ( ll_Row , "eq_id" )
	
	Parent.Event ue_Select ( li_SelectionType, ll_SelectionId )

	Parent.Event ue_AddRemove ( )
	sle_Selection.SetFocus ( )
END IF

RETURN 0

end event

event ue_key;///// OVERRIDING ANCESTOR

long		ll_Row
String	ls_Type
Long		ll_SelectionID
Int		li_SelectionType 

n_cst_EquipmentManager	lnv_EquipmentManager
IF key = KeyEnter! THEN

	ll_Row = THIS.GetRow ( ) 
	
	IF ll_Row > 0 THEN
	
		THIS.Event ue_SelectionChanged ( ll_Row )
		
	END IF
ELSEIF KEY = KeyEscape! THEN
	IF ii_SelectionType > 0 AND il_SelectionId > 0 THEN
		Parent.Event ue_Select ( ii_SelectionType, il_SelectionId )
	END IF
	sle_Selection.SetFocus ( )
	
ELSEIF KEY = KeyUpArrow! THEN
	
	IF THIS.RowCount () = 0 THEN
		sle_Selection.SetFocus ( )
	END IF
	
END IF


RETURN 0
end event

type cb_1 from commandbutton within u_cst_eventrouting_assignments
integer x = 3790
integer y = 76
integer width = 247
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Details"
end type

event clicked;n_cst_Msg	lnv_msg
S_Parm		lstr_Parm
Long			ll_ShipID

IF il_SelectionId > 0 THEN
	CHOOSE CASE ii_SelectionType
			
		CASE gc_Dispatch.ci_itinType_powerUnit , gc_Dispatch.ci_itinType_TrailerChassis , gc_Dispatch.ci_itinType_Container
			opensheetwithparm(w_eq_info, il_SelectionId, gnv_app.of_GetFrame (), 0, original!)
			
		CASE gc_Dispatch.ci_itinType_Driver
			opensheetwithparm(w_emp_info, il_SelectionId, gnv_app.of_GetFrame (), 0, original!)
	END CHOOSE
	

END IF
end event

