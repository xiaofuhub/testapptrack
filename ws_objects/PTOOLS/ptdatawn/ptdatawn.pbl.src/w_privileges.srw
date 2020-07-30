$PBExportHeader$w_privileges.srw
$PBExportComments$here or PTCORE ?
forward
global type w_privileges from window
end type
type st_4 from statictext within w_privileges
end type
type gb_6 from groupbox within w_privileges
end type
type gb_5 from groupbox within w_privileges
end type
type gb_1 from groupbox within w_privileges
end type
type cbx_settle_adj from checkbox within w_privileges
end type
type st_cover_settle9 from statictext within w_privileges
end type
type st_cover_settle1 from statictext within w_privileges
end type
type st_cover_settle2 from statictext within w_privileges
end type
type st_cover_settle3 from statictext within w_privileges
end type
type st_cover_settle5 from statictext within w_privileges
end type
type st_cover_settle6 from statictext within w_privileges
end type
type st_cover_settle7 from statictext within w_privileges
end type
type st_cover_settle8 from statictext within w_privileges
end type
type st_cover_settle4 from statictext within w_privileges
end type
type st_cover_settle0 from statictext within w_privileges
end type
type cbx_settle_settle from checkbox within w_privileges
end type
type cbx_settle_status from checkbox within w_privileges
end type
type cbx_settle_edit2 from checkbox within w_privileges
end type
type cbx_settle_trip from checkbox within w_privileges
end type
type cbx_settle_unsettle from checkbox within w_privileges
end type
type cbx_settle_view from checkbox within w_privileges
end type
type cbx_settle_reports from checkbox within w_privileges
end type
type cbx_settle_edit1 from checkbox within w_privileges
end type
type st_settle1 from statictext within w_privileges
end type
type st_settle0 from statictext within w_privileges
end type
type cbx_settle_privileges from checkbox within w_privileges
end type
type st_3 from statictext within w_privileges
end type
type st_user_check from statictext within w_privileges
end type
type uo_choose_emp from u_choose_emp within w_privileges
end type
type sle_name from singlelineedit within w_privileges
end type
type st_cover_log0 from statictext within w_privileges
end type
type st_cover_emp0 from statictext within w_privileges
end type
type st_cover_log4 from statictext within w_privileges
end type
type st_cover_log8 from statictext within w_privileges
end type
type st_cover_log7 from statictext within w_privileges
end type
type st_cover_log6 from statictext within w_privileges
end type
type st_cover_log5 from statictext within w_privileges
end type
type st_cover_log3 from statictext within w_privileges
end type
type st_cover_log2 from statictext within w_privileges
end type
type st_cover_log1 from statictext within w_privileges
end type
type st_cover_emp7 from statictext within w_privileges
end type
type st_cover_emp6 from statictext within w_privileges
end type
type st_cover_emp5 from statictext within w_privileges
end type
type st_cover_emp4 from statictext within w_privileges
end type
type st_cover_emp3 from statictext within w_privileges
end type
type st_cover_emp2 from statictext within w_privileges
end type
type st_log8 from statictext within w_privileges
end type
type st_log7 from statictext within w_privileges
end type
type st_log6 from statictext within w_privileges
end type
type st_log5 from statictext within w_privileges
end type
type st_log4 from statictext within w_privileges
end type
type st_log3 from statictext within w_privileges
end type
type st_log2 from statictext within w_privileges
end type
type st_log1 from statictext within w_privileges
end type
type st_log0 from statictext within w_privileges
end type
type st_emp0 from statictext within w_privileges
end type
type st_emp7 from statictext within w_privileges
end type
type st_emp6 from statictext within w_privileges
end type
type st_emp5 from statictext within w_privileges
end type
type st_emp4 from statictext within w_privileges
end type
type st_emp3 from statictext within w_privileges
end type
type st_emp2 from statictext within w_privileges
end type
type st_emp1 from statictext within w_privileges
end type
type cbx_log_reports1 from checkbox within w_privileges
end type
type cbx_log_privileges from checkbox within w_privileges
end type
type cbx_emp_privileges from checkbox within w_privileges
end type
type st_2 from statictext within w_privileges
end type
type st_1 from statictext within w_privileges
end type
type cbx_emp_grant from checkbox within w_privileges
end type
type cbx_emp_add from checkbox within w_privileges
end type
type cbx_emp_viewadmin from checkbox within w_privileges
end type
type cbx_emp_viewdriver from checkbox within w_privileges
end type
type cbx_log_reports2 from checkbox within w_privileges
end type
type cbx_emp_password from checkbox within w_privileges
end type
type cbx_emp_edit from checkbox within w_privileges
end type
type cbx_log_view from checkbox within w_privileges
end type
type cbx_log_mph from checkbox within w_privileges
end type
type cbx_log_purge from checkbox within w_privileges
end type
type cbx_log_lock from checkbox within w_privileges
end type
type cbx_log_edit from checkbox within w_privileges
end type
type cbx_emp_viewphone from checkbox within w_privileges
end type
type ddlb_names from dropdownlistbox within w_privileges
end type
type st_modified from statictext within w_privileges
end type
type st_cover_emp1 from statictext within w_privileges
end type
type cbx_log_excuse from checkbox within w_privileges
end type
type gb_2 from groupbox within w_privileges
end type
type st_settle2 from statictext within w_privileges
end type
type st_settle3 from statictext within w_privileges
end type
type st_settle4 from statictext within w_privileges
end type
type st_settle5 from statictext within w_privileges
end type
type st_settle6 from statictext within w_privileges
end type
type st_settle7 from statictext within w_privileges
end type
type st_settle8 from statictext within w_privileges
end type
type st_settle9 from statictext within w_privileges
end type
type st_mask from statictext within w_privileges
end type
type cbx_customerhold from checkbox within w_privileges
end type
type gb_3 from groupbox within w_privileges
end type
type gb_7 from groupbox within w_privileges
end type
type gb_4 from groupbox within w_privileges
end type
type gb_8 from groupbox within w_privileges
end type
type defined_classes from structure within w_privileges
end type
type comp_struct from structure within w_privileges
end type
end forward

type defined_classes from structure
	long		id
	string		name
	integer		indx
	integer		val[]
	long		item[]
end type

type comp_struct from structure
	integer		indx
	long		ninethou_id[]
	checkbox		noprivs_cbx
	statictext		noprivs_cover
	statictext		noprivs_pm
	boolean		noprivs_origval
	boolean		noprivs_classval
	checkbox		cbx[]
	statictext		cover[]
	statictext		plusminus[]
	boolean		origval[]
	boolean		classval[]
end type

global type w_privileges from window
boolean visible = false
integer width = 3122
integer height = 1284
boolean titlebar = true
string title = "User Privileges"
string menuname = "m_privs"
boolean controlmenu = true
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
st_4 st_4
gb_6 gb_6
gb_5 gb_5
gb_1 gb_1
cbx_settle_adj cbx_settle_adj
st_cover_settle9 st_cover_settle9
st_cover_settle1 st_cover_settle1
st_cover_settle2 st_cover_settle2
st_cover_settle3 st_cover_settle3
st_cover_settle5 st_cover_settle5
st_cover_settle6 st_cover_settle6
st_cover_settle7 st_cover_settle7
st_cover_settle8 st_cover_settle8
st_cover_settle4 st_cover_settle4
st_cover_settle0 st_cover_settle0
cbx_settle_settle cbx_settle_settle
cbx_settle_status cbx_settle_status
cbx_settle_edit2 cbx_settle_edit2
cbx_settle_trip cbx_settle_trip
cbx_settle_unsettle cbx_settle_unsettle
cbx_settle_view cbx_settle_view
cbx_settle_reports cbx_settle_reports
cbx_settle_edit1 cbx_settle_edit1
st_settle1 st_settle1
st_settle0 st_settle0
cbx_settle_privileges cbx_settle_privileges
st_3 st_3
st_user_check st_user_check
uo_choose_emp uo_choose_emp
sle_name sle_name
st_cover_log0 st_cover_log0
st_cover_emp0 st_cover_emp0
st_cover_log4 st_cover_log4
st_cover_log8 st_cover_log8
st_cover_log7 st_cover_log7
st_cover_log6 st_cover_log6
st_cover_log5 st_cover_log5
st_cover_log3 st_cover_log3
st_cover_log2 st_cover_log2
st_cover_log1 st_cover_log1
st_cover_emp7 st_cover_emp7
st_cover_emp6 st_cover_emp6
st_cover_emp5 st_cover_emp5
st_cover_emp4 st_cover_emp4
st_cover_emp3 st_cover_emp3
st_cover_emp2 st_cover_emp2
st_log8 st_log8
st_log7 st_log7
st_log6 st_log6
st_log5 st_log5
st_log4 st_log4
st_log3 st_log3
st_log2 st_log2
st_log1 st_log1
st_log0 st_log0
st_emp0 st_emp0
st_emp7 st_emp7
st_emp6 st_emp6
st_emp5 st_emp5
st_emp4 st_emp4
st_emp3 st_emp3
st_emp2 st_emp2
st_emp1 st_emp1
cbx_log_reports1 cbx_log_reports1
cbx_log_privileges cbx_log_privileges
cbx_emp_privileges cbx_emp_privileges
st_2 st_2
st_1 st_1
cbx_emp_grant cbx_emp_grant
cbx_emp_add cbx_emp_add
cbx_emp_viewadmin cbx_emp_viewadmin
cbx_emp_viewdriver cbx_emp_viewdriver
cbx_log_reports2 cbx_log_reports2
cbx_emp_password cbx_emp_password
cbx_emp_edit cbx_emp_edit
cbx_log_view cbx_log_view
cbx_log_mph cbx_log_mph
cbx_log_purge cbx_log_purge
cbx_log_lock cbx_log_lock
cbx_log_edit cbx_log_edit
cbx_emp_viewphone cbx_emp_viewphone
ddlb_names ddlb_names
st_modified st_modified
st_cover_emp1 st_cover_emp1
cbx_log_excuse cbx_log_excuse
gb_2 gb_2
st_settle2 st_settle2
st_settle3 st_settle3
st_settle4 st_settle4
st_settle5 st_settle5
st_settle6 st_settle6
st_settle7 st_settle7
st_settle8 st_settle8
st_settle9 st_settle9
st_mask st_mask
cbx_customerhold cbx_customerhold
gb_3 gb_3
gb_7 gb_7
gb_4 gb_4
gb_8 gb_8
end type
global w_privileges w_privileges

