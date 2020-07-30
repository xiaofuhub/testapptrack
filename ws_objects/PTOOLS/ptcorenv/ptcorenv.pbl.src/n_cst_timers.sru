$PBExportHeader$n_cst_timers.sru
$PBExportComments$[n_base]
forward
global type n_cst_timers from n_base
end type
end forward

global type n_cst_timers from n_base
end type
global n_cst_timers n_cst_timers

type variables
PRIVATE:
n_cst_timing_StatusRequest	inv_StatusRequest
n_cst_timing_Notification	inv_Notification
end variables

forward prototypes
public function integer of_starttimer (string as_timer)
private function integer of_startstatusrequest ()
private function integer of_stopstatusrequest ()
public function integer of_stoptimer (string as_timer)
public function boolean of_isrunning (string as_timer)
public function boolean of_isstatusrequestrunning ()
public function boolean of_isnotificationrunning ()
private function integer of_startnotification ()
private function integer of_stopnotification ()
public function integer of_stopalltimers ()
public function integer of_setstatusrequestblackout (time at_start, time at_end)
end prototypes

public function integer of_starttimer (string as_timer);CHOOSE CASE as_Timer
		
	CASE n_cst_constants.cs_Timer_StatusRequest
		THIS.of_StartStatusRequest ( )
		
// RDT 5-13-03 //	CASE n_cst_constants.cs_Timer_Notification
// RDT 5-13-03 //		THIS.of_StartNotification ( )

	CASE ELSE
		
END CHOOSE

RETURN 1
end function

private function integer of_startstatusrequest ();// RDT 5-06-03 Changed to minutes ( * 60)
Long	ll_Interval
Any	la_Value
String	ls_Blackout

n_cst_settings	lnv_Settings

IF lnv_Settings.of_GetSetting ( 114 , la_Value ) = 1 THEN
 	//ll_Interval = Long ( la_Value ) * 60 	
	ll_Interval = Long ( la_Value ) * 60
ELSE
	ll_Interval = 60
END IF

IF lnv_Settings.of_GetSetting ( 152 , la_Value ) = 1 THEN
	ls_Blackout = String ( la_Value ) 
END IF

inv_StatusRequest = CREATE n_cst_Timing_StatusRequest
inv_StatusRequest.of_SetBlackoutTime ( ls_Blackout )
inv_StatusRequest.Start ( ll_Interval )

RETURN 1


end function

private function integer of_stopstatusrequest ();IF isValid ( inv_StatusRequest ) THEN
	inv_StatusRequest.Stop ( )
	DESTROY ( inv_StatusRequest )
END IF

RETURN 1
end function

public function integer of_stoptimer (string as_timer);CHOOSE CASE as_Timer
		
	CASE n_cst_constants.cs_Timer_StatusRequest
		THIS.of_StopStatusRequest ( )

	CASE n_cst_constants.cs_Timer_Notification
		THIS.of_StopNotification ( )
		
	CASE ELSE

END CHOOSE

RETURN 1

end function

public function boolean of_isrunning (string as_timer);Boolean	lb_Return

CHOOSE CASE as_Timer
		
	CASE n_cst_Constants.cs_timer_StatusRequest
		lb_Return = THIS.of_IsStatusRequestRunning ( )
		
	CASE n_cst_Constants.cs_timer_Notification
		lb_Return = THIS.of_IsNotificationRunning ( )

CASE ELSE
		
END CHOOSE

RETURN lb_Return
end function

public function boolean of_isstatusrequestrunning ();boolean	lb_Return

IF IsValid ( inv_StatusRequest ) THEN
	lb_Return = inv_StatusRequest.Running
END IF

RETURN lb_Return
end function

public function boolean of_isnotificationrunning ();// RDT 5-06-03 New Method
boolean	lb_Return

IF IsValid ( inv_notification ) THEN
	lb_Return = inv_notification.Running
END IF

RETURN lb_Return
end function

private function integer of_startnotification ();// RDT 5-06-03 New Method
Long	ll_Interval
Any	la_Value
n_cst_settings	lnv_Settings

IF lnv_Settings.of_GetSetting ( 114 , la_Value ) = 1 THEN
	ll_Interval = Long ( la_Value ) * 60
ELSE
	ll_Interval = 60
END IF

inv_Notification = CREATE n_cst_Timing_Notification

inv_Notification.Start ( ll_Interval )

RETURN 1


end function

private function integer of_stopnotification ();// RDT 5-06-03 New Method
IF isValid ( inv_Notification ) THEN
	inv_Notification.Stop ( )
	DESTROY ( inv_Notification )
END IF

RETURN 1
end function

public function integer of_stopalltimers ();// RDT 5-06-03 New Method

If This.of_IsRunning ( n_cst_constants.cs_timer_statusrequest ) Then 
	THIS.of_StopStatusRequest ( )
End IF

If This.of_IsRunning (n_cst_constants.cs_timer_notification ) Then 
	THIS.of_StopNotification ( )
End If

return 1
end function

public function integer of_setstatusrequestblackout (time at_start, time at_end);Int		li_Return = 1
String	ls_Value

ls_Value = String ( at_start )+ "*" + String ( at_end )

IF IsValid ( inv_statusrequest ) THEN
	inv_statusrequest.of_SetBlackoutTime ( ls_Value )
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

on n_cst_timers.create
TriggerEvent( this, "constructor" )
end on

on n_cst_timers.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;// there should be a stop all method but i will implement this when we have more than one timer

// RDT 5-06-03 Added of_StopAllTimers
//THIS.of_StopStatusRequest ( )
This.of_StopAllTimers()


end event

