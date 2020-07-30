$PBExportHeader$n_cst_eventtask.sru
forward
global type n_cst_eventtask from n_base
end type
end forward

global type n_cst_eventtask from n_base
end type
global n_cst_eventtask n_cst_eventtask

type variables
CONSTANT	int	ci_Result_Error = appeon_constant.ci_Result_Error
CONSTANT	int	ci_Result_Success = appeon_constant.ci_Result_Success
CONSTANT	int	ci_Result_SuccessNotComplete = appeon_constant.ci_Result_SuccessNotComplete

PROTECTED:
String	is_TaskDescription
String	is_EventName
String	is_ScheduleName
String	is_ProcedureName
String	is_TabPageLabel



Private:

Long	il_TaskID
Int	ii_Prio
Int	ii_Weight
Int	ii_ProcessingResult
String	is_ResultString




end variables

forward prototypes
public function integer of_settaskid (long al_id)
public function integer of_setpriority (integer ai_priority)
public function integer of_execute ()
public function integer of_getprocessingresult ()
public function string of_getresultstring ()
public function long of_gettaskid ()
public function integer of_getpriority ()
protected function integer of_setresultstring (string as_result)
protected function integer of_setprocessingresult (integer ai_result)
public function string of_getdescription ()
public function integer of_createeventindb ()
public function string of_geteventname ()
public function string of_gettabpagelabel ()
public function integer of_disableevent ()
end prototypes

public function integer of_settaskid (long al_id);il_taskid = al_id
RETURN 1
end function

public function integer of_setpriority (integer ai_priority);ii_prio = ai_Priority
RETURN 1
end function

public function integer of_execute ();// implemented in descendant

RETURN -1
end function

public function integer of_getprocessingresult ();RETURN ii_processingresult
end function

public function string of_getresultstring ();Return is_resultstring
end function

public function long of_gettaskid ();RETURN il_taskid
end function

public function integer of_getpriority ();Return ii_prio
end function

protected function integer of_setresultstring (string as_result);is_Resultstring = as_result
RETURN 1
end function

protected function integer of_setprocessingresult (integer ai_result);ii_processingresult = ai_result
RETURN 1
end function

public function string of_getdescription ();RETURN is_taskdescription
end function

public function integer of_createeventindb ();String	ls_Sql
String	ls_EventName
String	ls_ScheduleName
String	ls_ProcedureName

ls_ProcedureName = is_Procedurename
ls_EventName = is_eventname
ls_ScheduleName = is_schedulename

ls_Sql = "CREATE EVENT " + ls_EventName + " " + &
			"SCHEDULE " + ls_ScheduleName + " " + &
			"BETWEEN '09:00' AND '17:00' EVERY 1 HOURS DISABLE " + &
			"HANDLER BEGIN	Call " + ls_ProcedureName +"; END;"
			
Execute Immediate :ls_Sql;
Commit;
		

//CREATE EVENT "ptev_204process"
//SCHEDULE "ptsch_204process" BETWEEN '09:00' AND '17:00' EVERY 1 HOURS
//DISABLE
//HANDLER
//BEGIN
//	Call ptsp_204process;
//END;
//COMMENT ON EVENT "ptev_204process" IS 'This is the process that creates the previously imported shipments into Profit Tools.';

RETURN 1
end function

public function string of_geteventname ();RETURN is_eventname
end function

public function string of_gettabpagelabel ();RETURN is_Tabpagelabel
end function

public function integer of_disableevent ();Int	li_Return = 1
Int	li_Start
String	ls_EventName

n_cst_scheduledata	lnv_Data
lnv_Data = CREATE n_cst_scheduledata

lnv_Data.of_Seteventtask( THIS )
lnv_Data.of_Setenabled( FALSE )

li_Return = lnv_Data.of_Update( )



ls_eventName = THIS.ClassName()

li_Start = LEN ( "n_cst_eventtask_" ) + 1
ls_EventName = Mid ( ls_EventName , li_Start )

DELETE FROM "eventtasks"  
WHERE "eventtasks"."eventtaskname" = :ls_EventName;
IF SQLCA.Sqlcode <> 0 THEN
	ROLLBACK;
	li_Return = -1
ELSE
	Commit;
END IF
DESTROY ( lnv_Data )

RETURN li_Return
end function

on n_cst_eventtask.create
call super::create
end on

on n_cst_eventtask.destroy
call super::destroy
end on

