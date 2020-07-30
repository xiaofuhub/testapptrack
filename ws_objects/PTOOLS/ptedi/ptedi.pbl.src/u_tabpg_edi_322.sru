$PBExportHeader$u_tabpg_edi_322.sru
forward
global type u_tabpg_edi_322 from u_tabpg_edi_gen
end type
type dw_1 from u_dw_ediprofile within u_tabpg_edi_322
end type
type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_322
end type
end forward

global type u_tabpg_edi_322 from u_tabpg_edi_gen
integer width = 2555
integer height = 700
string text = "322"
dw_1 dw_1
dw_mappings dw_mappings
end type
global u_tabpg_edi_322 u_tabpg_edi_322

on u_tabpg_edi_322.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_mappings=create dw_mappings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_mappings
end on

on u_tabpg_edi_322.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_mappings)
end on

event constructor;call super::constructor;long	ll_coid, &
		ll_row

ll_coid = this.of_GetCompany()

if ll_coid > 0 then
	dw_profile.settransobject(sqlca)
	dw_mappings.settransobject(sqlca)
	if dw_profile.retrieve(ll_coid, appeon_constant.cl_transaction_set_322, "OUTBOUND") < 1 then
		ll_row = dw_profile.insertrow(0)
		if ll_row > 0 then
			dw_profile.object.companyid[ll_row] = ll_coid
			dw_profile.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_322
			dw_profile.object.in_out[ll_row] = "OUTBOUND"
		end if
	end if


	if dw_mappings.retrieve(ll_coid, appeon_constant.cl_transaction_set_322, "OUTBOUND") < 1 then
		ll_row = dw_mappings.insertrow(0)
		if ll_row > 0 then
			dw_mappings.object.company[ll_row] = ll_coid
			dw_mappings.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_322
		end if
		
	end if	

END IF
this.of_setupdateobjects( {dw_Profile, dw_Mappings } )


////////////////////////////////////////
//	long	ll_coid, &
//		ll_row
//
//ll_coid = this.of_GetCompany()
//
//if ll_coid > 0 then
//	dw_profile.settransobject(sqlca)
//	dw_mappings.settransobject(sqlca)
//	if dw_profile.retrieve(ll_coid, appeon_constant.cl_transaction_set_210) < 1 then
//		ll_row = dw_profile.insertrow(0)
//		if ll_row > 0 then
//			dw_profile.object.companyid[ll_row] = ll_coid
//			dw_profile.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_210
//		end if
//	end if
//	
//	if dw_mappings.retrieve(ll_coid, appeon_constant.cl_transaction_set_210) < 1 then
//		ll_row = dw_mappings.insertrow(0)
//		if ll_row > 0 then
//			dw_mappings.object.company[ll_row] = ll_coid
//			dw_mappings.object.transactionset[ll_row] = appeon_constant.cl_transaction_set_210
//		end if
//	end if
//	
//end if
//
//
//
//this.of_setupdateobjects( {dw_Profile, dw_Mappings } )
//
end event

type dw_profile from u_tabpg_edi_gen`dw_profile within u_tabpg_edi_322
boolean visible = true
integer x = 14
integer y = 136
boolean ib_isupdateable = true
end type

type st_title from u_tabpg_edi_gen`st_title within u_tabpg_edi_322
boolean visible = true
integer x = 146
integer y = 36
string text = "Terminal Operations and Intermodal Ramp Activity"
end type

type tab_1 from u_tabpg_edi_gen`tab_1 within u_tabpg_edi_322
end type

type dw_1 from u_dw_ediprofile within u_tabpg_edi_322
integer x = 27
integer y = 780
integer taborder = 0
boolean bringtotop = true
end type

type dw_mappings from u_dw_mappingfiles within u_tabpg_edi_322
integer x = 55
integer y = 548
integer width = 1723
integer height = 104
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = false
end type

