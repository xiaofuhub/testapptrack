$PBExportHeader$n_cst_uilink_dw.sru
forward
global type n_cst_uilink_dw from ofr_n_cst_uilink_dw
end type
end forward

global type n_cst_uilink_dw from ofr_n_cst_uilink_dw
end type
global n_cst_uilink_dw n_cst_uilink_dw

forward prototypes
public function long getallbeo (ref n_cst_beo aa_beo[])
public function long getallbeo (ref n_cst_beo aan_beo[], string as_columnname, string as_value)
public function integer deleterow (long al_row)
end prototypes

public function long getallbeo (ref n_cst_beo aa_beo[]);Long ll_dwRowCount
Long ll_dsRowCount
Long ll_ReturnValue = -1
int i

n_cst_beo lnv_beo[] 
lnv_beo	= aa_beo

If IsValid ( idw_requestor ) THEN
	ll_dwRowCount = idw_requestor.rowCount()
	ll_ReturnValue = ll_dwRowCount
	FOR i = 1 To ll_dwRowCount
		lnv_beo[i] = getBeo(i)
	NEXT
ELSEIF isValid ( ids_requestor ) THEN
	ll_dsRowCount = ids_requestor.rowCount()
	ll_returnValue = ll_dsRowCount
	FOR i = 1 TO ll_dsRowCount
		lnv_beo[i] = getbeo(i)
	NEXT
END IF
aa_beo = lnv_beo

RETURN ll_ReturnValue
end function

public function long getallbeo (ref n_cst_beo aan_beo[], string as_columnname, string as_value);

Long ll_dwRowCount
Long ll_dsRowCount
Long ll_ReturnValue = -1
Long i
string	ls_FindExpression

n_cst_beo lnv_beo[] 
lnv_beo	= aan_beo

ls_FindExpression = as_columnname+ " = " + as_value
i = 0 


long ll_find = 1  

If IsValid ( idw_requestor ) THEN
	
	i = 1
		
	ll_dwRowCount = idw_requestor.rowCount ( )
	ll_find = idw_requestor.Find ( ls_FindExpression , ll_find, ll_dwRowCount )
	
	DO WHILE ll_find > 0
		 // Collect found row
		lnv_beo[i] = getBeo( ll_find )
	
		ll_find++
		i++
		// Prevent endless loop
		IF ll_find > ll_dwRowCount THEN EXIT
		ll_find = idw_requestor.Find(ls_FindExpression , ll_find, ll_dwRowCount )
	
	LOOP
	
	
ELSEIF isValid ( ids_requestor ) THEN
	
	i = 1
	
	ll_dsRowCount = ids_requestor.rowCount ( )
	ll_find = ids_requestor.Find ( ls_FindExpression , ll_find, ll_dsRowCount )
	
	DO WHILE ll_find > 0
		 // Collect found row
		lnv_beo[i] = getBeo( ll_find )
	
		ll_find++
		i++
		// Prevent endless loop
		IF ll_find > ll_dsRowCount THEN EXIT
		ll_find = ids_requestor.Find(ls_FindExpression , ll_find, ll_dsRowCount )
	
	LOOP
	
END IF

	
ll_ReturnValue = i	

RETURN ll_ReturnValue
//wcontrol.Find ( expression, start, end )

end function

public function integer deleterow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DeleteRow  (OVERRIDING ANCESTOR FOR BUG FIX)
// BUG FIX:       NEEDS TO CALL ClearOFRErrors
//
//	Arguments:		al_row	Row in requestor to delete
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Deletes the specified row in the requestor and its
//						associated business object
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	BTR 6968 - add call to OFRDeleteRow
// 1.2	GK - Removed dynamic calls to help PB6
// 1.3   Handle delete errors.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo lnv_beo
int li_rc = -1
n_cst_ofrerror lnv_ofrerror[]

This.ClearOFRErrors ( )  //Bug Fix by Profit Tools -- This is the only change

if not isvalid(inv_bcm) then return -1

if al_row = 0 then
	if IsValid(idw_requestor) then
		al_row = idw_requestor.GetRow()
	else
		al_row = ids_requestor.GetRow()
	end if
end if

if this.GetThinClient() then
	li_rc = inv_bcm.deletebeo(this.GetBEOIndex(al_row))
else
	lnv_beo = this.getbeo ( al_row ) 	// get a reference to the BEO instance for the row.
	
	if IsValid ( lnv_beo ) then
		li_rc = lnv_beo.deletebeo ( )		// call the Delete ( ) method of the BEO instance.
	end if
end if

if li_rc > 0 then
	if NOT ib_Shared then			// must delete the row in the non-shared
		ipo_requestor.Dynamic OFRDeleteRow ( al_row )
	end if
else
	// 1.3 Change - Process and display errors.
	this.PropagateErrors(lnv_beo)
	this.GetOFRErrors(lnv_ofrerror)
	this.ProcessOFRError(lnv_ofrerror)
end if

return li_rc

end function

on n_cst_uilink_dw.create
TriggerEvent( this, "constructor" )
end on

on n_cst_uilink_dw.destroy
TriggerEvent( this, "destructor" )
end on

