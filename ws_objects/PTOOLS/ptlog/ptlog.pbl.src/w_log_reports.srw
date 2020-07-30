$PBExportHeader$w_log_reports.srw
forward
global type w_log_reports from window
end type
type cb_all from statictext within w_log_reports
end type
type rb_driver_info from radiobutton within w_log_reports
end type
type dw_report from datawindow within w_log_reports
end type
type st_opts from statictext within w_log_reports
end type
type uo_choose_emp from u_choose_emp within w_log_reports
end type
type cbx_ex from checkbox within w_log_reports
end type
type cbx_comments from checkbox within w_log_reports
end type
type rb_hours_avail from radiobutton within w_log_reports
end type
type rb_hours_worked from radiobutton within w_log_reports
end type
type rb_entered from radiobutton within w_log_reports
end type
type rb_stats from radiobutton within w_log_reports
end type
type rb_group from radiobutton within w_log_reports
end type
type st_sort from statictext within w_log_reports
end type
type st_desig from statictext within w_log_reports
end type
type rb_missing from radiobutton within w_log_reports
end type
type gb_report from groupbox within w_log_reports
end type
type cbx_filter from checkbox within w_log_reports
end type
type sle_edate from singlelineedit within w_log_reports
end type
type st_to from statictext within w_log_reports
end type
type sle_bdate from singlelineedit within w_log_reports
end type
type uo_month from u_month within w_log_reports
end type
type ddlb_sort from dropdownlistbox within w_log_reports
end type
type st_month from statictext within w_log_reports
end type
type ddlb_tag from dropdownlistbox within w_log_reports
end type
type ddlb_driverinfo from dropdownlistbox within w_log_reports
end type
type st_date from statictext within w_log_reports
end type
type st_range_cover from statictext within w_log_reports
end type
type ddlb_range from dropdownlistbox within w_log_reports
end type
type st_driverinfo from statictext within w_log_reports
end type
type buffer_logs from structure within w_log_reports
end type
end forward

type buffer_logs from structure
	long		id
	integer		sched_type
	date		fdate
	date		maxdate
	string		ln
	string		fn
	string		mn
	integer		fday
end type

global type w_log_reports from window
integer x = 5
integer y = 4
integer width = 2981
integer height = 1372
boolean titlebar = true
string title = "Report Window"
string menuname = "m_reports"
boolean controlmenu = true
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
cb_all cb_all
rb_driver_info rb_driver_info
dw_report dw_report
st_opts st_opts
uo_choose_emp uo_choose_emp
cbx_ex cbx_ex
cbx_comments cbx_comments
rb_hours_avail rb_hours_avail
rb_hours_worked rb_hours_worked
rb_entered rb_entered
rb_stats rb_stats
rb_group rb_group
st_sort st_sort
st_desig st_desig
rb_missing rb_missing
gb_report gb_report
cbx_filter cbx_filter
sle_edate sle_edate
st_to st_to
sle_bdate sle_bdate
uo_month uo_month
ddlb_sort ddlb_sort
st_month st_month
ddlb_tag ddlb_tag
ddlb_driverinfo ddlb_driverinfo
st_date st_date
st_range_cover st_range_cover
ddlb_range ddlb_range
st_driverinfo st_driverinfo
end type
global w_log_reports w_log_reports

type variables
protected:
date retdate
string wintype, all_drivers
Boolean	ib_DisableCloseQuery

String	cs_KeyCol_EmployeeId = "em_id"
String	cs_KeyCol_DriverId = "di_id"
end variables

forward prototypes
public subroutine month_date (ref date curdate)
public subroutine missing ()
public subroutine entered ()
public subroutine violations ()
public subroutine stats ()
public subroutine worked ()
public subroutine available ()
public function integer emp_switch (integer uo_num)
public function integer u_month_function (date curdate)
public subroutine designator (integer type_des)
public subroutine date_range ()
public subroutine get_dates (ref date bdate, ref date edate)
public function string reptype ()
public subroutine zz_print_request ()
public subroutine rb_clicked ()
public function integer retrieve_avail (date bdate, date edate, ref string failstring)
public function integer retrieve_worked (date bdate, date edate, ref string failstring)
public function integer retrieve_stats (date bdate, date edate, ref string failstring)
public function integer retrieve_entered (date bdate, date edate, ref string failstring)
public function integer retrieve_missing (date bdate, date edate, ref string failstring)
public function integer retrieve_vios_single (s_emp_info curemp, date bdate, date edate, ref string failstring)
public function integer retrieve_vios_all (date bdate, date edate, ref string failstring)
public subroutine zz_print_preview ()
public subroutine preview_mode (boolean bool_val)
public subroutine driverinfo ()
public function integer retrieve_driver (ref string failnote)
public function integer of_buildreport ()
end prototypes

public subroutine month_date (ref date curdate);uo_month.ddlb_month.triggerevent(modified!)

if isnumber(uo_month.sle_year.text) and &
	uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0) > 0 then
	curdate = date(string(uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0)) +&
			"/1/" + uo_month.sle_year.text)
else
	curdate = null_date
end if


return

end subroutine

public subroutine missing ();ddlb_range.visible = false
st_range_cover.visible = false
sle_bdate.visible = false
sle_edate.visible = false
st_month.visible = true
st_date.visible = false
st_to.visible = false
uo_month.visible = true

ddlb_sort.enabled = true
ddlb_tag.enabled = true

cbx_filter.text = "Only Drivers Missing Logs"
cbx_filter.visible = true
cbx_filter.enabled = true

cbx_ex.visible = false
cbx_comments.visible = false

uo_choose_emp.visible = false
cb_all.visible = false
st_driverinfo.visible = false
ddlb_driverinfo.visible = false


ddlb_sort.reset()

ddlb_sort.additem("Alphabetical")
ddlb_sort.additem("Most Violations")
ddlb_sort.additem("Least Violations")
ddlb_sort.additem("Schedule Type + Alpha.")

ddlb_sort.selectitem(1)
designator(1)
//uo_month.ddlb_month.setfocus()

end subroutine

public subroutine entered ();ddlb_range.visible = false
st_range_cover.visible = false
sle_bdate.visible = false
sle_edate.visible = false
st_month.visible = true
st_date.visible = false
st_to.visible = false
uo_month.visible = true

ddlb_sort.enabled = true
ddlb_tag.enabled = true

cbx_filter.enabled = false
cbx_filter.visible = true

cbx_ex.visible = false
cbx_comments.visible = false

uo_choose_emp.visible = false
cb_all.visible = false

st_driverinfo.visible = false
ddlb_driverinfo.visible = false

ddlb_sort.reset()
ddlb_sort.additem("Alphabetical")
ddlb_sort.additem("Number of Logs not Entered")
ddlb_sort.selectitem(1)

designator(1)
//uo_month.ddlb_month.setfocus()


end subroutine

public subroutine violations ();ddlb_range.visible = true
st_range_cover.visible = true
st_range_cover.bringtotop = true
sle_bdate.visible = true
sle_edate.visible = true
sle_bdate.enabled = true
sle_edate.enabled = true
st_month.visible = false
st_date.visible = false
st_to.visible = true
uo_month.visible = false

ddlb_sort.enabled = false
ddlb_tag.enabled = true

cbx_filter.visible = false

cbx_ex.visible = true
cbx_comments.visible = true
st_driverinfo.visible = false
ddlb_driverinfo.visible = false

uo_choose_emp.visible = true
cb_all.visible = true
if not isnull(uo_choose_emp.cur_emp.em_id) then
	if uo_choose_emp.cur_emp.em_id = -1 then
		uo_choose_emp.cur_emp.em_id = null_Long
		cb_all.postevent(clicked!)
	else
		uo_choose_emp.sle_name.text = uo_choose_Emp.cur_emp.em_ln + ", " + uo_choose_emp.cur_emp.em_fn
	end if
