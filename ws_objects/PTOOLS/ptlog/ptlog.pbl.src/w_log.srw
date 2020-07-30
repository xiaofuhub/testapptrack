$PBExportHeader$w_log.srw
forward
global type w_log from window
end type
type st_noprivs from statictext within w_log
end type
type ds_vios_daily_print from datawindow within w_log
end type
type uo_choose_emp from u_choose_emp within w_log
end type
type cb_settings from commandbutton within w_log
end type
type cb_daily from commandbutton within w_log
end type
type cb_list_print from commandbutton within w_log
end type
type cb_log_print from commandbutton within w_log
end type
type st_lock from statictext within w_log
end type
type st_type from statictext within w_log
end type
type dw_vios_daily from datawindow within w_log
end type
type dw_log_list from datawindow within w_log
end type
type dw_miles from datawindow within w_log
end type
type uo_codriver from u_choose_emp within w_log
end type
type dw_vios_short from datawindow within w_log
end type
type gb_date from groupbox within w_log
end type
type st_insert6 from statictext within w_log
end type
type st_insert1 from statictext within w_log
end type
type st_insert2 from statictext within w_log
end type
type st_insert3 from statictext within w_log
end type
type st_insert4 from statictext within w_log
end type
type st_insert5 from statictext within w_log
end type
type st_insert7 from statictext within w_log
end type
type st_vios from statictext within w_log
end type
type dw_log from datawindow within w_log
end type
type violations from structure within w_log
end type
type rec_violations from structure within w_log
end type
type oldvios from structure within w_log
end type
type os_tracking from structure within w_log
end type
type os_violation from structure within w_log
end type
end forward

type violations from structure
	long		the_id
	date		the_date
	integer		the_num
	integer		the_time
	integer		howbad
	integer		the_type
	integer		limit
end type

type rec_violations from structure
	time		rec_time
	string		rec_type
	string		actual
	integer		rec_tz
	time		time_fixed
	date		rec_date
end type

type oldvios from structure
	string		vdesc
	string		reason
	date		vdate
	string		ex
	string		whoex
	integer		vtype
end type

type os_tracking from structure
	decimal { 2 }		ic_drivingtime
	decimal { 2 }		ic_totaldutytime
	datetime		idt_sleeperstart
	datetime		idt_sleeperend
	integer		ii_lastsleeperindex
	decimal { 2 }		ic_sleeperinterval
	datetime		idt_nextintervalstart
	integer		ii_nextintervalstartindex
	datetime		idt_drivinglimitreached
	datetime		idt_dutylimitreached
	decimal { 2 }		ic_drivingviolationtime
	decimal { 2 }		ic_dutyviolationtime
	datetime		idt_drivingviolationstart
	datetime		idt_dutyviolationstart
	decimal{2}		ic_continuoussleeper
end type

type os_violation from structure
	integer		ii_violationtype
	datetime		idt_limitreached
	datetime		idt_violationstart
	decimal {2}	ic_violationtime
end type

global type w_log from window
integer x = 5
integer y = 212
integer width = 3383
integer height = 1920
boolean titlebar = true
string title = "Log Entry"
string menuname = "m_log"
boolean controlmenu = true
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
event mousegone pbm_ncmousemove
st_noprivs st_noprivs
ds_vios_daily_print ds_vios_daily_print
uo_choose_emp uo_choose_emp
cb_settings cb_settings
cb_daily cb_daily
cb_list_print cb_list_print
cb_log_print cb_log_print
st_lock st_lock
st_type st_type
dw_vios_daily dw_vios_daily
dw_log_list dw_log_list
dw_miles dw_miles
uo_codriver uo_codriver
dw_vios_short dw_vios_short
gb_date gb_date
st_insert6 st_insert6
st_insert1 st_insert1
st_insert2 st_insert2
st_insert3 st_insert3
st_insert4 st_insert4
st_insert5 st_insert5
st_insert7 st_insert7
st_vios st_vios
dw_log dw_log
end type
global w_log w_log

type variables
protected:
integer curx, cury, xfix, yfix, start_check_row
integer rows_to_check[]
boolean add_next
boolean forced_closing = false
string copy_string, entry_str
string editmode= 'off', mbox_inst
date lastentered
statictext st_inpt[7]

public:
s_log_settings settings
s_emp_info cur_driver
datastore ds_violations, ds_receipts, ds_drivers
string log_string, bugstring
integer old_intsig, sched_type, vios_row
date lockdate
w_log_printing w_printchild
boolean win_is_closing = false, triggerit = false
integer minmph, maxmph, indx
integer lockopt

end variables

forward prototypes
public function integer autoprint (ref string fail_string)
public subroutine zz_clear_log ()
public subroutine zz_insert_log ()
public subroutine zz_delete_log ()
public subroutine zz_calc_only ()
public subroutine zz_add_next ()
public subroutine zz_lost_log ()
public subroutine zz_found_log ()
public subroutine zz_add_vios ()
public subroutine zz_receipts ()
public subroutine zz_settings ()
public subroutine zz_codriver ()
public subroutine zz_hundred ()
public subroutine zz_calc_and_save ()
public subroutine zz_print_options ()
public function integer miler_check ()
public subroutine delete_log ()
public subroutine skip_logs ()
public subroutine set_codriver ()
public subroutine menu_setup ()
public subroutine receipt_check ()
public subroutine setface (integer button)
public subroutine dw_losefocus ()
public function integer calc_and_save (ref string failnote)
public subroutine insert_log (integer selspot)
public subroutine log_to_chart (integer oldrow, integer newrow)
public subroutine set_choose_emp ()
public subroutine rowsmod ()
public subroutine refresh_shortvios ()
public subroutine set_vios ()
protected subroutine total_hours (boolean oldarg)
public subroutine sched_check ()
public subroutine violations_check ()
public subroutine emp_switch (integer uo_num)
public subroutine refresh_jump ()
public function integer wf_violationscheck (date ad_startdate)
public function integer wf_violationsrecord (date ad_impactstartdate, os_violation astra_violations[])
public function long wf_getcurrentdriverid ()
private function string wf_getformatteddatetime (datetime adt_target)
end prototypes

event mousegone;if editmode <> "insert" then return

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

end event

public function integer autoprint (ref string fail_string);// this ability is turned of for version 1.0

return 0
//if isnull(cur_driver.em_id) then return 100
//if dw_log_list.rowcount() = 0 then return 100
//
//date printdates[], tester[]
//integer pindx, totmiles, lcv, lcv2, rownum, lcvprint
//
//for lcv = 1 to dw_log_list.rowcount()
//	if dw_log_list.getitemdate(lcv, "dl_date") > lastentered and &
//		dw_log_list.getitemnumber(lcv, "dl_vios") = 1 then 
//		pindx ++
//		printdates[pindx] = dw_log_list.getitemdate(lcv, "dl_date")
//	end if 
//next
//if pindx = 0 then return 100
//
////if not isvalid(ds_vios_daily_print) then 
////	ds_vios_daily_print = create datastore 
////	ds_vios_daily_print.dataobject = "d_vios_daily_print"  
////	ds_vios_daily_print.settransobject(sqlca)
////end if
//
//string printstring = ""
//fail_string = ""
//
//ds_vios_daily_print.object.st_printsign.text = string(settings.printsign)
//
//for lcv = 1 to pindx 
//	ds_vios_daily_print.reset()
//
//	if ds_vios_daily_print.retrieve(cur_driver.em_id, printdates[lcv]) = -1 then
//		rollback ;
//		fail_string += "The following date could not be retrieved for:  " +&
//			string(printdates[lcv], "m/d/yy") + "~n"
//		continue
//	else
//		commit ;
//	end if
//
//	ds_vios_daily_print.object.st_date.text = string(printdates[lcv], "MMM D, yyyy (DDD)")
//
//	//--------------------------------------------------------violations nest	
//	tester = ds_vios_daily_print.object.report_vios.object.dv_date.primary
//	rownum = upperbound(tester)
//	
//	if rownum > 0 then
//		ds_vios_daily_print.object.st_numvios.text = "Number of Violations = " + string(rownum)
//		ds_Vios_daily_print.object.st_novios.visible = 0
//		ds_vios_daily_print.object.st_numvios.visible = 1
//	else
//		ds_Vios_daily_print.object.st_novios.visible = 1
//		ds_vios_daily_print.object.st_numvios.visible = 0
//	end if
//	//--------------------------------------------------------chart nest	
////	tester = ds_vios_daily_print.object.report_log.object.dl_date.primary
////	rownum = upperbound(tester)
//
//	ds_vios_daily_print.object.st_name.text = cur_driver.em_ln + ", " + cur_driver.em_fn
//	
//	totmiles = ds_vios_daily_print.object.report_log.object.dl_miles[1]
//	ds_vios_daily_print.object.st_miles.text = "Total Miles = " + string(totmiles)
//	
//	printstring += string(printdates[lcv], "m/d/yy") + ": " + string(rownum) + "~n" 
//	for lcvprint = 1 to settings.numcop
//		ds_vios_daily_print.print()
//	next
//next
//
//
//if len(fail_string) > 0 then return -1 else return 0
//
//
//
end function

public subroutine zz_clear_log ();dw_losefocus() 
if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) or left(log_string, 1) = "6" &
	or left(log_string, 1) = "7" or st_lock.visible = true &
	then return

if left(log_string, 1) = "5" then
	messagebox("Clear Log", "You cannot clear a lost log.  Report the log as found instead.")
	return
end if

dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_miles", 0)
dw_miles.setitem(1, "dl_miles", 0)
setface(1)
total_hours(true)

date date_check, thisdate

thisdate = dw_log_list.getitemdate(dw_log_list.getselectedrow(0), "dl_date")
uo_codriver.sle_name.text = ""


integer rows_vios, lcv, the_num = 0, rowtodelete[]
rows_vios = ds_violations.rowcount()
boolean stillvios = false

if rows_vios > 0 then
	for lcv = rows_vios to 1 step -1
		date_check = ds_violations.getitemdate(lcv, "dv_date")
		if date_check = thisdate then
			if ds_violations.getitemnumber(lcv, "dv_type") <> 5 then 
				the_num ++
				rowtodelete[the_num] = lcv
			else
				stillvios = true
			end if
		end if
	next 
end if

if the_num > 0 then 
	for lcv = 1 to the_num
		ds_violations.deleterow(rowtodelete[lcv])
	next
end if

if stillvios = false then
	st_vios.visible = false
	dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_vios", 0)
end if	
refresh_shortvios()

end subroutine

public subroutine zz_insert_log ();if isnull(cur_driver.em_id) then return
if St_noprivs.Visible = TRUE THEN RETURN 
integer lcv, lastrow
choose case editmode 
	case "delete" 
		return
	case "off"
		if miler_check() = 99 then
			dw_log_list.scrolltorow(dw_log_list.getselectedrow(0))
			dw_miles.setfocus()
			return
		end if
		if sched_type = 8 then
			st_inpt[1].y = dw_log_list.y + 108
			st_inpt[1].visible = true
			st_inpt[1].textcolor = rgb(255, 255, 255)
			for lcv = 2 to 7
				st_inpt[lcv].y = st_inpt[lcv - 1].y + 75
				if lcv = 5 then st_inpt[lcv].y = st_inpt[lcv].y - 10
				st_inpt[lcv].textcolor = rgb(255, 255, 255)
				st_inpt[lcv].visible = true 
			next
		else
			st_inpt[1].y = dw_log_list.y + 118
			st_inpt[1].visible = true
			st_inpt[1].textcolor = rgb(255, 255, 255)
			for lcv = 2 to 7
				st_inpt[lcv].y = st_inpt[lcv - 1].y + 86
				st_inpt[lcv].textcolor = rgb(255, 255, 255)
				if lcv <> 7 then st_inpt[lcv].visible = true
			next
		end if
		dw_miles.setfocus()
		dw_log_list.enabled = true
		editmode = "insert"
	case "insert"
		for lcv = 1 to 7
			st_inpt[lcv].visible = false
		next
		editmode = "off"
end choose

	

end subroutine

public subroutine zz_delete_log ();if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) then return

choose case editmode 
	case "insert" 
		return 
	case "off"
		if miler_check() = 99 then 
			dw_log_list.scrolltorow(dw_log_list.getselectedrow(0))
			dw_miles.setfocus()
			return
		end if
		dw_log_list.enabled = true
		editmode = "delete"
		dw_log_list.selectrow(0, false)
	case "delete"
		editmode = "off"

		integer lastrow
		lastrow = integer(dw_log_list.Object.DataWindow.FirstRowOnPage) + 3
		if lastrow = 0 then lastrow = dw_log_list.rowcount()

		dw_log_list.setredraw(false)
		dw_log.setredraw(false)
		log_to_chart(0, lastrow)
		dw_log_list.selectrow(0, false)
		dw_log_list.selectrow(lastrow, true)
		dw_log_list.scrolltorow(lastrow)
		dw_log_list.setredraw(true)
		dw_log.setredraw(true)
end choose





end subroutine

public subroutine zz_calc_only ();if isnull(cur_driver.em_id) then return
if St_noprivs.Visible = TRUE THEN RETURN 
dw_losefocus() 
rowsmod()
if indx > 0 then 
	if miler_check() = 99 then return 
	violations_check()
	sched_check()
	receipt_check()
	set_vios()
end if
refresh_shortvios()


end subroutine

public subroutine zz_add_next ();n_cst_LicenseManager	lnv_LicenseManager
if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) then return
dw_losefocus() 
 
//-----------------------------------------------------------miler check-
if miler_check() = 99 then 
	dw_miles.setfocus() 
	return 
end if
//-----------------------------------------------------------------------

integer lastrow, oldrow
date logdate

lastrow = dw_log_list.rowcount()
oldrow = dw_log_list.getselectedrow(0)
logdate = relativedate(dw_log_list.getitemdate(lastrow, "dl_date"), 1)

if daysafter(lnv_LicenseManager.of_GetLicenseExpiration ( ), logdate) > 0 then 
	messagebox("Add Next Log", lnv_LicenseManager.of_GetExpirationNotice ( ) +&
	"Logs cannot be added past this date.  Please contact Profit Tools to extend your "+&
	"registration.", exclamation!)
	return 
end if

string checklast
checklast = dw_log_list.getitemstring(lastrow, "dl_log")
if left(checklast, 1) = "8" then
	string tempstr
	tempstr = fill("1", 96)
	dw_log_list.setitem(lastrow, "dl_miles", 0)
	dw_log_list.setitem(lastrow, "dl_log", tempstr)
	dw_log_list.setitem(lastrow, "dl_odtot", 0)
	dw_log_list.setitem(lastrow, "dl_drtot", 0)
	dw_log_list.setitem(lastrow, "dl_vios", 0)	
	dw_log_list.setitem(lastrow, "comp_mod", "y")
end if
curx=1
cury=1

dw_log.modify("st_curpos.text = '" + string(curx * 10 + cury) + "'")

lastrow = dw_log_list.insertrow(0)
dw_log_list.setitem(lastrow, "dl_vios", 0)
dw_log_list.setitem(lastrow, "dl_miles", 0)
dw_log_list.setitem(lastrow, "dl_id", cur_driver.em_id)
dw_log_list.setitem(lastrow, "dl_date", logdate)
dw_log_list.setitem(lastrow, "comp_mod", "y")
log_string = fill("8", 96)
dw_log_list.setitem(lastrow, "dl_log", log_string)
dw_log_list.selectrow(0, false)
dw_log_list.selectrow(lastrow, true)
dw_log_list.setcolumn("dl_odtot")
dw_log_list.scrolltorow(lastrow)
dw_log_list.setrow(lastrow)

gb_date.text = string(logdate, "m/d/yy") + "  " + dayname(logdate)

dw_log.enabled = true
uo_codriver.enabled = true
st_lock.visible = false
st_vios.visible = false

dw_log.setredraw(false)
dw_miles.setredraw(false)

dw_log.reset()
dw_miles.reset()

dw_log_list.RowsCopy (lastrow, lastrow, primary!, dw_log, 99, primary!)
dw_log_list.RowsCopy (lastrow, lastrow, primary!, dw_miles, 99, primary!)
cury = integer(left(log_string, 1))
dw_log.modify("st_curpos.text = '" + string(1 * 10 + cury) + "'")
dw_log.object.di_lockdate.text = string(lockdate, "m/d/yy")
dw_miles.object.di_lockdate.text = string(lockdate, "m/d/yy")
curx = 1
uo_codriver.sle_name.text = ""
uo_codriver.cur_emp.em_id = null_long
dw_log.setredraw(true)
dw_miles.setredraw(true)

total_hours(true)
add_next = true
refresh_shortvios()
dw_log.setfocus()

end subroutine

public subroutine zz_lost_log ();dw_losefocus() 
if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) then return
if st_lock.visible = true then return
if left(log_string, 1) = "5" or left(log_string, 1) = "7" then	return

string checkstr
integer currow

checkstr = fill("1", 96)
currow =	dw_log_list.getselectedrow(0)

if checkstr <> dw_log_list.getitemstring(currow, "dl_log") and &
	left(dw_log_list.getitemstring(currow, "dl_log"), 1) <> "8" then 
	if messagebox("Lost Log", "OK to report " + & 
		string(dw_log_list.getitemdate(currow, "dl_date"), "m/d/yy") +&
		 " as missing?", question!, okcancel!) = 2 then return
end if

dw_log.setredraw(false)
dw_miles.setredraw(false)

log_string = fill("5", 96)
dw_log.setitem(1, "dl_log", log_string)
dw_log_list.setitem(currow, "dl_vios", 1)
dw_log_list.setitem(currow, "dl_odtot", 0)
dw_log_list.setitem(currow, "dl_drtot", 0)
dw_log_list.setitem(currow, "dl_miles", 0)
dw_miles.setitem(1, "dl_miles", 0)
dw_miles.setitem(1, "dl_log", log_string)

dw_log.setredraw(true)
dw_miles.setredraw(true)

st_vios.visible = true
dw_log.enabled = false

total_hours(true)

indx = 1
rows_to_check[1] = currow

miler_check()
violations_check()
sched_check()
receipt_check()
set_vios()

date checkdate
integer lcv, viosrow
checkdate = dw_log_list.getitemdate(currow, "dl_date")

viosrow = 0
for lcv = ds_Violations.rowcount() to 1 step -1
	if ds_violations.getitemdate(lcv, "dv_date") = checkdate and &
		ds_violations.getitemnumber(lcv, "dv_type") = 7 then 
		viosrow = lcv	
		Exit
	end if
next

if viosrow = 0 then /*this should never happen*/ return

string cmts 
cmts = gnv_App.of_GetUserId ( ) + " set this log as missing on " + string(today(), "m/d/yy") +&
	" at " + string(now(), "h:mm A/P") + "."
ds_violations.setitem(viosrow, "dv_reason", cmts)
dw_log_list.setitem(currow, "comp_mod", "y")
refresh_shortvios()
cb_log_print.taborder = 1
cb_log_print.postevent(getfocus!)
dw_miles.setredraw(true)
dw_miles.taborder = 0


end subroutine

public subroutine zz_found_log ();dw_losefocus() 
if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) then return
if st_lock.visible = true then return

if left(log_string, 1) <> "5" or st_lock.visible = true then
	return
else
//	if essagebox("Missing Log", "If log for " + st_date.text + " was found press" + &
//		" OK.", exclamation!, okcancel!, 2) = 2 then return
end if

setface(1) 
total_hours(true)

date thisdate
integer lcv, typevios

thisdate = dw_log_list.getitemdate(dw_log_list.getselectedrow(0), "dl_date")

if ds_violations.rowcount() > 0 then
	for lcv = 1 to ds_violations.rowcount()
		if thisdate = ds_violations.getitemdate(lcv, "dv_date") then
			typevios = ds_violations.getitemnumber(lcv, "dv_type") 
			if typevios = 5 or typevios = 6 or typevios = 0 then goto skiprest
		end if
	next
end if

st_vios.visible = false
dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_vios", 0)

skiprest:
refresh_shortvios()

end subroutine

public subroutine zz_add_vios ();dw_losefocus() 
if isnull(cur_driver.em_id) then return 
if st_lock.visible = true then return
if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) or left(log_string, 1) = "8" or left(log_string, 1) = "7" then return

string return_value
openwithparm(w_add_vios, string(cur_driver.em_id))
return_value = message.stringparm
if isnull(return_value) or len(return_value) = 0 then return 

integer posx
posx = pos(return_value, "x")
integer vtype, row_end, row_find, the_num
vtype = integer(left(return_value, 1))
return_value = right(return_value, len(return_value) - 2)

date thisdate
thisdate = dw_log_list.getitemdate(dw_log_list.getselectedrow(0), "dl_date")

row_end = ds_violations.rowcount()

if row_end > 0 then
	row_find = ds_violations.find("dv_date = " + string(thisdate, "yyyy-mm-dd"), row_end, 1)

	do while row_find > 0
		the_num = max(ds_violations.getitemnumber(row_find, "dv_num"), the_num)
		row_find = row_find - 1
		if row_find < 1 then exit 
		row_find = ds_violations.find("dv_date = " + string(thisdate, "yyyy-mm-dd"), row_find, 1)
	loop
end if

the_num ++

// end of number search ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	row_end = ds_violations.insertrow(0)
	ds_violations.setitem(row_end, "dv_id", cur_driver.em_id)
	ds_violations.setitem(row_end, "dv_date", thisdate)
	ds_violations.setitem(row_end, "dv_num", the_num)
	ds_violations.setitem(row_end, "dv_type", vtype)
	ds_violations.setitem(row_end, "dv_desc", return_value)
	dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_vios", 1)
	if dw_log_list.getitemstring(dw_log_list.getselectedrow(0), "comp_mod") = "n" then &
		dw_log_list.setitem(dw_log_list.getselectedrow(0), "comp_mod", "o")
	st_vios.visible = true
	refresh_shortvios()

IF RETURN_VALUE = "The driver failed to include the total miles driven for this day." then
	add_next = false
end if

end subroutine

public subroutine zz_receipts ();if St_noprivs.Visible = TRUE THEN RETURN 
dw_losefocus() 
if isnull(cur_driver.em_id) then return
if left(log_string, 1) = "8" or left(log_string, 1) = "7" or &
	st_lock.visible = true then return

if miler_check() = 99 then return
openwithparm(w_log_receipts, this)

if ds_receipts.modifiedcount() > 0 or ds_receipts.deletedcount() > 0 or &
	message.stringparm = "true" then
	if dw_log_list.getitemstring(dw_log_list.getselectedrow(0), "comp_mod") = "n" then &
		dw_log_list.setitem(dw_log_list.getselectedrow(0), "comp_mod", "o")
	rowsmod()
	if indx > 0 then 
		violations_check()
		miler_check()
		sched_check()
		receipt_check()
		set_vios()
	end if
	refresh_shortvios()
end if
end subroutine

public subroutine zz_settings ();openwithparm(w_log_settings, settings)

settings = message.powerobjectparm






end subroutine

public subroutine zz_codriver ();dw_losefocus() 
if isnull(cur_driver.em_id) then return

if getfocus() = uo_codriver.sle_name then 
	triggerit = true
	uo_codriver.sle_name.triggerevent(modified!)
end if

if isnull(dw_log_list.getitemnumber(dw_log_list.getselectedrow(0), "dl_codriver_id")) then 
	messagebox("View Codriver's Log", "You must specify the codriver first.")
	uo_codriver.sle_name.setfocus()
	return
end if 

string testchar
testchar = left(dw_log_list.getitemstring(dw_log_list.getselectedrow(0), "dl_log"), 1) 
if testchar = "8" or testchar = "5" or testchar = "6" or testchar = "7" then
	messagebox("View Codriver's Log", "In order to use this option, the current driver "+&
		"must also have a log entered for this date.")
	return
end if		

gb_date.text = string(dw_log_List.getitemdate(dw_log_list.getselectedrow(0), "dl_date"), "m/d/yy")
openwithparm(w_codriving, this)

end subroutine

public subroutine zz_hundred ();dw_losefocus() 
dw_miles.accepttext()
dw_log_list.accepttext()
if St_noprivs.Visible = TRUE THEN RETURN 
if st_lock.visible = true or isnull(cur_driver.em_id) or left(log_string, 1) = "7" then
	return
elseif left(log_string, 1) = "5" then
	messagebox("100 Air-Mile Radius", "You must report the log as found before you can "+&
		"use the 100 Air-Mile Radius rules.")
	return
elseif left(log_string, 1) = "6" then
	if dw_log_list.object.dl_odtot[dw_log_list.getselectedrow(0)] > 0 then
		if messagebox("Undo 100 Air-Mile Radius", "OK to clear hours worked and "+&
			"enter a log for this day instead?", question!, okcancel!) = 2 then return
	end if
	dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_drtot", 0)
	dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_odtot", 0)
	dw_log.setredraw(false)
	dw_miles.setredraw(false)

	log_string = fill("1", 96)
	dw_log.setitem(1, "dl_log", log_string)
	cury = 1
	curx = 1
	dw_log.modify("st_curpos.text = '" + string(1 * 10 + cury) + "'")
	dw_miles.reset()
	dw_log.rowscopy(1, 1, primary!, dw_miles, 99, primary!)

	dw_log.enabled = True
	dw_log.setredraw(True)
	dw_miles.setredraw(True)
	dw_log.setfocus()
else
	string checkstr
	checkstr = fill("1", 96)
	if log_string <> checkstr and left(log_string, 1) <> "8" then
		if messagebox("100 Air-Mile Radius", "OK to clear the current log and use the " +&
		"100 Air-Mile Radius rules instead?", question!, okcancel!) = 2 then return
	end if
	dw_log.setredraw(false)
	log_string = fill("6", 96)
	dw_log.setitem(1, "dl_log", log_string)
	dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_drtot", 0)
	dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_odtot", 0)
	dw_miles.reset()
	dw_log.rowscopy(1, 1, primary!, dw_miles, 99, primary!)
	dw_log.enabled = false
	dw_log.setredraw(true)
end if
total_hours(true)
indx = 1
rows_to_check[1] = dw_log_list.getselectedrow(0)

//miler_check()
violations_check()
sched_check()
receipt_check()
set_vios()
refresh_shortvios()

end subroutine

public subroutine zz_calc_and_save ();dw_losefocus() 
if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) then return

if g_privs.log[3] = 0 then 
	messagebox("Save Changes", "Your current user privileges do not allow you " +&
	"to edit driver logs.", exclamation!)
	return
end if


setpointer(hourglass!)

string failnote
choose case calc_and_save(failnote)
	case -1
		messagebox("Save Changes", failnote)
end choose

refresh_shortvios()

end subroutine

public subroutine zz_print_options ();if St_noprivs.Visible = TRUE THEN RETURN 
if isnull(cur_driver.em_id) then return
dw_losefocus() 
if g_privs.log[2] = 0 then 
	messagebox("Print Request", "Your current user privileges do not allow you " +&
	"to print reports.", exclamation!)
	return
end if

rowsmod()
if indx > 0 then 
	if miler_check() = 99 then return
	violations_check()
	sched_check()
	receipt_check()
	set_vios()
end if

if isvalid(w_printchild) then
	show(w_printchild) 
else
	openwithparm(w_printchild, this, this)
end if

end subroutine

public function integer miler_check ();if isnull(cur_driver.em_id) then return 0 
dw_miles.accepttext()

/* return 0 means OK/continue
	return 99 means stop and enter the miles */

integer currow, lcv, miles
decimal tothours, aver 
date thisdate 
string fchar
//------------------------------------------------------------------getting info
currow = dw_log_list.getselectedrow(0)
if currow = 0 or isnull(currow) then
	return 0 
elseif dw_log_list.getitemstatus(currow, 0, primary!) = notmodified! or &
	dw_log_list.getitemstatus(currow, 0, primary!) = new! then
	return 0
end if

miles = dw_log_list.getitemnumber(currow, "dl_miles")
fchar = left(dw_log_list.getitemstring(currow, "dl_log"), 1)
thisdate = dw_log_list.getitemdate(currow, "dl_date")
tothours = dw_log_list.getitemnumber(currow, "dl_drtot")

if isnull(miles) then 
	miles = 0 
	dw_log_list.setitem(currow, "dl_miles", 0)
end if

if thisdate < lockdate then return 0
if fchar <> "1" and fchar <> "2" and fchar <> "3" and fchar <> "4" then goto mphcheck

if tothours = 0 then	aver = 0 else aver = round(miles / tothours, 1)
if (miles > 0 and tothours = 0) then 
	dw_miles.setfocus() 
	messagebox("Reported Miles", "Driver cannot report 0 hours of driving and " + &
		"also record " + string(miles) + " miles driven.", exclamation!)
	return 99
elseif miles = 0 and add_next = true and tothours > 0 and settings.entermiles = 1 then
	add_next = false 
	dw_miles.setfocus()
	if messagebox("Enter Miles?","The mileage was not entered. OK to continue?", &
		question!, okcancel!) = 2 then 
		dw_miles.setfocus()
		return 99
	end if
elseif add_next = true then
	add_next = false
end if

// ---------------------------------------- Creating Violation
mphcheck:
string v_desc
integer maxnum

if (aver > maxmph or aver < minmph) and aver <> 0 then
//	string highorlow
//	if aver > maxmph then
//		highorlow = "high"
//	else
//		highorlow = "low"
//	end if

	v_desc = "Log shows that driver drove for " + string(miles) + " mile"
	if miles <> 1 then v_desc += "s"
	v_desc += " in " + string(tothours, "0.00") + " hour" 
	if tothours <> 1 then v_desc += "s"
	v_desc += ".  The average speed is " + string(aver, "0.00") + " MPH.  "  // +&
//		"This is an unusually " + highorlow + " rate of speed."
	if aver > maxmph then
		v_desc += "This exceeds the company maximum of " + string(maxmph) + " MPH."
	else
		v_desc += "This falls below the company minimum of " + string(minmph) + " MPH."
	end if
end if

