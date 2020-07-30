$PBExportHeader$task_n_cst_pfcparameters.sru
forward
global type task_n_cst_pfcparameters from task_n_cst_parameters
end type
end forward

global type task_n_cst_pfcparameters from task_n_cst_parameters
end type
global task_n_cst_pfcparameters task_n_cst_pfcparameters

forward prototypes
public function integer retrievedatawindow (datawindow adw_datawindow)
end prototypes

public function integer retrievedatawindow (datawindow adw_datawindow);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		RetrieveDatawindow
//
//	Arguments:		Datawindow	-	adw_datawindow
//
//	returns:			Integer	- number of rows retrieved.
//
//	Description:	Integrates DBF retrievals with the PFC services.
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

// Determine if this is a PFC Datawindow
IF adw_datawindow.TriggerEvent ( "pfc_descendant" ) = 1 THEN 
	// This is a PFC datawindow
	dw = adw_datawindow

	// A PFC Datawindow can either be Linked or NotLinked
   if isValid(dw.inv_linkage) then
	   return dw.inv_linkage.of_retrieve()
	else
		return dw.Event pfc_retrieve()
	end if
End If

// This is a standard DataWindow
Return super::RetrieveDataWindow(adw_datawindow)






end function

on task_n_cst_pfcparameters.create
TriggerEvent( this, "constructor" )
end on

on task_n_cst_pfcparameters.destroy
TriggerEvent( this, "destructor" )
end on

