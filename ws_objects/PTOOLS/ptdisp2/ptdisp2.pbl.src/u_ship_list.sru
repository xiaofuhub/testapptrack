$PBExportHeader$u_ship_list.sru
forward
global type u_ship_list from UserObject
end type
type ddlb_shipmentsort from u_ddlb_shipmentsort within u_ship_list
end type
type dw_ship_list from datawindow within u_ship_list
end type
type cb_x01 from commandbutton within u_ship_list
end type
type cb_x03 from commandbutton within u_ship_list
end type
type cb_x02 from commandbutton within u_ship_list
end type
type st_ship_sort from statictext within u_ship_list
end type
type st_ship_display from statictext within u_ship_list
end type
type ddlb_ship_display from dropdownlistbox within u_ship_list
end type
type st_ship_ind from statictext within u_ship_list
end type
type st_ships from statictext within u_ship_list
end type
end forward

global type u_ship_list from UserObject
int Width=3607
int Height=852
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
ddlb_shipmentsort ddlb_shipmentsort
dw_ship_list dw_ship_list
cb_x01 cb_x01
cb_x03 cb_x03
cb_x02 cb_x02
st_ship_sort st_ship_sort
st_ship_display st_ship_display
ddlb_ship_display ddlb_ship_display
st_ship_ind st_ship_ind
st_ships st_ships
end type
global u_ship_list u_ship_list

type variables
public:
string button_list, button_set[]
char new_ship_type
window w_par
commandbutton buttons[]
datetime dt_this_updated
u_refresh uo_refresh
u_radius_ship uo_radius_ship

Private:
w_LoadBuilder	iw_LoadBuilder
end variables

forward prototypes
public subroutine reset_range ()
protected subroutine process_buttonclk (integer which_button)
public subroutine ship_details ()
public subroutine duplicate ()
public subroutine new_ship ()
protected subroutine ship_selection ()
public subroutine filter_and_sort ()
public function integer load_from_cache ()
public subroutine set_buttons ()
public function integer setup ()
public subroutine set_list_height ()
private function integer of_getselection (ref long al_row, ref long al_id)
private function long of_getselectedids (ref long ala_ids[])
public subroutine of_details ()
public subroutine of_deliveryreceipts ()
public subroutine of_showloadbuilder ()
private subroutine of_updateloadbuilder ()
end prototypes

public subroutine reset_range ();datawindow dw_for_this
statictext st_for_this
integer firstrow, lastrow, ofrows, ships_in_trip
string new_range

dw_for_this = dw_ship_list
st_for_this = st_ship_ind

firstrow = integer(dw_for_this.describe("datawindow.firstrowonpage"))
lastrow = integer(dw_for_this.describe("datawindow.lastrowonpage"))
ofrows = dw_for_this.rowcount()

new_range = string(firstrow) + " to " + string(lastrow) + " of " + string(ofrows)

st_for_this.text = new_range
end subroutine

protected subroutine process_buttonclk (integer which_button);if which_button > upperbound(button_set) then return

choose case button_set[which_button]
case "CANCEL"
	if isvalid(w_par) then w_par.post dynamic process_ship_cancel()
case "SELECT"
	post ship_selection()
case "DETAILS"
	post ship_details()
case "DUPLICATE"
	post duplicate()
case "NEW"
	post new_ship()
end choose
end subroutine

public subroutine ship_details ();Long	ll_Row, &
		ll_Id
n_cst_ShipmentManager	lnv_ShipmentMgr

CHOOSE CASE of_GetSelection ( ll_Row, ll_Id )

CASE 1
	lnv_ShipmentMgr.of_OpenShipment ( ll_Id )

CASE 0
	messagebox("Shipment Details", "Please select a shipment in the list first.")

CASE ELSE //-1
	messagebox("Shipment Details", "Could not process request.  Request cancelled.", &
		exclamation!)

END CHOOSE
end subroutine

public subroutine duplicate ();Long	ll_Row, &
		ll_Id

n_cst_msg	lnv_msg
S_parm		lstr_Parm



CHOOSE CASE of_GetSelection ( ll_Row, ll_Id )

