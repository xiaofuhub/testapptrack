﻿$PBExportHeader$n_cst_eventtask_210.sru
forward
global type n_cst_eventtask_210 from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_210 from n_cst_eventtask
end type
global n_cst_eventtask_210 n_cst_eventtask_210

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int	li_WriteReturn
Int	li_ProcessingResult 
String	ls_ResultString


n_cst_licensemanager	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_hasedi210license( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "EDI 210 is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF

n_cst_bso_edimanager lnv_edi

long	lla_id[]


lnv_edi = create n_cst_bso_edimanager

lnv_edi.of_Generate ( appeon_constant.cl_transaction_set_210, lla_id )

lnv_edi.of_resetPendingcache()

//n_cst_bso_edimanager_214	lnv_Edi
//lnv_Edi = CREATE n_cst_bso_edimanager_210
//
li_ProcessingResult = appeon_constant.ci_Result_Success
ls_ResultString = "210 generation completed successfully."
//
////
//IF lnv_Edi.of_Sendpending( ) <> 1 THEN
//	li_ProcessingResult = appeon_constant.ci_Result_Error
//	ls_ResultString = "An error occurred while attempting to generate EDI 210 files."
//END IF

THIS.of_Setprocessingresult( li_ProcessingResult)
THIS.of_Setresultstring( ls_ResultString )

DESTROY ( lnv_Edi )

RETURN 1		// the result of the actual operation has been set on this task to be interpreted by the 
				// manager. we are returning that we did execute what we were supposed to.
				
end function

on n_cst_eventtask_210.create
call super::create
end on

on n_cst_eventtask_210.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = 'This is the process that generates EDI 210 transactions.'
is_Tabpagelabel = "EDI 210"
is_eventname = "ptev_210"
is_schedulename = "ptsch_210"
is_Procedurename = "ptsp_210"
end event

