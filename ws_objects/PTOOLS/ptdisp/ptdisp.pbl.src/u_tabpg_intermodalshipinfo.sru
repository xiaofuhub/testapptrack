$PBExportHeader$u_tabpg_intermodalshipinfo.sru
forward
global type u_tabpg_intermodalshipinfo from u_tabpg_shipinfo
end type
type uo_equipment from u_cst_shipequipment within u_tabpg_intermodalshipinfo
end type
type cb_shipnote from commandbutton within u_tabpg_intermodalshipinfo
end type
type cb_billnote from commandbutton within u_tabpg_intermodalshipinfo
end type
type uo_billto from u_cst_sle_company within u_tabpg_intermodalshipinfo
end type
type st_1 from statictext within u_tabpg_intermodalshipinfo
end type
end forward

global type u_tabpg_intermodalshipinfo from u_tabpg_shipinfo
integer width = 4283
integer height = 880
long backcolor = 12632256
event ue_showbillnote ( )
event ue_showshipnote ( )
event ue_preremovesplit ( )
event ue_refreshequipment ( )
event ue_frontsplitadded ( )
event ue_backsplitadded ( )
event ue_trailerpuchanged ( long al_siteid )
event ue_trailerrtnchanged ( long al_siteid )
event ue_chassispuchanged ( long al_site )
event ue_chassisrtnchanged ( long al_site )
uo_equipment uo_equipment
cb_shipnote cb_shipnote
cb_billnote cb_billnote
uo_billto uo_billto
st_1 st_1
end type
global u_tabpg_intermodalshipinfo u_tabpg_intermodalshipinfo

type variables

end variables

forward prototypes
private function integer of_shipmentchanged ()
public function integer of_setequipmentlocation (string as_column, long al_siteid)
public subroutine of_setfocus ()
public function integer of_setnotebuttons ()
public subroutine of_syncbillto ()
public function integer of_accepttext ()
public function integer of_formatforcontext ()
public subroutine of_shownoteicons ()
end prototypes

event ue_refreshequipment;IF isValid ( inv_Shipment ) THEN
	uo_equipment.of_RetrieveEquipment ( inv_Shipment.of_GetID ( ) )	
END IF

end event

private function integer of_shipmentchanged ();RETURN -1
end function

public function integer of_setequipmentlocation (string as_column, long al_siteid);CHOOSE CASE UPPER ( as_column )
	CASE "CHASSISPU"
		uo_equipment.of_SetChassisPuLocation ( al_siteid ) 
	CASE "CHASSISRTN"
		uo_equipment.of_SetChassRtnLocation ( al_siteid ) 	
	CASE "TRAILERPU"
		uo_equipment.of_SetTrailerPULocation ( al_siteid ) 
	CASE "TRAILERRTN"
		uo_equipment.of_SetTrailerRtnLocation ( al_siteid ) 
END CHOOSE
				
RETURN 1

	

end function

public subroutine of_setfocus ();uo_equipment.Post of_SetFocus ( "Info" , "" )


end subroutine

public function integer of_setnotebuttons ();IF IsValid ( inv_Shipment ) AND ib_RestrictedView THEN
	
	cb_billnote.Visible = NOT isNull ( inv_Shipment.of_GetBillingComments ( ) ) 
	cb_shipnote.Visible = NOT isNull ( inv_Shipment.of_GetShipmentComments ( ) )

Else 
	//MessageBox ( "Shipment" , "Not Valid" )
END IF

RETURN 1
end function

public subroutine of_syncbillto ();IF IsValid ( inv_Shipment ) THEN
	
	uo_billto.of_SetBillToID ( inv_Shipment.of_GetBillto ( ) )
	
END IF
end subroutine

public function integer of_accepttext ();uo_equipment.event ue_SyncEquipment ( )
RETURN 1
end function

public function integer of_formatforcontext ();dw_shipinfo.of_DetermineInitialContext ( )
RETURN 1
end function

public subroutine of_shownoteicons ();uo_shipnote.of_ShowIcons ( ) 
end subroutine

