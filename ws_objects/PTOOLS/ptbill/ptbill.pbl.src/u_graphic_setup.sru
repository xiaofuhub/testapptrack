$PBExportHeader$u_graphic_setup.sru
forward
global type u_graphic_setup from UserObject
end type
type pb_getfile from picturebutton within u_graphic_setup
end type
type st_invalid_file from statictext within u_graphic_setup
end type
type p_check_size from picture within u_graphic_setup
end type
type dw_list from datawindow within u_graphic_setup
end type
type st_3 from statictext within u_graphic_setup
end type
type sle_file from singlelineedit within u_graphic_setup
end type
type sle_name from singlelineedit within u_graphic_setup
end type
type st_2 from statictext within u_graphic_setup
end type
type st_1 from statictext within u_graphic_setup
end type
type dw_layout from datawindow within u_graphic_setup
end type
end forward

global type u_graphic_setup from UserObject
int Width=2592
int Height=1232
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
pb_getfile pb_getfile
st_invalid_file st_invalid_file
p_check_size p_check_size
dw_list dw_list
st_3 st_3
sle_file sle_file
sle_name sle_name
st_2 st_2
st_1 st_1
dw_layout dw_layout
end type
global u_graphic_setup u_graphic_setup

type variables
protected:
long il_target_width
long il_target_height
long il_target_x
long il_target_y
long il_current_id
window iw_parent
end variables

forward prototypes
public function long of_retrieve_list ()
public function integer of_change_selection (long al_selected_id)
public function integer of_reset_graphic ()
public function integer of_compute_xy (long al_width, long al_height, ref long al_x, ref long al_y, boolean ab_allow_negative)
public function integer of_get_original_size (string as_filename, ref long al_original_width, ref long al_original_height)
public function string of_get_dbstring (string as_target_name)
public function integer of_save_if_needed (string as_context)
public function integer of_set_parent (window aw_new_parent)
public subroutine of_new ()
public subroutine of_enable_edit (boolean ab_enabled)
public function integer of_create_picture (datawindow adw_target, string as_picture_name, string as_band, long al_refx, long al_refy, string as_dbstring)
end prototypes

public function long of_retrieve_list ();long ll_result

ll_result = dw_list.retrieve()

if ll_result = -1 then
	rollback ;
else
	commit ;
end if

return ll_result
end function

public function integer of_change_selection (long al_selected_id);string ls_dbstring
long ll_foundrow

ll_foundrow = dw_list.find("gd_id = " + string(al_selected_id), 1, dw_list.rowcount())

if ll_foundrow > 0 then
	this.setfocus()
	dw_list.selectrow(0, false)
	dw_list.selectrow(ll_foundrow, true)
	of_enable_edit(true)
	sle_name.text = dw_list.object.gd_name[ll_foundrow]
	ls_dbstring = dw_list.object.gd_dbstring[ll_foundrow]
	of_create_picture(dw_layout, "p_logo", "background", il_target_x, il_target_y, &
		ls_dbstring)
	il_current_id = al_selected_id
else
	messagebox("Change Selection", "Could not process selection request.  "+&
		"Request cancelled.", exclamation!)
	return -1
end if

return 1
end function

public function integer of_reset_graphic ();string ls_filename, ls_command
long ll_original_width, ll_original_height, ll_x, ll_y

ls_filename = trim(sle_file.text)
st_invalid_file.visible = false

if len(ls_filename) > 0 then
	if of_get_original_size(ls_filename, ll_original_width, ll_original_height) = 1 then
		dw_layout.modify("destroy p_logo")
		of_compute_xy(ll_original_width, ll_original_height, ll_x, ll_y, false)
		ls_command = 'create bitmap(band=background filename="' + ls_filename + '" x="' + string(ll_x) + '" y="' + string(ll_y) + '" height="' + string(ll_original_height) + '" width="' + string(ll_original_width) + '" border="3"  name=p_logo  resizeable=1  moveable=1 )'
		dw_layout.modify(ls_command)
	else
		st_invalid_file.visible = true
	end if
else
	dw_layout.modify("destroy p_logo")
end if

return 1
end function

