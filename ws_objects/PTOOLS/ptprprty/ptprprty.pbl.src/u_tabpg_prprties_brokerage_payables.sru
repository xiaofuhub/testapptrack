$PBExportHeader$u_tabpg_prprties_brokerage_payables.sru
forward
global type u_tabpg_prprties_brokerage_payables from u_tabpg_prprties_settlements
end type
type uo_carrierpayablebatch from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_brokerage_payables
end type
type uo_vendorvalidfilelocfolder from u_cst_syssettings_folders within u_tabpg_prprties_brokerage_payables
end type
type uo_payablebatcherrlogfolder from u_cst_syssettings_folders within u_tabpg_prprties_brokerage_payables
end type
type uo_payablesbatchfolder from u_cst_syssettings_folders within u_tabpg_prprties_brokerage_payables
end type
end forward

global type u_tabpg_prprties_brokerage_payables from u_tabpg_prprties_settlements
integer width = 2094
integer height = 1596
string text = "General"
uo_carrierpayablebatch uo_carrierpayablebatch
uo_vendorvalidfilelocfolder uo_vendorvalidfilelocfolder
uo_payablebatcherrlogfolder uo_payablebatcherrlogfolder
uo_payablesbatchfolder uo_payablesbatchfolder
end type
global u_tabpg_prprties_brokerage_payables u_tabpg_prprties_brokerage_payables

on u_tabpg_prprties_brokerage_payables.create
int iCurrent
call super::create
this.uo_carrierpayablebatch=create uo_carrierpayablebatch
this.uo_vendorvalidfilelocfolder=create uo_vendorvalidfilelocfolder
this.uo_payablebatcherrlogfolder=create uo_payablebatcherrlogfolder
this.uo_payablesbatchfolder=create uo_payablesbatchfolder
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_carrierpayablebatch
this.Control[iCurrent+2]=this.uo_vendorvalidfilelocfolder
this.Control[iCurrent+3]=this.uo_payablebatcherrlogfolder
this.Control[iCurrent+4]=this.uo_payablesbatchfolder
end on

on u_tabpg_prprties_brokerage_payables.destroy
call super::destroy
destroy(this.uo_carrierpayablebatch)
destroy(this.uo_vendorvalidfilelocfolder)
destroy(this.uo_payablebatcherrlogfolder)
destroy(this.uo_payablesbatchfolder)
end on

type uo_carrierpayablebatch from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_brokerage_payables
integer y = 60
integer width = 1989
integer taborder = 80
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_BillingCarrierPayableBatch

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_carrierpayablebatch.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_vendorvalidfilelocfolder from u_cst_syssettings_folders within u_tabpg_prprties_brokerage_payables
integer x = 55
integer y = 432
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

type uo_payablebatcherrlogfolder from u_cst_syssettings_folders within u_tabpg_prprties_brokerage_payables
integer x = 55
integer y = 684
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PayableBatchErrLogFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_payablebatcherrlogfolder.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_payablesbatchfolder from u_cst_syssettings_folders within u_tabpg_prprties_brokerage_payables
integer x = 55
integer y = 200
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PayablesBatchFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY inv_syssetting
end event

on uo_payablesbatchfolder.destroy
call u_cst_syssettings_folders::destroy
end on

