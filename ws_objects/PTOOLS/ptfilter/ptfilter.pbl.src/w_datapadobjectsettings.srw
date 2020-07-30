$PBExportHeader$w_datapadobjectsettings.srw
forward
global type w_datapadobjectsettings from w_response
end type
type cb_1 from u_cbok within w_datapadobjectsettings
end type
type cb_2 from u_cbcancel within w_datapadobjectsettings
end type
type dw_2 from u_dw_datapadobjectsettings within w_datapadobjectsettings
end type
type st_1 from statictext within w_datapadobjectsettings
end type
type uo_1 from u_cst_colors within w_datapadobjectsettings
end type
type st_selectedcolor from statictext within w_datapadobjectsettings
end type
type sle_1 from singlelineedit within w_datapadobjectsettings
end type
type st_2 from statictext within w_datapadobjectsettings
end type
type uo_2 from u_cst_colors within w_datapadobjectsettings
end type
type st_textcolor from statictext within w_datapadobjectsettings
end type
type st_4 from statictext within w_datapadobjectsettings
end type
type cb_3 from commandbutton within w_datapadobjectsettings
end type
type gb_2 from groupbox within w_datapadobjectsettings
end type
type gb_1 from groupbox within w_datapadobjectsettings
end type
end forward

global type w_datapadobjectsettings from w_response
int X=901
int Y=656
int Width=1550
int Height=1540
WindowType WindowType=popup!
boolean TitleBar=true
string Title="Data Manager Object Settings"
boolean MinBox=true
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
st_1 st_1
uo_1 uo_1
st_selectedcolor st_selectedcolor
sle_1 sle_1
st_2 st_2
uo_2 uo_2
st_textcolor st_textcolor
st_4 st_4
cb_3 cb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_datapadobjectsettings w_datapadobjectsettings

type variables
dwObject		idwo_Target

//n_cst_Mediator_DataManager	inv_Mediator
n_cst_DataObject_Filter	inv_DOF
//n_cst_FilterAttrib   inv_filterAttrib
String	is_ColumnName
dataWindowChild	idw_Values
dataWindowChild	idw_colors

Long    il_Color
Long    il_TextColor
String	is_Label
String	is_Filter
String	is_FilePath

String is_Column
String is_Operator
String is_Value
end variables

forward prototypes
public function integer of_getvalues (string as_column)
public function string wf_parsecolumnname (string as_data)
public function integer wf_setcolor (Long al_Color)
private function integer wf_setinitialvalue ()
public function integer wf_setfilter (string as_filter)
public function integer wf_setpicturepath (String as_Path)
public function integer wf_settextcolor (long al_color)
end prototypes

