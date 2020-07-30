$PBExportHeader$w_inboundmessages.srw
forward
global type w_inboundmessages from w_sheet
end type
type dw_1 from u_dw within w_inboundmessages
end type
type cb_1 from commandbutton within w_inboundmessages
end type
type st_1 from statictext within w_inboundmessages
end type
type st_today from statictext within w_inboundmessages
end type
end forward

global type w_inboundmessages from w_sheet
integer x = 5
integer y = 96
integer width = 3653
integer height = 2032
string title = "Communication Inbound Message Log"
string menuname = "m_sheets"
event ue_delete ( )
dw_1 dw_1
cb_1 cb_1
st_1 st_1
st_today st_today
end type
global w_inboundmessages w_inboundmessages

type variables
String	is_Device
n_cst_Toolmenu_Manager  inv_ToolmenuManager
n_cst_bso_Communication_manager	inv_CommManager
n_cst_msg	inv_Msg

end variables

forward prototypes
private function integer wf_refresh ()
public function integer wf_createtoolmenu ()
public function integer wf_process_request (string as_request)
public function integer wf_displaydata (String as_FileName)
public function integer wf_getinboundpath (ref string as_path)
public function long wf_geteventid (long al_row)
end prototypes

event ue_delete;Long	ll_selectedRow

end event

private function integer wf_refresh ();//BLOB	lblb_State
//n_cst_bso_Communication_Manager	lnv_CommMgr
//n_cst_Msg	lnv_Msg
//S_Parm		lstr_Parm
//dataStore	lds_Message
//
//lnv_CommMgr = CREATE n_cst_bso_Communication_Manager
//
//IF Len ( Trim ( is_Device ) ) > 0 THEN
//	IF isValid ( gnv_app ) THEN
//		gnv_app.Event ue_Communication ( is_Device )
//	END IF
//END IF
//lstr_Parm.is_Label = "DEVICE" 
//lstr_Parm.ia_Value = is_Device
//lnv_Msg.of_Add_Parm ( lstr_Parm ) 
//
//lnv_CommMgr.of_MessageLog ( lnv_Msg )
//
//IF lnv_Msg.of_Get_Parm ( "DATASOURCE" , lstr_Parm ) <> 0 THEN
//	lds_message = lstr_Parm.ia_Value
//END IF
//
//IF isValid ( lds_Message ) THEN
//	lds_message.GetFullState(lblb_state)
//	dw_1.SetFullState ( lblb_state )
//	dw_1.ResetUpdate()
//ELSE
//	MessageBox ("Refresh Messages" , "An error occurred while attempting to refresh the messages.")
//END IF	
//
//DESTROY lnv_CommMgr
//
//
RETURN 1
end function

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu
n_cst_privileges	lnv_Privileges

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "DELETE!"
//lstr_toolmenu.s_menuitem_text = "&Delete Row(s)"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
lstr_toolmenu.s_name = "REFRESH!"
lstr_toolmenu.s_menuitem_text = "&Refresh"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)


//

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1

end function

public function integer wf_process_request (string as_request);SetPointer(HourGlass!)



CHOOSE CASE as_Request

	
CASE "DELETE!"
	PostEvent ( "ue_delete" )

	
CASE "REFRESH!"
	dw_1.postEvent ( "ue_refresh" )	

END CHOOSE



RETURN 1
end function

public function integer wf_displaydata (String as_FileName);return -1
end function

public function integer wf_getinboundpath (ref string as_path);String	ls_InboundPath
Int		li_Return = -1
String	ls_CommunicationObject

n_cst_bso_Communication_Manager	lnv_Manager


CHOOSE CASE UPPER (is_Device)
	
	CASE "QUALCOMM" , n_cst_constants.cs_CommunicationDevice_Qualcomm 
		ls_CommunicationObject = "n_cst_bso_Communication_QualComm"
		
			
	CASE "NEXTEL" , n_cst_constants.cs_CommunicationDevice_Nextel
		ls_CommunicationObject = "n_cst_bso_Communication_Nextel"

	CASE "INTOUCH", n_cst_constants.cs_CommunicationDevice_InTouch
		ls_CommunicationObject = "n_cst_bso_Communication_Intouch"
	
	CASE "ATROAD", n_cst_constants.cs_CommunicationDevice_AtRoad
		ls_CommunicationObject = "n_cst_bso_Communication_AtRoad"
		
	CASE "CADEC", n_cst_constants.cs_CommunicationDevice_Cadec
		ls_CommunicationObject = "n_cst_bso_Communication_Cadec"
		

