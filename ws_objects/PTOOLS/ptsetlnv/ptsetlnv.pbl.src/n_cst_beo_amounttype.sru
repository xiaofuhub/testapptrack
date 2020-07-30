$PBExportHeader$n_cst_beo_amounttype.sru
$PBExportComments$THIS OBJECT SHOWS MESSAGEBOXS ON SETS BY DEFAULT. YOU CAN TURN IT OFF BY SETTING THE ACTION SORCE TO SYSTEM AmountType (Persistent Class from PBL map PTSetl) //@(*)[209019889|543]
forward
global type n_cst_beo_amounttype from n_cst_beo
end type
end forward

global type n_cst_beo_amounttype from n_cst_beo
end type
global n_cst_beo_amounttype n_cst_beo_amounttype

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_bcm inv_amounttemplate //@(*)[72433200|1460:amounttemplate]<nosync>
private n_cst_bcm inv_accountmap //@(*)[75673218|1608:accountmap]<nosync>
//@(text)--

Public Constant Integer	ci_TypicalAmount_Either = 0
Public Constant Integer	ci_TypicalAmount_Positive = 1
Public Constant Integer	ci_TypicalAmount_Negative = 2

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly string as_name, readonly any aa_value)
protected function integer getattribute (readonly string as_name, ref any aa_value)
public function Integer of_GetId ()
public function Integer of_SetId (Integer ai_id)
public function String of_GetName ()
public function integer of_setname (string as_name)
public function Integer of_GetCategory ()
public function Integer of_SetCategory (Integer ai_category)
public function Integer of_GetTypicalamount ()
public function Integer of_SetTypicalamount (Integer ai_typicalamount)
public function Boolean of_GetTaxabledefault ()
public function Integer of_SetTaxabledefault (Boolean ab_taxabledefault)
public function String of_GetTag ()
public function Integer of_SetTag (String as_tag)
public function string of_getaccount ()
public function n_cst_bcm of_GetAmounttemplate (String as_query)
public function n_cst_bcm of_GetAmounttemplate ()
public function n_cst_bcm of_GetAccountmap (String as_query)
public function n_cst_bcm of_GetAccountmap ()
protected function integer of_setsurcharge (string as_surcharge)
public function string of_getitemtype ()
public function integer of_setitemtype (string as_itemtype)
protected function integer of_setnotify (string as_value)
public function string of_getnotify ()
public function boolean of_isbillablefuelsurcharge ()
protected function string of_getsurcharge ()
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_amounttype")
inv_bcm.RegisterAttribute("id", "integer") //@(*)[209306953|546]
inv_bcm.SetKey("id")
inv_bcm.RegisterAttribute("name", "string(15)") //@(*)[209313781|547]
inv_bcm.RegisterAttribute("category", "integer") //@(*)[209378663|548]
inv_bcm.RegisterAttribute("typicalamount", "integer") //@(*)[210035677|549]
inv_bcm.RegisterAttribute("taxabledefault", "boolean") //@(*)[212363478|550]
inv_bcm.RegisterAttribute("tag", "string(32767)") //@(*)[39291671|730]
inv_bcm.RegisterAttribute("itemtype", "string(1)") //ADDED MANUALLY
inv_bcm.RegisterAttribute("surcharge", "string(1)") //ADDED MANUALLY
inv_bcm.RegisterAttribute("sendnotification", "string(1)") //ADDED MANUALLY
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "AmountType", "Id")
   inv_bcm.MapDBColumn("name", "AmountType", "Name")
   inv_bcm.MapDBColumn("category", "AmountType", "Category")
   inv_bcm.MapDBColumn("typicalamount", "AmountType", "TypicalAmount")
   inv_bcm.MapDBColumn("taxabledefault", "AmountType", "TaxableDefault")
   inv_bcm.MapDBColumn("tag", "AmountType", "Tag")
   inv_bcm.MapDBColumn("itemtype", "AmountType", "ItemType")
   inv_bcm.MapDBColumn("surcharge", "AmountType", "Surcharge")
   inv_bcm.MapDBColumn("sendnotification", "AmountType", "sendnotification")
