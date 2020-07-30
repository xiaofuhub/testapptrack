$PBExportHeader$w_revenuemanager.srw
$PBExportComments$TransactionManager (Window from PBL map PTSetl) //@(*)[79252215|1558]
forward
global type w_revenuemanager from w_response
end type
type dw_list from u_dw within w_revenuemanager
end type
type dw_controltotal from datawindow within w_revenuemanager
end type
type cb_cancel from u_cbcancel within w_revenuemanager
end type
type cb_ok from u_cbok within w_revenuemanager
end type
type cb_calc from commandbutton within w_revenuemanager
end type
type cb_up from u_cb within w_revenuemanager
end type
type cb_dwn from u_cb within w_revenuemanager
end type
type cb_top from u_cb within w_revenuemanager
end type
type cb_btm from u_cb within w_revenuemanager
end type
type gb_1 from groupbox within w_revenuemanager
end type
type cb_cut from commandbutton within w_revenuemanager
end type
type cb_paste from commandbutton within w_revenuemanager
end type
type cb_3 from commandbutton within w_revenuemanager
end type
end forward

global type w_revenuemanager from w_response
integer x = 283
integer y = 576
integer width = 3077
integer height = 1344
string title = "Manage Revenue Splits"
dw_list dw_list
dw_controltotal dw_controltotal
cb_cancel cb_cancel
cb_ok cb_ok
cb_calc cb_calc
cb_up cb_up
cb_dwn cb_dwn
cb_top cb_top
cb_btm cb_btm
gb_1 gb_1
cb_cut cb_cut
cb_paste cb_paste
cb_3 cb_3
end type
global w_revenuemanager w_revenuemanager

type variables
private:
n_cst_Bso_Dispatch	inv_Dispatch
Integer			ii_CurrentColumn
long			il_CurrentRow	
decimal			ic_TotalFreight
decimal			ic_TotalAccess
decimal			ic_MoveAmount
decimal			ic_ReplacedAmount


end variables

forward prototypes
private subroutine wf_loadevents ()
private subroutine wf_recalctotal ()
private subroutine wf_updatesplits ()
private subroutine wf_moveamount (string as_direction)
private subroutine wf_clearsplits ()
end prototypes

private subroutine wf_loadevents ();long	ll_RowCount, &
		ll_row, &
		ll_NewRow
	
decimal	lc_FreightSplit, &
			lc_AccessSplit, &
			lc_TotalFreight, &
			lc_TotalAccess
			
n_ds	lds_EventCache

lds_EventCache = inv_Dispatch.of_GetEventCache ( )
ll_RowCount = lds_EventCache.RowCount()	

FOR ll_row = 1 to ll_RowCount
	
	ll_NewRow = dw_list.InsertRow(0)
	dw_list.object.de_id[ll_NewRow] = lds_EventCache.object.de_id[ll_row]
	dw_list.object.de_event_type[ll_NewRow] = lds_EventCache.object.de_event_type[ll_row]
	dw_list.object.co_name[ll_NewRow] = lds_EventCache.object.co_name[ll_row]
	dw_list.object.leg_miles[ll_NewRow] = lds_EventCache.object.leg_miles[ll_row]
	
	lc_FreightSplit = lds_EventCache.object.de_freightsplit[ll_row]
	IF isnull(lc_FreightSplit) THEN
		lc_FreightSplit = 0
	END IF
	
	lc_AccessSplit = lds_EventCache.object.de_accesssplit[ll_row]
	IF isnull(lc_AccessSplit) THEN
		lc_AccessSplit = 0
	END IF
	
	dw_list.object.de_freightsplit[ll_NewRow] = lc_FreightSplit
	dw_list.object.de_accesssplit[ll_NewRow] = lc_AccessSplit
	
	lc_TotalFreight += lc_FreightSplit
	lc_TotalAccess += lc_AccessSplit
	
NEXT

IF ll_RowCount > 0 THEN
	
	ll_NewRow = dw_ControlTotal.InsertRow(0)
	dw_ControlTotal.Object.Total_Freight_Revenue[ll_NewRow] = ic_TotalFreight
	dw_controltotal.Object.Total_Access_Revenue[ll_NewRow] = ic_TotalAccess
	dw_ControlTotal.Object.Disbursed_Freight_Revenue[ll_NewRow] = lc_TotalFreight
	dw_controltotal.Object.Disbursed_Access_Revenue[ll_NewRow] = lc_TotalAccess
	
END IF

