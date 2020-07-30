$PBExportHeader$w_log_admin.srw
$PBExportComments$PTLOG:
forward
global type w_log_admin from w_response
end type
type cb_lock from commandbutton within w_log_admin
end type
type cb_delete_i from commandbutton within w_log_admin
end type
type cb_delete from commandbutton within w_log_admin
end type
type cb_cancel from commandbutton within w_log_admin
end type
type cb_setmph from commandbutton within w_log_admin
end type
type tab_a from tab within w_log_admin
end type
type page_lock from userobject within tab_a
end type
type cbx_lock from checkbox within page_lock
end type
type sle_lock from singlelineedit within page_lock
end type
type st_lock1 from statictext within page_lock
end type
type page_lock from userobject within tab_a
cbx_lock cbx_lock
sle_lock sle_lock
st_lock1 st_lock1
end type
type page_del from userobject within tab_a
end type
type st_3 from statictext within page_del
end type
type st_1 from statictext within page_del
end type
type sle_deldate from singlelineedit within page_del
end type
type page_del from userobject within tab_a
st_3 st_3
st_1 st_1
sle_deldate sle_deldate
end type
type page_delone from userobject within tab_a
end type
type rb_delone_date from radiobutton within page_delone
end type
type rb_delone_all from radiobutton within page_delone
end type
type st_6 from statictext within page_delone
end type
type st_delone3 from statictext within page_delone
end type
type st_last from statictext within page_delone
end type
type st_first from statictext within page_delone
end type
type st_delone1 from statictext within page_delone
end type
type uo_choose_emp from u_choose_emp within page_delone
end type
type sle_deldate_one from singlelineedit within page_delone
end type
type gb_delone from groupbox within page_delone
end type
type page_delone from userobject within tab_a
rb_delone_date rb_delone_date
rb_delone_all rb_delone_all
st_6 st_6
st_delone3 st_delone3
st_last st_last
st_first st_first
st_delone1 st_delone1
uo_choose_emp uo_choose_emp
sle_deldate_one sle_deldate_one
gb_delone gb_delone
end type
type page_mph from userobject within tab_a
end type
type st_7 from statictext within page_mph
end type
type st_5 from statictext within page_mph
end type
type st_4 from statictext within page_mph
end type
type sle_max from singlelineedit within page_mph
end type
type sle_min from singlelineedit within page_mph
end type
type st_2 from statictext within page_mph
end type
type page_mph from userobject within tab_a
st_7 st_7
st_5 st_5
st_4 st_4
sle_max sle_max
sle_min sle_min
st_2 st_2
end type
type tab_a from tab within w_log_admin
page_lock page_lock
page_del page_del
page_delone page_delone
page_mph page_mph
end type
end forward

global type w_log_admin from w_response
integer x = 677
integer y = 540
integer width = 1262
integer height = 1352
string title = "Log Administration"
long backcolor = 12632256
cb_lock cb_lock
cb_delete_i cb_delete_i
cb_delete cb_delete
cb_cancel cb_cancel
cb_setmph cb_setmph
tab_a tab_a
end type
global w_log_admin w_log_admin

type variables
protected:
s_emp_info cur_driver
integer minmph, maxmph, numlock
boolean lockopt, ignore_change, ignore_enter, notify = true

end variables

forward prototypes
public function integer set_choose_emp ()
public subroutine emp_switch (integer uo_num)
private function integer wf_deletelogs (long al_id, date ad_priorto)
private subroutine wf_deletelogssingle ()
private subroutine wf_deletelogsall ()
end prototypes

public function integer set_choose_emp ();tab_a.page_delone.uo_choose_emp.w_mainpar = this

if gds_emp.rowcount() > 0 then 
	tab_a.page_delone.uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
	tab_a.page_delone.uo_choose_emp.ds_hotkey.setfilter("not isnull(di_id)")
	tab_a.page_delone.uo_choose_emp.ds_hotkey.filter()
end if

if tab_a.page_delone.uo_choose_emp.ds_hotkey.rowcount() = 0 then 
	tab_a.page_delone.uo_choose_emp.hsb_1.Visible = false
end if

tab_a.page_delone.uo_choose_emp.st_tag1.text = "Driver:"
//tab_a.page_delone.uo_choose_emp.sle_name.width  = tab_a.page_delone.st_first.x + tab_a.page_delone.st_first.width - tab_a.page_delone.uo_choose_emp.sle_name.x - TAB_a.page_delone.uo_choose_emp.x + 9
//tab_a.page_delone.uo_choose_emp.sle_name.width  = tab_a.page_delone.st_last.x + tab_a.page_delone.st_last.width - tab_a.page_delone.uo_choose_emp.sle_name.x - TAB_a.page_delone.uo_choose_emp.x + 9

tab_a.page_delone.uo_choose_emp.sle_name.width  = tab_a.page_delone.gb_delone.x + tab_a.page_delone.gb_delone.width - tab_a.page_delone.uo_choose_emp.hsb_1.width - tab_a.page_delone.uo_choose_emp.sle_name.x - TAB_a.page_delone.uo_choose_emp.x - 12

tab_a.page_delone.uo_choose_emp.hsb_1.x = tab_a.page_delone.uo_choose_emp.sle_name.width + tab_a.page_delone.uo_choose_emp.sle_name.x + 9
tab_a.page_delone.uo_choose_emp.width = tab_a.page_delone.uo_choose_emp.hsb_1.width + tab_a.page_delone.uo_choose_emp.hsb_1.x + 9
 
tab_a.page_delone.uo_choose_emp.cur_emp.em_id = null_long
cur_driver.em_id = null_long

return 0

end function

public subroutine emp_switch (integer uo_num);if keydown(keyenter!) and cb_delete_i.enabled then ignore_enter = true
//If the user presses enter in the uo sle with cb_delete_i enabled, this flag prevents
//the delete script from executing.

cur_driver = tab_a.page_delone.uo_choose_emp.temp_emp
tab_a.page_delone.uo_choose_emp.set_emp(true)


date bdate, edate
integer schedtype
if isnull(cur_driver.em_id) then
//	tab_a.page_delone.st_last.text = ""
//	tab_a.page_delone.st_first.text = ""
	beep(1)
	cb_cancel.text = "Cancel"
	cb_cancel.event post clicked()
else
	select min(dl_date), max(dl_date) into :bdate, :edate
		from driver_logs where dl_id = :cur_driver.em_id ;
	if sqlca.sqlcode <> 0 then
		rollback ;
		tab_a.page_delone.st_last.text = "?"
		tab_a.page_delone.st_first.text = "?"
		return 
	else
		commit ;
	end if
	select di_sched_type into :schedtype from driverinfo where di_id = :cur_driver.em_id ;
	if sqlca.sqlcode <> 0 then
		rollback ;
		tab_a.page_delone.st_last.text = "?"
		tab_a.page_delone.st_first.text = "?"
		return 
	else
		commit ;
	end if
	bdate = relativedate(bdate, schedtype - 1)
	tab_a.page_delone.st_first.text = string(bdate, "m/d/yy")
	tab_a.page_delone.st_last.text = string(edate, "m/d/yy")
	tab_a.page_delone.st_first.backcolor = 12648447
	tab_a.page_delone.st_last.backcolor = 12648447
	tab_a.page_delone.gb_delone.enabled = true
	tab_a.page_delone.rb_delone_all.enabled = true
	tab_a.page_delone.rb_delone_date.enabled = true
	if tab_a.page_delone.rb_delone_date.checked then
		tab_a.page_delone.sle_deldate_one.enabled = true
		tab_a.page_delone.sle_deldate_one.setfocus()
	else
		tab_a.page_delone.rb_delone_all.setfocus()
	end if
	tab_a.page_del.enabled = false
	tab_a.page_lock.enabled = false
	tab_a.page_mph.enabled = false
	cb_cancel.text = "Cancel"
	cb_delete_i.enabled = true
