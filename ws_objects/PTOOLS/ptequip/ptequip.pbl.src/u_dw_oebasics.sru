$PBExportHeader$u_dw_oebasics.sru
forward
global type u_dw_oebasics from u_dw
end type
end forward

global type u_dw_oebasics from u_dw
integer width = 1842
integer height = 588
string dataobject = "d_oebasics2"
boolean border = false
borderstyle borderstyle = stylebox!
event type integer ue_changepusite ( long al_siteid )
event type integer ue_changertnsite ( long al_siteid )
event type integer ue_eqrefchanged ( string as_originalvalue,  string as_newvalue,  long al_row )
event type n_cst_bso_dispatch ue_getdispatch ( )
event type integer ue_rowadded ( long al_row )
event type n_cst_beo_shipment ue_getshipment ( )
event type integer ue_unlinkequipment ( long al_row )
event type integer ue_cancelreload ( long al_row )
event type integer ue_deactivateequipment ( long al_row )
event type integer ue_showreloadmenu ( long al_row )
event type integer ue_viewreloadshipment ( long al_shipmentid )
event type integer ue_showequipmentmenu ( long al_row )
event type integer ue_eqtypechanged ( string as_originaltype,  long al_row,  string as_type )
event type integer ue_leasetypechanged ( long al_eqid )
event ue_showequipmentpostingmenu ( long al_row )
event type long ue_showequipmentmessagebox ( long al_row,  string as_oldref )
end type
global u_dw_oebasics u_dw_oebasics

type variables
datawindowChild	idwc_Lines
Boolean ib_itemChanged
end variables

forward prototypes
public function datawindowchild of_getdatawindowchild ()
public function integer of_filter (string as_filter)
public function integer of_filter ()
private function integer of_setline ()
public function long of_getpusite ()
public function long of_getrtnsite ()
public function long of_setpusite (long al_id)
public function long of_setrtnsite (long al_site)
public function integer of_retrieve (long al_shipmentid)
private function integer of_initializeequipment (long al_row)
private function integer of_validatechangeofreuse (long al_row, string as_oldref, string as_newref)
private function integer of_validaterefchange (long al_row, string as_oldref, string as_newref)
private function integer of_insertreloadequipment (long al_row, long al_eqid)
private function integer of_initializenewequipment (long al_row)
private function long of_doesequipmentexist (string as_ref)
private function boolean of_isshipmentexport ()
private function integer of_getequipment (long al_equipmentid, ref n_cst_beo_equipment2 anv_equipment)
private function integer of_validatenewequipmentaddition (long al_row, string as_ref)
private function integer of_initializeexistingequipment (long al_row, long al_eqid)
private function boolean of_iseditonreload (long al_Row)
private function integer of_insertnewequipment (long al_row, string as_ref)
private function long of_addrow (long al_beforerow)
private function integer of_validateexistingequipmentchange (long al_row, string as_ref, string as_oldref)
private function integer of_insertexistingequipment (long al_eqid, long al_row)
private function integer of_insertexistingequipmentforreload (long al_id, long al_row)
public function integer of_syncwithcache (n_cst_bso_dispatch anv_dispatch)
private subroutine of_seticons ()
private function integer of_formatforreload ()
private function integer of_addnewifneeded ()
public function integer of_setenable (boolean ab_value)
public function integer of_selectequipment (string as_type, long al_row)
public function integer of_setreleasedate (date ad_value)
public function integer of_setreleasetime (time at_value)
private function long of_doeseqexistonthisshipment (string as_ref)
private function integer of_lookforreloadchassis (long al_inboundshipment)
public function integer of_proposepostingneed (n_cst_beo_equipment2 anv_equipment)
public function integer of_removeneedposting (n_cst_beo_equipment2 anv_equipment)
public function integer of_postequipment (long al_row)
public function integer of_posthave (n_cst_beo_equipment2 anv_equipment)
public function integer of_removehaveposting (n_cst_beo_equipment2 anv_equipment)
public function integer of_parseisocode ()
public function string of_buildisocode (long al_row)
public function integer of_modifyisocode (long al_row)
public function integer of_setisogooseneckandheight (long al_row, string as_value)
public function integer of_setisodescription (long al_row, string as_value)
private function integer of_setfocus (integer ai_column, long al_row)
public function integer of_eqrefchanged (string as_oldref, long al_row, string as_data)
public function integer of_addalert (long al_row)
public function string of_getequipmentprefix (long al_row)
private function integer of_replaceexistingequipmentwithreload (long al_existingeqid, long al_existingeqrow, long al_reloadeqid)
private function integer of_labeltempeqnumber (long al_row)
private function integer of_determineref1text (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype)
private function integer of_determineref2text (string as_originaleqref, string as_neweqref, long al_row, string as_originaleqtype, string as_neweqtype)
private function long of_doesequipmentexist (string as_ref, ref string asa_dupes[])
public function integer of_syncwithcache (n_cst_bso_dispatch anv_dispatch, boolean ab_retrieve)
end prototypes

event ue_changepusite;Long	ll_Row

ll_Row = THIS.GetRow ( )
IF ll_Row > 0 THEN
	THIS.SetItem ( ll_Row , "outside_equip_originationsite" , al_siteid )
END IF

RETURN 1
end event

event ue_changertnsite;Long	ll_Row

ll_Row = THIS.GetRow ( )
IF ll_Row > 0 THEN
	THIS.SetItem ( ll_Row , "outside_equip_terminationsite" , al_siteid )
END IF

RETURN 1
end event

event type integer ue_eqrefchanged(string as_originalvalue, string as_newvalue, long al_row);String	ls_Prefix
String	ls_equipmentType
String	ls_EquipmentRef

String	ls_Equipmenttype2
String	ls_CurrentEqType
Long		ll_Row

ll_Row = al_row

ls_EquipmentType = THIS.object.intermodalequipment_type [ ll_row ]	//original equipment type DEK 3-26-07
ls_Prefix = THIS.of_GetEquipmentPrefix ( ll_Row ) 

IF isNull ( ls_equipmentType ) OR ls_equipmentType = "" THEN
	CHOOSE CASE Upper ( Right ( ls_Prefix , 1 ) )
			
		CASE "U"
			THIS.of_SelectEquipment( "CONTAINER" , ll_Row)		
				
		CASE ELSE 
			IF ll_Row = 1 AND Upper ( Right ( ls_Prefix , 1 ) ) = "Z" THEN
				THIS.of_SelectEquipment ( "RAILBOX" , ll_Row )
			ELSE 
				THIS.of_SelectEquipment ( "CHASSIS" , ll_Row )
			END IF
			
	END CHOOSE 
END IF

ls_CurrentEqType = THIS.object.intermodalequipment_type [ ll_row ]

//DEK Modified 3-26-07, we need to know the original values for type and eqref to determine the text
THIS.Post of_DetermineRef1Text ( as_originalvalue , as_newvalue, ls_equipmentType, ls_CurrentEqType )
THIS.Post of_DetermineRef2Text ( as_originalvalue , as_newvalue ,ll_Row, ls_Equipmenttype, ls_CurrentEqType )
THIS.of_FormatForReload ( )


//POSTING
n_cst_beo_Equipment2	lnv_Equip
Long	ll_ID 
ll_ID = this.getitemNumber ( ll_Row ,"eq_id" )
THIS.of_Getequipment( ll_ID , lnv_Equip )
THIS.of_removeNeedposting( lnv_Equip )	

//ALERT
IF isValid( lnv_equip ) THEN  //DEK added condition 3-30-07, this was causing an error 2		
										//when deactivating a railbox with ref 12345, and then adding a chassis with ref 12345 and saving.
	THIS.event ue_getdispatch( ).of_GetAlertManager().of_ShowAlerts ( {lnv_Equip} )
END IF

Destroy ( lnv_Equip )
	

RETURN 1

/*
String	ls_Prefix
Long		ll_Row

ll_Row = al_row


ls_Prefix = THIS.of_GetEquipmentPrefix ( ll_Row ) 


CHOOSE CASE Upper ( Right ( ls_Prefix , 1 ) )
		
	CASE "U"
		THIS.of_SelectEquipment( "CONTAINER" , ll_Row)		
			
		
	CASE ELSE 
		IF ll_Row = 1 AND Upper ( Right ( ls_Prefix , 1 ) ) = "Z" THEN
			THIS.of_SelectEquipment ( "RAILBOX" , ll_Row )
		ELSE 
			THIS.of_SelectEquipment ( "CHASSIS" , ll_Row )
		END IF
		
END CHOOSE 

THIS.Post of_DetermineRef1Text ( as_originalvalue , as_newvalue)
THIS.Post of_DetermineRef2Text ( as_originalvalue , as_newvalue ,ll_Row )
THIS.of_FormatForReload ( )

//POSTING
n_cst_beo_Equipment2	lnv_Equip
Long	ll_ID 
ll_ID = this.getitemNumber ( ll_Row ,"eq_id" )
THIS.of_Getequipment( ll_ID , lnv_Equip )
THIS.of_removeNeedposting( lnv_Equip )	

//ALERT
THIS.event ue_getdispatch( ).of_GetAlertManager().of_ShowAlerts ( {lnv_Equip} )


Destroy ( lnv_Equip )
	

RETURN 1
*/
end event

event type integer ue_unlinkequipment(long al_row);Long	ll_Null	
Int	li_Return = 1
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch


SetNull ( ll_null ) 

lnv_Dispatch = THIS.Event ue_GetDispatch ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF Not isValid ( lnv_Dispatch ) THEN
	li_Return = -1
END IF


IF Not IsValid ( lnv_shipment ) THEN
	li_Return = -1
END IF


IF li_Return = 1 THEN
	
	IF al_Row > 0 THEN
		THIS.Object.equipmentlease_shipment [ al_Row ] = ll_Null
	ELSE
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	
	THIS.SetRedraw ( FALSE ) 
	IF THIS.of_SyncWithCache ( lnv_Dispatch, false ) = 1 THEN //DEK 5-1-07 overloaded to not retrieve
		THIS.of_Retrieve ( lnv_Shipment.of_GetID ( ) ) 		
	END IF
	THIS.SetRedraw ( TRUE ) 	
	
END IF

RETURN li_Return
end event

event type integer ue_cancelreload(long al_row);Long	ll_Null	
Int	li_Return = 1

n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch


SetNull ( ll_null ) 

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Dispatch = THIS.Event ue_GetDispatch ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF Not isValid ( lnv_Dispatch ) THEN
	li_Return = -1
END IF


IF Not IsValid ( lnv_shipment ) THEN
	li_Return = -1
END IF


IF li_Return = 1 THEN
	
	lnv_Equipment.of_SetSource ( THIS ) 
	lnv_Equipment.of_SetSourceRow ( al_Row )
	lnv_Dispatch.of_EquipmentReloadCanceled ( lnv_Equipment ) 
	
END IF

IF li_Return = 1 THEN
	
	IF al_Row > 0 THEN
		THIS.Object.reloadshipment [ al_Row ] = ll_Null
	ELSE
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	
	
	THIS.SetRedraw ( FALSE ) 
	IF THIS.of_SyncWithCache ( lnv_Dispatch, false ) = 1 THEN		//DEK 5-1-07 the syncwith cache was already doing a retrieve..
		THIS.of_Retrieve ( lnv_Shipment.of_GetID ( ) ) 		
	END IF
	THIS.SetRedraw ( TRUE ) 	
	
END IF

DESTROY ( lnv_Equipment )

RETURN li_Return
end event

event type integer ue_deactivateequipment(long al_row);Long	ll_Null	
Int	li_Return = 1
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch


SetNull ( ll_null ) 

lnv_Dispatch = THIS.Event ue_GetDispatch ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF Not isValid ( lnv_Dispatch ) THEN
	li_Return = -1
END IF


IF Not IsValid ( lnv_shipment ) THEN
	li_Return = -1
END IF


IF li_Return = 1 THEN	
	IF al_Row > 0 THEN	
		THIS.Object.eq_status [ al_Row ] = "D"
	ELSE
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	Boolean	lb_Have
	Boolean	lb_Need
	n_Cst_beo_equipment2	lnv_Equipment
	lnv_Equipment = CREATE n_cst_beo_Equipment2
	lnv_Equipment.of_SetSource ( THIS ) 
	lnv_Equipment.of_SetSourceRow ( al_row ) 
	lb_Have = THIS.GetItemString ( al_row , "equipmentpostingstatus_Postingstatus" ) = 'H'	
	lb_Need = THIS.GetItemString ( al_row , "equipmentpostingstatus_Postingstatus" ) = 'N'
	
	IF lb_Need THEN
		THIS.of_removeNeedposting( lnv_Equipment )
	ELSEIF lb_Have THEN
		THIS.of_RemoveHavePosting ( lnv_Equipment )
	END IF						
	DESTROY ( lnv_Equipment )
	
END IF

IF li_Return = 1 THEN
		
	THIS.SetRedraw ( FALSE ) 
	IF THIS.of_SyncWithCache ( lnv_Dispatch, false ) = 1 THEN  //DEK 5-1-07  I don't know why it needs to rertrieve right after. Its posts it in the call.
		THIS.of_Retrieve ( lnv_Shipment.of_GetID ( ) ) 		
	END IF
	THIS.SetRedraw ( TRUE ) 	
	
END IF

RETURN li_Return
end event

event ue_showreloadmenu;Long		ll_ShipmentID
String	ls_Menu
String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]
Any		la_Setting
	

lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Cancel Reload"

IF NOT THIS.of_IsEditOnReload ( al_row ) THEN
	lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "DISABLE"
	laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Cancel Reload"
END IF

IF THIS.of_IsEditOnReload ( al_row ) THEN
	ll_ShipmentID = THIS.object.equipmentlease_shipment [ al_Row ]
	ls_Menu = "View Original Shipment"
			
ELSE
	ls_Menu = "View Reload Shipment"
	ll_ShipmentID = THIS.object.reloadshipment [ al_Row ]
	
END IF
		
lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = ls_Menu


ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)
	
CHOOSE CASE ls_PopRtn
		
	CASE "CANCEL RELOAD"
		THIS.Event ue_CancelReload ( al_Row )

	CASE "VIEW RELOAD SHIPMENT" , "VIEW ORIGINAL SHIPMENT"
		
		THIS.Event ue_ViewReloadShipment ( ll_ShipmentID )
		THIS.of_Retrieve ( ll_ShipmentID )
			
		
END CHOOSE

THIS.Post of_SetIcons ( )

RETURN 1


end event

