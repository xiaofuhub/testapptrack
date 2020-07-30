$PBExportHeader$ofr_n_cst_bcm.sru
$PBExportComments$Business Collection Manager base class
forward
global type ofr_n_cst_bcm from n_cst_collection
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070731
//Long	sl_BufferSize = 0  //Load value on first get
////end modification Shared Variables by appeon  20070731
//
end variables

global type ofr_n_cst_bcm from n_cst_collection
end type
global ofr_n_cst_bcm ofr_n_cst_bcm

type variables
protected:

string   is_dlk_relation
string is_dlk = "n_cst_dlk"
long ll_bcm_index
string is_query
// how BCM was passed (byref or serialized(value))
boolean ib_byref
//indicates requestor is sso
boolean ib_local
// BEO cursor index
long il_currow
// Result set append indicator
boolean ib_append
// Table owners
ofr_s_bcm_tableowner is_tableowner[]
n_cst_beo inv_relatedbeo
n_cst_beo inv_ownerbeo	// Owner BEO
string is_ownerrelationshipname   // Relationship to owner (for many-to-many)

n_bcm_ds ids_view		// BEO view
// transaction object reference for DLK's ids_view. Only valid in C/S model
transaction itrx_view

boolean ib_validated
// Registration info
int ii_classes, ii_regclass
// R1.20.04 Current class in hiearchy being registered
//int ii_reghierarchyclass
ofr_s_bcm_class istr_class[]
n_cst_database inv_database

n_cst_dlk inv_dlk

// Setting this to TRUE will cause the BCM to work in Thin Client mode.
// No BEOs will be instatiated in this mode.
Boolean ib_thinclient = FALSE

// When in Thin Client and an insert is done,
// we may want to call to the server to process
// PostNew on a BEO so that default values
// can be set.
Boolean ib_processpostnew = true

//begin modification Shared Variables by appeon  20070731
Long	sl_BufferSize = 0  //Load value on first get
//end modification Shared Variables by appeon  20070731
end variables

forward prototypes
public function integer addclass (readonly string as_classname)
public function integer checkrequired (ref string as_class, ref string as_attribute, ref long al_beo_index)
public function integer checkuniqueconstraint (readonly string as_class, readonly string as_constraint, readonly any aa_values[], readonly nonvisualobject anv_source_bcm, readonly long al_source_beoindex)
public function integer deletebeo (n_cst_beo anv_beo)
public function integer destroydlk (ref n_cst_dlk anv_dlk)
public function any get (readonly long al_beo_index, readonly string as_class, readonly string as_attribute)
public function long getbcmindex ()
public function n_cst_beo getbeo (readonly string as_expression)
public function string getbeoclass ()
public function integer getbeoclass (ref string as_class[])
public function long getbeoindexdata (ref any aa_columndata[])
protected function long getbeorow (readonly long al_beoindex)
public function integer getcolumnid (readonly string as_class, readonly string as_attribute)
public function long getdata (ref any aa_data[])
public function long getdata (ref string as_data)
public function string gethowtype (readonly string as_class, readonly string as_attribute)
public function n_cst_beo getownerbeo ()
public function integer gettrans (ref transaction atr_tran)
public function long newbeo (ref n_cst_beo anv_beo, readonly n_cst_beo anv_assocbeo, readonly string as_relationshipname)
public function integer registerattribute (readonly string as_attribute, readonly string as_type)
public function integer registerclass (readonly string as_class)
public function integer registerrelationshipattribute (readonly string as_attribute, readonly string as_type, readonly string as_relatedclass, readonly string as_relatedattribute, readonly string as_relationshipname)
public function integer relateclasses (readonly n_cst_beo anv_beo, readonly n_cst_beo anv_relatedbeo, readonly string as_relationshipname)
public function integer resetupdate ()
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
public function integer save ()
public function integer set (readonly long al_beo_index, readonly string as_colname, readonly any aa_value)
public function integer setany (readonly long al_beo_index, readonly string as_class, string as_attribute, any aa_value)
public function integer setdlk (readonly string as_dlk)
public function integer setkey (readonly string as_attribute)
public function integer setownerbeo (readonly n_cst_beo anv_ownerbeo)
public function integer setownerbeo (readonly n_cst_beo anv_ownerbeo, string as_ownerrelationshipname)
public function integer setquery (readonly string as_query)
public function integer settableowner (string as_table, string as_ownername)
public function integer settransobject (readonly transaction atrx_view)
public function integer setunique (readonly string as_attribute)
public function integer setunique (readonly string as_attribute, readonly string as_constraint)
public function integer validate ()
public function boolean ValidateClass (readonly string as_baseclass, readonly string as_ancestorclass)
public function integer mapdbcolumn (readonly string as_attribute, readonly string as_table, readonly string as_column)
public function s_bcmreference serialize ()
public function s_bcmreference getbcm (readonly boolean ab_byref)
public function s_bcmreference getbcm ()
public function integer getattribute (readonly string as_table, readonly string as_column, ref string as_class, ref string as_attribute)
public function integer setappend (readonly boolean ab_append)
public function long getdata (readonly string as_colname[], readonly string as_datatype[], readonly long al_beoindex, ref any aa_data[])
public function long getretrieveddata (readonly string as_colname[], readonly string as_datatype[], ref any aa_data[])
public function integer getupdatecount (ref long al_updated, ref long al_inserted, ref long al_deleted)
public function integer updatespending ()
protected function n_cst_beo createbeo (readonly long al_beo_index, readonly string as_classname)
protected function integer checkuniqueness (readonly long al_beoindex, readonly string as_classname, readonly string as_attribute, readonly any aa_value)
protected function any getnull (readonly string as_type)
protected function integer getclass (readonly string as_classname)
public function n_cst_bcm copy ()
public function n_cst_bcm copy (readonly n_cst_bcmmgr anv_bcmmgr)
protected function integer getbeoindexcolumn ()
protected function integer gettablecolumn (readonly string as_classname, readonly string as_attribute, ref string as_table, ref string as_column)
public function integer presave ()
public function integer postsave ()
public function boolean hasdatachangedduringupdate ()
public function integer setbcm (readonly s_bcmreference astr_ds)
public function integer setbcm (readonly blob ablb_bcm)
public function long getcount ()
public function integer setrelatedbeo (readonly n_cst_beo anv_ownerbeo)
public function long newbeo (ref n_cst_beo anv_beo)
public function any getat (readonly long al_beo_index)
public function any getat (readonly long al_beo_index, readonly string as_beoclass)
public function any getfirst ()
public function any getfirst (readonly string as_beoclass)
public function any getlast ()
public function any getlast (readonly string as_beoclass)
public function any getnext ()
public function any getnext (readonly string as_beoclass)
public function any getprev ()
public function any getprev (readonly string as_beoclass)
public function integer remove (readonly any lany_obj)
public function integer add (ref any lany_obj)
public function integer add (ref any lnv_obj, readonly any lnv_related_obj)
public function integer addclass (readonly string as_classname, readonly boolean ab_updateable)
public function integer getbcm (readonly boolean ab_byref, ref any any_bcm)
public function integer getattributecount (readonly string as_class)
public function integer getattribute (readonly string as_class, readonly integer ai_attribute, ref n_cst_attribute anv_attribute)
public function string getdlkname ()
public function long getrowcount ()
public function integer getattribute (readonly string as_class, readonly string as_attr_relation_name, ref n_cst_attribute anv_attribute[])
public function boolean setdatabase (readonly n_cst_database anv_database)
public function n_cst_database getdatabase ()
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15, readonly any aa_arg16, string as_queryname)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13)
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15)
public function integer reset ()
protected function integer destroybeos ()
public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15, readonly any aa_arg16)
public function integer createdlk ()
public function boolean getremote ()
public function integer createdlk (ref n_cst_dlk anv_dlk)
public function integer setlocal (readonly boolean ab_local)
public function boolean isnew (n_cst_beo anv_beo)
public function boolean ismodified (n_cst_beo anv_beo)
public function string getclass (readonly integer ai_index)
public function string getqueryname ()
public function integer setdbcolumn (readonly long al_idx, readonly string as_table, readonly string as_column)
public function integer append (ref n_cst_bcm anv_bcm)
public function boolean setdlkrelation (readonly string as_dlk_relation)
protected function integer mapcolumns (integer ai_class)
public function integer setthinclient (readonly boolean ab_thinclient)
public function boolean getthinclient ()
public function long newbeo ()
public function integer deletebeo (long al_beoindex)
protected function long getbeoindex (readonly long al_row, dwbuffer adw_buffer)
public function boolean defaultdlk ()
protected function integer validatethinclient ()
protected function boolean getreginitialized ()
protected function integer registerallclasses (long al_beo_index, string as_classname)
protected function n_cst_beo createbeo (long al_beo_index, string as_classname, integer ai_class)
protected function unsignedlong getmetadatablob (ref blob ablb_bcm)
public function long getbeoindex (readonly long al_row)
public function datastore getview ()
protected function integer setmetadatablob (ref blob ablb_bcm)
public function string getcolumnname (readonly string as_class, readonly string as_attribute)
protected function long getbuffersize ()
end prototypes

