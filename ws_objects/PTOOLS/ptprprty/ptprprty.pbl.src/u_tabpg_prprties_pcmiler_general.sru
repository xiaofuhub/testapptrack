$PBExportHeader$u_tabpg_prprties_pcmiler_general.sru
forward
global type u_tabpg_prprties_pcmiler_general from u_tabpg_prprties_pcmiler
end type
type uo_trippininfo from u_cst_syssettings_files within u_tabpg_prprties_pcmiler_general
end type
type uo_unnassignedpininfo from u_cst_syssettings_files within u_tabpg_prprties_pcmiler_general
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_pcmiler_general
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_pcmiler_general
end type
end forward

global type u_tabpg_prprties_pcmiler_general from u_tabpg_prprties_pcmiler
integer width = 1970
integer height = 1252
string text = "General"
uo_trippininfo uo_trippininfo
uo_unnassignedpininfo uo_unnassignedpininfo
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_pcmiler_general u_tabpg_prprties_pcmiler_general

on u_tabpg_prprties_pcmiler_general.create
int iCurrent
call super::create
this.uo_trippininfo=create uo_trippininfo
this.uo_unnassignedpininfo=create uo_unnassignedpininfo
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_trippininfo
this.Control[iCurrent+2]=this.uo_unnassignedpininfo
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.uo_1
end on

on u_tabpg_prprties_pcmiler_general.destroy
call super::destroy
destroy(this.uo_trippininfo)
destroy(this.uo_unnassignedpininfo)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_trippininfo from u_cst_syssettings_files within u_tabpg_prprties_pcmiler_general
integer x = 82
integer y = 512
integer taborder = 40
end type

on uo_trippininfo.destroy
call u_cst_syssettings_files::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_tripPinInfo
event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

type uo_unnassignedpininfo from u_cst_syssettings_files within u_tabpg_prprties_pcmiler_general
integer x = 78
integer y = 248
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_unnAssignedPinInfo

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_unnassignedpininfo.destroy
call u_cst_syssettings_files::destroy
end on

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_pcmiler_general
integer x = 91
integer y = 116
integer width = 1797
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PCMilerMappingInstall

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_pcmiler_general
integer x = 91
integer y = 16
integer width = 1797
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PCMilerServerInstall

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