on u_tabpg_intermodalshipinfo.create
int iCurrent
call super::create
this.uo_equipment=create uo_equipment
this.cb_shipnote=create cb_shipnote
this.cb_billnote=create cb_billnote
this.uo_billto=create uo_billto
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_equipment
this.Control[iCurrent+2]=this.cb_shipnote
this.Control[iCurrent+3]=this.cb_billnote
this.Control[iCurrent+4]=this.uo_billto
this.Control[iCurrent+5]=this.st_1
end on

on u_tabpg_intermodalshipinfo.destroy
call super::destroy
destroy(this.uo_equipment)
destroy(this.cb_shipnote)
destroy(this.cb_billnote)
destroy(this.uo_billto)
destroy(this.st_1)
end on

event ue_shipmentchanged;call super::ue_shipmentchanged;IF IsValid ( anv_Shipment ) THEN
	
	uo_equipment.of_RetrieveEquipment ( anv_Shipment.of_GetID ( ) )	
	dw_shipinfo.of_SetContext ( anv_Shipment.of_GetMoveCode ( ) )
	uo_billto.of_SetBillToId (  anv_Shipment.of_GetBillTo ( ) ) 
	
	
	//IF gnv_App.of_Getprivsmanager( ).of_Getuserpermissionfromfn( "ModifyShipment" , anv_Shipment ) =  gnv_App.of_Getprivsmanager( ).ci_True THEN
		uo_billto.of_Enable ( anv_Shipment.of_AllowEditBill ( ) )
	//ELSE
	//	uo_billto.of_Enable ( FALSE )
	//END IF
	
END IF

Long	ll_ChassisPU
Long	ll_ChassisRtn
Long	ll_TrailerRtn
Long	ll_TrailerPU

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_Events			lnv_Events
PowerObject 			lpo_Cache

lnv_Dispatch = THIS.Event ue_GetDispatch ( )

IF IsValid ( lnv_Dispatch ) THEN
	lpo_Cache = lnv_Dispatch.of_GetEventCache ( )
	ll_ChassisPU = lnv_Events.of_GetChassisPuLocation ( lpo_Cache ) 
	ll_ChassisRtn = lnv_Events.of_GetChassisRtnLocation ( lpo_Cache ) 
	ll_TrailerRtn = lnv_Events.of_GetTrailerRtnLocation ( lpo_Cache ) 
	ll_TrailerPU = lnv_Events.of_GetTrailerPULocation ( lpo_Cache )
	
	uo_equipment.of_SetChassisPuLocation ( ll_ChassisPu ) 
	uo_equipment.of_SetChassRtnLocation ( ll_ChassisRtn ) 	
	uo_equipment.of_SetTrailerPULocation ( ll_TrailerPu ) 
	uo_equipment.of_SetTrailerRtnLocation ( ll_TrailerRtn ) 
END IF 

THIS.Post of_SetNoteButtons ( )


RETURN AncestorReturnValue 	
	

end event

event constructor;call super::constructor;IF ib_RestrictedView THEN
	dw_shipinfo.SetTabOrder ( "ds_ship_comment", 0 )
	dw_shipinfo.SetTabOrder ( "ds_Bill_comment", 0 )
END IF

end event

event ue_restrictedit;call super::ue_restrictedit;//Boolean	lb_Enable


//IF gnv_app.of_Getprivsmanager( ).of_Getuserpermissionfromfn( "ModifyShipment" , dw_shipinfo.event ue_getshipment( ) ) = appeon_constant.ci_True THEN
//	n_cst_Setting_EnableShipNote	lnv_ShipNote
//	lnv_ShipNote = CREATE n_cst_Setting_EnableShipNote
//	lb_Enable = lnv_Shipnote.of_GetValue ( ) = lnv_ShipNote.cs_Yes or ab_value
//	DESTROY ( lnv_ShipNote ) 
//ELSE
//	lb_Enable = FALSE	
//END IF
//
//uo_shipnote.Enabled = lb_Enable
uo_billto.of_enable( ab_value )
uo_equipment.of_SetEnable( ab_Value )

RETURN 1
end event

event ue_refreshshipment;n_cst_bso_Dispatch	lnv_Disp
lnv_Disp = THIS.Event ue_GetDispatch ( )