type variables
Private:
integer comp_indx, tot_defined
comp_struct comp[]
defined_classes class[]
s_emp_info cur_emp
boolean originals_exist, one_warn = false
long modcolor, user_id
string orig_checker = "ü", no_priv_text, all_priv_text
string plustxt, minustxt, orig_pwd, cur_pwd, orig_ref, &
	cur_ref
datastore ds_emp_classes, ds_ind_classes
boolean closewith = false

long	il_originalcustomerholdvalue
end variables

forward prototypes
public function integer reset_face ()
public function integer display_class (string classname)
public function integer setup_originals ()
public function integer setup_arrays ()
public function integer save_classes (ref string failnote)
public function integer save_employee (ref string failnote)
public function integer cbx_clicked (checkbox curcbx)
public function integer mod_class (checkbox curcbx)
public function integer set_choose_emp ()
public function integer emp_switch (integer uo_num)
public subroutine zz_refresh ()
public subroutine zz_password ()
public subroutine ptadmin_switch ()
public subroutine zz_save ()
protected subroutine set_user_check ()
public function integer zz_extended ()
end prototypes

public function integer reset_face ();boolean tester, modvis
integer lcv, lcv2
if isnull(cur_emp.em_id) then 
	for lcv = 1 to comp_indx
		comp[lcv].noprivs_pm.text = ""
		comp[lcv].noprivs_cover.textcolor = 0
		for lcv2 = 1 to comp[lcv].indx 
			comp[lcv].plusminus[lcv2].text = ""
			comp[lcv].cover[lcv2].textcolor = 0
		next
	next
	st_modified.visible = modvis
	goto enabled_part
end if
			

modvis = false
for lcv = 1 to comp_indx
//------------------------------------------------------top no privilege part
	if originals_exist then
		if comp[lcv].noprivs_cbx.checked <> comp[lcv].noprivs_origval then
			if comp[lcv].noprivs_cbx.checked = true then
				comp[lcv].noprivs_pm.text = plustxt
			else	
				comp[lcv].noprivs_pm.text = minustxt
			end if
		else
			comp[lcv].noprivs_pm.text = ""
		end if
	end if
	if comp[lcv].noprivs_cbx.checked <> comp[lcv].noprivs_classval then
		comp[lcv].noprivs_cover.textcolor = modcolor
		modvis = true
	else
		comp[lcv].noprivs_cover.textcolor = 0
	end if
//--------------------------------------------------------plus minus section
	for lcv2 = 1 to comp[lcv].indx
		if originals_exist then 
			if string(comp[lcv].cbx[lcv2].checked) <> string(comp[lcv].origval[lcv2]) then
				if comp[lcv].cbx[lcv2].checked = true then
					comp[lcv].plusminus[lcv2].text = plustxt
				else	
					comp[lcv].plusminus[lcv2].text = minustxt
				end if
			else
				comp[lcv].plusminus[lcv2].text = ""
			end if
		end if
		//---------------------------------------------------modified from class
		if comp[lcv].cbx[lcv2].checked <> comp[lcv].classval[lcv2] then
			comp[lcv].cover[lcv2].textcolor = modcolor
			modvis = true
		else
			comp[lcv].cover[lcv2].textcolor = 0
		end if
	next
next
st_modified.visible = modvis

//-------------------------------------enabled part
enabled_part:

if ddlb_names.text = no_priv_text then
	for lcv = 1 to comp_indx
		for lcv2 = 1 to comp[lcv].indx
			comp[lcv].cbx[lcv2].enabled = false
		next
	next
else
	for lcv = 1 to comp_indx
		choose case lcv
		case 1 //general
			tester = false
			for lcv2 = 1 to comp[lcv].indx
				if lcv2 <= 3 then
					if comp[lcv].cbx[lcv2].checked = true then tester = true
					comp[lcv].cbx[lcv2].enabled = true
				elseif lcv2 = 4 or lcv2 = 5 then 
					comp[lcv].cbx[lcv2].enabled = tester
					tester = comp[lcv].cbx[lcv2].checked
				else
					comp[lcv].cbx[lcv2].enabled = tester
				end if
			next
		case 2 //log	
			tester = false
			for lcv2 = 1 to comp[lcv].indx
				if lcv2 <= 2 then
					comp[lcv].cbx[lcv2].enabled = true
					if lcv2 = 1 then tester = comp[lcv].cbx[lcv2].checked
				elseif lcv2 = 3 then 
					comp[lcv].cbx[lcv2].enabled = tester
					tester = comp[lcv].cbx[lcv2].checked
				else
					comp[lcv].cbx[lcv2].enabled = tester
				end if
			next
		case 3 //settlements	
			for lcv2 = 1 to comp[lcv].indx
				choose case lcv2 
				case 1
					comp[lcv].cbx[lcv2].enabled = true
					tester = comp[lcv].cbx[lcv2].checked
				case 2
					comp[lcv].cbx[lcv2].enabled = tester
					tester = comp[lcv].cbx[lcv2].checked
				case 3
					comp[lcv].cbx[lcv2].enabled = tester
				case 4
					comp[lcv].cbx[lcv2].enabled = tester
					tester = comp[lcv].cbx[lcv2].checked
				case 5
					comp[lcv].cbx[lcv2].enabled = tester
					tester = comp[lcv].cbx[lcv2].checked
				case 6, 9
					comp[lcv].cbx[lcv2].enabled = comp[lcv].cbx[2].checked
				case 7, 8
					comp[lcv].cbx[lcv2].enabled = true
				end choose
			next
		end choose
	next
end if

if il_originalcustomerholdvalue = 1 then
	cbx_customerhold.checked = true
else
	cbx_customerhold.checked = false
end if

if cur_emp.em_id = 10000 or cur_emp.em_id = user_id then 
	ddlb_names.enabled = false
else
	ddlb_names.enabled = true
end if

st_Mask.BringToTop = TRUE
return 0




end function

public function integer display_class (string classname);integer lcv, lcv2, lcv3, curitem
if isnull(classname) or len(trim(classname)) = 0 then classname = no_priv_text

for lcv = 1 to comp_indx
	comp[lcv].noprivs_pm.text = ""
	comp[lcv].noprivs_cover.textcolor = 0
next

if ddlb_names.text <> classname then ddlb_names.selectitem(classname, 0)
if classname = no_priv_text then 
	for lcv = 1 to comp_indx
		comp[lcv].noprivs_classval = true
		comp[lcv].noprivs_cbx.checked = true
		for lcv2 = 1 to comp[lcv].indx
			comp[lcv].cbx[lcv2].checked = false
			comp[lcv].cbx[lcv2].Textcolor = 0
			comp[lcv].classval[lcv2] = false
			comp[lcv].cbx[lcv2].enabled = false
		next
	next
	return 0
else
	for lcv = 1 to comp_indx
		comp[lcv].noprivs_classval = false
		comp[lcv].noprivs_cbx.checked = false
	next
end if

for lcv = 1 to tot_defined
	if class[lcv].name = classname then
		curitem = lcv
		exit
	end if
next

boolean onval
for lcv = 1 to class[curitem].indx
	if class[curitem].id = 1005 then
		il_originalcustomerholdvalue = 1
		cbx_customerhold.checked = true
	else
		il_originalcustomerholdvalue = 0
		cbx_customerhold.checked = false
	end if
	for lcv2 = 1 to comp_indx
		for lcv3 = 1 to comp[lcv2].indx
			if comp[lcv2].ninethou_id[lcv3] = class[curitem].item[lcv] then
				if class[curitem].val[lcv] = 1 then onval = true else onval = false
				comp[lcv2].cbx[lcv3].checked = onval
				comp[lcv2].classval[lcv3] = onval
				goto nextone
			end if
		next
	next
	nextone:
next

return 0


end function

public function integer setup_originals ();// this is psuedo function, it assumes that the current values are show and then
// you must setup deviations on your own

integer lcv, lcv2, lcv3, curitem
for lcv = 1 to tot_defined
	if class[lcv].id = cur_emp.em_class then
		curitem = lcv
		exit
	end if
next

for lcv = 1 to comp_indx
	comp[lcv].noprivs_origval = comp[lcv].noprivs_cbx.checked
	for lcv2 = 1 to comp[lcv].indx
		comp[lcv].origval[lcv2] = comp[lcv].cbx[lcv2].checked
	next
next


if il_originalcustomerholdvalue = 1 then
	cbx_customerhold.checked = true
else
	cbx_customerhold.checked = false
end if

return 0

end function

public function integer setup_arrays ();modcolor = rgb(0, 0, 200)
st_modified.textcolor = modcolor
plustxt = "+"
minustxt= "–"
comp_indx = 3
		/* 1 = general
			2 = logs    
			3 = settlements */

comp[1].indx = 7
comp[1].noprivs_cbx = cbx_emp_privileges
comp[1].noprivs_cover = st_cover_emp0
comp[1].noprivs_pm = st_emp0

comp[2].indx = 8
comp[2].noprivs_cbx = cbx_log_privileges
comp[2].noprivs_cover = st_cover_log0
comp[2].noprivs_pm = st_log0

comp[3].indx = 9
comp[3].noprivs_cbx = cbx_settle_privileges
comp[3].noprivs_cover = st_cover_settle0
comp[3].noprivs_pm = st_settle0
//-----------------------------------------------------------
comp[1].cbx[1] = cbx_emp_viewphone
comp[1].cbx[2] = cbx_emp_viewdriver
comp[1].cbx[3] = cbx_emp_viewadmin
comp[1].cbx[4] = cbx_emp_edit
comp[1].cbx[5] = cbx_emp_add
comp[1].cbx[6] = cbx_emp_grant
comp[1].cbx[7] = cbx_emp_password

comp[2].cbx[1] = cbx_log_view
comp[2].cbx[2] = cbx_log_reports1
comp[2].cbx[3] = cbx_log_edit 
comp[2].cbx[4] = cbx_log_excuse
comp[2].cbx[5] = cbx_log_mph
comp[2].cbx[6] = cbx_log_lock
comp[2].cbx[7] = cbx_log_purge
comp[2].cbx[8] = cbx_log_reports2

comp[3].cbx[1] = cbx_settle_view
comp[3].cbx[2] = cbx_settle_edit1
comp[3].cbx[3] = cbx_settle_status
comp[3].cbx[4] = cbx_settle_settle
comp[3].cbx[5] = cbx_settle_unsettle
comp[3].cbx[6] = cbx_settle_edit2
comp[3].cbx[7] = cbx_settle_trip
comp[3].cbx[8] = cbx_settle_adj
comp[3].cbx[9] = cbx_settle_reports

comp[1].cover[1] = st_cover_emp1
comp[1].cover[2] = st_cover_emp2
comp[1].cover[3] = st_cover_emp3
comp[1].cover[4] = st_cover_emp4
comp[1].cover[5] = st_cover_emp5
comp[1].cover[6] = st_cover_emp6
comp[1].cover[7] = st_cover_emp7

