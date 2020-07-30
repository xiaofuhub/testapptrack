$PBExportHeader$u_dw_equipmentlist.sru
$PBExportComments$EquipmentList (Data Control from PBL map PTData) //@(*)[34034163|986]
forward
global type u_dw_equipmentlist from u_dw
end type
end forward

global type u_dw_equipmentlist from u_dw
integer width = 2400
integer height = 600
string dragicon = "Rectangle!"
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
event type long task_retrieve ( )
event type integer ue_refresh ( )
event type integer ue_showmap ( ref w_map aw_map,  readonly boolean ab_switch )
event ue_details ( )
event ue_itinerary ( )
event type integer ue_setcategoryfilter ( integer ai_category )
event ue_fueltax ( )
event ue_equiphistreport ( )
event ue_pretax ( )
event ue_selectview ( )
event type integer ue_fleethistoryreport ( )
event ue_opendatamanager ( )
event type integer ue_showmapstreets ( ref w_map_streets aw_map,  readonly boolean ab_switch )
event ue_plotequipment ( ref w_map aw_map )
event ue_plotunroutedshipmentevents ( ref w_map aw_map )
event ue_keydown pbm_dwnkey
event type integer ue_traceequipment ( )
end type
global u_dw_equipmentlist u_dw_equipmentlist

type variables
n_cst_Mediator_DataManager    inv_Mediator
end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function string of_getsort ()
public function string of_getfilter ()
public function integer of_getviewfolder (ref string as_path)
end prototypes

event task_retrieve;long ll_rc = -1
n_cst_bcm	lnv_Cache, &
				lnv_bcm
n_cst_EquipmentManager	lnv_EquipmentMgr

//Get the cache from the EquipmentManager

IF lnv_EquipmentMgr.of_GetCache ( lnv_Cache ) = 1 THEN

	//Make a local copy of the cache
	lnv_Bcm = lnv_Cache.Copy ( )

	//If copy was successful, use the local copy as the data source
	IF IsValid ( lnv_Bcm ) THEN

		if inv_uilink.SetBCM(lnv_bcm) = 1 then
			ll_rc = this.RowCount()
		end if

	END IF

END IF

return ll_rc

end event

event ue_refresh;n_cst_EquipmentManager	lnv_EquipmentMgr
Integer	li_Return

li_Return = 1

IF lnv_EquipmentMgr.of_Refresh ( ) = -1 THEN
	li_Return = -1
//ELSEIF lnv_EquipmentMgr.of_RefreshCalculations ( ) = -1 THEN
//	li_Return = -1
//	This is not currently needed since refresh is pulling the whole list,
//	which does the calculations.  This is only needed for incremental retrieves.
END IF

IF li_Return = 1 THEN
	IF This.Event pfc_Retrieve ( ) = FAILURE THEN
		li_Return = -1
	END IF
END IF

IF li_Return = -1 THEN
	MessageBox ( "Refresh List", "Error refreshing list.  Request cancelled.", Exclamation! )
END IF

RETURN li_Return
end event

event type integer ue_showmap(ref w_map aw_map, readonly boolean ab_switch);Long			ll_EqCount
Long			ll_Id
Long			ll_Index
Long			ll_Count		
Long			lla_SelectedRows[]


Integer		li_Return = 1

String		ls_MessageHeader = "Show Map"


s_Parm		lstr_Parm
n_cst_Msg	lnv_Msg
s_Mapping	lstr_Mapping

n_cst_beo	lnva_Equipment[]

n_cst_beo_Equipment		lnv_Beo
n_cst_EquipmentManager	lnv_EquipmentManager
n_cst_LicenseManager lnv_LicenseManager 