public function integer addclass (readonly string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddClass
//
//	Arguments:		as_classname	Class name
//
//	Returns:			Integer
//						1	Success
//						-1 Not successful
//
//	Description:	Adds additional updateable class for this BCM
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.1	Initial version
// 2.0 Changed to call new overload.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return this.AddClass(as_classname, true)

end function

public function integer checkrequired (ref string as_class, ref string as_attribute, ref long al_beo_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CheckRequired
//
//	Arguments:		as_class			Reference - missing attribute class name
//						as_attribute	Reference - missing attribute name
//						al_beo_index		Reference - missing required beo_index number
//
//	Returns:			Integer
//						1	no required fields missing
//				 		-1	missing required fields
//
//	Description:	Checks for missing required fields in the BCM DataStore.
//						If a missing required attribute is found the class name,
//						attribute name and the BEO_Index value are returned.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Added multi-class support
//	1.0.2		Update to return class/attribute names
//	1.0.2		Add BCM error service
//	1.2		Changed to get metadata from ids_view metadata functions
//	1.2		Only check required on updateable classes
//	1.20.01	Also loop through filter buffer.
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Boolean lb_check
Int li_col, li_cols, li_class, li_i
Long ll_beo_index, ll_row, ll_last_beo_index
n_cst_beo lnv_beo
n_cst_ofrerror lnv_ofrerror
string ls_class, ls_attribute, ls_last_class
dwbuffer dwb_buffer

if not IsValid(ids_view) then
	return -1
end if

li_cols = this.ids_view.GetColCount()
dwb_buffer = Primary!
for li_i = 1 to 2
	ll_row = ids_view.GetNextModified(0, dwb_buffer)
	do while ll_row > 0
		if ids_view.GetItemStatus(ll_row, 0, dwb_buffer) <> NotModified! then
			ll_beo_index = this.GetBEOIndex(ll_row)
			for li_col = 1 to li_cols
				if IsNull(ids_view.object.data[ll_row, li_col]) then
					if this.ids_view.GetAttribute(li_col, ls_class, ls_attribute) = 1 then
						//	Only get the BEO if it's different
						if ll_beo_index <> ll_last_beo_index and ls_class <> ls_last_class then
							lb_check = false
							//		Ensure class is updateable
							li_class = this.GetClass(ls_class)
							if li_class > 0 then
								if istr_class[li_class].b_updateable then
									lnv_beo = GetAt(ll_beo_index, ls_class)
									ll_last_beo_index = ll_beo_index
									ls_last_class = ls_class
									lb_check = true
								end if
							end if
						else
							lb_check = true
						end if
						if lb_check = true then
							if lnv_beo.IsRequired(ls_attribute) = 1 then
								as_class = ls_class
								as_attribute = ls_attribute
								al_beo_index = ll_beo_index
								lnv_ofrerror = this.AddOFRError()
								lnv_ofrerror.SetBCM(this)
								lnv_ofrerror.SetErrorType(-2)
								lnv_ofrerror.SetClass(as_class)
								lnv_ofrerror.SetAttribute(as_attribute)
								lnv_ofrerror.SetBEOIndex(al_beo_index)
								lnv_ofrerror.SetErrorMessage('Missing required attribute: ' + as_class + '/' + as_attribute)
								return -1
							end if
						end if
					end if
				end if
			next
		end if
		ll_row = ids_view.GetNextModified(ll_row, dwb_buffer)
	loop
	dwb_buffer = Filter!
	next
return 1

end function

public function integer checkuniqueconstraint (readonly string as_class, readonly string as_constraint, readonly any aa_values[], readonly nonvisualobject anv_source_bcm, readonly long al_source_beoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CheckUniqueConstraint
//
//	Arguments:		as_class				Class of constraint
//						as_constraint		Constraint to check
//						aa_values[]			Values to check
//						anv_source_bcm		Source BCM for check values
//						al_source_beoindex	Source beoindex for check values
//
//	Returns:			Integer
//						1		No duplicates
//						0		BCM does not contain all of the constraint columns
//						-1		duplicate value
//						-2		class not found
//						-3		constraint not found
//						-4		not enough values specified
//						-99   Error
//
//	Description:	Checks to see if specified values violate
//						the specified unique constraint.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2		Initial version
//	1.20.04	Add validity check for ids_view
// 2.1		Fix BTR #10979.  Add 'and' operator for multiple columns
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_constraint, li_values, li_class, li_attribute, li_viewcol
long ll_row, ll_rows
string ls_find, ls_oper
datetime ldt_value
boolean lb_found

if not IsValid(ids_view) then
	return -99
end if


// Get the class
li_class = this.GetClass(as_class)
if li_class < 1 then
	return -2
end if

li_values = UpperBound(aa_values)
//	Check for null values, no need check if null
for li_attribute = 1 to li_values
	if IsNull(aa_values[li_attribute]) then
		return 1
	end if
next

//	Find the contraint
for li_constraint = 1 to istr_class[li_class].i_UniqueConstraints
	if as_constraint = istr_class[li_class].unique[li_constraint].s_name then
		lb_found = true
		exit
	end if
next

if lb_found then
	//	Make sure we have enough specified values
	if li_values < istr_class[li_class].unique[li_constraint].i_attributes then
		return -4
	end if
	//	Loop through each contraint attribute and build find string
	for li_attribute = 1 to istr_class[li_class].unique[li_constraint].i_attributes
		li_viewcol = GetColumnID(as_class, istr_class[li_class].unique[li_constraint].s_attribute[li_attribute])
		if li_viewcol > 0 then
			ls_find += ls_oper + " #" + string(li_viewcol) + "="
			choose case Left(ids_view.Describe("#" + String(li_viewcol) + ".coltype"), 5)
			case "char("
				ls_find += '"' + aa_values[li_attribute] + '"'
			case "datet"
				ldt_value = aa_values[li_attribute]
				ls_find += 'datetime(date("' + string(date(ldt_value),"yyyy/mm/dd") +&
								'"),time("' + string(time(ldt_value)) + '"))'
			case "date"
				ls_find += 'date("' + string(aa_values[li_attribute],"yyyy/mm/dd") + '")'
			case "time"
				ls_find += 'time("' + string(aa_values[li_attribute]) + '")'
			case else	// Assume numeric
				ls_find += string(aa_values[li_attribute])
			end choose
			ls_oper = ' and '
		else
			return 0
		end if
	next
	//	Look for duplicate
	ll_rows = ids_view.RowCount()
	ll_row = ids_view.Find(ls_find, 1, ll_rows)
	if ll_row > 0 then
		//		Trap if we found the same BCM/row that is the source of the values
		//		that we are checking with - if so then skip.
		if this = anv_source_bcm and this.GetBEOIndex(ll_row) = al_source_beoindex then
			ll_row = ids_view.Find(ls_find, ll_row + 1, ll_rows + 1)
		end if
	end if
	if ll_row > 0 then
		return -1
	else
		return 1
	end if
else
	return -3
end if

end function

public function integer deletebeo (n_cst_beo anv_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DeleteBEO
//
//	Arguments:		anv_beo	Business object to delete
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Deletes the specified BEO.  Note that this function
//						should only be called from the ofr_n_cst_beo::delete().
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 1.3	Fix the current row iterator when we remove a row.
// 2.1   In remote mode make sure datawindow is updateable.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer li_rc
li_rc = this.DeleteBEO( anv_beo.GetBEOIndex ( ) )

if li_rc > -1 then
	destroy anv_beo
end if

return li_rc

end function

public function integer destroydlk (ref n_cst_dlk anv_dlk);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestroyDLK
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Destroys the DLK used by the BCM
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
int li_rc = 1

if IsValid(anv_dlk) then
	destroy anv_dlk
end if

return li_rc

end function

public function any get (readonly long al_beo_index, readonly string as_class, readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Get
//
//	Arguments:		al_beo_index		BEO_Index for BEO to get attribute value for
//						as_class			BEO class for attribute
//						as_attribute	Attribute to get value for
//
//	Returns:			Any - Value for attribute on specified BEO
//
//	Description:	Returns value for attribute on specified BEO.  Note this
//						function should only be called from 
//						ofr_n_cst_beo::GetValue().
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//	1.0.2	BTR 6634 - check for attributes missing from query, return null
//	1.2	Used view metadata
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
any la_boolean
boolean lb_value
decimal ldec_null
int li_viewcol, li_class, li_anc_class, li_anc_classes
long ll_row
string ls_howtype

ll_row = this.getBEORow ( al_beo_index )
ls_howtype = this.GetHOWType(as_class, as_attribute)

if ll_row > 0 then
	li_viewcol = this.GetColumnID(as_class, as_attribute)
	//		If the class/attribute doesn't work try the ancestor classes
	if li_viewcol < 1 then
		li_class = this.GetClass(as_class)
		li_anc_classes = UpperBound(istr_class[li_class].s_classhierarchy)
		for li_anc_class = 1 to li_anc_classes
			li_viewcol = this.GetColumnID(istr_class[li_class].s_classhierarchy[li_anc_class], as_attribute)
			if li_viewcol > 0 then
				exit
			end if
		next
	end if
	if li_viewcol > 0 then
		if ls_howtype = "boolean" then
			la_boolean = this.ids_view.object.data[ll_row, li_viewcol]
			if IsNull(la_boolean) then
				return this.GetNull(ls_howtype)
			else
				if ClassName(la_boolean) = "string" then
					if Upper(la_boolean) = "Y" then
						lb_value = TRUE
					end if
				else
					if la_boolean <> 0 then
						lb_value = TRUE
					end if
				end if
				return lb_value
			end if
		else
			return this.ids_view.object.data[ll_row, li_viewcol]
		end if
	else
		//		Attribute is not in result set
		this.SetException("get", "29996", {as_attribute})
	end if
else
	//		Invalid row specified
	this.SetException("get", "29995", {String(al_beo_index)})
end if

//	If we got here then we have an error
//	Return null value of proper type
if ls_howtype = '' then
	return -1
else
	return this.GetNull(ls_howtype)
end if

end function

public function long getbcmindex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMIndex
//
//	Arguments:		None
//
//	Returns:			Long		BCM Index
//
//	Description:	Returns this BCM Index
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
return this.ll_bcm_index


end function

public function n_cst_beo getbeo (readonly string as_expression);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEO
//
//	Arguments:		as_expression	Search expression to find BEO with
//
//	Returns:			n_cst_beo			The first BEO found matching the search
//											expression.  If no matching BEO is found
//											then a null BEO is returned.
//
//	Description:	Returns the first BEO for matching the search expression.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.20.04	Add validity check for ids_view
// 2.0 		Add call to GetBEOIndex instead of GetItemNumber
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo lnv_beo
long ll_beo_index
long ll_row


if not IsValid(ids_view) then
	return lnv_beo
end if

// get beo_index from ids_view then attempt to find it
ll_row = ids_view.Find ( as_expression, 1, ids_view.RowCount ( ) )
if ll_row > 0 then
	//ll_beo_index = ids_view.GetItemNumber ( ll_row, this.GetBEOIndexColumn() )
	ll_beo_index = ids_view.GetBeoIndex( ll_row )
	lnv_beo = this.GetAt( ll_beo_index )
end if

return lnv_beo

end function

public function string getbeoclass ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOClass
//
//	Arguments:		None
//
//	Returns:			String Class name of business object (e.g. n_cst_beo_xxxx)
//
//	Description:	Returns primary (first) business object class name
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_class

if UpperBound(istr_class) > 0 then
	ls_class = istr_class[1].s_class
end if

return ls_class

end function

public function integer getbeoclass (ref string as_class[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOClass
//
//	Arguments:		as_class[]	Reference: returned array of BEO classes
//
//	Returns:			Integer	1	Success
//									-1	Error
//
//	Description:	Returns array of all registered business object class names
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
int li_rc = 1, li_class, li_classes
string ls_class[]

li_classes = UpperBound(istr_class)
for li_class = 1 to li_classes
	ls_class[li_class] = istr_class[li_class].s_class
next
as_class = ls_class

return li_rc

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
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rows

ll_rows = ids_view.GetBEOIndexData(aa_columndata)
if ll_rows < 0 then
	this.PushException("getbeoindexdata")
	ll_rows = -1
end if

return ll_rows

end function

protected function long getbeorow (readonly long al_beoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEORow
//
//	Arguments:		al_beoindex	Index of BEO to find
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
//	1.0   	Initial version
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row

if not IsValid(ids_view) then
	return -1
end if

ll_row = this.ids_view.GetBEORow(al_beoindex)

return ll_row
	
end function

public function integer getcolumnid (readonly string as_class, readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetColumnID
//
//	Arguments:		as_class			Class name
//						as_attribute	Attribute to find column id for
//
//	Returns:			Integer
//						> 0		Column ID corresponding to attribute
//						-1			Attribute not found
//
//	Description:	Returns column ID for specified attribute
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Added multi-class support
//	1.2		Changed to call ids_view.FindAttribute()
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc

if not IsValid(ids_view) then
	return -1
end if

li_rc = this.ids_view.GetViewCol(as_class, as_attribute)

return li_rc

end function

public function long getdata (ref any aa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetData
//
//	Arguments:		aa_data[]	Reference - returned data array
//
//	Returns:			Long	Number of rows returned
//						> 0	Number of rows returned
//						< 0	Error
//
//	Description:	Returns BCM data any array
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if not IsValid(ids_view) then
	return -1
end if

if ids_view.RowCount ( ) > 0 then 
	aa_data = ids_view.object.data
end if

return UpperBound ( aa_data )

end function

public function long getdata (ref string as_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetData
//
//	Arguments:		as_data	Reference - BCM data in text format
//
//	Returns:			Long	Number of rows returned
//						> 0	Number of rows returned
//						< 0	Error
//
//	Description:	Returns BCM data in text format
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Long ll_rows

if not IsValid(ids_view) then
	return -1
end if

ll_rows = ids_view.RowCount()
if ll_rows > 0 then
	as_data = ids_view.Object.DataWindow.data
end if

return ll_rows

end function

public function string gethowtype (readonly string as_class, readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetHOWType
//
//	Arguments:		as_class			Class name
//						as_attribute	Attribute name
//
//	Returns:			string			HOW attribute type
//
//	Description:	Returns HOW attribute type for specified class/attribute
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
int li_class, li_attribute, li_attributes
string ls_type

li_class = this.GetClass(as_class)
if li_class > 0 then
	li_attributes = istr_class[li_class].i_attributes
	for li_attribute = 1 to li_attributes
		if as_attribute = istr_class[li_class].attribute[li_attribute].GetName() then
			ls_type = istr_class[li_class].attribute[li_attribute].GetType()
			exit
		end if
	next
end if

return ls_type

end function

public function n_cst_beo getownerbeo ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetOwnerBEO
//
//	Arguments:		None
//
//	Returns:			n_cst_beo	The owner business object of the BCM
//						1		success
//						-1		error
//
//	Description:	Returns the owner business object of the BCM.
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
return inv_ownerbeo

end function

public function integer gettrans (ref transaction atr_tran);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetTrans
//
//	Arguments:		atr_tran		Reference - set to database transaction
//										object being used by BCM
//
//	Returns:			Integer
//						1		success
//						-1		transaction object not valid
//
//	Description:	Returns database transaction object being
//						used by the BCM
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
Int li_rc = 1

if IsValid(itrx_view) then
	atr_tran = itrx_view
else
	li_rc = -1
end if

return li_rc

end function

public function long newbeo (ref n_cst_beo anv_beo, readonly n_cst_beo anv_assocbeo, readonly string as_relationshipname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		NewBEO
//
//	Arguments:		anv_beo		Reference - pointer to newly created BEO
//						anv_assocbeo	Related business object
//						as_relationshipname	Related business object
//													relationship name
//
//	Returns:			Long	Number of rows or -1 if an error occurs
//
//	Description:	Creates a new business object for the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//	1.0.2	BTR 6854 - fix multi-class support
// 1.3   Propagate errors if PostNew fails.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Long ll_row
long ll_beo_index
Long ll_rc
int li_class
n_cst_beo lnv_beo

// 1.3 - Remove old errors.
this.ClearOFRErrors()

if ii_classes = 0 then
	this.SetException("newbeo()", "29997")
	return -1
end if

//		Create view if not already created
if not IsValid(ids_view) then
	this.GetView()
	if not IsValid(ids_view) then
		return -1
	end if
end if

ib_validated = FALSE

// insert a row in the datastore view
if (this.GetThinClient() = FALSE or ib_processpostnew = FALSE) or ib_local = TRUE then
	ll_row = this.ids_view.InsertRow ( 0 )
	ll_beo_index = this.ids_view.GetBEOIndex(ll_row)
	ll_rc = ll_row
end if

if this.GetThinClient() and ib_local = false then
	// Call to SSO to add row.
	if ib_processpostnew = TRUE then
		ll_rc = inv_database.ThinClientNewBEO(this)
		if ll_rc > 0 then
			ids_view.SetBEOIndexForRow(ll_rc)
		end if
	end if
else
	for li_class = 1 to ii_classes
		if istr_class[li_class].b_updateable = true then
			lnv_beo = this.CreateBEO(ll_beo_index, istr_class[li_class].s_class)
			if IsValid(lnv_beo) then
				if IsValid(inv_ownerbeo) then
					lnv_beo.SetRelatedClass(inv_ownerbeo, is_ownerrelationshipname)
				end if
	
				if IsValid(anv_assocbeo) then
					lnv_beo.SetRelatedClass(anv_assocbeo, as_relationshipname)
				end if
	
				// execute PostNew event in BEO instance.
				if ( lnv_beo.Event ofr_PostNew ( ) = -1 ) then				// postnew failed backout
					// 1.3 - Move errors to BCM before destroying BEO.
					this.PropagateErrors(lnv_beo)
					this.DeleteBEO ( lnv_beo )		// back out new object
					return -1
				end if
	
				//	Assign argument BEO to the first class
				if li_class = 1 then
					anv_beo = lnv_beo
				end if
			else
				this.PushException("newbeo")
				ll_rc = -1
			end if
		end if
	next
end if

return ll_rc

end function

public function integer registerattribute (readonly string as_attribute, readonly string as_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterAttribute
//
//	Arguments:		as_attribute	Logical attribute name
//						as_type			Logical attribute datatype
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Call this function from the RegisterClass
//						function of descendent business objects in
//						order to define attributes associated
//						to the business object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	2.0		Add create of attribute class
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_attributes

istr_class[ii_regclass].i_attributes++
li_attributes = istr_class[ii_regclass].i_attributes
istr_class[ii_regclass].attribute[li_attributes] = create n_cst_attribute
// 2.0 - SVH//if istr_class[ii_regclass].attribute[li_attributes].Initialize(inv_current_reg_beo.ClassName(), //as_attribute, lower(as_type), ii_reghierarchyclass ) <> 1 then
if istr_class[ii_regclass].attribute[li_attributes].Initialize(istr_class[ii_regclass], as_attribute, lower(as_type) ) <> 1 then
	li_rc = -1
end if

return li_rc

end function

public function integer registerclass (readonly string as_class);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterClass
//
//	Arguments:		as_class		Class name to register
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Call this function from the RegisterClass
//						function of descendent business objects in
//						order to define class hierarchy.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	1.20.04	Keep track of class in hiearchy being registered
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_class, li_classes
boolean lb_found

li_classes = UpperBound(istr_class[ii_regclass].s_classhierarchy)
for li_class = 1 to li_classes
	if as_class = istr_class[ii_regclass].s_classhierarchy[li_classes] then
		lb_found = true
		exit
	end if
next

if lb_found = false then
	// R1.20.04
	li_classes++
	istr_class[ii_regclass].s_classhierarchy[li_classes] = as_class
end if

//	R1.20.04 - save which class in hiearchy attributes are being registered for
//svh removed
//ii_reghierarchyclass = li_class


return 1

end function

public function integer registerrelationshipattribute (readonly string as_attribute, readonly string as_type, readonly string as_relatedclass, readonly string as_relatedattribute, readonly string as_relationshipname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterRelationshipAttribute
//
//	Arguments:		as_attribute			Logical attribute name
//						as_type					Logical attribute datatype
//						as_relatedclass		FK related class name
//						as_relatedattribute	FK related attribute name
//						as_relationshipname	FK relationship name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers a FK column
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//	2.0	Add attribute object
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1, li_attribute

//		Register attribute
if RegisterAttribute(as_attribute, as_type) = 1 then
	//		Last attribute is one we just registered
	li_attribute = istr_class[ii_regclass].i_attributes
	// 	Set fk information
	if istr_class[ii_regclass].attribute[li_attribute].SetRelationshipInfo(as_relatedclass, as_relatedattribute, as_relationshipname) = 1 then
		li_rc = 1
	end if
end if

return li_rc

end function

public function integer relateclasses (readonly n_cst_beo anv_beo, readonly n_cst_beo anv_relatedbeo, readonly string as_relationshipname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		relateclasses
//
//	Arguments:		anv_beo			BEO to related class to
//						anv_relatedbeo	Related BEO to relate from
//						as_relationshipname	Optional relationship name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Used to assign a relationship (e.g. FK) between
//						the two specified business objects.
//						FOR INTERNAL OFR USE ONLY.

//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//	1.2	Changed to use ids_view metadata
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1, li_col, li_cols, li_class, li_attribute, li_attributes
string ls_class, ls_attribute
string ls_relatedclass, ls_relatedattribute, ls_relationshipname

if NOT isValid(anv_beo) or NOT isValid(anv_relatedbeo) then
	return -1
end if

li_class = this.GetClass(anv_beo.ClassName())
li_attributes = istr_class[li_class].i_attributes

li_cols = this.ids_view.GetColCount()
for li_col = 1 to li_cols
	if this.ids_view.GetAttribute(li_col, ls_class, ls_attribute) = 1 then
		//		See if column is part of primary class
		if anv_beo.ValidateClass(ls_class) then
			//		Find the attribute
			for li_attribute = 1 to li_attributes
				if ls_attribute = istr_class[li_class].attribute[li_attribute].GetName() then
					
					//svh 
					ls_relatedclass = istr_class[li_class].attribute[li_attribute].GetRelatedClass()
					if ls_relatedclass <> '' then
						//		See if column FK class matches related BEO
						if anv_relatedbeo.ValidateClass(ls_relatedclass) then
							ls_relationshipname = istr_class[li_class].attribute[li_attribute].GetRelationshipName()
							if as_relationshipname = ls_relationshipname or as_relationshipname = '' then
								ls_relatedattribute = istr_class[li_class].attribute[li_attribute].GetRelatedName()
								if anv_beo.SetAny(ls_attribute, anv_relatedbeo.Get(ls_relatedattribute)) = 1 then
									li_rc = 1
								else
									return -1
								end if
							end if
						end if
						exit
					end if
				end if
			next
		end if
	end if
next

return li_rc

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
//	Description:	Resets the update flags associated to the BCM Datastore
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Make sure is valid
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

if IsValid(ids_view) then
	if ids_view.ResetUpdate() <> 1 then
		this.PushException("resetupdate")
		li_rc = -1
	end if
end if

return li_rc

end function

public function long retrieve ();Any la_arg[16]

return Retrieve(la_arg[1], la_arg[2], la_arg[3], la_arg[4], la_arg[5], la_arg[6], la_arg[7], &
la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], &
la_arg[16], "")

end function

public function long retrieve (readonly any aa_arg1);Any la_arg[16]

return Retrieve(aa_arg1, la_arg[2], la_arg[3], la_arg[4], la_arg[5], la_arg[6], &
la_arg[7], la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], &
la_arg[14], la_arg[15], la_arg[16], "")

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, la_arg[3], la_arg[4], la_arg[5], la_arg[6], la_arg[7], &
la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], &
la_arg[16], "")


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, la_arg[4], la_arg[5], la_arg[6], la_arg[7], &
la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], &
la_arg[16], "")


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, la_arg[5], la_arg[6], la_arg[7], &
la_arg[8], la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], &
la_arg[16], "")


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, la_arg[6], la_arg[7], la_arg[8],&
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], &
la_arg[16], "")


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, la_arg[7], la_arg[8], &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16],&
"")


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, la_arg[8], &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16], &
"")


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3,aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
la_arg[9], la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16], "")


