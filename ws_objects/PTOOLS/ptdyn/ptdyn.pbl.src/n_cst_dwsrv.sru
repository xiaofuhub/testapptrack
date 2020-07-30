$PBExportHeader$n_cst_dwsrv.sru
$PBExportComments$Extension Base DataWindow service
forward
global type n_cst_dwsrv from pfc_n_cst_dwsrv
end type
end forward

global type n_cst_dwsrv from pfc_n_cst_dwsrv
end type
global n_cst_dwsrv n_cst_dwsrv

forward prototypes
public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
end prototypes

public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 2)
//
//	Access:    		Public
//
//	Arguments:
//   as_objlist[]:	A string array to hold objects (passed by reference)
//   as_objtype:  	The type of objects to get (* for all, others defined
//							by the object .TYPE attribute)
//   as_band:  		The dw band to get objects from (* for all) 
//							Valid bands: header, detail, footer, summary
//							header.#, trailer.#
//   ab_visibleonly: TRUE  - get only the visible objects,
//							 FALSE - get visible and non-visible objects
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//	Description:	The following function will parse the list of objects 
//						contained in the datawindow control associated with this service,
//						returning their names into a string array passed by reference, 
//						and returning the number of names in the array as the return value 
//						of the function.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.1	Maury(for mouseovers)Added Match statement in the visible condition so that a visible property with
//			and expression will be added to the object list (line #55)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string	ls_ObjString, ls_ObjHolder
integer	li_Start=1, li_Tab, li_Count=0

/* Get the Object String */
ls_ObjString = idw_Requestor.Describe("Datawindow.Objects")

/* Get the first tab position. */
li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_ObjHolder = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))
	// Determine if object is the right type and in the right band
	If (idw_Requestor.Describe(ls_ObjHolder + ".type") = as_ObjType Or as_ObjType = "*") And &
		(idw_Requestor.Describe(ls_ObjHolder + ".band") = as_Band Or as_Band = "*") And &
		((idw_Requestor.Describe(ls_ObjHolder + ".visible") = "1" Or Match(idw_Requestor.Describe(ls_ObjHolder + ".visible"), "~t+") Or Not ab_VisibleOnly)) Then
			li_Count ++
			as_ObjList[li_Count] = ls_ObjHolder
	End if
	//Len(idw_Requestor.Describe(ls_ObjHolder + ".visible")) > 1
	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Loop 

// Check the last object
ls_ObjHolder = Mid(ls_ObjString, li_Start, Len(ls_ObjString))

// Determine if object is the right type and in the right band
If (idw_Requestor.Describe(ls_ObjHolder + ".type") = as_ObjType or as_ObjType = "*") And &
	(idw_Requestor.Describe(ls_ObjHolder + ".band") = as_Band or as_Band = "*") And &
	(idw_Requestor.Describe(ls_ObjHolder + ".visible") = "1" Or Match(idw_Requestor.Describe(ls_ObjHolder + ".visible"), "~t+") OR  Not ab_VisibleOnly) Then
		li_Count ++
		as_ObjList[li_Count] = ls_ObjHolder
End if

Return li_Count
end function

on n_cst_dwsrv.create
call super::create
end on

on n_cst_dwsrv.destroy
call super::destroy
end on

