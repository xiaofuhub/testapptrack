$PBExportHeader$u_cst_shipequipment.sru
forward
global type u_cst_shipequipment from u_base
end type
type uo_eqinfo from u_cst_oebasics within u_cst_shipequipment
end type
type uo_equipmentlocation from u_cst_equipmentlocation within u_cst_shipequipment
end type
end forward

global type u_cst_shipequipment from u_base
integer width = 1787
integer height = 876
long backcolor = 12632256
event ue_mousemove pbm_mousemove
event type integer ue_trailerpuchanged ( long al_siteid )
event type integer ue_trailerrtnchanged ( long al_siteid )
event type integer ue_chassispuchanged ( long al_siteid )
event type integer ue_chassisrtnchanged ( long al_siteid )
event ue_gotfocus ( )
event type n_cst_bso_dispatch ue_getdispatch ( )
event ue_syncequipment ( )
event type n_cst_beo_shipment ue_getshipment ( )
event type integer ue_displayshipment ( long al_shipmentid )
uo_eqinfo uo_eqinfo
uo_equipmentlocation uo_equipmentlocation
end type
global u_cst_shipequipment u_cst_shipequipment

type variables
Boolean    ib_PopHelp

end variables

forward prototypes
public function integer of_settrailerequipment (string as_type)
public function long of_gettrailerpulocation ()
public function long of_getchassispulocation ()
public function long of_gettrailerrtnlocation ()
public function integer of_setchassispulocation (long al_id)
public function integer of_setchassrtnlocation (long al_id)
public function integer of_settrailerpulocation (long al_id)
public function integer of_settrailerrtnlocation (long al_id)
public function long of_getchassisrtnlocation ()
public function integer of_retrieveequipment (long al_shipmentid)
public function integer of_setenable (boolean ab_value)
public function integer of_setfocus (string as_object, string as_column)
public function integer of_setreleasedate (date ad_value)
public function integer of_setreleasetime (time at_Value)
end prototypes

event ue_syncequipment;
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Dispatch = THIS.Event ue_GetDispatch ( )

IF isValid ( lnv_dispatch ) THEN
	
	uo_eqinfo.of_SyncEquipmentCache ( lnv_Dispatch ) 
	
END IF

end event

public function integer of_settrailerequipment (string as_type);//uo_Trailer.of_SelectEquipment ( as_type )
RETURN 1
end function

public function long of_gettrailerpulocation ();RETURN -1 //uo_trailer.of_GetPULocation ( )
end function

public function long of_getchassispulocation ();RETURN uo_equipmentlocation.of_GetChassisPuSite ( )
end function

public function long of_gettrailerrtnlocation ();RETURN -1 // uo_trailer.of_GetRTNLocation ( )
end function

public function integer of_setchassispulocation (long al_id);RETURN uo_equipmentlocation.of_SetChassisPuSite ( al_id )
end function

public function integer of_setchassrtnlocation (long al_id);RETURN uo_equipmentlocation.of_SetChassisRtnSite ( al_id )
end function

public function integer of_settrailerpulocation (long al_id);RETURN uo_equipmentlocation.of_SetTrailerPUSite ( al_id )
end function

public function integer of_settrailerrtnlocation (long al_id);RETURN uo_equipmentlocation.of_SetTrailerRtnSite ( al_id )
end function

public function long of_getchassisrtnlocation ();RETURN uo_equipmentlocation.of_GetChassisRtnSite ( )
end function

public function integer of_retrieveequipment (long al_shipmentid);RETURN uo_eqinfo.of_RetrieveEquipment (al_ShipmentID )
end function

public function integer of_setenable (boolean ab_value);uo_eqinfo.of_SetEnable ( ab_Value ) 
uo_equipmentlocation.of_SetEnable ( ab_Value ) 
RETURN 1
end function

public function integer of_setfocus (string as_object, string as_column);IF as_Object = "SITES" THEN
	uo_equipmentlocation.Post of_SetFocus ( as_column )
ELSE
	uo_eqinfo.Post of_SetFocus ( )
	
END IF

RETURN 1
end function

public function integer of_setreleasedate (date ad_value);uo_eqinfo.of_SetReleaseDate ( ad_value )
RETURN 1
end function

public function integer of_setreleasetime (time at_Value);uo_eqinfo.of_SetReleaseTime ( at_value )
RETURN 1
end function

on u_cst_shipequipment.create
int iCurrent
call super::create
this.uo_eqinfo=create uo_eqinfo
this.uo_equipmentlocation=create uo_equipmentlocation
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_eqinfo
this.Control[iCurrent+2]=this.uo_equipmentlocation
end on

on u_cst_shipequipment.destroy
call super::destroy
destroy(this.uo_eqinfo)
destroy(this.uo_equipmentlocation)
end on

type uo_eqinfo from u_cst_oebasics within u_cst_shipequipment
integer x = 9
integer y = 12
integer width = 1765
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_eqinfo.destroy
call u_cst_oebasics::destroy
end on

event ue_getdispatch;Return Parent.event ue_GetDispatch ( )
end event

event ue_getshipment;RETURN Parent.Event ue_GetShipment ( )
end event

event ue_displayshipment;Return Parent.Event ue_DisplayShipment ( al_id )
end event

event constructor;call super::constructor;n_cst_LicenseManager	lnv_LicenseMgr
THIS.Enabled = lnv_LicenseMgr.of_GetLicensed ( n_cst_Constants.cs_Module_Dispatch )
end event

type uo_equipmentlocation from u_cst_equipmentlocation within u_cst_shipequipment
integer x = 9
integer y = 568
integer width = 1166
integer height = 300
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_equipmentlocation.destroy
call u_cst_equipmentlocation::destroy
end on

event ue_chassispuadded;Parent.Event ue_ChassisPuChanged ( al_companyid )
Return 1
end event

event ue_chassisrtnadded;Parent.Event ue_ChassisRtnChanged ( al_companyid )
Return 1
end event

event ue_trailerpuchanged;RETURN Parent.event ue_TrailerPuChanged ( al_siteid )
end event

event ue_trailerrtnchanged;RETURN Parent.event ue_TrailerRtnChanged ( al_siteid )
end event

