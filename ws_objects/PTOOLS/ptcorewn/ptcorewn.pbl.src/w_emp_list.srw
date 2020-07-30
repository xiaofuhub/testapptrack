$PBExportHeader$w_emp_list.srw
$PBExportComments$PTCORE:  (info only) this is the employee list
forward
global type w_emp_list from w_response
end type
type cbx_all from checkbox within w_emp_list
end type
type cb_cancel from commandbutton within w_emp_list
end type
type cb_select from commandbutton within w_emp_list
end type
type dw_emp_list from u_dw_emp_list within w_emp_list
end type
end forward

global type w_emp_list from w_response
integer x = 1851
integer y = 324
integer width = 1541
integer height = 1788
string title = "Employee Selection"
long backcolor = 12632256
cbx_all cbx_all
cb_cancel cb_cancel
cb_select cb_select
dw_emp_list dw_emp_list
end type
global w_emp_list w_emp_list

type variables
protected:
s_emp_info ems
boolean winisclosing
string is_base_filter
end variables

event open;/*---------------------------------------------What to send this window

A programmer should send this window a structure of type s_emp_info.

Set the em_ln = "" and em_fn = "" if the programmer wants a full list of all employees.
If the programmer wants a list of only employees with a certain last name then they should
set the em_ln and/or em_fn and this window will filter on that criteria.  If the programmer
wants only drivers or only some other type of employee then they should set that info
in the structure.  

This window automatically sets a filter on deactivated employees.  There is a checkbox
to remove this filter.  This removal of the filter may be a bad option for the user
if the programmer wants them to choose a driver that is active.  Set the em_type of the 
structure to "K" and the option to remove the filter will be invisible.

-----------------------------------------------What this window sends back

This window sends back a structure of type s_emp_info.  If the user did not choose a driver 
or pressed CANCEL then the em_id is null, otherwise it is filled with all the driver
info. 

Program Change!  the em_type does not matter for the database anymore! 
if you want a list of all employees, send the in the struct an emtype of 1
if you want a list of ONLY DRIVERS, send the in the struct an emtype of 2

---------------------------------------------------------------------------------------*/

ems = message.powerobjectparm

Date	ld_Avail
this.x = 1852	
this.y = 325

if gds_emp.rowcount() > 0 then 
	dw_emp_list.object.data.primary = gds_emp.object.data.primary
else
	messagebox("Employee List","There are currently no employees in the database.")
	cb_cancel.event trigger clicked()
	return
end if


is_base_filter = "1 = 1"


if ems.em_type = 2 then
	ld_Avail = ems.di_date
	is_base_filter += " and (not isnull(di_id))"
	this.title = "Driver Selection"
	cbx_all.text = "Show Deactivated Drivers"
ELSEIF ems.em_type = 1 then // admin employees
	is_base_filter += " and em_type = 1"
	this.title = "Employee Selection"
	cbx_all.text = "Show Deactivated Employees"
end if


if len(trim(ems.em_ln)) > 0 then is_base_filter += " and em_ln = '" + ems.em_ln + "'"
if len(trim(ems.em_fn)) > 0 then is_base_filter += " and em_fn = '" + ems.em_fn + "'"

if ems.em_status = "K" then cbx_all.visible = false

dw_emp_list.setfilter(is_base_filter + " and em_status <> 'D'")
dw_emp_list.filter()
dw_emp_list.sort()
dw_emp_list.setfocus()

IF ems.em_type = 2 AND ( NOT isNull (ld_Avail ) ) THEN
	dw_emp_list.of_markunavailable( ld_Avail ) 
END IF

end event

on w_emp_list.create
int iCurrent
call super::create
this.cbx_all=create cbx_all
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_emp_list=create dw_emp_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_all
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.dw_emp_list
end on

on w_emp_list.destroy
call super::destroy
destroy(this.cbx_all)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_emp_list)
end on

event closequery;if winisclosing = false then
	cb_cancel.event post clicked()
	return 1
end if
end event

