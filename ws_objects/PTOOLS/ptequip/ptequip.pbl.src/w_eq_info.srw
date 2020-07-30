$PBExportHeader$w_eq_info.srw
forward
global type w_eq_info from w_eq_base
end type
type cbx_active from checkbox within w_eq_info
end type
end forward

global type w_eq_info from w_eq_base
integer width = 2510
integer height = 2092
string menuname = "m_sheets"
cbx_active cbx_active
end type
global w_eq_info w_eq_info

type variables
protected:
boolean ib_winisclosing
n_cst_toolmenu_manager inv_cst_toolmenu_manager
integer ii_company_height
integer ii_outside_height

//This will be set to the Eq_Ref protect string from the 
//datawindow object.  This column is force protected
//for edit of owned equipment.
String	is_InitialRefProtect

//This will be set to the Eq_Ref background string from the 
//datawindow object.  This column is force protected
//for edit of owned equipment.
String	is_InitialRefBackground

end variables

forward prototypes
protected function integer wf_create_toolmenu ()
protected subroutine wf_select ()
protected subroutine wf_new ()
public subroutine wf_process_request (string as_request)
protected function integer wf_retrieve (long al_id)
protected subroutine wf_history_report (string as_reporttype)
public function integer wf_setnewshipment ()
end prototypes

protected function integer wf_create_toolmenu ();n_cst_LicenseManager	lnv_LicenseManager
s_toolmenu lstr_toolmenu

if isvalid(inv_cst_toolmenu_manager) then return 0

inv_cst_toolmenu_manager = create n_cst_toolmenu_manager
inv_cst_toolmenu_manager.of_set_parent(this)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_toolmenu_manager.of_add_standard("SAVE!")

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "NEW!"
lstr_toolmenu.s_toolbutton_picture = "eqnew.bmp"
//lstr_toolmenu.s_toolbutton_text = "NEW (CO EQ)"
//lstr_toolmenu.s_menuitem_text = "&New (Co. Eq.)"
lstr_toolmenu.s_toolbutton_text = "NEW CO EQ"
lstr_toolmenu.s_menuitem_text = "&New Company Equipment"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "SELECT!"
lstr_toolmenu.s_toolbutton_picture = "list.bmp"
lstr_toolmenu.s_toolbutton_text = "SELECT LIST"
lstr_toolmenu.s_menuitem_text = "Selection &List"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_Toolmenu_Manager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "HISTORYREPORT!"
lstr_toolmenu.s_menuitem_text = "Equipment &History Report"
inv_cst_Toolmenu_Manager.of_add_toolmenu(lstr_toolmenu)

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_FuelTax ) THEN

	inv_cst_Toolmenu_Manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "STATEBREAKDOWN!"
	lstr_toolmenu.s_menuitem_text = "State &Breakdown Report"
	inv_cst_Toolmenu_Manager.of_add_toolmenu(lstr_toolmenu)

	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "FUELTAX!"
	lstr_toolmenu.s_menuitem_text = "Prepare Fuel Ta&x Data"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

END IF

inv_cst_toolmenu_manager.of_set_target_menu(m_sheets.m_current)

return 1
end function

protected subroutine wf_select ();long ll_selection

if wf_save_if_needed("CHANGE_SELECTION!") = -1 then return

g_tempstr = "ANYEQ200"
openwithparm(w_equip_select, null_ds)
ll_selection = message.doubleparm

if ll_selection > 0 then wf_retrieve(ll_selection)
end subroutine

protected subroutine wf_new ();n_cst_LicenseManager	lnv_LicenseManager

IF Left ( lnv_LicenseManager.of_GetLicensedCompany ( ), 3 ) = "S&J" THEN

	CHOOSE CASE gnv_App.of_GetUserId ( )

	CASE "SAM", "BARBARA", "MAL", "PTADMIN"
		//ids are ok.  proceed.

	CASE ELSE
		MessageBox ( "Add New Company Equipment", "You are not authorized to perform this "+&
			"procedure." )
		RETURN

	END CHOOSE

END IF

if wf_save_if_needed("NEW!") = 1 then wf_retrieve(0)
end subroutine

