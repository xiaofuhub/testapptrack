$PBExportHeader$task_u_cbcancel.sru
forward
global type task_u_cbcancel from commandbutton
end type
end forward

global type task_u_cbcancel from commandbutton
int Width=234
int Height=105
int TabOrder=1
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global task_u_cbcancel task_u_cbcancel

event clicked;if isValid(parent) then
   close(parent)
end if
end event