END CHOOSE

IF len ( ls_CommunicationObject ) > 0 THEN
	
	lnv_Manager = CREATE USING ls_CommunicationObject
	
END IF


IF isValid ( lnv_Manager ) THEN

	IF lnv_Manager.of_GetInboundPath ( ls_InboundPath ) = 1 THEN
		li_Return = 1
	END IF
	
END IF

as_Path = ls_InboundPath

RETURN li_Return


end function

public function long wf_geteventid (long al_row);IF al_Row > 0 THEN
	RETURN dw_1.GetItemNumber ( al_Row , "message_eventid" ) 
END IF
end function

on w_inboundmessages.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.st_today=create st_today
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_today
end on

on w_inboundmessages.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_today)
end on

event open;call super::open;THIS.wf_CreateToolMenu ( )

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( dw_1, 'ScaleToright&Bottom' )
inv_Resize.of_Register ( cb_1, 'FixedToRight' )


gf_mask_menu(m_sheets)


end event

event close;call super::close;
Destroy inv_ToolmenuManager
end event

event pfc_postopen;

Blob 		lblb_State
s_parm	lstr_Parm
datastore lds_message

IF inv_Msg.of_Get_Parm ( "DATASOURCE" , lstr_Parm ) <> 0 THEN
	lds_message = lstr_Parm.ia_Value
END IF
IF inv_Msg.of_Get_Parm ( "DEVICE" , lstr_Parm ) <> 0 THEN
	is_Device = lstr_Parm.ia_Value
END IF

IF Len ( is_Device ) > 0 THEN
	THIS.Title = is_Device + " " + THIS.Title
END IF

IF isvalid (lds_message) THEN
	lds_message.GetFullState(lblb_state)
	dw_1.SetFullState ( lblb_state )
	dw_1.ResetUpdate()
	IF lds_Message.RowCount ( ) = 0 THEN
		IF MessageBox ( "Inbound Messages" , "The message log is empty. Would you like to check for new messages now?", QUESTION! , YESNO! , 2 ) = 1 THEN
			dw_1.Event ue_Refresh ( )
		ELSE	
			CLOSE ( THIS )
		END IF
	END IF
ELSE
	CLOSE(THIS)
END IF
end event

type dw_1 from u_dw within w_inboundmessages
event type integer ue_refresh ( )
event type integer ue_loaddriveritinerary ( long al_row )
event type integer ue_loadtractoritinerary ( long al_row )
integer x = 18
integer y = 196
integer width = 3575
integer height = 1672
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_communicationlog"
boolean hscrollbar = true
end type

event type integer ue_refresh();BLOB	   lblb_State
integer	li_return=1
string	ls_errormessage
n_cst_bso_Communication_Manager	lnv_CommMgr
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm
dataStore	lds_Message

Setpointer  ( HOURGLASS! )

lnv_CommMgr = CREATE n_cst_bso_Communication_Manager

IF Len ( Trim ( is_Device ) ) > 0 THEN
	
	IF isValid ( gnv_app ) THEN
		li_return = gnv_app.Event ue_Communication ( is_Device, ls_errormessage )
	END IF
	if li_return = -1 then
		messagebox("Process Inbound Messages",ls_errormessage)
	end if
	
END IF
if li_return <> -1 then
	lstr_Parm.is_Label = "DEVICE" 
	lstr_Parm.ia_Value = is_Device
	lnv_Msg.of_Add_Parm ( lstr_Parm ) 
	
	lnv_CommMgr.of_MessageLog ( lnv_Msg )
	
	IF lnv_Msg.of_Get_Parm ( "DATASOURCE" , lstr_Parm ) <> 0 THEN
		lds_message = lstr_Parm.ia_Value
	END IF
	
	IF isValid ( lds_Message ) THEN
		lds_message.GetFullState(lblb_state)
		dw_1.SetFullState ( lblb_state )
		dw_1.ResetUpdate()
		IF li_Return = 1 THEN // we are only going to show the message if this 
		// script did any importing. If the scheduler did the importing and this 
		// simply refreshed then we are not going to show a message
			MessageBox ("Inbound Messages" , "Process complete.")
		END IF
	ELSE
		MessageBox ("Refresh Messages" , "An error occurred while attempting to refresh the messages.")
	END IF	
end if

DESTROY lnv_CommMgr

