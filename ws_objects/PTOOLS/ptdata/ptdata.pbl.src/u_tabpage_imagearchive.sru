$PBExportHeader$u_tabpage_imagearchive.sru
forward
global type u_tabpage_imagearchive from u_tabpg
end type
end forward

global type u_tabpage_imagearchive from u_tabpg
event type boolean ue_allowpagechange ( )
end type
global u_tabpage_imagearchive u_tabpage_imagearchive

event type boolean ue_allowpagechange();RETURN TRUE
end event

on u_tabpage_imagearchive.create
call super::create
end on

on u_tabpage_imagearchive.destroy
call super::destroy
end on

