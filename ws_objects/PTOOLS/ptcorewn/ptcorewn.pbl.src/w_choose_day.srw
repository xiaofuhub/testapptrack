$PBExportHeader$w_choose_day.srw
$PBExportComments$PTCORE:  (wiztype) calendar for user to choose a date
forward
global type w_choose_day from Window
end type
type hsb_1 from hscrollbar within w_choose_day
end type
type st_43 from statictext within w_choose_day
end type
type st_month from statictext within w_choose_day
end type
type st_38 from statictext within w_choose_day
end type
type st_32 from statictext within w_choose_day
end type
type st_42 from statictext within w_choose_day
end type
type st_41 from statictext within w_choose_day
end type
type st_40 from statictext within w_choose_day
end type
type st_39 from statictext within w_choose_day
end type
type st_37 from statictext within w_choose_day
end type
type st_36 from statictext within w_choose_day
end type
type st_35 from statictext within w_choose_day
end type
type st_34 from statictext within w_choose_day
end type
type st_33 from statictext within w_choose_day
end type
type st_31 from statictext within w_choose_day
end type
type st_30 from statictext within w_choose_day
end type
type st_29 from statictext within w_choose_day
end type
type st_28 from statictext within w_choose_day
end type
type st_27 from statictext within w_choose_day
end type
type st_26 from statictext within w_choose_day
end type
type st_25 from statictext within w_choose_day
end type
type st_24 from statictext within w_choose_day
end type
type st_23 from statictext within w_choose_day
end type
type st_22 from statictext within w_choose_day
end type
type st_21 from statictext within w_choose_day
end type
type st_20 from statictext within w_choose_day
end type
type st_19 from statictext within w_choose_day
end type
type st_18 from statictext within w_choose_day
end type
type st_17 from statictext within w_choose_day
end type
type st_16 from statictext within w_choose_day
end type
type st_15 from statictext within w_choose_day
end type
type st_14 from statictext within w_choose_day
end type
type st_13 from statictext within w_choose_day
end type
type st_12 from statictext within w_choose_day
end type
type st_11 from statictext within w_choose_day
end type
type st_10 from statictext within w_choose_day
end type
type st_9 from statictext within w_choose_day
end type
type st_8 from statictext within w_choose_day
end type
type st_7 from statictext within w_choose_day
end type
type st_6 from statictext within w_choose_day
end type
type st_5 from statictext within w_choose_day
end type
type st_4 from statictext within w_choose_day
end type
type st_3 from statictext within w_choose_day
end type
type st_2 from statictext within w_choose_day
end type
type st_1 from statictext within w_choose_day
end type
type cb_ok from commandbutton within w_choose_day
end type
type cb_cancel from commandbutton within w_choose_day
end type
type sle_pickdate from singlelineedit within w_choose_day
end type
type r_1 from rectangle within w_choose_day
end type
type st_sun from statictext within w_choose_day
end type
type st_sa from statictext within w_choose_day
end type
type st_f from statictext within w_choose_day
end type
type st_r from statictext within w_choose_day
end type
type st_w from statictext within w_choose_day
end type
type st_t from statictext within w_choose_day
end type
type st_m from statictext within w_choose_day
end type
type st_tag from statictext within w_choose_day
end type
type st_calfocus from statictext within w_choose_day
end type
end forward

global type w_choose_day from Window
int X=1801
int Y=600
int Width=901
int Height=1144
boolean TitleBar=true
string Title="Calendar"
long BackColor=12632256
WindowType WindowType=response!
hsb_1 hsb_1
st_43 st_43
st_month st_month
st_38 st_38
st_32 st_32
st_42 st_42
st_41 st_41
st_40 st_40
st_39 st_39
st_37 st_37
st_36 st_36
st_35 st_35
st_34 st_34
st_33 st_33
st_31 st_31
st_30 st_30
st_29 st_29
st_28 st_28
st_27 st_27
st_26 st_26
st_25 st_25
st_24 st_24
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
st_19 st_19
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
sle_pickdate sle_pickdate
r_1 r_1
st_sun st_sun
st_sa st_sa
st_f st_f
st_r st_r
st_w st_w
st_t st_t
st_m st_m
st_tag st_tag
st_calfocus st_calfocus
end type
global w_choose_day w_choose_day

type variables
protected:
s_date_return open_vals
date return_date
statictext st_day[42]
integer indx = 42
long pickcolor = rgb(0, 255, 255)
boolean forced_closing = false

