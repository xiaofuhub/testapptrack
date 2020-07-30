$PBExportHeader$n_cst_uilink_tvs.sru
forward
global type n_cst_uilink_tvs from ofr_n_cst_uilink_tvs
end type
end forward

global type n_cst_uilink_tvs from ofr_n_cst_uilink_tvs
end type
global n_cst_uilink_tvs n_cst_uilink_tvs

on n_cst_uilink_tvs.create
TriggerEvent( this, "constructor" )
end on

on n_cst_uilink_tvs.destroy
TriggerEvent( this, "destructor" )
end on

