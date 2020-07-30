$PBExportHeader$n_cst_eventtask_204.sru
forward
global type n_cst_eventtask_204 from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_204 from n_cst_eventtask
end type
global n_cst_eventtask_204 n_cst_eventtask_204

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
	THIS.of_Setresultstring( "EDI Outbound 204 is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF


n_cst_bso_edimanager_204	lnv_Edi
lnv_Edi = CREATE n_cst_bso_edimanager_204

li_ProcessingResult = appeon_constant.ci_Result_Success
ls_ResultString = "204 generation completed successfully."

li_result = lnv_Edi.of_Sendpending( )

//li_result = 0 means that there were no 990s pending.
IF li_result = 0 THEN			
	li_result = 1
END IF

IF li_result <> 1 THEN
	li_ProcessingResult = appeon_constant.ci_Result_Error
	ls_ResultString = "An error occurred while attempting to generate EDI 204 files."
END IF

THIS.of_Setprocessingresult( li_ProcessingResult)
THIS.of_Setresultstring( ls_ResultString )

DESTROY ( lnv_Edi )

RETURN 1		// the result of the actual operation has been set on this task to be interpreted by the 
				// manager. we are returning that we did execute what we were supposed to.
end function

on n_cst_eventtask_204.create
call super::create
end on

on n_cst_eventtask_204.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = 'This is the process that generates EDI 204 transactions.'
is_Tabpagelabel = "EDI 204 Outbound"
is_eventname = "ptev_204"
is_schedulename = "ptsch_204"
is_Procedurename = "ptsp_204"
end event