end if 
//@(text)--


return 1
end function

protected function integer setattribute (readonly string as_name, readonly any aa_value);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=no)<Attribute Case>
int li_rc

li_rc = super::SetAttribute(as_name, aa_value)

if li_rc <> 0 then
    return li_rc
end if

choose case as_name
 case "id" 
   return of_SetId(Integer(aa_value))
 case "name" 
   return of_SetName(String(aa_value))
 case "category" 
   return of_SetCategory(Integer(aa_value))
 case "typicalamount" 
   return of_SetTypicalamount(Integer(aa_value))
 case "taxabledefault" 
   return of_SetTaxabledefault(Convert(aa_value, TypeBoolean!))
 case "tag" 
   return of_SetTag(String(aa_value))
// rdt 08-14-02
 case "itemtype" 
   return of_SetItemType(String(aa_value))
 case "surcharge" 
   return of_SetSurcharge(String(aa_value))
	
case "sendnotification" 
   return of_SetNotify(String(aa_value))

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
 case "name" 
   aa_value = of_GetName()
   li_rc = 1
 case "category" 
   aa_value = of_GetCategory()
   li_rc = 1
 case "typicalamount" 
   aa_value = of_GetTypicalamount()
   li_rc = 1
 case "taxabledefault" 
   aa_value = of_GetTaxabledefault()
   li_rc = 1
 case "tag" 
   aa_value = of_GetTag()
   li_rc = 1
 case "itemtype" 
   aa_value = of_GetItemType()
   li_rc = 1
 case "surcharge" 
   aa_value = of_GetSurcharge()
   li_rc = 1
case "sendnotification" 
   aa_value = of_GetNotify()
   li_rc = 1
	
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Integer of_GetId ();//@(*)[209306953|546:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_SetId (Integer ai_id);//@(*)[209306953|546:id:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetName ();//@(*)[209313781|547:name:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("name")
//@(text)--

end function

public function integer of_setname (string as_name);//@(*)[209313781|547:name:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "name" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--
n_cst_beo_AmountType 	lnv_AmountType
n_Cst_bcm					lnv_Bcm
lnv_Bcm = THIS.GetBcm ( ) 

IF isValid ( lnv_Bcm ) THEN
	lnv_AmountType = lnv_Bcm.GetBeo ( "amounttype_name = '" + as_name +"'" )
	IF isValid ( lnv_AmountType ) THEN
		IF lnv_AmountType.getBeoIndex () <> THIS.GetBeoIndex ( ) THEN
			li_rc = -1 // entry is a dupe
		END IF
		
	END IF
END IF




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

public function Integer of_GetCategory ();//@(*)[209378663|548:category:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("category")
//@(text)--

end function

public function Integer of_SetCategory (Integer ai_category);//@(*)[209378663|548:category:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetTypicalamount ();//@(*)[210035677|549:typicalamount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("typicalamount")
//@(text)--

end function

public function Integer of_SetTypicalamount (Integer ai_typicalamount);//@(*)[210035677|549:typicalamount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "typicalamount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("typicalamount", ai_typicalamount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Boolean of_GetTaxabledefault ();//@(*)[212363478|550:taxabledefault:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("taxabledefault")
//@(text)--

end function

public function Integer of_SetTaxabledefault (Boolean ab_taxabledefault);//@(*)[212363478|550:taxabledefault:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "taxabledefault" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("taxabledefault", ab_taxabledefault) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetTag ();//@(*)[39291671|730:tag:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("tag")
//@(text)--

end function

public function Integer of_SetTag (String as_tag);//@(*)[39291671|730:tag:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "tag" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("tag", as_tag) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function string of_getaccount ();RETURN ""
end function

