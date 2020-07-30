$PBExportHeader$ofr_n_cst_base.sru
$PBExportComments$Base class for all OFR objects
forward
global type ofr_n_cst_base from nonvisualobject
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070731
//n_cst_bcmmgr snv_bcmmgr
////end modification Shared Variables by appeon  20070731
//
end variables

global type ofr_n_cst_base from nonvisualobject
end type
global ofr_n_cst_base ofr_n_cst_base

type variables
protected:
n_cst_ofrerror_collection inv_ofrerrorcollection

// Exception handler
n_cst_exception inv_exception




end variables

forward prototypes
public function n_cst_ofrerror addofrerror ()
public function integer clearofrerrors ()
public function integer geterrorcount ()
public function n_cst_ofrerror_collection getofrerrorcollection ()
public function integer getofrerrors (ref n_cst_ofrerror anv_ofrerror[])
public function any convert (readonly any aa_value, readonly parmtype apt_parmtype)
public function boolean of_boolean (readonly any aa_value)
public function date of_date (readonly any aa_value)
public function datetime of_datetime (readonly any aa_value)
public function time of_time (readonly any aa_value)
public function integer propagateerrors (readonly n_cst_base anv_ofrobject)
public function n_cst_bcmmgr getbcmmgr ()
protected function integer setbcmmgr (readonly n_cst_bcmmgr anv_bcmmgr)
protected function integer setexception (readonly string as_script, readonly string as_messageid)
protected function integer setexception (readonly string as_script, readonly string as_messageid, readonly string as_substitutions[])
protected function integer pushexception (readonly string as_script)
public function ofr_s_error_collection getserializederrors ()
public function boolean deserializeargs (ref any aa_args[], blob ablb_args)
public function blob serializeargs (any aa_args[])
public function long getserializedbloberrors (ref blob abl_errors)
public function any convert (readonly any aa_value, readonly string as_parmtype)
end prototypes

public function n_cst_ofrerror addofrerror ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddOFRError
//
//	Arguments:		none
//
//	Returns:			n_cst_ofrerror	Newly created OFR error object
//
//	Description:	Creates OFR error object for this BCM
//						FOR INTERNAL USE ONLY
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
n_cst_ofrerror lnv_error

lnv_error = this.GetOFRErrorCollection().dynamic AddError()

return lnv_error
end function

public function integer clearofrerrors ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearOFRErrors
//
//	Arguments:		none
//
//	Returns:			1	success
//						-1	error
//
//	Description:	Clears OFR errors for the BCM
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2	Initial version
// 1.20.03  Don't call GetOFRErrorCollection because it will CREATE the collection
//			when we don't really need it.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

if isValid(inv_ofrerrorcollection) then
	return GetOFRErrorCollection().dynamic ClearErrors()
else
	return 1
end if

end function

public function integer geterrorcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetErrorCount
//
//	Arguments:		none
//
//	Returns:			Number of errors for this object
//
//	Description:	Called to determine if this object (BEO, BCM, DLK) has any errors.
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

return GetOFRErrorCollection().dynamic GetErrorCount()
end function

public function n_cst_ofrerror_collection getofrerrorcollection ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetOFRErrorCollection
//
//	Arguments:		none
//
//	Returns:			Error Collection object
//
//	Description:	Returns error collection object containing all errors.
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

if not isValid(inv_ofrerrorcollection) then
	inv_ofrerrorcollection = create n_cst_ofrerror_collection
end if

return inv_ofrerrorcollection
end function

