$PBExportHeader$w_shiptype_manager.srw
forward
global type w_shiptype_manager from w_sheet
end type
type tab_shiptype_manager from u_tab_shiptype_manager within w_shiptype_manager
end type
type dw_list from u_dw_shiptype_list within w_shiptype_manager
end type
type tab_shiptype_manager from u_tab_shiptype_manager within w_shiptype_manager
end type
end forward

global type w_shiptype_manager from w_sheet
int Width=3314
int Height=2052
boolean TitleBar=true
string Title="Shipment Type / Division Setup"
string MenuName="m_sheets"
tab_shiptype_manager tab_shiptype_manager
dw_list dw_list
end type
global w_shiptype_manager w_shiptype_manager

type variables

n_cst_toolmenu_manager    inv_ToolMenuManager
CONSTANT INT ci_TabPage_Details = 1
CONSTANT INT ci_TabPage_ARMap = 2
CONSTANT INT ci_TabPage_AcctMap = 3

end variables

forward prototypes
public function integer wf_createtoolmenu ()
public function integer wf_process_request (string as_request)
end prototypes

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)
inv_ToolmenuManager.of_add_standard("DIVIDER!")
inv_ToolmenuManager.of_add_standard("SAVE!")




inv_ToolmenuManager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "NEW!"
lstr_toolmenu.s_toolbutton_picture = "gridnew1.bmp"
lstr_toolmenu.s_toolbutton_text = "NEW"
lstr_toolmenu.s_menuitem_text = "&New"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)


inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public function integer wf_process_request (string as_request);SetPointer(HourGlass!)
long 	ll_row
Int	li_TabPage


CHOOSE CASE as_Request

CASE "SAVE!"
	EVENT pfc_Save()
	


CASE "NEW!"

	li_TabPage = tab_ShipType_Manager.selectedTab
	CHOOSE CASE li_TabPage
		CASE ci_tabpage_details
			
			tab_shiptype_manager.Tabpage_ShipType_details.dw_Details.Event pfc_AddRow ( )
			
		CASE ci_tabpage_acctmap
			
			tab_ShipType_Manager.TabPage_AcctMap.dw_acctmap.Event pfc_addRow ()
		
		case ci_TabPage_ARMap 
		
			tab_ShipType_Manager.TabPage_ARMap.dw_1.Event pfc_addRow ()
			
	END CHOOSE

END CHOOSE

Return 1
end function

on w_shiptype_manager.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.tab_shiptype_manager=create tab_shiptype_manager
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_shiptype_manager
this.Control[iCurrent+2]=this.dw_list
end on

on w_shiptype_manager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_shiptype_manager)
destroy(this.dw_list)
end on

event open;call super::open;this.x = 1
this.y = 1

gf_Mask_Menu ( m_Sheets )
This.wf_CreateToolmenu ( )

tab_shiptype_manager.tabpage_shiptype_details.dw_details.sharedata(dw_list)
tab_shiptype_manager.tabpage_shiptype_details.dw_details.SetTransObject ( SQLCA )

tab_shiptype_manager.tabpage_armap.dw_1.retrieve()
tab_shiptype_manager.tabpage_armap.dw_1.sharedata(tab_shiptype_manager.tabpage_acctmap.dw_acctmap)


n_cst_Privileges	lnv_Privileges

IF lnv_Privileges.of_HasSysAdminRights ( ) = FALSE THEN
	MessageBox ( This.Title, lnv_Privileges.of_GetSysAdminMessage ( ) )
	ib_DisableCloseQuery = TRUE
	Close ( This )
END IF


end event

event pfc_postopen;//Give the ShipTypeDetail dw a handle to the list dw.
tab_shiptype_manager.Tabpage_ShipType_details.dw_Details.idw_List = dw_List


//Rick had coded this.  The processing appears to be handled by dw_List.RowFocusChanged,
//so we've commented it out.
//
////Filter the payables to the current type/division.
//
//Long	ll_ID
//
//IF dw_list.RowCount () > 0 THEN 
//	
//	ll_ID = dw_list.object.st_id[1]
//	tab_ShipType_Manager.TabPage_AcctMap.dw_acctmap.of_SetCurrentID (ll_ID  )
//	
//	IF NOT IsNull ( ll_ID )THEN
//	
//		tab_shiptype_manager.tabpage_acctmap.dw_acctmap.of_SetCurrentID ( ll_ID )
//		
//		tab_shiptype_manager.tabpage_acctmap.dw_acctmap.SetFilter( "accountmap_division = " + String ( ll_ID ) )
//		tab_shiptype_manager.tabpage_acctmap.dw_acctmap.Filter()
//	END IF
//END IF



end event

event close;call super::close;IF IsValid ( inv_ToolmenuManager ) THEN
	DESTROY inv_ToolmenuManager
END IF


