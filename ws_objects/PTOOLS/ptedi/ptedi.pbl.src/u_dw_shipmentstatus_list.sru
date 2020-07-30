$PBExportHeader$u_dw_shipmentstatus_list.sru
forward
global type u_dw_shipmentstatus_list from u_dw
end type
end forward

global type u_dw_shipmentstatus_list from u_dw
integer width = 3214
integer height = 504
string dataobject = "d_edipending_grid"
end type
global u_dw_shipmentstatus_list u_dw_shipmentstatus_list

type variables
datawindowChild	idwc_Status, idwc_Reasons
end variables

forward prototypes
public function integer of_getchildren ()
public function integer of_filterbyshipment (long al_shipmentid)
end prototypes

public function integer of_getchildren ();Long	ll_Rtn
THIS.GetChild ( "status" , idwc_Status )
THIS.GetChild ( "reason" , idwc_Reasons )
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

on u_dw_shipmentstatus_list.create
end on

on u_dw_shipmentstatus_list.destroy
end on

