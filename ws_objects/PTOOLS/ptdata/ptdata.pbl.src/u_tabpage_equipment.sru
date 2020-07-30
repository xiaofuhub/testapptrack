$PBExportHeader$u_tabpage_equipment.sru
$PBExportComments$Route equipment.
forward
global type u_tabpage_equipment from u_tabpg
end type
type dw_equipmentinfo from u_dw_equipment within u_tabpage_equipment
end type
end forward

global type u_tabpage_equipment from u_tabpg
int Width=2377
int Height=872
event ue_equipmentadded ( long al_equipid )
event ue_equipmentremoved ( long al_equipmentid )
dw_equipmentinfo dw_equipmentinfo
end type
global u_tabpage_equipment u_tabpage_equipment

forward prototypes
private function integer of_getequipment (long al_row)
end prototypes

private function integer of_getequipment (long al_row);integer li_Return
s_eq_info find_eqs

g_tempstr = "ANYEQ300" 
openwithparm(w_equip_select, null_ds)
find_eqs.eq_id = message.doubleparm

IF gf_eq_info(null_ds, null_str, null_str, find_eqs) < 1 then
	li_Return = 0 // no row was added
	
ELSE
	
	//make sure this equipment wasn'T already picked
	IF dw_equipmentinfo.find ( "eq_id = " + string ( Find_eqs.eq_ID ), 1, dw_equipmentinfo.RowCount() ) > 0 THEN
		messagebox ( "Add New Equipment", "The equipment you selected is already part of the route." ) 
	ELSE
		trim(gf_eqref(find_eqs.eq_type, find_eqs.eq_ref))
		dw_equipmentinfo.object.eq_id[al_row] = Find_eqs.eq_ID
		dw_equipmentinfo.object.equipment_Type[al_row] = Find_eqs.eq_Type 
		dw_equipmentinfo.object.eq_Ref[al_row] = Find_eqs.eq_Ref
		dw_equipmentinfo.object.eq_outside[al_row] = Find_eqs.eq_Outside
		dw_equipmentinfo.object.eq_Length[al_row] = Find_eqs.eq_length
		dw_equipmentinfo.object.eq_Height[al_row] = Find_eqs.eq_Height
		dw_equipmentinfo.object.eq_Volume[al_row] = Find_eqs.eq_Volume
		dw_equipmentinfo.object.eq_Axles[al_row] = Find_eqs.eq_Axles
		dw_equipmentinfo.object.equipment_Air[al_row] = Find_eqs.eq_Air 
		li_Return = 1
	END IF
	
END IF

Return li_Return
end function

on u_tabpage_equipment.create
int iCurrent
call super::create
this.dw_equipmentinfo=create dw_equipmentinfo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_equipmentinfo
end on

on u_tabpage_equipment.destroy
call super::destroy
destroy(this.dw_equipmentinfo)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_equipmentinfo
inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
	ldo_Reference.Y + ldo_Reference.Height + li_Border )

//Register resizable controls
This.inv_resize.of_Register ( dw_equipmentinfo, 'ScaleToRight&Bottom' )

//Trigger resize event to perform initial resize of tabpage contents
This.TriggerEvent ( "Resize" )


RETURN AncestorReturnValue
end event

type dw_equipmentinfo from u_dw_equipment within u_tabpage_equipment
int X=9
int Y=24
int Width=2331
int Height=816
int TabOrder=10
boolean BringToTop=true
end type

event pfc_addrow;call super::pfc_addrow;Long	ll_Return
integer li_RetVal

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
	
	li_RetVal = parent.of_GetEquipment ( ll_Return )
		
	IF li_RetVal < 1 then
		THIS.DeleteRow ( ll_Return )
		ll_Return = 0 // no row was added
		
	ELSE
		Parent.Event ue_EquipmentAdded ( dw_equipmentinfo.object.eq_id[ll_Return] )
		
	END IF
	
END IF
RETURN 	ll_Return
end event

event pfc_deleterow;// overRide w/ Call TO Super

Long	ll_Row
Long	ll_EquipID
Long	ll_Return = 1

Long	test
IF THIS.RowCount ( ) > 0 THEN
	ll_Row = THIS.GetRow ( )
	IF ll_Row > 0 THEN
		ll_EquipID = THIS.Object.eq_ID [ll_Row]
		
		
		Test = SUPER::EVENT pfc_DeleteRow ( )
		
		//ll_Return = AncestorReturnValue
		
		IF ll_Return = 1 THEN
			Parent.Event ue_EquipmentRemoved ( ll_EquipID ) 
		END IF
	ELSE
		MessageBox ( "Delete Row" , "Please select a row to be deleted." ) 
		
	END IF
END IF
RETURN 1

end event

event pfc_insertrow;call super::pfc_insertrow;Long	ll_Return
integer li_RetVal

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
	
	li_RetVal = parent.of_GetEquipment ( ll_Return )
		
	IF li_RetVal < 1 then
		THIS.DeleteRow ( ll_Return )
		ll_Return = 0 // no row was added
		
	ELSE
		Parent.Event ue_EquipmentAdded ( dw_equipmentinfo.object.eq_id[ll_Return] )
		
	END IF
	
END IF
RETURN 	ll_Return
end event

event constructor;call super::constructor;
of_SetAutoSort ( TRUE )

end event

