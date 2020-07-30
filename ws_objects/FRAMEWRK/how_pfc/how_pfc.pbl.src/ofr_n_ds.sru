$PBExportHeader$ofr_n_ds.sru
$PBExportComments$Ancestor for n_ds, inherits from pfc_n_ds: for use with OFR and PFC together.
forward
global type ofr_n_ds from pfc_n_ds
end type
end forward

global type ofr_n_ds from pfc_n_ds
event type boolean pfc_descendent ( )
event type n_cst_uilink_dw ofr_getuilink ( )
event type integer ofr_error ( readonly n_cst_ofrerror_collection anv_ofrerror_collection )
event type integer ofr_mapcolumns ( )
end type
global ofr_n_ds ofr_n_ds

type variables
public:
n_cst_uilink_dw inv_uilink

protected:
boolean ib_ofrinserting, ib_ofrdeleting
boolean ib_ofrresetting
string is_openframeservice = "n_cst_uilink_dw"


end variables

forward prototypes
public function integer setitem (long al_row, readonly integer ai_column, any aa_value)
public function integer setitem (long al_row, readonly string as_column, any aa_value)
public function integer setitem (long al_row, readonly string as_column, string as_value)
protected function integer setnull (readonly long al_row, readonly integer ai_column)
protected function integer setnull (readonly long al_row, readonly string as_column)
public function integer ofrerror ()
public function long insertrow (long al_row)
public function long ofrinsertrow (long al_row)
public function integer deleterow (long al_row)
public function integer ofrdeleterow (long al_row)
public function integer setuilink (boolean ab_switch)
public function integer ofrsetitem (long al_row, readonly string as_column, any aa_value)
public function integer retrieve (any arg1, any arg2, any arg3, any arg4, any arg5, any arg6, any arg7, any arg8, any arg9, any arg10, any arg11, any arg12, any arg13, any arg14, any arg15, any arg16, any arg17, any arg18, any arg19, any arg20)
public function integer reset ()
public function integer resetpresentation ()
end prototypes

event pfc_descendent;call super::pfc_descendent;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_descendant
//
//	Arguments:   none
//
//	Returns:  boolean
//
//	Description:  Always returns true and is used to determine that this
//	   class is part of the PowerBuilder Foundation Class Library.
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Powersoft is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
return true

end event

event ofr_getuilink;call super::ofr_getuilink;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			ofr_getuilink
//
//	Arguments:		none
//
//	returns:			n_cst_uilink_dw
//
//	Description:	Returns a pointer to the business object services for this 
//						datastore.
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
//						error service. Returning 0 will cause UILink to
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
return 1

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
//	Description:	Overrides the PowerBuilder SetItem function in order to 
//						trap any changes to the presentation buffer for business object
//						services.
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
//	Description:	Overrides the PowerBuilder SetItem function in order to 
//						trap any changes to the presentation buffer for business object
//						services.
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
//	Description:	Overrides the PowerBuilder SetItem function in order to 
//						trap any changes to the presentation buffer for business object
//						services.
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

ls_coltype = this.Describe("#" + String(ai_column) + ".coltype")
choose case Left(ls_coltype, 5)
	case "char("
		SetNull(ls_null)
		li_rc = Super::SetItem(al_row, ai_column, ls_null)
	case "datet"
		SetNull(ldt_null)
		li_rc = Super::SetItem(al_row, ai_column, ldt_null)
	case "date"
		SetNull(ld_null)
		li_rc = Super::SetItem(al_row, ai_column, ld_null)
	case "time"
		SetNull(lt_null)
		li_rc = Super::SetItem(al_row, ai_column, lt_null)
	case else
		SetNull(ldbl_null)
		li_rc = Super::SetItem(al_row, ai_column, ldbl_null)
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
//	Description:	Inserts a row into the DataStore
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
n_cst_ofrerror lnv_ofrerror[]

if IsValid(this.inv_uilink) and ib_ofrinserting = false then
	ll_row = this.inv_uilink.InsertRow(al_row)
	if ll_row < 0 then
		this.inv_uilink.GetOFRErrors(lnv_ofrerror)
		this.inv_uilink.ProcessOFRError(lnv_ofrerror)
	end if
else
	ll_row = super::InsertRow(al_row)
end if

return ll_row

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
//	Description:	Deletes a row from the DataStore
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
n_cst_ofrerror lnv_ofrerror[]

if IsValid(this.inv_uilink) and ib_ofrdeleting = false then
	li_rc = this.inv_uilink.DeleteRow(al_row)


	if li_rc < 0 then
		this.inv_uilink.GetOFRErrors(lnv_ofrerror)
		this.inv_uilink.ProcessOFRError(lnv_ofrerror)
	end if
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

public function integer setuilink (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetBEO
//
//	Arguments:		Boolean	-	ab_switch
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Turns the business object services on/off.
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
	if not IsValid (inv_uilink) then
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

public function integer ofrsetitem (long al_row, readonly string as_column, any aa_value);//////////////////////////////////////////////////////////////////////////////
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
//	1.0.2	BTR 6761 - Pass on unregistered column sets to Super::SetItem
//	1.0.2	Fix call to super with null values
//	1.2   Initial version
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
	// 1.20.03 - Different function to set nulls because
	// SetItem won't work if you pass it a null any.
	if isNull(aa_value) then
		li_rc = this.SetNull(al_row, as_column)
	else
		li_rc = super::SetItem(al_row, as_column, aa_value)
	end if
end if

return li_rc

end function

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
//	1.3   	Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int rc
 
if IsValid(inv_uilink) then
	rc = inv_uilink.Retrieve(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
else
	rc = super::retrieve(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13,arg14,arg15,arg16,arg17,arg18,arg19,arg20)
end if

return rc
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
//	Description:	Clears data from DataStore and BCM if there is one.
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

on ofr_n_ds.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on ofr_n_ds.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event destructor;call super::destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Destructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Performs any cleanup for the datastore - destroying the 
//						business object service.
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
this.SetUILink(FALSE)

end event

event updatestart;call super::updatestart;// 1.3 Return something to avoid PB compiled code problem.
return 0

end event

