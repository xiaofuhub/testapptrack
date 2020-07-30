$PBExportHeader$w_eq_base.srw
$PBExportComments$Ancestor of w_eq_newout and w_eq_info.
forward
global type w_eq_base from window
end type
type dw_basics from datawindow within w_eq_base
end type
type tab_1 from u_tab_equipment within w_eq_base
end type
type tab_1 from u_tab_equipment within w_eq_base
end type
end forward

global type w_eq_base from window
integer x = 832
integer y = 360
integer width = 2213
integer height = 2008
boolean titlebar = true
string title = "Equipment Information"
boolean controlmenu = true
boolean minbox = true
long backcolor = 12632256
event ue_getlinkedequipment ( )
event ue_clearsearch ( )
dw_basics dw_basics
tab_1 tab_1
end type
global w_eq_base w_eq_base

type variables
protected:
decimal {1} max_length = 60
Long	il_ShipmentNumber
Boolean	ib_FromShipment

n_cst_Beo_shipment	inv_shipment		//added 2-1-07 gets set on open event
n_cst_BSO_dispatch	inv_dispatch		//when the user elects to change the text fields, and this window
													//was opened from a context where the shipment it was linked to wasn't open
													//i need to save the changes on the dispatch manager I created when I got a shipment beo.
Boolean	ib_createdShipmentBeo
end variables

forward prototypes
protected function integer wf_save_if_needed (string as_context)
protected function long wf_subject ()
protected function boolean wf_allowsave ()
public function n_cst_beo_shipment wf_getshipmentbeo ()
public function integer of_determineref1text (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype)
public function integer wf_changeshipreftexts (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype, long al_eqid)
public function integer of_determineref2text (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype, long al_row)
end prototypes

event ue_clearsearch();tab_1.tabpage_lease.of_SetNewShipment(il_shipmentnumber)
end event

protected function integer wf_save_if_needed (string as_context);//Return Values: 	-1 : Do not proceed,  1 : Proceed
//
//Note:  This doesn't indicate success or failure.  It indicates whether the user would
//object to the calling script disposing of the current edit info.  If the save goes
//through, or if there were no changes, the value is always 1, but if the save fails, 
//the value can be -1 or 1, depending on whether the user has approved abandoning the 
//changes.  A conflict that prevents the save attempt will always return -1.

boolean lb_new_eq
Boolean	lb_Fail

long ll_new_id
datastore lds_sync
string ls_message_header, ls_message
n_cst_dws lnv_cst_dws
n_cst_Numerical	lnv_Numerical
n_cst_EquipmentManager lnv_EquipmentMgr

if as_context = "CLOSE_WINDOW!" then
	this.setfocus()
	this.show()
end if

if dw_basics.accepttext() = -1 then return -1
if tab_1.tabpage_lease.dw_1.accepttext() = -1 then return -1

//Check whether save is needed

if isnull(wf_subject()) then return 1

IF NOT THIS.wf_allowSave ( ) THEN
	RETURN 1
END IF


//if dw_basics.rowcount() > 0 then
//	if isnull(dw_basics.object.eq_type[1]) then return 1
//end if
//
if abs(dw_basics.modifiedcount()) + abs(tab_1.of_Getmodifiedcount()) = 0 then return 1


//Check whether user wants save

ls_message = "Save changes to current equipment?"

choose case as_context
case "SAVE_REQUEST!"
	ls_message_header = "Save Changes"
case "CLOSE_WINDOW!"
	ls_message_header = this.title
	ls_message = "Save changes before closing?"
case "CHANGE_SELECTION!"
	ls_message_header = "Change Selection"
	//ls_message is ok as is
case "NEW!"
	ls_message_header = "Add New Equipment"
	//ls_message is ok as is
end choose


n_cst_LicenseManager	lnv_LicenseManager

IF tab_1.tabpage_lease.dw_1.RowCount ( ) = 0 THEN

	IF Left ( lnv_LicenseManager.of_GetLicensedCompany ( ), 3 ) = "S&J" THEN
	
		CHOOSE CASE gnv_App.of_GetUserId ( )
	
		CASE "SAM", "BARBARA", "MAL", "PTADMIN"
			//ids are ok.  proceed.
	
		CASE ELSE
			MessageBox ( ls_message_header, "You are not authorized to save changes to "+&
				"company equipment.~n~nYour changes will not be saved." )
			RETURN 1
	
		END CHOOSE
	
	END IF

