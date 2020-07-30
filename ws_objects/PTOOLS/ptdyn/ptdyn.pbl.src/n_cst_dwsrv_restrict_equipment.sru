$PBExportHeader$n_cst_dwsrv_restrict_equipment.sru
forward
global type n_cst_dwsrv_restrict_equipment from n_cst_dwsrv_restrict_driverequip
end type
end forward

global type n_cst_dwsrv_restrict_equipment from n_cst_dwsrv_restrict_driverequip
end type
global n_cst_dwsrv_restrict_equipment n_cst_dwsrv_restrict_equipment

on n_cst_dwsrv_restrict_equipment.create
call super::create
end on

on n_cst_dwsrv_restrict_equipment.destroy
call super::destroy
end on

event ue_clearrestriction;call super::ue_clearrestriction;//undoes the restriction from if it was before
IF (as_dwType = "EQUIPMENT" OR as_dwType = "ALL" )AND isValid( idw_requestor ) THEN
	idw_requestor.rowsMove( 1, idw_requestor.filteredCount() , FILTER!, idw_requestor, 1, PRIMARY! )
	idw_requestor.filter()
	idw_requestor.sort()
	idw_requestor.groupCalc( )
END IF
end event

