$PBExportHeader$w_routemanager.srw
forward
global type w_routemanager from w_sheet
end type
type tab_routemanager from u_tab_routemanager within w_routemanager
end type
type dw_header from datawindow within w_routemanager
end type
type tab_routemanager from u_tab_routemanager within w_routemanager
end type
end forward

global type w_routemanager from w_sheet
int X=14
int Y=16
int Width=3753
int Height=2268
boolean TitleBar=true
string Title="Route Manager"
string MenuName="m_Sheets"
event ue_new ( )
event ue_updateheader ( long al_newrouteid )
event ue_delete ( )
tab_routemanager tab_routemanager
dw_header dw_header
end type
global w_routemanager w_routemanager

type variables
Private:
n_cst_Toolmenu_Manager  inv_ToolmenuManager
Constant Integer ci_tabpage_Route = 1
Constant Integer  ci_tabpage_Company = 2
Constant Integer  ci_tabpage_Equipment = 3
Constant Integer  ci_tabpage_Zones = 4

datastore ids_Join_Route_Company
datastore ids_Join_Route_Equipment
datastore ids_Join_Route_Zones

long il_CurrentRouteId
boolean ib_JoinRouteCompanyCached
boolean ib_JoinRouteEquipmentCached
string is_OriginalCompanySelect
string is_OriginalEquipmentSelect
String is_OriginalZoneSelect
end variables

forward prototypes
public function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
private function integer wf_getjoincompanylist (long al_routeid, ref long ala_id[])
private function integer wf_getjoinequipmentlist (long al_routeid, ref long ala_id[])
private function integer wf_removecompany (long al_coid)
private function integer wf_addequipment (long al_equipid)
private function integer wf_removeequipment (long al_equipid)
private function integer wf_getjoinzonelist (long al_routeid, ref string asa_id[])
private function integer wf_addcompany (long al_coid)
private function integer wf_addzone (String as_Zone)
private function integer wf_removezone (string as_zone)
end prototypes

event ue_new;long ll_Row

CHOOSE CASE tab_routemanager.SelectedTab

CASE ci_tabpage_Route
	ll_Row = tab_routemanager.tabpage_Route.dw_Route.Event pfc_AddRow ( )
	tab_routemanager.tabpage_Route.dw_Route.Post SetFocus ( )
	tab_routemanager.tabpage_Route.dw_Route.ScrollToRow ( ll_Row )
	
CASE ci_tabpage_Company
	tab_routemanager.tabpage_Company.dw_companyinfo.Event Post pfc_AddRow ( )
	tab_routemanager.tabpage_Company.dw_companyinfo.Post SetFocus ( )
	
CASE Ci_tabpage_Equipment
	tab_routemanager.tabpage_Equipment.dw_EquipmentInfo.Event Post pfc_AddRow ( )
	tab_routemanager.tabpage_Equipment.dw_EquipmentInfo.Post SetFocus ( )

CASE Ci_tabpage_Zones
	tab_routemanager.tabpage_Zones.dw_Zones.Event Post pfc_AddRow ( )
	tab_routemanager.tabpage_Zones.dw_Zones.Post SetFocus ( )


END CHOOSE

end event

event ue_updateheader;long	ll_FoundRow


ll_FoundRow = tab_routemanager.Tabpage_Route.dw_Route.Find ( "id = " + String ( al_newrouteid )  , 1, tab_routemanager.TabPage_Route.dw_Route.RowCount ( ) )

IF dw_header.RowCount( ) = 1 AND ll_FoundRow > 0 THEN
	
	dw_header.Object.RouteNumber[1] = String (tab_routemanager.Tabpage_Route.dw_Route.object.RouteNumber[ll_FoundRow] )
	dw_header.object.Type[1] = tab_routemanager.Tabpage_Route.dw_Route.object.Type[ll_FoundRow]
	il_currentrouteid = al_newrouteid
	ib_JoinRouteCompanyCached = FALSE
	ib_JoinRouteEquipmentCached = FALSE
	
END IF

end event

event ue_delete;CHOOSE CASE tab_routemanager.SelectedTab

CASE ci_tabpage_Route
	tab_routemanager.tabpage_Route.dw_Route.Event Post pfc_DeleteRow ( )
	
CASE ci_tabpage_Company
	tab_routemanager.tabpage_Company.dw_companyinfo.Event Post pfc_DeleteRow ( )

