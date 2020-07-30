$PBExportHeader$ofr_w_master.srw
forward
global type ofr_w_master from pfc_w_master
end type
end forward

global type ofr_w_master from pfc_w_master
event type integer task_setinputparameters ( n_cst_navigation an_navigation )
event type integer task_navigate ( string as_navigationname )
event type integer task_getinputparameters ( )
event type integer task_setoutputparameters ( )
event type integer task_receivenavigation ( n_cst_navigation an_navigation )
event type integer task_getoutputparameters ( n_cst_navigation an_navigation )
end type
global ofr_w_master ofr_w_master

type variables
public:
n_cst_navigation inv_navigation
n_cst_parameters inv_parameters
n_cst_winsrv_linkages inv_linkage
n_cst_txsrv inv_txsrv

end variables

forward prototypes
public function integer setlinkage (boolean as_flag)
public function integer settransactionmanagement (boolean as_flag)
end prototypes

event task_navigate;call super::task_navigate;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Task_Navigate
//
//	Arguments:		String - 		as_navigationname
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	This event is fired when a user tries to navigate within the
//						application.
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

n_cst_navigation lnv_navigation 
n_cst_taskmanager lnv_taskmanager

// if there is an instance level navigation object, then get the task manager from
// that, otherwise, get the application level task manager
if isValid(inv_navigation) then
	lnv_taskmanager = inv_navigation.GetTaskManager()
else
	lnv_taskmanager = gnv_app.inv_taskmanager
end if

if NOT isValid(lnv_taskmanager) then return 0

// if the actual navigation name was not provided, then give the user a list to choose
// from (modal dialog)
if as_navigationname = "" then
	as_navigationname = lnv_taskmanager.ListNavigationsForWindow(this)
end if

// at this point, we have the navigation name, have to determine what parameters are
// required and initialize the object
lnv_navigation = lnv_taskmanager.InitNavigation(this, as_navigationname, inv_parameters)

// if a valid navigation object was created, then set the input parameters
if isValid(lnv_navigation) then
	this.Event task_SetInputParameters(lnv_navigation) 
	lnv_navigation.Navigate()
else
	return 0
end if

return 1
end event

event task_getinputparameters;call super::task_getinputparameters;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			task_GetInputParameters
//
//	Arguments:		none
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Get any input parameters that have been specified for this window.
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


if isValid(inv_linkage) then
	inv_linkage.LinkFromWindow()
end if

return 1

end event

event task_setoutputparameters;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			task_SetOutputParameters
//
//	Arguments:		none
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Set any outgoing values that need to be populated.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 1.3 	Added proper return value if linkage service is not turned on.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if isValid(inv_linkage) then
	return inv_linkage.LinkToWindow()
else
	return 1
end if


end event

event task_receivenavigation;call super::task_receivenavigation;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			task_ReceiveNavigation
//
//	Arguments:		n_cst_navigation	-	an_navigation
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Capture any incoming navigations to this window in order to 
//						get the new parameters specified.
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
if isValid(an_navigation) then
	inv_navigation = an_navigation
	inv_navigation.ResetParameters(inv_parameters)
	this.Event task_GetInputParameters()
end if

return 1
end event

event task_getoutputparameters;call super::task_getoutputparameters;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			task_GetOuputParameters
//
//	Arguments:		n_cst_navigation	-	an_navigation
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Map any output parameters that need to be set for this window.
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
if isValid(an_navigation) then
	an_navigation.inv_parameters.PerformMap("Out")
end if

return 1
end event

public function integer setlinkage (boolean as_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLinkage
//
//	Arguments:		Boolean	-	as_flag
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Turns the window linkage service from OFR on/off
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


if as_flag = TRUE then
	inv_linkage = create n_cst_winsrv_linkages 
	inv_linkage.SetWindow(this)
	inv_linkage.SetParameters(inv_parameters)
else
	if isValid(inv_linkage) then
		destroy inv_linkage
	end if
end if

return 1
end function

public function integer settransactionmanagement (boolean as_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetTransactionManagement
//
//	Arguments:		Boolean	-	as_flag
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Turns OFR transaction management services on/off
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


if as_flag = TRUE then
	if not IsValid(inv_txsrv) then
		inv_txsrv = create n_cst_txsrv
	end if
	inv_txsrv.SetPresentationObject(this)
else
	if isValid(inv_txsrv) then
		destroy inv_txsrv
	end if
end if

return 1
end function

on ofr_w_master.create
call pfc_w_master::create
end on

on ofr_w_master.destroy
call pfc_w_master::destroy
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Open
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	In OFR, a navigation object may be fed into this window with
//						necessary parameters.  Capture this object if available.
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


if isValid(message.powerobjectparm) then
	if ClassName(message.powerobjectparm) = "n_cst_navigation" then
		inv_navigation = message.powerobjectparm
		inv_parameters = inv_navigation.inv_parameters
		inv_parameters.SetObject(this)
		this.Event Post task_GetInputParameters()
		return
	end if
end if

inv_parameters = create n_cst_parameters
inv_parameters.SetObject(this)
end event

event close;call super::close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Close
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Make sure all services are destroyed and perform cleanup.
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
SetLinkage(FALSE)
SetTransactionManagement(FALSE)

if isValid(inv_navigation) then
	inv_navigation.WindowClosing(this)
else
	destroy inv_parameters
end if

end event

event pfc_update;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			pfc_Update
//
//	Arguments:		powerobject	-	apo_control[]
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Capture any updating if using the ofr transaction service.
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
if isValid(inv_txsrv) then
	return inv_txsrv.Save()
else
	Return super::event pfc_update(apo_control)
end if

end event

event pfc_updatespending;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			pfc_UpdatesPending
//
//	Arguments:		powerobject	-	apo_control[]
//
//	returns:			integer
//						1		Success
//						-1		Error
//
//	Description:	Checks for updates using the ofr transaction service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.2   Initial version
// 1.3 	PFC6.0 requires that something is in the ipo_pendingupdates array 
// 		for an update to be valid.  Some cases, a BCM or DS needs to be saved,
//		 	but no DWs do.  Therefore, just stick the Txn Service in the array as a dummy object.

//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
int li_rc

li_rc = super::event pfc_updatespending(apo_control)

if isValid(inv_txsrv) then
	li_rc = inv_txsrv.UpdatesPending()
	if li_rc = 1 and UpperBound(ipo_pendingupdates) = 0 then
		// 1.3 - PFC6.0 requires that something is in this array 
		// for an update to be valid.  Some cases, a BCM or DS needs to be saved,
		// but no DWs do.  Therefore, just stick the Txn Service in the array as a dummy object.
		ipo_pendingupdates[1] = inv_txsrv
	end if
end if

//SVH - Updatespending can also return 2 or 3 depending upon deletes or modifications
if li_rc > 1 then
	li_rc = 1
END IF

return li_rc

end event

event pfc_dberror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			pfc_DBError
//
//	Arguments:		none
//
//	returns:			none
//
//	Description:	Ignore dberror if transaction service turned on because
//						the service will handle the error.
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
if not isValid(inv_txsrv) then
   super::event pfc_dberror()
end if

end event

