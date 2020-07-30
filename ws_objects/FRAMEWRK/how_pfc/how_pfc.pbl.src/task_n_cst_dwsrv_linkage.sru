$PBExportHeader$task_n_cst_dwsrv_linkage.sru
$PBExportComments$ancestor to n_cst_dwsrv_linkage, inherits from pfc_n_cst_dwsrv_linkage:  intercepts required events for master detail relationships in DBF
forward
global type task_n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
end type
end forward

global type task_n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
end type
global task_n_cst_dwsrv_linkage task_n_cst_dwsrv_linkage

type variables
// These can to set to cause the linkage service to 
// trigger an event on an object when a retrieve is needed.
protected:
powerobject ipo_object
string is_eventname
n_cst_parameters inv_parameters

end variables

forward prototypes
protected function integer of_retrievedetails (long al_row)
public subroutine setevent (powerobject po_object, string as_event)
public subroutine of_setevent (powerobject po_object, string as_event)
public subroutine setcallback (n_cst_parameters anv_parameters)
end prototypes

protected function integer of_retrievedetails (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RetrieveDetails
//
//	Arguments:		Long	-	al_row
//
//	returns:			Integer	- number of rows retrieved
//						-1		error
//
//	Description:	Intercepts retrieval for business object services.
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
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean lb_doretrieve = true

// Trigger a custom event when the retrieve needs to be done.
// For BO links.
if isValid(inv_parameters) then
	// Determine whether or not the Linkage Service is planning to do the retrieve.
	if UpperBound ( inv_linkargs.is_mastercolarg ) > 0 then
		lb_doretrieve = false
	end if
	inv_parameters.LinkCallback(idw_requestor, lb_doretrieve) 
end if

if isValid(ipo_object) then
	ipo_object.TriggerEvent(is_eventname)
end if

return super::of_retrievedetails(al_row)

end function

public subroutine setevent (powerobject po_object, string as_event);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetEvent
//
//	Arguments:		Powerobject	-	po_object
//						String		-	as_event
//
//	returns:			None
//
//	Description:	Stores an object and its event name.  These will be fired when
//						pfc_retrievedetails fires.
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
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


ipo_object = po_object
is_eventname = as_event
end subroutine

public subroutine of_setevent (powerobject po_object, string as_event);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.SetEvent(po_object, as_event)

end subroutine

public subroutine setcallback (n_cst_parameters anv_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetCallback
//
//	Arguments:		anv_parameters - Parameter class in charge of performing this link.
//
//	returns:			None
//
//	Description:	Indicates that the parameter class will handle performing this link.
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
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

inv_parameters = anv_parameters


end subroutine

on task_n_cst_dwsrv_linkage.create
TriggerEvent( this, "constructor" )
end on

on task_n_cst_dwsrv_linkage.destroy
TriggerEvent( this, "destructor" )
end on