IF ab_Switch THEN

	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Dispatch, "E" ) < 0 THEN
		li_Return = FAILURE
	END IF
	
	IF li_Return = 1 THEN	
		ll_Count = inv_Rowselect.of_Selectedcount( lla_SelectedRows )
	END IF
	
	IF li_Return = 1 THEN
		IF NOT IsValid ( This.inv_UILink ) THEN
		
			MessageBox ( ls_MessageHeader, "Could not process request (UILink not instantiated.)" )
			li_Return = -1
		
		END IF
	END IF
	
	IF li_Return = 1 THEN
	
		FOR ll_Index = 1 TO ll_Count
	
			lnv_Beo = This.inv_UILink.GetBeo ( lla_SelectedRows [ll_Index] )
	
			IF NOT IsValid ( lnv_Beo ) THEN
				CONTINUE
			END IF
	
			ll_EqCount ++
			lnva_Equipment [ll_EqCount] = lnv_Beo
				
		NEXT
	
	END IF
	
	IF li_Return = 1 THEN
		IF Not isValid ( aw_Map ) THEN
			lstr_Mapping.TypeMap = "B"
			OpenWithParm ( aw_Map, lstr_Mapping )
		END IF	
	END IF
	
	
	IF li_Return = 1 THEN
		IF IsValid ( aw_map ) THEN
			IF aw_Map.wf_plotpositions ( lnva_Equipment ) = -1 THEN
				li_Return = Failure
			END IF
		END IF
	END IF
ELSE
	IF IsValid ( aw_Map ) THEN
		Close ( aw_Map )
		li_Return = SUCCESS
	END IF	
END IF

RETURN li_Return
end event

event ue_details;Long ll_selectedRow
Long ll_selectedId
n_cst_AppServices	lnv_AppServices
n_cst_beo_Equipment lnv_beo
w_eq_info lw_eqwin

ll_selectedRow = getrow()

if ll_selectedRow > 0 then 
	lnv_beo = inv_uilink.getBeo( ll_SelectedRow )
	IF IsValid ( lnv_beo ) THEN
		ll_selectedId = lnv_beo.of_getID()
	END IF
END IF

if ll_selectedId > 0 then
	opensheetwithparm(lw_eqwin, ll_SelectedId, lnv_AppServices.of_GetFrame ( ), 0, original!)
else
	messagebox("Show Equipment Details", "No equipment is selected.")
end if
end event

event ue_itinerary;Long	ll_selectedRow
Long	ll_selectedId
Long	ll_ViewRow
String	ls_Type
Date	ld_ItinDate
datastore	lds_View
n_cst_AppServices	lnv_AppServices
n_cst_beo_Equipment lnv_beo
n_cst_EquipmentManager lnv_Equip

ll_SelectedRow = This.GetRow ( )

IF ll_SelectedRow > 0 AND IsValid ( inv_UILink ) THEN
	lnv_Beo = inv_UILink.GetBeo ( ll_SelectedRow )
	IF IsValid ( lnv_Beo ) THEN
		ls_type = lnv_beo.of_getType()
		lds_View = lnv_beo.getBcm ( ).getView ( ) 
		ll_SelectedId = lnv_beo.of_GetId ( )  
		ll_ViewRow = lds_view.GetRowFromRowID ( lnv_Beo.getBeoIndex( ) ) 
		ld_ItinDate = lds_View.GetItemDate ( ll_ViewRow, "CurrentEvent_DateArrived" )
	END IF
END IF

IF ll_SelectedId > 0 THEN
	lnv_Equip.of_OpenItinerary ( ll_SelectedId , ld_ItinDate )
ELSE
	MessageBox( "Show Itinerary", "No equipment is selected." )
END IF

end event

event ue_setcategoryfilter;//Returns:  SUCCESS, FAILURE

String	ls_Filter
n_cst_EquipmentManager	lnv_EquipmentMgr

Integer	li_Return = FAILURE


//Attempt to get a filter from the EquipmentMgr for the appropriate column name and requested category.
ls_Filter = lnv_EquipmentMgr.of_GetTypeFilter ( "Equipment_Type", ai_Category )


//If a valid type list has been returned, build and set a filter from it.

IF NOT IsNull ( ls_Filter ) THEN
	IF This.SetFilter ( ls_Filter ) = 1 THEN
		li_Return = SUCCESS
		This.Filter ( )
	END IF
END IF


RETURN li_Return
end event

event ue_fueltax;Long 	ll_SelectedID
Long	ll_SelectedRow

