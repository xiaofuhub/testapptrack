$PBExportHeader$w_coname.srw
$PBExportComments$PTDATA.     Response window for adding/editing a company name.
forward
global type w_coname from window
end type
type st_fixed_name from statictext within w_coname
end type
type cb_select from commandbutton within w_coname
end type
type st_dup_3 from statictext within w_coname
end type
type st_dup_2 from statictext within w_coname
end type
type st_dup_1 from statictext within w_coname
end type
type dw_co_list from datawindow within w_coname
end type
type st_nosym_2 from statictext within w_coname
end type
type st_nosym_1 from statictext within w_coname
end type
type cb_cancel from commandbutton within w_coname
end type
type cb_ok from commandbutton within w_coname
end type
type st_instruct from statictext within w_coname
end type
type sle_coname from singlelineedit within w_coname
end type
end forward

global type w_coname from window
integer x = 393
integer y = 788
integer width = 2967
integer height = 1276
boolean titlebar = true
string title = "Add New Company"
windowtype windowtype = response!
long backcolor = 12632256
st_fixed_name st_fixed_name
cb_select cb_select
st_dup_3 st_dup_3
st_dup_2 st_dup_2
st_dup_1 st_dup_1
dw_co_list dw_co_list
st_nosym_2 st_nosym_2
st_nosym_1 st_nosym_1
cb_cancel cb_cancel
cb_ok cb_ok
st_instruct st_instruct
sle_coname sle_coname
end type
global w_coname w_coname

type variables
protected:
string retnstr
string is_original_select
end variables

event open;retnstr = message.stringparm

this.height = 673
sle_coname.text = replace(retnstr, 1, 3, "")
retnstr = left(retnstr, 3)

if retnstr = "*NF" then
	st_instruct.text = "Enter New Facility Name"
	this.title = "Add New Facility"
end if

dw_co_list.settransobject(sqlca)
is_original_select = dw_co_list.describe("datawindow.table.select")

sle_coname.setfocus()
end event

on w_coname.create
this.st_fixed_name=create st_fixed_name
this.cb_select=create cb_select
this.st_dup_3=create st_dup_3
this.st_dup_2=create st_dup_2
this.st_dup_1=create st_dup_1
this.dw_co_list=create dw_co_list
this.st_nosym_2=create st_nosym_2
this.st_nosym_1=create st_nosym_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_instruct=create st_instruct
this.sle_coname=create sle_coname
this.Control[]={this.st_fixed_name,&
this.cb_select,&
this.st_dup_3,&
this.st_dup_2,&
this.st_dup_1,&
this.dw_co_list,&
this.st_nosym_2,&
this.st_nosym_1,&
this.cb_cancel,&
this.cb_ok,&
this.st_instruct,&
this.sle_coname}
end on

on w_coname.destroy
destroy(this.st_fixed_name)
destroy(this.cb_select)
destroy(this.st_dup_3)
destroy(this.st_dup_2)
destroy(this.st_dup_1)
destroy(this.dw_co_list)
destroy(this.st_nosym_2)
destroy(this.st_nosym_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_instruct)
destroy(this.sle_coname)
end on

type st_fixed_name from statictext within w_coname
boolean visible = false
integer x = 23
integer y = 168
integer width = 1682
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Univers Condensed"
long textcolor = 33554432
long backcolor = 12648447
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_select from commandbutton within w_coname
boolean visible = false
integer x = 2039
integer y = 72
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Select"
end type

event clicked;Long selrow, selid
selrow = dw_co_list.getselectedrow(0)

if selrow < 1 then
	this.enabled = false
	return
end if

selid = dw_co_list.getitemnumber(selrow, "co_id")
if selid < 1 then return //shouldn't happen

closewithreturn(parent, "*" + string(selid))
end event

type st_dup_3 from statictext within w_coname
boolean visible = false
integer x = 23
integer y = 492
integer width = 1307
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "of them instead of adding the new company."
boolean focusrectangle = false
end type

