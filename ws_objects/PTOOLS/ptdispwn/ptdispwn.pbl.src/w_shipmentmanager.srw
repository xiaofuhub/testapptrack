$PBExportHeader$w_shipmentmanager.srw
forward
global type w_shipmentmanager from w_sheet
end type
type uo_autorate from u_cst_autoratecombined within w_shipmentmanager
end type
type uo_ship_filter from u_ship_filter within w_shipmentmanager
end type
type uo_radius from u_radius_ship within w_shipmentmanager
end type
type ddlb_ship_display from dropdownlistbox within w_shipmentmanager
end type
type st_ship_display from statictext within w_shipmentmanager
end type
type ddlb_shipmentsort from u_ddlb_shipmentsort within w_shipmentmanager
end type
type st_ship_sort from statictext within w_shipmentmanager
end type
type cb_radius from u_cb within w_shipmentmanager
end type
type uo_refresh from u_refresh within w_shipmentmanager
end type
type st_1 from u_st_label within w_shipmentmanager
end type
type dw_shipment from u_dw_shipmentlist within w_shipmentmanager
end type
type st_cachecode from u_st_shipmentcachecode within w_shipmentmanager
end type
type sle_windowtitle from u_sle within w_shipmentmanager
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//Int	si_instance // window State
////end modification Shared Variables by appeon  20070730
end variables

global type w_shipmentmanager from w_sheet
integer width = 4279
integer height = 1536
string title = "Shipment Summary"
string menuname = "m_sheets"
long backcolor = 12632256
event ue_mousemove pbm_ncmousemove
event ue_startautorate ( )
event ue_stopautorate ( )
uo_autorate uo_autorate
uo_ship_filter uo_ship_filter
uo_radius uo_radius
ddlb_ship_display ddlb_ship_display
st_ship_display st_ship_display
ddlb_shipmentsort ddlb_shipmentsort
st_ship_sort st_ship_sort
cb_radius cb_radius
uo_refresh uo_refresh
st_1 st_1
dw_shipment dw_shipment
st_cachecode st_cachecode
sle_windowtitle sle_windowtitle
end type
global w_shipmentmanager w_shipmentmanager

type variables
Protected String	is_PreFilter

Private n_cst_Toolmenu_Manager	inv_ToolmenuManager
Private Boolean	ib_JustOpened = TRUE

//begin modification Shared Variables by appeon  20070730
Int	si_instance // window State
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
private function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
public function integer wf_getinstance ()
end prototypes

event ue_mousemove;IF ypos - THIS.Height  > -200 THEN  // off the bottom of the screen
	IF isValid ( dw_shipment.inv_Mediator ) THEN
		dw_shipment.inv_Mediator.of_ShowDataManager ( )
	END IF
END IF
end event

event ue_startautorate();cb_radius.Enabled = FALSE
uo_radius.Enabled = FALSE
uo_refresh.Enabled = FALSE
uo_ship_filter.Enabled = FALSE
ddlb_ship_display.Enabled = FALSE
ddlb_shipmentsort.Enabled = FALSE
st_Cachecode.Enabled = FALSE
uo_autorate.Visible = TRUE
uo_autorate.of_SetSource( dw_shipment )
uo_autorate.event ue_autorateon( )

end event

event ue_stopautorate();cb_radius.Enabled = TRUE
uo_radius.Enabled = TRUE
uo_refresh.Enabled = TRUE
uo_ship_filter.Enabled = TRUE
st_Cachecode.Enabled = TRUE
ddlb_ship_display.Enabled = TRUE
ddlb_shipmentsort.Enabled = TRUE

uo_autorate.Visible = FALSE



end event

private function integer wf_createtoolmenu ();n_cst_LicenseManager	lnv_LicenseManager
s_toolmenu lstr_toolmenu

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "RADIUS!"
lstr_toolmenu.s_menuitem_text = "&Radius Restriction"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

//inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
//lstr_toolmenu.s_name = "LOADBUILDER!"
//lstr_toolmenu.s_menuitem_text = "&Load Builder"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
//
//inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
//lstr_toolmenu.s_name = "DETAILS_FOR_SELECTED!"
//lstr_toolmenu.s_menuitem_text = "Details (All Selected TMPs)"
//inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) AND pcmm_inst THEN
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "PLOTSTOPS!"
	lstr_toolmenu.s_menuitem_text = "Plot &Unrouted Shipment Events"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
END IF

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AutoRating ) THEN
	
	inv_ToolmenuManager.of_add_standard("DIVIDER!")
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTORATEON!"
	lstr_toolmenu.s_menuitem_text = "Star&t Auto Rate Mode"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTORATENEXT!"
	lstr_toolmenu.s_menuitem_text = "Auto Rate &Next Shipment"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
	inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "AUTORATEOFF!"
	lstr_toolmenu.s_menuitem_text = "Sto&p Auto Rate Mode"
	inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)
	
END IF





inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);CHOOSE CASE as_Request

CASE "RADIUS!"

	This.SetRedraw ( FALSE )

	IF uo_Radius.Visible THEN
		uo_Radius.of_Unapply ( )
		dw_Shipment.Height += 160
		dw_Shipment.Y -= 160
	ELSE
		dw_Shipment.Height -= 160
		dw_Shipment.Y += 160
	END IF

	uo_Radius.Visible = NOT uo_Radius.Visible

	This.SetRedraw ( TRUE )

	IF uo_Radius.Visible THEN
		uo_Radius.gb_StopType.SetFocus ( )
	END IF

//CASE "LOADBUILDER!"
//
//	dw_Shipment.Event ue_SetLoadBuilder ( TRUE )
//
//CASE "DETAILS_FOR_SELECTED!"
//
//	dw_Shipment.Event ue_Details ( )
CASE "PLOTSTOPS!"
	n_cst_EquipmentManager	lnv_EquipmentManager
	w_Map	lw_Map
	s_Mapping	lstr_Mapping
	
	lstr_Mapping.TypeMap = "B"
	OpenWithParm ( lw_Map, lstr_Mapping )
	
	lnv_EquipmentManager.of_DisplayUnroutedStops ( lw_Map )
	
	
CASE "AUTORATEON!"
	THIS.event ue_startautorate( )
	
CASE "AUTORATENEXT!"
	uo_autorate.event ue_next( )
	
CASE "AUTORATEOFF!"
	uo_autorate.event ue_stop( )
	
	
END CHOOSE
end subroutine

public function integer wf_getinstance ();RETURN si_instance
end function

on w_shipmentmanager.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.uo_autorate=create uo_autorate
this.uo_ship_filter=create uo_ship_filter
this.uo_radius=create uo_radius
this.ddlb_ship_display=create ddlb_ship_display
this.st_ship_display=create st_ship_display
this.ddlb_shipmentsort=create ddlb_shipmentsort
this.st_ship_sort=create st_ship_sort
this.cb_radius=create cb_radius
this.uo_refresh=create uo_refresh
this.st_1=create st_1
this.dw_shipment=create dw_shipment
this.st_cachecode=create st_cachecode
this.sle_windowtitle=create sle_windowtitle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_autorate
this.Control[iCurrent+2]=this.uo_ship_filter
this.Control[iCurrent+3]=this.uo_radius
this.Control[iCurrent+4]=this.ddlb_ship_display
this.Control[iCurrent+5]=this.st_ship_display
this.Control[iCurrent+6]=this.ddlb_shipmentsort
this.Control[iCurrent+7]=this.st_ship_sort
this.Control[iCurrent+8]=this.cb_radius
this.Control[iCurrent+9]=this.uo_refresh
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_shipment
this.Control[iCurrent+12]=this.st_cachecode
this.Control[iCurrent+13]=this.sle_windowtitle
end on

