$PBExportHeader$u_tabpg_shipment_notification.sru
forward
global type u_tabpg_shipment_notification from u_tabpg
end type
type uo_1 from u_cst_shipment_notification within u_tabpg_shipment_notification
end type
end forward

global type u_tabpg_shipment_notification from u_tabpg
int Width=2281
int Height=1152
long BackColor=12632256
event ue_templatechanged ( string as_template )
event type n_cst_bso_dispatch ue_getdispatchobject ( )
uo_1 uo_1
end type
global u_tabpg_shipment_notification u_tabpg_shipment_notification

forward prototypes
public function integer of_retrievecontacts ()
public function integer of_setshipmentid (long al_ShipmentID)
public function integer of_settemplate (string as_Template)
end prototypes

public function integer of_retrievecontacts ();uo_1.of_RetrieveContacts ( ) 
RETURN 1
end function

public function integer of_setshipmentid (long al_ShipmentID);uo_1.of_SetShipmentID ( al_ShipmentID )
RETURN 1
end function

public function integer of_settemplate (string as_Template);RETURN uo_1.of_SetTemplate ( as_Template ) 
end function

on u_tabpg_shipment_notification.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_shipment_notification.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_shipment_notification within u_tabpg_shipment_notification
int X=0
int Y=0
int TabOrder=10
boolean BringToTop=true
end type

on uo_1.destroy
call u_cst_shipment_notification::destroy
end on

event ue_templatechanged;Parent.Event ue_TemplateChanged ( as_template )

RETURN 1

end event

event ue_getdispatchobject;RETURN Parent.Event ue_GetDispatchObject ( ) 
end event

