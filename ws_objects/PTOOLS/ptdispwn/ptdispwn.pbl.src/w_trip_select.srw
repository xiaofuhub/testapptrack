$PBExportHeader$w_trip_select.srw
$PBExportComments$PTSHIP.
forward
global type w_trip_select from Window
end type
type uo_refresh from u_refresh within w_trip_select
end type
type uo_statusfilter from u_cst_statusfilter within w_trip_select
end type
type uo_triplist from u_trip_list within w_trip_select
end type
type cb_ok from commandbutton within w_trip_select
end type
type cb_cancel from commandbutton within w_trip_select
end type
end forward

global type w_trip_select from Window
int X=0
int Y=312
int Width=3639
int Height=1968
boolean TitleBar=true
string Title="Trip Selection"
long BackColor=12632256
WindowType WindowType=response!
uo_refresh uo_refresh
uo_statusfilter uo_statusfilter
uo_triplist uo_triplist
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_trip_select w_trip_select

type variables
protected:
integer mboxret
end variables

event open;n_cst_ShipmentManager lnv_ShipmentMgr
n_cst_LicenseManager	lnv_LicenseManager
String	ls_MessageHeader = "Select Trip"

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_Brokerage ) = FALSE THEN

	lnv_LicenseManager.of_DisplayModuleNotice ( ls_MessageHeader )
	cb_Cancel.Event Clicked ( )
	RETURN

END IF

if lnv_ShipmentMgr.of_Get_Retrieved_Trips( ) = false then
	if lnv_ShipmentMgr.of_RefreshShipments ( TRUE ) = -1 then
		messagebox("Select Trip", "Could not retrieve trip list from "+&
			"database.~n~nRequest cancelled.", exclamation!)
		cb_Cancel.Event Clicked ( )
		RETURN
	end if
END IF

uo_refresh.list_type = "TRIP~tSHIP"
uo_refresh.setup()

uo_TripList.uo_refresh = uo_refresh
//uo_TripList.dw_trip_list.setfilter("bt_pmtstatus = 'K'")
if uo_TripList.setup() = -1 then
	MessageBox ( ls_MessageHeader, "Could not load trip list.  Request cancelled.", Exclamation! )
	cb_Cancel.Event Clicked ( )
	RETURN
END IF

uo_TripList.load_from_cache()
end event

on w_trip_select.create
this.uo_refresh=create uo_refresh
this.uo_statusfilter=create uo_statusfilter
this.uo_triplist=create uo_triplist
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.Control[]={this.uo_refresh,&
this.uo_statusfilter,&
this.uo_triplist,&
this.cb_ok,&
this.cb_cancel}
end on

on w_trip_select.destroy
destroy(this.uo_refresh)
destroy(this.uo_statusfilter)
destroy(this.uo_triplist)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

type uo_refresh from u_refresh within w_trip_select
event destroy ( )
int X=2683
int Y=24
int TabOrder=20
end type

on uo_refresh.destroy
call u_refresh::destroy
end on

event ue_refresh;call super::ue_refresh;//If refresh processing was a success, update the display with the results.

IF AncestorReturnValue = 1 THEN

	uo_TripList.Load_From_Cache ( )

END IF

RETURN AncestorReturnValue
end event

type uo_statusfilter from u_cst_statusfilter within w_trip_select
event destroy ( )
int X=0
int Y=0
int TabOrder=10
end type

on uo_statusfilter.destroy
call u_cst_statusfilter::destroy
end on

event ue_postselection;//Process Filter Selection

String	ls_Filter
Boolean	lb_Unknown

CHOOSE CASE ai_Selection

CASE ci_Selection_Open
	ls_Filter = "bt_pmtstatus = 'K'"

CASE ci_Selection_Restricted
	ls_Filter = "Pos ( 'NQT', bt_pmtstatus ) > 0"

CASE ci_Selection_All
	ls_Filter = "bt_pmtstatus <> 'W'"

CASE ELSE  //Unexpected value
	lb_Unknown = TRUE	

END CHOOSE

IF NOT lb_Unknown THEN

	uo_TripList.dw_trip_list.setfilter( ls_Filter )
	uo_TripList.dw_Trip_List.Filter ( )

END IF
end event

type uo_triplist from u_trip_list within w_trip_select
event destroy ( )
int X=0
int Y=200
int Height=1668
int TabOrder=40
end type

on uo_triplist.destroy
call u_trip_list::destroy
end on

event constructor;call super::constructor;This.cb_New_Trip.Enabled = FALSE
This.cb_New_Trip.Visible = FALSE

This.cb_Trip_Details.Enabled = FALSE
This.cb_Trip_Details.Visible = FALSE
end event

event ue_selection;//OVERRIDING ANCESTOR to provide context specific funtionality

CloseWithReturn ( Parent, al_Id )
RETURN 1
end event

type cb_ok from commandbutton within w_trip_select
int X=3081
int Y=204
int Width=251
int Height=88
int TabOrder=20
boolean BringToTop=true
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uo_TripList.Event ue_Select ( )
end event

type cb_cancel from commandbutton within w_trip_select
int X=3351
int Y=204
int Width=247
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;closewithreturn(parent, -25)
end on

