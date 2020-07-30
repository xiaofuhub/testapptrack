$PBExportHeader$u_tabpg_prprties_orderentry.sru
forward
global type u_tabpg_prprties_orderentry from u_tabpg_prprties
end type
end forward

global type u_tabpg_prprties_orderentry from u_tabpg_prprties
integer height = 1100
end type
global u_tabpg_prprties_orderentry u_tabpg_prprties_orderentry

on u_tabpg_prprties_orderentry.create
call super::create
end on

on u_tabpg_prprties_orderentry.destroy
call super::destroy
end on

