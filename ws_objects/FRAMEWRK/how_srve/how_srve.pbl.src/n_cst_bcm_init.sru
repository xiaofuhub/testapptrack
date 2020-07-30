$PBExportHeader$n_cst_bcm_init.sru
forward
global type n_cst_bcm_init from ofr_n_cst_bcm_init
end type
end forward

global type n_cst_bcm_init from ofr_n_cst_bcm_init
end type
global n_cst_bcm_init n_cst_bcm_init

on n_cst_bcm_init.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bcm_init.destroy
TriggerEvent( this, "destructor" )
end on

