$PBExportHeader$task_n_cst_winsrv_linkages.sru
$PBExportComments$Window level service that tracks input, output and control-to-control links.
forward
global type task_n_cst_winsrv_linkages from nonvisualobject
end type
end forward

global type task_n_cst_winsrv_linkages from nonvisualobject
end type
global task_n_cst_winsrv_linkages task_n_cst_winsrv_linkages

type variables
Boolean ib_controllink
Boolean ib_filterlink
Boolean ib_scrolllink


datawindow idw_currentsource
datawindow idw_currentdestination

window iw_window 
n_cst_parameters inv_parameters


end variables

forward prototypes
public function integer setlinkitem (string as_sourcename, string as_destinationname)
public subroutine setwindow (window aw_window)
public subroutine setparameters (n_cst_parameters anv_parameters)
public function integer linkfromwindow ()
public function integer linktowindow ()
public subroutine createcontrollinkitem (string as_sourcename, string as_destname)
public subroutine createcontrollink (datawindow adw_source, datawindow adw_destination)
public subroutine createinputlink (datawindow adw_datawindow)
public subroutine createoutputlink (datawindow adw_datawindow)
public function integer setlinkitem (string as_sourcename, string as_argnum, string as_destinationname)
public function integer setlinkexpression ()
public function integer retrieve (datawindow adw_datawindow)
public subroutine of_createcontrollink (datawindow adw_source, datawindow adw_destination)
public subroutine of_createinputlink (datawindow adw_datawindow)
public subroutine of_createoutputlink (datawindow adw_datawindow)
public function integer of_setlinkitem (string as_sourcename, string as_argnum, string as_destinationname)
public function integer of_setlinkexpression ()
public function integer of_retrieve (datawindow adw_datawindow)
public function integer of_setlinkitem (string as_sourcename, string as_destinationname)
public function integer of_setBEOlinkitem (string as_sourcename, string as_destinationname)
public function integer setattributelinkitem (string as_sourcename, string as_destinationname)
public subroutine createcontrolattributelinkitem (string as_sourcename, string as_destname)
public subroutine createfilterlink (datawindow adw_source, datawindow adw_destination)
public subroutine createscrolllink (datawindow adw_source, datawindow adw_destination)
end prototypes

