$PBExportHeader$u_tabpg_edi_997.sru
forward
global type u_tabpg_edi_997 from u_tabpg_edi
end type
end forward

global type u_tabpg_edi_997 from u_tabpg_edi
string text = "Outbound"
end type
global u_tabpg_edi_997 u_tabpg_edi_997

on u_tabpg_edi_997.create
call super::create
end on

on u_tabpg_edi_997.destroy
call super::destroy
end on

event constructor;call super::constructor;long	ll_coid, &
		ll_row

ll_coid = this.of_GetCompany()

if ll_coid > 0 then
	dw_profile.settransobject(sqlca)
	if dw_profile.retrieve(ll_coid, 997, "OUTBOUND") < 1 then
		ll_row = dw_profile.insertrow(0)
		if ll_row > 0 then
			dw_profile.object.companyid[ll_row] = ll_coid
			dw_profile.object.transactionset[ll_row] = 997
			dw_profile.object.in_out[ll_row] = "OUTBOUND"
		end if
	end if
end if

end event

type dw_profile from u_tabpg_edi`dw_profile within u_tabpg_edi_997
integer width = 2441
end type

type st_title from u_tabpg_edi`st_title within u_tabpg_edi_997
string text = "Functional Acknowledgment"
end type

