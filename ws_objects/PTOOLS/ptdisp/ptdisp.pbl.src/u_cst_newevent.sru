$PBExportHeader$u_cst_newevent.sru
forward
global type u_cst_newevent from u_base
end type
type lb_multiselection from u_lb within u_cst_newevent
end type
type lb_eventlist from u_lb within u_cst_newevent
end type
type cb_route from u_cb within u_cst_newevent
end type
type cb_autoroute from u_cb within u_cst_newevent
end type
type st_selection from u_st within u_cst_newevent
end type
type st_1 from u_st within u_cst_newevent
end type
type gb_4 from groupbox within u_cst_newevent
end type
type st_route from statictext within u_cst_newevent
end type
end forward

global type u_cst_newevent from u_base
integer width = 2030
integer height = 580
long backcolor = 12632256
event type integer ue_autoroute ( )
event ue_routemode ( )
event type long ue_getroutingids ( ref long ala_ids[] )
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event ue_setroutemodeindicator ( boolean ab_switch )
lb_multiselection lb_multiselection
lb_eventlist lb_eventlist
cb_route cb_route
cb_autoroute cb_autoroute
st_selection st_selection
st_1 st_1
gb_4 gb_4
st_route st_route
end type
global u_cst_newevent u_cst_newevent

event type long ue_getroutingids(ref long ala_ids[]);Long		lla_Ids[]
String	ls_SingleItem, &
			lsa_TypeList[]
Integer	li_MultiItems, &
			li_SingleItem, &
			li_Index
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_Events			lnv_Events
String	ls_MessageHeader = "Route New Events", &
			ls_ErrorMessage = "Error adding new events."

Long		ll_Return = 0

ala_Ids = lla_Ids

IF ll_Return = 0 THEN

	li_MultiItems = lb_MultiSelection.TotalItems ( )

	IF li_MultiItems > 0 THEN

		FOR li_Index = 1 TO li_MultiItems

			lsa_TypeList [ li_Index ] = lnv_Events.of_GetTypeDataValue ( lb_MultiSelection.Text ( li_Index ) )

		NEXT

	ELSE

		ls_SingleItem = lb_EventList.SelectedItem ( )

		IF Len ( ls_SingleItem ) > 0 THEN

			lsa_TypeList [ 1 ] = lnv_Events.of_GetTypeDataValue ( ls_SingleItem )

		END IF

	END IF

	IF UpperBound ( lsa_TypeList ) = 0 THEN

		ls_ErrorMessage = "You must select the event(s) to add first."
		ll_Return = -1

	END IF

END IF


IF ll_Return = 0 THEN

	lnv_Dispatch = This.Event ue_GetDispatchManager ( )

	IF NOT IsValid ( lnv_Dispatch ) THEN
		ls_ErrorMessage += "~n(No dispatch manager reference.)"
		ll_Return = -1
	END IF

END IF


IF ll_Return = 0 THEN

	//Create new event rows for the requested event types in the filter buffer.
	//Get the new event ids into lla_Target
	
	CHOOSE CASE lnv_Dispatch.of_NewEvents ( lsa_TypeList, lla_Ids )
	
	CASE 1  //Success
	
	CASE ELSE  //Error, or unexpected value
		ls_ErrorMessage += "~n(Could not add new events.)"
		ll_Return = -1
	
	END CHOOSE

END IF


IF ll_Return = 0 THEN

	ala_Ids = lla_Ids
	ll_Return = UpperBound ( ala_Ids )

ELSE

	MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )

END IF


RETURN ll_Return
end event

event ue_setroutemodeindicator(boolean ab_switch);//Toggles the route mode display indicator on or off, according to ab_Switch.

IF NOT IsNull ( ab_Switch ) THEN
	cb_Route.Visible = NOT ab_Switch
	st_Route.Visible = ab_Switch
END IF
end event

on u_cst_newevent.create
int iCurrent
call super::create
this.lb_multiselection=create lb_multiselection
this.lb_eventlist=create lb_eventlist
this.cb_route=create cb_route
this.cb_autoroute=create cb_autoroute
this.st_selection=create st_selection
this.st_1=create st_1
this.gb_4=create gb_4
this.st_route=create st_route
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_multiselection
this.Control[iCurrent+2]=this.lb_eventlist
this.Control[iCurrent+3]=this.cb_route
this.Control[iCurrent+4]=this.cb_autoroute
this.Control[iCurrent+5]=this.st_selection
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.st_route
end on

