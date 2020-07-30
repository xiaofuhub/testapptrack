$PBExportHeader$n_cst_template_excel.sru
forward
global type n_cst_template_excel from n_cst_template
end type
end forward

global type n_cst_template_excel from n_cst_template
end type
global n_cst_template_excel n_cst_template_excel

type variables
Private:
String	is_Delimiter
String	is_Topic
oleobject	inv_WorkBook
String	is_FirstAddress
String	is_LastAddress

end variables

forward prototypes
public function integer of_gettemplatetags (ref n_cst_TagData anv_TagData[])
public function integer of_findtopictag (oleobject anv_Range, string as_Topic, ref string as_Delimiter)
public function string of_getfirstaddress ()
public function string of_getlastaddress ()
public function integer of_setfirstaddress (oleobject anv_range, string as_begintag)
public function integer of_setlastaddress (oleobject anv_range, string as_endtag)
public subroutine of_setworkbook (oleobject anv_WorkBook)
public subroutine of_settopic (string as_Topic)
private subroutine of_replacetag (oleobject anv_Column, string as_Value)
private subroutine of_getrowtags (oleobject anv_RowsRange, ref n_cst_tagdata anv_tagdata[])
end prototypes

public function integer of_gettemplatetags (ref n_cst_TagData anv_TagData[]);Integer	li_Return


Return li_Return

end function

public function integer of_findtopictag (oleobject anv_Range, string as_Topic, ref string as_Delimiter);string	ls_TopicTag
			
long		ll_Pos

integer	li_Return

oleobject	lnv_NextRange

// Check for topic tag and set delimiter type being used in tag

//first try dot
ls_TopicTag = "<USE." + upper ( as_topic )  + ">"
lnv_NextRange = anv_Range.Find(ls_TopicTag)
	
IF isvalid ( lnv_NextRange ) THEN
	
	as_Delimiter = "."
	is_Delimiter = as_Delimiter

	li_Return = 1
	
ELSE	//try underscore
	
	ls_TopicTag = "<USE_" + upper ( as_topic )  + ">"
	lnv_NextRange = anv_Range.Find(ls_TopicTag)

	IF isvalid ( lnv_NextRange ) THEN
		
		as_Delimiter = "_"
		is_Delimiter = as_Delimiter
		li_Return = 1
		
	ELSE			//topic couldn't be found
		messagebox( "Template error", " Could not find the " + is_topic + &
						" topic tag in the template. " + &
						"The template could already be opened and needs to be closed. " + &
						"Please close the template or add this tag to the top of the " + &
						"newly created template and try again." )
		li_Return = -1
		
	END IF
	
END IF

RETURN li_Return
end function

public function string of_getfirstaddress ();Return is_firstaddress
end function

public function string of_getlastaddress ();Return is_lastaddress
end function

public function integer of_setfirstaddress (oleobject anv_range, string as_begintag);integer	li_Return

oleobject	lnv_NextRange

lnv_NextRange = anv_range.Find(as_BeginTag)
IF isvalid ( lnv_NextRange ) THEN
	is_firstaddress = lnv_NextRange.Address
	li_Return = 1
ELSE
	messagebox( "Template error", " Could not find the " +  as_begintag + " in the template. " + &
					"Please add this tag to the top left hand corner of the template and try again." )
	is_FirstAddress = ''
	li_Return = -1
		
END IF

Return li_Return 




end function

public function integer of_setlastaddress (oleobject anv_range, string as_endtag);integer li_Return

oleobject	lnv_NextRange

lnv_NextRange = anv_range.Find(as_EndTag)
IF isvalid ( lnv_NextRange ) THEN
	is_LastAddress = lnv_NextRange.Address
	li_Return = 1
	
ELSE
	messagebox( "Template error", " Could not find the " +  as_EndTag + " in the template. " + &
					"Please add this tag to the bottom right hand corner of the template and try again." )
	is_LastAddress = ''
	li_Return = -1
		
END IF

Return li_Return 



end function

public subroutine of_setworkbook (oleobject anv_WorkBook);inv_workbook = anv_WorkBook
end subroutine

public subroutine of_settopic (string as_Topic);is_topic = as_Topic
end subroutine

private subroutine of_replacetag (oleobject anv_Column, string as_Value);
end subroutine

private subroutine of_getrowtags (oleobject anv_RowsRange, ref n_cst_tagdata anv_tagdata[]);//string	lsa_Tags [], &
//			ls_Tag, &
//			ls_TopicTag, &
//			lsa_Formula[]
//			
//oleObject	lnv_RowRange, &
//				lnv_ColumnsRange, &
//				lnv_ColumnRange
//				
//long		ll_TagCount, &
//			ll_RowRangeCount, &
//			ll_RowCount, &
//			ll_ColumnCount, &
//			ll_Ndx, &
//			ll_Ndx2
//
//ll_RowRangeCount = anv_RowsRange.count
//
//FOR ll_ndx = 1 TO ll_RowRangeCount
////what about inserted rows ?
//	lsa_Tags = lsa_Blank
//	lsa_Formula = lsa_Blank
//	lnv_RowRange = anv_RowsRange.item(ll_ndx)
//	lnv_ColumnsRange = lnv_RowRange.Columns
//	ll_ColumnCount = lnv_ColumnsRange.Count
//
//	//	Get Tags from each row in the range
//	FOR ll_ndx2 = 1 to ll_ColumnCount
//		
//		lnv_ColumnRange = lnv_ColumnsRange.item(ll_ndx2)
//		IF left ( lnv_ColumnRange.text, 1 ) = "<" AND &
//			right ( lnv_ColumnRange.text, 1 ) = ">" THEN
//			ls_Tag = lnv_ColumnRange.text
//			IF pos ( ls_Tag, "=", 1 ) > 0 THEN
//				// in row formula, strip off brackets
//				// move tag to formula array retaining position in row
//				lsa_Formula [ll_Ndx2] = mid ( ls_Tag, 2, len ( ls_Tag ) - 2 )
//				lsa_Tags [ll_Ndx2] = ''
//			ELSE
//				lsa_Tags [ll_ndx2] = ls_Tag
//			END IF 
//		END IF
//						
//	NEXT
//	
//	IF upperbound ( lsa_Tags ) > 0 THEN
//		
//
//NEXT
//
//		ll_ArrayCount ++
//		anv_TagData[ll_ArrayCount] = Create n_cst_TagData
//		//Getting row instead of whole table.  This may be a problem if a 
//		//table contains mixed multiple row tags that could cause row insertion.
//		anv_TagData[ll_ArrayCount].of_SetObject(lnv_RowRange)
//		anv_TagData[ll_ArrayCount].of_SetTags(asa_Tags)
//		anv_TagData[ll_ArrayCount].of_SetTagDelimiter(is_delimiter)
//		anv_TagData[ll_ArrayCount].of_SetObjectType("TABLE")
//		
//	END IF
//			
//NEXT
//
end subroutine

on n_cst_template_excel.create
TriggerEvent( this, "constructor" )
end on

on n_cst_template_excel.destroy
TriggerEvent( this, "destructor" )
end on

