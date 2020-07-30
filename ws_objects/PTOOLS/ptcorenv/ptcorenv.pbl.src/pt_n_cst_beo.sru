$PBExportHeader$pt_n_cst_beo.sru
forward
global type pt_n_cst_beo from nonvisualobject
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070731
//Long			sl_ContextCompany // this is used primarily for getting alias values.
////end modification Shared Variables by appeon  20070731
end variables

global type pt_n_cst_beo from nonvisualobject
event type integer ue_getvalueany ( readonly string as_attribute,  ref any aa_value )
event type integer ue_getstringformat ( readonly string as_attribute,  ref string as_format )
event type integer ue_getobject ( readonly string as_objectname,  ref any aaa_beo[] )
event type integer ue_formatvalue ( readonly string as_attribute,  readonly any aa_value,  readonly string as_format,  ref string as_formattedvalue )
event type integer ue_getvalueanywithparmstring ( string as_attribute,  ref any aa_value )
event type integer ue_getvalueanywithparmobject ( string as_attribute,  n_cst_msg anv_msg,  ref any aa_value )
event type integer ue_setvalueany ( string as_attribute,  any aa_value )
end type
global pt_n_cst_beo pt_n_cst_beo

type variables
Private:
DataWindow	idw_Source
DataStore	ids_Source
Long		il_SourceId
String		is_KeyColumn
Boolean		ib_CreateOnDemand
Boolean		ib_AllowFilterSet = FALSE
Long		il_RowId
Boolean		ib_OriginalValueMode = FALSE
String		isa_Errors[]

n_cst_bso   inv_Context

Protected:
String		is_Topic
String		is_DocumentType     //RDT 092602

//begin modification Shared Variables by appeon  20070731
Long			sl_ContextCompany // this is used primarily for getting alias values.
//end modification Shared Variables by appeon  20070731

end variables

forward prototypes
public function integer of_setsource (powerobject apo_source)
public function integer of_setsourceid (long al_sourceid)
public function integer of_setkeycolumn (string as_keycolumn)
private function string of_getkeycolumn ()
public function powerobject of_getsource ()
private function string of_getfindexpression ()
protected function any of_getvalue (string as_attribute, parmtype ae_type)
protected function integer of_setany (string as_attribute, any aa_value)
public function boolean of_hassource ()
public function integer of_setcreateondemand (boolean ab_createondemand)
public function boolean of_getcreateondemand ()
public function integer of_clearsource ()
public function integer of_setusecache (boolean ab_switch)
public function integer of_setsourcerow (long al_row)
public function boolean of_isdeleted ()
public function long of_getsourceid ()
public function integer of_getsourcerow (ref long al_row, ref dwbuffer ae_buffer, readonly boolean ab_createifpermitted)
public function integer of_getvaluestring (readonly string as_attribute, ref string as_value)
public function integer of_getvalueany (readonly string as_attribute, ref any aa_value)
public function integer of_getvaluestring (string as_attribute, ref string as_value, readonly string as_format)
public function integer of_setallowfilterset (boolean ab_allowfilterset)
public function integer of_setoriginalvaluemode (readonly boolean ab_switch)
public function boolean of_getoriginalvaluemode ()
public function long of_adderror (readonly string as_error)
public subroutine of_clearerrors ()
public function string of_geterrorstring ()
public function long of_geterrors (ref string asa_errors[])
public function string of_geterrorstring (readonly boolean ab_clearerrors)
public function string of_geterrorstring (readonly string as_delimiter, readonly boolean ab_clearerrors)
public function long of_geterrorcount ()
public function long of_adderrors (string asa_errors[])
public function long of_geterrors (ref string asa_errors[], readonly boolean ab_clearerrors)
public function long of_getsourcerow ()
public function integer of_getobject (string as_objectname, ref any aaa_beo[])
public function string of_getnotificationtemplate ()
public function string of_getnotificationsubject ()
public function string of_gettopic ()
public function integer of_getnotificationtargets (ref Long ala_emailtargets[])
public function integer of_setdocumenttype (string as_documenttype)
public function string of_getdocumenttype ()
public function boolean of_sendnotification ()
public function integer of_setcontext (n_cst_bso anv_Context)
public function n_Cst_bso of_getcontext ()
public function boolean of_sendnotification (long al_ID)
public function integer of_getreferencedentities (ref pt_n_cst_beo anv_objects[])
public function integer of_showuseralerts ()
public function integer of_adduseralert (string as_msgtext)
public function integer of_adduseralert ()
public function integer of_showuseralerts (string as_message, long al_messageid)
public function integer of_setcontextcompany (long al_coid)
public function long of_getcontextcompanyid ()
public function long of_getdivisionid ()
end prototypes

event ue_getvalueany;//Returns: 1 = Got value successfully, 0 = Requested Attribute not found, -1 = Error

//Extend in descendants to process available attributes on the individual beo.

Integer	li_Return = 0

//If the attribute is a candidate for being a parameterized attribute by virtue of
//containing a "(", try to process it that way first.  If it processes successfully, 
//or is parameterized but fails, the return value will be 1 or -1 and descendants 
//need not attempt to reprocess the attribute.  If it does not resolve out, the return
//value will remain 0, and descendants can attempt to process it.

IF Pos ( as_Attribute, "(" ) > 0 THEN

	li_Return = This.Event ue_GetValueAnyWithParmString ( as_Attribute, aa_Value )

END IF


RETURN li_Return
end event

event ue_getstringformat;//Returns: 1 = Got value successfully, 0 = Requested Attribute Format not found, -1 = Error

//Extend in descendants to process get available formats for the individual beo.

RETURN 0
end event

event ue_getobject;//Returns: 1 = Got object(s) successfully (although the list may be empty, if there are no references),
//0 = Requested Object Name not valid, -1 = Processing Error

//Note:  Return 1 (Not 0 or -1) and an empty array if the request is correct 
//but the referenced object has not been specified (null foreign key).

//Extend in descendants to process get available objects for the individual beo.

RETURN 0
end event

event type integer ue_formatvalue(readonly string as_attribute, readonly any aa_value, readonly string as_format, ref string as_formattedvalue);//Returns: 	 1 = Successfully applied formatting to the value, whether from as_Format or 
//					a special formatting defined in the descendant.   
//				 0 = No formatting applied to value.  as_FormattedValue will be straight cast of aa_Value as String
//				-1 = Error

//Note:  If as_Format is not null, we'll apply it to aa_Value, which would usually supersede special formatting
//specified in the descendant  (although the descendant could perform processing even if li_Return is already 1).