else
	cb_all.postevent(clicked!) 
end if


ddlb_sort.reset()
designator(2)
//sle_bdate.setfocus()

end subroutine

public subroutine stats ();ddlb_range.visible = false
st_range_cover.visible = false
sle_bdate.visible = false
sle_edate.visible = false
st_month.visible = true
st_date.visible = false
st_to.visible = false
uo_month.visible = true

ddlb_sort.enabled = true
ddlb_tag.enabled = true

cbx_filter.enabled = false
cbx_filter.visible = true

cbx_ex.visible = false
cbx_comments.visible = false

uo_choose_emp.visible = false
cb_all.visible = false

st_driverinfo.visible = false
ddlb_driverinfo.visible = false

ddlb_sort.reset()

ddlb_sort.additem("Alphabetical")
ddlb_sort.additem("Most Violations")
ddlb_sort.additem("Least Violations")
ddlb_sort.additem("Most Miles")
ddlb_sort.additem("Least Miles")
ddlb_sort.additem("Most Hours Driving")
ddlb_sort.additem("Least Hours Driving")
ddlb_sort.additem("Fastest MPH")
ddlb_sort.additem("Slowest MPH")
ddlb_sort.additem("Highest Percent Driving")
ddlb_sort.additem("Lowest Percent Driving")
ddlb_sort.selectitem(1)
designator(1)
//uo_month.ddlb_month.setfocus()

end subroutine

public subroutine worked ();ddlb_range.visible = false
st_range_cover.visible = false
sle_bdate.visible = false
sle_edate.enabled = true
sle_edate.visible = true
st_month.visible = false
st_date.visible = true
st_date.text = "Enter Last Day of Target Week:"
st_to.visible = false
uo_month.visible = false

ddlb_sort.enabled = false
ddlb_tag.enabled = true //false

cbx_filter.enabled = false
cbx_filter.visible = true

cbx_ex.visible = false
cbx_comments.visible = false
st_driverinfo.visible = false
ddlb_driverinfo.visible = false


uo_choose_emp.visible = false
cb_all.visible = false


ddlb_sort.reset()
designator(0)

//sle_edate.setfocus()

end subroutine

public subroutine available ();ddlb_range.visible = false
sle_bdate.visible = false
sle_edate.enabled = true
sle_edate.visible = true
st_month.visible = false
st_date.visible = true
st_date.text = "Enter Target Date:"
st_to.visible = false
st_range_cover.visible = false
uo_month.visible = false

ddlb_sort.enabled = false
ddlb_tag.enabled = true //false

cbx_filter.enabled = false
cbx_filter.visible = true

cbx_ex.visible = false
cbx_comments.visible = false

uo_choose_emp.visible = false
cb_all.visible = false

st_driverinfo.visible = false
ddlb_driverinfo.visible = false

ddlb_sort.reset()
designator(0)
//sle_edate.setfocus()


end subroutine

public function integer emp_switch (integer uo_num);uo_choose_emp.set_emp(true)

return 0


end function

public function integer u_month_function (date curdate);return 0

end function

public subroutine designator (integer type_des);if ddlb_tag.totalitems() = 0 then
	ddlb_tag.additem("Official Copy")
	ddlb_tag.additem("Unofficial Copy")
	ddlb_tag.additem("Preliminary Copy")
	ddlb_tag.additem("Office Copy")
	ddlb_tag.selectitem(1)
end if

integer dcindex
dcindex = ddlb_tag.finditem("Driver Copy", 0)

if type_des = 2 then
	if dcindex > 0 then
	else
		ddlb_tag.additem("Driver Copy")
	end if
else
	if dcindex > 0 then
		if ddlb_tag.text = "Driver Copy" then ddlb_tag.selectitem(1)
		ddlb_tag.deleteitem(dcindex)
	end if
end if



//ddlb_tag.reset()
//
//choose case type_des
//case 1
//	ddlb_tag.additem("Official Copy")
//	ddlb_tag.additem("Unofficial Copy")
//	ddlb_tag.additem("Preliminary Copy")
//	ddlb_tag.additem("Office Copy")
//	ddlb_tag.additem("Special")
//	ddlb_tag.selectitem(1)
//case 2
//	ddlb_tag.additem("Official Copy")
//	ddlb_tag.additem("Unofficial Copy")
//	ddlb_tag.additem("Driver Copy")
//	ddlb_tag.additem("Office Copy")
//	ddlb_tag.additem("Special")
//	ddlb_tag.selectitem(1)
//end choose
//
//return
end subroutine

public subroutine date_range ();date edate, bdate, edate2
integer myear, mnum


edate = date(string(month(today())) + "/1/" + string(year(today())))
uo_month.ddlb_month.selectitem(month(edate))
uo_month.sle_year.text = string(year(edate))

//---------------------------------------------------------month to date
if daysafter(edate, today()) > 4 then 
	ddlb_range.additem(string(edate, "m/d") + " - " + string(relativedate(today(), 1), "m/d/yy"))
end if
//---------------------------------------------------------last 3 months
mnum = month(edate)
myear = year(edate)
mnum -= 3
if mnum < 1 then
	mnum += 12
	myear -= 1
	if myear = -1 then myear = 99
end if
bdate = date(string(mnum) + "/1/" + right(string(myear), 2))
ddlb_range.additem(string(bdate, "m/d") + " - " + string(edate, "m/d/yy"))
//---------------------------------------------------------last 6 months
mnum = month(edate)
myear = year(edate)
mnum -= 6
if mnum < 1 then
	mnum += 12
	myear -= 1
	if myear = -1 then myear = 99
end if

bdate = date(string(mnum) + "/1/" + right(string(myear), 2))
ddlb_range.additem(string(bdate, "m/d") + " - " + string(edate, "m/d/yy"))
//-----------------------------------------------------------------------------

ddlb_range.selectitem(0)
st_range_cover.bringtotop = true



end subroutine

public subroutine get_dates (ref date bdate, ref date edate);bdate = null_date
edate = null_date

integer nmon, nyear

if uo_month.visible = true then
	uo_month.sle_year.triggerevent(modified!)
	if isnumber(uo_month.sle_year.text) and &
		uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0) > 0 then
		bdate = date(string(uo_month.ddlb_month.finditem(uo_month.ddlb_month.text, 0)) +&
			"/1/" + uo_month.sle_year.text)
		nmon = month(bdate) + 1
		nyear = year(bdate)
		if nmon > 12 then  //(BF0001) -- Used to be > 13, not retrieving for December
			nmon -= 12
			nyear += 1
		end if
		edate = date(string(nmon) + "/1/" + string(nyear))
	end if
	return
elseif sle_bdate.visible = true and sle_edate.visible = true then
	sle_bdate.triggerevent(modified!)
	sle_edate.triggerevent(modified!)
	if isdate(sle_bdate.text) and isdate(sle_edate.text) then 
		bdate = date(sle_bdate.text)
		edate = date(sle_edate.text)
		if bdate > edate then
			date tempd
			tempd = bdate
			bdate = edate
			edate = tempd
			sle_bdate.text = string(bdate, "m/d/yy")
			sle_edate.text = string(edate, "m/d/yy")
		end if
	end if
	return
elseif sle_edate.visible = true and sle_bdate.visible = false then
	sle_edate.triggerevent(modified!)
	if isdate(sle_edate.text) then 
		edate = date(sle_edate.text)
		bdate = edate
	end if
	return
elseif rb_driver_info.checked = true then
	bdate = date("1/1/1980")  //(BF0002)
	edate = date("1/1/1980")  //(BF0002)
	return
end if


end subroutine

public function string reptype ();String	ls_RepType

if rb_entered.checked = true then
	ls_RepType = "E"
