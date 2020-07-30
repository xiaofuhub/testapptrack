$PBExportHeader$u_cst_setting_text.sru
forward
global type u_cst_setting_text from u_cst_setting
end type
type mle_value from multilineedit within u_cst_setting_text
end type
end forward

global type u_cst_setting_text from u_cst_setting
int Height=353
mle_value mle_value
end type
global u_cst_setting_text u_cst_setting_text

forward prototypes
private subroutine of_populate ()
end prototypes

private subroutine of_populate ();mle_Value.Text = of_GetDisplayValue ( )
end subroutine

on u_cst_setting_text.create
int iCurrent
call u_cst_setting::create
this.mle_value=create mle_value
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=mle_value
end on

on u_cst_setting_text.destroy
call u_cst_setting::destroy
destroy(this.mle_value)
end on

type mle_value from multilineedit within u_cst_setting_text
int Y=89
int Width=1505
int Height=233
int TabOrder=1
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AutoVScroll=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;of_SetValue ( This.Text )
end event

event getfocus;This.SelectText ( 1, Len ( This.Text ) )
end event