comp[2].cover[1] = st_cover_log1
comp[2].cover[2] = st_cover_log2
comp[2].cover[3] = st_cover_log3
comp[2].cover[4] = st_cover_log4
comp[2].cover[5] = st_cover_log5
comp[2].cover[6] = st_cover_log6
comp[2].cover[7] = st_cover_log7
comp[2].cover[8] = st_cover_log8

comp[3].cover[1] = st_cover_settle1
comp[3].cover[2] = st_cover_settle2
comp[3].cover[3] = st_cover_settle3
comp[3].cover[4] = st_cover_settle4
comp[3].cover[5] = st_cover_settle5
comp[3].cover[6] = st_cover_settle6
comp[3].cover[7] = st_cover_settle7
comp[3].cover[8] = st_cover_settle8
comp[3].cover[9] = st_cover_settle9

comp[1].plusminus[1] = st_emp1
comp[1].plusminus[2] = st_emp2
comp[1].plusminus[3] = st_emp3
comp[1].plusminus[4] = st_emp4
comp[1].plusminus[5] = st_emp5
comp[1].plusminus[6] = st_emp6
comp[1].plusminus[7] = st_emp7

comp[2].plusminus[1] = st_log1
comp[2].plusminus[2] = st_log2
comp[2].plusminus[3] = st_log3
comp[2].plusminus[4] = st_log4
comp[2].plusminus[5] = st_log5
comp[2].plusminus[6] = st_log6
comp[2].plusminus[7] = st_log7
comp[2].plusminus[8] = st_log8

comp[3].plusminus[1] = st_settle1
comp[3].plusminus[2] = st_settle2
comp[3].plusminus[3] = st_settle3
comp[3].plusminus[4] = st_settle4
comp[3].plusminus[5] = st_settle5
comp[3].plusminus[6] = st_settle6
comp[3].plusminus[7] = st_settle7
comp[3].plusminus[8] = st_settle8
comp[3].plusminus[9] = st_settle9

integer lcv, lcv2
for lcv = 1 to comp_indx
	comp[lcv].noprivs_cover.text = trim(comp[lcv].noprivs_cbx.text)
	comp[lcv].noprivs_cbx.text = trim(comp[lcv].noprivs_cbx.text) + " "
	comp[lcv].noprivs_cover.x = comp[lcv].noprivs_cbx.x + 83
	comp[lcv].noprivs_cover.y = comp[lcv].noprivs_cbx.y + 12
	if isnumber(comp[lcv].noprivs_cbx.tag) then 
		 comp[lcv].noprivs_cover.width = integer(comp[lcv].noprivs_cbx.tag)
	else
		comp[lcv].noprivs_cover.width = comp[lcv].noprivs_cbx.width
		// should never happen essagebox("PW", "no tag value for width--see set up arrays")
	end if
	comp[lcv].noprivs_cover.height = comp[lcv].noprivs_cbx.height - 24
	comp[lcv].noprivs_cover.visible = true
	comp[lcv].noprivs_cover.bringtotop = true

	comp[lcv].noprivs_pm.x = comp[lcv].noprivs_cbx.x - 87
	comp[lcv].noprivs_pm.y = comp[lcv].noprivs_cbx.y + 8
	comp[lcv].noprivs_pm.width = 65
	comp[lcv].noprivs_pm.height = comp[lcv].noprivs_cbx.height - 16

	for lcv2 = 1 to comp[lcv].indx
		//--------------------------------------------------------covers
		comp[lcv].cover[lcv2].text = trim(comp[lcv].cbx[lcv2].text)
		comp[lcv].cbx[lcv2].text = trim(comp[lcv].cbx[lcv2].text) + " " 
		comp[lcv].cover[lcv2].x = comp[lcv].cbx[lcv2].x + 83
		comp[lcv].cover[lcv2].y = comp[lcv].cbx[lcv2].y + 12
		if isnumber(comp[lcv].cbx[lcv2].tag) then 
			 comp[lcv].cover[lcv2].width = integer(comp[lcv].cbx[lcv2].tag)
		else
			// should never happen essagebox("PW", "Set up arrays, no integer in tag.")
			 comp[lcv].cover[lcv2].width = comp[lcv].cbx[lcv2].width
		end if
		comp[lcv].cover[lcv2].height = comp[lcv].cbx[lcv2].height - 24
		comp[lcv].cover[lcv2].visible = true
		comp[lcv].cover[lcv2].bringtotop = true
		//--------------------------------------------------------plus & Minus
		comp[lcv].plusminus[lcv2].width = 65
		comp[lcv].plusminus[lcv2].height = comp[lcv].cbx[lcv2].height - 16
		comp[lcv].plusminus[lcv2].x = comp[lcv].cbx[lcv2].x - 87
		comp[lcv].plusminus[lcv2].y = comp[lcv].cbx[lcv2].y + 8
	next
next

st_Mask.BringToTop = TRUE

//----------------------------ninethou_id designates the items ss_id in settings table

comp[1].ninethou_id[1] = 9001
comp[1].ninethou_id[2] = 9002
comp[1].ninethou_id[3] = 9003
comp[1].ninethou_id[4] = 9004
comp[1].ninethou_id[5] = 9005
comp[1].ninethou_id[6] = 9006
comp[1].ninethou_id[7] = 9007

comp[2].ninethou_id[1] = 19001
comp[2].ninethou_id[2] = 19002 
comp[2].ninethou_id[3] = 19003
comp[2].ninethou_id[4] = 19004
comp[2].ninethou_id[5] = 19005
comp[2].ninethou_id[6] = 19006
comp[2].ninethou_id[7] = 19007
comp[2].ninethou_id[8] = 19008

comp[3].ninethou_id[1] = 29001
comp[3].ninethou_id[2] = 29002 
comp[3].ninethou_id[3] = 29003
comp[3].ninethou_id[4] = 29004
comp[3].ninethou_id[5] = 29005
comp[3].ninethou_id[6] = 29006
comp[3].ninethou_id[7] = 29007
comp[3].ninethou_id[8] = 29008
comp[3].ninethou_id[9] = 29009

return 0
	if isnumber(comp[lcv].noprivs_cbx.tag) then &
		 comp[lcv].noprivs_cover.width = integer(comp[lcv].noprivs_cbx.tag)
	for lcv2 = 1 to comp[lcv].indx
		if isnumber(comp[lcv].cbx[lcv2].tag) then &
			 comp[lcv].cover[lcv2].width = integer(comp[lcv].cbx[lcv2].tag)
	next

end function

public function integer save_classes (ref string failnote);sle_name.text = trim(sle_name.text)

integer lcv, lcv2, maxid, chval
for lcv = 1 to tot_defined
	if class[lcv].name = sle_name.text then
		messagebox("Invalid Name", "The name chosen is already in use.")
		sle_name.setfocus()
		return 99
	end if
next


select max (ss_id) into :maxid from system_settings where ss_id > 1000 and ss_id < 1500 ;
if sqlca.sqlcode <> 0 then 
	failnote = "Maxid:  " + sqlca.sqlerrtext
	goto rollitback 
else
	commit ;
	maxid ++
end if

insert into system_settings (ss_id, ss_uid, ss_string) values (:maxid, 0, :sle_name.text) ;
if sqlca.sqlcode <> 0 then 
	failnote = "Insert:  " + sqlca.sqlerrtext
	goto rollitback 
end if

maxid = maxid * -1
string savenote
for lcv = 1 to comp_indx
	for lcv2 = 1 to comp[lcv].indx
		if comp[lcv].cbx[lcv2].checked = true then chval = 1 else chval = 0
		insert into system_settings(ss_id, ss_uid, ss_long) values
			(:comp[lcv].ninethou_id[lcv2], :maxid, :chval) ;
		if sqlca.sqlcode <> 0 then
			failnote = "Insert 9000's:  " + comp[lcv].cbx[lcv2].text + "~n" +&
			"Sql:  " + sqlca.sqlerrtext
			goto rollitback ;
		end if
		savenote += string(comp[lcv].ninethou_id[lcv2]) + "  " +&
		string(maxid) + "  " + string(chval) + "~n"
	next
	savenote += "~n"
next


commit ;
//messagebox("", savenote)
ddlb_names.additem(sle_name.text)
ddlb_names.selectitem(sle_name.text, 0)
ddlb_names.visible = true
sle_name.visible = false

tot_defined ++
class[tot_defined].id = abs(maxid)
class[tot_defined].name = sle_name.text
class[tot_defined].indx = 0

for lcv = 1 to comp_indx
	for lcv2 = 1 to comp[lcv].indx
		if comp[lcv].cbx[lcv2].checked = true then chval = 1 else chval = 0
		class[tot_defined].indx ++
		class[tot_defined].val[class[tot_defined].indx] = chval
		class[tot_defined].item[class[tot_defined].indx] = comp[lcv].ninethou_id[lcv2]
	next
next
return 0

//-----------------
rollitback:
	rollback ;
	return -1


end function

public function integer save_employee (ref string failnote);/* return   0 = everything saved
	return 100 = nothing modified, no need to save
	return  99 = user wants to enter more info, stop action without a messagebox
	return  -1 = database error, stop action and give user a message */

string tester

if cur_emp.em_id = 10000 then

	//This is the PTADMIN section.  The only thing it will update is the password.

	if cur_pwd = orig_pwd then return 100
	if len(cur_pwd) > 0 then //should be
		update employees set em_password = :cur_pwd 
		where em_id = 10000 and em_password = :orig_pwd ;
		if sqlca.sqlcode = 0 then
			commit ;
			orig_pwd = cur_pwd
		else
			goto rollitback
		end if
	else
		failnote = "Error processing save request."
		return -1
	end if
	return 0
end if
		
boolean priv_changes = false, emp_changes = false, one_on_exists = false
integer lcv, lcv2
long curclass

for lcv = 1 to comp_indx
	if len(trim(comp[lcv].noprivs_pm.text)) > 0 then priv_changes = true
	if comp[lcv].noprivs_cbx.checked = false then one_on_exists = true
	for lcv2 = 1 to comp[lcv].indx
		if len(trim(comp[lcv].plusminus[lcv2].text)) > 0 then priv_changes = true
		if comp[lcv].cbx[lcv2].checked = true then one_on_exists = true
	next
next

//Track these two separately, so if only the password (or ref, if we offer that) changes, 
//we don't have to do the privilege update processing.
if (cur_pwd = orig_pwd) or (isnull(cur_pwd) and isnull(orig_pwd)) &
	then emp_changes = emp_changes else emp_changes = true
