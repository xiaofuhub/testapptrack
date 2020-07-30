$PBExportHeader$n_cst_beo_transaction.sru
$PBExportComments$Transaction (Persistent Class from PBL map PTSetl) //@(*)[104076276|61]
forward
global type n_cst_beo_transaction from n_cst_beo
end type
end forward

global type n_cst_beo_transaction from n_cst_beo
end type
global n_cst_beo_transaction n_cst_beo_transaction

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private n_cst_bcm inv_amountowed //@(*)[363460197|276:amountowed]<nosync>
private n_cst_beo inv_entity //@(*)[104076276|61:entity]<nosync>
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Constant Integer	ci_Type_Settlement = 1
Constant String	cs_Type_ValueList = "SETTLEMENT~t1/"

Constant Integer	ci_Status_Open = 0
Constant Integer	ci_Status_Authorized = 1
Constant Integer	ci_Status_AuditRequired = 2
Constant Integer	ci_Status_Audited = 3
Constant Integer	ci_Status_Hold = 4
Constant Integer	ci_Status_History = 5
Constant Integer	ci_Status_Failed=6
Constant String	cs_Status_ValueList = "OPEN~t0/AUTHORIZED~t1/AUDIT REQ.~t2/AUDITED~t3/HOLD~t4/HISTORY~t5/FAILED~t6/"
//"Open~t0/Authorized~t1/Audit Req.~t2/Audited~t3/Hold~t4/History~t5/"
end variables

forward prototypes
protected function integer registerclass ()
protected function integer setattribute (readonly String as_name, readonly any aa_value)
protected function integer getattribute (readonly String as_name, ref any aa_value)
public function Integer of_SetId (Long al_id)
public function Integer of_GetCategory ()
public function Integer of_SetCategory (Integer ai_category)
public function Integer of_GetType ()
public function Integer of_SetType (Integer ai_type)
public function Boolean of_GetFixedamount ()
public function Integer of_SetFixedamount (Boolean ab_fixedamount)
public function Integer of_GetStatus ()
public function integer of_setstatus (integer ai_status)
public function Boolean of_GetOpen ()
public function integer of_setopen (boolean ab_open)
public function Date of_GetDocumentdate ()
public function Integer of_SetDocumentdate (Date ad_documentdate)
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
public function Date of_GetStartdate ()
public function Integer of_SetStartdate (Date ad_startdate)
public function Date of_GetEnddate ()
public function Integer of_SetEnddate (Date ad_enddate)
protected function String of_GetModlog ()
protected function Integer of_SetModlog (String as_modlog)
public function n_cst_beo of_getentity ()
public function n_cst_beo of_GetEntity (String as_query)
public function Integer of_SetEntity (n_cst_beo anv_entity)
public function n_cst_bcm of_GetAmountowed (String as_query)
public function n_cst_bcm of_GetAmountowed ()
public function Decimal of_GetTaxablegross ()
public function Integer of_SetTaxablegross (Decimal ad_taxablegross)
public function Decimal of_GetNontaxablegross ()
public function Integer of_SetNontaxablegross (Decimal ad_nontaxablegross)
public function Decimal of_GetPretaxnet ()
public function Integer of_SetPretaxnet (Decimal ad_pretaxnet)
public function String of_GetDocumentnumber ()
public function Integer of_SetDocumentnumber (String as_documentnumber)
public function Long of_GetId ()
public function Integer of_calculate ()
public function Integer of_unassignall ()
public function Integer of_getamountslist (ref n_cst_beo_amountowed an_amountslist[])
protected function Boolean of_isstatuscloseable (integer ai_status)
public function integer of_print ()
public function n_cst_bso_transactionmanager of_gettransactionmanager ()
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
public function Boolean of_GetBatched ()
public function integer of_setbatched (boolean ab_batched)
public function Date of_GetBatchdate ()
public function Integer of_SetBatchdate (Date ad_batchdate)
public function String of_GetBatchnumber ()
public function integer of_setbatchnumber (string as_batchnumber)
public function string of_getaccountingid (ref string as_type)
public function long of_getamountslist (ref long ala_id[])
end prototypes

protected function integer registerclass ();//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
super::RegisterClass()

//@(data)(recreate=yes)<RegisterClass>
inv_bcm.RegisterClass("n_cst_beo_transaction")
inv_bcm.RegisterAttribute("id", "long") //@(*)[88914054|90]
inv_bcm.SetKey("id")
inv_bcm.RegisterRelationshipAttribute("fkentity", "long", "n_cst_beo_entity", "id", "entity")
inv_bcm.RegisterAttribute("category", "integer") //@(*)[364998730|278]
inv_bcm.RegisterAttribute("type", "integer") //@(*)[365717254|284]
inv_bcm.RegisterAttribute("startdate", "date") //@(*)[370538728|310]
inv_bcm.RegisterAttribute("enddate", "date") //@(*)[370551671|311]
inv_bcm.RegisterAttribute("taxablegross", "decimal") //@(*)[72837595|452]
inv_bcm.RegisterAttribute("nontaxablegross", "decimal") //@(*)[72880621|453]
inv_bcm.RegisterAttribute("pretaxnet", "decimal") //@(*)[88951085|91]
inv_bcm.RegisterAttribute("fixedamount", "boolean") //@(*)[369827613|305]
inv_bcm.RegisterAttribute("status", "integer") //@(*)[49783059|318]
inv_bcm.RegisterAttribute("open", "boolean") //@(*)[145622440|149]
inv_bcm.RegisterAttribute("documentdate", "date") //@(*)[145570459|148]
inv_bcm.RegisterAttribute("documentnumber", "string(30)") //@(*)[369469411|304]
inv_bcm.RegisterAttribute("description", "string(32767)") //@(*)[366685068|295]
inv_bcm.RegisterAttribute("internalnote", "string(32767)") //@(*)[366701589|296]
inv_bcm.RegisterAttribute("publicnote", "string(32767)") //@(*)[366715001|297]
inv_bcm.RegisterAttribute("ref1type", "integer") //@(*)[366737300|298]
inv_bcm.RegisterAttribute("ref1text", "string(30)") //@(*)[369031962|299]
inv_bcm.RegisterAttribute("ref2type", "integer") //@(*)[369047189|300]
inv_bcm.RegisterAttribute("ref2text", "string(30)") //@(*)[369058307|301]
inv_bcm.RegisterAttribute("ref3type", "integer") //@(*)[369072389|302]
inv_bcm.RegisterAttribute("ref3text", "string(30)") //@(*)[369085527|303]
inv_bcm.RegisterAttribute("modlog", "string(32767)") //@(*)[49865825|320]
inv_bcm.RegisterAttribute("batched", "boolean") //@(*)[67568891|1626]
inv_bcm.RegisterAttribute("batchdate", "date") //@(*)[67632825|1627]
inv_bcm.RegisterAttribute("batchnumber", "string(30)") //@(*)[67646698|1628]
//@(data)--

