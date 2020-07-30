$PBExportHeader$u_choose_emp.sru
$PBExportComments$PTCORE:  uo with sle_name, st_hotkey, and emp_list button
forward
global type u_choose_emp from userobject
end type
type hsb_1 from hscrollbar within u_choose_emp
end type
type st_tag1 from statictext within u_choose_emp
end type
type sle_name from singlelineedit within u_choose_emp
end type
end forward

global type u_choose_emp from userobject
integer width = 1225
integer height = 80
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
hsb_1 hsb_1
st_tag1 st_tag1
sle_name sle_name
end type
global u_choose_emp u_choose_emp

type variables
public:
window w_mainpar
string jumper = "NO"
datastore ds_hotkey
s_emp_info cur_emp, temp_emp
integer uo_num = 1
boolean allow_noname = false
end variables

forward prototypes
public subroutine set_emp (boolean swap_parm)
public subroutine call_funct ()
public function integer of_filterdivisionalprivilege (string as_priv)
end prototypes

public subroutine set_emp (boolean swap_parm);if swap_parm = true then 
	cur_emp = temp_emp
end if

if isnull(cur_emp.em_id) then 
	sle_name.text = ""
elseif w_mainpar.classname() = "w_emp_info" and cur_emp.em_id = 0 then
	sle_name.text = "NEW EMPLOYEE"
else
	sle_name.text = cur_emp.em_ln + ", " + cur_emp.em_fn
end if

end subroutine

public subroutine call_funct ();if classname(w_mainpar) = "w_log" then
	if w_log.triggerit then
		w_mainpar.function dynamic trigger emp_switch(uo_num)
		w_log.triggerit = false
		return
	end if
end if

w_mainpar.function dynamic post emp_switch(uo_num)

end subroutine

public function integer of_filterdivisionalprivilege (string as_priv);/***************************************************************************************
NAME: of_filterdivisionalprivilege		

ACCESS: Public
		
ARGUMENTS: 	(String 	as_priv)

RETURNS:			Integer
	
DESCRIPTION:  
				Discards employee rows that should not be displayed for a current user that
				does not have divisional rights
				
				Discards Primary! AND Filter! buffers
				
				****this fuction is useless unless the w_emp_list winodw is filtered as well.
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created MFS 10/04/2006
	
***************************************************************************************/

Integer	li_Return = 1
//Long		ll_Division
//Long		ll_Empcount
//Long		i

//****this fn not used right now because w_emp_list would need to be filtered also


//n_cst_privsmanager lnv_PrivsManager
//
//ll_EmpCount = ds_Hotkey.RowCount()
//FOR i = ll_EmpCount TO 1 STEP -1 
//	ll_Division = 0
//	lnv_PrivsManager = gnv_App.of_GetPrivsManager( )
//	ll_Division = ds_hotkey.GetItemNumber(i, "di_division")
//	IF NOT isNull(ll_Division) AND ll_Division > 0 THEN
//		IF lnv_PrivsManager.of_GetUserPermissionFromFn(as_Priv, ll_Division) <> 1 THEN
//			IF ds_hotkey.RowsDiscard(i, i, Primary!) <> 1 THEN
//				li_Return = -1
//				EXIT
//			END IF
//		END IF
//	END IF
//NEXT
//
////Now discard from filter buffer incase filter is changed
//ll_EmpCount = ds_Hotkey.FilteredCount()
//FOR i = ll_EmpCount TO 1 STEP -1 
//	ll_Division = 0
//	lnv_PrivsManager = gnv_App.of_GetPrivsManager( )
//	ll_Division = ds_hotkey.GetItemNumber(i, "di_division", Filter!, FALSE)
//	IF NOT isNull(ll_Division) AND ll_Division > 0 THEN
//		IF lnv_PrivsManager.of_GetUserPermissionFromFn(as_Priv, ll_Division) <> 1 THEN
//			IF ds_hotkey.RowsDiscard(i, i, Filter!) <> 1 THEN
//				li_Return = -1
//				EXIT
//			END IF
//		END IF
//	END IF
//NEXT
//

Return li_Return
end function

on u_choose_emp.create
this.hsb_1=create hsb_1
this.st_tag1=create st_tag1
this.sle_name=create sle_name
this.Control[]={this.hsb_1,&
this.st_tag1,&
this.sle_name}
end on

on u_choose_emp.destroy
destroy(this.hsb_1)
destroy(this.st_tag1)
destroy(this.sle_name)
end on

