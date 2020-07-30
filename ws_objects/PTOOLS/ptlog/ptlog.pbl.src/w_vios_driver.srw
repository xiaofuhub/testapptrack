$PBExportHeader$w_vios_driver.srw
$PBExportComments$PTLOG:
forward
global type w_vios_driver from Window
end type
type dw_vios_single from datawindow within w_vios_driver
end type
type uo_choose_emp from u_choose_emp within w_vios_driver
end type
type dw_vios from datawindow within w_vios_driver
end type
end forward

global type w_vios_driver from Window
int X=5
int Y=4
int Width=2290
int Height=1160
boolean TitleBar=true
string Title="Violations"
string MenuName="m_violations"
long BackColor=12632256
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
dw_vios_single dw_vios_single
uo_choose_emp uo_choose_emp
dw_vios dw_vios
end type
global w_vios_driver w_vios_driver

type variables
protected:
date first_log, last_log
integer cur_intsig

public:
s_emp_info cur_driver
end variables

forward prototypes
public function integer set_choose_emp ()
public function integer save_changes (ref string failnote)
public function integer emp_switch (integer uo_num)
public subroutine zz_delete_vios ()
public subroutine zz_save_changes ()
public subroutine zz_jump_reports ()
protected subroutine scroll_vios (long target_row)
public function integer save_check ()
end prototypes

public function integer set_choose_emp ();uo_choose_emp.w_mainpar = this

uo_choose_emp.x = dw_vios.x
uo_choose_emp.width = dw_vios.width

uo_choose_emp.st_tag1.x = 1
uo_choose_emp.st_tag1.text = "Driver"
uo_choose_emp.st_tag1.width = 275

uo_choose_emp.sle_name.x = uo_choose_emp.st_tag1.x + uo_choose_emp.st_tag1.width + 9
uo_choose_emp.hsb_1.x = dw_vios.width - uo_choose_emp.hsb_1.width
uo_choose_emp.sle_name.width = dw_vios.width - uo_choose_emp.hsb_1.width - 9 - uo_choose_emp.sle_name.x

if gds_emp.rowcount() > 0 then   
	uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
	uo_choose_emp.ds_hotkey.setfilter("em_status <> 'D' and not isnull(di_id)")
	uo_choose_emp.ds_hotkey.filter()
end if

if uo_choose_emp.ds_hotkey.rowcount() = 0 then uo_choose_emp.hsb_1.Visible = false
uo_choose_emp.width = uo_choose_emp.hsb_1.x + uo_choose_emp.hsb_1.width + 9

return 0
end function

public function integer save_changes (ref string failnote);/*  Megan's standard return codes (standard most of the time)
	 99 = user entered information is illogical, can't update until they fix it
	100 = no changes made, no need to update
	  0 = update went through, commit, all OK
	 -1 = tried to update, database error, update failed (check failnote for explanation)       
----------------------------------------------------------------*/
if g_privs.log[4] = 0 then
	messagebox("Save Changes", "Your current user settings do not allow you to save changes.")
	return 0
end if	

//	Make sure we have a module lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_module_LogAudit, "S" ) < 0 THEN
	return -1
END IF

if dw_vios_single.accepttext() = -1 then return 99
if dw_vios.modifiedcount() = 0 and dw_vios.deletedcount() = 0  then return 100

integer new_intsig
select di_intsig into :new_intsig from driverinfo where di_id = :cur_driver.em_id ;
if sqlca.sqlcode <> 0 then 
	failnote = "Could not update database."
	goto rollitback
end if

if new_intsig <> cur_intsig then 
	messagebox("Saving Changes", "This driver's violations have already been updated in another window " +&
	"or by another user.  Changes cannot be saved.")
	return 0
end if	

if dw_vios.update(false, false) = -1 then
	failnote = "Could not update database."
	goto rollitback
end if

//The following will overwrite changes made from w_log.  Is that what is intended? --answer yes!

update driverinfo set di_intsig = :cur_intsig + 1 where di_id = :cur_Driver.em_id ;
if sqlca.sqlcode <> 0 then 
	failnote = "Could not update database."
	goto rollitback
end if

commit ;
dw_vios.resetupdate()
cur_intsig ++
return 0 


rollitback:
rollback ;

return -1


end function

