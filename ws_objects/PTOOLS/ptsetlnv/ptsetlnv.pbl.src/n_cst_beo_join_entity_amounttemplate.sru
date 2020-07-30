$PBExportHeader$n_cst_beo_join_entity_amounttemplate.sru
$PBExportComments$Join_Entity_AmountTemplate (Business Object for join table from PBL map PTSetl) //@(*)[57511999|1459]<nosync>
forward
global type n_cst_beo_join_entity_amounttemplate from n_cst_beo
end type
end forward

global type n_cst_beo_join_entity_amounttemplate from n_cst_beo
end type
global n_cst_beo_join_entity_amounttemplate n_cst_beo_join_entity_amounttemplate

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function Long of_GetFkentity ()
public function Integer of_SetFkentity (Long al_fkentity)
public function Long of_GetFkamounttemplate ()
public function Integer of_SetFkamounttemplate (Long al_fkamounttemplate)
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_join_entity_amounttemplate")
inv_bcm.RegisterRelationshipAttribute("fkentity", "long", "n_cst_beo_entity", "id", "entity")
inv_bcm.SetKey("fkentity")
inv_bcm.RegisterRelationshipAttribute("fkamounttemplate", "long", "n_cst_beo_amounttemplate", "id", "amounttemplate")
inv_bcm.SetKey("fkamounttemplate")
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("fkentity", "Join_Entity_AmountTemplate", "fkEntity")
   inv_bcm.MapDBColumn("fkamounttemplate", "Join_Entity_AmountTemplate", "fkAmountTemplate")
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
 case "fkentity" 
   return of_SetFkentity(Long(aa_value))
 case "fkamounttemplate" 
   return of_SetFkamounttemplate(Long(aa_value))
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
 case "fkentity" 
   aa_value = of_GetFkentity()
   li_rc = 1
 case "fkamounttemplate" 
   aa_value = of_GetFkamounttemplate()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Long of_GetFkentity ();//@(*)[88631486|88:fkentity:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fkentity")
//@(text)--

end function

public function Integer of_SetFkentity (Long al_fkentity);//@(*)[88631486|88:fkentity:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fkentity" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fkentity", al_fkentity) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetFkamounttemplate ();//@(*)[23667583|1284:fkamounttemplate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fkamounttemplate")
//@(text)--

end function

public function Integer of_SetFkamounttemplate (Long al_fkamounttemplate);//@(*)[23667583|1284:fkamounttemplate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fkamounttemplate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fkamounttemplate", al_fkamounttemplate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

on n_cst_beo_join_entity_amounttemplate.create
TriggerEvent(this, "constructor")
end on

on n_cst_beo_join_entity_amounttemplate.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("fkentity")
this.SetRequired("fkamounttemplate")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