END IF

//the following commented code didn't make sense, code has been added to the itemchanged event 
//for the reference number to stop duplicate equipment


/* This whole block of code was commented out however it was allowing multiple pieces of 
	equipment to be created with the same type and Ref... BAD. */

//IF tab_1.tabpage_lease.dw_1.RowCount ( ) > 0 AND ( Not ib_FromShipment ) THEN
//	String		ls_Where
//	String		ls_Text
//	Int			li_Rtn	= 1
//	Any			la_Value
//	Boolean		lb_UnLinked
//	DataStore					lds_Results
//	n_cst_EquipmentManager	lnv_Manager
//	n_cst_Settings		lnv_Settings
//	
//	IF lnv_Settings.of_GetSetting ( 82 , la_Value ) = 1 THEN
//		IF STRING ( la_Value ) = "YES!" THEN
//			lb_Unlinked = TRUE
//		END IF
//	END IF
//	
//	
//	IF NOT lb_UnLinked AND il_ShipmentNumber <= 0 THEN
//		RETURN -1
//	END IF
//		
//	ls_Text = TRIM (dw_basics.object.eq_ref[1] ) 
//
//	IF Len ( ls_Text ) > 0 THEN
//		ls_Where = "WHERE eq_Status = ~~'K~~' AND eq_ref = ~~'" + ls_Text + "~~' AND eq_id <> " + String ( dw_basics.object.eq_id[1] ) 
//		lnv_Manager.of_Retrieve (  lds_Results ,ls_Where )
//		
//		CHOOSE CASE lds_Results.RowCount ( )
//				
//			CASE 0 // EQUIPMENT DNE
//				
//				// proceed
//				
//			CASE ELSE
//				IF MessageBox ( "Leased Equipment" , "Active equipment already exists with the reference number specified. Close without saving changes?" ,QUESTION! , YESNO! , 2 ) = 1 THEN
//					Return 1
//				ELSE
//					li_Rtn = -1
//				END IF
//					
//		END CHOOSE
//	END IF
//	IF li_Rtn = -1 THEN
//		RETURN li_Rtn 
//	END IF
//END IF

//
//IF dw_Outside.RowCount ( ) > 0 THEN
//	String		ls_Where
//	String		ls_Text
//	Int			li_Rtn	= 1
//	Any			la_Value
//	Boolean		lb_UnLinked
//	DataStore					lds_Results
//	n_cst_EquipmentManager	lnv_Manager
//	n_cst_Settings		lnv_Settings
//	
//	IF lnv_Settings.of_GetSetting ( 82 , la_Value ) = 1 THEN
//		IF STRING ( la_Value ) = "YES!" THEN
//			lb_Unlinked = TRUE
//		END IF
//	END IF
//	
//	
//	IF NOT lb_UnLinked AND il_ShipmentNumber <= 0 THEN
//		RETURN -1
//	END IF
//		
//	ls_Text = TRIM (dw_basics.object.eq_ref[1] ) 
//	
//	IF Len ( ls_Text ) > 0 THEN
//		ls_Where = "WHERE eq_Status = ~~'K~~' AND eq_ref = ~~'" + ls_Text + "~~'"
//		lnv_Manager.of_Retrieve (  lds_Results ,ls_Where )
//		
//		CHOOSE CASE lds_Results.RowCount ( )
//				
//			CASE 0 // EQUIPMENT DNE
//				
//				// proceed
//				
//			CASE 1
//				
//				li_Rtn = -1
//				
//				IF IsNull ( lds_Results.object.equipmentLease_Shipment [ 1 ] ) THEN
//					IF il_ShipmentNumber > 0 THEN
//								
//						IF MessageBox ( "Specified Equipment" , "A piece of equipment already exists " + & 
//							+"with the reference number you sepcifed. However the equipment is not currently" + &
//							" associated to a shipment.~r~n~r~nClick OK to use this equipment and to link it " + &
//							"to this shipment.  OR~r~nClick Cancel to stop the processing.", INFORMATION! , OKCANCEL! , 1 ) = 1 THEN
//							// use the equipment		
//								Long	ll_EquipmentID
//								ll_EquipmentID = dw_outside.object.eq_id [ 1 ]
//																						
//								IF ll_EquipmentID > 0 THEN
//								
//									UPDATE "outside_equip"  
//									SET "shipment" = :il_ShipmentNumber  
//									WHERE "outside_equip"."oe_id" = :ll_EquipmentID ;
//									
//									IF sqlca.sqlcode <> 0 then
//										rollback;
//										li_Rtn = -1
//									ELSE
//										COMMIT;
//									END IF
//								END IF
//							END IF
//					ELSE
//						 MessageBox ( "Specified Equipment" ,"A piece of equipment already exists " + & 
//							+"with the reference number you sepcifed. However the equipment is not currently" + &
//							" associated to a shipment. Please go to the shipment intended for the equipment and create the equipment there." )
//					END IF
//					
//				ELSE // The equipment is linked to a shipment
//					IF MessageBox ( "Specified Equipment" , "A piece of equipment already exists " + & 
//						+"with the reference number you sepcifed. In addition the equipment is " + &
//						+"linked to shipment " + String ( lds_Results.object.equipmentLease_Shipment [ 1 ] ) + &
//						+" and can not be created again. Do you want to cancel and view this shipment now?" , QUESTION! , YESNO! , 2 ) = 1 THEN
//						// display the shipment
//						n_cst_shipmentManager	lnv_ShipmentManager
//						
//						lnv_ShipmentManager.of_OpenShipment ( lds_Results.object.equipmentLease_Shipment [ 1 ] )
//						li_Rtn = -1
//					ELSE
//						// stop the processing
//						li_rtn = -1
//						
//					END IF
//					
//				END IF
//				
//			CASE is >= 1 // MULTIPLES FOUND   /// I WILL NEED TO FURTHER THE PROCESSING HERE
//				MessageBox( "Specified Equipment" , "Multiple pieces of equipment exist with the specified number. Processing will stop." )
//				li_Rtn = -1
//				
//		END CHOOSE 
//		
//	END IF
//	
//	IF li_Rtn = -1 THEN
//		RETURN li_Rtn 
//	END IF
//END IF
//

