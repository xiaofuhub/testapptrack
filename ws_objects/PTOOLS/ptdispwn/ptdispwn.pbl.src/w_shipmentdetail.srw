$PBExportHeader$w_shipmentdetail.srw
forward
global type w_shipmentdetail from w_response
end type
type tab_detail from u_tab_shipmentdetail within w_shipmentdetail
end type
type tab_detail from u_tab_shipmentdetail within w_shipmentdetail
end type
end forward

global type w_shipmentdetail from w_response
int X=677
int Y=448
int Width=2487
boolean TitleBar=true
string Title="Shipment Detail"
long BackColor=12632256
event type n_cst_bso_dispatch ue_getdispatchobject ( )
tab_detail tab_detail
end type
global w_shipmentdetail w_shipmentdetail

type variables
n_cst_bso_dispatch		inv_Dispatch

end variables

event ue_getdispatchobject;RETURN inv_dispatch
end event

event open;call super::open;//Parms supported on the message object : Source, Row (optional) , Editable (optional)

n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment

IF IsValid ( Message.PowerObjectParm ) THEN

	lnv_Msg = Message.PowerObjectParm
	
	IF lnv_Msg.of_Get_Parm ( "DISPATCHOBJECT" , lstr_Parm ) <> 0 THEN
		inv_Dispatch = lstr_Parm.ia_Value
	END IF

	IF lnv_Msg.of_Get_Parm ( "Source", lstr_Parm ) > 0 THEN
		tab_Detail.of_SetSource ( lstr_Parm.ia_Value )
		//This makes it so the window wont try an actual update.  
		//It does validate the dw's before closing, though.
		This.of_SetUpdateable ( FALSE )

		IF lnv_Msg.of_Get_Parm ( "Row", lstr_Parm ) > 0 THEN
			tab_Detail.of_SetCurrentRow ( lstr_Parm.ia_Value )
			
			lnv_Shipment.of_SetSource ( tab_Detail.of_GetSource ( ) )			
			lnv_Shipment.of_SetSourceRow ( lstr_Parm.ia_Value )
			
			tab_detail.of_SetShipmentID ( lnv_Shipment.of_GetID ( ) )
			
		END IF

		IF lnv_Msg.of_Get_Parm ( "EDITABLE" , lstr_Parm ) <> 0 THEN
			tab_detail.of_SetEditable( lstr_Parm.ia_Value )
			IF NOT lstr_Parm.ia_Value THEN
				THIS.Title += " (Non-Editable)"
				
			END IF
		END IF

	END IF

END IF

DESTROY (lnv_Shipment) 
end event

on w_shipmentdetail.create
int iCurrent
call super::create
this.tab_detail=create tab_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_detail
end on

on w_shipmentdetail.destroy
call super::destroy
destroy(this.tab_detail)
end on

type tab_detail from u_tab_shipmentdetail within w_shipmentdetail
int X=64
int Y=44
int TabOrder=10
boolean BringToTop=true
long BackColor=12632256
end type

event ue_getdispatchobject;RETURN Parent.Event ue_GetDispatchObject ( ) 
end event

