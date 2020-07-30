$PBExportHeader$n_cst_eventtask_statusrequests.sru
forward
global type n_cst_eventtask_statusrequests from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_statusrequests from n_cst_eventtask
end type
global n_cst_eventtask_statusrequests n_cst_eventtask_statusrequests

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int	li_ProcessingResult 
String	ls_ResultString

n_cst_licenseManager	lnv_Licensemanager
IF NOT lnv_LicenseManager.of_hasnotificationlicense( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "Notification is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF

n_cst_bso_Notification_Manager	lnv_NoteManager
lnv_NoteManager = CREATE n_Cst_bso_Notification_Manager



li_ProcessingResult = appeon_constant.ci_Result_Success
ls_ResultString = "Status requests processed."

lnv_NoteManager.of_ProcessStatusRequests () 

THIS.of_Setprocessingresult( li_ProcessingResult)
THIS.of_Setresultstring( ls_ResultString )

DESTROY ( lnv_NoteManager )

RETURN 1		// the result of the actual operation has been set on this task to be interpreted by the 
				// manager. we are returning that we did execute what we were supposed to.
				
end function

on n_cst_eventtask_statusrequests.create
call super::create
end on

on n_cst_eventtask_statusrequests.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = 'This is the event task that will process the incoming status requests.'
is_Tabpagelabel = "Status Requests"
is_eventname = "ptev_StatusRequests"
is_schedulename = "ptsch_StatusRequests"
is_Procedurename = "ptsp_StatusRequests"
end event

