$PBExportHeader$w_bill_copies.srw
forward
global type w_bill_copies from w_response
end type
type cb_cancel from commandbutton within w_bill_copies
end type
type cb_ok from commandbutton within w_bill_copies
end type
type st_5 from statictext within w_bill_copies
end type
type st_4 from statictext within w_bill_copies
end type
type st_3 from statictext within w_bill_copies
end type
type st_2 from statictext within w_bill_copies
end type
type st_1 from statictext within w_bill_copies
end type
type sle_5 from singlelineedit within w_bill_copies
end type
type sle_4 from singlelineedit within w_bill_copies
end type
type sle_3 from singlelineedit within w_bill_copies
end type
type sle_2 from singlelineedit within w_bill_copies
end type
type sle_1 from singlelineedit within w_bill_copies
end type
type gb_1 from groupbox within w_bill_copies
end type
end forward

global type w_bill_copies from w_response
integer x = 1307
integer y = 764
integer width = 722
integer height = 868
string title = "Copy Selection"
long backcolor = 12632256
cb_cancel cb_cancel
cb_ok cb_ok
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
gb_1 gb_1
end type
global w_bill_copies w_bill_copies

type variables
protected:
s_longs copies
singlelineedit sle_ar[]
statictext st_ar[]

n_Cst_Msg	inv_Msg




end variables

forward prototypes
protected subroutine set_label (integer which_label)
public function integer wf_initializedefaults ()
end prototypes

protected subroutine set_label (integer which_label);if sle_ar[which_label].enabled then
	if integer(sle_ar[which_label].text) > 0 then
		st_ar[which_label].textcolor = 16711680
		st_ar[which_label].weight = 700
	else
		st_ar[which_label].textcolor = 0
		st_ar[which_label].weight = 400
	end if
end if
end subroutine

public function integer wf_initializedefaults ();Int	 li_return = 1
String	ls_value

n_cst_setting_billprintcopies_cust			lnv_cust
n_cst_setting_billprintcopies_duplicate	lnv_dup
n_cst_setting_billprintcopies_file			lnv_file
n_cst_setting_billprintcopies_office		lnv_office
n_cst_setting_billprintcopies_prev			lnv_prev



IF sle_1.enabled THEN
	lnv_prev = create n_cst_setting_billprintcopies_prev
	ls_value = lnv_prev.of_getValue()
	sle_1.text = ls_value
	DESTROY lnv_prev
END IF
IF sle_2.enabled THEN
	lnv_cust = create n_cst_setting_billprintcopies_cust
	ls_value = lnv_cust.of_getValue()
	sle_2.text = ls_value
	DESTROY lnv_cust
END IF
IF sle_3.enabled THEN
	lnv_office = create n_cst_setting_billprintcopies_office
	ls_value = lnv_office.of_getValue()
	sle_3.text = ls_value
	DESTROY lnv_office
END IF
IF sle_4.enabled THEN
	lnv_file = create n_cst_setting_billprintcopies_file
	ls_value = lnv_file.of_getValue()
	sle_4.text = ls_value
	DESTROY lnv_file
END IF
IF sle_5.enabled THEN
	lnv_dup = create n_cst_setting_billprintcopies_duplicate
	ls_value = lnv_dup.of_getValue()
	sle_5.text = ls_value
	DESTROY lnv_dup
END IF

RETURN li_Return
end function

on w_bill_copies.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_5=create sle_5
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.sle_5
this.Control[iCurrent+9]=this.sle_4
this.Control[iCurrent+10]=this.sle_3
this.Control[iCurrent+11]=this.sle_2
this.Control[iCurrent+12]=this.sle_1
this.Control[iCurrent+13]=this.gb_1
end on

on w_bill_copies.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_5)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.gb_1)
end on

event open;copies = message.powerobjectparm

THIS.of_Setbase ( TRUE ) 
inv_Base.of_Center ( )

