$PBExportHeader$ofr_n_cst_beolog.sru
forward
global type ofr_n_cst_beolog from n_cst_base
end type
end forward

global type ofr_n_cst_beolog from n_cst_base
end type
global ofr_n_cst_beolog ofr_n_cst_beolog

type variables
Private:
DataStore ids_bcm, ids_beo
NonVisualObject invo_bcm[], invo_beo[]

end variables

forward prototypes
private function integer AddBCM (readonly n_cst_bcm anvo_bcm)
private function integer addbeo (readonly n_cst_beo anvo_beo)
public function integer ClearLog ()
public function integer closelogwindow ()
private function long FindBCM (readonly n_cst_bcm anvo_bcm)
private function long FindBEO (readonly n_cst_beo anvo_beo)
public function long GetBCMData (ref string as_data)
public function long GetBEOData (ref string as_data)
public function integer logcreate (readonly nonvisualobject anvo_object)
public function integer logdestroy (readonly nonvisualobject anvo_object)
public function integer openlogwindow ()
public function integer of_openlogwindow ()
public function integer of_closelogwindow ()
end prototypes

private function integer AddBCM (readonly n_cst_bcm anvo_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddBCM
//
//	Arguments:		n_cst_bcm	-	anvo_bcm
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	logs the creation of the BCM.
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


Int li_retval
Long ll_idx

//	See if the BCM has already been added
ll_idx = FindBCM(anvo_bcm)
if ll_idx > 0 then
	MessageBox(This.ClassName() + " addbcm", "BCM create has already been added to log: " + ClassName(anvo_bcm))
	li_retval = -1
else
	ll_idx = ids_bcm.InsertRow(0)
	invo_bcm[ll_idx] = anvo_bcm
	ids_bcm.SetItem(ll_idx, "index", ll_idx)
	ids_bcm.SetItem(ll_idx, "status", "CREATED")
	ids_bcm.SetItem(ll_idx, "classname", anvo_bcm.GetBEOClass())
//	ids_bcm.SetItem(ll_idx, "", )

end if

return li_retval

end function

private function integer addbeo (readonly n_cst_beo anvo_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddBEO
//
//	Arguments:		n_cst_beo	-	anvo_beo
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Logs the creation of a BEO.
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
Int li_retval
Long ll_idx, ll_bcm_idx
String ls_err_text
n_cst_bcm lnv_bcm


//	See if the BEO has already been added
ll_idx = FindBEO(anvo_beo)
if ll_idx > 0 then
	MessageBox(This.ClassName() + " addbeo", "BEO create has already been added to log: " + ClassName(anvo_beo))
	li_retval = -1
else
	lnv_bcm = anvo_beo.GetBCM()
	ll_bcm_idx = FindBCM(lnv_bcm)
	ll_idx = ids_beo.InsertRow(0)
	invo_beo[ll_idx] = anvo_beo
	ids_beo.SetItem(ll_idx, "index", ll_idx)
	ids_beo.SetItem(ll_idx, "status", "CREATED")
	ids_beo.SetItem(ll_idx, "beoindex", anvo_beo.GetBEOIndex())
	ids_beo.SetItem(ll_idx, "class", anvo_beo.ClassName())
//	ids_beo.SetItem(ll_idx, "err_nbr", anvo_beo.GetError(ls_err_text))
//	ids_beo.SetItem(ll_idx, "err_text", ls_err_text)
	ids_beo.SetItem(ll_idx, "bcm_index", ll_bcm_idx)

end if

return li_retval

end function

public function integer ClearLog ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ClearLog
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears out the log for a BCM and a BEO.
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


if IsValid(ids_bcm) then
	ids_bcm.Reset()
	ids_beo.Reset()
	return 1
else
	return -1
end if

end function

public function integer closelogwindow ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		of_CloseLogWindow
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Closes the log display window.
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
return close(w_beolog)



end function

private function long FindBCM (readonly n_cst_bcm anvo_bcm);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		FindBCM
//
//	Arguments:		n_cst_bcm	-	anvo_bcm
//
//	returns:			Long	-	index of the BCM
//
//	Description:	Finds the index for the specified BCM.
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


Long ll_idx

for ll_idx = 1 to ids_bcm.RowCount()
	if invo_bcm[ll_idx] = anvo_bcm then
		return ll_idx
	end if
next

return 0

end function

private function long FindBEO (readonly n_cst_beo anvo_beo);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		FindBEO
//
//	Arguments:		n_cst_beo	-	anvo_beo
//
//	returns:			Long	-	index of the BEO
//
//	Description:	Finds the index of the specified BEO.
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


Long ll_idx

for ll_idx = 1 to ids_beo.RowCount()
	if invo_beo[ll_idx] = anvo_beo then
		return ll_idx
	end if
next

return 0

end function

public function long GetBCMData (ref string as_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBCMData
//
//	Arguments:		as_data
//
//	returns:			Long	-	number of rows of data
//
//	Description:	Gets all the data from a BCM.
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


Long ll_rows

ll_rows = ids_bcm.RowCount()
if ll_rows > 0 then
	as_data = ids_bcm.Object.DataWindow.data
end if

return ll_rows

end function

public function long GetBEOData (ref string as_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetBEOData
//
//	Arguments:		String	-	as_data
//
//	returns:			Long	-	number of rows of data
//
//	Description:	Gets the data for a particular business object and returns
//						it as a string.
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


Long ll_rows

ll_rows = ids_beo.RowCount()
if ll_rows > 0 then
	as_data = ids_beo.Object.DataWindow.data
end if

return ll_rows

end function

public function integer logcreate (readonly nonvisualobject anvo_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LogCreate
//
//	Arguments:		nonvisualobject	-	anvo_object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Creates a log based on the type of object being created.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1   Fix BTR #8376.  Removed hard coded prefixes for bcm and beo.  This change
// 		requires the instance variable for classnames in the bcmmgr to be correct.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
String ls_classname, ls_bcm_prefix, ls_beo_prefix

ls_beo_prefix = this.GetBCMMGR().GetBEOPrefix()
ls_bcm_prefix = this.GetBCMMGR().GetBCMClassname()
ls_classname = ClassName(anvo_object)

if Left(Lower(ls_classname), Len(ls_beo_prefix)) = Lower(ls_beo_prefix) then
	AddBEO(anvo_object)
elseif Left(Lower(ls_classname), Len(ls_bcm_prefix)) = Lower(ls_bcm_prefix) then
	AddBCM(anvo_object)
else
	MessageBox(This.ClassName() + " logcreate()", "Invalid class: " + ls_classname)
end if

return 1

end function

public function integer logdestroy (readonly nonvisualobject anvo_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LogDestroy
//
//	Arguments:		nonvisualobject	-	anvo_object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Logs the destruction of an object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1   Fix for BTR #8376.  BEO/BCM classnames are no longer hard coded.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String ls_classname, ls_bcm_prefix, ls_beo_prefix
Long ll_idx
Int li_retval

ls_beo_prefix = this.GetBCMMGR().GetBEOPrefix()
ls_bcm_prefix = this.GetBCMMGR().GetBCMClassname()
ls_classname = ClassName(anvo_object)

if Left(Lower(ls_classname), Len(ls_beo_prefix)) = Lower(ls_beo_prefix) then
	ll_idx = FindBEO(anvo_object)
	if ll_idx = 0 then
		li_retval = -1
	else
		ids_beo.SetItem(ll_idx, "status", "DESTROYED")
		li_retval = 1
	end if
elseif Left(Lower(ls_classname), Len(ls_bcm_prefix)) = Lower(ls_bcm_prefix) then
	ll_idx = FindBCM(anvo_object)
	if ll_idx = 0 then
		li_retval = -1
	else
		ids_bcm.SetItem(ll_idx, "status", "DESTROYED")
		li_retval = 1
	end if
else
	MessageBox(This.ClassName() + " logdestroy()", "Invalid class: " + ls_classname)
end if

return li_retval

end function

public function integer openlogwindow ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		OpenLogWindow
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Opens the display window for the log service.
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
return Open(w_beolog)

end function

public function integer of_openlogwindow ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		of_OpenLogWindow
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Opens the display window for the log service.
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
return this.OpenLogWindow()


end function

public function integer of_closelogwindow ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		of_CloseLogWindow
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Closes the log display window.
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
return this.CloseLogWindow()


end function

on ofr_n_cst_beolog.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_beolog.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Constructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Creates datastores to hold any logged objects - BEOs and BCMs.
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
ids_bcm = Create DataStore
ids_beo = Create DataStore

ids_bcm.DataObject = "d_log_bcm"
ids_beo.DataObject = "d_log_beo"

end event

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Destructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Close the display window.
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
CloseLogWindow()
destroy ids_bcm
destroy ids_beo

end event