dw_list.SetColumn("de_freightsplit")
dw_list.SetRow(1)
dw_list.Setfocus()

end subroutine

private subroutine wf_recalctotal ();long	ll_RowCount, &
		ll_row, &
		ll_NewRow
	
decimal	lc_FreightSplit, &
			lc_AccessSplit, &
			lc_DisbursedFreight, &
			lc_DisbursedAccess
			
ll_RowCount = dw_list.RowCount()	

FOR ll_row = 1 to ll_RowCount
	
	lc_FreightSplit = dw_list.object.de_freightsplit[ll_row]
	lc_AccessSplit = dw_list.object.de_accesssplit[ll_row]
	lc_DisbursedFreight += lc_FreightSplit
	lc_DisbursedAccess += lc_AccessSplit
	
NEXT

dw_ControlTotal.Object.Disbursed_Freight_Revenue[1] = lc_DisbursedFreight
dw_controltotal.Object.Disbursed_Access_Revenue[1] = lc_DisbursedAccess

end subroutine

private subroutine wf_updatesplits ();long	ll_RowCount, &
		ll_Row, &
		ll_EventId, &
		ll_FoundRow
		
decimal	lc_Amount

string	ls_FindString

n_ds	lds_EventCache

lds_EventCache = inv_Dispatch.of_GetEventCache ( )

ll_RowCount = dw_list.RowCount()	

FOR ll_Row = 1 to ll_RowCount
	
	ll_EventId = dw_list.Object.de_id[ll_Row]
	ls_FindString = "de_id = " + string ( ll_EventId ) 
	ll_FoundRow = lds_EventCache.Find ( ls_FindString, 1, ll_RowCount )
	IF ll_FoundRow > 0 THEN
		
		lc_Amount = dw_list.Object.de_freightsplit[ll_Row]
		IF lc_Amount = 0 THEN
			setnull(lc_Amount)
		END IF
		lds_EventCache.Object.de_freightsplit[ll_foundRow] = lc_Amount
		
		lc_Amount = dw_list.Object.de_accesssplit[ll_Row]
		IF lc_Amount = 0 THEN
			setnull(lc_Amount)
		END IF
		lds_EventCache.Object.de_accesssplit[ll_foundRow] = lc_Amount
		
	END IF
				
NEXT

end subroutine

private subroutine wf_moveamount (string as_direction);string	ls_ColumnName

long		ll_MoveRow

ii_CurrentColumn = 0
il_CurrentRow = 0
ic_MoveAmount = 0
ic_ReplacedAmount = 0

ii_CurrentColumn = dw_list.GetColumn()
il_CurrentRow = dw_list.GetRow()

IF ii_CurrentColumn > 0 THEN

	choose case upper(as_direction)
			
		case "UP"
			IF il_CurrentRow = 1 THEN
				//can't move
				ll_MoveRow = 0
			ELSE
				ll_MoveRow = il_CurrentRow - 1
			END IF
			
		case "DWN"
			IF il_CurrentRow = dw_list.RowCount() THEN
				//can't move
				ll_MoveRow = 0
			ELSE
				ll_MoveRow = il_CurrentRow + 1	
			END IF
			
		case "TOP"
			ll_MoveRow = 1
			
		case "BTM"
			ll_MoveRow = dw_list.RowCount()
			
	end choose
	
	IF ll_MoveRow > 0 THEN
		ls_ColumnName = dw_list.GetColumnName ( )	
		ic_MoveAmount = dw_list.GetItemDecimal(il_CurrentRow, ls_ColumnName)
		dw_list.SetItem(il_CurrentRow, ls_ColumnName, 0)
		ic_ReplacedAmount = dw_list.GetItemDecimal(ll_MoveRow , ls_ColumnName)
		dw_list.SetItem(ll_MoveRow, ii_CurrentColumn, ic_MoveAmount)
		dw_list.SetRow(ll_MoveRow)

	END IF
	
END IF
wf_RecalcTotal()

dw_list.SetFocus()


end subroutine

private subroutine wf_clearsplits ();long	ll_RowCount, &
		ll_row
	
ll_RowCount = dw_list.RowCount()	

FOR ll_row = 1 to ll_RowCount
	
	dw_list.object.de_freightsplit[ll_row] = 0
	dw_list.object.de_accesssplit[ll_row] = 0

NEXT

