$PBExportHeader$u_cst_splitid.sru
forward
global type u_cst_splitid from u_base
end type
type dw_id from datawindow within u_cst_splitid
end type
type cb_splits from u_cb within u_cst_splitid
end type
end forward

global type u_cst_splitid from u_base
integer width = 850
integer height = 88
long backcolor = 12632256
event ue_splitclicked ( )
event type integer ue_iddblclick ( )
dw_id dw_id
cb_splits cb_splits
end type
global u_cst_splitid u_cst_splitid

forward prototypes
public function integer of_setsplitsid (long al_id)
public function integer of_enable (boolean ab_Value)
public function long of_getsplitid ()
end prototypes

public function integer of_setsplitsid (long al_id);dw_id.object.Value [ 1 ] =  al_ID 
RETURN 1
end function

public function integer of_enable (boolean ab_Value);cb_splits.Enabled = ab_Value
RETURN 1
end function

public function long of_getsplitid ();RETURN dw_id.object.Value [1]
end function

on u_cst_splitid.create
int iCurrent
call super::create
this.dw_id=create dw_id
this.cb_splits=create cb_splits
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_id
this.Control[iCurrent+2]=this.cb_splits
end on

on u_cst_splitid.destroy
call super::destroy
destroy(this.dw_id)
destroy(this.cb_splits)
end on

type dw_id from datawindow within u_cst_splitid
integer x = 453
integer y = 4
integer width = 347
integer height = 76
integer taborder = 20
string title = "none"
string dataobject = "d_splitid"
boolean border = false
boolean livescroll = true
end type

event constructor;THIS.InsertRow( 0 )
end event

event doubleclicked;Parent.event ue_iddblclick( )
end event

type cb_splits from u_cb within u_cst_splitid
integer width = 430
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer weight = 400
string text = "&Split Billing"
end type

event clicked;//PARENT.wf_ManageSplits ( )
Parent.Event ue_SplitClicked ( )
end event

event constructor;//il_SplitsX = THIS.X
//il_SplitsY = THIS.y
end event

