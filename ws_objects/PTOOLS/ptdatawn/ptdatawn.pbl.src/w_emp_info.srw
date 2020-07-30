$PBExportHeader$w_emp_info.srw
forward
global type w_emp_info from window
end type
type st_noprivs from statictext within w_emp_info
end type
type st_user_check from statictext within w_emp_info
end type
type st_driver_privs from statictext within w_emp_info
end type
type cb_make_driver from commandbutton within w_emp_info
end type
type uo_choose_emp from u_choose_emp within w_emp_info
end type
type gb_2 from groupbox within w_emp_info
end type
type gb_1 from groupbox within w_emp_info
end type
type dw_emp_info from datawindow within w_emp_info
end type
type dw_driver_info from datawindow within w_emp_info
end type
type dw_temporarydivision from datawindow within w_emp_info
end type
end forward

global type w_emp_info from window
integer y = 4
integer width = 3648
integer height = 2132
boolean titlebar = true
string title = "Employee Information"
string menuname = "m_sheets"
boolean controlmenu = true
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
st_noprivs st_noprivs
st_user_check st_user_check
st_driver_privs st_driver_privs
cb_make_driver cb_make_driver
uo_choose_emp uo_choose_emp
gb_2 gb_2
gb_1 gb_1
dw_emp_info dw_emp_info
dw_driver_info dw_driver_info
dw_temporarydivision dw_temporarydivision
end type
global w_emp_info w_emp_info

type variables
protected:
n_cst_toolmenu_manager inv_cst_toolmenu_manager

public:
s_emp_info cur_emp
boolean winisclosing
end variables

forward prototypes
public subroutine is_driver (boolean bool_val)
public subroutine set_choose_emp ()
public subroutine add_new ()
public function integer update_gds ()
public subroutine passwords ()
public subroutine zz_save ()
public function integer save_changes (ref string failnote)
protected subroutine set_user_check ()
public subroutine emp_switch (integer uo_num)
public subroutine wf_history_report ()
protected function integer wf_create_toolmenu ()
public subroutine wf_process_request (string as_request)
private subroutine wf_notes ()
private subroutine wf_administrativenotes ()
public subroutine wf_payablessetup ()
public subroutine wf_fleethistoryreport ()
private subroutine wf_showalerts ()
public function integer wf_populatedivisions (long al_divisionid, ref datawindowchild adwc_divisions)
public function integer wf_discardnulltmpdivisions ()
public function integer wf_privsetup ()
public function integer wf_divisionsetup ()
end prototypes

public subroutine is_driver (boolean bool_val);//m_emp_info.m_current.m_history_report.enabled = bool_val
IF NOT gnv_App.of_Getprivsmanager( ).of_Useadvancedprivs( ) THEN
	if g_privs.emp[2] = 1    then  // allowed by privs
		if bool_val then // is a driver
			this.height = 2050//1916
			cb_make_driver.visible = false
			dw_driver_info.visible = true
		else // not a driver
			this.height = 1188
			dw_driver_info.visible = false
			cb_make_driver.visible = true
		end if
		st_driver_privs.visible = false
	else // privs don't allow them to see driver
		this.height = 1188
		dw_driver_info.visible = false
		cb_make_driver.visible = false
		if bool_val then
			st_driver_privs.text = "Driver Information File Maintained / No User Access"
		else
			st_driver_privs.text = "Driver Information File NOT Maintained"
		end if
		st_driver_privs.visible = true
	end if

	if g_privs.emp[4] = 1 then
		dw_driver_info.enabled = true
		cb_make_driver.enabled = true
		dw_emp_info.enabled = true
	else
		dw_driver_info.enabled = false
		cb_make_driver.enabled = false
		dw_emp_info.enabled = false
	end if
ELSE
	
	if bool_val then // is a driver
		this.height = 2050//1916
		cb_make_driver.visible = false
		dw_driver_info.visible = true
	else // not a driver
		this.height = 1188
		dw_driver_info.visible = false
		cb_make_driver.visible = true
	end if
	st_driver_privs.visible = false
	dw_driver_info.enabled = true
	cb_make_driver.enabled = true
	dw_emp_info.enabled = true
	
END IF














//integer lcv, proval
//long bcolor
//string colname, coltype
//
//if bool_val then
//	bcolor = rgb(255, 255, 255)
//	proval = 0
//else
//	bcolor = rgb(192, 192, 192)
//	proval = 1
//end if
//
//dw_driver_info.setredraw(false)
//for lcv = 1 to integer(dw_driver_info.object.datawindow.column.count)
//	colname = dw_driver_info.describe("#" + string(lcv) + ".name")
//	coltype = dw_driver_info.describe(colname + ".edit.style")
//	if coltype <> "checkbox" and coltype <> "radiobuttons" then &
//		dw_driver_Info.modify(colname + ".background.color = " + string(bcolor))
////	dw_driver_Info.modify(colname + ".protect = " + string(proval))
//next
//
//dw_driver_info.enabled = bool_val
//dw_driver_info.setredraw(True)


end subroutine

public subroutine set_choose_emp ();uo_choose_emp.w_mainpar = this

uo_choose_emp.st_tag1.text = "Employee:"
uo_choose_emp.st_tag1.width = 398
uo_choose_emp.sle_name.x = uo_choose_emp.st_tag1.width + uo_choose_emp.st_tag1.x + 9
uo_choose_emp.hsb_1.x = uo_choose_emp.sle_name.width + uo_choose_emp.sle_name.x + 9
uo_choose_emp.width = uo_choose_emp.hsb_1.x + uo_choose_emp.hsb_1.width + 9

if gds_emp.rowcount() > 0 then 
	uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
	uo_choose_emp.ds_hotkey.setfilter("em_status = 'K'")
	uo_choose_emp.ds_hotkey.filter()
end if

if uo_choose_emp.ds_hotkey.rowcount() = 0 then 
	uo_choose_emp.hsb_1.Visible = false
end if

end subroutine

public subroutine add_new ();integer result
string failnote

IF NOT gnv_App.of_GetPrivsmanager( ).of_useadvancedprivs( ) THEN
	if g_privs.emp[5] = 0 then
		messagebox("Add Employee", "Your current user privileges do not allow you to add " +&
		"new employees.")
		return
	end if
END IF

if dw_emp_info.accepttext() = -1 then return
if dw_driver_info.accepttext() = -1 then return

if (dw_emp_info.modifiedcount() = 0 and dw_driver_info.modifiedcount() = 0) or &
	isnull(cur_emp.em_id) then
		result = result
else
	result = messagebox("Add New Employee", "Save changes to current employee first?", &
		question!, yesnocancel!, 1)
	if result = 3 then
		return
	elseif result = 1 then
		choose case save_changes(failnote)
		case -1
			if messagebox("Save Changes", "Could not save changes to database.~n~n"+&
				"Press OK to abandon changes and add new employee, or Cancel to return "+&
				"to current employee and preserve changes for now.", exclamation!, okcancel!, 2) &
					= 2 then return
		case 99
			return
		end choose
	end if
end if

s_emp_info new_emp
cur_emp = new_emp

dw_emp_info.setredraw(false)
dw_driver_info.setredraw(false)

dw_emp_info.reset()
dw_driver_info.reset()
dw_emp_info.insertrow(0)
dw_emp_info.setitem(1, "em_id", 0)

uo_choose_emp.cur_emp = cur_emp
uo_choose_emp.set_emp(false)

dw_emp_info.setredraw(true)
dw_driver_info.setredraw(true)
is_driver(false)
set_user_check()


cb_make_driver.enabled = true
dw_emp_info.setcolumn("em_ln")
dw_emp_info.setfocus()
end subroutine

public function integer update_gds ();//if gds_emp.rowcount() = 0 then goto insertpart
//integer lcv, currow
//
//for lcv = 1 to gds_emp.rowcount()
//	if cur_emp.em_id = gds_emp.getitemnumber(lcv, "em_id") then
//		currow = lcv
//		exit
//	end if
//next
//if currow = 0 then goto insertpart
//
//if gds_emp.getitemstring(currow, "em_ln") = &
//	dw_emp_info.getitemstring(1, "em_ln") then lcv = lcv else goto delrow
//if gds_emp.getitemstring(currow, "em_fn") = &
//	dw_emp_info.getitemstring(1, "em_fn") then lcv = lcv else goto delrow
//if gds_emp.getitemstring(currow, "em_mn") = &
//	dw_emp_info.getitemstring(1, "em_mn") then lcv = lcv else goto delrow
//if gds_emp.getitemstring(currow, "em_ref") = &
//	dw_emp_info.getitemstring(1, "em_ref") then lcv = lcv else goto delrow
//if gds_emp.getitemstring(currow, "em_status") = &
//	dw_emp_info.getitemstring(1, "em_status") then lcv = lcv else goto delrow
//if gds_emp.getitemnumber(currow, "em_type") = &
//	dw_emp_info.getitemnumber(1, "em_type") then lcv = lcv else goto delrow
//if gds_emp.getitemnumber(currow, "em_class") = &
//	dw_emp_info.getitemnumber(1, "em_class") then lcv = lcv else goto delrow
//if isnull(gds_emp.getitemnumber(currow, "di_id")) and &
//	dw_driver_info.visible = true then goto delrow
//
//return 0
//delrow:
//gds_emp.deleterow(currow)
////-------------------------------------------------------------------------
//insertpart:
//integer newrow 
//newrow = gds_emp.insertrow(0)
//gds_emp.setitem(newrow, "em_id", dw_emp_info.getitemnumber(1, "em_id") )
//gds_emp.setitem(newrow, "em_ln", dw_emp_info.getitemstring(1, "em_ln") )
//gds_emp.setitem(newrow, "em_fn", dw_emp_info.getitemstring(1, "em_fn") )
//gds_emp.setitem(newrow, "em_mn", dw_emp_info.getitemstring(1, "em_mn") )
//gds_emp.setitem(newrow, "em_ref", dw_emp_info.getitemstring(1, "em_ref") )
//gds_emp.setitem(newrow, "em_type", dw_emp_info.getitemnumber(1, "em_type") )
//gds_emp.setitem(newrow, "em_status", dw_emp_info.getitemstring(1, "em_status") )
//gds_emp.setitem(newrow, "em_class", dw_emp_info.getitemnumber(1, "em_class") )
//if dw_driver_info.visible = true then 
//
//
//	gds_emp.setitem(newrow, "di_id", dw_emp_info.getitemnumber(1, "em_id") )
//else
//	gds_emp.setitem(newrow, "di_id", null_long)
//end if
//gds_emp.setitemstatus(newrow, 0, primary!, notmodified!)
//
//g_emp_update = datetime(today(), now())
//gds_emp.sort()
//
//uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
//uo_choose_emp.ds_hotkey.setfilter("em_status = 'K'")
//uo_choose_emp.ds_hotkey.filter()
//
//return 0
//

