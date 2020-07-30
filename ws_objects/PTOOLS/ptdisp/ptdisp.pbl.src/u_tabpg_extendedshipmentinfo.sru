$PBExportHeader$u_tabpg_extendedshipmentinfo.sru
forward
global type u_tabpg_extendedshipmentinfo from u_tabpg_shipinfo
end type
end forward

global type u_tabpg_extendedshipmentinfo from u_tabpg_shipinfo
integer width = 4343
integer height = 936
long backcolor = 12632256
event ue_ppcolchanged ( )
end type
global u_tabpg_extendedshipmentinfo u_tabpg_extendedshipmentinfo

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

on u_tabpg_extendedshipmentinfo.create
int iCurrent
call super::create
end on

on u_tabpg_extendedshipmentinfo.destroy
call super::destroy
end on

event ue_restrictedit;call super::ue_restrictedit;//n_cst_Setting_EnableShipNote	lnv_ShipNote
//lnv_ShipNote = CREATE n_cst_Setting_EnableShipNote
//uo_shipnote.Enabled = ( lnv_Shipnote.of_GetValue ( ) = lnv_ShipNote.cs_Yes ) OR ab_value
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

event ue_setfocus;dw_shipinfo.SetFocus ( )
dw_shipinfo.SetColumn ( "prenotedate" ) 
end event

type dw_shipinfo from u_tabpg_shipinfo`dw_shipinfo within u_tabpg_extendedshipmentinfo
integer x = 0
integer y = 0
integer width = 4315
integer height = 916
string dataobject = "d_ship_info"
end type

event dw_shipinfo::ue_getshipment;RETURN inv_Shipment 
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

event dw_shipinfo::ue_getshiptypemanager;RETURN PARENT.Event ue_GetShipTypemanager ( )
end event

event dw_shipinfo::ue_shiptypechanged;call super::ue_shiptypechanged;IF AncestorReturnValue = 1 THEN
	Parent.Event ue_ShipTypeChanged ( al_value )
END IF
RETURN AncestorReturnValue
end event

event dw_shipinfo::ue_shipmentchanged;call super::ue_shipmentchanged;// this is here to get the shiptype to display right upon entry
THIS.SetColumn ( "ds_ship_date" )
IF THIS.RowCount ( ) > 0 THEN
	THIS.SetRow ( 1 ) 
END IF
//THIS.Post SetColumn ( "ds_ref1_type" )
//THIS.Post SetColumn ( "billto_name" )
end event

event dw_shipinfo::ue_billtochanged;Parent.Event ue_billToChanged ( )
end event

event dw_shipinfo::ue_getdispatchmanager;RETURN Parent.Event ue_GetDispatch ( )
end event

event dw_shipinfo::ue_ppcolchanged;Parent.Event ue_PPColChanged ( )
end event

event dw_shipinfo::ue_payformatchanged;Parent.Event ue_PayFormatChanged ( ) 

end event

event dw_shipinfo::ue_billformatchanged;Parent.Event ue_BillFormatChanged ( ) 
end event

type uo_shipnote from u_tabpg_shipinfo`uo_shipnote within u_tabpg_extendedshipmentinfo
end type

