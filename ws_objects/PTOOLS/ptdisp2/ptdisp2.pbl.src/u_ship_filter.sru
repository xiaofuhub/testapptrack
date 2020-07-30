$PBExportHeader$u_ship_filter.sru
forward
global type u_ship_filter from userobject
end type
type st_display from statictext within u_ship_filter
end type
type ddlb_category from dropdownlistbox within u_ship_filter
end type
type ddlb_ship_filt from dropdownlistbox within u_ship_filter
end type
type st_ship_filt from statictext within u_ship_filter
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//String	ss_LastCategorySelected = "All"
////end modification Shared Variables by appeon  20070730
end variables

global type u_ship_filter from userobject
integer width = 1838
integer height = 108
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event ue_filterchanged ( string as_newfilter )
st_display st_display
ddlb_category ddlb_category
ddlb_ship_filt ddlb_ship_filt
st_ship_filt st_ship_filt
end type
global u_ship_filter u_ship_filter

type variables
public:
datawindow dw_ship_list
u_ship_list uo_ship_list
boolean allow_nonrouted = true

//begin modification Shared Variables by appeon  20070730
String	ss_LastCategorySelected = "All"
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public subroutine set_filter (boolean set_global_prefs)
public function integer setup ()
end prototypes

public subroutine set_filter (boolean set_global_prefs);String	ls_Filter, &
			ls_TypeList, &
			ls_Category
n_cst_ShipmentManager	lnv_ShipmentMgr
n_cst_Ship_Type			lnv_ShipmentTypeManager

ls_Filter = "(Shipment_BillingStatus = '" + gc_Dispatch.cs_ShipmentStatus_Open +&
	"' or Shipment_ConfirmedEventCount < Shipment_EventCount) and "

choose case ddlb_ship_filt.text
case "Unassigned Only"
	ls_Filter += "Shipment_Category = 'T' and not (Shipment_AssignedEventCount > 0 and Shipment_AssignedEventCount = Shipment_EventCount)"
	if set_global_prefs then lnv_ShipmentMgr.of_Set_Filter_Ships( 1 )
case "Unassigned / Incomplete"
	ls_Filter += "Shipment_Category = 'T' and not (Shipment_ConfirmedEventCount > 0 and Shipment_ConfirmedEventCount = Shipment_EventCount)"
	if set_global_prefs then lnv_ShipmentMgr.of_Set_Filter_Ships( 2 )
case "Completed"
	//Changed at customer request 8/16/05 4.0.41 BKW 
	//Completed was only showing completed ROUTED shipments.  Changed so it it would show completed Routed & Non-Routed.
	//It was decided to leave "Non-Routed" as is, showing both completed & incomplete non-routed.
//	ls_Filter += "Shipment_Category = 'T' and Shipment_ConfirmedEventCount > 0 and Shipment_ConfirmedEventCount = Shipment_EventCount"
	ls_Filter += "Shipment_ConfirmedEventCount > 0 and Shipment_ConfirmedEventCount = Shipment_EventCount"
	if set_global_prefs then lnv_ShipmentMgr.of_Set_Filter_Ships( 3 )
case "Non-Routed"
	ls_Filter += "Shipment_Category = 'D'"
	if set_global_prefs then lnv_ShipmentMgr.of_Set_Filter_Ships( 4 )
case "All"
	if allow_nonrouted then
		ls_Filter += "1=1"
	else
		ls_Filter += "Shipment_Category = 'T'"
	end if
	if set_global_prefs then lnv_ShipmentMgr.of_Set_Filter_Ships( 5 )
case else
	return
end choose


ls_Category = ddlb_Category.Text

CHOOSE CASE ls_Category

CASE "All"
	//No additional filter restrictions required.

CASE "Dispatch", "Brokerage"

	CHOOSE CASE lnv_ShipmentTypeManager.of_GetTypeList ( Upper ( ls_Category ), FALSE, ls_TypeList )

	CASE IS >= 0

		//Pad either end of type list with ", " to allow pattern matching of the type list string throughout
		ls_TypeList = ", " + ls_TypeList + ", "

		//Add the pattern match condition to the filter.
		ls_Filter = '( IsNull ( Shipment_ShipTypeId ) OR Match ( "' + ls_TypeList + '", ", " + String ( Shipment_ShipTypeId ) + ", " ) ) and ' + ls_Filter

	CASE ELSE
		//Error

	END CHOOSE

CASE ELSE
	//Unexpected Value.

END CHOOSE


if isvalid(dw_ship_list) then dw_ship_list.setfilter(ls_Filter)

if isvalid(uo_ship_list) then uo_ship_list.filter_and_sort()

This.Event Post ue_FilterChanged ( ls_Filter )
end subroutine

public function integer setup ();Integer	li_Filter
n_cst_ShipmentManager	lnv_ShipmentManager

if allow_nonrouted = false then ddlb_ship_filt.deleteitem(4)

if lnv_ShipmentManager.of_Get_Filter_Ships( ) > 0 then
	li_Filter = lnv_ShipmentManager.of_Get_Filter_Ships( )
else
	li_Filter = 2
end if
if allow_nonrouted then
	ddlb_ship_filt.selectitem(li_Filter)
else
	ddlb_ship_filt.selectitem(min(li_Filter, 4))
end if

if isvalid(uo_ship_list) then dw_ship_list = uo_ship_list.dw_ship_list
if not isvalid(dw_ship_list) then return -1

return 1
end function

on u_ship_filter.create
this.st_display=create st_display
this.ddlb_category=create ddlb_category
this.ddlb_ship_filt=create ddlb_ship_filt
this.st_ship_filt=create st_ship_filt
this.Control[]={this.st_display,&
this.ddlb_category,&
this.ddlb_ship_filt,&
this.st_ship_filt}
end on

on u_ship_filter.destroy
destroy(this.st_display)
destroy(this.ddlb_category)
destroy(this.ddlb_ship_filt)
destroy(this.st_ship_filt)
end on

type st_display from statictext within u_ship_filter
integer y = 20
integer width = 288
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "&Category:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_category from dropdownlistbox within u_ship_filter
event selectionchanged pbm_cbnselchange
integer x = 302
integer y = 4
integer width = 402
integer height = 448
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Dispatch","Brokerage","All"}
integer accelerator = 99
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Record the selection, so new instances will open with the most recent setting
ss_LastCategorySelected = This.Text

//Process the new selection.
post set_filter(true)
end event

event constructor;This.SelectItem ( ss_LastCategorySelected, 0 )
end event

type ddlb_ship_filt from dropdownlistbox within u_ship_filter
event selectionchanged pbm_cbnselchange
integer x = 951
integer y = 4
integer width = 873
integer height = 480
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Unassigned Only","Unassigned / Incomplete","Completed","Non-Routed","All"}
integer accelerator = 97
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;post set_filter(true)
end event

type st_ship_filt from statictext within u_ship_filter
integer x = 722
integer y = 20
integer width = 210
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "St&atus:"
alignment alignment = right!
boolean focusrectangle = false
end type

