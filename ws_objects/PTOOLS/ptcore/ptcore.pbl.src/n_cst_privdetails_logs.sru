$PBExportHeader$n_cst_privdetails_logs.sru
forward
global type n_cst_privdetails_logs from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_logs from n_cst_privdetails
end type
global n_cst_privdetails_logs n_cst_privdetails_logs

event constructor;call super::constructor;is_module = "Logs"
end event

on n_cst_privdetails_logs.create
call super::create
end on

on n_cst_privdetails_logs.destroy
call super::destroy
end on

