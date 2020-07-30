$PBExportHeader$u_tabpg_prprties_edi_general.sru
forward
global type u_tabpg_prprties_edi_general from u_tabpg_prprties_edi
end type
type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_general
end type
type uo_2 from u_cst_syssettings_files within u_tabpg_prprties_edi_general
end type
type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_edi_general
end type
end forward

global type u_tabpg_prprties_edi_general from u_tabpg_prprties_edi
integer width = 1765
string text = "General"
uo_3 uo_3
uo_2 uo_2
uo_1 uo_1
end type
global u_tabpg_prprties_edi_general u_tabpg_prprties_edi_general

on u_tabpg_prprties_edi_general.create
int iCurrent
call super::create
this.uo_3=create uo_3
this.uo_2=create uo_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_3
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_1
end on

on u_tabpg_prprties_edi_general.destroy
call super::destroy
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.uo_1)
end on

type uo_3 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_edi_general
integer x = 50
integer y = 596
integer width = 1934
integer taborder = 30
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_editransport

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;destroy inv_syssetting
end event

on uo_3.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event ue_choicechanged;//overrides ancestor script, added by dan 3-23-06 to do a check to see
//that all sef files are set up for all companies.  The reason is that
//ProfitTools cannot handle the transport if sef files are not set.

boolean 	lb_allowSave
Int 		li_countNulls

IF as_value = "Yes" THEN
	  SELECT Count ( * ) 
		 INTO :li_CountNulls
		 FROM "ediprofile"  
		WHERE "ediprofile"."seffilepath" is null       ;
	COMMIT;
	
	
	
	IF li_countNulls > 0 THEN
		lb_allowSave = false
	ELSE
		lb_allowSave = true
	END IF
	
	IF lb_allowSave THEN
	
	ELSE
		MessageBox("Profit Tools Transport","Some companies did not have all SEF file paths specified. Profit Tools Transport requires that all SEF file paths are set for companies.", EXCLAMATION!)
	END IF
END IF
inv_syssetting.of_savevalue( as_Value )
end event

type uo_2 from u_cst_syssettings_files within u_tabpg_prprties_edi_general
integer x = 23
integer y = 288
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_outboundediruleslocation

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_files::destroy
end on

type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_edi_general
integer x = 23
integer y = 16
integer width = 1563
integer taborder = 10
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_YourCompanySCAC

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_sle::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

