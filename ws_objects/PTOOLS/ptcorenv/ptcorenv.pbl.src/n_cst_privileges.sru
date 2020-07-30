$PBExportHeader$n_cst_privileges.sru
forward
global type n_cst_privileges from nonvisualobject
end type
end forward

shared variables
//begin commenting by appeon 20070727
//Integer	si_UserClass
//Long	sl_EmployeeId
//String	ss_ShipmentSummary_ViewTotalCharges
//end commenting by appeon 20070727


end variables

global type n_cst_privileges from nonvisualobject autoinstantiate
end type

type variables
CONSTANT Integer	ci_Class_NonUser = 1001
CONSTANT Integer	ci_Class_Lookup = 1002
CONSTANT Integer	ci_Class_Entry = 1003
CONSTANT Integer	ci_Class_Audit = 1004
CONSTANT Integer	ci_Class_Administrative = 1005
end variables

forward prototypes
public function integer of_setuserclass (integer ai_userclass)
public function integer of_getuserclass ()
public function boolean of_system_logon ()
public function boolean of_shipment_edit ()
public function string of_getrestrictmessage ()
public function boolean of_shipment_editrestrictedbill ()
public function boolean of_shipment_editbilledbill ()
public function boolean of_shipment_editbill ()
public function boolean of_shipment_setstatusrestricted ()
public function boolean of_shipment_setstatusaudited ()
public function boolean of_employee_editnotes ()
public function boolean of_employee_editrestrictednotes ()
public function integer of_setemployeeid (long al_id)
public function long of_getemployeeid ()
public function integer of_initialize ()
public function boolean of_settlements_edit ()
public function boolean of_fuelcard_import ()
public function boolean of_settlements_setup ()
public function boolean of_equipmentleasetype_setup ()
public function boolean of_shipmentsummary_viewtotalcharges ()
public function boolean of_trip_edit ()
public function boolean of_trip_editrestricted ()
public function boolean of_trip_edithistory ()
public function boolean of_trip_setstatusrestricted ()
public function boolean of_trip_setstatusaudited ()
public function boolean of_trip_setstatushistory ()
public function boolean of_trip_editaudited ()
public function boolean of_trip_delete ()
public function boolean of_hasadministrativerights ()
public function boolean of_hasauditrights ()
public function boolean of_hasentryrights ()
public function boolean of_haslookuprights ()
public function boolean of_hassysadminrights ()
public function boolean of_hasscanningrights ()
public function boolean of_canchangeimageid ()
public function boolean of_settlements_entitysetup ()
public function boolean of_settlements_createbatch ()
public function boolean of_settlements_assigntobatch ()
public function boolean of_rateconfirmationtemplate ()
public function boolean of_settlements_closetransaction ()
public function string of_getsysadminmessage ()
public function boolean of_shipment_setstatuscancelled ()
public function boolean of_shipment_delete ()
public function boolean of_hasequipmentdeactivationrights ()
public function boolean of_shipment_makenonrouted ()
public function boolean of_hastirlfdrights ()
public function boolean of_hasimagechangingrights ()
public function boolean of_hassufficientrights (string as_neededlevel)
public function boolean of_dynamic_administration ()
public function boolean of_dynamic_createinstance ()
public function boolean of_dynamic_createabstract ()
public function boolean of_dynamic_deleteabstract ()
public function boolean of_dynamic_createlinkdefinition ()
public function boolean of_dynamic_createmouseover ()
public function boolean of_dynamic_applylinks ()
public function boolean of_dynamic_changeproperties ()
end prototypes

public function integer of_setuserclass (integer ai_userclass);Integer	li_Return

CHOOSE CASE ai_UserClass

CASE	ci_Class_NonUser, &
		ci_Class_Lookup, &
		ci_Class_Entry, &
		ci_Class_Audit, &
		ci_Class_Administrative

		si_UserClass = ai_UserClass
		li_Return = 1

CASE ELSE
		li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_getuserclass ();Integer	li_UserClass

IF si_UserClass > 0 THEN
	li_UserClass = si_UserClass

ELSE
	SetNull ( li_UserClass )

END IF

RETURN li_UserClass
end function

public function boolean of_system_logon ();Boolean	lb_Allow

lb_Allow = of_HasLookupRights ( )

RETURN lb_Allow
end function

public function boolean of_shipment_edit ();Boolean	lb_Allow

lb_Allow = This.of_HasEntryRights ( )

RETURN lb_Allow
end function

