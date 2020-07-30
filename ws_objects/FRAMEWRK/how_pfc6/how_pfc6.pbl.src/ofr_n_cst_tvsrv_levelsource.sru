$PBExportHeader$ofr_n_cst_tvsrv_levelsource.sru
$PBExportComments$Extension Treeview Level Based service
forward
global type ofr_n_cst_tvsrv_levelsource from pfc_n_cst_tvsrv_levelsource
end type
end forward

global type ofr_n_cst_tvsrv_levelsource from pfc_n_cst_tvsrv_levelsource
end type
global ofr_n_cst_tvsrv_levelsource ofr_n_cst_tvsrv_levelsource

type variables
public:
n_cst_uilink_tvs inv_uilink[]

protected:
string is_openframeservice = "n_cst_uilink_tvs"
integer ii_error_level

end variables

forward prototypes
public function integer of_registerdatasource (integer ai_level, string as_method, string as_dataobject, n_tr atr_obj, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile)
public function integer setuilink (readonly integer ai_level, readonly boolean ab_switch)
public function long of_retrieve (integer ai_level, any aa_arg[20], ref n_ds ads_data)
public function integer geterrorlevel ()
public function integer of_register (integer ai_level, string as_labelcolumn, string as_retrieveargs, string as_dwobjectname, n_tr atr_obj, string as_filtercols, string as_method, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile)
end prototypes

public function integer of_registerdatasource (integer ai_level, string as_method, string as_dataobject, n_tr atr_obj, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile);//
//	Function:	of_RegisterDataSource
//
//	Access:		protected
//
//	Arguments:  
//	ai_Level				The TreeView level to associate the data source with.
//	as_method			The Method we will use to populate the data source
//	as_dataobject		The DataWindow object to be used for the data source.
//	atr_obj				The transaction object for this data source (can be
//								different for each level).
//	as_sql				The SQL Statement to be used for the data source (if specified).
//	apo_data[]			The data to be used for the data source (if specified).
//	adw_control			The datawindow control to be used for the data source (if specified).
//	ads_control			The datastore control to be used for the data source (if specified).
//	as_importfile		The import file from which to be used for the data source (if specified).
//
//	Returns:  Integer
//	 1 if it succeeds
//	-1 if an error occurs.
//	
//	Description:
//	Register the datasource definition with the cache service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	2.0 OFR
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1998 Riverton Software Corporation.  All Rights Reserved.
//	Any distribution of the HOW OpenFrame (OFR)
//	source code by other than Riverton is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Integer	li_rc
n_ds lds_source

li_rc = super::of_RegisterDataSource(ai_level, as_method, as_dataobject, atr_obj, as_sql, apo_data, adw_control, ads_control, as_importfile)

if li_rc = 1 then
	if ai_level <= UpperBound(inv_uilink) then
		if IsValid(this.inv_uilink[ai_level]) then
			if IsValid(inv_cache) then
				if inv_cache.of_GetRegistered(CACHE_ID + string(ai_level), lds_source) = 1 then
					//		Set cache DS - used for retrieval
					this.inv_uilink[ai_level].SetDataSource(lds_source)
					if this.of_GetDataSource(ai_level, lds_source) = 1 then
						//		Set datasource DS - used for update
						this.inv_uilink[ai_level].SetDataSource(lds_source)
					end if
				end if
			end if
		end if
	end if
end if

return li_rc

end function

