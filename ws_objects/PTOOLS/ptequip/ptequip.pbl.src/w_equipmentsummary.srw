$PBExportHeader$w_equipmentsummary.srw
$PBExportComments$EquipmentSummary (Window from PBL map PTData) //@(*)[65176532|1002]
forward
global type w_equipmentsummary from w_sheet
end type
type cb_5 from commandbutton within w_equipmentsummary
end type
type dw_equipmentlist from u_dw_equipmentlist within w_equipmentsummary
end type
type uo_radius from u_radius within w_equipmentsummary
end type
type cb_1 from u_cb within w_equipmentsummary
end type
type cb_2 from u_cb within w_equipmentsummary
end type
type cb_3 from u_cb within w_equipmentsummary
end type
type cb_4 from u_cb within w_equipmentsummary
end type
type cb_refresh from commandbutton within w_equipmentsummary
end type
end forward

global type w_equipmentsummary from w_sheet
integer x = 14
integer y = 176
integer width = 3931
integer height = 1932
string title = "Equipment Summary"
string menuname = "m_sheets"
long backcolor = 12632256
event ue_mousemove pbm_ncmousemove
event ue_search ( )
cb_5 cb_5
dw_equipmentlist dw_equipmentlist
uo_radius uo_radius
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_refresh cb_refresh
end type
global w_equipmentsummary w_equipmentsummary

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.

//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Private n_cst_Toolmenu_Manager	inv_ToolmenuManager
Private w_Map	iw_Map
Private w_map_streets	iw_mapstreets
//Private n_cst_bcm	inv_OriginalBCM
end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
public function n_cst_uilink_dw wf_getuilink ()
end prototypes

event ue_mousemove;

IF  ypos - THIS.Height  > -200 THEN
	IF isValid ( dw_equipmentlist.inv_Mediator ) THEN
		dw_equipmentlist.inv_Mediator.of_ShowDataManager ( )
	END IF
END IF
end event

event ue_search;SETPOINTER ( HOURGLASS! )

w_EquipmentSearch	lw_EquipmentSearch

OpenWithParm  ( lw_EquipmentSearch , dw_equipmentlist.inv_uiLink , THIS )
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

public function integer wf_createtoolmenu ();n_cst_LicenseManager	lnv_LicenseManager
s_toolmenu lstr_toolmenu

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "ITINERARY!"
lstr_toolmenu.s_menuitem_text = "&Itinerary"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "DETAILS!"
lstr_toolmenu.s_menuitem_text = "&Details"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "HISTORYREPORT!"
lstr_toolmenu.s_menuitem_text = "Equipment &History Report"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_FuelTax ) THEN

	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "STATEBREAKDOWN!"
	lstr_toolmenu.s_menuitem_text = "State &Breakdown Report"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "FUELTAX!"
	lstr_toolmenu.s_menuitem_text = "Prepare Fuel Ta&x Data"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

END IF

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "FLEETHISTORYREPORT!"
lstr_toolmenu.s_menuitem_text = "&Fleet History Report"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "REFRESH!"
lstr_toolmenu.s_menuitem_text = "&Refresh (reset)"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) AND pcmm_inst THEN
	inv_ToolmenuManager.of_add_standard("DIVIDER!")
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "MAP!"
	lstr_toolmenu.s_menuitem_text = "Plot Last Confir&med Positions"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "PLOTEQUIPMENT!"
	lstr_toolmenu.s_menuitem_text = "Plot &Equipment Routes..."
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "PLOTSTOPS!"
	lstr_toolmenu.s_menuitem_text = "Plot &Unrouted Shipment Events"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	inv_ToolmenuManager.of_add_standard("DIVIDER!")
END IF

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "VIEW!"
lstr_toolmenu.s_menuitem_text = "Change &View"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "SEARCH!"
lstr_toolmenu.s_menuitem_text = "&Search"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

IF lnv_LicenseManager.of_IsRailTraceActiveOutbound( ) THEN
	inv_ToolmenuManager.of_add_standard("DIVIDER!")
	lstr_toolmenu.s_name = "TRACE!"
	lstr_toolmenu.s_menuitem_text = "&Trace Selected Equipment"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
END IF


inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);CHOOSE CASE as_Request

CASE "REFRESH!"
	dw_EquipmentList.Event ue_Refresh ( )

