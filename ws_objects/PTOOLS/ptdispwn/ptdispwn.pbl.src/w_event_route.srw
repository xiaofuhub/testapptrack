$PBExportHeader$w_event_route.srw
forward
global type w_event_route from w_response
end type
type dw_1 from u_dw within w_event_route
end type
type cb_ok from u_cb within w_event_route
end type
type cb_cancel from u_cb within w_event_route
end type
type st_routetype from u_st within w_event_route
end type
type ddlb_routetype from u_ddlb within w_event_route
end type
type cb_all from u_cb within w_event_route
end type
type st_2 from u_st within w_event_route
end type
type uo_noteicon from u_cst_noteicon within w_event_route
end type
end forward

global type w_event_route from w_response
integer x = 27
integer y = 32
integer width = 2304
integer height = 1272
string title = "Event Selection "
long backcolor = 12632256
dw_1 dw_1
cb_ok cb_ok
cb_cancel cb_cancel
st_routetype st_routetype
ddlb_routetype ddlb_routetype
cb_all cb_all
st_2 st_2
uo_noteicon uo_noteicon
end type
global w_event_route w_event_route

type variables
n_cst_beo_shipment   inv_shipment
n_cst_bso_Dispatch	inv_Dispatch
Long	il_ShipmentId

Long	ila_LegNumber[]
Long	il_LegCount
Boolean 	ib_ClearGuess = TRUE
Boolean	ib_DestroyDisp
end variables

forward prototypes
public function integer wf_getlegcount ()
public subroutine wf_selectnonrouted ()
public subroutine wf_highlightleg (readonly long al_row, readonly boolean ab_highlight)
end prototypes

public function integer wf_getlegcount ();//RDT 8-13-03 
/* Returns number of legs in event list and assigns a leg to each row
// loop thru each row and get Group type
// add an array element ( ila_LegNumber[] ) for each row
// For each Deliver Group type add 1 to the leg index value

	 example: 8 rows with 3 legs
		 ila_LegNumber[1] = 1  	PU
		 ila_LegNumber[2] = 1	Del
		 ila_LegNumber[3] = 2	PU
		 ila_LegNumber[4] = 2	Del
		 ila_LegNumber[5] = 2	Del
		 ila_LegNumber[6] = 2	Del
		 ila_LegNumber[7] = 3	PU
		 ila_LegNumber[8] = 3	Del
*/

Long		ll_row, &
			ll_RowCount, &
			ll_LegCount

Boolean	lb_DeliverySectionFlag  = False

String 	ls_EventType 

ll_RowCount = dw_1.RowCount()
ll_LegCount = 1

n_cst_Events	lnv_Events

FOR ll_Row = 1 to ll_RowCount

	ls_EventType = dw_1.GetItemString( ll_row, "de_event_type")

	IF lnv_Events.of_IsTypePickupGroup( ls_EventType ) THEN 
		
		If lb_DeliverySectionFlag  Then 
			//first event of the next leg
			ll_legCount ++
			lb_DeliverySectionFlag = FALSE
		End If

	ELSEIF lnv_Events.of_IsTypeDeliverGroup( ls_EventType ) THEN
		//Flag that we're in the delivery segment (we may have been already)
		lb_DeliverySectionFlag = TRUE

	ELSE
		//Do nothing - unknown event type 

	END IF
	
	ila_LegNumber[ ll_row ] = ll_LegCount
	
NEXT 


Return ll_LegCount

end function

public subroutine wf_selectnonrouted ();
// selects only routable, non routed, rows from the first leg that has non-routed rows

Boolean	lb_FoundNonRoutedEvent = False

Long	i, &
		ll_rows, &
		ll_Leg = 0

String 	ls_Trac, &
			ls_Routeable 

ll_Rows = dw_1.RowCount()

For i = 1 to ll_rows
	
	ls_trac = dw_1.inv_Base.of_GetItem(	i,  "trac_ref" ) 
	
	// Find first non-routed event (row)
	If Len( ls_Trac ) < 1 OR IsNull( ls_trac ) then 
		ll_leg = ila_LegNumber[ i ]


		DO WHILE ll_leg = ila_LegNumber[i]
			
			// check if event is routABLE 
			ls_Routeable = dw_1.GetItemString( i, "disp_events_routable") 
			if  ls_Routeable = "T" OR  IsNull( ls_Routeable ) Then 

				// Hightlight only the non-routed events in the leg		
				if Len( ls_Trac ) < 1 OR IsNull( ls_trac ) then 
					dw_1.SelectRow(i,TRUE)
				end if
				
			end if

			i ++				

			if i > ll_rows Then 
				Exit //Do while 
			else
				ls_trac = dw_1.inv_Base.of_GetItem(	i,  "trac_ref" ) 
			end if
	
		LOOP
		
		Exit  // For Next 
	End if
	
Next


end subroutine

public subroutine wf_highlightleg (readonly long al_row, readonly boolean ab_highlight);//ON HOLD 8-19-03// Do not allow the selection of non-routable events
Long 		ll_Leg, &
			ll_RowCount

//ON HOLD 8-19-03//String	ls_Routeable 