public function integer emp_switch (integer uo_num);s_emp_info temp_driver
temp_driver = uo_choose_emp.temp_emp

if isnull(temp_driver.em_id) then goto olddriver
 

//------------------------------------------------------------------save current
integer retval
string failnote
if isnull(cur_driver.em_id) or g_privs.log[4] = 0 then goto retpart

dw_vios_single.accepttext()

string mbox
if save_check() = 1 then
	mbox = "~n~n(Please Note:  " + cur_driver.em_fn + " " + cur_driver.em_ln +&
		" is also the current driver in the Log Entry screen.  If you save changes "+&
		"in this window, any changes made in the Log Entry Screen will not be able to be "+&
		"saved.)"
end if 

if dw_vios.modifiedcount() > 0 or dw_vios.deletedcount() > 0 then
	retval = messagebox("Switch Drivers", "OK to save changes before "+&
		"switching drivers?" + mbox, question!, yesnocancel!, 1) 
	if retval = 1 then
		if save_changes(failnote) = -1 then
			if messagebox("Save Changes", "Could not save changes to database.~n~n" +&
			"Press OK to abandon changes and switch drivers, or Cancel to return to " +&
			"current driver and preserve changes for now.", exclamation!, okcancel!) = 2 then &
				goto olddriver
		end if
	elseif retval = 3 then 
		goto olddriver
	end if
end if
//------------------------------------------------------------------retrieve part
retpart:
dw_vios.setredraw(false)
dw_vios_single.setredraw(false)

if dw_vios.retrieve(temp_driver.em_id) = -1 then 
	rollback ;
	messagebox("Select Driver", "Could not retrieve violations from database.", &
		exclamation!)
	goto null_driver
else
	commit ;
end if


integer lrow
cur_driver = temp_driver
lrow = dw_vios.rowcount()
dw_vios_single.reset()
if lrow > 0 then scroll_vios(lrow)
if lrow > 0 then
	cur_intsig = dw_vios.getitemnumber(1, "di_intsig")
else
	select di_intsig into :cur_intsig from driverinfo where di_id = :cur_driver.em_id ;
	if sqlca.sqlcode <> 0 then 
		rollback ;
		messagebox("Select Driver", "Could not retrieve violations from database.", &
		exclamation!)
		goto null_driver
	else
		commit ;
	end if
end if

//if lrow > 0 then 
//	dw_vios.scrolltorow(lrow)
//	dw_vios.selectrow(0, false)
//	dw_vios.selectrow(lrow, true)
//	dw_vios.rowscopy(lrow, lrow, primary!, dw_vios_single, 99, primary!)
//end if
dw_vios.setredraw(true)
if lrow > 0 then dw_vios_single.setcolumn("dv_excused")
dw_vios_single.setredraw(true)
if lrow > 0 then dw_vios_single.setfocus()
uo_choose_emp.set_emp(true)
return 0

null_driver:
uo_choose_emp.cur_emp.em_id = null_long
dw_vios.reset()
dw_vios_single.reset()

olddriver:
dw_vios.setredraw(true)
dw_vios_single.setredraw(true)
uo_choose_emp.set_emp(false)
return 0


end function

public subroutine zz_delete_vios ();if isnull(cur_driver.em_id) then return
integer delrow, vtype  

delrow = dw_vios.getselectedrow(0)
if delrow <= 0 or isnull(delrow) then return
vtype = dw_vios.getitemnumber(delrow, "dv_type")

choose case vtype
	case 1, 2, 3
		messagebox("Delete Violation", "You cannot delete hours of service violations.  "+&
		"You can only excuse them.")
	case 4
		messagebox("Delete Violation", "You cannot delete average speed violations.  "+&
			"You can only excuse them.")
	case 5
		messagebox("Delete Violation", "You cannot delete a violation generated from a " +&
		"receipt.  Delete the receipt from the Log Entry Screen instead; the violation "+&
		"will be removed with it.")
	case 6, 0
		if messagebox("Delete Violation", "OK to delete this violation?", Exclamation!, &
			YesNo!, 2) = 2 then
			return
		else
//			dw_vios_single.setredraw(false)
			dw_vios_single.reset()
			dw_vios.deleterow(delrow)
			if dw_vios.rowcount() > 0 then
//				if delrow > 1 then
//					dw_vios.scrolltorow(delrow - 1)
//				else
					scroll_vios(min(dw_vios.rowcount(), delrow))
