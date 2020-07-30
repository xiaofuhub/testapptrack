$PBExportHeader$ofr_n_cst_ofrerror_collection.sru
forward
global type ofr_n_cst_ofrerror_collection from n_cst_base
end type
end forward

global type ofr_n_cst_ofrerror_collection from n_cst_base
end type
global ofr_n_cst_ofrerror_collection ofr_n_cst_ofrerror_collection

type variables
protected:

n_cst_ofrerror inv_ofrerror[]
integer ii_errorcount

end variables

forward prototypes
public function n_cst_ofrerror adderror ()
public function integer AddError (readonly n_cst_ofrerror anv_error)
public function integer ClearError (integer ai_errornumber)
public function integer ClearErrors ()
public function integer ClearPropagatedErrors ()
public function integer deserialize (readonly ofr_s_error_collection astr_collection)
public function integer GetErrorArray (ref n_cst_ofrerror anv_errors[])
public function integer geterrorcount ()
public function integer serialize (ref blob ablb_collection)
public function ofr_s_error_collection serialize ()
public function integer deserialize (readonly blob ablb_collection)
end prototypes

public function n_cst_ofrerror adderror ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddError
//
//	Arguments:		none
//
//	Returns:			n_cst_ofrerror	Newly created ofr error object
//
//	Description:	Creates ofr error object for this BCM
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2	Initial version
// 1.2 	GK - Added to BDM
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ii_errorcount++

// If using an compatibility, using old Error Service.
if classname(this.GetBCMMGR()) = "n_cst_bommgr" then
	inv_ofrerror[ii_errorcount] = create using "n_cst_dbferror"
else
	inv_ofrerror[ii_errorcount] = create n_cst_ofrerror	
end if

return inv_ofrerror[ii_errorcount]
end function

public function integer AddError (readonly n_cst_ofrerror anv_error);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddError
//
//	Arguments:		anv_error, Error object to insert
//
//	Returns:			Error position
//
//	Description:	Adds an error object to the collection.  Used when propagating errors.
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
ii_errorcount++
inv_ofrerror[ii_errorcount] = anv_error

return ii_errorcount
end function

public function integer ClearError (integer ai_errornumber);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearError
//
//	Arguments:		ai_errornumber:  Number of error object to remove.
//
//	Returns:			1
//
//	Description:	Removes and destroys an error object.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 1.2 	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

destroy inv_ofrerror[ai_errornumber]

return 1


end function

public function integer ClearErrors ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearErrors
//
//	Arguments:		none
//
//	Returns:			1
//
//	Description:	Removes and destroys all error objects.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2	Initial version
// 1.2 	GK - Added to BDM
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_count, li_total

li_total = ii_errorcount

for li_count = li_total to 1 step -1
	ClearError(li_count)
	ii_errorcount --
next

return 1
end function

public function integer ClearPropagatedErrors ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearPropagatedErrors
//
//	Arguments:		none
//
//	Returns:			1
//
//	Description:	Resets counter but does not destroy errors since they have 
//						copied or propagated to another object.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 1.2 	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ii_errorcount = 0

return 1
end function

public function integer deserialize (readonly ofr_s_error_collection astr_collection);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deserialize
//
//	Arguments:		astr_collection - Serialized error structure.
//
//	Returns:			Integer  >=0	# of deserialized errors
//									-1		Error
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
int i
n_cst_ofrerror lnv_error

for i = 1 to astr_collection.i_count
	lnv_error = this.AddError()
	lnv_error.Deserialize(astr_collection.s_errors[i])
next

return ii_errorcount

end function

public function integer GetErrorArray (ref n_cst_ofrerror anv_errors[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetErrorArray
//
//	Arguments:		none
//
//	Returns:			1
//
//	Description:	Get errors in array form.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 1.2 	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
anv_errors = inv_ofrerror

return ii_errorcount
end function

public function integer geterrorcount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetErrorCount
//
//	Arguments:		none
//
//	Returns:			Number of errors in the collection.
//
//	Description:	Called to determine number of errors in the collection.
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
return ii_errorcount
end function

public function integer serialize (ref blob ablb_collection);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Serialize
//
//	Arguments:		ablb_collection	Return blob of serialized error collection
//
//	Returns:			Integer	1	Success
//									-1	Error
//
//	Description:	Turns this object into a stream which can be returned from
//						the server to the client.
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
blob lblb_error
ofr_s_error_collection lstr_collection
int li_rc = 1, i, li_count
long ll_len
unsignedlong lul_rc

//		Truncate buffer
ablb_collection = lblb_error

for i = 1 to ii_errorcount
	if isValid(inv_ofrerror[i]) then
		lul_rc = inv_ofrerror[i].Serialize(lblb_error)
		if lul_rc > 0 then
			//		Prepend error length
			ll_len = Len(String(lul_rc)) + 1
			lblb_error = Blob(space(ll_len)) + lblb_error
			BlobEdit(lblb_error, 1, String(lul_rc))
			ablb_collection = ablb_collection + lblb_error
		else
			li_rc = -1
			exit
		end if
	end if
next

return li_rc

end function

public function ofr_s_error_collection serialize ();//////////////////////////////////////////////////////////////////////////////
//

//	Function:		Serialize
//
//	Arguments:		none
//
//	Returns:			ofr_s_error, serialized error structure.
//
//	Description:	Turns this object into a stream which can be returned from the 
//						server to the client.
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
ofr_s_error_collection lstr_collection
int i, li_count

for i = 1 to ii_errorcount
	if isValid(inv_ofrerror[i]) then
		lstr_collection.i_count++
		lstr_collection.s_errors[lstr_collection.i_count] = inv_ofrerror[i].Serialize()
	end if
next

return lstr_collection
end function

public function integer deserialize (readonly blob ablb_collection);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Deserialize
//
//	Arguments:		ablb_collection - Serialized error blob
//
//	Returns:			Integer  >=0	# of deserialized errors
//									-1		Error
//
//	Description:	Populates this error object from serialized blob.
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
n_cst_ofrerror lnv_error
int li_rc
long ll_length
string ls_temp
unsignedlong lul_pos = 1, lul_errorlength

ll_length = Len(ablb_collection)

do while lul_pos < ll_length
	ls_temp = String(BlobMid(ablb_collection, lul_pos))
	lul_pos = lul_pos + Len(ls_temp) + 1
	lul_errorlength = Long(ls_temp)
	lnv_error = this.AddError()
	if lnv_error.Deserialize(BlobMid(ablb_collection, lul_pos, lul_errorlength)) = 1 then
		li_rc = ii_errorcount
	else
		li_rc = -1
		exit
	end if
	lul_pos = lul_pos + lul_errorlength
loop

return li_rc

end function

on ofr_n_cst_ofrerror_collection.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_ofrerror_collection.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			destructor
//
//	Description:	Destroy all errors
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
this.ClearErrors()
end event

