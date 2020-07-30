$PBExportHeader$u_tabpg_edi_204_out.sru
forward
global type u_tabpg_edi_204_out from u_tabpg_edi
end type
type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_204_out
end type
end forward

global type u_tabpg_edi_204_out from u_tabpg_edi
integer height = 720
string text = "Outbound"
dw_mappings dw_mappings
end type
global u_tabpg_edi_204_out u_tabpg_edi_204_out

on u_tabpg_edi_204_out.create
int iCurrent
call super::create
this.dw_mappings=create dw_mappings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mappings
end on

on u_tabpg_edi_204_out.destroy
call super::destroy
destroy(this.dw_mappings)
end on

event constructor;call super::constructor;long	ll_coid, &
		ll_row

ll_coid = this.of_GetCompany()

if ll_coid > 0 then
	dw_profile.settransobject(sqlca)
	dw_mappings.settransobject(sqlca)
	if dw_profile.retrieve(ll_coid, appeon_constant.cl_transaction_set_204, "OUTBOUND") < 1 then
		ll_row = dw_profile.insertrow(0)
		if ll_row > 0 then
			dw_profile.object.companyid[ll_row] = ll_coid
			dw_profile.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_204
			dw_profile.object.in_out[ll_row] = "OUTBOUND"
		end if
	end if
	
	if dw_mappings.retrieve(ll_coid, appeon_constant.cl_transaction_set_204, "OUTBOUND") < 1 then
		ll_row = dw_mappings.insertrow(0)
		if ll_row > 0 then
			dw_mappings.object.company[ll_row] = ll_coid
			dw_mappings.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_204
		end if
	end if
	
end if
this.of_setupdateobjects( {dw_Profile, dw_Mappings } )
end event

type dw_profile from u_tabpg_edi`dw_profile within u_tabpg_edi_204_out
string dataobject = "d_ediprofile204out"
end type

type st_title from u_tabpg_edi`st_title within u_tabpg_edi_204_out
string text = "204 - Load Tender"
end type

type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_204_out
integer x = 46
integer y = 552
integer width = 1723
integer height = 104
integer taborder = 30
boolean bringtotop = true
boolean vscrollbar = false
end type

