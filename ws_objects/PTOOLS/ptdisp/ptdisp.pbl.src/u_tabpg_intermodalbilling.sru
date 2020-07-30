$PBExportHeader$u_tabpg_intermodalbilling.sru
forward
global type u_tabpg_intermodalbilling from u_tabpg_shipinfo
end type
type dw_forwarder from u_dw_co_location within u_tabpg_intermodalbilling
end type
type dw_agent from u_dw_co_location within u_tabpg_intermodalbilling
end type
end forward

global type u_tabpg_intermodalbilling from u_tabpg_shipinfo
integer width = 4306
integer height = 936
long backcolor = 12632256
event ue_ppcolchanged ( )
event ue_notechanged ( )
dw_forwarder dw_forwarder
dw_agent dw_agent
end type
global u_tabpg_intermodalbilling u_tabpg_intermodalbilling

type variables


end variables

forward prototypes
private function integer of_shipmentchanged ()
public subroutine of_format ()
public function integer of_setfocusonshipnote ()
public subroutine of_shownoteicons ()
public function integer of_accepttext (boolean ab_focusonerror)
end prototypes

private function integer of_shipmentchanged ();RETURN -1
end function

public subroutine of_format ();Long	ll_FoundRow
Long	ll_Return = 1
Boolean	lb_Brokerage

n_cst_LicenseManager	lnv_LicenseManager
n_cst_Ship_Type		lnv_ShipTypeManager
n_Cst_beo_Shipment	lnv_Shipment

lnv_Shipment = dw_shipinfo.Event ue_GetShipment ( )

IF ll_Return = 1 AND isValid ( lnv_Shipment ) THEN
	
	lb_Brokerage = lnv_Shipment.of_IsShipTypeBrokerage ( )
	
//	if lb_Brokerage AND lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Brokerage ) then
//		dw_shipinfo.object.billto_address.height=72
//		dw_shipinfo.object.ds_pronum_t.visible=0
//		dw_shipinfo.object.billdate_t.visible=0
//		dw_shipinfo.object.ds_pronum.visible=0
//		dw_shipinfo.object.ds_bill_date.visible=0
//		
//		dw_shipinfo.object.carrier_t.visible=1
//		dw_shipinfo.object.dispatchedby_t.visible=1
//		dw_shipinfo.object.availableon_t.visible=1
//		dw_shipinfo.object.availableuntil_t.visible=1
//		dw_shipinfo.object.pay1_name.visible=1
//		dw_shipinfo.object.dispatchedby.visible=1
//		dw_shipinfo.object.availableon.visible=1
//		dw_shipinfo.object.availableuntil.visible=1
//	else
//		dw_shipinfo.object.billto_address.height=252
//		dw_shipinfo.object.ds_pronum_t.visible=1
//		dw_shipinfo.object.billdate_t.visible=1
//		dw_shipinfo.object.ds_pronum.visible=1
//		dw_shipinfo.object.ds_bill_date.visible=1
//		
//		dw_shipinfo.object.carrier_t.visible=0
//		dw_shipinfo.object.dispatchedby_t.visible=0
//		dw_shipinfo.object.availableon_t.visible=0
//		dw_shipinfo.object.availableuntil_t.visible=0
//		dw_shipinfo.object.pay1_name.visible=0
//		dw_shipinfo.object.dispatchedby.visible=0
//		dw_shipinfo.object.availableon.visible=0
//		dw_shipinfo.object.availableuntil.visible=0
//	end if


END IF
end subroutine

public function integer of_setfocusonshipnote ();uo_shipnote.SetFocus ( )
RETURN 1
end function

public subroutine of_shownoteicons ();uo_shipnote.of_ShowIcons ( ) 
end subroutine

public function integer of_accepttext (boolean ab_focusonerror);Int	li_Return	

li_Return = dw_shipinfo.AcceptText ( )

RETURN li_Return
end function

on u_tabpg_intermodalbilling.create
int iCurrent
call super::create
this.dw_forwarder=create dw_forwarder
this.dw_agent=create dw_agent
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_forwarder
this.Control[iCurrent+2]=this.dw_agent
end on

on u_tabpg_intermodalbilling.destroy
call super::destroy
destroy(this.dw_forwarder)
destroy(this.dw_agent)
end on

event ue_shipmentchanged;call super::ue_shipmentchanged;Long	ll_Co

