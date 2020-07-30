$PBExportHeader$u_tabpg_shiptype_edit.sru
forward
global type u_tabpg_shiptype_edit from u_tabpg
end type
type dw_details from u_dw_shiptype_edit within u_tabpg_shiptype_edit
end type
end forward

global type u_tabpg_shiptype_edit from u_tabpg
integer width = 2825
integer height = 1200
event type integer ue_rowadded ( long al_row )
event ue_setredraw ( boolean ab_value )
event type long ue_getfirstrowonlistpage ( )
event ue_scrolllisttorow ( long al_row )
dw_details dw_details
end type
global u_tabpg_shiptype_edit u_tabpg_shiptype_edit

on u_tabpg_shiptype_edit.create
int iCurrent
call super::create
this.dw_details=create dw_details
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_details
end on

on u_tabpg_shiptype_edit.destroy
call super::destroy
destroy(this.dw_details)
end on

type dw_details from u_dw_shiptype_edit within u_tabpg_shiptype_edit
integer x = 174
integer y = 16
integer width = 2496
integer height = 1164
integer taborder = 11
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_rowadded;PArent.Event ue_RowAdded( al_row )
Return 1
end event

event ue_setredraw;call super::ue_setredraw;PARENT.Event ue_SetRedraw ( ab_Value )
end event

event ue_getfirstrowonlistpage;RETURN parent.Event ue_getfirstrowonlistpage () 
end event

event ue_scrolllisttorow;PARENT.Event ue_scrolllisttorow ( al_row ) 
end event

event constructor;call super::constructor;n_cst_presentation_shipment	lnv_presentationShipment

lnv_presentationShipment.of_setpresentation( this )

end event

