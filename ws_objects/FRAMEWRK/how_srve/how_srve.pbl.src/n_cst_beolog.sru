$PBExportHeader$n_cst_beolog.sru
$PBExportComments$BEO Logging Services
forward
global type n_cst_beolog from ofr_n_cst_beolog
end type
end forward

global type n_cst_beolog from ofr_n_cst_beolog
end type
global n_cst_beolog n_cst_beolog

on n_cst_beolog.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beolog.destroy
TriggerEvent( this, "destructor" )
end on

