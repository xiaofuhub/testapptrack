$PBExportHeader$n_cst_dwsrv_find.sru
$PBExportComments$Extension DataWindow Find/Replace service
forward
global type n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
end type
end forward

global type n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
end type
global n_cst_dwsrv_find n_cst_dwsrv_find

forward prototypes
protected function string of_buildfindexpression (string as_find, string as_column)
protected function integer of_replace (long al_row, string as_colname, string as_replacewith)
protected function integer of_buildcolumnnames (boolean ab_replacelist)
public subroutine of_getdw (ref u_dw adw_data)
end prototypes

protected function string of_buildfindexpression (string as_find, string as_column);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_BuildFindExpression
//
//	Access:  		protected
//
//	Arguments: 		
//	as_find			String being searched for.
//	as_column		The column to search in.
//
//	Returns:  		string
//						String expression to use in search.
//						'!' if an error is encountered.
//
//	Description:  	This function build the string that is passed to the 
//						find function.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03 Handle searching of quotes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string	ls_findexp
string	ls_coltype
string	ls_editstyle
n_cst_string lnv_string

//Check arguments.
If IsNull(as_find) or Len(as_find)=0 or &
	IsNull(as_column) or Len(Trim(as_column))=0 Then
	Return '!'
End If

//Check required.
If IsNull(idw_requestor) Or Not IsValid(idw_requestor) Then
	Return '!'
end If

//Get the current column, columntype, and editstyle
ls_coltype = idw_requestor.describe(as_column+".ColType")
ls_editstyle = idw_requestor.Describe(as_column+".Edit.Style")

// Is CodeTable or DDLB is used
boolean lb_lookup = FALSE
string ls_codetable
ls_codetable = idw_requestor.Describe( as_column + ".Edit.CodeTable" )
if( Upper( ls_codetable ) = "YES" ) then 
	lb_lookup = TRUE
else
	ls_codetable = idw_requestor.Describe( as_column + ".DDLB.Case" )
	if( ls_codetable <> "?" and ls_codetable <> "!" ) then lb_lookup = TRUE
end if

//Create the string according to the column type and edit style.
If lb_lookup Then
	// Handle searching of quotes by replacing them with the special characters.
	If Pos(as_find, "'") > 0 Then
		as_find = lnv_string.of_GlobalReplace (as_find, "'", "~~'")
	End If	
	
	//Add the MatchCase attributes.
	if inv_findattrib.ib_matchcase THEN
		ls_findexp = "Pos(LookUpDisplay(" +as_column+ "),'" + as_find + "') > 0"
	else
		ls_findexp = "Pos(Lower(LookUpDisplay(" +as_column+ ")),'" +Lower(as_find)+ "') > 0"
	end if
Else
	//Process according to the column type.
	Choose Case Left(Lower(ls_coltype),4)
		Case 'numb', 'long', 'inte', 'deci'
			If IsNumber(as_find) Then
				ls_findexp = as_column+ " = " + as_find
			Else
				ls_findexp = "!"
			End If
		Case 'date'
			if Lower( ls_coltype ) = "datetime" then
				ls_findexp = as_column+ " = DateTime ('" + as_find + "')"
			else
				If IsDate(as_find) Then
					ls_findexp = as_column+ " = Date ('" + as_find + "')"
				Else
					ls_findexp = "!"
				End If			
			end if
		Case 'time'	
			If IsTime(as_find) Then
				ls_findexp = as_column+ " = Time ('" + as_find + "')"
			Else
				ls_findexp = "!"
			End If				
		Case Else
			// Handle searching of quotes by replacing them with the special characters.
			If Pos(as_find, "'") > 0 Then
				as_find = lnv_string.of_GlobalReplace (as_find, "'", "~~'")
			End If				
			
			//Add the MatchCase attributes.
			if inv_findattrib.ib_matchcase THEN
				ls_findexp = "Pos(" +as_column+ ",'" + as_find + "') > 0"
			else
				ls_findexp = "Pos(Lower(" +as_column+ "),'" +Lower(as_find)+ "') > 0"
			end if
	End Choose
End If

Return ls_findexp

end function

protected function integer of_replace (long al_row, string as_colname, string as_replacewith);string 	ls_selectedtext
string	ls_coltype
string	ls_find
integer	li_rc=0
integer	li_count, li_i
boolean 	lb_replacechars=False
integer	li_find_startpos
string	ls_editstyle
string	ls_maskedfind, ls_maskedfind_selectedtext
integer	li_maskedfind_textlen, li_maskedfind_startpos, li_maskedfind_selectedtextlen

