$PBExportHeader$n_cst_fsi_import_item.sru
forward
global type n_cst_fsi_import_item from nonvisualobject
end type
end forward

global type n_cst_fsi_import_item from nonvisualobject
end type
global n_cst_fsi_import_item n_cst_fsi_import_item

type variables
Public:
string is_Description
decimal ic_Weight
decimal ic_Quantity
decimal ic_Charge
end variables

on n_cst_fsi_import_item.create
TriggerEvent( this, "constructor" )
end on

on n_cst_fsi_import_item.destroy
TriggerEvent( this, "destructor" )
end on