public function integer of_getvalues (string as_column);//string ls_format
//string ls_coltype
//string ls_val_expr
//integer li_selectedrow
//string ls_codetable
//boolean lb_lookup = FALSE
//string lsa_lookups[], ls_calcexpr
//long ll_index, ll_count, ll_colnumber
//long ll_arraysize, ll_arrayindex, ll_delimpos
//decimal value_x, value_width, lookup_x, lookup_width
//string ls_modify, ls_err
//string ls_syntax
//string ls_buffer
//
//n_cst_string lnv_string
//
//// Populate values based on current column
//
//SetPointer( HourGlass! )		
//
//// Get source column type
//ls_coltype = inv_filterattrib.idw_dw.Describe( as_column + ".Coltype" )
//if ls_coltype = "?" or ls_coltype = "!" then 
//	MessageBox( "Error", "Cannot detect column type", StopSign! )
//
//// MID CODE RETURN HERE 
//	return -1
//
//
//end if
//
//// If type is CHAR without length ( case of calculated column )
//if Lower(ls_coltype) = "char" then ls_coltype = "char(255)"
//
//// Get source column format
//ls_format = inv_filterattrib.idw_dw.Describe( as_column + ".Format" )
//if ls_format = "?" or ls_format = "!" or ls_format = "" then ls_format = "[general]"
//
//// Set appropriate expression for 'value' column
//Choose Case Left( ls_coltype, 5 )
//	// CHARACTER DATATYPE		
//	Case "char("	
//		ls_val_expr = "initial_value"
//	// DATE DATATYPE	
//	Case "date"
//		ls_val_expr = "string(Date(initial_value),'" + ls_format + "')"
//	// DATETIME DATATYPE
//	Case "datet"				
//		ls_val_expr = "string(DateTime(initial_value),'" + ls_format + "')"
//	// TIME DATATYPE
//	Case "time", "times"		
//		ls_val_expr = "string(Time(initial_value),'" + ls_format + "')"
//	// NUMBER
//	Case 	Else
//		ls_val_expr = "string(Number(initial_value),'" + ls_format + "')"
//End Choose
//
//// Add additional information column if initial column use 
//
//// Is CodeTable is used
//ls_codetable = inv_filterattrib.idw_dw.Describe( as_column + ".Edit.CodeTable" )
//if( Upper( ls_codetable ) = "YES" ) then 
//	lb_lookup = TRUE
//else
//	ls_codetable = inv_filterattrib.idw_dw.Describe( as_column + ".DDLB.Case" )
//	if( ls_codetable <> "?" and ls_codetable <> "!" ) then lb_lookup = TRUE
//end if
//
//if lb_lookup then
//	// Create complex calculate expression
//	ls_codetable = inv_filterattrib.idw_dw.Describe( as_column + ".Values" )
//	
//	ll_arraysize = lnv_string.of_ParseToArray( ls_codetable, "/", lsa_lookups )
//	for ll_arrayindex = 1 to ll_arraysize
//		ll_delimpos = Pos( lsa_lookups[ll_arrayindex], "~t" )
//		if ll_delimpos > 1 then
//			ls_calcexpr += "if(initial_value='" + Mid( lsa_lookups[ll_arrayindex], ll_delimpos + 1 ) + &
//			+ "','" + Left( lsa_lookups[ll_arrayindex], ll_delimpos - 1 ) + "'" + ","
//		else
//			ls_calcexpr += "if(IsNull(initial_value),'" + Left( lsa_lookups[ll_arrayindex], ll_delimpos - 1 ) + "',"
//		end if
//	next
//	ls_calcexpr = Left( ls_calcexpr, Len(ls_calcexpr) - 1 )
//	ls_calcexpr += ",''"
//	ls_calcexpr += Fill( ")", ll_arrayindex - 1 )
//end if
//
//// Get column number for given column name
//ll_count = Long( inv_filterattrib.idw_dw.Describe( "DataWindow.Column.Count" ) )
//for ll_index = 1 to ll_count
//	if inv_filterattrib.idw_dw.Describe( "#" + string( ll_index ) + ".Name" ) = as_column then
//		ll_colnumber = ll_index
//		exit
//	end if
//next
//
//// Only if ll_colnumner > 0 ( calculated columns doesn't exists in standard set of columns )
//// Another reason - calculated columns is prepared only for visible part of DW
//if ll_colnumber > 0 then
//	
//	// Rearrange DDDW
//	value_x = Dec( idw_Values.Describe( "value.X" ) )
//	lookup_x = Dec( idw_Values.Describe( "lookup.X" ) )
//	
//	if lb_lookup then
//		if lookup_x > value_x then
//			value_width = Dec( idw_Values.Describe( "value.Width" ) )
//			lookup_width = Dec( idw_Values.Describe( "lookup.Width" ) )
//			ls_modify = " lookup.X='" + string(value_x) + "' lookup.Width='" + string(value_width) + &
//				"' value.X='" + string(lookup_x) + "' value.Width='" + string(lookup_width) + "' "
//		end if
//		ls_modify += "lookup.Expression=~"" + ls_calcexpr + "~" lookup.Visible='1' " + &
//			"value.Expression=~"" + ls_val_expr + "~" value.Y='0'"
//		ls_err = idw_Values.Modify( ls_modify )
//	else
//		if value_x > lookup_x then
//			value_width = Dec( idw_Values.Describe( "value.Width" ) )
//			lookup_width = Dec( idw_Values.Describe( "lookup.Width" ) )
//			ls_modify = " lookup.X='" + string(value_x) + "' lookup.Width='" + string(value_width) + &
//				"' value.X='" + string(lookup_x) + "' value.Width='" + string(lookup_width) + "' "
//		end if
//		ls_modify += "value.Expression=~"" + ls_val_expr + "~" lookup.Visible='0' "
//		ls_err = idw_Values.Modify( ls_modify )
//	end if
//
//	// Make a full copy of initial column data
//	DataStore lds_data
//	lds_data = Create DataStore
//	
//	ls_syntax = inv_filterattrib.idw_dw.Describe( "DataWindow.Syntax" )
//	lds_data.Create( ls_syntax )
//	inv_filterattrib.idw_dw.RowsCopy( 1, inv_filterattrib.idw_dw.RowCount(), Primary!, lds_data, 1, Primary! )
//	inv_filterattrib.idw_dw.RowsCopy( 1, inv_filterattrib.idw_dw.FilteredCount(), Filter!, lds_data, 1, Primary! )
//
//	// Copy data into Child DW
//	idw_Values.Reset()
//	
//	ls_buffer = lds_data.Describe( "DataWindow.Data" )
//	idw_Values.ImportString( ls_buffer, 1, lds_data.RowCount( ), ll_colnumber, ll_colnumber, 1 )
//	Destroy lds_data
//
//	// Remove all records with NULL values
//	idw_Values.SetFilter( "IsNull(value) or value=''" )
//	idw_Values.Filter( )
//	idw_Values.RowsDiscard( 1, idw_Values.RowCount(), Primary! )
//	idw_Values.SetFilter( "" )
//	idw_Values.Filter( )
//	
//	// Remove duplicated values
//	idw_Values.SetSort( "value A" )
//	idw_Values.SetFilter( "GetRow( ) = 1 or initial_value <> initial_value[-1]" )
//	idw_Values.Sort( )
//	idw_Values.Filter( )
//	MessageBox ( "Count" , String ( idw_Values.RowCount ( ) ) ) 
//	
//end if
return -1
end function