end variables

forward prototypes
public function integer change_month (date checkdate)
public function integer turn_off ()
public function integer day_funct (statictext curday)
end prototypes

public function integer change_month (date checkdate);integer monthnum, lcv, startlcv
monthnum = month(checkdate) 
string mtag

choose case monthnum
	case 1
		mtag = "January" 
	case 2
		mtag = "February"
	case 3
		mtag = "March"
	case 4
		mtag = "April"
	case 5
		mtag = "May"
	case 6
		mtag = "June"
	case 7
		mtag = "July"
	case 8
		mtag = "August"
	case 9
		mtag = "September"
	case 10
		mtag = "October"
	case 11
		mtag = "November"
	case 12
		mtag = "December"
end choose

st_month.text = mtag + "   " + right(string(year(checkdate)), 2)
st_month.tag = string(checkdate, "m/d/yy")


startlcv = daynumber(checkdate)
//if startlcv = 1 then
//	startlcv = 7 
//else 
//	startlcv -= 1
//end if

date backdate
backdate = checkdate
if startlcv > 1 then
	for lcv = (startlcv - 1) to 1 step -1
		st_day[lcv].backcolor = rgb(220, 220, 220)
		backdate = relativedate(backdate, -1)
		if (not isnull(open_vals.mindate) and backdate = relativedate(open_vals.mindate, -1)) or & 
		(not isnull(open_vals.maxdate) and backdate = relativedate(open_vals.maxdate, 1)) then 
			st_day[lcv].textcolor = rgb(255, 0, 0)
			st_day[lcv].weight = 400
//			st_day[lcv].enabled = false
			st_day[lcv].tag = string(backdate, "m/d/yy")
			st_day[lcv].text = "X"
		else
			if (not isnull(open_vals.mindate) and backdate < open_vals.mindate) or &
			(not isnull(open_vals.maxdate) and backdate > open_vals.maxdate) then 
//				st_day[lcv].enabled = false
			else
//				st_day[lcv].enabled = true
			end if
			st_day[lcv].textcolor = 0
			st_day[lcv].tag = string(backdate, "m/d/yy")
			st_day[lcv].weight = 400
			st_day[lcv].text = string(day(backdate))
		end if
	next
end if

for lcv = startlcv to 42
	if month(checkdate) <> monthnum then 
		st_day[lcv].backcolor = rgb(220, 220, 220)
	else
		st_day[lcv].backcolor = rgb(255, 255, 255)
	end if
	if (not isnull(open_vals.mindate) and checkdate = relativedate(open_vals.mindate, -1)) or &
	(not isnull(open_vals.maxdate) and checkdate = relativedate(open_vals.maxdate, 1)) then 
		st_day[lcv].textcolor = rgb(255, 0, 0)
		st_day[lcv].weight = 400
//		st_day[lcv].enabled = false
		st_day[lcv].text = "X"
		st_day[lcv].tag = string(checkdate, "m/d/yy")
	else
		st_day[lcv].weight = 400
		st_day[lcv].textcolor = 0
		st_day[lcv].tag = string(checkdate, "m/d/yy")
//		st_day[lcv].enabled = true		
		st_day[lcv].text = string(day(checkdate))
		if (not isnull(open_vals.mindate) and checkdate < open_vals.mindate) or &
			(not isnull(open_vals.maxdate) and checkdate > open_vals.maxdate) then 
//			st_day[lcv].enabled = false
		else
//			st_day[lcv].enabled = true
		end if
	end if
	checkdate = relativedate(checkdate, 1)
next

setnull(return_date)

return 0
end function

public function integer turn_off ();integer lcv, monthnum
monthnum = month(date(st_month.tag))

for lcv = 1 to indx
	if st_day[lcv].backcolor = pickcolor then 
		if month(date(st_day[lcv].tag)) = monthnum then
			st_day[lcv].backcolor = rgb(255, 255, 255)
		else
			st_day[lcv].backcolor = rgb(220, 220, 220)
		end if
		exit
	end if
next

sle_pickdate.text = ""

return 0
end function

public function integer day_funct (statictext curday);return_date = date(curday.tag)
st_calfocus.setfocus()

if (not isnull(open_vals.mindate) and return_date < open_vals.mindate) or &
	(not isnull(open_vals.maxdate) and return_date > open_vals.maxdate) then 
	beep(1)
	setnull(return_date)
	sle_pickdate.text = ""
	return -1 