elseif rb_group.checked = true then
	ls_RepType = "V"
elseif rb_hours_avail.checked = true then
	ls_RepType = "A"
elseif rb_hours_worked.checked = true then
	ls_RepType = "W"
elseif rb_missing.checked = true then
	ls_RepType = "M"
elseif rb_stats.checked = true then
	ls_RepType = "S"
elseif rb_driver_info.checked = true then
	ls_RepType = "D"
else
	SetNull ( ls_RepType )
end if

return ls_RepType
end function

public subroutine zz_print_request ();string type_act = "Print Report"
string	reptype
Integer	retval

reptype = reptype()

choose case reptype
	case "S"
		if g_privs.log[8] = 0 then 
			messagebox(type_act, "Your current user privileges do not allow you " +&
			"to access this report.")
			return
		end if
	case "D"
		if g_privs.emp[2] = 0 then 
			messagebox(type_act, "Your current user privileges do not allow you " +&
			"to access this report.")
			return
		end if
	case else
		if g_privs.log[2] = 0 then
			messagebox(type_act, "Your current user privileges do not allow you " +&
			"to access this report.")
			return
		end if
end choose


if dw_report.visible = true then
	if messagebox(type_act, "OK to print the displayed report?", question!, &
	okcancel!) = 2 then return
	goto printing
end if

retval = of_BuildReport()

if retval = -1 then 
	messagebox(type_act, "Could not generate the requested report.~n~nPlease Retry.", &
		exclamation!)
	return 
elseif retval <> 0 then
	return
end if

if dw_report.rowcount() = 0 then
	if messagebox(type_act, "The report was generated but no information met " +&
	"the criteria of the search.  Do you still want to print report?", question!, &
	okcancel!) = 2 then return
else
	if reptype = "V" and uo_choose_emp.sle_name.text = all_drivers then
		retval = messagebox(type_act, "OK to print report?  (Please Note:  This " +&
		"is a potentially large report because there is one page per driver.)",&
		 question!, okcancel!, 1)
	else
		retval = messagebox(type_act, "OK to print report?", question!, okcancel!, 1)
	end if
	if retval = 2 then return
end if


printing:

long pj
integer result, zoomfact

if integer(dw_report.object.datawindow.zoom) <> 100 then 
	dw_report.setredraw(false)
	zoomfact = 	integer(dw_report.object.datawindow.zoom)
	dw_report.object.datawindow.zoom = 100 
end if

pj = printopen("Profit Tools Report")
if nullorneg(pj) then
	messagebox(type_act, "Could not print report.  Please retry.")
	goto exitfunct
end if

result = printdatawindow(pj, dw_report)
if result = -1 then
	printcancel(pj)
	messagebox(type_act, "Could not print report.  Please retry.")
	goto exitfunct
else
	printclose(pj)
end if


exitfunct:
if zoomfact > 0 then 
	dw_report.object.datawindow.zoom = zoomfact
	dw_report.setredraw(true)
end if
end subroutine

public subroutine rb_clicked ();string reptype
reptype = reptype()
choose case reptype
case "M"
	missing()
case "E"
	entered()
case "V"
	violations()
case "S"
	stats()
case "W"
	worked()
case "A"
	available()
case "D"
	driverinfo()
end choose
end subroutine

public function integer retrieve_avail (date bdate, date edate, ref string failstring);bdate = relativedate(edate, -7) 

if dw_report.retrieve(bdate, edate) = -1 then
	rollback ;
	failstring = "Could not retrieve information from database."
	return -1
else 
	commit ;
end if

if dw_report.rowcount() < 3 then
	dw_report.reset()
	return 0
end if

integer lcv, indx
long curid, newid
buffer_logs blogs[]
string logstr

logstr = fill("9", 96)
edate = relativedate(edate, -1)

curid = -99
for lcv = 1 to dw_report.rowcount()
	newid = dw_report.getitemnumber(lcv, "em_id")
	if left(dw_report.getitemstring(lcv, "dl_log"), 1) = "5" then &
			dw_report.setitem(lcv, "dl_log", logstr)
	if newid <> curid then 
		curid = newid
		if dw_report.getitemdate(lcv, "dl_date") > bdate or &
			dw_report.getitemdate(lcv, "compute_max") < edate then
			indx ++
			blogs[indx].fdate = dw_report.getitemdate(lcv, "dl_date")
			blogs[indx].id = curid
			blogs[indx].ln = dw_report.getitemstring(lcv, "em_ln")
			blogs[indx].fn = dw_report.getitemstring(lcv, "em_fn")
			blogs[indx].mn = dw_report.getitemstring(lcv, "em_mn")
			blogs[indx].sched_type = dw_report.getitemnumber(lcv, "di_sched_type")
			blogs[indx].maxdate = dw_report.getitemdate(lcv, "compute_max")
		end if
	end if
next

string mbox
if indx > 0 then
	integer counter, lcv2, newrow, stoplcv

	for lcv = 1 to indx
		if bdate >= blogs[lcv].fdate then continue
		mbox += blogs[lcv].ln + "--Before inserts:~t"
		stoplcv = daysafter(bdate, blogs[lcv].fdate)
		counter = 0
		for lcv2 = 1 to stoplcv
			newrow = dw_report.insertrow(0)
			dw_report.setitem(newrow, "em_id", blogs[lcv].id)
			dw_report.setitem(newrow, "dl_odtot", 0)
			dw_report.setitem(newrow, "dl_log", logstr)
			dw_report.setitem(newrow, "di_sched_type", blogs[lcv].sched_type)
			dw_report.setitem(newrow, "dl_date", relativedate(bdate, counter) )
			dw_report.setitem(newrow, "em_ln", blogs[lcv].ln)
			dw_report.setitem(newrow, "em_fn", blogs[lcv].fn)
			dw_report.setitem(newrow, "em_mn", blogs[lcv].mn)
			dw_report.setitem(newrow, "compute_max", blogs[lcv].maxdate)
			mbox += string(relativedate(bdate, counter), "m/d/yy") + "  "
			counter ++
		next
		mbox += "~n"
	next

	for lcv = 1 to indx
		if edate <= blogs[lcv].maxdate then continue
		mbox += blogs[lcv].ln + "--After inserts:~t"
		stoplcv = abs(daysafter(blogs[lcv].maxdate, edate))
		counter = 1
		for lcv2 = 1 to stoplcv
			newrow = dw_report.insertrow(0)
			dw_report.setitem(newrow, "em_id", blogs[lcv].id)
			dw_report.setitem(newrow, "dl_odtot", 0)
			dw_report.setitem(newrow, "dl_log", logstr)
			dw_report.setitem(newrow, "di_sched_type", blogs[lcv].sched_type)
			dw_report.setitem(newrow, "dl_date", relativedate(blogs[lcv].maxdate, counter))
			dw_report.setitem(newrow, "em_ln", blogs[lcv].ln)
			dw_report.setitem(newrow, "em_fn", blogs[lcv].fn)
			dw_report.setitem(newrow, "em_mn", blogs[lcv].mn)
			dw_report.setitem(newrow, "compute_max", blogs[lcv].maxdate)
			mbox += string(relativedate(blogs[lcv].maxdate, counter), "m/d/yy") + "  "
			counter ++
		next
		mbox += "~n"
	next
	mbox += "~n"
	dw_report.sort()
	dw_report.groupcalc()
end if

return 0



end function

public function integer retrieve_worked (date bdate, date edate, ref string failstring);bdate = relativedate(edate, -6)
if dw_report.retrieve(bdate, edate) = -1 then
	rollback ;
	failstring = "Retrieve from database failed."
	return -1
else 
	commit ;
end if

integer lcv, indx
long curid, newid
buffer_logs blogs[]
string logstr

logstr = fill("9", 96)

