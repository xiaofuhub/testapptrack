$PBExportHeader$n_cst_bso_validation.sru
forward
global type n_cst_bso_validation from n_cst_bso
end type
end forward

global type n_cst_bso_validation from n_cst_bso
end type
global n_cst_bso_validation n_cst_bso_validation

type variables
PRIVATE:
	
n_cst_bso_dispatch	inv_Dispatch


Long	ila_TrailerList[]
Long	ila_ContainerList[]
Long	il_Driver
Long	il_PowerEquipment
Date	id_TargetDate
Long	il_EventID
Boolean	ib_AllowContinue = TRUE
end variables

forward prototypes
private function integer of_adderror (string as_error)
public function integer of_showerrors ()
public function string of_getequipmentdescription (long al_eqid)
public function n_cst_bso_Dispatch of_getdispatch ()
public function integer of_setdispatch (n_cst_bso_dispatch anv_dispatch)
public function integer of_clearerrors ()
public function boolean of_dowecontinue ()
public function long of_getdriverid ()
public function long of_getpowerequipment ()
public function long of_geteventid ()
public function integer of_gettrailerlist (ref long ala_trailers[])
public function integer of_getcontainerlist (ref long ala_containers[])
public function date of_gettargetdate ()
private function integer of_setdriverid (long al_driverid)
private function integer of_setpowerequipmentid (long al_eqid)
private function integer of_seteventid (long al_eventid)
private function integer of_settargetdate (date ad_targetdate)
private function integer of_setcontainerlist (long ala_containers[])
private function integer of_settrailerlist (long ala_trailers[])
private function integer of_clearvars ()
public function integer of_checkequipmentondate ()
public function integer of_checkdriveronevent ()
private function boolean of_isshipmenthazmat ()
private function integer of_getdriverendorsements (ref boolean ab_doubles, ref boolean ab_hazmat, ref boolean ab_hazmattanker, ref boolean ab_tanker)
private function boolean of_anytankers ()
private function string of_getemployeedescription ()
public function integer of_validateassociation (long al_driver, long al_powerunit, long ala_trailers[], long ala_containers[], long al_event, date ad_targetdate)
private function integer of_checkequipmentonevent ()
public function integer of_checkdriverondate ()
public function integer of_checkdriveronequipment ()
public function date of_getdriverhazmatexpiration ()
public function integer of_getownedequipment (ref long ala_ids[])
private function n_cst_beo_event of_getevent ()
public function integer of_validateroutingremoval (long al_driver, long al_powerunit, long ala_trailers[], long ala_containers[], long al_event, date ad_targetdate)
private function long of_getdriverdivision ()
end prototypes

private function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )

RETURN 1
end function

public function integer of_showerrors ();int 		li_errorCount
int		i
String	ls_ErrorString
String	lsa_Errors[]

n_Cst_AnyarraySrv	lnv_Array
n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_Errorcollection.geterrorcount( )

For i = 1 TO li_ErrorCount
	lsa_Errors[i] = string( lnva_Error[i].getErrorMessage() )
next


lnv_Array.of_getshrinked( lsa_Errors , TRUE ,TRUE)

li_ErrorCount = UpperBound ( lsa_Errors )
For i = 1 TO li_ErrorCount
	ls_ErrorString += lsa_Errors[i] + "~r~n"
next

MessageBox("Association validation" , ls_ErrorString , EXCLAMATION! )

RETURN 1
end function

public function string of_getequipmentdescription (long al_eqid);Boolean	lb_Continue
String	ls_Type
String	ls_Ref
Long		ll_EqID 
String	ls_Return

ll_EqID = al_eqid

SELECT "equipment"."eq_type",   
		"equipment"."eq_ref"  
 INTO :ls_type,   
		:ls_Ref  
 FROM "equipment"  
WHERE "equipment"."eq_id" = :ll_EqID   ;

CHOOSE CASE SQLCA.SQlcode
	CASE 0,100
		Commit;
		lb_Continue = TRUE
	CASE ELSE  
		Rollback;
END CHOOSE

