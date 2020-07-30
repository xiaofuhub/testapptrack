$PBExportHeader$w_text_edit.srw
$PBExportComments$PTCORE.     Text field editing window (directions, comments, etc.)
forward
global type w_text_edit from window
end type
type st_address from statictext within w_text_edit
end type
type cb_print from commandbutton within w_text_edit
end type
type rb_comments from radiobutton within w_text_edit
end type
type rb_directions from radiobutton within w_text_edit
end type
type dw_address from datawindow within w_text_edit
end type
type rb_billing from radiobutton within w_text_edit
end type
type rb_primary from radiobutton within w_text_edit
end type
type st_textfor from statictext within w_text_edit
end type
type cb_cancel from commandbutton within w_text_edit
end type
type cb_ok from commandbutton within w_text_edit
end type
type st_instruct from statictext within w_text_edit
end type
type gb_address from groupbox within w_text_edit
end type
type mle_text_edit2 from multilineedit within w_text_edit
end type
type mle_text_edit from multilineedit within w_text_edit
end type
end forward

global type w_text_edit from window
integer x = 1079
integer y = 356
integer width = 1495
integer height = 1276
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 12632256
st_address st_address
cb_print cb_print
rb_comments rb_comments
rb_directions rb_directions
dw_address dw_address
rb_billing rb_billing
rb_primary rb_primary
st_textfor st_textfor
cb_cancel cb_cancel
cb_ok cb_ok
st_instruct st_instruct
gb_address gb_address
mle_text_edit2 mle_text_edit2
mle_text_edit mle_text_edit
end type
global w_text_edit w_text_edit

type variables
protected:
integer which_field
long id_to_display
string oldstr, oldstr2
end variables

event open;n_cst_Privileges	lnv_Privileges
String	ls_MessageHeader, &
			ls_Message

double passedval
passedval = message.doubleparm
n_cst_numerical lnv_numerical

if passedval = -25 then
	this.title = "Modification Log"
	st_instruct.text = "Mod Log for:"
	st_textfor.text = g_tempstr
	mle_text_edit.text = g_tempstr2
	mle_text_edit.displayonly = true
	cb_cancel.enabled = false
	cb_ok.setfocus()
	return
end if

id_to_display = truncate(passedval / 100, 0)
which_field = passedval - (id_to_display * 100)

if lnv_numerical.of_IsNullOrNotPos ( id_to_display ) then
	messagebox("Edit Text Field", "Could not identify text to display.")
	close(this)
	return
end if

setpointer(hourglass!)
dw_address.settransobject(sqlca)

string readstr1, readstr2

choose case which_field
	case 1, 2
		this.title = "Company Address / Directions / Comments"
		this.y = 253
		this.height = 1901
		mle_text_edit.height = 753
		mle_text_edit2.height = 753
		mle_text_edit.y = 1029
		mle_text_edit2.y = 1029
		if which_field = 2 then
			mle_text_edit.visible = false
			mle_text_edit2.visible = true
			rb_comments.checked = true
		end if
		st_instruct.visible = false
		st_textfor.visible = false
		dw_address.visible = true
		st_address.visible = true
		rb_primary.visible = true
		rb_billing.visible = true
		rb_directions.visible = true
		rb_comments.visible = true
		cb_print.visible = true
		select co_directions, co_comments into :oldstr, :oldstr2 
			from companies where co_id = :id_to_display ;
	case 7, 8
		this.title = "Company Directions / Comments"
		mle_text_edit.height = 785
		mle_text_edit2.height = 785
		mle_text_edit.y = 349
		mle_text_edit2.y = 349
		if which_field = 8 then
			mle_text_edit.visible = false
			mle_text_edit2.visible = true
			rb_comments.checked = true
		end if
		rb_directions.y = 249
		rb_comments.y = 249
		st_instruct.visible = false
		rb_directions.visible = true
		rb_comments.visible = true
		cb_print.visible = true
		select co_name, co_directions, co_comments into :readstr1, :oldstr, :oldstr2 
			from companies where co_id = :id_to_display ;
	case 3
		this.title = "Contact Comments"
		st_instruct.text = "Comments for:"
		select ct_fn, ct_ln, ct_comments into :readstr1, :readstr2, :oldstr 
			from contacts where ct_id = :id_to_display ;
		if len(trim(readstr1)) + len(trim(readstr2)) > 0 then readstr1 = readstr1 &
			else readstr1 = "[Unspecified]"
	CASE 4
		IF lnv_Privileges.of_Employee_EditNotes ( ) = FALSE THEN
			ls_MessageHeader = "Edit Employee Notes"
			ls_Message = lnv_Privileges.of_GetRestrictMessage ( )
			MessageBox ( ls_MessageHeader, ls_Message )
			Close ( This )
			RETURN
		END IF

		This.Title = "Employee Notes"
		st_Instruct.Text = "Notes for:"
		SELECT em_fn, em_ln, em_comments INTO :readstr1, :readstr2, :oldstr 
		FROM employees WHERE em_id = :id_to_display ;
	CASE 5
		IF lnv_Privileges.of_Employee_EditRestrictedNotes ( ) = FALSE THEN
			ls_MessageHeader = "Edit Administrative Employee Notes"
			ls_Message = lnv_Privileges.of_GetRestrictMessage ( )
			MessageBox ( ls_MessageHeader, ls_Message )
			Close ( This )
			RETURN
		END IF

		This.Title = "Employee Notes"
		st_Instruct.Text = "Administrative Notes for:"
		SELECT em_fn, em_ln, em_restrictedcomments INTO :readstr1, :readstr2, :oldstr 
		FROM employees WHERE em_id = :id_to_display ;
	case 9, 10
		this.title = "Company Address"
		this.height = 1033
		mle_text_edit.visible = false
		st_instruct.visible = false
		st_textfor.visible = false
		dw_address.visible = true
		st_address.visible = true
		rb_primary.visible = true
		rb_billing.visible = true
	case else
		messagebox("Edit Text Field", "Could not identify text to display.")
		close(this)
		return