CASE Ci_tabpage_Equipment
	tab_routemanager.tabpage_Equipment.dw_EquipmentInfo.Event Post pfc_DeleteRow ( )

CASE Ci_tabpage_Zones
	tab_routemanager.tabpage_Zones.dw_Zones.Event Post pfc_DeleteRow ( )


END CHOOSE

end event

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu
n_cst_privileges	lnv_Privileges

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("SAVE!")

//inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "GOTO!"
//lstr_toolmenu.s_toolbutton_picture = "list.bmp"
//lstr_toolmenu.s_toolbutton_text = "GO TO..."
//lstr_toolmenu.s_menuitem_text = "&Go To..."
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "NEW!"
lstr_toolmenu.s_toolbutton_picture = "gridnew1.bmp"
lstr_toolmenu.s_toolbutton_text = "ADD"
lstr_toolmenu.s_menuitem_text = "&Add"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "DELETE!"
lstr_toolmenu.s_toolbutton_picture = "griddel1.bmp"
lstr_toolmenu.s_toolbutton_text = "REMOVE"
lstr_toolmenu.s_menuitem_text = "&Remove"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_add_standard("DIVIDER!")
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "CLOSETRANSACTION!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "CLOSE TRNS."
//lstr_toolmenu.s_menuitem_text = "Clos&e Transaction"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "CLOSEBATCH!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "CLOSE TRNS."
//lstr_toolmenu.s_menuitem_text = "Close Ba&tch "
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "PRINTTRANSACTION!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
//lstr_toolmenu.s_menuitem_text = "&Print Transaction"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "PRINTBATCH!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
//lstr_toolmenu.s_menuitem_text = "P&rint Batch"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "EXPORTBATCH!"
////lstr_toolmenu.s_toolbutton_picture = "export.bmp"
////lstr_toolmenu.s_toolbutton_text = "Export Batch"
//lstr_toolmenu.s_menuitem_text = "E&xport Batch"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//IF lnv_Privileges.of_HasSysAdminRights ( ) THEN
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//	lstr_toolmenu.s_name = "MARKBATCHED!"
//	//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
//	//lstr_toolmenu.s_toolbutton_text = "Export Batch"
//	lstr_toolmenu.s_menuitem_text = "Mark as &Batched"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//	
//	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//	lstr_toolmenu.s_name = "MARKUNBATCHED!"
//	//lstr_toolmenu.s_toolbutton_picture = "export.bmp"
//	//lstr_toolmenu.s_toolbutton_text = "Export Batch"
//	lstr_toolmenu.s_menuitem_text = "Mar&k as Unbatched"
//	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//END IF
//
//
//inv_ToolmenuManager.of_add_standard("DIVIDER!")
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "AUTOASSIGN!"
//lstr_toolmenu.s_toolbutton_picture = "lbolt1.bmp"
//lstr_toolmenu.s_toolbutton_text = "AUTOASSIGN"
//lstr_toolmenu.s_menuitem_text = "Aut&o-Assign"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "ASSIGN!"
//lstr_toolmenu.s_toolbutton_picture = "brokassn.bmp"
//lstr_toolmenu.s_toolbutton_text = "ASSIGN"
//lstr_toolmenu.s_menuitem_text = "&Assign"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "UNASSIGN!"
//lstr_toolmenu.s_toolbutton_picture = "brokunas.bmp"
//lstr_toolmenu.s_toolbutton_text = "UNASSIGN"
//lstr_toolmenu.s_menuitem_text = "&Unassign"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//
//inv_ToolmenuManager.of_add_standard("DIVIDER!")
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "AMOUNTTEMPLATES!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
//lstr_toolmenu.s_menuitem_text = "Pa&yables Setup"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
//lstr_toolmenu.s_name = "AUTOGENERATE!"
////lstr_toolmenu.s_toolbutton_picture = "??"
////lstr_toolmenu.s_toolbutton_text = "PRINT TRNS."
//lstr_toolmenu.s_menuitem_text = "Auto-Generate Settle&ment"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "ITINERARY!"
//lstr_toolmenu.s_toolbutton_picture = "itin.bmp"
//lstr_toolmenu.s_toolbutton_text = "ITINERARY"
//lstr_toolmenu.s_menuitem_text = "&Itinerary (for Selected Item)"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);SetPointer(HourGlass!)



CHOOSE CASE as_Request

CASE "SAVE!"
	PostEvent ( "pfc_Save" )
	
	
CASE "NEW!"	
	PostEvent ( "ue_new" )
	
	