event type integer ue_showequipmentmenu(long al_row);String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]
Any		la_Setting
Boolean	lb_AllowUnLinked
Boolean	lb_AllowTerminate
Boolean	lb_PostEquipment

n_cst_beo_Equipment2	lnv_Equipment
n_cst_Privileges 	lnv_Privs
n_cst_settings	lnv_Settings
n_Cst_LicenseManager	lnv_LicMan

IF NOT THIS.event ue_getshipment( ).of_AllowEdit ( ) THEN
	RETURN -1
END IF

IF  lnv_LicMan.of_Getlicensed( n_cst_Constants.cs_Module_EquipmentPosting )  THEN
	lb_PostEquipment = TRUE
END IF


IF lb_PostEquipment THEN
	lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
	laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Post Equipment"
	
	lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
	laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "-"
END IF




IF Not THIS.of_isEditOnReload ( al_row ) THEN
	
	lnv_Equipment = CREATE n_cst_beo_Equipment2
	lnv_Equipment.of_SetSource ( THIS ) 
	lnv_Equipment.of_SetSourceRow ( al_row ) 
	
	
	//82			x  		Allow creation of unlinked OE
	IF lnv_Settings.of_GetSetting ( 82 , la_Setting ) = 1 THEN
		IF String ( la_Setting ) = "YES!" THEN
			lb_AllowUnlinked = TRUE
		END IF
	END IF
	
	lb_AllowTerminate = lnv_Privs.of_HasEquipmentDeactivationRights ( )
		
		
	lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
	laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Unlink Equipment"
	
	IF Not lb_AllowUnlinked THEN
		lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "DISABLE"
		laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Unlink Equipment"
	END IF
	
	
	lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
	laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Deactivate Equipment"
	
	IF Not lb_AllowTerminate OR lnv_Equipment.of_GetStatus ( ) <> 'K'  THEN
		lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "DISABLE"
		laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Deactivate Equipment"
	END IF
	
	IF lnv_Equipment.of_GetStatus ( ) <> 'K' THEN 
		lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "CHECK"
		laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Deactivate Equipment"
	END IF
	
END IF


IF UpperBound ( laa_parm_values ) > 0 THEN
	IF laa_parm_values [ UpperBound ( laa_parm_values ) ] <> "-" THEN
		lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
		laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "-"
	END IF
END IF

lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "Add Alert"

IF UpperBound ( lsa_parm_labels ) > 0 THEN
	ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)
		
	CHOOSE CASE ls_PopRtn
			
				
		CASE "UNLINK EQUIPMENT"
			THIS.Event ue_UnlinkEquipment ( al_Row )
		
		CASE "DEACTIVATE EQUIPMENT"
			THIS.Event ue_DeactivateEquipment ( al_Row )
			
		CASE "POST EQUIPMENT"
			THIS.of_postequipment( al_Row )
		
		CASE "ADD ALERT"
			THIS.of_Addalert( al_row )
		
	END CHOOSE
END IF

DESTROY ( lnv_Equipment )

RETURN 1


end event

event type integer ue_eqtypechanged(string as_originaltype, long al_row, string as_type);
/*
	DEK 3-30-07 Modified arguments to take the original value of the eqtype
	so that we can pass it in and determine the ref text and types.
*/

String	ls_equipmentType 

THIS.of_Labeltempeqnumber( al_row )


ls_EquipmentType = as_originalType 
IF al_Row = 1 THEN
	THIS.Post of_DetermineRef1Text ( THIS.GetItemString ( al_Row , "eq_ref" ) , THIS.GetItemString ( al_Row , "eq_ref" ), ls_EquipmentType, as_type )
ELSE
	THIS.Post of_DetermineRef2Text ( THIS.GetItemString ( al_Row , "eq_ref" ) , THIS.GetItemString ( al_Row , "eq_ref" ) , al_Row, ls_EquipmentType, as_type )
END IF

RETURN 1

end event

event type integer ue_leasetypechanged(long al_eqid);Long	ll_EqID 
Long	ll_LeaseTypeID


n_cst_beo_Equipment2 lnv_Equipment

ll_EqID = al_eqid
ll_LeaseTypeID = idwc_Lines.GetItemnumber ( idwc_Lines.GetRow ( ), "id" )

IF ll_eqID > 0 THEN
	IF THIS.of_GetEquipment ( ll_EqID , lnv_Equipment ) = 1 THEN
		lnv_Equipment.of_SetSource ( THIS )
		lnv_Equipment.of_SetSourceID ( ll_eqID )
		lnv_Equipment.of_SetLeaseType ( ll_LeaseTypeID )
		
		// we are going to add a need if the lease type has been specified but no ref number has 
		// been set.
		THIS.of_ProposePostingNeed ( lnv_Equipment )
		
		//THIS.Post of_SyncWithCache ( THIS.event ue_GetDispatch ( ) )
		
	END IF					
	
	DESTROY lnv_Equipment 
	
END IF



RETURN 1
end event

event ue_showequipmentpostingmenu(long al_row);String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]
Any		la_Setting
Boolean	lb_Need
Boolean	lb_Have



n_cst_beo_Equipment2	lnv_Equipment
n_cst_Privileges 	lnv_Privs
n_cst_settings	lnv_Settings


IF NOT THIS.event ue_getshipment( ).of_AllowEdit ( ) THEN
	RETURN 
END IF
	
lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Equipment.of_SetSource ( THIS ) 
lnv_Equipment.of_SetSourceRow ( al_row ) 

lsa_parm_labels [ UpperBound ( lsa_parm_labels ) + 1  ] = "ADD_ITEM"
laa_parm_values [ UpperBound ( laa_parm_values ) + 1 ] = "&Remove Posting"


lb_Have = THIS.GetItemString ( al_row , "equipmentpostingstatus_Postingstatus" ) = 'H'	
lb_Need = THIS.GetItemString ( al_row , "equipmentpostingstatus_Postingstatus" ) = 'N'

ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)
	
IF ls_PopRtn ="REMOVE POSTING" THEN
	IF lb_Need THEN
		THIS.of_removeNeedposting( lnv_Equipment )
	ELSEIF lb_Have THEN
		THIS.of_RemoveHavePosting ( lnv_Equipment )
	END IF						
END IF


DESTROY ( lnv_Equipment )



end event

event type long ue_showequipmentmessagebox(long al_row, string as_oldref);//created by dan on 2-6-07
//this is meant to be called when the equipment is cleared out and they tab away.

String	ls_PopRtn

Any		la_Setting
Boolean	lb_AllowUnLinked
Boolean	lb_AllowTerminate
Boolean	lb_ClearMatchingReferences

String	ls_oldRef
String	ls_equipmentType
String	ls_return
Long		ll_return
Long		ll_eqType
Long		ll_reftype

s_parm	 lstr_parm
n_cst_msg lnv_msg
N_cst_beo_shipment	lnv_shipment
n_cst_beo_Equipment2	lnv_Equipment
n_cst_Privileges 	lnv_Privs
n_cst_settings	lnv_Settings
n_Cst_LicenseManager	lnv_LicMan

IF NOT THIS.event ue_getshipment( ).of_AllowEdit ( ) THEN
	RETURN 1
END IF

IF Not THIS.of_isEditOnReload ( al_row ) THEN
	
	lnv_Equipment = CREATE n_cst_beo_Equipment2
	lnv_Equipment.of_SetSource ( THIS ) 
	lnv_Equipment.of_SetSourceRow ( al_row ) 
	
	ls_equipmentType = this.getItemstring( al_row, "intermodalequipment_type")
	
	CHOOSE CASE ls_EquipmentType 
		CASE 'C'
			ll_eqType = 20 
		CASE 'B'
			ll_eqType = 26
		CASE 'H'
			ll_eqType = 28	
		CASE 'V'
			ll_eqType = 23
	END CHOOSE
	
	//82			x  		Allow creation of unlinked OE
	IF lnv_Settings.of_GetSetting ( 82 , la_Setting ) = 1 THEN
		IF String ( la_Setting ) = "YES!" THEN
			lb_AllowUnlinked = TRUE
		END IF
	END IF
	
	lb_AllowTerminate = lnv_Privs.of_HasEquipmentDeactivationRights ( )
	
	
	IF Not lb_AllowTerminate OR lnv_Equipment.of_GetStatus ( ) <> 'K'  THEN
		lb_AllowTerminate = false
	END IF
	
	//a status of k means its active, so if its not active then I shouldn't allow them to (terminate and unlink).
	IF lnv_Equipment.of_GetStatus ( ) <> 'K' THEN 
		lb_AllowTerminate = false
	END IF
	
END IF

lstr_parm.is_label = "DEACTIVATE"
lstr_parm.ia_value = lb_AllowTerminate
lnv_msg.of_add_parm( lstr_parm )

lstr_parm.is_label = "UNLINK"
lstr_parm.ia_value = lb_AllowUnLinked
lnv_msg.of_add_parm( lstr_parm )

openwithparm(w_equip_Messagebox, lnv_msg)

IF isValid( message.powerobjectparm ) THEN
	ls_OldRef = as_Oldref
	IF message.powerobjectparm.classname() = "n_cst_msg" THEN
		lnv_msg = message.powerobjectparm
		IF lnv_msg.of_get_parm( "SELECTION" , lstr_parm) > 0 THEN
			CHOOSE CASE lstr_parm.ia_value  
				CASE appeon_constant.cs_deactivateUnlink
					//do deactivate and unlink functionality
					THIS.Event ue_DeactivateEquipment ( al_Row )
					THIS.Event ue_UnlinkEquipment ( al_Row )
					lb_ClearMatchingReferences = true
				CASE appeon_constant.cs_unlink
					//do unlink functionality
					THIS.Event ue_UnlinkEquipment ( al_Row )
					lb_ClearMatchingReferences = true
				CASE appeon_constant.cs_changeRef
					this.post setItem( al_row, "eq_ref", ls_oldref )
					THIS.Post of_FormatForReload ( )
					ll_return = 1
			END CHOOSE
		END IF
	END IF
END IF

IF lb_ClearMatchingReferences THEN
	lnv_shipment = this.event ue_getshipment( )
	
	ll_refType = lnv_shipment.of_getRef1type( )
	IF lnv_shipment.of_getref1text( ) = as_oldRef AND ll_eqType = ll_reftype  THEN
		lnv_shipment.of_setRef1text( "" )
	END IF
	
	ll_refType = lnv_shipment.of_getRef2type( )
	IF lnv_shipment.of_getRef2text( ) = as_oldRef AND ll_eqType = ll_reftype  THEN
		lnv_shipment.of_setRef2text( "" )
	END IF
	
END IF


DESTROY ( lnv_Equipment )

RETURN ll_return
end event

public function datawindowchild of_getdatawindowchild ();
THIS.GetChild ( "equipmentleasetype_line",  idwc_lines ) 
idwc_lines.SetTransObject ( SQLCA )
idwc_lines.Retrieve ( )


RETURN idwc_lines


end function

public function integer of_filter (string as_filter);DatawindowChild ldwc_Lines

ldwc_Lines = THIS.of_GetDataWindowChild ( ) 
IF isValid ( ldwc_Lines ) THEN
	ldwc_Lines.SetFilter ( as_Filter ) 
	ldwc_Lines.Filter ( ) 
END IF

IF ldwc_Lines.RowCount ( ) = 1 THEN
	THIS.object.equipmentleasetype_line[1] = ldwc_Lines.GetItemString ( 1 , "uniquelinename" )  
	THIS.object.equipmentleasetype_type[1] =  idwc_Lines.GetItemString (1, "type" )
END IF

RETURN 1
end function

public function integer of_filter ();String	ls_Prefix
String	ls_Number
String	ls_Filter 

ls_Number = THIS.GetItemString ( 1 , "equipment_eq_ref" )

ls_Prefix = Left ( ls_Number , 4 )
IF Len (ls_Prefix) > 0 THEN
	ls_Filter = "lineprefix = '" + ls_Prefix + "'" 

	THIS.of_Filter ( ls_Filter )
END IF


RETURN 1
end function

private function integer of_setline ();
//Long	ll_Row
//
//ll_Row = idwc_Lines.GetRow ( )
//
//Type = 
//

RETURN -1
end function

public function long of_getpusite ();RETURN THIS.GetItemNumber( THIS.GetRow ( ) , "outside_equip_originationsite" )

end function

public function long of_getrtnsite ();RETURN THIS.GetItemNumber ( THIS.GetRow ( ) , "outside_equip_terminationsite" )
end function

public function long of_setpusite (long al_id);n_cst_Beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company 
IF THIS.SetItem( THIS.GetRow ( ) , "outside_equip_originationsite" , al_ID ) = 1 THEN
	
	gnv_cst_companies.of_Cache (al_id, TRUE )
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID (al_id ) 
	
	this.SetItem ( THIS.GetRow ( ) ,  "companies_co_name_pu"  , lnv_Company.of_Getname ( ) )
END IF
	
DESTROY ( lnv_Company ) 
RETURN 1
end function

public function long of_setrtnsite (long al_site);n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company

IF THIS.setItem( THIS.GetRow ( ) , "outside_equip_terminationsite" , al_Site ) = 1 THEN
	
	gnv_cst_companies.of_Cache (al_site, TRUE )
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( al_site) 
	
	this.SetItem ( THIS.GetRow ( ) ,  "companies_co_name_rtn"  , lnv_Company.of_Getname ( ) )
END IF

DESTROY ( lnv_Company )

RETURN 1
end function

public function integer of_retrieve (long al_shipmentid);Long	ll_RowCount
Int	li_Return = 1
String	ls_FindString
String	ls_Where
Long		ll_FoundRow
Boolean	lb_Posting

n_cst_bso_Dispatch	lnv_Dispatch
n_ds						lds_EquipmentCache
n_Cst_LicenseManager	lnv_LicMan

lb_posting = lnv_LicMan.of_Hasequipmentpostinglicense( )

THIS.SetRedraw ( FALSE ) 

IF li_Return = 1 THEN
	lnv_Dispatch = THIS.Event ue_GetDispatch ( )
	IF NOT IsValid ( lnv_Dispatch ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
//	ls_Where = " where equipmentlease_shipment = " + String ( al_shipmentid ) + " OR reloadshipment = " + String ( al_shipmentid ) 
	IF lnv_Dispatch.of_RetrieveEquipmentForShipment ( al_shipmentid ) < 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )
	IF NOT isValid ( lds_EquipmentCache ) THEN
		li_Return = -1
	END IF
