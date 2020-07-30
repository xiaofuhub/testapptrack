$PBExportHeader$n_cst_beo_amounttemplate.sru
$PBExportComments$AmountTemplate (Persistent Class from PBL map PTSetl) //@(*)[23640230|1283]
forward
global type n_cst_beo_amounttemplate from n_cst_beo
end type
end forward

global type n_cst_beo_amounttemplate from n_cst_beo
end type
global n_cst_beo_amounttemplate n_cst_beo_amounttemplate

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_beo inv_ref1type //@(*)[23640230|1283:ref1type]<nosync>
private n_cst_beo inv_ref2type //@(*)[23640230|1283:ref2type]<nosync>
private n_cst_beo inv_ref3type //@(*)[23640230|1283:ref3type]<nosync>
private n_cst_bcm inv_join_entity_amounttemplate //@(*)[57511999|1459:join_entity_amounttemplate]<nosync>
private n_cst_bcm inv_entity //@(*)[57511999|1459:entity]<nosync>
private n_cst_beo inv_ratetype //@(*)[23640230|1283:ratetype]<nosync>
private n_cst_beo inv_amounttype //@(*)[23640230|1283:amounttype]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.
Constant Integer	ci_IntervalType_None = 0
Constant Integer	ci_IntervalType_Every = 1
Constant Integer	ci_IntervalType_On = 2
Constant String	cs_IntervalType_ValueList = "[NONE]~t0/EVERY __ DAYS~t1/ON __ DAY(S)~t2/"