n_cst_bso_FuelTax 	lnv_FuelTax
n_cst_beo_Equipment	lnv_Beo

ll_SelectedRow = GetRow ( )

if ll_SelectedRow > 0 then 
	lnv_beo = inv_uilink.getBeo( ll_SelectedRow )
	IF IsValid ( lnv_beo ) THEN
		ll_selectedId = lnv_beo.of_getID()
	END IF
END IF


choose case ll_SelectedRow

case is > 0
	lnv_FuelTax = create n_cst_bso_FuelTax
	lnv_FuelTax.of_process_report("EQUIPMENT!", ll_selectedId , appeon_constant.cs_Context_FuelTax )
	destroy lnv_FuelTax

case else
	messagebox("Prepare Fuel Tax Data", "No equipment is selected.")

end choose


end event

event ue_equiphistreport;Long ll_SelectedRow
Long ll_SelectedId

n_cst_bso_FuelTax		lnv_FuelTax
n_cst_beo_Equipment	lnv_beo

ll_SelectedRow = getRow ( ) 

if ll_selectedRow > 0 then 
	lnv_beo = inv_uilink.getBeo( ll_SelectedRow )
	IF IsValid ( lnv_beo ) THEN
		ll_selectedId = lnv_beo.of_getID()
	END IF
END IF


choose case ll_selectedRow

case is > 0
	lnv_FuelTax = create n_cst_bso_FuelTax
	lnv_FuelTax.of_process_report("EQUIPMENT!", ll_selectedId, appeon_constant.cs_Context_HistoryReport )
	destroy lnv_FuelTax

case else
	messagebox("Equipment History Report", "No equipment is selected.")

end choose
end event

event ue_pretax;Long 	ll_SelectedID
Long	ll_SelectedRow

n_cst_bso_FuelTax 	lnv_FuelTax
n_cst_beo_Equipment	lnv_Beo

ll_SelectedRow = GetRow ( )

if ll_SelectedRow > 0 then 
	lnv_beo = inv_uilink.getBeo( ll_SelectedRow )
	IF IsValid ( lnv_beo ) THEN
		ll_SelectedId = lnv_beo.of_getID()
	END IF
END IF


choose case ll_SelectedRow

case is > 0
	lnv_FuelTax = create n_cst_bso_FuelTax
	lnv_FuelTax.of_process_report("EQUIPMENT!", ll_SelectedId , appeon_constant.cs_Context_StateBreakdown )
	destroy lnv_FuelTax

case else
	messagebox("Prepare State Breakdown", "No equipment is selected.")

end choose


end event

event ue_selectview;String	ls_SortString
String 	ls_FilterString
String	ls_PathName, &
			ls_FileName
n_cst_bcm	lnv_Bcm
Boolean	lb_Success
			
n_cst_Presentation_EquipmentSummary	lnv_Presentation

n_cst_FileSrvwin32 lnv_FileSrv
lnv_FileSrv = CREATE n_cst_FileSrvwin32


ls_SortString = THIS.of_GetSort ( ) 
ls_FilterString = THIS.of_GetFilter ( ) 

IF THIS.of_GetViewFolder ( ls_PathName ) = 1 THEN
	lnv_FileSrv.of_ChangeDirectory ( ls_PathName )
END IF

