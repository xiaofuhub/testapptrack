$PBExportHeader$w_log_settings.srw
forward
global type w_log_settings from w_response
end type
type st_1 from statictext within w_log_settings
end type
type sle_numcop from singlelineedit within w_log_settings
end type
type cbx_miles from checkbox within w_log_settings
end type
type cb_cancel from commandbutton within w_log_settings
end type
type cbx_autoprint from checkbox within w_log_settings
end type
type cbx_signbox from checkbox within w_log_settings
end type
type cbx_autonext from checkbox within w_log_settings
end type
type cbx_autosave from checkbox within w_log_settings
end type
type gb_1 from groupbox within w_log_settings
end type
type cb_apply_perm from commandbutton within w_log_settings
end type
type cb_apply_temp from commandbutton within w_log_settings
end type
type st_temp from statictext within w_log_settings
end type
type st_perm from statictext within w_log_settings
end type
end forward

global type w_log_settings from w_response
integer x = 1184
integer y = 452
integer width = 1074
integer height = 628
string title = "User Preferences - (Log Entry)"
long backcolor = 12632256
st_1 st_1
sle_numcop sle_numcop
cbx_miles cbx_miles
cb_cancel cb_cancel
cbx_autoprint cbx_autoprint
cbx_signbox cbx_signbox
cbx_autonext cbx_autonext
cbx_autosave cbx_autosave
gb_1 gb_1
cb_apply_perm cb_apply_perm
cb_apply_temp cb_apply_temp
st_temp st_temp
st_perm st_perm
end type
global w_log_settings w_log_settings

type variables
protected:
s_log_settings settings
w_log parwin
boolean forced_closing = false
end variables

forward prototypes
public function integer update_settings (ref string failnote)
public function integer insert_settings (ref string failnote)
end prototypes

public function integer update_settings (ref string failnote);string retpart

retpart = "11000"
update system_settings 
	set ss_long = :settings.autoprint
	where ss_id = 11000 and ss_uid = :settings.emp_id ;

if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11001"
update system_settings 
	set ss_long = :settings.autosave
	where ss_id = 11001 and ss_uid = :settings.emp_id ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11002"
update system_settings 
	set ss_long = :settings.autonext
	where ss_id = 11002 and ss_uid = :settings.emp_id ;
if sqlca.sqlcode <> 0 then	goto rollitback 

retpart = "11003"
update system_settings 
	set ss_long = :settings.printsign
	where ss_id = 11003 and ss_uid = :settings.emp_id ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11004"
update system_settings 
	set ss_long = :settings.entermiles
	where ss_id = 11004 and ss_uid = :settings.emp_id ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11005"
update system_settings 
	set ss_long = :settings.numcop
	where ss_id = 11005 and ss_uid = :settings.emp_id ;
if sqlca.sqlcode <> 0 then	goto rollitback

commit ;
return 0

rollitback:
failnote = "Could not insert user options into the database.  (" + string(retpart) + ")~n" +&
	sqlca.sqlerrtext 
rollback ;
return -1
end function

public function integer insert_settings (ref string failnote);string retpart

retpart = "11000"
insert into system_settings (ss_id, ss_uid, ss_long) 
	values (	11000, :settings.emp_id, :settings.autoprint) ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11001"
insert into system_settings (ss_id, ss_uid, ss_long) 
	values (	11001, :settings.emp_id, :settings.autosave) ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11002"
insert into system_settings (ss_id, ss_uid, ss_long) 
	values (	11002, :settings.emp_id, :settings.autonext) ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11003"
insert into system_settings (ss_id, ss_uid, ss_long) 
	values (	11003, :settings.emp_id, :settings.printsign) ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11004"
insert into system_settings (ss_id, ss_uid, ss_long) 
	values (	11004, :settings.emp_id, :settings.entermiles) ;
if sqlca.sqlcode <> 0 then	goto rollitback

retpart = "11005"
insert into system_settings (ss_id, ss_uid, ss_long) 
	values (	11005, :settings.emp_id, :settings.numcop) ;
if sqlca.sqlcode <> 0 then	goto rollitback

commit ;
settings.setup = True
return 0

rollitback:
failnote = "Could not insert user options into the database.  (" + string(retpart) + ")~n" +&
sqlca.sqlerrtext
rollback ;
return -1



end function

