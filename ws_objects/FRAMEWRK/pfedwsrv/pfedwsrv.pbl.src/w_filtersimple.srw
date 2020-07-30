$PBExportHeader$w_filtersimple.srw
$PBExportComments$Extension Simple-Style Filter dialog window
forward
global type w_filtersimple from pfc_w_filtersimple
end type
type cb_check from commandbutton within w_filtersimple
end type
end forward

global type w_filtersimple from pfc_w_filtersimple
integer x = 214
integer y = 221
cb_check cb_check
end type
global w_filtersimple w_filtersimple

type variables
boolean ib_manual = FALSE
end variables

forward prototypes
public subroutine of_getvalues (string as_column)
public function boolean of_checkfilter (string as_filter)
end prototypes

public subroutine of_getvalues (string as_column);integer li_selectedrow
n_cst_string lnv_string

// Populate values based on current column
SetPointer( HourGlass! )		

// Get source column type
string ls_coltype
ls_coltype = inv_filterattrib.idw_dw.Describe( as_column + ".Coltype" )
if ls_coltype = "?" or ls_coltype = "!" then 
	MessageBox( "Error", "Cannot detect column type", StopSign! )
	return
end if

// If type is CHAR without length ( case of calculated column )
if Lower(ls_coltype) = "char" then ls_coltype = "char(255)"

// Get source column format
string ls_format
ls_format = inv_filterattrib.idw_dw.Describe( as_column + ".Format" )
// there seems to be an issue with date formats of mm/dd. PB evaluates the value as mm/dd/yy
// even though it is displayed as mm/dd.
if ls_format = "?" or ls_format = "!" or ls_format = "" or ls_format = "mm/dd" then ls_format = "[general]"


// Set appropriate expression for 'value' column
string ls_val_expr
Choose Case Left( ls_coltype, 5 )
	// CHARACTER DATATYPE		
	Case "char("	
		ls_val_expr = "initial_value"
	// DATE DATATYPE	
	Case "date"
		ls_val_expr = "string(Date(initial_value),'" + ls_format + "')"
	// DATETIME DATATYPE
	Case "datet"				
		ls_val_expr = "string(DateTime(initial_value),'" + ls_format + "')"
	// TIME DATATYPE
	Case "time", "times"		
		ls_val_expr = "string(Time(initial_value),'" + ls_format + "')"
	// NUMBER
	Case 	Else
		ls_val_expr = "string(Number(initial_value),'" + ls_format + "')"
End Choose

// Add additional information column if initial column use 
string ls_codetable
boolean lb_lookup = FALSE
// Is CodeTable is used
ls_codetable = inv_filterattrib.idw_dw.Describe( as_column + ".Edit.CodeTable" )
if( Upper( ls_codetable ) = "YES" ) then 
	lb_lookup = TRUE
else
	ls_codetable = inv_filterattrib.idw_dw.Describe( as_column + ".DDLB.Case" )
	if( ls_codetable <> "?" and ls_codetable <> "!" ) then lb_lookup = TRUE
end if

if lb_lookup then
	// Create complex calculate expression
	ls_codetable = inv_filterattrib.idw_dw.Describe( as_column + ".Values" )
	string lsa_lookups[], ls_calcexpr
	long ll_arraysize, ll_arrayindex, ll_delimpos
	ll_arraysize = lnv_string.of_ParseToArray( ls_codetable, "/", lsa_lookups )
	for ll_arrayindex = 1 to ll_arraysize
		ll_delimpos = Pos( lsa_lookups[ll_arrayindex], "~t" )
		if ll_delimpos > 1 then
			ls_calcexpr += "if(initial_value='" + Mid( lsa_lookups[ll_arrayindex], ll_delimpos + 1 ) + &
			+ "','" + Left( lsa_lookups[ll_arrayindex], ll_delimpos - 1 ) + "'" + ","
		else
			ls_calcexpr += "if(IsNull(initial_value),'" + Left( lsa_lookups[ll_arrayindex], ll_delimpos - 1 ) + "',"
		end if
	next
	ls_calcexpr = Left( ls_calcexpr, Len(ls_calcexpr) - 1 )
	ls_calcexpr += ",''"
	ls_calcexpr += Fill( ")", ll_arrayindex - 1 )
end if

// Get column number for given column name
long ll_index, ll_count, ll_colnumber
ll_count = Long( inv_filterattrib.idw_dw.Describe( "DataWindow.Column.Count" ) )
for ll_index = 1 to ll_count
	if inv_filterattrib.idw_dw.Describe( "#" + string( ll_index ) + ".Name" ) = as_column then
		ll_colnumber = ll_index
		exit
	end if
next

