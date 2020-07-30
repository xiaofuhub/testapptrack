$PBExportHeader$ofr_n_bcm_ds.sru
forward
global type ofr_n_bcm_ds from datastore
end type
end forward

global type ofr_n_bcm_ds from datastore
end type
global ofr_n_bcm_ds ofr_n_bcm_ds

type variables
protected:

constant string isc_beo_index = "beo_index"
int ii_beo_index_col

blob iblb_origstate
string is_originalbuffer

boolean ib_allow_inserts = TRUE
boolean ib_allow_updates = TRUE
boolean ib_allow_deletes = TRUE

boolean ib_skip_dberror = FALSE
boolean ib_append, ib_boindexadded

boolean ib_identitycolumn
boolean ib_datachangedduringupdate

int ii_cols

// next availabel beo index.
long il_next_beo_index
// number of rows retrieved
long il_startingrowcount, il_retrieved
// number of rows update
long il_updated, il_inserted, il_deleted

n_cst_dlk inv_dlk

ofr_s_bcm_ds_datacol istr_col[]

transaction inv_tran

boolean ib_useofrgetfullstate = false
n_cst_bcmmgr  inv_bcmmgr
end variables

forward prototypes
public function integer createsyntax (readonly string as_colname[], readonly string as_datatype[], ref string as_syntax)
public function integer disabledddw ()
public function integer getattribute (readonly integer ai_viewcol, ref string as_class, ref string as_attribute)
public function integer getattribute (readonly string as_table, readonly string as_column, ref string as_class, ref string as_attribute)
public function integer getattribute (readonly string as_viewcol, ref string as_class, ref string as_attribute)
public function long getbeoindex (readonly long al_row)
public function long getbeoindexdata (ref any aa_columndata[])
public function string getcoltype (integer ai_viewcol)
public function integer getcolumndbinfo (readonly integer ai_column, ref string as_table[], ref string as_column[], ref integer ai_key)
protected function integer getdbtablecolumn (readonly string as_dbname, ref string as_dbtable, ref string as_dbcolumn)
public function boolean getdeletesallowed ()
public function boolean getinsertsallowed ()
public function boolean getupdatesallowed ()
public function integer getviewcol (readonly string as_class, readonly string as_attribute)
public function integer mapattribute (readonly string as_class, readonly string as_attribute, readonly string as_table, readonly string as_column, readonly integer ai_key)
public function integer mapcolumn (readonly integer ai_column, readonly string as_table, readonly string as_column, readonly integer ai_key)
public function integer mapdbname (readonly string as_class, readonly string as_attribute, readonly string as_table, readonly string as_column)
public function integer registercolumn (readonly integer ai_column, readonly string as_class, readonly string as_attribute)
public function integer setnextbeoindex (readonly long al_next_beo_index)
public function integer setoriginalbuffer ()
public function integer setrequestor (readonly n_cst_dlk anv_dlk)
public function integer settrans (transaction t)
public function integer setupdatesallowed (readonly boolean ab_inserts, readonly boolean ab_updates, readonly boolean ab_deletes)
public function integer deserialize (readonly s_bcmreference astr_ds)
public function s_bcmreference serialize ()
public function long getdata (readonly string as_colname[], readonly string as_datatype[], readonly long al_beoindex, ref any aa_data[])
public function long getretrieveddata (readonly string as_colname[], readonly string as_datatype[], ref any aa_data[])
public function integer getupdatecount (ref long al_updated, ref long al_inserted, ref long al_deleted)
public function long initbeoindex (readonly long al_rows)
public function integer setappend (readonly boolean ab_append)
public function boolean isboindexadded ()
public function integer updatespending ()
public function n_bcm_ds copy ()
public function integer getbeoindexcolumn ()
protected function integer addbeoindex ()
public function integer setdataobject (readonly string as_dataobject, readonly boolean ab_addbeoindex)
public function integer setdatachangedduringupdate (readonly boolean ab_changed)
public function boolean hasdatachangedduringupdate ()
public function integer resetupdatecount ()
public function integer serialize (ref blob ablb_view)
public function integer deserialize (readonly blob ablb_view)
public function integer resetupdate ()
public function integer mapdbname (integer ai_classindex, string as_attribute, string as_table, string as_column)
protected function integer setfullstateofr (readonly blob ablb_dw)
public function integer reset ()
public function long getbeoindex (long al_row, dwbuffer adwb_buffer)
public function long insertrow (long al_row)
public function long append (readonly n_bcm_ds ads_view_new)
public function long getmaxindex (long al_rowstart, long al_rowend)
protected function integer getfullstateofr (ref blob ablb_dw, long al_len)
public subroutine setbcmmgr (readonly nonvisualobject anv_bcmmgr)
public function integer getcolcount ()
public subroutine getcols (ref ofr_s_bcm_ds_datacol astr_col[])
public function long getnextindex ()
public function long setbeoindexforrow (long al_row)
public function boolean ispbrowidon ()
public function long getbeorow (long al_beoindex)
end prototypes

public function integer createsyntax (readonly string as_colname[], readonly string as_datatype[], ref string as_syntax);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateSyntax
//
//	Arguments:		as_colname[]	Array of column names
//						as_datatype[]	Array of column datatypes
//						as_syntax		Reference: returned DW syntax
//
//	Returns:			Integer			1 Sucess
//											-1 error
//
//	Description:	Returns syntax for DW based on specified columns.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2		Initial version
// 2.1 		Determine release at runtime.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_col, li_cols
string ls_datatype
environment lenv

GetEnvironment(lenv)

as_syntax = 'release ' + string(lenv.PBMajorRevision) + '; datawindow(units=0 timer_interval=0 color=16777215 processing=0 print.documentname=""  print.orientation=0 print.margin.left=110 print.margin.right=110 print.margin.top=97 print.margin.bottom=97 print.paper.source=0 print.paper.size=0 selected.mouse=no) header(height=1 color="536870912" ) summary(height=1 color="536870912" ) footer(height=1 color="536870912" ) detail(height=1 color="536870912" ) table('

li_cols = UpperBound(as_colname)
for li_col = 1 to li_cols
	as_syntax = as_syntax + 'column=(type=' + as_datatype[li_col] + &
		' update=yes updatewhereclause=yes key=yes name=' + as_colname[li_col] + ' dbname="" ) '
next

as_syntax = as_syntax + 'update="x" updatewhere=0 updatekeyinplace=no )'

return li_rc

end function

public function integer disabledddw ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DisableDDDW
//
//	Arguments:		None
//
//	Returns:			Integer
//						1			Success
//						-1			Error
//
//	Description:	Disables DDDW's to prevent them from retrieving
//						FOR INTERNAL USE ONLY
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
int li_col, li_cols
string ls_col
datawindowchild ldwc_dddw

//	Prevent DDDW from retrieving by inserting dummy row
li_cols = this.GetColCount()
for li_col = 1 to li_cols
	if this.Describe("#" + string(li_col) + ".edit.style") = 'dddw' then
		ls_col = this.Describe("#" + string(li_col) + ".name")
		if this.GetChild(ls_col, ldwc_dddw) = 1 then
			ldwc_dddw.InsertRow(0)
		end if
	end if
next

return 1

end function

