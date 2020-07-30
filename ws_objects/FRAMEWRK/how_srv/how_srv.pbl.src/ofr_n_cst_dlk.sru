$PBExportHeader$ofr_n_cst_dlk.sru
forward
global type ofr_n_cst_dlk from n_cst_base
end type
end forward

global type ofr_n_cst_dlk from n_cst_base
event type long ofr_retrieve ( )
event type long ofr_sqlpreview ( readonly transaction anv_tran,  readonly sqlpreviewfunction request,  readonly sqlpreviewtype sqltype,  ref string sqlsyntax,  readonly dwbuffer buffer,  readonly long row )
event type long ofr_deleterow ( readonly transaction anv_tran,  ref string sqlsyntax,  readonly dwbuffer buffer,  readonly long row )
event type long ofr_insertrow ( readonly transaction anv_tran,  ref string sqlsyntax,  readonly dwbuffer buffer,  readonly long row )
event type long ofr_updaterow ( readonly transaction anv_tran,  ref string sqlsyntax,  readonly dwbuffer buffer,  readonly long row )
event type integer ofr_update ( readonly boolean ab_doinserts,  readonly boolean ab_doupdates,  readonly boolean ab_dodeletes )
end type
global ofr_n_cst_dlk ofr_n_cst_dlk

type variables
protected:
n_bcm_ds ids_view
// transaction object reference for DLK's ids_view.
transaction itrx_view
any iany_args[]

string is_datasource
string is_dlk_relation
boolean ib_append

// update info
boolean ib_allow_mulitable_update = TRUE
boolean ib_first_update = TRUE	// control var for save ( ) 
ofr_s_dlk_updateinfo ist_upd[]
boolean ib_override_updateinfo = false
string is_queryname
boolean ib_isclassquery  = FALSE

n_cst_bcm inv_bcm
end variables

forward prototypes
public function integer dberror (readonly long al_beoindex, readonly long al_sqldbcode, readonly string as_sqlerrtext, readonly string as_sql)
protected function integer getupdateinfo ()
public function n_bcm_ds GetView ()
public function integer performdeletes ()
public function integer performupdates ()
public function long retrieve ()
public function integer setargument (readonly any aa_argument)
public function integer setdatasource (readonly string as_datasource)
protected function integer setdbtransaction ()
protected function integer setupdateinfo (readonly integer ai_tablenum)
public function integer registerupdatetable (readonly string as_table, readonly string as_owner)
public function integer registerupdatetable (readonly string as_table)
public function integer setappend (readonly boolean ab_append)
protected function integer update (boolean ab_doinserts, boolean ab_doupdates, boolean ab_dodeletes)
protected function integer mapattribute (readonly string as_dwcolumn, readonly string as_class, readonly string as_attribute)
protected function integer mapdbcolumn (readonly string as_dwcolumn, readonly string as_table, readonly string as_column, readonly integer ai_key)
protected function integer createdatastore (readonly boolean ab_addbeoindex)
protected function integer setupdatesallowed (readonly boolean ab_inserts, readonly boolean ab_updates, readonly boolean ab_deletes)
public function integer resetupdatecount ()
public function integer save ()
protected function integer modifyclassdlk ()
public subroutine setisclassdlk (boolean ab_flag)
protected function integer modifyretrieve (string as_sql)
public subroutine setallowmultitableupdate (boolean ab_flag)
public function integer setquotes (ref any aa_argvalue[])
protected function long retrievedatastore (datastore ads_datastore, any aa_args[])
public function boolean setdlkrelation (readonly string as_dlk_relation)
protected function integer modifywhereclause ()
public function integer cleararguments ()
public function boolean defaultdlk ()
public function string getdatasource ()
public subroutine setoverrideupdateinfo (boolean ab_flag)
protected function integer setexception (readonly string as_script, readonly string as_messageid)
public function integer setexception (readonly string as_script, readonly string as_messageid, readonly string as_substitutions[])
end prototypes

event ofr_retrieve;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_retrieve
//
//	Arguments:		none
//
//	Returns:			Integer
//						>=0	# rows retrieved
//						-1		error
//
//	Description:	Retrieves data buffer. By default this ancestor script
//						will retrieve using the standard DataWindow retrieve
//						function. This event can be overridden in the descendent
//						object to retrieve the data differently.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	1.20.04	Fire events on ids_view if dynamic query in 5.0.2
//	1.20.05	Fixed previous fix to check PB version, not OS version
// 1.20.05  Allow passing of 16 arguments and call new RetrieveDataStore function.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rowcount
environment lenv
boolean lb_fireevents