IF isValid ( lnv_Disp ) THEN
	lnv_Disp.of_FilterShipment  ( al_ShipmentId ) 
ELSE
	MessageBox ( "Refresh" , "Could not get a handle to the dispatch." ) 
END IF


end event

event ue_setfocus;uo_equipment.of_SetFocus ( "EQUIPMENT" , "" )
end event

type dw_shipinfo from u_tabpg_shipinfo`dw_shipinfo within u_tabpg_intermodalshipinfo
integer x = 0
integer y = 0
integer width = 4251
integer height = 872
integer taborder = 40
end type

event dw_shipinfo::ue_getshipment;RETURN inv_Shipment 
end event

event dw_shipinfo::ue_getshiptypemanager;RETURN PARENT.Event ue_GetShipTypemanager ( )
end event

event dw_shipinfo::ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatch ( )
end event

event dw_shipinfo::ue_shiptypechanged;call super::ue_shiptypechanged;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return = 1 THEN
	Parent.Event ue_ShipTypeChanged ( al_value )
END IF

RETURN ll_Return
end event

event dw_shipinfo::ue_getshiptype;n_cst_ship_Type	lnv_ShipTypeManager
n_cst_ShipType		lnv_ShipType

Long	ll_ShipType

lnv_ShipTypeManager.of_Ready ( TRUE ) 
IF IsValid( inv_Shipment ) THEN
	ll_ShipType = inv_Shipment.of_GetType ( )
Else
	MessageBox ("ship type" , "Shipment not valid" )
END IF

lnv_ShipTypeManager.of_Get_Object ( ll_ShipType , lnv_ShipType )

RETURN lnv_ShipType 

end event

event dw_shipinfo::itemchanged;call super::itemchanged;Choose Case dwo.name
		
	CASE "lastfreedate" , "pickupbydate"
		n_cst_setting_setshipdate	lnv_SetDate
		lnv_SetDate = CREATE n_cst_setting_setshipdate
		IF lnv_SetDate.of_GetValue ( ) = lnv_SetDate.cs_yes THEN
			THIS.SetItem ( row , "ds_Ship_Date" ,  Date ( data ))
		END IF
		DESTROY ( lnv_SetDate )
		
	
END CHOOSE 

RETURN AncestorReturnValue
end event

event dw_shipinfo::ue_bookingnumberchanged;n_cst_beo_Shipment	lnv_Shipment


lnv_Shipment = THIS.Event ue_GetShipment ( )

IF isValid ( lnv_Shipment ) THEN
	
	IF lnv_Shipment.of_GetRef1type ( ) = 18 THEN
		lnv_Shipment.of_SetRef1Text ( as_value )
	END IF
	
END IF

RETURN 1
end event

event dw_shipinfo::ue_releasetimechanged;call super::ue_releasetimechanged;//uo_equipment.Post Event ue_SyncEquipment ( )
uo_equipment.of_SetReleaseTime ( at_value ) 
Parent.Post Event ue_RefreshEquipment ( )
RETURN 1
end event

event dw_shipinfo::ue_releasedatechanged;call super::ue_releasedatechanged;//uo_equipment.Post Event ue_SyncEquipment ( )
uo_equipment.of_SetReleaseDate ( ad_value ) 
Parent.Post Event ue_RefreshEquipment ( )

RETURN 1
end event

event dw_shipinfo::ue_emptyatcustomerdatechanged;call super::ue_emptyatcustomerdatechanged;uo_equipment.event ue_syncequipment( )
end event

type uo_shipnote from u_tabpg_shipinfo`uo_shipnote within u_tabpg_intermodalshipinfo
integer x = 3259
integer y = 512
end type

type uo_equipment from u_cst_shipequipment within u_tabpg_intermodalshipinfo
integer x = 5
integer height = 872
integer taborder = 10
boolean bringtotop = true
end type

on uo_equipment.destroy
call u_cst_shipequipment::destroy
end on

event ue_getdispatch;RETURN Parent.Event ue_GetDispatch () 
end event

event ue_getshipment;RETURN inv_Shipment 
end event