public function integer setuilink (readonly integer ai_level, readonly boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		SetUILink
//
//	Arguments:		ai_level
//						ab_switch
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
int li_rc = -1

//Check arguments
if IsNull(ab_switch) then
	return -1
end if

if ab_Switch then
	if ai_level <= UpperBound(inv_uilink) then
		if IsValid(inv_uilink[ai_level]) then
			return 1
		end if
	end if
	inv_uilink[ai_level] = create using is_openframeservice
	if inv_uilink[ai_level].SetRequestor(itv_requestor) = 1 then
		li_rc = 1
	end if
else
	if IsValid(inv_uilink[ai_level]) then
		destroy inv_uilink[ai_level]
		li_rc = 1
	end if	
end if

return li_rc

end function

public function long of_retrieve (integer ai_level, any aa_arg[20], ref n_ds ads_data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_Retrieve
//
//	Access:		public
//
//	Arguments:
//	ai_Level		The TreeView level to be retrieved.
//	aa_Arg[20]	An array of type Any that will contain the retrieval
//						argument values.  
//	ads_obj		The datastore holding the retrieved data.  Passed by reference
//
//	Returns:		Integer
//			Returns 1 if the data source was added successfully, 
//			-1 if an error occurrs.
//			-2 Key columns were not defined for the level
//			-3 Retrieve from datastore was not successful
//			-4 if datawindow object is not valid
//
//	Description:	Retrieve the data for a treeview level.
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
Integer		li_Cnt, li_Index, li_numcols
Long			ll_NewRows, ll_Rows
String		ls_cacheid, ls_filter, ls_expression
string		ls_column[], ls_operators[]
window		lw_parentwindow

if NOT IsValid(this.inv_uilink[ai_level]) then
	return super::of_Retrieve(ai_level, aa_arg, ads_data)
end if

//	Check arguments
If IsNull(itv_requestor) or not isvalid(itv_requestor) Then Return -1
If IsNull(ai_level) or (ai_level < 1) Then
	Return -1
End If

// Determine if the level is recursive
If ai_Level > UpperBound(inv_attrib) Then
	li_Index = UpperBound(inv_attrib)
Else
	li_Index = ai_Level
End If

// check datawindow object for existence.  This is set to ""
// in of_register() when the datawindow is not updateable
if inv_attrib[li_Index].is_DataObject= "" then
	return -4
end if

if this.of_GetDataSource(ai_level, ads_data) = 1 then
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

public function integer geterrorlevel ();return ii_error_level

end function

public function integer of_register (integer ai_level, string as_labelcolumn, string as_retrieveargs, string as_dwobjectname, n_tr atr_obj, string as_filtercols, string as_method, string as_sql, powerobject apo_data[], datawindow adw_control, datastore ads_control, string as_importfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:	of_register
//
//	Access:		public
//
//	Arguments:
//	ai_Level					The TreeView level to associate the data source with.
//	as_LabelColumn			The column in the DataWindow object to display. 
//	as_RetrieveArgs		Retrieval/filter arguments for the level.  These should
//									be separated by commas in the format:
//										:keyword.n.column
//									where column is the name of a column in another level's
//									data source.  If keyword is 'level', n is an absolute level 
//									number.  If keyword is 'parent', n is a number relative to
//									the current level (i.e. :parent.2.c1 would be column c1 in
//									the DataWindow for the level 2 levels above this one).
//	as_DWobjectname		The DataWindow object to be used for the data source.
//	atr_obj					The transaction object for this data source (can be
//									different for each level).
//	as_FilterCols		Columns on the datastore object used for filtering the datastore.
//								This type of datasource does a retrieve once and uses the 
//								retrieval arguments to to filter out those records which do not
//								match.  The column names should be separated by commas.
//									ex:  "colname.NA, Col2name.NO, col3name"
//									means "Not (Colname=xxx) And Not (col2name=xxx) Or col3name=xxx"
//									ex:  "colname.A, Col2name"
//									means "Colname=xxx And col2name=xxx"
//									xxx is the values provided by the retrieval args
//								The columns will be the left side of the filter statement and the
//								retrieval arguments are the right side (i.e. filtercol='retrieval args')
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
//	-3 = a previous level had already been marked as recursive (there can be no more)
//	-4 = column label datatype was not in the data source
//	-5 = SetTransObject failed for the data source
// -7 = Error from Cache Registration 
//
//	Description:	Register a data source for a level of the TreeView.  The data source is a
//						DataWindow object that will be linked to the TreeView level and used
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

Integer	li_NumDS, li_Cnt, li_rc
String	ls_rc, ls_columncount, ls_sqlerr
window	lw_parentwindow
n_ds		lds_test

// Check arguments
if IsNull (ai_level) or ai_level <= 0 or &
	Len (as_labelcolumn) = 0 or IsNull (as_labelcolumn) or &
	Len (as_DWobjectname) = 0 or IsNull (as_DWobjectname) or &
	Len (as_method) = 0 or IsNull (as_method) then
	return -1
end if

// Check if recurrsive is being used
li_NumDS = UpperBound(inv_attrib)
If li_NumDS > 0 Then
	If inv_attrib[li_NumDS].ib_Recursive Then
		// If the last one is recursive, there can be no more
		Return -3
	End if
End if

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
// level does not exist and neither does datasource - so create it
If li_NumDS < ai_Level Then
	inv_attrib[ai_Level].ids_obj = Create n_ds
	If as_method = inv_cache.SQL Then
		inv_attrib[ai_Level].ids_obj.Create( as_DWobjectname, ls_sqlerr )
	Else
		inv_attrib[ai_Level].ids_obj.DataObject = as_DWobjectname
	End If
End If

If IsNull(inv_attrib[ai_Level].ids_obj) Or Not IsValid(inv_attrib[ai_Level].ids_obj) Then
	// level exists, but no datastore defined for it
	inv_attrib[ai_Level].ids_obj = Create n_ds
End if
// create a new dataobject for the level
If as_method = inv_cache.SQL Then
	inv_attrib[ai_Level].ids_obj.Create( as_DWobjectname, ls_sqlerr )
Else
	inv_attrib[ai_Level].ids_obj.DataObject = as_DWobjectname
End If

// Set values in the structure array
inv_attrib[ai_Level].is_Dataobject = as_DWobjectname
inv_attrib[ai_Level].is_LabelColumn = as_LabelColumn
inv_attrib[ai_Level].is_RetrieveArgs = as_RetrieveArgs
inv_attrib[ai_Level].is_FilterCols = as_filtercols
inv_attrib[ai_Level].itr_obj = atr_obj
inv_attrib[ai_Level].is_Method = as_Method

// Set parameters for the DataStore
inv_attrib[ai_Level].ids_obj.of_SetBase(true)
inv_attrib[ai_Level].ids_obj.of_SetAppend(false)

// datastore needs parent window reference to perform updates
itv_requestor.of_Getparentwindow(lw_parentwindow)
inv_attrib[ai_Level].ids_obj.of_SetParentWindow(lw_parentwindow)

// make sure transaction object is valid
If IsValid(atr_obj) Then
	If inv_attrib[ai_Level].ids_obj.of_SetTransObject(atr_obj) <> 1 Then 
		inv_attrib[ai_Level].is_Dataobject = ""
		Destroy inv_attrib[ai_Level].ids_obj
		Return -5
	End If
End If

// register with cache service
li_rc = of_registerdatasource(ai_level, as_method, as_DWobjectname, atr_obj, &
										as_sql, apo_data, adw_control, ads_control, as_importfile)
If li_rc < 1 Then 
	inv_attrib[ai_Level].is_Dataobject = ""
	Destroy inv_attrib[ai_Level].ids_obj
	Return -7
End If

Return 1

end function

on ofr_n_cst_tvsrv_levelsource.create
TriggerEvent( this, "constructor" )
end on

on ofr_n_cst_tvsrv_levelsource.destroy
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
int					li_level
n_ds					lds_DataStore
n_cst_ofrerror lnv_ofrerror[]
TreeViewItem		ltvi_Item

// check reference variables
If IsNull(itv_requestor) or Not IsValid(itv_requestor) Then Return -1

// check arguments
if itv_requestor.GetItem(al_handle, ltvi_Item) = FAILURE then
	return PREVENT_ACTION
end if

// Make sure the label did change
If as_newtext = ltvi_Item.Label Then Return PREVENT_ACTION

ll_rc = super::event pfc_endlabeledit(al_handle, as_newtext)

if ll_rc = prevent_action then
	// Get the label column for the level
	li_level = this.of_GetLevel(al_handle)
	If li_level < 1 then Return PREVENT_ACTION
	if this.of_GetDataSource(li_level, lds_DataStore) = 1 then
		if IsValid(this.inv_uilink[li_level]) and IsValid(lds_DataStore.inv_uilink) then
			//		Copy the errors from the internal DS to the LV UILink service
			this.inv_uilink[li_level].PropagateErrors(lds_DataStore.inv_uilink)
			this.inv_uilink[li_level].GetOFRErrors(lnv_ofrerror)
			this.ii_error_level = li_level
			this.inv_uilink[li_level].ProcessOFRError(lnv_ofrerror)
		end if
	end if
end if

return ll_rc


end event