IF GetFileOpenName ( "Select New Data View", ls_PathName, ls_FileName, "", "PSR Files (*.psr),*.psr" ) = 1 THEN
	
	IF Len ( ls_PathName ) > 0 THEN

		lnv_Bcm = This.inv_UILink.GetBcm ( FALSE /*Don't Create*/ )
	
		THIS.SetRedraw ( FALSE )
		THIS.DataObject = ls_PathName

		//In 3.0.03, we changed from just RefreshFromBcm to toggling the UILink off, then back on again.
		//This was done because PSR views had to have exactly the same column definition to work the old way.
		//This way, the display column mappings are cleared when the UILink is turned off, and then redefined
		//for the new view when it's turned back on again.
		This.SetUILink ( FALSE )
		This.SetUILink ( TRUE )
		This.inv_UILink.SetClass ( "" )
		
		lnv_Presentation.of_SetPresentation ( THIS )
		//THIS.inv_UILink.RefreshFromBcm ( )

		lb_Success = FALSE
		IF IsValid ( lnv_Bcm ) THEN
			IF inv_uilink.SetBCM(lnv_bcm) = 1 THEN
				lb_Success = TRUE
			END IF
		END IF

		IF lb_Success = FALSE THEN
			This.Event task_Retrieve ( )
		END IF
		
		
		IF Len (ls_SortString) > 0 THEN
			IF MessageBox( "Sort" , "Do you wish to apply the previous sort to the new view?" , QUESTION! , YESNO! , 1 ) = 1 THEN
				THIS.SetSort ( ls_SortString )
				THIS.Sort ( )
			END IF
		END IF
		
		IF Len (ls_FilterString) > 0  THEN
			IF MessageBox( "Filter" , "Do you wish to apply the previous filter to the new view?" , QUESTION! , YESNO! , 1 ) = 1 THEN
				THIS.SetFilter ( ls_FilterString )
				THIS.Filter ( )
			END IF
		END IF

		//GroupCalc added 3.5.18 BKW
		This.GroupCalc ( )
		
		THIS.SetRedraw ( TRUE )
	END IF
END IF

DESTROY lnv_FileSrv
end event

event type integer ue_fleethistoryreport();//Returns : 1 = Success, 0 = No action taken (no data, user cancel, etc.), -1 = Error


// Modified 4/13/05 to use selected row instead of rows on the current display

Date			ld_Start, &
				ld_End, &
				ld_Null
s_Anys		lstr_Result
s_Parm		lstr_Parm
n_cst_Msg	lnv_Msg, &
				lnv_Range, &
				lnv_Blank
Integer		li_Result, &
				li_ItinType
Long			ll_Id, &
				ll_Index, &
				ll_Count
				
Long	lla_SelectedRows[]

n_cst_beo_Equipment	lnv_Beo
				
String	ls_Template, &
			ls_Filter

String	ls_MessageHeader = "Fleet History Report"
	
any	laa_beo[], &
		laa_Data[]
	
				
n_cst_Privileges			lnv_Privileges
n_cst_beo_Itinerary2		lnva_Itinerary[]
n_cst_bso_Dispatch		lnva_Dispatch[]

SetNull ( ld_Null )
Integer	li_Return = 1





IF li_Return = 1 THEN

	IF lnv_Privileges.of_HasAdministrativeRights ( ) = FALSE THEN
		MessageBox ( ls_MessageHeader, lnv_Privileges.of_GetRestrictMessage ( ) )
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	
	ll_Count = inv_Rowselect.of_Selectedcount( lla_SelectedRows )

	//ll_RowCount = This.RowCount ( )

	IF ll_Count > 0 THEN
		IF MessageBox ( ls_MessageHeader, "OK to generate the Fleet History Report for the " +&
			String ( ll_Count ) + " unit(s) selected in the current display?", Question!, &
			OkCancel!, 1 ) = 2 THEN

			li_Return = 0

		END IF
	ELSE
		MessageBox ( ls_MessageHeader, "The report is generated for selected equipment in the display list.  "+&
			"Currently, no equipment is selected to report on." )
		li_Return = 0
	END IF

END IF


IF NOT IsValid ( This.inv_UILink ) THEN

	MessageBox ( ls_MessageHeader, "Could not process request (UILink not instantiated.)" )
	li_Return = -1

END IF


IF li_Return = 1 THEN

	//Present a date range dialog to the user.

	lstr_Parm.is_Label = "OPTIONAL"
	lstr_Parm.ia_Value = "FALSE"
	lnv_msg.of_add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_Date_Range, lnv_Msg )
	
	lstr_result = message.powerobjectparm
	li_result = lstr_result.anys[1]
	
	if li_result = 1 then
		ld_Start = lstr_result.anys[2]
		ld_Start = Date ( DateTime ( ld_Start ) )
		ld_End = lstr_result.anys[3]
		ld_End = Date ( DateTime ( ld_End ) )

		IF IsNull ( ld_Start ) OR IsNull ( ld_End ) THEN
			li_Return = -1
		END IF

	ELSE  //User Cancelled
		li_Return = 0
	end if

