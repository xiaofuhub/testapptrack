$PBExportHeader$n_cst_bso_edimanager_camir.sru
forward
global type n_cst_bso_edimanager_camir from n_cst_bso_edimanager
end type
end forward

global type n_cst_bso_edimanager_camir from n_cst_bso_edimanager
end type
global n_cst_bso_edimanager_camir n_cst_bso_edimanager_camir

type variables
PRIVATE:
DataStore	ids_Data
DataStore	ids_SQLMapping


Transaction	itr_Camir

CONSTANT String	Cs_type_SQLRetrieve = "SQLRETRIEVE"
CONSTANT String	Cs_type_TAG = "TAG"
CONSTANT String	cs_Type_Literal = "LITERAL"

CONSTANT String	Cs_TypeTag_TAG = "^TAG^"
CONSTANT String	Cs_TypeTag_SQLRetrieve = "^SQLRETRIEVE^"
CONSTANT String	Cs_TypeTag_Literal = "!"
end variables

forward prototypes
private function string of_getsyntaxforcolumn (string as_column)
private function string of_parsesyntax (string as_syntax)
private function integer of_loaddatamapping ()
private function integer of_populateextendeddata ()
private function integer of_getinitaldata ()
private function string of_resolvegettype (string as_syntax)
private function string of_gettagvalue (string as_syntax)
private function integer of_insertcamirrecord ()
public function long of_getnewcamirid ()
private function string of_removecomments (string as_syntax)
public function integer of_exportdata (long al_sourceshipmentid)
protected function integer of_adderror (string as_errortext)
private function integer of_connecttocamir ()
private function transaction of_getcamirtransaction ()
private function string of_getliteralvalue (string as_syntax)
private function string of_globalreplace (string as_source, string as_old, string as_new)
public function integer of_showerrormessages ()
private function integer of_buildfile ()
private function integer of_getsqlretrievevalue (ref string as_syntax)
private function integer of_getvalue (string as_column, ref string as_value)
public function datastore of_getdatasource ()
end prototypes

private function string of_getsyntaxforcolumn (string as_column);Long		ll_Found
Long		ll_RowCount
String	ls_Column
String	ls_Syntax

ls_Column = as_column

ll_RowCount = ids_SQLMapping.RowCount ( )

ll_Found = ids_SQLMapping.Find( "Source = '" + ls_Column + "'"  ,1 , ll_RowCount + 1 )
IF ll_Found > 0 THEN
	ls_Syntax = ids_SQLMapping.GetItemString ( ll_Found , "sqltext" )	
END IF

RETURN ls_Syntax


end function

private function string of_parsesyntax (string as_syntax);String	ls_Return 
String	ls_Syntax
String	ls_ShipmentTag
String	lsa_Tags[]
Any		laa_Value[]
Long		ll_ShipmentID
Int		li_TagCount
Int		li_ProcessedTags
Int		li_TagIndex

n_cst_bso_reportmanager lnv_RptMan

ls_Syntax = as_syntax

li_TagCount = lnv_RptMan.of_GetTags( ls_Syntax , lsa_Tags)

IF li_TagCount > 0 THEN 
	li_ProcessedTags = lnv_RptMan.of_Processgenerictaglist( inv_shipment , lsa_Tags , laa_Value ) 
END IF

IF li_TagCount = li_ProcessedTags AND li_TagCount > 0 THEN
	FOR li_TagIndex = 1 TO li_TagCount
		ls_Syntax = THIS.of_Globalreplace( ls_Syntax , lsa_Tags[ li_TagIndex ] , String ( laa_Value[ li_TagIndex] ) )		
	NEXT
END IF

ls_Return = ls_Syntax

RETURN ls_Return

end function

private function integer of_loaddatamapping ();int	li_Return = -1

ids_SQLMapping = CREATE DataStore
ids_SQLMapping.DataObject = "Camirmapping.psr"

IF ids_SQLMapping.rowCount ( ) > 0 THEN
	li_Return = 1
ELSE
	THIS.of_AddError ("Profit Tools could not successfully load/locate the Camirmapping.psr.")
END IF

RETURN li_Return
end function

private function integer of_populateextendeddata ();Int		li_Return
Long		i
Long		ll_ColumnCount
String	ls_ColumnName
String	ls_Result
Int		li_SetReturn
Int		li_FailureCount

ll_ColumnCount = Long ( ids_data.Object.DataWindow.Column.Count )
FOR i = 2 TO ll_ColumnCount

	ls_ColumnName = String ( ids_data.Describe("#"+String (i)+".Name") )
	
	IF THIS.of_GetValue ( ls_ColumnName , ls_Result ) = 1 THEN
		li_SetReturn = ids_data.SetItem ( 1 , ls_ColumnName , ls_Result  )
		IF li_SetReturn <> 1 THEN
			li_FailureCount ++
		END IF
	ELSE
		li_FailureCount = -1
		EXIT
	END IF

NEXT

RETURN li_FailureCount
end function

private function integer of_getinitaldata ();Int	li_Return

