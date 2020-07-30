$PBExportHeader$n_cst_dispatchids.sru
forward
global type n_cst_dispatchids from n_cst_base
end type
end forward

global type n_cst_dispatchids from n_cst_base
end type
global n_cst_dispatchids n_cst_dispatchids

type variables
Protected:
Long	ila_Drivers[]
Long	ila_PowerUnits[]
Long	ila_TrailerChassis[]
Long	ila_Containers[]
String	is_Label = "[UNSPECIFIED]"
end variables

forward prototypes
public function long of_adddrivers (long ala_ids[])
public function long of_addpowerunits (long ala_ids[])
public function long of_addtrailerchassis (long ala_ids[])
public function long of_addcontainers (long ala_ids[])
public function integer of_setlabel (string as_label)
public function string of_getlabel ()
public function long of_getdrivers (ref long ala_ids[])
public function long of_getpowerunits (ref long ala_ids[])
public function long of_gettrailerchassis (ref long ala_ids[])
public function long of_getcontainers (ref long ala_ids[])
public function long of_getelementcount ()
public function boolean of_haselements ()
public function integer of_adddriver (long al_id)
public function integer of_addpowerunit (long al_id)
public function integer of_addtrailerchassis (long al_id)
public function integer of_addcontainer (long al_id)
public function integer of_addelement (integer ai_type, long al_id)
public function long of_getdisplaylist (string as_assignmentindicator, string as_multilist, ref string asa_list[])
public function integer of_getdescription (integer ai_type, long al_id, ref string as_description)
public function integer of_getelement (long al_index, ref integer ai_type, ref long al_id)
end prototypes

public function long of_adddrivers (long ala_ids[]);//Adds ids in ala_Ids to ila_Drivers if they are not null and do not match any ids already
//found in ila_Drivers.

//Returns : >= 0 (The number of ids actually added by the operation -- Will be <= the 
//number of ids submitted.)

Long		ll_Index, &
			ll_Count, &
			ll_IdLoop, &
			ll_IdCount
Boolean	lb_Match

Long		ll_Return = 0

ll_Count = UpperBound ( ila_Drivers )
ll_IdCount = UpperBound ( ala_Ids )


//Loop throught the ids submitted and see if we want to add them.

FOR ll_IdLoop = 1 TO ll_IdCount

	//If the id submitted is null, skip it.
	IF IsNull ( ala_Ids [ ll_IdLoop ] ) THEN
		CONTINUE
	END IF


	//Reset the match flag.
	lb_Match = FALSE


	//Loop through the existing id list.  If the id submitted matches any of those in the
	//list, flag it as a match so we can skip it.

	FOR ll_Index = 1 TO ll_Count

		IF ila_Drivers [ ll_Index ] = ala_Ids [ ll_IdLoop ] THEN
			lb_Match = TRUE
			EXIT
		END IF

	NEXT


	//If the id submitted did not match any of those in the list, add it to the list.

	IF lb_Match = FALSE THEN

		ll_Count ++
		ila_Drivers [ ll_Count ] = ala_Ids [ ll_IdLoop ]

		//Incerement the return count of ids actually added to the list.
		ll_Return ++

	END IF

NEXT

RETURN ll_Return
end function

public function long of_addpowerunits (long ala_ids[]);//Adds ids in ala_Ids to ila_PowerUnits if they are not null and do not match any ids already
//found in ila_PowerUnits.

//Returns : >= 0 (The number of ids actually added by the operation -- Will be <= the 
//number of ids submitted.)

Long		ll_Index, &
			ll_Count, &
			ll_IdLoop, &
			ll_IdCount
Boolean	lb_Match

Long		ll_Return = 0

ll_Count = UpperBound ( ila_PowerUnits )
ll_IdCount = UpperBound ( ala_Ids )


//Loop throught the ids submitted and see if we want to add them.

