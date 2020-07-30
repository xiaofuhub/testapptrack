$PBExportHeader$n_cst_filesrvwin16.sru
$PBExportComments$Extension Win16 File handler service
forward
global type n_cst_filesrvwin16 from pfc_n_cst_filesrvwin16
end type
end forward

global type n_cst_filesrvwin16 from pfc_n_cst_filesrvwin16
end type
global n_cst_filesrvwin16 n_cst_filesrvwin16

on n_cst_filesrvwin16.create
TriggerEvent( this, "constructor" )
end on

on n_cst_filesrvwin16.destroy
TriggerEvent( this, "destructor" )
end on

