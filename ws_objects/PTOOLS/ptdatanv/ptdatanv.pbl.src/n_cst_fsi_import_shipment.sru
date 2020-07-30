$PBExportHeader$n_cst_fsi_import_shipment.sru
forward
global type n_cst_fsi_import_shipment from nonvisualobject
end type
end forward

global type n_cst_fsi_import_shipment from nonvisualobject
end type
global n_cst_fsi_import_shipment n_cst_fsi_import_shipment

type variables
Public:
string is_Pronum
string is_CarrierId
string is_CustomerRef
string is_QuoteNumber
string is_BilltoId
string is_ShipNote
string is_BillNote
datetime idt_ShipDate
decimal ic_CarrierPayable
n_cst_fsi_import_item inva_items []
end variables

on n_cst_fsi_import_shipment.create
TriggerEvent( this, "constructor" )
end on

on n_cst_fsi_import_shipment.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;Integer	li_Index, &
			li_IndexMax
			
li_IndexMax = upperbound ( inva_items ) 

FOR li_Index = 1 to li_IndexMax

	IF isvalid ( inva_items[li_Index] ) THEN
		destroy inva_items[li_Index]
	END IF
	
NEXT
end event

