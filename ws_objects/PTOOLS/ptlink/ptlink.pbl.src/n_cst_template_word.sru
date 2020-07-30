$PBExportHeader$n_cst_template_word.sru
forward
global type n_cst_template_word from n_cst_template
end type
end forward

global type n_cst_template_word from n_cst_template
end type
global n_cst_template_word n_cst_template_word

type variables
Private:
oleobject	inv_Document
oleobject	inv_LastCharacterRange
string	is_Delimiter
string	is_Topic
integer	ii_NumberOfChanges
string	isa_AllTableTags[]

end variables

forward prototypes
private subroutine of_replacetag (string as_tag, string as_value, oleobject anv_object)
private subroutine of_replaceheaderfooter (string asa_tags[], datastore ads_values, oleobject anv_object)
private subroutine of_findreplacetag (string as_tag, string as_value, oleobject anv_object)
private subroutine of_replacerow (string asa_tags[], datastore ads_values, oleobject anv_table, long al_rowindex)
private subroutine of_calculatecell (oleobject anv_table, long al_rowindex)
private subroutine of_getheadertags (ref string asa_tags[], ref n_cst_tagdata anv_tagdata[])
private subroutine of_replacetable (string asa_tags[], datastore ads_values, oleobject anv_table)
public subroutine of_setdocument (oleobject anv_Document)
private subroutine of_gettabletags (oleobject anv_range, ref string asa_tags[], ref n_cst_tagdata anv_tagdata[])
public function integer of_findtopictag (string as_rangetext, string as_topic, ref string as_delimiter)
public subroutine of_settopic (string as_Topic)
private subroutine of_removeduplicatetags (string asa_mastertags[], string asa_tags[], ref string asa_newtags[])
public subroutine of_gettemplatetags (ref n_cst_tagdata anv_tagdata[])
public function integer of_replacetemplatetags (ref n_cst_tagdata anv_tagdata[], long al_topiccount, n_cst_msg anv_tagmessage)
private subroutine of_preprocessnumbertags (oleobject anv_range, long al_tagnumber, string asa_tags[])
private subroutine of_numbertags (oleobject anv_range, ref string asa_tag[], ref n_cst_tagdata anv_tagdata[])
public function integer of_getnumberofchanges ()
private subroutine of_getfootertags (ref string asa_tags[], ref n_cst_tagdata anv_tagdata[])
end prototypes

private subroutine of_replacetag (string as_tag, string as_value, oleobject anv_object);string	ls_ErrorTag

IF isnull ( as_Value )  THEN
	ls_ErrorTag = "***" + mid ( as_Tag, 2,  len ( as_Tag ) - 2 ) + "***"
	anv_object.text = ls_ErrorTag
ELSE
	anv_object.text = as_Value
END IF
ii_NumberOfChanges ++
end subroutine

private subroutine of_replaceheaderfooter (string asa_tags[], datastore ads_values, oleobject anv_object);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessHeaderFooterTags
//
//	Access:  private
//
//	Arguments:  asa_Tags[]
//					ads_Values  datastore of data
//					object ( header footer)
//
// Returns:		Integer
//
//				   0 = success
//				  -1 = failure
//
//	Description:	
//						
//
// Written by: Norm LeBlanc
// 		Date: 9/13/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

string	ls_RangeText
				 
long		ll_objectCount, &
			ll_TagCount, &
			ll_TagNdx, &
			ll_Count1
			
oleobject	lnv_SingleObject			
			
ll_objectCount = anv_object.Count
FOR ll_Count1 = 1 TO ll_objectCount 

	lnv_SingleObject = anv_object.Item( ll_Count1 )
	ls_RangeText = lnv_SingleObject.Range.Text
	ll_TagCount = upperbound ( asa_Tags )
	IF ll_TagCount > 0 THEN //PROCESS TAGS

//			lds_Values = THIS.of_ProcessRange ( lnv_HeaderFooterRange, iaa_TopicSingleBeo, lsa_Tags )

//need to get the exact tag range before replacing


		IF ads_Values.RowCount() > 0 THEN
			
			FOR ll_TagNdx = 1 to ll_TagCount
				THIS.of_FindReplaceTag(asa_Tags [ ll_TagNdx ], ads_values.object.data.primary[1, ll_TagNdx], lnv_SingleObject )
			NEXT
				
		END IF
							
	END IF
NEXT

end subroutine

