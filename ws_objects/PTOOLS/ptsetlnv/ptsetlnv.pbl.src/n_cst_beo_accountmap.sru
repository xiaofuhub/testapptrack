$PBExportHeader$n_cst_beo_accountmap.sru
$PBExportComments$AccountMap (Persistent Class from PBL map PTSetl) //@(*)[75486947|1605]
forward
global type n_cst_beo_accountmap from n_cst_beo
end type
end forward

global type n_cst_beo_accountmap from n_cst_beo
end type
global n_cst_beo_accountmap n_cst_beo_accountmap

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_beo inv_amounttype //@(*)[75486947|1605:amounttype]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function Integer of_GetAmounttypeid ()
public function Integer of_SetAmounttypeid (Integer ai_amounttypeid)
public function Integer of_GetDivision ()
public function Integer of_SetDivision (Integer ai_division)
public function String of_GetAraccount ()
public function Integer of_SetAraccount (String as_araccount)
public function String of_GetSalesaccount ()
public function Integer of_SetSalesaccount (String as_salesaccount)
public function String of_GetApaccount ()
public function Integer of_SetApaccount (String as_apaccount)
public function String of_GetCostaccount ()
public function Integer of_SetCostaccount (String as_costaccount)
public function n_cst_beo of_GetAmounttype ()
public function n_cst_beo of_GetAmounttype (String as_query)
public function Integer of_SetAmounttype (n_cst_beo anv_amounttype)
public function String of_GetPayrollcashaccount ()
public function Integer of_SetPayrollcashaccount (String as_payrollcashaccount)
public function String of_GetPayrollexpenseaccount ()
public function Integer of_SetPayrollexpenseaccount (String as_payrollexpenseaccount)
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_accountmap")
inv_bcm.RegisterRelationshipAttribute("amounttypeid", "integer", "n_cst_beo_amounttype", "id", "amounttype")
inv_bcm.RegisterAttribute("division", "integer") //@(*)[76025042|1613]
inv_bcm.SetKey("division")
inv_bcm.RegisterAttribute("araccount", "string(32767)") //@(*)[75796916|1609]
inv_bcm.RegisterAttribute("salesaccount", "string(32767)") //@(*)[75796970|1610]
inv_bcm.RegisterAttribute("apaccount", "string(32767)") //@(*)[75796998|1611]
inv_bcm.RegisterAttribute("costaccount", "string(32767)") //@(*)[75797026|1612]
inv_bcm.RegisterAttribute("payrollcashaccount", "string(32767)") //@(*)[173644059|1646]
inv_bcm.RegisterAttribute("payrollexpenseaccount", "string(32767)") //@(*)[173649099|1647]
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("amounttypeid", "AccountMap", "AmountTypeId")
   inv_bcm.MapDBColumn("division", "AccountMap", "Division")
   inv_bcm.MapDBColumn("araccount", "AccountMap", "ARAccount")
   inv_bcm.MapDBColumn("salesaccount", "AccountMap", "SalesAccount")
   inv_bcm.MapDBColumn("apaccount", "AccountMap", "APAccount")
   inv_bcm.MapDBColumn("costaccount", "AccountMap", "CostAccount")
   inv_bcm.MapDBColumn("payrollcashaccount", "AccountMap", "PayrollCashAccount")
   inv_bcm.MapDBColumn("payrollexpenseaccount", "AccountMap", "PayrollExpenseAccount")
end if 
//@(text)--


return 1
end function