if gds_emp.rowcount() <> 0 then 
	integer lcv, currow
	
	for lcv = 1 to gds_emp.rowcount()
		if cur_emp.em_id = gds_emp.getitemnumber(lcv, "em_id") then
			currow = lcv
			exit
		end if
	next
	if currow <> 0 then	
		if gds_emp.getitemstring(currow, "em_ln") = dw_emp_info.getitemstring(1, "em_ln") then 
			if gds_emp.getitemstring(currow, "em_fn") = dw_emp_info.getitemstring(1, "em_fn") then
				if gds_emp.getitemstring(currow, "em_mn") = dw_emp_info.getitemstring(1, "em_mn") then
					if gds_emp.getitemstring(currow, "em_ref") =dw_emp_info.getitemstring(1, "em_ref") then 
						if gds_emp.getitemstring(currow, "em_status") =dw_emp_info.getitemstring(1, "em_status") then 
							if gds_emp.getitemnumber(currow, "em_type") = dw_emp_info.getitemnumber(1, "em_type") then 
								if gds_emp.getitemnumber(currow, "em_class") =dw_emp_info.getitemnumber(1, "em_class") then 
									if not isnull(gds_emp.getitemnumber(currow, "di_id")) or dw_driver_info.visible <> true then 
												return 0
									end if
								end if
							 end if
						 end if
					 end if
				 end if	 
			end if			
		end if		
	//end if	
	//delrow:
	gds_emp.deleterow(currow)
	end if	
	//-------------------------------------------------------------------------
else
	//insertpart:
	integer newrow 
	newrow = gds_emp.insertrow(0)
	gds_emp.setitem(newrow, "em_id", dw_emp_info.getitemnumber(1, "em_id") )
	gds_emp.setitem(newrow, "em_ln", dw_emp_info.getitemstring(1, "em_ln") )
	gds_emp.setitem(newrow, "em_fn", dw_emp_info.getitemstring(1, "em_fn") )
	gds_emp.setitem(newrow, "em_mn", dw_emp_info.getitemstring(1, "em_mn") )
	gds_emp.setitem(newrow, "em_ref", dw_emp_info.getitemstring(1, "em_ref") )
	gds_emp.setitem(newrow, "em_type", dw_emp_info.getitemnumber(1, "em_type") )
	gds_emp.setitem(newrow, "em_status", dw_emp_info.getitemstring(1, "em_status") )
	gds_emp.setitem(newrow, "em_class", dw_emp_info.getitemnumber(1, "em_class") )
	if dw_driver_info.visible = true then 
	
	
		gds_emp.setitem(newrow, "di_id", dw_emp_info.getitemnumber(1, "em_id") )
	else
		gds_emp.setitem(newrow, "di_id", null_long)
	end if
	gds_emp.setitemstatus(newrow, 0, primary!, notmodified!)
	
	g_emp_update = datetime(today(), now())
	gds_emp.sort()
	
	uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
	uo_choose_emp.ds_hotkey.setfilter("em_status = 'K'")
	uo_choose_emp.ds_hotkey.filter()
	
	
	end if
return 0

end function

public subroutine passwords ();if isnull(cur_emp.em_id) then return

if g_privs.emp[7] = 0 then
	messagebox("Passwords", "Your current user privileges do not allow you to " +&
	"access passwords.")
	return
end if

string new_pwd
openwithparm(w_password, dw_emp_info.getitemstring(1, "em_ref"))
new_pwd = message.stringparm
if not isnull(new_pwd) then
	//Null is cancel, not an error
	dw_emp_info.object.em_password[1] = new_pwd
	if dw_emp_info.object.em_class[1] > 1001 then
	else
		messagebox("Set Password", "The employee will also need to be " +&
		"assigned to a user class in order to log on.")
	end if
	post set_user_check()
end if

end subroutine

public subroutine zz_save ();string failnote
integer retval
IF NOT gnv_app.of_GetPrivsmanager( ).of_useadvancedprivs( ) THEN
	if g_privs.emp[4] = 0 then
		messagebox("Save Changes", "Your current user privileges do not allow you to " +&
		"save changes to this screen.")
		return
	end if
END IF

retval = save_changes(failnote)

//if retval = 99 then 
//	return 
//elseif retval = -1 then
//	messagebox("Database Error", "Could not save changes.~nPress OK to switch " +&
//	"employees and abandon changes.  Press CANCEL to remain with current employee." +&
//	"~n~n" + failnote)
//end if


if retval = -1 then
	messagebox("Save Changes", "Could not save changes to database.", &
		exclamation!)
end if


end subroutine

