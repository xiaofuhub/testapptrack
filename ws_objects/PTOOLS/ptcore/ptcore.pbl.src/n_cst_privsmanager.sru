$PBExportHeader$n_cst_privsmanager.sru
forward
global type n_cst_privsmanager from n_cst_bso
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//Boolean	sb_UseAdvancedPrivs
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_privsmanager from n_cst_bso
end type
global n_cst_privsmanager n_cst_privsmanager

type variables
private	window				iw_privInterface
private 	n_ds					ids_UserClass
Private	n_ds					ids_FunctionOverride

private 	n_cst_privDetails 	inva_lattestChanges[]


Public:
//
//constant string	cs_Admin = "Admin"
//constant string	cs_Audit = "Audit"
//constant string	cs_lookup = "Lookup"
//constant string	cs_Entry	= "Entry"

Constant Long	cl_Admin = 1005
Constant Long	cl_Audit = 1004
Constant Long	cl_Entry = 1003
Constant Long	cl_Lookup = 1002
Constant Long	cl_None	= 1001


Constant String	cs_AllModules = "All"
Constant Long		cl_AllDivisions	= 1//2203

Constant String	cs_Collection = "n_cst_privdetails_collection"

//return codes
Constant INT	ci_true = 1
Constant Int	ci_false = 0
Constant Int	ci_error = -1
Constant Int	ci_undefinedFunction = -2

//Function Constants
	//rates
	constant	string	cs_ModifyRateTable = "Modify Rate Table"
	
	//imaging
	CONSTANT STRING 	cs_DeleteImage = "Delete Image"
	CONSTANT STRING 	cs_ModifyImage = "Modify Image"
	CONSTANT STRING 	cs_SCANImage	= "Scan Image"
	
	//Dispatch	
	CONSTANT STRING	cs_ModifyShipment = "ModifyShipment"
	CONSTANT STRING	cs_viewCharges	="View Charges"
	CONSTANT STRING	cs_ModifyBilledShip = "Modify Billed Shipments"					//added 2-7-07
	CONSTANT STRING	cs_ModifyBilledShipRates = "Modify Billed Shipment Rates"	//added 2-7-07
	
	//Billing
	CONSTANT STRING	cs_BillShipment = "Bill Shipment"
	CONSTANT STRING	cs_ViewBilling	= "View Billing Window"
	
	//Settlements
	CONSTANT STRING	cs_ModifyGlobalPayable = "Modify Global Templates"
	CONSTANT STRING	cs_ModifyEmployeePayable = "Modify Employee Payables"
	CONSTANT STRING	cs_SettleDrivers = "Settle Drivers"
	
	//Logs
	CONSTANT STRING	cs_ModifyDriverLog = "Modify Driver Log"
	CONSTANT STRING	cs_ViewLogReports = "View Log Reports"
	// employees
	CONSTANT STRING   cs_ViewEmployee = "View Employee"
	CONSTANT STRING	cs_ModifyEmployee = "Modify Employee"

//begin modification Shared Variables by appeon  20070730
Boolean	sb_UseAdvancedPrivs
//end modification Shared Variables by appeon  20070730
	
end variables

forward prototypes
public function integer of_getmodules (ref string asa_modules[])
public function integer of_setinterface (window aw_interface)
public function integer of_save ()
private function long of_getprivid (long al_userid, string as_module, long al_division)
public function integer of_getdivisions (ref datastore ads_divisions)
public function integer of_changeprivs (n_cst_privdetails anv_privdetail)
private function integer of_discardfunctionoverrides (long al_privid)
private function long of_getdefaultuserclass (long al_userid)
public function integer of_getfunctionoverridecache (integer al_privid, ref n_ds ads_fnoverrides)
public function integer of_getlattestchanges (ref n_cst_privdetails anva_privchanges[])
public function n_cst_privdetails of_getdetails (long al_user, string as_module, long al_division, boolean ab_initializecollection)
public function n_cst_privdetails of_getdetails (long al_userid, string as_module, long al_division)
public function integer of_detailchanged (n_cst_privdetails anv_privdetail, integer al_modfnid, string as_data)
private function integer of_updateuserclassrole (ref long al_privid, string as_module, long al_division, long al_userid, long al_role)
private function boolean of_privdefaulted (long al_privid, long al_userid, long al_newrole)
public function n_cst_privDetails of_getuserprivs (long al_division, string as_module)
public function n_cst_privdetails of_getuserprivs (string as_functionid, long al_divisionid)
public function string of_getmodulefromfunction (string as_function)
public function n_cst_privdetails of_getuserprivs (string as_module)
private function integer of_addnewpriv (ref long al_privid, long al_userid, string as_module, long al_division, long al_role)
private function integer of_deletefunctionoverrides (long al_privid)
public function long of_getuserclassrole (long al_privid, long al_userid)
private function integer of_informinterface ()
public function boolean of_updatespending ()
private function n_cst_privdetails of_getuserprivsfromfn (string as_function)
public function integer of_adderror (string as_error)
public function integer of_getuserpermissionfromfn (string as_function)
public function integer of_getuserpermissionfromfn (string as_function, long al_division)
public function integer of_getuserpermissionfromfn (string as_function, pt_n_cst_beo anv_beo)
public function integer of_hasminimumrequiredroll (string as_function)
public function integer of_clearlattestchanges ()
public function integer of_copyuserprivs (long al_userid, long al_division, string as_module, long al_touserid, long al_todiv)
public function boolean of_useadvancedprivs ()
public function boolean of_setusedadvancedprivs ()
private function boolean of_includemodule (string as_module)
end prototypes

public function integer of_getmodules (ref string asa_modules[]);//Passes out an array of modules in the order you want them to appear from top to bottom.
//Returns number of modules if sucess, -1 if faliure
Integer 	li_return
Long		i, ll_ModCount, ll_FoundAll
String	lsa_modules[]