event ue_trailerpuchanged;Long		ll_ItemCount
Long		ll_Hook
Long		ll_Mount
Long		ll_Chassis
Boolean	lb_Rate = TRUE

n_cst_beo_Event		lnv_Event
n_cst_Events			lnv_Events
n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_anyarraysrv		lnv_arraySrv
n_cst_beo_Item			lnva_Items[]

lnv_Dispatch =THIS.Event ue_GetDispatch ( )

IF isValid ( lnv_Dispatch ) AND IsValid ( inv_Shipment ) THEN
	IF lnv_Events.of_HasFrontChassisSplit ( lnv_Dispatch.of_GetEventCache ( ) ) THEN
		
		lnv_Events.of_GetFrontChassisSplitSites ( ll_Hook , ll_Mount , lnv_Dispatch.of_GetEventCache ( ) )
		IF ll_Hook <> ll_Mount THEN
			
			// need to add the item		
			ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_frontchassissplit, lnva_Items ) 						
			IF ll_ItemCount = 0 THEN
				lb_Rate = FALSE
				inv_Shipment.Post of_AddFrontChassisSplitItem ( lnv_Dispatch )				
			END IF

			lnv_ArraySrv.of_Destroy ( lnva_Items )		
			
		END IF	

	ELSE  // no split 
		
		ll_Chassis =	uo_equipment.of_GetChassisPuLocation( ) 
		IF ll_Chassis <> al_siteid THEN
			Parent.Post Event ue_FrontSplitAdded ( ) 
			THIS.Event ue_ChassisPUChanged ( al_SiteID ) 
		END IF
	END IF
	 
	lnv_Event = lnv_Events.of_GetTrailerPuEvent ( lnv_Dispatch.of_GetEventCache ( ) )
	IF isValid  ( lnv_Event ) THEN
		lnv_Event.of_SetShipment ( THIS.Event ue_GetShipment ( )) 
		lnv_Event.of_SetSite ( al_SiteID )
	END IF
	
	IF lb_Rate THEN
		inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_FrontChassissplit )
	END IF
		
	Parent.Event ue_RefreshShipment ( inv_shipment.of_GetID ( ) ) 
	
END IF

Parent.Event ue_TrailerPuChanged ( al_siteid )

DESTROY ( lnv_Event ) 

RETURN 1
end event

event ue_trailerrtnchanged;Long		ll_ItemCount
Long		ll_Dismount
Long		ll_Drop
Long		ll_Chassis
Long		ll_RowCount
Boolean	lb_Rate = TRUE

n_cst_beo_Item		lnva_Items[]
n_cst_Dws			lnv_Dws
n_cst_Events		lnv_Events
n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch lnv_Dispatch
n_cst_anyarraysrv	lnv_arraySrv

lnv_Dispatch = THIS.Event ue_GetDispatch ( )

IF isValid ( lnv_Dispatch ) AND  isValid ( inv_Shipment ) THEN
	
	ll_RowCount = lnv_Dws.of_RowCount ( lnv_Dispatch.of_GetEventCache ( ) )
	
	IF lnv_Events.of_HasBackChassisSplit ( lnv_Dispatch.of_GetEventCache ( ) ) THEN
		lnv_Events.of_GetBackChassisSplitSites ( ll_Dismount , ll_Drop , lnv_Dispatch.of_GetEventCache ( ) )
		IF ll_Dismount <> ll_Drop THEN
		
			ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_Backchassissplit, lnva_Items ) 			
			IF ll_ItemCount = 0 THEN
				lb_Rate = FALSE
				inv_Shipment.of_AddBackChassisSplitItem ( lnv_Dispatch )
			END IF
			
			lnv_ArraySrv.of_Destroy ( lnva_Items )			
						
		END IF	
	ELSE
		ll_Chassis =	uo_equipment.of_GetChassisRtnLocation (  ) 
		IF ll_Chassis <> al_siteid AND ll_RowCount > 2 THEN   
			Parent.Post Event ue_BackSplitAdded ( ) 
			THIS.Event ue_ChassisRtnChanged ( al_siteid )
		END IF
		
	END IF
	
	lnv_Event = lnv_Events.of_GetTrailerRtnEvent ( lnv_Dispatch.of_GetEventCache ( ) )
	IF isValid  ( lnv_Event ) THEN
		lnv_Event.of_SetShipment ( THIS.Event ue_GetShipment ( )) 
		lnv_Event.of_SetSite ( al_SiteID )
	END IF
	
	IF lb_Rate THEN
		inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_BackChassissplit )
	END IF

	Parent.Event ue_RefreshShipment ( inv_Shipment.of_GetID ( ) )
	