IF lb_Continue THEN
	CHOOSE CASE ls_Type
		case "Z"
			ls_Return = ""
		case "T"
			ls_Return = "TRAC"
		case "S"
			ls_Return = "STRT"
		case "N"
			ls_Return = "VAN"
		case "V"
			ls_Return = "TRLR"
		case "F"
			ls_Return = "FLBD"
		case "R"
			ls_Return = "REFR"
		case "K"
			ls_Return = "TANK"
		case "B"
			ls_Return = "RBOX"
		case "C"
			ls_Return = "CNTN"
		case "H"
			ls_Return = "CHAS"
	end choose	
	
	ls_Return +=  " " + ls_Ref
END IF

Return ls_Return

end function

public function n_cst_bso_Dispatch of_getdispatch ();RETURN inv_Dispatch
end function

public function integer of_setdispatch (n_cst_bso_dispatch anv_dispatch);inv_Dispatch = anv_dispatch
RETURN 1
end function

public function integer of_clearerrors ();IF isValid ( inv_ofrerrorcollection ) THEN
	THIS.inv_ofrerrorcollection.clearerrors( )
END IF

ib_allowcontinue = TRUE
RETURN 1
end function

public function boolean of_dowecontinue ();int 		li_errorCount
int		i
String	ls_ErrorString
String	lsa_Errors[]
Boolean	lb_Return

n_Cst_AnyarraySrv	lnv_Array
n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_Errorcollection.geterrorcount( )

For i = 1 TO li_ErrorCount
	lsa_Errors[i] = string( lnva_Error[i].getErrorMessage() )
next


lnv_Array.of_getshrinked( lsa_Errors , TRUE ,TRUE)

li_ErrorCount = UpperBound ( lsa_Errors )
ls_ErrorString = "The following problems were discovered:~r~n~r~n"

For i = 1 TO li_ErrorCount
	ls_ErrorString += lsa_Errors[i] + "~r~n"
next

IF ib_allowcontinue THEN

	ls_ErrorString += "~r~n Do you want to continue?"

	lb_Return = MessageBox("Association Validation" , ls_ErrorString , QUESTION! , YESNO! , 2 ) = 1
	
ELSE
	
	 MessageBox("Association Validation" , ls_ErrorString , Exclamation! )
	 lb_Return = FALSE
	 
END IF
//THIS.of_ClearErrors( ) 
//THIS.of_Clearvars( )
RETURN lb_Return
end function

public function long of_getdriverid ();RETURN il_Driver
end function

public function long of_getpowerequipment ();RETURN il_Powerequipment
end function

public function long of_geteventid ();RETURN il_Eventid
end function

public function integer of_gettrailerlist (ref long ala_trailers[]);ala_Trailers = ila_Trailerlist
RETURN UpperBound ( ala_trailers )
end function

public function integer of_getcontainerlist (ref long ala_containers[]);ala_containers[] = ila_Containerlist
RETURN UpperBound ( ala_containers )
end function

public function date of_gettargetdate ();Return id_targetdate
end function

private function integer of_setdriverid (long al_driverid);il_Driver = al_driverid
RETURN 1
end function

private function integer of_setpowerequipmentid (long al_eqid);il_powerequipment = al_Eqid
RETURN 1
end function

private function integer of_seteventid (long al_eventid);il_EventID = al_eventid
RETURN 1
end function

private function integer of_settargetdate (date ad_targetdate);id_targetdate = ad_targetdate
RETURN 1
end function

private function integer of_setcontainerlist (long ala_containers[]);int	li_Count
Int	i
Int	li_Keep

li_Count = UpperBound ( ala_containers[] )
FOR i = 1 TO li_Count
	IF Not IsNull ( ala_containers[i] ) THEN
		li_Keep ++
		ila_Containerlist[li_Keep] = ala_containers[i]
	END IF
NEXT


RETURN li_Keep
end function

private function integer of_settrailerlist (long ala_trailers[]);int	li_Count
Int	i
Int	li_Keep

li_Count = UpperBound ( ala_Trailers[] )
FOR i = 1 TO li_Count
	IF Not IsNull ( ala_Trailers[i] ) THEN
		li_Keep ++
		ila_trailerlist [li_Keep] = ala_Trailers[i]
	END IF
NEXT

RETURN li_Keep
end function

private function integer of_clearvars ();Long	lla_TrailerList[]
Long	lla_ContainerList[]
Date	ld_TargetDate

ila_TrailerList[] = lla_TrailerList
ila_ContainerList[] =lla_ContainerList
il_Driver = 0
il_PowerEquipment = 0
id_TargetDate = ld_TargetDate
il_EventID = 0