public function string wf_parsecolumnname (string as_data);Int	li_Pos

li_Pos = Pos ( as_Data, "="  )


RETURN Left ( as_Data , li_Pos - 1)

end function

public function integer wf_setcolor (Long al_Color);il_Color = al_Color
st_selectedcolor.BackColor = il_Color
Return 1
end function

private function integer wf_setinitialvalue ();dw_2.setItem ( 1 , "values" , String ( inv_DOF.of_GetValue ( ) ) )
is_Value = inv_DOF.of_GetValue ( )

RETURN 1
end function

public function integer wf_setfilter (string as_filter);is_Filter = as_Filter
dw_2.Setitem ( 1 , "expression" , is_Filter )
Return 1
end function

public function integer wf_setpicturepath (String as_Path);is_FilePath = as_Path 

sle_1.Text = is_FilePath

RETURN 1
end function

public function integer wf_settextcolor (long al_color);il_TextColor = al_Color
st_Textcolor.BackColor = il_textColor
return 1
end function

event open;call super::open;String	ls_Label 
Long		ll_Color

dw_2.insertRow ( 0 )

inv_DOF = Message.PowerObjectParm

ib_DisableCloseQuery = TRUE

IF IsValid ( inv_DOF ) THEN

	ls_Label = inv_DOF.of_GetLabel ( )
	dw_2.Setitem ( 1 , "label" , ls_Label  )
	is_label = ls_Label
	
	
	wf_SetColor ( inv_DOF.of_GetColor( ) )
	wf_SetTextColor ( inv_DOF.of_GetTextColor( ) )	
	THIS.wf_SetFilter ( inv_DOF.of_GetFilter ( ) )
	THIS.wf_SetPicturePath ( inv_DOF.of_GetPicture ( ) ) 
 
ELSE
	Close( THIS )
END IF



end event

on w_datapadobjectsettings.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.st_1=create st_1
this.uo_1=create uo_1
this.st_selectedcolor=create st_selectedcolor
this.sle_1=create sle_1
this.st_2=create st_2
this.uo_2=create uo_2
this.st_textcolor=create st_textcolor
this.st_4=create st_4
this.cb_3=create cb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_selectedcolor
this.Control[iCurrent+7]=this.sle_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.uo_2
this.Control[iCurrent+10]=this.st_textcolor
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_1
end on

