$PBExportHeader$n_cst_privdetails_settlements.sru
forward
global type n_cst_privdetails_settlements from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_settlements from n_cst_privdetails
end type
global n_cst_privdetails_settlements n_cst_privdetails_settlements

event constructor;call super::constructor;is_module = "Settlements"
end event

on n_cst_privdetails_settlements.create
call super::create
end on

on n_cst_privdetails_settlements.destroy
call super::destroy
end on

