$PBExportHeader$n_cst_edi_204_record.sru
forward
global type n_cst_edi_204_record from n_base
end type
end forward

global type n_cst_edi_204_record from n_base
end type
global n_cst_edi_204_record n_cst_edi_204_record

type variables
String   	is_Identifyer
String   	is_ShipperName
String   	is_ConsigneeName
String	is_BillToName
String	is_PONum
String	is_CustomerOrder
String	is_Bol
String	is_ShipmentNotes
String	is_BillNotes
String	is_ShipmentDate
String	is_PickUpDate
String	is_Weight
String	is_WeightQualifier
String	is_ladingQuantity
String	is_ComodityDescription
String	is_DockName
String	is_MethodOfPayment
String	is_TotalCharge
String	is_EDIShipmentIDNumber
String	is_OrderType
String	is_ShipmentScac
String	is_DeliverDate
String	is_DeliverTime
String	is_PickupTime
String	is_Custom1
String	is_Custom2
String	is_Custom3
String	is_Custom4
String	is_Custom5
String	is_Custom6
String	is_Custom7
String	is_Custom8
String	is_Custom9
String	is_Custom10
Long	il_ShipmentID

String	isa_FreightRate[]

Datastore	ids_Data

Boolean	ib_CrossDock

//Boolean	ib_StopMode

Long	il_StopCount

String	isa_StopTypes[]
String	isa_Sites[]

int	ii_EquipmentCount
n_cst_204_Equipment	inva_Equipment[]
n_cst_204_stopOff	inva_Stop[]


boolean	ib_Success
boolean	ib_Real204

String	is_ErrorText

n_cst_DataMapping_EDI204	inv_DataMapping


end variables

forward prototypes
public function integer of_setreference (string as_value, string as_qualifier)
public function integer of_setname (string as_value, string as_qualifier)
public function integer of_setdate (string as_value, string as_qualifier)
public function integer of_setweight (string as_weight, string as_qualifier)
public function integer of_setladingquantity (string as_quantity)
public function integer of_setdescription (string as_value)
public function string of_getblnum ()
public function string of_getref1text ()
public function string of_getref2text ()
public function string of_getref3text ()
public function string of_getdescription ()
public function long of_getstopcount ()
public function string of_getweightqualifier ()
public function long of_getsite (integer ai_index)
public function long of_setsite ()
public function integer of_addstop (string as_StopType)
public function integer of_addstopsite (string as_site)
public function long of_determinestops ()
public function integer of_getref1type ()
public function integer of_getref2type ()
public function integer of_getref3type ()
public function long of_getbilltoid ()
public function date of_getshipmentdate ()
public function string of_geteventtype (long ai_index)
public function decimal of_getweight ()
public function decimal of_getqty ()
public function integer of_setshipmentid (long al_id)
public function long of_getshipmentid ()
public function long of_setsuccessfulimportflag (boolean ab_value)
public function integer of_seterrortext (string as_text)
public function string of_geterrortext ()
public function boolean of_getsuccessfulimportflag ()
public function integer of_setnote (string as_value, string as_qualifier)
public function string of_getshipmentnote ()
public function string of_getbillnotes ()
public function date of_getpickupdate ()
public function string of_getstringsite (integer ai_index)
public function integer of_setpaymentmethod (string as_mop)
public function integer of_setequipmentdetails (string asa_record[])
public function integer of_setstopdetail (string asa_record[])
public function integer of_setreal204 (boolean ab_Value)
public function date of_getstopdate (integer ai_stopindex)
public function integer of_settotalcharge (string as_value)
public function dec of_gettotalcharge ()
public function string of_getbillformat ()
public function string of_getrequiredequipment ()
public function boolean of_isreal204 ()
public function integer of_setedishipmentidnumber (string as_value)
public function string of_getedishipmentidnumber ()
public function string of_getordertype ()
public function integer of_setordertype (string as_value)
public function time of_getstoptime (integer ai_index)
public function integer of_setshipmentscac (string as_scac)
public function string of_getshipmentscac ()
public function string of_geteventnote (integer ai_Index)
public function string of_getstopreference (integer ai_index)
private function string of_getvalue (string as_columnname)
public function date of_getdeliverdate ()
public function integer of_setfreightrate (readonly string as_index, readonly string as_Amount)
public function decimal of_getfreightrate (readonly integer ai_Item)
public function time of_getdelivertime ()
public function time of_getpickuptime ()
public function string of_getcustomtext (string as_WhichOne)
public function integer of_setcustomtext (string as_Value, string as_Qualifier)
public function string of_getattemptedbilltoname ()
end prototypes