public function string of_getrestrictmessage ();RETURN "You are not authorized to perform this function."
end function

public function boolean of_shipment_editrestrictedbill ();Boolean	lb_Allow

lb_Allow = This.of_HasAuditRights ( )

RETURN lb_Allow
end function

public function boolean of_shipment_editbilledbill ();Boolean	lb_Allow

lb_Allow = This.of_HasSysAdminRights ( )

RETURN lb_Allow
end function

public function boolean of_shipment_editbill ();Boolean	lb_Allow

lb_Allow = of_HasEntryRights ( )

RETURN lb_Allow
end function

public function boolean of_shipment_setstatusrestricted ();Boolean	lb_Allow

lb_Allow = This.of_HasEntryRights ( )

RETURN lb_Allow
end function

public function boolean of_shipment_setstatusaudited ();Boolean	lb_Allow

lb_Allow = This.of_HasAuditRights ( )

RETURN lb_Allow
end function

public function boolean of_employee_editnotes ();Boolean	lb_Allow

lb_Allow = of_HasEntryRights ( )

RETURN lb_Allow
end function

public function boolean of_employee_editrestrictednotes ();Boolean	lb_Allow

lb_Allow = of_HasAdministrativeRights ( )

RETURN lb_Allow
end function

public function integer of_setemployeeid (long al_id);sl_EmployeeId = al_Id

RETURN 1
end function

public function long of_getemployeeid ();RETURN sl_EmployeeId
end function

public function integer of_initialize ();//Returns : 1, -1

Long	ll_EmployeeId, &
		ll_ClassId

ll_EmployeeId = of_GetEmployeeId ( )
ll_ClassId = of_GetUserClass ( )

//Megan Code from here on

integer retval
datastore ds_ind_classes

retval = 1

ds_ind_classes = CREATE datastore 
ds_ind_classes.DataObject = "d_ind_classes"
ds_ind_classes.SetTransObject(sqlca) 

if gds_privs.retrieve() = -1 then
	// this datastores retrieves all classes and it is only neccessary to retrieve
	// the one class but I don't have time to change it for this release
	rollback ;
	retval = -1
	goto delstores
else
	commit ;
	gds_privs.setfilter("class_id = " + string(ll_ClassId))
	gds_privs.filter()
	gds_privs.rowsdiscard(1, gds_privs.filteredcount(), filter!)
end if
if ds_ind_classes.retrieve(ll_EmployeeId) = -1 then
	rollback ;
	retval = -1
	goto delstores
else
	commit ;
end if

integer lcv, lcv2, newrow
long privitem

for lcv = 1 to ds_ind_classes.rowcount()
	privitem = ds_ind_classes.getitemnumber(lcv, "ss_id") 
	for lcv2 = 1 to gds_privs.rowcount()
		if gds_privs.getitemnumber(lcv2, "priv_item") = privitem then 
			gds_privs.setitem(lcv2, "priv_val", ds_ind_classes.getitemnumber(lcv, "ss_long"))
			//should be: exit
			goto found_it
		end if
	next
	// the following script is for when values are in the database before they have been 
	//	put into formal classes
	newrow = gds_privs.insertrow(0)
	gds_privs.setitem(newrow, "class_id", ll_ClassId)
	gds_privs.setitem(newrow, "priv_item", privitem)
	gds_privs.setitem(newrow, "priv_val", ds_ind_classes.getitemnumber(lcv, "ss_long"))
	found_it:
next
gds_privs.sort()
gds_privs.groupcalc()

for lcv = 1 to gds_privs.rowcount()
	privitem = gds_privs.getitemnumber(lcv, "priv_item") 
	choose case privitem 
		case is < 10000 //in emp componant
			IF gnv_app.of_GetPrivsmanager( ).of_useadvancedprivs( ) THEN
				g_privs.emp[privitem - 9000] = 1
			ELSE
				
				g_privs.emp[privitem - 9000] = gds_privs.getitemnumber(lcv, "priv_val")
			END IF
		case is < 20000 // in log componant
			IF gnv_app.of_GetPrivsmanager( ).of_useadvancedprivs( ) THEN
				g_privs.log[privitem - 19000] = 1
			ELSE
				g_privs.log[privitem - 19000] = gds_privs.getitemnumber(lcv, "priv_val")
			END IF
		case is < 30000 // in settle componant
			IF gnv_app.of_GetPrivsmanager( ).of_useadvancedprivs( ) THEN
				g_privs.settle[privitem - 29000] = 1
			ELSE
				g_privs.settle[privitem - 29000] = gds_privs.getitemnumber(lcv, "priv_val")
			END IF
		case  39001 //customer hold
			g_privs.l_customerhold = gds_privs.getitemnumber(lcv, "priv_val")
	end choose
