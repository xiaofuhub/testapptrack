$PBExportHeader$n_cst_privdetails_imaging.sru
forward
global type n_cst_privdetails_imaging from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_imaging from n_cst_privdetails
end type
global n_cst_privdetails_imaging n_cst_privdetails_imaging

event constructor;call super::constructor;is_Module = "Imaging"
ib_hasSpecialprivchecking = true
end event

on n_cst_privdetails_imaging.create
call super::create
end on

on n_cst_privdetails_imaging.destroy
call super::destroy
end on

