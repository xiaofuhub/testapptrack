$PBExportHeader$n_cst_bso_edimanager_204.sru
forward
global type n_cst_bso_edimanager_204 from n_cst_bso_edi_manager
end type
end forward

global type n_cst_bso_edimanager_204 from n_cst_bso_edi_manager
end type
global n_cst_bso_edimanager_204 n_cst_bso_edimanager_204

type variables
n_cst_ediexportshipmentmanager inv_manager
end variables

forward prototypes
public function integer of_sendpending ()
public function integer of_sendtransactionsforcompany (long al_coid)
end prototypes

public function integer of_sendpending ();/*
	This moves requests for 204 generations into the pending table first.
	
	Created on 3-6-07.  THis function rounds up all the companies with outbound 204
	capability and attempts to send any 204s for those companies.
*/
n_ds lds_204Out
Int	ll_index
Int	ll_max
Long	ll_coid


n_cst_ediexportshipmentmanager lnv_exportmanager

lnv_exportmanager = create n_cst_ediexportshipmentmanager

lnv_exportmanager.of_addrequeststoexportedshipmentstable( )

lds_204Out = create n_ds
lds_204Out.dataobject = "d_ediProfile_ds"
lds_204Out.setTransobject( SQLCA )
lds_204Out.retrieve()

commit;

lds_204Out.setFilter( "transactionset = 204 AND in_out = '"+ appeon_constant.cs_transaction_OUTBOUND +"'" )
lds_204Out.filter()

ll_max = lds_204Out.rowcount( )
FOR ll_index = 1 TO ll_max
	ll_coid = lds_204Out.getItemnumber( ll_index, "companyid")
	
	this.of_sendtransactionsforcompany( ll_coid )
NEXT


IF THIS.of_hadupdatespending( ) THEN
	THIS.of_savecache( )
END IF

DESTROY lnv_exportManager
DESTROY lds_204Out
RETURN 1

end function

public function integer of_sendtransactionsforcompany (long al_coid);/*
	Created on 3-5-07 by dan
*/
Int	li_Return 

n_cst_edi_transaction_204		lnv_transaction
lnv_Transaction = CREATE n_cst_edi_transaction_204

lnv_transaction.of_SetCache ( THIS.of_GetCache( ) )


li_Return = lnv_transaction.of_Sendforcompany( al_coid ) 

Destroy ( lnv_transaction ) 
RETURN li_Return
end function

on n_cst_bso_edimanager_204.create
call super::create
end on

on n_cst_bso_edimanager_204.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_manager = create n_cst_ediexportshipmentmanager
is_cachedo = "d_edi_exportedshipments"
end event

event destructor;call super::destructor;DESTROY inv_manager
end event