// Only if ll_colnumner > 0 ( calculated columns doesn't exists in standard set of columns )
// Another reason - calculated columns is prepared only for visible part of DW
if ll_colnumber > 0 then
	
	// Rearrange DDDW
	decimal value_x, value_width, lookup_x, lookup_width
	value_x = Dec( idwc_values.Describe( "value.X" ) )
	lookup_x = Dec( idwc_values.Describe( "lookup.X" ) )
	string ls_modify, ls_err
	if lb_lookup then
		if lookup_x > value_x then
			value_width = Dec( idwc_values.Describe( "value.Width" ) )
			lookup_width = Dec( idwc_values.Describe( "lookup.Width" ) )
			ls_modify = " lookup.X='" + string(value_x) + "' lookup.Width='" + string(value_width) + &
				"' value.X='" + string(lookup_x) + "' value.Width='" + string(lookup_width) + "' "
		end if
		ls_modify += "lookup.Expression=~"" + ls_calcexpr + "~" lookup.Visible='1' " + &
			"value.Expression=~"" + ls_val_expr + "~" value.Y='0'"
		ls_err = idwc_values.Modify( ls_modify )
	else
		if value_x > lookup_x then
			value_width = Dec( idwc_values.Describe( "value.Width" ) )
			lookup_width = Dec( idwc_values.Describe( "lookup.Width" ) )
			ls_modify = " lookup.X='" + string(value_x) + "' lookup.Width='" + string(value_width) + &
				"' value.X='" + string(lookup_x) + "' value.Width='" + string(lookup_width) + "' "
		end if
		ls_modify += "value.Expression=~"" + ls_val_expr + "~" lookup.Visible='0' "
		ls_err = idwc_values.Modify( ls_modify )
	end if

	// Make a full copy of initial column data
	DataStore lds_data
	lds_data = Create DataStore
	string ls_syntax
	ls_syntax = inv_filterattrib.idw_dw.Describe( "DataWindow.Syntax" )
	lds_data.Create( ls_syntax )
	inv_filterattrib.idw_dw.RowsCopy( 1, inv_filterattrib.idw_dw.RowCount(), Primary!, lds_data, 1, Primary! )
	inv_filterattrib.idw_dw.RowsCopy( 1, inv_filterattrib.idw_dw.FilteredCount(), Filter!, lds_data, 1, Primary! )

	// Copy data into Child DW
	idwc_values.Reset()
	string ls_buffer
	ls_buffer = lds_data.Describe( "DataWindow.Data" )
	idwc_values.ImportString( ls_buffer, 1, lds_data.RowCount( ), ll_colnumber, ll_colnumber, 1 )
	Destroy lds_data

	// Remove all records with NULL values
	idwc_values.SetFilter( "IsNull(value) or value=''" );
	idwc_values.Filter( );
	idwc_values.RowsDiscard( 1, idwc_values.RowCount(), Primary! )
	idwc_values.SetFilter( "" );
	idwc_values.Filter( );
	
	// Remove duplicated values
	idwc_values.SetSort( "value A" );
	idwc_values.SetFilter( "GetRow( ) = 1 or initial_value <> initial_value[-1]" )
	idwc_values.Sort( )
	idwc_values.Filter( )
	
	// Set width of DDDW
	if lb_lookup then
		dw_filter.Modify( "colvalue.DDDW.PercentWidth=150" )
	else
		dw_filter.Modify( "colvalue.DDDW.PercentWidth=100" )
	end if

end if

end subroutine

public function boolean of_checkfilter (string as_filter);DataStore lds_test
integer li_rc
// Determine if the Filter Test is needed.
If Len(as_filter) > 0 Then
	// Create the Test-filter datastore.
	lds_test = CREATE n_ds
	lds_test.DataObject = inv_filterattrib.idw_dw.DataObject
	// Test the new filter.
	li_rc = lds_test.SetFilter(as_filter)
	// Destroy the Test-filter datastore.
	Destroy lds_test
	// Check if the Test of the new filter failed.
	If li_rc <> 1 Then
		// Test of the new filter failed.  Do not allow the window to close via the OK.
		of_MessageBox('pfc_filtersimple_failedfilter',this.Title,'Invalid Filter.', &
			Information!, OK!, 1)
		Return FALSE
	End If
End If
return TRUE

end function

on w_filtersimple.create
int iCurrent
call super::create
this.cb_check=create cb_check
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_check
end on

on w_filtersimple.destroy
call super::destroy
destroy(this.cb_check)
end on

event pfc_postopen;integer 	li_newrow, li_numcols, li_i, li_rc
string	ls_filter
n_cst_string lnv_string

// Turn off re-drawing until all done.
dw_filter.SetReDraw (FALSE)

