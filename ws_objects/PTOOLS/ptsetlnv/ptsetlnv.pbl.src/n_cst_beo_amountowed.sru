$PBExportHeader$n_cst_beo_amountowed.sru
$PBExportComments$AmountOwed (Persistent Class from PBL map PTSetl) //@(*)[103978905|60]
forward
global type n_cst_beo_amountowed from n_cst_beo
end type
end forward

global type n_cst_beo_amountowed from n_cst_beo
event ue_deletepaysplit ( )
end type
global n_cst_beo_amountowed n_cst_beo_amountowed

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_beo inv_transaction //@(*)[103978905|60:transaction]<nosync>
private n_cst_beo inv_entity //@(*)[103978905|60:entity]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Constant Integer	ci_Status_Open = 0
Constant Integer	ci_Status_Authorized = 1
Constant Integer	ci_Status_AuditRequired = 2
Constant Integer	ci_Status_Audited = 3
Constant Integer	ci_Status_Hold = 4
Constant Integer	ci_Status_History = 5
Constant String	cs_Status_ValueList = "OPEN~t0/AUTHORIZED~t1/AUDIT REQ.~t2/AUDITED~t3/HOLD~t4/HISTORY~t5/"
//"Open~t0/Authorized~t1/Audit Req.~t2/Audited~t3/Hold~t4/History~t5/"
end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly string as_name, readonly any aa_value)
protected function integer getattribute (readonly string as_name, ref any aa_value)
public function Integer of_SetId (Long al_id)
public function Long of_GetFktransaction ()
public function Integer of_SetFktransaction (Long al_fktransaction)
public function Integer of_GetCategory ()
public function Integer of_SetCategory (Integer ai_category)
public function Integer of_GetType ()
public function integer of_settype (integer ai_type)
public function Decimal of_GetAmount ()
public function Integer of_SetAmount (Decimal ad_amount)
public function Integer of_GetStatus ()
public function Integer of_SetStatus (Integer ai_status)
public function Boolean of_GetOpen ()
public function Integer of_SetOpen (Boolean ab_open)
public function String of_GetDescription ()
public function Integer of_SetDescription (String as_description)
public function String of_GetInternalnote ()
public function Integer of_SetInternalnote (String as_internalnote)
public function String of_GetPublicnote ()
public function Integer of_SetPublicnote (String as_publicnote)
public function Integer of_GetRef1type ()
public function Integer of_SetRef1type (Integer ai_ref1type)
public function String of_GetRef1text ()
public function Integer of_SetRef1text (String as_ref1text)
public function Integer of_GetRef2type ()
public function Integer of_SetRef2type (Integer ai_ref2type)
public function String of_GetRef2text ()
public function Integer of_SetRef2text (String as_ref2text)
public function Integer of_GetRef3type ()
public function Integer of_SetRef3type (Integer ai_ref3type)
public function String of_GetRef3text ()
public function Integer of_SetRef3text (String as_ref3text)
public function Integer of_GetRatetype ()
public function Integer of_SetRatetype (Integer ai_ratetype)
public function Decimal of_GetQuantity ()
public function Integer of_SetQuantity (Decimal ad_quantity)
public function Decimal of_GetRate ()
public function Integer of_SetRate (Decimal ad_rate)
protected function String of_GetModlog ()
protected function Integer of_SetModlog (String as_modlog)
public function n_cst_beo of_getentity ()
public function n_cst_beo of_GetEntity (String as_query)
public function Integer of_SetEntity (n_cst_beo anv_entity)
public function n_cst_beo of_GetTransaction ()
public function n_cst_beo of_GetTransaction (String as_query)
public function Integer of_SetTransaction (n_cst_beo anv_transaction)
public function Date of_GetStartdate ()
public function Integer of_SetStartdate (Date ad_startdate)
public function Date of_GetEnddate ()
public function Integer of_SetEnddate (Date ad_enddate)
protected function Integer of_calculate (string as_whatchanged, decimal ad_newvalue)
public function Integer of_GetDivision ()
public function integer of_setdivision (integer ai_division)
public function Boolean of_GetTaxable ()
public function Integer of_SetTaxable (Boolean ab_taxable)
public function Long of_GetId ()
public function Integer of_calculatetransaction ()
public function Integer of_gettransaction (ref n_cst_beo_transaction an_transaction)
public function Integer of_unassign ()
protected function Boolean of_isstatuscloseable (integer ai_status)
public function Integer of_getamounttype (ref n_cst_beo_amounttype an_amounttype)
protected function Integer of_getamounttype (integer ai_amounttypeid, ref n_cst_beo_amounttype an_amounttype)
public function Boolean of_isstatuscloseable ()
public function Long of_GetFkentity ()
public function Integer of_SetFkentity (Long al_fkentity)
public function Boolean of_isstatusactive ()
public function Boolean of_isstatusrestricted ()
public function Boolean of_isstatusaudited ()
public function Boolean of_isstatushistory ()
public function Boolean of_isstatusactive (integer ai_status)
public function Boolean of_isstatusrestricted (integer ai_status)
public function Boolean of_isstatusaudited (integer ai_status)
public function Boolean of_isstatushistory (integer ai_status)
public function integer of_markuppercent (decimal adec_Percent)
public function integer of_markupdollar (decimal adec_dollarvalue)
public function string of_getdriver ()
public function string of_gettruck ()
public function string of_gettrailer ()
public function string of_getcontainer ()
public function string of_getshipment ()
public function string of_gettrip ()
public function integer of_setdriver (string as_driver)
public function integer of_settruck (string as_truck)
public function integer of_settrailer (string as_trailer)
public function integer of_setcontainer (string as_container)
public function integer of_setshipment (string as_shipment)
public function integer of_settrip (string as_trip)
public function integer of_setfktransaction_direct (long al_fktransaction)
public function string of_getratecodename ()
public function string of_getlastmodifiedby ()
public function integer of_setlastmodifiedby (string as_value)
public function integer of_setratecodename (string as_value)
public function string of_getoriginzone ()
public function string of_getdestinationzone ()
public function integer of_setoriginzone (string as_value)
public function integer of_setdestinationzone (string as_value)
public function long of_getbilltoid ()
public function integer of_setbilltoid (long al_value)
public subroutine of_applyautorate (n_cst_ratedata anv_ratedata)
end prototypes

event ue_deletepaysplit;Long	ll_RowCount, &
		ll_AmountID, & 
		ll_FoundRow
		
Integer	li_Return = 1

n_cst_bso	lnv_Context
n_ds	lds_PaySplitCache


IF This.HasContext ( ) THEN

	lnv_Context = This.GetContext ( )
	ll_AmountID = this.of_GetId ()

	lds_PaySplitCache = lnv_Context.Dynamic of_GetPaySplitCache ( FALSE /*Don't Create*/ )	

	IF IsValid ( lds_PaySplitCache ) THEN  //If not valid, not a problem, for now anyway.
		
		ll_RowCount = lds_PaySplitCache.RowCount()
		
		DO 		
			ll_FoundRow = lds_PaysplitCache.Find ( "amountid = " + string ( ll_AmountId ), 1 , ll_RowCount )
			IF ll_FoundRow > 0 THEN
				lds_PaySplitCache.RowsDiscard(ll_FoundRow, ll_FoundRow, Primary!)
			END IF 
			
		LOOP WHILE ll_FoundRow > 0
		
	END IF

//ELSE   Don't fail for this, for now, anyway.
//	li_Return = -1

