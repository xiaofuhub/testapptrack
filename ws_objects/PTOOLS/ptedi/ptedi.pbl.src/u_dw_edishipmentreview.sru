$PBExportHeader$u_dw_edishipmentreview.sru
forward
global type u_dw_edishipmentreview from u_dw_shipmentlist
end type
end forward

global type u_dw_edishipmentreview from u_dw_shipmentlist
string dataobject = "d_ediShipmentReview"
end type
global u_dw_edishipmentreview u_dw_edishipmentreview

on u_dw_edishipmentreview.create
end on

on u_dw_edishipmentreview.destroy
end on

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
end event

event clicked;call super::clicked;IF Row = 0 OR Row > THIS.rowcount( ) THEN
	THIS.SelectRow ( 0 , FALSE ) 
END IF

RETURN AncestorReturnValue

end event