public function integer of_compute_xy (long al_width, long al_height, ref long al_x, ref long al_y, boolean ab_allow_negative);al_x = int((dw_layout.width - al_width) / 2)
al_y = int((dw_layout.height - al_height) / 2)

if not ab_allow_negative then
	al_x = max(al_x, 0)
	al_y = max(al_y, 0)
end if

return 1
end function

public function integer of_get_original_size (string as_filename, ref long al_original_width, ref long al_original_height);as_filename = trim(as_filename)

al_original_width = 0
al_original_height = 0

if len(as_filename) > 0 then
	p_check_size.width = 1
	p_check_size.height = 1
	p_check_size.picturename = as_filename
	if p_check_size.width > 1 and p_check_size.height > 1 then
		al_original_width = p_check_size.width
		al_original_height = p_check_size.height
	else
		return -1
	end if
	p_check_size.picturename = ""
else
	return -1
end if

return 1
end function

public function string of_get_dbstring (string as_target_name);long ll_x, ll_y, ll_width, ll_height
string ls_object_type, ls_logoname, ls_filename, ls_dbstring

ls_object_type = upper(dw_layout.describe(as_target_name + ".type"))
choose case ls_object_type
case "BITMAP"
case else
	return null_str
end choose

ls_logoname = trim(sle_name.text)

ll_x = long(dw_layout.describe(as_target_name + ".x"))
ll_y = long(dw_layout.describe(as_target_name + ".y"))
ll_width = long(dw_layout.describe(as_target_name + ".width"))
ll_height = long(dw_layout.describe(as_target_name + ".height"))
ls_filename = upper(dw_layout.describe(as_target_name + ".filename"))

ll_x -= il_target_x
ll_y -= il_target_y

ls_dbstring = ""
ls_dbstring += "NAME~t" + ls_logoname + "~n"
ls_dbstring += "X~t" + string(ll_x) + "~n"
ls_dbstring += "Y~t" + string(ll_y) + "~n"
ls_dbstring += "WIDTH~t" + string(ll_width) + "~n"
ls_dbstring += "HEIGHT~t" + string(ll_height) + "~n"
ls_dbstring += "FILENAME~t" + ls_filename

return ls_dbstring
end function

public function integer of_save_if_needed (string as_context);//Return Values: 	-1 : Do not proceed,  1 : Proceed
//
//Note:  This doesn't indicate success or failure.  It indicates whether the user would
//object to the calling script disposing of the current edit info.  If the save goes
//through, or if there were no changes, the value is always 1, but if the save fails, 
//the value can be -1 or 1, depending on whether the user has approved abandoning the 
//changes.  A conflict that prevents the save attempt will always return -1.

string ls_reject, ls_old_dbstring, ls_new_dbstring, ls_message_header, ls_message
long ll_row, ll_new_id, ll_checkloop

if as_context = "CLOSE_WINDOW!" and isvalid(iw_parent) then
	iw_parent.setfocus()
	iw_parent.show()
else
	this.setfocus() //forces processing of changes in the sle's
end if

if il_current_id > 0 then
	ll_row = dw_list.find("gd_id = " + string(il_current_id), 1, dw_list.rowcount())
	if ll_row > 0 then
		ls_old_dbstring = dw_list.object.gd_dbstring.original[ll_row]
		ls_new_dbstring = of_get_dbstring("p_logo")
		if ls_old_dbstring = ls_new_dbstring then return 1
	else //Shouldn't happen
		return 1
	end if
elseif isnull(il_current_id) then  //New logo
	if (len(trim(sle_name.text)) > 0 and trim(sle_name.text) <> "[NEW LOGO]") &
		or len(trim(sle_file.text)) > 0 then
			ls_new_dbstring = of_get_dbstring("p_logo")
	elseif as_context <> "SAVE_REQUEST!" then
			dw_list.filter()
			dw_list.rowsdiscard(1, dw_list.filteredcount(), filter!)
			sle_name.text = ""
			sle_file.text = ""
			return 1
	end if
else //There is no current logo
	return 1
end if

ls_message = "Save changes to current logo?"

choose case as_context
case "SAVE_REQUEST!"
	//No processing needed
case "CLOSE_WINDOW!"
	if isvalid(iw_parent) then ls_message_header = iw_parent.title &
		else ls_message_header = "Close Window"
	ls_message = "Save changes before closing?"
