$PBExportHeader$n_cst_base.sru
forward
global type n_cst_base from ofr_n_cst_base
end type
end forward

global type n_cst_base from ofr_n_cst_base
end type
global n_cst_base n_cst_base

on n_cst_base.create
TriggerEvent( this, "constructor" )
end on

on n_cst_base.destroy
TriggerEvent( this, "destructor" )
end on