public function integer save_changes (ref string failnote);///*  Megan's standard return codes (standard most of the time)
//	 99 = user entered information is illogical, can't update until they fix it
//	100 = no changes made, no need to update
//	  0 = update went through, commit, all OK
//	 -1 = tried to update, database error, update failed (check failnote for explanation)       
//----------------------------------------------------------------*/
//string teststr1, teststr2, teststr3, rejstr, old_ref, new_ref
//long retval = 99
//integer origsched, newsched, origclass
//date mindate
//int	li_res
//Long	ll_driverID
//Long	ll_division
//datawindowChild ldwc_tmpDivisions
//
//
//if dw_emp_info.accepttext() = -1 then return 99
//if dw_driver_info.accepttext() = -1 then return 99
//if dw_temporarydivision.acceptText( ) = -1 then return 99
//
//if dw_emp_info.modifiedcount() = 0 and dw_driver_info.modifiedcount() = 0 and dw_temporarydivision.modifiedCount() = 0 then return 100
//if isnull(cur_emp.em_id) then return 100
//
//
//
//origclass = dw_emp_info.getitemnumber(1, "em_class", primary!, true)
//if dw_driver_info.rowcount() > 0 then
//	origsched = dw_driver_info.getitemnumber(1, "di_sched_type", primary!, true)
//	newsched = dw_driver_info.getitemnumber(1, "di_sched_type")
//	mindate = dw_driver_info.getitemdate(1, "compute_min")
//end if
//
//teststr1 = dw_emp_info.object.em_fn[1]
//teststr2 = dw_emp_info.object.em_ln[1]
//rejstr = ""
//
//if isnull(teststr1) and isnull(teststr2) then
//	rejstr = "first and last"
//	dw_emp_info.setcolumn("em_ln")
//elseif isnull(teststr1) then
//	rejstr = "first"
//	dw_emp_info.setcolumn("em_fn")
//elseif isnull(teststr2) then
//	rejstr = "last"
//	dw_emp_info.setcolumn("em_ln")
//end if
//
//if len(rejstr) > 0 then
//	rejstr = "You must specify the employee's " + rejstr + " name in order to save changes."
//	dw_emp_info.setfocus()
//	goto reject
//end if
//
//if dw_emp_info.getitemstatus(1, 0, primary!) = newmodified! then
//	old_ref = ""
//else
//	old_ref = dw_emp_info.object.em_ref.original[1]
//end if
//new_ref = dw_emp_info.object.em_ref[1]
//if isnull(old_ref) then old_ref = ""
//if isnull(new_ref) then new_ref = ""
//
//if new_ref = "PTADMIN" then 
//	rejstr = "The Quick Reference Code you have specified (PTADMIN) is reserved for the " +&
//	"Profit Tools Administrator."
//	dw_emp_info.setcolumn("em_ref")
//	dw_emp_info.setfocus()
//	goto reject
//elseif len(new_ref) > 0 and not old_ref = new_ref then
//	//The preceding code verifies that the QRC we're checking is different from the one
//	//that was retrieved.  Therefore, if we get a match, its either a different emp, or
//	//someone else modified the data, which still basically fits the message given.
//	select em_fn, em_ln into :teststr2, :teststr3 from employees where em_ref = :new_ref ;
//	choose case sqlca.sqlcode
//		case -1
//			rollback ;
//			rejstr = "Could not access database to verify whether the Quick Reference "+&
//				"Code you have entered is unique."
//			goto reject
//		case 0
//			commit ;
//			rejstr = "The Quick Reference Code you have specified has already been "+&
//				"assigned to another employee, " + teststr2 + " " + teststr3 +&
//				".  Duplicate Reference Codes are not allowed."
//			dw_emp_info.setcolumn("em_ref")
//			dw_emp_info.setfocus()
//			goto reject
//		case 100
//			commit ;
//	end choose
//end if
//
//if dw_emp_info.getitemstring(1, "em_status", primary!, true) = "K" and &
//	dw_emp_info.getitemstring(1, "em_status") = "D" and &
//	isnull(dw_emp_info.getitemdate(1, "em_stop_date")) then 
//	choose case messagebox("Save Changes", "You have deactivated the current employee.  " +&
//		"Would you like to enter a termination date before saving?", question!, yesnocancel!, 1)
//	case 1
//		dw_emp_info.setfocus()
//		dw_emp_info.setcolumn("em_stop_date")
//		goto undo_and_return
//	case 3
//		goto undo_and_return
//	end choose
//elseif isnull(dw_emp_info.getitemdate(1, "em_stop_date", primary!, true)) and &
//	not isnull(dw_emp_info.getitemdate(1, "em_stop_date")) and &
//	dw_emp_info.getitemstring(1, "em_status") = "K" then 
//	choose case messagebox("Save Changes", "You have given this employee a termination " +&
//		"date but their status is still listed as 'ACTIVE'.  Would you like to deactivate " +&
//		"the employee before saving?", question!, yesnocancel!, 1)
//	case 1
//		dw_emp_info.setfocus()
//		dw_emp_info.setcolumn("em_status")
//		goto undo_and_return
//	case 3
//		goto undo_and_return
//	end choose
//end if
//
//if cur_emp.em_id = 0 then //new employee
//	long maxid
//	select max(em_id) into :maxid from employees ;
//	if sqlca.sqlcode <> 0 then goto rollitback
//	commit ;
//	if isnull(maxid) then maxid = 0
//	maxid ++
//	dw_emp_info.object.em_id[1] = maxid
//	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = maxid
//elseif origsched <> newsched and not isnull(mindate) then
//	if origsched = 8 and newsched = 7 then // must delete first row
//		delete from driver_logs where dl_id = :cur_emp.em_id and dl_date = :mindate ;
//		mindate = relativedate(mindate, 1)
//	else //must insert
//		mindate = relativedate(mindate, -1)
//		teststr1 = fill("7", 96)
//		insert into driver_logs (dl_id, dl_date, dl_log, dl_odtot, dl_drtot, dl_miles)
//			values(:cur_emp.em_id, :mindate, :teststr1, 0, 0, 0) ;
//	end if
//	if sqlca.sqlcode <> 0 then goto rollitback
//end if
//
//if origclass <> dw_emp_info.getitemnumber(1, "em_class") then
//	delete from system_settings where ss_uid = :cur_emp.em_id and 
//		( ( ss_id > 9000 and ss_id <= 9999 ) or ( ss_id > 19000 and ss_id <= 19999  ) ) ;
//	if sqlca.sqlcode = 100 or sqlca.sqlcode = 0 then
//	else
//		goto rollitback 
//	end if
//end if
//
//if dw_emp_info.update(false, false) = -1 then goto rollitback
//
//if dw_driver_info.modifiedcount() > 0 then
//	if dw_driver_info.rowcount() > 0 then &
//		dw_driver_info.setitem(1, "di_intsig", dw_driver_info.getitemnumber(1, "di_intsig") + 1)
//	if dw_driver_info.update(false, false) = -1 then goto rollitback
//	
//end if
//
////added by Dan (when in rome do as romans do)
//dw_temporarydivision.getChild( "tmpdivision", ldwc_tmpDivisions )
//
////if its changed, i have to see if it was set to null, if so i delete the row
////from the database.  IF it hasn't changed, then i want to discard any rows
////that were inserted as nulls so i can avoid db update errors.
//IF dw_driver_info.rowCount() > 0 THEN
//	ll_division = dw_driver_Info.getItemNumber( 1, "di_division" )
//	IF dw_temporarydivision.modifiedCOunt() > 0 THEN
//		IF isNUll(dw_temporarydivision.getItemNumber( 1, "tmpdivision")) THEN
//			dw_temporaryDivision.deleterow( 1 )
//		END IF
//	ELSE
//		IF dw_temporarydivision.rowCount() > 0 THEN
//			IF ll_division = dw_temporarydivision.getItemNumber( 1, "tmpdivision" ) THEN
//				dw_temporarydivision.deleterow( 1 )
//			END IF
//		END IF
//		dw_temporarydivision.rowsDiscard( 1, 1, PRIMARY!)
//	END IF
//
//	
//	//if the tmp division is the same as the primary division, then we 
//	//want to delete the tmp from the database.
//	
//	IF isNull( ll_division ) THEN
//		ll_division = 0		//set it to show a blank
//	ELSE
//		IF dw_temporarydivision.rowCount() > 0 THEN
//			IF ll_division = dw_temporarydivision.getItemNumber( 1, "tmpdivision" ) THEN
//				dw_temporarydivision.deleterow( 1 )
//			END IF
//		END IF
//	END IF
//	
//	li_res = dw_temporarydivision.update(  )
//	IF li_Res = -1 THEN
//		rollback;
//	ELSE
//		//if the update succeeded than i need to repopulate the temporary window
//		IF dw_temporarydivision.rowCOunt() = 0 THEN
//			dw_temporarydivision.insertRow( 0 )
//			ll_driverId = dw_driver_info.getItemNumber( 1, "di_id")
//			dw_temporarydivision.setItem( 1, "di_id", ll_driverId )
//		END IF
//		this.wf_populatedivisions( ll_division, ldwc_tmpDivisions)
//		
//	END IF
//END IF
//
//
////--------------------------------------------------
//commit ;
//
//
//dw_emp_info.resetupdate()
//if dw_driver_info.rowcount() > 0 then dw_driver_info.setitem(1, "compute_min", mindate)
//dw_driver_info.resetupdate()
//
//
//
//cur_emp.em_id = dw_emp_info.object.em_id[1]
//cur_emp.em_ln = dw_emp_info.getitemstring(1, "em_ln")
//cur_emp.em_fn = dw_emp_info.getitemstring(1, "em_fn")
//cur_emp.em_ref = dw_emp_info.getitemstring(1, "em_ref")
//
//update_gds()
//
//uo_choose_emp.cur_emp = cur_emp
//uo_choose_emp.set_emp(false)
//
//return 0
//
//rollitback :
//rollback ;
//retval = -1
//goto undo_and_return
//
//reject:
//messagebox("Save Changes", rejstr + "~n~nSave request canceled.", exclamation!)
//
//undo_and_return:
//
////If this is a new emp, clear the id that was assigned to them
//if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
//	dw_emp_info.object.em_id[1] = 0
//	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
//end if
//
////Retval is set to 99 when it is declared, so calling undo_and_return without specifying
////a different value returns 99
//return retval

/*  Megan's standard return codes (standard most of the time)
	 99 = user entered information is illogical, can't update until they fix it
	100 = no changes made, no need to update
	  0 = update went through, commit, all OK
	 -1 = tried to update, database error, update failed (check failnote for explanation)       
----------------------------------------------------------------*/
string teststr1, teststr2, teststr3, rejstr, old_ref, new_ref
long retval = 99
integer origsched, newsched, origclass
date mindate
int	li_res
Long	ll_driverID
Long	ll_division
datawindowChild ldwc_tmpDivisions


if dw_emp_info.accepttext() = -1 then return 99
if dw_driver_info.accepttext() = -1 then return 99
if dw_temporarydivision.acceptText( ) = -1 then return 99

if dw_emp_info.modifiedcount() = 0 and dw_driver_info.modifiedcount() = 0 and dw_temporarydivision.modifiedCount() = 0 then return 100
if isnull(cur_emp.em_id) then return 100



origclass = dw_emp_info.getitemnumber(1, "em_class", primary!, true)
if dw_driver_info.rowcount() > 0 then
	origsched = dw_driver_info.getitemnumber(1, "di_sched_type", primary!, true)
	newsched = dw_driver_info.getitemnumber(1, "di_sched_type")
	mindate = dw_driver_info.getitemdate(1, "compute_min")
end if

teststr1 = dw_emp_info.object.em_fn[1]
teststr2 = dw_emp_info.object.em_ln[1]
rejstr = ""

if isnull(teststr1) and isnull(teststr2) then
	rejstr = "first and last"
	dw_emp_info.setcolumn("em_ln")
elseif isnull(teststr1) then
	rejstr = "first"
	dw_emp_info.setcolumn("em_fn")
elseif isnull(teststr2) then
	rejstr = "last"
	dw_emp_info.setcolumn("em_ln")
end if

if len(rejstr) > 0 then
	rejstr = "You must specify the employee's " + rejstr + " name in order to save changes."
	dw_emp_info.setfocus()
	//goto reject
	messagebox("Save Changes", rejstr + "~n~nSave request canceled.", exclamation!)
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
end if

if dw_emp_info.getitemstatus(1, 0, primary!) = newmodified! then
	old_ref = ""
else
	old_ref = dw_emp_info.object.em_ref.original[1]
end if
new_ref = dw_emp_info.object.em_ref[1]
if isnull(old_ref) then old_ref = ""
if isnull(new_ref) then new_ref = ""

if new_ref = "PTADMIN" then 
	rejstr = "The Quick Reference Code you have specified (PTADMIN) is reserved for the " +&
	"Profit Tools Administrator."
	dw_emp_info.setcolumn("em_ref")
	dw_emp_info.setfocus()
	//goto reject
	messagebox("Save Changes", rejstr + "~n~nSave request canceled.", exclamation!)
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
elseif len(new_ref) > 0 and not old_ref = new_ref then
	//The preceding code verifies that the QRC we're checking is different from the one
	//that was retrieved.  Therefore, if we get a match, its either a different emp, or
	//someone else modified the data, which still basically fits the message given.
	select em_fn, em_ln into :teststr2, :teststr3 from employees where em_ref = :new_ref ;
	choose case sqlca.sqlcode
		case -1
			rollback ;
			rejstr = "Could not access database to verify whether the Quick Reference "+&
				"Code you have entered is unique."
			//goto reject
			messagebox("Save Changes", rejstr + "~n~nSave request canceled.", exclamation!)
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
		case 0
			commit ;
			rejstr = "The Quick Reference Code you have specified has already been "+&
				"assigned to another employee, " + teststr2 + " " + teststr3 +&
				".  Duplicate Reference Codes are not allowed."
			dw_emp_info.setcolumn("em_ref")
			dw_emp_info.setfocus()
			//goto reject
			messagebox("Save Changes", rejstr + "~n~nSave request canceled.", exclamation!)
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
		case 100
			commit ;
	end choose
