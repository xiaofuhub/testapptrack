$PBExportHeader$n_cst_eventtask_qualcomm.sru
forward
global type n_cst_eventtask_qualcomm from n_cst_eventtask_mobilcomm
end type
end forward

global type n_cst_eventtask_qualcomm from n_cst_eventtask_mobilcomm
end type
global n_cst_eventtask_qualcomm n_cst_eventtask_qualcomm

event constructor;call super::constructor;is_taskdescription =   "This is the process that sends and receives information via Qualcomm mobile devices."
is_Tabpagelabel = "QualComm"
is_eventname = "ptev_qualcomm"
is_schedulename = "ptsch_qualcomm" 
is_Procedurename = "ptsp_qualcomm"

is_device = "QUALCOMM"
end event

on n_cst_eventtask_qualcomm.create
call super::create
end on

on n_cst_eventtask_qualcomm.destroy
call super::destroy
end on