END IF


IF li_Return = 1 THEN
	
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	n_cst_EmployeeManager	lnv_EmployeeManager	//**We're borrowing the of_GetTemplate function on this**
	ls_Template = lnv_EmployeeManager.of_GetTemplate()
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	IF len ( trim ( ls_Template ) ) > 0 THEN
		//OK, a template was selected
	ELSE
		//User cancelled.
		li_Return = 0
	END IF
	
END IF


IF li_Return = 1 THEN

	FOR ll_Index = 1 TO ll_Count

		lnv_Beo = This.inv_UILink.GetBeo ( lla_SelectedRows [ll_Index] )

		IF NOT IsValid ( lnv_Beo ) THEN
			CONTINUE
		END IF

		ll_Id = lnv_Beo.of_GetId ( )
		IF IsNull ( ll_Id ) THEN
			CONTINUE
		END IF

		li_ItinType = lnv_Beo.of_GetItinType ( )
		IF IsNull ( li_ItinType ) THEN
			CONTINUE
		END IF

		lnva_Dispatch [ ll_Index ] = CREATE n_cst_bso_Dispatch
		lnva_Dispatch [ ll_Index ].of_RetrieveItinerary ( li_ItinType, ll_Id, &
			RelativeDate ( ld_Start, -5 ), RelativeDate ( ld_End, 5 ), FALSE /*Don't force prior beyond cushion*/ )

		//Filter the itinerary  (use null limits to take everything that was retrieved -- we want everything that
		//was retrieved, even the stuff outside the range.)
		lnva_Dispatch [ ll_Index ].of_FilterItinerary ( li_ItinType, ll_Id, ld_Null, ld_Null )

		lnv_Range.of_Reset ( )

		lstr_Parm.is_Label = "StartDate"
		lstr_Parm.ia_Value = ld_Start
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "EndDate"
		lstr_Parm.ia_Value = ld_End
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = li_ItinType
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = ll_Id
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lnva_Itinerary [ ll_Index ] = CREATE n_cst_beo_itinerary2
		
		lnva_Itinerary [ ll_Index ].of_SetDispatchManager ( lnva_Dispatch [ ll_Index ] )
		lnva_Itinerary [ ll_Index ].of_SetRange ( lnv_Range )

	NEXT

END IF


IF li_Return = 1 THEN
	
	n_cst_bso_ReportManager	lnv_ReportManager
	laa_Beo = lnva_Itinerary
	lnv_ReportManager.of_CreateReport ( "ITINERARY", ls_Template, laa_Beo, TRUE, TRUE, laa_Data, lnv_Range )
	
END IF

ll_Count = upperbound ( lnva_Itinerary ) 
FOR ll_Index = 1 to ll_Count
	DESTROY lnva_Itinerary [ll_Index]
NEXT

ll_Count = upperbound ( lnva_Dispatch ) 
FOR ll_Index = 1 to ll_Count
	DESTROY lnva_Dispatch [ll_Index]
NEXT

RETURN li_Return
end event

event ue_showmapstreets;//Will open or close an instance of w_Map, passed by reference, and populate
//it with pins for the currently displayed equipment information.

//Returns:  SUCCESS, FAILURE, NO_ACTION

s_mapping	lstr_Mapping
n_cst_beo lnv_beo[]

Integer	li_Return = NO_ACTION

IF ab_Switch THEN

	IF NOT IsValid ( aw_Map ) THEN

		//	Request a lock for user
		n_cst_LicenseManager lnv_LicenseManager 

		IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Dispatch, "E" ) < 0 THEN

			li_Return = FAILURE

		ELSE	
			setPointer(HOURGLASS!)
			
			inv_uilink.getallbeo(lnv_beo)
			
			lstr_Mapping.ypos = 1
			SetNull ( lstr_Mapping.xpos )
			lstr_Mapping.typemap = "L"  //Locations
			lstr_Mapping.inva_BeoList = lnv_Beo
			
			openwithparm( aw_Map, lstr_Mapping, Parent )
	
			li_Return = SUCCESS

		END IF

	END IF