//
choose case as_context
case "CLOSE_WINDOW!", "CHANGE_SELECTION!", "NEW!"
	choose case messagebox(ls_message_header, ls_message, question!, yesnocancel!)
	case 2
		return 1
	case 3
		return -1
	end choose
end choose

//Perform save

if lnv_Numerical.of_IsNullOrNotPos(len(trim(dw_basics.object.eq_ref[1]))) then
	messagebox("Save Changes", "Cannot save equipment information without a Reference "+&
		"Number.~n~nSave request cancelled.", exclamation!)
	return -1
end if

IF IsNull ( dw_basics.object.eq_Type[1] ) THEN
	MessageBox ( "Save Changes" , "Cannot save equipment information without a equipment "+&
		"type specified.~n~nSave request cancelled.", exclamation!)
	return -1
END IF

if dw_basics.object.eq_id[1] = 0 then
	lb_new_eq = true
	gnv_app.of_getnextid( "equipment", ll_new_id , true )
//	select max(eq_id) into :ll_new_id from equipment ;
//	if sqlca.sqlcode <> 0 then goto rollitback	
//	if lnv_Numerical.of_IsNullOrNotPos(ll_new_id) then ll_new_id = 10000000
//	ll_new_id ++
	dw_basics.object.eq_id[1] = ll_new_id
	
	tab_1.tabpage_description.of_SetNewEquipmentid( ll_new_id)
	tab_1.tabpage_dimensions.of_SetNewEquipmentid( ll_new_id)
	tab_1.tabpage_extended.of_SetNewEquipmentid( ll_new_id)
	tab_1.tabpage_extras.of_SetNewEquipmentid( ll_new_id)
	tab_1.tabpage_registration.of_SetNewEquipmentid( ll_new_id)
	
//This test for row count was commented out and causing a row to be inserted into the outside equipment table
//nwl 06/05/2004
	if tab_1.tabpage_lease.dw_1.rowcount() > 0 then 
		tab_1.tabpage_lease.of_Setnewequipmentid( ll_new_id )
	end if
	
end if

if dw_basics.update(false, false) = -1 then goto rollitback
//DEK 5-21-07 when we create a beo out of thin air, its because this window wasn't opened from
//a shipment context so in order for the changes to happen we have to save them on 
//the dispatch manager we got the shipment from.
IF ib_createdshipmentbeo and isValid( inv_dispatch ) THEN
	inv_dispatch.event pt_save( )

