$PBExportHeader$u_dw_eqassignlist.sru
forward
global type u_dw_eqassignlist from u_dw
end type
end forward

global type u_dw_eqassignlist from u_dw
integer width = 1307
integer height = 456
string dragicon = "grab.ico"
string dataobject = "d_eqassignlist"
event type n_cst_beo_shipment ue_getshipment ( )
end type
global u_dw_eqassignlist u_dw_eqassignlist

forward prototypes
public function string of_getselectedtype ()
public function string of_getselectedref ()
public function long of_getselectedid ()
public function integer of_setcache (readonly n_cst_bso_dispatch anv_dispatch, readonly long al_shipmentid)
end prototypes

public function string of_getselectedtype ();long	ll_Row
String	ls_Type 
ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ls_Type = THIS.GetItemString ( ll_Row , "equipment_type" )
END IF

RETURN ls_Type
end function

public function string of_getselectedref ();long		ll_Row
String	ls_Ref

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ls_Ref = THIS.GetItemString ( ll_Row , "equipment_eq_ref" )
END IF

RETURN ls_Ref 
end function

public function long of_getselectedid ();long		ll_Row
Long		ll_ID

ll_Row = THIS.GetRow ( )

IF ll_Row > 0 THEN
	ll_ID = THIS.GetItemNumber( ll_Row , "equipment_eq_id" )
END IF

RETURN ll_ID 
end function

public function integer of_setcache (readonly n_cst_bso_dispatch anv_dispatch, readonly long al_shipmentid);long 	ll_find
Long 	ll_end
Long	ll_RowCount
String	ls_Find
Long		ll_NewRow
Long		i

DataStore	lds_Copy
n_ds			lds_Cache
lds_Copy = CREATE DataStore

IF IsValid ( anv_dispatch ) THEN
	anv_dispatch.of_RetrieveEquipmentForShipment ( al_shipmentid )
	

	lds_cache = anv_Dispatch.of_GetEquipmentCache ( )
	
	lds_Copy.DataObject = lds_Cache.DataObject
	
	ls_Find = "equipmentlease_shipment = " + String ( al_shipmentid ) + " OR reloadshipment = " +  + String ( al_shipmentid )
	
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
			THIS.SetItem ( i , "equipment_type" , lds_Copy.GetItemString( i,"eq_type" ) )
			THIS.SetItem ( i , "equipment_eq_ref" , lds_Copy.GetItemString( i,"eq_ref" ) )
			THIS.SetItem ( i , "equipment_eq_id" , lds_Copy.GetItemNumber( i,"eq_id" ) )
			THIS.SetItem ( i , "equipment_eq_status" , lds_Copy.GetItemString( i,"eq_status" ) )
		END IF
	NEXT
	
END IF



DESTROY ( lds_Copy ) 
RETURN ll_RowCount
end function

event constructor;ib_rmbmenu = FALSE
THIS.SetRowFocusIndicator ( focusRect! )
end event

event lbuttondown;call super::lbuttondown;n_cst_privileges_events	lnv_Privs
IF lnv_Privs.of_allowalteritins( ) THEN
	IF THIS.RowCount ( ) > 0 THEN
		THIS.Drag ( BEGIN! )
	END IF
END IF
end event

event doubleclicked;SetPointer ( HOURGLASS! )
Long	ll_ID	
w_eq_info   lw_eqwin

n_cst_msg	lnv_msg
s_parm		lstr_parm




	
IF ROW > 0 THEN
	ll_ID = THIS.Object.equipment_eq_id [ row ]
	IF ll_ID > 10000000 THEN
		//changed 5-22-07 to open with lnv_msg
		lstr_parm.is_label = "ID"
		lstr_parm.ia_value = ll_id
		lnv_msg.of_add_parm( lstr_parm )
		
		//added by dan 5-22-07
		lstr_parm.is_label = "SHIPMENT"
		lstr_parm.ia_value = this.event ue_getShipment()
		lnv_msg.of_add_parm( lstr_parm )
		opensheetwithparm(lw_eqwin, lnv_msg, gnv_app.of_GetFrame ( ), 0, original!)
	ELSE
		MessageBox ( "Equipment Details" , "Please save the shipment before viewing equipment details." )
	END IF
END IF


end event

on u_dw_eqassignlist.create
end on

on u_dw_eqassignlist.destroy
end on

