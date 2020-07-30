$PBExportHeader$w_sortmulti.srw
$PBExportComments$Extension DDLB-style Sort dialog window
forward
global type w_sortmulti from pfc_w_sortmulti
end type
end forward

global type w_sortmulti from pfc_w_sortmulti
end type
global w_sortmulti w_sortmulti

forward prototypes
public function string of_buildsortstring ()
end prototypes

public function string of_buildsortstring ();string 	ls_asc_desc, ls_sort_expr, ls_colname
int 		li_i, li_rcount, li_found_row

li_rcount = dw_sort.RowCount ( )

FOR li_i = 1 to li_rcount
	ls_asc_desc = dw_sort.GetItemString ( li_i,"sort_order")
	li_found_row = idwc_cols.Find ( 'display_column = "' + dw_sort.GetItemString(li_i,"display_column") + '"', &
								1, idwc_cols.RowCount () )
	IF li_found_row > 0 THEN 
		ls_colname = idwc_cols.GetItemString ( li_found_row, "columnname" ) 
// ches ///////////////////////////////////////////////////////////////////////
	else
		ls_colname = ""
// ches ///////////////////////////////////////////////////////////////////////
	END IF 
	
	IF Trim(ls_colname) <> "" THEN
		IF idwc_cols.GetItemString ( li_found_row, "use_display" ) = "1" THEN 
			ls_sort_expr = ls_sort_expr + "LookUpDisplay(" + ls_colname + ") " + &
								ls_asc_desc + " "
		ELSE 
			ls_sort_expr = ls_sort_expr + ls_colname + " " + ls_asc_desc + " "
		END IF 
	END IF
NEXT

Return Trim ( ls_sort_expr )
end function

on w_sortmulti.create
call super::create
end on

on w_sortmulti.destroy
call super::destroy
end on

event pfc_postopen;integer 	li_num_cols, li_found, li_i
integer 	li_numcols_sort, li_newrow
Integer	li_rc
string 	ls_display

SetPointer ( HourGlass! ) 

// Turn off re-drawing until all done.
dw_sort.SetReDraw (FALSE)

// Get dddw reference.
dw_sort.GetChild ( "display_column", idwc_cols ) 

// Populate the dropdownlistbox with column names.
li_numcols_sort = UpperBound ( inv_sortattrib.is_sortcolumns ) 
FOR li_i = 1 to li_numcols_sort
	// Insert a new row
	li_newrow = idwc_cols.InsertRow ( 0 ) 
	// Populate the attributes for the column.	
	idwc_cols.SetItem ( li_newrow, "columnname", inv_sortattrib.is_sortcolumns[li_i] ) 
	idwc_cols.SetItem ( li_newrow, "display_column", inv_sortattrib.is_colnamedisplay[li_i] ) 
	IF inv_sortattrib.ib_usedisplay[li_i] THEN
		li_rc = idwc_cols.SetItem ( li_newrow, "use_display", "1" ) 
	ELSE
		li_rc = idwc_cols.SetItem ( li_newrow, "use_display", "0" ) 
	END IF 
NEXT

// Add rows for the current sort. One row for each column.
li_num_cols = UpperBound ( inv_sortattrib.is_origcolumns ) 
FOR li_i = 1 to li_num_cols
	li_found = idwc_cols.Find ( "columnname = '" + inv_sortattrib.is_origcolumns[li_i] + &
									    "'", 1, idwc_cols.RowCount () ) 
	IF li_found > 0 THEN
		// Insert a new row.
		li_newrow = dw_sort.InsertRow (0) 		
		// Set the column		
		ls_display = idwc_cols.GetItemString (li_found, "display_column" ) 
		li_rc = dw_sort.SetItem ( li_newrow, "display_column", ls_display ) 
		// Check the Asc/Desc sort order column		
		li_rc = dw_sort.SetItem ( li_newrow, "sort_order", inv_sortattrib.is_origorder[li_i] ) 
	END IF 
NEXT 

// Make sure there is at least one empty row.
If dw_sort.RowCount() = 0 Then
	// Insert a new row.
	li_newrow = dw_sort.InsertRow (0)
End If

// Set sorting
idwc_cols.SetSort( "display_column A" )
idwc_cols.Sort( )

// Turn off re-drawing until all done.
dw_sort.SetReDraw (TRUE)

end event

type cb_cancel from pfc_w_sortmulti`cb_cancel within w_sortmulti
boolean BringToTop=true
end type

