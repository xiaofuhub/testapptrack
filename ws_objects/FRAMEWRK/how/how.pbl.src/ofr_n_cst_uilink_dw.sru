$PBExportHeader$ofr_n_cst_uilink_dw.sru
$PBExportComments$UI Link object - handles communication between presentation and BCM.
forward
global type ofr_n_cst_uilink_dw from n_cst_uilink
end type
end forward

global type ofr_n_cst_uilink_dw from n_cst_uilink
end type
global ofr_n_cst_uilink_dw ofr_n_cst_uilink_dw

type variables
protected:

any ia_arginit[16]
boolean ib_colregistered[]
string is_regcolname[]
string is_regcoldatatype[]
int ii_reqcols
// Append result set
boolean ib_append = false
boolean ib_appendset = false
// Requestor pointers
datawindow idw_requestor
datastore ids_requestor
// BCM
boolean ib_bcmcreated

//this can be deleted after 2.0 stabilizes
string is_bcm_classname = "n_cst_bcm"
///
boolean ib_shared
constant string isc_beo_index = "beo_index"
int ii_beo_index_col
transaction itrx_tran

// This determines if this service should destroy the BCM
Boolean ib_is_primary = TRUE

end variables

forward prototypes
public function n_cst_beo getbeo (long al_row)
public function integer save (readonly boolean ab_accepttext)
public function integer save ()
public function integer filldddw (readonly string as_dddw_column)
public function integer filldddw (readonly string as_dddw_column, readonly n_cst_bcm anv_bcm)
public function integer settransobject (readonly transaction atrx_tran)
public function integer setshared (readonly boolean ab_shared)
public function integer resetupdate ()
public function integer setbcm (readonly n_cst_bcm anv_bcm)
public function integer setbcmclass (readonly string as_bcm_classname)
public function long new (long al_row, readonly n_cst_beo anv_assoc_beo, readonly string as_relationship)
public function integer settext (long al_row, string as_column, string as_value)
public function integer refreshfrombcm ()
public function n_cst_beo getbeo (long al_row, readonly string as_classname)
public function integer sharedata (powerobject apo_otherobject)
public function integer setsharedbcm (n_cst_bcm anv_bcm)
public subroutine setprimary (boolean ab_flag)
public function integer validate ()
public function integer updaterequestor (readonly long al_row)
public function integer getattribute (readonly string as_table, readonly string as_column, ref string as_class, ref string as_attribute)
protected function integer mapcolumns ()
public function long retrieve ()
public function long retrieve (readonly any aa_arg1)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15, readonly any aa_arg16)
public function integer deleterow (long al_row)
public function integer save (readonly boolean ab_accepttext, readonly boolean ab_resetupdateflag)
protected function integer set (long al_row, string as_column, any aa_value, boolean ab_itemchanged)
protected function n_cst_bcm createbcm ()
protected function long rowcount ()
public function integer set (readonly long al_row, readonly string as_column, readonly any aa_value)
public function long insertrow (long al_row)
public function integer registercolumn (readonly string as_requestor_colname, readonly string as_resultset_colname)
public function boolean getprimary ()
protected function integer sharebcm ()
protected function integer addbeoindex (ref string as_syntax)
protected function integer setnull (long al_row, integer ai_col)
protected function integer destroybcm ()
protected function integer checkbeoindex ()
public function integer setrequestor (readonly powerobject apo_requestor)
public function integer seterrorfocus (readonly n_cst_ofrerror anv_ofrerror)
public function string getqueryname ()
public function integer setbcm ()
public function integer reset ()
public function n_cst_bcm getbcm (readonly boolean ab_createbcm)
public function n_cst_bcm getbcm ()
public function boolean isbcmcreated ()
public function boolean isrequestorvalid ()
public function integer setappend (boolean ab_flag)
protected function long copybcm (readonly boolean ab_allrows)
public function long getbeoindex (long al_row, dwbuffer adw_buffer)
public function long getbeoindex (long al_row)
protected function boolean getthinclient ()
public function long getbeorow (long al_beoindex)
end prototypes

