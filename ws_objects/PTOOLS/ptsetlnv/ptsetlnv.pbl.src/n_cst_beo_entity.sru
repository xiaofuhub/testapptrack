$PBExportHeader$n_cst_beo_entity.sru
$PBExportComments$Entity (Persistent Class from PBL map PTSetl) //@(*)[104234622|62]
forward
global type n_cst_beo_entity from n_cst_beo
end type
end forward

shared variables
//This value is used by of_GetPayablesId to record which
//derivation for PayablesId to used, once it's determined
//the first time, based on acctlink settings.
//Value are cs_PayablesIdType_Name, 
//cs_PayablesIdType_AcctCode, 
//cs_PayablesIdType_Unknown


////begin modification Shared Variables by appeon  20070730
//String	ss_PayablesIdType
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_beo_entity from n_cst_beo
end type
global n_cst_beo_entity n_cst_beo_entity

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_bcm inv_amountowed //@(*)[370004321|307:amountowed]<nosync>
private n_cst_bcm inv_transaction //@(*)[370292092|308:transaction]<nosync>
private n_cst_bcm inv_join_entity_amounttemplate //@(*)[57511999|1459:join_entity_amounttemplate]<nosync>
private n_cst_bcm inv_amounttemplate //@(*)[57511999|1459:amounttemplate]<nosync>
private n_cst_beo inv_employee //@(*)[104234622|62:employee]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

String	cs_PayablesIdType_Name = "Name"
String	cs_PayablesIdType_AcctCode = "AcctCode"
String	cs_PayablesIdType_Unknown = "Unknown"
n_ds	ids_EmployeeCache


//begin modification Shared Variables by appeon  20070730
String	ss_PayablesIdType
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly string as_name, readonly any aa_value)
protected function integer getattribute (readonly string as_name, ref any aa_value)
public function Long of_GetId ()
public function Integer of_SetId (Long al_id)
public function n_cst_bcm of_GetAmountowed (String as_query)
public function n_cst_bcm of_GetAmountowed ()
public function n_cst_bcm of_GetTransaction (String as_query)
public function n_cst_bcm of_GetTransaction ()
public function string of_getentityid ()
public function n_cst_bcm of_GetJoin_entity_amounttemplate (String as_query)
public function n_cst_bcm of_GetJoin_entity_amounttemplate ()
public function n_cst_bcm of_GetAmounttemplate (String as_query)
public function n_cst_bcm of_GetAmounttemplate ()
public function Long of_GetFkemployee ()
public function Integer of_SetFkemployee (Long al_fkemployee)
public function Long of_GetCompanyid ()
public function Integer of_SetCompanyid (Long al_companyid)
public function n_cst_beo of_GetEmployee ()
public function n_cst_beo of_GetEmployee (String as_query)
public function Integer of_SetEmployee (n_cst_beo anv_employee)
public function String of_GetReceivablesid ()
public function Integer of_SetReceivablesid (String as_receivablesid)
public function string of_getpayablesid ()
public function Integer of_SetPayablesid (String as_payablesid)
public function String of_GetPayrollid ()
public function Integer of_SetPayrollid (String as_payrollid)
public function String of_getname ()
public function Integer of_GetDivision ()
public function Integer of_SetDivision (Integer ai_division)
protected subroutine of_initializepayablesidtype (readonly boolean ab_forcerefresh)
public function string of_getfuelcardfeemarkup ()
public function integer of_setfuelcardfeemarkup (string as_fuelcardfeemarkup)
public function n_ds of_getemployeecache ()
public function integer of_getemployeetype (readonly long al_employeeid)
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_entity")
inv_bcm.RegisterAttribute("id", "long") //@(*)[88631486|88]
inv_bcm.SetKey("id")
inv_bcm.RegisterRelationshipAttribute("fkemployee", "long", "n_cst_beo_employee", "id", "employee")
inv_bcm.RegisterAttribute("companyid", "long") //@(*)[92367888|1515]
inv_bcm.RegisterAttribute("receivablesid", "string(32767)") //@(*)[95681234|1516]
inv_bcm.RegisterAttribute("payablesid", "string(32767)") //@(*)[95819080|1517]
inv_bcm.RegisterAttribute("payrollid", "string(32767)") //@(*)[96149312|1519]
inv_bcm.RegisterAttribute("division", "integer") //@(*)[72687988|1666]
inv_bcm.RegisterAttribute("fuelcardfeemarkup", "string(32767)")  //Added manually
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "Entity", "Id")
   inv_bcm.MapDBColumn("fkemployee", "Entity", "fkEmployee")
   inv_bcm.MapDBColumn("companyid", "Entity", "fkCompany")
   inv_bcm.MapDBColumn("receivablesid", "Entity", "ReceivablesId")
   inv_bcm.MapDBColumn("payablesid", "Entity", "PayablesId")
   inv_bcm.MapDBColumn("payrollid", "Entity", "PayrollId")
   inv_bcm.MapDBColumn("division", "Entity", "Division")
   inv_bcm.MapDBColumn("fuelcardfeemarkup", "Entity", "FuelCardFeeMarkup")