if ds_violations.rowcount() > 0 then
	for lcv = ds_violations.rowcount() to 1 step -1
		if ds_violations.getitemdate(lcv, "dv_date") = thisdate and &
			ds_violations.getitemnumber(lcv, "dv_type") = 4 then
			if ds_violations.getitemstring(lcv, "dv_desc") = v_desc then 
				return 0
			else
				ds_violations.deleterow(lcv)
			end if
		elseif ds_violations.getitemdate(lcv, "dv_date") = thisdate then 
			maxnum = max(ds_violations.getitemnumber(lcv, "dv_num"), maxnum)
		end if
	next 
end if
	
	
if len(trim(v_desc)) > 0 then 
	maxnum ++
	currow = ds_violations.insertrow(0)
	ds_violations.setitem(currow, "dv_id", cur_driver.em_id)
	ds_violations.setitem(currow, "dv_date", thisdate)
	ds_violations.setitem(currow, "dv_num", maxnum)
	ds_violations.setitem(currow, "dv_type", 4)
	ds_violations.setitem(currow, "dv_desc", v_desc)
elseif maxnum = 0 then
	if dw_log_list.getitemnumber(dw_log_list.getselectedrow(0), "dl_vios") = 1 then &
		dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_vios", 0)
end if
return 0


end function

public subroutine delete_log ();if isnull(cur_driver.em_id) then return

integer delrow
delrow = dw_log_list.getselectedrow(0) 
dw_log_list.scrolltorow(delrow)

if delrow = 0 then
	messagebox("Remove Extra Log", "You must select a log to remove.")
	return 
elseif delrow <= sched_type then 
	messagebox("Remove Extra Log", "You cannot remove this type of driver log.")
	return 
end if

if dw_log_list.getitemdate(delrow, "dl_date") < lockdate then
	messagebox("Remove Extra Log", "Cannot remove a locked log.")
	return 
end if

string msgstr
msgstr = "OK to remove " + string(dw_log_list.getitemdate(delrow, "dl_date"), "m/d/yy") + "?"
if dw_log_list.rowcount() > delrow then msgstr += "  (All subsequent logs will be "+&
	"shifted back one day.)"
if messagebox("Remove Extra Log", msgstr, question!, okcancel!) = 2 then return
//--------------------------------------------------------------------OK to delete

dw_log_list.setredraw(false)
dw_log.setredraw(false)

date thisdate
thisdate = dw_log_list.getitemdate(delrow, "dl_date")
integer lcv
for lcv = dw_log_list.rowcount() to 1 step -1
	if dw_log_list.getitemdate(lcv, "dl_date") > thisdate then
		dw_log_list.setitem(lcv, "dl_date", &
			relativedate(dw_log_list.getitemdate(lcv, "dl_date"), -1))
	elseif dw_log_list.getitemdate(lcv, "dl_date") = thisdate then
		dw_log_list.deleterow(lcv)
	end if
next

if ds_violations.rowcount() > 0 then 
	for lcv = ds_violations.rowcount() to 1 step -1
		if ds_violations.getitemdate(lcv, "dv_date") > thisdate then
			ds_violations.setitem(lcv, "dv_date", &
				relativedate(ds_violations.getitemdate(lcv, "dv_date"), -1))
			ds_violations.setitemstatus(lcv, 0, primary!, newmodified!)
		elseif ds_violations.getitemdate(lcv, "dv_date") = thisdate then
			ds_violations.rowsdiscard(lcv, lcv, primary!)
		end if
	next
end if

if ds_receipts.rowcount() > 0 then 
	for lcv = ds_receipts.rowcount() to 1 step -1
		if ds_receipts.getitemdate(lcv, "lr_date") > thisdate then
			ds_receipts.setitem(lcv, "lr_date", &
				relativedate(ds_receipts.getitemdate(lcv, "lr_date"), -1))
			ds_receipts.setitemstatus(lcv, 0, primary!, newmodified!)
		elseif ds_receipts.getitemdate(lcv, "lr_date") = thisdate then
			ds_receipts.rowsdiscard(lcv, lcv, primary!)
		end if
	next
end if

dw_log_list.sort()
ds_violations.sort()
ds_receipts.sort()

editmode = "off"

delrow ++
if delrow > dw_log_list.rowcount() then delrow = dw_log_list.rowcount()
dw_log_list.setredraw(false)
dw_log.setredraw(false)
log_to_chart(0, delrow)
dw_log_list.selectrow(0, false)
dw_log_list.selectrow(delrow, true)
dw_log_list.scrolltorow(delrow)
dw_log_list.setredraw(true)
dw_log.setredraw(true)

return 
end subroutine

public subroutine skip_logs ();if isnull(cur_driver.em_id) then return
if dw_log_list.rowcount() = 0 then return

dw_losefocus()  

//-----------------------------------------------------------miler check-
if miler_check() = 99 then 
	dw_miles.setfocus() 
	return 
end if
//-----------------------------------------------------------------------


openwithparm(w_log_skipdays, this)

string tempstr, fillstr
date skipdate, lastdate
integer newrow

tempstr = message.stringparm
if isnull(tempstr) or len(trim(tempstr)) = 0 or not isdate(tempstr) then return
skipdate = date(tempstr)
lastdate = relativedate(dw_log_list.getitemdate(dw_log_list.rowcount(), "dl_date"), 1)

fillstr = fill("1", 96)
if left(dw_log_list.getitemstring(dw_log_list.rowcount(), "dl_log"), 1) = "8" then
	dw_log_list.setitem(dw_log_list.rowcount(), "dl_log", fillstr)
	dw_log_list.setitem(dw_log_list.rowcount(), "comp_mod", "y")
end if

dw_log_list.setredraw(false)
do until lastdate = skipdate
	newrow = dw_log_list.insertrow(0)
	dw_log_list.setitem(newrow, "dl_vios", 0)
	dw_log_list.setitem(newrow, "dl_miles", 0)
	dw_log_list.setitem(newrow, "dl_id", cur_driver.em_id)
	dw_log_list.setitem(newrow, "dl_date", lastdate)
	dw_log_list.setitem(newrow, "comp_mod", "y")
	dw_log_list.setitem(newrow, "dl_log", fillstr)
	lastdate = relativedate(lastdate, 1)
loop 

zz_add_next()
dw_log_list.setredraw(true)
return


end subroutine

public subroutine set_codriver ();if isnull(cur_driver.em_id) or dw_log_list.rowcount() = 0 then 
	uo_codriver.temp_emp.em_id = null_long
	uo_codriver.cur_emp.em_id = null_long
	uo_codriver.set_emp(false)
	return
elseif st_lock.visible = true then
	uo_codriver.set_emp(false)
	return
end if
if uo_codriver.temp_emp.em_id = cur_driver.em_id then
	if uo_codriver.jumper <> "NO" and uo_codriver.ds_hotkey.rowcount() > 1 then
		uo_codriver.cur_emp = uo_codriver.temp_emp
		if uo_codriver.jumper = "FORWARD" then
			uo_codriver.hsb_1.postevent("lineright")
		else
			uo_codriver.hsb_1.postevent("lineleft")
		end if
		return
	else
		uo_codriver.set_emp(false)
		return
	end if
elseif not isnull(dw_log_list.getitemnumber(dw_log_list.getselectedrow(0), "dl_codriver_id")) and &
	dw_log_list.getitemnumber(dw_log_list.getselectedrow(0), "dl_codriver_id") = &
	uo_codriver.temp_emp.em_id then
	uo_codriver.set_emp(true)
	return
end if
uo_codriver.set_emp(true)
dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_codriver_id", uo_codriver.temp_emp.em_id)
if dw_log_list.getitemstring(dw_log_list.getselectedrow(0), "comp_mod") = "n" then &
	dw_log_list.setitem(dw_log_list.getselectedrow(0), "comp_mod", "o") 






end subroutine

public subroutine menu_setup ();if g_privs.log[3] = 0 then
	m_log.m_current.m_lost.visible = false
	m_log.m_current.m_found.visible = false
	m_log.m_current.m_air.visible = false
	m_log.m_current.m_insert_log.visible = false 
	m_log.m_current.m_remove_extra.visible = false
	m_log.m_current.m_skipahead.visible = false
	m_log.m_current.m_save.visible = false
	m_log.m_current.m_receipts.visible = false
	m_log.m_current.m_add_vios.visible = false
	m_log.m_current.m_div_c03.visible = false
	m_log.m_current.m_div_c04.visible = false
	m_log.m_current.m_div_c05.visible = false

	m_log.m_current.m_lost.toolbaritemvisible = false
	m_log.m_current.m_found.toolbaritemvisible = false
	m_log.m_current.m_air.toolbaritemvisible = false
	m_log.m_current.m_insert_log.toolbaritemvisible = false
	m_log.m_current.m_remove_extra.toolbaritemvisible = false
	m_log.m_current.m_skipahead.toolbaritemvisible = false
	m_log.m_current.m_save.toolbaritemvisible = false
	m_log.m_current.m_receipts.toolbaritemvisible = false
	m_log.m_current.m_add_vios.toolbaritemvisible = false
	uo_codriver.enabled = false 
end if
if g_privs.log[2] = 0 then
	m_log.m_current.m_log_print.visible = false
	m_log.m_current.m_log_print.toolbaritemvisible = false
end if
end subroutine

public subroutine receipt_check ();Integer	li_BaseTimeZone
n_cst_LicenseManager	lnv_LicenseManager

li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )


integer lcv, mod_row = 0, log_row, lcv2
integer rec_zone, maxvios, rec_vios, newrow

time rec_time, time_fixed
decimal checkpoint, margin
string rec_type, status, status2, check_log
string v_desc, v1, v2, v3

date log_date

rec_violations vios[] 
oldvios old[]
integer xx = 0

rec_vios = 0

//------------------------------------------------------------------------------------------
for lcv = 1 to ds_receipts.rowcount()
	log_date = ds_receipts.getitemdate(lcv, "lr_date")
	if log_date < lockdate then continue
	
	rec_type = ds_receipts.getitemstring(lcv, "lr_type")
	rec_time = ds_receipts.getitemtime(lcv, "lr_time")
	rec_zone = ds_receipts.getitemnumber(lcv, "lr_tz")
	
	if rec_zone <> li_BaseTimeZone then
		time_fixed = reltime_ext(string(rec_time, "hh:mm:ss"), 3600 * (li_BaseTimeZone - rec_zone))
	else
		time_fixed = rec_time
	end if
	
	checkpoint = ((hour(time_fixed) * 60 + minute(time_fixed)) / 15) + 1 
	if start_time <> 0 or start_time <> 24 then
		checkpoint = checkpoint - start_time * 4
		if checkpoint <= 0 then checkpoint += 96
	end if
	/* margin for error  -- can be changed here -- currently it is 3 minutes*/
	margin = checkpoint - round(checkpoint, 0)
	
	checkpoint = integer( truncate (checkpoint, 0))
	log_row = dw_log_list.find("dl_date = " + string(log_date, "yyyy-mm-dd") + " and " +&
		"dl_id = " + string(cur_driver.em_id), start_check_row, 9999)
	check_log = dw_log_list.getitemstring(log_row, "dl_log")
	status = mid(check_log, checkpoint, 1)
	if status = "5" or status = "6" then continue

//	Bug Fix 2.5.04  Was not flagging Fueling while Driving
//	if (rec_type = "F" and (status = "3" or status = "4") ) or (rec_type = "T" and &
//		status = "3") then

	if (rec_type = "F" and status = "4") or (rec_type = "T" and status = "3") then

	else
		if abs(margin) <= .2 then    // .2 = 1/5 of 15 min = 3 minute error of margin
			if margin < 0 then  //rounded up
				if checkpoint = 96 then
					if dw_log_list.rowcount() = log_row then
						goto nomargin
					else
						check_log = dw_log_list.getitemstring(log_row + 1, "dl_log")
					end if
					checkpoint = 0  //will add the next one on next line
				end if		
				status2 = mid(check_log, checkpoint + 1, 1)
			else
				if checkpoint = 1 then
					if log_row = 1 then
						goto nomargin
					else
						check_log = dw_log_list.getitemstring(log_row - 1, "dl_log")
					end if
					checkpoint = 95 //will subtract the next one on next line
				end if		
				status2 = mid(check_log, checkpoint - 1, 1)
			end if
		else
			goto nomargin
		end if

//		Bug Fix 2.5.04  Was not flagging Fueling while Driving	
//		if (rec_type = "F" and (status2 = "3" or status2 = "4") ) or (rec_type = "T" &
//			and status2 = "3") then

		if (rec_type = "F" and status2 = "4") or (rec_type = "T" and status2 = "3") then

		else
			nomargin:
			rec_vios ++
			vios[rec_vios].rec_date = log_date
			vios[rec_vios].rec_time = rec_time
			vios[rec_vios].rec_type = rec_type
			vios[rec_vios].actual = status
			vios[rec_vios].rec_tz = rec_zone
			vios[rec_vios].time_fixed = time_fixed
		end if
	end if
next
//------------------------------------------------------------------------------------
for lcv = ds_violations.rowcount() to 1 step -1
 	if ds_violations.getitemnumber(lcv, "dv_type") <> 5 then continue
	if ds_violations.getitemdate(lcv, "dv_date") < lockdate then continue
	if ds_violations.getitemstring(lcv, "dv_excused") = "T" or &
		len(trim(ds_violations.getitemstring(lcv, "dv_reason"))) > 0 then
		xx ++
		old[xx].vdesc = ds_violations.getitemstring(lcv, "dv_desc")
		old[xx].reason = ds_violations.getitemstring(lcv, "dv_reason")
		old[xx].vdate = ds_violations.getitemdate(lcv, "dv_date")
		old[xx].ex = ds_violations.getitemstring(lcv, "dv_excused")
		old[xx].whoex = ds_violations.getitemstring(lcv, "dv_who_ex")
	end if 
	ds_violations.deleterow(lcv)
next

if rec_vios > 0 then
	for lcv = 1 to rec_vios
		maxvios = 0
		for lcv2 = 1 to ds_violations.rowcount()
			if ds_violations.getitemdate(lcv2, "dv_date") = vios[lcv].rec_date then &
				maxvios = max(ds_violations.getitemnumber(lcv2, "dv_num"), maxvios)
		next
		maxvios ++
		if vios[lcv].rec_type = "F" then 
			v1 = "refueling "
		else
			v1 = "paying a toll "
		end if

		if vios[lcv].actual = "1" then
			v2 = "off duty."
		elseif vios[lcv].actual = "2" then
			v2 = "in the sleeper berth."

		//Bug Fix: This condition ("3") was added 2.5.04
		elseif vios[lcv].actual = "3" then
			v2 = "driving."

		else // type 4
			v2 = "on duty but not driving."
		end if

		v3 = string(vios[lcv].rec_time, "h:mm AM/PM") 
		if vios[lcv].rec_tz <> li_BaseTimeZone then
			choose case vios[lcv].rec_tz 
				case 0
					v3 = v3 + " HWI "
				case 1
					v3 = v3 + " ALA "
				case 2
					v3 = v3 + " PAC "
				case 3
					v3 = v3 + " MTN "
				case 4
					v3 = v3 + " CEN "
				case 5
					v3 = v3 + " EST "
				case 6
					v3 = v3 + " ATL "
			end choose
			v3 = v3 + "(" + string(vios[lcv].time_fixed, "h:mm AM/PM") + " on log)"
		end if 

		v_desc = "Receipt shows driver was " + v1 + "at " + v3 + ".  Driver " +&
			"log contradicts this information by reporting that driver was " + v2 

		newrow = ds_violations.insertrow(0)
		ds_violations.setitem(newrow, "dv_id", cur_driver.em_id)
		ds_violations.setitem(newrow, "dv_date", vios[lcv].rec_date)
		ds_violations.setitem(newrow, "dv_num", maxvios)
		ds_violations.setitem(newrow, "dv_type", 5)
		ds_violations.setitem(newrow, "dv_desc", v_desc)
		if xx > 0 then
			for lcv2 = 1 to xx
				if old[lcv2].vdate = vios[lcv].rec_date and old[lcv2].vdesc = v_desc then
					ds_violations.setitem(newrow, "dv_excused", old[lcv2].ex)
					ds_violations.setitem(newrow, "dv_reason", old[lcv2].reason)
					ds_violations.setitem(newrow, "dv_who_ex", old[lcv2].whoex)
				end if	
			next
		end if
	next
end if


end subroutine

public subroutine setface (integer button);/*
	button = 0 , no driver/all dw's reset/all tags not visible etc.
	button = 1 , clears current log to 1's, clears vios, enables etc., (checks lock also)
	button = 2 , only worries about lockdate
*/

if isnull(cur_driver.em_id) then	button = 0

integer currow
currow = dw_log_list.getselectedrow(0) 
if currow = 0 then button = 0

if button = 1 or button = 2 then 
	if dw_log_list.getitemdate(currow, "dl_date") < lockdate then
		dw_log.enabled = false 
		uo_codriver.enabled = false
		st_lock.visible = true
	else
		dw_log.enabled = true 
		uo_codriver.enabled = true
		st_lock.visible = false
	end if
end if

choose case button 
//-------------------------------------------------------------no driver
case 0
	dw_log_list.setredraw(false)
	dw_log.setredraw(false)
	dw_vios_short.setredraw(false)
	dw_miles.setredraw(false)

	dw_log_list.reset()
	dw_log.reset()
	dw_vios_short.reset()
	dw_miles.reset()

	cur_Driver.em_id = null_long
	cur_Driver.em_ln = ""
	cur_Driver.em_fn = ""

	uo_choose_emp.cur_emp = cur_driver
	uo_choose_emp.temp_emp = cur_driver
	uo_choose_emp.set_emp(true)
	uo_codriver.cur_emp = cur_driver
	uo_codriver.temp_emp = cur_driver
	uo_codriver.set_emp(true)

	dw_miles.insertrow(0)
	dw_miles.setitem(1, "dl_log", "9")
	dw_miles.object.di_lockdate.text = "1/1/90"

	dw_log_list.setredraw(true)
	dw_log.setredraw(true)
	dw_vios_short.setredraw(true)
	dw_miles.setredraw(true)
	st_vios.visible = false
	st_lock.visible = false
	gb_date.text = string(today(), "m/d/yy")
	st_type.text = ""
	st_noprivs.Visible = False
//------------------------------------------------------------------clear and new
case 1
	st_vios.visible = false
	st_lock.visible = false
	dw_log.setredraw(false)
	log_string = fill("1", 96)
	dw_log.setitem(1, "dl_log", log_string)
	cury = 1
	dw_log.modify("st_curpos.text = '" + string(1 * 10 + cury) + "'")
	dw_log.object.di_lockdate.text = string(lockdate, "m/d/yy")
	curx = 1
	st_noprivs.Visible = False
	dw_log.setredraw(True)
end choose

return 

end subroutine

public subroutine dw_losefocus ();if isvalid(dw_vios_daily) then
	if dw_vios_daily.visible = true then 
		dw_vios_daily.accepttext()
		dw_vios_daily.visible = false
	end if
end if
//if getfocus() = uo_codriver.sle_name then 
//	triggerit = true
//	uo_codriver.sle_name.triggerevent(modified!)
//end if 

choose case editmode
	case "insert"
		zz_insert_log()
	case else
		return
end choose
return 
end subroutine

public function integer calc_and_save (ref string failnote);/* return 100 = did not have to update, nothing modified or no driver
	return 99  = user entered data is poor (i.e. no miles entered)
	return -1  = database error, had to rollback
	return 0   = success  */

failnote = ""

if isnull(cur_driver.em_id) then return 100

if g_privs.log[3] = 0 then 
	messagebox("Save Changes", "Your current user privileges do not allow you " +&
	"to edit driver logs.", exclamation!)
	return 0
end if

//	Make sure we have a module lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_module_LogAudit, "S" ) < 0 THEN
	goto failure
END IF

rowsmod()
if indx > 0 then 
	if miler_check() = 99 then return 99
	violations_check()
	sched_check()
	receipt_check()
	set_vios()
elseif indx = 0 then
	return 100
end if

integer lastrow
lastrow = dw_log_list.rowcount()

if left(dw_log_list.getitemstring(lastrow, "dl_log"), 1) = "8" then
	if lastrow = sched_type then
		delete from driver_logs where dl_id = :cur_driver.em_id ;
		if sqlca.sqlcode <> 0 or sqlca.sqlcode <> 100 then 
			rollback ;
			goto failure
		else
			commit ;
			return 0
		end if
	end if
	dw_log_list.deleterow(lastrow)
	if dw_log_list.getselectedrow(0) = 0 then log_to_chart(0, dw_log_list.rowcount())
end if

integer new_intsig
select di_intsig into :new_intsig from driverinfo where di_id = :cur_driver.em_id ;
if sqlca.sqlcode <> 0 then
	rollback ;
	goto failure
else
	commit ;
end if

if new_intsig <> old_intsig then 
	failnote = "The information has already been changed by another user or in " +&
	"another window.  "
	goto failure
else 
	update driverinfo set di_intsig = :old_intsig + 1 where di_id = :cur_driver.em_id ;
	if sqlca.sqlcode <> 0 then
		rollback ; 
		goto failure
	else
		commit ;
	end if
end if

if dw_log_list.modifiedcount() > 0 or dw_log_list.deletedcount() > 0 then  
	if dw_log_list.update(false, false) = -1 then
		rollback ;
		goto failure
	end if
end if

if ds_violations.deletedcount() > 0 or ds_violations.modifiedcount() > 0 then 
	if ds_violations.update(false, false) = -1 then
		rollback ;
		goto failure
	end if
end if 

if ds_receipts.deletedcount() > 0 or ds_receipts.modifiedcount() > 0 then 
	if ds_receipts.update(false, false) = -1 then
		rollback ;
		goto failure
	end if
end if 

commit ;
old_intsig ++
if dw_log_list.getitemstatus(1, 0, primary!) = newmodified! then refresh_jump()

ds_violations.resetupdate()
ds_receipts.resetupdate()
dw_log_list.resetupdate()


return 0

failure:

failnote += "Could not save changes to database."
return -1
end function

public subroutine insert_log (integer selspot);n_cst_LicenseManager	lnv_LicenseManager

integer inrow 
date lastdate

inrow = integer(dw_log_list.object.datawindow.firstrowonpage) + selspot - 1

if inrow < sched_type - 1 then
	messagebox("Insert Omitted Log", "The first log you've entered is " +&
		string(dw_log_list.getitemdate(sched_type, "dl_date"), "m/d/yy") + ".  You may "+&
		"insert a log directly prior to that one, but you cannot insert into the grey "+&
		"area at the top of the list, as you have requested.", exclamation!)
	zz_insert_log()
	return
end if

if dw_log_list.getitemdate(inrow + 1, "dl_date") < lockdate then
	messagebox("Insert Omitted Log", "Cannot insert a log between locked logs.", exclamation!)
	zz_insert_log()
	return
end if 

lastdate = relativedate(dw_log_list.getitemdate(dw_log_list.rowcount(), "dl_date"), 1)
if daysafter(lnv_LicenseManager.of_GetLicenseExpiration ( ), lastdate) > 0 then 
	messagebox("Insert Omitted Log", lnv_LicenseManager.of_GetExpirationNotice ( ) +&
	"Inserting a log would push the last log you've entered past this date.  Your "+&
	"registration must be extended in order to carry out this request.", exclamation!)
	zz_insert_log()
	return
end if

//--------------------------------------------------------------------OK to insert

dw_log_list.setredraw(false)
dw_log.setredraw(false)

date thisdate
thisdate = dw_log_list.getitemdate(inrow, "dl_date")
integer lcv, newrow

for lcv = dw_log_list.rowcount() to 1 step -1
	if dw_log_list.getitemdate(lcv, "dl_date") > thisdate then
		dw_log_list.setitem(lcv, "dl_date", &
			relativedate(dw_log_list.getitemdate(lcv, "dl_date"), 1))
	elseif dw_log_list.getitemdate(lcv, "dl_date") = thisdate then
		newrow = dw_log_list.insertrow(lcv)
		dw_log_list.setitem(newrow, "dl_date", relativedate(thisdate, 1))
		dw_log_list.setitem(newrow, "dl_id", cur_driver.em_id)
		dw_log_list.setitem(newrow, "dl_odtot", 0)
		dw_log_list.setitem(newrow, "dl_drtot", 0)
		dw_log_list.setitem(newrow, "dl_miles", 0)
		dw_log_list.setitem(newrow, "dl_vios", 0)
		dw_log_list.setitem(newrow, "comp_mod", "y")
		dw_log_list.setitem(newrow, "dl_log", fill("1", 96))
	end if
next

if ds_violations.rowcount() > 0 then 
	for lcv = ds_violations.rowcount() to 1 step -1
		if ds_violations.getitemdate(lcv, "dv_date") > thisdate then
			ds_violations.setitem(lcv, "dv_date", &
				relativedate(ds_violations.getitemdate(lcv, "dv_date"), 1))
			ds_violations.setitemstatus(lcv, 0, primary!, newmodified!)
		end if
	next
end if

if ds_receipts.rowcount() > 0 then 
	for lcv = ds_receipts.rowcount() to 1 step -1
		if ds_receipts.getitemdate(lcv, "lr_date") > thisdate then
			ds_receipts.setitem(lcv, "lr_date", &
				relativedate(ds_receipts.getitemdate(lcv, "lr_date"), 1))
			ds_receipts.setitemstatus(lcv, 0, primary!, newmodified!)
		end if
	next
end if


dw_log_list.sort()
ds_violations.sort()
ds_receipts.sort()

for lcv = 1 to 7
	st_inpt[lcv].visible = false
next

inrow ++
editmode = "off"
log_to_chart(0, inrow)
dw_log_list.selectrow(0, false)
dw_log_list.selectrow(inrow, true)

//dw_log_list.setrow(dw_log_list.rowcount())
dw_log_list.scrolltorow(inrow)

dw_log_list.setredraw(true)
dw_log.setredraw(true)

dw_log_list.scrolltorow(inrow)

return
end subroutine

public subroutine log_to_chart (integer oldrow, integer newrow);/* this function copies info from log_list to log_chart.
send it the oldrow and then the newrow.  Send it zero for either if value is n/a 
*/
 
if isnull(cur_driver.em_id) or dw_log_list.rowcount() = 0 then 
	setface(0)
	return
end if
if isnull(oldrow) then oldrow = 0
if isnull(newrow) then newrow = 0 

//----------------------------------------------------------old business

if oldrow <> newrow and oldrow <> 0 then 
	if miler_check() = 99 then
		dw_log_list.scrolltorow(oldrow)
		dw_miles.setfocus()
		return
	end if
end if

//----------------------------------------------------------new business

add_next = false

dw_log_list.selectrow(0, false)
dw_log_list.selectrow(newrow, True)	
dw_log_list.setrow(newrow)
dw_log_list.setcolumn("dl_odtot")

date logdate
logdate = dw_log_list.getitemdate(newrow, "dl_date")
log_string = dw_log_list.getitemstring(newrow, "dl_log")

gb_date.text = string(logdate, "m/d/yy") + " " + dayname(logdate)

long co_id 
integer lcv
co_id = dw_log_list.getitemnumber(newrow, "dl_codriver_id")
if not isnull(co_id) then 
	for lcv = 1 to gds_emp.rowcount()
		if co_id = gds_emp.getitemnumber(lcv, "em_id") then
			uo_codriver.sle_name.text = gds_emp.getitemstring(lcv, "em_ln") + ", " + gds_emp.getitemstring(lcv, "em_fn") 
			uo_codriver.cur_emp.em_id = co_id
			uo_codriver.cur_emp.em_ln = gds_emp.getitemstring(lcv, "em_ln")
			uo_codriver.cur_emp.em_fn = gds_emp.getitemstring(lcv, "em_fn")
			uo_codriver.cur_emp.em_mn = ""
			exit
		end if
	next
else
	uo_codriver.sle_name.text = ""
	uo_codriver.cur_emp.em_id = null_long
end if

setface(2)
dw_log.setredraw(false)
dw_miles.setredraw(false)

dw_log.reset()
dw_miles.reset()
dw_log_list.RowsCopy (newrow, newrow, primary!, dw_log, 99, primary!)
dw_log_list.RowsCopy (newrow, newrow, primary!, dw_miles, 99, primary!)
cury = integer(left(log_string, 1))
dw_log.modify("st_curpos.text = '" + string(1 * 10 + cury) + "'")
curx = 1
dw_log.object.di_lockdate.text = string(lockdate, "m/d/yy")
dw_miles.object.di_lockdate.text = string(lockdate, "m/d/yy")
dw_log.setredraw(true)
dw_miles.setredraw(true)

refresh_shortvios()

return

end subroutine

public subroutine set_choose_emp ();uo_choose_Emp.x = dw_vios_short.x 
uo_codriver.x = dw_vios_short.x

uo_choose_emp.w_mainpar = this
uo_codriver.w_mainpar = this
uo_codriver.uo_num = 2 
uo_codriver.allow_noname = true

if gds_emp.rowcount() > 0 then   
	uo_codriver.ds_hotkey.object.data.primary = gds_emp.object.data.primary
	uo_codriver.ds_hotkey.setfilter("em_status = 'K' and not isnull(di_id)")
	uo_codriver.ds_hotkey.filter()
end if
if ds_drivers.rowcount() > 0 then 
//	Long	i
	
	
	uo_choose_emp.ds_hotkey.object.data.primary = ds_drivers.object.data.primary
end if

if uo_codriver.ds_hotkey.rowcount() = 0 then 
	uo_codriver.hsb_1.Visible = false
end if
if uo_choose_emp.ds_hotkey.rowcount() = 0 then 
	uo_choose_emp.hsb_1.Visible = false
end if

uo_choose_emp.sle_name.setfocus()

uo_choose_emp.cur_emp.em_id = null_long
uo_choose_emp.st_tag1.x = 0
uo_choose_emp.st_tag1.text = "Driver"
uo_choose_emp.sle_name.x = uo_choose_emp.st_tag1.width + 9
uo_choose_emp.sle_name.height = 77
uo_choose_emp.sle_name.width = 723

