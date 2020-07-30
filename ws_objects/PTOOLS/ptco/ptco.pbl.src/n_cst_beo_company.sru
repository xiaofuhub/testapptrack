$PBExportHeader$n_cst_beo_company.sru
forward
global type n_cst_beo_company from pt_n_cst_beo
end type
end forward

global type n_cst_beo_company from pt_n_cst_beo
end type
global n_cst_beo_company n_cst_beo_company

forward prototypes
public function integer of_setusecache (boolean ab_switch)
public function decimal of_gethiddendiscount ()
public function string of_getbillingname ()
public function string of_getaccountingid ()
public function string of_getbillsame ()
public function string of_getbillname ()
public function string of_getname ()
public function string of_getallowbilling ()
public function string of_getcity ()
public function string of_getstate ()
public function string of_getlocation ()
public function string of_getaddress1 ()
public function string of_getphone1 ()
public function string of_formatphone1 ()
public function string of_getlocationpostal ()
public function string of_getzip ()
public function string of_getusnon ()
public function string of_getcountry ()
public function string of_formatphone (string as_phone)
public function string of_getphone2 ()
public function string of_getfax ()
public function string of_formatphone2 ()
public function string of_formatfax ()
public function string of_getaddress2 ()
public function string of_getpcm ()
public function string of_getlocator ()
public function string of_getcodename ()
public function string of_getbillingaddress1 ()
public function string of_getbillingaddress2 ()
public function string of_getbillingcity ()
public function string of_getbillingzip ()
public function string of_getbillingphone1 ()
public function string of_getbillingphone2 ()
public function string of_getbillingfax ()
public function string of_getbillingusnon ()
public function string of_getbillingcountry ()
public function string of_getstatus ()
public function string of_getcomments ()
public function string of_getdirections ()
public function string of_getbillingattn ()
public function string of_getbillingattntext ()
public function integer of_gettimezone ()
public function long of_getid ()
public function integer of_usephysicalorbilling ()
public function string of_getbillstate ()
public function string of_getbillingstate ()
public function string of_getbillzip ()
public function string of_getbilladdress1 ()
public function string of_getbilladdress2 ()
public function string of_getbillcity ()
public function string of_getbillcountry ()
public function string of_getbillfax ()
public function string of_getbillphone1 ()
public function string of_getbillphone2 ()
public function string of_formatzip (string as_Zip)
public function string of_getbillattntext ()
public function string of_getbillattn ()
public function string of_getbilllocation ()
public function string of_getbilllocationpostal ()
public function string of_getbillinglocation ()
public function string of_getbillinglocationpostal ()
public function string of_getsalesrep ()
public function time of_getdefaultduration ()
public function string of_getdefaultfreightdescription ()
public function string of_getdispatchinstructions ()
public function integer of_createpcmlocator (ref string as_locator)
public function string of_getterminationlocation ()
public function boolean of_isterminationlocation ()
public function string of_getedi214code ()
public function string of_getedi210code ()
public function boolean of_hascustomfuelsurcharge ()
public function decimal of_getcustomfuelsurcharge ()
public function integer of_getrequiredimagetypes (ref string asa_types[])
public function integer of_getwarningimagetypes (ref string asa_types[])
public function boolean of_overriderequiredimagetypes ()
public function boolean of_overridewarningimagetypes ()
public function boolean of_overrideprintingimagetypes ()
public function integer of_getprintingimagetypes (ref string asa_types[])
public function long of_getfacilityof ()
public function string of_getrequiredrequestrole ()
public function integer of_setrequiredrequestrole (string as_role)
public function string of_getstatusrequesttemplate ()
public function integer of_getattachimagetypes (ref string asa_types[])
public function integer of_setaccnotetemplate (string as_Template)
public function string of_getaccnotetemplate ()
public function integer of_setaccauthtemplate (string as_Template)
public function integer of_seteventtemplate (string as_Template)
public function string of_getaccauthtemplate ()
public function string of_geteventtemplate ()
public function int of_setstatusrequesttemplate (String as_template)
public function integer of_setlastfreedatetemplate (string as_Template)
public function string of_getlastfreedatetemplate ()
public function string of_gettirtemplate ()
public function integer of_settirtemplate (string as_Template)
public function string of_getratetablelist ()
public function string of_getloadconfirmationtemplate ()
public function integer of_setloadconfirmationtemplate (string as_Template)
public function boolean of_isedi322site ()
public function boolean of_addfuelsurcharge ()
public function string of_getnotificationeventorigin ()
public function string of_getnotificationeventdestination ()
public function string of_getfuelsurchargetype ()
public function string of_getpaymentterms ()
public function integer of_setpatmentterms (string as_value)
public function string of_getalias ()
public function boolean of_emailinvoices ()
public function integer of_getemailinvoiceimagetypes (ref string asa_types[])
end prototypes

