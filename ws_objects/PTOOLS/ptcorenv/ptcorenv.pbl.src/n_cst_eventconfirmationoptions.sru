$PBExportHeader$n_cst_eventconfirmationoptions.sru
forward
global type n_cst_eventconfirmationoptions from n_cst_base
end type
end forward

global type n_cst_eventconfirmationoptions from n_cst_base
end type
global n_cst_eventconfirmationoptions n_cst_eventconfirmationoptions

type variables
Public:

// ROW CONSTANTS
CONSTANT STRING cs_ShipmentAuthorization = "Shipment Authorization"
CONSTANT STRING cs_TerminationEventconfirmation = "Termination Event Confirmation"
CONSTANT STRING cs_EventConfirmation = "Event Confirmation"

// COLUMN CONSTANTS
CONSTANT STRING cs_Driver = "DRIVER"
CONSTANT STRING cs_Tractor = "TRACTOR"
CONSTANT STRING cs_Chassis = "CHASSIS"
CONSTANT STRING cs_FreightCarrying = "FREIGHT"


Private:
DataStore	ids_Source


CONSTANT int ci_RowEventConfirmation = 1
CONSTANT int ci_RowTemminationEvent = 2
CONSTANT int ci_RowShipmentAuthorization = 3

CONSTANT int ci_ColumnDriver = 1
CONSTANT int ci_ColumnTractor = 2
CONSTANT int ci_ColumnFreightCarrying = 3
CONSTANT int ci_ColumnChassis = 4

Boolean 		iba_Matrix[3,4]
end variables

forward prototypes
public function datastore of_getsource ()
private function integer of_populatedata ()
public function integer of_savesource ()
private function string of_getterminationstring ()
private function string of_getconfirmationstring ()
private function string of_getauthorizationstring ()
public function blob of_getfullstate ()
public function integer of_setfullstate (blob ablb_State)
public function boolean of_isrequired (string as_RowConstant, string as_ColumnConstant)
public function integer of_openwindow ()
public function integer of_checkrequirements (n_cst_bso_dispatch anv_dispatch, long al_id, string as_rowconstant)
private function integer of_initializematrixtotrue ()
end prototypes

public function datastore of_getsource ();return ids_source
end function

private function integer of_populatedata ();Int	i , j
Int	li_Value
String ls_Label

IF isValid ( ids_Source ) THEN
	ids_Source.Reset () 
END IF

//not displaying shipmentauthorization at this time
//FOR i = 1 TO 3  // loop through the rows
FOR i = 1 TO 2  // loop through the rows
	ids_Source.InsertRow ( 0 )
	CHOOSE CASE i
		CASE ci_roweventconfirmation
			ls_Label = cs_eventconfirmation	
		CASE ci_rowtemminationevent
			ls_Label = cs_terminationeventconfirmation
		CASE ci_rowshipmentauthorization
			ls_Label = cs_shipmentauthorization
	END CHOOSE
			
	ids_Source.object.label [ i ] = ls_Label
	
	FOR j = 1 TO 4   // then the columns
		
		IF iba_Matrix [ i , j ] THEN
			li_Value = 1
		ELSE
			li_Value = 0
		END IF
		ids_source.SetItem ( i , j , li_Value )
	NEXT
NEXT

RETURN 1
end function

public function integer of_savesource ();String 	ls_TerminationEvent
String	ls_EventConfirmation
String	ls_ShipmentAuth
Long		ll_FindRow
Long		ll_NewRow
Int		li_Return = 1

DataStore	lds_Settings

lds_Settings = CREATE DataStore
lds_Settings.DataObject = "d_Settings"
lds_Settings.SetTransObject ( SQLCA )

IF lds_Settings.Retrieve ( ) >= 0 THEN
	COMMIT ;
	
ELSE
	ROLLBACK ;
	DESTROY lds_Settings
	li_Return = -1
END IF


