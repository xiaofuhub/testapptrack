$PBExportHeader$n_cst_timer_eventhandler.sru
$PBExportComments$[n_base]
forward
global type n_cst_timer_eventhandler from timing
end type
end forward

global type n_cst_timer_eventhandler from timing
end type
global n_cst_timer_eventhandler n_cst_timer_eventhandler

type variables
n_cst_eventmanager	inv_Manager
Time	it_KillTime
end variables

forward prototypes
public function integer of_setkilltime (time at_value)
end prototypes

public function integer of_setkilltime (time at_value);it_killtime = at_value
RETURN 1
end function

on n_cst_timer_eventhandler.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_timer_eventhandler.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;call super::constructor;inv_manager = CREATE n_cst_eventmanager	

SetNull ( it_killtime ) 
end event

event timer;IF Not inv_manager.of_isprocessing( ) THEN
	
	Time lt_now
	lt_now = NOW ( )
	IF lt_now > it_killtime AND lt_now < RelativeTime ( it_killtime , ( 60 * 10 ) ) THEN
		// give a 10 minute window for the app to be shut down. 
		// this way you can shut it down in the am and start it back up in the am
		// 10 minutes after the kill time
		gnv_app.event ue_stopeventscheduler( )
		gnv_app.event pfc_exit( )
	ELSE	
		inv_manager.of_executenexttask( )
	END IF
END IF
end event

