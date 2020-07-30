$PBExportHeader$ofr_n_cst_ofrerror.sru
forward
global type ofr_n_cst_ofrerror from n_cst_base
end type
end forward

global type ofr_n_cst_ofrerror from n_cst_base
end type
global ofr_n_cst_ofrerror ofr_n_cst_ofrerror

type variables
protected:
n_cst_bcm inv_bcm
int ii_errortype = 1
string is_class, is_attribute
long il_beoindex
long il_errornumber
string is_errormessage
boolean ib_warning
long il_sqldbcode
string is_sqlerrtext, is_sqlsyntax
end variables

forward prototypes
public function integer deserialize (ofr_s_error astr_error)
public function string GetAttribute ()
public function n_cst_bcm GetBCM ()
public function long GetBEOIndex ()
public function string GetClass ()
public function string GetErrorMessage ()
public function long GetErrorNumber ()
public function integer GetErrorType ()
public function long GetSQLDBCode ()
public function string GetSQLErrText ()
public function string GetSQLSyntax ()
public function boolean GetWarning ()
public function ofr_s_error serialize ()
public function integer SetAttribute (readonly string as_attribute)
public function integer SetBCM (readonly nonvisualobject anv_bcm)
public function integer SetBEOIndex (readonly long al_beoindex)
public function integer SetClass (readonly string as_class)
public function integer SetErrorMessage (readonly string as_errormessage)
public function integer SetErrorNumber (readonly long al_errornumber)
public function integer seterrortype (readonly integer ai_errortype)
public function integer SetSQLDBCode (readonly long al_sqldbcode)
public function integer SetSQLErrText (readonly string sqlerrtext)
public function integer SetSQLSyntax (readonly string as_sqlsyntax)
public function integer SetWarning (readonly boolean ab_warning)
public function integer deserialize (readonly blob ablb_error)
public function unsignedlong serialize (ref blob ablb_error)
public function long getbcmindex ()
end prototypes

public function integer deserialize (ofr_s_error astr_error);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deserialize
//
//	Arguments:		astr_error - Serialized error structure.
//
//	Returns:			Integer  -1=error, 1=success
//
//	Description:	Populates this error object from one returned from the server.
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


ii_errortype = astr_error.i_errortype
il_errornumber = astr_error.l_errornumber
ib_warning = astr_error.b_warning
is_attribute = astr_error.s_attribute
is_class = astr_error.s_class
il_beoindex = astr_error.l_beoindex
is_errormessage = astr_error.s_errormessage
is_sqlerrtext =astr_error.s_sqlerrtext
is_sqlsyntax = astr_error.s_sqlsyntax
il_sqldbcode = astr_error.l_sqldbcode
inv_bcm = this.GetBCMMgr().GetBCMByIndex(astr_error.l_bcmindex)

return 1

end function

public function string GetAttribute ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetAttribute
//
//	Arguments:		none
//
//	Returns:			String	Attribute in error
//
//	Description:	Returns the attribute that is associated with the error.
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
return is_attribute

end function

public function n_cst_bcm GetBCM ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCM
//
//	Arguments:		none
//
//	Returns:			n_cst_bcm	Owner BCM
//
//	Description:	Returns the BCM that is associated with the error.
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
return inv_bcm

end function

public function long GetBEOIndex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		none
//
//	Returns:			Long	BEOIndex of the BEO
//
//	Description:	Returns BEOIndex of the business object that is
//						associated with the error.
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
return il_beoindex

end function

public function string GetClass ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetClass
//
//	Arguments:		none
//
//	Returns:			String	Class of business object
//
//	Description:	Returns the class of the business object that is 
//						associated with the error.
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
return is_class

end function

public function string GetErrorMessage ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetErrorMessage
//
//	Arguments:		none
//
//	Returns:			String	Error message
//
//	Description:	Returns the error message that is associated with the error.
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
return is_errormessage

end function

public function long GetErrorNumber ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetErrorNumber
//
//	Arguments:		none
//
//	Returns:			Long	Error number
//
//	Description:	Returns the error number that is associated with the error.
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
return il_errornumber

end function

public function integer GetErrorType ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetErrorType
//
//	Arguments:		none
//
//	Returns:			Error Type		>0 - User defined validation error
//											-1 - DBError database error
//											-2 - Required field missing
//											-3 - Unique constraint error
//
//	Description:	Gets the type of error.
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
return ii_errortype

end function

public function long GetSQLDBCode ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSQLDBCode
//
//	Arguments:		none
//
//	Returns:			Long	SQLDBCode
//
//	Description:	Returns the SQLDBCode that is associated with the error.
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
return il_sqldbcode

