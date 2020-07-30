$PBExportHeader$w_rate_selection.srw
forward
global type w_rate_selection from w_response
end type
type cb_ok from u_cb within w_rate_selection
end type
type cb_cancel from u_cb within w_rate_selection
end type
type cb_newquery from u_cb within w_rate_selection
end type
type mle_message from u_mle within w_rate_selection
end type
type rb_row from u_rb within w_rate_selection
end type
type rb_rate from u_rb within w_rate_selection
end type
type dw_rateselection from u_dw within w_rate_selection
end type
type gb_1 from groupbox within w_rate_selection
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//String    ss_RadioButtonChecked
////end modification Shared Variables by appeon  20070730
//
end variables

global type w_rate_selection from w_response
integer x = 197
integer y = 1052
integer width = 3333
integer height = 1032
string title = "Rate Selection"
event ue_paste ( )
cb_ok cb_ok
cb_cancel cb_cancel
cb_newquery cb_newquery
mle_message mle_message
rb_row rb_row
rb_rate rb_rate
dw_rateselection dw_rateselection
gb_1 gb_1
end type
global w_rate_selection w_rate_selection

type variables
//begin modification Shared Variables by appeon  20070730
String    ss_RadioButtonChecked
//end modification Shared Variables by appeon  20070730

end variables

event ue_paste;long	ll_CurrentRow
long ll_ItemIndex 
n_cst_msg	lnv_Msg	
S_Parm		lstr_Parm
n_cst_Beo_Item	lnv_Item
n_cst_Rate_Attribs	lnv_Attribs

lnv_Item = CREATE n_cst_beo_Item

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = String ("TRUE" )

lnv_Msg.of_Add_Parm ( lstr_Parm )


CHOOSE CASE ss_RadioButtonChecked
	CASE "ROW"
		lstr_Parm.is_Label = "PASTING"
		lstr_Parm.ia_value = "ROW"
		
	CASE ELSE

		lstr_Parm.is_Label = "PASTING"
		lstr_Parm.ia_Value = "RATE"
		
END CHOOSE

lnv_Msg.of_Add_Parm ( lstr_Parm )

ll_CurrentRow = dw_rateselection.getselectedRow (0)
 lnv_Item.of_SetSource ( dw_rateselection ) 
lnv_Item.of_SetSourceRow ( ll_CurrentRow )

lnv_Attribs.of_SetCurrentRow( ll_CurrentRow )


ll_ItemIndex = lnv_Item.of_GetId () 

lstr_Parm.is_Label = "ITEMINDEX"
lstr_Parm.ia_Value = ll_ItemIndex
lnv_Msg.of_Add_Parm ( lstr_Parm )

DESTROY ( lnv_Item )

CloseWithReturn ( THIS , lnv_Msg )


//lnv_Item.of_SetShipment ( inv_Shipment )


end event

on w_rate_selection.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_newquery=create cb_newquery
this.mle_message=create mle_message
this.rb_row=create rb_row
this.rb_rate=create rb_rate
this.dw_rateselection=create dw_rateselection
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_newquery
this.Control[iCurrent+4]=this.mle_message
this.Control[iCurrent+5]=this.rb_row
this.Control[iCurrent+6]=this.rb_rate
this.Control[iCurrent+7]=this.dw_rateselection
this.Control[iCurrent+8]=this.gb_1
end on

on w_rate_selection.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_newquery)
destroy(this.mle_message)
destroy(this.rb_row)
destroy(this.rb_rate)
destroy(this.dw_rateselection)
destroy(this.gb_1)
end on

event open;call super::open;String	ls_MleText
Long		ll_RowCount
Long		ll_CurrentRow

n_ds			lds_Temp
n_cst_Rate_Attribs	lnv_RateAttribs

ib_disableCloseQuery = TRUE

ll_CurrentRow = lnv_RateAttribs.of_GetCurrentRow ( )

lds_Temp = lnv_RateAttribs.of_GetDataStore()

IF ss_RadioButtonChecked = "ROW" THEN
	rb_row.Checked = TRUE
ELSE
	rb_rate.Checked = TRUE
END IF

IF isValid ( lds_Temp ) THEN
	lds_Temp.RowsCopy ( 1 , lds_Temp.RowCount ( ) , Primary!, dw_rateselection, dw_rateselection.rowCount( ) + 1 , PRIMARY! )
	dw_RateSelection.SelectRow ( 0, FALSE ) // deselect all rows
	IF ll_CurrentRow > 0 THEN
		dw_RateSelection.SelectRow ( ll_CurrentRow, TRUE ) //HighLight The selected Row
		dw_RateSelection.ScrollToRow ( ll_CurrentRow )
	END IF
END IF

ls_mleText ="Please verify that the highlighted row contains the information you want to paste. " &
	+"If you do not see the desired information click the NEW QUERY button to perform a new search."

mle_Message.Text = ls_MleText
end event

type cb_help from w_response`cb_help within w_rate_selection
end type

type cb_ok from u_cb within w_rate_selection
integer x = 1083
integer y = 828
integer taborder = 20
boolean bringtotop = true
string text = "OK"
boolean default = true
end type

event clicked;IF dw_rateselection.RowCount ( ) > 0 THEN

	IF NOT  dw_rateselection.GetSelectedRow(0) > 0 THEN
		MessageBox ( "Rate Selection" , "Please Select a Row." )
	ELSE
		event ue_Paste ( )
	END IF
	
ELSE
	cb_cancel.Event Clicked ( )
END IF
end event

type cb_cancel from u_cb within w_rate_selection
integer x = 1463
integer y = 828
integer taborder = 30
boolean bringtotop = true
string text = "Cancel"
boolean cancel = true
end type

event clicked;n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = "FALSE"
lnv_Msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( PARENT, lnv_Msg )
end event

type cb_newquery from u_cb within w_rate_selection
integer x = 1847
integer y = 828
integer width = 379
integer taborder = 40
boolean bringtotop = true
string text = "New &Query"
end type

event clicked;n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = "QUERY"
lnv_Msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( PARENT, lnv_Msg )
end event

type mle_message from u_mle within w_rate_selection
integer x = 14
integer y = 12
integer width = 2034
integer height = 216
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean displayonly = true
end type

type rb_row from u_rb within w_rate_selection
integer x = 2158
integer y = 72
integer width = 503
boolean bringtotop = true
string text = "Paste &Entire Row"
end type

event clicked;ss_RadioButtonChecked = "ROW"
end event

type rb_rate from u_rb within w_rate_selection
integer x = 2158
integer y = 136
integer width = 512
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
string text = "Only Paste &Rate"
boolean checked = true
end type

event clicked;ss_RadioButtonChecked = "RATE"
end event

type dw_rateselection from u_dw within w_rate_selection
integer x = 14
integer y = 256
integer width = 3287
integer height = 544
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_itemselection"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;of_SetAutoSort ( TRUE )
THIS.of_SetRowSelect ( TRUE ) 
ib_rmbmenu = FALSE

n_cst_presentation_RateTable 	lnv_Presentation 
lnv_Presentation.of_SetPresentation ( THIS )


end event

event rowfocuschanged;call super::rowfocuschanged;n_cst_Rate_Attribs	lnv_Rate_Attribs

lnv_Rate_Attribs.of_SetCurrentRow ( currentrow )
end event

event doubleclicked;IF row > 0 THEN
	THIS.Event RowFocusChanged ( row )
	Event ue_Paste ( )
END IF
end event

type gb_1 from groupbox within w_rate_selection
integer x = 2121
integer y = 4
integer width = 571
integer height = 228
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

