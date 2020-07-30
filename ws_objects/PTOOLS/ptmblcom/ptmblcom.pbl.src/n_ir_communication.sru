$PBExportHeader$n_ir_communication.sru
forward
global type n_ir_communication from internetresult
end type
end forward

global type n_ir_communication from internetresult
end type
global n_ir_communication n_ir_communication

type variables
Blob	iblb_Data
end variables

forward prototypes
public function integer internetdata (blob ablb_data)
end prototypes

public function integer internetdata (blob ablb_data);iblb_Data = ablb_Data
RETURN 1
end function

on n_ir_communication.create
call internetresult::create
TriggerEvent( this, "constructor" )
end on

on n_ir_communication.destroy
call internetresult::destroy
TriggerEvent( this, "destructor" )
end on

