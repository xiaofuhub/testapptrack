$PBExportHeader$n_cst_privdetails_collection.sru
forward
global type n_cst_privdetails_collection from n_cst_privdetails
end type
end forward

global type n_cst_privdetails_collection from n_cst_privdetails
event ue_initializecollection ( )
end type
global n_cst_privdetails_collection n_cst_privdetails_collection

type variables
n_cst_PrivDetails		inva_Collection[]
end variables

forward prototypes
public function integer of_getcollection (ref n_cst_privdetails anva_privdetails[])
public function integer of_detailchanged (dwobject adwo, long al_row, string as_data)
public function integer of_setmodule (string as_module)
public function datastore of_getdetails ()
public function boolean of_hasnondivisionbasedprivs ()
public function boolean of_isnondivisionbasedpriv (long al_modfnid)
public function boolean of_getuserpermissionbyfunction (string as_function)
end prototypes

event ue_initializecollection();//initialize 

//is_module
//il_division
//il_PrivId
//ii_role

String		lsa_allModules[]
Long			lla_divisionIds[]
Datastore	lds_divisions

Long			ll_row
Long			ll_max
Long			ll_index
Long			ll_k
Long			ll_AllDivisionIndex
Long			ll_AllModuleIndex
Long			ll_modCount
Long			ll_divCount
Boolean		lb_continue = true
n_cst_privDetails	lnv_privDetails

//put the modules and divisions into arrays so that we can get each combination of the objects 
//as part of this collection.
IF isValid( this.inv_privmanager ) THEN
	
	//in order for this to be a collection either is_module must equal All Modules or
	//il_division as to equal all divisions
	//both are possible
	
	IF is_module = inv_privManager.cs_AllModules THEN
		inv_privManager.of_getmodules( lsa_allmodules ) 
		IF upperBound( lsa_allmodules ) = 0 THEN
			lb_continue = false		//not a valid collection, nothing can be created
		END IF
	ELSE
		//has to be all divisions because there is only one module
		lsa_allModules[1] = is_module
	END IF
	
	IF il_division =  inv_privManager.cl_AllDivisions THEN
		inv_privManager.of_getDivisions( lds_divisions )
		IF isValid( lds_divisions ) THEN
			ll_max = lds_divisions.rowCount( ) 
			FOR ll_index = 1 TO ll_max
				lla_divisionIds[ll_index] = lds_divisions.getItemNumber( ll_index, "st_id" )
			NEXT
		ELSE
			lb_continue = false			//not a valid collection, nothing can be created
		END IF
	ELSE
		//has to be all modules because there is only one division
		lla_divisionIds[1] = il_division
	END IF
ELSE
	lb_continue = false
END IF

//if there is at least one thing in the collection that can be created
IF lb_continue THEN
	ll_modCount = upperBound( lsa_Allmodules )
	ll_divCount = upperBound( lla_divisionIds )
	
	//create each combination of division and modules that make up this collection, 
	//add them to the array
	FOR ll_row = 1 TO ll_modCount 
		FOR ll_index = 1 TO ll_divCount
			//we never want a collection object to be created inside of another collection object
			IF NOT (lsa_allModules[ll_row] = inv_privManager.cs_AllModules AND lla_divisionIds[ll_index] = inv_privManager.cl_AllDivisions) THEN
				IF NOT (lsa_allModules[ll_row] = is_module AND lla_divisionIds[ll_index] = il_division )THEN
					lnv_privDetails = inv_privmanager.of_getdetails( il_userid , lsa_Allmodules[ll_row], lla_divisionIds[ll_index], false )			
					IF isValid( lnv_privDetails ) THEN
						inva_collection[upperBound( inva_collection )+1] = lnv_privDetails
					END IF
				END IF			
			END IF
		NEXT
	NEXT
END IF
end event

public function integer of_getcollection (ref n_cst_privdetails anva_privdetails[]);anva_privDetails = inva_collection

RETURN upperBound( inva_collection )
end function

public function integer of_detailchanged (dwobject adwo, long al_row, string as_data);//This loops through its collection of objects and forwards the call so they can handle themselves.
//The only time this should ever be called on a collection object is if the division is all_divisions
//but not if its all modules and alldivisions.  The reasoning behind this is because it changes
//the functional overrides for a specific module, and modules are not garanteed to have the same
//functions, but one module across all divisions should have the same functions, so it is safe
//to change it for all divisions.

Long	ll_index
Long	ll_max
Boolean	lb_perm
String	ls_oldData
String	ls_function
String	ls_Singletonvalue

DataStore	lds_PrivDetail


