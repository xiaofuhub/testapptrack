$PBExportHeader$w_shipmentlistorder.srw
forward
global type w_shipmentlistorder from w_main
end type
type cb_unselectall from u_cb within w_shipmentlistorder
end type
type cb_selectall from u_cb within w_shipmentlistorder
end type
type cb_ok from u_cbok within w_shipmentlistorder
end type
type dw_1 from u_dw_shipmentlist within w_shipmentlistorder
end type
type cb_cancel from u_cbcancel within w_shipmentlistorder
end type
type cb_bottom from commandbutton within w_shipmentlistorder
end type
type cb_top from commandbutton within w_shipmentlistorder
end type
type cb_down from commandbutton within w_shipmentlistorder
end type
type cb_up from commandbutton within w_shipmentlistorder
end type
type gb_1 from groupbox within w_shipmentlistorder
end type
end forward

global type w_shipmentlistorder from w_main
integer width = 3369
integer height = 2052
string title = "Auto Route Repos "
boolean clientedge = true
event ue_route ( )
cb_unselectall cb_unselectall
cb_selectall cb_selectall
cb_ok cb_ok
dw_1 dw_1
cb_cancel cb_cancel
cb_bottom cb_bottom
cb_top cb_top
cb_down cb_down
cb_up cb_up
gb_1 gb_1
end type
global w_shipmentlistorder w_shipmentlistorder

type variables
Boolean ib_Cancel

n_cst_msg inv_Msg

end variables

forward prototypes
public subroutine wf_moverowsdown ()
end prototypes

public subroutine wf_moverowsdown ();long	lla_Selected[], &
		ll_SelectedStartRow, &
		ll_SelectedEndRow, &
		ll_BeforeRow, &
		ll_SelectedRowCount, & 
		ll_RowNdx, &
		ll_RowCount, &
		ll_HoldRow
		
ll_RowCount = dw_1.RowCount()
lla_Selected = dw_1.object.ds_id.selected

ll_SelectedRowCount = upperbound ( lla_Selected )
IF ll_SelectedRowCount > 0 THEN

	ll_SelectedEndRow = dw_1.Find ( "ds_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )
	IF ll_SelectedEndRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_HoldRow = ll_SelectedEndRow + 2
		FOR ll_RowNdx = 1 TO ll_SelectedRowCount 
		
			ll_SelectedStartRow = dw_1.Find ( "ds_id = " + String ( lla_Selected [ll_RowNdx] ), 1, ll_RowCount )
	
			CHOOSE CASE ll_SelectedStartRow
				CASE 0 	//problem
					
				CASE ELSE
					
					IF ll_RowNdx = 1 THEN
						ll_BeforeRow = ll_SelectedEndRow + 2
					END IF
					
					ll_SelectedEndRow = ll_SelectedStartRow
					dw_1.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_1, ll_BeforeRow, Primary! )
					
			END CHOOSE
			
		NEXT

		//set row selections
		dw_1.SelectRow ( 0, FALSE)
		//first row to highlight
		ll_SelectedStartRow = dw_1.Find ( "ds_id = " + String ( lla_Selected [1] ), 1, ll_RowCount )
		ll_SelectedEndRow = dw_1.Find ( "ds_id = " + String ( lla_Selected [ll_SelectedRowCount] ), 1, ll_RowCount )

		FOR ll_RowNdx = ll_SelectedStartRow TO ll_SelectedEndRow  
			
			dw_1.SelectRow (ll_RowNdx, TRUE)

			IF ll_RowNdx = ll_SelectedStartRow THEN
				dw_1.SetRow ( ll_RowNdx)
			END IF				

		next
				
	END IF
	
ELSE
	ll_SelectedStartRow = dw_1.GetRow()
	ll_SelectedEndRow = dw_1.GetRow()
	IF ll_SelectedStartRow = ll_RowCount THEN
		//No move necessary
	ELSE
		ll_BeforeRow = ll_SelectedEndRow + 2
		dw_1.RowsMove ( ll_SelectedStartRow, ll_SelectedEndRow, Primary!, dw_1, ll_BeforeRow, Primary! )
		dw_1.SelectRow (ll_SelectedStartRow, FALSE)
		dw_1.SelectRow (ll_SelectedStartRow + 1, TRUE)
		dw_1.SetRow ( ll_SelectedStartRow + 1)
	END IF
	
END IF

dw_1.SetFocus()

end subroutine

on w_shipmentlistorder.create
int iCurrent
call super::create
this.cb_unselectall=create cb_unselectall
this.cb_selectall=create cb_selectall
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_bottom=create cb_bottom
this.cb_top=create cb_top
this.cb_down=create cb_down
this.cb_up=create cb_up
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_unselectall
this.Control[iCurrent+2]=this.cb_selectall
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_bottom
this.Control[iCurrent+7]=this.cb_top
this.Control[iCurrent+8]=this.cb_down
this.Control[iCurrent+9]=this.cb_up
this.Control[iCurrent+10]=this.gb_1
end on

on w_shipmentlistorder.destroy
call super::destroy
destroy(this.cb_unselectall)
destroy(this.cb_selectall)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_bottom)
destroy(this.cb_top)
destroy(this.cb_down)
destroy(this.cb_up)
destroy(this.gb_1)
end on

event open;call super::open;SetPointer(HourGlass!)

//// Display the window on top left
This.X = 1
This.Y = 1

Int li_Ctr

Long ll_Shipmentid
Long ll_UpperBound
Long ll_RowsRetrieved
Long lla_Shipmentid[]

