$PBExportHeader$u_cst_loadbuilder.sru
forward
global type u_cst_loadbuilder from u_base
end type
type cb_route from commandbutton within u_cst_loadbuilder
end type
type st_legnumber from statictext within u_cst_loadbuilder
end type
type cbx_alllegs from checkbox within u_cst_loadbuilder
end type
type sle_legnumber from singlelineedit within u_cst_loadbuilder
end type
type uo_selectedtotals from u_cst_itemlisttotals within u_cst_loadbuilder
end type
type uo_totals from u_cst_itemlisttotals within u_cst_loadbuilder
end type
type dw_itemlist from u_dw_itemlist within u_cst_loadbuilder
end type
type mle_instruct from multilineedit within u_cst_loadbuilder
end type
end forward

global type u_cst_loadbuilder from u_base
integer width = 3456
integer height = 1024
long backcolor = 12632256
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event ue_autoroute ( )
cb_route cb_route
st_legnumber st_legnumber
cbx_alllegs cbx_alllegs
sle_legnumber sle_legnumber
uo_selectedtotals uo_selectedtotals
uo_totals uo_totals
dw_itemlist dw_itemlist
mle_instruct mle_instruct
end type
global u_cst_loadbuilder u_cst_loadbuilder

forward prototypes
public function integer of_addshipments (long ala_ids[])
public function integer of_removeshipments (long ala_ids[])
public function integer of_setshipmentlist (long ala_ids[])
public function integer of_seteventscompleted (long ala_ids[])
public function integer of_setevents (long ala_ids[])
public function integer of_setcurrentevent (long al_id)
public function integer of_setreporttitle (string as_title)
public function integer of_setdispatchmanager (n_cst_bso_dispatch anv_dispatch)
end prototypes

event ue_autoroute();//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			ue_RouteByLeg
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	When this is initiated Profit Tools will identify all of the events in the 
//	selected   leg that belong to the highlighted shipments. These events will then be loaded 
//	into the event selection window
//	Get the events by calling n_cst_beo_Shipment.of_GetLegEventList ( ai_leg , ref  
//	 anva_Events)
// 	Then open w_event_route with the event ids
//     trap the eventids reurned as well as the route type and call:
//	n_cst_shipmentManager.of_SetRouteType ( li_RouteType )
//	n_cst_shipmentManager.of_AutoRoute ( ala_EventIds )
//    
// 	Note. Be sure that  il_InsertionEventId and ii_InsertionStyle are set. This should be 
//	changed to use defaults. This point has been mentioned in other documentation and may 
//	have already been changed.
//////////////////////////////////////////////////////////////////////////////

Long	lla_EventIds[]
Long	lla_EmptyIds[]
Int	li_EventCount
Int	li_TotalCount
Int	li_legToRoute
Long	lla_ShipmentIds[]
Int	li_ShipmentCount
Int	i,j
String	ls_RouteType