private subroutine of_findreplacetag (string as_tag, string as_value, oleobject anv_object);string	ls_ErrorTag

//Value must be under 255 characters or it will crash (fixed 4/28/06 MFS)
IF Len(as_Value) >= 255 THEN
	as_Value = Left(as_Value, 254)
END IF

IF isnull ( as_Value )  THEN
	ls_ErrorTag = "***" + mid ( as_Tag, 2,  len ( as_Tag ) - 2 ) + "***"
	anv_object.Range.find.Execute(as_Tag,false,true,false,&
				false,false,true,1,false,ls_ErrorTag,true)
ELSE
	anv_object.Range.find.Execute(as_Tag,false,true,&
				false,false,false,true,1,false,as_Value,true)
END IF
ii_NumberOfChanges ++
end subroutine

private subroutine of_replacerow (string asa_tags[], datastore ads_values, oleobject anv_table, long al_rowindex);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ReplaceTable
//
//	Access:  private
//
//	Arguments:  anv_SingleRow
//					ads_Values
//
// Returns:		none
//
//				  -1 = failure
//
//	Description:	
//First replace the tags and then add any additional rows.
//We need to look for the cell location of each tag in the row.
//
// Written by: Norm LeBlanc
// 		Date: 9/21/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
//
string	ls_ProcessTag, &
			ls_test

oleObject	lnv_TableRows, &
				lnv_SingleRow, &
			 	lnv_AddedRow, &
				lnv_BeforeRow, &
				lnv_NextRow, &
				lnv_Cells, &
				lnv_SingleCell, &
				lnv_CellRange
				 
long		ll_CellsCount, &
			ll_TagNdx, &
			ll_CellsNdx, &
			ll_RowNdx, &
			ll_RowCount, &
			ll_TagCount, &
			ll_TableRowCount, &
			ll_Index
			
boolean	lb_FoundCell, &
			lb_RowsAdded

ll_TagCount = upperbound ( asa_tags )
ll_RowCount = ads_values.RowCount()
IF isvalid ( anv_Table ) THEN
	//OK
	ll_TableRowCount = anv_table.Rows.Count
	
	lnv_SingleRow = anv_table.Rows.Item [ al_RowIndex ]
	
	IF ll_TagCount > 0 THEN
			
		IF ll_RowCount > 0 THEN
			//we have the values now let's update tags in row object
			FOR ll_TagNdx = 1 TO ll_TagCount
				
				IF left ( asa_Tags [ ll_TagNdx ], 2 ) = '<=' THEN 
					//formula tag don't replace text in cell
					CONTINUE
				END IF
					
				ll_CellsCount = lnv_singlerow.Cells.Count
				//****test
				FOR ll_CellsNdx = ll_TagNdx TO ll_CellsCount
			
					lnv_SingleCell = lnv_singlerow.Cells.Item(ll_CellsNdx)
					lnv_CellRange = lnv_SingleCell.Range
					
					ls_ProcessTag = this.of_GetTag ( lnv_CellRange.text )
					
					//does cell text match tag
					IF ls_ProcessTag = asa_Tags [ ll_TagNdx ] THEN
						
						lb_FoundCell = TRUE
						ls_test=ads_values.object.data.primary[1, ll_TagNdx]
						THIS.of_ReplaceTag ( asa_Tags [ ll_TagNdx ], ads_values.object.data.primary[1, ll_TagNdx], lnv_CellRange )
						
						IF ll_RowCount > 1 THEN
						
							FOR ll_RowNdx = 2 TO ll_RowCount
								
								IF ll_TagNdx = 1 and not lb_RowsAdded THEN  //ADD ALL THE BLANK ROWS NEEDED FOR NEW VALUES
								
									FOR ll_Index = 2 to ll_RowCount

										//add() will take a row object as an arg an insert before that row arg
										//if no arg then a row will be added to the end of the table
										IF al_rowindex = ll_TableRowCount THEN 	//Tags were in last row, add to end of table						
											lnv_AddedRow =	anv_table.Rows.Add()
										ELSE // Get next row for beforerow argument
											lnv_BeforeRow = anv_table.Rows.Item(ll_RowNdx + 1)
											lnv_AddedRow =	anv_table.Rows.Add(lnv_BeforeRow)
										END IF
									
									NEXT	
									lb_RowsAdded = TRUE
									
								END IF
								
								IF ll_RowNdx = 2 THEN
									lnv_NextRow = lnv_SingleRow.NEXT
								ELSE
									lnv_NextRow = lnv_NextRow.NEXT
								END IF
								
								lnv_Cells = lnv_NextRow.Cells	
				
								lnv_SingleCell = lnv_Cells.Item(ll_CellsNdx)
								lnv_CellRange = lnv_SingleCell.Range
								ls_test=ads_values.object.data.primary[ll_rowNdx, ll_TagNdx]
								THIS.of_ReplaceTag ( asa_Tags [ ll_TagNdx ], ads_values.object.data.primary[ll_rowNdx, ll_TagNdx], lnv_CellRange )
										
							NEXT
							
						END IF
						
						IF lb_FoundCell THEN
							lb_FoundCell = FALSE
							EXIT
						END IF
									
					END IF
						
				NEXT
	
			NEXT
				
		END IF
	
	END IF	