Integer	li_Return = 0
Long		ll_index

IF POS ( as_format , "NODECIMAL" ) > 0 THEN
	IF pos(String ( aa_value ) ,'.') > 0 THEN			
		as_formattedvalue = replace(String ( aa_value ),pos(String ( aa_value ),'.'),1,'')
		li_Return = 1
	END IF
ELSEIF POS ( as_format , "NOPUNCTUATION" ) > 0 THEN
	//added this section by dan 8-2-06
	//strips out all punctuation from a string.
	FOR ll_index = 1 TO len( string( aa_value ) )
		IF MATCH((MID( string(aa_value), ll_index, 1 )) , "^[0-9a-zA-Z]+$"	) THEN
			as_formattedvalue += MID( string(aa_value), ll_index, 1 )		
		END IF
		li_Return = 1
	NEXT
ELSE

	IF IsNull ( as_Format ) THEN
		as_FormattedValue = String ( aa_Value )
		//Leave li_Return = 0
	ELSE
		as_FormattedValue = String ( aa_Value, as_Format )
		li_Return = 1
	END IF
	
END IF

RETURN li_Return
end event

event ue_getvalueanywithparmstring;//Returns: 1 = Got value successfully, 
//0 = Requested Attribute not found (or parm list not present)
//-1 = Error

//Parses out the Parms in as_Attribute, and forwards the request to 
//ue_GetValueAnyWithParmObject for processing.

String	ls_ParmString, &
			lsa_Parms[]
Integer	li_ParmPos, &
			li_DelimPos, &
			li_ParmCount, &
			li_Index
n_cst_String	lnv_String
n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

Integer	li_Return = 0

IF li_Return = 0 THEN

	IF Match ( as_Attribute, ".+(.*)$" ) THEN

		li_ParmPos = Pos ( as_Attribute, "(" )

		IF li_ParmPos > 1 THEN

			//Pull out everything after the "("
			ls_ParmString = Mid ( as_Attribute, li_ParmPos + 1 )
			//Drop the closing ")"
			ls_ParmString = Left ( ls_ParmString, Len ( ls_ParmString ) - 1 )
	
			//Get the actual attribute label
			as_Attribute = Left ( as_Attribute, li_ParmPos - 1 )

			li_ParmCount = lnv_String.of_ParseToArray ( ls_ParmString, ",", lsa_Parms )
			
			FOR li_Index = 1 TO li_ParmCount

				li_DelimPos = Pos ( lsa_Parms [ li_Index ], "=" )

				IF li_DelimPos > 1 THEN
					lstr_Parm.is_Label = Left ( lsa_Parms [ li_Index ], li_DelimPos - 1 )
					lstr_Parm.ia_Value = Mid ( lsa_Parms [ li_Index ], li_DelimPos + 1 )
					lnv_Msg.of_Add_Parm ( lstr_Parm )
				END IF

			NEXT

			li_Return = This.Event ue_GetValueAnyWithParmObject ( as_Attribute, lnv_Msg, aa_Value )

		ELSE

			li_Return = -1

		END IF

	END IF

END IF

RETURN li_Return
end event

event ue_getvalueanywithparmobject;//Returns: 1 = Got value successfully, 0 = Requested Attribute not found, -1 = Error

//Extend in descendant to provide support for parameterized attributes.

RETURN 0
end event

event ue_setvalueany;RETURN -1
end event

public function integer of_setsource (powerobject apo_source);DataWindow	ldw_Source
DataStore	lds_Source
n_cst_Dws	lnv_Dws
Integer		li_Return

CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( apo_Source, ldw_Source, lds_Source )

CASE DataWindow!, DataStore!

	idw_Source = ldw_Source
	ids_Source = lds_Source
	SetNull ( il_RowId )

	//We're dealing with a new target.  Clear any leftover errors.
	This.of_ClearErrors ( )

	li_Return = 1

CASE ELSE

	li_Return = -1

END CHOOSE

RETURN li_Return
end function

public function integer of_setsourceid (long al_sourceid);Integer	li_Return
Long		ll_OldSourceID

IF IsNull ( al_SourceId ) THEN
	li_Return = -1
ELSE
	
	//ll_oldSourceID = il_sourceid
	il_SourceId = al_SourceId
	SetNull ( il_RowId )
//	IF IsNull ( ll_OldSourceID) OR ll_OldSourceID <> al_sourceid  AND NOT gnv_app.of_runningscheduledtask( ) THEN
//		THIS.of_Showuseralerts( )
//	END IF
	
	
	
	//Note: We'll leave il_RowId to be determined at by the next GetSourceRow call.

	//We're dealing with a new target.  Clear any leftover errors.
	This.of_ClearErrors ( )

	li_Return = 1
END IF

RETURN li_Return
end function

public function integer of_setkeycolumn (string as_keycolumn);Integer	li_Return

as_KeyColumn = Lower ( Trim ( as_KeyColumn ) )

IF Len ( as_KeyColumn ) > 0 THEN
	is_KeyColumn = as_KeyColumn
	li_Return = 1
ELSE
	li_Return = -1
END IF

RETURN li_Return
end function

private function string of_getkeycolumn ();RETURN is_KeyColumn
end function

public function powerobject of_getsource ();PowerObject	lpo_Source

IF IsValid ( idw_Source ) THEN
	lpo_Source = idw_Source
ELSEIF IsValid ( ids_Source ) THEN
	lpo_Source = ids_Source
END IF

RETURN lpo_Source
end function

private function string of_getfindexpression ();String	ls_Expression, &
			ls_KeyColumn
Long		ll_SourceId

ls_KeyColumn = This.of_GetKeyColumn ( )
ll_SourceId = This.of_GetSourceId ( )

IF IsNull ( ls_KeyColumn ) OR IsNull ( ll_SourceId ) THEN
	SetNull ( ls_Expression )
ELSE
	ls_Expression = ls_KeyColumn + " = " + String ( ll_SourceId )
END IF

RETURN ls_Expression
end function

protected function any of_getvalue (string as_attribute, parmtype ae_type);Any	la_Value
Long	ll_SourceRow
DWBuffer		le_Buffer
n_cst_Dws	lnv_Dws
n_cst_Conversion	lnv_Conversion
PowerObject	lpo_Source
Boolean		lb_GetOriginalValue
Integer		li_Result

lpo_Source = This.of_GetSource ( )