GetEnvironment(lenv)
if lenv.PBMajorRevision = 5 and lenv.PBFixesRevision <= 2 and Len(is_datasource) > 40 then
	lb_fireevents = true
end if

if lb_fireevents then
	this.ids_view.event RetrieveStart()
end if

//		Insure argument array upper bound is set
// 1.20.05 - Allow 16 arguments.
if UpperBound(iany_args) < 16 then
	iany_args[17] = ''
end if


// For Class DLK
if this.ModifyClassDLK() < 0 then
	return -1
end if

// 1.20.05 Call new function that can be overridden in the descendant.
ll_rowcount = this.RetrieveDataStore(this.ids_view, iany_args[])
//

if ll_rowcount < 0 then
	this.SetException("ofr_retrieve()", "25999", {string(ll_rowcount)})
	ll_rowcount = -1
else
	if lb_fireevents then
		this.ids_view.event RetrieveEnd(this.ids_view.RowCount())
	end if
end if

return ll_rowcount

end event

event ofr_sqlpreview;call super::ofr_sqlpreview;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_sqlpreview
//
//	Returns:			Integer
//						1		Skip processing SQL statement
//						0		Process SQL statement
//						-1		error
//
//	Description:	Triggered from ofr_n_bcm_ds SQLPreview when SQL is executed.
//						Routes calls to other events.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if request = PreviewFunctionUpdate! then
	choose case sqltype
		case PreviewInsert!
			return this.Event ofr_InsertRow(anv_tran, sqlsyntax, buffer, row)
		case PreviewUpdate!
			return this.Event ofr_UpdateRow(anv_tran, sqlsyntax, buffer, row)
		case PreviewDelete!
			return this.Event ofr_DeleteRow(anv_tran, sqlsyntax, buffer, row)
	end choose
end if

return 0

end event

event ofr_deleterow;call super::ofr_deleterow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_deleterow
//
//	Returns:			Integer
//						1		Skip processing SQL statement
//						0		Process SQL statement
//						-1		error
//
//	Description:	Invoked for each row to be deleted.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return 0

end event

event ofr_insertrow;call super::ofr_insertrow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_insertrow
//
//	Returns:			Integer

//						1		Skip processing SQL statement
//						0		Process SQL statement
//						-1		error
//
//	Description:	Invoked for each row to be inserted.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return 0

end event

event ofr_updaterow;call super::ofr_updaterow;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_updaterow
//
//	Returns:			Integer
//						1		Skip processing SQL statement
//						0		Process SQL statement
//						-1		error
//
//	Description:	Invoked for each row to be updated.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return 0

end event

event ofr_update;//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ofr_update
//
//	Arguments:		ab_doinserts	Indicator as to whether to perform inserts
//						ab_doupdates	Indicator as to whether to perform updates
//						ab_dodeletes	Indicator as to whether to perform deletes
//
//	Returns:			Integer
//						1		successfully saved changes
//						-1		error
//
//	Description:	Event fired to update persistent store. By default this
//						ancestor script will use the standard PB DW Update
//						function. This script can be overridden in the descendent
//						object to perform updates differently.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Added multi-class support
// 1.0.1.2 	Fix for inherited update
//	1.0.2		BTR 6760 - add validation check
//	1.0.2		Added BCM error processing
//	1.0.2 	BTR 6784 - correct order of updates deletes then inserts/updates
//	1.2		Moved from BCM.Save to DLK.ofr_Update event
// 1.20.02 	Allow user to disable multitable update.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_i, li_tablecnt

this.ClearOFRErrors()
li_tablecnt = UpperBound(ist_upd)

//  Check to see if the GetUpdateInfo was overridden.  if not set to override 
//  then continue as normal otherwise, if it is set to override and the tablecount
//  is greater than one than disregard override setting and continue as normal to
//  allow multi-table updates to occur
if NOT ib_override_updateinfo or (ib_override_updateinfo and li_tablecnt > 1) then
	// check for first time update
	// if first time then derive update characteristics from associated dataobject
	if ib_first_update then
		// get update info
		if this.GetUpdateInfo ( ) = 1 then
			ib_first_update = false
			if li_tablecnt = 1 or ib_allow_mulitable_update = false then
				this.SetUpdateInfo(1)
			end if
		else
			this.PushException("ofr_update")
			li_rc = -1
		end if
	end if
