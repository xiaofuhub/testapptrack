$PBExportHeader$w_autoreposequipmentinput.srw
forward
global type w_autoreposequipmentinput from w_response
end type
type st_1 from statictext within w_autoreposequipmentinput
end type
type cb_insertrow from commandbutton within w_autoreposequipmentinput
end type
type cb_deleterow from commandbutton within w_autoreposequipmentinput
end type
type cb_ok from u_cbok within w_autoreposequipmentinput
end type
type cb_cancel from u_cbcancel within w_autoreposequipmentinput
end type
type dw_1 from u_dw within w_autoreposequipmentinput
end type
end forward

global type w_autoreposequipmentinput from w_response
integer x = 214
integer y = 221
integer width = 1326
integer height = 1584
string title = "Input Screen for Auto Route Repos"
event ue_ok ( )
st_1 st_1
cb_insertrow cb_insertrow
cb_deleterow cb_deleterow
cb_ok cb_ok
cb_cancel cb_cancel
dw_1 dw_1
end type
global w_autoreposequipmentinput w_autoreposequipmentinput

type variables
Private:
Constant  String cs_MsgHdr = "Auto Route Repos"


end variables

forward prototypes
public function string wf_parsealphanumeric (string as_value)
public subroutine wf_turndefaulttext ()
public subroutine wf_turnredboldtext ()
end prototypes

event ue_ok();Int li_Ctr
Int li_Ctr1
Int li_Ctr2
Int li_Return = 1
Int li_MsgReturn
Long ll_RowCount
Long lla_ShipmentId[]
Long ll_ShipmentVal
Long ll_UpperBound1
Long ll_UpperBound2

String ls_Value
String lsa_EquipNum[]
String ls_ErrMsg

n_cst_msg lnv_msg
s_parm lstr_Parm

IF dw_1.AcceptText() <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ll_RowCount = dw_1.RowCount()
	
	IF ll_RowCount > 0 THEN
		FOR li_Ctr = 1 TO ll_RowCount
			ls_Value = Trim(dw_1.Object.equipmentnum[li_Ctr])
			IF IsNull(ls_Value) OR LEN(ls_Value) = 0 THEN
				Continue
			ELSE
				li_Ctr1++
				lsa_EquipNum[li_Ctr1] = ls_Value
				li_Ctr2++
				ll_ShipmentVal =  dw_1.Object.shipmentid[li_Ctr]
				lla_ShipmentId[li_Ctr2] = ll_ShipmentVal
			END IF
		NEXT
	ELSE
		MessageBox(cs_MsgHdr,'Equipment Id List Empty')		
	END IF	
END IF		
	
IF UpperBound(lsa_EquipNum) <= 0 THEN
	li_Return = -1 
END IF

IF li_Return = 1 THEN
	// Shrink and get duplicates & null free arrays
	n_cst_AnyArraySrv lnv_ArraySrv
	lnv_ArraySrv.of_Getshrinked(lla_ShipmentId,TRUE,TRUE)
	lnv_ArraySrv.of_Getshrinked(lsa_EquipNum,TRUE,TRUE)
		
	ll_UpperBound1 = UpperBound(lsa_EquipNum)
	ll_UpperBound2 = UpperBound(lla_ShipmentId)
		
	IF ll_UpperBound1 <> ll_UpperBound2 THEN
		ls_ErrMsg = "Do you want to rectify errors for Equipment marked in RED?"
		li_MsgReturn = MessageBox(cs_MsgHdr,ls_ErrMsg,Question!,YesNo!,1)
		IF li_MsgReturn = 1 THEN 	
			li_Return = -1 
		END IF		
	END IF
END IF

IF	li_Return = 1  THEN
	IF UpperBound(lla_ShipmentId) > 0 THEN
		lstr_parm.is_label = "SHIPMENTID"
		lstr_Parm.ia_Value = lla_ShipmentId
		lnv_msg.of_add_parm(lstr_parm)
		CloseWithReturn(This,lnv_msg)
	ELSE
		MessageBox(cs_MsgHdr,"Shipment Id list Empty. Cannot Route Repos")
	END IF	
ELSE
	wf_turndefaulttext()
	dw_1.SetFocus()
END IF
end event

public function string wf_parsealphanumeric (string as_value);Int li_Ctr
Long ll_TotLen
Char lc_Char
String ls_Value
String ls_NewValue

ls_Value = Trim(as_value)

ll_TotLen = Len(ls_Value)

FOR li_Ctr = 1 TO ll_TotLen
	lc_Char = Mid(ls_Value,li_Ctr,1)
	IF IsNumber(lc_Char) THEN
		Continue
	END IF
	ls_NewValue = ls_NewValue + lc_Char
NEXT 

Return ls_NewValue
end function

public subroutine wf_turndefaulttext ();String ls_mod_string

