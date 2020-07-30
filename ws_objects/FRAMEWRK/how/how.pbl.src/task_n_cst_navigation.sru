$PBExportHeader$task_n_cst_navigation.sru
$PBExportComments$Object to handle navigation from one place to another.
forward
global type task_n_cst_navigation from nonvisualobject
end type
end forward

shared variables

end variables

global type task_n_cst_navigation from nonvisualobject
end type
global task_n_cst_navigation task_n_cst_navigation

type variables
n_cst_parameters inv_parameters

protected:
any ia_param_values[]
string ib_param_names[]
int ii_param_count
Boolean ib_exit

string is_navigationname
string is_destination_window
window iw_source_window
n_cst_parameters inv_sourceparameters
window iw_destination_window
windowtype iwt_window_type = Main!

// Override this variable in the extension layer if you want
// sheets opened differently.
arrangeOpen iao_sheetopenstyle = Layered!

n_cst_taskmanager inv_taskmanager
integer ii_navkey
n_cst_taskmanager inv_subtaskmanager


end variables

forward prototypes
public subroutine setsourcewindow (window source_window_v)
protected function boolean iswindowopen ()
public subroutine setdestinationwindow (string as_window, windowtype awt_window_type)
public subroutine setname (string as_name)
public function string getname ()
public function n_cst_taskmanager gettaskmanager ()
public function integer navigate ()
protected function integer opensheet ()
public subroutine setsubtask (task_n_cst_taskmanager anv_subtask)
public subroutine settaskmanager (n_cst_taskmanager an_taskmanager, integer ai_navkey)
public subroutine setsourceparameters (n_cst_parameters an_parameters)
public subroutine destroyself ()
public function boolean ismodal ()
public subroutine setisexit ()
public function integer resetparameters (n_cst_parameters anv_parameters)
public function integer destinationclosing ()
public function integer windowclosing (window aw_window)
public function integer getkey ()
public subroutine reactivatesource ()
public subroutine setsheetarrange (arrangeopen ao_type)
public function boolean isNavigationValid ()
public function boolean of_isNavigationValid ()
protected function boolean of_iswindowopen ()
public function string of_getname ()
public function n_cst_taskmanager of_gettaskmanager ()
public function integer of_navigate ()
protected function integer of_opensheet ()
public subroutine of_setsheetarrange (arrangeopen ao_type)
end prototypes

public subroutine setsourcewindow (window source_window_v);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSourceWindow
//
//	Arguments:		window - source_window_v - pointer to source window
//
//	returns:			None
//
//	Description:	Store a pointer to the source window.
//						FOR INTERNAL USE ONLY.
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


iw_source_window = source_window_v
end subroutine

protected function boolean iswindowopen ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsWindowOpen
//
//	Arguments:		none
//
//	returns:			Boolean
//
//	Description:	Determines if the destination window is already open.
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


window lw_sheet, lw_frame

lw_frame = inv_taskmanager.GetFrame()

// Get all sheets of classname
lw_sheet = lw_frame.GetFirstSheet ()
if IsValid (lw_sheet) then
	do
		if ClassName (lw_sheet) = is_destination_window then
			iw_destination_window = lw_sheet
			return TRUE
		end if
		lw_sheet = lw_frame.GetNextSheet (lw_sheet)
	loop until not IsValid (lw_sheet)
end if

return FALSE
end function

