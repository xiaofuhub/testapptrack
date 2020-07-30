$PBExportHeader$w_savedataview.srw
forward
global type w_savedataview from w_response
end type
type sle_1 from singlelineedit within w_savedataview
end type
type st_1 from statictext within w_savedataview
end type
type st_2 from statictext within w_savedataview
end type
type cb_1 from u_cbok within w_savedataview
end type
type cb_2 from u_cbcancel within w_savedataview
end type
end forward

global type w_savedataview from w_response
int X=837
int Y=1180
int Width=1161
int Height=384
boolean TitleBar=true
string Title="Save Your Data View"
boolean ControlMenu=false
sle_1 sle_1
st_1 st_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
end type
global w_savedataview w_savedataview

on w_savedataview.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
end on

on w_savedataview.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event pfc_default;String ls_Name 
n_cst_ReturnAttrib	lnv_RtnAttrib

ls_Name = Trim ( sle_1.Text )
IF Len ( ls_Name ) = 0 THEN
	Beep ( 1 ) 
	sle_1.SetFocus ( )
ELSE

	IF Match ( ls_Name , "[\/:*?~"<>|]" ) THEN
		MessageBox ( "File Name" , "A file name cannot contain any of the following characters:~n~r~t \ / : * ? ~" < > |" , StopSign! )
	ELSE
		lnv_RtnAttrib.ii_rc = 1
		lnv_RtnAttrib.is_rs = ls_Name
		CloseWithReturn ( THIS , lnv_RtnAttrib )
	END IF
END IF
end event

event pfc_cancel;call super::pfc_cancel;n_cst_ReturnAttrib	lnv_RtnAttrib
lnv_RtnAttrib.ii_rc = 0

CloseWithReturn ( THIS , lnv_RtnAttrib )
end event

event open;call super::open;String ls_FileName

ls_FileName = Message.StringParm

sle_1.Text = ls_FileName
end event

type sle_1 from singlelineedit within w_savedataview
int X=32
int Y=176
int Width=759
int Height=88
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean HideSelection=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;THIS.SelectText ( 1, Len ( THIS.Text ) )
end event

type st_1 from statictext within w_savedataview
int X=37
int Y=20
int Width=750
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="What do you want to call"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_savedataview
int X=37
int Y=84
int Width=750
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="your new Data View ?"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cbok within w_savedataview
int X=837
int Y=52
int Width=270
int TabOrder=30
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_savedataview
int X=837
int Y=176
int Width=270
int TabOrder=20
boolean BringToTop=true
end type