END IF

Parent.Event ue_TrailerRtnChanged ( al_siteid )

DESTROY ( lnv_Event ) 


RETURN 1
end event

event ue_chassisrtnchanged;Boolean		lb_ConvertFirst
Boolean		lb_ConvertLast
Long			ll_ItemID
Long			ll_RowCount
Long			lla_NewIds[]
Long			ll_ItemCount
Long			ll_Return = 1
Long			ll_newEventID

n_cst_beo_Item			lnva_Items[]
n_cst_anyarraysrv		lnv_Arraysrv
n_cst_Dws				lnv_Dws
n_cst_beo_Item			lnv_Item
n_csT_beo_Event		lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_ShipmentManager	lnv_ShipmentManager
n_Cst_Events	lnv_Events

lnv_Dispatch = THIS.Event ue_GetDispatch ( )

lnv_Item = CREATE n_cst_beo_Item
lnv_Event = CREATE n_cst_beo_Event

lb_ConvertFirst = FALSE
lb_ConvertLast = TRUE

IF Not ( isValid ( lnv_Dispatch ) AND isValid ( inv_Shipment ) ) THEN
	ll_Return = -1
END IF

IF ll_Return = 1 THEN
	
	ll_RowCount = lnv_Dws.of_RowCount ( lnv_Dispatch.of_GetEventCache ( ) )
	
	IF NOT lnv_Events.of_HasBackChassisSplit ( lnv_Dispatch.of_GetEventCache ( ) ) THEN	
		// see if the site is the same as the dismount
		lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Event.of_SetSourceRow ( ll_RowCount  ) 
		IF lnv_Event.of_GetType ( ) = gc_dispatch.cs_EventType_Drop THEN
			
			IF lnv_Event.of_GetSite ( ) <> al_siteid AND ll_rowCount >= 2 AND al_SiteID > 0 THEN	// changed to >= 2 to support one-way <<*>>
				
				IF inv_Shipment.of_AddChassisMove ( al_siteid ,  lnv_Dispatch, lla_newids, lb_ConvertFirst , lb_ConvertLast ) = 1 THEN
					// need to add the item		
					ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_Backchassissplit, lnva_Items ) 						
					IF ll_ItemCount = 0 THEN
						inv_Shipment.Post of_AddBackChassisSplitItem ( lnv_Dispatch )				
					END IF
					Parent.Post Event ue_BackSplitAdded ( ) 
					lnv_ArraySrv.of_Destroy ( lnva_Items )			
					
				END IF
	
			END IF
			
		ELSEIF lnv_Event.of_GetType ( ) = gc_dispatch.cs_EventType_Dismount THEN
			IF lnv_Event.of_GetSite ( ) <> al_siteid AND ll_rowCount >= 2 AND al_SiteID > 0 THEN
				inv_Shipment.of_addevent( gc_dispatch.cs_EventType_Drop , ll_rowCount + 1, lnv_Dispatch, ll_newEventID , al_SiteID )
				
				ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_Backchassissplit, lnva_Items ) 						
				IF ll_ItemCount = 0 THEN
					inv_Shipment.Post of_AddBackChassisSplitItem ( lnv_Dispatch )				
				END IF
				Parent.Post Event ue_BackSplitAdded ( ) 
				lnv_ArraySrv.of_Destroy ( lnva_Items )						
								
			END IF
			
		END IF
					
	ELSE
		
		IF IsNull ( al_siteid ) OR al_siteid = 0  THEN
			Parent.Event ue_PreRemoveSplit ( )
			lnv_ShipmentManager.of_RemoveBackChassisSplit ( inv_Shipment , lnv_Dispatch ) 	
		ELSE
			lnv_Events.of_setBackchassisSplitSite ( al_siteid, lnv_Dispatch.of_GetEventCache ( ) )			
			inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_BackChassissplit )
		END IF
	
	END IF
	
	Parent.Event ue_RefreshShipment ( inv_Shipment.of_GetID ( ) )		
	//THIS.Post of_SetFocus ("SITES" , "CHASSISRTN" )
	
