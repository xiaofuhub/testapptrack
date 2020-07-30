$PBExportHeader$u_cst_setting_enumerated.sru
forward
global type u_cst_setting_enumerated from u_cst_setting
end type
type ddlb_setting from u_ddlb_setting within u_cst_setting_enumerated
end type
end forward

global type u_cst_setting_enumerated from u_cst_setting
ddlb_setting ddlb_setting
end type
global u_cst_setting_enumerated u_cst_setting_enumerated

forward prototypes
public function integer of_addvalue (any aa_datavalue, string as_displayvalue)
public function integer of_settarget (powerobject apo_target, long al_id, parmtype ae_datatype)
end prototypes

public function integer of_addvalue (any aa_datavalue, string as_displayvalue);RETURN ddlb_Setting.of_AddValue ( aa_DataValue, as_DisplayValue )
end function

public function integer of_settarget (powerobject apo_target, long al_id, parmtype ae_datatype);RETURN ddlb_Setting.of_SetTarget ( apo_Target, al_id, ae_DataType )
end function

on u_cst_setting_enumerated.create
int iCurrent
call super::create
this.ddlb_setting=create ddlb_setting
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_setting
end on

on u_cst_setting_enumerated.destroy
call super::destroy
destroy(this.ddlb_setting)
end on

type ddlb_setting from u_ddlb_setting within u_cst_setting_enumerated
int X=0
int Y=88
int Width=681
end type