CONSTANT Boolean	lb_CreateIfPermitted = TRUE
li_Result = This.of_GetSourceRow ( ll_SourceRow, le_Buffer, lb_CreateIFPermitted )

IF IsValid ( lpo_Source ) AND li_Result = 1 THEN

	lb_GetOriginalValue = This.of_GetOriginalValueMode ( )

	CHOOSE CASE ae_Type
	
	CASE TypeInteger!, TypeLong!, TypeDouble!
		la_Value = lnv_Dws.of_GetItemNumber ( lpo_Source, ll_SourceRow, as_Attribute, le_Buffer, lb_GetOriginalValue )

	CASE TypeDecimal!
		la_Value = lnv_Dws.of_GetItemDecimal ( lpo_Source, ll_SourceRow, as_Attribute, le_Buffer, lb_GetOriginalValue )

	CASE TypeString!
		la_Value = lnv_Dws.of_GetItemString ( lpo_Source, ll_SourceRow, as_Attribute, le_Buffer, lb_GetOriginalValue )
	
	CASE TypeDate!
		la_Value = lnv_Dws.of_GetItemDate ( lpo_Source, ll_SourceRow, as_Attribute, le_Buffer, lb_GetOriginalValue )
	
	CASE TypeTime!
		la_Value = lnv_Dws.of_GetItemTime ( lpo_Source, ll_SourceRow, as_Attribute, le_Buffer, lb_GetOriginalValue )
	
	CASE TypeDateTime!
		la_Value = lnv_Dws.of_GetItemDateTime ( lpo_Source, ll_SourceRow, as_Attribute, le_Buffer, lb_GetOriginalValue )
	
	CASE ELSE
	
	END CHOOSE

ELSE

	lnv_Conversion.of_SetAnyType ( la_Value, ae_Type )

END IF

RETURN la_Value
end function

protected function integer of_setany (string as_attribute, any aa_value);//Returns : 1 = Success, -1 = Error, Null = Could not resolve target, or target is not available
// (Source row can't be found, is in delete, or is in filter with AllowFilterSet = False )
// -2 = Found source in filter, moved it to primary to perform set, and then couldn't move it back.

//Note : The return values on this definitely aren't consistent with Riverton

Long			ll_SourceRow
DWBuffer		le_Buffer
n_cst_Dws	lnv_Dws
PowerObject	lpo_Source
Integer		li_Result
INT			li_MoveRtn

Integer		li_Return
SetNull ( li_Return )

lpo_Source = This.of_GetSource ( )

CONSTANT Boolean	lb_CreateIfPermitted = TRUE
li_Result = This.of_GetSourceRow ( ll_SourceRow, le_Buffer, lb_CreateIFPermitted )


IF li_Result = 1 AND ll_SourceRow > 0  THEN
	
	CHOOSE CASE le_Buffer 
			
		CASE Primary! 
	
			li_Result = lnv_Dws.of_SetItem ( lpo_Source, ll_SourceRow, as_Attribute, aa_Value )

			IF IsNull ( li_Result ) THEN
				SetNull ( li_Return )

			ELSEIF li_Result = 1 THEN
				li_Return = 1

			ELSEIF li_Result = -1 THEN
				li_Return = -1

			ELSE  //Unexpected Return
				li_Return = -1

			END IF
			
		CASE FILTER!
			
			IF ib_allowFilterSet THEN
				// move row into the primary buffer
				li_MoveRtn = lnv_Dws.of_RowsMove ( lpo_Source , ll_SourceRow , ll_SourceRow , FILTER! , lpo_Source, 999999 ,  PRIMARY! ) 
				
				IF li_MoveRtn = 1 THEN
					// get the row in the primary buffer			
					li_Result = This.of_GetSourceRow ( ll_SourceRow, le_Buffer, lb_CreateIFPermitted )
				
					IF li_Result = 1 THEN // set item in the Primary buffer 
						li_Result = lnv_Dws.of_SetItem ( lpo_Source, ll_SourceRow, as_Attribute, aa_Value )

						IF IsNull ( li_Result ) THEN
							SetNull ( li_Return )
			
						ELSEIF li_Result = 1 THEN
							li_Return = 1
			
						ELSEIF li_Result = -1 THEN
							li_Return = -1
			
						ELSE  //Unexpected Return
							li_Return = -1
			
						END IF

						// move the row back to filter			
						li_MoveRtn = lnv_Dws.of_RowsMove ( lpo_Source , ll_SourceRow , ll_SourceRow , PRIMARY! , lpo_Source, 999999 ,  FILTER! ) 

						IF li_MoveRtn = 1 THEN
							//Moved back to filter successfully.
						ELSE
							//Could not move back to filter.
							li_Return = -2
						END IF

					ELSE  //Could not find the row now that we've moved it to primary!
							//This shouldn't happen, but is ugly if it does.  No graceful way to handle it.

						li_Return = -2

					END IF

				ELSE   //Found the target, but error attempting to move it.
					li_Return = -1
					
				END IF
				
			ELSE  //Instance setting says we're not allowed to perform sets on the target in the filter buffer.
				SetNull ( li_Return )
			END IF

		CASE ELSE  //Row is not in a buffer we can handle  (ie, Delete!)
			SetNull ( li_Return )
			
	END CHOOSE
ELSE

	SetNull ( li_Return )

END IF

RETURN li_Return
end function

public function boolean of_hassource ();Long		ll_Row
DWBuffer	le_Buffer
Boolean	lb_HasSource

IF This.of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't Create if Permitted*/ ) = 1 THEN
	lb_HasSource = TRUE
END IF

RETURN lb_HasSource
end function

public function integer of_setcreateondemand (boolean ab_createondemand);IF IsNull ( ab_CreateOnDemand ) THEN
	RETURN -1
ELSE
	ib_CreateOnDemand = ab_CreateOnDemand
	RETURN 1
END IF
end function

public function boolean of_getcreateondemand ();RETURN ib_CreateOnDemand
end function

public function integer of_clearsource ();DataWindow	ldw_Source
DataStore	lds_Source

idw_Source = ldw_Source
ids_Source = lds_Source

SetNull ( il_RowId )

RETURN 1
end function

public function integer of_setusecache (boolean ab_switch);RETURN -1
end function

public function integer of_setsourcerow (long al_row);//Note: The reference to the row is not retained.  This just gets the id for al_Row, 
//and then sets the id as usual.

//Returns : 1, -1

Long			ll_Id, &
				ll_RowId
Integer		li_Return
n_cst_Dws	lnv_Dws

