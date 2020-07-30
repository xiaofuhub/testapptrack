$PBExportHeader$w_autogen_progress.srw
forward
global type w_autogen_progress from w_popup
end type
type st_1 from statictext within w_autogen_progress
end type
type sle_1 from singlelineedit within w_autogen_progress
end type
type st_2 from statictext within w_autogen_progress
end type
type cb_1 from commandbutton within w_autogen_progress
end type
end forward

global type w_autogen_progress from w_popup
int X=585
int Y=788
int Width=2272
int Height=732
long BackColor=80269524
boolean ControlMenu=false
st_1 st_1
sle_1 sle_1
st_2 st_2
cb_1 cb_1
end type
global w_autogen_progress w_autogen_progress

type variables
w_settlementbatchmanager	iw_batchmgr
end variables

forward prototypes
public subroutine wf_updateprogress (string as_value)
end prototypes

public subroutine wf_updateprogress (string as_value);if len(trim(as_value)) > 0 then
	sle_1.text = as_value
end if
end subroutine

on w_autogen_progress.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.st_2=create st_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_1
end on

on w_autogen_progress.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.cb_1)
end on

event open;call super::open;iw_batchmgr = message.powerobjectparm

end event

type st_1 from statictext within w_autogen_progress
int X=37
int Y=64
int Width=1001
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Now Auto Generating Settlements for..."
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

type sle_1 from singlelineedit within w_autogen_progress
int X=1042
int Y=48
int Width=1143
int Height=92
boolean Enabled=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_autogen_progress
int X=37
int Y=228
int Width=2016
int Height=172
boolean Enabled=false
boolean BringToTop=true
string Text="Click the stop button if you would like to stop the Generation process after the driver currently being settled ?"
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

type cb_1 from commandbutton within w_autogen_progress
int X=965
int Y=456
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Stop"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if isvalid(iw_batchmgr) then
	iw_batchmgr.TriggerEvent("ue_cancelautogen")
end if
Close(Parent)
end event