END IF
	
	
IF li_Return = 1 THEN

	THIS.Reset ( ) 
	ll_RowCount = lds_EquipmentCache.RowCount()
	
	ls_FindString = "equipmentlease_shipment = " + String ( al_shipmentid ) + " OR reloadshipment = " + String ( al_shipmentid ) 
	ll_FoundRow = lds_EquipmentCache.Find ( ls_FindString  ,  1 , ll_RowCount + 1)
	DO WHILE ll_FoundRow > 0
		lds_EquipmentCache.RowsCopy (ll_FoundRow, ll_FoundRow, PRIMARY!, THIS, 999, PRIMARY! )
	
		ll_FoundRow++		
		ll_FoundRow = lds_EquipmentCache.Find ( ls_FindString  ,  ll_FoundRow , ll_RowCount + 1)
	
	LOOP
		
END IF
THIS.ResetUpdate ( )
CHOOSE CASE THIS.RowCount ( )
		
	CASE 0
	//	THIS.of_AddRow ( 0 ) 
		THIS.of_AddRow ( 0 ) 
		
	CASE 1
	//	THIS.of_AddRow ( 0 ) 
		
END CHOOSE
THIS.SetRedraw ( TRUE ) 
THIS.Post of_AddNewIfNeeded ( )
IF lb_posting THEN
	THIS.Post of_ParseISOCode ( )
END IF

THIS.Post of_FormatForReload ( )
THIS.Post of_Seticons ( ) 




RETURN 1
end function

private function integer of_initializeequipment (long al_row);Boolean					lb_Reload
String					ls_Where
String					ls_EqRef
Long						ll_RowCount
Long						ll_TempID
Long						ll_FindID
Long						ll_FindRow
Int						li_Return = 1

n_cst_equipmentmanager	lnv_EquipmentManager
n_ds						lds_EquipmentCache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_Equipment2 lnv_ReloadEquipment

lnv_Dispatch = THIS.Event ue_GetDispatch ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

lnv_ReloadEquipment = CREATE n_cst_beo_Equipment2
lnv_Equipment = CREATE n_cst_beo_Equipment2


ls_EqRef = THIS.Object.eq_ref[al_row]
ll_FindID = lnv_EquipmentManager.of_GetIdFromRef ( ls_EqRef )

CHOOSE CASE ll_FindID


	CASE is < 0 
		// error
		li_Return = -1
	CASE 0
		// DNE
		lb_Reload = FALSE
		
		
	CASE ELSE
		lb_Reload = TRUE
		lnv_Dispatch.of_RetrieveEquipment ( {ll_FindID} )
		lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( ) 
		ll_FindRow = lds_EquipmentCache.Find ( "eq_id = " + String ( ll_FindID ) , 1 , lds_EquipmentCache.RowCount ( ) )
	
END CHOOSE
 	
IF li_Return = 1 THEN
	
	IF lb_Reload THEN
		lnv_ReloadEquipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) ) 
		lnv_ReloadEquipment.of_SetSourceID ( ll_FindID ) 
		
		IF lnv_ReloadEquipment.of_GetReloadShipment ( ) > 0 THEN // already a reload... problem
			
		
		ELSE
			
			THIS.SetRedraw ( FALSE )
			lds_EquipmentCache.RowsCopy (ll_FindRow, ll_FindRow, PRIMARY!, THIS, al_row + 1, PRIMARY! )
			THIS.RowsDiscard ( al_Row , al_Row , PRIMARY! )
			lnv_Equipment.of_SetSource ( THIS )
			lnv_Equipment.of_SetSourceRow ( al_row )
			THIS.SetItemStatus ( al_row, 0 , PRIMARY!, DataModified! ) 
			lnv_Equipment.of_SetReloadShipment ( lnv_Shipment.of_GetID ( ) )				
			THIS.SetRedraw ( TRUE ) 
			
		END IF
		
	ELSE// new equipment
	
		THIS.of_InitializeNewEquipment ( al_Row ) 
		
//		ll_TempID = lnv_Dispatch.of_GetTempEqID ( )
//		THIS.Object.eq_id [al_row] = ll_TempID
//		THIS.Object.oe_id [al_row] = ll_TempID
//		
//		lnv_Equipment.of_SetSource ( THIS )
//		lnv_Equipment.of_SetSourceRow ( al_row )
//		lnv_Equipment.of_SetShipment ( lnv_Shipment.of_GetID ( ) )	
		
	END IF
	
END IF

DESTROY ( lnv_Equipment )
DESTROY ( lnv_ReloadEquipment )

RETURN 1
end function

private function integer of_validatechangeofreuse (long al_row, string as_oldref, string as_newref);// this Method should be called when the the equipment attemting to be changed is on the original shipment
// the changing of the reference on the reload os not allowed.

Int		li_Return = 1
Int		li_MessageRtn
Long		ll_ReloadShipment
Long		ll_TempEqId
String	ls_OldRef
String	ls_NewRef
String	ls_Message
Boolean	lb_Reload

n_cst_beo_Equipment2 lnv_ThisEquipment
n_cst_beo_Equipment2 lnv_TempEquipment
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Shipment	lnv_ReloadShipment
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_equipmentManager	lnv_EquipmentManager


ls_OldRef = as_oldRef
ls_NewRef = as_NewRef
lnv_Dispatch = THIS.Event ue_GetDispatch ( )
lnv_Shipment = THIS.Event ue_GetShipment ( ) 

lnv_ReloadShipment = CREATE n_cst_beo_Shipment 
lnv_ThisEquipment = CREATE n_cst_beo_Equipment2
lnv_TempEquipment = CREATE n_cst_beo_Equipment2

IF Not ( IsValid ( lnv_Shipment ) AND IsValid ( lnv_Dispatch ) ) THEN
	li_Return = -1
END IF

lnv_ThisEquipment.of_SetSource ( THIS ) 
lnv_ThisEquipment.of_SetSourceRow ( al_row )
		
ll_ReloadShipment = lnv_ThisEquipment.of_GetReloadShipment ( )

IF ll_ReloadShipment > 0 AND lnv_Shipment.of_GetID ( ) = ll_ReloadShipment THEN
	li_Return = -1
	// they cant change the reload ref on the reload shipment. they have to do it from the "parent" shipment
END IF


IF li_Return = 1 THEN
	// see if what they are trying to set it to is one that already exists
	ll_TempEqID = lnv_EquipmentManager.of_GetIdFromRef ( as_newref )
	IF ll_TempEqID > 0 THEN  // eq exists
		lnv_Dispatch.of_RetrieveEquipment ( {ll_TempEqID} )
		lnv_TempEquipment.of_SetSource (lnv_Dispatch.of_GetEquipmentCache ( ) )
		lnv_TempEquipment.of_SetSourceID ( ll_TempEqId )
		IF lnv_TempEquipment.of_GetShipment ( ) > 0 THEN
			// the equipment specified is already lined 
			
			IF  lnv_TempEquipment.of_GetReloadShipment ( ) <= 0 THEN
				// See if the shipement is an export
				IF lnv_Shipment.of_GetMoveType ( ) = "E" THEN
					// allow the change to take place
					lb_Reload = TRUE
					/*conclusion here is:
						the new equipment specified already exists
						the new equipment is already linked to another shipment
						the new equipment has not been reloaded
						the current shipment is an EXPORT
						
							ALLOW THE CHANGE
							
					*/
				ELSE
					MessageBox( "Equipment Ref" , "The equipment specified already exists and cannot be reloaded on a non-export shipment." )
					
				END IF
							
			ELSE // it is already linked and reloaded... BAD
				MessageBox ( "Equipment Ref" , "The equipment you specified is already liked to shipment " + String ( lnv_TempEquipment.of_GetShipment ( ) ) + " and reoladed on shipment " + String ( lnv_TempEquipment.of_GetReloadShipment ( ) )  )
				li_Return = -1
			END IF
			
			

		ELSE
			//It does exist but it is not linked so let it go. 
			
			
		END IF
	ELSE
		// it DNE
	
	END IF
		
END IF 



IF li_Return = 1  THEN
	
	IF NOT lb_Reload THEN
		ls_Message = "By changing the equipment reference here you will be changing" + &
						 " it in all places this equipment is used."										
		IF ll_ReloadShipment > 0 THEN
			ls_Message += " This includes the reload shipment " + String ( ll_ReloadShipment ) + "." 
		END IF
											
		li_MessageRtn = MessageBox ( "Equipment Reference" , ls_Message , INFORMATION! , OKCANCEL!, 2 ) 
											
		IF li_MessageRtn = 1 THEN // make the change
									// this means change the ref 1 text on this shipment ( if appropriate ) 
									// see if the equipment is being used in a reload situation 
									// if it is change the ref 1 text there too.
		
											
			// first see if we need to change the ref 1 text on this shipment
			IF lnv_Shipment.of_GetRef1Text ( ) = ls_OldRef THEN
				lnv_Shipment.of_setRef1Text( ls_NewRef )
			END IF
			
			IF ll_ReloadShipment > 0 THEN
				lnv_Dispatch.of_RetrieveShipment ( ll_ReloadShipment ) 
				lnv_ReloadShipment.of_SetAllowFilterSet ( TRUE ) 
				lnv_ReloadShipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) ) 
				lnv_ReloadShipment.of_SetSourceID ( ll_ReloadShipment ) 
				IF lnv_ReloadShipment.of_GetRef1Text ( ) = ls_OldRef THEN
					lnv_ReloadShipment.of_setRef1Text( ls_NewRef )
				END IF
				
			END IF
		ELSE
			li_Return = 0 
		END IF
	END IF
END IF


IF li_Return = 1 THEN
	
	IF lb_Reload THEN
		THIS.of_InsertReloadEquipment ( al_row , ll_TempEqID )
		
		
		
	END IF
	
END IF



DESTROY ( lnv_ReloadShipment ) 
DESTROY ( lnv_ThisEquipment ) 
DESTROY ( lnv_TempEquipment ) 

RETURN li_Return 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////v
//
//
//
//
//
//
//
//
//
//
//
//li_Return = MessageBox ( "Equipment Reference" ,"By changing the equipment reference here you will be changing the" + &
//										" equipment reference on the other shipment since this is a reload.~r~n" + &
//										"Click YES to change both references upon save.~r~n" + &
//										"Click NO to create a new piece of equipment with a new reference.~r~n" + &
//										"Click CANCEL to abort changes." , INFORMATION! , YESNOCANCEL!, 3 ) 
//										
//CHOOSE CASE li_Return
//		
//	CASE 1 // allow change
//		
//	CASE 2 // new equipment
//		Long		ll_TempID
//		Long		ll_Null
//		SetNull ( ll_Null )
//		
//		
//		IF isValid ( lnv_Disp ) THEN
//			ll_TempID =  lnv_Disp.of_GetTempEqID ( )
//			SetNull ( ll_TempID )
//			this.SetItem ( al_Row , "eq_id" , ll_TempID )
//			this.SetItem ( al_Row , "eq_id" , ll_TempID )
//			THIS.SetItem ( al_Row , "eq_ref" , "" )
//			THIS.SetItem ( al_Row , "reloadShipment" , ll_Null )
//			
//			
//		ELSE
//			li_Return = -1
//		END IF
//		
//		
//	CASE 3 // abort
//		
//END CHOOSE
//		
//		
//RETURN li_Return 
end function

private function integer of_validaterefchange (long al_row, string as_oldref, string as_newref);Int		li_Return = 1
Int		li_CDRtn
Long		ll_ReloadShipment
Long		ll_CurentShipment
Long		ll_CurrentEqID
String	ls_CDError

n_cst_beo_equipment2		lnv_equipment
n_cst_beo_shipment		lnv_Shipment

n_cst_EquipmentManager	lnv_EqManager

//Validate Check digit on containers
IF li_Return = 1 THEN
	IF UPPER(Mid(as_newref, 4, 1)) = "U" THEN //4th letter 'U' denotes container
		IF lnv_EqManager.of_ValidateCheckDigit(as_newref, ls_CDerror) <> 1 THEN
			MessageBox ("Equipment Validation" , ls_CDerror )
			li_Return = -1
		END IF
	END IF
END IF

//Validate against existing equipement
IF li_Return = 1 THEN
	lnv_Shipment = THIS.Event ue_GetShipment ( )
	lnv_Equipment = CREATE n_cst_beo_Equipment2 
	IF  IsValid ( lnv_SHipment ) THEN
		
		lnv_Equipment.of_SetSource ( THIS )
		lnv_Equipment.of_SetSourceRow ( al_Row )
		
		ll_ReloadShipment = lnv_Equipment.of_GetReloadShipment ( )
		ll_CurentShipment = lnv_Shipment.of_GetID ( )
		
		IF isNull ( ll_ReloadShipment ) THEN
			ll_ReloadShipment = 0 
		END IF
		
		ll_CurrentEqID = THIS.object.eq_id [ al_Row ]
		
		IF THIS.of_DoesEqExistOnThisShipment ( as_newref ) > 0 THEN
			MessageBox ( "Equipment" , "The equipment entered already exists on this shipment." )
			li_Return = -1
		ELSE
			
			IF ll_CurrentEqID > 0 THEN // this is an edit
				
				li_Return = THIS.of_ValidateExistingEquipmentChange ( al_Row , as_newref , as_oldref )
	
			ELSE // new adddition 
				IF THIS.of_ValidateNewEquipmentAddition ( al_row , as_newref ) = 1 THEN
					li_Return = 1
				ELSE
					li_Return = -1
				END IF
			END IF
			
		END IF
	ELSE
		li_Return = -1
	END IF
END IF

DESTROY ( lnv_Equipment ) 

RETURN li_Return

end function

private function integer of_insertreloadequipment (long al_row, long al_eqid);Long	ll_FindRow

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_Shipment	lnv_Shipment

n_ds	lds_EquipmentCache

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Dispatch = THIS.Event ue_getDispatch ( ) 
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF IsValid ( lnv_Shipment ) AND IsValid ( lnv_Dispatch ) THEN

	lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( ) 
	ll_FindRow = lds_EquipmentCache.Find ( "eq_id = " + String ( al_eqid ) , 1 , lds_EquipmentCache.RowCount ( ) )
	
	
	THIS.SetRedraw ( FALSE )
	lds_EquipmentCache.RowsCopy (ll_FindRow, ll_FindRow, PRIMARY!, THIS, al_row + 1, PRIMARY! )
	THIS.RowsDiscard ( al_Row , al_Row , PRIMARY! )
	lnv_Equipment.of_SetSource ( THIS )
	lnv_Equipment.of_SetSourceRow ( al_row )
	THIS.SetItemStatus ( al_row, 0 , PRIMARY!, DataModified! ) 
	lnv_Equipment.of_SetReloadShipment ( lnv_Shipment.of_GetID ( ) )	
	
	//THIS.of_Removehaveposting( lnv_Equipment )  // this is done by the disp call below
	