end if

if li_rc = 1 then
	if li_tablecnt > 1 and ib_allow_mulitable_update = true then
		//	Do Deletes Bottom/Up
		if ab_dodeletes then
			this.SetUpdatesAllowed(false, false, ab_dodeletes)
			for li_i = li_tablecnt to 1 step -1
				if this.SetUpdateInfo(li_i) = 1 then
					li_rc = ids_view.Update(false, false)
					//	See if bad rc or Errors > 0
					if li_rc < 0 OR this.GetErrorCount() > 0 then
						li_rc = -1
						exit
					end if
				else
					li_rc = -1
					exit
				end if
			next
		end if
		if li_rc = 1 then
			//		Do Inserts/Updates Top/Down
			if ab_doinserts OR ab_doupdates then
				this.SetUpdatesAllowed(ab_doinserts, ab_doupdates, false)
				for li_i = 1 to li_tablecnt
					if this.SetUpdateInfo(li_i) = 1 then
						li_rc = ids_view.Update(false, false)
						//	See if bad rc or Errors > 0
						//	We check error count because PB 5.0.2 will ret 1 from update even if the update was
						//	aborted in SQLPreview with ret of 1
						if li_rc < 0 OR this.GetErrorCount() > 0 then
							li_rc = -1
							exit
						end if
					else
						li_rc = -1
						exit
					end if
				next
			end if
		end if
	else
		this.SetUpdatesAllowed(ab_doinserts, ab_doupdates, ab_dodeletes)
		li_rc = ids_view.Update(false, false)
		//	See if bad rc or Errors > 0
		//		We check error count because PB 5.0.2 will ret 1 from update even if the update was
		//		aborted in SQLPreview with ret of 1
		if li_rc < 0 OR this.GetErrorCount() > 0 then
			li_rc = -1
		end if
	end if
end if

return li_rc
end event

public function integer dberror (readonly long al_beoindex, readonly long al_sqldbcode, readonly string as_sqlerrtext, readonly string as_sql);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		dberror
//
//	Arguments:		beo_index, transaction
//
//	Returns:			1	success
//						-1	error
//
//	Description:	Adds OFR error object with DBError information
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_ofrerror lnv_ofrerror

lnv_ofrerror = this.AddOFRError()
lnv_ofrerror.SetErrorType(-1)
lnv_ofrerror.SetSQLDBCode(al_sqldbcode)
lnv_ofrerror.SetSQLErrText(as_sqlerrtext)
lnv_ofrerror.SetSQLSyntax(as_sql)
lnv_ofrerror.SetBEOIndex(al_beoindex)

return 1

end function

protected function integer getupdateinfo ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetUpdateInfo
//
//	Arguments:		None
//
//	Returns:			Integer	The number of tables required to update class.
//									This number will be greater than	one only if it
//									is a subclass and the ancestor class or classes
//									are included in the query.
//						1		Success
//						-1		Error
//
//	Description:	A function to initialize the update information	for the 
//						associated query object assigned to ids_view.  The first
//						time a Save() is	performed this function is called
//						to initialize the ist_upd[ ] instance structure for 
//						subsequent use by SetUpdateInfo(). 
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Added multi-class support
//	1.2		Moved from BCM to DLK
// 1.20.02 	If multitable update is not allowed, put all updateable columns in 1st modify.
// 2.1      Fix BTR 11516.  Saving a newly inserted row would fail if the FK of the descendant
//				is an identity column in the ancestor
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
boolean lb_match
int li_rc = 1, li_col, li_cols, li_table, li_modifytable, li_tables, li_key, li_map, li_maps, li_beo_index_col
string ls_table[], ls_column[], ls_modify, ls_col

li_cols = this.ids_view.GetColCount()
li_tables = UpperBound(ist_upd)
li_beo_index_col = ids_view.GetBEOIndexColumn()