public function integer of_setusecache (boolean ab_switch);//NOTE: Currently, this does NOT operate in auto-cache mode.  If you do
//SetSourceId on a company that is not already cached, it will fail.
//This should be extended, but at present, it is up to the calling script
//to be sure that the company is cached.

Integer	li_Result

IF ab_Switch = TRUE THEN
	li_Result = of_SetSource ( gnv_cst_Companies.of_GetCache ( ) )
ELSEIF ab_Switch = FALSE THEN
	li_Result = of_ClearSource ( )
ELSE
	li_Result = -1
END IF

RETURN li_Result
end function

public function decimal of_gethiddendiscount ();RETURN of_GetValue ( "co_HiddenDiscount", TypeDecimal! )
end function

public function string of_getbillingname ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetName ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillName( )
		
END CHOOSE

RETURN ls_Return




end function

public function string of_getaccountingid ();RETURN of_GetValue ( "co_bill_acctcode", TypeString! )
end function

public function string of_getbillsame ();RETURN of_GetValue ( "co_bill_same", TypeString! )
end function

public function string of_getbillname ();RETURN of_GetValue ( "co_bill_name", TypeString! )
end function

public function string of_getname ();RETURN of_GetValue ( "co_name", TypeString! )
end function

public function string of_getallowbilling ();RETURN of_GetValue ( "co_allow_billing", TypeString! )
end function

public function string of_getcity ();RETURN This.of_GetValue ( "co_city", TypeString! )
end function

public function string of_getstate ();RETURN of_GetValue ( "co_state", TypeString! )
end function

public function string of_getlocation ();RETURN gnv_cst_Companies.of_Make_Location ( This.of_GetCity ( ), This.of_GetState ( ) )
end function

public function string of_getaddress1 ();RETURN This.of_GetValue ( "co_addr1", TypeString! )
end function

public function string of_getphone1 ();RETURN of_GetValue ( "co_phone1", TypeString! )
end function

public function string of_formatphone1 ();RETURN of_FormatPhone ( of_GetPhone1 ( ) )
end function

public function string of_getlocationpostal ();RETURN gnv_cst_Companies.of_Make_Location ( This.of_GetCity ( ), This.of_GetState ( ), &
	This.of_GetZip ( ), This.of_GetUsNon ( ), This.of_GetCountry ( ), "FULL!" )
end function

public function string of_getzip ();RETURN of_GetValue ( "co_zip", TypeString! )
end function

public function string of_getusnon ();RETURN of_GetValue ( "co_usnon", TypeString! )
end function

public function string of_getcountry ();RETURN of_GetValue ( "co_country", TypeString! )
end function

public function string of_formatphone (string as_phone);IF of_GetUsNon ( ) = "N" THEN
	RETURN as_Phone
ELSE
	RETURN gnv_cst_Companies.of_FormatPhone ( as_Phone, TRUE )
END IF
end function

public function string of_getphone2 ();RETURN of_GetValue ( "co_phone2", TypeString! )
end function

public function string of_getfax ();RETURN of_GetValue ( "co_fax", TypeString! )
end function

public function string of_formatphone2 ();RETURN of_FormatPhone ( of_GetPhone2 ( ) )
end function

public function string of_formatfax ();RETURN of_FormatPhone ( of_GetFax ( ) )
end function

public function string of_getaddress2 ();RETURN This.of_GetValue ( "co_addr2", TypeString! )
end function

public function string of_getpcm ();RETURN This.of_GetValue ( "co_pcm", TypeString! )
end function

public function string of_getlocator ();String	ls_Locator

ls_Locator = This.of_GetPcm ( )

RETURN ls_Locator
end function

public function string of_getcodename ();RETURN This.of_GetValue ( "co_code_name", TypeString! )
end function

public function string of_getbillingaddress1 ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetAddress1 ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillAddress1( )
				
END CHOOSE

RETURN ls_Return




end function

public function string of_getbillingaddress2 ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetAddress2 ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillAddress2( )
		
END CHOOSE

RETURN ls_Return




end function

public function string of_getbillingcity ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetCity ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillCity( )
		
END CHOOSE

RETURN ls_Return




end function

public function string of_getbillingzip ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetZip ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillZip ( )