uo_codriver.cur_emp.em_id = null_long
uo_codriver.st_tag1.x = 0
uo_codriver.st_tag1.text = "Codriver"
uo_codriver.sle_name.x = uo_codriver.st_tag1.width + 9
uo_codriver.sle_name.height = uo_choose_emp.sle_name.height
uo_codriver.sle_name.width = 723


uo_choose_emp.hsb_1.x = uo_choose_emp.sle_name.x + uo_choose_emp.sle_name.width + 9
uo_choose_emp.width = uo_choose_emp.hsb_1.x + uo_choose_emp.hsb_1.width + 5

uo_codriver.hsb_1.x = uo_codriver.sle_name.x + uo_codriver.sle_name.width + 9
uo_codriver.width = uo_choose_emp.width

st_type.x = uo_choose_emp.width + uo_choose_emp.x + 9

st_vios.x = dw_log_list.x + dw_log_list.width / 4 - st_Vios.width / 2
st_lock.x = dw_log_list.x + 3 * dw_log_list.width / 4 - st_Vios.width / 2
st_lock.y = st_vios.y 

dw_log.object.st_tot1.text = ""
dw_log.object.st_tot2.text = ""
dw_log.object.st_tot3.text = ""
dw_log.object.st_tot4.text = ""

return

end subroutine

public subroutine rowsmod ();indx = 0
if isnull(cur_driver.em_id) then return
dw_vios_daily.accepttext()
dw_miles.accepttext()
dw_log_list.accepttext()

if getfocus() = uo_codriver.sle_name then 
	triggerit = true
	uo_codriver.sle_name.triggerevent(modified!)
end if

integer lcv, lcv2, sched_type_mod
integer stop_row, fixlcv
stop_row = dw_log_list.rowcount()
if stop_row = 0 then return
if left(dw_log_list.getitemstring(stop_row, "dl_log"), 1) = "8" then 
	stop_row -= 1
end if
if stop_row = 0 then return

for lcv = start_check_row to stop_row
	if dw_log_list.getitemstring(lcv, "comp_mod") = "y" and lcv <> stop_row then
		if lcv < fixlcv then
			/* row has already been put into array */
			sched_type_mod = sched_type - (fixlcv - lcv)
		else
			fixlcv = lcv
			sched_type_mod = sched_type
		end if
		for lcv2 = 1 to sched_type_mod
			indx ++
			rows_to_check[indx] = fixlcv
			fixlcv ++
			if fixlcv > stop_row then goto outloop
		next
	elseif dw_log_list.getitemstring(lcv, "comp_mod") = "y" and lcv = stop_row then
		indx ++
		rows_to_check[indx] = lcv
	elseif dw_log_list.getitemstring(lcv, "comp_mod") = "o" then
		indx ++
		rows_to_check[indx] = lcv
	end if
next

outloop:
string mbox_inst_loc = ""
integer counter = 0, currow

if indx = 0 and (ds_violations.deletedcount() > 0 or ds_violations.modifiedcount() > 0 or &
	ds_receipts.deletedcount() > 0 or ds_receipts.modifiedcount() > 0 or &
	dw_log_list.deletedcount() > 0 or dw_log_list.modifiedcount() > 0) then 
	indx = -1
	if (ds_violations.deletedcount() = 0 and ds_violations.modifiedcount() = 0 and &
		ds_receipts.deletedcount() = 0 and ds_receipts.modifiedcount() = 0 and &
		dw_log_list.deletedcount() = 0 and dw_log_list.modifiedcount() > 0) then 
		date moddates[]
		integer dindx
		for lcv = 1 to dw_log_list.rowcount()
			if dw_log_list.getitemstatus(lcv, 0, primary!) = datamodified! then
				mbox_inst_loc += string(dw_log_list.getitemdate(lcv, "dl_date"), "m/d/yy") + &
					" - datamod~n"
			elseif dw_log_list.getitemstatus(lcv, 0, primary!) = newmodified! then
				mbox_inst_loc += string(dw_log_list.getitemdate(lcv, "dl_date"), "m/d/yy") + &
					" - newmod~n"
				dindx ++
				moddates[dindx] = dw_log_list.getitemdate(lcv, "dl_date")
			end if
		next 
		if dindx = 1 then
			if moddates[dindx] = dw_log_list.getitemdate(dw_log_list.rowcount(), "dl_date") &
				and stop_row = dw_log_list.rowcount() - 1 then indx = 0
		end if
	end if
elseif indx > 0 then
	if rows_to_check[indx] > dw_log_list.rowcount()	then 
		for lcv = indx to 1 step -1
			counter = 0
			if rows_to_check[lcv] > dw_log_list.rowcount() then 
				indx -= 1
				counter ++
			end if
		next
	end if
	mbox_inst_loc = ""
	for lcv = 1 to indx
		currow = rows_to_check[lcv]
		for lcv2 = 1 to indx
			if currow = rows_to_check[lcv2] and lcv2 <> lcv then
				mbox_inst_loc += string(dw_log_list.getitemdate(currow, "dl_date"), "m/d/yy") + "~n"
			end if
		next
	next
end if

return

end subroutine

public subroutine refresh_shortvios ();if dw_log_list.rowcount() = 0 then return
if dw_log_list.getselectedrow(0) = 0 then return
if isnull(cur_driver.em_id) then return

integer lcv, curval
date curdate

curdate = dw_log_list.getitemdate(dw_log_list.getselectedrow(0), "dl_date")
curval = dw_log_list.getitemnumber(dw_log_list.getselectedrow(0), "dl_vios")

dw_vios_short.setredraw(false)
dw_vios_short.reset()
for lcv = 1 to ds_violations.rowcount()
	if ds_violations.getitemdate(lcv, "dv_date") = curdate then
		ds_violations.rowscopy(lcv, lcv, primary!, dw_vios_short, 999, primary!)
	end if
next

dw_vios_short.sort()
dw_vios_short.setredraw(true)

//This is what Megan had.  It was causing false violations flagging because it doesn't 
//take into account whether the violations are excused, as the other calculations do.
//
//if dw_vios_short.rowcount() > 0 then ... (The lines following are unchanged)

if dw_vios_short.find("dv_excused = 'F'", 1, dw_vios_short.rowcount()) > 0 then
	if st_vios.visible = false then st_vios.visible = true
	if curval <> 1 then dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_vios", 1)
else
	if st_vios.visible = true then st_vios.visible = false
	if curval <> 0 then dw_log_list.setitem(dw_log_list.getselectedrow(0), "dl_vios", 0)
end if

if dw_vios_daily.visible = true then dw_vios_daily.bringtotop = true
	
return

end subroutine

public subroutine set_vios ();if isnull(cur_driver.em_id) then return

integer lcv, lcv2, viosindx = 0, totrows
date date_vios[], date_check
boolean vios 

totrows = dw_log_list.rowcount()
if left(dw_log_list.getitemstring(totrows, "dl_log"), 1) = "8" then totrows -= 1

if ds_violations.rowcount() = 0 then
	for lcv = 1 to totrows
		if dw_log_list.getitemnumber(lcv, "dl_vios") <> 0 then &
			dw_log_list.setitem(lcv, "dl_vios", 0)
		if dw_log_list.getitemstring(lcv, "comp_mod") <> "n" then &
			dw_log_list.setitem(lcv, "comp_mod", "n")
	next
else
	for lcv = 1 to ds_violations.rowcount()
		if ds_violations.getitemstring(lcv, "dv_excused") = "F" then
			viosindx ++
			date_vios[viosindx] = ds_violations.getitemdate(lcv, "dv_date")
		end if
		if isnull(ds_violations.getitemnumber(lcv, "di_sched_type")) then &
			ds_violations.setitem(lcv, "di_sched_type", sched_type)
	next
	for lcv = 1 to totrows
		date_check = dw_log_list.getitemdate(lcv, "dl_date")
		vios = false
		for lcv2 = 1 to viosindx
			if date_check = date_vios[lcv2] then 
				vios = true
				Exit
			end if
		next
		if vios = true and dw_log_list.getitemnumber(lcv, "dl_vios") <> 1 then
			dw_log_list.setitem(lcv, "dl_vios", 1)
		elseif vios = false and dw_log_list.getitemnumber(lcv, "dl_vios") <> 0 then
			dw_log_list.setitem(lcv, "dl_vios", 0)
		end if
		if dw_log_list.getitemstring(lcv, "comp_mod") <> "n" then &
			dw_log_list.setitem(lcv, "comp_mod", "n")
	next
end if

if dw_log_list.getitemnumber(Dw_log_list.getselectedrow(0), "dl_vios") = 1 then 
	st_vios.visible = true
else
	st_vios.visible = false
end if
return

end subroutine

protected subroutine total_hours (boolean oldarg);integer currow 
currow = dw_log_list.getselectedrow(0) 
 
if left(log_string, 1) <> "5" and left(log_string, 1) <> "6" and left(log_string, 1) <> "7" &
	and left(log_string, 1) <> "8" then
	dw_log_list.setitem(currow, "dl_drtot", dw_log.getitemnumber(1, "comp_tot3"))
	dw_log_list.setitem(currow, "dl_odtot", dw_log.getitemnumber(1, "comp_tot3") + &
		dw_log.getitemnumber(1, "comp_tot4") )
end if

dw_log_list.setitem(currow, "dl_log", log_string)
dw_log_list.setitem(currow, "comp_mod", "y")

dw_miles.setredraw(false)

dw_miles.setitem(1, "dl_drtot", dw_log.getitemnumber(1, "comp_tot3"))
dw_miles.setitem(1, "dl_log", log_string)

dw_miles.setredraw(true)

return

end subroutine

public subroutine sched_check ();//Modified 9/19/05 BKW.  Updated to reflect changes to 34 hr restart provision in 10-1-05 Rule Revisions.
//Driver no longer has to be in compliance with 60 or 70 hr rule at the time he starts a 34 hr restart period.

Date		ld_LogDate                         
String	ls_Status, ls_Log                  
String	ls_ViolationDescription, ls_RuleSet

integer num_row[], li_ViosRow, lcv, li_Loop, li_RowLoop      
integer li_DutyTotal, li_Limit, li_TimeOver
integer li_LogRow, li_OldIndex
integer li_NewRow, li_CheckType, li_MaxNum

violations vios[1]                         
oldvios old
boolean lb_LostLog, lb_PrevDay   //It doesn't appear to me that these actually do anything. --BKW

Integer	li_Index, &
			li_ContinuousOffCount
String	ls_Restart
Boolean	lb_Special, &
			lb_DQOnly, &
			lb_OverAtStart, &
			lb_Post100105  /*Flags whether the 10-1-05 Rule Revisions are in effect for the log being checked.*/

li_Limit = (sched_type - 1) * 10 * 4


//This section was added for 34 hour restart provision 1-4-04 BKW, and modified for the 10-1-05 Rules.  
//If the driver has 34 consecutive hours off, his clock resets to 0.  (Prior to 10-1-05, his 34 hr period
//could not begin while he was in violation of the 60 or 70 hr rule.  With the 10-1-05 rules, this requirement
//was waived.)
//This will be flagged by putting a "T" in dl_restart for the date that the restart takes effect (the
//date that the 34 consecutive hours off ENDS on.)  We will loop through and (re)assess any restarts
//first, and then (re)assess and violations.


//On all logs after the lock date and on or after 1-4-04, we provide the ability for the user to check the Restart box 
//saying that a restart has taken effect on that day.  This is because due to air radius and startup logs, 
//where the user can type an OnDuty Total rather than having the system determine it from a log, 
//the system will not always be able to determine if a reset occurred in situation where it did.
//However, if the user checks the reset box in a situation where the system can definitively determine
//that a restart did NOT occur, the system will remove this check (see notes below for exception to this), 
//and in situations where the system can determine that a restart did occur, the system will check the box for the user.


FOR li_Loop = 1 TO indx

	li_LogRow = rows_to_check[li_Loop]
	ld_LogDate = dw_Log_List.GetItemDate ( li_LogRow, "dl_date" )

	//Logs prior to 2004-01-04 are not eligible for restart.  If the log is not eligible, CONTINUE

	IF ld_LogDate < 2004-01-04 THEN
		CONTINUE
	END IF
	
	//Determine whether the log falls on or after 10-1-05, and is eligible for the 10-1-05 Rule Revisions.
	
	IF ld_LogDate >= 2005-10-01 THEN
		lb_Post100105 = TRUE
	ELSE
		lb_Post100105 = FALSE
	END IF

	ls_Log = dw_log_list.getitemstring(li_LogRow, "dl_log")

	//Tally up how much OffDuty/Sleeper time the current log starts with

	li_ContinuousOffCount = 0
	lb_Special = FALSE
	lb_DQOnly = FALSE
	lb_OverAtStart = FALSE

	FOR li_Index = 1 TO 96

		CHOOSE CASE Mid ( ls_Log, li_Index, 1 )

		CASE gc_Logs.cs_Status_OffDuty, gc_Logs.cs_Status_Sleeper

			li_ContinuousOffCount ++

		CASE gc_Logs.cs_Status_Driving, gc_Logs.cs_Status_OnDuty

			EXIT

		CASE gc_Logs.cs_Status_AirRadius, gc_Logs.cs_Status_Startup

			li_DutyTotal = dw_Log_List.GetItemNumber ( li_LogRow, "dl_odtot" ) * 4

			IF li_DutyTotal > 0 THEN

				//Since we can't know when the OnDutyTime happened, we can't say that a reset happened.
				//We could only disqualify a Reset that the user had flagged, by seeing if in the best-case 
				//scenario the reset the user claims could not be valid.  

				lb_DQOnly = TRUE
				li_ContinuousOffCount = 96 - li_DutyTotal  //Assume the OnDuty time is at the end of the day 
					//and the OffDuty time is at the beginning (the best-case scenario for the restart.)
				lb_Special = TRUE

				EXIT

			ELSE

				//Since theres no OnDutyTime, we can safely count the whole day as OffDuty/Sleeper time,
				//and continue the check of the prior logs.

				li_ContinuousOffCount = 96
				EXIT

			END IF

		CASE gc_Logs.cs_Status_Lost, gc_Logs.cs_Status_New

			//We don't know OnDuty time for these logs, so we won't dispute the user's selection, 
			//unless the Restart can be disqualified for some reason.
			lb_DQOnly = TRUE
			li_ContinuousOffCount = 96  //DQOnly mode, take the best case scenario.
			lb_Special = TRUE
			EXIT

		CASE ELSE  //Unexpected value

			EXIT

		END CHOOSE

	NEXT


	//NOTE: The following condition is lifted by the rule revisions 10-01-05.  However, for consistency, we'll still 
	//determine the lb_OverAtStart variable value, but only use it to prevent a restart if lb_Post100105 is FALSE.
	
	//Now that we have a figure for how much OffDuty time at the beginning of the log we're checking will contribute 
	//to a potential restart, we can look back to the log prior or 2 logs prior (to when the 34 hr off duty period would 
	//have had to have started) to see if the driver was over the 60/70 rule going into the potential restart.
	//If he was over (ie, had negative time available), the restart doesn't count, even if he got the 34 hrs off.

	//We should always have at least 3 logs prior, but the li_LogRow checks are just to avoid a potential crash
	//if this assumption did not hold up.

	IF li_ContinuousOffCount <= 40 AND li_LogRow > 3 THEN

		//Since there's 10 hrs or less of OffDuty starting this log, we have to go 2 logs prior.
		//(We have to look at how much time was available going INTO the day 2 logs prior, ie how much
		//was available at the end of the 3rd log prior.)

		IF dw_Log_List.GetItemDecimal ( li_LogRow - 3, "comp_b" /*Hrs Available*/ ) < 0 THEN
			lb_OverAtStart = TRUE
		END IF

	ELSEIF li_ContinuousOffCount > 40 AND li_LogRow > 2 THEN

		IF dw_Log_List.GetItemDecimal ( li_LogRow - 2, "comp_b" /*Hrs Available*/ ) < 0 THEN
			lb_OverAtStart = TRUE
		END IF

	END IF


	IF li_ContinuousOffCount > 0 AND li_LogRow > 2 AND ( lb_OverAtStart = FALSE OR lb_Post100105 = TRUE ) THEN

		//Audit the prior log or two logs to see if we qualify for a restart
		//We should always have at least 2 logs prior, but the check is to avoid a potential crash.

		ls_Log = dw_Log_List.GetItemString ( li_LogRow - 2, "dl_log" )
		ls_Log += dw_Log_List.GetItemString ( li_LogRow - 1, "dl_log" )			

		FOR li_Index = 192 TO 1 STEP -1

			CHOOSE CASE Mid ( ls_Log, li_Index, 1 )

			CASE gc_Logs.cs_Status_OffDuty, gc_Logs.cs_Status_Sleeper

				li_ContinuousOffCount ++

			CASE gc_Logs.cs_Status_Driving, gc_Logs.cs_Status_OnDuty

				EXIT

			CASE gc_Logs.cs_Status_AirRadius, gc_Logs.cs_Status_Startup

				IF li_Index > 96 THEN  //We're in the 2nd log in ls_Log, the one just prior to the one we're checking for a restart

					li_DutyTotal = dw_Log_List.GetItemNumber ( li_LogRow - 1, "dl_odtot" ) * 4

					IF li_DutyTotal = 0 THEN

						//Count the whole day as OffDuty and continue the check.
						li_ContinuousOffCount += 96
						li_Index = 97  //Now that we've counted the time, reduce li_Index to skip over this log.

					ELSEIF li_ContinuousOffCount + ( 96 - li_DutyTotal ) >= 136 THEN

						lb_DQOnly = TRUE
						li_ContinuousOffCount += ( 96 - li_DutyTotal )

						//The scenario is potentially a reset.  Use the users value.
						lb_Special = TRUE
						EXIT

					ELSE

						//The scenario is not potentially a reset.  Disqualify a user reset value.
						EXIT

					END IF

				ELSE  //We're in the first log in ls_Log, the one 2 prior to the one we're checking for a restart

					li_DutyTotal = dw_Log_List.GetItemNumber ( li_LogRow - 2, "dl_odtot" ) * 4

					IF li_DutyTotal = 0 THEN

						li_ContinuousOffCount += 96
						li_Index = 1  //Now that we've counted the time, reduce li_Index to skip over this log.

					ELSEIF li_ContinuousOffCount + ( 96 - li_DutyTotal ) >= 136 THEN

						//The scenario is potentially a reset.  Use the users value.

						lb_DQOnly = TRUE
						li_ContinuousOffCount += ( 96 - li_DutyTotal )

						lb_Special = TRUE
						EXIT

					ELSE

						//The scenario is not potentially a reset.  Disqualify a user reset value.
						EXIT

					END IF

				END IF


			CASE gc_Logs.cs_Status_Lost, gc_Logs.cs_Status_New

				lb_DQOnly = TRUE
				li_ContinuousOffCount += 96  //Treat this as best-case scenario, all off duty
				li_Index -= 95  //The 96th will be subtracted by NEXT
				lb_Special = TRUE

			CASE ELSE  //Unexpected value.

				EXIT

			END CHOOSE

		NEXT

	ELSE

		//With this log starting with something other than OffDuty/Sleeper time, it cannot qualify for a restart
		//(If the previous log was 24 hrs off and this one starts w. OnDuty or Driving, the previous day may have
		//qualified for a restart, but this one doesn't.

		//We'll override the user's choice, if they made one.

		//ls_Restart = "F"   Don't need to set this, it will be set below.

	END IF


	IF li_ContinuousOffCount >= 136 AND ( lb_OverAtStart = FALSE OR lb_Post100105 = TRUE ) THEN  //34hrs * 4 intervals / hr = 136 intervals

		IF lb_DQOnly = TRUE THEN

			//User is in control of whether the log is flagged.  Scrub a null value to "F"
	
			ls_Restart = dw_Log_List.GetItemString ( li_LogRow, "dl_restart" )
	
			IF IsNull ( ls_Restart ) THEN
				ls_Restart = "F"
			END IF

		ELSE

			//We've determined there is a valid restart.  Set it, regardless of what the user did.
			ls_Restart = "T"

		END IF


	ELSE

		//If we were in lb_DQOnly = TRUE mode, we've DQ'd it.  
		//If we were in normal mode, we've determined that no restart happened.

		ls_Restart = "F"

	END IF


	//Record the value we've determined onto the datawindow.
	dw_Log_List.SetItem ( li_LogRow, "dl_restart", ls_Restart )

NEXT


//********************************** BIG LOOP FOR ALL ROWS MODIFIED ********************
for li_Loop = 1 to indx 
	li_LogRow = rows_to_check[li_Loop]
	ld_LogDate = dw_log_list.getitemdate(li_LogRow, "dl_date")
	ls_Log = dw_log_list.getitemstring(li_LogRow, "dl_log")
	li_DutyTotal = 0
	if li_LogRow < sched_type then

		//Bug Fix by BKW for 12/25/03 to accompany new HOS regs.
		//Modified 2/5/04 3.8 BKW to add Restart provision.

		for li_RowLoop = 1 to li_LogRow

			IF dw_Log_List.GetItemString ( li_RowLoop, "dl_restart" ) = "T" THEN
				li_DutyTotal = 0
			END IF
			
			li_DutyTotal += dw_log_list.getitemnumber(li_RowLoop, "dl_odtot") * 4

		next

//		This was Megan's old code.  Any decimals in dl_odtot would have been rounded.
//		for li_RowLoop = 1 to li_LogRow
//			li_DutyTotal += dw_log_list.getitemnumber(li_RowLoop, "dl_odtot")
//		next
//		li_DutyTotal = li_DutyTotal * 4

	else
		
		//If the log we're on has a restart, use DutyTotal zero, otherwise take the 
		//duty total for the last 6 or last 7 (depending on sched_type) in "comp_a"
		//**FROM THE PREVIOUS ROW** (which will reflect any PRIOR restarts)
		
		//Note : The check of the restart condition here was omitted in the initial 3.7 version, effectively 
		//causing the restart to be ignored until the following day, which would result in Duty violations
		//being reported on the day of the restart where they should not have been.  Fixed 2/5/04 3.8 BKW
		
		IF dw_Log_List.GetItemString ( li_LogRow, "dl_restart" ) = "T" THEN
			li_DutyTotal = 0
		ELSE
			li_DutyTotal = (dw_log_list.getitemnumber(li_LogRow - 1, "comp_a")) * 4
		END IF

	end if
	
	li_TimeOver = 0
	li_OldIndex = 0
	lb_LostLog = false
	lb_PrevDay = false
	
	if li_DutyTotal >= 10 * (sched_type - 1) then lb_PrevDay = true
	
	//--------------------------------------------------------------finding info on first day
	for lcv = 1 to 96 
		ls_Status =	mid(ls_Log, lcv, 1)
		if ls_Status = "3" then
			li_DutyTotal ++
			if li_DutyTotal > li_Limit then li_TimeOver ++
		elseif ls_Status = "4" then
			li_DutyTotal ++
		elseif ls_Status = "5" then
			li_DutyTotal = 0
			lb_LostLog = true
	//		if li_DutyTotal >= li_Limit then 
	//			li_TimeOver = 0
	//			lb_LostLog = true
	//		end if
	//--------------------------------------------------where to add hours for lost logs in future
			exit
		elseif ls_Status = "6" then  //Air Radius
			
			//This is Megan's code and I'm not entirely sure I understand the thinking.
			//What she's doing is that if the amount we're over is more than the amount we worked today,
			//then just make the amount we're over equal the time we worked today.
			//There may be a perfectly good reason, just not sure offhand what it is.
			
			li_DutyTotal += 4 * (dw_log_list.getitemnumber(li_LogRow, "dl_odtot"))
			if li_DutyTotal > li_Limit AND dw_log_list.getitemnumber(li_LogRow, "dl_odtot") > 0 then 
				li_TimeOver = li_DutyTotal - li_Limit
				if li_TimeOver > 4 * dw_log_list.getitemnumber(li_LogRow, "dl_odtot") then &
					li_TimeOver = 4 * dw_log_list.getitemnumber(li_LogRow, "dl_odtot")
			end if
			exit
		end if
	next 
	
	if li_TimeOver > 0 then
		vios[1].the_date = ld_LogDate
		vios[1].the_id = cur_driver.em_id
		vios[1].howbad = li_TimeOver   
		vios[1].the_time = 0
		vios[1].limit = 0
		vios[1].the_type = 3 
	end if
	
	// ---------------------------------------------------------------Finding Old
	li_MaxNum = 0
	if ds_violations.rowcount() > 0 then 
		for li_ViosRow = ds_violations.rowcount() to vios_row step -1
			if ds_violations.getitemdate(li_ViosRow, "dv_date") <> ld_LogDate then continue
			li_CheckType = ds_violations.getitemnumber(li_ViosRow, "dv_type")
			if li_CheckType = 3 then
				if ds_violations.getitemstring(li_ViosRow, "dv_excused") = "T" or &
					len(trim(ds_violations.getitemstring(li_ViosRow, "dv_reason"))) > 0 then
					li_OldIndex ++
					old.vdesc = ds_violations.getitemstring(li_ViosRow, "dv_desc")
					old.reason = ds_violations.getitemstring(li_ViosRow, "dv_reason")
					old.ex = ds_violations.getitemstring(li_ViosRow, "dv_excused")
					old.whoex = ds_violations.getitemstring(li_ViosRow, "dv_who_ex")
				end if 
				ds_violations.deleterow(li_ViosRow)				
			else
				li_MaxNum = max(ds_violations.getitemnumber(li_ViosRow, "dv_num"), li_MaxNum)
			end if
		next
	end if
	li_MaxNum ++
	
	if li_TimeOver > 0 then 
		//---------------------------------------------------------------- Description Setup
		if sched_type = 8 then
			ls_RuleSet = " 70 hour / 8 day limit"
		else
			ls_RuleSet = " 60 hour / 7 day limit"
		end if
		
		if vios[1].howbad = 4 then 
			ls_ViolationDescription = "Driver violated" + ls_RuleSet + ".  The driver exceeded the limit by " +&
			string(vios[1].howbad / 4.0, "0.00") + " hour."
		else
			ls_ViolationDescription = "Driver violated" + ls_RuleSet + ".  The driver exceeded the limit by " +&
			string(vios[1].howbad / 4.0, "0.00") + " hours."
		end if
	
		if lb_LostLog = true then
			ls_ViolationDescription += ""
		end if
		
		// --------------------------------------------------------Placing Violation in DS
		li_NewRow = ds_violations.insertrow(0)
		ds_violations.setitem(li_NewRow, "dv_id", cur_driver.em_id)
		ds_violations.setitem(li_NewRow, "dv_date", ld_LogDate)
		ds_violations.setitem(li_NewRow, "dv_num", li_MaxNum)
		ds_violations.setitem(li_NewRow, "dv_type", 3)
		ds_violations.setitem(li_NewRow, "dv_desc", ls_ViolationDescription)
	
		//------------------------------------ Reinstating Comment or Excused Value
		if li_OldIndex > 0 then 
			if old.vdesc = ls_ViolationDescription then
				ds_violations.setitem(li_NewRow, "dv_excused", old.ex)
				ds_violations.setitem(li_NewRow, "dv_reason", old.reason)
				ds_violations.setitem(li_NewRow, "dv_who_ex", old.whoex)
			end if
		end if
		//-----------------------------------------------------------End of Insert Section
	end if
next 
return 
end subroutine

public subroutine violations_check ();Long		ll_DriverId
ll_DriverId = cur_driver.em_id

Date		ld_LogDate												// date of each log in question

String	ls_CurrentLog, ls_PriorLog							// "96's" char long log strings
String	ls_Status, ls_PriorStatus							// single chars for each log status
String	ls_Violation, ls_V1, ls_V2, ls_V3, ls_V4

Integer	li_Loop1, li_Loop2, li_Row, li_OuterLoop		// loop control vars
Integer	li_Driving, li_OnDuty, li_ConsecutiveRest, li_ConsecutiveSleeper							
Integer	li_DrivingViolationStart, li_OnDutyViolationStart, li_DrivingLimitReached, li_OnDutyLimitReached
Integer	li_CheckType, li_MaxViolation, li_Starter, li_DrivingViolationLength, li_OnDutyViolationLength
Integer	li_DrivingStart, li_OnDutyStart
Integer	li_SleeperIndex, li_SleeperTotal[], li_SleeperEndpoint[]
Decimal	lc_OnDutyTotal

Boolean	lb_LostOr100, lb_LostLog = FALSE 
Boolean	lb_InViolation_OnDuty, lb_InViolation_Driving            
Boolean	lb_PreviousDayLimit, lb_PreviousDayStart, lb_SameTime

Time		lt_FixerStart
String	ls_LimitReached, ls_ViolationLength, ls_ViolationStart, ls_ViolationTimeLabel

violations	lstra_Violations[]											// violation information
oldvios		lstra_OldViolations[]
Integer		li_SetIndex, li_ViolationIndex, li_NewRow
lt_FixerStart =  relativetime(00:00:00, start_time * 3600)

//NEW VARIABLES IN 3.7.00, to support new DOT regulations effective 1/4/04
Integer	li_DrivingLimitHours, li_DrivingLimit, li_OnDutyLimitHours, li_OnDutyLimit, &
			li_OffDutyPeriod, li_SleeperPeriod, li_AirRadiusHoursLimit
Boolean	lb_NewRulesProcessingNeeded = FALSE
Date		ld_NewRulesProcessingStartDate

Integer	li_ViosMoveRowCount, &
			li_ViosMoveFilteredCount, &
			li_ViosMoveFirstNewHOSRow, &
			li_ViosMovedCount
Boolean	lb_ViosMovedToFilter

SetNull ( lb_ViosMovedToFilter )   //Null until first pass through, where it will be set either True or False