///	IF THIS.GetItemString ( al_Row , "intermodalequipment_type")  = 'C' THEN
		THIS.of_LookForReloadChassis ( lnv_Equipment.of_getShipment ( )  )
	/// END IF
	
	THIS.SetRedraw ( TRUE ) 
	THIS.of_SyncWithCache ( lnv_Dispatch, false ) // added 8/1/03    //modified DEK 5-1-07 to false
	This.of_addnewifneeded( )								//added 5-1-07
	lnv_Dispatch.of_EquipmentReloaded ( lnv_Equipment ) 
	
	
END IF

DESTROY ( lnv_Equipment ) 


RETURN 1
end function

private function integer of_initializenewequipment (long al_row);Long	ll_TempID
Long	ll_ShipmentID		

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Equipment2	lnv_Equipment

lnv_Dispatch = THIS.Event ue_GetDispatch ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

lnv_Equipment = CREATE n_cst_beo_Equipment2
		
ll_TempID = lnv_Dispatch.of_GetTempEqID ( )
THIS.Object.eq_id [al_row] = ll_TempID
THIS.Object.oe_id [al_row] = ll_TempID


ll_ShipmentID = lnv_Shipment.of_GetID ( )
lnv_Equipment.of_SetSource ( THIS )
lnv_Equipment.of_SetSourceRow ( al_row )
lnv_Equipment.of_SetShipment ( ll_ShipmentID )

//POSTING
// added for eq posting
THIS.of_syncwithcache( lnv_Dispatch, false )		//DEK 5-1-07
This.of_addnewifneeded( )
//lnv_Equipment.of_SetReleaseDate ( lnv_Shipment.of_GetReleaseDate ( ) )
//lnv_Equipment.of_SetReleaseTime ( lnv_Shipment.of_GetReleaseTime ( ) )
//

//THIS.SetRow ( al_Row ) 
DESTROY ( lnv_Equipment )

RETURN 1
end function

private function long of_doesequipmentexist (string as_ref);String	lsa_Dupes[] //Dummy

Return of_DoesEquipmentExist(as_Ref, lsa_Dupes)
end function

private function boolean of_isshipmentexport ();Boolean					lb_Return
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = THIS.Event ue_GetShipment ( )

IF isValid ( lnv_Shipment ) THEN
	IF lnv_SHipment.of_GetMoveCode ( ) = "E" THEN
		lb_Return = TRUE
	END IF
ELSE
	SetNull ( lb_Return )	
	
END IF

RETURN lb_Return
end function

private function integer of_getequipment (long al_equipmentid, ref n_cst_beo_equipment2 anv_equipment);int	li_Return = 0

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Equipment2	lnv_Equipment

lnv_Equipment = CREATE n_Cst_beo_Equipment2
lnv_Dispatch = THIS.Event ue_GEtDispatch ( )

Int	li_Temp

IF IsValid ( lnv_Dispatch ) THEN
	
	//THIS.of_Syncwithcache( lnv_Dispatch )
	li_Temp = lnv_Dispatch.of_RetrieveEquipment ( {al_equipmentID} )
	li_Temp = lnv_Equipment.of_SetSource ( lnv_Dispatch.of_GetEquipmentCache ( ) ) 
	li_Temp = lnv_Equipment.of_SetSourceID ( al_equipmentID )
	IF lnv_Equipment.of_HasSource ( ) THEN

		anv_Equipment = lnv_Equipment
		li_Return = 1 
	END IF
		
ELSE
	li_Return = -1
END IF

RETURN li_Return 
end function

private function integer of_validatenewequipmentaddition (long al_row, string as_ref);Long		ll_EqID
Long		ll_CurrentShipment
Long		i
Long		ll_DupCount
Int		li_Return = 1
Boolean	lb_Relink
String	ls_Message
String	ls_Dupes
String	lsa_Dupes[]

n_cst_Beo_Shipment	lnv_Shipment
n_cst_equipmentmanager	lnv_Manager
n_cst_beo_Equipment2	lnv_Equipment
n_Cst_settings			lnv_Settings

lb_Relink = lnv_Settings.of_AllowShipmentChangeofLinkedEquipment (  )


lnv_Shipment = THIS.Event ue_GetShipment ( ) 
If IsValid ( lnv_Shipment ) THEN
	ll_CurrentShipment = lnv_Shipment.of_GetID ( ) 
ELSE
	li_Return = -1
END IF
	

IF li_Return = 1 THEN
	ll_EqID = THIS.of_DoesEquipmentExist ( as_Ref, lsa_Dupes )
	CHOOSE CASE ll_EqID
		CASE IS > 0 // equipment exists
				
			IF THIS.of_GetEquipment ( ll_EqID , lnv_Equipment ) = 1 THEN
				
				IF lnv_Equipment.of_GetShipment ( ) > 0 THEN
					
					IF lb_Relink THEN
						
						ls_Message = "The equipment specifed: " + as_Ref + " is currently linked to shipment " + String ( lnv_Equipment.of_GetShipment ( ) ) + & 
																". Do you want to link it to shipment " + String ( ll_CurrentShipment ) + " instead?~r~nBe sure to calculate all needed charges for the original shipment before re-linking."
						
						CHOOSE CASE  MessageBox ( "Specified Equipment" , ls_Message , Question! , YesNo! , 1) 
							CASE 1 // yes change the link
								//THIS.Post of_initializeExistingEquipment ( al_row , ll_EqID )
								//Post removed to fix issue 2888
								THIS.of_initializeExistingEquipment ( al_row , ll_EqID )								
							CASE ELSE
								li_Return = -1
								
						END CHOOSE 
						
						
						
					ELSE
						// already linked try reload			
					
					
						IF THIS.of_IsShipmentExport ( ) THEN
							IF lnv_Equipment.of_GetReloadShipment ( ) > 0 THEN
								MessageBox ( "Equipment Reference" , "The equipment entered already exists and is already reloaded." )					
								li_Return = -1
							ELSE
								// allow Reload
								IF THIS.of_InsertReloadEquipment ( al_row ,  ll_EqID ) = 1 THEN
									li_Return = 1
								END IF
								
							END IF
							
							
						ELSE
							MessageBox ( "Equipment Reference" , "The equipment entered already exists. Equipment can only be reloaded on export shipments." )
							li_Return = -1
						END IF
							
					END IF
						
				ELSE // not linked so allow the input.
					IF THIS.of_initializeExistingEquipment ( al_row , ll_EqID ) = 1 THEN
						li_Return = 1
						//DEK 4-2-07 If a shipment had a piece of equipment that was active and linked to it,
						/// then the user deactivated and unlinked it, and then entered the same equipment number(without saving)
						// it was showing up as a linked, deactivated piece of equipment.  This changes back
						//to active if they retyped it.
	//					IF THIS.Object.eq_status [ al_row ] <> "K" THEN
	//						THIS.post setitem(al_row,"eq_status", "K") // Object.eq_status [ al_row ] = "K"
	//					END IF
						// End change 4-2-07
					END IF
				END IF			
				
			ELSE
				MessageBox ( "Equipment Reference" , "An error occured while attempting to validate equipment entered." )
				li_Return = -1
			END IF
			
		CASE -2 //More than one exists, error state
			li_Return = -1
			ll_DupCount = UpperBound(lsa_Dupes)
			FOR i = 1 TO ll_DupCount
				ls_Dupes += lsa_dupes[i] + "~r~n"
			NEXT
			MessageBox("Specified Equipment" , "More than one piece of equipment already exists with that reference number.~r~n" + & 
						  "Duplicate reference numbers:~r~n" + ls_Dupes, INFORMATION! )		
		CASE 0 	//	EQUIPMENT DNE
		
			IF THIS.of_InitializeNewEquipment ( al_Row  ) = 1 THEN
				li_Return = 1
			END IF
			
		CASE ELSE 
			//Error
	END CHOOSE
	
END IF

Destroy ( lnv_Equipment ) 

RETURN li_Return
	
	
	


end function

private function integer of_initializeexistingequipment (long al_row, long al_eqid);/*
	******MFS 5/10/07 Changes:
							1) The call to this fn (from of_validatenewequipmentaddition) is not longer posted.
							2) The if statement 'IF al_row = 1 THEN  // added this on 12-20-05 for issue 2073'
							   has been commented out to fix 'cannot access object property' error in ue_eqrefchanged()
							   when relinking on row 2. 
*/


Long	ll_FindRow
Int	li_Rtn

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_Shipment	lnv_Shipment

n_ds	lds_EquipmentCache

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Equipment.of_SetAllowFilterSet ( TRUE ) 
lnv_Dispatch = THIS.Event ue_getDispatch ( ) 
lnv_Shipment = THIS.Event ue_GetShipment ( )

lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( ) 
ll_FindRow = lds_EquipmentCache.Find ( "eq_id = " + String ( al_eqid ) , 1 , lds_EquipmentCache.RowCount ( ) )

THIS.SetRedraw ( FALSE )

//(no save) and try to readd the same piece of equipment.
li_Rtn = lds_EquipmentCache.RowsCopy (ll_FindRow, ll_FindRow, PRIMARY!, THIS, al_row + 1, PRIMARY! )
//li_Rtn = lds_EquipmentCache.RowsCopy (ll_FindRow, ll_FindRow, PRIMARY!, THIS, al_row, PRIMARY! )

//IF al_row = 1 THEN  // added this on 12-20-05 for issue 2073
	li_Rtn = THIS.RowsDiscard ( al_Row , al_Row , PRIMARY! )
//END IF

li_Rtn = lnv_Equipment.of_SetSource ( THIS )
li_Rtn = lnv_Equipment.of_SetSourceRow ( al_row  )


li_rtn = THIS.SetItemStatus ( al_row , 0 , PRIMARY!, DataModified! ) 
li_Rtn = lnv_Equipment.of_SetShipment ( lnv_Shipment.of_GetID ( ) )		

//DEK 5/10/07	When relinking, if this isn't here the results look funky.
THIS.of_SyncWithCache ( THIS.Event ue_GetDispatch ( ), false )


THIS.SetRedraw ( TRUE ) 

DESTROY ( lnv_Equipment ) 

RETURN 1
end function

private function boolean of_iseditonreload (long al_Row);Boolean	lb_Return
Long		ll_Reloadshipment

n_cst_Beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( ) 

n_cst_beo_Equipment2	lnv_ThisEquipment
lnv_ThisEquipment = CREATE n_cst_beo_Equipment2

lnv_ThisEquipment.of_SetSource ( THIS ) 
lnv_ThisEquipment.of_SetSourceRow ( al_row )

ll_ReloadShipment = lnv_ThisEquipment.of_GetReloadShipment ( )

IF ll_ReloadShipment > 0 AND lnv_Shipment.of_GetID ( ) = ll_ReloadShipment THEN
	lb_Return = TRUE
	
	// they cant change the reload ref on the reload shipment. they have to do it from the "parent" shipment
END IF

DESTROY ( lnv_ThisEquipment ) 


RETURN lb_Return
end function

private function integer of_insertnewequipment (long al_row, string as_ref);Long						ll_NewRow
Long						ll_TempID
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Equipment2	lnv_Equipment

lnv_Dispatch = THIS.Event ue_GetDispatch ( )
lnv_Shipment = THIS.Event ue_GetShipment ( )

lnv_Equipment = CREATE n_cst_beo_Equipment2

ll_NewRow = THIS.of_AddRow ( al_Row )

IF ll_NewRow > 0 THEN
	
	ll_TempID = lnv_Dispatch.of_GetTempEqID ( )
	THIS.Object.eq_id [ll_NewRow] = ll_TempID
	THIS.Object.oe_id [ll_NewRow] = ll_TempID
	
	lnv_Equipment.of_SetSource ( THIS )
	lnv_Equipment.of_SetSourceRow ( ll_NewRow )
	lnv_Equipment.of_SetShipment ( lnv_Shipment.of_GetID ( ) )	
	lnv_Equipment.of_SetNumber ( as_Ref )

	THIS.ScrollToRow ( ll_NewRow )
	

END IF

DESTROY ( lnv_Equipment )


RETURN 1
end function

private function long of_addrow (long al_beforerow);
Long ll_NewRow
ll_newRow = THIS.InsertRow ( al_BeforeRow )

IF ll_NewRow > 0 THEN
	THIS.SetItem ( ll_NewRow , "eq_status" , 'K' )
	THIS.SetItem ( ll_NewRow , "eq_outside" , 'T' )
	THIS.SetItem ( ll_NewRow , "eq_height" , 96.0 )
	THIS.SetItem ( ll_NewRow , "eq_Length" , 40.0 )
	THIS.object.height [ll_NewRow ] = "-99"
END IF

RETURN ll_NewRow


end function

private function integer of_validateexistingequipmentchange (long al_row, string as_ref, string as_oldref);Int		li_Return = 1
Long		ll_EqID
Long		ll_CurrentShipment
Long		ll_EqShipment
Long		ll_ExistingEqID
Long		ll_DupCount
Long		i
Boolean	lb_Relink
String	ls_Message
String	ls_Dupes
String	lsa_Dupes[]


n_cst_beo_Shipment		lnv_Shipment
n_cst_beo_Equipment2		lnv_Equipment
n_cst_settings				lnv_Settings
n_cst_EquipmentManager	lnv_Equip

lnv_Shipment = THIS.Event ue_GetShipment ( )
lb_Relink = lnv_Settings.of_AllowShipmentChangeofLinkedEquipment (  )

IF IsValid ( lnv_Shipment ) THEN
	ll_CurrentShipment = lnv_Shipment.of_GetID ( )
ELSE
	li_Return = -1
END IF

IF THIS.GetItemString ( al_Row , "eq_status" ) <> 'K' THEN
	MessageBox ( "Equipment Reference" , "The piece of equipment you are attempting to edit is no longer active and cannot be edited." )
	li_Return = -1
END IF


IF li_Return = 1 THEN	
	IF THIS.of_isEditOnReload ( al_Row ) THEN
		li_Return = -1
		MessageBox ( "Equipment Reference" ,"You cannot edit the equipment reference on a reload. Either cancel the reload or goto the parent shipment and edit it there." )
	END IF
END IF