END CHOOSE

RETURN ls_Return




end function

public function string of_getbillingphone1 ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetPhone1 ( ) 
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillPhone1( )

END CHOOSE

RETURN ls_Return




end function

public function string of_getbillingphone2 ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_FormatPhone ( THIS.of_GetPhone2 ( ) )
		
	CASE 2 // Billing
		ls_Return = THIS.of_FormatPhone ( THIS.of_GetBillPhone2 ( ) )
		
END CHOOSE

RETURN ls_Return




end function

public function string of_getbillingfax ();/*
	A return value of null indicates that billling is not allowed.
*/

String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetFax ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillFax( )
		
	CASE ELSE // Billing not allowed
		SetNull ( ls_Return )
		
END CHOOSE

RETURN ls_Return




end function

public function string of_getbillingusnon ();RETURN of_GetValue ( "co_bill_usnon", TypeString! )
end function

public function string of_getbillingcountry ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetCountry ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillCountry( )
		
END CHOOSE

RETURN ls_Return




end function

public function string of_getstatus ();RETURN of_GetValue ( "co_status", TypeString! )
end function

public function string of_getcomments ();RETURN of_GetValue ( "co_comments", TypeString! )
end function

public function string of_getdirections ();RETURN of_GetValue ( "co_directions", TypeString! )
end function

public function string of_getbillingattn ();String 	ls_BillAttn
String	ls_BillAttnText
String	ls_Work
String	ls_Attn

//" – "  // long dash

ls_BillAttn = THIS.of_GetBillAttn ( )
ls_BillAttnText = THIS.of_GetBillAttnText ( )

choose case ls_BillAttn
		
	case "N" //No attention line
		//No processing needed
		
	case "O" //Text only
		if len(ls_BillAttnText) > 0 then ls_work += "ATTN: " + ls_BillAttnText
		
	case "F" //'Accounts Payable' First
		ls_work += "ATTN: ACCOUNTS PAYABLE"
		if len(ls_BillAttnText) > 0 then ls_work += " - " + ls_BillAttnText
		
	case "L" //'Accounts Payable' Last
		ls_work += "ATTN: "
		if len(ls_BillAttnText) > 0 then ls_work += ls_BillAttnText + " - "
		ls_work += "ACCOUNTS PAYABLE"
		
end choose

ls_attn = ls_work

RETURN ls_Attn


end function

public function string of_getbillingattntext ();RETURN of_GetValue ( "co_bill_attn_text", TypeString! )
end function

public function integer of_gettimezone ();RETURN of_GetValue ( "co_tz", TypeInteger! )
end function

public function long of_getid ();RETURN This.of_GetValue ( "co_id", TypeLong! )
end function

public function integer of_usephysicalorbilling ();/*
//	Returns:
//			1 = Physical
//			2 = Billing
//		  -1 = ERROR  (DEFAULT)
//		 
///////////////
   March 31 2003 <<*>>
		Changed return codes from:
		Returns:
				1 = Physical
				2 = Billing
				0 = Billing Not Allowed. Don't Use Either
			  -1 = ERROR
			  
								   TO:
		Returns:
				1 = Physical
				2 = Billing
			  -1 = ERROR			
		This method no longer returns 0 for companies that are not authorized for billing. There is a
		separate method to determine that. 
		  
*/

Int	li_Return = -1

IF of_GetBillSame ( ) = "F"  THEN
	li_Return = 2 // use billing
ELSE
	li_Return = 1 // same, so use physical
END IF


RETURN li_Return
end function

public function string of_getbillstate ();RETURN This.of_GetValue ( "co_bill_state", TypeString! )
end function

public function string of_getbillingstate ();String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetState ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillState ( )
		
END CHOOSE

RETURN ls_Return
end function

public function string of_getbillzip ();RETURN of_GetValue ( "co_bill_zip", TypeString! )
end function

public function string of_getbilladdress1 ();RETURN This.of_GetValue ( "co_bill_addr1", TypeString! )
end function

public function string of_getbilladdress2 ();RETURN This.of_GetValue ( "co_bill_addr2", TypeString! )
end function

public function string of_getbillcity ();RETURN This.of_GetValue ( "co_bill_city", TypeString! )
end function

public function string of_getbillcountry ();RETURN of_GetValue ( "co_bill_country", TypeString! )
end function

public function string of_getbillfax ();RETURN of_GetValue ( "co_bill_fax", TypeString! )
end function

public function string of_getbillphone1 ();RETURN of_GetValue ( "co_bill_phone1", TypeString! )
end function

