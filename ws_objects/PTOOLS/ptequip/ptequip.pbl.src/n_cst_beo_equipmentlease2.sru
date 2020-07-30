$PBExportHeader$n_cst_beo_equipmentlease2.sru
forward
global type n_cst_beo_equipmentlease2 from pt_n_cst_beo
end type
end forward

global type n_cst_beo_equipmentlease2 from pt_n_cst_beo
end type
global n_cst_beo_equipmentlease2 n_cst_beo_equipmentlease2

type variables
n_cst_beo_EquipmentLeaseType2 	inv_EquipmentLeaseType
end variables

forward prototypes
public function integer of_setonbehalfof (string as_Value)
public function integer of_setleasetype (long al_value)
public function integer of_setbookingnumber (String as_Value)
public function integer of_setoriginationevent (long al_value)
public function integer of_setterminationevent (long al_Value)
public function integer of_setnotes (string as_Value)
public function integer of_setoe_id (long al_Value)
public function integer of_setfkequipmentleasetype (long al_Value)
public function integer of_settimein (datetime adt_value)
public function integer of_settimeout (datetime adt_value)
public function long of_getoriginationevent ()
public function long of_getterminationevent ()
public function long of_getoriginationsite ()
public function long of_getterminationsite ()
public function date of_getoriginationdate ()
public function date of_getterminationdate ()
public function time of_getoriginationtime ()
public function time of_getterminationtime ()
public function integer of_setoriginationsite (long al_value)
public function integer of_setterminationsite (long al_value)
public function integer of_setoriginationdate (date ad_value)
public function integer of_setterminationdate (date ad_value)
public function integer of_setoriginationtime (time at_value)
public function integer of_setterminationtime (time at_value)
public function integer of_proposeorigination (long al_event, long al_site, date ad_proposeddate, time at_proposedtime, boolean ab_interactive)
public function long of_getid ()
public function integer of_proposetermination (long al_event, long al_site, date ad_proposeddate, time at_proposedtime, boolean ab_interactive)
protected function integer of_autostatus (boolean ab_interactive)
public function integer of_clearorigination ()
public function integer of_cleartermination ()
public function integer of_setshipmentid (long al_Value)
public function integer of_cleartermination (long al_event)
public function integer of_proposeorigination (long al_event, datastore ads_events, boolean ab_interactive)
public function integer of_proposetermination (long al_event, datastore ads_events, boolean ab_interactive)
public function integer of_clearorigination (long al_event)
public function decimal of_getcharges ()
public function n_cst_beo_equipmentleasetype2 of_getequipmentleasetype ()
public function long of_getfkequipmentleasetype ()
public function datetime of_gettimeout ()
public function datetime of_gettimein ()
public function datetime of_getfreetimeexpiration ()
public function String of_getleaseline ()
public function String of_getleasetype ()
public function integer of_setreleasedate (date ad_value)
public function integer of_setreleasetime (time at_value)
public function date of_getreleasedate ()
public function time of_getreleasetime ()
public function integer of_setfreetimeexpirationdate (date ad_Value)
public function integer of_setfreetimeexpirationtime (time at_Value)
public function integer of_calculateftx ()
public function integer of_getfreetimestartsetting ()
public function integer of_getcharges (ref n_cst_leasecharges anv_leasecharges)
protected function integer of_getdaysout ()
end prototypes

public function integer of_setonbehalfof (string as_Value);RETURN THIS.of_SetAny ( "oe_for" , as_Value )
end function

public function integer of_setleasetype (long al_value);RETURN THIS.of_SetAny ( "equipmentlease_fkequipmentleasetype" , al_Value )
end function

public function integer of_setbookingnumber (String as_Value);RETURN THIS.of_SetAny ( "oe_Booknum" , as_Value )
end function

public function integer of_setoriginationevent (long al_value);RETURN THIS.of_SetAny ( "oe_orig_event" , al_value )

end function

public function integer of_setterminationevent (long al_Value);RETURN THIS.of_SetAny ( "oe_Term_event" , al_value )
end function

public function integer of_setnotes (string as_Value);RETURN THIS.of_SetAny ( "notes" , as_Value )
end function

public function integer of_setoe_id (long al_Value);RETURN THIS.of_SetAny  ( "oe_id" , al_Value )
end function

public function integer of_setfkequipmentleasetype (long al_Value);RETURN THIS.of_SetAny ( "equipmentlease_fkequipmentleasetype" , al_Value )
end function

public function integer of_settimein (datetime adt_value);RETURN THIS.of_SetAny ( "oe_in" , adt_Value )
end function

public function integer of_settimeout (datetime adt_value);RETURN THIS.of_SetAny ( "oe_out" , adt_Value )
end function

public function long of_getoriginationevent ();RETURN This.of_GetValue ( "oe_orig_event", TypeLong! )
end function

public function long of_getterminationevent ();RETURN This.of_GetValue ( "oe_term_event", TypeLong! )
end function

public function long of_getoriginationsite ();RETURN This.of_GetValue ( "equipmentlease_originationsite", TypeLong! )
end function

