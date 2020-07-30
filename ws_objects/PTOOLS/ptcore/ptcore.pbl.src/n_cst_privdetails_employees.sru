$PBExportHeader$n_cst_privdetails_employees.sru
forward
global type n_cst_privdetails_employees from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_employees from n_cst_privdetails
end type
global n_cst_privdetails_employees n_cst_privdetails_employees

on n_cst_privdetails_employees.create
call super::create
end on

on n_cst_privdetails_employees.destroy
call super::destroy
end on

event constructor;call super::constructor;is_module = "Employees"


end event