public function string of_getbillphone2 ();RETURN of_GetValue ( "co_bill_phone2", TypeString! )
end function

public function string of_formatzip (string as_Zip);RETURN gnv_cst_Companies.of_FormatZip ( as_Zip )
end function

public function string of_getbillattntext ();RETURN of_GetValue ( "co_bill_attn_text", TypeString! )
end function

public function string of_getbillattn ();RETURN of_GetValue ( "co_bill_attn", TypeString! )
end function

public function string of_getbilllocation ();RETURN gnv_cst_Companies.of_Make_Location ( This.of_GetBillCity ( ), This.of_GetbillState ( ) )
end function

public function string of_getbilllocationpostal ();RETURN gnv_cst_Companies.of_Make_Location ( This.of_GetbillCity ( ), This.of_GetbillState ( ), &
	This.of_GetbillZip ( ), This.of_GetUsNon ( ), This.of_GetbillCountry ( ), "FULL!" )
end function

public function string of_getbillinglocation ();
String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetLocation ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillLocation( )

END CHOOSE

RETURN ls_Return





end function

public function string of_getbillinglocationpostal ();
String	ls_Return

CHOOSE CASE THIS.of_UsePhysicalOrBilling ( )
		
	CASE 1 // physical 
		ls_Return = THIS.of_GetLocationPostal ( )
		
	CASE 2 // Billing
		ls_Return = THIS.of_GetBillLocationPostal( )
		
END CHOOSE

RETURN ls_Return





end function

public function string of_getsalesrep ();RETURN This.of_GetValue ( "SalesRep", TypeString! )
end function

public function time of_getdefaultduration ();RETURN This.of_GetValue ( "DefaultDuration", TypeTime! )
end function

public function string of_getdefaultfreightdescription ();RETURN This.of_GetValue ( "DefaultFreightDescription", TypeString! )
end function

public function string of_getdispatchinstructions ();RETURN This.of_GetValue ( "DispatchInstructions", TypeString! )
end function

public function integer of_createpcmlocator (ref string as_locator);//not used 

//String	ls_Locator
Int		li_ReturnValue= -1
//n_cst_Bso_PCMiler	lnv_PCM
//
//ls_Locator = lnv_Pcm.of_CreateLocator ( THIS )
//IF isNull ( ls_Locator ) THEN
//	li_ReturnValue = -1
//ELSE
//	li_ReturnValue = 1
//	as_locator = ls_Locator
//END IF
//
RETURN li_ReturnValue
//



end function

public function string of_getterminationlocation ();RETURN This.of_GetValue ( "terminationlocation", TypeString! )
end function

public function boolean of_isterminationlocation ();//Returns : TRUE, FALSE, Null if cannot be determined.

Boolean	lb_Return

CHOOSE CASE This.of_GetTerminationLocation ( )

CASE "T"
	lb_Return = TRUE

CASE "F"
	lb_Return = FALSE

CASE ELSE
	SetNull ( lb_Return )

END CHOOSE

RETURN lb_Return
end function

public function string of_getedi214code ();RETURN of_GetValue ( "edi214code", TypeString! )
end function

public function string of_getedi210code ();RETURN of_GetValue ( "edi210code", TypeString! )
end function

public function boolean of_hascustomfuelsurcharge ();RETURN NOT isNull ( THIS.of_GetCustomFuelSurcharge ( ) )


 
end function

public function decimal of_getcustomfuelsurcharge ();RETURN of_GetValue ( "fuelsurcharge", TypeDecimal! )
end function

public function integer of_getrequiredimagetypes (ref string asa_types[]);String	lsa_Return[]
String	ls_Types

n_cst_String	lnv_String
ls_Types = of_GetValue ( "requiredimagetypes", Typestring! )

lnv_String.of_ParseToArray ( ls_Types , ";" , lsa_Return  )
asa_types[] = lsa_Return
	

RETURN UpperBound ( asa_Types )
end function

public function integer of_getwarningimagetypes (ref string asa_types[]);String	lsa_Return[]
String	ls_Types

n_cst_String	lnv_String
ls_Types = of_GetValue ( "warningimagetypes", Typestring! )

lnv_String.of_ParseToArray ( ls_Types , ";" , lsa_Return  )
asa_types[] = lsa_Return
	

RETURN UpperBound ( asa_Types )
end function

public function boolean of_overriderequiredimagetypes ();// if the value is null then, the settings are not everridden, if there is any thing, 
// even an empty string then the settings are overridden
Boolean	lb_Return
String	ls_Value