//if (cur_ref = orig_ref) or (isnull(cur_ref) and isnull(orig_ref)) &
//	then emp_changes = emp_changes else emp_changes = true

if one_on_exists = false and ddlb_names.text <> no_priv_text then
	//I would prefer to give a cancel option here, but the current return value structure
	//doesn't permit it (you get a message if you return -1, and otherwise, whatever you
	//were doing proceeds.)
	//meg's response:  retval of 99 will stop action without message

	if messagebox("Save Changes", "Please Note:  Since this employee no longer has any "+&
		"privileges, their user class will be changed from " + ddlb_names.text + " to " +&
		no_priv_text + ".~n~nOK to continue?", question!, okcancel!) = 2 then return 99
	curclass = 1001
	ddlb_names.selectitem(no_priv_text, 0)
	set_user_check()
else
	for lcv = 1 to tot_defined 
		if class[lcv].name = ddlb_names.text then
			curclass = class[lcv].id
			exit
		end if
	next
end if

choose case cbx_customerhold.checked
	case true
		if il_originalcustomerholdvalue = 0 then
			priv_changes = true
			il_originalcustomerholdvalue = 1
		end if
	case false
		if il_originalcustomerholdvalue = 1 then
			priv_changes = true
			il_originalcustomerholdvalue = 0
		end if
end choose

if originals_exist = true and priv_changes = false and emp_changes = false then return 100

if originals_exist = true and priv_changes = false then goto emp_changer

delete from system_settings where ss_uid = :cur_emp.em_id and
	((ss_id >= 9000 and ss_id < 10000) or (ss_id >= 19000 and ss_id < 20000) or 
	(ss_id >= 29000 and ss_id < 30000) or (ss_id >= 39000 and ss_id < 40000)) ;
if sqlca.sqlcode = 0 or sqlca.sqlcode = 100 then 
else
	tester = "Point1~n" + sqlca.sqlerrtext + "~n" + string(sqlca.sqlcode)
	goto rollitback 
end if

integer dbval, newrow
ds_ind_classes.reset()
for lcv = 1 to comp_indx
	for lcv2 = 1 to comp[lcv].indx
		if comp[lcv].cover[lcv2].textcolor = modcolor then 
			if comp[lcv].cbx[lcv2].checked = true then dbval = 1 else dbval = 0
			newrow = ds_ind_classes.insertrow(0)
			ds_ind_classes.setitem(newrow, "ss_id", comp[lcv].ninethou_id[lcv2])
			ds_ind_classes.setitem(newrow, "ss_uid", cur_emp.em_id)
			ds_ind_classes.setitem(newrow, "ss_long", dbval)
		end if
	next
next

//credit hold privilege (39001
newrow = ds_ind_classes.insertrow(0)
ds_ind_classes.setitem(newrow, "ss_id", 39001)
ds_ind_classes.setitem(newrow, "ss_uid", cur_emp.em_id)
if cbx_customerhold.checked = true then
	ds_ind_classes.setitem(newrow, "ss_long", 1)
else
	ds_ind_classes.setitem(newrow, "ss_long", 0)
end if

long origclass
select em_class into :origclass from employees where em_id = :cur_Emp.em_id ;
if sqlca.sqlcode <> 0 then 
	tester = "Point2~n" + sqlca.sqlerrtext + "~n" + string(sqlca.sqlcode)
	goto rollitback 
end if

//essagebox("orig class", "InstVar  = " + string(cur_emp.em_class) +&
// "~nDBval   = " + string(origclass) +&
// "~nCurclass  = " + string(curclass) + "~n~nOrig Exist ? - " + string(originals_exist))

if cur_emp.em_class <> origclass then 
	failnote = "Information was already changed by another user or in another window."
	return -1
end if

update employees set em_class = :curclass where em_id = :cur_emp.em_id ;
if sqlca.sqlcode <> 0 then 
	tester = "Point3~n" + sqlca.sqlerrtext + "~n" + string(sqlca.sqlcode)
	goto rollitback
end if

if ds_ind_classes.update(false, false) = -1 then 
	tester = "Point4~nupdating ds_ind_classes."
	goto rollitback
end if

emp_changer:

if emp_changes then
	//Script will need to be added for em_ref, if we offer that.
	if isnull(orig_pwd) then
		update employees set em_password = :cur_pwd
		where em_id = :cur_emp.em_id and em_password is null ;
	else
		update employees set em_password = :cur_pwd
		where em_id = :cur_emp.em_id and em_password = :orig_pwd ;
	end if
	if sqlca.sqlcode <> 0 then 
		tester = "Point5~n" + sqlca.sqlerrtext + "~n" + string(sqlca.sqlcode)
		goto rollitback
	end if
end if

commit ;

ds_ind_classes.resetupdate()
orig_pwd = cur_pwd
//orig_ref = cur_ref

if originals_exist = true and priv_changes = false then return 0

long diffid
integer lcv3
boolean onval

cur_emp.em_class = curclass
setup_originals()
for lcv = 1 to ds_ind_classes.rowcount()
	diffid =  ds_ind_classes.getitemnumber(lcv, "ss_id") 
	for lcv2 = 1 to comp_indx
		for lcv3 = 1 to comp[lcv2].indx
			if comp[lcv2].ninethou_id[lcv3] = diffid then 
				if ds_ind_classes.getitemnumber(lcv, "ss_long") = 0 then onval = false else onval = true
				comp[lcv2].origval[lcv3] = onval
				goto nextone
			end if 
		next
	next
	nextone:
next
originals_exist = true
reset_face()

for lcv = 1 to gds_emp.rowcount()
	if gds_emp.getitemnumber(lcv, "em_id") = cur_emp.em_id then
		gds_emp.setitem(lcv, "em_class", cur_emp.em_class)

//		This part didn't look healthy to me.  Brian.
//		if g_uid = gds_emp.getitemstring(lcv, "em_ref") then
//			cur_emp.em_ref = gds_emp.getitemstring(lcv, "em_ref")
//			exit
//		end if

		uo_choose_emp.ds_hotkey.reset()
		if gds_emp.rowcount() > 1 then   
			uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
		else
			uo_choose_emp.hsb_1.Visible = false
		end if
		exit
	end if
next

if cur_emp.em_ref = gnv_App.of_GetUserId ( ) then//---------------------------------------
	messagebox("User Privileges", "You have changed your own user privileges.  These " +&
	"changes have been updated in the database but will not take effect until your next " +&
	"log on to the system.")
end if
//----------------------------------------------------------------------------------------	
return 0


rollitback:
rollback ;
failnote = "Could not save changes to database." /*+ "~n~n" + tester*/
return -1


end function

public function integer cbx_clicked (checkbox curcbx);integer lcv, lcv2, cur1, cur2
for lcv = 1 to comp_indx
	for lcv2 = 1 to comp[lcv].indx
		if comp[lcv].cbx[lcv2] = curcbx then
			cur1 = lcv
			cur2 = lcv2
			goto getout
		end if
	next
next

getout:

boolean all_off = true
if comp[cur1].cbx[cur2].checked = true then 
	comp[cur1].noprivs_cbx.checked = false
else
	for lcv = 1 to comp[cur1].indx
		if comp[cur1].cbx[lcv].checked = true then all_off = false		
	next
	if all_off then comp[cur1].noprivs_cbx.checked = true
end if
return 0



end function

public function integer mod_class (checkbox curcbx);integer lcv
if isnull(cur_emp.em_id) then
//	for lcv = 1 to comp_indx
//		if comp[lcv].noprivs_cbx = curcbx and curcbx.checked = true then return -1
//	next
//	if sle_name.visible = false then return -1
	return -1
elseif (cur_emp.em_id) = 10000 then
	return -1
elseif (cur_emp.em_id) = user_id then
	beep(1)
	if one_warn = false then 
		messagebox("Change Privileges", "You cannot modify your own user privileges.")
		one_warn = true
	end if 
	return -1
else
	if ddlb_names.text = no_priv_text then
		beep(1)
		return -1
	end if
	for lcv = 1 to comp_indx
		if comp[lcv].noprivs_cbx = curcbx and curcbx.checked = true then return -1
	next
end if

return 0
end function

public function integer set_choose_emp ();uo_choose_emp.w_mainpar = this
if gds_emp.rowcount() > 0 then   
	uo_choose_emp.ds_hotkey.object.data.primary = gds_emp.object.data.primary
else
	uo_choose_emp.hsb_1.Visible = false
end if

uo_choose_emp.sle_name.width = uo_choose_emp.sle_name.width - 90
uo_choose_emp.hsb_1.x = 9 + uo_choose_emp.sle_name.x + uo_choose_emp.sle_name.width
uo_choose_emp.st_tag1.text = "Employee"

uo_choose_emp.sle_name.setfocus()
uo_choose_emp.cur_emp.em_Id = null_long

return 0


end function

public function integer emp_switch (integer uo_num);s_emp_info temp_emp
temp_emp = uo_choose_emp.temp_emp

boolean changes_exist = false
integer lcv, lcv2, lcv3
long curclass

if isnull(temp_emp.em_id) then return 0
if isnull(cur_emp.em_id) then goto retpart

for lcv = 1 to comp_indx
	if len(trim(comp[lcv].noprivs_pm.text)) > 0 then changes_exist = true
	for lcv2 = 1 to comp[lcv].indx
		if len(trim(comp[lcv].plusminus[lcv2].text)) > 0 then changes_exist = true
	next
next

choose case cbx_customerhold.checked
	case true
		if il_originalcustomerholdvalue = 0 then
			changes_exist = true
		end if
	case false
		if il_originalcustomerholdvalue = 1 then
			changes_exist = true
		end if
end choose

if (cur_pwd = orig_pwd) or (isnull(cur_pwd) and isnull(orig_pwd)) &
	then changes_exist = changes_exist else changes_exist = true
//if (cur_ref = orig_ref) or (isnull(cur_ref) and isnull(orig_ref)) &
//	then changes_exist = changes_exist else changes_exist = true

if changes_exist then 
	choose case messagebox("Switch Employees", "Save changes to the current employee first?", &
		question!, yesnocancel!, 1) 
	case 1 
		string failnote
		integer retval
		retval = save_Employee(failnote)
		if retval = -1 then 
			if messagebox("Save Changes", failnote + "~n~n" +&
			"Press OK to abandon changes and switch employees, or press Cancel to return " +&
			"to the current employee and preserve changes for now.", exclamation!, okcancel!) = 2 then goto oldemp
		elseif retval = 99 then 
			goto oldemp
		end if
	case 3
		goto oldemp
	end choose
end if

