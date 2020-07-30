$PBExportHeader$w_duplicatewithequipment.srw
forward
global type w_duplicatewithequipment from w_response
end type
type st_nonroutedcopies from statictext within w_duplicatewithequipment
end type
type em_copies from u_em within w_duplicatewithequipment
end type
type st_1 from statictext within w_duplicatewithequipment
end type
type cbx_equipment from checkbox within w_duplicatewithequipment
end type
type cb_1 from u_cbok within w_duplicatewithequipment
end type
type cb_2 from u_cbcancel within w_duplicatewithequipment
end type
type cbx_copyref from checkbox within w_duplicatewithequipment
end type
type tab_1 from u_tab_duplication within w_duplicatewithequipment
end type
type tab_1 from u_tab_duplication within w_duplicatewithequipment
end type
type sle_date from u_sle_date within w_duplicatewithequipment
end type
type st_2 from statictext within w_duplicatewithequipment
end type
type st_duplicate from statictext within w_duplicatewithequipment
end type
type gb_1 from groupbox within w_duplicatewithequipment
end type
type cb_add from commandbutton within w_duplicatewithequipment
end type
type sle_temp from singlelineedit within w_duplicatewithequipment
end type
type ddlb_template from u_ddlb within w_duplicatewithequipment
end type
end forward

shared variables
s_Parm	sstra_Options[]
Boolean	sb_NonRoutedOnly = FALSE
end variables

global type w_duplicatewithequipment from w_response
integer x = 581
integer y = 600
integer width = 2565
integer height = 1764
string title = "Duplicate Shipment"
st_nonroutedcopies st_nonroutedcopies
em_copies em_copies
st_1 st_1
cbx_equipment cbx_equipment
cb_1 cb_1
cb_2 cb_2
cbx_copyref cbx_copyref
tab_1 tab_1
sle_date sle_date
st_2 st_2
st_duplicate st_duplicate
gb_1 gb_1
cb_add cb_add
sle_temp sle_temp
ddlb_template ddlb_template
end type
global w_duplicatewithequipment w_duplicatewithequipment

type variables
Long	il_ShipmentID
Long	il_ParentShipmentID
Long	ila_ShipmentsToCopy[]
String	is_EqRef
String	is_Type
Int	ii_Copies
n_cst_msg	inv_Msg

Boolean	ib_Options
Boolean	ib_Equipment
Boolean   ib_Template
Boolean	ib_MultipleShipments
Boolean	ib_Split

u_dw	idw_Equipment
String	is_ValueList

boolean	ib_CopySeal
boolean	ib_AllowViewing = TRUE

n_ds ids_Temp

end variables

forward prototypes
public function integer wf_initializeequipmentlist ()
public function integer wf_displaynewshipments (long ala_ids[])
public function integer wf_checkbox (string as_whatsclicked)
private function integer wf_concatinatemsgobjects (readonly n_cst_msg anv_Msg1, readonly n_cst_msg anv_Msg2, ref n_cst_msg anv_resultMsg)
private function integer wf_setshipmentid ()
private function integer wf_syncdatawindowwithcount ()
private function integer wf_prevalidateinput ()
public function integer wf_getsites (ref n_cst_msg anv_Msg)
private function integer wf_setmultipleshipmentids (long ala_shipmentids[])
public function integer wf_validateselectedstatus ()
private function integer wf_initializewindow (n_cst_msg anv_msg)
private function integer wf_initializetemplates ()
private function integer wf_initializesplits ()
private function integer wf_initializemultipleshipments ()
private function long wf_getshipmentsource (ref long ala_ShipmentIds[])
private function integer wf_duplicateshipments (ref long ala_newids[])
private function Date wf_getdate ()
private function boolean wf_allowduplication ()
end prototypes

public function integer wf_initializeequipmentlist ();Long	i
Long	ll_NewRow
Long	ll_LeaseType
String	ls_Find
String	ls_Type
DataStore	lds_FindResults
n_cst_equipmentManager	lnv_EquipmentManager

ll_NewRow = idw_equipment.InsertRow ( 0 )

if Len ( is_Type ) = 0 THEN
	is_Type = 'C'
END IF

idw_equipment.SetItem ( ll_NewRow , "equipment_type" , is_Type )
idw_equipment.SetItem ( ll_NewRow , "equipment_eq_height" , 96)
idw_equipment.SetItem ( ll_NewRow , "equipment_eq_length" , 40 )

IF Len( TRIM ( is_eqRef ) ) > 0 THEN
	
	ls_Find = "WHERE eq_ref = '" + is_eqRef + "' and eq_status = 'K'"
	if len(is_Type) > 0 then 
		ls_Find += " and eq_type = '" + is_Type +"'"
	END IF
	lnv_EquipmentManager.of_Retrieve (lds_FindResults ,ls_Find )
	
	IF lds_FindResults.RowCount ( ) = 1 THEN	
		ll_LeaseType = lds_FindResults.Object.equipmentlease_fkequipmentleasetype[1]
		
		idw_equipment.SetItem ( ll_NewRow , "outside_equip_fkequipmentleasetype" , ll_LeaseType )
		idw_equipment.SetItem ( ll_NewRow , "equipment_type" , is_Type )
		idw_equipment.SetItem ( ll_NewRow , "template" , il_shipmentid )
		idw_equipment.SetItem ( ll_NewRow , "equipment_eq_height" , lds_FindResults.Object.eq_height[1] )
		idw_equipment.SetItem ( ll_NewRow , "equipment_eq_length" , lds_FindResults.Object.eq_length[1] )
		idw_equipment.SetItem ( ll_NewRow , "equipment_eq_Air" , lds_FindResults.Object.eq_air[1] )
		idw_equipment.SetItem ( ll_NewRow , "equipment_eq_axles" , lds_FindResults.Object.eq_axles[1] )
		
		
	END IF
	
END IF
//ii_Copies = Integer ( em_copies.Text )