DataStore	lds_ModLicenses

lds_ModLicenses = Create DataStore
lds_ModLicenses.DataObject = "d_modulelicenses"
lds_ModLicenses.SetTransObject(SQLCA)

IF lds_ModLicenses.Retrieve() >= 0 THEN
	
	lsa_modules[1] = cs_AllModules
	
	lds_ModLicenses.setSort( "module A" )
	lds_modLicenses.sort( )
	
	ll_ModCount = lds_ModLicenses.RowCount()
	FOR i = 1 TO ll_ModCount
		//this checks to see if the module is one that we are suppose to include.
		IF this.of_includemodule( lds_ModLicenses.Object.module[i] ) THEN
			lsa_Modules[upperBound(lsa_modules) + 1] = lds_ModLicenses.Object.module[i]
		END IF
	NEXT
	
	
	//add in the categories that are not linkable to modules.
	lsa_Modules[upperBound(lsa_modules) + 1] = "Employees"
		

	
	asa_modules = lsa_modules
	
	li_Return = UpperBound(asa_Modules)

ELSE
	li_Return = -1
END IF





Destroy lds_ModLicenses

return li_return
end function

public function integer of_setinterface (window aw_interface);//This sets the interface to the visual window that will react to changes made on 
//the priv cache

int li_return

IF isValid( aw_interface ) THEN
	this.iw_privInterface = aw_interface
	li_return  = 1
ELSE
	li_return = -1
END IF

RETURN li_Return
end function

public function integer of_save ();//this function saves the privelage cache with all the changes.
Int	 li_return
Int	 li_Update

li_Update = ids_UserClass.Update()
IF li_Update = 1 THEN
	Commit;
	li_Return = 1
ELSE
	li_Return = -1
	this.of_addERROR( "ERROR: Failed to update database table 'PrivUserClass'." )
	Rollback;
END IF

IF li_Return = 1 THEN
	
	li_Update = ids_FunctionOverride.Update()
	
	IF li_Update = 1 THEN
		Commit;
	ELSE
		this.of_addERROR( "ERROR: Failed to update database table 'PrivFunctionOverride'." )
		li_Return = -1
		Rollback;
	END IF
	
END IF


Return li_Return


end function

private function long of_getprivid (long al_userid, string as_module, long al_division);String	ls_FindString
String	ls_Module
Long		i
Long		ll_Max
Long		ll_FoundRow
Long		ll_FoundDelRow
Long		ll_PrivId
Long		ll_Retrieve
Long		ll_Rowcount
Long		ll_UserId
Long		ll_Division

ls_FindString = "userid = " + String(al_userid) + " AND module = '" + as_module + &
					 "' AND division = " + String(al_division)
					 
ll_FoundRow = ids_UserClass.Find( ls_FindString, 1, ids_UserClass.RowCount())

//Search Delete buffer for this priv
ll_Max = ids_Userclass.DeletedCount()
FOR i = 1 TO ll_Max
	ll_Userid = ids_UserClass.Object.userid.Delete[i]
	ls_Module = ids_UserClass.Object.module.Delete[i]
	ll_Division = ids_UserClass.Object.division.Delete[i]
	IF ll_UserId = al_UserId AND ls_Module = as_Module AND ll_Division = al_Division THEN
		ll_FoundDelRow = i
		EXIT
	END IF
NEXT

IF ll_FoundRow > 0 THEN
	ll_PrivId = ids_UserClass.Object.privid[ll_FoundRow]
ELSE
	//If the priv is not in the delete buffer, then retrieve
	IF ll_FoundDelRow = 0 THEN
		ll_RowCount = ids_UserClass.RowCount()
		ll_Retrieve = ids_UserClass.Retrieve(al_userid, as_module, al_division)
		Commit;
	END IF
	
	IF ll_Retrieve > ll_RowCount THEN
		ll_PrivId = ids_UserClass.Object.privid[ids_UserClass.RowCount()]
		
		//IF sucessfully retrieved privilege, make sure overrides are in cache
		ls_FindString = "privid = " + String(ll_privid)
		ll_FoundRow = ids_FunctionOverride.Find( ls_FindString, 1, ids_FunctionOverride.RowCount())
		IF ll_FoundRow <= 0 THEN
			ll_Retrieve = ids_FunctionOverride.Retrieve(ll_PrivId)
			Commit;
		END IF		
				
	ELSE //Not in database so priv id will get set upon deviation
		ll_PrivId = 0
	END IF
END IF


Return ll_PrivId
end function

public function integer of_getdivisions (ref datastore ads_divisions);//Passes an array of divisions in the order you want them to appear from left to right.
//Returns number of divisions if success, -1 failure
 
Int   li_Return
Long  i
Long  lla_Divisions[]
Long  ll_Division
 
Long  ll_DivCount
 
n_cst_String  lnv_String
n_cst_Ship_Type lnv_ShipType
datastore   lds_divisions
 
IF lnv_Shiptype.of_Ready(True) THEN
 
 lds_divisions = create Datastore
 
 lds_divisions.dataobject = gds_shiptype.dataObject
 lds_Divisions.SetTransObject( SQLCA )
 
 ll_DivCount = gds_shiptype.rowCount()
 
 FOR i = 1 TO ll_DivCount
  IF gds_Shiptype.Object.st_Status[i] = 'K' THEN
   gds_shiptype.rowsCopy( i, i, PRIMARY!, lds_divisions, 1, PRIMARY!)
  END IF
 NEXT
 
 lds_divisions.setSort( "st_name A" )
 lds_divisions.sort()
 
 ll_DivCount = lds_Divisions.RowCount()
 li_Return = ll_DivCount
 
 ads_divisions = lds_divisions
 
ELSE
 li_Return = -1
END IF
 
 
 
Return li_Return
end function

