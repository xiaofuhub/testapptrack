$PBExportHeader$u_tabpg_prprties_settlements_payables.sru
forward
global type u_tabpg_prprties_settlements_payables from u_tabpg_prprties_settlements
end type
type uo_vendorvalidfilelocfolder from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payables
end type
type uo_6 from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payables
end type
type uo_5 from u_cst_syssettings_files within u_tabpg_prprties_settlements_payables
end type
type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payables
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payables
end type
end forward

global type u_tabpg_prprties_settlements_payables from u_tabpg_prprties_settlements
integer width = 2094
integer height = 1596
string text = "Payables"
uo_vendorvalidfilelocfolder uo_vendorvalidfilelocfolder
uo_6 uo_6
uo_5 uo_5
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_settlements_payables u_tabpg_prprties_settlements_payables

on u_tabpg_prprties_settlements_payables.create
int iCurrent
call super::create
this.uo_vendorvalidfilelocfolder=create uo_vendorvalidfilelocfolder
this.uo_6=create uo_6
this.uo_5=create uo_5
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_vendorvalidfilelocfolder
this.Control[iCurrent+2]=this.uo_6
this.Control[iCurrent+3]=this.uo_5
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.uo_1
end on

on u_tabpg_prprties_settlements_payables.destroy
call super::destroy
destroy(this.uo_vendorvalidfilelocfolder)
destroy(this.uo_6)
destroy(this.uo_5)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_vendorvalidfilelocfolder from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payables
integer x = 55
integer y = 352
integer taborder = 30
end type

on uo_vendorvalidfilelocfolder.destroy
call u_cst_syssettings_folders::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_VendorValidFileLocFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_6 from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payables
integer x = 55
integer y = 820
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PayableBatchErrLogFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_6.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_5 from u_cst_syssettings_files within u_tabpg_prprties_settlements_payables
integer x = 55
integer y = 584
integer taborder = 40
end type

on uo_5.destroy
call u_cst_syssettings_files::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_GLPayablesValidationFile

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payables
integer x = 55
integer y = 120
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PayablesBatchFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY inv_syssetting
end event

on uo_2.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payables
integer x = 69
integer y = 28
integer width = 1792
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PayablesBatches

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY inv_syssetting
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