IF al_Row <= lnv_Dws.of_RowCount ( This.of_GetSource ( ) ) AND &
	al_Row > 0 THEN

	ll_Id = lnv_Dws.of_GetItemNumber ( This.of_GetSource ( ), al_Row, This.of_GetKeyColumn ( ) )

	li_Return = This.of_SetSourceId ( ll_Id )

	IF li_Return = 1 THEN

		ll_RowId = lnv_Dws.of_GetRowIdFromRow ( This.of_GetSource ( ), al_Row, Primary! )

		IF ll_RowId > 0 THEN
			il_RowId = ll_RowId
		END IF

		//We're dealing with a new target.  Clear any leftover errors.
		This.of_ClearErrors ( )

	END IF

ELSE

	li_Return = -1

END IF

RETURN li_Return
end function

public function boolean of_isdeleted ();//Returns:  TRUE, FALSE, Null ( if object is not in cache and status cannot be determined).

Long		ll_Row
DWBuffer	le_Buffer
Boolean	lb_IsDeleted

IF This.of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't Create if Permitted*/ ) = 1 THEN

	IF le_Buffer = Delete! THEN
		lb_IsDeleted = TRUE
	END IF

ELSE  //Object is not in the Source datastore.  Deletion cannot be determined.
	SetNull ( le_Buffer )

END IF

RETURN lb_IsDeleted
end function

public function long of_getsourceid ();RETURN il_SourceId	
end function

public function integer of_getsourcerow (ref long al_row, ref dwbuffer ae_buffer, readonly boolean ab_createifpermitted);//Returns: 1, -1

PowerObject	lpo_Source
n_cst_dws	lnv_Dws
Long	ll_SourceRow, &
		ll_CreatedRow, &
		ll_FilteredCount, &
		ll_DeletedCount, &
		ll_RowId, &
		ll_CheckRow
DWBuffer	le_Buffer, &
			le_CheckBuffer
String	ls_KeyColumn

Integer	li_Return = -1

lpo_Source = This.of_GetSource ( )
ls_KeyColumn = This.of_GetKeyColumn ( )


IF li_Return = -1 THEN

	IF il_RowId > 0 THEN
	
		CHOOSE CASE lnv_Dws.of_GetRowFromRowId ( lpo_Source, il_RowId, ll_SourceRow, le_Buffer )
	
		CASE 1  //Success
	
			IF le_Buffer = Delete! THEN
				//Ignore it.  We've had some freaky behavior with this.  When rows have been deleted,
				//it will sometimes incorrectly resolve a RowId to the delete buffer when the row
				//you want is in one of the other buffers.
			ELSE
				li_Return = 1
			END IF
	
		CASE 0

			//Row not found
	
		CASE ELSE  //-1
	
			//Error
	
		END CHOOSE
	
	END IF

END IF


IF li_Return = -1 THEN

	IF NOT IsNull ( il_SourceId ) THEN

		//Check the primary buffer
		ll_SourceRow = lnv_Dws.of_Find ( lpo_Source, This.of_GetFindExpression ( ) )

		IF ll_SourceRow > 0 THEN

			le_Buffer = Primary!
			li_Return = 1
		
		END IF


		//If still no luck, try the filter buffer.

		IF li_Return = -1 THEN

			ll_FilteredCount = lnv_Dws.of_FilteredCount ( lpo_Source )
		
			IF ll_FilteredCount > 0 THEN
				le_Buffer = Filter!
		
				FOR ll_SourceRow = 1 TO ll_FilteredCount

					IF lnv_Dws.of_GetItemNumber ( lpo_Source, ll_SourceRow, ls_KeyColumn, le_Buffer, FALSE ) = il_SourceId THEN
						li_Return = 1
						EXIT
					END IF

				NEXT
		
			END IF
		END IF


		//If still no luck, try the delete buffer.  (DO WE REALLY WANT TO DO THIS??)
		//(IF THE OBJECT'S BEEN DELETED, SHOULD IT STILL FUNCTION??)

		IF li_Return = -1 THEN

			ll_DeletedCount = lnv_Dws.of_DeletedCount ( lpo_Source )
		
			IF ll_DeletedCount > 0 THEN
				le_Buffer = Delete!
		
				FOR ll_SourceRow = 1 TO ll_DeletedCount

					IF lnv_Dws.of_GetItemNumber ( lpo_Source, ll_SourceRow, ls_KeyColumn, le_Buffer, FALSE ) = il_SourceId THEN
						li_Return = 1
						EXIT
					END IF

				NEXT
		
			END IF
		END IF


		//IF a match was found, get the rowid and record it.

		IF li_Return = 1 THEN

			ll_RowId = lnv_Dws.of_GetRowIdFromRow ( lpo_Source, ll_SourceRow, le_Buffer )

			IF ll_RowId > 0 THEN  //Will not be valid if row hasn't been in primary buffer yet.

				il_RowId = ll_RowId

			END IF

		END IF

	END IF

END IF


//If the row was not identified, create it if permitted and requested.

IF li_Return = -1 THEN

	IF ab_CreateIfPermitted = TRUE THEN

		IF This.of_GetCreateOnDemand ( ) = TRUE THEN

			ll_CreatedRow = lnv_Dws.of_InsertRow ( lpo_Source, 0 )

			IF ll_CreatedRow > 0 THEN

				lnv_Dws.of_SetItem ( lpo_Source, ll_CreatedRow, ls_KeyColumn, &
					This.of_GetSourceId ( ) )
				//Should probably check failure and rowsdiscard if not successful
				ll_SourceRow = ll_CreatedRow
				le_Buffer = Primary!
				li_Return = 1

			END IF

		END IF

	END IF

END IF


//Set reference values to be passed out.

IF li_Return = 1 THEN

	al_Row = ll_SourceRow
	ae_Buffer = le_Buffer

ELSE

	SetNull ( al_Row )
	SetNull ( ae_Buffer )

END IF

RETURN li_Return
end function

public function integer of_getvaluestring (readonly string as_attribute, ref string as_value);//Call the overloaded version with no format specified.

String	ls_Format
SetNull ( ls_Format )

RETURN This.of_GetValueString ( as_Attribute, as_Value, ls_Format )
end function

public function integer of_getvalueany (readonly string as_attribute, ref any aa_value);RETURN This.Event ue_GetValueAny ( as_Attribute, aa_Value )
end function

public function integer of_getvaluestring (string as_attribute, ref string as_value, readonly string as_format);Any		la_Value, &
			laa_Object[]