return li_return


end event

event type integer ue_loaddriveritinerary(long al_row);Integer					li_Return = 1
Long						ll_SourceEntityId
Long						ll_DriverId
Long						ll_EventId
Long						ll_EventDriver
Long						lla_Driver[]
Long						lla_PowerUnit[]
Date						ld_DateArrived
Date						ld_OpenDate
String					ls_Msg
String					ls_SourceEntityType
w_dispatch 				lw_dispwindow
n_ds						lds_EventCache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event
n_cst_Msg				lnv_Msg
S_Parm					lstr_Parm


lnv_Event = CREATE n_cst_beo_Event
lnv_Dispatch = CREATE n_cst_bso_dispatch

ld_OpenDate = Today()

ls_Msg = "The itinerary could not be loaded."

ll_EventID = PARENT.wf_GetEventID ( al_row )

IF ll_EventID > 0 THEN
	lnv_Dispatch.of_RetrieveEvents ( {ll_EventID} )
	
	lds_EventCache = lnv_Dispatch.of_GetEventCache ( )
	
	lnv_Event.of_SetSource	( lds_EventCache )
	lnv_Event.of_SetSourceId ( ll_EventID )
	
	lnv_Event.of_GetAssignments ( lla_Driver , lla_PowerUnit )
	
	IF UpperBound(lla_Driver) > 0 THEN
		ll_EventDriver = lla_Driver[1]
	END IF
	
	ld_DateArrived = lnv_Event.of_getDateArrived ( )
END IF


ll_SourceEntityId = This.GetItemNumber(al_Row, "message_sourceentityid")
ls_SourceEntityType = This.GetItemString(al_Row, "message_sourceentitytype")

IF ll_SourceEntityId > 0 THEN //we are going off the source id
	
	IF ls_SourceEntityType = appeon_constant.cs_Employee THEN
		ll_DriverId = ll_SourceEntityId
		
		IF ll_SourceEntityId = ll_EventDriver THEN
			ld_OpenDate = ld_DateArrived
		END IF
	ELSE
		ls_Msg = "The itinerary could not be loaded because the driver ID could not be determined."
		li_Return = -1
	END IF
	
ELSE //We are going off the event
	IF ll_EventId > 0 THEN
		IF ll_EventDriver > 0 THEN
			ll_DriverId = ll_EventDriver
			ld_OpenDate = ld_DateArrived
		ELSE
			ls_Msg = "The itinerary could not be loaded because the driver ID could not be determined."
			li_Return = -1
		END IF
	ELSE
		ls_Msg = "The itinerary could not be loaded because the event ID could not be determined."
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	lstr_Parm.is_Label = "CATEGORY"
	lstr_Parm.ia_Value = "ITIN"
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "TYPE"
	lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Driver
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "ID"
	lstr_Parm.ia_Value = ll_DriverId
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "DATE"
	lstr_Parm.ia_Value = ld_OpenDate
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	opensheetwithparm(lw_dispwindow, lnv_msg, gnv_app.of_GetFrame ( ), 0, original!)
END IF

IF li_Return <> 1 THEN
	MessageBox ( "Goto Driver Itinerary" , ls_Msg )
END IF

Destroy ( lnv_Dispatch )
Destroy ( lnv_Event )

Return li_Return

end event

event type integer ue_loadtractoritinerary(long al_row);Integer					li_Return = 1
Long						ll_SourceEntityId
Long						ll_TractorId
Long						ll_EventId
Long						ll_EventTractor
Long						lla_Driver[]
Long						lla_PowerUnit[]
Date						ld_DateArrived
Date						ld_OpenDate
String					ls_Msg
String					ls_SourceEntityType
w_dispatch 				lw_dispwindow
n_ds						lds_EventCache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event
n_cst_Msg				lnv_Msg
S_Parm					lstr_Parm


lnv_Event = CREATE n_cst_beo_Event
lnv_Dispatch = CREATE n_cst_bso_dispatch

ld_OpenDate = Today()

ls_Msg = "The itinerary could not be loaded."

ll_EventID = PARENT.wf_GetEventID ( al_row )