Integer	i

If il_LegCount = 1 then 
	dw_1.SelectRow(0, ab_highlight)
Else
	
	// highlight 1 leg 
	// get row leg
	ll_leg = ila_LegNumber[al_Row]
	ll_RowCount = dw_1.RowCount()

	For i = 1 to ll_RowCount 
		
		If ila_LegNumber[i] = ll_leg then 
//ON HOLD 8-19-03//			ls_Routeable = dw_1.GetItemString( i, "disp_events_routable") 
//ON HOLD 8-19-03//			if  ls_Routeable = "T" OR  IsNull( ls_Routeable ) Then 
				dw_1.SelectRow( i, ab_highlight )
//ON HOLD 8-19-03//			end if
			
		End If
		
	Next
	
	
End if
end subroutine

on w_event_route.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_routetype=create st_routetype
this.ddlb_routetype=create ddlb_routetype
this.cb_all=create cb_all
this.st_2=create st_2
this.uo_noteicon=create uo_noteicon
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_routetype
this.Control[iCurrent+5]=this.ddlb_routetype
this.Control[iCurrent+6]=this.cb_all
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.uo_noteicon
end on

on w_event_route.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_routetype)
destroy(this.ddlb_routetype)
destroy(this.cb_all)
destroy(this.st_2)
destroy(this.uo_noteicon)
end on

event pfc_default;
Long 	ll_Row, &
		ll_RowCount, &
		lla_eventID[]
	
n_cst_msg 	lnv_Msg
s_parm		lstr_parm

// Get list of selected Event Ids
ll_Row = 0
ll_RowCount = dw_1.RowCount()

For ll_Row = 1 to ll_RowCount
	
	If dw_1.IsSelected ( ll_Row ) Then 

		lla_eventID[ UpperBound( lla_eventID ) + 1 ] = dw_1.GetItemNumber(ll_Row,"de_id")
	End If
	
Next

If UpperBound( lla_eventID ) < 1 Then 
	MessageBox("Auto Route","No Events were selected. Please select an event to continue.")
	
Else

	lstr_Parm.is_Label = "EVENTS"
	lstr_Parm.ia_Value = lla_EventId[]
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	If ddlb_routetype.Visible = TRUE Then 
		lstr_Parm.is_Label = "ROUTETYPE"
		lstr_Parm.ia_Value = ddlb_routetype.text 
		lnv_Msg.of_Add_Parm ( lstr_Parm )
	End If
		
	
	CloseWithReturn(This, lnv_Msg)


End if



end event

event open;call super::open;Boolean	lb_Select = TRUE
Long	ll_EventCount, &
		ll_Return = 1, &
		lla_Events[]

String	ls_RouteStyle

n_cst_msg		lnv_msg
s_parm			lstr_parm
n_ds				lds_events
n_cst_settings lnv_Settings
n_cst_LicenseManager	lnv_LicenseManager	

ib_DisableCloseQuery = TRUE 
dw_1.SetTransObject(SQLCA)
lnv_msg =  Message.PowerObjectParm

// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()

//get msg parms
IF lnv_Msg.of_Get_Parm ( "MAKESELECTION" , lstr_Parm ) <> 0 THEN
	lb_Select = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "DISPATCH" , lstr_Parm ) <> 0 THEN
	inv_dispatch = lstr_Parm.ia_Value
END IF


IF lnv_Msg.of_Get_Parm ( "SHIPMENT" , lstr_Parm ) <> 0 THEN
	inv_Shipment = lstr_Parm.ia_Value
	IF isValid ( inv_Shipment ) THEN
		uo_noteicon.of_SetContext ( inv_Shipment , "SHIPNOTE" )
	END IF

END IF
	
if lnv_msg.of_get_parm ( "EVENTDATASTORE" , lstr_parm ) > 0 THEN
	lds_events = lstr_Parm.ia_Value
	lds_events.ShareData ( dw_1 )
ElseIF lnv_Msg.of_Get_Parm ( "EVENTIDS" , lstr_Parm ) <> 0 THEN
	lla_Events = lstr_Parm.ia_Value
	uo_noteicon.Visible = FALSE
	IF UpperBound ( lla_Events ) > 0 THEN
		dw_1.Retrieve ( lla_Events )
	END IF
ELSE
	MessageBox("Event Auto-Route","No Events to route.")
	ll_Return = -1
	This.TriggerEvent ( 'pfc_Cancel')
end if

IF ll_Return = 1 THEN
	IF dw_1.RowCount ( ) <= 0 THEN
		MessageBox("Event Auto-Route","No Events to route.")
		ll_Return = -1
		This.TriggerEvent ( 'pfc_Cancel')
	END IF
END IF

If ll_Return = 1 then 
	
	

	dw_1.SelectRow( 0, FALSE )
	ddlb_routetype.SetFocus()
	
	il_legCount = This.wf_GetLegCount() 
	IF lb_Select THEN
		This.wf_SelectNonRouted() 
	END IF
	
	IF NOT lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_RouteManager ) THEN
		st_routetype.Visible = False
		ddlb_routetype.Visible = False
	Else

		// Get System settings for autoroute style
		ls_RouteStyle = lnv_Settings.of_getAutoRouteStyle ( )
		ddlb_routetype.SelectItem ( ls_RouteStyle , 0)

	End if

	
