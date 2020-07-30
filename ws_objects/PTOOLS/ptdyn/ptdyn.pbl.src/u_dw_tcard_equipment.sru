$PBExportHeader$u_dw_tcard_equipment.sru
forward
global type u_dw_tcard_equipment from u_dw_tcard
end type
end forward

global type u_dw_tcard_equipment from u_dw_tcard
string title = "Equipment"
string icon = "tracter.ico"
event ue_equipmentdetail ( long al_row )
end type
global u_dw_tcard_equipment u_dw_tcard_equipment

forward prototypes
public function integer of_setrestriction (boolean ab_switch)
end prototypes

event ue_equipmentdetail(long al_row);
//Copied from u_dw_ShipmentList
//Changed hard reference to ds_id to a read of the first column

Long	ll_Row, &
		ll_Id
n_cst_EquipmentManager	lnv_equipmentManager
Date ld_ItinDate

IF This.RowCount ( ) > 0 THEN

	IF al_Row > 0 THEN
	
		ll_Row = al_Row
	
	ELSE
	
		ll_Row = This.GetSelectedRow ( 0 )
	
		IF ll_Row > 0 THEN
	
			//OK
	
		ELSE
	
			ll_Row = This.GetRow ( )
	
		END IF
	
	END IF

END IF


IF ll_Row > 0 THEN

	ll_Id = This.GetItemNumber ( ll_Row, 1 )  //Revise later??
	ld_ItinDate = Date ( DateTime ( Today ( ) ) ) //Strip Unwanted time component   Revise?!
	lnv_EquipmentManager.of_OpenItinerary ( ll_Id, ld_ItinDate )

END IF
end event

public function integer of_setrestriction (boolean ab_switch);Integer	li_Return = NO_ACTION

//Check arguments
If IsNull(ab_switch) Then
	li_Return = FAILURE
ELSEIF ab_Switch THEN
	IF IsNull(inv_restriction) Or Not IsValid (inv_restriction) THEN
		inv_restriction = Create n_cst_dwsrv_restrict_equipment		
		inv_restriction.of_SetRequestor ( THIS )
		li_Return = SUCCESS
	END IF
ELSE 
	IF IsValid (inv_restriction) THEN
		Destroy inv_restriction
		Return SUCCESS
	END IF	
END IF

Return li_Return
end function

on u_dw_tcard_equipment.create
end on

on u_dw_tcard_equipment.destroy
end on

event ue_getcategory;/***************************************************************************************
NAME: 		getCategory	

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			string
	
DESCRIPTION: 	returns the category of this type
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/

//overides ancestor
return "equipment"
end event

event ue_getidcolumn;call super::ue_getidcolumn;/***************************************************************************************
NAME: 			ue_getIDCol

ACCESS:			public
		
ARGUMENTS: 		
							none

RETURNS:			String
	
DESCRIPTION:	
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/


return ancestorReturnValue
end event

event ue_seticon;//overides ancestor, optional to put in logic based on 
//its own data to choose the icon
end event

event dragdrop;call super::dragdrop;//logic for assignment, specific to equipment and possibly source
//dataobjects
end event

event ue_setdragicon;call super::ue_setdragicon;/***************************************************************************************
NAME: 		ue_setdragicon 	

ACCESS:			Public
		
ARGUMENTS: 		
							None

RETURNS:			None
	
DESCRIPTION:	Logic for choosing an icon for this kind of tcard
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Dan and Maury	7-29-05
	

***************************************************************************************/




Long			ll_EquipId, &
				ll_Row

n_cst_EquipmentManager	lnv_EquipmentManager
s_Eq_Info	lstr_Equip


ll_Row = This.GetRow ( )

IF ll_Row > 0 THEN

	ll_EquipId = This.GetItemNumber ( ll_Row, 1 )  //Revise this!?
	
END IF