//-----------------------------------------------------------------------Outside loop
for li_OuterLoop = 1 to indx

	li_Row = rows_to_check[li_OuterLoop]
	ls_CurrentLog = dw_log_list.getitemstring(li_Row, "dl_log")
	ld_LogDate = dw_log_list.getitemdate(li_Row, "dl_date")
	
	ls_PriorLog = dw_log_list.getitemstring(li_Row - 1, "dl_log")
	
	
	//Set the values for allowed & required intervals, based on the DOT regulations.
	//A change in the DOT limits takes effect on 1/4/04
	//Hrs are multiplied by 4 to give the # of 15-min intervals, for easy comparisons later.
	
	IF DaysAfter ( 2004-01-04, ld_LogDate ) >= 0 THEN
		li_DrivingLimitHours = 11		//11 hrs
		li_OnDutyLimitHours = 14		//14 hrs CONSECUTIVE FROM START OF ON DUTY PERIOD  (used to be CUMULATIVE)
		li_OffDutyPeriod = 10 * 4		//10 hrs -- can be mix of Off Duty and Sleeper, must be consecutive
		li_SleeperPeriod = 10 * 4		//10 hrs -- sleeper only, 2 periods of at least 2 hrs each totaling 10 hrs
		li_AirRadiusHoursLimit = 12	//12 hrs

		/*CHANGE OF LOGIC FLOW FOR NEW HOS RULES  11-21-03  BKW  EXIT THE LOOP AND HANDLE THIS DATE FORWARD WITH NEW LOGIC*/

		lb_NewRulesProcessingNeeded = TRUE
		ld_NewRulesProcessingStartDate = ld_LogDate
		EXIT

		/*END CHANGE OF LOGIC FLOW*/

	ELSE
		li_DrivingLimitHours = 10		//10 hrs
		li_OnDutyLimitHours = 15		//15 hrs CUMULATIVE FROM START OF ON DUTY PERIOD
		li_OffDutyPeriod = 8 * 4		// 8 hrs -- can be mix of Off Duty and Sleeper, must be consecutive
		li_SleeperPeriod = 8 * 4		// 8 hrs -- sleeper only, 2 periods of at least 2 hrs each totaling 8 hrs
		li_AirRadiusHoursLimit = 12	//12 hrs
	END IF
	
	li_DrivingLimit = li_DrivingLimitHours * 4	//Get the # of 15-min intervals for the # of hours
	li_OnDutyLimit = li_OnDutyLimitHours * 4		//Get the # of 15-min intervals for the # of hours
	
	// -----------------------------------------------------------------------re-zeroing
	li_Driving = 0
	li_OnDuty = 0
	li_ConsecutiveRest = 0
	li_ConsecutiveSleeper = 0
	li_ViolationIndex = 0
	lb_LostLog = FALSE
	lb_LostOr100 = FALSE //the other lb_LostOr100 variable for violation stuff on current not yesterday
	lb_InViolation_OnDuty = FALSE
	lb_InViolation_Driving = FALSE
	li_Starter = 2
	li_OnDutyViolationStart = 0
	li_DrivingViolationStart = 0
	li_DrivingStart = 0
	li_OnDutyStart = 0
	li_SetIndex = 0
	li_SleeperIndex = 0
	li_DrivingViolationLength = 0
	li_OnDutyViolationLength = 0
	li_OnDutyLimitReached = 0
	li_DrivingLimitReached = 0
	
	ls_CurrentLog = ls_PriorLog + ls_CurrentLog
	
	//------------------------------------------------------------------Info on Previous Day
	 
	ls_PriorStatus = mid(ls_CurrentLog, 1, 1) 
	
	if ls_PriorStatus = "1" then
		li_ConsecutiveRest ++
	elseif ls_PriorStatus = "2" then 
		li_ConsecutiveSleeper ++
		li_ConsecutiveRest ++
	elseif ls_PriorStatus = "3" then
		li_DrivingStart = 1
		li_OnDutyStart = 1
		li_Driving ++
		li_OnDuty ++
	elseif ls_PriorStatus = "4" then
		li_OnDutyStart = 1
		li_OnDuty ++
	elseif ls_PriorStatus = "5" then
		lb_LostLog = TRUE
		li_Starter = 97
		ls_PriorStatus = "1"
	elseif ls_PriorStatus = "7" or ls_PriorStatus = "8" or ls_PriorStatus = "6" then 
		li_Starter = 97
		ls_PriorStatus = "1"
	end if
	
	goto start_pt
	
	//-----------------------------------------------------------------Rezero for restart
	
	start_loop:
	
	if lb_InViolation_Driving = TRUE and li_DrivingStart < li_Starter then 
		
		li_ViolationIndex ++
	
		lstra_Violations[li_ViolationIndex].the_num = li_ViolationIndex
		lstra_Violations[li_ViolationIndex].the_date = ld_LogDate
		lstra_Violations[li_ViolationIndex].the_id = ll_DriverId
		lstra_Violations[li_ViolationIndex].howbad = li_DrivingViolationLength
		lstra_Violations[li_ViolationIndex].the_time = li_DrivingViolationStart
		lstra_Violations[li_ViolationIndex].the_type = 1
		lstra_Violations[li_ViolationIndex].limit = li_DrivingLimitReached
	
		lb_InViolation_Driving = FALSE
		//li_DrivingViolationStart = 0	
		li_DrivingViolationLength = 0		
		li_DrivingStart = 0
	
	elseif lb_InViolation_Driving = TRUE then
	
		lb_InViolation_Driving = FALSE
		li_DrivingStart = 0
	
	end if
	
	
	if lb_InViolation_OnDuty = TRUE and li_OnDutyStart < li_Starter then
	
		li_ViolationIndex ++
	
		lstra_Violations[li_ViolationIndex].the_num = li_ViolationIndex
		lstra_Violations[li_ViolationIndex].the_date = ld_LogDate
		lstra_Violations[li_ViolationIndex].the_id = ll_DriverId
		lstra_Violations[li_ViolationIndex].howbad = li_OnDutyViolationLength
		lstra_Violations[li_ViolationIndex].the_time = li_OnDutyViolationStart
		lstra_Violations[li_ViolationIndex].the_type = 2
		lstra_Violations[li_ViolationIndex].limit = li_OnDutyLimitReached
		
		lb_InViolation_OnDuty = FALSE
		//li_OnDutyViolationStart = 0	
		li_OnDutyViolationLength = 0		
		li_OnDutyStart = 0
		
	elseif lb_InViolation_OnDuty = TRUE then
		
		li_OnDutyStart = 0
		lb_InViolation_OnDuty = FALSE
		
	end if
	
	//li_Driving = 0
	//li_OnDuty = 0
	//li_ConsecutiveRest = 0
	//li_ConsecutiveSleeper = 0
	
	
	//-----------------------------------------------------------------Start of Violations Loop
	
	start_pt:
	
	for li_Loop1 = li_Starter to 192  //192=24*4*2 : 2 days' worth of intervals
	
		ls_Status =	Mid ( ls_CurrentLog, li_Loop1, 1 )
	
		if ls_Status = "5" and li_Loop1 = 97 then   //97=24*4+1 : the first interval of the 2nd day
			
			lb_LostOr100 = TRUE
			li_ViolationIndex = 1
			lstra_Violations[li_ViolationIndex].the_num = li_ViolationIndex
			lstra_Violations[li_ViolationIndex].the_date = ld_LogDate
			lstra_Violations[li_ViolationIndex].the_id = ll_DriverId
			lstra_Violations[li_ViolationIndex].the_type = 7 
			
			goto set_violations
			
		elseif ls_Status = "6" and li_Loop1 = 97 then  //97=24*4+1 : the first interval of the 2nd day
			
			lb_LostOr100 = TRUE
			lc_OnDutyTotal = dw_log_list.getitemnumber(li_Row, "dl_odtot")
			
			if lc_OnDutyTotal > li_AirRadiusHoursLimit then
				
				li_ViolationIndex = 1
				
				lstra_Violations[li_ViolationIndex].the_num = li_ViolationIndex
				lstra_Violations[li_ViolationIndex].the_date = ld_LogDate
				lstra_Violations[li_ViolationIndex].the_id = ll_DriverId
				lstra_Violations[li_ViolationIndex].the_type = 8 
				
			end if
			
			goto set_violations
			
		end if
		
	
		/*********************************************************** part 1:  if status is same */
		
		if ls_PriorStatus = ls_Status or (ls_PriorStatus = "1" and ls_Status = "2") then
	
			if ls_Status = "1" or ls_Status = "2" then
				
				li_ConsecutiveRest ++
				if ls_Status = "2" then li_ConsecutiveSleeper ++
	
			elseif ls_Status = "3" then		
				
				if li_OnDuty >= li_OnDutyLimit and lb_InViolation_OnDuty = FALSE then 
					
					lb_InViolation_OnDuty = TRUE
					li_OnDutyViolationLength = 1
					li_OnDutyViolationStart = li_Loop1
					
				elseif lb_InViolation_OnDuty = TRUE then
					
					li_OnDutyViolationLength ++	
					
				end if
				
				li_Driving ++
				li_OnDuty ++
				
				if li_OnDuty = li_OnDutyLimit then li_OnDutyLimitReached = li_Loop1
				if li_Driving = li_DrivingLimit then li_DrivingLimitReached = li_Loop1
		
				if li_Driving > li_DrivingLimit and lb_InViolation_Driving = FALSE then
					
					li_DrivingViolationStart = li_Loop1
					li_DrivingViolationLength = 1
					lb_InViolation_Driving = TRUE
					
				elseif lb_InViolation_Driving = TRUE then
					
					li_DrivingViolationLength ++
					
				end if
				
			else
				
				li_OnDuty ++
				
				if li_OnDuty = li_OnDutyLimit then
					li_OnDutyLimitReached = li_Loop1
				end if
				
			end if 
			
		/**************************************************** Part 2:  ls_PriorStatus is 2 (ending sb) */
	
		elseif ls_PriorStatus = "2" then
			
			if ls_Status = "1" then
				li_ConsecutiveRest ++
			end if
			
			if li_ConsecutiveSleeper >= li_SleeperPeriod or li_ConsecutiveRest >= li_OffDutyPeriod then 
				
				li_SleeperIndex = 0
				li_ConsecutiveSleeper = 0
				li_Starter = li_Loop1 + 1
				ls_PriorStatus = ls_Status
				
				if ls_Status = "3" then 
					
					li_Driving = 1
					li_OnDuty = 1
					li_OnDutyStart = li_Loop1 
					li_DrivingStart = li_Loop1
					
				elseif ls_Status = "4" then 
					
					li_Driving = 0
					li_OnDuty = 1
					li_OnDutyStart = li_Loop1
					li_DrivingStart = 0
					
				else //ls_Status = 1
					
					li_Driving = 0
					li_OnDuty = 0
					li_OnDutyStart = 0
					li_DrivingStart = 0
					
				end if
				
				goto start_loop
				
			elseif li_ConsecutiveSleeper >= 8 then 
				
				if li_SleeperIndex > 0 then 
					
					for li_Loop2 = li_SleeperIndex to 1 step -1
						
						if li_ConsecutiveSleeper + li_SleeperTotal[li_Loop2] >= li_SleeperPeriod then  
							
							if li_Starter >= li_SleeperEndpoint[li_Loop2] then 
								continue
							end if
							
							li_Starter = li_SleeperEndpoint[li_Loop2]
							ls_PriorStatus = "1"  //arbitrary
							li_ConsecutiveRest = 0
							li_Driving = 0
							li_OnDuty = 0
							
							goto start_loop
							
						end if
						
					next	
					
				end if
				
				li_SleeperIndex ++
				li_SleeperTotal[li_SleeperIndex] = li_ConsecutiveSleeper
				li_SleeperEndpoint[li_SleeperIndex] = li_Loop1
				
			end if
			
			li_ConsecutiveSleeper = 0
			
			if ls_Status <> "1" then li_ConsecutiveRest = 0
			
			if ls_Status = "3" then
				
				if li_OnDuty >= li_OnDutyLimit and lb_InViolation_OnDuty = FALSE then 
					
					lb_InViolation_OnDuty = TRUE
					li_OnDutyViolationLength = 1
					li_OnDutyViolationStart = li_Loop1
					
				elseif lb_InViolation_OnDuty = TRUE then
					
					li_OnDutyViolationLength ++	
					
				end if
		
				li_Driving ++
				li_OnDuty ++
				
				if li_DrivingStart = 0 then li_DrivingStart = li_Loop1
				if li_OnDutyStart = 0 then li_OnDutyStart = li_Loop1
		
				if li_OnDuty  = li_OnDutyLimit then li_OnDutyLimitReached = li_Loop1
				if li_Driving  = li_DrivingLimit then li_DrivingLimitReached = li_Loop1
				
				if li_Driving  > li_DrivingLimit and lb_InViolation_Driving = FALSE then
					
					li_DrivingViolationStart = li_Loop1	
					li_DrivingViolationLength = 1
					lb_InViolation_Driving = TRUE
					
				elseif lb_InViolation_Driving = TRUE then
					
					li_DrivingViolationLength ++
					
				end if
				
			elseif ls_Status = "4" then   /** ls_Status is 4 **/
				
				li_OnDuty ++
				
				if li_OnDuty = li_OnDutyLimit then li_OnDutyLimitReached = li_Loop1
				if li_OnDutyStart = 0 then li_OnDutyStart = li_Loop1
				
			end if
			
		/**************************************Part 3: switching away from driving to something else*/
		
		elseif ls_PriorStatus = "3" then  
			
			if ls_Status = "4" then
				
				li_OnDuty ++
				
				if li_OnDutyStart = 0 then li_OnDutyStart = li_Loop1
				if li_OnDuty = li_OnDutyLimit then li_OnDutyLimitReached = li_Loop1
				
			elseif ls_Status = "1" then /* sb exception taken care of when ls_Status changed away from sb */
				
				li_ConsecutiveRest = 1                        /* but not if driver didn't start on sb*/
				
			elseif ls_Status = "2" then
				
				li_ConsecutiveRest = 1
				li_ConsecutiveSleeper = 1
				
			end if
			
		/* &&&&&&&&&&&&&&&&&&&&&&&&&&& part: 4 new ls_Status is driving except if ls_PriorStatus is sb*/
		//                                                           (that's in part 2)       */
		elseif ls_Status = "3" then
			
			if li_ConsecutiveRest >= li_OffDutyPeriod then 
				
				li_ConsecutiveRest = 0 //newline
				li_SleeperIndex = 0
				ls_PriorStatus = "3"
				li_Driving = 1 
				li_OnDuty = 1
				li_Starter = li_Loop1 + 1
				li_DrivingStart = li_Loop1
				li_OnDutyStart = li_Loop1
				
				goto start_loop
				
			end if
			
			li_ConsecutiveRest = 0
			
			if li_OnDuty >= li_OnDutyLimit and lb_InViolation_OnDuty = FALSE then 
				lb_InViolation_OnDuty = TRUE
				li_OnDutyViolationLength = 1
				li_OnDutyViolationStart = li_Loop1
			elseif lb_InViolation_OnDuty = TRUE then
				li_OnDutyViolationLength ++	
			end if
			
			li_Driving ++
			li_OnDuty ++
			
			if li_DrivingStart = 0 then li_DrivingStart = li_Loop1
			if li_OnDutyStart = 0 then li_OnDutyStart = li_Loop1
			if li_OnDuty = li_OnDutyLimit then li_OnDutyLimitReached = li_Loop1
			if li_Driving = li_DrivingLimit then li_DrivingLimitReached = li_Loop1
			
			if li_Driving > li_DrivingLimit and lb_InViolation_Driving = FALSE then
				li_DrivingViolationStart = li_Loop1
				li_DrivingViolationLength = 1
				lb_InViolation_Driving = TRUE
			elseif lb_InViolation_Driving = TRUE then
				li_DrivingViolationLength ++
			end if
			
		//****************************************** part 5:  ls_PriorStatus is 4, new is 1 or 2 //
		
		elseif ls_PriorStatus = "4" then
			
			if ls_Status = "1" then
				li_ConsecutiveRest = 1
			elseif ls_Status = "2" then 
				li_ConsecutiveRest = 1
				li_ConsecutiveSleeper = 1
			end if
			
		//****************************************** part 6:  ls_PriorStatus is 1, ls_Status is 4//
		
		else 
			
			if li_ConsecutiveRest >= li_OffDutyPeriod then 
				
				li_SleeperIndex = 0
				li_ConsecutiveRest = 0 //newline
				li_Starter = li_Loop1 + 1
				ls_PriorStatus = "4"
				li_OnDuty = 1
				li_Driving = 0
				li_DrivingStart = 0
				li_OnDutyStart = li_Loop1
				
				goto start_loop
				
			end if
			
			li_OnDuty ++	
			
			if li_OnDutyStart = 0 then li_OnDutyStart = li_Loop1
			if li_OnDuty = li_OnDutyLimit then li_OnDutyLimitReached = li_Loop1
			
		end if
		
		ls_PriorStatus = ls_Status
		
	next 
	
	//----------------------------------------------------------End of log string loop
	
	if lb_InViolation_Driving = TRUE then
		
		li_ViolationIndex ++
		
		lstra_Violations[li_ViolationIndex].the_num = li_ViolationIndex
		lstra_Violations[li_ViolationIndex].the_date = ld_LogDate
		lstra_Violations[li_ViolationIndex].the_id = ll_DriverId
		lstra_Violations[li_ViolationIndex].howbad = li_DrivingViolationLength
		lstra_Violations[li_ViolationIndex].the_time = li_DrivingViolationStart
		lstra_Violations[li_ViolationIndex].the_type = 1
		lstra_Violations[li_ViolationIndex].limit = li_DrivingLimitReached
		
	end if
	
	if lb_InViolation_OnDuty = TRUE then
		
		li_ViolationIndex ++
		
		lstra_Violations[li_ViolationIndex].the_num = li_ViolationIndex
		lstra_Violations[li_ViolationIndex].the_date = ld_LogDate
		lstra_Violations[li_ViolationIndex].the_id = ll_DriverId
		lstra_Violations[li_ViolationIndex].howbad = li_OnDutyViolationLength
		lstra_Violations[li_ViolationIndex].the_time = li_OnDutyViolationStart
		lstra_Violations[li_ViolationIndex].the_type = 2
		lstra_Violations[li_ViolationIndex].limit = li_OnDutyLimitReached
		
	end if
	
	set_violations: 

	//	Logic added for New HOS Rules 11-21-03  BKW  
	//	The old logic deletes rows and then adds new ones to the end of the datastore with InsertRow(0)
	//	Rather than try to change the way this is working, I'm just going to temporarily move any violations
	//	for 1/1/04 and beyond into the filter, and then move them back when this is done, and then go on to
	//	the post 1/1/04 processing.

	IF IsNull ( lb_ViosMovedToFilter ) THEN  //First time through, has not been checked yet.

		li_ViosMoveRowCount = ds_Violations.RowCount ( )
		li_ViosMoveFilteredCount = ds_Violations.FilteredCount ( )   //I think this will be 0, but j.i.c.
		li_ViosMoveFirstNewHOSRow = ds_Violations.Find ( "dv_date >= 2004-01-04", 1, li_ViosMoveRowCount )
	
		IF li_ViosMoveFirstNewHOSRow > 0 THEN
	
			//Mod Status will be retained because moving within same datastore.
			ds_Violations.RowsMove ( li_ViosMoveFirstNewHOSRow, li_ViosMoveRowCount, Primary!, &
				ds_Violations, li_ViosMoveFilteredCount + 1, Filter! )  //Move to the end of the filter buffer
	
			lb_ViosMovedToFilter = TRUE
			li_ViosMovedCount = ( li_ViosMoveRowCount - li_ViosMoveFirstNewHOSRow ) + 1

		ELSE

			lb_ViosMovedToFilter = FALSE   //Change from null so we don't have to check again.
	
		END IF

	END IF

	//	End of logic added for New HOS rules.


	// ------------------------------------------------------------------Removing Old Violations
	li_NewRow = ds_violations.rowcount()
	li_MaxViolation = 0
	
	if li_NewRow > 0 then
		
		for li_Loop1 = li_NewRow to vios_row step -1	
			
			if ds_violations.getitemdate(li_Loop1, "dv_date") <> ld_LogDate then CONTINUE  //goto next_one
			if ds_violations.getitemdate(li_Loop1, "dv_date") < lockdate then CONTINUE     //goto next_one
			
			li_CheckType = ds_violations.getitemnumber(li_Loop1, "dv_type")
			
			if li_CheckType = 1 or li_CheckType = 2 or li_CheckType = 7 or li_CheckType = 8 then
				
				if ds_violations.getitemstring(li_Loop1, "dv_excused") = "T" or &
					len(trim(ds_violations.getitemstring(li_Loop1, "dv_reason"))) > 0 then
				 
					li_SetIndex ++
					
					lstra_OldViolations[li_SetIndex].vdesc = ds_violations.getitemstring(li_Loop1, "dv_desc")
					lstra_OldViolations[li_SetIndex].reason = ds_violations.getitemstring(li_Loop1, "dv_reason")
					lstra_OldViolations[li_SetIndex].ex = ds_violations.getitemstring(li_Loop1, "dv_excused")
					lstra_OldViolations[li_SetIndex].whoex = ds_violations.getitemstring(li_Loop1, "dv_who_ex")
					lstra_OldViolations[li_SetIndex].vtype = ds_violations.getitemnumber(li_Loop1, "dv_type")
					
				end if 
				
				ds_violations.deleterow(li_Loop1)				
				
			else
				
				li_MaxViolation = max(ds_violations.getitemnumber(li_Loop1, "dv_num"), li_MaxViolation)
				
			end if
			
			//next_one:
		next
		
	end if
	
	li_MaxViolation ++
	
	
	//----------------------------------------------------------------------establishing desc.
	
	/////////////////////////
	
	//The original code used goto's to control the logic flow here.  This has been replaced with an 
	//equivalent IF - THEN structure, below    3.7.00  8-9-03  BKW
	
	//if li_ViolationIndex > 0 or lb_LostOr100 = TRUE then
	//	if lb_LostOr100 = TRUE then goto special_logs
	//else
	//	//no violations, go to next modified row
	//	CONTINUE  //goto skipit
	//end if
	
	//////////////////////////
	
	
	IF lb_LostOr100 = TRUE THEN
		
		if li_ViolationIndex = 0 then CONTINUE
		
		choose case lstra_Violations[1].the_type
		
		case 7 
			ls_Violation = "Driver did not turn in a log for this day."
			
		case 8
			if dec(lc_OnDutyTotal - li_AirRadiusHoursLimit) = 1 then 
				ls_ViolationTimeLabel = " hour."
			else
				ls_ViolationTimeLabel = " hours."
			end if
			
			ls_Violation = "Driver exceeded the " + String ( li_AirRadiusHoursLimit ) + " hour 100 Air-Mile Radius rule.  The " +&
				"driver exceed the limit by " + string(lc_OnDutyTotal - li_AirRadiusHoursLimit, "0.00") + ls_ViolationTimeLabel 
					
		end choose
		
		li_NewRow = ds_violations.insertrow(0)
		
		ds_violations.setitem(li_NewRow, "dv_id", ll_DriverId)
		ds_violations.setitem(li_NewRow, "dv_date", ld_LogDate)
		ds_violations.setitem(li_NewRow, "dv_num", li_MaxViolation)
		ds_violations.setitem(li_NewRow, "dv_type", lstra_Violations[1].the_type)
		ds_violations.setitem(li_NewRow, "dv_desc", ls_Violation)
		
		li_MaxViolation ++
		
		if li_SetIndex > 0 then
		
			for li_Loop1 = 1 to li_SetIndex
		
				if ( lstra_Violations[1].the_type = 8 and lstra_OldViolations[li_Loop1].vtype = lstra_Violations[1].the_type ) or &
					( lstra_Violations[1].the_type = 7 and lstra_OldViolations[li_Loop1].vdesc = ls_Violation) then
					
					ds_violations.setitem(li_NewRow, "dv_excused", lstra_OldViolations[li_Loop1].ex)
					ds_violations.setitem(li_NewRow, "dv_reason", lstra_OldViolations[li_Loop1].reason)
					ds_violations.setitem(li_NewRow, "dv_who_ex", lstra_OldViolations[li_Loop1].whoex)
					
				end if
				
			next
			
		end if
		
	ELSEIF li_ViolationIndex > 0 THEN
	
		for li_Loop1 = 1 to li_ViolationIndex
		
			if lstra_Violations[li_Loop1].the_type = 2 then  //On Duty Violation
				
				if lstra_Violations[li_Loop1].the_time + lstra_Violations[li_Loop1].howbad <= 97 then continue
				
				if lstra_Violations[li_Loop1].the_time > 96 then                  
					lstra_Violations[li_Loop1].the_time = lstra_Violations[li_Loop1].the_time - 96
					lb_PreviousDayStart = FALSE
				else
					lb_PreviousDayStart = TRUE
				end if
			
				if lstra_Violations[li_Loop1].limit > 96 then
					lstra_Violations[li_Loop1].limit = lstra_Violations[li_Loop1].limit - 96
					lb_PreviousDayLimit = FALSE
				else
					lb_PreviousDayLimit = TRUE
				end if
			
			
				ls_LimitReached = string(reltime_ext(string(lt_FixerStart), lstra_Violations[li_Loop1].limit * 900), &
					"h:mm AM/PM")
					
				ls_ViolationStart = string(reltime_ext(string(lt_FixerStart), (lstra_Violations[li_Loop1].the_time - 1) * &
					 900), "h:mm AM/PM")
					 
				ls_ViolationLength = string(lstra_Violations[li_Loop1].howbad / 4.0, "0.00")
			
				if ls_LimitReached = ls_ViolationStart then lb_SameTime = TRUE else lb_SameTime = FALSE
			
			// tttttttttttttttttttttttTTTTTTTTTTTTTTTTTTTTttttttttttttttttt description stuff
			
				if lb_PreviousDayLimit = TRUE then
					ls_V1 = "At " + ls_LimitReached + " of previous day, driver reached "
				else
					ls_V1 = "At " + ls_LimitReached + " driver reached "
				end if
				
				ls_V2 = String ( li_OnDutyLimitHours ) + " hour on duty limit"
				
				if li_Loop1 > 1 then 
					for li_Loop2 = (li_Loop1 - 1) to 1 step -1
						if lstra_Violations[li_Loop2].the_type = 2 then 
		//					ls_V2 += " again"
							exit
						end if
					next
				end if
		
				if dec(ls_ViolationLength) = 1 then
					ls_ViolationTimeLabel = " hour" 
				else 
					ls_ViolationTimeLabel = " hours"
				end if
				
				ls_V4 = "proceeded to drive " + ls_ViolationLength + ls_ViolationTimeLabel + " beyond the limit"
		
				if lb_SameTime = TRUE then
					ls_V3 = " and " + ls_V4 + "."
				elseif lb_PreviousDayStart = TRUE then
					ls_V3 = ".  At " + ls_ViolationStart + " of previous day, driver " + ls_V4 + " into the current day."
				else
					ls_V3 = ".  At " + ls_ViolationStart + " driver " + ls_V4 + "."
				end if
		
				ls_Violation = ls_V1 + ls_V2 + ls_V3
				
			else //driving hours violation
				
				if lstra_Violations[li_Loop1].the_time + lstra_Violations[li_Loop1].howbad <= 97 then continue
				
				if lstra_Violations[li_Loop1].the_time > 96 then                  
					lstra_Violations[li_Loop1].the_time = lstra_Violations[li_Loop1].the_time - 96
					lb_PreviousDayStart = FALSE
				else
					lb_PreviousDayStart = TRUE
				end if
			
				if lstra_Violations[li_Loop1].limit > 96 then
					lstra_Violations[li_Loop1].limit = lstra_Violations[li_Loop1].limit - 96
					lb_PreviousDayLimit = FALSE
				else
					lb_PreviousDayLimit = TRUE
				end if
			
			
				ls_LimitReached = string(reltime_ext(string(lt_FixerStart), lstra_Violations[li_Loop1].limit * 900), &
					"h:mm AM/PM")
					
				ls_ViolationStart = string(reltime_ext(string(lt_FixerStart), (lstra_Violations[li_Loop1].the_time - 1) * &
					 900), "h:mm AM/PM")
					 
				ls_ViolationLength = string(lstra_Violations[li_Loop1].howbad / 4.0, "0.00")
			
				if ls_LimitReached = ls_ViolationStart then
					lb_SameTime = TRUE 
				else 
					lb_SameTime = FALSE
				end if
			
			// tttttttttttttttttttttttTTTTTTTTTTTTTTTTTTTTttttttttttttttttt description stuff
			
				if lb_PreviousDayLimit = TRUE then
					ls_V1 = "At " + ls_LimitReached + " of previous day, driver reached "
				else
					ls_V1 = "At " + ls_LimitReached + " driver reached "
				end if
				
				ls_V2 = String ( li_DrivingLimitHours )  + " hour driving limit"
				
				if li_Loop1 > 1 then 
					for li_Loop2 = (li_Loop1 - 1) to 1 step -1
						if lstra_Violations[li_Loop2].the_type = 1 then 
		//					ls_V2 += " again"
							exit
						end if
					next
				end if
				
				if dec(ls_ViolationLength) = 1 then 
					ls_ViolationTimeLabel = " hour"	
				else 
					ls_ViolationTimeLabel = " hours"
				end if
				
				ls_V4 = "proceeded to drive " + ls_ViolationLength + ls_ViolationTimeLabel + " beyond the limit"
		
				if lb_SameTime = TRUE then
					ls_V3 = " and " + ls_V4 + "."
				elseif lb_PreviousDayStart = TRUE then
					ls_V3 = ".  At " + ls_ViolationStart + " of previous day, driver " + ls_V4 + " into the current day."
				else
					ls_V3 = ".  At " + ls_ViolationStart + " driver " + ls_V4 + "."
				end if
		
				ls_Violation = ls_V1 + ls_V2 + ls_V3
				
			end if
			
			//---------------------------------------------------------------- set in datatstore
		
			li_NewRow = ds_violations.insertrow(0)
			
			ds_violations.setitem(li_NewRow, "dv_id", ll_DriverId)
			ds_violations.setitem(li_NewRow, "dv_date", ld_LogDate)
			ds_violations.setitem(li_NewRow, "dv_num", li_MaxViolation)
			ds_violations.setitem(li_NewRow, "dv_type", lstra_Violations[li_Loop1].the_type)
			ds_violations.setitem(li_NewRow, "dv_desc", ls_Violation)
			
			for li_Loop2 = 1 to li_SetIndex
				
				if lstra_OldViolations[li_Loop2].vdesc = ls_Violation then
					
					ds_violations.setitem(li_NewRow, "dv_excused", lstra_OldViolations[li_Loop2].ex)
					ds_violations.setitem(li_NewRow, "dv_reason", lstra_OldViolations[li_Loop2].reason)
					ds_violations.setitem(li_NewRow, "dv_who_ex", lstra_OldViolations[li_Loop2].whoex)
					
				end if
				
			next
			
			li_MaxViolation ++
			
		next
		
	END IF


// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ end of loop for insertion
next 

// end of first "for" loop The big one 
// eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee


/*	NEW HOS RULES PROCESSING ADDED 11-21-03 BKW */


IF lb_ViosMovedToFilter = TRUE THEN   //Post 1/1/04 violations were moved to filter.  Move them back.

	//Will this be a problem if they had post 1/1/04 logs with violations, and then deleted them all??
	//Would that result in the violations being there without the logs??

	li_ViosMoveRowCount = ds_Violations.RowCount ( )

	ds_Violations.RowsMove ( li_ViosMoveFilteredCount + 1, li_ViosMoveFilteredCount + li_ViosMovedCount, Filter!, &
		ds_Violations, li_ViosMoveRowCount + 1, Primary! )

END IF


IF lb_NewRulesProcessingNeeded THEN

	//Because of the potential for a change on one day to create a violation on the prior day, 
	//so long as we're processing after 1/4/04, start the check one day early, so the overlap, if any, is caught.
	//(Actually, it is possible for this overlap to extend backwards more than one day, but not as likely...)

	IF DaysAfter ( 2004-01-04, ld_NewRulesProcessingStartDate ) > 0 THEN

		This.wf_ViolationsCheck ( RelativeDate ( ld_NewRulesProcessingStartDate, -1 ) )
		
	ELSE
		
		This.wf_ViolationsCheck ( ld_NewRulesProcessingStartDate )
		
	END IF

END IF

/*	END NEW HOS RULES PROCESSING*/


return



end subroutine

public subroutine emp_switch (integer uo_num);n_cst_LicenseManager	lnv_LicenseManager

n_cst_PrivsManager	lnv_PrivsManager

if win_is_closing = true then return
dw_losefocus()
if uo_num = 2 then 
	set_codriver() 
	return
elseif isnull(uo_choose_emp.temp_emp.em_id) then 
	return
elseif not isnull(cur_driver.em_id) and uo_choose_emp.temp_emp.em_id = cur_driver.em_id then
	//same driver
	uo_choose_emp.set_emp(true) //gets the name back
	return
end if 
 
//******************************************************************** upadate section
integer reply
string failnote

rowsmod()
if indx <> 0 and settings.autosave = 0 and g_privs.log[3] = 1 then
	reply = messagebox("Change Drivers","Save changes to current driver first?", question!, &
	yesnocancel!, 1) 
	if reply = 2 then
		goto retrievepart
	elseif reply = 3 then
		goto original_driver
	end if
elseif indx = 0 or g_privs.log[3] = 0 then
	goto retrievepart
end if

reply = calc_and_save(failnote)

if reply = -1 then
	reply = messagebox("Save Changes", "Could not save changes to database.~n~nPress OK to " +&
	"abandon changes and switch drivers.  Press Cancel to return to the current driver "+&
	"and preserve changes for now.", Exclamation!, Okcancel!, 2)
	if reply = 2 then goto original_driver
elseif reply = 99 then //--------------------- user wants to enter mileage
	goto original_driver
end if 

//********************************************************************* retrieving
retrievepart:

integer newint, newsched, lcv
date firstlog, templock
long temp_id
Long	ll_Division
boolean first_entry

SELECT "driverinfo"."di_division" 
INTO :ll_division
FROM "driverinfo"  
WHERE "driverinfo"."di_id" = :uo_choose_emp.temp_emp.em_id;
COMMIT;

lnv_PrivsManager = gnv_App.of_GetPrivsManager( )
IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyDriverLog, ll_Division) <> 1 THEN
	goto hide_details
END IF

//the first part of this sql statement is bogus
setnull(temp_id)
select di_id into :temp_id from driverinfo where di_id = :uo_choose_emp.temp_emp.em_id and 
	( exists (select * from driver_logs where dl_id = :uo_choose_emp.temp_emp.em_id) ) ; 

if sqlca.sqlcode = 0 or sqlca.sqlcode = 100 then 
	commit ;
else
	rollback ; 
	messagebox("Change Drivers","Could not retrieve information from database." + &
	"~n~nPlease Retry.", exclamation!)
	goto original_driver
end if
if isnull(temp_id) then first_entry = true else first_entry = false

select di_intsig, di_sched_type into :newint, :newsched
	from driverinfo where di_id = :uo_choose_emp.temp_emp.em_id ;
if sqlca.sqlcode <> 0 then
	rollback ; 
	messagebox("Change Drivers","Could not retrieve information from database." + &
	"~n~nPlease Retry.", exclamation!)
	goto original_driver
else
	commit ;
	if isnull(newint) then 
		update driverinfo set di_intsig = 1 where di_id = :uo_choose_emp.temp_emp.em_id ;
		if sqlca.sqlcode <> 0 then
			rollback ;
			messagebox("Change Drivers","Could not retrieve information from database." + &
			"~n~nPlease Retry.", exclamation!)
			goto original_driver
		else
			commit ;
			newint = 1
		end if 
	end if
end if
//-----------------------------------------------------------------no rule set
if nullornotpos(newsched) then  
	if g_privs.log[3] = 0 then	goto noentry
	dw_log_list.object.di_sched_Type.text = "7"
	openwithparm(w_sched_type, uo_choose_emp.temp_emp.em_ln + ", " + uo_choose_emp.temp_emp.em_fn)
	newsched = message.doubleparm
	if isnull(newsched) or newsched = 0 then goto original_driver
	//sets the newsched right now even if they reject first log entry date
	update driverinfo set di_sched_type = :newsched, di_intsig = :newint + 1 where di_id = :uo_choose_emp.temp_emp.em_id ;
	if sqlca.sqlcode <> 0 then 
		rollback ;
		messagebox("Change Drivers","Could not retrieve information from database." + &
		"~n~nPlease Retry.", exclamation!)
		goto original_driver
	else
		commit ;
		newint ++
	end if		
end if
//-----------------------------------------------------------------no logs on file
if first_entry = true then 
	IF NOT gnv_App.of_Getprivsmanager( ).of_Useadvancedprivs( ) THEN
		if g_privs.log[3] = 0 then
			noentry:
			messagebox("Change Drivers", "The driver " + uo_choose_emp.temp_emp.em_fn + " " +&
				uo_choose_emp.temp_emp.em_ln + " has no logs on file.~n~nChange request cancelled.")
			goto original_driver
		end if
	END IF
	s_date_return openvals
	openvals.mindate = date("1/1/90")
	openvals.maxdate = relativedate(lnv_LicenseManager.of_GetLicenseExpiration ( ), -1)
	openvals.tag = "Enter First Log Date for " + uo_choose_emp.temp_emp.em_ln
	string return_date
	openwithparm(w_choose_day, openvals)
	if not isdate(message.stringparm) then
		goto original_driver
	else
		firstlog = date(message.stringparm)
	end if
end if

//------------------------------------------------past the point of no return(reject)
dw_log_list.setredraw(false)
dw_log.setredraw(false)
dw_log.setredraw(false)

dw_log_list.reset()
ds_violations.reset()
ds_receipts.reset()
dw_log.reset()
st_noprivs.Visible = False //incase hide_details made it visible
dw_log.Enabled = True //incase hide_details turned disable it

if newsched = 8 then
	st_type.text = "70/8"
	dw_log_list.object.di_sched_Type.text = "8"
	dw_log_list.modify("datawindow.detail.height = 75")
	dw_log_list.modify("datawindow.header.height = 70")
elseif newsched = 7 then	
	st_type.text = "60/7"
	dw_log_list.object.di_sched_Type.text = "7"
	dw_log_list.modify("datawindow.detail.height = 86")
	dw_log_list.modify("datawindow.header.height = 57")
end if
//--------------------------------------------------

if first_entry = true then 
	integer rowfix
	rowfix = (newsched - 1) * -1
	log_string = fill("7", 96)
	lockdate = relativedate(date(return_date), -10)
	for lcv = 1 to newsched
		dw_log_list.insertrow(0)
		dw_log_list.setitem(lcv, "dl_vios", 0)
		dw_log_list.setitem(lcv, "dl_odtot", 0)
		dw_log_list.setitem(lcv, "dl_id", uo_choose_emp.temp_emp.em_id)
		dw_log_list.setitem(lcv, "dl_date", relativedate(firstlog, rowfix))
		rowfix ++
		if lcv <> newsched then dw_log_list.setitem(lcv, "dl_log", log_string)
	next
	log_string = fill("1", 96)
	dw_log.setitem(newsched, "dl_log", log_string)
else
	integer retrieve1, retrieve2, retrieve3
	retrieve1 = dw_log_list.retrieve(uo_choose_emp.temp_emp.em_id, date("1/1/80"), date("1/1/80"))
	retrieve2 = ds_violations.retrieve(uo_choose_emp.temp_emp.em_id)
	retrieve3 = ds_receipts.retrieve(uo_choose_emp.temp_emp.em_id)
	
	if retrieve1 = -1  or retrieve2 = -1 or retrieve3 = -1 then
		rollback ;
		messagebox("Change Drivers","Could not retrieve information from database." + &
		"~n~nPlease Retry.", exclamation!)
		goto rejection
	else
		commit ;
	end if
end if


dw_log_list.scrolltorow(dw_log_list.rowcount())
dw_log_list.setrow(dw_log_list.rowcount())
cury = integer(left(log_string, 1))
dw_log.modify("st_curpos.text = '" + string(1 * 10 + cury) + "'")
curx = 1

//--------------------------------------------------------------date vs. lockdate check
firstlog = dw_log_list.getitemdate(newsched, "dl_date")
lastentered = dw_log_list.getitemdate(dw_log_list.rowcount(), "dl_date")

if lockopt > 0 and first_entry = false then 
	lockdate = relativedate(lastentered, (lockopt - 1) * -1 )
else 
	lockdate = relativedate(firstlog, -10)
end if
dw_log_list.object.di_lockdate.text = string(lockdate, "m/d/yy")

start_check_row = 0
vios_row = 0  // the point of the viosrow is to start violations check without going back 6
              //months into vios that are locked up.  It should make things more efficient

if lockdate > firstlog then
	for lcv = newsched to dw_log_list.rowcount()
		if dw_log_list.getitemdate(lcv, "dl_date") = lockdate then
			start_check_row = lcv
			exit
		end if
	next
	if start_check_row = 0 then start_check_row = newsched
else
	start_check_row = newsched
	vios_row = 1
end if		
//-----------------------------------------------------------Vios Row Set up
if ds_violations.rowcount() > 0 and vios_row = 0 then
	for lcv = 1 to ds_violations.rowcount()
		if ds_violations.getitemdate(lcv, "dv_date") <= lockdate then
			vios_row = lcv
			if ds_violations.getitemdate(lcv, "dv_date") = lockdate then exit
		else
			exit //date surpassed locked date into open territory--check is done
		end if
	next
else
	vios_row = 1  // be careful in loops, there are no violations
end if

cur_driver = uo_choose_emp.temp_emp
uo_choose_emp.set_emp(true)
sched_type = newsched
old_intsig = newint
if isnull(vios_row) or vios_row <= 0 then vios_row = 1
if isnull(start_check_row) or start_check_row <= 0 then start_check_row = sched_type

if (settings.autonext = 0 or lastentered < lockdate or first_entry = true or &
	relativedate(lastentered, 1) >= lnv_LicenseManager.of_GetLicenseExpiration ( ) ) then
	log_to_chart(0, dw_log_list.rowcount())


	add_next = false
else
	zz_add_next()
	add_next = true
end if
dw_log.setfocus()

if first_entry = true then lastentered = relativedate(lastentered, -1)
dw_log_list.setredraw(true)
dw_log.setredraw(true)
return 

rejection:
	setface(0)
	uo_choose_emp.set_emp(false)
	return 

original_driver:
	if not isnull(cur_driver.em_id) then 
		uo_choose_emp.sle_name.text = cur_driver.em_ln + ", " + cur_driver.em_fn
	else
		goto rejection
	end if
	return
	
hide_details:
	dw_log_list.reset()
	ds_violations.reset()
	ds_receipts.reset()
	dw_log.reset()
	dw_vios_short.reset()
	dw_miles.reset()
	
	dw_log.Enabled = False //Prevent click actions
	
	st_vios.visible = False
	st_lock.visible = False
	
	gb_date.text = ""
	st_type.text = ""
	
	cur_driver = uo_choose_emp.temp_emp
	uo_choose_emp.set_emp(True)
	uo_codriver.sle_name.Text = ""
	uo_codriver.sle_name.Text = ""
	
	st_noprivs.Visible = True
	return



end subroutine

public subroutine refresh_jump ();if ds_drivers.retrieve() = -1 then
	rollback ;
	//it's ok if this fails.  the userobject still has the old one
	//no point bothering the user, the newly entered driver just won't be on the jump
	return
else 
	commit ;
end if

if ds_drivers.rowcount() > 0 then 
	uo_choose_emp.ds_hotkey.object.data.primary = ds_drivers.object.data.primary
else
	uo_choose_emp.ds_hotkey.reset()
end if

if uo_choose_emp.ds_hotkey.rowcount() > 0 then 
	uo_choose_emp.hsb_1.Visible = true
else
	uo_choose_emp.hsb_1.Visible = false
end if



end subroutine

public function integer wf_violationscheck (date ad_startdate);//Have them specify the short haul exemption up front.  The check will then determine if that is valid -- 
//if so, it will keep it and use it, if not, it will toss it out.
//
//
//From change point, go backwards to identify last 10 consective hrs off.
//From change point, go forwards to identify next 10 consecutive hrs off.
//
//The back to the next is the first processing loop.  Then, repeat for all subsequent intervals between 10 hr off periods.
//
//Look in each of these intervals for violations.


//*******


DataWindow	ldw_Logs
DataStore	lds_Violations

Integer		li_LogCount, &
				li_StartRow, &
				li_Row, &
				li_Start, &
				li_End, &
				li_IntervalEnd, &
				li_IntervalLength, &
				li_Index, &
				li_NextIntervalStartIndex, &
				li_SleeperCount, &
				li_SleeperMatchIndex, &
				li_TrackingIndex, &
				li_SleeperIndex, &
				li_ViolationCount, &
				li_Check, &
				li_TrackingIndexToUse

Decimal {2}	lc_FirstSleeperIntervalCheck, &
				lc_SecondSleeperIntervalCheck, &
				lc_ContinuousRest, &
				lc_ContinuousSleeper, &
				lc_OnDutyTotal   //For use with Air Radius Check

Boolean		lb_OpenSleeperInterval, &
				lb_UsingSplitSleeper, &
				lb_Reset, &
				lb_Post100105

//lb_UsingSplitSleeper was introduced after FMCSA 11-24-03 in order to flag whether at least one Split Sleeper Reset
//had occurred during a run between 10-hr off periods.  If so, the final split sleeper period can be paired with a 
//10 hr off period; if not (if there has been a sleeper period not successfully paired with anything for a reset), 
//this sleeper - 10 off combo cannot be used, and the sleeper period counts against the 14 hour rule.

String		ls_ErrorMessage


//****

String	ls_PriorStatus, &
			ls_CurrentStatus, &
			ls_CombinedLog, &
			ls_Find

Date		ld_CombinedStartDate, &
			ld_CombinedEndDate

//DateTime	ldt_PriorDateTime
DateTime	ldt_CurrentDateTime, &
			ldt_NextDateTime, &
			ldt_UnspecifiedDateTime
			
Long		ll_Test

//SetNull ( ldt_StartDateTime )


//I'm naming these constants as variables because the values could potentially be conditional.

Constant Integer	li_DrvingLimitHours = 11  //11 hrs
Constant Integer	li_OnDutyLimitHours = 14  //14 hrs CONSECUTIVE FROM START OF ON DUTY PERIOD (used to be CUMULATIVE)
Constant Integer	li_OffDutyPeriod = 10 * 4 //10 hrs -- can be mix of Off Duty and Sleeper, must be consecutive.
Constant Integer	li_SleeperPeriod = 10 * 4 //10 hrs -- sleeper only, in 2 periods of at least 2 hrs each totaling 10 hrs.	
Constant Integer	li_AirRadiusLimitHours = 12  //12 hrs.
Constant Integer	li_DrivingLimit = 11 * 4  //The # of 15 minute intervals in the driving hours limit.
Constant Integer	li_OnDutyLimit = 14 * 4   //The # of 15 minute intervals in the on duty hours limit.

Constant Decimal {2}	lc_MinSleeperInterval = 2	//2 hrs.
Constant Decimal {2} lc_CombinedSleeperRequirement = 10  //10 hrs.
Constant Decimal {2}	lc_OffDutyRequirement = 10 //10 hrs.
Constant Decimal {2}	lc_DutyTimeLimit = 14		//14 hrs.
Constant Decimal {2}	lc_DrivingTimeLimit = 11	//11 hrs.

Decimal {2}	lc_ContinuousSleeperRequirement  //Value depends on pre or post 10-01-05.  Set during each interval pass.

//And, an array to track all the sleeper periods encountered (including those not eligible due to < 2 hrs, because processing would be harder to exclude them, I think)

//s_Tracking	
//
//Decimal	ic_DrivingTime
//Decimal	ic_TotalDutyTime
//DateTime	idt_SleeperStart				//DateTime that the sleeper period started
//DateTime	idt_SleeperEnd					//DateTime that the sleeper period ENDED (NOT the start of the last interval in the sleeper) (eg, 2PM, if sleeper ended at 2PM)
//Integer	ii_LastSleeperIndex			//Index that the sleeper interval ended (the last index that was in the sleeper pd)
//Decimal	ic_SleeperInterval			//Duration of this sleeper interval (0 if not a sleeper interval, ie the baseline)
//DateTime	idt_NextIntervalStart		//DateTime that the next interval started (will be the next 1/4 hr after end, by rule - when using split sleeper, the next period starts immediately, event Off Duty immediately following the sleeper period counts against the next 14 hr Duty cycle)
//Integer	ii_NextIntervalStartIndex	//Index that the next interval started (will be the next index after end, by rule)
//DateTime	idt_DrivingLimitReached		//
//DateTime	idt_DutyLimitReached
//Decimal	ic_DrivingViolationTime
//Decimal	ic_DutyViolationTime


os_Tracking	lstra_Tracking[], &
				lstra_BlankTracking[]

os_Violation	lstra_Violations[]

n_cst_DateTime	lnv_DateTime


Integer		li_Return = 1


IF li_Return = 1 THEN

	ldw_Logs = dw_Log_List				//dw_Log_List is the log list datawindow.
	lds_Violations = ds_Violations	//ds_Violations is an instance variable for the window.
	
	li_LogCount = ldw_Logs.RowCount ( )

	//Build find string.  Using DaysAfter to avoid any problem with hidden time component.
	ls_Find = "DaysAfter ( dl_date, " + String ( ad_StartDate, "yyyy-mm-dd" ) + " ) = 0"
	//Instead of:  ls_Find = "dl_date = " + String ( ad_StartDate ), "yyyy-mm-dd" )

	li_StartRow = ldw_Logs.Find ( ls_Find, 1, li_LogCount )
	
	IF li_StartRow > 0 THEN
		//OK
	ELSE
		ls_ErrorMessage = "Could not identify start row for HOS check in log list. (VC1)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	//Assemble the combined log string from the identified start row forward.

	FOR li_Row = li_StartRow TO li_LogCount

		ls_CombinedLog += ldw_Logs.GetItemString ( li_Row, "dl_log" )

	NEXT

	ld_CombinedStartDate = ldw_Logs.GetItemDate ( li_StartRow, "dl_date" )
	ld_CombinedEndDate = ldw_Logs.GetItemDate ( li_LogCount, "dl_date" )

	IF DaysAfter ( ld_CombinedStartDate, ld_CombinedEndDate ) = li_LogCount - li_StartRow THEN
		//OK
	ELSE
		ls_ErrorMessage = "Incorrect number of logs for date range.  (VC3)"
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	li_IntervalEnd = 0
	li_IntervalLength = 0

	FOR li_Index = 1 TO 96

		ls_CurrentStatus = Mid ( ls_CombinedLog, li_Index, 1 )

		CHOOSE CASE ls_CurrentStatus

		CASE gc_Logs.cs_Status_Driving, gc_Logs.cs_Status_OnDuty

			IF li_IntervalLength >= li_OffDutyPeriod THEN
				li_Start = li_IntervalEnd + 1
			END IF

			EXIT

		CASE gc_Logs.cs_Status_OffDuty, gc_Logs.cs_Status_Sleeper

			li_IntervalEnd ++
			li_IntervalLength ++

		CASE ELSE  //Special Log Code   ***MIGHT NEED TO GO BACKWARDS HERE?  

			//I don't think this concern applies now after the FMCSA 11-24-03 ruling.

			//**WHAT IF THEY HAD A LOG WITH SLEEPER IN IT, AND THEN REPLACED THAT WITH MISSING LOG OR AIR RADIUS.
			//**COULD INVALIDATE THE PREVIOUS DAY.  NEED TO CHECK IN THAT SITUATION WHAT THE START DATE THAT'S 
			//**PASSED IN IS.  PERHAPS IT'S AUTOMATICALLY SET AHEAD OF WHERE THE ACTUAL EDIT TOOK PLACE?

			li_Start = 1
			EXIT

		END CHOOSE

	NEXT

	//If we went all the way through the loop in a rest period, set the start position as 1
	//(Start with this log, no need to go backwards.)

	IF li_Start = 0 AND li_IntervalEnd = 96 THEN

		li_Start = 1

	END IF



	//If necessary, loop backwards trying to find 10 consecutive off duty, or a special log code.
	//The checking interval will start immediately after the end of this "reset" period.

	IF li_Start > 0 THEN

		//OK, already determined a start point within the first log.  No need to look backwards.

	ELSE

		FOR li_Row = li_StartRow - 1 TO 1 STEP -1
	
			ls_CombinedLog = ldw_Logs.GetItemString ( li_Row, "dl_log" ) + ls_CombinedLog
			ld_CombinedStartDate = RelativeDate ( ld_CombinedStartDate, -1 )

			//This loop may be building of a rest interval already in progress, even one that started in the 
			//check of the first log in a different loop, above.  If that's the case, adjust the IntervalEnd 
			//index to reflect the additional log being inserted at the front of the string.
	
			IF li_IntervalEnd > 0 THEN
				li_IntervalEnd += 96
			END IF
	
			FOR li_Index = 96 TO 1 STEP -1
	
				ls_CurrentStatus = Mid ( ls_CombinedLog, li_Index, 1 )
	
				CHOOSE CASE ls_CurrentStatus
	
				CASE gc_Logs.cs_Status_Driving, gc_Logs.cs_Status_OnDuty
	
					li_IntervalEnd = 0
					li_IntervalLength = 0
	
				CASE gc_Logs.cs_Status_OffDuty, gc_Logs.cs_Status_Sleeper
	
					IF li_IntervalLength > 0 THEN
	
						li_IntervalLength ++
	
						IF li_IntervalLength = li_OffDutyPeriod THEN
							li_Start = li_IntervalEnd + 1
							EXIT
						END IF
	
					ELSE
	
						li_IntervalEnd = li_Index
						li_IntervalLength = 1
	
					END IF
	
				CASE ELSE  //IS > "4"  //One of the special log codes:  Lost, Air Radius, Pre-Log PlaceHolder, or New Log
	

					/*WE NEED TO START AFTER ANY OPEN REST PERIOD THAT WE'VE BEEN WORKING
							THROUGH BEFORE ENCOUNTERING THIS SPECIAL LOG CODE.   
					*/

					IF li_IntervalLength > 0 THEN
						//We have an open rest interval prior to encountering the special code.  Start immediately after that.
						li_Start = li_IntervalEnd + 1
					ELSE
						//We don't have an open rest interval prior to encountering the special code.
						//Start immediately after the point we're checking here (li_Index + 1).
						li_Start = li_Index + 1
					END IF

					EXIT
	
				END CHOOSE
	
			NEXT

			//If we've now determined a start position, EXIT
			IF li_Start > 0 THEN
				EXIT
			END IF
	
		NEXT

	END IF


	IF li_Start > 0 THEN
		//OK -- We've identified a start point
	ELSE
		ls_ErrorMessage = "Could not find a start point for the HOS check. (VC2)"
		li_Return = -1
	END IF

END IF



//***SCAN THE INDENTIFIED RANGE FOR VIOLATIONS.***

IF li_Return = 1 THEN


//	MessageBox ( "Start", String ( li_Start ) )  //TESTING ONLY

//	//Add one extra status to the end of ls_CombinedLog to force triggering of any calculations triggered by change
//	//of duty status away from sleeper, etc.

	//Add a block of 15 hrs off duty to the end of ls_Combined log to force triggering of any violations.
	
	//Using OffDuty will trigger computation of any preceding violations without creating new ones.

	FOR li_Index = 1 TO 60
		ls_CombinedLog += gc_Logs.cs_Status_OffDuty
	NEXT

	li_End = Len ( ls_CombinedLog ) 

	//li_SleeperCount = 0
	ls_CurrentStatus = ""
	ls_PriorStatus = ""

	lb_Reset = TRUE
	SetNull ( lb_Post100105 )  //Should get set to null because lb_Reset = TRUE, but jic that logic changes...
	
	FOR li_Index = li_Start to li_End

		IF lb_Reset = TRUE THEN

			//We're coming in to this pass off a reset.  We need to reset various variables.

			lstra_Tracking = lstra_BlankTracking

			//Set starting values for lstra_Tracking [ 1 ].  This is the baseline interval, which will count all time,
			//including any sleeper time encountered, as duty time.  This baseline interval will be the one used unless a 
			//qualifying split-sleeper period is encountered.

			//*****
			//Note:  Prior to FMCSA Memo 11-24-03, this note read as follows, to reflect the fact that a sleeper period
			//would be disqualified by the driver going into violation:
			//Set starting values for lstra_Tracking [ 1 ].  This is the baseline interval, which will count all time,
			//including any sleeper time encountered, as duty time.  This baseline interval will be the one used unless a 
			//qualifying split-sleeper period is encountered, and not voided by violation.
			//*****

			lstra_Tracking [ 1 ].ic_TotalDutyTime = 0  //Just to force there to be an array entry [1]

			li_SleeperCount = 0   //This is the number of sleeper intervals being tracked during this interval.  Now 0.
			lb_OpenSleeperInterval = FALSE  //This is whether we're in an open sleeper interval, coming into this pass.  Now FALSE.
			li_SleeperMatchIndex = 0  //This is used to loop through looking for a qualifying sleeper split.  Make sure no carryover value.

			lc_ContinuousRest = 0
			lc_ContinuousSleeper = 0

			lb_Reset = FALSE
			
			SetNull ( lb_Post100105 )  //Will be set below based on ldt_CurrentDateTime

		END IF

	
		IF li_Index > 1 THEN
			ls_PriorStatus = Mid ( ls_CombinedLog, li_Index - 1, 1 )
		ELSE
			ls_PriorStatus = gc_Logs.cs_Status_Unknown
		END IF

		ls_CurrentStatus = Mid ( ls_CombinedLog, li_Index, 1 )
	


		//!!NOTE:  This logic assumes a midnight start time!!  (Most companies use this, but technically, they are
		//able to set their own.  This has not been a supported option, however.)

		ldt_CurrentDateTime = DateTime ( RelativeDate ( ld_CombinedStartDate, Int ( ( li_Index - 1 ) / 96 ) ), &
			RelativeTime ( 00:00:00, Mod ( li_Index - 1, 96 ) * 15 * 60 ) )

		ldt_NextDateTime = DateTime ( RelativeDate ( ld_CombinedStartDate, Int ( ( li_Index ) / 96 ) ), &
			RelativeTime ( 00:00:00, Mod ( li_Index, 96 ) * 15 * 60 ) )
			
			
		//If this is the start of a new interval, lb_Post100105 will be null, and we have to determine it.
			
		IF IsNull ( lb_Post100105 ) THEN
			
			//If we'll be on or after 10-01-05 00:00:00 at 14 hrs from the starting point, use the new rules.
			
			//The first period that overlaps is inherently a gray area, but this seems like a fairly reasonable
			//handling.
			
			IF ldt_CurrentDateTime >= DateTime ( 2005-09-30, 10:00:00 ) THEN
				lb_Post100105 = TRUE
				lc_ContinuousSleeperRequirement = 8  //8 hrs
			ELSE
				lb_Post100105 = FALSE
				lc_ContinuousSleeperRequirement = 0  //No requirement
			END IF
			
		END IF


//		Decided this was not needed
//		IF IsNull ( ldt_StartDateTime ) THEN
//			ldt_StartDateTime = ldt_CurrentDateTime
//		END IF


