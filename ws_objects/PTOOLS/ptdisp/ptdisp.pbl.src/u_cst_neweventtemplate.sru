$PBExportHeader$u_cst_neweventtemplate.sru
forward
global type u_cst_neweventtemplate from u_base
end type
type cb_templates from commandbutton within u_cst_neweventtemplate
end type
type cb_setup from commandbutton within u_cst_neweventtemplate
end type
type cb_route from commandbutton within u_cst_neweventtemplate
end type
type dw_itintemplateevents from u_dw within u_cst_neweventtemplate
end type
type st_events from u_st within u_cst_neweventtemplate
end type
type dw_itintemplates from u_dw within u_cst_neweventtemplate
end type
type gb_1 from groupbox within u_cst_neweventtemplate
end type
type st_route from statictext within u_cst_neweventtemplate
end type
end forward

global type u_cst_neweventtemplate from u_base
integer width = 2030
integer height = 580
long backcolor = 12632256
event type long ue_getroutingids ( ref long ala_ids[] )
event type n_cst_bso_dispatch ue_getdispatchmanager ( )
event ue_setroutemodeindicator ( boolean ab_switch )
event ue_routemode ( )
event ue_setup ( )
event type integer ue_autoroute ( )
cb_templates cb_templates
cb_setup cb_setup
cb_route cb_route
dw_itintemplateevents dw_itintemplateevents
st_events st_events
dw_itintemplates dw_itintemplates
gb_1 gb_1
st_route st_route
end type
global u_cst_neweventtemplate u_cst_neweventtemplate

event type long ue_getroutingids(ref long ala_ids[]);Long		lla_Ids[]
Long		ll_EventCount, i
Long		lla_Sites[]
String	lsa_TypeList[]
String	ls_MessageHeader = "Route Template Events", &
			ls_ErrorMessage = "Error adding template events."

Long		ll_Return = 0

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_Events			lnv_Events

ala_Ids = lla_Ids

IF ll_Return = 0 THEN
	ll_EventCount = dw_itintemplateevents.RowCount()
	FOR i = 1 TO ll_EventCount
		lsa_TypeList[i] = dw_itintemplateevents.GetItemString(i, "event_type")
		lla_Sites[i] = dw_itintemplateevents.GetItemNumber(i, "event_site")
	NEXT

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
	
	CHOOSE CASE lnv_Dispatch.of_NewEvents ( lsa_TypeList, lla_Sites, lla_Ids )
	
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

event ue_setup();Long		ll_NewId

Open(w_itintemplatesetup)

//Reset old templates
dw_itintemplates.inv_Linkage.of_ReSet()

//Retrieve new templates
IF dw_itintemplates.inv_Linkage.of_Retrieve() > 0 THEN
	dw_itintemplates.SetRow(1)
	dw_itintemplates.SelectRow(1, True)
END IF
end event

on u_cst_neweventtemplate.create
int iCurrent
call super::create
this.cb_templates=create cb_templates
this.cb_setup=create cb_setup
this.cb_route=create cb_route
this.dw_itintemplateevents=create dw_itintemplateevents
this.st_events=create st_events
this.dw_itintemplates=create dw_itintemplates
this.gb_1=create gb_1
this.st_route=create st_route
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_templates
this.Control[iCurrent+2]=this.cb_setup
this.Control[iCurrent+3]=this.cb_route
this.Control[iCurrent+4]=this.dw_itintemplateevents
this.Control[iCurrent+5]=this.st_events
this.Control[iCurrent+6]=this.dw_itintemplates
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_route
end on

on u_cst_neweventtemplate.destroy
call super::destroy
destroy(this.cb_templates)
destroy(this.cb_setup)
destroy(this.cb_route)
destroy(this.dw_itintemplateevents)
destroy(this.st_events)
destroy(this.dw_itintemplates)
destroy(this.gb_1)
destroy(this.st_route)
end on

event constructor;call super::constructor;//Set sorts, linkage service will sort accordingly
dw_itintemplateevents.SetSort("event_order A")
dw_itintemplates.SetSort("name A")


//Initialize linkage
dw_itintemplates.of_SetLinkage(True)
dw_itintemplateevents.of_SetLinkage(True)


dw_itintemplateevents.inv_Linkage.of_SetMaster(dw_itintemplates)
dw_itintemplateevents.inv_Linkage.of_SetStyle(n_cst_dwsrv_Linkage.RETRIEVE)
dw_itintemplateevents.inv_Linkage.of_Register("id", "id")


//Retrieve
dw_itintemplates.inv_Linkage.of_SetTransObject(SQLCA)

IF dw_itintemplates.inv_Linkage.of_Retrieve() > 0 THEN
	dw_itintemplates.SetRow(1)
	dw_itintemplates.SelectRow(1, True)
END IF

end event

type cb_templates from commandbutton within u_cst_neweventtemplate
integer x = 69
integer y = 68
integer width = 667
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Available &Templates"
end type

event clicked;Parent.Event ue_Setup()
end event

type cb_setup from commandbutton within u_cst_neweventtemplate
integer x = 777
integer y = 156
integer width = 334
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aut&o-Route"
end type

event clicked;Parent.Event ue_AutoRoute()
end event

type cb_route from commandbutton within u_cst_neweventtemplate
integer x = 1129
integer y = 156
integer width = 325
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Route"
end type

event clicked;Parent.Event ue_RouteMode()
end event

type dw_itintemplateevents from u_dw within u_cst_neweventtemplate
integer x = 777
integer y = 256
integer width = 1193
integer height = 272
integer taborder = 20
string dataobject = "d_itintemplateevents_single"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;n_cst_Events	lnv_Events

This.of_SetInsertable(False)
This.of_SetDeleteable(False)

//Initialize code table
This.Modify ("event_type.Edit.CodeTable = yes " + &
		"event_type.Values = '" + lnv_Events.of_GetTypeCodeTable( ) + "'" )


end event

event retrieverow;call super::retrieverow;This.SelectRow(row, True)
end event

type st_events from u_st within u_cst_neweventtemplate
integer x = 782
integer y = 72
integer width = 507
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 29409472
string text = "Events on Template"
end type

type dw_itintemplates from u_dw within u_cst_neweventtemplate
integer x = 64
integer y = 152
integer width = 672
integer height = 376
integer taborder = 10
string dataobject = "d_itintemplates"
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event constructor;call super::constructor;This.of_SetDeleteable( False )
This.of_SetInsertable( False )

This.of_SetRowSelect(True)
This.inv_RowSelect.of_SetRequestor(This)

This.inv_RowSelect.of_SetStyle(0)

//Hide header
dw_itintemplates.Modify("DataWindow.Header.Height = 0")
end event

event pfc_retrieve;//Overriding ancestor

Integer	li_Return

li_Return =  This.Retrieve()

Commit;

Return li_Return
end event

type gb_1 from groupbox within u_cst_neweventtemplate
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
string text = "Route Template Events"
end type

type st_route from statictext within u_cst_neweventtemplate
boolean visible = false
integer x = 1129
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

