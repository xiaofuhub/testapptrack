$PBExportHeader$n_cst_eventtask_dbbackup.sru
forward
global type n_cst_eventtask_dbbackup from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_dbbackup from n_cst_eventtask
end type
global n_cst_eventtask_dbbackup n_cst_eventtask_dbbackup

forward prototypes
public function integer of_createeventindb ()
end prototypes

public function integer of_createeventindb ();String	ls_Sql
String	ls_EventName
String	ls_ScheduleName

ls_EventName = is_eventname
ls_ScheduleName = is_schedulename

ls_Sql = "CREATE EVENT " + ls_EventName + " " + &
			"SCHEDULE " + ls_ScheduleName + " " + &
			"START TIME '00:30' ON ( 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' ) DISABLE " + &
			"HANDLER BEGIN " + &
				"DECLARE ls_BackupDirectory Long Varchar ;"+ &
				 "DECLARE ls_Command Long Varchar ;"+ &
				 "SELECT Trim(ss_String) INTO ls_BackupDirectory FROM ~"DBA~".system_settings WHERE ss_id = 190 ;"+ &
				 "IF Length(ls_BackupDirectory) > 0 THEN " + &				 	
					  "SET ls_Command = 'BACKUP DATABASE DIRECTORY ''' || ls_BackupDirectory || ''''; "+ &
					  "EXECUTE IMMEDIATE WITH ESCAPES OFF ls_Command ; "+ &
				 "END IF END" +&
				 " --If system setting 190 specifies a backup directory path, backup the db to that path. "+&
		  		 " --The path should be from the database servers perspective, and the engine must have privs to write there. " + &
    			 " --The path can end in a \, but does not have to. " + &
			 	 " --The command must be run using EXECUTE IMMEDIATE in order to allow the path to be determined dynamically. " +&
        		 " --The WITH ESCAPES OFF option must be used to avoid problems with the \ in the path " + &
	        	 " -- ( \ is the escape character) " + &
			 " ; " 


			
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

on n_cst_eventtask_dbbackup.create
call super::create
end on

on n_cst_eventtask_dbbackup.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription = 'This is the process that will make a backup copy of the Profit Tools Database (ASA 9.0 +).'
is_eventname = "ptev_Backup"
is_schedulename = "ptsch_Backup"

end event

