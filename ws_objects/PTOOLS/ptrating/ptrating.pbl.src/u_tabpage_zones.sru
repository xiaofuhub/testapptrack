$PBExportHeader$u_tabpage_zones.sru
forward
global type u_tabpage_zones from u_tabpg
end type
type dw_zones from u_dw_zone within u_tabpage_zones
end type
end forward

global type u_tabpage_zones from u_tabpg
integer width = 2569
long backcolor = 12632256
event ue_zoneadded ( string as_name )
event ue_zoneremoved ( string as_name )
dw_zones dw_zones
end type
global u_tabpage_zones u_tabpage_zones

forward prototypes
public function integer of_getzone (long al_row)
end prototypes

public function integer of_getzone (long al_row);String 	ls_Zone
String	ls_Description
Int		li_Return = -1
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

Open ( w_ZoneSelect ) 

IF IsValid( Message.PowerObjectParm ) THEN
	lnv_Msg = Message.PowerObjectParm
	
	IF lnv_Msg.of_Get_Parm ( "ZONE" , lstr_Parm ) <> 0 THEN
		ls_Zone = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "DESCRIPTION" , lstr_Parm ) <> 0 THEN
		ls_Description = lstr_Parm.ia_Value
	END IF
	
	IF Len ( ls_Zone ) > 0 THEN
		IF dw_zones.find ( "name = '" + ls_Zone + "'" , 1 , 9999 ) > 0 THEN  
			messagebox ( "Add New Zone", "The zone you selected is already part of the route." )
		ELSE
			dw_zones.object.Name [ al_Row ] = ls_Zone
			dw_zones.object.Description [ al_Row ] = ls_Description
			li_Return = 1
		END IF
	END IF
END IF

Return li_Return

	

end function

on u_tabpage_zones.create
int iCurrent
call super::create
this.dw_zones=create dw_zones
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_zones
end on

on u_tabpage_zones.destroy
call super::destroy
destroy(this.dw_zones)
end on

event constructor;call super::constructor;//Extending Ancestor


//Intialize the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)

Integer		li_Border = 32
DragObject	ldo_Reference
ldo_Reference = dw_zones
//inv_Resize.of_SetOrigSize ( ldo_Reference.X + ldo_Reference.Width + li_Border, &
//	ldo_Reference.Y + ldo_Reference.Height + li_Border )
//
////Register resizable controls
//This.inv_resize.of_Register ( dw_zones, 'ScaleToRight&Bottom' )
//
//Trigger resize event to perform initial resize of tabpage contents
//This.TriggerEvent ( "Resize" )

//dw_Zones.Modify ( "name displayonly = yes" )
//dw_Zones.Modify ( "description displayonly = yes" )
dw_zones.object.name.protect = 1
dw_zones.object.description.protect = 1
                
RETURN AncestorReturnValue
end event

type dw_zones from u_dw_zone within u_tabpage_zones
integer x = 82
integer y = 24
integer width = 1906
integer height = 1160
integer taborder = 10
boolean bringtotop = true
end type

event pfc_addrow;call super::pfc_addrow;Long	ll_Return
integer li_RetVal

ll_Return = AncestorReturnValue

IF ll_Return > 0 THEN
	
	li_RetVal = parent.of_GetZone ( ll_Return )
		
	IF li_RetVal < 1 then
		THIS.DeleteRow ( ll_Return )
		ll_Return = 0 // no row was added
		
	ELSE
		Parent.Event ue_ZoneAdded ( dw_zones.object.Name[ll_Return] )
		
	END IF
	
END IF
RETURN 	ll_Return
end event

event constructor;call super::constructor;
setRowFocusIndicator ( FocusRect! )

//THIS.Event ue_setFocusindicator ( TRUE )
of_SetAutoSort ( TRUE )
end event

event pfc_deleterow;// overRide w/ Call TO Super
String	ls_Name
Long		ll_Row
Long		ll_Return = 1


Long	test
IF THIS.RowCount ( ) > 0 THEN
	ll_Row = THIS.GetRow ( )
	IF ll_Row > 0 THEN
		ls_Name = THIS.Object.Name [ll_Row]
		
		
		Test = SUPER::EVENT pfc_DeleteRow ( )
		
		//ll_Return = AncestorReturnValue
		
		IF ll_Return = 1 THEN
			Parent.Event ue_ZoneRemoved ( ls_Name ) 
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
	
	li_RetVal = parent.of_GetZone ( ll_Return )
		
	IF li_RetVal < 1 then
		THIS.DeleteRow ( ll_Return )
		ll_Return = 0 // no row was added
		
	ELSE
		Parent.Event ue_ZoneAdded ( dw_zones.object.eq_id[ll_Return] )
		
	END IF
	
END IF
RETURN 	ll_Return
end event