FOR ll_IdLoop = 1 TO ll_IdCount

	//If the id submitted is null, skip it.
	IF IsNull ( ala_Ids [ ll_IdLoop ] ) THEN
		CONTINUE
	END IF


	//Reset the match flag.
	lb_Match = FALSE


	//Loop through the existing id list.  If the id submitted matches any of those in the
	//list, flag it as a match so we can skip it.

	FOR ll_Index = 1 TO ll_Count

		IF ila_PowerUnits [ ll_Index ] = ala_Ids [ ll_IdLoop ] THEN
			lb_Match = TRUE
			EXIT
		END IF

	NEXT


	//If the id submitted did not match any of those in the list, add it to the list.

	IF lb_Match = FALSE THEN

		ll_Count ++
		ila_PowerUnits [ ll_Count ] = ala_Ids [ ll_IdLoop ]

		//Incerement the return count of ids actually added to the list.
		ll_Return ++

	END IF

NEXT

RETURN ll_Return
end function

public function long of_addtrailerchassis (long ala_ids[]);//Adds ids in ala_Ids to ila_TrailerChassis if they are not null and do not match any ids already
//found in ila_TrailerChassis.

//Returns : >= 0 (The number of ids actually added by the operation -- Will be <= the 
//number of ids submitted.)

Long		ll_Index, &
			ll_Count, &
			ll_IdLoop, &
			ll_IdCount
Boolean	lb_Match

Long		ll_Return = 0

ll_Count = UpperBound ( ila_TrailerChassis )
ll_IdCount = UpperBound ( ala_Ids )


//Loop throught the ids submitted and see if we want to add them.

FOR ll_IdLoop = 1 TO ll_IdCount

	//If the id submitted is null, skip it.
	IF IsNull ( ala_Ids [ ll_IdLoop ] ) THEN
		CONTINUE
	END IF


	//Reset the match flag.
	lb_Match = FALSE


	//Loop through the existing id list.  If the id submitted matches any of those in the
	//list, flag it as a match so we can skip it.

	FOR ll_Index = 1 TO ll_Count

		IF ila_TrailerChassis [ ll_Index ] = ala_Ids [ ll_IdLoop ] THEN
			lb_Match = TRUE
			EXIT
		END IF

	NEXT


	//If the id submitted did not match any of those in the list, add it to the list.

	IF lb_Match = FALSE THEN

		ll_Count ++
		ila_TrailerChassis [ ll_Count ] = ala_Ids [ ll_IdLoop ]

		//Incerement the return count of ids actually added to the list.
		ll_Return ++

	END IF

NEXT

RETURN ll_Return
end function

public function long of_addcontainers (long ala_ids[]);//Adds ids in ala_Ids to ila_Containers if they are not null and do not match any ids already
//found in ila_Containers.

//Returns : >= 0 (The number of ids actually added by the operation -- Will be <= the 
//number of ids submitted.)

Long		ll_Index, &
			ll_Count, &
			ll_IdLoop, &
			ll_IdCount
Boolean	lb_Match

Long		ll_Return = 0

ll_Count = UpperBound ( ila_Containers )
ll_IdCount = UpperBound ( ala_Ids )


//Loop throught the ids submitted and see if we want to add them.

FOR ll_IdLoop = 1 TO ll_IdCount

	//If the id submitted is null, skip it.
	IF IsNull ( ala_Ids [ ll_IdLoop ] ) THEN
		CONTINUE
	END IF


	//Reset the match flag.
	lb_Match = FALSE


	//Loop through the existing id list.  If the id submitted matches any of those in the
	//list, flag it as a match so we can skip it.

	FOR ll_Index = 1 TO ll_Count

		IF ila_Containers [ ll_Index ] = ala_Ids [ ll_IdLoop ] THEN
			lb_Match = TRUE
			EXIT
		END IF

	NEXT


	//If the id submitted did not match any of those in the list, add it to the list.

	IF lb_Match = FALSE THEN

		ll_Count ++
		ila_Containers [ ll_Count ] = ala_Ids [ ll_IdLoop ]

		//Incerement the return count of ids actually added to the list.
		ll_Return ++

	END IF

NEXT

RETURN ll_Return
end function

public function integer of_setlabel (string as_label);//Returns : 1, -1 (Currently not implemented)

Integer	li_Return = 1

IF IsNull ( as_Label ) THEN
	as_Label = "[UNSPECIFIED]"
END IF

is_Label = as_Label

RETURN li_Return
end function