FOR i = 1 TO ii_Copies - 1
	idw_equipment.RowsCopy ( 1, 1, Primary!, idw_equipment, idw_equipment.RowCount ( ), Primary! )
NEXT

RETURN 1


	
	
end function

public function integer wf_displaynewshipments (long ala_ids[]);
n_cst_msg	lnv_msg
S_Parm		lstr_Parm
w_Search		lw_Search
n_cst_Sql	lnv_Sql
n_cst_shipmentManager	lnv_ShipmentManager
IF  UpperBound ( ala_IDs[] ) = 1 THEN
	lnv_ShipmentManager.of_OpenShipment ( ala_IDs [ 1 ] )
ELSEIF UpperBound ( ala_IDS ) > 0 THEN
	lstr_Parm.is_Label = "ShipmentWhereClause"
	lstr_Parm.ia_Value = "WHERE ds_id " + lnv_Sql.of_MakeInClause ( ala_IDs )
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	OpenSheetWithParm ( lw_Search, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
END IF

RETURN 1
end function

public function integer wf_checkbox (string as_whatsclicked);Int	li_ActiveTab
CHOOSE CASE as_WhatsClicked 
	CASE "OPTIONS" 
		
		IF cbx_copyref.Checked THEN
			ib_Options = TRUE
			tab_1.Tabpage_Options.Visible = TRUE
			li_ActiveTab = 2
		ELSE
			tab_1.event ue_initializeOptions ( )
			IF ib_MultipleShipments THEN
				li_ActiveTab = 3
			ELSE
				li_ActiveTab = 1
			END IF
			
			ib_Options = FALSE
			tab_1.Tabpage_Options.Visible = FALSE
		END IF
	CASE "EQUIPMENT"

		IF cbx_equipment.Checked THEN
			
			IF Long ( em_copies.Text ) <> 0 THEN
				SetPointer ( Hourglass! )	
				wf_InitializeEquipmentList ( )
				idw_equipment.SetFocus ( )
				idw_equipment.SetRow ( 1 )
				idw_equipment.SetColumn ( 2 )
				
				ib_Equipment = TRUE
				wf_SyncDataWindowWithCount ( )
				tab_1.Tabpage_Equipment.Visible = TRUE
				li_ActiveTab = 1
				
			ELSE
				MessageBox ( "Equipment Information" , "Please indicate the number of copies you would like to create first.")
				cbx_equipment.Checked = FALSE
				ib_Equipment = FALSE
				tab_1.Tabpage_Equipment.Visible = FALSE
			END IF
									
		ELSE
			
			IF ib_MultipleShipments THEN
				li_ActiveTab = 3
			ELSE
				li_ActiveTab = 2	
			END IF
				
			idw_equipment.Reset ( )
			ib_Equipment = FALSE	
			tab_1.Tabpage_Equipment.Visible = FALSE
								
		END IF
		
END CHOOSE

Tab_1.SelectedTab = li_ActiveTab 

IF ib_Equipment OR ib_Options OR ib_MultipleShipments THEN
	THIS.Height = 1764
ELSE
	THIS.Height = 580
END IF

RETURN 1
end function

private function integer wf_concatinatemsgobjects (readonly n_cst_msg anv_Msg1, readonly n_cst_msg anv_Msg2, ref n_cst_msg anv_resultMsg);Int	i
Int	li_Count
S_Parm 	lstr_Parm	

li_Count = anv_Msg1.of_Get_Count ( )


FOR i = 1 TO li_Count
	
	anv_Msg1.of_Get_Parm ( i , lstr_Parm )
	anv_Msg2.of_Add_Parm ( lstr_Parm )
	
NEXT

anv_resultMsg = anv_msg2

RETURN 1
end function

private function integer wf_setshipmentid ();Int	li_Return = -1
String	ls_Find
Long		ll_FindRtn

n_cst_string lnv_string

IF ib_Template THEN
	
	ls_Find = ( ddlb_template.Text )
	IF Len ( ls_Find ) > 0 THEN
		
		If Pos(ls_Find, "'") > 0 Then
			ls_Find = lnv_string.of_GlobalReplace (ls_Find, "'", "~~'")
		End If	

		ll_FindRtn = ids_Temp.Find ( "ds_ref1_Text = '" + ls_Find + "'" , 1, 9999 )
		IF ll_FindRtn > 0 THEN
			il_ShipmentID = ids_Temp.GetItemNumber ( ll_FindRtn , "ds_id" )
			li_Return = 1
		ELSE
			MessageBox ("Duplicate Shipment" , "The template you have indicated does not exist.")
		END IF
		
	ELSE
		MessageBox ("Duplicate Shipment" , "Please select a template.")
	END IF
ELSEIF ib_MultipleShipments THEN
	li_Return = 1
END IF


RETURN li_Return 
end function

private function integer wf_syncdatawindowwithcount ();Long	ll_RowCount
Long	i
ii_Copies = Long ( em_copies.Text )
IF ib_Equipment THEN

	ll_RowCount = idw_equipment.RowCount ( )
	
	IF ll_RowCount = 0 THEN
		wf_InitializeEquipmentList () 
		ll_RowCount = idw_equipment.RowCount ( )
	END IF
	
	IF ii_Copies > ll_RowCount THEN
		FOR i = ll_RowCount TO ii_Copies - 1
			idw_equipment.SetRedraw ( FALSE )
			idw_equipment.RowsCopy ( idw_equipment.RowCount ( ) , idw_equipment.RowCount ( ), Primary!, idw_equipment,  idw_equipment.RowCount ( ) + 1, PRIMARY! ) 	
			idw_equipment.object.equipment_eq_ref [ idw_equipment.RowCount ( ) ] = ""
			idw_equipment.SetRedraw ( TRUE ) 
		NEXT
	ELSEIF ii_Copies < ll_RowCount THEN
		FOR i = ll_RowCount TO ii_Copies + 1 STEP -1
			idw_equipment.DeleteRow ( idw_equipment.RowCount( ) )
		NEXT
	END IF
END IF

IF idw_Equipment.RowCount ( ) = 1 THEN
		
	
ELSEIF  idw_Equipment.RowCount ( ) > 1 THEN
	CHOOSE CASE idw_Equipment.Object.equipment_Type[1]
		CASE 'C'
			is_ValueList =	"CNTN~tC/"
		CASE ELSE
			is_ValueList =	"RBOX~tB/CHAS~tH/"
	END CHOOSE
END IF

IF Len ( is_ValueList ) > 0 THEN
	idw_Equipment.Modify ( 	"equipment_type.Values = '" + is_ValueList + "'" )
END IF

RETURN 1

end function

private function integer wf_prevalidateinput ();Boolean	lb_ValidateEquipment
integer 	li_Return = 1
String	ls_WhereClause
String	ls_Type
Long		lla_DupRows[]

String	ls_OriginalSelect
String	ls_SQL
String	ls_ModString
Long		j
Long		lla_Ids[]
Long		ll_ArrayCount
Long		ll_RetrieveCount
Long		lla_RefRows[]
Long		i
String	ls_find
Long		ll_StartRow
Long		ll_FoundRow
Long		lla_InputDups[]
String	ls_CDerror
String	lsa_Dupes[]
		

n_cst_Sql	lnv_SQL
w_Search 	lw_Search

n_cst_msg	lnv_OptionsMsg	, lnv_Msg
S_Parm		lstr_Parm


DataStore	lds_Search
DataStore	lds_Ship

n_cst_Equipmentmanager	lnv_EquipmentManager

lb_ValidateEquipment = ib_Equipment

ll_StartRow = 2

For i = 1 To idw_equipment.RowCount ( ) 
	idw_Equipment.SelectRow ( i , FALSE )
NEXT

IF lb_ValidateEquipment THEN
	
	lds_Ship = CREATE DataStore
	lds_Ship.dataobject = "d_shipmentlist"
	lds_Ship.SetTransObject ( SQLCA )
	
	Long 	ll_RowCount
	
	String	ls_Eq
	
	ll_RowCount = idw_Equipment.RowCount ( ) 
	
	
	FOR i = 1 TO ll_RowCount 
		ls_Eq = TRIM ( idw_Equipment.getItemString ( i , "equipment_eq_ref" ) )
		IF Len ( ls_eq ) = 0 OR IsNull ( ls_Eq ) THEN
			MessageBox ( "Equipment Reference" , "Please specify a reference value for each piece of equipment." ) 
			li_Return = -1
			EXIT
		END IF
		
		//Validate Check digit on containers
		IF Upper(Mid(ls_Eq, 4, 1)) = "U" THEN //4th letter 'U' denotes container
			IF lnv_EquipmentManager.of_ValidateCheckDigit(ls_Eq, ls_CDerror) <> 1 THEN
				MessageBox ( "Equipment Reference" , ls_CDerror )
				li_Return = -1
				EXIT
			END IF
		END IF
		
		ls_Type = idw_Equipment.getItemString ( i , "equipment_Type" )
		/*OLD DUPE CHECK
		ls_WhereClause = "WHERE eq_ref = '" + ls_Eq + "' and eq_status = 'K'"
		if len(ls_Type) > 0 then 
			ls_WhereClause += " and eq_type = '" + ls_Type +"'"
		END IF
		
		lnv_EquipmentManager.of_Retrieve ( lds_Search , ls_WhereClause )
		
		IF lds_Search.RowCount ( ) > 0 THEN // equipment exists
			lla_DupRows [ upperBound ( lla_DupRows ) + 1 ] = i
		END IF
		*/
		
		/*NEW DUPE CHECK - 2/23/07*/
		CHOOSE CASE lnv_EquipmentManager.of_ExistsEquipment(ls_eq, lsa_Dupes) 
			CASE IS > 0 //Found one dupe
				lla_DupRows [ upperBound ( lla_DupRows ) + 1 ] = i
			CASE -2 //Mulitiple dupes
				lla_DupRows [ upperBound ( lla_DupRows ) + 1 ] = i
		END CHOOSE
		
		// now check the ref fields
		ls_OriginalSelect = lds_Ship.Describe("DataWindow.Table.Select")
		ls_SQL = " where disp_ship.ds_ref1_text = ~~'" + ls_eq + "~~'"

		ls_SQL += " and disp_ship.ds_status <> ~~'" + gc_dispatch.cs_ShipmentStatus_Billed + "~~'" 

		ls_ModString = "DataWindow.Table.Select='" + ls_OriginalSelect + ls_sql + "'"
		lds_Ship.Modify(ls_ModString)
		ll_RetrieveCount = lds_Ship.Retrieve()
		IF lds_Ship.RowCount ( ) > 0 THEN // equipment exists
			lla_RefRows [ upperBound ( lla_RefRows ) + 1 ] = i
		END IF
		FOR j = 1 to ll_RetrieveCount
			ll_ArrayCount ++
			lla_Ids[ll_ArrayCount] = lds_Ship.object.ds_id[j]
		NEXT
	
	
		// now check the list given for dups
		IF i < ll_RowCount THEN
			ls_Find = "equipment_eq_ref = '" + ls_Eq + "'"
			ll_FoundRow = idw_Equipment.Find ( ls_Find , ll_StartRow , 99999 )
			ll_StartRow ++ 
			IF ll_FoundRow > 0 THEN
				lla_InputDups [ UpperBound ( lla_InputDups ) + 1 ] = ll_FoundRow
			END IF
		END IF
		
	NEXT
	
	IF ib_Options THEN	
		
		lnv_OptionsMsg = tab_1.tabPage_Options.of_GetOptionsMsg ( )
		
		IF lnv_OptionsMsg.of_Get_Parm ( gc_Dispatch.cs_ShipDupOpt_NonRouted , lstr_Parm ) <> 0 THEN
			IF lstr_Parm.ia_Value THEN
				IF MessageBox ( "Non-Routed copies" , "By specifying the duplicated shipments as non-routed the equipment specified will not be created." , INFORMATION! , OKCANCEL!, 2 ) = 2 THEN
					li_Return = -1
				END IF
			END IF
		END IF
	END IF
	
END IF // validate equip


IF UpperBound( lla_DupRows ) > 0 AND li_Return = 1 THEN
	FOR i = 1 TO UpperBound ( lla_DupRows )
		idw_Equipment.SelectRow ( lla_DupRows [ i ] , TRUE )
	NEXT
	MessageBox("Duplicate Equipment", "The equipment in the selected rows already exists and will have to be removed before processing can continue." )
	li_Return = -1
END IF


//if any returned then ask to display search list
IF upperbound ( lla_Ids ) > 0 AND li_Return = 1 THEN
	FOR i = 1 TO UpperBound ( lla_RefRows )
		idw_Equipment.SelectRow ( lla_refRows [ i ] , TRUE )
	NEXT

	IF MessageBox ( "Primary Reference Cross Check", "The reference numbers in the selected rows have been used in other shipments. "+&
		"Do you want to continue anyway?" , QUESTION! , YESNO! , 2 ) = 2 THEN
		
		li_Return = -1
		IF MessageBox ( "Primary Reference Cross Check" , "Do you want to see a list of the shipments?" , QUESTION! , YESNO! , 2 ) = 1 THEN

			ls_WhereClause = " WHERE ds_id " + lnv_Sql.of_MakeInClause ( lla_Ids )
			lstr_Parm.is_Label = "ShipmentWhereClause"
			lstr_Parm.ia_Value = ls_WhereClause
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			OpenSheetWithParm ( lw_Search, lnv_Msg, gnv_App.of_GetFrame ( ), 0, Layered! )
			
		END IF
		
	END IF
	
END IF

// show the results of dups given in the list
IF upperbound ( lla_InputDups ) > 0 AND li_Return = 1 THEN
	FOR i = 1 TO UpperBound ( lla_InputDups )
		idw_Equipment.SelectRow ( lla_InputDups [ i ] , TRUE )
	NEXT
	MessageBox ( "Duplicate Equipment" , "The equipment listed in the selected rows are duplicates within the list just specified. Duplicates will need to be removed before processing can continue.")
	li_Return = -1
END IF
	
IF li_Return = 1 THEN
	IF THIS.wf_ValidateSelectedStatus ( ) <> 1 THEN
		li_Return = -1
	END IF
END IF
	
DESTROY ( lds_Ship )

RETURN li_Return 







end function

public function integer wf_getsites (ref n_cst_msg anv_Msg);Boolean	lb_TryAgain
String	ls_Where
Long		ll_TerminationSite
Long		ll_OriginSite

n_cst_EquipmentManager	lnv_EquipmentManager
DataStore	lds_Results
S_Parm		lstr_Parm

// First we will look for an exact match
ls_Where = "WHERE equipmentLease_shipment = ~~'" + String ( il_ShipmentID ) + "'~~ AND eq_Status = ~~'K~~' AND eq_ref = ~~'" + is_eqref + "~~'"
lnv_EquipmentManager.of_Retrieve ( lds_Results , ls_Where ) 

IF lds_Results.RowCount ( ) = 1 THEN // we got a match
	ll_TerminationSite = lds_Results.object.equipmentLease_TerminationSite [ 1 ]
	ll_OriginSite = lds_Results.object.equipmentLease_OriginationSite [ 1 ]
ELSE
	lb_TryAgain = TRUE
END IF

IF lb_TryAgain THEN // IF we didn't get a match, get a little more general
	ls_Where = "WHERE eq_Status = ~~'K~~' AND eq_ref = ~~'" + is_eqref + "~~'"
	lnv_EquipmentManager.of_Retrieve ( lds_Results , ls_Where ) 
	
	CHOOSE CASE lds_Results.RowCount ( )
			
		CASE 0	// no matches. Don't set any sites and the processing will use pattern matching
					// by default
		
		CASE 1 // we got a match, so use it
			ll_TerminationSite = lds_Results.object.equipmentLease_TerminationSite [ 1 ]
			ll_OriginSite = lds_Results.object.equipmentLease_OriginationSite [ 1 ]
					
		CASE is > 1 //NOW WHAT DO WE DO?
			


	END CHOOSE
END IF

IF ll_TerminationSite > 0 THEN
	lstr_Parm.is_label = "TERMINATIONSITE"
	lstr_Parm.ia_Value = ll_TerminationSite
	anv_Msg.of_Add_Parm ( lstr_Parm )
END IF

IF ll_OriginSite > 0 THEN
	lstr_Parm.is_Label = "ORIGINSITE"
	lstr_Parm.ia_Value = ll_OriginSite
	anv_Msg.of_Add_Parm ( lstr_Parm )
END IF


RETURN 1





end function

private function integer wf_setmultipleshipmentids (long ala_shipmentids[]);ila_ShipmentsToCopy = ala_ShipmentIDs[]
ib_MultipleShipments = TRUE

cbx_equipment.Enabled = FALSE
tab_1.of_RetrieveShipments ( ila_ShipmentsToCopy )

THIS.Height = 1764

RETURN 1
end function

public function integer wf_validateselectedstatus ();Int		li_ShipmentCount
Int		i
Long		lla_ShipmentIds[]
String	ls_status
String	ls_Error
Int		li_Return = 1
Long		ll_ValidateKey


ll_ValidateKey = 550
IF IsDate ( sle_Date.Text ) THEN
	ll_ValidateKey = 2598
END IF


n_cst_beo_Shipment	lnva_Shipments[]
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Dispatch = CREATE n_cst_bso_Dispatch


ls_Status = tab_1.of_GetSelectedShipmentStatus ( )
li_ShipmentCount = tab_1.tabpage_multiple.of_GEtShipments ( lnva_Shipments )

li_ShipmentCount = tab_1.of_GetShipmentIds ( lla_ShipmentIds )

lnv_Dispatch.of_RetrieveShipments ( lla_ShipmentIDs )


FOR i = 1 TO li_ShipmentCount
	lnva_Shipments[i] = CREATE n_cst_beo_shipment
	lnva_Shipments[i].of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
	lnva_Shipments[i].of_SetSourceID ( lla_ShipmentIDs [ i ] )
	lnva_Shipments[i].of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
	lnva_Shipments[i].of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
	
	// see of_ValidateStatus for explanation of 550
	IF lnva_Shipments[i].of_ValidateStatus ( ls_Status , ls_Error , ll_ValidateKey ) <> 1 THEN
		MessageBox ( "New Shipment Status" , "Cannot approve status change because the following problems have "+&
															"been detected in shipment " + String ( lla_ShipmentIDs [ i ]) +":~n~n" + ls_Error + "~nRequest Cancelled." )
		li_Return = -1
		EXIT
	END IF
	
NEXT

Destroy ( lnv_Dispatch )

li_ShipmentCount = i
FOR i = 1 TO li_ShipmentCount
	DESTROY ( lnva_Shipments[i] )
NEXT

RETURN li_Return 
end function

private function integer wf_initializewindow (n_cst_msg anv_msg);// RDT 7-17-03 added Code for parentId  
n_cst_msg	lnv_msg
S_Parm		lstr_Parm

lnv_msg =   anv_msg

IF lnv_Msg.of_Get_Parm ( "SHIPMENTID" , lstr_Parm ) <> 0 THEN
	il_ShipmentID = lstr_Parm.ia_Value
elseif lnv_Msg.of_Get_Parm ( "SHIPMENT" , lstr_Parm ) <> 0 THEN
	il_ShipmentID = lstr_Parm.ia_Value
ELSEIF lnv_Msg.of_Get_Parm ( "MULTIPLESHIPMENTS" , lstr_Parm ) <> 0 THEN
	THIS.wf_SetMultipleShipmentids ( lstr_Parm.ia_Value )
END IF

IF lnv_Msg.of_Get_Parm ( "EQREF" , lstr_Parm ) <> 0 THEN
	is_EqRef = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "TYPE" , lstr_Parm ) <> 0 THEN
	is_Type = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "SEAL" , lstr_Parm ) <> 0 THEN
	ib_CopySeal = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "TEMPLATE" , lstr_Parm ) <> 0 THEN
	ib_Template = TRUE
