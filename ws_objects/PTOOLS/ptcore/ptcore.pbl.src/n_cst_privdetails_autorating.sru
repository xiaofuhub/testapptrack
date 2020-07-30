$PBExportHeader$n_cst_privdetails_autorating.sru
forward
global type n_cst_privdetails_autorating from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_autorating from n_cst_privdetails
end type
global n_cst_privdetails_autorating n_cst_privdetails_autorating

on n_cst_privdetails_autorating.create
call super::create
end on

on n_cst_privdetails_autorating.destroy
call super::destroy
end on

event constructor;call super::constructor;is_module = "AutoRating"

//non-division based properties set up..

//ila_nondivisionbasedprivs[1] = 12//"modify"
end event