public function string of_getlabel ();RETURN is_Label
end function

public function long of_getdrivers (ref long ala_ids[]);//Passes out the Driver list by reference.

//Returns : The number of ids in the array.

ala_Ids = ila_Drivers

RETURN UpperBound ( ala_Ids )
end function

public function long of_getpowerunits (ref long ala_ids[]);//Passes out the PowerUnit list by reference.

//Returns : The number of ids in the array.

ala_Ids = ila_PowerUnits

RETURN UpperBound ( ala_Ids )
end function

public function long of_gettrailerchassis (ref long ala_ids[]);//Passes out the TrailerChassis list by reference.

//Returns : The number of ids in the array.

ala_Ids = ila_TrailerChassis

RETURN UpperBound ( ala_Ids )
end function

public function long of_getcontainers (ref long ala_ids[]);//Passes out the Container list by reference.

//Returns : The number of ids in the array.

ala_Ids = ila_Containers

RETURN UpperBound ( ala_Ids )
end function

public function long of_getelementcount ();//Returns : >= 0

Long	ll_Count

ll_Count = UpperBound ( ila_Drivers ) + UpperBound ( ila_PowerUnits ) +&
	UpperBound ( ila_TrailerChassis ) + UpperBound ( ila_Containers )

RETURN ll_Count

end function

public function boolean of_haselements ();//Returns : TRUE, FALSE

Boolean	lb_Return = FALSE

IF This.of_GetElementCount ( ) > 0 THEN
	lb_Return = TRUE
END IF

RETURN lb_Return
end function

public function integer of_adddriver (long al_id);//Returns : 1 if the driver was added, 0 if the driver was not added because it was null
//or already in the list, -1 if an error occurs or there is an unexpected return value.

Integer	li_Return

CHOOSE CASE This.of_AddDrivers ( { al_Id } )

CASE 1
	//One element was added (ie, the id was added)
	li_Return = 1

CASE 0
	//No elements were added (ie, the id was not added)
	li_Return = 0

CASE ELSE
	//Error, or unexpected return.
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_addpowerunit (long al_id);//Returns : 1 if the PowerUnit was added, 0 if the PowerUnit was not added because it was null
//or already in the list, -1 if an error occurs or there is an unexpected return value.

Integer	li_Return

CHOOSE CASE This.of_AddPowerUnits ( { al_Id } )

CASE 1
	//One element was added (ie, the id was added)
	li_Return = 1

CASE 0
	//No elements were added (ie, the id was not added)
	li_Return = 0

CASE ELSE
	//Error, or unexpected return.
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_addtrailerchassis (long al_id);//Returns : 1 if the TrailerChassis was added, 0 if the TrailerChassis was not added because it was null
//or already in the list, -1 if an error occurs or there is an unexpected return value.

Integer	li_Return

CHOOSE CASE This.of_AddTrailerChassis ( { al_Id } )

CASE 1
	//One element was added (ie, the id was added)
	li_Return = 1

CASE 0
	//No elements were added (ie, the id was not added)
	li_Return = 0

CASE ELSE
	//Error, or unexpected return.
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_addcontainer (long al_id);//Returns : 1 if the Container was added, 0 if the Container was not added because it was null
//or already in the list, -1 if an error occurs or there is an unexpected return value.

Integer	li_Return

CHOOSE CASE This.of_AddContainers ( { al_Id } )

CASE 1
	//One element was added (ie, the id was added)
	li_Return = 1

CASE 0
	//No elements were added (ie, the id was not added)
	li_Return = 0

CASE ELSE
	//Error, or unexpected return.
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_addelement (integer ai_type, long al_id);//Returns : 1 if the element was added, 0 if the element was not added because it was null
//or already in the list, -1 if an error occurs or there is an unexpected return value.

//If ai_Type is null or not recognized and al_Id is null, we will return 0.
//If ai_Type is null or not recognized and al_Id is not null, we will return -1.

Integer	li_Result

Integer	li_Return = 0


CHOOSE CASE ai_Type

CASE gc_Dispatch.ci_ItinType_Driver
	li_Result = This.of_AddDrivers ( { al_Id } )

