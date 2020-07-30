$PBExportHeader$u_cst_oebasics.sru
forward
global type u_cst_oebasics from u_base
end type
type dw_oe from u_dw_oebasics within u_cst_oebasics
end type
end forward

global type u_cst_oebasics from u_base
integer width = 1742
integer height = 552
long backcolor = 12632256
event type integer ue_pusitechanged ( long al_siteid )
event type integer ue_rtnsitechanged ( long al_siteid )
event type integer ue_eqrefchanged ( string as_value,  long al_row )
event ue_gotfocus ( )
event ue_lostfocus pbm_bnkillfocus
event type n_cst_bso_dispatch ue_getdispatch ( )
event type n_cst_beo_shipment ue_getshipment ( )
event type integer ue_displayshipment ( long al_id )
dw_oe dw_oe
end type
global u_cst_oebasics u_cst_oebasics

type variables
datawindowChild	idwc_Lines
end variables

forward prototypes
public function long of_getpulocation ()
public function long of_getrtnlocation ()
public function integer of_setpulocation (long al_id)
public function integer of_setrtnlocation (long al_id)
public function integer of_selectequipment (string as_type, long al_row)
public function integer of_retrieveequipment (long al_shipmentid)
public function integer of_syncequipmentcache (n_cst_bso_dispatch anv_dispatch)
public function integer of_setenable (boolean ab_Value)
public subroutine of_setfocus ()
public function integer of_setreleasedate (date ad_Value)
public function integer of_setreleasetime (time at_Value)
end prototypes

public function long of_getpulocation ();RETURN dw_oe.of_GetPUSite ( )
end function

public function long of_getrtnlocation ();RETURN dw_oe.of_GetRtnSite ( )
end function

public function integer of_setpulocation (long al_id);RETURN dw_oe.of_SetPUSite ( al_id )
end function

public function integer of_setrtnlocation (long al_id);RETURN dw_oe.of_SetRtnSite ( al_Id )
end function

public function integer of_selectequipment (string as_type, long al_row);IF dw_oe.RowCount ( ) >= al_Row THEN
	
	CHOOSE CASE UPPER ( as_Type ) 
			
		CASE "TRAILER"
			
			dw_oe.SetItem ( al_Row , "intermodalequipment_type" , "B" )
			
		CASE "CONTAINER"
			
			dw_oe.SetItem ( al_Row , "intermodalequipment_type" , "C" )
			
		CASE "CHASSIS" , "H"
			
			dw_oe.SetItem ( al_Row , "intermodalequipment_type" , "H" )
			
		
		CASE "RAILBOX" 
			
			dw_oe.SetItem ( al_Row , "intermodalequipment_type" , "R" )
			
		
	END CHOOSE 
END IF
RETURN 1
end function

public function integer of_retrieveequipment (long al_shipmentid);Return dw_oe.of_Retrieve ( al_ShipmentID )
end function

public function integer of_syncequipmentcache (n_cst_bso_dispatch anv_dispatch);RETURN dw_oe.of_SyncWithCache ( anv_dispatch )

//Boolean	lb_AllRows 
//Boolean	lb_AllColumns
//Int		li_Return = -1
//n_cst_bso_Dispatch	lnv_Dispatch
//n_ds			lds_EquipmentCache
//DataWindow	ldw_Null
//DataStore	lds_Null
//
//lnv_Dispatch = anv_Dispatch
//IF isValid ( lnv_dispatch ) THEN
//	lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )
//END IF
//
//IF isValid ( lds_EquipmentCache ) THEN
//	
//	Long	ll_RowCount 
//	Long	ll_I
//	
//	//dw_oe.SetRedraw ( FALSE )
//	ll_RowCount = dw_oe.RowCount ( ) 
//		
//	FOR ll_i = ll_RowCount TO 1 STEP -1
//		
//		IF Len ( Trim ( String ( dw_oe.Object.eq_ref [ ll_i ]  ) ) ) > 0 THEN
//		ELSE
//			//dw_oe.Rowsdiscard (ll_i, ll_i, PRIMARY! )
//			dw_oe.SetItemStatus ( ll_i, 0 , PRIMARY!, NotModified! ) 
//		END IF
//	NEXT
//	
//	IF gf_rows_sync(lds_Null, dw_oe, lds_EquipmentCache, ldw_Null, PRIMARY!, lb_AllRows, lb_AllColumns) = 1 THEN
//		li_Return = 1
//	END IF
//	
////	CHOOSE CASE dw_oe.RowCount ( ) 
////			
////		CASE 0
////			dw_oe.of_AddRow ( 99 )
////			dw_oe.of_AddRow ( 99 ) 
////			
////		CASE 1
////			dw_oe.of_AddRow ( 99 )
////			
////	END CHOOSE
//	
////	dw_oe.SetRedraw ( TRUE )
//	
//	
//	
//END IF
//
//RETURN li_Return