CASE 1
	
	String	ls_Text
	Int		li_Type 
	ls_Text = dw_ship_list.object.Shipment_Ref1Text [ 1 ]
	li_Type = dw_ship_list.object.Shipment_Ref1Type [ 1 ]

	IF Not isNull ( ls_Text ) AND ( li_Type = 20 OR li_Type = 26 OR li_Type = 28) THEN
	
		lstr_Parm.is_Label = "EQREF"
		lstr_Parm.ia_Value =  dw_ship_list.object.Shipment_Ref1Text [ 1 ]
		lnv_Msg.of_Add_Parm ( lstr_Parm )
		
		IF li_Type = 20 THEN
			lstr_Parm.ia_Value = 'C'
		ELSEIF li_Type = 26  THEN
			lstr_Parm.ia_Value = 'B'
		ELSE
			lstr_Parm.ia_Value = 'H'
		END IF
		lstr_Parm.is_Label = "TYPE"
		lnv_Msg.of_Add_Parm  ( lstr_Parm ) 
	
	
	END IF
	
	lstr_Parm.is_Label = "SHIPMENTID"
	lstr_Parm.ia_Value = ll_Id
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
	
	openwithparm( w_duplicateWithEquipment, lnv_Msg )

CASE 0
	messagebox("Duplicate Shipment", "Please select a shipment in the list first.")

CASE ELSE //-1
	messagebox("Duplicate Shipment", "Could not process request.  Request cancelled.", &
		exclamation!)

END CHOOSE
end subroutine

public subroutine new_ship ();n_cst_ShipmentManager	lnv_ShipmentMgr

IF new_ship_type = "B" THEN
	lnv_ShipmentMgr.of_NewBrokerageShipment ( )
ELSE
	lnv_ShipmentMgr.of_NewShipment ( )
END IF
end subroutine

protected subroutine ship_selection ();Long	ll_Row, &
		ll_Id

CHOOSE CASE of_GetSelection ( ll_Row, ll_Id )

CASE 1
	if isvalid(w_par) then w_par.post dynamic process_ship_selection( ll_Row, ll_Id )

CASE 0
	messagebox("Select Shipment", "No shipment is selected.")

CASE ELSE //-1
	messagebox("Select Shipment", "Could not process request.  Request cancelled.", &
		exclamation!)

END CHOOSE
end subroutine

public subroutine filter_and_sort ();dw_ship_list.setredraw(false)
dw_ship_list.filter()
dw_ship_list.sort()
if dw_ship_list.getselectedrow(0) > 0 then &
	dw_ship_list.scrolltorow(dw_ship_list.getselectedrow(0))
dw_ship_list.setredraw(true)

reset_range()

if isvalid(uo_radius_ship) then uo_radius_ship.of_unapplied()
end subroutine

public function integer load_from_cache ();Long	ll_CacheCount, &
		ll_SelectedCount, &
		lla_SelectedIds[], &
		ll_Ndx, &
		ll_Row
n_cst_ShipmentManager lnv_ShipmentMgr
n_ds lds_Ships
lds_Ships = lnv_ShipmentMgr.of_Get_DS_Ship( )

if dt_this_updated = lnv_ShipmentMgr.of_Get_Updated_Ships( ) then return 1

if lnv_ShipmentMgr.of_Get_Retrieved_Ships( ) = false then
	if gf_refresh("SHIP") = -1 then return -1
end if

ll_SelectedCount = of_GetSelectedIds ( lla_SelectedIds )
ll_CacheCount = lds_Ships.rowcount()

if ll_CacheCount > 0 then

	dw_ship_list.setredraw(false)
	dw_ship_list.reset()
	lds_Ships.rowscopy(1, ll_CacheCount, primary!, dw_ship_list, 9999, primary!)

	FOR ll_Ndx = 1 TO ll_SelectedCount
		ll_Row = dw_Ship_List.Find ( "ds_id = " + String ( lla_SelectedIds [ ll_Ndx ] ), &
			1, ll_CacheCount )
		IF ll_Row > 0 THEN
			dw_Ship_List.SelectRow ( ll_Row, TRUE )
		END IF
	NEXT

else
	dw_ship_list.reset()

end if

filter_and_sort()

dt_this_updated = lnv_ShipmentMgr.of_Get_Updated_Ships( )

if isvalid(uo_refresh) then uo_refresh.display_time()

return 1
end function

public subroutine set_buttons ();integer button_index, checkloop
long num_in_list
string empty_list[], parsed_list[], button_name, button_text
n_cst_numerical lnv_numerical
n_cst_anyarraysrv lnv_anyarray

button_set = empty_list

for checkloop = 1 to upperbound(buttons)
	buttons[checkloop].visible = false
next

n_cst_string lnv_string
num_in_list = lnv_string.of_ParseToArray(button_list, "~t", parsed_list)
if lnv_numerical.of_IsNullOrNotPos(num_in_list) then return