ELSE

	IF IsValid ( aw_Map ) THEN
		Close ( aw_Map )
		li_Return = SUCCESS
	END IF

END IF

RETURN li_Return
end event

event ue_plotequipment(ref w_map aw_map);Date			ld_Start
Date			ld_End
Date			ld_Null
Long			ll_EqCount
Long			ll_Id
Long			ll_Index
Long			ll_Count		
Long			lla_SelectedRows[]
Long			lla_EqIds[]

Integer		li_Result
Integer		li_Return = 1

String		ls_MessageHeader = "Plot Equipment Route"

s_Anys		lstr_Result
s_Parm		lstr_Parm
n_cst_Msg	lnv_Msg
s_Mapping	lstr_Mapping

n_cst_beo_Equipment		lnv_Beo
n_cst_EquipmentManager	lnv_EquipmentManager
SetNull ( ld_Null )

IF li_Return = 1 THEN	
	ll_Count = inv_Rowselect.of_Selectedcount( lla_SelectedRows )
END IF


IF NOT IsValid ( This.inv_UILink ) THEN

	MessageBox ( ls_MessageHeader, "Could not process request (UILink not instantiated.)" )
	li_Return = -1

END IF


IF li_Return = 1 THEN

	//Present a date range dialog to the user.

	lstr_Parm.is_Label = "OPTIONAL"
	lstr_Parm.ia_Value = "FALSE"
	lnv_msg.of_add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_Date_Range, lnv_Msg )
	
	lstr_result = message.powerobjectparm
	li_result = lstr_result.anys[1]
	
	if li_result = 1 then
		ld_Start = lstr_result.anys[2]
		ld_Start = Date ( DateTime ( ld_Start ) )
		ld_End = lstr_result.anys[3]
		ld_End = Date ( DateTime ( ld_End ) )

		IF IsNull ( ld_Start ) OR IsNull ( ld_End ) THEN
			li_Return = -1
		END IF

	ELSE  //User Cancelled
		li_Return = 0
	end if

END IF


IF li_Return = 1 THEN

	FOR ll_Index = 1 TO ll_Count

		lnv_Beo = This.inv_UILink.GetBeo ( lla_SelectedRows [ll_Index] )

		IF NOT IsValid ( lnv_Beo ) THEN
			CONTINUE
		END IF

		ll_Id = lnv_Beo.of_GetId ( )
		IF IsNull ( ll_Id ) THEN
			CONTINUE
		END IF

		ll_EqCount ++
		lla_EqIds[ll_EqCount] = ll_Id
			
	NEXT

END IF

IF li_Return = 1 THEN
	IF Not isValid ( aw_Map ) THEN
		lstr_Mapping.TypeMap = "B"
		OpenWithParm ( aw_Map, lstr_Mapping )
	END IF	
END IF


IF li_Return = 1 THEN
	
	lnv_EquipmentManager.of_DisplayRouteMap ( lla_EqIds , ld_Start , ld_End, aw_Map )
	
END IF

end event

event ue_plotunroutedshipmentevents(ref w_map aw_map);n_cst_EquipmentManager	lnv_EquipmentManager
s_Mapping	lstr_Mapping

If Not isValid ( aw_map ) THEN
	lstr_Mapping.TypeMap = "B"	
	OpenWithParm ( aw_Map, lstr_Mapping )
END IF

lnv_EquipmentManager.of_DisplayUnroutedStops ( aw_Map )
end event

event ue_keydown;IF keyflags = 2 AND KeyDown ( KeyA! ) THEN// Ctrl key
	THIS.Selectrow( 0, TRUE )
END IF

RETURN 0
end event

event type integer ue_traceequipment();Integer	li_Return = 1
Long		ll_Count, i
Long		lla_SelectedRows[]
Long		lla_EqId[]
String	ls_EqType
String	ls_MsgErr = "Failed to trace selected equipment."
String	ls_MessageHeader 
ls_MessageHeader = "Add Equipment to " + gnv_App.of_GetRailTraceAppName()

