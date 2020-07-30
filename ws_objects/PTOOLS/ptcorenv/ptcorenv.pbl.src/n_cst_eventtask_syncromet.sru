$PBExportHeader$n_cst_eventtask_syncromet.sru
forward
global type n_cst_eventtask_syncromet from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_syncromet from n_cst_eventtask
end type
global n_cst_eventtask_syncromet n_cst_eventtask_syncromet

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int	li_WriteReturn
Int	li_ProcessingResult 
String	ls_ResultString


n_cst_licensemanager	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_hasequipmentpostinglicense( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "Equipment Posting is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF


n_cst_equipmentposting	lnv_EqPosting
lnv_EqPosting = CREATE n_cst_equipmentposting


li_ProcessingResult = appeon_constant.ci_Result_Success
ls_ResultString = "Equipment posting completed successfully."

li_WriteReturn = lnv_EqPosting.of_Writefiles( )

IF li_WriteReturn <> 1 THEN
	li_ProcessingResult = appeon_constant.ci_Result_Error
	ls_ResultString = "An error occurred while attempting to write the equipment posting file."
END IF

THIS.of_Setprocessingresult( li_ProcessingResult)
THIS.of_Setresultstring( ls_ResultString )

DESTROY ( lnv_EqPosting )

RETURN 1		// the result of the actual operation has been set on this task to be interpreted by the 
				// manager. we are returning that we did execute what we were supposed to.
				
end function

on n_cst_eventtask_syncromet.create
call super::create
end on

on n_cst_eventtask_syncromet.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = 'This is the process that generates equipment postings for SynchroMet equipment matching.'
is_Tabpagelabel = "SynchroMet"
is_eventname = "ptev_syncromet"
is_schedulename = "ptsch_syncromet"
is_Procedurename = "ptsp_syncromet"
end event

