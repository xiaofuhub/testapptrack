$PBExportHeader$n_cst_dssrv.sru
$PBExportComments$Extension Datastore Base service
forward
global type n_cst_dssrv from pfc_n_cst_dssrv
end type
end forward

global type n_cst_dssrv from pfc_n_cst_dssrv
end type
global n_cst_dssrv n_cst_dssrv

forward prototypes
public function integer of_setitem (long al_row, string as_column, string as_value)
public function long of_primarymodifiedcount ()
public function integer of_getupdateablecolumns (ref string asa_updateablecols[])
public function integer of_getkeycolumns (ref string asa_keycols[])
end prototypes

public function integer of_setitem (long al_row, string as_column, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:		OVERRIDE of_SetItem (FORMAT 2) for bug fix  (Vladimir)
//
//	Access:			Public
//
//	Arguments:
//   al_row		:  The row reference for the value to be set
//   as_column :  The column name reference
//   as_value  :  The value of the column in string format
//
//	Returns:		  Integer
//						1 = if it succeeds
//					 -1 = if an error occurs
//
//	Description:	  Sets the specified row/column to the passed value.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem with datetime columns being set to invalid datetime values
//		Added error checking for arguments.
// 5.0.04 Fixed where number and real datatype was being converted into a long.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer	li_rc
date		ld_val
decimal	ldc_val
double	ldb_val
long		ll_val
real		lr_val
string		ls_string_value
time		ltm_val
n_cst_string	lnv_string
n_cst_conversion	lnv_conversion

// Check arguments
if IsNull (al_row) or IsNull (as_column) then
	return -1
end if

if IsNull (ids_requestor) or not IsValid (ids_requestor) then
	return -1
end if

// ********** get the current decimal delimited symbol from LOCALE *********
// ********** it's need to walk around the PFC bug *************************
// ***********	   Vladimir Chesnokov			*************************
string ls_triple_delim
if Pos( string( 1.1 ), "," ) > 0 then
	ls_triple_delim = " "
else
	ls_triple_delim = ","
end if
// *************************************************************************

/*  Determine the datatype of the column and then call the SetItem
	 with proper datatype */

CHOOSE CASE Lower ( Left ( ids_requestor.Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char("		//  CHARACTER DATATYPE
			li_rc = ids_requestor.SetItem ( al_row, as_column, as_value )

		CASE "date"			//  DATE DATATYPE
			li_rc = ids_requestor.SetItem ( al_row, as_column, Date (as_value) )

		CASE "datet"		//  DATETIME DATATYPE

			ld_val = lnv_conversion.of_Date (as_value)
			ltm_val = lnv_conversion.of_Time (as_value)
			li_rc = ids_requestor.SetItem (al_row, as_column, DateTime (ld_val, ltm_val))

		CASE "decim"		//  DECIMAL DATATYPE
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ls_triple_delim, "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ldc_val = Dec (ls_string_value) / 100
			else
				ldc_val = Dec (ls_string_value)
			end if

			li_rc = ids_requestor.SetItem ( al_row, as_column, ldc_val)

		CASE "numbe", "doubl"			//  NUMBER DATATYPE
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ls_triple_delim, "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ldb_val = Double (ls_string_value) / 100
			else
				ldb_val = Double (ls_string_value)
			end if

			li_rc = ids_Requestor.SetItem ( al_row, as_column, ldb_val)

		CASE "real"				//  REAL DATATYPE
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ls_triple_delim, "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				lr_val = Real (ls_string_value) / 100
			else
				lr_val = Real (ls_string_value)
			end if

			li_rc = ids_Requestor.SetItem ( al_row, as_column, lr_val)

		CASE "long", "ulong"		//  NUMBER DATATYPE
			/*  Replace formatting characters in passed string */
			ls_string_value = lnv_string.of_GlobalReplace (as_value, "$", "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ls_triple_delim, "" )
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "(", "-")
			ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, ")", "")
			if Pos (ls_string_value, "%") > 0 then
				ls_string_value = lnv_string.of_GlobalReplace (ls_string_value, "%", "")
				ll_val = Long (ls_string_value) / 100
			else
				ll_val = Long (ls_string_value)
			end if

			li_rc = ids_requestor.SetItem ( al_row, as_column, ll_val)

		CASE "time", "times"		//  TIME DATATYPE
			li_rc = ids_requestor.SetItem ( al_row, as_column, Time ( as_value ) )


END CHOOSE

Return li_rc
end function

public function long of_primarymodifiedcount ();/***************************************************************************************
NAME: of_primarymodifiedcount

ACCESS:	Public
		
ARGUMENTS: 		(None)

RETURNS:			Long
	
DESCRIPTION:
		Returns the modified count in the Primary buffer
		
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created: 1/16/06 - Maury

***************************************************************************************/

Long	i
Long	ll_NumRows
Long	ll_Count = 0

ll_NumRows = ids_Requestor.RowCount()

FOR i = 1 TO ll_NumRows
		
	IF ids_Requestor.GetItemStatus(i, 0, Primary!) = DataModified! THEN
		ll_Count ++
	END IF

NEXT


Return ll_Count
end function

public function integer of_getupdateablecolumns (ref string asa_updateablecols[]);/***************************************************************************************
NAME: of_GetUpdateableColumns

ACCESS:	Public
		
ARGUMENTS: 		( ref string asa_updateablecols[] )

RETURNS:			integer
	
DESCRIPTION:
		Passes out updateable columns by ref
		
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created: 2/14/06 - Maury

***************************************************************************************/
Integer	li_Return = 1
Long		i, ll_NumCols
String	ls_ColName
String	lsa_UpdateableCols[]

string	ls_update

IF isValid(ids_requestor) THEN
	ll_NumCols = Long(ids_Requestor.Object.DataWindow.Column.Count)
	FOR i = 1 TO ll_NumCols
		ls_ColName =  ids_Requestor.Describe("#" + String(i) + ".Name")
		ls_update = ids_Requestor.Describe(ls_ColName + ".Update")
		IF ids_Requestor.Describe(ls_ColName + ".Update") = "yes" THEN
			lsa_UpdateableCols[Upperbound(lsa_Updateablecols[]) + 1] = ls_ColName
		END IF
	NEXT
	asa_UpdateableCols[] = lsa_UpdateableCols[]
ELSE
	li_Return = -1
END IF

Return li_Return
end function

public function integer of_getkeycolumns (ref string asa_keycols[]);/***************************************************************************************
NAME: of_GetKeyColumns

ACCESS:	Public
		
ARGUMENTS: 		( ref string asa_KeyCols[] )

RETURNS:			integer
	
DESCRIPTION:
		Passes out Key columns by ref
		
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created: 2/14/06 - Maury

***************************************************************************************/
Integer	li_Return = 1
Long		i, ll_NumCols
String	ls_ColName
String	lsa_KeyCols[]

IF isValid(ids_requestor) THEN
	ll_NumCols = Long(ids_Requestor.Object.DataWindow.Column.Count)
	FOR i = 1 TO ll_NumCols
		ls_ColName =  ids_Requestor.Describe("#" + String(i) + ".Name")
		IF ids_Requestor.Describe(ls_ColName + ".Key") = "yes" THEN
			lsa_KeyCols[Upperbound(lsa_KeyCols[]) + 1] = ls_ColName
		END IF
	NEXT
	asa_KeyCols[] = lsa_KeyCols[]
ELSE
	li_Return = -1
END IF

Return li_Return
end function

on n_cst_dssrv.create
call super::create
end on

on n_cst_dssrv.destroy
call super::destroy
end on