on w_log_settings.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_numcop=create sle_numcop
this.cbx_miles=create cbx_miles
this.cb_cancel=create cb_cancel
this.cbx_autoprint=create cbx_autoprint
this.cbx_signbox=create cbx_signbox
this.cbx_autonext=create cbx_autonext
this.cbx_autosave=create cbx_autosave
this.gb_1=create gb_1
this.cb_apply_perm=create cb_apply_perm
this.cb_apply_temp=create cb_apply_temp
this.st_temp=create st_temp
this.st_perm=create st_perm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_numcop
this.Control[iCurrent+3]=this.cbx_miles
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cbx_autoprint
this.Control[iCurrent+6]=this.cbx_signbox
this.Control[iCurrent+7]=this.cbx_autonext
this.Control[iCurrent+8]=this.cbx_autosave
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.cb_apply_perm
this.Control[iCurrent+11]=this.cb_apply_temp
this.Control[iCurrent+12]=this.st_temp
this.Control[iCurrent+13]=this.st_perm
end on

on w_log_settings.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_numcop)
destroy(this.cbx_miles)
destroy(this.cb_cancel)
destroy(this.cbx_autoprint)
destroy(this.cbx_signbox)
destroy(this.cbx_autonext)
destroy(this.cbx_autosave)
destroy(this.gb_1)
destroy(this.cb_apply_perm)
destroy(this.cb_apply_temp)
destroy(this.st_temp)
destroy(this.st_perm)
end on

event open;if g_privs.log[1] = 0 then
	messagebox("User Preferences - (Log Entry)", "Your current user privileges do not "+&
	"allow you to edit logs.  You therefore do not have access to log entry preference "+&
	"settings.")
	close(this)
	return
end if

this.x = 1185
this.y = 483


if not isvalid(message.powerobjectparm) then
	string failnote
	if f_log_settings(failnote, settings) = -1 then
		messagebox("User Preferences - (Log Entry)", "Could not retrieve information to open this window." +&
		"~n~nPlease Retry.")
		close(this)
		return
	end if
//	cb_cancel.y = cb_apply_temp.y
//	st_temp.visible = false
//	cb_apply_temp.visible = false
//	this.height = cb_cancel.y + cb_cancel.height + 111
else
	settings = message.powerobjectparm
end if

if settings.autosave = 1 then cbx_autosave.checked = true else cbx_autosave.checked = false
if settings.autoprint = 1 then cbx_autoprint.checked = true else cbx_autoprint.checked = false
if settings.autonext = 1 then cbx_autonext.checked = true else cbx_autonext.checked = false
if settings.printsign = 1 then cbx_signbox.checked = true else cbx_signbox.checked = false
if settings.entermiles = 1 then cbx_miles.checked = true else cbx_miles.checked = false

if g_privs.log[3] = 0 then
	cbx_autosave.checked = false
	cbx_autosave.enabled = false
	cbx_autonext.checked = false
	cbx_autonext.enabled = false
	cbx_miles.checked = false
	cbx_miles.enabled = false
	cbx_autoprint.checked = false
	cbx_autoprint.enabled = false
	sle_numcop.enabled = false
end if
if g_privs.log[2] = 0 then
	cbx_autoprint.checked = false
	cbx_autoprint.enabled = false
	cbx_signbox.checked = false
	cbx_signbox.enabled = false
	sle_numcop.enabled = false
end if

if settings.autoprint = 0 then settings.numcop = 1
sle_numcop.text = string(settings.numcop)






end event

event close;
//if isvalid(parwin) then parwin.settings = settings
// cant be opened by parwin right now, if it could, decide between close with return and close
end event

event closequery;if forced_closing = true then return 0
integer checkval

if cbx_autosave.checked = true then checkval = 1 else checkval = 0
if checkval <> settings.autosave then goto changed_items

if cbx_autonext.checked = true then checkval = 1 else checkval = 0
if checkval <> settings.autonext then goto changed_items

if cbx_signbox.checked = true then checkval = 1 else checkval = 0
if checkval <> settings.printsign then goto changed_items

if cbx_miles.checked = true then checkval = 1 else checkval = 0
if checkval <> settings.entermiles then goto changed_items

return 0

changed_items:
choose case messagebox("User Preferences - (Log Entry)", "Save changes before closing?", &
	exclamation!, yesnocancel!)
case 1
	//This approach is ok becase this is a response window.  If it were a sheet, this
	//would interfere (I think) with a close all windows or exit program attempt.  Brian.
	cb_apply_perm.event post clicked()
	return 1
case 3
	return 1
end choose


end event

event key;if keydown(keydownarrow!) then
	choose case getfocus()
		case cbx_autosave
			cbx_autonext.setfocus()
		case cbx_autonext
			cbx_miles.setfocus()
		case cbx_miles
			cbx_signbox.setfocus()
		case cbx_signbox
			cbx_autosave.setfocus()
	end choose