String	ls_Format, &
			ls_FormattedValue, &
			ls_SubAttribute, &
			ls_Object, &
			ls_Value, &
			lsa_Parms[], &
			ls_Parm, &
			ls_ParmLabel, &
			ls_ParmValue
Integer	li_Result, &
			li_DotPos, &
			li_SemiPos, &
			li_ParmCount, &
			li_Index, &
			li_CharPos, &
			li_RangeLength, &
			li_RelativeDate
Long		lla_RangeLimits[]
n_cst_String	lnv_String

Integer	li_Return = 1

SetNull ( ls_Format )
SetNull ( li_RelativeDate )


//Because of LiveLoad PSR column naming restrictions, we need to support certain special
//characters with escape sequences.  Each escape sequence is replaced below with it's 
//actual value.  Note that underscore is used in conjunction with other characters to
//build some of the escape sequences.  It translates to "." when used by itself.
//The first 4 substituations are for parameterized tags.  The last substitution is for
//sub-object references.

IF Pos ( as_Attribute, "_" ) > 0 THEN

	//Replace "_aa_" with "("   Used in parameterized tags.
	as_Attribute = lnv_String.of_GlobalReplace ( as_Attribute, "_aa_", "(" )
	
	//Replace "_zz_" with ")"   Used in parameterized tags.
	as_Attribute = lnv_String.of_GlobalReplace ( as_Attribute, "_zz_", ")" )
	
	//Replace "_mm_" with ","   Used in parameterized tags.
	as_Attribute = lnv_String.of_GlobalReplace ( as_Attribute, "_mm_", "," )

	//Replace "_qq_" with "="   Used in parameterized tags.
	as_Attribute = lnv_String.of_GlobalReplace ( as_Attribute, "_qq_", "=" )
	
	//Replace "_ww_" with "{"   Used in parameterized tags.
	as_Attribute = lnv_String.of_GlobalReplace ( as_Attribute, "_ww_", "{" )
	
	//Replace "_pp_" with "}"   Used in parameterized tags.
	as_Attribute = lnv_String.of_GlobalReplace ( as_Attribute, "_pp_", "}" )
	
	//Replace "_" with "."   Used in sub-object references.
	as_Attribute = lnv_String.of_GlobalReplace ( as_Attribute, "_", "." )

END IF


li_DotPos = Pos ( as_Attribute, "." )
li_SemiPos = Pos ( as_Attribute, ";" )

//First, we need to see if the attribute is native to this object, or if it references a sub object.
//These sub-object references are made with dots "."  If the attribute is on a sub-object, we need
//to figure out which sub-object, and then forward the attribute request to it.

//Semicolons are used to delimit special formatting parameters.  Dots are used to delimit object
//references in the attribute name.  Everything up to the first semicolon (if any) is the attribute
//name.  Dots in that range delimit object references.  Dots after the first semicolon have whatever
//meaning they want in the formatting string.   

IF li_DotPos > 0 AND ( li_DotPos < li_SemiPos OR li_SemiPos = 0 ) THEN

	//It's a sub-object attribute reference.  Get the sub-object and forward the request to it.

	ls_Object = Left ( as_Attribute, li_DotPos - 1 )
	ls_SubAttribute = Mid ( as_Attribute, li_DotPos + 1 )

	CHOOSE CASE This.of_GetObject ( ls_Object, laa_Object[] )

	CASE 1

		CHOOSE CASE UpperBound ( laa_Object )

		CASE 0
			SetNull ( as_Value )
			li_Return = 1

		CASE 1

			CHOOSE CASE laa_Object[1].Dynamic of_GetValueString ( ls_SubAttribute, ls_Value )
	
			CASE 1
				as_Value = ls_Value
				li_Return = 1
	
			CASE 0
				SetNull ( as_Value )
				li_Return = 0
	
			CASE ELSE
				SetNull ( as_Value )
				li_Return = -1
	
			END CHOOSE

		CASE ELSE
			SetNull ( as_Value )
			li_Return = -1

		END CHOOSE

	CASE 0

		SetNull ( as_Value )
		li_Return = 0

	CASE ELSE

		SetNull ( as_Value )
		li_Return = -1

	END CHOOSE
	
	FOR li_Index = 1 TO upperbound(laa_Object)
		DESTROY laa_Object[li_index]
	NEXT
	