ls_Value = THIS.of_GetValue ( "requiredimagetypes" , typeString! )

IF isNull ( ls_Value ) THEN
	lb_Return = FALSE
ELSE
	lb_Return = TRUE
END IF
	

RETURN lb_Return
end function

public function boolean of_overridewarningimagetypes ();// if the value is null then, the settings are not everridden, if there is any thing, 
// even an empty string then the settings are overridden
Boolean	lb_Return
String	ls_Value

ls_Value = THIS.of_GetValue ( "warningimagetypes" , typeString! )

IF isNull ( ls_Value ) THEN
	lb_Return = FALSE
ELSE
	lb_Return = TRUE
END IF
	

RETURN lb_Return
end function

public function boolean of_overrideprintingimagetypes ();// if the value is null then, the settings are not everridden, if there is any thing, 
// even an empty string then the settings are overridden

Boolean	lb_Return
String	ls_Value

ls_Value = THIS.of_GetValue ( "printingimagetypes" , typeString! )

IF isNull ( ls_Value ) THEN
	lb_Return = FALSE
ELSE
	lb_Return = TRUE
END IF
	

RETURN lb_Return
end function

public function integer of_getprintingimagetypes (ref string asa_types[]);String	lsa_Return[]
String	ls_Types

n_cst_String	lnv_String
ls_Types = of_GetValue ( "printingimagetypes", Typestring! )

lnv_String.of_ParseToArray ( ls_Types , ";" , lsa_Return  )
asa_types[] = lsa_Return
	

RETURN UpperBound ( asa_Types )
end function

public function long of_getfacilityof ();RETURN of_GetValue ( "co_facility_of", TypeLong! )
end function

public function string of_getrequiredrequestrole ();RETURN This.of_GetValue ( "statusrequestrole", TypeString! )

end function

public function integer of_setrequiredrequestrole (string as_role);Int	li_Return

CHOOSE CASE as_Role
		
	CASE n_cst_Constants.cs_RequestRole_None, &
		  n_cst_Constants.cs_RequestRole_Billto, &
		  n_cst_Constants.cs_RequestRole_Any
		  
		li_Return = this.of_SetAny ( "statusrequestrole" , as_role )		  
		
	CASE ELSE
		li_Return = -1
END CHOOSE


RETURN li_Return
end function

public function string of_getstatusrequesttemplate ();String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "statusrequesttemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 110 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function integer of_getattachimagetypes (ref string asa_types[]);String	lsa_Return[]
String	ls_Types

n_cst_String	lnv_String
ls_Types = of_GetValue ( "attachimagetypes", Typestring! )

lnv_String.of_ParseToArray ( ls_Types , ";" , lsa_Return  )
asa_types[] = lsa_Return
	

RETURN UpperBound ( asa_Types )
end function

public function integer of_setaccnotetemplate (string as_Template);RETURN this.of_SetAny ( "accnotetemplate" , as_template )
end function

public function string of_getaccnotetemplate ();//RETURN of_GetValue ( "accnotetemplate", TypeString! )



String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "accnotetemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 117 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function integer of_setaccauthtemplate (string as_Template);RETURN this.of_SetAny ( "accauthtemplate" , as_template )
end function

public function integer of_seteventtemplate (string as_Template);RETURN this.of_SetAny ( "eventtemplate" , as_template )
end function

public function string of_getaccauthtemplate ();//RETURN of_GetValue ( "accauthtemplate", TypeString! )


String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "accauthtemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 118 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function string of_geteventtemplate ();//RETURN of_GetValue ( "eventtemplate", TypeString! )

String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "eventtemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 111 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function int of_setstatusrequesttemplate (String as_template);RETURN This.of_Setany ( "statusrequesttemplate", as_template )
end function

public function integer of_setlastfreedatetemplate (string as_Template);RETURN this.of_SetAny ( "lfdtemplate" , as_template )
end function

public function string of_getlastfreedatetemplate ();//RETURN of_GetValue ( "eventtemplate", TypeString! )

String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "lfdtemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 120 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function string of_gettirtemplate ();//RETURN of_GetValue ( "eventtemplate", TypeString! )

String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "tirtemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 119 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function integer of_settirtemplate (string as_Template);RETURN this.of_SetAny ( "tirtemplate" , as_template )
end function

public function string of_getratetablelist ();RETURN This.of_GetValue ( "RatetableList", TypeString! )
end function

public function string of_getloadconfirmationtemplate ();String	ls_Template
Any		la_Value
n_cst_Settings	lnv_Setting