type cb_help from w_response`cb_help within w_emp_list
integer x = 1440
integer y = 1628
end type

type cbx_all from checkbox within w_emp_list
integer x = 41
integer y = 44
integer width = 869
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Show Deactivated Employees"
end type

event clicked;string ls_filter

ls_filter = is_base_filter

if cbx_all.checked = false then ls_filter += " and em_status <> 'D'"

dw_emp_list.setfilter(ls_filter)
dw_emp_list.filter()
dw_emp_list.sort()
dw_emp_list.setfocus()

end event

type cb_cancel from commandbutton within w_emp_list
integer x = 1211
integer y = 40
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;s_emp_info empstruct
empstruct.em_id = null_long
winisclosing = true
closewithreturn(parent, empstruct)

end event

type cb_select from commandbutton within w_emp_list
integer x = 937
integer y = 40
integer width = 247
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select"
boolean default = true
end type

event clicked;integer selrow
s_emp_info empstruct

selrow = dw_emp_list.getselectedrow(0)

if selrow > 0 then
	empstruct.em_id = dw_emp_list.getitemnumber(selrow, "em_id")
	empstruct.em_fn = dw_emp_list.getitemstring(selrow, "em_fn")
	empstruct.em_mn = dw_emp_list.getitemstring(selrow, "em_mn")
	empstruct.em_ln = dw_emp_list.getitemstring(selrow, "em_ln")
	empstruct.em_ref = dw_emp_list.getitemstring(selrow, "em_ref")
	empstruct.em_status = dw_emp_list.getitemstring(selrow, "em_status")
	empstruct.em_type = dw_emp_list.getitemnumber(selrow, "em_type")
	empstruct.em_class = dw_emp_list.getitemnumber(selrow, "em_class")
end if

winisclosing = true
closewithreturn(parent, empstruct)

end event

type dw_emp_list from u_dw_emp_list within w_emp_list
event downkey pbm_dwnkey
integer x = 46
integer y = 160
integer width = 1426
integer height = 1440
integer taborder = 11
boolean bringtotop = true
end type

event downkey;integer lcv, downkey = 0, selrow, newrow
selrow = getselectedrow(0)

//Not necessary now that select is default button
//
//if keydown(keyenter!) then
//	if selrow = 0 or isnull(selrow) then return
//	cb_select.postevent(clicked!)
//	return
//end if

if keydown(keyuparrow!) or keydown(keydownarrow!) then
	if keydown(keyuparrow!) then
		if selrow = 0 or selrow = 1 then
			newrow = rowcount()
		else
			newrow = selrow - 1
		end if
	else
		if selrow = 0 or selrow = rowcount() then
			newrow = 1
		else 
			newrow = selrow + 1
		end if
	end if
	selectrow(0, false)
	selectrow(newrow, true)
	scrolltorow(newrow)
	return
end if
	
for lcv = 65 to 90 	
	if keydown(lcv) then
		downkey = lcv
		exit
	end if
next

if downkey = 0 then return 

integer tempnewrow
string ln, templ, oldl


selrow = getselectedrow(0)
if selrow = 0 or isnull(selrow) then goto bigloop
ln = getitemstring(selrow, "em_ln")

if downkey = asc(ln) then
	newrow = 0
	if selrow = rowcount() then 
		goto bigloop
	elseif left(getitemstring(selrow + 1, "em_ln"), 1) = left(ln, 1) then
		newrow = selrow + 1
	else
		if selrow = 1 then return
		newrow = 0
		for lcv = 1 to selrow
			if left(getitemstring(lcv, "em_ln"), 1) = left(ln, 1) and &
			lcv <> selrow then 
					newrow = lcv
					exit
			end if
		next
		if newrow = 0 then return
	end if
	selectrow(0, false)
	selectrow(newrow, true)
	scrolltorow(newrow)
	return
end if

bigloop:
setnull(oldl)		
tempnewrow = 1
newrow = 0

for lcv = 1 to rowcount()
	templ = left(getitemstring(lcv, "em_ln"), 1)
	if asc(templ) < downkey then tempnewrow = lcv
	if templ <> oldl or isnull(oldl) then 
		oldl = templ
	else
		continue
	end if
	if asc(oldl) = downkey then newrow = lcv
next
if newrow = 0 and tempnewrow > 0 then newrow = tempnewrow

if newrow = 0 then 
	beep(1)
	return
end if
selectrow(0, false)
selectrow(newrow, true)
scrolltorow(newrow)
		
end event

event clicked;call super::clicked;if row <= 0 then return
selectrow(0, false)
selectrow(row, True)	
end event

event dberror;call super::dberror;return 1
end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	selectrow(0, false)
	selectrow(row, true)
	cb_select.postevent(clicked!)
end if

end event