//@(text)(recreate=yes)<MapDBCols>
if inv_bcm.defaultDLK() then
   inv_bcm.MapDBColumn("id", "Transaction", "Id")
   inv_bcm.MapDBColumn("fkentity", "Transaction", "fkEntity")
   inv_bcm.MapDBColumn("category", "Transaction", "Category")
   inv_bcm.MapDBColumn("type", "Transaction", "Type")
   inv_bcm.MapDBColumn("startdate", "Transaction", "StartDate")
   inv_bcm.MapDBColumn("enddate", "Transaction", "EndDate")
   inv_bcm.MapDBColumn("taxablegross", "Transaction", "TaxableGross")
   inv_bcm.MapDBColumn("nontaxablegross", "Transaction", "NonTaxableGross")
   inv_bcm.MapDBColumn("pretaxnet", "Transaction", "PreTaxNet")
   inv_bcm.MapDBColumn("fixedamount", "Transaction", "FixedAmount")
   inv_bcm.MapDBColumn("status", "Transaction", "Status")
   inv_bcm.MapDBColumn("open", "Transaction", "Open")
   inv_bcm.MapDBColumn("documentdate", "Transaction", "DocumentDate")
   inv_bcm.MapDBColumn("documentnumber", "Transaction", "DocumentNumber")
   inv_bcm.MapDBColumn("description", "Transaction", "Description")
   inv_bcm.MapDBColumn("internalnote", "Transaction", "InternalNote")
   inv_bcm.MapDBColumn("publicnote", "Transaction", "PublicNote")
   inv_bcm.MapDBColumn("ref1type", "Transaction", "Ref1Type")
   inv_bcm.MapDBColumn("ref1text", "Transaction", "Ref1Text")
   inv_bcm.MapDBColumn("ref2type", "Transaction", "Ref2Type")
   inv_bcm.MapDBColumn("ref2text", "Transaction", "Ref2Text")
   inv_bcm.MapDBColumn("ref3type", "Transaction", "Ref3Type")
   inv_bcm.MapDBColumn("ref3text", "Transaction", "Ref3Text")
   inv_bcm.MapDBColumn("modlog", "Transaction", "ModLog")
   inv_bcm.MapDBColumn("batched", "Transaction", "Batched")
   inv_bcm.MapDBColumn("batchdate", "Transaction", "BatchDate")
   inv_bcm.MapDBColumn("batchnumber", "Transaction", "BatchNumber")
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
 case "fkentity" 
   return of_SetFkentity(Long(aa_value))
 case "category" 
   return of_SetCategory(Integer(aa_value))
 case "type" 
   return of_SetType(Integer(aa_value))
 case "startdate" 
   return of_SetStartdate(Convert(aa_value, TypeDate!))
 case "enddate" 
   return of_SetEnddate(Convert(aa_value, TypeDate!))
 case "taxablegross" 
   return of_SetTaxablegross(Dec(aa_value))
 case "nontaxablegross" 
   return of_SetNontaxablegross(Dec(aa_value))
 case "pretaxnet" 
   return of_SetPretaxnet(Dec(aa_value))
 case "fixedamount" 
   return of_SetFixedamount(Convert(aa_value, TypeBoolean!))
 case "status" 
   return of_SetStatus(Integer(aa_value))
 case "open" 
   return of_SetOpen(Convert(aa_value, TypeBoolean!))
 case "documentdate" 
   return of_SetDocumentdate(Convert(aa_value, TypeDate!))
 case "documentnumber" 
   return of_SetDocumentnumber(String(aa_value))
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
 case "batched" 
   return of_SetBatched(Convert(aa_value, TypeBoolean!))
 case "batchdate" 
   return of_SetBatchdate(Convert(aa_value, TypeDate!))
 case "batchnumber" 
   return of_SetBatchnumber(String(aa_value))
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
 case "fkentity" 
   aa_value = of_GetFkentity()
   li_rc = 1
 case "category" 
   aa_value = of_GetCategory()
   li_rc = 1
 case "type" 
   aa_value = of_GetType()
   li_rc = 1
 case "startdate" 
   aa_value = of_GetStartdate()
   li_rc = 1
 case "enddate" 
   aa_value = of_GetEnddate()
   li_rc = 1
 case "taxablegross" 
   aa_value = of_GetTaxablegross()
   li_rc = 1
 case "nontaxablegross" 
   aa_value = of_GetNontaxablegross()
   li_rc = 1
 case "pretaxnet" 
   aa_value = of_GetPretaxnet()
   li_rc = 1
 case "fixedamount" 
   aa_value = of_GetFixedamount()
   li_rc = 1
 case "status" 
   aa_value = of_GetStatus()
   li_rc = 1
 case "open" 
   aa_value = of_GetOpen()
   li_rc = 1
 case "documentdate" 
   aa_value = of_GetDocumentdate()
   li_rc = 1
 case "documentnumber" 
   aa_value = of_GetDocumentnumber()
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
 case "batched" 
   aa_value = of_GetBatched()
   li_rc = 1
 case "batchdate" 
   aa_value = of_GetBatchdate()
   li_rc = 1
 case "batchnumber" 
   aa_value = of_GetBatchnumber()
   li_rc = 1
end choose

//@(text)--

//@(text)(recreate=yes)<return value>
return li_rc
//@(text)--

