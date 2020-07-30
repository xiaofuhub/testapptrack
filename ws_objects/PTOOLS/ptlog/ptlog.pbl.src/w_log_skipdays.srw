$PBExportHeader$w_log_skipdays.srw
forward
global type w_log_skipdays from Window
end type
type cb_cancel from commandbutton within w_log_skipdays
end type
type cb_accept from commandbutton within w_log_skipdays
end type
type sle_date from singlelineedit within w_log_skipdays
end type
type st_1 from statictext within w_log_skipdays
end type
type ddlb_jump from dropdownlistbox within w_log_skipdays
end type
end forward

global type w_log_skipdays from Window
int X=1161
int Y=564
int Width=864
int Height=420
boolean TitleBar=true
string Title="Skip Logs"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_cancel cb_cancel
cb_accept cb_accept
sle_date sle_date
st_1 st_1
ddlb_jump ddlb_jump
end type
global w_log_skipdays w_log_skipdays

type variables
protected:
w_log w_par
date lastdate
boolean notify = true, forced_close
end variables

event open;this.x = 1162
this.y = 565

w_par = message.powerobjectparm

lastdate = w_par.dw_log_list.getitemdate(w_par.dw_log_list.rowcount(), "dl_date")
this.title = "Last Log:  " + string(lastdate, "m/d/yy")

ddlb_jump.selectitem(0)
sle_date.setfocus()
end event

on w_log_skipdays.create
this.cb_cancel=create cb_cancel
this.cb_accept=create cb_accept
this.sle_date=create sle_date
this.st_1=create st_1
this.ddlb_jump=create ddlb_jump
this.Control[]={this.cb_cancel,&
this.cb_accept,&
this.sle_date,&
this.st_1,&
this.ddlb_jump}
end on

on w_log_skipdays.destroy
destroy(this.cb_cancel)
destroy(this.cb_accept)
destroy(this.sle_date)
destroy(this.st_1)
destroy(this.ddlb_jump)
end on

event closequery;if not forced_close then message.stringparm = null_str
end event

type cb_cancel from commandbutton within w_log_skipdays
int X=471
int Y=204
int Width=279
int Height=88
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;forced_close = true
closewithreturn(parent, null_str)


end event

type cb_accept from commandbutton within w_log_skipdays
int X=142
int Y=204
int Width=279
int Height=88
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_LicenseManager	lnv_LicenseManager

if len(trim(sle_date.text)) = 0 then 
	messagebox("Skip Logs", "Please enter the date you want to skip to.")
	sle_date.setfocus()
	return 
elseif not isdate(sle_date.text) then
	return
elseif date(sle_date.text) <= lastdate then
	messagebox("Skip Logs", "Please enter a date that occurs after the last log entered.")
	sle_date.setfocus()
	return 
elseif date(sle_date.text) > lnv_LicenseManager.of_GetLicenseExpiration ( ) then
	messagebox("Skip Logs", lnv_LicenseManager.of_GetExpirationNotice ( ) +&
		"You cannot skip past this date.")
	sle_date.setfocus()
	return 
end if

forced_close = true
closewithreturn(parent, sle_date.text)




end event

type sle_date from singlelineedit within w_log_skipdays
event lbuttondown pbm_lbuttondown
int X=498
int Y=44
int Width=311
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;this.setfocus()


end event

event modified;n_cst_String	lnv_String
date newdate

if len(trim(this.text)) = 0 then
	this.text = ""
	return
end if

newdate = lnv_String.of_SpecialDate ( this.text )
if isnull(newdate) then return

sle_date.text = string(newdate, "m/d/yy")

end event

event getfocus;this.selecttext(1, len(this.text))
end event

event rbuttondown;n_cst_LicenseManager	lnv_LicenseManager

this.setfocus()
s_date_return pickdate

pickdate.mindate = relativedate(lastdate, 1)
pickdate.maxdate = relativedate(lnv_LicenseManager.of_GetLicenseExpiration ( ), -1)

pickdate.tag = "Choose a Skip Date"

notify = false
openwithparm(w_choose_day, pickdate)
notify = true

if isdate(message.stringparm) then
	this.text = string(date(message.stringparm), "m/d/yy")
	this.selecttext(1, len(this.text))
end if


end event

event losefocus;if getfocus() = cb_cancel or notify = false then return

if len(trim(this.text)) > 0 then
	if not isdate(this.text) then
		beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
	end if
end if
end event

type st_1 from statictext within w_log_skipdays
int X=27
int Y=56
int Width=384
int Height=72
boolean Enabled=false
string Text="Skip to Date:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_jump from dropdownlistbox within w_log_skipdays
int X=23
int Y=44
int Width=457
int Height=344
BorderStyle BorderStyle=StyleRaised!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Skip 7 Days",&
"Skip 14 Days",&
"Skip 1 Month"}
end type

event selectionchanged;if nullornotpos(index) then return
date newdate
choose case index
	case 1
		newdate = relativedate(lastdate, 7)
	case 2
		newdate = relativedate(lastdate, 14)
	case 3
		newdate = relativedate(lastdate, 30)
end choose

this.selectitem(0)
sle_date.text = string(newdate, "m/d/yy")




end event

