$PBExportHeader$u_tab_intermodalshipment.sru
forward
global type u_tab_intermodalshipment from u_tab
end type
type tabpage_shipment from u_tabpg_intermodalshipinfo within u_tab_intermodalshipment
end type
type tabpage_shipment from u_tabpg_intermodalshipinfo within u_tab_intermodalshipment
end type
type tabpage_extendedshipinfo from u_tabpg_extendedshipmentinfo within u_tab_intermodalshipment
end type
type tabpage_extendedshipinfo from u_tabpg_extendedshipmentinfo within u_tab_intermodalshipment
end type
type tabpage_billing from u_tabpg_intermodalbilling within u_tab_intermodalshipment
end type
type tabpage_billing from u_tabpg_intermodalbilling within u_tab_intermodalshipment
end type
type tabpage_extendedinfo from u_tabpg_extendedintermodal within u_tab_intermodalshipment
end type
type tabpage_extendedinfo from u_tabpg_extendedintermodal within u_tab_intermodalshipment
end type
end forward

global type u_tab_intermodalshipment from u_tab
integer width = 3241
integer height = 968
fontcharset fontcharset = ansi!
long backcolor = 12632256
boolean boldselectedtext = true
alignment alignment = center!
tabpage_shipment tabpage_shipment
tabpage_extendedshipinfo tabpage_extendedshipinfo
tabpage_billing tabpage_billing
tabpage_extendedinfo tabpage_extendedinfo
event type n_cst_beo_shipment ue_getshipment ( )
event type n_cst_bso_dispatch ue_getdispatch ( )
event type n_cst_ship_type ue_getshiptypemanager ( )
event type integer ue_shipmentchanged ( n_cst_beo_shipment anv_shipment )
event type integer ue_displayshipment ( long al_shipmentid )
event type integer ue_shiptypechanged ( long al_value )
event ue_ppcolchanged ( )
event ue_notechanged ( )
event ue_billformatchanged ( )
event ue_billtochanged ( )
event ue_preremovesplit ( )
event ue_refreshshipment ( long al_shipmentid )
event ue_refreshequipment ( )
event ue_payformatchanged ( )
event ue_movecodechanged ( )
event ue_frontsplitadded ( )
event ue_backsplitadded ( )
event ue_equipmentlocationchanged ( long al_siteid )
end type
global u_tab_intermodalshipment u_tab_intermodalshipment

type variables
n_Cst_beo_Shipment	inv_Shipment
Constant	Int ci_TabPage_ShipInfo = 1
Constant	Int ci_TabPage_Billing = 3
Constant	Int ci_TabPage_Extended = 4
Constant	Int ci_TabPage_ExtendedShipInfo = 2

end variables

forward prototypes
public function integer of_setsharesource (powerobject apo_source)
public function integer of_setequipmentlocation (string as_Column, long al_SiteID)
public function integer of_showshipnote ()
public function integer of_showbillnote ()
public function integer of_accepttext ()
public function integer of_setcontext ()
public subroutine of_syncbillto ()
end prototypes

event ue_shipmentchanged;Boolean	lb_Intermodal
THIS.SetRedraw ( FALSE )
inv_shipment = anv_shipment
tabpage_shipment.Event ue_ShipmentChanged ( anv_shipment )
tabpage_billing.Event ue_ShipmentChanged ( anv_shipment )
tabpage_extendedinfo.Event ue_ShipmentChanged ( anv_shipment )
tabpage_extendedShipInfo.Event ue_ShipmentChanged ( anv_shipment )


If IsValid ( inv_Shipment ) THEN
	lb_Intermodal = inv_Shipment.of_IsIntermodal ( )
	IF lb_Intermodal THEN
		tabpage_shipment.Visible = TRUE
		tabpage_extendedinfo.Visible = TRUE
		tabpage_extendedShipInfo.visible = FALSE
		tabpage_shipment.of_SetFocus ( )		
		THIS.SelectTab ( ci_TabPage_ShipInfo   )	
	ELSE 
		THIS.Post SelectTab ( ci_TabPage_ExtendedShipInfo   )	
		tabpage_extendedShipInfo.of_SetFocus ( "ds_ship_date" )
		tabpage_shipment.Visible = FALSE
		tabpage_extendedinfo.Visible = FALSE
		tabpage_extendedShipInfo.visible = TRUE
			
	END IF
	
	IF ( inv_Shipment.of_GetStatus ( ) = gc_Dispatch.cs_ShipmentStatus_Billed )  THEN
		THIS.Post SelectTab ( ci_Tabpage_Billing )
		tabpage_Billing.Event Post ue_SetFocus ( )	
	END IF
	 
