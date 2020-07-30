$PBExportHeader$ofr_n_cst_beokey.sru
$PBExportComments$Business Object base class
forward
global type ofr_n_cst_beokey from n_cst_base
end type
end forward

global type ofr_n_cst_beokey from n_cst_base
end type
global ofr_n_cst_beokey ofr_n_cst_beokey

type variables
protected:
string is_class
string is_keyname[]
string is_keytype[]
any iany_keyvalue[]
int ii_key

end variables

forward prototypes
public function string getclass ()
public function integer getkeycount ()
public function integer initialize (readonly n_cst_beo anv_beo)
public function integer getnext ()
public function integer getfirst ()
public function string gettype ()
public function any getvalue ()
public function string getname ()
public function boolean ismulticolumn ()
public function boolean serialize (ref blob ablb_beokey)
public function boolean isbeokey (readonly any aa_key)
public subroutine getvalues (ref any aa_values[])
public function n_cst_bcm retrieve (readonly blob ab_beokey)
public function boolean deserialize (readonly blob ab_key)
end prototypes

public function string getclass ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetClass
//
//	Arguments:		none
//
//	returns:			string		Class
//
//	Description:	Returns class for BEOKey
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
return is_class

end function

public function integer getkeycount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetKeyCount
//
//	Arguments:		none
//
//	returns:			integer		Key count
//
//	Description:	returns total key columns
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
return UpperBound(is_keyname)

end function