IF li_Return = 1 THEN
	ll_ExistingEqID = THIS.GetItemNumber ( al_row, "eq_id" ) 
	IF IsNull ( ll_ExistingEqID ) OR ll_ExistingEqID = 0 THEN
		li_Return = -1
		MessageBox ( "Equipment Reference" , "An errror occurred while attempting to identify the existing equipment." )
	END IF
END IF


IF li_Return = 1 THEN

	ll_EqID = THIS.of_DoesEquipmentExist ( as_Ref, lsa_Dupes)
	
	CHOOSE CASE ll_EqId
		CASE IS > 0 //Eq exists
			IF ll_EqId = THIS.object.eq_id [ al_Row ] THEN 
				//existing equipment is this one, accept edit
			ELSE
				IF THIS.of_GetEquipment ( ll_EqID , lnv_Equipment ) = 1 THEN
					ll_EqShipment = lnv_Equipment.of_GetShipment ( )
							
					IF ll_EqShipment > 0 THEN	// the equipment is linked 
					
						IF lb_Relink THEN		
							
							ls_Message = "The equipment specified: " + as_Ref + " is currently linked to shipment " + String ( ll_EqShipment ) + & 
																	".~r~nYou cannot relink over a reference number that already exists.~r~nTo preform a relink, you must " + &
																	"deactivate and unlink the current reference number first."
																	//". Do you want to link it to shipment " + String ( ll_CurrentShipment ) + " instead?~r~nBe sure to calculate all needed charges for the original shipment before re-linking."
																	
							/*MFS 5/8/07 - We are not allowing a re-link here because it is causing duplicates
							CHOOSE CASE  MessageBox ( "Specified Equipment" , ls_Message , Question! , YesNo! , 1) 
								CASE 1 // yes change the link
									THIS.of_InsertExistingEquipment ( ll_EqID, al_row  )								
								CASE ELSE
									li_Return = -1							
							END CHOOSE*/ 
							MessageBox ( "Specified Equipment" , ls_Message)	
							li_Return = -1
									
						ELSE
											
							IF THIS.of_IsShipmentExport ( ) THEN
								IF lnv_Equipment.of_GetReloadShipment ( ) > 0 THEN
									li_Return = -1
									MessageBox( "Equipment Reference" ,"The equipment specified already exists and has been reloaded. " )
								ELSE
									//THIS.Object.eq_ref [ al_Row ] = as_OldRef
									//THIS.of_InsertExistingEquipmentForReload ( ll_EqID , al_Row )
									IF THIS.of_Replaceexistingequipmentwithreload( ll_ExistingEqID , al_Row , ll_EqID ) = 1 THEN
										li_Return = 2
									ELSE
										li_Return = -1
									END IF
								END IF
								
							ELSE
								li_Return = -1
								MessageBox( "Equipment Reference" ,"The equipment specified already exists. Equipment can only be reloaded on export shipments." )				
							END IF
						END IF
					ELSE  // the equipment is not linked
						
						THIS.Object.eq_ref [ al_Row ] = as_OldRef
						THIS.of_InsertExistingEquipment ( ll_EqID , al_row )
						//THIS.of_InsertNewEquipment ( al_row ,as_ref )
						li_Return = -1
					END IF
				ELSE
					MessageBox( "Equipment Reference" ,"An error occurred while attempting to validate your entry." )
					li_Return = -1
				END IF
			END IF
		CASE -2	//More than one eq existing
			li_Return = -1
			ll_DupCount = UpperBound(lsa_Dupes)
			FOR i = 1 TO ll_DupCount
				ls_Dupes += lsa_dupes[i] + "~r~n"
			NEXT
			MessageBox("Specified Equipment" , "More than one piece of equipment already exists with that reference number.~r~n" + & 
						  "Duplicate reference numbers:~r~n" + ls_Dupes, INFORMATION! )				

		CASE 0 //EQ DNE
			// accept edit and change ref on shipment
	END CHOOSE
	
END IF


RETURN li_Return
end function

private function integer of_insertexistingequipment (long al_eqid, long al_row);Long	ll_FindRow

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_Shipment	lnv_Shipment

n_ds	lds_EquipmentCache

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Dispatch = THIS.Event ue_getDispatch ( ) 
lnv_Shipment = THIS.Event ue_GetShipment ( )

lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( ) 
ll_FindRow = lds_EquipmentCache.Find ( "eq_id = " + String ( al_eqid ) , 1 , lds_EquipmentCache.RowCount ( ) )

THIS.SetRedraw ( FALSE )
Int	li_CopyReturn
li_CopyReturn = lds_EquipmentCache.RowsCopy (ll_FindRow, ll_FindRow, PRIMARY!, THIS, al_row , PRIMARY! )
//THIS.RowsDiscard ( al_Row , al_Row , PRIMARY! )
lnv_Equipment.of_SetSource ( THIS )
lnv_Equipment.of_SetSourceRow ( al_row )
THIS.SetItemStatus ( al_row, 0 , PRIMARY!, DataModified! ) 
lnv_Equipment.of_SetShipment ( lnv_Shipment.of_GetID ( ) )				
THIS.SetRedraw ( TRUE ) 

DESTROY ( lnv_Equipment ) 


RETURN 1
end function

private function integer of_insertexistingequipmentforreload (long al_id, long al_row);Long	ll_FindRow

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_Shipment	lnv_Shipment

n_ds	lds_EquipmentCache

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Dispatch = THIS.Event ue_getDispatch ( ) 
lnv_Shipment = THIS.Event ue_GetShipment ( )

lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( ) 
ll_FindRow = lds_EquipmentCache.Find ( "eq_id = " + String ( al_ID ) , 1 , lds_EquipmentCache.RowCount ( ) )

THIS.SetRedraw ( FALSE )
lds_EquipmentCache.RowsCopy (ll_FindRow, ll_FindRow, PRIMARY!, THIS, al_row , PRIMARY! )
//THIS.RowsDiscard ( al_Row , al_Row , PRIMARY! )
lnv_Equipment.of_SetSource ( THIS )
lnv_Equipment.of_SetSourceRow ( al_row )
THIS.SetItemStatus ( al_row, 0 , PRIMARY!, DataModified! ) 
lnv_Equipment.of_SetReloadShipment ( lnv_Shipment.of_GetID ( ) )
THIS.of_Syncwithcache( lnv_Dispatch, false )	//DEK 5-1-07 modified to not retrieve
lnv_Dispatch.of_Equipmentreloaded( lnv_Equipment )
THIS.SetRedraw ( TRUE ) 

DESTROY ( lnv_Equipment ) 

RETURN 1 
end function

public function integer of_syncwithcache (n_cst_bso_dispatch anv_dispatch);return this.of_syncWithcache( anv_dispatch, true)
end function

private subroutine of_seticons ();Long	i
Long	ll_ShipmentID
String	ls_ModString 

n_cst_Beo_Shipment 	lnv_Shipment
THIS.SetRedraw ( FALSE ) 
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF IsValid ( lnv_Shipment ) THEN
	
	ll_ShipmentID = lnv_Shipment.of_GetID ( )
	
	THIS.Modify ( "FrontReload.visible = '1~tIF ( reloadshipment > 0 and reloadshipment <>" + String ( ll_ShipmentID ) + " , 1 , 0 )'" ) 
	THIS.Modify ( "BackReload.visible  = '1~tIF ( reloadshipment > 0 and reloadshipment = " + String ( ll_ShipmentID ) + " , 1 , 0 )'" ) 
	
	
	ls_ModString = "ReloadDate.Protect = ~"1~tIF (  reloadshipment > 0  AND describe ( 'txt_restrict_ind.text' )  = "+ String ( "'F'") + ", 0 , 1 )~""
	THIS.Modify ( ls_ModString )
	
	ls_ModString = "ReloadTime.Protect = ~"1~tIF (  reloadshipment > 0  AND describe ( 'txt_restrict_ind.text' )  = "+ String ( "'F'") + ", 0 , 1 )~""
	THIS.Modify ( ls_ModString )
	
	ls_ModString = "reloadfreetimeexpiredate.Protect = ~"1~tIF (  reloadshipment > 0  AND describe ( 'txt_restrict_ind.text' )  = "+ String ( "'F'") + ", 0 , 1 )~""
	THIS.Modify ( ls_ModString )
	
	
	ls_ModString = "reloadfreetimeexpiretime.Protect = ~"1~tIF (  reloadshipment > 0  AND describe ( 'txt_restrict_ind.text' )  = "+ String ( "'F'") + ", 0 , 1 )~""
	THIS.Modify ( ls_ModString )
	
END IF
THIS.SetRedraw ( TRUE ) 
end subroutine

private function integer of_formatforreload ();Long	ll_RowCount
Long	ll_I
Int	li_ReloadHeight = 268
Int	li_RegularHeight = 172


Int	li_Column
Long	ll_Row

ll_Row = THIS.GetRow ( )
li_Column = THIS.GetColumn ()
ll_RowCount = THIS.RowCount ( ) 
THIS.SetRedraw ( FALSE ) 
FOR ll_i = 1 TO ll_RowCount
	IF this.object.ReloadShipment [ ll_i ] > 0 THEN
		THIS.SetDetailHeight ( ll_i , ll_i , li_ReloadHeight ) 
	ELSE
		THIS.SetDetailHeight ( ll_i , ll_i , li_RegularHeight ) 
	END IF
NEXT
THIS.SetRedraw ( TRUE )
THIS.ScrollToRow ( ll_Row )
 
THIS.SetRow ( ll_Row ) 
THIS.SetColumn( li_Column )



RETURN 1
end function

private function integer of_addnewifneeded ();Long	ll_RowCount
Long	ll_i

ll_RowCount = THIS.RowCount ( )
FOR ll_i = 1 TO ll_RowCount
	//IF Len ( Trim ( THIS.GetItemString ( ll_i , "eq_ref"  ) ) ) = 0 THEN
	//IF IsNull (  THIS.GetItemString ( ll_i , "eq_ref"  ) ) THEN
	IF IsNull (  THIS.GetItemNumber ( ll_i , "eq_id"  ) ) THEN
		EXIT 
	END IF
NEXT

IF ll_i > ll_RowCount THEN
	THIS.Post of_AddRow ( 0 ) 
END IF

RETURN 1
end function

public function integer of_setenable (boolean ab_value);Long		ll_ColumnCount	
Long		ll_i
String	ls_ColumnName
String	ls_ModifyRtn


IF ab_value THEN
	THIS.Object.txt_restrict_ind.Text = 'F'
ELSE
	THIS.Object.txt_restrict_ind.Text = 'T'
END IF
	
//ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )
//
//FOR ll_i = 1 TO ll_ColumnCount
//	ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )
//	
//	
//	CHOOSE CASE ls_ColumnName 
//			
//		CASE "ds_id" , "movecode" , "ds_ship_comment" , "ds_ref1_text" , "ds_ref2_text" , "ds_ref3_text" , "ds_status" , "ds_bill_date" , "ds_pronum"
//			
//		
//			
//		CASE ELSE
//			ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
//		//	ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )	
//		
//	END CHOOSE
//	
//NEXT
//
// computed fields are not accounted for in get column count
//THIS.Modify( "comp_confirmed.Width=0")
//THIS.Modify( "comp_routed.Width=0")
//THIS.Modify( "comp_tz_adj.Width=0")
//THIS.Post of_AllowEdit ( TRUE ) 

RETURN 1
end function

public function integer of_selectequipment (string as_type, long al_row);Int	li_Null
SetNull ( li_Null )

IF THIS.RowCount ( ) >= al_Row THEN
	
	CHOOSE CASE UPPER ( as_Type ) 
			
		CASE "TRAILER" , 'V'
			
			THIS.SetItem ( al_Row , "intermodalequipment_type" , "V" )
			THIS.SetItem ( al_Row , "eq_axles" , 2 )		
			
		CASE "CONTAINER" , 'C'
			
			THIS.SetItem ( al_Row , "intermodalequipment_type" , "C" )
			THIS.SetItem ( al_Row , "eq_axles" , li_Null )	
			// this sets the length to the same as the previous if the previous was a Chassis
			IF al_Row > 1 THEN
				IF THIS.GetItemString ( al_Row - 1  , "intermodalequipment_type" ) = "H" THEN
					THIS.SetItem ( al_Row , "eq_length" , THIS.GetItemNumber ( al_Row - 1 , "eq_length" )  )	
				END IF
			END IF
			
		CASE "CHASSIS" , "H"
			
			THIS.SetItem ( al_Row , "intermodalequipment_type" , "H" )
			THIS.SetItem ( al_Row , "eq_axles" , 2 )	
			
			// this sets the length to the same as the previous if the previous was a Container
			IF al_Row > 1 THEN
				IF THIS.GetItemString ( al_Row - 1  , "intermodalequipment_type" ) = "C" THEN
					THIS.SetItem ( al_Row , "eq_length" , THIS.GetItemNumber ( al_Row - 1 , "eq_length" )  )	
				END IF
			END IF
		
		CASE "RAILBOX" , 'B'
			
			THIS.SetItem ( al_Row , "intermodalequipment_type" , "B" )
			THIS.SetItem ( al_Row , "eq_axles" , 2 )		
		
	END CHOOSE 
END IF
RETURN 1

//"TRLR~tV/FLBD~tF/REFR~tR/TANK~tK/RBOX~tB/CHAS~tH/CNTN~tC/" 
end function

public function integer of_setreleasedate (date ad_value);//Long	ll_RowCount	
//Long	i
//
//ll_RowCount = THIS.RowCount ( )
//
//FOR i = 1 TO ll_RowCount
//	IF IsNull ( THIS.GetItemDate ( i , "releasedate" ) ) THEN
//		THIS.SetItem ( i , "releasedate" , ad_value )	
//	END IF
//NEXT
//
RETURN 1

end function

public function integer of_setreleasetime (time at_value);//Long	ll_RowCount	
//Long	i
//
//ll_RowCount = THIS.RowCount ( )
//
//FOR i = 1 TO ll_RowCount
//	IF IsNull ( THIS.GetItemTime ( i , "releasetime" ) ) THEN
//		THIS.SetItem ( i , "releasetime" , at_value )	
//	END IF
//NEXT

RETURN 1
end function

private function long of_doeseqexistonthisshipment (string as_ref);Long		ll_FindRtn
Long		ll_EqId
Long		ll_RowCount, i
String	lsa_Dupes[]

n_cst_EquipmentManager	lnv_EqManager

DataStore	lds_Cache

/* MFS - 4/16/07 - commented code below and replaced with new existsInCache logic
ll_FindRtn = THIS.Find (  "eq_ref = '" + as_Ref + "'", 1 ,THIS.RowCount ( ) + 1 )	
IF ll_FindRtn = THIS.GetRow ( ) THEN
	ll_FindRtn = THIS.Find (  "eq_ref = '" + as_Ref + "'", ll_FindRtn + 1 ,THIS.RowCount ( ) + 1 )	
END IF*/