end function

public function Integer of_SetId (Long al_id);//@(*)[88914054|90:id:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetCategory ();//@(*)[364998730|278:category:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("category")
//@(text)--

end function

public function Integer of_SetCategory (Integer ai_category);//@(*)[364998730|278:category:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetType ();//@(*)[365717254|284:type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("type")
//@(text)--

end function

public function Integer of_SetType (Integer ai_type);//@(*)[365717254|284:type:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "type" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("type", ai_type) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Boolean of_GetFixedamount ();//@(*)[369827613|305:fixedamount:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("fixedamount")
//@(text)--

end function

public function Integer of_SetFixedamount (Boolean ab_fixedamount);//@(*)[369827613|305:fixedamount:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "fixedamount" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("fixedamount", ab_fixedamount) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Integer of_GetStatus ();//@(*)[49783059|318:status:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("status")
//@(text)--

end function

public function integer of_setstatus (integer ai_status);//@(*)[49783059|318:status:s]<nosync>//@(-)Do not edit, move or copy this line//
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
	
		//Do not allow status to be set to history unless Transaction has been closed
	
		IF This.of_GetOpen ( ) = TRUE THEN
			ls_Message = "Status cannot manually be set to history.  If you want to close the "+&
				"transaction, please do so using the menu."
			li_rc = -1
		END IF
	
	CASE ELSE
	
		//Do not allow other statuses to be set if Transaction has been closed
	
		IF This.of_GetOpen ( ) = FALSE THEN
			ls_Message = "Cannot change the status of a closed transaction."
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
	ls_Message += "~n~n(Press Esc twice to undo your edit.)"
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage( ls_Message )
	lnv_Error.SetMessageHeader ( ls_MessageHeader )
END IF

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Boolean of_GetOpen ();//@(*)[145622440|149:open:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("open")
//@(text)--

end function

public function integer of_setopen (boolean ab_open);//@(*)[145622440|149:open:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "open" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--


Boolean	lb_CurrentValue, &
			lb_FlagForBatching, &
			lb_PayrollEntity, &
			lb_PayablesEntity
Integer	li_Count, &
			li_Index, &
			li_SqlCode
Long		ll_EntityId
String	ls_PayablesId, &
			ls_PayrollId, &
			ls_BatchNumber
n_cst_beo_AmountOwed	lnva_Amounts[]
n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_Privileges		lnv_Privileges

lb_CurrentValue = This.of_GetOpen ( )

CHOOSE CASE ab_Open

CASE TRUE

	CHOOSE CASE lb_CurrentValue

	CASE TRUE
		//Value already matches.  Do not reset it.
		RETURN 1

	CASE FALSE
		//Do not allow a closed transaction to be reopened.
		li_rc = -1

	CASE ELSE  //Null
		//Value is being initialized.  Proceed.

	END CHOOSE

CASE FALSE

	IF lb_CurrentValue = FALSE THEN
		//Value already matches.  Do not reset it.
		RETURN 1
	END IF


	//Check whether user has sufficient privileges.

	IF lnv_Privileges.of_Settlements_CloseTransaction ( ) = FALSE THEN
		//**Propagate an error message**
		RETURN -1
	END IF


	//Check whether current status is closeable

	IF This.of_IsStatusCloseable ( This.of_GetStatus ( ) ) = FALSE THEN
		//**Propagate an error message**
		RETURN -1
	END IF


	//Get the AmountsList for this transaction.

	li_Count = This.of_GetAmountsList ( lnva_Amounts )

	IF li_Count = -1 THEN
		li_rc = -1

	ELSE

		//Verify that the amounts in the list have a closeable status.  If any don't, abort.

		//New in 2.7.00 : Verify that the amounts in the list have an amount type and a division.
		//If any don't, abort.  (This whole test could possibly be moved to the Amount beo, 
		//in an of_IsClosable method.)

		FOR li_Index = 1 TO li_Count

			IF lnva_Amounts [ li_Index ].of_IsStatusCloseable ( ) = FALSE THEN
				//**Propagate an error message**
				li_rc = -1
				EXIT
			END IF

			IF IsNull ( lnva_Amounts [ li_Index ].of_GetType ( ) ) OR &
				IsNull ( lnva_Amounts [ li_Index ].of_GetDivision ( ) ) THEN
				//**Propagate an error message**
				li_rc = -1
				EXIT
			END IF

		NEXT


		IF li_rc > 0 THEN

			//Attempt to close all the amounts in the list.  If any fail, abort.
			//**There's the possibility here for some amounts to get closed and others
			//**to remain open.  Should this be a fatal error??  IsStatusClosable returns
			//TRUE for amounts with a history status, so a second attempt would not fail 
			//on those grounds.
	
			FOR li_Index = 1 TO li_Count
	
				IF lnva_Amounts [ li_Index ].of_SetOpen ( FALSE ) = -1 THEN
					li_rc = -1
					EXIT
				END IF
	
			NEXT

		END IF

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


//If we just closed the Transaction (successfully), set Status to History