s_Parm lstr_Parm

inv_Msg = Message.PowerObjectParm
n_cst_Presentation_EquipmentSummary lnv_EquipmentSummary
n_cst_ShipmentManager lnv_ShipmentManager
n_cst_Presentation_Shipment lnv_Presentation

THIS.SetRedraw ( FALSE )

// Resizing Window
This.of_SetResize(TRUE)
inv_Resize.of_Register(	dw_1		,	appeon_constant.ScaleRightBottom)
inv_Resize.of_Register( gb_1		,  appeon_constant.FixedRight   	)
inv_Resize.of_Register(	cb_Top	,	appeon_constant.FixedRight		) 
inv_Resize.of_Register(	cb_Bottom,	appeon_constant.FixedRight		)
inv_Resize.of_Register( cb_Up		,	appeon_constant.FixedRight		)	
inv_Resize.of_register( cb_Down	,	appeon_constant.FixedRight		)
inv_Resize.of_Register( cb_ok ,  appeon_constant.FixedRight			)
inv_Resize.of_Register( cb_Cancel,  appeon_constant.FixedRight   	)
inv_Resize.of_Register( cb_selectall,  appeon_constant.FixedRight   )
inv_Resize.of_Register( cb_UNSelectall,  appeon_constant.FixedRight )

IF inv_Msg.of_Get_parm( "SHIPMENTID",lstr_Parm) <> 0 THEN
	lla_Shipmentid[] = lstr_Parm.ia_Value
ELSEIF inv_msg.of_Get_parm ( "TARGET_IDS", lstr_Parm) <> 0 THEN
	lla_Shipmentid[] = lstr_Parm.ia_Value
ElseIF inv_msg.of_Get_parm ( "TARGET_ID", lstr_Parm) <> 0 THEN
	lla_Shipmentid[1] = lstr_Parm.ia_Value 
ELSE
	MessageBox("Auto Route Repos", "Open Failed. No Shipment ID in message")
End If

dw_1.SetTransObject(SQLCA)

ll_RowsRetrieved = dw_1.Retrieve(lla_Shipmentid)

//Populates the Equipment type names
lnv_EquipmentSummary.of_Setpresentation(dw_1)

// Populates the reference types & corresponsing reference name.
lnv_ShipmentManager.of_PopulateReferenceLists (dw_1)
lnv_Presentation.of_SetPresentation (dw_1)

THIS.SetRedraw(TRUE)

IF ll_RowsRetrieved <= 0 THEN
	MessageBox("Auto Route Repos","Shipment id list empty")
	Close(This)
ELSE
	dw_1.SelectRow( 0,TRUE)
END IF
end event

type cb_unselectall from u_cb within w_shipmentlistorder
integer x = 2720
integer y = 1004
integer width = 398
integer height = 112
integer taborder = 70
integer weight = 400
string text = "Unselect All"
end type

event clicked;call super::clicked;dw_1.of_UnSelectAllRows( )
end event

type cb_selectall from u_cb within w_shipmentlistorder
integer x = 2720
integer y = 852
integer width = 398
integer height = 112
integer taborder = 60
integer weight = 400
string text = "Select All"
end type

event clicked;call super::clicked;dw_1.of_SelectAllRows( )
end event

type cb_ok from u_cbok within w_shipmentlistorder
integer x = 2720
integer y = 1160
integer width = 398
integer height = 108
integer taborder = 90
integer weight = 400
fontcharset fontcharset = ansi!
end type

event clicked;call super::clicked;//event ue_route( ) // Moved to decendant
end event

type dw_1 from u_dw_shipmentlist within w_shipmentlistorder
integer x = 69
integer y = 68
integer width = 2455
integer height = 1828
integer taborder = 10
string dataobject = "d_shipmentroutinglist"
end type

event constructor;call super::constructor;of_SetRowManager( TRUE)
of_SetRowSelect( TRUE)
inv_RowSelect.of_setstyle(2)
end event

event clicked;call super::clicked;Long ll_ClickedRow

ll_ClickedRow = This.GetClickedRow()

IF ll_ClickedRow = 0 THEN
	This.SelectRow(0,FALSE)
END IF
end event

type cb_cancel from u_cbcancel within w_shipmentlistorder
integer x = 2720
integer y = 1312
integer width = 398
integer height = 112
integer taborder = 80
integer weight = 400
fontcharset fontcharset = ansi!
end type

event clicked;call super::clicked;ib_disableclosequery = TRUE
ib_Cancel 				= TRUE
Close(Parent)
end event

type cb_bottom from commandbutton within w_shipmentlistorder
integer x = 2720
integer y = 600
integer width = 398
integer height = 112
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Bottom"
end type

event clicked;dw_1.of_MoveRowsBottom( )
end event

type cb_top from commandbutton within w_shipmentlistorder
integer x = 2720
integer y = 452
integer width = 398
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Top"
end type

event clicked;dw_1.of_MoveRowsTop( )
end event

type cb_down from commandbutton within w_shipmentlistorder
integer x = 2720
integer y = 304
integer width = 398
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Down"
end type

event clicked;dw_1.of_MoveRowsDown( )

//wf_moverowsdown( )
end event

type cb_up from commandbutton within w_shipmentlistorder
integer x = 2720
integer y = 156
integer width = 398
integer height = 112
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Up"
end type

event clicked;dw_1.of_MoveRowsUp( )

end event

type gb_1 from groupbox within w_shipmentlistorder
integer x = 2610
integer y = 56
integer width = 617
integer height = 708
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selected Shipments"
end type

