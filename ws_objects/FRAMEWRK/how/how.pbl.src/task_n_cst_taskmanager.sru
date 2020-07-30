$PBExportHeader$task_n_cst_taskmanager.sru
$PBExportComments$Manages all navigations for a task
forward
global type task_n_cst_taskmanager from nonvisualobject
end type
end forward

global type task_n_cst_taskmanager from nonvisualobject
end type
global task_n_cst_taskmanager task_n_cst_taskmanager

type variables

protected:
task_n_cst_taskmanager inv_subtaskmanager[]
task_n_cst_taskmanager inv_parenttask
task_n_cst_navigation inv_startnavigation

integer ii_activenavs
task_n_cst_navigation inv_navigations[]
task_n_cst_parameters inv_parameters
integer ii_navindex[]

ofr_s_taskmanager_navigation istr_navigation[]
integer ii_navigationcount

window iw_frame


end variables

forward prototypes
public function integer begintask ()
public function boolean getparametervalue (string as_name, ref any aa_value)
public function integer exittask ()
public function string listnavigationsforwindow (window aw_window)
public function task_n_cst_navigation initnavigation (window aw_window, string as_navigationname, task_n_cst_parameters anv_parameters)
public subroutine setsourcename (integer ai_index, string as_name)
public subroutine setframe (window aw_frame)
protected subroutine setdestinationname (integer ai_index, string as_name)
protected subroutine setnavigationname (integer ai_index, string as_name)
protected subroutine setclosesource (integer ai_index, boolean as_closesource)
protected subroutine setactivatetarget (integer ai_index, boolean ab_activatetarget)
protected subroutine setreuseopenwindows (integer ai_index, boolean ab_reuse)
protected subroutine setparametermap (integer ai_index, string as_map, string as_param)
protected subroutine setisentry (integer ai_index)
protected subroutine setissubtaskmodal (integer ai_index, boolean ab_flag)
protected subroutine setwindowtype (integer ai_index, windowtype awt_windowtype)
protected subroutine setdestinationsubtask (integer ai_index, string as_name)
protected subroutine setsourcesubtask (integer ai_index, string as_name)
protected subroutine setisexit (integer ai_index)
public function integer of_begintask ()
public function boolean of_getparametervalue (string as_name, ref any aa_value)
public function integer of_exittask ()
public function string of_listnavigationsforwindow (window aw_window)
public function task_n_cst_navigation of_initnavigation (window aw_window, string as_navigationname, task_n_cst_parameters anv_parameters)
public subroutine of_setsourcename (integer ai_index, string as_name)
public subroutine of_setframe (window aw_frame)
protected subroutine of_setdestinationname (integer ai_index, string as_name)
protected subroutine of_setnavigationname (integer ai_index, string as_name)
protected subroutine of_setclosesource (integer ai_index, boolean as_closesource)
protected subroutine of_setactivatetarget (integer ai_index, boolean ab_activatetarget)
protected subroutine of_setreuseopenwindows (integer ai_index, boolean ab_reuse)
protected subroutine of_setparametermap (integer ai_index, string as_map, string as_param)
protected subroutine of_setisentry (integer ai_index)
protected subroutine of_setissubtaskmodal (integer ai_index, boolean ab_flag)
protected subroutine of_setwindowtype (integer ai_index, windowtype awt_windowtype)
protected subroutine of_setdestinationsubtask (integer ai_index, string as_name)
protected subroutine of_setsourcesubtask (integer ai_index, string as_name)
protected subroutine of_setisexit (integer ai_index)
public subroutine destroynavigation (integer ai_navindex)
public function integer subtaskexit (task_n_cst_taskmanager an_subtask)
public subroutine setparenttask (task_n_cst_taskmanager an_task)
public function integer inittaskfromnavigation (task_n_cst_navigation anv_navigation)
public subroutine setstartnavigation (task_n_cst_navigation an_navigation)
public function string listnavigations (integer ai_count, string as_navs[])
public function integer getnavigations (string as_sourcename, ref string as_navigations[])
public function boolean getsubtaskmodalbyindex (integer ai_index)
public function task_n_cst_navigation getstartnavigation ()
public function window getframe ()
public function integer loadtaskparameters (integer ai_navindex,task_n_cst_parameters anv_parameters)
public function boolean getclosesourcebyindex (integer ai_index)
public function boolean getactivatetargetbyindex (integer ai_index)
public function boolean getreuseopenwindowsbyindex (integer ai_index)
public function task_n_cst_parameters getparameters ()
public function integer of_loadtaskparameters (integer ai_navindex,task_n_cst_parameters anv_parameters)
public function boolean of_getclosesourcebyindex (integer ai_index)
public function boolean of_getactivatetargetbyindex (integer ai_index)
public function boolean of_getreuseopenwindowsbyindex (integer ai_index)
public function task_n_cst_parameters of_getparameters ()
public function window of_getframe ()
public function integer of_inittaskfromnavigation (task_n_cst_navigation anv_navigation)
public function windowtype of_getwintypebyid (integer ai_type)
public function integer of_getidbywintype (windowtype awt_type)
end prototypes

