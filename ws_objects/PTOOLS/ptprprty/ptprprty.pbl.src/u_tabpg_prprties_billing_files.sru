$PBExportHeader$u_tabpg_prprties_billing_files.sru
forward
global type u_tabpg_prprties_billing_files from u_tabpg_prprties_billing
end type
type uo_customervalidationfolder from u_cst_syssettings_files within u_tabpg_prprties_billing_files
end type
type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_billing_files
end type
type uo_4 from u_cst_syssettings_files within u_tabpg_prprties_billing_files
end type
type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_billing_files
end type
end forward

global type u_tabpg_prprties_billing_files from u_tabpg_prprties_billing
integer height = 1244
string text = "Files"
uo_customervalidationfolder uo_customervalidationfolder
uo_1 uo_1
uo_4 uo_4
uo_2 uo_2
end type
global u_tabpg_prprties_billing_files u_tabpg_prprties_billing_files

on u_tabpg_prprties_billing_files.create
int iCurrent
call super::create
this.uo_customervalidationfolder=create uo_customervalidationfolder
this.uo_1=create uo_1
this.uo_4=create uo_4
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_customervalidationfolder
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_4
this.Control[iCurrent+4]=this.uo_2
end on

on u_tabpg_prprties_billing_files.destroy
call super::destroy
destroy(this.uo_customervalidationfolder)
destroy(this.uo_1)
destroy(this.uo_4)
destroy(this.uo_2)
end on

type uo_customervalidationfolder from u_cst_syssettings_files within u_tabpg_prprties_billing_files
integer x = 5
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_CustomerValidationFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_customervalidationfolder.destroy
call u_cst_syssettings_files::destroy
end on

type uo_1 from u_cst_syssettings_folders within u_tabpg_prprties_billing_files
integer x = 5
integer y = 756
integer width = 1600
integer taborder = 40
end type

on uo_1.destroy
call u_cst_syssettings_folders::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_QuickBooksFilesPathFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_4 from u_cst_syssettings_files within u_tabpg_prprties_billing_files
integer x = 5
integer y = 480
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_GLReceivableValidationFile

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_files::destroy
end on

type uo_2 from u_cst_syssettings_folders within u_tabpg_prprties_billing_files
integer x = 5
integer y = 244
integer width = 1600
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_ReceivablesBatchFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_folders::destroy
end on