public function integer of_setreference (string as_value, string as_qualifier);CHOOSE CASE as_Qualifier
		
	CASE "BM"
		is_bol = as_Value
		ids_Data.SetItem ( 1 , "bol" , as_Value )
		
	CASE "PO"
		is_ponum = as_Value
		ids_Data.SetItem ( 1 , "ponum" , as_Value )
		
	CASE "CR"
		is_customerorder = as_Value
		ids_Data.SetItem ( 1 , "customerorder" , as_Value )
		
END CHOOSE

RETURN 1



end function

public function integer of_setname (string as_value, string as_qualifier);CHOOSE CASE as_Qualifier
		
	CASE "SF"
		is_shippername = as_Value
		ids_Data.SetItem ( 1 , "shippername" , as_Value )
	CASE "CN"
		is_consigneename = as_Value
		ids_Data.SetItem ( 1 , "consigneename" , as_Value )
	CASE "BT"
		is_billtoname = as_Value
		ids_Data.SetItem ( 1 , "billtoname" , as_Value )
	CASE "CD"
		is_DockName = as_Value
		ids_Data.SetItem ( 1 , "DockName" , as_Value )
		ib_CrossDock = TRUE
		
END CHOOSE

THIS.of_AddStopSite ( as_value )

RETURN 1
end function

public function integer of_setdate (string as_value, string as_qualifier);CHOOSE CASE as_Qualifier
		
	CASE "38"
		
		is_shipmentdate = as_Value
		ids_Data.SetItem ( 1 , "shipmentdate" , as_Value )
		
	CASE "98"
		is_pickupdate = as_Value
		ids_Data.SetItem ( 1 , "pickupdate" , as_Value )
		
	CASE "70"
		is_deliverdate = as_Value
		//ids_Data.SetItem ( 1 , "pickupdate" , as_Value )
	
	CASE "44"
		is_deliverTime = as_Value
				
	CASE "33"
		is_PickupTime = as_Value
	
END CHOOSE

RETURN 1



end function

public function integer of_setweight (string as_weight, string as_qualifier);is_weight = as_Weight
is_weightqualifier = as_Qualifier

ids_Data.SetItem ( 1 , "weight" , as_Weight ) 
ids_Data.SetItem ( 1 , "weightqualifier" , as_Qualifier ) 

RETURN 1
end function

public function integer of_setladingquantity (string as_quantity);is_ladingquantity = as_Quantity

ids_Data.SetItem ( 1 , "ladingquantity" , as_Quantity )

Return 1
end function

public function integer of_setdescription (string as_value);is_comoditydescription = as_Value

ids_Data.SetItem ( 1 , "comoditydescription" , as_Value )

RETURN 1
end function

public function string of_getblnum ();
String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "bol" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "bol" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

RETURN UPPER ( ls_Return )
end function

public function string of_getref1text ();String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "REF1TEXT" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = Upper ( is_Bol )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

Return ls_Return 



end function

public function string of_getref2text ();String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "REF2TEXT" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = Upper ( is_ponum )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF


Return ls_Return 

end function

public function string of_getref3text ();//String	ls_Return
//
//IF ib_Real204 THEN 
//	// we will need to utilize the field mapping here later
//	ls_Return = TRIM ( Left ( is_shipmentscac , 15 ) )
//ELSE
//	ls_Return = TRIM ( Left ( is_customerorder , 15 ) )
//END IF

String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "REF3TEXT" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = Upper ( is_customerorder )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

Return ls_Return 

   

end function

public function string of_getdescription ();
String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "comoditydescription" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "comoditydescription" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

RETURN UPPER ( ls_Return )


end function

public function long of_getstopcount ();Long	ll_Return

IF ib_Real204 = FALSE THEN
	ll_Return = UpperBound ( isa_stoptypes )
ELSE 
	ll_Return = il_stopcount
END IF

RETURN ll_Return
end function

public function string of_getweightqualifier ();String	ls_Return 
IF ib_Real204 = FALSE THEN
	CHOOSE CASE  UPPER ( is_weightqualifier )
			
		CASE "LB" 
			ls_Return = appeon_constant.cs_RateUnit_Code_Pound
	END CHOOSE
