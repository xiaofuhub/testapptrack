$PBExportHeader$ofr_n_cst_attribute.sru
$PBExportComments$Business Object base class
forward
global type ofr_n_cst_attribute from n_cst_base
end type
end forward

global type ofr_n_cst_attribute from n_cst_base
end type
global ofr_n_cst_attribute ofr_n_cst_attribute

type variables
protected:
string	is_classname
string	is_name
string	is_type
string	is_relatedclass
string	is_relatedname
string	is_relationshipname
string	is_table[]
string	is_column[]
integer     ii_classindex
boolean	ib_key
ofr_s_bcm_class istr_class

end variables

forward prototypes
public function string getclass ()
public function string getname ()
public function string gettype ()
public function string getrelatedclass ()
public function string getrelatedname ()
public function integer setrelationshipinfo (readonly string as_relatedclass, readonly string as_relatedname, readonly string as_relatinshipname)
public function string getrelationshipname ()
public function integer setdbcolumn (readonly string as_table, readonly string as_column)
public function integer getdbcount ()
public function string getdbtable (readonly integer ai_idx)
public function string getdbcolumn (readonly integer ai_idx)
public function integer setkey (readonly boolean ab_key)
public function boolean getkey ()
public function integer getclassindex ()
public function integer initialize (readonly ofr_s_bcm_class astr_class, readonly string as_name, readonly string as_type)
end prototypes

public function string getclass ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetClass
//
//	Arguments:		None
//
//	Returns:			Class name
//
//	Description:	Returns class name that this attribute is part of.
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
//return is_class

return istr_class.s_class

end function

public function string getname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetName
//
//	Arguments:		None
//
//	Returns:			Attribute name
//
//	Description:	Returns name of this attribute
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
return is_name

end function

public function string gettype ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetType
//
//	Arguments:		None
//
//	Returns:			Attribute type
//
//	Description:	Returns type of this attribute
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
return is_type

end function

public function string getrelatedclass ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRelatedClass
//
//	Arguments:		None
//
//	Returns:			Related class name
//
//	Description:	Returns class that this relationship attribute refers to.
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
return is_relatedclass

end function

public function string getrelatedname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRelatedName
//
//	Arguments:		None
//
//	Returns:			Related attribute name
//
//	Description:	Returns attribute name in related class that this
//						relationship attribute refers to.
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
return is_relatedname

end function

public function integer setrelationshipinfo (readonly string as_relatedclass, readonly string as_relatedname, readonly string as_relatinshipname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRelationshipInfo
//
//	Arguments:		as_relatedclass		Related class name
//						as_relatedname			Related attribute name
//						as_relationshipname	Relationship name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Initializes relationship attribute informattion.
//						FOR INTERNAL USE ONLY
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
is_relatedclass = as_relatedclass
is_relatedname = as_relatedname
is_relationshipname = as_relatinshipname

return 1
end function

public function string getrelationshipname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetRelationshipName
//
//	Arguments:		None
//
//	Returns:			Relationship name
//
//	Description:	Returns name of the relationship that this relationship
//						attribute refers to.
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
return is_relationshipname

end function

public function integer setdbcolumn (readonly string as_table, readonly string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDBColumn
//
//	Arguments:		as_table			Table name
//						as_column		Column name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Maps this attribute to a table/column.
//						FOR INTERNAL USE ONLY
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
int li_dbcount

li_dbcount = this.GetDBCount() + 1

is_table[li_dbcount] = as_table
is_column[li_dbcount] = as_column

return 1

end function

public function integer getdbcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDBCount
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Returns count of table/column mappings.
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
Return UpperBound(is_table)

end function

public function string getdbtable (readonly integer ai_idx);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDBTable
//
//	Arguments:		ai_idx		Iterator index
//
//	Returns:			String		Table name
//
//	Description:	Returns table name from table/column mappings.
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
if ai_idx <= this.GetDBCount() then
	return is_table[ai_idx]
else
	return ''
end if

end function

public function string getdbcolumn (readonly integer ai_idx);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDBColumn
//
//	Arguments:		ai_idx		Iterator index
//
//	Returns:			String		Column name
//
//	Description:	Returns column name from table/column mappings.
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
if ai_idx <= this.GetDBCount() then
	return is_column[ai_idx]
else
	return ''
end if

end function

public function integer setkey (readonly boolean ab_key);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetKey
//
//	Arguments:		ab_key		Key indicator
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Identifies whether this is a key attribute.
//						FOR INTERNAL USE ONLY
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
ib_key = ab_key

return 1

end function

public function boolean getkey ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetKey
//
//	Arguments:		none
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Returns indicator as to whether this attribute is part of
//						the key for the class.
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
return ib_key

end function

public function integer getclassindex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetClassIndex
//
//	Arguments:		None
//
//	Returns:			Class Index
//
//	Description:	Returns class index that this attribute is part of.
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
return ii_classindex

end function

public function integer initialize (readonly ofr_s_bcm_class astr_class, readonly string as_name, readonly string as_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Initialize
//
//	Arguments:		as_class			Attribute class
//						as_name			Attribute name
//						as_type			Attribute type
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Initializes attribute object.
//						FOR INTERNAL USE ONLY
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
//is_class = as_class
is_name = as_name
is_type = as_type
//svh
//ii_classindex = ai_index
istr_class = astr_class
return 1

end function

on ofr_n_cst_attribute.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_attribute.destroy
TriggerEvent( this, "destructor" )
end on