public function n_cst_bcm of_GetAmounttemplate (String as_query);//@(*)[72433200|1460]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_amounttemplate = GetRelationship( inv_amounttemplate, "n_cst_dlkc_amounttemplate", "amounttemplate", "amounttype", as_query )
inv_amounttemplate.AddClass("n_cst_beo_amounttemplate")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_amounttemplate
//@(text)--

end function

public function n_cst_bcm of_GetAmounttemplate ();//@(*)[72433200|1460:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetAmounttemplate(ls_dlkname)
//@(text)--

end function

public function n_cst_bcm of_GetAccountmap (String as_query);//@(*)[75673218|1608]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_accountmap = GetRelationship( inv_accountmap, "n_cst_dlkc_accountmap", "accountmap", "amounttype", as_query )
inv_accountmap.AddClass("n_cst_beo_accountmap")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_accountmap
//@(text)--

end function

public function n_cst_bcm of_GetAccountmap ();//@(*)[75673218|1608:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetAccountmap(ls_dlkname)
//@(text)--

end function

protected function integer of_setsurcharge (string as_surcharge);/* 
	This set will look to see if this amount type is the amount type used for fuel surcharges and
	if so, it will see if the surcharge is being set to anything but NONE. if so the user will be warned
	that this setting doesn't make sense in normal situcations.

*/


// rdt 08-14-02
integer li_ReturnCode = 1
String	lsa_RateList[]
String	ls_Message
Long		ll_AmountType

n_cst_bso_Rating			lnv_Rating
n_cst_RateData				lnv_RateData
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("surcharge", as_Surcharge) < 1 then
      li_ReturnCode = -1
   end if
end if

IF THIS.GetActionSource ( ) = ci_ActionSource_User THEN
	
	lnv_Rating = CREATE n_cst_bso_Rating
	lnv_RateData = CREATE n_cst_RateData
	
	IF li_ReturnCode > 0 THEN
		IF lnv_Rating.of_GetCodeDefaultList ( 0 , appeon_constant.cl_FuelSurcharge_list , lsa_RateList ) > 0 THEN	
			lnv_RateData.of_SetCodeName ( lsa_RateList[1] )
			ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
			
			IF ll_AmountType = THIS.of_GetID ( ) THEN
				IF as_surcharge <> n_cst_Constants.cs_FuelSurcharge_None THEN
					ls_Message = "The change you made indicates that the surcharge line item will contribute to the calculation of the surcharge amount. Under normal circumstances this should be set to NONE."
					MessageBox ("Fuel Surcharge" , ls_Message )	
				END IF		
			END IF
			
		END IF
	END IF
END IF

DESTROY ( lnv_Rating )
DESTROY ( lnv_RateData )

return li_ReturnCode
end function

public function string of_getitemtype ();//rdt 08-14-02 
return GetValue("itemtype")
end function

public function integer of_setitemtype (string as_itemtype);// rdt 08-14-02
integer li_ReturnCode = 1
String	ls_OriginalItemTypeValue
String	ls_Message
String	ls_NewFscValue
String	ls_ExistingFscValue
String	lsa_RateList []
Long		ll_AmountType
n_Cst_RateData	lnv_RateData
n_Cst_bso_Rating	lnv_Rating
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

ls_OriginalItemTypeValue = THIS.of_GetItemType ()
ls_ExistingFscValue = THIS.of_GetSurcharge ( )

if li_ReturnCode > 0 then
   if SetValue("itemtype", as_itemtype) < 1 then
      li_ReturnCode = -1
   end if
end if

