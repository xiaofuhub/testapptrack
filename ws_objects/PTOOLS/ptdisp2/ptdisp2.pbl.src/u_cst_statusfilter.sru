$PBExportHeader$u_cst_statusfilter.sru
forward
global type u_cst_statusfilter from UserObject
end type
type rb_all from radiobutton within u_cst_statusfilter
end type
type rb_restricted from radiobutton within u_cst_statusfilter
end type
type rb_open from radiobutton within u_cst_statusfilter
end type
type gb_1 from groupbox within u_cst_statusfilter
end type
end forward

global type u_cst_statusfilter from UserObject
int Width=1019
int Height=212
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_postselection ( readonly integer ai_selection )
rb_all rb_all
rb_restricted rb_restricted
rb_open rb_open
gb_1 gb_1
end type
global u_cst_statusfilter u_cst_statusfilter

type variables
Constant Integer	ci_Selection_Open = 1
Constant Integer	ci_Selection_Restricted = 2
Constant Integer	ci_Selection_All = 3
end variables

on u_cst_statusfilter.create
this.rb_all=create rb_all
this.rb_restricted=create rb_restricted
this.rb_open=create rb_open
this.gb_1=create gb_1
this.Control[]={this.rb_all,&
this.rb_restricted,&
this.rb_open,&
this.gb_1}
end on

on u_cst_statusfilter.destroy
destroy(this.rb_all)
destroy(this.rb_restricted)
destroy(this.rb_open)
destroy(this.gb_1)
end on

type rb_all from radiobutton within u_cst_statusfilter
int X=718
int Y=76
int Width=247
int Height=76
string Text="&All"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Call the user event so descendants can process the selection
Parent.Event Post ue_PostSelection ( ci_Selection_All )
end event

type rb_restricted from radiobutton within u_cst_statusfilter
int X=315
int Y=76
int Width=393
int Height=76
string Text="&Restricted"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Call the user event so descendants can process the selection
Parent.Event Post ue_PostSelection ( ci_Selection_Restricted )
end event

type rb_open from radiobutton within u_cst_statusfilter
int X=50
int Y=76
int Width=265
int Height=76
string Text="&Open"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Call the user event so descendants can process the selection
Parent.Event Post ue_PostSelection ( ci_Selection_Open )
end event

type gb_1 from groupbox within u_cst_statusfilter
int X=14
int Y=8
int Width=965
int Height=168
int TabOrder=20
string Text="Status"
BorderStyle BorderStyle=StyleLowered!
long TextColor=128
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