public function integer of_changeprivs (n_cst_privdetails anv_privdetail);//This function resolves all the necessary data from the nonvisual passed in, and attempts to update
//the cache values.
Integer	li_Return = -1
Integer	li_Role
String	ls_Module
Long		i
Long		ll_PrivId
Long		ll_Division
Long		ll_UserId
Long		ll_NumDetails
Long		ll_NewRole

n_cst_PrivDetails		lnva_Collection[]
n_cst_PrivDetails		lnv_CurrentDetail
n_cst_privDetails_collection lnv_collection

n_cst_privDetails 	lnv_Changes[]


IF isValid(anv_PrivDetail) THEN

	IF anv_PrivDetail.ClassName() = cs_Collection THEN
		lnv_collection = anv_PrivDetail
		lnv_collection.of_GetCollection( lnva_Collection )
		ll_NewRole = lnv_Collection.of_GetRole()
		ll_NumDetails = Upperbound(lnva_Collection[])
		FOR i = 1 TO ll_NumDetails
			lnv_CurrentDetail = lnva_Collection[i]
			//All new Details should be set to collection object new role
			lnv_CurrentDetail.of_SetRole( ll_NewRole )
			ll_PrivId = lnv_CurrentDetail.of_GetPrivId()
			ll_UserId = lnv_CurrentDetail.of_GetUserId()
			ls_Module = lnv_CurrentDetail.of_GetModule()
			ll_Division = lnv_CurrentDetail.of_GetDivision()
			IF This.of_UpdateUserClassRole(ll_Privid, ls_Module, ll_Division,  ll_Userid, ll_NewRole) = 1 THEN
				li_Return = 1
			ELSE 
				li_Return = -1
				EXIT
			END IF
			lnv_currentDetail.of_setPrivid( ll_privId )
		NEXT
	END IF
	
	

	ll_PrivId = anv_PrivDetail.of_GetPrivId()
	ls_Module = anv_PrivDetail.of_GetModule()
	ll_Division = anv_PrivDetail.of_GetDivision()
	ll_UserId = anv_PrivDetail.of_GetUserId()
	ll_NewRole = anv_PrivDetail.of_GetRole()
	IF This.of_UpdateUserClassRole(ll_Privid, ls_Module, ll_Division, ll_UserId, ll_NewRole) = 1 THEN
		li_Return = 1
		anv_privDetail.of_setPrivId( ll_privId )
	ELSE 
		li_Return = -1
	END IF


	IF li_Return = 1 THEN
		lnv_Changes[Upperbound(lnv_Changes)+1] = anv_PrivDetail
		inva_lattestChanges[] = lnv_Changes
		
		
		IF isValid( iw_privinterface ) THEN
			iw_privinterface.triggerEvent("ue_getLatestChanges")
		END IF
		
	END IF

ELSE
	li_Return = -1
END IF


Return li_Return
end function

private function integer of_discardfunctionoverrides (long al_privid);//Returns number of fucntions discarded

Integer	li_Return
Long	i
Long	ll_FnOverrideCount 
Long	ll_FnOverrideDelCount

ll_FnOverrideCount = ids_FunctionOverride.RowCount()
ll_FnOverrideDelCount = ids_FunctionOverride.DeletedCount()

//Discard Rows from Primary buffer
FOR i = ll_FnOverrideCount TO 1 STEP -1
	IF ids_FunctionOverride.Object.privid[i] = al_privid THEN
		IF ids_FunctionOverride.Rowsdiscard( i, i, Primary!) = 1 THEN
			li_Return ++
		END IF
	END IF
NEXT

//Discard Rows from Delete Buffer
FOR i = ll_FnOverrideDelCount TO 1 STEP -1
	IF ids_FunctionOverride.Object.privid.Delete[i] = al_privid THEN
		IF ids_FunctionOverride.RowsDiscard(i, i, Delete!) = 1 THEN
			li_Return ++
		END IF
	END IF
NEXT

Return li_Return
end function

private function long of_getdefaultuserclass (long al_userid);Long		ll_Return
Long		ll_Default
Integer	li_SqlCode


Select em_Class
Into	:ll_Default
From	employees
Where em_id = :al_UserId;

Commit;

li_SqlCode = SQLCA.SqlCode

ll_Return = ll_Default


IF li_SqlCode =  100 THEN//Value not defined
	ll_Return = 0
ELSEIF li_SqlCode = -1 THEN
	ll_Return = -1
END IF


Return ll_Return
end function

public function integer of_getfunctionoverridecache (integer al_privid, ref n_ds ads_fnoverrides);Integer	li_Return = 1
String	ls_FindString
Long		ll_FoundRow
Long		ll_PrivId

n_ds	lds_FnOverrides


IF li_Return = 1 THEN
	lds_FnOverrides = Create n_ds
	lds_FnOverrides.DataObject = ids_FunctionOverride.DataObject
	lds_FnOverrides.SetTransObject(SQLCA)
	
	IF ids_FunctionOverride.Rowscopy( 1, ids_FunctionOverride.RowCount(), Primary!, lds_FnOverrides, 1, Primary!) = 1 THEN
		lds_FnOverrides.SetFilter("privid = " + String(al_privid))
		lds_FnOverrides.Filter()
		lds_FnOverrides.RowsDiscard(1, lds_FnOverrides.FilteredCount(), Filter!)
	END IF

END IF

ads_FnOverrides = lds_FnOverrides

Return li_Return


end function

public function integer of_getlattestchanges (ref n_cst_privdetails anva_privchanges[]);//This function is completed, it gets the last group of nonvisual objects that were created
//as a result of the last change made to the cache by the function called of_changePrivs.
//Returns the number of nonvisuals passed back.
Long	i
Long	j
Long	ll_DetailCount
Long	ll_ChangeCount
N_cst_privDetails_collection	lnv_collection
N_cst_privDetails	lnva_collection[]

