$PBExportHeader$n_cst_mediator_datamanager.sru
forward
global type n_cst_mediator_datamanager from n_cst_mediator
end type
end forward

global type n_cst_mediator_datamanager from n_cst_mediator
end type
global n_cst_mediator_datamanager n_cst_mediator_datamanager

type variables
Boolean   ib_Licensed

boolean    ib_Change
String        is_Name
String	 is_Topic

Boolean   ib_Hidden
Long        il_OldHeight = 708
Long	il_OldDWHeight

w_dataManager	iw_DataManager
u_dw    idw_Target

u_dw_DataPad	idw_DataManager
n_cst_DataObject_Filter	inva_DOF[]


n_cst_FilterAttrib	inv_FilterAttrib
n_cst_SortAttrib	inv_SortAttrib

end variables

forward prototypes
public function integer of_filter (string as_filterstring)
public function integer of_setdatamanager (u_dw adw_datamanager)
protected function n_cst_dataobject_filter of_newfilterobject ()
public function integer of_populatedatavalues (ref n_cst_dataobject_filter anv_dof)
public function n_cst_dataobject_filter of_getdataobject (long al_ID)
private function long of_getidfromname (String as_Name)
public function integer of_displaydetails (dwobject adwo_data)
public function integer of_reset ()
public function integer of_delete (dwobject adwo_data)
private function integer of_populateobjects (string asa_objectnames[])
public function integer of_createfilterobject ()
public function integer of_import (string as_path)
public function integer of_registertarget (datawindow adw_target, String as_Topic)
public function string of_getpath ()
public function n_cst_filterattrib of_getfilterattribs ()
private function integer of_populatefilterattribs ()
public function integer of_save (boolean ab_ask)
public function integer of_showdatamanager ()
public function integer of_hidedatamanager ()
public function integer of_pindown ()
public function integer of_pinup ()
public function integer of_createfilterobject (dwobject dwo, long al_row)
private function integer of_createfilterobject (string as_columnname, string as_value, string as_displayname)
public function string of_resolvealias (string as_value)
private function integer of_displaydatamanager ()
private function integer of_displaynew (n_cst_dataobject_filter anv_dof)
private function integer of_shrinkarray ()
private function long of_getfullsizeheight ()
private function string of_getvalue (dwobject dwo, long al_row)
public function integer of_setlicensed (Boolean ab_Licensed)
public function boolean of_getlicensed ()
public subroutine readme ()
end prototypes

public function integer of_filter (string as_filterstring);IF isValid ( idw_Target ) THEN
	idw_Target.SetFilter( as_FilterString )
	idw_Target.Filter ( )
	idw_Target.Sort ( )
	idw_Target.TriggerEvent ( "ue_FilterChanged" )
ELSE
	MessageBox ( "Error" , "Target is not valid" )
END IF

RETURN 1
end function

public function integer of_setdatamanager (u_dw adw_datamanager);idw_datamanager = adw_DataManager
iw_datamanager = adw_datamanager.GetParent () 
Return 1
end function

protected function n_cst_dataobject_filter of_newfilterobject ();
n_cst_DataObject_Filter lnv_DOF 
lnv_DOF = CREATE n_cst_DataObject_Filter 
lnv_DOF.of_SetID ( THIS.of_GetNextObjectID ( ) )
lnv_DOF.of_SetMediator ( THIS )
inva_dof[ UpperBound ( inva_dof ) + 1 ] = lnv_DOF

ib_Change = TRUE

Return  lnv_DOF
end function