END IF

IF lnv_Msg.of_Get_Parm ( "ALLOWVIEWING" , lstr_Parm ) <> 0 THEN
	ib_AllowViewing = lstr_Parm.ia_Value
END IF

IF lnv_Msg.of_Get_Parm ( "SPLITOPTIONS" , lstr_Parm ) <> 0 THEN
	ib_Split = TRUE
END IF

// RDT 7-17-03 -Start 
IF lnv_Msg.of_Get_Parm ( "PARENTSHIPMENTID" , lstr_Parm ) <> 0 THEN
	il_ParentShipmentID = lstr_Parm.ia_Value
Else
	SetNull( il_ParentShipmentID )
END IF
// RDT 7-17-03 -End

Tab_1.event ue_initializeOptions ( )


RETURN 1
end function

private function integer wf_initializetemplates ();

IF ib_Template THEN
	Long	i
	st_duplicate.Text = "Tem&plate"
	st_duplicate.Visible = TRUE
	ddlb_template.Visible = TRUE
	
	ids_Temp = CREATE n_ds
	ids_Temp.DataObject = "d_templateList"
	ids_Temp.SetTransObject ( SQLCA )
	ids_Temp.Retrieve ( )
	
	For i = 1 TO ids_Temp.RowCount ( ) 
		ddlb_template.AddItem ( ids_Temp.GetItemString ( i , "ds_Ref1_Text" ) )
	NEXT
	
	
	tab_1.TabPage_Options.of_SelectTemplateOptions ( )
	cbx_copyref.Checked = TRUE
	THIS.POST wf_CheckBox ( "OPTIONS" )
