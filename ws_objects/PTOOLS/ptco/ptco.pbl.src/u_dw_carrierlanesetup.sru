$PBExportHeader$u_dw_carrierlanesetup.sru
forward
global type u_dw_carrierlanesetup from u_dw
end type
end forward

global type u_dw_carrierlanesetup from u_dw
int Width=2103
int Height=584
string DataObject="d_carrierlanesetup"
event type integer ue_rowadded ( long al_row )
event ue_cleanup ( )
end type
global u_dw_carrierlanesetup u_dw_carrierlanesetup

type variables
Long	il_CarrierID
Long	il_NextID


end variables

forward prototypes
public function long of_getcarrierid ()
public function integer of_setcarrierid (long al_ID)
public function long of_retrieve ()
public function long of_getnextid ()
end prototypes

event ue_rowadded;Long	ll_CarrierID 
Int	li_Rtn = 1

ll_CarrierId = THIS.of_GetCarrierID ( )
IF al_row > 0 THEN
	IF ll_CarrierID > 0 THEN
	
		THIS.SetItem ( al_row , "carrierlanes_carrier" , ll_CarrierID )
	ELSE
		MessageBox ( "New Lane" , "The target carrier could not be resolved. Please try again." )
		THIS.DeleteRow ( al_Row )
		li_Rtn = -1
	END IF
ELSE
	li_Rtn = -1
END IF

IF li_Rtn = 1 THEN
	THIS.SetItem ( al_row , "carrierlanes_id" , THIS.of_GetNextID ( ) )
	THIS.ScrollToRow ( al_Row )
	THIS.SetRow ( al_Row ) 
	THIS.SetColumn ( "carrierlanes_origin" )
	THIS.SetFocus ( )
END IF

RETURN  li_Rtn


end event

event ue_cleanup;Long	ll_RowCount 
Long  i
THIS.SetRedraw ( FALSE ) 

THIS.SetFilter ( "IsNull (carrierlanes_origin) and IsNull ( carrierlanes_destination )" )
THIS.Filter ( ) 
ll_RowCount = THIS.RowCount ( )
IF ll_RowCount > 0 THEN
	THIS.RowsMove ( 1, ll_RowCount, PRIMARY!, THIS, 99, DELETE! )
END IF
 
THIS.SetFilter ( "" )
THIS.Filter ( )
//Step 1: First sort the records in Datawindow 
THIS.SetSort('carrierlanes_origin A, carrierlanes_Destination A')
THIS.Sort()

DO 
	
	//Step 2: 
	THIS.SetFilter(' ( carrierlanes_origin = carrierlanes_origin[1] AND carrierlanes_Destination = carrierlanes_Destination[1] ) OR ( carrierlanes_origin = carrierlanes_origin[-1] AND carrierlanes_Destination = carrierlanes_Destination[-1] )')
	THIS.Filter()

	ll_RowCount = THIS.RowCount ( )
	IF ll_RowCount > 0 THEN
		THIS.DeleteRow ( 1 )
	END IF

	
LOOP UNTIL ll_RowCount = 0

DO 
	
	//Step 2: 
	THIS.SetFilter('IsNull (carrierlanes_origin) AND ( carrierlanes_Destination = carrierlanes_Destination[1]  OR carrierlanes_Destination = carrierlanes_Destination[-1] )  ')
	THIS.Filter()

	ll_RowCount = THIS.RowCount ( )
	IF ll_RowCount > 0 THEN
		THIS.DeleteRow ( 1 )
	END IF

	
LOOP UNTIL ll_RowCount = 0

DO 
	
	//Step 2: 
	THIS.SetFilter('IsNull (carrierlanes_Destination) AND ( carrierlanes_origin = carrierlanes_origin[1]  OR  carrierlanes_origin = carrierlanes_origin[-1] ) ')
	THIS.Filter()

	ll_RowCount = THIS.RowCount ( )
	IF ll_RowCount > 0 THEN
		THIS.DeleteRow ( 1 )
	END IF

	
LOOP UNTIL ll_RowCount = 0



THIS.SetFilter ( "" )
THIS.Filter ( )

THIS.SetRedraw ( TRUE ) 

end event

public function long of_getcarrierid ();RETURN il_CarrierID 
end function

public function integer of_setcarrierid (long al_ID);il_CarrierID = al_ID
RETURN 1
end function

public function long of_retrieve ();Long	ll_ID
Long	ll_Rtn = -1

ll_ID = THIS.of_GetCarrierID ( )

IF ll_ID > 0 THEN
	ll_Rtn = THIS.Retrieve ( ll_ID )
END IF

RETURN ll_Rtn
end function

public function long of_getnextid ();Long	ll_Rtn

ll_Rtn = il_NextID + 1

il_NextID = ll_Rtn

RETURN ll_Rtn 
end function

event constructor;Long	ll_Max
SetTransObject ( SQLCA )


Select Max ( id ) INTO :ll_Max FROM carrierLanes;

IF IsNull ( ll_max ) THEN
	ll_Max = 0
END IF

il_NextID = ll_Max

THIS.of_Setbase ( TRUE ) 
THIS.of_SetAutoFilter( TRUE )
THIS.of_SetAutoSort( TRUE )


end event

event pfc_addrow;call super::pfc_addrow;Long	ll_Rtn

ll_Rtn = AncestorReturnValue

IF ll_Rtn > 0 THEN
	THIS.Event ue_RowAdded ( ll_Rtn )
END IF

RETURN ll_Rtn

end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_Rtn

ll_Rtn = AncestorReturnValue

IF ll_Rtn > 0 THEN
	THIS.Event ue_RowAdded ( ll_Rtn )
END IF

RETURN ll_Rtn

end event

