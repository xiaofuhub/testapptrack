$PBExportHeader$n_cst_winsrv_linkages.sru
forward
global type n_cst_winsrv_linkages from task_n_cst_winsrv_pfclinkages
end type
end forward

global type n_cst_winsrv_linkages from task_n_cst_winsrv_pfclinkages
end type
global n_cst_winsrv_linkages n_cst_winsrv_linkages

on n_cst_winsrv_linkages.create
TriggerEvent( this, "constructor" )
end on

on n_cst_winsrv_linkages.destroy
TriggerEvent( this, "destructor" )
end on

