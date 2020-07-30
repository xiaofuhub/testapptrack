$PBExportHeader$u_dw_eventdetail.sru
forward
global type u_dw_eventdetail from u_dw
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
////This value will be initialized to 0 or 1 on the first constructor script pass.
//Integer	si_ShowDispatchedField = -1
////end modification Shared Variables by appeon  20070730
end variables

global type u_dw_eventdetail from u_dw
integer width = 2789
integer height = 892
integer taborder = 10
string dataobject = "d_eventdetail"
boolean vscrollbar = false
borderstyle borderstyle = styleraised!
event processenter pbm_dwnprocessenter
event processkey pbm_dwnkey
event ue_setscrollcolumn ( readonly string as_scrollcolumn )
event ue_makepopup ( )
event ue_postdatetimeedit ( readonly long al_row,  readonly string as_colname,  string as_data )
event type integer ue_prechangesite ( long al_row,  long al_id )
event type integer ue_changesite ( long al_row,  long al_id )
event ue_postchangesite ( long al_row,  long al_old,  long al_new )
event type integer ue_addeventnote ( long al_row,  string as_movetype )
event type integer ue_cancelnotification ( pt_n_cst_beo anv_event )
event type integer ue_checknotifications ( pt_n_cst_beo anv_ptbeo )
event type string ue_getnotificationerror ( pt_n_cst_beo anv_ptbeo )
event type integer ue_rightclickondriver ( )
event type integer ue_rightclickonequipment ( dwobject dwo )
event type integer ue_rightclickonnotificationicon ( dwobject dwo )
event type integer ue_processinterchange ( long al_eventid )
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event type n_cst_beo_shipment ue_getshipment ( )
event type integer ue_firsthooksitechanged ( long al_site )
event type integer ue_firstmountsitechanged ( long al_site )
event type integer ue_lastdismountsitechanged ( long al_siteid )
event type integer ue_lastdropsitechanged ( long al_siteid )
event ue_refresh ( )
event type integer ue_rightclickonsite ( long al_row )
event ue_origindestchanged ( )
event type integer ue_addnotification ( pt_n_cst_beo anv_event )
event ue_setcolumn ( )
end type
global u_dw_eventdetail u_dw_eventdetail

type variables
Private DataWindow	idw_EventList
Private String		is_Context
Private n_cst_beo_Shipment	inv_Shipment

Private String		is_BackupContext
Private n_cst_beo_Shipment	inv_BackupShipment

Private:
Boolean	ib_SendNotification = TRUE
Boolean	ib_NotificationPending
Boolean 	ib_NotificationError = TRUE
Boolean	ib_SendNow
String	is_NotificationErrorString

PROTECTED:
String	is_SetColumn

//begin modification Shared Variables by appeon  20070730
//This value will be initialized to 0 or 1 on the first constructor script pass.
Integer	si_ShowDispatchedField = -1
//end modification Shared Variables by appeon  20070730


end variables

forward prototypes
public function integer of_seteventlist (readonly datawindow adw_eventlist)
public function datawindow of_geteventlist ()
public function integer of_setcontext (readonly string as_context)
public function string of_getcontext ()
public function integer of_setcontext (readonly string as_context, readonly n_cst_beo_shipment anv_shipment)
private function integer of_makecontextmodifications ()
public function integer of_clearcontext ()
protected function integer of_restorecontext ()
protected function integer of_clearbackupcontext ()
public function long of_getevents (ref n_cst_beo_event anva_events[])
public function long of_gettrips (ref long ala_ids[])
public function long of_getshipments (ref long ala_ids[])
public subroutine of_cachecompanies ()
public function integer of_initializenotification (n_cst_beo_event anv_event)
public function integer of_hidenotificationicon ()
public function integer of_showcontacts ()
private function integer of_setnotificationicon (dwobject adwo_icon)
public function integer of_eventconfirmed (n_cst_beo_event anv_event, n_cst_bso_dispatch anv_dispatch)
private function integer of_shownotificationerroricon ()
private function integer of_shownotificationsuccessicon ()
private function integer of_shownotificationpendingicon ()
public function integer of_eventunconfirmed (pt_n_cst_beo anv_Event)
protected function integer of_checknotifications (pt_n_cst_beo anv_event)
public function integer of_shownotificationerror ()
public function integer of_checknotifications ()
public function integer of_pickupadded (long al_row)
public function integer of_deliveradded (long al_row)
private function integer of_shownotificationnoneicon ()
private function integer of_shownotificationnoaddr ()
private function integer of_gettimecolumns (ref string asa_columns[])
protected function integer of_settimesenabeled (boolean ab_value)
public function integer of_defaultrestrictions ()
protected function integer of_clearrestrictions ()
public function n_cst_beo_Event of_getevent ()
end prototypes

event processenter;//Intercept enter key and send a tab key command
Send ( Handle ( This ), 256, 9, Long ( 0, 0 ) )

//Indicate that the enter key has been fully processed
//to prevent any additional handling of it.
RETURN 1
end event

event processkey;DataWindow	ldw_EventList

ldw_EventList = This.of_GetEventList ( )


//If this dw has been set to interact with a list dw, then perform interaction processing.

IF IsValid ( ldw_EventList ) THEN
	

	if keydown(keydownarrow!) or keydown(keypagedown!) or keydown(keyuparrow!) or &
		keydown(keypageup!) then
		ldw_EventList.SetRedraw ( FALSE)
		THIS.SetRedraw ( FALSE)
		ldw_EventList.SetColumn ( "de_note" )
		THIS.SetColumn ( "de_note" )
	
		if keydown(keydownarrow!) then
			if keydown(keycontrol!) then
				This.Event ue_SetScrollColumn ( "de_arrtime" )
			end if
			ldw_EventList.post scrollnextrow()
		elseif keydown(keyuparrow!) then
			if keydown(keycontrol!) then
				This.Event ue_SetScrollColumn ( "de_arrtime" )
			end if
			ldw_EventList.post scrollpriorrow()
		elseif keydown(keycontrol!) and keydown(keypagedown!) then
			ldw_EventList.post scrolltorow(ldw_EventList.rowcount())
		elseif keydown(keycontrol!) and keydown(keypageup!) then
			ldw_EventList.post scrolltorow(1)
		elseif keydown(keypagedown!) then
			ldw_EventList.post scrollnextpage()
		elseif keydown(keypageup!) then
			ldw_EventList.post scrollpriorpage()
		end if
		
		THIS.Post Event ue_SetColumn ( )
		ldw_EventList.Post TriggerEvent ( "ue_ScrollLeft" )
		ldw_EventList.Post SetRedraw ( TRUE )
		THIS.Post SetRedraw ( TRUE )
	
		return 1
	
	end if

END IF
end event

event ue_setscrollcolumn;//This event can be extended in the descendant to set the scroll column
//on the window to the value supplied.  This event is triggered internally
//by the processkey event.
end event

event ue_makepopup;This.Visible = FALSE
This.TitleBar = TRUE
This.Title = "Event Details"
This.ControlMenu = TRUE
This.BorderStyle = StyleBox!
This.Height += n_cst_Constants.ci_TitleBarHeight
This.Y -= n_cst_Constants.ci_TitleBarHeight
end event

event ue_postdatetimeedit;//This event is called by ItemChanged and ItemError after the user has
//edited a date or time value.  It may be extended in the descendant in
//order to implement further response to these changes.

Time	lt_Null

IF al_Row > 0 THEN

	IF IsNull ( This.Object.de_ArrDate [ al_Row ] ) THEN

		SetNull ( lt_Null )

		IF NOT IsNull ( This.Object.de_ArrTime [ al_Row ] ) THEN
			This.Object.de_ArrTime [ al_Row ] = lt_Null
		END IF

		IF NOT IsNull ( This.Object.de_DepTime [ al_Row ] ) THEN
			This.Object.de_DepTime [ al_Row ] = lt_Null
		END IF

	END IF

END IF
end event

event ue_prechangesite;//Placeholder event to allow PreChangeSite processing.

//Return Values : 1 = Change approved, proceed.  -1 = Change rejected, do not proceed.

//This event should not be called directly.  Only ue_ChangeSite should call this event.



RETURN 1
end event

event type integer ue_changesite(long al_row, long al_id);//Returns : 1 = Success, 0 = No Action, -1 = Rejected / Error (No change made.)
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
Long		ll_CurrentSite

Integer	li_Return = 1

lnv_Event = CREATE n_cst_beo_Event
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Dispatch = THIS.Event ue_GetDispatchManager ( ) 

lnv_Event.of_SetAllowFilterSet ( TRUE )

IF li_Return = 1 THEN

	ll_CurrentSite = This.Object.de_Site [ al_Row ]

	IF ( ll_CurrentSite = al_Id ) OR ( IsNull ( ll_CurrentSite ) AND IsNull ( al_Id ) ) THEN
		//The requested value is already assigned.  Return No Action.
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF This.Event ue_PreChangeSite ( al_Row, al_Id ) = 1 THEN
		//OK to proceed
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	//Change processing
	Long	ll_Origin
	Long	ll_Dest
	
	ll_Origin = lnv_Shipment.of_GetOrigin( )
	ll_Dest = lnv_Shipment.of_GetDestination ( ) 
	
	lnv_Event.of_SetSource ( lnv_Dispatch.of_geteventcache( ) )
	lnv_Event.of_SetSourceID ( THIS.GetItemNumber ( al_Row , "de_id" ) )
	lnv_Event.of_SetShipment ( lnv_Shipment ) 

	IF lnv_Event.of_SetSite ( al_Id ) = 1 THEN
		//OK
		IF ( lnv_Shipment.of_GetOrigin ( ) <> ll_Origin ) OR ( lnv_Shipment.of_GetDestination ( ) <> ll_Dest ) & 
				OR isNull ( ll_Origin ) OR IsNull (ll_Dest )	THEN
				
			THIS.Event ue_OriginDestChanged ( )
			
		END IF
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	This.Event ue_PostChangeSite ( al_Row, ll_CurrentSite, al_Id )

