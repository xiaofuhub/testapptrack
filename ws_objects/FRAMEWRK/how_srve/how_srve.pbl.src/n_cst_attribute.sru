$PBExportHeader$n_cst_attribute.sru
$PBExportComments$Business Object base class
forward
global type n_cst_attribute from ofr_n_cst_attribute
end type
end forward

global type n_cst_attribute from ofr_n_cst_attribute
end type
global n_cst_attribute n_cst_attribute

on n_cst_attribute.create
TriggerEvent( this, "constructor" )
end on

on n_cst_attribute.destroy
TriggerEvent( this, "destructor" )
end on