on w_shipmentmanager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_autorate)
destroy(this.uo_ship_filter)
destroy(this.uo_radius)
destroy(this.ddlb_ship_display)
destroy(this.st_ship_display)
destroy(this.ddlb_shipmentsort)
destroy(this.st_ship_sort)
destroy(this.cb_radius)
destroy(this.uo_refresh)
destroy(this.st_1)
destroy(this.dw_shipment)
destroy(this.st_cachecode)
destroy(this.sle_windowtitle)
end on

event open;call super::open;//The window is not updateable.  Disable the closequery.
ib_DisableCloseQuery = TRUE

SetPointer ( HourGlass! )
gf_Mask_Menu ( m_Sheets )
This.wf_CreateToolmenu ( )

This.of_SetResize ( TRUE )
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize(1300, 400)
//inv_Resize.of_Register ( tab_Data, "ScaleToRight&Bottom" )
inv_Resize.of_Register ( dw_Shipment, "ScaleToRight&Bottom" )
//inv_Resize.of_Register ( uo_Refresh, "FixedToBottom" )


n_cst_LicenseManager	lnv_LicenseManager
n_cst_ShipmentManager lnv_ShipmentMgr

Boolean	lb_OrderEntry, &
			lb_Brokerage, &
			lb_Dispatch

lb_OrderEntry = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_OrderEntry )
lb_Brokerage = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Brokerage )
lb_Dispatch = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Dispatch )
IF lb_Dispatch OR lb_Brokerage OR lb_OrderEntry THEN
	//One of the necessary modules is licensed.
ELSE
	lnv_LicenseManager.of_DisplayModuleNotice ( "Shipment Summary" )
	Close ( This )
	RETURN AncestorReturnValue
END IF

si_instance ++
THIS.wf_SetWindowstate( TRUE )


end event

event close;call super::close;//Extending Ancestor

//Destroy the ToolMenuManager
DESTROY inv_ToolmenuManager


IF IsValid ( inv_Windowstate ) THEN
	inv_windowstate.of_Savestate( )
	THIS.wf_setwindowstate( FALSE )
END IF
si_instance --


RETURN AncestorReturnValue
end event

event pfc_postopen;uo_Refresh.list_type = "SHIP"
uo_Refresh.setup()
end event

event activate;call super::activate;//Extending Ancestor

//Perform check of ib_JustOpened to prevent activate processing immediately after the window opens.
//The retrieval will have already been triggered elsewhere, in the filter initialization.

IF ib_JustOpened THEN
	ib_JustOpened = FALSE
	this.setredraw(false)
//	DO
//		Yield()
//		//Is dw populated yet ?
//		IF dw_shipment.rowcount() > 0 THEN EXIT
//	LOOP Until dw_shipment.rowcount() > 0
	ddlb_shipmentsort.triggerevent("selectionchanged")
	this.setredraw(true)
ELSE
	//Call ue_CacheRetrieve, so that if any changes have been made outside the window that are already 
	//updated in the cache, those changes will be reflected in the list.  This call does not force a 
	//refresh of the cache or a redisplay of the list if the cache hasn't changed on it's own.
	dw_Shipment.Event ue_CacheRetrieve ( FALSE /*Don't refresh cache*/, FALSE /*Do not force reload*/ )
END IF

RETURN AncestorReturnValue
end event

type uo_autorate from u_cst_autoratecombined within w_shipmentmanager
boolean visible = false
integer x = 3675
integer y = 4
integer width = 539
integer taborder = 20
end type

on uo_autorate.destroy
call u_cst_autoratecombined::destroy
end on

event ue_stop;call super::ue_stop;Parent.event ue_stopautorate( )
end event

type uo_ship_filter from u_ship_filter within w_shipmentmanager
integer x = 9
integer y = 184
integer taborder = 30
boolean bringtotop = true
end type

event constructor;This.Setup ( )
This.Set_Filter ( FALSE /*Don't set global prefs*/ )
end event

on uo_ship_filter.destroy
call u_ship_filter::destroy
end on