END IF

RETURN  1

end function

private function integer wf_initializesplits ();IF ib_Split THEN
	tab_1.TabPage_Options.of_SelectSplitOptions ( )
	cbx_copyref.Checked = TRUE
	THIS.POST wf_CheckBox ( "OPTIONS" )
END IF

RETURN 1
end function

private function integer wf_initializemultipleshipments ();tab_1.of_MultipleShipments ( ib_MultipleShipments )
IF ib_MultipleShipments THEN
	Tab_1.SelectedTab = 3
END IF
RETURN 1
end function

private function long wf_getshipmentsource (ref long ala_ShipmentIds[]);Long	ll_SourceCount
Long	lla_ShipmentIDs[]

IF ib_MultipleShipments THEN
	//ls_NewStatus = tab_1.of_GetSelectedShipmentStatus ( )
	ll_SourceCount = tab_1.of_GetShipmentIDs ( lla_ShipmentIds )
ELSE
	ll_SourceCount = 1
	lla_ShipmentIds[1] = il_ShipmentID
END IF

ala_ShipmentIds[] = lla_ShipmentIDS

RETURN ll_SourceCount
end function

private function integer wf_duplicateshipments (ref long ala_newids[]);// RDT 7-17-03 Added code for ParentShipmentID
Int	li_Return = 1

