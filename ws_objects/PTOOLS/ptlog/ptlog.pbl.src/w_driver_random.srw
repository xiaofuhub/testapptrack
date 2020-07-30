$PBExportHeader$w_driver_random.srw
$PBExportComments$random
forward
global type w_driver_random from Window
end type
type ds_report from datawindow within w_driver_random
end type
type st_randtag from statictext within w_driver_random
end type
type rb_amount from radiobutton within w_driver_random
end type
type sle_percent from singlelineedit within w_driver_random
end type
type sle_number from singlelineedit within w_driver_random
end type
type st_alltag from statictext within w_driver_random
end type
type dw_rand from datawindow within w_driver_random
end type
type rb_percent from radiobutton within w_driver_random
end type
type gb_2 from groupbox within w_driver_random
end type
type dw_all from datawindow within w_driver_random
end type
end forward

global type w_driver_random from Window
int X=833
int Y=361
int Width=1870
int Height=1597
boolean TitleBar=true
string Title="Random List Generator"
string MenuName="m_random"
long BackColor=12632256
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
ds_report ds_report
st_randtag st_randtag
rb_amount rb_amount
sle_percent sle_percent
sle_number sle_number
st_alltag st_alltag
dw_rand dw_rand
rb_percent rb_percent
gb_2 gb_2
dw_all dw_all
end type
global w_driver_random w_driver_random

type variables
protected:
/*datastore ds_report*/
boolean win_is_closing = false
end variables

forward prototypes
public subroutine generate_list (integer rannum, integer percnt)
public subroutine zz_print ()
public subroutine zz_generate ()
public subroutine sorter ()
end prototypes

public subroutine generate_list (integer rannum, integer percnt);if dw_all.rowcount() = 0 then
	beep(1)
	return
end if

if nullornotpos(rannum) then 
	beep(1)
	return
end if

setpointer(hourglass!)

integer totnum, lcv, lcv2, rfind[], rindx, tempfind
totnum = dw_all.rowcount()

for lcv = 1 to rannum
	do_over:
	tempfind = rand(totnum)
	for lcv2 = 1 to rindx
		if rfind[lcv2] = tempfind then goto do_over
	next
	rindx ++
	rfind[rindx] = tempfind
next

dw_rand.setredraw(false)
dw_all.setredraw(false)

dw_rand.reset()
dw_all.selectrow(0, false)
for lcv = 1 to rindx
	dw_all.selectrow(rfind[lcv], true)
	dw_all.rowscopy(rfind[lcv], rfind[lcv], primary!, dw_rand, dw_rand.rowcount() + 1, primary!)
next
dw_rand.sort()

sorter()

dw_all.setsort("em_id A")
dw_all.sort()
dw_rand.setsort("em_id A")
dw_rand.sort()

ds_report.reset()
ds_report.insertrow(0)
ds_report.object.r_list[1].object.data.primary = dw_rand.object.data.primary
ds_report.object.r_pool[1].object.data.primary = dw_all.object.data.primary

if nullornotpos(percnt) then 
	ds_report.object.st_amount.text = string(rannum) + " OF " + string(totnum) + " DRIVERS"
else
	ds_report.object.st_amount.text = string(rannum) + " OF " + string(totnum) + " DRIVERS (" + string(percnt) + "%)"
end if
st_randtag.text = "Random List ( " + string(rannum) + " of " + string(totnum) + " )"

dw_all.setsort("comp_fullname A")
dw_all.sort()
dw_rand.setsort("comp_fullname A")
dw_rand.sort()
dw_rand.setredraw(true)
dw_all.setredraw(true)



end subroutine

public subroutine zz_print ();if rb_percent.checked = true then
	if not isnumber(sle_percent.text) then
		beep(1)
		sle_percent.selecttext(1, len(sle_percent.text))
		sle_percent.setfocus()
		return		
	end if
else //rb_amount = checked
	if not isnumber(sle_number.text) then
		beep(1)
		sle_number.selecttext(1, len(sle_number.text))
		sle_number.setfocus()
		return
	end if
end if

if dw_rand.rowcount() = 0 then 
	messagebox("Print Random List", "You must generate the list first.")
	return
end if

long pj
integer result

pj = printopen("Profit Tools Report")
if nullorneg(pj) then
	messagebox("Print Random List", "Could not print list.  Please retry.", exclamation!)
	return