public function long of_getterminationsite ();RETURN This.of_GetValue ( "equipmentlease_terminationsite", TypeLong! )
end function

public function date of_getoriginationdate ();RETURN This.of_GetValue ( "equipmentlease_originationdate", TypeDate! )
end function

public function date of_getterminationdate ();RETURN This.of_GetValue ( "equipmentlease_terminationdate", TypeDate! )
end function

public function time of_getoriginationtime ();RETURN This.of_GetValue ( "equipmentlease_originationtime", TypeTime! )
end function

public function time of_getterminationtime ();RETURN This.of_GetValue ( "equipmentlease_terminationtime", TypeTime! )
end function

public function integer of_setoriginationsite (long al_value);RETURN This.of_SetAny ( "equipmentlease_originationsite" , al_value )
end function

public function integer of_setterminationsite (long al_value);RETURN This.of_SetAny ( "equipmentlease_terminationsite" , al_value )
end function

public function integer of_setoriginationdate (date ad_value);Int	li_Return

li_Return = This.of_SetAny ( "equipmentlease_originationdate" , ad_value )

//n_cst_beo_Equipment2	lnv_Equipment
//lnv_Equipment = CREATE n_cst_beo_Equipment2
//
//IF li_Return = 1 THEN
//	lnv_Equipment.of_SetSource ( THIS.of_GetSource ( ))	//
//	lnv_Equipment.of_SetSourceID ( THIS.of_GetID ( ) ) 	//
//	lnv_Equipment.of_SetAllowFilterSet ( TRUE  )				//		All Added
//	lnv_Equipment.of_CalculateLeaseFreeTimeExpiration ( ) //   <<*>> 2.19.03  Ver 3.6
//END IF
//
//DESTROY ( lnv_Equipment )

RETURN li_Return
end function

public function integer of_setterminationdate (date ad_value);RETURN This.of_SetAny ( "equipmentlease_terminationdate" , ad_value )
end function

public function integer of_setoriginationtime (time at_value);Int	li_Return

li_Return = This.of_SetAny ( "equipmentlease_originationtime" , at_value )

//n_cst_beo_Equipment2	lnv_Equipment
//lnv_Equipment = CREATE n_cst_beo_Equipment2
//

//IF li_Return = 1 THEN
//	lnv_Equipment.of_SetSource ( THIS.of_GetSource ( ))	//
//	lnv_Equipment.of_SetSourceID ( THIS.of_GetID ( ) ) 	//
//	lnv_Equipment.of_SetAllowFilterSet ( TRUE  )				//		All Added
//	lnv_Equipment.of_CalculateLeaseFreeTimeExpiration ( ) //   <<*>> 2.19.03  Ver 3.6
//END IF
//
//DESTROY ( lnv_Equipment )

RETURN li_Return
end function

public function integer of_setterminationtime (time at_value);RETURN This.of_SetAny ( "equipmentlease_terminationtime" , at_value )
end function

public function integer of_proposeorigination (long al_event, long al_site, date ad_proposeddate, time at_proposedtime, boolean ab_interactive);//This function is to be used for proposing an origination event/site/date/time, 
//based on event information.  

//ad_ProposedDate is required in order for the proposed origination to be considered.

//Returns : 1, 0 (Proposed origination not used, or user cancelled), -1 (Error)


Long	ll_ExistingEvent, &
		ll_ExistingSite
Date	ld_ExistingDate
Time	lt_ExistingTime

String	ls_MessageHeader = "Origination Event", &
			ls_Message, &
			ls_Work
Boolean	lb_ProposedIsLater, &
			lb_AskUser


Integer	li_Return = 1

n_cst_beo_Equipment2	lnv_Equipment
n_cst_beo_EquipmentLease2	lnv_EquipmentLease


lnv_Equipment = CREATE n_cst_beo_Equipment2


IF li_Return = 1 THEN

	IF IsNull ( ad_ProposedDate ) THEN
		//Can't propose a null origination date.
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	ll_ExistingEvent = This.of_GetOriginationEvent ( )
	ll_ExistingSite = This.of_GetOriginationSite ( )
	ld_ExistingDate = This.of_GetOriginationDate ( )
	lt_ExistingTime = This.of_GetOriginationTime ( )

	IF NOT IsNull ( ld_ExistingDate ) THEN

		IF ( DaysAfter ( ld_ExistingDate, ad_ProposedDate ) < 0 ) OR &
			( DaysAfter ( ld_ExistingDate, ad_ProposedDate ) = 0 AND &
			at_ProposedTime < lt_ExistingTime ) THEN

			IF IsNull ( ll_ExistingEvent ) THEN

				//A manual origination was set.  Handle according to whether we're in 
				//interactive mode or not.

				IF ab_Interactive THEN

					//We are in interactive mode.  See if the user wants to override the manual origination.

					lb_AskUser = TRUE

				ELSE

					//Can't ask user, so assume "No" -- Don't override the manual value.
					li_Return = 0

				END IF

			ELSE

				//The origination had been set automatically.  Use this new value instead.

			END IF

		ELSE

			//The proposed value is later than the one already specified.  

			//Flag for later reference.
			lb_ProposedIsLater = TRUE

			//Handle according to whether we're in interactive mode or not.

			IF ab_Interactive THEN

				lb_AskUser = TRUE

			ELSE

				//Can't ask user.  We'll keep the earlier date.  Don't change anything.
				li_Return = 0

			END IF

		END IF

	ELSE

		//No existing origination date specified.
		//Use the proposed value.

	END IF

