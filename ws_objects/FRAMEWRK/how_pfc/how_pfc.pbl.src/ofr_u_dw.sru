$PBExportHeader$ofr_u_dw.sru
$PBExportComments$Ancestor to u_dw, inherits from pfc_u_dw: used with OFR and PFC together
forward
global type ofr_u_dw from pfc_u_dw
end type
end forward

global type ofr_u_dw from pfc_u_dw
event type n_cst_uilink_dw ofr_getuilink ( )
event type integer ofr_error ( readonly n_cst_ofrerror_collection anv_ofrerror_collection )
event type integer ofr_mapcolumns ( )
end type
global ofr_u_dw ofr_u_dw

type variables
Public:
n_cst_uilink_dw inv_uilink	// dw business object (bo) service

ProtectedRead ProtectedWrite Long il_RtnVal     // Ancestor event return value

protected:
boolean ib_ofritemchangederror
boolean ib_ofrresetting
boolean ib_retrievingdetail
any ia_key_values[16]
boolean ib_ofrinserting, ib_ofrdeleting
string is_openframeservice = "n_cst_uilink_dw"
boolean ib_usetaskretrieve = false

end variables

forward prototypes
public function integer retrieve (any arg1, any arg2, any arg3, any arg4, any arg5, any arg6, any arg7, any arg8, any arg9, any arg10, any arg11, any arg12, any arg13, any arg14, any arg15, any arg16, any arg17, any arg18, any arg19, any arg20)
public subroutine setkeyvalue (integer ai_index, any aa_value)
public function integer setitem (long al_row, readonly string as_column, any aa_value)
public function integer setitem (long al_row, readonly integer ai_column, any aa_value)
public function integer setitem (long al_row, readonly string as_column, string as_value)
protected function integer setnull (readonly long al_row, readonly integer ai_column)
protected function integer setnull (readonly long al_row, readonly string as_column)
public function integer ofrerror ()
public function long ofrinsertrow (long al_row)
public function long insertrow (long al_row)
public function integer deleterow (long al_row)
public function integer ofrdeleterow (long al_row)
public function integer setuilink (readonly boolean ab_switch)
protected function integer ofrsetitem (long al_row, readonly string as_column, any aa_value)
public function integer reset ()
public function integer resetpresentation ()
protected subroutine setusetaskretrieve (boolean ab_flag)
end prototypes

event ofr_getuilink;call super::ofr_getuilink;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_GetUILink
//
//	Arguments:		none
//
//	returns:			n_cst_uilink
//
//	Description:	Returns a pointer to the service object for this datawindow
//						control.
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
return inv_uilink
end event

event ofr_error;call super::ofr_error;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			OFRError
//
//	Arguments:		anv_ofrerror_collection		Passed in error collection
//
//	returns:			Integer	0		Error not processed
//									<>0 	Error processed
//
//	Description:	Invoked whenever an error occurs when the UILink service
//						is turned on. Place code within this event to use your own
//						error service. Returning 0 (default) will cause UILink to
//						process and display the error message. Returning anything
//						other than 0 assumes the error has been processed and
//						UILink will not display a message.
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
return 0

end event

event ofr_mapcolumns;call super::ofr_mapcolumns;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_mapcolumns
//
//	Arguments:		none
//
//	returns:			integer
//
//	Description:	Registers requestor columns using dbname information.
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
return 0

end event

public function integer retrieve (any arg1, any arg2, any arg3, any arg4, any arg5, any arg6, any arg7, any arg8, any arg9, any arg10, any arg11, any arg12, any arg13, any arg14, any arg15, any arg16, any arg17, any arg18, any arg19, any arg20);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		20 of any datatype
//
//	returns:			Integer	- number of rows retrieved.
//
//	Description:	Overrides PowerBuilder function Retrieve - so the retrieval will
//						be done through business object services by using the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.20.04	BTR# 9056 Set indicator for retrieving detail
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int rc
any rca
 