public function integer of_populatedatavalues (ref n_cst_dataobject_filter anv_dof);//string ls_format
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
//String	as_Column
//DataStore	lds_Values
//
//as_column = anv_dof.of_GetColumnName ( )
//
////idw_target = idw_target
//lds_Values = anv_dof.of_GetValuesds ( )
//
//
//
//n_cst_string lnv_string
//
//// Populate values based on current column
//
//SetPointer( HourGlass! )		
//
//// Get source column type
//ls_coltype = idw_target.Describe( as_column + ".Coltype" )
//if ls_coltype = "?" or ls_coltype = "!" then 
//	MessageBox( "Error", "Cannot detect column type", StopSign! )
//// MID CODE RETURN HERE 
//	return -1
//end if
//
//anv_dof.of_SetDataType ( ls_ColType )
//
//// If type is CHAR without length ( case of calculated column )
//if Lower(ls_coltype) = "char" then ls_coltype = "char(255)"
//
//// Get source column format
//ls_format = idw_target.Describe( as_column + ".Format" )
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
//ls_codetable = idw_target.Describe( as_column + ".Edit.CodeTable" )
//if( Upper( ls_codetable ) = "YES" ) then 
//	lb_lookup = TRUE
//else
//	ls_codetable = idw_target.Describe( as_column + ".DDLB.Case" )
//	if( ls_codetable <> "?" and ls_codetable <> "!" ) then lb_lookup = TRUE
//end if
//
//if lb_lookup then
//	// Create complex calculate expression
//	ls_codetable = idw_target.Describe( as_column + ".Values" )
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
//ll_count = Long( idw_target.Describe( "DataWindow.Column.Count" ) )
//for ll_index = 1 to ll_count
//	if idw_target.Describe( "#" + string( ll_index ) + ".Name" ) = as_column then
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
//	value_x = Dec( lds_Values.Describe( "value.X" ) )
//	lookup_x = Dec( lds_Values.Describe( "lookup.X" ) )
//	
//	if lb_lookup then
//		if lookup_x > value_x then
//			value_width = Dec( lds_Values.Describe( "value.Width" ) )
//			lookup_width = Dec( lds_Values.Describe( "lookup.Width" ) )
//			ls_modify = " lookup.X='" + string(value_x) + "' lookup.Width='" + string(value_width) + &
//				"' value.X='" + string(lookup_x) + "' value.Width='" + string(lookup_width) + "' "
//		end if
//		ls_modify += "lookup.Expression=~"" + ls_calcexpr + "~" lookup.Visible='1' " + &
//			"value.Expression=~"" + ls_val_expr + "~" value.Y='0'"
//		ls_err = lds_Values.Modify( ls_modify )
//	else
//		if value_x > lookup_x then
//			value_width = Dec( lds_Values.Describe( "value.Width" ) )
//			lookup_width = Dec( lds_Values.Describe( "lookup.Width" ) )
//			ls_modify = " lookup.X='" + string(value_x) + "' lookup.Width='" + string(value_width) + &
//				"' value.X='" + string(lookup_x) + "' value.Width='" + string(lookup_width) + "' "
//		end if
//		ls_modify += "value.Expression=~"" + ls_val_expr + "~" lookup.Visible='0' "
//		ls_err = lds_Values.Modify( ls_modify )
//	end if
//
//	// Make a full copy of initial column data
//	DataStore lds_data
//	lds_data = Create DataStore
//	
//	ls_syntax = idw_target.Describe( "DataWindow.Syntax" )
//	lds_data.Create( ls_syntax )
//	
//	idw_target.RowsCopy( 1, idw_target.RowCount(), Primary!, lds_data, 1, Primary! )
//	idw_target.RowsCopy( 1, idw_target.FilteredCount(), Filter!, lds_data, 1, Primary! )
//
//	// Copy data into Child DW
//	lds_Values.Reset()
//	
//	ls_buffer = lds_data.Describe( "DataWindow.Data" )
//	lds_Values.ImportString( ls_buffer, 1, lds_data.RowCount( ), ll_colnumber, ll_colnumber, 1 )
//	Destroy lds_data
//
//	// Remove all records with NULL values
//	lds_Values.SetFilter( "IsNull(value) or value=''" )
//	lds_Values.Filter( )
//	lds_Values.RowsDiscard( 1, lds_Values.RowCount(), Primary! )
//	lds_Values.SetFilter( "" )
//	lds_Values.Filter( )
//	
//	// Remove duplicated values
//	lds_Values.SetSort( "value A" )
//	lds_Values.SetFilter( "GetRow( ) = 1 or initial_value <> initial_value[-1]" )
//	lds_Values.Sort( )
//	lds_Values.Filter( )
//	
//end if
return 1
end function

public function n_cst_dataobject_filter of_getdataobject (long al_ID);n_cst_DataObject_Filter	lnv_DOF

SetNull ( lnv_DOF )

