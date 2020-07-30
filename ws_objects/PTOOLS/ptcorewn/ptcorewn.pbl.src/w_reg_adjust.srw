$PBExportHeader$w_reg_adjust.srw
forward
global type w_reg_adjust from w_reg_base
end type
type st_screen_label from statictext within w_reg_adjust
end type
end forward

global type w_reg_adjust from w_reg_base
st_screen_label st_screen_label
end type
global w_reg_adjust w_reg_adjust

event open;call super::open;mle_instruct.text = "This screen will allow you to enter a registration key that will extend the registration date of your system.  If you wish to perform this function, please contact Profit Tools at (603) 659-3822 during East Coast business hours    to obtain your key."

wf_SetValues ( )
end event

on w_reg_adjust.create
int iCurrent
call w_reg_base::create
this.st_screen_label=create st_screen_label
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_screen_label
end on

on w_reg_adjust.destroy
call w_reg_base::destroy
destroy(this.st_screen_label)
end on

type st_screen_label from statictext within w_reg_adjust
int X=833
int Y=101
int Width=1157
int Height=113
boolean Enabled=false
boolean BringToTop=true
string Text="System Registration"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

