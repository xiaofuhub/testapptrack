$PBExportHeader$n_cst_eventtask_204process.sru
forward
global type n_cst_eventtask_204process from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_204process from n_cst_eventtask
end type
global n_cst_eventtask_204process n_cst_eventtask_204process

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int		li_ProcessReturn
Int		li_ProcessingResult
String	ls_ResultString	

li_ProcessingResult = n_cst_eventmanager.ci_Result_Success
ls_ResultString = "EDI 204 Process has completed successfully."

n_cst_licensemanager	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_HasEDI204License ( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "EDI 204 is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF

n_cst_edishipmentprocessmanager	lnv_ProcessManager
lnv_ProcessManager = CREATE n_cst_edishipmentprocessmanager

IF lnv_ProcessManager.of_processpendingshipments(  ) <> 1 THEN
//IF lnv_EdiManager.of_Processpendingshipments( ) <> 1 THEN
	li_ProcessingResult = n_cst_eventmanager.ci_Result_Error
	ls_ResultString = lnv_ProcessManager.of_Geterrorstring( )
END IF

THIS.of_setprocessingresult( li_ProcessingResult )
THIS.of_setresultstring( ls_ResultString )

DESTROY ( lnv_ProcessManager )

RETURN 1
end function

on n_cst_eventtask_204process.create
call super::create
end on

on n_cst_eventtask_204process.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = "This is the process that creates the previously imported shipments into Profit Tools."
is_Tabpagelabel = "204 Process"
is_eventname = "ptev_204process"
is_schedulename = "ptsch_204process" 
is_Procedurename = "ptsp_204process" 
end event

