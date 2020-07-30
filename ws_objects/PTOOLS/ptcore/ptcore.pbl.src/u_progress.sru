$PBExportHeader$u_progress.sru
$PBExportComments$PTCORE.
forward
global type u_progress from UserObject
end type
type st_tag from statictext within u_progress
end type
type r_back from rectangle within u_progress
end type
type r_fill from rectangle within u_progress
end type
end forward

global type u_progress from UserObject
int Width=906
int Height=293
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
st_tag st_tag
r_back r_back
r_fill r_fill
end type
global u_progress u_progress

forward prototypes
public function integer fill_width (decimal fill_amount)
end prototypes

public function integer fill_width (decimal fill_amount);/*  The arguement "fill_amount" represents how much of the total space should be filled.  
	Zero = invisible 
	One  = all  
	1/2  = half
	etc.
---------------------------------- */


if isnull(fill_amount) or fill_amount <= 0 then
	r_fill.width = 0
elseif fill_amount < 1 then 
	r_fill.width = round( fill_amount * (r_back.width - 9), 0)
else
	r_fill.width = r_back.width - 9
end if

return 0


end function

on u_progress.create
this.st_tag=create st_tag
this.r_back=create r_back
this.r_fill=create r_fill
this.Control[]={ this.st_tag,&
this.r_back,&
this.r_fill}
end on

on u_progress.destroy
destroy(this.st_tag)
destroy(this.r_back)
destroy(this.r_fill)
end on

type st_tag from statictext within u_progress
int X=206
int Y=57
int Width=485
int Height=77
boolean Enabled=false
string Text="Progress . . . "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_back from rectangle within u_progress
int X=60
int Y=145
int Width=773
int Height=85
boolean Enabled=false
int LineThickness=5
long FillColor=12632256
end type

type r_fill from rectangle within u_progress
int X=69
int Y=149
int Width=759
int Height=81
boolean Enabled=false
LineStyle LineStyle=transparent!
int LineThickness=5
long FillColor=65535
end type