END IF
if tab_1.tabpage_lease.dw_1.update(false, false) = -1 then goto rollitback

IF tab_1.tabpage_lease.dw_1.RowCount ( ) > 0 THEN
	// I was getting a "can't convert int to time error" error so I had to do this
	Date	ld_Date
	Time	lt_Time
	Long	ll_ID
	ll_ID	= tab_1.tabpage_lease.dw_1.object.oe_id [ 1 ]
	
	IF tab_1.tabpage_lease.dw_1.GetItemStatus ( 1, "terminationdate", PRIMARY! ) = DataModified!  THEN	
		ld_Date = tab_1.tabpage_lease.dw_1.object.terminationDate [ 1 ]
		 UPDATE "outside_equip"  
		  SET "terminationdate" = :ld_Date  
		WHERE "outside_equip"."oe_id" = :ll_ID ;
		IF sqlca.sqlcode <> 0 then lb_Fail = TRUE
	END IF
	
	
	
	IF tab_1.tabpage_lease.dw_1.GetItemStatus ( 1, "terminationtime", PRIMARY! ) = DataModified! AND NOT lb_Fail THEN		
		lt_time = tab_1.tabpage_lease.dw_1.object.terminationtime [ 1 ]
		 UPDATE "outside_equip"  
		  SET "terminationtime" = :lt_time  
		WHERE "outside_equip"."oe_id" = :ll_ID ;
		IF sqlca.sqlcode <> 0 then lb_Fail = TRUE
	END IF
	
	IF tab_1.tabpage_lease.dw_1.GetItemStatus ( 1, "originationdate", PRIMARY! ) = DataModified! AND NOT lb_Fail THEN
		ld_Date = tab_1.tabpage_lease.dw_1.object.originationdate [ 1 ]
		 UPDATE "outside_equip"  
		  SET "originationdate" = :ld_Date 
		WHERE "outside_equip"."oe_id" = :ll_ID ;
		IF sqlca.sqlcode <> 0 then lb_Fail = TRUE
	END IF
	
	IF tab_1.tabpage_lease.dw_1.GetItemStatus ( 1, "originationtime", PRIMARY! ) = DataModified! AND NOT lb_Fail THEN
		lt_Time = tab_1.tabpage_lease.dw_1.object.originationTime[ 1 ]
		 UPDATE "outside_equip"  
		  SET "originationtime" = :lt_Time  
		WHERE "outside_equip"."oe_id" = :ll_ID ;
		IF sqlca.sqlcode <> 0 then lb_Fail = TRUE
	END IF

	IF NOT lb_Fail THEN
		commit ;	
	END IF
END IF

//tell tabs to save
if tab_1.of_update(TRUE,TRUE) = 1 then
	commit;
else
	goto rollitback
end if


if sqlca.sqlcode <> 0 then goto rollitback

dw_basics.resetupdate()
tab_1.tabpage_lease.dw_1.resetupdate()

if lnv_EquipmentMgr.of_Get_Retrieved_Equip( ) then

	//Since this doesn't deal with the current event info, we don't want to sync in
	//a row for existing equipment that hasn't been retrieved

	lds_sync = create datastore
	lds_sync.dataobject = "d_equip_list"
	
	lds_sync.insertrow(0)
	
	lnv_cst_dws.of_copy_by_column(dw_basics, 1, lds_sync, 1)
	
	if tab_1.tabpage_lease.dw_1.rowcount() > 0 then
		lnv_cst_dws.of_copy_by_column(tab_1.tabpage_lease.dw_1, 1, lds_sync, 1)
	end if
	
	lnv_EquipmentMgr.of_Sync ( lds_Sync, TRUE, FALSE )
	//false for all_data preserves the current event values already in the cache row.

	destroy lds_sync

end if

return 1

rollitback:
rollback ;

if lb_new_eq then
	dw_basics.object.eq_id[1] = 0
	if tab_1.tabpage_lease.dw_1.rowcount() > 0 then tab_1.tabpage_lease.dw_1.object.oe_id[1] = 0
end if

choose case as_context
case "SAVE_REQUEST!"
	messagebox("Save Changes", "Could not save changes to database.~n~nPlease retry.", &
		exclamation!)
	return -1
