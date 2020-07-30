$PBExportHeader$n_cst_beo_item.sru
forward
global type n_cst_beo_item from pt_n_cst_beo
end type
end forward

shared variables

////begin modification Shared Variables by appeon  20070730
//CONSTANT String	cs_Type_Freight = "L"
//CONSTANT String	cs_Type_Accessorial = "A"
////end modification Shared Variables by appeon  20070730

//Constant String cs_RateType_None = "Z"
//Constant String cs_RateType_Flat = "F"
//Constant String cs_RateType_Minimum = "N"
//Constant String cs_RateType_PerMile  = "M"
//Constant String cs_RateType_PerUnit = "U"
//Constant String cs_RateType_Class = "C"
end variables

global type n_cst_beo_item from pt_n_cst_beo
end type
global n_cst_beo_item n_cst_beo_item

type variables
Private:
DataWindow	idw_EventSource
DataStore	ids_EventSource
n_cst_beo_Shipment	inv_Shipment
Boolean	ib_DontRecalc

//begin modification Shared Variables by appeon  20070730
CONSTANT String	cs_Type_Freight = "L"
CONSTANT String	cs_Type_Accessorial = "A"
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function string of_getdescription ()
public function string of_gettype ()
public function boolean of_isfreight ()
public function boolean of_isaccessorial ()
public function long of_getpickupevent ()
public function long of_getdeliverevent ()
public function boolean of_isfullyassigned ()
public function boolean of_hasdescription ()
public function decimal of_getbillingamount ()
public function long of_getid ()
public function long of_getshipment ()
public function integer of_seteventsource (powerobject apo_source)
public function powerobject of_geteventsource ()
public function integer of_getpickupevent (ref n_cst_beo_event anv_event)
public function integer of_getdeliverevent (ref n_cst_beo_event anv_event)
public function integer of_setshipment (readonly n_cst_beo_shipment anv_shipment)
public function integer of_setquantity (readonly decimal ac_value)
public function integer of_setdescription (readonly string as_value)
public function integer of_setrate (readonly decimal ac_value)
public function integer of_setamount (readonly decimal ac_value)
public function integer of_makefuelsurcharge ()
public function integer of_setratetype (readonly string as_value)
protected function integer of_calculate (string as_whatchanged, readonly decimal ac_newvalue)
public function decimal of_getquantity ()
public function decimal of_getrate ()
public function decimal of_getmiles ()
public function decimal of_getweightperunit ()
public function integer of_setmiles (readonly decimal ac_value)
public function integer of_setweightperunit (readonly decimal ac_value)
public function integer of_settotalweight (readonly decimal ac_value)
public function string of_getratetype ()
public function decimal of_getfreightcharges ()
public function decimal of_getaccessorialcharges ()
public function decimal of_gettypecharges (readonly string as_type)
public function string of_getreference ()
public function string of_getblnum ()
public function string of_getrefnum ()
public function integer of_sethazmat (string as_value)
public function string of_gethazmat ()
public function boolean of_ishazmat ()
public function decimal of_gettotalweight ()
public function integer of_setblnum (string as_blnum)
public function integer of_setrefnum (String as_RefNum)
public function integer of_setpuevent (integer ai_Value)
public function integer of_setdelevent (integer ai_Value)
public function long of_setshipment (long al_Value)
public function integer of_autorate (ref n_cst_ratedata anva_ratedata[])
public function string of_getpayratetype ()
public function decimal of_getpayrate ()
public function decimal of_getpayableamount ()
public function integer of_setpayrate (decimal ac_value)
public function integer of_setpayratetype (string as_value)
public function integer of_setpayableamount (decimal ac_value)
protected function decimal of_calculaterate (string as_ratetype, decimal ac_amount, decimal ac_quantity, decimal ac_miles, decimal ac_totalweight)
protected function decimal of_calculateamount (string as_ratetype, decimal ac_rate, decimal ac_quantity, decimal ac_miles, decimal ac_totalweight)
public function decimal of_gettypepayable (string as_type)
public function decimal of_getfreightpayable ()
public function decimal of_getaccessorialpayable ()
public function integer of_setamounttype (integer ai_value)
public function integer of_getamounttype ()
public function string of_getamounttypename ()
public function integer of_getnotificationtargets (ref long ala_contactids[])
public function string of_getnotificationsubject ()
public function string of_getratecodename ()
public function integer of_setratecodename (string as_value)
public function string of_getlastratedby ()
public function string of_gettaglist ()
public function integer of_setlastratedby (string as_value)
public function integer of_settaglist (string as_value)
public function integer of_setdefaultfreightcircles (n_cst_beo_shipment anv_shipment)
public function integer of_seteventtypeflag (string as_value)
public function string of_geteventtypeflag ()
public function integer of_setaccountingtype (string as_value)
public function string of_getaccountingtype ()
public function boolean of_sendnotification ()
public function String of_getnote ()
public function string of_gettypedescription (string as_type)
public function long of_applyautorate (n_cst_ratedata anva_ratedata[])
public function integer of_autorateandapply ()
public function integer of_clearbillratedata ()
public function integer of_clearpayratedata ()
public function boolean of_sendnotification (long al_id)
public function integer of_setnote (string as_value)
public function integer of_getamounttypecategory ()
public function integer of_applyratelookupresults (n_cst_rate_attribs anv_attribs)
public function decimal of_getfscrate ()
public function integer of_setfscrate (decimal ac_value)
public function integer of_setfsctype (string as_value)
public function string of_getfscratetype ()
public function integer of_setfscitemid (long al_value)
public function integer of_makefuelsurcharge (boolean ab_useoldvalue)
public function integer of_resetfuelsurcharge ()
public function integer of_setdontrecalcflag (boolean ab_value)
end prototypes

public function string of_getdescription ();RETURN This.of_GetValue ( "di_description", TypeString! )
end function

public function string of_gettype ();RETURN This.of_GetValue ( "di_item_type", TypeString! )
end function

public function boolean of_isfreight ();Boolean	lb_Result

CHOOSE CASE of_GetType ( )

CASE cs_Type_Freight
	lb_Result = TRUE

CASE ELSE
	lb_Result = FALSE

END CHOOSE

RETURN lb_Result
end function

public function boolean of_isaccessorial ();Boolean	lb_Result

CHOOSE CASE of_GetType ( )

CASE cs_Type_Accessorial
	lb_Result = TRUE

CASE ELSE
	lb_Result = FALSE

END CHOOSE

RETURN lb_Result
end function

public function long of_getpickupevent ();RETURN This.of_GetValue ( "di_pu_event", TypeLong! )
end function

public function long of_getdeliverevent ();RETURN This.of_GetValue ( "di_del_event", TypeLong! )
end function

public function boolean of_isfullyassigned ();Boolean	lb_Result
String	ls_EventypeFlag

IF of_IsFreight ( ) THEN

	ls_EventypeFlag = THIS.of_Geteventtypeflag( )
	CHOOSE CASE ls_EventypeFlag
			
		CASE  n_cst_constants.cs_itemeventtype_backchassissplit, &
				n_cst_constants.cs_itemeventtype_frontchassissplit , &
				n_cst_constants.cs_itemeventtype_fuelsurcharge , &
				n_cst_constants.cs_itemeventtype_perdiem , &
				n_cst_constants.cs_itemeventtype_stopoff
				
				IF of_GetPickupEvent ( ) > 0 THEN
					lb_Result = TRUE
				END IF
							
		CASE ELSE
			
			IF of_GetPickupEvent ( ) > 0 AND &
				of_GetDeliverEvent ( ) > 0 THEN
		
				lb_Result = TRUE
		
			END IF
	END CHOOSE	
			
ELSEIF of_IsAccessorial ( ) THEN

	IF of_GetPickupEvent ( ) > 0 THEN

		lb_Result = TRUE

	END IF

END IF

RETURN lb_Result
end function

public function boolean of_hasdescription ();Boolean	lb_Result

IF Len ( Trim ( of_GetDescription ( ) ) ) > 0 THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function decimal of_getbillingamount ();RETURN This.of_GetValue ( "di_our_itemamt", TypeDecimal! )
end function

public function long of_getid ();RETURN This.of_GetValue ( "di_item_id", TypeLong! )
end function

public function long of_getshipment ();RETURN This.of_GetValue ( "di_shipment_id", TypeLong! )
end function

public function integer of_seteventsource (powerobject apo_source);DataWindow	ldw_Source
DataStore	lds_Source
n_cst_Dws	lnv_Dws
Integer		li_Return

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

CASE DataWindow!, DataStore!

	idw_EventSource = ldw_Source
	ids_EventSource = lds_Source
	li_Return = 1

CASE ELSE

	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function powerobject of_geteventsource ();PowerObject	lpo_Source

IF IsValid ( idw_EventSource ) THEN
	lpo_Source = idw_EventSource
ELSEIF IsValid ( ids_EventSource ) THEN
	lpo_Source = ids_EventSource
END IF

RETURN lpo_Source
end function

public function integer of_getpickupevent (ref n_cst_beo_event anv_event);Int	li_Return 

IF NOT IsValid(inv_Shipment) THEN
	n_cst_beo_Shipment	lnv_Shipment
	
	lnv_Shipment = CREATE n_cst_beo_Shipment
	
	lnv_Shipment.of_SetEventSource ( of_GetEventSource ( ) )
	lnv_Shipment.of_SetSourceId ( of_GetShipment ( ) )
		
	li_Return = lnv_Shipment.of_GetEvent ( of_GetPickupEvent ( ), anv_Event )
	
	DESTROY ( lnv_Shipment )
ELSE
	li_Return = inv_Shipment.of_GetEvent ( of_GetPickupEvent ( ), anv_Event )
END IF

RETURN li_Return 
end function

public function integer of_getdeliverevent (ref n_cst_beo_event anv_event);Int	li_Return

IF Not IsValid(inv_shipment) THEN

	n_cst_beo_Shipment	lnv_Shipment
	
	lnv_Shipment = CREATE n_cst_beo_Shipment
	
	lnv_Shipment.of_SetEventSource ( of_GetEventSource ( ) )
	lnv_Shipment.of_SetSourceId ( of_GetShipment ( ) )
	
	li_Return = lnv_Shipment.of_GetEvent ( of_GetDeliverEvent ( ), anv_Event )
	
	DESTROY lnv_Shipment 
ELSE
	li_Return = inv_Shipment.of_GetEvent ( of_GetDeliverEvent ( ), anv_Event )
END IF	
RETURN li_Return 
end function

public function integer of_setshipment (readonly n_cst_beo_shipment anv_shipment);//Currently, this is not a change of assignment, just a registration 
//of an existing relationship.

inv_Shipment = anv_Shipment

RETURN 1
end function