IF li_Return = 1 THEN
	
	ls_TerminationEvent = THIS.of_GetTerminationString ( ) 
	ls_EventConfirmation = THIS.of_GetConfirmationString ( )
	ls_ShipmentAuth = THIS.of_GetAuthorizationString ( )
	
	
	
	IF IsNull ( ls_EventConfirmation ) OR li_Return = -1 THEN
		li_Return = -1
	ELSE
		ll_FindRow = lds_Settings.Find ( "ss_id = 79" , 1 , lds_Settings.RowCount ( ) + 1)
		IF ll_FindRow > 0 THEN
			lds_Settings.SetItem ( ll_FindRow , "ss_String" , ls_EventConfirmation )
			ll_FindRow = 0
		ELSE
			ll_NewRow = lds_Settings.insertRow ( 0 ) 
			lds_Settings.SetItem ( ll_NewRow , "ss_String" , ls_EventConfirmation )
			lds_Settings.SetItem ( ll_NewRow , "ss_id" , 79 )
		END IF
	END IF
	
	IF IsNull ( ls_TerminationEvent ) THEN
		li_Return = -1
	ELSE
		ll_FindRow = lds_Settings.Find ( "ss_id = 80" , 1 , lds_Settings.RowCount ( ) + 1 )
		IF ll_FindRow > 0 THEN
			lds_Settings.SetItem ( ll_FindRow , "ss_String" , ls_TerminationEvent )
			ll_FindRow = 0
		ELSE
			ll_NewRow = lds_Settings.insertRow ( 0 ) 
			lds_Settings.SetItem ( ll_NewRow , "ss_String" , ls_TerminationEvent )
			lds_Settings.SetItem ( ll_NewRow , "ss_id" , 80 )
		END IF
	END IF
	
//	IF IsNull ( ls_ShipmentAuth ) OR li_Return = -1 THEN
//		li_Return = -1
//	ELSE
//		ll_FindRow = lds_Settings.Find ( "ss_id = 81", 1 , lds_Settings.RowCount ( ) + 1 )
//		IF ll_FindRow > 0 THEN
//			lds_Settings.SetItem ( ll_FindRow , "ss_String" , ls_ShipmentAuth )
//			ll_FindRow = 0
//		ELSE
//			ll_NewRow = lds_Settings.insertRow ( 0 ) 
//			lds_Settings.SetItem ( ll_NewRow , "ss_String" , ls_ShipmentAuth )
//			lds_Settings.SetItem ( ll_NewRow , "ss_id" , 81 )
//		END IF
//	END IF
	
	
	IF li_Return = 1 THEN
		IF lds_Settings.UPDATE ( ) = 1 THEN
			COMMIT;
		ELSE
			ROLLBACK;
			li_Return = -1
		END IF
	END IF
		
END IF

RETURN li_Return 

end function

private function string of_getterminationstring ();String	ls_Return

IF Not IsValid ( ids_Source ) OR (ids_Source.RowCount ( ) < ci_rowtemminationevent) THEN
	SetNull ( ls_Return )
	RETURN ls_Return
END IF

IF ids_source.GetItemNumber ( ci_rowtemminationevent , ci_columndriver ) = 0 THEN
	ls_Return += cs_driver + ","
END IF

IF ids_source.GetItemNumber ( ci_rowtemminationevent , ci_columntractor ) = 0 THEN
	ls_Return += cs_tractor + ","
END IF

IF ids_source.GetItemNumber ( ci_rowtemminationevent , ci_columnfreightcarrying ) = 0 THEN
	ls_Return += cs_freightcarrying + ","
END IF

IF ids_source.GetItemNumber ( ci_rowtemminationevent , ci_columnchassis ) = 0 THEN
	ls_Return += cs_chassis + ","
END IF

RETURN ls_Return
end function

private function string of_getconfirmationstring ();String	ls_Return

IF Not IsValid ( ids_Source ) OR (ids_Source.RowCount ( ) < ci_roweventconfirmation) THEN
	SetNull ( ls_Return )
	RETURN ls_Return
END IF

IF ids_source.GetItemNumber ( ci_roweventconfirmation , ci_columndriver ) = 0 THEN
	ls_Return += cs_driver + ","
END IF

IF ids_source.GetItemNumber ( ci_roweventconfirmation , ci_columntractor ) = 0 THEN
	ls_Return += cs_tractor + ","
END IF
	
