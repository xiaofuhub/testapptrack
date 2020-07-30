$PBExportHeader$u_tabpg_shipinfo.sru
forward
global type u_tabpg_shipinfo from u_tabpg
end type
type dw_shipinfo from u_dw_intermodalshipinfo within u_tabpg_shipinfo
end type
type uo_shipnote from u_cst_note within u_tabpg_shipinfo
end type
end forward

global type u_tabpg_shipinfo from u_tabpg
integer width = 3273
integer height = 1396
event type integer ue_shipmentchanged ( n_cst_beo_shipment anv_shipment )
event ue_setdisplayrestrictions ( )
event type n_cst_bso_dispatch ue_getdispatch ( )
event type n_cst_ship_type ue_getshiptypemanager ( )
event type integer ue_displayshipment ( long al_shipmentid )
event type integer ue_shiptypechanged ( long al_value )
event type integer ue_setsharesource ( powerobject apo_source )
event type integer ue_restrictedit ( boolean ab_value )
event ue_billformatchanged ( )
event ue_billtochanged ( )
event ue_refreshshipment ( long al_shipmentid )
event ue_setfocus ( )
event ue_payformatchanged ( )
event ue_movecodechanged ( )
event ue_shownotes ( )
event ue_notemodified ( )
dw_shipinfo dw_shipinfo
uo_shipnote uo_shipnote
end type
global u_tabpg_shipinfo u_tabpg_shipinfo

type variables
n_cst_beo_Shipment	inv_Shipment
Boolean	ib_RestrictedView
end variables

forward prototypes
public function integer of_setfocus (string as_column)
public function integer of_showshipmentnote (long al_x, long al_y, long al_width, long al_height)
public subroutine of_syncbillto ()
end prototypes

event type integer ue_shipmentchanged(n_cst_beo_shipment anv_shipment);inv_Shipment = anv_Shipment
dw_shipinfo.Post Event ue_ShipmentChanged ( ) 

Boolean	lb_AllowEdit

IF IsValid ( inv_Shipment ) THEN
	//DEK 3-28-07 Added this to allow editing if the shipment is billed and the user has permission to modify a billed shipment	
	IF inv_shipment.of_isBilled( ) THEN
		IF gnv_app.of_Getprivsmanager( ).of_Getuserpermissionfromfn( appeon_constant.cs_ModifyBilledShip , dw_shipinfo.event ue_getshipment( ) ) = appeon_constant.ci_True THEN
			lb_allowEdit = true
		ELSE
			lb_allowEdit = false
		END IF
	ELSE
		//this was the default.
		lb_AllowEdit = inv_Shipment.of_AllowEditBill ( )
	END IF
	THIS.Event ue_RestrictEdit ( lb_AllowEdit  )	
	
END IF

RETURN 1




end event

event ue_setsharesource;dw_shipinfo.of_ShareData ( apo_source )
RETURN 1
end event

event type integer ue_restrictedit(boolean ab_value);
Boolean	lb_Enable
/*
	DEK: 3-28-07 Modified to be set based on a different priv if the shipment has already
	been billed
*/

n_cst_beo_shipment	lnv_shipment
String	ls_modFnId
Boolean	lb_checkSetting

lnv_shipment = dw_shipinfo.event ue_getshipment( ) 
IF isValid( lnv_shipment ) THEN
	IF lnv_shipment.of_isBilled( ) THEN
		ls_modfnid = appeon_constant.cs_ModifyBilledShip
		//DEK 4-18-07
		IF gnv_app.of_Getprivsmanager( ).of_Getuserpermissionfromfn( "ModifyShipment", dw_shipinfo.event ue_getshipment( ) ) = appeon_constant.ci_True THEN
			lb_checkSetting = true		
		END IF
		/////////////
	ELSE
		ls_modfnid = "ModifyShipment"
		lb_checkSetting = true	//DEK 4-18-07
	END IF
ELSE
	ls_modfnid = "ModifyShipment"
	lb_checkSetting = true		//DEK 4-18-07
END IF

IF gnv_app.of_Getprivsmanager( ).of_Getuserpermissionfromfn( ls_modfnid , dw_shipinfo.event ue_getshipment( ) ) = appeon_constant.ci_True THEN
//	n_cst_Setting_EnableShipNote	lnv_ShipNote
//	lnv_ShipNote = CREATE n_cst_Setting_EnableShipNote
//	lb_Enable = lnv_Shipnote.of_GetValue ( ) = lnv_ShipNote.cs_Yes or ab_value
//	DESTROY ( lnv_ShipNote ) 
ELSE
	lb_Enable = FALSE	
END IF

IF lb_checkSetting THEN
	n_cst_Setting_EnableShipNote	lnv_ShipNote
	lnv_ShipNote = CREATE n_cst_Setting_EnableShipNote
	lb_Enable = lnv_Shipnote.of_GetValue ( ) = lnv_ShipNote.cs_Yes or ab_value
	DESTROY ( lnv_ShipNote ) 
END IF

uo_shipnote.of_setenabled(  lb_Enable )
RETURN 1

end event

event ue_shownotes;Long	ll_ID
n_Cst_Msg	lnv_Msg
S_Parm lstr_Parm 

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Shipment = dw_shipinfo.Event ue_GetShipment ( )
lnv_Dispatch = dw_shipinfo.Event ue_GetDispatchManager ( )

