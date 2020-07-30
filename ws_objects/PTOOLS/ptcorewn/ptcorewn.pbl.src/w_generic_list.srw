$PBExportHeader$w_generic_list.srw
forward
global type w_generic_list from Window
end type
type cb_cancel from commandbutton within w_generic_list
end type
type cb_select from commandbutton within w_generic_list
end type
type dw_items from datawindow within w_generic_list
end type
end forward

global type w_generic_list from Window
int X=1852
int Y=325
int Width=1075
int Height=1249
boolean TitleBar=true
string Title="Item Selection"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_cancel cb_cancel
cb_select cb_select
dw_items dw_items
end type
global w_generic_list w_generic_list

type variables
protected:
s_emp_info item_info
boolean winisclosing
datastore ds_items
end variables

event open;ds_items = message.powerobjectparm

this.x = 1852	
this.y = 325

if ds_items.rowcount() > 0 then &
	dw_items.object.data.primary = ds_items.object.data.primary

item_info.em_fn = ""
item_info.em_ln = ""
item_info.em_id = null_long
winisclosing = false

dw_items.setfocus()


end event

on w_generic_list.create
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_items=create dw_items
this.Control[]={ this.cb_cancel,&
this.cb_select,&
this.dw_items}
end on

on w_generic_list.destroy
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_items)
end on

event closequery;if winisclosing = false then
	cb_cancel.event post clicked()
	return 1
end if
end event

event close;//destroy ds_items
end event

type cb_cancel from commandbutton within w_generic_list
int X=773
int Y=41
int Width=247
int Height=89
int TabOrder=20
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;item_info.em_ln = ""
item_info.em_id = null_long
winisclosing = true
closewithreturn(parent, item_info)

end event

type cb_select from commandbutton within w_generic_list
int X=494
int Y=41
int Width=247
int Height=89
int TabOrder=10
string Text="Select"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer selrow
selrow = dw_items.getselectedrow(0)
if selrow <= 0 then 
	item_info.em_ln = ""
	item_info.em_id = null_long
	return
else	
	item_info.em_ln = dw_items.getitemstring(selrow, "name")
	item_info.em_id = dw_items.getitemnumber(selrow, "id")
end if
winisclosing = true
closewithreturn(parent, item_info)

end event

type dw_items from datawindow within w_generic_list
event downkey pbm_dwnkey
int X=37
int Y=157
int Width=983
int Height=977
int TabOrder=30
string DataObject="d_generic_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event downkey;integer lcv, downkey, selrow, newrow
integer tempnewrow
string curname, tempname, oldname

selrow = getselectedrow(0)

if keydown(keyuparrow!) or keydown(keydownarrow!) then
	if keydown(keyuparrow!) then
		if selrow = 0 or selrow = 1 then
			newrow = rowcount()
		else
			newrow = selrow - 1
		end if
	else
		if selrow = 0 or selrow = rowcount() then
			newrow = 1
		else 
			newrow = selrow + 1
		end if
	end if
	selectrow(0, false)
	selectrow(newrow, true)
	scrolltorow(newrow)
	return
end if
	
for lcv = 65 to 90 	
	if keydown(lcv) then
		downkey = lcv
		exit
	end if
next

if downkey = 0 then return 


selrow = this.getselectedrow(0)
if selrow = 0 or isnull(selrow) then goto bigloop
curname = getitemstring(selrow, "name")

if downkey = asc(curname) then
	newrow = 0
	if selrow = this.rowcount() then 
		goto bigloop
	elseif left(getitemstring(selrow + 1, "name"), 1) = left(curname, 1) then
		newrow = selrow + 1
	else
		if selrow = 1 then return
		newrow = 0
		for lcv = 1 to selrow
			if left(this.getitemstring(lcv, "name"), 1) = left(curname, 1) and &
			lcv <> selrow then 
					newrow = lcv
					exit
			end if
		next
		if newrow = 0 then return
	end if
	selectrow(0, false)
	selectrow(newrow, true)
	scrolltorow(newrow)
	return
end if

bigloop:
setnull(oldname)		
tempnewrow = 1
newrow = 0

for lcv = 1 to this.rowcount()
	tempname = left(this.getitemstring(lcv, "name"), 1)
	if asc(tempname) < downkey then tempnewrow = lcv
	if tempname <> oldname or isnull(oldname) then 
		oldname = tempname
	else
		continue
	end if
	if asc(oldname) = downkey then newrow = lcv
next
if newrow = 0 and tempnewrow > 0 then newrow = tempnewrow

if newrow = 0 then 
	beep(1)
	return
end if
selectrow(0, false)
selectrow(newrow, true)
scrolltorow(newrow)
		
end event

event clicked;if row <= 0 then return
selectrow(0, false)
selectrow(row, True)	

end event

event dberror;return 1
end event

event doubleclicked;if row > 0 then
	selectrow(0, false)
	selectrow(row, true)
	cb_select.postevent(clicked!)
end if

end event