END IF

lnv_Equipment.of_SetSource ( This.of_GetSource ( ) )
lnv_Equipment.of_SetSourceId ( This.of_GetId ( ) )
	
IF li_Return = 1 AND lb_AskUser = TRUE THEN

	//Note : Get some more context info here, so the message is more informative.

	ls_MessageHeader = "Origination Override"

	ls_Work = Trim ( lnv_Equipment.of_GetNumber ( ) )

	IF Len ( ls_Work ) > 0 THEN
		ls_MessageHeader += " -- " + ls_Work
	END IF

	ls_Message = "An origination of " + String ( ld_ExistingDate, "m/d/yy" )

	IF NOT IsNull ( lt_ExistingTime ) THEN
		ls_Message += " at " + String ( lt_ExistingTime, "hh:mm" )
	END IF

	IF IsNull ( ll_ExistingEvent ) THEN
		ls_Message += " has already been set manually.~n~n"
	ELSE
		ls_Message += " has already been recorded.~n~n"
	END IF

	IF lb_ProposedIsLater THEN
		ls_Message += "Do you want to use the LATER value "
	ELSE
		ls_Message += "Do you want to use the EARLIER value "
	END IF

	ls_Message += String ( ad_ProposedDate, "m/d/yy" )

	IF NOT IsNull ( at_ProposedTime ) THEN
		ls_Message += " at " + String ( at_ProposedTime, "hh:mm" )
	END IF

	ls_Message += " instead?"

	IF MessageBox ( ls_MessageHeader, ls_Message, Question!, YesNo!, 2 ) = 2 THEN

		//User chose "No"
		li_Return = 0

	END IF

END IF


IF li_Return = 1 THEN
	
	n_cst_EquipmentManager	lnv_Manager
	
	This.of_SetOriginationSite ( al_Site )
	This.of_SetOriginationEvent ( al_Event )
 	This.of_SetOriginationDate ( ad_ProposedDate ) 
	This.of_SetOriginationTime ( at_ProposedTime )	

	//If appropriate, modify the equipment's status based on these changes.
	This.of_AutoStatus ( ab_Interactive )
	
	lnv_Manager.of_Sync ( THIS.of_GetSource ( ) , FALSE , FALSE ) 	//
	lnv_Equipment.of_GetEquipmentLease ( lnv_EquipmentLease )   	//
	IF isValid ( lnv_EquipmentLease )THEN									//
		lnv_EquipmentLease.of_CalculateFTX ( )         					//   <<*>> 2.19.03  Ver 3.6
	END IF


END IF

DESTROY ( lnv_Equipment )
DESTROY ( lnv_EquipmentLease )

RETURN li_Return
end function

public function long of_getid ();RETURN This.of_GetValue ( "oe_id", TypeLong! )
end function

public function integer of_proposetermination (long al_event, long al_site, date ad_proposeddate, time at_proposedtime, boolean ab_interactive);//This function is to be used for proposing an termination event/site/date/time, 
//based on event information.  

//ad_ProposedDate is required in order for the proposed termination to be considered.

//Returns : 1, 0 (Proposed termination not used, or user cancelled), -1 (Error)


Long	ll_ExistingEvent, &
		ll_ExistingSite
Date	ld_ExistingDate
Time	lt_ExistingTime
n_cst_beo_Equipment2	lnv_Equipment

String	ls_MessageHeader = "Termination Event", &
			ls_Message, &
			ls_Work
Boolean	lb_ProposedIsEarlier, &
			lb_AskUser


Integer	li_Return = 1

lnv_Equipment = CREATE n_cst_beo_Equipment2

IF li_Return = 1 THEN

	IF IsNull ( ad_ProposedDate ) THEN
		//Can't propose a null termination date.
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	ll_ExistingEvent = This.of_GetTerminationEvent ( )
	ll_ExistingSite = This.of_GetTerminationSite ( )
	ld_ExistingDate = This.of_GetTerminationDate ( )
	lt_ExistingTime = This.of_GetTerminationTime ( )

	IF NOT IsNull ( ld_ExistingDate ) THEN

		IF ( DaysAfter ( ld_ExistingDate, ad_ProposedDate ) > 0 ) OR &
			( DaysAfter ( ld_ExistingDate, ad_ProposedDate ) = 0 AND &
			at_ProposedTime > lt_ExistingTime ) THEN

			IF IsNull ( ll_ExistingEvent ) THEN

				//A manual termination was set.  Handle according to whether we're in 
				//interactive mode or not.

				IF ab_Interactive THEN

					//We are in interactive mode.  See if the user wants to override the manual termination.

					lb_AskUser = TRUE

				ELSE

					//Can't ask user, so assume "No" -- Don't override the manual value.
					li_Return = 0

				END IF

			ELSE

				//The termination had been set automatically.  Use this new value instead.

			END IF

		ELSE

			//The proposed value is earlier than the one already specified.

			//Flag for later reference.
			lb_ProposedIsEarlier = TRUE
  
			//Handle according to whether we're in interactive mode or not.

			IF ab_Interactive THEN

				lb_AskUser = TRUE

			ELSE

				//Can't ask user.  We'll keep the later date.  Don't change anything.
				li_Return = 0

			END IF

		END IF

	ELSE

		//No existing termination date specified.
		//Use the proposed value.

	END IF