for li_col = 1 to li_cols
	if li_col <> li_beo_index_col then
		ls_col = ' #' + string(li_col)
		this.ids_view.GetColumnDBInfo(li_col, ls_table, ls_column, li_key)
		li_maps = UpperBound(ls_column)
		for li_table = 1 to li_tables
			// If updates to multiple tables are not allowed,
			// all updateable columns must be put on the 1st table's modify statement
			// so that it will process the update regardless of which column is changed.
			if ib_allow_mulitable_update = true then
				li_modifytable = li_table
			else
				li_modifytable = 1
			end if			
			lb_match = false
			for li_map = 1 to li_maps
				if ist_upd[li_table].s_table = ls_table[li_map] then
					lb_match = true
					// Column included in update
					ist_upd[li_modifytable].s_modify = ist_upd[li_modifytable].s_modify + ls_col + '.update=yes' + ls_col +&
						".dbname='" + ist_upd[li_table].s_qualifiedtable + '.' + ls_column[li_map] + "'" + ls_col + '.key='
					// Check for key column in update
					if li_key > 0 then
						ist_upd[li_modifytable].s_modify = ist_upd[li_modifytable].s_modify + 'yes'
						// if we've got a pk/fk relationship and we're setting the descendant and it's an 
						// identity column then make the descendant column identity value = no
						if li_maps > 1 and li_modifytable > 1 and ids_view.describe(ls_col + ".identity") = 'yes' then
							ist_upd[li_modifytable - 1].s_modify = ist_upd[li_modifytable - 1].s_modify + ls_col + '.identity=yes'
							ist_upd[li_modifytable].s_modify = ist_upd[li_modifytable].s_modify + ls_col + '.identity=no'
						end if
					else
						ist_upd[li_modifytable].s_modify = ist_upd[li_modifytable].s_modify + 'no'
					end if
				end if
			next
			if lb_match = false and ib_allow_mulitable_update = true then
				// Column not included in update for this table
				ist_upd[li_table].s_modify = ist_upd[li_table].s_modify + ls_col + '.update=no' + ls_col + '.key=no'
			end if
		next
	end if
next

return li_rc

end function

public function n_bcm_ds GetView ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetView
//
//	Arguments:		none
//
//	Returns:			n_bcm_ds		View datastore
//
//	Description:	Returns view datastore
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return ids_view

end function

public function integer performdeletes ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		PerformDeletes
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		Success
//						-1		Error
//
//	Description:	Deletes all rows in deleted buffer.
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
return update(false, false, true)
end function

public function integer performupdates ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		PerformUpdates
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		Success
//						-1		Error
//
//	Description:	Performs all inserts and updates of the data in the datastore.
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
return update(true, true, false)
end function

public function long retrieve ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		none
//
//	Returns:			Long
//						>= 0		Number of rows returned by retrieve
//						< 0		error
//
//	Description:	Retrieves the DLK Datastore.
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
any lany_data[]
boolean lb_boindexadded
long ll_rowcount, ll_origrowcount
n_bcm_ds lds_view

if not IsValid(ids_view) then
	return -1
end if

ids_view.SetBCMMGR(this.GetBCMMgr())

lb_boindexadded = ids_view.IsBOIndexAdded()
if lb_boindexadded = TRUE then
	lds_view = this.ids_view
	//		Create new DS without adding BEO_Index column
	if this.CreateDataStore(FALSE) = 1 then
		if this.SetDBTransaction() <> 1 then
			this.PushException("retrieve")
			ll_rowcount = -1
		end if
	else
		this.PushException("retrieve")
		ll_rowcount = -1
	end if
else
	ids_view.SetAppend(this.ib_append)
end if

if ll_rowcount = 0 then
	ll_rowcount = this.event ofr_retrieve()
	if ll_rowcount < 0 then
		this.PushException("retrieve")
	end if
end if

if lb_boindexadded then
	// Clear the existing buffer if were not appending
	if this.ib_append = false then
		lds_view.Reset()
	end if
	ll_origrowcount = lds_view.RowCount()
	if ll_rowcount > 0 then
		lany_data = this.ids_view.object.data
		lds_view.object.data[ll_origrowcount + 1, 1, ll_rowcount + ll_origrowcount, ids_view.GetColCount()] = lany_data
	end if
	destroy this.ids_view
	this.ids_view = lds_view
	this.ids_view.InitBEOIndex(ll_rowcount)
	this.ids_view.SetOriginalBuffer()
	ll_rowcount = ll_rowcount + ll_origrowcount