IF li_rc > 0 AND &
	ab_Open = FALSE THEN

	IF This.of_SetStatus ( ci_Status_History ) = -1 THEN
		//Open and Status settings now conflict.  We should:
		//Attempt to reset Status value.
		//If unsuccessful, raise fatal exception.
	END IF

	IF This.of_SetDocumentDate ( Today ( ) ) = -1 THEN
		//Error handling
	END IF

	IF This.of_SetDocumentNumber ( String ( This.of_GetId ( ), "0000" ) ) = -1 THEN
		//Error handling
	END IF

	li_rc = 2


	//Handle flagging of transaction for batching

	//Get the transaction manager.  We'll need it.
	lnv_TransactionManager = This.of_GetTransactionManager ( )

	ll_EntityId = This.of_GetfkEntity ( )

	SELECT PayablesId, PayrollId INTO :ls_PayablesId, :ls_PayrollId
	FROM Entity WHERE Id = :ll_EntityId ;

	li_SqlCode = SQLCA.SqlCode

	COMMIT ;

	CHOOSE CASE li_SqlCode

	CASE 100, -1  //Not found, error
		//Ask the user later.
		SetNull ( lb_FlagForBatching )

	CASE ELSE

		//Determine which type of entity it is.
		IF Len ( ls_PayablesId ) > 0 THEN
			lb_PayablesEntity = TRUE
		END IF

		IF Len ( ls_PayrollId ) > 0 THEN
			lb_PayrollEntity = TRUE
		END IF

		IF lb_PayablesEntity AND NOT lb_PayrollEntity THEN
			//It's a Payables Entity.  Use the appropriate system setting.
			IF IsValid ( lnv_TransactionManager ) THEN
				lb_FlagForBatching = lnv_TransactionManager.of_GetCreatePayablesBatches ( )
			ELSE
				SetNull ( lb_FlagForBatching )  //Can't determine.  Ask user later.
			END IF

		ELSEIF lb_PayrollEntity AND NOT lb_PayablesEntity THEN
			//It's a Payroll Entity.  Use the appropriate system setting.
			IF IsValid ( lnv_TransactionManager ) THEN
				lb_FlagForBatching = lnv_TransactionManager.of_GetCreatePayrollBatches ( )
			ELSE
				SetNull ( lb_FlagForBatching )  //Can't determine.  Ask user later.
			END IF

		ELSE
			//It's both or it's neither.  See if the system setting is the same either way.
			//If so, use it.  If not, ask the user later.

			IF IsValid ( lnv_TransactionManager ) THEN

				//Start with one...
				lb_FlagForBatching = lnv_TransactionManager.of_GetCreatePayablesBatches ( )
	
				//Then compare to the other one...
				IF lb_FlagForBatching = lnv_TransactionManager.of_GetCreatePayrollBatches ( ) THEN
					//They're the same.  Use the value.
				ELSE
					//They're not the same.  Ask the user later.
					SetNull ( lb_FlagForBatching )
				END IF

			ELSE
				SetNull ( lb_FlagForBatching )  //Can't determine.  Ask user later.

			END IF

		END IF

	END CHOOSE


	IF IsNull ( lb_FlagForBatching ) THEN

		CHOOSE CASE MessageBox ( "Close Transaction", "Could not determine based on entity and system settings "+&
			"whether this transaction will need to be batched.  Do you want it to be batched?~n~n"+&
			"NOTE: Selecting NO will pass the transaction to history without making it available for batching.", &
			Question!, YesNo!, 1 )

		CASE 1 //Yes -- Flag it for batching
			lb_FlagForBatching = TRUE

		CASE 2 //No -- Don't flag it for batching
			lb_FlagForBatching = FALSE

		CASE ELSE  //Unexpected value (shouldn't happen).
			//????

		END CHOOSE

	END IF


	//If we've determined that we need to flag the batch, do so.
	IF lb_FlagForBatching = TRUE THEN

		This.of_SetBatched ( FALSE)  //FALSE means "hasn't been batched yet, but needs to be"

		//Try to get a BatchNumber here, and set it if the user gives us one.
		IF IsValid ( lnv_TransactionManager ) THEN
			
			ls_BatchNumber = This.of_GetBatchNumber ( )

			IF IsNull ( ls_BatchNumber ) THEN

				IF lnv_TransactionManager.of_BatchDialog ( "Select Batch", &
					"Do you want to assign this transaction to a batch at this point?~r~n~r~n"+&
					"(If you choose No, PTADMIN can assign the transaction to a batch later.)", &
					"YESNO!", ls_BatchNumber ) = 1 THEN
	
					This.SetActionSource ( ci_ActionSource_System )
					This.of_SetBatchNumber ( ls_BatchNumber )
					This.RestoreActionSource ( )
	
				END IF
				
			END IF

		END IF

	ELSE
		//The value for "don't batch" is null, which is what it is now.
	END If


END IF


//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Date of_GetDocumentdate ();//@(*)[145570459|148:documentdate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("documentdate")
//@(text)--

end function

public function Integer of_SetDocumentdate (Date ad_documentdate);//@(*)[145570459|148:documentdate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "documentdate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("documentdate", ad_documentdate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetDescription ();//@(*)[366685068|295:description:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("description")
//@(text)--

end function

public function Integer of_SetDescription (String as_description);//@(*)[366685068|295:description:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetInternalnote ();//@(*)[366701589|296:internalnote:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("internalnote")
//@(text)--

end function

public function Integer of_SetInternalnote (String as_internalnote);//@(*)[366701589|296:internalnote:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetPublicnote ();//@(*)[366715001|297:publicnote:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("publicnote")
//@(text)--

end function

public function Integer of_SetPublicnote (String as_publicnote);//@(*)[366715001|297:publicnote:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetRef1type ();//@(*)[366737300|298:ref1type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref1type")
//@(text)--

end function

public function Integer of_SetRef1type (Integer ai_ref1type);//@(*)[366737300|298:ref1type:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetRef1text ();//@(*)[369031962|299:ref1text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref1text")
//@(text)--

end function

public function Integer of_SetRef1text (String as_ref1text);//@(*)[369031962|299:ref1text:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetRef2type ();//@(*)[369047189|300:ref2type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref2type")
//@(text)--

end function

public function Integer of_SetRef2type (Integer ai_ref2type);//@(*)[369047189|300:ref2type:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetRef2text ();//@(*)[369058307|301:ref2text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref2text")
//@(text)--

end function

public function Integer of_SetRef2text (String as_ref2text);//@(*)[369058307|301:ref2text:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Integer of_GetRef3type ();//@(*)[369072389|302:ref3type:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref3type")
//@(text)--

end function

public function Integer of_SetRef3type (Integer ai_ref3type);//@(*)[369072389|302:ref3type:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function String of_GetRef3text ();//@(*)[369085527|303:ref3text:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("ref3text")
//@(text)--

end function

public function Integer of_SetRef3text (String as_ref3text);//@(*)[369085527|303:ref3text:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function Date of_GetStartdate ();//@(*)[370538728|310:startdate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("startdate")
//@(text)--

end function

public function Integer of_SetStartdate (Date ad_startdate);//@(*)[370538728|310:startdate:s]<nosync>//@(-)Do not edit, move or copy this line//
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

		ld_EndDate = This.of_GetEndDate ( )

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

