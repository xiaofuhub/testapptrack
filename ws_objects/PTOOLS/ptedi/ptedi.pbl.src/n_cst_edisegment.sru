$PBExportHeader$n_cst_edisegment.sru
forward
global type n_cst_edisegment from n_cst_base
end type
end forward

global type n_cst_edisegment from n_cst_base
end type
global n_cst_edisegment n_cst_edisegment

type variables
Protected:
String	is_ControlSegmentId	//	3/3
String	is_SegmentString
String	isa_Segment[]
String	is_ElementDelimiter = '*'
Int		ii_Count
Long		il_SourceShipmentID

DataStore	ids_Segment

end variables

forward prototypes
public function string of_getrecordstring ()
public function string of_getcontrolsegmentid ()
public function integer of_buildrecord ()
public function string of_getelementdelimiter ()
protected function integer of_parsesegment ()
protected function integer of_adderror (string as_error)
public function integer of_setsegment (string asa_segment[])
public function integer of_showerrormessages ()
public function String of_getsegmentid ()
public function integer of_meetscondition (string as_condition)
public function integer of_getvalue (long ala_elementpositions[], ref string as_value)
public function integer of_setvalue (long ai_elementposition, string as_value)
public function string of_geterrorstring ()
end prototypes

public function string of_getrecordstring ();String	ls_Record
Constant Boolean cb_IncludeEmptyString = TRUE
n_Cst_String	lnv_String


// we need to check that there are not any extra '*' at the end of the string
Long	ll_Bound
Long	j
Long		li_Max
String	lsa_Empty[]
String	lsa_Temp[]
Boolean	lb_take

ll_Bound = UpperBound ( isa_segment )
FOR li_Max = ll_Bound TO 1 STEP -1
	IF Len ( isa_segment[li_Max] ) > 0 THEN
		EXIT
	END IF
NEXT
	
	
FOR j = 1 TO li_Max 
	lsa_Temp[j] = isa_segment[j]
NEXT
	
isa_segment = lsa_Empty
isa_segment = lsa_Temp
	
	
IF Len ( is_segmentstring ) = 0 THEN
	lnv_String.of_arraytostring( isa_segment, THIS.of_Getelementdelimiter( ), ls_Record, cb_IncludeEmptyString )	
	is_segmentstring = ls_Record
END IF

RETURN is_segmentstring

end function

public function string of_getcontrolsegmentid ();RETURN is_Controlsegmentid
end function

public function integer of_buildrecord ();Int	li_Rtn
li_Rtn = -1 

RETURN li_Rtn


end function

public function string of_getelementdelimiter ();RETURN is_Elementdelimiter

end function

protected function integer of_parsesegment ();String	ls_Segment
Int		li_ColumnCount
Int		i
Int		li_Return = 1

ls_Segment = is_controlsegmentid

ids_segment.DataObject = "d_ediSegment_" + ls_Segment

IF ids_segment.insertRow ( 0 ) <= 0 THEN
	li_Return = -1
	THIS.of_adderror( "Could not create dataobject for " + ls_Segment  )
END IF

IF li_Return = 1 THEN
	li_ColumnCount = Integer ( ids_segment.Object.DataWindow.Column.Count )
	IF ii_Count > li_ColumnCount THEN
		li_Return = -1
		THIS.of_AddError ( "The column count was incorrect for the " + ls_Segment  + " segment." )
	END IF
END IF

IF li_Return = 1 THEN
	FOR i = 1 TO ii_count
		IF ids_segment.setitem( 1, i , isa_segment[i] ) <> 1 THEN
			THIS.of_adderror( "Could not set " + ls_Segment + string ( i ) )
			li_Return = -1
		END IF
	NEXT
	
END IF


RETURN li_Return
end function

protected function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )
lnv_Error.SetMessageHeader ( "EDI Data" )

RETURN 1
end function

public function integer of_setsegment (string asa_segment[]);Int	li_Return = 1
n_cst_String	lnv_String

//is_segmentstring = as_segment
//lnv_String.of_Parsetoarray( is_segmentstring , is_elementdelimiter , isa_segment )
isa_segment = asa_segment[]
ii_Count = UpperBound ( isa_segment )

If ii_Count > 0 THEN
	is_Controlsegmentid = isa_segment[1]
ELSE
	li_Return = -1
	THIS.of_AddError( "The control segment id could not be determined.")
END IF

IF li_Return = 1 THEN	
	IF THIS.of_Parsesegment( ) <> 1 THEN
		li_Return = -1
	END IF
END IF

RETURN li_Return

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

MessageBox("EDI Processing" , ls_ErrorString , EXCLAMATION! )

RETURN 1
end function

public function String of_getsegmentid ();RETURN is_controlsegmentid
end function

public function integer of_meetscondition (string as_condition);//  RETURNS  1 = Meets Condition
//				0	= Does not meet condition
//				-1 = Error. most likely a syntax error in the condition

String	ls_Condition
String	lsa_Conditions[]
Int		li_NumConditions
String	lsa_ConditionParts[]
Int		li_Element
String	ls_NeededValue
String	ls_ActualValue
Int		i
Int		li_Return = 1 // assume it meets condition
Boolean	lb_OR
Boolean	lb_Not
String	ls_Delimiter


n_cst_String	lnv_String

IF Pos ( Upper ( as_condition ), "<>" ) > 0 THEN
	lb_Not = TRUE
	ls_Delimiter = "<>"