end if

result = printdatawindow(pj, ds_report)
if result = -1 then
	printcancel(pj)
	messagebox("Print Random List", "Could not print list.  Please retry.", exclamation!)
	return
else
	printclose(pj)
end if







end subroutine

public subroutine zz_generate ();integer randtot, percnt

if dw_all.rowcount() = 0 then
	messagebox("Generate List", "There are no active drivers on file.  Cannot generate a random list.")
	return
elseif rb_percent.checked = true then
	if len(trim(sle_percent.text)) = 0 then 
		messagebox("Generate List", "Please enter the percentage of drivers to select.")
		sle_percent.setfocus()
		return 
	elseif not isnumber(sle_percent.text) then
		beep(1)
		sle_percent.selecttext(1, len(sle_percent.text))
		sle_percent.setfocus()
		return		
	end if
	percnt = abs(integer(sle_percent.text))
	if percnt = 0 then
		sle_percent.text = ""
		messagebox("Generate List", "Please enter the percentage of drivers to select.")
		sle_percent.setfocus()
		return 
	end if
	percnt = min(percnt, 100)		
	randtot = ceiling( percnt * dw_all.rowcount() / 100)
	sle_percent.text = string(percnt)
	if randtot = 0 then randtot = 1
	sle_number.text = string(randtot)
else //rb_amount = checked
	if len(trim(sle_number.text)) = 0 then 
		messagebox("Generate List", "Please enter the number of drivers to select.")
		sle_number.setfocus()
		return 
	elseif not isnumber(sle_number.text) then
		beep(1)
		sle_number.selecttext(1, len(sle_number.text))
		sle_number.setfocus()
		return
	end if
	randtot = abs(integer(sle_number.text))
	if randtot = 0 then 
		sle_number.text = ""
		messagebox("Generate List", "Please enter the number of drivers to select.")
		sle_number.setfocus()
		return 
	end if
	randtot = min(randtot, dw_all.rowcount())
	sle_number.text = string(randtot)
	sle_percent.text = string(round(100 * randtot / dw_all.rowcount(), 0))
end if

generate_list(randtot, percnt)
end subroutine

public subroutine sorter ();integer lcv, offset, sortval

offset = 1
sortval = 1
if dw_all.rowcount() > 0 then 
	for lcv = 1 to dw_all.rowcount() 
		dw_all.setitem(lcv, "em_id", sortval)
		sortval += 5
		if sortval > dw_all.rowcount() then
			offset ++
			sortval = offset
		end if		
	next
end if

offset = 1
sortval = 1
if dw_rand.rowcount() > 0 then 
	for lcv = 1 to dw_rand.rowcount() 
		dw_rand.setitem(lcv, "em_id", sortval)
		sortval += 2
		if sortval > dw_rand.rowcount() then
			offset ++
			sortval = offset
		end if		
	next
end if

end subroutine

on w_driver_random.create
if this.MenuName = "m_random" then this.MenuID = create m_random
this.ds_report=create ds_report
this.st_randtag=create st_randtag
this.rb_amount=create rb_amount
this.sle_percent=create sle_percent
this.sle_number=create sle_number
this.st_alltag=create st_alltag
this.dw_rand=create dw_rand
this.rb_percent=create rb_percent
this.gb_2=create gb_2
this.dw_all=create dw_all
this.Control[]={ this.ds_report,&
this.st_randtag,&
this.rb_amount,&
this.sle_percent,&
this.sle_number,&
this.st_alltag,&
this.dw_rand,&
this.rb_percent,&
this.gb_2,&
this.dw_all}
end on

on w_driver_random.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ds_report)
destroy(this.st_randtag)
destroy(this.rb_amount)
destroy(this.sle_percent)
destroy(this.sle_number)
destroy(this.st_alltag)
destroy(this.dw_rand)
destroy(this.rb_percent)
destroy(this.gb_2)
destroy(this.dw_all)
end on

event open;if g_privs.log[2] = 0 then
	messagebox("Random Driver List", "Your current user privileges do not allow you to access" +&
	" this screen.")
	close(this)
	return
end if


this.x = 1
this.y = 1 

gf_mask_menu(m_random)

if gds_emp.rowcount() > 0 then   
	dw_all.object.data.primary = gds_emp.object.data.primary
	dw_all.setfilter("em_status = 'K' and not isnull(di_id)")
	dw_all.filter()
