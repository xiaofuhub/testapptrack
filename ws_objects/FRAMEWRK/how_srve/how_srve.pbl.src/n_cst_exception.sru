$PBExportHeader$n_cst_exception.sru
forward
global type n_cst_exception from ofr_n_cst_exception
end type
end forward

global type n_cst_exception from ofr_n_cst_exception
end type
global n_cst_exception n_cst_exception

on n_cst_exception.create
TriggerEvent( this, "constructor" )
end on

on n_cst_exception.destroy
TriggerEvent( this, "destructor" )
end on