END IF
Parent.Event ue_ChassisRtnChanged ( al_siteid )
DESTROY ( lnv_Item ) 
DESTROY ( lnv_Event ) 

RETURN ll_Return
end event

event ue_chassispuchanged;Long			lla_NewIds[]
Boolean		lb_ConvertFirst
Boolean		lb_ConvertLast
Long			ll_ItemID
Long			ll_ItemCount
Long			ll_Return = 1
Long			ll_EventID

n_cst_anyarraySrv	lnv_ArraySrv
n_cst_beo_Item			lnva_Items[]
n_cst_beo_Item			lnv_Item
n_csT_beo_Event		lnv_Event
n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_ShipmentManager	lnv_ShipmentManager
n_Cst_Events	lnv_Events

lnv_Dispatch = THIS.Event ue_GetDispatch ( )

lnv_Item = CREATE n_cst_beo_Item
lnv_Event = CREATE n_cst_beo_Event

lb_ConvertFirst = TRUE
lb_ConvertLast = FALSE

IF Not ( isValid ( lnv_Dispatch ) AND isValid( inv_Shipment )  )THEN
	ll_Return = -1
END IF

IF ll_Return = 1 THEN
	
	IF NOT lnv_Events.of_HasFrontChassisSplit ( lnv_Dispatch.of_GetEventcache ( ) ) THEN
		// see if the site is the same as the hook
		lnv_Event.of_SetSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Event.of_SetSourceRow ( 1 ) 
		IF lnv_Event.of_GetType ( ) = gc_dispatch.cs_EventType_Hook THEN
			IF lnv_Event.of_GetSite ( ) <> al_siteid AND al_SiteID > 0 THEN			
				IF inv_Shipment.of_AddChassisMove ( al_siteid ,  lnv_Dispatch, lla_newids, lb_ConvertFirst , lb_ConvertLast ) = 1 THEN
					// need to add the item		
					ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_frontchassissplit, lnva_Items ) 						
					IF ll_ItemCount = 0 THEN				
						inv_Shipment.Post of_AddFrontChassisSplitItem ( lnv_Dispatch )				
					END IF
					
					lnv_ArraySrv.of_Destroy ( lnva_Items )			
								
				END IF

				Parent.Post Event ue_FrontSplitAdded ( )
				
			END IF
		ELSEIF lnv_Event.of_GetType ( ) = gc_dispatch.cs_EventType_Mount THEN
			inv_Shipment.of_AddEvent( gc_dispatch.cs_EventType_Hook, 1, lnv_Dispatch , ll_EventID , al_SiteID )
			// need to add the item		
			ll_ItemCount = inv_Shipment.of_getitemsforeventtype (n_cst_constants.cs_itemeventtype_frontchassissplit, lnva_Items ) 						
			IF ll_ItemCount = 0 THEN				
				inv_Shipment.Post of_AddFrontChassisSplitItem ( lnv_Dispatch )				
			END IF
			
			lnv_ArraySrv.of_Destroy ( lnva_Items )		
			
		END IF
			
	ELSE
	
		IF IsNull ( al_siteid ) OR al_siteid = 0  THEN
			Parent.Event ue_PreRemoveSplit ( )
			lnv_ShipmentManager.of_RemovefrontChassisSplit ( inv_Shipment , lnv_Dispatch ) 	
		ELSE
			lnv_Events.of_setFrontchassisSplitSite ( al_siteid, lnv_Dispatch.of_GetEventCache ( ) )
			inv_Shipment.of_AutoRateEventTypeItem ( n_cst_constants.cs_itemeventtype_FrontChassissplit )
		END IF
	
	END IF
	
	Parent.Event ue_RefreshShipment ( inv_Shipment.of_GetID ( ) )
	//THIS.Post of_SetFocus ("SITES" , "CHASSISPU" )
	
	