lds_Cache = Create DataStore

lds_Cache.Dataobject = This.Dataobject

//Copy to ds
ll_RowCount = This.RowCount()
FOR i = 1 TO ll_RowCount
	IF i <> This.GetRow() THEN
		This.RowsCopy( i, i, Primary!, lds_Cache, lds_Cache.RowCount() + 1, Primary!)
	END IF
NEXT

lnv_EqManager.of_ExistsInCache( lds_Cache, as_ref, "", "", ll_FindRtn)

Destroy(lds_Cache)

RETURN ll_FindRtn


end function

private function integer of_lookforreloadchassis (long al_inboundshipment);n_Cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch	
n_Cst_beo_Equipment2	lnva_Equipment[]

Long	ll_RowCount
Long	ll_i
Long	ll_EmptyRow
Int	li_EqCount


lnv_SHipment = CREATE n_cst_beo_Shipment 
lnv_Dispatch = THIS.Event ue_GetDispatch ( )

IF IsValid ( lnv_Shipment ) AND isValid ( lnv_Dispatch ) THEN
	
	lnv_Dispatch.of_retrieveequipmentforshipment ( al_inboundshipment )	
	
	//Look for empty row 
	ll_RowCount = THIS.RowCount ( )
	FOR ll_i = 1 TO ll_RowCount		
		IF IsNull (  THIS.GetItemString ( ll_i , "eq_ref"  ) ) THEN
			EXIT 
		END IF
	NEXT
		
	ll_EmptyRow = ll_i
		
	lnv_Dispatch.of_RetrieveShipment ( al_inboundShipment )
	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
	lnv_Shipment.of_SetSourceid ( al_inboundShipment ) 
	
	li_EqCount = lnv_Shipment.of_getLinkedEquipment ( lnva_Equipment )
	FOR ll_i = 1 TO li_EqCount 
		IF lnva_Equipment [ ll_i ].of_GetType ( ) = 'H' AND IsNull ( lnva_Equipment [ ll_i ].of_GetReloadShipment ( ) ) THEN			
			THIS.of_insertexistingequipmentforreload ( lnva_Equipment [ ll_i ].of_GetId ( ) , ll_EmptyRow )
			IF ll_EmptyRow > 0 THEN
				ll_EmptyRow ++
			END IF
		END IF
		DESTROY ( lnva_Equipment [ ll_i ] )
	NEXT
	//THIS.of_AddNewIfNeeded ( )
	
END IF

DESTROY ( lnv_Shipment )
RETURN 1
end function

public function integer of_proposepostingneed (n_cst_beo_equipment2 anv_equipment);Int	li_Return = -1
Int	li_PostingRtn
String	ls_Ref

n_Cst_licenseManager	lnv_LivMan
n_cst_bso_Dispatch	lnv_Disp
n_Cst_equipmentPosting	lnv_EqPosting

lnv_Disp = THIS.event ue_getdispatch( )

IF isValid ( lnv_Disp ) THEN
	lnv_EqPosting = lnv_Disp.of_GetEquipmentposting( ) 
	IF IsValid ( lnv_EqPosting ) THEN 
		li_Return = 1
	END IF
END IF

IF li_Return = 1 THEN
	IF NOT lnv_LivMan.of_HasEquipmentpostinglicense( ) THEN
		li_Return = 0
	END IF
	ls_Ref = anv_equipment.of_GetNumber ( )
	// check to see if we are registered to post as well as check the rules here
	IF NOT (IsNull ( ls_Ref ) OR  match ( ls_Ref , "^UNK[1-9]" )) THEN
		li_Return = 0 
	END IF
END IF

IF li_Return = 1 THEN
	li_postingRtn = lnv_EqPosting.of_AddNeed( anv_equipment )
	li_Return = li_PostingRtn
END IF

//IF li_Return = 1 THEn
//	THIS.of_Syncwithcache( lnv_Disp )
//END IF

RETURN li_Return


end function

public function integer of_removeneedposting (n_cst_beo_equipment2 anv_equipment);Int	li_Return = -1
Int	li_PostingRtn

n_cst_LicenseManager	lnv_LicMan
n_cst_bso_Dispatch	lnv_Disp
n_Cst_equipmentPosting	lnv_EqPosting

lnv_Disp = THIS.event ue_getdispatch( )

IF isValid ( lnv_Disp ) THEN
	lnv_EqPosting = lnv_Disp.of_GetEquipmentposting( ) 
	IF IsValid ( lnv_EqPosting ) THEN 
		li_Return = 1
	END IF
END IF

IF li_Return = 1 THEN
	IF NOT lnv_LicMan.of_HasEquipmentpostinglicense( ) THEN
		li_Return = 0
	END IF
END IF

IF li_Return = 1 THEN
	li_postingRtn = lnv_EqPosting.of_removeNeed ( anv_equipment )
	li_Return = li_PostingRtn
END IF

IF li_Return = 1 THEN
	THIS.of_Syncwithcache( lnv_Disp, false ) //DEK 5-1-07
END IF

RETURN li_Return

end function

public function integer of_postequipment (long al_row);String	ls_LeaseType
String	ls_EqRef
String	ls_Code
Boolean	lb_Post = TRUE
n_cst_EquipmentManager	lnv_EqMan
n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_equipmentlease2 lnv_equipmentlease

lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Equipment.of_SetSource ( THIS ) 
lnv_Equipment.of_SetSourceRow ( al_row ) 

ls_LeaseType = THIS.GetItemString ( al_row , 'equipmentleasetype_line' )
ls_Code = THIS.GetITemString ( al_row , "equipment_isocode" )

ls_EqRef = lnv_Equipment.of_GetNumber( )

IF THIS.GetITemString ( al_row , "intermodalequipment_type" ) <> lnv_EqMan.cs_CNTN THEN
	lb_Post = FALSE
	MessageBox ( "Equipment Posting", "Currently, only the posting of containers is allowed." )
END IF

IF lb_Post THEN
	IF Len ( ls_LeaseType )  = 0 THEN
		lb_Post = FALSE
		MessageBox ("Equipment Posting", "Only equipment with an assigned lease type may be posted" ) 
	END IF
END IF
	
IF lb_Post THEN
	IF IsNull ( ls_Code ) THEN
		lb_Post = FALSE
		MessageBox ("Equipment Posting", "Please enter equipment details before flagging the equipment for posting." )
	END IF
END IF

	
IF lb_Post THEN
	IF IsNull ( ls_EqRef ) OR Match ( ls_EqRef, "^UNK[1-9]") THEN
		THIS.of_Proposepostingneed( lnv_Equipment )
	ELSE
		THIS.of_Posthave( lnv_Equipment )
	END IF
	
	THIS.of_syncwithcache( THIS.event ue_getdispatch( ), false ) //DEK 5-1-07
END IF



Destroy ( lnv_Equipment  )

RETURN 1
end function

public function integer of_posthave (n_cst_beo_equipment2 anv_equipment);Int	li_Return = -1
Int	li_PostingRtn

n_cst_LicenseManager	lnv_LicMan
n_cst_bso_Dispatch	lnv_Disp
n_Cst_equipmentPosting	lnv_EqPosting

lnv_Disp = THIS.event ue_getdispatch( )

IF isValid ( lnv_Disp ) THEN
	lnv_EqPosting = lnv_Disp.of_GetEquipmentposting( ) 
	IF IsValid ( lnv_EqPosting ) THEN 
		li_Return = 1
	END IF
END IF

IF li_Return = 1 THEN
	IF NOT lnv_LicMan.of_HasEquipmentpostinglicense( ) THEN
		li_Return = 0 
	END IF
	
	// check to see if we are registered to post as well as check the rules here
//	IF Len ( anv_equipment.of_GetNumber ( ) ) > 0 THEN
//		li_Return = 0 
//	END IF
END IF

IF li_Return = 1 THEN
	li_postingRtn = lnv_EqPosting.of_AddHave( anv_equipment )
	li_Return = li_PostingRtn
END IF



RETURN li_Return


end function

public function integer of_removehaveposting (n_cst_beo_equipment2 anv_equipment);Int	li_Return = -1
Int	li_PostingRtn

n_cst_bso_Dispatch	lnv_Disp
n_Cst_equipmentPosting	lnv_EqPosting

lnv_Disp = THIS.event ue_getdispatch( )

IF isValid ( lnv_Disp ) THEN
	lnv_EqPosting = lnv_Disp.of_GetEquipmentposting( ) 
	IF IsValid ( lnv_EqPosting ) THEN 
		li_Return = 1
	END IF
END IF

IF li_Return = 1 THEN
	// check to see if we are registered to post as well as check the rules here
END IF

IF li_Return = 1 THEN
	li_postingRtn = lnv_EqPosting.of_removeHave ( anv_equipment )
	li_Return = li_PostingRtn
END IF

IF li_Return = 1 THEn
	THIS.of_Syncwithcache( lnv_Disp, false )		//Dek 5-1-07
END IF

RETURN li_Return

end function

public function integer of_parseisocode ();Long	ll_RowCount
Long	i
String	ls_Code
String	ls_Length
String	ls_Goose
String	ls_Desc

n_cst_EquipmentManager	lnv_EqMan

ll_RowCount = THIS.RowCount ( )

FOR i = 1 TO ll_RowCount 

	ls_Code = THIS.GetITemString ( i , "equipment_isocode" )
	IF len ( ls_code ) > 0 THEN
		lnv_EqMan.of_Parseisocode( ls_Code , ls_Length , ls_Goose, ls_Desc )
		THIS.of_SetIsoGooseNeckandHeight (i , ls_Goose)
		THIS.of_SetIsoDescription ( i, ls_Desc )
		THIS.SetItemstatus( i,0,PRIMARY!, NOTMODIFIED!)
	ELSE 
		// default iso
	END IF
	
	
	
NEXT

RETURN 1



end function

public function string of_buildisocode (long al_row);String	ls_Return

Int		li_Length
String	ls_Length 
String	ls_GooseAndHeight
String	ls_GooseNeck
String	ls_Height
String	ls_Desc

String	ls_Temp
n_cst_numerical	lnv_Num


li_Length =  THIS.GetItemNumber ( al_Row , "eq_length" )  
CHOOSE CASE li_Length 
		
	CASE 10
		ls_Length = '1'
	CASE 20
		ls_Length = '2'
	CASE 30
		ls_Length = '3'
	CASE 40
		ls_Length = '4'
	CASE is > 40
		ls_Length = '9'
	CASE is > 30
		ls_Length = '8'
	CASE is > 20
		ls_Length = '7'
	CASE is > 10 
		ls_Length = '6'
	CASE ELSE
		ls_Length = '0'			
END CHOOSE

ls_GooseNeck = THIS.GetItemString ( al_row , "gooseneck" )
ls_Height = THIS.GetItemString ( al_row , "height" ) 
IF isNull ( ls_Height ) THEN
	ls_Height = ""
END IF

IF isNull ( ls_GooseNeck ) THEN
	ls_GooseNeck = ""
END IF

CHOOSE CASE ls_Height
	CASE "8" , "9"
		ls_GooseAndHeight = ls_Height
	CASE ELSE
		ls_Temp = lnv_Num.of_binary( Dec ( ls_Height ) ) + ls_GooseNeck
		ls_GooseAndHeight = String (lnv_Num.of_decimal( ls_Temp ))
			
END CHOOSE
	
	
ls_Desc = THIS.GetItemString ( al_row , "isoDescription" )

IF ISNull (ls_Length) OR Len ( ls_length ) = 0 THEN
	ls_Length = "0"
END IF

IF ISNull (ls_GooseAndHeight) OR Len ( ls_GooseAndHeight ) = 0 THEN
	ls_GooseAndHeight = "0"
END IF

IF ISNull (ls_Desc) OR Len ( ls_Desc ) = 0  THEN
	ls_Desc = "00"
END IF

ls_Return = ls_Length + ls_GooseAndHeight + ls_Desc

RETURN ls_Return





end function

public function integer of_modifyisocode (long al_row);String	ls_Code

ls_Code = THIS.of_Buildisocode( al_row )


THIS.Post SetItem ( al_Row , "equipment_isocode" , ls_Code ) 

RETURN 1
end function

public function integer of_setisogooseneckandheight (long al_row, string as_value);String	ls_Goose
String	ls_temp
String	ls_Height
n_cst_numerical	lnv_Num
CHOOSE CASE as_Value
		
	CASE "8" , "9" 
		ls_Height =  as_Value
	CASE ELSE
			
		ls_Temp = lnv_Num.of_binary( Dec ( as_Value ) )
		ls_Goose = Right ( ls_Temp , 1 ) 		
		ls_Height =  String (lnv_Num.of_decimal( Left ( ls_Temp , LEN ( ls_Temp ) -1 ) ))
		IF isNull ( ls_Height ) THEN
			ls_Height = "0"
		END IF
END CHOOSE
	
THIS.Object.height[al_Row] = ls_Height
THIS.Object.Gooseneck[al_Row] = ls_Goose
//THIS.SetItem ( al_Row , "height" , ls_Height )
//THIS.SetItem ( al_Row , "Gooseneck" , ls_Goose )
		
		
RETURN 1
end function

public function integer of_setisodescription (long al_row, string as_value);THIS.object.isodescription[al_row] = as_value

RETURN 1//THIS.SetItem ( al_Row , "isodescription" , as_Value  )
end function

private function integer of_setfocus (integer ai_column, long al_row);THIS.Post SetColumn ( ai_Column )
THIS.Post SetRow ( al_Row ) 
RETURN 1

end function

public function integer of_eqrefchanged (string as_oldref, long al_row, string as_data);String	ls_OldRef
String	ls_NewRef
String	ls_CurrentRef
String	ls_EqType
String	ls_EqType2
Int		li_ValidateRtn
Long		ll_Return
n_cst_msg	lnv_msg
s_parm		lstr_parm