//Get the current column, columntype, and editstyle
ls_coltype = idw_requestor.describe(as_colname+".ColType")
ls_editstyle = idw_requestor.Describe(as_colname+".Edit.Style")

// Is CodeTable or DDLB is used
boolean lb_lookup = FALSE
string ls_codetable
ls_codetable = idw_requestor.Describe( as_colname + ".Edit.CodeTable" )
if( Upper( ls_codetable ) = "YES" ) then 
	lb_lookup = TRUE
else
	ls_codetable = idw_requestor.Describe( as_colname + ".DDLB.Case" )
	if( ls_codetable <> "?" and ls_codetable <> "!" ) then lb_lookup = TRUE
end if

// Find data value corresponding to display value
if lb_lookup then
	n_cst_string lnv_string
	long ll_arraysize, ll_arrayindex, ll_delimpos
	string lsa_lookups[]
	ls_codetable = idw_requestor.Describe( as_colname + ".Values" )
	ll_arraysize = lnv_string.of_ParseToArray( ls_codetable, "/", lsa_lookups )
	for ll_arrayindex = 1 to ll_arraysize
		ll_delimpos = Pos( lsa_lookups[ll_arrayindex], "~t" )
		if ll_delimpos > 1 then
			if as_replacewith = Upper(Left( lsa_lookups[ll_arrayindex], ll_delimpos - 1 )) then
				as_replacewith = Mid( lsa_lookups[ll_arrayindex], ll_delimpos + 1 )
				exit
			end if
		end if
	next
end if

//Get the currently selected text.
ls_selectedtext = idw_requestor.SelectedText()