RETURN 1

end function

public function integer of_checkequipmentondate ();// check that the equipment can operate on the date specified.
Long	ll_EquipmentID
Date	ld_TargetDate
Date	ld_Inservice
Date	ld_OutService
Date	ld_Registration
Date	ld_Inspection
Int	li_ProblemCount
Int	li_Return 
Int	li_EqCount
Int	li_Index
Long	lla_Eqids[]
String	ls_EqDescription

SetNull ( ld_Inservice ) 
SetNull ( ld_outService )
SetNull ( ld_Registration )
SetNull ( ld_Inspection )

ld_TargetDate = THIS.of_GetTargetdate( )
//ll_EquipmentID = THIS.of_GetPowerequipment( )

li_EqCount = THIS.of_GetOwnedEquipment ( lla_EqIds )

FOR li_Index = 1 TO li_EqCount

	ll_EquipmentID = lla_EqIds[li_Index]
	
	ls_EqDescription = THIS.of_Getequipmentdescription( ll_EquipmentID )
	
	IF ll_EquipmentID > 0 AND NOT isNull ( ld_targetDate ) THEN
		
		// in/out of service
		SELECT "equipmentextendeddata"."inservicedate",   
				"equipmentextendeddata"."outofservicedate"  
		 INTO :ld_Inservice,   
				:ld_OutService  
		 FROM "equipmentextendeddata"  
		WHERE "equipmentextendeddata"."equipmentid" = :ll_EquipmentID   ;
		Commit;
		IF Not IsNull ( ld_OutService ) THEN
			IF isNull ( ld_Inservice ) OR ld_TargetDate >= ld_Inservice THEN // equipment is out of service
				li_ProblemCount ++
				THIS.of_AddError( ls_EqDescription + " is out of service on " + String ( ld_TargetDate , "M/D/YY" ) +"." )
			END IF
		END IF
		
		//Registration
		SELECT "equipmentregistration"."registrationexpirationdate"  
		 INTO :ld_Registration  
		 FROM "equipmentregistration"  
		WHERE "equipmentregistration"."equipmentid" = :ll_EquipmentID   ;
		Commit;
		
		IF isNull ( ld_Registration ) THEN
			li_ProblemCount ++ 
			THIS.of_adderror( ls_EqDescription + "'s registration expiration is not on file.")	
		ELSEIF ld_TargetDate >= ld_Registration THEN
			li_ProblemCount ++ 
			THIS.of_adderror( ls_EqDescription + "'s registration is expired on "+ String ( ld_TargetDate, "MM/DD/YY" ) +"." )
		END IF
		
		// Inspection
		SELECT "equipmentregistration"."annualinspectiondateexpiration"  
		 INTO :ld_Inspection  
		 FROM "equipmentregistration"  
		WHERE "equipmentregistration"."equipmentid" = :ll_EquipmentID  ;
		Commit;
		
		IF isNull ( ld_Inspection ) THEN
			li_ProblemCount ++
			THIS.of_AddError (  ls_EqDescription + "'s inspection expiration is not on file.")	
		ELSEIF ld_TargetDate >= ld_Inspection THEN
			li_ProblemCount ++ 
			THIS.of_adderror( ls_EqDescription + "'s inspection is expired on "+ String ( ld_TargetDate, "MM/DD/YY" ) +"." )
		END IF
	
	END IF
NEXT

li_Return = li_ProblemCount

RETURN li_Return
end function

public function integer of_checkdriveronevent ();Int		li_Problems
Boolean	lb_Hazmat
Boolean	lb_Doubles
Boolean	lb_HazmatTanks
Boolean	lb_Tanks
Boolean	lb_ShipmentHazmat
Boolean	lb_AnyTankers
Date		ld_TargetDate
Date		ld_HazmatDate
Long		lla_Trailers[]
String	ls_DriverDesc


SetNull ( ld_HazmatDate )

ls_DriverDesc = THIS.of_GetEmployeedescription( )
lb_AnyTankers = THIS.of_Anytankers( )
ld_TargetDate = THIS.of_getTargetdate( )
ld_HazmatDate = THIS.of_GetDriverhazmatexpiration( )