END IF

RETURN ls_Return
end function

public function long of_getsite (integer ai_index);Long	ll_Return
n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

IF ib_Real204 = FALSE THEN
	IF ai_index > 0 AND ai_index <= UpperBound ( isa_Sites ) THEN
		ll_Return = gnv_cst_companies.of_Find ( isa_sites[ai_index] )
		IF ll_Return > 0 THEN
			lnv_Company.of_SetUseCache ( TRUE )
			lnv_Company.of_SetSourceRow ( ll_Return )
			ll_Return = lnv_Company.of_GetID ( )
		END IF
		
	END IF
ELSE
	IF ai_index > 0 AND ai_index <= il_stopcount THEN
		ll_Return = inva_stop[ai_Index].of_GetSite ( )
	END IF	
	
END IF

IF ll_Return <= 0 THEN
	SetNull ( ll_Return ) 
END IF

DESTROY lnv_Company

return ll_Return
end function

public function long of_setsite ();RETURN -1
end function

public function integer of_addstop (string as_StopType);isa_stoptypes[ UpperBound ( isa_stoptypes ) + 1 ] = as_StopType

RETURN 1
end function

public function integer of_addstopsite (string as_site);isa_sites[ UpperBound( isa_sites )+ 1 ] = as_site
RETURN 1
end function

public function long of_determinestops ();String	lsa_Empty[]

IF ib_Real204 = FALSE THEN
	IF ib_CrossDock THEN
		
		// reset the stop list... we may not want to do this when we further the processing
		// to allow a cross dock to be in the middle of an event sequence.
		
		isa_StopTypes = lsa_Empty
		isa_Sites = lsa_Empty
		
		
		isa_StopTypes[1] = gc_Dispatch.cs_EventType_PickUp
		isa_Sites[1] = is_shippername // ship from
		
		isa_StopTypes[2] = gc_Dispatch.cs_EventType_Deliver
		isa_Sites[2] = is_dockname
		
		isa_StopTypes[3] = gc_Dispatch.cs_EventType_PickUp
		isa_Sites[3] = is_dockname
		
		isa_StopTypes[4] = gc_Dispatch.cs_EventType_Deliver
		isa_Sites[4] = is_consigneename // Deliver to
		
	ELSE
		
		IF Len ( is_shippername ) > 0 THEN
			isa_StopTypes[1] = gc_Dispatch.cs_EventType_PickUp
			isa_Sites[1] = is_shippername // ship from
		END IF
		
		IF Len ( is_consigneename ) > 0 THEN
			isa_StopTypes[ UpperBound ( isa_StopTypes ) + 1 ] = gc_Dispatch.cs_EventType_Deliver
			isa_Sites[ UpperBound ( isa_Sites ) + 1 ] = is_consigneename
		END IF
		
	END IF
ELSE
//	THIS.of_DetermineStopsForReal204 ( ) 
END IF
	
	
RETURN 1	
	
	
end function

public function integer of_getref1type ();// 15  is Master bl #
Int	li_Return
String	ls_Type
ls_Type = inv_DataMapping.of_GetSettingForAction ( "REF1TYPE" )

IF IsNull ( ls_Type ) OR Len ( ls_Type ) = 0 OR ( Not isNumber ( ls_Type )) THEN
	li_Return = 15
ELSE
	li_Return = Long ( ls_Type )
END IF

RETURN li_Return
end function

public function integer of_getref2type ();Int	li_Return
String	ls_Type
ls_Type = inv_DataMapping.of_GetSettingForAction ( "REF2TYPE" )

IF IsNull ( ls_Type ) OR Len ( ls_Type ) = 0 OR ( Not isNumber ( ls_Type )) THEN
	li_Return = 3
ELSE
	li_Return = Long ( ls_Type )
END IF



RETURN li_Return 
end function

public function integer of_getref3type ();Int		li_Return
String	ls_Type

ls_Type = inv_DataMapping.of_GetSettingForAction ( "REF3TYPE" )

IF IsNull ( ls_Type ) OR Len ( ls_Type ) = 0 OR ( Not isNumber ( ls_Type )) THEN
	li_Return = 6
ELSE
	li_Return = Long ( ls_Type )
END IF

RETURN li_Return 

