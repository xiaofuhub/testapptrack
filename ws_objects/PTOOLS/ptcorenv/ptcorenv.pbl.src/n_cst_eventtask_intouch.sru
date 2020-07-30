$PBExportHeader$n_cst_eventtask_intouch.sru
forward
global type n_cst_eventtask_intouch from n_cst_eventtask_mobilcomm
end type
end forward

global type n_cst_eventtask_intouch from n_cst_eventtask_mobilcomm
end type
global n_cst_eventtask_intouch n_cst_eventtask_intouch

event constructor;call super::constructor;is_taskdescription =   "This is the process that sends and receives information via Intouch mobile devices."
is_Tabpagelabel = "InTouch"
is_eventname = "ptev_intouch"
is_schedulename = "ptsch_intouch" 
is_Procedurename = "ptsp_intouch"

is_device = "INTOUCH"
end event

on n_cst_eventtask_intouch.create
call super::create
end on

on n_cst_eventtask_intouch.destroy
call super::destroy
end on

