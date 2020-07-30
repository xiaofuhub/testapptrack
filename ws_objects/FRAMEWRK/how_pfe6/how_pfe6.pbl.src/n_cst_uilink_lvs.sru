$PBExportHeader$n_cst_uilink_lvs.sru
forward
global type n_cst_uilink_lvs from ofr_n_cst_uilink_lvs
end type
end forward

global type n_cst_uilink_lvs from ofr_n_cst_uilink_lvs
end type
global n_cst_uilink_lvs n_cst_uilink_lvs

on n_cst_uilink_lvs.create
TriggerEvent( this, "constructor" )
end on

on n_cst_uilink_lvs.destroy
TriggerEvent( this, "destructor" )
end on

