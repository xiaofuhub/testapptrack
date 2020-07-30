$PBExportHeader$n_cst_bso_edimanager_990.sru
forward
global type n_cst_bso_edimanager_990 from n_cst_bso_edi_manager
end type
end forward

global type n_cst_bso_edimanager_990 from n_cst_bso_edi_manager
end type
global n_cst_bso_edimanager_990 n_cst_bso_edimanager_990

forward prototypes
public function integer of_sendtransaction ()
public function integer of_sendtransactionsforcompany (long al_coid)
public function integer of_sendpending ()
public function integer of_setmessagestatus (long ll_shipid, integer li_status)
end prototypes

public function integer of_sendtransaction ();return 1
end function

public function integer of_sendtransactionsforcompany (long al_coid);//do what the window did, accept get all the ids of shipments that i want
//to send. DOESN"T ACTUALLY SEND FOR A SINGLE COMPANY YET!!! but it will.


//Creates a shipmentReview and retrieves ALL of the pending 990s to be sent.
//Creates a 990 transaction and sends it.


//IF this returns anything other than 1 then an error gets put in the tasklog saying
//it failed to generate an edi 990.  
n_cst_edishipmentreview lnv_review
int			li_Return = 1
Long			ll_index
Long			ll_max
Long			lla_ids[]
Long			lla_idsToSendFromPending[]
n_ds			lds_cache
datastore	lds_pendingCache

n_cst_edi_transaction_990	lnv_EDI
	
n_cst_setting_edi204version	lnv_204Version

lnv_review = CREATE n_cst_edishipmentreview		//used d_edishipmentreview

//find out the ids from the pending cache table.
lds_pendingCache = This.of_getCache()

IF isValid( lds_pendingCache ) THEN
	ll_max = lds_pendingCache.rowcount( )
	FOR ll_index = 1 TO ll_max
		//this will make sure we only retrieve the ones that have a pending status.  The ones that
		//are retrieved will be sent or resent in the 990 transaction object.  Once they are resent or sent,
		//there status is set to 1.
		IF lds_pendingCache.getItemNumber( ll_index, "messagestatus" ) = appeon_constant.ci_messagestatus_pending THEN
			lla_ids[upperBound(lla_ids) + 1] = lds_pendingCache.getItemNumber( ll_index , "shipid" )
		END IF
	NEXT
	
	//if there are no pending processes nothing will heappen.
	IF upperBound(lla_ids) = 0 THEN
		li_return = 0
	END IF
ELSE
	li_return = -1
END IF

IF li_return = 1  THEN
	lnv_review.of_retrieveids( lla_ids )

	//what should be done here
	//filter the cache down to the specific company, call of_sendTransactionForCompany on the transaction
	//It doesn't do this right now because the old way of sending 990s does the filtering
	//of companies in of_sendTransaction.  Eventually this will be redone the right way.

	//this is the cache we just retrieved.
	lds_cache = lnv_review.of_getCache()
	
	IF not IsValid(lds_cache) THEN
		li_return = -1
	END IF
		
END IF

IF li_return = 1 THEN
	lnv_204Version = CREATE n_cst_setting_edi204version
	
	IF lnv_204Version.of_GetValue ( ) = lnv_204Version.cs_ediversion_direct THEN
	
		lnv_EDI = create n_cst_edi_transaction_990
	
		//when this is redone, this call will be obsolete.  The call that should
		//be made is lnv_edi.of_sendTransactionForCompany( al_coid ), that function
		//should resolve out the ids for of pending items for each company and call
		//lnv_edi.of_sendTransaction( ll_ids ) where ll_ids will contain the shipments
		//ids for the specific company. That function will generate the 990 and send it.
		
		//With all the above being said, this could probably be implemented on the ancestor
		//bso.  All we'd have to do is implement a function to get the appropriate transaction.
		//The 990 would behave exactly like the 322
		lnv_edi.of_setmanager( this )
		lnv_EDI.of_SendTransaction(lds_cache, lla_ids )
		
		destroy lnv_EDI
		
	END IF
	destroy lnv_204Version
END IF

IF isValid( lnv_review ) THEN	
	DESTROY lnv_review
END IF
	
RETURN li_return
end function

public function integer of_sendpending ();//once this is done right, it will probably only be implemented on the 
//ancestor.  It will probably look something like the n_cst_bso_ediManager_322's code.

Long	ll_coid
Int	li_return

//right now ll_coid is useless and this will send it for all the companies.
//once edi is done right, it ll_coid will have meaning, and it will probably
//be generated from a list of companies that have edi set up.  
li_return = this.of_sendtransactionsforcompany( ll_coid )

this.of_savecache( )
RETURN li_return
end function

public function integer of_setmessagestatus (long ll_shipid, integer li_status);//this is called by sendTransaction in n_cst_editransaction_990
//maybe this can go on the ancestor when we do it right.
Datastore	lds_pendingCache
Long			ll_max
Long			ll_index
String		ls_find

lds_pendingCache = This.of_getCache()

IF isValid( lds_pendingCache ) THEN
	ll_max = lds_pendingCache.rowcount( )
	ls_find = " shipid = " + string( ll_shipId )
	ll_index = lds_pendingCache.find( ls_find, 1, ll_max )
	
	IF ll_index > 0 THEN
		lds_pendingCache.setItem( ll_index, "messagestatus", li_status )
	END IF
	
END IF


RETURN 1
end function

on n_cst_bso_edimanager_990.create
call super::create
end on

on n_cst_bso_edimanager_990.destroy
call super::destroy
end on

event constructor;call super::constructor;is_cachedo = "d_990status"
is_transactioncompanydo = "d_990companies"
end event

