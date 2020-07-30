$PBExportHeader$n_cst_eventmanager.sru
forward
global type n_cst_eventmanager from n_base
end type
end forward

shared variables

end variables

global type n_cst_eventmanager from n_base
end type
global n_cst_eventmanager n_cst_eventmanager

type variables
CONSTANT	Int	ci_Processed = 1
CONSTANT	Int	ci_NotProcessed = 0


CONSTANT	int	ci_Result_Error = -1
CONSTANT	int	ci_Result_Success = 1
CONSTANT	int	ci_Result_SuccessNotComplete = 0


PRIVATE:
dataStore	ids_Tasks
Boolean	ib_Processing
end variables

forward prototypes
private function n_cst_eventtask of_getnexttask ()
private function integer of_executetask (ref n_cst_eventtask anv_task)
private function integer of_processtaskresult (ref n_cst_eventtask anv_task)
private function integer of_flagtaskasbeingprocessed (long al_taskid)
private function integer of_writelog (n_cst_eventtask anv_task)
private function integer of_deletetask (n_cst_eventtask anv_task)
private function integer of_processsuccessfultask (n_cst_eventtask anv_task)
private function integer of_processincompletetask (n_cst_eventtask anv_task)
private function integer of_processerroredtask (n_cst_eventtask anv_task)
public function integer of_executenexttask ()
public function boolean of_isprocessing ()
private function string of_getlogfolder ()
public function integer of_resetalltasks ()
public function integer of_getschedulelist (ref n_cst_scheduledata anva_schedules[])
private function boolean of_recordsuccesses ()
end prototypes

private function n_cst_eventtask of_getnexttask ();Long	ll_TaskCount
Long	ll_TaskID
Long	ll_TaskRow
Int	li_Prio
Int	li_FlagRtn
Boolean	lb_Continue = TRUE

String	ls_taskname
Constant	String cs_ClassName = "n_cst_eventTask"

n_cst_EventTask	lnv_Task
/*
We were having problems where multiple schedulers were grabbing the same task
so I am going to lock the table until we are done flagging it as taken.
*/

Execute Immediate "LOCK TABLE EventTasks IN  EXCLUSIVE MODE" ;

ll_TaskCount = ids_Tasks.Retrieve ( )
// we don't want to commit or rollback here
// we want to wait until we finish flagging the task as being processed.

IF ll_TaskCount > 0 THEN
	ll_TaskRow = 1
	
	ls_TaskName = ids_Tasks.GetItemString ( ll_TaskRow , "eventtaskname" ) 
	ll_TaskID = ids_tasks.GetItemNumber ( ll_TaskRow , "taskid" )
	li_Prio = ids_tasks.GetItemNumber ( ll_TaskRow , "taskpriority" )
	IF ll_TaskID > 0 THEN
		li_FlagRtn = THIS.of_FlagTaskAsBeingProcessed( ll_TaskID )
		IF li_FlagRtn <> 1 THEN
			lb_Continue = FALSE
		END IF
	ELSE // Since of_FlagTaskAsBeingProcessed will not issue a commit or rollback if
			// the taskId is not > 0 we want to make sure that we close the trasaction 
			// since we put an exclusive lock on it.
		IF sqlca.sqlcode = -1 THEN
			RollBack;
		ELSE
			Commit;
		END IF
	END IF
ELSE
	IF sqlca.sqlcode = -1 THEN
		RollBack;
	ELSE
		Commit;
	END IF

END IF

IF lb_Continue THEN
	IF Len ( ls_TaskName ) > 0 THEN
		lnv_Task = CREATE USING cs_ClassName + "_" + ls_TaskName
	END IF
END IF

IF lb_Continue THEN
	IF IsValid ( lnv_Task ) THEN		
		lnv_Task.of_settaskid( ll_TaskID )
		lnv_Task.of_Setpriority( li_Prio )		
	END IF
END IF
	

RETURN lnv_Task


end function

private function integer of_executetask (ref n_cst_eventtask anv_task);Int	li_Return

IF isvalid ( anv_task ) THEN
	li_Return = anv_task.of_Execute ( )
END IF

RETURN li_Return


end function

private function integer of_processtaskresult (ref n_cst_eventtask anv_task);Int		li_ProcessingResult
int		li_Return = 1

IF Not IsValid ( anv_task ) THEN
	RETURN li_Return
END IF


li_ProcessingResult = anv_task.of_GetProcessingResult ( )