case "CLOSE_WINDOW!"
	if messagebox("Save Changes", "Could not save changes to database.  Press OK "+&
		"to abandon changes and close window, or Cancel to return to window and "+&
		"preserve changes for now.", exclamation!, okcancel!) = 2 then return -1
case "CHANGE_SELECTION!"
	if messagebox("Save Changes", "Could not save changes to database.  Press OK "+&
		"to abandon changes and select another piece of equipment, or Cancel to return to "+&
		"the current equipment and preserve changes for now.", exclamation!, okcancel!) = 2 &
		then return -1
case "NEW!"
	if messagebox("Save Changes", "Could not save changes to database.  Press OK "+&
		"to abandon changes and add a new piece of equipment, or Cancel to return to "+&
		"the current equipment and preserve changes for now.", exclamation!, okcancel!) = 2 &
		then return -1
end choose

return 1
end function

protected function long wf_subject ();long ll_id

if dw_basics.rowcount() > 0 then
	ll_id = dw_basics.object.eq_id[1]
else
	setnull(ll_id)
end if

return ll_id
end function

protected function boolean wf_allowsave ();Boolean	lb_Return
Long		ll_Shipment
n_cst_Privileges	lnv_privs
String	ls_privFunction


lb_Return = lnv_privs.of_Hasentryrights( )

IF tab_1.tabpage_lease.dw_1.RowCount ( ) > 0 THEN
	ll_Shipment =  tab_1.tabpage_lease.dw_1.object.Shipment[1]
END IF



IF ll_Shipment > 0 THEN
	
	n_Cst_bso_Dispatch	lnv_Disp
	lnv_Disp = CREATE n_cst_bso_Dispatch
	n_cst_beo_Shipment	lnv_Shipment
	lnv_Shipment = CREATE n_cst_beo_Shipment
	IF lnv_Disp.of_Retrieveshipment( ll_Shipment ) = 1 THEN
		lnv_Shipment.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) ) 
		lnv_Shipment.of_SetSourceID ( ll_Shipment )
		
		//Modified 2-9-07 to use a different priv if the shipment is billed
		IF lnv_Shipment.of_isBilled() THEN
			ls_privFunction = appeon_constant.cs_ModifyBilledShip
		ELSE
			ls_privFunction = "ModifyShipment"
		END IF
		/////////////////////
		IF gnv_app.of_Getprivsmanager( ).of_GetUserpermissionfromfn( ls_privFunction , lnv_Shipment ) <> appeon_constant.ci_True THEN
			lb_Return = FALSE
		END IF		
	
	ELSE
		MessageBox ( "Modify Equipment" , "Your privileges to modify this equipment could not be verrified." )
		lb_Return = FALSE
	END IF
END IF

DESTROY ( lnv_Shipment )
DESTROY ( lnv_Disp )

RETURN lb_Return
end function

public function n_cst_beo_shipment wf_getshipmentbeo ();/*Created By Dan 2-2-07
	Returns a shipment beo, if its not valid then it
	creates one...It is possible that one was passed in
	when the window is opened.  If it can't create the shipment
	beo, the item returned is invalid
*/


n_Cst_bso_dispatch 	lnv_dispatch
n_cst_Beo_shipment	lnv_shipment
n_cst_Beo_shipment	lnva_shipments[]
n_Cst_beo_equipment2	lnv_equipment
n_ds	lds_eqCache, lds_shipCache

Long	ll_eqID, ll_shipID

lnv_dispatch = inv_dispatch

IF isValid( inv_shipment ) THEN
	lnv_shipment = inv_shipment
ELSE
	ll_eqID = dw_basics.getItemNumber( 1, "eq_id")
	
	IF not isValid( lnv_dispatch ) THEN
		inv_dispatch = create n_cst_bso_dispatch		//need to hang on to this so I can save it
		lnv_dispatch = inv_dispatch
	END IF
	lnv_dispatch.of_retrieveequipment( {ll_eqId} )
	lds_eqCache = lnv_dispatch.of_getEquipmentcache( )
	
	lnv_equipment = create n_cst_beo_equipment2
	
	lnv_equipment.of_SetSource( lds_eqCache )
	lnv_equipment.of_setSourceid( ll_eqId )
	lnv_equipment.of_setallowfilterset( true )

	IF lnv_equipment.of_hassource( ) THEN
			ll_shipID = lnv_equipment.of_GetShipment( )
	END IF
	
	IF ll_shipID > 0 THEN
		lnv_shipment = create n_cst_beo_shipment
		
		lnv_dispatch.of_GetShipments( {ll_shipID}, lnva_shipments)
		
		IF upperBound( lnva_shipments ) > 0 THEN
			lnv_shipment = lnva_shipments[1]
			lnv_shipment.of_setallowfilterset( true )
			inv_shipment = lnv_shipment
			ib_createdshipmentbeo = true
		END IF
	END IF
