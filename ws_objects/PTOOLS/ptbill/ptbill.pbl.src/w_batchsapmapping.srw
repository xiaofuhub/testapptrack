$PBExportHeader$w_batchsapmapping.srw
forward
global type w_batchsapmapping from w_response
end type
type tab_1 from u_tab_sap within w_batchsapmapping
end type
type tab_1 from u_tab_sap within w_batchsapmapping
end type
type cb_save from commandbutton within w_batchsapmapping
end type
type cb_close from commandbutton within w_batchsapmapping
end type
end forward

global type w_batchsapmapping from w_response
integer x = 214
integer y = 221
integer width = 1957
integer height = 1836
string title = "SAP Batch Setup"
long backcolor = 12632256
event ue_itemchanged ( )
event ue_save ( )
tab_1 tab_1
cb_save cb_save
cb_close cb_close
end type
global w_batchsapmapping w_batchsapmapping

event ue_itemchanged();cb_save.Enabled = True
end event

event ue_save();IF This.Event pfc_Save() >= 0 THEN
	cb_Save.Enabled = False
END IF
end event

on w_batchsapmapping.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
end on

on w_batchsapmapping.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_save)
destroy(this.cb_close)
end on

type cb_help from w_response`cb_help within w_batchsapmapping
boolean visible = false
end type

type tab_1 from u_tab_sap within w_batchsapmapping
integer x = 37
integer y = 32
integer width = 1851
integer taborder = 11
boolean bringtotop = true
end type

event ue_itemchanged;call super::ue_itemchanged;Parent.Event ue_ItemChanged()
end event

type cb_save from commandbutton within w_batchsapmapping
integer x = 1157
integer y = 1620
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Save"
end type

event clicked;Parent.Event ue_Save()
end event

type cb_close from commandbutton within w_batchsapmapping
integer x = 1550
integer y = 1620
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;Parent.Event pfc_Close()
end event

