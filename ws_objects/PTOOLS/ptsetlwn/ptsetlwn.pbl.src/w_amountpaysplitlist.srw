$PBExportHeader$w_amountpaysplitlist.srw
forward
global type w_amountpaysplitlist from w_response
end type
type dw_1 from u_dw_amountpaysplitlist within w_amountpaysplitlist
end type
type dw_2 from datawindow within w_amountpaysplitlist
end type
type dw_remainder from datawindow within w_amountpaysplitlist
end type
type cb_1 from u_cbok within w_amountpaysplitlist
end type
type cb_2 from u_cbcancel within w_amountpaysplitlist
end type
type cb_3 from commandbutton within w_amountpaysplitlist
end type
end forward

global type w_amountpaysplitlist from w_response
int Width=3209
int Height=1472
boolean TitleBar=true
string Title="Amount Splits"
dw_1 dw_1
dw_2 dw_2
dw_remainder dw_remainder
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_amountpaysplitlist w_amountpaysplitlist

type variables
Long	il_AmountID
Long	il_EventID
end variables

forward prototypes
public function integer wf_highlightevent ()
public function integer wf_updateremainder ()
end prototypes

public function integer wf_highlightevent ();String 	ls_ModString 

ls_ModString ="disp_events_de_id.Color='0 ~tIf(disp_events_de_id=" +String ( il_EventID )+",255,0)'"

dw_1.Modify ( ls_ModString ) 

RETURN 1
end function

public function integer wf_updateremainder ();Dec	lc_Total
Dec	lc_Remainder

IF dw_2.RowCount ( ) > 0 THEN
	lc_Total = dw_2.object.amount[1]
	lc_Remainder = lc_Total - dw_1.Object.cf_sum[1]
	dw_Remainder.object.remainder [1] = lc_Remainder
END IF
RETURN 1
end function

on w_amountpaysplitlist.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_remainder=create dw_remainder
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_remainder
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
end on

on w_amountpaysplitlist.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_remainder)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

lnv_Msg = Message.PowerObjectParm 

IF lnv_Msg.of_Get_Parm ( "AMOUNTID" , lstr_Parm ) <> 0 THEN
	il_AmountID = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "EVENTID" , lstr_Parm ) <> 0 THEN
	il_EventID = lstr_Parm.ia_Value
END IF

dw_2.SetTransObject ( SQLCA )

dw_1.SetRedraw (FALSE)
dw_2.SetRedraw (FALSE)

dw_1.Retrieve () 
dw_2.Retrieve () 

dw_1.SetFilter ( "paysplit_amountid = " + string ( il_AmountId) ) 
dw_2.SetFilter ( "id = " + string ( il_AmountId) ) 
dw_1.Filter ( )
dw_2.Filter ( )

dw_1.SetRedraw ( TRUE )
dw_2.SetRedraw ( TRUE )

dw_Remainder.InsertRow ( 0 )
THIS.wf_UpdateRemainder ( )



end event

event pfc_postopen;THIS.wf_HighlightEvent ( )
end event

event pfc_cancel;call super::pfc_cancel;ib_DisableCloseQuery = TRUE
close ( THIS )
end event

event pfc_default;Boolean 	lb_Close = TRUE

IF dw_Remainder.object.remainder [1] > 0 THEN
	IF MessageBox ( "Amount Splits" , "There is still is a remainder. Do you still want to close the window?" , QUESTION!, YESNO! ,2) = 2 THEN
		lb_Close = FALSE
	END IF
END IF
	
IF lb_Close THEN
	close ( THIS )
END IF
end event

type dw_1 from u_dw_amountpaysplitlist within w_amountpaysplitlist
int X=37
int Y=276
int Width=3131
int Height=884
int TabOrder=10
boolean BringToTop=true
boolean HScrollBar=true
end type

event itemchanged;call super::itemchanged;
CHOOSE CASE dwo.name
		
	CASE "paysplit_paysplit"
		Post wf_UpdateRemainder (  ) 		
		
END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;long	ll_CurrentAmountID

ll_CurrentAmountID = THIS.Object.paysplit_AmountID [ currentRow ]

dw_2.SetFilter ( "id = " + string ( ll_CurrentAmountID) ) 
dw_2.Filter ( )
end event

type dw_2 from datawindow within w_amountpaysplitlist
int X=37
int Y=32
int Width=3131
int Height=204
boolean Enabled=false
boolean BringToTop=true
string DataObject="d_amountlistheader"
boolean Border=false
boolean LiveScroll=true
end type

type dw_remainder from datawindow within w_amountpaysplitlist
int X=2715
int Y=1180
int Width=411
int Height=88
boolean BringToTop=true
string DataObject="d_amountowedremainder"
boolean Border=false
boolean LiveScroll=true
end type

type cb_1 from u_cbok within w_amountpaysplitlist
int X=1198
int Y=1264
int Width=329
int TabOrder=20
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_amountpaysplitlist
int X=1591
int Y=1264
int Width=329
int TabOrder=30
boolean BringToTop=true
end type

type cb_3 from commandbutton within w_amountpaysplitlist
int X=2176
int Y=1188
int Width=539
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="&Assign Reminder"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long	ll_SelectedRow

ll_SelectedRow	= dw_1.GetRow ( )

IF ll_SelectedRow > 0 THEN
	
	dw_1.SetItem ( ll_SelectedRow, "paysplit_paySplit" , dw_1.object.paysplit_paysplit [ ll_SelectedRow ] + dw_Remainder.object.remainder [1] )
//	dw_1.object.paysplit_paysplit [ ll_SelectedRow ] = dw_1.object.paysplit_paysplit [ ll_SelectedRow ] + dw_Remainder.object.remainder [1]
	
	
	wf_UpdateRemainder ( )
END IF
end event

