$PBExportHeader$u_dw_eqlist.sru
forward
global type u_dw_eqlist from u_dw
end type
end forward

global type u_dw_eqlist from u_dw
int Width=1550
int Height=320
string DataObject="d_eqref"
event ue_key pbm_dwnkey
event type integer ue_selectionchanged ( long al_row )
end type
global u_dw_eqlist u_dw_eqlist

forward prototypes
public function integer of_retrieve (string as_value)
public function integer of_retrieveexact (string as_value)
public function integer of_retrieveonshipment (long al_shipment)
public function integer of_retrieveonshipment (long al_ShipmentID, boolean ab_ReloadsToo)
public function integer of_copyfromcache (readonly long al_shipmentid, readonly datastore ads_cache)
end prototypes

event ue_key;long		ll_Row
String	ls_Type
Long		ll_SelectionID
Int		li_SelectionType 

n_cst_EquipmentManager	lnv_EquipmentManager
IF key = KeyEnter! THEN

	ll_Row = THIS.GetRow ( ) 
	
	IF ll_Row > 0 THEN
		THIS.Event ue_SelectionChanged ( ll_Row )
	END IF
ELSEIF KEY = KeyEscape! THEN

	THIS.Event LoseFocus ( )
	
ELSEIF KEY = KeyUpArrow! THEN
	
	IF THIS.RowCount () = 0 THEN
		THIS.Event LoseFocus ( )
	END IF
	
END IF


RETURN 0
end event

public function integer of_retrieve (string as_value);String	ls_OriginalSelect
String 	ls_Where
String 	ls_Ref
Long		ll_Retrieve


THIS.SetTransObject ( SQLCA )
ls_OriginalSelect = THIS.GetSQLSelect ( )

ls_Ref = "~~'" + as_Value + "%~~'"

ls_Where = " where eq_status = ~~'K~~' and eq_ref like " + ls_REf 

THIS.Modify("DataWindow.Table.Select='" +ls_OriginalSelect + ls_Where + "'")
 
ll_Retrieve = THIS.Retrieve ( )

IF ll_Retrieve > 0 THEN
	THIS.Visible = TRUE
	THIS.SelectRow ( 1, TRUE )
END IF
THIS.Modify("DataWindow.Table.Select='" + ls_OriginalSelect + "'")

RETURN ll_Retrieve

end function

public function integer of_retrieveexact (string as_value);String	ls_OriginalSelect
String 	ls_Where
String 	ls_Ref
Long		ll_Retrieve


THIS.SetTransObject ( SQLCA )
ls_OriginalSelect = THIS.GetSQLSelect ( )

ls_Ref = "~~'" + as_Value + "~~'"

ls_Where = " where eq_status = ~~'K~~' and eq_ref = " + ls_REf 

THIS.Modify("DataWindow.Table.Select='" +ls_OriginalSelect + ls_Where + "'")
 
ll_Retrieve = THIS.Retrieve ( )

IF ll_Retrieve > 0 THEN
	THIS.Visible = TRUE
	THIS.SelectRow ( 1, TRUE )
END IF

THIS.Modify("DataWindow.Table.Select='" + ls_OriginalSelect + "'")

RETURN ll_Retrieve

end function

public function integer of_retrieveonshipment (long al_shipment);//String	ls_OriginalSelect
//String 	ls_Where
//
//Long		ll_Retrieve
//
//
//THIS.SetTransObject ( SQLCA )
//ls_OriginalSelect = THIS.GetSQLSelect ( )
//
//ls_Where = " where eq_status <> ~~'X~~' and outside_equip.shipment = " +  String ( al_Shipment )
//
//THIS.Modify("DataWindow.Table.Select='" +ls_OriginalSelect + ls_Where + "'")
// 
//ll_Retrieve = THIS.Retrieve ( )
//
//IF ll_Retrieve > 0 THEN
//	THIS.Visible = TRUE
//	THIS.SelectRow ( 1, TRUE )
//END IF
//
//THIS.Modify("DataWindow.Table.Select='" + ls_OriginalSelect + "'")
//
//RETURN ll_Retrieve
//

