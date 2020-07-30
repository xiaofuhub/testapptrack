$PBExportHeader$u_tabpg_edi_gen_214.sru
forward
global type u_tabpg_edi_gen_214 from u_tabpg_edi_gen
end type
end forward

global type u_tabpg_edi_gen_214 from u_tabpg_edi_gen
string text = "214"
end type
global u_tabpg_edi_gen_214 u_tabpg_edi_gen_214

forward prototypes
public function integer of_buildtabpages (n_cst_msg anv_msg)
end prototypes

public function integer of_buildtabpages (n_cst_msg anv_msg);Int	li_return
Int li_UpperBound
String lsa_TabPage[]
lsa_TabPage = isa_TabPage
li_upperBound = upperbound( isa_tabPage )
li_return = SUPER::of_buildTabPages( anv_msg )

IF li_UpperBound > 1 THEN
	tab_1.post SelectTab(lsa_TabPage[2])
END IF
RETURN li_Return
end function

on u_tabpg_edi_gen_214.create
call super::create
end on

on u_tabpg_edi_gen_214.destroy
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
isa_tabpage[li_cnt] = 'u_tabpg_edi_214_in'

li_cnt ++
isa_tabpage[li_cnt] = 'u_tabpg_edi_214'






end event

type dw_profile from u_tabpg_edi_gen`dw_profile within u_tabpg_edi_gen_214
end type

type st_title from u_tabpg_edi_gen`st_title within u_tabpg_edi_gen_214
end type

type tab_1 from u_tabpg_edi_gen`tab_1 within u_tabpg_edi_gen_214
end type

