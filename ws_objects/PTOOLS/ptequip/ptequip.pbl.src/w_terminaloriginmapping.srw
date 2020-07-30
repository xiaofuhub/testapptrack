$PBExportHeader$w_terminaloriginmapping.srw
forward
global type w_terminaloriginmapping from w_main
end type
type cb_ok from commandbutton within w_terminaloriginmapping
end type
type uo_1 from u_cst_terminaltraceoriginmapping within w_terminaloriginmapping
end type
end forward

global type w_terminaloriginmapping from w_main
integer width = 2226
integer height = 1236
string title = "Terminal Origin Mapping"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12632256
event ue_done ( )
cb_ok cb_ok
uo_1 uo_1
end type
global w_terminaloriginmapping w_terminaloriginmapping

event ue_done();//IF This.Event pfc_Save() >= 0 THEN
	This.Event pfc_Close()
//END IF
end event

on w_terminaloriginmapping.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.uo_1
end on

on w_terminaloriginmapping.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.uo_1)
end on

event open;call super::open;// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()
end event

type cb_ok from commandbutton within w_terminaloriginmapping
integer x = 1723
integer y = 988
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Done"
end type

event clicked;Parent.Event ue_done()
end event

type uo_1 from u_cst_terminaltraceoriginmapping within w_terminaloriginmapping
integer x = 41
integer y = 36
integer width = 2126
integer height = 1100
integer taborder = 10
end type

on uo_1.destroy
call u_cst_terminaltraceoriginmapping::destroy
end on

