$PBExportHeader$ofr_u_lvs.sru
$PBExportComments$PFC Service Based Listview class
forward
global type ofr_u_lvs from pfc_u_lvs
end type
end forward

global type ofr_u_lvs from pfc_u_lvs
event type integer ofr_error ( readonly n_cst_ofrerror_collection anv_ofrerror_collection )
end type
global ofr_u_lvs ofr_u_lvs

type variables
long il_retrieved
end variables

forward prototypes
public function integer ofrerror ()
public function long of_populate ()
end prototypes

event ofr_error;//////////////////////////////////////////////////////////////////////////////
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
return 0

end event

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

lnv_ofrerrors = inv_datasource.inv_uilink.GetOFRErrorCollection()

return this.event ofr_error(lnv_ofrerrors)

end function

public function long of_populate ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Populate
//
//	Access:		Public
//
//	Arguments:	None
//	
//
//	Returns:		Long
//			 # of items treeview was populated with
//			 0 if nothing was populated
//			-1 = error
//
//	Description:
//	retrieves the datasource and uses it to load the listview with data
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0   Initial version - added method override for of_populate to save the 
//       number of retrieved rows into instance varialbe il_retrieved.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
n_ds		lds_data

Setpointer(hourglass!)

// retrieve the data into the services datastore
il_retrieved = this.event pfc_retrieve( lds_data)
if il_retrieved < 0 Then Return -1

// add the treeview data
Return this.event pfc_AddAll(lds_data) 

end function