END IF

DESTROY ( lnv_Event ) 

RETURN li_Return
end event

event ue_postchangesite;Long ll_RowCount
n_cst_Events	lnv_Events
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

ll_RowCount = THIS.RowCount ( ) 

lnv_Event.of_SetSource ( THIS ) 
lnv_Event.of_setSourceRow ( al_Row ) 

CHOOSE CASE al_row
		
	CASE 1 

		IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Hook THEN
			THIS.Event ue_FirstHookSiteChanged ( al_new )
		END IF

		
		
	CASE 2
		IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Mount THEN
			THIS.Event ue_FirstMountSiteChanged ( al_new )
		END IF
		
	CASE ll_RowCount - 1
		
		IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Dismount THEN
			THIS.Event ue_LastDismountSiteChanged ( al_new )
		END IF
		
		
	CASE ll_RowCount 
		IF lnv_Event.of_GetType ( ) = gc_Dispatch.cs_EventType_Drop THEN
			THIS.Event ue_LastDropSiteChanged ( al_new )
		END IF
		
END CHOOSE

DESTROY lnv_Event




end event

event ue_addeventnote;w_eventNoteWizard 	lw_eventNoteWizard 
n_cst_EventNote	lnv_EventNote
String	ls_Note
String 	ls_Existing

OpenWithParm ( lw_eventNoteWizard , as_movetype )

lnv_EventNote = Message.PowerobjectParm
IF IsValid ( lnv_EventNote ) AND al_Row > 0 THEN  

	ls_Note = lnv_EventNote.of_GetNote ( )
	IF Len ( ls_Note ) > 0 THEN
		
		ls_Existing	= THIS.Object.de_Note[ al_row ]
		
		If IsNull ( ls_Existing ) OR Trim ( ls_Existing ) = "" THEN
			THIS.Object.de_Note[ al_row ] = ls_Note
		ELSE
			IF lnv_EventNote.of_Append ( ) THEN
					
				THIS.Object.de_Note[ al_row ] = ls_Existing + "~r~n"+ls_Note 
			
			ELSE
				
				THIS.object.de_Note[al_row] = ls_Note + "~r~n" + ls_Existing
				
			END IF
		END IF
		
	END IF
	
END IF

THIS.SetRedraw ( TRUE ) // force refresh

DESTROY lnv_eventNote

RETURN 1


end event

event ue_checknotifications;n_Cst_bso_dispatch	lnv_Disp

Int	li_Return = -2

lnv_Disp = THIS.Event ue_GetDispatchManager ( )

IF isValid ( lnv_Disp ) THEN
	li_Return = lnv_Disp.of_GetnotificationManager ( ).of_CheckNotificationStatus ( anv_ptbeo )
END IF

RETURN li_Return
end event

event type integer ue_rightclickondriver();Int		li_Return
Long		ll_ID
String	ls_PopRtn
String	lsa_Parm_Labels[]
Any		laa_Parm_Values[]
String	ls_Request 
n_cst_Msg	lnv_Msg
S_parm		lstr_Parm


ll_id = THIS.getitemnumber(THIS.GetRow (), "de_driver")
if ll_id > 0 then
	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "&Employee Info"
	
	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "Add &Alert"
	
	lsa_parm_labels[ 3 ] = "XPOS"
	laa_parm_values[ 3 ] = PointerX ( ) + THIS.x + 75
	
	lsa_parm_labels[ 4 ] = "YPOS"
	laa_parm_values[ 4 ] = PointerY ( ) + THIS.y + 350
	
	
end if

ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)

choose case ls_PopRtn		
	case "EMPLOYEE INFO"		
		ls_Request = "DETAILS!"
		li_Return = 1
	CASE "ADD ALERT"
		ls_Request = "ADDALERT!"
		li_Return = 1
END CHOOSE

IF li_Return = 1 THEN
		
	lstr_parm.is_label = "TOPIC"
	lstr_parm.ia_value = "EMPLOYEE!"
	lnv_Msg.of_add_parm(lstr_parm)
	
	lstr_parm.is_label = "REQUEST"
	lstr_parm.ia_value = ls_Request
	lnv_Msg.of_add_parm(lstr_parm)
	
	lstr_parm.is_label = "TARGET_ID"
	lstr_parm.ia_value = ll_id
	lnv_Msg.of_add_parm(lstr_parm)
	
	f_process_standard(lnv_Msg)
	
END IF
		


RETURN li_Return
end event

event type integer ue_rightclickonequipment(dwobject dwo);Int		li_Return
Int		li_Count
String	ls_Name
String	ls_Work
String	lsa_Parm_Labels[]

Any		laa_Parm_Values[]
Long		ll_ID
Long		ll_Row
S_Parm	lstr_Parm
n_cst_Msg	lnv_Msg
n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event


//Note : We only support "p_cntn01", not "p_cntn02" and "p_cntn03" because each of these is
//not really a specific container but a container "set" (one or two) at the corresponding
//chassis position.  So, we interpret "p_cntn01" as the first container (normally, the only
//container), and ignore the rest.  If the user wants info on those they can go up to the 
//itin tab, select the specific equipment, and get details there.


li_Count ++
lsa_parm_labels[ li_Count ] = "ADD_ITEM"
laa_parm_values[ li_Count ] = "&Equipment Details"

li_Count ++
lsa_parm_labels[ li_Count ] = "ADD_ITEM"
laa_parm_values[ li_Count ] = "Copy &Ref. #"

li_Count ++
lsa_parm_labels[ li_Count ] = "XPOS"
laa_parm_values[ li_Count ] = PointerX ( ) + THIS.x + 75

li_Count ++
lsa_parm_labels[ li_Count ] = "YPOS"
laa_parm_values[ li_Count ] = PointerY ( ) + THIS.y + 350
	

ls_Name = dwo.name
ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	
	
	CHOOSE CASE ls_Name
					
		case "p_trlr1", "p_trlr2", "p_trlr3"
			ll_id = THIS.getitemnumber(ll_Row, "de_trailer" + right(ls_Name, 1))
			
		case "p_cntn01"
			ll_id = THIS.getitemnumber(ll_Row, "de_container" + right(ls_Name, 1))
			
		case "p_trac", "p_st"
			ll_id = THIS.getitemnumber(ll_Row, "de_tractor")
			
	end choose
	
	
	IF NOT ( ls_Name = "p_trac" OR ls_Name = "p_st" ) THEN
	
		lnv_Event.of_SetSource ( THIS )
		lnv_Event.of_SetSourceRow ( ll_Row )
	
		IF lnv_Event.of_IsInterchangeCapable ( ) THEN
			li_Count ++
			lsa_parm_labels[ li_Count ] = "ADD_ITEM"
	
			IF lnv_Event.of_IsAssociation ( ) THEN
				laa_parm_values[ li_Count ] = "Set as Origination"
			ELSE
				laa_parm_values[ li_Count ] = "Set as Termination"
			END IF
	
		END IF
		
		
	
	END IF
	
	
	li_Count ++
	lsa_parm_labels[ li_Count ] = "ADD_ITEM"
	laa_parm_values[ li_Count ] = "Add &Alert"
	
	choose case f_pop_standard(lsa_parm_labels, laa_parm_values)
			
		case "EQUIPMENT DETAILS"
			li_Return = 1
//			ll_id = 0
			
//			CHOOSE CASE ls_Name
//					
//				case "p_trlr1", "p_trlr2", "p_trlr3"
//					ll_id = THIS.getitemnumber(ll_Row, "de_trailer" + right(ls_Name, 1))
//					
//				case "p_cntn01"
//					ll_id = THIS.getitemnumber(ll_Row, "de_container" + right(ls_Name, 1))
//					
//				case "p_trac", "p_st"
//					ll_id = THIS.getitemnumber(ll_Row, "de_tractor")
//					
//			end choose
			
			if ll_id > 0 then
				if ll_id > 10000000 then
					w_eq_info	lw_eq_info
					lstr_parm.is_label = "TOPIC"
					lstr_parm.ia_value = "EQUIPMENT!"
					lnv_Msg.of_add_parm(lstr_parm)
		
					lstr_parm.is_label = "REQUEST"
					lstr_parm.ia_value = "DETAILS!"
					lnv_Msg.of_add_parm(lstr_parm)
		
					lstr_parm.is_label = "TARGET_ID"
					lstr_parm.ia_value = ll_id
					lnv_Msg.of_add_parm(lstr_parm)
					///////MODIFIED BY DAN 2-2-07 to not call process standard, so I can pass in the shipment beo easily 
					lstr_parm.is_label = "SHIPMENT"
					lstr_parm.ia_value = this.event ue_getshipment( )
					lnv_Msg.of_add_parm(lstr_parm)
					
					lstr_parm.is_label = "ID"
					lstr_parm.ia_value = ll_id
					lnv_Msg.of_add_parm(lstr_parm)
		
					opensheetwithparm(lw_eq_info, lnv_msg, gnv_app.of_getFrame(), 0, original!)
					//f_process_standard(lnv_Msg)
					//////////////////////////////////////////////
				else
					messagebox("Equipment Details", "Cannot display details for this piece of "+&
						"equipment until you have saved your changes.")
				end if
			end if
		
		CASE "COPY REF. #"
			li_Return = 1
			//Note:  This section references the following columns with calculated names
			//REFERENCES: trlr1_ref, trlr2_ref, trlr3_ref, cntn1_ref, cntn2_ref, cntn3_ref, 
			//REFERENCES: cntn4_ref, trac_ref, acteq_ref
		
			CHOOSE CASE ls_Name
		
				CASE "p_trlr1", "p_trlr2", "p_trlr3"
					ls_Work = Right ( ls_Name, 5 )
			
				CASE "p_cntn01"
					ls_Work = "cntn1"
			
				CASE "p_trac", "p_st"
					ls_Work = "trac"
			
				CASE ELSE
					MessageBox ( "Copy Ref. #", "Could not process request.  Request cancelled.", Exclamation! )
					
		
			END CHOOSE
		
			ls_Work += "_ref"
		
			ClipBoard ( THIS.GetItemString ( ll_Row, ls_Work ) )
		
		
		CASE "SET AS ORIGINATION", "SET AS TERMINATION"
			li_Return = 1
			THIS.Event ue_ProcessInterchange ( lnv_Event.of_GetId ( ) )
	
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
	