END IF

inv_dispatch = lnv_dispatch
DESTROY lnv_equipment

RETURN lnv_shipment
	
end function

public function integer of_determineref1text (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype);n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = this.wf_GetShipmentBEO( )

String	ls_EquipmentType
String	ls_EquipmentRef
String	ls_Ref1Text

LOng		ll_EquipCount
Int		li_RefType
Int		li_SetType 
Int		li_originalEqType




//Messagebox("wf_changeShipRefTexts", this.classname())
////we need to determine what changed. IT was either the ref or the type.
//IF as_originaleqref = as_currenteqref THEN
//	//we know the type changed
//	ls_equipmentType = as_currenteqtype
//ELSE
//	ls_equipmentType = as_originaleqtype
//END IF
//

// REF 1**************************************************


// modified to only set the ref value if no label has been specified.
IF IsValid ( lnv_Shipment ) AND Len ( as_Currenteqref ) > 0 THEN

	ls_EquipmentRef =  lnv_Shipment.of_getref1text( ) 

	li_RefType = lnv_Shipment.of_getRef1Type ( ) 
	ls_Ref1Text = lnv_Shipment.of_GetRef1text ( ) 
	
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
END IF		


RETURN 1
end function

public function integer wf_changeshipreftexts (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype, long al_eqid);n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = this.wf_GetShipmentBEO( )
u_dw		ldw_equipment
String	ls_EquipmentType
String	ls_EquipmentRef
String	ls_Ref1Text
String	ls_REf2Text
LOng		ll_EquipCount
Long		ll_row
Long		ll_CurrentRow
Int		li_RefType
Int		li_SetType 
Int		li_originalEqType


n_cst_beo_equipment2 lnva_equipment[]


//Messagebox("wf_changeShipRefTexts", this.classname())
//we need to determine what changed. IT was either the ref or the type.
IF as_originaleqref = as_currenteqref THEN
	//we know the type changed
	ls_equipmentType = as_currenteqtype
ELSE
	ls_equipmentType = as_originaleqtype
END IF


ll_equipCount = this.tab_1.of_getequipmentdw( ldw_equipment )
// REF 1**************************************************


// modified to only set the ref value if no label has been specified.
IF IsValid ( lnv_Shipment ) AND Len ( as_Currenteqref ) > 0 THEN
	lnv_shipment.of_GetEquipmentlist( lnva_Equipment )
	ls_EquipmentRef =  lnv_Shipment.of_getref1text( ) 
	
	FOR ll_row = 1 TO upperBOund(lnva_equipment)
		IF lnva_equipment[ll_row].of_getId( ) = al_eqId THEN
			//ll_row is the index that this would show up in on the window
			ll_currentRow = ll_row
			exit
		END IF
	NEXT
	
	//this means its a new piece of equipment
	IF ll_currentROw = 0 THEN
		ll_currentRow = upperBOund(lnva_equipment)+ 1
	END IF
	IF upperBound( lnva_equipment ) > ll_EquipCount THEN
		//MESsagebox("changeShipRefTexts","CHANGE")
		
		this.of_determineref1text(  as_originaleqref, as_currenteqref, as_originaleqtype, as_currenteqtype )
		this.of_determineref2text( as_originalEqRef, as_currenteqref, as_originaleqtype, as_currenteqtype, ll_currentrow )
	ELSE
		this.of_determineref1text(  as_originaleqref, as_currenteqref, as_originaleqtype, as_currenteqtype )
		this.of_determineref2text( as_originalEqRef, as_currenteqref, as_originaleqtype, as_currenteqtype, ll_currentrow )
	END IF
	FOR ll_row = 1 TO upperBOund(lnva_equipment)
		DESTROY lnva_equipment[ll_row]
	NEXT
	
END IF		


RETURN 1
end function

public function integer of_determineref2text (string as_originaleqref, string as_currenteqref, string as_originaleqtype, string as_currenteqtype, long al_row);n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = this.wf_GetShipmentBEO( )