end if

if dw_emp_info.getitemstring(1, "em_status", primary!, true) = "K" and &
	dw_emp_info.getitemstring(1, "em_status") = "D" and &
	isnull(dw_emp_info.getitemdate(1, "em_stop_date")) then 
	choose case messagebox("Save Changes", "You have deactivated the current employee.  " +&
		"Would you like to enter a termination date before saving?", question!, yesnocancel!, 1)
	case 1
		dw_emp_info.setfocus()
		dw_emp_info.setcolumn("em_stop_date")
		//goto undo_and_return
		//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
	case 3
		//goto undo_and_return
		//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
	end choose
elseif isnull(dw_emp_info.getitemdate(1, "em_stop_date", primary!, true)) and &
	not isnull(dw_emp_info.getitemdate(1, "em_stop_date")) and &
	dw_emp_info.getitemstring(1, "em_status") = "K" then 
	choose case messagebox("Save Changes", "You have given this employee a termination " +&
		"date but their status is still listed as 'ACTIVE'.  Would you like to deactivate " +&
		"the employee before saving?", question!, yesnocancel!, 1)
	case 1
		dw_emp_info.setfocus()
		dw_emp_info.setcolumn("em_status")
		//goto undo_and_return
		//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
	case 3
		//goto undo_and_return
		//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
	end choose
end if

if cur_emp.em_id = 0 then //new employee
	long maxid
	select max(em_id) into :maxid from employees ;
	if sqlca.sqlcode <> 0 then 
		//goto rollitback
		rollback ;
retval = -1
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
	end if	
	commit ;
	if isnull(maxid) then maxid = 0
	maxid ++
	dw_emp_info.object.em_id[1] = maxid
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = maxid
elseif origsched <> newsched and not isnull(mindate) then
	if origsched = 8 and newsched = 7 then // must delete first row
		delete from driver_logs where dl_id = :cur_emp.em_id and dl_date = :mindate ;
		mindate = relativedate(mindate, 1)
	else //must insert
		mindate = relativedate(mindate, -1)
		teststr1 = fill("7", 96)
		insert into driver_logs (dl_id, dl_date, dl_log, dl_odtot, dl_drtot, dl_miles)
			values(:cur_emp.em_id, :mindate, :teststr1, 0, 0, 0) ;
	end if
	if sqlca.sqlcode <> 0 then 
		//goto rollitback
		rollback ;
retval = -1
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
	end if	
end if

if origclass <> dw_emp_info.getitemnumber(1, "em_class") then
	delete from system_settings where ss_uid = :cur_emp.em_id and 
		( ( ss_id > 9000 and ss_id <= 9999 ) or ( ss_id > 19000 and ss_id <= 19999  ) ) ;
	if sqlca.sqlcode = 100 or sqlca.sqlcode = 0 then
	else
		//goto rollitback 
		rollback ;
retval = -1
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
	end if
end if

if dw_emp_info.update(false, false) = -1 then 
	//goto rollitback
	rollback ;
retval = -1
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
end if	

if dw_driver_info.modifiedcount() > 0 then
	if dw_driver_info.rowcount() > 0 then &
		dw_driver_info.setitem(1, "di_intsig", dw_driver_info.getitemnumber(1, "di_intsig") + 1)
	if dw_driver_info.update(false, false) = -1 then
		//goto rollitback
		rollback ;
retval = -1
//If this is a new emp, clear the id that was assigned to them
if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
	dw_emp_info.object.em_id[1] = 0
	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
end if

//Retval is set to 99 when it is declared, so calling undo_and_return without specifying
//a different value returns 99
return retval
		
	end if	
	
end if

//added by Dan (when in rome do as romans do)
dw_temporarydivision.getChild( "tmpdivision", ldwc_tmpDivisions )

//if its changed, i have to see if it was set to null, if so i delete the row
//from the database.  IF it hasn't changed, then i want to discard any rows
//that were inserted as nulls so i can avoid db update errors.
IF dw_driver_info.rowCount() > 0 THEN
	ll_division = dw_driver_Info.getItemNumber( 1, "di_division" )
	IF dw_temporarydivision.modifiedCOunt() > 0 THEN
		IF isNUll(dw_temporarydivision.getItemNumber( 1, "tmpdivision")) THEN
			dw_temporaryDivision.deleterow( 1 )
		END IF
	ELSE
		IF dw_temporarydivision.rowCount() > 0 THEN
			IF ll_division = dw_temporarydivision.getItemNumber( 1, "tmpdivision" ) THEN
				dw_temporarydivision.deleterow( 1 )
			END IF
		END IF
		dw_temporarydivision.rowsDiscard( 1, 1, PRIMARY!)
	END IF

	
	//if the tmp division is the same as the primary division, then we 
	//want to delete the tmp from the database.
	
	IF isNull( ll_division ) THEN
		ll_division = 0		//set it to show a blank
	ELSE
		IF dw_temporarydivision.rowCount() > 0 THEN
			IF ll_division = dw_temporarydivision.getItemNumber( 1, "tmpdivision" ) THEN
				dw_temporarydivision.deleterow( 1 )
			END IF
		END IF
	END IF
	
	li_res = dw_temporarydivision.update(  )
	IF li_Res = -1 THEN
		rollback;
	ELSE
		//if the update succeeded than i need to repopulate the temporary window
		IF dw_temporarydivision.rowCOunt() = 0 THEN
			dw_temporarydivision.insertRow( 0 )
			ll_driverId = dw_driver_info.getItemNumber( 1, "di_id")
			dw_temporarydivision.setItem( 1, "di_id", ll_driverId )
		END IF
		this.wf_populatedivisions( ll_division, ldwc_tmpDivisions)
		
	END IF
END IF


//--------------------------------------------------
commit ;


dw_emp_info.resetupdate()
if dw_driver_info.rowcount() > 0 then dw_driver_info.setitem(1, "compute_min", mindate)
dw_driver_info.resetupdate()



cur_emp.em_id = dw_emp_info.object.em_id[1]
cur_emp.em_ln = dw_emp_info.getitemstring(1, "em_ln")
cur_emp.em_fn = dw_emp_info.getitemstring(1, "em_fn")
cur_emp.em_ref = dw_emp_info.getitemstring(1, "em_ref")

update_gds()

uo_choose_emp.cur_emp = cur_emp
uo_choose_emp.set_emp(false)

return 0

//rollitback:
//rollback ;
//retval = -1
////If this is a new emp, clear the id that was assigned to them
//if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
//	dw_emp_info.object.em_id[1] = 0
//	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
//end if
//
////Retval is set to 99 when it is declared, so calling undo_and_return without specifying
////a different value returns 99
//return retval
//
//reject:
//messagebox("Save Changes", rejstr + "~n~nSave request canceled.", exclamation!)
////If this is a new emp, clear the id that was assigned to them
//if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
//	dw_emp_info.object.em_id[1] = 0
//	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
//end if
//
////Retval is set to 99 when it is declared, so calling undo_and_return without specifying
////a different value returns 99
//return retval
//
//undo_and_return:
//
////If this is a new emp, clear the id that was assigned to them
//if cur_emp.em_id = 0 and dw_emp_info.object.em_id[1] > 0 then
//	dw_emp_info.object.em_id[1] = 0
//	if dw_driver_info.rowcount() > 0 then dw_driver_info.object.di_id[1] = 0
//end if
//
////Retval is set to 99 when it is declared, so calling undo_and_return without specifying
////a different value returns 99
//return retval
end function

protected subroutine set_user_check ();n_cst_setting_advancedPrivs lnv_setting
String	ls_usePrivs
string checkstr = "User Checklist: "
boolean has_pwd, has_ref, show_it = true
//added by dan
boolean		lb_hasDefDivs
datastore	lds_divisionDefault

lds_divisionDefault = create datastore
lds_divisionDefault.dataobject = "d_employeedivisiondefaults"
lds_divisionDefault.settransobject( SQLCA )

lnv_setting = create n_cst_setting_advancedPrivs

ls_usePrivs = lnv_setting.of_getValue()

if dw_emp_info.rowcount() = 1 then
	if dw_emp_info.object.em_class[1] = 1001 then show_it = false
	
//	//added by Dan
//	IF lds_divisionDefault.retrieve( dw_emp_Info.getItemNumber( 1, "em_id" ) ) = 0 THEN
//		show_it = true
//	ELSE
//		lb_hasDefDivs = true
//	END IF
//	commit;
	
else
	show_it = false
end if

if not show_it then
	st_user_check.text = checkstr
	st_user_check.textcolor = 0
	st_user_check.visible = false
	return
end if

if len(dw_emp_info.getitemstring(1, "em_password")) > 0 then has_pwd = true
if len(dw_emp_info.getitemstring(1, "em_ref")) > 0 then has_ref = true

if has_pwd and has_ref then
	checkstr += "User can log on."
	st_user_check.textcolor = 0
	
	//added by dan
	IF NOT lb_hasDefDivs AND ls_usePrivs = "Yes" THEN
		checkstr += "User Needs Default Divisions."
	END IF
else
	st_user_check.textcolor = 128
	checkstr += "User needs "
	if has_pwd then
		checkstr += "Quick Ref. Code."
	elseif has_ref then
		checkstr += "Password."
	else
		checkstr += "Quick Ref. Code and Password."
	end if
	
	//added by dan