END IF


end subroutine

private subroutine of_calculatecell (oleobject anv_table, long al_rowindex);oleObject	lnv_TableRows, &
			 	lnv_SingleRow, &
				lnv_Cells, &
				lnv_SingleCell, &
				lnv_CellRange
				 
long		ll_CellsCount, &
			ll_CellsNdx, &
			ll_Pos, &
			ll_Pos2
			
string	ls_Text, &
			ls_Formula, &
			ls_Format, & 
			lsa_Tag[], &
			lsa_StrippedTag[]

n_cst_string			lnv_String

IF isvalid ( anv_Table ) THEN
	lnv_TableRows = anv_table.Rows
	lnv_SingleRow = lnv_TableRows.Item [ al_RowIndex ]
	lnv_Cells = lnv_singlerow.Cells
	ll_CellsCount = lnv_Cells.Count
	
	FOR ll_CellsNdx = 1 TO ll_CellsCount
	
		lnv_SingleCell = lnv_Cells.Item(ll_CellsNdx)
		lnv_CellRange = lnv_SingleCell.Range
		ls_Text = trim ( lnv_CellRange.Text )
		ls_Text = lnv_String.of_RemoveNonPrint ( ls_Text )
		IF left ( ls_Text, 2 ) = '<=' THEN 
			//FORMULA
			//STRIP BRACKETS
			lsa_Tag[1] = ls_Text
			this.of_StripTagBrackets(lsa_Tag, lsa_StrippedTag )
			ls_text = lsa_StrippedTag[1]
			lnv_CellRange.text = ''
			//get formula and format
			ll_Pos = Pos ( ls_text, ",", 1 )
			IF ll_Pos > 0 THEN
				ll_Pos2 = Pos ( ls_Text, ",", ll_Pos + 1 )
				IF ll_Pos2 > 0 THEN
					ls_Formula = left ( ls_Text, ll_Pos2 -1 ) 
					ls_Format = right ( ls_text, len ( ls_Text) - ll_Pos2 )
				ELSE
					ls_Formula = left ( ls_Text, ll_Pos -1 ) 
					ls_Format = right ( ls_Text, len ( ls_Text ) - ll_Pos )
				END IF
			ELSE
				ls_Formula = ls_Text
				ls_Format = "0"
			END IF
			lnv_SingleCell.formula(ls_Formula, ls_Format)
		end if 
				
	NEXT

END IF
end subroutine