public function n_cst_beo getbeo (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEO
//
//	Arguments:		al_row	Requestor row to get BEO for
//
//	Returns:			Business object (n_cst_beo) for specified row.  Returns
//						null if an error occurs.
//
//	Description:	Returns a business object for the specified requestor
//						row.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.GetBEO(al_row, '')

end function

public function integer save (readonly boolean ab_accepttext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Save
//
//	Arguments:		ab_accepttext			AcceptText indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Saves changes that have been made to the BCM.
//						Optionally an AcceptText will be performed before
//						the update.  A ResetUpdate will be
//						performed after the udpate.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.Save ( ab_accepttext, TRUE )

	
end function

public function integer save ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Save
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Saves changes that have been made to the BCM.
//						An AcceptText will be performed before
//						the update and a ResetUpdate will be
//						performed after the udpate.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.Save ( TRUE, TRUE )

	
end function

public function integer filldddw (readonly string as_dddw_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		FillDDDW
//
//	Arguments:		as_dddw_column		DDDW column name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Fills the specified drop down DataWindow for the
//						specified column using data from the temporary
//						created BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int li_rc
String ls_dataobject
n_cst_bcm lnv_bcm

if IsValid(idw_requestor) then
	lnv_bcm = this.GetBCMMGR().CreateBCM('n_cst_beo')
	ls_dataobject = idw_requestor.Describe(as_dddw_column + '.dddw.name')
	lnv_bcm.SetQuery(ls_dataobject)
	lnv_bcm.Retrieve()
	li_rc = this.FillDDDW(as_dddw_column, lnv_bcm)
	this.GetBCMMGR().DestroyBCM(lnv_bcm)
else
	li_rc = -1
end if

return li_rc

end function

public function integer filldddw (readonly string as_dddw_column, readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		FillDDDW
//
//	Arguments:		as_dddw_column		DDDW column name
//						anv_bcm				BCM to use to fill DDDW with
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Fills the specified drop down DataWindow for the
//						specified column using data from the specified BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
DataWindowChild ldwc_dddw
Int li_rc
Long ll_rows
String ls_data

if IsValid(idw_requestor) then
	li_rc = idw_requestor.GetChild(as_dddw_column, ldwc_dddw)
	if li_rc = -1 then
		this.SetException("filldddw", "27999", {as_dddw_column})
	else
		li_rc = anv_bcm.GetData ( ls_data )
		if li_rc > 0 then
			ldwc_dddw.Reset ( )
			ldwc_dddw.ImportString (ls_data)
			ll_rows = ldwc_dddw.RowCount()
			li_rc = 1
		end if
	end if
else
	li_rc = -1
end if

return li_rc

end function

public function integer settransobject (readonly transaction atrx_tran);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetTransObject
//
//	Arguments:		atrx_tran	Transacation object to use with BCM
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Assigns the transaction object to be used by the BCM.
//						By default SQLCA is used.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

//		Keep pointer to desired transaction object
//		Not actually set until CreateBCM unless BCM already exists
itrx_tran = atrx_tran

if IsValid(inv_bcm) then
	if inv_bcm.SetTransObject(atrx_tran) <> 1 then
		li_rc = -1
	end if
end if

return li_rc

end function

public function integer setshared (readonly boolean ab_shared);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetShared
//
//	Arguments:		ab_shared	Sharing indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets the indicator as to whether the BCM Datastore
//						is shared with the requestor DataWindow/Datastore.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ib_shared = ab_shared

return 1

end function

public function integer resetupdate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ResetUpdate
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Resets the update flags of the BCM and the requestor.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int li_rc = -1

if IsValid(inv_bcm) then
	if inv_bcm.ResetUpdate() = 1 then
		// GK - Logic is same for DW and DS, but objects are different.  Don't use dynamic because
		// of potential problems in PB6.
		if IsValid(idw_requestor) then
			li_rc = idw_requestor.ResetUpdate()
			//		Start major PB hack
			//		Work around PB bug that shared DW's deleted counts are not
			//		reset when there primary DS's are updated.
			if ib_shared then
				if idw_requestor.DeletedCount() > 0 then
					idw_requestor.ShareDataOff()
					this.ShareBCM()
				end if
			end if
			//		End PB hack
		else
			li_rc = ids_requestor.ResetUpdate()
			//		Start major PB hack
			//		Work around PB bug that shared DW's deleted counts are not
			//		reset when there primary DS's are updated.
			if ib_shared then
				if ids_requestor.DeletedCount() > 0 then
					ids_requestor.ShareDataOff()
					this.ShareBCM()
				end if
			end if
			//		End PB hack
		end if
	end if
else
	//		No BCM then no flags to reset - return OK
	li_rc = 1
end if

return li_rc

end function

public function integer setbcm (readonly n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCM
//
//	Arguments:		anv_bcm	BCM to associate
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Associates an existing BCM with a requestor
//						DataWindow/Datastore object and populates the
//						requestor using the BCM data.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.01   GK - Don't destroy the BCM if the same BCM was passed in.
//	1.0.2	Add logic to get BCM classes
// 2.1 	Added Thin Client support.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc

If NOT IsValid(anv_bcm) then		
	li_rc = -1				// invalid BCM passed in
else
	// to avoid orphaning an existing BCM you must Destroy it first, if it exists
	if IsValid(inv_bcm) then
		// Don't destroy the BCM if it is the same one that was passed in.
		if (inv_bcm <> anv_bcm) then
			if this.DestroyBCM (  ) = -1 then
				return -1
			end if
		end if
	end if
	inv_bcm = anv_bcm
		
	if this.MapColumns() = 1 then
		//		Grab BCM classes
		inv_bcm.GetBEOClass(is_class)
		this.SetPrimary(FALSE)
		if ib_shared then 
			this.Sharebcm ( )
			li_rc = 1
		else
			if this.CheckBEOIndex() >= 0 then
				this.Copybcm(true)
				li_rc = 1
			else
				this.PushException("setbcm()")
				li_rc = -1
			end if
		end if
	else
		this.PushException("setbcm")
		li_rc = -1
	end if
end if

return li_rc

end function

public function integer setbcmclass (readonly string as_bcm_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCMClass
//
//	Arguments:		as_bcm_classname	Class name used for associated BCM
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Use this function to override the default class name
//						used for the associated BCM (default is n_cst_bcm).
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
is_bcm_classname = as_bcm_classname

return 1

end function

public function long new (long al_row, readonly n_cst_beo anv_assoc_beo, readonly string as_relationship);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		new
//
//	Arguments:		al_row			Location to create new row at
//						anv_assoc_beo	Related BEO to this BEO being created
//						as_relationship	Related BEO relationship name
//
//	Returns:			Long 		returns position of new row or -1 if an
//									error occurs
//
//	Description:	Creates a new row in the requestor and a new
//						corresponding business object.  Also relates
//						related BEO to the newly created BEO.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	Set status not modified on requestor new rows
// 1.2 	Removed dynamic calls where not needed.
// 1.3   Removed Exception
// 2.1 	Added Thin Client support.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_query
n_cst_beo lnv_beo
int li_rc = 1, li_end, li_idx
long ll_row, ll_bcmrow
n_cst_ofrerror lnv_ofrerror[]

ll_row = al_row
this.ClearOFRErrors()

//		WORKAROUND FOR BUG IN PB
//		If a DW is shared from a DS and an insert is done on the DS then
//		and changes currently in the edit buffer are lost.
//		Do an AcceptText() will work around this problem.
if ( IsValid(idw_requestor) ) and ( ib_Shared = TRUE ) then
	li_rc = idw_requestor.AcceptText()
end if

if li_rc = 1 then
	if not IsValid(inv_bcm) then
 		this.createbcm()
		if not IsValid(inv_bcm) then
			this.PushException("new()")
			return -1
		end if
	end if
	
	if this.GetThinClient() then
		ll_row = inv_bcm.newbeo()		
	elseif IsValid(anv_assoc_beo) then
		ll_row = inv_bcm.newbeo(lnv_beo, anv_assoc_beo, as_relationship)
	else
		ll_row = inv_bcm.newbeo(lnv_beo)
	end if
	
	ll_bcmrow = ll_row
	
	// if return value is greater than 0 then it succeeded.
	if ll_row > 0 then
		this.MapColumns()
		if ib_Shared then
			//		Move new row to desired location
			if al_row > 0 then
				if IsValid(idw_requestor) then
					idw_requestor.RowsMove(ll_row, ll_row, Primary!, idw_requestor, al_row, Primary!)
				else
					ids_requestor.RowsMove(ll_row, ll_row, Primary!, ids_requestor, al_row, Primary!)
				end if
				ll_row = al_row
			end if
		else
			// if copied ( not shared ) then make sure a row gets inserted in the presentation dw/ds.
			if IsValid(idw_requestor) then
				ll_row = idw_requestor.dynamic OFRInsertRow(al_row)
				if not this.GetBCMMGR().IsPBRowIDOn() then
					idw_requestor.object.data[ll_row, ii_beo_index_col] = inv_bcm.GetBEOIndex(ll_bcmrow)
				end if
			else
				ll_row = ids_requestor.dynamic OFRInsertRow(al_row)
				if not this.GetBCMMGR().IsPBRowIDOn() then
					ids_requestor.object.data[ll_row, ii_beo_index_col] = inv_bcm.GetBEOIndex(ll_bcmrow)
				end if
			end if
			li_rc = this.UpdateRequestor(ll_row)
		end if
		//		Reset requestor status flags to prevent change message
		if IsValid(idw_requestor) then
			idw_requestor.SetItemStatus(ll_row, 0, Primary!, NotModified!)
		else
			ids_requestor.SetItemStatus(ll_row, 0, Primary!, NotModified!)
		end if
	else
		this.PropagateErrors(inv_bcm)
		this.GetOFRErrors(lnv_ofrerror)
		this.ProcessOFRError(lnv_ofrerror)
		this.PushException("new()")
		li_rc = -1			// unable to create new BEO instance.
	end if
end if

// li_retval not equal to one indicates an error.
if li_rc <> 1 then
	ll_row = -1
end if


return ll_row

end function

public function integer settext (long al_row, string as_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetText
//
//	Arguments:		al_row		Row in requestor being changed
//						as_column	Name of column in requestor being changed
//						as_value		New value as text
//
//	Returns:			Integer
//						1		Successfully updated attribute
//						2		Successfully updated attribute and other
//								attributes have been updated as a result
//						0		unregistered column
//						-1		error setting attribute
//
//	Description:	Called from ofr_u_dw ItemChanged.  Convert text
//						value to proper type and call set method.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	BTR 6170 - add date casting when only date value is passed to
//			a datetime column
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_coltype, ls_date, ls_time
int li_pos
int li_rc = -1

ls_coltype = idw_requestor.Describe(as_column + ".coltype")
choose case Left(ls_coltype, 5)
	case "char("
		li_rc = this.Set(al_row, as_column, as_value, TRUE)
	case "datet"
		//		If space then assume time specified
		li_pos = Pos(as_value, " ")
		if li_pos > 0 then
			ls_time = Mid(as_value, li_pos)
			ls_date = Left(as_value, li_pos)
			li_rc = this.Set(al_row, as_column, DateTime(Date(ls_date), Time(ls_time)), TRUE)
		else

			//		No time specified
			li_rc = this.Set(al_row, as_column, DateTime(Date(as_value)), TRUE)
		end if
	case "date"
		li_rc = this.Set(al_row, as_column, Date(as_value), TRUE)
	case "time"
		li_rc = this.Set(al_row, as_column, Time(as_value), TRUE)
	case else
		li_rc = this.Set(al_row, as_column, Double(as_value), TRUE)
end choose

if li_rc = -1 then
	this.PushException("settext")
end if

return li_rc

end function

public function integer refreshfrombcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RefreshFromBCM
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Refreshes the requestor from the bcm
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if not ib_shared then 
	this.Copybcm(true)
end if

return 1

end function

public function n_cst_beo getbeo (long al_row, readonly string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEO
//
//	Arguments:		al_row			Requestor row to get BEO for
//						as_classname	Classname
//
//	Returns:			Business object (n_cst_beo) for specified row.  Returns
//						null if an error occurs.
//
//	Description:	Returns a business object for the specified class and
//						specified requestor row.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////

//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo lnv_beo
long ll_beo_index, ll_keyval

if al_row > 0 then
	ll_beo_index = this.GetBEOIndex ( al_row )
	if ll_beo_index > 0 then
		if as_classname <> '' then
			lnv_beo = inv_bcm.GetAt(ll_beo_index, as_classname)
		else
			lnv_beo = inv_bcm.GetAt(ll_beo_index)
		end if
		if not IsValid(lnv_beo) then
			this.PushException("getbeo()")
		end if
	end if
end if

return lnv_beo

end function

public function integer sharedata (powerobject apo_otherobject);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ShareData
//
//	Arguments:		apo_otherobject	Reference to either a DataWindow or DataStore
//												with which we will share the data in our
//												requestor object.
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Allows multiple presentation objects to share the same BCM.  
//						Equilivent to PowerBuilder's ShareData() function, but with
//						additional functionality specific to the OFR.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.01   Initial version
// 1.2		GK - Removed dynamic calls for PB6.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

datawindow dw
datastore ds
ofr_n_cst_uilink_dw lnv_uilink

// Check for BEO Service on the other object
if apo_otherobject.TriggerEvent("ofr_getuilink") = 1 then
	lnv_uilink = apo_otherobject.Dynamic Event ofr_getuilink()
end if

if isValid(lnv_uilink) = FALSE or IsNull(lnv_uilink) then 
	// Other object must have BEO Service turned on.
	return -1
end if	

// Use PowerBuilder's ShareData() to share between our requestor (the primary)

// and the other requestor (the secondary).
if TypeOf ( apo_otherobject ) = DataWindow! then
	dw = apo_otherobject
	if TypeOf(ipo_requestor) = DataWindow! then
		if idw_requestor.Function Dynamic ShareData(dw) < 1 then
			return -1
		end if
	else
		if ids_requestor.Function Dynamic ShareData(dw) < 1 then
			return -1
		end if
	end if
else
	ds = apo_otherobject
	if TypeOf(ipo_requestor) = DataWindow! then
		if idw_requestor.Function Dynamic ShareData(ds) < 1 then
			return -1
		end if
	else
		if ids_requestor.Function Dynamic ShareData(ds) < 1 then
			return -1
		end if
	end if
end if

// Use this function to cause the other BEO Service to point to the same BCM
// we are using.

lnv_uilink.SetSharedbcm(this.GetBCM(true))  //getbcm will also create a bcm

return 1
end function

public function integer setsharedbcm (n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSharedBCM
//
//	Arguments:		anv_bcm				Reference to a BCM which has already been
//												created by another service.
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets the BCM instance so that mutliple services can use
//						the same BCM.
//						Users should call SetBCM() to specify a BCM for a service.
//						To share data between presentation DataWindows, call 
//						ShareData().
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Add call to MapColumns()
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int         li_rc = 1

// If there already was a BCM, destroy it.
if isValid(inv_bcm) then
	// Make sure it isn't the same BCM that we just got.
	if (inv_bcm <> anv_bcm) then
		DestroyBCM()
	end if
end if

// This flag is set to indicate that this service is not responsible for
// destroying the BCM.
SetPrimary(FALSE)

// Set the pointer to the BCM.
inv_bcm = anv_bcm

if this.MapColumns() = 1 then
//		Grab BCM classes
	inv_bcm.GetBEOClass(is_class)
else
	li_rc = -1
end if

return li_rc

end function

public subroutine setprimary (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetPrimary
//
//	Arguments:		ab_flag	Boolean indicating whether or not this is the primary service
//
//	returns:			none
//
//	Description:	Called to indicate that this BEO Service is or is not the primary
//						Service for its BCM.  The primary service is responsible for 
//						destroying the BCM.  If you do not want the BCM destroyed when
//						the service is destroyed, you should call this function passing FALSE.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.01   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ib_is_primary = ab_flag
end subroutine

public function integer validate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Validate
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		No errors
//						-1		BEO error
//
//	Description:	Checks for BEO validation errors.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int li_rc = 1
long ll_beo_index
string ls_class, ls_attribute
n_cst_ofrerror lnv_ofrerror[]

this.ClearOFRErrors()
if inv_bcm.Validate() = -1 then
	this.PropagateErrors(inv_bcm)
	this.GetOFRErrors(lnv_ofrerror)
	this.ProcessOFRError(lnv_ofrerror)
	li_rc = -1
end if

return li_rc

end function

public function integer updaterequestor (readonly long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		UpdateRequestor
//
//	Arguments:		al_row	Requestor row to update
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Updates all of the requestor columns in the specified
//						row using data from all of the business objects whose
//						classes have been registered.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2		Initial version
//	1.2		Changed to use requestor mapping info
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_col
long ll_rows
any la_data[]
string ls_colname[]

ll_rows = inv_bcm.GetData(is_regcolname, is_regcoldatatype, this.GetBEOIndex(al_row), la_data)
if ll_rows = 1 then
	for li_col = 1 to ii_reqcols
		if ib_colregistered[li_col] then
			//		Ensure we have valid attribute in result set
			if IsValid(idw_requestor) then
				if idw_requestor.object.data[al_row, li_col] <> la_data[li_col] OR &
						IsNull(idw_requestor.object.data[al_row, li_col]) OR &
						IsNull(la_data[li_col]) then
					idw_requestor.object.data[al_row, li_col] = la_data[li_col]
				end if
			else
				if ids_requestor.object.data[al_row, li_col] <> la_data[li_col] OR &
						IsNull(ids_requestor.object.data[al_row, li_col]) OR &
						IsNull(la_data[li_col]) then
					ids_requestor.object.data[al_row, li_col] = la_data[li_col]
				end if
			end if
		end if
	next
end if

return li_rc

end function

public function integer getattribute (readonly string as_table, readonly string as_column, ref string as_class, ref string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		as_table			table name
//						as_column		column name
//						as_class			reference: class name
//						as_attribute	reference: attribute name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Returns class/attribute name for specified
//						table/column name.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

if inv_bcm.GetAttribute(as_table, as_column, as_class, as_attribute) <> 1 then
	li_rc = -1
end if

return li_rc

end function

protected function integer mapcolumns ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapColumns
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Gets requestor column mapping information.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_col
string ls_colname

if ii_reqcols = 0 then
	if IsValid(idw_requestor) then
		ii_reqcols = Integer(idw_requestor.Describe("DataWindow.Column.Count"))
	else
		ii_reqcols = Integer(ids_requestor.Describe("DataWindow.Column.Count"))
	end if
	//		Set array upper bound
	ib_colregistered[ii_reqcols] = false
	//		Invoke requestor mapping event
	ipo_requestor.Dynamic Event ofr_mapcolumns()
	for li_col = 1 to ii_reqcols
		if ib_colregistered[li_col] = false then
			//		For any unregistered columns assume requestor colname = result set colname
			if IsValid(idw_requestor) then
				ls_colname = idw_requestor.Describe("#" + string(li_col) + ".name")
			else
				ls_colname = ids_requestor.Describe("#" + string(li_col) + ".name")
			end if
			this.RegisterColumn(ls_colname, ls_colname)
		end if
	next
end if

return li_rc

end function

public function long retrieve ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//

//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Any la_arg[16]

la_arg = ia_arginit

return Retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, la_arg[2], la_arg[3], la_arg[4], la_arg[5], la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, la_arg[3], la_arg[4], la_arg[5], la_arg[6], la_arg[7], la_arg[8], &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1,aa_arg2, aa_arg3, la_arg[4], la_arg[5], la_arg[6], la_arg[7], la_arg[8], &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, la_arg[5], la_arg[6], la_arg[7], la_arg[8], &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, la_arg[6], la_arg[7], la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, la_arg[7], la_arg[8], &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, la_arg[8], &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			long
//						1		success
//						-1		error
//
//	Description:	Retrieves the BCM and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8,&
aa_arg9, la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						>= 0		Number of rows retrieved
//						< 0		error
//
//	Description:	Retrieves the bcm and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8,&
aa_arg9, aa_arg10, la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						>= 0		Number of rows retrieved
//						< 0		error
//
//	Description:	Retrieves the bcm and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9, aa_arg10, aa_arg11, la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16])

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						>= 0		Number of rows retrieved
//						< 0		error
//
//	Description:	Retrieves the bcm and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	     
/////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9, aa_arg10, aa_arg11, aa_arg12, la_arg[13], la_arg[14], la_arg[15], la_arg[16])


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						>= 0		Number of rows retrieved
//						< 0		error
//
//	Description:	Retrieves the bcm and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	     
/////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9, aa_arg10, aa_arg11, aa_arg12, aa_arg13, la_arg[14], la_arg[15], la_arg[16])


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						>= 0		Number of rows retrieved
//						< 0		error
//
//	Description:	Retrieves the bcm and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	     
/////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9, aa_arg10, aa_arg11, aa_arg12, aa_arg13, aa_arg14, la_arg[15], la_arg[16])


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						>= 0		Number of rows retrieved
//						< 0		error
//
//	Description:	Retrieves the bcm and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	     
/////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Any la_arg[16]

la_arg = ia_arginit

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9, aa_arg10, aa_arg11, aa_arg12, aa_arg13, aa_arg14, aa_arg15, la_arg[16])


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15, readonly any aa_arg16);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		aa_argn	0 to 16 retrieval arguments
//
//	Returns:			Long
//						>= 0		Number of rows retrieved
//						< 0		error
//
//	Description:	Retrieves the bcm and populates the requestor
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.2		Add call to RegisterRequestor
// 1.20.05  Allow 16 arguments.
//	     
/////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long 				ll_rc = 1
long 				ll_retrievestart
n_cst_ofrerror lnv_ofrerror[]
integer 			li_idx, li_end

this.ClearOFRErrors()

//		Create the BCM if not already created
if NOT IsValid(inv_bcm) then
	this.CreateBCM()
end if

if isValid(inv_bcm) then
	if IsValid(idw_requestor) then
		ll_retrievestart = this.idw_requestor.event RetrieveStart()
	else
		ll_retrievestart = this.ids_requestor.event RetrieveStart()
	end if
		
	if ll_retrievestart = 1 then
		ll_rc = -1
	else
		// Unless the append flag was explicitly set via SetAppend, check the return
		// code from RetrieveStart.
		if ib_appendset = false then
			if ll_RetrieveStart = 2 then
				this.ib_append = true
			else
				this.ib_append = false
			end if
		end if
		
		inv_bcm.SetAppend(this.ib_append)
		ll_rc = inv_bcm.Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, aa_arg9, aa_arg10, aa_arg11, aa_arg12, aa_arg13, aa_arg14, aa_arg15, aa_arg16)
		if ll_rc >= 0 then
			ib_bcmcreated = true
			if this.SetBCM() = 1 then
				if this.MapColumns() = 1 then
					if ib_Shared then
						if this.ShareBCM() <> 1 then
							this.PushException("retrievebcm")
							ll_rc = -1
						end if
					else
						if this.CopyBCM(false) <> 1 then
							this.PushException("retrievebcm")
							ll_rc = -1
						end if
					end if
					if ll_rc >= 0 then
						if IsValid(idw_requestor) then
							this.idw_requestor.event RetrieveEnd(ll_rc)
						else
							this.ids_requestor.event RetrieveEnd(ll_rc)
						end if
					end if
				else
					this.PushException("retrievebcm")
					ll_rc = -1
				end if
			else
				this.PushException("retrievebcm")
				ll_rc = -1
			end if
		else
			this.PropagateErrors(inv_bcm)
			this.GetOFRErrors(lnv_ofrerror)
			this.ProcessOFRError(lnv_ofrerror)
			ll_rc = -1
		end if
	end if
end if

return ll_rc
end function

public function integer deleterow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DeleteRow
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

public function integer save (readonly boolean ab_accepttext, readonly boolean ab_resetupdateflag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Save
//
//	Arguments:		ab_accepttext			AcceptText indicator
//						ab_resetupdateflag	ResetUpdate flags indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Saves changes that have been made to the BCM.
//						Optionally an AcceptText will be performed before
//						the update and optionally a ResetUpdate will be
//						performed after the udpate.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	Add call to Validate
//	1.2	Change to use TX service
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1
n_cst_txsrv lnv_txsrv

this.ClearOFRErrors()
lnv_txsrv = create n_cst_txsrv
if IsValid(lnv_txsrv) then
	if IsValid(idw_requestor) then
		lnv_txsrv.Register(idw_requestor)
	else
		lnv_txsrv.Register(ids_requestor)
	end if
	if lnv_txsrv.Save() <> 1 then
		this.PropagateErrors(lnv_txsrv)
		li_rc = -1
	end if
	destroy lnv_txsrv
else
	li_rc = -1
end if

return li_rc
	
end function

protected function integer set (long al_row, string as_column, any aa_value, boolean ab_itemchanged);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		al_row		Row in requestor being changed
//						as_column	Name of column in requestor being changed
//						aa_value		New value
//						ab_itemchanged		Indicator for ItemChanged invoked
//
//	Returns:			Integer
//						2		Successfully updated attribute and other
//								attributes have been updated as a result
//						1		Successfully updated attribute
//						0		Attempt to set non-registered column
//						-1		error setting attribute
//
//	Description:	Sets the specified value to the attribute associated
//						to the specified column for the business object
//						associated to the specified row.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Updated for multi-class support to call set on BCM instead of on BEO.
//	1.0.1	Added check for unregistered columns
//	1.0.2	BTR 6761 - Remove message on unregistered columns
//	1.0.2	BTR 6759 - Add check for warnings
// 2.1	BTR 9252	- Cast strings that should be datetimes
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_beo_index, ll_keyval
int li_rc, li_col
n_cst_beo lnv_beo
n_cst_ofrerror lnv_ofrerror[]
string ls_dataobject, ls_coldatatype

This.ClearOFRErrors()

if al_row < 1 or al_row > RowCount() then
	if IsValid(idw_requestor) then
		ls_dataobject = idw_requestor.dataobject
	else
		ls_dataobject = ids_requestor.dataobject
	end if
	this.SetException("set", "27995", {String(al_row), ls_dataobject})
	return -1
end if
ll_beo_index = this.GetBEOIndex(al_row)

if IsValid(idw_requestor) then
	li_col = integer(idw_requestor.Describe(as_column + '.id'))
else
	li_col = integer(ids_requestor.Describe(as_column + '.id'))
end if
if li_col = 0 then
	if IsValid(idw_requestor) then
		ls_dataobject = idw_requestor.dataobject
	else
		ls_dataobject = ids_requestor.dataobject
	end if
	this.SetException("set", "27996", {as_column, ls_dataobject})
	return -1
end if

//		Don't allow setting of columns that have not been registered
if ib_colregistered[li_col] = false then
	return 0
end if

li_rc = inv_bcm.set(ll_beo_index, is_regcolname[li_col], aa_value)

// Trap columns missing from result set
if li_rc = 0 then
	return 0
end if

if li_rc < 0 then		// set ( ) failed, catch error
	this.PropagateErrors(inv_bcm)
	if this.GetOFRErrors(lnv_ofrerror) > 0 then
		//		Let warnings pass through to update BCM
		if lnv_ofrerror[1].GetWarning() = FALSE then
			return li_rc
		end if
	else
		this.PushException("set")
		return li_rc
	end if
end if
	
if NOT ib_Shared then
	if li_rc = 2 then
		// retval 2 from set indicates other attributes were updated so
		// call UpdateRequestor to refresh all attribute values
		lnv_beo = this.GetBEO(al_row)
		this.UpdateRequestor(al_row)
	elseif ab_itemchanged = FALSE then
		if IsNull(aa_value) then
			li_rc = SetNull(al_row, li_col)
		else
			If IsValid(idw_requestor) then
				ls_coldatatype = idw_requestor.Describe("#" + string(li_col) + ".ColType")
			else
				ls_coldatatype = ids_requestor.Describe("#" + string(li_col) + ".ColType")
			end if
			if ls_coldatatype = "datetime" and Classname(aa_value) = "string" then
				aa_value = datetime(date(mid(aa_value,1,pos(aa_value," "))), time(mid(aa_value,pos(aa_value," "))))
			end if
			if IsValid(idw_requestor) then
				idw_requestor.Object.Data[al_row, li_col] = aa_value
			else
				ids_requestor.Object.Data[al_row, li_col] = aa_value
			end if
		end if

		if li_rc <> 1 then

			this.PushException("set")
			return li_rc
		end if
	end if
end if

return li_rc


end function

protected function n_cst_bcm createbcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateBCM
//
//	Arguments:		none
//
//	Returns:			Returns created BCM - null if an error occurs.
//
//	Description:	Creates new BCM
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	Call to SetPrimary(TRUE) for BEOSRV created BCM's
//	2.1 	Don't create BCM is there is no DW Object on the requestor.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_syntax, ls_filter, ls_class
int li_class

if UpperBound(is_class) > 0 then
	ls_class = is_class[1]
end if

If ib_bcmcreated = false then	
	if IsValid(idw_requestor) then
		// Check if syntax-generated datawindow
		if Len(idw_requestor.dataobject) = 0 then
			// Syntax-generated datawindow
			ls_syntax = idw_requestor.Describe("datawindow.syntax")
		else
			// Datawindow object
			ls_syntax = idw_requestor.dataobject
		end if
		if ls_syntax <> "" and ls_syntax <> "?" then
			ls_filter = idw_requestor.Object.DataWindow.Table.Filter
		else
			return inv_bcm
		end if
	else
		// Check if syntax-generated datastore
		if Len(ids_requestor.dataobject) = 0 then
			// Syntax-generated datastore
			ls_syntax = ids_requestor.Describe("datawindow.syntax")
		else
			// Datawindow object
			ls_syntax = ids_requestor.dataobject
		end if
		if ls_syntax <> "" and ls_syntax <> "?" then
			ls_filter = ids_requestor.Object.DataWindow.Table.Filter
		else
			return inv_bcm
		end if
	end if
	
	inv_bcm =this.GetBCMMGR().CreateBCM(is_bcm_classname, ls_class)
	if IsValid ( inv_bcm ) then
		ib_bcmcreated = TRUE
		inv_bcm.SetTransObject(itrx_tran)
		for li_class = 1 to UpperBound(is_class)
			inv_bcm.AddClass(is_class[li_class])

		next
		if is_dlk_name > "" then
			inv_bcm.SetDLK(is_dlk_name)
		else
			if inv_bcm.SetQuery ( ls_syntax ) = 1 then
				//		SetQuery will clear the current filter
				//		If we are in shared mode then restore it
				if this.ib_shared then
					this.ShareBCM()
					if ls_filter <> "?" then
						ipo_requestor.Dynamic SetFilter(ls_filter)
					end if
				end if
			else
				this.PushException("creatbcm")
			end if
		end if
	else
		this.PushException("createbcm")
	end if
end if

return inv_bcm
end function

protected function long rowcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RowCount
//
//	Arguments:		none
//
//	Returns:			Number of rows in requestor
//
//	Description:	Get number of rows in requestor
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rows

if IsValid(idw_requestor) then
	ll_rows = idw_requestor.RowCount()
else
	ll_rows = ids_requestor.RowCount()
end if

return ll_rows
end function

public function integer set (readonly long al_row, readonly string as_column, readonly any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		al_row		Row in requestor being changed
//						as_column	Name of column in requestor being changed
//						aa_value		New value
//
//	Returns:			Integer
//						2		Successfully updated attribute and other
//								attributes have been updated as a result
//						1		Successfully updated attribute
//						0		Attempt to set non-registered column
//						-1		error setting attribute
//
//	Description:	Sets the specified value to the attribute associated
//						to the specified column for the business object
//						associated to the specified row.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.Set ( al_row, as_column, aa_value, FALSE )

end function

public function long insertrow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		InsertRow
//
//	Arguments:		al_row	Location to create new row at
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Creates a new row in the requestor and a new
//						corresponding business object.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo lnv_null

return this.New(al_row, lnv_null, "")

end function

public function integer registercolumn (readonly string as_requestor_colname, readonly string as_resultset_colname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterColumn
//
//	Arguments:		as_column		requestor column name
//						as_colname		result set column name
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Maps requestor column to result set column
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc, li_column

if IsValid(idw_requestor) then
	li_column = integer(idw_requestor.Describe(as_requestor_colname + '.id'))
else
	li_column = integer(ids_requestor.Describe(as_requestor_colname + '.id'))
end if

if li_column > 0 then
	ib_colregistered[li_column] = true
	is_regcolname[li_column] = as_resultset_colname
	if IsValid(idw_requestor) then
		is_regcoldatatype[li_column] = idw_requestor.Describe(as_requestor_colname + '.coltype')
	else
		is_regcoldatatype[li_column] = ids_requestor.Describe(as_requestor_colname + '.coltype')
	end if
	li_rc = 1
else
	li_rc = -1
end if

return li_rc

end function

public function boolean getprimary ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetPrimary
//
//	Arguments:		none
//
//	returns:			Boolean indicating whether or not this is the primary service
//
//	Description:	Returns indicator that this BEO Service is or is not the primary
//						Service for its BCM.  The primary service is responsible for 
//						destroying the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return ib_is_primary

end function

protected function integer sharebcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ShareBCM
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Shares the BCM Datastore with the requestor.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0  Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Datastore lds_view
string ls_filter
int li_rc

lds_view = inv_bcm.GetView ( )
if IsValid(idw_requestor) then
	ls_filter = idw_requestor.Object.DataWindow.Table.Filter
	li_rc = lds_view.ShareData ( idw_requestor )
	if ls_filter <> "?" then
		idw_requestor.SetFilter(ls_filter)
		idw_requestor.Filter()
	end if
else
	ls_filter = ids_requestor.Object.DataWindow.Table.Filter
	li_rc = lds_view.ShareData ( ids_requestor )
	if ls_filter <> "?" then
		ids_requestor.SetFilter(ls_filter)
		ids_requestor.Filter()
	end if
end if

return li_rc

end function

protected function integer addbeoindex (ref string as_syntax);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddBEOIndex
//
//	Arguments:		as_syntax	Syntax of DW
//
//	returns:			long
//						1		success
//						-1		error
//
//	Description:	Adds BEO_Index computed column to passed syntax
//						if the column is missing.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1   Return from function if this is pb version 6.0 and indicator specifies use
//			of pb function GetRowIDFromRow instead of beo_index
// 2.1	Add External datawindow support
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//		Add BEO Index column to dw/ds syntax
//		returns: 1 if column added, -1 error

Int li_rc
Long ll_retrieve, ll_from, ll_pos, ll_pos2
String ls_char, ls_error, ls_dataobject


if this.GetBCMMGR().IsPBRowIDOn() then return 1

if IsValid(idw_requestor) then
	ls_dataobject = idw_requestor.dataobject
else
	ls_dataobject = ids_requestor.dataobject
end if

// Look for PBSelect retrieve syntax
ll_retrieve = Pos(as_syntax, "retrieve=~"PBSELECT(")

// did it find it in PBSelect
if ( ll_retrieve > 0 ) then
	ll_pos2 = Max(Pos(as_syntax, "COLUMN(NAME", ll_retrieve), Pos(as_syntax, "COMPUTE(NAME", ll_retrieve))
	do while ll_pos2 > 0
		ll_pos = ll_pos2 + 10
		ll_pos2 = Max(Pos(as_syntax, "COLUMN(NAME", ll_pos), Pos(as_syntax, "COMPUTE(NAME", ll_pos))
	loop
	ll_pos = Pos(as_syntax, ")", ll_pos)
	// Add column to PBSELECT
	as_syntax = Left(as_syntax, ll_pos) +&
			" COMPUTE(NAME=~~~"0~~~")" + Mid(as_syntax, ll_pos + 1)
	// Add computed column
	as_syntax = Left(as_syntax, ll_retrieve - 1) +&
			" column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
			Mid(as_syntax, ll_retrieve)
	li_rc = 1
else
	// Look for SQL SELECT
	ll_retrieve = Pos( as_syntax, "retrieve=" )
	if ( ll_retrieve > 0 ) then
		ll_from = Pos(Lower(as_syntax), " from ", ll_retrieve)
		if ( ll_from > 0 ) then
			// Add computed column to SELECT
			as_syntax = Left(as_syntax, ll_from - 1) + ", 0 " + isc_beo_index + Mid(as_syntax, ll_from)
			// Add computed column
			as_syntax = Left(as_syntax, ll_retrieve - 1) +&
					" column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
					Mid(as_syntax, ll_retrieve)
			li_rc = 1
		else
			this.SetException("addbeoindex", "27993", {ls_dataobject})
			li_rc = -1
		end if
	else
		// Look for stored procedure
		ll_retrieve = Pos( as_syntax, "procedure=" )
		if ( ll_retrieve > 0 ) then
			// Add computed column
			as_syntax = Left(as_syntax, ll_retrieve - 1) +&
					" column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
					Mid(as_syntax, ll_retrieve)
			li_rc = 1
		else
			
			//most likely an external datawindow which has no indicator
			ll_pos = 1
			ll_retrieve = 1
	
			do until ll_retrieve = 0
				ll_retrieve = Pos( as_syntax, "dbname=", ll_pos )
				if ll_retrieve <> 0 then
					ll_pos = ll_retrieve + 7
				end if
			loop
			
			ll_retrieve = Pos( as_syntax, ")", ll_pos) 
			as_syntax = Left(as_syntax, ll_retrieve + 1) + " column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
					Mid(as_syntax, ll_retrieve + 1)
			li_rc = 1
		end if
	end if
end if

return li_rc

end function

protected function integer setnull (long al_row, integer ai_col);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetNull
//
//	Arguments:		al_row	Requestor row
//						ai_col	Requestor column
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears a column in the requestor
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.3   Handle datastores too.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
String ls_coltype
Int li_rc = 1
String ls_null
DateTime ldt_null
Date ld_null
Time lt_null
Double ldbl_null


if IsValid(idw_requestor) then
	ls_coltype = idw_requestor.Describe("#" + String(ai_col) + ".coltype")
	choose case Left(ls_coltype, 5)
		case "char("
			SetNull(ls_null)
			idw_requestor.Object.Data[al_row, ai_col] = ls_null
		case "datet"
			SetNull(ldt_null)
			idw_requestor.Object.Data[al_row, ai_col] = ldt_null
		case "date"
			SetNull(ld_null)
			idw_requestor.Object.Data[al_row, ai_col] = ld_null
		case "time"
			SetNull(lt_null)
			idw_requestor.Object.Data[al_row, ai_col] = lt_null
		case else
			SetNull(ldbl_null)
			idw_requestor.Object.Data[al_row, ai_col] = ldbl_null
	end choose
elseif IsValid(ids_requestor) then
	ls_coltype = ids_requestor.Describe("#" + String(ai_col) + ".coltype")
	choose case Left(ls_coltype, 5)
		case "char("
			SetNull(ls_null)
			ids_requestor.Object.Data[al_row, ai_col] = ls_null
		case "datet"
			SetNull(ldt_null)
			ids_requestor.Object.Data[al_row, ai_col] = ldt_null
		case "date"
			SetNull(ld_null)
			ids_requestor.Object.Data[al_row, ai_col] = ld_null
		case "time"
			SetNull(lt_null)
			ids_requestor.Object.Data[al_row, ai_col] = lt_null
		case else
			SetNull(ldbl_null)
			ids_requestor.Object.Data[al_row, ai_col] = ldbl_null
	end choose
else
	return -1
end if

return li_rc

end function

protected function integer destroybcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestroyBCM
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Destroys the BCM associated to the service
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.01   GK - Only destroy the BCM if this is the primary service. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

// Only destroy the BCM if it exists and this service is it's owner.
If IsValid ( inv_bcm ) and ib_is_primary then
	this.GetBCMMGR().DestroyBCM (  inv_bcm )
	if IsValid ( inv_bcm ) then
		li_rc = -1 
	end if
end if

return li_rc

end function

protected function integer checkbeoindex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CheckBEOIndex
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		BEO Index column added
//						0		Column already exists
//						-1		error
//
//	Description:	Checks for and adds BEO Index computed column.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	Add setting of ii_beo_index_col
// 2.1   If GetPBRowIDInd is true pb function GetRowIDfromRow
//			is to be used instead of beoindex.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int li_rc
String ls_syntax, ls_error, ls_dataobject, ls_control

if this.GetBCMMGR().IsPBRowIDOn() then
	return 0
end if

if IsValid(idw_requestor) then
	ii_beo_index_col =  integer(idw_requestor.Describe(isc_beo_index + ".ID"))
else
	ii_beo_index_col =  integer(ids_requestor.Describe(isc_beo_index + ".ID"))
end if

//		Check for old BO_INDEX
if ( ii_beo_index_col <= 0 ) then
	if IsValid(idw_requestor) then
		ii_beo_index_col =  integer(idw_requestor.Describe("bo_index.ID"))
	else
		ii_beo_index_col =  integer(ids_requestor.Describe("bo_index.ID"))
	end if
end if

// if the BEO_INDEX id is not found then...
if ( ii_beo_index_col <= 0 ) then
	if IsValid(idw_requestor) then
		// grab the dw syntax
		ls_syntax = idw_requestor.Describe("DataWindow.Syntax")
		ls_dataobject = idw_requestor.DataObject
	else
		ls_syntax = ids_requestor.Describe("DataWindow.Syntax")
		ls_dataobject = ids_requestor.DataObject
	end if
	//		Check for missing DataWindow object
	if ls_syntax = "" then
		if IsValid(idw_requestor) then
			ls_control = idw_requestor.ClassName()
		else
			ls_control = ids_requestor.ClassName()
		end if
		this.SetException("checkbeoindex", "27994", {ls_control, ls_dataobject})
	else
		if this.AddBEOIndex(ls_syntax) = 1 then
			if IsValid(idw_requestor) then
				li_rc = idw_requestor.Create( ls_syntax, ls_error )
			else
				li_rc = ids_requestor.Create( ls_syntax, ls_error )
			end if
			if ( li_rc = 1 ) then
				if IsValid(idw_requestor) then
					ii_beo_index_col =  integer(idw_requestor.Describe(isc_beo_index + ".ID"))
				else
					ii_beo_index_col =  integer(ids_requestor.Describe(isc_beo_index + ".ID"))
				end if
			else
				this.SetException("checkbeoindex", "27998", {ls_error})
				li_rc = -1
			end if
		else
			this.PushException('checkbeoindex')
			li_rc = -1
		end if
	end if
else
	li_rc = 0
end if

return li_rc

end function

public function integer setrequestor (readonly powerobject apo_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRequestor
//
//	Arguments:		apo_requestor	Requestor DataWindow
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Identifies the requestor DataWindow to the
//						business object services.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	2.0	Call ancestor definition
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1

if super::SetRequestor(apo_requestor) = 1 then
	if TypeOf(ipo_requestor) = DataWindow! then
		idw_requestor = apo_requestor
	elseif TypeOf(ipo_requestor) = DataStore! then
		ids_requestor = apo_requestor
	else
		return -1
	end if
	if this.CheckBEOIndex() >= 0 then
		li_rc = 1
	else
		this.PushException('setrequestor()')
	end if
end if

return li_rc

end function

public function integer seterrorfocus (readonly n_cst_ofrerror anv_ofrerror);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetErrorFocus
//
//	Arguments:		anv_ofrerror	OFR error object to get focus info from
//
//	returns:			Integer	1  success
//									-1  could not set focus
//
//	Description:	Attempts to set the focus to the object in error based
//						on the information from the specified OFR error object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
//
//////////////////////////////////////////////////////////////////////////////

//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_column, li_i
long ll_beoindex, ll_row
string ls_class, ls_attribute, ls_column

if IsValid(idw_requestor) then
	if GetFocus() <> idw_requestor then
		li_rc = idw_requestor.SetFocus()
	end if
	if li_rc <> -1 then
		ll_beoindex = anv_ofrerror.GetBEOIndex()
		if ll_beoindex > 0 then
			ll_row = this.GetBEORow(ll_beoindex)
			if ll_row > 0 then
				if ll_row <> idw_requestor.GetRow() then
					li_rc = idw_requestor.ScrollToRow(ll_row)
				end if
			else
				li_rc = -1
			end if
		else
			li_rc = -1
		end if
	end if
	if li_rc <> -1 then
		ls_class = anv_ofrerror.GetClass()
		ls_attribute = anv_ofrerror.GetAttribute()
		if ls_class <> '' and ls_attribute <> '' then
			ls_column = inv_bcm.GetColumnName(ls_class, ls_attribute)
			if ls_column <> "" then
				li_column = 1
				for li_i = 1 to ii_reqcols
					if ib_colregistered[li_i] = true then
						if is_regcolname[li_i] = ls_column then
							li_column = li_i
							exit
						end if
					end if
				next
				if li_column <> 0 then
					if li_column <> idw_requestor.GetColumn() then
						li_rc = idw_requestor.SetColumn(li_column)
					end if
				end if
			else
				li_rc = -1
			end if
		else
			li_rc = -1
		end if
	end if
else
	li_rc = -1
end if

return li_rc

end function

public function string getqueryname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDataObject
//
//	Arguments:		none
//
//	Returns:			String	DataObject for the requestor or dlk name
//
//	Description:	Returns the dataobject for the datawindow or datastore or dlk
//						name.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_syntax

if is_dlk_name <> "" then
	return is_dlk_name
else
	if IsValid(idw_requestor) then
	// Check if syntax-generated datawindow
		if Len(idw_requestor.dataobject) = 0 then
			// Syntax-generated datawindow
			ls_syntax = idw_requestor.Describe("datawindow.syntax")
		else
			// Datawindow object
			ls_syntax = idw_requestor.dataobject
		end if
	else
		// Check if syntax-generated datastore
		if Len(ids_requestor.dataobject) = 0 then
			// Syntax-generated datastore
			ls_syntax = ids_requestor.Describe("datawindow.syntax")
		else
			// Datawindow object
			ls_syntax = ids_requestor.dataobject
		end if
	end if
end if

return ls_syntax
end function

public function integer setbcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCM
//
//	Arguments:		None
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Repacement function for CreateBCM.  Intialize newly created
//						bcm.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc = 1, li_class, li_classes
string  ls_filter

if not IsValid(inv_bcm) then
	return -1
end if

ib_bcmcreated = TRUE

li_classes = UpperBound(is_class)
for li_class = 1 to li_classes
	inv_bcm.AddClass(is_class[li_class])
next

if is_dlk_name = "" then
	if IsValid(idw_requestor) then
		ls_filter = idw_requestor.Object.DataWindow.Table.Filter
	else
		ls_filter = ids_requestor.Object.DataWindow.Table.Filter
	end if
	
	if this.ib_shared then
		li_rc = this.ShareBCM()
		if ls_filter <> "?" then
			ipo_requestor.Dynamic SetFilter(ls_filter)
		end if
	end if
end if

return li_rc
end function

public function integer reset ();////////////////////////////////////////////////////////////////////////////////
//	Function:		Reset
//
//	Arguments:		None
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears the data in the BCM.  This is called 
//						from the Reset fuction in ofr_u_dw and ofr_n_ds.
//						This function should not be directly.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.3   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if isValid(inv_bcm) then
	return inv_bcm.Reset()
end if

return 1


end function

public function n_cst_bcm getbcm (readonly boolean ab_createbcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		ab_createbcm	specifies whether to create BCM if not valid
//
//	Returns:			BCM (n_cst_bcm) associated to BEO service
//
//	Description:	Returns BCM associated to BEO service
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if not isvalid(inv_bcm) and ab_CreateBCM then
	return this.CreateBCM()
end if

return inv_bcm

end function

public function n_cst_bcm getbcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		none
//
//	Returns:			BCM (n_cst_bcm) associated to BEO service
//
//	Description:	Returns BCM associated to BEO service
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.0   Removed create of a bcm. Only an SSO can create a bcm.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.GetBCM(TRUE)
end function

public function boolean isbcmcreated ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsBCMCreated
//
//	Arguments:		none
//
//	Returns:			Boolean indicator
//
//	Description:	Returns indicator as to whether BCM has been created
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if IsValid(inv_bcm) then
	return TRUE
else
	return FALSE
end if

end function

public function boolean isrequestorvalid ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsRequestorValid
//
//	Arguments:		none
//
//	Returns:			Boolean
//
//	Description:	Checks to see if the requestor is usable.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_syntax

if isValid(idw_requestor) then
	// Check if syntax-generated datawindow
	if Len(idw_requestor.dataobject) = 0 then
		// Syntax-generated datawindow
		ls_syntax = idw_requestor.Describe("datawindow.syntax")
	else
		// Datawindow object
		ls_syntax = idw_requestor.dataobject
	end if
	if ls_syntax <> "" and ls_syntax <> "?" then
		return true
	end if
elseif isValid(ids_requestor) then
	// Check if syntax-generated datawindow
	if Len(ids_requestor.dataobject) = 0 then
		// Syntax-generated datawindow
		ls_syntax = ids_requestor.Describe("datawindow.syntax")
	else
		// Datawindow object
		ls_syntax = ids_requestor.dataobject
	end if
	if ls_syntax <> "" and ls_syntax <> "?" then
		return true
	end if	
end if

return false
end function

public function integer setappend (boolean ab_flag);////////////////////////////////////////////////////////////////////////////////
//	Function:		SetAppend
//
//	Arguments:		ab_flag - Use append or not.
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Whether or not to append rows on a retrieve.  
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ib_append = ab_flag
ib_appendset = true
return 1
end function

protected function long copybcm (readonly boolean ab_allrows);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CopyBCM
//
//	Arguments:		ab_allrows	Indicator as to whether to copy all rows
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Copies BCM data to presentation DataWindow
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.2		Change to call requestor OFRInsertRow()
//	1.2		Move data by columns to allow for sparse requestor
//	1.2		GK - Removed Dynamic calls for PB6
//	1.20.04	BTR# 9224 Reset requestor before copying to clear filtered data
// 1.3		#8764 - Don't bother doing filter and sort if there are no rows.
//	1.3 		Call new Reset function.
// 2.1		BTR# 8372 Dont use bcm_ds.il_retrieved as value for ll_rows
//
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int  li_cols
long ll_row, ll_rows, ll_rowcount, ll_startrow, ll_endrow, ll_rc
string ls_colname[]
any la_data[]

ll_rowcount = this.RowCount()

if IsValid(idw_requestor) then
	idw_requestor.SetRedraw(FALSE)
end if

if ll_rowcount = 0 then
	ipo_Requestor.dynamic OFRInsertRow ( 0 )	// assures that dddw's get retrieved
end if

//		Clear requestor including any filtered data
if ib_append = false then
	// 1.3 - Call new Reset function since PB Reset is now overridden in ofr_u_dw and ofr_n_ds.
	if IsValid(idw_requestor) then
		idw_requestor.function dynamic ResetPresentation()
	else
		ids_requestor.function dynamic ResetPresentation()
	end if
end if

if ab_allrows then
	ll_rc = inv_bcm.GetData(is_regcolname, is_regcoldatatype, 0, la_data)
else
	ll_rc = inv_bcm.GetRetrievedData(is_regcolname, is_regcoldatatype, la_data)
end if

//2.1 change
ll_rows = UpperBound(la_data)

if ll_rows > 0 then
	if ib_append = true and ab_allrows = false then
		li_cols = UpperBound(is_regcolname)
		ll_startrow = ll_rowcount + 1
		ll_endrow = ll_rowcount + ll_rows
		if IsValid(idw_requestor) then
			idw_requestor.object.data[ll_startrow, 1, ll_endrow, li_cols] = la_data
			for ll_row = ll_startrow to ll_endrow
				idw_requestor.SetItemStatus(ll_row, 0,  Primary!, NotModified!)
			next
		else
			ids_requestor.object.data[ll_startrow, 1, ll_endrow, li_cols] = la_data
			for ll_row = ll_startrow to ll_endrow
				ids_requestor.SetItemStatus(ll_row, 0,  Primary!, NotModified!)
			next
		end if
	else
		if IsValid(idw_requestor) then
			idw_requestor.object.data = la_data
			idw_requestor.ResetUpdate ( )
			// Trigger event so that linkage service will pick up new rows.
			idw_requestor.Event rowfocuschanged(idw_requestor.GetRow())
		else
			ids_requestor.object.data = la_data
			ids_requestor.ResetUpdate ( )
		end if
	end if
elseif ll_rc < 0 then
	this.PushException("copybcm")
	ll_rc = -1
end if

if ll_rc >= 0 then
	ll_rc = 1
end if

if IsValid(idw_requestor) then
	// 1.3 Change
	if ll_rows > 0 then
		idw_requestor.Filter()
		idw_requestor.Sort()
	end if
	idw_requestor.SetRedraw(TRUE)
else
	// 1.3 Change
	if ll_rows > 0 then
		ids_requestor.Filter()
		ids_requestor.Sort()
	end if
end if

return ll_rc

end function

public function long getbeoindex (long al_row, dwbuffer adw_buffer);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		al_row	Row to get BEO Index for
//
//	Returns:			Long BEO Index value for specified row.
//
//	Description:	Returns the BEO Index value for the specified row.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1 	Added 6.0 function GetRowIDFromRow
//	2.1   Fix BTR# 12115 - Added check for buffers
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rc

if isNull(adw_buffer) then
	adw_buffer = Primary!
end if

if al_row > 0 then 
	if IsValid(idw_requestor) then
		if this.GetBCMMGR().IsPBRowIDOn() then
			ll_rc = idw_requestor.dynamic GetRowIDFromRow( al_row )
		else
			ll_rc = idw_requestor.GetItemNumber ( al_row, ii_beo_index_col, adw_buffer, false )
		end if
	else
		if this.GetBCMMGR().IsPBRowIDOn() then
			ll_rc = ids_requestor.dynamic GetRowIDFromRow( al_row )
		else
			ll_rc = ids_requestor.GetItemNumber ( al_row, ii_beo_index_col, adw_buffer, false )
		end if
	end if

	if ll_rc <= 0 then
		this.SetException("getbeoindex", "27997", {string(al_row)})
		ll_rc = -1
	end if
else
	ll_rc = -1
end if

return ll_rc

end function

public function long getbeoindex (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		al_row	Row to get BEO Index for
//
//	Returns:			Long BEO Index value for specified row.
//
//	Description:	Returns the BEO Index value for the specified row.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	2.1   Fix BTR# 12115 - Added call to function with buffer argument
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return this.GetBEOIndex(al_row, Primary!)
end function

protected function boolean getthinclient ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetThinClient
//
//	Arguments:		None
//
//	Returns:			Boolean
//
//	Description:	Indicates if this UI Link is working in Thin Clien mode.
//						FOR INTERNAL USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if isValid(inv_bcm) then
	return inv_bcm.GetThinClient()
else
	return false
end if

end function

public function long getbeorow (long al_beoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEORow
//
//	Arguments:		al_beoindex	BEOIndex of row to find
//
//	returns:			Long	Row number for specified BEOIndex
//
//	Description:	Returns row number for specified BEOIndex.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   	Initial version
// 1.2		GK - Removed useless dynamic calls.
// 2.0 		Added pb 6.0 function GetRowFromRowID
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row, ll_rowcount

if IsValid(idw_requestor) then
	if this.GetBCMMgr().IsPBRowIDOn() then
		ll_row = idw_requestor.dynamic GetRowFromRowID(al_beoindex)
	else
		ll_rowcount = idw_requestor.RowCount()
		ll_row = idw_requestor.Find("#" + String(ii_beo_index_col) + "=" + String(al_beoindex), 1, ll_rowcount)
	end if
else
	if this.GetBCMMgr().IsPBRowIDOn() then
		ll_row = ids_requestor.dynamic GetRowFromRowID(al_beoindex)
	else
		ll_rowcount = ids_requestor.RowCount()
		ll_row = ids_requestor.Find("#" + String(ii_beo_index_col) + "=" + String(al_beoindex), 1, ll_rowcount)
	end if
end if

return ll_row

end function

on ofr_n_cst_uilink_dw.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_uilink_dw.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			destructor
//
//	Description:	Clean up associated BCM 
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.

//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
this.DestroyBCM( )


end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			constructor
//
//	Description:	Set default transaction object
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.0   Added retrieval argument initialization array. An invokation of a 
//			remote object requires Any arguments be explicitly set to null.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
itrx_tran = SQLCA

SetNull(ia_arginit[1])
SetNull(ia_arginit[2])
SetNull(ia_arginit[3])
SetNull(ia_arginit[4])
SetNull(ia_arginit[5])
SetNull(ia_arginit[6])
SetNull(ia_arginit[7])
SetNull(ia_arginit[8])
SetNull(ia_arginit[9])
SetNull(ia_arginit[10])
SetNull(ia_arginit[11])
SetNull(ia_arginit[12])
SetNull(ia_arginit[13])
SetNull(ia_arginit[14])
SetNull(ia_arginit[15])
SetNull(ia_arginit[16])

end event