retpart:
string ret_pwd, ret_ref
long dbclass
select em_password, em_ref, em_class into :ret_pwd, :ret_ref, :dbclass from employees
	where em_id = :temp_emp.em_id ;
//In a multi-user situation, this could produce an apparent conflict, if the actual
//ref value in the db is different from the one in the cache.  Should we use the cache
//value instead, even though it could lead to a failed update?

//Meg's response:  I am aware of the conflict but this version is not a multi-user situation

if sqlca.sqlcode <> 0 then
	rollback ;
	messagebox("Switch Employees", "Could not retrieve employee privilege information.~n~n"+&
		"Window will close.", exclamation!)
	close(this)
	return -1
else
	commit ;
end if

if dbclass <> temp_emp.em_class or (isnull(temp_emp.em_class) and not isnull(dbclass)) or &
	(isnull(dbclass) and not isnull(temp_emp.em_class) ) then temp_emp.em_class = dbclass

string class_name
if isnull(temp_emp.em_class) then 
	temp_emp.em_class = 1001 //no privileges
	originals_exist = false
else
	originals_exist = true
end if
for lcv = 1 to tot_defined
	if class[lcv].id = temp_emp.em_class then
		class_name = class[lcv].name
		exit
	end if
next
display_class(class_name)
if originals_exist then	setup_originals()
for lcv = 1 to comp_indx
	for lcv2 = 1 to comp[lcv].indx
		comp[lcv].plusminus[lcv2].visible = originals_exist
	next
next

long diffid
boolean onval

if ds_ind_classes.retrieve(temp_emp.em_id) = -1 then
	rollback ;
	messagebox("Switch Employees", "Could not retrieve employee privilege information.~n~n"+&
		"Window will close.", exclamation!)
	close(this)
	return -1
else
	commit ;
end if

il_originalcustomerholdvalue = 0
cbx_customerhold.checked = false

for lcv = 1 to ds_ind_classes.rowcount()
	diffid =  ds_ind_classes.getitemnumber(lcv, "ss_id") 
	
	//customer hold
	if diffid = 39001 then 
		il_originalcustomerholdvalue = ds_ind_classes.getitemnumber(lcv, "ss_long")
		if il_originalcustomerholdvalue = 1 then 
			cbx_customerhold.checked = true 
		else
			cbx_customerhold.checked = false
		end if
		exit
	end if
	
	for lcv2 = 1 to comp_indx
		for lcv3 = 1 to comp[lcv2].indx
			if comp[lcv2].ninethou_id[lcv3] = diffid then 
				if ds_ind_classes.getitemnumber(lcv, "ss_long") = 0 then onval = false else onval = true
				comp[lcv2].cbx[lcv3].checked = onval
				comp[lcv2].origval[lcv3] = onval
				goto nextone
			end if 
		next
	next
	nextone:
next

orig_pwd = ret_pwd
cur_pwd = ret_pwd
orig_ref = ret_ref
cur_ref = ret_ref

cur_emp = temp_emp
uo_choose_emp.set_emp(true)
reset_face()
set_user_check()
return 0

oldemp:
uo_choose_emp.set_emp(false)
return 0





end function

public subroutine zz_refresh ();integer lcv, lcv2, lcv3

//if isnull(cur_Emp.em_id) and uo_choose_Emp.visible = false then goto skipthis
if isnull(cur_Emp.em_id) then return
if originals_exist = false then return
//-----------------------------------------
long diffid
boolean onval
string class_name

for lcv = 1 to tot_defined
	if class[lcv].id = cur_emp.em_class then
		class_name = class[lcv].name
		exit
	end if
next
display_class(class_name)

for lcv = 1 to ds_ind_classes.rowcount()
	diffid =  ds_ind_classes.getitemnumber(lcv, "ss_id") 
	for lcv2 = 1 to comp_indx
		for lcv3 = 1 to comp[lcv2].indx
			if comp[lcv2].ninethou_id[lcv3] = diffid then 
				if ds_ind_classes.getitemnumber(lcv, "ss_long") = 0 then onval = false else onval = true
				comp[lcv2].cbx[lcv3].checked = onval
				goto nextone
			end if 
		next
	next
	nextone:
next
reset_face()
return
//-----------------------------------------

//skipthis:
//sle_name.visible = true
//ddlb_names.visible = false
//sle_name.text = ""
//for lcv = 1 to comp_indx
//	for lcv2 = 1 to comp[lcv].indx
//		comp[lcv].cbx[lcv2].checked = false
//	next
//next
//sle_name.setfocus()
//
end subroutine

public subroutine zz_password ();if isnull(cur_emp.em_id) then return

if cur_emp.em_id = 10000 and gnv_App.of_GetUserId ( ) <> "PTADMIN" then
	messagebox("Change Password", "Only a user logged in as PTADMIN can change " +&
	"PTADMIN's password.")
	return
end if


string new_pwd
openwithparm(w_password, cur_emp.em_ref)
new_pwd = message.stringparm

if len(new_pwd) > 0 then
	cur_pwd = new_pwd
	set_user_check()
end if

//if not isnull(pwd) and len(trim(pwd)) > 0 then
//	update employees set em_password = :pwd where em_id = :cur_emp.em_id ;
//	if sqlca.sqlcode <> 0 then 
//		rollback ;
//		messagebox("Update Password", "Could not update database with new password.  " +&
//		"~n~nPlease try again.")
//		return
//	else
//		commit ;
//	end if
//end if


end subroutine

public subroutine ptadmin_switch ();boolean changes_exist = false
integer lcv, lcv2, lcv3
long curclass

if isnull(cur_emp.em_id) then goto retpart

for lcv = 1 to comp_indx
	if len(trim(comp[lcv].noprivs_pm.text)) > 0 then changes_exist = true
	for lcv2 = 1 to comp[lcv].indx
		if len(trim(comp[lcv].plusminus[lcv2].text)) > 0 then changes_exist = true
	next
next

if (cur_pwd = orig_pwd) or (isnull(cur_pwd) and isnull(orig_pwd)) &
	then changes_exist = changes_exist else changes_exist = true
//if (cur_ref = orig_ref) or (isnull(cur_ref) and isnull(orig_ref)) &
//	then changes_exist = changes_exist else changes_exist = true

if changes_exist then
	choose case messagebox("Switch Employees", "Save changes to the current employee first?", &
		question!, yesnocancel!, 1) 
	case 1
		string failnote
		integer retval
		retval = save_employee(failnote)
		if retval = -1 then 
			if messagebox("Save Changes", failnote + "~n~n" +&
			"Press OK to abandon changes and switch employees, or press Cancel to return " +&
			"to the current employee and preserve changes for now.", exclamation!, okcancel!) = 2 then goto oldemp
		elseif retval = 99 then 
			goto oldemp
		end if
	case 3
		goto oldemp
	end choose
end if

//if changes_exist then 
//	if messagebox("Save Changes", "There were changes to the current employee's settings." +&
//	"~n~nPress Ok to save changes.  Press Cancel to continue.", &
//	exclamation!, okcancel!, 1) = 1 then 
//		string failnote
//		integer retval
//		retval = save_employee(failnote)
//		if retval = -1 then 
//			if messagebox("Save Changes", failnote + "~n~n" +&
//			"Press Ok to remain with current employee and retry save.  Press Cancel to cancel " +&
//			"save and move to PTADMIN.", exclamation!, okcancel!) = 1 then return
//		elseif retval = 99 then 
//			return
//		end if
//	end if
//end if

retpart:

string ret_pwd
select em_password into :ret_pwd from employees where em_id = 10000 ;

if sqlca.sqlcode <> 0 then
	rollback ;
	messagebox("Switch Employees", "Could not retrieve employee privilege information.~n~n"+&
		"Window will close.", exclamation!)
	close(this)
	return
else
	commit ;
end if

display_class(all_priv_text)
cur_emp.em_id = 10000
cur_emp.em_ln = "PTADMIN"
cur_emp.em_ref = "PTADMIN"
cur_emp.em_fn = ""
cur_emp.em_mn = ""
cur_emp.em_status = "K"
cur_emp.em_type = 0
cur_emp.em_class = 1005
ddlb_names.enabled = false
originals_exist = false

orig_pwd = ret_pwd
cur_pwd = ret_pwd
orig_ref = "PTADMIN"
cur_ref = "PTADMIN"

set_user_check()

for lcv = 1 to comp_indx
	comp[lcv].noprivs_pm.text = ""
	comp[lcv].noprivs_cover.textcolor = 0
	for lcv2 = 1 to comp[lcv].indx
		comp[lcv].plusminus[lcv2].text = ""
		comp[lcv].cover[lcv2].textcolor = 0
	next
next
st_modified.visible = false
uo_choose_emp.cur_emp.em_id = null_long
reset_face()
return

oldemp:
uo_choose_emp.set_emp(false)

end subroutine

public subroutine zz_save ();if isnull(cur_emp.em_id) then return

//Now, the password change gets handled in the save function.
//if cur_emp.em_id = 10000 then
//	messagebox("Save Changes", "Changes for the user PTADMIN are not allowed.")
//	return
//end if

string failnote
integer retval

retval = save_employee(failnote)
if retval = -1 then messagebox("Save Changes", "Could not save changes to database.", &
	exclamation!)




end subroutine

protected subroutine set_user_check ();boolean has_pwd, has_ref
string checkstr

if ddlb_names.text = no_priv_text or isnull(cur_emp.em_id) then
	st_user_check.text = ""
	st_user_check.textcolor = 0
	st_user_check.visible = false
	return
end if

if len(cur_pwd) > 0 then has_pwd = true
if len(cur_ref) > 0 then has_ref = true

if has_pwd and has_ref then
	checkstr = "User can log on."
	st_user_check.textcolor = 0
else
	st_user_check.textcolor = 128
	if has_pwd then
		checkstr = "User needs Quick Ref. Code."
	elseif has_ref then
		checkstr = "User needs Password."
	else
		checkstr = "Needs Quick Ref. Code, Password."
	end if
end if

st_user_check.text = checkstr
st_user_check.visible = true
end subroutine

public function integer zz_extended ();openwithparm( w_userPrivs, cur_emp.em_id )

Return 1

end function