next

if isnull(g_max_permit) then
	if ll_ClassId >= 1004 then g_max_permit = "T" else g_max_permit = "K"
end if

delstores:
destroy ds_ind_classes
return retval

end function

public function boolean of_settlements_edit ();Boolean	lb_Allow
IF NOT gnv_app.of_Getprivsmanager( ).of_Useadvancedprivs( ) THEN
	IF gf_privs(29001) = 0 THEN
		//Not allowed
	ELSE
		lb_Allow = TRUE
	END IF
ELSE
	lb_Allow = TRUE
END IF

RETURN lb_Allow
end function

public function boolean of_fuelcard_import ();RETURN of_Settlements_Edit ( )
end function

public function boolean of_settlements_setup ();RETURN This.of_HasSysAdminRights ( )
end function

public function boolean of_equipmentleasetype_setup ();RETURN of_HasSysAdminRights ( )
end function

public function boolean of_shipmentsummary_viewtotalcharges ();//NOTE: Returns Null if value cannot be determined!

Boolean	lb_Allow
String	ls_Value

//Retrieve the value, if it hasn't been already

IF ss_ShipmentSummary_ViewTotalCharges = "" THEN

	SELECT ss_string into :ls_Value FROM system_settings where ss_id = 27 ;

	CHOOSE CASE SQLCA.SqlCode

	CASE 0
		COMMIT ;

		CHOOSE CASE ls_Value

		CASE "ALL!", "AUDIT!", "ADMIN!", "NONE!"
			//Value is ok.  Proceed.

		CASE ELSE
			//Unexected Value.  Use default instead.
			ls_Value = "ALL!"

		END CHOOSE

	CASE 100
		COMMIT ;
		//Setting not found.  Use default.
		ls_Value = "ALL!"

	CASE ELSE
		ROLLBACK ;
		//Error.  Set value as uninitialized.
		ls_Value = ""

	END CHOOSE

	ss_ShipmentSummary_ViewTotalCharges = ls_Value

END IF


CHOOSE CASE ss_ShipmentSummary_ViewTotalCharges

CASE "ALL!"
	lb_Allow = TRUE

CASE "AUDIT!"
	IF This.of_HasAuditRights ( ) THEN
		lb_Allow = TRUE
	END IF

CASE "ADMIN!"
	IF This.of_HasAdministrativeRights ( ) THEN
		lb_Allow = TRUE
	END IF

CASE "NONE!"
	//Don't allow.

CASE ELSE
	SetNull ( lb_Allow )

END CHOOSE


RETURN lb_Allow
end function

public function boolean of_trip_edit ();Boolean	lb_Allow

lb_Allow = This.of_HasEntryRights ( )

RETURN lb_Allow
end function

public function boolean of_trip_editrestricted ();Boolean	lb_Allow

lb_Allow = This.of_HasAuditRights ( )

RETURN lb_Allow
end function

public function boolean of_trip_edithistory ();Boolean	lb_Allow

lb_Allow = This.of_HasSysAdminRights ( )

RETURN lb_Allow
end function

public function boolean of_trip_setstatusrestricted ();Boolean	lb_Allow

lb_Allow = This.of_HasEntryRights ( )

RETURN lb_Allow
end function

public function boolean of_trip_setstatusaudited ();Boolean	lb_Allow

lb_Allow = This.of_HasAuditRights ( )

RETURN lb_Allow
end function

public function boolean of_trip_setstatushistory ();Boolean	lb_Allow

lb_Allow = This.of_HasAuditRights ( )

RETURN lb_Allow
end function

public function boolean of_trip_editaudited ();Boolean	lb_Allow

lb_Allow = This.of_HasAuditRights ( )

RETURN lb_Allow
end function

public function boolean of_trip_delete ();Boolean	lb_Allow

lb_Allow = This.of_HasAuditRights ( )

RETURN lb_Allow
end function

public function boolean of_hasadministrativerights ();//TRUE if the user is Administrative class OR HIGHER, FALSE if not, or can't be determined

Boolean	lb_Result

CHOOSE CASE of_GetUserClass ( )

CASE ci_Class_Administrative
	lb_Result = TRUE

END CHOOSE

RETURN lb_Result
end function