else
	sle_pickdate.text = string(return_date, "m/d/yy")
	curday.backcolor = pickcolor
	return 0
end if




end function

on w_choose_day.create
this.hsb_1=create hsb_1
this.st_43=create st_43
this.st_month=create st_month
this.st_38=create st_38
this.st_32=create st_32
this.st_42=create st_42
this.st_41=create st_41
this.st_40=create st_40
this.st_39=create st_39
this.st_37=create st_37
this.st_36=create st_36
this.st_35=create st_35
this.st_34=create st_34
this.st_33=create st_33
this.st_31=create st_31
this.st_30=create st_30
this.st_29=create st_29
this.st_28=create st_28
this.st_27=create st_27
this.st_26=create st_26
this.st_25=create st_25
this.st_24=create st_24
this.st_23=create st_23
this.st_22=create st_22
this.st_21=create st_21
this.st_20=create st_20
this.st_19=create st_19
this.st_18=create st_18
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.sle_pickdate=create sle_pickdate
this.r_1=create r_1
this.st_sun=create st_sun
this.st_sa=create st_sa
this.st_f=create st_f
this.st_r=create st_r
this.st_w=create st_w
this.st_t=create st_t
this.st_m=create st_m
this.st_tag=create st_tag
this.st_calfocus=create st_calfocus
this.Control[]={this.hsb_1,&
this.st_43,&
this.st_month,&
this.st_38,&
this.st_32,&
this.st_42,&
this.st_41,&
this.st_40,&
this.st_39,&
this.st_37,&
this.st_36,&
this.st_35,&
this.st_34,&
this.st_33,&
this.st_31,&
this.st_30,&
this.st_29,&
this.st_28,&
this.st_27,&
this.st_26,&
this.st_25,&
this.st_24,&
this.st_23,&
this.st_22,&
this.st_21,&
this.st_20,&
this.st_19,&
this.st_18,&
this.st_17,&
this.st_16,&
this.st_15,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_ok,&
this.cb_cancel,&
this.sle_pickdate,&
this.r_1,&
this.st_sun,&
this.st_sa,&
this.st_f,&
this.st_r,&
this.st_w,&
this.st_t,&
this.st_m,&
this.st_tag,&
this.st_calfocus}
end on

on w_choose_day.destroy
destroy(this.hsb_1)
destroy(this.st_43)
destroy(this.st_month)
destroy(this.st_38)
destroy(this.st_32)
destroy(this.st_42)
destroy(this.st_41)
destroy(this.st_40)
destroy(this.st_39)
destroy(this.st_37)
destroy(this.st_36)
destroy(this.st_35)
destroy(this.st_34)
destroy(this.st_33)
destroy(this.st_31)
destroy(this.st_30)
destroy(this.st_29)
destroy(this.st_28)
destroy(this.st_27)
destroy(this.st_26)
destroy(this.st_25)
destroy(this.st_24)
destroy(this.st_23)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.st_18)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.sle_pickdate)
destroy(this.r_1)
destroy(this.st_sun)
destroy(this.st_sa)
destroy(this.st_f)
destroy(this.st_r)
destroy(this.st_w)
destroy(this.st_t)
destroy(this.st_m)
destroy(this.st_tag)
destroy(this.st_calfocus)
end on

event open;/*  This window returns a date or junk string if the user cancels.  

	Send this window a structure of the type g_date_return.

	mindate Field:  represents first acceptable date user may choose.  if null, all dates 
		are acceptable

	maxdate Field:  represents last acceptable date user may choose.  if null, no limit

	Tag Field:  Programmer can put any title they choose here or it will default to
		"Choose a Date", (keep under 40 characters, less if all capitol letters)

	XPos & YPos Fields:  Programmer may allow the window to be opened at any position, 
		default is centered 

	Window returns a date or a junk string to represent that user canceled  */
//-------------------------------------------------------------------------------

n_cst_numerical lnv_numerical

open_vals = message.powerobjectparm 
sle_pickdate.enabled = true
st_calfocus.setfocus()
if lnv_numerical.of_IsNullOrNotPos(open_vals.xpos) then this.x = 1800 else this.x = open_vals.xpos
if lnv_numerical.of_IsNullOrNotPos(open_vals.ypos) then this.y = 600 else this.y = open_vals.ypos
//--------------------------------------------------------------- startdate/lastdate