public function integer getattribute (readonly integer ai_viewcol, ref string as_class, ref string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		ai_viewcol		View column number
//						as_class			reference: returned class name
//						as_attribute	reference: returned attribute name
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Returns class/attribute for specified view column
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

if ai_viewcol <= this.GetColCount() then
	if istr_col[ai_viewcol].s_class <> '' then
		as_class = istr_col[ai_viewcol].s_class
		as_attribute = istr_col[ai_viewcol].s_attribute
		li_rc = 1
	else
		as_class = ''
		as_attribute = ''
		li_rc = 0
	end if
else
	as_class = ''
	as_attribute = ''
	li_rc = -1
end if

return li_rc

end function

public function integer getattribute (readonly string as_table, readonly string as_column, ref string as_class, ref string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		as_table			database table name
//						as_column		database column name
//						as_class			reference: returned class name
//						as_attribute	reference: returned attribute name
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Returns class/attribute for specified table/column
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
int li_rc = -1, li_col, li_cols, li_colmap, li_colmaps

li_cols = this.GetColCount()
for li_col = 1 to li_cols
	li_colmaps = UpperBound(istr_col[li_col].colmap)
	for li_colmap = 1 to li_colmaps
		if as_column = istr_col[li_col].colmap[li_colmap].s_column then
			if as_table = istr_col[li_col].colmap[li_colmap].s_table then
				as_class = istr_col[li_col].s_class
				as_attribute = istr_col[li_col].s_attribute
				return 1
			end if
		end if
	next
next

return li_rc

end function

public function integer getattribute (readonly string as_viewcol, ref string as_class, ref string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		as_viewcol		View column name
//						as_class			reference: returned class name
//						as_attribute	reference: returned attribute name
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Returns class/attribute for specified view column
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
int li_rc, li_viewcol

li_viewcol = integer(this.describe(as_viewcol + ".id"))
if li_viewcol > 0 then
	li_rc = this.GetAttribute(li_viewcol, as_class, as_attribute)
else
	li_rc = -1
end if

return li_rc

end function

public function long getbeoindex (readonly long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		al_row	View row number
//
//	Returns:			long
//						>= 0		BEO_Index number
//						-1			Error
//
//	Description:	Returns beoindex for specified view row
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
return this.GetBEOIndex(al_row, Primary!)

end function

public function long getbeoindexdata (ref any aa_columndata[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndexData
//
//	Arguments:		aa_columndata[]	reference: returned beoindex data
//
//	Returns:			long
//						>= 0		Number of rows returned
//						-1			Error
//
//	Description:	Returns beoindex data
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 2.1 	Use pb function GetRowIDFromRow if indicator is on
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rows, ll_row

ll_rows = this.RowCount()
if ll_rows > 0 then
	if this.IsPBRowIDOn() then
		for ll_row = 1 to ll_rows
			aa_columndata[ll_row] = this.dynamic GetRowIDFromRow(ll_row)
		next
	else
		aa_columndata = this.Object.Data[1, ii_beo_index_col, ll_rows, ii_beo_index_col]
	end if
end if

return ll_rows

end function

public function string getcoltype (integer ai_viewcol);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetColType
//
//	Arguments:		ai_viewcol		Column in view
//
//	Returns:			string			DW column type
//
//	Description:	Returns DW column type for specified view column
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
return this.describe('#' + string(ai_viewcol) + ".coltype")

end function

public function integer getcolumndbinfo (readonly integer ai_column, ref string as_table[], ref string as_column[], ref integer ai_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetColumnDBInfo
//
//	Arguments:		ai_column		column number
//						as_table[]		reference: db table name
//						as_column[]		reference: db column name
//						ai_key			reference: key info
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Returns database info for specified column
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
int li_rc = -1, li_col, li_cols
string ls_table[], ls_column[]

if ai_column >= LowerBound(istr_col) and ai_column <= this.GetColCount() then
	li_cols = UpperBound(istr_col[ai_column].colmap)
	if li_cols > 0 then
		for li_col = 1 to li_cols
			ls_table[li_col] = istr_col[ai_column].colmap[li_col].s_table
			ls_column[li_col] = istr_col[ai_column].colmap[li_col].s_column
		next
		ai_key = istr_col[ai_column].colmap[1].i_key
	end if
	li_rc = 1
end if

as_table = ls_table
as_column = ls_column

return li_rc

end function

protected function integer getdbtablecolumn (readonly string as_dbname, ref string as_dbtable, ref string as_dbcolumn);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDBTableColumn
//
//	Arguments:		as_dbname	DBName to parse
//						as_dbtable	Reference - parsed table name
//						as_dbcolumn	Reference - parsed column name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Parses dbname into table and column
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Move to BDM
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1
int li_pos

li_pos = Pos(as_dbname, '.')
if li_pos > 0 then
	as_dbtable = Left(as_dbname, li_pos - 1)
else
	as_dbtable = ''
end if
as_dbcolumn = Mid(as_dbname, li_pos + 1)
li_rc = 1

return li_rc

end function

public function boolean getdeletesallowed ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDeletesAllowed
//
//	Arguments:		None
//
//	Returns:			Boolean
//						TRUE		Deletes are performed during update
//						FALSE		Deletes are not performed during update
//
//	Description:	Returns indicator of whether deletes are allowed
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
return ib_allow_deletes

end function

public function boolean getinsertsallowed ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetInsertsAllowed
//
//	Arguments:		None
//
//	Returns:			Boolean
//						TRUE		Inserts are performed during update
//						FALSE		Inserts are not performed during update
//
//	Description:	Returns indicator of whether inserts are allowed
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
return ib_allow_inserts

end function

public function boolean getupdatesallowed ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetUpdatesAllowed
//
//	Arguments:		None
//
//	Returns:			Boolean
//						TRUE		Updates are performed during update
//						FALSE		Updates are not performed during update
//
//	Description:	Returns indicator of whether deletes are allowed
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
return ib_allow_updates

end function

public function integer getviewcol (readonly string as_class, readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetViewCol
//
//	Arguments:		as_class				class name
//						as_attribute		attribute name
//
//	Returns:			Integer
//						> 0		Column number
//						-1			Error
//
//	Description:	Returns view column number for specified class/attribute
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
int li_rc = -1, li_col, li_cols

if as_attribute <> "" then
	li_cols = this.GetColCount()
	for li_col = 1 to li_cols
		if as_attribute = istr_col[li_col].s_attribute then
			if as_class = istr_col[li_col].s_class then
				li_rc = li_col
				exit
			end if
		end if
	next
end if

return li_rc

end function

public function integer mapattribute (readonly string as_class, readonly string as_attribute, readonly string as_table, readonly string as_column, readonly integer ai_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapAttribute
//
//	Arguments:		as_class			class name
//						as_attribute	attribute name
//						as_table			database table name
//						as_column		database column name
//						ai_key			key info
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Maps an attribute to it's table/column
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
int li_rc = -1, li_col, li_colmap, li_colmaps
string ls_column, ls_table

li_col = this.GetViewCol(as_class, as_attribute)
if li_col > 0 then
	li_rc = this.MapColumn(li_col, as_table, as_column, ai_key)
end if

return li_rc

end function

public function integer mapcolumn (readonly integer ai_column, readonly string as_table, readonly string as_column, readonly integer ai_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapColumn
//
//	Arguments:		ai_column				Column number
//						as_table					Database table name
//						as_column				Database column name
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Register column mapping info
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//	2.10	If table name is not set, set it. BTR# 11905
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_colmap, li_colmaps

li_colmaps = UpperBound(istr_col[ai_column].colmap)
for li_colmap = 1 to li_colmaps
	if lower(istr_col[ai_column].colmap[li_colmap].s_column) = lower(as_column) then
//		btr# 11905
//		if lower(istr_col[ai_column].colmap[li_colmap].s_table) = lower(as_table) then
		if istr_col[ai_column].colmap[li_colmap].s_table = "" then
			istr_col[ai_column].colmap[li_colmap].s_table = as_table
			istr_col[ai_column].colmap[li_colmap].s_column = as_column
			istr_col[ai_column].colmap[li_colmap].i_key = ai_key
			return 1
		end if
	end if
next

li_colmaps++
istr_col[ai_column].colmap[li_colmaps].s_table = as_table
istr_col[ai_column].colmap[li_colmaps].s_column = as_column
istr_col[ai_column].colmap[li_colmaps].i_key = ai_key

return 1

end function

public function integer mapdbname (readonly string as_class, readonly string as_attribute, readonly string as_table, readonly string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapDBName
//
//	Arguments:		as_class			class name
//						as_attribute	attribute name
//						as_table			database table name
//						as_column		database column name
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Identifies attributes via dbname information
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
int li_rc = -1, li_col, li_cols, li_colmap, li_colmaps
string ls_column, ls_table

ls_table = lower(as_table)
ls_column = lower(as_column)
li_cols = this.GetColCount()

for li_col = 1 to li_cols
	li_colmaps = UpperBound(istr_col[li_col].colmap)
	for li_colmap = 1 to li_colmaps
		if ls_column = lower(istr_col[li_col].colmap[li_colmap].s_column) then
//			if ls_table = lower(istr_col[li_col].colmap[li_colmap].s_table) then
				this.RegisterColumn(li_col, as_class, as_attribute)
				return 1
//			end if
		end if
	next
next

return li_rc

end function

public function integer registercolumn (readonly integer ai_column, readonly string as_class, readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterColumn
//
//	Arguments:		ai_column				Column number
//						as_class					class name
//						as_attribute			attribute name
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Register column info
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
istr_col[ai_column].s_class = as_class
istr_col[ai_column].s_attribute = as_attribute

return 1

end function

public function integer setnextbeoindex (readonly long al_next_beo_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetNextBEOIndex
//
//	Arguments:		al_next_beo_index	Next BEO index
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Sets next BEO Index value
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
il_next_beo_index = al_next_beo_index

return 1

end function

public function integer setoriginalbuffer ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetOriginalBuffer
//
//	Arguments:		None
//
//	Returns:			1	Success
//						-1	Error
//
//	Description:	Saves original copy of DS
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2		Original version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
any la_buffer[]
environment lenv

/*
**  We need to update this code to conditionally handle PB5 or PB6
**  instead of keeping two copies of the originalbuffer.  Once we 
**  remove the comments below we need to update Serialize and Deserialize
**  on bcm_ds to also conditionally check what PB version we are running
**  and then either load the structure form either the blob (PB6) or the 
**  buffer array (PB5) (MP)
*/

GetEnvironment(lenv)

if lenv.PBMajorRevision >= 6  then
	if this.RowCount() > 0 then
		if ib_useofrgetfullstate then
			is_originalbuffer = this.describe('datawindow.data')
		else
			this.dynamic GetFullState(iblb_origstate)
		end if
	else
		if ib_useofrgetfullstate then
			is_originalbuffer = ""
		else
			iblb_origstate = blob('')
		end if
	end if
else
	if this.RowCount() > 0 then
		is_originalbuffer = this.Describe("datawindow.data")
	else
		is_originalbuffer = ""
	end if

end if

return 1

end function

public function integer setrequestor (readonly n_cst_dlk anv_dlk);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRequestor
//
//	Arguments:		anv_dlk		BDM that created this DS
//
//	Returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Identifies the owning BDM
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
inv_dlk = anv_dlk

return 1

end function

public function integer settrans (transaction t);//
//	Function:		SetTrans
//
//	Arguments:		anv_tran - the transaction object
//
//	Returns:			Integer
//						1			Success
//						-1			Error
//
//	Description:	Sets transaction object for datastore to use
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

inv_tran = t

return this.SetTransObject(inv_tran)
end function

public function integer setupdatesallowed (readonly boolean ab_inserts, readonly boolean ab_updates, readonly boolean ab_deletes);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUpdatesAllowed
//
//	Arguments:		ab_inserts	Boolean indicating if SQL inserts are performed
//										during updates
//						ab_updates	Boolean indicating if SQL updates are performed
//										during updates
//						ab_deletes	Boolean indicating if SQL deletes are performed
//										during updates
//
//	Returns:			Integer
//						1			Success
//						-1			Error
//
//	Description:	Sets update indicators as to what types of SQL update
//						statements are allowed.
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
ib_allow_inserts = ab_inserts
ib_allow_updates = ab_updates
ib_allow_deletes = ab_deletes

return 1

end function

public function integer deserialize (readonly s_bcmreference astr_ds);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deserialize
//
//	Arguments:		ablb_view		Structure to deserialize
//
//	Returns:			Integer		1	Success
//										-1	Failure
//
//	Description:	Recreates view from passed structure
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2		Initial version
// 2.1		Modified to use pb functions SetFullState and SetChanges
// 2.1      Fix for setting proper status on inserted rows. BTR #11456
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

int li_rc = 1, li_col, li_colmap, li_colmaps
long ll_row, ll_rows, ll_index, ll_beorow, ll_newrow
string ls_syntax, ls_error
environment lenv

ii_cols = UpperBound(astr_ds.s_col_class)
ii_beo_index_col = astr_ds.i_beoindexcolumn
//		Copy metadata
for li_col = 1 to ii_cols
	istr_col[li_col].s_colname = astr_ds.s_col_name[li_col]
	istr_col[li_col].s_class = astr_ds.s_col_class[li_col]
	istr_col[li_col].s_attribute = astr_ds.s_col_attribute[li_col]
	istr_col[li_col].s_datatype = astr_ds.s_col_datatype[li_col]
	for li_colmap = 1 to astr_ds.i_colmaps[li_col]
		li_colmaps++
		istr_col[li_col].colmap[li_colmap].s_table = astr_ds.s_col_table[li_colmaps]
		istr_col[li_col].colmap[li_colmap].s_column = astr_ds.s_col_column[li_colmaps]
		istr_col[li_col].colmap[li_colmap].i_key = astr_ds.i_col_key[li_colmaps]
	next
next

//		Create syntax from scratch if no dataobject is set.
//		This can happen if BEOM creates ds instead of BDM.
//		See BEOM.Deserialize() for more information.
if this.DataObject = "" then
	if this.Create(astr_ds.s_dwsyntax, ls_error) <> 1 then
		if isValid(inv_dlk) then
			inv_dlk.SetException("ofr_n_bcm_ds::deserialize", "27991", {ls_error})
		end if
		return -1
	end if
	this.Modify("datawindow.table.updatekeyinplace=yes")
end if

GetEnvironment(lenv)

if lenv.PBMajorRevision >= 6  then
	if ib_useofrgetfullstate then
		this.SetFullStateOFR(astr_ds.blb_originalbuffer)
		this.ResetUpdate()
	else
		this.dynamic SetFullState(astr_ds.blb_originalbuffer)
		this.ResetUpdate()
	end if
else
	is_originalbuffer = astr_ds.s_originalbuffer 
	this.ImportString(is_originalbuffer)
	this.ResetUpdate()
end if

if lenv.PBMajorRevision >= 6  then
	if len(astr_ds.blb_changes) > 0 then
		li_rc = this.dynamic SetChanges(astr_ds.blb_changes)
	end if
   il_retrieved = this.RowCount()
else
//		Copy the data and status information
	ll_rows = UpperBound(astr_ds.i_rowstatus)
	if ll_rows > 0 then
		for ll_row = 1 to ll_rows
			if astr_ds.i_rowstatus[ll_row] = 0 then
				this.SetItemStatus(ll_row, 0, Primary!, DataModified!)
				this.SetItemStatus(ll_row, 0, Primary!, NotModified!)
			else
				//		New row
				if astr_ds.i_rowstatus[ll_row] = 1 then
					ll_NewRow = this.InsertRow(0)
				else
					//		New modified row
					if astr_ds.i_rowstatus[ll_row] = 2 then
						ll_NewRow = this.InsertRow(0)
						this.SetItemStatus(ll_NewRow, 0, Primary!, NewModified!)
					else
						//		Modified row
						this.SetItemStatus(ll_row, 0, Primary!, DataModified!)
						ll_NewRow = ll_row
					end if
				end if
				// 1.20.05 - Set values even if the row is new.
				// This will set the BEOIndex.
				for li_col = 1 to ii_cols
					ll_index = (ll_row - 1) * ii_cols + li_col
					if astr_ds.b_colstatus[ll_index] then
						this.Object.Data.Primary.Current[ll_NewRow, li_col] = &
						astr_ds.a_coldata[ll_index]
					end if
				next
				//	1.20.05 - Set status back to New!
				if astr_ds.i_rowstatus[ll_row] = 1 then
					this.SetItemStatus(ll_NewRow, 0, Primary!, NotModified!)
				end if
				//
			end if
		next
	end if

	//		Set number of rows retrieved to totals rows in buffer
	this.il_retrieved = ll_rows

	//		Copy deleted rows and status information
	ll_rows = UpperBound(astr_ds.i_delrowstatus)
	if ll_rows > 0 then
	//cant use buffers to move data - datawindow updates don't work
	//	this.Object.Data.Delete.Original = astr_ds.a_deletedbuffer
   	for ll_row = 1 to ll_rows
//			if IsPBRowIDOn() then
//				ll_beorow = this.dynamic GetRowFromRowID(astr_ds.i_delrowstatus[ll_row], Primary!)
//				if ll_beorow = -1 then //Hack around PB Bug!
//					ll_beorow = this.dynamic GetRowFromRowID(astr_ds.i_delrowstatus[ll_row], Delete!)
//				end if
//			else
				ll_beorow = this.Find( "#" + String(ii_beo_index_col) + " = " + String(astr_ds.i_delrowstatus[ll_row]), 1, this.RowCount())
//			end if		
			if ll_beorow > 0 then
				li_rc = this.DeleteRow(ll_beorow)
			end if
		next
	end if
end if
this.il_next_beo_index = astr_ds.l_next_beo_index

if li_rc = 0 then
   li_rc = 1
end if

return li_rc

end function

public function s_bcmreference serialize ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Serialize
//
//	Arguments:		None
//
//	Returns:			n_bcm_ds		Copied DataStore
//
//	Description:	Returns copy of BEOM DataStore
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2		Initial version
// 2.1      Updated to use pb functions GetFullState and GetChanges
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ofr_n_bcm_ds lnv_copy
int li_rc = 1, li_col, li_cols, li_colmap, li_colmaps
long ll_row, ll_rows, ll_index
dwitemstatus ldwis_status
s_bcmreference lstr_ds
any lany_buffer[]
environment lenv

li_cols = this.GetColCount()

//		Copy metadata
for li_col = 1 to li_cols
	lstr_ds.s_col_name[li_col] = istr_col[li_col].s_colname
	lstr_ds.s_col_class[li_col] = istr_col[li_col].s_class
	lstr_ds.s_col_attribute[li_col] = istr_col[li_col].s_attribute
	lstr_ds.s_col_datatype[li_col] = istr_col[li_col].s_datatype
	lstr_ds.i_colmaps[li_col] = UpperBound(istr_col[li_col].colmap)
	for li_colmap = 1 to lstr_ds.i_colmaps[li_col]
		li_colmaps++
		lstr_ds.s_col_table[li_colmaps] = istr_col[li_col].colmap[li_colmap].s_table
		lstr_ds.s_col_column[li_colmaps] = istr_col[li_col].colmap[li_colmap].s_column
		lstr_ds.i_col_key[li_colmaps] = istr_col[li_col].colmap[li_colmap].i_key
	next
next

lstr_ds.l_next_beo_index = this.il_next_beo_index
lstr_ds.i_beoindexcolumn = ii_beo_index_col
lstr_ds.s_dwsyntax = this.Describe("DataWindow.Syntax")

GetEnvironment(lenv)

if lenv.PBMajorRevision >= 6  then
	if ib_useofrgetfullstate then
		lstr_ds.blb_originalbuffer = Blob(is_originalbuffer)
	else
		lstr_ds.blb_originalbuffer = iblb_origstate
	end if
else
	if is_originalbuffer <> "" then
		lstr_ds.s_originalbuffer = is_originalbuffer
	else
		lstr_ds.s_originalbuffer = ""
	end if
end if

if lenv.PBMajorRevision >= 6  then
	li_rc = this.dynamic GetChanges(lstr_ds.blb_changes)
else	
	li_cols = this.GetColCount()
	//		Copy the data and status information
	ll_rows = this.RowCount()
	if ll_rows > 0 then
		for ll_row = 1 to ll_rows
			ldwis_status = this.GetItemStatus(ll_row, 0, Primary!)
	//				Set upperbound
			lstr_ds.b_colstatus[ll_rows * li_cols] = false
			lstr_ds.i_rowstatus[ll_rows] = 0
			if ldwis_status <> NotModified! then
				if ldwis_status = New! then
					lstr_ds.i_rowstatus[ll_row] = 1
				else
					if ldwis_status = NewModified! then
						lstr_ds.i_rowstatus[ll_row] = 2
					else
						lstr_ds.i_rowstatus[ll_row] = 3
					end if
				end if
				// 1.20.05 - Copy data even if status is new
				for li_col = 1 to li_cols
					ll_index = (ll_row - 1) * li_cols + li_col
					ldwis_status = this.GetItemStatus(ll_row, li_col, Primary!)
					// 1.20.05 - Also copy BEO Index value
					if ldwis_status = DataModified! or ii_beo_index_col = li_col then
						lstr_ds.b_colstatus[ll_index] = true
						lstr_ds.a_coldata[ll_index] = this.Object.Data.Primary.Current[ll_row, li_col]
					end if
				next
				//
			end if
		next
	end if
	
	//		Copy deleted rows and status information
	ll_rows = this.DeletedCount()
	if ll_rows > 0 then
	//HACK! BUG IN PB buffers won't update/delete/insert. 
	//So in ofr_n_bcm_ds.deserialize do a deleterow
//		lany_buffer = this.Object.Data.Delete.Original
//		lstr_ds.a_deletedbuffer = lany_buffer
		lstr_ds.i_delrowstatus[ll_rows] = 0
		for ll_row = 1 to ll_rows
//			if IsPBRowIDOn() then
//				lstr_ds.i_delrowstatus[ll_row] = this.dynamic GetRowIDFromRow(ll_row, Delete!)
//				if lstr_ds.i_delrowstatus[ll_row] = -1 then //Hack around PB Bug!
//					lstr_ds.i_delrowstatus[ll_row] = this.dynamic GetRowIDFromRow(ll_row, Filter!)
//				end if
//			else
				lstr_ds.i_delrowstatus[ll_row] = this.GetItemNumber(ll_row, ii_beo_index_col, Delete!, false)
//			end if
		next
	end if
end if

return lstr_ds

end function

public function long getdata (readonly string as_colname[], readonly string as_datatype[], readonly long al_beoindex, ref any aa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetData
//
//	Arguments:		as_colname[]		column names
//						as_datatype[]		column datatypes
//						al_beoindex			beoindex of row to copy (0 for all rows)
//						aa_data[]			reference: returned data
//
//	Returns:			long
//						>= 0		Number of rows returned
//						-1			Error
//
//	Description:	Returns column data for the specified columns
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
long ll_startrow, ll_endrow, ll_rows
int li_cols, li_col, li_sourcecol
string ls_syntax, ls_error
datastore lds_buffer

lds_buffer = create datastore
if this.CreateSyntax(as_colname, as_datatype, ls_syntax) = 1 then
	if lds_buffer.Create(ls_syntax, ls_error) <> 1 then
		if isValid(inv_dlk) then
			inv_dlk.SetException("ofr_n_bcm_ds::GetData", "27991", {ls_error})
		end if
		return -1
	end if
else
	return -1
end if

li_cols = UpperBound(as_colname)
if al_beoindex = 0 then
	ll_startrow = 1
	ll_rows = this.RowCount()
	ll_endrow = ll_rows
else
	ll_startrow = this.GetBEORow(al_beoindex)
	if ll_startrow > 0 then
		ll_endrow = ll_startrow
		ll_rows = 1
	end if
end if

if ll_rows > 0 then
	//		Prevent GPF
	lds_buffer.insertrow(0)
	for li_col = 1 to li_cols
		li_sourcecol = integer(this.describe(as_colname[li_col] + ".id"))
		if li_sourcecol > 0 then
			lds_buffer.Object.Data[1, li_col, ll_rows, li_col] = &
					this.Object.Data[ll_startrow, li_sourcecol, ll_endrow, li_sourcecol]
		end if
	next
	if al_beoindex = 0 then
		aa_data = lds_buffer.object.data
	else
		aa_data = lds_buffer.object.data[1]
	end if
end if

destroy lds_buffer

return ll_rows

end function

public function long getretrieveddata (readonly string as_colname[], readonly string as_datatype[], ref any aa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRetrievedData
//
//	Arguments:		as_colname[]		column names
//						as_datatype[]		column datatypes
//						aa_data[]			reference: returned data
//
//	Returns:			long
//						>= 0		Number of rows returned
//						-1			Error
//
//	Description:	Returns last retrieved data for the specified columns
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
long ll_startrow, ll_endrow
int li_cols, li_col, li_sourcecol
string ls_syntax, ls_error
datastore lds_buffer

lds_buffer = create datastore
if this.CreateSyntax(as_colname, as_datatype, ls_syntax) = 1 then
	if lds_buffer.Create(ls_syntax, ls_error) <> 1 then
		if isValid(inv_dlk) then
			inv_dlk.SetException("ofr_n_bcm_ds::GetRetrievedData", "27991", {ls_error})
		end if
		return -1
	end if
else
	return -1
end if

li_cols = UpperBound(as_colname)
ll_endrow = this.RowCount()
ll_startrow = ll_endrow - il_retrieved + 1
if il_retrieved > 0 then
	//		Prevent GPF
	lds_buffer.insertrow(0)
	for li_col = 1 to li_cols
		li_sourcecol = integer(this.describe(as_colname[li_col] + ".id"))
		if li_sourcecol > 0 then
			lds_buffer.Object.Data[1, li_col, il_retrieved, li_col] = &
					this.Object.Data[ll_startrow, li_sourcecol, ll_endrow, li_sourcecol]
		end if
	next
	aa_data = lds_buffer.object.data
end if

destroy lds_buffer

return il_retrieved

end function

public function integer getupdatecount (ref long al_updated, ref long al_inserted, ref long al_deleted);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetUpdateCount
//
//	Arguments:		al_updated		Reference: rows updated
//						al_inserted		Reference: rows inserted
//						al_deleted		Reference: rows deleted
//
//	Returns:			integer
//						1		Success
//						-1		failure
//
//	Description:	Returns number of rows updated
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
al_updated = il_updated
al_inserted = il_inserted
al_deleted = il_deleted

return 1

end function

public function long initbeoindex (readonly long al_rows);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		InitBEOIndex
//
//	Arguments:		al_rows		Rows to initialize
//
//	Returns:			long
//						>=0		Rows initialized
//						-1			Error
//
//	Description:	Initializes BEOIndex column
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
Long ll_row, ll_start, ll_rowcount
ofr_s_bcm_ds_beoindex_init lstr_init[]	// used to initalize BEO_index column in ids_view with dot notation syntax.

il_retrieved = al_rows

if ii_beo_index_col > 0 then
	ll_rowcount = this.RowCount()
	if ib_append = false then
		il_next_beo_index = 0
	end if
	if ll_rowcount > 0 and al_rows > 0 then
		if al_rows = ll_rowcount then
			// setup BEO Index values after successful retrieve.
			// build BEO_index init structure array
			for ll_row = 1 to ll_rowcount
				lstr_init[ll_row].beo_index = this.getnextindex ( )
			next
			// init BEO_INDEX using dot syntax
			this.Object.Data[1, ii_beo_index_col, ll_rowcount, ii_beo_index_col] = lstr_init
			this.ResetUpdate ( )
		else
			//		Appending rows
			ll_start = ll_rowcount - al_rows + 1
			for ll_row = ll_start to ll_rowcount
				this.SetItem(ll_row, ii_beo_index_col, this.getnextindex())
				this.SetItemStatus(ll_row, 0,  Primary!, NotModified!)
			next
		end if
	end if
end if

return al_rows

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

public function boolean isboindexadded ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsBOIndexAdded
//
//	Arguments:		none
//
//	Returns:			Boolean
//
//	Description:	Returns indicator as to whether BOIndex was added
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
return this.ib_boindexadded

end function

public function integer updatespending ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		UpdatesPending
//
//	Arguments:		none
//
//	Returns:			integer
//						1		Updates are pending
//						2 		Deletes are pending
//						3		Deletes and Updates are pending
//						0		No updates pending
//
//	Description:	Returns indicator of whether DS has changed
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 2.0   Return 1 if Modified, 2 if Delete or 3 if both
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long ll_drc, ll_mrc, ll_rc = 0

ll_drc = this.deletedcount()
ll_mrc = this.modifiedcount()

if (ll_drc > 0 and ll_mrc > 0) then
	return 3
elseif ll_drc > 0 then
	ll_rc = 2
elseif ll_mrc > 0 then
	ll_rc = 1
end if

return ll_rc

end function

public function n_bcm_ds copy ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Copy
//
//	Arguments:		None
//
//	Returns:			ofr_n_bcm_ds		Copied DataStore
//
//	Description:	Returns copy of BEOM DataStore
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.02.5   Initial version
//	1.2		Update for 1.2
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ofr_n_bcm_ds lnv_copy
int li_col, li_cols
long ll_row, ll_rows
dwItemStatus ldwis_rowstatus, ldwis_colstatus

lnv_copy = create using this.ClassName()
if this.dataobject <> '' then
	lnv_copy.dataobject = this.dataobject
else
	lnv_copy.Create(this.Object.DataWindow.Syntax)
end if

//		Copy the data and status information
ll_rows = this.RowCount()
if ll_rows > 0 then
	//		Copy data
	//		PB HACK!!! Insert dummy row to prevent GPF on DW created from syntax.
	lnv_copy.InsertRow(0)
	lnv_copy.Object.Data.Primary.Original = this.Object.Data.Primary.Original
	//		At this point all rows in lnv_copy now have a status of New!
	//		Update status information
	li_cols = this.GetColCount()
	for ll_row = 1 to ll_rows
		ldwis_rowstatus = this.GetItemStatus(ll_row, 0, Primary!)
		choose case ldwis_rowstatus
			case NotModified!
				lnv_copy.SetItemStatus(ll_row, 0, Primary!, DataModified!)
				lnv_copy.SetItemStatus(ll_row, 0, Primary!, NotModified!)
			case DataModified!, NewModified!
				lnv_copy.SetItemStatus(ll_row, 0, Primary!, ldwis_rowstatus)
				for li_col = 1 to li_cols
					if this.GetItemStatus(ll_row, li_col, Primary!) = DataModified! then
						lnv_copy.Object.Data.Primary.Current[ll_row, li_col] = &
							this.Object.Data.Primary.Current[ll_row, li_col]
					end if
				next
		end choose
	next
end if

//		Copy deleted rows and status information
ll_rows = this.DeletedCount()
if ll_rows > 0 then
	lnv_copy.Object.Data.Delete.Original = this.Object.Data.Delete.Original
	for ll_row = 1 to ll_rows
		ldwis_rowstatus = this.GetItemStatus(ll_row, 0, Delete!)
		choose case ldwis_rowstatus
			case NotModified!
				lnv_copy.SetItemStatus(ll_row, 0, Delete!, DataModified!)
				lnv_copy.SetItemStatus(ll_row, 0, Delete!, NotModified!)
			case DataModified!, NewModified!
				lnv_copy.SetItemStatus(ll_row, 0, Delete!, ldwis_rowstatus)
		end choose
	next
end if

lnv_copy.SetNextBEOIndex(this.il_next_beo_index)

return lnv_copy

end function

public function integer getbeoindexcolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndexColumn
//
//	Arguments:		none
//
//	Returns:			integer	Column number
//
//	Description:	Returns column number of BEO_Index column.
//						FOR INTERNAL OFR USE ONLY.
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
return this.ii_beo_index_col

end function

protected function integer addbeoindex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddBEOIndex
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Adds BEO_Index computed column
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2   Move to DS, added SP support
//	2.1	Add external datawindow support
// 2.1   Return from function if using PB RowID functions instead of beoindex
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc
long ll_retrieve, ll_from, ll_pos, ll_pos2
string ls_syntax, ls_char, ls_error


if this.IsPBRowIDOn() then
	return 1
end if

ls_syntax = this.Describe("DataWindow.Syntax")

// Look for PBSelect retrieve syntax???
ll_retrieve = Pos(ls_syntax, "retrieve=~"PBSELECT(")
	
// did it find it in PBSelect
if ( ll_retrieve > 0 ) then
	ll_pos2 = Max(Pos(ls_syntax, "COLUMN(NAME", ll_retrieve), Pos(ls_syntax, "COMPUTE(NAME", ll_retrieve))
	do while ll_pos2 > 0
		ll_pos = ll_pos2 + 10
		ll_pos2 = Max(Pos(ls_syntax, "COLUMN(NAME", ll_pos), Pos(ls_syntax, "COMPUTE(NAME", ll_pos))
	loop
	ll_pos = Pos(ls_syntax, ")", ll_pos)
	// Add column to PBSELECT
	ls_syntax = Left(ls_syntax, ll_pos) +&
			" COMPUTE(NAME=~~~"0~~~")" + Mid(ls_syntax, ll_pos + 1)
	// Add computed column
	ls_syntax = Left(ls_syntax, ll_retrieve - 1) +&
			" column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
			Mid(ls_syntax, ll_retrieve)
	li_rc = 1
else
	// Look for SQL SELECT
	ll_retrieve = Pos( ls_syntax, "retrieve=" )
	if ( ll_retrieve > 0 ) then
		ll_from = Pos(Lower(ls_syntax), " from ", ll_retrieve)
		if ( ll_from > 0 ) then
			// Add computed column to SELECT
			ls_syntax = Left(ls_syntax, ll_from - 1) + ", 0 " + isc_beo_index + Mid(ls_syntax, ll_from)
			// Add computed column
			ls_syntax = Left(ls_syntax, ll_retrieve - 1) +&
					" column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
					Mid(ls_syntax, ll_retrieve)
			li_rc = 1
		else
//			this.SetException("addbeoindex()", "24984", {"Missing from clause from select"})
			li_rc = -1
		end if
	else
		// Look for stored procedure
		ll_retrieve = Pos( ls_syntax, "procedure=" )
		if ( ll_retrieve > 0 ) then
			// Add computed column
			ls_syntax = Left(ls_syntax, ll_retrieve - 1) +&
					" column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
					Mid(ls_syntax, ll_retrieve)
			li_rc = 1
		else
			//most likely an external datawindow which has no indicator
			ll_pos = 1
			ll_retrieve = 1
	
			do until ll_retrieve = 0
				ll_retrieve = Pos( ls_syntax, "dbname=", ll_pos )
				if ll_retrieve <> 0 then
					ll_pos = ll_retrieve + 7
				end if
			loop
			
			ll_retrieve = Pos( ls_syntax, ")", ll_pos) 
			ls_syntax = Left(ls_syntax, ll_retrieve +1) + " column=(type=long updatewhereclause=yes name="+isc_beo_index+" dbname=~""+isc_beo_index+"~" ) " +&
					Mid(ls_syntax, ll_retrieve+1)
			li_rc = 1
		end if
	end if
end if


if li_rc = 1 then
	if this.Create(ls_syntax, ls_error) = 1 then
		this.ib_boindexadded = TRUE
		li_rc = 1
	else
		li_rc = -1
	end if
end if

return li_rc

end function

public function integer setdataobject (readonly string as_dataobject, readonly boolean ab_addbeoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDataObject
//
//	Arguments:		as_dataobject		Data object definition
//						ab_addbeoindex		Whehter to add BEO_Index column if missing
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets datastore object
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	1.2.1		Added fix for BTR# 7938.
//	1.20.04	Clear filter on passed dataobjects BTR# 9051
//	2.10		Don't set default table name here. BTR# 11905
// 2.10     Map columns if default dlk.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_col, li_cols
string ls_error, ls_table, ls_column

//		if longer than 40 characters then assume syntax was passed
if Len(as_dataobject) > 40 then
	if this.Create(as_dataobject, ls_error) = -1 then
		li_rc = -1
	end if
else
	this.dataobject = as_dataobject
	if this.describe("datawindow.syntax") = "" then
		if isValid(inv_dlk) then
			inv_dlk.SetException("ofr_n_bcm_ds::setdataobject", "27990", {as_dataobject})
		end if
		li_rc = -1
	end if
end if

if li_rc = 1 then
	//	Clear any filters
	this.SetFilter("")
	this.Filter()
	if not this.IsPBRowIDOn() then
		ii_beo_index_col =  integer(this.Describe(isc_beo_index + ".ID"))
		if ii_beo_index_col < 1 then
			ii_beo_index_col =  integer(this.Describe("bo_index.ID"))
		end if
		if ii_beo_index_col < 1 and ab_addbeoindex = true then
			if this.AddBEOIndex() = 1 then
				ii_beo_index_col =  integer(this.Describe(isc_beo_index + ".ID"))
			else
				li_rc = -1
			end if
		end if
	end if
end if

if li_rc = 1 and inv_dlk.defaultDLK() then
	li_cols = this.GetColCount()
	// Load default table/column info
	for li_col = 1 to li_cols
		if this.GetDBTableColumn(this.Describe("#" + string(li_col) + ".dbname"), ls_table, ls_column) = 1 then
			//btr# 11905
//			if ls_table <> "" and ls_column <> "" then
//				
//				istr_col[li_col].colmap[1].s_table = lower(ls_table)
				istr_col[li_col].colmap[1].s_column = lower(ls_column)
//			elseif ls_table = "" and ls_column = this.Describe("#" + string (ii_beo_index_col) + ".name") then
//				/*
//				**  This is the beo_index column which does not have a table associated to it
//				*/
//				istr_col[li_col].colmap[1].s_column = lower(ls_column)
//			end if
			/*
			**  Reset refrence varibles
			**  (MP - Added so that the next time GetDBTableColumn is invoked, it will not
			**   pick up the values from the previous call)
			*/
			ls_table = ""
			ls_column = ""
			//	Check for identity column
			if this.Describe("#" + string(li_col) + ".Identity") = "yes" then
				ib_identitycolumn = true
			end if
		else
			//		Need exception here
			li_rc = -1
		end if
	next
end if

return li_rc

end function

public function integer setdatachangedduringupdate (readonly boolean ab_changed);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDataChangedDuringUpdate
//
//	Arguments:		ab_changed		Change indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets indicator as to whether data changed in the result
//						set during the update process.
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
this.ib_datachangedduringupdate = ab_changed

return 1

end function

public function boolean hasdatachangedduringupdate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		HasDataChangedDuringUpdate
//
//	Arguments:		none
//
//	Returns:			Boolean	Change indicator
//
//	Description:	Returns indicator as to whether data changed in the result
//						set during the update process.
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
return this.ib_datachangedduringupdate

end function

public function integer resetupdatecount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ResetUpdateCount
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Resets data values prior to updating datastore
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
il_updated = 0
il_inserted = 0
il_deleted = 0

this.SetDataChangedDuringUpdate(FALSE)

return 1
end function

public function integer serialize (ref blob ablb_view);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Serialize
//
//	Arguments:		ablb_view	Returned blob of serialized view
//
//	Returns:			int		1	Success
//									-1	Failure
//
//	Description:	Returns serialized copy of BCM_DS DataStore
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_col, li_cols, li_colmap, li_colmaps
unsignedlong ul_rc = 1
long ll_rc
blob lblb_data


//		Initialize buffer
ablb_view = blob(space(1000000))
ul_rc = BlobEdit(ablb_view, ul_rc, this.Describe("DataWindow.Syntax"))

li_cols = this.GetColCount()
ul_rc = BlobEdit(ablb_view, ul_rc, string(li_cols))

//		Copy metadata
for li_col = 1 to li_cols
	ul_rc = BlobEdit(ablb_view, ul_rc, istr_col[li_col].s_colname)
	ul_rc = BlobEdit(ablb_view, ul_rc, istr_col[li_col].s_class)
	ul_rc = BlobEdit(ablb_view, ul_rc, istr_col[li_col].s_attribute)
	ul_rc = BlobEdit(ablb_view, ul_rc, istr_col[li_col].s_datatype)
	li_colmaps = UpperBound(istr_col[li_col].colmap[])
	ul_rc = BlobEdit(ablb_view, ul_rc, string(li_colmaps))
	for li_colmap = 1 to li_colmaps
		ul_rc = BlobEdit(ablb_view, ul_rc, istr_col[li_col].colmap[li_colmap].s_table)
		ul_rc = BlobEdit(ablb_view, ul_rc, istr_col[li_col].colmap[li_colmap].s_column)
		ul_rc = BlobEdit(ablb_view, ul_rc, string(istr_col[li_col].colmap[li_colmap].i_key))
	next
next

ul_rc = BlobEdit(ablb_view, ul_rc, String(this.il_next_beo_index))
ul_rc = BlobEdit(ablb_view, ul_rc, String(this.ii_beo_index_col))

if ib_useofrgetfullstate then
	li_rc = this.GetFullStateOFR(ablb_view, ul_rc)
else
	//ul_rc = BlobEdit(ablb_view, ul_rc, String(Len(is_originalbuffer) + 1))
	ul_rc = BlobEdit(ablb_view, ul_rc, String(Len(iblb_origstate)))
	//ul_rc = BlobEdit(ablb_view, ul_rc, is_originalbuffer)
	ul_rc = BlobEdit(ablb_view, ul_rc, iblb_origstate)
	
	ll_rc = this.dynamic GetChanges(lblb_data)
	ablb_view = BlobMid(ablb_view, 1, ul_rc - 1) + lblb_data
end if

return li_rc

end function

public function integer deserialize (readonly blob ablb_view);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deserialize
//
//	Arguments:		ablb_view		Blob to deserialize
//
//	Returns:			Integer		1	Success

//										-1	Failure
//
//	Description:	Recreates view from passed blob
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
blob lblb_data
int li_rc = 1, li_col, li_colmap, li_colmaps
long ll_row, ll_rows, ll_index, ll_beorow, ll_len
string ls_syntax, ls_error, ls_temp
unsignedlong ul_rc = 1

//		DW Syntax
ls_syntax = String(BlobMid(ablb_view, ul_rc))
ul_rc = ul_rc + len(ls_syntax) + 1

if this.Create(ls_syntax, ls_error) <> 1 then
	if isValid(inv_dlk) then
		inv_dlk.SetException("ofr_n_bcm_ds::deserialize()", "27991", {ls_error})
	end if
	return -1
end if

//		# columns
ls_temp = String(BlobMid(ablb_view, ul_rc, 4))
ul_rc = ul_rc + len(ls_temp) + 1
ii_cols = Integer(ls_temp)
//		Copy metadata
for li_col = 1 to ii_cols
	//		Column name
	ls_temp = String(BlobMid(ablb_view, ul_rc, 41))
	ul_rc = ul_rc + len(ls_temp) + 1
	istr_col[li_col].s_colname = ls_temp
	//		Class name
	ls_temp = String(BlobMid(ablb_view, ul_rc, 41))
	ul_rc = ul_rc + len(ls_temp) + 1
	istr_col[li_col].s_class = ls_temp
	//		Attribute name
	ls_temp = String(BlobMid(ablb_view, ul_rc, 41))
	ul_rc = ul_rc + len(ls_temp) + 1
	istr_col[li_col].s_attribute = ls_temp
	//		datatype
	ls_temp = String(BlobMid(ablb_view, ul_rc, 20))
	ul_rc = ul_rc + len(ls_temp) + 1
	istr_col[li_col].s_datatype = ls_temp
	//		Column maps
	ls_temp = String(BlobMid(ablb_view, ul_rc, 3))
	ul_rc = ul_rc + len(ls_temp) + 1
	li_colmaps = Integer(ls_temp)
	for li_colmap = 1 to li_colmaps
		//		DB Table
		ls_temp = String(BlobMid(ablb_view, ul_rc, 41))
		ul_rc = ul_rc + len(ls_temp) + 1
		istr_col[li_col].colmap[li_colmap].s_table = ls_temp
		//		DB Column
		ls_temp = String(BlobMid(ablb_view, ul_rc, 41))
		ul_rc = ul_rc + len(ls_temp) + 1
		istr_col[li_col].colmap[li_colmap].s_column = ls_temp
		//		key indicator
		ls_temp = String(BlobMid(ablb_view, ul_rc, 2))
		ul_rc = ul_rc + len(ls_temp) + 1
		istr_col[li_col].colmap[li_colmap].i_key = Integer(ls_temp)
	next
next

//		Next BEO Index value
ls_temp = String(BlobMid(ablb_view, ul_rc, 5))
ul_rc = ul_rc + len(ls_temp) + 1
this.il_next_beo_index = Long(ls_temp)

//		BEO Index column
ls_temp = String(BlobMid(ablb_view, ul_rc, 41))
ul_rc = ul_rc + len(ls_temp) + 1
this.ii_beo_index_col = Long(ls_temp)

if ib_useofrgetfullstate then
	li_rc = this.SetFullStateOFR(Blobmid(ablb_view, ul_rc))
else
	//new
	ls_temp = String(blobmid(ablb_view, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	ll_len = Long(ls_temp)
	//ls_temp = string(BlobMid(ablb_view, ul_rc, ll_len))
	iblb_origstate = BlobMid(ablb_view, ul_rc, ll_len)
	ul_rc = ul_rc + ll_len
	this.dynamic SetFullState(iblb_origstate)
	ll_len = len(iblb_origstate)
	//this.reset()
	//this.resetupdate()
	//this.SetOriginalBuffer()
	
	//		DW data
	lblb_data = BlobMid(ablb_view, ul_rc)
	ul_rc = this.RowCount()
	
	ul_rc = this.dynamic SetChanges(lblb_data)
	ul_rc = this.RowCount()
	ul_rc = this.DeletedCount()
	ul_rc = this.modifiedCount()
end if

//		Set number of rows retrieved to totals rows in buffer
this.il_retrieved = this.RowCount()

return li_rc

end function

public function integer resetupdate ();//
//	Function:		ResetUpdate
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Resets the update information associated to the BCM Datastore
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.20.03   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc

li_rc = super::ResetUpdate()
this.SetOriginalBuffer()

return li_rc
end function

public function integer mapdbname (integer ai_classindex, string as_attribute, string as_table, string as_column);return 1
end function

protected function integer setfullstateofr (readonly blob ablb_dw);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetFullStateOFR
//
//	Arguments:		ablb_dw  blob  State information you want to apply to the 
//											DataWindow control or DataStore
//
//	Returns:			Integer 		1 indicates success
//										-1	indicates error
//
//	Description:	Applies the contents of a blob created by GetFullStateOFR to a 
//						DataWindow or DataStore. 
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1	Initial Version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string  ls_orig, ls_temp, ls_date, ls_time
unsignedlong ul_rc = 1
int li_rc = 1, li_col, li_cols, li_pos
long ll_row, ll_rows, ll_beoindex, ll_beorow
String ls_coltype[]
String ls_null
DateTime ldt_null
Date ld_null
Time lt_null
Double ldbl_null

SetNull(ls_null)
SetNull(ldt_null)
SetNull(ld_null)
SetNull(lt_null)
SetNull(ldbl_null)


li_cols = this.GetColCount()
for li_col = 1 to li_cols
	ls_coltype[li_col] = this.Describe("#" + String(li_col) + ".coltype")
next

//		Is there original buffer?
ls_orig = String(BlobMid(ablb_dw, ul_rc))
ul_rc = ul_rc + len(ls_orig) + 1

//		Get original buffer
if ls_orig = "Y" then
	ls_temp = String(BlobMid(ablb_dw, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	li_rc = this.ImportString(ls_temp)
	this.ResetUpdate()
end if

//		Deleted rows
ls_temp = String(BlobMid(ablb_dw, ul_rc))
ul_rc = ul_rc + len(ls_temp) + 1
ll_rows = Long(ls_temp)
for ll_row = 1 to ll_rows
	ls_temp = String(BlobMid(ablb_dw, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	ll_beorow = this.Find( "#" + String(ii_beo_index_col) + " = " + ls_temp, 1, this.RowCount())
	this.DeleteRow(ll_beorow)
next

//		Modified rows
ls_temp = String(BlobMid(ablb_dw, ul_rc))
ul_rc = ul_rc + len(ls_temp) + 1
ll_rows = Long(ls_temp)
for ll_row = 1 to ll_rows
	//		BEOIndex
	ls_temp = String(BlobMid(ablb_dw, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	ll_beoindex = Long(ls_temp)
	//		Row status (1 new, 2 new modified, 3 modified)
	ls_temp = String(BlobMid(ablb_dw, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	if ls_temp = "1" then
		ll_beorow = super::InsertRow(0)
	else
		if ls_temp = "2" then
			ll_beorow = super::InsertRow(0)
		else
			//	Get row # for status 3
			ls_temp = String(BlobMid(ablb_dw, ul_rc))
			ul_rc = ul_rc + len(ls_temp) + 1
			ll_beorow = Long(ls_temp)
		end if
		for li_col = 1 to li_cols
			//		Column status (0 not modified, 1 modified and null, 2 modified)
			ls_temp = String(BlobMid(ablb_dw, ul_rc))
			ul_rc = ul_rc + len(ls_temp) + 1
			if ls_temp = "1" then
				//		Set column to null
				choose case Left(ls_coltype[li_col], 5)
					case "char("
						this.Object.Data[ll_beorow, li_col] = ls_null
					case "datet"
						this.Object.Data[ll_beorow, li_col] = ldt_null
					case "date"
						this.Object.Data[ll_beorow, li_col] = ld_null
					case "time"
						this.Object.Data[ll_beorow, li_col] = lt_null
					case else
						this.Object.Data[ll_beorow, li_col] = ldbl_null
				end choose
			elseif ls_temp = "2" then
				//		Get column modified value
				ls_temp = String(BlobMid(ablb_dw, ul_rc))
				ul_rc = ul_rc + len(ls_temp) + 1
				choose case Left(ls_coltype[li_col], 5)
					case "char("
						this.Object.Data[ll_beorow, li_col] = ls_temp
					case "datet"
						li_pos = Pos(ls_temp, " ")
						ls_time = Mid(ls_temp, li_pos)
						ls_date = Left(ls_temp, li_pos)
						this.Object.Data[ll_beorow, li_col] = DateTime(Date(ls_date), Time(ls_time))
					case "date"
						this.Object.Data[ll_beorow, li_col] = date(ls_temp)
					case "time"
						this.Object.Data[ll_beorow, li_col] = time(ls_temp)
					case else
						this.Object.Data[ll_beorow, li_col] = double(ls_temp)
				end choose
			end if
		next
		//		Set BEOIndex value
		this.Object.Data[ll_beorow, ii_beo_index_col] = ll_beoindex
		this.SetItemStatus(ll_beorow, ii_beo_index_col, Primary!, NotModified!)
	end if
next

//now that data is in, set the original buffer.
if ls_orig = "N" then
	this.SetOriginalBuffer()
end if


li_rc = 1

return li_rc

end function

public function integer reset ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ResetUpdate
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Resets datastore
//						FOR INTERNAL USE ONLY
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

integer li_rc

li_rc = super::reset()

if li_rc > -1 then
	this.SetOriginalBuffer()
	il_next_beo_index = 0
	il_retrieved = 0
	il_startingrowcount = 0
end if

return li_rc

end function

public function long getbeoindex (long al_row, dwbuffer adwb_buffer);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		al_row	View row number
//						adwb_buffer DataWindow buffer
//
//	Returns:			long
//						>= 0		BEO_Index number
//						-1			Error
//
//	Description:	Returns beoindex for specified view row
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 2.0   Use pb function GetRowIDFromRow if indicator is on.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_beo_index = -1

if al_row > 0 then
	if IsPBRowIDOn() then
		ll_beo_index = this.dynamic GetRowIDFromRow( al_row, adwb_buffer )
	else
		if ii_beo_index_col > 0 then
			ll_beo_index = this.GetItemNumber(al_row, ii_beo_index_col, adwb_buffer, false)
		end if
	end if
end if

return ll_beo_index
end function

public function long insertrow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		InsertRow
//
//	Arguments:		r			Row before which you want to insert the row.
//
//	Returns:			Long
//						>0			number of the row that was added
//						-1			Error
//
//	Description:	Inserts a row
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
//	1.20.05	Set row status back to New! after setting BEO Index value.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rc


//		Prevent DDDW's from retrieving
if this.rowcount() = 0 then
	this.DisableDDDW()
end if

ll_rc = super::InsertRow(al_row)
if ll_rc > 0 then
	this.SetBEOIndexForRow(ll_rc)
end if

return ll_rc

end function

public function long append (readonly n_bcm_ds ads_view_new);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Append
//
//	Arguments:		ads_view_new  View to append to 'this' view
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Appends view data to this view
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer 			li_rc
long				ll_RowsNew
long           ll_RowsOrig
long				ll_row
long           ll_beo_index
dwitemstatus	ldwis

ll_RowsNew = ads_view_new.RowCount()
if ll_RowsNew = 0 then
	return 1
end if

//	Set number of rows retrieved to totals rows in buffer
this.il_retrieved = ll_RowsNew

ll_RowsOrig = this.RowCount()

li_rc = ads_view_new.RowsCopy(1, ll_RowsNew, Primary!, this, ll_RowsOrig + 1, Primary!)

if li_rc = 1 then
	for ll_row = 1 to ll_RowsNew
		
		// Set up the beoindex for appended rows
		ll_beo_index = this.GetMaxIndex(1, ll_RowsOrig)
		ll_RowsOrig ++
		this.SetItem(ll_RowsOrig, ii_beo_index_col, ll_beo_index + 1)
		this.SetNextBEOIndex(ll_beo_index + 1)
		// Set the row status' for the newly appended rows
		ldwis = ads_view_new.GetItemStatus(ll_row, 0, Primary!)
		if ldwis = NotModified! then
			this.SetItemStatus(ll_RowsOrig, 0, Primary!, DataModified!)
			this.SetItemStatus(ll_RowsOrig, 0, Primary!, NotModified!)
		else
			this.SetItemStatus(ll_RowsOrig, 0, Primary!, ldwis)
		end if
	next
end if

ll_RowsNew = ads_view_new.DeletedCount()
ll_RowsOrig = this.DeletedCount()

if ll_RowsNew > 0 then
	li_rc = ads_view_new.RowsCopy(1, ll_RowsNew, Delete!, this, ll_RowsOrig + 1, Delete!)
end if

for ll_row = 1 to ll_RowsNew
	ldwis = ads_view_new.GetItemStatus(ll_row, 0, Delete!)
	ll_RowsOrig ++
	choose case ldwis
		case NotModified!
			this.SetItemStatus(ll_RowsOrig, 0, Delete!, DataModified!)
			this.SetItemStatus(ll_RowsOrig, 0, Delete!, NotModified!)
		case DataModified!, NewModified!
			this.SetItemStatus(ll_RowsOrig, 0, Delete!, ldwis)
	end choose
next

//svh - ia orgininal buffer will need to be appended.  gk says it should also change 
//from an any to a string.  Unclear as to why....


return li_rc
end function

public function long getmaxindex (long al_rowstart, long al_rowend);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetMaxIndex
//
//	Arguments:		None
//
//	Returns:			Long Maximum BEO index value
//
//	Description:	Returns max BEO index value in a range of rows
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
long ll_row
long ll_value
long ll_last_value

for ll_row = al_rowstart to al_rowend
	ll_value = this.GetItemNumber(ll_row, ii_beo_index_col)
	if ll_value > ll_last_value then
		ll_last_value = ll_value
	end if
next

return ll_last_value

end function

protected function integer getfullstateofr (ref blob ablb_dw, long al_len);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetFullStateOFR
//
//	Arguments:		ablb_dw  blob  Blob by reference to populate
//						al_len	long	Starting position
//
//	Returns:			Long 		Returns the number of rows in the DataWindow blob if 
//									it succeeds and -1 if an error occurs
//						1		success
//						-1		error
//
//	Description:	Retrieves the complete state of a DataWindow or DataStore into a blob.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1	Initial Version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
any 				la_data
blob 				lblb_mod
long 				ll_value, ll_row, ll_rows, ll_index, ll_modrows
int 				li_col, li_cols
dwitemstatus 	ldwis_status
unsignedlong 	ul_rc, ul_mod = 1

ul_rc = al_len
lblb_mod = blob(space(100000))

if is_originalbuffer <> '' then
	ul_rc = BlobEdit(ablb_dw, ul_rc, "Y")
	ul_rc = BlobEdit(ablb_dw, ul_rc, is_originalbuffer)
else
	ul_rc = BlobEdit(ablb_dw, ul_rc, "N")
end if

//		Copy deleted rows and status information
ll_rows = this.DeletedCount()
ul_rc = BlobEdit(ablb_dw, ul_rc, String(ll_rows))
for ll_row = 1 to ll_rows
	ll_value = this.GetItemNumber(ll_row, ii_beo_index_col, Delete!, false)
	ul_rc = BlobEdit(ablb_dw, ul_rc, string(ll_value))
next

li_cols = this.GetColCount()
//		Copy the data and status information
ll_rows = this.RowCount()
if ll_rows > 0 then
	for ll_row = 1 to ll_rows
		ldwis_status = this.GetItemStatus(ll_row, 0, Primary!)
		if ldwis_status <> NotModified! then
			ul_mod = BlobEdit(lblb_mod, ul_mod, String(this.GetItemNumber(ll_row, ii_beo_index_col)))
			ll_modrows++
			if ldwis_status = New! then
				ul_mod = BlobEdit(lblb_mod, ul_mod, "1")
			elseif ldwis_status = NewModified! then
				ul_mod = BlobEdit(lblb_mod, ul_mod, "2")
			else
				ul_mod = BlobEdit(lblb_mod, ul_mod, "3")
				ul_mod = BlobEdit(lblb_mod, ul_mod, string(ll_row))
			end if
			for li_col = 1 to li_cols
				ldwis_status = this.GetItemStatus(ll_row, li_col, Primary!)
				la_data = this.Object.Data.Primary.Current[ll_row, li_col]
				if ldwis_status = NotModified! then
					ul_mod = BlobEdit(lblb_mod, ul_mod, "0")
				else
					if IsNull(la_data) then
						ul_mod = BlobEdit(lblb_mod, ul_mod, "1")
					else
						ul_mod = BlobEdit(lblb_mod, ul_mod, "2")
						ul_mod = BlobEdit(lblb_mod, ul_mod, String(la_data))
					end if
				end if
			next
		end if
	next
end if

ul_rc = BlobEdit(ablb_dw, ul_rc, String(ll_modrows))
if ll_modrows > 0 then
	lblb_mod = BlobMid(lblb_mod, 1, ul_mod - 1)	
	ul_rc = BlobEdit(ablb_dw, ul_rc, lblb_mod)
end if

ablb_dw = BlobMid(ablb_dw, 1, ul_rc - 1)

return 1

end function

public subroutine setbcmmgr (readonly nonvisualobject anv_bcmmgr);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCMMgr
//
//	Arguments:		n_cst_bcmmgr	BCM Manager to use
//
//	Returns:			None
//
//	Description:	BCM Manager for datastore to use
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

inv_bcmmgr = anv_bcmmgr
end subroutine

public function integer getcolcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetColCount
//
//	Arguments:		None
//
//	Returns:			integer		Number of columns in datastore
//
//	Description:	Returns number of columns in datastore
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	1.20.01	BUG #8368 - Make sure the structure is populated to avoid Array Boundary Exceeded.
//
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if ii_cols = 0 then
	ii_cols = Integer ( this.Describe("datawindow.column.count") )
	// BUG #8368 - Make sure the structure is populated to avoid Array Boundary Exceeded.
	if ii_cols > UpperBound(istr_col) then
		istr_col[ii_cols].s_colname = ""
	end if
end if

return ii_cols

end function

public subroutine getcols (ref ofr_s_bcm_ds_datacol astr_col[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetCols
//
//	Arguments:		None
//
//	Returns:			None
//
//	Description:	Get Columns for datastore
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

astr_col = istr_col
end subroutine

public function long getnextindex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetNextIndex
//
//	Arguments:		None
//
//	Returns:			Long Next BEO index value
//
//	Description:	Returns next BEO index value
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Move to BEOM_DS
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
il_next_beo_index ++
return il_next_beo_index
end function

public function long setbeoindexforrow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBEOIndexForRow
//
//	Arguments:		al_row	Row before which you want set the BEO Index value.
//
//	Returns:			Long
//						>0			number of the row that was added
//						-1			Error
//
//	Description:	Sets BEO Index to next available value.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 2.1	Initial Version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rc = 1

if IsPBRowIDOn() then
	return ll_rc
else
	this.SetItem(al_row, ii_beo_index_col, this.getnextindex())
	// 1.20.05 - Set the status to New!. It says NotModified!, but it actually 
	// sets it to New!.  
	this.SetItemStatus(al_row, 0, Primary!, NotModified!)
end if

return ll_rc

end function

public function boolean ispbrowidon ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsPBRowIDOn
//
//	Arguments:		none
//
//	Returns:			Boolean
//
//	Description:	Returns true if ofr is to use PB 6.0 RowID functions instead of
//						beoindex.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if isValid(inv_dlk) then
	return inv_dlk.GetBCMMGR().IsPBRowIDOn() 
elseif isValid(inv_bcmmgr) then
	return inv_bcmmgr.IsPBRowIDOn()
else 
	return false
end if
end function

public function long getbeorow (long al_beoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEORow
//
//	Arguments:		al_beo_index	Index of BEO to find
//
//	Returns:			Integer
//						> 0		Row of BEO found
//						0			Index not found
//						< 0		error
//
//	Description:	Returns row for specified BEOIndex
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1 	Use pb function GetRowIDFromRow if indicator is on
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row

if this.IsPBRowIDOn() then
	ll_row = this.dynamic GetRowFromRowID(al_beoindex)
else
	ll_row = this.Find( "#" + String(ii_beo_index_col) + " = " + String(al_beoindex), 1, this.RowCount())
end if

return ll_row
end function

on ofr_n_bcm_ds.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on ofr_n_bcm_ds.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event dberror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			dberror
//
//	Description:	Displays a message with the database error
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	Remove message beox, use BEOM error service instead
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if ib_skip_dberror = FALSE then
	// Check to avoid null object crash
	if isValid(inv_dlk) then
		inv_dlk.DBError(GetBEOIndex(row, buffer), sqldbcode, sqlerrtext, sqlsyntax)
	end if
else
	ib_skip_dberror = FALSE
end if

return 1

end event

event sqlpreview;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			SqlPreview
//
//	Description:	Intercepts SQL calls and only allows certain update
//						calls to execute
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.2		Added decrement of affected row variables. Fixes BTR# 0007615
//	1.20.01	Checked for either 1 or 2 as valid return codes from events.  Fixes BTR# 0008379
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rc

ib_skip_dberror = FALSE

if request = PreviewFunctionUpdate! then
	choose case sqltype
		case PreviewInsert!
			if ib_allow_inserts = FALSE then
				il_inserted --
				ll_rc = 2
			end if
		case PreviewUpdate!
			if ib_allow_updates = FALSE then
				il_updated --
				ll_rc = 2
			end if
		case PreviewDelete!
			// GK - Make sure this is the delete buffer.  Otherwise, this
			// is an Update implemented as Delete/Insert.
			if ib_allow_deletes = FALSE and buffer = Delete! then
				il_deleted --
				ll_rc = 2
			end if
	end choose
end if

if ll_rc = 0 then
	//		Invoke DLK SQLPreview
	if IsValid(inv_dlk) then
		ll_rc = inv_dlk.event ofr_sqlpreview(inv_tran, request, sqltype, sqlsyntax, buffer, row)
		if ll_rc = 0 then
			this.SetSQLPreview(sqlsyntax)
		// Bug #0008379:  Check for 1 OR 2 because both mean that the update was OK and we should continue.
		elseif ll_rc = 1 or ll_rc = 2 then
			//	Statement processed in DLK
			// Return 2 Skip this request and execute the next request.
			ll_rc = 2
		else
			//		Error
			// Return 1 Stop processing of all entries.
			ib_skip_dberror = TRUE
			ll_rc = 1
		end if
	end if
end if

return ll_rc

end event

event retrievestart;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			retrievestart
//
//	Description:	Occurs when the retrieval is about to begin.
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
int li_rc

this.DisableDDDW()
if this.ib_append then
	li_rc = 2
	il_startingrowcount = this.RowCount()
end if

return li_rc

end event

event retrieveend;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			retrieveend
//
//	Description:	Occurs when the retrieval has finished.
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
any la_buffer[]
long ll_retrieved


if ib_append then
	ll_retrieved = rowcount - il_startingrowcount
else
	ll_retrieved = rowcount
end if

if this.InitBEOIndex(ll_retrieved) < 0 then
	return -1
else
	this.SetOriginalBuffer()
	return 0
end if

end event

event updateend;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			updateend
//
//	Description:	Occurs when the update has finished.
//						FOR INTERNAL USE ONLY
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
this.il_inserted = this.il_inserted + rowsinserted
this.il_updated = this.il_updated + rowsupdated
this.il_deleted = this.il_deleted + rowsdeleted

if this.il_inserted > 0 then
	if ib_identitycolumn then
		this.SetDataChangedDuringUpdate(TRUE)
	end if
end if

end event