//		IF li_Index = 1 THEN
//
//			ldt_PriorDateTime = DateTime ( RelativeDate ( ld_CombinedStartDate, -1 ), 23:45:00 )
//
//		ELSE
//
//			ldt_PriorDateTime = DateTime ( RelativeDate ( ld_CombinedStartDate, Int ( ( li_Index - 2 ) / 96 ) ), &
//				RelativeTime ( 00:00:00, Mod ( li_Index - 2, 96 ) * 15 * 60 ) )
//
//		END IF

		//!!
	
	
		//First, deal with a change into or out of the sleeper berth that would cause us to have to 
		//open a new sleeper interval for tracking, or close an open one.

		IF ls_CurrentStatus = gc_Logs.cs_Status_Sleeper OR &
			( lb_Post100105 AND ls_CurrentStatus = gc_Logs.cs_Status_OffDuty ) THEN
			
			//With the 10-01-05 Rules, a "sleeper" interval is now really just a rest interval.
			//However, one of these rest intervals will need to be 8 or more continuous hrs in the 
			//sleeper in order to qualify for a reset.
	
			IF lb_OpenSleeperInterval = FALSE THEN
	
				//We're now in the sleeper, and we don't have an open sleeper interval.  Add a tracking entry for this
				//new sleeper interval, and flag that we now are in an open sleeper interval.

				li_SleeperCount ++
				lstra_Tracking [ li_SleeperCount + 1 ] = lstra_Tracking [ 1 ]  //Copy the contents of the baseline into a new tracking index for this new sleeper interval.
				lstra_Tracking [ li_SleeperCount + 1 ].idt_SleeperStart = ldt_CurrentDateTime
	
				lb_OpenSleeperInterval = TRUE
	
			END IF
	
		ELSE
	
			IF lb_OpenSleeperInterval = TRUE THEN

				//We're now out of the sleeper, but we have an open sleeper interval.  We have to close this open interval.
	
				lstra_Tracking [ li_SleeperCount + 1 ].idt_SleeperEnd = ldt_CurrentDateTime
				//If we're in sleeper from 12 to 2, we're doing this processing on the ldt_CurrentDateTime = 2PM pass, so
				//idt_SleeperEnd will be ldt_CurrentDateTime (NOT 15 mins prior), and idt_NextIntervalStart will be the same.

				lstra_Tracking [ li_SleeperCount + 1 ].ii_LastSleeperIndex = li_Index - 1
				lstra_Tracking [ li_SleeperCount + 1 ].idt_NextIntervalStart = ldt_CurrentDateTime
				lstra_Tracking [ li_SleeperCount + 1 ].ii_NextIntervalStartIndex = li_Index
	
				lb_OpenSleeperInterval = FALSE
	
				lc_SecondSleeperIntervalCheck = lstra_Tracking [ li_SleeperCount + 1 ].ic_SleeperInterval
	
				IF lc_SecondSleeperIntervalCheck >= lc_MinSleeperInterval AND li_SleeperCount > 1 THEN
	
					//The sleeper interval we just completed is >= the required minimum interval (2 hrs), 
					//and there's at least one other sleeper interval in the duty cycle.
					//So, we'll see if we can combine this interval with a previous interval.
	
					//NOTE:  If the FMCSA says you have to re-use interval B in the next cycle, then we'd 
					//just have to check interval "B", rather than all possible intervals, here.
	
					//We're going to step backwards because the latest qualifying interval is the best for the driver.
					//(Unless "B" has to pivot, in which case the longest qualifying interval may be the best???)
	
					FOR li_SleeperIndex = li_SleeperCount - 1 TO 1 STEP -1
	
						lc_FirstSleeperIntervalCheck = lstra_Tracking [ li_SleeperIndex + 1 ].ic_SleeperInterval
	
						IF lc_FirstSleeperIntervalCheck >= lc_MinSleeperInterval AND &
							lc_FirstSleeperIntervalCheck + lc_SecondSleeperIntervalCheck >= lc_CombinedSleeperRequirement THEN
	
//***************		Prior to FMCSA 11-24-03, the sleeper period would be valid only if the driver had not gone into violation.
//***************		The FMCSA interpretation changed that.  If they change their mind again, revert to this logic.
//							//This will qualify as a reset, IF the driver is not in 11 or 14 hr violation.
//	
//							IF lstra_Tracking [ li_SleeperIndex + 1 ].ic_DrivingViolationTime > 0 OR &
//								lstra_Tracking [ li_SleeperIndex + 1 ].ic_DutyViolationTime > 0 THEN
//	
//								//It doesn't count, driver is already in violation.  Split sleeper can no longer help him.
//								//Make a descriptive note to this effect here, to include in the violation description???
//	
//							ELSE
//	
//								//This split qualifies for a reset.  EXIT this loop prematurely at this position.	
//	
//								EXIT
//	
//							END IF
//****************

							//With the 10-01-05 Rules, at least one of the 2 periods has to meet the ContinuousSleeperRequirement (8 hrs of uninterupted sleeper time)

							IF lb_Post100105 THEN
								
								IF lstra_Tracking [ li_SleeperIndex + 1 ].ic_ContinuousSleeper >= lc_ContinuousSleeperRequirement OR &
									lstra_Tracking [ li_SleeperCount + 1 ].ic_ContinuousSleeper >= lc_ContinuousSleeperRequirement THEN
									//OK
								ELSE
									//Neither period has enough continuous sleeper time.  Keep looking.
									CONTINUE
								END IF
								
							END IF


							//This qualifies as a reset (regardless of whether the driver is not in 11 or 14 hr violation.)
	
							//See if it's the best qualifying split for the driver.

							IF li_SleeperMatchIndex = 0 THEN  //First match found.  Use it, unless a better one is found.

								li_SleeperMatchIndex = li_SleeperIndex

							ELSEIF lstra_Tracking [ li_SleeperIndex + 1 ].ic_DutyViolationTime < lstra_Tracking [ li_SleeperMatchIndex + 1 ].ic_DutyViolationTime THEN

								//The duty violation time for li_SleeperIndex is lower than the previous best match, li_SleeperMatchIndex
								//Make li_SleeperIndex the new best match in li_SleeperMatchIndex
								li_SleeperMatchIndex = li_SleeperIndex

							END IF


							//If we've identified a sleeper match with zero duty violation time, use it -- we can't beat that.
							//No need to continue the loop.

							IF li_SleeperMatchIndex > 0 THEN

								IF lstra_Tracking [ li_SleeperMatchIndex + 1 ].ic_DutyViolationTime = 0 THEN

									EXIT

								END IF

							END IF

	
						END IF
	
					NEXT
	
	
					IF li_SleeperMatchIndex > 0 THEN		//We found a match.   Process a Restart
	
//***					Now that we can't CONTINUE due to FMCSA 11-24-03, we have to handle this with li_NextIntervalStartIndex, below.
//						//Set li_Index, (the loop control counter) to 1 position BEFORE the li_NextIntervalStartIndex, 
//						//so that when we CONTINUE, it will be incremented to the li_NextIntervalStartIndex 
//						//(which is the position just after the end of the sleeper interval.)
//						li_Index = lstra_Tracking [ li_SleeperMatchIndex + 1 ].ii_NextIntervalStartIndex - 1

						lb_Reset = TRUE  //Flag that as we enter the beginning of the loop, that we are coming off a reset,
							//and need to reset various flags
						li_NextIntervalStartIndex = lstra_Tracking [ li_SleeperMatchIndex + 1 ].ii_NextIntervalStartIndex

						//Based on FMCSA 11-24-03, flag that we have had at least one split-sleeper reset since the last 
						//full 10-hrs-off reset, so that if we finish with 10 hrs of, that can be paired up with our final
						//sleeper interval.  (If you haven't had at least one split sleeper reset, you can't make this pairing,
						//and any sleeper period counts against the 14 hour rule.)
						
						//Note: This tracking is irrelevant after 10-01-05, because any continuous sleeper period of at least
						//8 hrs does not count against 14 hrs, EVEN if it's by itself, and all other sleeper periods do count 
						//against the 14 hr rule.  However, no harm in setting the flag anyway.
						
						lb_UsingSplitSleeper = TRUE

//***					Can't do this now due to FMCSA 11-24-03.  Formerly, a violation would void a sleeper reset, so
//						by definition could not have a violation with a sleeper reset.  Now, however, a violation does NOT
//						void the sleeper reset, so now we may have a violation, and we have to process it.
//						CONTINUE		//Restart the outer index loop immediately after the sleeper berth interval.
//										//There's no violation, so we can bypass the violation part of the loop.
	
					END IF
	
				END IF
	
			END IF
	
		END IF
			

		//If we're extending a continuous rest period, adjust the total.
		//Otherwise, see if we qualify for a reset.

		CHOOSE CASE ls_CurrentStatus

		CASE gc_Logs.cs_Status_OffDuty, gc_Logs.cs_Status_Sleeper

			lc_ContinuousRest += .25
			
			IF ls_CurrentStatus = gc_Logs.cs_Status_Sleeper THEN
			
				lc_ContinuousSleeper += .25
				
			ELSE
				
				lc_ContinuousSleeper = 0   //** OK to put this here????
				
			END IF

		CASE gc_Logs.cs_Status_Driving, gc_Logs.cs_Status_OnDuty

			IF lc_ContinuousRest >= lc_OffDutyRequirement THEN


				lb_Reset = TRUE
				li_NextIntervalStartIndex = li_Index  //Start from the index we're currently on.

//				This was the beinning of an attempt to see if we should keep looking forward even past the
//				reset to possibly complete a split sleeper berth period, if doing so would keep us out of
//				a violation we would otherwise get.
//
//				I was thinking this was potentially only theoretically relevant anyway, but then FMCSA 11-24-03
//				made this event less relevant.  The only scenario now would be sleeper, 10 off, sleeper, where
//				the first sleeper was by itself and therefore wouldn't qualify without the 2nd.
//
//				IF lstra_Tracking [ 1 ].ic_DrivingViolationTime = 0 AND &
//					lstra_Tracking [ 1 ].ic_DutyViolationTime > 0 AND &
//					li_SleeperCount > 0 THEN
//
//					FOR li_TrackingIndex = li_SleeperCount + 1 TO 2 STEP -1
//				
//						IF lstra_Tracking [ li_TrackingIndex ].ic_DutyViolationTime = 0 THEN
//
//							
//				lb_PendingReset = TRUE
//				ldt_PendingResetIntervalEnd = ldt_PriorDateTime
//				ldt_PendingResetIntervalEndIndex = li_Index - 1

			ELSE

				lc_ContinuousRest = 0
				lc_ContinuousSleeper = 0

			END IF

		CASE ELSE   //Special Log Status

			lb_Reset = TRUE
			li_NextIntervalStartIndex = li_Index + 96		//Start one full day ahead from the index we're currently on.
																		//(Any violation for the special log will be handled on this pass, below.)

		END CHOOSE


		IF lb_Reset = FALSE THEN
	
			//Loop through the baseline tracking interval and all the sleeper tracking intervals, and make the appropriate 
			//adjustments to the total times being tracked in each.
		
			FOR li_TrackingIndex = 1 TO li_SleeperCount + 1   
				//Entry 1 in the array is the baseline, which counts all time, including sleeper berth time, as Duty Time.
				//The total number of entries in the tracking array is always the number of sleeper entries (li_SleeperCount)
				//plus the one baseline entry.
		
				li_SleeperIndex = li_TrackingIndex - 1   //Adjust for the baseline, so we can reference both easily.

		
				IF lb_Post100105 THEN
					
					
					IF ( ls_CurrentStatus = gc_Logs.cs_Status_Sleeper OR ls_CurrentStatus = gc_Logs.cs_Status_OffDuty ) &
						AND li_SleeperIndex = li_SleeperCount THEN
			
						//We're in the last sleeper index (the open one), with Rest Time.
			
						//Tack on this time to this sleeper interval.  
						//Under the new rules, iIt WILL still count against duty time, unless it's part of an 8+ hr block of continuous sleeper.
			
						lstra_Tracking [ li_TrackingIndex ].ic_SleeperInterval += .25
						
						IF lc_ContinuousSleeper > lstra_Tracking [ li_TrackingIndex ].ic_ContinuousSleeper THEN
							lstra_Tracking [ li_TrackingIndex ].ic_ContinuousSleeper = lc_ContinuousSleeper
						END IF
			
					END IF
			
					
					IF ls_CurrentStatus = gc_Logs.cs_Status_Sleeper AND lc_ContinuousSleeper >= 8 THEN
						
						IF lc_ContinuousSleeper = 8 THEN  //We just hit 8 continuous.  Need to deduct 7.75 from ALL running tracking,
																	 //and undo duty limit reached if applicable
																	 
							lstra_Tracking [ li_TrackingIndex ].ic_TotalDutyTime = Max ( lstra_Tracking [ li_TrackingIndex ].ic_TotalDutyTime - 7.75, 0 )

							ll_Test = lnv_DateTime.of_SecondsAfter ( lstra_Tracking [ li_TrackingIndex ].idt_DutyLimitReached, ldt_NextDateTime )
							
							IF ll_Test > 0 AND ll_Test <= 28800 THEN  // <= 8hrs, expressed as seconds, 8 * 60 * 60
							
								lstra_Tracking [ li_TrackingIndex ].idt_DutyLimitReached = ldt_UnspecifiedDateTime   //To maintain consistency, jic, not setting to null.  Setting to the value a datetime variable initializes to, untouched.
								
							END IF
							
							//IF idt_DutyLimitReached is specified and within 7.75 hrs, clear it.
							
						END IF
						
					ELSE

						//In all other circumstances, increment total duty time.
		
						lstra_Tracking [ li_TrackingIndex ].ic_TotalDutyTime += .25
			
						IF lstra_Tracking [ li_TrackingIndex ].ic_TotalDutyTime = lc_DutyTimeLimit THEN
			
							lstra_Tracking [ li_TrackingIndex ].idt_DutyLimitReached = ldt_NextDateTime
							//If ldt_CurrentDateTime is 11:45, we're reaching the limit at the END of this period, ie, 12, or ldt_NextDateTime
			
						END IF
			
					END IF
					
					
				ELSE
		
		
					IF ls_CurrentStatus = gc_Logs.cs_Status_Sleeper AND li_SleeperIndex = li_SleeperCount THEN
			
						//We're in the last sleeper index (the open one), with Sleeper Time.
			
						//Tack on this time to this sleeper interval, and don't count it against the duty time for this tracking index.
			
						lstra_Tracking [ li_TrackingIndex ].ic_SleeperInterval += .25
						
						IF lc_ContinuousSleeper > lstra_Tracking [ li_TrackingIndex ].ic_ContinuousSleeper THEN
							lstra_Tracking [ li_TrackingIndex ].ic_ContinuousSleeper = lc_ContinuousSleeper
						END IF
			
					ELSE
			
						//We're in something other than Sleeper Time for an open sleeper interval.  
						//Count this time against the duty time for this tracking index.
			
						lstra_Tracking [ li_TrackingIndex ].ic_TotalDutyTime += .25
			
						IF lstra_Tracking [ li_TrackingIndex ].ic_TotalDutyTime = lc_DutyTimeLimit THEN
			
							lstra_Tracking [ li_TrackingIndex ].idt_DutyLimitReached = ldt_NextDateTime
							//If ldt_CurrentDateTime is 11:45, we're reaching the limit at the END of this period, ie, 12, or ldt_NextDateTime
			
						END IF
			
					END IF
					
				END IF
		
		
				IF ls_CurrentStatus = gc_Logs.cs_Status_Driving THEN
		
					lstra_Tracking [ li_TrackingIndex ].ic_DrivingTime += .25
		
					CHOOSE CASE lstra_Tracking [ li_TrackingIndex ].ic_DrivingTime
		
					CASE lc_DrivingTimeLimit
		
						lstra_Tracking [ li_TrackingIndex ].idt_DrivingLimitReached = ldt_NextDateTime
						//If ldt_CurrentDateTime is 11:45, we're reaching the limit at the END of this period, ie, 12, or ldt_NextDateTime
		
					CASE IS > lc_DrivingTimeLimit
		

						IF lstra_Tracking [ li_TrackingIndex ].ic_DrivingViolationTime = 0 THEN
							lstra_Tracking [ li_TrackingIndex ].idt_DrivingViolationStart = ldt_CurrentDateTime
						END IF

						lstra_Tracking [ li_TrackingIndex ].ic_DrivingViolationTime += .25
		
					END CHOOSE
		
		
					IF lstra_Tracking [ li_TrackingIndex ].ic_TotalDutyTime > lc_DutyTimeLimit THEN
		
						IF lstra_Tracking [ li_TrackingIndex ].ic_DutyViolationTime = 0 THEN
							lstra_Tracking [ li_TrackingIndex ].idt_DutyViolationStart = ldt_CurrentDateTime
						END IF

						lstra_Tracking [ li_TrackingIndex ].ic_DutyViolationTime += .25
		
					END IF
		
				END IF
		
			NEXT

		END IF


		IF lb_Reset = TRUE OR li_Index = li_End THEN

			li_TrackingIndexToUse = 1  //Use the baseline tracking index unless determined differently.


			//If we determined a split sleeper match above and are resetting because of it, use it.

			IF li_SleeperMatchIndex > 0 THEN

				li_TrackingIndexToUse = li_SleeperMatchIndex + 1   //Add one to allow for the baseline which is entry 1

			//BECAUSE it's a reset, lc_ContinuousRest is still populated, and can be used in this logic.
			//If it's not a reset, it gets cleared when status goes off the continuous rest period.

			ELSEIF lc_ContinuousRest >= lc_OffDutyRequirement AND lb_UsingSplitSleeper = TRUE THEN

				//We've had a full rest period, and we were using split sleeper (ie, we had at least one split sleeper
				//reset during the interval following the previous full rest period.)  So, this full rest period can 
				//be paired with a sleeper period just as if we had gotten a 2nd sleeper period, and the sleeper period
				//would not count against the 14 hr rule.  So, if we have a duty time violation in the baseline tracking
				//(the one that counts all sleeper against the 14 hr rule) then we need to check if we have an eligibile 
				//sleeper period that we can use that reduces or eliminates this violation.

				//This provision does NOT apply Post100105 because only 8hr+ continuous sleeper blocks can be deducted from 
				//duty time, and those are ALWAYS (and therefore ALREADY) deducted under the new rules.

				IF lstra_Tracking [ li_TrackingIndexToUse ].ic_DutyViolationTime > 0 AND lb_Post100105 = FALSE THEN

					FOR li_TrackingIndex = li_SleeperCount + 1 TO 2 STEP -1  //If li_SleeperCount is 0, does not enter the loop

						IF lstra_Tracking [ li_TrackingIndex ].ic_DutyViolationTime < lstra_Tracking [ li_TrackingIndexToUse ].ic_DutyViolationTime THEN

							li_TrackingIndexToUse = li_TrackingIndex

						END IF

					NEXT

				END IF


				//Regardless of what was determined above, now that we've had a full 10 hrs off, we'll need to re-establish
				//sleeper usage in the next cycle if we want to be eligible for a sleeper - off duty trip end combo.
				//Therefore, clear the flag.

				lb_UsingSplitSleeper = FALSE

			END IF	



			IF lstra_Tracking [ li_TrackingIndexToUse ].ic_DrivingViolationTime > 0 THEN

				//CREATE DRIVING VIOLATION

				li_ViolationCount ++

				lstra_Violations [ li_ViolationCount ].ii_ViolationType = gc_Logs.ci_ViolationType_DrivingTime
				lstra_Violations [ li_ViolationCount ].idt_LimitReached = lstra_Tracking [ li_TrackingIndexToUse ].idt_DrivingLimitReached
				lstra_Violations [ li_ViolationCount ].idt_ViolationStart = lstra_Tracking [ li_TrackingIndexToUse ].idt_DrivingViolationStart
				lstra_Violations [ li_ViolationCount ].ic_ViolationTime = lstra_Tracking [ li_TrackingIndexToUse ].ic_DrivingViolationTime

			END IF


			IF lstra_Tracking [ li_TrackingIndexToUse ].ic_DutyViolationTime > 0 THEN

				//Create Duty Violation

				li_ViolationCount ++

				lstra_Violations [ li_ViolationCount ].ii_ViolationType = gc_Logs.ci_ViolationType_DutyTime
				lstra_Violations [ li_ViolationCount ].idt_LimitReached = lstra_Tracking [ li_TrackingIndexToUse ].idt_DutyLimitReached
				lstra_Violations [ li_ViolationCount ].idt_ViolationStart = lstra_Tracking [ li_TrackingIndexToUse ].idt_DutyViolationStart
				lstra_Violations [ li_ViolationCount ].ic_ViolationTime = lstra_Tracking [ li_TrackingIndexToUse ].ic_DutyViolationTime

			END IF


			//Handle the special log statuses.

			CHOOSE CASE ls_CurrentStatus

			CASE gc_Logs.cs_Status_Lost

				//Create lost log violation

				li_ViolationCount ++

				lstra_Violations [ li_ViolationCount ].ii_ViolationType = gc_Logs.ci_ViolationType_LostLog
				lstra_Violations [ li_ViolationCount ].idt_LimitReached = ldt_CurrentDateTime
				lstra_Violations [ li_ViolationCount ].idt_ViolationStart = ldt_CurrentDateTime
				lstra_Violations [ li_ViolationCount ].ic_ViolationTime = 24 //Hrs.

				//li_Index += 95  //It'll get advanced one more (96 from where it is now) by the NEXT statement

			CASE gc_Logs.cs_Status_AirRadius

				//Check if there's an air radius violation.

				//Build find string.  Using DaysAfter to avoid any problem with hidden time component.
				ls_Find = "DaysAfter ( dl_date, " + String ( Date ( ldt_CurrentDateTime ), "yyyy-mm-dd" ) + " ) = 0"
				//Instead of:  ls_Find = "dl_date = " + String ( Date ( ldt_CurrentDateTime ), "yyyy-mm-dd" )
				li_Row = ldw_Logs.Find ( ls_Find, 1, li_LogCount )

				IF li_Row > 0 THEN

					lc_OnDutyTotal = ldw_Logs.GetItemNumber ( li_Row, "dl_odtot" )

					IF lc_OnDutyTotal > li_AirRadiusLimitHours THEN

						//Create Air Radius violation
		
						li_ViolationCount ++
		
						lstra_Violations [ li_ViolationCount ].ii_ViolationType = gc_Logs.ci_ViolationType_AirRadius
						lstra_Violations [ li_ViolationCount ].idt_LimitReached = ldt_CurrentDateTime
						lstra_Violations [ li_ViolationCount ].idt_ViolationStart = ldt_CurrentDateTime
						lstra_Violations [ li_ViolationCount ].ic_ViolationTime = lc_OnDutyTotal - li_AirRadiusLimitHours

					END IF

				ELSE

					//Could not find the row.

					ls_ErrorMessage = "Processing Error:  Could not identify row for Air Radius Violation."
					li_Return = -1

					EXIT

				END IF

			CASE gc_Logs.cs_Status_Startup
				//No action necessary.  No violations for this status.

			CASE gc_Logs.cs_Status_New
				//No action necessary.  No violations for this status.

			END CHOOSE


			//If we've just come off a special log, see if we need to roll the start of the next period further 
			//forward because the next log begins with rest time.  The next period should begin with OnDuty or Driving.

			CHOOSE CASE ls_CurrentStatus

			CASE gc_Logs.cs_Status_Lost, gc_Logs.cs_Status_AirRadius, gc_Logs.cs_Status_Startup, gc_Logs.cs_Status_New

				FOR li_Check = li_NextIntervalStartIndex TO li_End

					CHOOSE CASE Mid ( ls_CombinedLog, li_Check, 1 )

					CASE gc_Logs.cs_Status_OffDuty, gc_Logs.cs_Status_Sleeper

						li_NextIntervalStartIndex ++

					CASE ELSE

						//Another status encountered, stop rolling forward.
						EXIT

					END CHOOSE

				NEXT

			END CHOOSE

		END IF


		//If we're processing a reset, adjust li_Index to li_NextIntervalStartIndex - 1 so that it will start where intended when incremented by NEXT

		IF lb_Reset = TRUE THEN

			IF li_NextIntervalStartIndex > 0 THEN
				li_Index = li_NextIntervalStartIndex - 1  //Set to NISI - 1 so that it will be correct when incremented by NEXT
				li_NextIntervalStartIndex = 0  //Clear it for the next potential use, so this would error if not set.
			ELSE
				ls_ErrorMessage = "Processing Error:  No start index specified on reset."
				li_Return = -1
				EXIT
			END IF

		END IF
	
	NEXT
	

END IF


//*************************************************************************************
//TESTING DIALOG ONLY -- COMMENT FOR REAL.

//String	ls_Test, ls_TestMessage
//
//ls_TestMessage = String ( li_ViolationCount ) + " Violations~n"
//
//FOR li_Index = 1 TO li_ViolationCount
//
//	ls_Test = String ( lstra_Violations [ li_Index ].ii_ViolationType ) + ": "
//	ls_Test += String ( lstra_Violations [ li_Index ].idt_LimitReached ) + ", "
//	ls_Test += String ( lstra_Violations [ li_Index ].idt_ViolationStart ) + ", "
//	ls_Test += String ( lstra_Violations [ li_Index ].ic_ViolationTime ) + "~n"
//
//	ls_TestMessage += ls_Test
//
//NEXT
//
//MessageBox ( String (li_StartRow ) + " NEW HOS " + String ( li_Return ), ls_TestMessage )

//*************************************************************************************


IF li_Return = 1 THEN

	//Even if there's no violations, we need to call wf_ViolationsRecord, because there may be existing
	//violations that now need to be cleared.

	//We want to use ad_StartDate NOT ld_CombinedStartDate because we are only getting full violations
	//checking from ad_StartDate forward, and so that is the date we need to clear and replace from
	//in wf_ViolationsRecord.  Any violations we happened to encounter prior to ad_StartDate in the
	//course of this check should be unchanged from the existing data and therefore will be ignored in
	//wf_ViolationsRecord.

	This.wf_ViolationsRecord ( ad_StartDate, lstra_Violations )

END IF

/*

*****************************************************************************************************



Have a sleeper array.


[0] means counting none of the sleeper events (if any), where do we stand
[1-n] means counting the nth sleeper event, where do we stand.  This way, when we hit another sleeper 
		event that can put us over the top with one (or more) of these prior sleeper events, we can 
		see which one we want to combine it with, and then restart the clock 

*/


RETURN li_Return


end function

public function integer wf_violationsrecord (date ad_impactstartdate, os_violation astra_violations[]);Integer	li_ReplacementRowCount, &
			li_FirstReplacementRow, &
			li_NewViolationArrayCount, &
			li_MaxViolationNumber, &
			li_Row, &
			li_NewRow, &
			li_ViolationType, &
			li_CheckType, &
			li_Index, &
			li_OldViolationsRowCount

Long		ll_DriverId

Date		ld_ReplacementStartDate, &
			ld_ViolationDate

String	ls_Description, &
			ls_Find

DataStore	lds_Violations, &
				lds_OldViolations

Constant Date		cd_NewHOSStart = 2004-01-04

Constant Integer	li_DrivingLimitHours = 11  //11 hrs
Constant Integer	li_OnDutyLimitHours = 14  //14 hrs CONSECUTIVE FROM START OF ON DUTY PERIOD (used to be CUMULATIVE)
Constant Integer	li_AirRadiusLimitHours = 12  //12 hrs.


Integer	li_Return = 1


//MessageBox ( "Testing", "Starting wf_ViolationsRecord" )  //TESTING ONLY

IF li_Return  = 1 THEN

	ll_DriverId = This.wf_GetCurrentDriverId ( )

	li_NewViolationArrayCount = UpperBound ( astra_Violations )

	lds_Violations = ds_Violations  //ds_Violations is an instance variable.
	li_ReplacementRowCount = lds_Violations.RowCount ( )


	//Determine ld_ReplacementStartDate.  This is the date from which any existing violations in the datastore
	//of relevant type will be replaced by the new violations we have generated.

	IF ad_ImpactStartDate < cd_NewHOSStart THEN

		ld_ReplacementStartDate = cd_NewHOSStart

	ELSE

		ld_ReplacementStartDate = ad_ImpactStartDate

	END IF


	//****IS THIS RIGHT?  OR SHOULD THIS BE <= LOCKDATE   >>>  = RelativeDate ( lockdate, 1 )

	IF ld_ReplacementStartDate < lockdate THEN   //lockdate is an instance variable.

		ld_ReplacementStartDate = lockdate

	END IF

END IF


IF li_Return = 1 AND li_ReplacementRowCount > 0 THEN

	li_FirstReplacementRow = lds_Violations.Find ( "dv_date >= " + String ( ld_ReplacementStartDate, "yyyy-mm-dd" ), &
		1, li_ReplacementRowCount )

END IF


IF li_Return = 1 AND li_FirstReplacementRow > 0 THEN


	lds_OldViolations = CREATE DataStore
	lds_OldViolations.DataObject = lds_Violations.DataObject
	lds_OldViolations.SetTransObject ( SQLCA )

	lds_Violations.RowsCopy ( li_FirstReplacementRow, li_ReplacementRowCount, Primary!, &
		lds_OldViolations, 9999, Primary! )

	li_OldViolationsRowCount = lds_OldViolations.RowCount ( )



	FOR li_Row = li_ReplacementRowCount TO li_FirstReplacementRow STEP -1

//		if lds_Violations.getitemdate(li_Row, "dv_date") <> ld_LogDate then CONTINUE
//		if lds_Violations.getitemdate(li_Row, "dv_date") < lockdate then CONTINUE
		
		li_CheckType = lds_Violations.GetItemNumber ( li_Row, "dv_type" )
		
		CHOOSE CASE li_CheckType 

		CASE gc_Logs.ci_ViolationType_DrivingTime, gc_Logs.ci_ViolationType_DutyTime, &
			gc_Logs.ci_ViolationType_LostLog, gc_Logs.ci_ViolationType_AirRadius
			