n_cst_AnyArraySrv		lnv_Array
n_cst_beo_Event		lnva_Events[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_Msg				lnv_Msg
S_Parm					lstr_Parm
Boolean					lb_AllLegs

lnv_Dispatch = CREATE n_cst_bso_Dispatch
lnv_Shipment = CREATE n_Cst_beo_SHipment

lb_AllLegs = cbx_alllegs.Checked
li_legToRoute = Integer ( sle_legnumber.text )

li_ShipmentCount = dw_itemlist.of_getshipments( lla_ShipmentIds )
lnv_Array.of_getshrinked( lla_ShipmentIds , TRUE ,TRUE )

lnv_Dispatch.of_RetrieveShipments ( lla_ShipmentIds )
lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) ) 
lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) ) 
lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) ) 
li_ShipmentCount = UpperBound ( lla_ShipmentIds )
IF li_ShipmentCount > 0 THEN
	FOR i = 1 TO li_ShipmentCount
		lnv_Shipment.of_SetSourceID ( lla_ShipmentIds[i] )
		IF lb_AllLegs THEN
			li_EventCount = lnv_Shipment.of_geteventlist( lnva_Events )
		ELSE
			li_EventCount = lnv_Shipment.of_getLegeventlist( li_LegToRoute , lnva_Events )
		END IF
		FOR j = 1 TO li_EventCount
			li_TotalCount ++
			lla_EventIds[li_TotalCount] = lnva_Events[j].of_GetID ( )
			DESTROY (  lnva_Events[j] )
		NEXT
	NEXT
	
	lstr_Parm.is_Label = "EVENTIDS"
	lstr_Parm.ia_Value = lla_EventIds
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "MAKESELECTION"
	lstr_Parm.ia_Value = FALSE
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	IF UpperBound ( lla_EventIds ) > 0 THEN
	
		OpenWithParm ( w_event_route , lnv_Msg )
		lnv_Msg = Message.powerObjectParm
		lla_EventIds = lla_EmptyIds
	END IF
	
	IF isValid ( lnv_Msg ) THEN
		IF lnv_Msg.of_Get_Parm ( "ROUTETYPE", lstr_Parm ) > 0 THEN
			ls_RouteType = lstr_Parm.ia_Value
		END IF
		
		IF lnv_Msg.of_Get_Parm ( "EVENTS", lstr_Parm ) > 0 THEN
			lla_EventIds = lstr_Parm.ia_Value
		END IF
		
		IF UpperBound ( lla_EventIds ) > 0 THEN
			lnv_ShipmentManager.of_setroutetype(  ls_RouteType )
			lnv_ShipmentManager.of_AutoRoute ( lla_EventIds )
		END IF
	END IF
END IF
DESTROY ( lnv_Dispatch )
DESTROY ( lnv_Shipment )



end event

public function integer of_addshipments (long ala_ids[]);RETURN dw_ItemList.of_AddShipments ( ala_Ids )
end function

public function integer of_removeshipments (long ala_ids[]);RETURN dw_ItemList.of_RemoveShipments ( ala_Ids )
end function

public function integer of_setshipmentlist (long ala_ids[]);RETURN dw_ItemList.of_SetShipmentList ( ala_Ids )
end function

public function integer of_seteventscompleted (long ala_ids[]);mle_Instruct.Visible = TRUE

RETURN dw_ItemList.of_SetEventsCompleted ( ala_Ids )
end function

public function integer of_setevents (long ala_ids[]);mle_Instruct.Visible = TRUE

RETURN dw_ItemList.of_SetEvents ( ala_Ids )
end function

public function integer of_setcurrentevent (long al_id);RETURN dw_ItemList.of_SetCurrentEvent ( al_Id )
end function

public function integer of_setreporttitle (string as_title);RETURN dw_ItemList.of_SetReportTitle ( as_Title )
end function

public function integer of_setdispatchmanager (n_cst_bso_dispatch anv_dispatch);RETURN dw_ItemList.of_SetDispatchManager ( anv_Dispatch )
end function

on u_cst_loadbuilder.create
int iCurrent
call super::create
this.cb_route=create cb_route
this.st_legnumber=create st_legnumber
this.cbx_alllegs=create cbx_alllegs
this.sle_legnumber=create sle_legnumber
this.uo_selectedtotals=create uo_selectedtotals
this.uo_totals=create uo_totals
this.dw_itemlist=create dw_itemlist
this.mle_instruct=create mle_instruct
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_route
this.Control[iCurrent+2]=this.st_legnumber
this.Control[iCurrent+3]=this.cbx_alllegs
this.Control[iCurrent+4]=this.sle_legnumber
this.Control[iCurrent+5]=this.uo_selectedtotals
this.Control[iCurrent+6]=this.uo_totals
this.Control[iCurrent+7]=this.dw_itemlist
this.Control[iCurrent+8]=this.mle_instruct
end on

