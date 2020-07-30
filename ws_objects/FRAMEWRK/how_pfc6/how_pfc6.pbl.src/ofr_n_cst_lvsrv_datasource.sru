$PBExportHeader$ofr_n_cst_lvsrv_datasource.sru
$PBExportComments$Extension ListView Datasource service
forward
global type ofr_n_cst_lvsrv_datasource from pfc_n_cst_lvsrv_datasource
end type
end forward

global type ofr_n_cst_lvsrv_datasource from pfc_n_cst_lvsrv_datasource
end type
global ofr_n_cst_lvsrv_datasource ofr_n_cst_lvsrv_datasource

type variables
public:
n_cst_uilink_lvs inv_uilink

protected:
string is_openframeservice = "n_cst_uilink_lvs"

end variables

forward prototypes
public function integer setuilink (readonly boolean ab_switch)
public function long of_retrieve (any aa_arg[20], ref n_ds ads_data)
public function integer of_registerdatasource (string as_method, string as_dataobject, n_tr atr_obj, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile)
public function integer of_register (string as_labelcolumn, string as_dwobjectname, n_tr atr_obj, string as_method, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile)
end prototypes

public function integer setuilink (readonly boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUILink
//
//	Arguments:		Boolean	-	ab_switch
//
//	returns:			Integer
//						1		success
//						-1		error
//
//	Description:	Turns business object services on/off
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
int li_rc

//Check arguments
if IsNull(ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid(inv_uilink) then
		inv_uilink = create using is_openframeservice
		if inv_uilink.SetRequestor(ilv_requestor) = 1 then
			li_rc = 1
		end if
	end if
else
	if IsValid(inv_uilink) then
		destroy inv_uilink
		li_rc = 1
	end if	
end if

return li_rc

end function

public function long of_retrieve (any aa_arg[20], ref n_ds ads_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Retrieve
//
//	Access:		public
//
//	Arguments:
//	aa_Arg[20]	An array of type Any that will contain the retrieval
//						argument values.  
//	ads_data		The datastore holding the retrieved data.  Passed by reference
//
//	Returns:		Integer
//			Returns 1 if the data source was added successfully, 
//			-1 if an error occurrs.
//			-2 Key columns were not defined for the level
//			-3 Retrieve from datastore was not successful
//			-4 if datawindow object is not valid
//
//	Description:	Retrieve the data for a listview level.
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

Long			ll_NewRows, ll_Rows

if NOT IsValid(this.inv_uilink) then
	return super::of_Retrieve( aa_arg, ads_data )
end if

//	Check arguments
If IsNull(ilv_requestor) or not isvalid(ilv_requestor) Then Return -1

// check datawindow object for existence.  This is set to ""
// in of_register() when the datawindow is not updateable
if inv_attrib.is_DataObject= "" then
	return -4
end if

if this.of_GetDataSource(ads_data) = 1 then
	//		FIX SMF 4/2/98
	ll_rows = ads_data.RowCount()
	ll_NewRows = ads_data.Retrieve(aa_Arg[1], aa_Arg[2], aa_Arg[3], aa_Arg[4], aa_Arg[5], &
											aa_Arg[6], aa_Arg[7], aa_Arg[8], aa_Arg[9], aa_Arg[10], &
											aa_Arg[11], aa_Arg[12], aa_Arg[13], aa_Arg[14], aa_Arg[15], &
											aa_Arg[16], aa_Arg[17], aa_Arg[18], aa_Arg[19], aa_Arg[20])
	ll_NewRows = ll_NewRows - ll_rows
	//		END FIX
end if

Return ll_NewRows

end function

public function integer of_registerdatasource (string as_method, string as_dataobject, n_tr atr_obj, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_RegisterDataSource
//
//	Access:		protected
//
//	Arguments:
//	as_method			The Method we will use to populate the data source
//	as_dataobject	The DataWindow object to be used for the data source.
//	atr_obj				The transaction object for this data source .
//	as_sql				The SQL Statement to be used for the data source (if specified).
//	apo_data[]			The data to be used for the data source (if specified).
//	adw_control			The datawindow control to be used for the data source (if specified).
//	ads_control			The datastore control to be used for the data source (if specified).
//	as_importfile		The import file from which to be used for the data source (if specified).
//
//	Returns:		Integer
//	 1 = the data source was added successfully
//	-1 = Nothing was registered with the cache
//
//	Description:	Register a data source for the ListView with the cache service. 
//
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
int li_rc
n_ds lds_source

li_rc = super::of_RegisterDataSource(as_method, as_dataobject, atr_obj, as_sql, apo_data, adw_control, ads_control, as_importfile)

if li_rc = 1 then
	if IsValid(this.inv_uilink) then
		if IsValid(inv_cache) then
			if inv_cache.of_GetRegistered(CACHE_ID, lds_source) = 1 then
				//		Set cache DS - used for retrieval
				this.inv_uilink.SetDataSource(lds_source)
				if this.of_GetDataSource(lds_source) = 1 then
					//		Set datasource DS - used for update
					this.inv_uilink.SetDataSource(lds_source)
				end if
			end if
		end if
	end if
end if

return li_rc

end function

public function integer of_register (string as_labelcolumn, string as_dwobjectname, n_tr atr_obj, string as_method, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:

//	as_LabelColumn		The column in the DataWindow object to display. 
//	as_DWobjectname	The DataWindow object to be used for the data source.
//	atr_obj				The transaction object for this data source 
//	as_method			The Method we will use to populate the data source
//	as_sql				The SQL Statement to be used for the data source (if specified).
//	apo_data[]			The data to be used for the data source (if specified).
//	adw_control			The datawindow control to be used for the data source (if specified).
//	ads_control			The datastore control to be used for the data source (if specified).
//	as_importfile		The import file from which to be used for the data source (if specified).
//
//	Returns:  integer
//	 1 = the data source was added successfully
//	-1 = argument validation error
//	-4 = column label datatype was not in the data source
//	-5 = SetTransObject failed for the data source
// -7 = Error from Cache Registration 
//
//	Description:	Register a data source for a ListView.  The data source is a
//						DataWindow object that will be linked to the Listview and used
//						to populate.
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

Integer	li_rc
String	ls_sqlerr
window	lw_parentwindow
n_ds		lds_test

// Check arguments
if Len (as_labelcolumn) = 0 or IsNull (as_labelcolumn) or &
	Len (as_DWobjectname) = 0 or IsNull (as_DWobjectname) or &
	Len (as_method) = 0 or IsNull (as_method) then
	return -1
end if

// create temporary datastore 
lds_test = Create n_ds
If as_method = inv_cache.SQL then
	lds_test.Create( as_DWobjectname, ls_sqlerr )
	If Len(ls_sqlerr) > 0 Then
		Destroy lds_test
		Return -1		
	End If 	
Else
	lds_test.DataObject = as_DWobjectname
End If

// label column must be in the datawindow
If lds_test.Describe(as_LabelColumn + ".Band") = "!" Then 
	Destroy lds_test
	Return -4
End if
	
// don't need this anymore
Destroy lds_test

// Create a DataStore to use as the data source
inv_attrib.ids_source = Create n_ds

If as_method = inv_cache.SQL Then
	inv_attrib.ids_source.Create( as_DWobjectname, ls_sqlerr )
Else
	inv_attrib.ids_source.DataObject = as_DWobjectname
End If

// create a new dataobject for the level
If as_method = inv_cache.SQL Then
	inv_attrib.ids_source.Create( as_DWobjectname, ls_sqlerr )
Else
	inv_attrib.ids_source.DataObject = as_DWobjectname
End If

// Set values in the structure array
inv_attrib.is_Dataobject = as_DWobjectname
inv_attrib.is_LabelColumn = as_LabelColumn
inv_attrib.itr_obj = atr_obj
inv_attrib.is_Method = as_Method

// Set parameters for the DataStore
inv_attrib.ids_source.of_SetBase(true)
inv_attrib.ids_source.of_SetAppend(false)

// datastore needs parent window reference to perform updates
ilv_requestor.of_Getparentwindow(lw_parentwindow)
inv_attrib.ids_source.of_SetParentWindow(lw_parentwindow)

// make sure transaction object is valid
If IsValid(atr_obj) Then
	If inv_attrib.ids_source.of_SetTransObject(atr_obj) <> 1 Then 
		inv_attrib.is_Dataobject = ""
		Destroy inv_attrib.ids_source
		Return -5
	End If
End If

// register with cache service
li_rc = this.of_registerdatasource(as_method,as_dwobjectname,atr_obj,as_sql,apo_data,adw_control,ads_control,as_importfile)
If li_rc < 1 Then 
	inv_attrib.is_Dataobject = ""
	Destroy inv_attrib.ids_source
	Return -7
End If

Return 1

end function

on ofr_n_cst_lvsrv_datasource.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_lvsrv_datasource.destroy
TriggerEvent( this, "destructor" )
end on

event pfc_endlabeledit;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_EndLabelEdit
//
//	Description:	Override default PFC behavior to invoke UILink error
//						services if UILink turned on.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Long					ll_Row, ll_rc
n_ds					lds_DataStore
n_cst_ofrerror lnv_ofrerror[]
ListViewItem		llvi_Item

// check reference variables
If IsNull(ilv_requestor) or Not IsValid(ilv_requestor) Then Return -1

// Make sure the label did change
ilv_requestor.GetItem(ai_index, llvi_Item)
If as_newlabel = llvi_Item.Label Then Return PREVENT_ACTION

ll_rc = super::event pfc_endlabeledit(ai_index, as_newlabel)

if ll_rc = prevent_action then
	if this.of_GetDataSource(lds_DataStore) = 1 then
		if IsValid(this.inv_uilink) and IsValid(lds_DataStore.inv_uilink) then
			//		Copy the errors from the internal DS to the LV UILink service
			this.inv_uilink.PropagateErrors(lds_DataStore.inv_uilink)
//			this.Post event ofr_ProcessError()
			this.inv_uilink.GetOFRErrors(lnv_ofrerror)
			this.inv_uilink.ProcessOFRError(lnv_ofrerror)
		end if
	end if
end if

return ll_rc

end event

