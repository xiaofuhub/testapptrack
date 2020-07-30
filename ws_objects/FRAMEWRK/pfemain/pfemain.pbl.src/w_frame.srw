$PBExportHeader$w_frame.srw
$PBExportComments$Extension Frame Window class
forward
global type w_frame from pfc_w_frame
end type
end forward

global type w_frame from pfc_w_frame
event type integer pfc_closeall ( )
end type
global w_frame w_frame

event pfc_closeall;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_closeall
//
//	Arguments:  none
//
//	Returns:  integer
//	 number of sheets closed
//	-1 = error
//
//	Description:
//	Attempts to close all open sheets
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

if IsValid (inv_sheetmanager) then
	li_rc = this.inv_sheetmanager.event pfc_closeall()
end if

return li_rc
end event

on w_frame.create
call super::create
end on

on w_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