public subroutine wf_process_request (string as_request);choose case as_request
case "SAVE!"
	This.wf_save_if_needed("SAVE_REQUEST!")
	//if the user saves without closing the window 
	//then we need to initialize the tabpages
	long	ll_eqid
	if dw_basics.rowcount() > 0 then
		ll_eqid = dw_basics.object.eq_id[1]
	end if
	tab_1.of_Initialize(ll_eqid)

case "NEW!"
	This.wf_new()
case "SELECT!"
	This.wf_select()
case "HISTORYREPORT!"
	This.wf_History_Report ( appeon_constant.cs_context_HistoryReport )
case "STATEBREAKDOWN!"
	This.wf_History_Report ( appeon_constant.cs_context_StateBreakdown )
case "FUELTAX!"
	This.wf_History_Report ( appeon_constant.cs_context_FuelTax )
end choose
end subroutine

protected function integer wf_retrieve (long al_id);//Note: al_id = Null or al_Id = 0 is interpreted as a request for new company equipment.

Boolean	lb_New		//Set to true if we're creating new equipment.
Boolean	lb_Outside	//Set to true if the equipment retrieved is outside equipment.
Boolean	lb_ProtectRef	//Flag if we should force protect ref field.
long	ll_shipid
n_cst_Privileges	lnv_Privileges
tab_1.of_Retrieve(al_id)
tab_1.of_Initialize(al_id)
if isnull(al_id) or al_id = 0 then
	//Create a new piece of company equipment.
	lb_New = TRUE
	dw_basics.reset()
	tab_1.tabpage_lease.dw_1.reset()
	dw_basics.insertrow(0)
	dw_basics.object.eq_id[1] = al_id
	if al_id = 0 then
		dw_basics.object.eq_status[1] = "K"
		dw_basics.object.eq_outside[1] = "F"
	end if
	cbx_Active.Visible = FALSE

	
	tab_1.enabled=true
	tab_1.tabpage_lease.dw_equipment.BringToTop = TRUE
	tab_1.tabpage_lease.st_2.BringToTop = TRUE
	tab_1.tabpage_lease.st_1.BringToTop = TRUE
	tab_1.event ue_typechanged(dw_basics.object.eq_type[1])

else
	if dw_basics.retrieve(al_id) <> 1 then goto rollitback
	if tab_1.tabpage_lease.dw_1.retrieve(al_id) = -1 then goto rollitback
	commit ;
	//nwl - bad approach but need to get this done
	tab_1.tabpage_extended.dw_extended.of_setaxle(dw_basics.object.eq_axles[1])
	tab_1.tabpage_extended.dw_extended.of_setnote(dw_basics.object.notes[1])
	tab_1.tabpage_dimensions.dw_1.of_setlength(dw_basics.object.eq_length[1])
	tab_1.tabpage_dimensions.dw_1.of_setwidth(dw_basics.object.eq_height[1])
	tab_1.tabpage_extras.dw_1.of_setair(dw_basics.object.eq_air[1])
	cbx_Active.Visible = TRUE
	
	tab_1.of_Retrieve(al_id)
	tab_1.of_Initialize(al_id)
	tab_1.enabled=true
	tab_1.tabpage_lease.dw_equipment.BringToTop = TRUE
	tab_1.tabpage_lease.st_2.BringToTop = TRUE
	tab_1.tabpage_lease.st_1.BringToTop = TRUE
	tab_1.event ue_typechanged(dw_basics.object.eq_type[1])

end if

if dw_basics.object.eq_status[1] = "K" then cbx_active.checked = true &
	else cbx_active.checked = false
IF dw_basics.object.eq_outside[1] = 'T' THEN
//if tab_1.tabpage_lease.dw_1.rowcount() > 0 then
	lb_Outside = TRUE
	tab_1.tabpage_lease.visible = true
	ll_ShipID = tab_1.tabpage_lease.dw_1.Object.Shipment [ 1 ] 
	
	IF ll_ShipID > 0 THEN
		tab_1.tabpage_lease.of_SetNewShipment ( ll_ShipID ) 
		tab_1.tabpage_lease.dw_Equipment.SetFilter ( "eq_id <> " + String ( dw_basics.object.eq_id [ 1 ] )   )
		tab_1.tabpage_lease.dw_Equipment.Filter ( )
	END IF
	

//	this.height = ii_outside_height
else
	tab_1.tabpage_lease.visible = false
//	this.height = ii_company_height
end if


