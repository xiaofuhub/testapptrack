$PBExportHeader$n_cst_beo_imagetype.sru
$PBExportComments$ImageType (Persistent Class from PBL map PTData) //@(*)[10376478|987]
forward
global type n_cst_beo_imagetype from n_cst_beo
end type
end forward

global type n_cst_beo_imagetype from n_cst_beo
end type
global n_cst_beo_imagetype n_cst_beo_imagetype

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_bcm inv_image //@(*)[50095669|1343:image]<nosync>
//@(text)--



//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.
public:		

CONSTANT String    cs_ImageTopic_Shipment = "SHIPMENT"
CONSTANT String    cs_ImageTopic_Employee= "EMPLOYEE"
CONSTANT String    cs_ImageType_POD = "POD"



CONSTANT String   cs_ImageType_ValueList  = "POD~tPOD/"
CONSTANT String   cs_ImageTopic_ValueList = "SHIPMENT~tSHIPMENT/"

end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function String of_GetTopic ()
public function Integer of_SetTopic (String as_topic)
public function String of_GetCategory ()
public function Integer of_SetCategory (String as_category)
public function String of_GetType ()
public function Integer of_SetType (String as_type)
public function n_cst_bcm of_GetImage (String as_query)
public function n_cst_bcm of_GetImage ()
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_imagetype")
inv_bcm.RegisterAttribute("topic", "string(32767)") //@(*)[10383519|988]
inv_bcm.SetKey("topic")
inv_bcm.RegisterAttribute("category", "string(32767)") //@(*)[10633532|989]
inv_bcm.SetKey("category")
inv_bcm.RegisterAttribute("type", "string(32767)") //@(*)[10654161|990]
inv_bcm.SetKey("type")
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("topic", "ImageType", "Topic")
   inv_bcm.MapDBColumn("category", "ImageType", "Category")
   inv_bcm.MapDBColumn("type", "ImageType", "Type")
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
 case "topic" 
   return of_SetTopic(String(aa_value))
 case "category" 
   return of_SetCategory(String(aa_value))
 case "type" 
   return of_SetType(String(aa_value))
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
 case "topic" 
   aa_value = of_GetTopic()
   li_rc = 1
 case "category" 
   aa_value = of_GetCategory()
   li_rc = 1
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function String of_GetTopic ();//@(*)[10383519|988:topic:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("topic")
//@(text)--

end function

public function Integer of_SetTopic (String as_topic);//@(*)[10383519|988:topic:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "topic" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("topic", as_topic) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetCategory ();//@(*)[10633532|989:category:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("category")
//@(text)--

end function

public function Integer of_SetCategory (String as_category);//@(*)[10633532|989:category:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "category" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("category", as_category) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetType ();//@(*)[10654161|990:type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("type")
//@(text)--

end function

public function Integer of_SetType (String as_type);//@(*)[10654161|990:type:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function n_cst_bcm of_GetImage (String as_query);//@(*)[50095669|1343]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_image = GetRelationship( inv_image, "n_cst_dlkc_image", "image", "imagetype", as_query )
inv_image.AddClass("n_cst_beo_image")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_image
//@(text)--

end function

public function n_cst_bcm of_GetImage ();//@(*)[50095669|1343:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetImage(ls_dlkname)
//@(text)--

end function

on n_cst_beo_imagetype.create
TriggerEvent(this, "constructor")
end on

on n_cst_beo_imagetype.destroy
TriggerEvent(this, "destructor")
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("topic")
this.SetRequired("category")
this.SetRequired("type")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