//			if lds_Violations.getitemstring(li_Row, "dv_excused") = "T" or &
//				len(trim(lds_Violations.getitemstring(li_Row, "dv_reason"))) > 0 then
//			 
//				li_SetIndex ++
//				
//				lstra_OldViolations[li_SetIndex].vdesc = lds_Violations.getitemstring(li_Row, "dv_desc")
//				lstra_OldViolations[li_SetIndex].reason = lds_Violations.getitemstring(li_Row, "dv_reason")
//				lstra_OldViolations[li_SetIndex].ex = lds_Violations.getitemstring(li_Row, "dv_excused")
//				lstra_OldViolations[li_SetIndex].whoex = lds_Violations.getitemstring(li_Row, "dv_who_ex")
//				lstra_OldViolations[li_SetIndex].vtype = lds_Violations.getitemnumber(li_Row, "dv_type")
//				
//			end if 
			
			lds_Violations.DeleteRow ( li_Row )				
			
		CASE ELSE
			
			li_MaxViolationNumber = Max ( lds_Violations.GetItemNumber ( li_Row, "dv_num" ), li_MaxViolationNumber )
			
		END CHOOSE
		
	NEXT

	li_MaxViolationNumber ++

END IF




IF li_Return = 1 AND li_NewViolationArrayCount > 0 THEN

	FOR li_Index = 1 TO li_NewViolationArrayCount

		ld_ViolationDate = Date ( astra_Violations [ li_Index ].idt_ViolationStart )
		li_ViolationType = astra_Violations [ li_Index ].ii_ViolationType

		ls_Description = ""
		ls_Find = ""

		IF DaysAfter ( ld_ReplacementStartDate, ld_ViolationDate ) < 0 THEN
			CONTINUE
		END IF


		CHOOSE CASE li_ViolationType

		CASE gc_Logs.ci_ViolationType_DrivingTime, gc_Logs.ci_ViolationType_DutyTime

			//There are two syntaxes here, depending on whether the driver hits the limit and the violation starts
			//immediately thereafter, or if he hits the limit and the violation begins later.

			//Examples of both syntaxes:
			//"On 1/20/04 at 2:00 PM driver reached the 11 Hour Driving Limit and proceeded to drive 3.25 hours beyond the limit."
			//"...and proceeded to drive 3.25 hours beyond the limit, beginning on 1/20/04 at 4:15 PM."

			//Note:  The limit can be reached on the day prior to when the violation starts, which is covered by including
			//the dates in the description.  Prior to 1/4/04 this was worded differently, referencing "previous day".
			//The logic is simpler this way and the violation description stands on its own better.
			

			ls_Description = "On " + This.wf_GetFormattedDateTime ( astra_Violations [ li_Index ].idt_LimitReached )
			ls_Description += " driver reached the "

			CHOOSE CASE li_ViolationType

			CASE gc_Logs.ci_ViolationType_DrivingTime
				ls_Description += String ( li_DrivingLimitHours, "0" ) + " Hour Driving Limit"

			CASE gc_Logs.ci_ViolationType_DutyTime
				ls_Description += String ( li_OnDutyLimitHours, "0" ) + " Hour On-Duty Limit"

			END CHOOSE

			ls_Description += " and proceeded to drive " + String ( astra_Violations [ li_Index ].ic_ViolationTime, "0.00" )
			ls_Description += " hours beyond the limit"

			IF astra_Violations [ li_Index ].idt_ViolationStart > astra_Violations [ li_Index ].idt_LimitReached THEN

				ls_Description += ", beginning on " + This.wf_GetFormattedDateTime ( astra_Violations [ li_Index ].idt_ViolationStart )

			END IF

			ls_Description += "."

//**		TESTING CODE -- CAN BE DELETED.
//			ls_Description = String ( astra_Violations [ li_Index ].ii_ViolationType ) + ": "
//			ls_Description += String ( astra_Violations [ li_Index ].idt_LimitReached ) + ", "
//			ls_Description += String ( astra_Violations [ li_Index ].idt_ViolationStart ) + ", "
//			ls_Description += String ( astra_Violations [ li_Index ].ic_ViolationTime ) + "~n"


		CASE gc_Logs.ci_ViolationType_LostLog
			ls_Description = "Driver did not turn in a log for " + String ( astra_Violations [ li_Index ].idt_ViolationStart, "m/d/yy" ) + "."

		CASE gc_Logs.ci_ViolationType_AirRadius   //**ARE WE GOING TO GENERATE THIS ONE???  THIS IS THE OLD CODE.
//			ls_Description = "Driver exceeded the " + String ( li_AirRadiusHoursLimit ) + " hour 100 Air-Mile Radius rule.  The " +&
//				"driver exceed the limit by " + string(lc_OnDutyTotal - li_AirRadiusHoursLimit, "0.00") + ls_ViolationTimeLabel 

			ls_Description = "Driver exceeded the " + String ( li_AirRadiusLimitHours ) +& 
				" hour On-Duty Limit for the 100 Air-Mile Radius Rule by " +& 
				String ( astra_Violations [ li_Index ].ic_ViolationTime, "0.00" ) + " hours."

		CASE ELSE  //Unexpected Type Value
			CONTINUE  //FAIL??

		END CHOOSE


		li_NewRow = lds_Violations.InsertRow ( 0 )

		lds_Violations.setitem(li_NewRow, "dv_id", ll_DriverId)
		lds_Violations.setitem(li_NewRow, "dv_date", ld_ViolationDate)
		lds_Violations.setitem(li_NewRow, "dv_num", li_MaxViolationNumber)
		lds_Violations.setitem(li_NewRow, "dv_type", li_ViolationType)
		lds_Violations.setitem(li_NewRow, "dv_desc", ls_Description)


		ls_Find = "DaysAfter ( " + String ( ld_ViolationDate, "yyyy-mm-dd" ) + ", dv_date ) = 0 AND "+&
			"dv_type = " + String ( li_ViolationType ) + " AND dv_excused = 'T'"


		CHOOSE CASE li_ViolationType

		CASE gc_Logs.ci_ViolationType_DrivingTime, gc_Logs.ci_ViolationType_DutyTime

			//For Driving and Duty Time Violations, if it's not exactly the same violation, don't match it up.
			ls_Find += " AND dv_desc = '" + ls_Description + "'"

		END CHOOSE


		IF li_OldViolationsRowCount > 0 THEN

			li_Row = lds_OldViolations.Find ( ls_Find, 1, li_OldViolationsRowCount )

			IF li_Row > 0 THEN
	
				lds_Violations.setitem(li_NewRow, "dv_excused", lds_OldViolations.GetItemString ( li_Row, "dv_excused" ) )
				lds_Violations.setitem(li_NewRow, "dv_reason", lds_OldViolations.GetItemString ( li_Row, "dv_reason" ) )
				lds_Violations.setitem(li_NewRow, "dv_who_ex", lds_OldViolations.GetItemString ( li_Row, "dv_who_ex" ) )
	
			END IF

		END IF

		
		li_MaxViolationNumber ++

	NEXT

END IF


/*
// ********************************************************************************	
	
	IF lb_LostOr100 = TRUE THEN
		
		if li_ViolationIndex = 0 then CONTINUE
		
		choose case lstra_Violations[1].the_type
		
		case 7 
			ls_Violation = "Driver did not turn in a log for this day."
			
		case 8
			if dec(lc_OnDutyTotal - li_AirRadiusHoursLimit) = 1 then 
				ls_ViolationTimeLabel = " hour."
			else
				ls_ViolationTimeLabel = " hours."
			end if
			
			ls_Violation = "Driver exceeded the " + String ( li_AirRadiusHoursLimit ) + " hour 100 Air-Mile Radius rule.  The " +&
				"driver exceed the limit by " + string(lc_OnDutyTotal - li_AirRadiusHoursLimit, "0.00") + ls_ViolationTimeLabel 
					
		end choose
		
		li_NewRow = ds_violations.insertrow(0)
		
		ds_violations.setitem(li_NewRow, "dv_id", ll_DriverId)
		ds_violations.setitem(li_NewRow, "dv_date", ld_LogDate)
		ds_violations.setitem(li_NewRow, "dv_num", li_MaxViolationNumber)
		ds_violations.setitem(li_NewRow, "dv_type", lstra_Violations[1].the_type)
		ds_violations.setitem(li_NewRow, "dv_desc", ls_Violation)
		
		li_MaxViolationNumber ++
		
		if li_SetIndex > 0 then
		
			for li_Loop1 = 1 to li_SetIndex
		
				if ( lstra_Violations[1].the_type = 8 and lstra_OldViolations[li_Loop1].vtype = lstra_Violations[1].the_type ) or &
					( lstra_Violations[1].the_type = 7 and lstra_OldViolations[li_Loop1].vdesc = ls_Violation) then
					
					ds_violations.setitem(li_NewRow, "dv_excused", lstra_OldViolations[li_Loop1].ex)
					ds_violations.setitem(li_NewRow, "dv_reason", lstra_OldViolations[li_Loop1].reason)
					ds_violations.setitem(li_NewRow, "dv_who_ex", lstra_OldViolations[li_Loop1].whoex)
					
				end if
				
			next
			
		end if
		
	ELSEIF li_ViolationIndex > 0 THEN
	
		for li_Loop1 = 1 to li_ViolationIndex
		
			if lstra_Violations[li_Loop1].the_type = 2 then  //On Duty Violation
				
				if lstra_Violations[li_Loop1].the_time + lstra_Violations[li_Loop1].howbad <= 97 then continue
				
				if lstra_Violations[li_Loop1].the_time > 96 then                  
					lstra_Violations[li_Loop1].the_time = lstra_Violations[li_Loop1].the_time - 96
					lb_PreviousDayStart = FALSE
				else
					lb_PreviousDayStart = TRUE
				end if
			
				if lstra_Violations[li_Loop1].limit > 96 then
					lstra_Violations[li_Loop1].limit = lstra_Violations[li_Loop1].limit - 96
					lb_PreviousDayLimit = FALSE
				else
					lb_PreviousDayLimit = TRUE
				end if
			
			
				ls_LimitReached = string(reltime_ext(string(lt_FixerStart), lstra_Violations[li_Loop1].limit * 900), &
					"h:mm AM/PM")
					
				ls_ViolationStart = string(reltime_ext(string(lt_FixerStart), (lstra_Violations[li_Loop1].the_time - 1) * &
					 900), "h:mm AM/PM")
					 
				ls_ViolationLength = string(lstra_Violations[li_Loop1].howbad / 4.0, "0.00")
			
				if ls_LimitReached = ls_ViolationStart then lb_SameTime = TRUE else lb_SameTime = FALSE
			
			// tttttttttttttttttttttttTTTTTTTTTTTTTTTTTTTTttttttttttttttttt description stuff
			
				if lb_PreviousDayLimit = TRUE then
					ls_V1 = "At " + ls_LimitReached + " of previous day, driver reached "
				else
					ls_V1 = "At " + ls_LimitReached + " driver reached "
				end if
				
				ls_V2 = String ( li_OnDutyLimitHours ) + " hour on duty limit"
				
				if li_Loop1 > 1 then 
					for li_Loop2 = (li_Loop1 - 1) to 1 step -1
						if lstra_Violations[li_Loop2].the_type = 2 then 
		//					ls_V2 += " again"
							exit
						end if
					next
				end if
		
				if dec(ls_ViolationLength) = 1 then
					ls_ViolationTimeLabel = " hour" 
				else 
					ls_ViolationTimeLabel = " hours"
				end if
				
				ls_V4 = "proceeded to drive " + ls_ViolationLength + ls_ViolationTimeLabel + " beyond the limit"
		
				if lb_SameTime = TRUE then
					ls_V3 = " and " + ls_V4 + "."
				elseif lb_PreviousDayStart = TRUE then
					ls_V3 = ".  At " + ls_ViolationStart + " of previous day, driver " + ls_V4 + " into the current day."
				else
					ls_V3 = ".  At " + ls_ViolationStart + " driver " + ls_V4 + "."
				end if
		
				ls_Violation = ls_V1 + ls_V2 + ls_V3
				
			else //driving hours violation
				
				if lstra_Violations[li_Loop1].the_time + lstra_Violations[li_Loop1].howbad <= 97 then continue
				
				if lstra_Violations[li_Loop1].the_time > 96 then                  
					lstra_Violations[li_Loop1].the_time = lstra_Violations[li_Loop1].the_time - 96
					lb_PreviousDayStart = FALSE
				else
					lb_PreviousDayStart = TRUE
				end if
			
				if lstra_Violations[li_Loop1].limit > 96 then
					lstra_Violations[li_Loop1].limit = lstra_Violations[li_Loop1].limit - 96
					lb_PreviousDayLimit = FALSE
				else
					lb_PreviousDayLimit = TRUE
				end if
			
			
				ls_LimitReached = string(reltime_ext(string(lt_FixerStart), lstra_Violations[li_Loop1].limit * 900), &
					"h:mm AM/PM")
					
				ls_ViolationStart = string(reltime_ext(string(lt_FixerStart), (lstra_Violations[li_Loop1].the_time - 1) * &
					 900), "h:mm AM/PM")
					 
				ls_ViolationLength = string(lstra_Violations[li_Loop1].howbad / 4.0, "0.00")
			
				if ls_LimitReached = ls_ViolationStart then
					lb_SameTime = TRUE 
				else 
					lb_SameTime = FALSE
				end if
			
			// tttttttttttttttttttttttTTTTTTTTTTTTTTTTTTTTttttttttttttttttt description stuff
			
				if lb_PreviousDayLimit = TRUE then
					ls_V1 = "At " + ls_LimitReached + " of previous day, driver reached "
				else
					ls_V1 = "At " + ls_LimitReached + " driver reached "
				end if
				
				ls_V2 = String ( li_DrivingLimitHours )  + " hour driving limit"
				
				if li_Loop1 > 1 then 
					for li_Loop2 = (li_Loop1 - 1) to 1 step -1
						if lstra_Violations[li_Loop2].the_type = 1 then 
		//					ls_V2 += " again"
							exit
						end if
					next
				end if
				
				if dec(ls_ViolationLength) = 1 then 
					ls_ViolationTimeLabel = " hour"	
				else 
					ls_ViolationTimeLabel = " hours"
				end if
				
				ls_V4 = "proceeded to drive " + ls_ViolationLength + ls_ViolationTimeLabel + " beyond the limit"
		
				if lb_SameTime = TRUE then
					ls_V3 = " and " + ls_V4 + "."
				elseif lb_PreviousDayStart = TRUE then
					ls_V3 = ".  At " + ls_ViolationStart + " of previous day, driver " + ls_V4 + " into the current day."
				else
					ls_V3 = ".  At " + ls_ViolationStart + " driver " + ls_V4 + "."
				end if
		
				ls_Violation = ls_V1 + ls_V2 + ls_V3
				
			end if
			
			//---------------------------------------------------------------- set in datatstore
		
			li_NewRow = ds_violations.insertrow(0)
			
			ds_violations.setitem(li_NewRow, "dv_id", ll_DriverId)
			ds_violations.setitem(li_NewRow, "dv_date", ld_LogDate)
			ds_violations.setitem(li_NewRow, "dv_num", li_MaxViolationNumber)
			ds_violations.setitem(li_NewRow, "dv_type", lstra_Violations[li_Loop1].the_type)
			ds_violations.setitem(li_NewRow, "dv_desc", ls_Violation)
			
			for li_Loop2 = 1 to li_SetIndex
				
				if lstra_OldViolations[li_Loop2].vdesc = ls_Violation then
					
					ds_violations.setitem(li_NewRow, "dv_excused", lstra_OldViolations[li_Loop2].ex)
					ds_violations.setitem(li_NewRow, "dv_reason", lstra_OldViolations[li_Loop2].reason)
					ds_violations.setitem(li_NewRow, "dv_who_ex", lstra_OldViolations[li_Loop2].whoex)
					
				end if
				
			next
			
			li_MaxViolationNumber ++
			
		next
		
	END IF


// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ end of loop for insertion
END IF

*/


/*	NEW HOS RULES PROCESSING ADDED 11-21-03 BKW */

/*
IF lb_ViosMovedToFilter = TRUE THEN   //Post 1/1/04 violations were moved to filter.  Move them back.

	//Will this be a problem if they had post 1/1/04 logs with violations, and then deleted them all??
	//Would that result in the violations being there without the logs??

	li_ViosMoveRowCount = ds_Violations.RowCount ( )

	ds_Violations.RowsMove ( li_ViosMoveFilteredCount + 1, li_ViosMoveFilteredCount + li_ViosMovedCount, Filter!, &
		ds_Violations, li_ViosMoveRowCount + 1, Primary! )

END IF


*/

DESTROY lds_OldViolations

RETURN li_Return
end function

public function long wf_getcurrentdriverid ();RETURN cur_driver.em_id
end function

private function string wf_getformatteddatetime (datetime adt_target);//Format a datetime value for use in violations description.

String	ls_Result

ls_Result = String ( adt_Target, "m/d/yy" ) + " at " + String ( adt_Target, "h:mm AM/PM" )

RETURN ls_Result
end function

event open;IF NOT gnv_App.of_Getprivsmanager( ).of_Useadvancedprivs( ) THEN
	if g_privs.log[1] = 0 then 
		messagebox("Driver Logs", "Your current user privileges do not allow you " +&
		"to view driver logs.", exclamation!)
		close(this)
		return
	end if
END IF
 
//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock (n_cst_constants.cs_module_LogAudit, "E") < 0 THEN
	close (this)
	return
END IF

gf_mask_menu(m_log)

minmph = 20 
maxmph = 55    
dw_log.settransobject(sqlca)
dw_log_list.settransobject(sqlca)
dw_vios_daily.settransobject(sqlca)
ds_vios_daily_print.settransobject(sqlca)

cur_driver.em_ln = ""
cur_driver.em_fn = ""   
cur_driver.em_id = null_long

this.x = 1
this.y = 1
this.height = min(dw_log.y + dw_log.height + 131, g_max_h)
this.width = g_max_w
dw_vios_daily.x = 1047
dw_vios_daily.y = 333

setface(0)
dw_vios_daily.visible = false

gb_date.text = string(today(), "m/d/yy") + "  " + dayname(today())

xfix = integer(dw_log.describe("r_logbox.x"))
yfix = integer(dw_log.describe("r_logbox.y"))

ds_violations = CREATE datastore 
ds_violations.DataObject = "d_vios_list"
ds_violations.SetTransObject(sqlca)

ds_receipts = create datastore 
ds_receipts.dataobject = "d_log_receipts"  
ds_receipts.settransobject(sqlca)

ds_drivers = create datastore 
ds_drivers.dataobject = "d_driver_list" 
ds_drivers.settransobject(sqlca)

dw_log_list.object.st_print.text = "off"

if ds_drivers.retrieve() = -1 then
	rollback ;
	goto close_window
else 
	commit ;
end if

integer wherepos, lenpos, npos
string selstr, modstring

selstr = dw_log_list.describe("datawindow.table.select")
wherepos = pos(selstr, "WHERE")
lenpos = len(selstr)

modstring = "  WHERE ( ~~~"driver_logs~~~".~~~"dl_id~~~" = :driver_id ) order by dl_date"

selstr = replace(selstr, wherepos, lenpos - wherepos - 1, modstring)

npos = pos(selstr, "'n'")
selstr = replace(selstr, npos, 3, "~~'n~~'")
dw_log_list.modify("datawindow.table.select = '" + selstr + "'")

set_choose_emp()

string failnote
if f_log_settings(failnote, settings) = -1 then goto close_window

select ss_long into :minmph from system_settings where ss_id = 10010 ;
if sqlca.sqlcode = 0 then
	commit ;
	if isnull(minmph) or minmph = 0 then minmph = 20
elseif sqlca.sqlcode = 100 then
	commit ;
	minmph = 20
else
	rollback ;
	goto close_window
end if

select ss_long into :maxmph from system_settings where ss_id = 10011 ;
if sqlca.sqlcode = 0 then
	commit ;
	if isnull(maxmph) or maxmph = 0 then maxmph = 55
elseif sqlca.sqlcode = 100 then
	commit ;
	maxmph = 55
else
	rollback ;
	goto close_window
end if

integer lcv
st_inpt[1] = st_insert1
st_inpt[2] = st_insert2
st_inpt[3] = st_insert3
st_inpt[4] = st_insert4
st_inpt[5] = st_insert5
st_inpt[6] = st_insert6
st_inpt[7] = st_insert7

for lcv = 1 to 7
	st_inpt[lcv].visible = false
	st_inpt[lcv].x = dw_log_list.x - st_inpt[lcv].width
next
st_type.text = ""

select ss_long into :lockopt from system_settings where ss_id = 10002 ;
if sqlca.sqlcode <> 0 then 
	rollback ;
	goto close_window
else
	commit ;
end if
if lockopt > 0 then 
	select ss_long into :lockopt from system_settings where ss_id = 10003 ;
	if sqlca.sqlcode <> 0 then 
		rollback ;
		goto close_window
	else
		commit ;
	end if
end if

uo_codriver.enabled = false
menu_setup()

return

//------------------------------------------------cannot open window
close_window:

messagebox("Log Entry", "Could not retrieve information required to open this window.", exclamation!)
close(this)
return



end event

event closequery;integer reply, choice
rowsmod()
if indx <> 0 and g_privs.log[3] = 1 then
	this.setfocus()
	this.show()
	if settings.autosave = 1 then goto skiptosave
	choose case messagebox("Log Entry","Save changes before closing?", question!, &
					yesnocancel!, 1)
	case 1
		skiptosave:
		string failnote
		choose case calc_and_save(failnote)
		case -1
			if messagebox("Save Changes", "Could not save changes to database.~n~nPress OK to abandon changes and " +&
				"close window.  Press Cancel to return to window and preserve changes for now.",&
				exclamation!, okcancel!, 2) = 2 then return 1
		case 99
			return 1 
		end choose
	case 3
		return 1
	end choose
end if

win_is_closing = true
uo_choose_emp.sle_name.text = ""

end event

on w_log.create
if this.MenuName = "m_log" then this.MenuID = create m_log
this.st_noprivs=create st_noprivs
this.ds_vios_daily_print=create ds_vios_daily_print
this.uo_choose_emp=create uo_choose_emp
this.cb_settings=create cb_settings
this.cb_daily=create cb_daily
this.cb_list_print=create cb_list_print
this.cb_log_print=create cb_log_print
this.st_lock=create st_lock
this.st_type=create st_type
this.dw_vios_daily=create dw_vios_daily
this.dw_log_list=create dw_log_list
this.dw_miles=create dw_miles
this.uo_codriver=create uo_codriver
this.dw_vios_short=create dw_vios_short
this.gb_date=create gb_date
this.st_insert6=create st_insert6
this.st_insert1=create st_insert1
this.st_insert2=create st_insert2
this.st_insert3=create st_insert3
this.st_insert4=create st_insert4
this.st_insert5=create st_insert5
this.st_insert7=create st_insert7
this.st_vios=create st_vios
this.dw_log=create dw_log
this.Control[]={this.st_noprivs,&
this.ds_vios_daily_print,&
this.uo_choose_emp,&
this.cb_settings,&
this.cb_daily,&
this.cb_list_print,&
this.cb_log_print,&
this.st_lock,&
this.st_type,&
this.dw_vios_daily,&
this.dw_log_list,&
this.dw_miles,&
this.uo_codriver,&
this.dw_vios_short,&
this.gb_date,&
this.st_insert6,&
this.st_insert1,&
this.st_insert2,&
this.st_insert3,&
this.st_insert4,&
this.st_insert5,&
this.st_insert7,&
this.st_vios,&
this.dw_log}
end on

on w_log.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_noprivs)
destroy(this.ds_vios_daily_print)
destroy(this.uo_choose_emp)
destroy(this.cb_settings)
destroy(this.cb_daily)
destroy(this.cb_list_print)
destroy(this.cb_log_print)
destroy(this.st_lock)
destroy(this.st_type)
destroy(this.dw_vios_daily)
destroy(this.dw_log_list)
destroy(this.dw_miles)
destroy(this.uo_codriver)
destroy(this.dw_vios_short)
destroy(this.gb_date)
destroy(this.st_insert6)
destroy(this.st_insert1)
destroy(this.st_insert2)
destroy(this.st_insert3)
destroy(this.st_insert4)
destroy(this.st_insert5)
destroy(this.st_insert7)
destroy(this.st_vios)
destroy(this.dw_log)
end on

event close;close(w_printchild)
destroy ds_violations
destroy ds_receipts
destroy ds_drivers

//if isvalid(ds_vios_daily_print) then destroy ds_vios_daily_print



end event

event clicked;dw_losefocus() 
dw_log.setredraw(true)
dw_log.setfocus()

end event

event mousemove;if editmode <> "insert" then return

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

for lcv = 1 to sched_type - 1
	if ypos >= st_inpt[lcv].y and ypos < st_inpt[lcv].y + st_inpt[lcv].height then 
		st_inpt[lcv].textcolor = rgb(255, 0, 0) 
	else 
		st_inpt[lcv].textcolor = rgb(255, 255, 255)	
	end if
next


end event

event mousedown;if editmode <> "insert" then return

if xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width or &
	ypos < st_inpt[1].y or ypos > st_inpt[sched_type -1].y + st_inpt[sched_type -1].height then
	zz_insert_log()
	return
end if
 
integer lcv

for lcv = 1 to sched_type - 1
	if ypos >= st_inpt[lcv].y and ypos < st_inpt[lcv].y + st_inpt[lcv].height and &
		st_inpt[lcv].visible and st_inpt[lcv].textcolor = 255 then
		insert_log(lcv) 
		exit
	end if
next 


end event

type st_noprivs from statictext within w_log
boolean visible = false
integer x = 1481
integer y = 320
integer width = 1751
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Missing required divisional privilege rights to access this driver log."
boolean focusrectangle = false
end type

type ds_vios_daily_print from datawindow within w_log
integer x = 960
integer y = 1764
integer width = 407
integer height = 88
string dataobject = "d_vios_daily_print"
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_choose_emp from u_choose_emp within w_log
event mousemove pbm_mousemove
integer x = 41
integer y = 32
integer width = 1234
integer height = 84
end type

event mousemove;call super::mousemove;if editmode <> "insert" then return

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

end event

on uo_choose_emp.destroy
call u_choose_emp::destroy
end on

type cb_settings from commandbutton within w_log
event clicked pbm_bnclicked
integer x = 960
integer y = 1668
integer width = 407
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "zSettings"
end type

event clicked;openwithparm(w_log_settings, settings)

settings = message.powerobjectparm





end event

type cb_daily from commandbutton within w_log
integer x = 960
integer y = 1476
integer width = 407
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Daily Vios"
end type

event clicked;if isnull(cur_driver.em_id) then return 
dw_losefocus()   

if left(log_string, 1) = "7" then
	messagebox("Print Request", "Cannot print this report for dates prior to the first "+&
		"log entered (" + string(dw_log_list.getitemdate(sched_type, "dl_date"), "m/d/yy") +&
		").")
	return
elseif left(log_string, 1) = "8" then
	messagebox("Print Request", "Cannot print this report for a new log.")
	return
end if

rowsmod()
if indx <> 0 and g_privs.log[3] = 1 then 
	if messagebox("Print Request", "In order to print this report, your changes will "+&
		"need to be saved.~n~nOK to proceed?", question!, OKCancel!, 1) = 2 then return
elseif indx <> 0 and g_privs.log[3] = 0 then 
	messagebox("Print Request", "In order to print this report, your changes will "+&
	"need to be saved.  Your current user settings do not allow you to save " +&
	"changes.~n~nCannot print this report.", exclamation!)
	return
end if

if indx <> 0 then 
	string failnote
	choose case calc_and_save(failnote)
	case -1 
		messagebox("Save Changes", failnote + "~n~nPrint request cancelled.")
		return
	case 99
		return
	end choose
end if 

//if not isvalid(ds_vios_daily_print) then  
//	ds_vios_daily_print = create datastore 
//	ds_vios_daily_print.dataobject = "d_vios_daily_print"  
//	ds_vios_daily_print.settransobject(sqlca)
//end if

date thisdate
thisdate = dw_log_list.getitemdate(dw_log_list.getselectedrow(0), "dl_date")
ds_vios_daily_print.object.st_date.text = string(thisdate, "MMM d, yyyy (DDD)")
ds_vios_daily_print.object.st_usertag.visible = 0

if ds_vios_daily_print.retrieve(cur_driver.em_id, thisdate) = -1 then
	rollback ;
	messagebox("Print Request", "Could not retrieve report information.~n~nPlease retry.", &
		exclamation!)
	goto destruction
	return
else
	commit ;
end if

integer lcv, the_Num, lcvprint
the_num = 0
if ds_violations.rowcount() > 0 then
	for lcv = 1 to ds_Violations.rowcount()
		if ds_violations.getitemdate(lcv, "dv_date") = thisdate then the_num ++
	next
end if

if the_num > 0 then
	ds_vios_daily_print.object.st_numvios.text = "Number of Violations = " + string(the_Num)
	ds_Vios_daily_print.object.st_novios.visible = 0
	ds_vios_daily_print.object.st_numvios.visible = 1
else
	ds_Vios_daily_print.object.st_novios.visible = 1
	ds_vios_daily_print.object.st_numvios.visible = 0
end if

ds_vios_daily_print.object.st_name.text = uo_choose_emp.sle_name.text
ds_vios_daily_print.object.st_vios.text = "on"
ds_vios_daily_print.object.st_printsign.text = string(settings.printsign)

ds_vios_daily_print.object.st_daily.text = "Daily Summary Report"  //Bug Fix 11/24/98

integer the_miles
the_miles = dw_log_list.getitemnumber(dw_log_list.getselectedrow(0), "dl_miles")
ds_vios_daily_print.object.st_miles.text = "Total Miles = " + string(the_miles)
ds_vios_daily_print.object.report_log.object.st_header.text = "off"
ds_vios_daily_print.object.report_log.object.datawindow.header.height = 1
 

for lcvprint = 1 to w_printchild.numcop
	ds_vios_daily_print.print(false)
next 

destruction:
//destroy ds_vios_daily_print
end event