Int	li_return
ll_max = upperBound( inva_collection )
//begin midification by appeon 
//invoke constant form n_cst_appeon_constant
//IF il_division = n_cst_privsManager.cl_AllDivisions AND  is_module <> n_cst_privsManager.cs_AllModules THEN
IF il_division = appeon_constant.cl_AllDivisions AND  is_module <> appeon_constant.cs_AllModules THEN

//end midification by appeon 
	FOR ll_index = 1 TO ll_max
		IF isValid( inva_collection[ll_index] ) THEN
			lds_PrivDetail = inva_collection[ll_index].of_GetCurrentDetails()
			IF lds_privDetail.RowCount() > 0 THEN
				ls_SingletonValue = lds_PrivDetail.GetItemString( al_row , "functionvalue" )
				//If the singleton value is different from the collection, call detail changed
				IF ls_SingletonValue <> as_data THEN
					inva_collection[ll_index].of_DetailChanged( adwo, al_row, as_data )
				END IF
			ELSE
				//the functional details were not initialized yet.
				inva_collection[ll_index].of_DetailChanged( adwo, al_row, as_data )
			END IF
		END IF
	NEXT
END IF

RETURN li_Return
end function

public function integer of_setmodule (string as_module);is_Module = as_Module

Return 1
end function

public function datastore of_getdetails ();Long		i, j
Long		ll_CollectionCount
LOng		ll_DetailCount
Long		ll_FunctionCount
String	ls_Module
String	ls_CollectionValue
String	ls_LastValue

DataStore lds_CollectionDetail


ls_Module = This.of_GetModule()
ids_PrivDetails.Retrieve(ls_Module)
Commit;

IF ids_privDetails.RowCount() > 0 THEN
	IF this.is_module <> "All" THEN
		ll_CollectionCount = UpperBound(inva_Collection)
		FOR i = 1 TO ll_CollectionCount
			lds_CollectionDetail = inva_Collection[i].of_GetDetails()
			ll_FunctionCount = lds_CollectionDetail.RowCOunt()//ids_PrivDetails.RowCount()
			
			FOR j = 1 TO ll_FunctionCount
				ls_CollectionValue = lds_CollectionDetail.Object.functionvalue[j]
				ls_LastValue = ids_PrivDetails.Object.functionvalue[j]
				
				IF isNull(ls_LastValue) OR ls_LastValue <> "?" THEN
					ids_PrivDetails.Object.functionvalue[j] = ls_CollectionValue //"Y", "N"
				END IF
				
				IF NOT isNUll(ls_LastValue) AND ls_LastValue <> ls_CollectionValue THEN
					ids_PrivDetails.Object.functionvalue[j] = "?"
				END IF
			NEXT
			
		NEXT
	END IF
END IF

Return ids_PrivDetails
end function

public function boolean of_hasnondivisionbasedprivs ();//this is only here so that it doesn't do the ancestor script
return false
end function

public function boolean of_isnondivisionbasedpriv (long al_modfnid);//here to override ancestor script
return false
end function

public function boolean of_getuserpermissionbyfunction (string as_function);//Overrides ancestor, if the function is called for a collection, then that means that
//the function passed in doesn't make sense from one division to the next.  A setting of
//yes on this function should mean that I can test any of the objects in the collection,
//and get the same answer.  For now ambiguous answers are unresolved. This function returns
//the first setting of yes or no found on any of the objects in this collection
//If the setting isn't found in the first collection object than false is returned.
Datastore	lds_privs
Long			ll_index
String		ls_function
String		ls_perm
Boolean		lb_return
Boolean		lb_found
Boolean		lb_proceed
Long			ll_collectionNum
n_cst_privDetails	lnv_temp

ll_collectionNum = upperBound( this.inva_collection )


lb_proceed = (ll_collectionNum  > 0)
	
IF lb_proceed THEN	
	lds_privs = this.of_getDetails( )
	
	FOR ll_index = ll_collectionNum TO 1 step - 1
		IF isValid( inva_collection[ll_index] ) THEN
			lnv_temp = inva_collection[ll_index]
			lb_return = lnv_temp.of_getuserpermissionbyfunction ( as_function )
			EXIT
		END IF
	NEXT
END IF

RETURN lb_return
end function

on n_cst_privdetails_collection.create
call super::create
end on

on n_cst_privdetails_collection.destroy
call super::destroy
end on

event destructor;call super::destructor;Long	ll_index
Long	ll_max

ll_max = upperBound( inva_collection )
FOR ll_index = 1 TO ll_max
	IF isValid( inva_collection[ll_index] ) THEN
		DESTROY inva_collection[ll_index]
	END IF
NEXT
end event

