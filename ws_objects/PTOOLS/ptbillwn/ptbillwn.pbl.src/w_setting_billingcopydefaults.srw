$PBExportHeader$w_setting_billingcopydefaults.srw
forward
global type w_setting_billingcopydefaults from w_response
end type
type sle_prev from singlelineedit within w_setting_billingcopydefaults
end type
type sle_cust from singlelineedit within w_setting_billingcopydefaults
end type
type sle_file from singlelineedit within w_setting_billingcopydefaults
end type
type sle_dup from singlelineedit within w_setting_billingcopydefaults
end type
type sle_off from singlelineedit within w_setting_billingcopydefaults
end type
type st_1 from statictext within w_setting_billingcopydefaults
end type
type st_2 from statictext within w_setting_billingcopydefaults
end type
type st_3 from statictext within w_setting_billingcopydefaults
end type
type st_4 from statictext within w_setting_billingcopydefaults
end type
type st_5 from statictext within w_setting_billingcopydefaults
end type
type cb_ok from commandbutton within w_setting_billingcopydefaults
end type
type cb_2 from commandbutton within w_setting_billingcopydefaults
end type
type gb_1 from groupbox within w_setting_billingcopydefaults
end type
end forward

global type w_setting_billingcopydefaults from w_response
integer x = 214
integer y = 221
integer width = 736
integer height = 788
string title = "Copy Defaults"
long backcolor = 12632256
event ue_ok ( )
sle_prev sle_prev
sle_cust sle_cust
sle_file sle_file
sle_dup sle_dup
sle_off sle_off
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
cb_ok cb_ok
cb_2 cb_2
gb_1 gb_1
end type
global w_setting_billingcopydefaults w_setting_billingcopydefaults

type variables
n_cst_setting_billprintcopies_cust			inv_cust
n_cst_setting_billprintcopies_duplicate	inv_dup
n_cst_setting_billprintcopies_file			inv_file
n_cst_setting_billprintcopies_office		inv_office
n_cst_setting_billprintcopies_prev			inv_prev
end variables

forward prototypes
public function integer of_initialize ()
public function boolean of_changedvalues ()
public function integer of_validatechanges (ref string as_errormessage)
public function integer wf_savesettings ()
end prototypes

event ue_ok();Boolean lb_userChanged
String	ls_error

Int		li_savechanges
Int		li_close

lb_userChanged = this.of_changedvalues( )


IF lb_userChanged THEN
	IF this.of_validatechanges( ls_error ) = 1 THEN
		//ask if they want to save
		li_savechanges = Messagebox( "Save Settings", "Do you want to save changes?", question!, yesno!, 1 )
		li_close = 1
	ELSE
		li_close = Messagebox( "Validation Error", "There was an error validating new settings. "+ ls_error +" Do you want to close without saving changes?", question!, yesno!,2 )
	END IF
END IF


If li_savechanges = 1 THEN
	this.wf_savesettings( )

END IF

IF li_close = 1 THEN
	close(this)
END IF
end event

public function integer of_initialize ();Int	li_Return 

sle_prev.text = inv_prev.of_getValue( )
sle_cust.text = inv_cust.of_getValue( )
sle_off.text = inv_office.of_getValue( )
sle_file.text = inv_file.of_getValue( )
sle_dup.text = inv_dup.of_getValue( )

RETURN li_return
end function

public function boolean of_changedvalues ();//returns true if the values are different then in the db

String	ls_dispvalue
String	ls_value

Boolean	lb_userChanged

ls_dispValue = sle_prev.text
ls_value = inv_prev.of_getValue()
IF ls_dispvalue <> ls_value THEN
	lb_userChanged = true
END IF

IF not lb_userChanged THEN
	ls_dispValue = sle_cust.text
	ls_value = inv_cust.of_getValue()
	IF ls_dispvalue <> ls_value THEN
		lb_userChanged = true
	END IF
END IF

IF not lb_userChanged THEN
	ls_dispValue = sle_off.text
	ls_value = inv_office.of_getValue()
	IF ls_dispvalue <> ls_value THEN
		lb_userChanged = true
	END IF
END IF

IF not Lb_userChanged THEN
	ls_dispValue = sle_file.text
	ls_value = inv_file.of_getValue()
	IF ls_dispvalue <> ls_value THEN
		lb_userChanged = true
	END IF
END IF

IF not lb_userChanged THEN
	ls_dispValue = sle_dup.text
	ls_value = inv_dup.of_getValue()
	IF ls_dispvalue <> ls_value THEN
		lb_userChanged = true
	END IF
END IF

RETURN lb_userChanged

end function

public function integer of_validatechanges (ref string as_errormessage);Int	li_return = 1
String ls_message

IF IsNumber( sle_prev.text ) THEN
	IF long( sle_prev.text ) >= 0 THEN
		//ok
	ELSE
		li_return = -1
		ls_message = "Preview copies must be a number greater then or equal to 0."
	END IF
ELSE
	li_Return = -1
	ls_message = "Preview copies must be a number greater then or equal to 0."
END IF

IF li_Return = 1 THEN
	IF IsNumber( sle_cust.text ) THEN
		IF long( sle_cust.text ) >= 0 THEN
			//ok
		ELSE
			li_return = -1
			ls_message = "Customer copies must be a number greater then or equal to 0."
		END IF
	ELSE
		li_return = -1
		ls_message = "Customer copies must be a number greater then or equal to 0."
	END IF
END IF


