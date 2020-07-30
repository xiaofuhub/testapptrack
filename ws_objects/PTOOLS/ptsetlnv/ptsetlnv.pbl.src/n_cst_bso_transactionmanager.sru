$PBExportHeader$n_cst_bso_transactionmanager.sru
$PBExportComments$TransactionManager (Non-persistent Class from PBL map PTSetl) //@(*)[228453964|173]
forward
global type n_cst_bso_transactionmanager from n_cst_bso
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_transactionmanager sn_n_cst_bso_transactionmanager_a[] //@(*)[228453964|173:n]<nosync>
Integer sn_n_cst_bso_transactionmanager_c //@(*)[228453964|173:c]<nosync>
//@(text)--

String    ssa_BatchNames[]
//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_transactionmanager from n_cst_bso
event type boolean ue_istransactionmanager ( )
end type
global n_cst_bso_transactionmanager n_cst_bso_transactionmanager

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
private Integer ii_defaultcategory //@(*)[60764744|518]
private Long il_defaultentityid //@(*)[60878513|519]
//@(text)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Constant String	cs_TagKey_Optional = "Optional"

Constant String	cs_Loaded_AllTransactions = "AT"
Constant String	cs_Loaded_OpenTransactions = "OT"
Constant String	cs_Loaded_Transactions = "TR"
Constant String	cs_Loaded_UnbatchedTransactions = "UT"
Constant String	cs_Loaded_UnassignedAmounts = "UA"
Constant String	cs_Loaded_TransactionAmounts = "TA"
Constant String	cs_Loaded_Entities = "EN"

Private n_cst_ValueList	inv_Loaded
Private n_ds		ids_EntityCache
Private n_ds		ids_PaySplitCache

//The following two values are used when creating amounts.
Private Long	il_MostRecentEntityId
Private Long	il_MostRecentEntityDivision
Private Long	il_ItineraryId
Private Boolean	ib_NewRequiresEntity = FALSE
Private Integer	ii_ItineraryType
Private Integer	ii_BreakdownType
Private Integer	ii_RouteType
Private Boolean	ib_RouteTypeDefined
Private Boolean	ib_WholeDateRange
Private Date	id_Start
Private Date	id_End
Private Long	il_GeneratedCount
Private n_cst_msg	inv_RangeMsg
Private n_cst_beo_AmountTemplate inva_AmountTemplate[]
Private n_cst_beo_Itinerary2	inv_Itinerary
Private long	ila_NewAmountId[]
end variables

forward prototypes
public function n_cst_bcm of_getamountsowed ()
public function n_cst_bcm of_gettransactions ()
public function n_cst_bcm of_retrieveopentransactions (long al_entityid)
public function n_cst_beo_amountowed of_newamountowed ()
public function n_cst_beo_amountowed of_newamountowed (n_cst_beo_transaction an_transaction)
public function Integer of_GetDefaultcategory ()
public function Integer of_SetDefaultcategory (Integer ai_defaultcategory)
public function Long of_GetDefaultentityid ()
public function Integer of_SetDefaultentityid (Long al_defaultentityid)
public function Integer of_gettransactionamounts (long al_transactionid, ref n_cst_beo_amountowed an_amountslist[])
public function integer of_gettransaction (long al_transactionid, ref n_cst_beo_transaction an_transaction)
public function Integer of_autoassign (n_cst_beo_transaction an_transaction)
public function Integer of_getratetype (integer ai_id, ref n_cst_beo_ratetype an_ratetype)
public function Integer of_getamounttype (integer ai_id, ref n_cst_beo_amounttype an_amounttype)
public function Integer of_makecompanyentity (long al_companyid, ref long al_entityid)
public function integer of_getcompanyentity (long al_companyid, ref long al_entityid)
public function string of_describeentity (long al_entityid, integer ai_describetype)
protected function Integer of_tagreferencedfields (ref n_ds an_target, ref n_cst_beo_amounttemplate an_amounttemplates[])
protected function Integer of_purgeoptionalfields (n_ds an_target)
public function n_cst_beo_transaction of_newtransaction ()
public function Integer of_getroutetypesettlements (ref integer ai_routetype)
public function n_cst_bcm of_retrievetransactions (long ala_transactionids[])
public function Integer of_loadtransactions (long ala_transactionids[])
public function n_cst_bcm of_retrievetransactionamounts (long ala_transactionids[])
public function Integer of_loadtransactionamounts (long ala_transactionids[])
public function Integer of_loadopentransactions (long al_entityid)
public function n_cst_bcm of_retrieveunassignedamounts (long al_entityid)
public function Integer of_loadunassignedamounts (long al_entityid)
public function Boolean of_isloaded (string as_valuetype, long al_id)
public function Integer of_setloaded (string as_valuetype, long al_id)
private function String of_makeloadedvalue (string as_valuetype, long al_id)
public function n_cst_bcm of_retrieveshipmentamounts (long ala_shipmentids[])
public function Integer of_loadshipmentamounts (long ala_shipmentids[])
public function n_cst_bcm of_retrievetripamounts (long ala_tripids[])
public function Integer of_loadtripamounts (long ala_tripids[])
public function n_cst_bcm of_retrieveunbatchedtransactions (long al_entityid)
public function Integer of_loadunbatchedtransactions (long al_entityid)
public function n_cst_bcm of_retrievetransactions (long al_entityid, date ad_min, date ad_max)
public function Integer of_loadtransactions (long al_entityid, date ad_min, date ad_max)
public function n_cst_bcm of_retrieveentities (long ala_entityids[])
public function Integer of_loadentities (long ala_entityids[])
public function Integer of_getentity (long al_id, ref n_cst_beo_entity an_entity)
public function Integer of_loadreferencedentities ()
public function n_cst_bcm of_retrievebatch (string as_batchnumber)
public function integer of_loadbatch (string as_batchnumber)
public function Integer of_loadreferencedamounts ()
public function boolean of_getcreatepayablesbatches ()
public function boolean of_getcreatepayrollbatches ()
public function integer of_batchdialog (string as_title, string as_message, string as_buttonset, ref string as_defaultselection)
public function boolean of_getnewrequiresentity ()
public function integer of_setnewrequiresentity (readonly boolean ab_value)
public function long of_getamounttemplate (ref n_cst_beo_amounttemplate anva_amounttemplate[])
private function integer of_setitineraryid ()
private function long of_getitineraryid ()
private subroutine of_setitinerarytype ()
private subroutine of_setbreakdowntype ()
public function integer of_getitinerarytype ()
public function integer of_getitinerarybreakdowntype ()
public subroutine of_setpaysplitcache (datastore ads_PaySplitCache)
public function datastore of_getpaysplitcache (boolean ab_create)
public function long of_getamounttemplate (long ala_id[], ref n_cst_beo_amounttemplate anva_amounttemplate[])
public subroutine of_setinitialitineraryrange (n_cst_msg anv_RangeMsg)
public function n_cst_msg of_getinitialitineraryrange ()
private subroutine of_templateloop (n_cst_beo_transaction an_transaction)
private function decimal of_aggregatecalc (n_cst_beo_amounttemplate anv_amounttemplate, n_cst_beo_transaction an_transaction, string asa_datapoint[], ref n_cst_beo_amountowed anva_amounts[])
public function decimal of_generateamount (ref datastore ads_data, n_cst_beo_amounttemplate anv_amounttemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amountowed anv_amountowed)
public subroutine of_addpaysplit (long al_row, decimal ac_splitsamount, n_cst_beo_amountowed anv_amountowed)
private function long of_linkeventtoshipmentid (datastore ads_event, long al_row)
public function long of_validateitinerarymileage ()
public subroutine of_manualamount (ref n_cst_beo_transaction an_transaction, n_cst_bso_dispatch anv_dispatch, decimal ac_amount, integer ac_amounttype, boolean ac_taxable, date ad_start, date ad_end)
public function long of_getnewamountidlist (ref long ala_newamountid[])
public subroutine of_resetnewamountid ()
public function long of_generatepayable (date ad_start, date ad_end, ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amounttemplate anva_amounttemplate[], n_cst_bso_dispatch anv_dispatch, boolean ab_wholedaterange)
public function long of_loadexpression (n_cst_beo_amounttemplate anv_amount, ref string asa_expression[])
public function long of_getdatapoint (string as_expression, ref string asa_datapoint[])
public function long of_loadcalculationdatastore (string asa_datapoint[], ref datastore ads_calculation)
public function long of_setitineraryobject (n_cst_beo_itinerary2 anv_itinerary)
public function long of_generatepaysplits (n_cst_beo_amounttemplate anv_amounttemplate, string asa_datapoint[], n_cst_beo_amountowed anv_amountowed, decimal ac_totalsplit)
public function long of_createamountowed (ref n_cst_beo_amounttemplate anv_amounttemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amountowed anv_amountowed, ref decimal ac_amount, ref decimal ac_quantity, ref decimal ac_rate, boolean ab_zeroamounttemplate)
public subroutine of_amountoweditinerarydata (ref n_cst_beo_amountowed anv_amount)
public function long of_preprocessautogen (n_cst_beo_entity anva_entities[], date ad_start, date ad_end, n_cst_bso_transactionmanager anv_transactionmanager, ref boolean ab_preprocessingperformed, ref n_ds ads_EntityInfo)
public function long of_unassignedamountcount (n_cst_beo_transaction an_transaction)
public subroutine of_loadpaysplitcache (long ala_amountid[])
public function integer of_getallunassingedentities (ref long ala_unassigned[])
public function integer of_gettransaction (long ala_transactionid[], ref n_cst_beo_transaction anva_transaction[])
end prototypes

event ue_istransactionmanager;//Always returns true.  Used by outside objects to verify whether a context
//instance has TransactionManager capabilities or not.

RETURN TRUE
end event

public function n_cst_bcm of_getamountsowed ();//@(*)[233849414|188]<150205682|321>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_Bcm	lnv_Bcm

GetCache ( "n_cst_dlkc_amountowed", lnv_Bcm )
//Error Check !!

//IF IsValid ( lnv_Bcm ) THEN
//	lnv_Bcm.AddClass ( "n_cst_beo_amountowed" )
//END IF

RETURN lnv_Bcm
end function

public function n_cst_bcm of_gettransactions ();//@(*)[77326144|246]<155155216|325>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_Bcm	lnv_Bcm

GetCache ( "n_cst_dlkc_transaction", lnv_Bcm )
//Error Check !!

RETURN lnv_Bcm
end function

public function n_cst_bcm of_retrieveopentransactions (long al_entityid);//@(*)[156492793|332]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Passing null for al_EntityId will retrieve all open transactions, regardless of entity.

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()

If IsValid(lnv_database) Then

   lnv_query = lnv_database.GetQuery()

	IF IsNull ( al_EntityId ) THEN
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","TransactionsOpen")
	ELSE
		lnv_query.SetArgument(al_entityid)
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","EntityTransactionsOpen")
	END IF

End If

return lnv_bcm
end function

public function n_cst_beo_amountowed of_newamountowed ();//@(*)[60439648|511]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_beo_AmountOwed	lnv_AmountOwed
n_cst_CacheManager	lnv_CacheManager
n_cst_Bcm	lnv_Bcm
Integer	li_DefaultCategory
Long		ll_DefaultEntityId, &
			ll_DefaultDivision

lnv_CacheManager = This.GetCacheManager ( )

IF lnv_CacheManager.of_GetCache ( "n_cst_dlkc_amountowed", lnv_Bcm, TRUE /*CreateNew*/ ) = 1 THEN

	IF lnv_Bcm.NewBeo ( lnv_AmountOwed ) > 0 THEN

		li_DefaultCategory = of_GetDefaultCategory ( )
		ll_DefaultEntityId = of_GetDefaultEntityId ( )

		CHOOSE CASE li_DefaultCategory

		CASE n_cst_Constants.ci_Category_Payables
	
			lnv_AmountOwed.of_SetCategory ( li_DefaultCategory )
//			lnv_AmountOwed.of_SetType ( 1 )

			IF NOT IsNull ( ll_DefaultEntityId ) THEN

				lnv_AmountOwed.of_SetfkEntity ( ll_DefaultEntityId )

				SetNull ( ll_DefaultDivision )

				IF il_MostRecentEntityId = ll_DefaultEntityId THEN
					ll_DefaultDivision = il_MostRecentEntityDivision
				ELSE
					SELECT division INTO :ll_DefaultDivision FROM entity WHERE id = :ll_DefaultEntityId ;
					COMMIT ;
				END IF

				IF NOT IsNull ( ll_DefaultDivision ) THEN
					lnv_AmountOwed.of_SetDivision ( ll_DefaultDivision )
				END IF

				il_MostRecentEntityId = ll_DefaultEntityId
				il_MostRecentEntityDivision = ll_DefaultDivision
				
				ila_NewAmountId [ upperbound (ila_NewAmountId) + 1 ] = lnv_AmountOwed.of_GetId ( )
				
			END IF

		END CHOOSE

	END IF

END IF

RETURN lnv_AmountOwed
end function

public function n_cst_beo_amountowed of_newamountowed (n_cst_beo_transaction an_transaction);//@(*)[60528802|512]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_beo_AmountOwed	lnv_AmountOwed

IF IsValid ( an_Transaction ) THEN

	IF an_Transaction.AllowEdit ( appeon_constant.cb_UserField, &
		appeon_constant.cb_Restricted ) = FALSE THEN

		//**THIS MESSAGEBOX SHOULD BE REPLACE WITH AN OFRERROR!!**
		MessageBox ( "New Transaction Amount", "You are not authorized to make this change.", Exclamation! )

	ELSE

		lnv_AmountOwed = This.of_NewAmountOwed ( )
	
		IF IsValid ( lnv_AmountOwed ) THEN
	
			lnv_AmountOwed.of_SetTransaction ( an_Transaction )
	
		END IF

	END IF

END IF

RETURN lnv_AmountOwed
end function

public function Integer of_GetDefaultcategory ();//@(*)[60764744|518:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return ii_defaultcategory
//@(text)--

end function

public function Integer of_SetDefaultcategory (Integer ai_defaultcategory);//@(*)[60764744|518:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

ii_defaultcategory = ai_defaultcategory
return 1
//@(text)--

end function

public function Long of_GetDefaultentityid ();//@(*)[60878513|519:g]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

return il_defaultentityid
//@(text)--

end function

public function Integer of_SetDefaultentityid (Long al_defaultentityid);//@(*)[60878513|519:s]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<body>

il_defaultentityid = al_defaultentityid
return 1
//@(text)--

end function

public function Integer of_gettransactionamounts (long al_transactionid, ref n_cst_beo_amountowed an_amountslist[]);//@(*)[61080399|527]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns:	>=0 : Number of Amounts
//				 -1 : Error

n_cst_CacheManager	lnv_CacheManager
n_cst_Bcm	lnv_Cache
n_cst_Beo	lnv_Beo
n_cst_beo_AmountOwed	lnva_List[]
n_cst_String	lnv_String
String	ls_Base, &
			ls_Work, &
			ls_Find, &
			lsa_Ids[]
Integer	li_Count, &
			li_Return


//Clear the reference array.
an_AmountsList = lnva_List


//Make sure the requested information has already been retrieved.

IF This.of_LoadTransactionAmounts ( {al_TransactionId} ) = 1 THEN
	//Transaction Amounts have been successfully loaded for this transaction.

ELSE
	//Could not load transaction amounts for this transaction.
	li_Return = -1

END IF



//If everythings ok so far, try to get the amount list.

IF NOT li_Return = -1 THEN

	lnv_CacheManager = This.GetCacheManager ( )
	
	
	IF lnv_CacheManager.of_GetCache ( "n_cst_dlkc_amountowed", lnv_Cache ) = 1 THEN

		//The goal here is to find all the amount beos assigned to the transaction 
		//(ie. amountowed_fktransaction = al_TransactionId).  However, using GetBeo, 
		//we have no way of doing a find with a start row.  So, in order to look for
		//all the amounts, we have to exclude the amount id's we've already found from
		//the find criteria.  This is, obviously, a bit cumbersome.
	
		ls_Base = "amountowed_fktransaction = " + String ( al_TransactionId )
	
		DO
	
			ls_Find = ls_Base
	
			IF li_Count > 0 THEN

				//Add a string excluding the ids we've already found from the find.

				IF lnv_String.of_ArrayToString ( lsa_Ids, " OR amountowed_id = ", ls_Work ) = -1 THEN
					li_Return = -1
					EXIT
				END IF
				ls_Find += " AND NOT ( amountowed_id = " + ls_Work + " )"

			END IF
	
			lnv_Beo = lnv_Cache.GetBeo ( ls_Find )
		
			IF IsValid ( lnv_Beo ) THEN
		
				li_Count ++
				lnva_List [ li_Count ] = lnv_Beo
				lsa_Ids [ li_Count ] = String ( lnva_List [ li_Count ].of_GetId ( ) )
		
			END IF
	
		LOOP WHILE IsValid ( lnv_Beo )
	
		IF NOT li_Return = -1 THEN
			li_Return = li_Count
			an_AmountsList = lnva_List
		END IF
	
	ELSE
	
		li_Return = -1
	
	END IF

END IF

RETURN li_Return
end function

public function integer of_gettransaction (long al_transactionid, ref n_cst_beo_transaction an_transaction);Integer	li_Return
n_cst_beo_Transaction	lnva_SingleTransaction[]

lnva_SingleTransaction[1] = an_Transaction

li_Return = This.of_GetTransaction({al_TransactionId}, lnva_SingleTransaction)

IF UpperBound(lnva_SingleTransaction) = 1 THEN
	an_Transaction = lnva_SingleTransaction[1]
END IF

Return li_Return
end function

public function Integer of_autoassign (n_cst_beo_transaction an_transaction);//@(*)[195289293|537]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns : Number of amounts auto-assigned if successful (>=0), -1 = Error

Integer	li_TransactionCategory, &
			li_AmountCategory, &
			li_Count
Long	ll_TransactionEntity, &
		ll_AmountEntity
