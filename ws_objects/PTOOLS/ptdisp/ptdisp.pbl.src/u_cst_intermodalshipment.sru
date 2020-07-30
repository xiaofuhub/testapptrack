$PBExportHeader$u_cst_intermodalshipment.sru
forward
global type u_cst_intermodalshipment from u_base
end type
type tab_intermodal from u_tab_intermodalshipment within u_cst_intermodalshipment
end type
type tab_intermodal from u_tab_intermodalshipment within u_cst_intermodalshipment
end type
type dw_header from u_dw_intermodalheader within u_cst_intermodalshipment
end type
type st_1 from statictext within u_cst_intermodalshipment
end type
type st_2 from statictext within u_cst_intermodalshipment
end type
type st_3 from statictext within u_cst_intermodalshipment
end type
end forward

global type u_cst_intermodalshipment from u_base
integer width = 3575
integer height = 976
long backcolor = 12632256
long tabbackcolor = 80269524
event ue_mousemove pbm_mousemove
event type integer ue_chassispuadded ( long al_companyid )
event type integer ue_chassisrtnadded ( long al_siteid )
event type n_cst_beo_shipment ue_getshipment ( )
event type integer ue_addchassissplit ( long al_companyid )
event type n_cst_bso_dispatch ue_getdispatch ( )
event type integer ue_trailerpuchanged ( long al_id )
event type integer ue_trailerrtnchanged ( long al_id )
event type n_cst_ship_type ue_getshiptypemanager ( )
event ue_recalcamounts ( integer ai_index,  string as_column )
event ue_frontchassissplitadded ( )
event ue_backchassissplitadded ( )
event type integer ue_displayshipment ( long al_id )
event type n_cst_shiptype ue_getshiptype ( )
event type integer ue_shiptypechanged ( long al_value )
event ue_ppcolchanged ( )
event ue_syncequipment ( )
event ue_billformatchanged ( )
event ue_billtochanged ( )
event ue_preremovesplit ( )
event ue_refreshshipment ( long al_shipmentid )
event ue_refreshequipment ( )
event ue_payformatchanged ( )
event ue_equipmentlocationchanged ( long al_siteid )
tab_intermodal tab_intermodal
dw_header dw_header
st_1 st_1
st_2 st_2
st_3 st_3
end type
global u_cst_intermodalshipment u_cst_intermodalshipment

type prototypes
FUNCTION int  ScrollBar_SetPos ( long al_handle , int al_pos , BOOLEAN ab_redraw ) &
	LIBRARY "kernel32.dll"
	

//SUBROUTINE PP_Unlock ( long pw1, long pw2, long pw3, long pw4) &
//	LIBRARY "PrntPRO1.ocx" ALIAS FOR "PS_UnLock"

end prototypes

type variables
n_cst_beo_Shipment	inv_Shipment
end variables

forward prototypes
public function integer of_setchassispusite (long al_siteid)
public function integer of_setchassisrtnsite (long al_id)
public function integer of_settrailerrtnsite (long al_id)
public function integer of_settrailerpusite (long al_id)
public function integer of_sharedata (powerobject apo_source)
public function integer of_setshipment (n_cst_beo_shipment anv_Shipment)
public function integer of_shipmentchanged (n_cst_beo_shipment anv_shipment)
public function integer of_accepttext ()
public subroutine of_syncbillto ()
end prototypes

event ue_addchassissplit;Long			lla_NewIds[]
Boolean		lb_ConvertFirst
Boolean		lb_ConvertLast
Int			li_Return = -1

n_cst_bso_Dispatch 	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_RateData			lnva_RateData[]

lnv_Dispatch = THIS.Event ue_GetDispatch ( ) 
lnv_Shipment = THIS.Event ue_GetShipment ( )

lb_ConvertFirst = TRUE
lb_ConvertLast = FALSE
	