Int i 
Int li_Count

li_Count = UpperBound ( inva_dof )

FOR i = 1 TO li_Count 	
	IF inva_dof[i].of_GetID ( ) = al_ID THEN
		lnv_DOF = inva_dof[i]
		EXIT
	END IF
NEXT


Return lnv_Dof
end function

private function long of_getidfromname (String as_Name);Int		li_Pos
Long		ll_ID = -1
String	ls_ID

li_Pos = POS( as_Name , "do_" )

IF li_Pos > 0 THEN
	ls_ID = Right ( as_Name ,  len ( as_Name ) - 3 ) 	
	IF isNumber ( ls_ID ) THEN
		ll_ID = Long ( ls_id )
	END IF
	
END IF

RETURN ll_ID
end function

public function integer of_displaydetails (dwobject adwo_data);Int	li_Return = -1
Long	ll_ID
n_cst_DataObject_Filter lnv_DOF

ll_ID = THIS.of_GetIDFromName ( String ( adwo_Data.Name ) )
IF ll_ID <> -1 THEN
	lnv_DOF = THIS.of_GetDataObject ( ll_ID )
	IF IsValid ( lnv_DOF ) THEN
		lnv_DOF.of_DisplayDetails ( adwo_data )
		li_Return = 1
	END IF
END IF

RETURN li_return
end function

public function integer of_reset ();// Return 	1 Continue
//				0 Cancel
Int			li_Return = 1
Boolean 		lb_Continue = TRUE
Boolean		lb_AskToSave = TRUE

IF ib_Change THEN
	lb_Continue = THIS.of_Save ( lb_AskToSave ) = 1
END IF

IF lb_Continue THEN
	n_cst_DataObject_Filter	lnva_Empty[]
	
	inva_dof[] = lnva_Empty[]
	il_nextid = 0
	idw_datamanager.DataObject = "d_DataPad"
	ib_change = FALSE
	is_Name = "Untitled"
ELSE
	li_Return = 0
END IF

RETURN li_Return
end function

public function integer of_delete (dwobject adwo_data);Int	li_Return = -1
Long	ll_ID
n_cst_DataObject_Filter lnv_DOF

ll_ID = THIS.of_GetIDFromName ( String ( adwo_Data.Name ) )
IF ll_ID <> -1 THEN
	lnv_DOF = THIS.of_GetDataObject ( ll_ID )
	IF IsValid ( lnv_DOF ) THEN
		DESTROY lnv_DOF 
		THIS.of_ShrinkArray ( )
		li_Return = 1
		
		ib_Change = TRUE
	END IF
END IF

RETURN li_return
end function

private function integer of_populateobjects (string asa_objectnames[]);Long	ll_Count
Long	i
String	ls_CurrentName
String	ls_Label
Long		ll_Color
Long		ll_TextColor
String	ls_Filter
String   ls_Picture

n_cst_DataObject_Filter lnv_DOF

ll_Count = Upperbound ( asa_ObjectNames )

FOR i = 1 TO ll_Count  
	ls_CurrentName = asa_objectnames[i]
	IF ls_Currentname <> "dummy" THEN
		
		ls_Label = idw_datamanager.Describe ( ls_CurrentName + ".Text" )
		ll_Color = Long ( idw_datamanager.Describe ( ls_CurrentName + ".Background.Color" ) )
		ll_TextColor = Long ( idw_datamanager.Describe ( ls_CurrentName + ".Color" ) )
		ls_Filter = idw_datamanager.Describe ( ls_CurrentName + ".tag" )
		ls_Picture = idw_datamanager.Describe ( ls_CurrentName + ".filename" )
		
		lnv_DOF = THIS.of_newFilterObject (  )
		lnv_DOF.of_setLabel 	 	( ls_Label ) 
		lnv_DOF.of_SetFilter  	( ls_Filter )
		lnv_DOF.of_SetColor   	( ll_Color )
		lnv_DOF.of_SetPicture 	( ls_Picture )
		lnv_DOF.of_SetTextColor ( ll_TextColor )
	
		//IF	lnv_DOF.of_SetAttributesFromFilter ( ) = 1 THEN
			//THIS.of_populatedatavalues ( lnv_DOF )
	//	END IF
			
	END IF
	