if not isnull(open_vals.maxdate) and not isnull(open_vals.mindate) then 
	if open_vals.maxdate <= open_vals.mindate then
//		essagebox("Programmer's Warning", "Invalid dates given to date window.")
		setnull(return_date)
		close(this)
		return
	end if
end if

//-----------------------------------------------------------------  tag for window
if isnull(open_vals.tag) or len(trim(open_vals.tag)) = 0 then
	st_tag.text = "Choose a Date"
else
	st_tag.text = open_vals.tag
end if

//-------------------------------------------------------------------- set calendar

st_day[1] = st_42
st_day[2] = st_1
st_day[3] = st_2
st_day[4] = st_3
st_day[5] = st_4
st_day[6] = st_5
st_day[7] = st_6
st_day[8] = st_7 
st_day[9] = st_8
st_day[10] = st_9
st_day[11] = st_10
st_day[12] = st_11
st_day[13] = st_12
st_day[14] = st_13
st_day[15] = st_14
st_day[16] = st_15
st_day[17] = st_16
st_day[18] = st_17
st_day[19] = st_18 
st_day[20] = st_19 
st_day[21] = st_20 
st_day[22] = st_21
st_day[23] = st_22
st_day[24] = st_23
st_day[25] = st_24 
st_day[26] = st_25 
st_day[27] = st_26 
st_day[28] = st_27 
st_day[29] = st_28 
st_day[30] = st_29 
st_day[31] = st_30 
st_day[32] = st_31 
st_day[33] = st_32 
st_day[34] = st_33 
st_day[35] = st_34 
st_day[36] = st_35 
st_day[37] = st_36 
st_day[38] = st_37 
st_day[39] = st_38 
st_day[40] = st_39 
st_day[41] = st_40 
st_day[42] = st_41

date checkdate 
checkdate = today()
if isnull(open_vals.mindate) and isnull(open_vals.maxdate) then
elseif not isnull(open_vals.mindate) and not isnull(open_vals.maxdate) then
	if checkdate >= open_vals.mindate and checkdate <= open_vals.maxdate then
	else
		checkdate = open_vals.mindate
	end if
elseif not isnull(open_vals.mindate) then
	if checkdate >= open_vals.mindate then
	else
		checkdate = open_vals.mindate
	end if
elseif not isnull(open_vals.maxdate) then 
	if checkdate <= open_vals.maxdate then
	else
		checkdate = open_vals.maxdate
	end if
end if

checkdate = date(string(month(checkdate)) + "/1/" + string(year(checkdate)) )
change_month(checkdate)


end event

event key;if (keydown(KeyLeftArrow!) or keydown(KeyUpArrow!) or keydown(KeyRightArrow!) or &
	keydown(KeyDownArrow!)) then
	if getfocus() <> sle_pickdate then
		if st_calfocus <> getfocus() then st_calfocus.triggerevent(getfocus!)
	elseif getfocus() = sle_pickdate then
		if len(trim(sle_pickdate.text)) = 0 then
			sle_pickdate.text = ""
			st_calfocus.triggerevent(getfocus!)
		else
			return
		end if
	end if 
elseif keydown(KeyPageUp!) then
	hsb_1.postevent(lineleft!)
	return
elseif keydown(KeyPageDown!) then 
	hsb_1.postevent(lineright!)
	return
else
 	return 
end if

integer lcv, curbox = 0, newbox, monthnum
monthnum = month(date(st_month.tag))

for lcv = 1 to indx
	if st_day[lcv].backcolor = pickcolor then 
		curbox = lcv
		exit
	end if
next

if curbox = 0 then 
	newbox = 0
	if keydown(KeyLeftArrow!) or keydown(KeyUpArrow!) then 
		for lcv = indx to 1 step -1
			if (not isnull(open_vals.mindate) and date(st_day[lcv].tag) < open_vals.mindate) or &
				(not isnull(open_vals.maxdate) and date(st_day[lcv].tag) > open_vals.maxdate) then 
			else //if st_day[lcv].enabled = true then
				newbox = lcv
				goto spot2
			end if
		next
	else
		for lcv = 1 to indx
			if (not isnull(open_vals.mindate) and date(st_day[lcv].tag) < open_vals.mindate) or &
				(not isnull(open_vals.maxdate) and date(st_day[lcv].tag) > open_vals.maxdate) then 
			else //if st_day[lcv].enabled = true then
				newbox = lcv
				goto spot2
			end if
		next
	end if
	spot2:
	if newbox = 0 then return
	st_day[newbox].postevent(clicked!)
	return
