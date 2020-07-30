$PBExportHeader$n_cst_eventtask_atroad.sru
forward
global type n_cst_eventtask_atroad from n_cst_eventtask_mobilcomm
end type
end forward

global type n_cst_eventtask_atroad from n_cst_eventtask_mobilcomm
end type
global n_cst_eventtask_atroad n_cst_eventtask_atroad

on n_cst_eventtask_atroad.create
call super::create
end on

on n_cst_eventtask_atroad.destroy
call super::destroy
end on

event constructor;call super::constructor;is_taskdescription =   "This is the process that sends and receives information via AtRoad mobile devices."
is_Tabpagelabel = "AtRoad"
is_eventname = "ptev_atroad"
is_schedulename = "ptsch_atroad" 
is_Procedurename = "ptsp_atroad"

is_device = "ATROAD"
end event