Date	ld_TransactionStart, &
		ld_TransactionEnd, &
		ld_AmountStart, &
		ld_AmountEnd
n_cst_bcm	lnv_Amounts
n_cst_beo_AmountOwed	lnv_Amount

Integer	li_rc = 0

IF NOT IsValid ( an_Transaction ) THEN
	RETURN -1
END IF

//IF li_rc > 0 THEN
	IF an_Transaction.AllowEdit ( appeon_constant.cb_UserField, &
		appeon_constant.cb_Restricted ) = FALSE THEN

		//**THIS MESSAGEBOX SHOULD BE REPLACE WITH AN OFRERROR!!**
		MessageBox ( "Auto-Assign Amounts to Transaction", "You are not authorized to make this change.", Exclamation! )
		RETURN -1

//		li_rc = -1
//		lb_AuthorizationError = TRUE
	END IF
//END IF

//We may be able to remove this one now.
IF an_Transaction.of_GetOpen ( ) = FALSE THEN
	RETURN -1
END IF

li_TransactionCategory = an_Transaction.of_GetCategory ( )
ll_TransactionEntity = an_Transaction.of_GetfkEntity ( )

IF IsNull ( ll_TransactionEntity ) THEN
	RETURN -1
END IF

ld_TransactionStart = an_Transaction.of_GetStartDate ( )
ld_TransactionEnd = an_Transaction.of_GetEndDate ( )

IF IsNull ( ld_TransactionEnd ) THEN
	//Note : Right now we're only assigning based on end date, so that's all I'm requiring here
	RETURN -1
END IF

lnv_Amounts = This.of_GetAmountsOwed ( )

IF NOT IsValid ( lnv_Amounts ) THEN
	RETURN -1
END IF


////////////////////////////

//We'd like to have this:
//ll_BeoCount = lnv_Amounts.GetAll ( lnva_Beos )


//But due to regen problems, I've coded it locally for now.

n_cst_beo	lnva_Beos[], &
				lnv_Beo
Long			ll_BeoCount, &
				ll_Index

lnv_Beo = lnv_Amounts.GetFirst ( )

DO WHILE IsValid ( lnv_Beo )

	ll_BeoCount ++
	lnva_Beos [ ll_BeoCount ] = lnv_Beo

	lnv_Beo = lnv_Amounts.GetNext ( )

LOOP

/////////////////////////////


FOR ll_Index = 1 TO ll_BeoCount

	lnv_Amount = lnva_Beos [ ll_Index ]

	IF IsValid ( lnv_Amount ) THEN

		IF IsNull ( lnv_Amount.of_GetfkTransaction ( ) ) THEN
			//Amount is not already assigned.  Proceed.
		ELSE
			CONTINUE
		END IF

		//This was commented, but I'm not sure why.
		IF lnv_Amount.of_GetOpen ( ) = FALSE THEN
			CONTINUE
		END IF

		li_AmountCategory = lnv_Amount.of_GetCategory ( )

		IF li_AmountCategory = li_TransactionCategory THEN
			//Categories match.  Proceed.
		ELSE
			CONTINUE
		END IF


		ll_AmountEntity = lnv_Amount.of_GetfkEntity ( )
		
		IF ll_AmountEntity = ll_TransactionEntity THEN
			//Entities match.  Proceed.
		ELSE
			CONTINUE
		END IF


		ld_AmountStart = lnv_Amount.of_GetStartDate ( )
		ld_AmountEnd = lnv_Amount.of_GetEndDate ( )


		IF ld_AmountEnd <= ld_TransactionEnd THEN

			lnv_Amount.of_SetTransaction ( an_Transaction )

			//Check return value??
			li_Count ++

		END IF

	END IF

NEXT

RETURN li_Count
end function

public function Integer of_getratetype (integer ai_id, ref n_cst_beo_ratetype an_ratetype);//@(*)[354772389|654]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: 	1 = Success, 0 = RateType does not exist, -1 = Error

n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

//IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_ratetype", lnv_Cache ) = 1 THEN
//Revised this to Auto-Create and Auto-Retrieve in 2.6.00

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_ratetype", lnv_Cache, TRUE, TRUE ) = 1 THEN

	lnv_Beo = lnv_Cache.GetBeo ( "ratetype_id = " + String ( ai_Id ) )

	IF IsValid ( lnv_Beo ) THEN
		li_Return = 1
	ELSE
		li_Return = 0
	END IF

ELSE
	li_Return = -1

END IF

an_RateType = lnv_Beo
RETURN li_Return
end function

public function Integer of_getamounttype (integer ai_id, ref n_cst_beo_amounttype an_amounttype);//@(*)[354856845|657]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: 	1 = Success, 0 = AmountType does not exist, -1 = Error

n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

//IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache ) = 1 THEN
//Revised this to Auto-Create and Auto-Retrieve in 2.6.00

IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN

	lnv_Beo = lnv_Cache.GetBeo ( "amounttype_id = " + String ( ai_Id ) )

	IF IsValid ( lnv_Beo ) THEN
		li_Return = 1
	ELSE
		li_Return = 0
	END IF

ELSE
	li_Return = -1

END IF

an_AmountType = lnv_Beo
RETURN li_Return
end function

public function Integer of_makecompanyentity (long al_companyid, ref long al_entityid);//@(*)[257645369|675]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns : 1 = Success (Entity Added ), 0 = Entity already exists, no action taken, -1 = Error

Long	ll_EntityId
Integer	li_Return

li_Return = -1
SetNull ( al_EntityId )

CHOOSE CASE of_GetCompanyEntity ( al_CompanyId, ll_EntityId )

CASE 1
	al_EntityId = ll_EntityId
	li_Return = 0

CASE 0

	Long	ll_NextId
	Constant Boolean	cb_Commit = TRUE
		
	IF gnv_App.of_GetNextId ( "n_cst_beo_entity", ll_NextId, cb_Commit ) = 1 THEN
	
		INSERT INTO Entity ( Id, fkCompany ) VALUES ( :ll_NextId, :al_CompanyId ) ;

		IF SQLCA.SqlCode = 0 THEN
			COMMIT ;
			al_EntityId = ll_NextId
			li_Return = 1
		ELSE
			ROLLBACK ;
		END IF
		
	END IF
	
CASE ELSE //-1
	//Error.  Allow to fail.

END CHOOSE

RETURN li_Return
end function

public function integer of_getcompanyentity (long al_companyid, ref long al_entityid);//@(*)[257767791|679]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns : 1 = Success, 0 = Not Found, -1 = Error

Long	ll_EntityId
Integer	li_Return

SetNull ( al_EntityId )

IF NOT IsNull ( al_CompanyId ) THEN

	SELECT Id INTO :ll_EntityId FROM Entity WHERE fkCompany = :al_CompanyId ;
	
	CHOOSE CASE SQLCA.SqlCode
	
	CASE 0
		COMMIT ;
		al_EntityId = ll_EntityId
		li_Return = 1
	
	CASE 100
		COMMIT ;
		li_Return = 0
	
	CASE ELSE
		ROLLBACK ;
		li_Return = -1
	
	END CHOOSE
	
ELSE
	li_Return = 0
	
END IF

RETURN li_Return
end function

public function string of_describeentity (long al_entityid, integer ai_describetype);//@(*)[258440736|687]//@(-)Do not edit, move or copy this line//

//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//ai_DescribeType = 1 include entity type with description ( tab seperated )  .
//**THIS CODE MAY BE HALF BAKED**


String	ls_Description, &
			ls_Name,&
			ls_PayablesId, &
			ls_PayrollId
Long		ll_CompanyId, &
			ll_EmployeeId
n_cst_beo_Company			lnv_Company
n_cst_EmployeeManager	lnv_EmployeeManager

lnv_Company = CREATE n_cst_beo_Company

SELECT fkCompany, fkEmployee, payablesid, payrollid
  INTO :ll_CompanyId, :ll_EmployeeId, :ls_PayablesId, :ls_PayrollId 
FROM Entity WHERE Id = :al_EntityId ;

CHOOSE CASE SQLCA.SqlCode

CASE 0
	COMMIT ;

	IF NOT IsNull ( ll_CompanyId ) THEN

		gnv_cst_Companies.of_Cache ( ll_CompanyId, FALSE )

		lnv_Company.of_SetUseCache ( TRUE )
		lnv_Company.of_SetSourceId ( ll_CompanyId )

		IF lnv_Company.of_HasSource ( ) THEN
			ls_Description = lnv_Company.of_GetName ( )
		END IF

	ELSEIF NOT IsNull ( ll_EmployeeId ) THEN
		choose case ai_describetype
			case 0	//lastfirst
				IF lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeId, ls_Name, &
					appeon_constant.ci_DescribeType_LastFirst ) = 1 THEN
		
					ls_Description = ls_Name
		
				END IF
				
			case 1	//firstlast
				IF lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeId, ls_Name, &
					appeon_constant.ci_DescribeType_FirstLast ) = 1 THEN
		
					ls_Description = ls_Name
		
				END IF
		end choose
	END IF
	
	IF ai_describetype = 1 	THEN
		
		IF isnull ( ls_PayablesId ) or len ( ls_PayablesId ) = 0 THEN
			
			IF isnull ( ls_PayrollId ) or len ( ls_PayrollId ) = 0 THEN
				
				IF NOT IsNull ( ll_CompanyId ) THEN 
					
					ls_Description += "~t" + "Payables"
					
				ELSE
				
					ls_Description += "~t" + "Payables/Payroll Unspecified"
					
				END IF
				
			ELSE
				
				ls_Description += "~t" + "Payroll"
		
			END IF
			
		ELSE
			
			IF len ( ls_PayrollId ) > 0 THEN
				
				ls_Description += "~t" + "Payables/Payroll Unspecified"
				
			ELSE
				
				ls_Description += "~t" + "Payables"
				
			END IF
						
		END IF
		
		
	END IF
				

CASE 100
	COMMIT ;

CASE ELSE //-1
	ROLLBACK ;

END CHOOSE

DESTROY lnv_Company

RETURN ls_Description

end function

protected function Integer of_tagreferencedfields (ref n_ds an_target, ref n_cst_beo_amounttemplate an_amounttemplates[]);//@(*)[90404481|1336]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

/* This code is in working order, but not in use, so it's been commented.
//Tag any fields in the target datastore that are referenced in the amount templates

//Returns:  >= 0 : The number of fields tagged.

Integer	li_TemplateCount, &
			li_TemplateIndex, &
			li_ColumnCount, &
			li_ColumnIndex, &
			li_ReferenceCount
String	lsa_Columns[], &
			ls_Column, &
			ls_Tag
n_cst_beo_AmountTemplate	lnv_AmountTemplate
n_cst_String	lnv_String


an_Target.of_SetBase ( TRUE )
li_ColumnCount = an_Target.inv_Base.of_GetObjects ( &
	lsa_Columns, "column" /*ObjectType*/, "*" /*Band*/, FALSE /*VisibleOnly*/ )


li_TemplateCount = UpperBound ( an_AmountTemplates )


//Loop through the columns, and tag any that are referenced in the AmountTemplates

FOR li_ColumnIndex = 1 TO li_ColumnCount

	//Get a more convenient reference to the column for this pass through the loop.
	ls_Column = lsa_Columns [ li_ColumnIndex ]
	ls_Tag = an_Target.Describe ( ls_Column + ".Tag" )

	IF Lower ( lnv_String.of_GetKeyValue ( ls_Tag, cs_TagKey_Optional, ";" ) ) = "yes" THEN

		FOR li_TemplateIndex = 1 TO li_TemplateCount
	
			//Get a more convenient reference to the amount template for this pass through the loop.
			lnv_AmountTemplate = an_AmountTemplates [ li_TemplateIndex ]
	
			IF lnv_AmountTemplate.of_IsFieldReferenced ( ls_Column ) THEN
	
				li_ReferenceCount ++
				lnv_String.of_SetKeyValue ( ls_Tag, cs_TagKey_Optional, "No", ";" )
				an_Target.Modify ( ls_Column + ".Tag = '" + ls_Tag + "'" )
				EXIT  //Column is now required.  No need to check whether the other templates need it or not.
	
			END IF
	
		NEXT

	END IF

NEXT

RETURN li_ReferenceCount
*/
RETURN 0
end function

protected function Integer of_purgeoptionalfields (n_ds an_target);//@(*)[95882871|1339]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

/* This code is in working order, but not in use, so it's been commented.
//Purge any fields in the target datastore that are tagged as Optional

//Returns:  >= 0 : The number of fields destroyed.

Integer	li_ColumnCount, &
			li_ColumnIndex, &
			li_PurgeCount
String	lsa_Columns[], &
			ls_Column, &
			ls_Tag
n_cst_String	lnv_String


an_Target.of_SetBase ( TRUE )
li_ColumnCount = an_Target.inv_Base.of_GetObjects ( &
	lsa_Columns, "column" /*ObjectType*/, "*" /*Band*/, FALSE /*VisibleOnly*/ )


//Loop through the columns, and destroy any that are tagged as optional

FOR li_ColumnIndex = 1 TO li_ColumnCount

	//Get a more convenient reference to the column for this pass through the loop.
	ls_Column = lsa_Columns [ li_ColumnIndex ]
	ls_Tag = an_Target.Describe ( ls_Column + ".Tag" )

	IF Lower ( lnv_String.of_GetKeyValue ( ls_Tag, cs_TagKey_Optional, ";" ) ) = "yes" THEN

		li_PurgeCount ++
		an_Target.Modify ( "DESTROY COLUMN" + ls_Column )

	END IF

NEXT

RETURN li_PurgeCount
*/
RETURN 0
end function

public function n_cst_beo_transaction of_newtransaction ();//@(*)[11579608|1462]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


n_cst_beo_Transaction	lnv_Transaction
n_cst_CacheManager	lnv_CacheManager
n_cst_Bcm	lnv_Bcm
Integer	li_DefaultCategory
Long		ll_DefaultEntityId

lnv_CacheManager = This.GetCacheManager ( )

IF lnv_CacheManager.of_GetCache ( "n_cst_dlkc_transaction", lnv_Bcm ) = 1 THEN

	IF lnv_Bcm.NewBeo ( lnv_Transaction ) > 0 THEN

		//Initialization is done in ofr_PostNew on the beo

	END IF

END IF

RETURN lnv_Transaction
end function

public function Integer of_getroutetypesettlements (ref integer ai_routetype);//@(*)[60192819|1529]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:   1 = Success (value returned by reference in ai_RouteType)
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

Integer	li_RouteType
Integer	li_SqlCode

Integer	li_Return = 1


//Attempt to retrieve Settlements Route Type value from database

SELECT ss_Long INTO :li_RouteType FROM System_Settings WHERE ss_Id = 12 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.

	//0-4 Are the valid PCMiler Route Types

	IF li_RouteType >= 0 AND li_RouteType <= 4 THEN
		//Value is OK
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	ai_RouteType = li_RouteType
ELSE
	SetNull ( ai_RouteType )
END IF

RETURN li_Return
end function

public function n_cst_bcm of_retrievetransactions (long ala_transactionids[]);//@(*)[93440266|1586]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()
If IsValid(lnv_database) Then
   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument(ala_TransactionIds)
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","Ids")
End If

return lnv_bcm
end function

public function Integer of_loadtransactions (long ala_transactionids[]);//@(*)[93472210|1588]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:	 1 = Success (Retrieved, or already loaded, including no result for invalid ids)
//				-1 (Error)

n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE
Long			lla_IdsToLoad[]
Integer		li_Count, &
				li_Index, &
				li_CountToLoad

Integer	li_Return = 1


//Scan through the array, and make a list of ids that are valid and not already loaded.

IF lb_AttemptRetrieval THEN

	li_Count = UpperBound ( ala_TransactionIds )

	FOR li_Index = 1 TO li_Count

		//Verify that the requested TransactionId is valid.

		IF IsNull ( ala_TransactionIds [ li_Index ] ) THEN
			CONTINUE
		END IF

		//Verify whether the requested information has already been retrieved.
	
		IF This.of_IsLoaded ( cs_Loaded_Transactions, ala_TransactionIds [ li_Index ] ) THEN
			//This transaction has already been loaded.
			CONTINUE
		END IF

		li_CountToLoad ++
		lla_IdsToLoad [ li_CountToLoad ] = ala_TransactionIds [ li_Index ]

	NEXT


	IF li_CountToLoad = 0 THEN
		//If there's nothing to load, don't bother
		lb_AttemptRetrieval = FALSE
	END IF

END IF


//If there's something to load, attempt to load it.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveTransactions ( lla_IdsToLoad )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.  Record that this information has been loaded.

			FOR li_Index = 1 TO li_CountToLoad
				This.of_SetLoaded ( cs_Loaded_Transactions, lla_IdsToLoad [ li_Index ] )
			NEXT

		ELSE
			//Caching error.
			li_Return = -1
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function n_cst_bcm of_retrievetransactionamounts (long ala_transactionids[]);//@(*)[93097384|1582]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()
If IsValid(lnv_database) Then
   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument(ala_TransactionIds)
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_amountowed","","TransactionAmounts")
End If

return lnv_bcm
end function

public function Integer of_loadtransactionamounts (long ala_transactionids[]);//@(*)[93245622|1584]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:	 1 = Success (Retrieved, or already loaded, including no result for invalid ids)
//				-1 (Error)

n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE
Long			lla_IdsToLoad[]
Integer		li_Count, &
				li_Index, &
				li_CountToLoad

Integer	li_Return = 1


//Scan through the array, and make a list of ids that are valid and not already loaded.

IF lb_AttemptRetrieval THEN

	li_Count = UpperBound ( ala_TransactionIds )

	FOR li_Index = 1 TO li_Count

		//Verify that the requested TransactionId is valid.

		IF IsNull ( ala_TransactionIds [ li_Index ] ) THEN
			CONTINUE
		END IF

		//Verify whether the requested information has already been retrieved.
	
		IF This.of_IsLoaded ( cs_Loaded_TransactionAmounts, ala_TransactionIds [ li_Index ] ) THEN
			//Transaction Amounts have already been retrieved for this transaction.
			CONTINUE
		END IF

		li_CountToLoad ++
		lla_IdsToLoad [ li_CountToLoad ] = ala_TransactionIds [ li_Index ]

	NEXT


	IF li_CountToLoad = 0 THEN
		//If there's nothing to load, don't bother
		lb_AttemptRetrieval = FALSE
	END IF