ll_ChangeCount = UpperBound(inva_lattestChanges)
FOR i = 1 TO ll_ChangeCount
	IF isValid(inva_lattestChanges[i]) THEN
		IF inva_lattestChanges[i].classname() = this.cs_Collection THEN
			lnv_collection = inva_lattestChanges[i]
			ll_detailCount = lnv_collection.of_getCollection( lnva_collection )
			FOR j= 1 TO ll_detailCount
				anva_privchanges[upperBound( anva_privchanges )+1] =  lnva_collection[j]
			NEXT

		END IF
		anva_privchanges[upperBound( anva_privchanges )+1] = inva_lattestChanges[i]
	END IF
NEXT

RETURN upperBound( anva_privchanges )
end function

public function n_cst_privdetails of_getdetails (long al_user, string as_module, long al_division, boolean ab_initializecollection);//The following function should return an instance of n_cst_privDetails based on the
//al_user, as_module, and as_division passed in.  
Long		ll_FindRow
Long		ll_PrivId
Long		ll_role

n_cst_privDetails		lnv_Detail

IF as_Module = cs_AllModules OR al_Division = cl_AllDivisions THEN
	lnv_Detail = Create Using "n_cst_privdetails_" + "collection"
	lnv_Detail.of_SetModule( as_Module )
ELSE
	lnv_Detail = Create Using "n_cst_PrivDetails_" + as_Module
END IF

ll_PrivId = This.of_Getprivid( al_User, as_module, al_division)
//Role is either cached or defaulted to default role
ll_Role = This.of_GetuserClassRole( ll_privid, al_user )
lnv_Detail.of_SetPrivId( ll_Privid )
lnv_Detail.of_SetRole( ll_Role )
lnv_Detail.of_SetUser( al_user )
lnv_Detail.of_SetDivision( al_Division )
lnv_Detail.of_SetPrivManager( This )

IF ab_InitializeCollection THEN
	lnv_Detail.TriggerEvent("ue_InitializeCollection")
END IF

Return lnv_Detail
end function

public function n_cst_privdetails of_getdetails (long al_userid, string as_module, long al_division);Return This.of_GetDetails( al_Userid, as_Module, al_division, TRUE )

end function

public function integer of_detailchanged (n_cst_privdetails anv_privdetail, integer al_modfnid, string as_data);Integer	li_Return
String	ls_FindString
String	ls_Module
String	ls_Authorized
Long		ll_Foundrow
Long		ll_FoundUserClassRow
Long		ll_Row
Long		ll_PrivId
Long		ll_Division
Long		ll_Role
Long		ll_UserId
Boolean	lb_DefaultPriv



ll_PrivId = anv_PrivDetail.of_GetPrivId()
ll_Division	 = anv_PrivDetail.of_GetDivision()
ls_Module = anv_PrivDetail.of_GetModule()
ll_Role = anv_PrivDetail.of_GetRole()
ll_UserId = anv_PrivDetail.of_GetUserId()


////Check if user priv exists in cache yet
ll_FoundUserClassRow = ids_UserClass.Find("privid = " + String(ll_PrivId), 1, ids_Userclass.RowCount())

//IF priv already in cache, then ll_PrivId already exists, otherwise 
// of_addnewpriv will give it a new priv id
IF ll_FoundUserClassRow <= 0 THEN
	This.of_AddNewpriv( ll_PrivId, ll_UserId, ls_Module, ll_Division, ll_Role )
	anv_privDetail.of_setPrivId( ll_privId )
END IF


ls_FindString = "privid = " + String(ll_privid) + " AND modfnid = " + String(al_modfnid)
ll_FoundRow = ids_FunctionOverride.Find(ls_FindString, 0, ids_FunctionOverride.RowCount())

IF ll_FoundRow > 0 THEN
	ls_Authorized = ids_FunctionOverride.Object.authorized[ll_FoundRow]
	IF ls_Authorized <> as_Data THEN
		//IF lb_DefaultRole THEN
			
		ids_FunctionOverride.DeleteRow(ll_FoundRow)
		lb_DefaultPriv = This.of_PrivDefaulted(ll_PrivId, ll_UserId, ll_Role)
		
		IF lb_DefaultPriv THEN //Remove row from user class role cache
			IF ll_FoundUserClassRow > 0 THEN
				ids_UserClass.DeleteRow(ll_FoundUserClassRow)
				This.of_DisCardFunctionOverrides( ll_PrivId )
			END IF
		END IF
		
	END IF
ELSE
	ll_Row = ids_FunctionOverride.InsertRow(0)
	ids_FunctionOverride.Object.privid[ll_Row] = ll_PrivId
	ids_FunctionOverride.Object.modfnid[ll_Row] = al_ModFnId
	ids_FunctionOverride.Object.authorized[ll_Row] = as_Data
END IF

inva_lattestchanges[UpperBound(inva_lattestchanges) + 1] = anv_PrivDetail

IF isValid(iw_privInterface) THEN
	iw_privInterface.TriggerEvent("ue_getlatestchanges")
END IF

return li_Return

end function

private function integer of_updateuserclassrole (ref long al_privid, string as_module, long al_division, long al_userid, long al_role);Integer	li_Return = 1
Long		i
Long		ll_FoundRow
Long		ll_NewRow
Long		ll_FnOverrideCount
Long		ll_DefaultRole
Long		ll_NewPrivId

long		ll_del