END IF

DESTROY ( lnv_Event )

RETURN li_Return
end event

event ue_rightclickonnotificationicon;// RDT 5-13-03 added p_notificationnone
// RDT 7-01-03 added p_notificationNoAddr

String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]
Long		ll_Return = 1

n_cst_LicenseManager	lnv_LicenseManager


IF NOT  lnv_LicenseManager.of_HasNotificationLicense (  ) THEN
	RETURN 1
END IF

CHOOSE CASE dwo.name
		
	CASE  "p_notificationnoaddr"
		lsa_parm_labels [1] = "ADD_ITEM"
		laa_parm_values [1] = "Show &Error"	
		lsa_parm_labels [2] = "ADD_ITEM"
		laa_parm_values [2] = "&ReSend"	

	CASE  "p_notificationnone"
		lsa_parm_labels [1] = "ADD_ITEM"
		laa_parm_values [1] = "&Send"	
		
	CASE  "p_notificationactive"

		lsa_parm_labels [1] = "ADD_ITEM"
		laa_parm_values [1] = "&Cancel"	
		
	CASE "p_notificationsuccess"
		
		lsa_parm_labels [1] = "ADD_ITEM"
		laa_parm_values [1] = "&Cancel"	
				
		lsa_parm_labels [2] = "DISABLE"
		laa_parm_values [2] = "&Cancel"	
		
	CASE "p_notificationerror"
		
		lsa_parm_labels [1] = "ADD_ITEM"
		laa_parm_values [1] = "&Cancel"	
		
		lsa_parm_labels [2] = "ADD_ITEM"
		laa_parm_values [2] = "-"	
		
		lsa_parm_labels [3] = "DISABLE"
		laa_parm_values [3] = "&Cancel"	
		
		lsa_parm_labels [4] = "ADD_ITEM"
		laa_parm_values [4] = "Show &Error"	
		
END CHOOSE

lsa_parm_labels [ UpperBound (lsa_parm_labels) + 1  ] = "ADD_ITEM"
laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "Con&tacts"	


IF UpperBound ( lsa_parm_labels ) > 0 THEN

	
	ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)
	
	CHOOSE CASE ls_PopRtn

		// RDT 5-13-03 p_NotificationNone - Start 
		CASE "SEND","RESEND"
			pt_n_cst_beo	lnv_Eventadd
			lnv_Eventadd = CREATE n_cst_beo_Event
			lnv_Eventadd.of_SetSource ( THIS )
			lnv_Eventadd.of_SetSourceRow ( THIS.GetRow ( ))
			THIS.Event ue_AddNotification ( lnv_Eventadd  )	
			THIS.of_CheckNotifications ( lnv_Eventadd )
			DESTROY ( lnv_Eventadd ) 
			
		// RDT 5-13-03 p_NotificationNone - End
		
		CASE "CANCEL"
			
			pt_n_cst_beo	lnv_Event
			lnv_Event = CREATE n_cst_beo_Event
			lnv_Event.of_SetSource ( THIS )
			lnv_Event.of_SetSourceRow ( THIS.GetRow ( ))
			THIS.Event ue_CancelNotification ( lnv_Event  )	
			THIS.of_CheckNotifications ( lnv_Event )
			DESTROY ( lnv_Event ) 
			
		
		CASE "SHOW ERROR"
			
			THIS.of_ShowNotificationError ( ) 
			
		CASE "CONTACTS"
			
			THIS.of_ShowContacts ( )
			
			
	END CHOOSE
	
	ll_Return = 0 
		
END IF


RETURN ll_Return
end event

event type integer ue_rightclickonsite(long al_row);//RDT 8-21-03 
Any		laa_Parm_Values[]
String	lsa_Parm_Labels[]
String	ls_PopRtn 
Long	   ll_CompanyID
Boolean	lb_addDivider
Boolean	lb_Continue = TRUE
Boolean	lb_AllowEdit = TRUE
Long		ll_Dest
Long		ll_Orig

Long		ll_OldSiteID, &
			ll_NewSiteID , &
			ll_EventId, &
			lla_Contactid[]

n_cst_beo_Shipment	lnv_Shipment
n_Cst_AnyArraySrv lnv_ArraySrv					//RDT 8-21-03 
n_cst_beo_Event 	lnva_OLDEvent[] 				//RDT 8-21-03 
n_cst_beo_Event 	lnva_NEWEvent[] 				//RDT 8-21-03 

n_cst_beo_Event 	lnv_Event						//RDT 8-21-03 
lnv_Event = CREATE n_cst_beo_Event				//RDT 8-21-03 

ll_CompanyID = THIS.GetItemNumber ( al_Row , "de_site" )
lnv_Shipment = THIS.Event ue_GetShipment ( )

ll_EventId 	 = THIS.GetItemNumber ( al_Row , "de_id") //RDT 8-21-03

lnv_Event.of_SetSource ( This )					//RDT 8-21-03 
lnv_Event.of_SetSourceRow ( al_row )			//RDT 8-21-03 
lnv_Event.of_SetSourceID( ll_EventID)			//RDT 8-21-03 

IF IsValid ( lnv_Shipment ) Then 
	if ll_CompanyID <= 0 THEN
		lb_Continue = FALSE
	end if
ELSE
	lb_Continue = FALSE
END IF

IF lb_Continue THEN
	lb_AllowEdit = lnv_shipment.of_AllowEditbill  ( ) 
END IF

IF lb_Continue THEN
	ll_Dest = lnv_Shipment.of_GetDestination ( )	
	ll_Orig = lnv_Shipment.of_getOrigin ( )


	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "COMPANY"
	lsa_parm_labels[2] = "CO_ID"
	laa_parm_values[2] = ll_CompanyID
		
	// making change here to allow any type of event to be specified as either the origination
	// or termination site.
			
	//IF lb_AddDivider THEN		
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
		lb_AddDivider = FALSE
	//END IF
	
	IF ll_Orig = ll_CompanyID then
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "CHECK"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Origin"
	END IF
				
	
	lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Origin"
	
	if ll_Dest = ll_CompanyID then
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "CHECK"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Final Destination"
	end if
	
	IF lb_AddDivider THEN
		lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
		laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "-"
	END IF
	
	lsa_parm_labels[UpperBound ( lsa_Parm_Labels ) + 1] = "ADD_ITEM"
	laa_parm_values[UpperBound ( laa_parm_values ) + 1] = "List as Final Destination"
		

	ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)
	
	IF lb_AllowEdit THEN
		choose case ls_PopRtn
			case "LIST AS ORIGIN"
		
				lnv_Shipment.of_GetEventbyOriginDestination( lnva_OLDEvent[], "O"	)//RDT 8-21-03
				
				lnv_Shipment.of_SetOrigin ( ll_CompanyID )
				THIS.Event ue_OriginDestChanged ( )
				
				lnv_Shipment.of_GetEventbyOriginDestination( lnva_NEWEvent[], "O"	)//RDT 8-21-03
				lnv_Shipment.of_moveEventContacts(lnva_OLDEvent[], lnva_NEWEvent[], "O")//RDT 8-21-03				


			case "LIST AS FINAL DESTINATION"
				
				lnv_Shipment.of_GetEventbyOriginDestination( lnva_OLDEvent[], "D")//RDT 8-21-03
				
				lnv_Shipment.of_SetFinalDestination ( ll_CompanyID )							 
				THIS.Event ue_OriginDestChanged ( )
				
				lnv_Shipment.of_GetEventbyOriginDestination( lnva_NEWEvent[], "D")//RDT 8-21-03
				lnv_Shipment.of_moveEventContacts(lnva_OLDEvent[], lnva_NEWEvent[], "D")//RDT 8-21-03				


		end choose
	END IF
	
END IF

Destroy( lnv_Event)									//RDT 8-21-03
lnv_ArraySrv.of_Destroy ( lnva_OLDEvent[] ) 	//RDT 8-21-03
lnv_ArraySrv.of_destroy ( lnva_NEWEvent[] )	//RDT 8-21-03

RETURN 1
end event

event ue_setcolumn;Long	ll_Row


ll_Row = THIS.GetRow ( ) 
IF ll_Row > 0 THEN
		
	IF Len ( THIS.GetItemString ( ll_Row , "co_name" ) ) > 0  THEN
		THIS.SetColumn ( THIS.SetColumn ( "de_apptdate") )
	ELSE
		THIS.SetColumn ( "co_name")
	END IF

END IF


end event

public function integer of_seteventlist (readonly datawindow adw_eventlist);//Returns : 1, -1

idw_EventList = adw_EventList
RETURN 1
end function

public function datawindow of_geteventlist ();RETURN idw_EventList
end function

public function integer of_setcontext (readonly string as_context);//Returns :  1 = Success
//				-1 = Failure

Integer	li_Return = -1

CHOOSE CASE as_Context

CASE gc_Dispatch.cs_Context_Itinerary, gc_Dispatch.cs_Context_Trip

	//Types are ok for this version of the function.

	//Clear current context information, and make a backup in case of failure.
	This.of_ClearContext ( )

	//Set the new context values.
	is_Context = as_Context

	//Attempt to make the modifications for the new context.

	IF This.of_MakeContextModifications ( ) = 1 THEN
		//Changes succeeded.  Release the backup context info.
		This.of_ClearBackupContext ( )
		li_Return = 1
	ELSE
		//Change failed.  Restore old context values.
		This.of_RestoreContext ( )
	END IF

END CHOOSE

RETURN li_Return
end function

public function string of_getcontext ();RETURN is_Context
end function

public function integer of_setcontext (readonly string as_context, readonly n_cst_beo_shipment anv_shipment);//Returns :  1 = Success
//				-1 = Failure

Integer	li_Return = -1