If Not IsValid ( ids_data ) THEN
	ids_data = CREATE DataStore
END IF

ids_Data.DataObject = "d_camir2ddata"
ids_Data.SetTransobject( THIS.of_getcamirtransaction( )  )

IF ids_data.InsertRow ( 0 )  = 1 THEN
	li_Return = 1
ELSE
	THIS.of_AddError ( "Profit Tools could not initialize the Customs Data." )
	li_Return = -1
END IF

RETURN li_Return
end function

private function string of_resolvegettype (string as_syntax);STRING	ls_Return

IF Pos ( UPPER (as_syntax)  , Cs_TypeTag_Literal ) > 0 THEN
	ls_Return = cs_Type_literal
	
ELSEIF Pos ( UPPER (as_syntax)  , "SELECT " ) > 0 THEN // the space is intentional. 
	ls_Return = Cs_type_sqlretrieve							//  it will prevent a tag with
																		//  SELECT in it being interprited
ELSE																	//  as a select statement	
	ls_Return = cs_type_tag
	
END IF

RETURN ls_Return
end function

private function string of_gettagvalue (string as_syntax);String	ls_Syntax
String	ls_return
String	lsa_Tags[]
Any		laa_Value[]

n_cst_bso_reportmanager lnv_RptMan

ls_Syntax = as_syntax

ls_Return = THIS.of_Parsesyntax( ls_Syntax )

RETURN ls_Return
end function

private function integer of_insertcamirrecord ();Int			li_UpdateRtn = -1
Long			ll_NewRow
Long			ll_ID
String		ls_Null
DataStore	lds_Temp
Transaction	ltr_Camir

SetNull ( ls_Null )
SetNull ( ll_ID )
ltr_Camir = THIS.of_GetCamirTransaction ( )

lds_Temp = CREATE DataStore
lds_Temp.DataObject = "d_camir2ddata"
lds_Temp.SetTransobject( ltr_Camir )


IF ids_data.RowsCopy( 1,1, PRIMARY!, lds_Temp , 999999 , PRIMARY! ) = 1 THEN
	
	li_UpdateRtn = lds_Temp.Update( )
	IF li_UpdateRtn = 1 THEN
		COMMIT;
	ELSE
		THIS.of_AddError ("Profit Tools could not insert a new record into the Customs DB." )
	END IF
	
END IF

DESTROY ( lds_Temp )

RETURN li_UpdateRtn









end function

public function long of_getnewcamirid ();Long	ll_id
		
SELECT MAX ( tblcamir.camirid )
 INTO :ll_ID  
 FROM tblcamir USING itr_camir  ;

IF itr_camir.sqlcode <> 0 THEN
	RollBack;
	ll_ID = -1
	THIS.of_AddError ("Profit Tools could not determine the new Customs record ID.~r~n" + itr_camir.sqlErrtext )
ELSE
	COMMIT;
END IF

RETURN ll_ID
end function

private function string of_removecomments (string as_syntax);String	ls_Syntax
Long		ll_Start

ls_Syntax = as_syntax

ll_Start = Pos (  ls_Syntax , "//" )
IF ll_Start > 0 THEN
	ls_Syntax = Replace(ls_Syntax, ll_Start , 9999 , "" )
END IF

RETURN ls_Syntax
end function

public function integer of_exportdata (long al_sourceshipmentid);Long	ll_Return = 1

THIS.clearofrerrors( )

IF ll_Return = 1 THEN
	THIS.of_Setsourceshipmentid( al_sourceshipmentid )
	IF THIS.of_buildfile( ) <> 1 THEN		
		ll_Return = -1
	END IF
END IF


IF ll_Return = 1 THEN
	ll_Return = THIS.of_Getnewcamirid( )
END IF

RETURN ll_Return
end function

protected function integer of_adderror (string as_errortext);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_errortext 

lnv_Error.SetErrorMessage( ls_ErrorMessage )
lnv_Error.SetMessageHeader ( "Customs Data" )

RETURN 1
end function

private function integer of_connecttocamir ();Int	li_Return = 1
 
itr_camir.DBMS 		= "ODBC"
itr_camir.DBParm		= "ConnectString='DSN=Cafes2D'"

// Connect Transaction
CONNECT Using itr_camir;

IF itr_camir.sqlcode <> 0 then
	THIS.of_AddError ( "Profit Tools could not connect to the Cafes2D Data Source.~r~n~r~n" + itr_camir.SqlErrtext )
	li_Return = -1	
END IF

RETURN li_Return
end function

private function transaction of_getcamirtransaction ();RETURN itr_camir
end function

private function string of_getliteralvalue (string as_syntax);String	ls_Return
String	ls_Syntax

ls_Syntax = as_syntax

ls_Return = THIS.of_Globalreplace( ls_Syntax , THIS.cs_typetag_literal , "")

RETURN ls_Return
end function

private function string of_globalreplace (string as_source, string as_old, string as_new);Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new)  Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get the string lenghts
ll_OldLen = Len(as_Old)
ll_NewLen = Len(as_New)