END IF


IF li_Return = 1 AND lb_AskUser = TRUE THEN

	//Note : Get some more context info here, so the message is more informative.

	lnv_Equipment.of_SetSource ( This.of_GetSource ( ) )
	lnv_Equipment.of_SetSourceId ( This.of_GetId ( ) )

	ls_MessageHeader = "Termination Override"

	ls_Work = Trim ( lnv_Equipment.of_GetNumber ( ) )

	IF Len ( ls_Work ) > 0 THEN
		ls_MessageHeader += " -- " + ls_Work
	END IF

	ls_Message = "A termination of " + String ( ld_ExistingDate, "m/d/yy" )

	IF NOT IsNull ( lt_ExistingTime ) THEN
		ls_Message += " at " + String ( lt_ExistingTime, "hh:mm" )
	END IF

	IF IsNull ( ll_ExistingEvent ) THEN
		ls_Message += " has already been set manually.~n~n"
	ELSE
		ls_Message += " has already been recorded.~n~n"
	END IF

	IF lb_ProposedIsEarlier THEN
		ls_Message += "Do you want to use the EARLIER value "
	ELSE
		ls_Message += "Do you want to use the LATER value "
	END IF

	ls_Message += String ( ad_ProposedDate, "m/d/yy" )

	IF NOT IsNull ( at_ProposedTime ) THEN
		ls_Message += " at " + String ( at_ProposedTime, "hh:mm" )
	END IF

	ls_Message += " instead?"

	IF MessageBox ( ls_MessageHeader, ls_Message, Question!, YesNo!, 2 ) = 2 THEN

		//User chose "No"
		li_Return = 0

	END IF

END IF


IF li_Return = 1 THEN

	This.of_SetTerminationSite ( al_Site )
	This.of_SetTerminationEvent ( al_Event )
	This.of_SetTerminationDate ( ad_ProposedDate )
	This.of_SetTerminationTime ( at_ProposedTime )

	//If appropriate, modify the equipment's status based on these changes.
	This.of_AutoStatus ( ab_Interactive )

END IF

DESTROY ( lnv_Equipment )

RETURN li_Return
end function

protected function integer of_autostatus (boolean ab_interactive);//Evaluates the origination and termination situation, and changes equipment status
//if appropriate.  If both origination and termination are specified and the status
//is active, the equipment will be deactivated.  If either origination, termination,
//or both are not specified and the equipment is deactivated, it will be reactivated.
//This does not apply to equipment with an "X" status, which means deleted / non-existent.

//Returns : 1 = Status got changed, 0 = No status change was needed, -1 = Error

Date		ld_Origination, &
			ld_Termination

String	ls_Status

Boolean  lb_Deactivate // this is set by the system setting, default is true
Any		la_Value

n_cst_beo_Equipment2	lnv_Equipment
n_cst_Settings	lnv_Settings


Integer	li_Return = 0

lnv_Equipment = CREATE n_cst_beo_Equipment2

// check to see if the system setting is set to not deactivate
lb_Deactivate = TRUE
IF lnv_Settings.of_GetSetting ( 91 , la_Value ) > 0 THEN
	IF String ( la_Value ) = "NO!" THEN
		lb_Deactivate = FALSE
	END IF
END IF


IF li_Return = 0 THEN

	lnv_Equipment.of_SetSource ( This.of_GetSource ( ) )
	lnv_Equipment.of_SetSourceId ( This.of_GetId ( ) )

	IF lnv_Equipment.of_HasSource ( ) = FALSE THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 0 THEN

	ls_Status = lnv_Equipment.of_GetStatus ( )
	ld_Origination = This.of_GetOriginationDate ( )
	ld_Termination = This.of_GetTerminationDate ( )

	IF IsNull ( ld_Origination ) OR IsNull ( ld_Termination ) THEN

		IF ls_Status = "D" THEN  					//D = Deactivated
			lnv_Equipment.of_SetStatus ( "K" )  //K = Active.
			li_Return = 1
		END IF

	ELSE

		IF ls_Status = "K" AND lb_Deactivate THEN	//K = Active
			lnv_Equipment.of_SetStatus ( "D" )	   //D = Deactivated
			li_Return = 1
		END IF

	END IF

END IF

DESTROY ( lnv_Equipment )

RETURN li_Return
end function

public function integer of_clearorigination ();//Clear the origination event, date, and time (if any).

//Returns : 1, -1 (Not currently implemented).

Long		ll_Null
Date		ld_Null
Time		lt_Null