public function Date of_GetEnddate ();//@(*)[370551671|311:enddate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("enddate")
//@(text)--

end function

public function Integer of_SetEnddate (Date ad_enddate);//@(*)[370551671|311:enddate:s]<nosync>//@(-)Do not edit, move or copy this line//
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

protected function String of_GetModlog ();//@(*)[49865825|320:modlog:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("modlog")
//@(text)--

end function

protected function Integer of_SetModlog (String as_modlog);//@(*)[49865825|320:modlog:s]<nosync>//@(-)Do not edit, move or copy this line//
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

public function n_cst_beo of_getentity ();//@(*)[370292092|308:o]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--


//If there is a TransactionManager, use it to get the entity beo instead of normal
//relationship method processing.  If the TransactionManager can't get the beo, 
//we will allow the request to fail, NOT resort to the normal processing, because
//if there's a TransactionManager, you wouldn't want the new individual entity bcm 
//getting retrieved.

n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_beo_Entity	lnv_Entity

lnv_TransactionManager = This.of_GetTransactionManager ( )

IF IsValid ( lnv_TransactionManager ) THEN

	lnv_TransactionManager.of_GetEntity ( This.of_GetfkEntity ( ), lnv_Entity )

	RETURN lnv_Entity

END IF



//@(text)(recreate=yes)<Return BEO>
return this.of_GetEntity(ls_dlkname)
//@(text)--

end function

public function n_cst_beo of_GetEntity (String as_query);//@(*)[370292092|308]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_entity = GetRelationship( inv_entity, "n_cst_dlkc_entity",  "entity", "transaction", as_query, "n_cst_beo_entity" )
//@(text)--

//@(text)(recreate=yes)<Return BEO>
return inv_entity
//@(text)--

end function

public function Integer of_SetEntity (n_cst_beo anv_entity);//@(*)[370292092|308:so]<nosync>//@(-)Do not edit, move or copy this line//
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

public function n_cst_bcm of_GetAmountowed (String as_query);//@(*)[363460197|276]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
inv_amountowed = GetRelationship( inv_amountowed, "n_cst_dlkc_amountowed", "amountowed", "transaction", as_query )
inv_amountowed.AddClass("n_cst_beo_amountowed")
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return inv_amountowed
//@(text)--

end function

public function n_cst_bcm of_GetAmountowed ();//@(*)[363460197|276:d]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

String ls_dlkname = ""
//@(text)--

//@(text)(recreate=yes)<Return BCM>
return this.of_GetAmountowed(ls_dlkname)
//@(text)--

end function

public function Decimal of_GetTaxablegross ();//@(*)[72837595|452:taxablegross:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("taxablegross")
//@(text)--

end function

public function Integer of_SetTaxablegross (Decimal ad_taxablegross);//@(*)[72837595|452:taxablegross:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "taxablegross" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("taxablegross", ad_taxablegross) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetNontaxablegross ();//@(*)[72880621|453:nontaxablegross:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("nontaxablegross")
//@(text)--

end function

public function Integer of_SetNontaxablegross (Decimal ad_nontaxablegross);//@(*)[72880621|453:nontaxablegross:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "nontaxablegross" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("nontaxablegross", ad_nontaxablegross) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Decimal of_GetPretaxnet ();//@(*)[88951085|91:pretaxnet:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("pretaxnet")
//@(text)--

end function

public function Integer of_SetPretaxnet (Decimal ad_pretaxnet);//@(*)[88951085|91:pretaxnet:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "pretaxnet" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("pretaxnet", ad_pretaxnet) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetDocumentnumber ();//@(*)[369469411|304:documentnumber:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("documentnumber")
//@(text)--

end function

public function Integer of_SetDocumentnumber (String as_documentnumber);//@(*)[369469411|304:documentnumber:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "documentnumber" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("documentnumber", as_documentnumber) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Long of_GetId ();//@(*)[88914054|90:id:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("id")
//@(text)--

end function

public function Integer of_calculate ();//@(*)[60058842|526]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns : 1, -1

n_cst_beo_AmountOwed	lnva_Amounts[], &
							lnv_Amount
Integer	li_Count, &
			li_Index
Decimal	lc_Amount, &
			lc_TaxableGross, &
			lc_NonTaxableGross, &
			lc_PreTaxNet
Boolean	lb_Taxable, &
			lb_FixedAmount


lb_FixedAmount = This.of_GetFixedAmount ( )

IF lb_FixedAmount = TRUE THEN

	//Amounts are determined by user entry on the transaction, not by the sum of 
	//related AmountsOwed.  Get the user-entered values.
	lc_TaxableGross = This.of_GetTaxableGross ( )
	lc_NonTaxableGross = This.of_GetNonTaxableGross ( )

ELSEIF lb_FixedAmount = FALSE THEN

	//Amounts are calculated from the related AmounntsOwed.  Process them.

	//Get the list of transaction amounts.
	
	li_Count = This.of_GetAmountsList ( lnva_Amounts )
	
	IF li_Count = -1 THEN
		RETURN -1
	END IF
	
	
	//Total the taxable and non-taxable amounts from the amounts list.

	FOR li_Index = 1 TO li_Count
	
		lnv_Amount = lnva_Amounts [ li_Index ]
	
		lb_Taxable = lnv_Amount.of_GetTaxable ( )
		lc_Amount = lnv_Amount.of_GetAmount ( )
	
		IF IsNull ( lc_Amount ) THEN
			CONTINUE
		ELSEIF IsNull ( lb_Taxable ) THEN
			lb_Taxable = TRUE
		END IF
	
		IF lb_Taxable THEN
			lc_TaxableGross += lc_Amount
		ELSE
			lc_NonTaxableGross += lc_Amount
		END IF
	
	NEXT

ELSE
	//No value for FixedAmount.  Fail.
	RETURN -1

END IF

lc_PreTaxNet = lc_TaxableGross + lc_NonTaxableGross

IF SetValue ( "taxablegross", lc_TaxableGross ) < 1 THEN
	RETURN -1
