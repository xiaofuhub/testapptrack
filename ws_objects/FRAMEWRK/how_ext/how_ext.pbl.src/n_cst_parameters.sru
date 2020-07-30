$PBExportHeader$n_cst_parameters.sru
forward
global type n_cst_parameters from task_n_cst_pfcparameters
end type
end forward

global type n_cst_parameters from task_n_cst_pfcparameters
end type
global n_cst_parameters n_cst_parameters

on n_cst_parameters.create
TriggerEvent( this, "constructor" )
end on

on n_cst_parameters.destroy
TriggerEvent( this, "destructor" )
end on