IF ids_source.GetItemNumber ( ci_roweventconfirmation , ci_columnfreightcarrying ) = 0 THEN
	ls_Return += cs_freightcarrying + ","
END IF

IF ids_source.GetItemNumber ( ci_roweventconfirmation , ci_columnchassis ) = 0 THEN
	ls_Return += cs_chassis + ","
END IF

RETURN ls_Return
end function

private function string of_getauthorizationstring ();String	ls_Return

IF Not IsValid ( ids_Source ) OR (ids_Source.RowCount ( ) < ci_rowshipmentauthorization) THEN
	SetNull ( ls_Return )
	RETURN ls_Return
END IF

IF ids_source.GetItemNumber ( ci_rowshipmentauthorization , ci_columndriver ) = 0 THEN
	ls_Return += cs_driver + ","
	//IF Len ( ls_Return ) > 0 THEN ls_Return += ","
END IF

IF ids_source.GetItemNumber ( ci_rowshipmentauthorization , ci_columntractor ) = 0 THEN
	ls_Return += cs_tractor + ","
END IF
	
IF ids_source.GetItemNumber ( ci_rowshipmentauthorization , ci_columnfreightcarrying ) = 0 THEN
	ls_Return += cs_freightcarrying + ","
END IF

IF ids_source.GetItemNumber ( ci_rowshipmentauthorization , ci_columnchassis ) = 0 THEN
	ls_Return += cs_chassis + ","
END IF

RETURN ls_Return
end function

public function blob of_getfullstate ();Blob	lblb_State

ids_Source.GetFullState ( lblb_State )

RETURN lblb_State

end function

public function integer of_setfullstate (blob ablb_State);RETURN ids_Source.SetFullState ( ablb_State )
end function

public function boolean of_isrequired (string as_RowConstant, string as_ColumnConstant);Int	li_Row
Int	li_Column
Boolean	lb_Return  // return null on error

CHOOSE CASE as_RowConstant
	CASE cs_terminationeventconfirmation
		li_Row = ci_rowtemminationevent
	CASE cs_eventconfirmation
		li_Row = ci_roweventconfirmation
	CASE cs_shipmentauthorization
		li_Row = ci_rowshipmentauthorization
END CHOOSE

CHOOSE CASE as_ColumnConstant
	CASE cs_driver
		li_Column = ci_columndriver
	CASE cs_tractor
		li_Column = ci_columntractor
	CASE cs_freightcarrying
		li_Column = ci_columnfreightcarrying
	CASE cs_chassis
		li_Column = ci_columnchassis
END CHOOSE

IF li_Row > 0 AND li_Row <= ids_Source.RowCount ( ) AND li_Column > 0 AND li_Column <=  Long ( ids_Source.Describe ( "dataWindow.Column.count" ) ) THEN
	lb_Return = ( ids_Source.GetItemNumber ( li_Row , li_Column ) = 1 )
ELSE 
	SetNull ( lb_Return ) 
END IF
RETURN lb_Return
end function

public function integer of_openwindow ();openWithParm ( w_eventConfirmationOptions , THIS )
RETURN 1
end function

public function integer of_checkrequirements (n_cst_bso_dispatch anv_dispatch, long al_id, string as_rowconstant);//Returns : 1, -1

Boolean		lb_IsThirdParty, &
				lb_HasSite, &
				lb_HasDateArrived, &
				lb_HasTimes, &
				lb_IsNonRouted

Long			lla_Drivers[], &
				lla_PowerUnits[], &
				lla_TrailerChassis[], &
				lla_Containers[]

String		ls_ErrorMessage, &
				ls_Type

n_cst_beo_Event	lnv_Event
n_cst_beo_shipment lnv_shipment
DataStore			lds_Events, &
						lds_shipments
n_cst_OFRError		lnv_Error
n_cst_EquipmentManager	lnv_EquipmentMan

Integer	li_Return = 1

lnv_Event = CREATE n_cst_beo_Event