dw_1.Object.TurnRed[dw_1.GetRow()] = 0
ls_mod_string = "equipmentnum.Color='0~tIf(TurnRed=1,255,0)'"
dw_1.Modify(ls_mod_string)		
ls_mod_string = "equipmentnum.Font.Weight='0~tIf(TurnRed=1,700,400)'"
dw_1.Modify(ls_mod_string)
end subroutine

public subroutine wf_turnredboldtext ();String ls_mod_string

dw_1.Object.TurnRed[dw_1.GetRow()] = 1
ls_mod_string = "equipmentnum.Color='0~tIf(TurnRed=1,255,0)'"
dw_1.Modify(ls_mod_string)		
ls_mod_string = "equipmentnum.Font.Weight='0~tIf(TurnRed=1,700,400)'"
dw_1.Modify(ls_mod_string)


end subroutine

on w_autoreposequipmentinput.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_insertrow=create cb_insertrow
this.cb_deleterow=create cb_deleterow
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_insertrow
this.Control[iCurrent+3]=this.cb_deleterow
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.dw_1
end on

on w_autoreposequipmentinput.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_insertrow)
destroy(this.cb_deleterow)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_1)
end on

event open;call super::open;ib_disableclosequery = TRUE
ib_isUpdateable = False

of_SetBase(True)
inv_base.of_center()
end event

event pfc_default;call super::pfc_default;event ue_ok( )
end event

event pfc_cancel;call super::pfc_cancel;Close(This)
end event

type st_1 from statictext within w_autoreposequipmentinput
integer x = 41
integer y = 12
integer width = 1221
integer height = 136
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_insertrow from commandbutton within w_autoreposequipmentinput
integer x = 818
integer y = 216
integer width = 375
integer height = 116
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Insert Row"
end type

event clicked;st_1.text = ""
dw_1.SetRow(dw_1.InsertRow(0))
dw_1.SetFocus()
end event

type cb_deleterow from commandbutton within w_autoreposequipmentinput
integer x = 818
integer y = 376
integer width = 375
integer height = 116
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Delete Row"
end type

event clicked;st_1.text = ""
dw_1.DeleteRow(dw_1.GetRow())
dw_1.SetFocus()
end event

type cb_ok from u_cbok within w_autoreposequipmentinput
integer x = 818
integer y = 536
integer width = 375
integer height = 112
integer taborder = 40
integer weight = 400
fontcharset fontcharset = ansi!
boolean default = false
end type

type cb_cancel from u_cbcancel within w_autoreposequipmentinput
integer x = 818
integer y = 696
integer width = 375
integer height = 112
integer taborder = 50
integer weight = 400
fontcharset fontcharset = ansi!
end type

type dw_1 from u_dw within w_autoreposequipmentinput
integer x = 50
integer y = 208
integer width = 658
integer height = 1216
integer taborder = 10
string dataobject = "d_equipmentlist"
boolean ib_ofrinserting = true
end type

event constructor;call super::constructor;ib_rmbmenu = FALSE
This.InsertRow(0)


end event

event itemchanged;call super::itemchanged;Int li_Return = 1
Int li_Found
Long ll_Row
Long ll_RowCount
Long ll_Shipmentid
String ls_Value
String ls_NewValue
String ls_Status
String ls_mod_string
Boolean lb_Copy

li_Found = This.Find("equipmentnum ='" +  Trim(data) + "'" ,1,This.RowCount())

IF li_Found > 0 THEN 
	st_1.Text = 'Duplicate Equipment: ' + data + '.'
	This.Object.equipmentnum[row] = ""
	li_Return = -1 
ELSE
	st_1.Text = ""
END IF

IF li_Return = 1 THEN
	SELECT oe.shipment,e.eq_Status
	INTO :ll_Shipmentid, :ls_Status
	FROM outside_equip OE,equipment E
	WHERE E.eq_ref  = :data
	AND oe.oe_id = e.eq_id
	AND E.eq_Status = 'K';
	Commit;
	
	IF IsNull(ll_Shipmentid) OR ll_Shipmentid = 0  THEN
		st_1.Text = 'Shipment not linked for Equipment: ' + data
		wf_turnredboldtext( )
		lb_Copy 		= FALSE
	ELSE		
		wf_turndefaulttext( )
		This.Object.ShipmentId[Row] = ll_Shipmentid
		lb_Copy 		= TRUE
	END IF
	
	ll_RowCount	= This.RowCount()
	ls_Value		= THIS.Object.Equipmentnum[ll_RowCount]
		
	IF This.GetRow() = (ll_RowCount - 1) AND (IsNull(ls_Value) OR Len(ls_Value) = 0 ) THEN
	ELSE
		ll_Row = This.InsertRow(0)
		This.Scrolltorow(ll_Row)
//		ls_NewValue = wf_ParseAlphaNumeric(Data) // Commented for timebeing.
		IF Not IsNumber(ls_NewValue) AND lb_copy THEN
			This.SetItem(ll_Row,"equipmentnum",ls_NewValue)
		END IF
	END IF
END IF
end event

