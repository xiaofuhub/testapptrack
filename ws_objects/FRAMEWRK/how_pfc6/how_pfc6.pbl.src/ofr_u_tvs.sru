$PBExportHeader$ofr_u_tvs.sru
$PBExportComments$PFC Service Based TreeView class
forward
global type ofr_u_tvs from pfc_u_tvs
end type
end forward

global type ofr_u_tvs from pfc_u_tvs
event type integer ofr_error ( readonly n_cst_ofrerror_collection anv_ofrerror_collection )
end type
global ofr_u_tvs ofr_u_tvs

type variables
long il_retrieved
end variables

forward prototypes
public function integer ofrerror ()
public function long of_populate (long al_parent)
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
integer li_error_level

li_error_level = inv_levelsource.dynamic GetErrorLevel()
lnv_ofrerrors = inv_levelsource.inv_uilink[li_error_level].GetOFRErrorCollection()

return this.event ofr_error(lnv_ofrerrors)

end function

public function long of_populate (long al_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Populate
//
//	Access:		Public
//
//	Arguments:	
//	al_parent	The handle to the Treeview item to place retrieved data under
//
//	Returns:		Long
//			 # of items treeview was populated with
//			 0 if nothing was populated
//			-1 = error
//
//	Description:
//	retrieves the datasource and uses it to load the treeview with data
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

// check arguments
IF (al_parent < 0) or IsNull(al_parent) then Return -1

Setpointer(hourglass!)

// retrieve the data into the services datastore
il_retrieved = this.event pfc_retrieve(al_parent, lds_data)
if il_retrieved < 0 Then Return -1

// add the treeview data
Return this.event pfc_AddAll(al_parent, lds_data) 

end function

event pfc_addall;//////////////////////////////////////////////////////////////////////////////
//
//	Event:		pfc_AddAll
//
//	Arguments:	
//	al_parent	The handle to the Treeview item to place data under
//	ads_source	data source to use for setting treeview item values
//
//	Returns:		long
//					 number of items added successfully  
//					 0 = no items added
//					-1 = an error occurred
//
//	Description:	Add all the rows from data source to the treeview.
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
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long		ll_count=0
Long		ll_rowcount, ll_row

// check the arguments
If IsNull(ads_source) or Not IsValid(ads_source) Then Return -1
If (al_parent < 0) or isnull(al_parent) then Return -1

// loop through the data and add the items
ll_rowcount = ads_source.RowCount()

For ll_row = (ll_rowcount - il_retrieved) + 1 to ll_rowcount
	If this.event pfc_insertitem(al_parent, ads_source, ll_row, INSERT_LAST, 0) < 1 then
		Return -1
	End If
	ll_count++
End For

return ll_count
end event