end function

public function long of_getbilltoid ();Long	ll_Return
String	ls_FindName

n_cst_beo_Company	lnv_Company

lnv_Company = CREATE n_cst_beo_Company

ls_FindName = is_billtoname

IF Len ( is_methodofpayment ) > 0 THEN
	IF is_methodofpayment = "PP" THEN
		ls_FindName = is_billtoname
	ELSEIF is_methodofpayment = "CL" THEN
		ls_FindName = is_consigneename
	END IF
END IF

ll_Return = gnv_cst_companies.of_Find ( ls_FindName ) 
IF ll_Return > 0 THEN
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceRow ( ll_Return )
	ll_Return = lnv_Company.of_GetID ( )
END IF

IF ll_Return <= 0 THEN
	SetNull ( ll_Return ) 
END IF

DESTROY lnv_Company

return ll_Return
 
end function

public function date of_getshipmentdate ();Date	ld_return
SetNull ( ld_Return )

String	ls_Temp 
				//MONTH											DAY 												
ls_Temp = Mid ( is_shipmentdate , 5 , 2 ) + "/" + Right ( is_shipmentdate , 2 ) +"/" + Left ( is_shipmentdate , 4 )

IF isDate ( ls_Temp ) THEN
	ld_Return = Date ( ls_Temp ) 
END IF

RETURN ld_Return 
end function

public function string of_geteventtype (long ai_index);String	ls_Return

IF ib_Real204 = FALSE THEN
	IF ai_index > 0 AND ai_index <= UpperBound ( isa_stoptypes[] ) THEN
		ls_Return =  isa_stoptypes[ai_index] 
	END IF
ELSE
	IF ai_index > 0 AND ai_index <= UpperBound ( inva_stop[] ) THEN
		ls_Return =  inva_stop[ai_index].of_GetStopType ( )
	END IF
END IF

IF Len ( ls_Return ) <= 0 THEN
	SetNull ( ls_Return ) 
END IF

return ls_Return
end function

public function decimal of_getweight ();Dec	lc_Return

IF isNumber ( is_weight ) THEN
	lc_Return = dec ( is_weight )
END IF


RETURN lc_Return 
end function

public function decimal of_getqty ();String	ls_Return
Dec	lc_Return = 1

