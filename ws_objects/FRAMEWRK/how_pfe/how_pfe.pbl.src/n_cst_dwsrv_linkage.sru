$PBExportHeader$n_cst_dwsrv_linkage.sru
$PBExportComments$Extension DataWindow Linkage service
forward
global type n_cst_dwsrv_linkage from task_n_cst_dwsrv_linkage
end type
end forward

global type n_cst_dwsrv_linkage from task_n_cst_dwsrv_linkage
end type
global n_cst_dwsrv_linkage n_cst_dwsrv_linkage

type variables
long 	il_linkId
end variables

forward prototypes
public function integer of_setmaster (u_dw adw_master, long al_linkid)
public function long of_getlinkid ()
public function any of_buildexpression (long al_row, string as_column, string as_operator, string as_optionalvalue)
end prototypes

public function integer of_setmaster (u_dw adw_master, long al_linkid);/***************************************************************************************
NAME: 			of_setMaster

ACCESS:			Public
		
ARGUMENTS: 		
							adw_master: the master u_dw of the datawindow that has this service.
							al_linkId:	the id of the link that is only set if this is a detail.

RETURNS:			1 success
					-1 failure
	
DESCRIPTION:	Overloaded function that calls the one argument version, and if that one 
					succeeds then it is ok to set the link id so long as it is valid. 
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :Created By Dan	9-2-2005
	

***************************************************************************************/

IF this.of_setMaster(adw_master) = 1 AND not ISNULL(al_linkID) THEN
	il_linkId = al_linkID
	
	return 1
	
ELSE
	return -1
END IF
end function

public function long of_getlinkid ();return il_linkId
end function

public function any of_buildexpression (long al_row, string as_column, string as_operator, string as_optionalvalue);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_BuildExpression
//
//	Access:    Public
//
//	Arguments:
//   al_row			   : The row reference
//   as_column    	: The column name reference
//	  as_operator		: The desired operator.
//								"="	Equals	
//								">"	Greater than	
//								"<"	Less than	
//								"<>"	Not equal	
//								">="	Greater than or equal	
//								"<="	Less than or equal	
//	  as_optionalvalue: An optional value.  If found it will not used the
//							  row/column value.
//
//	Returns:  Any
//	  The column value cast to an any datatype
//
//	Description:  
//	Returns a complete expression string that can be used on any Find or 
//	Filter operation.  
//	For example, 'hired_date > Date("1/1/95")' will be the result for 
//	as_column='hired_date', as_operator='>', as_optionalvalue='1/1/95'.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_expression
string	ls_coltype
string	ls_value

n_cst_string lnv_string

// Verify passed arguments.
If IsNull(idw_requestor) Or Not IsValid(idw_requestor) Then Return '!'
If as_optionalvalue = '#@notapplicable@#' Then
	// Only test row number when there is no optional value.
	If IsNull(al_row) or al_row <= 0 or al_row > idw_requestor.RowCount() Then Return '!'
End If
If Len(Trim(as_column))=0 or IsNull(as_column) Then Return '!'
If as_operator='=' or as_operator='>' or as_operator='<' or as_operator='<>' or &
	as_operator='>=' or as_operator='<=' Then
	// Good value.
Else
	Return '!'
End If

// Get the column type.
ls_coltype = idw_requestor.Describe(as_column+'.ColType')
If ls_coltype='!' or ls_coltype='?' Then Return '!'

// Either get the current value or use the passed in value.
If as_optionalvalue = '#@notapplicable@#' Then
	ls_value = string( of_GetItemAny(al_row, as_column) )
Else
	ls_value = as_optionalvalue
End If

If IsNull(ls_value) Then
	//-- Build NULL value expressions. --
	If as_operator='=' Then
		ls_expression = 'IsNull('+as_column+')'
	ElseIf as_operator='<>' Then
		ls_expression = 'Not IsNull('+as_column+')'		
	Else
		ls_expression = '!'
	End If
Else
	//-- Build NonNull value expressions. --

	// Start building the Find/Filter expression.
	ls_expression = as_column + ' ' + as_operator + ' '

	// Wrap the value with datatype conversion functions, so that
	// the value is valid in Filter and Find expressions.
	//	Note: a number value does not need any special handling.
	Choose Case Lower ( Left (ls_coltype, 5 ) )
		
		// CHARACTER DATATYPE		
		Case "char("	
			
			/******Added Enhancement - Maury 3/31/06********************/
			/*Replaced single quotes with special chars single to avoid*/
			/*invalid expression on columns that may have single quotes*/
			
			If Pos(ls_value, '~~~"') =0 And Pos(ls_value, "~~~'") =0 Then
				// No special characters found.
				If Pos(ls_value, "'") >0 Then
					// Replace single quotes with special chars single quotes.
					ls_value = lnv_string.of_GlobalReplace(ls_value, "'", "~~~'")				
				End If
			End If
			
			/******End Added Enhancement***********/
			
			ls_expression += "'" + ls_value + "'"

		// DATE DATATYPE	
		Case "date"					
			ls_expression += "Date('" + ls_value  + "')" 

		// DATETIME DATATYPE
		Case "datet"				
			ls_expression += "DateTime('" + ls_value + "')" 

		// TIME DATATYPE
		Case "time", "times"		
			ls_expression += "Time('" + ls_value + "')" 
	
		// Number
		Case 	Else
			ls_expression += ls_value

	End Choose
End If

Return ls_expression
end function

on n_cst_dwsrv_linkage.create
call super::create
end on

on n_cst_dwsrv_linkage.destroy
call super::destroy
end on