public function integer of_setquantity (readonly decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "Quantity", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


//RETURN of_SetAny ( "di_qty", ac_Value )
end function

public function integer of_setdescription (readonly string as_value);RETURN of_SetAny ( "di_description", as_Value )
end function

public function integer of_setrate (readonly decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "Rate", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


//RETURN of_SetAny ( "di_our_rate", ac_Value )
end function

public function integer of_setamount (readonly decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "Amount", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


//RETURN of_SetAny ( "di_our_itemamt", ac_Value )
end function

public function integer of_makefuelsurcharge ();//Modified by Dan 1-3-2006  old functionality version of this function.  This doesn't check to see what the surcharge was calculated from originally.
return	this.of_makeFuelsurcharge( FALSE )

////Returns:  1, -1
////Currently, the function will notify on failure, but this should be 
////changed when the error service is available.
//
//Decimal			lc_Surcharge
//Decimal {2}		lc_TargetAmount
////nwl 8/23/04 - prior to this the lc_rate was limited to 2 decimal places
////I removed it because of truncation for per mile rate
////Decimal {2}			lc_Rate
//Decimal 			lc_Rate
//Decimal			ls_FSCRate
//Decimal {2}		lc_miles
//n_cst_ShipmentManager	lnv_ShipmentManager
//n_cst_beo_Shipment		lnv_Shipment
//n_cst_beo_Company			lnv_Company
//n_cst_bso_Rating			lnv_Rating
//n_cst_RateData				lnv_RateData
//
//String	ls_MessageHeader = "Create Fuel Surcharge", &
//			ls_ErrorText = "Could not process request.", &
//			ls_Description, &
//			ls_CustomDescription, &
//			ls_SurchargeType, &
//			ls_RateType
//			
//String	lsa_RateList[]
//String	ls_RateCodeName
//String	ls_RateDescription
//Long		ll_itemId
//Long		ll_AmountType
//Long		ll_CoID
//Boolean	lb_CustomDescription
//Boolean	lb_HasSurcharge
//
//n_cst_setting_recalcFuelSurcharge lnv_recalcFsc
//
//lnv_recalcFsc = CREATE n_cst_setting_recalcFuelSurcharge
//
//Integer	li_Return = 1
//
//lnv_Rating = CREATE n_cst_bso_Rating
//lnv_RateData = CREATE n_cst_RateData
//
//
////Get a reference to this item's shipment
//lnv_Shipment = inv_Shipment
//
////If the shipment is valid, get the NetFreightCharges for calculation purposes.
////If not valid, fail.
//
//IF IsValid ( lnv_Shipment ) THEN
//
//	IF lnv_Shipment.of_AllowEditBill ( ) = FALSE THEN
//
//		li_Return = -1
//		ls_ErrorText = "Your user permissions do not allow you to edit billing "+&
//			"information for this shipment."
//
//	ELSEIF lnv_Shipment.of_AllowItemCharges ( ) = FALSE THEN
//
//		li_Return = -1
//		ls_ErrorText = "The billing format selected for this shipment does "+&
//			"not allow item-level charges."
//
//	ELSE
////		lc_TargetAmount = lnv_Shipment.of_GetFuelSurchargeableAmount ( )
//
//	END IF
//
//ELSE
//	li_Return = -1
//
//END IF
//
//// look for custom fuel surcharge 
//IF li_Return = 1 THEN
//	IF lnv_Shipment.of_GetBillToCompany ( lnv_Company , TRUE ) > 0 THEN
//		IF lnv_Company.of_HasSource ( ) THEN
//			ll_CoID = lnv_Company.of_GetID ( )
//			IF lnv_Company.of_HasCustomFuelSurcharge ( ) THEN
//				lc_Surcharge = lnv_Company.of_GetCustomFuelSurcharge ( )
//				ls_SurchargeType = lnv_Company.of_GetFuelSurchargeType ( )
//				lb_HasSurcharge = TRUE
//			END IF
//		END IF
//	END IF
//END IF
//
//
//IF li_Return = 1 THEN
//	// Get Rate Code
//	IF lnv_Rating.of_GetCodeDefaultList ( ll_CoID , appeon_constant.cl_FuelSurcharge_list , lsa_RateList ) > 0 THEN	
//		lnv_RateData.of_SetCodeName ( lsa_RateList[1] )
//	
//		ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
//		ls_RateCodeName = lsa_RateList[1]
//		ls_RateDescription = lnv_Rating.of_GetRateDescription ( lnv_RateData )
//	END IF
//	
//END IF
//
//
////If ok to this point, attempt to determine Fuel Surcharge Percentage
//
//IF li_Return = 1 THEN
//	IF NOT lb_HasSurcharge THEN
//		CHOOSE CASE lnv_ShipmentManager.of_GetFuelSurcharge ( lc_Surcharge )
//		
//		CASE 1
//			//Proceed
//			ls_SurchargeType = lnv_ShipmentManager.of_GetFuelSurchargeType ( )
//		CASE 0  //Value not defined (or not defined properly)
//			li_Return = -1
//			ls_ErrorText = "You must define the Fuel Surcharge value in System Settings first."
//		
//		CASE ELSE  //-1
//			li_Return = -1
//			ls_ErrorText = "Could not determine Fuel Surcharge percentage."
//		
//		END CHOOSE
//	END IF
//
//END IF
//
//
////If ok to this point, attempt to determine if there's a Custom Description
//
//IF li_Return = 1 THEN
//
//	CHOOSE CASE lnv_ShipmentManager.of_GetCustomFuelSurchargeDescription ( ls_CustomDescription )
//	
//	CASE 1
//		lb_CustomDescription = TRUE
//	
//	CASE 0  //Value not defined
//		//User wants default description -- Proceed
//	
//	CASE ELSE  //-1
//		li_Return = -1
//		ls_ErrorText = "Could not determine Custom Fuel Surcharge Description."
//	
//	END CHOOSE
//
//END IF
//
//
////If ok to this point, calculate the surcharge amount and set the appropriate fields.
//
//IF li_Return = 1 THEN
//	THIS.of_SetEventTypeFlag ( n_Cst_Constants.cs_ItemEventType_FuelSurcharge ) 
//
//	lc_TargetAmount = lnv_Shipment.of_GetFuelSurchargeableAmount ( ls_SurchargeType )
//
//	//added by Dan 1-3-2006 to find out if the current rate is different from the rate used to 
//	//calculate the FSC.
//	//if the setting is no, then do the new logic
//	IF ab_useOldValue THEN
//		
//	END IF
//	//-------------------------
//	choose case ls_SurchargeType
//		case 'PERCENTAGE'
//			
//			lc_Rate = lc_TargetAmount * ( lc_Surcharge / 100 )
//			ls_RateType = appeon_constant.cs_Rateunit_code_Flat
//			
//			IF ls_RateDescription <> "" THEN
//				ls_Description =  ls_RateDescription 
//			ELSE
//				IF lb_CustomDescription THEN
//					ls_Description = ls_CustomDescription
//				ELSE
//					ls_Description = "FUEL SURCHARGE ( " + String ( lc_Surcharge, "0.0###########" ) +&
//						"% OF " + String ( lc_TargetAmount, "[currency]" ) + " )"
//				END IF
//			END IF
//
//		case 'PERMILE'
//			
//			ls_RateType = appeon_constant.cs_Rateunit_code_PerMile
//			lc_Rate = lc_Surcharge
//			lc_miles = THIS.of_getMiles()
//			if lc_miles = 0 then
//				inv_shipment.of_GetTotalMiles(lc_miles)
//			end if
//			IF ls_RateDescription <> "" THEN
//				ls_Description =  ls_RateDescription 
//			ELSE
//				IF lb_CustomDescription THEN
//					ls_Description = ls_CustomDescription
//				ELSE
//					ls_Description = "FUEL SURCHARGE ( " + String ( lc_Surcharge, "0.0###########" ) +&
//						"/Mile for " + string( lc_miles, "0#######" ) + " miles )"
//				END IF
//			END IF
//
//			
//	end choose
//	
//	ll_itemId = this.of_getId( )						//added by dan to save the item id out to the disp_itemlinktofscRate table
//	
//	This.of_SetRateType ( ls_RateType )
//	This.of_SetDescription ( ls_Description )
//	This.of_SetQuantity ( 1 )
//	This.of_SetRate ( lc_Rate )
//	this.of_SetfscItemId( ll_itemId )				//added by dan to save fuel surcharge rate used to calc
//	this.of_Setfscrate( lc_Surcharge )				//added by dan to save fuel surcharge rate used to calc
//	this.of_setfscType( ls_SurchargeType )			//added by dan to save type of the rate used for calculation
//	
//	if ls_SurchargeType = "PERMILE" then
//		This.of_SetMiles(lc_miles)
////		This.of_SetAmount(lc_Rate * lc_miles)
//		This.of_SetRate ( lc_Rate )
//	end if
//	
//	IF ll_AmountType > 0 THEN
//		THIS.of_SetAmountType ( ll_AmountType )
//	END IF
//	
//	IF ls_RateCodeName <> "" THEN
//		THIS.of_SetRateCodeName ( ls_RateCodeName )
//	END IF
//	
////	Amount will auto-process
//
//END IF
//
////If there was an error condition, report it.
//
//IF li_Return = -1 THEN
//
//	ls_ErrorText += "~n~nRequest cancelled."
//	MessageBox ( ls_MessageHeader, ls_ErrorText, Exclamation! )
//
//END IF
//DESTROY	lnv_Rating
//DESTROY	lnv_RateData
//DESTROY lnv_Company
//Destroy	lnv_recalcFsc
//
//RETURN li_Return
end function

public function integer of_setratetype (readonly string as_value);//Clear the current rate information before changing rate type value
This.of_SetRate ( 0 )
//of_SetAny ( "di_our_rate", 0 )
//of_SetAny ( "di_our_itemamt", 0 )
RETURN of_SetAny ( "di_our_ratetype", as_Value )
end function

protected function integer of_calculate (string as_whatchanged, readonly decimal ac_newvalue);Decimal	lc_OldQuantity, &
			lc_OldBillingAmount, &
			lc_OldPayAmount, &
			lc_OldMiles, &
			lc_OldWeightPerUnit, &
			lc_OldTotalWeight

Decimal	lc_Quantity, &
			lc_Rate, &
			lc_Amount, &
			lc_Miles, &
			lc_WeightPerUnit, &
			lc_TotalWeight

Integer	li_Return = 1

lc_OldQuantity = This.of_GetQuantity ( )
lc_OldBillingAmount = This.of_GetBillingAmount ( )
lc_OldPayAmount = This.of_GetPayableAmount ( )
lc_OldMiles = This.of_GetMiles ( )
lc_OldWeightPerUnit = This.of_GetWeightPerUnit ( )
lc_OldTotalWeight = This.of_GetTotalWeight ( )

as_WhatChanged = Lower ( as_WhatChanged )


//Determine new value for miles
IF as_WhatChanged = Lower ( "Miles" ) THEN
	lc_Miles = ac_NewValue
ELSE
	lc_Miles = lc_OldMiles
END IF

lc_Miles = Round ( lc_Miles, 0 )


//Determine new value for quantity and weights
CHOOSE CASE as_WhatChanged

CASE Lower ( "Quantity" )

	lc_Quantity = ac_NewValue
	lc_WeightPerUnit = lc_OldWeightPerUnit
	lc_TotalWeight = lc_Quantity * lc_WeightPerUnit

CASE Lower ( "WeightPerUnit" )

	lc_Quantity = lc_OldQuantity
	lc_WeightPerUnit = ac_NewValue
	lc_TotalWeight = lc_Quantity * lc_WeightPerUnit

CASE Lower ( "TotalWeight" )

	lc_Quantity = lc_OldQuantity
	lc_TotalWeight = ac_NewValue
	IF lc_TotalWeight = 0 OR lc_Quantity = 0 THEN
		lc_WeightPerUnit = 0
		lc_TotalWeight = 0
	ELSE
		lc_WeightPerUnit = lc_TotalWeight / lc_Quantity
	END IF

CASE ELSE

	lc_Quantity = lc_OldQuantity
	lc_WeightPerUnit = lc_OldWeightPerUnit
	lc_TotalWeight = lc_OldTotalWeight

END CHOOSE

//recalculate payable columns
choose case as_WhatChanged
	case "payamount"
		lc_Amount = ac_NewValue

		if this.of_getpayratetype() = appeon_constant.cs_RateUnit_Code_None  then
			this.of_adderror("You must select a rate type first. The change is cancelled, " + &
									"and the previous value will be restored.")
			li_Return = -1
			lc_amount = 0
		else
			//Determine Rate
			lc_rate = this.of_calculaterate(This.of_GetPayRateType ( ), lc_amount, lc_quantity, lc_miles, lc_totalweight)
			if lc_rate = 0 then
				lc_amount = 0
			end if			
		end if
		
		This.of_SetAny ( "di_pay_rate", lc_Rate )
		This.of_SetAny ( "di_pay_itemamt", lc_Amount )

	case else
		if as_whatchanged <> "rate" then
			//other values that affect amounts may have changed
			IF as_WhatChanged = "payrate" THEN
				lc_Rate = ac_NewValue
			ELSE
				lc_Rate = This.of_GetPayRate ( )
			END IF
				
			lc_Amount = this.of_calculateamount(This.of_GetPayRateType ( ), lc_rate, lc_quantity, lc_miles, lc_totalweight)
			if lc_amount = 0 then
				lc_rate = 0
			end if
			
			This.of_SetAny ( "di_pay_rate", lc_Rate )
			This.of_SetAny ( "di_pay_itemamt", lc_Amount )
		end if
		
end choose


//Determine new value for rate and amount

CHOOSE CASE as_WhatChanged

CASE Lower ( "Amount" )

	lc_Amount = ac_NewValue

	if this.of_getratetype() = appeon_constant.cs_RateUnit_Code_None then
		this.of_adderror("You must select a rate type first. The change is cancelled, " + &
								"and the previous value will be restored.")
		li_Return = -1
		lc_amount = 0
	else
		//Determine Rate
		lc_rate = this.of_calculaterate(This.of_GetRateType ( ), lc_amount, lc_quantity, lc_miles, lc_totalweight)
		if lc_rate = 0 then
			lc_amount = 0
		end if
	end if
	
	This.of_SetAny ( "di_our_rate", lc_Rate )
	This.of_SetAny ( "di_our_itemamt", lc_Amount )

CASE ELSE

	if as_whatchanged <> "payrate" then
		//other values that affect amounts may have changed
		IF as_WhatChanged = Lower ( "Rate" ) THEN
			lc_Rate = ac_NewValue
		ELSE
			lc_Rate = This.of_GetRate ( )
		END IF
	
		lc_Amount = this.of_calculateamount(This.of_GetRateType ( ), lc_rate, lc_quantity, lc_miles, lc_totalweight)
		if lc_amount = 0 then
			lc_rate = 0
		end if
		
		This.of_SetAny ( "di_our_rate", lc_Rate )
		This.of_SetAny ( "di_our_itemamt", lc_Amount )
	end if
	
END CHOOSE

This.of_SetAny ( "di_qty", lc_Quantity )
This.of_SetAny ( "di_miles", lc_Miles )
This.of_SetAny ( "di_weightperunit", lc_WeightPerUnit )
This.of_SetAny ( "di_totitemweight", lc_TotalWeight )

IF IsValid ( inv_Shipment ) THEN
	IF THIS.of_GetEventTypeFlag ( ) =  n_cst_Constants.cs_ItemEventType_FuelSurcharge  THEN
	  // don't recalc surcharges
	ELSE
		IF ( lc_OldBillingAmount <> THIS.of_GetBillingAmount ( ) ) OR &
			( lc_OldPayAmount <> This.of_GetPayableAmount ( ) ) OR & 
			( lc_OldMiles <> lc_miles ) THEN
			inv_Shipment.of_RecalcSurcharges ( )
		END IF
	END IF
	
	inv_Shipment.of_Calculate ( )
	inv_Shipment.of_CalculatePayable ( )
END IF


RETURN li_Return
end function

public function decimal of_getquantity ();RETURN This.of_GetValue ( "di_qty", TypeDecimal! )
end function

public function decimal of_getrate ();RETURN This.of_GetValue ( "di_our_rate", TypeDecimal! )
end function

public function decimal of_getmiles ();RETURN This.of_GetValue ( "di_miles", TypeInteger! )
end function

public function decimal of_getweightperunit ();RETURN This.of_GetValue ( "di_weightperunit", TypeLong! )
end function

public function integer of_setmiles (readonly decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "Miles", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


//RETURN of_SetAny ( "di_miles", ac_Value )
end function

public function integer of_setweightperunit (readonly decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "WeightPerUnit", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


//RETURN of_SetAny ( "di_weightperunit", ac_Value )
end function

public function integer of_settotalweight (readonly decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "TotalWeight", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


//RETURN of_SetAny ( "di_totitemweight", ac_Value )
end function

public function string of_getratetype ();RETURN This.of_GetValue ( "di_our_ratetype", TypeString! )
end function

public function decimal of_getfreightcharges ();//Returns the freight charges associated with this item, if any.
//Returns null if the value cannot be determined.

RETURN This.of_GetTypeCharges ( cs_Type_Freight )
end function

public function decimal of_getaccessorialcharges ();//Returns the accessorial charges associated with this item, if any.
//Returns null if the value cannot be determined.

RETURN This.of_GetTypeCharges ( cs_Type_Accessorial )
end function

public function decimal of_gettypecharges (readonly string as_type);//Returns the charges associated with this item of the type requested, if any.
//Returns null if the value cannot be determined.

Decimal	lc_TypeCharges
String	ls_Type

//Currently, all the charges for the item are allocated by item type.

ls_Type = This.of_GetType ( )

IF IsNull ( ls_Type ) THEN

	SetNull ( lc_TypeCharges )

ELSEIF ls_Type = as_Type THEN

	lc_TypeCharges = This.of_GetBillingAmount ( )

ELSE
	//Leave lc_TypeCharges = 0

END IF

RETURN lc_TypeCharges
end function

public function string of_getreference ();//Returns Reference # regardless of Freight or Accessorial Type.
//Use of_GetBLNum or of_GetRefNum if you want only BL# or 
//Accessorial reference #, depending on item type.

RETURN This.of_GetValue ( "di_blnum", TypeString! )
end function

public function string of_getblnum ();//Note:  Returns the Reference Number field, but only if it's a freight item
//(ie., having a BL).  Otherwise, returns Null

String	ls_BLNum

IF This.of_IsFreight ( ) THEN
	ls_BLNum = This.of_GetReference ( )
ELSE
	SetNull ( ls_BLNum )
END IF

RETURN ls_BLNum
end function

public function string of_getrefnum ();//Note:  Returns the Reference Number field, but only if it's an accessorial item.
//Otherwise, returns Null.  Use of_GetReference if you want the # regardless of type.

String	ls_RefNum

IF This.of_IsAccessorial ( ) THEN
	ls_RefNum = This.of_GetReference ( )
ELSE
	SetNull ( ls_RefNum )
END IF

RETURN ls_RefNum
end function

public function integer of_sethazmat (string as_value);// Returns 1, -1

Int	li_ReturnValue = -1

IF of_SetAny ( "di_hazmat", as_Value ) = 1 THEN
	
	IF IsValid ( inv_shipment ) THEN
		IF inv_shipment.of_CalculateHazmat ( ) = 1 THEN
			li_ReturnValue = 1
		END IF
	END IF
	
END IF

RETURN li_ReturnValue
end function

public function string of_gethazmat ();RETURN THIS.of_GetValue ( "di_hazmat" , TYPESTRING!)
end function

public function boolean of_ishazmat ();Boolean	lb_Result

IF This.of_GetHazmat ( ) = "T" THEN
	lb_Result = TRUE
END IF

RETURN lb_Result
end function

public function decimal of_gettotalweight ();RETURN This.of_GetValue ( "di_totitemweight", TypeLong! )
end function

public function integer of_setblnum (string as_blnum);Int	li_return = -1

IF This.of_IsFreight ( ) THEN
	IF of_SetAny ( "di_blnum", as_blnum ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function integer of_setrefnum (String as_RefNum);Int	li_return = -1

IF This.of_IsAccessorial ( ) THEN
	IF of_SetAny ( "di_blnum", as_RefNum ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function integer of_setpuevent (integer ai_Value);RETURN of_SetAny ( "di_pu_event", ai_Value )
end function

public function integer of_setdelevent (integer ai_Value);RETURN of_SetAny ( "di_del_event", ai_Value )
end function

public function long of_setshipment (long al_Value);RETURN This.of_SetAny ( "di_shipment_id", al_Value )
end function

public function integer of_autorate (ref n_cst_ratedata anva_ratedata[]);// Assuming that the licensing for auto rating was already checked

integer	li_return = 1, &
			li_category
long		ll_errorcount
		
string	ls_errormessage

n_cst_OFRError	lnva_Errors[]
n_cst_beo_item		lnva_item[]
n_cst_bso_rating	lnv_rating
n_cst_RateData		lnva_rateData[]

if li_return = 1 then
	if IsValid ( inv_shipment ) then
		li_return = 1 
	else
		li_return = -1
	end if
end if

if li_return = 1 then
	lnv_rating = create n_cst_bso_rating	
	lnva_item[1] = this

	lnv_rating.ClearOFRErrors ( )
	

	CHOOSE CASE this.of_GetAccountingType()	
		CASE n_cst_constants.cs_AccountingType_Billable, n_cst_constants.cs_AccountingType_Both
			li_category = n_cst_constants.ci_Category_Receivables
		CASE n_cst_constants.cs_AccountingType_Payable
			li_category = n_cst_constants.ci_Category_Payables
		CASE ELSE
			//DEFAULT
			li_category = n_cst_constants.ci_Category_Receivables
	END CHOOSE
	
	
	if lnv_rating.of_autorate(inv_shipment, lnva_item, lnva_rateData, li_category ) = 1 then
		lnv_rating.GetOFRErrors ( lnva_Errors )
		ll_errorcount = lnv_rating.GetErrorCount()
		if ll_errorcount > 0 then
			ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
	
			if Len ( ls_errormessage ) > 0 then
				//OK
			else
				ls_errormessage = "Unspecified error on rating."
			end if
		
			if len(ls_errormessage) > 0 then
				if ls_errormessage = "Cancelled" then
					//user cancelled
					li_return = -1
				else
					//Dan 2-1-2006 check for scheduler running here
					IF NOT gnv_app.of_runningscheduledtask( ) THEN	
						messagebox("Auto Rating", ls_errormessage)
					END IF
					//--------------------
					li_return = -1
				end if
			end if
			
		end if
	else
		//returned -1, no rating done
	end if
	
	destroy lnv_rating

	anva_ratedata = lnva_ratedata
	
else
	li_return = -1
end if

return li_return


/*  Commented out when Dan Integrated autorating and fuel surcharge objects
// Assuming that the licensing for auto rating was already checked

integer	li_return = 1, &
			li_category
long		ll_errorcount
		
string	ls_errormessage

n_cst_OFRError	lnva_Errors[]
n_cst_beo_item		lnva_item[]
n_cst_bso_rating	lnv_rating
n_cst_RateData		lnva_rateData[]

if li_return = 1 then
	if IsValid ( inv_shipment ) then
		li_return = 1 
	else
		li_return = -1
	end if
end if

if li_return = 1 then
	lnv_rating = create n_cst_bso_rating	
	lnva_item[1] = this

	lnv_rating.ClearOFRErrors ( )
	

	CHOOSE CASE this.of_GetAccountingType()	
		CASE n_cst_constants.cs_AccountingType_Billable, n_cst_constants.cs_AccountingType_Both
			li_category = n_cst_constants.ci_Category_Receivables
		CASE n_cst_constants.cs_AccountingType_Payable
			li_category = n_cst_constants.ci_Category_Payables
		CASE ELSE
			//DEFAULT
			li_category = n_cst_constants.ci_Category_Receivables
	END CHOOSE
	
	
	if lnv_rating.of_autorate(inv_shipment, lnva_item, lnva_rateData, li_category ) = 1 then
		lnv_rating.GetOFRErrors ( lnva_Errors )
		ll_errorcount = lnv_rating.GetErrorCount()
		if ll_errorcount > 0 then
			ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
	
			if Len ( ls_errormessage ) > 0 then
				//OK
			else
				ls_errormessage = "Unspecified error on rating."
			end if
		
			if len(ls_errormessage) > 0 then
				if ls_errormessage = "Cancelled" then
					//user cancelled
					li_return = -1
				else
				messagebox("Auto Rating", ls_errormessage)
				li_return = -1
				end if
			end if
			
		end if
	else
		//returned -1, no rating done
	end if
	
	destroy lnv_rating

	anva_ratedata = lnva_ratedata
	
else
	li_return = -1
end if

return li_return
*/
end function

public function string of_getpayratetype ();RETURN This.of_GetValue ( "di_pay_ratetype", TypeString! )
end function

public function decimal of_getpayrate ();RETURN This.of_GetValue ( "di_pay_rate", TypeDecimal! )
end function

public function decimal of_getpayableamount ();RETURN This.of_GetValue ( "di_pay_itemamt", TypeDecimal! )
end function

public function integer of_setpayrate (decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "PayRate", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


end function

public function integer of_setpayratetype (string as_value);integer li_return
//Clear the current rate information before changing rate type value
This.of_SetPayRate ( 0 )

li_return = of_SetAny ( "di_pay_ratetype", as_Value )

return li_return
end function

public function integer of_setpayableamount (decimal ac_value);Integer	li_Return = -1

IF This.of_Calculate ( "PayAmount", ac_Value ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


end function

protected function decimal of_calculaterate (string as_ratetype, decimal ac_amount, decimal ac_quantity, decimal ac_miles, decimal ac_totalweight);decimal lc_rate

CHOOSE CASE as_RateType

CASE appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
	  appeon_constant.cs_RateUnit_Code_Maximum
	lc_Rate = ac_Amount

CASE appeon_constant.cs_RateUnit_Code_PerUnit, appeon_constant.cs_RateUnit_Code_Piece, &
	  appeon_constant.cs_RateUnit_Code_Gallon

	IF ac_Quantity = 0 THEN
		lc_Rate = 0
	ELSE
		lc_Rate = ac_Amount / ac_Quantity
	END IF

CASE appeon_constant.cs_RateUnit_Code_PerMile

	IF ac_Miles = 0 THEN
		lc_Rate = 0
	ELSE
		lc_Rate = ac_Amount / ac_Miles
	END IF

CASE appeon_constant.cs_RateUnit_Code_Pound
	// The old conditional check was "IF ac_Miles = 0 THEN'... which i think was a copy and paste error
	// from the case statement above. issue 2605 <<*>>
	IF ac_TotalWeight = 0 THEN  
		lc_Rate = 0
	ELSE
		lc_Rate = ac_Amount / ac_TotalWeight
	END IF
	
CASE appeon_constant.cs_RateUnit_Code_100Pound
	
	IF ac_TotalWeight = 0 THEN
		lc_Rate = 0
	ELSE
		lc_Rate = ac_Amount / ( ac_TotalWeight / 100 )
	END IF

CASE appeon_constant.cs_RateUnit_Code_Ton
	
	IF ac_TotalWeight = 0 THEN
		lc_Rate = 0
	ELSE
		lc_Rate = ac_Amount / ( ac_TotalWeight / 2000 )
	END IF

CASE appeon_constant.cs_RateUnit_Code_Class

	IF ac_TotalWeight = 0 THEN
		lc_Rate = 0
	ELSE
		lc_Rate = ac_Amount / ( ac_TotalWeight / 100 )
	END IF

CASE ELSE  //cs_RateType_None
	lc_Rate = 0

END CHOOSE

return lc_rate
end function

protected function decimal of_calculateamount (string as_ratetype, decimal ac_rate, decimal ac_quantity, decimal ac_miles, decimal ac_totalweight);decimal	lc_amount

CHOOSE CASE as_RateType

CASE appeon_constant.cs_RateUnit_Code_Flat, appeon_constant.cs_RateUnit_Code_Minimum, &
	  appeon_constant.cs_RateUnit_Code_Maximum
	lc_Amount = ac_Rate

CASE appeon_constant.cs_RateUnit_Code_PerUnit, appeon_constant.cs_RateUnit_Code_Piece, &
	  appeon_constant.cs_RateUnit_Code_Gallon
	lc_Amount = ac_Rate * ac_Quantity

CASE appeon_constant.cs_RateUnit_Code_PerMile
	lc_Amount = ac_Rate * ac_Miles

CASE appeon_constant.cs_RateUnit_Code_Class
	lc_Amount = ac_Rate * ( ac_TotalWeight / 100 )

CASE appeon_constant.cs_RateUnit_Code_Pound
	lc_Amount = ac_Rate * ac_TotalWeight
	
CASE appeon_constant.cs_RateUnit_Code_100Pound
	lc_Amount = ac_Rate * ( ac_TotalWeight / 100 )

CASE appeon_constant.cs_RateUnit_Code_Ton
	lc_Amount = ac_Rate * ( ac_TotalWeight / 2000 )

CASE ELSE  //appeon_constant.cs_RateUnit_Code_None
	lc_Amount = 0

END CHOOSE

return lc_amount
end function

public function decimal of_gettypepayable (string as_type);//Returns the payable associated with this item of the type requested, if any.
//Returns null if the value cannot be determined.

Decimal	lc_TypePayable
String	ls_Type

//Currently, the payable for the item is allocated by item type.

ls_Type = This.of_GetType ( )

IF IsNull ( ls_Type ) THEN

	SetNull ( lc_TypePayable )

ELSEIF ls_Type = as_Type THEN

	lc_TypePayable = This.of_GetPayableAmount ( )

ELSE
	//Leave lc_TypePayable = 0

END IF

RETURN lc_TypePayable
end function

public function decimal of_getfreightpayable ();//Returns the freight payable associated with this item, if any.
//Returns null if the value cannot be determined.

RETURN This.of_GetTypePayable ( cs_Type_Freight )
end function

public function decimal of_getaccessorialpayable ();//Returns the accessorial payable associated with this item, if any.
//Returns null if the value cannot be determined.

RETURN This.of_GetTypePayable ( cs_Type_Accessorial )
end function

public function integer of_setamounttype (integer ai_value);Int	li_Return

li_Return = This.of_SetAny ( "amounttype", ai_Value )

IF THIS.of_GetEventTypeFlag ( ) =  n_cst_Constants.cs_ItemEventType_FuelSurcharge  OR ib_dontrecalc THEN
ELSE
	IF IsValid ( inv_SHipment ) THEN
		inv_Shipment.of_RecalcSurcharges ( )
	END IF
END IF

RETURN li_Return
end function

public function integer of_getamounttype ();RETURN This.of_GetValue ( "amounttype", TypeInteger! )
end function

public function string of_getamounttypename ();n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
n_cst_beo_amounttype lnv_amounttype
Integer	li_Return, &
			li_id
string	ls_name

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

li_id = this.of_getamounttype()

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_Beo = lnv_Cache.getBeo("amounttype_id = " + string(li_id) )
	IF isValid(lnv_Beo) THEN
		li_Return = 1            
	END IF

END IF

if li_return = 1 then
	lnv_amounttype = lnv_Beo
	ls_name = lnv_amounttype.of_getname()
else
	ls_name = ''
end if

return ls_name

end function

public function integer of_getnotificationtargets (ref long ala_contactids[]);//
/***************************************************************************************
NAME			: of_GetNotificationTargets
ACCESS		: Public
ARGUMENTS	: Long array	(ala_ContactIDs[])
RETURNS		: Integer		(Number of contact id's retrieved)
DESCRIPTION	: retrieves the contacts from the shipment

REVISION		: RDT 092602
***************************************************************************************/

Int	li_Return 
Long	ll_ShipmentID

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Shipment	lnv_Shipment


lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Dispatch = CREATE n_cst_bso_Dispatch

ll_ShipmentID = THIS.of_GetShipment (  )

IF ll_ShipmentID > 0 THEN
	lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID ) 
	lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( )) 
	lnv_Shipment.of_SetSourceID ( ll_ShipmentID ) 
END IF


IF lnv_Shipment.of_HasSource ( ) THEN
   //lnv_Shipment.of_GetNotificationTargets ( ala_ContactIDs[] )
	lnv_Shipment.of_getaccnotecontacts ( ala_ContactIDs[] )
	li_Return = UpperBound ( ala_ContactIDs[] )
END IF


DESTROY ( lnv_Shipment ) 
Destroy ( lnv_Dispatch )

RETURN li_Return 
end function

public function string of_getnotificationsubject ();// RDT 6-19-03 removed shipment id from subject and added reference data
String	ls_Return
Long	ll_ShipmentID

// RDT 6-19-03 -Start 
String ls_RefLabel, ls_RefText 
ls_RefLabel = THIS.of_getreference( )
ls_RefText  = THIS.of_getrefnum(  )

If Len(Trim( ls_RefLabel ) ) < 1 or IsNull( ls_RefLabel ) or ls_RefLabel = "[NONE]" then 
		ls_RefLabel = ""
End If
If Len(Trim( ls_RefText ) ) < 1 or IsNull( ls_RefText ) then 
		ls_RefText = ""
End If

ls_Return = "Accessorial Charges " + ls_RefLabel+ " "+ ls_RefText

// RDT 6-19-03 -END 

//ll_ShipmentID = THIS.of_GetShipment (  )

//IF ll_ShipmentID > 0 THEN
//	ls_Return += " for shipment " + String ( ll_ShipmentID ) 
//END IF


RETURN ls_Return
end function

public function string of_getratecodename ();RETURN This.of_GetValue ( "RateCodename", TypeString! )
end function

public function integer of_setratecodename (string as_value);RETURN of_SetAny ( "RateCodename", as_Value )
end function

public function string of_getlastratedby ();RETURN This.of_GetValue ( "LastRatedBy", TypeString! )
end function

public function string of_gettaglist ();RETURN This.of_GetValue ( "TagList", TypeString! )
end function

public function integer of_setlastratedby (string as_value);RETURN of_SetAny ( "LastRatedBy", as_Value )
end function

public function integer of_settaglist (string as_value);RETURN of_SetAny ( "TagList", as_Value )
end function

public function integer of_setdefaultfreightcircles (n_cst_beo_shipment anv_shipment);String		ls_ItemType
Boolean		lb_Continue
Long			ll_FreightCount
Long			ll_EventCount
Long			ll_PuEvent
Long			ll_DelEvent
Long			ll_FoundRow
Int			li_Return = 1

PowerObject	lpo_ItemSource
PowerObject lpo_EventSource

n_cst_dws	lnv_dws

lb_Continue = IsValid ( anv_Shipment )

IF lb_Continue THEN
	lb_Continue = NOT anv_Shipment.of_ISIntermodal ( )
END IF

IF lb_Continue THEN
	ls_ItemType = THIS.of_GetType () 
END IF

IF lb_Continue THEN
	ll_FreightCount = anv_Shipment.of_GetItemCount ( "L" ) 
	ll_EventCount = anv_Shipment.of_GetEventCount ( )
	lpo_ItemSource = anv_Shipment.of_GetItemSource ( )
	lpo_EventSource = anv_Shipment.of_GetEventSource ( )
END IF

lb_Continue = IsValid ( lpo_ItemSource ) AND IsValid ( lpo_EventSource )

IF lb_Continue THEN
	CHOOSE CASE ls_ItemType
			
		CASE "L"  // freight
			
			IF ll_FreightCount - 1 > 0 THEN
				
				ll_PuEvent = lnv_Dws.of_GetItemNumber ( lpo_ItemSource , ll_FreightCount - 1, "di_pu_event" )
				ll_DelEvent = lnv_Dws.of_GetItemNumber ( lpo_ItemSource , ll_FreightCount - 1, "di_del_event" )
		
			ELSEIF ll_EventCount > 0 THEN
				
				setnull( ll_PuEvent )
				setnull( ll_DelEvent )
				
				ll_FoundRow = lnv_Dws.of_Find ( lpo_EventSource , "pos('PHM', de_event_type) > 0", 1, ll_EventCount )
			
				IF ll_foundrow > 0 THEN
					
					ll_puEvent = ll_foundrow
					
					ll_FoundRow = lnv_Dws.of_Find ( lpo_EventSource , "pos('DRN', de_event_type) > 0", ll_PuEvent , ll_EventCount )
					
					IF ll_foundrow > 0 THEN
						ll_delEvent = ll_foundrow
					END IF
					
				END IF
			END IF
			
			THIS.of_SetPUEvent ( ll_PuEvent )
			THIS.of_SetDelEvent ( ll_DelEvent )
	
	END CHOOSE
END IF

IF NOT lb_Continue THEN
	li_Return = -1
END IF

RETURN li_Return


end function

public function integer of_seteventtypeflag (string as_value);integer	li_return
Long		ll_Null
String	ls_Null	
		
n_cst_ratedata	lnva_ratedata[]
n_cst_AnyArraySrv		lnv_ArraySrv

SetNull ( ll_Null )
SetNull ( ls_Null )

li_return = of_SetAny ( "eventflag", as_Value )
//IF IsNull ( THIS.of_GetDescription ( ) )THEN
	CHOOSE CASE as_value						
		CASE n_cst_constants.cs_itemeventtype_backchassissplit
			THIS.of_SetDescription ( "CHASSIS RETURN" )
		CASE	n_cst_constants.cs_itemeventtype_Frontchassissplit
			THIS.of_SetDescription ( "CHASSIS PICKUP" )
	END CHOOSE
//END IF

CHOOSE CASE as_value
			
	CASE 	n_cst_constants.cs_ItemEventType_PerDiem , &
			n_cst_constants.cs_ItemEventType_FuelSurcharge, &
			n_Cst_Constants.cs_itemeventtype_imported, &
			n_Cst_Constants.cs_itemeventtype_importedacc, &
			n_Cst_Constants.cs_itemeventtype_importedfreight
				
	CASE ELSE
			

		if li_return = 1 then
			
			THIS.of_SetPUEvent ( ll_Null )
			THIS.of_SetDelEvent ( ll_Null )
			THIS.of_setRatecodename( ls_Null )
				
			if this.of_autorate ( lnva_rateData) = -1 then
				//error
			else
				setpointer(HourGlass!)
				this.of_applyautorate ( lnva_rateData)
				lnv_ArraySrv.of_Destroy ( lnva_RateData )
			END IF
			
		end if
		
END CHOOSE




return li_return


end function

public function string of_geteventtypeflag ();
RETURN This.of_GetValue ( "eventflag", TypeString! )
end function

public function integer of_setaccountingtype (string as_value);Int	li_SetReturn

li_SetReturn = of_SetAny ("accountingtype", as_Value)
IF li_SetReturn = 1 THEN

	CHOOSE CASE as_Value 
			
		CASE n_cst_constants.cs_accountingtype_billable
			THIS.of_SetPayableamount ( 0 ) 
			THIS.of_SetPayRate ( 0 ) 
			THIS.of_SetPayRateType ( appeon_constant.cs_rateunit_code_none ) 
			
		CASE n_cst_constants.cs_accountingtype_Payable
			
			THIS.of_Setamount ( 0 ) 
			THIS.of_SetRate ( 0 ) 
			THIS.of_SetRateType ( appeon_constant.cs_rateunit_code_none ) 

	END CHOOSE
	
END IF

RETURN li_SetReturn
end function

public function string of_getaccountingtype ();RETURN This.of_GetValue ("accountingtype", TypeString!)
end function

public function boolean of_sendnotification ();// RDT 5-13-03 moved to of_SendNotification(long) 

//Boolean	lb_Return
//Long		ll_AmountTypeID
//
//n_cst_beo_AmountType		lnv_AmountType
//n_cst_bso_transactionManager	lnv_Trans
//
//lnv_Trans = CREATE n_cst_bso_transactionManager
//
//
//ll_AmountTypeID = THIS.of_GetAmountType ( )
//
//IF ll_AmountTypeID > 0 THEN
//	IF lnv_Trans.of_GetAmountType ( ll_AmountTypeID , lnv_AmountType ) = 1 THEN
//		lb_Return  = lnv_AmountType.of_GetNotify ( ) = 'T' 
//			
//	END IF
//END IF
//
////DESTROY ( lnv_AmountType )
//DESTROY ( lnv_Trans )
//
//Return lb_Return

RETURN This.of_SendNotification( 0 ) 

end function

public function String of_getnote ();//
/***************************************************************************************
NAME			: of_GetNote
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: String (notes)
REVISION		: RDT 12-04-02
***************************************************************************************/

RETURN This.of_GetValue ( "note", TypeString! )

end function

public function string of_gettypedescription (string as_type);//
/***************************************************************************************
NAME			: of_GetTypeDescription
ACCESS		: Public 
ARGUMENTS	: String
RETURNS		: String 
DESCRIPTION	: Returns the description from the constants.

REVISION		: RDT 12-03-02
***************************************************************************************/
String ls_Return

Choose Case as_type
		
	Case n_cst_Constants.cs_ItemType_Freight 		
		ls_Return = n_cst_Constants.cs_ItemType_Freight_Description
	
	Case n_cst_Constants.cs_ItemType_Accessorial 
		ls_Return = n_cst_Constants.cs_ItemType_Accessorial_Description

	Case Else
		ls_Return = ""		
End Choose

Return ls_Return


end function

public function long of_applyautorate (n_cst_ratedata anva_ratedata[]);long		ll_index, &
			ll_count, &
			ll_found, &
			ll_amounttype, &
			ll_coid
string	ls_description, &
			ls_taglist

String	ls_autorate
Long		 ll_rows
Long		ll_ediCompanyId
Long		ll_shipmentId
Long		i
String	ls_scac
Dec		lc_rate
Datastore 	lds_Profile
Datastore	lds_204Profile

boolean	lb_apply
boolean	lb_doAutoRate
N_cst_licensemanager lnv_licensemanager

ll_count = upperbound(anva_ratedata)

lb_doAutoRate = false

if this.of_GetAccountingType() = n_cst_constants.cs_AccountingType_Payable then
	//don't apply rates they are for billing
	lb_apply = false
else
	lb_apply = true
end if

if lb_apply then
	CHOOSE CASE THIS.of_GetEventTypeFlag ( ) 
		CASE 	n_cst_constants.cs_ItemEventType_PerDiem 
			//don't autorate
		CASE	n_cst_constants.cs_ItemEventType_FuelSurcharge
			//don't autorate
		CASE  n_Cst_Constants.cs_itemeventtype_imported, &
				n_Cst_Constants.cs_itemeventtype_importedacc, &
				n_Cst_Constants.cs_itemeventtype_importedfreight
				
				
				//Imported item from 204 should find out which company sent the edi file(not bill to)
				//by getting the scac from the known sender of the 204. From that it should find out
				//the company id of the sender, and find out if the setting says to autorate or not.
				ll_shipmentID = this.of_getshipment( )	
					
				SELECT FIRST "importedshipments"."senderscode" 
						INTO :ls_scac
						FROM "importedshipments"  
						WHERE "importedshipments"."shipmentid" = :ll_shipmentID;
						
				IF SQLCA.SQLCode = 0 THEN 
					//success
					COMMIT;
					
					lds_Profile = CREATE datastore
					lds_Profile.dataobject = "d_ediprofile_ds"
					lds_Profile.setTransobject( SQLCA )
					
					ll_rows = lds_Profile.retrieve(  )
					commit;
					
					//find a row whos scac matches
					IF ll_rows > 0 THEN
						i = lds_Profile.find( "scac = '"+ls_scac+"'", 1, ll_rows )
					END IF
					
					//if found a row
					IF i > 0 THEN
						ll_coId = lds_profile.getItemNumber( i, "companyid" )
						
						
						lds_204Profile = CREATE datastore
						lds_204Profile.dataobject = "d_204companysettings"
						lds_204Profile.setTransobject( SQLCA )
						ll_rows = lds_204Profile.retrieve( ll_coId )
						
					END IF
					
					//we found it
					IF i > 0 AND ll_rows > 0 THEN
						ls_autoRate = lds_204Profile.getItemString( ll_rows, "edi204profile_autorate" )
					
						IF ls_autorate = "Yes" THEN
							lb_doAutoRate = TRUE
						END IF
					END IF
					
					DESTROY lds_204Profile
					Destroy lds_Profile
					
				ELSEIF SQLCA.SQLCode = 100 THEN
					//fetched row not found
					COMMIT;
				ELSEIF SQLCA.SQLCode = -1 THEN
					//error
					ROLLBACK;
				END IF

		CASE ELSE
			lb_doAutoRate = true

	END CHOOSE
	
	IF lb_doAutorate THEN
		choose case this.of_gettype()
	
				case n_cst_constants.cs_itemtype_freight, n_cst_constants.cs_itemtype_accessorial
					
					//first try a direct match on ratecodename
					for ll_index = 1 to ll_count
						if isvalid(anva_ratedata[ll_index]) then
							
							if anva_ratedata[ll_index].of_getitemtype() <> this.of_gettype() then
								continue
							end if
	
							if ll_count = 1 then
								ll_found = ll_index
								exit
							else
								//if there is more than one then search through the rate objects for the 
								//matching one
								
								if anva_ratedata[ll_index].of_getcodename() = this.of_GetRatecodename() then
									ll_found = ll_index
									exit
								end if				
							end if
						end if
					next
					
					//if direct match not found then look for other criteria
					if ll_found > 0 then
						//found direct match 
					else
						for ll_index = 1 to ll_count 
							if isvalid(anva_ratedata[ll_index]) then
								
								if anva_ratedata[ll_index].of_getitemtype() <> this.of_gettype() then
									continue
								end if
		
								if ll_count = 1 then
									ll_found = ll_index
									exit
								else
									//if there is more than one then search through the rate objects for the 
									//matching one
									
									if (anva_ratedata[ll_index].of_getratetype() = this.of_getratetype()) or & 
										(this.of_getratetype() = appeon_constant.cs_RateUnit_Code_None) or &
										(this.of_getratetype() <> appeon_constant.cs_RateUnit_Code_None and &
										anva_ratedata[ll_index].of_getcodename() = this.of_GetRatecodename()) then
										ll_found = ll_index
										exit
									end if				
								end if
							end if
						next
					end if
					
					if ll_found > 0 then 
						
						if this.of_getmiles() > 0 then
							//no change
						else
							if anva_ratedata[ll_found].of_useshipmiles() then
								this.of_setmiles(anva_ratedata[ll_found].of_gettotalmiles())
							end if
						end if
						
						if anva_ratedata[ll_found].of_useminimum() then
							this.of_setratetype(appeon_constant.cs_RateUnit_Code_Minimum)
						elseif anva_ratedata[ll_found].of_usemaximum() then
							this.of_setratetype(appeon_constant.cs_RateUnit_Code_Maximum)
						else
							this.of_setratetype(anva_ratedata[ll_found].of_getratetype())
						end if
						
						lc_rate = anva_ratedata[ll_found].of_getrate()
						this.of_setrate(lc_rate)
						//this.of_setrate(anva_ratedata[ll_found].of_getrate())
						ls_description = anva_ratedata[ll_found].of_getDescription()
						//only replace description if there is one on the ratetable
						if len(trim(ls_description)) > 0 then
							this.of_setdescription(ls_description)
						end if
						if this.of_gettype() = anva_ratedata[ll_found].of_getitemtype() then
							ll_amounttype = anva_ratedata[ll_found].of_getAmounttype()
							if isnull(ll_amounttype) or ll_amounttype = 0 then
								//don't set
							else
								this.of_setAmounttype(anva_ratedata[ll_found].of_getAmounttype())
							end if
						end if
						this.of_setratecodename(anva_ratedata[ll_found].of_getcodename())
						
						ls_taglist = 'BillTo=' + string(anva_ratedata[ll_found].of_getbilltoid()) + "," + &
										'Originzone=' + anva_ratedata[ll_found].of_getOriginZone() + "," + &
										'Destinationzone=' + anva_ratedata[ll_found].of_getDestinationZone()
			
						this.of_setTaglist(ls_taglist)
						
						this.of_setlastratedby(gnv_app.of_getuserid())
					end if
	
		end choose
	END IF
	
	
end if


return ll_found


end function

public function integer of_autorateandapply ();integer	li_return = 1
Long		ll_Null
					
n_cst_ratedata	lnva_ratedata[]
n_cst_AnyArraySrv		lnv_ArraySrv

SetNull ( ll_Null )

if li_return = 1 then
	
	THIS.of_SetPUEvent ( ll_Null )
	THIS.of_SetDelEvent ( ll_Null )
			
	if this.of_autorate ( lnva_rateData) = -1 then
		li_Return = -1
		//error	
	else
		
		setpointer(HourGlass!)
		this.of_applyautorate ( lnva_rateData)
		lnv_ArraySrv.of_Destroy ( lnva_RateData )
	END IF
	
end if

return li_return


end function

public function integer of_clearbillratedata ();String	ls_Null
SetNull ( ls_Null )
this.of_setratetype ( appeon_constant.cs_RateUnit_Code_None )
this.of_setrateCodeName ( ls_Null )

RETURN 1
end function

public function integer of_clearpayratedata ();this.of_setPayratetype ( appeon_constant.cs_RateUnit_Code_None )


RETURN 1
end function

public function boolean of_sendnotification (long al_id);// RDT 5-13-03 moved from of_SendNotification() 
Boolean	lb_Return
Long		ll_AmountTypeID

n_cst_beo_AmountType		lnv_AmountType
n_cst_bso_transactionManager	lnv_Trans

lnv_Trans = CREATE n_cst_bso_transactionManager


IF THIS.of_GetBillingamount( ) > 0 THEN  // only going to send if there is $$$ to report on
	ll_AmountTypeID = THIS.of_GetAmountType ( )
	
	IF ll_AmountTypeID > 0 THEN
		IF lnv_Trans.of_GetAmountType ( ll_AmountTypeID , lnv_AmountType ) = 1 THEN
			lb_Return  = lnv_AmountType.of_GetNotify ( ) = 'T' AND THIS.of_GetAccountingtype( ) <> n_cst_constants.cs_accountingtype_payable
				
		END IF
	END IF
	
	//DESTROY ( lnv_AmountType )
	DESTROY ( lnv_Trans )
END IF

RETURN lb_Return
end function

public function integer of_setnote (string as_value);RETURN of_SetAny ( "note", as_Value )
end function

public function integer of_getamounttypecategory ();n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
n_cst_beo_amounttype lnv_amounttype
Integer	li_Return, &
			li_id, &
			li_category

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

li_id = this.of_getamounttype()

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_Beo = lnv_Cache.getBeo("amounttype_id = " + string(li_id) )
	IF isValid(lnv_Beo) THEN
		li_Return = 1            
	END IF

END IF

if li_return = 1 then
	lnv_amounttype = lnv_Beo
	li_category = lnv_amounttype.of_getcategory()
else
	setnull(li_category)
end if

return li_category

end function

public function integer of_applyratelookupresults (n_cst_rate_attribs anv_attribs);/*
	THIS is used by the old rate query window. Not Auto Rating.
	
	
*/

// check to see if there is a rate code we can use

// if that yielded results stop processing
// else apply the data in pieces.

n_cst_RateData	lnva_RateData[]
n_cst_beo_Item	lnv_SourceItem
lnv_SourceItem = CREATE n_cst_beo_Item

Boolean	lb_Continue = TRUE
String	ls_RateCode

n_ds	lds_Source

lds_Source = anv_attribs.of_GetDataStore ( )

lnv_SourceItem.of_SetSource ( lds_Source )
lnv_SourceItem.of_SetSourceid ( anv_attribs.of_GetapplyID() )

ls_RateCode = lnv_SourceItem.of_Getratecodename( )
IF len ( ls_RateCode ) > 0 THEN
	THIS.of_Setratecodename( ls_RateCode ) 
	IF THIS.of_autorate(lnva_Ratedata) < 0 then
		THIS.of_SetRatecodename( "" )
	ELSE
		IF THIS.of_Applyautorate( lnva_RateData ) = 1 THEN					
			lb_Continue = FALSE					
		END IF
	END IF		
END IF

IF lb_Continue THEN
	THIS.of_SetRateType ( lnv_SourceItem.of_GetRateType( ) )
	THIS.of_SetRate ( lnv_SourceItem.of_GetRate( ) )
	THIS.of_Setany( "di_our_rate", lnv_SourceItem.of_GetRate( ) ) // I am doing this twice because it will not stick 
	// if the setting of the rate results in a zero amount... ie per pound rate without any weight on the item
	THIS.of_SetDescription ( lnv_SourceItem.of_getdescription( ) )		
	THIS.of_SetRatecodename( "CUSTOM" )
END IF
	

n_cst_AnyarraySrv	lnv_Arraysrv
lnv_ArraySrv.of_Destroy ( lnva_RateData )			
DESTROY ( lnv_SourceItem )


RETURN 1
end function

public function decimal of_getfscrate ();RETURN This.of_GetValue ( "disp_itemlinkfscrate_rate", TypeDecimal! )
end function

public function integer of_setfscrate (decimal ac_value);RETURN of_SetAny ( "disp_itemlinkfscrate_rate", ac_Value )
end function

public function integer of_setfsctype (string as_value);RETURN of_SetAny ( "disp_itemlinkfscrate_type", as_Value )
end function

public function string of_getfscratetype ();RETURN This.of_GetValue ( "disp_itemlinkfscrate_type", TypeString! )
end function

public function integer of_setfscitemid (long al_value);RETURN This.of_SetAny ( "disp_itemlinkfscrate_di_itemfsc_id", al_Value )
end function

public function integer of_makefuelsurcharge (boolean ab_useoldvalue);//written by Dan 1-3-2006. Now if TRUE is passed in then it uses the old value
//for lc_surcharge instead of the current one.

//Returns:  1, -1
//Currently, the function will notify on failure, but this should be 
//changed when the error service is available.

Decimal			lc_Surcharge
Decimal {2}		lc_TargetAmount
//nwl 8/23/04 - prior to this the lc_rate was limited to 2 decimal places
//I removed it because of truncation for per mile rate
//Decimal {2}			lc_Rate
Decimal 			lc_Rate
Decimal			lc_FSCRate
Decimal {2}		lc_miles
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_beo_Shipment		lnv_Shipment
n_cst_beo_Company			lnv_Company
n_cst_bso_Rating			lnv_Rating
n_cst_RateData				lnv_RateData

String	ls_MessageHeader = "Create Fuel Surcharge", &
			ls_ErrorText = "Could not process request.", &
			ls_Description, &
			ls_CustomDescription, &
			ls_SurchargeType, &
			ls_RateType
			
String	lsa_RateList[]
String	ls_RateCodeName
String	ls_RateDescription
Long		ll_itemId
Long		ll_AmountType
Long		ll_CoID
Boolean	lb_CustomDescription
Boolean	lb_HasSurcharge

n_cst_setting_recalcFuelSurcharge lnv_recalcFsc

lnv_recalcFsc = CREATE n_cst_setting_recalcFuelSurcharge

Integer	li_Return = 1

lnv_Rating = CREATE n_cst_bso_Rating
lnv_RateData = CREATE n_cst_RateData


//Get a reference to this item's shipment
lnv_Shipment = inv_Shipment

//If the shipment is valid, get the NetFreightCharges for calculation purposes.
//If not valid, fail.

IF IsValid ( lnv_Shipment ) THEN

	//2-9-07Modified By dan to allow fuel surcharge calculation if user privs say you can edit a billed shipments charges
	Boolean	lb_canMOdifyRatesOnBill
	IF gnv_app.of_getprivsmanager( ).of_getUserpermissionfromfn( appeon_constant.cs_ModifyBilledShipRates , lnv_shipment ) = 1 THEN
		lb_canMOdifyRatesOnBill = true
	END IF
	///////////////////

	IF lnv_Shipment.of_AllowEditBill ( ) = FALSE THEN

		IF lnv_shipment.of_isBilled( ) AND lb_canMOdifyRatesOnBill THEN
			//this condition was added on 2-9-07 to allow them to do it.
		ELSE
			li_Return = -1
			ls_ErrorText = "Your user permissions do not allow you to edit billing "+&
				"information for this shipment."
		END IF
	ELSEIF lnv_Shipment.of_AllowItemCharges ( ) = FALSE THEN

		li_Return = -1
		ls_ErrorText = "The billing format selected for this shipment does "+&
			"not allow item-level charges."

	ELSE
//		lc_TargetAmount = lnv_Shipment.of_GetFuelSurchargeableAmount ( )

	END IF

ELSE
	li_Return = -1

END IF

// look for custom fuel surcharge 
IF li_Return = 1 THEN
	IF lnv_Shipment.of_GetBillToCompany ( lnv_Company , TRUE ) > 0 THEN
		IF lnv_Company.of_HasSource ( ) THEN
			ll_CoID = lnv_Company.of_GetID ( )
			IF lnv_Company.of_HasCustomFuelSurcharge ( ) THEN
				lc_Surcharge = lnv_Company.of_GetCustomFuelSurcharge ( )
				ls_SurchargeType = lnv_Company.of_GetFuelSurchargeType ( )
				lb_HasSurcharge = TRUE
			END IF
		END IF
	END IF
END IF


IF lb_HasSurcharge AND lc_Surcharge = 0 THEN
	li_Return = 0
END IF



IF li_Return = 1 THEN
	// Get Rate Code
	IF lnv_Rating.of_GetCodeDefaultList ( ll_CoID , appeon_constant.cl_FuelSurcharge_list , lsa_RateList ) > 0 THEN	
		lnv_RateData.of_SetCodeName ( lsa_RateList[1] )
	
		ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
		ls_RateCodeName = lsa_RateList[1]
		ls_RateDescription = lnv_Rating.of_GetRateDescription ( lnv_RateData )
	END IF
	
END IF


//If ok to this point, attempt to determine Fuel Surcharge Percentage

IF li_Return = 1 THEN
	IF NOT lb_HasSurcharge THEN
		CHOOSE CASE lnv_ShipmentManager.of_GetFuelSurcharge ( lc_Surcharge )
		
		CASE 1
			//Proceed
			ls_SurchargeType = lnv_ShipmentManager.of_GetFuelSurchargeType ( )
		CASE 0  //Value not defined (or not defined properly)
			li_Return = -1
			ls_ErrorText = "You must define the Fuel Surcharge value in System Settings first."
		
		CASE ELSE  //-1
			li_Return = -1
			ls_ErrorText = "Could not determine Fuel Surcharge percentage."
		
		END CHOOSE
	END IF

END IF


//If ok to this point, attempt to determine if there's a Custom Description

IF li_Return = 1 THEN

	CHOOSE CASE lnv_ShipmentManager.of_GetCustomFuelSurchargeDescription ( ls_CustomDescription )
	
	CASE 1
		lb_CustomDescription = TRUE
	
	CASE 0  //Value not defined
		//User wants default description -- Proceed
	
	CASE ELSE  //-1
		li_Return = -1
		ls_ErrorText = "Could not determine Custom Fuel Surcharge Description."
	
	END CHOOSE

END IF


//If ok to this point, calculate the surcharge amount and set the appropriate fields.

IF li_Return = 1 THEN
	THIS.of_SetEventTypeFlag ( n_Cst_Constants.cs_ItemEventType_FuelSurcharge ) 


	//added by Dan 1-3-2006 to find out if the current rate is different from the rate used to 
	//calculate the FSC.
	//if the setting is true, then use the new value.
	IF ab_useOldValue THEN
		lc_FSCRate = this.of_getFScrate( )
		IF not IsNULL( lc_FSCRate ) THEN
			lc_Surcharge = lc_FSCRate
		END IF
	END IF
	//-------------------------

	lc_TargetAmount = lnv_Shipment.of_GetFuelSurchargeableAmount ( ls_SurchargeType )

	choose case ls_SurchargeType
		case 'PERCENTAGE'
			
			lc_Rate = lc_TargetAmount * ( lc_Surcharge / 100 )
			ls_RateType = appeon_constant.cs_Rateunit_code_Flat
			
			IF ls_RateDescription <> "" THEN
				ls_Description =  ls_RateDescription 
			ELSE
				IF lb_CustomDescription THEN
					ls_Description = ls_CustomDescription
				ELSE
					ls_Description = "FUEL SURCHARGE ( " + String ( lc_Surcharge, "0.0###########" ) +&
						"% OF " + String ( lc_TargetAmount, "[currency]" ) + " )"
				END IF
			END IF

		case 'PERMILE'
			
			ls_RateType = appeon_constant.cs_Rateunit_code_PerMile
			lc_Rate = lc_Surcharge
			lc_miles = THIS.of_getMiles()
			if lc_miles = 0 then
				inv_shipment.of_GetTotalMiles(lc_miles)
			end if
			IF ls_RateDescription <> "" THEN
				ls_Description =  ls_RateDescription 
			ELSE
				IF lb_CustomDescription THEN
					ls_Description = ls_CustomDescription
				ELSE
					ls_Description = "FUEL SURCHARGE ( " + String ( lc_Surcharge, "0.0###########" ) +&
						"/Mile for " + string( lc_miles, "0#######" ) + " miles )"
				END IF
			END IF

			
	end choose
	
	ll_itemId = this.of_getId( )						//added by dan to save the item id out to the disp_itemlinktofscRate table
	
	
	this.of_SetfscItemId( ll_itemId )				//added by dan to save fuel surcharge rate used to calc
	this.of_Setfscrate( lc_surcharge )				//added by dan to save fuel surcharge rate used to calc
	this.of_setfscType( ls_SurchargeType )			//added by dan to save type of the rate used for calculation
	This.of_SetRateType ( ls_RateType )
	This.of_SetDescription ( ls_Description )
	This.of_SetQuantity ( 1 )
	This.of_SetRate ( lc_Rate )
	
	
	if ls_SurchargeType = "PERMILE" then
		This.of_SetMiles(lc_miles)
//		This.of_SetAmount(lc_Rate * lc_miles)
		This.of_SetRate ( lc_Rate )
	end if
	
	IF ll_AmountType > 0 THEN
		THIS.of_SetAmountType ( ll_AmountType )
	END IF
	
	IF ls_RateCodeName <> "" THEN
		THIS.of_SetRateCodeName ( ls_RateCodeName )
	END IF
	
//	Amount will auto-process

END IF

//If there was an error condition, report it.

IF li_Return = -1 THEN

	ls_ErrorText += "~n~nRequest cancelled."
	MessageBox ( ls_MessageHeader, ls_ErrorText, Exclamation! )

END IF

DESTROY	lnv_Rating
DESTROY	lnv_RateData
DESTROY lnv_Company
Destroy	lnv_recalcFsc

//2-15-2006 Mod by Dan, if for whatever reason teh lc_rate is not one,( lc_rate is zero or something went wrong)
//then remove this item from the shipment list, becuase we don't want to see it if it is zero.
IF li_Return = 0  THEN  // Rick modifid this from ( IF li_Return <> 1 THEN ) b.c. attempting to modify a shipment that had been billed 
								// was causing the FSC to be deleted.
//IF lc_Surcharge = 0  THEN
	lnv_Shipment.of_Removeitem( THIS )
END IF


RETURN li_Return
end function

public function integer of_resetfuelsurcharge ();//2-16-2006 written by dan and rick to replace lnv_shipment.of_removeItem( lnv_items ) calls when the system setting
//to of_recalcSurcharges is set to 'no'. If the setting is yes, then this function makes the of_removeItem call to maintian
//old working code.  Much of this code was stolen from of_makeFuelSurcharge


//Returns:  1, -1
//Currently, the function will notify on failure, but this should be 
//changed when the error service is available.

Decimal			lc_Surcharge
Decimal {2}		lc_TargetAmount
//nwl 8/23/04 - prior to this the lc_rate was limited to 2 decimal places
//I removed it because of truncation for per mile rate
//Decimal {2}			lc_Rate
Decimal 			lc_Rate
Decimal			lc_FSCRate
Decimal {2}		lc_miles
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_beo_Shipment		lnv_Shipment
n_cst_beo_Company			lnv_Company
n_cst_bso_Rating			lnv_Rating
n_cst_RateData				lnv_RateData




String	ls_MessageHeader = "Create Fuel Surcharge", &
			ls_ErrorText = "Could not process request.", &
			ls_Description, &
			ls_CustomDescription, &
			ls_SurchargeType, &
			ls_RateType
			
String	lsa_RateList[]
String	ls_RateCodeName
String	ls_RateDescription
Long		ll_itemId
Long		ll_AmountType
Long		ll_CoID
Boolean	lb_CustomDescription
String	ls_value


n_cst_setting_recalcFuelSurcharge lnv_recalcFsc

lnv_recalcFsc = CREATE n_cst_setting_recalcFuelSurcharge

ls_value = lnv_recalcFsc.of_GetValue( )

Integer	li_Return = 1

lnv_Rating = CREATE n_cst_bso_Rating
lnv_RateData = CREATE n_cst_RateData


//Get a reference to this item's shipment
lnv_Shipment = inv_Shipment


//THis maintains old function ality if the setting is yes.  We replaced calls to lnv_shipment.of_removeItem with
//calls to of_reset on the items it was removing.
IF ls_Value = "Yes" AND isvalid( lnv_shipment ) THEN
	lnv_shipment.of_removeItem( THIS )
ELSE
	
	//If the shipment is valid, get the NetFreightCharges for calculation purposes.
	//If not valid, fail.
	
	IF IsValid ( lnv_Shipment ) THEN
	
		//2-9-07Modified By dan to allow fuel surcharge calculation if user privs say you can edit a billed shipments charges
		Boolean	lb_canMOdifyRatesOnBill
		IF gnv_app.of_getprivsmanager( ).of_getUserpermissionfromfn( appeon_constant.cs_ModifyBilledShipRates , lnv_shipment ) = 1 THEN
			lb_canMOdifyRatesOnBill = true
		END IF
		///////////////////
	
		IF lnv_Shipment.of_AllowEditBill ( ) = FALSE THEN
			IF lnv_shipment.of_isbilled( ) AND lb_canmodifyRatesOnBill THEN
				//this condition was added to allow them to change fsc if  on 2-9-07 by dan
			ELSE
		
				li_Return = -1
				ls_ErrorText = "Your user permissions do not allow you to edit billing "+&
					"information for this shipment."
			END IF
		ELSEIF lnv_Shipment.of_AllowItemCharges ( ) = FALSE THEN
	
			li_Return = -1
			ls_ErrorText = "The billing format selected for this shipment does "+&
				"not allow item-level charges."
	
		ELSE
	//		lc_TargetAmount = lnv_Shipment.of_GetFuelSurchargeableAmount ( )
	
		END IF
	
	ELSE
		li_Return = -1
	
	END IF
	
	// look for custom fuel surcharge 
	IF li_Return = 1 THEN
		IF lnv_Shipment.of_GetBillToCompany ( lnv_Company , TRUE ) > 0 THEN
			IF lnv_Company.of_HasSource ( ) THEN
				ll_CoID = lnv_Company.of_GetID ( )
			END IF
		END IF
	END IF
	
	
	IF li_Return = 1 THEN
		// Get Rate Code
		IF lnv_Rating.of_GetCodeDefaultList ( ll_CoID , appeon_constant.cl_FuelSurcharge_list , lsa_RateList ) > 0 THEN	
			lnv_RateData.of_SetCodeName ( lsa_RateList[1] )
		
			ll_AmountType = lnv_Rating.of_GetAmountType ( lnv_RateData )
			ls_RateCodeName = lsa_RateList[1]
			ls_RateDescription = lnv_Rating.of_GetRateDescription ( lnv_RateData )
		END IF
		
	END IF
	
	
	//If ok to this point, attempt to determine Fuel Surcharge Percentage
	
	IF li_Return = 1 THEN

			ls_SurchargeType = lnv_ShipmentManager.of_GetFuelSurchargeType ( )
	
	END IF
	
	
	//If ok to this point, attempt to determine if there's a Custom Description
	
	IF li_Return = 1 THEN
	
		CHOOSE CASE lnv_ShipmentManager.of_GetCustomFuelSurchargeDescription ( ls_CustomDescription )
		
		CASE 1
			lb_CustomDescription = TRUE
		
		CASE 0  //Value not defined
			//User wants default description -- Proceed
		
		CASE ELSE  //-1
			li_Return = -1
			ls_ErrorText = "Could not determine Custom Fuel Surcharge Description."
		
		END CHOOSE
	
	END IF
	
	
	//If ok to this point, calculate the surcharge amount and set the appropriate fields.
	
	IF li_Return = 1 THEN
		THIS.of_SetEventTypeFlag ( n_Cst_Constants.cs_ItemEventType_FuelSurcharge ) 
	
		lc_TargetAmount = lnv_Shipment.of_GetFuelSurchargeableAmount ( ls_SurchargeType )
	
		choose case ls_SurchargeType
			case 'PERCENTAGE'
				
				lc_Rate = lc_TargetAmount * ( lc_Surcharge / 100 )
				ls_RateType = appeon_constant.cs_Rateunit_code_Flat
				
				IF ls_RateDescription <> "" THEN
					ls_Description =  ls_RateDescription 
				ELSE
					IF lb_CustomDescription THEN
						ls_Description = ls_CustomDescription
					ELSE
						ls_Description = "FUEL SURCHARGE ( " + String ( lc_Surcharge, "0.0###########" ) +&
							"% OF " + String ( lc_TargetAmount, "[currency]" ) + " )"
					END IF
				END IF
	
			case 'PERMILE'
				
				ls_RateType = appeon_constant.cs_Rateunit_code_PerMile
				lc_Rate = lc_Surcharge
				lc_miles = THIS.of_getMiles()
				if lc_miles = 0 then
					inv_shipment.of_GetTotalMiles(lc_miles)
				end if
				IF ls_RateDescription <> "" THEN
					ls_Description =  ls_RateDescription 
				ELSE
					IF lb_CustomDescription THEN
						ls_Description = ls_CustomDescription
					ELSE
						ls_Description = "FUEL SURCHARGE ( " + String ( lc_Surcharge, "0.0###########" ) +&
							"/Mile for " + string( lc_miles, "0#######" ) + " miles )"
					END IF
				END IF
	
				
		end choose
		
		This.of_SetDescription ( /*ls_Description*/ "FUEL SURCHARGE" )
		This.of_SetQuantity ( 1 )
		This.of_SetRate ( lc_Rate )
		
		
		if ls_SurchargeType = "PERMILE" then
			This.of_SetMiles(lc_miles)
			This.of_SetRate ( lc_Rate )
		end if
		
	//	Amount will auto-process
	
	END IF
	
	//If there was an error condition, report it.
	
	IF li_Return = -1 THEN
	
		ls_ErrorText += "~n~nRequest cancelled."
		MessageBox ( ls_MessageHeader, ls_ErrorText, Exclamation! )
	
	END IF
END IF
DESTROY	lnv_Rating
DESTROY	lnv_RateData
DESTROY lnv_Company
Destroy	lnv_recalcFsc

RETURN li_Return
end function

public function integer of_setdontrecalcflag (boolean ab_value);ib_dontrecalc = ab_value
RETURN 1
end function

on n_cst_beo_item.create
call super::create
end on

on n_cst_beo_item.destroy
call super::destroy
end on

event constructor;call super::constructor;of_SetKeyColumn ( "di_item_id" )
is_Topic = "ITEM"
is_documenttype = appeon_constant.cs_acc			// RDT 092602
end event

event ue_getvalueany;call super::ue_getvalueany;//Extending Ancestor to provide attribute support for this class.

Integer	li_Return

li_Return = AncestorReturnValue

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_Attribute ) )

		CASE "ID"
			aa_Value = This.of_GetId ( )

		CASE "SHIPMENTID", "TMP"
			aa_Value = This.of_GetShipment ( )
			
		CASE "TYPE"
			aa_Value = This.of_GetType ( )
			
		CASE "QTY", "QUANTITY"
			aa_Value = This.of_GetQuantity ( )
			
		CASE "DESCRIPTION"
			aa_Value = This.of_GetDescription ( )
			
		CASE "WEIGHTPERUNIT"		
			aa_Value = This.of_GetWeightPerUnit ( )
			
		CASE "TOTALWEIGHT"
			aa_Value = This.of_getTotalWeight  ( )
			
		CASE "RATETYPE"
			aa_Value = This.of_GetRateType ( )
			
		CASE "RATE"
			aa_Value = This.of_GetRate ( )
			
		CASE "CHARGES"
			aa_Value = This.of_GetBillingAmount ( )			//(Freight or Access)

		CASE "FREIGHTCHARGES"
			aa_Value = This.of_GetFreightCharges ( )			//(Freight only)

		CASE "ACCESSORIALCHARGES"
			aa_Value = This.of_GetAccessorialCharges ( )		//(Access only)
			
		CASE "PAYABLERATETYPE", "PAYRATETYPE"
			aa_Value = This.of_GetPayRateType ( )
			
		CASE "PAYABLERATE", "PAYRATE"
			aa_Value = This.of_GetPayRate ( )
			
		case "PAYABLES"
			aa_Value = This.of_GetPayableAmount ( )			//(Freight or Access)
			
		CASE "FREIGHTPAYABLES"
			aa_Value = This.of_GetFreightPayable ( )			//(Freight only)

		CASE "ACCESSORIALPAYABLES"
			aa_Value = This.of_GetAccessorialPayable ( )		//(Access only)
			
		CASE "MILES"
			aa_Value = This.of_GetMiles ( )
			
		CASE "REFERENCE", "REFERENCENUMBER"
			aa_Value = This.of_GetReference ( )  //Either BL or Ref (Freight or Access)

		CASE "BILLOFLADING", "BLNUM", "BLNUMBER"
			aa_Value = This.of_GetBLNum ( )  //BL Only  (Freight only)

		CASE "REFNUM"
			aa_Value = This.of_GetRefNum ( ) //Ref Only (Access only)
			
		CASE "HAZMAT"
			aa_Value = This.of_GetHazmat ( )
			
		CASE "PICKUPEVENTID"
			aa_Value = This.of_GetPickupEvent ( )
			
		CASE "DELIVEREVENTID"
			aa_Value = This.of_GetDeliverEvent ( )
			
		CASE "AMOUNTTYPEID"
			aa_Value = This.of_GetAmountType ( )
			
		CASE "AMOUNTTYPENAME"
			aa_Value = This.of_GetAmountTypeName ( )
			
		Case "ROWNUMBER"
			aa_Value = THIS.of_getSourcerow( )
		
		CASE "NOTE", "NOTES"
			aa_Value = THIS.of_getnote( )	// S.A.T 04/12/06
		
		CASE "RATECODENAME"
			aa_Value = THIS.of_GetRatecodename( )
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
			
		CASE "QTY" , "QUANTITY"
			as_Format = "0.0####"
			
		CASE "RATE" , "CHARGES", "FREIGHTCHARGES", "ACCESSORIALCHARGES", "PAYABLERATE", "PAYABLE"
			as_Format = "0.00##"
			
		CASE "WEIGHTPERUNIT" , "TOTALWEIGHT", "MILES"
			as_Format = "0"
						
			
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
			
		CASE "TYPE"

			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.

				CASE "L"
					as_FormattedValue = "FREIGHT"
					
				CASE "A"
					as_FormattedValue = "ACCESS."
					
				CASE ELSE //Unexpected value, including null.
					as_FormattedValue = ""
					
			END CHOOSE
			
		CASE "RATETYPE", "PAYRATETYPE", "PAYABLERATETYPE"
			
			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.

				case appeon_constant.cs_RateUnit_Code_Flat
					as_FormattedValue = appeon_constant.cs_RateUnit_Flat
					
				case appeon_constant.cs_RateUnit_Code_Minimum
					as_FormattedValue = appeon_constant.cs_RateUnit_Minimum
					
				case appeon_constant.cs_RateUnit_Code_Maximum
					as_FormattedValue = appeon_constant.cs_RateUnit_Maximum
					
				case appeon_constant.cs_RateUnit_Code_PerUnit
					as_FormattedValue = appeon_constant.cs_RateUnit_PerUnit
					
				case appeon_constant.cs_RateUnit_Code_Gallon
					as_FormattedValue = appeon_constant.cs_RateUnit_Gallon
					
				case appeon_constant.cs_RateUnit_Code_Piece
					as_FormattedValue = appeon_constant.cs_RateUnit_Piece
					
				case appeon_constant.cs_RateUnit_Code_Ton
					as_FormattedValue = appeon_constant.cs_RateUnit_Ton
					
				case appeon_constant.cs_RateUnit_Code_100Pound
					as_FormattedValue = appeon_constant.cs_RateUnit_100Pound
					
				case appeon_constant.cs_RateUnit_Code_Pound
					as_FormattedValue = appeon_constant.cs_RateUnit_Pound
					
				case appeon_constant.cs_RateUnit_Code_PerMile
					as_FormattedValue = appeon_constant.cs_RateUnit_PerMile
					
				case appeon_constant.cs_RateUnit_Code_Class
					as_FormattedValue = appeon_constant.cs_RateUnit_Class
					
				case else
					as_FormattedValue =  appeon_constant.cs_RateUnit_None
	
			END CHOOSE
			
		CASE "HAZMAT"

			CHOOSE CASE UPPER ( Trim ( String ( aa_value ) ) )
				//String ( ) is necessary to prevent crash on null value for any variable.
						
				CASE "T"
					as_FormattedValue = "HAZMAT"
					
				CASE "F"
					as_FormattedValue = ""
					
				CASE ELSE //unexpected value, including null
					as_FormattedValue = ""

			END CHOOSE
			
		CASE ELSE
			li_Return = 0
			
	END CHOOSE
END IF 

RETURN li_Return
end event

event ue_setvalueany;call super::ue_setvalueany;Int	li_Return 

IF Len ( as_attribute ) = 0 AND  Len ( String ( aa_value ) ) = 0 THEN
	RETURN 1 // so we can check that the event exists w. a 'triggerevent' call
END IF


CHOOSE CASE Upper ( as_attribute )
		
	CASE "DESCRIPTION"
		li_Return = THIS.of_setdescription(  String ( aa_value )  ) 
		
	CASE "TOTALWEIGHT"
		li_Return = THIS.of_setTotalWeight (  Dec ( aa_value )  ) 		
	
	CASE "QTY", "QUANTITY"
		li_Return = This.of_SetQuantity ( Integer ( aa_Value ) )
			
	CASE "NOTE" , "NOTES"
		li_Return = This.of_SetNote ( String ( aa_Value ) )
		
	CASE "WEIGHTPERUNIT"		
		li_Return = This.of_SetWeightPerUnit ( Dec ( aa_Value ) )
		
	CASE "TOTALWEIGHT"
		li_Return = This.of_SetTotalWeight  (Dec( aa_Value ) )
		
	CASE "RATETYPE"
		li_Return = This.of_SetRateType ( String ( aa_Value ) )
		
	CASE "RATE"
		li_Return = This.of_SetRate ( Dec ( aa_Value ) )
		
	CASE "CHARGES"
		li_Return = This.of_SetAmount ( Dec ( aa_Value )	)		//(Freight or Access)
		
	CASE "PAYABLERATETYPE", "PAYRATETYPE"
		li_Return = This.of_SetPayRateType ( String ( aa_Value ) )
		
	CASE "PAYABLERATE", "PAYRATE"
		li_Return = This.of_SetPayRate (Dec ( aa_Value ) )
		
	case "PAYABLES"
		li_Return = This.of_SetPayableAmount ( Dec ( aa_Value ) )			//(Freight or Access) 
		
	CASE "MILES"
		li_Return = This.of_SetMiles ( Dec ( aa_Value ) )
		
	CASE "BILLOFLADING", "BLNUM", "BLNUMBER"
		li_Return = This.of_SetBLNum ( String ( aa_Value ) )  //BL Only  (Freight only)

	CASE "REFNUM"
		li_Return = This.of_SetRefNum ( String (aa_Value ) ) //Ref Only (Access only)
		
	CASE "HAZMAT"
		li_Return = This.of_SetHazmat ( String ( aa_Value ) )
		
	CASE "PICKUPEVENTID"
		li_Return = This.of_SetPuEvent ( Long ( aa_Value ) )
		
	CASE "DELIVEREVENTID"
		li_Return = This.of_SetDelEvent ( Long ( aa_Value ) )
		
	CASE "AMOUNTTYPEID"
		li_Return = This.of_SetAmountType ( Long ( aa_Value ) )
		
	CASE "RATECODENAME"
		li_Return = THIS.of_SetRatecodename( String ( aa_value ) )
		
	CASE ELSE
		li_Return = 0
		
END CHOOSE

RETURN li_Return
end event

event ue_getobject;call super::ue_getobject;// zmc - 2/13/04

//Extending Ancestor to provide object support for this class.
//See ancestor script for explanation of return codes.

Integer	li_Return

Any		laa_Beo[]
n_cst_beo_Event		lnv_Event

li_Return = AncestorReturnValue
aaa_Beo = laa_Beo

IF li_Return = 0 THEN

	li_Return = 1 //This gets set back to zero if the attribute is not found.

	CHOOSE CASE UPPER ( Trim ( as_ObjectName ) )

	CASE "PICKUPEVENT"
		
		CHOOSE CASE This.of_GetPickupEvent(lnv_Event)
				
			CASE 1  //Request resolved successfully.
				aaa_Beo [ 1 ] = lnv_Event
			CASE 0  //Pickupevent is not specified (null).
				//Leave the array empty, but return 1
			CASE ELSE
				li_Return = -1
				
		END CHOOSE

	CASE "DELIVEREVENT"
		
		CHOOSE CASE This.of_GetDeliverEvent(lnv_Event)
				
			CASE 1  //Request resolved successfully.
				aaa_Beo [ 1 ] = lnv_Event
			CASE 0  //Deliverevent is not specified (null).
				//Leave the array empty, but return 1
			CASE ELSE
				li_Return = -1
				
		END CHOOSE

	CASE ELSE
		li_Return = 0
			
	END CHOOSE

END IF

RETURN li_Return
end event