end if

if keydown(KeyLeftArrow!) then 
	if curbox = 1 then return
	newbox = curbox - 1 
elseif keydown(KeyUpArrow!) then
	if curbox < 8 then return
	newbox = curbox - 7 
elseif keydown(KeyRightArrow!) then
	if curbox = indx then return
	newbox = curbox + 1 
elseif keydown(KeyDownArrow!) then 
	if curbox > (indx - 7) then return
	newbox = curbox + 7 
end if

if (not isnull(open_vals.mindate) and date(st_day[newbox].tag) < open_vals.mindate) or &
	(not isnull(open_vals.maxdate) and date(st_day[newbox].tag) > open_vals.maxdate) then 
	return
else //if st_day[newbox].enabled = true then
	st_day[newbox].postevent(clicked!)
end if




end event

event closequery;if not forced_closing then message.stringparm = null_str


end event

type hsb_1 from hscrollbar within w_choose_day
int X=731
int Y=196
int Width=110
int Height=80
boolean Enabled=false
boolean StdHeight=false
end type

event lineleft;date firstdate
firstdate = date(st_month.tag)

integer monthnum, yearnum
monthnum = month(firstdate)
yearnum = year(firstdate)

if monthnum = 1 then
	monthnum = 12
	yearnum -= 1
else
	monthnum -= 1
end if

firstdate = date(string(monthnum) + "/1/" + string(yearnum))

if not isnull(open_vals.mindate) then
	if (monthnum < month(open_vals.mindate) and yearnum <= year(open_vals.mindate)) or &
	(yearnum < year(open_vals.mindate)) then
		beep(1)
		return
	end if
end if
change_month(firstdate)

if isdate(sle_pickdate.text) then 
	if abs(daysafter(date(sle_pickdate.text), firstdate)) < 60 then 
		integer lcv
		for lcv = 1 to indx
			if date(st_day[lcv].tag) = date(sle_pickdate.text) then
				st_day[lcv].backcolor = pickcolor
				exit
			end if
		next
	end if
end if


end event

event lineright;date firstdate
firstdate = date(st_month.tag)

integer monthnum, yearnum
monthnum = month(firstdate)
yearnum = year(firstdate)

if monthnum = 12 then
	monthnum = 1
	yearnum ++
else
	monthnum ++
end if

firstdate = date(string(monthnum) + "/1/" + string(yearnum))

if not isnull(open_vals.maxdate) then
	if (monthnum > month(open_vals.maxdate) and yearnum >= year(open_vals.maxdate)) or &
	(yearnum > year(open_vals.maxdate)) then
		beep(1)
		return
	end if
end if

change_month(firstdate)

if isdate(sle_pickdate.text) then
	if abs(daysafter(date(sle_pickdate.text), firstdate)) < 60 then 
		integer lcv
		for lcv = 1 to indx
			if date(st_day[lcv].tag) = date(sle_pickdate.text) then
				st_day[lcv].backcolor = pickcolor
				exit
			end if
		next
	end if
end if


end event

type st_43 from statictext within w_choose_day
int X=69
int Y=844
int Width=517
int Height=76
boolean Enabled=false
string Text="Enter Date:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_month from statictext within w_choose_day
int X=32
int Y=196
int Width=699
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="January"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_38 from statictext within w_choose_day
int X=379
int Y=732
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_32 from statictext within w_choose_day
int X=489
int Y=660
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_42 from statictext within w_choose_day
int X=32
int Y=372
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_41 from statictext within w_choose_day
int X=727
int Y=732
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_40 from statictext within w_choose_day
int X=599
int Y=732
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_39 from statictext within w_choose_day
int X=489
int Y=732
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_37 from statictext within w_choose_day
int X=270
int Y=732
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_36 from statictext within w_choose_day
int X=160
int Y=732
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)

end event