curid = -99
for lcv = 1 to dw_report.rowcount()
	newid = dw_report.getitemnumber(lcv, "em_id")
	if left(dw_report.getitemstring(lcv, "dl_log"), 1) = "5" then &
			dw_report.setitem(lcv, "dl_log", logstr)
	if newid <> curid then 
		curid = newid
		if dw_report.getitemdate(lcv, "dl_date") > bdate or &
			dw_report.getitemdate(lcv, "compute_max") < edate then
			indx ++
			blogs[indx].fdate = dw_report.getitemdate(lcv, "dl_date")
			blogs[indx].id = curid
			blogs[indx].ln = dw_report.getitemstring(lcv, "em_ln")
			blogs[indx].fn = dw_report.getitemstring(lcv, "em_fn")
			blogs[indx].mn = dw_report.getitemstring(lcv, "em_mn")
			blogs[indx].maxdate = dw_report.getitemdate(lcv, "compute_max")
		end if
	end if
next

string mbox
if indx > 0 then
	integer counter, lcv2, newrow, stoplcv

	for lcv = 1 to indx
		if bdate >= blogs[lcv].fdate then continue
		mbox += blogs[lcv].ln + "--Before inserts:~t"
		stoplcv = daysafter(bdate, blogs[lcv].fdate)
		counter = 0
		for lcv2 = 1 to stoplcv
			newrow = dw_report.insertrow(0)
			dw_report.setitem(newrow, "em_id", blogs[lcv].id)
			dw_report.setitem(newrow, "dl_odtot", 0)
			dw_report.setitem(newrow, "dl_log", logstr)
			dw_report.setitem(newrow, "dl_date", relativedate(bdate, counter) )
			dw_report.setitem(newrow, "em_ln", blogs[lcv].ln)
			dw_report.setitem(newrow, "em_fn", blogs[lcv].fn)
			dw_report.setitem(newrow, "em_mn", blogs[lcv].mn)
			dw_report.setitem(newrow, "compute_max", blogs[lcv].maxdate)
			mbox += string(relativedate(bdate, counter), "m/d/yy") + "  "
			counter ++
		next
		mbox += "~n"
	next

	for lcv = 1 to indx
		if edate <= blogs[lcv].maxdate then continue
		mbox += blogs[lcv].ln + "--After inserts:~t"
		stoplcv = abs(daysafter(blogs[lcv].maxdate, edate))
		counter = 1
		for lcv2 = 1 to stoplcv
			newrow = dw_report.insertrow(0)
			dw_report.setitem(newrow, "em_id", blogs[lcv].id)
			dw_report.setitem(newrow, "dl_odtot", 0)
			dw_report.setitem(newrow, "dl_log", logstr)
			dw_report.setitem(newrow, "dl_date", relativedate(blogs[lcv].maxdate, counter))
			dw_report.setitem(newrow, "em_ln", blogs[lcv].ln)
			dw_report.setitem(newrow, "em_fn", blogs[lcv].fn)
			dw_report.setitem(newrow, "em_mn", blogs[lcv].mn)
			dw_report.setitem(newrow, "compute_max", blogs[lcv].maxdate)
			mbox += string(relativedate(blogs[lcv].maxdate, counter), "m/d/yy") + "  "
			counter ++
		next
		mbox += "~n"
	next
	mbox += "~n"
	dw_report.sort()
	dw_report.groupcalc()
end if

return 0



end function

public function integer retrieve_stats (date bdate, date edate, ref string failstring);if dw_report.retrieve(bdate, edate) = -1 then
	rollback ;
	failstring = "Could not retrieve information from database"
	return -1
else
	commit ;
end if

string newsort
choose case ddlb_sort.text
	case "Alphabetical"
		newsort = "comp_name A"
	case "Most Violations"
		newsort = "comp_driver_total D, comp_name A"
	case "Least Violations"
		newsort = "comp_driver_total A, comp_name A"
	case "Most Miles"
		newsort = "comp_miles D, comp_name A"
	case "Least Miles"
		newsort = "comp_miles A, comp_name A"
	case "Most Hours Driving"
		newsort = "comp_drtot D, comp_name A"
	case "Least Hours Driving"
		newsort = "comp_drtot A, comp_name A"
	case "Fastest MPH"
		newsort = "comp_mph D, comp_name A"
	case "Slowest MPH"
		newsort = "comp_mph A, comp_name A"
	case "Highest Percent Driving"
		newsort = "percent_dr D, comp_name A"
	case "Lowest Percent Driving"
		newsort = "percent_dr A, comp_name A"
	case else
		newsort = ""
end choose
dw_report.setsort(newsort)
dw_report.sort()
dw_report.groupcalc()

return 0



end function

public function integer retrieve_entered (date bdate, date edate, ref string failstring);if dw_report.retrieve(bdate, edate) = -1 then
	failstring = "Could not retrieve this report at this time."
	rollback ;
	return -1
else
	commit ;
end if

if dw_report.rowcount() < 3 then
	dw_report.reset()
	return 0
end if

integer lcv, indx
long curid, newid
buffer_logs blogs[]

curid = 0

for lcv = 1 to dw_report.rowcount()
	newid = dw_report.getitemnumber(lcv, "em_id")
	if newid <> curid then 
		curid = newid
		if day(dw_report.getitemdate(lcv, "dl_date")) <> 1 then
			indx ++
			blogs[indx].fday = day(dw_report.getitemdate(lcv, "dl_date")) - 1
			blogs[indx].id = curid
			blogs[indx].ln = dw_report.getitemstring(lcv, "em_ln")
			blogs[indx].fn = dw_report.getitemstring(lcv, "em_fn")
			blogs[indx].mn = dw_report.getitemstring(lcv, "em_mn")
			blogs[indx].maxdate = dw_report.getitemdate(lcv, "compute_max")
		end if
	end if
next

if indx > 0 then
	string logstr, mbox = ""
	integer counter, lcv2, newrow

	logstr = fill("1", 96)
	for lcv = 1 to indx
		counter = 0
		mbox = string(blogs[lcv].id) + "~n~t"
		for lcv2 = 1 to blogs[lcv].fday
			newrow = dw_report.insertrow(0)
			dw_report.setitem(newrow, "em_id", blogs[lcv].id)
			dw_report.setitem(newrow, "dl_vios", 0)
			dw_report.setitem(newrow, "dl_log", logstr)
			dw_report.setitem(newrow, "dl_date", relativedate(bdate, counter) )
			dw_report.setitem(newrow, "em_ln", blogs[lcv].ln)
			dw_report.setitem(newrow, "em_fn", blogs[lcv].fn)
			dw_report.setitem(newrow, "em_mn", blogs[lcv].mn)
			dw_report.setitem(newrow, "compute_max", blogs[lcv].maxdate)
			mbox += string(relativedate(bdate, counter), "m/d/yy") + " "
			counter ++
		next
	next

	dw_report.sort()
	dw_report.groupcalc()
end if

		

string newsort
choose case ddlb_sort.text
	case "Alphabetical"
		newsort = "em_ln A, em_fn A, em_mn A, dl_date A"
	case "Number of Logs not Entered"
		newsort = "compute_max A, em_ln A, em_fn A, em_mn A, dl_date A"
end choose

dw_report.setsort(newsort)
dw_report.sort()
dw_report.groupcalc()
return 0



end function

public function integer retrieve_missing (date bdate, date edate, ref string failstring);if dw_report.retrieve(bdate, edate) = -1 then
	rollback ;
	failstring = "Could not retrieve information from database."
	return -1
else
	commit ;
end if

if cbx_filter.checked = true then
	dw_report.setfilter("comp_nummissing > 0")
	dw_report.filter()
	dw_report.object.st_all.text = "DRIVERS WITH LOGS MISSING"
else
	dw_report.object.st_all.text = "ALL DRIVERS"