end if

end subroutine

private function integer wf_deletelogs (long al_id, date ad_priorto);//Note:  This was Megan's approach.  A simpler approach might be to just issue a
//SQL delete, and then insert the 6 or 7 blank header rows necessary.  This would
//eliminate the need for ds looping and the extra delete statements to remove 
//violations and receipts for the 6 or 7 logs that get converted to blanks, because
//ALL the violations and receipts involved would be removed by the cascading delete.

String	ls_Blank
Integer	li_Return = 1, li_ScheduleType
Long		ll_Row, ll_RowCount
Date		ld_FirstLog, ld_Check, ld_Max, ld_ClearBefore, ld_DeleteBefore
DataStore	lds_Work

ls_Blank = Fill ("7", 96)
ld_ClearBefore = Date ( DateTime ( ad_PriorTo ) )
ld_Max = RelativeDate ( ld_ClearBefore, 20)

lds_Work = CREATE DataStore 
lds_Work.DataObject = "d_log_deleter"
lds_Work.SetTransObject ( SQLCA )

ll_RowCount = lds_Work.Retrieve ( al_Id, ld_Max )

CHOOSE CASE ll_RowCount
CASE -1
	ROLLBACK ;
	li_Return = -1
	GOTO CleanUp
CASE 0
	COMMIT ;
	li_Return = 0
	GOTO CleanUp
CASE ELSE
	COMMIT ;
END CHOOSE

li_ScheduleType = lds_Work.GetItemNumber ( 1, "di_sched_type" )
ld_DeleteBefore = RelativeDate ( ld_ClearBefore, -1 * ( li_ScheduleType - 1) )

ld_FirstLog = RelativeDate ( lds_Work.GetItemDate (1, "dl_date" ), li_ScheduleType - 1 )

IF ld_FirstLog >= ld_ClearBefore THEN 
	li_Return = 0
	GOTO CleanUp
END IF

FOR ll_Row = ll_RowCount TO 1 STEP -1

	ld_Check = lds_Work.GetItemDate ( ll_Row, "dl_date" )

	IF ld_Check >= ld_ClearBefore THEN
		CONTINUE
	ELSEIF ld_Check < ld_ClearBefore AND ld_Check >= ld_DeleteBefore THEN
		lds_Work.SetItem ( ll_Row, "dl_miles", 0 )
		lds_Work.SetItem ( ll_Row, "dl_vios", 0 )
		lds_Work.SetItem ( ll_Row, "dl_log", ls_Blank )
		lds_Work.SetItem ( ll_Row, "dl_drtot", 0 )
	ELSE	
		lds_Work.DeleteRow ( ll_Row )
	END IF

NEXT

IF lds_Work.Update ( FALSE, FALSE ) = -1 THEN
	ROLLBACK ;
	li_Return = -1
	GOTO CleanUp
END IF

UPDATE driverinfo SET di_intsig = di_intsig + 1 WHERE di_id = :al_Id ;
IF SQLCA.SqlCode = 0 AND SQLCA.SqlNRows = 1 THEN
ELSE
	ROLLBACK ;
	li_Return = -1
	GOTO CleanUp
END IF

DELETE FROM driver_vios WHERE dv_date < :ld_ClearBefore AND dv_id = :al_Id ;
IF SQLCA.SqlCode = 0 AND SQLCA.SqlNRows >= 0 THEN
ELSE
	ROLLBACK ;
	li_Return = -1
	GOTO CleanUp
END IF

DELETE FROM log_receipts WHERE lr_date < :ld_ClearBefore AND lr_id = :al_Id ;
IF SQLCA.SqlCode = 0 AND SQLCA.SqlNRows >= 0 THEN
ELSE
	ROLLBACK ;
	li_Return = -1
	GOTO CleanUp
END IF

COMMIT ;

lds_Work.ResetUpdate ( )

CleanUp:

DESTROY lds_Work
RETURN li_Return
end function

private subroutine wf_deletelogssingle ();String	ls_MessageHeader = "Delete Logs"
Date		ld_PriorTo

if ignore_enter then
	//This would have been set in emp_switch, if the user pressed enter in the uo sle
	ignore_enter = false
	return
end if

if g_privs.log[7] = 0 then
	messagebox(ls_MessageHeader, "Your current user privileges do not allow you " +&
	"to delete driver logs.")
	cb_cancel.postevent(clicked!)
	return
end if

if isnull(cur_driver.em_id) then //shouldn't happen
	messagebox(ls_MessageHeader, "You must choose a driver first.")
	tab_a.page_delone.uo_choose_emp.sle_name.setfocus()
	return 
end if

if not tab_a.page_delone.rb_delone_all.checked then
	if len(trim(tab_a.page_delone.sle_deldate_one.text)) = 0 then
		messagebox(ls_MessageHeader, "You must specify a date first.")
		tab_a.page_delone.sle_deldate_one.setfocus()
		return
	elseif not isdate(tab_a.page_delone.sle_deldate_one.text) then
		return
	else
		ld_PriorTo = date(tab_a.page_delone.sle_deldate_one.text)
	end if
end if

if isvalid(w_log) then
	if not isnull(w_log.cur_driver.em_id) then 
		if w_log.cur_driver.em_id = cur_Driver.em_id then
			messagebox(ls_MessageHeader, "Logs for this driver are currently being viewed in the "+&
			"Log Entry screen.  Please close that window before performing this procedure.")
			return
		end if
	end if
end if
if isvalid(w_vios_driver) then
	if not isnull(w_vios_driver.cur_driver.em_id) then 
		if w_vios_driver.cur_driver.em_id = cur_Driver.em_id then
			messagebox(ls_MessageHeader, "Information for this driver is currently being viewed in the " +&
			"Violations screen.  Please close that window before performing this procedure.")
			return
		end if
	end if
end if

if tab_a.page_delone.rb_delone_all.checked then
	if messagebox(ls_MessageHeader, "OK to delete ALL logs for " + cur_driver.em_fn + " " +&
		cur_driver.em_ln + "?", exclamation!, OkCancel!, 1) = 2 then return
	update driverinfo set di_intsig = di_intsig + 1 where di_id = :cur_driver.em_id ;
	if sqlca.sqlcode <> 0 then
		rollback ;
		messagebox(ls_MessageHeader, "Could not delete driver logs from database.~n~nPlease Retry.", exclamation!)
	else
		delete from driver_logs where dl_id = :cur_driver.em_id ;
		if sqlca.sqlcode <> 0 then
			rollback ;
			messagebox(ls_MessageHeader, "Could not delete driver logs from database.~n~nPlease Retry.", exclamation!)
		else
			commit ;
			cb_cancel.postevent(clicked!)
		end if 
	end if
	return
end if

if messagebox(ls_MessageHeader, "OK to delete logs for " + cur_driver.em_fn + " " +&
	cur_driver.em_ln + " prior to but excluding " + string(ld_PriorTo, "m/d/yy") + "?", &
	exclamation!, OkCancel!, 1) = 2 then return


