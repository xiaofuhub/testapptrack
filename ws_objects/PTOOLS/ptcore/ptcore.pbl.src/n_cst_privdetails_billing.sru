$PBExportHeader$n_cst_privdetails_billing.sru
forward
global type n_cst_privdetails_billing from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_billing from n_cst_privdetails
end type
global n_cst_privdetails_billing n_cst_privdetails_billing

event constructor;call super::constructor;is_Module = "Billing"
end event

on n_cst_privdetails_billing.create
call super::create
end on

on n_cst_privdetails_billing.destroy
call super::destroy
end on