dw_ControlTotal.Object.Total_Freight_Revenue[1] = ic_TotalFreight
dw_controltotal.Object.Total_Access_Revenue[1] = ic_TotalAccess
dw_ControlTotal.Object.Disbursed_Freight_Revenue[1] = 0
dw_controltotal.Object.Disbursed_Access_Revenue[1] = 0

dw_list.SetColumn("de_freightsplit")
dw_list.SetRow(1)
dw_list.Setfocus()

end subroutine

on w_revenuemanager.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_controltotal=create dw_controltotal
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_calc=create cb_calc
this.cb_up=create cb_up
this.cb_dwn=create cb_dwn
this.cb_top=create cb_top
this.cb_btm=create cb_btm
this.gb_1=create gb_1
this.cb_cut=create cb_cut
this.cb_paste=create cb_paste
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_controltotal
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_calc
this.Control[iCurrent+6]=this.cb_up
this.Control[iCurrent+7]=this.cb_dwn
this.Control[iCurrent+8]=this.cb_top
this.Control[iCurrent+9]=this.cb_btm
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.cb_cut
this.Control[iCurrent+12]=this.cb_paste
this.Control[iCurrent+13]=this.cb_3
end on

on w_revenuemanager.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_controltotal)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_calc)
destroy(this.cb_up)
destroy(this.cb_dwn)
destroy(this.cb_top)
destroy(this.cb_btm)
destroy(this.gb_1)
destroy(this.cb_cut)
destroy(this.cb_paste)
destroy(this.cb_3)
end on

event open;call super::open;n_cst_msg	lnv_msg
s_parm		lstr_Parm
n_cst_privsmanager	lnv_manager

lnv_msg = message.powerobjectParm

ib_DisableCloseQuery = TRUE

IF isValid ( lnv_msg ) THEN
	//dispatch object should already be filtered by the correct shipmentid 
	IF lnv_Msg.of_Get_Parm ( "DISPATCHOBJECT" , lstr_Parm ) <> 0 THEN
		inv_Dispatch = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "FREIGHT" , lstr_Parm ) <> 0 THEN
		ic_TotalFreight = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "ACCESSORIAL" , lstr_Parm ) <> 0 THEN
		ic_TotalAccess = lstr_Parm.ia_Value
	END IF

	this.Event Post pfc_open( )
	
ELSE
	messageBox ( "Revenue Manager" , "An error occurred while attempting to open the window.~r~nRequest Cancelled.", EXCLAMATION! ) 
	ib_DisableCloseQuery = TRUE
	close ( THIS ) 
END IF

//ADDED BY DAN 1-30-07
lnv_manager = gnv_app.of_getPrivsmanager( )
IF lnv_manager.of_getUserpermissionfromfn( "View Charges" ) <> 1 THEN
	Messagebox("Manage Revenue Splits", "You do not have permission to view this window.")
	close(this)
END IF
////////////////////
end event

event pfc_cancel;call super::pfc_cancel;close(this)
end event

event pfc_postopen;this.wf_LoadEvents()
end event

event pfc_default;decimal	lc_Freight, &
			lc_Access
			
lc_Freight = dw_controltotal.object.remaining_freight_revenue[1]		
lc_Access = dw_controltotal.object.remaining_access_revenue[1]

IF lc_Freight = 0 AND lc_Access = 0 THEN

	this.wf_UpdateSplits()
	
ELSE
	
	choose case	messagebox("Revenue Manager", "There is still a remainder. " + &
							"Do you still want to close.", Question!, YesNo!)
		case 1
				this.wf_UpdateSplits()
		case 2
			return
	
	end choose
	
END IF

close(this)



end event

