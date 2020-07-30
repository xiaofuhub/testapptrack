$PBExportHeader$u_refresh.sru
forward
global type u_refresh from UserObject
end type
type cb_refresh from commandbutton within u_refresh
end type
type st_refresh from statictext within u_refresh
end type
type st_1 from statictext within u_refresh
end type
end forward

global type u_refresh from UserObject
int Width=919
int Height=92
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
event type integer ue_refresh ( )
cb_refresh cb_refresh
st_refresh st_refresh
st_1 st_1
end type
global u_refresh u_refresh

type variables
public:
string list_type

end variables

forward prototypes
public function integer setup ()
public subroutine display_time ()
end prototypes

event ue_refresh;Integer	li_Return = -1

if gf_refresh(list_type) = 1 then
	li_Return = 1
else
	messagebox("Refresh", "Could not retrieve information from database." +&
		"~n~nPlease retry.", exclamation!)
end if

RETURN li_Return
end event

public function integer setup ();choose case list_type
case "TRIP~tSHIP", "SHIP"
	display_time()
	return 1
case else
	return -1
end choose
end function

public subroutine display_time ();n_cst_ShipmentManager lnv_ShipmentMgr

choose case list_type
case "TRIP~tSHIP", "SHIP"
	if lnv_ShipmentMgr.of_Get_Retrieved_Ships( ) then
		st_refresh.text = string(time(lnv_ShipmentMgr.of_Get_Refreshed_Ships( ) ), "h:mma/p")
	else
		st_refresh.text = ""
	end if
case else
	st_refresh.text = ""
end choose
end subroutine

on u_refresh.create
this.cb_refresh=create cb_refresh
this.st_refresh=create st_refresh
this.st_1=create st_1
this.Control[]={this.cb_refresh,&
this.st_refresh,&
this.st_1}
end on

on u_refresh.destroy
destroy(this.cb_refresh)
destroy(this.st_refresh)
destroy(this.st_1)
end on

type cb_refresh from commandbutton within u_refresh
event clicked pbm_bnclicked
int X=667
int Width=247
int Height=88
int TabOrder=1
string Text="Re&fresh"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_Refresh ( )
end event

type st_refresh from statictext within u_refresh
int X=398
int Y=8
int Width=247
int Height=72
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=29425663
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_refresh
int Y=16
int Width=379
int Height=76
boolean Enabled=false
string Text="Last Refresh:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