on w_privileges.create
if this.MenuName = "m_privs" then this.MenuID = create m_privs
this.st_4=create st_4
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_1=create gb_1
this.cbx_settle_adj=create cbx_settle_adj
this.st_cover_settle9=create st_cover_settle9
this.st_cover_settle1=create st_cover_settle1
this.st_cover_settle2=create st_cover_settle2
this.st_cover_settle3=create st_cover_settle3
this.st_cover_settle5=create st_cover_settle5
this.st_cover_settle6=create st_cover_settle6
this.st_cover_settle7=create st_cover_settle7
this.st_cover_settle8=create st_cover_settle8
this.st_cover_settle4=create st_cover_settle4
this.st_cover_settle0=create st_cover_settle0
this.cbx_settle_settle=create cbx_settle_settle
this.cbx_settle_status=create cbx_settle_status
this.cbx_settle_edit2=create cbx_settle_edit2
this.cbx_settle_trip=create cbx_settle_trip
this.cbx_settle_unsettle=create cbx_settle_unsettle
this.cbx_settle_view=create cbx_settle_view
this.cbx_settle_reports=create cbx_settle_reports
this.cbx_settle_edit1=create cbx_settle_edit1
this.st_settle1=create st_settle1
this.st_settle0=create st_settle0
this.cbx_settle_privileges=create cbx_settle_privileges
this.st_3=create st_3
this.st_user_check=create st_user_check
this.uo_choose_emp=create uo_choose_emp
this.sle_name=create sle_name
this.st_cover_log0=create st_cover_log0
this.st_cover_emp0=create st_cover_emp0
this.st_cover_log4=create st_cover_log4
this.st_cover_log8=create st_cover_log8
this.st_cover_log7=create st_cover_log7
this.st_cover_log6=create st_cover_log6
this.st_cover_log5=create st_cover_log5
this.st_cover_log3=create st_cover_log3
this.st_cover_log2=create st_cover_log2
this.st_cover_log1=create st_cover_log1
this.st_cover_emp7=create st_cover_emp7
this.st_cover_emp6=create st_cover_emp6
this.st_cover_emp5=create st_cover_emp5
this.st_cover_emp4=create st_cover_emp4
this.st_cover_emp3=create st_cover_emp3
this.st_cover_emp2=create st_cover_emp2
this.st_log8=create st_log8
this.st_log7=create st_log7
this.st_log6=create st_log6
this.st_log5=create st_log5
this.st_log4=create st_log4
this.st_log3=create st_log3
this.st_log2=create st_log2
this.st_log1=create st_log1
this.st_log0=create st_log0
this.st_emp0=create st_emp0
this.st_emp7=create st_emp7
this.st_emp6=create st_emp6
this.st_emp5=create st_emp5
this.st_emp4=create st_emp4
this.st_emp3=create st_emp3
this.st_emp2=create st_emp2
this.st_emp1=create st_emp1
this.cbx_log_reports1=create cbx_log_reports1
this.cbx_log_privileges=create cbx_log_privileges
this.cbx_emp_privileges=create cbx_emp_privileges
this.st_2=create st_2
this.st_1=create st_1
this.cbx_emp_grant=create cbx_emp_grant
this.cbx_emp_add=create cbx_emp_add
this.cbx_emp_viewadmin=create cbx_emp_viewadmin
this.cbx_emp_viewdriver=create cbx_emp_viewdriver
this.cbx_log_reports2=create cbx_log_reports2
this.cbx_emp_password=create cbx_emp_password
this.cbx_emp_edit=create cbx_emp_edit
this.cbx_log_view=create cbx_log_view
this.cbx_log_mph=create cbx_log_mph
this.cbx_log_purge=create cbx_log_purge
this.cbx_log_lock=create cbx_log_lock
this.cbx_log_edit=create cbx_log_edit
this.cbx_emp_viewphone=create cbx_emp_viewphone
this.ddlb_names=create ddlb_names
this.st_modified=create st_modified
this.st_cover_emp1=create st_cover_emp1
this.cbx_log_excuse=create cbx_log_excuse
this.gb_2=create gb_2
this.st_settle2=create st_settle2
this.st_settle3=create st_settle3
this.st_settle4=create st_settle4
this.st_settle5=create st_settle5
this.st_settle6=create st_settle6
this.st_settle7=create st_settle7
this.st_settle8=create st_settle8
this.st_settle9=create st_settle9
this.st_mask=create st_mask
this.cbx_customerhold=create cbx_customerhold
this.gb_3=create gb_3
this.gb_7=create gb_7
this.gb_4=create gb_4
this.gb_8=create gb_8
this.Control[]={this.st_4,&
this.gb_6,&
this.gb_5,&
this.gb_1,&
this.cbx_settle_adj,&
this.st_cover_settle9,&
this.st_cover_settle1,&
this.st_cover_settle2,&
this.st_cover_settle3,&
this.st_cover_settle5,&
this.st_cover_settle6,&
this.st_cover_settle7,&
this.st_cover_settle8,&
this.st_cover_settle4,&
this.st_cover_settle0,&
this.cbx_settle_settle,&
this.cbx_settle_status,&
this.cbx_settle_edit2,&
this.cbx_settle_trip,&
this.cbx_settle_unsettle,&
this.cbx_settle_view,&
this.cbx_settle_reports,&
this.cbx_settle_edit1,&
this.st_settle1,&
this.st_settle0,&
this.cbx_settle_privileges,&
this.st_3,&
this.st_user_check,&
this.uo_choose_emp,&
this.sle_name,&
this.st_cover_log0,&
this.st_cover_emp0,&
this.st_cover_log4,&
this.st_cover_log8,&
this.st_cover_log7,&
this.st_cover_log6,&
this.st_cover_log5,&
this.st_cover_log3,&
this.st_cover_log2,&
this.st_cover_log1,&
this.st_cover_emp7,&
this.st_cover_emp6,&
this.st_cover_emp5,&
this.st_cover_emp4,&
this.st_cover_emp3,&
this.st_cover_emp2,&
this.st_log8,&
this.st_log7,&
this.st_log6,&
this.st_log5,&
this.st_log4,&
this.st_log3,&
this.st_log2,&
this.st_log1,&
this.st_log0,&
this.st_emp0,&
this.st_emp7,&
this.st_emp6,&
this.st_emp5,&
this.st_emp4,&
this.st_emp3,&
this.st_emp2,&
this.st_emp1,&
this.cbx_log_reports1,&
this.cbx_log_privileges,&
this.cbx_emp_privileges,&
this.st_2,&
this.st_1,&
this.cbx_emp_grant,&
this.cbx_emp_add,&
this.cbx_emp_viewadmin,&
this.cbx_emp_viewdriver,&
this.cbx_log_reports2,&
this.cbx_emp_password,&
this.cbx_emp_edit,&
this.cbx_log_view,&
this.cbx_log_mph,&
this.cbx_log_purge,&
this.cbx_log_lock,&
this.cbx_log_edit,&
this.cbx_emp_viewphone,&
this.ddlb_names,&
this.st_modified,&
this.st_cover_emp1,&
this.cbx_log_excuse,&
this.gb_2,&
this.st_settle2,&
this.st_settle3,&
this.st_settle4,&
this.st_settle5,&
this.st_settle6,&
this.st_settle7,&
this.st_settle8,&
this.st_settle9,&
this.st_mask,&
this.cbx_customerhold,&
this.gb_3,&
this.gb_7,&
this.gb_4,&
this.gb_8}
end on

on w_privileges.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_4)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.cbx_settle_adj)
destroy(this.st_cover_settle9)
destroy(this.st_cover_settle1)
destroy(this.st_cover_settle2)
destroy(this.st_cover_settle3)
destroy(this.st_cover_settle5)
destroy(this.st_cover_settle6)
destroy(this.st_cover_settle7)
destroy(this.st_cover_settle8)
destroy(this.st_cover_settle4)
destroy(this.st_cover_settle0)
destroy(this.cbx_settle_settle)
destroy(this.cbx_settle_status)
destroy(this.cbx_settle_edit2)
destroy(this.cbx_settle_trip)
destroy(this.cbx_settle_unsettle)
destroy(this.cbx_settle_view)
destroy(this.cbx_settle_reports)
destroy(this.cbx_settle_edit1)
destroy(this.st_settle1)
destroy(this.st_settle0)
destroy(this.cbx_settle_privileges)
destroy(this.st_3)
destroy(this.st_user_check)
destroy(this.uo_choose_emp)
destroy(this.sle_name)
destroy(this.st_cover_log0)
destroy(this.st_cover_emp0)
destroy(this.st_cover_log4)
destroy(this.st_cover_log8)
destroy(this.st_cover_log7)
destroy(this.st_cover_log6)
destroy(this.st_cover_log5)
destroy(this.st_cover_log3)
destroy(this.st_cover_log2)
destroy(this.st_cover_log1)
destroy(this.st_cover_emp7)
destroy(this.st_cover_emp6)
destroy(this.st_cover_emp5)
destroy(this.st_cover_emp4)
destroy(this.st_cover_emp3)
destroy(this.st_cover_emp2)
destroy(this.st_log8)
destroy(this.st_log7)
destroy(this.st_log6)
destroy(this.st_log5)
destroy(this.st_log4)
destroy(this.st_log3)
destroy(this.st_log2)
destroy(this.st_log1)
destroy(this.st_log0)
destroy(this.st_emp0)
destroy(this.st_emp7)
destroy(this.st_emp6)
destroy(this.st_emp5)
destroy(this.st_emp4)
destroy(this.st_emp3)
destroy(this.st_emp2)
destroy(this.st_emp1)
destroy(this.cbx_log_reports1)
destroy(this.cbx_log_privileges)
destroy(this.cbx_emp_privileges)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cbx_emp_grant)
destroy(this.cbx_emp_add)
destroy(this.cbx_emp_viewadmin)
destroy(this.cbx_emp_viewdriver)
destroy(this.cbx_log_reports2)
destroy(this.cbx_emp_password)
destroy(this.cbx_emp_edit)
destroy(this.cbx_log_view)
destroy(this.cbx_log_mph)
destroy(this.cbx_log_purge)
destroy(this.cbx_log_lock)
destroy(this.cbx_log_edit)
destroy(this.cbx_emp_viewphone)
destroy(this.ddlb_names)
destroy(this.st_modified)
destroy(this.st_cover_emp1)
destroy(this.cbx_log_excuse)
destroy(this.gb_2)
destroy(this.st_settle2)
destroy(this.st_settle3)
destroy(this.st_settle4)
destroy(this.st_settle5)
destroy(this.st_settle6)
destroy(this.st_settle7)
destroy(this.st_settle8)
destroy(this.st_settle9)
destroy(this.st_mask)
destroy(this.cbx_customerhold)
destroy(this.gb_3)
destroy(this.gb_7)
destroy(this.gb_4)
destroy(this.gb_8)
end on

event open;/*  three cases for opening this window:

1.  opened in order to define a new class of privileges.
	 No driver can be retrieved
	 no powerobject parm (not for this version)

2.  Employee window is opened and they are obviously trying to set that employees settings

3.  Opened with the employee screen not opened
--------------------------------------------------------------*/


