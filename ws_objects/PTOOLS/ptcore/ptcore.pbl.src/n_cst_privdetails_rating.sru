$PBExportHeader$n_cst_privdetails_rating.sru
forward
global type n_cst_privdetails_rating from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_rating from n_cst_privdetails
end type
global n_cst_privdetails_rating n_cst_privdetails_rating

on n_cst_privdetails_rating.create
call super::create
end on

on n_cst_privdetails_rating.destroy
call super::destroy
end on

event constructor;call super::constructor;is_module = "Rating"

//non-division based properties set up..

//ila_nondivisionbasedprivs[1] = 12//"modify"
end event

