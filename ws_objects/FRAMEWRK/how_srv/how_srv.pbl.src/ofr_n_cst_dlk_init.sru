$PBExportHeader$ofr_n_cst_dlk_init.sru
forward
global type ofr_n_cst_dlk_init from n_cst_base
end type
end forward

global type ofr_n_cst_dlk_init from n_cst_base
end type
global ofr_n_cst_dlk_init ofr_n_cst_dlk_init

type variables
public:

n_bcm_ds ids_view
transaction itrx_view
n_cst_bcm inv_bcm
end variables

on ofr_n_cst_dlk_init.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_dlk_init.destroy
TriggerEvent( this, "destructor" )
end on