ls_Template = This.of_GetValue ( "loadconfirmationtemplate", TypeString! )

IF Len ( ls_Template ) > 0 THEN
	
ELSE
	IF lnv_Setting.of_GetSetting ( 137 , la_Value ) = 1 THEN
		ls_Template = String ( la_Value )
	END IF
END IF

RETURN ls_Template
end function

public function integer of_setloadconfirmationtemplate (string as_Template);RETURN this.of_SetAny ( "loadconfirmationtemplate" , as_template )
end function

public function boolean of_isedi322site ();//Should events that occur at this site be considered candidates for EDI322 notification?
//Is this site a terminal, ramp, etc for which the company issues 322 notifications?

//Returns : TRUE, FALSE, Null (cannot be determined)   (Null is currently not implemented)

//For each site that you want to trigger 322 messages, an entry should be made, as follows:
//[EDI322Sites]
//1234=Whatever		(1234 is the sysid of company Whatever -- the exact text is not important)

Long		ll_Id

Boolean	lb_Return = FALSE

ll_Id = This.of_GetId ( )

IF Len ( ProfileString ( gnv_App.of_GetAppIniFile ( ), "EDI322Sites", String ( ll_Id ), "" ) ) > 0 THEN

	lb_Return = TRUE

END IF

RETURN lb_Return
end function

public function boolean of_addfuelsurcharge ();Boolean	lb_Return = TRUE
IF THIS.of_getCustomFuelSurcharge ( ) = 0 THEN
	lb_Return = FALSE
END IF

RETURN lb_Return


end function

public function string of_getnotificationeventorigin ();RETURN of_GetValue ( "notificationeventorigin", TypeString! )
end function

public function string of_getnotificationeventdestination ();RETURN of_GetValue ( "notificationeventdestination", TypeString! )
end function

public function string of_getfuelsurchargetype ();String	ls_Type

ls_Type = of_GetValue ( "fuelsurchargetype", TypeString! )

IF IsNull ( ls_Type ) THEN
	ls_Type = 'PERCENTAGE'
END IF

RETURN ls_Type
end function

public function string of_getpaymentterms ();RETURN of_GetValue ( "paymentterms", TypeString! )
end function

public function integer of_setpatmentterms (string as_value);RETURN this.of_SetAny ( "paymentterms" , as_value )
end function

public function string of_getalias ();String	ls_Return
Long		ll_ContextID
Long		ll_ThisID
Long		ll_Return
Long		ll_PtCoID
Long		ll_Context
String	ls_ContextCompanyID

ll_ContextID = THIS.of_getcontextcompanyid( )
IF ll_ContextID > 0 THEN

	ll_ThisID = THIS.of_GetID ( )
	
	  SELECT "companyalias"."contextcompanyid"  
    INTO :ls_Return  
    FROM "companyalias"  
   WHERE ( "companyalias"."context" = :ll_ContextID ) AND  
         ( "companyalias"."ptcoid" = :ll_ThisID ) ;

 			
	IF SQLCA.Sqlcode = 0 THEN
		Commit;
	ELSE
		ROLLBACK;
	END IF	
END IF

RETURN ls_Return
end function

public function boolean of_emailinvoices ();Boolean	lb_Email
String 	ls_Setting
Long		ll_CoId

ll_CoId = This.of_GetSourceId( )

Select EmailInvoice
Into :ls_Setting
From companies
Where co_id = :ll_CoId;

COMMIT;

IF ls_Setting = "T" THEN
	lb_Email = TRUE 
ELSE
	lb_Email = FALSE
END IF

Return lb_Email
end function

public function integer of_getemailinvoiceimagetypes (ref string asa_types[]);

n_ds		lds_Types
Long	i
Long	ll_Max

String	lsa_Types[]

lds_Types = CREATE n_ds

lds_Types.DataObject = "d_companyinvoicemapping"
lds_Types.SetTransObject(SQLCA)


lds_Types.Retrieve(This.of_GeTSourceId())
ll_Max = lds_Types.RowCount()

FOR i = 1 TO ll_Max
	lsa_Types[i] = lds_Types.GetItemString(i, "ptdocument")
NEXT

asa_Types = lsa_Types

Destroy lds_Types

Return UpperBound(lsa_Types[])


end function

on n_cst_beo_company.create
call super::create
end on

on n_cst_beo_company.destroy
call super::destroy
end on