Long	ll_SourceCount
Long	lla_ShipmentIds[]
Long	lla_Ids[]
Long	ll_SourceIndex
String	ls_NewStatus
Int 	i, j

n_cst_msg	lnv_Msg , &
				lnv_OptionsMsg, &
				lnv_AllMsgs
S_Parm		lstr_Parm
n_cst_ShipmentManager	lnv_ShipmentManager

ll_SourceCount = THIS.wf_GetShipmentSource ( lla_ShipmentIds )


FOR ll_SourceIndex = 1 TO ll_SourceCount
	
 
	FOR i = 1 TO ii_Copies 
		
		lnv_Msg.of_Reset ( )
		
		IF ib_Equipment THEN
			IF i <= idw_Equipment.RowCount ( ) THEN
				tab_1.tabpage_equipment.dw_1.of_GetMsgObjectForRow ( i , lnv_Msg )
			END IF
		END IF
		
		IF NOT ib_MultipleShipments THEN
			THIS.wf_GetSites ( lnv_Msg )
		END IF			
	
		lstr_parm.is_Label = "SEAL"
		lstr_Parm.ia_Value = ib_CopySeal
		lnv_Msg.of_Add_Parm ( lstr_parm )	
	
		lstr_parm.is_Label = "DATE"
		lstr_Parm.ia_Value = THIS.wf_GetDate ( )
		lnv_Msg.of_Add_Parm ( lstr_parm )	
	
		lstr_parm.is_Label = "COUNT"
		lstr_Parm.ia_Value = 1
		lnv_Msg.of_Add_Parm ( lstr_parm )
		
		lstr_parm.is_Label = "TEMPLATE"
		lstr_Parm.ia_Value = ib_Template
		lnv_Msg.of_Add_Parm ( lstr_parm )
		
		lstr_parm.is_Label = "SHIPMENTID"
		lstr_Parm.ia_Value = lla_ShipmentIds [ ll_SourceIndex ]
		lnv_Msg.of_Add_Parm ( lstr_parm )
		
		// RDT 7-17-03 - Start
		lstr_parm.is_Label = "PARENTSHIPMENTID"
		lstr_Parm.ia_Value = il_ParentShipmentId
		lnv_Msg.of_Add_Parm ( lstr_parm )
		// RDT 7-17-03 - End
			
		IF ib_Options THEN	
			lnv_OptionsMsg = tab_1.tabPage_Options.of_GetOptionsMsg ( )
		ELSE
			lnv_OptionsMsg = tab_1.tabPage_Options.of_GetDefaultOptionsMsg ( )
		END IF	
		
		THIS.wf_ConcatinateMsgObjects ( lnv_Msg , lnv_OptionsMsg, lnv_AllMsgs )
		
		IF lnv_ShipmentManager.of_DuplicateShipment ( lnv_AllMsgs ) = -1 THEN
			MessageBox ( "Duplicate Shipment" , "An error occurred while attempting to duplicate the requested shipment. Processing stopped." )
			li_Return = -1			
			EXIT			
		END IF
				
		IF lnv_AllMsgs.of_Get_Parm ( "NEWIDS" , lstr_Parm ) <> 0 THEN
			lla_IDS = lstr_Parm.ia_Value
			
			FOR j = 1 TO UpperBound ( lla_IDs ) 
				ala_newids [ upperBound ( ala_newids[] ) + 1 ] = lla_IDs [ j ]
			NEXT
		
		END IF
		
	NEXT