end if

string newsort
choose case ddlb_sort.text
	case "Alphabetical"
		newsort = "comp_name A"
	case "Most Violations"
		newsort = "comp_vios D, comp_name A"
	case "Least Violations"
		newsort = "comp_vios A, comp_name A"
	case "Schedule Type + Alpha."
		newsort = "di_sched_type A, comp_name A"
	case else
		newsort = ""
end choose
dw_report.setsort(newsort)
dw_report.sort()
dw_report.groupcalc()



return 0



end function

public function integer retrieve_vios_single (s_emp_info curemp, date bdate, date edate, ref string failstring);Long	ll_EmpId
Long	ll_Division
n_cst_privsmanager		lnv_PrivsManager

if dw_report.retrieve(bdate, edate) = -1 then
	rollback ;
	failstring = "Could not retrieve information at this time."
	return -1	
else
	commit ;
end if	

string newfilter

newfilter = "em_id = " + string(curemp.em_id)
if cbx_ex.checked = false then newfilter += " and (dv_excused = 'F' or isnull(dv_id))"
if cbx_comments.checked = false then 
	dw_report.object.st_comments.text = "off" 
	dw_report.modify("datawindow.detail.height.autosize = no")
else 
	dw_report.object.st_comments.text = "on"
	dw_report.modify("datawindow.detail.height.autosize = yes")
end if

dw_report.setfilter(newfilter)
dw_report.filter()
dw_report.sort()
dw_report.groupcalc()
dw_report.sort()
dw_report.groupcalc()

if dw_report.rowcount() = 0 then
	messagebox("Print Request", "This driver has no violations for the specified "+&
		"date range.  No report will be generated.")
	return 99
end if

//---check divisional privs for view log report (MFS 10/04/06)
lnv_PrivsManager = gnv_App.of_GetPrivsManager( )
ll_EmpId = dw_report.GetItemNumber(1, "em_id")

SELECT "driverinfo"."di_division" 
INTO :ll_division
FROM "driverinfo"  
WHERE "driverinfo"."di_id" = :ll_EmpId;
COMMIT;

IF ll_Division > 0 THEN
	IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ViewLogReports, ll_Division) <> 1 THEN
		Messagebox("Log Report", "You do not have divisional privileges to access this dirver's log report")
		return 99 //sure why not
	END IF
END IF
//---
	
return 0


end function

public function integer retrieve_vios_all (date bdate, date edate, ref string failstring);if dw_report.retrieve(bdate, edate) = -1 then
	rollback ;
	failstring = "Could not retrieve information at this time."
	return -1	
else
	commit ;
end if	

string newfilter
if cbx_ex.checked = false then newfilter = "dv_excused = 'F' or isnull(dv_id)"
if cbx_comments.checked = false then 
	dw_report.object.st_comments.text = "off" 
	dw_report.modify("datawindow.detail.height.autosize = no")
else 
	dw_report.object.st_comments.text = "on"
	dw_report.modify("datawindow.detail.height.autosize = yes")
end if

dw_report.setfilter(newfilter)
dw_report.filter()
dw_report.sort()
dw_report.groupcalc()
dw_report.sort()
dw_report.groupcalc()

if dw_report.rowcount() = 0 then
	messagebox("Print Request", "There are no violations for the specified date range." +&
		"  No report will be generated.")
	return 99
end if


return 0


end function

public subroutine zz_print_preview ();if dw_report.visible = true then
	preview_mode(false)
	return
end if
string type_act = "Print Preview"
Integer	retval
choose case reptype()
	case "S"
		if g_privs.log[8] = 0 then 
			messagebox(type_act, "Your current user privileges do not allow you " +&
			"to access this report.")
			return
		end if
	case "D"
		if g_privs.emp[2] = 0 then 
			messagebox(type_act, "Your current user privileges do not allow you " +&
			"to access this report.")
			return
		end if
	case else
		if g_privs.log[2] = 0 then
			messagebox(type_act, "Your current user privileges do not allow you " +&
			"to access this report.")
			return
		end if
end choose

dw_report.post setfocus()

retval = of_buildReport()

if retval = -1 then 
	messagebox(type_act, "Could not generate the requested report.~n~nPlease Retry.")
	return 
elseif retval <> 0 then
	return
end if

preview_mode(true)

end subroutine

public subroutine preview_mode (boolean bool_val);integer obcount, lcv
windowobject curob
n_cst_AppServices	lnv_AppServices

this.setredraw(false)
gb_report.bringtotop = false
obcount = upperbound(this.control[])

for lcv = 1 to obcount
	if classname(this.control[lcv]) = "dw_report_real" then continue
	curob = this.control[lcv]
	curob.visible = not(bool_val)
next

if bool_val and len(trim(dw_report.dataobject)) > 0 then
	if dw_report.dataobject = "d_log_miss" then  
		if integer(dw_report.object.datawindow.zoom) <> 90 then &
			dw_report.object.datawindow.zoom = 90
	elseif integer(dw_report.object.datawindow.zoom) <> 94 then 
		dw_report.object.datawindow.zoom = 94
	end if
end if
dw_report.visible = bool_val
if bool_val = false then 
	rb_clicked()
	gb_report.bringtotop = false
	this.width = 1331
	this.height = cb_all.y + cb_all.height + 131
	this.title = "Log Reports"
	m_reports.m_current.m_preview.toolbaritemdown = false
	m_reports.m_current.m_preview.checked = false
else
	this.width = g_max_w
	this.height = g_max_h
	this.title = "Report Preview"
	m_reports.m_current.m_preview.toolbaritemdown = true
	m_reports.m_current.m_preview.checked = true
end if
this.x = 1
this.y = 1
this.setredraw(True)


lnv_AppServices.of_GetFrame ( ).SetRedraw ( TRUE )


end subroutine

public subroutine driverinfo ();ddlb_range.visible = false
st_range_cover.visible = false
sle_bdate.visible = false
sle_edate.enabled = false
sle_edate.visible = false
st_month.visible = false
st_date.visible = false
st_to.visible = false
uo_month.visible = false

ddlb_sort.enabled = true
ddlb_tag.enabled = true

cbx_filter.text = "Flag Upcoming Renewals"
cbx_filter.enabled = true
cbx_filter.visible = true

cbx_ex.visible = false
cbx_comments.visible = false

uo_choose_emp.visible = false
cb_all.visible = false

ddlb_sort.reset()
designator(1)
if ddlb_driverinfo.text = "" then ddlb_driverinfo.selectitem(1)
st_driverinfo.visible = true
ddlb_driverinfo.visible = true

ddlb_sort.additem("Alphabetical")
ddlb_sort.additem("License Expiration")
ddlb_sort.additem("Medical Expiration")
ddlb_sort.additem("Number of Missing Items")
ddlb_sort.selectitem(1)

end subroutine

public function integer retrieve_driver (ref string failnote);dw_report.setredraw(false)
setpointer(hourglass!)
integer lcv, lcv2, counter, colcount
string colname, editstyle, sort_str, tval, fval, fontval

colcount = integer(dw_report.object.datawindow.column.count)
//----------------------------------------------------------------
if ddlb_driverinfo.text = "Mark Items on File" then
	tval = "ü"
	fval = ""
	fontval = "Windings"
	dw_report.object.st_display.text = "  = Item on File"
	dw_report.object.st_wind.visible = 1
else
	tval = ""
	fval = "X"
	fontval = "Arial"
	dw_report.object.st_display.text = fval + " = Missing Item"
	dw_report.object.st_wind.visible = 0
