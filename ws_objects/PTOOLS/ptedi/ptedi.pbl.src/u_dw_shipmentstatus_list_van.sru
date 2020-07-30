$PBExportHeader$u_dw_shipmentstatus_list_van.sru
forward
global type u_dw_shipmentstatus_list_van from u_dw
end type
end forward

global type u_dw_shipmentstatus_list_van from u_dw
integer width = 2400
integer height = 488
string dataobject = "d_edi_eventcache"
end type
global u_dw_shipmentstatus_list_van u_dw_shipmentstatus_list_van

type variables
datawindowChild	idwc_Status, idwc_Reasons
end variables

forward prototypes
public function integer of_getchildren ()
public function integer of_filterbyshipment (long al_shipmentid)
end prototypes

public function integer of_getchildren ();Long	ll_Rtn
THIS.GetChild ( "shipment_status_edi_status_id" , idwc_Status )
THIS.GetChild ( "shipment_status_edi_reason_id" , idwc_Reasons )
idwc_Status.SetTransObject ( SQLCA )
idwc_Reasons.SetTransObject ( SQLCA )

ll_Rtn = idwc_Status.Retrieve ( )
ll_Rtn = idwc_Reasons.Retrieve ( ) 

RETURN 1
end function

public function integer of_filterbyshipment (long al_shipmentid);THIS.SetFilter ( "disp_events_de_shipment_id = " + String( al_ShipmentID ) )
THIS.Filter ( ) 

Return 1


end function

event constructor;n_cst_events	lnv_Events 
This.Modify ( "event_type.Edit.CodeTable = Yes "+&
	"event_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
	
//THIS.of_SetRowSelect ( TRUE )

end event

on u_dw_shipmentstatus_list_van.create
end on

on u_dw_shipmentstatus_list_van.destroy
end on

