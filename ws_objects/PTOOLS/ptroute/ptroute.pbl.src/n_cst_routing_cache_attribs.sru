$PBExportHeader$n_cst_routing_cache_attribs.sru
forward
global type n_cst_routing_cache_attribs from datastore
end type
end forward

global type n_cst_routing_cache_attribs from datastore
string DataObject="d_cache_data"
end type
global n_cst_routing_cache_attribs n_cst_routing_cache_attribs

on n_cst_routing_cache_attribs.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on n_cst_routing_cache_attribs.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