String	ls_EquipmentType
String	ls_EquipmentRef
String	ls_Ref2Text

LOng		ll_EquipCount
Int		li_RefType
Int		li_SetType 
Int		li_originalEqType

IF isValid( lnv_shipment ) THEN
	IF  /*al_Row > 1 AND */lnv_shipment.of_getref1text( ) <> as_currentEqRef THEN
	//IF al_Row <= THIS.RowCount () AND al_Row > 1 THEN
		// REF 2 ********************************************************
		ls_EquipmentRef =  lnv_Shipment.of_getref2text( ) //THIS.object.eq_ref [ 1 ]
		
		// modified to only set the ref value if no label has been specified.
		
		IF IsValid ( lnv_Shipment ) AND Len ( as_Currenteqref ) > 0 THEN
			
			
			li_RefType = lnv_Shipment.of_getRef2Type ( ) 
			ls_Ref2Text = lnv_Shipment.of_GetRef2text ( ) 
			
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
			
			IF (li_RefType = li_originalEqType AND as_originaleqref = ls_Ref2Text) OR li_Reftype = 0 OR isNull ( li_RefType ) OR isNull ( ls_Ref2Text) OR (li_originaleqType > 0 AND len( ls_Ref2Text ) = 0 ) &
				OR  (li_setType = li_refType AND ls_Ref2Text = "" ) THEN	//DEK 4-9-07 added condition so that if the ref field contains a type, and you specify equipment with that type, it will populate the ref field.
		
				
				IF li_SetType > 0 THEN
					lnv_Shipment.of_SetRef2Type( li_SetType )
					lnv_Shipment.of_SetRef2Text ( as_currenteqref )
				END IF	
			END IF
		
		END IF	
	
	END IF
END IF

RETURN 1
end function

on w_eq_base.create
this.dw_basics=create dw_basics
this.tab_1=create tab_1
this.Control[]={this.dw_basics,&
this.tab_1}
end on

on w_eq_base.destroy
destroy(this.dw_basics)
destroy(this.tab_1)
end on

event close;IF isValid( inv_shipment ) AND ib_createdshipmentbeo THEN
	DESTROY inv_shipment

END IF

DESTROY inv_dispatch
end event

type dw_basics from datawindow within w_eq_base
event processenter pbm_dwnprocessenter
integer x = 27
integer y = 20
integer width = 1847
integer height = 116
integer taborder = 10
string dataobject = "d_eq_basics"
boolean border = false
end type

event processenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

event itemchanged;string cur_type, rejstr, cur_eqref
Long	ll_EqId, ll_DupCount, i
String	ls_type
String	ls_Dupes
String	lsa_Dupes[]
cur_type = this.object.eq_type[1]
cur_eqref = this.object.eq_ref[1]

