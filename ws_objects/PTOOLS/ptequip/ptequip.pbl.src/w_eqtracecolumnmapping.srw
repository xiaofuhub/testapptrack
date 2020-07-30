$PBExportHeader$w_eqtracecolumnmapping.srw
forward
global type w_eqtracecolumnmapping from w_response
end type
type tab_1 from u_tab_columnmapping within w_eqtracecolumnmapping
end type
type tab_1 from u_tab_columnmapping within w_eqtracecolumnmapping
end type
type cb_done from commandbutton within w_eqtracecolumnmapping
end type
end forward

global type w_eqtracecolumnmapping from w_response
integer width = 2126
string title = "Equipment Trace Data Mapping"
long backcolor = 12632256
event ue_done ( )
tab_1 tab_1
cb_done cb_done
end type
global w_eqtracecolumnmapping w_eqtracecolumnmapping

event ue_done();//IF This.Event pfc_Save() >= 0 THEN
	This.Event pfc_Close()
//END IF
end event

on w_eqtracecolumnmapping.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_done=create cb_done
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_done
end on

on w_eqtracecolumnmapping.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_done)
end on

event open;call super::open;// Center window
This.of_SetBase(TRUE) 
This.inv_Base.Of_Center()
end event

type cb_help from w_response`cb_help within w_eqtracecolumnmapping
boolean visible = false
end type

type tab_1 from u_tab_columnmapping within w_eqtracecolumnmapping
integer x = 59
integer y = 44
integer width = 1970
integer height = 1164
integer taborder = 11
boolean bringtotop = true
boolean boldselectedtext = true
end type

type cb_done from commandbutton within w_eqtracecolumnmapping
integer x = 1627
integer y = 1248
integer width = 402
integer height = 112
integer taborder = 21
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Done"
end type

event clicked;Parent.Event ue_Done()
end event