protected function integer setattribute (readonly String as_name, readonly any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
int li_rc

li_rc = super::SetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "amounttypeid" 
   return of_SetAmounttypeid(Integer(aa_value))
 case "division" 
   return of_SetDivision(Integer(aa_value))
 case "araccount" 
   return of_SetAraccount(String(aa_value))
 case "salesaccount" 
   return of_SetSalesaccount(String(aa_value))
 case "apaccount" 
   return of_SetApaccount(String(aa_value))
 case "costaccount" 
   return of_SetCostaccount(String(aa_value))
 case "payrollcashaccount" 
   return of_SetPayrollcashaccount(String(aa_value))
 case "payrollexpenseaccount" 
   return of_SetPayrollexpenseaccount(String(aa_value))
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return 0
//@(text)--

end function

protected function integer getattribute (readonly String as_name, ref any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attribute Case>
integer li_rc

li_rc = super::GetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "amounttypeid" 
   aa_value = of_GetAmounttypeid()
   li_rc = 1
 case "division" 
   aa_value = of_GetDivision()
   li_rc = 1
 case "araccount" 
   aa_value = of_GetAraccount()
   li_rc = 1
 case "salesaccount" 
   aa_value = of_GetSalesaccount()
   li_rc = 1
 case "apaccount" 
   aa_value = of_GetApaccount()
   li_rc = 1
 case "costaccount" 
   aa_value = of_GetCostaccount()
   li_rc = 1
 case "payrollcashaccount" 
   aa_value = of_GetPayrollcashaccount()
   li_rc = 1
 case "payrollexpenseaccount" 
   aa_value = of_GetPayrollexpenseaccount()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Integer of_GetAmounttypeid ();//@(*)[209306953|546:amounttypeid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("amounttypeid")
//@(text)--

end function

public function Integer of_SetAmounttypeid (Integer ai_amounttypeid);//@(*)[209306953|546:amounttypeid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "amounttypeid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("amounttypeid", ai_amounttypeid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetDivision ();//@(*)[76025042|1613:division:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("division")
//@(text)--

end function

public function Integer of_SetDivision (Integer ai_division);//@(*)[76025042|1613:division:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetAraccount ();//@(*)[75796916|1609:araccount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("araccount")
//@(text)--

end function

public function Integer of_SetAraccount (String as_araccount);//@(*)[75796916|1609:araccount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "araccount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("araccount", as_araccount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSalesaccount ();//@(*)[75796970|1610:salesaccount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("salesaccount")
//@(text)--

end function

public function Integer of_SetSalesaccount (String as_salesaccount);//@(*)[75796970|1610:salesaccount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "salesaccount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("salesaccount", as_salesaccount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetApaccount ();//@(*)[75796998|1611:apaccount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("apaccount")
//@(text)--

end function

public function Integer of_SetApaccount (String as_apaccount);//@(*)[75796998|1611:apaccount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "apaccount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("apaccount", as_apaccount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetCostaccount ();//@(*)[75797026|1612:costaccount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("costaccount")
//@(text)--

end function

public function Integer of_SetCostaccount (String as_costaccount);//@(*)[75797026|1612:costaccount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "costaccount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("costaccount", as_costaccount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_GetAmounttype ();//@(*)[75673218|1608:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetAmounttype(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetAmounttype (String as_query);//@(*)[75673218|1608]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_amounttype = GetRelationship( inv_amounttype, "n_cst_dlkc_amounttype",  "amounttype", "accountmap", as_query, "n_cst_beo_amounttype" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_amounttype
//@(text)--

end function

public function Integer of_SetAmounttype (n_cst_beo anv_amounttype);//@(*)[75673218|1608:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_amounttype,"amounttype") = 1 then
inv_amounttype = anv_amounttype
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function String of_GetPayrollcashaccount ();//@(*)[173644059|1646:payrollcashaccount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("payrollcashaccount")
//@(text)--

end function

public function Integer of_SetPayrollcashaccount (String as_payrollcashaccount);//@(*)[173644059|1646:payrollcashaccount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "payrollcashaccount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("payrollcashaccount", as_payrollcashaccount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetPayrollexpenseaccount ();//@(*)[173649099|1647:payrollexpenseaccount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("payrollexpenseaccount")
//@(text)--

end function

public function Integer of_SetPayrollexpenseaccount (String as_payrollexpenseaccount);//@(*)[173649099|1647:payrollexpenseaccount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "payrollexpenseaccount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("payrollexpenseaccount", as_payrollexpenseaccount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

on n_cst_beo_accountmap.create
TriggerEvent(this, "constructor")
end on

on n_cst_beo_accountmap.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("amounttypeid")
this.SetRequired("division")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