///////
/*Int	li_PrivsRtn
n_cst_beo_Event	lnv_Event

n_cst_privsmanager	lnv_Privs
lnv_Privs = gnv_app.of_GetPrivsmanager( )
lnv_Event = THIS.of_GetEvent ( )
 li_PrivsRtn = lnv_Privs.of_Getuserpermissionfromfn( "Alteritinerary", THIS.of_GetEvent ( ) )

CHOOSE CASE li_PrivsRtn
		
	CASE appeon_constant.ci_true
		MessageBox ( "Drivre on itin." , "YES" )
		
	CASE appeon_constant.ci_FALSE
		li_Problems ++
		THIS.of_AddError ( "You are not authorized to make this modification." )
		
		
		//MessageBox ( "Drivre on itin." , "No" )
		
	CASE Else
		MessageBox ( "Drivre on itin." , "ELSE" )
		
END CHOOSE
*/

//////////
IF li_Problems = 0 THEN

	lb_ShipmentHazmat = THIS.of_Isshipmenthazmat( )
	IF THIS.of_GetDriverendorsements( lb_Doubles , lb_Hazmat, lb_HazmatTanks , lb_Tanks ) = 1 THEN
	
		IF lb_ShipmentHazmat THEN
		
			IF NOT lb_Hazmat THEN
				THIS.of_Adderror( ls_DriverDesc + " is not endorsed for HAZMAT loads." )
				li_Problems ++
			ELSEIF IsNull ( ld_HazmatDate ) THEN
				THIS.of_Adderror( ls_DriverDesc + "'s HAZMAT expiration is not on file." )
				li_Problems ++
			ELSEIF ld_TargetDate >= ld_HazmatDate THEN
				THIS.of_Adderror( ls_DriverDesc + "'s HAZMAT endorsement is not valid on " + String ( ld_TargetDate , "MM/DD/YY" ) + "." )
				li_Problems ++
			END IF
			
			IF lb_AnyTankers AND NOT lb_HazmatTanks THEN
				THIS.of_Adderror( ls_DriverDesc + " is not endorsed for HAZMAT TANKER loads.")
				li_Problems ++
			END IF
			
		END IF
	
		IF lb_AnyTankers AND NOT lb_Tanks THEN
			THIS.of_Adderror( ls_DriverDesc + " is not endorsed for TANKER loads.")
			li_Problems ++
		END IF
	
		IF ( THIS.of_GetTrailerlist( lla_Trailers ) > 1 OR &
			  THIS.of_getcontainerlist( lla_Trailers ) > 1 )   AND NOT lb_Doubles THEN
			THIS.of_Adderror( ls_DriverDesc + " is not endorsed for DOUBLES.")
			li_Problems ++
		END IF
	
	END IF
END IF


RETURN li_Problems
	


end function

private function boolean of_isshipmenthazmat ();Long	ll_ShipmentID
Long	ll_EventID

Boolean	lb_ShipmentHazmat

n_Cst_beo_Event		lnv_Event 
n_cst_beo_Shipment	lnv_Shipment

lnv_Shipment = CREATE n_Cst_beo_Shipment
lnv_Event = CREATE n_cst_beo_Event

ll_EventID = THIS.of_GetEventid( )