as_old = Lower(as_old)
ls_source = Lower(as_source)

//Search for the first occurrence of as_Old
ll_Start = Pos(ls_Source, as_Old)

Do While ll_Start > 0
	// replace as_Old with as_New
	as_Source = Replace(as_Source, ll_Start, ll_OldLen, as_New)
	
	ls_source = Lower(as_source)
	
	
	// find the next occurrence of as_Old
	ll_Start = Pos(ls_Source, as_Old, (ll_Start + ll_NewLen))
Loop

Return as_Source

end function

public function integer of_showerrormessages ();int 		li_errorCount
int		i
String	ls_ErrorString

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = upperBound(lnva_Error)

For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() )
next

MessageBox("Customs Export" , ls_ErrorString , EXCLAMATION! )

RETURN -1
end function

private function integer of_buildfile ();Int	li_Return = 1
Long	ll_NewID


IF li_Return = 1 THEN
	IF THIS.of_Connecttocamir( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_Loaddatamapping( ) <> 1 THEN 
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_getinitaldata( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_populateextendeddata( ) <> 0 THEN // returns the number of failed 'Sets'
		li_Return = -1										//	or -1 on internal error
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_insertcamirrecord( ) <> 1 THEN
		li_Return = -1	
	END IF
END IF

RETURN li_Return
	
	

end function

private function integer of_getsqlretrievevalue (ref string as_syntax);Int		li_Return = 1
String	ls_Syntax
Long		ll_RowCount

DataStore	lds_Temp

lds_Temp = CREATE DataStore
lds_Temp.DataObject = "d_temp"
lds_Temp.SetTransObject ( SQLCA )

ls_Syntax = as_syntax

IF li_Return = 1 THEN
	IF Pos ( UPPER ( ls_Syntax ) , "UPDATE" ) > 0 THEN
		ls_Syntax = ""
		li_Return = -1
		THIS.of_Adderror( "The Customs export utility is not authorized to execute UPDATE statements.")
	END IF
END IF

IF li_Return = 1 THEN
	IF Pos ( UPPER ( ls_Syntax ) , "DELETE" ) > 0 THEN
		ls_Syntax = ""
		li_Return = -1
		THIS.of_Adderror( "The Customs export utility is not authorized to execute DELETE statements.")
	END IF
END IF

IF li_Return = 1 THEN
	IF Pos ( UPPER ( ls_Syntax ) , "INSERT" ) > 0 THEN
		ls_Syntax = ""
		li_Return = -1
		THIS.of_Adderror( "The Customs export utility is not authorized to execute INSERT statements.")
	END IF
END IF

IF li_Return = 1 THEN
	IF ls_Syntax <> "" THEN
		lds_Temp.setsqlselect( ls_Syntax )
		ll_RowCount  = lds_Temp.Retrieve ( )
	END IF		
END IF

IF li_Return = 1 THEN
	IF ll_RowCount = 1 THEN
		ls_Syntax = lds_Temp.GetItemString ( 1 , "value1" )
	END IF
END IF

as_Syntax = ls_Syntax

DESTROY ( lds_Temp )

RETURN li_Return

end function

private function integer of_getvalue (string as_column, ref string as_value);Int		li_ReturnValue = 1
String	ls_ReturnValue
String	ls_Value
String	ls_Syntax

ls_Syntax = THIS.of_GetSyntaxforcolumn( as_column )

CHOOSE CASE THIS.of_ResolveGetType( ls_Syntax )

	CASE THIS.cs_type_sqlretrieve
		
		ls_Syntax = THIS.of_Removecomments( ls_Syntax )
		ls_Syntax = THIS.of_ParseSyntax ( ls_Syntax )		
		IF THIS.of_Getsqlretrievevalue( ls_Syntax ) <> 1 THEN
			li_ReturnValue = -1
		ELSE
			ls_ReturnValue = ls_Syntax
		END IF
	
	CASE THIS.cs_type_tag
		
		ls_Syntax = THIS.of_Removecomments( ls_Syntax )
		ls_ReturnValue = THIS.of_GetTagValue ( ls_Syntax )
		
	CASE THIS.cs_Type_Literal
		
		ls_Syntax = THIS.of_Removecomments( ls_Syntax )
		ls_ReturnValue = THIS.of_GetLiteralValue ( ls_Syntax )
		
END CHOOSE
	
IF Len ( ls_ReturnValue ) = 0 THEN
	SetNull ( ls_ReturnValue )
END IF

as_value = ls_ReturnValue

RETURN li_ReturnValue


end function

public function datastore of_getdatasource ();RETURN ids_data
end function

on n_cst_bso_edimanager_camir.create
call super::create
end on

on n_cst_bso_edimanager_camir.destroy
call super::destroy
end on

event destructor;call super::destructor;Destroy ( ids_data )
Disconnect USING itr_camir;
Destroy ( itr_camir )
end event

event constructor;call super::constructor;itr_camir = CREATE transaction
end event

