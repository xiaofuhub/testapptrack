$PBExportHeader$w_ship_select.srw
forward
global type w_ship_select from Window
end type
type uo_refresh from u_refresh within w_ship_select
end type
type uo_ship_filter from u_ship_filter within w_ship_select
end type
type uo_ship_list from u_ship_list within w_ship_select
end type
end forward

global type w_ship_select from Window
int X=0
int Y=312
int Width=3643
int Height=1968
boolean TitleBar=true
string Title="Shipment Selection"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
uo_refresh uo_refresh
uo_ship_filter uo_ship_filter
uo_ship_list uo_ship_list
end type
global w_ship_select w_ship_select

forward prototypes
public subroutine process_ship_cancel ()
public subroutine process_ship_selection (long selrow, long selid)
end prototypes

public subroutine process_ship_cancel ();closewithreturn(this, 0)
end subroutine

public subroutine process_ship_selection (long selrow, long selid);if selid > 0 then closewithreturn(this, selid)
end subroutine

on w_ship_select.create
this.uo_refresh=create uo_refresh
this.uo_ship_filter=create uo_ship_filter
this.uo_ship_list=create uo_ship_list
this.Control[]={this.uo_refresh,&
this.uo_ship_filter,&
this.uo_ship_list}
end on

on w_ship_select.destroy
destroy(this.uo_refresh)
destroy(this.uo_ship_filter)
destroy(this.uo_ship_list)
end on

event open;n_cst_ShipmentManager lnv_ShipmentMgr

if lnv_ShipmentMgr.of_Get_Retrieved_Ships( ) = false then
	if gf_refresh("SHIP") = -1 then goto failure
end if

uo_refresh.list_type = "SHIP"
if uo_refresh.setup() = -1 then goto failure

uo_ship_list.w_par = this
uo_ship_list.uo_refresh = uo_refresh
uo_ship_list.button_list = "CANCEL~tSELECT"
if uo_ship_list.setup() = -1 then goto failure

uo_ship_filter.uo_ship_list = uo_ship_list
uo_ship_filter.allow_nonrouted = false
if uo_ship_filter.setup() = -1 then goto failure

uo_ship_list.load_from_cache()
uo_ship_filter.set_filter(false)

return

failure:
messagebox("Shipment Selection", "Could not initialize selection window.  "+&
	"Request cancelled.", exclamation!)
closewithreturn(this, 0)
end event

type uo_refresh from u_refresh within w_ship_select
int X=2683
int Y=32
int TabOrder=30
end type

on uo_refresh.destroy
call u_refresh::destroy
end on

event ue_refresh;call super::ue_refresh;//If refresh processing was a success, update the display with the results.

IF AncestorReturnValue = 1 THEN

	uo_Ship_List.Load_From_Cache ( )

END IF

RETURN AncestorReturnValue
end event

type uo_ship_filter from u_ship_filter within w_ship_select
int X=9
int Y=28
int TabOrder=10
end type

on uo_ship_filter.destroy
call u_ship_filter::destroy
end on

type uo_ship_list from u_ship_list within w_ship_select
int X=0
int Y=272
int Height=1584
int TabOrder=20
end type

on uo_ship_list.destroy
call u_ship_list::destroy
end on

