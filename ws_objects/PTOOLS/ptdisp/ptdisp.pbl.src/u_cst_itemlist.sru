$PBExportHeader$u_cst_itemlist.sru
forward
global type u_cst_itemlist from u_base
end type
type st_item_ind from statictext within u_cst_itemlist
end type
type dw_itemlist from u_dw_shipmentitemlist within u_cst_itemlist
end type
type cb_1 from commandbutton within u_cst_itemlist
end type
type cb_2 from commandbutton within u_cst_itemlist
end type
end forward

global type u_cst_itemlist from u_base
integer width = 3218
integer height = 380
long backcolor = 12632256
event type integer ue_showdetails ( long al_row )
event type integer ue_ratelookup ( boolean ab_createnew )
event type integer ue_rowfocuschanged ( long al_row )
event ue_calcfreightcircles ( long row,  dwobject dwo )
event type n_cst_beo_shipment ue_getshipment ( )
event type n_cst_bso_dispatch ue_getdispatch ( )
event type integer ue_itemadded ( long al_itemid )
event ue_refresh ( )
event ue_itemdeleted ( )
event ue_deleteitem ( )
st_item_ind st_item_ind
dw_itemlist dw_itemlist
cb_1 cb_1
cb_2 cb_2
end type
global u_cst_itemlist u_cst_itemlist

type prototypes

end prototypes

type variables
DataStore	ids_Temp
Long	il_OriginalHeight

end variables

forward prototypes
public function integer of_getselectedids (ref long ala_ids[])
public function integer of_sharedata (datastore ads_source)
public function integer of_selectrow (long al_Row, boolean ab_Highlight)
public function long of_getrow ()
public function integer of_setredraw (boolean ab_Value)
public function integer of_setcontext (string as_context)
public function n_cst_beo_item of_getselecteditem ()
public subroutine of_resetrange ()
public function integer of_setdisplayrestrictions ()
public function integer of_setheight (long al_Height)
public function long of_find (string as_Expression)
public function integer of_setrow (long al_row)
public function integer of_sharedataoff ()
public function integer of_getitemcount ()
public function integer of_hiderates ()
end prototypes

event type integer ue_itemadded(long al_itemid);THIS.of_resetrange( )
dw_itemlist.Sort ( ) 
dw_itemlist.SetRedraw  ( TRUE )

RETURN 1


end event

event ue_refresh;dw_itemlist.Sort ( ) 
dw_itemlist.SetRedraw  ( TRUE )
end event

event ue_itemdeleted();THIS.of_ResetRange()
end event

public function integer of_getselectedids (ref long ala_ids[]);RETURN dw_itemlist.of_GetSelectedIds ( ala_Ids )


end function

public function integer of_sharedata (datastore ads_source);Int	li_Return
li_Return = ads_Source.ShareData ( dw_itemlist )
THIS.of_ResetRange ( )

String	ls_Temp

ls_Temp = ads_Source.Describe ( "datawindow.table.sort" )
//MessageBox ("Sort" , ls_Temp )

dw_itemlist.SetSort ( ls_Temp )
dw_itemlist.Sort ( ) 
dw_itemlist.SetRedraw  ( TRUE )


RETURN li_Return

end function

public function integer of_selectrow (long al_Row, boolean ab_Highlight);RETURN dw_itemlist.of_SelectRow ( al_Row , ab_Highlight )

end function

public function long of_getrow ();RETURN dw_itemlist.of_GetRow ( ) 
end function

public function integer of_setredraw (boolean ab_Value);THIS.SetRedraw ( ab_Value ) 
RETURN 1
end function

public function integer of_setcontext (string as_context);
CHOOSE CASE UPPER ( as_Context ) 
		
	CASE "INTERMODAL"			
		dw_itemlist.Modify ( "comp_pu.Visible = ~"0~tIF (  di_item_type = 'L' , 0 , 1 )~"" )
		dw_itemlist.Modify ( "comp_DEL.color = ~"0~tif ( di_item_type = 'L', RGB ( 255 , 255, 255 ), 0 )~"" ) 
	
	CASE ELSE

		dw_itemlist.Modify ( "comp_pu.Visible = 1")		
		dw_itemlist.Modify ( "comp_DEL.color = ~"0~tif ( di_del_event = comp_event and di_pu_event > 0, 32768, 0 )~"" )

END CHOOSE

dw_itemlist.Post of_InitializeRestrictions ( )

RETURN 1
		
		
end function

public function n_cst_beo_item of_getselecteditem ();Long	ll_Row

n_Cst_beo_Item	lnv_Item

ll_Row = dw_itemlist.GetRow ( )

IF ll_Row > 0 THEN
	lnv_Item = CREATE n_cst_Beo_Item
	lnv_Item.of_SetSource ( dw_itemlist )
	lnv_Item.of_SetSourceRow ( ll_Row )
END IF

RETURN lnv_Item
end function

public subroutine of_resetrange ();Long	ll_FirstRow
Long	ll_LastRow
Long	ll_ItemCount

ll_FirstRow = integer(dw_itemlist.describe("datawindow.firstrowonpage"))
ll_LastRow = integer(dw_itemlist.describe("datawindow.lastrowonpage"))
ll_ItemCount = dw_itemlist.RowCount ( ) 

st_item_ind.text = "&Item List: " + string( ll_FirstRow ) + " to " + string( ll_LastRow ) + " of " + string( ll_ItemCount )

end subroutine

public function integer of_setdisplayrestrictions ();
dw_itemlist.Post of_SetDisplayRestrictions ( )


RETURN 1
end function

public function integer of_setheight (long al_Height);THIS.Height = al_Height
RETURN 1
end function

