$PBExportHeader$n_cst_employeemanager.sru
forward
global type n_cst_employeemanager from nonvisualobject
end type
end forward

shared variables
////DEK 5-29-07 There was no shared variables here when I started.
////begin modification Shared Variables by appeon  20070730
//
//long	sl_counter = 0
//
//n_ds 	sds_employee
//
//boolean 	sb_employees_retrieved
//
//string	ss_employees_last_change
//
//datetime	sdt_employees_refreshed, &
//	sdt_employees_updated, &
//	sdt_LastEmployeeCacheWrite
//	
//String	ss_EmployeeCacheFile
//String	ss_employeeCacheCode
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_employeemanager from nonvisualobject autoinstantiate
event type integer ue_fleethistoryreport ( )
end type

type variables
Public:
String	is_LastEmpDisplay
s_Emp_Info	istr_LastEmp

//DEK 5-29-07 There was no shared variables here when I started.
//begin modification Shared Variables by appeon  20070730

long	sl_counter = 0

//n_ds 	sds_employee

boolean 	sb_employees_retrieved

string	ss_employees_last_change

datetime	sdt_employees_refreshed, &
	sdt_employees_updated, &
	sdt_LastEmployeeCacheWrite
	
String	ss_EmployeeCacheFile
String	ss_employeeCacheCode
//end modification Shared Variables by appeon  20070730

end variables

forward prototypes
public function integer of_getemployeebycode (string as_code, ref long al_id)
public function integer of_getentitybycode (string as_code, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery)
public function integer of_getentity (long al_employeeid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery)
public function integer of_makeentity (long al_employeeid, ref long al_entityid)
public function integer of_getemployeebyentry (string as_entry, ref long al_id)
public function integer of_getentitybyentry (string as_entry, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery)
public function long of_empinfo (datastore ads_local, string as_entry, string as_type, ref s_emp_info astr_employee, boolean ab_notify)
public function integer of_describeemployee (readonly long al_id, ref string as_description)
public function integer of_getentitybyentry (string as_entry, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup)
public function integer of_getentitybycode (string as_code, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup)
public function integer of_getentity (long al_employeeid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup)
public function integer of_describeemployee (long al_id, ref string as_description, integer ai_describetype)
public function integer of_getemployeetype (long al_employeeid)
public function string of_gettemplate ()
public function integer of_describeemployee (string as_codename, integer ai_type, ref string as_description)
public function long of_getuserlist (ref long ala_userids[])
public function boolean of_get_employeesretrieved ()
public function string of_get_employees_lastchange ()
public function datetime of_get_employees_refreshed ()
public function datetime of_get_employees_updated ()
public function datetime of_get_lastemployee_cachewrite ()
public function string of_getcachefile ()
public function n_ds of_get_dsemployee ()
public function integer of_set_employees_lastchange (string as_lastchange)
public subroutine of_set_employeesretrieved (boolean ab_employeesretrieved)
public subroutine of_set_employees_refreshed (datetime adt_employeesrefreshed)
public subroutine of_set_employeesupdated (datetime adt_employeesupdated)
public subroutine of_set_lastemployeecachewrite (datetime adt_lastemployeecachewrite)
public subroutine of_set_employeecachefile (string as_employeecachefile)
public function integer of_loademployeecachefromfile ()
public function integer of_getemployeecachefile (ref string as_cachefile)
public function integer of_refreshemployees ()
public function integer of_populateextendedemployeedata (datastore ads_target)
public function integer of_initializecurrentemployees (ref datastore ads_currentemployees)
end prototypes

event ue_fleethistoryreport;//Returns : 1 = Success, 0 = No action taken (no data, user cancel, etc.), -1 = Error

Date			ld_Start, &
				ld_End, &
				ld_Null
s_Anys		lstr_Result
s_Parm		lstr_Parm
n_cst_Msg	lnv_Msg, &
				lnv_Range, &
				lnv_Blank
Integer		li_Result, &
				li_DriverCategory
DataStore	lds_Employees
Long			lla_Ids[], &
				ll_Count, &
				ll_Index
				
String	ls_Template, &
			ls_Filter

String	ls_MessageHeader = "Fleet History Report"
	
any	laa_beo[], &
		laa_Data[]
	
				
n_cst_Privileges			lnv_Privileges				
n_cst_beo_Itinerary2		lnva_Itinerary[]
n_cst_bso_Dispatch		lnva_Dispatch[]

SetNull ( ld_Null )
Integer	li_Return = 1


IF li_Return = 1 THEN

	IF lnv_Privileges.of_HasAdministrativeRights ( ) = FALSE THEN
		MessageBox ( ls_MessageHeader, lnv_Privileges.of_GetRestrictMessage ( ) )
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	//Present a date range dialog to the user.

	lstr_Parm.is_Label = "OPTIONAL"
	lstr_Parm.ia_Value = "FALSE"
	lnv_msg.of_add_Parm ( lstr_Parm )
	
	OpenWithParm ( w_Date_Range, lnv_Msg )
	
	lstr_result = message.powerobjectparm
	li_result = lstr_result.anys[1]
	
	if li_result = 1 then
		ld_Start = lstr_result.anys[2]
		ld_Start = Date ( DateTime ( ld_Start ) )
		ld_End = lstr_result.anys[3]
		ld_End = Date ( DateTime ( ld_End ) )

		IF IsNull ( ld_Start ) OR IsNull ( ld_End ) THEN
			li_Return = -1
		END IF

	ELSE  //User Cancelled
		li_Return = 0
	end if

END IF


IF li_Return = 1 THEN

	Open ( w_SelectDriverCategory )
	li_DriverCategory = Message.DoubleParm

	IF li_DriverCategory = -1 THEN  //User cancelled.
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN
	
	ls_Template = this.of_GetTemplate()
	IF len ( trim ( ls_Template ) ) > 0 THEN
		//OK, a template was selected
	ELSE
		//User cancelled.
		li_Return = 0
	END IF
	
END IF


IF li_Return = 1 THEN

	//Retrieve an employee cache, so we can filter & sort it to get a list of driver ids.
	//(We can't use the gds_Emp cache here because it doesn't have the Team column we need
	//on it.)

	SetPointer ( HourGlass! )

	lds_Employees = CREATE DataStore
	lds_Employees.DataObject = "d_EmployeeCache"
	lds_Employees.SetTransObject ( SQLCA )

	IF lds_Employees.Retrieve ( ) >= 0 THEN
		//OK
	ELSE
		MessageBox ( ls_MessageHeader, "Could not retrieve driver list.  Request cancelled.", &
			Exclamation! )
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN
	
	ls_Filter = "em_status = 'K' AND em_type = 2"   //Status = Active and Type = Driver

	CHOOSE CASE li_DriverCategory

	CASE n_cst_Constants.ci_DriverCategory_Singles
		ls_Filter += " AND di_Team = 'F'"

	CASE n_cst_Constants.ci_DriverCategory_Teams
		ls_Filter += " AND di_Team = 'T'"

	CASE n_cst_Constants.ci_DriverCategory_All
		//No additional filter restriction needed.

	CASE ELSE  //Unexpected Value -- shouldn't happen
		MessageBox ( ls_MessageHeader, "Could not process driver category selection.  Request cancelled.", &
			Exclamation! )
		li_Return = -1

	END CHOOSE

	lds_Employees.SetFilter ( ls_Filter )
	lds_Employees.SetSort ( "em_ln A, em_fn A" )  //LastName, FirstName
	lds_Employees.Filter ( )
	lds_Employees.Sort ( )

	IF lds_Employees.RowCount ( ) > 0 THEN
		lla_Ids = lds_Employees.Object.em_id.Primary
		ll_Count = UpperBound ( lla_Ids )
	ELSE
		MessageBox ( ls_MessageHeader, "No drivers are available to report on.  Request cancelled." )
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	FOR ll_Index = 1 TO ll_Count

		lnva_Dispatch [ ll_Index ] = CREATE n_cst_bso_Dispatch
		lnva_Dispatch [ ll_Index ].of_RetrieveItinerary ( gc_Dispatch.ci_ItinType_Driver, lla_Ids [ ll_Index ], &
			RelativeDate ( ld_Start, -5 ), RelativeDate ( ld_End, 5 ), FALSE /*Don't force prior beyond cushion*/ )

		//Filter the itinerary  (use null limits to take everything that was retrieved -- we want everything that
		//was retrieved, even the stuff outside the range.)
		lnva_Dispatch [ ll_Index ].of_FilterItinerary ( gc_Dispatch.ci_ItinType_Driver, lla_Ids [ ll_Index ], ld_Null, ld_Null )

		lnv_Range.of_Reset ( )

		lstr_Parm.is_Label = "StartDate"
		lstr_Parm.ia_Value = ld_Start
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "EndDate"
		lstr_Parm.ia_Value = ld_End
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = gc_Dispatch.ci_ItinType_Driver
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = lla_Ids [ ll_Index ]
		lnv_Range.of_Add_Parm ( lstr_Parm )

		lnva_Itinerary [ ll_Index ] = CREATE n_cst_beo_itinerary2
		
		lnva_Itinerary [ ll_Index ].of_SetDispatchManager ( lnva_Dispatch [ ll_Index ] )
		lnva_Itinerary [ ll_Index ].of_SetRange ( lnv_Range )

	NEXT

