$PBExportHeader$u_tabpg_dupmultiple.sru
forward
global type u_tabpg_dupmultiple from u_tabpg
end type
type dw_1 from u_dw_shipmentlist within u_tabpg_dupmultiple
end type
end forward

global type u_tabpg_dupmultiple from u_tabpg
integer width = 2450
integer height = 964
dw_1 dw_1
end type
global u_tabpg_dupmultiple u_tabpg_dupmultiple

forward prototypes
public function long of_retrieveshipments (long ala_ids[])
public function long of_getshipmentids (ref long ala_Ids[])
public function integer of_getshipments (ref n_cst_beo_shipment anva_shipments[])
end prototypes

public function long of_retrieveshipments (long ala_ids[]);String	ls_Select
String	ls_Where
Long		ll_Return = -1

n_cst_sql	lnv_Sql

ls_Select = dw_1.describe("datawindow.table.select")
ls_Where = " WHERE ~~~"disp_ship~~~".~~~"ds_id~~~" "+  lnv_Sql.of_MakeInClause ( ala_ids[] )

dw_1.modify("datawindow.table.select = '" + ls_Select + ls_Where + "'")
ll_Return = dw_1.Retrieve ( )

RETURN ll_Return
end function

public function long of_getshipmentids (ref long ala_Ids[]);Long	lla_Ids[]
Long	ll_Count
Long	i

ll_Count = dw_1.Rowcount ( )

FOR i = 1 TO ll_Count
	lla_Ids[i] = dw_1.GetItemNumber ( i , "ds_ID" )
NEXT

ala_Ids[ ] = lla_Ids
RETURN ll_Count

end function

public function integer of_getshipments (ref n_cst_beo_shipment anva_shipments[]);Int	i
Long	ll_RowCount

n_cst_beo_Shipment	lnva_Shipment[]


ll_RowCount = dw_1.RowCount ( )

FOR i = 1 TO ll_RowCount
	
	lnva_Shipment[i] = CREATE n_cst_beo_Shipment
	lnva_Shipment[i].of_SetSource ( dw_1 ) 
	lnva_Shipment[i].of_SetSourceID ( dw_1.Object.ds_id[i] )
	
NEXT

anva_Shipments[] = lnva_Shipment

RETURN UpperBound ( anva_Shipments )
	
end function

on u_tabpg_dupmultiple.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on u_tabpg_dupmultiple.destroy
call super::destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_shipmentlist within u_tabpg_dupmultiple
integer x = 9
integer y = 16
integer width = 2423
integer height = 928
integer taborder = 10
boolean bringtotop = true
end type

event constructor;call super::constructor;THIS.Event ue_SetView ( "Overview" )
THIS.modify ( "DataWindow.Footer.Height = 0")

THIS.SetTransObject ( sqlca )
THIS.ib_rmbMenu = FALSE
end event

