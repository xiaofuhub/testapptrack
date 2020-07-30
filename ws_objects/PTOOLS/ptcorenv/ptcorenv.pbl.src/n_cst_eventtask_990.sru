$PBExportHeader$n_cst_eventtask_990.sru
forward
global type n_cst_eventtask_990 from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_990 from n_cst_eventtask
end type
global n_cst_eventtask_990 n_cst_eventtask_990

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int	li_WriteReturn
Int	li_ProcessingResult 
Int	li_result
String	ls_ResultString


n_cst_licensemanager	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_hasedi204license( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "EDI 990 is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF


n_cst_bso_edimanager_990	lnv_Edi
lnv_Edi = CREATE n_cst_bso_edimanager_990

li_ProcessingResult = appeon_constant.ci_Result_Success
ls_ResultString = "990 generation completed successfully."

li_result = lnv_Edi.of_Sendpending( )

//li_result = 0 means that there were no 990s pending.
IF li_result = 0 THEN			
	li_result = 1
END IF

IF li_result <> 1 THEN
	li_ProcessingResult = appeon_constant.ci_Result_Error
	ls_ResultString = "An error occurred while attempting to generate EDI 990 files."
END IF

THIS.of_Setprocessingresult( li_ProcessingResult)
THIS.of_Setresultstring( ls_ResultString )

DESTROY ( lnv_Edi )

RETURN 1		// the result of the actual operation has been set on this task to be interpreted by the 
				// manager. we are returning that we did execute what we were supposed to.
end function

on n_cst_eventtask_990.create
call super::create
end on

on n_cst_eventtask_990.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = 'This is the process that generates EDI 990 transactions.'
is_Tabpagelabel = "EDI 990"
is_eventname = "ptev_990"
is_schedulename = "ptsch_990"
is_Procedurename = "ptsp_990"
end event