end choose

if sqlca.sqlcode <> 0 then goto failure

choose case which_field
	case 1, 2, 9, 10
		if dw_address.retrieve(id_to_display) < 1 then goto failure
	case 7, 8
		if dw_address.importstring(g_tempstr) <> 1 then goto failure
end choose

commit ;

choose case which_field
	case 1, 2, 9, 10
		if dw_address.getitemstring(1, "co_bill_same") = "T" then
			rb_billing.enabled = false
		elseif which_field = 10 then
			rb_billing.checked = true
//			rb_primary.checked = false
			dw_address.modify("txt_disp_ind.text = 'B'")
			dw_address.setredraw(true)
		end if
		if which_field > 8 then cb_cancel.enabled = false  //for 9 and 10
//	case 
//		mle_text_edit.displayonly = true
//		mle_text_edit.backcolor = 12648447
end choose


if len(trim(readstr1)) > 0 then readstr1 = trim(readstr1) + " "
st_textfor.text = readstr1 + readstr2

mle_text_edit.text = oldstr
mle_text_edit2.text = oldstr2

if mle_text_edit.visible then
	mle_text_edit.setfocus()
elseif mle_text_edit2.visible then
	mle_text_edit2.setfocus()
else
	cb_ok.setfocus()
end if

return

failure:

rollback ;
messagebox(this.title, "Could not retrieve information from database -- please retry.")
close(this)
end event

on w_text_edit.create
this.st_address=create st_address
this.cb_print=create cb_print
this.rb_comments=create rb_comments
this.rb_directions=create rb_directions
this.dw_address=create dw_address
this.rb_billing=create rb_billing
this.rb_primary=create rb_primary
this.st_textfor=create st_textfor
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_instruct=create st_instruct
this.gb_address=create gb_address
this.mle_text_edit2=create mle_text_edit2
this.mle_text_edit=create mle_text_edit
this.Control[]={this.st_address,&
this.cb_print,&
this.rb_comments,&
this.rb_directions,&
this.dw_address,&
this.rb_billing,&
this.rb_primary,&
this.st_textfor,&
this.cb_cancel,&
this.cb_ok,&
this.st_instruct,&
this.gb_address,&
this.mle_text_edit2,&
this.mle_text_edit}
end on

on w_text_edit.destroy
destroy(this.st_address)
destroy(this.cb_print)
destroy(this.rb_comments)
destroy(this.rb_directions)
destroy(this.dw_address)
destroy(this.rb_billing)
destroy(this.rb_primary)
destroy(this.st_textfor)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_instruct)
destroy(this.gb_address)
destroy(this.mle_text_edit2)
destroy(this.mle_text_edit)
end on

type st_address from statictext within w_text_edit
boolean visible = false
integer x = 46
integer y = 164
integer width = 247
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Address:"
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_text_edit
boolean visible = false
integer x = 41
integer y = 28
integer width = 457
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print Directions"
end type

