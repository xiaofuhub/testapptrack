$PBExportHeader$w_postingrules.srw
forward
global type w_postingrules from w_response
end type
type tab_1 from u_tab_postingrules within w_postingrules
end type
type tab_1 from u_tab_postingrules within w_postingrules
end type
type cb_1 from u_cbok within w_postingrules
end type
type cb_2 from u_cbcancel within w_postingrules
end type
end forward

global type w_postingrules from w_response
integer x = 214
integer y = 221
integer width = 3058
integer height = 1372
string title = "Equipment Posting"
long backcolor = 12632256
tab_1 tab_1
cb_1 cb_1
cb_2 cb_2
end type
global w_postingrules w_postingrules

on w_postingrules.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_postingrules.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;THIS.of_setbase( TRUE )
inv_Base.of_Center( )
end event

event pfc_cancel;call super::pfc_cancel;CLOSE ( THIS )
end event

event pfc_default;call super::pfc_default;THIS.of_Update( TRUE,TRUE )
end event

type cb_help from w_response`cb_help within w_postingrules
integer x = 2958
integer y = 1228
end type

type tab_1 from u_tab_postingrules within w_postingrules
integer x = 23
integer y = 32
integer taborder = 11
boolean bringtotop = true
end type

type cb_1 from u_cbok within w_postingrules
integer x = 1166
integer y = 1156
integer width = 233
integer taborder = 11
boolean bringtotop = true
string text = "Save"
end type

type cb_2 from u_cbcancel within w_postingrules
integer x = 1499
integer y = 1156
integer width = 233
integer taborder = 11
boolean bringtotop = true
end type

