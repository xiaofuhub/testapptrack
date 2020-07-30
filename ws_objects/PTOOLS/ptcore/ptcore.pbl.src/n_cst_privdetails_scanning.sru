$PBExportHeader$n_cst_privdetails_scanning.sru
forward
global type n_cst_privdetails_scanning from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_scanning from n_cst_privdetails
end type
global n_cst_privdetails_scanning n_cst_privdetails_scanning

event constructor;call super::constructor;is_module = "Scanning"
end event

on n_cst_privdetails_scanning.create
call super::create
end on

on n_cst_privdetails_scanning.destroy
call super::destroy
end on