Constant Integer	ci_Type_All = 0
Constant Integer	ci_Type_Point_to_point = 1
Constant Integer	ci_Type_Shipment = 2
Constant Integer	ci_Type_Move = 3
Constant Integer	ci_Type_DateRange = 4
Constant Integer	ci_Type_Day = 5
Constant Integer	ci_Type_Leg = 6
Constant Integer	ci_Type_Periodic = 7
Constant Integer	ci_Type_FuelSurcharge = 8
Constant String	cs_Type_ValueList = "POINT-TO-POINT~t1/SHIPMENT~t2/MOVE~t3/DATE RANGE ~t4/DAY~t5/LEG~t6/PERIODIC~t7/FUEL SURCHARGE~t8"
end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly string as_name, readonly any aa_value)
protected function integer getattribute (readonly string as_name, ref any aa_value)
public function Long of_GetId ()
public function Integer of_SetId (Long al_id)
public function Integer of_GetRef1typeid ()
public function Integer of_SetRef1typeid (Integer ai_ref1typeid)
public function Integer of_GetRef2typeid ()
public function Integer of_SetRef2typeid (Integer ai_ref2typeid)
public function Integer of_GetRef3typeid ()
public function Integer of_SetRef3typeid (Integer ai_ref3typeid)
public function String of_GetName ()
public function Integer of_SetName (String as_name)
public function Integer of_GetCategory ()
public function Integer of_SetCategory (Integer ai_category)
public function Integer of_GetDivision ()
public function integer of_setdivision (integer ai_division)
public function String of_GetDescription ()
public function Integer of_SetDescription (String as_description)
public function String of_GetRef1text ()
public function Integer of_SetRef1text (String as_ref1text)
public function String of_GetRef2text ()
public function Integer of_SetRef2text (String as_ref2text)
public function String of_GetRef3text ()
public function Integer of_SetRef3text (String as_ref3text)
public function n_cst_beo of_GetRef1type ()
public function n_cst_beo of_GetRef1type (String as_query)
public function Integer of_SetRef1type (n_cst_beo anv_refnumtype)
public function n_cst_beo of_GetRef2type ()
public function n_cst_beo of_GetRef2type (String as_query)
public function Integer of_SetRef2type (n_cst_beo anv_refnumtype)
public function n_cst_beo of_GetRef3type ()
public function n_cst_beo of_GetRef3type (String as_query)
public function Integer of_SetRef3type (n_cst_beo anv_refnumtype)
public function Integer of_getrequiredfields (ref string as_fieldlist)
public function Boolean of_isfieldreferenced (string as_field)
public function String of_GetGenerationcondition ()
public function Integer of_SetGenerationcondition (String as_generationcondition)
public function Boolean of_GetGenerateifzero ()
public function Integer of_SetGenerateifzero (Boolean ab_generateifzero)
public function String of_GetQuantity ()
public function Integer of_SetQuantity (String as_quantity)
public function String of_GetRate ()
public function Integer of_SetRate (String as_rate)
public function String of_GetAmount ()
public function Integer of_SetAmount (String as_amount)
public function n_cst_bcm of_GetJoin_entity_amounttemplate (String as_query)
public function n_cst_bcm of_GetJoin_entity_amounttemplate ()
public function n_cst_bcm of_GetEntity (String as_query)
public function n_cst_bcm of_GetEntity ()
public function Integer of_GetAmounttypeid ()
public function Integer of_SetAmounttypeid (Integer ai_amounttypeid)
public function Integer of_GetRatetypeid ()
public function Integer of_SetRatetypeid (Integer ai_ratetypeid)
public function n_cst_beo of_GetRatetype ()
public function n_cst_beo of_GetRatetype (String as_query)
public function Integer of_SetRatetype (n_cst_beo anv_ratetype)
public function n_cst_beo of_GetAmounttype ()
public function n_cst_beo of_GetAmounttype (String as_query)
public function Integer of_SetAmounttype (n_cst_beo anv_amounttype)
protected function Integer of_validateexpression (string as_type, string as_expression)
public function boolean of_getaggregatecalc ()
public function string of_getsplitsby ()
public function integer of_setaggregatecalc (boolean ab_aggregatecalc)
public function integer of_setsplitsby (string as_splitsby)
public function integer of_gettype ()
public function string of_getselectionfilter ()
public function integer of_settype (integer ai_type)
public function integer of_setselectionfilter (string as_selectionfilter)
public function string of_getcustom1 ()
public function string of_getcustom2 ()
public function string of_getcustom3 ()
public function integer of_setcustom1 (string as_custom)
public function integer of_setcustom2 (string as_Custom)
public function integer of_setcustom3 (string as_custom)
public function integer of_getintervaltype ()
public function string of_getinterval ()
public function date of_getactivationdate ()
public function decimal of_gettargettotal ()
public function decimal of_getrunningtotal ()
public function decimal of_getlastamount ()
public function date of_getlastdate ()
public function date of_getfirstdate ()
public function integer of_setintervaltype (integer ai_intervaltype)
public function integer of_setinterval (string as_interval)
public function integer of_settargettotal (decimal ac_targettotal)
public function integer of_setrunningtotal (decimal ac_runningtotal)
public function integer of_setlastamount (decimal ac_lastamount)
public function integer of_setlastdate (date ad_lastdate)
public function integer of_setfirstdate (date ad_firstdate)
public function integer of_setactivationdate (date ad_activationdate)
public function long of_getfkentity ()
public function long of_getrunningcount ()
public function integer of_setfkentity (long ai_fkentity)
public function integer of_setrunningcount (long ai_runningcount)
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_amounttemplate")
inv_bcm.RegisterAttribute("id", "long") //@(*)[23667583|1284]
inv_bcm.SetKey("id")
inv_bcm.RegisterRelationshipAttribute("ref1typeid", "integer", "n_cst_beo_refnumtype", "id", "ref1type")
inv_bcm.RegisterRelationshipAttribute("ref2typeid", "integer", "n_cst_beo_refnumtype", "id", "ref2type")
inv_bcm.RegisterRelationshipAttribute("ref3typeid", "integer", "n_cst_beo_refnumtype", "id", "ref3type")
inv_bcm.RegisterRelationshipAttribute("amounttypeid", "integer", "n_cst_beo_amounttype", "id", "amounttype")
inv_bcm.RegisterRelationshipAttribute("ratetypeid", "integer", "n_cst_beo_ratetype", "id", "ratetype")
inv_bcm.RegisterAttribute("name", "string(32767)") //@(*)[25265978|1300]
inv_bcm.RegisterAttribute("category", "integer") //@(*)[23777753|1286]
inv_bcm.RegisterAttribute("division", "integer") //@(*)[23845390|1289]
inv_bcm.RegisterAttribute("generationcondition", "string(32767)") //@(*)[71873347|1347]
inv_bcm.RegisterAttribute("generateifzero", "boolean") //@(*)[71900634|1348]
inv_bcm.RegisterAttribute("description", "string(32767)") //@(*)[24130218|1291]
inv_bcm.RegisterAttribute("quantity", "string(32767)") //@(*)[24346430|1295]
inv_bcm.RegisterAttribute("rate", "string(32767)") //@(*)[24574329|1296]
inv_bcm.RegisterAttribute("amount", "string(32767)") //@(*)[71443642|1346]
inv_bcm.RegisterAttribute("ref1text", "string(32767)") //@(*)[26714584|1305]
inv_bcm.RegisterAttribute("ref2text", "string(32767)") //@(*)[26729550|1306]
inv_bcm.RegisterAttribute("ref3text", "string(32767)") //@(*)[26739506|1307]
inv_bcm.RegisterAttribute("aggregatecalc", "boolean") //Added manually
inv_bcm.RegisterAttribute("splitsby", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("type", "integer") //Added manually
inv_bcm.RegisterAttribute("selectionfilter", "string(32767)") //Added manually
// jma 9/05/02 added fields to do automatic generation for payables - Central
//   States project
inv_bcm.RegisterAttribute("fkentity", "long") //Added manually
inv_bcm.RegisterAttribute("intervaltype", "integer") //Added manually
inv_bcm.RegisterAttribute("interval", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("activationdate", "date") //Added manually
inv_bcm.RegisterAttribute("targettotal", "decimal") //Added manually
inv_bcm.RegisterAttribute("runningtotal", "decimal") //Added manually
inv_bcm.RegisterAttribute("runningcount", "long") //Added manually
inv_bcm.RegisterAttribute("lastamount", "decimal") //Added manually
inv_bcm.RegisterAttribute("lastdate", "date") //Added manually
inv_bcm.RegisterAttribute("firstdate", "date") //Added manually
// rdt 08-14-02 added custom fields
inv_bcm.RegisterAttribute("custom1", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("custom2", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("custom3", "string(32767)") //Added manually
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "AmountTemplate", "Id")
   inv_bcm.MapDBColumn("ref1typeid", "AmountTemplate", "Ref1TypeId")
   inv_bcm.MapDBColumn("ref2typeid", "AmountTemplate", "Ref2TypeId")
   inv_bcm.MapDBColumn("ref3typeid", "AmountTemplate", "Ref3TypeId")
   inv_bcm.MapDBColumn("amounttypeid", "AmountTemplate", "AmountTypeId")
   inv_bcm.MapDBColumn("ratetypeid", "AmountTemplate", "RateTypeId")
   inv_bcm.MapDBColumn("name", "AmountTemplate", "Name")
   inv_bcm.MapDBColumn("category", "AmountTemplate", "Category")
   inv_bcm.MapDBColumn("division", "AmountTemplate", "Division")
   inv_bcm.MapDBColumn("generationcondition", "AmountTemplate", "GenerationCondition")
   inv_bcm.MapDBColumn("generateifzero", "AmountTemplate", "GenerateIfZero")
   inv_bcm.MapDBColumn("description", "AmountTemplate", "Description")
   inv_bcm.MapDBColumn("quantity", "AmountTemplate", "Quantity")
   inv_bcm.MapDBColumn("rate", "AmountTemplate", "Rate")
   inv_bcm.MapDBColumn("amount", "AmountTemplate", "Amount")
   inv_bcm.MapDBColumn("ref1text", "AmountTemplate", "Ref1Text")
   inv_bcm.MapDBColumn("ref2text", "AmountTemplate", "Ref2Text")
   inv_bcm.MapDBColumn("ref3text", "AmountTemplate", "Ref3Text")
   inv_bcm.MapDBColumn("aggregatecalc", "AmountTemplate", "AggregateCalc")
   inv_bcm.MapDBColumn("splitsby", "AmountTemplate", "SplitsBy")
   inv_bcm.MapDBColumn("type", "AmountTemplate", "Type")
   inv_bcm.MapDBColumn("selectionfilter", "AmountTemplate", "SelectionFilter")
	// jma 9.05.02  added fields to do automatic generation for payables - Central 
	//  States project
   inv_bcm.MapDBColumn("fkentity", "AmountTemplate", "fkentity")
   inv_bcm.MapDBColumn("intervaltype", "AmountTemplate", "IntervalType")
   inv_bcm.MapDBColumn("interval", "AmountTemplate", "Interval")
   inv_bcm.MapDBColumn("activationdate", "AmountTemplate", "ActivationDate")
   inv_bcm.MapDBColumn("targettotal", "AmountTemplate", "TargetTotal")
   inv_bcm.MapDBColumn("runningtotal", "AmountTemplate", "RunningTotal")
   inv_bcm.MapDBColumn("runningcount", "AmountTemplate", "RunningCount")
   inv_bcm.MapDBColumn("lastamount", "AmountTemplate", "LastAmount")
   inv_bcm.MapDBColumn("lastdate", "AmountTemplate", "LastDate")
   inv_bcm.MapDBColumn("firstdate", "AmountTemplate", "FirstDate")	
	// rdt 08-14-02 added custom fields
   inv_bcm.MapDBColumn("custom1", "AmountTemplate", "Custom1")
   inv_bcm.MapDBColumn("custom2", "AmountTemplate", "Custom2")
   inv_bcm.MapDBColumn("custom3", "AmountTemplate", "Custom3")
	
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
 case "ref1typeid" 
   return of_SetRef1typeid(Integer(aa_value))
 case "ref2typeid" 
   return of_SetRef2typeid(Integer(aa_value))
 case "ref3typeid" 
   return of_SetRef3typeid(Integer(aa_value))
 case "amounttypeid" 
   return of_SetAmounttypeid(Integer(aa_value))
 case "ratetypeid" 
   return of_SetRatetypeid(Integer(aa_value))
 case "name" 
   return of_SetName(String(aa_value))
 case "category" 
   return of_SetCategory(Integer(aa_value))
 case "division" 
   return of_SetDivision(Integer(aa_value))
 case "generationcondition" 
   return of_SetGenerationcondition(String(aa_value))
 case "generateifzero" 
   return of_SetGenerateifzero(Convert(aa_value, TypeBoolean!))
 case "description" 
   return of_SetDescription(String(aa_value))
 case "quantity" 
   return of_SetQuantity(String(aa_value))
 case "rate" 
   return of_SetRate(String(aa_value))
 case "amount" 
   return of_SetAmount(String(aa_value))
 case "ref1text" 
   return of_SetRef1text(String(aa_value))
 case "ref2text" 
   return of_SetRef2text(String(aa_value))
 case "ref3text" 
   return of_SetRef3text(String(aa_value))
 case "aggregatecalc" 
   return of_SetAggregateCalc(Convert(aa_value, TypeBoolean!))
 case "splitsby" 
   return of_SetSplitsBy(String(aa_value))
 case "type" 
   return of_SetType(Integer(aa_value))
 case "selectionfilter" 
   return of_SetSelectionFilter(String(aa_value))
// jma 09.05.02 added fields for automatic generation of
//   payables for Central States project.
case "fkentity" 
  return of_Setfkentity(Long(aa_value))
case "intervaltype" 
  return of_Setintervaltype(Integer(aa_value))
case "interval" 
  return of_Setinterval(String(aa_value))
case "activationdate" 
//  return of_Setactivationdate(Date(aa_value))
  return of_Setactivationdate(Convert(aa_value, TypeDate!))
case "targettotal" 
  return of_Settargettotal(Dec(aa_value))
case "runningtotal" 
  return of_Setrunningtotal(Dec(aa_value))
case "runningcount" 
  return of_Setrunningcount(Long(aa_value))
case "lastamount" 
  return of_Setlastamount(Dec(aa_value))
case "lastdate" 
//  return of_Setlastdate(Date(aa_value))
  return of_Setlastdate(Convert(aa_value, TypeDate!))  
case "firstdate" 
//  return of_Setfirstdate(Date(aa_value))  
  return of_Setfirstdate(Convert(aa_value, TypeDate!))    
// rdt 08-14-02 added custom fields
 case "custom1" 
   return of_SetCustom1(String(aa_value))
 case "custom2" 
   return of_SetCustom2(String(aa_value))
 case "custom3" 
   return of_SetCustom3(String(aa_value))

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
 case "ref1typeid" 
   aa_value = of_GetRef1typeid()
   li_rc = 1
 case "ref2typeid" 
   aa_value = of_GetRef2typeid()
   li_rc = 1
 case "ref3typeid" 
   aa_value = of_GetRef3typeid()
   li_rc = 1
 case "amounttypeid" 
   aa_value = of_GetAmounttypeid()
   li_rc = 1
 case "ratetypeid" 
   aa_value = of_GetRatetypeid()
   li_rc = 1
 case "name" 
   aa_value = of_GetName()
   li_rc = 1
 case "category" 
   aa_value = of_GetCategory()
   li_rc = 1
 case "division" 
   aa_value = of_GetDivision()
   li_rc = 1
 case "generationcondition" 
   aa_value = of_GetGenerationcondition()
   li_rc = 1
 case "generateifzero" 
   aa_value = of_GetGenerateifzero()
   li_rc = 1
 case "description" 
   aa_value = of_GetDescription()
   li_rc = 1
 case "quantity" 
   aa_value = of_GetQuantity()
   li_rc = 1
 case "rate" 
   aa_value = of_GetRate()
   li_rc = 1
 case "amount" 
   aa_value = of_GetAmount()
   li_rc = 1
 case "ref1text" 
   aa_value = of_GetRef1text()
   li_rc = 1
 case "ref2text" 
   aa_value = of_GetRef2text()
   li_rc = 1
 case "ref3text" 
   aa_value = of_GetRef3text()
   li_rc = 1
 case "aggregatecalc" 
   aa_value = of_GetAggregateCalc()
   li_rc = 1
 case "splitsby" 
   aa_value = of_GetSplitsBy()
   li_rc = 1
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
 case "selectionfilter" 
   aa_value = of_GetSelectionFilter()
   li_rc = 1
// jma 9.05.02  added fields for automatic generation
// of payables for Central States project
 case "fkentity" 
   aa_value = of_Getfkentity()
   li_rc = 1
 case "intervaltype" 
   aa_value = of_Getintervaltype()
   li_rc = 1
 case "interval" 
   aa_value = of_Getinterval()
   li_rc = 1
 case "activationdate" 
   aa_value = of_Getactivationdate()
   li_rc = 1
 case "targettotal" 
   aa_value = of_Gettargettotal()
   li_rc = 1
 case "runningtotal" 
   aa_value = of_Getrunningtotal()
   li_rc = 1
 case "runningcount" 
   aa_value = of_Getrunningcount()
   li_rc = 1
 case "lastamount" 
   aa_value = of_Getlastamount()
   li_rc = 1
 case "lastdate" 
   aa_value = of_Getlastdate()
   li_rc = 1
 case "firstdate" 
   aa_value = of_Getfirstdate()
   li_rc = 1
// rdt 08-14-02 added custom fields
 CASE "custom1"
	aa_Value = of_GetCustom1()
   li_rc = 1
 CASE "custom2"
	aa_Value = of_GetCustom2()
   li_rc = 1
 CASE "custom3"
	aa_Value = of_GetCustom3()
   li_rc = 1
			

end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[23667583|1284:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_SetId (Long al_id);//@(*)[23667583|1284:id:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetRef1typeid ();//@(*)[70899352|661:ref1typeid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref1typeid")
//@(text)--

end function

public function Integer of_SetRef1typeid (Integer ai_ref1typeid);//@(*)[70899352|661:ref1typeid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref1typeid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


IF li_rc > 0 THEN

	IF ai_Ref1TypeId = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Ref1TypeId )
		li_rc = 2  //To force redisplay of field.
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref1typeid", ai_ref1typeid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetRef2typeid ();//@(*)[70899352|661:ref2typeid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref2typeid")
//@(text)--

end function

public function Integer of_SetRef2typeid (Integer ai_ref2typeid);//@(*)[70899352|661:ref2typeid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref2typeid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


IF li_rc > 0 THEN

	IF ai_Ref2TypeId = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Ref2TypeId )
		li_rc = 2  //To force redisplay of field.
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref2typeid", ai_ref2typeid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetRef3typeid ();//@(*)[70899352|661:ref3typeid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref3typeid")
//@(text)--