public function boolean of_hasauditrights ();//TRUE if the user is Audit class OR HIGHER, FALSE if not, or can't be determined

Boolean	lb_Result

IF of_HasAdministrativeRights ( ) THEN
	lb_Result = TRUE

ELSEIF of_GetUserClass ( ) = ci_Class_Audit THEN
	lb_Result = TRUE

END IF

RETURN lb_Result
end function

public function boolean of_hasentryrights ();//TRUE if the user is Entry class OR HIGHER, FALSE if not, or can't be determined

Boolean	lb_Result

IF of_HasAuditRights ( ) THEN
	lb_Result = TRUE

ELSEIF of_GetUserClass ( ) = ci_Class_Entry THEN
	lb_Result = TRUE

END IF

RETURN lb_Result
end function

public function boolean of_haslookuprights ();//TRUE if the user is Lookup class OR HIGHER, FALSE if not, or can't be determined

Boolean	lb_Result

IF of_HasEntryRights ( ) THEN
	lb_Result = TRUE

ELSEIF of_GetUserClass ( ) = ci_Class_Lookup THEN
	lb_Result = TRUE

END IF

RETURN lb_Result
end function

public function boolean of_hassysadminrights ();Boolean	lb_Result

IF gnv_App.of_GetUserId ( ) = "PTADMIN" THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function boolean of_hasscanningrights ();//NOTE: Returns Null if value cannot be determined!

Boolean	lb_Allow
String	ls_Value

//Retrieve the value, if it hasn't been already


	SELECT ss_string into :ls_Value FROM system_settings where ss_id = 36 ;

	CHOOSE CASE SQLCA.SqlCode

	CASE 0
		COMMIT ;

		CHOOSE CASE ls_Value

		CASE "ALL!", "ENTRY!", "AUDIT!", "ADMIN!"
			//Value is ok.  Proceed.

		CASE ELSE
			//Unexected Value.  Use default instead.
			ls_Value = "ALL!"

		END CHOOSE

	CASE 100
		COMMIT ;
		//Setting not found.  Use default.
		ls_Value = "ALL!"

	CASE ELSE
		ROLLBACK ;
		//Error.  Set value as uninitialized.
		ls_Value = ""

	END CHOOSE





CHOOSE CASE ls_Value

CASE "ALL!"
	lb_Allow = TRUE

CASE "ENTRY!"
	IF This.of_HasEntryRights ( ) THEN
		lb_Allow = TRUE
	END IF

CASE "ADMIN!"
	IF This.of_HasAdministrativeRights ( ) THEN
		lb_Allow = TRUE
	END IF
	
CASE "AUDIT!"
	IF This.of_HasAuditRights ( ) THEN
		lb_Allow = TRUE
	END IF


CASE ELSE
	SetNull ( lb_Allow )

END CHOOSE


RETURN lb_Allow
end function

public function boolean of_canchangeimageid ();RETURN THIS.of_hasSysAdminRights ( )


end function

public function boolean of_settlements_entitysetup ();RETURN This.of_HasAdministrativeRights ( )
end function

public function boolean of_settlements_createbatch ();RETURN This.of_HasAdministrativeRights ( )
end function

public function boolean of_settlements_assigntobatch ();RETURN This.of_HasAuditRights ( )
end function

public function boolean of_rateconfirmationtemplate ();RETURN of_HasSysAdminRights ( )
end function

public function boolean of_settlements_closetransaction ();RETURN This.of_HasAdministrativeRights ( )
end function

public function string of_getsysadminmessage ();RETURN "Only the Profit Tools Administrator (PTADMIN) can perform this function."
end function

public function boolean of_shipment_setstatuscancelled ();n_cst_Settings	lnv_Settings
Any	la_Value

Boolean	lb_Allow = FALSE

CHOOSE CASE lnv_Settings.of_GetSetting ( 77, la_Value )

CASE 1

	CHOOSE CASE String ( la_Value )

	CASE "ENTRY!"
		lb_Allow = This.of_HasEntryRights ( )

	CASE "AUDIT!"
		lb_Allow = This.of_HasAuditRights ( )

	CASE "ADMIN!"
		lb_Allow = This.of_HasAdministrativeRights ( )

	CASE "PTADMIN!"
		lb_Allow = This.of_HasSysAdminRights ( )

	CASE "NONE!"
		//Do not allow

	CASE ELSE
		//Unexpected value.
		//Do not allow

	END CHOOSE

