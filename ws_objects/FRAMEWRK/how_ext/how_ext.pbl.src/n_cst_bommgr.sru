$PBExportHeader$n_cst_bommgr.sru
$PBExportComments$Included for compatibility only.
forward
global type n_cst_bommgr from ofr_n_cst_bommgr
end type
end forward

global type n_cst_bommgr from ofr_n_cst_bommgr
end type
global n_cst_bommgr n_cst_bommgr

on n_cst_bommgr.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bommgr.destroy
TriggerEvent( this, "destructor" )
end on