end function

public function Integer of_SetRef3typeid (Integer ai_ref3typeid);//@(*)[70899352|661:ref3typeid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref3typeid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


IF li_rc > 0 THEN

	IF ai_Ref3TypeId = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Ref3TypeId )
		li_rc = 2  //To force redisplay of field.
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref3typeid", ai_ref3typeid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetName ();//@(*)[25265978|1300:name:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("name")
//@(text)--

end function

public function Integer of_SetName (String as_name);//@(*)[25265978|1300:name:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "name" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("name", as_name) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetCategory ();//@(*)[23777753|1286:category:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("category")
//@(text)--

end function

public function Integer of_SetCategory (Integer ai_category);//@(*)[23777753|1286:category:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "category" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("category", ai_category) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetDivision ();//@(*)[23845390|1289:division:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("division")
//@(text)--

end function

public function integer of_setdivision (integer ai_division);//@(*)[23845390|1289:division:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "division" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


n_cst_beo_ShipType	lnv_ShipType
Boolean	lb_Active

String	ls_Message, &
			ls_MessageHeader = "Change Division"
n_cst_OFRError	lnv_Error

lnv_ShipType = CREATE n_cst_beo_ShipType

//IF li_rc > 0 THEN
//	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
//		li_rc = -1
//	END IF
//END IF


