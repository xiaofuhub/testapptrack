$PBExportHeader$u_tabpg_prprties_billing_links.sru
forward
global type u_tabpg_prprties_billing_links from u_tabpg_prprties_billing
end type
type cb_Restore from commandbutton within u_tabpg_prprties_billing_links
end type
type cb_sapsetup from commandbutton within u_tabpg_prprties_billing_links
end type
type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_links
end type
type uo_4 from u_cst_syssettings_files within u_tabpg_prprties_billing_links
end type
type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_billing_links
end type
type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_links
end type
end forward

global type u_tabpg_prprties_billing_links from u_tabpg_prprties_billing
integer width = 2098
integer height = 1768
string text = "Accounting Package"
event ue_enablesapsetup ( boolean ab_enable )
cb_Restore cb_Restore
cb_sapsetup cb_sapsetup
uo_5 uo_5
uo_4 uo_4
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_billing_links u_tabpg_prprties_billing_links

event ue_enablesapsetup(boolean ab_enable);cb_SapSetup.Visible = ab_Enable
cb_restore.Visible = ab_enable
end event

on u_tabpg_prprties_billing_links.create
int iCurrent
call super::create
this.cb_Restore=create cb_Restore
this.cb_sapsetup=create cb_sapsetup
this.uo_5=create uo_5
this.uo_4=create uo_4
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_Restore
this.Control[iCurrent+2]=this.cb_sapsetup
this.Control[iCurrent+3]=this.uo_5
this.Control[iCurrent+4]=this.uo_4
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.uo_1
end on

on u_tabpg_prprties_billing_links.destroy
call super::destroy
destroy(this.cb_Restore)
destroy(this.cb_sapsetup)
destroy(this.uo_5)
destroy(this.uo_4)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type cb_Restore from commandbutton within u_tabpg_prprties_billing_links
boolean visible = false
integer x = 1189
integer y = 256
integer width = 741
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Restore system defaults..."
end type

event clicked;
IF MessageBox ("Restore SAP Defaults" , "Are you sure that you want to REMOVE ALL of the existing SAP mapping values and RESTORE ALL back to the system default?" , QUESTION! , YESNO! , 2 ) = 1 THEN
		
	
	n_cst_batchsrv_sap lnv_SAPSrv
	lnv_SAPSrv = CREATE n_cst_batchsrv_sap
	CHOOSE CASE lnv_SAPSrv.of_Restoresystemdefaults( ) 
		CASE 1
			MessageBox ( "Restore Defaults" , "System restored successfully." )
			
		CASE ELSE
			
			MessageBox ( "Restore Defaults" , "System restore failed. Please contact Technical Support." )
	END CHOOSE
	
	DESTROY ( lnv_SAPSrv )
	
END IF
	 
end event

type cb_sapsetup from commandbutton within u_tabpg_prprties_billing_links
boolean visible = false
integer x = 672
integer y = 156
integer width = 507
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SAP Setup"
end type

event clicked;Open(w_batchsapmapping)
end event

type uo_5 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_billing_links
integer x = 23
integer y = 28
integer width = 1957
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DynamicsOnMSSQL

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_5.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_4 from u_cst_syssettings_files within u_tabpg_prprties_billing_links
integer y = 632
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_BusinessWorksFile

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_4.destroy
call u_cst_syssettings_files::destroy
end on

type uo_2 from u_cst_syssettings_sle within u_tabpg_prprties_billing_links
integer y = 408
integer width = 1975
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_QuickBooksPO#

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_sle::destroy
end on

type uo_1 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_billing_links
integer x = 23
integer y = 156
integer width = 1929
integer height = 112
integer taborder = 20
end type

on uo_1.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AccPkgs

event ue_setproperty(inv_syssetting)


event ue_setvalue(inv_syssetting)

Parent.Event ue_EnableSapSetup(ddlb_1.Text = appeon_constant.cs_SAP)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

event ue_choicechanged;call super::ue_choicechanged;Boolean	lb_Enable

IF as_Value = appeon_constant.cs_SAP THEN
	lb_Enable = TRUE
ELSE
	lb_Enable = FALSE
END IF

Parent.Event ue_EnableSapSetup(lb_Enable)
end event