private subroutine of_getheadertags (ref string asa_tags[], ref n_cst_tagdata anv_tagdata[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetHeaderTags
//
//	Access:  private
//
//	Arguments:  anv_Document,
//					asa_Tags[]
//
// Returns:		long
//					number of tags
//
//	Description:	
//						
//
// Written by: Norm LeBlanc
// 		Date: 9/13/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

string	ls_RangeText
				
oleObject	lnv_SingleSection, &
			 	lnv_Headers, &
			 	lnv_SingleHeader
				 
long		ll_HeadersCount, &
			ll_TagCount, &
			ll_Count1, &
			ll_ArrayCount
			
datastore lds_Values

/*	
	Sections represent pages for the multiple topics and could contain
	tag values. 

*/
If inv_Document.Sections.Count > 0 THEN
	ll_ArrayCount = upperbound ( anv_tagdata )
	//always processing last section
	lnv_SingleSection = inv_Document.Sections.Item( inv_Document.Sections.Count )
	//	Look for header tags
	lnv_Headers = lnv_SingleSection.Headers
	ll_HeadersCount = lnv_Headers.Count
	FOR ll_Count1 = 1 TO ll_HeadersCount 	
		lnv_SingleHeader = lnv_Headers.Item( ll_Count1 )
		ls_RangeText = lnv_SingleHeader.Range.Text	
		IF this.of_GetTags ( ls_RangeText, asa_Tags )  > 0 THEN
			ll_ArrayCount ++
			anv_TagData[ll_ArrayCount] = Create n_cst_TagData
			anv_TagData[ll_ArrayCount].of_SetObject(lnv_Headers)
			anv_TagData[ll_ArrayCount].of_SetTags(asa_Tags)
			anv_TagData[ll_ArrayCount].of_SetTagDelimiter(is_delimiter)
			anv_TagData[ll_ArrayCount].of_SetObjectType("HEADER")
			
		END IF
	NEXT
	
END IF

end subroutine

private subroutine of_replacetable (string asa_tags[], datastore ads_values, oleobject anv_table);long	ll_TagCount, &
		ll_TableRowCount, &
		ll_Ndx

ll_TagCount = upperbound ( asa_Tags )
ll_TableRowCount = anv_Table.Rows.Count

FOR ll_Ndx = 1 TO ll_TableRowCount
	
	IF ll_TagCount > 0 THEN //PROCESS TAGS
		IF ads_Values.RowCount() > 0 THEN
			
			THIS.of_ReplaceRow ( asa_Tags, ads_Values, anv_Table, ll_Ndx )
	
		END IF
	END IF
	//calculate formula
	THIS.of_CalculateCell ( anv_table, ll_Ndx )
	
NEXT
	

end subroutine

public subroutine of_setdocument (oleobject anv_Document);inv_document = anv_Document
end subroutine

private subroutine of_gettabletags (oleobject anv_range, ref string asa_tags[], ref n_cst_tagdata anv_tagdata[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessTableTags
//
//	Access:  private
//
//	Arguments:  anv_Range
//					asa_Tags[]
//
// Returns:		long
//
//				   number of tags
//
//	Description:	Loop through tables which are part of the range passed to 
//						method.
//						
//
// Written by: Norm LeBlanc
// 		Date: 9/13/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

oleObject	lnv_NextTable, &
			 	lnv_TableSingleRow, &
				lnv_RowRange
				 
long		ll_TableCount, &
			ll_TableRowCount, &
			ll_TableNdx, & 
			ll_TableRowNdx, &
			ll_RowCount, &
			ll_ArrayCount, &
			ll_ndx, &
			ll_TagMax
			
ll_TableCount = anv_Range.Tables.Count
ll_ArrayCount = upperbound ( anv_TagData )
/*	Loop through all tables by incrementing argument 	*/
FOR ll_TableNdx = 1 TO ll_TableCount

	lnv_NextTable = anv_Range.Tables.Item(ll_TableNdx)
	
	ll_TableRowCount = lnv_NextTable.Rows.Count
	
	FOR ll_TableRowNdx = 1 TO ll_TableRowCount

		lnv_TableSingleRow = lnv_NextTable.Rows.Item(ll_TableRowNdx)
		lnv_RowRange = lnv_TableSingleRow.Range
		IF this.of_GetTags ( lnv_RowRange.text, asa_Tags ) > 0 THEN
			
			//**ADD ALL TAGS TO A MASTER TABLE TAG LIST
			//This will be used to pare down document tags
			ll_TagMax = upperbound ( asa_Tags )
			FOR ll_Ndx = 1 to ll_TagMax
				isa_AllTableTags[ upperbound(isa_AllTableTags) + 1 ] = asa_Tags [ll_Ndx]
			NEXT
			//***
			
			ll_ArrayCount ++
			anv_TagData[ll_ArrayCount] = Create n_cst_TagData
			//Getting row instead of whole table.  This may be a problem if a 
			//table contains mixed multiple row tags that could cause row insertion.
			anv_TagData[ll_ArrayCount].of_SetObject(lnv_RowRange)
			anv_TagData[ll_ArrayCount].of_SetTags(asa_Tags)
			anv_TagData[ll_ArrayCount].of_SetTagDelimiter(is_delimiter)
			anv_TagData[ll_ArrayCount].of_SetObjectType("TABLE")
			
		END IF
				
	NEXT
		
NEXT

end subroutine

public function integer of_findtopictag (string as_rangetext, string as_topic, ref string as_delimiter);string	ls_TopicTag
			
long		ll_Pos

integer	li_Return

// Check for topic tag and set delimiter type being used in tag

//first try dot
ls_TopicTag = "<USE." + upper ( as_topic )  + ">"
ll_pos = pos ( upper ( as_RangeText ), ls_TopicTag, 1 )

IF ll_Pos = 0 THEN

	//try underscore
	ls_TopicTag = "<USE_" + upper ( as_topic )  + ">"
	
	IF ll_Pos = 0 THEN

		messagebox( "Word Template error", "Could not find the " + as_topic + &
			" topic tag in the template. " + &
			"The template could already be opened and needs to be closed. " + &
			"Please switch over to the open copy in Word and close the template " + &
			"or add this tag to the top of the newly created template. ") 
//			"Then click OK to continue. ")
	
			li_Return = -1
			
		ELSE
		
		as_Delimiter = "_"
		is_Delimiter = as_Delimiter
		li_Return = 1
		
	END IF
		
ELSE

	as_Delimiter = "."
	is_Delimiter = as_Delimiter

	li_Return = 1
	
END IF

RETURN li_Return
end function

public subroutine of_settopic (string as_Topic);is_topic = as_Topic
end subroutine

private subroutine of_removeduplicatetags (string asa_mastertags[], string asa_tags[], ref string asa_newtags[]);long 	ll_ndx1, &
		ll_Ndx2, &
		ll_TagMax, &
		ll_AllTagMax, &
		ll_NewTags
		
boolean	lb_Found	
	
ll_TagMax = upperbound ( asa_tags  )
ll_AllTagMax = upperbound ( asa_MasterTags )
FOR ll_Ndx1 = 1 to ll_TagMax
	lb_Found = FALSE
	
	FOR ll_Ndx2 = 1 to ll_AllTagMax
		
		IF	asa_MasterTags [][ll_Ndx2 ] = asa_tags [ll_Ndx1] THEN
			lb_Found = TRUE
			EXIT
		END IF
		
	NEXT
	
	IF not lb_Found THEN
		ll_NewTags ++
		asa_NewTags [ ll_NewTags ] = asa_tags [ll_Ndx1]
	END IF
NEXT

end subroutine

public subroutine of_gettemplatetags (ref n_cst_tagdata anv_tagdata[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTemplateTags
//
//	Access:  private
//
//	Arguments:  as_topic
//
// Returns:		Integer
//
//				   0 = success
//				  -1 = failure
//
//	Description:	Remove the topic tag and then select the document and cut into the
//					clipboard. Paste back and start looking for tags.  As tags are gathered
//					remove them so they won't be picked up by other passes.
//					After getting all the tags paste the document with the tag values for
//					the replacing.
//						
//
// Written by: Norm LeBlanc
// 		Date: 3/1/00
//		Version: 3.0.11
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

integer	li_Return = 1 

string	lsa_Tags [], &
			lsa_Blank [], &
			lsa_DocumentTags [], &
			ls_TopicTag

long		ll_ArrayCount, &
			ll_DocumentTags, &
			ll_Ndx
				
oleObject	lnv_DocumentRange
lnv_DocumentRange = inv_document.Range(inv_document.Range.Start, inv_document.Range.End)
//Remove topic tag
ls_TopicTag = "<USE" + is_Delimiter + upper ( is_topic )  + ">"
of_FindReplaceTag ( ls_TopicTag, '', inv_document )

////select template and cut
//lnv_DocumentRange.Select()
//lnv_DocumentRange.Cut()
//// get last character of document 
//inv_LastCharacterRange = inv_document.Characters.last
//inv_lastcharacterrange.Paste()
//ii_numberofchanges ++
//
/*						Table Processing

	Process tables first, they could be multiple rows and need 
	special processing loops.
	
*/

this.of_GetTableTags (lnv_DocumentRange,lsa_Tags, anv_TagData)

/*			Single occurrence processing	

	Get the rest of the tags outside of the table areas.
*/	
lsa_Tags = lsa_Blank
IF THIS.of_GetTags ( lnv_DocumentRange.text, lsa_Tags )  > 0 THEN
	
	//CHECK MASTER LIST FOR DUPLICATES AND REMOVE
	this.of_RemoveDuplicateTags ( isa_alltabletags, lsa_Tags, lsa_DocumentTags )
	
	//Look for number tags and group into seperate tagdata objects
	of_NumberTags(inv_Document, lsa_DocumentTags, anv_TagData )
	//put remaining tags into an object
	ll_DocumentTags = upperbound ( lsa_DocumentTags )
	ll_ArrayCount = 0
	lsa_Tags = lsa_Blank
	FOR ll_Ndx = 1 to ll_DocumentTags
		IF len ( trim ( lsa_DocumentTags [ll_Ndx] ) ) > 0 THEN
			ll_ArrayCount ++
			lsa_Tags[ll_ArrayCount] = lsa_DocumentTags [ll_Ndx]
		END IF
	NEXT
	IF upperbound ( lsa_Tags ) > 0 THEN
		ll_ArrayCount = upperbound ( anv_TagData )
		ll_ArrayCount ++
		anv_TagData[ll_ArrayCount] = Create n_cst_TagData
		anv_TagData[ll_ArrayCount].of_SetObject(inv_Document)
		anv_TagData[ll_ArrayCount].of_SetTags(lsa_Tags)
		anv_TagData[ll_ArrayCount].of_SetTagDelimiter(is_delimiter)
		anv_TagData[ll_ArrayCount].of_SetObjectType("DOCUMENT")
	END IF
	
END IF


/*							headerfooter processing	

	Header and footer tags are processed by sections and are not 
	found during document processing.
*/
this.of_GetHeaderTags(lsa_Tags, anv_tagdata)
this.of_GetFooterTags(lsa_Tags, anv_tagdata)

end subroutine

public function integer of_replacetemplatetags (ref n_cst_tagdata anv_tagdata[], long al_topiccount, n_cst_msg anv_tagmessage);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ReplaceTemplateTags
//
//	Access:  private
//
//	Arguments:  as_topic
//
// Returns:		Integer
//
//				   0 = success
//				  -1 = failure
//
//	Description:	
//						
//
// Written by: Norm LeBlanc
// 		Date: 3/1/00
//		Version: 3.0.11
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

integer	li_Return = 1 , &
			li_CustomTagCount, &
			li_Count

long		ll_ObjectCount, &
			ll_Count, &
			ll_TagCount, &
			ll_TagNdx, &
			ll_Pos, &
			ll_Ndx, &
			ll_NdxMax

string	lsa_Tags [], &
			lsa_WorkTag[], &
			ls_Tag, &
			ls_Value, &
			lsa_StrippedTag[], &
			lsa_Result[]
				
boolean	lb_NumberTags

oleObject	lnv_CharacterRange, &
				lnv_Object

datastore	lds_Values
s_Parm		lstr_Parm
n_cst_string	lnv_String

ll_ObjectCount = upperbound ( anv_TagData ) 

FOR ll_Count = 1 to ll_ObjectCount
	IF isvalid ( anv_TagData [ ll_Count ] ) THEN
		anv_TagData[ll_Count].of_GetTags(lsa_Tags)
		lnv_Object = anv_TagData[ll_Count].of_GetObject()
		anv_TagData[ll_Count].of_GetValues(lds_Values)
	END IF

	// *** ON FIRST OBJECT
//	IF ll_Count = 1 THEN
//		//	insert page break and paste template
//		lnv_CharacterRange = inv_document.Characters.last
//		IF al_TopicCount > 1 THEN
//			//If we have any number tags then no page break
//			ll_NdxMax = upperbound ( anv_TagData )
//			FOR ll_Ndx = 1 to ll_NdxMax
//				If anv_TagData [ll_Ndx].of_IsNumberTag ( ) THEN
//					lb_NumberTags = TRUE
//					EXIT
//				END IF
//			NEXT
//			IF not lb_NumberTags THEN
//				lnv_CharacterRange.InsertBreak(2)
//				lnv_CharacterRange.Paste()
//			END IF
//		END IF
//		
//	END IF
//	
	IF isvalid ( lds_Values ) THEN
		CHOOSE CASE UPPER ( anv_TagData [ll_Count].of_GetObjectType() ) 
				
			CASE "DOCUMENT"
				IF isvalid ( lds_Values ) THEN
					//assume one row of data
					IF lds_Values.RowCount() > 0 THEN
						//we have the values now let's update tags 
						ll_TagCount = upperbound ( lsa_Tags )
						IF anv_TagData [ll_Count].of_IsNumberTag ( ) THEN
							IF anv_TagData [ll_Count].of_GetTagNumber() = al_topiccount THEN
								this.of_PreProcessNumberTags( lnv_Object.Range, al_topiccount, lsa_WorkTag )
							ELSE
								CONTINUE
							END IF
						END IF
						
						FOR ll_TagNdx = 1 TO ll_TagCount
								of_FindReplaceTag ( lsa_Tags [ll_TagNdx], lds_values.object.data.primary[1, ll_TagNdx], lnv_Object )
						NEXT
			
					END IF
				END IF
	
			CASE "TABLE"
				of_ReplaceTable ( lsa_Tags, lds_Values, lnv_Object )
				
			CASE "HEADER", "FOOTER"
				of_ReplaceHeaderFooter ( lsa_Tags, lds_Values, lnv_Object )	
				
			CASE ELSE
				//can't replace
				
		END CHOOSE
	END IF
	
NEXT

RETURN -1
end function

private subroutine of_preprocessnumbertags (oleobject anv_range, long al_tagnumber, string asa_tags[]);string	ls_RangeText, &
			lsa_Blank[], &
			lsa_Result[], &
			lsa_Tag[], &
			lsa_StrippedTag[], &
			ls_NewTag
			
long	ll_TagStartPos, &
		ll_TagEndPos, &
		ll_Ndx, &
		ll_TagResultCount, &
		ll_TagArrayCount
		
boolean	lb_GetTag = TRUE

n_cst_string	lnv_String

ll_TagStartPos = 1 
ls_RangeText = anv_Range.Text

DO WHILE lb_GetTag
	ll_TagStartPos = pos( ls_RangeText, "<", ll_TagStartPos )
	IF ll_TagStartPos > 0 THEN
		ll_TagendPos = pos( ls_RangeText, ">", ll_TagStartPos )
		IF ll_TagendPos > 0 THEN
			lsa_Result = lsa_Blank
			
			//check tag for number and error '***"
			lsa_Tag [1] = mid ( ls_RangeText, ll_TagStartPos, ( ll_TagendPos - ll_TagStartPos ) + 1 )
			this.of_StripTagBrackets( lsa_Tag, lsa_StrippedTag )
			lsa_Result = lsa_Blank
			IF lnv_String.of_ParseToArray ( lsa_StrippedTag [1], is_Delimiter , lsa_Result ) > 0 THEN
				IF left ( lsa_Result [1], 3 ) = '***' THEN 
					//remove the error for another go of processing
					lsa_Result [1] = mid ( lsa_Result [1], 4, len( lsa_Result [1] ) - 6 ) // "***" on both ends
				END IF
				IF lsa_Result [1] = string ( al_TagNumber ) THEN
					//rebuild tag and replace
					ll_TagResultCount = upperbound(lsa_Result) 
					ls_NewTag = "<" 
					
					FOR ll_Ndx = 2 to ll_TagResultCount
						ls_NewTag += lsa_Result[ll_Ndx]
						IF ll_Ndx < ll_TagResultCount THEN ls_NewTag += is_Delimiter
					NEXT
					
					ls_NewTag += ">"
					inv_document.Range.find.Execute(lsa_Tag [1],false,true,false,&
							false,false,true,1,false,ls_NewTag,true)
							
					ii_numberofchanges ++
					
					ll_TagArrayCount ++
					asa_Tags[ll_TagArrayCount] = ls_NewTag
					
				END IF
			END IF
			
		ll_TagStartPos = ll_TagendPos

		END IF
	ELSE
		lb_GetTag = FALSE
	END IF
LOOP
end subroutine

private subroutine of_numbertags (oleobject anv_range, ref string asa_tag[], ref n_cst_tagdata anv_tagdata[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTags
//
//	Access:  private
//
//	Arguments:  anv_range
//					asa_tags[] by reference
//					as_number
//
// Returns:		long  -	number of tags
//
//
//	Description:	Loop through range argument for tags and 
//						change tags with a prefix number equal to ai_process. 
//
//
//
// Written by: Norm LeBlanc
// 		Date: 9/12/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
string	lsa_Blank[], &
			lsa_Result[], &
			lsa_Number[], &
			lsa_Tag[], &
			lsa_StrippedTag[]
			
long	ll_Ndx, &
		ll_NumberNdx, &
		ll_NumberArrayCount, &
		ll_ArrayCount, &
		ll_TagArrayCount
		
boolean	lb_NumberFound

n_cst_string	lnv_String

this.of_StripTagBrackets(asa_Tag, lsa_StrippedTag )
ll_TagArrayCount = upperbound ( lsa_StrippedTag )

//Get all unique number tags into array
FOR ll_Ndx = 1 to ll_TagArrayCount
	lsa_Result = lsa_Blank
	IF lnv_String.of_ParseToArray ( lsa_StrippedTag [ll_Ndx], is_Delimiter , lsa_Result ) > 0 THEN
		IF isnumber (lsa_Result [1]) THEN
			ll_NumberArrayCount = upperbound (lsa_Number)
			lb_NumberFound = FALSE
			FOR ll_NumberNdx = 1 to ll_NumberArrayCount
				IF lsa_Number [ll_NumberNdx] = lsa_Result [1] THEN
					lb_NumberFound = TRUE
					EXIT
				END IF
			NEXT
			IF not lb_NumberFound then
				lsa_Number [ll_NumberArrayCount + 1] = lsa_Result [1]
			END IF
		END IF
	END IF
NEXT

ll_NumberArrayCount = upperbound (lsa_Number)
FOR ll_NumberNdx = 1 to ll_NumberArrayCount
	lsa_Tag = lsa_Blank
	ll_ArrayCount = 0
	FOR ll_Ndx = 1 to ll_TagArrayCount
		lsa_Result = lsa_Blank
		IF lnv_String.of_ParseToArray ( lsa_StrippedTag [ll_Ndx], is_Delimiter , lsa_Result ) > 0 THEN
			IF isnumber (lsa_Result [1]) THEN
				IF lsa_Result [1] = lsa_Number[ll_NumberNdx] THEN
					ll_ArrayCount ++
					lsa_Tag[ll_ArrayCount] = asa_Tag [ll_Ndx]
					asa_Tag [ll_Ndx] = ''
				END IF
			END IF
		END IF
	NEXT
	IF upperbound ( lsa_Tag ) > 0 THEN
		ll_ArrayCount = upperbound ( anv_TagData )
		ll_ArrayCount ++
		anv_TagData[ll_ArrayCount] = Create n_cst_TagData
		anv_TagData[ll_ArrayCount].of_SetObject(inv_Document)
		anv_TagData[ll_ArrayCount].of_SetTags(lsa_Tag)
		anv_TagData[ll_ArrayCount].of_SetTagNumber(long(lsa_Number[ll_NumberNdx]))
		anv_TagData[ll_ArrayCount].of_SetTagDelimiter(is_delimiter)
		anv_TagData[ll_ArrayCount].of_SetObjectType("DOCUMENT")
	END IF

NEXT

end subroutine

public function integer of_getnumberofchanges ();return ii_NumberOfChanges
end function

private subroutine of_getfootertags (ref string asa_tags[], ref n_cst_tagdata anv_tagdata[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFooterTags
//
//	Access:  private
//
//	Arguments:  asa_Tags[] by reference
//
// Returns:		long
//
//				   number of tags
//
//	Description:	
//						
//
// Written by: Norm LeBlanc
// 		Date: 9/13/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

string	ls_RangeText
				
oleObject	lnv_SingleSection, &
			 	lnv_Footers, &
			 	lnv_SingleFooter
				 
long		ll_FootersCount, &
			ll_TagCount, &
			ll_Count1, &
			ll_ArrayCount
			
datastore lds_Values
/*	
	Sections represent pages for the multiple topics and could contain
	tag values. 

*/
If inv_Document.Sections.Count > 0 THEN
	ll_ArrayCount = upperbound ( anv_tagdata )
	//always processing last section
	lnv_SingleSection = inv_Document.Sections.Item( inv_Document.Sections.Count )
	//	Look for footer tags
	lnv_Footers = lnv_SingleSection.Footers
	ll_FootersCount = lnv_Footers.Count
	FOR ll_Count1 = 1 TO ll_FootersCount 	
		lnv_SingleFooter = lnv_Footers.Item( ll_Count1 )
		ls_RangeText = lnv_SingleFooter.Range.Text
		IF this.of_GetTags ( ls_RangeText, asa_Tags )  > 0 THEN
			ll_ArrayCount ++
			anv_TagData[ll_ArrayCount] = Create n_cst_TagData
			anv_TagData[ll_ArrayCount].of_SetObject(lnv_Footers)
			anv_TagData[ll_ArrayCount].of_SetTags(asa_Tags)
			anv_TagData[ll_ArrayCount].of_SetTagDelimiter(is_delimiter)
			anv_TagData[ll_ArrayCount].of_SetObjectType("FOOTER")
			
		END IF
	NEXT
	
END IF


end subroutine

on n_cst_template_word.create
call super::create
end on

on n_cst_template_word.destroy
call super::destroy
end on