IF li_rc > 0 THEN

	IF ai_Division = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Division )
		li_rc = 2  //To force redisplay of field

	ELSEIF IsNull ( ai_Division ) THEN
		//OK - No processing needed.

	ELSE

		lnv_ShipType.of_SetUseCache ( TRUE )
		lnv_ShipType.of_SetSourceId ( ai_Division )

		lb_Active = lnv_ShipType.of_IsActive ( )

		IF lb_Active = FALSE THEN
	
			ls_Message = "The division you have selected has been deactivated, and is only "+&
				"listed for historical display purposes.  Please make another selection, or "+&
				"press Esc twice to clear your edit."
			li_rc = -1

		ELSEIF IsNull ( lb_Active ) THEN

			ls_Message = "Could not validate your selection.  Please make another selection, or "+&
				"press Esc twice to clear your edit."
			li_rc = -1
	
		END IF

	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("division", ai_division) < 1 then
      li_rc = -1
   end if
end if
//@(text)--


//If an error explanation was provided above, create an OFRError.
IF li_rc = -1 AND Len ( ls_Message ) > 0 THEN
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage( ls_Message )
	lnv_Error.SetMessageHeader ( ls_MessageHeader )
END IF

DESTROY ( lnv_ShipType )
//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetDescription ();//@(*)[24130218|1291:description:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("description")
//@(text)--

