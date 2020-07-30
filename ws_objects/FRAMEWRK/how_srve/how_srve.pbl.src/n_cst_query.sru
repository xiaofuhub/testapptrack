$PBExportHeader$n_cst_query.sru
forward
global type n_cst_query from ofr_n_cst_query
end type
end forward

global type n_cst_query from ofr_n_cst_query
end type
global n_cst_query n_cst_query

on n_cst_query.create
TriggerEvent( this, "constructor" )
end on

on n_cst_query.destroy
TriggerEvent( this, "destructor" )
end on