IF Len ( Trim ( as_data ) ) > 0 THEN
			
	ls_NewRef = as_data
	ls_OldRef = as_Oldref
	
	
	li_ValidateRtn = THIS.of_ValidateRefChange ( al_row , ls_OldRef , ls_newRef )
	
	//MFS - 4/12/07 - If we have done a reload, the eqref may be different from ls_newRef
	//So check the existing value 
	ls_CurrentRef = This.object.eq_ref[al_row]
	IF ls_CurrentRef <> ls_NewRef THEN
		ls_NewRef = ls_CurrentRef
	END IF
	//END MFS - 4/12/07

	
	CHOOSE CASE li_ValidateRtn
			
		CASE 1 // make the change
			
			
			THIS.Post Event ue_EqRefChanged ( ls_OldRef ,  ls_NewRef , al_row )		
			
		CASE 2 //Existing reload
			//MFS - 4/13/07 - We may not want to do all the ue_EqrefChanged processing, but
			//we should make sure the ref1/2 fields are in sync with the new reload container
			ls_EqType = THIS.object.intermodalequipment_type [ 1 ]
			ls_EqType2 =  THIS.object.intermodalequipment_type [ 2 ]

			THIS.Post of_DetermineRef1Text ( as_oldRef , ls_NewRef, ls_EqType, ls_EqType )
			THIS.Post of_DetermineRef2Text ( as_oldRef , ls_NewRef , al_Row, ls_EqType2, ls_EqType )
			//END MFS - 4/13/07
			ll_Return = 1
		CASE 3
			//2  Reject the data value but allow the focus to change
			ll_Return = 1
		CASE -1
			ll_Return = 1	
			THIS.Post SetItem( al_row , "eq_ref" , ls_OldRef )
		CASE ELSE
								
	END CHOOSE
		
	THIS.Post of_FormatForReload ( )
	//THIS.post of_AddNewIfNeeded ( )

ELSE //condition added by dan 2-5-07
	this.event ue_showequipmentmessagebox( al_row, as_oldRef )		
END IF
	
Return 1
end function

public function integer of_addalert (long al_row);n_cst_beo_Equipment2	lnv_Eq

lnv_Eq = CREATE n_cst_beo_Equipment2

lnv_Eq.of_SetSource ( THIS ) 
lnv_Eq.of_SetSourceRow ( al_Row )

if lnv_Eq.of_GetID () > 10000000 then
	lnv_Eq.of_AddUserAlert ( )
ELSE
	messagebox("Equipment Alert", "Cannot create an alert for this piece of "+&
		"equipment until you have saved your changes.")
END IF

DESTROY ( lnv_Eq )

RETURN 1
end function

public function string of_getequipmentprefix (long al_row);String	ls_EqRef
String	ls_Prefix 
Char		lca_eqRef[]
Char		lc_Char
Long		ll_Row
Long		ll_StringLength
Int		li_i


n_cst_String	lnv_String

ll_Row = al_row
IF ll_Row > 0 THEN
	
	ls_EqRef = Trim (  THIS.Object.eq_ref[ ll_row ] )
	
END IF

ll_StringLength = Len ( ls_eqRef )

IF ll_StringLength > 0 THEN
	
	lca_EqRef = ls_EqRef
	
	//Loop through the entire string
	For li_i = 1 to ll_stringlength
		//Get one character at a time
		lc_char = lca_EqRef[li_i]
		If lnv_String.of_IsAlpha(lc_char) Then
			ls_Prefix += String ( lc_Char )
		ELSE
			EXIT
			// stop when the firs non alpha character is encountered.
		END IF
	Next

END IF

RETURN ls_Prefix


end function

private function integer of_replaceexistingequipmentwithreload (long al_existingeqid, long al_existingeqrow, long al_reloadeqid);Int	li_Return = 1
Long	ll_Shipment

n_cst_Beo_Equipment2	lnv_ExistingEquipment
n_cst_EquipmentManager	lnv_EqManager

IF THIS.of_GetEquipment( al_existingeqid ,lnv_ExistingEquipment ) <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF lnv_EqManager.of_Isequipmentrouted( lnv_ExistingEquipment, this.event ue_getdispatch( )) THEN	
		MessageBox ( "Change Equipment" , "You are attempting to replace the equipment with a reload. However the existing piece of equipment has been routed. Please remove any routing before attemping to switch to a reload." )
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	IF THIS.Event ue_DeactivateEquipment ( al_existingeqrow ) <> 1 THEN
		MessageBox ( "Change Equipment" , "An error occurred while attempting to change the equipment number." )
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.Event ue_UnlinkEquipment ( al_existingeqrow ) <> 1 THEN
		MessageBox ( "Change Equipment" , "An error occurred while attempting to change the equipment number." )
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	THIS.SetReDraw (FALSE)
	THIS.of_insertexistingequipmentforreload( al_reloadeqid , al_existingeqrow )	
	
	lnv_ExistingEquipment.of_SetSource ( THIS )
	lnv_ExistingEquipment.of_SetSourceRow ( al_existingeqrow ) 
	THIS.of_LookForReloadChassis ( lnv_ExistingEquipment.of_getShipment ( )  )
	THIS.SetRedraw ( TRUE ) 
END IF

DESTROY ( lnv_ExistingEquipment )


RETURN li_Return
end function

private function integer of_labeltempeqnumber (long al_row);
Long	ll_ShipmentID

n_cst_Beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )
IF isValid ( lnv_Shipment ) THEN
	ll_ShipmentID = lnv_Shipment.of_GetID ( )
END IF


IF THIS.AcceptText ( ) = 1 THEN
	IF THIS.GetItemNumber( al_Row, "eq_id" ) >= 0 AND IsNull ( THIS.GetItemString ( al_Row , "eq_Ref" )) THEN
		THIS.SetItem ( al_Row , "eq_Ref"	, 'UNK' + String( al_Row ) + "-" + String ( ll_ShipmentID )   )			
		THIS.of_SyncWithCache ( THIS.Event ue_GetDispatch ( ), false )  //DEK modified 5-1-07 to use false
	END IF
END IF


RETURN 1
end function

private function integer of_determineref1text (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype);n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )

String	ls_EquipmentType
String	ls_EquipmentRef
String	ls_Ref1Text
Int		li_RefType
Int		li_SetType 
Int		li_originalEqType

//we need to determine what changed. IT was either the ref or the type.
IF as_originaleqref = as_currenteqref THEN
	//we know the type changed
	ls_equipmentType = as_currenteqtype
ELSE
	ls_equipmentType = as_originaleqtype
END IF


//ls_EquipmentType = THIS.object.intermodalequipment_type [ 1 ]
ls_EquipmentRef = THIS.object.eq_ref [ 1 ]

// modified to only set the ref value if no label has been specified.
IF IsValid ( lnv_Shipment ) AND Len ( as_Currenteqref ) > 0 THEN
	
	
	li_RefType = lnv_Shipment.of_getRef1Type ( ) 
	ls_Ref1Text = lnv_Shipment.of_GetRef1text ( ) 
	//IF isNull ( ls_Ref1Text ) OR ls_Ref1Text = as_originaleqref OR Len ( ls_Ref1Text ) = 0 THEN	
	//IF isNull ( lnv_Shipment.of_GetRef1Text ( ) ) OR lnv_Shipment.of_GetRef1Text ( ) = as_originaleqref THEN	
		

	
	//Determine the original type
	CHOOSE CASE as_originaleqtype
		CASE 'C'
			li_originalEqType = 20 
		CASE 'B'
			li_originalEqType = 26
		CASE 'H'
			li_originalEqType = 28	
		CASE 'V'
			li_originalEqType = 23
	END CHOOSE
	
	
	//determine the set Type	
	CHOOSE CASE as_currenteqtype
		CASE 'C'
			li_SetType = 20 
		CASE 'B'
			li_SetType = 26
		CASE 'H'
			li_SetType = 28	
		CASE 'V'
			li_SetType = 23
	END CHOOSE
	
	IF (li_RefType = li_originalEqType AND as_originaleqref = ls_Ref1Text) OR li_Reftype = 0 OR isNull ( li_RefType ) OR isNull ( ls_Ref1Text) OR (li_originaleqType > 0 AND len( ls_Ref1Text ) = 0 ) &
		OR  (li_setType = li_refType AND ls_Ref1Text = "" ) THEN	//DEK 4-9-07 added condition so that if the ref field contains a type, and you specify equipment with that type, it will populate the ref field.

		
		IF li_SetType > 0 THEN
			lnv_Shipment.of_SetRef1Type( li_SetType )
			lnv_Shipment.of_SetRef1Text ( as_currenteqref )
		END IF	
	END IF

//old code
//	IF (li_Reftype = 0 OR isNull ( li_RefType ) ) OR (  li_SetType = li_RefType AND ( isNull ( ls_Ref1Text ) OR ls_Ref1Text = as_originaleqref ) )THEN
//		
//		
//		
//		IF li_SetType > 0 THEN
//			lnv_Shipment.of_SetRef1Type( li_SetType )
//			lnv_Shipment.of_SetRef1Text ( as_currenteqref )
//		END IF	
//				
//	END IF		
END IF			
	
RETURN 1
end function

private function integer of_determineref2text (string as_originaleqref, string as_neweqref, long al_row, string as_originaleqtype, string as_neweqtype);//DEK 3-27-07, we need to determine the text from whether or not both the original text and ref matched.	
n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )

String	ls_EquipmentType
String	ls_EquipmentRef
String	ls_ref2Text
Int		li_originalEqType
Int		li_RefType
Int		li_SetType 


IF al_Row <= THIS.RowCount () AND al_Row > 1 THEN
	ls_EquipmentType = THIS.object.intermodalequipment_type [ al_Row ]
	ls_EquipmentRef = THIS.object.eq_ref [ al_Row ]
	// modified to only set the ref value if no label has been specified.
	IF IsValid ( lnv_Shipment ) AND Len ( as_neweqref ) > 0 THEN
		li_RefType = lnv_Shipment.of_getRef2Type ( ) 
		ls_ref2Text = lnv_Shipment.of_GetRef2text ( ) 
			
		//IF isNull ( ls_ref2Text ) OR ls_ref2Text = as_originaleqref OR Len ( ls_ref2Text ) = 0 THEN	
			
			//Determine the original type
	CHOOSE CASE as_originaleqtype
		CASE 'C'
			li_originalEqType = 20 
		CASE 'B'
			li_originalEqType = 26
		CASE 'H'
			li_originalEqType = 28	
		CASE 'V'
			li_originalEqType = 23
	END CHOOSE
	
	CHOOSE CASE ls_EquipmentType 
			CASE 'C'
				li_SetType = 20 
			CASE 'B'
				li_SetType = 26
			CASE 'H'
				li_SetType = 28	
			CASE 'V'
				li_SetType = 23
		END CHOOSE
	IF (li_RefType = li_originalEqType AND as_originaleqref = ls_Ref2Text) OR li_Reftype = 0 OR isNull ( li_RefType ) OR isNull ( ls_Ref2Text) OR (li_originaleqType > 0 AND len( ls_Ref2Text ) = 0 ) &		
		OR  (li_setType = li_refType AND ls_Ref2Text = "" ) THEN	//DEK 4-9-07 added condition so that if the ref field contains a type, and you specify equipment with that type, it will populate the ref field.	
				
	//	IF (li_Reftype = 0 OR isNull ( li_RefType ) ) OR (  li_SetType = li_RefType AND ( isNull ( ls_Ref2Text ) OR ls_Ref2Text = as_originaleqref ) )THEN	
			IF li_SetType > 0 THEN
				lnv_Shipment.of_SetRef2Type( li_SetType )
				lnv_Shipment.of_SetRef2Text ( as_neweqref )
			END IF						
		END IF			
		
	END IF			
END IF

RETURN 1

end function

private function long of_doesequipmentexist (string as_ref, ref string asa_dupes[]);Long		ll_EqID
Long		ll_FindRtn
String	lsa_Dupes[]
n_ds		lds_EquipmentCache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_Equipmentmanager	lnv_Manager	

ll_EqID = lnv_Manager.of_GetIdFromRef ( as_Ref )

/*OLD DUPE CHECK
IF ll_eqID <= 0 THEN //CHECK THE CACHE

	lnv_Dispatch = THIS.Event ue_GetDispatch ( )
	IF IsValid ( lnv_Dispatch ) THEN
		lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )
		
		IF isValid ( lds_EquipmentCache ) THEN
			
			ll_FindRtn = lds_EquipmentCache.Find ( "eq_ref = '" + as_Ref + "'" , 1 ,lds_EquipmentCache.RowCount ( ) )
			IF ll_FindRtn > 0 THEN
				ll_eqID = lds_EquipmentCache.GetItemNumber ( ll_FindRtn , "eq_id" )
			END IF
						
		END IF
	END IF
	
END IF
*/
/*NEW DUPE CHECK 2/23/07*/
lnv_Dispatch = THIS.Event ue_GetDispatch ( )
IF IsValid ( lnv_Dispatch ) THEN
	lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )
	IF IsValid(lds_EquipmentCache) THEN
		ll_EqId = lnv_Manager.of_ExistsEquipment(as_ref, lds_EquipmentCache, lsa_Dupes) 
	END IF
END IF

asa_Dupes = lsa_Dupes

RETURN ll_EqID
end function

public function integer of_syncwithcache (n_cst_bso_dispatch anv_dispatch, boolean ab_retrieve);Boolean	lb_AllRows 
Boolean	lb_AllColumns 
Int		li_Return = -1

n_cst_EquipmentManager	lnv_Equip
n_cst_bso_Dispatch		lnv_Dispatch
n_ds							lds_EquipmentCache
DataWindow					ldw_Null
DataStore					lds_Null

Int	li_Column
Long	ll_Row
li_Column = THiS.GetColumn ( )
ll_Row = THIS.GetRow ( )

THIS.SetRedraw ( FALSE ) 

lnv_Dispatch = anv_Dispatch
IF isValid ( lnv_dispatch ) THEN
	lds_EquipmentCache = lnv_Dispatch.of_GetEquipmentCache ( )
END IF

IF isValid ( lds_EquipmentCache ) THEN
	
	Long	ll_RowCount 
	Long	ll_I
	
	ll_RowCount = THIS.RowCount ( ) 
		
	FOR ll_i = ll_RowCount TO 1 STEP -1
		IF THIS.Object.eq_id [ ll_i ] > 0 THEN
		ELSE
			THIS.SetItemStatus ( ll_i, 0 , PRIMARY!, NotModified! ) 
		END IF
//		IF Len ( Trim ( String ( THIS.Object.eq_ref [ ll_i ]  ) ) ) > 0 THEN
//		ELSE
//			dw_oe.Rowsdiscard (ll_i, ll_i, PRIMARY! )
//			THIS.SetItemStatus ( ll_i, 0 , PRIMARY!, NotModified! ) 
//		END IF
	NEXT
	
	IF gf_rows_sync(lds_Null, THIS, lds_EquipmentCache, ldw_Null, PRIMARY!, lb_AllRows, lb_AllColumns) = 1 THEN
		li_Return = 1
	END IF
	
