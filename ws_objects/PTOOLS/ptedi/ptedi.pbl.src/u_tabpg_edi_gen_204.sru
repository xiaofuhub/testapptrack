$PBExportHeader$u_tabpg_edi_gen_204.sru
forward
global type u_tabpg_edi_gen_204 from u_tabpg_edi_gen
end type
end forward

global type u_tabpg_edi_gen_204 from u_tabpg_edi_gen
string text = "204"
end type
global u_tabpg_edi_gen_204 u_tabpg_edi_gen_204

on u_tabpg_edi_gen_204.create
call super::create
end on

on u_tabpg_edi_gen_204.destroy
call super::destroy
end on

event constructor;call super::constructor;integer	li_cnt

n_cst_LicenseManager	lnv_LicenseManager
n_cst_setting_edi204version	lnv_204Version
n_cst_setting_editransport		lnv_transportSetting


// I am going to show this all of the time since we need
// access to the SCAC. I don't have the time to go and figure out
// all of the places the other transaction sets use the 204 SCAC


li_cnt ++
isa_tabpage[li_cnt] = 'u_tabpg_edi_204'

li_cnt ++
isa_tabpage[li_cnt] = 'u_tabpg_edi_204_out'






end event

type dw_profile from u_tabpg_edi_gen`dw_profile within u_tabpg_edi_gen_204
end type

type st_title from u_tabpg_edi_gen`st_title within u_tabpg_edi_gen_204
end type

type tab_1 from u_tabpg_edi_gen`tab_1 within u_tabpg_edi_gen_204
end type