elseif keydown(keyuparrow!) then
	choose case getfocus()
		case cbx_autosave
			cbx_signbox.setfocus()
		case cbx_autonext
			cbx_autosave.setfocus()
		case cbx_miles
			cbx_autonext.setfocus()
		case cbx_signbox
			cbx_miles.setfocus()
	end choose
end if
end event

type cb_help from w_response`cb_help within w_log_settings
integer x = 951
integer y = 464
end type

type st_1 from statictext within w_log_settings
boolean visible = false
integer x = 142
integer y = 440
integer width = 763
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Number of Copies to Autoprint"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_numcop from singlelineedit within w_log_settings
event lbuttondown pbm_lbuttondown
boolean visible = false
integer x = 32
integer y = 436
integer width = 96
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event lbuttondown;this.setfocus()
end event

event modified;if len(trim(this.text)) = 0 then
	this.text = "1"
else
	if not isnumber(this.text) or trim(this.text) = "0" then
		this.text = "1"
	else 
		this.text = string(abs(integer(this.text)))
		if integer(This.text) > 10 then this.text = "1"
	end if
end if


end event

type cbx_miles from checkbox within w_log_settings
integer x = 32
integer y = 196
integer width = 1019
integer height = 60
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Remind User to Enter Miles"
end type

type cb_cancel from commandbutton within w_log_settings
integer x = 594
integer y = 408
integer width = 247
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;forced_closing = true
close(parent)




end event

type cbx_autoprint from checkbox within w_log_settings
boolean visible = false
integer x = 32
integer y = 356
integer width = 1019
integer height = 60
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Auto Print out of Daily Violations"
end type

event clicked;if this.checked = false then
	sle_numcop.enabled = false
else
	sle_numcop.enabled = true
end if
end event

type cbx_signbox from checkbox within w_log_settings
integer x = 32
integer y = 276
integer width = 1019
integer height = 60
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Print Daily Violation w/ Signature Box"
end type

type cbx_autonext from checkbox within w_log_settings
event clicked pbm_bnclicked
integer x = 32
integer y = 116
integer width = 1093
integer height = 60
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Auto Add Next Log for Next Driver"
end type

type cbx_autosave from checkbox within w_log_settings
event clicked pbm_bnclicked
integer x = 32
integer y = 36
integer width = 1019
integer height = 60
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Auto Save Between Drivers"
end type

type gb_1 from groupbox within w_log_settings
integer x = 32
integer y = 360
integer width = 1006
integer height = 12
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_apply_perm from commandbutton within w_log_settings
integer x = 229
integer y = 408
integer width = 247
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;s_log_settings current_settings
current_settings = settings

if cbx_autosave.checked = true then settings.autosave = 1 else settings.autosave = 0
if cbx_autonext.checked = true then settings.autonext = 1 else settings.autonext = 0
if cbx_autoprint.checked = true then settings.autoprint = 1 else settings.autoprint = 0
if cbx_signbox.checked = true then settings.printsign = 1 else settings.printsign = 0
if cbx_miles.checked = true then settings.entermiles = 1 else settings.entermiles = 0

//sle_numcop.triggerevent(modified!)
//settings.numcop = integer(sle_numcop.text)

//if settings.autoprint = 0 then settings.numcop = 1
settings.numcop = 1

string failnote
integer result

if settings.setup = true then
	result = update_settings(failnote)
else
	result = insert_settings(failnote)
end if

if result = -1 then
	messagebox("Save Changes", "Could not save preference settings to database.~n~n"+&
		"Please Retry.", exclamation!)
	settings = current_settings
	return
end if

if isvalid(w_log) then w_log.settings = settings
forced_closing = true
close(parent)
end event

type cb_apply_temp from commandbutton within w_log_settings
integer x = 494
integer y = 868
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Apply"
end type

event clicked;if cbx_autosave.checked = true then settings.autosave = 1 else settings.autosave = 0
if cbx_autonext.checked = true then settings.autonext = 1 else settings.autonext = 0
if cbx_autoprint.checked = true then settings.autoprint = 1 else settings.autoprint = 0
if cbx_signbox.checked = true then settings.printsign = 1 else settings.printsign = 0
if cbx_miles.checked = true then settings.entermiles = 1 else settings.entermiles = 0

sle_numcop.triggerevent(modified!)
settings.numcop = integer(sle_numcop.text)

//closewithreturn(parent, settings)




end event

type st_temp from statictext within w_log_settings
integer x = 23
integer y = 1068
integer width = 773
integer height = 124
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Apply Settings ONLY While Log Window is Open"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_perm from statictext within w_log_settings
integer x = 23
integer y = 928
integer width = 773
integer height = 124
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Set as User~'s Permanent Settings"
alignment alignment = right!
boolean focusrectangle = false
end type

