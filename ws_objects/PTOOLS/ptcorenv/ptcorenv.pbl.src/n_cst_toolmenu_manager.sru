$PBExportHeader$n_cst_toolmenu_manager.sru
forward
global type n_cst_toolmenu_manager from nonvisualobject
end type
end forward

global type n_cst_toolmenu_manager from nonvisualobject
end type
global n_cst_toolmenu_manager n_cst_toolmenu_manager

type variables
protected:
window iw_parent
groupbox igb_toolbutton_border
menu im_target
m_generator ima_generator[]
s_toolmenu istra_toolmenu[]
end variables

forward prototypes
public function integer of_add_toolmenu (s_toolmenu astr_toolmenu)
public function integer of_set_parent (window aw_parent)
public subroutine of_process_key (u_cst_toolbutton auo_toolbutton)
public function integer of_set_focus (string as_target, string as_relative)
public function integer of_set_focus (string as_target)
public function integer of_set_focus (string as_target, u_cst_toolbutton auo_toolbutton)
public function integer of_find_toolbutton (u_cst_toolbutton auo_toolbutton, ref integer ai_ndx)
public function integer of_find_item (string as_item, ref integer ai_ndx)
public subroutine of_process_click (u_cst_toolbutton auo_toolbutton)
public function integer of_set_target_menu (menu am_target)
public function integer of_add_standard (string as_type)
public function integer of_mask_toolbuttons (boolean ab_mask)
public subroutine of_make_default (ref s_toolmenu astr_toolmenu, boolean ab_toolbutton, boolean ab_menuitem)
public subroutine of_make_blank (ref s_toolmenu astr_toolmenu)
public function integer of_find_menuitem (menu am_menuitem, ref integer ai_ndx)
public subroutine of_process_click (menu am_menuitem)
public function integer of_get_next_position (ref long al_next_x, ref long al_next_y)
public subroutine of_setgroupboxtaborder (integer ai_value)
end prototypes

public function integer of_add_toolmenu (s_toolmenu astr_toolmenu);Environment	lstr_Environment
Boolean	lb_IsPre60
GetEnvironment ( lstr_Environment )
IF lstr_Environment.PBMajorRevision < 6 THEN
	lb_IsPre60 = TRUE
END IF


long ll_next_x, ll_next_y
m_generator lm_generator

if astr_toolmenu.s_name = trim(astr_toolmenu.s_name) and len(astr_toolmenu.s_name) > 0 then
	//This checks that there is an ! at the end of s_name, and nowhere else besides that.
	//An ! to start the string is reserved for internal purposes.
	if pos(astr_toolmenu.s_name, "!") <> len(astr_toolmenu.s_name) then return -1
else
	return -1
end if

if astr_toolmenu.b_toolbutton = true and not isvalid(iw_parent) then return -1
//if astr_toolmenu.b_menuitem = true and not isvalid(im_target) then return -1
//You need the parent window in order to create the buttons, but you don't need to 
//know the target menu in order to create the menu items.  The target menu can be 
//set later with of_set_target_menu.

if astr_toolmenu.b_toolbutton = true then
	if of_get_next_position(ll_next_x, ll_next_y) = -1 then return -1
	if iw_parent.openuserobject(astr_toolmenu.uo_toolbutton, "u_cst_toolbutton", &
		ll_next_x, ll_next_y) = 1 then
			astr_toolmenu.uo_toolbutton.bringtotop = true
			astr_toolmenu.uo_toolbutton.of_set_manager(this)
			astr_toolmenu.uo_toolbutton.of_set_picture(astr_toolmenu.s_toolbutton_picture)
			astr_toolmenu.uo_toolbutton.of_set_text(astr_toolmenu.s_toolbutton_text)

			if not isvalid(igb_toolbutton_border) then
				if iw_parent.openuserobject(igb_toolbutton_border, 1, 1) = 1 then
					igb_toolbutton_border.y = -60
					igb_toolbutton_border.x = astr_toolmenu.uo_toolbutton.x +&
						astr_toolmenu.uo_toolbutton.width - 4
					IF lb_IsPre60 THEN
						igb_toolbutton_border.width = 12
					ELSE
						igb_ToolButton_Border.Width = 8
					END IF
					igb_toolbutton_border.height = 3000
					igb_toolbutton_border.backcolor = 12632256
					igb_toolbutton_border.bringtotop = false
				end if
			end if

	end if
