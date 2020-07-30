$PBExportHeader$w_upgrade.srw
forward
global type w_upgrade from w_master
end type
type st_message from statictext within w_upgrade
end type
end forward

global type w_upgrade from w_master
int Width=1481
int Height=464
WindowType WindowType=popup!
boolean Visible=false
boolean TitleBar=true
string Title="DataBase Upgrading"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
st_message st_message
end type
global w_upgrade w_upgrade

on w_upgrade.create
int iCurrent
call super::create
this.st_message=create st_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_message
end on

on w_upgrade.destroy
call super::destroy
destroy(this.st_message)
end on

event open;call super::open;this.of_SetBase( TRUE )
this.inv_base.of_Center( )
end event

type st_message from statictext within w_upgrade
int X=87
int Y=68
int Width=1275
int Height=244
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

