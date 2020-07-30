$PBExportHeader$n_cst_scheduledata.sru
forward
global type n_cst_scheduledata from n_base
end type
end forward

global type n_cst_scheduledata from n_base
end type
global n_cst_scheduledata n_cst_scheduledata

type variables
PRIVATE:
Boolean	ib_Enabled
Time		it_Start
Time		it_End
Int		ii_Period
String	is_PeriodUnits
String	isa_Days[]
String	is_Schedulename
String	is_EventName
String	is_Remarks
Int		il_EventID
Int		ii_Days // bitwise rep

String	is_OriginalSql

Constant	String	cs_Sun = 'sunday'
Constant	String	cs_Mon = 'monday'
Constant	String	cs_Tues = 'tuesday'
Constant	String	cs_Wed = 'wednesday'
Constant	String	cs_Thurs = 'thursday'
Constant	String	cs_Fri = 'friday'
Constant	String	cs_Sat = 'saturday'


n_cst_EventTask	inv_Task

end variables

forward prototypes
public function time of_getstarttime ()
public function time of_getendtime ()
public function integer of_setstarttime (time at_value)
public function integer of_setendtime (time at_value)
public function boolean of_getenabled ()
public function integer of_setenabled (boolean ab_value)
public function integer of_getperiod ()
public function any of_setperiod (integer ai_value)
public function string of_getperiodunits ()
public function integer of_setperiodunits (string as_value)
public function integer of_setdays (string asa_days[])
public function string of_getschedulename ()
public function integer of_setschedulename (string as_value)
public function string of_geteventname ()
public function integer of_seteventname (string as_value)
public function integer of_retrievescheduledata ()
private function integer of_setdaysoftheweek (integer ai_value)
private function string of_getdays ()
public function boolean of_getrunondayofweek (integer ai_day)
public function integer of_setrunondayofweek (integer ai_day, boolean ab_value)
public function integer of_update ()
public function string of_getremarks ()
public function string of_gettaskdescription ()
public function integer of_seteventtask (n_cst_eventtask anv_task)
private function boolean of_doeseventexist (string as_eventname)
public function integer of_settask (string as_taskname)
public function string of_gettabpagelabel ()
public function string of_getoriginalsql ()
public function string of_buildschedulesql ()
end prototypes

public function time of_getstarttime ();RETURN it_Start
end function

public function time of_getendtime ();RETURN it_End
end function

public function integer of_setstarttime (time at_value);it_Start = at_value
RETURN 1
end function

public function integer of_setendtime (time at_value);it_End = at_value
RETURN 1
end function

public function boolean of_getenabled ();RETURN ib_enabled
end function

public function integer of_setenabled (boolean ab_value);ib_enabled = ab_value
RETURN 1
end function

public function integer of_getperiod ();RETURN ii_period
end function

public function any of_setperiod (integer ai_value);ii_period = ai_value
RETURN 1


end function

public function string of_getperiodunits ();String	ls_Return
CHOOSE CASE is_Periodunits
		
	CASE "HH" , "hours"
		ls_Return = "hours"
	CASE "NN" , "minutes"
		ls_Return = "minutes"
	CASE "SS" , "seconds"
		ls_Return = "seconds"
END CHOOSE

Return ls_Return
end function

public function integer of_setperiodunits (string as_value);is_periodunits =as_value
RETURN 1
end function

public function integer of_setdays (string asa_days[]);isa_days = asa_days[] 
RETURN 1
end function

public function string of_getschedulename ();Return is_Schedulename
end function

public function integer of_setschedulename (string as_value);is_Schedulename = As_value
RETURN 1
end function

public function string of_geteventname ();RETURN is_Eventname
end function

public function integer of_seteventname (string as_value);is_Eventname = as_value
RETURN 1
end function

public function integer of_retrievescheduledata ();Long		ll_EventID
Time     lt_StartTime   
Time     lt_EndTime  
String   ls_IntervalUnits   
int      li_Interval
Int      li_DaysofWeek  
Int		li_Return = 1
String	ls_EventName
String	ls_ScheduleName
String	ls_Remarks
Char		lch_Enabled


If IsValid ( inv_Task ) THEN
	ls_EventName = inv_Task.of_GetEventName ( )
END IF
	
IF Len ( ls_EventName ) > 0 THEN
	
	THIS.of_Seteventname( ls_EventName )

	IF THIS.of_Doeseventexist( ls_EventName ) = FALSE THEN	
		inv_task.of_CreateEventInDB ( )
	END IF

  SELECT "sys"."sysschedule"."event_id", 
			"sys"."sysschedule"."sched_name", 
			"sys"."sysschedule"."start_time",   
			"sys"."sysschedule"."stop_time",                
			"sys"."sysschedule"."interval_units",   
			"sys"."sysschedule"."interval_amt",   
			"sys"."sysschedule"."days_of_week"  ,  
			"sys"."sysevent"."enabled" ,
			"sys"."sysevent"."remarks" 
	 INTO :ll_EventID,  
			:ls_ScheduleName,
			:lt_StartTime,   
			:lt_EndTime,               
			:ls_IntervalUnits,   
			:li_Interval,   
			:li_DaysofWeek ,
			:lch_Enabled,
			:ls_Remarks
	 FROM "sys"."sysschedule" ,
			 "sys"."sysevent" 
	WHERE ( "sys"."sysschedule"."event_id" = "sys"."sysevent"."event_id" ) and  
			( ( "sys"."sysevent"."event_name" = :ls_EventName ) )  ;
	 
	 
	IF Sqlca.Sqlcode = 0 THEN
		li_Return = 1
		COMMIT;
	ELSE
		li_Return = -1
		RollBack;
	END IF		
	 
