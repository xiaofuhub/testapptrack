$PBExportHeader$n_cst_beo_equipmentleasetype.sru
$PBExportComments$EquipmentLeaseType (Persistent Class from PBL map PTData) //@(*)[72656228|583]
forward
global type n_cst_beo_equipmentleasetype from n_cst_beo
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//Boolean	sb_HolidayExtraFreeDay
//Boolean   sb_HaveSetting
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_beo_equipmentleasetype from n_cst_beo
end type
global n_cst_beo_equipmentleasetype n_cst_beo_equipmentleasetype

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_bcm inv_equipmentlease //@(*)[63106059|918:equipmentlease]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Public Constant Integer	ci_CalendarDays = 1
Public Constant Integer	ci_WorkingDays = 2
Public Constant Integer	ci_Hours = 3
Public Constant Integer	ci_Notify = 1
Public Constant Integer	ci_Outgate = 2
Public Constant Integer	ci_Yes = 1
Public Constant Integer	ci_No = 0
Public Constant Integer	ci_Active = 1
Public Constant Integer	ci_DeActive = 0

//begin modification Shared Variables by appeon  20070730
Boolean	sb_HolidayExtraFreeDay
Boolean   sb_HaveSetting
//end modification Shared Variables by appeon  20070730


end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly string as_name, readonly any aa_value)
protected function integer getattribute (readonly string as_name, ref any aa_value)
public function Integer of_GetId ()
public function Integer of_SetId (Integer ai_id)
public function String of_GetLine ()
public function Integer of_SetLine (String as_line)
public function String of_GetType ()
public function Integer of_SetType (String as_type)
public function Integer of_GetFreetimeunits ()
public function Integer of_SetFreetimeunits (Integer ai_freetimeunits)
public function Integer of_GetFreetimeperiod ()
public function integer of_setfreetimeperiod (integer ai_freetimeperiod)
public function Integer of_GetChargedperiods ()
public function integer of_setchargedperiods (integer ai_chargedperiods)
public function Integer of_GetFirstchargedunits ()
public function Integer of_SetFirstchargedunits (Integer ai_firstchargedunits)
public function Integer of_GetFirstchargedperiod ()
public function integer of_setfirstchargedperiod (integer ai_firstchargedperiod)
public function Decimal of_GetFirstchargedrate ()
public function integer of_setfirstchargedrate (decimal ad_firstchargedrate)
public function Integer of_GetSecondchargedunits ()
public function Integer of_SetSecondchargedunits (Integer ai_secondchargedunits)
public function Integer of_GetSecondchargedperiod ()
public function integer of_setsecondchargedperiod (integer ai_secondchargedperiod)
public function Decimal of_GetSecondchargedrate ()
public function integer of_setsecondchargedrate (decimal ad_secondchargedrate)
public function Integer of_GetThirdchargedunits ()
public function Integer of_SetThirdchargedunits (Integer ai_thirdchargedunits)
public function Integer of_GetThirdchargedperiod ()
public function integer of_setthirdchargedperiod (integer ai_thirdchargedperiod)
public function Decimal of_GetThirdchargedrate ()
public function integer of_setthirdchargedrate (decimal ad_thirdchargedrate)
public function Integer of_GetFourthchargedunits ()
public function Integer of_SetFourthchargedunits (Integer ai_fourthchargedunits)
public function Integer of_GetFourthchargedperiod ()
public function integer of_setfourthchargedperiod (integer ai_fourthchargedperiod)
public function Decimal of_GetFourthchargedrate ()
public function integer of_setfourthchargedrate (decimal ad_fourthchargedrate)
public function integer of_getfreetimeexpiration (date ad_outdate, time at_outtime, ref date ad_expirationdate, ref time at_expirationtime)
public function integer of_getcharges (date ad_outdate, time at_outtime, ref decimal ad_charges)
public function integer of_getcharges (date ad_outdate, time at_outtime, date ad_returndate, time at_returntime, ref decimal ad_charges)
public function String of_GetSpec1 ()
public function Integer of_SetSpec1 (String as_spec1)
public function String of_GetSpec2 ()
public function Integer of_SetSpec2 (String as_spec2)
public function String of_GetSpec3 ()
public function Integer of_SetSpec3 (String as_spec3)
public function String of_GetSpec4 ()
public function Integer of_SetSpec4 (String as_spec4)
public function String of_GetSpec5 ()
public function Integer of_SetSpec5 (String as_spec5)
public function String of_GetUser1 ()
public function Integer of_SetUser1 (String as_user1)
public function String of_GetUser2 ()
public function Integer of_SetUser2 (String as_user2)
public function String of_GetNotes ()
public function Integer of_SetNotes (String as_notes)
public function n_cst_bcm of_GetEquipmentlease (String as_query)
public function n_cst_bcm of_GetEquipmentlease ()
public function integer of_getfreetimestart ()
public function time of_getfreetimefriday ()
public function integer of_getfreetimeweekend ()
public function integer of_getperdiemholiday ()
public function string of_getprefix ()
public function string of_getlength ()
public function integer of_setfreetimestart (integer ai_freetimestart)
public function integer of_setfreetimeholiday (time at_holiday)
public function integer of_setfreetimeweekend (integer ai_freetimeweekend)
public function integer of_setperdiemholiday (integer ai_perdiemholiday)
public function integer of_setprefix (string as_prefix)
public function integer of_setlength (string as_length)
public function integer of_getstatus ()
public function integer of_setstatus (integer ai_status)
public function time of_getfreetimeholiday ()
private function date of_calcfreefriday (date adt_dateout, time at_timeout, date adt_expiredate)
private function date of_calcfreeholiday (date adt_dateout, time at_timeout, date adt_expiredate)
private function date of_calcperdiemholiday (date adt_dateout, date adt_expiredate)
private function date of_calcfreeweekend (date adt_date)
public function integer of_setfreetimefriday (time at_FreeTimeFriday)
public function integer of_getcharges (date ad_outdate, time at_outtime, date ad_returndate, time at_returntime, ref n_cst_leasecharges anv_leasecharges)
private function boolean of_isholidayextrafreeday ()
public function string of_getscac ()
public function integer of_setscac (string as_scac)
public function integer of_setdayofinterchangecounts (integer ai_counts)
public function integer of_getdayofinterchangecounts ()
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_equipmentleasetype")
inv_bcm.RegisterAttribute("id", "integer") //@(*)[74094561|584]
inv_bcm.SetKey("id")
inv_bcm.RegisterAttribute("line", "string(30)") //@(*)[74455915|586]
inv_bcm.RegisterAttribute("type", "string(30)") //@(*)[74483972|587]
inv_bcm.RegisterAttribute("freetimeunits", "integer") //@(*)[74637300|588]
inv_bcm.RegisterAttribute("freetimeperiod", "integer") //@(*)[75689115|591]
inv_bcm.RegisterAttribute("chargedperiods", "integer") //@(*)[77109409|595]
inv_bcm.RegisterAttribute("firstchargedunits", "integer") //@(*)[76070028|593]
inv_bcm.RegisterAttribute("firstchargedperiod", "integer") //@(*)[76278015|594]
inv_bcm.RegisterAttribute("firstchargedrate", "decimal") //@(*)[77532727|596]
inv_bcm.RegisterAttribute("secondchargedunits", "integer") //@(*)[77595778|597]
inv_bcm.RegisterAttribute("secondchargedperiod", "integer") //@(*)[77798918|598]
inv_bcm.RegisterAttribute("secondchargedrate", "decimal") //@(*)[77828020|599]
inv_bcm.RegisterAttribute("thirdchargedunits", "integer") //@(*)[77842568|600]
inv_bcm.RegisterAttribute("thirdchargedperiod", "integer") //@(*)[77852068|601]
inv_bcm.RegisterAttribute("thirdchargedrate", "decimal") //@(*)[77866563|602]
inv_bcm.RegisterAttribute("fourthchargedunits", "integer") //@(*)[77879167|603]
inv_bcm.RegisterAttribute("fourthchargedperiod", "integer") //@(*)[77909371|604]
inv_bcm.RegisterAttribute("fourthchargedrate", "decimal") //@(*)[77987647|606]
inv_bcm.RegisterAttribute("spec1", "string(1)") //@(*)[65160321|933]
inv_bcm.RegisterAttribute("spec2", "string(1)") //@(*)[65171518|934]
inv_bcm.RegisterAttribute("spec3", "string(1)") //@(*)[65178537|935]
inv_bcm.RegisterAttribute("spec4", "string(1)") //@(*)[65193775|936]
inv_bcm.RegisterAttribute("spec5", "string(1)") //@(*)[65202775|937]
inv_bcm.RegisterAttribute("user1", "string(32767)") //@(*)[64145138|930]
inv_bcm.RegisterAttribute("user2", "string(32767)") //@(*)[64189453|931]
inv_bcm.RegisterAttribute("notes", "string(32767)") //@(*)[64200732|932]
// rdt 08/05/02
inv_bcm.RegisterAttribute("freetimestart","integer") 	// added manually
inv_bcm.RegisterAttribute("freetimefriday","time")  	// added manually
inv_bcm.RegisterAttribute("freetimeholiday","time")  	// added manually
inv_bcm.RegisterAttribute("freetimeweekend","integer")// added manually
inv_bcm.RegisterAttribute("perdiemholiday","integer") // added manually
inv_bcm.RegisterAttribute("leasestatus","integer")  		// added manually
inv_bcm.RegisterAttribute("lineprefix","string(32767)")  	// added manually
inv_bcm.RegisterAttribute("equipmentlength","string(12)")  		// added manually