End if


Return ll_Return 
end event

event pfc_cancel;call super::pfc_cancel;n_cst_msg 	lnv_Msg
s_parm		lstr_parm

lstr_Parm.is_Label = "NOEVENTS"
lstr_Parm.ia_Value = "CANCEL"
lnv_Msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn( This, lnv_Msg )
end event

type dw_1 from u_dw within w_event_route
integer x = 37
integer y = 148
integer width = 2213
integer height = 816
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_event_route"
boolean hscrollbar = true
end type

event constructor;n_cst_Events	lnv_Events

dw_1.of_SetBase( TRUE )

This.SetRowFocusIndicator ( FocusRect! )
//This.of_SetRowSelect(TRUE)
//inv_RowSelect.of_SetStyle ( appeon_constant.Extended )
This.ib_rmbmenu = false


This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
end event

event clicked;call super::clicked;//ON HOLD 8-19-03// Do not allow selection of NON-Routable events
//ON HOLD 8-19-03// String	ls_Routeable 

IF row > 0 Then 
//ON HOLD 8-19-03//	ls_Routeable = This.GetItemString( row, "disp_events_routable") 
//ON HOLD 8-19-03//	If ls_Routeable = "T"  OR IsNull( ls_Routeable ) Then 

		If KeyDown(KeyControl!) THEN
			
			if this.IsSelected( ROW ) Then 
				This.SelectRow(ROW, False)
			else
				This.SelectRow(ROW, True )
			end if
		
		Else 
			
			// Clear the guess 
			If ib_ClearGuess then 
				This.SelectRow(0, False)
				ib_ClearGuess = FALSE
			End If
			
			// set to user selection 
				
				if this.IsSelected( ROW ) Then 
	//				This.SelectRow(ROW, False)
					Parent.wf_highlightLeg( row , FALSE )
				else
	//				This.SelectRow(ROW, True )
					Parent.wf_highlightLeg( row , TRUE )
				end if
				
		End If
		
//ON HOLD 8-19-03//	Else
//ON HOLD 8-19-03//		This.SelectRow(ROW, False)
//ON HOLD 8-19-03//	End If

END IF
end event

type cb_ok from u_cb within w_event_route
integer x = 914
integer y = 996
integer taborder = 30
boolean bringtotop = true
integer weight = 400
string text = "&OK"
boolean default = true
end type

event clicked;Parent.TriggerEvent('pfc_default')
end event

type cb_cancel from u_cb within w_event_route
integer x = 1463
integer y = 996
integer taborder = 40
boolean bringtotop = true
integer weight = 400
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Parent.TriggerEvent("pfc_cancel")
end event

type st_routetype from u_st within w_event_route
integer x = 1490
integer y = 48
integer width = 306
boolean bringtotop = true
long backcolor = 12632256
string text = "&Route Type:"
end type

type ddlb_routetype from u_ddlb within w_event_route
integer x = 1778
integer y = 32
integer width = 471
integer height = 348
integer taborder = 10
boolean bringtotop = true
integer accelerator = 114
end type

event constructor;	
ddlb_RouteType.AddItem( gc_Dispatch.cs_RouteType_Any )
ddlb_RouteType.AddItem( gc_Dispatch.cs_RouteType_Pickup )
ddlb_RouteType.AddItem( gc_Dispatch.cs_RouteType_Deliver )
ddlb_RouteType.AddItem( "NONE")

ddlb_RouteType.SelectItem(1)

end event

type cb_all from u_cb within w_event_route
integer x = 366
integer y = 996
integer taborder = 50
boolean bringtotop = true
integer weight = 400
string text = "&All"
end type

event clicked;// select all rows and process
dw_1.SelectRow(0,True)

Parent.TriggerEvent('pfc_default')
end event

type st_2 from u_st within w_event_route
integer x = 256
integer y = 48
integer width = 942
boolean bringtotop = true
long backcolor = 12632256
string text = "Hold CTRL key down to select one event"
end type

type uo_noteicon from u_cst_noteicon within w_event_route
integer x = 41
integer y = 48
integer width = 105
integer height = 80
integer taborder = 10
boolean bringtotop = true
end type

event ue_shownotes;Long	ll_ID

n_Cst_Msg				lnv_Msg
S_Parm 					lstr_Parm 

IF isValid ( inv_Shipment ) THEN
	ll_ID = inv_Shipment.of_GetID ( )
END IF

lstr_parm.is_label = "TOPIC"
lstr_parm.ia_value = "SHIPMENT!"
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "DISPATCH"
lstr_parm.ia_value = inv_Dispatch
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "REQUEST"
lstr_parm.ia_value = "VIEWNOTES!"
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "TARGET_ID"
lstr_parm.ia_value = ll_ID
lnv_Msg.of_add_parm(lstr_parm)

f_process_standard(lnv_Msg)
end event

on uo_noteicon.destroy
call u_cst_noteicon::destroy
end on