public subroutine setdestinationwindow (string as_window, windowtype awt_window_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDestinationWindow
//
//	Arguments:		String - 	as_window
//						Windowtype - awt_window_type
//
//	returns:			None
//
//	Description:	store information about the destination window.
//						FOR INTERNAL USE ONLY.
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


// store the window name and type
is_destination_window = as_window
iwt_window_type = awt_window_type

if NOT isValid(iw_destination_window) then
   if iwt_window_type = Main! then
		// if there should only be one instance of this window open then locate it
		if inv_taskmanager.GetReuseOpenWindowsByIndex(ii_navkey) then
			isWindowOpen()
	   end if
	end if
end if

// Create an NVO to hold parameters.
inv_parameters = create n_cst_parameters

end subroutine

public subroutine setname (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetName
//
//	Arguments:		String - as_name - name of navigation
//
//	returns:			None
//
//	Description:	Store the name of the navigation
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//						FOR INTERNAL USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


is_navigationname = as_name
end subroutine

public function string getname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetName
//
//	Arguments:		none
//
//	returns:			String - navigation name
//
//	Description:	Return the name of the navigation
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


return is_navigationname
end function

public function n_cst_taskmanager gettaskmanager ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetTaskManager
//
//	Arguments:		none
//
//	returns:			n_cst_taskmanager
//						
//
//	Description:	Return the pointer to the task manager object.
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


return inv_taskmanager
end function

public function integer navigate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Navigate
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Performs the navigation from one place to another.  All input
//						parameters have been set by this point.
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

integer li_rc

// find the mapped parameters for this task
inv_parameters.SetTaskParameters(inv_taskmanager.GetParameters())
inv_taskmanager.LoadTaskParameters(ii_navkey, inv_parameters)

// if the source parameters are provided, then map them appropriately
if isValid(inv_sourceparameters) then
	inv_parameters.SetSourceParameters(inv_sourceparameters)
	inv_parameters.PerformMap("In")
end if

// determine if the source window is supposed to be closed, and if it is, then close it
if inv_taskmanager.GetCloseSourceByIndex(ii_navkey) = TRUE &
		and isValid(iw_source_window) &
		and iw_source_window <> inv_taskmanager.GetFrame() then
	Close(iw_source_window)
end if

// if this is an exit point, the exit the task
if ib_exit then
	return inv_taskmanager.ExitTask()
end if

// if this is a subtask, then initialize from the parent
if isValid(inv_subtaskmanager) then
	return inv_subtaskmanager.InitTaskFromNavigation(this)
end if

if isValid(iw_destination_window) then
	// if window is already open, then Reactivate it
	if inv_taskmanager.GetActivateTargetByIndex(ii_navkey) then
		iw_destination_window.SetFocus()
	end if
	// Trigger event on destination window to pass values
	iw_destination_window.Event Dynamic task_ReceiveNavigation(this)
	return 1
else
	Choose Case iwt_window_type
	Case Main!
		// Open new sheet
		openSheet()
	Case Child!, Popup!
		if isValid(iw_source_window) then
			OpenWithParm(iw_destination_window, this, is_destination_window, iw_source_window)
		else
			OpenWithParm(iw_destination_window, this, is_destination_window, inv_taskmanager.GetFrame())
		end if
	Case Else
		// Response!
		OpenWithParm(iw_destination_window, this, is_destination_window)
	End Choose
end if

return 1

end function

protected function integer opensheet ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		opensheet
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Opens the destination window and passes parameters required.
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



return OpenSheetWithParm(iw_destination_window, this, is_destination_window, inv_taskmanager.GetFrame(), 0, iao_sheetopenstyle)


end function

public subroutine setsubtask (task_n_cst_taskmanager anv_subtask);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSubTask
//
//	Arguments:		n_cst_taskmanager - anv_subtask - pointer to the subtask manager object
//
//	returns:			None
//
//	Description:	Store pointer to the subtask manager and get the parameters for it.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//						FOR INTERNAL USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////



// Use the parameters of the subtask.
inv_parameters = anv_subtask.GetParameters()

inv_subtaskmanager = anv_subtask
end subroutine

public subroutine settaskmanager (n_cst_taskmanager an_taskmanager, integer ai_navkey);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetTaskManager
//
//	Arguments:		n_cst_taskmanager - an_taskmanager
//						Integer - ai_navkey
//
//	returns:			None
//
//	Description:	Store the pointer to the task manager and the key for this 
//						navigation for later use.
//						FOR INTERNAL USE ONLY.
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


inv_taskmanager = an_taskmanager
ii_navkey = ai_navkey
end subroutine

public subroutine setsourceparameters (n_cst_parameters an_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSourceParameters
//
//	Arguments:		n_cst_parameters - an_parameters - the source window's parameter object
//
//	returns:			None
//
//	Description:	Stores a pointer to the source windows parameter object
//						FOR INTERNAL USE ONLY.
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


inv_sourceparameters = an_parameters
end subroutine

public subroutine destroyself ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestroySelf
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	The destination window was not valid for some reason, so close the
//						navigation completely.
//						FOR INTERNAL USE ONLY.
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


if isValid(inv_taskmanager) then
   inv_taskmanager.DestroyNavigation(ii_navkey)
end if
end subroutine

public function boolean ismodal ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsModal
//
//	Arguments:		none
//
//	returns:			Boolean
//
//	Description:	Determines if the current window is modal.
//						FOR INTERNAL USE ONLY.
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


if iwt_window_type = Response! then
	return TRUE
else
	return FALSE
end if
end function

public subroutine setisexit ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetIsExit
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Sets the boolean if this is the exit point.
//						FOR INTERNAL USE ONLY.
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


ib_exit = TRUE
inv_parameters = inv_taskmanager.GetParameters()
inv_parameters.RemoveMaps("In")

end subroutine

public function integer resetparameters (n_cst_parameters anv_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ResetParameters
//
//	Arguments:		n_cst_parameters - anv_parameters
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Stores the parameters for this navigation into the passed parameter
//						object.
//						FOR INTERNAL USE ONLY.
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



anv_parameters.RemoveMaps("In")
anv_parameters.RemoveMaps("Out")
inv_parameters.CopyParameters(anv_parameters)

destroy inv_parameters

inv_parameters = anv_parameters

return 1
end function

public function integer destinationclosing ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestinationClosing
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Some error has occurred, so the destination window will be closed.
//						FOR INTERNAL USE ONLY.
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



if NOT isValid(iw_source_window) then
	this.Function Post DestroySelf()
else
	if inv_parameters.HasOutputParameters() = FALSE then
		this.Function Post DestroySelf()
	else
	   if iw_source_window.Event Dynamic task_GetOutputParameters(this) <> 2 then
			this.Function Post DestroySelf()
		end if
	end if
end if

return 1

end function

public function integer windowclosing (window aw_window);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		WindowClosing
//
//	Arguments:		window - aw_window - pointer to window to be closed
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Make sure any cleanup is done for a closing window.
//						FOR INTERNAL USE ONLY.
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



if aw_window = iw_source_window then 
	// Destroy self?
elseif aw_window = iw_destination_window then
   return this.DestinationClosing()
end if

return 1

end function

public function integer getkey ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		getKey
//
//	Arguments:		none
//
//	returns:			Integer - key for this navigation 
//
//	Description:	REturn the navigation key
//						FOR INTERNAL USE ONLY.
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


return ii_navkey
end function

public subroutine reactivatesource ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ReactivateSource
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Reactivates the source window if it is valid.
//						FOR INTERNAL USE ONLY.
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


if isvalid(iw_source_window) then
	iw_source_window.SetFocus()
end if

end subroutine

public subroutine setsheetarrange (arrangeopen ao_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSheetArrange
//
//	Arguments:		arrangeopen - ao_type
//
//	returns:			None
//
//	Description:	Store the default for how sheets will be opened.
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


iao_sheetopenstyle = ao_type
end subroutine

public function boolean isNavigationValid ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		IsNavigationValid
//
//	Arguments:		none
//
//	returns:			Boolean
//
//	Description:	If there is no source, no destination and no subtask, then this
//						navigation is not valid anymore.
//						FOR INTERNAL USE ONLY.
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


if isValid(iw_destination_window) then
	return TRUE
elseif isValid(iw_source_window) then
	return TRUE
elseif isValid(inv_subtaskmanager) then 
	return TRUE
end if
 
return FALSE
end function

public function boolean of_isNavigationValid ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.IsNavigationValid()

end function

protected function boolean of_iswindowopen ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.IsWindowOpen()

end function

public function string of_getname ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.GetName()

end function

public function n_cst_taskmanager of_gettaskmanager ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.GetTaskManager()

end function

public function integer of_navigate ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.Navigate()

end function

protected function integer of_opensheet ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.OpenSheet()

end function

public subroutine of_setsheetarrange (arrangeopen ao_type);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.SetSheetArrange(ao_type)

end subroutine

on task_n_cst_navigation.create
TriggerEvent( this, "constructor" )
end on

on task_n_cst_navigation.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;// If the destination did not destroy its parameters (because it had to return
// output values) destroy them now.
if NOT isValid(inv_subtaskmanager) and NOT isValid(iw_destination_window) and NOT ib_exit then
	if isValid(inv_parameters) then
		destroy inv_parameters
	end if
end if

end event