IF as_module <> cs_allmodules THEN
	ll_FoundRow = ids_UserClass.Find("privid = " + String(al_PrivId), 1, ids_Userclass.RowCount())
	//If already in cache...
	IF ll_FoundRow > 0 THEN
		ll_DefaultRole = This.of_GetDefaultUserClass(al_UserId)
		//IF the new role does not deviate from default user class, then we dont want to store it
		IF ll_DefaultRole = al_role THEN
			ll_Del = ids_UserClass.DeleteRow(ll_FoundRow)
			This.of_DiscardFunctionOverrides( al_PrivId )
		
		ELSE //If it does diviate from default user class, then we change the value and 
				//Delete old function overrdies for that privid
			ids_UserClass.Object.role[ll_FoundRow] = al_role
			This.of_DeleteFunctionOverrides( al_PrivId )
			
		END IF
		
	//IF not in cache, its a brand new priv so insert row	
	ELSE //Insert new privilege
		If al_role <> this.of_GetDefaultUserClass( al_userId ) THEN
			This.of_AddNewPriv( al_PrivId, al_Userid, as_Module, al_Division, al_Role )
		END IF
	END IF
END IF

Return li_Return
end function

private function boolean of_privdefaulted (long al_privid, long al_userid, long al_newrole);//Returns True if privilege has been set back to its default value
//Returns Falase if privilege is still deviated from default
Boolean	lb_Defaulted
Long		ll_OverrideCount


IF al_NewRole = This.of_GetDefaultuserclass( al_UserId ) THEN
	lb_Defaulted = True
END IF

IF lb_Defaulted Then
	ids_functionoverride.SetFilter("privid = " + String(al_PrivId))
	ids_functionoverride.Filter()
	ll_OverrideCount = ids_functionoverride.RowCount()
	//Unfilter
	ids_functionoverride.Setfilter("")
	ids_functionoverride.Filter()
END IF

//IF The role has defaulted and there are no other fn overrides, return true
Return lb_Defaulted AND ll_OverrideCount <= 0



end function

public function n_cst_privDetails of_getuserprivs (long al_division, string as_module);Long	ll_userid 

ll_userId = gnv_app.of_getNumericuserid( )
RETURN this.of_getDetails( ll_userId, as_module, al_division)
end function

public function n_cst_privdetails of_getuserprivs (string as_functionid, long al_divisionid);//returns a lightweight nonvisual detail representing the module and division according to
//the function id passed in and current user.

n_cst_privDetails lnv_temp
String	ls_module

//must get the module for the corresponding function from the PrivModuleFunction table
ls_module = this.of_getmodulefromfunction( as_functionId )
IF len( ls_module ) > 0 THEN
	lnv_temp = this.of_getUserPrivs( al_divisionId, ls_module )
END IF

RETURN lnv_temp
end function

public function string of_getmodulefromfunction (string as_function);String	ls_module
String	ls_function

ls_function = as_function

  SELECT "privmodulefunction"."module" 
    INTO :ls_module
    FROM "privmodulefunction"  
   WHERE "privmodulefunction"."function" = :as_function
           ;
COMMIT;

RETURN ls_module
end function

public function n_cst_privdetails of_getuserprivs (string as_module);//RETURNS a collection object that represents all divisions.

RETURN this.of_getUserPrivs( this.cl_allDivisions, as_module )
end function

private function integer of_addnewpriv (ref long al_privid, long al_userid, string as_module, long al_division, long al_role);Long	ll_NewRow

ll_NewRow = ids_UserClass.InsertRow(0)

IF al_privid = 0 THEN //role has not deviated
	gnv_App.of_GetNextId( "PrivId", al_PrivId, TRUE)
END IF

ids_UserClass.Object.privid[ll_NewRow] = al_PrivId
ids_UserClass.Object.userid[ll_NewRow] = al_userid
ids_UserClass.Object.module[ll_NewRow] = as_module	
ids_UserClass.Object.division[ll_NewRow] = al_division
ids_UserClass.Object.role[ll_NewRow] = al_role

Return ll_NewRow
end function

private function integer of_deletefunctionoverrides (long al_privid);//Returns number of fucntions deleted

Integer	li_Return
Long	i
Long	ll_FnOverrideCount 

ll_FnOverrideCount = ids_FunctionOverride.RowCount()

FOR i = ll_FnOverrideCount TO 1 STEP -1
	IF ids_FunctionOverride.Object.privid[i] = al_privid THEN
		IF ids_FunctionOverride.DeleteRow(i) = 1 THEN
			li_Return ++
		END IF
	END IF
NEXT

Return li_Return
end function

public function long of_getuserclassrole (long al_privid, long al_userid);Long		ll_FoundRow
Long		ll_Role

ll_FoundRow = ids_UserClass.Find("privid = " + String(al_privid), 1, ids_UserClass.RowCount())
IF ll_FoundRow > 0 THEN
	ll_Role = ids_UserClass.Object.role[ll_FoundRow]
ELSE
	ll_Role = This.of_GetDefaultUserClass(al_UserId)
END IF

Return ll_Role
end function

private function integer of_informinterface ();//This function informs the interface that there are latest changes.
INT li_return = 1

IF isValid( iw_privInterface ) THEN
	//if ue_getLatestChanges, if it exists on the window can make a call to
	//its privManager (this), and request the list of nonvisual objects that
	//represent the divisions, and modules that can be updated.  of_getChanges( n_cst_privDetails [])
	iw_privInterface.triggerEvent( "ue_getLatestChanges" )
	
ELSE
	li_return = -1
END IF

RETURN li_return
end function

public function boolean of_updatespending ();Return ids_UserClass.of_Updatespending( ) = 1 OR ids_FunctionOverride.of_UpdatesPending() = 1



end function

private function n_cst_privdetails of_getuserprivsfromfn (string as_function);//returns a collection object that represents all divisions

String	ls_module

ls_module = this.of_getmodulefromfunction( as_function )

return this.of_getuserprivs( ls_module )
end function

public function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )

RETURN 1
end function

public function integer of_getuserpermissionfromfn (string as_function);//the following function will return 1 if the user has permission to do a specific function
//0 if they do not have permission, -1 if there is an error or -2 if the setting is off
//and the function passed in is not defined....A messagebox is popped up when negative 2 is the result

