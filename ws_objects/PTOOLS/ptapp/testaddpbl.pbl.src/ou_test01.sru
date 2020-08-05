$PBExportHeader$ou_test01.sru
forward
global type ou_test01 from adoresultset
end type
end forward

global type ou_test01 from adoresultset
end type
global ou_test01 ou_test01

type variables
//
end variables
on ou_test01.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ou_test01.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

