$PBExportHeader$n_cst_privdetails_brokerage.sru
forward
global type n_cst_privdetails_brokerage from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_brokerage from n_cst_privdetails
end type
global n_cst_privdetails_brokerage n_cst_privdetails_brokerage

event constructor;call super::constructor;is_Module = "Brokerage"
end event

on n_cst_privdetails_brokerage.create
call super::create
end on

on n_cst_privdetails_brokerage.destroy
call super::destroy
end on