END IF

IF li_Return = 1 THEN
	is_Schedulename = ls_ScheduleName
	il_EventID = ll_EventID
	ib_Enabled = lch_Enabled = 'Y'
	it_start = lt_StartTime
	it_End = lt_EndTime
	ii_period = li_Interval
	is_periodunits = ls_IntervalUnits
	THIS.of_SetDaysoftheweek( li_DaysofWeek )
	is_Remarks = ls_Remarks

END IF

is_originalsql = THIS.of_Buildschedulesql( )


RETURN 1






end function

private function integer of_setdaysoftheweek (integer ai_value);If isNull ( ai_Value ) THEN
	ii_Days = 0
ELSE
	ii_days = ai_value
END IF

RETURN 1
end function

private function string of_getdays ();//ai_Value is a bit-wise repesentation of the days of the week 
// 1st bit is sunday, 7th is sat, 

Int		i
String	lsa_Days[7] = { cs_Sun, cs_Mon, cs_Tues , cs_Wed , cs_Thurs,  cs_Fri , cs_Sat }
String	ls_Return

n_cst_numerical	lnv_Num

FOR i = 1 TO 7

	IF lnv_Num.of_getbit( ii_Days , i ) THEN 
		IF Len ( ls_Return ) > 0 THEN
			ls_Return += ","
		END IF
		ls_Return += "'" + lsa_Days[i] + "'"
		
	END IF
	
NEXT 

RETURN ls_Return
end function

public function boolean of_getrunondayofweek (integer ai_day);// sunday = 1
Boolean	lb_Return
n_cst_numerical lnv_Num

lb_Return = lnv_Num.of_getbit( ii_days , ai_Day ) 

RETURN lb_Return
end function

public function integer of_setrunondayofweek (integer ai_day, boolean ab_value);n_cst_Numerical	lnv_Numerical

IF ai_Day > 0 AND ai_day < 8 THEN
	ii_days = lnv_Numerical.of_Setbit( ii_days , ai_day , ab_value )
END IF

RETURN 1
end function

public function integer of_update ();String	ls_Sql
Int		li_Return 

ls_Sql = THIS.of_Buildschedulesql( )

Execute IMMEDIATE :ls_Sql;

IF SQLCA.Sqlcode = 0 THEN
	COMMIT;
	li_Return = 1
ELSE
	ROLLBACK;
	li_Return = -1
END IF


RETURN li_Return
end function

public function string of_getremarks ();Return is_Remarks
end function

public function string of_gettaskdescription ();String	ls_Description

IF IsValid ( inv_Task ) THEN
	ls_Description = inv_Task.of_Getdescription( )
END IF

RETURN ls_Description
end function

public function integer of_seteventtask (n_cst_eventtask anv_task);inv_task = anv_task
THIS.of_Retrievescheduledata( )
RETURN 1
end function

private function boolean of_doeseventexist (string as_eventname);Boolean	lb_Return
Long		ll_EventID
String	ls_Name

ls_Name = as_eventname
  
  SELECT "sys"."sysevent"."event_id"  
    INTO :ll_EventID  
    FROM "sys"."sysevent"  
   WHERE "sys"."sysevent"."event_name" = :ls_Name   ;
	
	
	IF SQLCA.SQlcode = 0 THEN
		lb_Return = TRUE
		Commit;
	ELSE
		lb_Return = FALSE
		Rollback;
	END IF

RETURN lb_Return
end function

public function integer of_settask (string as_taskname);Int	li_Return
inv_Task = CREATE USING "n_Cst_eventTask_" + as_taskname
IF isValid (inv_task) THEN
	THIS.of_retrievescheduledata( )
	li_Return = 1 
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function string of_gettabpagelabel ();String	ls_Return

IF IsValid ( inv_task ) THEN
	ls_Return = inv_task.of_gettabpagelabel( )
END IF

RETURN ls_Return
end function

public function string of_getoriginalsql ();RETURN is_originalsql
end function

public function string of_buildschedulesql ();String	ls_EventName
String	ls_ScheduleName
Time		lt_Start
Time		lt_End
Int		li_Period
String	ls_PeriodUnits
String	ls_DaysofTheWeek
String	ls_Enable
String	ls_Sql

ls_EventName = THIS.of_Geteventname( )
ls_ScheduleName = THIS.of_Getschedulename( )
lt_Start = THIS.of_GetStarttime( )
lt_End = THIS.of_GetEndtime( )
li_Period = THIS.of_Getperiod( )
ls_PeriodUnits = Upper ( of_GetPeriodunits( ) )
ls_DaysofTheWeek = THIS.of_GetDays( )
IF ib_enabled THEN
	ls_Enable = "ENABLE"
ELSE
	ls_Enable = "DISABLE"
END IF


ls_Sql = "ALTER EVENT " + ls_EventName + " " + &
			"SCHEDULE " + ls_ScheduleName + " " + &
			"BETWEEN '" + String ( lt_Start ) + "' AND '" + String ( lt_End ) + "' " + &
			"EVERY " + String ( li_Period ) + " " + ls_PeriodUnits + " "
			IF Len ( ls_DaysofTheWeek ) > 0 THEN
				ls_Sql += "ON (" + ls_DaysofTheWeek + ")"
			END IF
			ls_Sql += ls_Enable
								
RETURN ls_Sql

end function

on n_cst_scheduledata.create
call super::create
end on

on n_cst_scheduledata.destroy
call super::destroy
end on

event destructor;call super::destructor;Destroy ( inv_task )
end event

