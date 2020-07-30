$PBExportHeader$u_trip_list.sru
forward
global type u_trip_list from UserObject
end type
type dw_trip_list from u_dw_triplist within u_trip_list
end type
type cb_new_trip from commandbutton within u_trip_list
end type
type cb_trip_details from commandbutton within u_trip_list
end type
type ddlb_trip_sort from dropdownlistbox within u_trip_list
end type
type st_trip_sort from statictext within u_trip_list
end type
type ddlb_trip_display from dropdownlistbox within u_trip_list
end type
type st_trip_display from statictext within u_trip_list
end type
type st_trip_ind from statictext within u_trip_list
end type
type st_trips from statictext within u_trip_list
end type
end forward

global type u_trip_list from UserObject
int Width=3607
int Height=712
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
event type integer ue_selection ( readonly long al_id )
event type integer ue_select ( )
dw_trip_list dw_trip_list
cb_new_trip cb_new_trip
cb_trip_details cb_trip_details
ddlb_trip_sort ddlb_trip_sort
st_trip_sort st_trip_sort
ddlb_trip_display ddlb_trip_display
st_trip_display st_trip_display
st_trip_ind st_trip_ind
st_trips st_trips
end type
global u_trip_list u_trip_list

type variables
public:
datetime dt_this_updated
u_refresh uo_refresh
end variables

forward prototypes
public subroutine reset_range ()
public subroutine set_sort (boolean set_global_prefs)
public subroutine filter_and_sort ()
public function integer load_from_cache ()
public subroutine set_list_height ()
public function integer setup ()
end prototypes

event ue_selection;//Override this in the descendant if you want something different.

n_cst_ShipmentManager	lnv_ShipmentManager
lnv_ShipmentManager.of_OpenTrip ( al_Id )

RETURN 1
end event

event ue_select;Long	ll_SelectedRow, &
		ll_SelectedId

Integer	li_Return = -1

ll_SelectedRow = dw_Trip_List.GetSelectedRow ( 0 )

IF ll_SelectedRow > 0 THEN

	ll_SelectedId = dw_Trip_List.Object.bt_id [ ll_SelectedRow ]

	IF ll_SelectedId > 0 THEN

		This.Event ue_Selection ( ll_SelectedId )
		li_Return = 1

	END IF

END IF

RETURN li_Return
end event

public subroutine reset_range ();datawindow dw_for_this
statictext st_for_this
integer firstrow, lastrow, ofrows
string new_range

dw_for_this = dw_trip_list
st_for_this = st_trip_ind

firstrow = integer(dw_for_this.describe("datawindow.firstrowonpage"))
lastrow = integer(dw_for_this.describe("datawindow.lastrowonpage"))
ofrows = dw_for_this.rowcount()

new_range = string(firstrow) + " to " + string(lastrow) + " of " + string(ofrows)

st_for_this.text = new_range
end subroutine

public subroutine set_sort (boolean set_global_prefs);//Bug Fix: Prior to 3.0.15, we were using bt_tripnum for "Trip #", even though the display had changed
//to using bt_id.

choose case ddlb_trip_sort.text
case "TripDt, Trip #"
	dw_trip_list.setsort("bt_tripdate A, bt_id A")
case "TripDt, Carrier"
	dw_trip_list.setsort("bt_tripdate A, carrier_name A, bt_id A")
case "TripDt, Origin"
	dw_trip_list.setsort("bt_tripdate A, origin_name A, bt_id A")
case "TripDt, O. Loc."
	dw_trip_list.setsort("bt_tripdate A, origin_state A, origin_city A, origin_name A, bt_id A")
case "TripDt, Dest."
	dw_trip_list.setsort("bt_tripdate A, findest_name A, bt_id A")
case "TripDt, D. Loc."
	dw_trip_list.setsort("bt_tripdate A, findest_state A, findest_city A, findest_name A, bt_id A")
case "Trip #"
	dw_trip_list.setsort("bt_id A")