inv_bcm.RegisterAttribute("scac","string(10)")  		// added manually
inv_bcm.RegisterAttribute("dayofinterchangecounts","integer")  		// added manually


//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "EquipmentLeaseType", "Id")
   inv_bcm.MapDBColumn("line", "EquipmentLeaseType", "Line")
   inv_bcm.MapDBColumn("type", "EquipmentLeaseType", "Type")
   inv_bcm.MapDBColumn("freetimeunits", "EquipmentLeaseType", "FreeTimeUnits")
   inv_bcm.MapDBColumn("freetimeperiod", "EquipmentLeaseType", "FreeTimePeriod")
   inv_bcm.MapDBColumn("chargedperiods", "EquipmentLeaseType", "ChargedPeriods")
   inv_bcm.MapDBColumn("firstchargedunits", "EquipmentLeaseType", "FirstChargedUnits")
   inv_bcm.MapDBColumn("firstchargedperiod", "EquipmentLeaseType", "FirstChargedPeriod")
   inv_bcm.MapDBColumn("firstchargedrate", "EquipmentLeaseType", "FirstChargedRate")
   inv_bcm.MapDBColumn("secondchargedunits", "EquipmentLeaseType", "SecondChargedUnits")
   inv_bcm.MapDBColumn("secondchargedperiod", "EquipmentLeaseType", "SecondChargedPeriod")
   inv_bcm.MapDBColumn("secondchargedrate", "EquipmentLeaseType", "SecondChargedRate")
   inv_bcm.MapDBColumn("thirdchargedunits", "EquipmentLeaseType", "ThirdChargedUnits")
   inv_bcm.MapDBColumn("thirdchargedperiod", "EquipmentLeaseType", "ThirdChargedPeriod")
   inv_bcm.MapDBColumn("thirdchargedrate", "EquipmentLeaseType", "ThirdChargedRate")
   inv_bcm.MapDBColumn("fourthchargedunits", "EquipmentLeaseType", "FourthChargedUnits")
   inv_bcm.MapDBColumn("fourthchargedperiod", "EquipmentLeaseType", "FourthChargedPeriod")
   inv_bcm.MapDBColumn("fourthchargedrate", "EquipmentLeaseType", "FourthChargedRate")
   inv_bcm.MapDBColumn("spec1", "EquipmentLeaseType", "Spec1")
   inv_bcm.MapDBColumn("spec2", "EquipmentLeaseType", "Spec2")
   inv_bcm.MapDBColumn("spec3", "EquipmentLeaseType", "Spec3")
   inv_bcm.MapDBColumn("spec4", "EquipmentLeaseType", "Spec4")
   inv_bcm.MapDBColumn("spec5", "EquipmentLeaseType", "Spec5")
   inv_bcm.MapDBColumn("user1", "EquipmentLeaseType", "User1")
   inv_bcm.MapDBColumn("user2", "EquipmentLeaseType", "User2")
   inv_bcm.MapDBColumn("notes", "EquipmentLeaseType", "Notes")
	// rdt 08/05/02
   inv_bcm.MapDBColumn("freetimestart", "EquipmentLeaseType", "Freetimestart")
   inv_bcm.MapDBColumn("freetimefriday", "EquipmentLeaseType", "Freetimefriday")
   inv_bcm.MapDBColumn("freetimeholiday", "EquipmentLeaseType", "Freetimeholiday")
   inv_bcm.MapDBColumn("freetimeweekend", "EquipmentLeaseType", "Freetimeweekend")
   inv_bcm.MapDBColumn("perdiemweekend", "EquipmentLeaseType", "Perdiemweekend")
   inv_bcm.MapDBColumn("perdiemholiday", "EquipmentLeaseType", "Perdiemholiday")
   inv_bcm.MapDBColumn("leasestatus", "EquipmentLeaseType", "LeaseStatus")
   inv_bcm.MapDBColumn("lineprefix", "EquipmentLeaseType", "LinePrefix")
   inv_bcm.MapDBColumn("equipmentlength", "EquipmentLeaseType", "EquipmentLength")
	
	inv_bcm.MapDBColumn("scac", "EquipmentLeaseType", "SCAC")
	inv_bcm.MapDBColumn("dayofinterchangecounts", "EquipmentLeaseType", "dayofinterchangecounts")

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
   return of_SetId(Integer(aa_value))
 case "line" 
   return of_SetLine(String(aa_value))
 case "type" 
   return of_SetType(String(aa_value))
 case "freetimeunits" 
   return of_SetFreetimeunits(Integer(aa_value))
 case "freetimeperiod" 
   return of_SetFreetimeperiod(Integer(aa_value))
 case "chargedperiods" 
   return of_SetChargedperiods(Integer(aa_value))
 case "firstchargedunits" 
   return of_SetFirstchargedunits(Integer(aa_value))
 case "firstchargedperiod" 
   return of_SetFirstchargedperiod(Integer(aa_value))
 case "firstchargedrate" 
   return of_SetFirstchargedrate(Dec(aa_value))
 case "secondchargedunits" 
   return of_SetSecondchargedunits(Integer(aa_value))
 case "secondchargedperiod" 
   return of_SetSecondchargedperiod(Integer(aa_value))
 case "secondchargedrate" 
   return of_SetSecondchargedrate(Dec(aa_value))
 case "thirdchargedunits" 
   return of_SetThirdchargedunits(Integer(aa_value))
 case "thirdchargedperiod" 
   return of_SetThirdchargedperiod(Integer(aa_value))
 case "thirdchargedrate" 
   return of_SetThirdchargedrate(Dec(aa_value))
 case "fourthchargedunits" 
   return of_SetFourthchargedunits(Integer(aa_value))
 case "fourthchargedperiod" 
   return of_SetFourthchargedperiod(Integer(aa_value))
 case "fourthchargedrate" 
   return of_SetFourthchargedrate(Dec(aa_value))
 case "spec1" 
   return of_SetSpec1(String(aa_value))
 case "spec2" 
   return of_SetSpec2(String(aa_value))
 case "spec3" 
   return of_SetSpec3(String(aa_value))
 case "spec4" 
   return of_SetSpec4(String(aa_value))
 case "spec5" 
   return of_SetSpec5(String(aa_value))
 case "user1" 
   return of_SetUser1(String(aa_value))
 case "user2" 
   return of_SetUser2(String(aa_value))
 case "notes" 
   return of_SetNotes(String(aa_value))
 // rdt 08/05/02
 case "freetimestart" 
   return of_SetFreeTimeStart(Integer(aa_value))
 // rdt - if aa_value is null the datatype is any, else the datatype is time. 
 // I'm not sure why yet and I'm running out of time to isolate. 
 // It may be related to the datawindow format and edit format in the presentation object.
 case "freetimefriday" 
	If IsNull(aa_value) Then 
   	Return of_SetFreeTimeFriday(time(aa_value))
	Else
   	Return of_SetFreeTimeFriday(aa_value)
	End if		
 case "freetimeholiday" 
	If IsNull(aa_value) Then 
   	return of_SetFreeTimeHoliday(Time(aa_value))
	Else
	   return of_SetFreeTimeHoliday(aa_value)
	End if		
 case "freetimeweekend" 
   return of_SetFreeTimeWeekend(Integer(aa_value))
 case "perdiemholiday" 
   return of_SetPerdiemHoliday(Integer(aa_value))
 case "leasestatus" 
   return of_SetStatus(Integer(aa_value))
 case "lineprefix" 
   return of_SetPrefix(String(aa_value))
 case "equipmentlength" 
   return of_SetLength(String(aa_value))

 case "scac" 
   return of_Setscac(String(aa_value))

 case "dayofinterchangecounts" 
   return of_setdayofinterchangecounts( Integer(aa_value) )

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
 case "line" 
   aa_value = of_GetLine()
   li_rc = 1
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
 case "freetimeunits" 
   aa_value = of_GetFreetimeunits()
   li_rc = 1
 case "freetimeperiod" 
   aa_value = of_GetFreetimeperiod()
   li_rc = 1
 case "chargedperiods" 
   aa_value = of_GetChargedperiods()
   li_rc = 1
 case "firstchargedunits" 
   aa_value = of_GetFirstchargedunits()
   li_rc = 1
 case "firstchargedperiod" 
   aa_value = of_GetFirstchargedperiod()
   li_rc = 1
 case "firstchargedrate" 
   aa_value = of_GetFirstchargedrate()
   li_rc = 1
 case "secondchargedunits" 
   aa_value = of_GetSecondchargedunits()
   li_rc = 1
 case "secondchargedperiod" 
   aa_value = of_GetSecondchargedperiod()
   li_rc = 1
 case "secondchargedrate" 
   aa_value = of_GetSecondchargedrate()
   li_rc = 1
 case "thirdchargedunits" 
   aa_value = of_GetThirdchargedunits()
   li_rc = 1
 case "thirdchargedperiod" 
   aa_value = of_GetThirdchargedperiod()
   li_rc = 1
 case "thirdchargedrate" 
   aa_value = of_GetThirdchargedrate()
   li_rc = 1
 case "fourthchargedunits" 
   aa_value = of_GetFourthchargedunits()
   li_rc = 1
 case "fourthchargedperiod" 
   aa_value = of_GetFourthchargedperiod()
   li_rc = 1
 case "fourthchargedrate" 
   aa_value = of_GetFourthchargedrate()
   li_rc = 1
 case "spec1" 
   aa_value = of_GetSpec1()
   li_rc = 1
 case "spec2" 
   aa_value = of_GetSpec2()
   li_rc = 1
 case "spec3" 
   aa_value = of_GetSpec3()
   li_rc = 1
 case "spec4" 
   aa_value = of_GetSpec4()
   li_rc = 1
 case "spec5" 
   aa_value = of_GetSpec5()
   li_rc = 1
 case "user1" 
   aa_value = of_GetUser1()
   li_rc = 1
 case "user2" 
   aa_value = of_GetUser2()
   li_rc = 1
 case "notes" 
   aa_value = of_GetNotes()
   li_rc = 1
 // rdt 08/05/02
 case "freetimestart" 
   aa_value = of_GetFreeTimeStart()
   li_rc = 1
 case "freetimefriday" 
   aa_value = of_GetFreeTimeFriday()
   li_rc = 1
 case "freetimeholiday" 
   aa_value = of_GetFreeTimeHoliday()
   li_rc = 1
 case "freetimeweekend" 
   aa_value = of_GetFreeTimeWeekend()
   li_rc = 1
 case "perdiemholiday" 
   aa_value = of_GetPerdiemHoliday()
   li_rc = 1
 case "leasestatus" 
   aa_value = of_GetStatus()
   li_rc = 1
 case "lineprefix" 
   aa_value = of_GetPrefix()
   li_rc = 1
 case "equipmentlength" 
   aa_value = of_GetLength()
   li_rc = 1
 case "scac" 
   aa_value = of_Getscac()
   li_rc = 1