if not isValid(inv_uilink) then
	rc = super::retrieve(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19,arg20)
else
	setKeyValue(1, arg1)
	setKeyValue(2, arg2)
	setKeyValue(3, arg3)
	setKeyValue(4, arg4)
	setKeyValue(5, arg5)
	setKeyValue(6, arg6)
	setKeyValue(7, arg7)
	setKeyValue(8, arg8)
	setKeyValue(9, arg9)
	setKeyValue(10, arg10)
	setKeyValue(11, arg11)
	setKeyValue(12, arg12)
	setKeyValue(13, arg13)
	setKeyValue(14, arg14)
	setKeyValue(15, arg15)
	setKeyValue(16, arg16)

	ib_retrievingdetail = true
	rca = Event pfc_retrieve()
	ib_retrievingdetail = false
	rc = Integer(rca)
end if

return rc
end function

public subroutine setkeyvalue (integer ai_index, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetKeyValue
//
//	Arguments:		Integer	-	ai_index
//						Any		-	aa_value
//
//	returns:			None
//
//	Description:	Stores any key values in an array.
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
ia_key_values[ai_index] = aa_value
end subroutine

public function integer setitem (long al_row, readonly string as_column, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetItem
//
//	Arguments:		Long		-	al_row
//						String	-	as_column
//						Any		-	aa_value
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overrides PowerBuilder function SetItem in order to capture any
//						changes to be sent to the BCM if business object services are
//						turned on.
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
return this.OFRSetItem(al_row, as_column, aa_value)

end function

public function integer setitem (long al_row, readonly integer ai_column, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetItem
//
//	Arguments:		Long		-	al_row
//						Integer	-	ai_column
//						Any		-	aa_value
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overrides PowerBuilder function SetItem in order to capture any
//						changes to be sent to the BCM if business object services are
//						turned on.
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
return this.OFRSetItem(al_row, This.Describe('#'+string(ai_column)+'.name'), aa_value)

end function

public function integer setitem (long al_row, readonly string as_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetItem
//
//	Arguments:		Long		-	al_row
//						String	-	as_column
//						String	-	as_value
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overrides PowerBuilder function SetItem in order to capture any
//						changes to be sent to the BCM if business object services are
//						turned on.
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
return this.OFRSetItem(al_row, as_column, as_value)

end function

protected function integer setnull (readonly long al_row, readonly integer ai_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetNull
//
//	Arguments:		al_row		row number
//						ai_column	column number
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Calls ancestor SetItem with null of proper datatype
//						FOR INTERNAL USE ONLY
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
Int li_rc
String ls_coltype
String ls_null
DateTime ldt_null
Date ld_null
Time lt_null
Double ldbl_null

ls_coltype = this.describe("#" + String(ai_column) + ".coltype")
choose case Left(ls_coltype, 5)
	case "char("
		SetNull(ls_null)
		li_rc = super::SetItem(al_row, ai_column, ls_null)
	case "datet"
		SetNull(ldt_null)
		li_rc = super::SetItem(al_row, ai_column, ldt_null)
	case "date"
		SetNull(ld_null)
		li_rc = super::SetItem(al_row, ai_column, ld_null)
	case "time"
		SetNull(lt_null)
		li_rc = super::SetItem(al_row, ai_column, lt_null)
	case else
		SetNull(ldbl_null)
		li_rc = super::SetItem(al_row, ai_column, ldbl_null)
end choose

return li_rc

end function

protected function integer setnull (readonly long al_row, readonly string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetNull
//
//	Arguments:		al_row		row number
//						as_column	column name
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Calls ancestor SetItem with null of proper datatype
//						FOR INTERNAL USE ONLY
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
Int li_rc, li_column

li_column = Integer(this.Describe(as_column + ".id"))
li_rc = this.SetNull(al_row, li_column)

return li_rc

end function

public function integer ofrerror ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ofrerror
//
//	Arguments:		none
//
//	returns:			Integer
//						0		Error not processed
//						<>0	Error processed in event
//
//	Description:	Invokes ofr_error event.
//						FOR INTERNAL USE ONLY
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
n_cst_ofrerror_collection lnv_ofrerrors

lnv_ofrerrors = inv_uilink.GetOFRErrorCollection()

return this.event ofr_error(lnv_ofrerrors)

end function

public function long ofrinsertrow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		OFRInsertRow
//

//	Arguments:		al_row	Row before which you want to insert the row.
//
//	returns:			Long
//						>0		Number of the row that was added
//						-1		error
//
//	Description:	Used by OFR to insert a row in the requestor.
//						FOR INTERNAL USE ONLY
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
long ll_row

ib_ofrinserting = true
ll_row = this.InsertRow(al_row)
ib_ofrinserting = false

return ll_row

end function

public function long insertrow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		InsertRow
//
//	Arguments:		al_row	Row before which you want to insert the row.
//
//	returns:			Long
//						>0		Number of the row that was added
//						-1		error
//
//	Description:	Inserts a row into the DataWindow
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
// 1.3 	  Don't process errors because UI Link is already doing that.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_row

if IsValid(this.inv_uilink) and ib_ofrinserting = false then
	ll_row = this.inv_uilink.InsertRow(al_row)
else
	ll_row = super::InsertRow(al_row)
end if

return ll_row

end function

public function integer deleterow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DeleteRow
//
//	Arguments:		al_row	The row you want to delete.
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Deletes a row from the DataWindow
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2   Initial version
// 1.3 	  Don't process errors because UI Link is already doing that.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc

if IsValid(this.inv_uilink) and ib_ofrdeleting = false then
	li_rc = this.inv_uilink.DeleteRow(al_row)
else
	li_rc = super::DeleteRow(al_row)
end if

return li_rc

end function

public function integer ofrdeleterow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		OFRDeleteRow
//
//	Arguments:		al_row	Row to delete
//
//	returns:			Long
//						1		success
//						-1		error
//
//	Description:	Used by OFR to delete a row in the requestor.
//						FOR INTERNAL USE ONLY
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
int li_rc

ib_ofrdeleting = true
li_rc = this.DeleteRow(al_row)
ib_ofrdeleting = false

return li_rc

end function

public function integer setuilink (readonly boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUILink
//
//	Arguments:		Boolean	-	ab_switch
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Turns business object services on/off
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
int li_rc
n_cst_ofrerror lnv_ofrerror[]

//Check arguments
if IsNull(ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid(inv_uilink) then
		inv_uilink = create using is_openframeservice
		if inv_uilink.SetRequestor(this) = 1 then
			li_rc = 1
		else
			//		Check for error and process
			this.inv_uilink.GetOFRErrors(lnv_ofrerror)
			if UpperBound(lnv_ofrerror) > 0 then
				if IsValid(lnv_ofrerror[1]) then
					this.inv_uilink.ProcessOFRError(lnv_ofrerror)
				end if
			end if
			li_rc = -1
		end if
	end if
else
	if IsValid(inv_uilink) then
		destroy inv_uilink
		li_rc = 1
	end if	
end if

return li_rc

end function

protected function integer ofrsetitem (long al_row, readonly string as_column, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		OFRSetItem
//
//	Arguments:		Long		-	al_row
//						String	-	as_column
//						Any		-	aa_value
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Common implementation of SetItem functionality.
//						FOR INTERNAL USE ONLY
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0.2 	BTR 6761 - Pass on unregistered column sets to Super::SetItem
//	1.0.2 	Fix call to super with null values
//	1.2      Initial version
//	1.20.03	Fix call to super with null values
// 2.1      BTR 11781 - Fix call to super with null values
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
boolean lb_set
int li_rc
n_cst_ofrerror lnv_ofrerror[]

if IsValid ( inv_uilink ) then			// business object services
	li_rc = this.inv_uilink.set(al_row, as_column, aa_value)
	if li_rc = 1 then
		lb_set = true
	elseif li_rc = 0 then
		// 1.20.03 - Different function to set nulls because
		// SetItem won't work if you pass it a null any.
		if isNull(aa_value) then
			li_rc = this.SetNull(al_row, as_column)
		else
			li_rc = super::SetItem(al_row, as_column, aa_value)
		end if
	else
		//		Check for error and process
		this.inv_uilink.GetOFRErrors(lnv_ofrerror)
		if UpperBound(lnv_ofrerror) > 0 then
			if IsValid(lnv_ofrerror[1]) then
				this.inv_uilink.ProcessOFRError(lnv_ofrerror)
			end if
		end if
	end if
else
	if isNull(aa_value) then
		li_rc = this.SetNull(al_row, as_column)
	else
		li_rc = super::SetItem(al_row, as_column, aa_value)
	end if
end if

return li_rc

end function

public function integer reset ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Reset
//
//	Arguments:		none
//
//	returns:			Integer
//						1		Success
//						-1		Error
//
//	Description:	Clears data from DataWindow and BCM if there is one.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 1.3 		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer li_rc

if ib_ofrresetting = false then
	if IsValid(this.inv_uilink) then
		li_rc = this.inv_uilink.Reset()
		if li_rc <> 1 then return li_rc
	end if
end if

return super::reset()

end function

public function integer resetpresentation ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ResetPresentation
//
//	Arguments:		none
//
//	returns:			Integer
//						1		Success
//						-1		Error
//
//	Description:	Clears data from DataWindow, but not from the BCM.
//						Called from UI Link to reset the presentation.
//						FOR INTERNAL USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
// 1.3 		Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc

ib_ofrresetting = true
li_rc = this.Reset()
ib_ofrresetting = false

return li_rc

end function

protected subroutine setusetaskretrieve (boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUseTaskRetrieve
//
//	Arguments:		ab_flag - Whether or not the pfc_retrieve event should invoke
//						the task_retrieve event in order to perform the retrieve.
//
//	returns:			None
//
//	Description:	Whether or not the pfc_retrieve event should invoke
//						the task_retrieve event in order to perform the retrieve.
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
ib_usetaskretrieve = ab_flag
end subroutine

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Itemchanged
//
//	Arguments:		Long		-	row
//						dwobject	-	dwo
//						String	-	data
//
//	returns:			Long
//
//	Description:	Capture any changes made by the user for business object
//						services to communicate to the BCM.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.0.2	BTR 6760 - Add BCM error serice call
//	1.0.2	BTR 6759 - check for warnings
//	1.0.2	Add ib_ofritemchangederror setting for itemerror event notification
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_cst_ofrerror lnv_ofrerror[]
il_rtnval = 0
int li_rc

if IsValid(inv_uilink) then			// business object services
	li_rc = this.inv_uilink.SetText( row, dwo.name, data)
	if li_rc < 0 then
		il_rtnval = 1
		ib_ofritemchangederror = true
		//		Check for warning and process
		this.inv_uilink.GetOFRErrors(lnv_ofrerror)
		if UpperBound(lnv_ofrerror) > 0 then
			if IsValid(lnv_ofrerror[1]) then
				if lnv_ofrerror[1].GetWarning() = true then
					this.inv_uilink.ProcessOFRError(lnv_ofrerror)
					il_rtnval = 0
					ib_ofritemchangederror = false
				end if
			end if
		end if
	end if
end if

return il_rtnval

end event

event pfc_update;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			pfc_Update
//
//	Arguments:		Boolean	-	ab_accepttext
//						Boolean	-	ab_resetflag
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Make sure any updates are done through the BCM if business
//						object services are turned on.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1   Remove processing of errors since they are processed by the transaction
//			service
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_rc

if IsValid(inv_uilink) then
	li_rc = inv_uilink.save(ab_accepttext, ab_resetflag)
else
	li_rc = super::event pfc_update(ab_accepttext, ab_resetflag)
end if

return li_rc
end event

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Destructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	cleans up the business object services.
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
this.SetUILink( FALSE )
end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			pfc_retrieve
//
//	Arguments:		none
//
//	returns:			integer	- number of rows retrieved
//
//	Description:	Make sure any retrievals go through the BCM if business object
//						services are turned on.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//	1.20.04	BTR# 9056 Only allow retrieve of detail linkage when we come from
//				Retrieve() method on this object.
//	1.20.05  Allow 16 arguments.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if isValid(inv_uilink) then
	//		Skip retrieval if:
	//			- linkage is turned on
	//			- its retrieve based linkage (of_GetUseColLinks() = 2)
	//			- we are dealing with a detail dw (IsRoot() = false)
	//			- we were not invoked from the Retrieve() function (ib_RetrievingDetail = false)
	//		BTR# 9056 - This avoids double retrieves on detail DW's when the
	//		master DW is retrieved. This works around a bug in of_Retrieve in
	//		pfc_n_cst_dwsrv_linkage where it retrieves the detail DW's after
	//		retrieving the master.
	if IsValid(inv_linkage) then
		if inv_linkage.of_GetUseColLinks() = 2 then
			if inv_linkage.of_IsRoot() = false then
				if ib_retrievingdetail = false then
					return 0
				end if
			end if
		end if
	end if
	if ib_usetaskretrieve = false then
		return inv_uilink.Retrieve( ia_key_values[1], &
												ia_key_values[2], &
												ia_key_values[3], &
												ia_key_values[4], &
												ia_key_values[5], &
												ia_key_values[6], &
												ia_key_values[7], &
												ia_key_values[8], &
												ia_key_values[9], &
												ia_key_values[10], &
												ia_key_values[11], &
												ia_key_values[12], &
												ia_key_values[13], &
												ia_key_values[14], &
												ia_key_values[15], &
												ia_key_values[16])
	else
		return this.event dynamic task_retrieve()
	end if											

else
	return 0
end if

end event

event itemerror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Itemerror
//
//	Arguments:		Long		-	row
//						dwobject	-	dwo
//						String	-	data
//
//	returns:			Long
//
//	Description:	Invoked by PB for DW datatype errors, DW validation
//						errors and ItemChanged errors. If UILink is turned on and
//						this is an ItemChanged error then attempt to process
//						the OFR errors.
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
Long ll_err_nbr
String ls_err_text, ls_title
n_cst_ofrerror lnv_ofrerror[]

il_rtnval = super::event ItemError(row, dwo, data)

if il_rtnval = 0 then
	if IsValid(inv_uilink) and ib_OFRItemChangedError = true then
		ib_OFRItemChangedError = false
		this.inv_uilink.GetOFRErrors(lnv_ofrerror)
		if this.inv_uilink.ProcessOFRError(lnv_ofrerror) > 0 then
			il_rtnval = 1
		end if
	end if
end if

return il_rtnval

end event

event pfc_updatespending;call super::pfc_updatespending;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			pfc_UpdatesPending
//
//	Arguments:		none
//
//	returns:			integer
//						> 0		Updates are pending
//						0			No updates are pending
//
//	Description:	Determine if any updates are pending on this datawindow
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 2.0   Added call to IsBCMCreated and return code from pfc_updatesPending
//			can now be greater than 1
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_rc

if IsValid(inv_uilink) then
	if inv_uilink.IsBCMCreated() then
		if inv_uilink.GetBCM().UpdatesPending() > 0 then
			li_rc = 1
		end if
	end if
else
	li_rc = Super::Event pfc_UpdatesPending()
end if

if li_rc > 1 then
	li_rc = 1
end if

return li_rc
end event

event updatestart;call super::updatestart;// 1.3 Return something to avoid PB compiled code problem.
return 0

end event

