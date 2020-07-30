$PBExportHeader$u_dw_tcard_drivers.sru
forward
global type u_dw_tcard_drivers from u_dw_tcard
end type
end forward

global type u_dw_tcard_drivers from u_dw_tcard
string title = "Drivers"
string icon = "driv.ico"
event ue_driverdetail ( long al_row )
end type
global u_dw_tcard_drivers u_dw_tcard_drivers

forward prototypes
public function integer of_setrestriction (boolean ab_switch)
public function integer of_getidcolumn ()
end prototypes

event ue_driverdetail(long al_row);Long	ll_Row, &
		ll_Id
n_cst_EquipmentManager	lnv_EquipmentManager
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
	ld_ItinDate = Date ( DateTime ( Today ( ) ) ) //Strip Unwanted time component   Revise?!
	ll_Id = This.GetItemNumber ( ll_Row, this.of_getidcolumn( ) )  //Revise later??
	lnv_EquipmentManager.of_openDriverItinerary( ll_Id, ld_ItinDate  )
END IF
end event

public function integer of_setrestriction (boolean ab_switch);Integer	li_Return = NO_ACTION

//Check arguments
If IsNull(ab_switch) Then
	li_Return = FAILURE
ELSEIF ab_Switch THEN
	IF IsNull(inv_restriction) Or Not IsValid (inv_restriction) THEN
		inv_restriction = Create n_cst_dwsrv_restrict_drivers		
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

public function integer of_getidcolumn ();Int li_return = 1

IF this.of_GetRetrievetype( ) = ci_cache THEN
	li_return =2 
END IF

RETURN li_Return
	
end function

on u_dw_tcard_drivers.create
end on

on u_dw_tcard_drivers.destroy
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
return "driver"
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

event dragdrop;call super::dragdrop;//logic for data assignment based on this data and data of the object
//being dropped on it

//this.of_watchListLogic(source, row, dwo)
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

this.DragIcon = "driv.ico"

end event

event ue_getcacheds;//overrides ancestor

Datastore 	lds_Cache

n_cst_employeeManager	lnv_employeeManager

lnv_employeeManager.of_refreshEmployees()
lds_Cache = lnv_EmployeeManager.of_get_dsemployee( )

return lds_Cache
end event

event ue_getitinassignment;call super::ue_getitinassignment;//Overriding ancestor : Event is implemented by descendants

//Returns by reference the ItinType and ItinId of the requested al_Row (or the current row if al_row is null)
//Returns : 1 (Success, value determined and passed out by ref), 0 (Does not apply to this Tcard), -1 (Error)

Integer	li_ItinType
Long		ll_ItinId

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
	
	li_ItinType = gc_Dispatch.ci_ItinType_Driver
	
	//DEK 6-14-07 Had to move the driver ids to the second column with the cach view because
	//gf_rowsync needed to look at the first row for caching, and that needed to be the event id
	//for the drivers, because gf_rowsync is hardcoded to look at the first row when syncing up the driver cache.
	IF this.of_getretrievetype( ) = ci_cache THEN
		ll_ItinId = This.GetItemNumber ( al_Row, 2 )  //Revise this!?
	ELSE
		ll_ItinId = This.GetItemNumber ( al_Row, 1 )  //Revise this!?
	END IF
	
	IF NOT IsNull ( ll_ItinId ) THEN
		//OK
	ELSE
		li_Return = 0
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

//this is logic for dealing with groups, it will reset the current row
//if the thing dropped on is a header or trailer and set the current row
//to the first row in the group.
IF row = 0 THEN
	row = this.of_doGroupRowCalculation( )
	IF row = -1 THEN
		row = 0
	END IF
END IF

IF Row > 0 THEN
	This.Event ue_DriverDetail ( Row )
END IF
end event

event ue_reload;call super::ue_reload;
return ancestorreturnvalue
end event