ELSEIF SetValue ( "nontaxablegross", lc_NonTaxableGross ) < 1 THEN
	SetValue ( "taxablegross", 0 )
	RETURN -1
ELSEIF  SetValue ( "pretaxnet", lc_PreTaxNet ) < 1 THEN
	SetValue ( "taxablegross", 0 )
	SetValue ( "nontaxablegross", 0 )
	RETURN -1
END IF

RETURN 1
end function

public function Integer of_unassignall ();//@(*)[147178079|717]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns : 1, -1

n_cst_beo_AmountOwed	lnva_Amounts[], &
							lnv_Amount
Integer	li_Count, &
			li_Index


//Get the list of transaction amounts.

li_Count = This.of_GetAmountsList ( lnva_Amounts )

IF li_Count = -1 THEN
	RETURN -1
END IF


//Unassign the amounts in the list.  Unassign will force recalculation of transaction totals, 
//and handle any fatal exceptions.

FOR li_Index = 1 TO li_Count

	lnv_Amount = lnva_Amounts [ li_Index ]

	IF lnv_Amount.of_Unassign ( ) = 1 THEN
		//Unassigned successfully.  Proceed.

	ELSE
		RETURN -1

	END IF

NEXT

RETURN 1
end function

public function Integer of_getamountslist (ref n_cst_beo_amountowed an_amountslist[]);//@(*)[181455594|718]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns : >= 0 Number of amounts in list (success), -1 = Failure

n_cst_bso_TransactionManager	lnv_TransactionManager
Integer	li_Count, &
			li_Return

li_Return = -1

//TransactionManager is needed in order to get a list of related amounts.
lnv_TransactionManager = This.of_GetTransactionManager ( )

IF IsValid ( lnv_TransactionManager ) THEN

	//Get the list of transaction amounts.
	li_Count = lnv_TransactionManager.of_GetTransactionAmounts ( This.of_GetId ( ), an_AmountsList )
	
	IF li_Count >= 0 THEN
		li_Return = li_Count
	END IF

END IF

RETURN li_Return
end function

protected function Boolean of_isstatuscloseable (integer ai_status);//@(*)[49935167|725]//@(-)Do not edit, move or copy this line//
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

public function integer of_print ();//@(*)[43256933|760]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


n_ds	lds_Transaction, &
		lds_Amount, &
		lds_Composite
DataWindowChild	ldwc_Transaction, &
						ldwc_Amount
n_cst_bso_TransactionManager	lnv_TransactionManager
n_cst_Presentation_transaction	lnv_Presentation_transaction
n_cst_Presentation_amountOwed		lnv_presentation_AmountOwed

n_cst_LicenseManager	lnv_LicenseManager
String	lsa_Empty[], &
			lsa_Reports[], &
			ls_LicensedCompany, &
			ls_EntityDescription, &
			ls_AccountingId, &
			ls_Type
			
Border	lea_Border[]
Long		ll_Id

Integer	li_Return = 1


SetPointer ( HourGlass! )

lnv_TransactionManager = This.of_GetTransactionManager ( )
ls_LicensedCompany = lnv_LicenseManager.of_GetLicensedCompany ( )
ll_Id = This.of_GetId ( )


IF NOT IsValid ( lnv_TransactionManager ) THEN

	//Can't perform procedure without TransactionManager.
	li_Return = -1

ELSEIF NOT lnv_TransactionManager.of_LoadTransactionAmounts ( { ll_Id } ) = 1 THEN

	//Cant perform procedure without TransactionAmounts loaded.
	li_Return = -1

END IF


IF li_Return = 1 THEN

	ls_EntityDescription = lnv_TransactionManager.of_DescribeEntity ( This.of_GetfkEntity ( ), 0 )

	ls_AccountingId = this.of_GetAccountingId(ls_type)
	
	IF isnull(ls_AccountingId) or len(trim(ls_AccountingId)) = 0 then
		//no id
	ELSE
		ls_EntityDescription = ls_EntityDescription + '  [' + ls_AccountingId + ']'
	END IF
	
	n_cst_string lnv_string
	If Pos(ls_EntityDescription, "'") > 0 Then
		ls_EntityDescription = lnv_string.of_GlobalReplace (ls_EntityDescription, "'", "~~~~~~'")
	End If	
	
	lds_Transaction = CREATE n_ds
	lds_Transaction.DataObject = "d_TransactionReport"
	lds_Transaction.SetFilter ( "transaction_id = " + String ( ll_Id ) )
	lds_Transaction.SetUILink(TRUE)
	lds_Transaction.inv_uilink.SetClass("")
	lds_Transaction.inv_UILink.SetBcm ( lnv_TransactionManager.of_GetTransactions ( ) )
	
	
	lds_Amount = CREATE n_ds
	lds_Amount.DataObject = "d_AmountOwedReport"
	lds_Amount.SetFilter ( "amountowed_fktransaction = " + String ( ll_Id ) )
	//old sort
//	lds_Amount.SetSort ( "amountowed_startdate A, amountowed_taxable D, amountowed_type A, amountowed_id A" )
	//new sort
	lds_Amount.SetSort ( "amountowed_startdate A, amountowed_id A" )
	lds_Amount.SetUILink(TRUE)
	lds_Amount.inv_uilink.SetClass("")
	lds_Amount.inv_UILink.SetBcm ( lnv_TransactionManager.of_GetAmountsOwed ( ) )

	lds_Composite = CREATE n_ds
	lds_Composite.of_SetReport ( TRUE )
	lds_Composite.inv_Report.of_CreateComposite ( { "d_TransactionReport", "d_AmountOwedReport" }, TRUE, &
		lsa_Empty, lsa_Empty, lea_Border )
	
	Constant Boolean	lb_VisibleOnly = TRUE
	lds_Composite.inv_Report.of_GetObjects ( lsa_Reports, "report", "detail", lb_VisibleOnly )