end function

public function Integer of_SetDescription (String as_description);//@(*)[24130218|1291:description:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "description" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("description", as_description) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRef1text ();//@(*)[26714584|1305:ref1text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref1text")
//@(text)--

end function

public function Integer of_SetRef1text (String as_ref1text);//@(*)[26714584|1305:ref1text:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref1text" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref1text", as_ref1text) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRef2text ();//@(*)[26729550|1306:ref2text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref2text")
//@(text)--

end function

public function Integer of_SetRef2text (String as_ref2text);//@(*)[26729550|1306:ref2text:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref2text" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref2text", as_ref2text) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRef3text ();//@(*)[26739506|1307:ref3text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref3text")
//@(text)--

end function

public function Integer of_SetRef3text (String as_ref3text);//@(*)[26739506|1307:ref3text:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref3text" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref3text", as_ref3text) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_GetRef1type ();//@(*)[26415476|1301:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetRef1type(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetRef1type (String as_query);//@(*)[26415476|1301]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_ref1type = GetRelationship( inv_ref1type, "n_cst_dlkc_refnumtype",  "ref1type", "amounttemplate", as_query, "n_cst_beo_refnumtype" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_ref1type
//@(text)--

end function

public function Integer of_SetRef1type (n_cst_beo anv_refnumtype);//@(*)[26415476|1301:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_refnumtype,"refnumtype") = 1 then
inv_ref1type = anv_refnumtype
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function n_cst_beo of_GetRef2type ();//@(*)[26602484|1302:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetRef2type(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetRef2type (String as_query);//@(*)[26602484|1302]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_ref2type = GetRelationship( inv_ref2type, "n_cst_dlkc_refnumtype",  "ref2type", "amounttemplate_2", as_query, "n_cst_beo_refnumtype" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_ref2type
//@(text)--

end function

public function Integer of_SetRef2type (n_cst_beo anv_refnumtype);//@(*)[26602484|1302:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_refnumtype,"refnumtype") = 1 then
inv_ref2type = anv_refnumtype
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function n_cst_beo of_GetRef3type ();//@(*)[26633330|1303:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetRef3type(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetRef3type (String as_query);//@(*)[26633330|1303]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_ref3type = GetRelationship( inv_ref3type, "n_cst_dlkc_refnumtype",  "ref3type", "amounttemplate_3", as_query, "n_cst_beo_refnumtype" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_ref3type
//@(text)--

end function

public function Integer of_SetRef3type (n_cst_beo anv_refnumtype);//@(*)[26633330|1303:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_refnumtype,"refnumtype") = 1 then
inv_ref3type = anv_refnumtype
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function Integer of_getrequiredfields (ref string as_fieldlist);//@(*)[46922379|1325]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