CASE "MAP!"
	n_cst_licensemanager	lnv_licensemanager
	
	if lnv_LicenseManager.of_usepcmilerstreets() then
		dw_EquipmentList.Event ue_ShowMap ( iw_mapstreets, TRUE )
	elseif lnv_LicenseManager.of_haspcmilerlicense() then
		dw_EquipmentList.Event ue_ShowMap ( iw_Map, TRUE )
	else
		//no license	
	end if

	

CASE "ITINERARY!"
	dw_EquipmentList.Event ue_Itinerary ( )

CASE "DETAILS!"
	dw_EquipmentList.Event ue_Details ( )

CASE "FUELTAX!" 
	dw_EquipmentList.Event ue_FuelTax ( )

CASE "HISTORYREPORT!"
	dw_EquipmentList.Event ue_EquipHistReport ( )	

CASE "STATEBREAKDOWN!"
	dw_EquipmentList.Event ue_PreTax ( )

CASE "FLEETHISTORYREPORT!"
	dw_EquipmentList.Event ue_FleetHistoryReport ( )

CASE "VIEW!"
	dw_EquipmentList.Event ue_SelectView ( )

CASE "SEARCH!"
	THIS.event ue_Search ( )
	
	
CASE "PLOTEQUIPMENT!"
	if lnv_LicenseManager.of_usepcmilerstreets() then
		dw_equipmentlist.event ue_plotequipment( iw_mapstreets )
	elseif lnv_LicenseManager.of_haspcmilerlicense() then
		dw_equipmentlist.event ue_plotequipment( iw_Map )
	else
		//no license	
	end if

CASE "PLOTSTOPS!"
	if lnv_LicenseManager.of_usepcmilerstreets() then
		dw_equipmentlist.event ue_plotunroutedshipmentevents( iw_mapstreets )
	elseif lnv_LicenseManager.of_haspcmilerlicense() then
		dw_equipmentlist.event ue_plotunroutedshipmentevents( iw_Map )
	else
		//no license	
	end if
CASE "TRACE!"
	dw_equipmentlist.Event ue_TraceEquipment()
	
END CHOOSE
end subroutine

public function n_cst_uilink_dw wf_getuilink ();RETURN dw_equipmentlist.inv_uilink
end function

on w_equipmentsummary.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.cb_5=create cb_5
this.dw_equipmentlist=create dw_equipmentlist
this.uo_radius=create uo_radius
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_5
this.Control[iCurrent+2]=this.dw_equipmentlist
this.Control[iCurrent+3]=this.uo_radius
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_refresh
end on

on w_equipmentsummary.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_5)
destroy(this.dw_equipmentlist)
destroy(this.uo_radius)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_refresh)
end on

event open;call super::open;//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Dispatch, "E" ) < 0 THEN
	ib_DisableCloseQuery = TRUE
	close (this)
	return
END IF

SetPointer ( HourGlass! )
gf_Mask_Menu ( m_Sheets )
wf_CreateToolmenu ( )

//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>

//@(text)--
//Retrieve in pfc_PostOpen

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

//@(text)(recreate=no)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_equipmentlist, 'ScaleToRight&Bottom')
//@(text)--

end event

event close;call super::close;n_cst_licensemanager	lnv_licensemanager

//Have the u_dw close the map window, if it's open
if lnv_LicenseManager.of_usepcmilerstreets() then
	dw_EquipmentList.Event ue_ShowMapStreets ( iw_mapstreets, FALSE )
elseif lnv_LicenseManager.of_haspcmilerlicense() then
	dw_EquipmentList.Event ue_ShowMap ( iw_Map, FALSE )
else
	//no license	
end if


//Destroy the ToolMenuManager
DESTROY inv_ToolmenuManager

RETURN AncestorReturnValue
end event

event task_setinputparameters;call super::task_setinputparameters;//@(+)(recreate=opt)<ValueMaps-EquipmentSummary>
Choose Case an_navigation.GetName()
Case "EquipmentSummary to Exit1"
//@(data)(recreate=yes)<EquipmentSummary to Exit1>
//@(data)--

//@(text)(recreate=no)<EquipmentSummary to Exit1 User Code>

//@(text)--
End Choose
//@(+)--

return 1
end event

event pfc_postopen;//Done here rather than open for psychological reasons only.

inv_Linkage.Retrieve ( dw_EquipmentList )