IF ll_EventID > 0 THEN
	lnv_Dispatch.of_RetrieveEvents ( {ll_EventID} )
	
	lds_EventCache = lnv_Dispatch.of_GetEventCache ( )
	
	lnv_Event.of_SetSource	( lds_EventCache )
	lnv_Event.of_SetSourceId ( ll_EventID )
	
	lnv_Event.of_GetAssignments ( lla_Driver , lla_PowerUnit )
	
	IF UpperBound(lla_Driver) > 0 THEN
		ll_EventTractor = lla_PowerUnit[1]
	END IF
	
	ld_DateArrived = lnv_Event.of_getDateArrived ( )
END IF


ll_SourceEntityId = This.GetItemNumber(al_Row, "message_sourceentityid")
ls_SourceEntityType = This.GetItemString(al_Row, "message_sourceentitytype")
	
IF ll_SourceEntityId > 0 THEN //we are going off the source id
	IF ls_SourceEntityType = appeon_constant.cs_Equipment THEN
		ll_TractorId = ll_SourceEntityId
		
		IF ll_SourceEntityId = ll_EventTractor THEN
			ld_OpenDate = ld_DateArrived
		END IF
	ELSE
		ls_Msg = "The itinerary could not be loaded because the tractor ID could not be determined."
		li_Return = -1
	END IF
	
ELSE //We are going off the event
	IF ll_EventId > 0 THEN
		IF ll_EventTractor > 0 THEN
			ll_TractorId = ll_EventTractor
			ld_OpenDate = ld_DateArrived
		ELSE
			ls_Msg = "The itinerary could not be loaded because the driver ID could not be determined."
			li_Return = -1
		END IF
	ELSE
		ls_Msg = "The itinerary could not be loaded because the event ID could not be determined."
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	lstr_Parm.is_Label = "CATEGORY"
	lstr_Parm.ia_Value = "ITIN"
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "TYPE"
	lstr_Parm.ia_Value = gc_Dispatch.ci_itinType_PowerUnit
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "ID"
	lstr_Parm.ia_Value = ll_TractorId
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "DATE"
	lstr_Parm.ia_Value = ld_OpenDate
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	opensheetwithparm(lw_dispwindow, lnv_msg, gnv_app.of_GetFrame ( ), 0, original!)
END IF

IF li_Return <> 1 THEN
	MessageBox ( "Goto Tractor Itinerary" , ls_Msg )
END IF

Destroy ( lnv_Dispatch )
Destroy ( lnv_Event )

Return li_Return
end event

event constructor;inv_msg = Message.PowerObjectParm
//THIS.of_SetRowSelect ( TRUE ) 
//inv_rowselect.of_SetStyle (2) //2 = extended row select service

This.Event ue_SetFocusIndicator ( TRUE )

of_setinsertable ( FALSE )
of_setDeleteable ( TRUE )

of_SetAutoFilter ( TRUE )
of_SetAutoSort ( TRUE )

//ib_disableclosequery = TRUE





end event

event doubleclicked;IF row > 0 THEN
	IF this.object.message_shipmentid[row] > 0 THEN
		
		n_cst_ShipmentManager	lnv_ShipmentMgr
		lnv_ShipmentMgr.of_OpenShipment ( this.object.message_shipmentid[row] )
		
	END IF
END IF
end event

event rbuttondown;call super::rbuttondown;any 		laa_parm_values[]
String 	lsa_parm_labels[]

IF Row > 0 THEN
	THIS.SetRow ( ROW )
	
	
	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "Goto &Driver Itinerary"
		
	lsa_parm_labels[2] = "ADD_ITEM"
	laa_parm_values[2] = "Goto &Tractor Itinerary"
		
	IF UpperBound( laa_parm_values ) > 0 THEN
		This.SelectRow(row, true)
		CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
				
			CASE "GOTO DRIVER ITINERARY"
				THIS.Event ue_LoadDriverItinerary ( Row )
				
			CASE "GOTO TRACTOR ITINERARY"
				THIS.Event ue_LoadTractorItinerary ( ROW )
		END CHOOSE
		This.SelectRow(row, false)
	END IF
END IF


end event

type cb_1 from commandbutton within w_inboundmessages
integer x = 3296
integer y = 72
integer width = 297
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Refresh"
end type

event clicked;dw_1.Event ue_Refresh ( )
end event

type st_1 from statictext within w_inboundmessages
integer x = 18
integer y = 88
integer width = 832
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Inbound messages received "
boolean focusrectangle = false
end type

type st_today from statictext within w_inboundmessages
integer x = 864
integer y = 88
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "today"
boolean focusrectangle = false
end type

event constructor;THIS.Text = String ( Today ( ) , "mm/dd/yyyy" )
end event