NEXT


	
RETURN 1

end function

public function integer of_createfilterobject ();String	ls_ColType
String	ls_Filter
String 	ls_Operator 
Int		li_Return = 1

n_cst_String	lnv_String
n_cst_DataObject_Filter	lnv_DOF

lnv_DOF = THIS.of_NewFilterObject ( )
lnv_DOF.of_SetLabel	( "NEW "+String ( lnv_DOF.of_GetID ( ) ) )	
	
THIS.of_DisplayNew 	( lnv_DOF )
	
RETURN li_Return
end function

public function integer of_import (string as_path);String	ls_PathName, &
			ls_FileName
String 	lsa_Names[]
String   lsa_Objects[]
Int		li_Mbox
Boolean	lb_Continue = TRUE
Boolean	lb_AskToSave = TRUE

n_cst_String	lnv_String

IF ib_Change THEN
	lb_Continue = THIS.of_Save ( lb_AskToSave ) = 1
END IF

IF lb_Continue THEN
	
	THIS.of_Reset ( )
	idw_datamanager.DataObject = as_path+ ".psr"
	
	ls_FileName = lsa_Names [ lnv_String.of_parseToArray ( as_Path , "\" , lsa_Names ) ]
	is_Name = ls_FileName
	lnv_String.of_ParseToArray ( idw_datamanager.Describe ( "datawindow.objects" ) , "~t" ,lsa_Objects )
	
	THIS.of_PopulateObjects ( lsa_Objects )
	ib_Change = FALSE
END IF

RETURN 1
end function

public function integer of_registertarget (datawindow adw_target, String as_Topic);
// Early return possibility
IF Not isValid ( adw_Target ) THEN RETURN -1

idw_Target = adw_Target
THIS.of_PopulateFilterAttribs ( )

is_topic = as_Topic

RETURN 1

end function

public function string of_getpath ();String	ls_Path
Any 		la_Value

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_Path = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting ) 

ls_Path += "Dataview\" + is_Topic + "\"

Return ls_Path

end function

public function n_cst_filterattrib of_getfilterattribs ();RETURN inv_FilterAttrib
end function

private function integer of_populatefilterattribs ();
SetPointer ( HourGlass! )


inv_FilterAttrib.idw_dw = idw_target

Long	ll_ColCount 
Long 	i
long	j
String lsa_DBCols [] 
String lsa_Cols []
String ls_Name
String ls_DBName

IF Not ib_Licensed THEN Return 0 // done here for performance Reasons

ll_ColCount = Long ( idw_target.describe ( "datawindow.column.count" ) )

FOR i = 1 TO ll_ColCount 
	
	ls_DBName = idw_target.describe ( "#" + String ( i ) + ".DBname" ) 
	ls_Name =  idw_target.describe ( "#" + String ( i ) + ".name" ) 
	IF lower ( ls_DBName ) <> "beo_index" THEN 
		j++
		lsa_DBCols [ j ] = ls_DBName
		lsa_Cols [ j ] = ls_Name  
	END IF
	
NEXT

inv_FilterAttrib.is_Columns = lsa_Cols
inv_FilterAttrib.is_colnamedisplay = lsa_DBCols
inv_FilterAttrib.is_dbnames = lsa_Cols


RETURN 1
end function

public function integer of_save (boolean ab_ask);// returns: 	-1  Error
//					 0  User wants to cancel
//					 1  Success  
Int		li_Return = -1
Int		li_Mbox
Boolean	lb_Save

IF ab_Ask THEN
	THIS.of_showDataManager ( )
	li_Mbox = MessageBox ( "Save Changes" , "Do you want to save the change to the current view?" , QUESTION! , YESNOCANCEL! )
	
	CHOOSE CASE li_Mbox
			
		CASE 0 , 2 // no changes / don't save 
			lb_Save = FALSE
			ib_Change = FALSE  // I'm setting this here to prevent any repetitive save questions
			li_Return = 1
			
		CASE 1  // save the changes
			lb_Save = TRUE
			
		CASE 3  // cancel
			lb_Save = FALSE
			li_Return = 0
	END CHOOSE
ELSE
	lb_Save = TRUE
END IF

IF lb_Save THEN
	IF idw_datamanager.Event ue_Save ( ) = 0 THEN  
		li_return = 0 
	ELSE
		ib_Change = FALSE
	END IF
END IF

RETURN li_Return
end function

public function integer of_showdatamanager ();
// early return

IF not ib_Licensed THEN RETURN 0

IF Not IsValid ( iw_DataManager ) THEN
	THIS.of_DisplayDataManager ( )
END IF

Long	ll_BandHeight

IF IsValid ( iw_DataManager ) THEN
	IF ib_Hidden THEN
		
		iw_DataManager.Visible = TRUE
		ll_bandHeight = Long ( THIS.idw_Target.Describe( "Datawindow.footer.height" )  )
		
		DO
			iw_DataManager.height += 80
			iw_DataManager.y  = THIS.idw_Target.y + THIS.idw_Target.Height - iw_DataManager.height

		loop while iw_DataManager.height < il_OldHeight			
		ib_Hidden = FALSE
	END IF
END IF
RETURN 1
end function

public function integer of_hidedatamanager ();Long	ll_BandHeight

IF isValid ( iw_DataManager ) THEN
	IF ib_Hidden = FALSE AND ( NOT iw_DataManager.ib_PinDown ) THEN
		il_OldHeight = iw_DataManager.Height
		
		iw_DataManager.Visible = FALSE
		
		THIS.idw_Target.SetRedraw ( FALSE )
		ll_bandHeight = Long ( THIS.idw_Target.Describe( "Datawindow.footer.height" )  )
		DO
			iw_DataManager.height -= 90
			iw_DataManager.y = THIS.idw_Target.Height - iw_DataManager.height + 110 + ll_bandHeight
		loop while iw_DataManager.height > 90
		
		THIS.idw_Target.SetRedraw ( TRUE )		
		
	
		ib_Hidden = TRUE
	END IF
END IF




RETURN 1
end function

public function integer of_pindown ();
il_oldDWHeight = idw_Target.Height
idw_Target.Height -= iw_DataManager.Height //+ 75


RETURN 1


end function

public function integer of_pinup ();
idw_Target.Height = il_olddwheight//THIS.of_GetFullSizeHeight ( )

RETURN 1

end function

public function integer of_createfilterobject (dwobject dwo, long al_row);String	ls_Value
String 	ls_ColumnName
String	ls_DisplayName
Int		li_Return = 0

IF dwo.Name = 'datawindow' THEN
	
	//Screen for dwo's without Band attribute, which would crash
	
ELSEIF dwo.Band = "detail" THEN

	ls_value = THIS.of_GetValue ( dwo , al_Row )
	
	ls_ColumnName =  String ( dwo.name )
	ls_ColumnName = THIS.of_ResolveAlias ( ls_ColumnName ) 
	
	IF dwo.type = "compute" THEN
		ls_DisplayName = ls_Value
	ELSE
		ls_DisplayName = "evaluate ( 'lookupdisplay ("+ ls_ColumnName + ")', " + String ( al_Row ) + " )"		
		ls_DisplayName = idw_target.Describe ( ls_DisplayName )
	END IF
	
	IF Not IsNull ( ls_Value ) THEN
		IF THIS.of_CreateFilterObject ( ls_ColumnName , ls_Value , ls_DisplayName ) = 1 THEN
			li_Return = 1
		ELSE
			li_Return = -1
		END IF
	END IF
END IF

RETURN li_Return
end function

private function integer of_createfilterobject (string as_columnname, string as_value, string as_displayname);String	ls_ColType
String	ls_Filter
String 	ls_Operator 
Int		li_Return = 1

n_cst_String	lnv_String
n_cst_DataObject_Filter	lnv_DOF

ls_ColType = idw_target.Describe(as_columnName + ".ColType")
IF ls_ColType = "!" OR ls_ColType = "?" THEN
	li_Return = -1
ELSE
	ls_Operator = "="
	ls_Filter = lnv_String.of_BuildFilterString ( ls_coltype , as_columnName , as_Value , ls_Operator )
	
	lnv_DOF = THIS.of_NewFilterObject ( )
	
	lnv_DOF.of_SetDataType 		( ls_ColType )
	lnv_DOF.of_SetColumnName 	( as_ColumnName )
	lnv_DOF.of_SetFilter 		( ls_Filter )
	lnv_DOF.of_SetColor 			( 16776960 ) // light blue
	lnv_DOF.of_SetLabel			( as_DisplayName )	
	
	THIS.of_populateDatavalues ( lnv_DOF )
	THIS.of_DisplayNew 			( lnv_DOF )
	
END IF

RETURN li_Return
end function

public function string of_resolvealias (string as_value);
String ls_Return
ls_Return = as_value

CHOOSE CASE Lower ( as_Value ) 
		
	CASE "findest_name_d" , "origin_name_d"
		ls_Return = Left ( as_Value , ( len ( as_Value ) - 2 ) ) 
		
	CASE "hazmat" , "expedite"
		
		ls_Return = "ds_" + as_Value
		
		
END CHOOSE

RETURN ls_Return
		
end function

private function integer of_displaydatamanager ();
// early Return
IF NOT ib_Licensed THEN RETURN 0

w_dataManager lw_DataManager

openWithParm  ( lw_DataManager , THIS , idw_Target.getParent ( ) )

Return 1
end function

private function integer of_displaynew (n_cst_dataobject_filter anv_dof);
IF NOT IsValid ( idw_datamanager ) THEN
	THIS.of_DisplayDatamanager ( )
END IF
	
IF isValid (  idw_datamanager ) THEN
	idw_datamanager.Modify ( anv_dof.of_GetDisplayString ( ) )
END IF
	
RETURN 1
end function

private function integer of_shrinkarray ();Long	i
Long	ll_Count
Long	ll_NewCount = 0
n_cst_DataObject_Filter	lnva_New []

ll_Count = UpperBound ( inva_dof[] )

FOR i = 1 TO ll_Count
	IF IsValid ( inva_dof [i] ) THEN
		ll_NewCount ++
		lnva_New [ ll_NewCount ] = inva_dof [i] 
	END IF
NEXT
inva_dof = lnva_New


RETURN 1
	
	

end function

private function long of_getfullsizeheight ();Long	ll_Height

Window lw_Temp

lw_Temp = idw_Target.GetParent ( )

ll_Height = lw_Temp.Height - 10



Return ll_Height
end function

private function string of_getvalue (dwobject dwo, long al_row);String ls_Return

CHOOSE CASE dwo.type 
		
	CASE "column" , "compute"
		ls_Return = String ( dwo.primary [ al_Row ] )
		
	CASE "text"
		ls_Return = dwo.Text
		CHOOSE CASE Upper ( ls_Return )
			CASE "E" , "H" 
				ls_Return = "T" 
		END CHOOSE
		
		
END CHOOSE


return ls_Return 
end function

public function integer of_setlicensed (Boolean ab_Licensed);ib_Licensed = ab_Licensed

RETURN 1

end function

public function boolean of_getlicensed ();
RETURN ib_licensed


end function

public subroutine readme ();/*
*	The Purpose of this object is to mediate between the filter data objects, the 
*	DataManager Window and the Target for the action ( i.e. filter )
*	
*	To utilize just create an instance of THIS on the u_dw and call the of_RegisterTarget
*	method. The Topic argument is used to identify the type of target ( i.e. shipment, equip)
*	which is directly used to populate any predefined/saved .psr used in the DataManager via
*	a path to saved files.
*	
*	The DataManager window is equiped with a auto hide feature that is activated by mouse
*	movement over the target u_dw ( hide ) and the bottom of the Parent to the u_dw ( show	).
*	Some code will need to be put in place on the window and the u_dw and call the methods 
*	on THIS, of_ShowDataManager () and of_HideDataManager ( )*
*
*
*
*
*	/////////////////////////////////////////////////////////////////////////////////////
*	Written by: Rick Zacher
*	Date:       June 27, 2001
*
*
*
*
*/
end subroutine

on n_cst_mediator_datamanager.create
call super::create
end on

on n_cst_mediator_datamanager.destroy
call super::destroy
end on

event constructor;n_cst_LicenseManager	lnv_LicenseManager

ib_Licensed = lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_DataManager )


end event