end if
for lcv = 1 to colcount
	colname = dw_report.describe("#" + string(lcv) + ".name")
	choose case colname
			
		case	"di_app_employ", "di_med_short", "di_road_test", &
				"di_cert_vios", "di_prev_employer", "di_inq_state", "di_casual_ch", &
				"di_drug_test_pre", "di_drug_enrolled", "di_review_record", &
				"di_cert_comp", "di_hazmat_certification", "di_copy_lic", "di_med_long", &
				"di_rec_book", "di_non_mvw"
				dw_report.modify(colname + ".edit.codetable = yes")
				dw_report.modify(colname + ".values = '" + tval + "~tT/" + fval + "~tF'")
				dw_report.modify(colname + ".font.face = '" + fontval + "'")
				if fval = "X" then 
					dw_report.modify(colname + ".font.charset = 1")
					dw_report.modify(colname + ".font.height = -9")
				end if
				dw_report.modify(colname + ".font.family = 0")
	end choose
next
//------------------------------------------------------------------------------
if dw_report.retrieve() = -1 then
	rollback ;
	failnote = "Could not retrieve information to generate report."
	dw_report.setredraw(true)
	return -1
else
	commit ;
end if
//------------------------------------------------------------------------------

for lcv = 1 to dw_report.rowcount()
	counter = 0
	for lcv2 = 1 to colcount
		colname = dw_report.describe("#" + string(lcv2) + ".name")
		choose case colname
			case	"di_app_employ", "di_med_short", "di_road_test", &
					"di_cert_vios", "di_prev_employer", "di_inq_state", "di_casual_ch", &
					"di_drug_test_pre", "di_drug_enrolled", "di_review_record", &
					"di_cert_comp", "di_hazmat_certification", "di_copy_lic", "di_med_long", &
					"di_rec_book", "di_non_mvw"
					if dw_report.getitemstring(lcv, colname) = "F" then counter ++	
		end choose
	next
	dw_report.setitem(lcv, "comp_miss", counter)
next

choose case ddlb_sort.text 
	case "Alphabetical"
		sort_str = ""
	case "Medical Expiration"
		sort_str = "di_med_exp A, "
	case "License Expiration"
		sort_str = "di_lic_exp A, "
	case "Number of Missing Items"
		sort_str = "comp_miss D, "
end choose
sort_str += "comp_name A"

dw_report.setsort(sort_str)
dw_report.sort()

if cbx_filter.checked = true then
	dw_report.object.highlight.text = "on"
else
	dw_report.object.highlight.text = "off"
end if

dw_report.setredraw(true)
return 0







end function

public function integer of_buildreport ();//Return -2 - data validation error / missing privs
//Return -1 - retrieve error
//Return 0 - success

string usertag

string reptype, failstring

integer retval

string	ls_Keycol // "em_id" or "di_id"
Long		ll_Rowcount
Long		ll_RowcountAfter
Long		i
Long		ll_Division
Long		ll_EmpId

n_cst_privsmanager	lnv_PrivsManager

ddlb_tag.triggerevent(modified!)
if len(trim(ddlb_tag.text)) = 0 and ddlb_tag.enabled = true then
	setnull(usertag)
else
	usertag = trim(ddlb_tag.text)
end if

date bdate, edate
get_dates(bdate, edate)
if isnull(bdate) and isnull(edate) then
	if sle_bdate.visible = true and sle_edate.visible = true then 
		messagebox("Log Report", "You must specify a date range in order to preview this " +&
		"report.")
		sle_bdate.setfocus()
		retval = -2
	elseif sle_edate.visible = true then 
		messagebox("Log Report", "You must specify a target date in order to preview this " +&
		"report.")
		sle_edate.setfocus()
		retval = -2
	elseif uo_month.visible = true then 
		messagebox("Log Report", "The specified year is not valid.  Please " +&
		"enter a valid year.")
		uo_month.sle_year.setfocus()
		retval = -2
	end if
end if

IF retval <> -2 THEN
	reptype = reptype()
	dw_report.setredraw(false)
	dw_report.reset()
	
	choose case reptype
	case "M"
		dw_report.dataobject = "d_log_miss"
		dw_report.settransobject(sqlca)
		retval = retrieve_missing(bdate, edate, failstring)
		ls_KeyCol = cs_KeyCol_EmployeeId
	case "E"
		dw_report.dataobject = "d_logs_entered"
		dw_report.settransobject(sqlca)
		retval = retrieve_entered(bdate, edate, failstring)
		ls_KeyCol = cs_KeyCol_EmployeeId
	case "V"
		uo_choose_emp.sle_name.triggerevent(modified!)
		dw_report.dataobject = "d_vios_print"
		dw_report.settransobject(sqlca)
		if uo_choose_emp.sle_name.text = all_drivers then
			retval = retrieve_vios_all(bdate, edate, failstring)
		elseif not isnull(uo_choose_emp.cur_emp) then 
			retval = retrieve_vios_single(uo_choose_emp.cur_emp, bdate, edate, failstring)
		else
			messagebox("Log Report", "You need to choose one driver or select ALL drivers " +&
			"before this report can be generated.")
			dw_report.setredraw(true)
			retval = -2
		end if
		ls_KeyCol = cs_KeyCol_EmployeeId
	case "S"
		dw_report.dataobject = "d_vios_report"
		dw_report.settransobject(sqlca)
		retval = retrieve_stats(bdate, edate, failstring)
		ls_KeyCol = cs_KeyCol_DriverId
	case "A"
		dw_report.dataobject = "d_hours_avail"
		dw_report.settransobject(sqlca)
		retval = retrieve_avail(bdate, edate, failstring)
		ls_KeyCol = cs_KeyCol_EmployeeId
	case "W"
		dw_report.dataobject = "d_hours_worked"
		dw_report.settransobject(sqlca)
		retval = retrieve_worked(bdate, edate, failstring)
		ls_KeyCol = cs_KeyCol_EmployeeId
	case "D"
		dw_report.dataobject = "d_driver_report"
		dw_report.settransobject(sqlca)
		retval = retrieve_driver(failstring)
		ls_KeyCol = cs_KeyCol_DriverId
	end choose
	
	if isnull(usertag) then
		dw_report.object.st_usertag.visible = 0
	else
		dw_report.object.st_usertag.text = usertag
		dw_report.object.st_usertag.visible = 1
	end if
	
	//Discard employees that user does not have permission to view
	IF retval = 0 THEN
		
		IF NOT isNull(ls_KeyCol) AND Len(ls_KeyCol) > 0 THEN
			
			lnv_PrivsManager = gnv_App.of_GetPrivsManager( )
			ll_Rowcount = dw_report.RowCount()
			FOR i = ll_RowCount TO 1 STEP -1
				ll_EmpId = dw_report.GetItemNumber(i, ls_keycol)
				
				SELECT "driverinfo"."di_division" 
				INTO :ll_division
				FROM "driverinfo"  
				WHERE "driverinfo"."di_id" = :ll_EmpId;
				COMMIT;
				
				IF ll_Division > 0 THEN
					IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ViewLogReports, ll_Division) <> 1 THEN
						dw_report.RowsDiscard(i, i, Primary!)
					END IF
				END IF
				
			NEXT
			
			ll_RowcountAfter = dw_Report.RowCount()
			
			IF  ll_RowcountAfter < ll_RowCount THEN
				//if any rows were discarded, warn user
				MessageBox("Log Report", "The report will only contain drivers that you have divisional privileges to access.")
			END IF
			
		END IF
		
		
	END IF
	

	dw_report.setredraw(true)
	
END IF

Return retval
end function

event open;/*  This window will hold any report for driver violation.  The type of datawindow that will 
appear will depend on the messagestringparm.  For the sake of ease, I've given each
report type a code name.  The menu that will open this window must give this window the 
proper code to determine the type of report that will be retrieved.  

(not case sensitive)
available	=	work sheet for hours available						(d_hours_avail)
missing		=	missing logs report										(d_log_miss)
entered		=	status of entered logs									(d_logs_entered)
stats			=	company statistics report								(d_vios_report)
week			= 	hours worked in one week for all drivers			(d_hours_worked)

----------------------------------------------------------------------------------*/
this.x = 1
this.y = 1
gf_mask_menu(m_reports)

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_module_LogAudit, "E" ) < 0 THEN
	ib_DisableCloseQuery = TRUE
	close (this)
	return