event constructor;call super::constructor;of_SetKeyColumn ( "co_id" )
end event

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.
// RDT 5-13-03 added NotificationEventOrigin & NotificationEventDestination

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "ID"
			aa_Value = This.of_GetID ( )

		CASE "NAME"
			aa_Value = This.of_GetName ( )
			
		CASE "ADDRESS1"
			aa_Value = This.of_GetAddress1 ( )
			
		CASE "ADDRESS2"
			aa_Value = This.of_GetAddress2 ( )
			
		CASE "CITY"
			aa_Value = This.of_GetCity ( )
			
		CASE "STATE"
			aa_Value = This.of_GetState ( )
			
		CASE "ZIP"
			aa_Value = This.of_GetZip ( )
			
		CASE "PHONE1"
			aa_Value = This.of_GetPhone1 ( )
			
		CASE "PHONE2"
			aa_Value = This.of_GetPhone2 ( )
			
		CASE "FAX"
			aa_Value = This.of_GetFax ( )
			
//		CASE "USNON"
//			aa_Value = This.of_GetUSnon ( )
			
		CASE "COUNTRY"
			aa_Value = This.of_GetCountry ( )

		CASE "LOCATION"
			aa_Value = This.of_getLocation ( )	

		CASE "LOCATIONPOSTAL"
			aa_Value = This.of_getLocationPostal ( )				
			
		CASE "BILLSAME"
			aa_Value = This.of_GetBillSame ( )
			
		CASE "BILLINGNAME"
			aa_Value = This.of_GetBillingName ( )
			
		CASE "BILLINGADDRESS1"
			aa_Value = This.of_getBillingAddress1 ( )
			
		CASE "BILLINGADDRESS2"
			aa_Value = This.of_GetBillingAddress2 ( )
			
		CASE "BILLINGCITY"
			aa_Value = This.of_getBillingCity ( )
			
		CASE "BILLINGSTATE"
			aa_Value = This.of_getBillingState ( )

		CASE "BILLINGZIP"
			aa_Value = This.of_getBillingZip ( )
			
		CASE "BILLINGPHONE1"
			aa_Value = This.of_getBillingPhone1 ( )	
			
		CASE "BILLINGPHONE2"
			aa_Value = This.of_getBillingPhone2 ( )	
			
		CASE "BILLINGFAX"
			aa_Value = This.of_getBillingFax ( )	
			
//		CASE "BILLINGUSNON"
//			aa_Value = This.of_getBillingUSNon ( )	

		
			
		CASE "BILLINGLOCATION"
			aa_Value = This.of_getBillingLocation ( )	
			
		CASE "BILLINGLOCATIONPOSTAL"
			aa_Value = This.of_getBillingLocationPostal ( )	
			
		CASE "BILLINGCOUNTRY"
			aa_Value = This.of_getBillingCountry ( )		
			
		CASE "ACCOUNTINGID"
			aa_Value = This.of_getAccountingID ( )	
			
		CASE "STATUS"
			aa_Value = This.of_getStatus ( )
			
		CASE "CODENAME"
			aa_Value = This.of_getCodeName ( )
			
		CASE "FACILITYOF"
			aa_Value = This.of_getFacilityOf ( )	
			
		CASE "COMMENTS"
			aa_Value = This.of_getComments ( )
			
		CASE "DIRECTIONS"
			aa_Value = This.of_getDirections ( )
			
		CASE "BILLINGATTN"
			aa_Value = This.of_getBillingAttn ( )
			
		CASE "BILLINGATTNTEXT" 
			aa_Value = This.of_getBillAttnText ( )
			
		CASE "TIMEZONE"
			aa_Value = This.of_getTimeZone ( )
		
		CASE "PCMILERLOCATION"
			aa_Value = This.of_getPCM ( )
		
		CASE "ALLOWBILLING"
			aa_Value = This.of_getAllowBilling ( )
		
		CASE "HIDDENDISCOUNT"
			aa_Value = This.of_getHiddenDiscount ( )

		CASE "SALESREP"
			aa_Value = This.of_GetSalesRep ( )

		CASE "DEFAULTDURATION"
			aa_Value = This.of_GetDefaultDuration ( )

		CASE "DEFAULTFREIGHTDESCRIPTION"
			aa_Value = This.of_GetDefaultFreightDescription ( )

		CASE "DISPATCHINSTRUCTIONS"
			aa_Value = This.of_GetDispatchInstructions ( )

		CASE "TERMINATIONLOCATION"
			aa_Value = This.of_GetTerminationLocation ( )

		CASE "CUSTOM1", "CUSTOM2", "CUSTOM3", "CUSTOM4", "CUSTOM5", "CUSTOM6", "CUSTOM7", "CUSTOM8", "CUSTOM9", "CUSTOM10"
			aa_Value = This.of_GetValue ( Trim ( as_Attribute ), TypeString! )

		CASE "EDI210CODE"
			aa_Value = This.of_GetEDI210Code ( )

		CASE "EDI214CODE"
			aa_Value = This.of_GetEDI214Code ( )

		CASE "FUELSURCHARGE"
			aa_Value = THIS.of_GetCustomFuelSurcharge ( )
			
		CASE "NOTIFICATIONEVENTORIGIN" 
			aa_Value = THIS.of_GetNotificationEventOrigin ( )
			
		CASE "NOTIFICATIONEVENTDESTINATION"
			aa_Value = THIS.of_GetNotificationEventDestination ( )
			
		CASE "PAYMENTTERMS"
			aa_Value = THIS.of_GetPaymentTerms ( ) 
			
		CASE "ALIAS"
			aa_Value = THIS.of_GetAlias( )
						
		CASE ELSE
			
			li_Return = 0

	END CHOOSE