IF isValid ( inv_Dispatch ) THEN
	
	inv_dispatch.of_RetrieveEvents( {ll_EventID} )
	lnv_Event.of_SetSource ( inv_Dispatch.of_GetEventCache ( )) 
	lnv_Event.of_SetSourceID ( ll_EventID ) 
	ll_ShipmentID = lnv_Event.of_GetShipment ( )

	
	IF ll_ShipmentID > 0 THEN
		inv_Dispatch.of_RetrieveShipment( ll_SHipmentiD ) 
		lnv_Shipment.of_SetSource ( inv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
		IF lnv_SHipment.of_gethazmat( ) = 'T' THEN
			lb_ShipmentHazmat = TRUE
		END IF
	END IF
	
END IF

DESTROY ( lnv_Shipment ) 
DESTROY ( lnv_Event )

RETURN lb_ShipmentHazmat
end function

private function integer of_getdriverendorsements (ref boolean ab_doubles, ref boolean ab_hazmat, ref boolean ab_hazmattanker, ref boolean ab_tanker);Long		ll_Driver
String	ls_T  // doubles
String	ls_N  // tanker
String	ls_X //  hazmat tanker
String	ls_H	// Hazmat
Boolean	lb_Doubles
Boolean	lb_Tank
Boolean	lb_HT
Boolean	lb_Hazmat
int		li_Return = -1

ll_Driver = THIS.of_Getdriverid( )

IF ll_Driver > 0 THEN

	SELECT "driverinfo"."di_endorse_t", 
			"driverinfo"."di_endorse_h" ,
			"driverinfo"."di_endorse_n",   
			"driverinfo"."di_endorse_x"  
	 INTO :ls_T,   
			:ls_H,
			:ls_N,   
			:ls_X  
	 FROM "driverinfo"  
	WHERE "driverinfo"."di_id" = :ll_Driver;
	
	commit;
	
	IF ls_T = 'T' THEN
		lb_Doubles = TRUE
	END IF
	
	IF ls_H = 'T' THEN
		lb_Hazmat = TRUE
	END IF
	
	IF ls_X = 'T' THEN
		lb_HT = TRUE
	END IF
	
	IF ls_N = 'T' THEN
		lb_Tank = TRUE 
	END IF
	
	ab_Doubles = lb_Doubles
	ab_Hazmat = lb_Hazmat
	ab_HazmatTanker= lb_HT
	ab_tanker = lb_Tank
	
	li_Return = 1

END IF

RETURN li_Return
end function

private function boolean of_anytankers ();Boolean	lb_Return
Int		li_Count
Int		i
Long		ll_Temp
String	ls_Type 
Long		lla_Trailers[]
Int		li_Bound

n_Cst_EquipmentManager	lnv_EqMan
ls_Type = lnv_EqMan.cs_tank

li_Bound = THIS.of_Gettrailerlist( lla_Trailers )

FOR  i = 1 TO li_Bound

	ll_Temp = lla_Trailers[i] 
	
	SELECT Count ( "equipment"."eq_id"  )
		INTO :li_Count
	 FROM "equipment"  
	WHERE "equipment"."eq_id" = :ll_Temp AND  "equipment"."eq_type"  = :ls_Type ;
	
	CHOOSE CASE SQLCA.Sqlcode
	CASE 0,100 
		Commit;
	CASE ELSE
		Rollback;
	END CHOOSE       
	
	IF li_Count > 0 THEN
		lb_Return = TRUE
		EXIT
	END IF
	
NEXT	

IF NOT lb_Return THEN
	s_eq_info lstr_equip
	IF isValid ( inv_dispatch ) THEN
		FOR  i = 1 TO li_Bound	
			inv_dispatch.of_getequipmentinfo(lla_Trailers[i],  lstr_equip )
			IF lstr_equip.eq_type = lnv_EqMan.cs_tank THEN
				lb_Return = TRUE
				EXIT
			END IF
		NEXT
	END IF
END IF


RETURN lb_Return
end function

private function string of_getemployeedescription ();Long	ll_EmpID
String	ls_FName
String	ls_LName
String	ls_Return
Boolean	lb_Continue

ll_EmpID = THIS.of_getdriverid( )

  SELECT "employees"."em_fn",   
         "employees"."em_ln"  
    INTO :ls_FName,   
         :ls_LName  
    FROM "employees"  
   WHERE "employees"."em_id" = :ll_EmpID ;
          
CHOOSE CASE SQLCA.Sqlcode
	CASE 0,100
		lb_Continue = TRUE
		Commit;
	CASE ELSE
		Rollback;
END CHOOSE

IF lb_Continue THEN
	ls_Return = ls_FName + " " + ls_LName
END IF

RETURN ls_Return
end function

public function integer of_validateassociation (long al_driver, long al_powerunit, long ala_trailers[], long ala_containers[], long al_event, date ad_targetdate);Int	li_ProblemCount
Int	li_Return
Boolean	lb_PerformAssociation

THIS.of_Clearvars( )

THIS.of_Setdriverid( al_driver )
THIS.of_Setpowerequipmentid( al_powerunit )
THIS.of_SetTrailerlist( ala_trailers[] )
THIS.of_SetContainerlist( ala_containers)
THIS.of_setEventid( al_event )
THIS.of_SetTargetdate( ad_targetdate )

// We will possibly perform 2 check here
// first we want to check that the users privs actually allow them to even attempt the association

CHOOSE CASE gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "Alteritinerary", THIS.of_GetEvent () )
		
	CASE appeon_constant.ci_True
		
	CASE appeon_constant.ci_False
		li_ProblemCount ++
		THIS.of_AddError ( "Your privileges do not permit you to make this modification." )
		ib_allowcontinue = FALSE
		
	CASE ELSE
		
