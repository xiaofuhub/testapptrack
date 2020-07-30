$PBExportHeader$n_cst_dwsrv_sort.sru
$PBExportComments$Extension DataWindow Sort service
forward
global type n_cst_dwsrv_sort from pfc_n_cst_dwsrv_sort
end type
end forward

global type n_cst_dwsrv_sort from pfc_n_cst_dwsrv_sort
end type
global n_cst_dwsrv_sort n_cst_dwsrv_sort

forward prototypes
public function string of_getsort ()
end prototypes

public function string of_getsort ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetSort
//
//	Access:    		Public
//
//	Arguments: 		None
//
//	Returns:   		String
//						The sort expression
//
//	Description:	Get the current sort expression on the datawindow.
//
// Overriding ancestor in order to screen for "?" when there is no sort.
// This screening is built into PFC's getfilter, but not getsort.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Sort

// Check the datawindow reference.
If IsNull(idw_Requestor) Or Not IsValid(idw_Requestor) Then Return ''

// Return the current sort for the datawindow.
ls_Sort = idw_Requestor.Describe ("DataWindow.Table.Sort")

// A questionmark indicates no sort set.
If ls_Sort='?' Then ls_Sort = ''

Return ls_Sort
end function

on n_cst_dwsrv_sort.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwsrv_sort.destroy
TriggerEvent( this, "destructor" )
end on