for checkloop = 1 to 5
	choose case checkloop
	case 1
		button_name = "CANCEL"
		button_text = "Cancel"
	case 2
		button_name = "SELECT"
		button_text = "Select"
	case 3
		button_name = "DETAILS"
		button_text = "&Details"
	case 4
		button_name = "DUPLICATE"
		button_text = "D&upl."
	case 5
		button_name = "NEW"
		button_text = "&New"
	end choose
	if lnv_anyarray.of_Find(parsed_list, button_name, 1, num_in_list) > 0 then
		button_index ++
		button_set[button_index] = button_name
		if button_index <= upperbound(buttons) then
			buttons[button_index].visible = true
			buttons[button_index].text = button_text
			if button_name = "CANCEL" then buttons[button_index].cancel = true
		end if
	end if
next
end subroutine

public function integer setup ();set_list_height()
set_buttons()
//set_sort(false)

return 1
end function

public subroutine set_list_height ();dw_ship_list.height = this.height - dw_ship_list.y - 8
end subroutine

private function integer of_getselection (ref long al_row, ref long al_id);Long	ll_CurrentRow, &
		ll_SelectedRow, &
		ll_TargetRow
Integer	li_Return

ll_CurrentRow = dw_Ship_List.GetRow ( )
ll_SelectedRow = dw_Ship_List.GetSelectedRow ( 0 )

IF dw_Ship_List.IsSelected ( ll_CurrentRow ) THEN

	ll_TargetRow = ll_CurrentRow

ELSE
	ll_TargetRow = ll_SelectedRow

END IF

IF ll_TargetRow > 0 THEN
	al_Row = ll_TargetRow
	al_Id = dw_ship_list.object.ds_id[ll_TargetRow]
	IF al_Id > 0 THEN
		li_Return = 1
	ELSE
		li_Return = -1
	END IF
ELSE
	SetNull ( al_Row )
	SetNull ( al_Id )
	li_Return = 0
END IF

RETURN li_Return
end function

private function long of_getselectedids (ref long ala_ids[]);Long	ll_SelectedCount, &
		lla_SelectedIds[]

IF dw_Ship_List.GetSelectedRow ( 0 ) > 0 THEN
	lla_SelectedIds = dw_Ship_List.Object.ds_id.Selected
	ll_SelectedCount = UpperBound ( lla_SelectedIds )
END IF

ala_Ids = lla_SelectedIds

RETURN ll_SelectedCount
end function

public subroutine of_details ();Long	lla_Ids[]
n_cst_ShipmentManager	lnv_ShipmentMgr

of_GetSelectedIds ( lla_Ids )

lnv_ShipmentMgr.of_OpenShipments ( lla_Ids )
end subroutine

public subroutine of_deliveryreceipts ();Long	lla_Ids[]
n_cst_BillServices	lnv_BillServices

of_GetSelectedIds ( lla_Ids )

lnv_BillServices.of_QuickPrint_Delrecs ( lla_Ids )
end subroutine

public subroutine of_showloadbuilder ();IF IsValid ( iw_LoadBuilder ) THEN
	iw_LoadBuilder.WindowState = Normal!
ELSE
	Open ( iw_LoadBuilder )
	of_UpdateLoadBuilder ( )
END IF
end subroutine

private subroutine of_updateloadbuilder ();Long	lla_Ids[]

IF IsValid ( iw_LoadBuilder ) THEN

	of_GetSelectedIds ( lla_Ids )
	iw_LoadBuilder.wf_SetShipmentList ( lla_Ids )

END IF
end subroutine

on u_ship_list.create
this.ddlb_shipmentsort=create ddlb_shipmentsort
this.dw_ship_list=create dw_ship_list
this.cb_x01=create cb_x01
this.cb_x03=create cb_x03
this.cb_x02=create cb_x02
this.st_ship_sort=create st_ship_sort
this.st_ship_display=create st_ship_display
this.ddlb_ship_display=create ddlb_ship_display
this.st_ship_ind=create st_ship_ind
this.st_ships=create st_ships
this.Control[]={this.ddlb_shipmentsort,&
this.dw_ship_list,&
this.cb_x01,&
this.cb_x03,&
this.cb_x02,&
this.st_ship_sort,&
this.st_ship_display,&
this.ddlb_ship_display,&
this.st_ship_ind,&
this.st_ships}
end on

