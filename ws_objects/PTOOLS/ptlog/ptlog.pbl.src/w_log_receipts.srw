$PBExportHeader$w_log_receipts.srw
$PBExportComments$PTLOG.
forward
global type w_log_receipts from window
end type
type cb_close from commandbutton within w_log_receipts
end type
type cb_delete from commandbutton within w_log_receipts
end type
type cb_add from commandbutton within w_log_receipts
end type
type dw_log_receipts from datawindow within w_log_receipts
end type
type gb_1 from groupbox within w_log_receipts
end type
type violations from structure within w_log_receipts
end type
end forward

type violations from structure
	time		rec_time
	string		rec_type
	string		actual
end type

global type w_log_receipts from window
integer x = 850
integer y = 512
integer width = 1719
integer height = 576
boolean titlebar = true
string title = "Log Receipts"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
dw_log_receipts dw_log_receipts
gb_1 gb_1
end type
global w_log_receipts w_log_receipts

type variables
protected:
date curdate
w_log w_par
integer startcount
end variables

event open;w_par = message.powerobjectparm

curdate = w_par.dw_log_list.getitemdate(w_par.dw_log_list.getselectedrow(0), "dl_date")
this.title = "Log Receipts:  " + string(curdate, "m/d/yy")

w_par.ds_receipts.sharedata(dw_log_receipts)
dw_log_receipts.setfilter("lr_date = " + string(curdate, "yyyy-mm-dd"))
dw_log_receipts.filter()
dw_log_receipts.sort()

this.x = 851
this.y = 513


startcount = dw_log_receipts.rowcount()
if dw_log_receipts.rowcount() = 0 then cb_add.postevent(clicked!)

end event

on w_log_receipts.create
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_log_receipts=create dw_log_receipts
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_delete,&
this.cb_add,&
this.dw_log_receipts,&
this.gb_1}
end on

on w_log_receipts.destroy
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_log_receipts)
destroy(this.gb_1)
end on

event close;if dw_Log_receipts.rowcount() <> startcount then 
	message.stringparm = "true"
else
	message.stringparm = "false"
end if


dw_log_receipts.setfilter("")
dw_log_receipts.filter()
dw_log_receipts.sort()



end event

event closequery;if dw_log_receipts.accepttext() = -1 then return 1 //focus is set in itemerror

Integer	li_BaseTimeZone
n_cst_LicenseManager	lnv_LicenseManager

li_BaseTimeZone = lnv_LicenseManager.of_GetBaseTimeZone ( )

integer lcv
if dw_log_receipts.modifiedcount() > 0 or dw_log_receipts.deletedcount() > 0 then
	for lcv = dw_log_receipts.rowcount() to 1 step -1
		if isnull(dw_log_receipts.getitemstring(lcv, "lr_loc")) and &
			isnull(dw_log_receipts.getitemstring(lcv, "lr_state")) and &
			isnull(dw_log_receipts.getitemtime(lcv, "lr_time")) and &
			isnull(dw_log_receipts.getitemstring(lcv, "lr_type")) then
			dw_log_receipts.deleterow(lcv)
			continue
		elseif isnull(dw_log_receipts.getitemtime(lcv, "lr_time")) then
			dw_log_receipts.setcolumn("lr_time")
			dw_log_receipts.scrolltorow(lcv)
			dw_log_receipts.setfocus()
			messagebox("Log Receipts", "All receipts must have a time.  Please enter the time.")
			return 1
		elseif isnull(dw_log_receipts.getitemstring(lcv, "lr_type")) then
			dw_log_receipts.setcolumn("lr_type")
			dw_log_receipts.scrolltorow(lcv)
			dw_log_receipts.setfocus()
			messagebox("Log Receipts", "All receipts must have a type.  Please enter the type.")
			return 1
		end if
		dw_log_receipts.setitem(lcv, "lr_num", lcv)
		dw_log_receipts.setitem(lcv, "lr_tz", li_BaseTimeZone)
		dw_log_receipts.setitem(lcv, "lr_id", w_par.cur_driver.em_id)
	next
end if


 


end event

type cb_close from commandbutton within w_log_receipts
integer x = 1317
integer y = 372
integer width = 261
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_delete from commandbutton within w_log_receipts
integer x = 1010
integer y = 372
integer width = 261
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;integer delrow
delrow = dw_log_receipts.getrow()
if delrow = 0 then return


dw_log_receipts.deleterow(delrow)



end event

type cb_add from commandbutton within w_log_receipts
integer x = 704
integer y = 372
integer width = 261
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add"
end type

event clicked;if dw_log_receipts.accepttext() = -1 then return

integer num_row

num_row = dw_log_receipts.insertrow(0)
dw_log_receipts.setitem(num_row, "lr_num", 0)
dw_log_receipts.setitem(num_row, "lr_date", curdate)
dw_log_receipts.setitem(num_row, "lr_id", w_par.cur_driver.em_id)

dw_log_receipts.setfocus()
//dw_log_receipts.setrow(num_row)
dw_log_receipts.setcolumn("lr_time")
dw_log_receipts.scrolltorow(num_row)


end event

type dw_log_receipts from datawindow within w_log_receipts
integer y = 8
integer width = 1678
integer height = 328
integer taborder = 10
string dataobject = "d_log_receipts"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemerror;n_cst_String	lnv_String
string colname
colname = trim(this.getcolumnname())

time comptime
if colname = "lr_time" then
	comptime = lnv_String.of_SpecialTime ( data )
	if not isnull(comptime) or len(trim(data)) = 0 then 
		this.setitem(row, colname, comptime)
		return 3
//	else
//		beep(1)
//		return 1
	end if
//elseif colname = "lr_state" then
//	beep(1)
//	return 1
end if

//return 1

this.selecttext(1, 999)
this.setfocus()
beep(1)
return 1

end event

event itemchanged;string colname

colname = this.getcolumnname()
if colname = "lr_loc" then
	if len(trim(data)) = 0 then setnull(data)
	if data <> trim(data) or isnull(data) then
		this.setitem(row, colname, trim(data))
		return 2
	end if
end if


end event

event itemfocuschanged;if dwo.name = "lr_type" then
	if isnull(dwo.primary[row]) then
		dw_log_receipts.object.lr_type.values = "FUEL~tF/TOLL~tT"
	end if
end if
end event

event constructor;n_cst_Presentation_State	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

end event

type gb_1 from groupbox within w_log_receipts
integer x = 9
integer y = 344
integer width = 1678
integer height = 8
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
end type

