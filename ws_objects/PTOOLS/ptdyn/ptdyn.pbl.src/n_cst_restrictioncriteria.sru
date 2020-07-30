$PBExportHeader$n_cst_restrictioncriteria.sru
forward
global type n_cst_restrictioncriteria from nonvisualobject
end type
end forward

global type n_cst_restrictioncriteria from nonvisualobject
end type
global n_cst_restrictioncriteria n_cst_restrictioncriteria

type variables
Public:

	Long	il_withinDistance
	Long	il_outZip
	Long	il_intoZip
	
	Boolean	ib_into
	Boolean	ib_outof
	Boolean	ib_current
	Boolean	ib_firstLast
	Boolean 	ib_allLocations
	
	String	is_outOfCity
	String	is_outOfState
	String	is_intoCity
	String	is_intoState
	
	String  	is_into_foundPCM
	String	is_outOf_foundPCM
	
	String	is_tab		//must be set to one of the following
	
	Constant String 		cs_shipments = "SHIPMENTS"
	Constant String		cs_driverEquip = "DRIVER_EQUIP"
	Constant String 		cs_Drivers = "DRIVERS"
	Constant String 		cs_Equipment = "EQUIPMENT"
	
	
	
end variables

on n_cst_restrictioncriteria.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_restrictioncriteria.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

