$PBExportHeader$n_cst_errorlog_manager.sru
forward
global type n_cst_errorlog_manager from n_cst_base
end type
end forward

global type n_cst_errorlog_manager from n_cst_base
end type
global n_cst_errorlog_manager n_cst_errorlog_manager

type variables
Public:
Constant String	cs_ErrorRemedy_EDI = "n_cst_ErrorRemedy_edi"
end variables

forward prototypes
public function integer of_logerror (n_cst_errorlog anv_errorlog)
public function integer of_logerrors (n_cst_errorlog anva_errorlog[])
public function integer of_troubleshoot (n_cst_errorlog anv_errorlog)
public function integer of_logerror (string as_category, string as_context, string as_message, integer ai_urgency, long ala_sourceids[], string as_remedy)
end prototypes

public function integer of_logerror (n_cst_errorlog anv_errorlog);/***************************************************************************************
NAME: 		of_LoggError	

ACCESS:		Public
		
ARGUMENTS:	(n_cst_ErrorLog anv_Errorlog)

RETURNS:		Integer
	
DESCRIPTION: 
				Logs an error in the ErrorLog Table
				Return 1 : success
				Returns 0: invalid log error
				Returns -1: error
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 05/04/06 - Maury
***************************************************************************************/
Integer	li_Return
Long		i, ll_SourceIdCount
String	ls_Category
String	ls_Context
String	ls_Message
String	ls_RemedyObject
Integer	li_Urgency
Long		lla_SourceIds[]
Long		ll_ErrorLogId

IF isValid(anv_ErrorLog) THEN
	ls_Category = anv_ErrorLog.of_GetCategory()
	ls_Context = anv_ErrorLog.of_GetContext()
	ls_Message = anv_ErrorLog.of_GetMessage()
	li_Urgency = anv_ErrorLog.of_GetUrgency()
	ls_RemedyObject = anv_ErrorLog.of_GetRemedyObject()
	anv_ErrorLog.of_GetSourceIds(lla_SourceIds[])
	
	gnv_App.of_GetNextId( "errorlog", ll_ErrorLogId, true)
	//log error
	INSERT INTO errorlog("id", "message", "category", "context", "urgency", "remedyobject" )
			 VALUES (:ll_ErrorLogId, :ls_Message, :ls_Category, :ls_Context, :li_Urgency, :ls_RemedyObject );
			 
	//log SourceIds for remedy purposes	
	IF SQLCA.Sqlcode = 0 THEN
		ll_SourceIdCount = UpperBound(lla_SourceIds[])
		FOR i = 1 TO ll_SourceIdCount
			
			INSERT INTO errorlogsourceids("errorlogid", "sourceid" )
					 VALUES ( :ll_ErrorLogId, :lla_SourceIds[i] );
		
			IF SQLCA.Sqlcode <> 0 THEN
				EXIT
			END IF
			
		NEXT
	END IF
		
	
	IF SQLCA.SqlCode = 0 THEN
		Commit;
		li_Return = 1
	ELSE
		Rollback;
		li_Return = -1
	END IF

END IF


Return li_Return


end function

public function integer of_logerrors (n_cst_errorlog anva_errorlog[]);/***************************************************************************************
NAME: 		of_LoggErrors

ACCESS:		Public
		
ARGUMENTS:	(n_cst_ErrorLog anva_Errorlog[])

RETURNS:		Integer
	
DESCRIPTION: 
				Return 1 : success
				Returns -1: error
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 05/04/06 - Maury
***************************************************************************************/
Long		i
Long		ll_LogCount
Integer	li_Return


ll_LogCount = UpperBound(anva_ErrorLog[])
FOR i = 1 TO ll_LogCount
	IF This.of_LogError(anva_ErrorLog[i]) <> 1 THEN
		li_Return = -1
		EXIT
	END IF
NEXT

Return li_Return
end function

public function integer of_troubleshoot (n_cst_errorlog anv_errorlog);Integer	li_Return
String	ls_RemedyObject
Long		lla_SourceIds[]

n_cst_ErrorRemedy		lnv_ErrorRemedy

anv_ErrorLog.of_GetSourceIds(lla_SourceIds[])

ls_RemedyObject = anv_ErrorLog.of_GetRemedyObject()


IF Pos(lower(ls_RemedyObject), "n_cst_errorremedy", 1) > 0 THEN
	lnv_ErrorRemedy = Create Using ls_RemedyObject	
	lnv_ErrorRemedy.of_SetSourceIds(lla_SourceIds[])
	lnv_errorRemedy.of_setSource( anv_errorlog )
	lnv_ErrorRemedy.of_Remedy()
	Destroy lnv_ErrorRemedy
END IF



Return li_Return
end function

public function integer of_logerror (string as_category, string as_context, string as_message, integer ai_urgency, long ala_sourceids[], string as_remedy);//DEK 3-16-07, Just instantiate a manager and call this function to create an entry in the db.
n_cst_errorlog lnv_error

lnv_error = CREATE n_cst_errorlog	

lnv_error.of_setlogdata( as_category, as_context , String(Today(), "m/d/yy hh:mm")+" "+as_message, ai_urgency, ala_sourceIds, as_remedy)

this.of_logerror( lnv_error )
Destroy lnv_error

RETURN 1	
end function

on n_cst_errorlog_manager.create
call super::create
end on

on n_cst_errorlog_manager.destroy
call super::destroy
end on