CASE 0
	//Value not specified  --  Use default policy.
	lb_Allow = FALSE  //Default policy is to not allow this (partly for legacy reasons, 
							//partly because users should be aware where the shipments will go
							//if they use this capability.)

CASE -1
	//Error
	//Do not allow

CASE ELSE
	//Unexpected return
	//Do not allow

END CHOOSE

RETURN lb_Allow
end function

public function boolean of_shipment_delete ();n_cst_Settings	lnv_Settings
Any	la_Value

Boolean	lb_Allow = FALSE

CHOOSE CASE lnv_Settings.of_GetSetting ( 78, la_Value )

CASE 1

	CHOOSE CASE String ( la_Value )

	CASE "ENTRY!"
		lb_Allow = This.of_HasEntryRights ( )

	CASE "AUDIT!"
		lb_Allow = This.of_HasAuditRights ( )

	CASE "ADMIN!"
		lb_Allow = This.of_HasAdministrativeRights ( )

	CASE "PTADMIN!"
		lb_Allow = This.of_HasSysAdminRights ( )

	CASE "NONE!"
		//Do not allow

	CASE ELSE
		//Unexpected value.
		//Do not allow

	END CHOOSE

CASE 0
	//Value not specified  --  Use default policy.
	//lb_Allow = This.of_HasEntryRights ( )

	// we are not going to allow by default as of 4.0.11

CASE -1
	//Error
	//Do not allow

CASE ELSE
	//Unexpected return
	//Do not allow

END CHOOSE

RETURN lb_Allow
end function

public function boolean of_hasequipmentdeactivationrights ();//NOTE: Returns Null if value cannot be determined!

Boolean	lb_Allow
Any		la_Value
n_cst_Settings	lnv_Settings

lnv_Settings.of_GetSetting ( 94 , la_Value )


IF Len ( String ( la_Value ) )> 0 THEN
	
	
	CHOOSE CASE String ( la_Value )
	
	CASE "ALL!"
		lb_Allow = TRUE
	
	CASE "ENTRY!"
		IF This.of_HasEntryRights ( ) THEN
			lb_Allow = TRUE
		END IF
	
	CASE "ADMIN!"
		IF This.of_HasAdministrativeRights ( ) THEN
			lb_Allow = TRUE
		END IF
		
	CASE "AUDIT!"
		IF This.of_HasAuditRights ( ) THEN
			lb_Allow = TRUE
		END IF
	
	
	CASE ELSE
		SetNull ( lb_Allow )
	
	END CHOOSE

ELSE
	IF THIS.of_HasSysAdminRights ( ) THEN
		lb_Allow = TRUE
	END IF
END IF
	
RETURN lb_Allow
end function

public function boolean of_shipment_makenonrouted ();n_cst_Settings	lnv_Settings
Any	la_Value

Boolean	lb_Allow = FALSE

CHOOSE CASE lnv_Settings.of_GetSetting ( 130, la_Value )

CASE 1

	CHOOSE CASE String ( la_Value )

	CASE "ENTRY!"
		lb_Allow = This.of_HasEntryRights ( )

	CASE "AUDIT!"
		lb_Allow = This.of_HasAuditRights ( )

	CASE "ADMIN!"
		lb_Allow = This.of_HasAdministrativeRights ( )

	CASE "PTADMIN!"
		lb_Allow = This.of_HasSysAdminRights ( )

	CASE "NONE!"
		//Do not allow

	CASE ELSE
		//Unexpected value.
		//Do not allow

	END CHOOSE

CASE 0
	//Value not specified  --  Use default policy.
	lb_Allow = This.of_HasSysAdminRights ( )  //Default is to allow for PTADMIN only.

CASE -1
	//Error
	//Do not allow

CASE ELSE
	//Unexpected return
	//Do not allow

END CHOOSE

RETURN lb_Allow
end function

public function boolean of_hastirlfdrights ();//
/***************************************************************************************
NAME			: of_hasTIRLFDRights
ACCESS		: Public 
ARGUMENTS	: None
RETURNS		: Boolean 
DESCRIPTION	: checks for group rights to send TIR and Last Free Date notificaitons
					Returns Null if value cannot be determined
REVISION		: RDT 12-02-02
***************************************************************************************/
Boolean	lb_Allow
Any		la_Value
n_cst_Settings	lnv_Settings

lnv_Settings.of_GetSetting ( 134 , la_Value )