ELSE

	//The attribute request is native to this object.  Try to satisfy the request.

	//If there's extended formatting parameters on the attribute, parse them out.
	
	IF li_SemiPos > 0 THEN

		li_ParmCount = lnv_String.of_ParseToArray ( as_Attribute, ";", lsa_Parms )
		//Note:  The first "parm" will be the attribute name.
		IF li_ParmCount > 0 THEN
			as_Attribute = lsa_Parms[1]
		END IF

		//Check and see if a string format is one of the special parameters.  If so, we need to grab
		//it now, because the format must be applied before the other special formatting values.
		//(Note:  A format specified this way overrides a format that may have been passed in as an argument.)

		FOR li_Index = 2 TO li_ParmCount  //Skip over the first "parm", which is the attribute name

			ls_Parm = lsa_Parms [ li_Index ]  //Read into straight variable for easier reference
			li_CharPos = Pos ( ls_Parm, "=" )  //Determine location of label / value split

			IF li_CharPos > 0 THEN
				//There is a label and value.  Read them out.
				ls_ParmLabel = Trim ( Left ( ls_Parm, li_CharPos - 1 ) )  //Trim the label

				IF Upper ( ls_ParmLabel ) = "FORMAT" THEN

					ls_ParmValue = Mid ( ls_Parm, li_CharPos + 1 )  //Don't trim the value
					//Since we're using semicolons to delimit our values list, the user can't use
					//semicolons to delimit their format, as PB requires.  So, they have to use "|" 
					//(the character you get with shift-backslash.)  Here, we need to convert these
					//delimiters to the real thing.
					ls_Format = lnv_String.of_GlobalReplace ( ls_ParmValue, "|", ";" )

					//Clear this entry from the Parms list, and exit the loop
					lsa_Parms [ li_Index ] = ""
					//EXIT  -- Commented because we now have another option, so we need to check all parms

				ELSEIF Upper ( ls_ParmLabel ) = "RELDATE" THEN

					ls_ParmValue = Mid ( ls_Parm, li_CharPos + 1 )
					IF IsNumber ( ls_ParmValue ) THEN
						li_RelativeDate = Integer ( ls_ParmValue )
					END IF
					lsa_Parms [ li_Index ] = ""

				END IF					

			END IF

		NEXT

	END IF


	//Get the raw attribute value.

	IF li_Return = 1 THEN
	
		li_Result = This.Event ue_GetValueAny ( as_Attribute, la_Value )
		
		CHOOSE CASE li_Result
	
		CASE 1
			//Got a value.  Proceed to formatting.
	
		CASE 0
			//Allow value to be passed in (1/19/06 - MFS)
			IF NOT isNull(as_Value) AND Len(as_Value) > 0 THEN 
				la_Value = as_Value
				li_Return = 1
			ELSE
				li_Return = 0
			END IF
	
		CASE ELSE //-1
			li_Return = -1
	
		END CHOOSE
	
	END IF
	

	//If no format was specified in the attribute request, see if one was passed in,
	//or if there's a default format.

	IF li_Return = 1 AND IsNull ( ls_Format ) THEN
	
		IF IsNull ( as_Format ) THEN
			IF This.Event ue_GetStringFormat ( as_Attribute, ls_Format ) < 1 THEN
				SetNull ( ls_Format )  //Should still be null, but j.i.c.
			END IF
		ELSE
			ls_Format = as_Format
		END IF
	
	END IF
	

	//If a RelativeDate parameter was supplied, apply it to the raw date value.

	IF li_Return = 1 AND NOT IsNull ( li_RelativeDate ) THEN

		IF NOT IsNull ( la_Value ) THEN

			IF ClassName ( la_Value ) = "date" THEN

				la_Value = RelativeDate ( la_Value, li_RelativeDate )
			END IF

		END IF

	END IF

	
	//Format the raw attribute value.

	IF li_Return = 1 THEN
	
		CHOOSE CASE This.Event ue_FormatValue ( as_Attribute, la_Value, ls_Format, ls_FormattedValue )
	
		CASE 1  //Formatting was applied (either ls_Format, if not null, or a special format from the beo).
			as_Value = ls_FormattedValue
	
		CASE 0  //No formatting was applied -- ls_FormattedValue is a straight cast of la_Value as String.
			as_Value = ls_FormattedValue
	
		CASE ELSE //-1
			SetNull ( as_Value )
			li_Return = -1
	
		END CHOOSE
	
	ELSE
		SetNull ( as_Value )
	END IF


	//If other special formatting parameters were supplied, apply them to the value string.

	IF li_Return = 1 AND li_ParmCount > 1 THEN  //First "parm" is just the attribute name

		//Loop through the parms and apply special formatting

		FOR li_Index = 2 TO li_ParmCount  //First "parm" is just the attribute name

			ls_Parm = lsa_Parms [ li_Index ]  //Read into straight variable for easier reference
			li_CharPos = Pos ( ls_Parm, "=" )  //Determine location of label / value split

			IF li_CharPos > 0 THEN
				//There is a label and value.  Read them out.
				ls_ParmLabel = Trim ( Left ( ls_Parm, li_CharPos - 1 ) )  //Trim the label
				ls_ParmValue = Mid ( ls_Parm, li_CharPos + 1 )  //Don't trim the value
			ELSE
				//There is only a label.
				ls_ParmLabel = Trim ( ls_Parm )
				ls_ParmValue = ""
			END IF


			//Apply the requested special formatting.

			CHOOSE CASE Upper ( ls_ParmLabel )

			CASE "RANGE"

				as_Value = lnv_String.of_RemoveNonPrint ( as_Value )

				CHOOSE CASE lnv_String.of_ParseToArray ( ls_ParmValue, ",", lla_RangeLimits )
					//Return value of ParseToArray is number of elements in the result set.

				CASE 1  //Lower limit and up

					as_Value = Mid ( as_Value, lla_RangeLimits [ 1 ] )

				CASE 2

					li_RangeLength = lla_RangeLimits [ 2 ] - lla_RangeLimits [ 1 ] + 1
					as_Value = Mid ( as_Value, lla_RangeLimits [ 1 ], li_RangeLength )

				CASE ELSE  //Improperly formatted range value string

					//Cannot process request -- return null value.
					SetNull ( as_Value )

				END CHOOSE

			END CHOOSE

		NEXT

	END IF

END IF

RETURN li_Return
end function

public function integer of_setallowfilterset (boolean ab_allowfilterset);ib_AllowFilterSet = ab_AllowFilterSet
RETURN 1
end function

public function integer of_setoriginalvaluemode (readonly boolean ab_switch);ib_OriginalValueMode = ab_Switch
RETURN 1
end function

public function boolean of_getoriginalvaluemode ();RETURN ib_OriginalValueMode
end function

public function long of_adderror (readonly string as_error);//Adds an error to the error list.
//Returns:  >= 0 : The number of errors in the list after the addition.

Long	ll_Index

ll_Index = UpperBound ( isa_Errors ) + 1

isa_Errors [ ll_Index ] = as_Error

RETURN ll_Index
end function

public subroutine of_clearerrors ();//Clears the error list.  Note: This is called by default by GetErrors and GetErrorString, 
//unless it is requested by parameter that the list be preserved.

String	lsa_Empty[]

isa_Errors = lsa_Empty
end subroutine

public function string of_geterrorstring ();//Concatenates the error list into a string using the default delimiter, and clears the list.

Constant Boolean	lb_ClearErrors = TRUE

RETURN This.of_GetErrorString ( lb_ClearErrors )
end function

public function long of_geterrors (ref string asa_errors[]);//Passes out the error list, and then clears the list.
//Returns:  >= 0 : The number of errors in the list being passed out.

Constant Boolean	lb_ClearErrors = TRUE  //Clear errors by default

RETURN This.of_GetErrors ( asa_Errors, lb_ClearErrors )
end function

public function string of_geterrorstring (readonly boolean ab_clearerrors);//Concatenates the error list into a string using the default delimiter, 
//and optionally clears the list, according to ab_ClearErrors.

Constant String	ls_Delimiter = "~n~n"  //Double Space by default

RETURN This.of_GetErrorString ( ls_Delimiter, ab_ClearErrors )
end function

public function string of_geterrorstring (readonly string as_delimiter, readonly boolean ab_clearerrors);//Concatenates the error list into a string using the delimiter provided in as_Delimiter, 
//and optionally clears the list, according to ab_ClearErrors.

String	lsa_Errors[], &
			ls_ErrorString
Long		ll_ErrorCount
n_cst_String	lnv_String

ll_ErrorCount = This.of_GetErrors ( lsa_Errors, ab_ClearErrors )

