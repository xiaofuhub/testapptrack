$PBExportHeader$n_cst_txmgr.sru
$PBExportComments$I no longer inherit from n_cst_pfctxmgr!!!
forward
global type n_cst_txmgr from ofr_n_cst_txmgr
end type
end forward

global type n_cst_txmgr from ofr_n_cst_txmgr
end type
global n_cst_txmgr n_cst_txmgr

on n_cst_txmgr.create
TriggerEvent( this, "constructor" )
end on

on n_cst_txmgr.destroy
TriggerEvent( this, "destructor" )
end on