//Process according to the column type.
//Check that the ReplaceWith value is appropriate for the column type.
Choose Case Left(Lower(ls_coltype),4)
	Case 'numb', 'long', 'inte'
		If IsNumber(ls_selectedtext) and IsNumber(inv_findattrib.is_find) Then
			If Long(ls_selectedtext) = Long(inv_findattrib.is_find) Then
				If IsNumber(as_replacewith /*!*/) Then
					li_rc = idw_requestor.SetItem(al_row, as_colname, &
					 			Long(as_replacewith /*!*/))
				Else
					of_MessageBox ('pfc_find_replaceinvalidnumber', 'Replace', &
						'The Replace With value is not a valid number.', Information!, Ok!, 1)
					li_rc = -2
				End If										
			End If
		End If
		Return li_rc /* numb, long, inte */
		
	Case 'ulon'
		If IsNumber(ls_selectedtext) and IsNumber(inv_findattrib.is_find) Then
			If Long(ls_selectedtext) = Long(inv_findattrib.is_find) Then
				If IsNumber(as_replacewith /*!*/) Then
					If Long(as_replacewith /*!*/) > 0 Then
 						li_rc = idw_requestor.SetItem(al_row, as_colname, &
						 			Long(as_replacewith /*!*/))
					Else
						of_MessageBox ('pfc_find_replaceinvalidnumber', 'Replace', &
							'The Replace With value is not a valid number.', Information!, Ok!, 1)
						li_rc = -2
					End If														
				Else
					of_MessageBox ('pfc_find_replaceinvalidnumber', 'Replace', &
						'The Replace With value is not a valid number.', Information!, Ok!, 1)					
					li_rc = -2
				End If										
			End If
		End If	
		Return li_rc /* ulon */
		
	Case 'deci'
		If IsNumber(ls_selectedtext) and IsNumber(inv_findattrib.is_find) Then
			If Dec(ls_selectedtext) = Dec(inv_findattrib.is_find) Then
				If IsNumber(as_replacewith /*!*/) Then
					li_rc = idw_requestor.SetItem(al_row, as_colname, &
								Dec(as_replacewith /*!*/))
				Else
					of_MessageBox ('pfc_find_replaceinvalidnumber', 'Replace', &
						'The Replace With value is not a valid number.', Information!, Ok!, 1)					
					li_rc = -2
				End If									
			End If
		End If	
		Return li_rc /* Deci */
		
	Case 'date'
		if Lower(ls_coltype) = 'datetime' then
			// as_replace string must represent date (without spaces) or datetime with
			// one space. All other cases will be restricted.
			long ll_pos
			string ls_date, ls_time
			DateTime ldt_newval
			ll_pos = Pos( as_replacewith, " " )
			if ll_pos > 0 then
				// DateTime
				ls_date = Left( as_replacewith, ll_pos - 1 )
				ls_time = Mid( as_replacewith, ll_pos + 1 )
			else
				// Date
				ls_date = as_replacewith
				ls_time = "00:00:00"
			end if
			if IsDate( ls_date ) and IsTime( ls_time ) then
				// If both parts is valid
				ldt_newval = DateTime( Date( ls_date ), Time( ls_time ) )
				li_rc = idw_requestor.SetItem(al_row, as_colname, ldt_newval )
			else
				of_MessageBox ('pfc_find_replaceinvaliddate', 'Replace', &
					'The Replace With value is not a valid Date and Time.', Information!, Ok!, 1)					
				li_rc = -2
			end if
		else
			If IsDate(ls_selectedtext) and IsDate(inv_findattrib.is_find) Then
				If Date(ls_selectedtext) = Date(inv_findattrib.is_find) Then
					If IsDate(as_replacewith /*!*/) Then
						li_rc = idw_requestor.SetItem(al_row, as_colname, &
									Date(as_replacewith /*!*/))
					Else
						of_MessageBox ('pfc_find_replaceinvaliddate', 'Replace', &
							'The Replace With value is not a valid date.', Information!, Ok!, 1)					
						li_rc = -2
					End If								
				End If
			End If
		end if
		Return li_rc /* Date */
	Case 'time'	
		If IsTime(ls_selectedtext) and IsTime(inv_findattrib.is_find) Then
			If Time(ls_selectedtext) = Time(inv_findattrib.is_find) Then
				If IsTime(as_replacewith /*!*/) Then
					li_rc = idw_requestor.SetItem(al_row, as_colname, &
								Time(as_replacewith /*!*/))
				Else
					of_MessageBox ('pfc_find_replaceinvalidtime', 'Replace', &
						'The Replace With value is not a valid time.', Information!, Ok!, 1)					
					li_rc = -2
				End If								
			End If
		End If	
		Return li_rc /* Time */		
		
	Case 'char' 
		If of_Find(as_colname, inv_findattrib.is_find, al_row, al_row) = al_row Then
			//Get the entire string.
			ls_find = idw_requestor.GetItemString(al_row, as_colname)

			If (inv_findattrib.ib_matchcase) Then
				li_find_startpos = Pos(ls_find, inv_findattrib.is_find)
			Else
				li_find_startpos = Pos(Lower(ls_find),Lower(inv_findattrib.is_find))
			End If

			//Handle edimask fields.
			If ls_editstyle='editmask' Then
				//Check if the selected text matches the the "Find string".
				//Get "Masked Find"  and its appropriate length.
				ls_maskedfind = of_GetItem(al_row, as_colname)
				li_maskedfind_textlen = Len(ls_maskedfind)
				li_maskedfind_startpos = Pos (ls_maskedfind, ls_selectedtext)
				li_maskedfind_selectedtextlen = Len(ls_selectedtext)
				
				li_count = 1
				For li_i = 1 to li_maskedfind_textlen
					If Mid(ls_find, li_count, 1) =  Mid(ls_maskedfind, li_i, 1) Then
						If li_i >= li_maskedfind_startpos And &
							li_i <= li_maskedfind_startpos + (li_maskedfind_selectedtextlen -1) Then
							ls_maskedfind_selectedtext = ls_maskedfind_selectedtext + Mid(ls_find, li_count, 1)
						ElseIf li_i > li_maskedfind_startpos + (li_maskedfind_selectedtextlen -1) Then
								Exit
						End If
						li_count ++							
					End If
				Next 
				
				//Check if the selected text matches the the "Find string".					
				If (inv_findattrib.ib_matchcase And &
						ls_maskedfind_selectedtext = inv_findattrib.is_find) Or &
					(Not inv_findattrib.ib_matchcase And &
						Lower(ls_maskedfind_selectedtext) = Lower(inv_findattrib.is_find)) Then
					lb_replacechars = True
				End If
			Else
				//Check if the selected text matches the the "Find string".
				If (inv_findattrib.ib_matchcase And &
						ls_selectedtext = inv_findattrib.is_find) Or &
					(Not inv_findattrib.ib_matchcase And &
						Lower(ls_selectedtext) = Lower(inv_findattrib.is_find)) Then
					lb_replacechars = True
				End If
				if lb_lookup then lb_replacechars = True
			End If
				
			If lb_replacechars Then
				//Replace the "Find" characters with the "ReplaceWith" characters.
				ls_find = Replace(ls_find, li_find_startpos, Len(inv_findattrib.is_find), as_replacewith /*!*/)
				li_rc = idw_requestor.SetItem(al_row, as_colname, ls_find)
			End If
		End If
		Return li_rc /* Char */
		
	Case Else
		//Code should never reach this line.		
		Return -1