//				end if
			end if
				
//			dw_vios_single.reset()
//			dw_vios.selectrow(0, false)
		end if
	case 7
		messagebox("Delete Violation","You cannot delete the violation caused by a lost " +&
		"log.  You must report the log as found in the Log Entry Screen in order to remove "+&
		"the violation.")
	case 8
		messagebox("Delete Violation","You cannot delete violations that are caused by the " +&
		"100 Air-Mile Radius rule.  You can only excuse them.")
	case else
		return
end choose
end subroutine

public subroutine zz_save_changes ();dw_vios_single.accepttext()

if not isnull(cur_driver.em_id) then  
	if g_privs.log[3] = 0 then
		messagebox("Save Changes", "Your current user privileges do not allow you to save changes.")
		return
	end if	
	if dw_vios.modifiedcount() > 0 or dw_vios.deletedcount() > 0 then 	
		if save_check() = 1 then
			if messagebox("Save Changes", "Please Note:  " + cur_driver.em_fn + " " + cur_driver.em_ln +&
				" is also the current driver in the Log Entry screen.  If you save changes "+&
				"in this window, any changes made in the Log Entry Screen will not be able to be "+&
				"saved.~n~nOK to proceed?", exclamation!, okcancel!) = 2 then return
		end if 
		string failnote
		if save_changes(failnote) = -1 then messagebox("Save Changes", "Could not save " +&
		"changes to database.~n~nPlease Retry.", exclamation!)
	end if
end if


end subroutine

public subroutine zz_jump_reports ();
end subroutine

protected subroutine scroll_vios (long target_row);if target_row > 0 and target_row <= dw_vios.rowcount() then
	dw_vios_single.accepttext()
	dw_vios_single.setredraw(false)
	dw_vios_single.reset()
	dw_vios.selectrow(0, false)
	dw_vios.scrolltorow(target_row)
	dw_vios.selectrow(target_row, true)
	dw_vios.rowscopy(target_row, target_row, primary!, dw_vios_single, 99, primary!)
	dw_vios_single.setredraw(true)
end if
end subroutine

public function integer save_check ();if isvalid(w_log) then
	if not isnull(w_log.cur_driver.em_id) then 
		if not isnull(cur_driver.em_id) then
			if w_log.cur_driver.em_id = cur_Driver.em_id then 
				if w_log.old_intsig = cur_intsig then return 1
			end if
		end if
	end if
end if


return 0
end function

on w_vios_driver.create
if this.MenuName = "m_violations" then this.MenuID = create m_violations
this.dw_vios_single=create dw_vios_single
this.uo_choose_emp=create uo_choose_emp
this.dw_vios=create dw_vios
this.Control[]={this.dw_vios_single,&
this.uo_choose_emp,&
this.dw_vios}
end on

on w_vios_driver.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_vios_single)
destroy(this.uo_choose_emp)
destroy(this.dw_vios)
end on

event open;if g_privs.log[3] = 0 then
	messagebox("Violations", "Your current user privileges do not allow you " +&
	"to access this screen.", exclamation!)
	close(this)
	return
end if

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_module_LogAudit, "E" ) < 0 THEN
	close (this)
	return
END IF

gf_mask_menu(m_violations)

if g_privs.log[4] = 0 then 
	m_violations.m_current.m_save.visible = false
	m_violations.m_current.m_deleteviolation.visible = false
	m_violations.m_current.m_div_c01.visible = false
	m_violations.m_current.m_div_c02.visible = false

	m_violations.m_current.m_save.toolbaritemvisible = false
	m_violations.m_current.m_deleteviolation.toolbaritemvisible = false
	dw_vios_single.enabled = false
end if

//if g_privs.log[4] = 0 then
//	m_violations.m_current.m_div_c01.toolbaritemvisible = false
//	m_violations.m_current.m_div_c02.toolbaritemvisible = false
//	essagebox("", "Now ?" )
//end if

dw_vios.settransobject(sqlca)

cur_driver.em_id = null_long
uo_choose_emp.cur_emp.em_id = null_long
set_choose_emp()

//this.x = message.doubleparm
this.x = 1
this.y = 1
end event

event closequery;if g_privs.log[4] = 0 then goto end_part

