$PBExportHeader$w_selectautoroutestyle.srw
forward
global type w_selectautoroutestyle from w_response
end type
type cb_1 from u_cbok within w_selectautoroutestyle
end type
type cb_2 from u_cbcancel within w_selectautoroutestyle
end type
type em_leg from editmask within w_selectautoroutestyle
end type
type st_1 from statictext within w_selectautoroutestyle
end type
type mle_1 from multilineedit within w_selectautoroutestyle
end type
type gb_1 from groupbox within w_selectautoroutestyle
end type
type rb_any from radiobutton within w_selectautoroutestyle
end type
type rb_pickup from radiobutton within w_selectautoroutestyle
end type
type rb_deliver from radiobutton within w_selectautoroutestyle
end type
type st_2 from statictext within w_selectautoroutestyle
end type
type rb_none from radiobutton within w_selectautoroutestyle
end type
end forward

global type w_selectautoroutestyle from w_response
int X=1486
int Y=544
int Width=933
int Height=1192
boolean TitleBar=true
string Title="Select Leg"
cb_1 cb_1
cb_2 cb_2
em_leg em_leg
st_1 st_1
mle_1 mle_1
gb_1 gb_1
rb_any rb_any
rb_pickup rb_pickup
rb_deliver rb_deliver
st_2 st_2
rb_none rb_none
end type
global w_selectautoroutestyle w_selectautoroutestyle

on w_selectautoroutestyle.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.em_leg=create em_leg
this.st_1=create st_1
this.mle_1=create mle_1
this.gb_1=create gb_1
this.rb_any=create rb_any
this.rb_pickup=create rb_pickup
this.rb_deliver=create rb_deliver
this.st_2=create st_2
this.rb_none=create rb_none
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.em_leg
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.mle_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.rb_any
this.Control[iCurrent+8]=this.rb_pickup
this.Control[iCurrent+9]=this.rb_deliver
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.rb_none
end on

on w_selectautoroutestyle.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.em_leg)
destroy(this.st_1)
destroy(this.mle_1)
destroy(this.gb_1)
destroy(this.rb_any)
destroy(this.rb_pickup)
destroy(this.rb_deliver)
destroy(this.st_2)
destroy(this.rb_none)
end on

event pfc_default;n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
Integer	li_LegSelection
String	ls_RouteType

li_LegSelection = Integer ( em_Leg.Text )
lstr_Parm.is_Label = "Leg"
lstr_Parm.ia_Value = li_LegSelection
lnv_Msg.of_Add_Parm ( lstr_Parm )

IF rb_Any.Checked THEN
	ls_RouteType = gc_Dispatch.cs_RouteType_Any

ELSEIF rb_Pickup.Checked THEN
	ls_RouteType = gc_Dispatch.cs_RouteType_Pickup

ELSEIF rb_Deliver.Checked THEN
	ls_RouteType = gc_Dispatch.cs_RouteType_Deliver

ELSE
	SetNull ( ls_RouteType )

END IF


IF NOT IsNull ( ls_RouteType ) THEN

	lstr_Parm.is_Label = "RouteType"
	lstr_Parm.ia_Value = ls_RouteType
	lnv_Msg.of_Add_Parm ( lstr_Parm )

END If

CloseWithReturn ( This, lnv_Msg )
end event

event pfc_cancel;call super::pfc_cancel;Close ( This )
end event

event open;call super::open;n_cst_LicenseManager	lnv_LicenseManager
Boolean	lb_RouteManagerLicensed

lb_RouteManagerLicensed = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_RouteManager )

//Enable or Disable Route Type Selection based on whether Route Manager is licensed.

IF lb_RouteManagerLicensed = FALSE THEN
	rb_None.Checked = TRUE
END IF
rb_Any.Enabled = lb_RouteManagerLicensed
rb_Pickup.Enabled = lb_RouteManagerLicensed
rb_Deliver.Enabled = lb_RouteManagerLicensed
rb_None.Enabled = lb_RouteManagerLicensed
end event

type cb_1 from u_cbok within w_selectautoroutestyle
int X=178
int Y=956
int TabOrder=30
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_selectautoroutestyle
int X=489
int Y=956
int TabOrder=40
boolean BringToTop=true
end type

type em_leg from editmask within w_selectautoroutestyle
int X=494
int Y=460
int Width=183
int Height=76
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="#0"
boolean Spin=true
string MinMax="1~~"
string Text="0"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;This.SelectText ( 1, Len ( This.Text ) )
end event

type st_1 from statictext within w_selectautoroutestyle
int X=279
int Y=464
int Width=183
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Leg # :"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_selectautoroutestyle
int X=55
int Y=24
int Width=805
int Height=352
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Text="Select which leg you want to Auto-Route, and which Route Types you want to search for.  Selecting Leg ~"0~" will Route all legs to one truck."
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_selectautoroutestyle
int X=55
int Y=400
int Width=805
int Height=500
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_any from radiobutton within w_selectautoroutestyle
int X=485
int Y=576
int Width=315
int Height=76
boolean BringToTop=true
string Text="&Any"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_pickup from radiobutton within w_selectautoroutestyle
int X=485
int Y=648
int Width=315
int Height=76
boolean BringToTop=true
string Text="&Pickup"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_deliver from radiobutton within w_selectautoroutestyle
int X=485
int Y=720
int Width=315
int Height=76
boolean BringToTop=true
string Text="&Deliver"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_selectautoroutestyle
int X=87
int Y=580
int Width=389
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Route Lookup: "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_none from radiobutton within w_selectautoroutestyle
int X=485
int Y=796
int Width=315
int Height=76
boolean BringToTop=true
string Text="&None"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