//	IF NOT lb_hasDefDivs AND ls_usePrivs = "Yes" THEN
//		IF len(checkstr) > 0 THEN
//			checkstr += " Division Defaults."
//		ELSE
//			checkstr += "User Needs Div. Defaults."
//		END IF
//	END IF
end if

st_user_check.text = checkstr
st_user_check.visible = true

DESTROY lnv_setting
Destroy lds_divisionDefault
end subroutine

public subroutine emp_switch (integer uo_num);//s_emp_info temp_emp
//temp_emp = uo_choose_emp.temp_emp
//Long	ll_division
//Long	ll_tmpDivision
//Long	ll_rows
//Long		ll_GreyOutColor
//Boolean	lb_AllowModify
//Boolean	lb_GreyOut
//String	lsa_ExcludeCols[]
//DatawindowChild	ldwc_divisions
//DatawindowChild	ldwc_tmpDivisions
//
//n_cst_PrivsManager	lnv_PrivsManager
//
//
//n_cst_Presentation_State	lnv_Presentation
//
//if isnull(temp_emp.em_id) then 
//	//goto reset_emp
//	uo_choose_emp.set_emp(false)
//return
//end if	
//if temp_emp.em_id = 0 then
//	//I don't know if this can happen (Brian).  Megan had this script (emp_switch) add the
//	//employee under this circumstance.  Unless there's some way for the user to initiate
//	//an add emp request from within the user object, this is actually an error and should
//	//be reported as such.
//	post add_new()
//	return
//end if
//if isnull(cur_emp.em_id) then goto retpart
//
//if dw_driver_info.accepttext() = -1 or  dw_emp_info.accepttext() = -1 then 
//	//goto reset_emp
//	uo_choose_emp.set_emp(false)
//return
//end if	
//if dw_driver_info.modifiedcount() = 0 and dw_emp_info.modifiedcount() = 0 then goto retpart
//
//choose case messagebox("Switch Employees", "Save changes to the current employee first?", &
//	question!, yesnocancel!, 1)
//case 2
//	goto retpart
//case 3
//	//goto reset_emp
//	uo_choose_emp.set_emp(false)
//return
//end choose
//
//string failnote
//choose case save_changes(failnote)
//case 99
//	//goto reset_emp
//	uo_choose_emp.set_emp(false)
//return
//case -1
//	if messagebox("Save Changes", "Could not save changes to database.~nPress OK to " +&
//	"abandon changes and switch employees, or press Cancel to return to the current " +&
//	"employee and preserve changes for now.", exclamation!, okcancel!, 1) = 2 &
//		then
//		//goto reset_emp
//		uo_choose_emp.set_emp(false)
//return
//		end if
//end choose
//
////-----------------------------------------------------------------retpart
//retpart:
//
//lnv_PrivsManager = gnv_App.of_GetPrivsManager( )
//
//IF lnv_Privsmanager.of_UseAdvancedPrivs( ) THEN
//	
//	SELECT "driverinfo"."di_division" 
//	INTO :ll_division
//	FROM "driverinfo"  
//	WHERE "driverinfo"."di_id" = :temp_emp.em_id;
//	COMMIT;
//	
//	IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyEmployee, ll_Division) <> 1 THEN
//		//Disable controls if user does not have permission to modify this employee
//		lb_AllowModify = FALSE
//		lb_GreyOut = TRUE
//		ll_GreyOutColor = 29425663
//		lnv_Presentation.of_SetEnablement(dw_emp_info, lb_AllowModify, lsa_ExcludeCols, lb_GreyOut, ll_GreyOutColor)
//		lnv_Presentation.of_SetEnablement(dw_temporarydivision, lb_AllowModify, lsa_ExcludeCols, lb_GreyOut, ll_GreyOutColor)
//		lsa_Excludecols = {"di_dutystatusdatetime"}
//		lnv_Presentation.of_SetEnablement(dw_driver_info, lb_AllowModify, lsa_ExcludeCols, lb_GreyOut, ll_GreyOutColor)
//		
//		st_driver_privs.Enabled = FALSE
//	ELSE
//		//Re-enable the emp info and driver info dws
//		//Resets the dataobjects so that the original design-time dw properties take effect
//		dw_emp_info.DataObject = ""
//		dw_emp_info.DataObject = "d_emp_info"
//		dw_emp_info.SetTransObject(SQLCA)
//		lnv_Presentation.of_SetPresentation ( dw_emp_info )
//		dw_driver_info.DataObject = ""
//		dw_driver_info.DataObject = "d_driver_info"
//		dw_driver_info.SetTransObject(SQLCA)
//		lnv_Presentation.of_SetPresentation ( dw_driver_info )
//		
//		//Re-enable temp division dw
//		lb_AllowModify = TRUE
//		lnv_Presentation.of_SetEnablement(dw_temporarydivision, lb_AllowModify)
//		
//		st_driver_privs.Enabled = TRUE
//	END IF
//END IF
//
////Hide employee info if user does not have permission to view this employee
//IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ViewEmployee, ll_Division) <> 1 THEN
//	//goto hide_details
//	dw_emp_info.reset()
//dw_driver_info.reset()
//dw_temporarydivision.reset()
//st_user_check.Visible = False
//cb_make_driver.visible = False
//st_NoPrivs.Visible = True
//cur_emp = temp_emp
//uo_choose_emp.set_emp(True)
//dw_emp_info.Enabled = False //Disable User Alert Menu
//return
//END IF
//
//dw_driver_info.setredraw(false)
//dw_emp_info.setredraw(false)
//
//dw_emp_info.reset()
//dw_driver_info.reset()
//
//IF lnv_PrivsManager.of_useadvancedprivs( ) THEN
//	dw_emp_info.Enabled = TRUE
//ELSE
//	dw_emp_info.Enabled = False //Enable incase disabled by hide_details
//END IF
//
//if dw_emp_info.retrieve(temp_emp.em_id) = -1 then 
//	//goto rollitback
//	rollback ;
//messagebox("Switch Employees", "Could not retrieve information for the employee you "+&
//	"requested.~n~nWindow will close.", exclamation!)
//winisclosing = true
//close(this)
//
//end if	
//
//if dw_emp_info.rowcount() > 0 then 
//	if dw_driver_info.retrieve(temp_emp.em_id) = -1 then
//		//goto rollitback
//		rollback ;
//messagebox("Switch Employees", "Could not retrieve information for the employee you "+&
//	"requested.~n~nWindow will close.", exclamation!)
//winisclosing = true
//close(this)
//end if
//	
//	//added by dan to populate the child datawindow with divisions
//		dw_driver_info.getChild( "di_division", ldwc_divisions )
//	
//		This.wf_populatedivisions( ll_division, ldwc_divisions )
//	
//	
////		SELECT "driverdivisions"."tmpdivision" 
////			 INTO :ll_tmpDivision
////			 FROM "driverdivisions"  
////			WHERE "driverdivisions"."di_id" = :temp_emp.em_id
////					  ;
////		COMMIT;
//
//		ll_rows = dw_temporarydivision.retrieve(temp_emp.em_id)
//		IF ll_rows <> -1 THEN
//			IF ll_rows = 0 THEN
//				dw_temporarydivision.insertRow(0)
//				dw_temporarydivision.setItem( 1, "di_id", temp_emp.em_id )
//			END IF
//			dw_temporarydivision.getChild( "tmpdivision", ldwc_tmpDivisions )
//			this.wf_populateDivisions( ll_tmpDivision, ldwc_tmpDivisions )
//		END IF
//	//--------------------------------------------------------------
//else
//	//goto rollitback
//	rollback ;
//messagebox("Switch Employees", "Could not retrieve information for the employee you "+&
//	"requested.~n~nWindow will close.", exclamation!)
//winisclosing = true
//close(this)
//
//end if
//
//commit ;
//st_NoPrivs.Visible = False
//cur_emp = temp_emp
//uo_choose_emp.set_emp(true)
//
//dw_emp_info.setredraw(true)
//dw_driver_info.setredraw(true)
//if dw_driver_info.rowcount() > 0 then is_driver(true) else is_driver(false)
//set_user_check()
////dw_emp_info.enabled = true
////cb_make_driver.enabled = true
//dw_emp_info.setcolumn("em_ln")
//dw_emp_info.setfocus()
//dw_temporarydivision.bringtotop = true
//THIS.Post wf_ShowAlerts ( )
//
//return
//
////reset_emp:
////uo_choose_emp.set_emp(false)
////return
//
////hide_details: 
////dw_emp_info.reset()
////dw_driver_info.reset()
////dw_temporarydivision.reset()
////st_user_check.Visible = False
////cb_make_driver.visible = False
////st_NoPrivs.Visible = True
////cur_emp = temp_emp
////uo_choose_emp.set_emp(True)
////dw_emp_info.Enabled = False //Disable User Alert Menu
////return
//
////rollitback:
////rollback ;
////messagebox("Switch Employees", "Could not retrieve information for the employee you "+&
////	"requested.~n~nWindow will close.", exclamation!)
////winisclosing = true
////close(this)
////
//
//


s_emp_info temp_emp
temp_emp = uo_choose_emp.temp_emp
Long	ll_division
Long	ll_tmpDivision
Long	ll_rows
Long		ll_GreyOutColor
Boolean	lb_AllowModify
Boolean	lb_GreyOut
String	lsa_ExcludeCols[]
DatawindowChild	ldwc_divisions
DatawindowChild	ldwc_tmpDivisions

n_cst_PrivsManager	lnv_PrivsManager

int li_re
n_cst_Presentation_State	lnv_Presentation

if isnull(temp_emp.em_id) then 
	//goto reset_emp
	uo_choose_emp.set_emp(false)