type cb_list_print from commandbutton within w_log
integer x = 960
integer y = 1572
integer width = 407
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Month Totals"
end type

event clicked;if isnull(cur_driver.em_id) then return 
dw_losefocus() 
 
rowsmod() 
if indx <> 0 and g_privs.log[3] = 1 then 
	if messagebox("Print Request", "In order to print this report, your changes will "+&
		"need to be saved.~n~nOK to proceed?", question!, OKCancel!, 1) = 2 then return
elseif indx <> 0 and g_privs.log[3] = 0 then 
	messagebox("Print Request", "In order to print this report, your changes will "+&
	"need to be saved.  Your current user settings do not allow you to save " +&
	"changes.~n~nCannot print this report.", exclamation!)
	return
end if

if indx <> 0 then 
	string failnote
	choose case calc_and_save(failnote)
	case 99 
		return
	case -1 
		messagebox("Save Changes", failnote + "~n~nPrint request cancelled.")
		return
	end choose
end if

date startdate, stopdate
integer selmonth, selyear, lcvprint
string month_tag

startdate = w_printchild.startdate
stopdate = w_printchild.stopdate

if w_printchild.rb_month.checked = true then 
	month_tag = string(startdate, "mmmm, yyyy")
	selmonth = month(startdate)
	selyear = year(startdate)
	if selmonth = 12 then 
		selmonth = 1
		selyear ++
	else
		selmonth ++
	end if
	stopdate = date(string(selmonth) + "/1/" + string(selyear))
	startdate = relativedate(startdate, - (sched_type - 1) )
else
	month_tag = "Review of Hours"
end if

datastore ds_loglist
ds_loglist = create datastore 
ds_loglist.dataobject = "d_log_header"  
ds_loglist.settransobject(sqlca)

if ds_loglist.retrieve(cur_driver.em_id, startdate, stopdate) = -1 then
	rollback ;
	messagebox("Print Request", "Could not retrieve report information.~n~nPlease retry.", &
		exclamation!)
	goto destruction
	return
else
	commit ;
end if

ds_loglist.object.st_month.text = month_tag
ds_loglist.object.report_log.object.st_print.text = "on"
ds_loglist.object.report_log.object.datawindow.detail.height = 87
ds_loglist.object.report_log.object.datawindow.header.height = 70
ds_loglist.object.st_usertag.visible = 0

for lcvprint = 1 to w_printchild.numcop
	ds_loglist.print(false)
next

destruction:
destroy ds_loglist

end event

type cb_log_print from commandbutton within w_log
integer x = 960
integer y = 1380
integer width = 407
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Log Only"
end type

event clicked;if isnull(cur_driver.em_id) then return 
dw_losefocus()   

if left(log_string, 1) = "7" then
	messagebox("Print Request", "Cannot print this report for dates prior to the first "+&
		"log entered (" + string(dw_log_list.getitemdate(sched_type, "dl_date"), "m/d/yy") +&
		").")
	return
elseif left(log_string, 1) = "8" then
	messagebox("Print Request", "Cannot print this report for a new log.")
	return
end if
 
rowsmod()
if indx <> 0 and g_privs.log[3] = 1 then 
	if messagebox("Print Request", "In order to print this report, your changes will "+&
		"need to be saved.~n~nOK to proceed?", question!, OKCancel!, 1) = 2 then return
elseif indx <> 0 and g_privs.log[3] = 0 then 
	messagebox("Print Request", "In order to print this report, your changes will "+&
	"need to be saved.  Your current user settings do not allow you to save " +&
	"changes.~n~nCannot print this report.", exclamation!)
	return
end if

if indx <> 0 then 
	string failnote
	choose case calc_and_save(failnote)
	case -1 
		messagebox("Save Changes", failnote + "~n~nPrint request cancelled.")
		return
	case 99
		return
	end choose
end if 

//if not isvalid(ds_vios_daily_print) then  
//	ds_vios_daily_print = create datastore 
//	ds_vios_daily_print.dataobject = "d_vios_daily_print"  
//	ds_vios_daily_print.settransobject(sqlca)
//end if

date thisdate
thisdate = dw_log_list.getitemdate(dw_log_list.getselectedrow(0), "dl_date")
ds_vios_daily_print.object.st_date.text = string(thisdate, "MMM d, yyyy (DDD)")
ds_vios_daily_print.object.st_usertag.visible = 0

if ds_vios_daily_print.retrieve(cur_driver.em_id, thisdate) = -1 then
	rollback ;
	messagebox("Print Request", "Could not retrieve report information.~n~nPlease retry.", &
		exclamation!)
	goto destruction
	return
else
	commit ;
end if

ds_Vios_daily_print.object.st_novios.visible = 0
ds_vios_daily_print.object.st_numvios.visible = 0
ds_vios_daily_print.object.st_name.text = uo_choose_emp.sle_name.text
ds_vios_daily_print.object.st_vios.text = "off"
ds_vios_daily_print.object.st_printsign.text = "0"
ds_vios_daily_print.object.st_daily.text = "Driver Log"

ds_vios_daily_print.object.report_log.object.st_header.text = "off"
ds_vios_daily_print.object.report_log.object.datawindow.header.height = 1

integer lcvprint 
for lcvprint = 1 to w_printchild.numcop
	ds_vios_daily_print.print(false)
next 

destruction:
//destroy ds_vios_daily_print
end event

type st_lock from statictext within w_log
boolean visible = false
integer x = 2569
integer y = 688
integer width = 443
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 29425663
boolean enabled = false
string text = "Locked"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_type from statictext within w_log
integer x = 1184
integer y = 40
integer width = 165
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "(60/7)"
boolean focusrectangle = false
end type

type dw_vios_daily from datawindow within w_log
event syscommand pbm_syscommand
boolean visible = false
integer x = 197
integer y = 1416
integer width = 1335
integer height = 528
boolean titlebar = true
string title = "Violations:  Details & Comments"
string dataobject = "d_vios_single2"
boolean minbox = true
end type

event syscommand;if message.wordparm = 61472 then
	this.accepttext()
	this.hide()
	message.processed = true
	message.returnvalue = 0
end if
end event

event itemchanged;integer mainrow, shortrow, lcv
string colname, uid
colname = this.getcolumnname()

shortrow = dw_vios_short.getselectedrow(0)
for lcv = ds_violations.rowcount() to 1 step -1
	if ds_violations.getitemdate(lcv, "dv_date") = &
			dw_vios_daily.getitemdate(row, "dv_date") and & 
		ds_violations.getitemnumber(lcv, "dv_num") = &
			dw_vios_daily.getitemnumber(row, "dv_num") then 
		mainrow = lcv
		exit
	end if
next

ds_violations.setitem(mainrow, colname, trim(data))
dw_vios_short.setitem(shortrow, colname, trim(data))

if colname = "dv_excused" then

//	Two bugs fixed here 11/4/98 : Megan was setting uid to empty string, not null, 
//	and the three lines that set the uid were using g_uid, instead of the local variable, 
//	so the who_ex value would not be erased

	if data = "T" then
		uid = gnv_App.of_GetUserId ( )
	else
		SetNull ( uid )
	end if
	ds_violations.setitem(mainrow, "dv_who_ex", uid)
	dw_vios_short.setitem(shortrow, "dv_who_ex", uid)
	this.setitem(row, "dv_who_ex", uid)

	boolean stillvios = false
	integer viosval = 0
	
	for lcv = 1 to dw_vios_short.rowcount()
		if dw_vios_short.getitemstring(lcv, "dv_excused") = "F" then	
			stillvios = true
			viosval = 1
			exit
		end if
	next
	
	if st_vios.visible <> stillvios then 
		st_vios.visible = stillvios
		this.bringtotop = true
	end if
	mainrow = dw_log_list.getselectedrow(0)
	if dw_log_list.getitemnumber(mainrow, "dl_vios") <> viosval then &
		dw_log_list.setitem(mainrow, "dl_vios", viosval)
end if


return 0

end event

event losefocus;this.accepttext()
this.visible = false
end event

type dw_log_list from datawindow within w_log
event hidewindow pbm_hidewindow
event mouseover pbm_mousemove
integer x = 1385
integer y = 32
integer width = 1947
integer height = 664
string dataobject = "d_log_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event mouseover;if editmode <> "insert" then return

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

end event

event clicked;dw_losefocus()
dw_miles.accepttext()
this.accepttext()
if getfocus() = uo_codriver.sle_name then 
	triggerit = true
	uo_codriver.sle_name.triggerevent(modified!)
end if

if row = 0 then return 

choose case editmode
	case "off"
		if miler_check() = 99 then return
		log_to_chart(this.getselectedrow(0), row)
		if st_lock.visible = false then 
			if left(dw_log_list.getitemstring(row, "dl_log"), 1) = "7" or &
				left(dw_log_list.getitemstring(row, "dl_log"), 1) = "6" then	
				this.setfocus()
				this.setrow(row)
				this.setcolumn("dl_odtot")
				// the script above seldom does what it is supposed to do
				// I think it sees the column as protected because the previous one before the setfocus is 
				//		is protected and the dw just can't refresh itself or look to the current one with focus
			elseif left(dw_log_list.getitemstring(row, "dl_log"), 1) = "5" then
				uo_choose_emp.sle_name.setfocus()
			else
				dw_log.setfocus()
			end if
		else
			uo_choose_emp.sle_name.setfocus()
		end if
	case "insert"
		return
end choose




end event

event itemchanged;if row = 0 or isnull(row) then return
string logstr 
dec tempnum, fract


//Section inserted into old code for 34 hour restart for New HOS 1/4/04 BKW
//The old script just assumes it's dealing with an hours worked change, since that
//used to be the only column available to modify.  I don't want to attempt to change
//that logic flow here.

CHOOSE CASE Lower ( dwo.Name )

CASE "dl_restart"

	//This code is borrowed from the script below, flagging modified rows for schedule check processing.
	this.setitem(row, "comp_mod", "y")
	if row < sched_type then this.setitem(start_check_row, "comp_mod", "y")

	RETURN 0

END CHOOSE

//End of Section Inserted


logstr = this.getitemstring(row, "dl_log")
if left(logstr, 1) <> "6" and left(logstr, 1) <> "7" then return 2

if isnull(data) or len(trim(data)) = 0 or not isnumber(data) then
	tempnum = 0 
	goto actcode
else 
	tempnum = abs(round(dec(data), 2))
end if

if tempnum >= 24 then
	tempnum = 24
	goto actcode
else
	fract = tempnum - truncate(tempnum, 0)
end if


	
if fract = 0 or fract = 0.25 or fract = 0.75 or fract = 0.5 then
else
	if fract < .18 then 
		fract = 0
	elseif fract < .33 then
		fract = .25
	elseif fract < .68 then
		fract = .5
	elseif fract < .88 then 
		fract = .75
	else
		fract = 1
	end if
	tempnum = truncate(tempnum, 0) + fract
	if tempnum > 24 then tempnum = 24
end if

actcode:

this.setitem(row, "comp_mod", "y")
if row < sched_type then this.setitem(start_check_row, "comp_mod", "y")
this.setitem(row, "dl_odtot", tempnum)
total_hours(true)
return 2


end event

event dberror;return 1
end event

event itemerror;this.setitem(row, "dl_odtot", 0)
beep(1)
total_hours(true)
return 3


end event

type dw_miles from datawindow within w_log
event mouseover pbm_mousemove
integer x = 18
integer y = 308
integer width = 1266
integer height = 100
integer taborder = 10
string dataobject = "d_log_miles"
boolean border = false
boolean livescroll = true
end type

event mouseover;if editmode <> "insert" then return

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

end event

event itemchanged;dw_losefocus()

string colname
long longnum

colname = this.getcolumnname()
choose case colname
case "dl_miles"
	if isnull(data) or len(trim(data)) = 0 or not isnumber(data) then
		longnum = 0
	else
		longnum = abs(long(data))
		if longnum > 3000 then longnum = 0
	end if
	this.setitem(row, colname, longnum)	
	
	integer currow
	currow = dw_log_list.getselectedrow(0)
	if currow <= 0 then return 2
	if dw_log_list.getitemnumber(currow, "dl_miles") <> longnum or &
		isnull(dw_log_list.getitemnumber(currow, "dl_miles")) then
		dw_log_list.setitem(currow, "dl_miles", longnum) 
		if dw_log_list.getitemstring(currow, "comp_mod") = "n" then &
			dw_log_list.setitem(currow, "comp_mod", "o") 
	end if
	
	return 2
end choose


	
end event

event itemerror;dw_losefocus()
string colname
long longnum

colname = this.getcolumnname()
choose case colname
case "dl_miles"
	if isnull(data) or len(trim(data)) = 0  then
		this.setitem(row, colname, 0)	
		integer currow
		currow = dw_log_list.getselectedrow(0)
		if currow <= 0 then return 3
		if dw_log_list.getitemnumber(currow, "dl_miles") <> longnum or &
			isnull(dw_log_list.getitemnumber(currow, "dl_miles")) then
			dw_log_list.setitem(currow, "dl_miles", longnum) 
			if dw_log_list.getitemstring(currow, "comp_mod") = "n" then &
				dw_log_list.setitem(currow, "comp_mod", "o") 
		end if
	else
		this.setitem(row, colname, this.getitemnumber(row, colname)	)
	end if
	return 3
end choose


	
end event

event losefocus;if forced_closing = true then return
if not isvalid (dw_log_list) then return
this.accepttext()
end event

type uo_codriver from u_choose_emp within w_log
event mousemove pbm_mousemove
integer x = 41
integer y = 216
integer width = 1106
integer height = 84
end type

event mousemove;call super::mousemove;if editmode <> "insert" then return
//this isn't always triggered

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

end event

on uo_codriver.destroy
call u_choose_emp::destroy
end on

type dw_vios_short from datawindow within w_log
event mouseover pbm_mousemove
integer x = 37
integer y = 412
integer width = 1257
integer height = 248
string dataobject = "d_vios_short"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event mouseover;if editmode <> "insert" then return

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

end event

event doubleclicked;if isnull(cur_driver.em_id) then return
if nullornotpos(row) then return

this.selectrow(0, false)
this.selectrow(row, true)

dw_vios_daily.accepttext()
if editmode <> "off" then return

dw_vios_daily.setredraw(false)
dw_vios_daily.reset()

integer lcv, viosnum, viostype, countnum = 1, foundcount
integer rowtocopy, selrow
date thisdate
boolean refreshed = false

thisdate = this.getitemdate(row, "dv_date")
viosnum = this.getitemnumber(row, "dv_num")
viostype = this.getitemnumber(row, "dv_type")

if row > 1 then 
	for lcv = 1 to (row - 1)
		if this.getitemnumber(lcv, "dv_type") = viostype then countnum ++
	next
end if

rowsmod()
if indx = 0 or indx = -1 then
else
	for lcv = 1 to indx
		if rows_to_check[lcv] = dw_log_list.getselectedrow(0) then 
			if miler_check() = 99 then goto redrawon
			violations_check()
			sched_check()
			receipt_check()
			set_vios()
			refresh_shortvios()
			refreshed = true
			exit
		end if
	next
end if

if refreshed = false then 
	for lcv = 1 to ds_violations.rowcount()
		if ds_violations.getitemnumber(lcv, "dv_num") = viosnum and &
			ds_violations.getitemdate(lcv, "dv_date") = thisdate then
			rowtocopy = lcv
			exit
		end if
	next
else
	for lcv = 1 to ds_violations.rowcount()
		if ds_violations.getitemnumber(lcv, "dv_type") = viostype and &
			ds_violations.getitemdate(lcv, "dv_date") = thisdate then
			rowtocopy = lcv
			foundcount ++
			if countnum = foundcount then exit
		end if
	next
end if

if rowtocopy > 0 then 
	ds_violations.RowsCopy(rowtocopy, rowtocopy, primary!, & 
		dw_vios_daily, 99, primary!)
	dw_vios_daily.setitem(lcv, "di_sched_type", sched_type)
	for lcv = 1 to this.rowcount()
		if this.getitemnumber(lcv, "dv_Num") = ds_violations.getitemnumber(rowtocopy, "dv_num") then
			selrow = lcv
			exit
		end if
	next
else
	messagebox("Violation Status","Violations were recalculated and the selected violation no longer exists.")
	goto redrawon
end if
dw_vios_daily.object.st_count.text = string(dw_vios_short.rowcount())
if st_lock.visible = true then
	dw_vios_daily.object.dv_reason.protect = 1
	dw_vios_daily.object.dv_excused.protect = 1
	dw_vios_daily.object.dv_reason.background.color = 12648447
else
	if g_privs.log[3] = 0 then 
		dw_vios_daily.object.dv_reason.protect = 1
	else
		dw_vios_daily.object.dv_reason.protect = 0
	end if
	if g_privs.log[4] = 0 then 
		dw_vios_daily.object.dv_excused.protect = 1
	else
		dw_vios_daily.object.dv_excused.protect = 0
	end if
	dw_vios_daily.object.dv_reason.background.color = rgb(255, 255, 255)
end if
dw_vios_daily.visible = true
dw_vios_daily.bringtotop = true
dw_vios_daily.setfocus()

redrawon:
dw_vios_daily.setredraw(true)
if dw_vios_daily.visible = true then
	if this.getselectedrow(0) = 0 then
		this.selectrow(selrow, true)
	elseif this.getselectedrow(0) <> selrow then
		this.selectrow(0, false)
		this.selectrow(selrow, true)
		dw_vios_daily.visible = true
	end if
else
	this.selectrow(0, false)
end if

end event

event clicked;if row = 0 or isnull(cur_driver.em_id) then 
	dw_losefocus()
	return
elseif dw_vios_daily.visible = false then 
	this.selectrow(0, false)
	this.selectrow(row, true)
	return
elseif this.rowcount() = 1 then 
	dw_losefocus()
	return
else
	//this script is cut from double clicked event and should be kept the same
	//although the rowsmod part will never be triggered, it's still here
	this.selectrow(0, false)
	this.selectrow(row, true)
	
	dw_vios_daily.accepttext()
	if editmode <> "off" then return
	
	dw_vios_daily.setredraw(false)
	dw_vios_daily.reset()
	
	integer lcv, viosnum, viostype, countnum = 1, foundcount
	integer rowtocopy, selrow
	date thisdate
	boolean refreshed = false
	
	thisdate = this.getitemdate(row, "dv_date")
	viosnum = this.getitemnumber(row, "dv_num")
	viostype = this.getitemnumber(row, "dv_type")
	
	if row > 1 then 
		for lcv = 1 to (row - 1)
			if this.getitemnumber(lcv, "dv_type") = viostype then countnum ++
		next
	end if
	
	rowsmod()
	if indx = 0 or indx = -1 then
	else
		for lcv = 1 to indx
			if rows_to_check[lcv] = dw_log_list.getselectedrow(0) then 
				if miler_check() = 99 then goto redrawon
				violations_check()
				sched_check()
				receipt_check()
				set_vios()
				refresh_shortvios()
				refreshed = true
				exit
			end if
		next
	end if
	
	if refreshed = false then 
		for lcv = 1 to ds_violations.rowcount()
			if ds_violations.getitemnumber(lcv, "dv_num") = viosnum and &
				ds_violations.getitemdate(lcv, "dv_date") = thisdate then
				rowtocopy = lcv
				exit
			end if
		next
	else
		for lcv = 1 to ds_violations.rowcount()
			if ds_violations.getitemnumber(lcv, "dv_type") = viostype and &
				ds_violations.getitemdate(lcv, "dv_date") = thisdate then
				rowtocopy = lcv
				foundcount ++
				if countnum = foundcount then exit
			end if
		next
	end if
	
	if rowtocopy > 0 then 
		ds_violations.RowsCopy(rowtocopy, rowtocopy, primary!, & 
			dw_vios_daily, 99, primary!)
		dw_vios_daily.setitem(lcv, "di_sched_type", sched_type)
		for lcv = 1 to this.rowcount()
			if this.getitemnumber(lcv, "dv_Num") = ds_violations.getitemnumber(rowtocopy, "dv_num") then
				selrow = lcv
				exit
			end if
		next
	else
		messagebox("Violation Status","Violations were recalculated and the selected violation no longer exists.")
		goto redrawon
	end if
	dw_vios_daily.object.st_count.text = string(dw_vios_short.rowcount())
	if st_lock.visible = true then
		dw_vios_daily.object.dv_reason.protect = 1
		dw_vios_daily.object.dv_excused.protect = 1
		dw_vios_daily.object.dv_reason.background.color = 12648447
	else
		if g_privs.log[3] = 0 then 
			dw_vios_daily.object.dv_reason.protect = 1
		else
			dw_vios_daily.object.dv_reason.protect = 0
		end if
		if g_privs.log[4] = 0 then 
			dw_vios_daily.object.dv_excused.protect = 1
		else
			dw_vios_daily.object.dv_excused.protect = 0
		end if
		dw_vios_daily.object.dv_reason.background.color = rgb(255, 255, 255)
	end if
	dw_vios_daily.visible = true
	dw_vios_daily.bringtotop = true
	dw_vios_daily.setfocus()
	
	redrawon:
	dw_vios_daily.setredraw(true)
	if dw_vios_daily.visible = true then
		if this.getselectedrow(0) = 0 then
			this.selectrow(selrow, true)
		elseif this.getselectedrow(0) <> selrow then
			this.selectrow(0, false)
			this.selectrow(selrow, true)
			dw_vios_daily.visible = true
		end if
	else
		this.selectrow(0, false)
	end if
end if

end event

type gb_date from groupbox within w_log
integer x = 9
integer y = 132
integer width = 1326
integer height = 564
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "10/12/29"
end type

type st_insert6 from statictext within w_log
boolean visible = false
integer x = 1339
integer y = 520
integer width = 50
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_insert1 from statictext within w_log
boolean visible = false
integer x = 1339
integer y = 144
integer width = 50
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_insert2 from statictext within w_log
boolean visible = false
integer x = 1339
integer y = 224
integer width = 50
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_insert3 from statictext within w_log
boolean visible = false
integer x = 1339
integer y = 292
integer width = 50
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_insert4 from statictext within w_log
boolean visible = false
integer x = 1339
integer y = 368
integer width = 50
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_insert5 from statictext within w_log
boolean visible = false
integer x = 1339
integer y = 444
integer width = 50
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_insert7 from statictext within w_log
boolean visible = false
integer x = 1339
integer y = 596
integer width = 50
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Ø"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_vios from statictext within w_log
integer x = 1600
integer y = 688
integer width = 443
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Violation"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_log from datawindow within w_log
event mousemove pbm_mousemove
event dwnkey pbm_dwnkey
integer x = 37
integer y = 736
integer width = 3296
integer height = 528
integer taborder = 20
string dataobject = "d_log_chart"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event mousemove;if editmode <> "insert" then return

integer lcv

if isnull(xpos) or isnull(ypos) or xpos < st_inpt[1].x or xpos > st_inpt[1].x + st_inpt[1].width &
	or ypos < st_inpt[1].y or ypos > st_inpt[sched_type - 1].y + st_inpt[1].height then
	for lcv = 1 to 7
		st_inpt[lcv].textcolor = rgb(255, 255, 255)
	next
	return
end if 

end event

event dwnkey;//dwnkeybegin
string temp_str
temp_str = entry_str
entry_str = "" 

if isnull(cur_driver.em_id) then return
if left(log_string, 1) = "5" or left(log_string, 1) = "6" or left(log_string, 1) = '7' then return
if keydown(keym!) and left(log_string, 1) <> "8" then	
	dw_miles.setfocus()
	return
end if

string oldstatus, old_log_string, new_log_string

if	left(log_string, 1) = "8" then 
	curx = 1
	cury = 1
	old_log_string = "x"
	new_log_string = fill("1", 96)
else
	old_log_string = log_string
	new_log_string = log_string
end if

integer oldx, oldy, lcv, newmin, newhour
oldstatus = mid(new_log_string, curx, 1)
oldx = curx 
lcv = curx
oldy = cury
if keydown(keyleftarrow!) then
	if keydown(keyshift!) then
		curx = max(curx - 4, 1)
	elseif keydown(keycontrol!) then
		curx = max(int((curx - 2) / 4) * 4 + 1, 1)	
	elseif curx > 1 then 
		curx --
	end if
elseif keydown(keyrightarrow!) then
	if keydown(keyshift!) then
		curx = min(curx + 4, 96)
	elseif keydown(keycontrol!) then
		curx = min(int((curx + 3) / 4) * 4 + 1, 96)
	elseif curx < 96 then 
		curx ++
	end if
elseif keydown(keydownarrow!) then
	if cury < 4 then cury ++
elseif keydown(keyuparrow!) then
	if cury > 1 then cury --
//------------------------------------------------------------------------capture keys part
elseif keydown(key1!) or keydown(keynumpad1!) then
	entry_str = temp_str + "1"
	return
elseif keydown(key2!) or keydown(keynumpad2!) then
	entry_str = temp_str + "2"
	return
elseif keydown(key3!) or keydown(keynumpad3!) then
	entry_str = temp_str + "3"
	return
elseif keydown(key4!) or keydown(keynumpad4!) then
	entry_str = temp_str + "4"
	return
elseif keydown(key5!) or keydown(keynumpad5!) then
	entry_str = temp_str + "5"

	return
elseif keydown(key6!) or keydown(keynumpad6!) then
	entry_str = temp_str + "6"
	return
elseif keydown(key7!) or keydown(keynumpad7!) then
	entry_str = temp_str + "7"
	return
elseif keydown(key8!) or keydown(keynumpad8!) then
	entry_str = temp_str + "8"
	return
elseif keydown(key9!) or keydown(keynumpad9!) then
	entry_str = temp_str + "9"
	return
elseif keydown(key0!) or keydown(keynumpad0!) then
	entry_str = temp_str + "0"
	return
elseif keydown(keydecimal!) or keydown(keyperiod!)then
	entry_str = temp_str + "."
	return
elseif keydown(keyenter!) then
	if temp_str = "" then 
		if oldstatus <> string(cury) then
			do 
				new_log_string = replace(new_log_string, lcv, 1, string(cury))
				lcv++
				if lcv > 96 then exit
			loop while (mid(new_log_string, lcv, 1) = oldstatus)
		end if
	else
		if left(temp_str, 1) <> "1" and left(temp_str, 1) <> "2" and &
			left(temp_str, 1) <> "3" and left(temp_str, 1) <> "4" then
			goto beeping
		elseif mid(temp_str, 2, 1) <> "." then
			goto beeping 
		end if
	
		cury = integer(left(temp_str, 1))
		temp_str = mid(temp_str, 3)
	
		if len(temp_str) <= 2 then 
			newhour = integer(temp_str)
			newmin = 0
		elseif len(temp_str) = 3 then 
			newhour = integer(left(temp_str, 1))
			newmin = integer(right(temp_str, 2))
		else
			newhour = integer(left(temp_str, 2))
			newmin = integer(right(temp_str, 2))
		end if
		if nullorneg(newhour) or newhour > 24 then 
			goto beeping
		elseif nullorneg(newmin) or newmin >= 60 then 
			goto beeping
		end if
		if newhour = 24 then newhour = 0
		if newmin = 0 then
		elseif newmin <= 15 then
			newmin = 1
		elseif newmin <= 30 then
			newmin = 2
		else
			newmin = 3
		end if 
		curx = newhour * 4 + newmin + 1
		oldstatus = mid(new_log_string, curx, 1)
		lcv = max(curx - 1, curx)
		if oldstatus <> string(cury) then
			do 
				new_log_string = replace(new_log_string, lcv, 1, string(cury))
				lcv++
				if lcv > 96 then exit
			loop while (mid(new_log_string, lcv, 1) = oldstatus)
		end if
	end if
end if

//--------------------------------------------------------------------------
if oldx <> curx or oldy <> cury or new_log_string <> old_log_string or old_log_string = "x" then 
	log_string = new_log_string
	dw_log.setredraw(false)
	this.modify("st_curpos.text = '" + string(curx * 10 + cury) + "'")
	if new_log_string <> old_log_string then
		this.SetItem (1, "dl_log", new_log_string)
		total_hours(true)
	end if
	this.setredraw(true)
//	Megan had this line here.  Was causing last modification to be lost, because total
//	hours sets log_string into dw_log_list.  Moved it up top, before total_hours is called.
//	The clicked script operates directly on log_string, so this wasn't an issue there.
//	log_string = new_log_string
end if
	
if keydown(keym!) then dw_miles.setfocus()	
return
//---------------------
beeping:
beep(1)
entry_str = ""
//dwnkeyend

end event

event clicked;if isnull(cur_driver.em_id) then return
dw_losefocus() 
if left(log_string, 1) = "5" or left(log_string, 1) = "6" or left(log_string, 1) = '7' then return

integer px, py, lcv
px = round((xpos - 77) / 6.0 , 0) + 1
py = int((ypos - 26) / 22.5) + 1

if px > 96 or px < 1 or py > 4 or py < 1 then return

this.setredraw(false)
integer eightness = 0
if left(log_string, 1) = "8" then 
	log_string = fill("1", 96)
	if py = 1 then eightness = 1
end if

string oldstatus, old_log_string
old_log_string = log_string
oldstatus = mid(log_string, px, 1)
lcv = px

if oldstatus <> string(py) then
	do 
		log_string = replace(log_string, lcv, 1, string(py))
		lcv++
		if lcv > 96 then exit
	loop while (mid(log_string, lcv, 1) = oldstatus)
end if

if px <> curx or py <> cury or log_string <> old_log_string then 
	curx = px
	cury = py
	this.modify("st_curpos.text = '" + string(curx * 10 + cury) + "'")
	if log_string <> old_log_string then
		this.SetItem (1, "dl_log", log_string)
		total_hours(true)
	end if
end if

if eightness = 1 then 
	curx = px
	cury = py
	this.modify("st_curpos.text = '" + string(curx * 10 + cury) + "'")
	this.SetItem (1, "dl_log", log_string)
	total_hours(true)
end if
this.setredraw(true)

end event

event dberror;return 1
end event