END CHOOSE


CHOOSE CASE gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "Alteritinerary", THIS.of_getdriverDivision ( ) )
		
	CASE appeon_constant.ci_True
		
	CASE appeon_constant.ci_False
		li_ProblemCount ++
		THIS.of_AddError ( "Your privileges do not permit you to make this modification." )
		ib_allowcontinue = FALSE
		
	CASE ELSE
		
END CHOOSE

n_cst_setting_associationvalidation	lnv_PerformValidation
lnv_PerformValidation = CREATE n_cst_setting_associationvalidation
lb_PerformAssociation = lnv_PerformValidation.of_GetValue ( ) = lnv_PerformValidation.cs_Yes
DESTROY ( lnv_PerformValidation )


// then, if the attempt is allowed we will check the association.
IF li_ProblemCount = 0 AND lb_PerformAssociation THEN
	
	li_ProblemCount += THIS.of_CheckEquipmentOnDate( )
	
	li_ProblemCount += THIS.of_CheckDriveronequipment( )
	li_ProblemCount += THIS.of_CheckDriverOnEvent( )
	li_ProblemCount += THIS.of_Checkdriverondate( )

END IF


li_Return = li_ProblemCount
RETURN li_Return




end function

private function integer of_checkequipmentonevent ();RETURN 0
/* We are not calling this yet because we need to discuss how to figure out all the 
	state the truck will be traveling through.

the commented code was not tested

Long		ll_Equipment
Long		ll_Event
String	ls_State
String	ls_Desc
Int		li_Problems
Int		li_Return
Int		li_Count

n_Cst_beo_Event		lnv_Event 
n_cst_beo_Company		lnv_Co

ll_Event = THIS.of_GetEventid( )
ll_Equipment = THIS.of_GetPowerequipment( )
ls_Desc = THIS.of_GetEquipmentdescription( ll_Equipment )

IF ll_Equipment + ll_Event = 0 THEN
	RETURN 0
END IF

lnv_Event = CREATE n_cst_beo_Event

IF isValid ( inv_Dispatch ) THEN
	
	inv_dispatch.of_RetrieveEvents( {ll_Event} )
	lnv_Event.of_SetSource ( inv_Dispatch.of_GetEventCache ( )) 
	lnv_Event.of_SetSourceID ( ll_Event ) 
	
	lnv_Event.of_GetSite( lnv_Co )

END IF

IF isValid ( lnv_Co ) THEN
	ls_State = lnv_Co.of_GetState( )
END IF

IF Len ( ls_State ) > 0 THEN
	  SELECT Count ("equipmentapportion"."equipmentid" )
    INTO :ll_Count  
    FROM "equipmentapportion"  
   WHERE ( "equipmentapportion"."equipmentid" = :ll_EquipmentID );
	Commit;
END IF

IF li_Count > 0 THEN
	SELECT Count ("equipmentapportion"."equipmentid" )
    INTO :ll_Count  
    FROM "equipmentapportion"  
   WHERE ( "equipmentapportion"."equipmentid" = :ll_EquipmentID )And
	 ( "equipmentapportion"."state" = :ll_State ) ;
	 Commit;
	 
	 IF li_Count = 0 THEN
		li_Problems ++
		THIS.of_AddError( ls_Desc + " is not apportioned for " + ls_State  )
	END IF
	 
	 
END IF
li_Return = li_Problems

RETURN li_Return

*/
	
	
end function

public function integer of_checkdriverondate ();Long		ll_DriverID
String	ls_Desc
Int		li_Problems
Int		li_Return
Date		ld_TargetDate
date		ld_LicExp
Date		ld_MedExp

Setnull ( ld_LicExp ) 
SetNull ( ld_MedExp )

ld_TargetDate = THIS.of_Gettargetdate( )
ll_DriverID = THIS.of_Getdriverid( )
ls_Desc = THIS.of_GetEmployeedescription( )


