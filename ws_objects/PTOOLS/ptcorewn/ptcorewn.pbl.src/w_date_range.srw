$PBExportHeader$w_date_range.srw
forward
global type w_date_range from window
end type
type st_2 from statictext within w_date_range
end type
type st_1 from statictext within w_date_range
end type
type cb_cancel from commandbutton within w_date_range
end type
type cb_ok from commandbutton within w_date_range
end type
type sle_2 from u_sle_date within w_date_range
end type
type sle_1 from u_sle_date within w_date_range
end type
end forward

global type w_date_range from window
integer x = 1285
integer y = 776
integer width = 859
integer height = 504
boolean titlebar = true
string title = "Date Range"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
sle_2 sle_2
sle_1 sle_1
end type
global w_date_range w_date_range

type variables

protected:
boolean ib_winisclosing

private:
boolean ib_optional
end variables

on w_date_range.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_2=create sle_2
this.sle_1=create sle_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_cancel,&
this.cb_ok,&
this.sle_2,&
this.sle_1}
end on

on w_date_range.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_2)
destroy(this.sle_1)
end on

event open;// The Date Range is Now conditionally optional. 
// the text will change depending on condition
date	ld_start, ld_end
ib_optional = TRUE
n_cst_msg 	lnv_msg
s_Parm 		lstr_Parm

IF IsValid(message.powerobjectParm) THEN
	lnv_msg = message.powerobjectParm
	IF lnv_msg.of_Get_Parm("OPTIONAL" , lstr_Parm ) <> 0 THEN
		IF ( lstr_Parm.ia_value = "FALSE" ) THEN
			ib_Optional = False
			st_1.text = "Enter Date Range:"  // not optional (changes default)

		END IF
	END IF
	IF lnv_msg.of_Get_Parm("START" , lstr_Parm ) <> 0 THEN
		ld_start = lstr_Parm.ia_value
		IF isnull(ld_start) THEN
			//skip
		else
			sle_1.text = string(ld_start, 'mm/dd/yy')
			sle_2.post setfocus()
		END IF
	END IF
	IF lnv_msg.of_Get_Parm("END" , lstr_Parm ) <> 0 THEN
		ld_end = lstr_Parm.ia_value
		IF isnull(ld_end) THEN
			//skip
		else
			sle_2.text = string(ld_end, 'mm/dd/yy')
			cb_ok.post setfocus()
		END IF
	END IF	
	IF lnv_msg.of_Get_Parm("DISABLESTART" , lstr_Parm ) <> 0 THEN
		sle_1.enabled=false
		sle_2.post setfocus()
	END IF
	IF lnv_msg.of_Get_Parm("DISABLEEND" , lstr_Parm ) <> 0 THEN
		sle_2.enabled=false
		cb_ok.post setfocus()
	END IF
	
	
END IF


sle_1.of_suspend_list_add(cb_cancel)
sle_2.of_suspend_list_add(cb_cancel)
end event

event closequery;if ib_winisclosing then
	sle_1.of_set_suspend(true)
	sle_2.of_set_suspend(true)
else
	cb_cancel.event post clicked()
	return 1
end if
end event

type st_2 from statictext within w_date_range
integer x = 379
integer y = 144
integer width = 82
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "to"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_date_range
integer x = 69
integer y = 48
integer width = 731
integer height = 76
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Enter Date Range (optional):"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_date_range
integer x = 480
integer y = 276
integer width = 247
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;s_anys lstr_return

ib_winisclosing = true

lstr_return.anys[1] = 0
lstr_return.anys[2] = null_date
lstr_return.anys[3] = null_date

closewithreturn(parent, lstr_return)
end event

type cb_ok from commandbutton within w_date_range
integer x = 114
integer y = 276
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;

//The reason I don't have &O for a shortcut is that it doesn't cause a losefocus in
//the sle, and will therefore process this script even if the sle text isn't valid.
//I didn't have time to work this out.

s_anys lstr_return
Boolean lb_Continue = TRUE
string ls_Message


IF ib_Optional THEN
	lb_Continue = TRUE
	
	lstr_return.anys[2] = sle_1.of_get_date()
	lstr_return.anys[3] = sle_2.of_get_date()
END IF

IF Not ib_Optional THEN
	
	if isNull( sle_2.of_get_date() ) OR (sle_2.of_get_date() < sle_1.of_get_date() ) THEN
		ls_message =   "Please enter a valid ending date." 
		sle_2.setFocus()
		lb_Continue = FALSE
	ELSE
		lstr_return.anys[3] = sle_2.of_get_date()
	END IF
	
	IF isNull( sle_1.of_get_date() )  THEN
		ls_message = "Please enter a valid starting date." 
		sle_1.setFocus()
		lb_Continue = FALSE	
	ELSE
		lstr_return.anys[2] = sle_1.of_get_date()
	END IF
	
END IF

ib_winisclosing = true

IF lb_Continue THEN
	lstr_return.anys[1] = 1
	closewithreturn(parent, lstr_return)
ELSE 
	BEEP(1)
	MessageBox( "Date Range" , ls_Message , EXCLAMATION! )
END IF

end event

type sle_2 from u_sle_date within w_date_range
integer x = 480
integer y = 140
integer taborder = 20
end type

type sle_1 from u_sle_date within w_date_range
integer x = 64
integer y = 140
integer taborder = 10
end type