IF lnv_EquipmentManager.of_Get_Info ( ll_EquipId, lstr_Equip, FALSE /*do not force_refresh*/ ) = 1 THEN
	
	CHOOSE CASE lstr_Equip.eq_Type
			
		CASE "T"  //Tractor
			this.DragIcon = "tracter.ico"
		CASE "S"  //Straight Truck
			this.DragIcon = "st.ico"
		CASE "N"  //Van
			this.DragIcon = "van.ico"
		CASE "C"  //Container
			
			IF lstr_Equip.eq_Length < 40 AND lstr_Equip.eq_Length > 0 THEN
				this.DragIcon = "2u.ico"
			ELSE
				this.DragIcon = "4u.ico"
			END IF
			
		CASE "H"  //Chassis

			IF lstr_Equip.eq_Length < 40 AND lstr_Equip.eq_Length > 0 THEN
				this.DragIcon = "2z.ico"
			ELSE
				this.DragIcon = "4z.ico"
			END IF
			
		CASE "F"  //Flatbed
			
			IF lstr_Equip.eq_Length < 40 AND lstr_Equip.eq_Length > 0 THEN
				this.DragIcon = "2f.ico"
			ELSE
				this.DragIcon = "4f.ico"
			END IF
			
		CASE ELSE  //Use general trailer icon
			
			IF lstr_Equip.eq_Length < 40 AND lstr_Equip.eq_Length > 0 THEN
				this.DragIcon = "pup.ico"
			ELSE
				this.DragIcon = "trlr.ico"
			END IF
		
	END CHOOSE
	
ELSE
	
	//Undetermined type.  Use a question mark??
			
END IF

end event

event ue_getcacheds;//overrides ancestor

Datastore 	lds_temp
return lds_temp
end event

event ue_getitinassignment;//Overriding ancestor : Event is implemented by descendants

//Returns by reference the ItinType and ItinId of the requested al_Row (or the current row if al_row is null)
//Returns : 1 (Success, value determined and passed out by ref), 0 (Does not apply to this Tcard), -1 (Error)


Integer	li_ItinType
Long		ll_ItinId

n_cst_EquipmentManager	lnv_EquipmentManager
s_Eq_Info	lstr_Equip

Integer	li_Return = 1


SetNull ( li_ItinType )
SetNull ( ll_ItinId )

//Validate the target row

IF li_Return = 1 THEN

	IF al_Row > 0 THEN
		IF al_Row <= This.RowCount ( ) THEN
			//OK
		ELSE
			//Invalid row request
			li_Return = -1
		END IF
	ELSE
		al_Row = This.GetRow ( )
		
		IF al_Row > 0 THEN
			//OK
		ELSE
			//No row available
			li_Return = 0
		END IF
	END IF
	
END IF


IF li_Return = 1 THEN
	
	ll_ItinId = This.GetItemNumber ( al_Row, 1 )  //Revise this!?
	
	IF NOT IsNull ( ll_ItinId ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF
	
END IF


IF li_Return = 1 THEN
	
	//If we have an id, look up the ItinType for it.
	
	SetNull ( li_ItinType )
	
	IF lnv_EquipmentManager.of_Get_Info ( ll_ItinId, lstr_Equip, FALSE /*do not force_refresh*/ ) = 1 THEN
		
		li_ItinType = lnv_EquipmentManager.of_GetItinType ( lstr_Equip.eq_Type )
		
	END IF
	
	
	IF IsNull ( li_ItinType ) THEN
		
		li_Return = -1  //Could not determine itin type from id
		
	END IF
	
	
END IF


IF li_Return = 1 THEN
	ai_ItinType = li_ItinType
	al_ItinId = ll_ItinId
ELSE
	SetNull ( ai_ItinType )
	SetNull ( al_ItinId )
END IF


RETURN li_Return
end event

event doubleclicked;call super::doubleclicked;//Extending ancestor

IF Row > 0 THEN
	This.Event ue_EquipmentDetail ( Row )
END IF
end event