on clicked;rb_primary.checked = true
dw_address.modify("txt_disp_ind.text = 'P'")
dw_address.setredraw(true)

long pj
integer choice, result, textlen, textloop, prevline, curline
string printstr

textlen = len(mle_text_edit.text)

do
	pj = printopen("Directions")
	if pj = -1 then
		choice = messagebox("Print Directions", "Could not open print job -- Retry?", &
			question!, retrycancel!, 1)
	else
		result = printdefinefont(pj, 1, "Arial", -18, 400, Default!, AnyFont!, false, false)
		if result = -1 then goto finish_attempt
		result = printsetfont(pj, 1)
		if result = -1 then goto finish_attempt
		result = print(pj, "DIRECTIONS TO:")
		if result = -1 then goto finish_attempt
		result = print(pj, " ")
		if result = -1 then goto finish_attempt
		printstr = dw_address.getitemstring(1, "co_name")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = dw_address.getitemstring(1, "co_addr1")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = dw_address.getitemstring(1, "co_addr2")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = dw_address.getitemstring(1, "comp_loc")
		if len(trim(printstr)) > 0 then result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		result = print(pj, " ")
		if result = -1 then goto finish_attempt
		printstr = "TEL1:~t" + dw_address.getitemstring(1, "comp_phone1")
		result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = "TEL2:~t" + dw_address.getitemstring(1, "comp_phone2")
		result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		printstr = "FAX:~t~t" + dw_address.getitemstring(1, "comp_fax")
		result = print(pj, printstr)
		if result = -1 then goto finish_attempt
		result = print(pj, " ")
		if result = -1 then goto finish_attempt
		prevline = 0
		if textlen > 0 then
			for textloop = 1 to textlen
				mle_text_edit.selecttext(textloop, 0)
				curline = mle_text_edit.selectedline()
				if curline > prevline then result = print(pj, mle_text_edit.textline())
				if result = -1 then exit
				prevline = curline
			next
		end if
		finish_attempt:
		if result = -1 then
			printcancel(pj)
			choice = messagebox("Print Directions", "Error attempting to print -- "+&
				"Retry?", question!, retrycancel!, 1)
		else
			result = printclose(pj)
			if result = -1 then
				printcancel(pj)
				choice = messagebox("Print Directions", "Error attempting to print -- "+&
					"Retry?", question!, retrycancel!, 1)
			end if
		end if
	end if
loop until result = 1 or choice = 2
end on

type rb_comments from radiobutton within w_text_edit
boolean visible = false
integer x = 754
integer y = 940
integer width = 389
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Comments"
end type

on clicked;if mle_text_edit2.visible = false then
	mle_text_edit.visible = false
	mle_text_edit2.visible = true
end if

mle_text_edit2.setfocus()
end on

type rb_directions from radiobutton within w_text_edit
boolean visible = false
integer x = 41
integer y = 940
integer width = 690
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Directions (to Primary)"
boolean checked = true
end type

on clicked;if mle_text_edit.visible = false then
	mle_text_edit2.visible = false
	mle_text_edit.visible = true
end if

mle_text_edit.setfocus()
end on

type dw_address from datawindow within w_text_edit
boolean visible = false
integer x = 41
integer y = 248
integer width = 1376
integer height = 648
string dataobject = "d_co_address"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Constant String	cs_State_PRE16 =		"Alberta~tAB/" +&
													"British Columbia~tBC/" +&
													"Manitoba~tMB/" +&
													"New Brunswick~tNB/" +&
													"Newfoundland~tNF/" +&
													"Northwest Territories~tNT/" +&
													"Nova Scotia~tNS/" +&
													"Ontario~tON/" +&
													"Prince Edward Island~tPE/" +&
													"Quebec~tPQ/" +&
													"Saskatchewan~tSK/" +&
													"Yukon~tYK/" +&
													"Mexico~tMX/"


Constant String	cs_State_POST15 =		"Alberta~tAB/" +&
													"British Columbia~tBC/" +&
													"Manitoba~tMB/" +&
													"New Brunswick~tNB/" +&
													"Newfoundland and Labrador~tNL/" +&
													"Northwest Territories~tNT/" +&
													"Nova Scotia~tNS/" +&
													"Nunavut~tNU/" +&
													"Ontario~tON/" +&
													"Prince Edward Island~tPE/" +&
													"Quebec~tQC/" +&
													"Saskatchewan~tSK/" +&
													"Yukon~tYT/" +&
													"Mexico~tMX/"

string	ls_ProductVersion, &
			ls_ValueList
			
