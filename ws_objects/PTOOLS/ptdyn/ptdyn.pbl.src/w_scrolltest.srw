$PBExportHeader$w_scrolltest.srw
forward
global type w_scrolltest from window
end type
type dw_1 from datawindow within w_scrolltest
end type
end forward

global type w_scrolltest from window
integer width = 3168
integer height = 1876
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_scrolltest w_scrolltest

event open;Datastore 	lds_Cache
Long			ll_rOWCOUNT

n_cst_ShipmentManager	lnv_ShipmentManager


dw_1.DataObject = "C:\Program Files\Profit Tools\Template\dynamic\GroupByVesselVoyage.psr"
dw_1.SetTransObject(SQLCA)

lnv_ShipmentManager.of_refreshShipments(false)
lds_Cache = lnv_ShipmentManager.of_get_ds_ship( )

IF IsValid ( lds_Cache ) THEN
	
	ll_rowcount = lds_Cache.rowcount()
	
	//this way there are no duplicate rows
	dw_1.Reset()
	
	lds_Cache.RowsCopy ( 1, ll_RowCount, Primary!, dw_1, 1, Primary! )
	//dw_1.resetUpdate()
		
END IF

end event

on w_scrolltest.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_scrolltest.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_scrolltest
integer x = 151
integer y = 76
integer width = 1381
integer height = 1512
integer taborder = 10
string title = "none"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

