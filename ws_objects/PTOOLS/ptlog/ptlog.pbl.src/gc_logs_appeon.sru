$PBExportHeader$gc_logs_appeon.sru
forward
global type gc_logs_appeon from nonvisualobject
end type
end forward

global type gc_logs_appeon from nonvisualobject autoinstantiate
end type

type variables
Constant String	cs_Status_Unknown = "0"
Constant String	cs_Status_OffDuty = "1"
Constant String	cs_Status_Sleeper = "2"
Constant String	cs_Status_Driving = "3"
Constant String	cs_Status_OnDuty = "4"
Constant String	cs_Status_Lost = "5"
Constant String	cs_Status_AirRadius = "6"
Constant String	cs_Status_Startup = "7"
Constant String	cs_Status_New = "8"


Constant Integer	ci_ViolationType_Other = 0
Constant Integer	ci_ViolationType_DrivingTime = 1
Constant Integer	ci_ViolationType_DutyTime = 2
Constant Integer	ci_ViolationType_WeeklyTime = 3
Constant Integer	ci_ViolationType_MPH = 4
Constant Integer	ci_ViolationType_Receipts = 5
Constant Integer	ci_ViolationType_Documentation = 6
Constant Integer	ci_ViolationType_LostLog = 7
Constant Integer	ci_ViolationType_AirRadius = 8
end variables

on gc_logs_appeon.create
call super::create
TriggerEvent( this, "constructor" )
end on

on gc_logs_appeon.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

