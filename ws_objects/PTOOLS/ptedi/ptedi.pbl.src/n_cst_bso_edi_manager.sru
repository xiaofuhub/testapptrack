$PBExportHeader$n_cst_bso_edi_manager.sru
forward
global type n_cst_bso_edi_manager from n_cst_bso
end type
end forward

global type n_cst_bso_edi_manager from n_cst_bso
end type
global n_cst_bso_edi_manager n_cst_bso_edi_manager

type variables
PROTECTED:
	n_ds 		ids_cache
	string	is_cacheDO
	string	is_transactionCompanyDO
	
	
PUBLIC:
	
Constant Int	ci_MessageStatus_Pending = 0
Constant Int	ci_MessageStatus_Processed = 1
Constant Int	ci_MessageStatus_Canceled = -2
end variables

forward prototypes
public function integer of_createmsg (readonly n_cst_beo_event anv_event, string as_status)
public function integer of_sendpending ()
public function integer of_sendtransactionsforcompany (long al_coid)
public function integer of_savecache ()
public function boolean of_hadupdatespending ()
public function datastore of_getcache ()
private function n_cst_edi_transaction of_gettransaction ()
end prototypes

public function integer of_createmsg (readonly n_cst_beo_event anv_event, string as_status);//
Int	li_return

/*appropriate code here???*/
RETURN li_Return
end function

public function integer of_sendpending ();return 1
end function

public function integer of_sendtransactionsforcompany (long al_coid);
n_cst_edi_transaction_322		lnv_transaction
lnv_Transaction = CREATE n_cst_edi_transaction_322

lnv_transaction.of_SetCache ( THIS.of_GetCache( ) )

Int	li_Return 
li_Return = lnv_transaction.of_Sendforcompany( al_coid ) 

Destroy ( lnv_transaction ) 
RETURN li_Return

end function

public function integer of_savecache ();Int	li_Return
IF ids_cache.Update() = 1 THEN
	COmmit;
	li_Return = 1
ELSE
	RollBack;
	li_return = -1
END IF

IF li_Return = 1 THEN
	DESTROY ( ids_cache ) 
END IF

RETURN li_Return
end function

public function boolean of_hadupdatespending ();Boolean	lb_Return
IF isvalid ( ids_cache ) THEN
	lb_Return = ids_cache.Modifiedcount( ) > 0 
END IF

RETURN lb_Return
end function

public function datastore of_getcache ();IF Not IsValid ( ids_cache ) THEN
	ids_cache = CREATE dataStore
	ids_cache.DataObject = is_cacheDO			//set by descendents
	ids_cache.SetTransObject ( SQLCA ) 
	
	ids_cache.Retrieve ( )
	
	Commit;
END IF

RETURN ids_cache
end function

private function n_cst_edi_transaction of_gettransaction ();//intended to be implemented on descendents
n_cst_edi_transaction lnv_dummy

RETURN lnv_dummy
end function

on n_cst_bso_edi_manager.create
call super::create
end on

on n_cst_bso_edi_manager.destroy
call super::destroy
end on

event destructor;call super::destructor;IF isValid( ids_cache ) THEN
	DESTROY ids_cache
END IF
end event

