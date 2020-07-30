$PBExportHeader$n_cst_beo_employee.sru
$PBExportComments$Employee (Persistent Class from PBL map PTData) //@(*)[84888599|1474]
forward
global type n_cst_beo_employee from n_cst_beo
end type
end forward

global type n_cst_beo_employee from n_cst_beo
end type
global n_cst_beo_employee n_cst_beo_employee

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_beo inv_entity //@(*)[84888599|1474:entity]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

//Note: At present, these are only implemented on 
//n_cst_EmployeeManager, not in ue_Describe on the beo
Constant Integer	ci_DescribeType_FirstLast = 100
Constant Integer	ci_DescribeType_LastFirst = 101
end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function Long of_GetId ()
public function Integer of_SetId (Long al_id)
public function String of_GetSalutation ()
public function Integer of_SetSalutation (String as_salutation)
public function String of_GetFirstname ()
public function Integer of_SetFirstname (String as_firstname)
public function String of_GetMiddlename ()
public function Integer of_SetMiddlename (String as_middlename)
public function String of_GetLastname ()
public function Integer of_SetLastname (String as_lastname)
public function String of_GetEmployeeid ()
public function Integer of_SetEmployeeid (String as_employeeid)
public function String of_GetStatus ()
public function Integer of_SetStatus (String as_status)
public function String of_GetPassword ()
public function Integer of_SetPassword (String as_password)
public function String of_GetMaxpermit ()
public function Integer of_SetMaxpermit (String as_maxpermit)
public function String of_GetItinpermit ()
public function Integer of_SetItinpermit (String as_itinpermit)
public function String of_GetSsn ()
public function Integer of_SetSsn (String as_ssn)
public function Date of_GetDob ()
public function Integer of_SetDob (Date ad_dob)
public function Date of_GetStartdate ()
public function Integer of_SetStartdate (Date ad_startdate)
public function Integer of_GetType ()
public function Integer of_SetType (Integer ai_type)
public function String of_GetPhone ()
public function Integer of_SetPhone (String as_phone)
public function String of_GetSex ()
public function Integer of_SetSex (String as_sex)
public function String of_GetAddress1 ()
public function Integer of_SetAddress1 (String as_address1)
public function String of_GetCity ()
public function Integer of_SetCity (String as_city)
public function String of_GetState ()
public function Integer of_SetState (String as_state)
public function String of_GetZip ()
public function Integer of_SetZip (String as_zip)
public function String of_GetTitle ()
public function Integer of_SetTitle (String as_title)
public function String of_GetEmergcontacthomephone ()
public function Integer of_SetEmergcontacthomephone (String as_emergcontacthomephone)
public function String of_GetEmergcontactrelation ()
public function Integer of_SetEmergcontactrelation (String as_emergcontactrelation)
public function String of_GetEmergcontactname ()
public function Integer of_SetEmergcontactname (String as_emergcontactname)
public function Long of_GetClass ()
public function Integer of_SetClass (Long al_class)
public function String of_GetEmergcontactworkphone ()
public function Integer of_SetEmergcontactworkphone (String as_emergcontactworkphone)
public function Date of_GetStopdate ()
public function Integer of_SetStopdate (Date ad_stopdate)
public function String of_GetOnhold ()
public function Integer of_SetOnhold (String as_onhold)
public function String of_GetEmail ()
public function Integer of_SetEmail (String as_email)
public function String of_GetNickname ()
public function Integer of_SetNickname (String as_nickname)
public function Long of_GetPager ()
public function Integer of_SetPager (Long al_pager)
public function String of_GetComments ()
public function Integer of_SetComments (String as_comments)
public function String of_GetRestrictedcomments ()
public function Integer of_SetRestrictedcomments (String as_restrictedcomments)
public function n_cst_beo of_GetEntity ()
public function n_cst_beo of_GetEntity (String as_query)
public function Integer of_SetEntity (n_cst_beo anv_entity)
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_employee")
inv_bcm.RegisterAttribute("id", "long") //@(*)[84889011|1475]
inv_bcm.SetKey("id")
inv_bcm.RegisterAttribute("salutation", "character(4)") //@(*)[84889085|1476]
inv_bcm.RegisterAttribute("firstname", "string(15)") //@(*)[84889134|1477]
inv_bcm.RegisterAttribute("middlename", "string(15)") //@(*)[84889177|1478]
inv_bcm.RegisterAttribute("lastname", "string(25)") //@(*)[84889217|1479]
inv_bcm.RegisterAttribute("employeeid", "string(8)") //@(*)[84889272|1480]
inv_bcm.RegisterAttribute("status", "character(1)") //@(*)[84889327|1481]
inv_bcm.RegisterAttribute("password", "string(8)") //@(*)[84889368|1482]
inv_bcm.RegisterAttribute("maxpermit", "character(1)") //@(*)[84889423|1483]
inv_bcm.RegisterAttribute("itinpermit", "character(1)") //@(*)[84889478|1484]
inv_bcm.RegisterAttribute("ssn", "character(9)") //@(*)[84889519|1485]
inv_bcm.RegisterAttribute("dob", "date") //@(*)[84889574|1486]
inv_bcm.RegisterAttribute("startdate", "date") //@(*)[84889642|1487]
inv_bcm.RegisterAttribute("type", "integer") //@(*)[84889698|1488]
inv_bcm.RegisterAttribute("phone", "character(14)") //@(*)[84889752|1489]
inv_bcm.RegisterAttribute("sex", "character(1)") //@(*)[84889808|1490]
inv_bcm.RegisterAttribute("address1", "string(50)") //@(*)[84889862|1491]
inv_bcm.RegisterAttribute("city", "string(25)") //@(*)[84889917|1492]
inv_bcm.RegisterAttribute("state", "character(3)") //@(*)[84889972|1493]
inv_bcm.RegisterAttribute("zip", "character(9)") //@(*)[84890027|1494]
inv_bcm.RegisterAttribute("title", "string(25)") //@(*)[84890082|1495]
inv_bcm.RegisterAttribute("emergcontacthomephone", "character(14)") //@(*)[84890137|1496]
inv_bcm.RegisterAttribute("emergcontactrelation", "string(15)") //@(*)[84890206|1497]
inv_bcm.RegisterAttribute("emergcontactname", "string(15)") //@(*)[84890260|1498]
inv_bcm.RegisterAttribute("class", "long") //@(*)[84890315|1499]
inv_bcm.RegisterAttribute("emergcontactworkphone", "character(14)") //@(*)[84890370|1500]
inv_bcm.RegisterAttribute("stopdate", "date") //@(*)[84890439|1501]
inv_bcm.RegisterAttribute("onhold", "character(1)") //@(*)[84890494|1502]
inv_bcm.RegisterAttribute("email", "character(40)") //@(*)[84890563|1503]
inv_bcm.RegisterAttribute("nickname", "character(20)") //@(*)[84890618|1504]
inv_bcm.RegisterAttribute("pager", "long") //@(*)[84890686|1505]
inv_bcm.RegisterAttribute("comments", "string(32767)") //@(*)[84891002|1510]
inv_bcm.RegisterAttribute("restrictedcomments", "string(32767)") //@(*)[84891071|1511]
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "employees", "em_id")
   inv_bcm.MapDBColumn("salutation", "employees", "em_sal")
   inv_bcm.MapDBColumn("firstname", "employees", "em_fn")
   inv_bcm.MapDBColumn("middlename", "employees", "em_mn")
   inv_bcm.MapDBColumn("lastname", "employees", "em_ln")
   inv_bcm.MapDBColumn("employeeid", "employees", "em_ref")
   inv_bcm.MapDBColumn("status", "employees", "em_status")
   inv_bcm.MapDBColumn("password", "employees", "em_password")
   inv_bcm.MapDBColumn("maxpermit", "employees", "em_max_permit")
   inv_bcm.MapDBColumn("itinpermit", "employees", "em_itin_permit")
   inv_bcm.MapDBColumn("ssn", "employees", "em_ss")
   inv_bcm.MapDBColumn("dob", "employees", "em_dob")
   inv_bcm.MapDBColumn("startdate", "employees", "em_start_date")
   inv_bcm.MapDBColumn("type", "employees", "em_type")
   inv_bcm.MapDBColumn("phone", "employees", "em_tele")
   inv_bcm.MapDBColumn("sex", "employees", "em_sex")
   inv_bcm.MapDBColumn("address1", "employees", "em_street")
   inv_bcm.MapDBColumn("city", "employees", "em_city")
   inv_bcm.MapDBColumn("state", "employees", "em_state")
   inv_bcm.MapDBColumn("zip", "employees", "em_zip")
   inv_bcm.MapDBColumn("title", "employees", "em_title")
   inv_bcm.MapDBColumn("emergcontacthomephone", "employees", "em_emerg_h")
   inv_bcm.MapDBColumn("emergcontactrelation", "employees", "em_emerg_rel")
   inv_bcm.MapDBColumn("emergcontactname", "employees", "em_emerg_name")
   inv_bcm.MapDBColumn("class", "employees", "em_class")
   inv_bcm.MapDBColumn("emergcontactworkphone", "employees", "em_emerg_w")
   inv_bcm.MapDBColumn("stopdate", "employees", "em_stop_date")
   inv_bcm.MapDBColumn("onhold", "employees", "em_on_hold")
   inv_bcm.MapDBColumn("email", "employees", "em_email")
   inv_bcm.MapDBColumn("nickname", "employees", "em_nickname")
   inv_bcm.MapDBColumn("pager", "employees", "em_pager")
   inv_bcm.MapDBColumn("comments", "employees", "em_comments")
   inv_bcm.MapDBColumn("restrictedcomments", "employees", "em_restrictedcomments")
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
 case "id" 
   return of_SetId(Long(aa_value))
 case "salutation" 
   return of_SetSalutation(String(aa_value))
 case "firstname" 
   return of_SetFirstname(String(aa_value))
 case "middlename" 
   return of_SetMiddlename(String(aa_value))
 case "lastname" 
   return of_SetLastname(String(aa_value))
 case "employeeid" 
   return of_SetEmployeeid(String(aa_value))
 case "status" 
   return of_SetStatus(String(aa_value))
 case "password" 
   return of_SetPassword(String(aa_value))
 case "maxpermit" 
   return of_SetMaxpermit(String(aa_value))
 case "itinpermit" 
   return of_SetItinpermit(String(aa_value))
 case "ssn" 
   return of_SetSsn(String(aa_value))
 case "dob" 
   return of_SetDob(Convert(aa_value, TypeDate!))
 case "startdate" 
   return of_SetStartdate(Convert(aa_value, TypeDate!))
 case "type" 
   return of_SetType(Integer(aa_value))
 case "phone" 
   return of_SetPhone(String(aa_value))
 case "sex" 
   return of_SetSex(String(aa_value))
 case "address1" 
   return of_SetAddress1(String(aa_value))
 case "city" 
   return of_SetCity(String(aa_value))
 case "state" 
   return of_SetState(String(aa_value))
 case "zip" 
   return of_SetZip(String(aa_value))
 case "title" 
   return of_SetTitle(String(aa_value))
 case "emergcontacthomephone" 
   return of_SetEmergcontacthomephone(String(aa_value))
 case "emergcontactrelation" 
   return of_SetEmergcontactrelation(String(aa_value))
 case "emergcontactname" 
   return of_SetEmergcontactname(String(aa_value))
 case "class" 
   return of_SetClass(Long(aa_value))
 case "emergcontactworkphone" 
   return of_SetEmergcontactworkphone(String(aa_value))
 case "stopdate" 
   return of_SetStopdate(Convert(aa_value, TypeDate!))
 case "onhold" 
   return of_SetOnhold(String(aa_value))
 case "email" 
   return of_SetEmail(String(aa_value))
 case "nickname" 
   return of_SetNickname(String(aa_value))
 case "pager" 
   return of_SetPager(Long(aa_value))
 case "comments" 
   return of_SetComments(String(aa_value))
 case "restrictedcomments" 
   return of_SetRestrictedcomments(String(aa_value))
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
 case "id" 
   aa_value = of_GetId()
   li_rc = 1
 case "salutation" 
   aa_value = of_GetSalutation()
   li_rc = 1
 case "firstname" 
   aa_value = of_GetFirstname()
   li_rc = 1
 case "middlename" 
   aa_value = of_GetMiddlename()
   li_rc = 1
 case "lastname" 
   aa_value = of_GetLastname()
   li_rc = 1
 case "employeeid" 
   aa_value = of_GetEmployeeid()
   li_rc = 1
 case "status" 
   aa_value = of_GetStatus()
   li_rc = 1
 case "password" 
   aa_value = of_GetPassword()
   li_rc = 1
 case "maxpermit" 
   aa_value = of_GetMaxpermit()
   li_rc = 1
 case "itinpermit" 
   aa_value = of_GetItinpermit()
   li_rc = 1
 case "ssn" 
   aa_value = of_GetSsn()
   li_rc = 1
 case "dob" 
   aa_value = of_GetDob()
   li_rc = 1
 case "startdate" 
   aa_value = of_GetStartdate()
   li_rc = 1
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
 case "phone" 
   aa_value = of_GetPhone()
   li_rc = 1
 case "sex" 
   aa_value = of_GetSex()
   li_rc = 1
 case "address1" 
   aa_value = of_GetAddress1()
   li_rc = 1
 case "city" 
   aa_value = of_GetCity()
   li_rc = 1
 case "state" 
   aa_value = of_GetState()
   li_rc = 1
 case "zip" 
   aa_value = of_GetZip()
   li_rc = 1
 case "title" 
   aa_value = of_GetTitle()
   li_rc = 1
 case "emergcontacthomephone" 
   aa_value = of_GetEmergcontacthomephone()
   li_rc = 1
 case "emergcontactrelation" 
   aa_value = of_GetEmergcontactrelation()
   li_rc = 1
 case "emergcontactname" 
   aa_value = of_GetEmergcontactname()
   li_rc = 1
 case "class" 
   aa_value = of_GetClass()
   li_rc = 1
 case "emergcontactworkphone" 
   aa_value = of_GetEmergcontactworkphone()
   li_rc = 1
 case "stopdate" 
   aa_value = of_GetStopdate()
   li_rc = 1
 case "onhold" 
   aa_value = of_GetOnhold()
   li_rc = 1
 case "email" 
   aa_value = of_GetEmail()
   li_rc = 1
 case "nickname" 
   aa_value = of_GetNickname()
   li_rc = 1
 case "pager" 
   aa_value = of_GetPager()
   li_rc = 1
 case "comments" 
   aa_value = of_GetComments()
   li_rc = 1
 case "restrictedcomments" 
   aa_value = of_GetRestrictedcomments()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[84889011|1475:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_SetId (Long al_id);//@(*)[84889011|1475:id:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetSalutation ();//@(*)[84889085|1476:salutation:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("salutation")
//@(text)--

end function

public function Integer of_SetSalutation (String as_salutation);//@(*)[84889085|1476:salutation:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "salutation" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("salutation", as_salutation) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetFirstname ();//@(*)[84889134|1477:firstname:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("firstname")
//@(text)--

end function

public function Integer of_SetFirstname (String as_firstname);//@(*)[84889134|1477:firstname:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "firstname" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("firstname", as_firstname) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetMiddlename ();//@(*)[84889177|1478:middlename:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("middlename")
//@(text)--

end function

public function Integer of_SetMiddlename (String as_middlename);//@(*)[84889177|1478:middlename:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "middlename" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("middlename", as_middlename) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetLastname ();//@(*)[84889217|1479:lastname:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("lastname")
//@(text)--

end function

public function Integer of_SetLastname (String as_lastname);//@(*)[84889217|1479:lastname:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "lastname" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("lastname", as_lastname) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEmployeeid ();//@(*)[84889272|1480:employeeid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("employeeid")
//@(text)--

end function

public function Integer of_SetEmployeeid (String as_employeeid);//@(*)[84889272|1480:employeeid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "employeeid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("employeeid", as_employeeid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetStatus ();//@(*)[84889327|1481:status:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("status")
//@(text)--

end function

public function Integer of_SetStatus (String as_status);//@(*)[84889327|1481:status:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "status" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("status", as_status) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetPassword ();//@(*)[84889368|1482:password:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("password")
//@(text)--

end function

public function Integer of_SetPassword (String as_password);//@(*)[84889368|1482:password:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "password" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("password", as_password) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetMaxpermit ();//@(*)[84889423|1483:maxpermit:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("maxpermit")
//@(text)--

end function

public function Integer of_SetMaxpermit (String as_maxpermit);//@(*)[84889423|1483:maxpermit:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "maxpermit" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("maxpermit", as_maxpermit) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetItinpermit ();//@(*)[84889478|1484:itinpermit:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("itinpermit")
//@(text)--

end function

public function Integer of_SetItinpermit (String as_itinpermit);//@(*)[84889478|1484:itinpermit:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "itinpermit" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("itinpermit", as_itinpermit) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSsn ();//@(*)[84889519|1485:ssn:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ssn")
//@(text)--

end function

public function Integer of_SetSsn (String as_ssn);//@(*)[84889519|1485:ssn:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ssn" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ssn", as_ssn) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Date of_GetDob ();//@(*)[84889574|1486:dob:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("dob")
//@(text)--

end function

public function Integer of_SetDob (Date ad_dob);//@(*)[84889574|1486:dob:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "dob" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("dob", ad_dob) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Date of_GetStartdate ();//@(*)[84889642|1487:startdate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("startdate")
//@(text)--

end function

public function Integer of_SetStartdate (Date ad_startdate);//@(*)[84889642|1487:startdate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "startdate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("startdate", ad_startdate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetType ();//@(*)[84889698|1488:type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("type")
//@(text)--

end function

public function Integer of_SetType (Integer ai_type);//@(*)[84889698|1488:type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("type", ai_type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetPhone ();//@(*)[84889752|1489:phone:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("phone")
//@(text)--

end function

public function Integer of_SetPhone (String as_phone);//@(*)[84889752|1489:phone:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "phone" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("phone", as_phone) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSex ();//@(*)[84889808|1490:sex:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("sex")
//@(text)--

end function

public function Integer of_SetSex (String as_sex);//@(*)[84889808|1490:sex:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "sex" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("sex", as_sex) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetAddress1 ();//@(*)[84889862|1491:address1:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("address1")
//@(text)--

end function

public function Integer of_SetAddress1 (String as_address1);//@(*)[84889862|1491:address1:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "address1" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("address1", as_address1) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetCity ();//@(*)[84889917|1492:city:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("city")
//@(text)--

end function

public function Integer of_SetCity (String as_city);//@(*)[84889917|1492:city:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "city" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("city", as_city) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetState ();//@(*)[84889972|1493:state:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("state")
//@(text)--

end function

public function Integer of_SetState (String as_state);//@(*)[84889972|1493:state:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "state" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("state", as_state) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetZip ();//@(*)[84890027|1494:zip:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("zip")
//@(text)--

end function

public function Integer of_SetZip (String as_zip);//@(*)[84890027|1494:zip:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "zip" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("zip", as_zip) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetTitle ();//@(*)[84890082|1495:title:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("title")
//@(text)--

end function

public function Integer of_SetTitle (String as_title);//@(*)[84890082|1495:title:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "title" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("title", as_title) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEmergcontacthomephone ();//@(*)[84890137|1496:emergcontacthomephone:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("emergcontacthomephone")
//@(text)--

end function

public function Integer of_SetEmergcontacthomephone (String as_emergcontacthomephone);//@(*)[84890137|1496:emergcontacthomephone:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "emergcontacthomephone" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("emergcontacthomephone", as_emergcontacthomephone) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEmergcontactrelation ();//@(*)[84890206|1497:emergcontactrelation:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("emergcontactrelation")
//@(text)--

end function

public function Integer of_SetEmergcontactrelation (String as_emergcontactrelation);//@(*)[84890206|1497:emergcontactrelation:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "emergcontactrelation" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("emergcontactrelation", as_emergcontactrelation) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEmergcontactname ();//@(*)[84890260|1498:emergcontactname:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("emergcontactname")
//@(text)--

end function

public function Integer of_SetEmergcontactname (String as_emergcontactname);//@(*)[84890260|1498:emergcontactname:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "emergcontactname" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("emergcontactname", as_emergcontactname) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetClass ();//@(*)[84890315|1499:class:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("class")
//@(text)--

end function

public function Integer of_SetClass (Long al_class);//@(*)[84890315|1499:class:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "class" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("class", al_class) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEmergcontactworkphone ();//@(*)[84890370|1500:emergcontactworkphone:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("emergcontactworkphone")
//@(text)--

end function

public function Integer of_SetEmergcontactworkphone (String as_emergcontactworkphone);//@(*)[84890370|1500:emergcontactworkphone:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "emergcontactworkphone" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("emergcontactworkphone", as_emergcontactworkphone) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Date of_GetStopdate ();//@(*)[84890439|1501:stopdate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("stopdate")
//@(text)--

end function

public function Integer of_SetStopdate (Date ad_stopdate);//@(*)[84890439|1501:stopdate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "stopdate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("stopdate", ad_stopdate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetOnhold ();//@(*)[84890494|1502:onhold:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("onhold")
//@(text)--

end function

public function Integer of_SetOnhold (String as_onhold);//@(*)[84890494|1502:onhold:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "onhold" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("onhold", as_onhold) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetEmail ();//@(*)[84890563|1503:email:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("email")
//@(text)--

end function

public function Integer of_SetEmail (String as_email);//@(*)[84890563|1503:email:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "email" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("email", as_email) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetNickname ();//@(*)[84890618|1504:nickname:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("nickname")
//@(text)--

end function

public function Integer of_SetNickname (String as_nickname);//@(*)[84890618|1504:nickname:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "nickname" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("nickname", as_nickname) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetPager ();//@(*)[84890686|1505:pager:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("pager")
//@(text)--

end function

public function Integer of_SetPager (Long al_pager);//@(*)[84890686|1505:pager:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "pager" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("pager", al_pager) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetComments ();//@(*)[84891002|1510:comments:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("comments")
//@(text)--

end function

public function Integer of_SetComments (String as_comments);//@(*)[84891002|1510:comments:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "comments" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("comments", as_comments) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRestrictedcomments ();//@(*)[84891071|1511:restrictedcomments:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("restrictedcomments")
//@(text)--

end function

public function Integer of_SetRestrictedcomments (String as_restrictedcomments);//@(*)[84891071|1511:restrictedcomments:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "restrictedcomments" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("restrictedcomments", as_restrictedcomments) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_GetEntity ();//@(*)[88497218|1514:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetEntity(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetEntity (String as_query);//@(*)[88497218|1514]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_entity = GetRelationship( inv_entity, "n_cst_dlkc_entity",  "entity", "employee", as_query, "n_cst_beo_entity" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_entity
//@(text)--

end function

public function Integer of_SetEntity (n_cst_beo anv_entity);//@(*)[88497218|1514:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_entity,"entity") = 1 then
inv_entity = anv_entity
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

on n_cst_beo_employee.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_employee.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