IF Len ( String ( la_Value ) )> 0 THEN
	
	
	CHOOSE CASE String ( la_Value )
	
	CASE "ALL!"
		lb_Allow = TRUE
	
	CASE "ENTRY!"
		IF This.of_HasEntryRights ( ) THEN
			lb_Allow = TRUE
		END IF
	
	CASE "ADMIN!"
		IF This.of_HasAdministrativeRights ( ) THEN
			lb_Allow = TRUE
		END IF
		
	CASE "AUDIT!"
		IF This.of_HasAuditRights ( ) THEN
			lb_Allow = TRUE
		END IF
	
	
	CASE ELSE
		SetNull ( lb_Allow )
	
	END CHOOSE

ELSE
	IF THIS.of_HasSysAdminRights ( ) THEN
		lb_Allow = TRUE
	END IF
END IF
	
RETURN lb_Allow


end function

public function boolean of_hasimagechangingrights ();
Boolean	lb_Allow
Any		la_Value
n_cst_Settings	lnv_Settings

lnv_Settings.of_GetSetting ( 148 , la_Value )


IF Len ( String ( la_Value ) )> 0 THEN
	
	
	CHOOSE CASE String ( la_Value )
	
	CASE "ALL!"
		lb_Allow = TRUE
	
	CASE "ENTRY!"
		IF This.of_HasEntryRights ( ) THEN
			lb_Allow = TRUE
		END IF
	
	CASE "ADMIN!"
		IF This.of_HasAdministrativeRights ( ) THEN
			lb_Allow = TRUE
		END IF
		
	CASE "AUDIT!"
		IF This.of_HasAuditRights ( ) THEN
			lb_Allow = TRUE
		END IF
		
	CASE "SYSADMIN!"
		IF THIS.of_HasSysAdminRights ( ) THEN
			lb_Allow = TRUE
		END IF
		
	END CHOOSE

ELSE
	IF THIS.of_HasAdministrativeRights ( ) THEN
		lb_Allow = TRUE
	END IF
END IF
	
RETURN lb_Allow


end function

public function boolean of_hassufficientrights (string as_neededlevel);Boolean	lb_Return




CHOOSE CASE UPPER ( as_neededlevel )
		
	CASE "ALL!" , "ALL"
		lb_Return = TRUE
	
	CASE "ENTRY!" , "ENTRY"
		lb_Return = This.of_HasEntryRights ( )

	CASE "AUDIT!" , "AUDIT"
		lb_Return = This.of_HasAuditRights ( )

	CASE "ADMIN!" , "ADMIN"
		lb_Return = This.of_HasAdministrativeRights ( )

	CASE "PTADMIN!" , "PTADMIN"
		lb_Return = This.of_HasSysAdminRights ( )
		
		
	CASE "ADMIN/AUDIT" , "ADMIN/AUDIT!" , "ADMIN / AUDIT" , "ADMIN / AUDIT!" , "AUDIT / ADMIN"
		lb_Return = THIS.of_Hasadministrativerights( ) OR THIS.of_HasAuditRights ( )
		
		
		
	CASE ELSE
		
		
END CHOOSE


RETURN lb_Return


end function

public function boolean of_dynamic_administration ();Boolean	lb_Allow

lb_Allow = This.of_HasSysAdminRights ( )

RETURN lb_Allow
end function

public function boolean of_dynamic_createinstance ();Boolean lb_Allow

lb_Allow = This.of_Dynamic_Administration( )

RETURN lb_Allow
end function

public function boolean of_dynamic_createabstract ();Boolean lb_Allow

lb_Allow = This.of_Dynamic_Administration( )

RETURN lb_Allow
end function

public function boolean of_dynamic_deleteabstract ();Boolean lb_Allow

lb_Allow = This.of_Dynamic_Administration( )

RETURN lb_Allow
end function

public function boolean of_dynamic_createlinkdefinition ();Boolean lb_Allow

lb_Allow = This.of_Dynamic_Administration( )

RETURN lb_Allow
end function

public function boolean of_dynamic_createmouseover ();Boolean lb_Allow

lb_Allow = This.of_Dynamic_Administration( )

RETURN lb_Allow
end function

public function boolean of_dynamic_applylinks ();Boolean lb_Allow

lb_Allow = This.of_Dynamic_Administration( )

RETURN lb_Allow 
end function

public function boolean of_dynamic_changeproperties ();Boolean lb_Allow

lb_Allow = This.of_Dynamic_Administration( )

RETURN lb_Allow
end function

on n_cst_privileges.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_privileges.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

