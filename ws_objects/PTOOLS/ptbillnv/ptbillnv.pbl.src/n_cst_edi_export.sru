$PBExportHeader$n_cst_edi_export.sru
forward
global type n_cst_edi_export from n_cst_base
end type
end forward

global type n_cst_edi_export from n_cst_base
end type
global n_cst_edi_export n_cst_edi_export

on n_cst_edi_export.create
TriggerEvent( this, "constructor" )
end on

on n_cst_edi_export.destroy
TriggerEvent( this, "destructor" )
end on