end if

return ll_rowcount

end function

public function integer setargument (readonly any aa_argument);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetArgument
//
//	Arguments:		aa_argument				Retrieve argument
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Saves retrieval argument
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
int li_arg

li_arg = UpperBound(iany_args) + 1
iany_args[li_arg] = aa_argument

return 1

end function

public function integer setdatasource (readonly string as_datasource);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDataSource
//
//	Arguments:		as_datasource	DataWindow object name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets datasource DataWindow object to be used by DLK
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 2.1 	Conditional beo index creation set on call to CreateDataStore
// 2.1   Remove dlk pointer on datastore
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_viewcol

is_datasource = as_datasource

if not IsValid(ids_view) then
	if this.CreateDataStore(TRUE) <> 1 then
		this.PushException("setdatasource")
		li_rc = -1
	end if
end if

if li_rc = 1 then
	if this.SetDBTransaction() <> 1 then
		this.PushException("setdatasource")
		li_rc = -1
	end if
end if

return li_rc

end function

protected function integer setdbtransaction ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDBTransaction
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets database transaction object
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

if IsValid(itrx_view) then
	if itrx_view.DBHandle() <> 0 then
		return ids_view.SetTrans(itrx_view)
	end if
end if

return ids_view.SetTrans(SQLCA)


end function

protected function integer setupdateinfo (readonly integer ai_tablenum);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUpdateInfo
//
//	Arguments:		ai_tablenum		Sets the DW update characteristics for
//											updating the specified table index.
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Modifies the Datastore update characteristics for
//						updating the specified table.
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
int li_i, li_rc
string ls_err

// verify that a valid element position was passed in.
if ( ai_tablenum <= 0 ) OR ( ai_tablenum > UpperBound(ist_upd) ) then return -1

// reset update table
this.ids_view.object.datawindow.table.updatetable = ist_upd[ai_tablenum].s_qualifiedtable

ls_err = this.ids_view.Modify (ist_upd[ai_tablenum].s_modify)
if ls_err = '' then
	li_rc = 1
else
	this.SetException("setupdateinfo", "25997", {ls_err})
	li_rc = -1
end if

return li_rc
end function

public function integer registerupdatetable (readonly string as_table, readonly string as_owner);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterUpdateTable
//
//	Arguments:		as_table		Table name
//						as_owner		Table owner name
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers updateable table for this datasource.
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
int li_table, li_tables

li_tables = UpperBound(ist_upd)
for li_table = 1 to li_tables
	if ist_upd[li_table].s_table = as_table and &
		ist_upd[li_table].s_owner = as_owner then
		return 1
	end if
next
li_tables ++
ist_upd[li_tables].s_table = as_table
ist_upd[li_tables].s_owner = as_owner
if as_owner <> '' then
	ist_upd[li_tables].s_qualifiedtable = as_owner + "." + as_table
else
	ist_upd[li_tables].s_qualifiedtable = as_table
end if

return 1

end function

public function integer registerupdatetable (readonly string as_table);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterUpdateTable
//
//	Arguments:		as_table		Table name
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers updateable table for this datasource.
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
return this.RegisterUpdateTable(as_table, "")

end function

public function integer setappend (readonly boolean ab_append);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetAppend
//
//	Arguments:		ab_append		Append indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets indicator as to whether result set should be appended
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
this.ib_append = ab_append

return 1

end function

protected function integer update (boolean ab_doinserts, boolean ab_doupdates, boolean ab_dodeletes);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		update
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		successfully saved changes
//						-1		error
//
//	Description:	Private function called from save, performdeletes, performupdates.
//						Copied from BCM save.
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
int li_rc

li_rc = this.event ofr_Update(ab_doinserts, ab_doupdates, ab_dodeletes)

return li_rc
end function

