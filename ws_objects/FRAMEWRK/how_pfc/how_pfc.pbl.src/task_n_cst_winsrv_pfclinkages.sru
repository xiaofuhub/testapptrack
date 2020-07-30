$PBExportHeader$task_n_cst_winsrv_pfclinkages.sru
$PBExportComments$Integrates Task links with PFC linkage services.
forward
global type task_n_cst_winsrv_pfclinkages from task_n_cst_winsrv_linkages
end type
end forward

global type task_n_cst_winsrv_pfclinkages from task_n_cst_winsrv_linkages
end type
global task_n_cst_winsrv_pfclinkages task_n_cst_winsrv_pfclinkages

forward prototypes
public subroutine createcontrollink (datawindow adw_source, datawindow adw_destination)
public subroutine createcontrollinkitem (string as_sourcename, string as_destinationname)
public subroutine createcontrolattributelinkitem (string as_sourcename, string as_destinationname)
public subroutine createfilterlink (datawindow adw_source, datawindow adw_destination)
public subroutine createscrolllink (datawindow adw_source, datawindow adw_destination)
protected function boolean verifydw (datawindow adw_datawindow, boolean ab_flag)
end prototypes

public subroutine createcontrollink (datawindow adw_source, datawindow adw_destination);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateControlLink
//
//	Arguments:		Datawindow	-	adw_source
//						Datawindow	-	adw_destination
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Integrates the PFC linkage service with the links set by DBF.
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


u_dw dw1, dw2

super::CreateControlLink(adw_source, adw_destination)

if not VerifyDW(adw_source, true) then
	return
end if

if not VerifyDW(adw_destination, true) then
	return
end if

dw1 = adw_source
dw2 = adw_destination

dw1.of_SetLinkage(TRUE)
dw2.of_SetLinkage(TRUE)
dw2.inv_linkage.of_LinkTo(dw1)
dw2.inv_linkage.of_SetUseColLinks(2)
dw2.inv_linkage.of_ResetArguments()

end subroutine

public subroutine createcontrollinkitem (string as_sourcename, string as_destinationname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateControlLinkItem
//
//	Arguments:		String	-	as_sourcename
//						String	-	as_destinationname
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Integrates the controls links in DBF with the arguments needed
//						by PFC linkage.
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


u_dw dw

if not VerifyDW(idw_currentdestination, false) then
	return
end if

dw = idw_currentdestination
dw.inv_linkage.of_SetArguments( as_sourcename, as_destinationname )

end subroutine

public subroutine createcontrolattributelinkitem (string as_sourcename, string as_destinationname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateControlBEOLinkItem
//
//	Arguments:		String	-	as_sourcename
//						String	-	as_destinationname
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Integrates the controls links in DBF with the arguments needed
//						by PFC linkage.
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


u_dw dw

dw = idw_currentdestination
dw.inv_linkage.SetCallback(inv_parameters)

end subroutine

public subroutine createfilterlink (datawindow adw_source, datawindow adw_destination);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateFilterLink
//
//	Arguments:		Datawindow	-	adw_source
//						Datawindow	-	adw_destination
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Integrates the PFC linkage service with the links set by DBF.
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


u_dw dw1, dw2

super::CreateFilterLink(adw_source, adw_destination)

if not VerifyDW(adw_source, true) then
	return
end if

if not VerifyDW(adw_destination, true) then
	return
end if

dw1 = adw_source
dw2 = adw_destination

dw1.of_SetLinkage(TRUE)
dw2.of_SetLinkage(TRUE)
dw2.inv_linkage.of_LinkTo(dw1)
dw2.inv_linkage.of_SetUseColLinks(1)
dw2.inv_linkage.of_ResetArguments()

end subroutine

public subroutine createscrolllink (datawindow adw_source, datawindow adw_destination);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		CreateScrollLink
//
//	Arguments:		Datawindow	-	adw_source
//						Datawindow	-	adw_destination
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Integrates the PFC linkage service with the links set by DBF.
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


u_dw dw1, dw2

super::CreateScrollLink(adw_source, adw_destination)

if not VerifyDW(adw_source, true) then
	return
end if

if not VerifyDW(adw_destination, true) then
	return
end if

dw1 = adw_source
dw2 = adw_destination

dw1.of_SetLinkage(TRUE)
dw2.of_SetLinkage(TRUE)
dw2.inv_linkage.of_LinkTo(dw1)
dw2.inv_linkage.of_SetUseColLinks(3)
dw2.inv_linkage.of_ResetArguments()

end subroutine

protected function boolean verifydw (datawindow adw_datawindow, boolean ab_flag);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		VerifyDW
//
//	Arguments:		Datawindow	-	adw_datawindow
//						ab_flag	-	Should we display a message.
//
//	returns:			Boolean
//
//	Description:	Tests to see if a DW is a PFC DW.
//						FOR INTERNAL USE ONLY.
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
//	Any distribution of the Distributed Business Object Framework (DBF)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

IF adw_datawindow.TriggerEvent("pfc_descendant") <> 1 THEN
	if ab_flag then
		MessageBox("Task Linkage Service Error", "DataWindow " + classname(adw_datawindow) + " does not inherit from u_dw. Only descendants of u_dw can be used in control to control links.")
	end if
	return false
end if
return true
end function

on task_n_cst_winsrv_pfclinkages.create
TriggerEvent( this, "constructor" )
end on

on task_n_cst_winsrv_pfclinkages.destroy
TriggerEvent( this, "destructor" )
end on

