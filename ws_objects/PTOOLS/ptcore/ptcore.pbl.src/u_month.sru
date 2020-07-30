$PBExportHeader$u_month.sru
forward
global type u_month from UserObject
end type
type sle_year from singlelineedit within u_month
end type
type ddlb_month from dropdownlistbox within u_month
end type
type vsb_1 from vscrollbar within u_month
end type
end forward

global type u_month from UserObject
int Width=695
int Height=97
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
sle_year sle_year
ddlb_month ddlb_month
vsb_1 vsb_1
end type
global u_month u_month

type variables
public:
window w_mainpar
boolean callfunct = true
end variables

event constructor;/*  There are two things to say about this user_object:  (1) the parent that holds
this user_object must have a function called u_month_function and (2) the parent that
holds this user_object must declare this user_object's instance variable w_mainpar as itself.  

The function "u_month_function" must be present because this function will be 
called when either the year or month is modified.  The purpose of the function is to
let the parent window know when something has been changed.  "U_month_funct" requires
one arguement of type date.  The function sends the currently inputted date or null if
the current date is not a date.  The return values are ignored but you might as well
send a return value of zero in case that changes in the future.

The parent window can determine the chosen date by reaching into the user_object and getting
it or by relying on the function "u_month_function".  The following script is "quick code".  
It is a model of how the parent window script could search the user_object for the date.
(Cut and Paste it.)

*** Recommended that you call a quick uo_month.sle_year.triggerevent(modified!) 
	 before calling these scripts.

If you want the full first date of the picked month then:
		date curdate
		if isnumber(uo_month.sle_year.text) and &
			uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0) > 0 then
			curdate = date(string(uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0)) +&
				"/1/" + uo_month.sle_year.text)
		end if

If you want integers to represent the month and year then:
		integer curmonth, curyear
		if isnumber(uo_month.sle_year.text) and &
			uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0) > 0 then
			curmonth = uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0)
			curyear = integer(uo_month.sle_year.text)
		end if

-----------------------------------------------------------------------------------*/

ddlb_month.selectitem(month(today()))
sle_year.text = string(year(today()))


end event

on u_month.create
this.sle_year=create sle_year
this.ddlb_month=create ddlb_month
this.vsb_1=create vsb_1
this.Control[]={ this.sle_year,&
this.ddlb_month,&
this.vsb_1}
end on

on u_month.destroy
destroy(this.sle_year)
destroy(this.ddlb_month)
destroy(this.vsb_1)
end on

type sle_year from singlelineedit within u_month
event lbuttondown pbm_lbuttondown
int X=412
int Y=5
int Width=234
int Height=85
int TabOrder=20
boolean BringToTop=true
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

event modified;if not isnumber(this.text) then 
	this.text = ""
	this.setfocus()
	return
end if

integer curyear
curyear = abs(round(dec(this.text), 0))

if curyear >= 80 and curyear < 99 then
	curyear += 1900
elseif curyear >= 0 and curyear < 51 then
	curyear += 2000
elseif curyear <= 2050 and curyear >= 1980 then
else
	this.text = ""
	this.setfocus()
	return
end if

this.text = string(curyear)

if callfunct = false then return
//--------------------------------------------------------
date curdate
if isnumber(sle_year.text) and ddlb_month.finditem(ddlb_month.text, 0) > 0 then
	curdate = date(string(ddlb_month.finditem(ddlb_month.text, 0)) +&
		"/1/" + sle_year.text)
else
	setnull(curdate)
end if

if isvalid(w_mainpar) then &
	w_mainpar.function dynamic trigger u_month_function(curdate)



end event

event getfocus;this.selecttext(1, len(this.text))
end event

type ddlb_month from dropdownlistbox within u_month
int Y=5
int Width=435
int Height=777
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"January",&
"February",&
"March",&
"April",&
"May",&
"June",&
"July",&
"August",&
"September",&
"October",&
"November",&
"December"}
end type

event selectionchanged;//--------------------------------------------------------
date curdate
if isnumber(sle_year.text) and ddlb_month.finditem(ddlb_month.text, 0) > 0 then
	curdate = date(string(ddlb_month.finditem(ddlb_month.text, 0)) +&
		"/1/" + sle_year.text)
else
	setnull(curdate)
end if

if isvalid(w_mainpar) then &
	w_mainpar.function dynamic trigger u_month_function(curdate)



end event

type vsb_1 from vscrollbar within u_month
int X=631
int Width=60
int Height=89
boolean Enabled=false
boolean BringToTop=true
boolean StdWidth=false
end type

event lineup;callfunct = false
sle_year.triggerevent(modified!)
callfunct = true

if sle_year.text = "" then
	sle_year.text = string(year(today()))
	return
elseif not isnumber(sle_year.text) then 
	return
end if

integer curyear

curyear = integer(sle_year.text)
if curyear >= 1980 and curyear < 2050 then &
	sle_year.text = string(curyear + 1)

//--------------------------------------------------------
date curdate
if isnumber(sle_year.text) and ddlb_month.finditem(ddlb_month.text, 0) > 0 then
	curdate = date(string(ddlb_month.finditem(ddlb_month.text, 0)) +&
		"/1/" + sle_year.text)
else
	setnull(curdate)
end if

if isvalid(w_mainpar) then &
	w_mainpar.function dynamic trigger u_month_function(curdate)







end event

event linedown;callfunct = false
sle_year.triggerevent(modified!)
callfunct = true

if sle_year.text = "" then
	sle_year.text = string(year(today()))
	return
elseif not isnumber(sle_year.text) then 
	return
end if

integer curyear

curyear = integer(sle_year.text)
if curyear >= 1980 and curyear < 2050 then &
	sle_year.text = string(curyear - 1)

//--------------------------------------------------------
date curdate
if isnumber(sle_year.text) and ddlb_month.finditem(ddlb_month.text, 0) > 0 then
	curdate = date(string(ddlb_month.finditem(ddlb_month.text, 0)) +&
		"/1/" + sle_year.text)
else
	setnull(curdate)
end if

if isvalid(w_mainpar) then &
	w_mainpar.function dynamic trigger u_month_function(curdate)











end event

