$PBExportHeader$w_about_trucking.srw
forward
global type w_about_trucking from Window
end type
type cb_ok from commandbutton within w_about_trucking
end type
type st_4 from statictext within w_about_trucking
end type
type mle_1 from multilineedit within w_about_trucking
end type
type st_copyright from statictext within w_about_trucking
end type
type st_version from statictext within w_about_trucking
end type
type st_2 from statictext within w_about_trucking
end type
type dw_co_name from datawindow within w_about_trucking
end type
end forward

global type w_about_trucking from Window
int X=1024
int Y=716
int Width=1623
int Height=972
boolean TitleBar=true
string Title="Profit Tools Program Information"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_ok cb_ok
st_4 st_4
mle_1 mle_1
st_copyright st_copyright
st_version st_version
st_2 st_2
dw_co_name dw_co_name
end type
global w_about_trucking w_about_trucking

on w_about_trucking.create
this.cb_ok=create cb_ok
this.st_4=create st_4
this.mle_1=create mle_1
this.st_copyright=create st_copyright
this.st_version=create st_version
this.st_2=create st_2
this.dw_co_name=create dw_co_name
this.Control[]={this.cb_ok,&
this.st_4,&
this.mle_1,&
this.st_copyright,&
this.st_version,&
this.st_2,&
this.dw_co_name}
end on

on w_about_trucking.destroy
destroy(this.cb_ok)
destroy(this.st_4)
destroy(this.mle_1)
destroy(this.st_copyright)
destroy(this.st_version)
destroy(this.st_2)
destroy(this.dw_co_name)
end on

type cb_ok from commandbutton within w_about_trucking
int X=672
int Y=736
int Width=247
int Height=88
int TabOrder=10
string Text="OK"
boolean Default=true
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type st_4 from statictext within w_about_trucking
int X=32
int Y=516
int Width=667
int Height=76
boolean Enabled=false
string Text="This copy is licensed to:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_about_trucking
int X=32
int Y=256
int Width=1531
int Height=212
BorderStyle BorderStyle=StyleLowered!
boolean DisplayOnly=true
string Text="PowerBuilder ® and Sybase SQL Anywhere ™ Runtime Components Copyright © Sybase, Inc. and its subsidiaries. Portions Copyright © Tenberry Software, Inc. 1992-5."
string Pointer="Arrow!"
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;cb_ok.setfocus()
end event

type st_copyright from statictext within w_about_trucking
int X=50
int Y=120
int Width=1486
int Height=76
boolean Enabled=false
string Text="CopyRight"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;This.Text = gnv_App.of_GetCopyRight ( )
end event

type st_version from statictext within w_about_trucking
int X=50
int Y=60
int Width=1486
int Height=76
boolean Enabled=false
string Text="AppVersionName"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;This.Text = gnv_App.of_GetAppVersionName ( )
end event

type st_2 from statictext within w_about_trucking
int X=32
int Y=44
int Width=1531
int Height=156
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_co_name from datawindow within w_about_trucking
int X=37
int Y=592
int Width=1563
int Height=88
boolean Enabled=false
string DataObject="d_noamp_st"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;n_cst_LicenseManager	lnv_LicenseManager

This.Object.text_val.Width = 1520
This.Object.text_val [1] = lnv_LicenseManager.of_GetLicensedCompany ( )
end event