/////NOTE:  this should only be called if you are looking for permission to do something
//          that is irrelevent to a specific division.  This function will check 
//				all divisions that are returned as part of this collection, which should
//				all be the same.  If they aren't, the function will add an error and return false.

n_cst_privDetails lnv_temp
n_cst_privDetails_collection	lnv_collection
n_cst_privDetails lnv_priv
n_cst_privileges	lnv_privManager
n_cst_privDetails lnva_array[]

long	ll_index
Long	ll_max
int  	li_return
int	li_firstValue
Long		ll_userId


IF sb_UseAdvancedPrivs THEN


	lnv_temp = this.of_getuserprivsfromfn( as_function )
	
	//garantee its a collection, but just to be safe
	IF isValid( lnv_temp ) AND lnv_temp.className() = cs_collection THEN
		lnv_collection = lnv_temp
		lnv_collection.of_getCollection( lnva_array )
		
		ll_max = upperBOund( lnva_array )
		FOR ll_Index = 1 To ll_max
			IF ll_index = 1 THEN
				IF lnva_array[ll_index].of_getUserPermissionbyFunction( as_function ) THEN
					li_firstValue = ci_true
				ELSE
					li_FirstValue = ci_false
				END IF
			END IF
			
			IF lnva_array[ll_index].of_getUserPermissionbyFunction( as_function ) THEN
				li_return = ci_true
			ELSE
				li_return  = ci_false
			END IF
			
			//this is the check to make sure that all are the same, if at any point they are
			//not the same than there is an error with the privileges for all divisions.
			IF li_return <> li_firstValue THEN
				//add an error ........
				ll_userId = lnva_array[ll_index].of_getUserId()
				this.of_adderror( "ERROR: Privileges for the function '"+as_function+"' were inconsistant in the context of getting user permission for all divisions and function "+as_function+" for user "+ string(ll_userid) )
				li_return  = ci_error
				EXIT
			END IF
		NEXT
	ELSE
		this.of_adderror( "ERROR: Invalid module object returned for request 'All Divisions' function '"+as_function+"'" )
		li_return = -1
	END IF
ELSE
	//this maintains old functionality for the most part.  It gets the users role and
	//compares it to the minimum required role for a specific function...It will pop a 
	//messagebox if the function isn't valid.
	
	CHOOSE CASE this.of_getModulefromfunction( as_Function ) 
		CASE	"Imaging"
			//Because imaging had some system settings, if app isn't set up to use
			//the new advanced settings, we don't want it to do normal priv checking it does
			//for the rest of the modules.  We want it to behave like it did before.  From 
			//what I can tell, Scanningrights -> scan button on. 
			//						 auditRights -> deleting an image is ok
			//						 ImageChangingRights -> modifying of the image.
			CHOOSE CASE as_function
				CASE cs_scanimage
					IF lnv_privManager.of_hasScanningrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE cs_deleteimage
					IF lnv_privManager.of_hasAuditrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE cs_modifyimage
					IF lnv_privManager.of_hasimagechangingrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE ELSE
					li_return = ci_error
			END CHOOSE
		CASE ELSE
			//this is default functionallity for modules that didn't already have
			//predefined system settings for privileges and such.
			li_Return  = this.of_hasminimumrequiredroll( as_function)
	END CHOOSE
	
	
END IF

IF li_return = ci_undefinedFunction THEN
	MESSAGEBOX("Privilege ERROR", "The function '"+as_function+"' does not have a defined minimum required role in the database. Contact Profit Tools Tech Support.", EXCLAMATION!)
END IF

IF isValid( lnv_temp ) THEN
	DESTROY lnv_temp		//destroys the collection
END IF

RETURN li_return
end function

public function integer of_getuserpermissionfromfn (string as_function, long al_division);//should never be called with all_divisions as the id(1)
//Returns 1 if the user has permision to do the specified function for
//a specific division, 0 if they don't, -1 if an error occurred

n_cst_privDetails lnv_priv
n_Cst_privileges 	lnv_privManager

int  li_return
Boolean	lb_firstValue


IF sb_UseAdvancedPrivs THEN

	lnv_priv = this.of_getuserprivs( as_function, al_division )
	
	IF isValid( lnv_priv ) THEN
		IF lnv_priv.of_getuserpermissionbyfunction( as_function ) THEN
			li_return = ci_true
		ELSE
			li_return = ci_false
		END IF
	ELSE
		li_return = ci_error
		this.of_addError( "ERROR: Invalid privilege request of function '"+as_function+"' and division id "+ string( al_division ))
	END IF
ELSE
	CHOOSE CASE this.of_getModulefromfunction( as_Function ) 
		CASE	"Imaging"
			//Because imaging had some system settings, if app isn't set up to use
			//the new advanced settings, we don't want it to do normal priv checking it does
			//for the rest of the modules.  We want it to behave like it did before.  From 
			//what I can tell, Scanningrights -> scan button on. 
			//						 auditRights -> deleting an image is ok
			//						 ImageChangingRights -> modifying of the image.
			CHOOSE CASE as_function
				CASE cs_scanimage
					IF lnv_privManager.of_hasScanningrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE cs_deleteimage
					IF lnv_privManager.of_hasAuditrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE cs_modifyimage
					IF lnv_privManager.of_hasimagechangingrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE ELSE
					li_return = ci_error
			END CHOOSE
		CASE ELSE
			//this is default functionallity for modules that didn't already have
			//predefined system settings for privileges and such.
			li_Return  = this.of_hasminimumrequiredroll( as_function)
	END CHOOSE
	
END IF

IF li_return = ci_undefinedFunction THEN
	MESSAGEBOX("Privilege ERROR", "The function '"+as_function+"' does not have a defined minimum required role in the database. Contact Profit Tools Tech Support.", EXCLAMATION!)
END IF

