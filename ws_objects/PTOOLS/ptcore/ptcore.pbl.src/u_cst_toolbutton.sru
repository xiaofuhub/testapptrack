$PBExportHeader$u_cst_toolbutton.sru
forward
global type u_cst_toolbutton from UserObject
end type
type p_1 from picture within u_cst_toolbutton
end type
type pb_1 from picturebutton within u_cst_toolbutton
end type
end forward

global type u_cst_toolbutton from UserObject
int Width=284
int Height=149
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
p_1 p_1
pb_1 pb_1
end type
global u_cst_toolbutton u_cst_toolbutton

type variables
protected:
integer ii_px
integer ii_py
boolean ib_buttondown, ib_spacedown
n_cst_toolmenu_manager inv_cst_toolmenu_manager
end variables

forward prototypes
protected subroutine of_push_response ()
public function integer of_set_manager (n_cst_toolmenu_manager anv_cst_toolmenu_manager)
public function integer of_set_picture (string as_picture)
public function integer of_set_text (string as_text)
public function integer of_set_focus ()
public subroutine of_set_mask (boolean ab_mask)
end prototypes

protected subroutine of_push_response ();if ib_buttondown or ib_spacedown then
	if p_1.x = ii_px then p_1.x = ii_px + 4
	if p_1.y = ii_py then p_1.y = ii_py + 4
else
	if p_1.x <> ii_px then p_1.x = ii_px
	if p_1.y <> ii_py then p_1.y = ii_py
end if
end subroutine

public function integer of_set_manager (n_cst_toolmenu_manager anv_cst_toolmenu_manager);inv_cst_toolmenu_manager = anv_cst_toolmenu_manager
return 1
end function

public function integer of_set_picture (string as_picture);p_1.picturename = as_picture
return 1
end function

public function integer of_set_text (string as_text);pb_1.text = as_text
return 1
end function

public function integer of_set_focus ();pb_1.setfocus()
return 1
end function

public subroutine of_set_mask (boolean ab_mask);pb_1.visible = not ab_mask
p_1.visible = not ab_mask
end subroutine

on u_cst_toolbutton.create
this.p_1=create p_1
this.pb_1=create pb_1
this.Control[]={ this.p_1,&
this.pb_1}
end on

on u_cst_toolbutton.destroy
destroy(this.p_1)
destroy(this.pb_1)
end on

event constructor;ii_px = p_1.x
ii_py = p_1.y
end event

type p_1 from picture within u_cst_toolbutton
int X=106
int Y=17
int Width=74
int Height=65
boolean Enabled=false
boolean FocusRectangle=false
end type

type pb_1 from picturebutton within u_cst_toolbutton
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
event keydown pbm_keydown
event keyup pbm_keyup
int Width=284
int Height=149
int TabOrder=1
int TextSize=-6
int Weight=400
string FaceName="Small Fonts"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;ib_buttondown = true
of_push_response()
end event

event lbuttonup;ib_buttondown = false
of_push_response()
end event

event keydown;if keydown(keyspacebar!) then
	ib_spacedown = true
	of_push_response()
elseif isvalid(inv_cst_toolmenu_manager) and not (ib_spacedown or ib_buttondown) then
	inv_cst_toolmenu_manager.of_process_key(parent)
end if
end event

event keyup;if not keydown(keyspacebar!) then
	ib_spacedown = false
	of_push_response()
end if
end event

event losefocus;this.setredraw(true)
end event

event clicked;if isvalid(inv_cst_toolmenu_manager) then
	inv_cst_toolmenu_manager.of_process_click(parent)
end if
end event