IF isNull ( ls_OriginalItemTypeValue ) THEN
	
	CHOOSE CASE as_itemtype
		CASE n_cst_constants.cs_itemtype_freight		
			choose case this.of_getcategory()
				case n_cst_constants.ci_category_payables
					ls_NewFscValue = n_cst_constants.cs_FuelSurcharge_Pay
				case n_cst_constants.ci_category_receivables
					ls_NewFscValue = n_cst_constants.cs_FuelSurcharge_Bill
				case n_cst_constants.ci_category_both
					ls_NewFscValue = n_cst_constants.cs_fuelsurcharge_both	
			end choose			
		CASE ELSE //n_cst_constants.cs_itemtype_accessorial
			ls_NewFscValue = n_cst_constants.cs_fuelsurcharge_None
			
	END CHOOSE
	
	lnv_Rating = CREATE n_cst_bso_Rating
	lnv_RateData = CREATE n_cst_RateData
	
	IF li_ReturnCode > 0 THEN
		IF lnv_Rating.of_GetCodeDefaultList ( 0 , appeon_constant.cl_FuelSurcharge_list , lsa_RateList ) > 0 THEN	
			lnv_RateData.of_SetCodeName ( lsa_RateList[1] )
			ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
			
			IF ll_AmountType = THIS.of_GetID ( ) THEN
				ls_NewFscValue = n_cst_constants.cs_fuelsurcharge_None	
			END IF
			
		END IF
	END IF
	
	IF isNull (ls_ExistingFscValue) THEN
		THIS.of_SetSurcharge ( ls_NewFscValue ) 
	END IF
	
ELSE
	
	IF THIS.GetActionSource ( ) = ci_ActionSource_User THEN
		IF li_ReturnCode > 0 THEN		
			
			CHOOSE CASE as_itemtype
				CASE n_cst_constants.cs_itemtype_freight	
					IF ls_ExistingFscValue <> n_cst_constants.cs_fuelsurcharge_both OR ls_ExistingFscValue <> n_cst_constants.cs_fuelsurcharge_Bill THEN
						ls_Message = "Please be sure to check your corresponding Fuel Surcharge Setting."
						MessageBox ("Item Type" , ls_Message )		
					END IF
			END CHOOSE
		END IF	
	END IF
END IF


DESTROY ( lnv_rating ) 
DESTROY ( lnv_rateData ) 
return li_ReturnCode
end function

protected function integer of_setnotify (string as_value);integer li_ReturnCode = 1
// Validation logic 
// Set li_ReturnCode to -1 if validation fails.
// Set li_ReturnCode to 2 if other attributes have been modified.

if li_ReturnCode > 0 then
   if SetValue("sendnotification", as_Value) < 1 then
      li_ReturnCode = -1
   end if
end if

return li_ReturnCode
end function

public function string of_getnotify ();String	ls_Return 

ls_Return = THIS.GetValue ( "sendnotification" ) 
IF isNull ( ls_Return ) THEN
	ls_Return = 'F' 
END IF

RETURN ls_Return
end function

public function boolean of_isbillablefuelsurcharge ();Boolean	lb_Return

CHOOSE CASE THIS.of_GetSurcharge ( )
		
	CASE n_cst_constants.cs_fuelsurcharge_bill , n_cst_constants.cs_fuelsurcharge_both 
		lb_Return = TRUE 
		
	CASE ELSE 
		
END CHOOSE

RETURN lb_Return



end function

protected function string of_getsurcharge ();//rdt 08-14-02 
return GetValue("surcharge")
end function

on n_cst_beo_amounttype.create
TriggerEvent( this, "constructor" )
end on

on n_cst_beo_amounttype.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
this.SetRequired("name")
this.SetRequired("category")
this.SetRequired("typicalamount")
this.SetRequired("taxabledefault")
// rdt 08-14-02
this.SetRequired("itemtype")

//@(data)--

//@(text)(recreate=no)<body>
THIS.SetActionSource ( THIS.ci_ActionSource_User )
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

	of_SetCategory ( n_cst_Constants.ci_Category_Payables )
	of_SetTypicalAmount ( ci_TypicalAmount_Either )
	of_SetTaxableDefault ( FALSE )
	THIS.of_SetNotify ( 'F' )

ELSE
	li_Return = AncestorReturnValue

END IF

RETURN li_Return
end event

event ue_describe;RETURN of_GetName ( )
end event