CHOOSE CASE as_Context

CASE gc_Dispatch.cs_Context_DispatchShipment, gc_Dispatch.cs_Context_NonRoutedShipment

	//Types are ok for this version of the function.

	IF IsValid ( anv_Shipment ) THEN

//Messagebox (" IsValid (inv_BackupShipment)" , String ( IsValid (inv_BackupShipment) ))
//Messagebox (" IsValid (inv_Shipment)" , String ( IsValid (inv_Shipment) ))

		//Clear current context information, and make a backup in case of failure.
//		This.of_ClearContext ( )

//Messagebox (" IsValid (inv_BackupShipment)" , String ( IsValid (inv_BackupShipment) ))
//Messagebox (" IsValid (inv_Shipment)" , String ( IsValid (inv_Shipment) ))

		inv_Shipment = anv_Shipment
		is_Context = as_Context

//Messagebox (" IsValid (inv_BackupShipment)" , String ( IsValid (inv_BackupShipment) ))
//Messagebox (" IsValid (inv_Shipment)" , String ( IsValid (inv_Shipment) ))

		IF This.of_MakeContextModifications ( ) = 1 THEN
			//Changes succeeded.  Release the backup context info.
			This.of_ClearBackupContext ( )
			li_Return = 1
		ELSE
			//Change failed.  Restore old context values.
			This.of_RestoreContext ( )
		END IF

	END IF

END CHOOSE

THIS.of_Defaultrestrictions( )

RETURN li_Return
end function

private function integer of_makecontextmodifications ();//Responds to new context settings.

//Returns :  1 = Success
//				-1 = Failure

//Constant String	cs_Context_DispatchShipment = "T"
//Constant String	cs_Context_NonRoutedShipment = "D"
//Constant String	cs_Context_Itinerary = "I"
//Constant String	cs_Context_Trip = "3"



Constant String	ls_BackgroundByConf = "16777215~tif ( de_conf = 'T', 12648447, 16777215 )"
Constant String	ls_ProtectByConf = "0~tif ( de_conf = 'T', 1, 0 )"

Constant String	ls_BackgroundByConfOrArrdate = "16777215~tif ( de_conf = 'T', 12648447, if ( isnull ( de_arrdate ), 12632256, 16777215 ) )"
Constant String	ls_ProtectByConfOrArrdate = "0~tif ( de_conf = 'T' or isnull ( de_arrdate ), 1, 0 )"

Constant String	ls_BackgroundByConfOrShipment = "16777215~tif ( de_conf = 'T' or ( de_shipment_id > 0 and not isnull ( de_site ) ), 12648447, 16777215 )"
Constant String	ls_ProtectByConfOrShipment = "0~tif ( de_conf = 'T' or ( de_shipment_id > 0 and not isnull ( de_site ) ), 1, 0 )"

Constant String	ls_BackgroundByArrdate = "16777215~tif ( isnull ( de_arrdate ), 12632256, 12648447 )"

Constant String	ls_ItinOrTripConf = "0~tif ( de_conf = 'T' and de_shipment_id > 0, 1, 0 )"

Boolean	lb_Restricted		//This is flags whether the site is un-editable due to shipment status and priv setting  independent of context
String	ls_Context, &
			ls_Work
Boolean	lb_AllowTimeEdit
Boolean	lb_AllowConfirm
Boolean	lb_AlterItins
n_cst_setting_advancedprivs lnv_setting 

Long		ll_backColor_Protect = 12648447

Integer	li_Return = 1

lnv_setting = create n_cst_setting_advancedprivs
//n_Cst_privileges_Events lnv_Privs

//lb_AllowConfirm = lnv_Privs.of_Allowconfirmation( )
//lb_AllowTimeEdit = lnv_Privs.of_edittimes( )
ls_Context = This.of_GetContext ( )

//lb_Restricted = NOT ( lnv_Privs.of_allowalteritins( ) )
n_cst_privsmanager lnv_PrivsMgr

lnv_PrivsMgr = gnv_app.of_Getprivsmanager( )


n_cst_beo_Event	lnv_Event
lnv_Event = THIS.of_GetEvent( )


lb_AllowConfirm = lnv_PrivsMgr.of_getuserpermissionfromfn( "ConfirmEvents", lnv_Event ) = appeon_constant.ci_True
lb_AllowTimeEdit = lnv_PrivsMgr.of_getuserpermissionfromfn( "EditEventTimes", lnv_Event ) = appeon_constant.ci_True
lb_AlterItins = lnv_PrivsMgr.of_getuserpermissionfromfn( "AlterItinerary", lnv_Event ) = appeon_constant.ci_True
//lb_Restricted = NOT lb_AlterItins

//If we're in a shipment context, see if we're in restricted edit mode.

CHOOSE CASE ls_Context

CASE gc_Dispatch.cs_Context_DispatchShipment, gc_Dispatch.cs_Context_NonRoutedShipment

	IF IsValid ( inv_Shipment ) THEN

		//Changed 3.5.20 BKW   This was not allowing edit of site when shipment had been force-billed.
		//lb_Restricted = NOT inv_Shipment.of_AllowEditBill ( )

		IF inv_Shipment.of_AllowEdit ( ) = FALSE THEN
			lb_Restricted = TRUE
		ELSEIF inv_Shipment.of_AllowEditBill ( ) = TRUE THEN//AND lb_AlterItins THEN
			//Based on privileges, user can modify the bill for the current status.
			lb_Restricted = FALSE
		ELSEIF inv_Shipment.of_AllowRestrictActive ( ) = TRUE THEN //AND lb_AlterItins THEN
			//Force billing is enabled, adding/editing events is allowed, regardless of status.
			lb_Restricted = FALSE
		ELSE
			//None of the allowing conditions were met, so reject.
			lb_Restricted = TRUE
		END IF

		//End change 3.5.20 BKW
		
		
	ELSE
		li_Return = -1

	END IF

END CHOOSE




//If all ok so far, perform the context modifications.
//THIS.SetRedraw ( FALSE )
IF li_Return = 1 THEN

	CHOOSE CASE ls_Context
	
	CASE gc_Dispatch.cs_Context_NonRoutedShipment
	
		//de_ArrDate
		This.Object.de_ArrDate.Background.Color = ls_BackgroundByConf
		This.Object.de_ArrDate.Protect = ls_ProtectByConf
	
		//de_ArrTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_ArrTime.Background.Color = ls_BackgroundByConfOrArrdate
			This.Object.de_ArrTime.Protect = ls_ProtectByConfOrArrdate
		ELSE
			This.Object.de_ArrTime.Background.Color = ll_backColor_Protect
			This.Object.de_ArrTime.Protect = 1
		END IF
		
		//de_appttime
//		IF lb_AllowTimeEdit THEN
//			This.Object.de_appttime.Background.Color = ls_BackgroundByConfOrArrdate
//			This.Object.de_appttime.Protect = ls_ProtectByConfOrArrdate
//		ELSE
//			This.Object.de_appttime.Background.Color = ll_backColor_Protect
//			This.Object.de_appttime.Protect = 1
//		END IF
		IF NOT lb_AllowTimeEdit THEN
			This.Object.de_appttime.Background.Color = ll_backColor_Protect
			This.Object.de_appttime.Protect = 1
		END IF
		
		
		//de_DepTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_DepTime.Background.Color = ls_BackgroundByConfOrArrdate
			This.Object.de_DepTime.Protect = ls_ProtectByConfOrArrdate
		ELSE
			This.Object.de_DepTime.Background.Color = ll_backColor_Protect
			This.Object.de_DepTime.Protect = 1
		END IF
	
		//de_Conf
		IF lb_AllowConfirm THEN
			This.Object.de_Conf.Protect = 0
		ELSE
			This.Object.de_Conf.Protect = 1
		END IF
	
		//co_Name
		IF lb_Restricted THEN
			This.Object.co_Name.Background.Color = 12648447
			This.Object.co_Name.Protect = 1
		ELSE
			This.Object.co_Name.Background.Color = ls_BackgroundByConf
			This.Object.co_Name.Protect = ls_ProtectByConf
		END IF
	
		This.Object.comp_Loc_ArrDate.Background.Color = 12648447
		This.Object.comp_Loc_DepDate.Background.Color = 12648447
		This.Object.comp_Loc_Arrtime.Background.Color = 12648447
		This.Object.comp_Loc_DepTime.Background.Color = 12648447
	
	CASE gc_Dispatch.cs_Context_DispatchShipment
	
		//de_ArrDate

		//IF ( [IsThirdParty] THEN [BackGroundByConf] ELSE [BackGroundByArrdate] )
		ls_Work = "16777215~tIF ( NOT IsNull ( de_Trailer ), " +&
			Mid ( ls_BackGroundByConf, Pos ( ls_BackGroundByConf, "~t" ) + 1 ) + ", " +&
			Mid ( ls_BackGroundByArrdate, Pos ( ls_BackGroundByArrdate, "~t" ) + 1 ) + " )"
		This.Object.de_ArrDate.Background.Color = ls_Work

		//IF ( [IsThirdParty] THEN [ProtectByConf] ELSE 1 )
		ls_Work = "0~tIF ( NOT IsNull ( de_Trailer ), " +&
			Mid ( ls_ProtectByConf, Pos ( ls_ProtectByConf, "~t" ) + 1 ) + ", " +&
			"1" + " )"
		This.Object.de_ArrDate.Protect = ls_Work
	
		//de_ArrTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_ArrTime.Background.Color = ls_BackgroundByConfOrArrdate
			This.Object.de_ArrTime.Protect = ls_ProtectByConfOrArrdate
		ELSE
			This.Object.de_ArrTime.Background.Color = ll_backColor_Protect
			This.Object.de_ArrTime.Protect = 1
		END IF
		
		
		//de_AppTime