ib_disableclosequery = TRUE  // this is here to be used by dw_list in the rowfocuschanging event
									 // it is a flag used to prevent multiple validation messages
									 
end event

event pfc_save;call super::pfc_save;IF AncestorReturnValue = 1 THEN
	COMMIT ;
END IF

RETURN AncestorReturnValue
end event

type tab_shiptype_manager from u_tab_shiptype_manager within w_shiptype_manager
int X=347
int Y=456
int Width=2862
int TabOrder=20
boolean BringToTop=true
end type

event selectionchanging;//0  Allow the selection to change
//1  Prevent the selection from changing
Int	li_Rtn

IF tab_ShipType_Manager.TabPage_AcctMap.dw_acctmap.EVENT pfc_Validation ( ) = -1 THEN
	li_Rtn = 1
END IF
if li_rtn = 1 then
	//continue
else
	IF tab_ShipType_Manager.TabPage_ArMap.dw_1.EVENT pfc_Validation ( ) = -1 THEN
		li_Rtn = 1
	END IF	
end if
RETURN li_Rtn
end event

event ue_rowadded;dw_list.ScrollToRow ( al_row )
Return 1
end event

event ue_setredraw;dw_list.SetRedraw ( ab_value )
end event

event ue_getfirstrowonlistpage;Return  Long ( dw_list.Object.DataWindow.FirstRowOnPage )
end event

event ue_scrolllisttorow;dw_List.ScrollToRow ( al_row ) 
end event

event ue_deleterow;integer	il_ret

long	ll_division, &
		ll_id
		
//8.0 issue with sharedata, i'm deleting the row from the primary

if al_row > 0 then
	ll_id = tab_shiptype_manager.tabpage_acctmap.dw_acctmap.object.accountmap_amounttypeid[al_row]
	ll_division = tab_shiptype_manager.tabpage_acctmap.dw_acctmap.object.accountmap_division[al_row]
	il_ret = tab_shiptype_manager.tabpage_armap.dw_1.find("accountmap_amounttypeid = " + string(ll_id) + &
						" and accountmap_division = " + string(ll_division), 1, &
								tab_shiptype_manager.tabpage_armap.dw_1.rowcount())
end if

if il_ret > 0 then
	tab_shiptype_manager.tabpage_armap.dw_1.deleterow(il_ret)
end if

return il_ret
end event

type dw_list from u_dw_shiptype_list within w_shiptype_manager
int X=347
int Y=32
int Width=2455
int Height=380
int TabOrder=10
boolean BringToTop=true
boolean VScrollBar=true
end type

event rowfocuschanged;call super::rowfocuschanged;Long	ll_ID
integer	li_tabpage

if currentrow > 0 then tab_shiptype_manager.tabpage_shiptype_details.dw_details.scrolltorow(currentrow)

This.Post SetRedraw ( TRUE )  //To force redraw of highlight

IF currentRow > 0  THEN
	ll_ID = dw_list.object.st_id[currentrow]
END IF

IF This.RowCount()> 0 AND NOT IsNull ( ll_ID )THEN
	tab_shiptype_manager.tabpage_armap.dw_1.of_SetCurrentID ( ll_ID )
	tab_shiptype_manager.tabpage_acctmap.dw_acctmap.of_SetCurrentID ( ll_ID )
	
	li_TabPage = tab_ShipType_Manager.selectedTab
	CHOOSE CASE li_TabPage
		CASE ci_tabpage_details
			
		case ci_TabPage_ARMap 
			parent.setredraw(false)
			tab_shiptype_manager.tabpage_armap.dw_1.post event ue_filter()
			parent.post setredraw(true)
			
		CASE ci_tabpage_acctmap
			parent.setredraw(false)
			tab_shiptype_manager.tabpage_acctmap.dw_acctmap.post event ue_filter()
			parent.post setredraw(true)
			
	END CHOOSE	
	
END IF

Setpointer (ARROW! )


end event

event constructor;call super::constructor;n_cst_Dws	lnv_Dws

lnv_Dws.of_CreateHighlight ( This )


end event

event rowfocuschanging;call super::rowfocuschanging;Int	li_Rtn

li_Rtn = AncestorReturnValue 

IF li_Rtn = 0 THEN
   IF NOT ib_disableclosequery THEN  // prevents multiple validation messages... set in close script of window
		
		IF tab_ShipType_Manager.TabPage_AcctMap.dw_acctmap.EVENT pfc_Validation ( ) = -1 THEN
			li_Rtn = 1
		END IF
		if li_rtn = 1 then
			//CONTINUE
		ELSE
			IF tab_shiptype_manager.tabpage_armap.dw_1.EVENT pfc_Validation ( ) = -1 THEN
				li_Rtn = 1
			END IF
		end if

	END IF
END IF
RETURN li_Rtn
end event

