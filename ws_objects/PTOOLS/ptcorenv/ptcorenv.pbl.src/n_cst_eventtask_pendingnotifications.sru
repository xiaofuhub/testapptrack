$PBExportHeader$n_cst_eventtask_pendingnotifications.sru
forward
global type n_cst_eventtask_pendingnotifications from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_pendingnotifications from n_cst_eventtask
end type
global n_cst_eventtask_pendingnotifications n_cst_eventtask_pendingnotifications

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int	li_ProcessingResult 
String	ls_ResultString

n_cst_licensemanager	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_hasnotificationlicense( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "Notification is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF





n_cst_bso_Notification_Manager	lnv_NoteManager
lnv_NoteManager = CREATE n_Cst_bso_Notification_Manager

li_ProcessingResult = appeon_constant.ci_Result_Success
ls_ResultString = "Email notifications sent."

IF lnv_NoteManager.of_SendPendingNotifications () <> 1 THEN
	ls_ResultString = "Process Pending Email** " + lnv_NoteManager.of_Geterrorstring( )
	li_ProcessingResult = appeon_constant.ci_Result_Success
END IF

THIS.of_Setprocessingresult( li_ProcessingResult)
THIS.of_Setresultstring( ls_ResultString )

DESTROY ( lnv_NoteManager )

RETURN 1		// the result of the actual operation has been set on this task to be interpreted by the 
				// manager. we are returning that we did execute what we were supposed to.
				
end function

on n_cst_eventtask_pendingnotifications.create
call super::create
end on

on n_cst_eventtask_pendingnotifications.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = 'This is the event task that will process the pending email notifications.'
is_Tabpagelabel = "Pending Notification"
is_eventname = "ptev_PendingNotifications"
is_schedulename = "ptsch_PendingNotifications"
is_Procedurename = "ptsp_PendingNotifications"
end event

