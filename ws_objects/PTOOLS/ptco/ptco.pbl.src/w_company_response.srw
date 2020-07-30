$PBExportHeader$w_company_response.srw
forward
global type w_company_response from w_company
end type
type cb_ok from commandbutton within w_company_response
end type
type cb_cancel from commandbutton within w_company_response
end type
type cb_save from commandbutton within w_company_response
end type
end forward

global type w_company_response from w_company
integer height = 1952
string menuname = ""
boolean minbox = false
boolean maxbox = false
windowtype windowtype = response!
event ue_close ( )
event ue_ok ( )
event ue_save ( )
event ue_key ( )
cb_ok cb_ok
cb_cancel cb_cancel
cb_save cb_save
end type
global w_company_response w_company_response

event ue_close();winisclosing = True
Close(This)
end event

event ue_ok();Close(This)
end event

event ue_save();This.Save()
end event

on w_company_response.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_save
end on

on w_company_response.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_save)
end on

event close;call super::close;Message.DoubleParm = co_to_display
end event

event open;call super::open;cb_delco.Visible = FALSE
cb_replace.Visible = FALSE


end event

event key;call super::key;IF Keyflags = 2 AND key = KeyS!THEN
	This.Event ue_Save()
END IF
end event

type cb_lanes from w_company`cb_lanes within w_company_response
end type

type cb_details from w_company`cb_details within w_company_response
end type

type cb_nofac from w_company`cb_nofac within w_company_response
end type

type cb_makefac from w_company`cb_makefac within w_company_response
end type

type cb_replace from w_company`cb_replace within w_company_response
end type

type dw_car_info from w_company`dw_car_info within w_company_response
end type

type st_2 from w_company`st_2 within w_company_response
end type

type cb_delfac from w_company`cb_delfac within w_company_response
end type

type cb_newfac from w_company`cb_newfac within w_company_response
end type

type st_1 from w_company`st_1 within w_company_response
end type

type dw_facility_list from w_company`dw_facility_list within w_company_response
end type

type cb_selco from w_company`cb_selco within w_company_response
end type

type cb_delco from w_company`cb_delco within w_company_response
end type

type cb_delct from w_company`cb_delct within w_company_response
end type

type cb_newct from w_company`cb_newct within w_company_response
end type

type cb_newco from w_company`cb_newco within w_company_response
end type

type dw_co_info from w_company`dw_co_info within w_company_response
end type

type dw_facility_details from w_company`dw_facility_details within w_company_response
end type

type dw_contacts from w_company`dw_contacts within w_company_response
end type

type cb_car_ct from w_company`cb_car_ct within w_company_response
end type

type cb_ok from commandbutton within w_company_response
integer x = 2734
integer y = 1736
integer width = 402
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;Parent.Event ue_OK()
end event

type cb_cancel from commandbutton within w_company_response
integer x = 3191
integer y = 1736
integer width = 402
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;Parent.Event ue_Close()
end event

type cb_save from commandbutton within w_company_response
integer x = 2277
integer y = 1736
integer width = 402
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;Parent.Event ue_Save()
end event