END IF

Parent.Event ue_ChassisPuChanged ( al_siteid )

DESTROY ( lnv_Item ) 
DESTROY ( lnv_Event ) 

RETURN ll_Return 
end event

event ue_displayshipment;RETURN Parent.Event ue_DisplayShipment ( al_shipmentid )
end event

type cb_shipnote from commandbutton within u_tabpg_intermodalshipinfo
boolean visible = false
integer x = 1193
integer y = 752
integer width = 288
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ship Note"
end type

event clicked;PARENT.Event ue_ShowShipNote ( )
end event

type cb_billnote from commandbutton within u_tabpg_intermodalshipinfo
boolean visible = false
integer x = 1490
integer y = 752
integer width = 288
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Bill Note"
end type

event clicked;PARENT.Event ue_ShowBillNote ( )
end event

type uo_billto from u_cst_sle_company within u_tabpg_intermodalshipinfo
integer x = 1189
integer y = 652
integer width = 585
integer taborder = 30
boolean bringtotop = true
long backcolor = 80269524
end type

event constructor;call super::constructor;THIS.of_SetWidth ( 590 ) 
THIS.of_SetBillToMode ( TRUE )
end event

on uo_billto.destroy
call u_cst_sle_company::destroy
end on

event ue_companychanged;Long	ll_ID

ll_ID = THIS.of_GetID ( ) 

IF isValid ( inv_Shipment ) THEN
	inv_Shipment.Of_SetBillToID ( ll_ID )	
END IF

Parent.Event ue_BillToChanged ( )

RETURN 1
end event

event ue_billtospecial;Long	ll_return = 1, &
		ll_Origin, &
		ll_Destination, &
		ll_Billto
		
n_cst_beo_company	lnv_company

IF as_value = '?' THEN
	
	IF isValid ( inv_Shipment ) THEN
		
		ll_Origin = inv_Shipment.Of_GetOrigin()
		
		if isnull(ll_origin) or ll_origin = 0 then
			messagebox('Billto Selection', "The shipment must have an origin when using the '?' to assign the Billto.")
			this.of_settext('')
			ll_return = -1
		else
			ll_Destination = inv_Shipment.Of_GetDestination()
			if isnull(ll_Destination) or ll_Destination = 0 then
				messagebox('Billto Selection', "The shipment must have a destination when using the '?' to assign the Billto.")
				this.of_settext('')
				ll_return = -1
			end if
		end if
		
		if ll_return = 1 then
			
		  SELECT "billtopoints"."id"  
			 INTO :ll_Billto  
			 FROM "billtopoints"  
			WHERE ( "billtopoints"."origin" = :ll_origin ) AND  
					( "billtopoints"."destination" = :ll_destination )   ;
			
			if sqlca.sqlcode = 0 then
				//force company in

				lnv_company = CREATE n_cst_beo_Company
				
				gnv_cst_Companies.of_Cache ( ll_Billto, TRUE )			
				
				lnv_company.of_SetUseCache ( TRUE )
				
				IF lnv_company.of_SetSourceId ( ll_Billto ) = 1 THEN
					IF lnv_company.of_HasSource ( ) THEN
						//set name
						this.of_settext(lnv_company.of_GetName())
						
						inv_Shipment.Of_SetBillToID ( ll_Billto )	
					END IF
				END IF

				Parent.Event ue_BillToChanged ( )
				
			ELSE
				
				messagebox('Billto Selection', 'No Billto has been specified for the shipment origin/destination. '+&
				'You can add one in the Billto Origin/Destination Points window.')
				
			END IF
			
			commit;
			
		END IF	
		
	END IF
	
END IF
end event

type st_1 from statictext within u_tabpg_intermodalshipinfo
integer x = 1189
integer y = 572
integer width = 590
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "&Bill To Name"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event clicked;uo_billto.Post Event ue_SetFocus ( )
end event

event getfocus;uo_billto.Post Event ue_SetFocus ( )
end event

