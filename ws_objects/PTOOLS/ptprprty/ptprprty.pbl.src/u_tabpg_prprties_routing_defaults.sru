$PBExportHeader$u_tabpg_prprties_routing_defaults.sru
forward
global type u_tabpg_prprties_routing_defaults from u_tabpg_prprties_routing
end type
type uo_autoaddbobtails from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_routing_defaults
end type
type uo_daysbacktocache from u_cst_syssettings_intergerspin within u_tabpg_prprties_routing_defaults
end type
type uo_newtripsite from u_cst_syssettings_sle_company within u_tabpg_prprties_routing_defaults
end type
type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_routing_defaults
end type
type uo_defaultitintype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_routing_defaults
end type
type uo_assiociationvalidation from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_routing_defaults
end type
type uo_intindays from u_cst_syssettings_sle within u_tabpg_prprties_routing_defaults
end type
type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_routing_defaults
end type
type uo_defaultlegautoroute from u_cst_syssettings_ddc_defltlegautoroute within u_tabpg_prprties_routing_defaults
end type
type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_routing_defaults
end type
end forward

global type u_tabpg_prprties_routing_defaults from u_tabpg_prprties_routing
integer width = 2002
integer height = 1668
string text = "Defaults"
uo_autoaddbobtails uo_autoaddbobtails
uo_daysbacktocache uo_daysbacktocache
uo_newtripsite uo_newtripsite
uo_2 uo_2
uo_defaultitintype uo_defaultitintype
uo_assiociationvalidation uo_assiociationvalidation
uo_intindays uo_intindays
uo_1 uo_1
uo_defaultlegautoroute uo_defaultlegautoroute
uo_3 uo_3
end type
global u_tabpg_prprties_routing_defaults u_tabpg_prprties_routing_defaults

on u_tabpg_prprties_routing_defaults.create
int iCurrent
call super::create
this.uo_autoaddbobtails=create uo_autoaddbobtails
this.uo_daysbacktocache=create uo_daysbacktocache
this.uo_newtripsite=create uo_newtripsite
this.uo_2=create uo_2
this.uo_defaultitintype=create uo_defaultitintype
this.uo_assiociationvalidation=create uo_assiociationvalidation
this.uo_intindays=create uo_intindays
this.uo_1=create uo_1
this.uo_defaultlegautoroute=create uo_defaultlegautoroute
this.uo_3=create uo_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_autoaddbobtails
this.Control[iCurrent+2]=this.uo_daysbacktocache
this.Control[iCurrent+3]=this.uo_newtripsite
this.Control[iCurrent+4]=this.uo_2
this.Control[iCurrent+5]=this.uo_defaultitintype
this.Control[iCurrent+6]=this.uo_assiociationvalidation
this.Control[iCurrent+7]=this.uo_intindays
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.uo_defaultlegautoroute
this.Control[iCurrent+10]=this.uo_3
end on

on u_tabpg_prprties_routing_defaults.destroy
call super::destroy
destroy(this.uo_autoaddbobtails)
destroy(this.uo_daysbacktocache)
destroy(this.uo_newtripsite)
destroy(this.uo_2)
destroy(this.uo_defaultitintype)
destroy(this.uo_assiociationvalidation)
destroy(this.uo_intindays)
destroy(this.uo_1)
destroy(this.uo_defaultlegautoroute)
destroy(this.uo_3)
end on

type uo_autoaddbobtails from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_routing_defaults
integer x = 32
integer y = 1108
integer width = 1865
integer height = 116
integer taborder = 90
end type

event constructor;call super::constructor;
inv_syssetting = CREATE n_cst_setting_autoaddbobtail

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_autoaddbobtails.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

event destructor;call super::destructor;destroy inv_syssetting
end event

type uo_daysbacktocache from u_cst_syssettings_intergerspin within u_tabpg_prprties_routing_defaults
integer x = 41
integer y = 1452
integer taborder = 100
end type

on uo_daysbacktocache.destroy
call u_cst_syssettings_intergerspin::destroy
end on

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_daysofitintocache
THIS.of_SetBounds( 1, 365)
event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

type uo_newtripsite from u_cst_syssettings_sle_company within u_tabpg_prprties_routing_defaults
integer x = 5
integer y = 1188
integer width = 1865
integer taborder = 90
end type

event constructor;call super::constructor;

inv_syssetting = CREATE n_cst_setting_newtripendtripcompany

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_newtripsite.destroy
call u_cst_syssettings_sle_company::destroy
end on