CASE gc_Dispatch.ci_ItinType_PowerUnit
	li_Result = This.of_AddPowerUnits ( { al_Id } )

CASE gc_Dispatch.ci_ItinType_TrailerChassis
	li_Result = This.of_AddTrailerChassis ( { al_Id } )

CASE gc_Dispatch.ci_ItinType_Container
	li_Result = This.of_AddContainers ( { al_Id } )

CASE ELSE

	IF IsNull ( al_Id ) THEN
		li_Result = 0
	ELSE
		li_Result = -1
	END IF

END CHOOSE



CHOOSE CASE li_Result

CASE 1
	//One element was added (ie, the id was added)
	li_Return = 1

CASE 0
	//No elements were added (ie, the id was not added)
	li_Return = 0

CASE ELSE
	//Error, or unexpected return.
	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function long of_getdisplaylist (string as_assignmentindicator, string as_multilist, ref string asa_list[]);Long		lla_Drivers[], &
			lla_Equipment[], &
			ll_Loop, &
			ll_Count
Integer	li_Index, &
			li_ListCount, &
			li_Type
String	ls_Format, &
			ls_Description, &
			lsa_List[]
n_cst_Events	lnv_Events

			
Boolean	lb_Finished = FALSE
Long		ll_Return = 0


IF lb_Finished = FALSE THEN

	//If as_AssignmentIndicator was specified (even as empty string), we'll precede each
	//description with a formatting tab.  If not, we'll leave the format string as the
	//empty string.

	IF NOT IsNull ( as_AssignmentIndicator ) THEN
		ls_Format = "~t"
	ELSE
		ls_Format = ""
	END IF

END IF


IF lb_Finished = FALSE THEN

	//Add driver descriptions to the list.

	ll_Count = This.of_GetDrivers ( lla_Drivers )

	FOR ll_Loop = 1 TO ll_Count

		This.of_GetDescription ( gc_Dispatch.ci_ItinType_Driver, lla_Drivers [ ll_Loop ], &
			ls_Description )

		//If there is a formatting tab, add it to the front of the description.
		ls_Description = ls_Format + ls_Description

		li_ListCount ++
		lsa_List [ li_ListCount ] = ls_Description

	NEXT


	//Add equipment descriptions to the list.

	FOR li_Index = 1 TO 3

		CHOOSE CASE li_Index

		CASE 1
			li_Type = gc_Dispatch.ci_ItinType_PowerUnit
			ll_Count = This.of_GetPowerUnits ( lla_Equipment )

		CASE 2
			li_Type = gc_Dispatch.ci_ItinType_TrailerChassis
			ll_Count = This.of_GetTrailerChassis ( lla_Equipment )

		CASE 3
			li_Type = gc_Dispatch.ci_ItinType_Container
			ll_Count = This.of_GetContainers ( lla_Equipment )

		END CHOOSE

	
		FOR ll_Loop = 1 TO ll_Count
	
			This.of_GetDescription ( li_Type, lla_Equipment [ ll_Loop ], ls_Description )

			//If there is a formatting tab, add it to the front of the description.
			ls_Description = ls_Format + ls_Description

			IF NOT IsNull ( as_AssignmentIndicator ) THEN

				//If the equipment is a trailer or container being assigned/unassigned, we want to indicate that
				//with the assignment indicator in front of the equipment description.  
	
				CHOOSE CASE li_Type
		
				CASE gc_Dispatch.ci_ItinType_TrailerChassis, gc_Dispatch.ci_ItinType_Container
	
					IF lnv_Events.of_IsInMultiList ( as_MultiList, li_Type, lla_Equipment [ ll_Loop ] ) = TRUE THEN
			
						ls_Description = as_AssignmentIndicator + ls_Description
			
					END IF
	
				END CHOOSE

			END IF
	
			li_ListCount ++
			lsa_List [ li_ListCount ] = ls_Description
	
		NEXT

	NEXT

END IF

asa_List = lsa_List
ll_Return = UpperBound ( asa_List )

RETURN ll_Return
end function

public function integer of_getdescription (integer ai_type, long al_id, ref string as_description);//Returns : 1, -1  (If -1 condition occurs, we still pass out a description, 
//containing an N/A message.)

