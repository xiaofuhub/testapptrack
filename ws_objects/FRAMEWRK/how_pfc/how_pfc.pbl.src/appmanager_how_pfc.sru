$PBExportHeader$appmanager_how_pfc.sru
$PBExportComments$NVO which is used to regenerate the DBF and Task objects.  Do not use this object  for anything else.
forward
global type appmanager_how_pfc from n_cst_appmanager
end type
end forward

global type appmanager_how_pfc from n_cst_appmanager
end type
global appmanager_how_pfc appmanager_how_pfc

type variables
n_cst_taskmanager inv_taskmanager
end variables

on appmanager_how_pfc.create
TriggerEvent( this, "constructor" )
end on

on appmanager_how_pfc.destroy
TriggerEvent( this, "destructor" )
end on

