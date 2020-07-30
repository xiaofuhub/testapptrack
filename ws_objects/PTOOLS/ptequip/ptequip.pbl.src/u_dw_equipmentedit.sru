$PBExportHeader$u_dw_equipmentedit.sru
forward
global type u_dw_equipmentedit from u_dw
end type
end forward

global type u_dw_equipmentedit from u_dw
integer width = 2482
integer height = 580
string dataobject = "d_equipmentbooking3"
boolean hscrollbar = true
boolean hsplitscroll = true
event ue_copypreviousrow ( long al_row )
event ue_populatesites ( long al_shipid,  long al_row )
end type
global u_dw_equipmentedit u_dw_equipmentedit

forward prototypes
public function integer of_getmsgobjectforrow (long al_row, ref n_cst_msg anv_msg)
end prototypes

event ue_populatesites;//Long		ll_EventCount
//Long		i
//String	ls_Note
//String	ls_ColumnName
//long	ll_CoID
//
//n_cst_bso_Dispatch	lnv_Disp
//lnv_Disp = CREATE n_cst_bso_Dispatch
//n_cst_beo_Shipment	lnv_Shipment
//n_cst_Beo_Event		lnva_Events[]
//
//
//n_ds		lds_Ship
//n_ds		lds_events
//n_ds		lds_Items
//
//IF al_shipid > 0 THEN
//	IF lnv_Disp.of_RetrieveShipment ( al_shipid ) = 1 THEN
//		lnv_Disp.of_FilterShipment ( al_shipid )
//		lds_Ship = lnv_Disp.of_GetShipmentCache ( )
//		lds_Events = lnv_Disp.of_GetEventCache ( )
//		lds_Items = lnv_Disp.of_GetItemCache ( )
//		IF isValid ( lds_Ship ) THEN
//			
//			lnv_Shipment.of_SetEventSource ( lds_Events )
//			lnv_Shipment.of_SetItemSource ( lds_Items )
//			lnv_Shipment.of_SetSource ( lds_Ship )
//			lnv_Shipment.of_SetSourceID ( al_shipid )
//			ll_EventCount = lnv_Shipment.of_GetEventList ( lnva_Events )
//
//		END IF
//	END IF	
//END IF
//
//
//
//FOR i = 1 TO ll_EventCount
//	ls_Note = Upper ( Trim ( lnva_Events [ i ].of_GetNote ( ) ) )
//	ll_CoId = lnva_Events [ i ].of_GetSite (  )
//	
//	
//	IF POS ( ls_Note , "<PIER>" ) > 0 THEN
//		ls_ColumnName = "Pier"
//		
//	ELSEIF POS ( ls_Note , "<CUSTOMER>") > 0 THEN
//		ls_ColumnName = "Customer_id"
//		
//	ELSEIF POS ( ls_Note , "<RAMP>" ) > 0 THEN
//		ls_ColumnName = "Ramp"
//		
//	ELSEIF POS ( ls_Note , "<YARD>" ) > 0 THEN
//		ls_ColumnName = "YARD"
//		
//	ELSEIF POS ( ls_Note , "<DOCK>" ) > 0 THEN
//		ls_ColumnName = "DOCK"
//		
//	ELSEIF POS ( ls_Note , "<POOL>" ) > 0 THEN
//		ls_ColumnName = "POOL"
//		
//	ELSEIF POS ( ls_Note , "<DEPOT>" ) > 0 THEN
//		ls_ColumnName = "DEPOT"
//		
//	ELSEIF POS ( ls_Note , "<TERMINAL>" ) > 0 THEN
//		ls_ColumnName = "TERMINAL_NAME"
//	END IF
//	
//	IF Len ( ls_ColumnName ) > 0 THEN
//		THIS.SetItem ( al_Row , ls_ColumnName , ll_CoID )
//	END IF
//
//	ls_ColumnName = ""  // reset
//	
//NEXT
//	
//
//
//Destroy ( lnv_Disp )
end event

public function integer of_getmsgobjectforrow (long al_row, ref n_cst_msg anv_msg);Long			ll_Row 
n_cst_msg	lnv_msg
S_Parm		lstr_Parm

ll_Row = al_Row

// EARLY RETURN -----
IF ll_Row <= 0 OR ll_Row > THIS.RowCount ( ) THEN
	RETURN -1
END IF