case "Carrier"
	dw_trip_list.setsort("carrier_name A, bt_tripdate A, bt_id A")
case "Origin"
	dw_trip_list.setsort("origin_name A, bt_tripdate A, bt_id A")
case "Origin Loc."
	dw_trip_list.setsort("origin_state A, origin_city A, origin_name A, bt_tripdate A, bt_id A")
case "Destination"
	dw_trip_list.setsort("findest_name A, bt_tripdate A, bt_id A")
case "Dest. Loc."
	dw_trip_list.setsort("findest_state A, findest_city A, findest_name A, bt_tripdate A, bt_id A")
case else
	return
end choose

//There is currently no global preference setting.
end subroutine

public subroutine filter_and_sort ();dw_trip_list.setredraw(false)
dw_trip_list.filter()
dw_trip_list.sort()
if dw_trip_list.getselectedrow(0) > 0 then &
	dw_trip_list.scrolltorow(dw_trip_list.getselectedrow(0))
dw_trip_list.setredraw(true)

reset_range()
end subroutine

public function integer load_from_cache ();long selrow, selid, cache_rows
n_cst_ShipmentManager lnv_ShipmentMgr
n_ds lds_Trips
lds_Trips = lnv_ShipmentMgr.of_Get_DS_Trip( )

if dt_this_updated = lnv_ShipmentMgr.of_Get_Updated_Trips( ) then return 1

if lnv_ShipmentMgr.of_Get_Retrieved_Trips( ) = false then
	if gf_refresh("TRIP~tSHIP") = -1 then return -1
end if

selrow = dw_trip_list.getselectedrow(0)
if selrow > 0 then selid = dw_trip_list.object.bt_id[selrow]

cache_rows = lds_Trips.rowcount()

if cache_rows > 0 then
	dw_trip_list.setredraw(false)
	dw_trip_list.reset()
	lds_Trips.rowscopy(1, cache_rows, primary!, dw_trip_list, 9999, primary!)
	if selid > 0 then
		selrow = dw_trip_list.find("bt_id = " + string(selid), 1, cache_rows)
		if selrow > 0 then dw_trip_list.selectrow(selrow, true)
	end if
	filter_and_sort()
else
	dw_trip_list.reset()
	reset_range()
end if

dt_this_updated = lnv_ShipmentMgr.of_Get_Updated_Trips( )

if isvalid(uo_refresh) then uo_refresh.display_time()

return 1
end function

public subroutine set_list_height ();dw_trip_list.height = this.height - dw_trip_list.y - 8
end subroutine

public function integer setup ();set_list_height()
set_sort(false)

return 1
end function

on u_trip_list.create
this.dw_trip_list=create dw_trip_list
this.cb_new_trip=create cb_new_trip
this.cb_trip_details=create cb_trip_details
this.ddlb_trip_sort=create ddlb_trip_sort
this.st_trip_sort=create st_trip_sort
this.ddlb_trip_display=create ddlb_trip_display
this.st_trip_display=create st_trip_display
this.st_trip_ind=create st_trip_ind
this.st_trips=create st_trips
this.Control[]={this.dw_trip_list,&
this.cb_new_trip,&
this.cb_trip_details,&
this.ddlb_trip_sort,&
this.st_trip_sort,&
this.ddlb_trip_display,&
this.st_trip_display,&
this.st_trip_ind,&
this.st_trips}
end on

on u_trip_list.destroy
destroy(this.dw_trip_list)
destroy(this.cb_new_trip)
destroy(this.cb_trip_details)
destroy(this.ddlb_trip_sort)
destroy(this.st_trip_sort)
destroy(this.ddlb_trip_display)
destroy(this.st_trip_display)
destroy(this.st_trip_ind)
destroy(this.st_trips)
end on

event constructor;ddlb_trip_display.selectitem(1)
ddlb_trip_sort.selectitem(2)
end event

type dw_trip_list from u_dw_triplist within u_trip_list
int X=14
int Y=132
int Width=3570
int Height=568
int TabOrder=40
end type