end function

public function string GetSQLErrText ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSQLErrText
//
//	Arguments:		none
//
//	Returns:			String	SQLErrText
//
//	Description:	Returns the SQLErrText that is associated with the error.
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
return is_sqlerrtext

end function

public function string GetSQLSyntax ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSQLSyntax
//
//	Arguments:		none
//
//	Returns:			String	SQLSyntax
//
//	Description:	Returns the SQLSyntax that is associated with the error.
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
return is_sqlsyntax

end function

public function boolean GetWarning ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetWarning
//
//	Arguments:		none
//
//	Returns:			Boolean	Warning indicator
//
//	Description:	Returns indicator as to whether this error is a warning.
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
return ib_warning

end function

public function ofr_s_error serialize ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Serialize
//
//	Arguments:		none
//
//	Returns:			ofr_s_error, serialized error structure.
//
//	Description:	Turns this object into a stream which can be returned from the 
//						server to the client.
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

ofr_s_error lstr_error

lstr_error.i_errortype = ii_errortype
lstr_error.l_errornumber = il_errornumber
lstr_error.b_warning = ib_warning
lstr_error.s_attribute = is_attribute
lstr_error.s_class = is_class
lstr_error.l_beoindex = il_beoindex
lstr_error.s_errormessage = is_errormessage
lstr_error.s_sqlerrtext = is_sqlerrtext
lstr_error.s_sqlsyntax = is_sqlsyntax
lstr_error.l_sqldbcode = il_sqldbcode
if isvalid(inv_bcm) then
	lstr_error.l_bcmindex = inv_bcm.GetBCMIndex()
end if
				
return lstr_error

end function