IF IsValid ( anv_shipment ) THEN
	ll_Co = anv_shipment.of_GetAgent ( )
	IF IsNull ( ll_Co ) THEN
		ll_Co = 0
	END IF
	dw_agent.of_LoadCompany ( ll_Co )
	
	ll_Co = anv_shipment.of_GetForwarder ( )
	IF IsNull ( ll_Co ) THEN
		ll_Co = 0
	END IF
	dw_forwarder.of_LoadCompany ( ll_Co )
END IF

RETURN AncestorReturnValue 
end event

event ue_setfocus;dw_shipinfo.SetColumn ( "ds_ship_date" )
dw_shipinfo.Post SetFocus ( )
end event

event ue_restrictedit;call super::ue_restrictedit;dw_forwarder.of_SetEnable ( ab_Value )
dw_agent.of_SetEnable ( ab_Value ) 

//n_cst_Setting_EnableShipNote	lnv_ShipNote
//lnv_ShipNote = CREATE n_cst_Setting_EnableShipNote
//uo_shipnote.Enabled = lnv_Shipnote.of_GetValue ( ) = lnv_ShipNote.cs_Yes OR ab_value
//DESTROY ( lnv_ShipNote ) 
//Boolean	lb_Enable
//
//
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


RETURN 1
end event

type dw_shipinfo from u_tabpg_shipinfo`dw_shipinfo within u_tabpg_intermodalbilling
integer x = 0
integer width = 4274
integer height = 908
string dataobject = "d_shipmentbillinginfo"
end type

event dw_shipinfo::ue_setcontextexport;// OverRide
RETURN 
end event

event dw_shipinfo::ue_setcontextimport;// OverRide
RETURN 
end event

event dw_shipinfo::ue_setcontextnone;// OverRide
RETURN 
end event

event dw_shipinfo::ue_setcontextoneway;// OverRide
RETURN 
end event

event dw_shipinfo::ue_getshipment;RETURN inv_Shipment 
end event

event dw_shipinfo::ue_getshiptypemanager;RETURN PARENT.Event ue_GetShipTypemanager ( )
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

event dw_shipinfo::ue_shiptypechanged;call super::ue_shiptypechanged;Parent.Post of_Format ( )
IF AncestorReturnValue = 1 THEN
	Parent.Event ue_ShipTypeChanged ( al_value )
END IF
RETURN AncestorReturnValue
end event

event dw_shipinfo::ue_getdispatchmanager;RETURN PARENT.Event ue_GetDispatch ( )
end event

event dw_shipinfo::ue_ppcolchanged;Parent.Event ue_PPColChanged ( )
end event

event dw_shipinfo::itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
		
	CASE "ds_ship_comment" , "ds_bill_comment"
		PARENT.Post Event ue_NoteChanged ( ) 
		
	CASE "billto_name"
		Parent.Event ue_BillToChanged ( )
END CHOOSE

RETURN AncestorReturnValue
end event

event dw_shipinfo::buttonclicked;call super::buttonclicked;THIS.setRedraw ( TRUE ) 
end event

event dw_shipinfo::ue_billformatchanged;Parent.Event ue_BillFormatChanged ( ) 
end event

event dw_shipinfo::ue_shipmentchanged;call super::ue_shipmentchanged;
// this is here to get the shiptype to display right upon entry
THIS.SetColumn ( "ds_ship_date" )
IF THIS.RowCount ( ) > 0 THEN
	THIS.SetRow ( 1 ) 
END IF
//THIS.Post SetColumn ( "ds_ref1_type" )
//THIS.Post SetColumn ( "billto_name" )
end event

event dw_shipinfo::ue_payformatchanged;Parent.Event ue_PayFormatChanged ( ) 


end event

type uo_shipnote from u_tabpg_shipinfo`uo_shipnote within u_tabpg_intermodalbilling
integer x = 1719
integer y = 308
end type

type dw_forwarder from u_dw_co_location within u_tabpg_intermodalbilling
integer x = 1984
integer y = 496
integer width = 613
integer height = 276
integer taborder = 20
boolean bringtotop = true
end type

event ue_companychanged;IF IsValid ( inv_Shipment ) THEN
	inv_Shipment.of_SetForwarder ( al_id )
END IF
dw_shipinfo.event ue_Forwarderchanged( al_id )

RETURN 1
end event

type dw_agent from u_dw_co_location within u_tabpg_intermodalbilling
integer x = 2629
integer y = 496
integer width = 608
integer height = 276
integer taborder = 30
boolean bringtotop = true
end type

event ue_companychanged;IF IsValid ( inv_Shipment ) THEN
	inv_Shipment.of_SetAgent ( al_id )
END IF

dw_Shipinfo.event ue_agentchanged( al_id )

RETURN 1
end event