type st_35 from statictext within w_choose_day
int X=32
int Y=732
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_34 from statictext within w_choose_day
int X=727
int Y=660
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_33 from statictext within w_choose_day
int X=599
int Y=660
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_31 from statictext within w_choose_day
int X=379
int Y=660
int Width=114
int Height=76
boolean Border=true
string Text="31"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_30 from statictext within w_choose_day
int X=270
int Y=660
int Width=114
int Height=76
boolean Border=true
string Text="30"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_29 from statictext within w_choose_day
int X=160
int Y=660
int Width=114
int Height=76
boolean Border=true
string Text="29"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_28 from statictext within w_choose_day
int X=32
int Y=660
int Width=114
int Height=76
boolean Border=true
string Text="15"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_27 from statictext within w_choose_day
int X=727
int Y=588
int Width=114
int Height=76
boolean Border=true
string Text="16"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_26 from statictext within w_choose_day
int X=599
int Y=588
int Width=114
int Height=76
boolean Border=true
string Text="17"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_25 from statictext within w_choose_day
int X=489
int Y=588
int Width=114
int Height=76
boolean Border=true
string Text="18"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_24 from statictext within w_choose_day
int X=379
int Y=588
int Width=114
int Height=76
boolean Border=true
string Text="19"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)



end event

type st_23 from statictext within w_choose_day
int X=270
int Y=588
int Width=114
int Height=76
boolean Border=true
string Text="20"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_22 from statictext within w_choose_day
int X=160
int Y=588
int Width=114
int Height=76
boolean Border=true
string Text="21"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_21 from statictext within w_choose_day
int X=32
int Y=588
int Width=114
int Height=76
boolean Border=true
string Text="28"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_20 from statictext within w_choose_day
int X=727
int Y=516
int Width=114
int Height=76
boolean Border=true
string Text="27"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_19 from statictext within w_choose_day
int X=599
int Y=516
int Width=114
int Height=76
boolean Border=true
string Text="26"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_18 from statictext within w_choose_day
int X=489
int Y=516
int Width=114
int Height=76
boolean Border=true
string Text="25"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_17 from statictext within w_choose_day
int X=379
int Y=516
int Width=114
int Height=76
boolean Border=true
string Text="24"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_16 from statictext within w_choose_day
int X=270
int Y=516
int Width=114
int Height=76
boolean Border=true
string Text="23"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_15 from statictext within w_choose_day
int X=160
int Y=516
int Width=114
int Height=76
boolean Border=true
string Text="22"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_14 from statictext within w_choose_day
int X=32
int Y=516
int Width=114
int Height=76
boolean Border=true
string Text="8"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_13 from statictext within w_choose_day
int X=727
int Y=444
int Width=114
int Height=76
boolean Border=true
string Text="9"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_12 from statictext within w_choose_day
int X=599
int Y=444
int Width=114
int Height=76
boolean Border=true
string Text="10"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_11 from statictext within w_choose_day
int X=489
int Y=444
int Width=114
int Height=76
boolean Border=true
string Text="11"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_10 from statictext within w_choose_day
int X=379
int Y=444
int Width=114
int Height=76
boolean Border=true
string Text="12"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_9 from statictext within w_choose_day
int X=270
int Y=444
int Width=114
int Height=76
boolean Border=true
string Text="13"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_8 from statictext within w_choose_day
int X=160
int Y=444
int Width=114
int Height=76
boolean Border=true
string Text="14"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_7 from statictext within w_choose_day
int X=32
int Y=444
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_6 from statictext within w_choose_day
int X=727
int Y=372
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_5 from statictext within w_choose_day
int X=599
int Y=372
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_4 from statictext within w_choose_day
int X=489
int Y=372
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_3 from statictext within w_choose_day
int X=379
int Y=372
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_2 from statictext within w_choose_day
int X=270
int Y=372
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type st_1 from statictext within w_choose_day
int X=160
int Y=372
int Width=114
int Height=76
boolean Border=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.text = "" then return
if this.backcolor = pickcolor then return
turn_off()
day_funct(this)


end event

type cb_ok from commandbutton within w_choose_day
int X=325
int Y=940
int Width=247
int Height=88
int TabOrder=30
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if len(trim(sle_pickdate.text)) = 0 then
	messagebox("Date Entry","Please enter a date.")
	sle_pickdate.setfocus()
	return
elseif isnull(return_date) then 
	return
else
	forced_closing = true
	closewithreturn(parent, string(return_date, "m/d/yy"))
end if


end event

type cb_cancel from commandbutton within w_choose_day
int X=594
int Y=940
int Width=247
int Height=88
int TabOrder=40
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;forced_closing = true
closewithreturn(parent, null_str)
end event