RETURN THIS.of_RetrieveOnShipment ( al_Shipment , FALSE )
end function

public function integer of_retrieveonshipment (long al_ShipmentID, boolean ab_ReloadsToo);String	ls_OriginalSelect
String 	ls_Where

Long		ll_Retrieve


THIS.SetTransObject ( SQLCA )
ls_OriginalSelect = THIS.GetSQLSelect ( )

ls_Where = " where eq_status <> ~~'X~~' and outside_equip.shipment = " +  String ( al_ShipmentID )

IF ab_ReloadsToo THEN
	ls_Where += " OR ( eq_status <> ~~'X~~' and outside_equip.reloadshipment = " +  String ( al_ShipmentID ) + " ) "
END IF
	

THIS.Modify("DataWindow.Table.Select='" +ls_OriginalSelect + ls_Where + "'")
 
ll_Retrieve = THIS.Retrieve ( )

IF ll_Retrieve > 0 THEN
	THIS.Visible = TRUE
	THIS.SelectRow ( 1, TRUE )
END IF

THIS.Modify("DataWindow.Table.Select='" + ls_OriginalSelect + "'")

RETURN ll_Retrieve

end function

public function integer of_copyfromcache (readonly long al_shipmentid, readonly datastore ads_cache);long 	ll_find
Long 	ll_end
Long	ll_RowCount
String	ls_Find
Long		ll_NewRow
Long		i

DataStore	lds_Copy
n_ds			lds_Cache
lds_Copy = CREATE DataStore

lds_cache = ads_cache

lds_Copy.DataObject = lds_Cache.DataObject

ls_Find = "( equipmentLease_Shipment = " + String ( al_shipmentid ) + "  OR reloadShipment = " +String ( al_shipmentid )+ " ) AND eq_status <> 'X' "
ll_end = lds_cache.RowCount() + 1
ll_find = 1

ll_find = lds_cache.Find(ls_Find , ll_find, ll_end)

DO WHILE ll_find > 0
	//Copy the row
	lds_Cache.RowsCopy(ll_find, ll_find, PRIMARY!, lds_Copy,999,PRIMARY! )
	
	// Search again
	ll_find++
	ll_find = lds_Cache.Find(ls_Find , ll_find, ll_end )

LOOP

ll_RowCount = lds_Copy.RowCount ( ) 
FOR i = 1 TO ll_RowCount 
	ll_NewRow = THIS.InsertRow ( 0 )
	IF ll_NewRow > 0 THEN
		THIS.SetItem ( i , "eq_id" , lds_Copy.GetItemNumber( i,"eq_id" ) )
		THIS.SetItem ( i , "equipment_type" , lds_Copy.GetItemString( i,"eq_type" ) )
		THIS.SetItem ( i , "eq_ref" , lds_Copy.GetItemString( i,"eq_ref" ) )
		THIS.SetItem ( i , "outside_equip_shipment" , lds_Copy.GetItemnumber( i,"equipmentLease_Shipment" ) )
		THIS.SetItem ( i , "eq_length" , lds_Copy.GetItemNumber( i,"eq_length" ) )
		THIS.SetItem ( i , "eq_status" , lds_Copy.GetItemString( i,"eq_status" ) )
	END IF
	
NEXT

DESTROY ( lds_Copy ) 
RETURN ll_RowCount
end function

event constructor;ib_rmbmenu = FALSE

THIS.of_SetRowSelect ( TRUE )
inv_RowSelect.of_SetStyle ( 0 )

n_cst_Presentation_EquipmentSummary	lnv_Pres

lnv_Pres.of_SetPresentation ( THIS )
end event

event clicked;call super::clicked;long	ll_Row

ll_Row = row

IF ll_Row > 0 THEN

	THIS.Event ue_SelectionChanged ( ll_Row )

END IF

RETURN 0
end event

