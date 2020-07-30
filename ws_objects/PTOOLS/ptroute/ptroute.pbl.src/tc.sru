$PBExportHeader$tc.sru
forward
global type tc from nonvisualobject
end type
end forward

global type tc from nonvisualobject
end type
global tc tc

type variables
// Some trip related constants
constant long STATE_BOBTAIL = -1
constant long STATE_DEADHEAD = 0
constant long STATE_LOADED = 1

//These are NOT used in the trip datastore, but only
//as a parameter to of_calculate.
Constant Long STATE_EMPTY = 2
Constant Long STATE_ANY = 3

end variables

on tc.create
TriggerEvent( this, "constructor" )
end on

on tc.destroy
TriggerEvent( this, "destructor" )
end on