end if

if astr_toolmenu.b_menuitem = true then
	if astr_toolmenu.s_name = "SAVE!" then
		lm_generator = create m_generator_ctrl_s
		astr_toolmenu.m_menuitem = lm_generator.item[1].item[1]
	else
		lm_generator = create m_generator
		astr_toolmenu.m_menuitem = lm_generator.item[1]
	end if
	ima_generator[upperbound(ima_generator) + 1] = lm_generator
	lm_generator.mf_set_manager(this)
	astr_toolmenu.m_menuitem.text = astr_toolmenu.s_menuitem_text
	if isvalid(im_target) then
		im_target.item[upperbound(im_target.item) + 1] = &
			astr_toolmenu.m_menuitem
		im_target.hide()
		im_target.show()
	end if
end if

istra_toolmenu[upperbound(istra_toolmenu) + 1] = astr_toolmenu

return 1
end function

public function integer of_set_parent (window aw_parent);iw_parent = aw_parent
return 1
end function

public subroutine of_process_key (u_cst_toolbutton auo_toolbutton);if isvalid(auo_toolbutton) then
	if keydown(keyuparrow!) or keydown(keyleftarrow!) then
		of_set_focus("!PREVIOUS", auo_toolbutton)
	elseif keydown(keydownarrow!) or keydown(keyrightarrow!) then
		of_set_focus("!NEXT", auo_toolbutton)
	elseif keydown(keypageup!) or keydown(keyhome!) then
		of_set_focus("!FIRST")
	elseif keydown(keypagedown!) or keydown(keyend!) then
		of_set_focus("!LAST")
	end if
end if
end subroutine

public function integer of_set_focus (string as_target, string as_relative);integer li_ndx, li_start, li_finish
boolean ib_passed

u_cst_toolbutton luo_target

choose case as_target
case "!PREVIOUS", "!LAST"
	li_start = upperbound(istra_toolmenu)
	li_finish = lowerbound(istra_toolmenu)
	for li_ndx = li_start to li_finish step -1
		if istra_toolmenu[li_ndx].b_toolbutton and &
			isvalid(istra_toolmenu[li_ndx].uo_toolbutton) and &
			istra_toolmenu[li_ndx].b_toolbutton_visible and &
			istra_toolmenu[li_ndx].b_enabled then
				if ib_passed then
					luo_target = istra_toolmenu[li_ndx].uo_toolbutton
					exit
				elseif not isvalid(luo_target) then
					luo_target = istra_toolmenu[li_ndx].uo_toolbutton
					if as_target = "!LAST" then exit
				end if
				if as_target = "!PREVIOUS" and istra_toolmenu[li_ndx].s_name = as_relative &
					then ib_passed = true
		end if
	next
case "!NEXT", "!FIRST"
	li_start = lowerbound(istra_toolmenu)
	li_finish = upperbound(istra_toolmenu)
	for li_ndx = li_start to li_finish step 1
		if istra_toolmenu[li_ndx].b_toolbutton and &
			isvalid(istra_toolmenu[li_ndx].uo_toolbutton) and &
			istra_toolmenu[li_ndx].b_toolbutton_visible and &
			istra_toolmenu[li_ndx].b_enabled then
				if ib_passed then
					luo_target = istra_toolmenu[li_ndx].uo_toolbutton
					exit
				elseif not isvalid(luo_target) then
					luo_target = istra_toolmenu[li_ndx].uo_toolbutton
					if as_target = "!FIRST" then exit
				end if
				if as_target = "!NEXT" and istra_toolmenu[li_ndx].s_name = as_relative &
					then ib_passed = true
		end if
	next
case else
	if of_find_item(as_target, li_ndx) = 1 then
		if istra_toolmenu[li_ndx].b_toolbutton and &
			isvalid(istra_toolmenu[li_ndx].uo_toolbutton) and &
			istra_toolmenu[li_ndx].b_toolbutton_visible and &
			istra_toolmenu[li_ndx].b_enabled then &
				luo_target = istra_toolmenu[li_ndx].uo_toolbutton
	end if
end choose

if isvalid(luo_target) then
	luo_target.of_set_focus()
	return 1
else
	return -1
end if
end function

public function integer of_set_focus (string as_target);return of_set_focus(as_target, "")
end function

public function integer of_set_focus (string as_target, u_cst_toolbutton auo_toolbutton);integer li_ndx

