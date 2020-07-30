$PBExportHeader$u_dw_shipmentdetail.sru
forward
global type u_dw_shipmentdetail from u_dw
end type
end forward

global type u_dw_shipmentdetail from u_dw
int Width=1074
int Height=472
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
event type boolean ue_isshipmentdetail ( )
end type
global u_dw_shipmentdetail u_dw_shipmentdetail

event ue_isshipmentdetail;//Can be triggered by other code to figure out if elements in a control array
//are descendants of this class.

RETURN TRUE
end event

event constructor;This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )

n_cst_Presentation_Shipment	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )
end event