case "CHANGE_SELECTION!"
	ls_message_header = "Change Selection"
	//ls_message is ok as is
case "NEW!"
	ls_message_header = "Create New Logo"
	//ls_message is ok as is
end choose

choose case as_context
case "SAVE_REQUEST!"
	//No processing needed
case "CLOSE_WINDOW!", "CHANGE_SELECTION!", "NEW!"
	choose case messagebox(ls_message_header, ls_message, question!, yesnocancel!)
	case 2
		if isnull(il_current_id) then
			dw_list.filter()
			dw_list.rowsdiscard(1, dw_list.filteredcount(), filter!)
		end if
		return 1
	case 3
		return -1
	end choose
end choose

if len(trim(sle_name.text)) > 0 and trim(sle_name.text) <> "[NEW LOGO]" then
else
	ls_reject += "logo name"
end if

if len(trim(sle_file.text)) > 0 and st_invalid_file.visible = false and len(ls_new_dbstring) > 0 then
else
	if len(ls_reject) > 0 then ls_reject += " and "
	ls_reject += "graphics file"
end if

if len(ls_reject) > 0 then
	messagebox("Save Changes", "You must specify a valid " + ls_reject + " before saving.~n~n"+&
		"Save request cancelled.")
	if pos(ls_reject, "logo name") > 0 then sle_name.setfocus() else sle_file.setfocus()
	return -1
end if

if il_current_id > 0 then
	update graphic_definitions set gd_dbstring = :ls_new_dbstring 
	where gd_id = :il_current_id and gd_dbstring = :ls_old_dbstring ;
	if sqlca.sqlcode = 0 and sqlca.sqlnrows = 1 then
		commit ;
	else
		rollback ;
		goto failure
	end if
else
	ll_new_id = 2000
	for ll_checkloop = 1 to dw_list.rowcount()
		if dw_list.object.gd_id[ll_checkloop] > ll_new_id then &
			ll_new_id = dw_list.object.gd_id[ll_checkloop]
	next
	ll_new_id ++
	insert into graphic_definitions (gd_id, gd_dbstring) 
	values (:ll_new_id, :ls_new_dbstring) ;
	if sqlca.sqlcode = 0 then
		commit ;
		il_current_id = ll_new_id
	else
		rollback ;
		goto failure
	end if
end if

of_retrieve_list()
ll_row = dw_list.find("gd_id = " + string(il_current_id), 1, dw_list.rowcount())
if ll_row > 0 then dw_list.selectrow(ll_row, true)

return 1

failure:

choose case as_context
case "SAVE_REQUEST!"
	messagebox("Save Changes", "Could not save changes to database.~n~nPlease retry.", &
		exclamation!)
	return -1
case "CLOSE_WINDOW!"
	if messagebox("Save Changes", "Could not save changes to database.  Press OK "+&
		"to abandon changes and close window, or Cancel to return to the logo setup "+&
		"screen and preserve changes for now.", exclamation!, okcancel!) = 2 &
		then return -1
case "CHANGE_SELECTION!"
	if messagebox("Save Changes", "Could not save changes to database.  Press OK "+&
		"to abandon changes and display the logo you requested, or Cancel to return to "+&
		"the current logo and preserve changes for now.", exclamation!, okcancel!) = 2 &
		then return -1
case "NEW!"
	if messagebox("Save Changes", "Could not save changes to database.  Press OK "+&
		"to abandon changes and create a new logo, or Cancel to return to "+&
		"the current logo and preserve changes for now.", exclamation!, okcancel!) = 2 &
		then return -1
end choose

if not as_context = "SAVE_REQUEST!" then
	if isnull(il_current_id) then
		dw_list.filter()
		dw_list.rowsdiscard(1, dw_list.filteredcount(), filter!)
	end if
end if

return 1
end function

public function integer of_set_parent (window aw_new_parent);if isvalid(aw_new_parent) then
	iw_parent = aw_new_parent
	return 1
else
	return -1
end if
end function

public subroutine of_new ();long ll_row

if of_save_if_needed("NEW!") = -1 then return

ll_row = dw_list.insertrow(0)