sle_ar[1] = sle_1
sle_ar[2] = sle_2
sle_ar[3] = sle_3
sle_ar[4] = sle_4
sle_ar[5] = sle_5

st_ar[1] = st_1
st_ar[2] = st_2
st_ar[3] = st_3
st_ar[4] = st_4
st_ar[5] = st_5

integer markloop
singlelineedit sle_foc

for markloop = 1 to upperbound(copies.longar)
	if copies.longar[markloop] >= 0 then
		sle_ar[markloop].text = string(copies.longar[markloop])
		sle_ar[markloop].enabled = true
		set_label(markloop)
		if copies.longar[markloop] > 0 and not isvalid(sle_foc) then &
			sle_foc = sle_ar[markloop]
	end if
	if not isnull(copies.longar[markloop]) then copies.longar[markloop] = 0
next

if isvalid(sle_foc) then sle_foc.setfocus() else sle_ar[1].setfocus()

THis.wf_initializedefaults( )
end event

type cb_help from w_response`cb_help within w_bill_copies
end type

type cb_cancel from commandbutton within w_bill_copies
integer x = 379
integer y = 652
integer width = 279
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;n_Cst_Msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_label = "CONTINUE"
lstr_Parm.ia_value = FALSE
lnv_Msg.of_Add_Parm( lstr_Parm )


closeWithReturn (parent , lnv_Msg )
end event

type cb_ok from commandbutton within w_bill_copies
integer x = 55
integer y = 652
integer width = 279
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;n_Cst_Msg	lnv_Msg
S_Parm		lstr_Parm
integer readloop

for readloop = 1 to upperbound(copies.longar)
	if isnull(copies.longar[readloop]) then continue
	copies.longar[readloop] = integer(sle_ar[readloop].text)
next

lstr_Parm.is_label = "CONTINUE"
lstr_Parm.ia_value = TRUE
lnv_Msg.of_Add_Parm( lstr_Parm )

lstr_Parm.is_label = "COPIES"
lstr_Parm.ia_value = copies
lnv_Msg.of_Add_Parm( lstr_Parm )

closeWithReturn (parent , lnv_Msg )
end event

type st_5 from statictext within w_bill_copies
integer x = 279
integer y = 496
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 12632256
boolean enabled = false
string text = "Duplicate"
boolean focusrectangle = false
end type

type st_4 from statictext within w_bill_copies
integer x = 279
integer y = 396
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 12632256
boolean enabled = false
string text = "File"
boolean focusrectangle = false
end type

type st_3 from statictext within w_bill_copies
integer x = 279
integer y = 296
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 12632256
boolean enabled = false
string text = "Office"
boolean focusrectangle = false
end type

type st_2 from statictext within w_bill_copies
integer x = 279
integer y = 196
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 12632256
boolean enabled = false
string text = "Customer"
boolean focusrectangle = false
end type

type st_1 from statictext within w_bill_copies
integer x = 279
integer y = 96
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8421504
long backcolor = 12632256
boolean enabled = false
string text = "Preview"
boolean focusrectangle = false
end type

type sle_5 from singlelineedit within w_bill_copies
integer x = 110
integer y = 488
integer width = 142
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = "0"
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;post set_label(5)
end event

type sle_4 from singlelineedit within w_bill_copies
integer x = 110
integer y = 388
integer width = 142
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = "0"
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;post set_label(4)
end event

type sle_3 from singlelineedit within w_bill_copies
integer x = 110
integer y = 288
integer width = 142
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = "0"
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;post set_label(3)
end event

type sle_2 from singlelineedit within w_bill_copies
integer x = 110
integer y = 188
integer width = 142
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = "0"
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;post set_label(2)
end event

type sle_1 from singlelineedit within w_bill_copies
integer x = 110
integer y = 88
integer width = 142
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = "0"
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;this.selecttext(1, len(this.text))
end event

event modified;post set_label(1)
end event

type gb_1 from groupbox within w_bill_copies
integer x = 55
integer y = 16
integer width = 603
integer height = 588
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

