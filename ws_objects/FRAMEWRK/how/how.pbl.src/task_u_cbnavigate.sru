$PBExportHeader$task_u_cbnavigate.sru
$PBExportComments$Navigate commandbutton generated for any new navigations
forward
global type task_u_cbnavigate from commandbutton
end type
end forward

global type task_u_cbnavigate from commandbutton
int Width=229
int Height=101
int TabOrder=1
string Text="&Navigate..."
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global task_u_cbnavigate task_u_cbnavigate

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Clicked
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	This event is fired when the navigate button is clicked.  It
//						is responsible for firing an event on its parent for 
//						navigation - task_navigate.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

parent.Event Dynamic task_Navigate("")



end event

