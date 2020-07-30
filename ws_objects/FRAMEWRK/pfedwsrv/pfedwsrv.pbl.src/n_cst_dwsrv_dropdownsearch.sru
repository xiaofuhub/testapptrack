$PBExportHeader$n_cst_dwsrv_dropdownsearch.sru
$PBExportComments$Extension DataWindow DropDownSearch service
forward
global type n_cst_dwsrv_dropdownsearch from pfc_n_cst_dwsrv_dropdownsearch
end type
end forward

global type n_cst_dwsrv_dropdownsearch from pfc_n_cst_dwsrv_dropdownsearch
event type boolean ue_editchanged ( ref long al_row,  ref dwobject adwo_obj,  ref string as_data,  ref string as_found )
end type
global n_cst_dwsrv_dropdownsearch n_cst_dwsrv_dropdownsearch

type prototypes
SUBROUTINE keybd_event( int bVk, int bScan, int dwFlags, int dwExtraInfo) &
LIBRARY "user32.dll"



end prototypes

type variables
//private string is_lastFoundText
end variables

forward prototypes
private function integer of_reverttext (long al_row, dwobject adwo_obj, ref string as_found)
end prototypes

event type boolean ue_editchanged(ref long al_row, ref dwobject adwo_obj, ref string as_data, ref string as_found);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		pfc_editchanged
//
//	Arguments:
//	al_row:  	row number
//	adwo_obj:  	DataWindow object passed by reference
//	as_data:  	The current data on the column.  (The search text)
//
//	Returns:   none
//
//	Description:	This event should be mapped to the editchanged
//			   		event of a DataWindow. When is event is "fired", it will use
//						instance variables (set in the pfc_itemfocuschanged) to access
//						items in the instance structure.
//						The instance structure contains information about the dddw and 
//						ddlb columns this service uses.
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
integer		li_searchtextlen
//created by Dan 12-12-2005, basically the same as editchanged except it doesn't change the value if it doesn't
//find it, and it returns whether or not it finds it.

long			ll_findrow
string		ls_dddw_displaycol
string		ls_foundtext
string		ls_findexp
string		ls_searchcolname
long			ll_dddw_rowcount
long			li_ddlb_index=0
string		ls_displaydata_value
string		ls_searchtext
boolean		lb_matchfound=False
int			li_vKey


// Check requirements.
If IsNull(adwo_obj) or Not IsValid(adwo_obj) Then Return false

// Confirm that the search capabilities are valid for this column.
if ib_performsearch=False or ii_currentindex <= 0 THEN return false

// Get information on the column and text.
ls_searchcolname = adwo_obj.Name
ls_searchtext = as_data
li_searchtextlen = Len (ls_searchtext)

// If the user performed a delete operation, do not perform the search.
// If the text entered is the same as the last search, do not perform another search.
If (li_searchtextlen < Len(is_textprev)) or &
	(Lower (ls_searchtext) = Lower (is_textprev)) Then
	// Store the previous text information.
	is_textprev = ''
	Return false
End If

// Store the previous text information.
is_textprev = ls_searchtext

If istr_columns[ii_currentindex].s_editstyle = 'dddw' Then
	// *** DropDownDatawindow Search ***
	// Build the find expression to search the dddw for the text 
	// entered in the parent datawindow column.
	ls_dddw_displaycol = adwo_obj.dddw.displaycolumn
	ls_findexp = "Lower (Left (" + ls_dddw_displaycol + ", " + &
		String (li_searchtextlen) + ")) = '" + Lower (ls_searchtext) + "'"

	// Perform the Search on the dddw.
	ll_dddw_rowcount = istr_columns[ii_currentindex].dwc_object.rowcount()
	ll_findrow = istr_columns[ii_currentindex].dwc_object.Find (ls_findexp, 0, ll_dddw_rowcount)

	// Determine if a match was found on the dddw.
	lb_matchfound = (ll_findrow > 0)

	// Set the found text if found on the dddw.
	if lb_matchfound then
		// Get the text found.
		ls_foundtext =	istr_columns[ii_currentindex].dwc_object.GetItemString (&
									ll_findrow, ls_dddw_displaycol)
	End If								
ElseIf istr_columns[ii_currentindex].s_editstyle = 'ddlb' Then
	// *** DropDownListBox Search ***
	// Loop around the entire Code Table until a match is found (if any).
	Do
		li_ddlb_index	++
		ls_displaydata_value = idw_requestor.GetValue(ls_searchcolname, li_ddlb_index)
		If ls_displaydata_value = '' Then 
			// No more entries on the Code Table.
			Exit
		End If
	
		// Determine if a match has been found on the ddlb.
		lb_matchfound = ( Lower(ls_searchtext) = Lower( Left(ls_displaydata_value, Len(ls_searchtext))) )
	Loop Until lb_matchfound
	
	// Check if a match was found on the ddlb.
	If lb_matchfound Then
		// Get the text found by discarding the data value (just keep the display value).
		ls_foundtext = Left (ls_displaydata_value, Pos(ls_displaydata_value,'~t') -1)			
	End If
End If

// For either dddw or ddlb, check if a match was found.
If lb_matchfound Then
	// Set the text.
	idw_requestor.SetText (ls_foundtext)

	// Determine what to highlight or where to move the cursor..
	if li_searchtextlen = len(ls_foundtext) THEN
		// Move the cursor to the end
		idw_requestor.SelectText (Len (ls_foundtext)+1, 0)
	else
		// Hightlight the portion the user has not actually typed.
		idw_requestor.SelectText (li_searchtextlen + 1, Len (ls_foundtext))
	end if
	as_found = ls_foundText
ELSE
	//added by dan so that the user can't continue typing an invalid string
	li_vkey = 8		//back space
 	keybd_event( li_vkey, 1, 0, 0 )
	keybd_event( li_vkey, 1, 0, 0 )
	this.post of_revertText( al_row, adwo_obj, as_found )
	//MessageBox("",idw_requestor.getText())
	//post keybd_event( 40, 1, 0, 0)
	//idw_requestor.post selectText(1 , len(idw_requestor.getText()) )
end if

return lb_matchFound
end event

private function integer of_reverttext (long al_row, dwobject adwo_obj, ref string as_found);//Created By Dan to replace the incorrectly typed text to the first text found by the findstring.
String	ls_newFind
String	ls_oldValue
String	ls_value

ls_oldValue = idw_requestor.getText()

ls_value = left( ls_oldValue, len( ls_oldValue ) - 1 )

IF len( ls_value ) > 0 THEN
	this.event ue_editChanged(al_row, adwo_obj, ls_value, as_found )
END IF

return 1
end function

on n_cst_dwsrv_dropdownsearch.create
call super::create
end on

on n_cst_dwsrv_dropdownsearch.destroy
call super::destroy
end on