SetNull ( ll_Null )
SetNull ( ld_Null )
SetNull ( lt_Null )

Integer	li_Return = 1

IF li_Return = 1 THEN

	This.of_SetOriginationEvent ( ll_Null )
	This.of_SetOriginationDate ( ld_Null )
	This.of_SetOriginationTime ( lt_Null )
	
	//   <<*>> 2.19.03  Ver 3.6
	If THIS.of_GetFreeTimeStartSetting ( ) = 2 then  // 2 = outgate 
		THIS.of_SetFreeTimeExpirationDate ( ld_Null ) 
		THIS.of_SetFreeTimeExpirationTime ( lt_Null ) 
	END IF
	//   <<*>> END 
	
	//If appropriate, modify the equipment's status based on these changes.
	This.of_AutoStatus ( FALSE /*Non-Interactive*/ )

END IF

RETURN li_Return
end function

public function integer of_cleartermination ();//Clear the termination event, date, and time (if any).

//Returns : 1, -1 (Not currently implemented).

Long		ll_Null
Date		ld_Null
Time		lt_Null

SetNull ( ll_Null )
SetNull ( ld_Null )
SetNull ( lt_Null )

Integer	li_Return = 1

IF li_Return = 1 THEN

	This.of_SetTerminationEvent ( ll_Null )
	This.of_SetTerminationDate ( ld_Null )
	This.of_SetTerminationTime ( lt_Null )

	//If appropriate, modify the equipment's status based on these changes.
	This.of_AutoStatus ( FALSE /*Non-Interactive*/ )

END IF


RETURN li_Return
end function

public function integer of_setshipmentid (long al_Value);RETURN This.of_SetAny ( "equipmentlease_Shipment" , al_Value )
end function

public function integer of_cleartermination (long al_event);//Clears the termination, if the termination event is the event passed in.

//Returns : 1 = Termination Cleared, 0 = No attempt made (termination event is not the 
//event passed in), -1 = Error

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF This.of_GetTerminationEvent ( ) = al_Event THEN
		//The current termination event is the event passed in.
		//We'll try to clear it.
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE This.of_ClearTermination ( )

	CASE 1
		//Termination cleared successfully.

	CASE -1
		//Error
		li_Return = -1

	CASE ELSE
		//Unexpected return
		li_Return = -1

	END CHOOSE

END IF


RETURN li_Return
end function

public function integer of_proposeorigination (long al_event, datastore ads_events, boolean ab_interactive);//Arguments are the event id being proposed as the origination, and the datastore
//containing the event.

//Returns : 1, 0 (Proposed origination not used, or user cancelled), -1 (Error)

Long	ll_SiteId
Date	ld_ProposedDate
Time	lt_ProposedTime
Integer	li_Null

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