//Determine whether the equipment ref column should be unconditionally protected.

IF lb_Outside OR lb_New THEN
	lb_ProtectRef = FALSE
ELSEIF lnv_Privileges.of_HasSysAdminRights ( ) THEN
	lb_ProtectRef = FALSE
ELSE
	lb_ProtectRef = TRUE
END IF


//If the field should be unconditionally protected, protect it.  Otherwise, set
//the conditional protect expression native to the datawindow object.

IF lb_ProtectRef THEN
	dw_Basics.Object.eq_Ref.Protect = "1"
	dw_Basics.Object.eq_Ref.Background.Color = n_cst_Constants.cs_Color_Protected
ELSE
	dw_Basics.Object.eq_Ref.Protect = is_InitialRefProtect
	dw_Basics.Object.eq_Ref.Background.Color = is_InitialRefBackground
END IF

dw_basics.setfocus()

IF lb_Outside THEN
	tab_1.tabpage_lease.visible=true
	tab_1.Selecttab('tabpage_lease')
ELSE
	tab_1.tabpage_lease.visible=false
	tab_1.Selecttab('tabpage_extended')
END IF

return 1

rollitback:
rollback ;
messagebox("Equipment Information", "Could not retrieve requested information.~n~n "+&
	"Window will close.", exclamation!)
ib_winisclosing = true
close(this)
return -1
end function

protected subroutine wf_history_report (string as_reporttype);n_cst_bso_fuelTax lnv_FuelTax
long ll_subject
String	ls_MessageHeader

CHOOSE CASE as_ReportType

CASE appeon_constant.cs_context_HistoryReport
	ls_MessageHeader = "Equipment History Report"

CASE appeon_constant.cs_context_FuelTax
	ls_MessageHeader = "Fuel Tax File Export"

CASE appeon_constant.cs_context_StateBreakDown
	ls_MessageHeader = "State Breakdown Report"

CASE ELSE  //Unexpected ReportType Value
	ls_MessageHeader = "Prepare Report"

END CHOOSE


ll_subject = This.wf_subject()

choose case ll_subject
case is > 0
	
	lnv_FuelTax = create n_cst_bso_FuelTax
	lnv_FuelTax.of_process_report("EQUIPMENT!", ll_subject , as_ReportType)
	destroy lnv_FuelTax
case 0
	messagebox(ls_MessageHeader, "The report is not available for "+&
		"unsaved equipment.")
case else
	messagebox(ls_MessageHeader, "Please select a piece of equipment first.")
end choose
end subroutine

public function integer wf_setnewshipment ();

tab_1.tabpage_lease.dw_1.SetItem ( tab_1.tabpage_lease.dw_1.GetRow ( ) , "Shipment" , il_ShipmentNumber)
Event ue_ClearSearch ( )

RETURN 1 


end function

on w_eq_info.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.cbx_active=create cbx_active
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_active
end on

on w_eq_info.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_active)
end on

event open;long ll_id, ll_toolbutton_x, ll_toolbutton_y
n_cst_Numerical	lnv_Numerical

//Modified on 2-1-07 by dan to handle n_cst_msg as parm
n_cst_msg lnv_msg
s_parm	lstr_parm

IF isValid( message.powerobjectparm ) THEN
	IF message.powerobjectparm.classname( ) = "n_cst_msg" THEN
		lnv_msg = message.powerobjectparm
		IF lnv_msg.of_get_parm( "SHIPMENT", lstr_parm )	> 0 THEN
			inv_shipment = lstr_parm.ia_value
		END IF
		
		IF lnv_msg.of_get_parm( "ID", lstr_parm )	> 0 THEN
			ll_id = lstr_parm.ia_value
		END IF
	ELSE
		ll_id = message.doubleparm		//maintain old
	END IF
ELSE
	ll_id = message.doubleparm			//maintain old
END IF
//////////////////////


gf_mask_menu(m_sheets)

this.x = 1
this.y = 1

if wf_create_toolmenu() = -1 then
	//Error processing??
end if

ii_Outside_Height = This.Height + 33

//if inv_cst_toolmenu_manager.of_get_next_position(ll_toolbutton_x, ll_toolbutton_y) = 1 then
//	ii_company_height = ll_toolbutton_y + 150
//else
//	ii_company_height = ii_outside_height
//end if
ii_company_height = 1992

