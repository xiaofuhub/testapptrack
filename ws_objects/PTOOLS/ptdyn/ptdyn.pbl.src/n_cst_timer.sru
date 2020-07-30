$PBExportHeader$n_cst_timer.sru
forward
global type n_cst_timer from timing
end type
end forward

global type n_cst_timer from timing
end type
global n_cst_timer n_cst_timer

type variables
Private PowerObject	ipo_Requester
Private String			is_TimerEvent = "ue_timer"
end variables

forward prototypes
public function integer of_setrequester (powerobject apo_requester)
public function integer of_settimerevent (string as_timerevent)
public function string of_gettimerevent ()
public function powerobject of_getrequester ()
end prototypes

public function integer of_setrequester (powerobject apo_requester);ipo_Requester = apo_Requester

Return 1
end function

public function integer of_settimerevent (string as_timerevent);Integer	li_Return = 1

as_TimerEvent = Trim ( as_TimerEvent )

IF Len ( as_TimerEvent ) > 0 THEN
	is_TimerEvent = as_TimerEvent
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

public function string of_gettimerevent ();RETURN is_TimerEvent
end function

public function powerobject of_getrequester ();RETURN ipo_Requester
end function

on n_cst_timer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_timer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;//Trigger the timer event that has been set for this service instance.
//If no event has been set, a default event -- ue_timer -- will be used.

IF IsValid(ipo_Requester) THEN
	ipo_Requester.TriggerEvent ( This.of_GetTimerEvent ( ) )
END IF




end event