event rbuttondown;call super::rbuttondown;string ls_object_name, ls_id_column, lsa_parm_labels[]
any laa_parm_values[]
n_cst_numerical lnv_numerical


IF Upper ( dwo.Type ) = "DATAWINDOW" THEN

	lsa_Parm_Labels [1] = "ADD_ITEM"
	laa_Parm_Values [1] = "&Print"

	lsa_Parm_Labels [2] = "ADD_ITEM"
	laa_Parm_Values [2] = "E&xport"

	CHOOSE CASE f_Pop_Standard ( lsa_Parm_Labels, laa_Parm_Values)

	CASE "PRINT"
		dw_Trip_List.Print ( )

	CASE "EXPORT"
		dw_Trip_List.SaveAs ( )

	END CHOOSE

	RETURN 0

END IF


if lnv_numerical.of_IsNullOrNotPos(row) then return 0

ls_object_name = dwo.name

choose case ls_object_name
case "carrier_name"
	ls_id_column = "bt_carrier_id"
case "origin_name"
	ls_id_column = "bt_origin_id"
case "findest_name"
	ls_id_column = "bt_findest_id"
end choose

choose case ls_id_column
case "bt_carrier_id", "bt_origin_id", "bt_findest_id"
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "COMPANY"
	lsa_parm_labels[2] = "CO_ID"
	laa_parm_values[2] = this.getitemnumber(row, ls_id_column)
	f_pop_standard(lsa_parm_labels, laa_parm_values)
end choose
end event

event clicked;call super::clicked;this.selectrow(0, false)
if row > 0 then this.selectrow(row, true)
end event

event doubleclicked;call super::doubleclicked;IF Row > 0 THEN
	Parent.Event ue_Select ( )
END IF
end event

event scrollvertical;call super::scrollvertical;reset_range()
end event

type cb_new_trip from commandbutton within u_trip_list
event clicked pbm_bnclicked
int X=3086
int Y=4
int Width=247
int Height=88
int TabOrder=30
string Text="&New"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_ShipmentManager	lnv_ShipmentManager

lnv_ShipmentManager.of_NewTrip ( )
end event

type cb_trip_details from commandbutton within u_trip_list
event clicked pbm_bnclicked
int X=3351
int Y=4
int Width=247
int Height=88
int TabOrder=50
string Text="&Details"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_Select ( )
end event

type ddlb_trip_sort from dropdownlistbox within u_trip_list
event selectionchanged pbm_cbnselchange
int X=2263
int Y=4
int Width=526
int Height=932
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
int Accelerator=115
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"TripDt, Trip #",&
"TripDt, Carrier",&
"TripDt, Origin",&
"TripDt, O. Loc.",&
"TripDt, Dest.",&
"TripDt, D. Loc.",&
"Trip #",&
"Carrier",&
"Origin",&
"Origin Loc.",&
"Destination",&
"Dest. Loc."}
end type

event selectionchanged;set_sort(true)
filter_and_sort()
end event

type st_trip_sort from statictext within u_trip_list
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

type ddlb_trip_display from dropdownlistbox within u_trip_list
event selectionchanged pbm_cbnselchange
int X=1509
int Y=4
int Width=494
int Height=272
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
string Item[]={"Locations",&
"Other Info"}
end type

event selectionchanged;choose case this.text
case "Locations"
	dw_trip_list.modify("txt_disp_ind.text = 'L'")
case "Other Info"
	dw_trip_list.modify("txt_disp_ind.text = 'E'")
end choose

dw_trip_list.setredraw(true)
end event

type st_trip_display from statictext within u_trip_list
int X=1262
int Y=20
int Width=283
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

type st_trip_ind from statictext within u_trip_list
int X=375
int Y=20
int Width=581
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

type st_trips from statictext within u_trip_list
int X=14
int Y=20
int Width=160
int Height=72
boolean Enabled=false
string Text="Trips"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