choose case as_target
case "!NEXT", "!PREVIOUS"
	if of_find_toolbutton(auo_toolbutton, li_ndx) = 1 then
		return of_set_focus(as_target, istra_toolmenu[li_ndx].s_name)
	end if
end choose

return -1
end function

public function integer of_find_toolbutton (u_cst_toolbutton auo_toolbutton, ref integer ai_ndx);integer li_ndx

ai_ndx = 0

for li_ndx = 1 to upperbound(istra_toolmenu)
	if istra_toolmenu[li_ndx].uo_toolbutton = auo_toolbutton then
		ai_ndx = li_ndx
		exit
	end if
next

if ai_ndx > 0 then
	return 1
else
	return 0
end if
end function

public function integer of_find_item (string as_item, ref integer ai_ndx);integer li_ndx

ai_ndx = 0

if len(trim(as_item)) > 0 then
	for li_ndx = 1 to upperbound(istra_toolmenu)
		if istra_toolmenu[li_ndx].s_name = as_item then
			ai_ndx = li_ndx
			exit
		end if
	next
end if

if ai_ndx > 0 then
	return 1
else
	return 0
end if
end function

public subroutine of_process_click (u_cst_toolbutton auo_toolbutton);integer li_ndx

if of_find_toolbutton(auo_toolbutton, li_ndx) = 1 and isvalid(iw_parent) then
	iw_parent.trigger dynamic wf_process_request(istra_toolmenu[li_ndx].s_name)
end if
end subroutine

public function integer of_set_target_menu (menu am_target);integer li_ndx
boolean lb_menu_changes

if not isvalid(am_target) then return -1

//The following is to ensure that the item array doesn't get doubled up for a menu that 
//has already been targeted by a previous call.
if im_target = am_target then return 1

im_target = am_target

for li_ndx = 1 to upperbound(istra_toolmenu)
	if istra_toolmenu[li_ndx].b_menuitem and isvalid(istra_toolmenu[li_ndx].m_menuitem) then
		lb_menu_changes = true
		im_target.item[upperbound(im_target.item) + 1] = &
			istra_toolmenu[li_ndx].m_menuitem
	end if
next

if lb_menu_changes then
	im_target.hide()
	im_target.show()
end if

return 1
end function

public function integer of_add_standard (string as_type);s_toolmenu lstr_toolmenu
s_toolmenu lstr_emptytoolmenu

choose case as_type
case "DIVIDER!"
	lstr_toolmenu.s_name = "DIVIDER!"
	lstr_toolmenu.b_enabled = true
	lstr_toolmenu.b_menuitem = true
	lstr_toolmenu.s_menuitem_text = "-"
	lstr_toolmenu.b_menuitem_visible = true
case "SAVE!"
	lstr_toolmenu.s_name = "SAVE!"
	lstr_toolmenu.b_enabled = true
	lstr_toolmenu.b_toolbutton = true
	lstr_toolmenu.s_toolbutton_picture = "save.bmp"
	lstr_toolmenu.s_toolbutton_text = "SAVE"
	lstr_toolmenu.b_toolbutton_visible = true
	lstr_toolmenu.b_menuitem = true
	lstr_toolmenu.s_menuitem_text = "&Save~tCtrl+S"
	lstr_toolmenu.b_menuitem_visible = true
// executes When Combine Save and Close on Shipment property = "YES"
case "SAVECLOSE!"
	lstr_toolmenu.s_name = "SAVECLOSE!"
	lstr_toolmenu.b_enabled = true
	lstr_toolmenu.b_toolbutton = true
	lstr_toolmenu.s_toolbutton_picture = "save.bmp"
	lstr_toolmenu.s_toolbutton_text = "SAVE&&CLOSE"
	lstr_toolmenu.b_toolbutton_visible = true
	lstr_toolmenu.b_menuitem = false
	
	IF of_add_toolmenu(lstr_toolmenu) = 1 THEN
		lstr_toolmenu = lstr_emptytoolmenu
	END IF		
	lstr_toolmenu.s_name = "SAVE!"
	lstr_toolmenu.b_enabled = true
	lstr_toolmenu.b_toolbutton = false
	lstr_toolmenu.b_menuitem = true
	lstr_toolmenu.s_menuitem_text = "&Save~tCtrl+S"
	lstr_toolmenu.b_menuitem_visible = true

case else
	return -1
end choose