CASE "DELETE!"
	PostEvent ( "ue_delete" )

	

END CHOOSE
end subroutine

private function integer wf_getjoincompanylist (long al_routeid, ref long ala_id[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  wf_GetJoinCompanyList
//
//	Access:  private
//
//	Arguments:  al_RouteId	value
//					ala_Id[]	value
//
// Returns:		integer
//
//				   number of ids in array
//
//	Description:	Filter ids_join_route_company by routeid and populate
//						array with company ids. 
//
// Written by: Norm LeBlanc
// 		Date: 9/29/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

long	ll_Ndx, &
		ll_RowCount
		
integer	li_RetVal

li_RetVal = ids_Join_Route_Company.SetFilter( "RouteId = " + string ( al_routeid ) )
li_RetVal = ids_Join_Route_Company.Filter( )

//get company ids from join table
ll_RowCount = ids_Join_Route_Company.RowCount()

FOR ll_Ndx = 1 to ll_RowCount
	ala_id [ ll_ndx ] = ids_Join_Route_Company.Object.CompanyId[ll_ndx]
NEXT

Return ll_RowCount
end function

private function integer wf_getjoinequipmentlist (long al_routeid, ref long ala_id[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  wf_GetJoinCompanyList
//
//	Access:  private
//
//	Arguments:  al_RouteId	value
//					ala_Id[]	value
//
// Returns:		integer
//
//				   number of ids in array
//
//	Description:	Filter ids_join_route_equipment by routeid and populate
//						array with equipment ids. 
//
// Written by: Norm LeBlanc
// 		Date: 9/29/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

long	ll_Ndx, &
		ll_RowCount

ids_Join_Route_Equipment.SetFilter( "RouteId = " + string ( al_routeid ))
ids_Join_Route_Equipment.Filter( )

//get company ids from join table
ll_RowCount = ids_Join_Route_Equipment.RowCount()

FOR ll_Ndx = 1 to ll_RowCount
	ala_id [ ll_ndx ] = ids_Join_Route_Equipment.Object.EquipmentId[ll_ndx]
NEXT

Return ll_RowCount
end function

private function integer wf_removecompany (long al_coid);// returns 1, success  -1 , failure

Long		ll_FoundRow
string	ls_FindString
Int		li_Return = -1

ls_FindString = "RouteId = " + string (il_currentrouteid) + " and CompanyId = " + String ( al_CoID ) 
ll_FoundRow = ids_Join_Route_Company.Find ( ls_FindString, 1, ids_Join_Route_Company.RowCount ( ) ) 
IF ll_FoundRow > 0 THEN
	ids_Join_Route_Company.DeleteRow ( ll_FoundRow )
	li_Return = 1
END IF

RETURN li_Return 
end function

private function integer wf_addequipment (long al_equipid);Long	ll_Row

ll_Row = ids_join_route_equipment.InsertRow (0)
IF ll_Row > 0 THEN
	ids_Join_Route_Equipment.Object.RouteId[ll_Row] = il_currentrouteid
	ids_Join_Route_Equipment.Object.Equipmentid[ll_Row] = al_equipid
END IF

RETURN 1
end function

private function integer wf_removeequipment (long al_equipid);// returns 1, success  -1 , failure

Long		ll_FoundRow
string	ls_FindString
Int		li_Return = -1

ls_FindString = "RouteID = " + string (il_currentrouteid) + " and EquipmentId = " + String ( al_equipid )
ll_FoundRow = ids_Join_Route_Equipment.Find (ls_FindString, 1, ids_Join_Route_Equipment.RowCount ( ) ) 
IF ll_FoundRow > 0 THEN
	ids_Join_Route_Equipment.DeleteRow ( ll_FoundRow )
	li_Return = 1
END IF

RETURN li_Return 
end function

private function integer wf_getjoinzonelist (long al_routeid, ref string asa_id[]);
SetPointer(HourGlass!)

long	ll_Ndx, &
		ll_RowCount
		
integer	li_RetVal

li_RetVal = ids_join_route_zones.SetFilter( "RouteId = " + string ( al_routeid ) )
li_RetVal = ids_join_route_zones.Filter( )

//get company ids from join table
ll_RowCount = ids_join_route_zones.RowCount()

FOR ll_Ndx = 1 to ll_RowCount
	asa_id [ ll_ndx ] = ids_join_route_zones.Object.ZoneName[ll_ndx]
NEXT

Return ll_RowCount
end function

private function integer wf_addcompany (long al_coid);Long	ll_Row

ll_Row = ids_join_route_company.InsertRow (0)
IF ll_Row > 0 THEN
	ids_Join_Route_Company.Object.RouteId[ll_Row] = il_currentrouteid
	ids_Join_Route_Company.Object.Companyid[ll_Row] = al_CoID
END IF

RETURN 1
end function

private function integer wf_addzone (String as_Zone);Long	ll_Row

ll_Row = ids_join_route_Zones.InsertRow (0)
IF ll_Row > 0 THEN
	ids_join_route_Zones.Object.RouteId[ll_Row] = il_currentrouteid
	ids_join_route_Zones.Object.ZoneName[ll_Row] = as_Zone
END IF

RETURN 1
end function

private function integer wf_removezone (string as_zone);// returns 1, success  -1 , failure

Long		ll_FoundRow
string	ls_FindString
Int		li_Return = -1

ls_FindString = "RouteId = " + string (il_currentrouteid) + " and ZoneName = '" + as_Zone +"'"
ll_FoundRow = ids_Join_Route_Zones.Find ( ls_FindString, 1, ids_Join_Route_Zones.RowCount ( ) ) 
IF ll_FoundRow > 0 THEN
	ids_Join_Route_Zones.DeleteRow ( ll_FoundRow )
	li_Return = 1
END IF

RETURN li_Return 
end function

on w_routemanager.create
int iCurrent
call super::create
if this.MenuName = "m_Sheets" then this.MenuID = create m_Sheets
this.tab_routemanager=create tab_routemanager
this.dw_header=create dw_header
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_routemanager
this.Control[iCurrent+2]=this.dw_header
end on

on w_routemanager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_routemanager)
destroy(this.dw_header)
end on

event open;call super::open;powerobject lpo_UpdateObjects []

gf_Mask_Menu ( m_Sheets )
This.wf_CreateToolmenu ( )


n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasAdministrativeRights ( ) = TRUE THEN
	//User is authorized.
ELSE
	MessageBox ( This.Title, lnv_Privileges.of_GetRestrictMessage ( ) )
	ib_DisableCloseQuery = TRUE
	Close ( This )
	RETURN
END IF


//Set size so that proper alignment will be kept when opening as layered (full screen)
of_SetResize(TRUE)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (tab_routemanager, 'ScaleToRight&Bottom')

dw_header.InsertRow (0)

ids_Join_Route_Company = CREATE datastore
ids_Join_Route_Company.Dataobject = "d_Join_Route_Company"
ids_Join_Route_Company.SetTransObject(SQLCA)
ids_Join_Route_Company.Retrieve()
is_OriginalCompanySelect = tab_routemanager.tabpage_Company.dw_companyinfo.Object.Datawindow.Table.Select

ids_Join_Route_Equipment = CREATE datastore
ids_Join_Route_Equipment.dataobject = "d_Join_Route_Equipment"
ids_Join_Route_Equipment.SetTransObject(SQLCA)
ids_Join_Route_Equipment.Retrieve()
is_OriginalEquipmentSelect = tab_routemanager.tabpage_Equipment.dw_equipmentinfo.Object.Datawindow.Table.Select

ids_Join_Route_Zones = CREATE datastore
ids_Join_Route_Zones.dataobject = "d_Join_Route_Zones"
ids_Join_Route_Zones.SetTransObject(SQLCA)
ids_Join_Route_Zones.Retrieve()
is_OriginalZoneSelect = tab_routemanager.tabpage_Zones.dw_Zones.Object.Datawindow.Table.Select



lpo_UpdateObjects[1] = tab_routemanager.tabpage_Route.dw_route
lpo_UpdateObjects[2] = ids_join_route_company
lpo_UpdateObjects[3] = ids_join_route_equipment
lpo_UpdateObjects[4] = ids_Join_Route_Zones
This.of_SetUpdateObjects ( lpo_UpdateObjects )

end event

event close;call super::close;//Extending ancestor

DESTROY inv_ToolmenuManager
DESTROY ids_Join_Route_Company
DESTROY ids_Join_Route_Equipment
DESTROY ids_Join_Route_Zones
RETURN AncestorReturnValue
end event

event pfc_save;call super::pfc_save;IF AncestorReturnValue = 1 THEN
	COMMIT ;
END IF

RETURN AncestorReturnValue
end event

type tab_routemanager from u_tab_routemanager within w_routemanager
int X=325
int Y=220
int Width=3369
int Height=1848
int TabOrder=10
boolean BringToTop=true
end type

event selectionchanged;SetPointer(HourGlass!)
	
long	ll_RouteId, & 
		lla_id[]
		
integer	il_Count		
String	lsa_Zones[]
string	ls_SelectList, &
			ls_SelectStatement, &
			ls_WhereClause

n_cst_Sql	lnv_Sql


this.SetRedraw ( false ) 

CHOOSE CASE newindex
		
CASE 1	//	tabpage_Route

	
CASE 2	//	tabpage_Company
	IF NOT ib_JoinRouteCompanyCached THEN
			
		//get company ids from join table
		il_Count = parent.wf_GetJoinCompanyList ( il_currentrouteid, lla_id)
		IF il_Count > 0 THEN
			ls_SelectList = lnv_Sql.of_MakeInClause ( lla_id )
			ls_WhereClause = "WHERE companies.co_id " + ls_SelectList
			tab_routemanager.tabpage_Company.dw_companyinfo.Object.Datawindow.Table.Select = is_originalcompanyselect + ls_WhereClause
			tab_routemanager.tabpage_Company.dw_companyinfo.SetTransObject (SQLCA)
			tab_routemanager.tabpage_Company.dw_companyinfo.Retrieve()
			ib_JoinRouteCompanyCached = TRUE
		ELSE
			tab_routemanager.tabpage_Company.dw_companyinfo.Reset()
		END IF
	
	END IF
	
CASE 3	//	tabpage_Equipment
	IF NOT ib_JoinRouteEquipmentCached THEN
		
		//get equipment ids from join table 
		il_Count = parent.wf_GetJoinEquipmentList ( il_currentrouteid, lla_id)
		IF il_Count > 0 THEN
			ls_SelectList = lnv_Sql.of_MakeInClause ( lla_id )
			ls_WhereClause = "WHERE equipment.Eq_ID " + ls_SelectList 
			tab_routemanager.tabpage_Equipment.dw_equipmentinfo.Object.Datawindow.Table.Select = is_originalequipmentselect + ls_WhereClause
			tab_routemanager.tabpage_Equipment.dw_equipmentinfo.SetTransObject (SQLCA)
			tab_routemanager.tabpage_Equipment.dw_equipmentinfo.Retrieve()
			ib_JoinRouteEquipmentCached = TRUE
		ELSE
			tab_routemanager.tabpage_Equipment.dw_equipmentinfo.Reset()
		END IF
		
	END IF
	
CASE 4	//	tabpage_Zones
	//IF NOT ib_JoinRouteEquipmentCached THEN
		
		//get equipment ids from join table 
		il_Count = parent.wf_GetJoinZoneList ( il_currentrouteid, lsa_Zones)
		IF il_Count > 0 THEN
			ls_SelectList = lnv_Sql.of_MakeInClauseFromStrings ( lsa_Zones )
			ls_WhereClause = "WHERE Name " + ls_SelectList 
			tab_routemanager.tabpage_Zones.dw_Zones.Object.Datawindow.Table.Select = is_originalZoneselect + ls_WhereClause
			tab_routemanager.tabpage_Zones.dw_Zones.SetTransObject (SQLCA)
			tab_routemanager.tabpage_Zones.dw_Zones.Retrieve()
			//ib_JoinRouteEquipmentCached = TRUE
		ELSE
			tab_routemanager.tabpage_Zones.dw_Zones.Reset()
		END IF
		
//	END IF

END CHOOSE

this.SetRedraw ( true ) 

end event

event ue_routechanged;Parent.Event post ue_UpdateHeader (al_newrouteid )
RETURN 1


end event

event ue_companyadded;Parent.wf_AddCompany ( al_companyid )
end event

event ue_companyremoved;Parent.wf_RemoveCompany ( al_coid )
end event

event ue_equipmentadded;Parent.wf_AddEquipment ( al_equipmentid ) 
end event

event ue_equipmentremoved;Parent.wf_RemoveEquipment ( ad_equipmentid ) 
end event

event ue_zoneadded;Return Parent.wf_AddZone ( as_name )
end event

event ue_zoneremoved;Return Parent.wf_RemoveZone ( as_name )
end event

type dw_header from datawindow within w_routemanager
int X=320
int Y=36
int Width=1202
int Height=152
boolean BringToTop=true
string DataObject="d_route_heading"
boolean Border=false
boolean LiveScroll=true
end type

