$PBExportHeader$u_st_shipmentcachecode.sru
forward
global type u_st_shipmentcachecode from u_st
end type
end forward

global type u_st_shipmentcachecode from u_st
int Height=72
boolean Enabled=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text=""
Alignment Alignment=Center!
long BackColor=12632256
FontCharSet FontCharSet=Ansi!
event type integer ue_refresh ( )
end type
global u_st_shipmentcachecode u_st_shipmentcachecode

event ue_refresh;n_cst_ShipmentManager	lnv_ShipmentManager
String	ls_CacheCode

Integer	li_Return = 1

//Set the cache code indicator to reflect the cache in use.

ls_CacheCode = lnv_ShipmentManager.of_GetShipmentCacheCode ( )

IF IsNull ( ls_CacheCode ) THEN
	ls_CacheCode = "Standard"
END IF

This.Text = ls_CacheCode

RETURN li_Return
end event