dw_EquipmentList.SetFocus ( )

//inv_OriginalBCM = dw_equipmentlist.Inv_UILink.GetBCM ( ) 
end event

type cb_5 from commandbutton within w_equipmentsummary
integer x = 3575
integer y = 44
integer width = 283
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Search"
end type

event clicked;Parent.event ue_search( )
end event

type dw_equipmentlist from u_dw_equipmentlist within w_equipmentsummary
event ue_mousemove pbm_dwnmousemove
event ue_filterchanged ( )
string tag = ";objectid=[65201317|1003]"
integer x = 32
integer y = 184
integer width = 3835
integer height = 1516
integer taborder = 10
end type

event ue_mousemove;
IF isValid ( THIS.inv_Mediator ) THEN
	inv_Mediator.of_HideDataManager ( )
END IF
end event

event ue_filterchanged;uo_Radius.of_Unapplied ( )
end event

on dw_equipmentlist.create
call u_dw_equipmentlist::create
end on

on dw_equipmentlist.destroy
call u_dw_equipmentlist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
inv_uilink.SetClass("")
//@(data)--

end event

event pfc_filterdlg;call super::pfc_filterdlg;//If successful, this action will have unapplied any radius restriction, 
//so we need to notify the control, so it can reset its display.

IF AncestorReturnValue = SUCCESS THEN
	uo_Radius.of_Unapplied ( )
END IF

RETURN AncestorReturnValue
end event

event task_retrieve;call super::task_retrieve;//If successful, this action will have unapplied any radius restriction, 
//so we need to notify the control, so it can reset its display.

IF AncestorReturnValue >= 0 THEN
	uo_Radius.of_Unapplied ( )
END IF

RETURN AncestorReturnValue
end event

event ue_setcategoryfilter;call super::ue_setcategoryfilter;//If successful, this action will have unapplied any radius restriction, 
//so we need to notify the control, so it can reset its display.

IF AncestorReturnValue = SUCCESS THEN
	uo_Radius.of_Unapplied ( )
END IF

RETURN AncestorReturnValue
end event

event ue_refresh;//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Dispatch, "E" ) < 0 THEN
	return 1
else
	call super:: ue_refresh
	return AncestorReturnValue
end if


end event

event ue_selectview;//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Dispatch, "E" ) < 0 THEN
	//do nothing
else
	call super:: ue_selectview
end if


end event

type uo_radius from u_radius within w_equipmentsummary
integer x = 27
integer y = 28
integer taborder = 20
boolean bringtotop = true
end type

on uo_radius.create
call u_radius::create
end on

on uo_radius.destroy
call u_radius::destroy
end on

event constructor;This.of_Set_Target ( dw_EquipmentList, "CurrentEvent_PCM", "PCM!" )
end event

type cb_1 from u_cb within w_equipmentsummary
integer x = 2638
integer y = 44
integer width = 155
integer taborder = 30
boolean bringtotop = true
string text = "&Pwr"
end type

event clicked;dw_EquipmentList.Event ue_SetCategoryFilter ( n_cst_Constants.ci_EquipmentCategory_PowerUnits )


end event

type cb_2 from u_cb within w_equipmentsummary
integer x = 2807
integer y = 44
integer width = 155
integer taborder = 40
boolean bringtotop = true
string text = "&Trlr"
end type

event clicked;dw_EquipmentList.Event ue_SetCategoryFilter ( n_cst_Constants.ci_EquipmentCategory_TrailerChassis )

end event

type cb_3 from u_cb within w_equipmentsummary
integer x = 2976
integer y = 44
integer width = 155
integer taborder = 50
boolean bringtotop = true
string text = "&Cntn"
end type

event clicked;dw_EquipmentList.Event ue_SetCategoryFilter ( n_cst_Constants.ci_EquipmentCategory_Containers )

end event

type cb_4 from u_cb within w_equipmentsummary
integer x = 3145
integer y = 44
integer width = 155
integer taborder = 60
boolean bringtotop = true
string text = "&All"
end type

event clicked;dw_EquipmentList.Event ue_SetCategoryFilter ( n_cst_Constants.ci_EquipmentCategory_All )

end event

type cb_refresh from commandbutton within w_equipmentsummary
integer x = 3314
integer y = 44
integer width = 247
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Refresh"
end type

event clicked;dw_equipmentlist.Event ue_refresh()
end event