//		IF lb_AllowTimeEdit THEN
//			This.Object.de_appttime.Background.Color = ls_BackgroundByConfOrArrdate
//			This.Object.de_appttime.Protect = ls_ProtectByConfOrArrdate
//		ELSE
//			This.Object.de_appttime.Background.Color = ll_backColor_Protect
//			This.Object.de_appttime.Protect = 1
//		END IF
		IF NOT lb_AllowTimeEdit THEN
			This.Object.de_appttime.Background.Color = ll_backColor_Protect
			This.Object.de_appttime.Protect = 1
		END IF
		
		
		//de_DepTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_DepTime.Background.Color = ls_BackgroundByConfOrArrdate
			This.Object.de_DepTime.Protect = ls_ProtectByConfOrArrdate
		ELSE
			This.Object.de_DepTime.Background.Color = ll_backColor_Protect
			This.Object.de_DepTime.Protect = 1
		END IF
	
		//de_Conf
		//IF lb_AllowConfirm THEN
			This.Object.de_Conf.Protect = 0
		//ELSE
		//	This.Object.de_Conf.Protect = 1
		//END IF
		
	
		//co_Name
		IF lb_Restricted THEN
	//IF NOT inv_Shipment.of_AllowEditBill ( )  THEN
			This.Object.co_Name.Background.Color = 12648447
			This.Object.co_Name.Protect = 1
			
			THIS.object.de_Apptnum.Background.Color = 12648447
			THIS.object.de_Apptnum.Protect = 1
			
			THIS.object.disp_events_earliestdate.Background.Color = 12648447
			THIS.object.disp_events_earliestdate.Protect = 1
			THIS.object.disp_events_earliesttime.Background.Color = 12648447
			THIS.object.disp_events_earliesttime.Protect = 1
			THIS.object.disp_events_latestdate.Background.Color = 12648447
			THIS.object.disp_events_latestdate.Protect = 1
			THIS.object.disp_events_latesttime.Background.Color = 12648447
			THIS.object.disp_events_latesttime.Protect = 1
			
			THIS.object.de_duration.Background.Color = 12648447
			THIS.object.de_duration.Protect = 1
			
			THIS.object.de_apptdate.Background.Color = 12648447
			THIS.object.de_apptdate.Protect = 1
			
			THIS.object.de_Note.Background.Color = 12648447
			THIS.object.de_Note.Protect = 1
			
			THIS.object.de_status.Protect = 1
			//THIS.object.cb_notes.Enabled = 1
			THIS.Setcolumn( "disp_events_importreference" )
			THIS.object.disp_events_importreference.Protect = 1 
			
			
		ELSE
			This.Object.co_Name.Background.Color = ls_BackgroundByConf
			This.Object.co_Name.Protect = ls_ProtectByConf
			
			THIS.object.de_Apptnum.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.de_Apptnum.Protect = 0
			
			THIS.object.disp_events_earliestdate.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_earliestdate.Protect = 0
			THIS.object.disp_events_earliesttime.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_earliesttime.Protect = 0
			THIS.object.disp_events_latestdate.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_latestdate.Protect = 0
			THIS.object.disp_events_latesttime.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_latesttime.Protect = 0
			
			THIS.object.de_duration.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.de_duration.Protect = 0
			
			THIS.object.de_apptdate.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.de_apptdate.Protect = 0
			
			THIS.object.de_Note.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.de_Note.Protect = 0
			
			THIS.object.de_status.Protect = 0
			//THIS.object.cb_notes.Enabled = 0
			THIS.object.disp_events_importreference.Protect = 0

			
		END IF
	
		This.Object.comp_Loc_ArrDate.Background.Color = ls_BackgroundByArrdate
		This.Object.comp_Loc_DepDate.Background.Color = ls_BackgroundByArrdate
		IF lb_AllowTimeEdit THEN
			This.Object.comp_Loc_Arrtime.Background.Color = ls_BackgroundByArrdate
			This.Object.comp_Loc_DepTime.Background.Color = ls_BackgroundByArrdate
		ELSE
			This.Object.comp_Loc_Arrtime.Background.Color = ll_backColor_Protect
			This.Object.comp_Loc_DepTime.Background.Color = ll_backColor_Protect
		END IF
	
	CASE gc_Dispatch.cs_Context_Itinerary
	
		//Note: The following assume de_Arrdate is not null for event to be in itinerary

		//de_ArrDate
		This.Object.de_ArrDate.Background.Color = 12648447
		This.Object.de_ArrDate.Protect = 1
	
		//de_ArrTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_ArrTime.Background.Color = ls_BackgroundByConf
			This.Object.de_ArrTime.Protect = ls_ProtectByConf
		ELSE
			This.Object.de_ArrTime.Background.Color = ll_backColor_Protect
			This.Object.de_ArrTime.Protect = 1
		END IF
	
		//de_AppTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_appttime.Background.Color = ls_BackgroundByConf
			This.Object.de_appttime.Protect = ls_ProtectByConf
		ELSE
			This.Object.de_appttime.Background.Color = ll_backColor_Protect
			This.Object.de_appttime.Protect = 1
		END IF
//		IF NOT lb_AllowTimeEdit THEN	
//			This.Object.de_appttime.Background.Color = ll_backColor_Protect
//			This.Object.de_appttime.Protect = 1
//		END IF
		
		//de_DepTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_DepTime.Background.Color = ls_BackgroundByConf
			This.Object.de_DepTime.Protect = ls_ProtectByConf
		ELSE
			This.Object.de_DepTime.Background.Color = ll_backColor_Protect
			This.Object.de_DepTime.Protect = 1			
		END IF
		//de_Conf
		IF lb_AllowConfirm THEN
			This.Object.de_Conf.Protect = ls_ItinOrTripConf
		ELSE
			This.Object.de_Conf.Protect = 1
		END IF
	
		//co_Name
		//co_Name
	//	IF lb_Restricted THEN
	//Modified By dan 2-9-07 to use a different priv function if the shipment is billed.
	String	ls_privFunction
	n_cst_beo_shipment	lnv_shipment
	lnv_shipment = this.event ue_getshipment( )
	IF isValid( lnv_shipment ) THEN
		//DEK 4-19-07, my previous changes changed the functionality of the program
		//for users who were not using advanced privileges..this fixes issue 2950
		IF lnv_shipment.of_isBilled() AND lnv_setting.of_getValue() = "Yes" THEN
			ls_privFunction = appeon_constant.cs_ModifyBilledShip
		ELSE
			ls_privFunction = "ModifyShipment"
		END IF
	ELSE
		ls_privFunction = "ModifyShipment"
	END IF
	/////////////////////
	IF lnv_PrivsMgr.of_getuserpermissionfromfn( ls_privFunction, lnv_Event ) <> appeon_constant.ci_True THEN
			This.Object.co_Name.Background.Color = 12648447
			This.Object.co_Name.Protect = 1
			
			THIS.object.de_Apptnum.Background.Color = 12648447
			//THIS.object.de_Apptnum.Protect = 1
			
			THIS.object.disp_events_earliestdate.Background.Color = 12648447
			THIS.object.disp_events_earliestdate.Protect = 1
			THIS.object.disp_events_earliesttime.Background.Color = 12648447
			THIS.object.disp_events_earliesttime.Protect = 1
			THIS.object.disp_events_latestdate.Background.Color = 12648447
			THIS.object.disp_events_latestdate.Protect = 1
			THIS.object.disp_events_latesttime.Background.Color = 12648447
			THIS.object.disp_events_latesttime.Protect = 1
			
			THIS.object.de_duration.Background.Color = 12648447
			THIS.object.de_duration.Protect = 1
			
			THIS.object.de_apptdate.Background.Color = 12648447
			THIS.object.de_apptdate.Protect = 1
			
			THIS.object.de_Note.Background.Color = 12648447
			THIS.object.de_Note.Protect = 1
			
			THIS.object.de_status.Protect = 1
					
			THIS.object.disp_events_importreference.Protect = 1 
			
		
			
		ELSE
			This.Object.co_Name.Background.Color = ls_BackgroundByConfOrShipment
			This.Object.co_Name.Protect = ls_ProtectByConfOrShipment
			
			
			THIS.object.de_Apptnum.Background.Color = RGB ( 255, 255, 255 )
			//THIS.object.de_Apptnum.Protect = 0
			
			THIS.object.disp_events_earliestdate.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_earliestdate.Protect = 0
			THIS.object.disp_events_earliesttime.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_earliesttime.Protect = 0
			THIS.object.disp_events_latestdate.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_latestdate.Protect = 0
			THIS.object.disp_events_latesttime.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.disp_events_latesttime.Protect = 0
			
			THIS.object.de_duration.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.de_duration.Protect = 0
			
			THIS.object.de_apptdate.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.de_apptdate.Protect = 0
			
			THIS.object.de_Note.Background.Color = RGB ( 255, 255, 255 )
			THIS.object.de_Note.Protect = 0
	
			
			THIS.object.de_status.Protect = 0			
			THIS.object.disp_events_importreference.Protect = 0 
			
			
		END IF
	//	This.Object.co_Name.Background.Color = ls_BackgroundByConfOrShipment
	//	This.Object.co_Name.Protect = ls_ProtectByConfOrShipment
	
		This.Object.comp_Loc_ArrDate.Background.Color = 12648447
		This.Object.comp_Loc_DepDate.Background.Color = 12648447
		This.Object.comp_Loc_Arrtime.Background.Color = 12648447
		This.Object.comp_Loc_DepTime.Background.Color = 12648447

	CASE gc_Dispatch.cs_Context_Trip
	
		//de_ArrDate
		This.Object.de_ArrDate.Background.Color = ls_BackgroundByConf
		This.Object.de_ArrDate.Protect = ls_ProtectByConf
	
		//de_ArrTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_ArrTime.Background.Color = ls_BackgroundByConfOrArrdate
			This.Object.de_ArrTime.Protect = ls_ProtectByConfOrArrdate
		ELSE
			This.Object.de_ArrTime.Background.Color = ll_backColor_Protect
			This.Object.de_ArrTime.Protect = 1
		END IF
		
		//de_appttime