dw_vios_single.accepttext()

string mbox
if save_check() = 1 then 
	mbox = "~n~n(Please Note:  " + cur_driver.em_fn + " " + cur_driver.em_ln +&
		" is also the current driver in the Log Entry screen.  If you save changes "+&
		"in this window, any changes made in the Log Entry Screen will not be able to be "+&
		"saved.)"
end if 


if not isnull(cur_driver.em_id) then 
	if dw_vios.modifiedcount() > 0 or dw_vios.deletedcount() > 0 then
		this.setfocus()
		this.show()
		choose case messagebox("Violations", "Save changes before closing?" + mbox, &
			question!, yesnocancel!, 1)
		case 1
			string failnote
			if save_changes(failnote) = -1 then 
				if messagebox("Save Changes", "Could not save changes to database." +&
				"~n~nPress OK to abandon changes and close window, or press CANCEL to "+&
				"return to window and preserve changes for now.", &
				exclamation!, okcancel!, 2) = 2 then return 1
			end if
		case 3
			return 1
		end choose
	end if
end if

end_part:
uo_choose_emp.sle_name.text = ""
end event

type dw_vios_single from datawindow within w_vios_driver
event dwnkey pbm_dwnkey
int X=1303
int Y=116
int Width=928
int Height=844
int TabOrder=20
string DataObject="d_vios_single"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

event dwnkey;integer vrow
vrow = dw_vios.getrow()
string colname
colname = this.getcolumnname()

if keydown(keyuparrow!) and not colname = "dv_reason" then
	if vrow > 1 then post scroll_vios(vrow - 1)
elseif keydown(keydownarrow!) and not colname = "dv_reason" then
	if vrow < dw_vios.rowcount() then post scroll_vios(vrow + 1)
elseif keydown(keypageup!) then
	if vrow > 1 then
		dw_vios.scrollpriorpage()
		post scroll_vios(dw_vios.getrow())
	end if
elseif keydown(keypagedown!) then
	if vrow < dw_vios.rowcount() then
		dw_vios.scrollnextpage()
		post scroll_vios(dw_vios.getrow())
	end if
elseif keydown(keycontrol!) and keydown(keyhome!) then
	if vrow > 1 then post scroll_vios(1)
	return 1
elseif keydown(keycontrol!) and keydown(keyend!) then
	if vrow < dw_vios.rowcount() then post scroll_vios(dw_vios.rowcount())
	return 1
end if

end event

event itemchanged;string colname, ls_UserId
colname = this.getcolumnname()

if colname = "dv_excused" and data = "T" then 
	ls_UserId = gnv_App.of_GetUserId ( )
	this.setitem(row, "dv_who_ex", ls_UserId)
	dw_Vios.setitem(dw_vios.getselectedrow(0), "dv_who_ex", ls_UserId)
	dw_Vios.setitem(dw_vios.getselectedrow(0), "dv_excused", data)
elseif colname = "dv_excused" and data = "F" then
	SetNull ( ls_UserId )
	this.setitem(row, "dv_who_ex", ls_UserId)
	dw_Vios.setitem(dw_vios.getselectedrow(0), "dv_who_ex", ls_UserId)
	dw_Vios.setitem(dw_vios.getselectedrow(0), "dv_excused", data)
elseif colname = "dv_reason" then
	dw_Vios.setitem(dw_vios.getselectedrow(0), "dv_reason", data)
end if

end event

event dberror;return 1
end event

type uo_choose_emp from u_choose_emp within w_vios_driver
event destroy ( )
int X=23
int Y=20
int Width=1093
int TabOrder=10
end type

on uo_choose_emp.destroy
call u_choose_emp::destroy
end on

type dw_vios from datawindow within w_vios_driver
int X=23
int Y=116
int Width=1285
int Height=844
boolean BringToTop=true
string DataObject="d_vios_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;if row > 0 then post scroll_vios(row)

//if row <= 0 then return
//if row = this.getselectedrow(0) then return
//
//dw_vios_single.accepttext()
//
//dw_vios_single.setredraw(false)
//dw_vios_single.reset()
//this.selectrow(0, false)
//this.selectrow(row, true)
//this.rowscopy(row, row, primary!, dw_vios_single, 99, primary!)
//dw_vios_single.setredraw(true)
end event

event dberror;return 1
end event