return of_add_toolmenu(lstr_toolmenu)
end function

public function integer of_mask_toolbuttons (boolean ab_mask);integer li_ndx

for li_ndx = 1 to upperbound(istra_toolmenu)
	if isvalid(istra_toolmenu[li_ndx].uo_toolbutton) then
		istra_toolmenu[li_ndx].uo_toolbutton.of_set_mask(ab_mask)
	end if
next

return 1
end function

public subroutine of_make_default (ref s_toolmenu astr_toolmenu, boolean ab_toolbutton, boolean ab_menuitem);s_toolmenu lstr_toolmenu

lstr_toolmenu.b_enabled = true

if ab_toolbutton then
	lstr_toolmenu.b_toolbutton = true
	lstr_toolmenu.b_toolbutton_visible = true
end if

if ab_menuitem then
	lstr_toolmenu.b_menuitem = true
	lstr_toolmenu.b_menuitem_visible = true
end if

astr_toolmenu = lstr_toolmenu
end subroutine

public subroutine of_make_blank (ref s_toolmenu astr_toolmenu);s_toolmenu lstr_toolmenu

astr_toolmenu = lstr_toolmenu
end subroutine

public function integer of_find_menuitem (menu am_menuitem, ref integer ai_ndx);integer li_ndx

ai_ndx = 0

for li_ndx = 1 to upperbound(istra_toolmenu)
	if istra_toolmenu[li_ndx].m_menuitem = am_menuitem then
		ai_ndx = li_ndx
		exit
	end if
next

if ai_ndx > 0 then
	return 1
else
	return 0
end if
end function

public subroutine of_process_click (menu am_menuitem);integer li_ndx

if of_find_menuitem(am_menuitem, li_ndx) = 1 and isvalid(iw_parent) then
	iw_parent.trigger dynamic wf_process_request(istra_toolmenu[li_ndx].s_name)
end if
end subroutine

public function integer of_get_next_position (ref long al_next_x, ref long al_next_y);Environment	lstr_Environment
Boolean	lb_IsPre60
GetEnvironment ( lstr_Environment )
IF lstr_Environment.PBMajorRevision < 6 THEN
	lb_IsPre60 = TRUE
END IF


integer li_ndx
long ll_work_x, ll_work_y

ll_work_x = 0

for li_ndx = 1 to upperbound(istra_toolmenu)
	if istra_toolmenu[li_ndx].b_toolbutton and istra_toolmenu[li_ndx].b_toolbutton_visible then
		if isvalid(istra_toolmenu[li_ndx].uo_toolbutton) then //should be
			IF lb_IsPre60 THEN
				ll_work_y = max(ll_work_y, istra_toolmenu[li_ndx].uo_toolbutton.y + &
					istra_toolmenu[li_ndx].uo_toolbutton.height - 1)
				//Without the -1 adjustment, every fourth button skips ahead notch
			ELSE
				ll_work_y = max(ll_work_y, istra_toolmenu[li_ndx].uo_toolbutton.y + &
					istra_toolmenu[li_ndx].uo_toolbutton.height)
				//This is the part we keep, post 6.5 conversion
			END IF
		end if
	end if
next

if ll_work_x >= 0 and ll_work_y >= 0 then
	al_next_x = ll_work_x
	al_next_y = ll_work_y
	return 1
else
	setnull(al_next_x)
	setnull(al_next_y)
	return -1
end if
end function

public subroutine of_setgroupboxtaborder (integer ai_value);//nwl 08/09/2004
//created this method to turn off the taborder
//when tabbing through a window with a toolbar this is 
//an unnecessary tab
igb_toolbutton_border.taborder=ai_value
end subroutine

on n_cst_toolmenu_manager.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_toolmenu_manager.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;integer li_ndx

for li_ndx = upperbound(istra_toolmenu) to 1 step -1
	if isvalid(istra_toolmenu[li_ndx].uo_toolbutton) then
		iw_parent.closeuserobject(istra_toolmenu[li_ndx].uo_toolbutton)
	end if
//	if isvalid(istra_toolmenu[li_ndx].m_menuitem) then
//		destroy istra_toolmenu[li_ndx].m_menuitem
//	end if
next

if isvalid(igb_toolbutton_border) then
	iw_parent.closeuserobject(igb_toolbutton_border)
end if

for li_ndx = upperbound(ima_generator) to 1 step -1
	destroy ima_generator[li_ndx]
next


end event

