$PBExportHeader$n_cst_beokey.sru
$PBExportComments$Business Object base class
forward
global type n_cst_beokey from ofr_n_cst_beokey
end type
end forward

global type n_cst_beokey from ofr_n_cst_beokey
end type
global n_cst_beokey n_cst_beokey

on n_cst_beokey.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beokey.destroy
TriggerEvent( this, "destructor" )
end on

