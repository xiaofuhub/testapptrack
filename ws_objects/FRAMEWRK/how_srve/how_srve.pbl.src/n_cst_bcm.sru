$PBExportHeader$n_cst_bcm.sru
$PBExportComments$Business Object Manager base class
forward
global type n_cst_bcm from ofr_n_cst_bcm
end type
end forward

global type n_cst_bcm from ofr_n_cst_bcm
end type
global n_cst_bcm n_cst_bcm

on n_cst_bcm.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bcm.destroy
TriggerEvent( this, "destructor" )
end on