//Settlements Notes  2.3.00  BKW
//Basically, all the old settlements functionality is here untouched.  I've just hidden it.
//What used to be "Settlements Entry", I've renamed "All Privileges"
//st_Mask is used to help hide all the stuff that gets redisplayed in reset_face()
//Aside from some design-time invisible properties, the only code changes are in
//reset_face() and setup_arrays(), related to st_Mask

//Settlements Notes  2.7.00  BKW
//Renamed "All Privileges" to "Privileges by User Class"

//Note:  When you change one of the Checkbox texts, you have to change the Tag value in
//it to specify the new width of the text, so that the cover static text will be sized properly.


if g_privs.emp[6] = 0 then
	messagebox("User Privileges", "Your current user privileges do not allow you to " +&
	"access this screen.")
	close(this)
	return
end if

this.x = 1
this.y = 1
this.width = 3246  //2062 without settlements privileges
this.height = 1293

ds_emp_classes = CREATE datastore  
ds_emp_classes.DataObject = "d_emp_classes"
ds_emp_classes.SetTransObject(sqlca) 

ds_ind_classes = CREATE datastore  
ds_ind_classes.DataObject = "d_ind_classes"
ds_ind_classes.SetTransObject(sqlca) 

if ds_emp_classes.retrieve() = -1 then
	rollback ;
	messagebox("User Privileges", "Could not retrieve information necessary to open "+&
		"this window.", exclamation!)
	close(this)
	return
else
	commit ;
end if

tot_defined = 1
class[1].name = ds_emp_classes.getitemstring(1, "class_name")
class[1].indx = 1
class[1].id = ds_emp_classes.getitemnumber(1, "class_id")
class[1].val[1] = ds_emp_classes.getitemnumber(1, "priv_val")
class[1].item[1] = ds_emp_classes.getitemnumber(1, "priv_item")
ddlb_names.additem(class[1].name)
if class[1].id = 1001 then no_priv_text = class[1].name
if class[1].id = 1005 then all_priv_text = class[1].name

integer lcv
for lcv = 2 to ds_emp_classes.rowcount()
	if ds_emp_classes.getitemnumber(lcv - 1, "class_id") = &
		ds_emp_classes.getitemnumber(lcv, "class_id") then
		class[tot_defined].indx ++
		class[tot_defined].val[class[tot_defined].indx] = ds_emp_classes.getitemnumber(lcv, "priv_val")
		class[tot_defined].item[class[tot_defined].indx] = ds_emp_classes.getitemnumber(lcv, "priv_item")
	else
		tot_defined ++
		class[tot_defined].id = ds_emp_classes.getitemnumber(lcv, "class_id")
		class[tot_defined].name = ds_emp_classes.getitemstring(lcv, "class_name")
		class[tot_defined].indx = 1
		class[tot_defined].val[1] = ds_emp_classes.getitemnumber(lcv, "priv_val")
		class[tot_defined].item[1] = ds_emp_classes.getitemnumber(lcv, "priv_item")
		ddlb_names.additem(class[tot_defined].name)
		if class[tot_defined].id = 1001 then no_priv_text = class[tot_defined].name
		if class[tot_defined].id = 1005 then all_priv_text = class[tot_defined].name
	end if
next

setup_arrays()
set_choose_emp()

//string class_name
//window checkwin
//
//checkwin = w_frame.getfirstsheet()
//if isvalid(checkwin) then
//	if classname(checkwin) = "w_emp_info" then
//		if not isnull(w_emp_info.cur_emp.em_id) then 
//			uo_choose_emp.temp_emp = w_emp_info.cur_emp
//			emp_switch(1)
//		end if
//	end if 
//end if

String ls_UserId
ls_UserId = gnv_App.of_GetUserId ( )

cur_emp.em_id = null_Long
display_class(no_priv_text)
reset_Face()
gf_mask_menu(m_privs)
select em_id into :user_id from employees where em_ref = :ls_UserId ;
if sqlca.sqlcode <> 0 then
	rollback ;
	messagebox("User Privileges", "Could not retrieve information necessary to open "+&
		"this window.", exclamation!)
	close(this)
	return
else
	commit ;
end if









//else  //------------------------------------------ setting up a class, not this version
//	uo_choose_emp.visible = false
//	originals_exist = false
//	setnull(cur_emp.em_id)
//	class_name = no_priv_text
//	display_class(class_name)
//	sle_name.x = ddlb_names.x
//	sle_name.y = ddlb_names.y
//	sle_name.width = ddlb_names.width
//	sle_name.height = cb_refresh.height
//	sle_name.visible = false
//	cb_refresh.visible = true
//	cb_refresh.text = "Define New Class"
//	this.title = "Defining Privilege Classes"
//	reset_face()
//end if



end event

event close;if isvalid(ds_emp_classes) then destroy ds_emp_classes
if isvalid(ds_ind_classes) then destroy ds_ind_classes
	 
end event

event closequery;boolean changes_exist = false
integer lcv, lcv2, lcv3
long curclass 

if isnull(cur_emp.em_id) then return 0

for lcv = 1 to comp_indx
	if len(trim(comp[lcv].noprivs_pm.text)) > 0 then changes_exist = true
	for lcv2 = 1 to comp[lcv].indx
		if len(trim(comp[lcv].plusminus[lcv2].text)) > 0 then changes_exist = true
	next
next

choose case cbx_customerhold.checked
	case true
		if il_originalcustomerholdvalue = 0 then
			changes_exist = true
		end if
	case false
		if il_originalcustomerholdvalue = 1 then
			changes_exist = true
		end if
end choose

if (cur_pwd = orig_pwd) or (isnull(cur_pwd) and isnull(orig_pwd)) &
	then changes_exist = changes_exist else changes_exist = true
//if (cur_ref = orig_ref) or (isnull(cur_ref) and isnull(orig_ref)) &
//	then changes_exist = changes_exist else changes_exist = true

if changes_exist then 
	this.setfocus()
	this.show()
	choose case messagebox("User Privileges", "Save changes before closing?", &
		question!, yesnocancel!, 1)
	case 1 
		string failnote
		integer retval
		retval = save_employee(failnote)
		if retval = -1 then 
			if messagebox("Save Changes", "Could not save changes to database.  Press OK to "+&
			"abandon changes and close window, or Cancel to return to window and preserve "+&
			"changes for now.", exclamation!, okcancel!) = 2 then return 1
		elseif retval = 99 then
			return 1
		end if
	case 2
		return 0
	case 3
		return 1
	end choose
end if


end event

type st_4 from statictext within w_privileges
integer x = 2272
integer y = 616
integer width = 425
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Miscellaneous"
boolean focusrectangle = false
end type

type gb_6 from groupbox within w_privileges
integer x = 2071
integer y = 444
integer width = 978
integer height = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_5 from groupbox within w_privileges
integer x = 1051
integer y = 444
integer width = 978
integer height = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_privileges
integer x = 37
integer y = 444
integer width = 978
integer height = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type cbx_settle_adj from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "462"
boolean visible = false
integer x = 2181
integer y = 1836
integer width = 905
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Create an Adjustment"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type st_cover_settle9 from statictext within w_privileges
integer x = 453
integer y = 1500
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle9"
boolean focusrectangle = false
end type

type st_cover_settle1 from statictext within w_privileges
integer x = 453
integer y = 1148
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle1"
boolean focusrectangle = false
end type

type st_cover_settle2 from statictext within w_privileges
integer x = 453
integer y = 1192
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle2"
boolean focusrectangle = false
end type

type st_cover_settle3 from statictext within w_privileges
integer x = 453
integer y = 1236
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle3"
boolean focusrectangle = false
end type

type st_cover_settle5 from statictext within w_privileges
integer x = 453
integer y = 1324
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle5"
boolean focusrectangle = false
end type

type st_cover_settle6 from statictext within w_privileges
integer x = 453
integer y = 1368
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle6"
boolean focusrectangle = false
end type

type st_cover_settle7 from statictext within w_privileges
integer x = 453
integer y = 1412
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle7"
boolean focusrectangle = false
end type

type st_cover_settle8 from statictext within w_privileges
integer x = 453
integer y = 1456
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle8"
boolean focusrectangle = false
end type

type st_cover_settle4 from statictext within w_privileges
integer x = 453
integer y = 1280
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle4"
boolean focusrectangle = false
end type

type st_cover_settle0 from statictext within w_privileges
integer x = 471
integer y = 1104
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "settle0"
boolean focusrectangle = false
end type

type cbx_settle_settle from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "407"
boolean visible = false
integer x = 2181
integer y = 1548
integer width = 905
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Settle a Settlement"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

if this.checked = false then comp[3].cbx[5].checked = false

reset_face()


end event

type cbx_settle_status from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "723"
boolean visible = false
integer x = 2181
integer y = 1476
integer width = 905
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Set/Override Settlement Statuses"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_settle_edit2 from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "865"
boolean visible = false
integer x = 2181
integer y = 1692
integer width = 960
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Edit Payscales/Standard Trips/Reoccur"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_settle_trip from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "279"
boolean visible = false
integer x = 2181
integer y = 1764
integer width = 905
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Create a Trip"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_settle_unsettle from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "462"
boolean visible = false
integer x = 2181
integer y = 1620
integer width = 905
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Unsettle a Settlement"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_settle_view from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "511"
integer x = 2153
integer y = 484
integer width = 905
integer height = 76
integer taborder = 230
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Privileges by User Class"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

integer lcv
if this.checked = false then 
	for lcv = 2 to comp[3].indx
		if lcv = 7 or lcv = 8 then continue
		comp[3].cbx[lcv].checked = false
	next
end if

reset_face()

end event

type cbx_settle_reports from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "705"
boolean visible = false
integer x = 2181
integer y = 1908
integer width = 905
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Print/Access Settlement Reports"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_settle_edit1 from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "677"
boolean visible = false
integer x = 2181
integer y = 1404
integer width = 992
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Edit Info. in Settlement Window"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

integer lcv
if this.checked = false then 
	for lcv = 3 to comp[3].indx
		if lcv = 7 or lcv = 8 then continue
		comp[3].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type st_settle1 from statictext within w_privileges
integer x = 2062
integer y = 484
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle0 from statictext within w_privileges
integer x = 2062
integer y = 368
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_settle_privileges from checkbox within w_privileges
event clicked pbm_bnclicked
string tag = "293"
integer x = 2153
integer y = 368
integer width = 795
integer height = 76
integer taborder = 210
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "No Privileges"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)

integer lcv 
for lcv = 1 to comp[3].indx
	comp[3].cbx[lcv].checked = false
