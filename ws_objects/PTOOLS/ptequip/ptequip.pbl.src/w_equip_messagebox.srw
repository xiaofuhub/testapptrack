$PBExportHeader$w_equip_messagebox.srw
forward
global type w_equip_messagebox from w_response
end type
type st_message from statictext within w_equip_messagebox
end type
type cb_ok from commandbutton within w_equip_messagebox
end type
type rb_deactiveunlink from radiobutton within w_equip_messagebox
end type
type rb_unlink from radiobutton within w_equip_messagebox
end type
type rb_changeref from radiobutton within w_equip_messagebox
end type
end forward

global type w_equip_messagebox from w_response
integer x = 214
integer y = 221
integer width = 1435
integer height = 660
string title = "Equipment Reference Validation"
boolean controlmenu = false
long backcolor = 12632256
event ue_close ( )
st_message st_message
cb_ok cb_ok
rb_deactiveunlink rb_deactiveunlink
rb_unlink rb_unlink
rb_changeref rb_changeref
end type
global w_equip_messagebox w_equip_messagebox

type variables
Constant String	cs_unlink = "UNLINK"
Constant String	cs_deactivateUnlink = "DEACTIVATEUNLINK"
Constant String	cs_changeRef = "CHANGEREF"
end variables

event ue_close();n_cst_msg	lnv_msg
s_parm		lstr_parm
STring		ls_value

IF rb_deactiveunlink.checked THEN
	ls_value = cs_deactivateUnlink
ELSEIF rb_unlink.checked THEN
	ls_value = cs_unlink
ELSEIF rb_changeref.checked THEN
	ls_value = cs_changeRef
ELSE
	ls_value = cs_changeRef
END IF

lstr_parm.is_label = "SELECTION"
lstr_parm.ia_value = ls_value 

lnv_msg.of_add_parm( lstr_parm )
closewithreturn( this, lnv_msg )
end event

on w_equip_messagebox.create
int iCurrent
call super::create
this.st_message=create st_message
this.cb_ok=create cb_ok
this.rb_deactiveunlink=create rb_deactiveunlink
this.rb_unlink=create rb_unlink
this.rb_changeref=create rb_changeref
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_message
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.rb_deactiveunlink
this.Control[iCurrent+4]=this.rb_unlink
this.Control[iCurrent+5]=this.rb_changeref
end on

on w_equip_messagebox.destroy
call super::destroy
destroy(this.st_message)
destroy(this.cb_ok)
destroy(this.rb_deactiveunlink)
destroy(this.rb_unlink)
destroy(this.rb_changeref)
end on

event open;call super::open;this.of_setBase( true )
inv_base.of_center( )

n_cst_msg	lnv_msg
s_parm lstr_parm

Boolean	lb_allowUnlink
Boolean	lb_allowDeactivate

IF isValid( message.powerobjectparm ) THEN
	IF message.powerObjectparm.classname() = "n_cst_msg" THEN
		lnv_msg = message.powerObjectparm
		
		IF lnv_msg.of_get_parm( "DEACTIVATE", lstr_parm )  > 0 THEN
			lb_allowDeactivate = lstr_parm.ia_value
		END IF
		
		IF lnv_msg.of_get_parm( "UNLINK", lstr_parm )  > 0 THEN
			lb_allowUnlink = lstr_parm.ia_value
		END IF
	END IF
END IF

rb_deactiveunlink.enabled = lb_allowDeactivate AND lb_allowUnlink
rb_unlink.enabled = lb_allowUnlink



end event

event close;call super::close;this.event ue_close()
end event

type cb_help from w_response`cb_help within w_equip_messagebox
boolean visible = false
end type

type st_message from statictext within w_equip_messagebox
integer x = 187
integer y = 32
integer width = 1120
integer height = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "The entered value is not a valid reference number.   What did you want to do?"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_equip_messagebox
event ue_close ( )
integer x = 553
integer y = 436
integer width = 343
integer height = 100
integer taborder = 10
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

event clicked;close(parent)
end event

type rb_deactiveunlink from radiobutton within w_equip_messagebox
integer x = 357
integer y = 176
integer width = 846
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Deactivate and Unlink Equipment"
end type

type rb_unlink from radiobutton within w_equip_messagebox
integer x = 357
integer y = 260
integer width = 562
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Unlink Equipment"
end type

type rb_changeref from radiobutton within w_equip_messagebox
integer x = 357
integer y = 344
integer width = 713
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Change Reference Number"
boolean checked = true
end type