lnv_String.of_ArrayToString ( lsa_Errors, as_Delimiter, ls_ErrorString )

RETURN ls_ErrorString
end function

public function long of_geterrorcount ();//Returns:  >= 0 : The number of errors in the error list.

RETURN UpperBound ( isa_Errors )
end function

public function long of_adderrors (string asa_errors[]);//Adds a set of errors to the error list.
//Returns:  >= 0 : The number of errors in the list after the addition.

Long	ll_Index, &
		ll_Count

ll_Count = UpperBound ( asa_Errors )

FOR ll_Index = 1 TO ll_Count

	This.of_AddError ( asa_Errors [ ll_Index ] )

NEXT

RETURN This.of_GetErrorCount ( )
end function

public function long of_geterrors (ref string asa_errors[], readonly boolean ab_clearerrors);//Passes out the error list, and optionally clears the list, according to ab_ClearErrors.
//Returns:  >= 0 : The number of errors in the list being passed out.

asa_Errors = isa_Errors

IF ab_ClearErrors THEN
	This.of_ClearErrors ( )
END IF

RETURN UpperBound ( asa_Errors )
end function

public function long of_getsourcerow ();//If the beo's source is an existing row in the primary buffer, returns the row number.
//If the beo has a valid, existing source but it's not in the primary buffer, returns 0.
//If the beo does not have a valid, existing source, returns -1.

Long		ll_Row
dwBuffer	le_Buffer

Long		ll_Return = -1

IF This.of_GetSourceRow ( ll_Row, le_Buffer, FALSE /*Don't create*/ ) = 1 THEN

	IF le_Buffer = Primary! AND ll_Row > 0 THEN
		ll_Return = ll_Row
	ELSE
		ll_Return = 0
	END IF

ELSE  //-1

	ll_Return = -1

END IF

RETURN ll_Return
end function

public function integer of_getobject (string as_objectname, ref any aaa_beo[]);
// determin if there is any special requests. i.e. RANGE

Any		la_Value
Any		laa_Object[]
Any		laa_Empty[]
Any		laa_Temp[]

Boolean	lb_Range

String	lsa_Parms[]
String	ls_Parm
String	ls_ParmLabel
String	ls_ParmValue
String	ls_ObjectName
Int		li_SemiPos
Int		li_First
Int		li_Last
Int		li_ParmCount
Int		li_CharPos
Int		li_Start
Int		li_End
Int 		li_GetObjectRtn
Int		li_ObjectCount
Int		li_Temp
Int		i
Long		lla_RangeLimits[]

Integer	li_Return = 1

n_cst_String	lnv_String

li_First = Pos ( as_objectname, "{" )
li_Last = Pos ( as_objectname, "}" )

//NEXTEVENT{1,1}
IF li_First > 0  THEN // most likely a special requst NEXTEVENT{1,n}

	ls_ParmValue = Mid ( as_ObjectName , li_First + 1 , li_Last - li_First - 1 )
	//ls_ParmValue = {1,n}
	
	ls_ObjectName = Left ( as_ObjectName , li_First - 1 )

	CHOOSE CASE lnv_String.of_ParseToArray ( ls_ParmValue, ",", lla_RangeLimits )
		//Return value of ParseToArray is number of elements in the result set.
	
		CASE 1  //Lower limit and up
			lb_Range = TRUE
			li_Start = lla_RangeLimits[1]
			li_End = 9999 // will be checked against the upper bound of the objects
			
		CASE 2
	
			lb_Range = TRUE
			li_Start = lla_RangeLimits[1]
			li_End = lla_RangeLimits[2]
	
		CASE ELSE  //Improperly formatted range value string
	
			//Cannot process request -- return null value.
		//	SetNull ( as_Value )
	
	END CHOOSE
		
	
ELSE
	ls_ObjectName = as_objectname
END IF
	

li_GetObjectRtn = This.Event ue_GetObject ( ls_ObjectName, laa_Object[] )
	
	
IF lb_Range THEN 
	
	
	li_ObjectCount = UpperBound ( laa_Object )
	
	IF li_Start > li_End THEN
		li_Temp = li_Start
		li_Start = li_End
		li_End = li_Temp
	END IF
	
	IF li_End > li_ObjectCount THEN
		li_End = li_ObjectCount
	END IF
	
	FOR i = li_Start TO li_End
		laa_Temp[UpperBound ( laa_Temp ) + 1 ] = laa_Object[i]
	NEXT
	laa_Object = laa_EMPTY
	laa_Object = laa_Temp 
END IF


aaa_beo = laa_Object


	
RETURN li_GetObjectRtn
	
//// determin if there is any special requests. i.e. RANGE
//
//Any		la_Value
//Any		laa_Object[]
//Any		laa_Empty[]
//Any		laa_Temp[]
//
//Boolean	lb_Range
//
//String	lsa_Parms[]
//String	ls_Parm
//String	ls_ParmLabel
//String	ls_ParmValue
//String	ls_ObjectName
//Int		li_SemiPos
//Int		li_First
//Int		li_Last
//Int		li_ParmCount
//Int		li_CharPos
//Int		li_Start
//Int		li_End
//Int 		li_GetObjectRtn
//Int		li_ObjectCount
//Int		li_Temp
//Int		i
//Long		lla_RangeLimits[]
//
//Integer	li_Return = 1
//
//n_cst_String	lnv_String
//
//li_First = Pos ( as_objectname, "{" )
//li_Last = Pos ( as_objectname, "}" )
//
////NEXTEVENT{1,1}
//IF li_First > 0  THEN // most likely a special requst NEXTEVENT{1,n}
//
//	ls_ParmValue = Mid ( as_ObjectName , li_First + 1 , li_Last - li_First - 1 )
//	//ls_ParmValue = {1,n}
//	
//	ls_ObjectName = Left ( as_ObjectName , li_First - 1 )
//
//	CHOOSE CASE lnv_String.of_ParseToArray ( ls_ParmValue, ",", lla_RangeLimits )
//		//Return value of ParseToArray is number of elements in the result set.
//	
//		CASE 1  //Lower limit and up
//			lb_Range = TRUE
//			li_Start = lla_RangeLimits[1]
//			li_End = 9999 // will be checked against the upper bound of the objects
//			
//		CASE 2
//	
//			lb_Range = TRUE
//			li_Start = lla_RangeLimits[1]
//			li_End = lla_RangeLimits[2]
//	
//		CASE ELSE  //Improperly formatted range value string
//	
//			//Cannot process request -- return null value.
//		//	SetNull ( as_Value )
//	
//	END CHOOSE
//		
//	
//ELSE
//	ls_ObjectName = as_objectname
//END IF
//	
//
//li_GetObjectRtn = This.Event ue_GetObject ( ls_ObjectName, laa_Object[] )
//	
//	
//IF lb_Range THEN 
//	
//	
//	li_ObjectCount = UpperBound ( laa_Object )
//	
////	IF li_End > li_ObjectCount THEN		//
////		li_End = li_ObjectCount				//
////	END IF										//
//													//
//	IF li_Start > li_End THEN				//
//		li_Temp = li_Start					//
//		li_Start = li_End						// This is done like this to give access to the 
//		li_End = li_Temp						// upperbound object. just provied {100,99}
//	END IF										//
//													//
//	IF li_End > li_ObjectCount THEN		//
//		li_End = li_ObjectCount				//
//	END IF										//
//						
//	FOR i = li_Start TO li_End
//		laa_Temp[UpperBound ( laa_Temp ) + 1 ] = laa_Object[i]
//	NEXT
//	laa_Object = laa_EMPTY
//	laa_Object = laa_Temp 
//END IF
//
//
//aaa_beo = laa_Object
//
//
//	
//RETURN li_GetObjectRtn
//	
end function

