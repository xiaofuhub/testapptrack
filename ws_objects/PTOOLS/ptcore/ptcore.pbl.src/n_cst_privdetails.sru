$PBExportHeader$n_cst_privdetails.sru
forward
global type n_cst_privdetails from nonvisualobject
end type
end forward

global type n_cst_privdetails from nonvisualobject
end type
global n_cst_privdetails n_cst_privdetails

type variables
Protected:
Boolean	ib_hasSpecialPrivChecking			//this will be true on modules
														//that have special privilege
														//checking that should be used
														//when the system setting is set to
														//NOT use the advanced privileges.  Primarily
														//to maintain old functionality. N_cst_privDetails_imaging
														//is an example.

string	is_module

long il_userId

long		il_division
long		il_PrivId = 0
Long		il_role

Long		ila_nonDivisionBasedPrivs[]

DataStore	ids_PrivDetails

n_cst_privsManager inv_PrivManager




end variables

forward prototypes
public function datastore of_getdetails ()
public function integer of_detailchanged (dwobject adwo, long al_row, string as_data)
public function integer of_setprivmanager (n_cst_privsmanager anv_manager)
public function integer of_setuser (long al_userid)
public function long of_getuserid ()
public function string of_getmodule ()
public function integer of_setdivision (long al_division)
protected function string of_getdetaildataobject ()
public function boolean of_issuperclass ()
public function integer of_setprivid (long al_id)
public function long of_getprivid ()
public function long of_getdivision ()
public function integer of_getuserclass (ref long al_role, ref integer ai_override)
public function integer of_changerole (integer ai_role)
public function integer of_setrole (long al_role)
public function long of_getrole ()
public function integer of_setmodule (string as_module)
private function boolean of_issubclass ()
public function datastore of_getcurrentdetails ()
public function boolean of_hasnondivisionbasedprivs ()
public function boolean of_isnondivisionbasedpriv (long al_modfnid)
public function boolean of_getuserpermissionbyfunction (string as_function)
public function boolean of_hasspecialchecking ()
end prototypes

public function datastore of_getdetails ();//this will return a datastore that is set up for this objects corresponding Division and
//module.  The datastore should have the dataobject that is going to be displayed in dw_details.
//All of the data is expected to be set for the specific user.
Long		i
Long		ll_PrivId
Long		ll_Role
Long		ll_Max
Long		ll_DefaultRole
Long		ll_ModFnId
Long		ll_FindRow
Long		ll_Division
String	ls_Module
String	ls_Division
String	FindString
String	ls_Authorized
String	ls_FindString

n_cst_Ship_Type	lnv_ShipType

n_ds	lds_FnOverride

ll_PrivId = This.of_GetPrivId()
ll_Division = This.of_GetDivision()

ls_Module = This.of_GetModule()
ids_PrivDetails.Retrieve(ls_Module)

commit;


IF isValid(inv_PrivManager) THEN
	IF inv_PrivManager.of_GetFunctionOverrideCache( ll_PrivId, lds_FnOverride ) = 1 THEN
		ll_Role = inv_PrivManager.of_GetuserClassRole( ll_privId, il_userid )
		//Load Defaults
		ll_Max = ids_PrivDetails.Rowcount()
		
		FOR i = 1 TO ll_Max
			//Set Default
			ll_DefaultRole = ids_PrivDetails.Object.role[i]
			IF ll_Role >= ll_DefaultRole THEN
				ids_PrivDetails.SetItem(i, "functionvalue", "Y")
			ELSE
				ids_PrivDetails.SetItem(i, "functionvalue", "N")
			END IF
			//Set Overrides
			ll_ModFnId = ids_PrivDetails.Object.modfnid[i]
			ls_FindString = "privid = " + String(ll_Privid) + " AND modfnid = " + String(ll_ModFnID)
			ll_FindRow = lds_FnOverride.Find(ls_FindString, 0, lds_FnOverride.RowCount())
			IF ll_FindRow > 0 THEN
				ids_PrivDetails.SetItem(i, "functionvalue", lds_FnOverride.Object.authorized[ll_FindRow])
			END IF
		NEXT
		
		//this will set the division compute column in the detail header
		lnv_ShipType.of_getname( ll_Division, ls_Division)
		ids_PrivDetails.Object.division[1] = ls_Division
		
		Destroy	lds_FnOverride
	END iF
END IF

Return ids_PrivDetails
end function

public function integer of_detailchanged (dwobject adwo, long al_row, string as_data);Int	 li_return

Long	ll_PrivId
Long	ll_ModFnId

ids_PrivDetails.SetItem(al_row, "functionvalue", as_data)

//Priv Id may be zero at this point if not in cache already
ll_PrivId = This.of_GetPrivId()

//Shardata so get the current modfnid for this row
ll_ModFnId = ids_PrivDetails.Object.modfnid[al_row]


Return inv_PrivManager.of_DetailChanged(This, ll_ModFnId, as_data)
end function

public function integer of_setprivmanager (n_cst_privsmanager anv_manager);inv_PrivManager = anv_manager
return 1
end function

public function integer of_setuser (long al_userid);int li_return = 1

il_userId = al_userId

RETURN li_Return
end function

public function long of_getuserid ();LONG	ll_return
IF il_userId > 0 THEN
	ll_Return = il_userId
ELSE
	ll_return = -1
END IF
RETURN ll_return

end function

public function string of_getmodule ();//intended to be implemented on decendents
return is_module
end function

public function integer of_setdivision (long al_division);il_Division = al_Division

Return 1
end function

protected function string of_getdetaildataobject ();Return "d_privilegedetail"
end function

public function boolean of_issuperclass ();//returns true if the user has greater privs than the average user of this type
Boolean lb_return
Long		i
Long		ll_Count

