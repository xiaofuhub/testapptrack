$PBExportHeader$w_updateprogress.srw
forward
global type w_updateprogress from w_popup
end type
type st_1 from statictext within w_updateprogress
end type
end forward

global type w_updateprogress from w_popup
int X=965
int Y=980
int Width=1413
int Height=444
boolean TitleBar=true
string Title="Company Locator Update"
st_1 st_1
end type
global w_updateprogress w_updateprogress

forward prototypes
public subroutine wf_setstatus (string as_status)
end prototypes

public subroutine wf_setstatus (string as_status);st_1.text=as_status
end subroutine

on w_updateprogress.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_updateprogress.destroy
call super::destroy
destroy(this.st_1)
end on

type st_1 from statictext within w_updateprogress
int X=114
int Y=88
int Width=1125
int Height=124
boolean Enabled=false
boolean BringToTop=true
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