type cb_help from w_response`cb_help within w_revenuemanager
end type

type dw_list from u_dw within w_revenuemanager
integer x = 23
integer y = 20
integer width = 2395
integer height = 1120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_eventrevenue"
end type

event itemchanged;call super::itemchanged;string	ls_Column
ls_Column = dwo.Name

CHOOSE CASE dwo.Name
		
	CASE "de_freightsplit", "de_accesssplit"
		post wf_RecalcTotal()
		
		
END CHOOSE
end event

event constructor;n_cst_Dws		lnv_Dws
n_cst_Events	lnv_Events

//lnv_Dws.of_CreateHighlight ( This )

This.Modify ( "de_event_type.Edit.CodeTable = Yes "+&
	"de_event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
end event

type dw_controltotal from datawindow within w_revenuemanager
integer x = 23
integer y = 1152
integer width = 2395
integer height = 96
boolean bringtotop = true
string dataobject = "d_revenue"
boolean border = false
boolean livescroll = true
end type

type cb_cancel from u_cbcancel within w_revenuemanager
integer x = 2551
integer y = 152
integer width = 379
integer taborder = 30
boolean bringtotop = true
end type

type cb_ok from u_cbok within w_revenuemanager
integer x = 2551
integer y = 40
integer width = 379
integer taborder = 20
boolean bringtotop = true
boolean default = false
end type

type cb_calc from commandbutton within w_revenuemanager
integer x = 2551
integer y = 260
integer width = 379
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Clear &Splits"
end type

event clicked;wf_ClearSplits()
end event

type cb_up from u_cb within w_revenuemanager
integer x = 2551
integer y = 632
integer width = 169
integer taborder = 50
boolean bringtotop = true
string text = "&Up"
end type

event clicked;wf_MoveAmount("UP")

end event

type cb_dwn from u_cb within w_revenuemanager
integer x = 2551
integer y = 740
integer width = 169
integer taborder = 60
boolean bringtotop = true
string text = "&Dwn"
end type

event clicked;wf_MoveAmount("DWN")

end event

type cb_top from u_cb within w_revenuemanager
integer x = 2761
integer y = 632
integer width = 169
integer taborder = 70
boolean bringtotop = true
string text = "&Top"
end type

event clicked;wf_MoveAmount("TOP")

end event

type cb_btm from u_cb within w_revenuemanager
integer x = 2761
integer y = 740
integer width = 169
integer taborder = 80
boolean bringtotop = true
string text = "&Btm"
end type

event clicked;wf_MoveAmount("BTM")

end event

type gb_1 from groupbox within w_revenuemanager
integer x = 2469
integer y = 544
integer width = 544
integer height = 324
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Move Amount"
end type

type cb_cut from commandbutton within w_revenuemanager
integer x = 2469
integer y = 904
integer width = 247
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cut"
end type

event clicked;string	ls_ColumnName

ii_CurrentColumn = 0
il_CurrentRow = 0
ic_MoveAmount = 0
ic_ReplacedAmount = 0

ii_CurrentColumn = dw_list.GetColumn()
il_CurrentRow = dw_list.GetRow()
IF ii_CurrentColumn > 0 THEN
	
	ls_ColumnName = dw_list.GetColumnName()
	ic_MoveAmount = dw_list.GetItemDecimal(il_CurrentRow, ls_ColumnName)
	dw_list.SetItem(il_CurrentRow, ls_ColumnName, 0)

END IF

wf_RecalcTotal()
dw_list.SetFocus()

end event

type cb_paste from commandbutton within w_revenuemanager
integer x = 2766
integer y = 904
integer width = 247
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Paste"
end type

event clicked;IF ii_CurrentColumn > 0 THEN
	
	IF dw_list.GetRow() <> il_CurrentRow THEN
		dw_list.SetItem(dw_list.GetRow(), dw_list.GetColumnName(), ic_moveamount)
	END IF
	
ELSE
	messagebox("Switch Amount", &
	"You must cut the amount to be paseted.", Information!)
	
END IF

ii_CurrentColumn = 0
il_CurrentRow = 0
ic_MoveAmount = 0
ic_ReplacedAmount = 0

wf_RecalcTotal()
dw_list.SetFocus()


end event

type cb_3 from commandbutton within w_revenuemanager
integer x = 2469
integer y = 1024
integer width = 544
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Paste &Remainder"
end type

event clicked;string	ls_ColumnName
decimal	lc_Remainder, &
			lc_Amount

ii_CurrentColumn = 0
il_CurrentRow = 0
ic_MoveAmount = 0
ic_ReplacedAmount = 0

ii_CurrentColumn = dw_list.GetColumn()
il_CurrentRow = dw_list.GetRow()
IF ii_CurrentColumn > 0 THEN
	
	ls_ColumnName = dw_list.GetColumnName()
	choose case ls_ColumnName
		case "de_freightsplit"
			lc_Remainder = dw_controltotal.object.remaining_freight_revenue[1]
		case "de_accesssplit"
			lc_Remainder = dw_controltotal.object.remaining_access_revenue[1]
	end choose
	
	lc_Amount = dw_list.GetItemDecimal(il_CurrentRow, ls_ColumnName)
	lc_Amount += lc_remainder
	dw_list.SetItem(il_CurrentRow, ls_ColumnName, lc_Amount)

END IF

wf_RecalcTotal()
dw_list.SetFocus()

end event

