$PBExportHeader$u_tabpg_extendedintermodal.sru
forward
global type u_tabpg_extendedintermodal from u_tabpg_shipinfo
end type
type dw_forwarder from u_dw_co_location within u_tabpg_extendedintermodal
end type
type dw_agent from u_dw_co_location within u_tabpg_extendedintermodal
end type
end forward

global type u_tabpg_extendedintermodal from u_tabpg_shipinfo
integer width = 4439
integer height = 952
long backcolor = 12632256
dw_forwarder dw_forwarder
dw_agent dw_agent
end type
global u_tabpg_extendedintermodal u_tabpg_extendedintermodal

forward prototypes
public subroutine of_shownoteicons ()
public function integer of_accepttext (boolean ab_focusonerror)
end prototypes

public subroutine of_shownoteicons ();uo_shipnote.of_ShowIcons ( ) 
end subroutine

public function integer of_accepttext (boolean ab_focusonerror);Int	li_Return	

li_Return = dw_shipinfo.AcceptText ( )

RETURN li_Return
end function

on u_tabpg_extendedintermodal.create
int iCurrent
call super::create
this.dw_forwarder=create dw_forwarder
this.dw_agent=create dw_agent
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_forwarder
this.Control[iCurrent+2]=this.dw_agent
end on

on u_tabpg_extendedintermodal.destroy
call super::destroy
destroy(this.dw_forwarder)
destroy(this.dw_agent)
end on

event ue_shipmentchanged;call super::ue_shipmentchanged;
Long	ll_Co

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
//dw_shipinfo.Event ue_shipmentChanged( )
//dw_shipinfo.of_DetermineDisplayRestrictions ( )

RETURN AncestorReturnValue

end event

event ue_restrictedit;call super::ue_restrictedit;dw_forwarder.of_SetEnable ( ab_Value )
dw_agent.of_SetEnable ( ab_Value )

//n_cst_Setting_EnableShipNote	lnv_ShipNote
//lnv_ShipNote = CREATE n_cst_Setting_EnableShipNote
//uo_shipnote.Enabled = ( lnv_Shipnote.of_GetValue ( ) = lnv_ShipNote.cs_Yes )  OR ab_value
//DESTROY ( lnv_ShipNote ) 


RETURN 1
end event

event ue_setfocus;dw_shipinfo.SetFocus ( )
dw_shipinfo.SetColumn ( "originport" ) 
end event

type dw_shipinfo from u_tabpg_shipinfo`dw_shipinfo within u_tabpg_extendedintermodal
integer x = 5
integer y = 0
integer width = 4361
integer height = 876
string dataobject = "d_extendedintermodal"
end type

event dw_shipinfo::ue_getshipment;RETURN inv_Shipment 
end event

event dw_shipinfo::ue_getdispatchmanager;Return Parent.Event ue_GetDispatch ( )
end event

event dw_shipinfo::itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
		
	CASE "billto_name"
		Parent.Event ue_BillToChanged ( )
END CHOOSE

RETURN AncestorReturnValue
end event

type uo_shipnote from u_tabpg_shipinfo`uo_shipnote within u_tabpg_extendedintermodal
end type

type dw_forwarder from u_dw_co_location within u_tabpg_extendedintermodal
integer x = 1929
integer y = 528
integer width = 617
integer height = 276
integer taborder = 20
boolean bringtotop = true
end type

event ue_companychanged;IF IsValid ( inv_Shipment ) THEN
	inv_Shipment.of_SetForwarder ( al_id )
END IF

dw_shipinfo.Event ue_forwarderChanged ( al_ID ) 

RETURN 1
end event

type dw_agent from u_dw_co_location within u_tabpg_extendedintermodal
integer x = 2610
integer y = 528
integer width = 617
integer height = 276
integer taborder = 30
boolean bringtotop = true
end type

event ue_companychanged;IF IsValid ( inv_Shipment ) THEN
	inv_Shipment.of_SetAgent ( al_id )
END IF
dw_shipinfo.event ue_agentchanged( al_id )

RETURN 1
end event