End Choose

//Code should never reach this line.
Return -1
end function

protected function integer of_buildcolumnnames (boolean ab_replacelist);integer	li_objects
integer	li_count=0
integer	li_i
string	ls_headernm
string	ls_obj_column[]
string	ls_oldlookdata
string	ls_oldfind
string	ls_oldreplacewith
string	ls_editstyle

//Check required.
If IsNull(idw_requestor) Or Not IsValid(idw_requestor) Then
	Return -1
end If

//Store the previous current look data (if any)
If inv_findattrib.ii_lookindex > 0 And &
	UpperBound(inv_findattrib.is_lookdata) >= inv_findattrib.ii_lookindex Then
	ls_oldlookdata = inv_findattrib.is_lookdata[inv_findattrib.ii_lookindex]
	ls_oldfind = inv_findattrib.is_find
	ls_oldreplacewith = inv_findattrib.is_replacewith
End If

//Reset the current index, find, and replace information.
inv_findattrib.ii_lookindex = 0
inv_findattrib.is_find = ''
inv_findattrib.is_replacewith = ''
inv_findattrib.is_lookdata = ls_obj_column[]
inv_findattrib.is_lookdisplay = ls_obj_column[]

//////////////////////////////////////////////////////////////////////////////
// populate string array for the user to select column from.
//////////////////////////////////////////////////////////////////////////////

//First get the Visible column names to use in search.
li_objects = of_GetObjects ( ls_obj_column, "column", "*", True )
	
//Get a list of all text objects associated with the column labels
FOR li_i=1 TO li_objects
	//Determine if the column is of unwanted type.
	ls_editstyle = idw_requestor.Describe(ls_obj_column[li_i]+".Edit.Style")
	If ls_editstyle='checkbox' or ls_editstyle='radiobuttons' Then
		Continue
	End If
	
	//If the list is being costructed for Replace then do not show 
	//DropDownDataWindow, DropDownListBoxes, Tab=0 Columns, or Display 
	//only columns.   Protected columns will still be 
	//shown since it could be a row dependendent.
	If ab_replacelist Then
		If ls_editstyle='dddw' or &
			ls_editstyle='ddlb' or &
			idw_requestor.Describe(ls_obj_column[li_i]+".TabSequence") = "0" or &
			idw_requestor.Describe(ls_obj_column[li_i]+".Edit.DisplayOnly") = "yes" Then
			Continue
		End If
	End If
	
	//Add the column name and column label to the array	
	li_count ++
// ches 1999-10-26 PFC DisplayColumnNameStyle BUG FIXING /////////////////////////////////////////////
	choose case ii_source
		case DEFAULT
			inv_findattrib.is_lookdata[li_count] = ls_obj_column[li_i]
			inv_findattrib.is_lookdisplay[li_count] = ls_obj_column[li_i]
		case DBNAME
			inv_findattrib.is_lookdata[li_count] = ls_obj_column[li_i]
			inv_findattrib.is_lookdisplay[li_count] = idw_requestor.Describe(ls_obj_column[li_i]+".DBName")
		case HEADER
			ls_headernm= of_GetHeaderName ( ls_obj_column[li_i] )
			inv_findattrib.is_lookdata[li_count] = ls_obj_column[li_i]
			inv_findattrib.is_lookdisplay[li_count] = ls_headernm
	end choose
// ches 1999-10-26 PFC DisplayColumnNameStyle BUG FIXING /////////////////////////////////////////////	

	//Reset the Index value (if any)
	If ls_oldlookdata = inv_findattrib.is_lookdata[li_count] Then
		inv_findattrib.ii_lookindex = li_count
		inv_findattrib.is_find = ls_oldfind
		inv_findattrib.is_replacewith = ls_oldreplacewith	
	End If
NEXT

Return li_count
end function

public subroutine of_getdw (ref u_dw adw_data);adw_data = idw_requestor
end subroutine

on n_cst_dwsrv_find.create
TriggerEvent( this, "constructor" )
end on

on n_cst_dwsrv_find.destroy
TriggerEvent( this, "destructor" )
end on