IF isValid( lnv_priv ) THEN
	DESTROY lnv_priv
END IF
	

RETURN li_return
end function

public function integer of_getuserpermissionfromfn (string as_function, pt_n_cst_beo anv_beo);//returns a division specific permission for the user for a particular module and division
Int	 li_return
n_cst_privileges   lnv_privManager

IF sb_UseAdvancedPrivs THEN
	IF isValid( anv_beo ) THEN
		li_return = this.of_getUserPermissionFromFn( as_function, anv_beo.of_getDivisionId() )
		
		IF li_return = ci_error THEN
			this.of_addError( "ERROR: getting permission for function '"+as_function+"' "+ "division "+string(anv_beo.of_GetDivisionId())+" on beo "+ anv_beo.className()+"." )
		END IF
	ELSE
		this.of_adderror( "ERROR: invalid beo object passed in to of_getUserPermission("+as_function+ ", <beo> )."  )
		li_return = ci_error
	END IF
ELSE
	//resolve the minimum privilege level and find out if the user is globablly defined to 
	//have that priv...-old functionallity.  If the minimum privilege level is undefined..
	//and error message will be displayed.
	CHOOSE CASE this.of_getModulefromfunction( as_Function ) 
		CASE	"Imaging"
			//Because imaging had some system settings, if app isn't set up to use
			//the new advanced settings, we don't want it to do normal priv checking it does
			//for the rest of the modules.  We want it to behave like it did before.  From 
			//what I can tell, Scanningrights -> scan button on. 
			//						 auditRights -> deleting an image is ok
			//						 ImageChangingRights -> modifying of the image.
			CHOOSE CASE as_function
				CASE cs_scanimage
					IF lnv_privManager.of_hasScanningrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE cs_deleteimage
					IF lnv_privManager.of_hasAuditrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE cs_modifyimage
					IF lnv_privManager.of_hasimagechangingrights( ) THEN
						li_return = ci_true
					ELSE
						li_return = ci_false
					END IF
				CASE ELSE
					li_return = ci_error
			END CHOOSE
		CASE ELSE
			//this is default functionallity for modules that didn't already have
			//predefined system settings for privileges and such.
			li_Return  = this.of_hasminimumrequiredroll( as_function)
	END CHOOSE
END IF

IF li_return = ci_undefinedFunction THEN
	MESSAGEBOX("Privilege ERROR", "The function '"+as_function+"' does not have a defined minimum required role in the database. Contact Profit Tools Tech Support.", EXCLAMATION!)
END IF


RETURN li_return
end function

public function integer of_hasminimumrequiredroll (string as_function);//This function is here primarily to maintain old functionality.  It looks up
//the current users roll and looks up the minimum roll required for a function,
//and returns ci_true if they meat the minimum requirements.  Returns ci_false
//if they don't, and if the function is not definedit returns a ci_undefinedFunction



Int	li_return
Int	li_sqlcode
Long	ll_userId
Long	ll_currentUserClass
Long	ll_minimumRequiredRole

n_cst_privileges lnv_privs

///ADDED 2-9-07  Dan added this because PTADMIN is 1005 and so are all administrative employees.
//               THis means that it wasn't possible to have a privilege that only PTADMIN could
//					  Do or give someone the rights to do.  If the user logged in is PTADMIN then 
//						they should always have the minimum required roll
IF lnv_privs.of_hassysadminrights( ) THEN
	RETURN ci_true
END IF
////////////////////////////////////////////
ll_userId = gnv_app.of_getnumericuserid( )


ll_currentUserClass = this.of_getdefaultuserclass( ll_userID )

Select role
Into	:ll_minimumRequiredRole 
From	privModuleFUnction
Where "privModuleFUnction"."Function" = :as_function;

li_SqlCode = SQLCA.SqlCode

IF li_SqlCode =  100 THEN//not found
	li_Return = ci_undefinedFunction
	Commit;
ELSEIF li_SqlCode = -1 THEN		//Error; the statement failed
	li_Return = ci_undefinedFunction
	RollBack;
ELSE // 0 = success
	//valid nonnull value
	Commit;
	IF ll_currentUserClass >= ll_minimumRequiredRole THEN
		li_return = ci_true
	ELSE
		li_return = ci_false
	END IF
END IF

RETURN li_Return
end function

public function integer of_clearlattestchanges ();n_cst_privDetails 	lnva_Empty[]

inva_lattestChanges[] = lnva_Empty[]

Return 1
end function

public function integer of_copyuserprivs (long al_userid, long al_division, string as_module, long al_touserid, long al_todiv);//the following function will copy a specified users privileges to another users privileges. The
//interface doens't need to be informed because the specified user is the al_userId, which is
//already being displayed.

Int	li_return
Long	ll_role
Long	ll_index
Long	ll_max
Long	ll_rows
Long	ll_maxRows
String	ls_FromfnSetting
String	ls_toFnSetting
Long		ll_fnId

datastore	lds_fromfnOverrides
datastore	lds_tofnOverrides

n_cst_privDetails	lnv_fromUser
n_cst_privDetails lnv_toUser
n_cst_privDetails_collection	lnv_from
n_cst_privDetails_collection 	lnv_to
n_cst_privDetails lnva_fromCollection[]
n_cst_privDetails lnva_toCollection[]


lnv_fromUser = this.of_getDetails( al_userId, as_module, al_division)
lnv_toUser = this.of_getDetails( al_touserId, as_module, al_toDiv)

IF isValid( lnv_fromUser ) AND isValid ( lnv_toUser ) THEN
	li_return = 1
ELSE
	li_return = -1
END IF

