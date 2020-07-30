$PBExportHeader$n_cst_mediator.sru
forward
global type n_cst_mediator from n_base
end type
end forward

shared variables
long	sl_NextObjectID
end variables

global type n_cst_mediator from n_base
end type
global n_cst_mediator n_cst_mediator

type variables
PROTECTED:

Long	il_NextID
end variables

forward prototypes
public function long of_getnextobjectid ()
end prototypes

public function long of_getnextobjectid ();il_nextid++
Return il_nextid
end function

on n_cst_mediator.create
TriggerEvent( this, "constructor" )
end on

on n_cst_mediator.destroy
TriggerEvent( this, "destructor" )
end on