END IF

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF isValid ( lnv_Shipment ) AND ab_retrieve THEN
	THIS.Post of_Retrieve ( lnv_Shipment.of_GetID ( ) ) 
END IF

lnv_Equip.of_Sync( lds_EquipmentCache )
// to address issue number 2861 I added the THIS.Setredraw (TRUE)
//and removed a POST from THIS.of_SetFocus ( ... )
THIS.SetRedraw ( TRUE ) 
THIS.of_SetFocus ( li_Column, ll_Row )
RETURN li_Return
end function

event constructor;ib_rmbmenu = FALSE
of_SetDeleteable ( FALSE )


//THIS.SetTransObject ( SQLCA ) 
 THIS.of_GetDatawindowChild ( )

datawindowChild	ldwc_Desc
THIS.GetChild ( "isodescription",  ldwc_Desc ) 
ldwc_Desc.SetTransObject ( SQLCA )
ldwc_Desc.Retrieve ( )

n_cst_Presentation_EquipmentleaseType	lnv_Presentation
lnv_Presentation.of_SetPresentation ( THIS )

n_cst_Presentation_EquipmentSummary	lnv_EQPresentation
lnv_EQPresentation.of_SetPresentation ( THIS )
	
Long		ll_ColumnCount	
Long		ll_i
String	ls_ColumnName
String	ls_ModifyRtn
Boolean	lb_Protect

n_cst_Privileges	lnv_Privs
lb_Protect = NOT  lnv_Privs.of_Hasentryrights( )



ll_ColumnCount = Long ( THIS.Object.DataWindow.Column.Count )

FOR ll_i = 1 TO ll_ColumnCount
	ls_ColumnName = String (  THIS.Describe("#"+ String (ll_i)+ ".Name") )
	IF lb_Protect THEN
		CHOOSE CASE ls_ColumnName 
			CASE "leasefreetimeexpiredate" 
			CASE ELSE
				ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=1" )
				IF ls_ColumnName <> "gooseneck" THEN
					ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=12648447" )	
				END IF
		END CHOOSE
	ELSE
	
		CHOOSE CASE ls_ColumnName 
				
			CASE  "equipmentleasetype_type" , "equipmentleasetype_line" , "eq_axles" , "leasefreetimeexpiredate" , "gooseneck"
				//"intermodalequipment_type" ,
			CASE ELSE
				ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".protect=~"0~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 1, 0 )~"" )
				ls_ModifyRtn = THIS.Modify( ls_ColumnName + ".background.color=~"16777215~tif ( describe ( 'txt_restrict_ind.text' ) = 'T', 12648447, 16777215 )~"" )	
			
		END CHOOSE
		
	END IF
NEXT

RETURN 1

end event

event itemchanged;call super::itemchanged;Long 		ll_Return
Long		ll_LeaseTypeID
Long		ll_EqID
Int		li_ValidateRtn
String	ls_OldRef
String	ls_NewRef
String	ls_OldType

n_cst_msg	lnv_msg
s_parm		lstr_parm
ll_Return = AncestorReturnValue

/* we are not going to filter the lease lines just yet
THIS.Post of_Filter ( )
*/

n_cst_EquipmentManager	lnv_EqManager
n_CsT_beo_Equipment2		lnv_Equipment

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = THIS.Event ue_GetShipment ( )
ib_itemchanged = true
//POSTING
ll_eqID = THIS.object.eq_id [ row ]
IF IsNull ( ll_EqID ) AND dwo.name <> "eq_ref" THEN
	THIS.of_Initializenewequipment( row )
END IF


CHOOSE CASE dwo.name
		
	CASE "equipmentleasetype_line"
		IF Row > 0 THEN		
			
			ll_eqID = THIS.object.eq_id [ row ]
			
			ll_LeaseTypeID = idwc_Lines.GetItemnumber ( idwc_Lines.GetRow ( ), "id" )
			THIS.object.equipmentlease_fkequipmentleasetype[row] =  ll_LeaseTypeID
			THIS.object.equipmentleasetype_type[row] =  idwc_Lines.GetItemString ( idwc_Lines.GetRow ( ), "type" )
			THIS.object.equipmentleasetype_freetimestart [row] =  idwc_Lines.GetItemNumber ( idwc_Lines.GetRow ( ), "freetimestart" )
		
			THIS.Event Post ue_LeaseTypeChanged ( ll_EqID ) 
	
		END IF	
	CASE "eq_ref"
		
		THIS.Post of_EqRefChanged (THIS.Object.eq_ref [ row ] , row , data )


	CASE "intermodalequipment_type"
	
		Boolean	lb_AllowChange = TRUE
		ls_OldType = THIS.object.intermodalequipment_type [ row ]
		ll_eqID = THIS.object.eq_id [ row ]
		
		IF ll_EqID >= lnv_EqManager.cl_permidstart AND NOT isNull ( ls_OldType ) THEN // only check the routing if the equipment has been saved	
			IF lnv_EqManager.of_Isequipmentrouted( ll_EqID , ls_OldType, this.event ue_getdispatch( )) THEN
				lb_AllowChange = FALSE 
				messageBox ( "Equipment Type" , "This piece of equipment is routed and cannot have it's type changed until it has been removed from any routing." )				
			END IF			
		END IF
		
		IF lb_AllowChange THEN
			//DEK 3-30-07 modified the ue_eqtypechanged arguments so that we know what the value was and what it is 
			//becoming so that we can determine the correct ref text and type.
			THIS.Event ue_EqTypeChanged (THIS.Object.intermodalequipment_type[ row ] ,row , data )			
		ELSE
			ll_Return = 0				
			THIS.Post SetItem( row , "intermodalequipment_type" , ls_OldType )			
		END IF
		
	CASE "gooseneck" , "height" , "isodescription"
		THIS.Post of_ModifyISOCode ( row )
		
	
END CHOOSE

string cur_type, rejstr
cur_type = this.object.intermodalequipment_type[1]
Dec Max_length = 60


choose case dwo.name
	case "intermodalequipment_type"
		decimal {1} cur_length, new_length, cur_height, new_height
		integer cur_axles, new_axles
		string cur_air, new_air
		cur_length = this.object.eq_length[1]
		cur_height = this.object.eq_height[1]
		cur_axles = this.object.eq_axles[1]
		cur_air = this.object.eq_air[1]
		
		choose case data
			case "V", "F", "R", "K"  //Added "K" to condition 3.0.06, it was omitted
				choose case cur_length
					case 18 to 57  //Changed lower limit from 20 to 18 in 3.0.06
						//Note : the lower limit of 20 was out of sync with the length processing 
						//which follows later, which put the lower limit at 28
						new_length = cur_length
					case else
						new_length = 48
				end choose
			case "B"
				choose case cur_length
					case 40, 45, 48 , 53 // added 53
						new_length = cur_length
					case else
						new_length = 48
				end choose
			case "H", "C"
				choose case max_length
					case 20, 24, 40, 45, 48, 53
						new_length = max_length
					case is < 40
						new_length = 20
					case else
						new_length = 40
				end choose
			case else
				setnull(new_length)
		end choose
		
		choose case data
			case "H", "C"
				new_height = 96
			case "S"
				choose case cur_height
					case 96, 102
						new_height = cur_height
					case else
						new_height = 96
				end choose
			case "V", "F", "R", "B"
				choose case cur_height
					case 96, 102
						new_height = cur_height
					case else
						new_height = 102
				end choose
			case else
				setnull(new_height)
		end choose
		
		choose case data
			case "C"
				setnull(new_axles)
				setnull(new_air)
			case "T", "S"
				choose case cur_axles
					case 2 to 4
						new_axles = cur_axles
					case else
						new_axles = 3
				end choose
				if isnull(cur_air) then new_air = "F" else new_air = cur_air
				
			case "N"
				new_axles = 2
				if isnull(cur_air) then new_air = "F" else new_air = cur_air
				
			case else
				if isnull(cur_axles) then
					new_axles = 2
				else
					new_axles = cur_axles
				end if
				if isnull(cur_air) then new_air = "F" else new_air = cur_air
				
		end choose
		
		this.object.eq_length[ row ] = new_length
		this.object.eq_height[ row ] = new_height
		THIS.Post SetItem ( row , "eq_axles" , new_axles )
		//this.object.eq_axles[ row ] = new_axles
		this.object.eq_air[ row ] = new_air
		
		
		// Added on 5-14-2007 for issue 2594 <<*>>
		THIS.of_Selectequipment( data,  Row )
		
		
	case "eq_length"
		if len(trim(data)) > 0 then
			rejstr = rejstr
		else
			choose case cur_type
				case "S", "V", "F", "R", "B", "H", "C"
					rejstr = "REQ"
					goto reject
			end choose
		end if
		rejstr = "INVALID"
		choose case cur_type
			case "S"
				choose case dec(data)
					case 8 to 30
						rejstr = rejstr
					case else
						goto reject
				end choose
			case "N"
				choose case dec(data)
					case 4 to 20
						rejstr = rejstr
					case else
						goto reject
				end choose
			case "B"
				choose case dec(data)
					case 40, 45, 48 , 53    // added 53
						rejstr = rejstr
					case else
						goto reject
				end choose
			case "H", "C"
				choose case dec(data)
					case 20, 24, 40, 45, 48, 53
						if dec(data) > max_length then goto reject
					case else
						goto reject
				end choose
			case else
				choose case dec(data)
					case 18 to 57  //Changed lower limit from 28 to 18 in 3.0.06
						rejstr = rejstr
					case else
						goto reject
				end choose
		end choose
	case "eq_height"
		if len(trim(data)) > 0 then
			rejstr = rejstr
		else
			choose case cur_type
				case "S", "V", "F", "R", "B", "H", "C"
					rejstr = "REQ"
					goto reject
			end choose
		end if
		rejstr = "INVALID"
		choose case cur_type
			case "S"
				choose case dec(data)
					case 84 to 102
						rejstr = rejstr
					case else
						goto reject
				end choose
			case "N"
				choose case dec(data)
					case 36 to 72
						rejstr = rejstr
					case else
						goto reject
				end choose
			case "K"
				choose case dec(data)
					case 90 to 110
						rejstr = rejstr
					case else
						goto reject
				end choose
			case else
				choose case dec(data)
					case 96, 102
						rejstr = rejstr
					case else
						goto reject
				end choose
		end choose
end choose

return 0  //<<*>>

 
reject:
choose case rejstr
	case "REQ"
		messagebox("Equipment Information", "This information is required for the "+&
			"current equipment type.", exclamation!)
end choose

RETURN ll_Return

end event

event pfc_addrow;// OVER RIDE ANCESTOR
Long	ll_NewRow	

ll_NewRow = THIS.of_AddRow ( 0 ) 
//ll_NewRow = AncestorReturnValue 

IF ll_NewRow > 0 THEN
	THIS.Event ue_RowAdded ( ll_NewRow ) 
	THIS.ScrollToRow ( ll_NewRow )
	THIS.SetRow ( ll_NewRow ) 
	THIS.SetColumn ( "eq_ref" )	
END IF

RETURN ll_NewRow
	
end event

event pfc_insertrow;// OVER RIDE ANCESTOR
Long	ll_NewRow	

//ll_NewRow = AncestorReturnValue 
ll_NewRow = THIS.of_AddRow ( THIS.GetRow ( ) ) 
IF ll_NewRow > 0 THEN
	THIS.Event ue_RowAdded ( ll_NewRow ) 
	THIS.ScrollToRow ( ll_NewRow )
	THIS.SetRow ( ll_NewRow ) 
	THIS.SetColumn ( "eq_ref" )	
	
END IF




RETURN ll_NewRow
	
end event

event rbuttondown;call super::rbuttondown;String	ls_PopRtn
String	lsa_parm_labels[]
Any		laa_parm_values[]

IF row > 0 THEN

	CHOOSE CASE dwo.name
			
		CASE "frontreload" , "backreload"
			
			THIS.Event ue_ShowReloadmenu ( row ) 
			
		CASE "eq_ref"
			IF THIS.object.eq_id [ row ] > 0 THEN
			//IF Len ( Trim ( THIS.GetItemString ( row , String ( dwo.name ) ) ) ) > 0 THEN
				THIS.Event ue_ShowEquipmentMenu ( row ) 
			END IF
		
		CASE "p_have" , "p_need" 
			
			THIS.Event ue_ShowEquipmentPostingMenu ( row ) 
			
	END CHOOSE
END IF

RETURN AncestorReturnValue 

end event

event itemerror;call super::itemerror;String	ls_ColumnType
Date		ld_Test
Time		lt_Test
Long		ll_Return 

n_cst_String	lnv_String

ll_Return = AncestorReturnValue

ll_Return = 1

IF Upper ( String ( dwo.type ) )  = "COLUMN" THEN
	ls_ColumnType = dwo.colType
	
	CHOOSE CASE UPPER ( ls_ColumnType )
			
		CASE  "DATE" 
			ld_test = lnv_string.of_SpecialDate(data)
			if not isnull(ld_test) then
				this.setitem(row, String ( dwo.name ), ld_test)
				ll_Return = 3
			end if
			
		CASE "TIME"
			lt_Test = lnv_string.of_SpecialTime(data)
			if not isnull(lt_Test) then
				this.setitem(row, String ( dwo.name ), lt_Test)
				ll_Return = 3
			end if			
	END CHOOSE
END IF



RETURN ll_Return
end event

on u_dw_oebasics.create
end on

on u_dw_oebasics.destroy
end on

event itemfocuschanged;call super::itemfocuschanged;CHOOSE CASE dwo.Name
	CASE "gooseneck" , "height", "isodescription"
		Send(Handle(THIS), 276, 3, 0) 		
	CASE ELSE
		Send(Handle(THIS), 276, 2, 0) 		
END CHOOSE


end event

event editchanged;call super::editchanged;THIS.of_AddNewIfNeeded ( )
end event

event losefocus;call super::losefocus;//DEK 5-1-07  Added the Ib_itemchanged check so that the syncwithcache call
//is only called if the itemchanged event fired.  The reason for this is because
//it is an expensive operation between the retrieval and the rowsync.
IF THIS.AcceptText ( ) = 1 AND ib_itemChanged THEN
	THIS.of_SyncWithCache ( THIS.Event ue_GetDispatch ( ) )	//dek 5-1-07 this needs to retrieve
	ib_itemChanged = false
END IF
//scroll back over
Send(Handle(THIS), 276, 2, 0) 	
end event