END IF


//If there's something to load, attempt to load it.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveTransactionAmounts ( lla_IdsToLoad )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.  Record that this information has been loaded.

			FOR li_Index = 1 TO li_CountToLoad
				This.of_SetLoaded ( cs_Loaded_TransactionAmounts, lla_IdsToLoad [ li_Index ] )
			NEXT

		ELSE
			//Caching error.
			li_Return = -1
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function Integer of_loadopentransactions (long al_entityid);//@(*)[92285787|1575]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:	 1 = Success (Retrieved, or already loaded, including no result for invalid id)
//				-1 (Error)

//Note: Passing null for al_EntityId will load all open transactions, regardless of entity.

n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE
Boolean		lb_OneEntity = TRUE
Long			ll_Null

Integer	li_Return = 1

SetNull ( ll_Null )

//Verify whether we're retrieving for one entity, or all of them.

IF IsNull ( al_EntityId ) THEN
	lb_OneEntity = FALSE
END IF


//Verify whether the requested information has already been retrieved.

IF lb_AttemptRetrieval THEN

	IF This.of_IsLoaded ( cs_Loaded_OpenTransactions, al_EntityId ) THEN

		//Open transactions have already been loaded for this entity.
		lb_AttemptRetrieval = FALSE

	ELSEIF This.of_IsLoaded ( cs_Loaded_AllTransactions, al_EntityId ) THEN

		//All transactions have already been loaded for this entity.
		lb_AttemptRetrieval = FALSE

	ELSEIF lb_OneEntity THEN

		//If we're retrieving for one entity, check whether all entities may have been retrieved.

		IF This.of_IsLoaded ( cs_Loaded_OpenTransactions, ll_Null ) THEN
			//Open transactions have already been loaded for all entities.
			lb_AttemptRetrieval = FALSE
		ELSEIF This.of_IsLoaded ( cs_Loaded_AllTransactions, ll_Null ) THEN
			//All transactions have already been loaded for all entities.
			lb_AttemptRetrieval = FALSE
		END IF

	END IF

END IF


//If the information requested is not already loaded, attempt to load it.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveOpenTransactions ( al_EntityId )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.  Record that this information has been loaded.
			This.of_SetLoaded ( cs_Loaded_OpenTransactions, al_EntityId )
		ELSE
			//Caching error.
			li_Return = -1
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function n_cst_bcm of_retrieveunassignedamounts (long al_entityid);//@(*)[92395211|1577]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

long ll_entityid
ll_entityid = al_entityid

lnv_database = gnv_bcmmgr.GetDatabase()
If IsValid(lnv_database) Then
   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument(ll_entityid)
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_amountowed","","EntityUnassignedAmounts")
End If

return lnv_bcm
end function

public function Integer of_loadunassignedamounts (long al_entityid);//@(*)[92523614|1580]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:	 1 = Success (Retrieved, or already loaded, including no result for invalid id)
//				-1 (Error)

n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE

Integer	li_Return = 1

//Verify that the requested entityid is valid.

IF lb_AttemptRetrieval THEN

	IF IsNull ( al_EntityId ) THEN
		lb_AttemptRetrieval = FALSE
	END IF

END IF


//Verify whether the requested information has already been retrieved.

IF lb_AttemptRetrieval THEN

	IF This.of_IsLoaded ( cs_Loaded_UnassignedAmounts, al_EntityId ) THEN
		//Unassigned amounts have already been loaded for this entity.
		lb_AttemptRetrieval = FALSE
	END IF

END IF


//If the information requested is not already loaded, attempt to load it.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveUnassignedAmounts ( al_EntityId )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.  Record that this information has been loaded.
			This.of_SetLoaded ( cs_Loaded_UnassignedAmounts, al_EntityId )
		ELSE
			//Caching error.
			li_Return = -1
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function Boolean of_isloaded (string as_valuetype, long al_id);//@(*)[66668578|1595]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


String	ls_Value
Boolean	lb_IsLoaded

ls_Value = This.of_MakeLoadedValue ( as_ValueType, al_Id )

IF inv_Loaded.of_HasValue ( ls_Value ) THEN
	lb_IsLoaded = TRUE
END IF

RETURN lb_IsLoaded
end function

public function Integer of_setloaded (string as_valuetype, long al_id);//@(*)[66791827|1598]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:  1, -1

String	ls_Value
Boolean	lb_IsLoaded

Integer	li_Return = -1

ls_Value = This.of_MakeLoadedValue ( as_ValueType, al_Id )

IF inv_Loaded.of_AddValue ( ls_Value, FALSE /*Don't Allow Duplicates*/ ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return
end function

private function String of_makeloadedvalue (string as_valuetype, long al_id);//@(*)[67454562|1602]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Assemble the Value string that is used to record what data has been loaded.

String	ls_LoadedValue

//I'm guessing the find might be most efficient with the Id (most unique value) coming 
//at the start of the string.

IF IsNull ( al_Id ) THEN
	ls_LoadedValue = "Null" + as_ValueType
ELSE
	ls_LoadedValue = String ( al_Id ) + as_ValueType
END IF

RETURN ls_LoadedValue
end function

public function n_cst_bcm of_retrieveshipmentamounts (long ala_shipmentids[]);//@(*)[57640725|1618]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_bcm lnv_bcm
//n_cst_database lnv_database
//n_cst_query lnv_query
//
//lnv_database = gnv_bcmmgr.GetDatabase()
//If IsValid(lnv_database) Then
//   lnv_query = lnv_database.GetQuery()
//	lnv_Query.SetArgument(6)  //Replace this with Type
//   lnv_query.SetArgument(ala_ShipmentIds)
//	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_amountowed","","IdInRef1")
//End If

return lnv_bcm
end function

public function Integer of_loadshipmentamounts (long ala_shipmentids[]);//@(*)[57754108|1622]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=opt)<return value>
Integer li_integer
return li_integer
//@(text)--

end function

public function n_cst_bcm of_retrievetripamounts (long ala_tripids[]);//@(*)[57643598|1620]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=opt)<return value>
n_cst_bcm ln_cst_bcm
return ln_cst_bcm
//@(text)--

end function

public function Integer of_loadtripamounts (long ala_tripids[]);//@(*)[57756484|1624]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=opt)<return value>
Integer li_integer
return li_integer
//@(text)--

end function

public function n_cst_bcm of_retrieveunbatchedtransactions (long al_entityid);//@(*)[70849063|1631]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Passing null for al_EntityId will retrieve all unbatched transactions, regardless of entity.

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()

If IsValid(lnv_database) Then

   lnv_query = lnv_database.GetQuery()

	IF IsNull ( al_EntityId ) THEN
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","UnbatchedTransactions")
	ELSE
		lnv_query.SetArgument(al_entityid)
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","EntityUnbatchedTransactions")
	END IF

End If

return lnv_bcm
end function

public function Integer of_loadunbatchedtransactions (long al_entityid);//@(*)[70822707|1629]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Load Transactions that are flagged to be batched.  TransactionAmounts for the transactions
//loaded will also be retrieved.  If of_LoadReferencedTransactions should fail, this function
//will still indicate success.

//Returns:	 1 = Success (Retrieved, or already loaded, including no result for invalid id)
//				-1 (Error)

//Note: Passing null for al_EntityId will load all unbatched transactions, regardless of entity.

n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE
Boolean		lb_OneEntity = TRUE
Long			ll_Null

Integer	li_Return = 1

SetNull ( ll_Null )

//Verify whether we're retrieving for one entity, or all of them.

IF IsNull ( al_EntityId ) THEN
	lb_OneEntity = FALSE
END IF


//Verify whether the requested information has already been retrieved.

IF lb_AttemptRetrieval THEN

	IF This.of_IsLoaded ( cs_Loaded_UnbatchedTransactions, al_EntityId ) THEN

		//Unbatched transactions have already been loaded for this entity.
		lb_AttemptRetrieval = FALSE

	ELSEIF This.of_IsLoaded ( cs_Loaded_AllTransactions, al_EntityId ) THEN

		//All transactions have already been loaded for this entity.
		lb_AttemptRetrieval = FALSE

	ELSEIF lb_OneEntity THEN

		//If we're retrieving for one entity, check whether all entities may have been retrieved.

		IF This.of_IsLoaded ( cs_Loaded_UnbatchedTransactions, ll_Null ) THEN
			//Unbatched transactions have already been loaded for all entities.
			lb_AttemptRetrieval = FALSE
		ELSEIF This.of_IsLoaded ( cs_Loaded_AllTransactions, ll_Null ) THEN
			//All transactions have already been loaded for all entities.
			lb_AttemptRetrieval = FALSE
		END IF

	END IF

END IF


//If the information requested is not already loaded, attempt to load it.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveUnbatchedTransactions ( al_EntityId )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.  Record that this information has been loaded.
			This.of_SetLoaded ( cs_Loaded_UnbatchedTransactions, al_EntityId )
		ELSE
			//Caching error.
			li_Return = -1
		END IF


		//If all is well, attempt to load referenced amounts.

		IF li_Return = 1 THEN
			This.of_LoadReferencedAmounts ( )
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function n_cst_bcm of_retrievetransactions (long al_entityid, date ad_min, date ad_max);//@(*)[52158091|1635]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Note: Passing null for al_EntityId will retrieve all transactions for the date range, regardless of entity.

//Transactions with any portion of their date range (StartDate - EndDate) falling withing the date range
//specified (ad_Min - ad_Max) will be retrieved.  

//Null ad_Min means transactions up to and including ad_Max.  
//Null ad_Max means transactions on or after ad_Min.  
//Null for both means any dates (all transactions for entity.)
//Null for all 3 means all transactions in the system.


n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()

If IsValid(lnv_database) Then

   lnv_query = lnv_database.GetQuery()

	IF IsNull ( al_EntityId ) AND IsNull ( ad_Min ) AND IsNull ( ad_Max ) THEN

		//Retrieve all transactions using class dlk
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","")

	ELSE

		lnv_Query.SetArgument(ad_Min)
		lnv_Query.SetArgument(ad_Max)
	
		IF IsNull ( al_EntityId ) THEN
			lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","DateRange")
		ELSE
			lnv_query.SetArgument(al_entityid)
			lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","EntityDateRange")
		END IF

	END IF

End If

return lnv_bcm
end function

public function Integer of_loadtransactions (long al_entityid, date ad_min, date ad_max);//@(*)[52133893|1633]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:	 1 = Success (Retrieved, or already loaded, including no result for invalid id)
//				-1 (Error)

//Note: Passing null for al_EntityId will load all transactions for the date range, regardless of entity.

//Transactions with any portion of their date range (StartDate - EndDate) falling withing the date range
//specified (ad_Min - ad_Max) will be retrieved.  

//Null ad_Min means transactions up to and including ad_Max.  
//Null ad_Max means transactions on or after ad_Min.  
//Null for both means any dates (all transactions for entity.)
//Null for all 3 means all transactions in the system.


n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE
Boolean		lb_OneEntity = TRUE
Long			ll_Null

Integer	li_Return = 1

SetNull ( ll_Null )

//Verify whether we're retrieving for one entity, or all of them.

IF IsNull ( al_EntityId ) THEN
	lb_OneEntity = FALSE
END IF


//Verify whether the requested information has already been retrieved by checking AllTransactions.
//(If all transactions have been retrieved for an entity, that covers any daterange.)

IF lb_AttemptRetrieval THEN

	IF This.of_IsLoaded ( cs_Loaded_AllTransactions, al_EntityId ) THEN

		//All transactions have already been loaded for this entity.
		lb_AttemptRetrieval = FALSE

	ELSEIF lb_OneEntity THEN

		//If we're retrieving for one entity, check whether all entities may have been retrieved.

		IF This.of_IsLoaded ( cs_Loaded_AllTransactions, ll_Null ) THEN
			//All transactions have already been loaded for all entities.
			lb_AttemptRetrieval = FALSE
		END IF

	END IF

END IF


//If the information requested is not already loaded, attempt to load it.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveTransactions ( al_EntityId, ad_Min, ad_Max )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.  If the retrieval did not specify a date range, 
			//record that AllTransactioins have been loaded.
			This.of_SetLoaded ( cs_Loaded_AllTransactions, al_EntityId )
		ELSE
			//Caching error.
			li_Return = -1
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function n_cst_bcm of_retrieveentities (long ala_entityids[]);//@(*)[52887231|1659]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()
If IsValid(lnv_database) Then
   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument(ala_EntityIds)
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_entity","","Ids")
End If

return lnv_bcm

end function

public function Integer of_loadentities (long ala_entityids[]);//@(*)[52892193|1661]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Returns:	 1 = Success (Retrieved, or already loaded, including no result for invalid ids)
//				-1 (Error)

n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE
Long			lla_IdsToLoad[]
Integer		li_Count, &
				li_Index, &
				li_CountToLoad

Integer	li_Return = 1


//Scan through the array, and make a list of ids that are valid and not already loaded.

IF lb_AttemptRetrieval THEN

	li_Count = UpperBound ( ala_EntityIds )

	FOR li_Index = 1 TO li_Count

		//Verify that the requested EntityId is valid.

		IF IsNull ( ala_EntityIds [ li_Index ] ) THEN
			CONTINUE
		END IF

		//Verify whether the requested information has already been retrieved.
	
		IF This.of_IsLoaded ( cs_Loaded_Entities, ala_EntityIds [ li_Index ] ) THEN
			//This entity has already been loaded.
			CONTINUE
		END IF

		li_CountToLoad ++
		lla_IdsToLoad [ li_CountToLoad ] = ala_EntityIds [ li_Index ]

	NEXT


	IF li_CountToLoad = 0 THEN
		//If there's nothing to load, don't bother
		lb_AttemptRetrieval = FALSE
	END IF

END IF


//If there's something to load, attempt to load it.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveEntities ( lla_IdsToLoad )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.  Record that this information has been loaded.

			FOR li_Index = 1 TO li_CountToLoad
				This.of_SetLoaded ( cs_Loaded_Entities, lla_IdsToLoad [ li_Index ] )
			NEXT

		ELSE
			//Caching error.
			li_Return = -1
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function Integer of_getentity (long al_id, ref n_cst_beo_entity an_entity);//@(*)[53423225|1663]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Returns: 	1 = Success, 0 = Entity does not exist, -1 = Error

n_cst_beo	lnv_Beo
n_cst_bcm	lnv_Cache

Integer	li_Return = 1


IF li_Return = 1 THEN

	IF This.of_LoadEntities ( { al_Id } ) = 1 THEN
		//Entity is loaded.	
	ELSE
		li_Return = -1
	END IF

END IF


IF li_Return = 1 THEN

	IF This.inv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Cache ) = 1 THEN
	
		lnv_Beo = lnv_Cache.GetBeo ( "entity_id = " + String ( al_Id ) )
	
		IF IsValid ( lnv_Beo ) THEN
			li_Return = 1
		ELSE
			li_Return = 0
		END IF
	
	ELSE
		li_Return = -1
	
	END IF

END IF


an_Entity = lnv_Beo

RETURN li_Return

end function

public function Integer of_loadreferencedentities ();//@(*)[83335190|1667]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Load any entities that are referenced by Transactions and/or amounts already loaded.

//Returns:	 1 = Success (Including if there were no entities referenced)
//				-1 (Error)

n_cst_bcm	lnv_TransactionBCM, &
				lnv_AmountBCM
DataStore	lds_Transactions, &
				lds_Amounts
n_cst_CacheManager	lnv_CacheManager
Long			lla_TransactionEntities[], &
				lla_AmountEntities[], &
				lla_CombinedEntities[], &
				ll_Base, &
				ll_Add, &
				ll_Index
n_cst_AnyArraySrv	lnv_ArraySrv

Integer	li_Return = 1

lnv_CacheManager = This.GetCacheManager ( )