n_ds		lds_Overrides

IF isValid( inv_PrivManager) THEN
	inv_PrivManager.of_GetFunctionOverrideCache( il_PrivId, lds_Overrides )
	IF isValid (lds_Overrides ) THEN
		ll_Count = lds_Overrides.Rowcount()
		FOR i = 1 TO ll_Count
			IF lds_Overrides.Object.Authorized[i] = "Y" THEN
				lb_Return = TRUE
				EXIT
			END IF
		NEXT
		
		Destroy lds_Overrides
	END IF

END IF

Return lb_return
end function

public function integer of_setprivid (long al_id);il_PrivId = al_id

Return 1
end function

public function long of_getprivid ();Return il_PrivId
end function

public function long of_getdivision ();//intended to be implemented on descendents
return il_division
end function

public function integer of_getuserclass (ref long al_role, ref integer ai_override);Long		ll_Role
Boolean	lb_SuperClass
Boolean	lb_SubClass

ll_Role = This.of_GetRole()

al_role = ll_Role

lb_SuperClass = This.of_isSuperClass()
lb_SubClass = This.of_isSubClass()

IF lb_SuperClass AND lb_SubClass THEN
	ai_Override = n_cst_Constants.ci_SuperSubClass
ELSEIF lb_SuperClass THEN
	ai_Override = n_cst_Constants.ci_SuperClass
ELSEIF lb_SubClass THEN
	ai_Override = n_cst_Constants.ci_SubClass
ELSE
	ai_Override = n_cst_Constants.ci_DefaultClass
END IF

Return 1
end function

public function integer of_changerole (integer ai_role);Integer	li_Return
Long	ll_PrivId

This.of_SetRole(ai_Role)

IF inv_Privmanager.of_ChangePrivs(This) = 1 THEN
	li_Return = 1
ELSE
	li_Return = -1
END IF

Return li_Return
end function

public function integer of_setrole (long al_role);il_role = al_role

Return 1
end function

public function long of_getrole ();return il_role
end function

public function integer of_setmodule (string as_module);//implemented at decendants

Return -1
end function

private function boolean of_issubclass ();//returns true if the user has lesser privs than the average user with this priv type
Boolean 	lb_return = FALSE
Long		i
Long		ll_Count

n_ds		lds_Overrides

IF isValid( inv_PrivManager) THEN
	inv_PrivManager.of_GetFunctionOverrideCache( il_PrivId, lds_Overrides )
	
	IF isValid (lds_Overrides ) THEN
		ll_Count = lds_Overrides.Rowcount()
		FOR i = 1 TO ll_Count
			IF lds_Overrides.Object.Authorized[i] = "N" THEN
				lb_Return = TRUE
				EXIT
			END IF
		NEXT
		
		Destroy lds_Overrides
	END IF

END IF

Return lb_Return
end function

public function datastore of_getcurrentdetails ();Return ids_PrivDetails
end function

public function boolean of_hasnondivisionbasedprivs ();//if a privDetail object has nonDivision based privs, the ancestor should set this
//initialize isa_nonDivisionBasedPrivs to contain all the functions that are non-division based.
//This returns true if there are any.
Long	ll_max
Long	ll_index
Boolean lb_return

ll_max =  ids_privdetails.rowCount() //upperBOund( ila_nondivisionbasedprivs )

FOR ll_index = 1 TO ll_max
	IF ids_privDetails.getItemString( ll_index, "type" ) = "N" THEN
		lb_return = true
		EXIT
	END IF
NEXT

RETURN lb_return
end function

public function boolean of_isnondivisionbasedpriv (long al_modfnid);// if the specified modfnId matches one that is listed in the array, then it returns true.
// They are initialized in the constructor of the module specific object
Long	ll_max
Long	ll_index
Boolean lb_return

ll_max =  ids_privdetails.rowCount() //upperBOund( ila_nondivisionbasedprivs )
FOR ll_index = 1 TO ll_max
	IF ids_privDetails.getItemNumber( ll_index, "modfnid" ) = al_modFnID THEN
		IF ids_privDetails.getItemString( ll_index, "type" ) = "N" THEN
			lb_return = true
		END IF
		EXIT
	END IF
NEXT

RETURN lb_Return
end function

public function boolean of_getuserpermissionbyfunction (string as_function);//Returns true if the user has permission to do this, this requires that
//function names are unique
Datastore	lds_privs
Long			ll_index
String		ls_function
String		ls_perm
Boolean		lb_return
Boolean		lb_found

lds_privs = this.of_getDetails( )

IF isValid( lds_privs ) THEN
	FOR ll_index = lds_privs.RowcouNT() TO 1 STEP -1
		ls_function = lds_privs.getitemString( ll_index, "function" )
		IF lower(ls_function) = lower(as_function) THEN
			lb_found = true
			EXIT
		END IF
	NEXT
END IF

IF lb_found THEN
	ls_perm = lds_privs.getitemString( ll_index, "functionvalue" )
	lb_return = (ls_perm = "Y")
END IF


RETURN lb_return
end function

public function boolean of_hasspecialchecking ();//this will be true on modules
//that have special privilege
//checking that should be used
//when the system setting is set to
//NOT use the advanced privileges.  Primarily
//to maintain old functionality. N_cst_privDetails_imaging
//is an example.
return ib_hasSpecialPrivChecking
end function

on n_cst_privdetails.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_privdetails.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_privDetails	= Create DataStore
ids_PrivDetails.DataObject = This.of_GetDetailDataObject()
ids_PrivDetails.SetTransObject(SQLCA)

end event

event destructor;Destroy ids_PrivDetails
end event