ELSE
	ls_Delimiter = "="
END IF
	
	
	
IF Pos ( Upper ( as_condition ), " OR " ) > 0 THEN
	lb_OR = TRUE
	lnv_String.of_ParseToArray ( as_condition , " OR " , lsa_Conditions )
ELSE
	lnv_String.of_ParseToArray ( as_condition , "," , lsa_Conditions )
END IF

li_NumConditions = UpperBound ( lsa_Conditions )


FOR i = 1 TO li_NumConditions
	
	lnv_String.of_Parsetoarray( lsa_Conditions[i] , ls_Delimiter , lsa_ConditionParts )
	
	IF UpperBound ( lsa_ConditionParts ) <> 2 THEN
		li_Return = -1
		THIS.of_AddError ( "Syntax error in condition " + lsa_Conditions[i] )
		EXIT
	ELSE
		IF isNumber ( lsa_ConditionParts[1] ) THEN
			li_Element = Integer ( lsa_ConditionParts[1] )
			ls_NeededValue = lsa_ConditionParts[2]
			IF ls_NeededValue = "''" THEN  // the condition is that te element is empty
				ls_NeededValue = ""
			END IF
		ELSE
			li_Return = -1
			THIS.of_AddError ( "Syntax error in condition " + lsa_Conditions[i] )
			EXIT
		END IF
	END IF
	
	
	IF li_Return = 1 THEN
		
		CHOOSE CASE lb_Not
				
			CASE FALSE
		
				IF THIS.of_GetValue( {li_Element} , ls_ActualValue ) = 1 THEN
					IF ls_NeededValue <> ls_actualValue AND NOT lb_OR THEN
						li_Return = 0 // does not meet specified condition
						EXIT
					ELSEIF ls_NeededValue = ls_actualValue AND lb_OR THEN
						EXIT // one satisfied condition is good enough
					END IF
				ELSE // could not get the value to evaluate. therefore doesn't meet condition unless
					  // we are looking for an empty string, so...
					IF ls_NeededValue = "" THEN
						// meets the specified condition
						/// so use the assumed return code.
					ELSE
						li_Return = 0 // it doesn't
					END IF
				END IF
			CASE TRUE  // looking for <> 
				IF THIS.of_GetValue( {li_Element} , ls_ActualValue ) = 1 THEN
					IF isNumber ( ls_ActualValue ) THEN
						ls_ActualValue = String ( Long ( ls_ActualValue ) ) 
					END IF
					IF ls_NeededValue = ls_ActualValue THEN
						li_Return = 0 // does not meet specified condition
						EXIT
					END IF
				END IF
				
		END CHOOSE
	END IF
			
NEXT

RETURN li_Return

end function

public function integer of_getvalue (long ala_elementpositions[], ref string as_value);Int		li_Return = 1
String	ls_Value
Int		li_Position
String	ls_Temp
Int		i
Int		li_ElementCount
n_cst_String	lnv_String

li_ElementCount = UpperBound ( ala_elementpositions[] )

FOR i = 1 TO li_ElementCount
	
	li_Position = ala_elementpositions[i] + 1
	
	IF li_Position > ii_Count THEN
		li_Return = -1
	END IF
	
	IF li_Return = 1 THEN
		IF Not isValid ( ids_segment ) THEN
			li_Return = -1
		END IF
	END IF
	
	IF li_Return = 1 THEN
		IF NOT ids_segment.RowCount ( ) > 0 THEN
			li_Return = -1
		END IF 
	END IF
	
	
	IF li_Return = 1 THEN
		ls_Temp =  lnv_String.of_removenonprint( ids_segment.GetItemString ( 1 , li_Position ) )
		ls_Temp = lnv_String.of_Globalreplace( ls_Temp , '~~', '')
		IF NOT isNull ( ls_Temp ) THEN
			ls_Value += ls_Temp
//		ELSE
//			li_Return = 0
		END IF
	END IF
	
NEXT

IF li_Return = 1 THEN
	as_Value = ls_Value
END IF

RETURN li_Return


end function

public function integer of_setvalue (long ai_elementposition, string as_value);Int		li_Return = 1
Int		li_Position

li_Position = ai_elementposition + 1
	
IF li_Position > ii_Count THEN
	li_Return = -1
END IF
	
IF li_Return = 1 THEN
	IF Not isValid ( ids_segment ) THEN
		li_Return = -1
	END IF
END IF
	
IF li_Return = 1 THEN
	IF NOT ids_segment.RowCount ( ) > 0 THEN
		li_Return = -1
	END IF 
END IF
	
IF li_Return = 1 THEN
	
	IF ids_segment.setitem( 1, li_Position , as_value ) <> 1 THEN
		li_Return = -1
	END IF

END IF

IF li_Return = 1 THEN
	isa_segment[li_Position] = as_value
END IF


RETURN li_Return


end function

public function string of_geterrorstring ();int 		li_errorCount
int		i
String	ls_ErrorString
String	ls_SourceString



n_cst_OFRError 				lnva_Error[]
n_cst_OFRError_Collection 	lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_ErrorCollection.geterrorcount( )





For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() ) + ", "
next

RETURN ls_ErrorString
end function

on n_cst_edisegment.create
call super::create
end on

on n_cst_edisegment.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_segment = CREATE DataStore
end event

event destructor;call super::destructor;Destroy ( ids_segment )
end event

