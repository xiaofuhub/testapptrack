$PBExportHeader$u_ddlb_setting.sru
forward
global type u_ddlb_setting from dropdownlistbox
end type
end forward

global type u_ddlb_setting from dropdownlistbox
int Width=558
int Height=229
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_ddlb_setting u_ddlb_setting

type variables
Protected:
n_cst_beo_Setting_Enumerated	inv_Setting
end variables

forward prototypes
private subroutine of_populate ()
public function integer of_settarget (powerobject apo_target, long al_id, parmtype ae_datatype)
public function integer of_addvalue (any aa_datavalue, string as_displayvalue)
end prototypes

private subroutine of_populate ();Long	ll_Count, &
		ll_Ndx
String	lsa_List[]

ll_Count = inv_Setting.of_GetDisplayList ( lsa_List )

FOR ll_Ndx = 1 TO ll_Count

	This.AddItem ( lsa_List [ ll_Ndx ] )

NEXT

SelectItem ( inv_Setting.of_GetDisplayValue ( ), 0 )

inv_Setting.of_SetCreateOnDemand ( TRUE )
end subroutine

public function integer of_settarget (powerobject apo_target, long al_id, parmtype ae_datatype);inv_Setting.of_SetSource ( apo_Target )
inv_Setting.of_SetKeyColumn ( "ss_id" )
inv_Setting.of_SetSourceId ( al_Id )
inv_Setting.of_SetDataType ( ae_DataType )

RETURN 1
end function

public function integer of_addvalue (any aa_datavalue, string as_displayvalue);IF inv_Setting.of_AddValue ( aa_DataValue, as_DisplayValue ) = 1 THEN
	This.Height += 100
	RETURN 1
ELSE
	RETURN -1
END IF
end function

event selectionchanged;inv_Setting.of_SetValue ( This.Text )
end event

event constructor;Post of_Populate ( )
end event