END IF

THIS.Post SetRedraw ( TRUE )

RETURN 1
end event

event type integer ue_shiptypechanged(long al_value);THIS.Post of_SetContext (  )

n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( ) 

IF isValid ( lnv_Shipment ) THEN
	lnv_shipment.of_SetType(al_value)
end if

RETURN 1
end event

event ue_notechanged;tabpage_shipment.of_SetNoteButtons ( )
end event

event ue_refreshequipment;tabpage_shipment.Event ue_RefreshEquipment ( )
end event

event ue_movecodechanged;tabpage_shipment.of_FormatForContext ( )
end event

public function integer of_setsharesource (powerobject apo_source);tabpage_billing.Event ue_SetShareSource ( apo_source )
tabpage_shipment.Event ue_SetShareSource ( apo_source )
tabpage_extendedinfo.Event ue_SetShareSource ( apo_source )
tabpage_extendedShipInfo.Event ue_SetShareSource ( apo_source )
RETURN 1
end function

public function integer of_setequipmentlocation (string as_Column, long al_SiteID);tabpage_shipment.of_SetEquipmentLocation ( as_Column , al_SiteID )
RETURN 1
end function

public function integer of_showshipnote ();n_cst_Msg	lnv_msg
n_cst_Settings	lnv_Settings
Int		li_Return = 1
S_Parm	lstr_Parm	

IF lnv_Settings.of_GetShipNoteFormat ( ) = "INDIVIDUAL!" THEN
	lstr_Parm.ia_Value = THIS.Event ue_GetDispatch ( )
	lstr_Parm.is_Label = "DISPATCH"
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
	lstr_Parm.ia_Value = inv_Shipment.of_GetID ( )
	lstr_Parm.is_Label = "TARGET_ID"
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
		
	THIS.SelectTab ( ci_TabPage_Billing )
	OpenWithParm ( w_noteShower , lnv_msg )
	tabpage_billing.of_SetFocus ( "ds_ship_Comment" )
	
ELSE
	THIS.SelectTab ( ci_TabPage_Billing )
	tabpage_billing.of_SetFocus ( "ds_ship_Comment" )
END IF

RETURN li_Return
end function

public function integer of_showbillnote ();THIS.SelectTab ( ci_TabPage_Billing )
tabpage_billing.of_SetFocus ( "ds_Bill_Comment" )
RETURN 1
end function

public function integer of_accepttext ();Int li_Return = -1
IF tabpage_shipment.of_AcceptText() = 1 THEN
	li_Return = 1
END IF

IF tabpage_extendedshipinfo.of_Accepttext( TRUE ) <> 1 THEN
	
	li_Return = -1 
	
END IF
 
IF tabpage_extendedinfo.of_Accepttext( TRUE ) <> 1 THEN
	
	li_Return = -1 
	
END IF

IF tabpage_billing.of_Accepttext( TRUE ) <> 1 THEN
	
	li_Return = -1 
	
END IF
 

return li_Return 
end function

public function integer of_setcontext ();Boolean	lb_Intermodal

If IsValid ( inv_Shipment ) THEN
	lb_Intermodal = inv_Shipment.of_IsIntermodal ( )
	IF lb_Intermodal THEN
		tabpage_shipment.Visible = TRUE
		tabpage_shipment.Enabled = TRUE
		tabpage_extendedinfo.Visible = TRUE
		tabpage_extendedShipInfo.visible = FALSE
	ELSE 
		tabpage_shipment.Visible = FALSE
		tabpage_shipment.Enabled = FALSE
		tabpage_extendedinfo.Visible = FALSE
		tabpage_extendedShipInfo.visible = TRUE
	END IF
	
	IF ( inv_Shipment.of_GetStatus ( ) = gc_Dispatch.cs_ShipmentStatus_Billed ) OR Not lb_Intermodal THEN
		IF Not lb_Intermodal THEN
			IF THIS.SelectedTab = ci_tabpage_shipinfo THEN
				THIS.Post SelectTab ( ci_TabPage_ExtendedShipInfo ) 
			END IF
		ELSE
			IF This.SelectedTab <> ci_TabPage_ExtendedShipInfo THEN
				THIS.Post SelectTab ( ci_Tabpage_Billing ) 
			END IF
		END IF
	ELSE
		
		IF THIS.Selectedtab = ci_tabpage_extendedshipinfo THEN
			//THIS.Post SelectTab ( ci_Tabpage_Billing ) 
			THIS.Post SelectTab ( ci_tabpage_shipinfo ) 
		END IF
		tabpage_shipment.Post of_SetFocus ( )		
	END IF
	 tabpage_Billing.Of_Format ( )