case "dayofinterchangecounts" 
   aa_value = of_GetDayofinterchangecounts( )
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Integer of_GetId ();//@(*)[74094561|584:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_SetId (Integer ai_id);//@(*)[74094561|584:id:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "id" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("id", ai_id) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetLine ();//@(*)[74455915|586:line:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("line")
//@(text)--

end function

public function Integer of_SetLine (String as_line);//@(*)[74455915|586:line:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "line" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("line", as_line) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetType ();//@(*)[74483972|587:type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("type")
//@(text)--

end function

public function Integer of_SetType (String as_type);//@(*)[74483972|587:type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("type", as_type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetFreetimeunits ();//@(*)[74637300|588:freetimeunits:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("freetimeunits")
//@(text)--

end function

public function Integer of_SetFreetimeunits (Integer ai_freetimeunits);//@(*)[74637300|588:freetimeunits:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "freetimeunits" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("freetimeunits", ai_freetimeunits) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetFreetimeperiod ();//@(*)[75689115|591:freetimeperiod:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("freetimeperiod")
//@(text)--

end function

public function integer of_setfreetimeperiod (integer ai_freetimeperiod);//@(*)[75689115|591:freetimeperiod:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "freetimeperiod" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


IF ai_freetimeperiod < 0 THEN
	li_rc = -1
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("freetimeperiod", ai_freetimeperiod) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetChargedperiods ();//@(*)[77109409|595:chargedperiods:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("chargedperiods")
//@(text)--

end function

public function integer of_setchargedperiods (integer ai_chargedperiods);//@(*)[77109409|595:chargedperiods:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "chargedperiods" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

int li_NullValue
dec ld_NullValue
setNull (li_NullValue )
setNull (ld_NullValue )


//Verify that the new value is in the acceptable range  (between 1 and 4), 
//and if so, perform dependent processing.

If ai_ChargedPeriods > 0 AND ai_ChargedPeriods < 5 THEN

	//Based on the new ChargedPeriods, clear any unused periods and set the Duration
	//for the last valid period to null, for "until return"

	IF ai_chargedperiods < 4 THEN
		of_SetFourthChargedUnits ( li_NullValue )
		of_SetFourthChargedPeriod (  li_NullValue ) 
		of_SetFourthChargedRate ( ld_NullValue )
		of_SetThirdChargedPeriod ( li_NullValue )  //Until Return
		li_rc = 2
	END IF 
	
	IF ai_chargedperiods < 3 THEN
		of_SetThirdChargedUnits ( li_NullValue )
		of_SetThirdChargedPeriod (  li_NullValue ) 
		of_SetThirdChargedRate ( ld_NullValue )
		of_SetSecondChargedPeriod ( li_NullValue )  //Until Return
		li_rc = 2
	END IF 
	
	IF ai_chargedperiods < 2 THEN
		of_SetSecondChargedUnits ( li_NullValue )
		of_SetSecondChargedPeriod (  li_NullValue ) 
		of_SetSecondChargedRate ( ld_NullValue )
		of_SetFirstChargedPeriod ( li_NullValue )  //Until Return
		li_rc = 2
	END IF 

ELSE
	//New value is not acceptable.  Reject it.
	li_rc = -1

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("chargedperiods", ai_chargedperiods) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetFirstchargedunits ();//@(*)[76070028|593:firstchargedunits:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("firstchargedunits")
//@(text)--

end function

public function Integer of_SetFirstchargedunits (Integer ai_firstchargedunits);//@(*)[76070028|593:firstchargedunits:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "firstchargedunits" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("firstchargedunits", ai_firstchargedunits) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetFirstchargedperiod ();//@(*)[76278015|594:firstchargedperiod:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("firstchargedperiod")
//@(text)--

end function

public function integer of_setfirstchargedperiod (integer ai_firstchargedperiod);//@(*)[76278015|594:firstchargedperiod:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "firstchargedperiod" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF ai_firstchargedperiod < 0 THEN
	li_rc = -1
END IF



//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("firstchargedperiod", ai_firstchargedperiod) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetFirstchargedrate ();//@(*)[77532727|596:firstchargedrate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("firstchargedrate")
//@(text)--

end function

