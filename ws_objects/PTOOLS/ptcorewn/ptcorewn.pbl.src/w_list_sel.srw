$PBExportHeader$w_list_sel.srw
$PBExportComments$PTCORE.
forward
global type w_list_sel from w_response
end type
type mle_instruct from multilineedit within w_list_sel
end type
type cb_cancel from commandbutton within w_list_sel
end type
type cb_select from commandbutton within w_list_sel
end type
type lb_list from listbox within w_list_sel
end type
end forward

global type w_list_sel from w_response
integer x = 585
integer y = 608
integer width = 1669
integer height = 804
string title = "Selection List"
long backcolor = 12632256
mle_instruct mle_instruct
cb_cancel cb_cancel
cb_select cb_select
lb_list lb_list
end type
global w_list_sel w_list_sel

type variables
s_strings istr_listvals
end variables

on w_list_sel.create
int iCurrent
call super::create
this.mle_instruct=create mle_instruct
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.lb_list=create lb_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_instruct
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.lb_list
end on

on w_list_sel.destroy
call super::destroy
destroy(this.mle_instruct)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.lb_list)
end on

event open;call super::open;//s_strings listvals
istr_listvals = message.powerobjectparm

end event

event pfc_postopen;call super::pfc_postopen;if len(istr_listvals.strar[1]) > 0 then this.title = istr_listvals.strar[1]
if len(istr_listvals.strar[2]) > 0 then mle_instruct.text = istr_listvals.strar[2]

//This loop starts at 5 to allow up to 4 strings to be passed.  Currently, only 2 are used.

integer 	readloop
int		selind
Int	li_Count
li_Count = UpperBound ( istr_listvals.strar )

for readloop = 5 to li_Count
	lb_list.additem(istr_listvals.strar[readloop])
next

selind = integer(istr_listvals.strar[3])
if selind > 0 then
	lb_list.selectitem(selind)
ELSE
	lb_List.SelectItem ( 1 )
END IF
end event

type cb_help from w_response`cb_help within w_list_sel
integer x = 1563
integer y = 648
end type

type mle_instruct from multilineedit within w_list_sel
integer x = 37
integer y = 32
integer width = 1294
integer height = 212
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Please make a selection from the list below."
boolean border = false
boolean displayonly = true
end type

type cb_cancel from commandbutton within w_list_sel
integer x = 1367
integer y = 136
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;closewithreturn(parent, "")
end event

type cb_select from commandbutton within w_list_sel
integer x = 1367
integer y = 28
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Select"
boolean default = true
end type

event clicked;integer selind, checkloop
string selstr

if lb_list.multiselect then
	if lb_list.totalselected() > 0 then
		for checkloop = 1 to lb_list.totalitems()
			if lb_list.state(checkloop) = 1 then selstr += string(checkloop) + "q"
		next
	end if
else
	selind = lb_list.selectedindex()
	if selind > 0 then selstr = string(selind) + "q"
end if

if len(selstr) > 0 then
	closewithreturn(parent, selstr)
else
	messagebox("Item Selection", "No items are selected.")
end if
end event

type lb_list from listbox within w_list_sel
integer x = 27
integer y = 260
integer width = 1582
integer height = 360
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;cb_Select.Event Post Clicked ( )
end event

