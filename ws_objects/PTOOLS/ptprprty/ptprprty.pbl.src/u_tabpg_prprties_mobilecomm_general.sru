$PBExportHeader$u_tabpg_prprties_mobilecomm_general.sru
forward
global type u_tabpg_prprties_mobilecomm_general from u_tabpg_prprties_mobilecomm
end type
type uo_replysuccess from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_mobilecomm_general
end type
type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_mobilecomm_general
end type
type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_mobilecomm_general
end type
type uo_inboundcadecfile from u_cst_syssettings_files within u_tabpg_prprties_mobilecomm_general
end type
type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_mobilecomm_general
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_mobilecomm_general
end type
end forward

global type u_tabpg_prprties_mobilecomm_general from u_tabpg_prprties_mobilecomm
integer width = 1774
integer height = 1424
string text = "General"
uo_replysuccess uo_replysuccess
uo_4 uo_4
uo_2 uo_2
uo_inboundcadecfile uo_inboundcadecfile
uo_3 uo_3
uo_1 uo_1
end type
global u_tabpg_prprties_mobilecomm_general u_tabpg_prprties_mobilecomm_general

type variables

end variables

on u_tabpg_prprties_mobilecomm_general.create
int iCurrent
call super::create
this.uo_replysuccess=create uo_replysuccess
this.uo_4=create uo_4
this.uo_2=create uo_2
this.uo_inboundcadecfile=create uo_inboundcadecfile
this.uo_3=create uo_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_replysuccess
this.Control[iCurrent+2]=this.uo_4
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.uo_inboundcadecfile
this.Control[iCurrent+5]=this.uo_3
this.Control[iCurrent+6]=this.uo_1
end on

on u_tabpg_prprties_mobilecomm_general.destroy
call super::destroy
destroy(this.uo_replysuccess)
destroy(this.uo_4)
destroy(this.uo_2)
destroy(this.uo_inboundcadecfile)
destroy(this.uo_3)
destroy(this.uo_1)
end on

type uo_replysuccess from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_mobilecomm_general
integer x = 73
integer y = 336
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_MobileCommReplySuccess

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_replysuccess.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_mobilecomm_general
integer x = 73
integer y = 192
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_MobileCommReplyError

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_mobilecomm_general
integer x = 69
integer y = 700
integer width = 1623
integer taborder = 50
end type

on uo_2.destroy
call u_cst_syssettings_sle::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_nextelmappingaddress

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

type uo_inboundcadecfile from u_cst_syssettings_files within u_tabpg_prprties_mobilecomm_general
integer x = 69
integer y = 952
integer width = 1623
integer taborder = 60
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_InboundCadecFile

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_inboundcadecfile.destroy
call u_cst_syssettings_files::destroy
end on

type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_mobilecomm_general
integer x = 73
integer y = 48
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_MobileCommRouteShipments

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_mobilecomm_general
integer x = 73
integer y = 456
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_QualCommPathFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