public function integer initialize (readonly n_cst_beo anv_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Initialize
//
//	Arguments:		anv_beo			BEO
//
//	returns:			int	1 		Success
//								-1		Error
//
//	Description:	Initializes BEOKey based on specified BEO.
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
int li_rc = 1, li_attribute, li_attributes, li_keycount
string ls_attribute
n_cst_bcm lnv_bcm
n_cst_attribute lnv_attribute

if NOT IsValid(anv_beo) then
	return -1
end if

is_class = ClassName(anv_beo)
lnv_bcm = anv_beo.GetBCM()
li_attributes = lnv_bcm.GetAttributeCount(is_class)
if li_attributes > 0 then
	for li_attribute = 1 to li_attributes
		lnv_bcm.GetAttribute(is_class, li_attribute, lnv_attribute)
		if lnv_attribute.GetKey() then
			li_keycount++
			ls_attribute = lnv_attribute.GetName()
			is_keyname[li_keycount] = ls_attribute
			is_keytype[li_keycount] = lnv_attribute.GetType()
			iany_keyvalue[li_keycount] = anv_beo.Get(ls_attribute)
		end if
	next
end if

return li_rc

end function

public function integer getnext ();/////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetNext
//
//	Arguments:		none
//
//	returns:			integer		1	Success
//										-1	Error
//
//	Description:	Positions cursor at next key column
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
int li_rc = -1

if ii_key < UpperBound(is_keyname) then
	ii_key++
	li_rc = 1
end if

return li_rc

end function

public function integer getfirst ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetFirst
//
//	Arguments:		none
//
//	returns:			integer		1	Success
//										-1	Error
//
//	Description:	Positions cursor at first key column.
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
int li_rc = -1

if UpperBound(is_keyname) > 0 then
	ii_key = 1
	li_rc = 1
end if

return li_rc

end function

public function string gettype ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetType
//
//	Arguments:		none
//
//	returns:			string		HOW Type
//
//	Description:	Returns type for current key column.
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
if ii_key > 0 then
	return is_keytype[ii_key]
else
	return ''
end if


end function

public function any getvalue ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetValue
//
//	Arguments:		none
//
//	returns:			any		Key value
//
//	Description:	Returns valuie for current key column.
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
if ii_key > 0 then
	return iany_keyvalue[ii_key]
else
	return -1
end if

end function

public function string getname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetName
//
//	Arguments:		none
//
//	returns:			string		Attribute name
//
//	Description:	Returns attribute name for current key column.
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
if ii_key > 0 then
	return is_keyname[ii_key]
else
	return ''
end if

end function

public function boolean ismulticolumn ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsMultiColumn
//
//	Arguments:		none
//
//	returns:			Boolean		Multi-column indicator
//
//	Description:	Returns boolean as to whether there is > 1 key columns.
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
return UpperBound(is_keyname) > 1

end function

public function boolean serialize (ref blob ablb_beokey);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Serialize
//
//	Arguments:		ablb_beokey Reference blob to populate
//
//	returns:			int	1 		Success
//								-1		Error
//
//	Description:	Populates a blob with beokey data
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

unsignedlong ul_rc = 1
integer li_attr, li_attrs

//		Initialize buffer
ablb_beokey = blob(space(60000))
ul_rc = BlobEdit(ablb_beokey, ul_rc, is_class)

li_attrs = UpperBound(is_keyname)
ul_rc = BlobEdit(ablb_beokey, ul_rc, string(li_attrs))

//		Copy metadata
for li_attr = 1 to li_attrs
	ul_rc = BlobEdit(ablb_beokey, ul_rc, is_keyname[li_attr])
	ul_rc = BlobEdit(ablb_beokey, ul_rc, is_keytype[li_attr])
	ul_rc = BlobEdit(ablb_beokey, ul_rc, string(iany_keyvalue[li_attr]))
next

return true

end function

public function boolean isbeokey (readonly any aa_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsBeoKey
//
//	Arguments:		aa_key  
//
//	Returns:			Boolean True - Is a BEO key
//								  False - Not a BEO Key (dlk, dataobject, BEO...)
//
//	Description:	Determine if the aa_key is a beokey
//						INTERNAL USE ONLY
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
blob lblb_data
string ls_class

if lower(ClassName( aa_key )) = "string" then
	lblb_data = Blob(aa_key)

	//		Get Class Name
	ls_class = String(BlobMid(lblb_data, 1))

	if ls_class = "n_cst_beokey" then
		return true
	else
		return false
	end if
else
	return false
end if

end function

public subroutine getvalues (ref any aa_values[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetValues
//
//	Arguments:		any		Key values by reference
//
//	returns:			None
//
//	Description:	Returns values for key column.
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
///////////////////////////////////////////////////////////////////////////
aa_values = iany_keyvalue

end subroutine

public function n_cst_bcm retrieve (readonly blob ab_beokey);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		ab_beokey				Blob	 - The BEO Key Values
//
//	Returns:			lnv_bcm					A bcm
//
//	Description:	Pass BEO keys and retrieve via the query->sso, which returns a bcm represented 
//						by s_bcmreference.  Create a bcm based on s_bcmreference and return it.
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

n_cst_database		lnv_database
n_cst_query			lnv_query
n_cst_bcm			lnv_bcm

lnv_database = this.GetBCMMGR().GetDefaultDatabase()

lnv_query = lnv_database.GetQuery()
if not isValid(lnv_query) then
	lnv_database.CreateQuery()
	lnv_query = lnv_database.GetQuery() 
end if

if isValid(lnv_query) then
	return lnv_query.ExecuteBEOKeyQuery( ab_beokey )
else
	return lnv_bcm
end if
end function

public function boolean deserialize (readonly blob ab_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deserialize
//
//	Arguments:		ab_key  Blob to deserialize
//
//	Returns:			boolean 	true Success
//									false Failure
//
//	Description:	Deserialize a BEOKey and set up the retrieval arguments
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
string ls_temp
unsignedlong  ul_rc = 1
integer li_attr, li_attrs

//		Get Class Name
ls_temp = String(BlobMid(ab_key, ul_rc))
ul_rc = ul_rc + len(ls_temp) + 1
is_class = ls_temp

//		Get # attributes
ls_temp = String(BlobMid(ab_key, ul_rc))
ul_rc = ul_rc + len(ls_temp) + 1
li_attrs = Integer(ls_temp)

//		Copy metadata
for li_attr = 1 to li_attrs
	//		Get Attribute name
	ls_temp = String(BlobMid(ab_key, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	is_keyname[li_attr] = ls_temp
	//		Get Attribute Type
	ls_temp = String(BlobMid(ab_key, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	is_keytype[li_attr] = ls_temp
	//		Get Attribute Value
	ls_temp = String(BlobMid(ab_key, ul_rc))
	ul_rc = ul_rc + len(ls_temp) + 1
	iany_keyvalue[li_attr] = ls_temp
next

//initialize the rest of the values (which will be used as 
//arguments) to null
for li_attr = li_attr to 16
	SetNull(iany_keyvalue[li_attr])
next

return true
end function

on ofr_n_cst_beokey.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_beokey.destroy
TriggerEvent( this, "destructor" )
end on

