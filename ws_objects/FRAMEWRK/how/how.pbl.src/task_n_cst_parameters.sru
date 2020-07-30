$PBExportHeader$task_n_cst_parameters.sru
$PBExportComments$Stores parameters to be passed from a source to a destination and the maps associated with them.
forward
global type task_n_cst_parameters from nonvisualobject
end type
end forward

global type task_n_cst_parameters from nonvisualobject
end type
global task_n_cst_parameters task_n_cst_parameters

type variables
protected:
any ia_param_values[]
string is_paramnames[]
string is_paramtypes[]
string is_parammodes[]
Boolean  ib_paramset[]
Boolean ib_isattribute[]
int ii_param_count

Boolean ib_paramsdefined

ofr_s_parameters_map map[]
int ii_count
int ii_current_map

task_n_cst_parameters inv_sourceparameters
task_n_cst_parameters inv_taskparameters
powerobject ipo_object

any ia_temp

end variables

forward prototypes
public function boolean getparametervalue (string as_name, ref any aa_value)
public function integer setparametervalue (string as_name, any aa_value)
public function boolean allparametersset (string as_names[])
public subroutine resetparameters ()
public subroutine addparameter (string as_name, string as_type, string as_mode)
public subroutine addparameter (string as_name, string as_type, string as_mode, any aa_default)
public subroutine setsourcecontrol (datawindow adw_datawindow)
public subroutine setdestinationcontrol (datawindow adw_datawindow)
public subroutine newmap (string as_mode)
public subroutine setmapitem (string as_sourcename, string as_sourcetype, string as_destinationname, string as_destinationtype)
public subroutine mapsource (string as_name, string as_mode)
public subroutine mapsource (datawindow adw_datawindow, string as_name)
public subroutine mapdestination (string as_param, string as_type)
public subroutine mapdestination (datawindow adw_datawindow, string as_arg)
public function any getparametervalue (string as_name)
public subroutine setmapexpression ()
public function boolean of_getparametervalue (string as_name, ref any aa_value)
public function integer of_setparametervalue (string as_name, any aa_value)
public function boolean of_allparametersset (string as_names[])
public subroutine of_resetparameters ()
public subroutine of_addparameter (string as_name, string as_type, string as_mode)
public subroutine of_addparameter (string as_name, string as_type, string as_mode, any aa_default)
public subroutine of_setsourcecontrol (datawindow adw_datawindow)
public subroutine of_setdestinationcontrol (datawindow adw_datawindow)
public subroutine of_newmap (string as_mode)
public subroutine of_setmapitem (string as_sourcename, string as_sourcetype, string as_destinationname, string as_destinationtype)
public subroutine of_mapsource (string as_name, string as_mode)
public subroutine of_mapsource (datawindow adw_datawindow, string as_name)
public subroutine of_mapdestination (string as_param, string as_type)
public subroutine of_mapdestination (datawindow adw_datawindow, string as_arg)
public function any of_getparametervalue (string as_name)
public subroutine of_setmapexpression ()
protected function integer getparameterindex (string as_name)
public function integer retrievedatawindow (datawindow adw_datawindow)
public function boolean hasoutputparameters ()
public function any getdatawindowvalue (datawindow adw, string as_name)
public subroutine removemaps (string as_mode)
protected function boolean mapvalue (task_n_cst_parameters anv_sourceparameters, integer ai_mapindex)
public function integer copyparameters (task_n_cst_parameters anv_parameters)
public subroutine setsourceparameters (task_n_cst_parameters as_parameters)
public function integer performmap (string as_mode)
public subroutine settaskparameters (task_n_cst_parameters as_parameters)
public subroutine of_setsourceparameters (task_n_cst_parameters as_parameters)
public function integer of_performmap (string as_mode)
public subroutine of_settaskparameters (task_n_cst_parameters as_parameters)
protected function boolean setmapvalue (nonvisualobject anv_sourceparameters, ref ofr_s_parameters_map astr_map, any aa_value)
public subroutine newmap (ofr_s_parameters_map astr_map)
protected subroutine addparameter (string as_name, string as_type, string as_mode, any aa_default, boolean ab_isattribute)
public subroutine addattribute (string as_name, string as_type, string as_mode, any aa_value)
public subroutine addattribute (string as_name, string as_type, string as_mode)
public subroutine setobject (powerobject apo_object)
public function boolean getparametervalue2 (string as_name, ref any aa_value)
public function integer linkcallback (datawindow adw_datawindow, boolean ab_doretrieve)
end prototypes