//transaction
	IF lds_Composite.GetChild ( lsa_Reports [ 1 ], ldwc_Transaction ) = 1 THEN
		ldwc_Transaction.Modify ( "DataWindow.ReadOnly = Yes" )   //To flag report processing in Presentation svc.
		ldwc_Transaction.Modify ( "cf_LicensedCompany.Expression = '~~'" + ls_LicensedCompany + "~~''" )
		ldwc_Transaction.Modify ( "cf_EntityName.Expression = '~~'" + ls_EntityDescription + "~~''" )
		lnv_Presentation_Transaction.of_SetPresentation ( ldwc_Transaction )
		lds_Transaction.ShareData ( ldwc_Transaction )
	END IF
	
//amount
	IF lds_Composite.GetChild ( lsa_Reports [ 2 ], ldwc_Amount ) = 1 THEN
		ldwc_Amount.Modify ( "DataWindow.ReadOnly = Yes" )   //To flag report processing in Presentation svc.
		ldwc_Amount.Modify ( "cf_EntityName.Expression = '~~'" + ls_EntityDescription + "~~''" )
		lnv_Presentation_AmountOwed.of_SetPresentation ( ldwc_Amount )
	
		n_cst_presentation_amounttype lnv_presentationamounttype
		lnv_presentationamounttype.of_setcategory(n_cst_constants.ci_category_payables)
		lnv_presentationamounttype.of_setpresentation(ldwc_Amount)

		lds_Amount.ShareData ( ldwc_Amount )
	END IF

	Constant Boolean	lb_ConvertHeader = FALSE
	Constant Boolean	lb_CancelDialog = FALSE
	lds_Composite.inv_Report.of_PrintReport ( lb_ConvertHeader, lb_CancelDialog )


	DESTROY lds_Transaction
	DESTROY lds_Amount
	DESTROY lds_Composite

END IF

RETURN li_Return




///////////////////////////////

//	IF lds_Composite.GetChild ( lsa_Reports [ 1 ], ldwc_Transaction ) = 1 THEN
//		IF lds_Transaction.RowCount ( ) > 0 THEN
////			MessageBox ( "Insert", String ( ldwc_Transaction.InsertRow ( 0 ) ) )
////			MessageBox ( "Insert", String ( ldwc_Transaction.InsertRow ( 0 ) ) )
//			MessageBox ( "ShareData", String ( lds_Transaction.ShareData ( ldwc_Transaction ) ) )
//			MessageBox ( "RowCount", String ( ldwc_Transaction.RowCount ( ) ) )
////			MessageBox ( "Copy", String ( lds_Transaction.RowsCopy ( 1, lds_Transaction.RowCount ( ), Primary!, ldwc_Transaction, 0, Primary! ) ) )
//		ELSE
//			MessageBox ( "Hello", "No Rows" )
//		END IF
//	END IF
end function

public function n_cst_bso_transactionmanager of_gettransactionmanager ();//@(*)[45652125|762]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Determine whether the bso context (if any) for this transaction is 
//a transaction manager, and if so, return it.

n_cst_bso	lnv_Context
n_cst_bso_TransactionManager	lnv_TransactionManager

lnv_Context = This.GetContext ( )

IF IsValid ( lnv_Context ) THEN

	IF lnv_Context.TriggerEvent ( "ue_IsTransactionManager" ) = 1 THEN
		lnv_TransactionManager = lnv_Context
	END IF

END IF

RETURN lnv_TransactionManager
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

public function Boolean of_isstatusactive ();//@(*)[163710056|1259]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusActive ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusrestricted ();//@(*)[163760112|1260]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusRestricted ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusaudited ();//@(*)[163814771|1261]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusAudited ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatushistory ();//@(*)[163844981|1262]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

RETURN This.of_IsStatusHistory ( This.of_GetStatus ( ) )
end function

public function Boolean of_isstatusactive (integer ai_status);//@(*)[163856439|1263]//@(-)Do not edit, move or copy this line//
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

public function Boolean of_isstatusrestricted (integer ai_status);//@(*)[163884119|1265]//@(-)Do not edit, move or copy this line//
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

public function Boolean of_isstatusaudited (integer ai_status);//@(*)[163939040|1269]//@(-)Do not edit, move or copy this line//
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

public function Boolean of_isstatushistory (integer ai_status);//@(*)[163909776|1267]//@(-)Do not edit, move or copy this line//
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

public function Boolean of_GetBatched ();//@(*)[67568891|1626:batched:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("batched")
//@(text)--

end function

public function integer of_setbatched (boolean ab_batched);//@(*)[67568891|1626:batched:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "batched" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--
Date ld_Today 
IF li_rc > 0 THEN
	IF ab_Batched = TRUE THEN
		ld_Today = Date ( DateTime ( Today ( ) ) )
		This.of_SetBatchdate ( ld_Today )
		li_rc = 2
	ELSEIF ab_Batched = FALSE THEN
		SetNull ( ld_Today )
		This.of_SetBatchdate ( ld_Today )
		li_rc = 2
	END IF
END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("batched", ab_batched) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function Date of_GetBatchdate ();//@(*)[67632825|1627:batchdate:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("batchdate")
//@(text)--

end function

public function Integer of_SetBatchdate (Date ad_batchdate);//@(*)[67632825|1627:batchdate:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "batchdate" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--




//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("batchdate", ad_batchdate) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function String of_GetBatchnumber ();//@(*)[67646698|1628:batchnumber:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>
return GetValue("batchnumber")
//@(text)--

end function

public function integer of_setbatchnumber (string as_batchnumber);//@(*)[67646698|1628:batchnumber:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Define Return Value>
integer li_rc = 1

// Validation logic for "batchnumber" attribute goes after this fragment.
// Set li_rc to -1 if validation fails.
// Set li_rc to 2 if other attributes have been modified.
//@(text)--

n_cst_Privileges	lnv_Privileges

IF li_rc > 0 THEN

	IF This.of_GetOpen ( ) = TRUE THEN

		IF This.AllowEdit ( cb_UserField, cb_Restricted ) = FALSE THEN
			li_rc = -1
		END IF

	ELSEIF lnv_Privileges.of_HasSysAdminRights ( ) OR This.SystemAction ( ) THEN

		//Change is OK

	ELSE
		li_rc = -1

	END IF


	IF li_rc = -1 THEN
		MessageBox ( "Batch Assignment: Transaction " + String ( This.of_GetId ( ) ), &
			lnv_Privileges.of_GetRestrictMessage ( ) )
	END IF

