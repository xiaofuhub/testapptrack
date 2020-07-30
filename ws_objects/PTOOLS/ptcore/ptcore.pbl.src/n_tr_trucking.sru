$PBExportHeader$n_tr_trucking.sru
$PBExportComments$Transaction Class with default user extension, AutoRollback = TRUE.
forward
global type n_tr_trucking from n_tr
end type
end forward

global type n_tr_trucking from n_tr
end type
global n_tr_trucking n_tr_trucking

type prototypes
SUBROUTINE GetNextId ( Long aClassId, REF Long aNextId, Integer aCommit ) RPCFUNC
SUBROUTINE GetModuleLock ( string aComputerName, string aModuleName, string aUserID,REF  long aRetVal ) RPCFUNC
SUBROUTINE GetCustomSeriesValue ( String aTopic, String aCode, REF Long aNextValue, REF String aStringFormat, Integer aAuto, Integer aCommit ) RPCFUNC
SUBROUTINE ptsp_BackupDB (string as_Location) RPCFUNC
SUBROUTINE ptsp_RailTraceUpdate() RPCFUNC
SUBROUTINE ptsp_AddEquipmentTrace(Long	al_EqId) RPCFUNC
end prototypes

forward prototypes
public function integer of_init (string as_inifile, string as_inisection)
public function integer of_getnextid (long al_idclass, ref long al_nextid, boolean ab_commit)
public function integer of_getmodulelock (string as_computername, string as_modulename, string as_userid)
public function integer of_getcustomseriesvalue (string as_topic, string as_code, ref long al_nextvalue, ref string as_stringformat, boolean ab_auto, boolean ab_commit)
public function integer of_backupdb (string as_location)
public function integer of_railtraceupdate ()
public function integer of_addequipmenttrace (long al_eqid)
end prototypes

public function integer of_init (string as_inifile, string as_inisection);Integer	li_Rc

This.DBMS = "ODBC"
This.DBParm = "Connectstring='DSN=Profit Tools Data'"
of_SetUser ( 'dba', 'sql' )

RETURN li_Rc

end function

public function integer of_getnextid (long al_idclass, ref long al_nextid, boolean ab_commit);//Note : The stored procedure has the option of committing the update to NextId itself, 
//thus freeing the lock faster.  This option is controlled through the aCommit parameter.

//Return : 1, -1

Integer	li_Commit, &
			li_Return

IF ab_Commit THEN
	li_Commit = 1
END IF

SetNull ( al_NextId )

IF NOT IsNull ( al_IdClass ) THEN

	This.GetNextId ( al_IdClass, al_NextId, li_Commit )
	
	IF ab_Commit THEN
		//Note:  The incrementing of the id will have already been committed in the DB.
		//This is just to clear any possible locks associated with calling the procedure 
		//(which is, surprisingly, necessary.)
		COMMIT ;
	END IF

END IF

IF IsNull ( al_NextId ) THEN
	li_Return = -1
ELSE
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_getmodulelock (string as_computername, string as_modulename, string as_userid);long		ll_RetVal
integer	li_Return

IF Len ( as_ComputerName ) > 0 THEN

//	A reference value for a stored procedure needs to be 
//	initialized as null
	SetNull ( ll_RetVal )

	This.GetModuleLock ( as_ComputerName, as_ModuleName, as_UserId, ll_RetVal )
	
	Commit ;
	//Without this commit, PT would hang when attempting to acquire locks.
	//Note:  The selects and inserts have already been committed in the DB.
	//This is just to clear any possible locks associated with calling the procedure 
	//(which is, surprisingly, necessary.)
	
	choose case ll_RetVal
		case 0
			li_Return = 0
		case 1
			li_Return = 1
		case else
			li_Return = -1
	end choose
	
ELSE
	li_Return = -1
	
END IF

Return li_Return

end function

public function integer of_getcustomseriesvalue (string as_topic, string as_code, ref long al_nextvalue, ref string as_stringformat, boolean ab_auto, boolean ab_commit);//Note : The stored procedure has the option of committing the update to NextValue itself, 
//thus freeing the lock faster.  This option is controlled through the aCommit parameter.

//Return : 1, -1

//ab_Auto controls whether an entry will be created for the Topic & Code specified, if one does
//not already exist.  This will not happen if there already is a row for that topic and code, 
//but with a null next value.

Integer	li_Auto, &
			li_Commit, &
			li_Return

//Boolean parameters must be sent to the Stored Procedure as ints -- convert them.

IF ab_Auto THEN
	li_Auto = 1
END IF

IF ab_Commit THEN
	li_Commit = 1
END IF

SetNull ( al_NextValue )
SetNull ( as_StringFormat )

IF NOT ( IsNull ( as_Topic ) OR IsNull ( as_Code ) ) THEN

	This.GetCustomSeriesValue ( as_Topic, as_Code, al_NextValue, as_StringFormat, li_Auto, li_Commit )
	//NOTE: For some reason, I have not been able to get the value of as_StringFormat to populate. --BKW
	
	IF ab_Commit THEN
		//Note:  The incrementing of the id will have already been committed in the DB.
		//This is just to clear any possible locks associated with calling the procedure 
		//(which is, surprisingly, necessary.)
		COMMIT ;
	END IF

END IF

IF IsNull ( al_NextValue ) THEN
	li_Return = -1
ELSE
	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_backupdb (string as_location);Integer	li_Return
This.ptsp_backupdb( as_Location )

IF This.sqlcode <> 0 THEN
	MessageBox( "Error", sqlca.sqlerrtext + "~n~nThe database was not successfully backed up.", Exclamation! )
	ROLLBACK ;
	li_Return = -1
ELSE
	Commit;
	li_Return = 1
END iF

Return li_Return
end function

public function integer of_railtraceupdate ();Integer	li_Return

This.ptsp_RailTraceUpdate()

IF This.sqlcode <> 0 THEN
	MessageBox( "Error", sqlca.sqlerrtext + "~n~nRailTrace update failed.", Exclamation! )
	ROLLBACK ;
	li_Return = -1
ELSE
	Commit;
	li_Return = 1
END iF

Return li_Return
end function

public function integer of_addequipmenttrace (long al_eqid);Integer	li_Return = 1

This.ptsp_AddEquipmentTrace( al_EqId )

IF This.sqlcode <> 0 THEN
	ROLLBACK ;
	li_Return = -1
ELSE
	Commit;
END iF

Return li_Return
end function

on n_tr_trucking.create
call super::create
end on

on n_tr_trucking.destroy
call super::destroy
end on

event constructor;of_SetAutoRollback ( TRUE )
end event

