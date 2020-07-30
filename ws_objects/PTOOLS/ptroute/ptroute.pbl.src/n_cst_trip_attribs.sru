$PBExportHeader$n_cst_trip_attribs.sru
forward
global type n_cst_trip_attribs from datastore
end type
end forward

global type n_cst_trip_attribs from datastore
string DataObject="d_trip_data"
end type
global n_cst_trip_attribs n_cst_trip_attribs

type variables
string is_layer
long il_borders_open = 0
string is_unit = "miles"
decimal id_cost = 0
long il_use_shape_pts = 0
long il_hub_mode = 0
long il_alpha_order = 0
long il_convert_ll_to_place = 0
long il_break_hours = 0
long il_break_wait_hours = 0
long il_custom_mode = 0
end variables

on n_cst_trip_attribs.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on n_cst_trip_attribs.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

