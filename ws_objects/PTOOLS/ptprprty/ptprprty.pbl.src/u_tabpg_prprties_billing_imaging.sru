$PBExportHeader$u_tabpg_prprties_billing_imaging.sru
forward
global type u_tabpg_prprties_billing_imaging from u_tabpg_prprties_billing
end type
type uo_1 from u_cst_syssettings_imagesettings within u_tabpg_prprties_billing_imaging
end type
end forward

global type u_tabpg_prprties_billing_imaging from u_tabpg_prprties_billing
integer width = 2277
integer height = 1196
string text = "Imaging"
uo_1 uo_1
end type
global u_tabpg_prprties_billing_imaging u_tabpg_prprties_billing_imaging

on u_tabpg_prprties_billing_imaging.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_tabpg_prprties_billing_imaging.destroy
call super::destroy
destroy(this.uo_1)
end on

type uo_1 from u_cst_syssettings_imagesettings within u_tabpg_prprties_billing_imaging
integer x = 14
integer y = 12
integer width = 2245
integer taborder = 10
end type

on uo_1.destroy
call u_cst_syssettings_imagesettings::destroy
end on

event constructor;call super::constructor;inv_syssetting_required  = CREATE n_cst_syssettings_imagesettings_required

inv_syssetting = inv_syssetting_required

event ue_setvalue(inv_syssetting) 

inv_syssetting_required = inv_syssetting

Post event ue_SetCheckBoxes(isa_imagetypes[],"REQUIRED")


inv_syssetting_Printing = CREATE n_cst_syssettings_imagesettings_Printing


inv_syssetting = inv_syssetting_Printing

event ue_setvalue(inv_syssetting)

inv_syssetting_Printing = inv_syssetting

Post event ue_SetCheckBoxes(isa_imagetypes[],"PRINTING")


inv_syssetting_Warning = CREATE n_cst_syssettings_imagesettings_Warning

inv_syssetting = inv_syssetting_Warning


event ue_setvalue(inv_syssetting)

inv_syssetting_Warning = inv_syssetting

Post event ue_SetCheckBoxes(isa_imagetypes[],"WARNING")

end event

event destructor;call super::destructor;Destroy inv_syssetting
Destroy inv_syssetting_printing
Destroy inv_syssetting_required
Destroy inv_syssetting_warning
end event