IF ll_DriverID > 0 AND Not IsNull ( ld_TargetDate ) THEN

	SELECT "driverinfo"."di_lic_exp",   
			"driverinfo"."di_med_exp"   
	 INTO :ld_LicExp,   
			:ld_MedExp   
	 FROM "driverinfo"  
	WHERE "driverinfo"."di_id" = :ll_DriverID;
	Commit;
	
	IF isNull ( ld_LicExp ) THEN
		li_Problems ++
		THIS.of_AddError ( ls_Desc + "'s license expiration is not on file." )
	END IF
	
	IF isNull ( ld_MedExp ) THEN
		li_Problems ++
		THIS.of_AddError ( ls_Desc + "'s medical card expiration is not on file." )
	END IF
		
	IF NOT IsNull ( ld_LicExp ) THEN
		IF ld_TargetDate >= ld_LicExp THEN
			li_Problems ++
			THIS.of_AddError ( ls_Desc + "'s license is not valid on " + String ( ld_targetDate, "MM/DD/YY" ) + "." )
		END IF
	END IF
	
	IF NOT IsNull ( ld_MedExp ) THEN
		IF ld_TargetDate >= ld_MedExp THEN
			li_Problems ++
			THIS.of_AddError ( ls_Desc + "'s medical card is not valid on " + String ( ld_targetDate, "MM/DD/YY" ) + "." )
		END IF
	END IF
	
END IF
	
li_Return = li_Problems

RETURN li_Return


end function

public function integer of_checkdriveronequipment ();Int	li_Problems
Int	li_Return
Long	ll_EquipmentID
Long	ll_DriverID
String	ls_DriverDesc
String	ls_EquipmentDesc
String	ls_EqType
String 	ls_LicType
String	ls_Need
Dec		lc_gvw

n_cst_equipmentmanager	lnv_EqMan
SetNull ( ls_LicType )

ll_EquipmentID = THIS.of_GetPowerequipment( )
ll_DriverID = THIS.of_GetDriverid( )
ls_DriverDesc = THIS.of_GetEmployeedescription( )
ls_EquipmentDesc = THIS.of_GetEquipmentdescription( ll_EquipmentID )

IF ll_DriverID > 0 THEN

	SELECT "driverinfo"."di_lic_type"  
	 INTO :ls_LicType  
	 FROM "driverinfo"  
	WHERE "driverinfo"."di_id" = :ll_DriverID ;


	IF isNull ( ls_LicType )  THEN
		li_Problems ++ 
		THIS.of_AddError ( ls_DriverDesc + "'s license type has not been specified." )
	END IF

	IF ll_EquipmentID > 0 THEN
		
		SELECT "equipment"."eq_type"
		INTO :ls_EqType
		FROM "equipment",   
		WHERE  "equipment"."eq_id" = :ll_EquipmentID ;
		Commit;

		IF Not IsNull ( ls_LicType ) THEN
			CHOOSE CASE ls_EqType 
				CASE lnv_EqMan.cs_trac 
					ls_Need = 'A'
				CASE lnv_EqMan.cs_Strt
					ls_Need = "AB"
				CASE ELSE
					ls_Need = 'ABN'
			END CHOOSE
		
			IF POS ( ls_Need , ls_LicType  ) = 0  THEN
				li_Problems ++
				THIS.of_Adderror( ls_DriverDesc + " does not have the appropriate license type for " + ls_EquipmentDesc + "." )
			END IF	
		END IF
		
	END IF
	
END IF

li_Return = li_Problems

RETURN li_Return




end function

public function date of_getdriverhazmatexpiration ();Long	ll_DriverID
Date	ld_Hazmat
Boolean	lb_Continue
n_cst_datetime	lnv_DateTime

ll_DriverID = THIS.of_Getdriverid( )
IF ll_DriverID > 0 THEN
	  
	SELECT "driverinfo"."di_hazmat_certification_date"  
	 INTO :ld_Hazmat  
	 FROM "driverinfo"  
	WHERE "driverinfo"."di_id" = :ll_DriverID ;
	IF SQLCA.Sqlcode = 0 THEN
		lb_Continue = TRUE
	END IF
	
	Commit;

END IF

IF lb_Continue THEN
	ld_Hazmat = lnv_DateTime.of_relativeyear(  ld_Hazmat, 3 ) // good for 3 years 
ELSE
	SetNull ( ld_Hazmat )
END IF


RETURN ld_Hazmat
	
	
end function

public function integer of_getownedequipment (ref long ala_ids[]);int		li_Count
Int		li_Index
Long		lla_Owned[]
String	ls_Outside
Long		ll_ID
int		li_Keep
Long	ll_PowerUnit
Long	lla_Containers[]
Long	lla_Trailers[] 
Long	lla_List[]
Int	i