//		IF lb_AllowTimeEdit THEN
//			This.Object.de_appttime.Background.Color = ls_BackgroundByConfOrArrdate
//			This.Object.de_appttime.Protect = ls_ProtectByConfOrArrdate
//		ELSE
//			This.Object.de_appttime.Background.Color = ll_backColor_Protect
//			This.Object.de_appttime.Protect = 1
//		END IF
		IF NOT lb_AllowTimeEdit THEN			
			This.Object.de_appttime.Background.Color = ll_backColor_Protect
			This.Object.de_appttime.Protect = 1
		END IF
	
		//de_DepTime
		IF lb_AllowTimeEdit THEN
			This.Object.de_DepTime.Background.Color = ls_BackgroundByConfOrArrdate
			This.Object.de_DepTime.Protect = ls_ProtectByConfOrArrdate
		ELSE
			This.Object.de_DepTime.Background.Color = ll_backColor_Protect
			This.Object.de_DepTime.Protect = 1
		END IF
	
		//de_Conf
		IF lb_AllowConfirm THEN
			This.Object.de_Conf.Protect = ls_ItinOrTripConf
		ELSE
			This.Object.de_Conf.Protect = 1
		END IF
		
		
	
		//co_Name
		IF lb_Restricted THEN   //????If we implement trip restrictions
			This.Object.co_Name.Background.Color = 12648447
			This.Object.co_Name.Protect = 1
		ELSE
			This.Object.co_Name.Background.Color = ls_BackgroundByConfOrShipment
			This.Object.co_Name.Protect = ls_ProtectByConfOrShipment
		END IF
	
		This.Object.comp_Loc_ArrDate.Background.Color = 12648447
		This.Object.comp_Loc_DepDate.Background.Color = 12648447
		This.Object.comp_Loc_Arrtime.Background.Color = 12648447
		This.Object.comp_Loc_DepTime.Background.Color = 12648447
	
	CASE ELSE  //Unexpected Context Value
		li_Return = -1
	
	END CHOOSE

END IF

//THIS.SetRedraw ( TRUE )
//THIS.of_SetTimesenabeled( TRUE )
DESTROY ( lnv_Event )

destroy lnv_setting

RETURN li_Return
end function

public function integer of_clearcontext ();//Clears current context information (makes backup first)

//Returns :  1 = Success
//				-1 = Failure

n_cst_beo_Shipment	lnv_BlankShipment

//Backup the current context information
is_BackupContext = This.of_GetContext ( )
//DESTROY ( inv_BackupShipment )

inv_BackupShipment = inv_Shipment

//Clear the current context information
is_Context = ""

//inv_Shipment = lnv_BlankShipment
//DESTROY ( inv_Shipment )


RETURN 1
end function

protected function integer of_restorecontext ();//Restores context information that had been backed up previously

//Returns :  1 = Success
//				-1 = Failure

is_Context = is_BackupContext
inv_Shipment = inv_BackupShipment

RETURN 1
end function

protected function integer of_clearbackupcontext ();//Returns :  1 = Success
//				-1 = Failure

//n_cst_beo_Shipment	lnv_BlankShipment

//Clear the backup context information
is_BackupContext = ""

DESTROY ( inv_BackupShipment )
//inv_BackupShipment = lnv_BlankShipment

RETURN 1
end function

public function long of_getevents (ref n_cst_beo_event anva_events[]);Long	ll_RowCount, &
		ll_Row
n_cst_beo_Event	lnva_Events[]
n_Cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.event ue_getshipment( )

ll_RowCount = This.RowCount ( )

FOR ll_Row = 1 TO ll_RowCount
	
	lnva_Events [ ll_Row ] = CREATE n_cst_beo_Event
	lnva_Events [ ll_Row ].of_SetSource ( This )
	lnva_Events [ ll_Row ].of_SetSourceRow ( ll_Row )
	IF isValid ( lnv_Shipment ) THEN
		lnva_Events [ ll_Row ].of_SetShipment (  lnv_Shipment  )
	END IF

NEXT

anva_Events = lnva_Events

RETURN ll_RowCount
end function

public function long of_gettrips (ref long ala_ids[]);//Return a list of the Trip Ids, (if any), referenced in the event list.
//The array will contain unique values, even if they're referenced more
//than once.

//Returns:  >= 0 : The number of elements in the array.
//				  -1 : Error

n_cst_beo_Event	lnva_Events[]
Long	ll_EventCount, &
		ll_Index, &
		lla_Trips[]
n_cst_AnyArraySrv	lnv_AnyArray

ll_EventCount = This.of_GetEvents ( lnva_Events )

FOR ll_Index = 1 TO ll_EventCount

	lla_Trips [ ll_Index ] = lnva_Events [ ll_Index ].of_GetTrip ( )

NEXT

ll_EventCount = lnv_AnyArray.of_GetShrinked ( lla_Trips, "NULLS~tDUPES" )

ala_Ids = lla_Trips

RETURN ll_EventCount
end function

public function long of_getshipments (ref long ala_ids[]);//Return a list of the Shipment Ids, (if any), referenced in the event list.
//The array will contain unique values, even if they're referenced more
//than once.

//Returns:  >= 0 : The number of elements in the array.
//				  -1 : Error

n_cst_beo_Event	lnva_Events[]
Long	ll_EventCount, &
		ll_Index, &
		lla_Shipments[]
n_cst_AnyArraySrv	lnv_AnyArray

ll_EventCount = This.of_GetEvents ( lnva_Events )

FOR ll_Index = 1 TO ll_EventCount

	lla_Shipments [ ll_Index ] = lnva_Events [ ll_Index ].of_GetShipment ( )

NEXT

ll_EventCount = lnv_AnyArray.of_GetShrinked ( lla_Shipments, "NULLS~tDUPES" )

ala_Ids = lla_Shipments

RETURN ll_EventCount
end function

public subroutine of_cachecompanies ();SetPointer(HourGlass!)
long lla_ids []

IF this.RowCount ( ) > 0 THEN
	lla_ids = this.object.de_site.primary.current
	gnv_cst_companies.of_cache ( lla_ids , FALSE )
END IF

end subroutine

public function integer of_initializenotification (n_cst_beo_event anv_event);Int	li_Return = -1
//Int	i
//Time	lt_Start
//
//DataStore	lds_Source
//IF (anv_Event.of_isPickupGroup ( ) OR anv_Event.of_isDeliverGroup ( )) AND anv_Event.of_GetShipment ( ) > 0  THEN
//
//	pt_n_cst_beo	lnv_Shipment
//	lnv_Shipment = CREATE n_cst_beo_Shipment
//	
//	pt_n_cst_beo	lnv_Event
//	lnv_Event = anv_event
//	
//	n_cst_bso_notification_Manager	lnv_Note
//	lnv_Note = CREATE n_cst_bso_Notification_Manager
//	
//	n_cst_bso_Dispatch lnv_Disp
//	lnv_Disp = CREATE n_cst_bso_Dispatch
//
//	lnv_Disp.of_RetrieveShipment ( anv_Event.of_GetShipment ( ) )
//	
//	lnv_Shipment.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) ) 
//	lnv_Shipment.of_SetSourceID ( anv_Event.of_GetShipment ( ) )
//	IF lnv_Shipment.of_HasSource ( ) THEN
//		IF THIS.of_ShowPendingMessageIcon ( ) = 1 THEN
////			IF lnv_Note.of_ProcessNotificationRequest ( lnv_Event ) <> 1 THEN
////			
////				THIS.Object.p_notification.visible = 1
////				This.Object.p_notification.Filename = "c:\packred.bmp"
////				ib_NotificationError = TRUE
////				is_notificationerrorstring = "No addresses were available to send message to."
////
////	
////			END IF	
//		END IF
//	END IF
//
//	Destroy ( lnv_Disp )
//	DESTROY ( lnv_Note )
//	DESTROY ( lnv_Shipment )
//
//END IF
//
RETURN li_Return
end function

public function integer of_hidenotificationicon ();//THIS.Object.p_notification.visible = 0
THIS.object.p_NotificationNone.Visible = FALSE // RDT 5-13-03 added p_NotificationNone
THIS.object.p_NotificationSuccess.Visible = FALSE
THIS.object.p_NotificationActive.Visible = FALSE
THIS.object.p_NotificationError.Visible = FALSE
THIS.object.p_NotificationNoAddr.Visible = FALSE // RDT 7-1-03 added p_NotificationNoAddr

RETURN 1
end function

public function integer of_showcontacts ();// RDT 6-01-03 Added event ID to contacts
n_cst_msg	lnv_Msg
S_Parm		lstr_Parm

n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( ) 

IF IsValid ( lnv_Shipment ) And lnv_Shipment.of_HasSource ( ) THEN
	lstr_Parm.is_Label = "SHIPMENT" 
	lstr_Parm.ia_Value = lnv_Shipment
	lnv_Msg.of_add_Parm ( lstr_Parm ) 
	
	// RDT 6-01-03 -Start-
	lstr_Parm.is_Label = "EVENTID" 
	lstr_Parm.ia_Value = This.GetItemNumber( THIS.GetRow(), "de_id" )
	lnv_Msg.of_add_Parm ( lstr_Parm ) 
	// RDT 6-01-03 -End-
	
	OpenWithParm ( w_ShipmentNotification , lnv_Msg )


//	DESTROY ( lnv_Shipment ) we can't destroy this here because is could be the one on the ship win
END IF


RETURN 1


end function

private function integer of_setnotificationicon (dwobject adwo_icon);IF isValid ( adwo_icon ) THEN

	//MessageBox ("Icon" , String ( adwo_icon.FileName )  ) 
//	THIS.object.P_NotificationActive.FileName = adwo_Icon.FileName
	
END IF
RETURN 1
end function

public function integer of_eventconfirmed (n_cst_beo_event anv_event, n_cst_bso_dispatch anv_dispatch);// check for pending notes
n_cst_LicenseManager	lnv_Lic
IF lnv_Lic.of_HasNotificationLicense ( ) THEN	
	THIS.of_CheckNotifications (anv_event)
END IF
	

return 1
end function