CHOOSE CASE wf_DeleteLogs ( cur_driver.em_id, ld_PriorTo )
CASE 1
	//tab_a.page_delone.st_first.text = string(ld_PriorTo, "m/d/yy")
	MessageBox ( ls_MessageHeader, "Process completed successfully.", Information! )
	cb_Cancel.PostEvent ( Clicked! )
CASE 0
	MessageBox ( ls_MessageHeader, "There are no logs on file for " + cur_driver.em_fn + " " +&
		cur_driver.em_ln + " prior to " + string ( ld_PriorTo, "m/d/yy" ) + "." )
CASE ELSE //-1
	MessageBox ( ls_MessageHeader, "Could not delete driver logs from database.~n~nPlease Retry", &
		Exclamation! )
END CHOOSE
end subroutine

private subroutine wf_deletelogsall ();String	ls_MessageHeader = "Delete Logs for All Drivers"
Date		ld_PriorTo

if g_privs.log[7] = 0 then
	messagebox(ls_MessageHeader, "Your current user privileges do not allow you " +&
	"to delete driver logs.")
	cb_cancel.postevent(clicked!)
	return
end if

if isvalid(w_log) or isvalid(w_vios_driver) then 
	messagebox(ls_MessageHeader, "The Log Entry and Violations Windows must be closed " +&
	"before you can delete logs.  (This is to avoid data conflicts between the logs " +&
	"you delete and the information already retrieved in those windows.)")
	return 
end if

//tab_a.page_del.sle_deldate.triggerevent(modified!) 
if len(trim(tab_a.page_del.sle_deldate.text)) = 0 then
	messagebox(ls_MessageHeader, "You must enter a date first.")
	tab_a.page_del.sle_deldate.setfocus()
	return
elseif not isdate(tab_a.page_del.sle_deldate.text) then
	return
else
	ld_PriorTo = date(tab_a.page_del.sle_deldate.text)
end if

//if ld_PriorTo >= today() then
//	messagebox(ls_MessageHeader, "Please enter a date before today's date.")
//	return
//end if

if messagebox(ls_MessageHeader,"OK to delete all logs prior to but excluding " +&
	string(ld_PriorTo, "m/d/yy") + "?", Exclamation!, OkCancel!, 1) = 2 then return

//----------------------------------------------------------------starting
setpointer(hourglass!)

datastore ds_drivers
ds_drivers = create datastore 
ds_drivers.dataobject = "d_emp_list"

if gds_emp.rowcount() > 1 then 
	ds_Drivers.object.data.primary = gds_emp.object.data.primary
	ds_drivers.setfilter("not isnull(di_id)")
	ds_drivers.filter()
end if
if ds_drivers.rowcount() = 0 then 
	messagebox(ls_MessageHeader, "There are no drivers on file.")
	destroy ds_drivers
	return
end if

//uo_progress.st_tag.text = "Deleting. . ."
//uo_progress.r_fill.width = 0
//uo_progress.visible = true
//uo_progress.bringtotop = true

string failnames
long curid
integer lcv

for lcv = 1 to ds_drivers.rowcount()
//	uo_progress.fill_width(lcv / ds_drivers.rowcount())
	curid = ds_drivers.getitemnumber(lcv, "em_id")

	CHOOSE CASE wf_DeleteLogs ( curid, ld_PriorTo )
	CASE 0
		
	CASE 1

	CASE ELSE //-1
		failnames += "~n" + ds_drivers.getitemstring(lcv, "em_ln") + ", " + ds_drivers.getitemstring(lcv, "em_fn")
	END CHOOSE

next

//uo_progress.visible = false
if len(trim(failnames)) > 0 then
	messagebox(ls_MessageHeader, "Could not delete driver logs for the following " +&
		"drivers:~n" + failnames + "~n~nPlease try the same delete again.", exclamation!)
else
	MessageBox ( ls_MessageHeader, "Process completed successfully.", Information! )
	cb_cancel.postevent(clicked!)
end if

destroy ds_drivers
end subroutine

on w_log_admin.create
int iCurrent
call super::create
this.cb_lock=create cb_lock
this.cb_delete_i=create cb_delete_i
this.cb_delete=create cb_delete
this.cb_cancel=create cb_cancel
this.cb_setmph=create cb_setmph
this.tab_a=create tab_a
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_lock
this.Control[iCurrent+2]=this.cb_delete_i
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_setmph
this.Control[iCurrent+6]=this.tab_a
end on

on w_log_admin.destroy
call super::destroy
destroy(this.cb_lock)
destroy(this.cb_delete_i)
destroy(this.cb_delete)
destroy(this.cb_cancel)
destroy(this.cb_setmph)
destroy(this.tab_a)
end on

event open;ignore_change = true

if g_privs.log[1] = 0 or (g_privs.log[5] = 0 and g_privs.log[6] = 0 and g_privs.log[7] = 0) then
	messagebox("Log Administration", "Your user privileges do not allow you to access this screen.")
	close(This)
	return 
end if

this.x = 677
this.y = 541


if g_privs.log[5] = 0 then tab_a.page_mph.enabled = false
if g_privs.log[6] = 0 then tab_a.page_lock.enabled = false
if g_privs.log[7] = 0 then
	tab_a.page_del.enabled = false
	tab_a.page_delone.enabled = false
end if

if tab_a.page_lock.enabled then
elseif tab_a.page_del.enabled then
	tab_a.post selecttab(2)
elseif tab_a.page_mph.enabled then
	tab_a.post selecttab(4)
end if

this.height = cb_cancel.y + cb_cancel.height + 130

set_choose_emp()

tab_a.page_delone.st_last.text = ""
tab_a.page_delone.st_first.text = "" 

cur_driver.em_id = null_long
//uo_progress.visible = false
//uo_progress.x = round(this.width / 2, 0) - round(uo_progress.width / 2, 0)
//uo_progress.y = round(this.height / 2, 0) - round(uo_progress.height / 2, 0)

select ss_long into :minmph from system_settings where ss_id = 10010 ;
if sqlca.sqlcode = 0 then
	commit ;
else
	rollback ;
	goto database_failure
end if

select ss_long into :maxmph from system_settings where ss_id = 10011 ;
if sqlca.sqlcode = 0 then 
	commit ;
else
	rollback ;
	goto database_failure
end if

tab_a.page_mph.sle_min.text = string(minmph)
tab_a.page_mph.sle_max.text = string(maxmph)

cb_setmph.visible = false
cb_delete_i.visible = false
cb_delete.visible = false
cb_lock.visible = true

cb_delete_i.x = cb_setmph.x
cb_delete.x = cb_setmph.x
cb_lock.x = cb_setmph.x

cb_delete_i.y = cb_setmph.y
cb_delete.y = cb_setmph.y
cb_lock.y = cb_setmph.y

long tempnum

select ss_long into :tempnum from system_settings where ss_id = 10002 ;
if sqlca.sqlcode = 0 then
	commit ;
else
	rollback ;
	goto database_failure
end if

select ss_long into :numlock from system_settings where ss_id = 10003 ;
if sqlca.sqlcode = 0 then
	commit ;
else
	rollback ;
	goto database_failure
end if