IF isValid ( lnv_Shipment ) THEN
	ll_ID = lnv_Shipment.of_GetID ( )
END IF



lstr_parm.is_label = "TOPIC"
lstr_parm.ia_value = "SHIPMENT!"
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "DISPATCH"
lstr_parm.ia_value = lnv_Dispatch
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "REQUEST"
lstr_parm.ia_value = "VIEWNOTES!"
lnv_Msg.of_add_parm(lstr_parm)

lstr_parm.is_label = "TARGET_ID"
lstr_parm.ia_value = ll_ID
lnv_Msg.of_add_parm(lstr_parm)

f_process_standard(lnv_Msg)
end event

event ue_notemodified;uo_shipnote.of_ShowIcons ( )
end event

public function integer of_setfocus (string as_column);
dw_shipinfo.SetColumn ( as_column )	
dw_ShipInfo.Post SetFocus ( )



RETURN 1
end function

public function integer of_showshipmentnote (long al_x, long al_y, long al_width, long al_height);uo_shipnote.Visible = TRUE
uo_shipnote.of_SetPosition ( al_x , al_y )
uo_shipnote.of_SetDimensions ( al_width , al_height )


RETURN 1


end function

public subroutine of_syncbillto ();n_cst_beo_Company	lnv_Co
Int	li_Temp
String	ls_Address
String	ls_name
String	ls_Null
Long		ll_CoID
Long		ll_length
SetNull ( ls_Null )

IF isValid ( inv_Shipment ) THEN
	
	inv_Shipment.of_GetBillToCompany ( lnv_Co , TRUE ) 

	IF isValid ( lnv_Co ) THEN
		
		ll_CoID = lnv_Co.of_getID( )
		
		
		
		ls_Name = lnv_Co.of_getBillingName ( )
		IF isNull ( ls_name ) THEN
			ls_Name = lnv_Co.of_GetName () 
		END IF
		
		IF ll_CoID > 0 THEN
			
			Select length (co_comments) into :ll_Length From companies where co_id = :ll_CoID;
			Commit;
	
			IF ll_Length > 0 THEN		
				ls_Name = "*" + ls_Name
			END IF
					
		END IF
		
		
		li_Temp = dw_shipinfo.SetItem ( 1, "billto_name" , ls_Name )			

		gnv_cst_companies.of_get_address( lnv_Co.of_GetID ( ), "BILLING_OR_WARNING!", false, ls_address)
		//No checking is done here b.c. if it fails, ls_address is set to null, which is ok
		dw_shipinfo.setitem(1, "billto_address", ls_address)
		
		DESTROY( lnv_Co )
	ELSE
		li_Temp = dw_shipinfo.SetItem ( 1, "billto_name" , ls_Null )
		dw_shipinfo.setitem(1, "billto_address", ls_Null)
	END IF
	
END IF
end subroutine

on u_tabpg_shipinfo.create
int iCurrent
call super::create
this.dw_shipinfo=create dw_shipinfo
this.uo_shipnote=create uo_shipnote
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_shipinfo
this.Control[iCurrent+2]=this.uo_shipnote
end on

on u_tabpg_shipinfo.destroy
call super::destroy
destroy(this.dw_shipinfo)
destroy(this.uo_shipnote)
end on

event constructor;call super::constructor;environment env

GetEnvironment(env)
If env.ScreenHeight	< 768 then 
	ib_RestrictedView = TRUE
End If
								

end event

type dw_shipinfo from u_dw_intermodalshipinfo within u_tabpg_shipinfo
integer x = 14
integer y = 4
integer width = 3168
integer height = 1344
integer taborder = 10
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.Name 
		
	CASE "agent"
		IF IsValid ( inv_Shipment ) THEN
			inv_Shipment.of_SetAgent ( Long ( data) )
		END IF
		
	CASE "forwarder"
		IF IsValid ( inv_Shipment ) THEN
			inv_Shipment.of_SetForwarder ( Long ( data) )
		END IF
		
	CASE "movecode"
		Parent.Post Event ue_moveCodeChanged ( )
		
		
		
END CHOOSE 

RETURN AncestorReturnValue
end event

event ue_shipmentchanged;call super::ue_shipmentchanged;uo_shipnote.of_SetContext( inv_Shipment , "SHIPNOTE" )
end event

event constructor;call super::constructor;n_cst_Settings	lnv_Settings
dwObject			ldwo_ShipNote
ldwo_ShipNote = THIS.Object.ds_ship_comment 
IF gnv_App.of_getshipnoteformat( ) = "INDIVIDUAL!" THEN	
	of_ShowShipmentNote (  Long (ldwo_ShipNote.X)  , Long ( ldwo_ShipNote.Y ) , Long(ldwo_ShipNote.Width) + 10 , Long ( ldwo_ShipNote.Height ))
	ldwo_ShipNote.Visible = FALSE
END IF

end event

type uo_shipnote from u_cst_note within u_tabpg_shipinfo
boolean visible = false
integer x = 1714
integer y = 348
integer taborder = 20
boolean bringtotop = true
end type

on uo_shipnote.destroy
call u_cst_note::destroy
end on

event ue_shownotes;Parent.Event ue_ShowNotes (  )
end event

event ue_notemodified;Parent.Event ue_NoteModified ( )

end event