on u_cst_newevent.destroy
call super::destroy
destroy(this.lb_multiselection)
destroy(this.lb_eventlist)
destroy(this.cb_route)
destroy(this.cb_autoroute)
destroy(this.st_selection)
destroy(this.st_1)
destroy(this.gb_4)
destroy(this.st_route)
end on

type lb_multiselection from u_lb within u_cst_newevent
event keydown pbm_keydown
integer x = 777
integer y = 256
integer width = 677
integer height = 272
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean sorted = false
end type

event keydown;//Make pressing space behave like doubleclicking

IF ( KeyDown ( KeySpaceBar! ) ) THEN

	This.Event DoubleClicked ( This.SelectedIndex ( ) )

END IF
end event

event doubleclicked;IF Index > 0 THEN
	This.DeleteItem ( Index )
END IF
end event

type lb_eventlist from u_lb within u_cst_newevent
event keydown pbm_keydown
event ue_select ( integer ai_index,  boolean ab_append )
integer x = 64
integer y = 152
integer width = 672
integer height = 376
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
boolean sorted = false
end type

event keydown;Boolean	lb_Append

IF KeyDown ( KeySpaceBar! ) THEN
	lb_Append = KeyDown ( KeyControl! )
	This.Event ue_Select ( This.SelectedIndex ( ), lb_Append )
END IF


end event

event ue_select;IF ai_Index > 0 THEN

	IF ab_Append = TRUE THEN
		//Append entry -- don't reset
	ELSE
		lb_MultiSelection.Reset ( )
	END IF

	lb_MultiSelection.AddItem ( This.Text ( ai_Index ) )

END IF
end event

event constructor;String	ls_TypeList, &
			lsa_Types[], &
			lsa_Empty[]
Long		ll_TypeCount, &
			ll_Index
Integer	li_Category
n_cst_String	lnv_String
n_cst_Events	lnv_Events


FOR li_Category = 1 TO 2

	//Clear the types array
	lsa_Types = lsa_Empty


	//Determine which types to add based on which pass we're on.

	CHOOSE CASE li_Category

	CASE 1   //Add assignment types to the list
		ls_TypeList = lnv_Events.of_GetAssignmentTypes ( )

	CASE 2   //Add passive types to the list
		ls_TypeList = lnv_Events.of_GetPassiveTypes ( )

	END CHOOSE

	//Parse the type list to an array of types	
	ll_TypeCount = lnv_String.of_ParseToArray ( ls_TypeList, "~t", lsa_Types )
	

	//Add each type to the list box, using the display value.
	FOR ll_Index = 1 TO ll_TypeCount
		This.SetRedraw ( FALSE )
		This.AddItem ( lnv_Events.of_GetTypeDisplayValue ( Char ( lsa_Types [ ll_Index ] ) ) )
		This.SetRedraw ( TRUE )
	NEXT

NEXT
end event

event selectionchanged;IF KeyDown ( KeyUpArrow! ) OR KeyDown ( KeyDownArrow! ) &
	OR KeyDown ( KeyLeftArrow! ) OR KeyDown ( KeyRightArrow! ) THEN

	//Selection has changed due to keyboard scroll -- don't change the 
	//event selection

ELSE

	//Selection has changed due to mouse click -- change the event selection.
	This.Event ue_Select ( Index, KeyDown ( KeyControl! ) /*Append?*/ )

END IF
end event

type cb_route from u_cb within u_cst_newevent
integer x = 1129
integer y = 156
integer width = 325
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "&Route"
end type

event clicked;Parent.Event ue_RouteMode ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type cb_autoroute from u_cb within u_cst_newevent
integer x = 777
integer y = 156
integer width = 334
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string facename = "MS Sans Serif"
string text = "Aut&o-Route"
end type

event clicked;Parent.Event ue_AutoRoute ( )
end event

event constructor;call super::constructor;n_cst_Privileges_Events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type st_selection from u_st within u_cst_newevent
integer x = 782
integer y = 76
integer width = 489
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 29409472
string text = "Events to Route"
end type

type st_1 from u_st within u_cst_newevent
integer x = 64
integer y = 72
integer width = 416
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 29409472
string text = "Available Events"
end type

type gb_4 from groupbox within u_cst_newevent
integer x = 23
integer width = 1989
integer height = 556
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 29409472
string text = "Route New Events"
end type

type st_route from statictext within u_cst_newevent
boolean visible = false
integer x = 1138
integer y = 160
integer width = 306
integer height = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 255
string text = "Route"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