return
end if	
if temp_emp.em_id = 0 then
	//I don't know if this can happen (Brian).  Megan had this script (emp_switch) add the
	//employee under this circumstance.  Unless there's some way for the user to initiate
	//an add emp request from within the user object, this is actually an error and should
	//be reported as such.
	post add_new()
	return
end if
if  not isnull(cur_emp.em_id) then 

	if dw_driver_info.accepttext() = -1 or  dw_emp_info.accepttext() = -1 then 
		//goto reset_emp
		uo_choose_emp.set_emp(false)
	return
	end if	
	
	if dw_driver_info.modifiedcount() <>0 or dw_emp_info.modifiedcount() <> 0 then
	
		li_re =  messagebox("Switch Employees", "Save changes to the current employee first?", question!, yesnocancel!, 1)
		
		if li_re =  3 then
			//goto reset_emp
			uo_choose_emp.set_emp(false)
			return
		elseif	li_re =  1 then
		
		
		string failnote
		choose case save_changes(failnote)
		case 99
			//goto reset_emp
			uo_choose_emp.set_emp(false)
		return
		case -1
			if messagebox("Save Changes", "Could not save changes to database.~nPress OK to " +&
			"abandon changes and switch employees, or press Cancel to return to the current " +&
			"employee and preserve changes for now.", exclamation!, okcancel!, 1) = 2 &
				then
				//goto reset_emp
				uo_choose_emp.set_emp(false)
		return
				end if
		end choose
	end if
	end if	
END IF
//-----------------------------------------------------------------retpart
//retpart:

lnv_PrivsManager = gnv_App.of_GetPrivsManager( )

IF lnv_Privsmanager.of_UseAdvancedPrivs( ) THEN
	
	SELECT "driverinfo"."di_division" 
	INTO :ll_division
	FROM "driverinfo"  
	WHERE "driverinfo"."di_id" = :temp_emp.em_id;
	COMMIT;
	
	IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyEmployee, ll_Division) <> 1 THEN
		//Disable controls if user does not have permission to modify this employee
		lb_AllowModify = FALSE
		lb_GreyOut = TRUE
		ll_GreyOutColor = 29425663
		lnv_Presentation.of_SetEnablement(dw_emp_info, lb_AllowModify, lsa_ExcludeCols, lb_GreyOut, ll_GreyOutColor)
		lnv_Presentation.of_SetEnablement(dw_temporarydivision, lb_AllowModify, lsa_ExcludeCols, lb_GreyOut, ll_GreyOutColor)
		lsa_Excludecols = {"di_dutystatusdatetime"}
		lnv_Presentation.of_SetEnablement(dw_driver_info, lb_AllowModify, lsa_ExcludeCols, lb_GreyOut, ll_GreyOutColor)
		
		st_driver_privs.Enabled = FALSE
	ELSE
		//Re-enable the emp info and driver info dws
		//Resets the dataobjects so that the original design-time dw properties take effect
		dw_emp_info.DataObject = ""
		dw_emp_info.DataObject = "d_emp_info"
		dw_emp_info.SetTransObject(SQLCA)
		lnv_Presentation.of_SetPresentation ( dw_emp_info )
		dw_driver_info.DataObject = ""
		dw_driver_info.DataObject = "d_driver_info"
		dw_driver_info.SetTransObject(SQLCA)
		lnv_Presentation.of_SetPresentation ( dw_driver_info )
		
		//Re-enable temp division dw
		lb_AllowModify = TRUE
		lnv_Presentation.of_SetEnablement(dw_temporarydivision, lb_AllowModify)
		
		st_driver_privs.Enabled = TRUE
	END IF
END IF

//Hide employee info if user does not have permission to view this employee
IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ViewEmployee, ll_Division) <> 1 THEN
	//goto hide_details
	dw_emp_info.reset()
dw_driver_info.reset()
dw_temporarydivision.reset()
st_user_check.Visible = False
cb_make_driver.visible = False
st_NoPrivs.Visible = True
cur_emp = temp_emp
uo_choose_emp.set_emp(True)
dw_emp_info.Enabled = False //Disable User Alert Menu
return
END IF

dw_driver_info.setredraw(false)
dw_emp_info.setredraw(false)

dw_emp_info.reset()
dw_driver_info.reset()

IF lnv_PrivsManager.of_useadvancedprivs( ) THEN
	dw_emp_info.Enabled = TRUE
ELSE
	dw_emp_info.Enabled = False //Enable incase disabled by hide_details
END IF

if dw_emp_info.retrieve(temp_emp.em_id) = -1 then 
	//goto rollitback
	rollback ;
messagebox("Switch Employees", "Could not retrieve information for the employee you "+&
	"requested.~n~nWindow will close.", exclamation!)
winisclosing = true
close(this)

end if	

if dw_emp_info.rowcount() > 0 then 
	if dw_driver_info.retrieve(temp_emp.em_id) = -1 then
		//goto rollitback
		rollback ;
messagebox("Switch Employees", "Could not retrieve information for the employee you "+&
	"requested.~n~nWindow will close.", exclamation!)
winisclosing = true
close(this)
end if
	
	//added by dan to populate the child datawindow with divisions
		dw_driver_info.getChild( "di_division", ldwc_divisions )
	
		This.wf_populatedivisions( ll_division, ldwc_divisions )
	
	
//		SELECT "driverdivisions"."tmpdivision" 
//			 INTO :ll_tmpDivision
//			 FROM "driverdivisions"  
//			WHERE "driverdivisions"."di_id" = :temp_emp.em_id
//					  ;
//		COMMIT;

		ll_rows = dw_temporarydivision.retrieve(temp_emp.em_id)
		IF ll_rows <> -1 THEN
			IF ll_rows = 0 THEN
				dw_temporarydivision.insertRow(0)
				dw_temporarydivision.setItem( 1, "di_id", temp_emp.em_id )
			END IF
			dw_temporarydivision.getChild( "tmpdivision", ldwc_tmpDivisions )
			this.wf_populateDivisions( ll_tmpDivision, ldwc_tmpDivisions )
		END IF
	//--------------------------------------------------------------
else
	//goto rollitback
	rollback ;
messagebox("Switch Employees", "Could not retrieve information for the employee you "+&
	"requested.~n~nWindow will close.", exclamation!)
winisclosing = true
close(this)

end if

commit ;
st_NoPrivs.Visible = False
cur_emp = temp_emp
uo_choose_emp.set_emp(true)

dw_emp_info.setredraw(true)
dw_driver_info.setredraw(true)
if dw_driver_info.rowcount() > 0 then is_driver(true) else is_driver(false)
set_user_check()
//dw_emp_info.enabled = true
//cb_make_driver.enabled = true
dw_emp_info.setcolumn("em_ln")
dw_emp_info.setfocus()
dw_temporarydivision.bringtotop = true
THIS.Post wf_ShowAlerts ( )
return
end subroutine

public subroutine wf_history_report ();n_cst_bso_FuelTax lnv_fuelTax
long ll_subject


ll_subject = cur_emp.em_id

choose case ll_subject
case is > 0
	if dw_driver_info.rowcount() > 0 then
		
		lnv_FuelTax = create n_cst_bso_FuelTax
		lnv_FuelTax.of_process_report("DRIVER!", ll_subject , appeon_constant.cs_Context_HistoryReport)
		destroy lnv_FuelTax
		
	else
		messagebox("Driver History Report", "This report is only available for drivers.")
	end if
case else
	messagebox("Driver History Report", "The report is not available for "+&
		"unsaved employees.")
end choose
end subroutine

protected function integer wf_create_toolmenu ();s_toolmenu lstr_toolmenu
n_cst_LicenseManager	lnv_LicenseManager

if isvalid(inv_cst_toolmenu_manager) then return 0

inv_cst_toolmenu_manager = create n_cst_toolmenu_manager
inv_cst_toolmenu_manager.of_set_parent(this)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_toolmenu_manager.of_add_standard("SAVE!")

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "NEW!"
lstr_toolmenu.s_toolbutton_picture = "empnew.bmp"
lstr_toolmenu.s_toolbutton_text = "NEW EMP"
lstr_toolmenu.s_menuitem_text = "Add &New Employee"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "PASSWORD!"
lstr_toolmenu.s_toolbutton_picture = "key.bmp"
lstr_toolmenu.s_toolbutton_text = "PASSWORD"
lstr_toolmenu.s_menuitem_text = "Change User &Password"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "NOTES!"
lstr_toolmenu.s_toolbutton_picture = "notes.bmp"
lstr_toolmenu.s_toolbutton_text = "NOTES"
lstr_toolmenu.s_menuitem_text = "Edit N&otes"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
lstr_toolmenu.s_name = "ADMINNOTES!"
lstr_toolmenu.s_toolbutton_picture = "notes.bmp"
lstr_toolmenu.s_toolbutton_text = "ADMIN"
lstr_toolmenu.s_menuitem_text = "Edit Administrative No&tes"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Settlements ) THEN
	inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
	lstr_toolmenu.s_name = "PAYABLES_SETUP!"
	lstr_toolmenu.s_menuitem_text = "Pa&yables Setup"
	inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
END IF

inv_cst_toolmenu_manager.of_add_standard("DIVIDER!")

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "HISTORY_REPORT!"
lstr_toolmenu.s_menuitem_text = "Driver &History Report"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "FLEET_HISTORY_REPORT!"
lstr_toolmenu.s_menuitem_text = "&Fleet History Report"
inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)

//inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "DIVISIONDEFAULTS!"
//lstr_toolmenu.s_toolbutton_picture = "notes.bmp"
//lstr_toolmenu.s_toolbutton_text = "DIVISIONS"
//lstr_toolmenu.s_menuitem_text = "Edit Division Defaults"
//inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)
//
//inv_cst_toolmenu_manager.of_make_default(lstr_toolmenu, true, true)
//lstr_toolmenu.s_name = "USERPRIVS!"
//lstr_toolmenu.s_toolbutton_picture = "notes.bmp"
//lstr_toolmenu.s_toolbutton_text = "PRIVILEGES"
//lstr_toolmenu.s_menuitem_text = "Edit User Privileges"
//inv_cst_toolmenu_manager.of_add_toolmenu(lstr_toolmenu)


inv_cst_toolmenu_manager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);Long	ll_empId
CHOOSE CASE as_Request

CASE "SAVE!"
	zz_save()

CASE "NEW!"
	add_new()

CASE "PASSWORD!"
	passwords()

CASE "HISTORY_REPORT!"
	wf_history_report()

CASE "FLEET_HISTORY_REPORT!"
	wf_FleetHistoryReport ( )

CASE "NOTES!"
	wf_Notes ( )

CASE "ADMINNOTES!"
	wf_AdministrativeNotes ( )

CASE "PAYABLES_SETUP!"
	wf_PayablesSetup ( )
	 
CASE "DIVISIONDEFAULTS!"
	wf_divisionsetup( )
	
CASE "USERPRIVS!"
	wf_privsetup( )
END CHOOSE
end subroutine

private subroutine wf_notes ();String	ls_MessageHeader, &
			ls_Message

ls_MessageHeader = "Edit Notes"

IF cur_emp.em_id = 0 THEN
	ls_Message = "You must save the new employee first."
	MessageBox ( ls_MessageHeader, ls_Message )
ELSEIF cur_emp.em_id > 10000 THEN
	OpenWithParm ( w_Text_Edit, cur_emp.em_id * 100 + 4 )
END IF
end subroutine

private subroutine wf_administrativenotes ();String	ls_MessageHeader, &
			ls_Message

ls_MessageHeader = "Edit Administrative Notes"

IF cur_emp.em_id = 0 THEN
	ls_Message = "You must save the new employee first."
	MessageBox ( ls_MessageHeader, ls_Message )
ELSEIF cur_emp.em_id > 10000 THEN
	OpenWithParm ( w_Text_Edit, cur_emp.em_id * 100 + 5 )
END IF
end subroutine

public subroutine wf_payablessetup ();Long	ll_EmployeeId, &
		ll_EntityId
w_tv_AmountTemplates			lw_AmountTemplates
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_Privileges			lnv_Privileges
String	ls_MessageHeader = "Payables Setup"

ll_EmployeeId = cur_emp.em_id

IF lnv_Privileges.of_Settlements_EntitySetup ( ) = TRUE THEN

	//User is authorized.

	CHOOSE CASE lnv_EmployeeManager.of_GetEntity (ll_EmployeeId, ll_EntityId, &
		TRUE /*AllowCreate*/, TRUE /*AskToCreate*/ )
	
	CASE 1
	
		//Entity Exists.  Display the Payables Setup window.
		SetPointer ( HourGlass! )
		OpenSheetWithParm ( lw_AmountTemplates, ll_EntityId, gnv_App.of_GetFrame ( ), 0, Layered! )
	
	CASE 0
	
		//Not found (and user chose not to create.)
	
	CASE ELSE //-1
	
		//Error
	
		MessageBox ( ls_MessageHeader, "Could not process request.  Request cancelled.", Exclamation! )
	
	END CHOOSE

ELSE
	//User is not authorized.  Display notification message.
	MessageBox ( ls_MessageHeader, lnv_Privileges.of_GetRestrictMessage ( ) )

END IF
end subroutine

public subroutine wf_fleethistoryreport ();n_cst_EmployeeManager	lnv_EmployeeManager

lnv_EmployeeManager.Event ue_FleetHistoryReport ( )
end subroutine

private subroutine wf_showalerts ();n_cst_beo_Employee2	lnv_Employee
n_cst_AlertManager	lnv_AlertManager

lnv_Employee = CREATE n_Cst_beo_Employee2

lnv_Employee.of_SetSourceid( cur_emp.em_id )



lnv_AlertManager = CREATE n_cst_AlertManager
lnv_AlertManager.of_Showalerts( {lnv_Employee} )

Destroy ( lnv_AlertManager )
DESTROY  ( lnv_Employee )


end subroutine

public function integer wf_populatedivisions (long al_divisionid, ref datawindowchild adwc_divisions);//function Added By Dan 4-25-06

n_cst_Ship_Type	lnv_ShipType

Long			ll_max
Long			ll_index
Long			ll_newRow

int			li_res
String		ls_division
String		ls_valueList
String		lsa_codeTable[]
Long			ll_divisionId
Long			lla_empty[]

n_cst_string	lnv_string


IF lnv_Shiptype.of_Ready(True) THEN
	IF isValid( adwc_divisions ) THEN
		//get all the divisions
		ll_max = adwc_divisions.rowCount()
		IF ll_max = 0 THEN
	
			ll_newRow = adwc_divisions.insertRow( 0 )
	
			lnv_ShipType.of_GetCodeTable ( "DIVISION", FALSE /*ActiveOnly*/, lla_Empty /*ReqIds*/, ls_ValueList )
			//lsvaluelist looks something like:    Intermodal~t2201/NonIntermodal~t2204
			
			lnv_string.of_parsetoarray( ls_valueList, "/", lsa_codeTable )
			
			IF ll_newRow > 0 THEN
				adwc_divisions.setItem( 1, "values", "")
			END IF
			
			ll_max = upperBOund( lsa_codeTable )
			
			FOR ll_index = 1 TO ll_max
				
				ll_newRow = adwc_divisions.insertRow( 0 )
			
				ls_division = left( lsa_codeTable[ll_index], POS(lsa_codeTable[ll_index], "~t") - 1 )//gds_shiptype.getItemString( ll_index, "st_name" ) 
				ll_divisionId = Long(right( lsa_codeTable[ll_index], LEN(lsa_codeTable[ll_index]) - POS(lsa_codeTable[ll_index], "~t") ))//gds_shipType.getItemNumber( ll_index, "st_id" )
				
			
				li_res = adwc_divisions.setItem( ll_newRow, "values" , ls_division )
				li_res = adwc_divisions.setItem( ll_newRow, "hidden_values", ll_divisionId )
			
				//set the division to the drivers division
				IF al_divisionId = ll_divisionId THEN
					adwc_divisions.setRow( ll_newRow )
				END IF
			NEXT
			
		ELSE
			IF al_divisionid > 0 THEN
				
				FOR ll_index = 1 TO ll_max
					ls_division = adwc_divisions.getItemString( ll_index, "values" ) 
					ll_divisionId = adwc_divisions.getItemNumber( ll_index, "hidden_values" )
					
					IF al_divisionId = ll_divisionId THEN
						adwc_divisions.setRow( ll_newRow )
					END IF
				NEXT
			ELSE
				adwc_divisions.setRow( 1 )
			END IF
		END IF
	END IF
END IF


RETURN  ll_max
end function

public function integer wf_discardnulltmpdivisions ();Long	ll_index
Long	ll_max

ll_max = dw_temporarydivision.rowCount()
FOR ll_index =1  TO ll_max
	IF isNULL( dw_temporarydivision.getItemNumber( ll_index , "di_id") ) OR isNull( dw_temporarydivision.getItemNumber( ll_index, "tmpdivision" ) ) THEN
		dw_temporarydivision.rowsDiscard( ll_index, ll_index, PRIMARY! )
	END IF
NEXT
RETURN 1
end function

public function integer wf_privsetup ();Long	ll_empId

ll_empId = dw_emp_info.getItemNumber( 1, "em_id" )

openwithparm( w_userPrivs, ll_empId )
return 1 
end function

public function integer wf_divisionsetup ();Integer	li_Return
Long		ll_empId
String	ls_fn
String	ls_ln
String	ls_name

n_cst_msg	lnv_Msg
s_Parm		lstr_Parm

ll_empId = dw_emp_info.getItemNumber( 1, "em_id" )

IF NOT isNull(ll_EmpId) AND ll_EmpId > 0 THEN

	ls_fn = dw_emp_info.getItemString( 1, "em_fn" )
	ls_ln = dw_emp_info.getItemString( 1, "em_ln" )
	ls_Name = ls_fn + " " + ls_ln
	
	
	lstr_Parm.is_Label = "EM_NAME"
	lstr_Parm.ia_value = ls_Name
	lnv_Msg.of_add_parm( lstr_Parm )
	
	lstr_Parm.is_Label = "EM_ID"
	lstr_Parm.ia_value = ll_empId
	lnv_Msg.of_add_parm( lstr_Parm )
	
	openwithparm( w_employeedivisiondefaults, lnv_Msg )
	
	li_return = 1
	
ELSE
	li_Return = -1
END IF
return li_Return
end function

event open;s_emp_info lstr_emp
lstr_emp.em_id = message.doubleparm

this.x = 1
this.y = 1

gf_mask_menu(m_sheets)
wf_create_toolmenu()

dw_driver_info.settransobject(sqlca)
dw_emp_info.settransobject(sqlca)

set_choose_emp()
uo_choose_emp.sle_name.setfocus()


if lstr_emp.em_id > 0 then
	if gf_emp_info(null_ds, null_str, null_str, lstr_emp) = 1 then
		uo_choose_emp.temp_emp = lstr_emp
		uo_choose_emp.call_funct()
		return
	else
		messagebox("Employee Info", "Could not retrieve information for the employee "+&
			"you requested.", exclamation!)
		close(this)
		return
	end if
end if

//IF gnv_App.of_Getprivsmanager( ).of_Useadvancedprivs( ) THEN
dw_emp_info.insertrow(0)
dw_emp_info.enabled = false
is_driver(false)

