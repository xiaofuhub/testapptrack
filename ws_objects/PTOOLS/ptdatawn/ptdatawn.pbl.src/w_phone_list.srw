$PBExportHeader$w_phone_list.srw
forward
global type w_phone_list from w_response
end type
type cbx_1 from checkbox within w_phone_list
end type
type dw_phone from datawindow within w_phone_list
end type
end forward

global type w_phone_list from w_response
integer x = 1134
integer y = 400
integer width = 1344
integer height = 1732
string title = "Phone List"
long backcolor = 12632256
cbx_1 cbx_1
dw_phone dw_phone
end type
global w_phone_list w_phone_list

on w_phone_list.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.dw_phone=create dw_phone
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.dw_phone
end on

on w_phone_list.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.dw_phone)
end on

event open;
this.x = 1162
this.y = 401

dw_phone.settransobject(sqlca)

if dw_phone.retrieve() = -1 then
	rollback ;
	messagebox("Opening Phone List", "Could not retrieve phone list at this time.")
	close(this)
	return
else
	commit ;
end if


end event

type cb_help from w_response`cb_help within w_phone_list
integer x = 1230
integer y = 1568
end type

type cbx_1 from checkbox within w_phone_list
integer x = 55
integer y = 16
integer width = 1134
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Show Drivers Only"
end type

event clicked;string filstr

if this.checked = true then filstr = "not isnull(di_id)"

dw_phone.setredraw(false)

dw_phone.setfilter(filstr)
dw_phone.filter()
dw_phone.sort()

dw_phone.setredraw(true)

end event

type dw_phone from datawindow within w_phone_list
event dwnkey pbm_dwnkey
integer x = 55
integer y = 108
integer width = 1211
integer height = 1428
integer taborder = 1
string dataobject = "d_phone_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dwnkey;integer lcv, downkey = 0, selrow, newrow
selrow = this.getselectedrow(0)


if keydown(keyuparrow!) or keydown(keydownarrow!) then
	if keydown(keyuparrow!) then
		if selrow = 0 or selrow = 1 then
			newrow = this.rowcount()
		else
			newrow = selrow - 1
		end if
	else
		if selrow = 0 or selrow = this.rowcount() then
			newrow = 1
		else 
			newrow = selrow + 1
		end if
	end if
	this.selectrow(0, false)
	this.selectrow(newrow, true)
	this.scrolltorow(newrow)
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


selrow = this.getselectedrow(0)
if selrow = 0 or isnull(selrow) then goto bigloop
ln = this.getitemstring(selrow, "em_ln")

if downkey = asc(ln) then
	newrow = 0
	if selrow = this.rowcount() then 
		goto bigloop
	elseif left(this.getitemstring(selrow + 1, "em_ln"), 1) = left(ln, 1) then
		newrow = selrow + 1
	else
		if selrow = 1 then return
		newrow = 0
		for lcv = 1 to selrow
			if left(this.getitemstring(lcv, "em_ln"), 1) = left(ln, 1) and &
			lcv <> selrow then 
					newrow = lcv
					exit
			end if
		next
		if newrow = 0 then return
	end if
	this.selectrow(0, false)
	this.selectrow(newrow, true)
	this.scrolltorow(newrow)
	return
end if

bigloop:
setnull(oldl)		
tempnewrow = 1
newrow = 0

for lcv = 1 to this.rowcount()
	templ = left(this.getitemstring(lcv, "em_ln"), 1)
	if asc(templ) < downkey then tempnewrow = lcv
	if templ <> oldl or isnull(oldl) then 
		oldl = templ
	else
		continue
	end if
	if asc(oldl) = downkey then newrow = lcv
next
if newrow = 0 and tempnewrow > 0 then newrow = tempnewrow

if newrow = 0 then return
this.selectrow(0, false)
this.selectrow(newrow, true)
this.scrolltorow(newrow)
		
end event

event clicked;if row = 0 then return

this.selectrow(0, false)
this.selectrow(row, true)


end event

event dberror;return 1
end event

