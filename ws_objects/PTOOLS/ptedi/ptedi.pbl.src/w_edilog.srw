$PBExportHeader$w_edilog.srw
forward
global type w_edilog from w_main
end type
type tab_1 from u_tab_edilog within w_edilog
end type
type tab_1 from u_tab_edilog within w_edilog
end type
type cb_send from commandbutton within w_edilog
end type
type cb_delete from commandbutton within w_edilog
end type
end forward

global type w_edilog from w_main
integer width = 3520
integer height = 2048
string title = "EDI Transaction Log"
string menuname = "m_sheets"
long backcolor = 12632256
event ue_delete ( long ala_id[] )
tab_1 tab_1
cb_send cb_send
cb_delete cb_delete
end type
global w_edilog w_edilog

type variables
n_cst_toolmenu_manager	inv_Toolmenumanager
end variables

forward prototypes
public subroutine wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
end prototypes

event ue_delete(long ala_id[]);long 	ll_ndx, &
		ll_count, &
		ll_found

ll_count = upperbound(ala_id)

for ll_ndx = 1 to ll_count
//	ll_found = dw_1.find('edi_id = ' + string(ala_id[ll_ndx]), 1, dw_1.rowcount())
//	if ll_found > 0 then
//		dw_1.deleterow(ll_found)
//	end if
next
	
	
end event

public subroutine wf_createtoolmenu ();s_toolmenu lstr_toolmenu
n_cst_privileges	lnv_Privileges

if isvalid(inv_ToolmenuManager) then 
	//already created
else
	inv_ToolmenuManager = create n_cst_toolmenu_manager
	inv_ToolmenuManager.of_set_parent(this)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "SEND!"
	lstr_toolmenu.s_menuitem_text = "S&end"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, FALSE, true)
	lstr_toolmenu.s_name = "DELETE!"
	lstr_toolmenu.s_menuitem_text = "&Delete"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)
end if
end subroutine

public subroutine wf_process_request (string as_request);SetPointer(HourGlass!)
long		lla_id[]

u_tabpg_edilog	luo_edilog

CHOOSE CASE as_Request

	CASE "SEND!"

		luo_edilog = tab_1.control[tab_1.SelectedTab]
		luo_EDILog.of_Send()
		luo_EDILog.of_Refresh()
		
	CASE "DELETE!"
		
		luo_edilog = tab_1.control[tab_1.SelectedTab]
		luo_edilog.of_getSelectedId(lla_id)
		luo_edilog.of_delete(lla_id)
	
	
END CHOOSE

end subroutine

on w_edilog.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.tab_1=create tab_1
this.cb_send=create cb_send
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_send
this.Control[iCurrent+3]=this.cb_delete
end on

on w_edilog.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.cb_send)
destroy(this.cb_delete)
end on

event open;call super::open;
long	ll_rowcount, &
		lla_shipid[]

n_cst_msg	lnv_msg
s_parm		lstr_Parm

IF IsValid( Message.PowerObjectParm ) Then 
	If UPPER( Message.PowerObjectParm.ClassName ( ) ) = "N_CST_MSG" Then 
		lnv_msg = Message.PowerObjectParm	
	End If
END IF

//IF lnv_msg.of_Get_Parm ( "SHIPMENTIDS" , lstr_Parm ) <> 0 THEN
//	lla_shipid = lstr_Parm.ia_Value
//	this.of_SetShipment(lla_shipid)
//END IF

tab_1.of_BuildTabPages(lnv_msg)

ib_DisableCloseQuery = TRUE 

gf_Mask_Menu ( m_sheets )
This.wf_CreateToolmenu ( )

of_SetResize(TRUE)
//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_resize.of_SetMinSize(1300, 400)
inv_Resize.of_Register ( tab_1, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( cb_send, 'FixedToRight' )
inv_Resize.of_Register ( cb_delete, 'FixedToRight' )


end event

event close;call super::close;if isvalid(inv_Toolmenumanager) then
	destroy inv_Toolmenumanager
end if
end event

type tab_1 from u_tab_edilog within w_edilog
integer x = 41
integer y = 136
integer width = 3401
integer taborder = 30
integer textsize = -10
string facename = "Arial"
end type

type cb_send from commandbutton within w_edilog
integer x = 2811
integer y = 40
integer width = 297
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Send"
end type

event clicked;PARENT.wf_process_request('SEND!')
end event

type cb_delete from commandbutton within w_edilog
integer x = 3145
integer y = 40
integer width = 297
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;PARENT.wf_process_request('DELETE!')
end event