end if 
//@(text)--


return 1
end function

protected function integer setattribute (readonly string as_name, readonly any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
int li_rc

li_rc = super::SetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "id" 
   return of_SetId(Long(aa_value))
 case "fkemployee" 
   return of_SetFkemployee(Long(aa_value))
 case "companyid" 
   return of_SetCompanyid(Long(aa_value))
 case "receivablesid" 
   return of_SetReceivablesid(String(aa_value))
 case "payablesid" 
   return of_SetPayablesid(String(aa_value))
 case "payrollid" 
   return of_SetPayrollid(String(aa_value))
 case "division" 
   return of_SetDivision(Integer(aa_value))
 case "fuelcardfeemarkup" 
   return of_SetFuelCardFeeMarkup(String(aa_value))
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return 0
//@(text)--

end function

protected function integer getattribute (readonly string as_name, ref any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
integer li_rc

li_rc = super::GetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "id" 
   aa_value = of_GetId()
   li_rc = 1
 case "fkemployee" 
   aa_value = of_GetFkemployee()
   li_rc = 1
 case "companyid" 
   aa_value = of_GetCompanyid()
   li_rc = 1
 case "receivablesid" 
   aa_value = of_GetReceivablesid()
   li_rc = 1
 case "payablesid" 
   aa_value = of_GetPayablesid()
   li_rc = 1
 case "payrollid" 
   aa_value = of_GetPayrollid()
   li_rc = 1
 case "division" 
   aa_value = of_GetDivision()
   li_rc = 1
 case "fuelcardfeemarkup" 
   aa_value = of_GetFuelCardFeeMarkup()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[88631486|88:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_SetId (Long al_id);//@(*)[88631486|88:id:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "id" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("id", al_id) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_bcm of_GetAmountowed (String as_query);//@(*)[370004321|307]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_amountowed = GetRelationship( inv_amountowed, "n_cst_dlkc_amountowed", "amountowed", "entity", as_query )
inv_amountowed.AddClass("n_cst_beo_amountowed")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_amountowed
//@(text)--

end function

public function n_cst_bcm of_GetAmountowed ();//@(*)[370004321|307:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetAmountowed(ls_dlkname)
//@(text)--

end function

public function n_cst_bcm of_GetTransaction (String as_query);//@(*)[370292092|308]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_transaction = GetRelationship( inv_transaction, "n_cst_dlkc_transaction", "transaction", "entity", as_query )
inv_transaction.AddClass("n_cst_beo_transaction")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_transaction
//@(text)--

end function

public function n_cst_bcm of_GetTransaction ();//@(*)[370292092|308:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetTransaction(ls_dlkname)
//@(text)--

end function

public function string of_getentityid ();
RETURN ""
end function

public function n_cst_bcm of_GetJoin_entity_amounttemplate (String as_query);//@(*)[57511999|1459:j]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_join_entity_amounttemplate = GetRelationship( inv_join_entity_amounttemplate, "n_cst_dlkc_join_entity_amounttemplate", "join_entity_amounttemplate", "entity", as_query )
inv_join_entity_amounttemplate.AddClass("n_cst_beo_join_entity_amounttemplate")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_join_entity_amounttemplate
//@(text)--

end function

public function n_cst_bcm of_GetJoin_entity_amounttemplate ();//@(*)[57511999|1459:j:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetJoin_entity_amounttemplate(ls_dlkname)
//@(text)--

end function

public function n_cst_bcm of_GetAmounttemplate (String as_query);//@(*)[57511999|1459]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_amounttemplate = GetRelationship( inv_amounttemplate, "n_cst_dlkc_amounttemplate", "amounttemplate", "entity", as_query )
inv_amounttemplate.AddClass("n_cst_beo_amounttemplate")
//@(text)--

//??Not sure if this is kosher, or the best way of doing this.  But, without this, the 
//ids_View on the bcm did not have its DataWindow.Table.UpdateTable property set (correctly).
//So, in order for this bcm to be useful, I had to add this.  [BKW]
//Also, the generated code above already assumes a valid bcm, so we'd have already crashed
//if it isn't.
inv_AmountTemplate.GetView ( ).Object.DataWindow.Table.UpdateTable = "AmountTemplate"

//@(text)(recreate=yes)<Return BCM>
return inv_amounttemplate
//@(text)--

end function

public function n_cst_bcm of_GetAmounttemplate ();//@(*)[57511999|1459:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetAmounttemplate(ls_dlkname)
//@(text)--

end function

public function Long of_GetFkemployee ();//@(*)[84889011|1475:fkemployee:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fkemployee")
//@(text)--

end function

public function Integer of_SetFkemployee (Long al_fkemployee);//@(*)[84889011|1475:fkemployee:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fkemployee" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fkemployee", al_fkemployee) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetCompanyid ();//@(*)[92367888|1515:companyid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("companyid")
//@(text)--

end function

public function Integer of_SetCompanyid (Long al_companyid);//@(*)[92367888|1515:companyid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "companyid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("companyid", al_companyid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_GetEmployee ();//@(*)[88497218|1514:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetEmployee(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetEmployee (String as_query);//@(*)[88497218|1514]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_employee = GetRelationship( inv_employee, "n_cst_dlkc_employee",  "employee", "entity", as_query, "n_cst_beo_employee" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_employee
//@(text)--

end function

public function Integer of_SetEmployee (n_cst_beo anv_employee);//@(*)[88497218|1514:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_employee,"employee") = 1 then
inv_employee = anv_employee
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function String of_GetReceivablesid ();//@(*)[95681234|1516:receivablesid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("receivablesid")
//@(text)--

end function

public function Integer of_SetReceivablesid (String as_receivablesid);//@(*)[95681234|1516:receivablesid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "receivablesid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("receivablesid", as_receivablesid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function string of_getpayablesid ();//@(*)[95819080|1517:payablesid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<body>
//return GetValue("payablesid")
//@(text)--

String	ls_PayablesId
Long		ll_CompanyId
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

ls_PayablesId = This.GetValue("payablesid")

IF IsNull ( ls_PayablesId ) OR Len ( Trim ( ls_PayablesId ) ) = 0 THEN

	ll_CompanyId = This.of_GetCompanyId ( )

	IF NOT IsNull ( ll_CompanyId ) THEN

		gnv_cst_Companies.of_Cache ( ll_CompanyId, FALSE )
		lnv_Company.of_SetUseCache ( TRUE )
		lnv_Company.of_SetSourceId ( ll_CompanyId )

		IF lnv_Company.of_HasSource ( ) THEN

			IF ss_PayablesIdType = "" THEN  //Value has not been initialized
				This.of_InitializePayablesIdType ( FALSE /*Don't force refresh*/ )
			END IF

			CHOOSE CASE ss_PayablesIdType
	
			CASE cs_PayablesIdType_Name
				ls_PayablesId = lnv_Company.of_GetBillingName ( )

			CASE cs_PayablesIdType_AcctCode
				ls_PayablesId = lnv_Company.of_GetAccountingId ( )

			CASE ELSE  //Unknown, or nothing
				//No value available.

			END CHOOSE

		END IF

	END IF

END IF

//Clean up payables id ???  (Empty string, etc?)
DESTROY lnv_Company

RETURN ls_PayablesId
end function

public function Integer of_SetPayablesid (String as_payablesid);//@(*)[95819080|1517:payablesid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "payablesid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("payablesid", as_payablesid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetPayrollid ();//@(*)[96149312|1519:payrollid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("payrollid")
//@(text)--

end function

public function Integer of_SetPayrollid (String as_payrollid);//@(*)[96149312|1519:payrollid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "payrollid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("payrollid", as_payrollid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_getname ();//@(*)[96787012|1521]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=opt)<return value>
String ls_string
return ls_string
//@(text)--

end function

public function Integer of_GetDivision ();//@(*)[72687988|1666:division:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("division")
//@(text)--

end function

public function Integer of_SetDivision (Integer ai_division);//@(*)[72687988|1666:division:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "division" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("division", ai_division) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

protected subroutine of_initializepayablesidtype (readonly boolean ab_forcerefresh);//RDT 01-21-03 - changed code to check for left 25 chars.

//In cases where the PayablesId is not specified for CompanyEntities, we can use
//either the CompanyBillingName or the AccountingId as the value.  This function
//determines which of those values to use, depending on the accounting package, 
//and stores it in ss_PayablesIdType so we don't have to look it up every time.

Boolean	lb_Skip
String	ls_AcctLink
n_cst_Settings	lnv_Settings


IF ab_ForceRefresh THEN  //Don't skip.
	ss_PayablesIdType = ""   //Clear current value, if any.
ELSEIF ss_PayablesIdType = "" THEN  //Value not initialized.
	//Don't skip.
ELSE  //Value has been initialized.  Skip.
	lb_Skip = TRUE
END IF


IF NOT lb_Skip THEN

	CHOOSE CASE lnv_Settings.of_GetAcctLink ( ls_AcctLink )
	CASE 1  //Value present.
		//RDT 01-21-03 replaced following commented code to check for left 25 chars.
		//IF  Lower ( ls_AcctLink ) = "n_cst_acctlink_quickbooks" THEN
		IF  Left( Lower ( ls_AcctLink ), 25)  = "n_cst_acctlink_quickbooks" THEN
			ss_PayablesIdType = cs_PayablesIdType_Name
		ELSE
			ss_PayablesIdType = cs_PayablesIdType_AcctCode
		END IF

	CASE 0  //Value not present.

		ss_PayablesIdType = cs_PayablesIdtype_Unknown

	CASE ELSE  //Error

		//Leave uninitialized.

	END CHOOSE


END IF
end subroutine

public function string of_getfuelcardfeemarkup ();//Attribute was added manually.
return GetValue("fuelcardfeemarkup")


end function

public function integer of_setfuelcardfeemarkup (string as_fuelcardfeemarkup);integer li_rc = 1

// Validation logic for "fuelcardfeemarkup" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.


if li_rc > 0 then
   if SetValue("fuelcardfeemarkup", as_fuelcardfeemarkup) < 1 then
      li_rc = -1
   end if
end if

return li_rc


end function

public function n_ds of_getemployeecache ();// Creates employee cache and retrieves rows.


If NOT IsValid( ids_EmployeeCache ) Then 
	ids_EmployeeCache	= CREATE DataStore
	
	ids_EmployeeCache.dataobject = "d_EmployeeCache"
	
	ids_EmployeeCache.SetTransObject ( SQLCA )
	
	If ids_EmployeeCache.Retrieve ( ) < 1 Then 
		MessageBox("Program Error","Employee Retrieve Failed")
	End If
	
End If


Return ids_EmployeeCache
end function

public function integer of_getemployeetype (readonly long al_employeeid);// Get employee type from employee cache


Long		ll_FindRow

Integer	li_DriverType, &
			li_Return

IF al_employeeid > 0 THEN
	This.of_getemployeecache()
	ll_FindRow = ids_EmployeeCache.Find ( "em_id = " + String ( al_employeeid  ) , 1, ids_EmployeeCache.RowCount ( ) )

	
	IF ll_FindRow > 0 THEN
		
		li_DriverType = ids_EmployeeCache.object.di_type_driver[ ll_FindRow ]
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

on n_cst_beo_entity.create
call super::create
end on

on n_cst_beo_entity.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

event destructor;call super::destructor;If IsValid( ids_employeecache ) Then Destroy( ids_employeecache )

end event

