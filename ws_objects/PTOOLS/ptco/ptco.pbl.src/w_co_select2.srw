$PBExportHeader$w_co_select2.srw
$PBExportComments$PTCORE.
forward
global type w_co_select2 from window
end type
type st_quotes from statictext within w_co_select2
end type
type st_no_match from statictext within w_co_select2
end type
type st_invalid from statictext within w_co_select2
end type
type cb_new from commandbutton within w_co_select2
end type
type sle_search from singlelineedit within w_co_select2
end type
type cb_cancel from commandbutton within w_co_select2
end type
type cb_select from commandbutton within w_co_select2
end type
type dw_co_list from datawindow within w_co_select2
end type
end forward

global type w_co_select2 from window
integer x = 293
integer y = 664
integer width = 2949
integer height = 840
boolean titlebar = true
string title = "Company / Facility Selection"
windowtype windowtype = response!
long backcolor = 12632256
event new_search pbm_custom01
st_quotes st_quotes
st_no_match st_no_match
st_invalid st_invalid
cb_new cb_new
sle_search sle_search
cb_cancel cb_cancel
cb_select cb_select
dw_co_list dw_co_list
end type
global w_co_select2 w_co_select2

type variables
protected:
string xon_1, xon_2
string is_original_select
end variables

event new_search;xon_1 = ""
xon_2 = ""

st_invalid.visible = false
st_no_match.visible = false
st_quotes.visible = false
cb_select.enabled = false
dw_co_list.reset()

string selstr, workstr
s_co_info lstr_company

workstr = trim(sle_search.text)

if left(workstr, 1) = "/" then
	if gnv_cst_companies.of_select(lstr_company, "ANY!", true, workstr, false, 0, &
		true, false) = 1 then
			closewithreturn(this, lstr_company.co_id)
	else
			st_no_match.visible = true
			this.post setfocus()
	end if
	return
elseif left(workstr, 1) = "~"" then
	workstr = upper(trim(replace(workstr, 1, 1, "")))
	if right(workstr, 1) = "~"" then workstr = trim(left(workstr, len(workstr) - 1))
	if pos(workstr, "~"") > 0 or pos(workstr, "'") > 0 then
		st_quotes.visible = true
		goto invalid
	end if
	selstr = "WHERE left(co_name, " + string(len(workstr)) + ") = ~~'" + &
		workstr + "~~' AND co_status <> ~~'D~~' "
else
	if not match(workstr, "^[A-Za-z0-9]") then goto invalid
	if gf_coname_index(sle_search.text, xon_1, xon_2) < 1 then goto invalid
	selstr = "WHERE (co_xon_1 = ~~'" + xon_1 + "~~'"
	if len(xon_2) > 0 then
		selstr += " AND co_xon_2 = ~~'" + xon_2 + "~~')"
	else
		selstr += " OR co_xon_2 = ~~'" + xon_1 + "~~')"
	end if
	selstr += " AND co_status <> ~~'D~~' "
end if

selstr = is_original_select + " " + selstr
dw_co_list.modify("datawindow.table.select = '" + selstr + "'")

if dw_co_list.retrieve() = -1 then
	rollback ;
else
	commit ;
end if

if dw_co_list.rowcount() < 1 then st_no_match.visible = true

dw_co_list.post setfocus()

return

invalid:
st_invalid.visible = true
this.post setfocus()
end event

event open;s_strings open_parms
open_parms = message.powerobjectparm

sle_search.text = open_parms.strar[1]

if upperbound(open_parms.strar) > 1 then
	if open_parms.strar[2] = "NEW=ENABLED" then cb_new.enabled = true
end if

dw_co_list.settransobject(sqlca)
//The following must follow settransobject, or the result is different
is_original_select = dw_co_list.describe("datawindow.table.select")

if left(sle_search.text, 1) = "/" then
//	string workstr
//	workstr = upper(trim(replace(sle_search.text, 1, 1, "")))
//	if match(workstr, "^[A-Z0-9]+$") then 
		st_no_match.visible = true
//	else
//		st_invalid.visible = true
//	end if
	return
end if

if len(sle_search.text) > 0 then this.postevent("new_search") else sle_search.setfocus()
end event

on w_co_select2.create
this.st_quotes=create st_quotes
this.st_no_match=create st_no_match
this.st_invalid=create st_invalid
this.cb_new=create cb_new
this.sle_search=create sle_search
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_co_list=create dw_co_list
this.Control[]={this.st_quotes,&
this.st_no_match,&
this.st_invalid,&
this.cb_new,&
this.sle_search,&
this.cb_cancel,&
this.cb_select,&
this.dw_co_list}
end on

on w_co_select2.destroy
destroy(this.st_quotes)
destroy(this.st_no_match)
destroy(this.st_invalid)
destroy(this.cb_new)
destroy(this.sle_search)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_co_list)
end on

event close;message.stringparm = sle_search.text
end event

type st_quotes from statictext within w_co_select2
boolean visible = false
integer x = 64
integer y = 488
integer width = 1600
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "Exact-name searches cannot contain quotes or apostrophes."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_no_match from statictext within w_co_select2
boolean visible = false
integer x = 617
integer y = 416
integer width = 498
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "No matches found."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_invalid from statictext within w_co_select2
boolean visible = false
integer x = 251
integer y = 416
integer width = 1230
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 16777215
boolean enabled = false
string text = "The search request you have entered is invalid."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_new from commandbutton within w_co_select2
integer x = 2359
integer y = 28
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "New"
end type

event clicked;string typed_name
typed_name = trim(sle_search.text)

if (len(typed_name) > 0 and match(typed_name, "^[A-Za-z0-9]")) or len(typed_name) = 0 then
	closewithreturn(parent, -2)
else
	messagebox("Create New Company", "The company name you have specified is not "+&
		"valid.  Request cancelled.", exclamation!)
end if
end event

type sle_search from singlelineedit within w_co_select2
event enchange pbm_enchange
integer x = 23
integer y = 32
integer width = 933
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 30
borderstyle borderstyle = stylelowered!
end type

event modified;if keydown(keytab!) or keydown(keyenter!) then
	parent.postevent("new_search")
end if
end event

event getfocus;cb_select.default = false

this.selecttext(1, len(this.text))
end event

event losefocus;cb_select.default = true
end event

type cb_cancel from commandbutton within w_co_select2
integer x = 2647
integer y = 28
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;closewithreturn(parent, 0)
end event

type cb_select from commandbutton within w_co_select2
integer x = 978
integer y = 28
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Select"
boolean default = true
end type

event clicked;integer selrow
long ll_id
selrow = dw_co_list.getselectedrow(0)

if selrow < 1 then
	this.enabled = false
	return
end if

ll_id = dw_co_list.object.co_id[selrow]

closewithreturn(parent, ll_id)
end event

type dw_co_list from datawindow within w_co_select2
integer x = 23
integer y = 140
integer width = 2880
integer height = 580
integer taborder = 20
string dataobject = "d_company_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on doubleclicked;if cb_select.enabled then cb_select.postevent("clicked")
end on

event rowfocuschanged;this.selectrow(0, false)

if currentrow > 0 and this.rowcount() > 0 then
	//currentrow was coming up > 0 on retrieves with no rows
	this.selectrow(currentrow, true)
	cb_select.enabled = true
else
	cb_select.enabled = false
end if
end event

event getfocus;if this.rowcount() = 0 then sle_search.post setfocus()
end event