NEXT

RETURN li_Return 
end function

private function Date wf_getdate ();String	ls_Date
Date		ld_Date

ls_Date =  Trim ( sle_Date.Text )
IF Len ( ls_Date ) = 0 THEN
	SetNull ( ls_Date )
END IF
ld_Date = DATE ( ls_Date )
ld_Date = Date ( DateTime ( ld_Date ) ) 

RETURN ld_Date
end function

private function boolean wf_allowduplication ();//MFS 5/17/06 -- Added check for 'modify shipment' privilege

Boolean	lb_Return = TRUE
Long		lla_ShipmentIds[]
Int		li_ShipmentCount	
Int		i

Long		ll_UserDivisionDefault
Long		ll_ShipType
String	ls_AdvancedPrivs
String	ls_ShipType
String	ls_Msg
String	ls_privFunction

n_cst_bso_Dispatch	lnv_Disp
n_cst_beo_Company		lnv_Co
n_cst_beo_Shipment	lnv_Shipment

n_cst_privsmanager	 lnv_PrivsManager

lnv_Disp = CREATE n_cst_bso_Dispatch
lnv_Shipment = CREATE n_cst_beo_Shipment

lnv_PrivsManager = gnv_App.of_GetPrivsManager()

IF ib_multipleshipments THEN
	lla_ShipmentIds[] = ila_shipmentstocopy[]
ELSE 
	IF il_ShipmentID > 0 THEN
		lla_ShipmentIDs[1] = il_shipmentid
	END IF
END IF


li_ShipmentCount = UpperBound ( lla_ShipmentIDs )

IF li_ShipmentCount > 0 THEN
	lnv_Disp.of_RetrieveShipments( lla_ShipmentIDS )
END IF

lnv_SHipment.of_SetSource ( lnv_Disp.of_GetShipmentCache  ( ) )

FOR i = 1 TO li_ShipmentCount
	lnv_Shipment.of_SetSourceID ( lla_SHipmentIDS[i]  )
	lnv_Shipment.of_GetBillToCompany ( lnv_Co, TRUE ) // true = check cache
	
	IF isValid ( lnv_Co ) THEN
		IF lnv_Co.of_GetStatus () = 'H' THEN
			lb_Return = FALSE
			ls_Msg = "Shipments with a Bill To on hold cannot be duplicated. Request Canceled."
			EXIT 
		END IF
	END IF
	
	//Get user priv to modify this ship type
	ll_ShipType = lnv_Shipment.of_GetType()
// DEK 5-29-07 Undid change from 2-7-07*************The ability to duplicate shipments should not look at the status of the original shipment - just check to see if the person is authorized to modify/create shipment - so yes related to modify shipment not modify billed shipment - for duplicating. -J. Howes 

	//Modified 2-7-07 Dan added a conditional check for the permission to use if the shipment is billed
	//IF lnv_shipment.of_isbilled( ) THEN
	//	ls_privFunction = n_cst_privsmanager.cs_ModifyBilledShip
	//ELSE
	ls_privFunction = "ModifyShipment"
	//END IF
	//////////////////////////////
	IF lnv_PrivsManager.of_GetUserPermissionFromFn(ls_privFunction, ll_ShipType) <> 1 THEN
		lb_Return = FALSE
		ls_ShipType = lnv_Shipment.of_GetShipmentType()
		ls_Msg = "Insufficient privileges to duplicate/modify shipment "+ String(lla_ShipmentIds[i]) + &
					" of type " + ls_ShipType + "."
		EXIT
	END IF
	