ll_PowerUnit = THIS.of_GetPowerequipment( )
THIS.of_GetContainerlist( lla_Containers )
THIS.of_GetTrailerlist( lla_Trailers )


FOR i = 1 TO 2
	CHOOSE CASE i
		CASE 1
			lla_List = lla_Containers
		CASE 2
			lla_List = lla_Trailers
	END CHOOSE
		
	li_Count = UpperBound ( lla_List )

	FOR li_Index = 1 TO li_Count
		ll_ID = lla_List[li_Index]
		
		  SELECT "equipment"."eq_outside"  
		 INTO :ls_Outside  
		 FROM "equipment"  
		WHERE "equipment"."eq_id" = :ll_ID;
		IF SQLCA.Sqlcode = 0 THEN
			IF ls_Outside = "F" THEN
				li_Keep ++
				lla_Owned[li_Keep] = ll_ID
			END IF
			COMMIT;
		ELSE
			ROLLBACK;
		END IF
	NEXT
NEXT

li_Keep++
lla_Owned[li_Keep] = ll_PowerUnit

ala_ids = lla_Owned

RETURN li_Keep
end function

private function n_cst_beo_event of_getevent ();Long	ll_Event
Long	ll_Shipment	


n_cst_beo_Shipment	lnva_Shipment[]
n_cst_Beo_Shipment	lnv_Shipment

ll_Event = THIS.of_Geteventid( )

n_cst_beo_Event	lnv_Event
lnv_Event = CREATE n_cst_beo_Event


lnv_Event.of_SetSource ( inv_dispatch.of_GetEventcache( ) )
lnv_Event.of_SetSourceID ( ll_Event )

ll_Shipment = lnv_Event.of_GetShipment () 
IF ll_Shipment > 0 THEN
	IF inv_dispatch.of_GetShipments( {ll_Shipment} , lnva_Shipment ) >= 0 THEN
		lnv_Shipment = lnva_Shipment[1]
	END IF
END IF

lnv_Event.of_SetShipment ( lnv_Shipment )

RETURN lnv_Event

end function

public function integer of_validateroutingremoval (long al_driver, long al_powerunit, long ala_trailers[], long ala_containers[], long al_event, date ad_targetdate);Int	li_ProblemCount
Int	li_Return

THIS.of_Clearvars( )

THIS.of_Setdriverid( al_driver )
THIS.of_Setpowerequipmentid( al_powerunit )
THIS.of_SetTrailerlist( ala_trailers[] )
THIS.of_SetContainerlist( ala_containers)
THIS.of_setEventid( al_event )
THIS.of_SetTargetdate( ad_targetdate )

// We will possibly perform 2 check here
// first we want to check that the users privs actually allow them to even attempt the association

CHOOSE CASE gnv_app.of_GetPrivsmanager( ).of_Getuserpermissionfromfn( "Alteritinerary", THIS.of_GetEvent () )
		
	CASE appeon_constant.ci_True
		
	CASE appeon_constant.ci_False
		li_ProblemCount ++
		THIS.of_AddError ( "Your privileges do not permit you to make this modification." )
		ib_allowcontinue = FALSE
		
	CASE ELSE
		
END CHOOSE




li_Return = li_ProblemCount
RETURN li_Return




end function

private function long of_getdriverdivision ();Long	ll_Return
Long	ll_Div
Long	ll_TempDiv
Long	ll_PermDiv
Long	ll_DriverID

ll_DriverID = THIS.of_Getdriverid( )

// first check the temp division
  SELECT "driverdivisions"."tmpdivision",   
         "driverinfo"."di_division"  
    INTO :ll_TempDiv,   
         :ll_PermDiv  
    FROM {oj "driverdivisions" RIGHT OUTER JOIN "driverinfo" ON "driverdivisions"."di_id" = "driverinfo"."di_id"}  
   WHERE "driverinfo"."di_id" = :ll_DriverID   ;

Commit;

IF ll_TempDiv > 0 THEN
	ll_Return = ll_TempDiv
ELSE
	ll_Return = ll_PermDiv
END IF
RETURN ll_Return
end function

on n_cst_bso_validation.create
call super::create
end on

on n_cst_bso_validation.destroy
call super::destroy
end on