on u_ship_list.destroy
destroy(this.ddlb_shipmentsort)
destroy(this.dw_ship_list)
destroy(this.cb_x01)
destroy(this.cb_x03)
destroy(this.cb_x02)
destroy(this.st_ship_sort)
destroy(this.st_ship_display)
destroy(this.ddlb_ship_display)
destroy(this.st_ship_ind)
destroy(this.st_ships)
end on

event constructor;n_cst_ShipmentManager	lnv_ShipmentMgr
lnv_ShipmentMgr.of_PopulateReferenceLists ( dw_Ship_List )

///////////////////////////////
//Populate shipment type list

n_cst_Ship_Type			lnv_ShipType
DWObject						ldwo_ShipType

ldwo_ShipType = dw_Ship_List.Object.Shipment_ShipTypeId
lnv_ShipType.of_Populate ( ldwo_ShipType )
DESTROY ldwo_ShipType

///////////////////////////////

buttons[1] = cb_x01
buttons[2] = cb_x02
buttons[3] = cb_x03

ddlb_ship_display.selectitem(1)
end event

type ddlb_shipmentsort from u_ddlb_shipmentsort within u_ship_list
int X=2263
int Y=4
int TabOrder=20
int Accelerator=115
end type

event ue_processchange;call super::ue_processchange;dw_Ship_List.SetSort ( as_Sort )

filter_and_sort()
end event

type dw_ship_list from datawindow within u_ship_list
event clicked pbm_dwnlbuttonclk
event dberror pbm_dwndberror
event scrollvertical pbm_dwnvscroll
int X=9
int Y=112
int Width=3593
int Height=736
string DataObject="d_bill_list"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;gf_MultiSelect ( This, Row )
of_UpdateLoadBuilder ( )
end event

event scrollvertical;reset_range()
end event

event doubleclicked;Setpointer ( HOURGLASS! )

n_cst_anyarraysrv lnv_anyarray

if lnv_anyarray.of_Find(button_set, "DETAILS", null_long, null_long) > 0 then
	post ship_details()
elseif lnv_anyarray.of_Find(button_set, "SELECT", null_long, null_long) > 0 then
	post ship_selection()
end if
end event

event rbuttondown;string ls_object_name, ls_IdColumn, lsa_parm_labels[]
any laa_parm_values[]
n_cst_numerical lnv_numerical
n_cst_EquipmentManager lnv_EquipmentMgr

Long	ll_EquipmentId, &
		ll_ParmCount
		
Date	ld_ItineraryDate

IF Upper ( dwo.Type ) = "DATAWINDOW" THEN

	lsa_Parm_Labels [1] = "ADD_ITEM"
	laa_Parm_Values [1] = "&Print"

	lsa_Parm_Labels [2] = "ADD_ITEM"
	laa_Parm_Values [2] = "E&xport"

	CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values)

	CASE "PRINT"
		dw_Ship_List.Object.r_test.y = 100
		dw_Ship_List.Print ( )
		dw_Ship_List.Object.r_test.y = 0

	CASE "EXPORT"
		dw_Ship_List.SaveAs ( )

	END CHOOSE

	RETURN 0

END IF

if lnv_numerical.of_IsNullOrNotPos(row) then return 0

ls_object_name = dwo.name

choose case ls_object_name
case "billto_name"
	ls_IdColumn = "billto_id"
case "origin_name", "origin_name_d"
	ls_IdColumn = "origin_id"
case "destination_name", "destination_name_d"
	ls_IdColumn = "destination_id"
case "shipment_invoicenumber", "ds_id"
	ls_IdColumn = "ds_id"

CASE "nextevent_site"
	ls_IdColumn = "NextEvent_SiteId"
CASE "lastconfirmed_site"
	ls_IdColumn = "LastConfirmed_SiteId"

CASE "nextevent_type", "nextevent_date", "nextevent_time", "nextevent_location"
	ls_IdColumn = "NextEvent_Id"
CASE "lastconfirmed_type", "lastconfirmed_date", "lastconfirmed_time", "lastconfirmed_location"
	ls_IdColumn = "LastConfirmed_Id"

end choose

choose case ls_IdColumn
case "billto_id", "origin_id", "destination_id", "NextEvent_SiteId", "LastConfirmed_SiteId"
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "COMPANY"
	lsa_parm_labels[2] = "CO_ID"
	laa_parm_values[2] = this.getitemnumber(row, ls_IdColumn)
	if ls_IdColumn = "ds_billto_id" then
		lsa_parm_labels[3] = "ADDRESS_TYPE"
		laa_parm_values[3] = "BILLING"
	end if
	f_pop_standard(lsa_parm_labels, laa_parm_values)
