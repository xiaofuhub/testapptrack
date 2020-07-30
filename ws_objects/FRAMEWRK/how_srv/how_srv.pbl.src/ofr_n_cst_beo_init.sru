$PBExportHeader$ofr_n_cst_beo_init.sru
forward
global type ofr_n_cst_beo_init from n_cst_base
end type
end forward

global type ofr_n_cst_beo_init from n_cst_base
end type
global ofr_n_cst_beo_init ofr_n_cst_beo_init

type variables
nonvisualobject inv_bcm
long il_beo_index

end variables

on ofr_n_cst_beo_init.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_beo_init.destroy
TriggerEvent( this, "destructor" )
end on