public function integer begintask ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		BeginTask
//
//	Arguments:		none
//
//	returns:			Integer
//						0 		success
//						-1		error
//
//	Description:	At the beginning of a task, start the first navigation, or if
//						there are multiple possibilities, then allow the user to choose
//						from a list.
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


n_cst_navigation ln_navigation
int i, ncount
string navs[], nav

// determine how many navigations are possible for this task
if ii_navigationcount > 0 then
	for i = 1 to ii_navigationcount
		if istr_navigation[i].isEntry then
			ncount++
			navs[ncount] = istr_navigation[i].name
		end if
	next 
end if

if ncount = 0 then return -1

// if there is only one navigation possible then store it, otherwise, provide a list to 
// the user to pick from
if ncount = 1 then
	nav = navs[1]
else
	nav = ListNavigations(ncount, navs)
end if

// if a navigation was selected, then initialize it and perform the navigation
if nav > "" then 
	ln_navigation = InitNavigation(iw_frame, nav, inv_parameters)
	if isValid(ln_navigation) then
		return ln_navigation.Navigate()
	end if
end if

return 0
end function

public function boolean getparametervalue (string as_name, ref any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetParameterValue
//
//	Arguments:		String	-	as_name
//						Any		-	aa_value
//
//	returns:			Boolean - TRUE success, FALSE failure
//
//	Description:	Get the value for the specified parameter.
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


if isValid(inv_parameters) then
	return inv_parameters.getparametervalue(as_name, aa_value)
end if

return FALSE

end function

public function integer exittask ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ExitTask
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Make sure any subtasks are closed for this task.
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



if isValid(inv_parenttask) then
	if inv_parenttask.SubtaskExit(this) = 0 then
		return 0
	end if
end if


return 1
end function

public function string listnavigationsforwindow (window aw_window);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		List NavigationsforWindow
//
//	Arguments:		Window - 		aw_window	- source window
//
//	returns:			String - 		user selected navigation
//
//	Description:	Gets the possible navigations to choose from and provides
//						a dialog to the user for selecting one.
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


string navs[]
int count

// get the navigations for this class of window
count = GetNavigations(aw_window.classname(), navs)

// return the selected navigation
return ListNavigations(count, navs)


end function

public function task_n_cst_navigation initnavigation (window aw_window, string as_navigationname, task_n_cst_parameters anv_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		InitNavigation
//
//	Arguments:		Window - 			aw_window - 			source window
//						String - 			as_navigationname - 	name of navigation (destination)
//						n_cst_parameters - anv_parameters - 	nvo for required parameters 
//
//	returns:			n_cst_navigation - pointer to the navigation object
//
//	Description:	
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

n_cst_navigation lnv_navigation
int i, current_nav, nvoindex, p1, p2, p3, l
string taskparam, destparam
nonvisualobject lnv_this
any anyvar

// loop through the list of navigations in the structure to find the appropriate match
for i = 1 to ii_navigationcount
	if istr_navigation[i].name = as_navigationname then
		current_nav = i
		exit
	end if
next

if current_nav = 0 then return lnv_navigation

// find an empty slot in the array of currently active navigations
for i = 1 to ii_activenavs
	if NOT isValid(inv_navigations[i]) then
		nvoindex = i
		exit
	elseif NOT inv_navigations[i].isNavigationValid() then

		DestroyNavigation(i)
		nvoindex = i
		exit
	end if
next

// if there was no empty slot, then add 1 to the array index
if nvoindex = 0 then
	ii_activenavs++
	nvoindex = ii_activenavs
end if

// create a navigation object and store the pointer in the empty slot
lnv_navigation = create n_cst_navigation
inv_navigations[nvoindex] = lnv_navigation
ii_navindex[nvoindex] = current_nav

// initialize the navigation object's pointers
lnv_this = this
lnv_navigation.SetTaskManager(lnv_this, nvoindex)
lnv_navigation.SetName(as_navigationname)
if isValid(aw_window) then
	lnv_navigation.SetSourceWindow(aw_window)
end if

// if this window has a parameters nvo, then set the pointer on the navigation object
if isValid(anv_parameters) then
	lnv_navigation.SetSourceParameters(anv_parameters)
end if
 
// determine the current type of navigation (exit, subtask or new window)
if istr_navigation[current_nav].isExit then
	lnv_navigation.SetIsExit()
elseif istr_navigation[current_nav].isDestinationSubtask then
	i = UpperBound(inv_subtaskmanager) + 1
	inv_subtaskmanager[i] = create using istr_navigation[current_nav].destinationname
	inv_subtaskmanager[i].SetFrame(iw_frame)
	lnv_navigation.SetSubTask(inv_subtaskmanager[i])
	inv_subtaskmanager[i].SetParentTask(this)
else
	
	//begin modification by appeon 20070727
	//lnv_navigation.SetDestinationWindow(istr_navigation[current_nav].destinationname, istr_navigation[current_nav].windowtype)
	windowtype lwt
	lwt = of_getwintypebyid(istr_navigation[current_nav].windowtype)
	lnv_navigation.SetDestinationWindow(istr_navigation[current_nav].destinationname, lwt)

	//end modification by appeon 20070727
end if

// return the pointer to the navigation object
return lnv_navigation

end function

public subroutine setsourcename (integer ai_index, string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSourceName
//
//	Arguments:		Integer	-	ai_index
//						String	-	as_name
//
//	returns:			None
//
//	Description:	Set the source name for the navigation indicated by the index.
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


istr_navigation[ai_index].sourcename = as_name
end subroutine

public subroutine setframe (window aw_frame);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetFrame
//
//	Arguments:		Window	-	aw_frame
//
//	returns:			None
//
//	Description:	Store a pointer to the MDI frame for this task.
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


iw_frame = aw_frame
end subroutine

protected subroutine setdestinationname (integer ai_index, string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDestinationName
//
//	Arguments:		Integer	-	ai_index
//						String	-	as_name
//
//	returns:			None
//
//	Description:	Set the destination name for the navigation indicated by the
//						provided index.
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


istr_navigation[ai_index].destinationname = as_name
end subroutine

protected subroutine setnavigationname (integer ai_index, string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetNavigationName
//
//	Arguments:		Integer	-	ai_index
//						String	-	as_name
//
//	returns:			None
//
//	Description:	If this navigation has not already been created, then create
//						a new entry and set defaults, otherwise, change the name
//						accordingly.
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


if ii_navigationcount < ai_index then
	ii_navigationcount = ai_index
	// Set defaults
	SetActivateTarget(ai_index, TRUE)
	SetCloseSource(ai_index, FALSE)
	SetReuseOpenWindows(ai_index, FALSE)

end if

istr_navigation[ai_index].name = as_name

end subroutine

protected subroutine setclosesource (integer ai_index, boolean as_closesource);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetCloseSource
//
//	Arguments:		Integer 	-	ai_index
//						Boolean	-	as_closesource
//
//	returns:			None
//
//	Description:	Set the property to close the source window for the navigation
//						based on the index provided.
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


istr_navigation[ai_index].closesource = as_closesource
end subroutine

protected subroutine setactivatetarget (integer ai_index, boolean ab_activatetarget);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetActivateTarget
//
//	Arguments:		Integer	-	ai_index
//						Boolean	-	ab_activatetarget
//
//	returns:			None
//
//	Description:	Set the Activate Target property of the navigation specified by
//						the provided index.
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


istr_navigation[ai_index].activatetarget = ab_activatetarget
end subroutine

protected subroutine setreuseopenwindows (integer ai_index, boolean ab_reuse);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetReuseOpenWindows
//
//	Arguments:		Integer	-	ai_index
//						Boolean	-	ab_reuse
//
//	returns:			None
//
//	Description:	Set the Reuse open window property for the navigation indicated
//						by the provided index.
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


istr_navigation[ai_index].ReuseOpenWindows = ab_reuse
end subroutine

protected subroutine setparametermap (integer ai_index, string as_map, string as_param);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetParameterMap
//
//	Arguments:		Integer	-	ai_index
//						String	-	as_map
//						String	-	as_param
//
//	returns:			None
//
//	Description:	Adds a new map for the navigation specified by the index.
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




istr_navigation[ai_index].mapcount++

istr_navigation[ai_index].parameter[istr_navigation[ai_index].mapcount] = as_param
istr_navigation[ai_index].taskparametermap[istr_navigation[ai_index].mapcount] = as_map




end subroutine

protected subroutine setisentry (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetIsEntry
//
//	Arguments:		Integer	-	ai_index
//
//	returns:			None
//
//	Description:	Make the navigation indicated by the index provided the entry
//						point for this task.
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


istr_navigation[ai_index].isEntry = TRUE
end subroutine

protected subroutine setissubtaskmodal (integer ai_index, boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetIsSubTaskModal
//
//	Arguments:		Integer	-	ai_index	(currently not used)
//						Boolean	-	ab_flag
//
//	returns:			None
//
//	Description:	Sets the subtask modal property of the last navigation in the 
//						array.
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


istr_navigation[ii_navigationcount].issubtaskmodal = ab_flag
end subroutine

protected subroutine setwindowtype (integer ai_index, windowtype awt_windowtype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetWindowType
//
//	Arguments:		Integer		-	ai_index
//						WindowType	-	awt_windowtype
//
//	returns:			None
//
//	Description:	Specify the window type for the destination of this navigation.
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

//begin modifyication by appeon 20070727
//istr_navigation[ai_index].windowtype = awt_windowtype
int lwindowtype
lwindowtype = of_getidbywintype(awt_windowtype)
istr_navigation[ai_index].windowtype = lwindowtype
//end modifyication by appeon 20070727
end subroutine

protected subroutine setdestinationsubtask (integer ai_index, string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDestinationSubtask
//
//	Arguments:		Integer	-	ai_index
//						String	-	as_name
//
//	returns:			None
//
//	Description:	Set the name of the destination subtask for the navigation
//						indicated by the index provided.
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


istr_navigation[ai_index].destinationname = as_name
istr_navigation[ai_index].isdestinationsubtask = TRUE
end subroutine

protected subroutine setsourcesubtask (integer ai_index, string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSourceSubTask
//
//	Arguments:		Integer	-	ai_index
//						String	-	as_name
//
//	returns:			None
//
//	Description:	Specify that a navigation is really a subtask to this task.
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


istr_navigation[ai_index].sourcename = as_name
istr_navigation[ai_index].issourcesubtask = TRUE
istr_navigation[ai_index].issubtaskmodal = TRUE
end subroutine

protected subroutine setisexit (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetIsExit
//
//	Arguments:		Integer	-	ai_index
//
//	returns:			None
//
//	Description:	Set the navigation indicated by the provided index to be the
//						exit point of the task.
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


istr_navigation[ai_index].isExit = TRUE
end subroutine

public function integer of_begintask ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.begintask()

end function

public function boolean of_getparametervalue (string as_name, ref any aa_value);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.getparametervalue ( as_name, aa_value)

end function

public function integer of_exittask ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.exittask()

end function

public function string of_listnavigationsforwindow (window aw_window);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.listnavigationsforwindow(aw_window)

end function

public function task_n_cst_navigation of_initnavigation (window aw_window, string as_navigationname, task_n_cst_parameters anv_parameters);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.initnavigation ( aw_window, as_navigationname, anv_parameters)

end function

public subroutine of_setsourcename (integer ai_index, string as_name);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setsourcename ( ai_index, as_name)

end subroutine

public subroutine of_setframe (window aw_frame);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////




this.setframe ( aw_frame)

end subroutine

protected subroutine of_setdestinationname (integer ai_index, string as_name);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setdestinationname ( ai_index,  as_name)

end subroutine

protected subroutine of_setnavigationname (integer ai_index, string as_name);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setnavigationname ( ai_index,  as_name)

end subroutine

protected subroutine of_setclosesource (integer ai_index, boolean as_closesource);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setclosesource ( ai_index, as_closesource)

end subroutine

protected subroutine of_setactivatetarget (integer ai_index, boolean ab_activatetarget);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setactivatetarget ( ai_index, ab_activatetarget)

end subroutine

protected subroutine of_setreuseopenwindows (integer ai_index, boolean ab_reuse);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setreuseopenwindows(ai_index, ab_reuse)

end subroutine

protected subroutine of_setparametermap (integer ai_index, string as_map, string as_param);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setparametermap ( ai_index, as_map, as_param)

end subroutine

protected subroutine of_setisentry (integer ai_index);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setisentry(ai_index)

end subroutine

protected subroutine of_setissubtaskmodal (integer ai_index, boolean ab_flag);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setissubtaskmodal ( ai_index, ab_flag)

end subroutine

protected subroutine of_setwindowtype (integer ai_index, windowtype awt_windowtype);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setwindowtype ( ai_index, awt_windowtype)

end subroutine

protected subroutine of_setdestinationsubtask (integer ai_index, string as_name);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setdestinationsubtask ( ai_index, as_name)

end subroutine

protected subroutine of_setsourcesubtask (integer ai_index, string as_name);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setsourcesubtask ( ai_index, as_name)

end subroutine

protected subroutine of_setisexit (integer ai_index);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// all calls to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setisexit ( ai_index)

end subroutine

public subroutine destroynavigation (integer ai_navindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		DestroyNavigation
//
//	Arguments:		Integer 	- 	ai_navindex
//
//	returns:			None
//
//	Description:	Remove a particular navigation from the array.
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


if isValid(inv_navigations[ai_navindex]) then
	destroy inv_navigations[ai_navindex]
end if
end subroutine

public function integer subtaskexit (task_n_cst_taskmanager an_subtask);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SubTaskExit
//
//	Arguments:		n_cst_taskmanager 	-	an_subtask
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears error message text and number
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


// The developer can extended this function in the descendant to do something
// with the Subtask's output parameters.

string ls_navs[]
integer li_count
n_cst_navigation ln_navigation

// get a pointer to the first navigation for the subtask
ln_navigation = an_subtask.GetStartNavigation()

if isValid(ln_navigation) then
	// determine if it is a modal subtask, and if it is, then close the destination
	// and reactivate the source window
	if this.GetSubtaskModalByIndex(ln_navigation.GetKey()) = TRUE then
		ln_navigation.DestinationClosing()
		ln_navigation.ReActivateSource()
		destroy an_subtask
	else
		// if it is not modal, then get all of the navigations possible for the subtask
		li_count = GetNavigations(ClassName(an_subtask), ls_navs)

		// loop through all the navigations of the subtask
		if li_count > 0 then
			ln_navigation = InitNavigation(iw_frame, ls_navs[1], an_subtask.GetParameters())
			ln_navigation.Navigate()
		end if
		
		// if the source window is supposed to be closed (end of the subtask) then
		// destroy the subtask entirely because it is now complete
		if this.GetCloseSourceByIndex(ln_navigation.GetKey()) = TRUE then
			destroy an_subtask
		end if
	end if
end if



return 1
end function

public subroutine setparenttask (task_n_cst_taskmanager an_task);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetParentTask
//
//	Arguments:		n_cst_taskmanager - an_task - pointer to parent task 
//
//	returns:			None
//
//	Description:	Store a pointer to the parent task
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


inv_parenttask = an_task
end subroutine

public function integer inittaskfromnavigation (task_n_cst_navigation anv_navigation);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		InitTaskFromNavigation
//
//	Arguments:		n_cst_navigation	-	anv_navigation
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Based on a provided navigation object, initialize this task and
//						begin.
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


inv_startnavigation = anv_navigation
return BeginTask()
end function

public subroutine setstartnavigation (task_n_cst_navigation an_navigation);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetStartNavigation
//
//	Arguments:		n_cst_navigation 	-	an_navigation
//
//	returns:			None
//
//	Description:	Set the start navigation object.
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


inv_startnavigation = an_navigation
end subroutine

public function string listnavigations (integer ai_count, string as_navs[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ListNavigations
//
//	Arguments:		Integer - 		ai_count		- total number of navigations
//						Stringarray - 	as_navs[]	- array of navigations
//
//	returns:			String - name of the selected navigation
//
//	Description:	Provide a dialog to the user so they can select a navigation.
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


string nav_list = ""
int i

//  Create a tab-delimited string of the navigation names to be imported to 
// a datawindow for presenting to the user
for i = 1 to ai_count
	nav_list = nav_list + as_navs[i] + "~r~n"
next 

// open the modal dialog
OpenWithParm(task_w_nav_list, nav_list)

// return the selected navigation
if not isNull(message.stringparm) then
	nav_list = message.stringparm
	SetNull(message.stringparm)
	return nav_list
else
	return ""
end if


end function

public function integer getnavigations (string as_sourcename, ref string as_navigations[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetNavigations
//
//	Arguments:		String - 		as_sourcename	-	name of the window class
//						Stringarray - 	as_navigations[]-	array to be populated with 
//																	possible navigations
//
//	returns:			Integer - total number of navigations for this window class
//						
//	Description:	Populate the string array with all possible navigations for this
//						window class and return the total count.
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


int i, count

// navigations are stored in a user object structure by window source name
// loop through the array of structures to find all possible paths from the
// source window
for i = 1 to ii_navigationcount
	if as_sourcename = istr_navigation[i].sourcename then
		count++
		as_navigations[count] = istr_navigation[i].name
	end if
next

return count
end function

public function boolean getsubtaskmodalbyindex (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetSubtaskModalByIndex
//
//	Arguments:		Integer	-	ai_index
//
//	returns:			Boolean
//
//	Description:	Determine if the subtask is modal based on the index provided.
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


return istr_navigation[ii_navindex[ai_index]].IsSubtaskModal
end function

public function task_n_cst_navigation getstartnavigation ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetStartNavigation
//
//	Arguments:		none
//
//	returns:			n_cst_navigation
//
//	Description:	Return a pointer to the first navigation for this task.
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


return inv_startnavigation
end function

public function window getframe ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetFrame
//
//	Arguments:		none
//
//	returns:			window
//
//	Description:	Return a pointer to the MDI frame for this task
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


return iw_frame
end function

public function integer loadtaskparameters (integer ai_navindex,task_n_cst_parameters anv_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LoadTaskParameters
//
//	Arguments:		integer - 				ai_navindex
//						n_cst_parameters - 	anv_parameters - pointer to the parameter object
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Create entries for the mapped parameters specific to this task.
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


int i, n
any anyvar[32]

// Get the index to the nav definitions
n = ii_navindex[ai_navindex]

// get all the mapped parameters defined for this navigation
for i = 1 to istr_navigation[n].mapcount
	anv_parameters.NewMap("In")
	anv_parameters.SetMapItem(istr_navigation[n].taskparametermap[i], "Parameter", istr_navigation[n].parameter[i], "Parameter")
next

return istr_navigation[n].mapcount
end function

public function boolean getclosesourcebyindex (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetCloseSourceByIndex
//
//	Arguments:		Integer - ai_index
//
//	returns:			Boolean
//
//	Description:	Return if the source window is supposed to be closed or not.
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


return istr_navigation[ii_navindex[ai_index]].closesource
end function

public function boolean getactivatetargetbyindex (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetActivateTargetByIndex
//
//	Arguments:		Integer	-	ai_index
//
//	returns:			Boolean
//
//	Description:	Based on the provided index, determine if the destination will be
//						activated.
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


return istr_navigation[ii_navindex[ai_index]].activatetarget
end function

public function boolean getreuseopenwindowsbyindex (integer ai_index);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetReuseOpenWindowsByIndex
//
//	Arguments:		Integer	-	ai_index
//
//	returns:			Boolean
//
//	Description:	Determine if you are supposed to reuse an open window, or open 
//						a new instance.
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


return istr_navigation[ii_navindex[ai_index]].ReuseOpenWindows
end function

public function task_n_cst_parameters getparameters ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetParameters
//
//	Arguments:		none
//
//	returns:			n_cst_parameters
//
//	Description:	Returns a pointer to the current source's parameters
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


return inv_parameters
end function

public function integer of_loadtaskparameters (integer ai_navindex,task_n_cst_parameters anv_parameters);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.loadtaskparameters(ai_navindex, anv_parameters)

end function

public function boolean of_getclosesourcebyindex (integer ai_index);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.getclosesourcebyindex(ai_index)

end function

public function boolean of_getactivatetargetbyindex (integer ai_index);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.getactivatetargetbyindex(ai_index)

end function

public function boolean of_getreuseopenwindowsbyindex (integer ai_index);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.getreuseopenwindowsbyindex(ai_index)

end function

public function task_n_cst_parameters of_getparameters ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.getparameters()

end function

public function window of_getframe ();////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////


return this.GetFrame()
end function

public function integer of_inittaskfromnavigation (task_n_cst_navigation anv_navigation);return this.InitTaskFromNavigation(anv_navigation)
end function

public function windowtype of_getwintypebyid (integer ai_type); windowtype lwt
 choose case ai_type
	case 1
		lwt = Child!
	case 2	
		lwt = Main!
	
	case 3	
		lwt = MDI!
		
	case 4	
		lwt = MDIHelp!
		
	case 5	
		lwt = Popup!	
	case else
		lwt = Response!
		
end choose

return lwt
end function

public function integer of_getidbywintype (windowtype awt_type); int lwt
 choose case awt_type
	case Child!
		lwt = 1
	case 	Main!
		lwt = 2
	
	case 	MDI!
		lwt = 3
		
	case MDIHelp!
		lwt = 4
		
	case 	Popup!	
		lwt = 5
	case else
		lwt = 6
		
end choose

return lwt
end function

on task_n_cst_taskmanager.create
call super::create
TriggerEvent( this, "constructor" )
end on

on task_n_cst_taskmanager.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Destructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	As the task manager is destroyed, make sure any subtasks are 
//						also removed.
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
int i, u

u = UpperBound(inv_subtaskmanager[])

for i = 1 to u
	destroy inv_subtaskmanager[i]
next

destroy inv_parameters
end event

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:			Constructor
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	As the task manager is created, create a parameter nvo as well.
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
inv_parameters = create n_cst_parameters
inv_parameters.SetObject(this)
end event

