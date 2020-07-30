$PBExportHeader$w_filterextended.srw
$PBExportComments$Extension Extended Filter dialog window
forward
global type w_filterextended from pfc_w_filterextended
end type
end forward

global type w_filterextended from pfc_w_filterextended
end type
global w_filterextended w_filterextended

on w_filterextended.create
call super::create
end on

on w_filterextended.destroy
call super::destroy
end on

event open;call super::open;// Add sorting
tab_1.tabpg_columns.dw_columns.SetSort( "display_name A" )
tab_1.tabpg_columns.dw_columns.Sort()



end event

type tab_1 from pfc_w_filterextended`tab_1 within w_filterextended
boolean BringToTop=true
end type

event tab_1::selectionchanged;integer	li_selectedrow
string		ls_col
n_cst_string	lnv_string

// Check for values tabpage
if newindex <> 4 then
	return
end if	

// Populate values based on current column
li_selectedrow = this.tabpg_columns.dw_columns.GetSelectedRow (0)
if li_selectedrow > 0 then
	ls_col = this.tabpg_columns.dw_columns.object.columnname[li_selectedrow]
	if ls_col <> is_currentcolumn then
		SetPointer( HourGlass! )		
		// Get source column type
		string ls_coltype
		ls_coltype = inv_filterattrib.idw_dw.Describe( ls_col + ".Coltype" )
		if ls_coltype = "?" or ls_coltype = "!" then 
			MessageBox( "Error", "Cannot detect column type", StopSign! )
			return
		end if
		// If type is CHAR without length ( case of calculated column )
		if Lower(ls_coltype) = "char" then ls_coltype = "char(255)"
		
		// Get source column format
		string ls_format
		ls_format = inv_filterattrib.idw_dw.Describe( ls_col + ".Format" )
		if ls_format = "?" or ls_format = "!" or ls_format = "" then ls_format = "[general]"

		// Get column title
		string ls_coltitle
		ls_coltitle = this.tabpg_columns.dw_columns.object.display_name[li_selectedrow]
		
		// Create appropriate DW
		string ls_newdwsyntax, ls_error
		this.tabpg_values.dw_values.SetRedraw( FALSE )
		this.tabpg_values.dw_values.Visible = FALSE
		ls_newdwsyntax = "release 6; " + &
			"datawindow(units=0 timer_interval=0 color=1090519039 processing=0 ) " + &
			"header(height=64 color='536870912' ) " + &
			"summary(height=4 color='536870912' ) " + &
			"footer(height=0 color='536870912' ) " + &
			"detail(height=60 color='553648127' ) " + &
			"table(column=(type=" + ls_coltype + " updatewhereclause=no name=vals dbname='vals' ) " + &
			"filter='GetRow( ) = 1 or vals <> vals[-1]'  sort='vals A ' ) " + &
			"text(band=header alignment='2' text='" + ls_coltitle + "'border='0' color='33554432' x='5' y='8'  " + &
			"height='52' width='901'  name=vals_t  font.face='MS Sans Serif' font.height='-8'  " + &
			"font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2'  " + &
			"background.color='1090519039' ) " + &
			"column(band=detail id=1 alignment='0' tabsequence=32766 border='0' color='33554432' x='5'  " + &
			"y='4' height='52' width='901' format='" + ls_format + "'  name=values edit.limit=0 edit.case=any  " + &
			"edit.focusrectangle=no edit.autoselect=no  font.face='MS Sans Serif' font.height='-8'  " + &
			"font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='2'  " + &
			"background.color='1090519039' ) " + &
			"htmltable(border='1' cellpadding='0' cellspacing='0' generatecss='no' nowrap='yes')  "
		if this.tabpg_values.dw_values.Create( ls_newdwsyntax, ls_error ) <> 1 then 
			MessageBox( "Error", ls_error + "~n~n" + ls_newdwsyntax, StopSign! )
			return
		end if
		
		// Add additional information column if initial column use CodeTable
		string ls_codetable
		boolean lb_lookup = FALSE
		// Is CodeTable is used
		ls_codetable = inv_filterattrib.idw_dw.Describe( ls_col + ".Edit.CodeTable" )
		if( Upper( ls_codetable ) = "YES" ) then 
			lb_lookup = TRUE
		else
			ls_codetable = inv_filterattrib.idw_dw.Describe( ls_col + ".DDLB.Case" )
			if( ls_codetable <> "?" and ls_codetable <> "!" ) then lb_lookup = TRUE
		end if
		
		if lb_lookup then
			// Create complex calculate expression
			string ls_delim = ""
			if Left( ls_coltype, 4 ) = "char" then ls_delim = "'"
			ls_codetable = inv_filterattrib.idw_dw.Describe( ls_col + ".Values" )
			string lsa_lookups[], ls_calcexpr
			long ll_arraysize, ll_arrayindex, ll_delimpos
			ll_arraysize = lnv_string.of_ParseToArray( ls_codetable, "/", lsa_lookups )
			for ll_arrayindex = 1 to ll_arraysize
				ll_delimpos = Pos( lsa_lookups[ll_arrayindex], "~t" )
				if ll_delimpos > 1 then
					ls_calcexpr += "if(vals=" + ls_delim + Mid( lsa_lookups[ll_arrayindex], ll_delimpos + 1 ) + &
					+ls_delim+","+"'"+Left( lsa_lookups[ll_arrayindex], ll_delimpos - 1 )+"'"+ ","
				else
					ls_calcexpr += "if(IsNull(vals),"+"'"+Left( lsa_lookups[ll_arrayindex], ll_delimpos - 1 )+"'"+ ","
				end if
			next
			ls_calcexpr = Left( ls_calcexpr, Len(ls_calcexpr) - 1 )
			ls_calcexpr += "," + "''"
			ls_calcexpr += Fill( ")", ll_arrayindex - 1 )
			
			// Add calculated column
			string ls_modify
			ls_modify = 'create compute(name=z band=detail font.charset="0" font.face=' + &
				'"MS Sans Serif" font.height="-8" font.pitch="2" font.weight="400" background.mode="2"' + &
				' background.color="1073741824" color="0" x="4" y="4" height="52" width="700" ' + &
				'format="[general]" expression="' + ls_calcexpr + '" alignment="0" border="0" ' + &
				'crosstab.repeat=no )'
			ls_error = this.tabpg_values.dw_values.Modify( ls_modify )
			if Len( ls_error ) > 0 then MessageBox( "Modify Error", ls_modify + "~n~n" + ls_error )
			ls_modify += ' values.x="705"'
			ls_error = this.tabpg_values.dw_values.Modify( ls_modify )
			if Len( ls_error ) > 0 then MessageBox( "Modify Error", ls_modify + "~n~n" + ls_error )
			string ls_sort = "z A"
			this.tabpg_values.dw_values.SetSort( ls_sort )
		end if
		
		// Get column number for given column name
		long ll_index, ll_count, ll_colnumber
		ll_count = Long( inv_filterattrib.idw_dw.Describe( "DataWindow.Column.Count" ) )
		for ll_index = 1 to ll_count
			if inv_filterattrib.idw_dw.Describe( "#" + string( ll_index ) + ".Name" ) = ls_col then
				ll_colnumber = ll_index
				exit
			end if
		next
		
		long ll_rows, ll_filtered
		ll_rows = inv_filterattrib.idw_dw.RowCount( )
		ll_filtered = inv_filterattrib.idw_dw.FilteredCount( )
		
		// Only if ll_colnumner > 0 ( calculated columns doesn't exists in standard set of columns )
		// Another reason - calculated columns is prepared only for visible part of DW
		if ll_colnumber > 0 then
			// Copy necessary column data into selector DW
			tab_1.tabpg_values.dw_values.Reset( )
			// From Primary! buffer
			tab_1.tabpg_values.dw_values.Object.Data.Primary[1,1,ll_rows,1] = &
				inv_filterattrib.idw_dw.Object.Data.Primary[1,ll_colnumber,ll_rows,ll_colnumber]
			// From Filtered! buffer
			if ll_filtered > 0 then
				tab_1.tabpg_values.dw_values.Object.Data.Primary[ll_rows+1,1,ll_rows+ll_filtered,1] = &
					inv_filterattrib.idw_dw.Object.Data.Filter[1,ll_colnumber,ll_filtered,ll_colnumber]
			end if
			// Remove all records with NULL values
			string ls_filter
			ls_filter = tab_1.tabpg_values.dw_values.Describe( "DataWindow.Table.Filter" )
			tab_1.tabpg_values.dw_values.SetFilter( "IsNull(vals)" );
			tab_1.tabpg_values.dw_values.Filter( );
			tab_1.tabpg_values.dw_values.RowsDiscard( 1, tab_1.tabpg_values.dw_values.RowCount(), Primary! )
			tab_1.tabpg_values.dw_values.SetFilter( "" );
			tab_1.tabpg_values.dw_values.Filter( );
			tab_1.tabpg_values.dw_values.SetFilter( ls_filter );
			// Final touch
			tab_1.tabpg_values.dw_values.Sort( )
			tab_1.tabpg_values.dw_values.Filter( )
			this.tabpg_values.dw_values.SetRedraw( TRUE )
			this.tabpg_values.dw_values.Visible = TRUE
		else
			this.tabpg_values.dw_values.dataobject = ""
			this.tabpg_values.dw_values.SetRedraw( TRUE )
			this.tabpg_values.dw_values.Visible = TRUE
		end if
	end if
else
	this.tabpg_values.dw_values.dataobject = ""
	is_currentcolumn = ""
end if
end event

type tabpg_functions from pfc_w_filterextended`tabpg_functions within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
end type