type uo_2 from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_routing_defaults
integer x = 27
integer y = 988
integer width = 1865
integer height = 116
integer taborder = 80
end type

event constructor;call super::constructor;
inv_syssetting = CREATE n_cst_setting_hideyardmovesonbill

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_2.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_defaultitintype from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_routing_defaults
integer x = 27
integer y = 284
integer width = 1920
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultItineraryButton

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_defaultitintype.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

type uo_assiociationvalidation from u_cst_syssettings_enumerated_2rb within u_tabpg_prprties_routing_defaults
integer x = 27
integer y = 872
integer width = 1865
integer height = 116
integer taborder = 70
end type

event constructor;call super::constructor;

inv_syssetting = CREATE n_cst_setting_associationvalidation

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_assiociationvalidation.destroy
call u_cst_syssettings_enumerated_2rb::destroy
end on

type uo_intindays from u_cst_syssettings_sle within u_tabpg_prprties_routing_defaults
integer x = 5
integer y = 596
integer width = 1865
integer taborder = 60
end type

event constructor;call super::constructor;THIS.of_Setslewidth( 270 )

inv_syssetting = CREATE n_cst_setting_numberofitindays

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_intindays.destroy
call u_cst_syssettings_sle::destroy
end on

event ue_valuechanged;//Override w. call to super

Int	li_Value
IF NOT isNumber ( as_Value ) THEN
	MessageBox ( "Itin days" , "Please enter a number from 0 to 364.")
ELSE
	li_Value = Integer ( as_Value )
	IF li_Value >= 0 AND li_Value < 365 THEN
		Super:: event ue_valuechanged( as_value )
	ELSE
		MessageBox ( "Itin days" , "Please enter a number from 0 to 364.")
		
	END IF
	
END IF

end event

type uo_1 from u_cst_syssettings_sle within u_tabpg_prprties_routing_defaults
integer x = 5
integer y = 368
integer width = 1870
integer taborder = 50
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultEventDuration

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

event destructor;call super::destructor;Destroy(inv_syssetting)
end event

on uo_1.destroy
call u_cst_syssettings_sle::destroy
end on

event pfc_validation;call super::pfc_validation;messagebox('time', '')

return AncestorReturnValue

end event

event ue_validatecontrols;call super::ue_validatecontrols;Int li_Return = 1
String ls_time

ls_time = Trim(Sle_1.Text)

if len(ls_time) = 0 or isnull(ls_time) then
	//skip validate
else
	IF inv_syssetting.of_ShouldValidate( ) THEN
		IF istime(ls_time) THEN
			//valid
			sle_1.text = String(time(ls_time),"hh:mm")
		ELSE
			Messagebox("Default Duration","The time entered is not valid.")
			Sle_1.SetFocus()
			li_Return = -1
		END IF	
	END IF	
end if

Return li_Return
end event

event ue_valuechanged;call super::ue_valuechanged;Int li_Return = 1
String ls_time

ls_time = Trim(Sle_1.Text)

if len(ls_time) = 0 or isnull(ls_time) then
	//skip validate
else
	IF inv_syssetting.of_ShouldValidate( ) THEN
		IF istime(ls_time) THEN
			//valid
			sle_1.text = String(time(ls_time),"hh:mm")
		ELSE
			Messagebox("Default Duration","The time entered is not valid.")
			Sle_1.SetFocus()
			li_Return = -1
		END IF	
	END IF	
end if

end event

type uo_defaultlegautoroute from u_cst_syssettings_ddc_defltlegautoroute within u_tabpg_prprties_routing_defaults
integer x = 27
integer y = 28
integer taborder = 20
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_DefaultLegAutoRoute

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)

end event

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

on uo_defaultlegautoroute.destroy
call u_cst_syssettings_ddc_defltlegautoroute::destroy
end on

type uo_3 from u_cst_syssettings_dropdownchoices within u_tabpg_prprties_routing_defaults
integer x = 27
integer y = 156
integer width = 1934
integer taborder = 40
end type

event constructor;call super::constructor;inv_syssetting = CREATE n_cst_setting_AutoRouteDefaultType

event ue_setproperty(inv_syssetting)

event ue_setvalue(inv_syssetting)
end event

on uo_3.destroy
call u_cst_syssettings_dropdownchoices::destroy
end on

event destructor;call super::destructor;DESTROY (inv_syssetting)
end event