/*
String	lsa_Expressions[], &
			lsa_DefinedFields[], &
			lsa_RequiredFields[], &
			ls_Check
Integer	li_ExpressionCount, &
			li_DefinedFieldCount, &
			li_RequiredFieldCount, &
			li_ExpressionIndex, &
			li_DefinedFieldIndex
n_cst_String	lnv_String

Integer	li_Return = 1


//Get a list of the expressions that may contain column references.

li_ExpressionCount ++
lsa_Expressions [ li_ExpressionCount ] = This.of_GetVariableQuantity ( )

li_ExpressionCount ++
lsa_Expressions [ li_ExpressionCount ] = This.of_GetVariableRate ( )

lnv_String.of_ArrayToString ( lsa_Expressions, " ", ls_Check )


//Get a list of the possible columns that may be referenced.
//Replace this with a dynamically determined list of columns in the dataobject??

lsa_DefinedFields = { &
	"Itinerary_TotalMiles", &
	"Itinerary_LoadedMiles", &
	"Itinerary_EmptyMiles", &
	"Itinerary_DeadheadMiles", &
	"Itinerary_BobtailMiles" }

li_DefinedFieldCount = UpperBound ( lsa_DefinedFields )


//Look for the possible columns in the expressions, and list any that are referenced.

FOR li_Index = 1 TO li_ExpressionCount

	FOR li_DefinedFieldIndex = 1 TO li_DefinedFieldCount

		
*/

RETURN 1
end function

public function Boolean of_isfieldreferenced (string as_field);//@(*)[53362772|1327]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


Boolean	lb_Referenced = FALSE

String	lsa_Expressions[], &
			ls_Check
Integer	li_ExpressionCount
n_cst_String	lnv_String


//Get a list of the expressions that may contain column references.

li_ExpressionCount ++
lsa_Expressions [ li_ExpressionCount ] = This.of_GetQuantity ( )

li_ExpressionCount ++
lsa_Expressions [ li_ExpressionCount ] = This.of_GetRate ( )


//Concatenate the expressions to a check string.
lnv_String.of_ArrayToString ( lsa_Expressions, " ", ls_Check )


//Look for as_Field in the check string.

IF Pos ( Lower ( ls_Check ), Lower ( as_Field ) ) > 0 THEN
	lb_Referenced = TRUE
END IF

RETURN lb_Referenced
end function

public function String of_GetGenerationcondition ();//@(*)[71873347|1347:generationcondition:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("generationcondition")
//@(text)--

end function

public function Integer of_SetGenerationcondition (String as_generationcondition);//@(*)[71873347|1347:generationcondition:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "generationcondition" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


//Validate the Expression Value

CHOOSE CASE This.of_ValidateExpression ( "Numeric", as_GenerationCondition )

CASE 1  //Valid
	//Accept Value

CASE 0  //Empty or Null Expression
	//Accept Value

CASE ELSE  //-1 Invalid expression or error
	li_rc = -1

END CHOOSE


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("generationcondition", as_generationcondition) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Boolean of_GetGenerateifzero ();//@(*)[71900634|1348:generateifzero:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("generateifzero")
//@(text)--

end function

public function Integer of_SetGenerateifzero (Boolean ab_generateifzero);//@(*)[71900634|1348:generateifzero:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "generateifzero" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("generateifzero", ab_generateifzero) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetQuantity ();//@(*)[24346430|1295:quantity:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("quantity")
//@(text)--

end function

public function Integer of_SetQuantity (String as_quantity);//@(*)[24346430|1295:quantity:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "quantity" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


//Validate the Expression Value

CHOOSE CASE This.of_ValidateExpression ( "Numeric", as_Quantity )

CASE 1  //Valid
	//Accept Value

CASE 0  //Empty or Null Expression
	//Accept Value

CASE ELSE  //-1 Invalid expression or error
	li_rc = -1

END CHOOSE


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("quantity", as_quantity) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRate ();//@(*)[24574329|1296:rate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("rate")
//@(text)--

end function

public function Integer of_SetRate (String as_rate);//@(*)[24574329|1296:rate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "rate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


//Validate the Expression Value

CHOOSE CASE This.of_ValidateExpression ( "Numeric", as_Rate )

CASE 1  //Valid
	//Accept Value

CASE 0  //Empty or Null Expression
	//Accept Value

CASE ELSE  //-1 Invalid expression or error
	li_rc = -1