type st_dup_2 from statictext within w_coname
boolean visible = false
integer x = 23
integer y = 400
integer width = 1586
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "already exist.  Press select to view information on one"
boolean focusrectangle = false
end type

type st_dup_1 from statictext within w_coname
boolean visible = false
integer x = 23
integer y = 308
integer width = 1527
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "The following similarly named companies / facilities"
boolean focusrectangle = false
end type

type dw_co_list from datawindow within w_coname
integer x = 23
integer y = 584
integer width = 2880
integer height = 580
string dataobject = "d_company_list"
boolean vscrollbar = true
boolean livescroll = true
end type

on doubleclicked;if cb_select.enabled then cb_select.postevent("clicked")
end on

event clicked;this.selectrow(0, false)

if row > 0 then
	this.selectrow(row, true)
	cb_select.enabled = true
else
	cb_select.enabled = false
end if
end event

type st_nosym_2 from statictext within w_coname
integer x = 197
integer y = 400
integer width = 1371
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "a number (not a symbol)."
boolean focusrectangle = false
end type

type st_nosym_1 from statictext within w_coname
integer x = 5
integer y = 308
integer width = 1518
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = " Note: The name must begin with either a letter or"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_coname
integer x = 2633
integer y = 72
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

on clicked;closewithreturn(parent, retnstr)
end on

type cb_ok from commandbutton within w_coname
integer x = 2336
integer y = 72
integer width = 247
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
boolean default = true
end type

event clicked;string xon_1, xon_2, selstr, oldselstr
integer wherepos, orderpos

sle_coname.text = trim(sle_coname.text)
if len(sle_coname.text) > 0 and match(sle_coname.text, "^[A-Za-z0-9]") then &
	xon_1 = xon_1 else goto invalid

if gf_coname_index(sle_coname.text, xon_1, xon_2) < 1 then goto invalid

if len(sle_coname.text) < 5 then
	if messagebox(parent.title, "The name you have entered is unusually short.  Press "+&
		"OK to confirm it is correct, or Cancel to return to the entry window.", &
		exclamation!, okcancel!, 2) = 2 then return
end if

if cb_select.visible = true or retnstr = "*NF" then goto addit

selstr = "WHERE co_xon_1 = ~~'" + xon_1 + "~~'"
if len(xon_2) > 0 then
	selstr += " OR co_xon_2 = ~~'" + xon_2 + "~~'"
else
	selstr += " OR co_xon_2 = ~~'" + xon_1 + "~~'"
end if
selstr += " AND co_status <> ~~'D~~' "

selstr = is_original_select + " " + selstr
dw_co_list.modify("datawindow.table.select = '" + selstr + "'")

if dw_co_list.retrieve() = -1 then
	rollback ;
else
	commit ;
end if

if dw_co_list.rowcount() < 1 then goto addit
if dw_co_list.rowcount() = 1 then
	dw_co_list.selectrow(1, true)
	cb_select.enabled = true
end if

st_fixed_name.text = sle_coname.text
st_fixed_name.visible = true
sle_coname.visible = false
parent.height = 1277
st_dup_1.visible = true
st_dup_2.visible = true
st_dup_3.visible = true
st_nosym_1.visible = false
st_nosym_2.visible = false
cb_select.visible = true
this.default = false
return

addit:
closewithreturn(parent, sle_coname.text)
return

invalid:
messagebox(parent.title, "The name you have entered is invalid.  If you do "+&
	"not wish to add a new " + lower(right(parent.title, 7)) + ", press Cancel "+&
	"in the entry window.")
end event

type st_instruct from statictext within w_coname
integer x = 23
integer y = 44
integer width = 919
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Enter New Company Name:"
boolean focusrectangle = false
end type

type sle_coname from singlelineedit within w_coname
integer x = 23
integer y = 168
integer width = 1682
integer height = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
integer limit = 45
borderstyle borderstyle = stylelowered!
end type

