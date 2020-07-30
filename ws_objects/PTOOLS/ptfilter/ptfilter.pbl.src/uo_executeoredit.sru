$PBExportHeader$uo_executeoredit.sru
$PBExportComments$radio buttons
forward
global type uo_executeoredit from UserObject
end type
type rb_execute from radiobutton within uo_executeoredit
end type
type rb_edit from radiobutton within uo_executeoredit
end type
end forward

global type uo_executeoredit from UserObject
int Width=590
int Height=96
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_modechanged ( string as_mode )
rb_execute rb_execute
rb_edit rb_edit
end type
global uo_executeoredit uo_executeoredit

on uo_executeoredit.create
this.rb_execute=create rb_execute
this.rb_edit=create rb_edit
this.Control[]={this.rb_execute,&
this.rb_edit}
end on

on uo_executeoredit.destroy
destroy(this.rb_execute)
destroy(this.rb_edit)
end on

type rb_execute from radiobutton within uo_executeoredit
int X=283
int Width=302
int Height=80
boolean BringToTop=true
string Text="E&xecute"
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

event clicked;IF This.Checked THEN
	EVENT ue_ModeChanged ( "EXECUTE!" )
END IF
end event

type rb_edit from radiobutton within uo_executeoredit
int X=9
int Y=4
int Width=247
int Height=76
boolean BringToTop=true
string Text="E&dit"
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

event clicked;IF This.Checked THEN
	EVENT ue_ModeChanged ( "EDIT!" )
END IF
end event

