$PBExportHeader$w_equip_base.srw
$PBExportComments$Ancestor of w_equip_select and w_equip_summary
forward
global type w_equip_base from Window
end type
type uo_radius_ship from u_radius within w_equip_base
end type
type cb_map from commandbutton within w_equip_base
end type
type cb_refresh from commandbutton within w_equip_base
end type
type st_refresh from statictext within w_equip_base
end type
type st_1 from statictext within w_equip_base
end type
type rb_400 from radiobutton within w_equip_base
end type
type rb_300 from radiobutton within w_equip_base
end type
type rb_200 from radiobutton within w_equip_base
end type
type rb_100 from radiobutton within w_equip_base
end type
type dw_list from datawindow within w_equip_base
end type
type gb_type from groupbox within w_equip_base
end type
end forward

global type w_equip_base from Window
int X=0
int Y=312
int Width=3643
int Height=1968
boolean TitleBar=true
string Title="Driver / Equipment Summary"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
uo_radius_ship uo_radius_ship
cb_map cb_map
cb_refresh cb_refresh
st_refresh st_refresh
st_1 st_1
rb_400 rb_400
rb_300 rb_300
rb_200 rb_200
rb_100 rb_100
dw_list dw_list
gb_type gb_type
end type
global w_equip_base w_equip_base

type variables
public:
datastore ds_local
w_map mapwin
end variables

on w_equip_base.create
this.uo_radius_ship=create uo_radius_ship
this.cb_map=create cb_map
this.cb_refresh=create cb_refresh
this.st_refresh=create st_refresh
this.st_1=create st_1
this.rb_400=create rb_400
this.rb_300=create rb_300
this.rb_200=create rb_200
this.rb_100=create rb_100
this.dw_list=create dw_list
this.gb_type=create gb_type
this.Control[]={this.uo_radius_ship,&
this.cb_map,&
this.cb_refresh,&
this.st_refresh,&
this.st_1,&
this.rb_400,&
this.rb_300,&
this.rb_200,&
this.rb_100,&
this.dw_list,&
this.gb_type}
end on

on w_equip_base.destroy
destroy(this.uo_radius_ship)
destroy(this.cb_map)
destroy(this.cb_refresh)
destroy(this.st_refresh)
destroy(this.st_1)
destroy(this.rb_400)
destroy(this.rb_300)
destroy(this.rb_200)
destroy(this.rb_100)
destroy(this.dw_list)
destroy(this.gb_type)
end on

event close;if isvalid(mapwin) then close(mapwin)
end event

type uo_radius_ship from u_radius within w_equip_base
int X=1006
int Y=184
int TabOrder=20
end type

event constructor;call super::constructor;this.of_set_target(dw_list, "curevco_pcm", "PCM!")
end event

on uo_radius_ship.destroy
call u_radius::destroy
end on

type cb_map from commandbutton within w_equip_base
int X=2514
int Y=432
int Width=526
int Height=88
int TabOrder=30
string Text="Show Map"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if isvalid(mapwin) then return
if dw_list.rowcount() = 0 then return

s_mapping maps

maps.dw_source = dw_list
maps.ds_source = null_ds
maps.ypos = 1
maps.xpos = null_int
maps.typemap = "Z"

openwithparm(mapwin, maps, parent)
end event

type cb_refresh from commandbutton within w_equip_base
event clicked pbm_bnclicked
int X=3351
int Y=32
int Width=247
int Height=88
int TabOrder=10
string Text="Refresh"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_refresh from statictext within w_equip_base
int X=3081
int Y=40
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

type st_1 from statictext within w_equip_base
int X=2674
int Y=48
int Width=389
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

type rb_400 from radiobutton within w_equip_base
event clicked pbm_bnclicked
int X=69
int Y=356
int Width=640
int Height=76
string Text="CONTAINERS"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_200.enabled or rb_300.enabled then
	dw_list.setfilter("eq_status = 'K' and pos('C', eq_type) > 0")
	dw_list.filter()
	dw_list.sort()
	uo_radius_ship.of_unapplied()
end if
end event

type rb_300 from radiobutton within w_equip_base
event clicked pbm_bnclicked
int X=69
int Y=272
int Width=640
int Height=76
string Text="TRAILERS / CHASSIS"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_200.enabled or rb_400.enabled then
	dw_list.setfilter("eq_status = 'K' and pos('VFRKBH', eq_type) > 0")
	dw_list.filter()
	dw_list.sort()
	uo_radius_ship.of_unapplied()
end if
end event

type rb_200 from radiobutton within w_equip_base
event clicked pbm_bnclicked
int X=69
int Y=188
int Width=727
int Height=76
string Text="TRACTORS / VANS / S.T.'S"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_300.enabled or rb_400.enabled then
	dw_list.setfilter("eq_status = 'K' and pos('TSN', eq_type) > 0")
	dw_list.filter()
	dw_list.sort()
	uo_radius_ship.of_unapplied()
end if
end event

type rb_100 from radiobutton within w_equip_base
event clicked pbm_bnclicked
int X=69
int Y=104
int Width=640
int Height=76
string Text="DRIVERS"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_list from datawindow within w_equip_base
int X=18
int Y=540
int Width=3593
int Height=1316
string DataObject="d_equip_list"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]

if upper(dwo.type) = "DATAWINDOW" then
	lsa_parm_labels[1] = "MENU_TYPE"
	laa_parm_values[1] = "PRINT"
	lsa_parm_labels[2] = "PRINT_OBJECT"
	laa_parm_values[2] = this

	lsa_Parm_Labels [3] = "ADD_ITEM"
	laa_Parm_Values [3] = "E&xport"

	CHOOSE CASE f_pop_standard(lsa_parm_labels, laa_parm_values)

	CASE "EXPORT"
		dw_List.SaveAs ( )

	END CHOOSE

end if
end event

event constructor;n_cst_Dws		lnv_Dws
n_cst_Events	lnv_Events

lnv_Dws.of_CreateHighlight ( This )

This.Modify ( "curev_type.Edit.CodeTable = Yes "+&
	"curev_type.Values = '" + lnv_Events.of_GetTypeCodeTable ( ) + "'" )
end event

event rowfocuschanged;This.Post SetRedraw ( TRUE )  //To force redraw of highlight
end event

event rowfocuschanging;This.SetRedraw ( FALSE )  //Needed for proper redraw of highlight
end event

type gb_type from groupbox within w_equip_base
int X=27
int Y=24
int Width=805
int Height=424
string Text="Display"
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