on w_datapadobjectsettings.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.st_selectedcolor)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.uo_2)
destroy(this.st_textcolor)
destroy(this.st_4)
destroy(this.cb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event pfc_default;dw_2.AcceptText ( )

inv_DOF.of_SetColor ( il_Color )
inv_DOF.of_SetTextColor ( il_TextColor )
inv_DOF.of_Setlabel ( is_Label )
inv_DOF.of_SetFilter ( is_Filter )
inv_DOf.of_SetPicture ( is_FilePath )


This.Event pfc_Close ( )
end event

event pfc_cancel;call super::pfc_cancel;//Extending Ancestor
This.Event pfc_Close ( )
end event

event pfc_postopen;//
//
//IF dw_2.GetChild ( "values", idw_values ) <> 1 THEN
//	MessageBox ( "ERROR" , "Could not get a handle to the dwc." )
//ELSE
//	Long			ll_FindRtn
//	DataStore	lds_Temp
//	lds_Temp = inv_DOF.of_GetValuesds ( ) 
//	lds_Temp.ShareData ( idw_Values )
//	
////	ll_FindRtn = idw_Values.Find ( "initial_value = '"+ String ( inv_DOF.of_GetValue ( ) ) + "'" , 1, 999 )
////
////	idw_Values.SetRow ( ll_FindRtn ) 
////	idw_Values.SelectRow ( ll_FindRtn, true ) 
//
//	
//END IF
//
end event

type cb_1 from u_cbok within w_datapadobjectsettings
int X=448
int Y=1308
int Width=279
int TabOrder=20
boolean BringToTop=true
end type

type cb_2 from u_cbcancel within w_datapadobjectsettings
int X=800
int Y=1308
int Width=283
int TabOrder=40
boolean BringToTop=true
end type

type dw_2 from u_dw_datapadobjectsettings within w_datapadobjectsettings
int X=5
int Y=28
int Width=1499
int Height=380
int TabOrder=10
boolean BringToTop=true
end type

event constructor;ib_rmbmenu = FALSE
end event

event itemchanged;call super::itemchanged;CHOOSE CASE Lower ( dwo.name )
		
	CASE "label"
		is_Label = data
		
	CASE "values"
		is_Value = data
		
	CASE "expression"
		is_Filter = data
	
END CHOOSE

		
end event

event buttonclicked;n_cst_FilterAttrib 	lnv_FilterAttrib
n_cst_ReturnAttrib	lnv_RtnAttrib

n_cst_DWSrv_filter	lnv_Filter
lnv_Filter = CREATE n_cst_DWSrv_filter


IF dwo.Name = "cb_modify" THEN
	//IF IsValid ( inv_dof.inv_Mediator.idw_Target.inv_Filter ) THEN
	//	lnv_FilterAttrib = inv_dof.of_GetFilterAttribs ( )
	//ELSE
	//	messageBox ( "NOT" , "VALID" )
	//END IF

	
	
	SetPointer ( HOURGLASS! )	

	lnv_FilterAttrib = inv_dof.of_getfilterattribs ( )
	lnv_FilterAttrib.is_Filter = is_Filter
	openWithParm ( w_FilterExtended , lnv_FilterAttrib )
	lnv_RtnAttrib = Message.PowerobjectParm
	IF lnv_RtnAttrib.ii_rc = 1 THEN
	
		String	ls_Filter
		ls_Filter = lnv_RtnAttrib.is_rs
		wf_SetFilter ( ls_Filter )
	END IF
	
END IF
end event

type st_1 from statictext within w_datapadobjectsettings
int X=69
int Y=516
int Width=325
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Background:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_1 from u_cst_colors within w_datapadobjectsettings
event destroy ( )
int X=379
int Y=588
int Width=434
int Height=348
int TabOrder=30
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_1.destroy
call u_cst_colors::destroy
end on

event ue_colorchanged;wf_SetColor ( al_Color )

end event

type st_selectedcolor from statictext within w_datapadobjectsettings
int X=398
int Y=520
int Width=407
int Height=68
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_datapadobjectsettings
int X=393
int Y=1072
int Width=718
int Height=80
int TabOrder=80
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
int Accelerator=102
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;is_FilePath = THIS.text
end event

type st_2 from statictext within w_datapadobjectsettings
int X=87
int Y=1076
int Width=293
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="&File Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_2 from u_cst_colors within w_datapadobjectsettings
int X=1033
int Y=588
int Width=434
int Height=348
int TabOrder=60
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_2.destroy
call u_cst_colors::destroy
end on

event ue_colorchanged;wf_SetTextColor ( al_Color )
end event

type st_textcolor from statictext within w_datapadobjectsettings
int X=1051
int Y=516
int Width=402
int Height=68
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_datapadobjectsettings
int X=905
int Y=520
int Width=133
int Height=52
boolean Enabled=false
boolean BringToTop=true
string Text="Font:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_datapadobjectsettings
int X=1129
int Y=1072
int Width=325
int Height=80
int TabOrder=70
boolean BringToTop=true
string Text="B&rowse..."
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_PathName
String	ls_FileName

IF GetFileOpenName ( "Picture", ls_pathname, ls_filename , ".bmp" , ".bmp Files (*.bmp),*.bmp" ) = 1 THEN
	wf_SetPicturePath ( ls_PathName )
END IF

RETURN 1

end event

type gb_2 from groupbox within w_datapadobjectsettings
int X=37
int Y=440
int Width=1463
int Height=516
int TabOrder=20
string Text="Color"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_datapadobjectsettings
int X=37
int Y=968
int Width=1463
int Height=268
int TabOrder=50
string Text="Picture"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