n_cst_trip	lnv_trip
n_cst_routing	lnv_routing

//need PCMiler version
lnv_trip = create n_cst_trip

if lnv_trip.of_isconnected() then
	if lnv_trip.of_connect(lnv_routing) then
		if lnv_routing.of_isvalid() then
			ls_productversion=lnv_routing.of_about("ProductVersion")
		end if	
	end if
end if

destroy lnv_trip

//depending on PCMiler version
choose case ls_productversion
	case "11.0", "12.0", "2000.0", "14.0", "15.0"
		ls_ValueList = cs_State_PRE16
		
	case else//"16.0", "17.0", "18.0" etc..
		ls_ValueList = cs_State_Post15
		
end choose

this.Dynamic Modify ( 'co_state' + "." + "Edit.CodeTable = Yes" )
this.Dynamic Modify ( 'co_state' + "." + ls_ValueList )

this.Dynamic Modify ( 'co_bill_state' + "." + "Edit.CodeTable = Yes" )
this.Dynamic Modify ( 'co_bill_state' + "." + ls_ValueList )



end event

type rb_billing from radiobutton within w_text_edit
boolean visible = false
integer x = 626
integer y = 160
integer width = 238
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Billing"
end type

on clicked;dw_address.modify("txt_disp_ind.text = 'B'")
dw_address.setredraw(true)
end on

type rb_primary from radiobutton within w_text_edit
boolean visible = false
integer x = 302
integer y = 160
integer width = 288
integer height = 72
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Primary"
boolean checked = true
end type

on clicked;if rb_billing.enabled then
	dw_address.modify("txt_disp_ind.text = 'P'")
	dw_address.setredraw(true)
end if
end on

type st_textfor from statictext within w_text_edit
integer x = 41
integer y = 144

integer width = 1371
integer height = 72
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

type cb_cancel from commandbutton within w_text_edit
integer x = 1166
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

on clicked;close(parent)
end on

type cb_ok from commandbutton within w_text_edit
integer x = 887
integer y = 28
integer width = 247
integer height = 88
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
end type

event clicked;if which_field > 8 then goto closeit

string newstr, newstr2
newstr = mle_text_edit.text
if len(trim(newstr)) < 1 then setnull(newstr)
newstr2 = mle_text_edit2.text
if len(trim(newstr2)) < 1 then setnull(newstr2)

boolean one_mod, two_mod

if not (newstr = oldstr or (isnull(newstr) and isnull(oldstr))) then one_mod = true
if not (newstr2 = oldstr2 or (isnull(newstr2) and isnull(oldstr2))) then two_mod = true

choose case which_field
	case 1, 2, 7, 8
		if not (one_mod or two_mod) then goto closeit
	case else
		if not one_mod then goto closeit
end choose

choose case which_field
	case 1, 2, 7, 8
		if one_mod then
			update companies set co_directions = :newstr where co_id = :id_to_display ;
		end if
		if two_mod then
			update companies set co_comments = :newstr2 where co_id = :id_to_display ;
		end if
	case 3
		update contacts set ct_comments = :newstr where ct_id = :id_to_display ;
	case 4
		update employees set em_comments = :newstr where em_id = :id_to_display ;
	case 5
		update employees set em_restrictedcomments = :newstr where em_id = :id_to_display ;
	case else
		goto closeit
end choose

IF SQLCA.SQLCode = 0 AND SQLCA.SQLNRows = 1 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
	if messagebox(parent.title, "Could not save changes to database.  Press OK "+&
		"to close window without saving, or Cancel to return.", exclamation!, &
		okcancel!, 2) = 2 then return
END IF

closeit:
close(parent)
end event

type st_instruct from statictext within w_text_edit
integer x = 41
integer y = 44
integer width = 805
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Text for:"
boolean focusrectangle = false
end type

type gb_address from groupbox within w_text_edit
boolean visible = false
integer x = 293
integer y = 124
integer width = 603
integer height = 116
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
end type

type mle_text_edit2 from multilineedit within w_text_edit
boolean visible = false
integer x = 41
integer y = 248
integer width = 1376
integer height = 884
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Univers Condensed"
long textcolor = 33554432
boolean vscrollbar = true
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
boolean hideselection = false
boolean ignoredefaultbutton = true
end type

type mle_text_edit from multilineedit within w_text_edit
integer x = 41
integer y = 248
integer width = 1376
integer height = 884
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Univers Condensed"
long textcolor = 33554432
boolean vscrollbar = true
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
boolean hideselection = false
boolean ignoredefaultbutton = true
end type

