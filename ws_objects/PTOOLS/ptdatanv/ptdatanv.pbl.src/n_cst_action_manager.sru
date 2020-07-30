$PBExportHeader$n_cst_action_manager.sru
$PBExportComments$[n_base]
forward
global type n_cst_action_manager from n_base
end type
end forward

global type n_cst_action_manager from n_base
end type
global n_cst_action_manager n_cst_action_manager

on n_cst_action_manager.create
TriggerEvent( this, "constructor" )
end on

on n_cst_action_manager.destroy
TriggerEvent( this, "destructor" )
end on