END IF

return 1
end function

public subroutine of_syncbillto ();tabpage_billing.of_SyncBillTo ( ) 
tabpage_shipment.of_SyncBillTo ( )
tabpage_extendedinfo.of_SyncBillTo ( )
tabpage_extendedshipinfo.of_SyncBillTo ( )
	
	
end subroutine

on u_tab_intermodalshipment.create
this.tabpage_shipment=create tabpage_shipment
this.tabpage_extendedshipinfo=create tabpage_extendedshipinfo
this.tabpage_billing=create tabpage_billing
this.tabpage_extendedinfo=create tabpage_extendedinfo
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_shipment
this.Control[iCurrent+2]=this.tabpage_extendedshipinfo
this.Control[iCurrent+3]=this.tabpage_billing
this.Control[iCurrent+4]=this.tabpage_extendedinfo
end on

on u_tab_intermodalshipment.destroy
call super::destroy
destroy(this.tabpage_shipment)
destroy(this.tabpage_extendedshipinfo)
destroy(this.tabpage_billing)
destroy(this.tabpage_extendedinfo)
end on

event selectionchanging;call super::selectionchanging;/* I am doing this here b.c. setting all of the restrictions at once in the 
   constructor was taking too long.

*/

CHOOSE CASE newindex
		
	CASE THIS.ci_tabpage_billing
		tabpage_billing.dw_shipinfo.of_Setdisplayrestrictions( )
		
	CASE THIS.ci_tabpage_extended
		tabpage_extendedinfo.dw_shipinfo.of_Setdisplayrestrictions( )
		
	CASE THIS.ci_tabpage_extendedshipinfo		
		tabpage_extendedshipinfo.dw_shipinfo.of_Setdisplayrestrictions( )
		
	CASE THIS.ci_tabpage_shipinfo
		tabpage_shipment.dw_shipinfo.of_Setdisplayrestrictions( )
		
END CHOOSE 

RETURN AncestorReturnValue
end event

type tabpage_shipment from u_tabpg_intermodalshipinfo within u_tab_intermodalshipment
integer x = 18
integer y = 100
integer width = 3205
integer height = 852
string text = "Shipment Info"
long tabbackcolor = 12632256
end type

event ue_getdispatch;RETURN PARENT.Event ue_GetDispatch ( )
end event

event ue_getshiptypemanager;RETURN PARENT.Event ue_GetShipTypemanager ( )
end event

event ue_displayshipment;RETURN Parent.Event ue_DisplayShipment ( al_shipmentid )
end event

event ue_shiptypechanged;Return Parent.Event ue_ShipTypeChanged ( al_value )
end event

event ue_showbillnote;Parent.of_ShowBillNote ( )
end event

event ue_showshipnote;Parent.of_ShowShipNote ( )
end event

event ue_billtochanged;Parent.Event ue_BillToChanged( )
tabpage_billing.of_SyncBillTo ( )
end event

event ue_preremovesplit;Parent.Event ue_PreRemoveSplit ( )
end event

event ue_refreshshipment;call super::ue_refreshshipment;Parent.Event ue_RefreshShipment ( al_shipmentid )
end event

event ue_backsplitadded;Parent.Event ue_BackSplitAdded ( )
end event

event ue_frontsplitadded;Parent.Event ue_FrontSplitAdded ( )
end event

event ue_notemodified;call super::ue_notemodified;tabpage_billing.of_ShowNoteIcons ( )
//tabpage_shipment.Event ue_NoteModified ( ) 
tabpage_extendedinfo.of_ShowNoteIcons ( ) 
tabpage_extendedshipinfo.of_ShowNoteIcons ( )
	
	
end event

