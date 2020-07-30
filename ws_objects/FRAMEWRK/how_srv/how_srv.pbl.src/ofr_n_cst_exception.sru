$PBExportHeader$ofr_n_cst_exception.sru
$PBExportComments$Handles exception error logging and debugging
forward
global type ofr_n_cst_exception from n_cst_base
end type
end forward

global type ofr_n_cst_exception from n_cst_base
end type
global ofr_n_cst_exception ofr_n_cst_exception

type variables
Protected:
string is_script[], is_object[]
int ii_stack
string is_messageid
string is_substitutions[]
boolean ib_debugon
datastore ids_messages

end variables

forward prototypes
public function integer clear ()
public function integer push (readonly powerobject apo_object, readonly string as_script)
public function integer setdebug (readonly boolean ab_flag)
public function integer getmessagetext (readonly string as_messageid, ref string as_message)
public function integer set (readonly n_cst_base apo_object, readonly string as_script, readonly string as_messageid, string as_substitutiones[])
public function integer set (readonly n_cst_base apo_object, readonly string as_script, readonly string as_messageid)
end prototypes

public function integer clear ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Clear
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears out any errors in the stack.
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


ii_stack = 0

return 1

end function

public function integer push (readonly powerobject apo_object, readonly string as_script);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Push
//
//	Arguments:		Powerobject	-	apo_object	-	object in exception
//						String		-	as_script	-	script where exception occurred
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Stores a message concerning some object involved.
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
powerobject lpo_object
string ls_object
int li_objects

ii_stack++
lpo_object = apo_object
do while IsValid(lpo_object)
	li_objects++
	if li_objects > 1 then
		ls_object = ls_object + "."
	end if
	ls_object = ls_object + ClassName(lpo_object)
	lpo_object = lpo_object.GetParent()
loop

is_object[ii_stack] = ls_object
is_script[ii_stack] = as_script

// display the message to the user if in debug mode
if ib_DebugOn then
	MessageBox('OFR Debug::Exception call ', &
			'Object: ' + ClassName(apo_object) + '~nScript: ' + as_script)
end if

return 1

end function

public function integer setdebug (readonly boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDebug
//
//	Arguments:		Boolean	-	ab_flag
//
//	returns:			Integer
//
//	Description:	Turns debugging on/off
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


this.ib_DebugOn = ab_flag

return 1

end function

public function integer getmessagetext (readonly string as_messageid, ref string as_message);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetMessage
//
//	Arguments:		as_messageid	message id to get
//						as_message		returned message
//
//	returns:			Integer
//						1		success
//						-1		error - message not found
//
//	Description:	Return message information.
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
int li_rc = -1
long ll_row

ll_row = ids_messages.Find('msgid = "' + as_messageid + '"', 1, ids_messages.RowCount())
if ll_row > 0 then
	as_message = ids_messages.GetItemString(ll_row, "message")
	li_rc = 1
end if

return li_rc

end function

public function integer set (readonly n_cst_base apo_object, readonly string as_script, readonly string as_messageid, string as_substitutiones[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		Powerobject		-	apo_object
//						String			-	as_script
//						String			-	as_messageid
//						Stringarray		-	as_substitutiones[]
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Set exception information with substitutions
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
int li_objects, li_sub, li_pos
n_cst_ofrerror lnv_ofrerror
powerobject lpo_object
string ls_message, ls_object

// store incoming exception information
is_messageid = as_messageid
is_substitutions = as_substitutiones

ii_stack = 1
lpo_object = apo_object
do while IsValid(lpo_object)
	li_objects++
	if li_objects > 1 then
		ls_object = ls_object + "."
	end if
	ls_object = ls_object + ClassName(lpo_object)
	lpo_object = lpo_object.GetParent()
loop

is_object[ii_stack] = ls_object
is_script[ii_stack] = as_script

if this.GetMessageText(as_messageid, ls_message) <> 1 then
	ls_message = "No exception message found: " + as_messageid
end if

for li_sub = 1 to UpperBound(as_substitutiones)
	li_pos = Pos(ls_message, "%s")
	if li_pos > 0 then
		ls_message = left(ls_message, li_pos - 1) +&
			as_substitutiones[li_sub] + Mid(ls_message, li_pos + 2)
	end if
next

lnv_ofrerror = apo_object.AddOFRError()
lnv_ofrerror.SetErrorType(-4)
lnv_ofrerror.SetErrorMessage(as_messageid + ": " + &
	ls_message + "~n" + 'Object: ' + ls_object + '~nScript: ' + as_script)

// if in debug mode, then display the error to the user
if ib_DebugOn then
	MessageBox('OFR Debug::Exception ' + as_messageid, &
			ls_message + "~n" + &
			'Object: ' + ls_object + '~nScript: ' + as_script)


end if

return 1

end function

public function integer set (readonly n_cst_base apo_object, readonly string as_script, readonly string as_messageid);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Set
//
//	Arguments:		Powerobject		-	apo_object
//						String			-	as_script
//						String			-	as_messageid
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Set exception information
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
string ls_empty[]

return This.set(apo_object, as_script, as_messageid, ls_empty)

end function

on ofr_n_cst_exception.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_exception.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//		Create datastor for exception messages
ids_messages = create datastore
if IsValid(ids_messages) then
	ids_messages.dataobject = "d_ofrexceptions"
end if

end event

event destructor;call super::destructor;if IsValid(ids_messages) then
	destroy ids_messages
end if

end event

