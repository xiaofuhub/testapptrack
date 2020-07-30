$PBExportHeader$task_w_nav_list.srw
$PBExportComments$Navigation services window for displaying links
forward
global type task_w_nav_list from Window
end type
type dw_1 from datawindow within task_w_nav_list
end type
type cb_cancel from commandbutton within task_w_nav_list
end type
type cb_ok from commandbutton within task_w_nav_list
end type
end forward

global type task_w_nav_list from Window
int X=833
int Y=373
int Width=1427
int Height=841
boolean TitleBar=true
string Title="Navigations"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event type integer rsc_getinputparameters ( n_cst_navigation an_navigation )
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global task_w_nav_list task_w_nav_list

type variables
protected:
string is_nav_list
n_cst_navigation in_navigation

end variables

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Open
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	When the task list window opens, import the tab delimited string
//						provided to display the possible navigations.
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

if not isNull(message.stringparm) then
	is_nav_list = message.stringparm
	dw_1.ImportString(is_nav_list)
	dw_1.SelectRow(1,TRUE)
else
	close(this)
end if

return 1
end event

on task_w_nav_list.create
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={ this.dw_1,&
this.cb_cancel,&
this.cb_ok}
end on

on task_w_nav_list.destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

type dw_1 from datawindow within task_w_nav_list
int X=28
int Y=37
int Width=1354
int Height=497
int TabOrder=10
string DataObject="task_d_nav_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;
if row = 0 then return

if this.GetSelectedRow(row) = row then return

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

event doubleclicked;if row > 0 then cb_ok.TriggerEvent(Clicked!)
end event

type cb_cancel from commandbutton within task_w_nav_list
int X=723
int Y=585
int Width=238
int Height=105
int TabOrder=20
string Text="Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Clicked
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	No navigation was selected, close the window.
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
close(parent)
end event

type cb_ok from commandbutton within task_w_nav_list
int X=449
int Y=585
int Width=234
int Height=105
int TabOrder=30
string Text="OK"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Clicked
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Determine which navigation was selected and return its name.
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
int r 

r = dw_1.GetSelectedRow(0)

if r > 0 then 
	closewithreturn(parent, dw_1.GetItemString(r, "nav"))
	return
end if

close(parent)


end event