public function integer setlinkitem (string as_sourcename, string as_destinationname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLinkItem
//
//	Arguments:		String	-	as_sourcename
//						String	-	as_destinationname
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overloaded function - use for all types of links.  Maps the
//						source parameter name to the destination parameter name.
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



if ib_controllink then
	CreateControlLinkItem(as_sourcename, as_destinationname)
elseif isValid(idw_currentdestination) then
	inv_parameters.setmapitem (as_sourcename, "Parameter", as_destinationname, "Argument")
else
	inv_parameters.setmapitem (as_sourcename, "Column", as_destinationname, "Parameter")
end if

return 1
end function

public subroutine setwindow (window aw_window);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetWindow
//
//	Arguments:		Window	-	aw_window
//
//	returns:			None
//
//	Description:	Stores a pointer to the window it will be servicing.
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


iw_window = aw_window

end subroutine

public subroutine setparameters (n_cst_parameters anv_parameters);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetParameters
//
//	Arguments:		n_cst_parameters	-	anv_parameters
//
//	returns:			None
//
//	Description:	Stores a pointer to the parameter object
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


inv_parameters = anv_parameters
end subroutine

public function integer linkfromwindow ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LinkFromWindow
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Establishes an input link between windows.
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


inv_parameters.PerformMap("InLink")

return 1
end function

public function integer linktowindow ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		LinkToWindow
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Establishes an output link between windows.
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


inv_parameters.PerformMap("OutLink")

return 1
end function

public subroutine createcontrollinkitem (string as_sourcename, string as_destname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateControlLinkItem
//
//	Arguments:		String	-	as_sourcename
//						String	-	as_destname
//
//	returns:			None
//
//	Description:	Specifies the names of the items that will be linked.  This 
//						function is overridden in the descendant.
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



end subroutine

public subroutine createcontrollink (datawindow adw_source, datawindow adw_destination);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateControlLink
//
//	Arguments:		Datawindow	-	adw_destination
//						Datawindow	-	adw_destination
//
//	returns:			None
//
//	Description:	Sets a link between two datawindow controls.
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


idw_currentsource = adw_source
idw_currentdestination = adw_destination

ib_controllink = TRUE
inv_parameters.NewMap("Control")
inv_parameters.SetSourceControl(adw_source)
inv_parameters.SetDestinationControl(adw_destination)



end subroutine

public subroutine createinputlink (datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateInputLink
//
//	Arguments:		Datawindow	-	adw_datawindow
//
//	returns:			None
//
//	Description:	Sets a link between an input parameter and a datawindow control.
//						This information will be fed into the parent window through a
//						navigation.
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


idw_currentdestination = adw_datawindow
SetNull(idw_currentsource)

ib_controllink = FALSE
inv_parameters.NewMap("InLink")
inv_parameters.SetDestinationControl(adw_datawindow)
end subroutine

public subroutine createoutputlink (datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateOutputLink
//
//	Arguments:		Datawindow	-	adw_datawindow
//
//	returns:			None
//
//	Description:	Creates an output link from a datawindow control.  This information
//						will be sent back to the calling window as an output parameter.
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


idw_currentsource = adw_datawindow
SetNull(idw_currentdestination)

ib_controllink = FALSE
inv_parameters.newmap("OutLink")
inv_parameters.SetSourceControl(adw_datawindow)
end subroutine

public function integer setlinkitem (string as_sourcename, string as_argnum, string as_destinationname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLinkItem
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overloaded function - call this when using control-to-control links.
//						Establishes the names of the fields for the link between two 
//						datawindow controls.
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


// Call this version when setting up a control-to-control link
if ib_controllink then
	CreateControlLinkItem(as_sourcename, as_destinationname)
end if

return 1
end function

public function integer setlinkexpression ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLinkExpression
//
//	Arguments:		none
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Stores the map expression within the parameter object.
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


if isValid(idw_currentdestination) then
	inv_parameters.setmapexpression ()
else
	inv_parameters.setmapexpression ()
end if

return 1
end function

public function integer retrieve (datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		Retrieve
//
//	Arguments:		Datawindow	-	adw_datawindow
//
//	returns:			Integer	-	 number of rows retrieved for the datawindow
//						-1		error
//
//	Description:	Retrieve the datawindow using the parameter object (where all
//						the arguments are stored)
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


return inv_parameters.RetrieveDataWindow(adw_datawindow)
end function

public subroutine of_createcontrollink (datawindow adw_source, datawindow adw_destination);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.CreateControlLink(adw_source, adw_destination)

end subroutine

public subroutine of_createinputlink (datawindow adw_datawindow);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

this.CreateInputLink(adw_datawindow)

end subroutine

public subroutine of_createoutputlink (datawindow adw_datawindow);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////
this.CreateOutputLink(adw_datawindow)

end subroutine

public function integer of_setlinkitem (string as_sourcename, string as_argnum, string as_destinationname);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.SetLinkItem(as_sourcename, as_argnum, as_destinationname)

end function

public function integer of_setlinkexpression ();
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.SetLinkExpression()
end function

public function integer of_retrieve (datawindow adw_datawindow);
////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.Retrieve(adw_datawindow)
end function

public function integer of_setlinkitem (string as_sourcename, string as_destinationname);////////////////////////////////////////////////////////////////////////////////////////////////////
// Compatibility function only.  
//
// This function has been provided for backwards compatibility with pre-1.2 applications.  
//
// This function WILL BE REMOVED in a future release.  Please replace all calls 
// to this function with calls to the new function called below.
////////////////////////////////////////////////////////////////////////////////////////////////////

return this.SetLinkItem(as_sourcename, as_destinationname)
end function

public function integer of_setBEOlinkitem (string as_sourcename, string as_destinationname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetLinkItem
//
//	Arguments:		String	-	as_sourcename
//						String	-	as_destinationname
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overloaded function - use for all types of links.  Maps the
//						source parameter name to the destination parameter name.
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



if ib_controllink then
	CreateControlLinkItem(as_sourcename, as_destinationname)
elseif isValid(idw_currentdestination) then
	inv_parameters.setmapitem (as_sourcename, "Parameter", as_destinationname, "Argument")
else
	inv_parameters.setmapitem (as_sourcename, "Column", as_destinationname, "Parameter")
end if

return 1
end function

public function integer setattributelinkitem (string as_sourcename, string as_destinationname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetAttributeLinkItem
//
//	Arguments:		String	-	as_sourcename, name of BEO
//						String	-	as_destinationname
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Overloaded function - use for all types of links.  Maps the
//						source parameter name to the destination parameter name.
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

if ib_controllink then
	inv_parameters.setmapitem (as_sourcename, "BEO", as_destinationname, "Parameter")
	CreateControlAttributeLinkItem(as_sourcename, as_destinationname)
else
	inv_parameters.setmapitem (as_sourcename, "BEO", as_destinationname, "Parameter")
end if

return 1
end function

public subroutine createcontrolattributelinkitem (string as_sourcename, string as_destname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateControlAttributeLinkItem
//
//	Arguments:		String	-	as_sourcename, name of BEO
//						String	-	as_destname, name of parameter
//
//	returns:			None
//
//	Description:	Specifies the names of the items that will be linked.  This 
//						function is overridden in the descendant.
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



end subroutine

public subroutine createfilterlink (datawindow adw_source, datawindow adw_destination);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateFilterLink
//
//	Arguments:		Datawindow	-	adw_destination
//						Datawindow	-	adw_destination
//
//	returns:			None
//
//	Description:	Sets a filter link between two datawindow controls.
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


idw_currentsource = adw_source
idw_currentdestination = adw_destination

ib_controllink = TRUE
ib_filterlink = true
end subroutine

public subroutine createscrolllink (datawindow adw_source, datawindow adw_destination);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateScrollLink
//
//	Arguments:		Datawindow	-	adw_destination
//						Datawindow	-	adw_destination
//
//	returns:			None
//
//	Description:	Sets a filter link between two datawindow controls.
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


idw_currentsource = adw_source
idw_currentdestination = adw_destination

ib_controllink = TRUE
ib_scrolllink = true

end subroutine

on task_n_cst_winsrv_linkages.create
TriggerEvent( this, "constructor" )
end on

on task_n_cst_winsrv_linkages.destroy
TriggerEvent( this, "destructor" )
end on

