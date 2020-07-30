$PBExportHeader$w_sched_type.srw
$PBExportComments$PTLOG.
forward
global type w_sched_type from Window
end type
type cb_ok from commandbutton within w_sched_type
end type
type cb_cancel from commandbutton within w_sched_type
end type
type rb_seventy from radiobutton within w_sched_type
end type
type rb_sixty from radiobutton within w_sched_type
end type
type mle_text from multilineedit within w_sched_type
end type
type gb_1 from groupbox within w_sched_type
end type
end forward

global type w_sched_type from Window
int X=851
int Y=701
int Width=965
int Height=841
boolean TitleBar=true
string Title="Select Rule Set"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_ok cb_ok
cb_cancel cb_cancel
rb_seventy rb_seventy
rb_sixty rb_sixty
mle_text mle_text
gb_1 gb_1
end type
global w_sched_type w_sched_type

type variables
protected:
integer sched_type
end variables

on w_sched_type.create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.rb_seventy=create rb_seventy
this.rb_sixty=create rb_sixty
this.mle_text=create mle_text
this.gb_1=create gb_1
this.Control[]={ this.cb_ok,&
this.cb_cancel,&
this.rb_seventy,&
this.rb_sixty,&
this.mle_text,&
this.gb_1}
end on

on w_sched_type.destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.rb_seventy)
destroy(this.rb_sixty)
destroy(this.mle_text)
destroy(this.gb_1)
end on

event close;//closewithreturn(this, sched_type)
message.doubleparm = sched_type


end event

event open;if isnull(message.stringparm) or len(trim(message.stringparm)) = 0 then 
	mle_text.text = "No rule set has been specified for the selected driver.  Please choose a rule set."
else
	mle_text.text = "No rule set has been specified for " + message.stringparm + ".  Please choose a rule set."
end if

end event

type cb_ok from commandbutton within w_sched_type
int X=147
int Y=625
int Width=289
int Height=89
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if rb_sixty.checked = true then
	sched_type = 7
else
	sched_type = 8
end if
close(parent)




end event

type cb_cancel from commandbutton within w_sched_type
int X=490
int Y=625
int Width=289
int Height=89
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//sched_type = 0
close(parent)


end event

type rb_seventy from radiobutton within w_sched_type
int X=211
int Y=477
int Width=540
int Height=77
string Text="70 Hr / 8 Days "
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_sixty from radiobutton within w_sched_type
int X=211
int Y=385
int Width=490
int Height=77
string Text="60 Hr / 7 Days "
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_text from multilineedit within w_sched_type
int X=33
int Y=29
int Width=874
int Height=285
BorderStyle BorderStyle=StyleLowered!
boolean DisplayOnly=true
string Text="No rule set has been entered for SCHIRMACKERS, RAYMONGD.  Please choose a rule set."
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_sched_type
int X=33
int Y=317
int Width=874
int Height=261
int TabOrder=10
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