public function integer SetAttribute (readonly string as_attribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetAttribute
//
//	Arguments:		as_attribute	Attribute name
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the attribute that is associated with the error.
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
is_attribute = as_attribute

return 1

end function

public function integer SetBCM (readonly nonvisualobject anv_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCM
//
//	Arguments:		n_cst_bcm	BCM that generated this error
//
//	Returns:			1	Success
//						-1	Error
//
//	Description:	Sets the owner BCM.
//						FOR INTERNAL USE ONLY!
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
inv_bcm = anv_bcm

return 1

end function

public function integer SetBEOIndex (readonly long al_beoindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBEOIndex
//
//	Arguments:		al_beoindex	BEOIndex number
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the BEOIndex of the business object that is 
//						associated with the error.
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
il_beoindex = al_beoindex

return 1

end function

public function integer SetClass (readonly string as_class);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetClass
//
//	Arguments:		as_class	Business object class name
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the class name of the business object that is 
//						associated with the error.
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
is_class = as_class

return 1

end function

public function integer SetErrorMessage (readonly string as_errormessage);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetErrorMessage
//
//	Arguments:		as_errormessage	Error message
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the error message that is associated with the error.
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
is_errormessage = as_errormessage

return 1

end function

public function integer SetErrorNumber (readonly long al_errornumber);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetErrorNumber
//
//	Arguments:		al_errornumber	Error number
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the error number that is associated with the error.
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
il_errornumber = al_errornumber

return 1

end function

public function integer seterrortype (readonly integer ai_errortype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetErrorType
//
//	Arguments:		ai_errortype	Type of error
//											>0 - User defined validation error
//											-1 - DBError database error
//											-2 - Required field missing
//											-3 - Unique constraint error
//											-4	- OpenFrame internal error
//
//	Returns:			Integer
//						1	success
//				 		-1	error
//
//	Description:	Sets the type of error.
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
ii_errortype = ai_errortype

return 1

end function

public function integer SetSQLDBCode (readonly long al_sqldbcode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSQLDBCode
//
//	Arguments:		al_sqldbcode	SQLDBCode
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the SQLDBCode that is associated with the error.
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
il_sqldbcode = al_sqldbcode

return 1

end function

public function integer SetSQLErrText (readonly string sqlerrtext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSQLErrText
//
//	Arguments:		sqlerrtext	SQLErrText
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the SQLErrText that is associated with the error.
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
is_sqlerrtext = sqlerrtext

return 1

end function

public function integer SetSQLSyntax (readonly string as_sqlsyntax);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSQLSyntax
//
//	Arguments:		as_sqlsyntax	SQL statement syntax
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the SQL statement syntax that generated the
//						database error that is associated with this error.
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
is_sqlsyntax = as_sqlsyntax

return 1

end function

public function integer SetWarning (readonly boolean ab_warning);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetWarning
//
//	Arguments:		ab_warning	Warning indicator
//
//	Returns:			Integer	1 	success
//									-1	error
//
//	Description:	Sets the indicator as to whether this error is a warning.
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
ib_warning = ab_warning

return 1

end function

public function integer deserialize (readonly blob ablb_error);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deserialize
//
//	Arguments:		ablb_error - Serialized error blob
//
//	Returns:			Integer  -1=error, 1=success
//
//	Description:	Populates this error object from the serialized blob.
//						FOR INTERNAL USE ONLY
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
int li_rc = 1
string ls_temp
unsignedlong lul_rc = 1

ls_temp = String(BlobMid(ablb_error, lul_rc, 10))
lul_rc = lul_rc + Len(ls_temp) + 1
ii_errortype = Integer(ls_temp)

ls_temp = String(BlobMid(ablb_error, lul_rc, 15))
lul_rc = lul_rc + Len(ls_temp) + 1
il_errornumber = Long(ls_temp)

ls_temp = String(BlobMid(ablb_error, lul_rc, 2))
lul_rc = lul_rc + Len(ls_temp) + 1
if ls_temp = "1" then
	ib_warning = true
else
	ib_warning = false
end if

ls_temp = String(BlobMid(ablb_error, lul_rc, 10))
lul_rc = lul_rc + Len(ls_temp) + 1
inv_bcm = this.GetBCMMgr().GetBCMByIndex(Long(ls_temp))

is_attribute = String(BlobMid(ablb_error, lul_rc, 41))
lul_rc = lul_rc + Len(is_attribute) + 1

is_class = String(BlobMid(ablb_error, lul_rc, 41))
lul_rc = lul_rc + Len(is_class) + 1

ls_temp = String(BlobMid(ablb_error, lul_rc, 10))
lul_rc = lul_rc + Len(ls_temp) + 1
il_beoindex = Long(ls_temp)

is_errormessage = String(BlobMid(ablb_error, lul_rc))
lul_rc = lul_rc + Len(is_errormessage) + 1

ls_temp = String(BlobMid(ablb_error, lul_rc, 15))
lul_rc = lul_rc + Len(ls_temp) + 1
il_sqldbcode = Long(ls_temp)

is_sqlerrtext = String(BlobMid(ablb_error, lul_rc))
lul_rc = lul_rc + Len(is_sqlerrtext) + 1

is_sqlsyntax = String(BlobMid(ablb_error, lul_rc))
lul_rc = lul_rc + Len(is_sqlsyntax) + 1

return li_rc

end function

public function unsignedlong serialize (ref blob ablb_error);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Serialize
//
//	Arguments:		ablb_error	Return error
//
//	Returns:			Long	Length of serialized error
//
//	Description:	Turns this object into a stream which can be returned from
//						the server to the client.
//						FOR INTERNAL USE ONLY
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
unsignedlong lul_rc = 1

ablb_error = Blob(Space(60000))

lul_rc = BlobEdit(ablb_error, lul_rc, String(ii_errortype))
lul_rc = BlobEdit(ablb_error, lul_rc, String(il_errornumber))
if ib_warning then
	lul_rc = BlobEdit(ablb_error, lul_rc, "1")
else
	lul_rc = BlobEdit(ablb_error, lul_rc, "0")
end if

if isValid(inv_bcm) then
	lul_rc = BlobEdit(ablb_error, lul_rc, String(inv_bcm.GetBCMIndex()))
else
	lul_rc = BlobEdit(ablb_error, lul_rc, "0")
end if

lul_rc = BlobEdit(ablb_error, lul_rc, is_attribute)
lul_rc = BlobEdit(ablb_error, lul_rc, is_class)
lul_rc = BlobEdit(ablb_error, lul_rc, String(il_beoindex))
lul_rc = BlobEdit(ablb_error, lul_rc, is_errormessage)
lul_rc = BlobEdit(ablb_error, lul_rc, String(il_sqldbcode))
lul_rc = BlobEdit(ablb_error, lul_rc, is_sqlerrtext)
lul_rc = BlobEdit(ablb_error, lul_rc, is_sqlsyntax)
lul_rc = lul_rc - 1
ablb_error = BlobMid(ablb_error, 1, lul_rc)

return lul_rc

end function

public function long getbcmindex ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOIndex
//
//	Arguments:		none
//
//	Returns:			Long	BEOIndex of the BEO
//
//	Description:	Returns BEOIndex of the business object that is
//						associated with the error.
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
return il_beoindex

end function

on ofr_n_cst_ofrerror.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_ofrerror.destroy
TriggerEvent( this, "destructor" )
end on