type sle_pickdate from singlelineedit within w_choose_day
event lbuttondown pbm_lbuttondown
int X=594
int Y=844
int Width=247
int Height=76
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;this.setfocus()
end event

event modified;n_cst_string lnv_string
date newdate
if len(trim(this.text)) = 0 then
	this.text = ""
	return
end if

if isnull(lnv_string.of_SpecialDate(this.text)) then 
	return
else
	this.text = string(lnv_string.of_SpecialDate(this.text), "m/d/yy")
end if

end event

event getfocus;this.selecttext(1, len(this.text))
st_calfocus.postevent(losefocus!)
end event

event losefocus;if getfocus() = cb_cancel or forced_closing then return
//I know that forced_closing isn't relevant at the moment.

integer lcv
for lcv = 1 to indx
	if getfocus() = st_day[lcv] then return
next

if len(trim(this.text)) > 0 then
	if not isdate(this.text) then
		beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
		setnull(return_date)
	else
		return_date = date(this.text)
		if not isnull(open_vals.mindate) and date(sle_pickdate.text) < open_vals.mindate then 
			beep(1)
			sle_pickdate.selecttext(1, len(sle_pickdate.text))
			messagebox("Invalid Date","You must enter a date that occurs after " + &
				string(relativedate(open_vals.mindate, -1), "m/d/yy") + ".")
			this.post setfocus()
			setnull(return_date)
		end if
		if not isnull(open_vals.maxdate) and date(sle_pickdate.text) > open_vals.maxdate then 
			beep(1)
			sle_pickdate.selecttext(1, len(sle_pickdate.text))
			messagebox("Invalid Date","You must enter a date that occurs before " + &
				string(relativedate(open_vals.maxdate, 1), "m/d/yy") + ".")
			this.post setfocus()
			setnull(return_date)
		end if
	end if
else
	setnull(return_date)
end if

integer monthnum
date tempdate
monthnum = month(date(st_month.tag))

for lcv = 1 to indx  //turning off currently chosen in calendar
	if st_day[lcv].backcolor = pickcolor then 
		if month(date(st_day[lcv].tag)) = monthnum then
			st_day[lcv].backcolor = rgb(255, 255, 255)
		else
			st_day[lcv].backcolor = rgb(220, 220, 220)
		end if
		exit
	end if 
next

if isnull(return_date) then return

if (month(date(st_month.tag)) <> month(return_date)) or (year(date(st_month.tag)) <> &
	year(return_date)) then
	tempdate = return_date
	change_month(date(string(month(return_date)) + "/1/" + string(year(return_date)) )) 
	return_date = tempdate
end if

for lcv = 1 to indx
	if date(st_day[lcv].tag) = return_date then
		st_day[lcv].backcolor = pickcolor
		exit
	end if
next




end event

type r_1 from rectangle within w_choose_day
int X=50
int Y=372
int Width=933
int Height=620
boolean Visible=false
boolean Enabled=false
int LineThickness=8
long FillColor=16777215
end type

type st_sun from statictext within w_choose_day
int X=32
int Y=300
int Width=114
int Height=60
boolean Enabled=false
string Text="Sun"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_sa from statictext within w_choose_day
int X=727
int Y=300
int Width=114
int Height=60
boolean Enabled=false
string Text="Sat"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_f from statictext within w_choose_day
int X=599
int Y=300
int Width=114
int Height=60
boolean Enabled=false
string Text="F"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_r from statictext within w_choose_day
int X=489
int Y=300
int Width=114
int Height=60
boolean Enabled=false
string Text="Th"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_w from statictext within w_choose_day
int X=379
int Y=300
int Width=114
int Height=60
boolean Enabled=false
string Text="W"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_t from statictext within w_choose_day
int X=270
int Y=300
int Width=114
int Height=60
boolean Enabled=false
string Text="T"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_m from statictext within w_choose_day
int X=160
int Y=300
int Width=114
int Height=60
boolean Enabled=false
string Text="M"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_tag from statictext within w_choose_day
int X=41
int Y=32
int Width=791
int Height=148
boolean Enabled=false
string Text="Choose a Date"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_calfocus from statictext within w_choose_day
int X=14
int Y=288
int Width=855
int Height=548
int TabOrder=10
Alignment Alignment=Center!
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event losefocus;integer lcv
for lcv = 1 to indx
	if st_day[lcv] = getfocus() then return		
next



end event

event clicked;this.setfocus()


end event