public function long of_find (string as_Expression);RETURN dw_itemlist.find( as_Expression , 1 , dw_itemlist.RowCount ( ) + 1 ) 
end function

public function integer of_setrow (long al_row);dw_ItemList.ScrollToRow ( al_Row ) 
dw_itemlist.SetRow ( al_row )
RETURN 1
end function

public function integer of_sharedataoff ();//
/***************************************************************************************
NAME			: of_sharedataoff
ACCESS		: Public 
 
ARGUMENTS	: none
RETURNS		: Integer
DESCRIPTION	: Turns Sharedata off

REVISION		: RDT 6-19-03 
***************************************************************************************/
Int	li_Return

li_Return = dw_ItemList.ShareDataOff() 

RETURN li_Return

end function

public function integer of_getitemcount ();RETURN dw_itemlist.of_Getitemcount( )
end function

public function integer of_hiderates ();//Created by Dan 1-27-07 To hide anything that displays a rate or charge.

Int	li_Return
String	ls_Temp
dw_itemlist.Modify("di_our_itemamt.Visible=0")
dw_itemlist.Modify("di_pay_itemamt.Visible=0")

//this hides the description when the type is FSC because the description contains rate information
dw_itemlist.Modify("di_description.Visible='1~tIf(di_item_type=~"A~",0,1)'")

RETURN li_return
end function

on u_cst_itemlist.create
int iCurrent
call super::create
this.st_item_ind=create st_item_ind
this.dw_itemlist=create dw_itemlist
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_item_ind
this.Control[iCurrent+2]=this.dw_itemlist
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on u_cst_itemlist.destroy
call super::destroy
destroy(this.st_item_ind)
destroy(this.dw_itemlist)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event constructor;call super::constructor;N_cst_privsManager	lnv_manager

THIS.of_SetResize ( TRUE )
inv_Resize.of_Register ( dw_itemlist , 'ScaleToRight&Bottom' )
il_OriginalHeight = THIS.Height
dw_itemlist.hscrollbar = FALSE 


lnv_manager = gnv_app.of_getPrivsmanager( )

IF lnv_manager.of_getUserpermissionfromfn( "View Charges" ) <> 1 THEN
	this.of_hiderates( )
END IF


end event

type st_item_ind from statictext within u_cst_itemlist
integer x = 5
integer width = 677
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "&Item List: 0 to 0 of 0"
boolean focusrectangle = false
end type

event clicked;//Display Item Details
//dw_itemlist.TriggerEvent ( "DoubleClicked" )

Long	ll_Row
IF dw_itemlist.RowCount ( ) > 0 THEN
	ll_Row = dw_itemlist.GetRow ( ) 
	IF ll_Row = 0 THEN
		ll_Row = 1 
		dw_itemlist.SelectRow ( 1 , TRUE ) 
	END IF
END IF

Parent.Event ue_ShowDetails ( ll_Row )
end event

type dw_itemlist from u_dw_shipmentitemlist within u_cst_itemlist
event ue_keydown pbm_dwnkey
integer y = 64
integer width = 3205
integer height = 316
integer taborder = 10
boolean bringtotop = true
end type

event ue_keydown;Long	ll_NewRow

CHOOSE CASE key
	CASE keyRightArrow!
		dw_itemlist.of_ScrollRight ( )
		
	CASE keyLeftArrow!
		dw_itemlist.of_ScrollLeft ( )
		
	CASE keyUpArrow!
		ll_NewRow = THIS.GetRow ( ) - 1
		IF ll_NewRow > 0 THEN
			THIS.SetRow ( ll_NewRow )
		END IF
		
		
	CASE keyDownArrow!
		
		ll_NewRow = THIS.GetRow ( ) + 1
		IF ll_NewRow > 0 AND ll_NewRow <= THIS.RowCount ( ) THEN
			THIS.SetRow ( ll_NewRow )
		END IF
	 
END CHOOSE

RETURN 1
end event

event ue_showdetails;Parent.Event ue_ShowDetails ( al_row )
RETURN 1
end event

event ue_ratelookup;RETURN Parent.Event ue_RateLookup ( ab_createnew ) 
end event

event rowfocuschanged;call super::rowfocuschanged;Parent.Event ue_RowFocusChanged ( currentrow )
end event

event scrollvertical;call super::scrollvertical;PARENT.of_ResetRange ( )
Return 1 
end event

event clicked;call super::clicked;
IF gnv_app.of_getprivsmanager( ).of_getuserpermissionfromfn( "ModifyShipment",  THIS.event ue_getshipment( ) ) = appeon_constant.ci_True THEN

	CHOOSE CASE dwo.Name
			
		CASE "comp_pu", "comp_del"
			 THIS.SetRow ( row )
			PARENT.Event ue_CalcFreightCircles ( row , dwo )
	END CHOOSE
END IF

end event

event ue_sethazmat;n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = PARENT.Event ue_GetShipment ( )
IF isValid ( lnv_Shipment ) THEN
 	lnv_Shipment.of_SetHazmat ( ab_value )
END IF

RETURN 1
end event

event ue_getshipment;RETURN PARENT.Event ue_GetShipment ( ) 
end event

event ue_getdispatch;RETURN Parent.Event ue_GetDispatch ( ) 
end event

event losefocus;THIS.of_ScrollLeft ( ) 
end event

event ue_deleteitem;Parent.Event ue_DeleteItem ( )
end event

type cb_1 from commandbutton within u_cst_itemlist
integer x = 681
integer width = 91
integer height = 56
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&,    <     "
end type

event clicked;dw_itemlist.of_ScrollLeft ( )
end event

type cb_2 from commandbutton within u_cst_itemlist
integer x = 777
integer width = 91
integer height = 56
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&.    >     "
end type

event clicked;dw_itemlist.of_ScrollRight ( )



end event

