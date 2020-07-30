$PBExportHeader$u_choose_generic.sru
forward
global type u_choose_generic from UserObject
end type
type hsb_1 from hscrollbar within u_choose_generic
end type
type st_tag1 from statictext within u_choose_generic
end type
type sle_name from singlelineedit within u_choose_generic
end type
end forward

global type u_choose_generic from UserObject
int Width=1371
int Height=88
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
hsb_1 hsb_1
st_tag1 st_tag1
sle_name sle_name
end type
global u_choose_generic u_choose_generic

type variables
public:
window w_mainpar
datastore ds_hotkey
s_emp_info cur_item, temp_item
integer uo_num = 1
string new_tag

end variables

forward prototypes
public subroutine call_funct ()
public function integer find_text (string search_str)
public subroutine set_item (boolean swap_parm)
end prototypes

public subroutine call_funct ();w_mainpar.function dynamic post item_switch(uo_num)

end subroutine

public function integer find_text (string search_str);integer lcv

for lcv = 1 to ds_hotkey.rowcount()
	if ds_hotkey.getitemstring(lcv, "name") = trim(search_str) then
		temp_item.em_id = ds_hotkey.getitemnumber(lcv, "id")
		temp_item.em_ln = ds_hotkey.getitemstring(lcv, "name")
		sle_name.text = temp_item.em_ln
		return 1
	end if
next

//sle_name.selecttext(1, len(sle_name.text)) (the messagebox takes the selection away)
beep(1)
messagebox("Finding Item", "Could not find a name that matched the entered text.")

return 0

end function

public subroutine set_item (boolean swap_parm);if swap_parm = true then 
	cur_item = temp_item
end if

if isnull(cur_item.em_id) then 
	sle_name.text = ""
else
	sle_name.text = cur_item.em_ln
end if

end subroutine

on u_choose_generic.create
this.hsb_1=create hsb_1
this.st_tag1=create st_tag1
this.sle_name=create sle_name
this.Control[]={this.hsb_1,&
this.st_tag1,&
this.sle_name}
end on

on u_choose_generic.destroy
destroy(this.hsb_1)
destroy(this.st_tag1)
destroy(this.sle_name)
end on

event constructor;ds_hotkey = create datastore
ds_hotkey.dataobject = "d_generic_list"


end event

event destructor;destroy ds_hotkey
end event

type hsb_1 from hscrollbar within u_choose_generic
int X=1202
int Width=119
int Height=76
boolean Enabled=false
boolean StdHeight=false
end type

event lineleft;integer hotrow, lcv
n_cst_numerical lnv_numerical

if ds_hotkey.rowcount() = 0 then 
	return
elseif ds_hotkey.rowcount() = 1 then 
	hotrow = 1
	goto set_spot
elseif lnv_numerical.of_IsNullOrNotPos(cur_item.em_id) then
	hotrow = ds_hotkey.rowcount()
	goto set_spot
else
	//	hotrow = ds_hotkey.find("name = '" + trim(upper(cur_item.em_ln)) + "'", 1, ds_hotkey.rowcount())
	// can't use find because of inner quotes
	for lcv = 1 to ds_hotkey.rowcount()
		if cur_item.em_ln = ds_hotkey.getitemstring(lcv, "name") then 
			hotrow = lcv
			exit
		end if
	next
	if lnv_numerical.of_IsNullOrNotPos(hotrow) then  //drivers not on list, not active
		messagebox("PW", "couldn't find current item of em_ln:  " + cur_item.em_ln)
		return
	end if
end if

hotrow -= 1
if hotrow < 1 then hotrow = ds_hotkey.rowcount()

set_spot:
temp_item.em_id = ds_hotkey.getitemnumber(hotrow, "id")
temp_item.em_ln = ds_hotkey.getitemstring(hotrow, "name")
call_funct()


end event

event lineright;integer hotrow, lcv
n_cst_numerical lnv_numerical

if ds_hotkey.rowcount() = 0 then 
	return
elseif ds_hotkey.rowcount() = 1 then 
	hotrow = 1
	goto set_spot
elseif lnv_numerical.of_IsNullOrNotPos(cur_item.em_id) then
	hotrow = 1
	goto set_spot
else
	//	hotrow = ds_hotkey.find("name = '" + trim(upper(cur_item.em_ln)) + "'", 1, ds_hotkey.rowcount())
	// can't use find because of inner quotes
	for lcv = 1 to ds_hotkey.rowcount()
		if cur_item.em_ln = ds_hotkey.getitemstring(lcv, "name") then 
			hotrow = lcv
			exit
		end if
	next
	if lnv_numerical.of_IsNullOrNotPos(hotrow) then  //drivers not on list, not active
		messagebox("PW", "couldn't find current item of em_ln:  " + cur_item.em_ln)
		return
	end if
end if

hotrow += 1
if hotrow > ds_hotkey.rowcount() then hotrow = 1

set_spot:
temp_item.em_id = ds_hotkey.getitemnumber(hotrow, "id")
temp_item.em_ln = ds_hotkey.getitemstring(hotrow, "name")
call_funct()

end event

type st_tag1 from statictext within u_choose_generic
int Width=425
int Height=76
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="List:"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;temp_item.em_ln = ""
temp_item.em_id = null_long

openwithparm(w_generic_list, ds_hotkey)
temp_item = message.powerobjectparm

if isnull(temp_item.em_id) then
	if not isnull(cur_item.em_id) then sle_name.text = cur_item.em_ln
else
	call_funct()
end if


	

end event

type sle_name from singlelineedit within u_choose_generic
event lbuttondown pbm_lbuttondown
int X=430
int Width=763
int Height=76
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;if getfocus() <> this then this.postevent(getfocus!)
end event

event modified;this.text = trim(this.text)

if len(text) = 0 then 
	if not isnull(cur_item.em_id) then this.text = cur_item.em_ln
	return
end if

if find_text(text) = 0 then
	if not isnull(cur_item.em_id) then this.text = cur_item.em_ln
	if classname(w_mainpar) = "w_reoccur_adjs" then
		if isnull(cur_item.em_id) and cur_item.em_ln = "NEW ADJUSTMENT" then this.text = cur_item.em_ln
	elseif classname(w_mainpar) = "w_new_payscales" then
		if isnull(cur_item.em_id) and cur_item.em_ln = "NEW PAYSCALE" then this.text = cur_item.em_ln
	elseif classname(w_mainpar) = "w_new_milescale" then
		if isnull(cur_item.em_id) and cur_item.em_ln = "NEW MILEAGE CHART" then this.text = cur_item.em_ln
	end if
else
	call_funct()
end if


end event

event getfocus;this.selecttext(1, len(this.text))
end event

