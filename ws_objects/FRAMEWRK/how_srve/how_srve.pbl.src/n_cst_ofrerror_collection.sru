$PBExportHeader$n_cst_ofrerror_collection.sru
forward
global type n_cst_ofrerror_collection from ofr_n_cst_ofrerror_collection
end type
end forward

global type n_cst_ofrerror_collection from ofr_n_cst_ofrerror_collection
end type
global n_cst_ofrerror_collection n_cst_ofrerror_collection

on n_cst_ofrerror_collection.create
TriggerEvent( this, "constructor" )
end on

on n_cst_ofrerror_collection.destroy
TriggerEvent( this, "destructor" )
end on

