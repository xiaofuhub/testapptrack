﻿$PBExportHeader$n_cst_uilink.sru
forward
global type n_cst_uilink from ofr_n_cst_uilink
end type
end forward

global type n_cst_uilink from ofr_n_cst_uilink
end type
global n_cst_uilink n_cst_uilink

forward prototypes
public function integer processofrerror (readonly n_cst_ofrerror anv_ofrerror[])
end prototypes

public function integer processofrerror (readonly n_cst_ofrerror anv_ofrerror[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ProcessOFRError  (OVERRIDE)
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

			ls_Title = anv_OFRError[1].GetMessageHeader ( )
			IF ls_Title = "" THEN
				ls_Title = "Error"
			END IF
			licon_msg = Exclamation!

			choose case anv_ofrerror[1].GetErrorType()
				case is > 0			// User validation error
					if anv_ofrerror[1].GetWarning() = TRUE then
						ls_title = "Warning"
						licon_msg = Information!
					else
						//ls_title = "Error"
						//licon_msg = StopSign!
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
//			if li_rc <> 1 then
//				ls_class = anv_ofrerror[1].GetClass()
//				ls_attribute = anv_ofrerror[1].GetAttribute()
//				if ls_class <> "" then
//					ls_errormessage = ls_class + "." + ls_attribute + " " + ls_errormessage
//				end if
//			end if
			MessageBox(ls_title, ls_errormessage, licon_msg)
			li_rc = 1
		end if
	end if
end if

return li_rc

end function

on n_cst_uilink.create
TriggerEvent( this, "constructor" )
end on

on n_cst_uilink.destroy
TriggerEvent( this, "destructor" )
end on

