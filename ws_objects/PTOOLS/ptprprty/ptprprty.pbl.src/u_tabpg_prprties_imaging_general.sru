$PBExportHeader$u_tabpg_prprties_imaging_general.sru
forward
global type u_tabpg_prprties_imaging_general from u_tabpg_prprties_imaging
end type
type uo_includetypeintitle from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_general
end type
type uo_includeparent from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_general
end type
type uo_quadrant from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_imaging_general
end type
end forward

global type u_tabpg_prprties_imaging_general from u_tabpg_prprties_imaging
integer width = 1966
integer height = 1224
string text = "General"
uo_includetypeintitle uo_includetypeintitle
uo_includeparent uo_includeparent
uo_quadrant uo_quadrant
end type
global u_tabpg_prprties_imaging_general u_tabpg_prprties_imaging_general

on u_tabpg_prprties_imaging_general.create
int iCurrent
call super::create
this.uo_includetypeintitle=create uo_includetypeintitle
this.uo_includeparent=create uo_includeparent
this.uo_quadrant=create uo_quadrant
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_includetypeintitle
this.Control[iCurrent+2]=this.uo_includeparent
this.Control[iCurrent+3]=this.uo_quadrant
end on

on u_tabpg_prprties_imaging_general.destroy
call super::destroy
destroy(this.uo_includetypeintitle)
destroy(this.uo_includeparent)
destroy(this.uo_quadrant)
end on

type uo_includetypeintitle from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_general
integer y = 148
integer width = 1888
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_includeimagetypeinprint

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

on uo_includetypeintitle.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_includeparent from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_imaging_general
integer y = 32
integer width = 1888
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_includeparentinimagelookup

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY ( inv_syssetting )
end event

on uo_includeparent.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_quadrant from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_imaging_general
integer y = 280
integer width = 1897
integer taborder = 30
end type

on uo_quadrant.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ImageTitleQuadrant

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

