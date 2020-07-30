$PBExportHeader$n_cst_eventtask_cadec.sru
forward
global type n_cst_eventtask_cadec from n_cst_eventtask_mobilcomm
end type
end forward

global type n_cst_eventtask_cadec from n_cst_eventtask_mobilcomm
end type
global n_cst_eventtask_cadec n_cst_eventtask_cadec

event constructor;call super::constructor;is_taskdescription =   "This is the process that imports information submitted via Cadec mobile devices."
is_Tabpagelabel = "Cadec"
is_eventname = "ptev_cadec"
is_schedulename = "ptsch_cadec" 
is_Procedurename = "ptsp_cadec"

is_device = "CADEC"
end event

on n_cst_eventtask_cadec.create
call super::create
end on

on n_cst_eventtask_cadec.destroy
call super::destroy
end on