IF lnv_Shipment.of_AddChassisMove ( al_companyid ,  lnv_Dispatch, lla_newids, lb_ConvertFirst , lb_ConvertLast ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


end event

event ue_trailerpuchanged;// I don't think this is called
n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_Events	lnv_Events

lnv_Dispatch = THIS.Event ue_GetDispatch ( )

lnv_Events.of_SetTrailerPuSite ( al_id, lnv_Dispatch.of_GetEventCache ( ) )

RETURN 1
end event

event ue_trailerrtnchanged;// i don't think this is called
n_cst_bso_Dispatch	lnv_Dispatch
n_Cst_Events	lnv_Events

lnv_Dispatch = THIS.Event ue_GetDispatch ( )

lnv_Events.of_SetTrailerRtnSite ( al_id, lnv_Dispatch.of_GetEventCache ( ) )

RETURN 1
end event

event ue_refreshequipment;tab_intermodal.Event ue_RefreshEquipment ( )
end event

public function integer of_setchassispusite (long al_siteid);RETURN tab_intermodal.of_SetEquipmentLocation ( "CHASSISPU" , al_siteid )

end function

public function integer of_setchassisrtnsite (long al_id);RETURN tab_intermodal.of_SetEquipmentLocation ( "CHASSISRTN" , al_id )
end function

public function integer of_settrailerrtnsite (long al_id);RETURN tab_intermodal.of_SetEquipmentLocation ( "TRAILERRTN" , al_id )
end function

public function integer of_settrailerpusite (long al_id);RETURN tab_intermodal.of_SetEquipmentLocation ( "TRAILERPU" , al_id )
end function

public function integer of_sharedata (powerobject apo_source);//dw_shipinfo.of_ShareData ( apo_source )
//THIS.Post of_RetrieveEquipment ( )

//dw_basicshipinfo.of_ShareData ( apo_source )
//THIS.of_DetermineContext ( )

tab_intermodal.of_SetShareSource ( apo_Source )
dw_header.of_ShareData ( apo_source )

RETURN 1
end function

public function integer of_setshipment (n_cst_beo_shipment anv_Shipment);inv_Shipment = anv_shipment
tab_intermodal.event ue_shipmentChanged ( inv_Shipment )

RETURN 1
end function

public function integer of_shipmentchanged (n_cst_beo_shipment anv_shipment);
THIS.of_SetShipment ( anv_shipment )
dw_header.Post Event ue_ShipmentChanged ( )
RETURN 1
end function

public function integer of_accepttext ();Int	li_Return = -1
IF tab_intermodal.of_AcceptText( ) = 1 THEN
	li_Return = 1 
END IF

RETURN li_Return
end function

public subroutine of_syncbillto ();tab_intermodal.of_SyncBillTo ( )
end subroutine

on u_cst_intermodalshipment.create
int iCurrent
call super::create
this.tab_intermodal=create tab_intermodal
this.dw_header=create dw_header
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_intermodal
this.Control[iCurrent+2]=this.dw_header
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
end on

on u_cst_intermodalshipment.destroy
call super::destroy
destroy(this.tab_intermodal)
destroy(this.dw_header)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event constructor;call super::constructor;THIS.of_SetResize ( TRUE ) 
inv_Resize.of_Register ( tab_intermodal , appeon_constant.scaleright )
end event

type tab_intermodal from u_tab_intermodalshipment within u_cst_intermodalshipment
integer y = 4
integer width = 3328
integer height = 984
integer taborder = 20
boolean bringtotop = true
end type

event ue_getdispatch;RETURN Parent.Event ue_GetDispatch ( ) 
end event

event ue_getshipment;RETURN Parent.Event ue_GetShipment ( ) 
end event

event ue_getshiptypemanager;RETURN PARENT.Event ue_GetShipTypeManager ( )
end event

event ue_displayshipment;RETURN Parent.Event ue_DisplayShipment ( al_shipmentid )
end event

event ue_shiptypechanged;call super::ue_shiptypechanged;Return Parent.Event ue_ShipTypeChanged ( al_value )
end event

event ue_ppcolchanged;Parent.Event ue_PpColChanged ( )
end event

event ue_billformatchanged;Parent.Event ue_BillFormatChanged ( ) 
end event

event ue_billtochanged;Parent.Event ue_BilltoChanged ( )
end event

event ue_preremovesplit;Parent.Event ue_PreRemoveSplit ( )
end event

event ue_refreshshipment;Parent.Event ue_RefreshShipment ( al_ShipmentID ) 
end event

event ue_payformatchanged;Parent.Event ue_PayFormatChanged ( ) 
end event

event ue_frontsplitadded;Parent.Event ue_FrontChassisSplitAdded ( )
end event

event ue_backsplitadded;Parent.Event ue_BackChassisSplitAdded ( )
end event

event ue_equipmentlocationchanged;call super::ue_equipmentlocationchanged;Parent.event ue_equipmentlocationchanged( al_siteid )
end event

type dw_header from u_dw_intermodalheader within u_cst_intermodalshipment
integer x = 1253
integer y = 8
integer height = 76
integer taborder = 10
boolean bringtotop = true
end type

event ue_getshipment;RETURN inv_Shipment 
end event

event ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatch ( )
end event

type st_1 from statictext within u_cst_intermodalshipment
integer x = 3287
integer y = 220
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
string text = "&1"
boolean focusrectangle = false
end type

event getfocus;If isValid ( inv_Shipment ) THEN
	IF inv_SHipment.of_IsIntermodal ( ) THEN
		tab_intermodal.SelectTab ( appeon_constant.ci_tabpage_shipinfo ) 
		tab_intermodal.Tabpage_Shipment.Event ue_SetFocus ( )
	ELSE
		tab_intermodal.SelectTab ( appeon_constant.ci_tabpage_extendedshipinfo ) 
		tab_intermodal.Tabpage_ExtendedShipInfo.Event ue_SetFocus ( )
	END IF
END IF

end event

type st_2 from statictext within u_cst_intermodalshipment
integer x = 3273
integer y = 296
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
string text = "&2"
boolean focusrectangle = false
end type

event getfocus;//If isValid ( inv_Shipment ) THEN
	//IF inv_SHipment.of_IsIntermodal ( ) THEN
		tab_intermodal.SelectTab ( appeon_constant.ci_tabpage_billing )
		tab_intermodal.Tabpage_Billing.Event ue_SetFocus ( )

	//ELSE
	//	tab_intermodal.SelectTab ( appeon_constant.ci_tabpage_extendedshipinfo ) 
	//	tab_intermodal.Tabpage_ExtendedShipInfo.Event ue_SetFocus ( )
	//END IF
//END IF

end event

type st_3 from statictext within u_cst_intermodalshipment
integer x = 3296
integer y = 376
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
string text = "&3"
boolean focusrectangle = false
end type

event getfocus;IF IsValid ( inv_Shipment ) THEN
	IF inv_SHipment.of_IsIntermodal ( ) THEN
		tab_intermodal.SelectTab ( appeon_constant.ci_tabpage_extended ) 
		tab_intermodal.Tabpage_ExtendedInfo.Event ue_SetFocus ( )
	END IF
END IF

end event