NEXT

Destroy 	lnv_Disp
DESTROY	lnv_Co
DESTROY	lnv_Shipment

IF Not lb_Return THEN
	MEssageBox ( "Duplicate Shipment" , ls_Msg )
END IF

RETURN lb_Return


end function

event pfc_cancel;call super::pfc_cancel;CLOSE ( THIS )
end event

on w_duplicatewithequipment.create
int iCurrent
call super::create
this.st_nonroutedcopies=create st_nonroutedcopies
this.em_copies=create em_copies
this.st_1=create st_1
this.cbx_equipment=create cbx_equipment
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_copyref=create cbx_copyref
this.tab_1=create tab_1
this.sle_date=create sle_date
this.st_2=create st_2
this.st_duplicate=create st_duplicate
this.gb_1=create gb_1
this.cb_add=create cb_add
this.sle_temp=create sle_temp
this.ddlb_template=create ddlb_template
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nonroutedcopies
this.Control[iCurrent+2]=this.em_copies
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_equipment
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cbx_copyref
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.sle_date
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_duplicate
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cb_add
this.Control[iCurrent+14]=this.sle_temp
this.Control[iCurrent+15]=this.ddlb_template
end on

on w_duplicatewithequipment.destroy
call super::destroy
destroy(this.st_nonroutedcopies)
destroy(this.em_copies)
destroy(this.st_1)
destroy(this.cbx_equipment)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_copyref)
destroy(this.tab_1)
destroy(this.sle_date)
destroy(this.st_2)
destroy(this.st_duplicate)
destroy(this.gb_1)
destroy(this.cb_add)
destroy(this.sle_temp)
destroy(this.ddlb_template)
end on

event pfc_default;Long	lla_NewIds []
Int	li_DupRtn 

n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm	

n_cst_ShipmentManager	lnv_ShipmentManager

SetPointer ( HOURGLASS! )

IF ii_Copies = 0 THEN
	MessageBox ( "Duplication" , "Please enter a number greater than zero." )
	em_copies.SetFocus ( )
	RETURN 
END IF

IF idw_equipment.AcceptText ( ) <> 1 THEN
	RETURN 												//////// EARLY RETURN 
END IF

IF THIS.wf_PreValidateInput ( ) <> 1 THEN
	RETURN 												//////// EARLY RETURN 
END IF

IF il_ShipmentID = 0 OR ib_Template THEN
	 IF THIS.wf_SetShipmentID ( ) <> 1 THEN
		RETURN 											//////// EARLY RETURN 
	END IF
END IF

IF NOT THIS.wf_AllowDuplication ( ) THEN
	RETURN
END IF

IF ii_Copies > 9 THEN 
	IF messageBox ( "Duplicate Shipment" , "Are you sure you want to create " + String ( ii_Copies ) + " copies? " , QUESTION! ,YESNO! , 2 ) = 2 THEN
		RETURN 											//////// EARLY RETURN 
	END IF
END IF	
	
li_DupRtn = THIS.wf_DuplicateShipments ( lla_NewIds )
	
IF ib_AllowViewing THEN
	IF UpperBound ( lla_NewIds ) > 0 THEN
		IF MessageBox ( "New Shipments" , "Do you want to see the new shipments?", QUESTION! ,YESNO!, 1 ) = 1 THEN
			THIS.wf_DisplayNewShipments( lla_NewIDs )
		END IF
	END IF
END IF

lnv_msg.of_Reset ( )
lstr_Parm.is_Label = "NEWIDS"
lstr_Parm.ia_Value = lla_NewIDs
lnv_Msg.of_Add_Parm ( lstr_Parm )

CloseWithReturn ( THIS ,lnv_Msg )
end event

event open;call super::open;
n_cst_msg	lnv_msg
S_Parm		lstr_Parm
lnv_msg = Message.powerobjectParm

THIS.Height = 580

tab_1.TabPage_Equipment.Visible = FALSE
tab_1.TabPage_Options.Visible = FALSE
tab_1.TabPage_Multiple.Visible = FALSE

ib_disableCloseQuery = TRUE

THIS.wf_initializeWindow ( lnv_Msg )

THIS.wf_initializeTemplates ( )
THIS.wf_InitializeSplits ( )
THIS.Post wf_InitializeMultipleShipments ( )


IF NOT THIS.wf_AllowDuplication  () THEN
	CLOSE ( THIS )
END IF

end event

event pfc_postopen;//CHOOSE CASE UPPER ( is_Type )
//	CASE 'C'
//		is_ValueList = "CNTN~tC/"
//	CASE 'H', 'B'
//		is_ValueList = "RBOX~tB/CHAS~tH/"
//	CASE ELSE 
		is_ValueList =	"RBOX~tB/CHAS~tH/CNTN~tC/"
//END CHOOSE
//
IF Len ( is_ValueList ) > 0 THEN
	idw_Equipment.Modify ( 	"equipment_type.Values = '" + is_ValueList + "'" )
END IF



IF il_ShipmentID > 0 THEN
	st_duplicate.Text = "Tmp. #"
	st_duplicate.Visible = TRUE
	sle_temp.Visible = TRUE
	sle_Temp.Text = String ( il_ShipmentID , "0000" )
END IF


ii_Copies = Long ( em_Copies.text )
end event

event close;call super::close;DESTROY ids_Temp
end event