end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9);Any la_arg[16]

return Retrieve(aa_arg1,aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, aa_arg9, &
la_arg[10], la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16], "")

end function

public function integer save ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Save
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		successfully saved changes
//						-1		error
//
//	Description:	Saves changes made to the business objects
//						associated with the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
// 1.0.1.2 Fix for inherited update
//	1.0.2	BTR 6760 - add validation check
//	1.0.2	Added BCM error processing
//	1.0.2 BTR 6784 - correct order of updates deletes then inserts/updates
//	1.2	Call save on DLK
// 1.2	Save now occurs on transaction manager (txmgr)
// 2.0   Update of the database now occurs when Commit is called.  Save 
//			only registers with the transaction manager.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer 		li_rc = 1
n_cst_txmgr	lnv_txmgr

if IsValid(inv_database) then
	if inv_database.GetRemote() then
		// Go through the Database if this is a remote BCM.
		inv_database.Register(this)
		if inv_database.Save() <> 1 then
			this.PropagateErrors(inv_database)
			li_rc = -1
		end if
		inv_database.Unregister()
		return li_rc
	end if
end if

// If there is no Database or it is local, do normal save.
lnv_txmgr = create n_cst_txmgr
if IsValid(lnv_txmgr) then
	lnv_txmgr.Register(this)
	if lnv_txmgr.Save() <> 1 then
		this.PropagateErrors(lnv_txmgr)
		li_rc = -1
	end if
	destroy lnv_txmgr
else
	li_rc = -1
end if

return li_rc
end function

