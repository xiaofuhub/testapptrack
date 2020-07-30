$PBExportHeader$w_communication_manager.srw
forward
global type w_communication_manager from w_sheet
end type
type tab_communication_manager from u_tab_communication_manager within w_communication_manager
end type
type tab_communication_manager from u_tab_communication_manager within w_communication_manager
end type
type uo_radius from u_radius within w_communication_manager
end type
end forward

global type w_communication_manager from w_sheet
integer width = 3547
integer height = 1812
string title = "Communication Device Setup"
string menuname = "m_sheets"
event ue_new ( )
event ue_delete ( )
tab_communication_manager tab_communication_manager
uo_radius uo_radius
end type
global w_communication_manager w_communication_manager

type variables
private:
n_cst_Toolmenu_Manager  inv_ToolmenuManager

Constant Integer  ci_tabpage_Equipment = 1
Constant Integer  ci_tabpage_Employee = 2
end variables

forward prototypes
public function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_Request)
end prototypes

event ue_new;CHOOSE CASE tab_communication_manager.SelectedTab

	CASE ci_tabpage_Employee
		tab_communication_manager.tabpage_Employee.dw_employee.Event pfc_AddRow ( )
		tab_communication_manager.tabpage_Employee.dw_employee.Post SetFocus ( )
	
	CASE ci_tabpage_Equipment
		tab_communication_manager.tabpage_Equipment.dw_equipment.Event pfc_AddRow ( )
		tab_communication_manager.tabpage_Equipment.dw_equipment.Post SetFocus ( )
		
END CHOOSE

	
end event

event ue_delete;CHOOSE CASE tab_communication_manager.SelectedTab

	CASE ci_tabpage_Employee
		tab_communication_manager.tabpage_Employee.dw_employee.Event pfc_DeleteRow ( )
		tab_communication_manager.tabpage_Employee.dw_employee.Post SetFocus ( )
	
	CASE ci_tabpage_Equipment
		tab_communication_manager.tabpage_Equipment.dw_equipment.Event pfc_DeleteRow ( )
		tab_communication_manager.tabpage_Equipment.dw_equipment.Post SetFocus ( )
		
END CHOOSE
end event

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu
n_cst_privileges	lnv_Privileges

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("SAVE!")


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


inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_Request);SetPointer(HourGlass!)



CHOOSE CASE as_Request

CASE "SAVE!"
	PostEvent ( "pfc_Save" )
	
	
CASE "NEW!"	
	PostEvent ( "ue_new" )
	
	
CASE "DELETE!"
	PostEvent ( "ue_delete" )

	

END CHOOSE
end subroutine

on w_communication_manager.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.tab_communication_manager=create tab_communication_manager
this.uo_radius=create uo_radius
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_communication_manager
this.Control[iCurrent+2]=this.uo_radius
end on

on w_communication_manager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_communication_manager)
destroy(this.uo_radius)
end on

event open;call super::open;THIS.wf_CreateToolMenu ( )
//Set size so that proper alignment will be kept when opening as layered (full screen)
of_SetResize(TRUE)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (tab_communication_manager, 'ScaleToRight&Bottom')
inv_resize.of_Register (uo_radius, 'FixedToRight')


tab_communication_manager.tabpage_Equipment.dw_equipment.SetTransObject(SQLCA)
tab_communication_manager.tabpage_Equipment.dw_equipment.Retrieve()



tab_communication_manager.tabpage_Employee.dw_employee.SetTransObject(SQLCA)
tab_communication_manager.tabpage_Employee.dw_employee.Retrieve()
// remove the line below when employee devices are supported
//tab_communication_manager.tabpage_Employee.Visible = FALSE
//tab_communication_manager.SelectedTab = ci_tabpage_equipment



/* uncomment the lines below when employee devices are supported */

//IF isValid ( tab_communication_manager.tabpage_Employee.dw_employee ) THEN
//	tab_communication_manager.tabpage_Employee.dw_employee.SetFocus ( )
//END IF

// remove the lines below when employee devices are supported
IF isValid ( tab_communication_manager.tabpage_Equipment.dw_equipment ) THEN
	tab_communication_manager.tabpage_Equipment.dw_equipment.SetFocus ( )
END IF

uo_radius.of_set_target ( tab_communication_manager.tabpage_Equipment.dw_equipment,"latlong","PCM!")
end event

event close;call super::close;DESTROY inv_ToolmenuManager
end event

event closequery;call super::closequery;//Constant Integer	ALLOW_CLOSE = 0
//Constant Integer	PREVENT_CLOSE = 1
//Int	li_Return
//li_Return = AncestorReturnValue
//
//IF li_Return = ALLOW_CLOSE THEN
//	
//
//	IF tab_communication_manager.tabpage_Equipment.dw_equipment.AcceptText ( ) = -1 THEN
//		li_Return = PREVENT_CLOSE
//	END IF
//
//	IF tab_communication_manager.tabpage_Employee.dw_employee.AcceptText ( ) = -1 THEN
//			li_Return = PREVENT_CLOSE
//	END IF
//	
//END IF
//
//RETURN li_Return
end event

type tab_communication_manager from u_tab_communication_manager within w_communication_manager
integer x = 343
integer y = 212
integer width = 3127
integer height = 1360
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
end type

type uo_radius from u_radius within w_communication_manager
integer x = 914
integer y = 32
integer taborder = 10
boolean bringtotop = true
end type

on uo_radius.destroy
call u_radius::destroy
end on