END IF

 
uo_month.w_mainpar = this
uo_choose_emp.w_mainpar = this
date_range() 
all_drivers = upper("All Drivers")

uo_month.x = ddlb_sort.x
uo_month.y = sle_bdate.y
st_month.y = sle_Bdate.y + 12
st_date.y = sle_bdate.y + 4
st_to.y = sle_bdate.y + 4

st_date.x = sle_edate.x - (9 + st_date.width)

uo_month.x = ddlb_sort.x
uo_month.width = ddlb_sort.width
uo_month.ddlb_month.width = 485
uo_month.vsb_1.width = 69
uo_month.sle_year.width = uo_month.width - (485 + 69)
uo_month.height = sle_bdate.height + 10

uo_month.ddlb_month.x = 1
UO_month.sle_year.x = uo_month.ddlb_month.x + uo_month.ddlb_month.width
uo_month.vsb_1.x = uo_month.sle_year.x + uo_month.sle_year.width
st_month.x = uo_month.x + uo_month.ddlb_month.x - (9 + st_month.width)

uo_choose_emp.st_tag1.text = "Drivers"
uo_choose_emp.width = ddlb_sort.width + uo_choose_emp.st_tag1.x + uo_choose_emp.st_tag1.width + 9
uo_choose_emp.hsb_1.x = uo_choose_emp.width - uo_choose_emp.hsb_1.width

cbx_comments.x = ddlb_sort.x
cbx_ex.x = ddlb_sort.x + ddlb_sort.width - cbx_ex.width
cbx_comments.y = cbx_filter.y
cbx_ex.y = cbx_filter.y

sle_bdate.enabled = false
sle_edate.enabled = false
st_month.visible = false
st_date.visible = false
st_to.visible = true
uo_month.visible = false

ddlb_sort.enabled = false
//ddlb_tag.enabled = false
st_sort.visible = true
st_desig.visible = true
st_opts.visible = true
cbx_filter.enabled = false
cbx_ex.visible = false
cbx_comments.visible = false
uo_choose_emp.visible = false
cb_all.visible = false
st_driverinfo.visible = false
ddlb_driverinfo.visible = false


if gds_emp.rowcount() > 0 then   
	uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
	uo_choose_emp.ds_hotkey.setfilter("em_status <> 'D' and not isnull(di_id)")
	uo_choose_emp.ds_hotkey.filter()
end if

if uo_choose_emp.ds_hotkey.rowcount() = 0 then 
	uo_choose_emp.hsb_1.visible = false
end if


s_emp_info curemp
curemp = message.powerobjectparm
if isnull(curemp.em_id) then 
	rb_missing.checked = true
	rb_missing.triggerevent(clicked!)
	uo_choose_emp.cur_emp.em_id = null_long
else 
	rb_group.checked = true
	uo_choose_emp.cur_emp = curemp
	rb_group.triggerevent(clicked!)
	sle_bdate.setfocus()
end if


dw_report.x = 14
dw_report.y = 21
dw_report.width = g_max_w - ( 2 * dw_report.x) - 30
dw_report.height = g_max_h - (2 * dw_report.y) - 90
preview_mode(false)


end event

on w_log_reports.create
if this.MenuName = "m_reports" then this.MenuID = create m_reports
this.cb_all=create cb_all
this.rb_driver_info=create rb_driver_info
this.dw_report=create dw_report
this.st_opts=create st_opts
this.uo_choose_emp=create uo_choose_emp
this.cbx_ex=create cbx_ex
this.cbx_comments=create cbx_comments
this.rb_hours_avail=create rb_hours_avail
this.rb_hours_worked=create rb_hours_worked
this.rb_entered=create rb_entered
this.rb_stats=create rb_stats
this.rb_group=create rb_group
this.st_sort=create st_sort
this.st_desig=create st_desig
this.rb_missing=create rb_missing
this.gb_report=create gb_report
this.cbx_filter=create cbx_filter
this.sle_edate=create sle_edate
this.st_to=create st_to
this.sle_bdate=create sle_bdate
this.uo_month=create uo_month
this.ddlb_sort=create ddlb_sort
this.st_month=create st_month
this.ddlb_tag=create ddlb_tag
this.ddlb_driverinfo=create ddlb_driverinfo
this.st_date=create st_date
this.st_range_cover=create st_range_cover
this.ddlb_range=create ddlb_range
this.st_driverinfo=create st_driverinfo
this.Control[]={this.cb_all,&
this.rb_driver_info,&
this.dw_report,&
this.st_opts,&
this.uo_choose_emp,&
this.cbx_ex,&
this.cbx_comments,&
this.rb_hours_avail,&
this.rb_hours_worked,&
this.rb_entered,&
this.rb_stats,&
this.rb_group,&
this.st_sort,&
this.st_desig,&
this.rb_missing,&
this.gb_report,&
this.cbx_filter,&
this.sle_edate,&
this.st_to,&
this.sle_bdate,&
this.uo_month,&
this.ddlb_sort,&
this.st_month,&
this.ddlb_tag,&
this.ddlb_driverinfo,&
this.st_date,&
this.st_range_cover,&
this.ddlb_range,&
this.st_driverinfo}
end on

on w_log_reports.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_all)
destroy(this.rb_driver_info)
destroy(this.dw_report)
destroy(this.st_opts)
destroy(this.uo_choose_emp)
destroy(this.cbx_ex)
destroy(this.cbx_comments)
destroy(this.rb_hours_avail)
destroy(this.rb_hours_worked)
destroy(this.rb_entered)
destroy(this.rb_stats)
destroy(this.rb_group)
destroy(this.st_sort)
destroy(this.st_desig)
destroy(this.rb_missing)
destroy(this.gb_report)
destroy(this.cbx_filter)
destroy(this.sle_edate)
destroy(this.st_to)
destroy(this.sle_bdate)
destroy(this.uo_month)
destroy(this.ddlb_sort)
destroy(this.st_month)
destroy(this.ddlb_tag)
destroy(this.ddlb_driverinfo)
destroy(this.st_date)
destroy(this.st_range_cover)
destroy(this.ddlb_range)
destroy(this.st_driverinfo)
end on

event close;//if isvalid(w_vios_driver) then
//	w_Vios_driver.x = 1
//	w_vios_driver.y = 1
//end if
//
//
end event

event closequery;IF ib_DisableCloseQuery = TRUE THEN

	//Proceed to close with no intervention

ELSEIF gnv_App.of_GetFrame ( ).getfirstsheet() = this THEN

	if dw_report.visible = true then
		preview_mode(false)
		return 1
	end if

END IF



end event

type cb_all from statictext within w_log_reports
integer x = 37
integer y = 1100
integer width = 128
integer height = 76
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "All"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;uo_choose_emp.sle_name.text = all_drivers
end event

type rb_driver_info from radiobutton within w_log_reports
event clicked pbm_bnclicked
integer x = 91
integer y = 556
integer width = 795
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Driver Information Report "
end type

event clicked;rb_clicked()


end event