SetNull ( li_Null )

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF IsNull ( al_Event ) THEN
		li_Return = -1
	ELSEIF NOT IsValid ( ads_Events ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( ads_Events )
	lnv_Event.of_SetSourceId ( al_Event )

	IF lnv_Event.of_HasSource ( ) = FALSE THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsConfirmed ( ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsAssociation ( ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsInterchangeCapable ( ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	//Null can be used in the following call when equipment type is not known.

	IF lnv_Event.of_IsActiveInAssignment ( li_Null, This.of_GetId ( ) ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	ll_SiteId = lnv_Event.of_GetSite ( )
	ld_ProposedDate = lnv_Event.of_GetDateArrived ( )
	lt_ProposedTime = lnv_Event.of_GetTimeArrived ( )

	CHOOSE CASE This.of_ProposeOrigination ( al_Event, ll_SiteId, ld_ProposedDate, &
		lt_ProposedTime, ab_Interactive )

	CASE 1
		//Origination set

	CASE 0
		//Proposed origination not used
		li_Return = 0

	CASE -1
		//Error
		li_Return = -1

	CASE ELSE
		//Unexpected return
		li_Return = -1

	END CHOOSE

END IF

DESTROY ( lnv_Event )

RETURN li_Return
end function

public function integer of_proposetermination (long al_event, datastore ads_events, boolean ab_interactive);//Arguments are the event id being proposed as the termination, and the datastore
//containing the event.

//Returns : 1, 0 (Proposed termination not used, or user cancelled), -1 (Error)

Long	ll_SiteId
Date	ld_ProposedDate
Time	lt_ProposedTime
Integer	li_Null

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event

SetNull ( li_Null )

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF IsNull ( al_Event ) THEN
		li_Return = -1
	ELSEIF NOT IsValid ( ads_Events ) THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	lnv_Event.of_SetSource ( ads_Events )
	lnv_Event.of_SetSourceId ( al_Event )

	IF lnv_Event.of_HasSource ( ) = FALSE THEN
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsConfirmed ( ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	//Null can be used in the following call when equipment type is not known.

	IF lnv_Event.of_IsActiveInAssignment ( li_Null, This.of_GetId ( ) ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF lnv_Event.of_IsTermination ( ) THEN
		//OK
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	ll_SiteId = lnv_Event.of_GetSite ( )
	ld_ProposedDate = lnv_Event.of_GetDateArrived ( )
	lt_ProposedTime = lnv_Event.of_GetTimeArrived ( )

	CHOOSE CASE This.of_ProposeTermination ( al_Event, ll_SiteId, ld_ProposedDate, &
		lt_ProposedTime, ab_Interactive )

	CASE 1
		//Termination set

	CASE 0
		//Proposed termination not used
		li_Return = 0

	CASE -1
		//Error
		li_Return = -1

	CASE ELSE
		//Unexpected return
		li_Return = -1

	END CHOOSE

END IF

DESTROY (lnv_Event)


RETURN li_Return
end function

public function integer of_clearorigination (long al_event);//Clears the origination, if the origination event is the event passed in.

//Returns : 1 = Origination Cleared, 0 = No attempt made (origination event is not the 
//event passed in), -1 = Error

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF This.of_GetOriginationEvent ( ) = al_Event THEN
		//The current origination event is the event passed in.
		//We'll try to clear it.
	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	CHOOSE CASE This.of_ClearOrigination ( )

	CASE 1
		//Origination cleared successfully.

	CASE -1
		//Error
		li_Return = -1

	CASE ELSE
		//Unexpected return
		li_Return = -1

	END CHOOSE

END IF


RETURN li_Return
end function

public function decimal of_getcharges ();
DateTime	ldt_Out, &
			ldt_In
Decimal	lc_Charges
n_cst_beo_EquipmentLeaseType2	lnv_LeaseType


lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

IF IsValid ( lnv_LeaseType ) THEN

	ldt_Out = This.of_GetTimeOut ( )
	ldt_In = This.of_GetTimeIn ( )

	lnv_LeaseType.of_GetCharges ( Date ( ldt_Out ), Time ( ldt_Out ), &
		Date ( ldt_In ), Time ( ldt_In ), lc_Charges )

ELSE
	SetNull ( lc_Charges )

END IF

RETURN lc_Charges
end function

public function n_cst_beo_equipmentleasetype2 of_getequipmentleasetype ();
//Override to get beo from global cache, instead of retrieving it.  NOTE: This does not force retrieval of
//a new beo that was not originally retrieved in the cache.

n_cst_bcm	lnv_Cache
n_cst_beo_EquipmentLeaseType2	lnv_Beo
Long			ll_fkLeaseType


IF IsValid ( inv_EquipmentLeaseType ) THEN

	lnv_Beo = inv_EquipmentLeaseType

ELSE
	
	lnv_Beo = CREATE n_cst_beo_EquipmentLeaseType2
	ll_fkLeaseType = This.of_GetfkEquipmentLeaseType ( )
	
	//lnv_Beo.of_GetRivertonBeo ( ll_fkLeaseType ) // this sets an instance of riverton on the 										
																	// pt_beo
	IF NOT IsNull ( ll_fkLeaseType ) THEN
		lnv_Beo.of_GetRivertonBeo ( ll_fkLeaseType ) 
		inv_EquipmentLeaseType = lnv_Beo
	END IF
END IF

RETURN lnv_Beo
end function

public function long of_getfkequipmentleasetype ();RETURN THIS.of_GetValue ( "equipmentlease_fkequipmentleasetype", TypeLong! )
end function

public function datetime of_gettimeout ();/* 
	RDT 12-05-02 Changed to account for Notify and Outgate values. 
	If FreetimeStart = 1 (Notify) use the notify ( aka release ) date and time date from disp_ship
	If FreeTimeStart = 2 (OutGate) use the origination date and time date
	NOTE: Same logic exists in n_cst_beo_EquipmentLease which is what the current menu of the shipment is calls

*/ 

Date		ld_Origination 
Time		lt_Origination 
dateTime	ldt_TimeOut
Long		ll_EquipID

SetNull ( ld_Origination )
SetNull ( lt_Origination )
SetNull ( ldt_TimeOut )

n_cst_EquipmentManager	lnv_EquipmentManager
// RDT 12-05-02 new code - Start 

Long	ll_ID

ll_ID = THIS.of_GetFKEquipmentLeaseType ( )


If THIS.of_GetFreeTimeStartSetting ( ) = lnv_EquipmentManager.ci_FreeTimeStart_Notify then 
	ll_EquipID = THIS.of_GetValue ("eq_id", TypeLong! )
		
	ld_Origination = THIS.of_GetReleaseDate ( ) 
	lt_Origination = THIS.of_GetReleaseTime ( )
	
	If NOT IsNull( ld_Origination ) Then 
		
		if IsNull ( lt_Origination ) then
			lt_Origination = 00:00:00
		end if
		
		ldt_TimeOut = DateTime ( ld_Origination, lt_Origination )
		
	End If

Else  // Free time starts at outgate

	ld_Origination = THIS.of_GetValue ( "EquipmentLease_OriginationDate" , TypeDate! )
	
	IF NOT IsNull ( ld_Origination ) THEN
		lt_Origination = THIS.of_GetValue ( "EquipmentLease_OriginationTime" , TypeTime! )
		
		IF IsNull ( lt_Origination ) THEN
			lt_Origination = 00:00:00
		END IF
	
		ldt_TimeOut = DateTime ( ld_Origination, lt_Origination )
		
	END IF
End If
// RDT 12-05-02 new code - End 


// RDT 12-05-02 commented - start 
//ld_Origination = THIS.of_GetValue ( "EquipmentLease_OriginationDate" , TypeDate! )
//
//IF NOT IsNull ( ld_Origination ) THEN
//	lt_Origination = THIS.of_GetValue ( "EquipmentLease_OriginationTime" , TypeTime! )
//	//New in 3.5.0 : If the OriginationTime is null, use midnight (that morning.)
//	//(We used to give a null back if there was no time specified on the event.)
//
//	IF IsNull ( lt_Origination ) THEN
//		lt_Origination = 00:00:00
//	END IF
//
//	ldt_TimeOut = DateTime ( ld_Origination, lt_Origination )
//	
//END IF
// RDT 12-05-02 commented - end

RETURN ldt_TimeOut
end function

public function datetime of_gettimein ();Date		ld_Termination 
Time		lt_Termination 
dateTime	ldt_TimeIn

SetNull ( ld_Termination )
SetNull ( lt_Termination )
SetNull ( ldt_TimeIn )

ld_Termination = THIS.of_GetValue ( "EquipmentLease_TerminationDate" , TypeDate! )

IF NOT IsNull ( ld_Termination ) THEN
	lt_Termination = THIS.of_GetValue ( "EquipmentLease_TerminationTime" , TypeTime! )
	//New in 3.5.0 : If the OriginationTime is null, use midnight (that morning.)
	//(We used to give a null back if there was no time specified on the event.)

	IF IsNull ( lt_Termination ) THEN
		lt_Termination = 00:00:00
	END IF

	ldt_TimeIn = DateTime ( ld_Termination, lt_Termination )
	
END IF

RETURN ldt_TimeIn
end function

public function datetime of_getfreetimeexpiration ();
DateTime ldt_Expiration
DateTime ldt_OutDateTime
Date     ld_ExpirationDate
Time 	 lt_ExpirationTime
n_cst_beo_EquipmentLeaseType2	lnv_LeaseType


lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

SetNull ( ldt_Expiration )
SetNull ( ld_ExpirationDate )
SetNull ( lt_ExpirationTime )

IF IsValid ( lnv_LeaseType ) THEN

	ldt_OutDateTime = This.of_GetTimeOut ( )
	IF Not isNull ( ldt_OutDateTime ) THEN
		lnv_LeaseType.of_GetFreeTimeExpiration ( Date (ldt_OutDateTime ), Time ( ldt_OutDateTime ) , & 
										ld_ExpirationDate ,	lt_ExpirationTime ) 								
		ldt_Expiration = DateTime(ld_ExpirationDate , lt_ExpirationTime )
	END IF
END IF

RETURN ldt_Expiration

end function

public function String of_getleaseline ();String	ls_return

n_cst_beo_EquipmentLeaseType2	lnv_LeaseType

lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

IF IsValid ( lnv_LeaseType ) THEN
	ls_Return = lnv_LeaseType.of_GetLine ( )
ELSE
	SetNull ( ls_Return )

END IF

RETURN ls_Return
end function

public function String of_getleasetype ();String	ls_return

n_cst_beo_EquipmentLeaseType2	lnv_LeaseType

lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

IF IsValid ( lnv_LeaseType ) THEN
	ls_Return = lnv_LeaseType.of_Gettype ( )
ELSE
	SetNull ( ls_Return )
END IF

RETURN ls_Return
end function

public function integer of_setreleasedate (date ad_value);Int	li_Return

li_Return = THIS.of_SetAny ( "releasedate" , ad_Value )

IF li_Return = 1 THEN
	THIS.of_CalculateFTX ( )	
END IF

RETURN li_Return


end function

public function integer of_setreleasetime (time at_value);Int	li_Return

li_Return = THIS.of_SetAny ( "releasetime" , at_Value )

IF li_Return = 1 THEN
	THIS.of_CalculateFTX ( )	
END IF

RETURN li_Return


end function

public function date of_getreleasedate ();RETURN THIS.of_GetValue ( "releasedate" , TypeDate! )
end function

public function time of_getreleasetime ();RETURN THIS.of_GetValue ( "releasetime" , Typetime! )
end function

public function integer of_setfreetimeexpirationdate (date ad_Value);RETURN THIS.of_SetAny ( "leasefreetimeexpiredate" , ad_Value )
end function

public function integer of_setfreetimeexpirationtime (time at_Value);RETURN THIS.of_SetAny ( "leasefreetimeexpiretime" , at_Value )
end function

public function integer of_calculateftx ();Int			li_Return = -1
DateTime 	ldtm_expire
Date			ld_Date
Time			lt_Time
	
ldtm_Expire = THIS.of_getfreetimeexpiration ( )

ld_Date = Date ( ldtm_Expire ) 
IF isNull ( ld_Date ) THEN
	SetNull ( lt_Time )
ELSE
	lt_Time = Time ( ldtm_Expire )
END IF

IF THIS.of_SetFreeTimeExpirationDate ( ld_Date ) = 1 AND & 
	THIS.of_SetFreeTimeExpirationTime ( lt_Time ) = 1        THEN
	li_Return = 1 
END IF 

RETURN li_Return

end function

public function integer of_getfreetimestartsetting ();Int	li_Return  
Long	ll_ID
Int	li_FreeTimeStart
String	ls_Test

n_cst_EquipmentManager lnv_Manager

li_Return = lnv_Manager.ci_FreeTimeStart_Outgate

IF THIS.of_GetValue ( "equipmentleasetype_freetimestart" , TypeLong! ) = 1 THEN
	li_Return = lnv_Manager.ci_FreeTimeStart_Notify 
END IF


ls_Test =  THIS.of_GetLeaseType ( )// ( "equipmentleasetype_line" , TypeString! )
//
//Messagebox ( "Test" , ls_Test + String ( li_Return ) )
//
//ll_ID = THIS.of_GetFkEquipmentLeaseType ()
//SELECT "equipmentleasetype"."freetimestart"  
// INTO :li_FreeTimeStart  
//  FROM "equipmentleasetype"
//  WHERE "equipmentleasetype"."id" = :ll_ID  ;
//Commit;
//li_Return = li_FreeTimeStart
RETURN li_Return




end function

public function integer of_getcharges (ref n_cst_leasecharges anv_leasecharges);DateTime	ldt_Out, &
			ldt_In
Int		li_Return = 1

n_cst_beo_EquipmentLeaseType2	lnv_LeaseType

lnv_LeaseType = This.of_GetEquipmentLeaseType ( )

IF IsValid ( lnv_LeaseType ) THEN

	ldt_Out = This.of_GetTimeOut ( )
	ldt_In = This.of_GetTimeIn ( )

	lnv_LeaseType.of_GetCharges ( Date ( ldt_Out ), Time ( ldt_Out ), Date ( ldt_In ), Time ( ldt_In ), anv_leasecharges )
	
ELSE
	li_Return = -1

END IF

RETURN li_Return
end function

protected function integer of_getdaysout ();Datetime ldtm_Out
DateTime	ldtm_In
Int		li_DaysOut

ldtm_Out = THIS.of_GetTimeout( )
ldtm_In = THIS.of_GetTimein( )

IF IsNull ( ldtm_In ) THEN
	
	ldtm_In = DateTime ( Today ( ) , Now ( )  )
	
END IF

li_DaysOut = DaysAfter ( Date ( ldtm_Out ) , Date ( ldtm_in ) )

RETURN li_DaysOut
end function

on n_cst_beo_equipmentlease2.create
call super::create
end on

on n_cst_beo_equipmentlease2.destroy
call super::destroy
end on

event constructor;call super::constructor;of_setKeyColumn ( "oe_id" )
end event

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "PERDIEM"
			aa_Value = THIS.of_GetCharges ( )
			
		CASE "FTE" , "FREETIMEEXPIRATION"
			aa_Value = THIS.of_GetFreeTimeExpiration ( )	
			
		CASE "TYPE"
			aa_Value = THIS.of_GetLeaseType ( )
			
		CASE "LINE"
			aa_Value = THIS.of_GetLeaseLine ( )
		
		CASE "ORIGINATIONDATE" , "ORIGDATE"
			aa_Value = THIS.of_GetOriginationDate ( )		
			
		CASE "ORIGINATIONDTIME" , "ORIGTIME" , "ORIGINATIONTIME"
			aa_Value = THIS.of_GetOriginationTime ( )		
			
		CASE "TERMINATIONDATE" , "TERMDATE"
			aa_Value = THIS.of_GetTerminationdate( )
			
		CASE "TERMINATIONTIME" , "TERMTIME"
			aa_Value = THIS.of_GetTerminationTime( )
		
		CASE "TIMEOUT"
			aa_value = THIS.of_GetTimeOut ( )
			
		CASE "DAYSOUT"
			aa_value = THIS.of_Getdaysout( )
		
		CASE ELSE
			
			li_Return = 0
	END CHOOSE

END IF

RETURN li_Return
end event

event destructor;DESTROY ( inv_equipmentleasetype )
end event

event ue_getobject;call super::ue_getobject;//Extending Ancestor to provide object support for this class.

//See ancestor script for explanation of return codes.

Integer	li_Return
Long		ll_Count, &
			ll_Index
Any		laa_Beo[]

n_cst_beo_EquipmentLeaseType2	lnv_LeaseType

li_Return = AncestorReturnValue
aaa_Beo = laa_Beo


IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_ObjectName ) )

	CASE "LEASETYPE" 
		
		lnv_LeaseType = THIS.of_getEquipmentleasetype( )
		
		IF Isvalid ( lnv_LeaseType ) THEN
			aaa_Beo [ 1 ] = lnv_LeaseType
		ELSE
			li_Return = 0
		END IF
		
	CASE ELSE
		li_Return = 0
			
	END CHOOSE

END IF

RETURN li_Return
end event