END IF

end event

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_amountowed")
inv_bcm.RegisterAttribute("id", "long") //@(*)[79597358|83]
inv_bcm.SetKey("id")
inv_bcm.RegisterRelationshipAttribute("fktransaction", "long", "n_cst_beo_transaction", "id", "transaction")
inv_bcm.RegisterRelationshipAttribute("fkentity", "long", "n_cst_beo_entity", "id", "entity")
inv_bcm.RegisterAttribute("category", "integer") //@(*)[364586147|277]
inv_bcm.RegisterAttribute("type", "integer") //@(*)[365687924|283]
inv_bcm.RegisterAttribute("division", "integer") //@(*)[72532501|449]
inv_bcm.RegisterAttribute("startdate", "date") //@(*)[60296736|336]
inv_bcm.RegisterAttribute("enddate", "date") //@(*)[60094008|335]
inv_bcm.RegisterAttribute("amount", "decimal") //@(*)[79632354|84]
inv_bcm.RegisterAttribute("status", "integer") //@(*)[49531976|317]
inv_bcm.RegisterAttribute("open", "boolean") //@(*)[79808743|85]
inv_bcm.RegisterAttribute("description", "string(32767)") //@(*)[366231552|286]
inv_bcm.RegisterAttribute("internalnote", "string(32767)") //@(*)[366278819|287]
inv_bcm.RegisterAttribute("publicnote", "string(32767)") //@(*)[366344187|288]
inv_bcm.RegisterAttribute("ref1type", "integer") //@(*)[366369861|289]
inv_bcm.RegisterAttribute("ref1text", "string(30)") //@(*)[366452401|290]
inv_bcm.RegisterAttribute("ref2type", "integer") //@(*)[366535332|291]
inv_bcm.RegisterAttribute("ref2text", "string(30)") //@(*)[366557774|292]
inv_bcm.RegisterAttribute("ref3type", "integer") //@(*)[366575011|293]
inv_bcm.RegisterAttribute("ref3text", "string(30)") //@(*)[366586957|294]
inv_bcm.RegisterAttribute("ratetype", "integer") //@(*)[372668932|313]
inv_bcm.RegisterAttribute("quantity", "decimal") //@(*)[372739290|314]
inv_bcm.RegisterAttribute("rate", "decimal") //@(*)[372762743|315]
inv_bcm.RegisterAttribute("taxable", "boolean") //@(*)[72663960|450]
inv_bcm.RegisterAttribute("modlog", "string(32767)") //@(*)[49837736|319]
inv_bcm.RegisterAttribute("driver", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("truck", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("trailer", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("container", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("shipment", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("trip", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("ratecodename", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("lastmodifiedby", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("originzone", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("destinationzone", "string(32767)") //Added manually
inv_bcm.RegisterAttribute("billtoid", "long") //Added manually
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "AmountOwed", "Id")
   inv_bcm.MapDBColumn("fktransaction", "AmountOwed", "fkTransaction")
   inv_bcm.MapDBColumn("fkentity", "AmountOwed", "fkEntity")
   inv_bcm.MapDBColumn("category", "AmountOwed", "Category")
   inv_bcm.MapDBColumn("type", "AmountOwed", "Type")
   inv_bcm.MapDBColumn("division", "AmountOwed", "Division")
   inv_bcm.MapDBColumn("startdate", "AmountOwed", "StartDate")
   inv_bcm.MapDBColumn("enddate", "AmountOwed", "EndDate")
   inv_bcm.MapDBColumn("amount", "AmountOwed", "Amount")
   inv_bcm.MapDBColumn("status", "AmountOwed", "Status")
   inv_bcm.MapDBColumn("open", "AmountOwed", "Open")
   inv_bcm.MapDBColumn("description", "AmountOwed", "Description")
   inv_bcm.MapDBColumn("internalnote", "AmountOwed", "InternalNote")
   inv_bcm.MapDBColumn("publicnote", "AmountOwed", "PublicNote")
   inv_bcm.MapDBColumn("ref1type", "AmountOwed", "Ref1Type")
   inv_bcm.MapDBColumn("ref1text", "AmountOwed", "Ref1Text")
   inv_bcm.MapDBColumn("ref2type", "AmountOwed", "Ref2Type")
   inv_bcm.MapDBColumn("ref2text", "AmountOwed", "Ref2Text")
   inv_bcm.MapDBColumn("ref3type", "AmountOwed", "Ref3Type")
   inv_bcm.MapDBColumn("ref3text", "AmountOwed", "Ref3Text")
   inv_bcm.MapDBColumn("ratetype", "AmountOwed", "RateType")
   inv_bcm.MapDBColumn("quantity", "AmountOwed", "Quantity")
   inv_bcm.MapDBColumn("rate", "AmountOwed", "Rate")
   inv_bcm.MapDBColumn("taxable", "AmountOwed", "Taxable")
   inv_bcm.MapDBColumn("modlog", "AmountOwed", "ModLog")
   inv_bcm.MapDBColumn("driver", "AmountOwed", "Driver")
   inv_bcm.MapDBColumn("truck", "AmountOwed", "truck")
   inv_bcm.MapDBColumn("trailer", "AmountOwed", "Trailer")
   inv_bcm.MapDBColumn("container", "AmountOwed", "Container")
   inv_bcm.MapDBColumn("shipment", "AmountOwed", "Shipment")
   inv_bcm.MapDBColumn("trip", "AmountOwed", "Trip")
	inv_bcm.MapDBColumn("ratecodename", "AmountOwed", "ratecodename")
	inv_bcm.MapDBColumn("lastmodifiedby", "AmountOwed", "lastmodifiedby")
	inv_bcm.MapDBColumn("originzone", "AmountOwed", "originzone")
	inv_bcm.MapDBColumn("destinationzone", "AmountOwed", "destinationzone")
	inv_bcm.MapDBColumn("billtoid", "AmountOwed", "billtoid")
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
 case "fktransaction" 
   return of_SetFktransaction(Long(aa_value))
 case "fkentity" 
   return of_SetFkentity(Long(aa_value))
 case "category" 
   return of_SetCategory(Integer(aa_value))
 case "type" 
   return of_SetType(Integer(aa_value))
 case "division" 
   return of_SetDivision(Integer(aa_value))
 case "startdate" 
   return of_SetStartdate(Convert(aa_value, TypeDate!))
 case "enddate" 
   return of_SetEnddate(Convert(aa_value, TypeDate!))
 case "amount" 
   return of_SetAmount(Dec(aa_value))
 case "status" 
   return of_SetStatus(Integer(aa_value))
 case "open" 
   return of_SetOpen(Convert(aa_value, TypeBoolean!))
 case "description" 
   return of_SetDescription(String(aa_value))
 case "internalnote" 
   return of_SetInternalnote(String(aa_value))
 case "publicnote" 
   return of_SetPublicnote(String(aa_value))
 case "ref1type" 
   return of_SetRef1type(Integer(aa_value))
 case "ref1text" 
   return of_SetRef1text(String(aa_value))
 case "ref2type" 
   return of_SetRef2type(Integer(aa_value))
 case "ref2text" 
   return of_SetRef2text(String(aa_value))
 case "ref3type" 
   return of_SetRef3type(Integer(aa_value))
 case "ref3text" 
   return of_SetRef3text(String(aa_value))
 case "ratetype" 
   return of_SetRatetype(Integer(aa_value))
 case "quantity" 
   return of_SetQuantity(Dec(aa_value))
 case "rate" 
   return of_SetRate(Dec(aa_value))
 case "taxable" 
   return of_SetTaxable(Convert(aa_value, TypeBoolean!))
 case "driver" 
   return of_SetDriver(String(aa_value))
 case "truck" 
   return of_SetTruck(String(aa_value))
 case "trailer" 
   return of_SetTrailer(String(aa_value))
 case "container" 
   return of_SetContainer(String(aa_value))
 case "shipment" 
   return of_SetShipment(String(aa_value))
 case "trip" 
   return of_SetTrip(String(aa_value))
 case "ratecodename"
	return of_SetrateCodename(String(aa_value))
 case "lastmodifiedby"
	return of_SetLastModifiedby(String(aa_value))
 case "originzone"
	return of_Setoriginzone(String(aa_value))
 case "destinationzone"
	return of_Setdestinationzone(String(aa_value))
 case "billtoid" 
   return of_SetId(Long(aa_value))
	
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
 case "fktransaction" 
   aa_value = of_GetFktransaction()
   li_rc = 1
 case "fkentity" 
   aa_value = of_GetFkentity()
   li_rc = 1
 case "category" 
   aa_value = of_GetCategory()
   li_rc = 1
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
 case "division" 
   aa_value = of_GetDivision()
   li_rc = 1
 case "startdate" 
   aa_value = of_GetStartdate()
   li_rc = 1
 case "enddate" 
   aa_value = of_GetEnddate()
   li_rc = 1
 case "amount" 
   aa_value = of_GetAmount()
   li_rc = 1
 case "status" 
   aa_value = of_GetStatus()
   li_rc = 1
 case "open" 
   aa_value = of_GetOpen()
   li_rc = 1
 case "description" 
   aa_value = of_GetDescription()
   li_rc = 1
 case "internalnote" 
   aa_value = of_GetInternalnote()
   li_rc = 1
 case "publicnote" 
   aa_value = of_GetPublicnote()
   li_rc = 1
 case "ref1type" 
   aa_value = of_GetRef1type()
   li_rc = 1
 case "ref1text" 
   aa_value = of_GetRef1text()
   li_rc = 1
 case "ref2type" 
   aa_value = of_GetRef2type()
   li_rc = 1
 case "ref2text" 
   aa_value = of_GetRef2text()
   li_rc = 1
 case "ref3type" 
   aa_value = of_GetRef3type()
   li_rc = 1
 case "ref3text" 
   aa_value = of_GetRef3text()
   li_rc = 1
 case "ratetype" 
   aa_value = of_GetRatetype()
   li_rc = 1
 case "quantity" 
   aa_value = of_GetQuantity()
   li_rc = 1
 case "rate" 
   aa_value = of_GetRate()
   li_rc = 1
 case "taxable" 
   aa_value = of_GetTaxable()
   li_rc = 1
 case "driver" 
   aa_value = of_GetDriver()
   li_rc = 1
 case "truck" 
   aa_value = of_GetTruck()
   li_rc = 1
 case "trailer" 
   aa_value = of_GetTrailer()
   li_rc = 1
 case "container" 
   aa_value = of_GetContainer()
   li_rc = 1
 case "shipment" 
   aa_value = of_GetShipment()
   li_rc = 1
 case "trip" 
   aa_value = of_GetTrip()
   li_rc = 1
 case "ratecodename"
	aa_value = of_GetrateCodename()
	li_rc = 1
 case "lastmodifiedby"
	aa_value = of_GetLastModifiedby()
	li_rc = 1
 case "originzone"
	aa_value = of_getoriginzone()
	li_rc = 1
 case "destinationzone"
	aa_value = of_getdestinationzone()
	li_rc = 1
 case "billtoid"
	aa_value = of_getbilltoid()
	li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Integer of_SetId (Long al_id);//@(*)[79597358|83:id:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Long of_GetFktransaction ();//@(*)[88914054|90:fktransaction:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fktransaction")
//@(text)--

end function

public function Integer of_SetFktransaction (Long al_fktransaction);//@(*)[88914054|90:fktransaction:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fktransaction" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


Long	ll_CurrentValue
n_cst_bso	lnv_Context
n_cst_beo_Transaction	lnv_CurrentTransaction, &
								lnv_AssignedTransaction
n_cst_OFRError		lnv_Error
String	ls_MessageHeader = "Assign to Transaction"
Boolean	lb_AuthorizationError

IF li_rc > 0 THEN
	IF This.AllowEdit ( cb_UserField, cb_Restricted ) = FALSE THEN
		li_rc = -1
		lb_AuthorizationError = TRUE
	END IF
END IF


IF li_rc > 0 THEN

	IF This.HasContext ( ) THEN
	
		lnv_Context = This.GetContext ( )
	
		CHOOSE CASE Lower ( lnv_Context.ClassName ( ) )
	
		CASE "n_cst_bso_transactionmanager"
	
			ll_CurrentValue = This.of_GetfkTransaction ( )
	
			IF NOT IsNull ( ll_CurrentValue ) THEN

				IF lnv_Context.Dynamic of_GetTransaction ( ll_CurrentValue, lnv_CurrentTransaction ) < 1 THEN
					li_rc = -1
				END IF

				IF IsValid ( lnv_CurrentTransaction ) THEN

					IF lnv_CurrentTransaction.AllowEdit ( appeon_constant.cb_UserField, &
						appeon_constant.cb_Restricted ) = FALSE THEN

						li_rc = -1
						lb_AuthorizationError = TRUE

					END IF

				END IF

			END IF
	

			IF NOT IsNull ( al_fkTransaction ) THEN

				IF lnv_Context.Dynamic of_GetTransaction ( al_fkTransaction, lnv_AssignedTransaction ) < 1 THEN
					li_rc = -1
				END IF

				IF IsValid ( lnv_AssignedTransaction ) THEN
	
					IF lnv_AssignedTransaction.AllowEdit ( appeon_constant.cb_UserField, &
						appeon_constant.cb_Restricted ) = FALSE THEN

						li_rc = -1
						lb_AuthorizationError = TRUE

					END IF

					IF This.of_GetCategory ( ) = lnv_AssignedTransaction.of_GetCategory ( ) THEN
						//Categories match.  Proceed.
					ELSE
						li_rc = -1
					END IF

				END IF
	
				//Check that entity is the same.  Other checks?
			END IF
	
		CASE ELSE
			li_rc = -1
	
		END CHOOSE
	
	ELSE
		li_rc = -1
	
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fktransaction", al_fktransaction) < 1 then
      li_rc = -1
   end if
end if
//@(text)--


IF li_rc > 0 THEN

	//Recalculate current transaction totals

	IF IsValid ( lnv_CurrentTransaction ) THEN

		IF lnv_CurrentTransaction.of_Calculate ( ) = -1 THEN
			SetValue ( "fktransaction", ll_CurrentValue )
			li_rc = -1
		END IF

	END IF


	//Recalculate assigned transaction totals

	IF IsValid ( lnv_AssignedTransaction ) THEN

		IF lnv_AssignedTransaction.of_Calculate ( ) = -1 THEN
			//Should have fatal exception here, because the other transaction has
			//already been recalculated.
			SetValue ( "fktransaction", ll_CurrentValue )
			li_rc = -1
		END IF

	END IF

END IF


IF li_rc = -1 THEN

	lnv_Error = This.AddOFRError ( )

	IF IsValid ( lnv_Error ) THEN

		IF IsNull ( al_fkTransaction ) THEN
			lnv_Error.SetMessageHeader ( "Unassign Amount from Transaction" )
		ELSE
			lnv_Error.SetMessageHeader ( "Assign Amount to Transaction" )
		END IF

		IF lb_AuthorizationError THEN
			lnv_Error.SetErrorMessage ( cs_RejectEdit_NotAuthorized )
		ELSE
			lnv_Error.SetErrorMessage ( cs_RejectEdit_Error )
		END IF

	END IF

END IF


//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetCategory ();//@(*)[364586147|277:category:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("category")
//@(text)--

end function

public function Integer of_SetCategory (Integer ai_category);//@(*)[364586147|277:category:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetType ();//@(*)[365687924|283:type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("type")
//@(text)--

end function

public function integer of_settype (integer ai_type);//@(*)[365687924|283:type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--
Int	li_ThisCategory
Int	li_AmountTypeCategory
Boolean	lb_GoodMatch

String	ls_Message, &
			ls_MessageHeader = "Amount Type"
n_cst_OFRError	lnv_Error


IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	n_cst_beo_AmountType	lnv_AmountType
	
	CHOOSE CASE This.of_GetAmountType ( ai_Type, lnv_AmountType )
	
	CASE 1  //New AmountType identified successfully
		
		li_AmountTypeCategory = lnv_AmountType.of_Getcategory( )
		li_ThisCategory = THIS.of_GetCategory( )
		
		CHOOSE CASE li_ThisCategory
			CASE n_cst_constants.ci_Category_Payables
				IF li_AmountTypeCategory = n_cst_constants.ci_Category_Payables OR &
					li_AmountTypeCategory = n_cst_constants.ci_Category_Both THEN
					lb_GoodMatch = TRUE
				END IF
				
			CASE n_cst_constants.ci_Category_Receivables
				IF li_AmountTypeCategory = n_cst_constants.ci_Category_Receivables OR &
					li_AmountTypeCategory = n_cst_constants.ci_Category_Both THEN
					lb_GoodMatch = TRUE
				END IF
				
		END CHOOSE
		
		This.of_SetTaxable ( lnv_AmountType.of_GetTaxableDefault ( ) )
		This.of_Calculate ( "type", ai_Type )
		li_rc = 2
		
		IF NOT lb_GoodMatch THEN // we are still going to allow this to be set but we do 
										// want to notify the user that there is a mismatch

//			NOTE: This message will need to be changed if amounts ouwed are used in receivables
										
			// this category and the amount type category is not compatable.
			// add an ofdr Error
			ls_Message = "A Shipment only amount type was assigned to a Payable amount."
			
		END IF
	
	CASE 0  //Type is being cleared
		//No action necessary
	
	CASE ELSE //-1  //New type could not be identified
		//Ignore error (?)
	
	END CHOOSE

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("type", ai_type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

IF Len ( ls_Message ) > 0 THEN
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage( ls_Message )
	lnv_Error.SetMessageHeader ( ls_MessageHeader )
END IF

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--
end function

public function Decimal of_GetAmount ();//@(*)[79632354|84:amount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("amount")
//@(text)--

end function

public function Integer of_SetAmount (Decimal ad_amount);//@(*)[79632354|84:amount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "amount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	IF This.of_Calculate ( "amount", ad_Amount ) = 1 THEN
		li_rc = 2
	ELSE
		li_rc = -1
	END IF

END IF


//@(text)(recreate=no)<Set Value>
//if li_rc > 0 then
//   if SetValue("amount", ad_amount) < 1 then
//      li_rc = -1
//   end if
//end if
//@(text)--


//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetStatus ();//@(*)[49531976|317:status:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("status")
//@(text)--

end function

public function Integer of_SetStatus (Integer ai_status);//@(*)[49531976|317:status:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "status" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


String	ls_Message, &
			ls_MessageHeader = "Change Status"
n_cst_OFRError	lnv_Error


IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	//Verify that requested Status makes sense, relative to Open setting
	
	CHOOSE CASE ai_Status
	
	CASE ci_Status_History
	
		//Do not allow status to be set to history unless Amount has been closed
	
		IF This.of_GetOpen ( ) = TRUE THEN
			ls_Message = "Status cannot manually be set to history.  You can set amount status "+&
				"to history by closing the associated transaction."
			li_rc = -1
		END IF
	
	CASE ELSE
	
		//Do not allow other statuses to be set if Amount has been closed
	
		IF This.of_GetOpen ( ) = FALSE THEN
			ls_Message = "Cannot change the status of a closed amount."
			li_rc = -1
		END IF
	
	END CHOOSE

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("status", ai_status) < 1 then
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


//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Boolean of_GetOpen ();//@(*)[79808743|85:open:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("open")
//@(text)--

end function

public function Integer of_SetOpen (Boolean ab_open);//@(*)[79808743|85:open:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "open" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


Boolean	lb_CurrentValue

lb_CurrentValue = This.of_GetOpen ( )

CHOOSE CASE ab_Open

CASE TRUE

	CHOOSE CASE lb_CurrentValue

	CASE TRUE
		//Value already matches.  Do not reset it.
		RETURN 1

	CASE FALSE
		//Do not allow a closed amount to be reopened.
		li_rc = -1

	CASE ELSE  //Null
		//Value is being initialized.  Proceed.

	END CHOOSE

CASE FALSE

	IF lb_CurrentValue = FALSE THEN
		//Value already matches.  Do not reset it.
		RETURN 1
	END IF


	//Check whether current status is closeable

	IF This.of_IsStatusCloseable ( ) = FALSE THEN
		//**Propagate an error message**
		RETURN -1
	END IF


CASE ELSE
	li_rc = -1

END CHOOSE


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("open", ab_open) < 1 then
      li_rc = -1
   end if
end if
//@(text)--


//If we just closed the Amount (successfully), set Status to History

IF li_rc > 0 AND &
	ab_Open = FALSE THEN

	IF This.of_SetStatus ( ci_Status_History ) > 0 THEN
		li_rc = 2
	ELSE
		//Open and Status settings now conflict.  We should:
		//Attempt to reset Status value.
		//If unsuccessful, raise fatal exception.
	END IF

END IF


//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetDescription ();//@(*)[366231552|286:description:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("description")
//@(text)--

end function

public function Integer of_SetDescription (String as_description);//@(*)[366231552|286:description:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "description" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


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

public function String of_GetInternalnote ();//@(*)[366278819|287:internalnote:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("internalnote")
//@(text)--

end function

public function Integer of_SetInternalnote (String as_internalnote);//@(*)[366278819|287:internalnote:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "internalnote" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("internalnote", as_internalnote) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetPublicnote ();//@(*)[366344187|288:publicnote:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("publicnote")
//@(text)--

end function

public function Integer of_SetPublicnote (String as_publicnote);//@(*)[366344187|288:publicnote:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "publicnote" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("publicnote", as_publicnote) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetRef1type ();//@(*)[366369861|289:ref1type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref1type")
//@(text)--

end function

public function Integer of_SetRef1type (Integer ai_ref1type);//@(*)[366369861|289:ref1type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref1type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	IF ai_Ref1Type = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Ref1Type )
		li_rc = 2  //To force redisplay of field.
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref1type", ai_ref1type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRef1text ();//@(*)[366452401|290:ref1text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref1text")
//@(text)--

end function

public function Integer of_SetRef1text (String as_ref1text);//@(*)[366452401|290:ref1text:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref1text" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


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

public function Integer of_GetRef2type ();//@(*)[366535332|291:ref2type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref2type")
//@(text)--

end function

public function Integer of_SetRef2type (Integer ai_ref2type);//@(*)[366535332|291:ref2type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref2type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	IF ai_Ref2Type = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Ref2Type )
		li_rc = 2  //To force redisplay of field.
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref2type", ai_ref2type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRef2text ();//@(*)[366557774|292:ref2text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref2text")
//@(text)--

end function

public function Integer of_SetRef2text (String as_ref2text);//@(*)[366557774|292:ref2text:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref2text" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


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

public function Integer of_GetRef3type ();//@(*)[366575011|293:ref3type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref3type")
//@(text)--

end function

public function Integer of_SetRef3type (Integer ai_ref3type);//@(*)[366575011|293:ref3type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref3type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	IF ai_Ref3Type = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Ref3Type )
		li_rc = 2  //To force redisplay of field.
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ref3type", ai_ref3type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetRef3text ();//@(*)[366586957|294:ref3text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref3text")
//@(text)--

end function

public function Integer of_SetRef3text (String as_ref3text);//@(*)[366586957|294:ref3text:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ref3text" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


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

public function Integer of_GetRatetype ();//@(*)[372668932|313:ratetype:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ratetype")
//@(text)--

end function

public function Integer of_SetRatetype (Integer ai_ratetype);//@(*)[372668932|313:ratetype:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "ratetype" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	IF ai_RateType = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_RateType )
		li_rc = 2  //To force redisplay of field
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("ratetype", ai_ratetype) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetQuantity ();//@(*)[372739290|314:quantity:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("quantity")
//@(text)--

end function

public function Integer of_SetQuantity (Decimal ad_quantity);//@(*)[372739290|314:quantity:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "quantity" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	IF This.of_Calculate ( "quantity", ad_Quantity ) = 1 THEN
		li_rc = 2
	ELSE
		li_rc = -1
	END IF

END IF


//@(text)(recreate=no)<Set Value>
//if li_rc > 0 then
//   if SetValue("quantity", ad_quantity) < 1 then
//      li_rc = -1
//   end if
//end if
//@(text)--


//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetRate ();//@(*)[372762743|315:rate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("rate")
//@(text)--

end function

public function Integer of_SetRate (Decimal ad_rate);//@(*)[372762743|315:rate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "rate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


IF li_rc > 0 THEN

	IF This.of_Calculate ( "rate", ad_Rate ) = 1 THEN
		li_rc = 2
	ELSE
		li_rc = -1
	END IF

END IF


//@(text)(recreate=no)<Set Value>
//if li_rc > 0 then
//   if SetValue("rate", ad_rate) < 1 then
//      li_rc = -1
//   end if
//end if
//@(text)--


//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

protected function String of_GetModlog ();//@(*)[49837736|319:modlog:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("modlog")
//@(text)--

end function

protected function Integer of_SetModlog (String as_modlog);//@(*)[49837736|319:modlog:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "modlog" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_SystemField, cb_Unrestricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("modlog", as_modlog) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function n_cst_beo of_getentity ();//@(*)[370004321|307:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--


//If there is a TransactionManager, use it to get the entity beo instead of normal
//relationship method processing.  If the TransactionManager can't get the beo, 
//we will allow the request to fail, NOT resort to the normal processing, because
//if there's a TransactionManager, you wouldn't want the new individual entity bcm 
//getting retrieved.

n_cst_bso	lnv_Context
n_cst_beo_Entity	lnv_Entity

IF This.HasContext ( ) THEN

	lnv_Context = This.GetContext ( )

	lnv_Context.Dynamic of_GetEntity ( This.of_GetfkEntity ( ), lnv_Entity )

	RETURN lnv_Entity

END IF


//@(text)(recreate=yes)<Return BEO>
return this.of_GetEntity(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetEntity (String as_query);//@(*)[370004321|307]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_entity = GetRelationship( inv_entity, "n_cst_dlkc_entity",  "entity", "amountowed", as_query, "n_cst_beo_entity" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_entity
//@(text)--

end function

public function Integer of_SetEntity (n_cst_beo anv_entity);//@(*)[370004321|307:so]<nosync>//@(-)Do not edit, move or copy this line//
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

public function n_cst_beo of_GetTransaction ();//@(*)[363460197|276:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return this.of_GetTransaction(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetTransaction (String as_query);//@(*)[363460197|276]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_transaction = GetRelationship( inv_transaction, "n_cst_dlkc_transaction",  "transaction", "amountowed", as_query, "n_cst_beo_transaction" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_transaction
//@(text)--

end function

public function Integer of_SetTransaction (n_cst_beo anv_transaction);//@(*)[363460197|276:so]<nosync>//@(-)Do not edit, move or copy this line//

//Note: All privileges checking, etc. is in SetfkTransaction, which will
//be called by the architecture when processing SetRelatedClass.

//@(text)(recreate=yes)<body>

if this.SetRelatedClass(anv_transaction,"transaction") = 1 then
inv_transaction = anv_transaction
 return 1
end if

//@(text)--

//@(text)(recreate=yes)<Return status>
return -1
//@(text)--

end function

public function Date of_GetStartdate ();//@(*)[60296736|336:startdate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("startdate")
//@(text)--

end function

public function Integer of_SetStartdate (Date ad_startdate);//@(*)[60296736|336:startdate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "startdate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("startdate", ad_startdate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

Date	ld_EndDate

IF li_rc > 0 THEN
	IF NOT IsNull ( ad_StartDate ) THEN

		ld_EndDate = of_GetEndDate ( )

		IF IsNull ( ld_EndDate ) OR &
			ld_EndDate < ad_StartDate THEN

			SetValue ( "enddate", ad_StartDate )
			li_rc = 2
		END IF
	END IF
END IF
	

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Date of_GetEnddate ();//@(*)[60094008|335:enddate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("enddate")
//@(text)--

end function

public function Integer of_SetEnddate (Date ad_enddate);//@(*)[60094008|335:enddate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "enddate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("enddate", ad_enddate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

Date	ld_StartDate

IF li_rc > 0 THEN
	IF NOT IsNull ( ad_EndDate ) THEN

		ld_StartDate = This.of_GetStartDate ( )

		IF IsNull ( ld_StartDate ) OR &
			ld_StartDate > ad_EndDate THEN

			SetValue ( "startdate", ad_EndDate )
			li_rc = 2
		END IF
	END IF
END IF

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

protected function Integer of_calculate (string as_whatchanged, decimal ad_newvalue);//@(*)[54795438|445]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Integer	li_Return, &
			li_Sign, &
			li_Type

Decimal	ld_Quantity, &
			ld_Rate, &
			ld_Amount, &
			ld_OldQuantity, &
			ld_OldRate, &
			ld_OldAmount
n_cst_beo_AmountType	lnv_AmountType

li_Return = 1
as_WhatChanged = Lower ( as_WhatChanged )

ld_OldQuantity = of_GetQuantity ( )
ld_OldRate = of_GetRate ( )
ld_OldAmount = of_GetAmount ( )

ld_Quantity = Abs ( ld_OldQuantity )	//Should be >= 0 anyway
ld_Rate = Abs ( ld_OldRate )				//Should be >= 0 anyway
ld_Amount = Abs ( ld_OldAmount )			//Could be negative

IF as_WhatChanged = "type" THEN
	li_Type = ad_NewValue
ELSE
	ad_NewValue = Abs ( ad_NewValue )
	li_Type = of_GetType ( )
END IF


CHOOSE CASE as_WhatChanged

CASE "quantity"

	ld_Quantity = ad_NewValue

	IF IsNull ( ld_Quantity ) THEN
		SetNull ( ld_Rate )
	ELSEIF IsNull ( ld_Rate ) THEN
		IF ld_Quantity <> 0 THEN
			ld_Rate = ld_Amount / ld_Quantity
		ELSE
			ld_Rate = 0
			ld_Amount = 0
		END IF
	ELSE
		ld_Amount = ld_Quantity * ld_Rate
	END IF

CASE "rate"

	ld_Rate = ad_NewValue

	IF IsNull ( ld_Rate ) THEN
		SetNull ( ld_Quantity )
	ELSEIF IsNull ( ld_Quantity ) THEN
		IF ld_Rate <> 0 THEN
			ld_Quantity = ld_Amount / ld_Rate
		ELSE
			ld_Quantity = 0
			ld_Amount = 0
		END IF
	ELSE
		ld_Amount = ld_Quantity * ld_Rate
	END IF

CASE "amount"

	ld_Amount = ad_NewValue

	IF IsNull ( ld_Amount ) THEN

		//SetNull ( ld_Quantity )
		SetNull ( ld_Rate )

	ELSEIF IsNull ( ld_Quantity ) OR &
		IsNull ( ld_Rate ) THEN

		//No Processing needed

	ELSEIF ld_Quantity <> 0 THEN

		ld_Rate = ld_Amount / ld_Quantity

	ELSEIF ld_Rate <> 0 THEN

		ld_Quantity = ld_Amount / ld_Rate

	ELSEIF ld_Amount <> 0 THEN

		ld_Quantity = 1
		ld_Rate = ld_Amount

	END IF

CASE "type"
	//Amounts stay the same -- only the sign needs to be determined


CASE ELSE

	//???

END CHOOSE


//Determine sign of amount  --  Assume positive if n/a

li_Sign = 1

IF IsNull ( ld_Amount ) OR ld_Amount = 0 THEN

	//Sign is irrelevant

ELSEIF IsNull ( ld_OldAmount ) OR ld_OldAmount = 0 OR as_WhatChanged = "type" THEN

	CHOOSE CASE of_GetAmountType ( li_Type, lnv_AmountType )

	CASE 1  //Type successfully identified

		CHOOSE CASE lnv_AmountType.of_GetTypicalAmount ( )

		CASE appeon_constant.ci_TypicalAmount_Negative
			li_Sign = -1

		END CHOOSE

	CASE 0  //No Type has been specified
		//Make the amount positive

	CASE ELSE  //Type could not be accessed
		//Make the amount positive  (Error?)

	END CHOOSE


ELSE

	//Keep sign same as it is now
	li_Sign = Sign ( ld_OldAmount )

END IF


//If sign should be negative, make it negative

IF li_Sign = -1 THEN
	ld_Amount *= -1
END IF


IF li_Return = 1 THEN

	IF ( 	( ld_Quantity = ld_OldQuantity ) OR &
			( IsNull ( ld_Quantity ) AND IsNull ( ld_OldQuantity ) ) ) AND &
		( 	( ld_Rate = ld_OldRate ) OR &
			( IsNull ( ld_Rate ) AND IsNull ( ld_OldRate ) ) ) AND &
		( 	( ld_Amount = ld_OldAmount ) OR &
			( IsNull ( ld_Amount ) AND IsNull ( ld_OldAmount ) ) ) THEN
	
		//No values have changed.  No need to write values or recalculate transaction.
	
	ELSEIF SetValue ( "quantity", ld_Quantity ) < 1 THEN
		li_Return = -1
	ELSEIF SetValue ( "rate", ld_Rate ) < 1 THEN
		SetValue ( "quantity", ld_OldQuantity )
		li_Return = -1
	ELSEIF  SetValue ( "amount", ld_Amount ) < 1 THEN
		SetValue ( "quantity", ld_OldQuantity )
		SetValue ( "rate", ld_OldRate )
		li_Return = -1
	END IF


	IF li_Return = 1 THEN
	
		IF ( 	( ld_Amount = ld_OldAmount ) OR &
				( IsNull ( ld_Amount ) AND IsNull ( ld_OldAmount ) ) ) THEN
		
			//Amount has not changed.  No need to recalculate transaction.

		
		ELSEIF This.of_CalculateTransaction ( ) = -1 THEN
			SetValue ( "quantity", ld_OldQuantity )
			SetValue ( "rate", ld_OldRate )
			SetValue ( "amount", ld_OldAmount )
			li_Return = -1
		END IF
	
	END IF
END IF


RETURN li_Return
end function

public function Integer of_GetDivision ();//@(*)[72532501|449:division:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("division")
//@(text)--

end function

public function integer of_setdivision (integer ai_division);//@(*)[72532501|449:division:s]<nosync>//@(-)Do not edit, move or copy this line//
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

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


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

public function Boolean of_GetTaxable ();//@(*)[72663960|450:taxable:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("taxable")
//@(text)--

end function

public function Integer of_SetTaxable (Boolean ab_taxable);//@(*)[72663960|450:taxable:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "taxable" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

Boolean	lb_NoChange

IF This.of_GetTaxable ( ) = ab_Taxable THEN
	lb_NoChange = TRUE
END IF

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF

//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("taxable", ab_taxable) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

IF li_rc > 0 AND &
	lb_NoChange = FALSE THEN

	This.of_CalculateTransaction ( )

END IF

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[79597358|83:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_calculatetransaction ();//@(*)[60801437|533]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns : 1 = Success (Transaction successfully identified and recalculated), 
//				0 = No transaction is associated, 
//				-1 = Error

n_cst_beo_Transaction	lnv_Transaction
Integer	li_Return

li_Return = 1

CHOOSE CASE This.of_GetTransaction ( lnv_Transaction )

CASE 1  //Success

	IF lnv_Transaction.of_Calculate ( ) = -1 THEN
		li_Return = -1
	END IF

CASE 0  //No Transaction is associated
	li_Return = 0

CASE -1  //Error
	li_Return = -1

END CHOOSE


RETURN li_Return
end function

public function Integer of_gettransaction (ref n_cst_beo_transaction an_transaction);//@(*)[63134385|535]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns : 1 = Success, 0 = No Transaction is associated, -1 = Error

Long	ll_TransactionId
n_cst_bso	lnv_Context
n_cst_beo_Transaction	lnv_Transaction
Integer	li_Return

li_Return = 1

ll_TransactionId = This.of_GetfkTransaction ( )

IF IsNull ( ll_TransactionId ) THEN
	li_Return = 0

ELSEIF This.HasContext ( ) THEN

	lnv_Context = This.GetContext ( )

	IF lnv_Context.Dynamic of_GetTransaction ( ll_TransactionId, lnv_Transaction ) < 1 THEN
		li_Return = -1
	END IF


ELSE
	//We can extend this to use the normal internal relationship methods if we want to.
	//For now, it's not necessary, so we'll just have it fail.
	li_Return = -1

END IF

an_Transaction = lnv_Transaction
RETURN li_Return
end function

public function Integer of_unassign ();//@(*)[47244035|716]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Long	ll_Null
Integer	li_Return

li_Return = -1
SetNull ( ll_Null )

IF This.of_SetfkTransaction ( ll_Null ) = 1 THEN

	//May need to clear the reference to the transaction?  IS THIS RIGHT??
	SetNull ( inv_Transaction )

	li_Return = 1
END IF

RETURN li_Return
end function

protected function Boolean of_isstatuscloseable (integer ai_status);//@(*)[49994250|727]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Identify whether the status submitted can be closed.
//Returns : TRUE, FALSE

Boolean	lb_Return = TRUE

CHOOSE CASE ai_Status

CASE ci_Status_AuditRequired, ci_Status_Hold
	//These statuses cannot be closed.
	lb_Return = FALSE

END CHOOSE

RETURN lb_Return
end function

public function Integer of_getamounttype (ref n_cst_beo_amounttype an_amounttype);//@(*)[75000039|732]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


RETURN This.of_GetAmountType ( This.of_GetType ( ), an_AmountType )
end function

protected function Integer of_getamounttype (integer ai_amounttypeid, ref n_cst_beo_amounttype an_amounttype);//@(*)[79352134|736]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns : 1 = Success, 0 = No AmountType is associated, -1 = Error

n_cst_bso	lnv_Context
n_cst_beo_AmountType	lnv_AmountType
Integer	li_Return

li_Return = 1

IF IsNull ( ai_AmountTypeId ) THEN
	li_Return = 0

ELSEIF This.HasContext ( ) THEN

	lnv_Context = This.GetContext ( )

	IF lnv_Context.Dynamic of_GetAmountType ( ai_AmountTypeId, lnv_AmountType ) < 1 THEN
		li_Return = -1
	END IF


ELSE
	//We can extend this to use the normal internal relationship methods if we want to.
	//For now, it's not necessary, so we'll just have it fail.
	li_Return = -1

END IF

an_AmountType = lnv_AmountType
RETURN li_Return
end function

public function Boolean of_isstatuscloseable ();//@(*)[83139734|755]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusCloseable ( This.of_GetStatus ( ) )
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

public function Boolean of_isstatusactive ();//@(*)[164000651|1271]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusActive ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusrestricted ();//@(*)[164013643|1272]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusRestricted ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusaudited ();//@(*)[164024736|1273]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusAudited ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatushistory ();//@(*)[164036656|1274]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusHistory ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusactive (integer ai_status);//@(*)[164048358|1275]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE ai_Status

CASE ci_Status_Open

	//Status is in "Active" category
	lb_Result = TRUE

CASE ci_Status_Authorized, &
	ci_Status_AuditRequired, &
	ci_Status_Hold

	//Status is in "Restricted" category
	//No processing needed

CASE ci_Status_Audited

	//Status is in "Audited" category
	//No processing needed

CASE ci_Status_History

	//Status is in "History" category
	//No processing needed

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function Boolean of_isstatusrestricted (integer ai_status);//@(*)[164069151|1277]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE ai_Status

CASE ci_Status_Open

	//Status is in "Active" category
	//No processing needed

CASE ci_Status_Authorized, &
	ci_Status_AuditRequired, &
	ci_Status_Hold

	//Status is in "Restricted" category
	lb_Result = TRUE

CASE ci_Status_Audited

	//Status is in "Audited" category
	//No processing needed

CASE ci_Status_History

	//Status is in "History" category
	//No processing needed

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function Boolean of_isstatusaudited (integer ai_status);//@(*)[164089829|1279]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE ai_Status

CASE ci_Status_Open

	//Status is in "Active" category
	//No processing needed

CASE ci_Status_Authorized, &
	ci_Status_AuditRequired, &
	ci_Status_Hold

	//Status is in "Restricted" category
	//No processing needed

CASE ci_Status_Audited

	//Status is in "Audited" category
	lb_Result = TRUE

CASE ci_Status_History

	//Status is in "History" category
	//No processing needed

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function Boolean of_isstatushistory (integer ai_status);//@(*)[164111881|1281]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: TRUE, FALSE, or Null (Unrecognized Status)

Boolean	lb_Result = FALSE

CHOOSE CASE ai_Status

CASE ci_Status_Open

	//Status is in "Active" category
	//No processing needed

CASE ci_Status_Authorized, &
	ci_Status_AuditRequired, &
	ci_Status_Hold

	//Status is in "Restricted" category
	//No processing needed

CASE ci_Status_Audited

	//Status is in "Audited" category
	//No processing needed

CASE ci_Status_History

	//Status is in "History" category
	lb_Result = TRUE

CASE ELSE

	SetNull ( lb_Result )

END CHOOSE


RETURN lb_Result
end function

public function integer of_markuppercent (decimal adec_Percent);Dec lc_OldAmount
Dec lc_NewAmount

lc_OldAmount = THIS.of_GetAmount( )
	
lc_NewAmount = lc_OldAmount + ( lc_oldAmount * adec_Percent )

THIS.of_SetAmount ( lc_NewAmount )

Return 1
end function

public function integer of_markupdollar (decimal adec_dollarvalue);Dec lc_OldAmount
Dec lc_NewAmount
Int li_Return = 1
n_cst_beo_AmountType lnv_Type

lc_OldAmount = THIS.of_GetAmount( )

THIS.of_GetAmountType ( lnv_Type )
IF IsValid ( lnv_Type ) THEN
	CHOOSE CASE lnv_Type.of_GEtTypicalAmount () 
			
		CASE appeon_constant.ci_TypicalAmount_Negative
			adec_dollarvalue = adec_dollarvalue * -1
			
		CASE appeon_constant.ci_TypicalAmount_Positive
			
		CASE appeon_constant.ci_TypicalAmount_Either
			if lc_OldAmount < 0 THEN
				adec_dollarvalue = adec_dollarvalue * -1
			END IF
	END CHOOSE
	
	lc_NewAmount = lc_OldAmount + adec_dollarvalue
	THIS.of_SetAmount ( lc_NewAmount )
ELSE
	
	li_Return = -1
END IF		


RETURN li_Return
end function

public function string of_getdriver ();//Attribute was added manually.
return This.GetValue("driver")
end function

public function string of_gettruck ();//Attribute was added manually.
return This.GetValue("truck")
end function

public function string of_gettrailer ();//Attribute was added manually.
return This.GetValue("trailer")
end function

public function string of_getcontainer ();//Attribute was added manually.
return This.GetValue("container")
end function

public function string of_getshipment ();//Attribute was added manually.
return This.GetValue("shipment")
end function

public function string of_gettrip ();//Attribute was added manually.
return This.GetValue("trip")
end function

public function integer of_setdriver (string as_driver);integer li_rc = 1

// Validation logic for "driver" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


if li_rc > 0 then
   if SetValue("driver", as_driver) < 1 then
      li_rc = -1
   end if
end if


return li_rc

end function

public function integer of_settruck (string as_truck);integer li_rc = 1

// Validation logic for "truck" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


if li_rc > 0 then
   if SetValue("truck", as_truck) < 1 then
      li_rc = -1
   end if
end if


return li_rc

end function

public function integer of_settrailer (string as_trailer);integer li_rc = 1

// Validation logic for "trailer" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


if li_rc > 0 then
   if SetValue("trailer", as_trailer) < 1 then
      li_rc = -1
   end if
end if


return li_rc

end function

public function integer of_setcontainer (string as_container);integer li_rc = 1

// Validation logic for "container" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


if li_rc > 0 then
   if SetValue("container", as_container) < 1 then
      li_rc = -1
   end if
end if


return li_rc

end function

public function integer of_setshipment (string as_shipment);integer li_rc = 1

// Validation logic for "shipment" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


if li_rc > 0 then
   if SetValue("shipment", as_shipment) < 1 then
      li_rc = -1
   end if
end if


return li_rc

end function

public function integer of_settrip (string as_trip);integer li_rc = 1

// Validation logic for "trip" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.

IF li_rc > 0 THEN
	IF This.ApproveEdit ( cb_UserField, cb_Restricted ) < 1 THEN
		li_rc = -1
	END IF
END IF


if li_rc > 0 then
   if SetValue("trip", as_trip) < 1 then
      li_rc = -1
   end if
end if


return li_rc

end function

public function integer of_setfktransaction_direct (long al_fktransaction);//This version should be used sparingly.  It's intended use is for when you
//want to link a series of amounts to a transaction without it recalculating,
//and then recalculate the transaction once at the end.  The normal 
//of_SetFkTransaction processing recalculates the associated transaction
//automatically, and would therefore recalculate after each amount was set.

//Note : We're bypassing all the normal privilege and integrity checking,
//so you should be sure everything's kosher to use this version.

integer li_rc = 1

// Validation logic for "fktransaction" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


if li_rc > 0 then
   if SetValue("fktransaction", al_fktransaction) < 1 then
      li_rc = -1
   end if
end if

return li_rc
end function

public function string of_getratecodename ();//Attribute was added manually.
return This.GetValue("ratecodename")
end function

public function string of_getlastmodifiedby ();//Attribute was added manually.
return This.GetValue("lastmodifiedby")
end function

public function integer of_setlastmodifiedby (string as_value);integer li_rc = 1

if SetValue("lastmodifiedby", as_value) < 1 then
   li_rc = -1
end if

return li_rc

end function

public function integer of_setratecodename (string as_value);integer li_rc = 1

li_rc = SetValue("ratecodename", as_value)

return li_rc


end function

public function string of_getoriginzone ();//Attribute was added manually.
return This.GetValue("originzone")
end function

public function string of_getdestinationzone ();//Attribute was added manually.
return This.GetValue("destinationzone")
end function

public function integer of_setoriginzone (string as_value);integer li_rc = 1

if SetValue("originzone", as_value) < 1 then
   li_rc = -1
end if

return li_rc

end function

public function integer of_setdestinationzone (string as_value);integer li_rc = 1

if SetValue("destinationzone", as_value) < 1 then
   li_rc = -1
end if

return li_rc

end function

public function long of_getbilltoid ();//Attribute was added manually.
return This.GetValue("billtoid")
end function

public function integer of_setbilltoid (long al_value);integer li_rc = 1

if SetValue("billtoid", al_value) < 1 then
   li_rc = -1
end if

return li_rc

end function

public subroutine of_applyautorate (n_cst_ratedata anv_ratedata);long		ll_index, &
			ll_count, &
			ll_found, &
			ll_amounttype
			
string	ls_description

if isvalid(anv_ratedata) then
	
	if anv_ratedata.of_getrate() > 0 then
		if anv_ratedata.of_Getratetype() = appeon_constant.cs_RateUnit_Code_Flat then
			this.of_setquantity(1)
		else
			this.of_setquantity(anv_ratedata.of_gettotalcount())
		end if
		this.of_setamount(0)
		this.of_Setrate(anv_ratedata.of_getrate())
	else
		this.of_setamount(0)
		this.of_Setrate(0)
	end if
	
//	this.of_setquantity(anv_ratedata.of_gettotalcount())
//	this.of_setamount(anv_ratedata.of_gettotalcharge())
	
	ls_description = anv_ratedata.of_getDescription()
	//only replace description if there is one on the ratetable
	if len(trim(ls_description)) > 0 then
		this.of_setdescription(ls_description)
	end if

	ll_amounttype = anv_ratedata.of_getAmounttype()
	if isnull(ll_amounttype) or ll_amounttype = 0 then
		//don't set
	else
		this.of_settype(anv_ratedata.of_getAmounttype())
	end if
	
	this.of_setratecodename(anv_ratedata.of_getcodename())
	this.of_setbilltoid(anv_ratedata.of_getbilltoid())
	this.of_setOriginzone(anv_ratedata.of_getOriginZone())
	this.of_setDestinationzone(anv_ratedata.of_getDestinationZone())
	this.of_setlastmodifiedby(gnv_app.of_getuserid())

end if

end subroutine

on n_cst_beo_amountowed.create
call super::create
end on

on n_cst_beo_amountowed.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
this.SetRequired("category")
this.SetRequired("type")
this.SetRequired("status")
this.SetRequired("open")
this.SetRequired("taxable")
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

		IF This.of_SetOpen ( TRUE ) < 1 THEN
			//Fail
			li_Return = -1
		END IF

	END IF


	//Set default value for Status

	IF li_Return = 1 THEN

		IF This.of_SetStatus ( ci_Status_Open ) < 1 THEN
			//Fail
			li_Return = -1
		END IF

	END IF

ELSE
	li_Return = AncestorReturnValue

END IF

RETURN li_Return
end event

event ofr_predelete;call super::ofr_predelete;//Extending ancestor script.
//We need to unassign the amount to force recalculation of the transaction before deleting.

//Return : 1 = Proceed with delete, <> 1 = Abort delete


Integer	li_Return

//Verify that delete has not already been rejected in the ancestor.
li_Return = AncestorReturnValue


//Check whether edits of any kind are allowed on the amount for this user, 
//given its current status.

IF li_Return = 1 THEN

	IF This.AllowEdit ( cb_UserField, cb_Restricted ) = FALSE THEN
		li_Return = -1
	END IF

END IF


//If OK so far, attempt to unassign the amount, in case it's assigned to a transaction.

IF li_Return = 1 THEN

	IF This.of_Unassign ( ) = 1 THEN
		//Unassign successful.  Proceed.
		IF this.triggerEvent("ue_deletepaysplit") < 1 then
			li_Return = -1 
		END IF
	ELSE
		//Unassign failed.  Prevent delete.
		li_Return = -1

	END IF

END IF

RETURN li_Return
end event

event ue_allowuseredit;call super::ue_allowuseredit;//EXTENDING ANCESTOR to provide class-specific processing.

Boolean	lb_Allow
n_cst_Privileges	lnv_Privileges

lb_Allow = AncestorReturnValue

//If Ancestor did not reject change, see if it passes further criteria.

IF lb_Allow THEN

	lb_Allow = lnv_Privileges.of_Settlements_Edit ( )

END IF

RETURN lb_Allow
end event

event ue_alloweditrestricted;call super::ue_alloweditrestricted;//EXTENDING ANCESTOR to provide class-specific processing.

Boolean	lb_Allow
n_cst_Privileges	lnv_Privileges

lb_Allow = AncestorReturnValue

//If Ancestor did not reject change, see if it passes further criteria.

IF lb_Allow THEN

	//Note: "Restricted" in this event's name means restricted in the broad sense.
	//There are three categories of restricted, one of which is named "Restricted".

	IF This.of_IsStatusRestricted ( ) THEN

		lb_Allow = lnv_Privileges.of_HasAuditRights ( )

	ELSEIF This.of_IsStatusAudited ( ) THEN

		lb_Allow = lnv_Privileges.of_HasAuditRights ( )

	ELSEIF This.of_IsStatusHistory ( ) THEN

		lb_Allow = lnv_Privileges.of_HasSysAdminRights ( )

	END IF

END IF

RETURN lb_Allow
end event

