$PBExportHeader$n_cst_dwsrv_querymode.sru
$PBExportComments$Extension DataWindow QueryMode service
forward
global type n_cst_dwsrv_querymode from pfc_n_cst_dwsrv_querymode
end type
end forward

type os_extendedquerymodeinfo from structure
	string		s_edit_displayonly
	string		s_edit_limit
end type

global type n_cst_dwsrv_querymode from pfc_n_cst_dwsrv_querymode
end type
global n_cst_dwsrv_querymode n_cst_dwsrv_querymode

type variables
Private:
os_ExtendedQueryModeInfo	istr_ExtendedQueryModeInfo[]
end variables

forward prototypes
public function integer of_setquerycols (string as_querycolumns[])
public function integer of_setenabled (boolean ab_switch)
end prototypes

public function integer of_setquerycols (string as_querycolumns[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetQueryCols
//
//	Access:  public
//
//	Arguments:
//   as_querycolumns[]  column names that allow data to be entered in querymode
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	To identify the columns that can have query criteria entered
//	when the datawindow is in QueryMode
//
// OVERRIDING ANCESTOR to provide extended column attribute support
// (edit_displayonly, edit_limit)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Store the QueryColumns in instance variable.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_maxcols
integer	li_i
integer	li_j
integer	li_maxset
integer	li_rc
string		ls_collist[]

// Check the datawindow reference
if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

// Get the upperbound value
li_maxcols = UpperBound (istr_querymodeinfo) 

// li_maxcols will be 0 if no columns have previously been set
if li_maxcols = 0 then
	
	// Initialize the structure with information of all the columns.
	// Store the original protect attribute, and initially set column
	// as not being a queryable column.
	li_rc = of_GetObjects (ls_collist, "column", "*", true) 
	li_maxcols = UpperBound (ls_collist)

	if li_maxcols = 0 then return -1

	for li_i = 1 to li_maxcols
		istr_querymodeinfo[li_i].s_col = ls_collist[li_i]
		istr_querymodeinfo[li_i].b_state = false
		istr_querymodeinfo[li_i].s_protect = idw_requestor.Describe (ls_collist[li_i] + ".protect")
		//Begin Extension - Collect additional properties for edit style.
		istr_ExtendedQueryModeInfo[li_i].s_Edit_DisplayOnly = idw_Requestor.Describe (ls_ColList[li_i] + ".Edit.DisplayOnly" )
		istr_ExtendedQueryModeInfo[li_i].s_Edit_Limit = idw_Requestor.Describe (ls_ColList[li_i] + ".Edit.Limit" )
		//End Extension
	next

else

	// Reset the queryable columns flag
	for li_i = 1 to li_maxcols
		istr_querymodeinfo[li_i].b_state = false
	next

end if
	
// Find the columns being set and tag it as queryable based on passed argument.
li_maxset = UpperBound (as_querycolumns)
for li_i = 1 to li_maxset
	for li_j = 1 to li_maxcols
		if Lower (istr_querymodeinfo[li_j].s_col) = Lower (as_querycolumns[li_i]) then
			istr_querymodeinfo[li_j].b_state = true
		end if
	next
next

is_querycolumns = as_querycolumns
return 1
end function

public function integer of_setenabled (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetEnabled
//
//	Access:  Public
//
//	Arguments: 
//   ab_switch
//	TRUE turns QueryMode on, 
//	FALSE turns QueryMode off
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:
//	Toggles querymode settings on and off based on argument
//
// OVERRIDING ANCESTOR to provide extended column attribute support
// (edit_displayonly, edit_limit)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Check that at least one QueryColumn has been requested prior to 
//			disabling/enabling columns.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer		li_numquerycols
integer		li_i
string		ls_rc
string		ls_modify
boolean		lb_querycolumn

// Verify passed arguments.
if IsNull (ab_switch) then return -1  

// Check the datawindow reference.
if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

// Disable the Redraw during the operation.
idw_requestor.SetReDraw (false)

// Get the upperbound of the querymode stored information.
li_numquerycols = UpperBound (istr_querymodeinfo)

// Check that at least one QueryColumn has been requested.
lb_querycolumn = (UpperBound(is_querycolumns) > 0)

choose case ab_switch

		case true
			// Clear prior QueryMode criteria if necessary
			if ib_resetcriteria then idw_requestor.Object.DataWindow.QueryClear = "yes"

			// Put the datawindow into QueryMode state
			idw_requestor.Object.DataWindow.QueryMode = "yes"

			// Check that at least one QueryColumn has been requested prior to 
			//	disabling/enabling columns.
			If lb_querycolumn Then
				// Build Modify string to change all the appropriate properties
				for li_i = 1 to li_numquerycols
					if istr_querymodeinfo[li_i].b_state = false then
						// Add to modify string to protect for non-querymode columns
						ls_modify = ls_modify + istr_querymodeinfo[li_i].s_col + ".Protect = 1 " 
					else
						// Add to modify string to non-protect for querymode columns.
						ls_modify = ls_modify + istr_querymodeinfo[li_i].s_col + ".Protect = 0 " 

						//Begin extension
						IF istr_ExtendedQueryModeInfo[li_i].s_Edit_DisplayOnly = "yes" THEN
							ls_Modify += istr_QueryModeInfo[li_i].s_col + ".Edit.DisplayOnly = no "
						END IF
						IF Integer ( istr_ExtendedQueryModeInfo[li_i].s_Edit_Limit ) > 0 THEN
							ls_Modify += istr_QueryModeInfo[li_i].s_col + ".Edit.Limit = 0 "
						END IF
						//End extension

					end if
				next
			
				// Execute the Modify string changing all the appropriate properties
				ls_rc = idw_Requestor.Modify (ls_modify)
				if ls_rc <> "" then
					idw_requestor.SetRedraw (true)
					return -1
				end if
			end if

		case false
			// Turn off QueryMode
			idw_Requestor.Object.DataWindow.QueryMode = "no"

			// Build Modify string to Reset all the appropriate properties
			for li_i = 1 to li_numquerycols
				// Add to Modify string to restore the protect property
				ls_modify = ls_modify + istr_querymodeinfo[li_i].s_col + &
						".Protect = " + istr_querymodeinfo[li_i].s_protect + " " 

				//Begin extension

				IF istr_ExtendedQueryModeInfo[li_i].s_edit_displayonly = "yes" THEN
					ls_Modify += istr_QueryModeInfo[li_i].s_col + ".Edit.DisplayOnly = yes "
				END IF

				IF Integer ( istr_ExtendedQueryModeInfo[li_i].s_Edit_Limit ) > 0 THEN
					ls_Modify += istr_QueryModeInfo[li_i].s_col + ".Edit.Limit = " +&
						istr_ExtendedQueryModeInfo[li_i].s_Edit_Limit + " "
				END IF

				//End extension

			next

			// Execute the Modify string
			ls_rc = idw_requestor.Modify (ls_modify)
			if ls_rc <> "" then
				idw_requestor.SetRedraw (true)
				return -1
			end if

			// Perform retrive if appropriate.
			if ib_retrieveondisabled then
				idw_requestor.event pfc_retrieve () 
			end if

end choose

idw_requestor.SetReDraw (true)
return 1
end function

on n_cst_dwsrv_querymode.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwsrv_querymode.destroy
TriggerEvent( this, "destructor" )
end on