private function integer of_shownotificationerroricon ();THIS.object.p_NotificationNoAddr.Visible = FALSE  // RDT 7-01-03 added p_NotificationNoAddr
THIS.object.p_NotificationNone.Visible = FALSE    // RDT 5-13-03 added p_NotificationNone
THIS.object.p_NotificationSuccess.Visible = FALSE
THIS.object.p_NotificationActive.Visible = FALSE
THIS.object.p_NotificationError.Visible = TRUE

RETURN 1
end function

private function integer of_shownotificationsuccessicon ();THIS.object.p_NotificationNoAddr.Visible = FALSE    // RDT 7-01-03 added p_NotificationNoAddr
THIS.object.p_NotificationNone.Visible = FALSE    // RDT 5-13-03 added p_NotificationNone
THIS.object.p_NotificationSuccess.Visible = TRUE
THIS.object.p_NotificationActive.Visible = FALSE
THIS.object.p_NotificationError.Visible = FALSE
RETURN 1
end function

private function integer of_shownotificationpendingicon ();THIS.object.p_NotificationNoAddr.Visible = FALSE    // RDT 7-01-03 added p_NotificationNoAddr
THIS.object.p_NotificationNone.Visible = FALSE    // RDT 5-13-03 added p_NotificationNone
THIS.object.p_NotificationSuccess.Visible = FALSE
THIS.object.p_NotificationActive.Visible = TRUE
THIS.object.p_NotificationError.Visible = FALSE
RETURN 1
end function

public function integer of_eventunconfirmed (pt_n_cst_beo anv_Event);// check for pending notes
n_cst_LicenseManager	lnv_Lic
IF lnv_Lic.of_HasNotificationLicense ( ) THEN	
	THIS.of_CheckNotifications (anv_event)
END IF
	

return 1
end function

protected function integer of_checknotifications (pt_n_cst_beo anv_event);// RDT 5-13-03 show "none" notification icon
// RDT 7-01-03 show "NoAddr" notification icon
n_cst_licenseManager	lnv_Lic
Int	li_Return 

li_Return = THIS.Event ue_CheckNotifications ( anv_Event )

IF lnv_Lic.of_HasNotificationLicense ( ) THEN
	CHOOSE CASE li_Return
			
		CASE 0
			THIS.of_ShowNotificationPendingIcon (  ) 
			
		CASE -1
			THIS.of_ShowNotificationErrorIcon (  ) 
			
		CASE -2
//			THIS.of_HideNotificationIcon ( )
			THIS.of_ShowNotificationNoneIcon ( ) 
			
		CASE -3
			THIS.of_ShowNotificationNoAddr( ) 

		CASE 1
			THIS.of_ShowNotificationSuccessIcon (  ) 
			
	END CHOOSE
END IF

RETURN 1


end function

public function integer of_shownotificationerror ();String	ls_Error

pt_n_cst_beo	lnv_Event
lnv_Event = CREATE n_cst_beo_Event
lnv_Event.of_SetSource ( THIS )
lnv_Event.of_SetSourceRow ( THIS.GetRow ( ))
ls_Error = THIS.Event ue_GetNotificationError ( lnv_Event )
DESTROY ( lnv_Event ) 

MessageBox ( "Notification Error" , ls_Error )

RETURN 1
end function

public function integer of_checknotifications ();pt_n_cst_beo	lnv_Event
Long	ll_Row

ll_Row = This.GetRow ( )

IF ll_Row > 0 THEN
	
	lnv_Event = CREATE n_cst_beo_Event
	lnv_Event.of_SetSource ( THIS )
	lnv_Event.of_SetSourceRow ( ll_Row )
	THIS.of_CheckNotifications ( lnv_Event )
	DESTROY ( lnv_Event ) 
	
END IF

RETURN 1
end function

public function integer of_pickupadded (long al_row);n_cst_beo_Shipment	lnv_Shipment
n_cst_Beo_Event		lnv_Event
n_cst_Bso_Dispatch	lnv_Disp
n_cst_Settings			lnv_Settings


lnv_Event = CREATE n_cst_beo_Event	
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Disp = THIS.Event ue_GetDispatchManager ( )

lnv_Event.of_SetSource ( THIS )
lnv_Event.of_SetSourceRow ( al_Row )

IF isValid ( lnv_Shipment ) THEN
	IF lnv_Settings.of_AddStopOffItem ( ) THEN
		lnv_Disp.of_FilterShipment ( lnv_Shipment.of_Getid( ) )
//		lnv_Shipment.of_SetItemsource( lnv_Disp.of_getitemcache( ) )
		IF NOT lnv_Shipment.of_Allowitemedit( ) THEN
			IF MessageBox ( "Add pickup stop off charge" , "The associated stop off charge will not be added since you do not have permissions to alter the shipment's items. Do you want to add the pickup event anyway?", Question!, YESNO!, 1 ) = 2 THEN
				lnv_Shipment.of_Removeevents( {lnv_Event.of_GetID ()} , lnv_Disp )
			END IF
		ELSE
			lnv_Shipment.of_AddStopOffItem ( lnv_Event , lnv_Disp )			
		END IF		
	END IF	
END IF

DESTROY ( lnv_Event )

RETURN 1
end function

public function integer of_deliveradded (long al_row);n_cst_beo_Shipment	lnv_Shipment
n_cst_Beo_Event		lnv_Event
n_cst_Bso_Dispatch	lnv_Disp
n_cst_Settings			lnv_Settings


lnv_Event = CREATE n_cst_beo_Event	
lnv_Shipment = THIS.Event ue_GetShipment ( )
lnv_Disp = THIS.Event ue_GetDispatchManager ( )

lnv_Event.of_SetSource ( THIS )
lnv_Event.of_SetSourceRow ( al_Row )

IF isValid ( lnv_Shipment ) THEN
	IF lnv_Settings.of_AddStopOffItem ( ) THEN
		
		IF NOT lnv_Shipment.of_Allowitemedit( ) THEN
			IF MessageBox ( "Add deliver stop off charge" , "The associated stop off charge will not be added since you do not have permissions to alter the shipment's items. Do you want to add the deliver event anyway?", Question!, YESNO!, 1 ) = 2 THEN
				lnv_Shipment.of_Removeevents( {lnv_Event.of_GetID ()} , lnv_Disp )
			END IF
		ELSE
			lnv_Shipment.of_AddStopOffItem ( lnv_Event , lnv_Disp )			
		END IF		
	END IF	
END IF

DESTROY ( lnv_Event )

RETURN 1
end function

private function integer of_shownotificationnoneicon ();THIS.object.p_NotificationNoAddr.Visible = FALSE   	// RDT 7-01-03 added p_NotificationNoAddr
THIS.object.p_NotificationNone.Visible = TRUE    		// RDT 5-13-03 added p_NotificationNone
THIS.object.p_NotificationSuccess.Visible = FALSE
THIS.object.p_NotificationActive.Visible = FALSE
THIS.object.p_NotificationError.Visible = FALSE
RETURN 1
end function

private function integer of_shownotificationnoaddr ();THIS.object.p_NotificationNoAddr.Visible = TRUE    // RDT 7-01-03 added p_NotificationNoAddr
THIS.object.p_NotificationNone.Visible = FALSE    	// RDT 5-13-03 added p_NotificationNone
THIS.object.p_NotificationSuccess.Visible = FALSE
THIS.object.p_NotificationActive.Visible = FALSE
THIS.object.p_NotificationError.Visible = FALSE
RETURN 1
end function

private function integer of_gettimecolumns (ref string asa_columns[]);String	lsa_Columns[]
Int	li_Return = -1
Int	li_Count

li_Count ++
lsa_Columns[li_Count] = "de_appttime"

li_Count ++
lsa_Columns[li_Count] = "de_arrtime"

li_Count ++
lsa_Columns[li_Count] = "de_deptime"


asa_columns = lsa_Columns

li_Return = UpperBound ( asa_columns )

RETURN li_Return

end function

protected function integer of_settimesenabeled (boolean ab_value);String	lsa_TimeColumns[]
Int		li_ColumnCount
Int		i
String	ls_ModString
Int		li_ProtectValue
Long		ll_Color

li_ColumnCount = THIS.of_GetTimeColumns( lsa_TimeColumns )


IF Ab_value THEN
	
	li_ProtectValue = 0
	ll_Color =  16777215 // white
	
ELSE	
	li_ProtectValue = 1
	ll_Color = 12648447 // yellowish
END IF

FOR i = 1 TO li_ColumnCount
	ls_ModString = lsa_TimeColumns[i] + ".Protect = " + String ( li_ProtectValue )
	THIS.Modify( ls_ModString )
	
	ls_ModString = lsa_TimeColumns[i] + ".Background.Color = " + String ( ll_Color )
	THIS.Modify( ls_ModString )
	
NEXT




RETURN -1


end function

public function integer of_defaultrestrictions ();//Long		ll_ColumnCount	
//Long		ll_i
//String	ls_ColumnName
//
//Int		li_ProtectValue
//Long		ll_Color
//String	ls_ModString
//
//n_cst_beo_Event	lnva_Event[]
//n_cst_beo_Event	lnv_Event
//
//THIS.SetRedraw( FALSE )
//IF THIS.of_Getevents( lnva_Event ) > 0 THEN
//	lnv_Event = lnva_Event[1]
//END IF
//
//
//n_cst_privsmanager	lnv_PrivManager
//lnv_PrivManager = gnv_app.of_Getprivsmanager( )
//
//IF lnv_PrivManager.of_getuserpermissionfromfn( "AlterItinerary", lnv_Event  ) = appeon_constant.ci_FALSE THEN
////AlterItins
//
////IF NOT lnv_Privs.of_allowalteritins( ) THEN
//	li_ProtectValue = 1
//	ll_Color = 12648447 // yellowish
//	
//	ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )
//	
//	FOR ll_i = 1 TO ll_ColumnCount
//		ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )
//		
//		IF ls_ColumnName = "de_note" THEN // we need a column unprotected so that the row focus can change
//			CONTINUE
//		END IF
//		
//		ls_ModString = ls_ColumnName + ".Protect = " + String ( li_ProtectValue )
//		THIS.Modify( ls_ModString )
//		
//		
//		CHOOSE CASE ls_ColumnName
//			CASE "disp_events_importreference" , "de_conf" ,"de_whoconf" , "driv_fn" , "driv_ln"
//				
//			CASE ELSE
//				
//				ls_ModString = ls_ColumnName + ".Background.Color = " + String ( ll_Color )
//				THIS.Modify( ls_ModString )
//		END CHOOSE
//					
//	NEXT
//ELSE
	THIS.of_Makecontextmodifications( )
