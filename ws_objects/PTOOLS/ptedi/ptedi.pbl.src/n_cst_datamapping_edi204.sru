$PBExportHeader$n_cst_datamapping_edi204.sru
forward
global type n_cst_datamapping_edi204 from n_cst_datamapping
end type
end forward

global type n_cst_datamapping_edi204 from n_cst_datamapping
end type
global n_cst_datamapping_edi204 n_cst_datamapping_edi204

forward prototypes
public function string of_getsource (string as_target)
public function string of_getsettingforaction (string as_Action)
end prototypes

public function string of_getsource (string as_target);String	ls_Return 

ls_Return = THIS.of_GetSource ( "EDI204" , "I" , 0 , "SHIPMENT" , Upper( as_target ) )


RETURN ls_Return
end function

public function string of_getsettingforaction (string as_Action);String	ls_Return 

ls_Return = THIS.of_GetSettingForAction ( "EDI204" , "I" , 0 ,  as_Action )


RETURN ls_Return
end function

on n_cst_datamapping_edi204.create
TriggerEvent( this, "constructor" )
end on

on n_cst_datamapping_edi204.destroy
TriggerEvent( this, "destructor" )
end on