END IF


//@(text)(recreate=yes)<Set Value>
if li_rc > 0 then
   if SetValue("batchnumber", as_batchnumber) < 1 then
      li_rc = -1
   end if
end if
//@(text)--

//@(text)(recreate=yes)<Return Value>
return li_rc
//@(text)--

end function

public function string of_getaccountingid (ref string as_type);long		ll_EntityId

string	ls_PayablesId, &
			ls_PayrollId, &
			ls_accountingid

boolean	lb_PayablesEntity, &
			lb_PayrollEntity

ll_EntityId = This.of_GetfkEntity ( )

SELECT PayablesId, PayrollId INTO :ls_PayablesId, :ls_PayrollId
FROM Entity WHERE Id = :ll_EntityId ;

COMMIT ;

CHOOSE CASE SQLCA.SqlCode

	CASE 100, -1  //Not found, error
		ls_AccountingId = ''
		
	CASE ELSE

		//Determine which type of entity it is.
		IF Len ( ls_PayablesId ) > 0 THEN
			lb_PayablesEntity = TRUE
		END IF

		IF Len ( ls_PayrollId ) > 0 THEN
			lb_PayrollEntity = TRUE
		END IF

		IF lb_PayablesEntity AND NOT lb_PayrollEntity THEN
			//It's a Payables Entity.  Use the appropriate system setting.
			ls_accountingid = ls_PayablesId
			as_type = 'AP'
		ELSEIF lb_PayrollEntity AND NOT lb_PayablesEntity THEN
			//It's a Payroll Entity.  Use the appropriate system setting.
			ls_accountingid = ls_PayrollId
			as_type = 'PR'
		ELSE
			//It's both or it's neither.
			ls_AccountingId = ''
			setnull(as_type)
		END IF
		
END CHOOSE

return ls_AccountingId
end function

public function long of_getamountslist (ref long ala_id[]);long	ll_ndx, &
		ll_count, &
		lla_id[]

n_cst_beo_amountowed	lnva_amountowed[]

this.of_GetAmountsList(lnva_Amountowed)

ll_count = upperbound(lnva_Amountowed)

for ll_ndx = 1 to ll_count
	
	lla_id[ll_ndx] = lnva_Amountowed[ll_ndx].of_GetId()
	
next

ala_id = lla_id

return upperbound(lla_id)


end function

on n_cst_beo_transaction.create
call super::create
end on

on n_cst_beo_transaction.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<init>
this.SetRequired("id")
this.SetRequired("category")
this.SetRequired("type")
this.SetRequired("taxablegross")
this.SetRequired("nontaxablegross")
this.SetRequired("pretaxnet")
this.SetRequired("fixedamount")
this.SetRequired("status")
this.SetRequired("open")
//@(data)--

//@(text)(recreate=yes)<body>

//@(text)--

end event

event ofr_postnew;call super::ofr_postnew;//Extending ancestor script.  Perform initialization and set any defaults.
//Return : 1, -1

Long	ll_NextId, &
		ll_DefaultEntityId
Integer	li_DefaultCategory, &
			li_Return
n_cst_bso_TransactionManager	lnv_TransactionManager


IF AncestorReturnValue = 1 THEN


	//TransactionManager is needed in order to get other optional defaults.
	lnv_TransactionManager = This.of_GetTransactionManager ( )

	IF IsValid ( lnv_TransactionManager ) THEN

		li_DefaultCategory = lnv_TransactionManager.of_GetDefaultCategory ( )
		ll_DefaultEntityId = lnv_TransactionManager.of_GetDefaultEntityId ( )

		IF lnv_TransactionManager.of_GetNewRequiresEntity ( ) THEN

			IF IsNull ( ll_DefaultEntityId ) THEN
				RETURN -1
			END IF

		END IF

	END IF


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


	//Set various default values

	IF This.of_SetOpen ( TRUE ) < 1 THEN
		li_Return = -1  //Fail
	ELSEIF This.of_SetStatus ( ci_Status_Open ) < 1 THEN
		li_Return = -1  //Fail
	ELSEIF This.of_SetTaxableGross ( 0 ) < 1 THEN
		li_Return = -1  //Fail
	ELSEIF This.of_SetNonTaxableGross ( 0 ) < 1 THEN
		li_Return = -1  //Fail
	ELSEIF This.of_SetPreTaxNet ( 0 ) < 1 THEN
		li_Return = -1  //Fail
	END IF


	//If we have the TransactionManager, set optional defaults.

	IF IsValid ( lnv_TransactionManager ) THEN

		CHOOSE CASE li_DefaultCategory

		CASE n_cst_Constants.ci_Category_Payables
	
			This.of_SetCategory ( li_DefaultCategory )
			This.of_SetType ( ci_Type_Settlement )
			This.of_SetFixedAmount ( FALSE )

			IF NOT IsNull ( ll_DefaultEntityId ) THEN
				This.of_SetfkEntity ( ll_DefaultEntityId )
			END IF

		END CHOOSE

	ELSE
		//Ignore and proceed.
	
	END IF

ELSE
	li_Return = AncestorReturnValue

END IF

RETURN li_Return
end event

event ofr_predelete;call super::ofr_predelete;//Extending ancestor script.
//We need to unassign all amounts from the transaction before deleting it.

//Return : 1 = Proceed with delete, <> 1 = Abort delete


Integer	li_Return

//Verify that delete has not already been rejected in the ancestor.
li_Return = AncestorReturnValue


//Check whether edits of any kind are allowed on the transaction for this user, 
//given its current status.

IF li_Return = 1 THEN

	IF This.AllowEdit ( cb_UserField, cb_Restricted ) = FALSE THEN
		li_Return = -1
	END IF

END IF


//If OK so far, attempt to unassign the amounts from the transaction.

IF li_Return = 1 THEN

	IF This.of_UnassignAll ( ) = 1 THEN
		//Amounts were successfully unassigned.  Proceed with delete.

	ELSE
		//Amounts were not unassigned.  Abort delete.
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