//END IF
//
//THIS.SetRedraw( TRUE )
RETURN 1
end function

protected function integer of_clearrestrictions ();//Long		ll_ColumnCount	
//Long		ll_i
//String	ls_ColumnName
//
//Int		li_ProtectValue
//Long		ll_Color
//String	ls_ModString
//
//li_ProtectValue = 0
//ll_Color = RGB ( 255,255,255)// White
//
//ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )
//THIS.SetRedraw( FALSE )
//FOR ll_i = 1 TO ll_ColumnCount
//	ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )
//	
//	IF ls_ColumnName = "de_note" THEN // we need a column unprotected so that the row focus can change
//		CONTINUE
//	END IF
//	
//	ls_ModString = ls_ColumnName + ".Protect = " + String ( li_ProtectValue )
//	THIS.Modify( ls_ModString )
//	
//	
//	CHOOSE CASE ls_ColumnName
//		CASE "disp_events_importreference" , "de_conf" ,"de_whoconf" , "driv_fn" , "driv_ln"
//			
//		CASE ELSE
//			
//			ls_ModString = ls_ColumnName + ".Background.Color = " + String ( ll_Color )
//			THIS.Modify( ls_ModString )
//	END CHOOSE
//				
//NEXT
//	
//THIS.SetRedraw( TRUE )

RETURN 1
end function

public function n_cst_beo_Event of_getevent ();Long		ll_Row
n_cst_beo_Event	lnv_Event
n_Cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.event ue_getshipment( )

ll_Row = THIS.GetRow ( ) 

lnv_Event = CREATE n_cst_beo_Event
lnv_Event.of_SetSource ( This )
lnv_Event.of_SetSourceRow ( ll_Row )
IF isValid ( lnv_Shipment ) THEN
	lnv_Event.of_SetShipment (  lnv_Shipment  )
END IF

RETURN lnv_Event
end function

event constructor;n_cst_LicenseManager	lnv_LicenseManager
n_cst_Events	lnv_Events
Integer	li_BaseTimeZone, &
			li_ShowDispatchedField
String	ls_IniFile

li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )
This.Modify ( "comp_tz_home.Expression = '" + String ( li_BaseTimeZone ) + "'" )

This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )


//si_ShowDispatchedField is initially = -1.  We are attempting to determine a value of
//0 or 1.  1 means show the field, 0 means don't show it.  0 will be the default.

//This is pulled from the ini file.  Example:
//
//[DispatchedField]
//Show=1


IF si_ShowDispatchedField < 0 THEN

	//Value not initialized yet.  Try to initialize it.
	ls_IniFile = gnv_App.of_GetAppIniFile ( )
	li_ShowDispatchedField = ProfileInt ( ls_IniFile, "DispatchedField", "Show", 0 )

	CHOOSE CASE li_ShowDispatchedField

	CASE 1, 0
		//OK, use this value.

	CASE ELSE

		li_ShowDispatchedField = 0

	END CHOOSE

	si_ShowDispatchedField = li_ShowDispatchedField

ELSE

	li_ShowDispatchedField = si_ShowDispatchedField

END IF


//If we're supposed to show the field, do so.  If not, it's hidden in the dwo definition,
//so we don't have to change anything.

IF li_ShowDispatchedField = 1 THEN

	This.Modify ( "de_Status.Visible=1" )

END IF


ib_Rmbmenu = FALSE


end event

event itemerror;call super::itemerror;Boolean	lb_Processed
string errcol
errcol = dwo.name
n_cst_string lnv_string

date compdate
time comptime

choose case errcol

case "de_apptdate", "de_arrdate" /*, "de_depdate"*/,&
	"disp_events_earliestdate" , "disp_events_latestdate"

	//Attempt to convert the text typed to a date
	compdate = lnv_string.of_SpecialDate(data)

	if isnull(compdate) then
		//Value is really invalid

	ELSE
		this.setitem(row, errcol, compdate)
	
		//The following event may be extended in the descendant to provide special handling
		This.Event Post ue_PostDateTimeEdit ( Row, dwo.Name, string(compdate) )
	
		lb_Processed = TRUE

	END IF

case "de_appttime", "de_arrtime", "de_deptime" ,&
		"disp_events_earliesttime" ,"disp_events_latesttime"

	//Attempt to convert the text typed to a time
	comptime = lnv_string.of_SpecialTime(data)

	if isnull(comptime) then
		//Value is really invalid

	ELSE
		this.setitem(row, errcol, comptime)
	
		//The following event may be extended in the descendant to provide special handling
		This.Event Post ue_PostDateTimeEdit ( Row, dwo.Name, string(comptime) )
	
		lb_Processed = TRUE

	END IF

end choose


IF NOT lb_Processed THEN
	messagebox("Edit Value", "The value you have entered is invalid.  It will be "+&
		"replaced by the previous value.")
END IF

return 3
end event

event itemchanged;call super::itemchanged;Long	ll_Return = 0

CHOOSE CASE dwo.Name

CASE "de_apptdate", "de_arrdate", /*"de_depdate",*/ &
	"de_appttime", "de_arrtime", "de_deptime", "de_duration", &
	"disp_events_earliestdate" , "disp_events_earliesttime" , &
	"disp_events_latestdate", "disp_events_latesttime"

	This.Event Post ue_PostDateTimeEdit ( Row, dwo.Name, data )

CASE "co_name"

	s_co_Info	lstr_Company
	String	ls_OriginalValue
	ls_OriginalValue = this.object.co_name[row]
	if gnv_cst_companies.of_select(lstr_company, "ANY!", true, data, false, 0, false, true) = 1 then
		This.Event ue_ChangeSite ( Row, lstr_Company.co_Id )
	else
		this.object.co_name[row] = ls_OriginalValue
	//	this.settext(substitute(this.object.co_name[row], null_str, ""))
	end if

	//Reject the value that was typed, and keep the one that was set by processing above.
	ll_Return = 2

CASE "de_conf"
	n_cst_beo_Event	lnv_Event
	lnv_Event = THIS.of_GetEvent( )
	IF Data = 'T' THEN
		IF gnv_app.of_GetPrivsmanager( ).of_GetUserpermissionfromfn( "ConfirmEvents" ,lnv_Event ) <> appeon_constant.ci_true THEN
			MessageBox ( "Confirm Event" , "Your privileges do not allow you to make this change" )			
			ll_Return = 2
		END IF
	ELSE 
		IF gnv_app.of_GetPrivsmanager( ).of_GetUserpermissionfromfn( "UnconfirmEvents" ,lnv_Event ) <> appeon_constant.ci_true THEN
			MessageBox ( "Unconfirm Event" , "Your privileges do not allow you to make this change" )			
			ll_Return = 2
		END IF
	END IF
	DESTROY ( lnv_Event )
	
END CHOOSE

RETURN ll_Return
end event

event buttonclicked;IF dwo.Name = "cb_notes" THEN
	n_cst_beo_Event	lnv_Event
	
	lnv_Event = THIS.of_Getevent( )
	
	IF gnv_App.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "AlterItinerary", lnv_Event ) = appeon_constant.ci_True THEN
		THIS.Event ue_AddEventNote	( row , "" )
	END IF
	
END IF

RETURN 0

end event

event itemfocuschanged;call super::itemfocuschanged;IF Row > 0 THEN

	CHOOSE CASE dwo.Name

	CASE "de_note"
		This.SelectText ( 99999, 0 ) // this will make sure that nothing is selected

	END CHOOSE

END IF

RETURN 0
end event

event destructor;call super::destructor;DESTROY ( inv_Shipment )
DESTROY ( inv_backupshipment )

end event

event doubleclicked;String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]
Long		ll_Return = 1

n_cst_LicenseManager	lnv_LicenseManager
IF NOT  lnv_LicenseManager.of_HasNotificationLicense (  ) THEN
	RETURN 1
END IF

CHOOSE CASE dwo.name
		
	CASE "p_notificationerror"
		THIS.of_ShowNotificationError ( ) 
		ll_Return = 0
END CHOOSE


RETURN ll_Return


end event

event rbuttondown;call super::rbuttondown;//RDT  5-13-03 added p_notificationnone
//RDT  7-01-03 added p_notificationNoAddr
Long	ll_Return

ll_Return = AncestorReturnValue 

IF ll_Return = 0 THEN

	CHOOSE CASE dwo.name
		case "p_driv"
				
			THIS.Event ue_RightClickOnDriver ( )
			ll_Return = 1	
			
		case "p_trlr1", "p_trlr2", "p_trlr3", "p_cntn01", "p_trac", "p_st"
				
			THIS.Event ue_RightClickOnEquipment ( dwo ) 
			ll_Return = 1
			
			
		CASE "p_notificationactive" , "p_notificationsuccess" , "p_notificationerror" , &
			"p_notificationnone", "p_notificationnoaddr" 
			THIS.Event ue_RightClickOnNotificationIcon ( dwo )
			ll_Return = 1
			
		CASE "co_name"
			IF row > 0 THEN
				THIS.Event ue_RightClickonSite ( row )
			END IF
		
			
	END CHOOSE
END IF

RETURN ll_Return
	



end event

event rowfocuschanged;call super::rowfocuschanged;THIS.Post of_CheckNotifications ( )
// added for issue 2509
THIS.Post Event ue_SetColumn ( )

RETURN AncestorReturnValue

end event

on u_dw_eventdetail.create
call super::create
end on

on u_dw_eventdetail.destroy
call super::destroy
end on