next

reset_face()



end event

type st_3 from statictext within w_privileges
integer x = 2272
integer y = 296
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Settlement Component"
boolean focusrectangle = false
end type

type st_user_check from statictext within w_privileges
boolean visible = false
integer x = 23
integer y = 160
integer width = 1006
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_choose_emp from u_choose_emp within w_privileges
integer x = 23
integer y = 48
integer width = 1157
integer taborder = 10
end type

on uo_choose_emp.destroy
call u_choose_emp::destroy
end on

type sle_name from singlelineedit within w_privileges
integer x = 1207
integer y = 1216
integer width = 247
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_cover_log0 from statictext within w_privileges
integer x = 279
integer y = 1104
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log0"
boolean focusrectangle = false
end type

type st_cover_emp0 from statictext within w_privileges
integer x = 69
integer y = 1108
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp0"
boolean focusrectangle = false
end type

type st_cover_log4 from statictext within w_privileges
integer x = 261
integer y = 1280
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log4"
boolean focusrectangle = false
end type

type st_cover_log8 from statictext within w_privileges
integer x = 261
integer y = 1456
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log8"
boolean focusrectangle = false
end type

type st_cover_log7 from statictext within w_privileges
integer x = 261
integer y = 1412
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log7"
boolean focusrectangle = false
end type

type st_cover_log6 from statictext within w_privileges
integer x = 261
integer y = 1368
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log6"
boolean focusrectangle = false
end type

type st_cover_log5 from statictext within w_privileges
integer x = 261
integer y = 1324
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log5"
boolean focusrectangle = false
end type

type st_cover_log3 from statictext within w_privileges
integer x = 261
integer y = 1236
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log3"
boolean focusrectangle = false
end type

type st_cover_log2 from statictext within w_privileges
integer x = 261
integer y = 1192
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log2"
boolean focusrectangle = false
end type

type st_cover_log1 from statictext within w_privileges
integer x = 261
integer y = 1148
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "log1"
boolean focusrectangle = false
end type

type st_cover_emp7 from statictext within w_privileges
integer x = 59
integer y = 1416
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp7"
boolean focusrectangle = false
end type

type st_cover_emp6 from statictext within w_privileges
integer x = 59
integer y = 1372
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp6"
boolean focusrectangle = false
end type

type st_cover_emp5 from statictext within w_privileges
integer x = 59
integer y = 1328
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp5"
boolean focusrectangle = false
end type

type st_cover_emp4 from statictext within w_privileges
integer x = 59
integer y = 1284
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp4"
boolean focusrectangle = false
end type

type st_cover_emp3 from statictext within w_privileges
integer x = 59
integer y = 1240
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp3"
boolean focusrectangle = false
end type

type st_cover_emp2 from statictext within w_privileges
integer x = 59
integer y = 1196
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp2"
boolean focusrectangle = false
end type

type st_log8 from statictext within w_privileges
integer x = 1061
integer y = 988
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log7 from statictext within w_privileges
integer x = 1061
integer y = 916
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log6 from statictext within w_privileges
integer x = 1061
integer y = 844
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log5 from statictext within w_privileges
integer x = 1061
integer y = 772
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log4 from statictext within w_privileges
integer x = 1061
integer y = 700
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log3 from statictext within w_privileges
integer x = 1061
integer y = 628
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log2 from statictext within w_privileges
integer x = 1061
integer y = 556
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log1 from statictext within w_privileges
integer x = 1061
integer y = 484
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_log0 from statictext within w_privileges
integer x = 1061
integer y = 368
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp0 from statictext within w_privileges
integer x = 27
integer y = 368
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp7 from statictext within w_privileges
integer x = 27
integer y = 916
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp6 from statictext within w_privileges
integer x = 27
integer y = 844
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp5 from statictext within w_privileges
integer x = 27
integer y = 772
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp4 from statictext within w_privileges
integer x = 27
integer y = 700
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp3 from statictext within w_privileges
integer x = 27
integer y = 628
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp2 from statictext within w_privileges
integer x = 27
integer y = 556
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_emp1 from statictext within w_privileges
integer x = 27
integer y = 484
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_log_reports1 from checkbox within w_privileges
string tag = "787"
integer x = 1129
integer y = 556
integer width = 905
integer height = 76
integer taborder = 140
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Print/Access Non-Sensitive Reports"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_log_privileges from checkbox within w_privileges
string tag = "293"
integer x = 1129
integer y = 368
integer width = 795
integer height = 76
integer taborder = 120
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "No Privileges"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)

integer lcv 
for lcv = 1 to comp[2].indx
	comp[2].cbx[lcv].checked = false
next

reset_face()



end event

type cbx_emp_privileges from checkbox within w_privileges
string tag = "293"
integer x = 96
integer y = 368
integer width = 795
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "No Privileges"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
integer lcv 
for lcv = 1 to comp[1].indx
	comp[1].cbx[lcv].checked = false
next


reset_face()


end event

type st_2 from statictext within w_privileges
integer x = 1216
integer y = 296
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Log Component"
boolean focusrectangle = false
end type

type st_1 from statictext within w_privileges
integer x = 178
integer y = 296
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Employee Component"
boolean focusrectangle = false
end type

type cbx_emp_grant from checkbox within w_privileges
string tag = "462"
integer x = 96
integer y = 844
integer width = 690
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Grant User Privileges"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)


reset_face()


end event

type cbx_emp_add from checkbox within w_privileges
string tag = "321"
integer x = 96
integer y = 772
integer width = 905
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Add Employee"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

integer lcv
if this.checked = false then 
	for lcv = 6 to comp[1].indx
		comp[1].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type cbx_emp_viewadmin from checkbox within w_privileges
string tag = "522"
integer x = 96
integer y = 628
integer width = 905
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "View Administrative Info"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

if comp[1].cbx[1].checked = false and comp[1].cbx[2].checked = false and &
	comp[1].cbx[3].checked = false then
	integer lcv
	for lcv = 4 to comp[1].indx
		comp[1].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type cbx_emp_viewdriver from checkbox within w_privileges
string tag = "508"
integer x = 96
integer y = 556
integer width = 905
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "View Driver Information"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

if comp[1].cbx[1].checked = false and comp[1].cbx[2].checked = false and &
	comp[1].cbx[3].checked = false then
	integer lcv
	for lcv = 4 to comp[1].indx
		comp[1].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type cbx_log_reports2 from checkbox within w_privileges
string tag = "691"
integer x = 1129
integer y = 988
integer width = 905
integer height = 76
integer taborder = 200
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Print/Access Violation Statistics"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_emp_password from checkbox within w_privileges
string tag = "435"
integer x = 96
integer y = 916
integer width = 905
integer height = 76
integer taborder = 110
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Manage Passwords"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_emp_edit from checkbox within w_privileges
string tag = "554"
integer x = 96
integer y = 700
integer width = 905
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Edit Viewable Information"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

integer lcv
if this.checked = false then 
	for lcv = 5 to comp[1].indx
		comp[1].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type cbx_log_view from checkbox within w_privileges
string tag = "234"
integer x = 1129
integer y = 484
integer width = 905
integer height = 76
integer taborder = 130
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "View Logs"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

integer lcv
if this.checked = false then 
	for lcv = 3 to comp[2].indx
		comp[2].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type cbx_log_mph from checkbox within w_privileges
string tag = "508"
integer x = 1129
integer y = 772
integer width = 905
integer height = 76
integer taborder = 170
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Change Min/Max MPH"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_log_purge from checkbox within w_privileges
string tag = "357"
integer x = 1129
integer y = 916
integer width = 905
integer height = 76
integer taborder = 190
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Delete Old Logs"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_log_lock from checkbox within w_privileges
string tag = "508"
integer x = 1129
integer y = 844
integer width = 905
integer height = 76
integer taborder = 180
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Adjust Locking Feature"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type cbx_log_edit from checkbox within w_privileges
string tag = "782"
integer x = 1129
integer y = 628
integer width = 905
integer height = 76
integer taborder = 150
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 12632256
string text = "Edit Logs/View Violation Summaries"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

integer lcv
if this.checked = false then 
	for lcv = 4 to comp[2].indx
		comp[2].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type cbx_emp_viewphone from checkbox within w_privileges
string tag = "540"
integer x = 96
integer y = 484
integer width = 905
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "View Phone # / Address"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)
if comp[1].cbx[1].checked = false and comp[1].cbx[2].checked = false and &
	comp[1].cbx[3].checked = false then
	integer lcv
	for lcv = 4 to comp[1].indx
		comp[1].cbx[lcv].checked = false
	next
end if

reset_face()


end event

type ddlb_names from dropdownlistbox within w_privileges
integer x = 1216
integer y = 48
integer width = 645
integer height = 588
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;display_class(this.text)
reset_face()
post set_user_check()


end event

type st_modified from statictext within w_privileges
boolean visible = false
integer x = 1216
integer y = 152
integer width = 585
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "(With Modifications)"
boolean focusrectangle = false
end type

type st_cover_emp1 from statictext within w_privileges
integer x = 59
integer y = 1152
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "emp1"
boolean focusrectangle = false
end type

type cbx_log_excuse from checkbox within w_privileges
string tag = "549"
integer x = 1129
integer y = 700
integer width = 905
integer height = 76
integer taborder = 160
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
string text = "Excuse/Delete Violations"
boolean automatic = false
end type

event clicked;if mod_class(this) = -1 then return else this.checked = not(this.checked)
cbx_clicked(this)

reset_face()


end event

type gb_2 from groupbox within w_privileges
integer x = 18
integer y = 1364
integer width = 3141
integer height = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_settle2 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1404
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle3 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1476
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle4 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1548
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle5 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1620
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle6 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1692
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle7 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1764
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle8 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1836
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_settle9 from statictext within w_privileges
boolean visible = false
integer x = 2112
integer y = 1908
integer width = 64
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "ü"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_mask from statictext within w_privileges
integer x = 910
integer y = 1404
integer width = 1134
integer height = 640
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cbx_customerhold from checkbox within w_privileges
integer x = 2153
integer y = 704
integer width = 846
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Remove/Place Customer on hold"
end type

type gb_3 from groupbox within w_privileges
integer y = 252
integer width = 1029
integer height = 848
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_7 from groupbox within w_privileges
integer x = 1019
integer y = 252
integer width = 1029
integer height = 848
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_4 from groupbox within w_privileges
integer x = 2039
integer y = 252
integer width = 1029
integer height = 324
integer taborder = 220
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_8 from groupbox within w_privileges
integer x = 2039
integer y = 544
integer width = 1029
integer height = 556
integer taborder = 150
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