type dw_report from datawindow within w_log_reports
event dwnkey pbm_dwnkey
integer x = 2523
integer y = 284
integer width = 494
integer height = 360
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dwnkey;//if dw_report.visible = false then return
//if dw_report.dataobject <> "d_log_miss" then return
//
//integer retval, lrow
//
//lrow = integer(dw_report.describe("datawindow.pagecount()"))
//if keydown(keyleftarrow!) or keydown(KeyPageup!) or keydown(KeyUpArrow!) then
//	dw_report.ScrollpriorPage() 
//elseif keydown(keyrightarrow!) or keydown(KeyPagedown!) or keydown(KeyDownArrow!) then
//	dw_report.ScrollNextPage() 
//elseif keydown(KeyHome!) then
//	dw_report.setredraw(false)
//	do 
//		retval = dw_report.scrollpriorpage()
//	loop until retval = 1 or retval = -1	
//	dw_report.setredraw(true)
//elseif keydown(KeyEnd!) then
//	dw_report.setredraw(false)
//	do
//		retval = dw_report.ScrollNextPage()
//	loop until retval = lrow or retval = -1
//	dw_report.setredraw(true)
//end if
//
//
end event

event dberror;return 1
end event

type st_opts from statictext within w_log_reports
integer y = 1016
integer width = 453
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Print Options:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_choose_emp from u_choose_emp within w_log_reports
integer x = 151
integer y = 1100
integer taborder = 120
end type

on uo_choose_emp.destroy
call u_choose_emp::destroy
end on

type cbx_ex from checkbox within w_log_reports
event clicked pbm_bnclicked
integer x = 1435
integer y = 1012
integer width = 416
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Excused Vios"
end type

type cbx_comments from checkbox within w_log_reports
event clicked pbm_bnclicked
integer x = 462
integer y = 1012
integer width = 379
integer height = 76
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Comments"
end type

type rb_hours_avail from radiobutton within w_log_reports
integer x = 91
integer y = 480
integer width = 814
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Hours Available Worksheet "
end type

event clicked;rb_clicked()


end event

type rb_hours_worked from radiobutton within w_log_reports
integer x = 91
integer y = 404
integer width = 846
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Hours Worked in One Week "
end type

event clicked;rb_clicked()


end event

type rb_entered from radiobutton within w_log_reports
integer x = 91
integer y = 176
integer width = 645
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Entered Logs Report "
end type

event clicked;rb_clicked()


end event

type rb_stats from radiobutton within w_log_reports
integer x = 91
integer y = 328
integer width = 841
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Company Statistics Report "
end type

event clicked;rb_clicked()


end event

type rb_group from radiobutton within w_log_reports
integer x = 91
integer y = 252
integer width = 718
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Driver Violations Report "
end type

event clicked;rb_clicked()


end event

type st_sort from statictext within w_log_reports
integer x = 224
integer y = 816
integer width = 224
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Sort by:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_desig from statictext within w_log_reports
integer x = 105
integer y = 916
integer width = 343
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Designation:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_missing from radiobutton within w_log_reports
integer x = 91
integer y = 100
integer width = 645
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Missing Logs Report "
end type

event clicked;rb_clicked()


end event

type gb_report from groupbox within w_log_reports
integer x = 37
integer y = 24
integer width = 1234
integer height = 640
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = " Choose Report"
end type

type cbx_filter from checkbox within w_log_reports
event clicked pbm_bnclicked
integer x = 462
integer y = 1012
integer width = 896
integer height = 76
integer taborder = 90
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Only Drivers Missing Logs"
end type

type sle_edate from singlelineedit within w_log_reports
event modified pbm_enmodified
event rbuttondown pbm_rbuttondown
integer x = 928
integer y = 704
integer width = 343
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;n_cst_String	lnv_String
date edate

edate = lnv_String.of_SpecialDate ( sle_edate.text )

sle_edate.text = string(edate, "m/d/yy")
 
end event

event rbuttondown;this.setfocus()
s_date_return pickdate

pickdate.ypos = parent.y + this.y
pickdate.xpos = parent.x + this.x + this.width + 50

pickdate.mindate = null_date
pickdate.maxdate = null_date

pickdate.tag = "Choose Stop Search Date"

openwithparm(w_choose_day, pickdate)
if isdate(message.stringparm) then
	sle_edate.text = string(date(message.stringparm), "m/d/yy")
	sle_edate.postevent(modified!)
end if


end event

event getfocus;this.selecttext(1, len(this.text))
end event

type st_to from statictext within w_log_reports
integer x = 809
integer y = 708
integer width = 114
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_bdate from singlelineedit within w_log_reports
event modified pbm_enmodified
event rbuttondown pbm_rbuttondown
integer x = 462
integer y = 704
integer width = 343
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;n_cst_String	lnv_String
date bdate

bdate = lnv_String.of_SpecialDate ( sle_bdate.text )

sle_bdate.text = string(bdate, "m/d/yy")

end event

event rbuttondown;this.setfocus()
s_date_return pickdate

pickdate.ypos = parent.y + this.y
pickdate.xpos = parent.x + this.x + this.width + 50

pickdate.mindate = null_date
pickdate.maxdate = null_date
pickdate.tag = "Choose Start Search Date"
openwithparm(w_choose_day, pickdate)
if isdate(message.stringparm) then
	sle_bdate.text = string(date(message.stringparm), "m/d/yy")
	sle_bdate.postevent(modified!)
end if


end event

event getfocus;this.selecttext(1, len(this.text))
end event

type uo_month from u_month within w_log_reports
integer x = 439
integer y = 812
integer width = 690
integer height = 108
integer taborder = 60
end type

on uo_month.destroy
call u_month::destroy
end on

type ddlb_sort from dropdownlistbox within w_log_reports
event selectionchanged pbm_cbnselchange
integer x = 462
integer y = 800
integer width = 814
integer height = 1060
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Alphabetical"}
borderstyle borderstyle = stylelowered!
end type

type st_month from statictext within w_log_reports
integer x = 773
integer y = 908
integer width = 334
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Pick Month:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_tag from dropdownlistbox within w_log_reports
integer x = 462
integer y = 904
integer width = 814
integer height = 848
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event modified;this.text = trim(this.text)


end event

type ddlb_driverinfo from dropdownlistbox within w_log_reports
integer x = 462
integer y = 696
integer width = 814
integer height = 1060
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Mark Items on File","Mark Missing Items"}
end type

type st_date from statictext within w_log_reports
integer x = 439
integer y = 700
integer width = 905
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Target Hours Available Day:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_range_cover from statictext within w_log_reports
event dwnkey pbm_dwnkey
integer x = 46
integer y = 708
integer width = 320
integer height = 68
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Date Range"
alignment alignment = center!
end type

event dwnkey;if keydown(keyspacebar!) or keydown(keydownarrow!) or keydown(keyuparrow!) then
	send(handle(ddlb_range), 1039, 1, 0)
	if not keydown(keyspacebar!) then ddlb_range.setfocus()
end if
end event

event clicked;Send(Handle(ddlb_range), 1039, 1, 0)
ddlb_range.setfocus()



end event

type ddlb_range from dropdownlistbox within w_log_reports
event cbncloseup pbm_cbncloseup
event dwnkey pbm_dwnkey
integer x = 37
integer y = 700
integer width = 411
integer height = 448
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Date Range"
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event cbncloseup;st_range_cover.post setfocus()


end event

event dwnkey;if keydown(keyspacebar!) then
	send(handle(this), 1039, 0, 0)
	return 1
end if


end event

event selectionchanged;if nullornotpos(index) then return

date bdate, edate
integer posd

posd = pos(this.text, "-")

edate = date(trim(right(this.text, len(this.text) - posd)))
bdate = date(trim(left(this.text, posd - 1)) + "/" + string(year(edate)))
if bdate > edate then bdate = date(trim(left(this.text, posd - 1)) + "/" + string(year(edate) - 1))
sle_bdate.text = string(bdate, "m/d/yy")
sle_edate.text = string(edate, "m/d/yy")



end event

type st_driverinfo from statictext within w_log_reports
integer y = 708
integer width = 453
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Display Format:"
alignment alignment = right!
boolean focusrectangle = false
end type

