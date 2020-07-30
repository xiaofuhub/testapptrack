$PBExportHeader$n_cst_sso.sru
forward
global type n_cst_sso from ofr_n_cst_sso
end type
end forward

global type n_cst_sso from ofr_n_cst_sso
end type
global n_cst_sso n_cst_sso

on n_cst_sso.create
TriggerEvent( this, "constructor" )
end on

on n_cst_sso.destroy
TriggerEvent( this, "destructor" )
end on

