$PBExportHeader$n_cst_winsrv_sheetmanager.sru
$PBExportComments$Extension Window Sheet Manager service
forward
global type n_cst_winsrv_sheetmanager from pfc_n_cst_winsrv_sheetmanager
end type
end forward

global type n_cst_winsrv_sheetmanager from pfc_n_cst_winsrv_sheetmanager
event type integer pfc_closeall ( )
end type
global n_cst_winsrv_sheetmanager n_cst_winsrv_sheetmanager

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

integer	li_sheetcount, &
			li_ClosedCount
integer	li_cnt
window	lw_sheet[]

// Validate window requestor
if IsNull(iw_requestor) Or not IsValid (iw_requestor) then
	return -1
end if

// Get all sheets
li_sheetcount = of_GetSheets (lw_sheet)
if li_sheetcount > 0 then
	// Save current state
	//of_SetCurrentState (icons!)  ???
	
	for li_cnt = 1 to li_sheetcount

		CHOOSE CASE Close ( lw_sheet[li_cnt] )

		CASE 1  //Close succeeded
			li_ClosedCount ++

		CASE -1  //Close rejected -- Don't attempt any more
			EXIT

		CASE ELSE  //Null?
			//No processing needed

		END CHOOSE

	next
end if

return li_ClosedCount

end event

on n_cst_winsrv_sheetmanager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_winsrv_sheetmanager.destroy
TriggerEvent( this, "destructor" )
end on