event ue_filterchanged;dw_Shipment.of_SetPreFilter ( as_NewFilter )
dw_Shipment.Event ue_CacheRetrieve ( FALSE /*Don't refresh cache*/, TRUE /*Do force reload*/ )
end event

type uo_radius from u_radius_ship within w_shipmentmanager
boolean visible = false
integer x = 5
integer y = 316
integer width = 3438
integer taborder = 60
boolean bringtotop = true
end type

on uo_radius.destroy
call u_radius_ship::destroy
end on

event constructor;//Set target columns 
This.of_SetPickupColumn ( "Origin_Id", "COMPANY!" )
This.of_SetDeliveryColumn ( "Destination_Id", "COMPANY!" )

//Set target dw
This.of_Set_Target ( dw_Shipment )
end event

type ddlb_ship_display from dropdownlistbox within w_shipmentmanager
integer x = 2135
integer y = 188
integer width = 622
integer height = 1500
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Overview","Appointments","Billing Info","Inbound Pending","Inbound Loads","Inbound Returns","Outbound Empties","Outbound Loading","Outbound Ready","One Ways"}
integer accelerator = 112
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Forward the request to the datawindow for handling.
dw_Shipment.of_SetSelectedItem ( This.Text )
dw_Shipment.Event ue_SetView ( This.Text )
end event

event constructor;Any				la_value

String			lsa_ViewList[], &
					ls_setting
Long				ll_Count, &
					ll_Index
					
Integer			li_find					
					
n_cst_Dws		lnv_Dws
n_cst_Settings		lnv_Settings

//Add any custom view definitions to the display option list.

//Get the list.
ll_Count = lnv_Dws.of_GetCustomViewList ( "ShipmentList", lsa_ViewList )

//Add them to the dropdown.

FOR ll_Index = 1 TO ll_Count

	This.AddItem ( lsa_ViewList [ ll_Index ] )

NEXT

//Set the selection, and force the SelectionChanged event, which will 
//trigger setup of the display view.  (SelectionChanged does not get 
//triggered on its own by the SelectItem call)

IF lnv_Settings.of_GetSetting ( 163 , la_Value ) = 1 THEN
	ls_Setting = string(la_value)
	IF isnull(ls_Setting) or len(trim(ls_Setting)) = 0 then
		//no default
	else
		li_find = this.FindItem ( ls_Setting, 0 )
	end if
END IF

if li_find > 0 then
	this.SelectItem ( li_Find )
else
	This.SelectItem ( 1 )
end if

dw_Shipment.of_SetSelectedItem ( This.Text )

This.Event SelectionChanged ( 1 )
end event

event rbuttondown;String	lsa_Parm_Labels[]
Any		laa_Parm_Values[]

w_CustomViewDefinitions	lw_ViewDefs

lsa_Parm_Labels [ 1 ] = "ADD_ITEM"
laa_Parm_Values [ 1 ] = "&Define Custom Views"

CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )

CASE "DEFINE CUSTOM VIEWS"

	OpenSheet ( lw_ViewDefs, gnv_App.of_GetFrame ( ), 0, Layered! )

END CHOOSE
end event

type st_ship_display from statictext within w_shipmentmanager
integer x = 1888
integer y = 204
integer width = 242
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Dis&play:"
boolean focusrectangle = false
end type

type ddlb_shipmentsort from u_ddlb_shipmentsort within w_shipmentmanager
integer x = 3017
integer y = 188
integer taborder = 50
integer accelerator = 115
end type

event ue_processchange;call super::ue_processchange;dw_Shipment.SetSort ( as_Sort )
dw_Shipment.Sort ( )
end event

event selectionchanged;call super::selectionchanged;//CALL Super::selectionchanged
//
//RETURN AncestorReturnValue
end event

type st_ship_sort from statictext within w_shipmentmanager
integer x = 2775
integer y = 204
integer width = 283
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "&Sort By:"
boolean focusrectangle = false
end type

