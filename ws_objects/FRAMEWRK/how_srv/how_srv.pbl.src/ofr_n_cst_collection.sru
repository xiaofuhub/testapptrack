$PBExportHeader$ofr_n_cst_collection.sru
$PBExportComments$Business Object Manager base class
forward
global type ofr_n_cst_collection from n_cst_base
end type
end forward

global type ofr_n_cst_collection from n_cst_base
end type
global ofr_n_cst_collection ofr_n_cst_collection

type variables
Protected:

end variables

forward prototypes
public function long getcount ()
public function integer add (ref any lany_obj)
public function integer add (ref any lany_obj, readonly any lany_related_obj)
public function any getat (readonly long al_index)
public function any getfirst ()
public function any getlast ()
public function any getnext ()
public function any getprev ()
public function integer remove (readonly any lany_obj)
end prototypes

public function long getcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetCount
//
//	Arguments:		al_index			Index of collection object to return
//
//	Returns:			n_cst_base		
//
//	Description:	Returns the specified object from the collection.
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
return -1

end function

public function integer add (ref any lany_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Add
//
//	Arguments:		lany_obj		Returned objet from add
//
//	Returns:			integer		1  Success
//										-1 Error
//
//	Description:	Adds object to collection. Note that this function only
//						works for collections that have been derived from
//						owning relationships (ex: line items for an order).
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
return -1

end function

public function integer add (ref any lany_obj, readonly any lany_related_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Add
//
//	Arguments:		lany_obj				Returned objet from add
//						lany_related_obj	Related object to add
//
//	Returns:			integer		1  Success
//										-1 Error
//
//	Description:	Adds object to collection. Note that this function only
//						works for collections that have been derived from
//						non-owning relationships (ex: emps for a dept).
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
return -1

end function

public function any getat (readonly long al_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAt
//
//	Arguments:		al_index			Index of collection object to return
//
//	Returns:			any
//
//	Description:	Returns the specified object from the collection.
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
any lany_obj

return lany_obj

end function

public function any getfirst ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetFirst
//
//	Arguments:		none
//
//	Returns:			any	
//
//	Description:	Returns the first object from the collection.
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
any lany_obj

return lany_obj

end function

public function any getlast ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetLast
//
//	Arguments:		none
//
//	Returns:			n_cst_object	
//
//	Description:	Returns the last object from the collection.
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
any lany_obj

return lany_obj

end function

public function any getnext ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetNext
//
//	Arguments:		none
//
//	Returns:			any
//
//	Description:	Returns the next object from the collection.
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
any lany_obj

return lany_obj

end function

public function any getprev ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetPrev
//
//	Arguments:		none
//
//	Returns:			n_cst_object
//
//	Description:	Returns the previous object from the collection.
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
any lany_obj

return lany_obj

end function

public function integer remove (readonly any lany_obj);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Remove
//
//	Arguments:		lany_obj		Object to remove to collection
//
//	Returns:			integer		1  Success
//										-1 Error
//
//	Description:	Remove (un-relates) object from collection
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
return -1

end function

on ofr_n_cst_collection.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_collection.destroy
TriggerEvent( this, "destructor" )
end on