event constructor;/*  ---------------------------------  How to use

(main window is the window that will hold the user object)

1. call a function called set_choose_emp from the MAIN WINDOW
	a.	this function will must declare the user object parent as the MAIN WINDOW
	b. it also can set the face of the user object
	c.	this function will also set the filter on the hotkey for active or retired/driver or
		non-driver

---the following is a sample of what the function will look like:
					uo_choose_emp.w_mainpar = this
					
					if gds_emp.rowcount() > 1 then 
						uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
						uo_choose_emp.ds_hotkey.setfilter("em_status <> 'A'")
						uo_choose_emp.ds_hotkey.filter()
					else
						uo_choose_emp.st_hotkey.enabled = false
						uo_choose_emp.st_back.enabled = false
					end if
					uo_choose_emp.st_tag1.text = "Name"
					uo_choose_emp.cb_list.text = "Employee List"
					
					uo_choose_emp.st_tag1.y = cb_new.y - uo_choose_emp.y
					uo_choose_emp.sle_name.y = cb_new.y - uo_choose_emp.y 
					uo_choose_emp.st_hotkey.y = cb_updater.y - uo_choose_emp.y
					uo_choose_emp.st_back.y = cb_updater.y - uo_choose_emp.y
					uo_choose_emp.cb_list.y = cb_updater.y - uo_choose_emp.y 
					
					uo_choose_emp.cur_emp.em_id = null_long
					uo_choose_emp.sle_name.setfocus()
					
					return 0
2. The MAIN WINDOW must contain a function called "emp_switch".
	This function must have a retrieval arguement of s_emp_info and an integer arguement.  
	S_emp_info is a global structure. See w_emp_info for an example.  The integer arguement
	is to distinguish between a window that contains several of these user objects.  Ignore 
	this arguement if there is just one in the window.

		The purpose of this function is the user object will send it the prospective chosen
	employee.  The user object calls this functin dynamically.  The MAIN WINDOW can do 
	whatever it wants with the prospective employee.  The user object will place the name	
	of the employee in the single line edit box.  This function reset the box or leave it.
		If you want the chosen employee to be the active employee in the user object then
	you should set it in this function.  That will keep the jump keys accurate according
	to the employee in the single line edit box. The current employee ID is held in an 
	instance variable in the user object of type s_emp_info.  It is only neccessary to 
	set the ID portion of the structure.
		Sample code:
		uo_choose_emp.cur_emp.em_id = 10000021

3.	***NOTE*** the user object contains the employee list button which brings up a list
	of all employees.  If the MAIN WINDOW has the name "w_emp_info" the user object will 
	retrieve for all employees, otherwise the user object will only ask for a list of drivers.
	If you want to ask for a list of employees and drivers, you must include the name of the
	MAIN WINDOW in that if/then code in that button.  It is not the greatest code and can 
	be made more abstract later on, but for now, it works.
	
-----------------------------------------------*/


ds_hotkey = create datastore
ds_hotkey.dataobject = "d_emp_list"


end event

event destructor;destroy ds_hotkey
end event

type hsb_1 from hscrollbar within u_choose_emp
integer x = 1102
integer width = 119
integer height = 76
boolean stdheight = false
end type

event lineleft;n_cst_Numerical	lnv_Numerical
integer hotrow, lcv
string findstr

if ds_hotkey.rowcount() = 0 then return

hotrow = 0

if ds_hotkey.rowcount() = 1 then 
	hotrow = 1
	goto set_spot
end if

if not isnull(cur_emp.em_id) then
	findstr = "em_id = " + string(cur_emp.em_id)
	hotrow = ds_hotkey.find(findstr, 1, ds_hotkey.rowcount())
end if


if hotrow > 0 then
	hotrow --
	if hotrow < 1 then hotrow = ds_hotkey.rowcount()
else  //drivers not on list, not active
	for lcv = ds_hotkey.rowcount() to 1 step -1
		if ds_hotkey.getitemstring(lcv, "em_ln") < cur_emp.em_ln then
			hotrow = lcv
			exit
		elseif ds_hotkey.getitemstring(lcv, "em_ln") = cur_emp.em_ln and &
			ds_hotkey.getitemstring(lcv, "em_fn") < cur_emp.em_fn then
				hotrow = lcv
				exit
		end if
	next
	if lnv_Numerical.of_IsNullOrNotPos(hotrow) then hotrow = ds_hotkey.rowcount()
end if

set_spot:

temp_emp.em_ln = ds_hotkey.getitemstring(hotrow, "em_ln")
temp_emp.em_fn = ds_hotkey.getitemstring(hotrow, "em_fn")
temp_emp.em_id = ds_hotkey.getitemnumber(hotrow, "em_id")
temp_emp.em_status = ds_hotkey.getitemstring(hotrow, "em_status")
temp_emp.em_type = ds_hotkey.getitemnumber(hotrow, "em_type")
temp_emp.em_ref = ds_hotkey.getitemstring(hotrow, "em_ref")
temp_emp.em_class = ds_hotkey.getitemnumber(hotrow, "em_class")

jumper = "BACKWORD"
call_funct()


end event

event lineright;n_cst_Numerical	lnv_Numerical
integer hotrow, lcv
string findstr

if ds_hotkey.rowcount() = 0 then return

hotrow = 0

if ds_hotkey.rowcount() = 1 then 
	hotrow = 1
	goto set_spot
end if


if not isnull(cur_emp.em_id) then
	findstr = "em_id = " + string(cur_emp.em_id)
	hotrow = ds_hotkey.find(findstr, 1, ds_hotkey.rowcount())
end if


if hotrow > 0 then 
	hotrow ++
	if hotrow > ds_hotkey.rowcount() then hotrow = 1
else //drivers not on list, not active
	for lcv = 1 to ds_hotkey.rowcount()
		if ds_hotkey.getitemstring(lcv, "em_ln") > cur_emp.em_ln then
			hotrow = lcv
			exit
		elseif ds_hotkey.getitemstring(lcv, "em_ln") = cur_emp.em_ln and &
			ds_hotkey.getitemstring(lcv, "em_fn") >= cur_emp.em_fn then
				hotrow = lcv
				exit
		end if
	next
	if lnv_Numerical.of_IsNullOrNotPos(hotrow) then hotrow = 1
end if

set_spot:

temp_emp.em_ln = ds_hotkey.getitemstring(hotrow, "em_ln")
temp_emp.em_fn = ds_hotkey.getitemstring(hotrow, "em_fn")
temp_emp.em_id = ds_hotkey.getitemnumber(hotrow, "em_id")
temp_emp.em_status = ds_hotkey.getitemstring(hotrow, "em_status")
temp_emp.em_type = ds_hotkey.getitemnumber(hotrow, "em_type")
temp_emp.em_ref = ds_hotkey.getitemstring(hotrow, "em_ref")
temp_emp.em_class = ds_hotkey.getitemnumber(hotrow, "em_class")

jumper = "FORWARD"
call_funct()



end event

type st_tag1 from statictext within u_choose_emp
integer width = 297
integer height = 76
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Driver:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;temp_emp.em_ln = ""
temp_emp.em_fn = ""
temp_emp.em_status = null_str

if classname(w_mainpar) = "w_emp_info" or classname(w_mainpar) = "w_privileges" then
	temp_emp.em_type = 0
else
	temp_emp.em_type = 2
end if

openwithparm(w_emp_list, temp_emp)
temp_emp = message.powerobjectparm

if not isnull(temp_emp.em_id) then
	jumper = "NO"
	call_funct()
else
	return
end if


	

end event

type sle_name from singlelineedit within u_choose_emp
event lbuttondown pbm_lbuttondown
integer x = 306
integer width = 791
integer height = 76
integer taborder = 10
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

event lbuttondown;if getfocus() <> this then this.postevent(getfocus!)
end event

event modified;integer lcv 
string type_emp = "2"
if classname(w_mainpar) = "w_emp_info" or classname(w_mainpar) = "w_privileges" &
	then type_emp = "x"

sle_name.text = trim(sle_name.text)
if len(trim(sle_name.text)) = 0 then 
	if isnull(cur_emp.em_id) then return
	if allow_noname = false then 
		set_emp(false)
	else
		temp_emp.em_id = null_long
		jumper = "NO"
		call_funct()
	end if
	return
elseif classname(w_mainpar) = "w_privileges" and lower(trim(this.text)) = "ptadmin" then
	w_mainpar.function dynamic post ptadmin_switch()
	return
elseif classname(w_mainpar) = "w_log_reports" and lower(this.text) = "all drivers" then
	return
end if

if gf_emp_info(null_ds, sle_name.text, type_emp, temp_emp) = 0 then
	set_emp(false)
else
	jumper = "NO"
	call_funct()
end if


end event

event getfocus;this.selecttext(1, len(this.text))
end event

