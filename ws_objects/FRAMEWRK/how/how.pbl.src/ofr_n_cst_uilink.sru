$PBExportHeader$ofr_n_cst_uilink.sru
forward
global type ofr_n_cst_uilink from n_cst_base
end type
end forward

global type ofr_n_cst_uilink from n_cst_base
end type
global ofr_n_cst_uilink ofr_n_cst_uilink

type variables
protected:
powerobject ipo_requestor
string is_openframeservice = "n_cst_uilink"
string is_class[]
string is_db_name
n_cst_bcm inv_bcm
string is_dlk_name
string is_beokey_name

end variables

forward prototypes
public function integer setrequestor (readonly powerobject apo_requestor)
public function integer addclass (readonly string as_classname)
public function integer setclass (readonly string as_classname)
public function integer seterrorfocus (readonly n_cst_ofrerror anv_ofrerror)
public subroutine setopenframeservice (string as_service)
public function boolean setdatabase (readonly string as_dbname)
public function integer processofrerror (readonly n_cst_ofrerror anv_ofrerror[])
public function integer setdlk (string as_dlkname)
public function string getdlk ()
end prototypes

public function integer setrequestor (readonly powerobject apo_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetRequestor
//
//	Arguments:		apo_requestor	Requestor object
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Identifies the requestor object to the
//						business object services.
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

if IsValid ( ipo_requestor ) then
	li_rc = -1
else
	ipo_requestor  = apo_requestor
end if

return li_rc

end function

public function integer addclass (readonly string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddClass
//
//	Arguments:		as_classname	Classname
//
//	Returns:			1 Success
//						-1 failure
//
//	Description:	Sets additional update class
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
int li_rc = -1, li_classes

if as_classname > "" then
	if not IsValid(inv_bcm) then
		li_classes = UpperBound(is_class) + 1
		is_class[li_classes] = as_classname
		li_rc = 1
	end if
end if

return li_rc

end function

public function integer setclass (readonly string as_classname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetClass
//
//	Arguments:		as_classname	Business object class name
//
//	Returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Used to assign class name used when creating busines
//						object instances for the associated BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	Change to call AddClass
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc

li_rc = this.AddClass(as_classname)

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
return 1

end function

public subroutine setopenframeservice (string as_service);//svh junk

is_openframeservice = as_service
end subroutine

public function boolean setdatabase (readonly string as_dbname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDatabase
//
//	Arguments:		as_dbname	Database name
//
//	Returns:			Boolean
//
//	Description:	Indicates what database to use for retrieval and update.
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
is_db_name = as_dbname

return true
end function

public function integer processofrerror (readonly n_cst_ofrerror anv_ofrerror[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ProcessOFRError
//
//	Arguments:		anv_ofrerror[]		Array of OFR error objects
//
//	returns:			Integer	1  success
//									0	no messages to process
//									-1 error
//
//	Description:	Processes the list of errors passed in by invoking
//						the ofr_error event on the requestor. If the requestor
//						does not process the errors then a message beox is display
//						showing the information from the first error object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
// 2.1     Make sure the error class is valid before using it
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc
long ll_errornumber, ll_sqldbcode
string ls_errormessage, ls_title, ls_sqlerrtext, ls_sqlsyntax
string ls_class, ls_attribute
icon licon_msg


if UpperBound(anv_ofrerror) > 0 then
	if isValid(anv_ofrerror[1]) then
		//		Make dynamic function call to invoke error service
		//		Can't make dynamic calls with arrays because PB 5.0.0 does not support it
		//		So call function on requestor that will calls back to beosrv to get errors
		li_rc = ipo_requestor.Dynamic ofrerror()
		if li_rc = 0 then
			choose case anv_ofrerror[1].GetErrorType()
				case is > 0			// User validation error
					if anv_ofrerror[1].GetWarning() = TRUE then
						ls_title = "Warning"
						licon_msg = Information!
					else
						ls_title = "Error"
						licon_msg = StopSign!
					end if
					ll_errornumber = anv_ofrerror[1].GetErrorNumber()
					if ll_errornumber > 0 then
						ls_title = ls_title + ": " + string(ll_errornumber)
					end if
					ls_errormessage = anv_ofrerror[1].GetErrorMessage()
					if ls_errormessage = "" then
						ls_errormessage = "No error message available"
					end if
				case -1	// DBError
					ll_sqldbcode = anv_ofrerror[1].GetSQLDBCode()
					if ll_sqldbcode <> 0 then
						ls_title = "Database Error: " + String(ll_sqldbcode)
						licon_msg = StopSign!
						ls_errormessage = anv_ofrerror[1].GetSQLErrText()
					end if
				case -2	//	Required missing error
					ls_title = "Error"
					licon_msg = StopSign!
					ls_errormessage = "Value is required"
				case -3	//	Required missing error
					ls_title = "Error"
					licon_msg = StopSign!
					ls_errormessage = "Duplicate value"
				case -4 // Internal OFR error
					ls_title = "OpenFrame Internal Error"
					licon_msg = StopSign!
					ls_errormessage = anv_ofrerror[1].GetErrorMessage()
			end choose
			li_rc = this.SetErrorFocus(anv_ofrerror[1])
			//		If could not set error focus then add class/attribute to message
			if li_rc <> 1 then
				ls_class = anv_ofrerror[1].GetClass()
				ls_attribute = anv_ofrerror[1].GetAttribute()
				if ls_class <> "" then
					ls_errormessage = ls_class + "." + ls_attribute + " " + ls_errormessage
				end if
			end if
			MessageBox(ls_title, ls_errormessage, licon_msg)
			li_rc = 1
		end if
	end if
end if

return li_rc

end function

public function integer setdlk (string as_dlkname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDLK
//
//	Arguments:		as_dlkname		DLK name
//
//	Returns:			Integer
//
//	Description:	Indicates what DLK or BEOKey to use for retrieval and update.
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
is_dlk_name = as_dlkname

return 1
end function

public function string getdlk ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDLK
//
//	Arguments:		None
//
//	Returns:			Name of DLK
//
//	Description:	Returns DLK or BEOKey used for retrieval and update.
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
return is_dlk_name
end function

on ofr_n_cst_uilink.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_uilink.destroy
TriggerEvent( this, "destructor" )
end on

