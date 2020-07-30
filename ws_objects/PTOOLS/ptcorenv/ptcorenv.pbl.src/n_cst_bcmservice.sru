$PBExportHeader$n_cst_bcmservice.sru
forward
global type n_cst_bcmservice from n_cst_bso
end type
end forward

global type n_cst_bcmservice from n_cst_bso autoinstantiate
end type

forward prototypes
public function long of_getallbeo (readonly n_cst_bcm anv_bcm, readonly string as_Expression, ref n_cst_beo anva_BEOs[])
end prototypes

public function long of_getallbeo (readonly n_cst_bcm anv_bcm, readonly string as_Expression, ref n_cst_beo anva_BEOs[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetallBEO
//
//	Arguments:		as_expression	Search expression to find BEO with
//						anva_beos[] 	list of found BEOs
//
//	Returns:			Long
//					 # > -1			   Success (upperBound of anva_beos[])
//						  -1				Faliure		
//						
//
//	Description:	populates BEO array matching the search expression.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_beo lnva_beos[]

long ll_beo_index
long ll_row

long ll_currentRow
long ll_NumberRows
Long ll_Count

n_bcm_ds	lds_View

IF IsValid ( anv_bcm ) THEN
	lds_View = anv_bcm.getView ( ) 
END IF

if not IsValid(lds_view) then
	return -1
end if
 
ll_NumberRows = lds_view.RowCount ( )
ll_currentRow = 1

DO
	// get beo_index from ids_view then attempt to find it
	ll_row = lds_view.Find ( as_expression, ll_CurrentRow , ll_numberRows )
	
	IF ll_row > 0 THEN
		ll_Count ++
		ll_beo_index = lds_view.GetBeoIndex( ll_row )
		lnva_beos[ ll_Count ] = anv_bcm.GetAt( ll_beo_index )
		ll_CurrentRow = ll_Row + 1
	ELSE
		EXIT
	END IF
	
LOOP UNTIL ll_CurrentRow > ll_numberRows

anva_beos[] = lnva_beos

return ll_Count
end function

on n_cst_bcmservice.create
TriggerEvent( this, "constructor" )
end on

on n_cst_bcmservice.destroy
TriggerEvent( this, "destructor" )
end on