CHOOSE CASE li_ProcessingResult
		
	CASE ci_result_error
		IF THIS.of_ProcessErroredtask( anv_task ) <> 1 THEN
			li_Return = -1
		END IF
		
	CASE ci_result_success
		IF THIS.of_Processsuccessfultask( anv_Task ) <> 1 THEN
			li_Return = -1
		END IF
			
	CASE ci_result_successnotcomplete
		IF THIS.of_ProcessIncompletetask( anv_task ) <> 1 THEN
			li_Return = -1
		END IF
		
	CASE ELSE
		li_Return = -1
END CHOOSE

RETURN li_Return
end function

private function integer of_flagtaskasbeingprocessed (long al_taskid);// this is used to flag the task a actively being processd. that way other clients doing
// processing will not retrieve this task

Long	ll_TaskID 
Int	li_Status
Int	li_Return = -1
String	ls_MachineName

n_cst_PlatformWin32	lnv_Platform

lnv_Platform = Create n_cst_PlatformWin32
ls_MachineName = lnv_platform.of_GetComputerName()

IF len ( ls_MachineName ) > 100 THEN  // DB Restriction
	ls_Machinename = Left ( ls_MachineName, 100 )
END IF



li_Status = ci_processed
ll_TaskID = al_taskid

IF ll_TaskID > 0 THEN

	UPDATE "eventtasks"  
	  SET "processingstatus" = :li_Status,
	  		"machinename" = :ls_Machinename
	WHERE "eventtasks"."taskid" = :ll_TaskID ;
	
	IF SQLCA.SQlcode = 0 THEN
		COMMIT;
		li_Return = 1
	ELSE
		li_Return = -1
		ROLLBACK;
	END IF
END IF


DESTROY ( lnv_Platform )

RETURN li_Return
end function

private function integer of_writelog (n_cst_eventtask anv_task);Int		li_Return = -1
String	ls_Path
String	ls_Filename
Int		li_FileHandle
String	ls_Result



IF not IsValid ( anv_Task ) THEN
	RETURN li_Return
END IF

ls_Path = THIS.of_Getlogfolder( ) + "\"
ls_FileName = 'EventLog.Txt'

li_Filehandle = FileOpen ( ls_path + ls_FileName , LineMode! , WRITE! ) 


IF li_Filehandle >= 0 THEN
	ls_Result = "-- " + String ( Today ( ) , "MM/DD/YYYY" ) + " " +  String ( Now ( ), "HH:MM") + "~r~n~t"
	ls_Result += anv_task.of_getResultString ( )
	FileWrite ( li_FileHandle , ls_Result ) 
	
	FileClose ( li_FileHandle ) 
	li_Return = 1
END IF


RETURN li_Return

end function

private function integer of_deletetask (n_cst_eventtask anv_task);Int	li_Return = 0
Long	ll_TaskID	
ll_TaskID = anv_task.of_GetTaskID (  )

//MessageBox ( "of_DeleteTask" , "Commented for testing" )
IF ll_TaskID > 0 THEN
	
  DELETE FROM "eventtasks"  
	WHERE "eventtasks"."taskid" = :ll_TaskID  ;
	
	CHOOSE CASE SQLCA.Sqlcode
		CASE 0			
			COMMIT;
			li_Return = 1
		CASE ELSE
			ROLLBACK;
			li_Return = -1
	END CHOOSE	
END IF	

RETURN li_Return
end function

private function integer of_processsuccessfultask (n_cst_eventtask anv_task);Int	li_Return = 1

IF not isValid ( anv_task ) THEN
	li_Return = -1
	RETURN li_Return
END IF

