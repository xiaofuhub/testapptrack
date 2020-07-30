$PBExportHeader$w_selection.srw
$PBExportComments$Extension Selection window
forward
global type w_selection from pfc_w_selection
end type
end forward

global type w_selection from pfc_w_selection
end type
global w_selection w_selection

on w_selection.create
call super::create
end on

on w_selection.destroy
call super::destroy
end on

event open;call super::open;//Extending ancestor

//In PFC Version, cb_OK only enables after clicking in the selection list, 
//which seems to require more effort than is appropriate for a simple selection dialog.

IF dw_1.RowCount ( ) > 0 THEN

	cb_Ok.Enabled = TRUE
	dw_1.SetFocus ( )

END IF
end event