type cb_help from w_response`cb_help within w_duplicatewithequipment
end type

type st_nonroutedcopies from statictext within w_duplicatewithequipment
boolean visible = false
integer x = 466
integer y = 148
integer width = 800
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Copies will be Non-Routed"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_copies from u_em within w_duplicatewithequipment
integer x = 96
integer y = 144
integer width = 320
integer taborder = 10
boolean bringtotop = true
integer accelerator = 99
string mask = "####0"
boolean spin = true
string minmax = "1~~"
end type

event constructor;THIS.Text = "1"
end event

event losefocus;wf_SyncDatawindowWithCount ( )
end event

event getfocus;call super::getfocus;THIS.SelectText ( 1, Len (THIS.Text ) )
end event

type st_1 from statictext within w_duplicatewithequipment
integer x = 96
integer y = 68
integer width = 850
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "How many &copies do you want?"
boolean focusrectangle = false
end type

type cbx_equipment from checkbox within w_duplicatewithequipment
integer x = 96
integer y = 360
integer width = 1111
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "&Specify and create outside equipment."
end type

event clicked;wf_CheckBox ( "EQUIPMENT" )

end event

type cb_1 from u_cbok within w_duplicatewithequipment
integer x = 2185
integer y = 84
integer width = 274
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_2 from u_cbcancel within w_duplicatewithequipment
integer x = 2185
integer y = 208
integer width = 274
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cbx_copyref from checkbox within w_duplicatewithequipment
integer x = 96
integer y = 280
integer width = 677
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select &fields to copy."
end type

event clicked;wf_CheckBox ( "OPTIONS" )
end event

type tab_1 from u_tab_duplication within w_duplicatewithequipment
event type integer ue_deleterow ( long al_row )
integer x = 18
integer y = 572
integer height = 1076
integer taborder = 80
boolean bringtotop = true
end type

event ue_deleterow;Long	ll_Copies
IF al_Row <= idw_Equipment.RowCount ( ) THEN
	
	idw_Equipment.DeleteRow ( al_row )
	
	ll_Copies = Long ( em_copies.Text )

	ll_Copies -- 

	em_Copies.Text = String (ll_Copies)
	ii_Copies = ll_Copies
	
	
END IF

IF idw_Equipment.RowCount ( ) = 1 THEN
	
	IF Len ( is_ValueList ) > 0 THEN
		idw_Equipment.Modify ( 	"equipment_type.Values = '" + is_ValueList + "'" )
	END IF
END IF

RETURN 1
end event

event constructor;idw_equipment = THIS.tabpage_Equipment.dw_1
end event

event selectionchanged;IF newindex = 1 THEN
	cb_add.Visible = TRUE
ELSE
	cb_add.Visible = FALSE
END IF
end event

event ue_addrow;Long	ll_Copies
Long	ll_BeforeRow
Long	ll_RowToCopy

IF al_beforerow <= 0 THEN
	ll_BeforeRow = idw_Equipment.RowCount ( ) + 1
ELSE
	ll_BeforeRow = al_BeforeRow
END IF

IF idw_Equipment.RowCount ( ) = 0 THEN
	wf_InitializeEquipmentList () 
//	ll_RowCount = idw_equipment.RowCount ( )
ELSE
	
	IF ll_BeforeRow - 1 <= 0 then
		ll_RowToCopy = idw_Equipment.RowCount ( )
	ELSE
		ll_RowToCopy = ll_BeforeRow - 1
	END IF
	
	idw_Equipment.RowsCopy ( ll_RowToCopy , ll_RowToCopy , PRIMARY!, idw_Equipment, ll_BeforeRow , Primary! )
	idw_Equipment.SetItem ( ll_BeforeRow ,  "equipment_eq_ref", "" )
END IF

ll_Copies = Long ( em_copies.Text )

ll_Copies ++ 

em_Copies.Text = String (ll_Copies)

wf_SyncDataWindowWithCount ( )


idw_Equipment.SetColumn ( 2 )
idw_Equipment.SetRow ( ll_BeforeRow )
idw_Equipment.SetFocus ( )

IF idw_Equipment.RowCount ( ) = 2 THEN
	
	
	CHOOSE CASE idw_Equipment.object.equipment_type [ 1 ]
		
		CASE 'H' , 'B' 
			is_ValueList =	"RBOX~tB/CHAS~tH/"
		CASE ELSE
			is_ValueList = "CNTN~tC/"	
	END CHOOSE
	
	IF Len ( is_ValueList ) > 0 THEN
		idw_Equipment.Modify ( 	"equipment_type.Values = '" + is_ValueList + "'" )
	END IF
END IF
end event

event ue_nonroutedselected;call super::ue_nonroutedselected;st_nonroutedcopies.Visible = ab_value
end event

event ue_getsourceshipments;call super::ue_getsourceshipments;wf_getshipmentsource( ala_shipments[] )
end event

type sle_date from u_sle_date within w_duplicatewithequipment
integer x = 1445
integer y = 148
integer width = 338
integer taborder = 50
boolean bringtotop = true
integer accelerator = 100
end type

event constructor;THIS.Text = String ( TODAY ( ) ) 
end event

type st_2 from statictext within w_duplicatewithequipment
integer x = 1445
integer y = 72
integer width = 475
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Shipment &Date"
boolean focusrectangle = false
end type

type st_duplicate from statictext within w_duplicatewithequipment
boolean visible = false
integer x = 1445
integer y = 256
integer width = 425
integer height = 68
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tem&plate"
boolean focusrectangle = false
end type

event getfocus;ddlb_template.SetFocus ( )
end event

type gb_1 from groupbox within w_duplicatewithequipment
integer x = 23
integer y = 480
integer width = 2446
integer height = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_add from commandbutton within w_duplicatewithequipment
boolean visible = false
integer x = 2181
integer y = 544
integer width = 279
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Add"
end type

event clicked;tab_1.Event ue_AddRow ( 0 )
end event

type sle_temp from singlelineedit within w_duplicatewithequipment
boolean visible = false
integer x = 1445
integer y = 324
integer width = 471
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 29425663
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_template from u_ddlb within w_duplicatewithequipment
boolean visible = false
integer x = 1445
integer y = 324
integer width = 576
integer height = 424
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 1090519039
boolean allowedit = true
integer accelerator = 112
end type

event constructor;ib_Search = TRUE
end event

