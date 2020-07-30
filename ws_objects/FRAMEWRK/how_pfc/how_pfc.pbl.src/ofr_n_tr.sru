$PBExportHeader$ofr_n_tr.sru
$PBExportComments$PFC Transaction class
forward
global type ofr_n_tr from pfc_n_tr
end type
end forward

global type ofr_n_tr from pfc_n_tr
event type boolean pfc_descendant ( )
end type
global ofr_n_tr ofr_n_tr

forward prototypes
public function long of_begin ()
end prototypes

event pfc_descendant;call super::pfc_descendant;return true

end event

public function long of_begin ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		of_Begin
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Base transaction object for use with OFR and PFC.
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
//	Copyright © 1996 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


Return 1

end function

on ofr_n_tr.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on ofr_n_tr.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