IF IsValid ( lnv_CacheManager ) THEN

	lnv_CacheManager.of_GetCache ( "n_cst_dlkc_transaction", lnv_TransactionBcm )
	lnv_CacheManager.of_GetCache ( "n_cst_dlkc_amountowed", lnv_AmountBcm )

	IF IsValid ( lnv_TransactionBCM ) THEN

		lds_Transactions = lnv_TransactionBCM.GetView ( )

		IF IsValid ( lds_Transactions ) THEN

			IF lds_Transactions.RowCount ( ) > 0 THEN
				lla_TransactionEntities = lds_Transactions.Object.Transaction_fkEntity.Primary
				lnv_ArraySrv.of_GetShrinked ( lla_TransactionEntities, "DUPES" )
			END IF

		END IF

	END IF


	IF IsValid ( lnv_AmountBCM ) THEN

		lds_Amounts = lnv_AmountBCM.GetView ( )

		IF IsValid ( lds_Amounts ) THEN

			IF lds_Amounts.RowCount ( ) > 0 THEN
				lla_AmountEntities = lds_Amounts.Object.AmountOwed_fkEntity.Primary
				lnv_ArraySrv.of_GetShrinked ( lla_AmountEntities, "DUPES" )
			END IF

		END IF

	END IF

	//Concatenate the two arrays into one

	lla_CombinedEntities = lla_TransactionEntities
	ll_Base = UpperBound ( lla_CombinedEntities )
	ll_Add = UpperBound ( lla_AmountEntities )

	FOR ll_Index = 1 TO ll_Add

		lla_CombinedEntities [ ll_Base + ll_Index ] = lla_AmountEntities [ ll_Index ]

	NEXT

	IF This.of_LoadEntities ( lla_CombinedEntities ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

ELSE
	//Can't perform processing without CacheManager
	li_Return = -1

END IF


RETURN li_Return
end function

public function n_cst_bcm of_retrievebatch (string as_batchnumber);//@(*)[56697182|1670]<157555757|1230>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query

lnv_database = gnv_bcmmgr.GetDatabase()
If IsValid(lnv_database) Then
   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument(as_BatchNumber)
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_transaction","","BatchNumber")
End If

return lnv_bcm
end function

public function integer of_loadbatch (string as_batchnumber);//@(*)[56752503|1672]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--


//Load Transactions assigned to the batch.  TransactionAmounts for the transactions
//loaded will also be loaded.  If of_LoadReferencedTransactions should fail, this function
//will still indicate success.

//This function does not check for previous loading.  The way we've implemented the screen, 
//it's not necessary, and you'd probably want to be sure you had the latest info anyway.

//Returns:	 1 = Success (Retrieved, or already loaded, including no entries for BatchNumber)
//				-1 (Error)

n_cst_bcm	lnv_ResultSet
Boolean		lb_AttemptRetrieval = TRUE

Integer	li_Return = 1

//Verify that the BatchNumber passed in is not null.

IF IsNull ( as_BatchNumber ) THEN
	lb_AttemptRetrieval = FALSE
END IF


//Attempt to load the requested information.

IF lb_AttemptRetrieval THEN

	//Attempt to retrieve the requested information.
	lnv_ResultSet = This.of_RetrieveBatch ( as_BatchNumber )
	
	
	//If the retrieval was successful, attempt to cache the result set.
	
	IF IsValid ( lnv_ResultSet ) THEN
	
		//Retrieved sucessfully.  Attempt to cache the rows.
	
		IF IsValid ( This.Cache ( lnv_ResultSet, TRUE /*DestroySource*/ ) ) THEN
			//Cached successfully.
		ELSE
			//Caching error.
			li_Return = -1
		END IF


		//If all is well, attempt to load referenced amounts.

		IF li_Return = 1 THEN
			This.of_LoadReferencedAmounts ( )
		END IF
	
	ELSE
		//Retrieval error
		li_Return = -1
	
	END IF

END IF


RETURN li_Return
end function

public function Integer of_loadreferencedamounts ();//@(*)[225860367|1674]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

//Load any Amounts that are referenced by Transactions already loaded.

//Returns:	 1 = Success (Including if there were no amounts referenced)
//				-1 (Error)

n_cst_bcm	lnv_TransactionBCM
DataStore	lds_Transactions
n_cst_CacheManager	lnv_CacheManager
Long			lla_Transactions[]

Integer	li_Return = 1

lnv_CacheManager = This.GetCacheManager ( )

IF IsValid ( lnv_CacheManager ) THEN

	lnv_CacheManager.of_GetCache ( "n_cst_dlkc_transaction", lnv_TransactionBcm )

	IF IsValid ( lnv_TransactionBCM ) THEN

		lds_Transactions = lnv_TransactionBCM.GetView ( )

		IF IsValid ( lds_Transactions ) THEN

			IF lds_Transactions.RowCount ( ) > 0 THEN
				lla_Transactions = lds_Transactions.Object.Transaction_Id.Primary
			END IF

		END IF

	END IF


	IF This.of_LoadTransactionAmounts ( lla_Transactions ) = 1 THEN
		//OK
	ELSE
		li_Return = -1
	END IF

ELSE
	//Can't perform processing without CacheManager
	li_Return = -1

END IF


RETURN li_Return
end function

public function boolean of_getcreatepayablesbatches ();//@(*)[231107135|1675]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

Boolean lb_Return = FALSE // default


String	ls_Value
Integer	li_SqlCode

// attempt to determine if payables batches are to be created
SELECT ss_String INTO :ls_Value FROM System_Settings WHERE ss_Id = 58 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
		// use default

CASE 0		//Success.  Validate value.
	IF Len ( ls_Value ) > 0 THEN
		//Value is OK 
		CHOOSE CASE upper ( ls_Value ) 
			CASE "YES!"
				lb_Return = TRUE
			CASE ELSE
				// use default
		END CHOOSE
	ELSE
		// use default
	END IF

CASE ELSE	//Error
	SetNull ( lb_Return )
END CHOOSE



return lb_Return 
//@(text)--

end function

public function boolean of_getcreatepayrollbatches ();//@(*)[231150697|1676]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

Boolean lb_Return = FALSE // default 


String	ls_Value
Integer	li_SqlCode

// attempt to determine if Payroll batches are to be created
SELECT ss_String INTO :ls_Value FROM System_Settings WHERE ss_Id = 59 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	// use default

CASE 0		//Success.  Validate value.
	IF Len ( ls_Value ) > 0 THEN
		//Value is OK 
		CHOOSE CASE upper ( ls_Value ) 
			CASE "YES!"
				lb_Return = TRUE
			CASE ELSE
				// use default
		END CHOOSE
		
	ELSE
		// use default
	END IF

CASE ELSE	//Error
	SetNull ( lb_Return )

END CHOOSE

return lb_Return 

//@(text)--

end function

public function integer of_batchdialog (string as_title, string as_message, string as_buttonset, ref string as_defaultselection);// Returns : 1 = success , 0 = User Canceled, -1 = Error

Int	li_Return = 1

n_cst_msg	lnv_Msg
S_parm		lstr_Parm


lstr_Parm.is_label = "TITLE"
lstr_Parm.ia_Value = as_title
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "MESSAGE"
lstr_Parm.ia_Value = as_message
lnv_Msg.of_Add_Parm ( lstr_Parm )


lstr_Parm.is_label = "BUTTONSET"
lstr_Parm.ia_Value = as_buttonset //i.e "YESNO!"
lnv_Msg.of_Add_Parm ( lstr_Parm )

lstr_Parm.is_label = "DEFAULT"
lstr_Parm.ia_Value = as_defaultselection
lnv_Msg.of_Add_Parm ( lstr_Parm )

openWithParm  ( W_BatchSelection , lnv_Msg )

lnv_msg = message.powerobjectParm

SetNull (  as_defaultselection )

IF IsValid ( lnv_Msg ) THEN
	IF lnv_Msg.of_Get_Parm ( "BATCH" , lstr_Parm ) <> 0 THEN
		IF isNull ( lstr_Parm.ia_Value ) THEN
			li_Return = 0 // user canceled
		ELSE
			as_defaultselection = lstr_Parm.ia_Value 
		END IF
	ELSE
		li_Return = -1
	END IF
ELSE
	li_Return = -1
END IF


RETURN li_Return

end function

public function boolean of_getnewrequiresentity ();RETURN ib_NewRequiresEntity
end function

public function integer of_setnewrequiresentity (readonly boolean ab_value);Integer	li_Return = 1

IF IsNull ( ab_Value ) THEN
	li_Return = -1
ELSE
	ib_NewRequiresEntity = ab_Value
END IF

RETURN li_Return
end function

public function long of_getamounttemplate (ref n_cst_beo_amounttemplate anva_amounttemplate[]);Integer	li_ItineraryType, &
			li_BreakDownType
			
Long		ll_EntityId, &
			ll_ItineraryId, &
			ll_TemplateCount, &
			ll_Return = 0
			
n_cst_bcm lnv_TemplateBCM
n_cst_beo_Entity		lnv_Entity
n_cst_beo_AmountTemplate lnv_AmountTemplate
n_cst_bcm lnv_EntityBcm
n_cst_database lnv_database
n_cst_query lnv_query
	
lnv_database = gnv_bcmmgr.GetDatabase()
// Commented out to allow periodics to update correctly. J.ALbert 12/16/02
//Get a reference to the interactive amounttemplate cache, and destroy it in order to force refresh
//IF GetCacheManager ( ).of_GetCache ( "n_cst_dlkc_amounttemplate", lnv_TemplateBCM ) = 1 THEN
//	gnv_BcmMgr.DestroyBcm ( lnv_TemplateBCM )
//END IF
////
If IsValid(lnv_database) Then

	lnv_query = lnv_database.GetQuery()
	lnv_query.SetArgument(This.of_GetDefaultEntityId ( ))
	lnv_EntityBcm = lnv_query.ExecuteQuery("n_cst_dlkc_entity","","")

	IF IsValid ( lnv_EntityBcm ) THEN
		lnv_Entity = lnv_EntityBcm.GetFirst ( )
	ELSE
		ll_Return = -1
	END IF

ELSE
	ll_Return = -1

End If

IF ll_Return = 0 THEN

	lnv_TemplateBcm = lnv_Entity.of_GetAmountTemplate ( )

	IF IsValid ( lnv_TemplateBcm ) THEN

		lnv_AmountTemplate = lnv_TemplateBcm.GetFirst ( )

		DO WHILE IsValid ( lnv_AmountTemplate )

			ll_TemplateCount ++
			anva_AmountTemplate [ ll_TemplateCount ] = lnv_AmountTemplate

			lnv_AmountTemplate = lnv_TemplateBcm.GetNext ( )

		LOOP

	//Retrieved sucessfully.  Attempt to cache the rows.  
	//jma, moved this if stmt into method to allow amounttemplate rows to update in db
		IF IsValid ( This.Cache ( lnv_TemplateBCM, false /*DestroySource*/ ) ) THEN
			//ok
		else
			ll_return = -1
		end if
	ELSE
		ll_Return = -1
	END IF

END IF

return ll_Return
end function

private function integer of_setitineraryid ();//	Use the default entity id
long	ll_EntityId

Integer	li_Return = 1

ll_EntityId = this.of_GetDefaultEntityId () 

IF isnull(ll_EntityId) or ll_EntityId = 0 THEN
	li_Return = -1 
ELSE
	SELECT fkEmployee INTO :il_ItineraryId FROM Entity WHERE Id = :ll_EntityId ;
	
	COMMIT ;
	
	CHOOSE CASE SQLCA.SqlCode
	
	CASE 0
	
		IF IsNull ( il_ItineraryId ) THEN
			li_Return = -1
		END IF
	
	CASE ELSE
		li_Return = -1
	
	END CHOOSE
END IF

Return li_Return
end function

private function long of_getitineraryid ();return il_ItineraryId
end function

private subroutine of_setitinerarytype ();ii_ItineraryType = gc_Dispatch.ci_ItinType_Driver
end subroutine

private subroutine of_setbreakdowntype ();ii_BreakdownType = 0  //********Determine Type HERE************

end subroutine

public function integer of_getitinerarytype ();return ii_itinerarytype
end function

public function integer of_getitinerarybreakdowntype ();return ii_breakdowntype
end function

public subroutine of_setpaysplitcache (datastore ads_PaySplitCache);ids_paysplitcache = ads_PaySplitCache
end subroutine

public function datastore of_getpaysplitcache (boolean ab_create);long		lla_amountid[], &
			ll_amountid

DataStore			Lds_Amounts
n_cst_AnyArraySrv	lnv_ArraySrv

n_cst_beo_amountowed		lnva_Amount[]
n_cst_bcm					lnv_AmountBCM
n_cst_CacheManager		lnv_CacheManager

IF isvalid(ids_PaySplitCache) THEN
	//ALREADY CREATED
ELSE
	IF ab_Create THEN
		lnv_CacheManager = This.GetCacheManager ( )
		
		IF IsValid ( lnv_CacheManager ) THEN
		
			lnv_CacheManager.of_GetCache ( "n_cst_dlkc_amountowed", lnv_AmountBcm )
		
		END IF
		
		IF IsValid ( lnv_AmountBCM ) THEN
		
			lds_Amounts = lnv_AmountBCM.GetView ( )
		
			IF IsValid ( lds_Amounts ) THEN
		
				IF lds_Amounts.RowCount ( ) > 0 THEN
					lla_amountid = lds_Amounts.Object.AmountOwed_Id.Primary
					lnv_ArraySrv.of_GetShrinked ( lla_amountid, "DUPES" )
				END IF
		
			END IF
		
		END IF
		
		this.of_LoadPaySplitCache(lla_amountid)

	END IF
END IF

Return ids_PaySplitCache
end function

public function long of_getamounttemplate (long ala_id[], ref n_cst_beo_amounttemplate anva_amounttemplate[]);Integer	li_ItineraryType, &
			li_BreakDownType
			
Long		ll_EntityId, &
			ll_ItineraryId, &
			ll_TemplateCount, &
			ll_IdCount, &
			ll_Ndx, &
			ll_Return = 0
			
n_cst_bcm lnv_TemplateBCM, lnv_cache
n_cst_beo_Entity		lnv_Entity
n_cst_beo_AmountTemplate lnv_AmountTemplate
n_cst_bcm lnv_EntityBcm
n_cst_database lnv_database
n_cst_query lnv_query
n_cst_cachemanager lnv_CacheManager

lnv_database = gnv_bcmmgr.GetDatabase()
If IsValid(lnv_database) Then
   lnv_query = lnv_database.GetQuery()
   lnv_query.SetArgument(ala_id)
	lnv_TemplateBCM = lnv_query.ExecuteQuery("n_cst_dlkc_amounttemplate","","ids")
End If

IF IsValid ( lnv_TemplateBCM ) THEN
	//Retrieved sucessfully.  Attempt to cache the rows.
	IF IsValid ( This.Cache ( lnv_TemplateBCM, true /*DestroySource*/ ) ) THEN
		//ok
	else
		ll_return = -1
	end if
else
	ll_return = -1
end if

IF ll_Return = 0 THEN

	lnv_CacheManager = This.GetCacheManager ( )
	
	IF lnv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttemplate", lnv_Cache ) = 1 THEN

		ll_IdCount = upperbound ( ala_id )
		
		FOR ll_Ndx = 1 to ll_IdCount
			
			lnv_AmountTemplate = lnv_Cache.GetBeo ( "amounttemplate_id = " + string ( ala_id[ll_Ndx] ) )
		
//			lnv_AmountTemplate = lnv_TemplateBCM.GetBeo("amounttemplate_id = " + string ( ala_id[ll_Ndx] ) )
			
			IF isvalid ( lnv_AmountTemplate ) THEN
				ll_TemplateCount ++
				anva_AmountTemplate [ ll_TemplateCount ] = lnv_AmountTemplate
			END IF

		NEXT
	end if
END IF

return ll_Return
end function

public subroutine of_setinitialitineraryrange (n_cst_msg anv_RangeMsg);inv_RangeMsg = anv_RangeMsg
end subroutine

public function n_cst_msg of_getinitialitineraryrange ();return inv_rangemsg
end function

private subroutine of_templateloop (n_cst_beo_transaction an_transaction);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_TemplateLoop
//
//	Access:  public
//
//	Arguments:  
//					an_transaction
//
//
//	Description:	
//			Extract all of the expressions (quantity, rate, amount, splitsby) from the 
//			amount templates.  Get all of the datapoints from the expresssions
//			and generate the amounts and splits.
//
// Written by: Norm LeBlanc
// 		Date: 05/07/01
//		Version: 3.0.17
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
Integer	li_Return

long	ll_TemplateCount, &
		ll_TemplateIndex, &
		ll_ArrayMax, &
		ll_Index, &
		ll_FirstRow, &
		ll_LastRow, &
		ll_Row, &
		ll_BadLocaters, &
		ll_TransactionId, &
		ll_AmountCount
		
decimal	lc_legAmount

string	lsa_Expression[], &
			lsa_Datapoint[], &
			lsa_Blank[], &
			ls_ErrorMessage, &
			ls_DateString, &
			ls_type


Date		lda_Dates[]
		
boolean	lb_MileageChecked

n_cst_beo_Transaction		lnv_NullTransaction
n_cst_Beo_AmountTemplate	lnv_AmountTemplate
n_cst_Beo_AmountOwed			lnv_AmountOwed, &
									lnva_Amounts[]
n_cst_Msg						lnv_Range
n_cst_string					lnv_String
s_Parm							lstr_Parm
n_ds								lds_Itinerary, &
									lds_EventCache, &
									lds_LegData
n_cst_events		lnv_events
dwObject	ldwo_EventType

ll_TemplateCount = UpperBound ( inva_AmountTemplate )

IF IsValid ( an_Transaction ) THEN
	ll_TransactionId = an_Transaction.of_GetId ( )
ELSE
	SetNull ( ll_TransactionId )
END IF

IF ll_TemplateCount > 0 THEN

	lds_LegData = CREATE n_ds
	lds_LegData.DataObject = "d_ItineraryData"
		
	//IF a RouteType for Settlements was determined earlier, set it for use in mileage calculations.
	IF ib_RouteTypeDefined THEN
		inv_Itinerary.of_SetRouteType ( ii_RouteType )
	END IF

	inv_Itinerary.of_SetDiscardOptional(TRUE)
	
	FOR ll_TemplateIndex = 1 TO ll_TemplateCount

		//Initially set itinerary for whole range
		lnv_Range.of_Reset ( )
		inv_Itinerary.of_SetRange  ( this.of_GetInitialItineraryRange ( ) )
		
		IF NOT lb_MileageChecked THEN
			IF inv_Itinerary.of_InitTrip ( lnv_Range ) <> 1 THEN
				lb_MileageChecked = TRUE
				// inform of any companies w/ bad locators
				IF lnv_Range.of_Get_Parm ( "IDS" , lstr_Parm ) <> 0 THEN
					ll_BadLocaters = UpperBound ( lstr_Parm.ia_Value  ) 
					choose case messagebox("Invalid Locaters", "One or more companies with invalid " + &
							"PC*Miler Locators has been found.  The mileage values will be zero, and " + &
							"any calculations based on mileages will be affected. Choose yes to generate the " + &
							"settlement. Choose no to cancel the generation and see a list of the companies.", Question!, YesNo!) 
					case 1
						
					case 2
						openWithParm(w_colist, lnv_Range )
						li_Return = -1
					end choose
		
				END IF
				IF li_Return = 0 THEN
					// if events were found w/o sites then the dates are provided to the user as means of id
					IF lnv_Range.of_Get_parm ( "DATES" ,lstr_Parm ) <> 0 THEN
						lda_Dates = lstr_Parm.ia_Value
						lnv_String.of_ArrayToString(lda_Dates,"~r~n,",ls_DateString)
						choose case messagebox("Unspecified Sites", "Unspecified sites were encountered on dates: " + &
								ls_DateString + "~r~nThe mileage values will be zero, and " + &
								"any calculations based on mileages will be affected. Do you still wish to " + &
								"generate the settlement?", Question!, YesNo!) 
						case 1
							
						case 2
							li_Return = -1
						end choose
			
					END IF
					
				END IF
	
			END IF
		END IF

		IF li_Return = -1 THEN
			EXIT
		ELSE
			lnv_AmountTemplate = inva_AmountTemplate [ ll_TemplateIndex ]
			
			IF isvalid ( lnv_AmountTemplate ) THEN
		
				//look for expressions (quantity,rate,amount)
				lsa_Expression = lsa_Blank
				this.of_LoadExpression(lnv_AmountTemplate, lsa_Expression)
				ll_ArrayMax = upperbound(lsa_Expression)
				
//				IF ll_ArrayMax = 0 THEN
//					//nothing in the template, move on to the next
//					CONTINUE
//				END IF
		
				//get data points for loading the calculation datastore, we only need to load the columns 
				//that are needed to perform the calculations
				lsa_DataPoint = lsa_Blank
				FOR ll_Index = 1 TO ll_ArrayMax
					this.of_GetDataPoint(lsa_Expression[ll_Index], lsa_DataPoint)
				NEXT
		
				IF lnv_AmountTemplate.of_GetAggregateCalc() THEN					

					//For performance reasons, instead of passing the transaction to of_AggregateCalc and
					//letting it make the link normally, we're going to pass a null transaction and get an
					//array of unassigned amounts back.  Then, we'll use of_SetFkTransaction_Direct to set the foreign
					//keys, but avoid recalculating the transaction.  Then, at the end of the script, we'll
					//call of_Calculate on the transaction, so it will recognize the amounts we've assigned
					//to it.

					This.of_AggregateCalc (  lnv_AmountTemplate, lnv_NullTransaction, lsa_DataPoint, lnva_Amounts )

					ll_AmountCount = UpperBound ( lnva_Amounts )

					FOR ll_Index = 1 TO ll_AmountCount

						IF IsValid ( lnva_Amounts [ ll_Index ] ) THEN
	
							IF NOT IsNull ( ll_TransactionId ) THEN
								lnva_Amounts [ ll_Index ].of_SetFkTransaction_Direct ( ll_TransactionId )
							END IF
	
						END IF

					NEXT
										
				ELSE			
					//get leg itineraries
					inv_Itinerary.of_GetFirstLastEventRow(ll_FirstRow, ll_LastRow)
					lds_EventCache = inv_Itinerary.of_GetEventCache( )
					
					FOR ll_Row = ll_FirstRow TO ll_LastRow
						
						lnv_Range.of_Reset ( )
					
						lstr_Parm.is_Label = "StartRow"
						lstr_Parm.ia_Value = ll_Row
						lnv_Range.of_Add_Parm ( lstr_Parm )
						
						lstr_Parm.is_Label = "EndRow"
						lstr_Parm.ia_Value = ll_Row
						lnv_Range.of_Add_Parm ( lstr_Parm )
						
						lstr_Parm.is_Label = "ItinType"
						lstr_Parm.ia_Value = this.of_GetItineraryType()
						lnv_Range.of_Add_Parm ( lstr_Parm )
						
						lstr_Parm.is_Label = "ItinId"
						lstr_Parm.ia_Value = this.of_GetItineraryId()
						lnv_Range.of_Add_Parm ( lstr_Parm )
						
						lstr_Parm.is_Label = "RetainExcludedShipments"
						lstr_Parm.ia_Value = TRUE
						lnv_Range.of_Add_Parm ( lstr_Parm )
			
						inv_Itinerary.of_SetRange ( lnv_Range )
			
						lds_LegData.Reset()
						lds_LegData.InsertRow(0)
						this.of_LoadCalculationDatastore ( lsa_DataPoint, lds_LegData )

						//For performance reasons, instead of passing the transaction to of_GenerateAmount and
						//letting it make the link normally, we're going to pass a null transaction and get an
						//unassigned amount back.  Then, we'll use of_SetFkTransaction_Direct to set the foreign
						//key, but avoid recalculating the transaction.  Then, at the end of the script, we'll
						//call of_Calculate on the transaction, so it will recognize the amounts we've assigned
						//to it.

						//lc_LegAmount = this.of_GenerateAmount(lds_LegData, lnv_AmountTemplate, an_transaction, inv_Itinerary, lnv_AmountOwed)
						lc_LegAmount = this.of_GenerateAmount(lds_LegData, lnv_AmountTemplate, lnv_NullTransaction, lnv_AmountOwed)

						IF IsValid ( lnv_AmountOwed ) THEN

							IF NOT IsNull ( ll_TransactionId ) THEN
								lnv_AmountOwed.of_SetFkTransaction_Direct ( ll_TransactionId )
							END IF

						END IF
							
						ldwo_EventType = lds_EventCache.Object.de_event_type
						ls_type = ldwo_EventType.Primary [ ll_row ]

						if lnv_events.of_isTypeLocationOptional( ls_type ) then
							//don't include
						else
							lc_LegAmount = round(lc_LegAmount,2)
			
							IF lc_LegAmount <> 0 THEN
								il_GeneratedCount ++
								this.of_AddPaySplit( ll_Row, lc_LegAmount, lnv_AmountOwed )
							END IF						
						end if
					
						inv_Itinerary.of_AppendExcludedShipmentsForRange ( )
			
					NEXT		
		
				END IF
			END IF
		END IF
	NEXT

	//Force the transaction to recalculate, so that it recomputes with the amounts we've directly assigned to it.
	IF IsValid ( an_Transaction ) THEN
		an_Transaction.of_Calculate ( )
	END IF
	
END IF

DESTROY lds_LegData
			


end subroutine

private function decimal of_aggregatecalc (n_cst_beo_amounttemplate anv_amounttemplate, n_cst_beo_transaction an_transaction, string asa_datapoint[], ref n_cst_beo_amountowed anva_amounts[]);// do calculation for total range

long	ll_DaysAfter, &
		ll_DayIndex, &
		ll_RowCount, &
		ll_AmountCount
		
decimal	lc_AmounttoSplit, &
			lc_TotalSplit
		
string	ls_SplitsByExpression

date		ld_Start

n_ds			lds_Calculation, &
				lds_Itinerary
n_cst_msg	lnv_Range
s_parm		lstr_Parm
n_cst_beo_AmountOwed	lnv_AmountOwed, &
							lnva_Amounts[]

IF ib_WholeDateRange THEN
	ll_DaysAfter = 0
ELSE
	ll_DaysAfter = daysafter(id_start, id_end)
END IF

FOR ll_DayIndex = 0 to ll_DaysAfter

	IF ib_WholeDateRange THEN 
		//Range already set
	ELSE
		
		lnv_Range.of_Reset ( )
		
		lstr_Parm.is_Label = "StartDate"
		ld_Start = relativedate(id_Start,ll_DayIndex)
		lstr_Parm.ia_Value = ld_Start
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "EndDate"
		
		IF ib_WholeDateRange THEN
			lstr_Parm.ia_Value = id_end		
		ELSE
			lstr_Parm.ia_Value = ld_Start
		END IF
		
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = this.of_GetItineraryType()
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = this.of_GetItineraryId()
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		inv_Itinerary.of_SetRange ( lnv_Range )
			
	END IF
	
	lds_Calculation = CREATE n_ds
	lds_Calculation.DataObject = "d_ItineraryData"
	lds_Calculation.InsertRow(0)
	this.of_LoadCalculationDatastore (asa_DataPoint, lds_Calculation )
	lc_AmounttoSplit = this.of_GenerateAmount(lds_Calculation, anv_AmountTemplate, an_transaction, lnv_AmountOwed)
	

	IF IsValid ( lnv_AmountOwed ) THEN
		ll_AmountCount ++
		lnva_Amounts [ ll_AmountCount ] = lnv_AmountOwed
	END IF


	IF lc_AmounttoSplit <> 0 THEN
		il_GeneratedCount ++
		//split to legs		
		ls_SplitsByExpression = anv_AmountTemplate.of_GetSplitsby ( )
		
		IF Len ( Trim ( ls_SplitsByExpression ) ) > 0 THEN
			//run splitsby against total itinerary, this number will be used
			//when determining percentages of participating legs
			lds_Calculation.Object.cf_Numeric.Expression = ls_SplitsByExpression
			lc_TotalSplit = lds_Calculation.GetItemNumber ( 1, "cf_Numeric" )
		
		ELSE
			lc_TotalSplit = 0
		
		END IF	
		
		this.of_GeneratePaySplits(anv_AmountTemplate, asa_datapoint, lnv_AmountOwed, lc_TotalSplit)
		
	END IF
	
	
	DESTROY lds_Calculation

NEXT

anva_Amounts = lnva_Amounts

return lc_TotalSplit
end function

public function decimal of_generateamount (ref datastore ads_data, n_cst_beo_amounttemplate anv_amounttemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amountowed anv_amountowed);//////////////////////////////////////////////////////////////////////////////
//
//
//	Function:  of_GenerateAmount for n_cst_bso_TransactionManager
//  
//	Access:  public
//
//	Arguments: 
//					ads_data by reference
//					anv_amounttemplate by value
//					an_transaction by reference
//					anv_amountowed by reference 
//
//	Return:		decimal 
//						
//
//	Description:  Used in settlement processing.
//						Code checks info in  amount template to see if and how
//						to create the amount owed.  
//						Calls of_createamountowed to actually create the amount
//						owed.
//			
//
//
// Written by:  anon.
// 		Date: 
//		Version: 
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version 1.1 JMA 10.1.02  Created new method, of_createamountowed from code
//					in this module.  The existing code was commented out. This header
//					was created too.
//	
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_ZeroAmountTemplate = FALSE

Long		ll_Offset, &
			ll_Return

integer	li_Division

String	ls_GenerationCondition, &
			ls_QuantityExpression, &
			ls_RateExpression, &
			ls_AmountExpression, &
			ls_PublicNote, &
			ls_Value
			
Decimal	lc_Quantity, &
			lc_Rate, &
			lc_Amount, &
			lc_Condition
			
boolean	lb_SkipGeneration

n_cst_beo_AmountOwed			lnv_Amount

//See if there is a generation condition on the amount template.

ls_GenerationCondition = anv_amountTemplate.of_GetGenerationCondition ( )

IF Len ( Trim ( ls_GenerationCondition ) ) > 0 THEN

	//Evaluate the generation condition to see whether the amount should be generated.
	//If yes, the condition should evaluate to 1.  If no, it should evaluate to 0.
	//(In actuality, any value but 0 will generate the amount.)

	ads_Data.Object.cf_Numeric.Expression = ls_GenerationCondition
	lc_Condition = ads_Data.GetItemNumber ( 1, "cf_Numeric" )
	//Dot notation with a type conversion here?  Could prevent crash??  Is that good??

	IF lc_Condition = 0 THEN  //Don't generate the amount.
		lb_SkipGeneration = TRUE
	ELSE
		lb_SkipGeneration = FALSE
	END IF

END IF


IF lb_SkipGeneration = FALSE THEN
	//Get values for Amount, Quantity, and Rate Expressions.
	
	ls_AmountExpression = anv_amountTemplate.of_GetAmount ( )
	ls_QuantityExpression = anv_amountTemplate.of_GetQuantity ( )
	ls_RateExpression = anv_amountTemplate.of_GetRate ( )
	
	lc_Amount = 0
	lc_Quantity = 0
	lc_Rate = 0
	
	//If there is an Amount Expression, evaluate it.  Otherwise, if there is a quantity
	//or rate expression, evaluate them.
	
	IF Len ( Trim ( ls_AmountExpression ) ) > 0 THEN
		
		if left(upper(ls_AmountExpression),6) = ':SHIP(' then
			//use ratecodename from shipment item
			
		elseif left(ls_AmountExpression,2) = ':(' then
			//override shipment item ratecodename
			
		else
			ads_Data.Object.cf_Numeric.Expression = ls_AmountExpression
			lc_Amount = ads_Data.GetItemNumber ( 1, "cf_Numeric" )
		end if
	
	ELSE
	
		IF Len ( Trim ( ls_QuantityExpression ) ) > 0 THEN
	
			ads_Data.Object.cf_Numeric.Expression = ls_QuantityExpression
			lc_Quantity = ads_Data.GetItemNumber ( 1, "cf_Numeric" )
			//Dot notation with a type conversion here?  Could prevent crash??  Is that good??
	
		END IF
	
	
		IF Len ( Trim ( ls_RateExpression ) ) > 0 THEN
			
			if left(upper(ls_RateExpression),6) = ':SHIP(' then
				//use ratecodename from shipment item
				
			elseif left(ls_RateExpression,2) = ':(' then
				//override shipment item ratecodename
				
			else
				ads_Data.Object.cf_Numeric.Expression = ls_RateExpression
				lc_Rate = ads_Data.GetItemNumber ( 1, "cf_Numeric" )
				//Dot notation with a type conversion here?  Could prevent crash??  Is that good??
			end if
			
		END IF
	
	END IF

	//If the AmountTemplate has GenerateIfZero = FALSE, check whether the amount will be zero, 
	//and if so, skip the generation.
	
	IF anv_amountTemplate.of_GetGenerateIfZero ( ) = FALSE THEN
	
		IF lc_Amount <> 0 OR ( lc_Quantity <> 0 AND lc_Rate <> 0 ) THEN
	
			//Amount will not be zero.  Generate it.
	
		ELSE
	
			//Amout will be zero.  
			lb_SkipGeneration=TRUE
	
		END IF
	
	END IF

END IF


IF lb_SkipGeneration = FALSE THEN
	ll_Return = this.of_CreateAmountOwed(anv_AmountTemplate, an_Transaction, lnv_Amount, lc_amount, &
		lc_quantity, lc_rate, lb_zeroamounttemplate)
END IF

IF IsValid(lnv_Amount) THEN  //If garbage came back, don't propagate it upstream.
	anv_Amountowed = lnv_Amount
ELSE
	lc_Amount = 0
END IF
Return lc_Amount
end function

public subroutine of_addpaysplit (long al_row, decimal ac_splitsamount, n_cst_beo_amountowed anv_amountowed);long	ll_ShipmentId, &
		ll_EventId, &
		ll_NextId, &
		ll_PaySplitRow
		
string	ls_type, &
			ls_itemtype
			
			
n_cst_beo_amounttype	lnv_amounttype

CONSTANT Boolean cb_Commit	= TRUE	

n_ds	lds_Event, &
		lds_PaySplitCache

dwObject	ldwo_EventId, &
			ldwo_ShipmentId
				
lds_PaySplitCache = of_GetPaySplitCache(TRUE)
lds_Event = inv_itinerary.of_GetEventCache()
//GET SHIPMENTID 
ldwo_ShipmentId = lds_Event.Object.de_shipment_id
ll_ShipmentId = ldwo_ShipmentId.Primary [ al_Row ]
IF isnull(ll_ShipmentId) THEN
	//determine whether event type is linking to the next shipment or previous one
	ll_ShipmentId = this.of_LinkEventtoShipmentId(lds_Event, al_Row )
END IF

ldwo_EventId = lds_Event.Object.de_id
ll_EventId = ldwo_EventId.Primary [ al_Row ]

//get the item type 
if this.of_GetAmountType (anv_AmountOwed.of_GetType(), lnv_amounttype) = 1 then
	ls_ItemType = lnv_AmountType.of_GetItemType()
end if

//write to splits table 
ll_PaySplitRow = lds_PaySplitCache.InsertRow(0)

IF gnv_App.of_GetNextId ( "paysplit", ll_NextId, cb_Commit ) = 1 THEN
	lds_PaySplitCache.object.id[ll_PaySplitRow] = ll_NextId

	lds_PaySplitCache.object.amountid[ll_PaySplitRow] = anv_AmountOwed.of_GetId( )
	lds_PaySplitCache.object.eventid[ll_PaySplitRow] = ll_EventId
	lds_PaySplitCache.object.shipmentid[ll_PaySplitRow] = ll_ShipmentId
	//turned off
	lds_PaySplitCache.object.paysplit[ll_PaySplitRow] = ac_SplitsAmount
	lds_PaySplitCache.object.itemtype[ll_PaySplitRow] = ls_itemtype
		
	this.of_SetPaySplitCache(lds_PaySplitCache)

END IF


end subroutine

private function long of_linkeventtoshipmentid (datastore ads_event, long al_row);long	ll_ShipmentId, &
		ll_Index, &
		ll_RowCount, &
		lla_ShipmentIds[], &
		ll_shipmentCount, &
		ll_LocationOptionalCount
		
boolean	lb_NextShipment, &
			lb_ShipmentIdFound

n_ds	lds_Event
dwObject	ldwo_EventType, &
			ldwo_ShipmentId

ldwo_EventType = ads_Event.Object.de_Event_Type
ldwo_ShipmentId = ads_Event.Object.de_Shipment_Id

lds_Event = inv_itinerary.of_GetEventCache()
ll_RowCount = lds_Event.RowCount()

IF ll_RowCount > 1 THEN
	ll_LocationOptionalCount = inv_itinerary.of_GetLocationOptionalCount( )
	IF isnull(ll_LocationOptionalCount) THEN
	
	ELSE
		ll_RowCount = ll_RowCount - ll_LocationOptionalCount
	END IF
END IF	


lla_ShipmentIds = lds_Event.Object.de_Shipment_Id.Primary
CHOOSE CASE ldwo_EventType.Primary [ al_Row ]
		
	CASE gc_Dispatch.cs_EventType_Pickup, gc_Dispatch.cs_EventType_Deliver
	
	CASE gc_Dispatch.cs_EventType_NewTrip, gc_Dispatch.cs_EventType_Hook, &
		gc_Dispatch.cs_EventType_Mount, gc_Dispatch.cs_EventType_Bobtail, &
		gc_Dispatch.cs_EventType_Deadhead
		
		//NEXT SHIPID
		FOR ll_Index = al_Row + 1 to ll_RowCount
			ll_ShipmentId = ldwo_ShipmentId.Primary [ ll_Index ]
			IF ll_ShipmentId > 0  THEN
				lb_ShipmentIdFound = TRUE
				exit
			end if
			
			lb_ShipmentIdFound = FALSE
			
		NEXT
	
		IF NOT Lb_ShipmentIdFound THEN
			setnull(ll_ShipmentID)
		END IF
			
	CASE gc_Dispatch.cs_EventType_EndTrip, gc_Dispatch.cs_EventType_Drop, &
		gc_Dispatch.cs_EventType_Dismount
		
		//PREVIOUS SHIPID
		inv_itinerary.of_GetExcludedShipments(lla_ShipmentIds)
		ll_ShipmentCount = upperbound(lla_ShipmentIds)
		IF ll_ShipmentCount > 0 THEN
			ll_ShipmentId = lla_ShipmentIds[ll_ShipmentCount]
		ELSE
			setnull(ll_ShipmentID)
		END IF
	
		
	CASE gc_Dispatch.cs_EventType_Reposition, gc_Dispatch.cs_EventType_Misc, &
		gc_Dispatch.cs_EventType_CheckCall, gc_Dispatch.cs_EventType_PositionReport, &
		gc_Dispatch.cs_EventType_Breakdown, gc_Dispatch.cs_EventType_PMService, &
		gc_Dispatch.cs_EventType_Repairs, gc_Dispatch.cs_EventType_Accident, &
		gc_Dispatch.cs_EventType_DOT, gc_Dispatch.cs_EventType_Scale, &
		gc_Dispatch.cs_EventType_OffDuty, gc_Dispatch.cs_EventType_Sleeper
		//NON SHIPMENT RELATED
		setnull(ll_ShipmentId)
		
END CHOOSE

Return ll_ShipmentId
end function

public function long of_validateitinerarymileage ();long ll_Return=0

String	ls_Description, &
			ls_Message
			
Constant String	ls_Format = "m/d/yy (Ddd)"
Date		ld_Start, &
			ld_End

ld_Start = inv_Itinerary.of_GetStartDate ( )
ld_End = inv_Itinerary.of_GetEndDate ( )

//give user the option to proceed or cancel.

IF IsNull ( inv_Itinerary.of_GetTotalMiles ( ) ) THEN
	ls_Description = String ( ld_Start, ls_Format ) + " - " + String ( ld_End, ls_Format )
END IF
		
IF Len ( ls_Description ) > 0 THEN

	ls_Message = "WARNING:~nMileages could not be calculated for the selected range " +&
					ls_Description + &
					", due to unspecified stops or invalid PC*Miler Locators. " +&
					"The mileage values will be zero, and any calculations based on mileages " + &
					"will be affected. Do you wish to generate the settlement anyway?"

	IF MessageBox ( "Auto-Generate Settlement", ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
		ll_Return = -1  //Not really an error, but we don't have another option here.
	END IF

END IF


return ll_Return


end function

public subroutine of_manualamount (ref n_cst_beo_transaction an_transaction, n_cst_bso_dispatch anv_dispatch, decimal ac_amount, integer ac_amounttype, boolean ac_taxable, date ad_start, date ad_end);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ManualAmount
//
//	Access:  private
//
//	Arguments:  
//					an_transaction
//					ac_Amount
//
//	Description:	
//					create amount owed for manual amount
//
// Written by: Norm LeBlanc
// 		Date: 06/28/01
//		Version: 3.5
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
long	ll_FirstRow, &
		ll_LastRow, &
		ll_Row, &
		ll_TransactionId, &
		ll_RowCount, &
		ll_Return, &
		ll_LocationOptionalCount
			
decimal	lc_SplitsAmount, &
			lc_RunningTotal

string	ls_type

n_cst_Beo_AmountTemplate	lnv_AmountTemplate
n_cst_Beo_AmountOwed			lnv_AmountOwed
n_cst_Msg						lnv_Range
s_Parm							lstr_Parm
n_ds					lds_Event
n_cst_events		lnv_events
dwObject	ldwo_EventType

IF IsValid ( an_Transaction ) THEN

	//A transaction was passed in.  Use it as the generation target.

	IF IsNull ( an_Transaction.of_GetStartDate ( ) ) AND &
		IsNull ( an_Transaction.of_GetEndDate ( ) ) THEN

		an_Transaction.of_SetStartDate ( ad_Start )
		an_Transaction.of_SetEndDate ( ad_End )

	END IF

ELSE

	//No transaction was passed in.  Create a new one.

	an_Transaction = This.of_NewTransaction ( )

	IF IsValid ( an_Transaction ) THEN

		an_Transaction.of_SetStartDate ( ad_Start )
		an_Transaction.of_SetEndDate ( ad_End )

	ELSE
		ll_Return = -1

	END IF

END IF

IF isvalid ( anv_Dispatch ) THEN
	
	IF isvalid ( inv_itinerary ) THEN
		//OK to proceed
	ELSE
		inv_itinerary = CREATE n_cst_beo_itinerary2
		//destroy in destructor
	END IF

	inv_Itinerary.of_SetDispatchManager ( anv_Dispatch )
	
END IF

//**
IF IsValid ( an_Transaction ) THEN
	ll_TransactionId = an_Transaction.of_GetId ( )
ELSE
	SetNull ( ll_TransactionId )
END IF

inv_Itinerary.of_SetDiscardOptional(TRUE)

//Initially set itinerary for whole range
lnv_Range.of_Reset ( )
inv_Itinerary.of_SetRange ( this.of_GetInitialItineraryRange ( ) )

//create amountowed
IF IsValid ( an_Transaction ) THEN
	lnv_AmountOwed = This.of_NewAmountOwed ( an_Transaction )
ELSE
	lnv_AmountOwed = This.of_NewAmountOwed ( )
END IF

IF IsValid ( lnv_AmountOwed ) THEN

	THIS.of_AmountOwedItineraryData ( lnv_AmountOwed ) 
	
	lnv_AmountOwed.of_SetDescription ( "MANUAL AMOUNT" )
	lnv_AmountOwed.of_SetAmount ( ac_Amount )
	lnv_AmountOwed.of_SetType ( ac_amounttype )
	lnv_AmountOwed.of_SetTaxable ( ac_taxable )
	
		
	IF NOT IsNull ( ll_TransactionId ) THEN
		lnv_AmountOwed.of_SetFkTransaction_Direct ( ll_TransactionId )
	END IF
	
ELSE
	
	ll_Return = -1
	
END IF

IF ll_Return = 0 THEN
	// add paysplits
	
	//paysplits are always done for the legs
		
	ll_RowCount = inv_itinerary.of_GetEventCount()
	
	//need to determine qualifying events for an even split
	IF ll_RowCount > 1 THEN
		ll_LocationOptionalCount = inv_itinerary.of_GetLocationOptionalCount( )
		IF isnull(ll_LocationOptionalCount) THEN
		
		ELSE
			ll_RowCount = ll_RowCount - ll_LocationOptionalCount
		END IF
	END IF	
	
	//get leg itineraries
	inv_itinerary.of_GetFirstLastEventRow(ll_FirstRow, ll_LastRow)

	lds_Event = inv_itinerary.of_GetEventCache()

	FOR ll_Row = ll_FirstRow TO ll_LastRow
		
		lnv_Range.of_Reset ( )
	
		lstr_Parm.is_Label = "StartRow"
		lstr_Parm.ia_Value = ll_Row
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "EndRow"
		lstr_Parm.ia_Value = ll_Row
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinType"
		lstr_Parm.ia_Value = this.of_GetItineraryType()
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "ItinId"
		lstr_Parm.ia_Value = this.of_GetItineraryId()
		lnv_Range.of_Add_Parm ( lstr_Parm )
		
		lstr_Parm.is_Label = "RetainExcludedShipments"
		lstr_Parm.ia_Value = TRUE
		lnv_Range.of_Add_Parm ( lstr_Parm )
	
		inv_Itinerary.of_SetRange ( lnv_Range )
	
		ldwo_EventType = lds_Event.Object.de_event_type
		ls_type = ldwo_EventType.Primary [ ll_row ]
		
		if lnv_events.of_isTypeLocationOptional( ls_type ) then
			continue
		end if

		//Count the number of legs and divide evenly
		IF ll_RowCount > 0 THEN 
			lc_SplitsAmount = round ( ac_amount / ll_rowcount , 2 ) 
		END IF
				
		IF ll_Row = ll_LastRow THEN
			lc_SplitsAmount = ac_amount - lc_RunningTotal
		ELSE
			IF Abs ( lc_RunningTotal + lc_SplitsAmount ) > Abs ( ac_amount ) THEN
				lc_SplitsAmount = ac_amount - lc_RunningTotal
			END IF
		END IF
	
		IF lc_SplitsAmount <> 0 	THEN
			this.of_AddPaySplit( ll_Row, lc_SplitsAmount, lnv_amountowed )
			lc_RunningTotal += lc_SplitsAmount
		END IF
		
	NEXT		
	
	//Force the transaction to recalculate, so that it recomputes with the amounts we've directly assigned to it.
	IF IsValid ( an_Transaction ) THEN
		an_Transaction.of_Calculate ( )
	END IF

END IF

end subroutine

public function long of_getnewamountidlist (ref long ala_newamountid[]);//	This list is the current list for the generateamount and manualamount methods.
//	The resetting of the list must be controlled by the user of the list.

ala_NewAmountId = ila_newamountid

return upperbound ( ila_newamountid )
end function

public subroutine of_resetnewamountid ();//	This list must be controlled by the user of the list.
long	lla_Empty []

ila_newamountid = lla_Empty
end subroutine

public function long of_generatepayable (date ad_start, date ad_end, ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amounttemplate anva_amounttemplate[], n_cst_bso_dispatch anv_dispatch, boolean ab_wholedaterange);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GeneratePayable
//
//	Access:  public
//
//	Arguments:  
//					ad_start					 by value
//					ad_end					 by value
//					an_transaction  		 by reference
//					anva_amounttemplate[] by reference
//					anv_dispatch			 by value
//					ab_wholedaterange 	 by value
//
//	Return:    number of generated amounts
//
//	Description:	
//			prepare transaction and itinerary for payables and paysplits generation
//			initiate amount template loop processing
//
//
// Written by: Norm LeBlanc
// 		Date: 05/07/01
//		Version: 3.0.17
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

Long		ll_ItineraryId, &
			ll_EntityId, &
			ll_Return = 0

date		ld_nulldate

s_Parm			lstr_Parm
n_cst_msg		lnv_Range

n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Transaction		lnv_Transaction
setnull(ld_nulldate)

ib_WholeDateRange = ab_WholeDateRange
id_Start = ad_start
id_End = ad_end
il_GeneratedCount = 0

/*	Let's make sure the entityid is valid before proceeding 
	(it should be set before calling this method) 
*/
ll_EntityId = This.of_GetDefaultEntityId ( )
IF IsNull ( ll_EntityId ) OR ll_EntityId = 0 THEN
	ll_Return = -1
END IF

/*	
	amount templates may be passed in by interactive blocking
*/
If upperbound(anva_AmountTemplate) > 0  THEN
	inva_AmountTemplate = anva_AmountTemplate
ELSE
	IF this.of_GetAmountTemplate(inva_AmountTemplate) = -1 THEN
		ll_Return = -1
	END IF
END IF

IF ll_Return = 0 THEN

	//Get the RouteType to use for mileage calculations, if the user has defined one.
	//Otherwise, use system defaults.

	CHOOSE CASE This.of_GetRouteTypeSettlements ( ii_RouteType )

	CASE 1
		ib_RouteTypeDefined = TRUE

	CASE 0  //Route type is not defined, or is invalid
		ib_RouteTypeDefined = FALSE

	CASE ELSE //-1 = Error
		ll_Return = -1

	END CHOOSE

END IF

IF ll_Return = 0 THEN
	IF isvalid ( anv_Dispatch ) THEN
		
		lnv_Dispatch = anv_Dispatch
		
		//if passing in a dispatch object, then you set the initial range from outside
		
	ELSE
		//Create the dispatch manager and get the itineraries for the selected range
		lnv_Dispatch = CREATE n_cst_bso_Dispatch
	
		IF this.of_SetItineraryId( ) = 1 THEN
			
			this.of_SetItineraryType( )
			IF lnv_Dispatch.of_RetrieveItinerary (this.of_GetItineraryType(), this.of_GetItineraryId(), RelativeDate ( ad_Start, -7 ), ad_End, TRUE /*NeedsPrior*/ ) < 0 THEN
				ll_Return = -1
			ELSE
				lnv_Dispatch.of_FilterItinerary (this.of_GetItineraryType(), this.of_GetItineraryId(), ld_nulldate, ld_nulldate )	
			END IF
		
			lstr_Parm.is_Label = "StartDate"
			lstr_Parm.ia_Value = id_start
			lnv_Range.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "EndDate"
			lstr_Parm.ia_Value = id_end
			lnv_Range.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "ItinType"
			lstr_Parm.ia_Value = this.of_GetItineraryType()
			lnv_Range.of_Add_Parm ( lstr_Parm )
			
			lstr_Parm.is_Label = "ItinId"
			lstr_Parm.ia_Value = this.of_GetItineraryId()
			lnv_Range.of_Add_Parm ( lstr_Parm )
	
			this.of_SetInitialitineraryRange ( lnv_Range ) 
			
		ELSE
			
			ll_Return = -1
			
		END IF
			
	END IF
	
END IF

IF ll_Return = 0 THEN

	IF IsValid ( an_Transaction ) THEN

		//A transaction was passed in.  Use it as the generation target.

		lnv_Transaction = an_Transaction

		IF IsNull ( lnv_Transaction.of_GetStartDate ( ) ) AND &
			IsNull ( lnv_Transaction.of_GetEndDate ( ) ) THEN

			lnv_Transaction.of_SetStartDate ( ad_Start )
			lnv_Transaction.of_SetEndDate ( ad_End )

		END IF

	ELSE

		//No transaction was passed in.  Create a new one.

		lnv_Transaction = This.of_NewTransaction ( )
	
		IF IsValid ( lnv_Transaction ) THEN
	
			lnv_Transaction.of_SetStartDate ( ad_Start )
			lnv_Transaction.of_SetEndDate ( ad_End )
	
		ELSE
			ll_Return = -1
	
		END IF

	END IF

END IF

IF ll_Return = 0 THEN

	IF isvalid ( inv_itinerary ) THEN
		//OK to proceed
	ELSE
		inv_itinerary = CREATE n_cst_beo_itinerary2
		//destroy in destructor
	END IF

	inv_Itinerary.of_SetDispatchManager ( lnv_Dispatch )
	
	this.of_templateloop( lnv_transaction )	
	
	ll_Return = il_GeneratedCount
	
END IF

//Pass the transaction out and return.
an_Transaction = lnv_Transaction
 
Return ll_Return
end function

public function long of_loadexpression (n_cst_beo_amounttemplate anv_amount, ref string asa_expression[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Load Expression
//
//	Access:  public
//
//	Arguments:  
//					anv_amount
//					asa_expression[] by reference
//
// Return:		number of expressions
//
//	Description:	
//			Extract all of the expressions (quantity, rate, amount) from the 
//			amount templates.
//
// Written by: Norm LeBlanc
// 		Date: 05/07/01
//		Version: 3.0.17
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
String	ls_GenerationCondition, &
			ls_QuantityExpression, &
			ls_RateExpression, &
			ls_AmountExpression, &
			ls_SplitsByExpression

//See if there is a generation condition on the amount template.

ls_GenerationCondition = anv_amount.of_GetGenerationCondition ( )
IF Len ( Trim ( ls_GenerationCondition ) ) > 0 THEN
	asa_Expression[upperbound(asa_Expression) + 1] = ls_GenerationCondition
END IF

//Get values for Amount, Quantity, and Rate Expressions.

ls_AmountExpression = anv_amount.of_GetAmount ( )
IF Len ( Trim ( ls_AmountExpression ) ) > 0 THEN
	asa_Expression[upperbound(asa_Expression) + 1] = ls_AmountExpression
END IF

ls_QuantityExpression = anv_amount.of_GetQuantity ( )
IF Len ( Trim ( ls_QuantityExpression ) ) > 0 THEN
	asa_Expression[upperbound(asa_Expression) + 1] = ls_QuantityExpression
END IF

ls_RateExpression = anv_amount.of_GetRate ( )
IF Len ( Trim ( ls_RateExpression ) ) > 0 THEN
	asa_Expression[upperbound(asa_Expression) + 1] = ls_RateExpression
END IF

ls_SplitsByExpression = anv_amount.of_GetSplitsBy ( )
IF Len ( Trim ( ls_SplitsByExpression ) ) > 0 THEN
	asa_Expression[upperbound(asa_Expression) + 1] = ls_SplitsByExpression
END IF

Return upperbound(asa_Expression)
end function

public function long of_getdatapoint (string as_expression, ref string asa_datapoint[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetDataPoint
//
//	Access:  public
//
//	Arguments:  
//					as_expression
//					asa_datapoint[]
//					an_transaction
//
//
//	Description:	
//			Extract all of the expressions (quantity, rate, amount) from the 
//			amount templates.  Get all of the datapoints from the expresssions
//			and generate the amounts and splits.
//
// Written by: Norm LeBlanc
// 		Date: 05/07/01
//		Version: 3.0.17
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

//Hard coding the datapoints but should modify this to get itinerary tags with <> brackets

long	ll_Return, &
		ll_Index, &
		ll_ArrayMax, &
		ll_Pos, &
		ll_Null, &
		ll_len

string	lsa_PossibleDataPoint[], &
			ls_Expression

n_cst_anyarraysrv lnv_anyarray

setnull(ll_Null)

lsa_PossibleDataPoint[1]="TOTALMILES"
lsa_PossibleDataPoint[2]="LOADEDMILES"
lsa_PossibleDataPoint[3]="EMPTYMILES"
lsa_PossibleDataPoint[4]="BOBTAILMILES"
lsa_PossibleDataPoint[5]="DEADHEADMILES"
lsa_PossibleDataPoint[6]="TOTALWEIGHT"
lsa_PossibleDataPoint[7]="SHIPMENTS"
lsa_PossibleDataPoint[8]="EVENTS"
lsa_PossibleDataPoint[9]="HOOKS"
lsa_PossibleDataPoint[10]="DROPS"
lsa_PossibleDataPoint[11]="DISMOUNTS"
lsa_PossibleDataPoint[12]="MOUNTS"
lsa_PossibleDataPoint[13]="PICKUPS"
lsa_PossibleDataPoint[14]="DELIVERIES"
lsa_PossibleDataPoint[15]="WORKINGSTOPS"
lsa_PossibleDataPoint[16]="STOPS"
lsa_PossibleDataPoint[17]="FREIGHTREVENUE"
lsa_PossibleDataPoint[18]="STARTDATE"
lsa_PossibleDataPoint[19]="ENDDATE"
lsa_PossibleDataPoint[20]="ITINERARYHOURS"

/*	
	Search the argument expression for datapoint(s), load to array, don't load duplicates.
	If a datapoint is found then load it to the array and then remove it from the expression.
	This is done to prevent finding 'stops' in 'workingstops'.
*/

ls_Expression = upper(as_Expression)

ll_ArrayMax = upperbound(lsa_PossibleDataPoint)

FOR ll_Index = 1 TO ll_ArrayMax

	ll_Pos = pos(ls_Expression, lsa_PossibleDataPoint[ll_Index], 1)
	
	IF ll_Pos > 0 THEN
		ls_Expression = Replace ( ls_Expression, ll_Pos, len(lsa_PossibleDataPoint[ll_Index]), '' )
		IF lnv_anyarray.of_Find( asa_datapoint, lsa_PossibleDataPoint[ll_Index], ll_Null, ll_Null) > 0 THEN
			//already in array
		ELSE
			asa_datapoint[upperbound(asa_datapoint) + 1] = 	lsa_PossibleDataPoint[ll_Index]
		END IF
	END IF

NEXT

Return ll_Return
end function

public function long of_loadcalculationdatastore (string asa_datapoint[], ref datastore ads_calculation);long	ll_ArrayMax, &
		ll_Index, &
		ll_Return = 0

ll_ArrayMax = upperbound(asa_DataPoint)

FOR ll_Index = 1 to ll_ArrayMax

	CHOOSE CASE upper(asa_DataPoint[ll_Index])
			
		CASE "TOTALMILES"
			ads_calculation.object.TotalMiles[1] = inv_Itinerary.of_GetTotalMiles()
			
		CASE "LOADEDMILES"
			ads_Calculation.Object.LoadedMiles[1] = inv_Itinerary.of_GetLoadedMiles()
			
		CASE "EMPTYMILES"
			ads_Calculation.Object.EmptyMiles[1] = inv_Itinerary.of_GetEmptyMiles()
			
		CASE "BOBTAILMILES"
			ads_Calculation.Object.BobTailMiles[1] = inv_Itinerary.of_GetBobTailMiles()
			
		CASE "DEADHEADMILES"
			ads_Calculation.Object.DeadHeadMiles[1] = inv_Itinerary.of_GetDeadHeadMiles()
			
		CASE "TOTALWEIGHT"
			inv_itinerary.of_Resetstopdata( )
			ads_calculation.object.TotalWeight[1] = inv_Itinerary.of_GetTotalWeight(TRUE,TRUE)
			inv_itinerary.of_Resetstopdata( )
			
		CASE "SHIPMENTS"
			ads_calculation.object.Shipments[1] = inv_Itinerary.of_GetShipmentCount()
			
		CASE "EVENTS"
			ads_Calculation.Object.Events[1] = inv_Itinerary.of_GetEventCount()
			
		CASE "HOOKS"
			ads_calculation.object.Hooks[1] = inv_Itinerary.of_GetHookCount()
			
		CASE "DROPS"
			ads_calculation.object.Drops[1] = inv_Itinerary.of_GetDropCount()
			
		CASE "DISMOUNTS"
			ads_Calculation.Object.Dismounts[1] = inv_Itinerary.of_GetDismountCount()
			
		CASE "MOUNTS"
			ads_Calculation.Object.Mounts[1] = inv_Itinerary.of_GetMountCount()
			
		CASE "PICKUPS"
			ads_calculation.object.Pickups[1] = inv_Itinerary.of_GetPickupCount()
			
		CASE "DELIVERIES"
			ads_calculation.object.Deliveries[1] = inv_Itinerary.of_GetDeliveryCount()
			
		CASE "WORKINGSTOPS"
			ads_calculation.object.WorkingStops[1] = inv_Itinerary.of_GetWorkingStopCount()
			
		CASE "STOPS"
			ads_calculation.object.Stops[1] = inv_Itinerary.of_GetStopCount()
			
		CASE "FREIGHTREVENUE"
			inv_itinerary.of_Resetstopdata( )
			ads_calculation.object.FreightRevenue[1] = inv_Itinerary.of_GetFreightRevenue(TRUE)
			inv_itinerary.of_Resetstopdata( )		
			
		CASE "STARTDATE"
			ads_calculation.object.StartDate[1] = inv_Itinerary.of_GetStartDate()
			
		CASE "ENDDATE"
			ads_calculation.object.EndDate[1] = inv_Itinerary.of_GetEndDate()
			
		CASE "ITINERARYHOURS"
			ads_calculation.object.ItineraryHours[1] = inv_Itinerary.of_GetItineraryHoursTotal()
				
	END CHOOSE
	
NEXT

Return ll_Return

end function

public function long of_setitineraryobject (n_cst_beo_itinerary2 anv_itinerary);//////////////////////////////////////////////////////////////////////////////
//
//
//	Function:  of_SetItineraryObject for n_cst_bso_transactionmanager
//  
//	Access:  private
//
//	Arguments: 
//					anv_itinerary 

//
//	Return:		ll_Return    
//					 
//						
//
//	Description:
//  While working in the n_cst_bso_payable object, the itinerary
//  object was modified.  Set the inv_itineray object in the
//  n_cst_bso_transactionmanager to be this new, improved itinerary!
//
//
// Written by: J. Albert
// 		Date: 10.24.02
//		Version: New
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//

long ll_Return


inv_itinerary = anv_itinerary
IF IsValid(inv_itinerary) then
	ll_Return = 1
ELSE
	ll_Return = -1
END IF

Return ll_Return
end function

public function long of_generatepaysplits (n_cst_beo_amounttemplate anv_amounttemplate, string asa_datapoint[], n_cst_beo_amountowed anv_amountowed, decimal ac_totalsplit);
//paysplits are always done for the legs even if amount is aggregate
	
long	ll_FirstRow, &
		ll_LastRow, &
		ll_Row, &
		ll_RowCount, &
		ll_Return, &
		ll_LocationOptionalCount

			
decimal	lc_LegAmount, &
			lc_SplitsAmount, &
			lc_AmountToSplit, &
			lc_RunningTotal

string	ls_SplitsByExpression, &
			ls_type
n_cst_Msg	lnv_Range
s_Parm		lstr_Parm
n_ds			lds_LegData, &
				lds_Event

n_cst_events		lnv_events
dwObject	ldwo_EventType

lc_AmountToSplit = anv_AmountOwed.of_GetAmount( )
ls_SplitsByExpression = anv_AmountTemplate.of_GetSplitsby ( )
ll_RowCount = inv_itinerary.of_GetEventCount()

//need to determine qualifying events for an even split
IF ll_RowCount > 1 THEN
	ll_LocationOptionalCount = inv_itinerary.of_GetLocationOptionalCount( )
	IF isnull(ll_LocationOptionalCount) THEN
	
	ELSE
		ll_RowCount = ll_RowCount - ll_LocationOptionalCount
	END IF
END IF	

//get leg itineraries
inv_itinerary.of_GetFirstLastEventRow(ll_FirstRow, ll_LastRow)

lds_Event = inv_itinerary.of_GetEventCache()

FOR ll_Row = ll_FirstRow TO ll_LastRow
	
	lnv_Range.of_Reset ( )

	lstr_Parm.is_Label = "StartRow"
	lstr_Parm.ia_Value = ll_Row
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "EndRow"
	lstr_Parm.ia_Value = ll_Row
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinType"
	lstr_Parm.ia_Value = this.of_GetItineraryType()
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "ItinId"
	lstr_Parm.ia_Value = this.of_GetItineraryId()
	lnv_Range.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "RetainExcludedShipments"
	lstr_Parm.ia_Value = TRUE
	lnv_Range.of_Add_Parm ( lstr_Parm )

	inv_Itinerary.of_SetRange ( lnv_Range )

	ldwo_EventType = lds_Event.Object.de_event_type
	ls_type = ldwo_EventType.Primary [ ll_row ]
	
	if lnv_events.of_isTypeLocationOptional( ls_type ) then
		//don't include
	else
		
		lds_LegData = CREATE n_ds
		lds_LegData.DataObject = "d_ItineraryData"
		lds_LegData.InsertRow(0)
		this.of_LoadCalculationDatastore (asa_DataPoint, lds_LegData )
		IF lds_LegData.RowCount() > 0 THEN
			IF Len ( Trim ( ls_SplitsByExpression ) ) > 0 THEN
				//get number for determining split percentage for each leg
				lds_LegData.Object.cf_Numeric.Expression = ls_SplitsByExpression
				lc_LegAmount = lds_LegData.GetItemNumber ( 1, "cf_Numeric" )
				IF lc_LegAmount > 0 THEN
					IF ac_totalsplit > 0 THEN
						lc_SplitsAmount = round ( ( lc_LegAmount / ac_totalsplit ) * lc_amounttosplit, 2 ) 
					ELSE
						//problem with total, don't split
					END IF
				ELSE
					lc_SplitsAmount = 0
				END IF
			ELSE
				//Count the number of legs and divide evenly
				IF ll_RowCount > 0 THEN 
					lc_SplitsAmount = round ( lc_amounttosplit / ll_rowcount , 2 ) 
				ELSE
					//cant split amount evenly
				END IF
				
			END IF
			
			IF ll_Row = ll_LastRow THEN
				lc_SplitsAmount = lc_amounttosplit - lc_RunningTotal
			ELSE
				IF Abs ( lc_RunningTotal + lc_SplitsAmount ) > Abs ( lc_amounttosplit ) THEN
					lc_SplitsAmount = lc_amounttosplit - lc_RunningTotal
				END IF
			END IF
	
		END IF
		
		IF lc_SplitsAmount <> 0 	THEN
			this.of_AddPaySplit( ll_Row, lc_SplitsAmount, anv_amountowed )
			lc_RunningTotal += lc_SplitsAmount
		END IF
		
		DESTROY lds_LegData
		
	end if

	inv_Itinerary.of_AppendExcludedShipmentsForRange ( )

NEXT	

return ll_Return
end function

public function long of_createamountowed (ref n_cst_beo_amounttemplate anv_amounttemplate, ref n_cst_beo_transaction an_transaction, ref n_cst_beo_amountowed anv_amountowed, ref decimal ac_amount, ref decimal ac_quantity, ref decimal ac_rate, boolean ab_zeroamounttemplate);//////////////////////////////////////////////////////////////////////////////
//
//
//	Function:  of_CreateAmountOwed for n_cst_bso_TransactionManager
//  
//	Access:  public
//
//	Arguments: 
//					anv_amounttemplate by reference
//					an_transaction by reference
//					anv_amountowed by reference (created here)
//					ac_amount by reference
//					ac_quantity by reference 
//					ac_rate by reference
//					ab_zeroamounttemplate
//
//	Return:		ll_Return    
//					Results are actually stored in create amountowed. 
//						
//
//	Description:
//			THis code was cut directly from a previously existing section
//			of_generateamount.  
//			This cut was made to allow the code to be shared between 
//			of_GenerateAmount and n_cst_bso_payable.of_ProcessPeriodic
//	
//       Modifications have been made to allow suspended amount templates
//       to generate zero value amount oweds.
//
//			It's function is to create an amount owed during settlement processing
//
//
// Written by: J. Albert
// 		Date: 10.01.02
//		Version: Newly cut & paste
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//


long ll_Return
string	ls_value
integer li_Division

n_cst_beo_AmountOwed	lnv_Amount


	IF IsValid ( an_Transaction ) THEN
		lnv_Amount = This.of_NewAmountOwed ( an_Transaction )
	ELSE
		lnv_Amount = This.of_NewAmountOwed ( )
	END IF
	
	IF IsValid ( lnv_Amount ) THEN
		lnv_Amount.of_SetType ( anv_AmountTemplate.of_GetAmountTypeId ( ) )
		
		//If there is a division specified for the template, use it.  Otherwise, allow the
		//default for the entity (if any) to hold.
		li_Division = anv_amountTemplate.of_GetDivision ( )
		IF NOT IsNull ( li_Division ) THEN
			lnv_Amount.of_SetDivision ( li_Division )
		END IF
		
		lnv_Amount.of_SetRateType ( anv_AmountTemplate.of_GetRateTypeId ( ) )
		lnv_Amount.of_SetRef1Type ( anv_AmountTemplate.of_GetRef1Typeid ( ) )
		lnv_Amount.of_SetRef2Type ( anv_AmountTemplate.of_GetRef2Typeid ( ) )
		lnv_Amount.of_SetRef3Type ( anv_AmountTemplate.of_GetRef3Typeid ( ) )
		
		IF ab_zeroamounttemplate = TRUE THEN
			lnv_Amount.of_SetDescription( "Suspended until " + string(anv_AmountTemplate.of_GetactivationDate( )))
		ELSE
			lnv_Amount.of_SetDescription ( anv_AmountTemplate.of_GetDescription ( ) )		
		END IF
		
		if anv_AmountTemplate.of_getType() = anv_AmountTemplate.ci_Type_Periodic then
			//just driver and truck
			ls_Value = inv_Itinerary.of_GetDriverList ( )
			IF len ( ls_Value ) > 0 THEN
				lnv_Amount.of_SetDriver ( ls_Value )	
			END IF
			
			ls_Value = inv_Itinerary.of_GetPowerUnitList ( )
			IF len ( ls_Value ) > 0 THEN
				lnv_Amount.of_SetTruck ( ls_Value )
			END IF
		else
			//all of it
			this.of_amountowedItineraryData ( lnv_Amount )
		end if
		
		//If there's an amount, set it.  Otherwise, set quantity and rate.
		// Also force this code path if we have a periodic template 
		// because periodic templates only allow amounts - rate & 
		// quantity are ignored - but they are not disallowed on the window.
		
		IF (ac_Amount <> 0) OR (ab_zeroamounttemplate = TRUE) THEN
		
			lnv_Amount.of_SetAmount ( ac_Amount )
		
		ELSE
		
			lnv_Amount.of_SetQuantity ( ac_Quantity )
			lnv_Amount.of_SetRate ( ac_Rate )
		
		END IF
		lnv_Amount.of_SetLastModifiedby(gnv_app.of_Getuserid())

		ac_Amount = lnv_Amount.of_GetAmount ( )
	
	ELSE
		//??Error handling??
		ll_Return = -1
	END IF
IF ll_Return <> -1 THEN	
	anv_Amountowed = lnv_Amount
END IF
Return ll_Return
end function

public subroutine of_amountoweditinerarydata (ref n_cst_beo_amountowed anv_amount);integer	li_Division

string	ls_Value, &
			ls_PublicNote

anv_Amount.of_SetStartDate ( inv_Itinerary.of_GetStartDate ( ) )
anv_Amount.of_SetEndDate ( inv_Itinerary.of_GetEndDate ( ) )
ls_Value = inv_Itinerary.of_GetOriginLocation ( )
IF len ( ls_Value ) > 0 THEN
	ls_PublicNote = ls_Value
	ls_Value = inv_Itinerary.of_GetDestinationLocation ( )
	IF len ( ls_Value ) > 0 THEN
		ls_PublicNote += " - " + ls_Value
		//nwl 3/17/03 I'm not sure if this makes sense anymore. leave it
		//commented until further notice
//		ls_Value = string ( round ( inv_itinerary.of_GetTotalMiles(), 1) )
//		IF len ( ls_Value ) > 0 THEN
//			ls_PublicNote += ", " + ls_Value
//		END IF
	ELSE
		setnull(ls_PublicNote)
	END IF
	
END IF
IF len ( ls_PublicNote ) > 0 THEN
	anv_Amount.of_SetPublicNote ( ls_PublicNote ) 
END IF

ls_Value = inv_Itinerary.of_GetDriverList ( )
IF len ( ls_Value ) > 0 THEN
	anv_Amount.of_SetDriver ( ls_Value )	
END IF

ls_Value = inv_Itinerary.of_GetPowerUnitList ( )
IF len ( ls_Value ) > 0 THEN
	anv_Amount.of_SetTruck ( ls_Value )
END IF

ls_Value = inv_Itinerary.of_GetTrailerList ( )
IF len ( ls_Value ) > 0 THEN
	anv_Amount.of_SetTrailer ( ls_Value )
END IF

ls_Value = inv_Itinerary.of_GetcontainerList ( )
IF len ( ls_Value ) > 0 THEN
	anv_Amount.of_SetContainer ( ls_Value )
END IF

ls_Value = inv_Itinerary.of_GetShipmentList (TRUE)
IF len ( ls_Value ) > 0 THEN
	anv_Amount.of_SetShipment ( ls_Value )
END IF


end subroutine

public function long of_preprocessautogen (n_cst_beo_entity anva_entities[], date ad_start, date ad_end, n_cst_bso_transactionmanager anv_transactionmanager, ref boolean ab_preprocessingperformed, ref n_ds ads_EntityInfo);///////////////////////////////////////////////////////////////////////////////
//
//  
//
//	Function:  of_PreProcessAutogen
//  
//	Access:  public
//
//	Arguments: 
//					anva_entities[] 
//					ad_start
//					ad_end
//					anv_transactionmanager (by reference  ??)
//					ab_preprocessingperformed by reference
//					as_filename by reference (used in messagebox to user)
//
//	Return:		ll_Return    
//       indirect - datastore that contains entities and problems with them
//    				boolean ab_preprocessingperformed: TRUE = preprocessing completed
//								FALSE = preprocessing not completed
//					
//						
//
//	Description:
//			for n_cst_bso_transactionmanager
//
//  	Users run this preprocess method to obtain a list
//    of entities, locations, routes, and mileage locators
//    that will cause autogen problems in this group.  
//    If any of these values are missing, 
//    autogen will not have the info
//    it needs to calculate all the amounts requested in 
//    the autogen.
//    
//    Process an array of entity ids.  Verify that the
//    entity is valid and the itinerary has all the info
//    it needs for autogen.  We will always only receive
//    entities for drivers, never for companies.
//    
//    Place results in a datastore accessible to users;
//    The users may use this info to correct the inaccurate
//    or missing info.  After the users manually correct the element(s)
//    & or entities they wish, (if any), the users will run autogen.  Users
//    may choose not to make any corrections before running autogen.
//   
// Written by: J. Albert
// 		Date: 10.21.02
//		Version: 1.0 - new code
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//	RDT 020703 The file is not created if there are no errors.
//	
//////////////////////////////////////////////////////////////////////////////
//

boolean	lb_RouteTypeDefined, &
			lb_ContinueProcess = TRUE

date		ld_nulldate, &
			lda_dates[]

integer	li_RouteType, &
			li_Result

long 	ll_Return, &
		ll_Count, &
		ll_EntityMax, &
		ll_EntityId, &
		ll_EmployeeId, &
		ll_BadLocators, &
		ll_ErrMsgCounter, &
		ll_Row, &
		ll_RowNbr, &
		ll_RowCount, &
		lla_EntityIds[], &
		ll_InvalidItinCounter
		
string	ls_DateString, &
			ls_entityId

s_parm	 lstr_Parm

n_ds	lds_EntityItinInfo

n_cst_msg	lnv_Range
n_cst_string	lnv_String
n_cst_bso_dispatch	lnv_Dispatch

n_cst_beo_entity	lnv_Entity, &
						lnva_Entities[]
						
n_cst_beo_itinerary2	lnv_itinerary						
n_cst_bcm	lnv_BCM


SetNull(ld_nulldate)


// Was a route type for settlements determined earlier?

CHOOSE CASE anv_transactionmanager.of_GetRouteTypeSettlements(li_RouteType)
	CASE 0 // 
		lb_RouteTypeDefined = FALSE
	CASE 1
		lb_RouteTypeDefined = TRUE
END CHOOSE


IF IsValid(lnv_Dispatch) THEN
	// this should fail; we don't have one yet
ELSE
	lnv_Dispatch = CREATE n_cst_bso_Dispatch
	IF IsValid(lnv_Dispatch) THEN
		// continue processing
	ELSE 
		lb_ContinueProcess = FALSE
		ab_PreprocessingPerformed = FALSE
		ll_Return = -1
	END IF
END IF

IF lb_ContinueProcess = TRUE THEN
// Have to connect from entity id to entity.fkemployee number
// This is needed to get the appropriate itinerary object
lnva_entities = anva_entities
ll_EntityMax = upperbound(lnva_Entities)
FOR ll_Count = 1 to ll_EntityMax
	lla_EntityIds[ll_Count] = lnva_Entities[ll_Count].of_getId()
NEXT

lds_EntityItinInfo = CREATE n_ds
lds_EntityItinInfo.DataObject = "d_entitylist"
lds_EntityItinInfo.SetTransObject(SQLCA)
ll_Rowcount= lds_EntityItinInfo.Retrieve(lla_EntityIds)

// Do we have entities? Are they valid? GEt the itinerary ?? > 1 ?? 
// for the driver.


 FOR ll_Count =  1 TO ll_EntityMax
	ll_ErrMsgCounter = 1	 
	ll_Entityid = lnva_Entities[ll_Count].of_getId()
	IF IsNull(ll_Entityid) OR (ll_EntityId = 0 ) THEN
		// place entity id and msg into datastore;this error msg code will be removed after debugging.
		ll_Row = ads_EntityInfo.InsertRow(0)
		IF ll_Row > 0 THEN	
			// 
			ads_EntityInfo.object.entityid[ll_Row] = ll_EntityId
			ads_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
			ads_EntityInfo.object.msg[ll_Row]  = "This entity does not contain an id."
			ll_ErrMsgCounter ++
			
		END IF  // ll_Row > 0
		CONTINUE
	ELSE
		ll_RowNbr = lds_EntityItinInfo.find(" entity_id = " + string(ll_entityid),1, ll_Rowcount)
		IF ll_RowNbr > 0 THEN  
			ll_EmployeeId= lds_EntityItinInfo.object.entity_fkemployee[ll_RowNbr]
			
			IF ( IsNull(ll_EmployeeId)) OR (ll_employeeid < 1) THEN  // should never get here
				ll_Row = ads_EntityInfo.InsertRow(0)
				IF ll_Row > 0 THEN				
					ads_EntityInfo.object.entityid[ll_Row] = ll_EntityId
					ads_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
					ads_EntityInfo.object.msg[ll_Row]  = "This entity contains incorrect " + &
					  " employee information."
					ll_ErrMsgCounter ++
					CONTINUE
				END IF // ll_Row > 0			
			END IF
			
			lnv_itinerary = lnv_Dispatch.of_GetItinerary(gc_Dispatch.ci_ItinType_Driver, &
			ll_EmployeeId, RelativeDate(ad_start, -7), ad_End)  
			IF NOT IsValid(lnv_itinerary) THEN
				// if we don't have a valid itinerary we do nothing 
				ll_Row = ads_EntityInfo.InsertRow(0)
				IF ll_Row > 0 THEN				
					ads_EntityInfo.object.entityid[ll_Row] = ll_EntityId
					ads_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
					ads_EntityInfo.object.msg[ll_Row]  = "Not able to obtain an itinerary " + &
					  " for employee, " + string(ll_EmployeeId) +  "."
					ll_ErrMsgCounter ++
					CONTINUE
				END IF // ll_Row > 0						
			ELSE
				// Not sure if we need to set up the default or not
				anv_TransactionManager.of_setDefaultentityID(ll_EntityId)
				anv_transactionManager.of_setdefaultCategory(n_cst_constants.ci_Category_Payables)
				anv_TransactionManager.of_loadopenTransactions(ll_EntityID)
				
				lnv_Itinerary.of_SetDiscardOptional(TRUE) 		
				IF lb_RouteTypeDefined THEN
					lnv_itinerary.of_SetRouteType(li_RouteType)
				END IF
			// Look into the itineraries for each entity.  Do they are have valid
			// PC Miler locators?  Do the events have sites (if needed by the event).
				li_Result = lnv_itinerary.of_InitTrip(lnv_Range) 
				IF li_Result <> 1 THEN
					li_Result = lnv_Range.of_Get_Parm("IDS", lstr_Parm)
					IF  li_Result <> 0 THEN
						ll_BadLocators = upperbound(lstr_Parm.ia_Value)
						//  Ok, put entity and msg into datastore
						ll_Row = ads_EntityInfo.InsertRow(0)
						IF ll_Row > 0 THEN					
							ads_EntityInfo.object.entityid[ll_Row] = ll_EntityId
							ads_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
							ads_EntityInfo.object.msg[ll_Row]  = "One or more companies with" + &
							" invalid PC*Miler Locators has been found.  The mileage values will" + & 
							" be zero; and any calculations based on mileages will be affected. "
							ll_ErrMsgCounter ++
						END IF // ll_Row > 0 
					END IF  //end of checking for invalid locators
					li_Result = lnv_Range.of_Get_Parm( "DATES", lstr_Parm)
					IF  li_Result <> 0 THEN
						lda_Dates = lstr_Parm.ia_value
						lnv_String.of_ArrayToString(lda_Dates,",",ls_DateString)
					// ok, put entity & msg into datastore
						ll_Row = ads_EntityInfo.InsertRow(0)	
						IF ll_Row > 0 THEN						
							ads_EntityInfo.object.entityid[ll_Row] = ll_EntityId
							ads_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
							ads_EntityInfo.object.msg[ll_Row]  = "Unspecifed sites were" + &
							" encountered on dates: " + ls_DateString + ".  The mileage values" + &
							" will be zero; and any calculations based on mileages will be" + &
							" affected."					
							ll_ErrMsgCounter ++
						END IF // ll_Row > 0
					END IF // end of checking for sites ("DATES")									 
				END IF // end of check on init trip
			
			END IF// tried to get the itinerary for this entity		
		ELSE // ll_RowNbr is not > 0
			ll_Row = ads_EntityInfo.InsertRow(0)
			IF ll_Row > 0 THEN				
				ads_EntityInfo.object.entityid[ll_Row] = ll_EntityId
				ads_EntityInfo.object.msgnbr[ll_Row] =ll_ErrMsgCounter
				ads_EntityInfo.object.msg[ll_Row]  = "This entity contains incorrect " + &
				  " information."
				ll_ErrMsgCounter ++
				CONTINUE
			END IF // ll_Row > 0
		END IF  // ll_RowNbr > 0 
	END IF  // was this entity null or have zero id; that is, was it invalid?	
	IF IsValid(lnv_itinerary) THEN
		DESTROY lnv_itinerary
	END IF
 NEXT  // 1 to ll_EntityMax
ll_Return = 1
ab_preprocessingperformed = TRUE
END IF // lb_ContinueProcess was True

IF IsValid(lds_EntityItinInfo) THEN
	DESTROY lds_EntityItinInfo
END IF
Return ll_Return

end function

public function long of_unassignedamountcount (n_cst_beo_transaction an_transaction);Integer	li_TransactionCategory, &
			li_AmountCategory
			
Long	ll_return=1 , &
		ll_count, &
		ll_TransactionEntity, &
		ll_AmountEntity
		
Date	ld_TransactionStart, &
		ld_TransactionEnd, &
		ld_AmountStart, &
		ld_AmountEnd
		
n_cst_bcm	lnv_Amounts
n_cst_beo_AmountOwed	lnv_Amount

Integer	li_rc = 0

IF NOT IsValid ( an_Transaction ) THEN
	ll_return = 0
END IF

if ll_return = 1 then
	li_TransactionCategory = an_Transaction.of_GetCategory ( )
	ll_TransactionEntity = an_Transaction.of_GetfkEntity ( )

	IF IsNull ( ll_TransactionEntity ) THEN
		ll_return = 0
	END IF
end if

if ll_return = 1 then
	this.of_loadunassignedamounts(ll_TransactionEntity)
	lnv_Amounts = This.of_GetAmountsOwed ( )
	
	IF NOT IsValid ( lnv_Amounts ) THEN
		ll_return = 0
	END IF
	
	n_cst_beo	lnva_Beos[], &
					lnv_Beo
	Long			ll_BeoCount, &
					ll_Index
	
	lnv_Beo = lnv_Amounts.GetFirst ( )
	
	DO WHILE IsValid ( lnv_Beo )
	
		ll_BeoCount ++
		lnva_Beos [ ll_BeoCount ] = lnv_Beo
	
		lnv_Beo = lnv_Amounts.GetNext ( )
	
	LOOP

	FOR ll_Index = 1 TO ll_BeoCount
	
		lnv_Amount = lnva_Beos [ ll_Index ]
	
		IF IsValid ( lnv_Amount ) THEN
	
			IF IsNull ( lnv_Amount.of_GetfkTransaction ( ) ) THEN
				//Amount is not assigned.
			ELSE
				CONTINUE
			END IF
	
			li_AmountCategory = lnv_Amount.of_GetCategory ( )
	
			IF li_AmountCategory = li_TransactionCategory THEN
				//Categories match.  Proceed.
			ELSE
				CONTINUE
			END IF
	
			ll_AmountEntity = lnv_Amount.of_GetfkEntity ( )
			
			IF ll_AmountEntity = ll_TransactionEntity THEN
				//Entities match.  Proceed.
			ELSE
				CONTINUE
			END IF
	
			ll_count ++
	
		END IF
	
	NEXT
end if

RETURN ll_Count
end function

public subroutine of_loadpaysplitcache (long ala_amountid[]);if isvalid(ids_PaysplitCache) then
	destroy ids_Paysplitcache
end if

ids_PaySplitCache = CREATE n_ds
ids_PaySplitCache.DataObject = "d_Paysplit"
ids_PaySplitCache.SetTransObject(SQLCA)

if upperbound(ala_amountid) > 0 then
	ids_PaySplitCache.Retrieve(ala_amountid)
end if

end subroutine

public function integer of_getallunassingedentities (ref long ala_unassigned[]);Integer	li_Return = 1
Long		ll_RowCount, i

n_ds	lds_UnassingedEntities

lds_UnassingedEntities = Create n_ds
lds_UnassingedEntities.DataObject = "d_allunassignedamounts" 
lds_UnassingedEntities.SetTransObject(SQLCA)

IF li_Return = 1 THEN
	IF lds_UnassingedEntities.Retrieve() = -1 THEN
		li_Return = -1
		RollBack;
	ELSE
		Commit;
	END IF
END IF

IF li_Return = 1 THEN
	ll_RowCount = lds_UnassingedEntities.RowCount()
	FOR i = 1 TO ll_RowCount
		ala_Unassigned[UpperBound(ala_Unassigned) + 1] = lds_UnassingedEntities.GetItemNumber(i, "fkentity")
	NEXT
END IF

Destroy(n_ds)

Return li_Return
end function

public function integer of_gettransaction (long ala_transactionid[], ref n_cst_beo_transaction anva_transaction[]);//@(*)[80256096|530]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

n_cst_bcm	lnv_Cache
n_cst_beo	lnva_Beo[]
Integer		li_Return = 1
Long			ll_TransCount, i

//Make sure the requested information has already been retrieved.

//(Note: Since the transaction could possibly be retrieved but not listed, we could
//try the find first, and if that doesn't work, then load the transactions.)
//Going with this way for now, though...

IF This.of_LoadTransactions ( ala_TransactionId ) = 1 THEN
	//The transaction has been successfully loaded.

ELSE
	//Could not load the transaction.
	li_Return = -1

END IF



IF This.GetCacheManager ( ).of_GetCache ( "n_cst_dlkc_transaction", lnv_Cache ) = 1 THEN
	
	ll_TransCount = UpperBound(ala_TransactionId)
	FOR i = 1 TO ll_TransCount
		
		lnva_Beo[i] = lnv_Cache.GetBeo ( "transaction_id = " + String ( ala_TransactionId[i] ) )
	
		IF NOT IsValid ( lnva_Beo[i] ) THEN
			li_Return = -1
			EXIT
		END IF
		
	NEXT

ELSE
	li_Return = -1

END IF

anva_Transaction = lnva_Beo
RETURN li_Return
end function

on n_cst_bso_transactionmanager.create
call super::create
end on

on n_cst_bso_transactionmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

n_cst_CacheManager	lnv_CacheManager
lnv_CacheManager = CREATE n_cst_CacheManager
lnv_CacheManager.of_SetAutoCache ( TRUE )
SetCacheManager ( lnv_CacheManager )

inv_Loaded = CREATE n_cst_ValueList

ids_EntityCache = CREATE DataStore
ids_EntityCache.DataObject = "d_EntityList"

Long	ll_Null
Integer	li_Null

SetNull ( ll_Null )
SetNull ( li_Null )

of_SetDefaultCategory ( li_Null )
of_SetDefaultEntityId ( ll_Null )
end event

event destructor;call super::destructor;//Extending ancestor script

DESTROY inv_Loaded
DESTROY ids_EntityCache
DESTROY ids_PaySplitCache

IF isvalid ( inv_itinerary ) THEN
	DESTROY inv_itinerary
END IF

end event

event pt_reset;call super::pt_reset;//Extending ancestor script
integer li_return

li_return = AncestorReturnValue

IF li_return = 0 THEN

	//No action taken in ancestor -- don't reset anything here

ELSE

	//Clear the list of loaded data
	inv_Loaded.of_Reset ( )

	IF IsValid ( ids_PaySplitCache ) THEN  

		IF ids_PaySplitCache.reset ( ) = 1 THEN

			li_Return = 1

		END IF

	END IF

	//Should we also clear the DefaultCategory and DefaultEntityId ???

END IF

RETURN li_return
end event

event pt_save;//override ancestor
integer	li_Return = 1 

CHOOSE CASE SUPER::Event pt_Save ( )

CASE 1  //Success
	
	n_ds	lds_PaySplitCache
	
	lds_PaySplitCache = of_GetPaySplitCache(TRUE)
	
	IF lds_PaySplitCache.Update(TRUE,TRUE) <> 1 	THEN
		rollback ;
		li_Return = -1
	END IF
	
CASE -1  //Failure
	li_Return = -1

CASE ELSE  //Unexpected result
	li_Return = -1

END CHOOSE

IF li_Return = 1 THEN
	commit ;
	if sqlca.sqlcode <> 0 then 
		rollback ;
		li_Return = -1
	end if
END IF

//Notify user on failure

IF li_Return = -1 THEN
	MessageBox ( "Save Changes", "Your changes could not be saved. " )
END IF

RETURN li_Return



end event

event pt_updatespending;call super::pt_updatespending;//Extending Ancestor Script in order to check for updates pending on custom cache objects.

Integer	li_Return

li_Return = AncestorReturnValue


//If no pending updates were identified so far, check paysplits.

IF li_Return = 0 THEN

	IF IsValid ( ids_PaySplitCache ) THEN  

		//Using of_GetPaySplitCache could instantiate it unecessarily.

		IF ids_PaySplitCache.of_UpdatesPending ( ) = 1 THEN

			li_Return = 1

		END IF

	END IF

END IF

RETURN li_Return
end event