if ll_row > 0 then
	setnull(il_current_id)
	dw_list.object.gd_name[ll_row] = "[NEW LOGO]"
	sle_name.text = "[NEW LOGO]"
	dw_list.selectrow(0, false)
	dw_list.selectrow(ll_row, true)
	sle_file.text = ""
	of_enable_edit(true)
	of_reset_graphic()
	sle_name.setfocus()
	sle_name.selecttext(1, len(sle_name.text))
else
	messagebox("Create New Logo", "Could not process request.  Request cancelled.", &
		exclamation!)
end if
end subroutine

public subroutine of_enable_edit (boolean ab_enabled);sle_name.enabled = ab_enabled
pb_getfile.enabled = ab_enabled
sle_file.enabled = ab_enabled
end subroutine

public function integer of_create_picture (datawindow adw_target, string as_picture_name, string as_band, long al_refx, long al_refy, string as_dbstring);string ls_filename, ls_command
long ll_x, ll_y, ll_width, ll_height
n_cst_string lnv_string

ll_x = al_refx + long(lnv_string.of_ExtractDelimited(as_dbstring, "X"))
ll_y = al_refy + long(lnv_string.of_ExtractDelimited(as_dbstring, "Y"))
ll_width = long(lnv_string.of_ExtractDelimited(as_dbstring, "WIDTH"))
ll_height = long(lnv_string.of_ExtractDelimited(as_dbstring, "HEIGHT"))
ls_filename = lnv_string.of_ExtractDelimited(as_dbstring, "FILENAME")

adw_target.setredraw(false)
adw_target.modify("destroy " + as_picture_name)

ls_command = 'create bitmap('
ls_command += 'band=' + as_band + ' '
ls_command += 'filename="' + ls_filename + '" '
ls_command += 'x="' + string(ll_x) + '" '
ls_command += 'y="' + string(ll_y) + '" '
ls_command += 'height="' + string(ll_height) + '" '
ls_command += 'width="' + string(ll_width) + '" '
ls_command += 'border="3"  '
ls_command += 'name=' + as_picture_name + '  '
ls_command += 'resizeable=1  '
ls_command += 'moveable=1 '
ls_command += ')'

adw_target.modify(ls_command)
adw_target.setredraw(true)

sle_file.text = ls_filename
st_invalid_file.visible = not fileexists(ls_filename)

return 1
end function

on u_graphic_setup.create
this.pb_getfile=create pb_getfile
this.st_invalid_file=create st_invalid_file
this.p_check_size=create p_check_size
this.dw_list=create dw_list
this.st_3=create st_3
this.sle_file=create sle_file
this.sle_name=create sle_name
this.st_2=create st_2
this.st_1=create st_1
this.dw_layout=create dw_layout
this.Control[]={this.pb_getfile,&
this.st_invalid_file,&
this.p_check_size,&
this.dw_list,&
this.st_3,&
this.sle_file,&
this.sle_name,&
this.st_2,&
this.st_1,&
this.dw_layout}
end on

on u_graphic_setup.destroy
destroy(this.pb_getfile)
destroy(this.st_invalid_file)
destroy(this.p_check_size)
destroy(this.dw_list)
destroy(this.st_3)
destroy(this.sle_file)
destroy(this.sle_name)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_layout)
end on

event constructor;string ls_command

of_enable_edit(false)

dw_list.settransobject(sqlca)
dw_list.setfilter("gd_id > 0") //Used in save_if_needed

il_target_width = 796
il_target_height = 213
of_compute_xy(il_target_width, il_target_height, il_target_x, il_target_y, false)

//Create Top Line of Target Box
ls_command = 'create line(band=foreground x1="' + string(il_target_x) + '" y1="' + string(il_target_y) + '" x2="' + string(il_target_x + il_target_width) + '" y2="' + string(il_target_y) + '"  name=ln_target_top pen.style="0" pen.width="5" pen.color="255"  background.mode="2" background.color="255" )'
dw_layout.modify(ls_command)

