$PBExportHeader$u_tabpg_prprties_settlements_payroll.sru
forward
global type u_tabpg_prprties_settlements_payroll from u_tabpg_prprties_settlements
end type
type uo_employeevalidlocfilefolder from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payroll
end type
type uo_5 from u_cst_syssettings_sle within u_tabpg_prprties_settlements_payroll
end type
type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payroll
end type
type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payroll
end type
type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payroll
end type
end forward

global type u_tabpg_prprties_settlements_payroll from u_tabpg_prprties_settlements
integer width = 2277
integer height = 1840
string text = "Payroll"
uo_employeevalidlocfilefolder uo_employeevalidlocfilefolder
uo_5 uo_5
uo_4 uo_4
uo_3 uo_3
uo_1 uo_1
end type
global u_tabpg_prprties_settlements_payroll u_tabpg_prprties_settlements_payroll

on u_tabpg_prprties_settlements_payroll.create
int iCurrent
call super::create
this.uo_employeevalidlocfilefolder=create uo_employeevalidlocfilefolder
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_3=create uo_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_employeevalidlocfilefolder
this.Control[iCurrent+2]=this.uo_5
this.Control[iCurrent+3]=this.uo_4
this.Control[iCurrent+4]=this.uo_3
this.Control[iCurrent+5]=this.uo_1
end on

on u_tabpg_prprties_settlements_payroll.destroy
call super::destroy
destroy(this.uo_employeevalidlocfilefolder)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_3)
destroy(this.uo_1)
end on

type uo_employeevalidlocfilefolder from u_cst_syssettings_folders within u_tabpg_prprties_settlements_payroll
integer x = 78
integer y = 592
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_EmployeeValidLocFileFolder

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_employeevalidlocfilefolder.destroy
call u_cst_syssettings_folders::destroy
end on

type uo_5 from u_cst_syssettings_sle within u_tabpg_prprties_settlements_payroll
integer x = 78
integer y = 360
integer width = 1806
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_MarkupAmtFuelCardFees

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_sle::destroy
end on

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

type uo_4 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payroll
integer x = 96
integer y = 244
integer width = 1792
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DriverMarkUpFees

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payroll
integer x = 96
integer y = 144
integer width = 1792
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_GenerateFuelDeductForEmpl

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_1 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_settlements_payroll
integer x = 96
integer y = 44
integer width = 1792
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_PayrollBatches

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