// Make the original filter visible.
ls_filter = inv_filterattrib.is_filter
If Pos(ls_filter, "~~~~'") > 0 And  Pos(ls_filter, "~~~~~~'") = 0 Then
	ls_filter = lnv_string.of_GlobalReplace(ls_filter, "~~~~'", "~~'")	
End If
mle_originalfilter.text = ls_filter

// Insert a new row.
li_newrow = dw_filter.Event pfc_AddRow()

// Get the Column Name childdatawindow reference.
li_rc = dw_filter.GetChild ( "colname", idwc_cols ) 

// Get the Column Value childdatawindow reference.
li_rc = dw_filter.GetChild ( "colvalue", idwc_values ) 

// Populate the childdatawidow column with the column names.
li_numcols = UpperBound ( inv_filterattrib.is_columns ) 
FOR li_i = 1 to li_numcols
	// Insert new row.
	li_newrow = idwc_cols.InsertRow ( 0 ) 

	// Populate the values for the new row.
	idwc_cols.SetItem ( li_newrow, "columnname", inv_filterattrib.is_columns[li_i] )
 	idwc_cols.SetItem ( li_newrow, "display_column", inv_filterattrib.is_colnamedisplay[li_i] ) 
NEXT

// Add sorting
idwc_cols.SetSort( "display_column A" )
idwc_cols.Sort( )

// Turn off re-drawing until all done.
dw_filter.SetReDraw (TRUE)
end event

event pfc_default;string		ls_testfilter
integer		li_rc=1
datastore	lds_test

// Get the new filter.
if ib_manual then
	// If filter is corrected manually
	ls_testfilter = mle_originalfilter.Text
else
	// If filter is not corrected
	ls_testfilter = of_BuildfilterString()
end if

// Determine if the Filter Test is needed.
If Len(ls_testfilter) > 0 Then
	// Create the Test-filter datastore.
	lds_test = CREATE n_ds

	// Associate the correct DataObject to the Test-filter datastore.
	lds_test.DataObject = inv_filterattrib.idw_dw.DataObject

	// Test the new filter.
	li_rc = lds_test.SetFilter(ls_testfilter)

	// Destroy the Test-filter datastore.
	Destroy lds_test

	// Check if the Test of the new filter failed.
	If li_rc <> 1 Then
		// Test of the new filter failed.  Do not allow the window to close via the OK.
		of_MessageBox('pfc_filtersimple_failedfilter',this.Title,'Invalid Filter.', &
			Information!, OK!, 1)
		Return 
	End If
End If

// A Test the filter was not needed or the Test was successful.

// Set the return code to mean succesful operation.
inv_return.ii_rc = 1

// Set the new sort string.
inv_return.is_rs = ls_testfilter

// Close the window.
CloseWithReturn ( this, inv_return )

end event

type cb_help from pfc_w_filtersimple`cb_help within w_filtersimple
end type

type cb_delete from pfc_w_filtersimple`cb_delete within w_filtersimple
end type

type cb_cancel from pfc_w_filtersimple`cb_cancel within w_filtersimple
integer taborder = 70
end type

type dw_filter from pfc_w_filtersimple`dw_filter within w_filtersimple
string dataobject = "d_filtersimple_mod"
end type

event dw_filter::itemchanged;call super::itemchanged;if( dwo.Name = "colname" ) then
	this.SetItem( row, "colvalue", "" )
end if
// Detect if filter expression is really changed
string ls_compare
ls_compare = mle_originalfilter.Text
mle_originalfilter.Text = of_buildfilterstring( )
if ls_compare <> mle_originalfilter.Text then ib_manual = FALSE

end event

type mle_originalfilter from pfc_w_filtersimple`mle_originalfilter within w_filtersimple
integer width = 1888
integer taborder = 40
fontcharset fontcharset = ansi!
long backcolor = 1090519039
boolean border = true
boolean displayonly = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event mle_originalfilter::modified;ib_manual = TRUE
end event

type gb_originalfilter from pfc_w_filtersimple`gb_originalfilter within w_filtersimple
string text = "Filter Expression"
end type

type cb_add from pfc_w_filtersimple`cb_add within w_filtersimple
end type

type gb_newfilter from pfc_w_filtersimple`gb_newfilter within w_filtersimple
end type

type cb_ok from pfc_w_filtersimple`cb_ok within w_filtersimple
integer taborder = 60
end type

type cb_dlghelp from pfc_w_filtersimple`cb_dlghelp within w_filtersimple
integer taborder = 80
end type

type cb_check from commandbutton within w_filtersimple
integer x = 2062
integer y = 64
integer width = 352
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Check"
end type

event clicked;if of_CheckFilter( mle_originalfilter.Text ) then MessageBox( "Check Filter", "Filter expression is OK." )
end event