IF li_Return = 1 THEN

	IF NOT IsValid ( anv_Dispatch ) THEN

		ls_ErrorMessage += "Processing error: Invalid dispatch object."
		li_Return = -1

	ELSEIF IsNull ( al_Id ) THEN

		ls_ErrorMessage += "Processing error: Null event id."
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	lds_Events = anv_Dispatch.of_GetEventCache ( )

	IF NOT IsValid ( lds_Events ) THEN

		ls_ErrorMessage += "Processing error: Invalid event cache."
		li_Return = -1

	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( lds_Events )
	lnv_Event.of_SetSourceId ( al_Id )

	IF lnv_Event.of_HasSource ( ) = TRUE THEN
		//OK
	ELSE
		ls_ErrorMessage += "Processing error: Invalid event source."
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_shipment = CREATE n_cst_beo_shipment
	lds_shipments = anv_Dispatch.of_GetShipmentCache ( )
	anv_Dispatch.of_retrieveshipment(lnv_event.of_GetShipment())
	lnv_Shipment.of_SetSource ( lds_Shipments )
	lnv_Shipment.of_SetSourceId ( lnv_event.of_GetShipment() )
	
	lnv_Event.of_SetShipment ( lnv_Shipment )
	//Check requirements, and note any that aren't met as errors.
	//(We'll continue checking even if an early check fails, because we want to give the user
	//all the failure conditions at once.)


	lb_IsThirdParty = lnv_Event.of_IsThirdParty ( )
	IF IsNull ( lb_IsThirdParty ) THEN
		ls_ErrorMessage += "Could not verify 3rd party routing information.~n"
		li_Return = -1
	ELSEIF lb_IsThirdParty = TRUE THEN
		//Can't be non-routed, don't need to check
	ELSE
		lb_IsNonRouted = lnv_Event.of_IsNonRouted ( )
		IF IsNull ( lb_IsNonRouted ) THEN
			ls_ErrorMessage += "Could not verify routed / non-routed status.~n"
			li_Return = -1
		END IF
	END IF

	DESTROY lnv_Shipment 
END IF


