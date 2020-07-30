$PBExportHeader$ofr_n_cst_bommgr.sru
$PBExportComments$Included for compatibility only.
forward
global type ofr_n_cst_bommgr from n_cst_base
end type
end forward

global type ofr_n_cst_bommgr from n_cst_base
end type
global ofr_n_cst_bommgr ofr_n_cst_bommgr

on ofr_n_cst_bommgr.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_bommgr.destroy
TriggerEvent( this, "destructor" )
end on

