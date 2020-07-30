$PBExportHeader$u_tabpg_edi_210.sru
forward
global type u_tabpg_edi_210 from u_tabpg_edi_gen
end type
type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_210
end type
end forward

global type u_tabpg_edi_210 from u_tabpg_edi_gen
integer width = 2542
integer height = 680
string text = "210"
dw_mappings dw_mappings
end type
global u_tabpg_edi_210 u_tabpg_edi_210

on u_tabpg_edi_210.create
int iCurrent
call super::create
this.dw_mappings=create dw_mappings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mappings
end on

on u_tabpg_edi_210.destroy
call super::destroy
destroy(this.dw_mappings)
end on

event constructor;call super::constructor;long	ll_coid, &
		ll_row

ll_coid = this.of_GetCompany()

if ll_coid > 0 then
	dw_profile.settransobject(sqlca)
	dw_mappings.settransobject(sqlca)
	if dw_profile.retrieve(ll_coid, appeon_constant.cl_transaction_set_210, "OUTBOUND") < 1 then
		ll_row = dw_profile.insertrow(0)
		if ll_row > 0 then
			dw_profile.object.companyid[ll_row] = ll_coid
			dw_profile.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_210
			dw_profile.object.in_out[ll_row] = "OUTBOUND"
		end if
	end if
	
	if dw_mappings.retrieve(ll_coid, appeon_constant.cl_transaction_set_210, "OUTBOUND") < 1 then
		ll_row = dw_mappings.insertrow(0)
		if ll_row > 0 then
			dw_mappings.object.company[ll_row] = ll_coid
			dw_mappings.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_210
		end if
	end if
	
end if



this.of_setupdateobjects( {dw_Profile, dw_Mappings } )

end event

type dw_profile from u_tabpg_edi_gen`dw_profile within u_tabpg_edi_210
boolean visible = true
integer x = 14
integer y = 136
integer width = 2437
boolean ib_isupdateable = true
end type

type st_title from u_tabpg_edi_gen`st_title within u_tabpg_edi_210
boolean visible = true
integer x = 146
integer y = 36
string text = "Freight Details and Invoice"
end type

type tab_1 from u_tabpg_edi_gen`tab_1 within u_tabpg_edi_210
end type

type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_210
integer x = 50
integer y = 548
integer width = 1723
integer height = 104
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = false
end type