public function integer of_setfirstchargedrate (decimal ad_firstchargedrate);//@(*)[77532727|596:firstchargedrate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "firstchargedrate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF ad_firstchargedrate < 0 THEN
	li_rc = -1
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("firstchargedrate", ad_firstchargedrate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetSecondchargedunits ();//@(*)[77595778|597:secondchargedunits:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("secondchargedunits")
//@(text)--

end function

public function Integer of_SetSecondchargedunits (Integer ai_secondchargedunits);//@(*)[77595778|597:secondchargedunits:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "secondchargedunits" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("secondchargedunits", ai_secondchargedunits) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetSecondchargedperiod ();//@(*)[77798918|598:secondchargedperiod:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("secondchargedperiod")
//@(text)--

end function

public function integer of_setsecondchargedperiod (integer ai_secondchargedperiod);//@(*)[77798918|598:secondchargedperiod:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "secondchargedperiod" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF ai_secondchargedperiod < 0 THEN
	li_rc = -1
END IF



//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("secondchargedperiod", ai_secondchargedperiod) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetSecondchargedrate ();//@(*)[77828020|599:secondchargedrate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("secondchargedrate")
//@(text)--

end function

public function integer of_setsecondchargedrate (decimal ad_secondchargedrate);//@(*)[77828020|599:secondchargedrate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "secondchargedrate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF ad_secondchargedrate < 0 THEN
	li_rc = -1
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("secondchargedrate", ad_secondchargedrate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetThirdchargedunits ();//@(*)[77842568|600:thirdchargedunits:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("thirdchargedunits")
//@(text)--

end function

public function Integer of_SetThirdchargedunits (Integer ai_thirdchargedunits);//@(*)[77842568|600:thirdchargedunits:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "thirdchargedunits" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("thirdchargedunits", ai_thirdchargedunits) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetThirdchargedperiod ();//@(*)[77852068|601:thirdchargedperiod:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("thirdchargedperiod")
//@(text)--

end function

public function integer of_setthirdchargedperiod (integer ai_thirdchargedperiod);//@(*)[77852068|601:thirdchargedperiod:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "thirdchargedperiod" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF ai_thirdchargedperiod < 0 THEN
	li_rc = -1
END IF



//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("thirdchargedperiod", ai_thirdchargedperiod) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetThirdchargedrate ();//@(*)[77866563|602:thirdchargedrate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("thirdchargedrate")
//@(text)--

end function

public function integer of_setthirdchargedrate (decimal ad_thirdchargedrate);//@(*)[77866563|602:thirdchargedrate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "thirdchargedrate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


IF ad_thirdchargedrate < 0 THEN
	li_rc = -1
END IF

//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("thirdchargedrate", ad_thirdchargedrate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetFourthchargedunits ();//@(*)[77879167|603:fourthchargedunits:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fourthchargedunits")
//@(text)--

end function

public function Integer of_SetFourthchargedunits (Integer ai_fourthchargedunits);//@(*)[77879167|603:fourthchargedunits:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fourthchargedunits" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fourthchargedunits", ai_fourthchargedunits) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetFourthchargedperiod ();//@(*)[77909371|604:fourthchargedperiod:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fourthchargedperiod")
//@(text)--

end function

public function integer of_setfourthchargedperiod (integer ai_fourthchargedperiod);//@(*)[77909371|604:fourthchargedperiod:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fourthchargedperiod" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF ai_fourthchargedperiod < 0 THEN
	li_rc = -1
END IF



//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fourthchargedperiod", ai_fourthchargedperiod) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetFourthchargedrate ();//@(*)[77987647|606:fourthchargedrate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fourthchargedrate")
//@(text)--

end function

public function integer of_setfourthchargedrate (decimal ad_fourthchargedrate);//@(*)[77987647|606:fourthchargedrate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fourthchargedrate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF ad_fourthchargedrate < 0 THEN
	li_rc = -1
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fourthchargedrate", ad_fourthchargedrate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function integer of_getfreetimeexpiration (date ad_outdate, time at_outtime, ref date ad_expirationdate, ref time at_expirationtime);//@(*)[56647772|616]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

/*Arguments: 
//    date:ad_outdate, time:at_outtime, date:ad_expirationdate, time:at_expirationtime
//returns: 
//		integer
//Description:
//		Calculates the free time expiration date.
//Revision History
//rdt 08-05-02 added code for new fields.
//RDT 5-08-03 added check for is Holiday Extra Free Day.
//RPZ 6/5/03 added use of shared variable
//RPZ 9/13/05 Added check for counting day of interchange
*/

LONG		ll_Offset
LONG  	ll_FreePeriod
INT 		li_ReturnValue
INT 		li_NumHours
DATETIME ldtm_Start, &
			ldtm_End

BOOLEAN 	lb_AddHoliday, &
			lb_DateChanged = TRUE 
			
Boolean	lb_InterchangeCounts

n_cst_DateTime	lnv_DateTime
li_ReturnValue = -1

// get freetime
ll_FreePeriod = of_GetFreeTimePeriod() 
// changes to use share to increase performance <<*>> 6/5/03
lb_AddHoliday = sb_HolidayExtraFreeDay


// I need to check this here b.c. some of the processing changes the date out and
// I need to know when it really went out.
IF ll_FreePeriod > 0 THEN
	lb_InterchangeCounts = (THIS.of_GetDayOfinterchangeCounts ( ) = THIS.ci_yes ) AND ( lnv_DateTime.of_IsWeekend(ad_outdate) )
END IF

IF (NOT isNull (ad_outdate) AND NOT isNull (at_outtime)) THEN
	
	If ad_outDate > ad_expirationdate  OR IsNull ( ad_expirationdate ) Then  // added the is null check to fix issue PT4PT-1699
		ad_expirationdate = ad_outDate
	End If
	lnv_DateTime.of_SetHolidays( ad_outdate, ad_expirationdate )
	

	// @@@@@@@@@@@@@@@@@ CHECKS FOR FIRST DATE @@@@@@@@@@@@@@@@@ 
	
	//RDT 5-08-03 check and add holidays as free days
	If lb_AddHoliday AND THIS.of_GetDayOfinterchangeCounts ( ) = THIS.ci_no Then // <<*>> Added the interchange check
		if lnv_datetime.of_isHoliday( ad_outdate ) Then 
			ad_outDate = lnv_DateTime.of_RelativeDate( ad_outDate , 1, FALSE) 
		end if
	End If
	//RDT 5-08-03 
	
	// rdt 08-05-02 check for Friday Freetime and move the outdate if true.
	If Not IsNull(of_GetFreeTimeFriday()) Then 
		if lnv_DateTime.of_dayofweek (ad_outdate)= 6 Then
			ad_outdate = of_CalcFreeFriday(ad_outdate, at_outtime, ad_outdate)	

			//RDT 5-08-03 check and add holiday as free day
			If lb_AddHoliday Then 
				if lnv_datetime.of_isHoliday( ad_outdate ) Then 
					ad_outDate = lnv_DateTime.of_RelativeDate( ad_outDate , 1, FALSE) 
				end if
			End If
			//RDT 5-08-03 

		end if
	End If
	// rdt 08-05-02 check for Holiday Freetime and move out date if true. 
	If Not IsNull(of_GetFreeTimeHoliday()) then
			ad_outdate = of_CalcFreeHoliday(ad_outdate, at_outtime, ad_outdate)					
			//RDT 5-08-03 check and add holiday as free day
			If lb_AddHoliday Then 
				if lnv_datetime.of_isHoliday( ad_outdate ) Then 
					ad_outDate = lnv_DateTime.of_RelativeDate( ad_outDate , 1, FALSE) 
				end if
			End If
			//RDT 5-08-03 
	End If

	// @@@@@@@@@@@@@@@@@ CHECKS FOR DATE RANGE @@@@@@@@@@@@@@@@@ 
	// calculate start of freetime period
	// determines when free time expires if units are in calendar days (The First day counts against any free days)

	
	IF of_getFreeTimeUnits() = ci_CalendarDays THEN  
		IF ll_FreePeriod - 1 < 0 THEN
			ad_expirationdate = lnv_DateTime.of_RelativeDate(ad_outdate, 0  , FALSE, FALSE /*dont add holidays if units are calandar*/)
		ELSE
			ad_expirationdate = lnv_DateTime.of_RelativeDate(ad_outdate, ll_FreePeriod - 1  , FALSE, FALSE /*dont add holidays if units are calandar*/ )
		END IF
		IF ll_FreePeriod > 0 THEN
			at_expirationtime = 23:59:59
		ELSE
			at_expirationtime = at_outtime
		END IF

	
		// rdt 08-05-02 check for first weekend free. (Weekend = Friday, Saturday, & Sunday)
		If of_GetFreeTimeWeekend() = 1 and ll_FreePeriod > 0 AND &   
			(lnv_DateTime.of_IsWeekend(ad_expirationdate) or lnv_DateTime.of_DayOfWeek(ad_expirationdate) = 6)  then
			ad_expirationdate = of_CalcFreeWeekend(ad_expirationdate)

			//RDT 5-08-03 check for holiday on the new expire date and add as a free day
			// RPZ commented this out bc holidays don't matter when evaluating calendar days
//			If lb_AddHoliday Then 
//				if lnv_datetime.of_isHoliday( ad_expirationdate  ) Then 
//					ad_expirationDate = lnv_DateTime.of_RelativeDate( ad_expirationdate , 1, FALSE) 
//				end if
//			End If
			//RDT 5-08-03 

		End if
		li_ReturnValue = 1
	
	// determines when free time expires if units are in Working days (The First day counts against any free days)
	ElseIF of_GetFreeTimeUnits() = ci_WorkingDays THEN
		IF ll_FreePeriod > 0 THEN
			at_expirationtime = 23:59:59
		ELSE
			at_expirationtime = at_outtime
		END IF
		If ll_FreePeriod > 0 Then 
			
			////// <<*>> Added 9/13/05			
			IF lb_InterchangeCounts THEN
				// burn a day off free time
				ll_FreePeriod -- 							
			ELSE		
			////// <<*>> End 9/13/05 change
		
			IF NOT( lnv_DateTime.of_IsWeekend(ad_outdate) ) THEN
				ll_FreePeriod -- 	
			END IF
		END IF
		
		ad_expirationdate = lnv_DateTime.of_RelativeDate(ad_outdate, ll_FreePeriod , TRUE, lb_AddHoliday)
			
			
			
		Else 
			ad_expirationdate = ad_outdate
		End If
		
		
//		//RDT 5-08-03 check for holidays in range and add as free days
//		If lb_AddHoliday Then 
//				ad_expirationdate = lnv_DateTime.of_RelativeDate( ad_expirationdate, lnv_datetime.of_GetHolidayCount ( ad_outdate, ad_expirationdate, FALSE ) , FALSE) 
//		End If
		//RDT 5-08-03 

		// rdt 08-05-02 check for first weekend free. (Weekend = Friday, Saturday, & Sunday)
		If of_GetFreeTimeWeekend() = 1 and & 
			(lnv_DateTime.of_IsWeekend(ad_expirationdate) or & 
			lnv_DateTime.of_DayOfWeek(ad_expirationdate) = 6)  then
				ad_expirationdate = of_CalcFreeWeekend(ad_expirationdate)
				//RDT 5-08-03 check for a holiday on new expire date and add as a free day
				If lb_AddHoliday Then 
					if lnv_datetime.of_isHoliday( ad_expirationdate  ) Then 
						ad_expirationDate = lnv_DateTime.of_RelativeDate( ad_expirationdate , 1, FALSE) 
					end if
				End If
				//RDT 5-08-03 

		end if		
		li_ReturnValue = 1
		
	// determines when free time expires if units are in Hours
	ElseIf of_GetFreeTimeUnits() = ci_Hours THEN
	// NOTE: 3600 = number of seconds in 1 Hour
		ldtm_Start = DATETIME(ad_outdate,at_outtime)
		ll_Offset = of_GetFreeTimePeriod() * 3600
		ldtm_End = lnv_DateTime.of_RelativeDateTime(ldtm_Start,ll_Offset)
		ad_expirationdate = DATE(ldtm_End)
		at_expirationtime = TIME(ldtm_End)
		// rdt 08-05-02 check for first weekend free. (Weekend = Friday, Saturday, & Sunday)
		If of_GetFreeTimeWeekend() = 1 and & 
		(lnv_DateTime.of_IsWeekend(ad_expirationdate) or lnv_DateTime.of_DayOfWeek(ad_expirationdate) = 6)  then
			ad_expirationdate = of_CalcFreeWeekend(ad_expirationdate)

			//RDT 5-08-03 check for a holiday on new expire date and add as a free day
			If lb_AddHoliday Then 
					if lnv_datetime.of_isHoliday( ad_expirationdate ) Then 
						ad_expirationDate = lnv_DateTime.of_RelativeDate( ad_expirationdate , 1, FALSE) 
					end if
			End If
			//RDT 5-08-03 
		end if
		li_ReturnValue = 1
	End IF

ELSE 
	setNull ( ad_expirationdate )
	setNull ( at_expirationtime )
	li_ReturnValue = 0
END IF

Return li_ReturnValue
end function

public function integer of_getcharges (date ad_outdate, time at_outtime, ref decimal ad_charges);//@(*)[57412717|621]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Date	ld_ReturnDate
Time	lt_ReturnTime 

lt_ReturnTime = Now()
ld_ReturnDate = Today()	

of_GetCharges(ad_outDate,at_OutTime,ld_ReturnDate,lt_ReturnTime,ad_charges)

Return 1
end function

public function integer of_getcharges (date ad_outdate, time at_outtime, date ad_returndate, time at_returntime, ref decimal ad_charges);//@(*)[65422814|638]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


Int	li_Return = -1
Int	li_ChgRtn
n_cst_LeaseCharges	lnv_Charges

li_ChgRtn = THIS.of_GetCharges ( ad_outdate, at_outtime, ad_returndate, at_returntime, lnv_Charges )

IF li_ChgRtn = 0 THEN
	SetNull ( ad_charges )
	li_Return = 0
ELSEIF li_ChgRtn = 1 THEN
	IF isValid ( lnv_Charges ) THEN
		ad_charges = lnv_Charges.of_GetTotalCharges ( ) 
		li_Return = 1
	END IF
END IF

DESTROY ( lnv_Charges )

RETURN li_Return
















//BOOLEAN 	lb_STATUS 		//Exclude weekends or not
//Date		ld_EndDate
//DATE 		ld_Start
//Date		ld_TempDate
//DATETIME ldtm_in, ldtm_out,ldtm_EndDateTime,ldtm_Start
//TIME		lt_TimeStart = 23:59:59
//Time		lt_TempTime
//Time		lt_StartTime
//INT 		li_UNITS
//INT		li_NumHours
//INT 		li_ReturnValue = -1 
//INT 		li_Period
//INT 		i
//INT		li_ChargedPeriods
//INT		li_number_holidays = 0
//// rdt 08-26-02 changed rate to a decimal
////LONG		ll_RATE
//Dec		lc_Charges
//Decimal  ld_rate
//LONG  	ll_Charges
//LONG  	ll_offset
//LONG 		ll_NumSeconds
//n_cst_leaseCharges	lnv_LeaseCharges
//lnv_LeaseCharges = CREATE n_cst_LeaseCharges
//
//ad_charges = 0
//ll_charges = 0
//n_cst_DateTime lnv_DateTime
//
//ld_Start = ad_OutDate
////rdt 08-05-02 ldtm_start = DATETIME(ad_outdate,at_outtime)
//IF Not IsNull ( ad_outdate )  THEN
//	
//	If Isnull ( ad_ReturnDate ) THEN
//		ld_TempDate = today()
//		ad_returndate = today()
//	ELSE
//		ld_TempDate = ad_returndate
//	END IF
//
//	If isNull ( at_ReturnTime ) THEN
//		lt_TempTime = now()
//		at_returntime = now()
//	ELSE 
//		lt_TempTime = at_returntime
//	END IF
//
//	// create holidays in date range
//	lnv_DateTime.of_SetHolidays(ad_outdate,ad_returndate)
//
//	// rdt 08-05-02  call of_getfreetimeexpiration and use the expire date as the new start date and start time
//	this.of_getfreetimeexpiration (ad_OutDate, at_outtime, ld_Start, lt_StartTime  )
//	ldtm_start = DATETIME(ld_Start,lt_StartTime)
//	// rdt end
//	
//	ldtm_IN  = DATETIME(ld_TempDate , lt_TempTime)
//
//	If ldtm_IN  > ldtm_start Then 					// RDT 101502 Bug fix 
//
//		li_ChargedPeriods = of_GetChargedPeriods()
//	   // rdt 08-05-02 replaced line below. Freetime is accounted for already
//	   //	FOR i = 0 TO li_ChargedPeriods
//		FOR i = 1 TO li_ChargedPeriods
//			CHOOSE CASE i
//				CASE 0
//					messagebox("ERROR","Case 0 should not happend")
//					li_Units = of_GetFreeTimeunits()
//					li_Period = of_GetFreeTimeperiod() 
//					IF NOT li_Units = ci_Hours THEN
//							// <<*>> calc fix
//							// I commented the line of code below
//						li_period --		//because 1st day counts as freeday		
//					End IF
//					ld_Rate = 0
//				CASE 1
//					li_Units = of_GetFirstChargedunits()
//					li_Period = of_GetFirstChargedPeriod()
//					ld_rate = of_GetFirstChargedRate()
//				CASE 2 
//					li_Units = of_GetSecondChargedunits()
//					li_Period = of_GetSecondChargedPeriod()
//					ld_rate = of_GetSecondChargedRate()
//				CASE 3
//					li_Units = of_GetThirdChargedunits()
//					li_Period = of_GetThirdChargedPeriod()
//					ld_rate = of_GetThirdChargedRate()
//				CASE 4
//					li_Units = of_GetFourthChargedunits()
//					li_Period = of_GetFourthChargedPeriod()
//					ld_rate = of_GetFourthChargedRate()
//			END CHOOSE
//			// 
//			IF li_Units = ci_WorkingDays THEN
//				lb_Status = TRUE
//			ELSE
//				lb_Status = FALSE	
//			END IF
//	
//			// If the li_period = null (UNTIL RTN), ld_enddate is not calculated it is set to return date.
//			If IsNull(li_Period) Then 
//					ld_EndDate = ad_ReturnDate 
//			Else
//				IF li_Units = ci_WorkingDays THEN
//					ld_EndDate = lnv_DateTime.of_relativeDate(ld_Start, li_Period, lb_Status)
//				ELSEIF li_Units = ci_CalendarDays THEN
//					ld_EndDate = lnv_DateTime.of_relativeDate(ld_Start, li_Period, lb_Status)
//				ELSEIF li_Units = ci_Hours THEN
//					ll_OffSet = li_Period  * 3600
//					ldtm_EndDateTime = lnv_DateTime.of_RelativeDateTime(ldtm_Start,ll_OffSet)
//					ld_EndDate = Date(ldtm_EndDateTime)
//					lt_TempTime = time(ldtm_EndDateTime)
//				END IF
//			End IF
//	
//			// rdt 08-05-02 moved line below up into if statement
//			//	ld_EndDate = lnv_DateTime.of_relativeDate(ld_Start, li_Period ,lb_Status)
//	
//			IF li_Units = ci_Hours  THEN			
//					// rdt 08-05-02 check for holidays and shift dates
//					If of_GetPerdiemHoliday() = 0 Then
//						// rdt 08-05-02 get holiday count for date range and add a day to the end date for each holiday 
//						//always include weekends if using hours.
//						li_number_holidays = lnv_DateTime.of_getholidaycount (ld_Start, ld_EndDate, FALSE)
//						// increase end date by number of holidays 
//						ld_EndDate = lnv_DateTime.of_relativeDate(ld_EndDate, li_number_holidays , FALSE)
//					End If		
//					// rdt end
//					IF ldtm_IN <= ldtm_EndDateTime OR ISNull(li_period)THEN
//						ll_NumSeconds = lnv_DateTime.of_SecondsAfter(ldtm_Start,ldtm_IN)
//					ELSE 
//						ll_NumSeconds = lnv_DateTime.of_SecondsAfter(ldtm_Start,ldtm_EndDateTime)
//					END IF
//					// NOTE: 3600 number of seconds in a hour
//					li_NumHours = ll_NumSeconds / 3600  
//					
//					IF Mod ( ll_NumSeconds , 3600 ) >= 60 THEN 											
//						li_NumHours ++     // one min. over and you're charged!
//					END IF
//					IF li_NumHours >= 0 THEN
//						
//						
//						
//						lc_Charges = ld_rate * li_NumHours 
//						lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
//						
//					//	ad_Charges += ld_rate * li_NumHours 
//						
//						
//						
//					END IF
//					// rdt 08-05-02 subtract charge amount for number of holidays
//					If li_number_holidays > 0 Then 
//						
//						
//						lc_Charges = ld_rate * li_NumHours 
//						lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
//						
//						//ad_charges = ad_charges - (li_Number_Holidays * 24 * ld_rate)
//						
//						
//						
//					End if 
//									
//					ldtm_Start = ldtm_EndDateTime
//					ld_Start = Date(ldtm_Start)
//	
//					IF ldtm_EndDateTime < ldtm_IN THEN  // missed fte (units = hours) need to ad. charges
//						ld_Start = relativeDate(ld_Start , -1)	
//					END IF	
//			ELSE
//					// rdt 08-05-02 check for holidays and shift dates
//					If of_GetPerdiemHoliday() = 0 Then
//						// rdt 08-05-02 get holiday count for date range and add a day to the end date for each holiday
//						If li_Units = ci_WorkingDays then 
//							li_number_holidays = lnv_DateTime.of_getholidaycount (ld_Start, ld_EndDate, FALSE)
//							// number of holidays to End Date 
//							if li_number_holidays > 0 Then 
//								ld_EndDate = lnv_DateTime.of_relativeDate(ld_EndDate, li_number_holidays , FALSE)
//							end if
//						Else
//							li_number_holidays = lnv_DateTime.of_getholidaycount (ld_Start, ld_EndDate, TRUE)
//							// number of holidays to End Date 
//							if li_number_holidays > 0 Then 
//								ld_EndDate = lnv_DateTime.of_relativeDate(ld_EndDate, li_number_holidays , TRUE)
//							end if
//						End IF
//					End If		
//					// subtract charge amount for number of holidays
//					lc_Charges = lnv_LeaseCharges.of_GetCharges ( i )
//					lc_Charges -= (li_number_holidays * ld_rate)					
//					lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
//					//ad_charges = ad_charges - (li_number_holidays * ld_rate)
//					
//					// rdt end
//	
//				// rdt check for a switch from hours to days
//				If Left(String(lt_StartTime),8) <> "23:59:59" then 
//					//add a days charges to the amount and set the time.
//					
//					lc_Charges  += 1 * ld_Rate
//					lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
//					//ad_Charges += 1 * ld_Rate
//									
//				End If
//	
//				IF ad_returnDate <= ld_EndDate OR isNull(li_period) THEN
//					
//					lc_Charges += (lnv_DateTime.of_DaysAfter(ld_Start,ad_returnDate,lb_Status )* ld_rate)
//					lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
//					
//				//	ad_charges += (lnv_DateTime.of_DaysAfter(ld_Start,ad_returnDate,lb_Status )* ld_rate)
//					
//					
//					
//					EXIT
//				ELSE
//					
//					lc_Charges += (lnv_DateTime.of_DaysAfter(ld_Start,ld_EndDate,lb_Status )*ld_rate)
//					lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
////					ad_charges += (lnv_DateTime.of_DaysAfter(ld_Start,ld_EndDate,lb_Status )*ld_rate)
//					
//					
//					
//				END IF
//												
//				ld_start = ld_EndDate
//				ldtm_Start = DateTime(ld_Start,lt_StartTime)
//	
//			END IF
//	
//		NEXT
//		li_ReturnValue = 1	
//
//	Else														// RDT 101502 Bug fix 
//
//		
//		ad_charges = 0										// RDT 101502 Bug fix 
//		li_ReturnValue	= 1								// RDT 101502 Bug fix 
//	End If													// RDT 101502 Bug fix 
//
//ELSE
//	
//	
//	
//	setNull(ad_Charges)
//	li_ReturnValue = 0
//END IF
//
//return li_ReturnValue
//
end function

public function String of_GetSpec1 ();//@(*)[65160321|933:spec1:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec1")
//@(text)--

end function

public function Integer of_SetSpec1 (String as_spec1);//@(*)[65160321|933:spec1:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "spec1" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("spec1", as_spec1) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSpec2 ();//@(*)[65171518|934:spec2:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec2")
//@(text)--

end function

public function Integer of_SetSpec2 (String as_spec2);//@(*)[65171518|934:spec2:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "spec2" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("spec2", as_spec2) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSpec3 ();//@(*)[65178537|935:spec3:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec3")
//@(text)--

end function

public function Integer of_SetSpec3 (String as_spec3);//@(*)[65178537|935:spec3:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "spec3" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("spec3", as_spec3) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSpec4 ();//@(*)[65193775|936:spec4:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec4")
//@(text)--

end function

public function Integer of_SetSpec4 (String as_spec4);//@(*)[65193775|936:spec4:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "spec4" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("spec4", as_spec4) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSpec5 ();//@(*)[65202775|937:spec5:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec5")
//@(text)--

end function

public function Integer of_SetSpec5 (String as_spec5);//@(*)[65202775|937:spec5:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "spec5" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("spec5", as_spec5) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetUser1 ();//@(*)[64145138|930:user1:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user1")
//@(text)--

end function

public function Integer of_SetUser1 (String as_user1);//@(*)[64145138|930:user1:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "user1" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("user1", as_user1) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetUser2 ();//@(*)[64189453|931:user2:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user2")
//@(text)--

end function

public function Integer of_SetUser2 (String as_user2);//@(*)[64189453|931:user2:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "user2" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("user2", as_user2) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetNotes ();//@(*)[64200732|932:notes:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("notes")
//@(text)--

end function

public function Integer of_SetNotes (String as_notes);//@(*)[64200732|932:notes:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "notes" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("notes", as_notes) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_bcm of_GetEquipmentlease (String as_query);//@(*)[63106059|918]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_equipmentlease = GetRelationship( inv_equipmentlease, "n_cst_dlkc_equipmentlease", "equipmentlease", "equipmentleasetype", as_query )
inv_equipmentlease.AddClass("n_cst_beo_equipmentlease")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_equipmentlease
//@(text)--

end function

public function n_cst_bcm of_GetEquipmentlease ();//@(*)[63106059|918:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetEquipmentlease(ls_dlkname)
//@(text)--

end function

public function integer of_getfreetimestart ();//rdt 08/05/02
return GetValue("freetimestart")

end function

public function time of_getfreetimefriday ();//rdt 08/05/02
return GetValue("freetimefriday")
end function

public function integer of_getfreetimeweekend ();//rdt 08/05/02
return GetValue("freetimeweekend")
end function

public function integer of_getperdiemholiday ();//rdt 08/05/02
return GetValue("perdiemholiday")
end function

public function string of_getprefix ();// rdt 08/05/02
return GetValue("lineprefix")
end function

public function string of_getlength ();// rdt 08/05/02
return GetValue("equipmentlength")
end function

public function integer of_setfreetimestart (integer ai_freetimestart);// rdt 08/05/02
integer li_ReturnCode = 1

// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.
//@(text)--


//@(text)(recreate=yes)<Set Value>
if li_ReturnCode > 0 then
   if SetValue("freetimestart", ai_freetimestart) < 1 then
      li_ReturnCode = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_ReturnCode
//@(text)--

end function

public function integer of_setfreetimeholiday (time at_holiday);// rdt 08/05/02
integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("freetimeholiday", at_holiday) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode

end function

public function integer of_setfreetimeweekend (integer ai_freetimeweekend);// rdt 08/05/02
integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("freetimeweekend", ai_freetimeweekend) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode

end function

public function integer of_setperdiemholiday (integer ai_perdiemholiday);// rdt 08/05/02
integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("perdiemholiday", ai_perdiemholiday) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode

end function

public function integer of_setprefix (string as_prefix);// rdt 08/05/02
integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("lineprefix", as_prefix) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode

end function

public function integer of_setlength (string as_length);// rdt 08/05/02
integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("equipmentlength", as_length) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode


end function

public function integer of_getstatus ();// rdt 08/05/02
return GetValue("leasestatus")
end function

public function integer of_setstatus (integer ai_status);// rdt 08/05/02
integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("leasestatus", ai_status) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode

end function

public function time of_getfreetimeholiday ();//rdt 08/05/02
return GetValue("freetimeholiday")
end function

private function date of_calcfreefriday (date adt_dateout, time at_timeout, date adt_expiredate);//
/*Arguments: Date of outgate, time of outgate, expire date
//returns: new expire date
//Description: Calculates the next free expire date based on friday cut off time
//
//Revision History
// rdt 08-05-02 initial version
*/
Date ld_ReturnDate

ld_returnDate = adt_expiredate

If at_timeout > of_GetFreeTimeFriday()  Then
	n_cst_datetime lnv_datetime
	// add 2 to expire date. include weekends so clock starts on Sunday night
	ld_ReturnDate = lnv_DateTime.of_RelativeDate(adt_expiredate, 1, false)
End If

return ld_ReturnDate


end function

private function date of_calcfreeholiday (date adt_dateout, time at_timeout, date adt_expiredate);//
/*Arguments: Date of outgate, time of outgate
//returns: new date
//Description: Calculates the next free expire date based on Holiday cut off time
// If the holiday is free then add a day.
//
//Revision History
// rdt 08-05-02 initial version
*/
date    ldt_ReturnDate,&
		  ldt_NextDay
time	  lt_FreeTime
string  ls_HolidayList

ldt_ReturnDate = adt_expiredate

n_cst_datetime lnv_DateTime

// Tell nvo to load the holiday dates
lnv_DateTime.of_SetHolidays( )

//// get Holiday dates from nvo
//ls_HolidayList = lnv_DateTime.of_GetAllHolidays( )

// add one day to date passed in to check if next day is a holiday.
ldt_NextDay = lnv_DateTime.of_RelativeDate(adt_expiredate, 1, true )

// if it's a holiday add a day to it.
If lnv_DateTime.of_IsHoliday(ldt_Nextday) Then 
	lt_FreeTime = of_GetFreeTimeHoliday( )
	If at_timeout > lt_FreeTime Then
		//	Working days, Calendar days, and Hours are treated the same. 
		ldt_ReturnDate = lnv_DateTime.of_RelativeDate ( adt_expiredate, 1, False )
	End If
End If

return ldt_ReturnDate

end function

private function date of_calcperdiemholiday (date adt_dateout, date adt_expiredate);//
/*Arguments: Date of outgate, time of outgate, expire date
//returns: new expire date
//Description: Looks for holidays and calculates new expire date 
//
//Revision History
// rdt 08-05-02 initial version
*/

Date 	  ldt_ReturnDate
Integer li_HolidayCount

n_cst_datetime lnv_DateTime
lnv_DateTime.of_SetHolidays(adt_dateout,adt_expiredate)

If of_GetFreeTimeUnits ( ) = ci_workingdays Then
	li_HolidayCount = lnv_DateTime.of_GetHolidayCount ( adt_dateout, adt_expiredate, True )
End If

If of_GetFreeTimeUnits ( ) = ci_calendardays Then 
	li_HolidayCount = lnv_DateTime.of_GetHolidayCount ( adt_dateout, adt_expiredate, False)
End IF

ldt_ReturnDate = lnv_DateTime.of_RelativeDate(adt_expiredate, li_HolidayCount, True)		


return ldt_ReturnDate

end function

private function date of_calcfreeweekend (date adt_date);//
/*Arguments: Date of outgate, time of outgate
//returns: new date
//Description: Calculates the next free expire date based on friday cut off time
// Per Specs.: If the time expires on Friday or Saturday the weekend is free.
// (A sandwich was almost bet on this one.)
//Revision History
// rdt 08-05-02 initial version

*/
date ld_Date 

ld_Date = adt_date

n_cst_datetime lnv_DateTime

// check for Friday
If lnv_DateTime.of_DayOfWeek(adt_Date)=6 then
	ld_Date = lnv_DateTime.of_RelativeDate(adt_Date, 2, FALSE)
End if
// check for Saturday
If lnv_DateTime.of_DayOfWeek(adt_Date)=7 then
	ld_Date = lnv_DateTime.of_RelativeDate(adt_Date, 1, FALSE)
End if

Return ld_Date
end function

public function integer of_setfreetimefriday (time at_FreeTimeFriday);// rdt 08/05/02
integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("freetimefriday", at_FreeTimeFriday) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode

end function

public function integer of_getcharges (date ad_outdate, time at_outtime, date ad_returndate, time at_returntime, ref n_cst_leasecharges anv_leasecharges);// RDT 101502 Bug fix - calculating negative charges if the return date was less than the start date.
// RDT 5-30-03 Bug Fix - Calculating holidays was using end of period date not return date
// MFS 2/13/06Fix - Calculating zero free days for calendar days was charging an extra day
BOOLEAN 	lb_STATUS 		//Exclude weekends or not
Date		ld_EndDate
DATE 		ld_Start
Date		ld_TempDate
Date		ld_HolidayStart // 2/13/06Fix 
DATETIME ldtm_in, ldtm_out,ldtm_EndDateTime,ldtm_Start
TIME		lt_TimeStart = 23:59:59
Time		lt_TempTime
Time		lt_StartTime
INT 		li_UNITS
INT		li_NumHours
INT 		li_ReturnValue = -1 
INT 		li_Period
INT 		i
INT		li_ChargedPeriods
INT		li_number_holidays = 0
// rdt 08-26-02 changed rate to a decimal
//LONG		ll_RATE
Dec		lc_Charges
Decimal  ld_rate
LONG  	ll_Charges
LONG  	ll_offset
LONG 		ll_NumSeconds
String	ls_RangeText
Int		li_NumDays
int		li_Range

int		li_FreeTime

n_cst_leaseCharges	lnv_LeaseCharges
lnv_LeaseCharges = CREATE n_cst_LeaseCharges

//ad_charges = 0
ll_charges = 0
n_cst_DateTime lnv_DateTime

ld_Start = ad_OutDate
//rdt 08-05-02 ldtm_start = DATETIME(ad_outdate,at_outtime)
IF Not IsNull ( ad_outdate )  THEN
	
	If Isnull ( ad_ReturnDate ) THEN
		ld_TempDate = today()
		ad_returndate = today()
	ELSE
		ld_TempDate = ad_returndate
	END IF

	If isNull ( at_ReturnTime ) THEN
		lt_TempTime = now()
		at_returntime = now()
	ELSE 
		lt_TempTime = at_returntime
	END IF

	// create holidays in date range
	lnv_DateTime.of_SetHolidays(ad_outdate,ad_returndate)

	// rdt 08-05-02  call of_getfreetimeexpiration and use the expire date as the new start date and start time
	this.of_getfreetimeexpiration (ad_OutDate, at_outtime, ld_Start, lt_StartTime  )
	ldtm_start = DATETIME(ld_Start,lt_StartTime)
	// rdt end
	
	ldtm_IN  = DATETIME(ld_TempDate , lt_TempTime)

	If ldtm_IN  > ldtm_start Then 					// RDT 101502 Bug fix 
		li_FreeTime = THIS.of_GetFreeTimeperiod( )
		li_ChargedPeriods = of_GetChargedPeriods()
		// 2/13/06Fix -- Calcutlate holidays with ld_Start
		//				  -- Push ld_Start back a day
		ld_HolidayStart = ld_start
		if li_FreeTime = 0 then
			ld_start = relativedate(ld_start, -1)
		end if
	   // rdt 08-05-02 replaced line below. Freetime is accounted for already
	   //	FOR i = 0 TO li_ChargedPeriods
		FOR i = 1 TO li_ChargedPeriods
			li_Range = 0
			lc_Charges = 0
			
			
			CHOOSE CASE i
				CASE 0
					messagebox("ERROR","Case 0 should not happend")
					li_Units = of_GetFreeTimeunits()
					li_Period = of_GetFreeTimeperiod() 
					IF NOT li_Units = ci_Hours THEN
							// <<*>> calc fix
							// I commented the line of code below
						li_period --		//because 1st day counts as freeday		
					End IF
					ld_Rate = 0
				CASE 1
					li_Units = of_GetFirstChargedunits()
					li_Period = of_GetFirstChargedPeriod()
					ld_rate = of_GetFirstChargedRate()
				CASE 2 
					li_Units = of_GetSecondChargedunits()
					li_Period = of_GetSecondChargedPeriod()
					ld_rate = of_GetSecondChargedRate()
				CASE 3
					li_Units = of_GetThirdChargedunits()
					li_Period = of_GetThirdChargedPeriod()
					ld_rate = of_GetThirdChargedRate()
				CASE 4
					li_Units = of_GetFourthChargedunits()
					li_Period = of_GetFourthChargedPeriod()
					ld_rate = of_GetFourthChargedRate()
			END CHOOSE
			// 
			IF li_Units = ci_WorkingDays THEN
				lb_Status = TRUE
			ELSE
				lb_Status = FALSE	
			END IF
	
			// If the li_period = null (UNTIL RTN), ld_enddate is not calculated it is set to return date.
			If IsNull(li_Period) Then 
				ld_EndDate = ad_ReturnDate 
			Else
				IF li_Units = ci_WorkingDays THEN
					ld_EndDate = lnv_DateTime.of_relativeDate(ld_Start, li_Period, lb_Status)
				ELSEIF li_Units = ci_CalendarDays THEN
					ld_EndDate = lnv_DateTime.of_relativeDate(ld_Start, li_Period, lb_Status)
				ELSEIF li_Units = ci_Hours THEN
					ll_OffSet = li_Period  * 3600
					ldtm_EndDateTime = lnv_DateTime.of_RelativeDateTime(ldtm_Start,ll_OffSet)
					ld_EndDate = Date(ldtm_EndDateTime)
					lt_TempTime = time(ldtm_EndDateTime)
				END IF
			End IF
			
			// rdt 08-05-02 moved line below up into if statement
			//	ld_EndDate = lnv_DateTime.of_relativeDate(ld_Start, li_Period ,lb_Status)
	
			IF li_Units = ci_Hours  THEN	
				// rdt 08-05-02 check for holidays and shift dates
				If of_GetPerdiemHoliday() = 0 Then

					// RDT 5-30-03 added following if statement
					if ad_ReturnDate < ld_EndDate then
						ld_EndDate = ad_ReturnDate
					end if
					
					// rdt 08-05-02 get holiday count for date range and add a day to the end date for each holiday 
					//always include weekends if using hours.
					li_number_holidays = lnv_DateTime.of_getholidaycount (ld_HolidayStart, ld_EndDate, FALSE)
					// increase end date by number of holidays 
					ld_EndDate = lnv_DateTime.of_relativeDate(ld_EndDate, li_number_holidays , FALSE)
				End If		
				// rdt end
				
				IF ldtm_IN <= ldtm_EndDateTime OR ISNull(li_period)THEN
					ll_NumSeconds = lnv_DateTime.of_SecondsAfter(ldtm_Start,ldtm_IN)
				ELSE 
					ll_NumSeconds = lnv_DateTime.of_SecondsAfter(ldtm_Start,ldtm_EndDateTime)
				END IF
				
				// NOTE: 3600 number of seconds in a hour
				li_NumHours = ll_NumSeconds / 3600  
				IF Mod ( ll_NumSeconds , 3600 ) >= 60 THEN 											
					li_NumHours ++     // one min. over and you're charged!
				END IF
				
				IF li_NumHours >= 0 THEN											
					lc_Charges = ld_rate * li_NumHours 											
				//	ad_Charges += ld_rate * li_NumHours 											
				END IF
				
				// rdt 08-05-02 subtract charge amount for number of holidays
				If li_number_holidays > 0 Then 											
					lc_Charges = lc_Charges - (li_Number_Holidays * 24 * ld_rate)					
					//ad_charges = ad_charges - (li_Number_Holidays * 24 * ld_rate)					
				End if 
				
				ls_RangeText = String ( li_NumHours - (li_Number_Holidays * 24)  ) + " HRS @ " + String ( ld_Rate ) + "/HR"	
				lnv_LeaseCharges.of_SetPeriodRange ( i , ls_RangeText )
				lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )	
				lnv_LeaseCharges.of_SetQty ( i , li_NumHours - (li_Number_Holidays * 24) )	
				lnv_LeaseCharges.of_SetPeriodRate ( i , ld_Rate )	
				
				
				ldtm_Start = ldtm_EndDateTime
				ld_HolidayStart = Date(ldtm_Start)
				ld_Start = Date(ldtm_Start)

				IF ldtm_EndDateTime < ldtm_IN THEN  // missed fte (units = hours) need to ad. charges
					ld_Start = relativeDate(ld_Start , -1)	
				END IF	
														
			ELSE
				// rdt 08-05-02 check for holidays and shift dates
				If of_GetPerdiemHoliday() = 0 Then
					
					// RDT 5-30-03 added following if statement
					if ad_ReturnDate < ld_EndDate then
						ld_EndDate = ad_ReturnDate
					end if

					// rdt 08-05-02 get holiday count for date range and add a day to the end date for each holiday
					If li_Units = ci_WorkingDays then 
						
						li_number_holidays = lnv_DateTime.of_getholidaycount (ld_HolidayStart, ld_EndDate, FALSE)
						// number of holidays to End Date 
						if li_number_holidays > 0 Then 
							ld_EndDate = lnv_DateTime.of_relativeDate(ld_EndDate, li_number_holidays , FALSE)
						end if
					Else
						li_number_holidays = lnv_DateTime.of_getholidaycount (ld_HolidayStart, ld_EndDate, TRUE)
						// number of holidays to End Date 
						if li_number_holidays > 0 Then 
							ld_EndDate = lnv_DateTime.of_relativeDate(ld_EndDate, li_number_holidays , FALSE /* CHANGED FROM TRUE for 2.13.06 FIX issue 2176*/)
						end if
					End IF
				End If	
				
				// subtract charge amount for number of holidays								
				lc_Charges -= (li_number_holidays * ld_rate)		
				//ad_charges = ad_charges - (li_number_holidays * ld_rate)
				
				// rdt end
					
				//// 2/13/06Fix -- Commented out following 6 lines	
				// rdt check for a switch from hours to days
				//If Left(String(lt_StartTime),8) <> "23:59:59" then 
					//add a days charges to the amount and set the time.					
					//lc_Charges  += 1 * ld_Rate	
					//ad_Charges += 1 * ld_Rate									
				//End If

				IF ad_returnDate <= ld_EndDate OR isNull(li_period) THEN
					li_NumDays = lnv_DateTime.of_DaysAfter(ld_Start,ad_returnDate,lb_Status )
					lc_Charges += ( li_NumDays * ld_rate)
					li_Range = li_NumDays - li_number_holidays
					//// 2/13/06Fix -- Commented out following 3 lines	
					//IF li_FreeTime = 0 THEN
						//li_Range ++
					//END IF
					ls_RangeText = String ( li_Range ) + " DAYS @ " + String ( ld_rate ) + "/DAY"
					lnv_LeaseCharges.of_SetPeriodRange ( i , ls_RangeText )
					lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
					lnv_LeaseCharges.of_SetQty ( i , li_Range )
					
					
					
					lnv_LeaseCharges.of_SetPeriodRate ( i , ld_Rate )	
					
					
					EXIT
					
				ELSE
					li_NumDays = lnv_DateTime.of_DaysAfter(ld_Start,ld_EndDate,lb_Status )
					lc_Charges += ( li_NumDays * ld_rate)
//					ad_charges += (lnv_DateTime.of_DaysAfter(ld_Start,ld_EndDate,lb_Status )*ld_rate)
				END IF
				li_Range = li_NumDays - li_number_holidays
				
				//// 2/13/06Fix -- Commented out following 3 lines	
				//IF li_FreeTime = 0 THEN
					//li_Range ++
				//END IF
				
				ls_RangeText = String ( li_Range ) + " DAYS @ " + String ( ld_rate ) + "/DAY"
				lnv_LeaseCharges.of_SetPeriodRange ( i , ls_RangeText )
				lnv_LeaseCharges.of_SetCharges ( i , lc_Charges )
				lnv_LeaseCharges.of_SetQty ( i , li_Range )	
				lnv_LeaseCharges.of_SetPeriodRate ( i , ld_Rate )	
				
				ld_HolidayStart = ld_EndDate
				ld_start = ld_EndDate
				ldtm_Start = DateTime(ld_Start,lt_StartTime)
	
			END IF
	
		NEXT
		li_ReturnValue = 1	

	Else														// RDT 101502 Bug fix 

		
//		ad_charges = 0										// RDT 101502 Bug fix 
		li_ReturnValue	= 1								// RDT 101502 Bug fix 
	End If													// RDT 101502 Bug fix 

ELSE
	
	
	
//	setNull(ad_Charges)
	li_ReturnValue = 0
END IF

anv_leasecharges = lnv_LeaseCharges

return li_ReturnValue

end function

private function boolean of_isholidayextrafreeday ();//
/***************************************************************************************
NAME			: of_IsHolidayExtraFreeDay
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Boolean
DESCRIPTION	: Checks System setting to count holiday as an extra free day.
					If the ini entry is not found the default is YES.
					
REVISION		: RDT 5-8-03
				: Changed to system setting
***************************************************************************************/
Boolean	lb_return = TRUE 
Any		la_Value

n_cst_settings	lnv_Settings

IF lnv_Settings.of_GetSetting ( 146 , la_Value ) = 1 THEN
	lb_Return = String ( la_Value ) = "YES!"		
END IF


Return lb_return
end function

public function string of_getscac ();return GetValue("scac")
end function

public function integer of_setscac (string as_scac);integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("scac", as_scac) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode


end function

public function integer of_setdayofinterchangecounts (integer ai_counts);integer li_ReturnCode = 1

// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.
//@(text)--


//@(text)(recreate=yes)<Set Value>
if li_ReturnCode > 0 then
   if SetValue("dayofinterchangecounts", ai_counts ) < 1 then
      li_ReturnCode = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_ReturnCode
//@(text)--

end function

public function integer of_getdayofinterchangecounts ();return GetValue("dayofinterchangecounts")
end function

on n_cst_beo_equipmentleasetype.create
call super::create
end on

on n_cst_beo_equipmentleasetype.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
// RDT 08-05-02 added new columns
this.SetRequired("id")
this.SetRequired("line")
this.SetRequired("type")
this.SetRequired("leasestatus")
this.SetRequired("dayofinterchangecounts")
this.SetRequired("freetimeunits")
this.SetRequired("freetimeperiod")
this.SetRequired("freetimestart")
this.SetRequired("freetimeweekend")
this.SetRequired("chargedperiods")
this.SetRequired("perdiemholiday")


//@(data)--

//@(text)(recreate=yes)<body>

// w/o this the processing was too slow
IF NOT sb_HaveSetting THEN
	sb_HolidayExtraFreeDay = this.of_IsHolidayExtraFreeDay( ) 
	sb_HaveSetting = TRUE
END IF

//@(text)--

end event

event ofr_postnew;call super::ofr_postnew;//Extending ancestor script.
//Return : 1, -1

Long	ll_NextId
Integer	li_Return

IF AncestorReturnValue = 1 THEN

	li_Return = -1
	Constant Boolean	cb_Commit = TRUE
	
	IF gnv_App.of_GetNextId ( This.ClassName ( ), ll_NextId, cb_Commit ) = 1 THEN
	
		IF of_SetId ( ll_NextId ) < 1 THEN
			//Fail
		ELSE
			//Success
			li_Return = 1
		END IF
	
	END IF

ELSE
	li_Return = AncestorReturnValue

END IF

RETURN li_Return
end event

event ofr_validate;//OVERRIDE OF ANCESTOR.  I think extend was causing a stack fault (BKW)

//Determine whether values that are conditionally required have been entered.
//At present, this applies to the rate information.
//Note: If charged periods has not been set, required field processing will flag the
//error so we will not flag that as failure here.

n_cst_OFRError	lnv_Error
Integer	li_ChargedPeriods
Boolean	lb_ValueMissing
Integer	li_Return = 1  //Assume valid until proven otherwise


li_ChargedPeriods = of_GetChargedPeriods ( )


//Based on ChargedPeriods, determine if all values that should be present actually are

IF li_ChargedPeriods > 3 THEN

	IF IsNull ( of_GetFourthChargedUnits ( ) ) OR &
		IsNull ( of_GetFourthChargedRate ( ) ) OR &
		IsNull ( of_GetThirdChargedPeriod ( ) ) THEN 

		lb_ValueMissing = TRUE

	END IF

END IF


IF li_ChargedPeriods > 2 THEN

	IF IsNull ( of_GetThirdChargedUnits ( ) ) OR &
		IsNull ( of_GetThirdChargedRate ( ) ) OR &
		IsNull ( of_GetSecondChargedPeriod ( ) ) THEN 

		lb_ValueMissing = TRUE

	END IF

END IF


IF li_ChargedPeriods > 1 THEN

	IF IsNull ( of_GetSecondChargedUnits ( ) ) OR &
		IsNull ( of_GetSecondChargedRate ( ) ) OR &
		IsNull ( of_GetFirstChargedPeriod ( ) ) THEN 

		lb_ValueMissing = TRUE

	END IF

END IF


IF li_ChargedPeriods > 0 THEN

	IF IsNull ( of_GetFirstChargedUnits ( ) ) OR &
		IsNull ( of_GetFirstChargedRate ( ) ) THEN

		lb_ValueMissing = TRUE

	END IF

END IF

//If an invalid condition was identified, set failure code and propagate error message

IF lb_ValueMissing THEN

	li_Return = -1
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( "Not all required values have been entered." )
//	lnv_Error.SetErrorMessage ( "Please edit your entry." )
	lnv_Error.SetClass ( "Equipment Lease Type is invalid" )

END IF


RETURN li_Return
end event