on u_cst_loadbuilder.destroy
call super::destroy
destroy(this.cb_route)
destroy(this.st_legnumber)
destroy(this.cbx_alllegs)
destroy(this.sle_legnumber)
destroy(this.uo_selectedtotals)
destroy(this.uo_totals)
destroy(this.dw_itemlist)
destroy(this.mle_instruct)
end on

event constructor;dw_ItemList.of_SetAllowUserSelection ( TRUE )
THIS.of_SetResize( TRUE )
inv_Resize.of_register( cb_route, inv_resize.fixedright )
inv_Resize.of_register( sle_legnumber, inv_resize.fixedright )
inv_Resize.of_register( st_legnumber, inv_resize.fixedright )
inv_Resize.of_register( cbx_alllegs, inv_resize.fixedright )

inv_Resize.of_register( uo_selectedtotals, inv_resize.fixedright )
inv_Resize.of_register( uo_totals, inv_resize.fixedright )

inv_Resize.of_register( dw_itemlist, inv_resize.scalerightbottom )
end event

type cb_route from commandbutton within u_cst_loadbuilder
integer x = 1559
integer y = 220
integer width = 434
integer height = 80
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Route"
end type

event clicked;Parent.Event ue_AutoRoute ( )
end event

event constructor;n_cst_privileges_events	lnv_Privs
THIS.Enabled = lnv_Privs.of_Allowalteritins( )
end event

type st_legnumber from statictext within u_cst_loadbuilder
integer x = 1559
integer y = 136
integer width = 320
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Leg number"
boolean focusrectangle = false
end type

type cbx_alllegs from checkbox within u_cst_loadbuilder
integer x = 1733
integer y = 60
integer width = 265
integer height = 64
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "All legs"
boolean checked = true
boolean lefttext = true
end type

event clicked;IF THIS.Checked THEN
	sle_legnumber.Text = ""
END IF
end event

type sle_legnumber from singlelineedit within u_cst_loadbuilder
integer x = 1893
integer y = 132
integer width = 105
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modified;String	ls_Text
Int		li_Leg
ls_Text = Trim ( THIS.Text )
IF IsNumber ( ls_Text ) THEN
	li_leg = Integer ( ls_Text )
	IF li_Leg <= 0 THEN		
		Beep (1) 
		THIS.Text = ""
	END IF
ELSE
	Beep (1) 
	THIS.Text = ""
END IF

cbx_alllegs.checked = Len ( Trim ( THIS.Text ) ) = 0 
end event

type uo_selectedtotals from u_cst_itemlisttotals within u_cst_loadbuilder
integer x = 2811
integer y = 12
integer height = 320
integer taborder = 50
end type

event constructor;call super::constructor;of_SetGroupLabel ( "Totals (Selected)" )
end event

on uo_selectedtotals.destroy
call u_cst_itemlisttotals::destroy
end on

type uo_totals from u_cst_itemlisttotals within u_cst_loadbuilder
integer x = 2062
integer y = 12
integer height = 320
integer taborder = 40
end type

event constructor;call super::constructor;of_SetGroupLabel ( "Totals (All)" )
end event

on uo_totals.destroy
call u_cst_itemlisttotals::destroy
end on

type dw_itemlist from u_dw_itemlist within u_cst_loadbuilder
integer y = 376
integer height = 640
integer taborder = 60
end type

event ue_postselection;call super::ue_postselection;uo_Totals.of_SetWeight ( This.of_GetTotalWeight ( FALSE ) )
uo_Totals.of_SetCharges ( This.of_GetTotalCharges ( FALSE ) )

uo_SelectedTotals.of_SetWeight ( This.of_GetTotalWeight ( TRUE ) )
uo_SelectedTotals.of_SetCharges ( This.of_GetTotalCharges ( TRUE ) )
end event

type mle_instruct from multilineedit within u_cst_loadbuilder
boolean visible = false
integer x = 46
integer y = 32
integer width = 1248
integer height = 288
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Items initially highlighted are being picked up or delivered at the selected stop.  List does not carry over from previous day.  Unsaved changes to items are not reflected in list."
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