IF THIS.of_Recordsuccesses( ) THEN
	IF THIS.of_Writelog( anv_task ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF THIS.of_Deletetask( anv_task ) <> 1 THEN
	li_Return = -1
END IF
	
RETURN li_Return
end function

private function integer of_processincompletetask (n_cst_eventtask anv_task);int	li_Return
Int	li_Prio
Int	li_Status
Long	ll_TaskID

IF Not IsValid ( anv_task ) THEN
	li_Return = -1
	RETURN li_Return
END IF

li_Status = ci_NotProcessed
ll_TaskID = anv_task.of_getTaskID()
li_Prio = anv_task.of_GetPriority ( )
li_Prio --

THIS.of_Writelog( anv_task )

IF ll_TaskID > 0 THEN
	
	  UPDATE "eventtasks"  
     SET "taskpriority" = :li_Prio,   
         "processingstatus" = :li_Status  
   WHERE "eventtasks"."taskid" = :ll_TaskID ;
	
	IF SQLCA.Sqlcode = 0 THEN
		COMMIT;
		li_Return = 1
	ELSE
		ROLLBACK;
		li_Return = -1
	END IF
	
END IF

RETURN li_Return
end function

private function integer of_processerroredtask (n_cst_eventtask anv_task);Int	li_Return = 1

IF not isValid ( anv_task ) THEN
	li_Return = -1
	RETURN li_Return
END IF

IF THIS.of_Writelog( anv_task ) <> 1 THEN
	li_Return = -1
END IF

IF THIS.of_Deletetask( anv_task ) <> 1 THEN
	li_Return = -1
END IF
	
RETURN li_Return
end function

public function integer of_executenexttask ();Int	li_Return = 1

n_cst_EventTask	lnv_Task

Ib_processing = TRUE

lnv_Task = THIS.of_GetNextTask( )

IF THIS.of_executetask( lnv_Task ) <> 1 THEN
	li_Return = -1

END IF

IF li_Return = 1 THEN
	IF THIS.of_Processtaskresult( lnv_Task ) <> 1 THEN
		li_Return = -1
	END IF
END IF

DESTROY ( lnv_Task )

ib_processing = FALSE

RETURN li_Return

end function

public function boolean of_isprocessing ();RETURN ib_processing
end function

private function string of_getlogfolder ();String	ls_Folder

ls_Folder = gnv_app.of_getapplicationfolder( )
//If MessageBox ("Location " , "Use Devel path" , QUESTION! , YESNO! ,1 ) = 1 THEN
//	ls_Folder = "c:\TaskLog"
//ELSE
	ls_Folder += "..\TaskLog"
//END IF

IF NOT DirectoryExists ( ls_Folder ) THEN
	CreateDirectory ( ls_Folder ) 
END IF

RETURN ls_Folder
end function

public function integer of_resetalltasks ();
Int	li_Return

DELETE FROM "eventtasks"  ;
IF Sqlca.Sqlcode <> 0 THEN
	Rollback;
	li_Return = 0
ELSE	
	Commit;
	li_Return = 1
END IF

RETURN li_Return

end function

public function integer of_getschedulelist (ref n_cst_scheduledata anva_schedules[]);Int	li_Return
Int	li_Count
n_Cst_ScheduleData	lnva_Schedules[]
n_cst_licenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_Hasedi204license( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "204import" )
	
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "204process" )
END IF
// Not quite yet...
IF lnv_LicenseManager.of_Hasedi214license( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "214" )
END IF

// Not quite yet...Added by Dan
IF lnv_LicenseManager.of_Hasedi204license( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "990" )
END IF

// Not quite yet...Added by Dan
IF lnv_LicenseManager.of_Hasedi210license( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "210" )
END IF

IF lnv_LicenseManager.of_Hasedi322license( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "322" )
END IF
////////////ADDED BY DAN FOR new 204 task 3-5-07
IF lnv_LicenseManager.of_hasedi204license( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "204" )
END IF


IF lnv_LicenseManager.of_hasedi204license( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "214process" )
END IF
//////////////////////////////


IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AtRoad ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "atroad" )
END IF

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Cadec ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "Cadec" )
END IF

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Intouch ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "intouch" )
END IF

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_qualcomm ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "qualcomm" )
END IF

IF lnv_LicenseManager.of_hasNextellicense( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "nextelsync" )
END IF

IF lnv_LicenseManager.of_hasEquipmentpostinglicense( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "equipmentposting" )
END IF

IF lnv_LicenseManager.of_hasnotificationlicense( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "statusrequests" )
	
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "pendingnotifications" )
END IF

IF lnv_LicenseManager.of_hasdocumentttansfer ( ) THEN
	li_Count ++
	lnva_Schedules[li_Count] = CREATE n_Cst_ScheduleData
	lnva_Schedules[li_Count].of_settask( "documenttransfer" )
END IF



anva_schedules = lnva_Schedules

RETURN li_Count

end function

private function boolean of_recordsuccesses ();Boolean	lb_Return

lb_Return = UPPER ( ProfileString ( gnv_app.of_getappinifile( ) , "PTEVENTS", "RECORD SUCCESSES", "NO" ) ) = "YES"



RETURN lb_Return
end function

on n_cst_eventmanager.create
call super::create
end on

on n_cst_eventmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_Tasks = CREATE DataStore
ids_Tasks.DataObject = "d_eventTasks"
ids_tasks.SetTransobject( SQLCA )
end event

event destructor;call super::destructor;DESTROY ids_tasks
end event

