$PBExportHeader$n_cst_txsrv.sru
forward
global type n_cst_txsrv from ofr_n_cst_pfctxsrv
end type
end forward

global type n_cst_txsrv from ofr_n_cst_pfctxsrv
end type
global n_cst_txsrv n_cst_txsrv

on n_cst_txsrv.create
TriggerEvent( this, "constructor" )
end on

on n_cst_txsrv.destroy
TriggerEvent( this, "destructor" )
end on