public function integer set (readonly long al_beo_index, readonly string as_colname, readonly any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		al_beo_index		BEO Index of value to set
//						as_colname		Column name
//						aa_value			New value
//
//	Returns:			Integer
//						2		success and other attributes updated
//						1		success
//						0		attempt to set unregistered column
//						-1		error
//
//	Description:	Sets value by calling BEO set method.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.1 	Initial version
//	1.2		Changed to take column name
// 1.20.01 	BUG #8321 - Allow computed columns to be set.
// 1.20.03 	Make sure null values are set.
// 2.1 		Thin Client support.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
boolean lb_classfound
int li_rc = -1, li_col, li_class, li_viewcol
n_cst_beo lnv_beo
string ls_class, ls_attribute
long ll_row

this.ClearOFRErrors()

// When in Thin Client Mode, don't do the Set through the BEO.
if not this.ib_thinclient then
	//		Force registration if not already loaded
	if this.GetRegInitialized() = false then
		if not IsValid(this.GetAt(al_beo_index)) then
			this.PushException("set")
			return -1
		end if
	end if

	if this.ids_view.GetAttribute(as_colname, ls_class, ls_attribute) = 1 then
		//		Find proper updateable class
		for li_class = 1 to ii_classes
			if istr_class[li_class].b_Updateable = true then
				lnv_beo = this.GetAt(al_beo_index, istr_class[li_class].s_class)
				if IsValid(lnv_beo) then
					if lnv_beo.ValidateClass(ls_class) then
						lb_classfound = true
						li_rc = lnv_beo.SetAny(ls_attribute, aa_value)
						if li_rc = -1 then
							this.PropagateErrors(lnv_beo)
						end if
						exit
					end if
				else
					this.PushException("beoset")
					exit
				end if
			end if
		next
		if lb_classfound = false then
			this.SetException("set", "29998", {ls_class, ls_attribute})
		end if
		
		return li_rc
	end if
end if

// BUG #8321 - Allow computed columns to be set.  Also, set values when in Thin Client mode.
ll_row = this.getBEORow(al_beo_index)
li_viewcol = Integer(this.ids_view.Describe(as_colname + ".id"))
li_rc = 0
if ll_row > 0 and li_viewcol > 0 then
	// 1.20.03 - Make sure null values are set.
	if IsNull(aa_value) then
		ids_view.Object.Data[ll_row, li_viewcol] = this.GetNull(this.ids_view.GetColType(li_viewcol))
	else
		li_rc = this.ids_view.SetItem(ll_row, as_colname, aa_value)
	end if
end if
//
		
return li_rc

end function

public function integer setany (readonly long al_beo_index, readonly string as_class, string as_attribute, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetAny

//
//	Arguments:		al_beo_index		BEO Index of value to set
//						as_class			Classname
//						as_attribute	Attribute name to set
//						aa_value			Value to set attribute to
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets the attribute value on the BCM Datastore.
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//	1.0.2	Raise exception for missing attributes
//	1.0.2	Add unique constraint error checking
//	1.2	Replaced BCM metadata references with ids_view metadata functions
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row
int li_rc, li_class, li_regcol, li_viewcol, li_anc_class, li_anc_classes
string ls_coltype
n_cst_ofrerror lnv_ofrerror

ll_row = this.getBEORow ( al_beo_index )

if ll_row > 0 then
	li_viewcol = this.GetColumnID(as_class, as_attribute)
	//		If the class/attribute doesn't work try the ancestor classes
	if li_viewcol < 1 then
		li_class = this.GetClass(as_class)
		li_anc_classes = UpperBound(istr_class[li_class].s_classhierarchy)
		for li_anc_class = 1 to li_anc_classes
			li_viewcol = this.GetColumnID(istr_class[li_class].s_classhierarchy[li_anc_class], as_attribute)
			if li_viewcol > 0 then
				exit
			end if
		next
	end if
	if li_viewcol > 0 then
		if IsNull(aa_value) then
			ids_view.Object.Data[ll_row, li_viewcol] = this.GetNull(this.ids_view.GetColType(li_viewcol))
			li_rc = 1
		else
			//		Convert boolean to proper database type
			if this.GetHOWType(as_class, as_attribute) = "boolean" then
				ls_coltype = this.ids_view.GetColType(li_viewcol)
				if Left(ls_coltype, 4) = "char" then
					if aa_value = TRUE then
						aa_value = "Y"
					else
						aa_value = "N"
					end if
				else			// Assume numeric
					if aa_value = TRUE then
						aa_value = 1
					else
						aa_value = 0
					end if
				end if
			end if
			if this.CheckUniqueness(al_beo_index, as_class, as_attribute, aa_value) = 1 then
				li_rc = this.ids_view.SetItem(ll_row, li_viewcol, aa_value)
			else
				lnv_ofrerror = this.AddOFRError()
				lnv_ofrerror.SetBCM(this)
				lnv_ofrerror.SetErrorType(-3)
				lnv_ofrerror.SetClass(as_class)
				lnv_ofrerror.SetAttribute(as_attribute)
				lnv_ofrerror.SetBEOIndex(al_beo_index)
				lnv_ofrerror.SetErrorMessage('Value is not unique: ' + as_class + '/' + as_attribute)
				li_rc = -1
			end if
		end if
		ib_validated = FALSE
	else
		this.SetException("setany", "29996", {as_attribute})
		li_rc = -1
	end if
else
	this.SetException("setany", "29995", {String(al_beo_index)})
	li_rc = -1
end if

return li_rc
end function

public function integer setdlk (readonly string as_dlk);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDLK
//
//	Arguments:		as_dlk		DLK object
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Identifies DLK to be used by BCM.
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
int li_rc = 1

this.is_dlk = as_dlk

return li_rc

end function

public function integer setkey (readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetKey
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Marks the specified attribute as an primary key column
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1, li_attribute, li_attributes

li_attributes = istr_class[ii_regclass].i_attributes
for li_attribute = li_attributes to 1 step -1
	if as_attribute = istr_class[ii_regclass].attribute[li_attribute].GetName() then
		if istr_class[ii_regclass].attribute[li_attribute].SetKey(TRUE) = 1 then
			li_rc = 1
		end if
		exit
	end if
next

return li_rc

end function

public function integer setownerbeo (readonly n_cst_beo anv_ownerbeo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetOwnerBEO
//
//	Arguments:		anv_ownerbeo		Owner BEO for this BCM
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	
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
return this.SetOwnerBEO(anv_ownerbeo, "")

end function

public function integer setownerbeo (readonly n_cst_beo anv_ownerbeo, string as_ownerrelationshipname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetOwnerBEO
//
//	Arguments:		anv_ownerbeo		Owner BEO for this BCM
//						as_ownerrelationshipname	Optional relationship name of
//											how this owner BEO is related
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	
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
inv_ownerbeo = anv_ownerbeo
is_ownerrelationshipname = as_ownerrelationshipname

return 1

end function

public function integer setquery (readonly string as_query);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetQuery
//
//	Arguments:		as_query		A DataWindow object name or syntax for
//										a DataWindow object
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets the query used for the BCM Datastore.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Added multi-class support
//	1.0.1.3	Add case sensitivity to dbname (e.g. remove lower)
//	1.02.5	Add call to GetViewCols
//	1.2		Support for DLK's
// 2.1 		Fix BTR #8375.  Remove hard coded dlk prefix
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_dlk_prefix

ls_dlk_prefix = this.GetBCMMgr().GetDLKPrefix()

if Lower(Left(as_query,len(ls_dlk_prefix))) = Lower(ls_dlk_prefix) then
	return this.SetDLK(as_query)
else
	is_query = as_query
end if

return 1

end function

public function integer settableowner (string as_table, string as_ownername);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetTableOwner
//
//	Arguments:		as_table		Database table name
//						as_class		Business object class name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Registers the owner prefix to be used for a table
//						like dbeo.employee
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.1.2	Initial version
//	1.0.2		BTR 6897 - fix case sensitvity (remove lower)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_table, li_tables
boolean lb_found

li_tables = UpperBound(is_tableowner)
for li_table = 1 to li_tables
	if as_table = is_tableowner[li_table].s_table then
		is_tableowner[li_table].s_owner = as_ownername
		lb_found = true
		exit
	end if
next

if lb_found = false then
	li_tables ++
	is_tableowner[li_table].s_table = as_table
	is_tableowner[li_table].s_owner = as_ownername
end if

return 1

end function

public function integer settransobject (readonly transaction atrx_view);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetTransObject
//
//	Arguments:		atrx_view	Database transaction object to assign to BCM
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Assigns database transaction object to the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	If view already created then do SetTransObject immediately
//	1.2	Updated for DLK support
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

itrx_view = atrx_view

return li_rc

end function

public function integer setunique (readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUnique
//
//	Arguments:		as_attribute	Attribute name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Identifies attribute as part of a unique constraint
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Moved to DLK
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//		Single attribute contraint
//		Default contraint name to attribute name
return SetUnique(as_attribute, as_attribute)

end function

public function integer setunique (readonly string as_attribute, readonly string as_constraint);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUnique
//
//	Arguments:		as_attribute	Attribute name

//						as_contraint	Name of unique constraint
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Identifies attribute as part of a unique constraint
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
// 2.1	Check to see a class is registered first
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_constraint, li_constraints, li_attributes
boolean lb_found

if ii_regclass = 0 then
	return -1
end if	

li_constraints = istr_class[ii_regclass].i_UniqueConstraints


for li_constraint = 1 to li_constraints
	if istr_class[ii_regclass].unique[li_constraint].s_name = as_constraint then
		li_attributes = istr_class[ii_regclass].unique[li_constraint].i_attributes + 1
		istr_class[ii_regclass].unique[li_constraint].i_attributes = li_attributes
		istr_class[ii_regclass].unique[li_constraint].s_attribute[li_attributes] = as_attribute
		lb_found = true
	end if
next

if lb_found = false then
	li_constraints++
	istr_class[ii_regclass].i_UniqueConstraints = li_constraints
	istr_class[ii_regclass].unique[li_constraints].s_name = as_constraint
	istr_class[ii_regclass].unique[li_constraints].i_attributes = 1
	istr_class[ii_regclass].unique[li_constraints].s_attribute[1] = as_attribute
end if

return 1

end function

public function integer validate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Validate
//
//	Arguments:		none
//
//	Returns:			Integer
//						1	no errors
//				 		-1	BEO error found
//
//	Description:	Checks for BEO errors by invoking the Validate method
//						on all BEO's that have been modified and are updateable.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2		Initial Version
//	1.20.01	Also loop through filter buffer.
//	1.20.04	Add validity check for ids_view
// 2.1      Fix BTR# 12115 - Get BEOIndex from primary then filter buffers
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Int li_rc = 1, li_col, li_regcol, li_class, li_i
string ls_class, ls_attribute
Long ll_beo_index, ll_row
n_cst_ofrerror lnv_ofrerror
n_cst_beo lnv_beo
dwbuffer dwb_buffer

if this.ib_thinclient = true and this.ib_local = false then
	this.SetException("validate", "29989", {""})
	return -1
end if

//		If not registered then there can't be anything to update.
if this.GetRegInitialized() = false then
	return 1
end if

if not IsValid(ids_view) then
	return -1
end if

this.ClearOFRErrors()

if this.ib_thinclient then
	if this.ValidateThinClient() = -1 then
		return -1
	end if
end if

if this.CheckRequired(ls_class, ls_attribute, ll_beo_index) = 1 then
	dwb_buffer = Primary!
	for li_i = 1 to 2
		ll_row = ids_view.GetNextModified(0, dwb_buffer)
		do while ll_row > 0
			if ids_view.GetItemStatus(ll_row, 0, dwb_buffer) <> NotModified! then
			//		Get BEO
			ll_beo_index = this.GetBEOIndex(ll_row, dwb_buffer)
			//		Check each updateable class
			for li_class = 1 to ii_classes
				if istr_class[li_class].b_Updateable = true then
					lnv_beo = this.GetAt(ll_beo_index, istr_class[li_class].s_class)
					if isValid(lnv_beo) then
						if lnv_beo.Validate() <> 1 then
							this.PropagateErrors(lnv_beo)
							return -1
						end if
					end if
				end if
			next
		end if
			ll_row = ids_view.GetNextModified(ll_row, dwb_buffer)
		loop
		dwb_buffer = Filter!
	next
	ib_validated = TRUE
else
	li_rc = -1
end if

return li_rc

end function

public function boolean ValidateClass (readonly string as_baseclass, readonly string as_ancestorclass);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ValidateClass
//
//	Arguments:		as_baseclass		Concrete class name
//						as_ancestorclass	Class name to check
//
//	Returns:			Boolean inidicating if part of class
//
//	Description:	Checks to see if the specified class is part of
//						class hierarchy for the specified base class.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//	1.2	Use new class hierarchy info
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int i, li_class, li_hierarchyclasses

li_class = this.GetClass(as_baseclass)

li_hierarchyclasses = UpperBound(istr_class[li_class].s_classhierarchy)
for i = 1 to li_hierarchyclasses
	if as_ancestorclass = istr_class[li_class].s_classhierarchy[i] then
		return TRUE
	end if
next 

return FALSE
end function

public function integer mapdbcolumn (readonly string as_attribute, readonly string as_table, readonly string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapDBColumn
//
//	Arguments:		as_attribute	Attribute name
//						as_table			Database table
//						as_column		Database column
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Call this function from the RegisterClass
//						function of descendent business objects in
//						order to map an attribute to a table/column.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
// 2.1      Don't call SetDBColumn if dlk is not specified.  When dlk is specified
//          this is handled in it's constructor.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = -1, li_attribute, li_attributes

if this.DefaultDLK() then
	li_attributes = istr_class[ii_regclass].i_attributes
	for li_attribute = 1 to li_attributes
		if as_attribute = istr_class[ii_regclass].attribute[li_attribute].GetName() then
			istr_class[ii_regclass].attribute[li_attribute].SetDBColumn(as_table, as_column)
			li_rc = 1
			exit
		end if
	next
end if

return li_rc

end function

public function s_bcmreference serialize ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Serialize
//
//	Arguments:		none
//
//	Returns:			s_bcmreference	Copy of this BCM
//
//	Description:	Returns a newly created BCM as a copy of this BCM
//
//						FOR INTERNAL USE ONLY
//
//						NOTE THIS FUNCTION IS SUBJECT TO CHANGE AND/OR REMOVAL
//						IN FUTURE RELEASES.
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
int li_rc = -1, li_class, li_classes, li_attribute, li_attributes
long ll_beo, ll_beos, ll_req
s_bcmreference lstr_ds

//		Create view if not already created
if not IsValid(ids_view) then
	this.GetView()
end if

lstr_ds = this.ids_view.Serialize()

blob lblb_bcm
//begin modification by appeon 20070815
//lblb_bcm = Blob(Space( This.GetBufferSize ( ) ))  //OVERRIDING lblb_bcm = Blob(Space(60000))
long ll_size
//debugbreak()
ll_size = This.GetBufferSize ( )
lblb_bcm = Blob(Space( ll_size))
//end modification by appeon 20070815

if this.GetMetaDataBlob(lblb_bcm) > 0 then
	lstr_ds.blb_bcm = lblb_bcm
end if

return lstr_ds

end function

public function s_bcmreference getbcm (readonly boolean ab_byref);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		ab_byref			How BCM is to be passed (ref or value)
//
//	Returns:			s_bcmreference		Structure containing either reference
//												to BCM or BCM data serialized.
//
//	Description:	Returns a structure containing this BCM. If the ab_byref
//						argument is true then a pointer to this BCM is stored in
//						the structure. If ab_byref = false then data for this BCM
//						is stored in the structure.
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
s_bcmreference lstr_bcmref
powerobject lpo_any

if ab_byref then
	lpo_any = this
	lstr_bcmref.nv_bcm = lpo_any
	this.ib_byref = true
else
	lstr_bcmref = this.Serialize()
end if

return lstr_bcmref

end function

public function s_bcmreference getbcm ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		none
//
//	Returns:			s_bcmreference		Structure containing either reference
//												to BCM or BCM data serialized.
//
//	Description:	Returns a structure containing this BCM.
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
return this.GetBCM(ib_byref)

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
//	1.0   	Initial version
//	1.0.1		Added multi-class support
//	1.0.1.3	Add case sensitivity to dbname (e.g. remove lower)
//	1.2		Changed to pass table and column names
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1

if not IsValid(ids_view) then
	return -1
end if

if ids_view.GetAttribute(as_table, as_column, as_class, as_attribute) <> 1 then
	li_rc = -1
end if

return li_rc

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

public function long getdata (readonly string as_colname[], readonly string as_datatype[], readonly long al_beoindex, ref any aa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetData
//
//	Arguments:		as_colname[]		column names
//						as_datatype[]		column datatypes
//						al_beoindex	starting beoindex of rows to copy
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
//	1.2   	Initial version
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rows

if not IsValid(ids_view) then
	return -1
end if

ll_rows = this.ids_view.GetData(as_colname, as_datatype, al_beoindex, aa_data)

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
//	1.2   	Initial version
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_rows

if not IsValid(ids_view) then
	return -1
end if

ll_rows = this.ids_view.GetRetrievedData(as_colname, as_datatype, aa_data)

return ll_rows

end function

public function integer getupdatecount (ref long al_updated, ref long al_inserted, ref long al_deleted);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetUpdateCount
//
//	Arguments:		al_updated		Rows updated
//						al_inserted		Rows inserted
//						al_deleted		Rows deleted
//
//	Returns:			Integer
//						1		Success
//						-1		error
//
//	Description:	Returns number of rows updated from last database update
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
return this.ids_view.GetUpdateCount(al_updated, al_inserted, al_deleted)

end function

public function integer updatespending ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		UpdatesPending
//
//	Arguments:		none
//
//	Returns:			integer
//						1	Updates pending
//						0	No updates pending
//
//	Description:	Returns indicator as to whether DS has been modified
//						FOR INTERNAL OFR USE ONLY.
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
int li_rc

if IsValid(this.ids_view) then
	li_rc = this.ids_view.UpdatesPending()
end if

return li_rc

end function

protected function n_cst_beo createbeo (readonly long al_beo_index, readonly string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateBEO
//
//	Arguments:		ai_elem		Array element to create BEO in
//						al_beo_index	BEO_Index value for BEO
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Creates a business object
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.0.1		Added multi-class support
//	1.2		Use al_beo_index as index value to BEO array
//	1.20.02	Call to MapColumns for each class as they are created
// 2.1  		Rewrite.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright (c) 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_class
n_cst_beo lnv_beo

li_class = this.GetClass(as_classname)
if li_class < 1 then
	li_class = this.RegisterAllClasses(al_beo_index, as_classname)
elseif istr_class[li_class].b_registered = false then
	li_class = this.RegisterAllClasses(al_beo_index, as_classname)	
end if

if li_class < 1 then
	return lnv_beo
end if

// See if the BEO has already been created
if al_beo_index <= UpperBound(istr_class[li_class].nv_beolist) then
	lnv_beo = istr_class[li_class].nv_beolist[al_beo_index]
end if

if not isValid(lnv_beo) then
	lnv_beo = this.CreateBEO(al_beo_index, as_classname, li_class)
end if

return lnv_beo

end function

protected function integer checkuniqueness (readonly long al_beoindex, readonly string as_classname, readonly string as_attribute, readonly any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CheckUniqueness
//
//	Arguments:		al_beoindex		BEOIndex of BEO being set
//						as_classname	Classname
//						attribute		Attribute to check uniquness on
//						aa_value			New attribute value
//
//	Returns:			Integer
//						1		No duplicates
//						-1		duplicate value
//
//	Description:	Checks for uniqueness constraint violations
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.1	Added multi-class support
//	1.0.2	BTR 4125 - Finish implementation
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_class, li_constraint, li_attribute
long ll_bcms, ll_bcm
ofr_n_cst_bcm lnv_bcms[]
n_cst_beo lnv_beo
any lany_colvalues[]
boolean lb_found

//	Loop through each unique constraint for the class
li_class = this.GetClass(as_classname)
for li_constraint = 1 to istr_class[li_class].i_UniqueConstraints
	//	Loop through each attribute of the unique constraint
	lb_found = false
	for li_attribute = 1 to istr_class[li_class].unique[li_constraint].i_attributes
		//	see if attribute matches an attribute of the constraint
		if as_attribute = istr_class[li_class].unique[li_constraint].s_attribute[li_attribute] then
			lb_found = true
			exit
		end if
	next
	if lb_found then
		//	Grab all attribute values that make up the constraint to check
		lnv_beo = this.GetAt(al_beoindex)
		for li_attribute = 1 to istr_class[li_class].unique[li_constraint].i_attributes
			if as_attribute = istr_class[li_class].unique[li_constraint].s_attribute[li_attribute] then
				lany_colvalues[li_attribute] = aa_value
			else
				lany_colvalues[li_attribute] = lnv_beo.Get(istr_class[li_class].unique[li_constraint].s_attribute[li_attribute])
			end if
		next
		if this.CheckUniqueConstraint(istr_class[li_class].s_class, istr_class[li_class].unique[li_constraint].s_name, lany_colvalues, this, al_beoindex) = -1 then
			return -1
		end if
//		this.GetBCMMGR().GetBCMs(lnv_bcms)
//		ll_bcms = UpperBound(lnv_bcms)
//		for ll_bcm = 1 to ll_bcms
//			if IsValid(lnv_bcms[ll_bcm]) then
//				//	Check each bcm with a matching class
//				if ls_this_class = lnv_bcms[ll_bcm].GetBEOClass() then
//					if lnv_bcms[ll_bcm].CheckUniqueConstraint(istr_class[li_class].name, istr_class[li_class].unique[li_constraint].name, lany_colvalues) = -1 then
//						return -1
//					end if
//				end if
//			end if
//		next
	end if
next

return 1

end function

protected function any getnull (readonly string as_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetNull
//
//	Arguments:		as_type	DataWindow or HOW datatype
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Returns null value of appropriate type
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2		Initial version
//	1.2		Changed to take datatype
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
any la_rc
blob lblob_null
boolean lb_null
datetime ldt_null
date ld_null
double ldbl_null
string ls_null
time lt_null

choose case Left(as_type, 5)
	case "blob"
		SetNull(lblob_null)
		la_rc = lblob_null
	case "boole"
		SetNull(lb_null)
		la_rc = lb_null
	case "char(", "chara", "strin"
		SetNull(ls_null)
		la_rc = ls_null
	case "datet"
		SetNull(ldt_null)
		la_rc = ldt_null
	case "date"
		SetNull(ld_null)
		la_rc = ld_null
	case "time"
		SetNull(lt_null)
		la_rc = lt_null
	case else
		SetNull(ldbl_null)
		la_rc = ldbl_null
end choose

return la_rc

end function

protected function integer getclass (readonly string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetClass
//
//	Arguments:		as_classname	Classname
//
//	Returns:			Integer
//						>0		Index for class
//						-1		Class not found
//
//	Description:	Returns class index for specified classname
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.1	Added multi-class support
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_class
int li_rc = -1

for li_class = 1 to ii_classes
	if istr_class[li_class].s_class = as_classname then
		li_rc = li_class
		exit
	end if
next

return li_rc

end function

public function n_cst_bcm copy ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Copy
//
//	Arguments:		none
//
//	Returns:			n_cst_bcm	Copy of this BCM
//
//	Description:	Returns a newly created BCM as a copy of this BCM
//
//						FOR INTERNAL USE ONLY
//
//						NOTE THIS FUNCTION IS SUBJECT TO CHANGE AND/OR REMOVAL
//						IN FUTURE RELEASES.
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
return this.Copy(this.GetBCMMGR())

end function

public function n_cst_bcm copy (readonly n_cst_bcmmgr anv_bcmmgr);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Copy
//
//	Arguments:		none
//
//	Returns:			n_cst_bcm	Copy of this BCM
//
//	Description:	Returns a newly created BCM as a copy of this BCM
//
//						FOR INTERNAL USE ONLY
//
//						NOTE THIS FUNCTION IS SUBJECT TO CHANGE AND/OR REMOVAL
//						IN FUTURE RELEASES.
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
s_bcmreference lstr_bcm
n_cst_bcm lnv_bcm

lstr_bcm = this.GetBCM(false)
lnv_bcm = this.GetBCMMGR().CreateBCM(lstr_bcm)

return lnv_bcm

end function

protected function integer getbeoindexcolumn ();//////////////////////////////////////////////////////////////////////////////
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
return this.ids_view.GetBEOIndexColumn()

end function

protected function integer gettablecolumn (readonly string as_classname, readonly string as_attribute, ref string as_table, ref string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetTableColumn
//
//	Arguments:		as_classname
//						as_attribute
//						as_table
//						as_column
//
//	Returns:			int
//
//	Description:	For compatiblity only
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
int li_rc = -1, li_class, li_attribute, li_attributes
string ls_type

li_class = this.GetClass(as_classname)
if li_class > 0 then
	li_attributes = istr_class[li_class].i_attributes
	for li_attribute = 1 to li_attributes
		if as_attribute = istr_class[li_class].attribute[li_attribute].GetName() then
			if istr_class[li_class].attribute[li_attribute].GetDBCount() > 0 then
				as_table = istr_class[li_class].attribute[li_attribute].GetDBTable(1)
				as_column = istr_class[li_class].attribute[li_attribute].GetDBColumn(1)
				li_rc = 1
				exit
			end if
		end if
	next
end if

return li_rc
end function

public function integer presave ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		PreSave
//
//	Arguments:		none
//
//	Returns:			Integer
//						1	Success
//				 		-1	Error
//
//	Description:	Executes pre-save logic on each modified BEO.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	1.20.01	Also loop through filter buffer.
// 1.3		Propagate errors from BEO like we do for Validate.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_class, li_classes, li_i
Long ll_beo_index, ll_row
n_cst_beo lnv_beo
dwbuffer dwb_buffer

//		If not registered then there can't be anything to update.
if this.GetRegInitialized() = false then
	return 1
end if

li_classes = UpperBound(istr_class)
dwb_buffer = Primary!
for li_i = 1 to 2
	ll_row = ids_view.GetNextModified(0, dwb_buffer)
	do while ll_row > 0
		if ids_view.GetItemStatus(ll_row, 0, dwb_buffer) <> NotModified! then
			ll_beo_index = this.GetBEOIndex(ll_row)
			for li_class = 1 to ii_classes
				if istr_class[li_class].b_updateable = true then
					lnv_beo = this.GetAt(ll_beo_index, istr_class[li_class].s_class)
					if lnv_beo.event ofr_PreSave() <> 1 then
						// 1.3
						this.PropagateErrors(lnv_beo)
						//
						return -1
					end if
				end if
			next
		end if
		ll_row = ids_view.GetNextModified(ll_row, dwb_buffer)
	loop
dwb_buffer = Filter!
next

return 1

end function

public function integer postsave ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		PostSave
//
//	Arguments:		none
//
//	Returns:			Integer
//						1	Success
//				 		-1	Error
//
//	Description:	Executes post-save logic on each modified BEO.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	1.20.01	Also loop through filter buffer.
// 1.3		Propagate errors from BEO like we do for Validate.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_class, li_classes, li_i
Long ll_beo_index, ll_row
n_cst_beo lnv_beo
dwbuffer dwb_buffer

//		If not registered then there can't be anything to update.
if this.GetRegInitialized() = false then
	return 1
end if

li_classes = UpperBound(istr_class)
dwb_buffer = Primary!
for li_i = 1 to 2
	ll_row = ids_view.GetNextModified(0, dwb_buffer)
	do while ll_row > 0
		if ids_view.GetItemStatus(ll_row, 0, dwb_buffer) <> NotModified! then
			ll_beo_index = this.GetBEOIndex(ll_row)
			for li_class = 1 to ii_classes
				if istr_class[li_class].b_updateable = true then
					lnv_beo = this.GetAt(ll_beo_index, istr_class[li_class].s_class)
					if lnv_beo.event ofr_PostSave() <> 1 then
						// 1.3
						this.PropagateErrors(lnv_beo)
						// 
					return -1
					end if
				end if
			next
		end if
	ll_row = ids_view.GetNextModified(ll_row, Primary!)
	loop
next

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
//	Description:	Returns indicator as to whether the result set has changed
//						during the update process.
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
return this.ids_view.HasDataChangedDuringUpdate()


end function

public function integer setbcm (readonly s_bcmreference astr_ds);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCM
//
//	Arguments:		astr_ds		Serialized info
//
//	Returns:			Integer		1 success
//										-1 error
//
//	Description:	Recreates BCM state from specified serialization info.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2	   Initial version
// 1.20.05 	Don't call NewBEO because it causes PostNew to fire.
// 2.1  		Added the bcm reference value and append functionality 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int 			li_rc = 1
n_cst_bcm 	lnv_bcm_new

if this.ib_append then
	this.SetLocal(True)
	lnv_bcm_new = this.GetBCMMGR().CreateBCM(astr_ds)
	this.append(lnv_bcm_new)
	this.SetLocal(False)
	this.GetBCMMGR().DestroyBCM(lnv_bcm_new)
else
	destroy ids_view  //destroy the old view first
	this.ids_view = create n_bcm_ds
	this.ids_view.SetBCMMgr(this.GetBCMMgr())
	
	if this.ids_view.Deserialize(astr_ds) <> 1 then
		this.SetException("SetBCM()", "29987")
		li_rc = -1
	end if

	if this.SetMetaDataBlob(astr_ds.blb_bcm) < 1 then
		li_rc = -1
	end if
end if

return li_rc


end function

public function integer setbcm (readonly blob ablb_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCM
//
//	Arguments:		ablb_bcm		Serialized info
//
//	Returns:			Integer		1 success
//										-1 error
//
//	Description:	Recreates BCM state from specified serialization info.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1	   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
blob 			lblb_bcmmetadata, lblb_view
int 			li_rc = 1, li_class, li_classes
unsignedlong ul_rc = 1, ul_len
n_cst_bcm lnv_bcm_new
string ls_temp

if this.ib_append then
	this.SetLocal(True)
	lnv_bcm_new = this.GetBCMMGR().CreateBCM(ablb_bcm)
	this.append(lnv_bcm_new)
	this.SetLocal(False)
	this.GetBCMMGR().DestroyBCM(lnv_bcm_new)
else
	ls_temp = String(BlobMid(ablb_bcm, ul_rc, 15))
	ul_rc = ul_rc + len(ls_temp) + 1
	ul_len = Long(ls_temp)
	if ul_rc <=0 then
		return -1
	end if
	
	//	Get BCM Metadata
	lblb_bcmmetadata = BlobMid(ablb_bcm, ul_rc, ul_len - 1)
	ul_rc = ul_rc + ul_len
	
	//	Get DataStore data
	lblb_view = BlobMid(ablb_bcm, ul_rc)
		
	this.ids_view = create n_bcm_ds
	this.ids_view.SetBCMMgr(this.GetBCMMgr())
	if this.ids_view.Deserialize(lblb_view) <> 1 then
		this.SetException("SetBCM()", "29987")
		return -1
	end if
	
	if this.SetMetaDataBlob(lblb_bcmmetadata) < 0 then
		return -1
	end if
end if

return li_rc

end function

public function long getcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetCount
//
//	Arguments:		none
//
//	Returns:			long
//
//	Description:	Returns total BEO's in collection.
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
Long ll_rows

if IsValid(ids_view) then
	ll_rows = ids_view.RowCount() - ids_view.DeletedCount()
else
	ll_rows = -1
end if

return ll_rows

return ll_rows

end function

public function integer setrelatedbeo (readonly n_cst_beo anv_ownerbeo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRelatedBEO
//
//	Arguments:		anv_ownerbeo		Related BEO for this BCM
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets non-owning BEO from which this collection was
//						derived from (ex: the department BEO for these emps).
//						FOR INTERNAL OFR USE ONLY.
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
inv_relatedbeo = anv_ownerbeo

return 1

end function

public function long newbeo (ref n_cst_beo anv_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		NewBEO
//
//	Arguments:		anv_beo		Reference - pointer to newly created BEO
//
//	Returns:			Long	Number of rows or -1 if an error occurs
//
//	Description:	Creates a new business object for the BCM.
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

return this.newbeo(anv_beo, lnv_null, "")

end function

public function any getat (readonly long al_beo_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAt
//
//	Arguments:		al_beo_index	BEO_Index of BEO to get
//
//	Returns:			any				BEO for specified BEO_Index.  Null if BEO is
//											not found or error occurs.
//
//	Description:	Returns the BEO for specified BEO_Index.
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
n_cst_beo lnv_beo

if ii_classes = 0 then
	this.SetException("getat", "29997")
else
	lnv_beo = this.GetAt(al_beo_index, this.GetBEOClass())
end if

return lnv_beo

end function

public function any getat (readonly long al_beo_index, readonly string as_beoclass);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAt
//
//	Arguments:		al_beo_index	BEO_Index of BEO to get
//						as_beoclass		BEO class to return
//
//	Returns:			any				BEO for specified BEO_Index.  Null if BEO is
//											not found or error occurs.
//
//	Description:	Returns the specified BEO class for specified BEO_Index.
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
n_cst_beo lnv_beo
Long ll_row

// Make sure the beo_index being requested exists
ll_row = this.GetBEORow(al_beo_index)
if ll_row > 0 then
	il_currow = ll_row
	lnv_beo = this.CreateBEO(al_beo_index, as_beoclass)
	if NOT IsValid(lnv_beo) then
		this.PushException("getat")
	end if
end if

return lnv_beo

end function

public function any getfirst ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetFirst
//
//	Arguments:		as_beoclass		BEO class to get
//
//	Returns:			any				BEO
//
//	Description:	Returns first BEO in BCM.
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
return this.GetFirst(this.GetBEOClass())

end function

public function any getfirst (readonly string as_beoclass);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetFirst
//
//	Arguments:		as_beoclass		BEO class to get
//
//	Returns:			any				BEO
//
//	Description:	Returns first BEO in BCM for the specified class.
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
long ll_beo_index
n_cst_beo lnv_beo

ll_beo_index = this.GetBEOIndex(1)

if ll_beo_index > 0 then
	il_currow = 1
	lnv_beo = this.GetAt(ll_beo_index, as_beoclass)
end if

return lnv_beo

end function

public function any getlast ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetLast
//
//	Arguments:		none
//
//	Returns:			any		BEO
//
//	Description:	Returns last BEO in BCM.
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
return this.GetLast(this.GetBEOClass())

end function

public function any getlast (readonly string as_beoclass);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetLast
//
//	Arguments:		as_beoclass		Class name to get
//
//	Returns:			any				BEO for specified class
//
//	Description:	Returns last BEO in BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   	Initial version
//	1.20.04	Add validity check for ids_view
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo lnv_beo
long ll_beoindex

if not IsValid(ids_view) then
	return lnv_beo
end if

il_currow = ids_view.RowCount()
if il_currow > 0 then
	ll_beoindex = this.GetBEOIndex(il_currow)
	if ll_beoindex > 0 then
		lnv_beo = this.GetAt(ll_beoindex, as_beoclass)
	end if
end if

return lnv_beo

end function

public function any getnext ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetNext
//
//	Arguments:		none
//
//	Returns:			any			BEO
//
//	Description:	Returns next BEO based on previous navigation method
//						calls (GetFirst, GetAt, GetPrev, GetLast).
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
return this.GetNext(this.GetBEOClass())

end function

public function any getnext (readonly string as_beoclass);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetNext
//
//	Arguments:		as_beoclass		Class name to get
//
//	Returns:			any				BEO for specified class
//
//	Description:	Returns next BEO based on previous navigation method
//						calls (GetFirst, GetAt, GetPrev, GetLast).
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
n_cst_beo lnv_beo
long ll_beoindex

ll_beoindex = this.GetBEOIndex(il_currow + 1)
if ll_beoindex > 0 then
	il_currow ++
	lnv_beo = this.GetAt(ll_beoindex, as_beoclass)
end if

return lnv_beo

end function

public function any getprev ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetPrev
//
//	Arguments:		none
//
//	Returns:			any			BEO
//
//	Description:	Returns the previous BEO based on last navigation method
//						called (GetFirst, GetAt, GetNext, GetLast).
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
return this.GetPrev(this.GetBEOClass())

end function

public function any getprev (readonly string as_beoclass);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetPrev
//
//	Arguments:		as_beoclass		BEO class name to get
//
//	Returns:			any				BEO for specified class
//
//	Description:	Returns the previous BEO based on last navigation method
//						called (GetFirst, GetAt, GetNext, GetLast).
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
n_cst_beo lnv_beo
long ll_beoindex

if il_currow > 1 then
	ll_beoindex = this.GetBEOIndex(il_currow - 1)
	if ll_beoindex > 0 then
		il_currow --
		lnv_beo = this.GetAt(ll_beoindex, as_beoclass)

	end if
end if

return lnv_beo

end function

public function integer remove (readonly any lany_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Remove
//
//	Arguments:		lany_obj		Object to remove from collection
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Removes object from collection that has been derived from
//						a related BEO. If this collection was derived from an
//						owning relationship (ex: items for order) then the BEO will
//						be deleted. If this collection was derived from a
//						non-owning relationship (ex: employees for a department)
//						then the BEO FK will be nullified.
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
int li_rc = -1, li_col, li_cols, li_class, li_attribute, li_attributes
string ls_class, ls_attribute
string ls_relatedclass, ls_relatedattribute, ls_relationshipname

//		Insure we have owning relationship on BCM
if NOT IsValid(lany_obj) or &
		( NOT IsValid(inv_ownerbeo) and NOT IsValid(inv_relatedbeo) ) then
	return -1
end if

//li_class = this.GetClass(anv_beo.ClassName())
//li_attributes = istr_class[li_class].i_attributes
//
//li_cols = this.ids_view.GetColCount()
//for li_col = 1 to li_cols
//	if this.ids_view.GetAttribute(li_col, ls_class, ls_attribute) = 1 then
//		//		See if column is part of primary class
//		if anv_beo.ValidateClass(ls_class) then
//			//		Find the attribute
//			for li_attribute = 1 to li_attributes
//				if ls_attribute = istr_class[li_class].attribute[li_attribute].s_attribute then
//					ls_relatedclass = istr_class[li_class].attribute[li_attribute].s_relatedclass
//					if ls_relatedclass <> '' then
//						//		See if column FK class matches related BEO
//						if anv_relatedbeo.ValidateClass(ls_relatedclass) then
//							ls_relationshipname = istr_class[li_class].attribute[li_attribute].s_relationshipname
//							if as_relationshipname = ls_relationshipname or as_relationshipname = '' then
//								ls_relatedattribute = istr_class[li_class].attribute[li_attribute].s_relatedattribute
//								if anv_beo.SetAny(ls_attribute, anv_relatedbeo.Get(ls_relatedattribute)) = 1 then
//									li_rc = 1
//								else
//									return -1
//								end if
//							end if
//						end if
//						exit
//					end if
//				end if
//			next
//		end if
//	end if
//next

return li_rc

end function

public function integer add (ref any lany_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Add
//
//	Arguments:		lany_obj		Returned add object
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Adds object to a collection that has been derived from
//						an owning relationship (ex: line item for an order).
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
int li_rc = 1
n_cst_beo lnv_beo

//		Insure we have owning relationship on BCM
if NOT isValid(inv_ownerbeo) then
	return -1
end if

if this.NewBEO(lnv_beo) < 1 then
	this.PushException("add")
	li_rc = -1
end if
lany_obj = lnv_beo

return li_rc

end function

public function integer add (ref any lnv_obj, readonly any lnv_related_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Add
//
//	Arguments:		lany_obj				Returned add object
//						lany_related_obj	Related object to add to collection
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Adds a related object to a collection that has been
//						derived from an non-owning relationship
//						(ex: employees for a department).
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
int li_rc = 1

//		Insure we have non-owning relationship on BCM
if NOT isValid(inv_relatedbeo) then
	return -1
end if

//		Need to add object to collection without inserting into the database
//		Add employye to department employee collection - you want to add the
//		employee BEO to this collection however you do not want to add the
//		employee to the database but rather simply associate the department
//		to the employee.

//if this.NewBEO(lnv_obj, lnv_related_obj, '') < 1 then
//	this.PushException("add")
//	li_rc = -1
//end if

return li_rc

end function

public function integer addclass (readonly string as_classname, readonly boolean ab_updateable);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddClass
//
//	Arguments:		as_classname	Class name
//
//	Returns:			Integer
//						1	Success
//						-1 Not successful
//
//	Description:	Adds additional class for this BCM
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0	Initial version with 2 arguments.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer li_class

//svh - avoid registering classes more than once
for li_class = 1 to ii_classes
	if as_classname = istr_class[li_class].s_class then
		return 1
	end if
next

ii_classes++
istr_class[ii_classes].s_class = as_classname
istr_class[ii_classes].b_updateable = ab_updateable

Return 1

end function

public function integer getbcm (readonly boolean ab_byref, ref any any_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		ab_byref			How BCM is to be passed (ref or value)
//						any_bcm			Returned BCM
//
//	Returns:			int	1	Success
//								-1	Failure
//
//	Description:	Returns a blob containing this BCM. If the ab_byref
//						argument is true then a pointer to this BCM is stored in
//						the blob. If ab_byref = true then data for this BCM
//						stored in the blob.
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
blob lblb_bcm, lblb_view
unsignedlong ul_rc
int li_rc = 1

if ab_byref then
	any_bcm = this
	return 1
end if

//		Create view if not already created
if not IsValid(ids_view) then
	this.GetView()
end if

//		Initialize buffer
lblb_bcm = blob(space( This.GetBufferSize ( ) ))  //OVERRIDING lblb_bcm = blob(space(60000))

lblb_bcm = lblb_bcm + lblb_bcm + lblb_bcm + lblb_bcm

ul_rc = this.GetMetaDataBlob(lblb_bcm)
if ul_rc < 0 then
	return -1
end if

blob temp
temp = blob(space(len(string(ul_rc - 1)) + 1))
BlobEdit(temp, 1, string(ul_rc - 1))
lblb_bcm = temp + lblb_bcm
ul_rc = ul_rc + Len(string(ul_rc - 1)) + 1

li_rc = this.ids_view.Serialize(lblb_view)

any_bcm = BlobMid(lblb_bcm, 1, ul_rc - 1) + lblb_view

return li_rc

end function

public function integer getattributecount (readonly string as_class);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttributeCount
//
//	Arguments:		as_class			Class name
//
//	Returns:			integer			Total attributes
//
//	Description:	Returns total attributes for specified class
//						FOR INTERNAL USE ONLY
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
int li_rc = -1, li_class

li_class = this.GetClass(as_class)
if li_class > 0 then
	li_rc = istr_class[li_class].i_attributes
end if

return li_rc

end function

public function integer getattribute (readonly string as_class, readonly integer ai_attribute, ref n_cst_attribute anv_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		as_class			Class name
//						ai_attribute	Attribute index
//						anv_attribute	Returned attribute object
//
//	Returns:			integer			1	Success
//											-1	Error
//
//	Description:	Returns HOW attribute object for specified class/attribute
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
int li_rc = -1, li_class

li_class = this.GetClass(as_class)
if li_class > 0 then
	if ai_attribute <= istr_class[li_class].i_attributes then
		anv_attribute = istr_class[li_class].attribute[ai_attribute]
		li_rc = 1
	end if
end if

return li_rc

end function

public function string getdlkname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDLKName
//
//	Returns:			String name of the DLK class being used.
//
//	Description:	Used by relationship methods to determine if same query 
//						was already used to retrieve.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_query
if this.is_dlk <> "" then
	ls_query = this.is_dlk
else
	ls_query = this.is_query
end if

return ls_query

end function

public function long getrowcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRowCount
//
//	Arguments:		None
//
//	Returns:			Long. Number of rows in the view
//
//	Description:	Returns number of rows from last retrieve
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if not IsValid(ids_view) then
	return 0
end if

return this.ids_view.RowCount()

end function

public function integer getattribute (readonly string as_class, readonly string as_attr_relation_name, ref n_cst_attribute anv_attribute[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		as_class					  Class name
//						as_attr_relation_name  The relationship_name of the attribute to get
//						anv_attribute[]		  Array of returned attribute objects
//
//	Returns:			integer			1	Success
//											-1	Error
//
//	Description:	Returns HOW attribute objects for specified class/relationship
//						If no attributes are found for a relationship then return the
//						Primary key attributes.  It's an array because you an have compound	
//						keys.
//						FOR INTERNAL USE ONLY
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
int li_rc = -1, li_class
int li_attr, li_next = 0

//first look for relationships
li_class = this.GetClass(as_class)
if li_class > 0 then
	for li_attr = 1 to istr_class[li_class].i_attributes  
		if istr_class[li_class].attribute[li_attr].GetRelationshipName() = as_attr_relation_name then
			li_next = UpperBound(anv_attribute) + 1
			anv_attribute[li_next] = istr_class[li_class].attribute[li_attr]
			li_rc = 1
		end if
	next
	
	if li_next = 0 then  //if no relationships were found get the primary key
		for li_attr = 1 to istr_class[li_class].i_attributes
			if istr_class[li_class].attribute[li_attr].GetKey() = true then
				li_next = UpperBound(anv_attribute) + 1
				anv_attribute[li_next] = istr_class[li_class].attribute[li_attr]
				li_rc = 1
			end if
		next
	end if
end if


return li_rc

end function

public function boolean setdatabase (readonly n_cst_database anv_database);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDatabase
//
//	Arguments:		anv_database Instance of the database related to this bcm
//
//	Returns:			Boolean
//
//	Description:	Sets Database associated with this bcm.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if isValid(anv_database) then
	this.inv_database = anv_database	
	this.SetThinClient(inv_database.GetThinClient())
	return true
else
	return false
end if
end function

public function n_cst_database getdatabase ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDatabase
//
//	Arguments:		none
//
//	Returns:			n_cst_database	Returns the database associated with this bcm
//
//	Description:	Returns the database associated with this bcm.
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
return inv_database

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15, readonly any aa_arg16, string as_queryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		String	relationship name to set on the dlk
//						Any		aa_argn	0 to 16 retrieval arguments
//						String	as_queryname - placeholder (this may be removed in a future release)
//
//	Returns:			Long
//						>= 0		Number of rows returned by retrieve
//						< 0		error
//
//	Description:	Retrieves a BCM Datastore using the optional
//						specified retrieval arguments.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Update to call DLK
// 2.1   Distributed support - ib_local=TRUE indicates it came from sso
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long 				ll_rowcount, ll_beo_index
long 				ll_i, ll_upper
int 				li_class, li_classes
string			ls_query
n_cst_query		lnv_query

// If the query already has results in it we would want to destroy any BEO's that may have
// been instantiated
if ib_append = false then
	li_classes = UpperBound(istr_class)
	for li_class = 1 to li_classes
		ll_upper = UpperBound (istr_class[li_class].nv_beolist)
		for ll_i = 1 to ll_upper
			if IsValid(istr_class[li_class].nv_beolist[ll_i]) then
				Destroy istr_class[li_class].nv_beolist[ll_i]
			end if
		next
	next
end if

if this.GetRemote() and not ib_local then
	if not inv_database.Open() then
		ll_rowcount = -1
	else
		lnv_query = inv_database.GetQuery()
		lnv_query.SetBCM(this)
		lnv_query.SetArgument(aa_arg1)
		lnv_query.SetArgument(aa_arg2)
		lnv_query.SetArgument(aa_arg3)
		lnv_query.SetArgument(aa_arg4)
		lnv_query.SetArgument(aa_arg5)
		lnv_query.SetArgument(aa_arg6)
		lnv_query.SetArgument(aa_arg7)
		lnv_query.SetArgument(aa_arg8)
		lnv_query.SetArgument(aa_arg9)
		lnv_query.SetArgument(aa_arg10)
		lnv_query.SetArgument(aa_arg11)
		lnv_query.SetArgument(aa_arg12)
		lnv_query.SetArgument(aa_arg13)
		lnv_query.SetArgument(aa_arg14)
		lnv_query.SetArgument(aa_arg15)
		lnv_query.SetArgument(aa_arg16)
		
		
		if is_dlk = "n_cst_dlk" then
			ls_query = is_query
		else
			ls_query = is_dlk
		end if
		if isValid(lnv_query.ExecuteQuery(ls_query)) then
			if isValid(ids_view) then
				ll_rowcount = ids_view.RowCount() 
			else
				ll_rowcount = -1
			end if
		else
			ll_rowcount = -1
		end if
	end if
else
	if this.CreateDLK() <> 1 then
		this.SetException("retrieve", "29986")
		this.PushException("retrieve")
		ll_rowcount = -1
	end if
	
	if ll_rowcount = 0 then
//		inv_dlk.SetQueryName(as_queryname)
		inv_dlk.SetArgument(aa_arg1)
		inv_dlk.SetArgument(aa_arg2)
		inv_dlk.SetArgument(aa_arg3)
		inv_dlk.SetArgument(aa_arg4)
		inv_dlk.SetArgument(aa_arg5)
		inv_dlk.SetArgument(aa_arg6)
		inv_dlk.SetArgument(aa_arg7)
		inv_dlk.SetArgument(aa_arg8)
		inv_dlk.SetArgument(aa_arg9)
		inv_dlk.SetArgument(aa_arg10)
		inv_dlk.SetArgument(aa_arg11)
		inv_dlk.SetArgument(aa_arg12)
		inv_dlk.SetArgument(aa_arg13)
		inv_dlk.SetArgument(aa_arg14)
		inv_dlk.SetArgument(aa_arg15)
		inv_dlk.SetArgument(aa_arg16)
		
		inv_dlk.SetAppend(ib_append)
		inv_dlk.SetDLKRelation(is_dlk_relation)
		
		ll_rowcount = inv_dlk.Retrieve()
		if ll_rowcount < 0 then
			this.SetException("Retrieve()", "25999", {String(ll_rowcount)})
			This.PropagateErrors(inv_dlk)
			ll_rowcount = -1
		elseif ll_rowcount > 0 and ib_thinclient = true then
			// Create a BEO to load the metadata for thin client mode.
			ll_beo_index = this.GetBEOIndex(1, Primary!)
			if upperbound(istr_class[]) > 0 and ll_beo_index > 0 then
				this.GetAt(ll_beo_index, istr_class[1].s_class)
			end if
		end if
		//  No longer destroy dlk.  CreateDLK will determine when it needs to
		//  recreate a dlk or use the same one.
		//this.DestroyDLK(inv_dlk)
	end if
end if

inv_database.deactivate()

return ll_rowcount

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5,aa_arg6, aa_arg7, aa_arg8, aa_arg9, &
aa_arg10, la_arg[11], la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16], "")

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, &
aa_arg8, aa_arg9, aa_arg10, aa_arg11, aa_arg12, la_arg[13], la_arg[14], la_arg[15], &
la_arg[16], "")

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9, aa_arg10, aa_arg11, aa_arg12, aa_arg13, aa_arg14, la_arg[15], la_arg[16], "")

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9, aa_arg10, aa_arg11, la_arg[12], la_arg[13], la_arg[14], la_arg[15], la_arg[16], "")

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13);Any la_arg[16]

return Retrieve(aa_arg1,aa_arg2, aa_arg3, aa_arg4,aa_arg5, aa_arg6, aa_arg7, aa_arg8, aa_arg9, &
aa_arg10, aa_arg11, aa_arg12, aa_arg13, la_arg[14], la_arg[15], la_arg[16], "")

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9,aa_arg10,aa_arg11, aa_arg12, aa_arg13, aa_arg14, aa_arg15, la_arg[16], "")

end function

public function integer reset ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Reset
//
//	Arguments:		None
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears the data in the BCM.  
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

// Reset BCM variables
il_currow = 0

this.DestroyBEOs()

if isValid(ids_view) then
	// Reset Datastore
	return ids_view.Reset()
end if

return 1

end function

protected function integer destroybeos ();integer li_classes, li_class
long ll_beos, ll_beo
n_cst_beo lnv_beolist[]

li_classes = UpperBound(istr_class)
for li_class = 1 to li_classes
	if IsValid(istr_class[li_class]) then
		ll_beos = UpperBound (istr_class[li_class].nv_beolist)
		for ll_beo = 1 to ll_beos
			if IsValid(istr_class[li_class].nv_beolist[ll_beo]) then
				Destroy istr_class[li_class].nv_beolist[ll_beo]
			end if
		next
	end if
	if IsValid(istr_class[li_class]) then
		istr_class[li_class].nv_beolist = lnv_beolist
	end if
next

return 1

end function

public function long retrieve (readonly any aa_arg1, readonly any aa_arg2, readonly any aa_arg3, readonly any aa_arg4, readonly any aa_arg5, readonly any aa_arg6, readonly any aa_arg7, readonly any aa_arg8, readonly any aa_arg9, readonly any aa_arg10, readonly any aa_arg11, readonly any aa_arg12, readonly any aa_arg13, readonly any aa_arg14, readonly any aa_arg15, readonly any aa_arg16);Any la_arg[16]

return Retrieve(aa_arg1, aa_arg2, aa_arg3, aa_arg4, aa_arg5, aa_arg6, aa_arg7, aa_arg8, &
aa_arg9,aa_arg10,aa_arg11, aa_arg12, aa_arg13, aa_arg14, aa_arg15, aa_arg16, "")

end function

public function integer createdlk ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateDLK
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Creates the DLK for the BCM
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 2.1   BTR #11858 - Don't create a dlk if it's already there
// 2.1   BTR #8650,6748,9625 - Destory dlk and ids_view if query passed in 
//										 is not the same as the current one
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_class, li_classes, li_attribute, li_attributes
int li_col, li_cols, li_ownertables, li_table
boolean lb_found
n_cst_dlk_init lnv_dlk_init
powerobject lpo_parm
string ls_table
n_cst_query lnv_query

if this.GetRemote() and not ib_local then
	// For remote BCMs, we must call GetDefintion to create ids_view.
	// The DLK will not be created.  
	lnv_query = inv_database.GetQuery()
	if not isValid(lnv_query) then
		return -1
	end if
	
	if not inv_database.Open() then
		return -1
	end if

	lnv_query.SetBCM(this)
	if isValid(lnv_query.GetDefinition(is_dlk)) then
		if isValid(ids_view) then
			li_rc = 1
		else
			li_rc = -1
		end if
	else
		li_rc = -1
	end if
	
destroy lnv_query

else
	li_ownertables = UpperBound(is_tableowner)
	
	//don't create a dlk if it's already there
	if isValid(inv_dlk) then
		//destroy the old dlk first and create a new one of a new class
		if lower(is_dlk) <> lower(Classname(inv_dlk)) then
			this.DestroyDLK(inv_dlk)
			//  Because the query passed in is different than the current datasource
			//  we need to destory ids_view so that the new query can be picked up and 
			//  registered properly
			destroy this.ids_view
		elseif inv_dlk.DefaultDLK() and is_query <> inv_dlk.GetDataSource() then
			this.DestroyDLK(inv_dlk)
			//  Because the query passed in is different than the current datasource
			//  we need to destory ids_view so that the new query can be picked up and 
			//  registered properly
			destroy this.ids_view
		else
			inv_dlk.ClearArguments()
		end if
	end if
	
	if not IsValid(inv_dlk) then
		lnv_dlk_init = create n_cst_dlk_init
		lnv_dlk_init.ids_view = this.ids_view
		lnv_dlk_init.itrx_view = this.itrx_view
		lnv_dlk_init.inv_bcm = this
	
		lpo_parm = Message.PowerObjectParm
		Message.PowerObjectParm = lnv_dlk_init
	
	
		if is_dlk = "n_cst_dlk" then
			inv_dlk = CREATE n_cst_dlk
		else
			inv_dlk = CREATE using is_dlk
		end if
		destroy lnv_dlk_init
		Message.PowerObjectParm = lpo_parm
	end if
	
	if IsValid(inv_dlk) then
		if is_query <> '' then
			li_classes = UpperBound(istr_class)
				for li_class = 1 to li_classes
					if istr_class[li_class].b_updateable = true then
						li_attributes = UpperBound(istr_class[li_class].attribute)
						for li_attribute = 1 to li_attributes
							li_cols = istr_class[li_class].attribute[li_attribute].GetDBCount()
							for li_col = 1 to li_cols
								//		Register update table
								ls_table = istr_class[li_class].attribute[li_attribute].GetDBTable(li_col)
								if ls_table <> "" then  //beo_index can be an empty table
									//		Look to see if table owner has been specified
									lb_found = false
									for li_table = 1 to li_ownertables
										if ls_table = is_tableowner[li_table].s_table then
											inv_dlk.RegisterUpdateTable(ls_table, is_tableowner[li_table].s_owner)
											lb_found = true
											exit
										end if
									next
								//		No table owner then just register without owner
									if lb_found = false then
										inv_dlk.RegisterUpdateTable(ls_table)
									end if
								end if
							next
						next
					end if
				next
	
			if inv_dlk.SetDataSource(this.is_query) <> 1 then
				li_rc = -1
			end if
		end if
		if li_rc = 1 then
			this.ids_view = inv_dlk.GetView()
//			if this.GetRemote() then
				this.ids_view.SetRequestor(inv_dlk)
//			end if
		end if
	else
		li_rc = -1
	end if
end if

inv_database.deactivate()

return li_rc


end function

public function boolean getremote ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRemote
//
//	Arguments:		none
//
//	Returns:			Boolean
//
//	Description:	Indicates if this BCM requires serialization to the server 
//						when it is saved.
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

if isvalid(inv_database) then
	return inv_database.GetRemote()
else
	return false
end if
end function

public function integer createdlk (ref n_cst_dlk anv_dlk);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateDLK
//
//	Arguments:		anv_dlk - Reference to DLK object.
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Creates the DLK for the BCM
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
if this.CreateDLK() = 1 then
	anv_dlk = inv_dlk
	return 1
else
	return -1
end if
end function

public function integer setlocal (readonly boolean ab_local);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLocal
//
//	Arguments:		ab_local		local indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets indicator as to whether bcm is called from sso
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
this.ib_local = ab_local

return 1

end function

public function boolean isnew (n_cst_beo anv_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		isNew
//
//	Arguments:		anv_beo	Business object to determine if it's new
//
//	Returns:			Boolean
//						True		BEO is a new row
//						False		BEO is not new
//
//	Description:	Determines if the specified BEO is a new row.  Note that this 
//						function	should be called from ofr_n_cst_beo::isNew().
//						FOR INTERNAL OFR USE ONLY.
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
long ll_row
boolean lb_new
dwitemStatus  l_itemstatus

ll_row = this.GetBEORow ( anv_beo.GetBEOIndex ( ) )

if ll_row > 0 then
	l_itemstatus =  this.ids_view.GetItemStatus ( ll_row, 0, Primary! )
	choose case l_itemstatus
		CASE New!, NewModified!
			lb_new = true
	end choose
end if

return lb_new
end function

public function boolean ismodified (n_cst_beo anv_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		isModified
//
//	Arguments:		anv_beo	Business object to determine if it's been changed
//
//	Returns:			Boolean
//						True		BEO has been modifed
//						False		BEO has not been modified
//
//	Description:	Determines if the specified BEO has been modifed.  Note that this 
//						function	should be called from ofr_n_cst_beo::isModifed().
//						FOR INTERNAL OFR USE ONLY.
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
long ll_row
integer li_cols, li_thiscol, li_indexcol
boolean lb_mod
dwitemStatus  l_itemstatus

ll_row = this.GetBEORow ( anv_beo.GetBEOIndex ( ) )

if ll_row > 0 then
	l_itemstatus =  this.ids_view.GetItemStatus ( ll_row, 0, Primary! ) //get row status
	choose case l_itemstatus
		CASE DataModified!, NewModified! 
			//verify modification was not beo index
			li_cols = integer(this.ids_view.Object.DataWindow.Column.Count)
			li_indexcol = this.GetBEOIndexColumn()
			for li_thiscol = 1 TO li_cols
				l_itemstatus  = this.ids_view.GetItemStatus ( ll_row, li_thiscol, Primary! )
				if l_itemstatus = DataModified! and li_indexcol <> li_thiscol then
					lb_mod = true
					exit
				end if
			next
	end choose
end if

return lb_mod
end function

public function string getclass (readonly integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetClass
//
//	Arguments:		ai_index	Index of the class name
//
//	Returns:			Classname
//
//	Description:	Returns classname for specified class index
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if UpperBound(istr_class) >= ai_index then
  return istr_class[ai_index].s_class 
else
	return ""
end if

end function

public function string getqueryname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetQueryName
//
//	Arguments:		None
//
//	Returns:			String 	Query name of BCM
//
//	Description:	Returns the query object associated with the BCM
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1   Initial version
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_query
if this.is_dlk <> "n_cst_dlk" then  //a 'real' dlk was passed in
	ls_query = this.is_dlk
else
	ls_query = this.is_query
end if

return ls_query

end function

public function integer setdbcolumn (readonly long al_idx, readonly string as_table, readonly string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDBColumn
//
//	Arguments:		as_table		attribute table
//						as_column	attribute name
//
//	Returns:			Integer
//						>0		success
//						-1		error
//
//	Description:	Register table and column information for a class
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
int li_rc = 1, li_attributes

istr_class[al_idx].i_attributes++
li_attributes = istr_class[al_idx].i_attributes
istr_class[al_idx].attribute[li_attributes] = create n_cst_attribute

if istr_class[al_idx].attribute[li_attributes].SetDBColumn(as_table, as_column) <> 1 then
	li_rc = -1
end if

return li_attributes

end function

public function integer append (ref n_cst_bcm anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Append
//
//	Arguments:		anv_bcm	BCM to append to this BCM
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Appends anv_bcm to this bcm
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

int li_rc = 1
n_bcm_ds lds_view


lds_view = this.GetView()
if not IsValid(lds_view) then
	return -1
end if

lds_view.Append(anv_bcm.GetView())

return li_rc

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

protected function integer mapcolumns (integer ai_class);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapColumns
//
//	Arguments:		ai_class		Class columns to map
//
//	Returns:			integer	1	Success
//									-1	Error
//
//	Description:	Registers class/attribute mapping information with DS
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.2			Initial version
//	1.20.02		Add specified class argument
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright (c) 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc = 1, li_attribute, li_attributes, li_col, li_cols, li_key
boolean lb_attributemapped

//		If we are using a query (e.g. not a DLK) as a datasource then
//		we need to push the mapping info to the datastore
if is_query <> "" then
	//		Identify attributes based on dbname
	li_attributes = istr_class[ai_class].i_attributes
	lb_attributemapped = false
	for li_attribute = 1 to li_attributes
		li_cols = istr_class[ai_class].attribute[li_attribute].GetDBCount()
		for li_col = 1 to li_cols
			if this.ids_view.MapDBName( &
				istr_class[ai_class].attribute[li_attribute].GetClass(), &
				istr_class[ai_class].attribute[li_attribute].GetName(), &
				istr_class[ai_class].attribute[li_attribute].GetDBTable(li_col), &
				istr_class[ai_class].attribute[li_attribute].GetDBColumn(li_col)) = 1 then
					lb_attributemapped = true
			end if
		next
	next
	if lb_attributemapped = false and istr_class[ai_class].b_updateable then
		//		Updateable class has no columns in result set
		this.SetException("mapcolumns", "29999", {istr_class[ai_class].s_class})
		return -1
	end if
	//		Map attributes to all table/columns
	for li_attribute = 1 to li_attributes
		li_cols = istr_class[ai_class].attribute[li_attribute].GetDBCount()
		for li_col = 1 to li_cols
			if istr_class[ai_class].attribute[li_attribute].GetKey() then
				li_key = 1
			else
				li_key = 0
			end if
			this.ids_view.MapAttribute( &
				istr_class[ii_regclass].attribute[li_attribute].GetClass(), &
				istr_class[ai_class].attribute[li_attribute].GetName(), &
				istr_class[ai_class].attribute[li_attribute].GetDBTable(li_col), &
				istr_class[ai_class].attribute[li_attribute].GetDBColumn(li_col), li_key)
		next
	next
end if

return li_rc



end function

public function integer setthinclient (readonly boolean ab_thinclient);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetThinClient
//
//	Arguments:		ab_thinclient	Thin Client indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Sets the indicator as to whether we are operating in Thin Client mode.
//						If TRUE, BEOs will not be created for sets, inserts, or deletes.
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
ib_thinclient = ab_thinclient

return 1

end function

public function boolean getthinclient ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetThinClient
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Returns whether or not to operate in Thin Client mode.
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

return ib_thinclient

end function

public function long newbeo ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		NewBEO
//
//	Arguments:		none
//
//	Returns:			Long	Number of rows or -1 if an error occurs
//
//	Description:	Creates a new business object for the BCM.  This version
//						of the function is for Thin Client mode only.
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
n_cst_beo lnv_null1
n_cst_beo lnv_null2

if ib_thinclient = false and ib_local = false then
	return -1
else
	return this.newbeo(lnv_null1, lnv_null2, "")
end if

end function

public function integer deletebeo (long al_beoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DeleteBEO
//
//	Arguments:		al_beoindex	- BEO Index value of Business object to delete
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Deletes a BEO when in Thin Client mode.  This function should only
//						be called when in Thin Client mode.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 2.1   Initial version.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long 		ll_row
int 		li_rc
string 	ls_syntax

ib_validated = FALSE

//ensure datawindow is updateable before calling deleterow
//because if it's not the deleterow will return 1 but nothing
//is put in the delete buffer.
if this.GetRemote() then
	ls_syntax = this.ids_view.Object.DataWindow.Table.UpdateTable
	if ls_syntax = "?" then
		this.ids_view.Object.DataWindow.Table.UpdateTable='x'
		this.ids_view.Object.DataWindow.Table.UpdateWhere='0'
		this.ids_view.Object.DataWindow.Table.UpdateKeyinPlace='No'
	end if
end if

ll_row = this.GetBEORow ( al_beoindex )

if ll_row > 0 then		// delete it
	li_rc =  this.ids_view.DeleteRow ( ll_row )
	// 1.3 - Fix the current row iterator when we remove a row.
	if il_currow >= ll_row then
		il_currow = il_currow - 1
	end if
	//
else
	li_rc = -1
end if

return li_rc
end function

protected function long getbeoindex (readonly long al_row, dwbuffer adw_buffer);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		al_row	Row to get BEOIndex for
//						dwbuffer	Buffer to get the BEOIndex for
//
//	Returns:			Integer
//						>0		BEOIndex for row
//						-1		error
//
//	Description:	Returns BEOIndex value for specified row
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2  	Initial version
//	1.20.04	Add validity check for ids_view
// 2.0		Add call to pb function GetRowIDFromRow if indicator is on
// 2.1      Added Parameter to include buffer.  Fix btr #12115
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_beo_index = -1, ll_row


if not IsValid(ids_view) then
	return -1
end if

if isNull(adw_buffer) then
	adw_buffer = Primary!
end if

if al_row <= 0 then
	return -1
elseif adw_buffer = Primary! then
	if al_row > ids_view.RowCount() then
		return -1
	end if
elseif adw_buffer = Delete! then
	if al_row > ids_view.DeletedCount() then
		return -1
	end if
elseif adw_buffer = Filter! then
	if al_row > ids_view.FilteredCount() then
		return -1
	end if
end if

if this.GetBCMMGR().IsPBRowIDOn() then
	ll_row = al_row
	ll_beo_index = ids_view.dynamic GetRowIDFromRow( ll_row, adw_buffer )
else
	ll_beo_index = ids_view.GetItemNumber(al_row, this.GetBEOIndexColumn(), adw_buffer, false)
end if

return ll_beo_index
	
	
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

boolean lb_rtn = false

if is_dlk = "n_cst_dlk" or is_dlk = "" then
	lb_rtn = true
end if

return lb_rtn

end function

protected function integer validatethinclient ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Validate
//
//	Arguments:		none
//
//	Returns:			Integer
//						1	no errors
//				 		-1	BEO error found
//
//	Description:	Performs validation specific to classes being updated in thin client
//						mode.
//						FOR INTERNAL USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 2.1      Initial verion.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row, ll_deletedcount, ll_beoindexes[]
n_cst_beo lnv_beo

// Move rows from Deleted buffer into Primary and call Delete.
ll_deletedcount = ids_view.DeletedCount()
if ll_deletedcount = 0 then 
	return 1
end if

for ll_row = 1 to ll_deletedcount
	ll_beoindexes[ll_row] = this.GetBEOIndex(ll_row, Delete!)
next

if ids_view.RowsMove(1, ll_deletedcount, Delete!, ids_view, ids_view.RowCount() + 1, Primary!) = 1 then
	for ll_row = 1 to ll_deletedcount
		lnv_beo = this.GetAt(ll_beoindexes[ll_row])
		if isValid(lnv_beo) then
			if lnv_beo.DeleteBEO() = -1 then
				this.PropagateErrors(lnv_beo)
				return -1
			end if
		end if
	next
end if

return 1
end function

protected function boolean getreginitialized ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRegInitialized
//
//
//	Returns:			Boolean
//
//	Description:	Indicates whether or not the BCM metadata has been loaded
//						from the RegisterClass function.
//						FOR INTERNAL USE ONLY
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
//	Copyright (c) 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if ii_classes > 0 then
	if istr_class[1].b_registered = true then
		return true
	end if
end if

return false

end function

protected function integer registerallclasses (long al_beo_index, string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RegisterAllClasses
//
//	Arguments:		al_beo_index	BEO_Index value for BEO
//
//	Returns:			Integer
//						>0 	Number of class which was registered.
//						-1		error
//
//	Description:	Registers all classes by creating all BEOs.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
// 2.1  		Initial version - Build 50
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright (c) 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_class, li_classfound = 0
n_cst_beo lnv_beo

for li_class = 1 to ii_classes
	// Find the class that was passed in.
	if istr_class[li_class].s_class = as_classname then
		li_classfound = li_class
	end if
	
	// Register all updateable classes.
	// Also, always register the class that was passed in.
	if istr_class[li_class].b_Updateable = true or li_classfound = li_class then
		if istr_class[li_class].b_registered = false then
			// Create the BEO if the class hasn't been registered yet.
			lnv_beo = this.CreateBEO(al_beo_index, istr_class[li_class].s_class, li_class)
			if not isValid(lnv_beo) then
				return -1
			else
				ii_regclass = li_class
				lnv_beo.RegisterClass()
				istr_class[li_class].b_registered = true
				if this.MapColumns(li_class) <> 1 then
					This.PushException("createbeo")
					destroy lnv_beo
					return -1
				end if
				// BEO Index=0 means that we are just registering 
				// using a temporary BEO.  Destroy that BEO now that we're done.
				if al_beo_index = 0 then
					destroy lnv_beo					
				end if
			end if
		end if
	end if
	
	// This class was not found in the original list of classes.
	// It must be a non-updateable class that hasn't been added, so add it now.
	if li_class = ii_classes then
		if li_classfound = 0 and as_classname <> "" then
			ii_classes++
			istr_class[ii_classes].s_class = as_classname
		end if
	end if
next

return li_classfound

end function

protected function n_cst_beo createbeo (long al_beo_index, string as_classname, integer ai_class);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateBEO
//
//	Arguments:		al_beo_index	BEO_Index value for BEO
//						as_classname   Class to create.
//
//	Returns:			BEO
//
//	Description:	Creates a business object.  Called from CreateBEO and RegisterAllClasses.
//						FOR INTERNAL USE ONLY
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
//	Copyright (c) 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_beo lnv_beo
n_cst_beo_init lnv_beo_init
powerobject lpo_parm


if this.ib_thinclient = true and this.ib_local = false then
	this.SetException("initbeo", "29988", {as_classname, string(al_beo_index)})
	return lnv_beo
end if

lnv_beo_init = create n_cst_beo_init
lnv_beo_init.inv_bcm = this
lnv_beo_init.il_beo_index = al_beo_index

lpo_parm = Message.PowerObjectParm
Message.PowerObjectParm = lnv_beo_init
lnv_beo = CREATE USING as_classname
destroy lnv_beo_init
Message.PowerObjectParm = lpo_parm
if al_beo_index > 0 then
	istr_class[ai_class].nv_beolist[al_beo_index] = lnv_beo
end if

return lnv_beo

end function

protected function unsignedlong getmetadatablob (ref blob ablb_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetMetaDataBlob
//
//	Arguments:		ablb_bcm		Serialized info
//
//	Returns:			Long		Size of Blob
//
//	Description:	Stores BCM state into serialization info.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1	   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
blob lblb_errorcollection
unsignedlong ul_rc
int li_rc = 1, li_class, li_classes, li_attribute, li_attributes
long ll_beo, ll_beos, ll_req, ll_totreq, ll_reqbeoindex[]
string ls_reqclass[], ls_reqattribute[]


ul_rc = 1

ul_rc = BlobEdit(ablb_bcm, ul_rc, this.ClassName())
ul_rc = BlobEdit(ablb_bcm, ul_rc, String(this.ll_bcm_index))
ul_rc = BlobEdit(ablb_bcm, ul_rc, this.is_dlk)
ul_rc = BlobEdit(ablb_bcm, ul_rc, this.is_query)
if ib_thinclient then
	ul_rc = BlobEdit(ablb_bcm, ul_rc, "TRUE")
else
	ul_rc = BlobEdit(ablb_bcm, ul_rc, "FALSE")
end if	

li_classes = UpperBound(istr_class[])
ul_rc = BlobEdit(ablb_bcm, ul_rc, String(li_classes))
for li_class = 1 to li_classes
	ul_rc = BlobEdit(ablb_bcm, ul_rc, istr_class[li_class].s_class)
	if istr_class[li_class].b_updateable then
		ul_rc = BlobEdit(ablb_bcm, ul_rc, "TRUE")
	else
		ul_rc = BlobEdit(ablb_bcm, ul_rc, "FALSE")
	end if	
next
//if IsValid(this.inv_ownerbeo) then
//	lstr_ds.l_owner_bcm_index = this.inv_ownerbeo.GetBCM().GetBCMIndex()
//	lstr_ds.s_owner_relationshipname = this.is_ownerrelationshipname
//end if

li_classes = UpperBound(istr_class)
for li_class = 1 to li_classes
	li_attributes = istr_class[li_class].i_attributes
	ll_beos = UpperBound (istr_class[li_class].nv_beolist)
	for ll_beo = 1 to ll_beos
		if IsValid(istr_class[li_class].nv_beolist[ll_beo]) then
			for li_attribute = 1 to li_attributes
				if istr_class[li_class].nv_beolist[ll_beo].IsRequired(istr_class[li_class].attribute[li_attribute].GetName()) = 1 then
					ll_req ++
					ls_reqclass[ll_req] = istr_class[li_class].s_class
					ls_reqattribute[ll_req] = istr_class[li_class].attribute[li_attribute].GetName()
					ll_reqbeoindex[ll_req] = ll_beo
				end if
			next
		end if
	next
next

ll_totreq = ll_req
ul_rc = BlobEdit(ablb_bcm, ul_rc, String(ll_totreq))
for ll_req = 1 to ll_totreq
	ul_rc = BlobEdit(ablb_bcm, ul_rc, String(ll_reqbeoindex[ll_req]))
	ul_rc = BlobEdit(ablb_bcm, ul_rc, ls_reqclass[ll_req])
	ul_rc = BlobEdit(ablb_bcm, ul_rc, ls_reqattribute[ll_req])
next

//		Serialize error collection
This.GetOFRErrorCollection().Serialize(lblb_ErrorCollection)
//		save length of error collection
ul_rc = BlobEdit(ablb_bcm, ul_rc, String(Len(lblb_ErrorCollection)))

ul_rc = BlobEdit(ablb_bcm, ul_rc, lblb_ErrorCollection)

return ul_rc
end function

public function long getbeoindex (readonly long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		al_row	Row to get BEOIndex for
//
//	Returns:			Long
//						>0		BEOIndex for row
//						-1		error
//
//	Description:	Returns BEOIndex value for specified row
//						FOR INTERNAL OFR USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2  	Initial version
// 2.1		Fix BTR# 12115.  Call beoindex function and pass in primary buffer
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

public function datastore getview ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetView
//
//	Arguments:		None
//
//	Returns:			Datastore	View datastore used by BCM
//
//	Description:	Returns pointer to Datastore used by BCM
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.2	Create DLK/ids_view if not already created
// 2.1   BTR #11858 Don't destroy the dlk.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if not IsValid(ids_view) then
	if this.CreateDLK() <> 1 then
		this.PushException("getview")
		destroy ids_view
	else
		//this.DestroyDLK(inv_dlk)
	end if
end if

return ids_view
end function

protected function integer setmetadatablob (ref blob ablb_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetMetaDataBlob
//
//	Arguments:		ablb_bcm		Serialized info
//
//	Returns:			Integer		1 success
//										-1 error
//
//	Description:	Recreates BCM state from specified serialization info.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.1	   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
blob 			lblb_ErrorCollection, lblb_view
int 			li_rc = 1, li_class, li_classes, li_attr, li_attrs, li_colmap, li_colmaps
long 			ll_req, ll_totreq, ll_errlen, ll_reqbeoindex[], ll_rows
n_cst_beo 	lnv_beo
string 		ls_class, ls_attribute, ls_temp, ls_reqclass[], ls_reqattribute[], ls_updateable
unsignedlong ul_rc = 1
ofr_s_bcm_ds_datacol lstr_cols[]

//		BCM class
ls_temp = String(BlobMid(ablb_bcm, ul_rc, 41))
ul_rc = ul_rc + len(ls_temp) + 1

//		BCM index
ls_temp = String(BlobMid(ablb_bcm, ul_rc, 10))
ul_rc = ul_rc + len(ls_temp) + 1
this.ll_bcm_index = Long(ls_temp)

//		DLK class
is_dlk = String(BlobMid(ablb_bcm, ul_rc, 41))	
ul_rc = ul_rc + len(is_dlk) + 1

//		is_query - Don't limit BlobMid since this could be the whole DW Syntax.
is_query = String(BlobMid(ablb_bcm, ul_rc))
ul_rc = ul_rc + len(is_query) + 1

ls_temp = String(BlobMid(ablb_bcm, ul_rc, 6))
ul_rc = ul_rc + len(ls_temp) + 1
if ls_temp = "TRUE" then
	ib_thinclient = true
end if

//	BEO classes
ls_temp = String(BlobMid(ablb_bcm, ul_rc, 10))
ul_rc = ul_rc + len(ls_temp) + 1
li_classes = Integer(ls_temp)

for li_class = 1 to li_classes
	ls_temp = String(BlobMid(ablb_bcm, ul_rc, 41))
	ul_rc = ul_rc + len(ls_temp) + 1
	ls_updateable = String(BlobMid(ablb_bcm, ul_rc, 6))
	ul_rc = ul_rc + len(ls_updateable) + 1
	if ls_updateable = "FALSE" then
		this.AddClass(ls_temp, FALSE)
	else
		this.AddClass(ls_temp, TRUE)
	end if
next

//		Extract required attribute information
ls_temp = String(BlobMid(ablb_bcm, ul_rc, 10))
ul_rc = ul_rc + len(ls_temp) + 1
ll_totreq = Long(ls_temp)
for ll_req = 1 to ll_totreq
	ls_temp = String(BlobMid(ablb_bcm, ul_rc, 41))
	ul_rc = ul_rc + len(ls_temp) + 1
	ll_reqbeoindex[ll_req] = long(ls_temp)
	ls_temp = String(BlobMid(ablb_bcm, ul_rc, 41))
	ul_rc = ul_rc + len(ls_temp) + 1
	ls_reqclass[ll_req] = ls_temp
	ls_temp = String(BlobMid(ablb_bcm, ul_rc, 41))
	ul_rc = ul_rc + len(ls_temp) + 1
	ls_reqattribute[ll_req] = ls_temp
next

//		Grab error collection length
ls_temp = String(BlobMid(ablb_bcm, ul_rc, 10))
ul_rc = ul_rc + len(ls_temp) + 1
ll_errlen = Long(ls_temp)

//		Deserialize error collection
lblb_ErrorCollection = BlobMid(ablb_bcm, ul_rc, ll_errlen)
ul_rc = ul_rc + ll_errlen
This.GetOFRErrorCollection().Deserialize(lblb_ErrorCollection)

this.ids_view.GetCols(lstr_cols)

// Set up the attributes
li_attrs = Upperbound(lstr_cols)
for li_attr = 1 to li_attrs
	for li_class = 1 to li_classes
		if lstr_cols[li_attr].s_class = istr_class[li_class].s_class and UpperBound(istr_class[li_class].attribute) = 0 then
			li_colmaps = UpperBound(lstr_cols[li_attr].colmap)
			for li_colmap = 1 to li_colmaps
				this.SetDBColumn( li_class, lstr_cols[li_attr].colmap[li_colmap].s_table, lstr_cols[li_attr].colmap[li_colmap].s_column )
			next
		end if
	next
next

if (ib_thinclient = false or ib_local = true) and (li_classes > 0) then
	if ll_totreq = 0 then
		// Do registration by creating dummy BEOs.
		if this.RegisterAllClasses(0, "") = -1 then
			li_rc = -1
		end if
	else
		for ll_req = 1 to ll_totreq
			lnv_beo = this.GetAt(ll_reqbeoindex[ll_req], ls_reqclass[ll_req])
			if isValid(lnv_beo) then
				lnv_beo.SetRequired(ls_reqattribute[ll_req])
			end if
		next
	end if
end if

return li_rc

end function

public function string getcolumnname (readonly string as_class, readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetColumnNmae
//
//	Arguments:		as_class			Class name
//						as_attribute	Attribute to find column id for
//
//	Returns:			String - Name of result set column.
//
//	Description:	Returns column ID for specified attribute
//						FOR INTERNAL OFR USE ONLY.
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
int li_rc

li_rc = this.GetColumnID(as_class, as_attribute)

if li_rc > -1 then
	return this.GetView().Describe("#" + string(li_rc) + ".name")
else
	return ""
end if

end function

protected function long getbuffersize ();String	ls_inifile, &
			ls_Value
Long		ll_BufferSize

IF sl_BufferSize = 0 THEN

	ls_inifile = gnv_app.of_GetAppIniFile()
	ls_Value =  ProfileString ( ls_inifile, "CopyBuffer", "Size" , "" )

	IF IsNumber ( ls_Value ) THEN
		ll_BufferSize = Long ( ls_Value )
	END IF

	//If the value is reasonable, use it, otherwise use the default of 60000

	IF ll_BufferSize > 20000 THEN
		sl_BufferSize = ll_BufferSize
	ELSE
		sl_BufferSize = 60000
	END IF

END IF

RETURN sl_BufferSize
end function

on ofr_n_cst_bcm.create
call super::create
end on

on ofr_n_cst_bcm.destroy
call super::destroy
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			constructor
//
//	Description:	Create BCM DataStore
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   	Initial version
//	1.02.5	Add BCMCopy stuff
//	1.2		Update for 1.2
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_bcm_init lnv_bcm_init
n_cst_beo lnv_beo
int li_class, li_obj, li_objs, li_regcol, li_regcols
string ls_class

lnv_bcm_init = Message.PowerObjectParm
this.ll_bcm_index = lnv_bcm_init.ll_bcm_index
this.GetBCMMGR().RegisterBCM(this, this.ll_bcm_index)
for li_class = 1 to UpperBound(lnv_bcm_init.is_beo_classname)
	this.AddClass(lnv_bcm_init.is_beo_classname[li_class])
next
if IsValid(this.GetBCMMGR().inv_beolog) then
	this.GetBCMMGR().inv_beolog.LogCreate(this)
end if

this.SetOwnerBEO(lnv_bcm_init.inv_ownerbeo, this.is_ownerrelationshipname)

if IsValid(lnv_bcm_init.ids_view) then
	if lnv_bcm_init.ib_copy = true then
		this.ids_view = lnv_bcm_init.ids_view.Copy()
	else
		this.ids_view = lnv_bcm_init.ids_view
	end if
end if

if IsValid(lnv_bcm_init.itrx_view) then
	this.SetTransObject(lnv_bcm_init.itrx_view)
else
	this.SetTransObject(SQLCA)
end if

li_objs = UpperBound(lnv_bcm_init.inv_beolist)
for li_obj = 1 to li_objs
	if IsValid(lnv_bcm_init.inv_beolist[li_obj]) then
		ls_class = ClassName(lnv_bcm_init.inv_beolist[li_obj])
		lnv_beo = this.CreateBEO(lnv_bcm_init.inv_beolist[li_obj].GetBEOIndex(), ls_class)
		
		//svh;AddClass should perhaps do this now???
		//		Set required attribute indicators as they can vary per BEO instance
//		li_class = this.GetClass(ls_class)
//		li_regcols = istr_class[li_class].regcols
//		for li_regcol = 1 to li_regcols
//			lnv_beo.SetRequired(istr_class[li_class].regcolumn[li_regcol].attribute, &
//				lnv_bcm_init.inv_beolist[li_obj].IsRequired(istr_class[li_class].regcolumn[li_regcol].attribute) = 1)
//		next
	end if
next

end event

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			destructor
//
//	Description:	Clean up any created BEO's and notify the log
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1   Destroy the DLK
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

this.DestroyBEOs()

if isValid(inv_dlk) then
	this.DestroyDLK(inv_dlk)
end if

if IsValid(this.GetBCMMgr().inv_beolog) then
	this.GetBCMMgr().inv_beolog.LogDestroy(this)
end if

if IsValid(ids_view) then
	destroy ids_view
end if

this.clearofrerrors()



end event

