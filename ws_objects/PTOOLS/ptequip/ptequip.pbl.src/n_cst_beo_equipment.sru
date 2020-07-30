$PBExportHeader$n_cst_beo_equipment.sru
$PBExportComments$Equipment (Persistent Class from PBL map PTData) //@(*)[75782057|857]
forward
global type n_cst_beo_equipment from n_cst_beo
end type
end forward

global type n_cst_beo_equipment from n_cst_beo
end type
global n_cst_beo_equipment n_cst_beo_equipment

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_beo inv_equipmentlease //@(*)[75782057|857:equipmentlease]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function Long of_GetId ()
public function Integer of_SetId (Long al_id)
public function String of_GetType ()
public function Integer of_SetType (String as_type)
public function String of_GetNumber ()
public function Integer of_SetNumber (String as_number)
public function String of_GetLeased ()
public function Integer of_SetLeased (String as_leased)
public function String of_GetStatus ()
public function Integer of_SetStatus (String as_status)
public function Decimal of_GetLength ()
public function Integer of_SetLength (Decimal ad_length)
public function Decimal of_GetWidth ()
public function Integer of_SetWidth (Decimal ad_width)
public function Long of_GetVolume ()
public function Integer of_SetVolume (Long al_volume)
public function Integer of_GetAxles ()
public function Integer of_SetAxles (Integer ai_axles)
public function String of_GetAir ()
public function Integer of_SetAir (String as_air)
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
public function Long of_GetCurrentevent ()
public function Integer of_SetCurrentevent (Long al_currentevent)
public function Long of_GetNextevent ()
public function Integer of_SetNextevent (Long al_nextevent)
public function String of_GetUser1 ()
public function Integer of_SetUser1 (String as_user1)
public function String of_GetUser2 ()
public function Integer of_SetUser2 (String as_user2)
public function String of_GetUser3 ()
public function Integer of_SetUser3 (String as_user3)
public function String of_GetUser4 ()
public function Integer of_SetUser4 (String as_user4)
public function String of_GetUser5 ()
public function Integer of_SetUser5 (String as_user5)
public function String of_GetNotes ()
public function Integer of_SetNotes (String as_notes)
public function DateTime of_GetTimestamp ()
public function Integer of_SetTimestamp (DateTime ad_timestamp)
public function n_cst_beo of_GetEquipmentlease ()
public function n_cst_beo of_GetEquipmentlease (String as_query)
public function Integer of_SetEquipmentlease (n_cst_beo anv_equipmentlease)
public function integer of_setequipmentleasedirectly (n_cst_beo anv_EquipmentLease)
public function integer of_getcategory ()
public function integer of_getitintype ()
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_equipment")
inv_bcm.RegisterAttribute("id", "long") //@(*)[75782139|858]
inv_bcm.SetKey("id")
inv_bcm.RegisterAttribute("type", "character(1)") //@(*)[75782180|859]
inv_bcm.RegisterAttribute("number", "character(15)") //@(*)[75782209|860]
inv_bcm.RegisterAttribute("leased", "character(1)") //@(*)[75782235|861]
inv_bcm.RegisterAttribute("status", "character(1)") //@(*)[75782278|862]
inv_bcm.RegisterAttribute("length", "decimal") //@(*)[75782317|863]
inv_bcm.RegisterAttribute("width", "decimal") //@(*)[75782345|864]
inv_bcm.RegisterAttribute("volume", "long") //@(*)[75782386|865]
inv_bcm.RegisterAttribute("axles", "integer") //@(*)[75782427|866]
inv_bcm.RegisterAttribute("air", "character(1)") //@(*)[75782468|867]
inv_bcm.RegisterAttribute("spec1", "character(1)") //@(*)[75782509|868]
inv_bcm.RegisterAttribute("spec2", "character(1)") //@(*)[75782537|869]
inv_bcm.RegisterAttribute("spec3", "character(1)") //@(*)[75782578|870]
inv_bcm.RegisterAttribute("spec4", "character(1)") //@(*)[75782619|871]
inv_bcm.RegisterAttribute("spec5", "character(1)") //@(*)[75782661|872]
inv_bcm.RegisterAttribute("currentevent", "long") //@(*)[75782701|873]
inv_bcm.RegisterAttribute("nextevent", "long") //@(*)[75782743|874]
inv_bcm.RegisterAttribute("user1", "string(32767)") //@(*)[63430166|921]
inv_bcm.RegisterAttribute("user2", "string(32767)") //@(*)[63469746|922]
inv_bcm.RegisterAttribute("user3", "string(32767)") //@(*)[63479637|923]
inv_bcm.RegisterAttribute("user4", "string(32767)") //@(*)[63488223|924]
inv_bcm.RegisterAttribute("user5", "string(32767)") //@(*)[63498506|925]
inv_bcm.RegisterAttribute("notes", "string(32767)") //@(*)[63512607|926]
inv_bcm.RegisterAttribute("timestamp", "datetime") //@(*)[66898535|938]
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "equipment", "eq_id")
   inv_bcm.MapDBColumn("type", "equipment", "eq_type")
   inv_bcm.MapDBColumn("number", "equipment", "eq_ref")
   inv_bcm.MapDBColumn("leased", "equipment", "eq_outside")
   inv_bcm.MapDBColumn("status", "equipment", "eq_status")
   inv_bcm.MapDBColumn("length", "equipment", "eq_length")
   inv_bcm.MapDBColumn("width", "equipment", "eq_height")
   inv_bcm.MapDBColumn("volume", "equipment", "eq_volume")
   inv_bcm.MapDBColumn("axles", "equipment", "eq_axles")
   inv_bcm.MapDBColumn("air", "equipment", "eq_air")
   inv_bcm.MapDBColumn("spec1", "equipment", "eq_spec1")
   inv_bcm.MapDBColumn("spec2", "equipment", "eq_spec2")
   inv_bcm.MapDBColumn("spec3", "equipment", "eq_spec3")
   inv_bcm.MapDBColumn("spec4", "equipment", "eq_spec4")
   inv_bcm.MapDBColumn("spec5", "equipment", "eq_spec5")
   inv_bcm.MapDBColumn("currentevent", "equipment", "eq_cur_event")
   inv_bcm.MapDBColumn("nextevent", "equipment", "eq_next_event")
   inv_bcm.MapDBColumn("user1", "equipment", "User1")
   inv_bcm.MapDBColumn("user2", "equipment", "User2")
   inv_bcm.MapDBColumn("user3", "equipment", "User3")
   inv_bcm.MapDBColumn("user4", "equipment", "User4")
   inv_bcm.MapDBColumn("user5", "equipment", "User5")
   inv_bcm.MapDBColumn("notes", "equipment", "Notes")
   inv_bcm.MapDBColumn("timestamp", "equipment", "timestamp")
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
 case "type" 
   return of_SetType(String(aa_value))
 case "number" 
   return of_SetNumber(String(aa_value))
 case "leased" 
   return of_SetLeased(String(aa_value))
 case "status" 
   return of_SetStatus(String(aa_value))
 case "length" 
   return of_SetLength(Dec(aa_value))
 case "width" 
   return of_SetWidth(Dec(aa_value))
 case "volume" 
   return of_SetVolume(Long(aa_value))
 case "axles" 
   return of_SetAxles(Integer(aa_value))
 case "air" 
   return of_SetAir(String(aa_value))
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
 case "currentevent" 
   return of_SetCurrentevent(Long(aa_value))
 case "nextevent" 
   return of_SetNextevent(Long(aa_value))
 case "user1" 
   return of_SetUser1(String(aa_value))
 case "user2" 
   return of_SetUser2(String(aa_value))
 case "user3" 
   return of_SetUser3(String(aa_value))
 case "user4" 
   return of_SetUser4(String(aa_value))
 case "user5" 
   return of_SetUser5(String(aa_value))
 case "notes" 
   return of_SetNotes(String(aa_value))
 case "timestamp" 
   return of_SetTimestamp(Convert(aa_value, TypeDateTime!))
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
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
 case "number" 
   aa_value = of_GetNumber()
   li_rc = 1
 case "leased" 
   aa_value = of_GetLeased()
   li_rc = 1
 case "status" 
   aa_value = of_GetStatus()
   li_rc = 1
 case "length" 
   aa_value = of_GetLength()
   li_rc = 1
 case "width" 
   aa_value = of_GetWidth()
   li_rc = 1
 case "volume" 
   aa_value = of_GetVolume()
   li_rc = 1
 case "axles" 
   aa_value = of_GetAxles()
   li_rc = 1
 case "air" 
   aa_value = of_GetAir()
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
 case "currentevent" 
   aa_value = of_GetCurrentevent()
   li_rc = 1
 case "nextevent" 
   aa_value = of_GetNextevent()
   li_rc = 1
 case "user1" 
   aa_value = of_GetUser1()
   li_rc = 1
 case "user2" 
   aa_value = of_GetUser2()
   li_rc = 1
 case "user3" 
   aa_value = of_GetUser3()
   li_rc = 1
 case "user4" 
   aa_value = of_GetUser4()
   li_rc = 1
 case "user5" 
   aa_value = of_GetUser5()
   li_rc = 1
 case "notes" 
   aa_value = of_GetNotes()
   li_rc = 1
 case "timestamp" 
   aa_value = of_GetTimestamp()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[75782139|858:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_SetId (Long al_id);//@(*)[75782139|858:id:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetType ();//@(*)[75782180|859:type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("type")
//@(text)--

end function

public function Integer of_SetType (String as_type);//@(*)[75782180|859:type:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetNumber ();//@(*)[75782209|860:number:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("number")
//@(text)--

end function

public function Integer of_SetNumber (String as_number);//@(*)[75782209|860:number:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "number" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("number", as_number) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetLeased ();//@(*)[75782235|861:leased:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("leased")
//@(text)--

end function

public function Integer of_SetLeased (String as_leased);//@(*)[75782235|861:leased:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "leased" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("leased", as_leased) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetStatus ();//@(*)[75782278|862:status:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("status")
//@(text)--

end function

public function Integer of_SetStatus (String as_status);//@(*)[75782278|862:status:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Decimal of_GetLength ();//@(*)[75782317|863:length:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("length")
//@(text)--

end function

public function Integer of_SetLength (Decimal ad_length);//@(*)[75782317|863:length:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "length" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("length", ad_length) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetWidth ();//@(*)[75782345|864:width:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("width")
//@(text)--

end function

public function Integer of_SetWidth (Decimal ad_width);//@(*)[75782345|864:width:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "width" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("width", ad_width) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetVolume ();//@(*)[75782386|865:volume:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("volume")
//@(text)--

end function

public function Integer of_SetVolume (Long al_volume);//@(*)[75782386|865:volume:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "volume" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("volume", al_volume) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetAxles ();//@(*)[75782427|866:axles:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("axles")
//@(text)--

end function

public function Integer of_SetAxles (Integer ai_axles);//@(*)[75782427|866:axles:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "axles" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("axles", ai_axles) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetAir ();//@(*)[75782468|867:air:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("air")
//@(text)--

end function

public function Integer of_SetAir (String as_air);//@(*)[75782468|867:air:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "air" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("air", as_air) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetSpec1 ();//@(*)[75782509|868:spec1:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec1")
//@(text)--

end function

public function Integer of_SetSpec1 (String as_spec1);//@(*)[75782509|868:spec1:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetSpec2 ();//@(*)[75782537|869:spec2:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec2")
//@(text)--

end function

public function Integer of_SetSpec2 (String as_spec2);//@(*)[75782537|869:spec2:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetSpec3 ();//@(*)[75782578|870:spec3:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec3")
//@(text)--

end function

public function Integer of_SetSpec3 (String as_spec3);//@(*)[75782578|870:spec3:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetSpec4 ();//@(*)[75782619|871:spec4:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec4")
//@(text)--

end function

public function Integer of_SetSpec4 (String as_spec4);//@(*)[75782619|871:spec4:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetSpec5 ();//@(*)[75782661|872:spec5:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("spec5")
//@(text)--

end function

public function Integer of_SetSpec5 (String as_spec5);//@(*)[75782661|872:spec5:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Long of_GetCurrentevent ();//@(*)[75782701|873:currentevent:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("currentevent")
//@(text)--

end function

public function Integer of_SetCurrentevent (Long al_currentevent);//@(*)[75782701|873:currentevent:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "currentevent" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("currentevent", al_currentevent) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetNextevent ();//@(*)[75782743|874:nextevent:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("nextevent")
//@(text)--

end function

public function Integer of_SetNextevent (Long al_nextevent);//@(*)[75782743|874:nextevent:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "nextevent" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("nextevent", al_nextevent) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetUser1 ();//@(*)[63430166|921:user1:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user1")
//@(text)--

end function

public function Integer of_SetUser1 (String as_user1);//@(*)[63430166|921:user1:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetUser2 ();//@(*)[63469746|922:user2:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user2")
//@(text)--

end function

public function Integer of_SetUser2 (String as_user2);//@(*)[63469746|922:user2:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetUser3 ();//@(*)[63479637|923:user3:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user3")
//@(text)--

end function

public function Integer of_SetUser3 (String as_user3);//@(*)[63479637|923:user3:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "user3" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("user3", as_user3) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetUser4 ();//@(*)[63488223|924:user4:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user4")
//@(text)--

end function

public function Integer of_SetUser4 (String as_user4);//@(*)[63488223|924:user4:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "user4" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("user4", as_user4) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetUser5 ();//@(*)[63498506|925:user5:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("user5")
//@(text)--

end function

public function Integer of_SetUser5 (String as_user5);//@(*)[63498506|925:user5:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "user5" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("user5", as_user5) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetNotes ();//@(*)[63512607|926:notes:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("notes")
//@(text)--

end function

public function Integer of_SetNotes (String as_notes);//@(*)[63512607|926:notes:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function DateTime of_GetTimestamp ();//@(*)[66898535|938:timestamp:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("timestamp")
//@(text)--

end function

public function Integer of_SetTimestamp (DateTime ad_timestamp);//@(*)[66898535|938:timestamp:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "timestamp" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("timestamp", ad_timestamp) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_GetEquipmentlease ();//@(*)[58729747|916:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetEquipmentlease(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetEquipmentlease (String as_query);//@(*)[58729747|916]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_equipmentlease = GetRelationship( inv_equipmentlease, "n_cst_dlkc_equipmentlease",  "equipmentlease", "equipment", as_query, "n_cst_beo_equipmentlease" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_equipmentlease
//@(text)--

end function

public function Integer of_SetEquipmentlease (n_cst_beo anv_equipmentlease);//@(*)[58729747|916:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_equipmentlease,"equipmentlease") = 1 then
inv_equipmentlease = anv_equipmentlease
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function integer of_setequipmentleasedirectly (n_cst_beo anv_EquipmentLease);inv_equipmentlease = anv_EquipmentLease
Return 1
end function

public function integer of_getcategory ();//Returns : The appropriate type contant, or null if could not be determined.

n_cst_EquipmentManager	lnv_EquipmentManager

Integer	li_Return

li_Return = lnv_EquipmentManager.of_Type_To_Category ( This.of_GetType ( ) )

RETURN li_Return
end function

public function integer of_getitintype ();//Returns : The ItinType for the equipment, or null if cannot be determined.

Integer	li_Category

Integer	li_Return


li_Category = This.of_GetCategory ( )

CHOOSE CASE li_Category

CASE 2  //PowerUnits
	li_Return = gc_Dispatch.ci_ItinType_PowerUnit

CASE 3  //TrailerChassis
	li_Return = gc_Dispatch.ci_ItinType_TrailerChassis

CASE 4  //Containers
	li_Return = gc_Dispatch.ci_ItinType_Container

CASE ELSE
	SetNull ( li_Return )

END CHOOSE

RETURN li_Return
end function

on n_cst_beo_equipment.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_equipment.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