END CHOOSE


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("rate", as_rate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetAmount ();//@(*)[71443642|1346:amount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("amount")
//@(text)--

end function

public function Integer of_SetAmount (String as_amount);//@(*)[71443642|1346:amount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "amount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


//Validate the Expression Value

CHOOSE CASE This.of_ValidateExpression ( "Numeric", as_Amount )

CASE 1  //Valid
	//Accept Value

CASE 0  //Empty or Null Expression
	//Accept Value

CASE ELSE  //-1 Invalid expression or error
	li_rc = -1

END CHOOSE


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("amount", as_amount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_bcm of_GetJoin_entity_amounttemplate (String as_query);//@(*)[57511999|1459:j]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_join_entity_amounttemplate = GetRelationship( inv_join_entity_amounttemplate, "n_cst_dlkc_join_entity_amounttemplate", "join_entity_amounttemplate", "amounttemplate", as_query )
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

public function n_cst_bcm of_GetEntity (String as_query);//@(*)[57511999|1459]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_entity = GetRelationship( inv_entity, "n_cst_dlkc_entity", "entity", "amounttemplate", as_query )
inv_entity.AddClass("n_cst_beo_entity")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_entity
//@(text)--

end function

public function n_cst_bcm of_GetEntity ();//@(*)[57511999|1459:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetEntity(ls_dlkname)
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

public function Integer of_GetRatetypeid ();//@(*)[201781389|541:ratetypeid:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ratetypeid")
//@(text)--

end function

public function Integer of_SetRatetypeid (Integer ai_ratetypeid);//@(*)[201781389|541:ratetypeid:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ratetypeid" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ratetypeid", ai_ratetypeid) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_GetRatetype ();//@(*)[72630206|1461:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetRatetype(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetRatetype (String as_query);//@(*)[72630206|1461]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_ratetype = GetRelationship( inv_ratetype, "n_cst_dlkc_ratetype",  "ratetype", "amounttemplate", as_query, "n_cst_beo_ratetype" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_ratetype
//@(text)--

end function

public function Integer of_SetRatetype (n_cst_beo anv_ratetype);//@(*)[72630206|1461:so]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_ratetype,"ratetype") = 1 then
inv_ratetype = anv_ratetype
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function n_cst_beo of_GetAmounttype ();//@(*)[72433200|1460:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetAmounttype(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetAmounttype (String as_query);//@(*)[72433200|1460]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_amounttype = GetRelationship( inv_amounttype, "n_cst_dlkc_amounttype",  "amounttype", "amounttemplate", as_query, "n_cst_beo_amounttype" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_amounttype
//@(text)--

end function

public function Integer of_SetAmounttype (n_cst_beo anv_amounttype);//@(*)[72433200|1460:so]<nosync>//@(-)Do not edit, move or copy this line//
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

protected function Integer of_validateexpression (string as_type, string as_expression);//@(*)[21534928|1533]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns: 1 = Valid, 0 = Empty or Null Expression, -1 = Invalid or Error

DataStore	lds_Data
n_cst_OFRError	lnv_Error
String		ls_Field, &
				ls_ColType, &
				ls_Message = "Could not process request."

Integer	li_Return = 1


IF li_Return = 1 THEN

	CHOOSE CASE Upper ( as_Type )
	
	CASE "NUMERIC"
		ls_Field = "cf_Numeric"
		ls_ColType = "number"
	
	CASE ELSE  //Unexpected Value
		ls_Message = "Could not process request.  (Invalid type requested.)"
		li_Return = -1
	
	END CHOOSE

END IF
	

IF li_Return = 1 THEN

	IF Len ( as_Expression ) > 0 THEN
	
		lds_Data = CREATE DataStore
		lds_Data.DataObject = "d_ItineraryData"
		
		IF lds_Data.Modify ( ls_Field + ".Expression = '" + as_Expression + "'" ) = "" THEN
			//Expression is Valid.  Check whether it's the right type.

			IF Lower ( lds_Data.Describe ( ls_Field + ".ColType" ) ) = Lower ( ls_ColType ) THEN
				//Expression is the type expected.
			ELSE
				ls_Message = "The expression you have entered does not evaluate to a " + ls_ColType + "."
				li_Return = -1
			END IF

		ELSE
			ls_Message = "The expression you have entered is invalid."
			li_Return = -1
		END IF
		
		DESTROY lds_Data
		
	END IF

END IF


IF li_Return = -1 THEN

	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage( ls_Message )
	lnv_Error.SetMessageHeader ( "Edit Expression" )

END IF

RETURN li_Return
end function

public function boolean of_getaggregatecalc ();//Attribute was added manually.
return GetValue("aggregatecalc")
end function

public function string of_getsplitsby ();//Attribute was added manually.
return GetValue("splitsby")
end function

public function integer of_setaggregatecalc (boolean ab_aggregatecalc);integer li_rc = 1

// Validation logic for "aggregatecalc" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

String	ls_Null

IF li_rc > 0 THEN

	IF ab_AggregateCalc = FALSE THEN

		SetNull ( ls_Null )

		IF This.of_SetSplitsBy ( ls_Null ) = 1 THEN
			li_rc = 2
		ELSE
			li_rc = -1
		END IF

	END IF

END IF

if li_rc > 0 then
   if SetValue("aggregatecalc", ab_aggregatecalc) < 1 then
      li_rc = -1
   end if
end if

return li_rc


end function

public function integer of_setsplitsby (string as_splitsby);integer li_rc = 1

// Validation logic for "splitsby" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.


if li_rc > 0 then
   if SetValue("splitsby", as_splitsby) < 1 then
      li_rc = -1
   end if
end if

return li_rc


end function

public function integer of_gettype ();//Attribute was added manually.
RETURN This.GetValue("type")
end function

public function string of_getselectionfilter ();//Attribute was added manually.
RETURN This.GetValue("selectionfilter")
end function

public function integer of_settype (integer ai_type);integer li_rc = 1

// Validation logic for "type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.


if li_rc > 0 then
   if SetValue("type", ai_type) < 1 then
      li_rc = -1
   end if
end if

return li_rc


end function

public function integer of_setselectionfilter (string as_selectionfilter);integer li_rc = 1

// Validation logic for "selectionfilter" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.


if li_rc > 0 then
   if SetValue("selectionfilter", as_selectionfilter) < 1 then
      li_rc = -1
   end if
end if

return li_rc


end function

public function string of_getcustom1 ();// rdt 08-14-02
return GetValue("custom1")
end function

public function string of_getcustom2 ();// rdt 08-14-02
return GetValue("custom2")
end function

public function string of_getcustom3 ();// rdt 08-14-02
return GetValue("custom3")
end function

public function integer of_setcustom1 (string as_custom);//rdt 08-14-02

integer li_ReturnCode = 1
// validate here if needed and set li_ReturnCode 

// If li_ReturnCode = 1 then 
If SetValue("custom1", as_custom) < 1 then
   li_ReturnCode = -1
End if
// End If

return li_ReturnCode

end function

public function integer of_setcustom2 (string as_Custom);//rdt 08-14-02

integer li_ReturnCode = 1
// validate here if needed and set li_ReturnCode 

// If li_ReturnCode = 1 then 
If SetValue("custom2", as_custom) < 1 then
   li_ReturnCode = -1
End if
// End If

return li_ReturnCode

end function

public function integer of_setcustom3 (string as_custom);//rdt 08-14-02

integer li_ReturnCode = 1
// validate here if needed and set li_ReturnCode 

// If li_ReturnCode = 1 then 
If SetValue("custom3", as_Custom) < 1 then
   li_ReturnCode = -1
End if
// End If

return li_ReturnCode

end function

public function integer of_getintervaltype ();// jma 9.05.02
return GetValue("intervaltype")
end function

public function string of_getinterval ();// jma 9.05.02
return GetValue("interval")
end function

public function date of_getactivationdate ();// jma 9.05.02
return GetValue("activationdate")
end function

public function decimal of_gettargettotal ();// jma 9.05.02
return GetValue("targettotal")
end function

public function decimal of_getrunningtotal ();// jma 9.05.02
return GetValue("runningtotal")
end function

public function decimal of_getlastamount ();// jma 9.05.02
return GetValue("lastamount")
end function

public function date of_getlastdate ();// jma 9.05.02
return GetValue("lastdate")
end function

public function date of_getfirstdate ();// jma 9.05.02
return GetValue("firstdate")
end function

public function integer of_setintervaltype (integer ai_intervaltype);//jma  09.05.02

integer li_rc = 1
// validate "intervaltype" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("intervaltype", ai_intervaltype) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_setinterval (string as_interval);//jma  09.05.02

integer li_rc = 1
// validate "interval" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("interval", as_interval) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_settargettotal (decimal ac_targettotal);//jma  09.05.02

integer li_rc = 1
// validate "targettotal" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("targettotal", ac_targettotal) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_setrunningtotal (decimal ac_runningtotal);//jma  09.05.02

integer li_rc = 1
// validate "runningtotal" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("runningtotal", ac_runningtotal) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_setlastamount (decimal ac_lastamount);//jma  09.05.02

integer li_rc = 1
// validate "lastamount" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("lastamount", ac_lastamount) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_setlastdate (date ad_lastdate);//jma  09.05.02

integer li_rc = 1
// validate "lastdate" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("lastdate", ad_lastdate) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_setfirstdate (date ad_firstdate);//jma  09.05.02

integer li_rc = 1
// validate "firstdate" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("firstdate", ad_firstdate) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_setactivationdate (date ad_activationdate);//jma  09.05.02

integer li_rc = 1
// validate "activationdate" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("activationdate", ad_activationdate) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function long of_getfkentity ();// jma 9.05.02
return GetValue("fkentity")
end function

public function long of_getrunningcount ();// jma 9.05.02
return GetValue("runningcount")
end function

public function integer of_setfkentity (long ai_fkentity);//jma  09.05.02

integer li_rc = 1
// validate "fkentity" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("fkentity", ai_fkentity) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

public function integer of_setrunningcount (long ai_runningcount);//jma  09.05.02

integer li_rc = 1
// validate "runningcount" here if needed and set li_rc.  
// -1 if validation fails
// 2 if other attributes have been modified

If li_rc >0  then 
  If SetValue("runningcount", ai_runningcount) < 1 then
   li_rc = -1
  End if
End if  


return li_rc

end function

on n_cst_beo_amounttemplate.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_amounttemplate.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
this.SetRequired("category")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

event ofr_postnew;call super::ofr_postnew;//Extending ancestor script.  Perform initialization and set any defaults.
//Return : 1, -1

Long	ll_NextId
Integer	li_Return

IF AncestorReturnValue = 1 THEN

	//Determine and set a value for Id

	li_Return = -1
	Constant Boolean	cb_Commit = TRUE
	
	IF gnv_App.of_GetNextId ( This.ClassName ( ), ll_NextId, cb_Commit ) = 1 THEN
	
		IF This.of_SetId ( ll_NextId ) < 1 THEN
			//Fail
		ELSE
			//Success
			li_Return = 1
		END IF
	
	END IF


	//Set default value for Open

	IF li_Return = 1 THEN

		IF This.of_SetCategory ( n_cst_Constants.ci_Category_Payables ) < 1 THEN
			//Fail
			li_Return = -1
		END IF

	END IF


	//Set default value for AggregateCalc

	IF li_Return = 1 THEN

		IF This.of_SetAggregateCalc ( TRUE ) < 1 THEN
			//Fail
			li_Return = -1
		END IF

	END IF


//	//Set default value for Status
//
//	IF li_Return = 1 THEN
//
//		IF This.of_SetStatus ( ci_Status_Open ) < 1 THEN
//			//Fail
//			li_Return = -1
//		END IF
//
//	END IF

ELSE
	li_Return = AncestorReturnValue

END IF

RETURN li_Return
end event

