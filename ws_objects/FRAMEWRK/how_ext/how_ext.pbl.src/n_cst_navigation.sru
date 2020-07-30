$PBExportHeader$n_cst_navigation.sru
$PBExportComments$Navigation Root Class
forward
global type n_cst_navigation from task_n_cst_navigation
end type
end forward

global type n_cst_navigation from task_n_cst_navigation
end type
global n_cst_navigation n_cst_navigation

on n_cst_navigation.create
TriggerEvent( this, "constructor" )
end on

on n_cst_navigation.destroy
TriggerEvent( this, "destructor" )
end on

