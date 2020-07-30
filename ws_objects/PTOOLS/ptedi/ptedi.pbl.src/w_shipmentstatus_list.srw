$PBExportHeader$w_shipmentstatus_list.srw
forward
global type w_shipmentstatus_list from w_popup
end type
type dw_list from u_dw_shipmentstatus_list within w_shipmentstatus_list
end type
type st_1 from statictext within w_shipmentstatus_list
end type
type cb_cancel from u_cbcancel within w_shipmentstatus_list
end type
end forward

global type w_shipmentstatus_list from w_popup
integer x = 219
integer y = 1328
integer width = 3209
integer height = 840
string title = "EDI Messages for Shipment"
dw_list dw_list
st_1 st_1
cb_cancel cb_cancel
end type
global w_shipmentstatus_list w_shipmentstatus_list

type variables
Long	il_EventID
n_cst_msg	inv_msg

n_cst_bso_ediManager	inv_EdiManager

end variables

on w_shipmentstatus_list.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.st_1=create st_1
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_shipmentstatus_list.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.st_1)
destroy(this.cb_cancel)
end on

event open;call super::open;S_Parm 	lstr_Parm
Long		ll_NewRow
n_ds		lds_cache
inv_msg = Message.PowerobjectParm
ib_DisableCloseQuery = TRUE

IF inv_Msg.of_Get_Parm ( "EDIMANAGER" , lstr_Parm ) <> 0 THEN
	inv_EDIManager = lstr_Parm.ia_Value
END IF

IF inv_Msg.of_Get_Parm ( "EVENTID" , lstr_Parm ) <> 0 THEN
	il_eventid = lstr_Parm.ia_Value
END IF

IF inv_Msg.of_Get_Parm ( "CACHE" , lstr_Parm ) <> 0 THEN
	lds_cache = lstr_Parm.ia_Value
END IF


IF IsValid ( inv_EdiManager ) THEN
	lds_cache.ShareData ( dw_list )
END IF

// This is here b/c it would interfere w/ the messageparm if it was in the constructor
dw_list.Event ue_SetFocusIndicator ( TRUE )

dw_List.of_GetChildren ( )

//IF il_shipid > 0 THEN
//	dw_List.of_FilterByShipment ( il_shipid )
//	THIS.Title += " " + String ( il_shipid )
//END IF


THIS.of_SetResize ( TRUE )
inv_Resize.of_Register ( dw_list , "ScaleToRight&Bottom" )
inv_Resize.of_Register ( cb_cancel , "FixedToRight&Bottom" )

end event

event pfc_default;CLOSE ( THIS )
end event

type dw_list from u_dw_shipmentstatus_list within w_shipmentstatus_list
integer x = 23
integer y = 96
integer width = 3118
integer taborder = 10
boolean bringtotop = true
end type

event doubleclicked;

IF ROW > 0 THEN
	

	inv_EdiManager.of_ShowDetails ( ROW, this.object.sourceid[row] ) 

	
END IF

	
end event

event constructor;call super::constructor;ib_RmbMenu = FALSE
end event

type st_1 from statictext within w_shipmentstatus_list
integer x = 50
integer y = 24
integer width = 613
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Double click for details"
boolean focusrectangle = false
end type

type cb_cancel from u_cbcancel within w_shipmentstatus_list
integer x = 1435
integer y = 620
integer width = 293
integer taborder = 20
boolean bringtotop = true
string text = "Close"
end type

event clicked;call super::clicked;Close ( PARENT )
end event