IF li_Return = 1 THEN

	lb_HasSite = lnv_Event.of_HasSite ( )
	lb_HasDateArrived = NOT IsNull ( lnv_Event.of_GetDateArrived ( ) )
	lb_HasTimes = NOT ( IsNull ( lnv_Event.of_GetTimeArrived ( ) ) OR IsNull ( lnv_Event.of_GetTimeDeparted ( ) ) )
	ls_Type = lnv_Event.of_GetType ( )

	IF lnv_Event.of_IsLocationOptional() THEN
		//don't require
	ELSE
		IF lb_HasSite = TRUE THEN
			//OK
		ELSE
			ls_ErrorMessage += "The site for this event has not been specified.~n"
			li_Return = -1
		END IF
	END IF

	IF lb_HasTimes = TRUE THEN
		//OK
	ELSEIF lb_IsNonRouted = TRUE THEN
		//If it's non-routed, times aren't required.
	ELSE
		ls_ErrorMessage += "The arrival and/or departure times for this event have not been specified.~n"
		li_Return = -1
	END IF


	IF lb_IsThirdParty = TRUE THEN

		//OK -- being assigned to a trip represents a complete assignment.
		//The other assignment requirements don't apply.

	ELSEIF lb_IsNonRouted = TRUE THEN

		//OK -- The other assignment requirements don't apply.

	ELSEIF lb_HasDateArrived = TRUE THEN

		//The event is routed.  Check the assignments.

		//Get the assignments that are present on the event.

		CHOOSE CASE lnv_Event.of_GetAssignments ( lla_Drivers, lla_PowerUnits, &
			lla_TrailerChassis, lla_Containers )

		CASE 1

			//If Driver is required, check that at least one has been assigned.
	
			CHOOSE CASE This.of_IsRequired ( as_RowConstant, appeon_constant.cs_Driver )
	
			CASE TRUE
	
				IF UpperBound ( lla_Drivers ) = 0 THEN
					ls_ErrorMessage += "The driver has not been specified.~n"
					li_Return = -1
				END IF
	
			CASE FALSE
	
				//OK
	
			CASE ELSE
	
				ls_ErrorMessage += "Could not verify driver assignment requirements.~n"
				li_Return = -1
	
			END CHOOSE
	
	
			//If PowerUnit is required, check that (at least) one has been assigned.
	
			CHOOSE CASE This.of_IsRequired ( as_RowConstant, appeon_constant.cs_Tractor )
	
			CASE TRUE
	
				IF UpperBound ( lla_PowerUnits ) = 0 THEN
					ls_ErrorMessage += "The power unit has not been specified.~n"
					li_Return = -1
				END IF
	
			CASE FALSE
	
				//OK
	
			CASE ELSE
	
				ls_ErrorMessage += "Could not verify power unit assignment requirements.~n"
				li_Return = -1
	
			END CHOOSE
	
	
		//If FreightCarrying equipment is required, check that it has been assigned.
		CHOOSE CASE This.of_IsRequired ( as_RowConstant, appeon_constant.cs_FreightCarrying )
		
			CASE TRUE
				CHOOSE CASE ls_Type
						
				CASE gc_Dispatch.cs_EventType_Deadhead
					
					IF UpperBound ( lla_TrailerChassis ) > 0 OR UpperBound ( lla_Containers ) > 0 THEN
						// OK
					ELSE
						ls_ErrorMessage += "The equipment has not been specified.~n"
						li_Return = -1
					END IF
						
				CASE 	gc_Dispatch.cs_EventType_Hook, &
						gc_Dispatch.cs_EventType_Drop
						IF NOT lnv_Event.of_IsBobtailEvent ( )THEN
							CHOOSE CASE lnv_Event.of_HasActivetrailerchassiscontainer ( NOT This.of_IsRequired ( as_RowConstant, appeon_constant.cs_Chassis )  ) 
							//CHOOSE CASE lnv_Event.of_HasActiveTrailerContainer ( )
								CASE TRUE
									//OK
								CASE FALSE
									ls_ErrorMessage += "The trailer/container has not been specified.~n"
									li_Return = -1	
								CASE ELSE
									ls_ErrorMessage += "Could not verify trailer/container assignment.~n"
									li_Return = -1
							END CHOOSE
						END IF
					
				CASE 	gc_Dispatch.cs_EventType_Mount, &
						gc_Dispatch.cs_EventType_Dismount
						
					CHOOSE CASE lnv_Event.of_HasActiveContainer ( ) 
						CASE TRUE
							//OK
						CASE FALSE
							ls_ErrorMessage += "The container has not been specified.~n"
							li_Return = -1
						CASE ELSE
							ls_ErrorMessage += "Could not verify container assignment.~n"
							li_Return = -1
					END CHOOSE
							
					
				//Perform freight-carrying equipment check, only if the event type warrants it.
				CASE	gc_Dispatch.cs_EventType_Pickup, &
						gc_Dispatch.cs_EventType_Deliver
				
					CHOOSE CASE lnv_Event.of_HasFreightCarryingEquipment ( )
						CASE TRUE
							//OK
						CASE FALSE
							ls_ErrorMessage += "The trailer/container has not been specified.~n"
							li_Return = -1
						CASE ELSE
							ls_ErrorMessage += "Could not verify trailer/container assignment.~n"
							li_Return = -1
					END CHOOSE
					
			END CHOOSE 

		END CHOOSE // of needs freight carrying


			//If Chassis is required (when containers are present), see if there are containers present, 
			//and if so, see if there's a chassis (for now, we're going to do this by just seeing if 
			//there's anything assigned in the TrailerChassis category, but we could do this more 
			//thoroughly, too.
	
			CHOOSE CASE This.of_IsRequired ( as_RowConstant, appeon_constant.cs_Chassis )
	
			CASE TRUE
	
				IF UpperBound ( lla_Containers ) > 0 THEN

					IF UpperBound ( lla_TrailerChassis ) = 0 OR lnv_EquipmentMan.of_isunknownequipment( lla_TrailerChassis ) THEN
						ls_ErrorMessage += "The chassis has not been specified.~n"
						li_Return = -1
					END IF

				END IF
	
			CASE FALSE
	
				//OK
	
			CASE ELSE
	
				ls_ErrorMessage += "Could not verify chassis assignment requirements.~n"
				li_Return = -1
	
			END CHOOSE

		CASE -1

			ls_ErrorMessage += "Could not verify assignment requirements.~n"
			li_Return = -1

		CASE ELSE

			ls_ErrorMessage += "Could not verify assignment requirements -- unexpected return error.~n"
			li_Return = -1

		END CHOOSE

	ELSE
		ls_ErrorMessage += "This event has not been routed.~n"
		li_Return = -1

	END IF