END IF


IF li_Return = 1 THEN
	
	n_cst_bso_ReportManager	lnv_ReportManager
	laa_Beo = lnva_Itinerary
	lnv_ReportManager.of_CreateReport ( "ITINERARY", ls_Template, laa_Beo, TRUE, TRUE, laa_Data, lnv_Range )
	
END IF


DESTROY lds_Employees

ll_Count = UpperBound ( lnva_Itinerary )
FOR ll_Index = 1 to ll_Count
	DESTROY lnva_Itinerary [ll_Index]
NEXT

ll_Count = UpperBound ( lnva_Dispatch )
FOR ll_Index = 1 to ll_Count
	DESTROY lnva_Dispatch [ll_Index]
NEXT

RETURN li_Return
end event

public function integer of_getemployeebycode (string as_code, ref long al_id);//Returns : 1, 0, -1

s_Emp_Info	lstr_Employee
DataStore	lds_Null
String	ls_Null
Integer	li_Return

SetNull ( ls_Null )
SetNull ( al_Id )
as_Code = Trim ( as_Code )
li_Return = 0


istr_LastEmp = lstr_Employee
is_LastEmpDisplay = ""


IF Len ( as_Code ) > 0 THEN

	Constant Boolean	lb_Notify = FALSE
	This.of_EmpInfo ( lds_Null, "/" + as_Code, "", lstr_Employee, lb_Notify )

END IF


//IF NOT IsNull ( lstr_Employee.em_id ) THEN
IF lstr_Employee.em_Id <> 0 THEN    //Code above may leave it 0

	istr_LastEmp = lstr_Employee
	is_LastEmpDisplay = lstr_Employee.em_fn + " " + lstr_Employee.em_ln

	al_Id = lstr_Employee.em_Id
	li_Return = 1

END IF

RETURN li_Return
end function