end if

dw_all.object.em_ref_t.visible = 0
dw_all.object.comp_ref.visible = 0
dw_rand.object.em_ref_t.visible = 0
dw_rand.object.comp_ref.visible = 0

st_alltag.text = "Active Drivers ( Total = " + string(dw_all.rowcount()) + " )"

//ds_report = CREATE datastore 
//ds_report.DataObject = "d_random_report_comp"
rb_percent.checked = true
sle_number.enabled = false


end event

event close;//destroy ds_report
//
end event

event closequery;win_is_closing = true
end event

type ds_report from datawindow within w_driver_random
int X=2021
int Y=525
int Width=3063
int Height=1297
string DataObject="d_random_report_comp"
end type

type st_randtag from statictext within w_driver_random
int X=951
int Y=353
int Width=860
int Height=77
boolean Enabled=false
string Text="Random List ( 0 of 0 )"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_amount from radiobutton within w_driver_random
int X=947
int Y=69
int Width=577
int Height=77
string Text="Number of Drivers "
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.checked = true then
	sle_number.enabled = true
	sle_percent.enabled = false
end if 
end event

type sle_percent from singlelineedit within w_driver_random
int X=444
int Y=153
int Width=284
int Height=85
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;if win_is_closing then return

if len(trim(this.text)) > 0 then
	if not isnumber(this.text) then
		if rb_amount = getfocus() then
			this.text = ""
		else
			beep(1)
			this.post selecttext(1, len(this.text))
			this.post setfocus()
		end if
		return
	else
		integer num_driv
		num_driv = abs(integer(this.text))
		if num_driv = 0 then
			this.text = ""
			return 
		end if
		num_driv = min(num_driv, 100)
		this.text = string(num_driv)
		sle_number.text = string(ceiling(dw_all.rowcount() * num_driv / 100))
	end if
end if
end event

event modified;integer num_driv
if len(trim(this.text)) = 0 then
	this.text = ""
	return
end if

if isnumber(this.text) then 
	num_driv = abs(integer(this.text))
	if num_driv = 0 then return 
	num_driv = min(num_driv, 100)
	this.text = string(num_driv)
	sle_number.text = string(ceiling(dw_all.rowcount() * num_driv / 100))
end if


end event

type sle_number from singlelineedit within w_driver_random
int X=1111
int Y=153
int Width=284
int Height=85
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;if win_is_closing then return

if len(trim(this.text)) > 0 then
	if not isnumber(this.text) then
		if getfocus() = rb_percent then 
			this.text = ""
		else
			beep(1)
			this.post selecttext(1, len(this.text))
			this.post setfocus()
		end if
		return
	else
		integer num_driv
		num_driv = abs(integer(this.text))
		if num_driv = 0 then
			this.text = ""
			return 
		end if 
		num_driv = min(dw_all.rowcount(), num_driv)
		this.text = string(num_driv)
		sle_percent.text = string(round(100 * num_driv / dw_all.rowcount(), 0))
	end if
end if
end event

event modified;integer num_driv
if len(trim(this.text)) = 0 then
	this.text = ""
	return
end if

if isnumber(this.text) then 
	num_driv = abs(integer(this.text))
	if num_driv = 0 then return 
	num_driv = min(dw_all.rowcount(), num_driv)
	this.text = string(num_driv)
	sle_percent.text = string(round(100 * num_driv / dw_all.rowcount(), 0))
end if

end event

type st_alltag from statictext within w_driver_random
int X=23
int Y=353
int Width=860
int Height=77
boolean Enabled=false
string Text="List of Active Drivers"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_rand from datawindow within w_driver_random
int X=951
int Y=437
int Width=860
int Height=961
string DataObject="d_emp_list"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type rb_percent from radiobutton within w_driver_random
int X=284
int Y=69
int Width=613
int Height=77
string Text="Percentage of Total "
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.checked = true then
	sle_number.enabled = false
	sle_percent.enabled = true
end if 
end event

type gb_2 from groupbox within w_driver_random
int X=243
int Y=5
int Width=1367
int Height=281
int TabOrder=10
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_all from datawindow within w_driver_random
int X=23
int Y=437
int Width=860
int Height=961
string DataObject="d_emp_list"
boolean VScrollBar=true
boolean LiveScroll=true
end type