IF li_return = 1 THEN

	//whether or not it is a collection we need to make this call so that the cell module division combo
	//is changed appropriately in the cache.
	ll_role =  lnv_fromUser.of_getrole( )
	lnv_toUser.of_changeRole( ll_role )
	
	lds_fromfnOverrides = lnv_fromUser.of_getDetails( )		//not really function overrides, its the displayable cache
	lds_tofnOverrides = lnv_toUser.of_getDetails()
	
	//copy from user a to user b the functional overrides, if they are different.
	//If they are different than make sure the change gets forwarded to the cache
	ll_max = lds_fromfnOverrides.rowCount()		
	FOR ll_index = 1 TO ll_max
		ls_fromfnSetting = lds_fromfnOverrides.getItemString( ll_index, "functionvalue" )
		ls_toFnSetting = lds_tofnOverrides.getItemString( ll_index, "functionvalue" )
		
		IF ls_fromfnSetting <> ls_toFnSetting THEN
			lds_tofnOverrides.setItem( ll_index, "functionvalue", ls_fromFnSetting )
			ll_fnid = lds_toFnOverrides.getItemnumber( ll_index, "modfnid" )
			this.of_DetailChanged(lnv_toUser, ll_FnId, ls_fromFnSetting )
		END IF
	NEXT



	//if one is a collection then they both are
	
	//if we have a collection, then we want to get its sub objects roles and
	//set the roles onto the corresponding sub object roles for the other object.
	IF lnv_fromUser.className() = cs_collection THEN
		lnv_from = lnv_fromUser
		lnv_to = lnv_toUser
		
		lnv_from.of_getCollection( lnva_fromCollection )
		lnv_to.of_getcollection( lnva_toCollection )	
		
		ll_max = upperBound( lnva_fromCollection )	
		
		//both arrays should be the same size and index values should represent
		//the same corresponding module division combo on each collection array.
		FOR ll_index = 1 TO ll_max
			ll_role = lnva_fromCollection[ll_index].of_getRole( )
			lnva_toCollection[ll_index].of_changeRole( ll_role )
			
			lds_fromfnOverrides = lnva_fromCollection[ll_index].of_getDetails( )		//not really function overrides, its the displayable cache
			lds_tofnOverrides = lnva_toCollection[ll_index].of_getDetails()
			
			//copy from user a to user b the functional overrides, if they are different.
			//If they are different than make sure the change gets forwarded to the cache
			ll_maxRows = lds_fromfnOverrides.rowCount()		//they should both be the same
			FOR ll_rows = 1 TO ll_maxRows
				ls_fromfnSetting = lds_fromfnOverrides.getItemString( ll_rows, "functionvalue" )
				ls_toFnSetting = lds_tofnOverrides.getItemString( ll_rows, "functionvalue" )
				
				IF ls_fromfnSetting <> ls_toFnSetting THEN
					lds_tofnOverrides.setItem( ll_rows, "functionvalue", ls_fromFnSetting )
					ll_fnid = lds_toFnOverrides.getItemnumber( ll_rows, "modfnid" )
					this.of_DetailChanged(lnva_toCollection[ll_index], ll_FnId, ls_fromFnSetting )
				END IF
			NEXT
			
		NEXT
	END IF
	
	Destroy lnv_fromUser
	Destroy lnv_toUser
END IF

RETURN li_return
end function

public function boolean of_useadvancedprivs ();return sb_useadvancedprivs
end function

public function boolean of_setusedadvancedprivs ();n_cst_setting_advancedprivs	lnv_setting
n_Cst_Privileges	lnv_Privs
//IF gnv_App.of_GetNumericuserid( ) = 10000

IF NOT lnv_Privs.of_hasSysadminrights( ) THEN
	lnv_setting	= CREATE n_cst_setting_advancedprivs
	sb_UseAdvancedPrivs = (lnv_setting.of_GetValue( ) = n_cst_setting_AdvancedPrivs.cs_Yes)
	Destroy	lnv_setting
ELSE
	sb_useadvancedprivs = FALSE
END IF

return sb_useadvancedPrivs
end function

private function boolean of_includemodule (string as_module);//returns true if the module is one that we are including, false otherwise
//should be updated everytime we want to include another module to have privileges for
Boolean lb_return
CHOOSE CASE as_module
	CASE n_cst_constants.cs_Module_Billing
		lb_return = true
	CASE n_cst_constants.cs_Module_Dispatch
		lb_return = true
	CASE n_cst_constants.cs_Module_Settlements
		lb_return = true
	CASE n_cst_constants.cs_Module_Imaging
		lb_return = true
	CASE n_cst_constants.cs_Module_AutoRating
		lb_return = true
	CASE n_cst_constants.cs_Module_LogAudit
		lb_return = true
		
	CASE "Employees"
		lb_return = TRUE
END CHOOSE
	
	
RETURN lb_return
end function

on n_cst_privsmanager.create
call super::create
end on

on n_cst_privsmanager.destroy
call super::destroy
end on

event constructor;//n_cst_setting_advancedprivs	lnv_setting
//n_Cst_Privileges	lnv_Privs
//IF NOT lnv_Privs.of_hasSysadminrights( ) THEN
//	lnv_setting	= CREATE n_cst_setting_advancedprivs
//	sb_UseAdvancedPrivs = (lnv_setting.of_GetValue( ) = n_cst_setting_AdvancedPrivs.cs_Yes)
//	Destroy	lnv_setting
//ELSE
//	sb_useadvancedprivs = FALSE
//END IF
this.of_setusedadvancedprivs( )

ids_UserClass = Create n_ds
ids_UserClass.DataObject = "d_PrivilegeUserClass"
ids_UserClass.SetTransObject(SQLCA)
ids_UserClass.of_SetAppend(True)

ids_FunctionOverride = Create n_ds
ids_FunctionOverride.DataObject = "d_PrivilegeFnOverride"
ids_FunctionOverride.SetTransObject(SQLCA)
ids_FunctionOverride.of_SetAppend(True)


end event

event destructor;Destroy ids_UserClass
Destroy ids_FunctionOverride
end event

