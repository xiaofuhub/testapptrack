$PBExportHeader$n_cst_database.sru
forward
global type n_cst_database from ofr_n_cst_database
end type
end forward

global type n_cst_database from ofr_n_cst_database
end type
global n_cst_database n_cst_database

on n_cst_database.create
TriggerEvent( this, "constructor" )
end on

on n_cst_database.destroy
TriggerEvent( this, "destructor" )
end on

