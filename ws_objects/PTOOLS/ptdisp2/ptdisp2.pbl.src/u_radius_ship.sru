$PBExportHeader$u_radius_ship.sru
forward
global type u_radius_ship from u_radius
end type
type gb_stoptype from groupbox within u_radius_ship
end type
type rb_pickup from radiobutton within u_radius_ship
end type
type rb_deliver from radiobutton within u_radius_ship
end type
end forward

global type u_radius_ship from u_radius
int Width=3333
int Height=132
gb_stoptype gb_stoptype
rb_pickup rb_pickup
rb_deliver rb_deliver
end type
global u_radius_ship u_radius_ship

type variables
Protected:
String	is_PickupColumn
String	is_PickupColumnType
String	is_DeliveryColumn
String	is_DeliveryColumnType
end variables

forward prototypes
public function integer of_set_target (datawindow adw_target)
public function integer of_setpickupcolumn (string as_column, string as_type)
public function integer of_setdeliverycolumn (string as_column, string as_type)
end prototypes

public function integer of_set_target (datawindow adw_target);idw_target = adw_target

ib_ready = true

return 1
end function

public function integer of_setpickupcolumn (string as_column, string as_type);is_PickupColumn = as_Column
is_PickupColumnType = as_Type

if rb_pickup.checked then
	is_target_column = is_PickupColumn
	is_target_column_type = is_PickupColumnType
end if

RETURN 1
end function

public function integer of_setdeliverycolumn (string as_column, string as_type);is_DeliveryColumn = as_Column
is_DeliveryColumnType = as_Type

if rb_deliver.checked then
	is_target_column = is_DeliveryColumn
	is_target_column_type = is_DeliveryColumnType
end if

RETURN 1
end function

on u_radius_ship.create
int iCurrent
call super::create
this.gb_stoptype=create gb_stoptype
this.rb_pickup=create rb_pickup
this.rb_deliver=create rb_deliver
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_stoptype
this.Control[iCurrent+2]=this.rb_pickup
this.Control[iCurrent+3]=this.rb_deliver
end on

on u_radius_ship.destroy
call super::destroy
destroy(this.gb_stoptype)
destroy(this.rb_pickup)
destroy(this.rb_deliver)
end on

type rb_outside from u_radius`rb_outside within u_radius_ship
int X=1179
int Height=76
end type

type rb_within from u_radius`rb_within within u_radius_ship
int X=910
int Height=76
end type

type st_4 from u_radius`st_4 within u_radius_ship
int X=2514
int Y=44
end type

type sle_state from u_radius`sle_state within u_radius_ship
int X=2368
int Y=44
int TabOrder=50
end type

type sle_city from u_radius`sle_city within u_radius_ship
int X=1920
int Y=44
int TabOrder=40
end type

type sle_zip from u_radius`sle_zip within u_radius_ship
int X=2601
int Y=44
int TabOrder=60
end type

type cb_unapply from u_radius`cb_unapply within u_radius_ship
int X=3081
int Y=40
int TabOrder=80
end type

type cb_apply from u_radius`cb_apply within u_radius_ship
int X=2821
int Y=40
int Width=247
int TabOrder=70
end type

type st_3 from u_radius`st_3 within u_radius_ship
int X=1682
int Y=44
end type

type sle_radius from u_radius`sle_radius within u_radius_ship
int X=1499
int Y=44
int TabOrder=30
end type

type st_1 from u_radius`st_1 within u_radius_ship
int Y=48
int Width=238
end type

type gb_1 from u_radius`gb_1 within u_radius_ship
int X=896
int Width=594
int Height=128
int TabOrder=20
end type

type gb_stoptype from groupbox within u_radius_ship
int X=247
int Width=645
int Height=128
int TabOrder=10
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_pickup from radiobutton within u_radius_ship
int X=270
int Y=44
int Width=283
int Height=76
boolean BringToTop=true
string Text="Pickup "
boolean Checked=true
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_target_column = is_PickupColumn
is_target_column_type = is_PickupColumnType
cb_apply.enabled = true
end event

type rb_deliver from radiobutton within u_radius_ship
int X=590
int Y=44
int Width=274
int Height=76
boolean BringToTop=true
string Text="Deliver "
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_target_column = is_DeliveryColumn
is_target_column_type = is_DeliveryColumnType
cb_apply.enabled = true
end event