public function integer of_getentitybycode (string as_code, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
'ab_OpenSetup'. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.

*/
//Returns : 1, 0, -1

CONSTANT Boolean cb_OpenSetup = FALSE

RETURN THIS.of_GetEntityByCode ( as_code, al_entityid, ab_allowcreate, ab_createquery, cb_OpenSetup ) 


//
//Long	ll_EmployeeId, &
//		ll_EntityId
//Integer	li_Return
//
//SetNull ( ll_EntityId )
//li_Return = -1
//
//CHOOSE CASE This.of_GetEmployeeByCode ( as_Code, ll_EmployeeId )
//
//CASE 1
//
//	//Employee identified successfully.  Try to determine entity.
//
//	CHOOSE CASE This.of_GetEntity ( ll_EmployeeId, ll_EntityId, ab_AllowCreate, ab_CreateQuery )
//
//	CASE 1
//
//		//Entity identified successfully.
//		li_Return = 1
//
//	CASE 0
//
//		//No entity match found.
//		li_Return = 0
//
//	CASE ELSE  //-1
//
//		//Error.  Allow to fail.
//
//	END CHOOSE
//
//CASE 0
//
//	//Employee not found.
//	li_Return = 0
//
//CASE ELSE  //-1
//
//	//Error.  Allow to fail.
//
//END CHOOSE
//
//
////Pass out value determined for entity (if any.)
//al_EntityId = ll_EntityId
//
//RETURN li_Return
end function

public function integer of_getentity (long al_employeeid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
-ab_OpenSetup. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.

*/


//Returns : 1 = Success, 0 = Not Found, -1 = Error

CONSTANT Boolean cb_OpenSetup = FALSE

RETURN This.of_GetEntity ( al_employeeid , al_entityid, ab_allowcreate, ab_createquery, cb_OpenSetup )



//Long	ll_EntityId
//Boolean	lb_Create
//String	ls_MessageHeader = "Select Employee"
//n_cst_Privileges	lnv_Privileges
//Integer	li_Return
//Int		li_MakeRtn
//
//SetNull ( al_EntityId )
//
//
//IF NOT IsNull ( al_EmployeeId ) THEN
//
//	SELECT Id INTO :ll_EntityId FROM Entity WHERE fkEmployee = :al_EmployeeId ;
//	
//	CHOOSE CASE SQLCA.SqlCode
//	
//	CASE 0
//		COMMIT ;
//		al_EntityId = ll_EntityId
//		li_Return = 1
//	
//	CASE 100
//		COMMIT ;
//		li_Return = 0
//	
//		IF ab_AllowCreate THEN
//	
//			//Here, I'm taking CreateQuery to be like a "notify" flag.  If CreateQuery is true, the user will get
//			//feedback depending on their privileges.  If CreateQuery is false, the creation will either happen
//			//or not happen silently, depending on the user's privileges.
//	
//			IF ab_CreateQuery THEN
//	
//				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
//	
//					IF MessageBox ( ls_MessageHeader, "The employee " + is_LastEmpDisplay + " is not currently set up "+&
//						"to handle transactions.  Do you want to perform the setup now?", Question!, YesNo!, 1 ) = 1 THEN
//		
//						lb_Create = TRUE
//		
//					END IF
//	
//				ELSE
//	
//					MessageBox ( ls_MessageHeader, "The employee " + is_LastEmpDisplay + " is not currently set up "+&
//						"to handle transactions." )
//	
//				END IF
//	
//			ELSE
//	
//				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
//					lb_Create = TRUE
//				END IF
//	
//			END IF
//	
//		END IF
//	
//	
//		IF lb_Create THEN
//			li_MakeRtn = This.of_MakeEntity ( al_EmployeeId, ll_EntityId )
//			// li_makeRtn = 1 --> just created
//			CHOOSE CASE li_MakeRtn
//	
//			CASE -1  //Failed
//				li_Return = -1
//	
//				IF ab_CreateQuery THEN
//					MessageBox ( ls_MessageHeader, "Could not perform setup.  Request cancelled.", Exclamation! )
//				END IF
//	
//			CASE ELSE  
//				//Entity was created successfully (or already exists.)
//				al_EntityId = ll_EntityId
//				li_Return = 1
//	
//			END CHOOSE
//			
//			IF li_Return = 1 AND ab_createquery AND li_MakeRtn = 1 THEN
//
//				w_AmountTemplates		lw_AmountTemplates
//				OpenSheetWithParm (lw_AmountTemplates, al_EntityId ,gnv_App.of_GetFrame ( ), 0, Layered!)
//
//			END IF
//	
//		END IF
//	
//	
//	CASE ELSE
//		ROLLBACK ;
//		li_Return = -1
//	
//	END CHOOSE
//	
//ELSE
//	li_Return = 0
//	
//END IF
//
//
//RETURN li_Return
end function

public function integer of_makeentity (long al_employeeid, ref long al_entityid);//Returns : 1 = Success (Entity Added ), 0 = Entity already exists, no action taken, -1 = Error

Long	ll_EntityId
Integer	li_Return
Long	ll_division

li_Return = -1
SetNull ( al_EntityId )


Constant Boolean	lb_AllowCreate = FALSE
Constant Boolean	lb_CreateQuery = FALSE

CHOOSE CASE This.of_GetEntity ( al_EmployeeId, ll_EntityId, lb_AllowCreate, lb_CreateQuery )

CASE 1
	al_EntityId = ll_EntityId
	li_Return = 0

CASE 0

	Long	ll_NextId
	Constant Boolean	cb_Commit = TRUE
		
	IF gnv_App.of_GetNextId ( "n_cst_beo_entity", ll_NextId, cb_Commit ) = 1 THEN
	
		//added by Dan 4-26-06, to insert the division id as well
		 SELECT "driverinfo"."di_division"
		 INTO :ll_division
		 FROM "driverinfo"  
		WHERE "driverinfo"."di_id" = :al_employeeid
					  ;
		
	
	
		INSERT INTO Entity ( Id, fkEmployee, Division ) VALUES ( :ll_NextId, :al_EmployeeId, :ll_division ) ;

		IF SQLCA.SqlCode = 0 THEN
			COMMIT ;
			al_EntityId = ll_NextId
			li_Return = 1
		ELSE
			ROLLBACK ;
		END IF
		
	END IF
	
CASE ELSE //-1
	//Error.  Allow to fail.

END CHOOSE

RETURN li_Return
end function

public function integer of_getemployeebyentry (string as_entry, ref long al_id);//Returns : 1, 0, -1

s_Emp_Info	lstr_Employee
DataStore	lds_Null
String	ls_Null
Integer	li_Return

SetNull ( ls_Null )
SetNull ( al_Id )
li_Return = 0


istr_LastEmp = lstr_Employee
is_LastEmpDisplay = ""


IF Len ( as_Entry ) > 0 THEN

	Constant Boolean	lb_Notify = TRUE
	This.of_EmpInfo ( lds_Null, as_Entry, "", lstr_Employee, lb_Notify )

ELSE

	lstr_Employee.em_ln = ""
	lstr_Employee.em_fn = ""
	lstr_Employee.em_status = ls_Null
	lstr_Employee.em_type = 0   //2 for drivers only
	
	OpenWithParm ( w_Emp_List, lstr_Employee )
	lstr_Employee = Message.PowerObjectParm

END IF


//IF NOT IsNull ( lstr_Employee.em_id ) THEN
IF lstr_Employee.em_Id <> 0 THEN    //Code above may leave it 0

	istr_LastEmp = lstr_Employee
	is_LastEmpDisplay = lstr_Employee.em_fn + " " + lstr_Employee.em_ln

	al_Id = lstr_Employee.em_Id
	li_Return = 1

END IF

RETURN li_Return
end function

public function integer of_getentitybyentry (string as_entry, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
-ab_OpenSetup. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.


*/
//Returns : 1, 0, -1

CONSTANT Boolean	cb_OpenSetup = FALSE

RETURN THIS.of_GetEntitybyEntry ( as_entry, al_entityid, ab_allowcreate, ab_createquery, cb_OpenSetup )

//Long	ll_EmployeeId, &
//		ll_EntityId
//Integer	li_Return
//
//SetNull ( ll_EntityId )
//li_Return = -1
//
//CHOOSE CASE This.of_GetEmployeeByEntry ( as_Entry, ll_EmployeeId )
//
//CASE 1
//
//	//Employee identified successfully.  Try to determine entity.
//
//	CHOOSE CASE This.of_GetEntity ( ll_EmployeeId, ll_EntityId, ab_AllowCreate, ab_CreateQuery )
//
//	CASE 1
//
//		//Entity identified successfully.
//		li_Return = 1
//
//	CASE 0
//
//		//No entity match found.
//		li_Return = 0
//
//	CASE ELSE  //-1
//
//		//Error.  Allow to fail.
//
//	END CHOOSE
//
//CASE 0
//
//	//Employee not found.
//	li_Return = 0
//
//CASE ELSE  //-1
//
//	//Error.  Allow to fail.
//
//END CHOOSE
//
//
////Pass out value determined for entity (if any.)
//al_EntityId = ll_EntityId
//
//RETURN li_Return
end function

public function long of_empinfo (datastore ads_local, string as_entry, string as_type, ref s_emp_info astr_employee, boolean ab_notify);//This is an exact wrap of gf_Emp_Info (with arguments renamed), with the addition of
//the ab_Notify option, to allow silent failure.

n_cst_Numerical	lnv_Numerical
n_cst_AnyArraySrv	lnv_AnyArray
datastore ds_source
long sourcerow, global_rows, local_rows

global_rows = gds_emp.rowcount()
if isvalid(ads_Local) then local_rows = ads_Local.rowcount()

if isnull(as_Entry) and isnull(as_Type) then
	if astr_Employee.em_id > 0 then
		if local_rows > 0 then &
			sourcerow = ads_Local.find("em_id = " + string(astr_Employee.em_id), 1, local_rows)
		if sourcerow > 0 then
			ds_source = ads_Local
		else
			sourcerow = gf_find_emp(astr_Employee.em_id)
			if sourcerow > 0 then ds_source = gds_emp else return sourcerow
		end if
	else
		return -1
	end if
else
	long local_ids[], foundrow, foundid, numlocal, numtotal
	string findstr, msgstr, fn, ln, typestr
	integer pos1, pos2, name_len, fn_len, ln_len
	if integer(as_Type) = 2 then typestr = "driver" else typestr = "employee"
	as_Entry = trim(as_Entry)
	name_len = len(as_Entry)
	msgstr = "The name you have entered is invalid.~n~nPlease retry."
	if lnv_Numerical.of_IsNullOrNotPos(name_len) then goto notify
	if left(as_Entry, 1) = "/" then
		as_Entry = trim(replace(as_Entry, 1, 1, ""))
		name_len = len(as_Entry)

		//The following line was revised 11/24/98 by Brian
		//The normal quote order was reversed to allow searching for refs with apostrophes
		if name_len > 0 then findstr = 'em_ref = "' + as_Entry + '"' else goto notify

	else
		pos1 = pos(as_Entry, ",")
		pos2 = pos(as_Entry, " ")
		if pos1 > 0 then
			fn = trim(mid(as_Entry, pos1 + 1))
			ln = trim(left(as_Entry, pos1 - 1))
		elseif pos2 > 0 then
			fn = trim(left(as_Entry, pos2 - 1))
			ln = trim(mid(as_Entry, pos2 + 1))
		else
			ln = as_Entry
		end if
		fn_len = len(fn)
		ln_len = len(ln)
		if (ln_len < 1) or (fn_len < 1 and (pos1 > 0 or pos2 > 0)) then goto notify

		//The following 2 lines were revised 11/24/98 by Brian
		//The normal quote order was reversed to allow searching for names with apostrophes
		findstr = 'em_ln = "' + ln + '"'
		if fn_len > 0 then findstr += ' and em_fn = "' + fn + '"'

	end if
	if isnumber(as_Type) then
		if integer(as_Type) = 2 then 
			findstr += " and not isnull(di_id)"
		end if
	end if
	if local_rows > 0 then
		do
			foundrow = ads_Local.find(findstr, foundrow + 1, local_rows)
			if foundrow > 0 then
				numlocal ++
				local_ids[numlocal] = ads_Local.object.em_id[foundrow]
				sourcerow = foundrow
			end if
		loop while foundrow > 0 and foundrow < local_rows
		numtotal = numlocal
		foundrow = 0
	end if
	if global_rows > 0 then
		do
			foundrow = gds_emp.find(findstr, foundrow + 1, global_rows)
			if foundrow > 0 then
				foundid = gds_emp.object.em_id[foundrow]
				if numlocal > 0 then
					if lnv_AnyArray.of_FindLong(local_ids, foundid, 1, numlocal) > 0 then continue
				end if
				numtotal ++
				sourcerow = foundrow
			end if
		loop while foundrow > 0 and foundrow < global_rows
	end if
	if numtotal = 1 then
		if numlocal = 1 then ds_source = ads_Local else ds_source = gds_emp
	else
		if numtotal > 1 then
			//This assumes that since more than one match was found, it wasn't a code name srch
			msgstr = "There is more than one " + typestr + " with that name.  Please "
			if fn_len < 1 then msgstr += "include the first name as well, or "
			msgstr += "use the selection list instead."
//-----------------------------------------------------
			s_emp_Info temp_emp
			temp_emp.em_ln = ln
			temp_emp.em_fn = fn
			if isnumber(as_Type) then 
				if integer(as_Type) = 2 then 
					temp_emp.em_type = 2
				end if
			end if
			openwithparm(w_emp_list, temp_emp)
			temp_emp = message.powerobjectparm
			if not isnull(temp_emp.em_id) then
				temp_emp = message.powerobjectparm
				astr_Employee.em_id = temp_emp.em_id
				astr_Employee.em_fn = temp_emp.em_fn
				astr_Employee.em_ln = temp_emp.em_ln
				astr_Employee.em_ref = temp_emp.em_ref
				astr_Employee.em_status = temp_emp.em_status
				astr_Employee.em_type = temp_emp.em_type
				astr_Employee.em_class = temp_emp.em_class
				return 1
			else
				return -1
			end if
//-------------------------------------------------------------------------------------
		else
			msgstr = "Could not find an active " + typestr + " with that name.  You may "+&
				"need to edit your entry, or refresh the " + typestr + " list."
		end if
		goto notify
	end if
end if

astr_Employee.em_id = ds_source.object.em_id[sourcerow]
astr_Employee.em_fn = ds_source.object.em_fn[sourcerow]
astr_Employee.em_ln = ds_source.object.em_ln[sourcerow]
astr_Employee.em_ref = ds_source.object.em_ref[sourcerow]
astr_Employee.em_status = ds_source.object.em_status[sourcerow]
astr_Employee.em_type = ds_source.object.em_type[sourcerow]
astr_Employee.em_class = ds_source.object.em_class[sourcerow]

return 1

notify:
typestr = replace(typestr, 1, 1, upper(left(typestr, 1)))

IF ab_Notify THEN
	messagebox(typestr + " Selection", msgstr, exclamation!)
END IF

return numtotal
end function

public function integer of_describeemployee (readonly long al_id, ref string as_description);//Return the employee description using the default describe type.

//RETURN This.of_DescribeEmployee ( al_Id, as_Description, &
//	n_cst_beo.ci_DescribeType_Default )
RETURN This.of_DescribeEmployee ( al_Id, as_Description, &
	appeon_constant.ci_DescribeType_Default )
end function

public function integer of_getentitybyentry (string as_entry, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
-ab_OpenSetup. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.


*/
//Returns : 1, 0, -1

Long	ll_EmployeeId, &
		ll_EntityId
Integer	li_Return

SetNull ( ll_EntityId )
li_Return = -1

CHOOSE CASE This.of_GetEmployeeByEntry ( as_Entry, ll_EmployeeId )

CASE 1

	//Employee identified successfully.  Try to determine entity.

	CHOOSE CASE This.of_GetEntity ( ll_EmployeeId, ll_EntityId, ab_AllowCreate, ab_CreateQuery, ab_OpenSetup )

	CASE 1

		//Entity identified successfully.
		li_Return = 1

	CASE 0

		//No entity match found.
		li_Return = 0

	CASE ELSE  //-1

		//Error.  Allow to fail.

	END CHOOSE

CASE 0

	//Employee not found.
	li_Return = 0

CASE ELSE  //-1

	//Error.  Allow to fail.

END CHOOSE


//Pass out value determined for entity (if any.)
al_EntityId = ll_EntityId

RETURN li_Return
end function

public function integer of_getentitybycode (string as_code, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
-ab_OpenSetup. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.

*/

//Returns : 1, 0, -1

Long	ll_EmployeeId, &
		ll_EntityId
Integer	li_Return

SetNull ( ll_EntityId )
li_Return = -1

CHOOSE CASE This.of_GetEmployeeByCode ( as_Code, ll_EmployeeId )

CASE 1

	//Employee identified successfully.  Try to determine entity.

	CHOOSE CASE This.of_GetEntity ( ll_EmployeeId, ll_EntityId, ab_AllowCreate, ab_CreateQuery, ab_OpenSetup )

	CASE 1

		//Entity identified successfully.
		li_Return = 1

	CASE 0

		//No entity match found.
		li_Return = 0

	CASE ELSE  //-1

		//Error.  Allow to fail.

	END CHOOSE

CASE 0

	//Employee not found.
	li_Return = 0

CASE ELSE  //-1

	//Error.  Allow to fail.

END CHOOSE


//Pass out value determined for entity (if any.)
al_EntityId = ll_EntityId

RETURN li_Return
end function

public function integer of_getentity (long al_employeeid, ref long al_entityid, boolean ab_allowcreate, boolean ab_createquery, boolean ab_opensetup);// overloaded.
/*
this method was overloaded to provide the functionality of opening the Payables Setup window
when an entity is set up to handle transactions. the logic relies on the boolean switch
-ab_OpenSetup. it will open the setup window if ab_OpenSetup = TRUE AND the entity has 
just been set up.

Default Value for ab_OpenSetup = FALSE

Updates-

<<*>> 7/25/2000 RPZ  overloading was implemented.


*/
//Returns : 1 = Success, 0 = Not Found, -1 = Error

Long	ll_EntityId
Boolean	lb_Create
String	ls_MessageHeader = "Select Employee"
n_cst_Privileges	lnv_Privileges
Integer	li_Return
Int		li_MakeRtn

SetNull ( al_EntityId )


IF NOT IsNull ( al_EmployeeId ) THEN

	SELECT Id INTO :ll_EntityId FROM Entity WHERE fkEmployee = :al_EmployeeId ;
	
	CHOOSE CASE SQLCA.SqlCode
	
	CASE 0
		COMMIT ;
		al_EntityId = ll_EntityId
		li_Return = 1
	
	CASE 100
		COMMIT ;
		li_Return = 0
	
		IF ab_AllowCreate THEN
	
			//Here, I'm taking CreateQuery to be like a "notify" flag.  If CreateQuery is true, the user will get
			//feedback depending on their privileges.  If CreateQuery is false, the creation will either happen
			//or not happen silently, depending on the user's privileges.
	
			IF ab_CreateQuery THEN
	
				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
	
					IF MessageBox ( ls_MessageHeader, "The employee " + is_LastEmpDisplay + " is not currently set up "+&
						"to handle transactions.  Do you want to perform the setup now?", Question!, YesNo!, 1 ) = 1 THEN
		
						lb_Create = TRUE
		
					END IF
	
				ELSE
	
					MessageBox ( ls_MessageHeader, "The employee " + is_LastEmpDisplay + " is not currently set up "+&
						"to handle transactions." )
	
				END IF
	
			ELSE
	
				IF lnv_Privileges.of_Settlements_EntitySetup ( ) THEN
					lb_Create = TRUE
				END IF
	
			END IF
	
		END IF
	
	
		IF lb_Create THEN
			li_MakeRtn = This.of_MakeEntity ( al_EmployeeId, ll_EntityId )
			// li_makeRtn = 1 --> just created
			CHOOSE CASE li_MakeRtn
	
			CASE -1  //Failed
				li_Return = -1
	
				IF ab_CreateQuery THEN
					MessageBox ( ls_MessageHeader, "Could not perform setup.  Request cancelled.", Exclamation! )
				END IF
	
			CASE ELSE  
				//Entity was created successfully (or already exists.)
				al_EntityId = ll_EntityId
				li_Return = 1
	
			END CHOOSE
			
			IF li_Return = 1 AND ab_opensetup AND li_MakeRtn = 1 THEN

				w_tv_AmountTemplates		lw_AmountTemplates
				OpenSheetWithParm (lw_AmountTemplates, al_EntityId ,gnv_App.of_GetFrame ( ), 0, Layered!)

			END IF
	
		END IF
	
	
	CASE ELSE
		ROLLBACK ;
		li_Return = -1
	
	END CHOOSE
	
ELSE
	li_Return = 0
	
END IF


RETURN li_Return

end function

public function integer of_describeemployee (long al_id, ref string as_description, integer ai_describetype);//Returns : 1, -1

s_emp_info	lstr_Employee
DataStore	lds_Null
String		ls_Null

Integer	li_Return = 1

SetNull ( ls_Null )
SetNull ( as_Description )

lstr_Employee.em_id = al_Id

IF This.of_EmpInfo ( lds_Null, ls_Null, ls_Null, lstr_Employee, FALSE /*Don't Notify*/ ) = 1 THEN

	CHOOSE CASE ai_DescribeType

	CASE appeon_constant.ci_DescribeType_FirstLast
		as_Description = lstr_Employee.em_fn + " " + lstr_Employee.em_ln

	CASE ELSE //n_cst_beo.ci_DescribeType_Default, appeon_constant.ci_DescribeType_LastFirst, or Unexpected -- Use LastFirst
		as_Description = lstr_Employee.em_ln + ", " + lstr_Employee.em_fn

	END CHOOSE

ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

public function integer of_getemployeetype (long al_employeeid);// returns the constant int for the type of the employee, -1 on error or -2 if the info was 
// not filled in

Int			li_Return = -1
Long			ll_FindRow 
Int			li_DriverType
DataStore	lds_EmpInfo
S_Emp_Info	lstr_EmpInfo

lds_EmpInfo = CREATE DataStore

lds_EmpInfo.dataobject = "d_EmployeeCache"

lds_EmpInfo.SetTransObject ( SQLCA )

lds_EmpInfo.Retrieve ( )


IF al_EmployeeID > 0 THEN

	ll_FindRow = lds_EmpInfo.Find ( "em_id = " + String ( al_employeeid ) , 1, lds_EmpInfo.RowCount ( ) )

	
	IF ll_FindRow > 0 THEN
		
		li_DriverType = lds_EmpInfo.object.di_type_driver[ ll_FindRow ]
		IF Not isNull ( li_DriverType ) THEN
			CHOOSE CASE li_DriverType
				CASE 0
					li_Return = n_cst_Constants.ci_Employee_OwnerOperator 
				CASE 1
					li_Return = n_cst_Constants.ci_Employee_CompanyDriver
				CASE 2
					li_Return = n_cst_Constants.ci_Employee_3rdParty
				CASE 3
					li_Return = n_cst_Constants.ci_Employee_Casual
				CASE ELSE // ERROR
					li_Return = -1
			END CHOOSE
		ELSE
			li_Return = -2 // driver type has not been filled in
		END IF
	END IF
	
END IF

RETURN li_Return

end function

public function string of_gettemplate ();//Gets a template file name for use in the FleetHistoryReport.

//NOTE : n_cst_EquipmentManager.ue_FleetHistoryReport also calls this,
//since the processing is the same.  Perhaps this code therefore have another home?

any		la_Setting

string	ls_Setting, &
			ls_Description, &
			ls_Path, &
			ls_File
			
Boolean	lb_SelectFileAgain 


n_cst_fileSrvwin32	lnv_fileSrv
lnv_FileSrv = CREATE n_cst_fileSrvwin32

//get the template folder location
n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_Path = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )


IF len ( ls_Path ) > 0 THEN
	
	ls_Description = ls_Path + "reports\"

END IF

	
IF len ( ls_Description ) = 0 THEN

	IF GetFileOpenName("Select File", ls_Path, ls_File, "xls", + &
				"Excel Spreadsheet (*.xls), *.xls") = 1 THEN
		ls_description = ls_Path 
	END IF
	
ELSE
	
	IF right ( ls_Description, 1 ) = "\" THEN
		
		lnv_FileSrv.of_ChangeDirectory ( ls_Description ) 
		Do
			lb_SelectFileAgain = FALSE
			CHOOSE CASE GetFileOpenName("Select File", ls_Path, ls_File, "xls", + &
					"Excel Spreadsheet (*.xls), *.xls") 
				CASE 1 // success
					ls_description = ls_Path 
				CASE 0 // user cancelled
					IF MessageBox ( "Fleet Report" , &
							"By not selecting a template you will cancel the report." + &
							" Are you sure you want to cancel?", QUESTION!, YESNO! , 2 ) = 1 THEN
						ls_Description = ''
					ELSE
						lb_SelectFileAgain = TRUE
					END IF
				CASE ELSE // unexpected error
					ls_Description = ''
				
			END CHOOSE
		LOOP While lb_SelectFileAgain
		
	END IF	

END IF

Destroy ( lnv_FileSrv )

return ls_Description
end function

public function integer of_describeemployee (string as_codename, integer ai_type, ref string as_description);//Returns : 1, -1

s_emp_info	lstr_Employee
DataStore	lds_Null

Long		ll_ID
Integer	li_Return = 1


SetNull ( as_Description )
THIS.of_GetEmployeeByCode( as_codename, ll_ID )
lstr_Employee.em_id = ll_ID

IF This.of_EmpInfo ( lds_Null, null_Str, null_Str , lstr_Employee, FALSE /*Don't Notify*/ ) = 1 THEN

	as_Description = lstr_Employee.em_fn + " " + lstr_Employee.em_ln
	
ELSE
	li_Return = -1
END IF


RETURN li_Return
end function

public function long of_getuserlist (ref long ala_userids[]);// returns a list of employees in PT that atr classified as users
Long	lla_Ids[]
Long	ll_Count
Long	ll_Temp
 
 
 DECLARE Users CURSOR FOR  
  SELECT "employees"."em_id"  
    FROM "employees"  
   WHERE "employees"."em_class" <> 1001;
	
OPEN Users;

DO 
	ll_Temp = 0
	
	FETCH Users into :ll_Temp;
	
	IF ll_Temp > 0 THEN
		ll_Count ++
		lla_Ids[ll_Count] = ll_Temp
	END IF
	
LOOP WHILE SQLCA.Sqlcode = 0



CLOSE Users;

COMMIT;

ala_userids[] = lla_Ids

RETURN ll_Count
end function

public function boolean of_get_employeesretrieved ();//DEK 5-30-07
return sb_employees_retrieved
end function

public function string of_get_employees_lastchange ();return ss_employees_last_change
end function

public function datetime of_get_employees_refreshed ();Return sdt_employees_refreshed
end function

public function datetime of_get_employees_updated ();return sdt_employees_updated
end function

public function datetime of_get_lastemployee_cachewrite ();return sdt_LastEmployeeCacheWrite
end function

public function string of_getcachefile ();return ss_EmployeeCacheFile
end function

public function n_ds of_get_dsemployee ();return sds_employee
end function

public function integer of_set_employees_lastchange (string as_lastchange);ss_employees_last_change = as_lastChange
return 1
end function

public subroutine of_set_employeesretrieved (boolean ab_employeesretrieved);sb_employees_retrieved = ab_employeesRetrieved
end subroutine

public subroutine of_set_employees_refreshed (datetime adt_employeesrefreshed);sdt_employees_refreshed = adt_employeesRefreshed
end subroutine

public subroutine of_set_employeesupdated (datetime adt_employeesupdated);sdt_employees_updated = adt_employeesUpdated
end subroutine

public subroutine of_set_lastemployeecachewrite (datetime adt_lastemployeecachewrite);sdt_LastEmployeeCacheWrite = adt_lastEmployeeCacheWrite
end subroutine

public subroutine of_set_employeecachefile (string as_employeecachefile);ss_EmployeeCacheFile = as_employeeCacheFile
end subroutine

public function integer of_loademployeecachefromfile ();/*
	DEK 5-30-07, I pretty much copied this from the shipment manager
*/
n_cst_dws	lnv_Dws
DataStore	lds_Temp
String		ls_MaxTimeStamp, &
				ls_CacheFile
Long			ll_RowCount, &
				ll_Attempts
Integer		li_FileHandle
Time			lt_FirstAttempt, &
				lt_LastAttempt

Integer	li_Return = 1


IF li_Return = 1 THEN

	CHOOSE CASE This.of_GetEmployeeCacheFile ( ls_CacheFile )

	CASE 1
		//OK

	CASE 0
		li_Return = 0
		
	CASE ELSE //-1
		li_Return = -1

	END CHOOSE

END IF


IF li_Return = 1 THEN

	lt_FirstAttempt = Now ( )

	DO
		
		//DEK this isn't in the shipment summary cache file but I seem to be getting stuck in 
		//an endless loop here when the file doesn't exist.
		IF not fileexists(ls_cachefile) THEN
			EXIT
			li_fileHandle = -1
		END IF
		
		li_FileHandle = FileOpen ( ls_CacheFile, LineMode!, Read!, LockWrite! )
		lt_LastAttempt = Now ( )
		ll_Attempts ++

		IF IsNull ( li_FileHandle ) THEN
			li_FileHandle = -1
			EXIT
		END IF

		//If we didn't get a file handle, we'll retry provided the time limit hasn't expired.
		//Yield processing to other threads, though, so we don't completely tie up the machine
		//for the attempt interval.

		IF li_FileHandle = -1 THEN
			Yield ( )
		END IF

	LOOP UNTIL li_FileHandle >= 0 OR SecondsAfter ( lt_FirstAttempt, lt_LastAttempt ) >= 5 /*Time Limit*/

	//In testing on a 4 second attempt interval, there were 4 attempts when the file was on a network, 
	//and 3160 attempts when the file was local.  However, if the file is local, it shouldn't be tied up
	//anyway, so we wouldn't really have all those attempts.

//	MessageBox ( String ( ll_Attempts ) + " Attempts", String ( li_FileHandle ) +&
//		" " + String ( lt_FirstAttempt, "h:mm:ss.fffff" ) + " " + String ( lt_LastAttempt, "h:mm:ss.ffffff" ) )


	IF li_FileHandle = -1 THEN
		li_Return = -1

	ELSEIF lnv_Dws.of_CreateDataStoreByDataObject ( ls_CacheFile, lds_Temp, TRUE ) = 1 THEN
		lds_Temp.SetSort ( "cs_timestamp A" )
		lds_Temp.Sort ( )
		ll_RowCount = lds_Temp.RowCount ( )
	
	ELSE
	
		li_Return = -1
	
	END IF

	IF li_FileHandle >= 0 THEN
		FileClose ( li_FileHandle )
	END IF

END IF


IF li_Return = 1 THEN

	IF ll_RowCount > 0 /*AND It's the right version*/ THEN

		ls_MaxTimeStamp = string(lds_Temp.Object.current_employees_lastroutedevent [ ll_RowCount ], "YYYY-MM-DD HH:MM:SS.FFF")

		IF Len ( ls_MaxTimeStamp ) > 0 THEN
			//OK
		ELSE
			li_Return = -1
		END IF

	ELSE
		li_Return = 0
	END IF

END IF


IF li_Return = 1 THEN

	IF ls_MaxTimeStamp > ss_employees_Last_Change THEN

		sds_employee.Reset ( )

		//Checking the success of rowscopy and the failure handling was added 3.6.b2 BKW 5-11-03
		//This enables the program to recognize cache file structure changes (via rowscopy failure)
		//and automatically recreate the cache file on an as-needed basis.

		IF lds_Temp.RowsCopy ( 1, ll_RowCount, Primary!, sds_employee, 9999, Primary! ) = 1 THEN

	//		Alternative Method : Replace existing cache with new one.
	//		DESTROY sds_Ship
	//		sds_Ship = lds_Temp
	
			sb_employees_retrieved = true
			ss_employees_last_change = ls_MaxTimeStamp
			sdt_employees_refreshed = datetime(today(), now())
			sdt_employees_updated = sdt_employees_refreshed

		ELSE

			//The "normal" reason for this rowscopy to fail would be the first time the cache has been loaded after
			//a program version update that changes its structure.  This will force a reload from scratch and an 
			//overwrite of the existing outdated cache file.

			li_Return = -1

			//If we had previously retrieved the cache successfully, reset the flags to indicate we no 
			//longer have it.  Note:  These are the same flags set when changing the cache code.

			IF sb_employees_Retrieved = TRUE THEN
	
				sb_employees_Retrieved = FALSE
				
				sdt_employees_refreshed = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
				sdt_employees_updated = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
				sdt_LastemployeeCacheWrite = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
				
				//si_ships_filter = 0
				ss_employees_last_change = ""

			END IF

		END IF

	ELSE
		li_Return = 0

	END IF

END IF


DESTROY lds_Temp

//If Alternative Method (Replacing Cache rather than copying rows) is used, we would conditionally destroy temp.
//IF li_Return < 1 THEN
//	DESTROY lds_Temp
//END IF

RETURN li_Return
end function

public function integer of_getemployeecachefile (ref string as_cachefile);//DEK 5-30-07More logic needs to go here but this is good for now
//as_cacheFile = "C:\employeeCache.psr"//ss_employeecachefile
//RETURN 1

//Returns : 1, 0, -1

any	la_Path
n_cst_settings lnv_Settings
String	ls_IniFile, &
			ls_Extension

Integer	li_Return = 1
Int	li_temp


IF IsNull ( ss_employeeCacheFile ) THEN

	//This is the first request for the value.  Look up the CacheFilePath and see if it exists.
	li_temp = lnv_Settings.of_GetSetting ( 68, la_path )
	IF li_temp = 1 THEN

		ss_employeeCacheFile = Trim ( String ( la_Path ) )

		IF Len ( ss_employeeCacheFile ) > 0 THEN

			IF Right ( ss_employeeCacheFile, 1 ) = "\" THEN
				//OK, leave it alone
			ELSE
				ss_employeeCacheFile += "\"
			END IF


			//If ss_ShipmentCacheCode has been specified, try to get a setting for it in the ini file.
			//If this succeeds, use the ss_ShipmentCacheCode as the psr name.
			//If not, clear the code, so that "shipsum.psr" will be used, below.
			//Note that "default.psr" is the default restricted summary, while "shipsum.psr" is the 
			//default unrestricted summary.

			IF NOT IsNull ( ss_employeeCacheCode ) THEN

				ls_IniFile = gnv_App.of_GetAppIniFile ( )
	

				setNull(ss_employeeCacheCode)
			ELSE

				//Since we don't have a code, clear the W.C.E., just in case it hasn't been already.
//				SetNull ( ss_ShipmentCacheWhereClauseExtension )

			END IF


			//If the CacheCode was null coming in, or if it's been set to null above, use the 
			//"universal" cache file, "employeeCache.psr"

			IF IsNull ( ss_employeeCacheCOde ) THEN

				ss_employeeCacheFile += "employeeCache.psr"

			END IF


		ELSE
			ss_employeeCacheFile = ""
			li_Return = 0

		END IF

	ELSE
		ss_employeeCacheFile = ""
		li_Return = 0

	END IF

ELSEIF ss_employeeCacheFile = "" THEN

	//We've already checked, and the path hasn't been specified.
	li_Return = 0

ELSE

	//Value is present.  Use it.

END IF


IF li_Return = 1 THEN
	as_cachefile = ss_employeeCacheFile
END IF
return li_return
end function

public function integer of_refreshemployees ();/*
	Relevent dataobjects are
	
	d_empCache
	d_current_Employee
	
	Relevent PSR is cacheViewDrivers
	
	All the columns from those caches should match, and any T-cards for drivers should be built with the same column structure
	as these three.
	
*/

boolean lb_Failed, lb_employeeCacheChanges

setpointer(hourglass!)

Datastore	lds_employeeIds, lds_EmployeeChanges
DWObject ldwo_EnployeeChangesTimestamp, ldwo_CheckId, ldwo_CacheId, ldwo_CheckTimestamp, ldwo_CacheTimestamp

long ll_CurrentEmployeeCount, ll_CacheCount, ll_CheckRow, ll_CacheRow, ll_employeeRow, &
	ll_CheckId, ll_CacheId, ll_TimestampRetrCount, lla_TimestampRetrIds[], ll_EmployeeChangesCount
string ls_Select, ls_CheckTimestamp, ls_MaxTimestamp, ls_TimestampInClause, ls_employeeCacheFile
string	ls_select1, ls_select2
Long	ll_index
Long	ll_max
Long	ll_id
Boolean	lb_CheckTimestamps
n_cst_DateTime		lnv_DateTime
n_cst_Sql			lnv_Sql
Int	li_return = 1

//We load the cache from file after thirty minutes goes by.
IF lnv_DateTime.of_SecondsAfter ( sdt_employees_Refreshed, DateTime ( Today ( ), Now ( ) ) ) > 1800 THEN
	This.of_LoademployeeCacheFromFile ()
END IF


//This section will see if any rows in the cache should no longer be there (due to deletion,
//the fact that they are no longer in current employees, fact that they no longer meet the criteria for this custom cache.)

//We're going to retrieve a list of all the ids that currently qualify for this cache, and if 
//there's any rows in the cache not in this id list, we'll remove them.


ll_CacheCount = sds_employee.rowcount()

if ll_CacheCount > 0 then
	
	lds_employeeIds = create datastore

	lds_employeeIds.dataobject = "d_currentemployee_ids"
	lds_employeeIds.settransobject(sqlca)
	lds_employeeIds.setsort("ce_id A")
	

	ll_CurrentEmployeeCount = lds_employeeIds.retrieve()
	if ll_CurrentEmployeeCount = -1 then
		rollback ;
		lb_Failed = true
	elseif ll_CurrentEmployeeCount = 0 then
		commit ;
		sds_employee.reset()
		lb_EmployeeCacheChanges = TRUE
		//this function will insert all of the drivers in the driver table into the current employee table. 
		//This should only be called the first tiem every that this function is called, or if the current_employee table was reset.
		this.of_initializecurrentemployees( lds_employeeIds )
	else
		this.of_initializecurrentemployees( lds_employeeIds ) //this will only add drivers that were not already there
	end if
end if


//Record in a boolean whether we have the info we need to do timestamp comparisons, for fast access in loop.

IF sb_employees_retrieved and len(ss_employees_last_change) > 0 THEN
	lb_CheckTimestamps = TRUE
END IF


if ll_CacheCount > 0 and ll_CurrentEmployeeCount > 0 then
	
	sds_employee.setsort("employees_em_id A")
	sds_employee.sort()
	ll_CheckRow = 1
	ll_CacheRow = 1
	ldwo_CheckId = lds_employeeIds.object.ce_id
	ldwo_CacheId = sds_employee.object.employees_em_id
	
	ldwo_CheckTimestamp = lds_employeeIds.Object.lastroutedevent
	ldwo_CacheTimestamp = sds_employee.Object.current_employees_lastRoutedEvent

	do
		
		ll_CheckId = ldwo_CheckId.primary[ll_CheckRow]

		do

			ll_CacheId = ldwo_CacheId.primary[ll_CacheRow]
			
			if ll_CacheId < ll_CheckId then
				sds_employee.rowsdiscard(ll_CacheRow, ll_CacheRow, primary!)
				ll_CacheCount --
				lb_employeeCacheChanges = TRUE
				continue
			elseif ll_CacheId > ll_CheckId then
				exit
			else
				
				//Added 4.0.45 9/1/05 BKW
				//The ids match.  Cross-check the timestamps.  If the timestamp in the table is 
				//greater than the ss_ships_last_change timestamp, that row will be refreshed normally
				//due to the timestamp criteria.  If the timestamp in the table is <= ss_ships_last_change 
				//AND it is DIFFERENT from the timestamp in the cache, this is an update that got skipped
				//over due to a dirty read and we need to record that id so we can include that id explicitly 
				//in the refresh request.  (Note:  We could actually just record all the ids whose timestamps,
				//don't match but I thought it would be better to avoid that for performance reasons.)
				
				//Changing isolation level for these queries to prevent dirty reads in the first place is probably 
				//not a viable option since the query would wait for all write locks on the rows being queried to
				//be released, which could severely degrade performance.  So, this approach does not attempt to
				//prevent a dirty read, but rather to "catch it" on the next pass and correct the data.
				
				//This change was implemented due to some occasional dirty read scenarios in the field.
				
				IF lb_CheckTimestamps THEN  	//If we don't have ss_ships_last_change, can't do these comparisons
														//In that case, all rows will be refreshed later, so it's ok.
				
					ls_CheckTimeStamp = string(ldwo_CheckTimeStamp.Primary [ ll_CheckRow ], "YYYY-MM-DD HH:MM:SS.FFF")
				
					IF ls_CheckTimeStamp > ss_employees_last_change THEN
						//ok
					ELSE
						//The timestamp in the cache is less than the timestamp in the table,
						//but is less than the max timestamp in the cache.  Need to force retrieval
						//for this id.
						
						ll_TimestampRetrCount ++
						lla_TimestampRetrIds [ ll_TimestampRetrCount ] = ll_CacheId
						
					END IF
					
				END IF
				
				//////End 4.0.45 addition
				
				ll_CacheRow ++
			end if
			
		loop while ll_CacheRow <= ll_CacheCount
		
		if ll_CacheRow > ll_CacheCount then exit
		
		ll_CheckRow ++
		
	loop while ll_CheckRow <= ll_CurrentEmployeeCount

	if ll_CacheRow <= ll_CacheCount then
		sds_employee.rowsdiscard(ll_CacheRow, ll_CacheCount, primary!)
		ll_CacheCount = ll_CacheRow - 1
		lb_employeeCacheChanges = TRUE
		
	end if
	
end if
//gnv_app.of_recordtime( string ( sds_employee.rowcount() ))
lds_EmployeeChanges = create datastore
lds_employeeChanges.dataobject = "d_current_employees"
lds_employeeChanges.settransobject(sqlca)

ls_Select = lds_employeeChanges.object.datawindow.table.select

IF lb_CheckTimestamps THEN   
	/*
		The select statement for the cache is a UNION between two selects.
		The first is a select that gets all driver rows for events cached today or after.
		The second is a select that gets all the driver rows who have no routed events for today or after.
		We want to cache both sets of information for common use.
		We exclude all driver rows with events that were cached before today, (THERE ARE A LOT!!! IT WILL CRASH A SYSTEM)
	*/
	ls_select1 = LEFT(ls_select, POS(ls_select, "UNION") - 1 )
	ls_select2 = RIGHT( ls_select, len(ls_select) - POS( ls_select,"UNION" ) + 1 )

	ls_select = ls_select1 + " AND " + "( ~~~"current_employees~~~".~~~"lastroutedevent~~~" > ~'" + ss_employees_last_change + "~' ) "+ ls_select2 
end if

lds_employeeChanges.object.datawindow.table.select = ls_Select
	

//Moved from earlier position 4.0.45 9/1/05 BKW

ll_EmployeeChangesCount = lds_employeeChanges.retrieve()

if ll_EmployeeChangesCount = -1 then
	rollback ;
	lb_Failed = true
else
	commit ;
end if

string ls_temp
if ll_EmployeeChangesCount > 0 then
// <*> IF ANY CALCULATIONS HAVE TO BE DONE AFTER THE FACT IT SHOULD GO HERE AND UNCOMMENT POPULATEEXTENDEDEMPLOYEEDATA
	//If any information needs to be calculated then this can be done here.
//MEssagebox("change count", ll_EmployeeChangesCount )
//	IF This.of_PopulateExtendedEmployeeData ( lds_employeeChanges ) = 1 THEN
//		//OK
//	ELSE
//		lb_Failed = TRUE
//	END IF

	ldwo_EnployeeChangesTimestamp = lds_employeeChanges.object.current_employees_lastroutedevent

	for ll_employeeRow = 1 to ll_EmployeeChangesCount
		ls_CheckTimestamp = string(ldwo_EnployeeChangesTimestamp.primary[ll_employeeRow], "YYYY-MM-DD HH:MM:SS.FFF")

		if ls_CheckTimestamp > ls_MaxTimestamp then 
			ls_MaxTimestamp = ls_CheckTimestamp

		end if
	next

	if gf_rows_sync(lds_employeeChanges, null_dw, sds_employee, null_dw, primary!, true, true) = 1 then
		lb_employeeCacheChanges = TRUE
		
		/*
			Because rowssync doesn't sync up rows that have null in the id column, I have to manually move them
			into the cache for employees who do not have any events routed today or after.  These rows do not have
			event ids, but we still want to cache them.  I thought this would be better then assigning false IDs to 
			the rows before doing a rowsync.  We make sure that no rows already exist in the cache for the employees
			with no events for today or after before we copy them.
		*/
		lds_employeeChanges.setfilter("isNull(disp_events_de_id)")
		lds_employeeChanges.filter()
		ll_max = lds_employeeChanges.rowCount()
		FOR ll_index = 1 TO ll_max
			ll_id = lds_employeeChanges.getITemNumber( ll_index, "employees_em_id" )
			IF sds_employee.find( "employees_em_id = "+ string(ll_id), 1 , sds_employee.rowcount() ) = 0 THEN
				lds_employeeChanges.rowscopy( ll_index, ll_index, PRIMARY!, sds_employee, 1, PRIMARY!)
				sds_employee.setitemstatus( 1, 0, PRIMARY!, DATAMODIFIED!)
				sds_employee.setitemstatus( 1, 0, PRIMARY!, NOTMODIFIED!)
			END IF
		NEXT
	else
		lb_Failed = true
	end if

end if



DESTROY lds_employeeChanges
DESTROY lds_employeeIds
DESTROY ldwo_EnployeeChangesTimestamp
DESTROY ldwo_CheckTimestamp
DESTROY ldwo_CacheTimestamp
DESTROY ldwo_CheckId
DESTROY ldwo_CacheId

if lb_Failed then
	return -1
else
	sb_employees_retrieved = true

	if ll_employeeChangesCount > 0 and len(ls_MaxTimestamp) > 0 then
		//This if condition was added 4.0.45 9/1/05 BKW.  Since we may now be refreshing shipments
		//whose timestamp is LESS than the max timestamp in the cache, we have to allow for the 
		//possibility that this is the ONLY thing being refreshed, and not set ss_Ships_Last_Change
		//unless the ls_MaxTimestamp value actually exceeds it.  (Previously, we could assume it exceeded it,
		//because we were only refreshing rows whose timestamp exceeded ss_Ships_Last_Change)
		
		IF ls_MaxTimestamp > ss_employees_Last_Change THEN
			ss_employees_last_change = ls_MaxTimestamp
		END IF
	END IF
	sdt_employees_refreshed = datetime(today(), now())
	sdt_employees_updated = sdt_employees_refreshed

	IF lb_employeeCacheChanges THEN

		IF lnv_DateTime.of_SecondsAfter ( sdt_LastEmployeeCacheWrite, sdt_employees_Refreshed /*Now*/ ) < 3600 THEN
			//This workstation has written the file out within the last hour -- don't do it this time

		ELSEIF This.of_GetEmployeeCacheFile ( ls_employeeCacheFile ) = 1 THEN
			IF sds_employee.SaveAs ( ls_EmployeeCacheFile, PSReport!, FALSE /*No Col Headings (Parm Doesn't Apply*/ ) = 1 THEN
				sdt_LastEmployeeCacheWrite = sdt_Employees_Refreshed  /*Now*/
			END IF
		END IF

	END IF
	return 1
end if


RETURN li_Return
end function

public function integer of_populateextendedemployeedata (datastore ads_target);/*
	DEK 6-5-07  This function populates fields that are evaluated at run time.  The number of events, loads, equipment
	information stops and company ids.  Before we had the cache, these fields were populated by computed fields
	based on the groupings and sort order of the data.  The initial cache retrieve still uses these, but for writing
	out the file we read the current value from the computed field and put it in a computed column instead for each column
	that is related to a particular driver.
	
	No longer used on 6-13-07, this function can be modified if we ever have computed columns, and it can be called by of_refreshEmployees()
*/
Int	li_return = 1
//Long	ll_index
//Long	ll_max
//Long	ll_equipmentRow
//
//Long	ll_eventCount
//Long	ll_loadCount
//Long	ll_coId1
//Long	ll_coId2
//Long	ll_coid3
//Long	ll_coid4
//
//Long	ll_empID
//Long	ll_empID2
//
//String	ls_stop1
//String	ls_stop2
//String	ls_stop3
//String	ls_stop4
//String	ls_equip
//
//
//
//IF isValid(ads_target) THEN
//
//ELSE
//	li_Return = -1
//END IF
//
//IF li_Return = 1 THEN
//	ll_max = ads_target.rowCount()
//	FOR ll_index  = 1 TO ll_max
//
//		IF ll_index > 1 THEN
//			ll_empId2 = ll_empId
//		END IF
//		ll_empId = ads_target.getItemNumber( ll_index,"employees_em_id")
//		
//		IF ll_empId2 <> ll_empId THEN
//			setnull(ls_equip)
//			ll_equipmentRow = ads_target.find( "Not isNull(equipment_eq_ref) AND employees_em_id = "+ string( ll_empId ), ll_index, ll_max )
//			IF ll_equipmentRow > 0 THEN
//				ls_equip = ads_target.getITemString( ll_equipmentRow, "equipment_eq_ref" ) 
//			END IF
//			ll_eventCount = ads_target.getItemNumber( ll_index,"cf_events")
//			ll_loadCount = ads_target.getItemNumber( ll_index,"cf_loads")
//			ll_coId1 = ads_target.getItemNumber( ll_index,"compute_2")
//			ll_coId2 = ads_target.getItemNumber( ll_index,"compute_7")
//			ll_coid3 = ads_target.getItemNumber( ll_index,"pedning_events")
//			ll_coid4 = ads_target.getItemNumber( ll_index,"compute_9")
//			
//			ls_stop1 = ads_target.getItemString( ll_index,"cf_first_city")
//			ls_stop2 = ads_target.getItemString( ll_index,"compute_4")
//			ls_stop3 = ads_target.getItemString( ll_index,"compute_5")
//			ls_stop4 = ads_target.getItemString( ll_index,"cf_last_city")
//			//I may need to do tracter as well
//		END IF
//		
//		
//		IF not Isnull( ls_equip ) THEN
//			ads_target.setItem( ll_index, "equipment_eq_ref", ls_equip )
//		END IF
//		ads_target.setItem( ll_index, "eventcount", ll_eventCount )
//		ads_target.setItem( ll_index, "loadcount", ll_loadCount )
//		ads_target.setItem( ll_index, "companyid_1", ll_coid1 )
//		ads_target.setItem( ll_index, "companyid_2", ll_coId2 )
//		ads_target.setItem( ll_index, "companyid_3", ll_coId3 )
//		ads_target.setItem( ll_index, "companyid_4", ll_coId4 )
//		ads_target.setItem( ll_index, "stop_1", ls_stop1 )
//		ads_target.setItem( ll_index, "stop_2", ls_stop2 )
//		ads_target.setItem( ll_index, "secondtolaststop", ls_stop3 )
//		ads_target.setItem( ll_index, "laststop", ls_stop4 )
//	NEXT
//END IF
RETURN li_Return
end function

public function integer of_initializecurrentemployees (ref datastore ads_currentemployees);//DEK 6-4-07 This function initializes the current employee table with all the driver ids from the driver info.
//Returns 1 if success, -1 otherwise

//This doesn't require that their is nothing in the current_employee table to succeed.  Any drivers found
//in the current employee table already will not be readded, only new drivers will be added.
Int	li_return = 1
Long	ll_driverCount, ll_index
Long	ll_newRow
Long	ll_driverID

Boolean	lb_update
datastore	lds_driverlist

IF isValid( ads_currentEmployees ) THEN
	lds_driverList = create datastore
	lds_driverLIst.dataobject = "d_emp_list"
	lds_driverList.settransobject( SQLCA )
	IF lds_driverList.retrieve() <> -1 THEN
		commit;
	ELSE
		rollback;
		li_Return = -1
	END IF
ELSE
	li_return = -1
END IF

IF li_Return = 1 THEN
	//we only care about drivers.
	lds_driverlist.setFilter( "not isnull(di_id)" )
	lds_driverlist.filter()
	ll_driverCount = lds_driverList.rowCount()
	
	FOR ll_index = 1 TO ll_driverCount
		ll_driverId = lds_driverlist.getItemnumber( ll_index, "di_id" )
		
		IF ads_currentemployees.find( "ce_id = "+ string( ll_driverID ), 1, ads_currentemployees.rowCount()  ) = 0 THEN
			ll_newRow = ads_currentemployees.insertRow( 0 )
			
			IF ll_newRow > 0 THEN
				ads_currentEmployees.setItem( ll_newRow, "ce_id", ll_driverId ) 
				lb_update = true
			END IF
		END IF
	NEXT
	

END IF

IF lb_update and li_return = 1 THEN
	
	IF ads_currentEmployees.update() = 1 THEN
		commit;
		
		//since the time stamps are generated after a succesful insert, we want to reretrieve them so that
		//our current cash is current.
		IF ads_currentEmployees.retrieve() <> -1 THEN
			commit;
		ELSE
			rollback;
			li_return = -1
		END IF
	ELSE
		
		rollback;
		li_return = -1
	END IF
END IF
DESTROY lds_driverList
RETURN li_Return
end function

on n_cst_employeemanager.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_employeemanager.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//5-29-07 DEK
if not IsValid(sds_employee )  then

	sl_counter = 1
	sds_employee = create n_ds
	sds_employee.DataObject = "d_empcache"
	sb_employees_retrieved = FALSE
	sdt_employees_refreshed = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sdt_employees_updated = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	sds_employee.SetTransObject( sqlca )
	sdt_LastEmployeeCacheWrite = DateTime( Date( 1970, 1, 1 ), Time( 0, 0, 0 ) )
	ss_employees_last_change = ""
	SetNull ( ss_EmployeeCacheFile )
else
	sl_counter ++
end if
end event

event destructor;//DEK 5-29-07
sl_counter --


if sl_counter = 0 then
	//DESTROY sds_employee
end if


end event

