$PBExportHeader$u_tabpg_prprties_orderentry_dockids.sru
forward
global type u_tabpg_prprties_orderentry_dockids from u_tabpg_prprties_orderentry
end type
type uo_4 from u_cst_syssettings_company_populate within u_tabpg_prprties_orderentry_dockids
end type
end forward

global type u_tabpg_prprties_orderentry_dockids from u_tabpg_prprties_orderentry
integer width = 1906
integer height = 1904
string text = "Dock IDs"
uo_4 uo_4
end type
global u_tabpg_prprties_orderentry_dockids u_tabpg_prprties_orderentry_dockids

on u_tabpg_prprties_orderentry_dockids.create
int iCurrent
call super::create
this.uo_4=create uo_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_4
end on

on u_tabpg_prprties_orderentry_dockids.destroy
call super::destroy
destroy(this.uo_4)
end on

type uo_4 from u_cst_syssettings_company_populate within u_tabpg_prprties_orderentry_dockids
integer y = 24
integer width = 1682
integer height = 1372
integer taborder = 70
end type

on uo_4.destroy
call u_cst_syssettings_company_populate::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DockId

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY(inv_syssetting)
end event