public function string of_getnotificationtemplate ();// Implemented By Descendant
RETURN ""
end function

public function string of_getnotificationsubject ();// implemented By Descendants
RETURN "" 
end function

public function string of_gettopic ();RETURN is_Topic
end function

public function integer of_getnotificationtargets (ref Long ala_emailtargets[]);// implementedByDescendents
RETURN -1

end function

public function integer of_setdocumenttype (string as_documenttype);//
/***************************************************************************************
NAME			: of_SetDocumentType
ACCESS		: pulbic
ARGUMENTS	: String		(document type)
RETURNS		: Integer
DESCRIPTION	: Sets instance variable to argument

REVISION		: RDT 092602
***************************************************************************************/
is_documenttype = as_DocumentType
Return 1
end function

public function string of_getdocumenttype ();//
/***************************************************************************************
NAME			: of_GetDocumentType	
ACCESS		: Public
ARGUMENTS	: none
RETURNS		: String		(is_DocumentType)
DESCRIPTION	: 

REVISION		: RDT 092602
***************************************************************************************/

Return is_documenttype

end function

public function boolean of_sendnotification ();// send by default
RETURN TRUE
end function

public function integer of_setcontext (n_cst_bso anv_Context);inv_context = anv_Context

RETURN 1
end function

public function n_Cst_bso of_getcontext ();RETURN inv_Context
end function

public function boolean of_sendnotification (long al_ID);// code in decendants
RETURN TRUE

end function

public function integer of_getreferencedentities (ref pt_n_cst_beo anv_objects[]);Return 0
end function

public function integer of_showuseralerts ();n_csT_msg	lnv_Msg
S_Parm		lstr_Parm

String	ls_ClassName
Long		ll_SourceID
Long		ll_messageID
String	ls_Message

ls_ClassName = THIS.ClassName ()
ll_SourceID = il_sourceid


 DECLARE UserAlerts CURSOR FOR  
  SELECT "useralerts"."alertmessage" ,
  			"useralerts"."id" 
    FROM "useralerts"  
   WHERE ( "useralerts"."sourceid" = :ll_SourceID ) AND  
         ( "useralerts"."classname" = :ls_ClassName )  ;

OPEN UserAlerts;

FETCH UserAlerts INTO :ls_Message , :ll_messageID ;

// Loop through result set until exhausted.

DO WHILE SQLCA.sqlcode = 0
	THIS.of_Showuseralerts( ls_Message, ll_messageID )
	// Fetch the next row from the result set.
	FETCH UserAlerts INTO :ls_Message, :ll_messageID;
LOOP

// All done, so close the cursor.

CLOSE UserAlerts;

Commit;

RETURN 1

end function

public function integer of_adduseralert (string as_msgtext);
Int	li_Return
n_cst_AlertManager	lnv_AlertManager
lnv_AlertManager = CREATE n_cst_AlertManager
li_Return = lnv_AlertManager.of_Addalert( as_msgtext , THIS )
Destroy ( lnv_AlertManager )

RETURN li_Return
end function

public function integer of_adduseralert ();Int			li_Return
String		ls_Message
n_Cst_msg	lnv_Msg
S_Parm		lstr_Parm

lstr_Parm.is_Label = "INSTRUCTIONS" 
lstr_PArm.ia_Value = "Enter message text."
lnv_Msg.of_add_parm( lstr_Parm )

lstr_Parm.is_Label = "Title" 
lstr_PArm.ia_Value = "User Alert"
lnv_Msg.of_add_parm( lstr_Parm )


OpenWithParm ( w_Textinput , lnv_Msg ) 

If isValid ( message.powerobjectparm  ) THEN
	lnv_Msg = message.powerobjectparm
	IF lnv_Msg.of_get_parm( "TEXT" , lstr_Parm ) > 0 THEN
		ls_Message = lstr_Parm.ia_Value
	END IF
END IF

IF len ( ls_Message ) > 0 THEN
	li_return = THIS.of_adduseralert( ls_Message )
END IF
RETURN li_Return
end function

public function integer of_showuseralerts (string as_message, long al_messageid);String	ls_Message
n_csT_msg	lnv_Msg
S_Parm		lstr_Parm
//w_Usernotes	lw_Usernotes

ls_Message = as_message

IF Len ( ls_Message ) > 0 THEN
	lstr_Parm.ia_value = ls_Message
	lstr_Parm.is_Label = "Message"
	lnv_Msg.of_Add_Parm ( lstr_Parm )	
	
	lstr_Parm.ia_value = al_MessageID 
	lstr_Parm.is_Label = "messageID"
	lnv_Msg.of_Add_Parm ( lstr_Parm )	
	
//	OpenWithParm ( lw_Usernotes , lnv_Msg )
END IF
RETURN 1

end function

public function integer of_setcontextcompany (long al_coid);sl_contextcompany = al_coid

RETURN 1
end function

public function long of_getcontextcompanyid ();RETURN sl_contextcompany
end function

public function long of_getdivisionid ();//intended to be implemented on ancestors
//Added by Dan 5-2-2006

RETURN 0
end function

on pt_n_cst_beo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pt_n_cst_beo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull ( il_SourceId )
SetNull ( is_KeyColumn )
SetNull ( il_RowId )


end event