type cb_radius from u_cb within w_shipmentmanager
integer x = 14
integer y = 44
integer width = 626
integer height = 88
integer taborder = 10
string text = "&Radius Restriction..."
end type

event clicked;Parent.wf_Process_Request ( "RADIUS!" )
end event

type uo_refresh from u_refresh within w_shipmentmanager
integer x = 2624
integer y = 44
integer taborder = 80
end type

event ue_refresh;call super::ue_refresh;//If refresh processing was a success, update the display with the results.

IF AncestorReturnValue = 1 THEN

	//Since the refresh attempt has already been made at this point, don't force refresh again, below.
	//Also, if there are no changes between the list we're displaying and what's in the cache,
	//don't force reload.
	dw_Shipment.Event ue_CacheRetrieve ( FALSE /*Don't refresh cache*/, FALSE /*Do not force reload*/ )

END IF

RETURN AncestorReturnValue
end event

on uo_refresh.destroy
call u_refresh::destroy
end on

type st_1 from u_st_label within w_shipmentmanager
integer x = 704
integer y = 56
integer width = 594
boolean bringtotop = true
long backcolor = 12632256
string text = "Name for &Window:"
end type

type dw_shipment from u_dw_shipmentlist within w_shipmentmanager
event ue_mousemove pbm_dwnmousemove
event ue_filterchanged ( )
integer x = 5
integer y = 312
integer width = 4201
integer height = 1024
integer taborder = 70
end type

event ue_mousemove;IF dwo.Name = 'datawindow' THEN
		
		//Screen for dwo's without Band attribute, which would crash
		//Clicked object was not a column header -- Ignore
ELSEIF dwo.Band <> "footer" THEN
	IF isValid ( THIS.inv_Mediator )  THEN
		inv_Mediator.of_HideDataManager ( )
	END IF
END IF
end event

event ue_filterchanged;uo_Radius.of_Unapplied ( )
end event

event ue_cacheretrieve;call super::ue_cacheretrieve;//Extending ancestor

//If we did in fact reload the display, make appropriate display changes in the window to reflect that.

IF AncestorReturnValue >= 0 THEN

	//The display was reloaded (the number of resulting rows is the return value).
	//If the display was not reloaded due to error or lack of need, return value would be -1 or -2

	//Reflect the fact that any radius restriction is now unapplied.
	uo_Radius.of_Unapplied ( )

	//Reflect the time of the last cache refresh on the refresh control.
	uo_Refresh.Display_Time ( )
	
	//Added 3.5.15 BKW
	//Update the cache code display to reflect any cache view selection change.
	st_CacheCode.Event ue_Refresh ( )

END IF

RETURN AncestorReturnValue
end event

event pfc_filterdlg;call super::pfc_filterdlg;//Extending Ancestor

IF AncestorReturnValue = 1 THEN //Filter was modified.
	//If a radius restriction was in effect, we've just bypassed it with our new filter.
	//We need to set the radius control back to "unapplied" mode.  This has no effect
	//if a radius restriction has not been applied.
	uo_Radius.of_Unapplied ( )
END IF

RETURN AncestorReturnValue
end event

type st_cachecode from u_st_shipmentcachecode within w_shipmentmanager
integer x = 2162
integer y = 52
integer width = 443
boolean bringtotop = true
end type

event clicked;n_cst_ShipmentManager	lnv_ShipmentManager

lnv_ShipmentManager.of_SetShipmentCacheCode ( "ASK!" )

uo_Refresh.Event ue_Refresh ( )
end event

type sle_windowtitle from u_sle within w_shipmentmanager
integer x = 1307
integer y = 52
integer width = 832
integer taborder = 20
boolean autohscroll = true
integer accelerator = 119
end type

event modified;String	ls_Title

ls_Title = Trim ( This.Text )

IF Len ( ls_Title ) = 0 THEN
	ls_Title = "Shipment Summary"
END IF

Parent.Title = ls_Title
end event