event ue_trailerpuchanged;call super::ue_trailerpuchanged;Parent.event ue_equipmentlocationchanged( al_siteid )
end event

event ue_trailerrtnchanged;call super::ue_trailerrtnchanged;Parent.event ue_equipmentlocationchanged( al_siteid )
end event

event ue_chassispuchanged;call super::ue_chassispuchanged;Parent.event ue_equipmentlocationchanged( al_site )
end event

event ue_chassisrtnchanged;call super::ue_chassisrtnchanged;Parent.event ue_equipmentlocationchanged( al_site )
end event

type tabpage_extendedshipinfo from u_tabpg_extendedshipmentinfo within u_tab_intermodalshipment
integer x = 18
integer y = 100
integer width = 3205
integer height = 852
string text = "Shipment Info"
long tabbackcolor = 12632256
end type

event ue_getshiptypemanager;RETURN PARENT.Event ue_GetShipTypemanager ( )
end event

event ue_shiptypechanged;Return Parent.Event ue_ShipTypeChanged ( al_value )
end event

event ue_movecodechanged;Parent.Event ue_MoveCodeChanged ( )
end event

event ue_billtochanged;Parent.Event ue_BillToChanged ( )
end event

event ue_billformatchanged;PARENT.event ue_BillformatChanged ( )
end event

event ue_getdispatch;RETURN PARENT.Event ue_GetDispatch ( )
end event

event ue_ppcolchanged;Parent.Event ue_PPColChanged ( ) 
end event

event ue_payformatchanged;PARENT.event ue_PayformatChanged ( )
end event

event ue_notemodified;call super::ue_notemodified;tabpage_billing.of_ShowNoteIcons ( )
tabpage_shipment.of_ShowNoteIcons ( )
tabpage_extendedinfo.of_ShowNoteIcons ( )
//tabpage_extendedshipinfo.Event ue_NoteModified ( ) 
	
end event

type tabpage_billing from u_tabpg_intermodalbilling within u_tab_intermodalshipment
integer x = 18
integer y = 100
integer width = 3205
integer height = 852
string text = "Billing Info"
long tabbackcolor = 12632256
end type

event ue_getdispatch;RETURN PARENT.Event ue_GetDispatch ( )
end event

event ue_getshiptypemanager;RETURN PARENT.Event ue_GetShipTypemanager ( )
end event

event ue_displayshipment;RETURN PARENT.Event ue_DisplayShipment ( al_shipmentid )
end event

event ue_shiptypechanged;Return Parent.Event ue_ShipTypeChanged ( al_value )
end event

event ue_ppcolchanged;Parent.Event ue_PPColChanged ( ) 
end event

event ue_notechanged;Parent.event ue_NoteChanged ( )
end event

event ue_billformatchanged;PARENT.event ue_BillformatChanged ( )
end event

event ue_billtochanged;Parent.Event ue_BillToChanged ( )
tabpage_shipment.of_SyncBillTo ( )
end event

event ue_payformatchanged;PARENT.event ue_PayformatChanged ( )
end event

event ue_movecodechanged;Parent.Event ue_MoveCodeChanged ( )
end event

event ue_notemodified;call super::ue_notemodified;//tabpage_billing.Event ue_NoteModified ( ) 
tabpage_shipment.of_ShowNoteIcons ( )
tabpage_extendedinfo.of_ShowNoteIcons ( )
tabpage_extendedshipinfo.of_ShowNoteIcons ( )

end event

type tabpage_extendedinfo from u_tabpg_extendedintermodal within u_tab_intermodalshipment
integer x = 18
integer y = 100
integer width = 3205
integer height = 852
string text = "Extended info"
long tabbackcolor = 12632256
end type

event ue_movecodechanged;Parent.Event ue_MoveCodeChanged ( )
end event

event ue_getdispatch;RETURN PARENT.Event ue_GetDispatch ( )
end event

event ue_billtochanged;Parent.Event ue_BillToChanged ( )
tabpage_shipment.of_SyncBillTo ( )
end event

event ue_notemodified;call super::ue_notemodified;tabpage_billing.of_ShowNoteIcons ( )
tabpage_shipment.of_ShowNoteIcons ( )
//tabpage_extendedinfo.Event ue_NoteModified ( ) 
tabpage_extendedshipinfo.of_ShowNoteIcons ( )

end event