n_cst_PtRailTraceManager	lnv_RailTraceMgr
n_cst_equipmentmanager 		lnv_EqMgr
	
ll_Count = inv_Rowselect.of_SelectedCount( lla_SelectedRows )

IF ll_Count > 0 THEN
	//Populate EqRef array
	FOR i = 1 TO ll_Count
		
		lla_EqId[UpperBound(lla_EqId)+1] = This.GetItemNumber(lla_SelectedRows[i], "equipment_id")
		
		//Test for selection of Power Equipment
		ls_EqType = This.GetItemString(lla_SelectedRows[i], "equipment_type")
		IF ls_EqType = lnv_EqMgr.cs_TRAC OR ls_EqType = lnv_EqMgr.cs_STRT OR ls_EqType = lnv_EqMgr.cs_VAN THEN
			ls_MsgErr = "Power equipment cannot be traced. Deselect power equipment and try again."
			li_Return = 0
			EXIT
		END IF
	NEXT
ELSE
	ls_MsgErr = "Select equipment to add from the current display."
	li_Return = 0
END IF


IF li_Return = 1 THEN
	lnv_RailTraceMgr = Create n_cst_PtRailTraceManager
	
	IF lnv_RailTraceMgr.of_AddEquipmentTrace(lla_EqId) <> 1 THEN
		li_Return = -1
		ls_MsgErr = "Failed to add equipment to pending trace list."
	END IF
	
	Destroy(lnv_RailTRaceMgr)
	
END IF

IF li_Return = 1 THEN
	MessageBox(ls_MessageHeader, "Successfully added selected equipment to the pending trace list.")
ELSE
	MessageBox ( ls_MessageHeader, ls_MsgErr )
END IF

Return li_Return
end event

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

public function string of_getsort ();String	ls_Sort

//SetNull (ls_Sort)// this has to be set null so the outside can Distinguish 
					  // between no sort and the removal of the sort which is an empty 
				     // string

IF IsValid ( inv_sort ) THEN
	ls_Sort =  inv_sort.of_GetSort ( ) 
END IF

RETURN ls_Sort
	
end function

public function string of_getfilter ();String	ls_Filter

//SetNull ( ls_Filter )// this has to be set null so the outside can Distinguish 
							// between no filter and the "all filter" which is an empty 
							// string

IF IsValid ( inv_Filter ) THEN
	ls_Filter =  inv_Filter.of_GetFilter ( ) 
END IF

RETURN ls_Filter
	
end function

public function integer of_getviewfolder (ref string as_path);//Returns:    
//				 1 = Success
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database
//				-2 = file DNE
// THIS GET THE Location to the equipment summary views ( PSRs )

String	ls_Description
Integer	li_SqlCode
Any 		la_Setting 
Integer	li_Return = 1


n_cst_fileSrvwin32	lnv_fileSrv
lnv_FileSrv = CREATE n_cst_fileSrvwin32
n_cst_String	lnv_String
n_cst_Settings lnv_Settings 


li_Return = lnv_Settings.of_GetSetting( 61, la_Setting ) 

//Set Reference Parameters and Return
IF li_Return = 1 THEN
	
	ls_Description = String ( la_Setting )
	
	IF Right ( ls_Description , 1 ) <> "\" THEN
		ls_Description += "\"
	END IF

	IF Not lnv_FileSrv.of_DirectoryExists( ls_Description ) THEN
		
		li_Return = -2
	
	END IF
	
	as_path = ls_description
	
END IF

IF isValid ( lnv_fileSrv ) THEN
	DESTROY lnv_FileSrv
END IF

RETURN li_Return



end function

on u_dw_equipmentlist.destroy
end on

event constructor;//@(data)(recreate=yes)<GenerationOptions>
SetUILink(TRUE)
inv_uilink.SetClass("")
of_SetTransObject(SQLCA)
//@(data)--

this.SetUseTaskRetrieve(TRUE)

This.DataObject = "d_EquipmentDisplay"
This.of_SetInsertable ( FALSE )
This.of_SetDeleteable ( FALSE )
This.of_SetUpdateable ( FALSE )  //This doesn't seem to have much effect on its own