//Note : If you have equipment and don't know the type, it's ok to pass in 
//null for ai_Type -- we will process that as equipment.

n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_EquipmentManager	lnv_EquipmentManager
String	ls_Description

Integer	li_Return = 1

IF li_Return = 1 THEN

	CHOOSE CASE ai_Type
	
	CASE gc_Dispatch.ci_ItinType_Driver
	
		IF lnv_EmployeeManager.of_DescribeEmployee ( al_Id, ls_Description, &
			appeon_constant.ci_DescribeType_LastFirst ) = 1 THEN
		
			//Success
		
		ELSE
			ls_Description = "DRIVER: [N/A]"
			IF NOT IsNull ( al_Id ) THEN
				ls_Description += "  (ID=" + String ( al_Id ) + ")"
			END IF

			li_Return = -1
		
		END IF
	
	CASE ELSE
	
		IF lnv_EquipmentManager.of_Get_Description ( al_Id, &
			"SHORT_REF!", ls_Description ) = 1 THEN
	
			//Success
	
		ELSE
			ls_Description = "EQUIPMENT: [N/A]"
			IF NOT IsNull ( al_Id ) THEN
				ls_Description += "  (ID=" + String ( al_Id ) + ")"
			END IF

			li_Return = -1
	
		END IF
	
	END CHOOSE

END IF

//Even if we're returning -1, we'll still pass out the description we've assembled, since it
//contains an error description.
as_Description = ls_Description

RETURN li_Return
end function

public function integer of_getelement (long al_index, ref integer ai_type, ref long al_id);//Pick out the nth element in the combined arrays, going in order by Driver, PowerUnit, 
//TrailerChassis, and Containers..

//Returns : 1 if it finds the requested element, -1 if it does not.
//If returning -1, ai_Type and al_Id will be set to null.

Long		ll_TotalCount, &
			ll_RunningCount

Boolean	lb_Finished
Integer	li_Return = 1


IF lb_Finished = FALSE THEN

	IF al_Index > 0 THEN
		//OK
	ELSE
		li_Return = -1
		lb_Finished = TRUE
	END IF

END IF


IF lb_Finished = FALSE THEN

	ll_RunningCount = ll_TotalCount
	ll_TotalCount += UpperBound ( ila_Drivers )
	
	IF ll_TotalCount >= al_Index THEN

		al_Id = ila_Drivers [ al_Index - ll_RunningCount ]
		ai_Type = gc_Dispatch.ci_ItinType_Driver
		lb_Finished = TRUE

	END IF

END IF


IF lb_Finished = FALSE THEN

	ll_RunningCount = ll_TotalCount
	ll_TotalCount += UpperBound ( ila_PowerUnits )
	
	IF ll_TotalCount >= al_Index THEN

		al_Id = ila_PowerUnits [ al_Index - ll_RunningCount ]
		ai_Type = gc_Dispatch.ci_ItinType_PowerUnit
		lb_Finished = TRUE

	END IF

END IF


IF lb_Finished = FALSE THEN

	ll_RunningCount = ll_TotalCount
	ll_TotalCount += UpperBound ( ila_TrailerChassis )
	
	IF ll_TotalCount >= al_Index THEN

		al_Id = ila_TrailerChassis [ al_Index - ll_RunningCount ]
		ai_Type = gc_Dispatch.ci_ItinType_TrailerChassis
		lb_Finished = TRUE

	END IF

END IF


IF lb_Finished = FALSE THEN

	ll_RunningCount = ll_TotalCount
	ll_TotalCount += UpperBound ( ila_Containers )
	
	IF ll_TotalCount >= al_Index THEN

		al_Id = ila_Containers [ al_Index - ll_RunningCount ]
		ai_Type = gc_Dispatch.ci_ItinType_Container
		lb_Finished = TRUE

	ELSE
		li_Return = -1
		lb_Finished = TRUE

	END IF

END IF


//If we didn't find the requested element, null the reference arguments.

IF li_Return = -1 THEN
	SetNull ( ai_Type )
	SetNull ( al_Id )
END IF


RETURN li_Return
end function

on n_cst_dispatchids.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dispatchids.destroy
TriggerEvent( this, "destructor" )
end on