END IF


IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

DESTROY ( lnv_Event )

RETURN li_Return
end function

private function integer of_initializematrixtotrue ();Int i,j

FOR i = 1 TO 3  // loop through the rows	
	FOR j = 1 TO 4   // then the columns
		 iba_Matrix [ i , j ] = TRUE
	NEXT
NEXT

RETURN 1
end function

on n_cst_eventconfirmationoptions.create
call super::create
end on

on n_cst_eventconfirmationoptions.destroy
call super::destroy
end on

event constructor;ids_Source = CREATE DataStore
ids_Source.dataobject = "d_eventconfirmationoptions"

Any		la_String
String	ls_TerminationEvent
String	ls_Event
String	ls_ShipmentAuth
String	lsa_Results[]
int		i
n_cst_Settings	lnv_Settings
n_cst_String 	lnv_string

lnv_Settings.of_GetSetting ( 79 , la_String )
ls_Event = String ( la_String )

lnv_Settings.of_GetSetting ( 80 , la_String )
ls_TerminationEvent = String ( la_String )


lnv_Settings.of_GetSetting ( 81 , la_String )
ls_ShipmentAuth = String ( la_String )

THIS.of_InitializeMatrixToTrue ( ) 

IF Len ( ls_Event ) > 0 THEN
	lnv_String.of_ParseToArray ( ls_Event , "," , lsa_Results )
	FOR i = 1 TO UpperBound ( lsa_Results )
		CHOOSE CASE lsa_Results [ i ]
				
			CASE cs_driver
				iba_Matrix [ ci_roweventconfirmation , ci_columndriver ] = FALSE
				
			CASE cs_tractor
				iba_Matrix [ ci_roweventconfirmation , ci_columntractor ] = FALSE
				
			CASE cs_freightcarrying
				iba_Matrix [ ci_roweventconfirmation , ci_columnfreightcarrying ] = FALSE
				
			CASE cs_chassis	
				iba_Matrix [ ci_roweventconfirmation , ci_columnchassis ] = FALSE
				
		END CHOOSE
		
	NEXT
END IF

IF Len ( ls_TerminationEvent ) > 0 THEN
	lnv_String.of_ParseToArray ( ls_TerminationEvent , "," , lsa_Results )
	FOR i = 1 TO UpperBound ( lsa_Results )
		CHOOSE CASE lsa_Results [ i ]
				
			CASE cs_driver
				iba_Matrix [ ci_rowtemminationevent , ci_columndriver ] = FALSE
				
			CASE cs_tractor
				iba_Matrix [ ci_rowtemminationevent , ci_columntractor ] = FALSE
				
			CASE cs_freightcarrying
				iba_Matrix [ ci_rowtemminationevent , ci_columnfreightcarrying ] = FALSE
				
			CASE cs_chassis	
				iba_Matrix [ ci_rowtemminationevent , ci_columnchassis ] = FALSE
				
		END CHOOSE
		
	NEXT
END IF


IF Len ( ls_ShipmentAuth ) > 0 THEN
	lnv_String.of_ParseToArray ( ls_ShipmentAuth , "," , lsa_Results )
	FOR i = 1 TO UpperBound ( lsa_Results )
		CHOOSE CASE lsa_Results [ i ]
				
			CASE cs_driver
				iba_Matrix [ ci_rowshipmentauthorization , ci_columndriver ] = FALSE
				
			CASE cs_tractor
				iba_Matrix [ ci_rowshipmentauthorization , ci_columntractor ] = FALSE
				
			CASE cs_freightcarrying
				iba_Matrix [ ci_rowshipmentauthorization , ci_columnfreightcarrying ] = FALSE
				
			CASE cs_chassis	
				iba_Matrix [ ci_rowshipmentauthorization , ci_columnchassis ] = FALSE
				
		END CHOOSE
		
	NEXT
END IF

THIS.of_PopulateData ( )
end event

event destructor;DESTROY ids_Source
end event

