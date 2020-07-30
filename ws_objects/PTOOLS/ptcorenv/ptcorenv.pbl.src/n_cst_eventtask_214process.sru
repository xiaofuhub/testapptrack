$PBExportHeader$n_cst_eventtask_214process.sru
forward
global type n_cst_eventtask_214process from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_214process from n_cst_eventtask
end type
global n_cst_eventtask_214process n_cst_eventtask_214process

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int		li_ProcessReturn
Int		li_ProcessingResult
String	ls_ResultString	

li_ProcessingResult = n_cst_eventmanager.ci_Result_Success
ls_ResultString = "EDI 214 Process has completed successfully."

n_cst_licensemanager	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_HasEDI214License ( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "EDI 214 inbound is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF

n_cst_edishipmentprocessmanager	lnv_ProcessManager
lnv_ProcessManager = CREATE n_cst_edishipmentprocessmanager

IF lnv_ProcessManager.of_processpending214s(  ) <> 1 THEN
	li_ProcessingResult = n_cst_eventmanager.ci_Result_Error
	ls_ResultString = lnv_ProcessManager.of_Geterrorstring( )
END IF

THIS.of_setprocessingresult( li_ProcessingResult )
THIS.of_setresultstring( ls_ResultString )

DESTROY ( lnv_ProcessManager )

RETURN 1
end function

event constructor;call super::constructor;is_taskdescription = "This is the process that confirms events on previously exported shipments from Profit Tools."
is_Tabpagelabel = "214 Process"
is_eventname = "ptev_214process"
is_schedulename = "ptsch_214process" 
is_Procedurename = "ptsp_214process" 
end event

on n_cst_eventtask_214process.create
call super::create
end on

on n_cst_eventtask_214process.destroy
call super::destroy
end on

