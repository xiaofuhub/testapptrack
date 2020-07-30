$PBExportHeader$n_tr.sru
forward
global type n_tr from ofr_n_tr
end type
end forward

global type n_tr from ofr_n_tr
end type
global n_tr n_tr

on n_tr.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on n_tr.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

