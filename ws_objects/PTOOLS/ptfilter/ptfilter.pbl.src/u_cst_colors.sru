$PBExportHeader$u_cst_colors.sru
forward
global type u_cst_colors from UserObject
end type
type st_16 from statictext within u_cst_colors
end type
type st_15 from statictext within u_cst_colors
end type
type st_14 from statictext within u_cst_colors
end type
type st_13 from statictext within u_cst_colors
end type
type st_12 from statictext within u_cst_colors
end type
type st_11 from statictext within u_cst_colors
end type
type st_10 from statictext within u_cst_colors
end type
type st_9 from statictext within u_cst_colors
end type
type st_8 from statictext within u_cst_colors
end type
type st_7 from statictext within u_cst_colors
end type
type st_6 from statictext within u_cst_colors
end type
type st_5 from statictext within u_cst_colors
end type
type st_4 from statictext within u_cst_colors
end type
type st_3 from statictext within u_cst_colors
end type
type st_2 from statictext within u_cst_colors
end type
type st_1 from statictext within u_cst_colors
end type
end forward

global type u_cst_colors from UserObject
int Width=457
int Height=356
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_colorchanged ( long al_color )
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global u_cst_colors u_cst_colors

type variables
String is_SelectedColor
end variables

on u_cst_colors.create
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_16,&
this.st_15,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on u_cst_colors.destroy
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type st_16 from statictext within u_cst_colors
int X=334
int Y=256
int Width=91
int Height=68
int TabOrder=160
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16711935
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_15 from statictext within u_cst_colors
int X=334
int Y=176
int Width=91
int Height=68
int TabOrder=120
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16776960
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_14 from statictext within u_cst_colors
int X=334
int Y=96
int Width=91
int Height=68
int TabOrder=80
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=65535
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_13 from statictext within u_cst_colors
int X=334
int Y=16
int Width=91
int Height=68
int TabOrder=40
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_12 from statictext within u_cst_colors
int X=229
int Y=256
int Width=91
int Height=68
int TabOrder=150
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=8388736
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_11 from statictext within u_cst_colors
int X=229
int Y=176
int Width=91
int Height=68
int TabOrder=110
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_10 from statictext within u_cst_colors
int X=229
int Y=96
int Width=91
int Height=68
int TabOrder=70
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=32896
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_9 from statictext within u_cst_colors
int X=229
int Y=16
int Width=91
int Height=68
int TabOrder=30
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_8 from statictext within u_cst_colors
int X=123
int Y=256
int Width=91
int Height=68
int TabOrder=140
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=16711680
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_7 from statictext within u_cst_colors
int X=123
int Y=176
int Width=91
int Height=68
int TabOrder=100
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=65280
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_6 from statictext within u_cst_colors
int X=123
int Y=96
int Width=91
int Height=68
int TabOrder=60
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_5 from statictext within u_cst_colors
int X=123
int Y=16
int Width=91
int Height=68
int TabOrder=20
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=8421504
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_4 from statictext within u_cst_colors
int X=18
int Y=256
int Width=91
int Height=68
int TabOrder=130
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=8388608
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_3 from statictext within u_cst_colors
int X=18
int Y=176
int Width=91
int Height=68
int TabOrder=90
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=32768
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_2 from statictext within u_cst_colors
int X=18
int Y=96
int Width=91
int Height=68
int TabOrder=50
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=128
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

type st_1 from statictext within u_cst_colors
int X=18
int Y=16
int Width=91
int Height=68
int TabOrder=10
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;Parent.Event ue_ColorChanged ( THIS.BackColor )
end event