end function

public function integer of_setenable (boolean ab_Value);dw_oe.of_SetEnable ( ab_Value )
RETURN 1
end function

public subroutine of_setfocus ();dw_oe.SetFocus ( )
end subroutine

public function integer of_setreleasedate (date ad_Value);dw_oe.of_SetReleaseDate ( ad_Value )
RETURN 1
end function

public function integer of_setreleasetime (time at_Value);dw_oe.of_SetReleaseTime ( at_Value )
RETURN 1
end function

on u_cst_oebasics.create
int iCurrent
call super::create
this.dw_oe=create dw_oe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_oe
end on

on u_cst_oebasics.destroy
call super::destroy
destroy(this.dw_oe)
end on

type dw_oe from u_dw_oebasics within u_cst_oebasics
integer width = 1746
integer height = 532
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
end type

event ue_changepusite;call super::ue_changepusite;Parent.event ue_puSiteChanged ( al_siteid )
RETURN 1
end event

event ue_changertnsite;call super::ue_changertnsite;Parent.Event ue_RtnSiteChanged ( al_siteid )
REturn 1
end event

event ue_getdispatch;RETURN Parent.Event ue_GetDispatch ( )
end event

event ue_getshipment;RETURN Parent.Event ue_GetShipment ( ) 
end event

event ue_viewreloadshipment;RETURN PARENT.Event ue_DisplayShipment ( al_shipmentid )
end event

event doubleclicked;SETPointer ( HOURGLASS! )
Long	ll_ID	
Long	ll_Row
w_eq_info   lw_eqwin
ll_Row = THIS.GetRow ( )

n_cst_msg	lnv_msg
s_parm		lstr_parm

IF ll_ROW > 0 THEN
	ll_ID = THIS.Object.eq_id [ ll_row ]
	//////Changed by Dan 2-1-07 to pass n_cst_msg instead of the id
	lstr_parm.is_label = "ID"
	lstr_parm.ia_value = ll_id
	lnv_msg.of_add_parm( lstr_parm )
	
//	lstr_parm.is_label = "U_CST_OEBASICS"
//	lstr_parm.ia_value = parent
//	lnv_msg.of_add_parm( lstr_parm )
//	
//	lstr_parm.is_label = "DWO"
//	lstr_parm.ia_value = dwo
//	lnv_msg.of_add_parm( lstr_parm )
//	
//	lstr_parm.is_label = "ROW"
//	lstr_parm.ia_value = row
//	lnv_msg.of_add_parm( lstr_parm )
	
	
	lstr_parm.is_label = "SHIPMENT"
	lstr_parm.ia_value = parent.event ue_getshipment( )
	lnv_msg.of_add_parm( lstr_parm )
	
	IF ll_ID > 999  THEN
//		THIS.of_SyncWithCache ( Parent.Event ue_GetDispatch ( )  )
//		opensheetwithparm(lw_eqwin, ll_ID, gnv_app.of_GetFrame ( ), 0, original!)
		opensheetwithparm(lw_eqwin, lnv_msg, gnv_app.of_GetFrame ( ), 0, original!)
	END IF
END IF
RETURN 1
end event

event ue_leasetypechanged;call super::ue_leasetypechanged;n_cst_beo_Shipment	lnv_Shipment 

lnv_Shipment = Parent.Event ue_GetShipment ( ) 

IF IsValid ( lnv_Shipment ) THEN
	// this is done so the shipment summary will reflect any changes
	lnv_Shipment.of_SetRequiredEquipment  ( lnv_Shipment.of_GetRequiredEquipment ( ) ) 
END IF

RETURN AncestorReturnValue
end event

event constructor;call super::constructor;Boolean	lb_Posting
n_cst_Licensemanager	lnv_LicMan
lb_Posting = lnv_LicMan.of_HasEquipmentpostinglicense( )

IF NOT lb_Posting THEN
	THIS.hscrollbar = FALSE
	THIS.Modify( "gb_details.width = 1632" )
	THIS.Modify( "gooseneck.tabsequence = 0" )
	THIS.Modify( "height.tabsequence = 0" )
	THIS.Modify( "isodescription.tabsequence = 0" )
END IF
	
	


end event

event itemchanged;call super::itemchanged;n_Cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.event ue_getshipment()

IF isValid ( lnv_Shipment ) THEN
	IF AncestorReturnValue = 0 THEN
		lnv_Shipment.of_MarkasModified ( )
	END IF
END IF

RETURN AncestorReturnValue
end event

