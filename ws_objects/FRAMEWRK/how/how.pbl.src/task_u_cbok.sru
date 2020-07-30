$PBExportHeader$task_u_cbok.sru
forward
global type task_u_cbok from commandbutton
end type
end forward

global type task_u_cbok from commandbutton
int Width=234
int Height=105
int TabOrder=1
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global task_u_cbok task_u_cbok

event clicked;
if isValid(parent) then
	parent.Event Dynamic task_SetOutputParameters()
   close(parent)
end if
end event