IF Not isNull ( Long ( THIS.object.template [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "SHIPMENTID"
	lstr_Parm.ia_Value = Long ( THIS.object.template [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull ( Long ( THIS.object.Pier [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "PIER"
	lstr_Parm.ia_Value =  Long ( THIS.object.Pier [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull (  Long ( THIS.object.Ramp [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "RAMP"
	lstr_Parm.ia_Value = Long ( THIS.object.Ramp [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull ( Long ( THIS.object.Yard [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "YARD"
	lstr_Parm.ia_Value = Long ( THIS.object.Yard [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull ( Long ( THIS.object.Dock [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "DOCK"
	lstr_Parm.ia_Value = Long ( THIS.object.Dock [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull ( Long ( THIS.object.Customer_id [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "CUSTOMER"
	lstr_Parm.ia_Value = Long ( THIS.object.Customer_id [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull ( Long ( THIS.object.Terminal_name [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "TERMINAL"
	lstr_Parm.ia_Value = Long ( THIS.object.Terminal_name [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull ( Long ( THIS.object.Pool [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "POOL"
	lstr_Parm.ia_Value = Long ( THIS.object.Pool [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not isNull ( Long ( THIS.object.Depot [ ll_Row ] ) ) THEN
	lstr_Parm.is_label = "DEPOT"
	lstr_Parm.ia_Value = Long ( THIS.object.Depot [ ll_Row ] )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( STRING ( THIS.object.outside_equip_oe_booknum [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "BOOKINGNUMBER"
	lstr_Parm.ia_Value = STRING ( THIS.object.outside_equip_oe_booknum [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( Long ( THIS.object.equipment_eq_ref [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "EQUIPREF"
	lstr_Parm.ia_Value = Upper ( STRING ( THIS.object.equipment_eq_ref [ ll_Row ] ) )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( Long ( THIS.object.equipment_eq_length [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "EQUIPLEN"
	lstr_Parm.ia_Value = Long ( THIS.object.equipment_eq_length [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( Long ( THIS.object.equipment_eq_height [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "EQUIPHEIGHT"
	lstr_Parm.ia_Value = Long ( THIS.object.equipment_eq_height [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF


IF Not IsNull ( String ( THIS.object.equipment_type [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "EQUIPTYPE"
	lstr_Parm.ia_Value = String ( THIS.object.equipment_type [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF


IF Not IsNull ( String ( THIS.object.equipment_eq_air [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "EQUIPAIR"
	lstr_Parm.ia_Value = String ( THIS.object.equipment_eq_air [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( String ( THIS.object.onbehalfof_name [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "BEHALFOF"
	lstr_Parm.ia_Value = String ( THIS.object.onbehalfof_name [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

// on its way out
IF Not IsNull ( String ( THIS.object.importexport [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "IMPORTEXPORT"
	lstr_Parm.ia_Value = String ( THIS.object.importexport [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

// on its way out
IF Not IsNull ( String ( THIS.object.servicetype [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "SERVICETYPE"
	lstr_Parm.ia_Value = String ( THIS.object.servicetype [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( String ( THIS.object.freightservice [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "FREIGHTSERVICE"
	lstr_Parm.ia_Value = String ( THIS.object.freightservice [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( String ( THIS.object.freightdescription [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "FREIGHTDESCRIPTION"
	lstr_Parm.ia_Value = String ( THIS.object.freightdescription [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( String (THIS.object.outside_equip_fkequipmentleasetype [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "LEASETYPE"
	lstr_Parm.ia_Value = LONG (THIS.object.outside_equip_fkequipmentleasetype [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF Not IsNull ( String (THIS.object.lease_type [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "LEASELINE"
	lstr_Parm.ia_Value = String (THIS.object.lease_type [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

/////
IF THIS.object.shipment_ref2type [ ll_Row ] > 0  THEN
	lstr_Parm.is_Label = "REF2LABEL"
	lstr_Parm.ia_Value = String (THIS.object.shipment_ref2type [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF


IF Not IsNull ( String (THIS.object.ref2text [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "REF2TEXT"
	lstr_Parm.ia_Value = String (THIS.object.ref2text [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF

IF THIS.object.shipment_ref3type [ ll_Row ] > 0 THEN
	lstr_Parm.is_Label = "REF3LABEL"
	lstr_Parm.ia_Value = String (THIS.object.shipment_ref3type [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF


IF Not IsNull ( String (THIS.object.ref3text [ ll_Row ] ) ) THEN
	lstr_Parm.is_Label = "REF3TEXT"
	lstr_Parm.ia_Value = String (THIS.object.ref3text [ ll_Row ] )
	lnv_msg.of_Add_Parm ( lstr_Parm )
END IF


anv_msg = lnv_Msg

RETURN 1

end function

event constructor;SetPointer ( HOURGLASS! )
n_cst_Presentation_EquipmentSummary	lnv_Presentation
lnv_Presentation.ib_Editable = TRUE
lnv_Presentation.of_SetPresentation ( This )


datawindowChild ldwc_LeaseTypes,ldwc_Types
Long		ll_EndRow


THIS.GetChild ( "outside_equip_fkequipmentleasetype" ,  ldwc_Types )
THIS.GetChild ( "lease_type" ,  ldwc_LeaseTypes )

IF isValid ( ldwc_Types ) THEN
	ldwc_Types.SetTransObject ( SQLCA )
	ldwc_Types.Retrieve ( )
	Commit;
	ll_EndRow = ldwc_Types.RowCount ( )
END IF

IF isValid ( ldwc_LeaseTypes ) THEN
	ldwc_Types.RowsCopy (1, ll_EndRow, PRIMARY!, ldwc_LeaseTypes, ll_EndRow, PRIMARY! )
END IF

n_cst_ShipmentManager	lnv_ShipmentMgr
lnv_ShipmentMgr.of_PopulateReferenceLists ( THIS )
end event

event pfc_addrow;call super::pfc_addrow;IF AncestorReturnValue > 1 THEN
	THIS.Event ue_CopyPreviousRow ( ancestorReturnValue )
END IF

Return AncestorReturnValue
end event

on u_dw_equipmentedit.create
end on

on u_dw_equipmentedit.destroy
end on

event itemchanged;call super::itemchanged;IF row > 0 THEN
	
	IF dwo.name = "shipment_ref2type" THEN
		
		IF Integer ( data ) = 0 THEN
			THIS.object.ref2text[ row ] = ""
		END IF
		
	ELSEIF dwo.name = "shipment_ref3type" THEN
		
		IF Integer ( data ) = 0 THEN
			THIS.object.ref3text[ row ] = ""
		END IF
	END IF
	
	
	
END IF
end event