protected function integer mapattribute (readonly string as_dwcolumn, readonly string as_class, readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapAttribute
//
//	Arguments:		ai_column		Column number
//						as_class			Class name
//						as_attribute	Attribute name
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers updateable table for this datasource.
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

li_col = Integer(this.ids_view.Describe(as_dwcolumn + ".id"))

if li_col > 0 then
	if this.ids_view.RegisterColumn(li_col, as_class, as_attribute) <> 1 then
		this.PushException("registercolumn")
		li_rc = -1
	end if
else
	this.PushException("registercolumn")
	li_rc = -1
end if

return li_rc

end function

protected function integer mapdbcolumn (readonly string as_dwcolumn, readonly string as_table, readonly string as_column, readonly integer ai_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapDBColumn
//
//	Arguments:		ai_column		Column number
//						as_table			Database table
//						as_column		Database column
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Maps datasource column to a table/column.
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
int li_rc = -1, li_col

li_col = Integer(this.ids_view.Describe(as_dwcolumn + ".id"))

if li_col > 0 then
	li_rc = this.ids_view.MapColumn(li_col, as_table, as_column, ai_key)
end if

return li_rc

end function

protected function integer createdatastore (readonly boolean ab_addbeoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateDataStore
//
//	Arguments:		ab_addbeoindex	Whether to add BEO_Index if missing
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Creates the datastore
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 2.1   Add dlk pointer on datastore
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1
string ls_error
powerobject po_temp

this.ids_view = create n_bcm_ds
ids_view.SetBCMMGR(this.GetBCMMgr())

//		Initialize DLK pointer on the datastore
po_temp = this
ids_view.SetRequestor(po_temp)

li_rc = this.ids_view.SetDataObject(is_datasource, ab_addbeoindex)

return li_rc

end function

protected function integer setupdatesallowed (readonly boolean ab_inserts, readonly boolean ab_updates, readonly boolean ab_deletes);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUpdatesAllowed
//
//	Arguments:		ab_inserts	Boolean indicating if inserts allowed
//						ab_updates	Boolean indicating if updates allowed
//						ab_deletes	Boolean indicating if deletes allowed
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	This function allows the restricting of which types
//						of database SQL is used when updating the BCM Datastore.
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
int li_rc = 1

if this.ids_view.SetUpdatesAllowed(ab_inserts, ab_updates, ab_deletes) <> 1 then
	li_rc = -1
end if

return li_rc

end function

public function integer resetupdatecount ();integer li_rc = -1

if Isvalid(ids_view) then
	li_rc = ids_view.ResetUpdateCount()
end if

RETURN li_rc
end function

public function integer save ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		save
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		successfully saved changes
//						-1		error
//
//	Description:	Updates BCM_DS
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
return this.Update(true, true, true)

end function

protected function integer modifyclassdlk ();// Description:  This function should only be called from ofr_retrieve just before
//						performing the retrieve.  If this is a Class or Default DLK,
//						this function will modify the WHERE clause of the query to 
//						retrieve the correct set of rows.


if ib_isclassquery = FALSE or UpperBound(iany_args) = 0 then
	return 0
end if

if is_dlk_relation = "" and (IsNull(iany_args[1]) or ClassName(iany_args[1]) = "any") then
	// This is a request to retrieve all rows so no modification is required.
	return 1
end if

return this.ModifyWhereClause()


end function

public subroutine setisclassdlk (boolean ab_flag);// Class DLK

ib_isclassquery = ab_flag
end subroutine

protected function integer modifyretrieve (string as_sql);// Replace the SQL of the DataStore with this SQL.

// Class DLK

string ls_syntax, ls_errors
integer li_pos1, li_pos2, li_rc

ls_syntax = ids_view.describe("datawindow.syntax")

li_pos1 = Pos(Lower(ls_syntax), "retrieve =")

if li_pos1 <= 0 then
	li_pos1 = Pos(Lower(ls_syntax), "retrieve=")
end if

if li_pos1 <= 0 then return -1

li_pos2 = Pos(ls_syntax, "~r~n", li_pos1)

if li_pos2 <= 0 then return -1

ls_syntax = Replace(ls_syntax, li_pos1, li_pos2 - li_pos1, as_sql)

li_rc = ids_view.Create(ls_syntax, ls_errors)
if li_rc = 1 then
	this.SetDBTransaction()
end if

return li_rc
end function

public subroutine setallowmultitableupdate (boolean ab_flag);//
//	Function:		SetAllowMultitableUpdate
//
//	Arguments:		ab_flag	Whether a multitable update can be done
//
//	Description:	Called by descendant to indicate that only one update
//						should be done even if multiple tables need to be updated.
//						Typically used by people using stored procedures which already
//						handle the multi-table update.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.20.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

ib_allow_mulitable_update = ab_flag
end subroutine

public function integer setquotes (ref any aa_argvalue[]);string ls_class
any la_newval
integer li_loop, li_end

li_end = UpperBound(aa_argvalue)

if li_end = 0 then
	aa_argvalue[1] = ""
	li_end = 1
end if

for li_loop = 1 to li_end
	ls_class = ClassName(aa_argvalue[li_loop])
	la_newval = aa_argvalue[li_loop]
	Choose Case ls_class	
		Case 'string','date', 'datetime', 'time', 'char'
			aa_argvalue[li_loop] = "~'" + string(la_newval) + "~'"
	End Choose
next

return 1
end function

protected function long retrievedatastore (datastore ads_datastore, any aa_args[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RetrieveDataStore
//
//	Arguments:		ads_datastore - The datastore.
//						aa_args[] - The argument array.
//
//	Returns:			Long, Rows retrieved.
//
//	Description:	Performs the retrieve of the datastore.  
//						Called from ofr_retrieve event.
//						This function can be overridden in the descendant to 
//						do special retrieves or to handle nulls arguments.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2.5	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return ads_datastore.Retrieve(aa_args[1], aa_args[2], aa_args[3], aa_args[4], aa_args[5], aa_args[6], aa_args[7], aa_args[8], aa_args[9], aa_args[10], aa_args[11], aa_args[12], aa_args[13], aa_args[14], aa_args[15], aa_args[16])

end function

public function boolean setdlkrelation (readonly string as_dlk_relation);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDLKRelation	
//
//	Arguments:		as_dlk_relation Source relationship used by DLK to modify where clause
//
//	Returns:			Boolean
//
//	Description:	For class dlk - sets relationship to modify the where clause
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
is_dlk_relation = as_dlk_relation

return true
end function

protected function integer modifywhereclause ();// Class DLK

return 0
end function

public function integer cleararguments ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearArguments
//
//	Arguments:		None
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears the argument array (iany_args[] ) 
//						FOR INTERNAL USE ONLY
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
integer li_rc = 1
any la_init[]

iany_args = la_init

if UpperBound(iany_args) > 0 then
	li_rc = -1
end if

return li_rc
end function

public function boolean defaultdlk ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DefaultDLK
//
//	Arguments:		None
//
//	Returns:			Boolean
//						true		Default DLK
//						false 	Specified DLK
//
//	Description:	Will determine if the dlk is based on the default or a specific
//						dlk.
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

boolean lb_rtn

if this.ClassName() = this.GetBCMMGR().GetDLKPrefix() then
	lb_rtn = true
end if

return lb_rtn

end function

public function string getdatasource ();return is_datasource
end function

public subroutine setoverrideupdateinfo (boolean ab_flag);ib_override_updateinfo = ab_flag
end subroutine

protected function integer setexception (readonly string as_script, readonly string as_messageid);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetException
//
//	Arguments:		as_script		Name of script the error occurred in
//						as_messageid	Error number of exception
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Records exception (use as pass through function to
//						ofr_n_cst_base)
//						INTERNAL USE ONLY
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

return super::SetException(as_script, as_messageid)


end function

public function integer setexception (readonly string as_script, readonly string as_messageid, readonly string as_substitutions[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetException
//
//	Arguments:		as_script				Name of script the error occurred in
//						as_messageid			Error number of exception
//						as_substitutions[]	Array of substitution values for
//													the error message
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Records exception (use as pass through function to
//						ofr_n_cst_base)
//						FOR INTERNAL USE ONLY
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

return super::SetException(as_script, as_messageid, as_substitutions)
end function

on ofr_n_cst_dlk.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_dlk.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			constructor
//
//	Description:	Occurs when object created
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
// 2.00		Also pass in BCM.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_dlk_init lnv_dlk_init
long ll_rc

lnv_dlk_init = Message.PowerObjectParm

//		The view may already exist if we are in C/S mode and we are
//		retrieving a second time.
this.ids_view = lnv_dlk_init.ids_view
//		Grab transaction object
itrx_view = lnv_dlk_init.itrx_view
inv_bcm = lnv_dlk_init.inv_bcm

return ll_rc

end event

