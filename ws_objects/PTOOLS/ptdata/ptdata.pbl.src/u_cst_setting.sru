$PBExportHeader$u_cst_setting.sru
forward
global type u_cst_setting from UserObject
end type
type st_label from statictext within u_cst_setting
end type
end forward

global type u_cst_setting from UserObject
int Width=1998
int Height=188
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
st_label st_label
end type
global u_cst_setting u_cst_setting

type variables
Private:
n_cst_beo_Setting	inv_Setting
end variables

forward prototypes
public function integer of_settarget (powerobject apo_target, long al_id, parmtype ae_datatype)
public function integer of_setlabel (string as_label)
protected function string of_getdisplayvalue ()
protected subroutine of_populate ()
protected function integer of_setvalue (string as_value)
end prototypes

public function integer of_settarget (powerobject apo_target, long al_id, parmtype ae_datatype);inv_Setting.of_SetSource ( apo_Target )
inv_Setting.of_SetKeyColumn ( "ss_id" )
inv_Setting.of_SetSourceId ( al_Id )
inv_Setting.of_SetDataType ( ae_DataType )

RETURN 1
end function

public function integer of_setlabel (string as_label);st_Label.Text = as_Label + ":"

RETURN 1
end function

protected function string of_getdisplayvalue ();RETURN inv_Setting.of_GetDisplayValue ( )
end function

protected subroutine of_populate ();//Should be overridden in the decendant
end subroutine

protected function integer of_setvalue (string as_value);RETURN inv_Setting.of_SetValue ( as_Value )
end function

on u_cst_setting.create
this.st_label=create st_label
this.Control[]={this.st_label}
end on

on u_cst_setting.destroy
destroy(this.st_label)
end on

event constructor;Post of_Populate ( )
inv_Setting.Post of_SetCreateOnDemand ( TRUE )
end event

type st_label from statictext within u_cst_setting
int Y=4
int Width=1504
int Height=80
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