public function boolean getparametervalue (string as_name, ref any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetParameterValue
//
//	Arguments:		String - as_name	- name of the parameter
//						Any - 	aa_value - any datatype to store the value
//
//	returns:			Boolean - TRUE for success, FALSE for failure
//
//	Description:	Get the value of the parameter and return.
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


int i

// loop through the parameters, find the appropriate param name and get the value
for i = 1 to ii_param_count
	if is_paramnames[i] = as_name then
		if ib_isattribute[i] = true and isvalid(ipo_object) then
			aa_value = ipo_object.function dynamic gettaskattribute(as_name)
			if isnull(aa_value) then
				return false
			else
				return true
			end if
		else
			if ib_paramset[i] = TRUE then
				aa_value = ia_param_values[i]
			else
				SetNull(aa_value)
			end if
		end if
		return ib_paramset[i]
	end if
next

return FALSE
	
end function

public function integer setparametervalue (string as_name, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetParameterValue
//
//	Arguments:		String - as_name	- name of the parameter
//						Any - 	aa_value - actual value
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Store the parameter and value into an array for later use.
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


int i

// store the value for the parameter into the parameter array
if ib_paramsdefined = TRUE then
	for i = 1 to ii_param_count
		if is_paramnames[i] = as_name then
			if ib_isattribute[i] = true and isvalid(ipo_object)  then
				ia_temp = aa_value
				if ipo_object.function dynamic settaskattribute(as_name, this) = 1 then
					return 1
				else
					return -1
				end if
			else
				ia_param_values[i] = aa_value
				if isNull(aa_value) then
					ib_paramset[i] = FALSE
				else 
					ib_paramset[i] = TRUE
				end if
				return 1
			end if
		end if
	next
else
	ii_param_count++
	is_paramnames[ii_param_count] = as_name
	ia_param_values[ii_param_count] = aa_value
	ib_isattribute[ii_param_count] = FALSE
	if isNull(aa_value) then
		ib_paramset[ii_param_count] = FALSE
	else 
		ib_paramset[ii_param_count] = TRUE
	end if
	return 1
end if

return -1
end function

public function boolean allparametersset (string as_names[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AllParametersSet
//
//	Arguments:		Stringarray - as_names[]
//
//	returns:			Boolean
//
//	Description:	Determine if the parameters in the array have values set.
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


any temp
int i, u

u = UpperBound(as_names[])

// determine if the value has been set for each parameter named
for i = 1 to u
	if getparametervalue(as_names[i], temp) = FALSE then
		return FALSE
	end if
next

return TRUE

end function

public subroutine resetparameters ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		ResetParameters
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Resets all the parameters
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


int i

for i = 1 to ii_param_count
	ib_paramset[i] = FALSE
next 


end subroutine

public subroutine addparameter (string as_name, string as_type, string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddParameter
//
//	Arguments:		String - as_name	- name of the parameter
//						String - as_type	- type of the parameter
//						String - as_mode	- mode (in, out)
//
//	returns:			None
//
//	Description:	Creates an entry for a parameter.
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


any null_any

AddParameter(as_name, as_type, as_mode, null_any)

end subroutine

public subroutine addparameter (string as_name, string as_type, string as_mode, any aa_default);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddParameter
//
//	Arguments:		String - as_name - parameter name
//						String - as_type - type of the parameter
//						String - as_mode - mode of param (in, out)
//						Any - aa_default - default value
//
//	returns:			None
//
//	Description:	CReates an entry for a parameter.
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

this.AddParameter(as_name,as_type,as_mode,aa_default,false)
end subroutine

public subroutine setsourcecontrol (datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSourceControl
//
//	Arguments:		Datawindow - adw_datawindow
//
//	returns:			None
//
//	Description:	Stores a pointer to the source datawindow control
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


map[ii_count].sourcecontrol = adw_datawindow
ii_current_map = ii_count
end subroutine

public subroutine setdestinationcontrol (datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetDestinationControl
//
//	Arguments:		Datawindow - adw_datawindow - pointer to datawindow control
//
//	returns:			None
//
//	Description:	Stores pointer to the destination datawindow control
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


map[ii_count].destinationcontrol = adw_datawindow
ii_current_map = ii_count
end subroutine

public subroutine newmap (string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		NewMap
//
//	Arguments:		String - as_mode		- mode of the parameter
//
//	returns:			None
//
//	Description:	Adds a new entry to the parameter map with the correct mode.
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


ii_count++
ii_current_map = ii_count
map[ii_count].mode = as_mode
end subroutine

public subroutine setmapitem (string as_sourcename, string as_sourcetype, string as_destinationname, string as_destinationtype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetMapItem
//
//	Arguments:		String - as_sourcename
//						String - as_sourcetype
//						String - as_destinationname
//						String - as_destinationtype
//
//	returns:			None
//
//	Description:	Sets the map information specified
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


if ii_current_map > 0 then
	if map[ii_count].sourcename > "" then
		ii_count++
	  	map[ii_count].mode = map[ii_current_map].mode
      map[ii_count].destinationcontrol = map[ii_current_map].destinationcontrol
      map[ii_count].sourcecontrol = map[ii_current_map].sourcecontrol
	end if
end if

map[ii_count].sourcename = as_sourcename
map[ii_count].sourcetype = as_sourcetype
map[ii_count].destinationname = as_destinationname
map[ii_count].destinationtype = as_destinationtype


end subroutine

public subroutine mapsource (string as_name, string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapSource
//
//	Arguments:		String - as_name - name of the source parameter
//						String - as_mode - parameter mode
//
//	returns:			None
//
//	Description:	stores parameter information for the source.
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


map[ii_count].sourcename = as_name
map[ii_count].sourcetype = as_mode

end subroutine

public subroutine mapsource (datawindow adw_datawindow, string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapSource
//
//	Arguments:		Datawindow - adw_datawindow - source datawindow
//						String - 	as_name - name of source parameter
//
//	returns:			None
//
//	Description:	Store source information
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


map[ii_count].sourcename = as_name
map[ii_count].sourcecontrol = adw_datawindow
end subroutine

public subroutine mapdestination (string as_param, string as_type);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapDestination
//
//	Arguments:		String - as_param - name of destination parameter
//						String - as_type - mode of parameter
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Clears error message text and number
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


map[ii_count].destinationname = as_param
map[ii_count].destinationtype = as_type

end subroutine

public subroutine mapdestination (datawindow adw_datawindow, string as_arg);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapDestination
//
//	Arguments:		Datawindow - adw_datawindow - datawindow control destination
//						String - 	as_arg - name of destination parameter
//
//	returns:			None
//
//	Description:	Store destination information.
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


map[ii_count].destinationname = as_arg
map[ii_count].destinationcontrol = adw_datawindow

end subroutine

public function any getparametervalue (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetParameterValue
//
//	Arguments:		String - as_name
//
//	returns:			Any - the actual value
//
//	Description:	Get the parameter value or return null.
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


any a_value
int r, nint, i
decimal ndec
time ntime
date ndate
datetime ndatetime
string nstring
Boolean nbool

// if you can't find the value, then must return a null value
if GetParameterValue(as_name, a_value) = FALSE then
	for i = 1 to ii_param_count
		if is_paramnames[i] = as_name then
			r = i
			exit 
		end if
	next 
	
	if r > 0 then
		Choose Case is_paramtypes[r] 
			Case "String" 
				a_value = SetNull(nstring)
			Case "Decimal"
				a_value = SetNull(ndec)
			Case "Date"
				a_value = SetNull(ndate)
			Case "Time"
				a_value = SetNull(ntime)
			Case "DateTime"
				a_value = SetNull(ndatetime)
			Case "Boolean"
				a_value = SetNull(nbool)
			Case "Integer"
				a_value = SetNull(nint)
			Case "Long"
				a_value = SetNull(nint)
			Case "ULong"
				a_value = SetNull(nint)
		End Choose
	end if
end if

return a_value


end function

public subroutine setmapexpression ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetMapExpression
//
//	Arguments:		none
//
//	returns:			None
//
//	Description:	Stores the current map information into the array.
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


if ii_current_map > 0 then
	if map[ii_count].sourcename > "" then
		ii_count++
	  	map[ii_count].mode = map[ii_current_map].mode
      map[ii_count].destinationcontrol = map[ii_current_map].destinationcontrol
      map[ii_count].sourcecontrol = map[ii_current_map].sourcecontrol
	end if
end if

map[ii_count].isExpression = TRUE
end subroutine

public function boolean of_getparametervalue (string as_name, ref any aa_value);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.getparametervalue(as_name, aa_value)

end function

public function integer of_setparametervalue (string as_name, any aa_value);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.setparametervalue(as_name, aa_value)

end function

public function boolean of_allparametersset (string as_names[]);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.allparametersset(as_names[])

end function

public subroutine of_resetparameters ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.resetparameters()

end subroutine

public subroutine of_addparameter (string as_name, string as_type, string as_mode);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.addparameter (as_name, as_type, as_mode)

end subroutine

public subroutine of_addparameter (string as_name, string as_type, string as_mode, any aa_default);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.addparameter (as_name,  as_type,  as_mode,  aa_default)

end subroutine

public subroutine of_setsourcecontrol (datawindow adw_datawindow);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setsourcecontrol ( adw_datawindow)

end subroutine

public subroutine of_setdestinationcontrol (datawindow adw_datawindow);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setdestinationcontrol ( adw_datawindow)

end subroutine

public subroutine of_newmap (string as_mode);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.newmap ( as_mode)

end subroutine

public subroutine of_setmapitem (string as_sourcename, string as_sourcetype, string as_destinationname, string as_destinationtype);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setmapitem(as_sourcename, as_sourcetype, as_destinationname, as_destinationtype)

end subroutine

public subroutine of_mapsource (string as_name, string as_mode);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.mapsource ( as_name,  as_mode)

end subroutine

public subroutine of_mapsource (datawindow adw_datawindow, string as_name);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.mapsource ( adw_datawindow, as_name)

end subroutine

public subroutine of_mapdestination (string as_param, string as_type);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.mapdestination ( as_param, as_type)

end subroutine

public subroutine of_mapdestination (datawindow adw_datawindow, string as_arg);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.mapdestination ( adw_datawindow,  as_arg)

end subroutine

public function any of_getparametervalue (string as_name);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.getparametervalue(as_name)

end function

public subroutine of_setmapexpression ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setmapexpression()

end subroutine

protected function integer getparameterindex (string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetParameterIndex
//
//	Arguments:		String - as_name - name of parameter to be located
//
//	returns:			Integer - index for the parameter
//
//	Description:	Find the location of the parameter in the array and return the index
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


int i

for i = 1 to ii_param_count
	if as_name = is_paramnames[i] then
		return i
	end if
next

return 0
end function

public function integer retrievedatawindow (datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RetrieveDatawindow
//
//	Arguments:		Datawindow - adw_datawindow
//
//	returns:			Integer - number of rows retrieved
//
//	Description:	Retrieve the datawindow after all parameters have been set
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


return adw_datawindow.retrieve()
end function

public function boolean hasoutputparameters ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		HasOutputParameters
//
//	Arguments:		none
//
//	returns:			boolean
//
//	Description:	Determines if any of these parameters are of mode Out.
//						FOR INTERNAL USE ONLY.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 2.1   Any attributes can be used as output parameters.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


int i

if ii_param_count > UpperBound(is_parammodes) THEN
	Return FALSE
end if

//for i = 1 to ii_param_count
//	if is_parammodes[i] = "Out" then
//		return TRUE
//	end if
//	if ib_isattribute[i] = true then
//		return true
//	end if
//next

return true
end function

public function any getdatawindowvalue (datawindow adw, string as_name);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetDatawindowValue
//
//	Arguments:		Datawindow - adw - datawindow pointer

//						String - as_name - name of the column
//
//	returns:			Any - the actual value
//
//	Description:	Get a value out of a datawindow
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


any a_value
int r, nint
decimal ndec
time ntime
date ndate
datetime ndatetime
string nstring


r = adw.GetRow()

// determine the datatype of the column provided
Choose Case Lower(Left(adw.Describe(as_name + ".ColType"), 5))
Case "char("
	if r = 0 then
		setnull(nstring)
		return nstring
	else
		a_value = adw.GetItemString(r, as_name)
	end if
Case "decim"
	if r = 0 then
		setnull(ndec)
		return ndec
	else
		a_value = adw.GetItemDecimal(r, as_name)
	end if
Case "date"
	if r = 0 then
		setnull(ndate)
		return ndate
	else
		a_value = adw.GetItemDate(r, as_name)
	end if
Case "datet"
	if r = 0 then
		setnull(ndatetime)
		return ndatetime
	else
	   a_value = adw.GetItemDateTime(r, as_name)
	end if
Case "time"
	if r = 0 then
		setnull(ntime)
		return ntime
	else
		a_value = adw.GetItemTime(r, as_name)
	end if
Case Else
	if r = 0 then
		setnull(nint)
		return nint
	else
		a_value = adw.GetItemNumber(r, as_name)
	end if
END Choose

// return the value as an any datatype
return a_value

end function

public subroutine removemaps (string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RemoveMaps
//
//	Arguments:		String - as_mode
//
//	returns:			None
//
//	Description:	Clear out all the maps for that mode 
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
int i = 1
ofr_s_parameters_map lmap
do while i <= ii_count
	if map[i].mode = as_mode then
		map[i] = map[ii_count]
		map[ii_count] = lmap
		ii_count = ii_count - 1
	end if
	i++
loop



end subroutine

protected function boolean mapvalue (task_n_cst_parameters anv_sourceparameters, integer ai_mapindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		MapValue
//
//	Arguments:		n_cst_parameters - anv_sourceparameters - pointer to source params
//						integer - 			ai_mapindex
//
//	returns:			Boolean - TRUE for mapped, FALSE for not mapped
//
//	Description:	Maps individual values for a mapped item
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


any a_value
n_cst_uilink_dw lnv_uilink

if map[ai_mapindex].isExpression = TRUE then
	return TRUE
end if

if Trim(map[ai_mapindex].sourcename) = "" or Trim(map[ai_mapindex].destinationname) = "" then 
	return FALSE
end if


// if passing value from one datacontrol to another, then get the datawindow value
if IsValid(map[ai_mapindex].sourcecontrol) then
	if map[ai_mapindex].sourcetype = "Column" then
		a_value = GetDataWindowValue(map[ai_mapindex].sourcecontrol, map[ai_mapindex].sourcename)
		if isNull(a_value) then
			return FALSE
		end if
	else
		if map[ai_mapindex].sourcecontrol.TriggerEvent("ofr_getuilink") = 1 then
			lnv_uilink = map[ai_mapindex].sourcecontrol.Dynamic Event ofr_getuilink()
		end if
		if not isvalid(lnv_uilink) then
			return false
		end if
		a_value = lnv_uilink.GetBEO(map[ai_mapindex].sourcecontrol.GetRow(), map[ai_mapindex].sourcename)
		if not isvalid(a_value) then 
			return false
		end if
	end if
	
else
	// get the parameter value if dealing with a task
	if map[ai_mapindex].sourcetype = "Task" then
		if inv_taskparameters.GetParameterValue(map[ai_mapindex].sourcename, a_value) = FALSE then
			return FALSE
		end if
	else
		if anv_sourceparameters.GetParameterValue(map[ai_mapindex].sourcename, a_value) = FALSE then
			return FALSE
		end if
	end if
	if map[ai_mapindex].sourcetype = "BEO" then
		if not isvalid(a_Value) then
			return FALSE
		end if
	end if
end if

return SetMapValue(anv_sourceparameters, map[ai_mapindex], a_value)

		


end function

public function integer copyparameters (task_n_cst_parameters anv_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CopyParameters
//
//	Arguments:		n_cst_parameters - anv_parameters
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Copies the parameters of this object into the one supplied as
//						an argument.
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


int i

for i = 1 to ii_count
	anv_parameters.NewMap(map[i])
next

for i = 1 to ii_param_count
	anv_parameters.SetParameterValue(is_paramnames[i], ia_param_values[i])
next 

return 1
end function

public subroutine setsourceparameters (task_n_cst_parameters as_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetSourceParameters
//
//	Arguments:		n_cst_parameters - as_parameters - pointer to the source parameters
//
//	returns:			None
//
//	Description:	Store the pointer to the source parameters.
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


inv_sourceparameters = as_parameters
end subroutine

public function integer performmap (string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		PerformMap
//
//	Arguments:		String - as_mode - mode of parameters to be mapped
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	
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

boolean lb_isparameter[]
int i, j, count = 0
Boolean return_code, all_set[]
task_n_cst_parameters lnv_parameters
datawindow dw[]

// when dealing with "In" mode, there should be a source providing parameters
if as_mode = "In" then
	lnv_parameters = inv_sourceparameters
else
	lnv_parameters = this
end if

// map the parameters with the appropriate mode
for i = 1 to ii_count
	if map[i].mode = as_mode and map[i].sourcename <> "" and map[i].destinationname <> "" then
		return_code = MapValue(lnv_parameters, i) 
		
		if isValid(map[i].destinationcontrol) then
			for j = 1 to count
				if dw[j] = map[i].destinationcontrol then
					exit
				end if
			next
			if j > count then
				count++
				j = count
				dw[j] = map[i].destinationcontrol
				if map[i].destinationtype = "Parameter" then
					lb_isparameter[j] = true
				else
					lb_isparameter[j] = false
				end if
				all_set[j] = TRUE
			end if
			
			if all_set[j] = TRUE then
				all_set[j] = return_code
			end if
		end if
	end if
next

// retrieve any datawindows after parameters have been set
for j = 1 to count
	if all_set[j] then			
		if lb_isparameter[j] then
			dw[j].TriggerEvent("task_retrieve")
		else
			RetrieveDataWindow(dw[j])
		end if
	end if
next

return 1

end function

public subroutine settaskparameters (task_n_cst_parameters as_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetTaskParameters
//
//	Arguments:		n_cst_parameters - as_parameters - pointer to the source's parameters
//
//	returns:			None
//
//	Description:	Stores a pointer to the sources parameter object
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


inv_taskparameters = as_parameters
end subroutine

public subroutine of_setsourceparameters (task_n_cst_parameters as_parameters)
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.setsourceparameters(as_parameters)

end subroutine

public function integer of_performmap (string as_mode)
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.performmap(as_mode)

end function

public subroutine of_settaskparameters (task_n_cst_parameters as_parameters)
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.settaskparameters(as_parameters)

end subroutine

protected function boolean setmapvalue (nonvisualobject anv_sourceparameters, ref ofr_s_parameters_map astr_map, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetMapValue
//
//	Arguments:		n_cst_parameters - anv_sourceparameters - source parameter object
//						map - 				astr_map - 					structure of maps
//						any - 				aa_value - 					value for the parameter
//
//	returns:			Boolean
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
task_n_cst_parameters lnv_sourceparameters
datawindow dw

lnv_sourceparameters = anv_sourceparameters
// as long as the destination control of this parameter is valid, then set the value
if IsValid(astr_map.destinationcontrol) then
	if astr_map.destinationtype = "Parameter" then
		ia_temp = aa_value

		astr_map.destinationcontrol.Function Dynamic SetTaskAttribute(astr_map.destinationname, this)
	else
		dw = astr_map.destinationcontrol
		dw.Function Dynamic SetKeyValue(Integer(astr_map.destinationname), aa_value)
	end if
else
	if astr_map.mode = "Out" then
		if inv_sourceparameters.SetParameterValue(astr_map.destinationname, aa_value) = 0 then
			return FALSE
		end if
	else
		if SetParameterValue(astr_map.destinationname, aa_value) = 0 then
			return FALSE
		end if
	end if
end if

return TRUE

end function

public subroutine newmap (ofr_s_parameters_map astr_map);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		NewMap
//
//	Arguments:		map - astr_map - structure with map information
//
//	returns:			None
//
//	Description:	Store new map information in the map array
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
ii_count++
map[ii_count] = astr_map
end subroutine

protected subroutine addparameter (string as_name, string as_type, string as_mode, any aa_default, boolean ab_isattribute);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddParameter
//
//	Arguments:		String - as_name - parameter name
//						String - as_type - type of the parameter
//						String - as_mode - mode of param (in, out)
//						Any - aa_default - default value
//						Boolean - ab_isattribute - Is this parameter really a variable.
//
//	returns:			None
//
//	Description:	CReates an entry for a parameter.
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


int i, p

ib_paramsdefined = TRUE

// see if the parameter has already been stored
for i = 1 to ii_param_count
	if as_name = is_paramnames[i] then
		p = i 
		exit
	end if
next

if p = 0 then
	ii_param_count++
	p = ii_param_count
	ib_paramset[p] = FALSE
end if

// set the parameter name, type and mode
is_paramnames[p] = as_name
is_paramtypes[p] = as_type
is_parammodes[p] = as_mode
ib_isattribute[p] = ab_isattribute

// if the default value is not null, then store it.
if not isNull(aa_default) and classname(aa_default) <> "any" then
	if ib_paramset[p] = FALSE then
		ia_param_values[p] = aa_default
		ib_paramset[p] = TRUE
	end if
end if

if isvalid(ipo_object) then
	// Initialize variables on the window with the values in this object.
	if ib_isattribute[p] = true then
		if ib_paramset[p] = TRUE then
			ia_temp = ia_param_values[p]
			ipo_object.function dynamic settaskattribute(is_paramnames[p], this)
		end if
	end if
end if



end subroutine

public subroutine addattribute (string as_name, string as_type, string as_mode, any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddAttribute
//
//	Arguments:		as_name - Parameter name
//						as_type - Datatype
//						as_mode - In or Out
//						aa_value - Default
//
//	returns:			none
//
//	Description:	Defines that an attribute is being used as a parameter.
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
AddParameter(as_name,as_type,as_mode,aa_value,TRUE)
end subroutine

public subroutine addattribute (string as_name, string as_type, string as_mode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		AddAttribute
//
//	Arguments:		as_name - Parameter name
//						as_type - Datatype
//						as_mode - In or Out
//
//	returns:			none
//
//	Description:	Defines that an attribute is being used as a parameter.
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

any la_null

this.AddAttribute(as_name,as_type,as_mode,la_null)
end subroutine

public subroutine setobject (powerobject apo_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetObject
//
//	Arguments:		apo_object - Window, control, or task manager.
//
//	returns:			none
//
//	Description:	Defines the object which these parameters are associated with.
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
int i

ipo_object = apo_object



end subroutine

public function boolean getparametervalue2 (string as_name, ref any aa_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		GetParameterValue
//
//	Arguments:		String - as_name	- name of the parameter
//						Any - 	aa_value - any datatype to store the value
//
//	returns:			Boolean - TRUE for success, FALSE for failure
//
//	Description:	Get the value of the parameter and return.
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

aa_value = ia_temp
return true	
end function

public function integer linkcallback (datawindow adw_datawindow, boolean ab_doretrieve);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LinkCallback
//
//	Arguments:		ai_linkindex - Index into the map struct for this link.
//
//	returns:			integer
//
//	Description:	Called from task_n_cst_dwsrv_linkage when a retrieve link
//						needs to be performed that the standard linkage service can't
//						handle.
//						FOR INTERNAL USE ONLY.
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
int i

for i = 1 to ii_count
	if isValid(map[i].destinationcontrol) then
		if map[i].mode = "Control" then
			if map[i].destinationcontrol = adw_datawindow then
				if MapValue(this, i) <> true then
					return -1
				end if
			end if
		end if
	end if
next

if ab_doretrieve then
	adw_datawindow.Triggerevent("task_retrieve")
end if

return 1


end function

on task_n_cst_parameters.create
TriggerEvent( this, "constructor" )
end on

on task_n_cst_parameters.destroy
TriggerEvent( this, "destructor" )
end on