IF li_Return = 1 THEN
	IF IsNumber( sle_Off.text ) THEN
		IF long( sle_Off.text ) >= 0 THEN
			//ok
		ELSE
			li_return = -1
			ls_message = "Office copies must be a number greater then or equal to 0."
		END IF
	ELSE
		li_Return = -1
		ls_message = "Office copies must be a number greater then or equal to 0."
	END IF
END IF

IF li_Return = 1 THEN
	IF IsNumber( sle_File.text ) THEN
		IF long( sle_file.text ) >= 0 THEN
			//ok
		ELSE
			li_return = -1
			ls_message = "File copies must be a number greater then or equal to 0."
		END IF
	ELSE
		li_return = -1
		ls_message = "File copies must be a number greater then or equal to 0."
	END IF
END IF

IF li_Return = 1 THEN
	IF IsNumber( sle_dup.text ) THEN
		IF long( sle_dup.text ) >= 0 THEN
			//ok
		ELSE
			li_return = -1
			ls_message = "Duplicate copies must be a number greater then or equal to 0."
		END IF
	ELSE
		ls_message = "Duplicate copies must be a number greater then or equal to 0."
		li_Return = -1
	END IF
END IF

as_errormessage = ls_message

RETURN li_return
end function

public function integer wf_savesettings ();Int	li_return = 1

inv_prev.of_savevalue( sle_prev.text )
inv_cust.of_savevalue( sle_cust.text )
inv_office.of_savevalue( sle_off.text )
inv_file.of_savevalue( sle_file.text )
inv_dup.of_savevalue( sle_dup.text )

RETURN li_Return 
end function

on w_setting_billingcopydefaults.create
int iCurrent
call super::create
this.sle_prev=create sle_prev
this.sle_cust=create sle_cust
this.sle_file=create sle_file
this.sle_dup=create sle_dup
this.sle_off=create sle_off
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.cb_ok=create cb_ok
this.cb_2=create cb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_prev
this.Control[iCurrent+2]=this.sle_cust
this.Control[iCurrent+3]=this.sle_file
this.Control[iCurrent+4]=this.sle_dup
this.Control[iCurrent+5]=this.sle_off
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.cb_ok
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.gb_1
end on

on w_setting_billingcopydefaults.destroy
call super::destroy
destroy(this.sle_prev)
destroy(this.sle_cust)
destroy(this.sle_file)
destroy(this.sle_dup)
destroy(this.sle_off)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.cb_ok)
destroy(this.cb_2)
destroy(this.gb_1)
end on

event open;call super::open;this.of_setbase( true )

inv_base.of_center()
inv_cust = create n_cst_setting_billprintcopies_cust
inv_dup = create n_cst_setting_billprintcopies_duplicate
inv_file = create n_cst_setting_billprintcopies_file
inv_office = create n_cst_setting_billprintcopies_office
inv_prev = create n_cst_setting_billprintcopies_prev	

this.of_initialize( )
end event

event close;call super::close;destroy inv_cust 
destroy inv_dup 
destroy inv_file 
destroy inv_office 
destroy inv_prev 
end event

type cb_help from w_response`cb_help within w_setting_billingcopydefaults
boolean visible = false
boolean enabled = false
end type

type sle_prev from singlelineedit within w_setting_billingcopydefaults
integer x = 105
integer y = 76
integer width = 142
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
borderstyle borderstyle = stylelowered!
end type

event getfocus;THIS.SElecttext( 1, 100)
end event

type sle_cust from singlelineedit within w_setting_billingcopydefaults
integer x = 105
integer y = 164
integer width = 142
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
borderstyle borderstyle = stylelowered!
end type

event getfocus;THIS.SElecttext( 1, 100)
end event

type sle_file from singlelineedit within w_setting_billingcopydefaults
integer x = 105
integer y = 340
integer width = 142
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
borderstyle borderstyle = stylelowered!
end type

event getfocus;THIS.SElecttext( 1, 100)
end event

type sle_dup from singlelineedit within w_setting_billingcopydefaults
integer x = 105
integer y = 428
integer width = 142
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
borderstyle borderstyle = stylelowered!
end type

event getfocus;THIS.SElecttext( 1, 100)
end event

type sle_off from singlelineedit within w_setting_billingcopydefaults
integer x = 105
integer y = 252
integer width = 142
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "0"
borderstyle borderstyle = stylelowered!
end type

event getfocus;THIS.SElecttext( 1, 100)
end event

type st_1 from statictext within w_setting_billingcopydefaults
integer x = 306
integer y = 80
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Preview"
boolean focusrectangle = false
end type

type st_2 from statictext within w_setting_billingcopydefaults
integer x = 306
integer y = 180
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Customer"
boolean focusrectangle = false
end type

type st_3 from statictext within w_setting_billingcopydefaults
integer x = 306
integer y = 268
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Office"
boolean focusrectangle = false
end type

type st_4 from statictext within w_setting_billingcopydefaults
integer x = 306
integer y = 356
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "File"
boolean focusrectangle = false
end type

type st_5 from statictext within w_setting_billingcopydefaults
integer x = 306
integer y = 440
integer width = 343
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Duplicate"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_setting_billingcopydefaults
integer x = 41
integer y = 568
integer width = 293
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
boolean default = true
end type

event clicked;parent.event ue_ok()
end event

type cb_2 from commandbutton within w_setting_billingcopydefaults
integer x = 384
integer y = 568
integer width = 293
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type gb_1 from groupbox within w_setting_billingcopydefaults
integer x = 32
integer y = 4
integer width = 649
integer height = 540
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Enter Values >= 0"
end type