ls_Return = inv_DataMapping.of_GetSource ( "ladingquantity" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "ladingquantity" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

IF isNumber ( ls_Return ) THEN
	lc_Return = Dec ( ls_Return )
END IF

RETURN lc_Return 


end function

public function integer of_setshipmentid (long al_id);il_ShipmentID = al_ID

ids_Data.SetItem ( 1 , "ShipmentID" , String ( al_ID ) )

RETURN 1
end function

public function long of_getshipmentid ();RETURN il_ShipmentID
end function

public function long of_setsuccessfulimportflag (boolean ab_value);IF ib_success THEN
	ib_success = ab_Value
END IF
RETURN 1
end function

public function integer of_seterrortext (string as_text);IF Len ( Trim ( as_Text ) ) > 0 THEN
	is_ErrorText += as_Text
END IF
RETURN 1
end function

public function string of_geterrortext ();RETURN  UPPER ( is_ErrorText )
end function

public function boolean of_getsuccessfulimportflag ();RETURN ib_Success
end function

public function integer of_setnote (string as_value, string as_qualifier);CHOOSE CASE as_Qualifier
		
	CASE "BN"
		
		is_BillNotes = as_Value
		ids_Data.SetItem ( 1 , "billNotes" , as_Value )
	CASE ELSE
		
		is_ShipmentNotes = as_Value
		ids_Data.SetItem ( 1 , "ShipmentNotes" , as_Value )
END CHOOSE

RETURN 1
end function

public function string of_getshipmentnote ();String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "Shipmentnotes" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "Shipmentnotes" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

RETURN UPPER ( ls_Return )

//RETURN  UPPER ( is_Shipmentnotes )
end function

public function string of_getbillnotes ();String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "BillNotes" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "BillNotes" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

RETURN UPPER ( ls_Return )
end function

public function date of_getpickupdate ();Date	ld_return
SetNull ( ld_Return )

String	ls_Temp 
				   //MONTH											DAY 												
ls_Temp = Mid ( is_pickupdate , 5 , 2 ) + "/" + Right ( is_pickupdate , 2 ) +"/" + Left ( is_pickupdate , 4 )

IF isDate ( ls_Temp ) THEN
	ld_Return = Date ( ls_Temp ) 
END IF

RETURN ld_Return 
end function

public function string of_getstringsite (integer ai_index);String	ls_Return

IF ib_Real204 = FALSE THEN
	IF ai_index > 0 AND ai_index <= UpperBound ( isa_Sites ) THEN
		ls_Return = isa_Sites[ai_index]
	END IF
ELSE
	IF ai_index > 0 AND ai_index <= il_stopcount THEN
		ls_Return = inva_stop[ai_Index].of_GetStringSite ( )
	END IF		
END IF

return ls_Return

end function

public function integer of_setpaymentmethod (string as_mop);is_methodofpayment = as_MOP
ids_Data.SetItem ( 1 , "methodofpayment" , as_MOP )
RETURN 1            
end function

public function integer of_setequipmentdetails (string asa_record[]);
Int	li_ValueCount
Int	i

String	ls_Value


ii_EquipmentCount ++

li_ValueCount = UpperBound ( asa_record[] )

FOR i = 2 TO li_ValueCount
	
	ls_Value = asa_Record[i]
	
	CHOOSE CASE i
			
		CASE 2
			inva_Equipment[ ii_EquipmentCount ].of_SetEquipmentInitial ( ls_Value )
		CASE 3
			inva_Equipment[ ii_EquipmentCount ].of_SetEquipmentNumber ( ls_Value )
		CASE 4
			inva_Equipment[ ii_EquipmentCount ].of_SetWeight ( ls_Value )
		CASE 5
			inva_Equipment[ ii_EquipmentCount ].of_SetWeightQualifier ( ls_Value )	
		CASE 6
			inva_Equipment[ ii_EquipmentCount ].of_SetTareWeight ( ls_Value )
		CASE 7
			inva_Equipment[ ii_EquipmentCount ].of_SetWeightAllowance ( ls_Value )
		CASE 8 
			//inva_Equipment[ ii_EquipmentCount ].of_Set			
		CASE 9 
			inva_Equipment[ ii_EquipmentCount ].of_SetVolume ( ls_Value )
		CASE 10		
			inva_Equipment[ ii_EquipmentCount ].of_SetVolumeQualifier ( ls_Value ) 
		CASE 11
			inva_Equipment[ ii_EquipmentCount ].of_SetOwnershipCode ( ls_Value )
		CASE 12
			inva_Equipment[ ii_EquipmentCount ].of_SetDescriptionCode ( ls_Value )
		CASE 13
			inva_Equipment[ ii_EquipmentCount ].of_SetScac ( ls_Value )
		CASE 14
			inva_Equipment[ ii_EquipmentCount ].of_SetTemperature	( ls_Value )
		CASE 15
			inva_Equipment[ ii_EquipmentCount ].of_SetPosition ( ls_Value )
		CASE 16
			inva_Equipment[ ii_EquipmentCount ].of_SetLength ( ls_Value )
		CASE 17
			inva_Equipment[ ii_EquipmentCount ].of_SetTareQualCode ( ls_Value )
		CASE 18
			inva_Equipment[ ii_EquipmentCount ].of_SetWeightUnitCode ( ls_Value )
		CASE 19
			inva_Equipment[ ii_EquipmentCount ].of_SetcheckDigit ( ls_Value )
		CASE 20
			inva_Equipment[ ii_EquipmentCount ].of_SetTypeofService ( ls_Value )
		CASE 21
			inva_Equipment[ ii_EquipmentCount ].of_SetHeight ( ls_Value )
		CASE 22
			inva_Equipment[ ii_EquipmentCount ].of_SetWidth	 ( ls_Value )
		CASE 23
			inva_Equipment[ ii_EquipmentCount ].of_SetEquipmentType ( ls_Value )
		CASE 24
//			scac again
//			inva_Equipment[ ii_EquipmentCount ].of_Set
		CASE 25
			inva_Equipment[ ii_EquipmentCount ].of_SetCartypeCode ( ls_Value )
			
	END CHOOSE
	
NEXT

RETURN 1

end function

public function integer of_setstopdetail (string asa_record[]);
Int	li_ValueCount
Int	i

String	ls_Value


il_StopCount ++

li_ValueCount = UpperBound ( asa_record[] )

FOR i = 2 TO li_ValueCount
	
	ls_Value = asa_Record[i]
	
	CHOOSE CASE i
			
		CASE 2
			inva_Stop[ il_StopCount ].of_SetStopNumber ( ls_Value )
		CASE 3
			inva_Stop[ il_StopCount ].of_SetStopReason ( ls_Value )
		CASE 4
			inva_Stop[ il_StopCount ].of_SetServiceCode ( ls_Value )			
		CASE 5
			inva_Stop[ il_StopCount ].of_SetWeight ( ls_Value )
		CASE 6
			inva_Stop[ il_StopCount ].of_SetWeightCode ( ls_Value )	
		CASE 7
			inva_Stop[ il_StopCount ].of_SetNumberOfUnits ( ls_Value )
		CASE 8
			inva_Stop[ il_StopCount ].of_SetUnitOfMeasure ( ls_Value )
		CASE 9
			inva_Stop[ il_StopCount ].of_SetVolume ( ls_Value )			
		CASE 10 
			inva_Stop[ il_StopCount ].of_SetVolumeUnit ( ls_Value )
		CASE 11		
			inva_Stop[ il_StopCount ].of_SetDescription ( ls_Value ) 
		CASE 12
			inva_Stop[ il_StopCount ].of_SetStandardPointLocation ( ls_Value )
		CASE 13
			inva_Stop[ il_StopCount ].of_SetAccomplishCode ( ls_Value )
		CASE 14
			inva_Stop[ il_StopCount ].of_SetDateQualifier ( ls_Value )
		CASE 15
			inva_Stop[ il_StopCount ].of_SetDate ( ls_Value )
		CASE 16
			inva_Stop[ il_StopCount ].of_SetTimeQualifier ( ls_Value )
		CASE 17
			inva_Stop[ il_StopCount ].of_SetTime ( ls_Value )
		CASE 18
			inva_Stop[ il_StopCount ].of_SetTimeCode ( ls_Value )
		CASE 19
			inva_Stop[ il_StopCount ].of_SetNote ( ls_Value )
		CASE 20
//			inva_Stop[ il_StopCount ].of_SetName ( ls_Value )  
		CASE 21
//			inva_Stop[ il_StopCount ].of_SetIDQualifier ( ls_Value )  	
		CASE 22
			inva_Stop[ il_StopCount ].of_SetName ( ls_Value )  // location (Quick Ref)
		CASE 23 
			inva_Stop[ il_StopCount ].of_SetReference ( ls_Value )  // location (Quick Ref)
			
	END CHOOSE
	
NEXT

RETURN 1
end function

public function integer of_setreal204 (boolean ab_Value);ib_Real204 = ab_Value
RETURN 1
end function

public function date of_getstopdate (integer ai_stopindex);Date	ld_Return
SetNull ( ld_Return )

IF ib_Real204 = FALSE THEN
		
	IF ai_StopIndex <= UpperBound ( isa_stoptypes[] ) THEN
		IF THIS.of_GetEventType ( ai_StopIndex ) = gc_Dispatch.cs_EventType_Pickup AND ai_StopIndex = 1 THEN
			ld_Return = THIS.of_GetPickupDate ( )
		ELSEIF  THIS.of_GetEventType ( ai_StopIndex ) = gc_Dispatch.cs_EventType_Deliver AND ai_StopIndex = THIS.of_GetStopCount ( ) THEN
			ld_Return = THIS.of_GetDeliverDate ( ) 						
		END IF
	END IF
	
ELSE
	
	IF ai_StopIndex <= UpperBound ( inva_stop ) THEN
		ld_Return = inva_stop[ai_StopIndex].of_GetDate ( ) 
	END IF

END IF

RETURN ld_Return
end function

public function integer of_settotalcharge (string as_value);is_TotalCharge = as_Value

ids_Data.SetItem ( 1 , "TotalCharge" , as_Value ) 

RETURN 1
end function

public function dec of_gettotalcharge ();Dec	lc_Return

IF isNumber ( is_TotalCharge ) THEN
	lc_Return = Dec ( is_Totalcharge )
END IF


RETURN lc_Return
end function

public function string of_getbillformat ();String	ls_Format


ls_Format = inv_DataMapping.of_GetSettingForAction ( "BILLFORMAT" )

IF IsNull ( ls_Format ) or Len ( ls_Format ) = 0 THEN
	IF ib_Real204 = FALSE THEN
		ls_Format = appeon_constant.cs_BillingFormat_Item
	ELSE
		IF THIS.of_GetTotalCharge ( ) > 0 THEN
			ls_Format = appeon_constant.cs_BillingFormat_Total
		END IF
	END IF
END IF 	

RETURN ls_Format
end function

public function string of_getrequiredequipment ();String	ls_Return
IF ii_equipmentcount > 0 THEN
	
	ls_Return = inva_equipment[ii_equipmentcount].of_GetLength( )
	IF Len ( ls_Return ) > 0 THEN
		ls_Return += " "
	END IF
	
	ls_Return += inva_equipment[ii_equipmentcount].of_GetDescription( )
	
END IF

RETURN ls_Return
end function

public function boolean of_isreal204 ();RETURN ib_Real204
end function

public function integer of_setedishipmentidnumber (string as_value);is_edishipmentidnumber = as_Value

ids_Data.SetItem ( 1 , "edishipmentidnumber" , as_Value )

RETURN 1
end function

public function string of_getedishipmentidnumber ();String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "edishipmentidnumber" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "edishipmentidnumber" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

RETURN UPPER ( ls_Return )


//RETURN is_edishipmentidnumber
end function

public function string of_getordertype ();String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "OrderType" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "OrderType" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

RETURN UPPER ( ls_Return )


//RETURN is_OrderType
end function

public function integer of_setordertype (string as_value);is_OrderType = as_Value
ids_Data.SetItem ( 1 , "OrderType" , as_Value )

RETURN 1

end function

public function time of_getstoptime (integer ai_index);Time	lt_StopTime
SetNull ( lt_StopTime ) 

IF ib_Real204 = FALSE THEN
		
	IF ai_index <= UpperBound ( isa_stoptypes[] ) THEN
		IF THIS.of_GetEventType ( ai_index ) = gc_Dispatch.cs_EventType_Pickup AND ai_index = 1 THEN
			lt_StopTime = THIS.of_GetPickupTime ( )
		ELSEIF  THIS.of_GetEventType ( ai_index ) = gc_Dispatch.cs_EventType_Deliver AND ai_index = THIS.of_GetStopCount ( ) THEN
			lt_StopTime = THIS.of_GetDeliverTime ( ) 						
		END IF
	END IF
	
ELSE

	IF ai_index > 0 AND ai_index <= il_stopcount THEN
		lt_StopTime = inva_stop[ai_Index].of_GetTime ( )
	END IF	
	
END IF
RETURN lt_StopTime



end function

public function integer of_setshipmentscac (string as_scac);is_ShipmentScac = as_Scac

ids_Data.SetItem ( 1 , "ShipmentScac" , as_Scac )

RETURN 1
end function

public function string of_getshipmentscac ();String	ls_Return

ls_Return = inv_DataMapping.of_GetSource ( "ShipmentScac" )

IF IsNull ( ls_Return ) OR Len ( ls_Return ) = 0 THEN
	ls_Return = ids_Data.GetItemString ( 1 , "ShipmentScac" )
ELSE
	ls_Return = THIS.of_GetValue ( ls_Return ) 	
END IF

RETURN UPPER ( ls_Return )



//RETURN is_ShipmentScac
end function

public function string of_geteventnote (integer ai_Index);String	ls_Return

IF ai_index > 0 AND ai_index <= il_stopcount THEN
	ls_Return = inva_stop[ai_Index].of_GetNote ( )
END IF	
	
RETURN ls_Return
end function

public function string of_getstopreference (integer ai_index);String	ls_Return

IF ai_index > 0 AND ai_index <= il_stopcount THEN
	ls_Return = inva_stop[ai_Index].of_GetReference ( )
END IF		
RETURN ls_Return
end function

private function string of_getvalue (string as_columnname);String	lsa_Columns[]
String	ls_Return
String	ls_Temp
Int		i
Int		li_Count

n_cst_String	lnv_String

lnv_String.of_ParseToArray ( as_columnname , "," , lsa_Columns )
li_Count = UpperBound  ( lsa_Columns )

FOR i = 1 TO li_Count
	IF i > 1 THEN
		ls_Return += " "
	END IF
	ls_Temp =  ids_data.GetItemString ( 1 , lsa_Columns[i] )
	IF Not IsNull ( ls_Temp ) THEN
		ls_Return += ls_Temp
	END IF
	
NEXT

RETURN  ls_Return


end function

public function date of_getdeliverdate ();Date	ld_return
SetNull ( ld_Return )

String	ls_Temp 
				   //MONTH											DAY 												
ls_Temp = Mid ( is_deliverdate , 5 , 2 ) + "/" + Right ( is_deliverdate , 2 ) +"/" + Left ( is_deliverdate , 4 )

IF isDate ( ls_Temp ) THEN
	ld_Return = Date ( ls_Temp ) 
END IF

RETURN ld_Return 
end function

public function integer of_setfreightrate (readonly string as_index, readonly string as_Amount);Int	li_Index

IF IsNumber ( as_index ) THEN
	li_Index = Integer ( as_index ) 
ELSE
	li_Index = UpperBound ( isa_freightrate[] ) + 1
END IF

isa_freightrate [ li_Index ] = as_Amount
RETURN 1
end function

public function decimal of_getfreightrate (readonly integer ai_Item);Dec	lc_Return
String	ls_Temp

IF ai_Item > 0 AND ai_Item <= UpperBound ( isa_freightrate[] ) THEN
	ls_Temp = isa_freightrate[ai_Item]	
	IF isNumber ( ls_Temp ) THEN
		lc_Return = Dec ( ls_Temp ) 
	END IF
END IF

RETURN lc_Return
end function

public function time of_getdelivertime ();Time	lt_Return 
SetNull ( lt_Return ) 

IF IsTime ( is_DeliverTime ) THEN
	lt_Return = Time ( is_DeliverTime ) 
END IF

RETURN lt_Return
end function

public function time of_getpickuptime ();Time	lt_Return 
SetNull ( lt_Return ) 

IF isTime ( is_PickupTime ) THEN
	lt_Return = Time ( is_PickUpTime	 ) 
END IF

RETURN lt_Return
end function

public function string of_getcustomtext (string as_WhichOne);String	ls_Return

SetNull ( ls_Return ) 

CHOOSE CASE as_WhichOne
		
	CASE "1"
		ls_Return =	is_custom1 
	CASE "2"
		ls_Return =	is_custom2 
	CASE "3"
		ls_Return =	is_custom3 
	CASE "4"
		ls_Return = is_custom4 
	CASE "5"
		ls_Return = is_custom5 
	CASE "6"
		ls_Return = is_custom6 
	CASE "7"
		ls_Return =	is_custom7 
	CASE "8"
		ls_Return =	is_custom8 
	CASE "9"
		ls_Return =	is_custom9 
	CASE "10"
		ls_Return=	is_custom10
		
END CHOOSE

RETURN ls_Return



end function

public function integer of_setcustomtext (string as_Value, string as_Qualifier);CHOOSE CASE as_Qualifier
		
	CASE "1"
		is_custom1 = as_Value
	CASE "2"
		is_custom2 = as_Value
	CASE "3"
		is_custom3 = as_Value
	CASE "4"
		is_custom4 = as_Value
	CASE "5"
		is_custom5 = as_Value
	CASE "6"
		is_custom6 = as_Value
	CASE "7"
		is_custom7 = as_Value
	CASE "8"
		is_custom8 = as_Value
	CASE "9"
		is_custom9 = as_Value
	CASE "10"
		is_custom10 = as_Value
		
END CHOOSE

RETURN 1

end function

public function string of_getattemptedbilltoname ();String	ls_FindName

ls_FindName = is_billtoname

IF Len ( is_methodofpayment ) > 0 THEN
	IF is_methodofpayment = "PP" THEN
		ls_FindName = is_billtoname
	ELSEIF is_methodofpayment = "CL" THEN
		ls_FindName = is_consigneename
	END IF
END IF

return ls_FindName
 
end function

on n_cst_edi_204_record.create
TriggerEvent( this, "constructor" )
end on

on n_cst_edi_204_record.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;ib_success = TRUE
ib_Real204 = TRUE
ids_Data = CREATE dataStore
ids_Data.DataObject = "d_Edi204_Data"
ids_Data.InsertRow (0) 

inv_DataMapping = CREATE n_cst_DataMapping_EDI204
end event

event destructor;DESTROY ( inv_DataMapping )
DESTROY ( ids_Data )
end event

