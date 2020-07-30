$PBExportHeader$u_tabpage_communication_equipment.sru
forward
global type u_tabpage_communication_equipment from u_tabpg
end type
type dw_equipment from u_dw_communication_setup_equipment within u_tabpage_communication_equipment
end type
end forward

global type u_tabpage_communication_equipment from u_tabpg
int Width=3323
int Height=716
dw_equipment dw_equipment
end type
global u_tabpage_communication_equipment u_tabpage_communication_equipment

on u_tabpage_communication_equipment.create
int iCurrent
call super::create
this.dw_equipment=create dw_equipment
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_equipment
end on

on u_tabpage_communication_equipment.destroy
call super::destroy
destroy(this.dw_equipment)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_equipment
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_equipment, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_equipment from u_dw_communication_setup_equipment within u_tabpage_communication_equipment
event ue_equipment_added ( )
int X=32
int Y=32
int Width=3255
int Height=648
int TabOrder=10
boolean BringToTop=true
string DataObject="d_communication_setup_equipment"
boolean HScrollBar=true
end type

event ue_equipment_added;String	ls_Value
String	lsa_DeviceList[]
String	ls_Device
Int		li_Return
Long		ll_Row
Boolean	lb_OpenDlg = FALSE
Long		ll_DeviceCount


s_eq_info find_eqs

n_cst_EquipmentManager	lnv_EquipmentManager
g_tempstr = "200" 


ll_Row = THIS.GetRow( )
openwithparm(w_equip_select, null_ds)
find_eqs.eq_id = message.doubleparm

IF gf_eq_info(null_ds, null_str, null_str, find_eqs) < 1 then
	li_Return = 0 // no row was added
	THIS.Event pfc_DeleteRow ( )
ELSE
	
	n_cst_bso_Communication_Manager lnv_Communication

	lnv_Communication = CREATE    n_cst_bso_Communication_Manager
	//
	
	IF IsValid ( lnv_Communication ) THEN
		ll_DeviceCount = lnv_Communication.Of_getlicenseddevices ( lsa_DeviceList ) 
		IF ll_DeviceCount > 0 AND UpperBound (lsa_DeviceList) > 0 THEN
			ls_Device = Upper ( lsa_DeviceList[1] )
		END IF
		DESTROY ( lnv_Communication ) 
	END IF
	
	//make sure this equipment wasn'T already picked

	trim(gf_eqref(find_eqs.eq_type, find_eqs.eq_ref))
	THIS.SetItem ( ll_row , "equipmentid", Find_eqs.eq_ID)
	THIS.SetItem ( ll_row , "equipment_type", Find_eqs.eq_Type)
	THIS.SetItem ( ll_row , "equipment_eq_ref", Find_eqs.eq_Ref)
	IF Len ( ls_Device ) > 0 THEN
		THIS.SetItem ( ll_Row , "type", ls_Device )
	ELSE
		MessageBox( "Device Type" , "No devices were found to be licensed. Processing stopped.")
		THIS.Event pfc_DeleteRow ( )
	END IF
END IF
end event

event pfc_addrow;call super::pfc_addrow;
Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
	THIS.Event ue_Equipment_Added ( )
END IF

RETURN ll_Return
end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_Return

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
	THIS.Event ue_Equipment_Added ( )
END IF

RETURN ll_Return
end event