//dw_basics.settransobject(sqlca)
//dw_outside.settransobject(sqlca)

if lnv_Numerical.of_IsNullOrNotPos ( ll_id ) then setnull(ll_id)
wf_retrieve(ll_id)

tab_1.tabpage_lease.dw_equipment.BringToTop = TRUE
tab_1.tabpage_lease.st_2.BringToTop = TRUE
tab_1.tabpage_lease.st_1.BringToTop = TRUE

Long	ll_ShipID

IF tab_1.tabpage_lease.dw_1.RowCount ( ) > 0 THEN
	ll_ShipID = tab_1.tabpage_lease.dw_1.Object.Shipment [ 1 ] 
	
	IF ll_ShipID > 0 THEN
		tab_1.tabpage_lease.dw_equipment.of_retrieveonshipment ( ll_ShipID ) 
		tab_1.tabpage_lease.dw_equipment.SetFilter ( "eq_id <> " + String ( dw_basics.object.eq_id [ 1 ] )   )
		tab_1.tabpage_lease.dw_equipment.Filter ( )
	END IF
	tab_1.SelectTab ( 1 )
ELSE
	tab_1.SelectTab ( 2 )
END IF

n_cst_beo_Equipment2	lnv_Equipment
lnv_Equipment = CREATE n_cst_beo_Equipment2
lnv_Equipment.of_SetSourceID ( ll_id )
n_cst_AlertManager	lnv_AlertManager
lnv_AlertManager = CREATE n_cst_AlertManager
lnv_AlertManager.of_Showalerts( { lnv_Equipment } )
DESTROY ( lnv_Equipment )
DESTROY ( lnv_AlertManager )
end event

event closequery;call super::closequery;if ib_winisclosing then return 0 //forced close

if wf_save_if_needed("CLOSE_WINDOW!") = -1 then return 1
end event

event close;call super::close;
destroy inv_cst_toolmenu_manager
end event

type dw_basics from w_eq_base`dw_basics within w_eq_info
integer x = 334
integer width = 1189
end type

event dw_basics::constructor;call super::constructor;is_InitialRefProtect = This.Object.eq_Ref.Protect
is_InitialRefBackground = This.Object.eq_Ref.Background.Color
end event

type tab_1 from w_eq_base`tab_1 within w_eq_info
integer x = 334
integer taborder = 20
end type

type cbx_active from checkbox within w_eq_info
integer x = 1659
integer y = 36
integer width = 247
integer height = 76
integer taborder = 15
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Active"
boolean automatic = false
end type

event clicked;String	ls_MessageHeader
boolean	lb_Admin
n_cst_Privileges		lnv_Privs

lb_Admin	= lnv_Privs.of_HasAdministrativeRights ( )


ls_MessageHeader = "Equipment Status"

IF gnv_App.of_GetUserId ( ) <> "PTADMIN" AND &
	tab_1.tabpage_lease.dw_1.RowCount ( ) = 0 THEN

	MessageBox ( ls_MessageHeader, "You must log in as PTADMIN in order to perform "+&
		"this procedure for company equipment.~n~nRequest cancelled." )
	RETURN

END IF

if this.checked = false then
//	if messagebox(ls_MessageHeader, "OK to reactivate this piece of equipment?", &
//		question!, okcancel!, 1) = 2 then return
	this.checked = true
	dw_basics.object.eq_status[1] = "K"
else
	
	if tab_1.tabpage_lease.dw_1.rowcount() > 0 then

		IF NOT IsNull ( tab_1.tabpage_lease.dw_1.object.originationdate [1] )  AND &
			NOT IsNull ( tab_1.tabpage_lease.dw_1.object.terminationdate [1] )  THEN		
		
		
			//Termination event is confirmed.  Proceed.
		ELSEIF lb_Admin THEN
			// ok
			
		ELSE 
			messagebox(ls_MessageHeader, "You are not authorized to deactivate a piece of equipment "+&
				"that has not had it's termination event confirmed as completed.~n~n"+&
				"Request cancelled.", exclamation!)
				
			return
			
		end if
	end if

//	if messagebox(ls_MessageHeader, "OK to deactivate this piece of equipment?", &
//		question!, okcancel!, 2) = 2 then return

	this.checked = false
	dw_basics.object.eq_status[1] = "D"

end if
end event

