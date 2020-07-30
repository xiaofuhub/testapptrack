$PBExportHeader$n_cst_object.sru
forward
global type n_cst_object from nonvisualobject
end type
end forward

global type n_cst_object from nonvisualobject
end type
global n_cst_object n_cst_object

type variables
public:
datastore ids_data
end variables

event destructor;destroy ids_data
end event

event constructor;ids_data = create datastore
end event

on n_cst_object.create
TriggerEvent( this, "constructor" )
end on

on n_cst_object.destroy
TriggerEvent( this, "destructor" )
end on

