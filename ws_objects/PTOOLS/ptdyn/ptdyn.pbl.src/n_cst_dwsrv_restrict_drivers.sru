$PBExportHeader$n_cst_dwsrv_restrict_drivers.sru
forward
global type n_cst_dwsrv_restrict_drivers from n_cst_dwsrv_restrict_driverequip
end type
end forward

global type n_cst_dwsrv_restrict_drivers from n_cst_dwsrv_restrict_driverequip
end type
global n_cst_dwsrv_restrict_drivers n_cst_dwsrv_restrict_drivers

on n_cst_dwsrv_restrict_drivers.create
call super::create
end on

on n_cst_dwsrv_restrict_drivers.destroy
call super::destroy
end on

event ue_clearrestriction;call super::ue_clearrestriction;//undoes the restriction if it was restricted before
IF ( as_dwType = "DRIVERS" OR as_dwType = "ALL" )AND isValid( idw_requestor ) THEN
	idw_requestor.rowsMove( 1, idw_requestor.filteredCount() , FILTER!, idw_requestor, 1, PRIMARY! )
	idw_requestor.filter()
	idw_requestor.sort()
	idw_requestor.groupCalc( )
END IF
end event