cur_emp.em_id = null_long
uo_choose_emp.cur_emp.em_id = null_long
cb_make_Driver.enabled = false
dw_temporarydivision.bringtotop = true
THIS.Post wf_ShowAlerts ( )



end event

on w_emp_info.create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.st_noprivs=create st_noprivs
this.st_user_check=create st_user_check
this.st_driver_privs=create st_driver_privs
this.cb_make_driver=create cb_make_driver
this.uo_choose_emp=create uo_choose_emp
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_emp_info=create dw_emp_info
this.dw_driver_info=create dw_driver_info
this.dw_temporarydivision=create dw_temporarydivision
this.Control[]={this.st_noprivs,&
this.st_user_check,&
this.st_driver_privs,&
this.cb_make_driver,&
this.uo_choose_emp,&
this.gb_2,&
this.gb_1,&
this.dw_emp_info,&
this.dw_driver_info,&
this.dw_temporarydivision}
end on

on w_emp_info.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_noprivs)
destroy(this.st_user_check)
destroy(this.st_driver_privs)
destroy(this.cb_make_driver)
destroy(this.uo_choose_emp)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_emp_info)
destroy(this.dw_driver_info)
destroy(this.dw_temporarydivision)
end on

event closequery;/*  Megan's standard return codes (standard most of the time)
	 99 = user entered information is illogical, can't update until they fix it
	100 = no changes made, no need to update
	  0 = update went through, commit, all OK
	 -1 = tried to update, database error, update failed (check failnote for explanation)       
----------------------------------------------------------------*/

if winisclosing then return 0 //forced close

if isnull(cur_emp.em_id) then return 0

boolean accepted = true
if dw_emp_info.accepttext() = -1 then accepted = false
if dw_driver_info.accepttext() = -1 then accepted = false

if accepted and dw_emp_info.modifiedcount() = 0 and dw_driver_info.modifiedcount() = 0 then &
	return 0

this.setfocus()
this.show()

if not accepted then return 1

choose case messagebox("Employee Info", "Save changes before closing?", &
	question!, yesnocancel!, 1)
		case 2
			return 0
		case 3
			return 1
end choose

string failnote

choose case save_changes(failnote)
	case -1
		if messagebox("Employee Info", "Could not save changes to database.~n~nPress OK "+&
			"to abandon changes and close window, or Cancel to return to window and preserve "+&
			"changes for now.", exclamation!, okcancel!, 2) = 2 then return 1
	case 99
		return 1
end choose
end event

event close;destroy inv_cst_toolmenu_manager
end event

type st_noprivs from statictext within w_emp_info
boolean visible = false
integer x = 960
integer y = 316
integer width = 1934
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Missing required divisional privilege rights to access this employee~'s info."
boolean focusrectangle = false
end type

type st_user_check from statictext within w_emp_info
boolean visible = false
integer x = 1678
integer y = 28
integer width = 1902
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "User Checklist:"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_driver_privs from statictext within w_emp_info
boolean visible = false
integer x = 1147
integer y = 968
integer width = 1426
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Driver Information File Maintained / No User Access"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_make_driver from commandbutton within w_emp_info
integer x = 1147
integer y = 968
integer width = 1426
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Maintain Driver File and Logs for this Employee"
end type

event clicked;if isnull(cur_emp.em_id) then return

if dw_driver_info.rowcount() = 0 then //It should
	dw_driver_info.insertrow(0)
	dw_driver_info.object.di_id[1] = cur_emp.em_id
	is_driver(true)
	dw_driver_info.setcolumn("di_type_driver")
	dw_driver_info.setfocus()
end if
end event

type uo_choose_emp from u_choose_emp within w_emp_info
integer x = 315
integer y = 28
integer width = 1339
integer taborder = 10
end type

on uo_choose_emp.destroy
call u_choose_emp::destroy
end on

type gb_2 from groupbox within w_emp_info
integer x = 293
integer y = 644
integer width = 3305
integer height = 8
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_emp_info
integer x = 293
integer y = 132
integer width = 3305
integer height = 8
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type dw_emp_info from datawindow within w_emp_info
event dwnprocessenter pbm_dwnprocessenter
integer x = 302
integer y = 152
integer width = 3314
integer height = 480
integer taborder = 30
string dataobject = "d_emp_info"
boolean border = false
end type

event dwnprocessenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

event itemchanged;if row = 0 then return
string colname, teststr1
colname = dwo.name
data = trim(data)

choose case colname
case "em_class"
	post set_user_check()
case "em_ref", "em_ln", "em_fn", "em_mn"
	if colname = "em_ref" then post set_user_check()
	dw_emp_info.setitem(row, colname, data)
	return 2
case "em_zip"
	if len(data) = 0 then
		this.setitem(row, colname, null_str)
		return 2
	elseif len(data) <> 5 and len(data) <> 9 then
		beep(1)
		return 1
	end if
case "em_ss"
	if len(data) = 0 then
		this.setitem(row, colname, null_str)
		return 2
	elseif len(data) <> 9 then
		beep(1)
		return 1
	end if
case "em_tele", "em_emerg_h", "em_emerg_w"
	if len(data) = 0 then 
		this.setitem(row, colname, null_str)
		return 2
	elseif len(data) < 10 then
		beep(1)
		return 1
	end if
case else
end choose


end event

event itemerror;string colname
colname = dwo.name
n_cst_string lnv_string

data = trim(data)

choose case colname
case "em_dob", "em_stop_date", "em_start_date"
	date tempdate
	tempdate = lnv_string.of_SpecialDate(data)
	if not isnull(tempdate) then
		this.setitem(row, colname, tempdate)
		return 3
	end if
end choose

this.selecttext(1, 999)
this.setfocus()
beep(1)
return 1
end event

event itemfocuschanged;string newcol
newcol = dwo.name

this.modify("em_tele.edit.format = ''") //removes the mask and restores edit
this.modify("em_emerg_h.edit.format = ''")
this.modify("em_emerg_w.edit.format = ''")
this.modify("em_zip.edit.format = ''")
this.modify("em_ss.edit.format = ''")
this.modify("em_cellphone.edit.format = ''")

choose case newcol
	case "em_tele", "em_emerg_h", "em_emerg_w" , "em_cellphone"
		this.modify(newcol + ".editmask.mask = '(###) ###-####'")
		//this.selecttext(1, 14)  Doesn't work in PB9 <<*>>
	case "em_zip"
		choose case this.getitemstring(1, "em_state")
			case "MX"
				return
			case "AB", "BC", "MB", "NB", "NF", "NT", "NS", "ON", "PE", "PQ", "QC", "SK", "YK"
				this.modify("em_zip.editmask.mask = '!!! !!!'")
			case else
				this.modify("em_zip.editmask.mask = '#####-####'")
		end choose
		this.selecttext(1, 10)
	case "em_ss"
		this.modify(newcol + ".editmask.mask = '###-##-####'")
		this.selecttext(1, 11)
end choose


end event

event dberror;return 1
end event

event rbuttondown;string lsa_parm_labels[]
any laa_parm_values[]
IF cur_emp.em_id > 0 THEN
	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "Add &Alert"
	
	IF f_pop_standard(lsa_parm_labels, laa_parm_values) = "ADD ALERT" THEN
		
		n_cst_beo_Employee2	lnv_Employee
		lnv_Employee = CREATE n_Cst_beo_Employee2
		
		lnv_Employee.of_SetSourceid( cur_emp.em_id )
		lnv_Employee.of_Adduseralert( )
		
		DESTROY ( lnv_Employee )
		
	END IF
END IF
end event

event constructor;n_cst_Presentation_State	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

type dw_driver_info from datawindow within w_emp_info
event dwnprocessenter pbm_dwnprocessenter
integer x = 302
integer y = 672
integer width = 3314
integer height = 1272
integer taborder = 40
string dataobject = "d_driver_info"
boolean border = false
end type

event dwnprocessenter;send(handle(this), 256, 9, long(0, 0))
return 1
end event

event itemchanged;datawindowchild ldwc_tmpdivisions
//datawindowChild ldwc_divisions
long	ll_divisionId

this.post setredraw(true)


if row = 0 then return
string colname
colname = dwo.name

choose case colname
case "di_cert_vios", "di_review_record", "di_hazmat_certification"
	if data = "F" then this.setitem(1, colname + "_date", null_date)
case "di_sched_type"
	integer origsched
	date mindate
	origsched = this.getitemnumber(1, "di_sched_type", primary!, true)
	mindate = this.getitemdate(1, "compute_min")
	if integer(data) <> origsched and not isnull(mindate) then
		string sched_descr
		if data = "7" then sched_descr = "60 Hour / 7 Day" &
			else sched_descr = "70 Hour / 8 Day"
		if messagebox("Change Schedule Type", "OK for this driver to begin using the " +&
			sched_descr + " Rule Set?~n~n(Any violations generated under the old Rule Set "+&
			"will remain unchanged, unless prior logs are added or edited.  In that case, "+&
			"violations would be recalculated for the affected period using the new Rule "+&
			"Set.)", question!, okcancel!, 1) = 2 then
				//The set of item and status is for display purposes only.  Return 2 leaves
				//the data alone, but the display shows the selected value.
				this.setitem(1, "di_sched_type", this.getitemnumber(1, "di_sched_type"))
				if this.getitemnumber(1, "di_sched_type") = &
					this.getitemnumber(1, "di_sched_type", primary!, true) then &
						this.setitemstatus(1, "di_sched_type", primary!, notmodified!)
				return 2
		end if
	end if
end choose



end event

event itemerror;if row = 0 then return

end event	

event constructor;n_cst_Presentation_State	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

type dw_temporarydivision from datawindow within w_emp_info
integer x = 1216
integer y = 1820
integer width = 1321
integer height = 96
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_drivertmpdivision"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject( SQLCA )

end event