case "ds_id"
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "SHIPMENT_PERFORM_OPEN"
	lsa_parm_labels[2] = "TARGET_ID"
	laa_parm_values[2] = this.getitemnumber(row, ls_IdColumn)
	
	IF This.GetSelectedRow ( 0 ) > 0 THEN
		
		lsa_parm_labels[3] = "TARGET_IDS"
		laa_parm_values[3] = This.Object.ds_id.Selected
		
	END IF
	ll_ParmCount = upperbound ( lsa_parm_labels ) + 1
	lsa_parm_labels[ll_ParmCount] = "DATAWINDOW"
	laa_parm_values[ll_ParmCount] = THIS
	
	f_pop_standard(lsa_parm_labels, laa_parm_values)

CASE "NextEvent_Id", "LastConfirmed_Id"

	ll_EquipmentId = This.GetItemNumber ( Row, "nextevent_equipment_id" )

	CHOOSE CASE ls_IdColumn
	CASE "NextEvent_Id"
		ld_ItineraryDate = This.GetItemDate ( Row, "NextEvent_Date" )
	CASE "LastConfirmed_Id"
		ld_ItineraryDate = This.GetItemDate ( Row, "LastConfirmed_Date" )
	END CHOOSE

	IF NOT ( IsNull ( ll_EquipmentId ) OR IsNull ( ld_ItineraryDate ) ) THEN

		lsa_Parm_Labels [ 1 ] = "ADD_ITEM"
		laa_Parm_Values [ 1 ] = "&Itinerary"
	
		CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values )
		CASE "ITINERARY"
	
			lnv_EquipmentMgr.of_OpenItinerary ( ll_EquipmentId, ld_ItineraryDate )
	
		END CHOOSE

	END IF

end choose
end event

event constructor;n_cst_ShipmentManager	lnv_ShipmentManager

This.Modify ( "Shipment_BillingStatus.Edit.CodeTable = Yes "+&
	"ds_Status.Values = '" + lnv_ShipmentManager.of_GetStatusCodeTable ( ) + "'" )

lnv_ShipmentManager.of_PrepareSummaryDisplay ( This )

This.Modify ( "DataWindow.Footer.Height = 0" )
end event

type cb_x01 from commandbutton within u_ship_list
event clicked pbm_bnclicked
int X=3351
int Y=4
int Width=247
int Height=88
int TabOrder=50
string Text="x01"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;post process_buttonclk(1)
end event

type cb_x03 from commandbutton within u_ship_list
event clicked pbm_bnclicked
int X=2816
int Y=4
int Width=247
int Height=88
int TabOrder=30
string Text="x03"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;post process_buttonclk(3)
end event

type cb_x02 from commandbutton within u_ship_list
event clicked pbm_bnclicked
int X=3086
int Y=4
int Width=247
int Height=88
int TabOrder=40
string Text="x02"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;post process_buttonclk(2)
end event

type st_ship_sort from statictext within u_ship_list
int X=2021
int Y=20
int Width=283
int Height=72
boolean Enabled=false
string Text="&Sort By:"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_ship_display from statictext within u_ship_list
int X=1262
int Y=20
int Width=242
int Height=72
boolean Enabled=false
string Text="Dis&play:"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_ship_display from dropdownlistbox within u_ship_list
event selectionchanged pbm_cbnselchange
int X=1509
int Y=4
int Width=494
int Height=488
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
int Accelerator=112
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Overview",&
"Appointments",&
"Next Stop",&
"Billing Info",&
"Intermodal"}
end type

event selectionchanged;dw_ship_list.Object.DataWindow.header.height=80
choose case this.text
	case "Overview"
		dw_ship_list.modify("txt_disp_ind.text = 'L'")
	case "Appointments"
		dw_ship_list.modify("txt_disp_ind.text = 'D'")
	case "Next Stop"
		dw_ship_list.modify("txt_disp_ind.text = 'C'")
	case "Billing Info"
		dw_ship_list.modify("txt_disp_ind.text = 'T'")
	case "Intermodal"
		dw_ship_list.modify("txt_disp_ind.text = 'I'")
		dw_ship_list.Object.DataWindow.header.height=140
end choose

dw_ship_list.setredraw(true)
end event

type st_ship_ind from statictext within u_ship_list
int X=375
int Y=20
int Width=887
int Height=72
boolean Enabled=false
string Text="0 to 0 of 0"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_ships from statictext within u_ship_list
int X=14
int Y=20
int Width=325
int Height=72
boolean Enabled=false
string Text="Shipments"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

