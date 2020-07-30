$PBExportHeader$u_cb_save.sru
forward
global type u_cb_save from u_cb
end type
end forward

global type u_cb_save from u_cb
string Text="&Save"
end type
global u_cb_save u_cb_save

event clicked;Parent.TriggerEvent ( "pfc_Save" )
end event