String	ls_oldRef
String	ls_privFunction
N_cst_privsManager lnv_privmanager
n_cst_beo_shipment 	lnv_shipment
choose case dwo.name
		
	case "eq_ref"

		string	ls_where
		String	ls_CDerror
		DataStore					lds_Results
		n_cst_EquipmentManager	lnv_Manager
		
		
		//Validate Check digit on containers
		IF UPPER(Mid(data, 4, 1)) = "U" THEN //4th letter 'U' denotes container
			IF lnv_Manager.of_ValidateCheckDigit(data, ls_CDerror) <> 1 THEN
				MessageBox ("Equipment Validation" , ls_CDerror )
				Return 1 //****      mid code return  ********//
			END IF
		END IF
		
		//check for duplicate equipment
		IF Len ( data ) > 0 THEN
			ls_Where = "WHERE eq_Status = ~~'K~~' AND eq_ref = ~~'" + data + "~~' AND eq_id <> " + String ( dw_basics.object.eq_id[1] ) + " AND eq_type = ~~'" + cur_type + "~~'"
			lnv_Manager.of_Retrieve (  lds_Results ,ls_Where )
			
			CHOOSE CASE lds_Results.RowCount ( )
					
				CASE 0 // EQUIPMENT DNE
					
					// proceed
					
				CASE ELSE
					MessageBox ( "Equipment" , "Active equipment already exists with the reference number specified.")
					
					//****      mid code return  ********//
					return 2
						
			END CHOOSE

			
			
		END IF
		
		//ADDED BY DAN 1-31-07
		
		lnv_privmanager = gnv_app.of_getprivsmanager( )
		lnv_shipment = parent.wf_getshipmentbeo( )
		IF isValid( lnv_shipment ) THEN
			IF lnv_shipment.of_isBilled() THEN
				ls_privFunction = lnv_privManager.cs_modifybilledship
			ELSE
				ls_privFunction = lnv_privManager.cs_modifyshipment
			END IF
	
			IF row > 0 AND lnv_privmanager.of_getuserpermissionfromfn( ls_privFunction, lnv_shipment) = lnv_privmanager.ci_true THEN
				ll_eqID = this.getITemNumber( row, "eq_id")
				ls_oldRef = this.getItemString( row, "eq_Ref")
				ls_type = this.getITemString( row, "eq_type" )
				parent.wf_changeshipreftexts( ls_oldREF, data, ls_type, ls_type, ll_eqID )
				//parent.wf_changeshipreftexts( ll_eqId, ls_oldRef, data )
			END IF
		END IF
		////////////////////////
		

	case "eq_type"
		
		
		//let tab know of change
		tab_1.enabled=true
		tab_1.event ue_typechanged(data)
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
		this.object.eq_length[1] = new_length
		this.object.eq_height[1] = new_height
		this.object.eq_axles[1] = new_axles
		this.object.eq_air[1] = new_air
		
		
		//ADDED BY DAN 5-21-07

		lnv_privmanager = gnv_app.of_getprivsmanager( )
		lnv_shipment = parent.wf_getshipmentbeo( )
		IF isValid( lnv_shipment ) THEN
			IF lnv_shipment.of_isBilled() THEN
				ls_privFunction = lnv_privManager.cs_modifybilledship
			ELSE
				ls_privFunction = lnv_privManager.cs_modifyshipment
			END IF
	
			IF row > 0 AND lnv_privmanager.of_getuserpermissionfromfn( ls_privFunction, lnv_shipment) = lnv_privmanager.ci_true THEN
				ll_eqID = this.getITemNumber( row, "eq_id")
				ls_oldRef = this.getItemString( row, "eq_Ref")
				ls_type = this.getITemString( row, "eq_type" )
				parent.wf_changeshipreftexts( ls_oldREF, ls_oldRef, ls_type, data, ll_eqID )
				//parent.wf_changeshipreftexts( ll_eqId, ls_oldRef, data )
			END IF
		END IF
		////////////////////////
		
		
		
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

return 0

reject:
choose case rejstr
	case "REQ"
		messagebox("Equipment Information", "This information is required for the "+&
			"current equipment type.", exclamation!)
end choose

return 1

//reject:
//choose case rejstr
//	case "REQ"
//		rejstr = "This information is required for the current equipment type."
//	case "INVALID"
//		rejstr = "The value you have entered is invalid."
//end choose
//rejstr += "~n~nThe previous value will be restored."
//
//messagebox("Equipment Information", rejstr)
//
//return 2
end event

event constructor;//this.object.eq_length.edit.format = "'#'~tif(truncate(eq_length, 0) = eq_length, '#', '#.#')"
//
//this.object.eq_height.edit.format = "'#'~tif(truncate(eq_height, 0) = eq_height, '#', '#.#')"

This.SetTransObject ( SQLCA )
end event

event itemerror;this.selecttext(1, 999)
this.setfocus()
beep(1)
return 1

//messagebox("Equipment Information", "The value you have entered is invalid.~n~n" +&
//	"It will be replaced by the previous value.")
//
//return 3
end event

type tab_1 from u_tab_equipment within w_eq_base
integer x = 23
integer y = 152
integer width = 2121
integer height = 1732
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
end type

event ue_datachanged;call super::ue_datachanged;string	as_value
long		al_value
decimal	ac_value

choose case as_what
		
	case 'air'
		as_value = string(aa_value)
		dw_basics.object.eq_air[1] = as_value
		
	case 'axle'
		al_value = long(aa_value)
		dw_basics.object.eq_axles[1] = al_value
		
	case 'notes'
		as_value = string(aa_value)
		dw_basics.object.notes[1] = as_value
		
	case 'length'
		ac_value = dec(aa_value)
		dw_basics.object.eq_length[1] = ac_value
		
	case 'width' //height
		ac_value = dec(aa_value)
		dw_basics.object.eq_height[1] = ac_value
		
end choose
end event

