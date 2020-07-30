$PBExportHeader$w_log_printing.srw
forward
global type w_log_printing from Window
end type
type cb_print from commandbutton within w_log_printing
end type
type rb_month from radiobutton within w_log_printing
end type
type rb_displayed from radiobutton within w_log_printing
end type
type rb_daily from radiobutton within w_log_printing
end type
type sle_num_copies from singlelineedit within w_log_printing
end type
type st_num from statictext within w_log_printing
end type
type uo_month from u_month within w_log_printing
end type
type gb_1 from groupbox within w_log_printing
end type
end forward

global type w_log_printing from Window
int X=407
int Y=277
int Width=924
int Height=653
boolean TitleBar=true
string Title="Print Options"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=child!
cb_print cb_print
rb_month rb_month
rb_displayed rb_displayed
rb_daily rb_daily
sle_num_copies sle_num_copies
st_num st_num
uo_month uo_month
gb_1 gb_1
end type
global w_log_printing w_log_printing

type variables
public:
w_log w_par
integer numcop
date startdate, stopdate
end variables

forward prototypes
public function integer u_month_function (date curdate)
end prototypes

public function integer u_month_function (date curdate);return 0
end function

on w_log_printing.create
this.cb_print=create cb_print
this.rb_month=create rb_month
this.rb_displayed=create rb_displayed
this.rb_daily=create rb_daily
this.sle_num_copies=create sle_num_copies
this.st_num=create st_num
this.uo_month=create uo_month
this.gb_1=create gb_1
this.Control[]={ this.cb_print,&
this.rb_month,&
this.rb_displayed,&
this.rb_daily,&
this.sle_num_copies,&
this.st_num,&
this.uo_month,&
this.gb_1}
end on

on w_log_printing.destroy
destroy(this.cb_print)
destroy(this.rb_month)
destroy(this.rb_displayed)
destroy(this.rb_daily)
destroy(this.sle_num_copies)
destroy(this.st_num)
destroy(this.uo_month)
destroy(this.gb_1)
end on

event open;w_par = message.powerobjectparm

this.x = 300
this.y = 300

rb_daily.checked = true
rb_daily.triggerevent(clicked!)

sle_num_copies.text = "1"

uo_month.w_mainpar = this
end event

event closequery;if w_par.win_is_closing = true then
	return 0
else
	hide(this)
	return 1
end if

end event

type cb_print from commandbutton within w_log_printing
int X=558
int Y=453
int Width=279
int Height=89
int TabOrder=40
string Text="Print"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//sle_num_copies.triggerevent(modified!)
if not isnumber(sle_num_copies.text) or sle_num_copies.text = "0" then
	messagebox("Print Request", "Please enter the number of copies to print.")
	sle_num_copies.setfocus()
	return
end if

numcop = integer(sle_num_copies.text) 

if rb_daily.checked = true then
	w_par.cb_daily.postevent(clicked!)
elseif rb_displayed.checked = true then
	w_par.cb_log_print.postevent(clicked!)
elseif rb_month.checked = true then
	uo_month.sle_year.triggerevent(modified!) 
	date curdate
	curdate = null_date
	if isnumber(uo_month.sle_year.text) and &
		uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0) > 0 then
		curdate = date(string(uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0)) +&
			"/1/" + uo_month.sle_year.text)
	end if
	if isnull(curdate) then 
		messagebox("Print Request", "Please enter a date.")
		return
	else
		startdate = curdate
		if month(startdate) = 12 then 	
			stopdate = date("1/1/" + string(year(startdate) + 1) )
		else 	
			stopdate = date( string(month(startdate) + 1) + "/1/" + string(year(startdate)) ) 
		end if
	end if
//	else
//		sle_bdate.triggerevent(modified!)
//		sle_edate.triggerevent(modified!)
//		if not isdate(sle_bdate.text) or not isdate(sle_edate.text) then
//			essagebox("Invalid Data", "The current dates are not valid.")
//			return
//		end if
//		startdate = date(sle_bdate.text)
//		stopdate = date(sle_edate.text)
//		if startdate >= stopdate then 
//			essagebox("Invalid Data", "The current dates are not valid.")
//			return
//		end if
//	end if
	w_par.cb_list_print.postevent(clicked!)
end if



end event

type rb_month from radiobutton within w_log_printing
int X=69
int Y=225
int Width=586
int Height=77
string Text="Print Month Totals "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uo_month.enabled = true
uo_month.sle_year.enabled = true
uo_month.ddlb_month.enabled = true

end event

type rb_displayed from radiobutton within w_log_printing
int X=69
int Y=141
int Width=741
int Height=77
string Text="Print Log Only "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uo_month.enabled = false
uo_month.sle_year.enabled = false
uo_month.ddlb_month.enabled = false



end event

type rb_daily from radiobutton within w_log_printing
int X=69
int Y=57
int Width=746
int Height=77
string Text="Print Daily Summary "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uo_month.enabled = false
uo_month.sle_year.enabled = false
uo_month.ddlb_month.enabled = false





end event

type sle_num_copies from singlelineedit within w_log_printing
event lbuttondown pbm_lbuttondown
int X=357
int Y=453
int Width=142
int Height=85
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;this.setfocus()
end event

event modified;if len(trim(sle_num_copies.text)) = 0 then 
elseif not isnumber(sle_num_copies.text) then
	sle_num_copies.text = ""
else
	this.text = string(abs(round(dec(this.text), 0)))
	if integer(this.text) > 99 then this.text = ""
end if


end event

event getfocus;this.selecttext(1, len(trim(this.text)))
end event

type st_num from statictext within w_log_printing
int X=33
int Y=457
int Width=316
int Height=77
boolean Enabled=false
boolean BringToTop=true
string Text="# of Copies:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_month from u_month within w_log_printing
event destroy ( )
int X=142
int Y=305
int Height=89
int TabOrder=20
boolean BringToTop=true
end type

on uo_month.destroy
call u_month::destroy
end on

type gb_1 from groupbox within w_log_printing
int X=28
int Width=846
int Height=425
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