//Create Bottom Line of Target Box
ls_command = 'create line(band=foreground x1="' + string(il_target_x) + '" y1="' + string(il_target_y + il_target_height) + '" x2="' + string(il_target_x + il_target_width) + '" y2="' + string(il_target_y + il_target_height) + '"  name=ln_target_bottom pen.style="0" pen.width="5" pen.color="255"  background.mode="2" background.color="255" )'
dw_layout.modify(ls_command)

//Create Left Line of Target Box
ls_command = 'create line(band=foreground x1="' + string(il_target_x) + '" y1="' + string(il_target_y) + '" x2="' + string(il_target_x) + '" y2="' + string(il_target_y + il_target_height + 4) + '"  name=ln_target_left pen.style="0" pen.width="5" pen.color="255"  background.mode="2" background.color="255" )'
dw_layout.modify(ls_command)

//Create Right Line of Target Box
ls_command = 'create line(band=foreground x1="' + string(il_target_x + il_target_width) + '" y1="' + string(il_target_y) + '" x2="' + string(il_target_x + il_target_width) + '" y2="' + string(il_target_y + il_target_height + 4) + '"  name=ln_target_right pen.style="0" pen.width="5" pen.color="255"  background.mode="2" background.color="255" )'
dw_layout.modify(ls_command)

//x 1066 = ' + string(il_target_x) + '
//x 1861 = ' + string(il_target_x + il_target_width) + '
//
//y 560 = ' + string(il_target_y) + '
//y 772 = ' + string(il_target_y + il_target_height) + '


//ls_create = 'create rectangle(band=foreground x="' + string(il_target_x) + '" y="' + string(il_target_y) + '" height="' + string(il_target_height) + '" width="' + string(il_target_width) + '"  name=r_target brush.hatch="7" brush.color="553648127" pen.style="0" pen.width="5" pen.color="255"  background.mode="2" background.color="0" )'
//dw_layout.modify(ls_create)
end event

type pb_getfile from picturebutton within u_graphic_setup
int X=933
int Y=696
int Width=101
int Height=88
int TabOrder=21
string PictureName="fileopen.bmp"
Alignment HTextAlign=Left!
boolean OriginalSize=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_pathname, ls_filename

if GetFileOpenName ( "Select Graphics File", ls_pathname, ls_filename, "", &
	"Windows Metafile (*.WMF),*.WMF,RunLengthEncode (*.RLE),*.RLE,Bitmap (*.BMP),*.BMP," +&
	"All Files (*.*),*.*" ) = 1 then
	//The lack of spaces between entries in the file type list is significant;
	//the spaces show up in the type list windows displays.
		sle_file.text = ls_pathname
		of_reset_graphic()
end if
end event

type st_invalid_file from statictext within u_graphic_setup
int X=462
int Y=712
int Width=443
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="(File Not Valid)"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_check_size from picture within u_graphic_setup
int X=37
int Y=920
int Width=165
int Height=144
boolean Visible=false
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type dw_list from datawindow within u_graphic_setup
int X=32
int Y=120
int Width=1006
int Height=360
string DataObject="d_graphic_definitions"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;long ll_clicked_id

if row > 0 and row <> this.getselectedrow(0) then
	ll_clicked_id = this.object.gd_id[row]
else
	return 0
end if

if of_save_if_needed("CHANGE_SELECTION!") = 1 then
	post of_change_selection(ll_clicked_id)
end if
end event

type st_3 from statictext within u_graphic_setup
int X=32
int Y=712
int Width=544
int Height=76
boolean Enabled=false
string Text="Graphics File:"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_file from singlelineedit within u_graphic_setup
int X=32
int Y=792
int Width=1006
int Height=76
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;of_reset_graphic()
end event

type sle_name from singlelineedit within u_graphic_setup
int X=32
int Y=592
int Width=1006
int Height=76
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
TextCase TextCase=Upper!
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

type st_2 from statictext within u_graphic_setup
int X=32
int Y=512
int Width=544
int Height=76
boolean Enabled=false
string Text="Logo Name:"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_graphic_setup
int X=32
int Y=32
int Width=512
int Height=76
boolean Enabled=false
string Text="Logo Selection:"
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_layout from datawindow within u_graphic_setup
int X=1106
int Y=32
int Width=1440
int Height=1164
int TabOrder=30
string DataObject="d_empty"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event rbuttondown;string lsa_parm_labels[], ls_selected_item
any laa_parm_values[]
long ll_original_width, ll_original_height, ll_width, ll_height, ll_x, ll_y