type st_help from pfc_w_filterextended`st_help within tabpg_functions
boolean BringToTop=true
end type

type tabpg_columns from pfc_w_filterextended`tabpg_columns within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
end type

type tabpg_operators from pfc_w_filterextended`tabpg_operators within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
end type

type tabpg_values from pfc_w_filterextended`tabpg_values within tab_1
int X=18
int Y=100
int Width=1865
int Height=768
end type

event dw_values::doubleclicked;any		la_val
string	ls_value
string	ls_coltype
string	ls_expression
n_cst_string lnv_string

if row > 0 then
	// Get the column type.
	ls_coltype = Left(this.Describe ( "#1.ColType" ), 5)
	
	// Get the value.
	la_val = inv_rowselect.of_GetItemAny (row, 1)
	ls_value = String (la_val)

	// Determine the correct expression.
	Choose Case ls_coltype
		// CHARACTER DATATYPE		
		Case "char("	
			If Pos(ls_value, '~~~"') =0 And Pos(ls_value, "~~~'") =0 Then
				// No special characters found.
				If Pos(ls_value, "'") >0 Then
					// Replace single quotes with special chars single quotes.
					ls_value = lnv_string.of_GlobalReplace(ls_value, "'", "~~~'")				
				End If
			End If
			ls_expression = "'" + ls_value + "'"
	
		// DATE DATATYPE	
		Case "date"
			ls_expression = "Date('" + ls_value  + "')" 

		// DATETIME DATATYPE
		Case "datet"				
			ls_expression = "DateTime('" + ls_value + "')" 

		// TIME DATATYPE
		Case "time", "times"		
			ls_expression = "Time('" + ls_value + "')" 
	
		// NUMBER
		Case 	Else
			ls_expression = ls_value
	End Choose	
	
	mle_filter.ReplaceText (ls_expression)
end if

end event