n_cst_Presentation_EquipmentSummary	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

of_SetAutoFind ( TRUE )
of_SetAutoSort ( TRUE )
of_SetAutoFilter ( TRUE )

//Instantiate the default row focus indicator
//This.Event ue_SetFocusIndicator ( TRUE )
//
THIS.of_setrowselect( TRUE )
inv_rowselect.of_setstyle( inv_rowselect.extended )


ib_rmbfocuschange = FALSE


//Instantiate the Mediator Object
inv_Mediator = CREATE n_cst_Mediator_DataManager
inv_Mediator.of_RegisterTarget ( THIS , "equip" )
end event

event doubleclicked;IF row > 0 THEN
	this.Event ue_Itinerary()
END IF
end event

event ue_autofind;call super::ue_autofind;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

IF AncestorReturnValue = SUCCESS THEN

	inv_Find.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_DBName )

END IF

RETURN AncestorReturnValue
end event

event ue_autosort;call super::ue_autosort;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

IF AncestorReturnValue = SUCCESS THEN

	inv_sort.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_DBName )

END IF

RETURN AncestorReturnValue
end event

event ue_autofilter;call super::ue_autofilter;//Extend ancestor code to use different options when autostarting
//AncestorReturnValue will be FAILURE or NO_ACTION if not autostarting

IF AncestorReturnValue = SUCCESS THEN

	inv_Filter.of_SetColumnDisplayNameStyle ( ci_DisplayNameStyle_DBName )

END IF

RETURN AncestorReturnValue
end event

event clicked;// OVERRIDE ANCESTOR SCRIPT 
Long	ll_Rtn = 0 //continue processing


IF Keydown ( KeyAlt! ) THEN
	
	inv_Mediator.of_CreateFilterObject ( dwo , Row ) 
	
ELSE
	ll_Rtn =	Super::Event clicked ( xpos,ypos,row,dwo )
END IF
	
RETURN ll_Rtn

end event

on u_dw_equipmentlist.create
end on

event rbuttondown;call super::rbuttondown;Long		ll_Return
Long		ll_EqID
Int		li_Count
string 	lsa_parm_labels[]
any 		laa_parm_values[]
n_cst_msg lnv_cst_msg
s_parm lstr_parm

ll_Return = AncestorReturnValue

THIS.SetRow ( ROW )

IF Row > 0 THEN

	CHOOSE CASE dwo.name
			
		CASE "equipment_number" , "equipment_type"
			
			
			li_Count ++
			lsa_parm_labels[li_Count] = "ADD_ITEM"
			laa_parm_values[li_Count] = "Add &Alert"
			
			li_Count ++
			lsa_parm_labels[li_Count] = "ADD_ITEM"
			laa_parm_values[li_Count] = "Equipment &Details"
	
	END CHOOSE

	choose case f_pop_standard(lsa_parm_labels, laa_parm_values)
			
		CASE "ADD ALERT"
			ll_EqID = THIS.object.equipment_id[row]
			n_cst_beo_Equipment2	lnv_Eq
			lnv_Eq = CREATE n_cst_beo_Equipment2
			lnv_Eq.of_SetSourceID (ll_EqID )
			lnv_Eq.of_Adduseralert( )
			DESTROY ( lnv_Eq )
					
		CASE "EQUIPMENT DETAILS"
			ll_EqID = THIS.object.equipment_id[row]
			lstr_parm.is_label = "TOPIC"
			lstr_parm.ia_value = "EQUIPMENT!"
			lnv_cst_msg.of_add_parm(lstr_parm)
	
			lstr_parm.is_label = "REQUEST"
			lstr_parm.ia_value = "DETAILS!"
			lnv_cst_msg.of_add_parm(lstr_parm)
	
			lstr_parm.is_label = "TARGET_ID"
			lstr_parm.ia_value = ll_EqID
			lnv_cst_msg.of_add_parm(lstr_parm)
	
			f_process_standard(lnv_cst_msg)
	END CHOOSE
	
END IF

RETURN  ll_Return
end event

