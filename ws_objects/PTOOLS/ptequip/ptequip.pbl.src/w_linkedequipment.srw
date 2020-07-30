$PBExportHeader$w_linkedequipment.srw
forward
global type w_linkedequipment from w_response
end type
type dw_1 from u_dw_eqlist within w_linkedequipment
end type
type cb_1 from commandbutton within w_linkedequipment
end type
type cb_2 from commandbutton within w_linkedequipment
end type
type cb_3 from commandbutton within w_linkedequipment
end type
end forward

global type w_linkedequipment from w_response
integer x = 1010
integer y = 788
integer width = 1943
integer height = 624
string title = "Linked Equipment"
event type integer ue_details ( readonly long al_row )
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_linkedequipment w_linkedequipment

type variables
Long	il_ShipmentID

n_cst_beo_shipment	inv_shipment
end variables

event type integer ue_details(readonly long al_row);SETPointer ( HOURGLASS! )
Long	ll_ID	
Long	ll_Row
w_eq_info   lw_eqwin
ll_Row = al_row

IF ll_ROW > 0 THEN
	ll_ID = dw_1.Object.eq_id [ ll_row ]
	IF ll_ID > 10000000 THEN
		n_cst_msg	lnv_msg
		s_parm		lstr_parm
		//changed 2-1-07 to open with lnv_msg
		lstr_parm.is_label = "ID"
		lstr_parm.ia_value = ll_id
		lnv_msg.of_add_parm( lstr_parm )
		
		//added by dan 2-1-07
		lstr_parm.is_label = "SHIPMENT"
		lstr_parm.ia_value = inv_shipment
		lnv_msg.of_add_parm( lstr_parm )
		/////////////////////
		//opensheetwithparm(lw_eqwin, ll_id , gnv_app.of_GetFrame ( ), 0, original!)
		opensheetwithparm(lw_eqwin, lnv_msg , gnv_app.of_GetFrame ( ), 0, original!)
		CLOSE ( THIS )
		RETURN 1
	ELSE
		MessageBox ( "Equipment Details" , "Please save the shipment before viewing equipment details." )
	END IF
//	OpenWithParm ( w_eq_info , ll_ID )
END IF

RETURN 1
end event

on w_linkedequipment.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
end on

on w_linkedequipment.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;n_cst_Msg	lnv_msg
S_Parm		lstr_parm
n_cst_bso_Dispatch	lnv_Dispatch

Boolean		lb_UseCache
Boolean		lb_Reloads

lnv_Msg = Message.PowerobjectParm 
ib_DisableCloseQuery = TRUE 

IF lnv_Msg.of_Get_Parm ( "SHIPMENT" , lstr_Parm ) <> 0 THEN
	il_ShipmentID = lstr_parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "RELOADS" , lstr_Parm ) <> 0 THEN
	lb_Reloads = lstr_parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "DISPATCH" , lstr_Parm ) <> 0 THEN
	lnv_Dispatch = lstr_parm.ia_Value
	lb_useCache = TRUE
END IF

/////////////ADDED BY DAN 2-1-07
IF lnv_Msg.of_Get_Parm ( "SHIPMENTBEO" , lstr_Parm ) <> 0 THEN
	inv_shipment = lstr_parm.ia_Value
END IF
////////////////////////////////

IF lb_UseCache THEN
	IF IsValid ( lnv_Dispatch ) THEN
		dw_1.of_CopyFromCache (  il_ShipmentID , lnv_Dispatch.of_GetEquipmentCache ( ) )	
	END IF
ELSE
	
	IF il_ShipmentID > 0 THEN
		IF NOT dw_1.of_RetrieveOnShipment( il_ShipmentID , lb_Reloads ) > -1 THEN
			MessageBox ("Linked Equipment" , "An error occurred while attempting to retrieve the equipment linked to the shipment." )
			CLOSE ( THIS )		
		END IF
	END IF
	
END IF	

end event

type cb_help from w_response`cb_help within w_linkedequipment
integer x = 1838
integer y = 476
end type

type dw_1 from u_dw_eqlist within w_linkedequipment
integer x = 32
integer y = 44
integer width = 1518
integer height = 400
integer taborder = 10
boolean bringtotop = true
end type

event doubleclicked;Parent.Event ue_Details ( dw_1.GetRow ( ) )

end event

type cb_1 from commandbutton within w_linkedequipment
integer x = 1586
integer y = 348
integer width = 297
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close ( PARENT  )
end event

type cb_2 from commandbutton within w_linkedequipment
integer x = 1586
integer y = 48
integer width = 297
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&New "
end type

event clicked;
n_cst_Msg	lnv_Msg
S_PArm		lstr_Parm
s_Eq_Info 	lstr_EqInfo


lstr_parm.is_Label = "SHIPMENT"
lstr_Parm.ia_Value = il_ShipmentID
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

lstr_EqInfo.eq_type ="34"
lstr_EqInfo.eq_id = 0

lstr_parm.is_Label = "EQSTRUCT"
lstr_Parm.ia_Value = lstr_EqInfo
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

//added by dan 2-26-07
lstr_parm.is_label = "SHIPMENTBEO"
lstr_parm.ia_value = inv_shipment
lnv_msg.of_add_parm( lstr_parm )
/////////////////////

OpenWithParm ( w_Eq_NewOut , lnv_Msg )

lstr_EqInfo = Message.PowerObjectParm 

IF lstr_EqInfo.eq_id > 0 THEN
	// eq created
	dw_1.of_RetrieveOnShipment ( il_ShipmentID )
END IF
	
	

end event

type cb_3 from commandbutton within w_linkedequipment
integer x = 1586
integer y = 160
integer width = 297
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Details"
end type

event clicked;PARENT.Event ue_Details ( dw_1.GetRow ( ) )


end event