tab_a.page_lock.sle_lock.text = string(numlock)
if tempnum = 0 then lockopt = false else lockopt = true
tab_a.page_lock.cbx_lock.checked = lockopt
tab_a.page_lock.sle_lock.enabled = lockopt
cb_lock.enabled = false
cb_cancel.text = "Close"

ignore_change = false
return

//--------------------------------------------------------------------------------
database_failure:
messagebox("Log Administration", "Could not retrieve information to " +&
	"open this window.~n~nPlease retry.")
close(this)
return


end event

event closequery;ignore_change = true

end event

type cb_help from w_response`cb_help within w_log_admin
integer x = 1147
integer y = 696
end type

type cb_lock from commandbutton within w_log_admin
event clicked pbm_bnclicked
integer x = 251
integer y = 1028
integer width = 338
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apply"
end type

event clicked;string type_act = "Apply Changes"

if g_privs.log[6] = 0 then
	messagebox(type_act, "Your current user privileges do not allow you " +&
	"to adjust the lock settings.")
	cb_cancel.postevent(clicked!)
	return
end if

integer newnum
boolean newact

//tab_a.page_lock.sle_lock.triggerevent(modified!)
//if this.enabled = false then return

newact = tab_a.page_lock.cbx_lock.checked
//if newact = true then  
//	if not isnumber(tab_a.page_lock.sle_lock.text) or tab_a.page_lock.sle_lock.text = "0" then
//		messagebox(type_act, "Please enter a number greater than zero to represent the number of logs to remain unlocked.")
//		tab_a.page_lock.sle_lock.setfocus()
//		return
//	else
//		newnum = abs(integer(tab_a.page_lock.sle_lock.text))
//	end if
//else
//	newnum = abs(integer(tab_a.page_lock.sle_lock.text))
//end if
newnum = integer(tab_a.page_lock.sle_lock.text)

if newnum > 0 then
else
	return
end if

if newact = lockopt and newnum = numlock then goto reset_display

integer tempnum 
if newact = true then tempnum = 1 else tempnum = 0
update system_settings set ss_long = :tempnum where ss_id = 10002 ;
if sqlca.sqlcode <> 0 then 
	rollback ;	
	messagebox(type_act, "Could not save changes to database.~n~nPlease retry.", exclamation!)	
	return
end if
update system_settings set ss_long = :newnum where ss_id = 10003 ;
if sqlca.sqlcode <> 0 then 
	rollback ;	
	messagebox(type_act, "Could not save changes to database.~n~nPlease retry.", exclamation!)	
	return
end if

commit ;
lockopt = newact
numlock = newnum

if isvalid(w_log) then
	if newact = true then w_log.lockopt = numlock else w_log.lockopt = 0 
	messagebox(type_act, "The new settings will take effect " +&
	"in the log entry screen when the next driver is retrieved.")
end if

reset_display:

cb_cancel.postevent(clicked!)

end event

type cb_delete_i from commandbutton within w_log_admin
event clicked pbm_bnclicked
integer x = 251
integer y = 908
integer width = 338
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;wf_DeleteLogsSingle ( )


/*
if ignore_enter then
	//This would have been set in emp_switch, if the user pressed enter in the uo sle
	ignore_enter = false
	return
end if

string type_act = "Delete Logs"
date deldate

if g_privs.log[7] = 0 then
	messagebox(type_act, "Your current user privileges do not allow you " +&
	"to delete driver logs.")
	cb_cancel.postevent(clicked!)
	return
end if

if isnull(cur_driver.em_id) then //shouldn't happen
	messagebox(type_act, "You must choose a driver first.")
	tab_a.page_delone.uo_choose_emp.sle_name.setfocus()
	return 
end if

if not tab_a.page_delone.rb_delone_all.checked then
	if len(trim(tab_a.page_delone.sle_deldate_one.text)) = 0 then
		messagebox(type_act, "You must specify a date first.")
		tab_a.page_delone.sle_deldate_one.setfocus()
		return
	elseif not isdate(tab_a.page_delone.sle_deldate_one.text) then
		return
	else
		deldate = date(tab_a.page_delone.sle_deldate_one.text)
	end if
end if

if isvalid(w_log) then
	if not isnull(w_log.cur_driver.em_id) then 
		if w_log.cur_driver.em_id = cur_Driver.em_id then
			messagebox(type_act, "Logs for this driver are currently being viewed in the "+&
			"Log Entry screen.  Please close that window before performing this procedure.")
			return
		end if
	end if
end if
if isvalid(w_vios_driver) then
	if not isnull(w_vios_driver.cur_driver.em_id) then 
		if w_vios_driver.cur_driver.em_id = cur_Driver.em_id then
			messagebox(type_act, "Information for this driver is currently being viewed in the " +&
			"Violations screen.  Please close that window before performing this procedure.")
			return
		end if
	end if
end if

if tab_a.page_delone.rb_delone_all.checked then
	if messagebox(type_act, "OK to delete ALL logs for " + cur_driver.em_fn + " " +&
		cur_driver.em_ln + "?", exclamation!, OkCancel!, 2) = 2 then return
	update driverinfo set di_intsig = di_intsig + 1 where di_id = :cur_driver.em_id ;
	if sqlca.sqlcode <> 0 then
		rollback ;
		messagebox(type_act, "Could not delete driver logs from database.~n~nPlease Retry.", exclamation!)
	else
		delete from driver_logs where dl_id = :cur_driver.em_id ;
		if sqlca.sqlcode <> 0 then
			rollback ;
			messagebox(type_act, "Could not delete driver logs from database.~n~nPlease Retry.", exclamation!)
		else
			commit ;
			cb_cancel.postevent(clicked!)
		end if 
	end if
	return
end if

if messagebox(type_act, "OK to delete logs for " + cur_driver.em_fn + " " +&
	cur_driver.em_ln + " prior to but excluding " + string(deldate, "m/d/yy") + "?", &
	exclamation!, OkCancel!, 2) = 2 then return

//----------------------------------------------------------------starting
datastore ds_delstore

ds_delstore = create datastore 
ds_delstore.DataObject = "d_log_deleter"
ds_delstore.SetTransObject(sqlca)

string logstr
integer lcv, lcv2, sched_type
date mindate, adjdate, qdate, maxdate
logstr = fill("7", 96)
maxdate = relativedate(deldate, 20)

if ds_delstore.retrieve(cur_driver.em_id, maxdate) = -1 then 
	rollback ;
	messagebox(type_act, "Could not delete driver logs from database.~n~nPlease Retry", exclamation!)
	goto delstore
else
	commit ;
	if ds_delstore.rowcount() = 0 then
		messagebox(type_act, "There are no logs on file for " + cur_driver.em_fn + " " +&
		cur_driver.em_ln + " prior to " + string(deldate, "m/d/yy") + ".")
		goto delstore
	end if
end if

sched_type = ds_delstore.getitemnumber(1, "di_sched_type")
mindate = relativedate(ds_delstore.getitemdate(1, "dl_date"), sched_type - 1)
adjdate = relativedate(deldate, -1 * (sched_type - 1))
if mindate >= deldate then 
	messagebox(type_act, "There are no logs on file for " + cur_driver.em_fn + " " +&
	cur_driver.em_ln + " prior to " + string(deldate, "m/d/yy") + ".")
	goto delstore
end if

for lcv2 = ds_delstore.rowcount() to 1 step -1
	qdate = ds_delstore.getitemdate(lcv2, "dl_date")
	if qdate >= deldate then
		continue
	elseif qdate < deldate and qdate >= adjdate then
		ds_delstore.setitem(lcv2, "dl_miles", 0)
		ds_delstore.setitem(lcv2, "dl_vios", 0)
		ds_delstore.setitem(lcv2, "dl_log", logstr)
		ds_delstore.setitem(lcv2, "dl_drtot", 0)
	else	
		ds_delstore.deleterow(lcv2)
	end if
next 	

if ds_delstore.update(false, false) = -1 then
	rollback ;
	messagebox(type_act, "Could not delete driver logs from database.~n~nPlease Retry", exclamation!)
	goto delstore
end if

update driverinfo set di_intsig = di_intsig + 1 where di_id = :cur_driver.em_id ;
if sqlca.sqlcode <> 0 then
	rollback ;
	messagebox(type_act, "Could not delete driver logs from database.~n~nPlease Retry", exclamation!)
	goto delstore
end if

delete from driver_vios where dv_date < :deldate and dv_id = :cur_driver.em_id ;
if sqlca.sqlcode = 100 or sqlca.sqlcode = 0 then
else
	rollback ;
	messagebox(type_act, "Could not delete driver logs from database.~n~nPlease Retry", exclamation!)
	goto delstore
end if

commit ;
ds_delstore.resetupdate()
//tab_a.page_delone.st_first.text = string(deldate, "m/d/yy")
cb_cancel.postevent(clicked!)

//----------------------------------------------------------------failure
delstore:

destroy ds_delstore
*/
end event

type cb_delete from commandbutton within w_log_admin
event clicked pbm_bnclicked
integer x = 251
integer y = 788
integer width = 338
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;wf_DeleteLogsAll ( )

/*
string type_act = "Delete Logs for All Drivers"
date deldate

if g_privs.log[7] = 0 then
	messagebox(type_act, "Your current user privileges do not allow you " +&
	"to delete driver logs.")
	cb_cancel.postevent(clicked!)
	return
end if

if isvalid(w_log) or isvalid(w_vios_driver) then 
	messagebox(type_act, "The Log Entry and Violations Windows must be closed " +&
	"before you can delete logs.  (This is to avoid data conflicts between the logs " +&
	"you delete and the information already retrieved in those windows.)")
	return 
end if

//tab_a.page_del.sle_deldate.triggerevent(modified!) 
if len(trim(tab_a.page_del.sle_deldate.text)) = 0 then
	messagebox(type_act, "You must enter a date first.")
	tab_a.page_del.sle_deldate.setfocus()
	return
elseif not isdate(tab_a.page_del.sle_deldate.text) then
	return
else
	deldate = date(tab_a.page_del.sle_deldate.text)
end if

//if deldate >= today() then
//	messagebox(type_act, "Please enter a date before today's date.")
//	return
//end if

if messagebox(type_act,"OK to delete all logs prior to but excluding " +&
	string(deldate, "m/d/yy") + "?", Exclamation!, OkCancel!, 2) = 2 then return
//if messagebox(type_act,"Are you sure?", Exclamation!, OkCancel!, 2) = 2 then return

//----------------------------------------------------------------starting
setpointer(hourglass!)
datastore ds_delstore
datastore ds_drivers

ds_delstore = create datastore 
ds_delstore.DataObject = "d_log_deleter"
ds_delstore.SetTransObject(sqlca)

ds_drivers = create datastore 
ds_drivers.dataobject = "d_emp_list"

if gds_emp.rowcount() > 1 then 
	ds_Drivers.object.data.primary = gds_emp.object.data.primary
	ds_drivers.setfilter("not isnull(di_id)")
	ds_drivers.filter()
end if
if ds_drivers.rowcount() = 0 then 
	messagebox(type_act, "There are no drivers on file.")
	destroy ds_delstore
	destroy ds_drivers
	return
end if

//uo_progress.st_tag.text = "Deleting. . ."
//uo_progress.r_fill.width = 0
//uo_progress.visible = true
//uo_progress.bringtotop = true

string failnames, logstr
long curid
integer lcv, lcv2, sched_type
date mindate, adjdate, qdate, maxdate
logstr = fill("7", 96)
maxdate = relativedate(deldate, 20)

for lcv = 1 to ds_drivers.rowcount()
//	uo_progress.fill_width(lcv / ds_drivers.rowcount())
	curid = ds_drivers.getitemnumber(lcv, "em_id")
	select min(dl_date) into :mindate from driver_logs where dl_id = :curid ;
	if sqlca.sqlcode <> 0 then 
		rollback ;
		failnames += "~n" + ds_drivers.getitemstring(lcv, "em_ln") + ", " + ds_drivers.getitemstring(lcv, "em_fn")
		continue
	else
		commit ;
	end if
	if isnull(mindate) then continue
	if mindate >= deldate then continue
	if ds_delstore.retrieve(curid, maxdate) = -1 then 
		rollback ;
		failnames += "~n" + ds_drivers.getitemstring(lcv, "em_ln") + ", " + ds_drivers.getitemstring(lcv, "em_fn")
		continue
	else
		commit ;
		if ds_delstore.rowcount() = 0 then continue
	end if
	sched_type = ds_delstore.getitemnumber(1, "di_sched_type")
	adjdate = relativedate(deldate, -1 * (sched_type - 1))
	if mindate >= adjdate then continue
	for lcv2 = ds_delstore.rowcount() to 1 step -1
		qdate = ds_delstore.getitemdate(lcv2, "dl_date")
		if qdate >= deldate then
			continue
		elseif qdate < deldate and qdate >= adjdate then
			ds_delstore.setitem(lcv2, "dl_miles", 0)
			ds_delstore.setitem(lcv2, "dl_vios", 0)
			ds_delstore.setitem(lcv2, "dl_log", logstr)
			ds_delstore.setitem(lcv2, "dl_drtot", 0)
		else	
			ds_delstore.deleterow(lcv2)
		end if
	next 	
//-----------------------------------testing
//	dw_delstore.reset()
//	dw_Delstore.object.data.primary = ds_delstore.object.data.primary
//	integer choice
//	choice = essagebox("", "check it out~n~n Want to update?", exclamation!, yesnocancel!)
//	choose case choice
//		case 1
//		case 2 	
//			continue
//		case 3
//			return
//	end choose
//-----------------------------------testing
	if ds_delstore.update(false, false) = -1 then
		rollback ;
		failnames += "~n" + ds_drivers.getitemstring(lcv, "em_ln") + ", " + ds_drivers.getitemstring(lcv, "em_fn")
		continue
	end if

	update driverinfo set di_intsig = di_intsig + 1 where di_id = :curid ;
	if sqlca.sqlcode <> 0 then
		rollback ;
		failnames += "~n" + ds_drivers.getitemstring(lcv, "em_ln") + ", " + ds_drivers.getitemstring(lcv, "em_fn")
		continue
	end if
	
	delete from driver_vios where dv_date < :deldate and dv_id = :curid ;
	if sqlca.sqlcode = 100 or sqlca.sqlcode = 0 then
	else
		rollback ;
		failnames += "~n" + ds_drivers.getitemstring(lcv, "em_ln") + ", " + ds_drivers.getitemstring(lcv, "em_fn")
		continue
	end if

	commit ;
	ds_delstore.resetupdate()
next

//uo_progress.visible = false
if len(trim(failnames)) > 0 then
	messagebox(type_act, "Could not delete driver logs for the following " +&
		"drivers:~n" + failnames + "~n~nPlease try the same delete again.", exclamation!)
//	messagebox("Suggested Action", "Please try the same delete again.")
	destroy ds_delstore
	destroy ds_drivers
	return
end if
cb_cancel.postevent(clicked!)

destroy ds_delstore
destroy ds_drivers

*/
end event

type cb_cancel from commandbutton within w_log_admin
integer x = 635
integer y = 644
integer width = 338
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;choose case this.text
	case "Close"
		close(parent)
		return
	case "Cancel"
		/*	index 1 = locked
			index 2 = delete
			index 3 = delete individual
			index 4 = mph */

		ignore_change = true

		choose case tab_a.selectedtab
			case 1
				tab_a.page_lock.cbx_lock.checked = lockopt
				tab_a.page_lock.sle_lock.text = string(numlock)
				tab_a.page_lock.sle_lock.enabled = lockopt
				cb_lock.enabled = false
			case 2
				tab_a.page_del.sle_deldate.text = ""
				cb_Delete.enabled = false
			case 3
				cb_Delete_i.enabled = false
				tab_a.page_delone.sle_deldate_one.text = ""
				tab_a.page_delone.sle_deldate_one.enabled = false
				tab_a.page_delone.rb_delone_date.enabled = false
				tab_a.page_delone.rb_delone_all.enabled = false
				tab_a.page_delone.st_last.text = ""
				tab_a.page_delone.st_first.text = ""
				tab_a.page_delone.st_last.backcolor = 12632256
				tab_a.page_delone.st_first.backcolor = 12632256
				tab_a.page_delone.gb_delone.enabled = false
				tab_a.page_delone.uo_choose_emp.sle_name.text = ""
				tab_a.page_delone.uo_choose_emp.cur_emp.em_id = null_long
				cur_driver.em_id = null_long
			case 4
				tab_a.page_mph.sle_min.text = string(minmph)
				tab_a.page_mph.sle_max.text = string(maxmph)
				cb_setmph.enabled = false
		end choose

		ignore_change = false

		if g_privs.log[6] = 1 then tab_a.page_lock.enabled = true
		if g_privs.log[7] = 1 then
			tab_a.page_del.enabled = true
			tab_a.page_delone.enabled = true
		end if
		if g_privs.log[5] = 1 then tab_a.page_mph.enabled = true
		this.text = "Close"
end choose

end event

type cb_setmph from commandbutton within w_log_admin
event clicked pbm_bnclicked
integer x = 256
integer y = 644
integer width = 338
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apply"
end type

event clicked;string type_act = "Apply Changes"

if g_privs.log[5] = 0 then
	messagebox(type_act, "Your current user privileges do not allow you " +&
	"to change the minimum/maximum MPH settings.")
	cb_cancel.postevent(clicked!)
	return
end if

//tab_a.page_mph.sle_min.triggerevent(modified!)
//tab_a.page_mph.sle_max.triggerevent(modified!)

//if not isnumber(tab_a.page_mph.sle_min.text) then 
//	messagebox(type_act, "Please enter minimum MPH.")
//	tab_a.page_mph.sle_min.setfocus()
//	return
//elseif not isnumber(tab_a.page_mph.sle_max.text) then 
//	messagebox(type_act, "Please enter maximum MPH.")
//	tab_a.page_mph.sle_max.setfocus()
//	return
//end if

if len(trim(tab_a.page_mph.sle_min.text)) = 0 then 
	messagebox(type_act, "Please enter the minimum MPH.")
	tab_a.page_mph.sle_min.setfocus()
	return
elseif len(trim(tab_a.page_mph.sle_max.text)) = 0 then 
	messagebox(type_act, "Please enter the maximum MPH.")
	tab_a.page_mph.sle_max.setfocus()
	return
elseif not (isnumber(tab_a.page_mph.sle_min.text) and isnumber(tab_a.page_mph.sle_max.text)) then
	return
end if

integer tempmin, tempmax

tempmin = integer(tab_a.page_mph.sle_min.text)
tempmax = integer(tab_a.page_mph.sle_max.text)

if tempmin = minmph and tempmax = maxmph then goto reset_display

if tempmin = tempmax then
	messagebox(type_act, "The minimum and maximum MPH's cannot be the same.")
	tab_a.page_mph.sle_min.setfocus()
	return
end if

if tempmin > tempmax then
	ignore_change = true
	tab_a.page_mph.sle_min.text = string(tempmax)
	tab_a.page_mph.sle_max.text = string(tempmin)
	ignore_change = false
	tempmax = integer(tab_a.page_mph.sle_max.text)
	tempmin = integer(tab_a.page_mph.sle_min.text)
end if

if tempmin < 0 or tempmin > 40 then 
	messagebox(type_act, "The minimum value must be less than 40 MPH.")
	tab_a.page_mph.sle_min.setfocus()
	return
end if
if tempmax < 40 or tempmax > 100 then 
	messagebox(type_act, "The maximum value must be between 40 and 100 MPH.")
	tab_a.page_mph.sle_max.setfocus()
	return
end if

//if messagebox(type_act, "OK to change MPH constants?", &
//	exclamation!, okcancel!, 1) = 2 then return

update system_settings set ss_long = :tempmin where ss_id = 10010 ;
if sqlca.sqlcode <> 0 then	goto rollitback
update system_settings set ss_long = :tempmax where ss_id = 10011 ;
if sqlca.sqlcode <> 0 then	goto rollitback
commit ;

minmph = tempmin
maxmph = tempmax

if isvalid(w_log) then
	messagebox(type_act, "The new minimum and maximum MPH's will take effect " +&
	"in the Log Entry Window the next time a mileage is entered.")
	w_log.minmph = minmph
	w_log.maxmph = maxmph
end if

reset_display:
cb_cancel.postevent(clicked!)

return

rollitback:
rollback ;
messagebox(type_act, "Could not save changes to database.~n~nPlease Retry.", &
	exclamation!)




end event

type tab_a from tab within w_log_admin
event create ( )
event destroy ( )
integer x = 37
integer y = 28
integer width = 1166
integer height = 584
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
page_lock page_lock
page_del page_del
page_delone page_delone
page_mph page_mph
end type

on tab_a.create
this.page_lock=create page_lock
this.page_del=create page_del
this.page_delone=create page_delone
this.page_mph=create page_mph
this.Control[]={this.page_lock,&
this.page_del,&
this.page_delone,&
this.page_mph}
end on

on tab_a.destroy
destroy(this.page_lock)
destroy(this.page_del)
destroy(this.page_delone)
destroy(this.page_mph)
end on

event selectionchanging;/*	index 1 = locked
	index 2 = delete
	index 3 = delete individual
	index 4 = mph */
//choose case oldindex
//	case 1
//		page_lock.sle_lock.triggerevent(modified!)
//	case 2
//		page_del.sle_deldate.triggerevent(modified!)
//	case 3
//		page_delone.sle_deldate_one.triggerevent(modified!)
//	case 4
//		page_mph.sle_min.triggerevent(modified!)
//		page_mph.sle_max.triggerevent(modified!)
//end choose

//choose case newindex
//	case 1
//		if page_lock.enabled = false then return 1
//	case 2
//		if page_Del.enabled = false then return 1		
//	case 3
//		if page_delone.enabled = false then return 1		
//	case 4
//		if page_mph.enabled = false then return 1		
//end choose




end event

event selectionchanged;/*	index 1 = locked
	index 2 = delete
	index 3 = delete individual
	index 4 = mph */


choose case newindex
	case 1
		cb_setmph.visible = false
		cb_delete_i.visible = false
		cb_delete.visible = false
		cb_lock.visible = true
		cb_lock.default = true
		cb_lock.enabled = false
	case 2
		cb_setmph.visible = false
		cb_delete_i.visible = false
		cb_lock.visible = false
		cb_delete.visible = true
		cb_delete.default = true
		cb_delete.enabled = false
	case 3
		cb_setmph.visible = false
		cb_delete_i.visible = true
		cb_delete_i.default = true
		cb_delete.visible = false
		cb_lock.visible = false
		cb_delete_i.enabled = false
	case 4
		cb_setmph.visible = true
		cb_setmph.default = true
		cb_delete_i.visible = false
		cb_delete.visible = false
		cb_lock.visible = false
		cb_setmph.enabled = false
end choose
end event

type page_lock from userobject within tab_a
integer x = 18
integer y = 112
integer width = 1129
integer height = 456
long backcolor = 12632256
string text = "Locking"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cbx_lock cbx_lock
sle_lock sle_lock
st_lock1 st_lock1
end type

on page_lock.create
this.cbx_lock=create cbx_lock
this.sle_lock=create sle_lock
this.st_lock1=create st_lock1
this.Control[]={this.cbx_lock,&
this.sle_lock,&
this.st_lock1}
end on

on page_lock.destroy
destroy(this.cbx_lock)
destroy(this.sle_lock)
destroy(this.st_lock1)
end on

type cbx_lock from checkbox within page_lock
integer x = 59
integer y = 36
integer width = 1051
integer height = 76
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Activate Locked Driver Logs Feature "
end type

event clicked;if this.checked = true then
	sle_lock.enabled = true
else
	sle_lock.enabled = false
end if


//if sle_lock.text <> string(numlock) or cbx_lock.checked <> lockopt then
	tab_a.page_del.enabled = false
	tab_a.page_delone.enabled = false
	tab_a.page_mph.enabled = false
	cb_lock.enabled = true
	cb_cancel.text = "Cancel"
//else
//	tab_a.page_del.enabled = true
//	tab_a.page_delone.enabled = true
//	tab_a.page_mph.enabled = true
//	cb_lock.enabled = false
//	cb_cancel.text = "Close"
//end if

end event

type sle_lock from singlelineedit within page_lock
event enchange pbm_enchange
integer x = 539
integer y = 132
integer width = 128
integer height = 80
integer taborder = 53
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

event enchange;if ignore_change = true or cb_cancel.text = "Cancel" then return

tab_a.page_del.enabled = false
tab_a.page_delone.enabled = false
tab_a.page_mph.enabled = false
cb_lock.enabled = true
cb_cancel.text = "Cancel"

end event

event modified;string tempstr
tempstr = trim(this.text)

ignore_change = true
this.text = tempstr
ignore_change = false



//string tempstr
//tempstr = trim(this.text)
//
//if len(tempstr) = 0 then
//	tempstr = "1"
//elseif not isnumber(tempstr) then
//	tempstr = "1"
//else
//	tempstr = string(abs(integer(tempstr)))
//	if tempstr = "0" then tempstr = "1"
//end if
//
//this.text = tempstr
//
//if this.text <> string(numlock) or cbx_lock.checked <> lockopt then
//	tab_a.page_del.enabled = false
//	tab_a.page_delone.enabled = false
//	tab_a.page_mph.enabled = false
//	cb_lock.enabled = true
//	cb_cancel.text = "Cancel"
//else
//	tab_a.page_del.enabled = true
//	tab_a.page_delone.enabled = true
//	tab_a.page_mph.enabled = true
//	cb_lock.enabled = false
//	cb_cancel.text = "Close"
//end if
//
end event

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;if getfocus() = cb_cancel or notify = false then return

if len(trim(this.text)) > 0 then
	if not (integer(this.text) > 0 and match(this.text, "^[0-9]+$")) then
		beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
	end if
end if
end event

type st_lock1 from statictext within page_lock
integer x = 142
integer y = 140
integer width = 978
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Keep the Last          Logs Unlocked"
boolean focusrectangle = false
end type

type page_del from userobject within tab_a
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 1129
integer height = 456
long backcolor = 12632256
string text = "Delete for All"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_3 st_3
st_1 st_1
sle_deldate sle_deldate
end type

on page_del.create
this.st_3=create st_3
this.st_1=create st_1
this.sle_deldate=create sle_deldate
this.Control[]={this.st_3,&
this.st_1,&
this.sle_deldate}
end on

on page_del.destroy
destroy(this.st_3)
destroy(this.st_1)
destroy(this.sle_deldate)
end on

type st_3 from statictext within page_del
integer x = 32
integer y = 144
integer width = 658
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "(for ALL Drivers)"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within page_del
integer x = 32
integer y = 60
integer width = 658
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Delete All Logs Prior To:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_deldate from singlelineedit within page_del
event enchange pbm_enchange
integer x = 709
integer y = 56
integer width = 325
integer height = 80
integer taborder = 61
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event enchange;if ignore_change = true or cb_cancel.text = "Cancel" then return

tab_a.page_delone.enabled = false
tab_a.page_lock.enabled = false
tab_a.page_mph.enabled = false
cb_cancel.text = "Cancel"
cb_delete.enabled = true

end event

event modified;n_cst_String	lnv_String
date newdate

if len(trim(this.text)) = 0 then
	ignore_change = true
	this.text = ""
	ignore_change = false
	return
end if

newdate = lnv_String.of_SpecialDate ( this.text )
if isnull(newdate) then return

this.text = string(newdate, "m/d/yy")
end event

event rbuttondown;s_date_return pickdate

pickdate.maxdate = null_date //relativedate(today(), -1)
pickdate.mindate = null_date
pickdate.xpos = 3600 - 1102 - 75
pickdate.ypos = 5
pickdate.tag = "Choose a Delete Date"

notify = false
openwithparm(w_choose_day, pickdate)
notify = true

if isdate(message.stringparm) then
	this.text = string(date(message.stringparm), "m/d/yy")
	this.selecttext(1, len(this.text))
end if
end event

event getfocus;this.selecttext(1, len(this.text))
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

type page_delone from userobject within tab_a
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 1129
integer height = 456
long backcolor = 12632256
string text = "Delete"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
rb_delone_date rb_delone_date
rb_delone_all rb_delone_all
st_6 st_6
st_delone3 st_delone3
st_last st_last
st_first st_first
st_delone1 st_delone1
uo_choose_emp uo_choose_emp
sle_deldate_one sle_deldate_one
gb_delone gb_delone
end type

on page_delone.create
this.rb_delone_date=create rb_delone_date
this.rb_delone_all=create rb_delone_all
this.st_6=create st_6
this.st_delone3=create st_delone3
this.st_last=create st_last
this.st_first=create st_first
this.st_delone1=create st_delone1
this.uo_choose_emp=create uo_choose_emp
this.sle_deldate_one=create sle_deldate_one
this.gb_delone=create gb_delone
this.Control[]={this.rb_delone_date,&
this.rb_delone_all,&
this.st_6,&
this.st_delone3,&
this.st_last,&
this.st_first,&
this.st_delone1,&
this.uo_choose_emp,&
this.sle_deldate_one,&
this.gb_delone}
end on

on page_delone.destroy
destroy(this.rb_delone_date)
destroy(this.rb_delone_all)
destroy(this.st_6)
destroy(this.st_delone3)
destroy(this.st_last)
destroy(this.st_first)
destroy(this.st_delone1)
destroy(this.uo_choose_emp)
destroy(this.sle_deldate_one)
destroy(this.gb_delone)
end on

type rb_delone_date from radiobutton within page_delone
integer x = 503
integer y = 292
integer width = 325
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Prior To: "
boolean checked = true
end type

event clicked;sle_deldate_one.enabled = true
end event

type rb_delone_all from radiobutton within page_delone
integer x = 306
integer y = 292
integer width = 192
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "All "
end type

event clicked;sle_deldate_one.enabled = false
end event

type st_6 from statictext within page_delone
integer x = 754
integer y = 184
integer width = 64
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "to"
boolean focusrectangle = false
end type

type st_delone3 from statictext within page_delone
integer x = 82
integer y = 292
integer width = 206
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Delete:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_last from statictext within page_delone
integer x = 827
integer y = 180
integer width = 256
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_first from statictext within page_delone
integer x = 475
integer y = 176
integer width = 256
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_delone1 from statictext within page_delone
integer x = 101
integer y = 184
integer width = 361
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Logs on File:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_choose_emp from u_choose_emp within page_delone
event destroy ( )
integer x = 14
integer y = 40
integer width = 1111
integer taborder = 10
end type

on uo_choose_emp.destroy
call u_choose_emp::destroy
end on

type sle_deldate_one from singlelineedit within page_delone
event enchange pbm_enchange
integer x = 827
integer y = 292
integer width = 256
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;n_cst_String	lnv_String
date newdate

if len(trim(this.text)) = 0 then
	this.text = ""
	return
end if

newdate = lnv_String.of_SpecialDate ( this.text )
if isnull(newdate) then return

this.text = string(newdate, "m/d/yy")
end event

event rbuttondown;s_date_return pickdate

pickdate.maxdate = null_date //relativedate(today(), -1)
pickdate.mindate = null_date
pickdate.xpos = 3600 - 1102 - 75
pickdate.ypos = 5
pickdate.tag = "Choose a Delete Date"

notify = false
openwithparm(w_choose_day, pickdate)
notify = true

if isdate(message.stringparm) then
	this.text = string(date(message.stringparm), "m/d/yy")
	this.selecttext(1, len(this.text))
end if
end event

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;if getfocus() = cb_cancel or getfocus() = tab_a.page_delone.rb_delone_all &
	or notify = false then return

if len(trim(this.text)) > 0 then
	if not isdate(this.text) then
		beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
	end if
end if
end event

type gb_delone from groupbox within page_delone
integer x = 9
integer y = 104
integer width = 1111
integer height = 300
integer taborder = 15
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
end type

type page_mph from userobject within tab_a
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 1129
integer height = 456
long backcolor = 12632256
string text = "MPH"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_7 st_7
st_5 st_5
st_4 st_4
sle_max sle_max
sle_min sle_min
st_2 st_2
end type

on page_mph.create
this.st_7=create st_7
this.st_5=create st_5
this.st_4=create st_4
this.sle_max=create sle_max
this.sle_min=create sle_min
this.st_2=create st_2
this.Control[]={this.st_7,&
this.st_5,&
this.st_4,&
this.sle_max,&
this.sle_min,&
this.st_2}
end on

on page_mph.destroy
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_max)
destroy(this.sle_min)
destroy(this.st_2)
end on

type st_7 from statictext within page_mph
integer y = 52
integer width = 421
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Average MPH:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within page_mph
integer x = 759
integer y = 52
integer width = 160
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Max:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within page_mph
integer x = 425
integer y = 52
integer width = 137
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Min:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_max from singlelineedit within page_mph
event enchange pbm_enchange
integer x = 928
integer y = 48
integer width = 183
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event enchange;if ignore_change = true or cb_cancel.text = "Cancel" then return

tab_a.page_del.enabled = false
tab_a.page_delone.enabled = false
tab_a.page_lock.enabled = false
cb_setmph.enabled = true 
cb_cancel.text = "Cancel"


end event

event modified;string tempstr
tempstr = trim(this.text)

ignore_change = true
if isnumber(tempstr) then this.text = string(integer(this.text)) else this.text = tempstr
ignore_change = false

//string tempstr
//tempstr = trim(this.text)
//
//if len(tempstr) = 0 or tempstr = string(maxmph) or not isnumber(tempstr) then
//	this.text = string(maxmph) 
//else 
//	this.text = string(abs(integer(tempstr)))
//end if
//
//if this.text <> string(maxmph) or sle_min.text <> string(minmph) then 
//	tab_a.page_del.enabled = false
//	tab_a.page_delone.enabled = false
//	tab_a.page_lock.enabled = false
//	cb_setmph.enabled = true 
//	cb_cancel.text = "Cancel"
//else
//	tab_a.page_del.enabled = true
//	tab_a.page_delone.enabled = true
//	tab_a.page_lock.enabled = true
//	cb_setmph.enabled = false 
//	cb_cancel.text = "Close"
//end if

end event

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;if getfocus() = cb_cancel or notify = false then return

if len(trim(this.text)) > 0 then
	if not match(this.text, "^[0-9]+$") then
		beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
	end if
end if
end event

type sle_min from singlelineedit within page_mph
event enchange pbm_enchange
integer x = 571
integer y = 48
integer width = 183
integer height = 80
integer taborder = 5
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event enchange;if ignore_change = true or cb_cancel.text = "Cancel" then return

tab_a.page_del.enabled = false
tab_a.page_delone.enabled = false
tab_a.page_lock.enabled = false
cb_setmph.enabled = true 
cb_cancel.text = "Cancel"

end event

event modified;string tempstr
tempstr = trim(this.text)

ignore_change = true
if isnumber(tempstr) then this.text = string(integer(this.text)) else this.text = tempstr
ignore_change = false

//string tempstr
//tempstr = trim(this.text)
//
//if len(tempstr) = 0 or tempstr = string(minmph) or not isnumber(tempstr) then
//	this.text = string(minmph) 
//else 
//	this.text = string(abs(integer(tempstr)))
//end if
//
//if this.text <> string(minmph) or sle_max.text <> string(maxmph) then 
//	tab_a.page_del.enabled = false
//	tab_a.page_delone.enabled = false
//	tab_a.page_lock.enabled = false
//	cb_setmph.enabled = true 
//	cb_cancel.text = "Cancel"
//else
//	tab_a.page_del.enabled = true
//	tab_a.page_delone.enabled = true
//	tab_a.page_lock.enabled = true
//	cb_setmph.enabled = false 
//	cb_cancel.text = "Close"
//end if



end event

event getfocus;this.selecttext(1, len(this.text))
end event

event losefocus;if getfocus() = cb_cancel or notify = false then return

if len(trim(this.text)) > 0 then
	if not match(this.text, "^[0-9]+$") then
		beep(1)
		this.post selecttext(1, len(this.text))
		this.post setfocus()
	end if
end if
end event

type st_2 from statictext within page_mph
integer x = 9
integer y = 160
integer width = 1106
integer height = 152
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Values below or above these limits will be flagged as violations in log entry."
alignment alignment = center!
boolean focusrectangle = false
end type