public function integer getofrerrors (ref n_cst_ofrerror anv_ofrerror[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetOFRErrors
//
//	Arguments:		anv_ofrerror[]		Returned array of OFR error objects
//
//	Returns:			1	success
//						-1	error
//
//	Description:	Returns array of OFR error objects associated with the BCM.
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

return This.GetOFRErrorCollection().dynamic GetErrorArray(anv_ofrerror[])

end function

public function any convert (readonly any aa_value, readonly parmtype apt_parmtype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Convert
//
//	Arguments:		aa_value			Any value to convert
//						apt_parmtype	Type to convert to
//
//	returns:			Any
//
//	Description:	Converts the any variable to a specified type.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
//	1.3 	Made Date conversion also work for DateTime.
// 2.1   Fix BTR #9252.  Convert datetime formatted string to datetime.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
any la_value
boolean lb_value
date ld_value
datetime ldt_value
decimal ldec_value
double ldbl_value
integer li_value
long ll_value
real lr_value
string ls_value
time lt_value
uint lui_value
ulong lul_value

choose case apt_parmtype
	case typeboolean!
		if IsNull(aa_value) then
			SetNull(lb_value)
		else
			lb_value = aa_value
		end if
		la_value = lb_value
	case typedate!
		if IsNull(aa_value) then
			SetNull(ld_value)
		else
			if Lower(ClassName(aa_value)) = "datetime" then
				ld_value = Date(aa_value)			
			else
				ld_value = aa_value
			end if
		end if
		la_value = ld_value
	case typedatetime!
		if IsNull(aa_value) then
			SetNull(ldt_value)
		else
			if ClassName(aa_value) = "string" then
				ldt_value = datetime(date(mid(aa_value,1,pos(aa_value," "))), time(mid(aa_value,pos(aa_value," "))))
			else
				ldt_value = aa_value
			end if
		end if
		la_value = ldt_value
	case typedecimal!
		if IsNull(aa_value) then
			SetNull(ldec_value)
		else
			ldec_value = aa_value
		end if
		la_value = ldec_value
	case typedouble!
		if IsNull(aa_value) then
			SetNull(ldbl_value)
		else
			ldbl_value = aa_value
		end if
		la_value = ldbl_value
	case typeinteger!
		if IsNull(aa_value) then
			SetNull(li_value)
		else
			li_value = aa_value
		end if
		la_value = li_value
	case typelong!
		if IsNull(aa_value) then
			SetNull(ll_value)
		else
			ll_value = aa_value
		end if
		la_value = ll_value
	case typereal!
		if IsNull(aa_value) then
			SetNull(lr_value)
		else
			lr_value = aa_value
		end if
		la_value = lr_value
	case typestring!
		if IsNull(aa_value) then
			SetNull(ls_value)
		else
			ls_value = aa_value
		end if
		la_value = ls_value
	case typetime!
		if IsNull(aa_value) then
			SetNull(lt_value)
		else
			lt_value = aa_value
		end if
		la_value = lt_value
	case typeuint!
		if IsNull(aa_value) then
			SetNull(lui_value)
		else
			lui_value = aa_value
		end if
		la_value = lui_value
	case typetime!
		if IsNull(aa_value) then
			SetNull(lul_value)
		else
			lul_value = aa_value
		end if
		la_value = lul_value
end choose

return la_value

end function

public function boolean of_boolean (readonly any aa_value);////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////
return this.Convert(aa_value, TypeBoolean!)

end function

public function date of_date (readonly any aa_value);////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////
return this.Convert(aa_value, TypeDate!)

end function

public function datetime of_datetime (readonly any aa_value);////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////
return this.Convert(aa_value, TypeDateTime!)

end function

public function time of_time (readonly any aa_value);////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////
return this.Convert(aa_value, TypeTime!)

end function

public function integer propagateerrors (readonly n_cst_base anv_ofrobject);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		PropagateErrors
//
//	Arguments:		anv_ofrobject, ofr_n_cst_base
//
//	Returns:			1	success
//						-1	error
//
//	Description:	Gets errors from one OFR object and moves them to this one.
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

n_cst_ofrerror_collection lnv_collection
n_cst_ofrerror lnv_errors[]
int li_count, i

li_count = anv_ofrobject.dynamic GetOFRErrors(lnv_errors)

for i = 1 to li_count
	this.GetOFRErrorCollection().dynamic AddError(lnv_errors[i])
next

lnv_collection = anv_ofrobject.dynamic GetOFRErrorCollection()
lnv_collection.dynamic ClearPropagatedErrors()

return 1

end function

public function n_cst_bcmmgr getbcmmgr ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMMGR
//
//	Arguments:		none
//
//	Returns:			1	success
//						-1	error
//
//	Description:	Returns pointer to BCMMGR
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
return snv_bcmmgr

end function

protected function integer setbcmmgr (readonly n_cst_bcmmgr anv_bcmmgr);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBCMMGR
//
//	Arguments:		anv_bcmmgr		BCM manager
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Captures pointer to BCMMGR
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
snv_bcmmgr = anv_bcmmgr

return 1

end function

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
//	Description:	Records exception abeout calling script
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
string ls_script, ls_messageid

if IsValid(inv_exception) then
	ls_script = as_script
	ls_messageid = as_messageid
	inv_exception.dynamic Set(this, ls_script, ls_messageid)
else
	MessageBox("Exception in " + this.Classname(), "Message ID: " + as_messageid)
end if

return 1

end function

protected function integer setexception (readonly string as_script, readonly string as_messageid, readonly string as_substitutions[]);//////////////////////////////////////////////////////////////////////////////
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
//	Description:	Records exception abeout calling script
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
string ls_script, ls_messageid, ls_substitutions[]
if IsValid(inv_exception) then
	ls_script = as_script
	ls_messageid = as_messageid
	ls_substitutions = as_substitutions
	inv_exception.dynamic Set(this, ls_script, ls_messageid, ls_substitutions)
else
	MessageBox("Exception in " + this.Classname(), "Message ID: " + as_messageid)
end if

return 1

end function

protected function integer pushexception (readonly string as_script);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		PushException
//
//	Arguments:		as_script	Name of the calling script
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Records calling script history in exception service
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
string ls_script
if IsValid(inv_exception) then
	ls_script = as_script
	inv_exception.dynamic Push(this, ls_script)
end if

return 1

end function

public function ofr_s_error_collection getserializederrors ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSerializedErrors
//
//	Arguments:		none
//
//	Returns:			ofr_s_error_collection:  All errors associated with this object.
//
//	Description:	Returns errors in a structure.
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
return this.GetOFRErrorCollection().Serialize()
end function

public function boolean deserializeargs (ref any aa_args[], blob ablb_args);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DeserializeArgs
//
//	Arguments:		aa_args[16] Array by reference to deserialize into
//						ablb_args   Blob to deserialize
//
//	Returns:			boolean 	true Success
//									false Failure
//
//	Description:	Deserialize a blob and set up the retrieval arguments
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
string 			ls_type, ls_value
unsignedlong  	ul_rc = 1
unsignedint		li_arg


for li_arg = 1 to 16
	ls_type = String(BlobMid(ablb_args, ul_rc))
	ul_rc = ul_rc + len(ls_type) + 1
	ls_value =  String(BlobMid(ablb_args, ul_rc))
	ul_rc = ul_rc + len(ls_value) + 1
	aa_args[li_arg] = this.Convert(ls_value, ls_type)
next

return true

end function

public function blob serializeargs (any aa_args[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SerializeArgs
//
//	Arguments:		aa_args[]	Arguments to populate blob
//
//	returns:			lblb_args	Blob containing argument data
//
//	Description:	Populates a blob with argument data
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
unsignedint	 ui_arg
blob			 lblb_args

//		Initialize buffer
lblb_args = blob(space(60000))

for ui_arg = 1 to 16
	ul_rc = BlobEdit(lblb_args, ul_rc, string(ClassName(aa_args[ui_arg])))
	ul_rc = BlobEdit(lblb_args, ul_rc, string(aa_args[ui_arg]))
next

return lblb_args

end function

public function long getserializedbloberrors (ref blob abl_errors);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSerializedBlobErrors
//
//	Arguments:		abl_errors 	Blob to contain serialized errors passed by reference
//
//	Returns:			long
//
//	Description:	Returns errors in a structure.
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

return this.GetOFRErrorCollection().Serialize(abl_errors)


end function

public function any convert (readonly any aa_value, readonly string as_parmtype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Convert
//
//	Arguments:		aa_value			Any value to convert
//						as_parmtype		Type to convert to
//
//	returns:			Any
//
//	Description:	Converts the any variable to a specified as_parmtype.
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
any la_value
boolean lb_value
date ld_value
datetime ldt_value
decimal ldec_value
double ldbl_value
integer li_value
long ll_value
real lr_value
string ls_value
time lt_value
uint lui_value
ulong lul_value

choose case as_parmtype
	case "boolean"
		if IsNull(aa_value) then
			SetNull(lb_value)
		else
			lb_value = aa_value
		end if
		la_value = lb_value
	case "date"
		if IsNull(aa_value) then
			SetNull(ld_value)
		else
			ld_value = date(aa_value)
		end if
		la_value = ld_value
	case "datetime"
		if IsNull(aa_value) then
			SetNull(ldt_value)
		else
			ldt_value = datetime(date(mid(aa_value,1,pos(aa_value," "))), time(mid(aa_value,pos(aa_value," "))))
		end if
		la_value = ldt_value
	case "decimal"
		if IsNull(aa_value) then
			SetNull(ldec_value)
		else
			ldec_value = Dec(aa_value)
		end if
		la_value = ldec_value
	case "double"
		if IsNull(aa_value) then
			SetNull(ldbl_value)
		else
			ldbl_value = double(aa_value)
		end if
		la_value = ldbl_value
	case "integer"
		if IsNull(aa_value) then
			SetNull(li_value)
		else
			li_value = integer(aa_value)
		end if
		la_value = li_value
	case "long"
		if IsNull(aa_value) then
			SetNull(ll_value)
		else
			ll_value = long(aa_value)
		end if
		la_value = ll_value
	case "real"
		if IsNull(aa_value) then
			SetNull(lr_value)
		else
			lr_value = real(aa_value)
		end if
		la_value = lr_value
	case "string"
		if IsNull(aa_value) then
			SetNull(ls_value)
		else
			ls_value = string(aa_value)
		end if
		la_value = ls_value
	case "time"
		if IsNull(aa_value) then
			SetNull(lt_value)
		else
			lt_value = time(aa_value)
		end if
		la_value = lt_value
	case "uint"
		if IsNull(aa_value) then
			SetNull(lui_value)
		else
			lui_value = integer(aa_value)
		end if
		la_value = lui_value
end choose

return la_value

end function

on ofr_n_cst_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if isValid(inv_ofrerrorcollection) then
	destroy inv_ofrerrorcollection
end if
end event

event constructor;if IsValid(snv_bcmmgr) then
	this.inv_exception = snv_bcmmgr.dynamic GetException()
end if

end event