END IF

RETURN li_Return
end event

event ue_formatvalue;call super::ue_formatvalue;// Extending Ancestor Script.

// Returns: -1 = Error
//           0 = Requested attribute format not found
//           1 = Success

Int li_Return

li_Return = AncestorReturnValue 

IF li_Return = 0 THEN
	
	li_Return = 1 //Changed back later if no match is found.

	CHOOSE CASE  UPPER( Trim ( as_attribute ) ) 
			
		CASE "STATUS"
			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.

				CASE "K"
					as_FormattedValue = "ACTIVE"
					
				CASE "D"
					as_FormattedValue = "DELETED"
					
				CASE "H"
					as_FormattedValue = "ON HOLD"
					
				CASE ELSE //Unexpected value, or null.
					as_FormattedValue = ""
					
			END CHOOSE
			
//		CASE "BILLINGATTN"
//			
//			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
//				//String ( ) is necessary to prevent crash on null value for any variable.
//				
//				CASE ELSE //Unexpected value, or null.
//					as_FormattedValue = ""
//					
//			END CHOOSE
			
		CASE "TIMEZONE"

			CHOOSE CASE Integer ( aa_value )
				//Integer ( ) is necessary to prevent crash on null value for any variable.

				CASE 0
					as_FormattedValue = "HWI"
					
				CASE 1
					as_FormattedValue = "ALK"
					
				CASE 2 
					as_FormattedValue = "PAC"
					
				CASE 3 
					as_FormattedValue = "MTN"
					
				CASE 4 
					as_FormattedValue = "CTL"
					
				CASE 5 
					as_FormattedValue = "EST"
					
				CASE 6 
					as_FormattedValue = "ATL"
					
				CASE ELSE //Unexpected value, or null.
					as_FormattedValue = ""

			END CHOOSE
			
		CASE "BILLINGZIP" , "ZIP"
			as_formattedvalue = THIS.of_FormatZip ( String (aa_value) )
			
			
		CASE "BILLINGPHONE1", "BILLINGPHONE2", "PHONE1", "PHONE2", "FAX", "BILLINGFAX"
			as_formattedvalue = THIS.of_FormatPhone ( String (aa_value) )

		CASE "ALLOWBILLING"
			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
					
				CASE "T"
					as_formattedvalue = "Billing Allowed"
					
				CASE "F"
					as_formattedvalue = "Billing Not Allowed"
					
				CASE ELSE
					as_formattedvalue = ""
			END CHOOSE
			
		CASE "BILLSAME"
			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
					
				CASE "T"
					as_formattedvalue = "SAME"
					
				CASE "F"
					as_formattedvalue = "DIFFERENT"
					
				CASE ELSE
					as_formattedvalue = ""
					
			END CHOOSE
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE
END IF 

RETURN li_Return
end event

event ue_getstringformat;call super::ue_getstringformat;// Extending Ancestor Script.

// Returns: -1 = Error
//           0 = Requested attribute format not found
//           1 = Success

Int li_Return

li_Return = AncestorReturnValue 

IF li_Return = 0 THEN
	
	li_Return = 1 //Changed back later if no match is found.

	CHOOSE CASE  UPPER( Trim ( as_attribute ) ) 
			
		CASE "HIDDENDISCOUNT"
			as_Format =  "0.0##%;-0.0##%;0.0%;NONE"
			
		CASE "FUELSURCHARGE"
			as_Format = "0.00##"
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE

END IF 

RETURN li_Return
end event