if isvalid(dwo) then
	if dwo.name = "p_logo" then
	else
		return 0
	end if
end if

lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Auto-Fit~tAUTO!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "-"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Align Left~tALIGN_LEFT!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Align Right~tALIGN_RIGHT!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Align Top~tALIGN_TOP!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Align Bottom~tALIGN_BOTTOM!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Align Center~tALIGN_CENTER!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "-"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Fill Frame~tFILL!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Fill Horizontal~tFILL_H!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Fill Vertical~tFILL_V!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "-"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Restore Original Size~tRESTORE!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Restore Horizontal Proportion~tRESTORE_HP!"
lsa_parm_labels[upperbound(lsa_parm_labels) + 1] = "ADD_ITEM"
laa_parm_values[upperbound(laa_parm_values) + 1] = "Restore Vertical Proportion~tRESTORE_VP!"

ls_selected_item = f_pop_standard(lsa_parm_labels, laa_parm_values)

if len(ls_selected_item) > 0 then
	if of_get_original_size(dw_layout.object.p_logo.filename, ll_original_width, &
		ll_original_height) = -1 then return 0
	ll_width = long(dw_layout.object.p_logo.width)
	ll_height = long(dw_layout.object.p_logo.height)
	ll_x = long(dw_layout.object.p_logo.x)
	ll_y = long(dw_layout.object.p_logo.y)
	dw_layout.setredraw(false)
	choose case ls_selected_item
	case "AUTO!"
		if ll_original_width / il_target_width > ll_original_height / il_target_height then
			ll_width = il_target_width
			ll_height = int(ll_width / ll_original_width * ll_original_height)
				//We know ll_original_width > 0 from success of of_get_original_size
		else
			ll_height = il_target_height
			ll_width = int(ll_height / ll_original_height * ll_original_width)
				//We know ll_original_height > 0 from success of of_get_original_size
		end if
		of_compute_xy(ll_width, ll_height, ll_x, ll_y, false)
	case "ALIGN_LEFT!"
		ll_x = il_target_x
	case "ALIGN_RIGHT!"
		ll_x = il_target_x + il_target_width - ll_width
	case "ALIGN_TOP!"
		ll_y = il_target_y
	case "ALIGN_BOTTOM!"
		ll_y = il_target_y + il_target_height - ll_height
	case "ALIGN_CENTER!"
		of_compute_xy(ll_width, ll_height, ll_x, ll_y, true)
	case "FILL!"
		ll_width = il_target_width
		ll_height = il_target_height
		ll_x = il_target_x
		ll_y = il_target_y
	case "FILL_H!"
		ll_width = il_target_width
		ll_x = il_target_x
	case "FILL_V!"
		ll_height = il_target_height
		ll_y = il_target_y
	case "RESTORE!"
		ll_width = ll_original_width
		ll_height = ll_original_height
	case "RESTORE_HP!"
		ll_width = int(ll_height / ll_original_height * ll_original_width)
		//We know ll_original_height > 0 from success of of_get_original_size
	case "RESTORE_VP!"
		ll_height = int(ll_width / ll_original_width * ll_original_height)
		//We know ll_original_width > 0 from success of of_get_original_size
	end choose
	if ll_width > 0 and ll_height > 0 then
		dw_layout.object.p_logo.width = ll_width
		dw_layout.object.p_logo.height = ll_height
		dw_layout.object.p_logo.x = ll_x
		dw_layout.object.p_logo.y = ll_y
	end if

	dw_layout.setredraw(true)

//
//		dw_layout.modify("destroy p_logo")
//		of_compute_xy(ll_original_width, ll_original_height, ll_x, ll_y, false)
//		ls_command = 'create bitmap(band=background filename="' + ls_filename + '" x="' + string(ll_x) + '" y="' + string(ll_y) + '" height="' + string(ll_original_height) + '" width="' + string(ll_original_width) + '" border="3"  name=p_logo  resizeable=1  moveable=1 )'
//		dw_layout.modify(ls_command)
//	else
//		st_invalid_file.visible = true
//	end if


end if


end event

