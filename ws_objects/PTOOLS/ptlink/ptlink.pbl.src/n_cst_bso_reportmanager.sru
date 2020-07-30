$PBExportHeader$n_cst_bso_reportmanager.sru
forward
global type n_cst_bso_reportmanager from n_cst_bso
end type
end forward

global type n_cst_bso_reportmanager from n_cst_bso autoinstantiate
end type

type variables
Protected:
oleobject		inv_OleReport
oleobject		inv_Document
oleobject		inv_Workbook
any 		iaa_TopicBeo []
any 		iaa_TopicSingleBeo []
long		il_ShipId
string		is_TemplateFileName
string		is_TemplateType
string		is_Topic
string		is_Delimiter
string		is_OldRangeText
integer		ii_NumberOfChanges
boolean		ib_PrepareforURL
boolean		ib_NoTopicBeo
boolean		ib_convertedtabletotext
n_cst_msg	inv_TagMessage
end variables

forward prototypes
public subroutine of_readme ()
private function integer of_connecttoobject (string as_objectname, string as_objecttype)
private function string of_gettemplatetype (string as_filename)
private function datastore of_createdatastore (string asa_tags[])
private function integer of_validatetemplatefile (ref string as_filename)
private subroutine of_loaddata (ref any aaa_data[])
public function integer of_createreport (string as_topic, string as_templatefilename, any aaa_beo[], boolean ab_display, boolean ab_includeform, ref any aaa_data[], ref n_cst_msg anv_tagmessage)
public subroutine of_printwordtemplate ()
public function integer of_populateexceltemplate (ref n_cst_msg anv_tagmessage)
protected subroutine of_replaceexcelrowtags (datastore ads_values, string asa_tags[], string asa_formula[], ref oleobject anv_rowsrange, long al_replacerow)
private subroutine of_processexcelrowsrange (ref oleobject anv_rowsrange, long al_rowrangecount)
private subroutine of_processexceltagrange (oleobject anv_tagrange)
private function integer of_populatewordtemplate (n_cst_msg anv_tagmessage)
private subroutine of_striptagbrackets (string asa_tags[], ref string asa_strippedtags[])
private subroutine of_stripnumber (ref string asa_tag[], long al_number)
public function integer of_test (n_cst_msg anv_tagmessage)
public function long of_gettags (string as_text, ref string asa_Tags[])
private function datastore of_processrange (oleobject anv_range, any aaa_beo[], ref string asa_tags[])
private subroutine of_converttablestotext ()
public function integer of_processgenerictaglist (any aa_beosource, string asa_tags[], ref any aaa_data[])
public function integer of_processstring (string as_input, ref string as_output, any aa_beosource, n_cst_msg anv_tagmessage)
public subroutine of_setdelimiter (string as_delimiter)
public function string of_getdelimiter ()
private function datastore of_processrange (ref string asa_tags[])
public function integer of_processstring (string as_input, ref string as_output, n_cst_msg anv_tagmessage)
public function integer of_process_report_request (string as_file)
public function integer of_processcustomtag (string as_tag, ref string as_value)
end prototypes

public subroutine of_readme ();//////////////////////////////////////////////////////////////////////////////
//
//	Object:	n_cst_bso_ReportManager
//
//	Ancestor:	n_cst_bso
//
//	Public Access:
//
//	Description:	This object is used for populating a report template with
//						data from the Profit Tools DB. To use this object you must 
//						supply the filename and topic.
//
//						The template type will be determined from the file extension.
//						This object will open the appropriate object type (eg. Word)
//						and search the template for the topic tag. If the topic does
//						not match the passed topic then nothing will be done.
//
//
//	
//
//				
//
// Methods:
//				of_ConnectToObject
//				of_CreateDatastore
//				of_CreateReport 	(public method)
//				of_GetTag - range text
//				of_GetTags - range object, tags
//				of_getTags - range text, tags
//				of_GetTemplateFile
//				of_GetTemplateType
//				of_LoadData
//				of_PopulateWordTemplate
//				of_PreProcessTags
//				of_ProcessHeaderFooterTags
//				of_ProcessRange
//				of_ProcessTabletags
//				of_ReplaceRowTags
//				of_StripTagBrackets
//				of_ValidateTemplateFile
//				of_ValidateTemplateTopic
//
//
// Written by: Norm LeBlanc
// 		Date: 9/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

end subroutine

private function integer of_connecttoobject (string as_objectname, string as_objecttype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConnectToObject
//
//	Access:  private
//
//	Arguments:  as_objectname	value
//					as_objecttype	value
//
// Returns:		integer
//
//				   1 = success
//				  -1 = failure
//
//	Description:	Try to connect to the appropriate object based on as_objecttype. 
//
// Written by: Norm LeBlanc
// 		Date: 9/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

string	ls_Object, &
			ls_MessageLabel, &
			ls_Text

integer li_Return

li_Return = 1 

CHOOSE CASE as_ObjectType
	CASE "WORD"
		ls_Object = "word.application"
		ls_MessageLabel = "Couldn't connect to Word Document " + is_templatefilename + ". Error: " 
		
	CASE "EXCEL"
		ls_Object = "excel.application"
		ls_MessageLabel = "Couldn't connect to Excel Spreadsheet " + is_templatefilename + ". Error: " 

	CASE ELSE
		li_Return = -1
		
END CHOOSE
			
IF li_Return = 1 THEN
	inv_OleReport = Create oleObject
	
	choose case inv_OleReport.ConnectToObject("",ls_object)
			
		case 0 		//  connnection made
			//	continue
			
		case -1		
			ls_Text = ls_MessageLabel + "-1. Error msg - Invalid Call: the argument is the Object property of a control."
			li_Return = -1
			
		case -2  	//	 
			ls_Text = ls_MessageLabel + "-2. Error msg - Class name not found."
			li_Return = -1
			
		case -3  	//	 
			ls_Text = ls_MessageLabel + "-3. Error msg - Object could not be created."
			li_Return = -1
			
		case -4  	//	 
			ls_Text = ls_MessageLabel + "-4. Error msg - Could not connect to object."
			li_Return = -1
			
		CASE -5  
//			ls_Text = ls_MessageLabel + "-5. Can't connect to the currently active object."
			//creating a new object
			
			CHOOSE CASE	inv_OleReport.ConnectToNewObject(ls_object)
				case -1		
					ls_Text = ls_MessageLabel + "-1. Error msg - Invalid Call: the argument is the Object property of a control."
					li_Return = -1
					
				case -2  	//	 
					ls_Text = ls_MessageLabel + "-2. Error msg - Class name not found."
					li_Return = -1
					
				case -3  	//	 
					ls_Text = ls_MessageLabel + "-3. Error msg - Object could not be created."
					li_Return = -1
					
				case -4  	//	 
					ls_Text = ls_MessageLabel + "-4. Error msg - Could not connect to object."
					li_Return = -1
					
				CASE	-9  // Other error
					ls_Text = ls_MessageLabel + "-9. Error msg - Other error."
					li_Return = -1
							
			END CHOOSE

		CASE -6
			ls_Text = ls_MessageLabel + "-6.  Filename is not valid."
			li_Return = -1
			
		CASE -7
			ls_Text = ls_MessageLabel + "-7.  File not found or file couldn't be opened."
			li_Return = -1 
			
		CASE -8
			ls_Text = ls_MessageLabel + "-8.  Load from file not supported by server."
			li_Return = -1
			
		case -9  	//	 
			ls_Text = ls_MessageLabel + "-9. Error msg - Other error."
			li_Return = -1
	
		CASE ELSE	//  
			ls_Text = ls_MessageLabel + "Unexpected return."
			li_Return = -1
				
	end choose

END IF

IF li_Return = -1 THEN
	MessageBox ( "Open Template" , ls_Text )
END IF 

return li_Return
end function

private function string of_gettemplatetype (string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTemplateType
//
//	Access:  private
//
//	Arguments:  as_FileName value
//
// Returns:		String	ObjectType
//
//
//	Description:	Determine what application or object will be used for the 
//						report display and manipulation based on the file extension.
//
// Written by: Norm LeBlanc
// 		Date: 9/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
String	ls_ObjectType, &
			ls_FileExtension
			
Long		ll_Pos

IF len ( as_filename ) > 0 THEN
	
	ll_pos = pos ( as_FileName, "." )
	IF ll_pos > 0 THEN
		ls_FileExtension = mid ( as_FileName, ll_Pos + 1 )
	END IF

	CHOOSE CASE upper ( ls_FileExtension )
		CASE "DOC", "DOT"
			ls_ObjectType = "WORD"
			
		CASE "XLS"
			ls_ObjectType = "EXCEL"
					
		CASE "TXT"
			ls_ObjectType = "TEXT"
					
	END CHOOSE
END IF

return ls_ObjectType
end function

private function datastore of_createdatastore (string asa_tags[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CreatTableDatastore
//
//	Access:  private
//
//	Arguments:  asa_tags[]
//
// Returns:		datastore
//
//
//	Description:	Create datastore and add tags as colmn headings
//						
//
// Written by: Norm LeBlanc
// 		Date: 9/14/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

Long		ll_TagCount, &
			ll_Tagndx

String	lsa_StrippedTags [], &
			lsa_Result []

datastore	lds_Values
n_cst_string	lnv_String
n_cst_dws		lnv_dws

of_StripTagBrackets ( asa_tags, lsa_StrippedTags ) 

ll_TagCount = upperbound ( lsa_StrippedTags )

FOR ll_TagNdx = 1 TO ll_TagCount
	IF lnv_String.of_ParseToArray ( lsa_StrippedTags [ll_TagNdx], is_Delimiter, lsa_Result ) > 0 THEN
		// just property
		lsa_StrippedTags[ll_TagNdx] =  lsa_Result [ upperbound ( lsa_Result ) ]
	END IF
NEXT


lds_Values = lnv_Dws.of_CreateDataStore ( ll_TagCount )
//lds_Values = lnv_Dws.of_CreateDataStore ( lsa_StrippedTags )
RETURN lds_Values

end function

private function integer of_validatetemplatefile (ref string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTemplateFile
//
//	Access:  private
//
//	Arguments:  as_filepath reference
//
// Returns:		Integer
//
//				   0 = success
//				  -1 = failure
//
//	Description:	Attempt to get a filename or folder from the system setting
//						Make sure file will be able to be opened.
//
// Written by: Norm LeBlanc
// 		Date: 9/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

String	ls_String, &
			ls_File, &
			ls_Path
			
Integer	li_SqlCode

Integer	li_Return = 1

Integer		li_FileID

n_cst_string			lnv_String
n_cst_FileSrvWin32	lnv_FileSrv

lnv_FileSrv = CREATE n_cst_FileSrvWin32

IF fileexists ( as_filename) THEN 

ELSE
	CHOOSE CASE MessageBox ( "File Access" , "The file '" + as_filename + &
		"' does not exist. Would You like to select a template ? ", Question!, YesNo! )
		
		CASE 1
			IF GetFileOpenName("Select File", ls_Path, ls_File, "doc", + &
								"Word Document (*.doc), *.doc,Word Template (*.dot),*.dot, Excel Spreadsheet ( *.xls), *.xls") = 1 THEN
				as_filename = ls_Path 
			END IF
			
		CASE ELSE
			li_Return = -1
			
	END CHOOSE
			

END IF


RETURN li_Return


end function

private subroutine of_loaddata (ref any aaa_data[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_LoadData
//
//	Access:  private
//
//	Arguments:  aaa_data[]
//
// Returns:		Long
//
//				   number of entries in array
//
//	Description:	
//
// Written by: Norm LeBlanc
// 		Date: 11/09/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
string		ls_ParagraphText, &
				ls_Text

long			ll_ParagraphCount, &
				ll_Ndx


oleobject	lnv_Paragraphs, &
				lnv_SingleParagraphRange

n_cst_string	lnv_string

//process sentences - grab sentence range and append to file
lnv_Paragraphs = inv_document.Paragraphs
ll_ParagraphCount = lnv_Paragraphs.Count

FOR ll_Ndx = 1 TO ll_ParagraphCount

	lnv_SingleParagraphRange = lnv_Paragraphs.Item(ll_Ndx)
	ls_ParagraphText = lnv_SingleParagraphRange.range.Text
	
	//Remove nonprintable characters
	if pos(ls_ParagraphText,'~t') > 0 then
		//don't remove tabs
		ls_Text = ls_ParagraphText
	else
		ls_Text = lnv_string.of_RemoveNonPrint ( ls_ParagraphText )
	end if
	
	aaa_data[ll_Ndx] = ls_Text
	
NEXT


//senetences won't work if there is a period in the line
//string		ls_SentenceText
//
//long 			ll_SentenceCount
//
//
//oleobject	lnv_Sentences, &
//				lnv_SingleSentenceRange
//				
////process sentences - grab sentence range and append to file
//lnv_Sentences = inv_document.Sentences
//ll_SentenceCount = lnv_Sentences.Count
//
//FOR ll_Ndx = 1 TO ll_SentenceCount
//
//	lnv_SingleSentenceRange = lnv_Sentences.Item(ll_Ndx)
//	ls_SentenceText = lnv_SingleSentenceRange.Text
//	//Remove nonprintable characters
//	ls_Text = lnv_string.of_RemoveNonPrint ( ls_SentenceText )
//	aaa_data[ll_Ndx] = ls_Text
//	
//NEXT
//
end subroutine

public function integer of_createreport (string as_topic, string as_templatefilename, any aaa_beo[], boolean ab_display, boolean ab_includeform, ref any aaa_data[], ref n_cst_msg anv_tagmessage);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CreateReport
//
//	Access:  public
//
//	Arguments:  as_topic
//					as_TemplateFilename
//					aaa_beo[]
//					ab_Display
//					ab_IncludeForm ( text and labels surrounding tags )
//					aaa_data[]
//					anv_process_message ( used to determine any special processing ) 
//
// Returns:		Integer
//
//				   0 = success
//				  -1 = failure
//
//	Description:	
//
// Written by: Norm LeBlanc
// 		Date: 9/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

integer	li_Return
string	ls_version
n_cst_msg	lnv_msg
s_parm		lstr_parm

li_Return = 1

is_Topic = as_Topic
iaa_TopicBeo = aaa_beo

ii_NumberOfChanges = 0

//set instance message object - this will be check during data gathering
IF isvalid ( anv_TagMessage )  THEN

	inv_TagMessage = anv_TagMessage

	IF anv_TagMessage.of_Get_Parm ( "URL" , lstr_Parm ) <> 0 THEN
		ib_PrepareforURL = TRUE
	END IF

END IF


IF of_ValidateTemplateFile ( as_templatefilename ) = 1 THEN
	is_TemplateType = of_GetTemplateType ( as_templatefilename )
	
	IF len ( is_TemplateType ) > 0 THEN
		is_templatefilename = as_templatefilename
		
		IF this.of_ConnectToObject ( is_templatefilename, is_TemplateType ) = 1 THEN
			
			CHOOSE CASE is_TemplateType
				CASE "WORD"
					IF this.of_PopulateWordTemplate ( anv_tagmessage ) < 0 THEN
						li_Return = -1
					END IF

					IF li_Return = 1 THEN
						
						IF ab_Display THEN
							inv_OleReport.Application.Visible=TRUE
						ELSE
							//Pass back report
							IF ab_IncludeForm THEN
								this.of_ConvertTablesToText()
								this.of_LoadData ( aaa_data ) 

/*	After changing the tags and getting my data, I had problems	closing the document 
without saving changes for background processing. Word is ignoring the parameter for
wdDoNotSaveChanges = 0.	My alternative solution was to keep track of the number of changes
and then run the undo command that many times. This works and word doesn't see any changes
to the document and therefore closes without complaints.
*/

			//try to get version of word and close based on that
//								ls_version = inv_OleReport.Application.version				
//								messagebox('os name',ls_version)
								
								/*	
									The number of change count is not working for the converttabletotext
									so i'm closing without saving the changes
									this doesn't always work and leaves word open.
								*/
								if ib_convertedtabletotext then
									inv_OleReport.Application.Documents.Close(0) 
								else
									inv_Document.Undo(ii_NumberOfChanges)
									inv_Document.Close( )	
								end if
							
							END IF
							
						END IF

					END IF
					
				CASE "EXCEL"
					IF this.of_PopulateExcelTemplate (anv_TagMessage) < 0 THEN
						li_Return = -1			
					END IF
					IF li_Return = 1 then
						inv_Workbook.Application.Visible=TRUE
					END IF
					
				CASE "GENERIC"
					
					
				CASE ELSE
					
			END CHOOSE
		ELSE
			li_Return = -1
			
		END IF
			
	END IF

ELSE
	li_Return = -1
END IF

	
	

return li_Return
end function

public subroutine of_printwordtemplate ();//			wdWindowStateMaximize = 1
//			wdDialogFilePrint = 88 , &

oleobject	lnv_OlePrintDialog

//inv_OleReport.Application.showme()
inv_OleReport.Application.windowstate=1

lnv_OlePrintDialog = inv_OleReport.Application.Dialogs.Item(88)
lnv_OlePrintDialog.show()

//lnv_ReportManager.inv_Document.PrintOut([background], [Append], [Range], [OutputFileName], &
//													[From], [To], [Item], [Copies], [Pages], [PageType], &
//													[PrintToFile], [Collate], [ActivePrinterMacGX], [ManualDuplexPrint])
//

end subroutine

public function integer of_populateexceltemplate (ref n_cst_msg anv_tagmessage);integer	li_Return = 1 , &
			li_count, &
			li_ContextTagCnt

long		ll_RowRangecount

string	ls_Tag, &
			ls_TopicTag, &
			ls_FirstAddress, &
			ls_LastAddress, &
			ls_Value
			
oleObject	lnv_ApplicationRange, &
				lnv_RowsRange, &
				lnv_NextRange, &
				lnv_TagRange, &
				lnv_EntireRowRange
				 
s_parm		lstr_Parm

inv_Workbook = inv_OleReport.Application.WorkBooks.open(is_TemplateFileName,false,true)
//inv_Workbook.Application.Visible=TRUE
lnv_ApplicationRange = inv_Workbook.Application.Cells

// Check for topic tag and set delimiter type being used in tag
	//make sure topic matches data being requested on template
//ADD SOME RETRY LOGIC
//first try dot
ls_TopicTag = "<USE." + upper ( is_topic )  + ">"
lnv_NextRange = lnv_ApplicationRange.Find(ls_TopicTag)

IF isvalid ( lnv_NextRange ) THEN
	
	is_Delimiter = "."
	
ELSE	//try underscore
	
	ls_TopicTag = "<USE_" + upper ( is_topic )  + ">"
	lnv_NextRange = lnv_ApplicationRange.Find(ls_TopicTag)

	IF isvalid ( lnv_NextRange ) THEN
		
		is_Delimiter = "_"
		
	ELSE			//topic couldn't be found
		messagebox( "Template error", " Could not find the " + is_topic + &
						" topic tag in the template. " + &
						"The template could already be opened and needs to be closed. " + &
						"Please close the template or add this tag to the top of the " + &
						"newly created template and try again." )
		inv_Workbook.close()				
		DESTROY inv_OleReport
		li_Return = -1
		
	END IF
	
END IF
			
IF li_Return = 1 THEN

	//	Remove topic tag
	ls_TopicTag = "<USE" + is_Delimiter + upper ( is_topic )  + ">"
	lnv_NextRange = lnv_ApplicationRange.Find(ls_TopicTag)
	ls_FirstAddress = lnv_NextRange.Address
	lnv_EntireRowRange = lnv_NextRange.EntireRow
	lnv_EntireRowRange.Delete()
//	lnv_NextRange.Value = ""
	
	//PROCESS ANY CONTEXT TAGS PASSED IN THE TAGMESSAGE OBJECT
	
	//**	We may want to put this logic in the loop process to populate
	//**	context tags in each occurrence of the topics.
	IF isvalid ( anv_TagMessage ) THEN
		
		li_ContextTagCnt = anv_TagMessage.of_Get_Count ( )
		
		FOR li_Count = 1 to li_ContextTagCnt
			
			IF anv_TagMessage.of_Get_Parm ( li_Count, lstr_Parm ) <> 0 THEN
				ls_Tag = lstr_Parm.is_Label
				ls_Tag = "<" + ls_Tag + ">"
				ls_Value = string ( lstr_Parm.ia_Value )
				
				lnv_NextRange = lnv_ApplicationRange.Find(ls_Tag)
				IF isvalid ( lnv_NextRange ) THEN
					lnv_NextRange.Value = ls_Value
				END IF
				
			END IF
			
		NEXT

	END IF 
	
lnv_NextRange = lnv_ApplicationRange.Find("<endtag>")
IF isvalid ( lnv_NextRange ) THEN
	ls_LastAddress = lnv_NextRange.Address
	lnv_NextRange.Value = ""
	
ELSE
	messagebox( "Template error", " Could not find the <endtag> in the template. " + &
					"Please add this tag to the bottom right hand corner of the template and try again." )
	li_Return = -1
	
END IF

				
	lnv_ApplicationRange = inv_Workbook.Application.Range(ls_FirstAddress,ls_LastAddress)
	lnv_RowsRange = lnv_ApplicationRange.Rows
	lnv_TagRange = lnv_ApplicationRange.Rows

	///logic for multiple topics
	//doesn't work for single
	THIS.of_ProcessExcelTagRange(lnv_TagRange)
	return li_Return
	
	
//*****REMOVE CODE BELOW AFTER TESTING*******

	//loginc for single
	ll_RowRangecount = lnv_RowsRange.count
//	THIS.of_ProcessExcelRowsRange(lnv_RowsRange, ll_RowRangeCount )

string	lsa_blank[], &
			ls_RangeText, &
			lsa_Tags [], &
			ls_ErrorTag, &
			ls_Address, &
			ls_Formula
			
oleObject	lnv_RowRange, &
				lnv_NextRowRange, &
				lnv_ColumnsRange, &
				lnv_ColumnRange
				 
long		ll_TopicCount, &
			ll_Count1, &
			ll_TagCount, &
			ll_TagNdx, &
			ll_RowCount, &
			ll_ColumnCount, &
			ll_Ndx, &
			ll_Ndx2, &
			ll_RowNdx, &
			ll_DSCount
datastore	lds_Values

	//	Get Tags from each row in the range
	FOR ll_ndx = 1 TO ll_RowRangecount
	//what about inserted rows ?
		lsa_Tags = lsa_Blank
		lnv_RowRange = lnv_RowsRange.item(ll_ndx)
		lnv_ColumnsRange = lnv_RowRange.Columns
		ll_ColumnCount = lnv_ColumnsRange.Count

		FOR ll_ndx2 = 1 to ll_ColumnCount
			
			lnv_ColumnRange = lnv_ColumnsRange.item(ll_ndx2)
			IF left ( lnv_ColumnRange.text, 1 ) = "<" AND &
				right ( lnv_ColumnRange.text, 1 ) = ">" THEN
				ll_TagNdx ++
				lsa_Tags [ll_ndx2] = lnv_ColumnRange.text
			END IF
		
		NEXT
		
		ll_TagCount = upperbound ( lsa_Tags ) 
		
		//	Get the data values for the tags in the current row
		IF ll_TagCount > 0 THEN //PROCESS TAGS
	
			lds_Values = THIS.of_ProcessRange ( lnv_RowRange, iaa_TopicBeo, lsa_Tags )
			ll_RowCount = lds_Values.RowCount()
			
			IF ll_RowCount > 0 THEN
				//we have the values now let's update tags in row object
				FOR ll_TagNdx = 1 TO ll_TagCount
					
					ll_DSCount = 0

					IF ll_TagNdx = 1 THEN
						lnv_NextRowRange = lnv_RowsRange.item( ll_ndx + 1)
						FOR ll_RowNdx = 1 TO ll_RowCount
							lnv_NextRowRange.Insert()
						NEXT
					END IF
					
					ll_Ndx2 = ( ll_RowCount + ll_Ndx ) - 1
					FOR ll_RowNdx = ll_Ndx TO ll_Ndx2
						lnv_NextRowRange = lnv_RowsRange.item(ll_RowNdx)
						lnv_ColumnsRange = lnv_NextRowRange.Columns
						lnv_ColumnRange = lnv_ColumnsRange.item(ll_TagNdx)
						ls_rangetext = lnv_ColumnRange.text
						ll_DSCount ++
						ls_Formula = ''
						
						IF ll_RowNdx = ll_Ndx then
							//First row contains the tag. Let's replace the tag.
							ls_Value = lds_values.object.data.primary[ll_DSCount, ll_TagNdx] 
							IF isnull ( ls_Value ) THEN
								If len ( lsa_Tags [ll_TagNdx] ) > 0 THEN
									ls_ErrorTag = "***" + mid ( lsa_Tags [ll_TagNdx], 2,  len ( lsa_Tags [ll_TagNdx] ) - 2 ) + "***"
									lnv_ColumnRange.Value = ls_ErrorTag
								END IF
							ELSE
								lnv_ColumnRange.Value = ls_Value
							END IF
							//Let's check for a formulas. If there is one then copy to inserted cells.
							ls_Formula = lnv_ColumnRange.Formula
							
						ELSE
							lnv_ColumnRange = lnv_ColumnsRange.item(ll_TagNdx)										
							ls_Value = lds_values.object.data.primary[ll_DSCount, ll_TagNdx] 
							IF isnull ( ls_Value ) THEN
								If len ( lsa_Tags [ll_TagNdx] )  > 0 THEN
									ls_ErrorTag = "***" + mid ( lsa_Tags [ll_TagNdx], 2,  len ( lsa_Tags [ll_TagNdx] ) - 2 ) + "***"
									lnv_ColumnRange.Value = ls_ErrorTag
								END IF
							ELSE
								lnv_ColumnRange.Value = ls_Value
								IF len ( ls_Formula ) > 0 THEN
									lnv_ColumnRange.Formula = ls_Formula
								END IF
								
							END IF
						END IF	
					NEXT

				NEXT
					
				IF isvalid ( lds_Values ) THEN
					DESTROY lds_Values
				END IF
	
			END IF
		
		END IF

	NEXT
	

END IF

return li_Return


end function

protected subroutine of_replaceexcelrowtags (datastore ads_values, string asa_tags[], string asa_formula[], ref oleobject anv_rowsrange, long al_replacerow);/*
		Replace the tags with the data and if there is more than 
		one row or data then insert rows and populate data.
		Modify in row formula to match row references if inserting
		new rows.

*/
string	ls_RangeText, &
			ls_Value, &
			ls_ErrorTag, &
			ls_Formula

long	ll_TagCount, &
		ll_FormulaCount, &
		ll_RowCount, &
		ll_TagNdx, &
		ll_RowNdx, &
		ll_Ndx, &
		ll_DSCount, &
		ll_Pos
		
oleobject	lnv_NextRowRange, &
				lnv_ColumnsRange, &
				lnv_ColumnRange
		

ll_TagCount = upperbound ( asa_Tags ) 
ll_FormulaCount = upperbound ( asa_Formula )

ll_RowCount = ads_Values.RowCount()

FOR ll_TagNdx = 1 TO ll_TagCount
	
	ll_DSCount = 0

	IF ll_TagNdx = 1 THEN
		IF ll_RowCount > 1 THEN
			lnv_NextRowRange = anv_RowsRange.item( al_replacerow + 1)
			FOR ll_RowNdx = 1 TO ll_RowCount
				lnv_NextRowRange.Insert()
			NEXT
		END IF
	END IF
	
	ll_Ndx = ( ll_RowCount + al_replacerow ) - 1
	
	FOR ll_RowNdx = al_replacerow TO ll_Ndx
		lnv_NextRowRange = anv_RowsRange.item(ll_RowNdx)
		lnv_ColumnsRange = lnv_NextRowRange.Columns
		lnv_ColumnRange = lnv_ColumnsRange.item(ll_TagNdx)
		ls_rangetext = lnv_ColumnRange.text
		ll_DSCount ++
		ls_Formula = ''
		
		IF ll_RowNdx = al_replacerow then
			//First row contains the tag. Let's replace the tag.
			ls_Value = ads_values.object.data.primary[ll_DSCount, ll_TagNdx] 
			IF isnull ( ls_Value ) THEN
				If len ( asa_Tags [ll_TagNdx] ) > 0 THEN
					ls_ErrorTag = "***" + mid ( asa_Tags [ll_TagNdx], 2,  len ( asa_Tags [ll_TagNdx] ) - 2 ) + "***"
					lnv_ColumnRange.Value = ls_ErrorTag
				END IF
			ELSE
				lnv_ColumnRange.Value = ls_Value
			END IF
			//Let's check for a formulas. 
			IF ll_FormulaCount > 0 THEN
				//this logic needs to be changed to use the autofill feature
				// AutoFill(Destination As Range, [Type As XlAutoFillType = xlFillDefault])

				IF len ( trim ( asa_Formula [ll_TagNdx] ) ) > 0 THEN
					lnv_ColumnRange.Formula = asa_Formula [ll_TagNdx] 
				END IF
			END IF
			
		ELSE
			lnv_ColumnRange = lnv_ColumnsRange.item(ll_TagNdx)										
			ls_Value = ads_values.object.data.primary[ll_DSCount, ll_TagNdx] 
			IF isnull ( ls_Value ) THEN
				If len ( asa_Tags [ll_TagNdx] )  > 0 THEN
					ls_ErrorTag = "***" + mid ( asa_Tags [ll_TagNdx], 2,  len ( asa_Tags [ll_TagNdx] ) - 2 ) + "***"
					lnv_ColumnRange.Value = ls_ErrorTag
				END IF
			ELSE
				lnv_ColumnRange.Value = ls_Value					
			END IF
			//Let's check for a formulas. 
			IF ll_FormulaCount > 0 THEN
				IF len ( trim ( asa_Formula [ll_TagNdx] ) ) > 0 THEN
					//need to replace row number in formula
					//replace saved row with ll_RowNdx
					ls_Formula = asa_Formula [ll_TagNdx] 
					DO 
						ll_Pos = ll_Pos + 2
						ll_Pos = Pos ( ls_Formula, string (al_replacerow), ll_Pos )
						IF ll_Pos > 0 THEN
							ls_Formula = replace ( ls_Formula, ll_Pos, len ( string (al_replacerow) ), string ( ll_RowNdx ) )
						END IF
						
					LOOP UNTIL ll_Pos = 0
					
					lnv_ColumnRange.Formula = ls_Formula
					
				END IF
			END IF
			
		END IF	
	NEXT

NEXT
	

end subroutine

private subroutine of_processexcelrowsrange (ref oleobject anv_rowsrange, long al_rowrangecount);string	lsa_blank[], &
			lsa_Tags [], &
			ls_Tag, &
			ls_TopicTag, &
			lsa_Formula[]
			
oleObject	lnv_RowRange, &
				lnv_ColumnsRange, &
				lnv_ColumnRange
				
long		ll_TagCount, &
			ll_RowRangeCount, &
			ll_RowCount, &
			ll_ColumnCount, &
			ll_Ndx, &
			ll_Ndx2

datastore	lds_Values
string ls_address
ls_address = anv_rowsrange.address
//loop thru rows in range
FOR ll_ndx = 1 TO al_RowRangecount
//what about inserted rows ?
	lsa_Tags = lsa_Blank
	lsa_Formula = lsa_Blank
	lnv_RowRange = anv_RowsRange.item(ll_ndx)
	lnv_ColumnsRange = lnv_RowRange.Columns
	ll_ColumnCount = lnv_ColumnsRange.Count

	//	Get Tags from each row in the range
	FOR ll_ndx2 = 1 to ll_ColumnCount
		
		lnv_ColumnRange = lnv_ColumnsRange.item(ll_ndx2)
		IF left ( lnv_ColumnRange.text, 1 ) = "<" AND &
			right ( lnv_ColumnRange.text, 1 ) = ">" THEN
			ls_Tag = lnv_ColumnRange.text
			IF pos ( ls_Tag, "<=", 1 ) > 0 THEN
				// in row formula, strip off brackets
				// move tag to formula array retaining position in row
				lsa_Formula [ll_Ndx2] = mid ( ls_Tag, 2, len ( ls_Tag ) - 2 )
				lsa_Tags [ll_Ndx2] = ''
			ELSE
				lsa_Tags [ll_ndx2] = ls_Tag
			END IF 
		END IF
						
	NEXT
	
	ll_TagCount = upperbound ( lsa_Tags ) 
	
	//	Get the data values for the tags in the current row
	IF ll_TagCount > 0 THEN //PROCESS TAGS
		lds_Values = THIS.of_ProcessRange ( lnv_RowRange, iaa_TopicSingleBeo, lsa_Tags )
		ll_RowCount = lds_Values.RowCount()
		
		IF ll_RowCount > 0 THEN
			
			THIS.of_ReplaceExcelRowTags(lds_Values, lsa_Tags, lsa_Formula, anv_RowsRange, ll_ndx)
			
			IF isvalid ( lds_Values ) THEN
				DESTROY lds_Values
			END IF

		END IF
	
	END IF

NEXT
end subroutine

private subroutine of_processexceltagrange (oleobject anv_tagrange);integer	li_Return = 1 , &
			li_count, &
			li_ContextTagCnt

long		ll_TopicCount, &
			ll_Count, &
			ll_Ndx, &
			ll_RowCount, &
			ll_NextRow, &
			ll_SaveRowsCount, &
			ll_RowRangecount, &
			ll_row, &
			ll_ArrayCount, &
			ll_ColumnCount, &
			ll_Ndx2
			
string	ls_Tag, &
			ls_TopicTag, &
			ls_FirstAddress, &
			ls_LastAddress, &
			ls_Value, &
			lsa_Value[]
			
oleObject	lnv_ApplicationRange, &
				lnv_RowsRange, &
				lnv_NextRange, &
				lnv_NextRowsRange, &
				lnv_EndTag, &
				lnv_topicTag, &
				lnv_RowRange, &
				lnv_ColumnsRange, &
				lnv_SaveRowRange, &
				lnv_SaveColumnsRange, &
				lnv_ColumnRange, &
				lnv_SaveColumnRange
				
				 
boolean	lb_Retry = TRUE

s_parm		lstr_Parm

ll_TopicCount = upperbound ( iaa_TopicBeo )
ll_SaveRowsCount = anv_TagRange.Count

//load array of cells
FOR ll_ndx = 1 TO ll_SaveRowsCount
	
	lnv_SaveRowRange = anv_TagRange.item(ll_ndx)
	lnv_SaveColumnsRange = lnv_SaveRowRange.Columns
	ll_ColumnCount = lnv_SaveColumnsRange.count
	//same count as rowrange

	FOR ll_ndx2 = 1 to ll_ColumnCount
		ll_ArrayCount ++
		lnv_SaveColumnRange = lnv_SaveColumnsRange.item(ll_ndx2)
		lsa_Value[ll_ArrayCount] = string ( lnv_SaveColumnRange.Value )
						
	NEXT
	
NEXT

FOR ll_Count = 1 to ll_TopicCount
	
	IF ll_Count > 1 THEN
		
		//insert lnv_SaveRowsRange after last range processed
		lnv_NextRowsRange = lnv_RowsRange.item(ll_NextRow)
		FOR ll_Ndx = 1 to ll_SaveRowsCount
			lnv_NextRowsRange.Insert() 
		NEXT
		ll_ArrayCount = 0
		ll_RowRangecount = ll_NextRow + ll_SaveRowsCount - 1
		
		FOR ll_ndx = ll_NextRow TO ll_RowRangecount
			
			lnv_RowRange = lnv_RowsRange.item(ll_ndx)
			lnv_ColumnsRange = lnv_RowRange.Columns
			ll_ColumnCount = lnv_ColumnsRange.Count
			
			FOR ll_ndx2 = 1 to ll_ColumnCount
				
				ll_ArrayCount ++
				lnv_ColumnRange = lnv_ColumnsRange.item(ll_ndx2)
				lnv_ColumnRange.Value = lsa_Value[ll_ArrayCount]
								
			NEXT
			
		NEXT

	ELSE
		lnv_RowsRange = anv_TagRange
		ll_RowRangecount = lnv_RowsRange.count

	END IF	

	//	Get next beo for processing
	iaa_TopicSingleBeo [1] = iaa_TopicBeo [ ll_Count ]
	
	/***						 Processing						***/
	IF ll_count > 1 THEN
		lnv_NextRowsRange = lnv_RowsRange.item(ll_NextRow)
		THIS.of_ProcessExcelRowsRange(lnv_NextRowsRange, 1)
	ELSE
		THIS.of_ProcessExcelRowsRange(lnv_RowsRange, ll_RowRangecount)
	END IF
	
	//get row count for inserting next range
	ll_NextRow = lnv_RowsRange.Count + ll_Count
//	ll_NextRow = lnv_RowsRange.Count + 1


NEXT



end subroutine

private function integer of_populatewordtemplate (n_cst_msg anv_tagmessage);
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PopulateWordTemplate
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
//		Open word template, instantiate topic mapping object and get data to 
//		populate template. When creating the template tables must be used to 
//		group data eg. if items are to grouped by events then the event tags	
//		and item tags must be in the same table. This will make it easier to 
//		set up patterns of data. If tags are outside of a table then it will
//		be considered freeform and only one occurrence. 
//
//		Tables will be substituted first because these will determine patterns
//		and loops which will need to be done.  When searching a document range
//		for tags, the table tags are also found. The table tags need to be 
//		processed seperately. After table tags are replaced, all other tags will
//		be searched and replaced.  These should be single occurrences.  Any tag
//		that hasn't been replaced did not match a data field.
//
//						
//
// Written by: Norm LeBlanc
// 		Date: 9/11/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//		3/7/01	Using using word template object and tagdata object
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

string	lsa_Tags []

integer	li_Return = 1 
			 
long		ll_TopicCount, &
			ll_TagDataCount, &
			ll_Count1, &
			ll_Count2
			
oleobject	lnv_Object

boolean	lb_Retry = TRUE

datastore				lds_Values
n_cst_TagData			lnv_TagData[], &
							lnv_BlankTagData[]
n_cst_template_word	lnv_Word

lnv_Word = Create n_cst_template_word

oleobject	lnv_CharacterRange, &
				lnv_DocumentRange
long	ll_ndx, &
		ll_ndxmax
boolean lb_numbertags

//make sure topic matches data being requested on template
inv_document = inv_OleReport.Application.Documents.open(is_TemplateFileName,false,true)

IF isvalid(inv_document) THEN
	IF UpperBound ( iaa_topicbeo[] ) > 0 THEN
//		do while lb_Retry
			IF lnv_Word.of_FindTopicTag ( inv_document.Range.text, is_topic, is_delimiter) = 1 THEN
//				lb_Retry = FALSE
			ELSE
				DESTROY inv_OleReport
//				IF this.of_ConnectToObject ( is_templatefilename, is_TemplateType ) = 1 THEN
//					inv_document = inv_OleReport.Application.Documents.open(is_TemplateFileName,false,true)
//				ELSE
//					lb_Retry = FALSE
					li_Return = -1
//				END IF
			END IF
//		loop	
	END IF
	
ELSE
	li_Return = -1
END IF


ll_TopicCount = upperbound ( iaa_TopicBeo )

IF  li_Return = 1 THEN

//select template and cut
lnv_DocumentRange = inv_document.range
lnv_DocumentRange.Select()
lnv_DocumentRange.Cut()
ii_numberofchanges ++
// get last character of document 
lnv_CharacterRange = inv_document.Characters.last
lnv_CharacterRange.Paste()
ii_numberofchanges ++

	
	lnv_Word.of_SetDocument ( inv_document )
	lnv_Word.of_SetTopic ( is_Topic )
	
	IF UpperBound ( iaa_topicbeo[] ) = 0 THEN
		//look for custom tags
		ib_NoTopicBeo = TRUE
		iaa_TopicBeo[1] = 'NOTOPIC'
		ll_TopicCount = 1
	END IF
	
	
	FOR ll_Count1 = 1 to ll_TopicCount

		//loop thru process range for object array
		
		//test
		
		//	insert page break and paste template
		lnv_CharacterRange = inv_document.Characters.last	
		IF ll_Count1 > 1 THEN
			//If we have any number tags then no page break
			ll_NdxMax = upperbound ( lnv_TagData )
			FOR ll_Ndx = 1 to ll_NdxMax
				If lnv_TagData [ll_Ndx].of_IsNumberTag ( ) THEN
					lb_NumberTags = TRUE
					EXIT
				END IF
			NEXT
			IF not lb_NumberTags THEN
				lnv_CharacterRange.InsertBreak(2)
				lnv_CharacterRange.Paste()
				ii_numberofchanges ++
			END IF
		END IF
	
		//need to get new tagdata objects
		lnv_TagData = lnv_BlankTagData 
		lnv_Word.of_GetTemplateTags ( lnv_TagData )

		
		ll_TagDataCount = upperbound ( lnv_TagData )
	//
		FOR ll_Count2 = 1 to ll_TagDataCount

			//check for number tags
			IF lnv_TagData[ll_Count2].of_IsNumberTag ( ) THEN
				//Make sure number matches beo count
				IF lnv_TagData[ll_Count2].of_GetTagNumber ( )  = ll_Count1 THEN
					//STRIP NUMBER		
					lnv_TagData[ll_Count2].of_GetTags ( lsa_Tags ) 
					this.of_StripNumber ( lsa_Tags, ll_Count1 )
					lnv_TagData[ll_Count2].of_SetTags ( lsa_Tags ) 
				ELSE
					CONTINUE
				END IF
			END IF
			lnv_TagData[ll_Count2].of_GetTags ( lsa_Tags ) 
			lnv_Object = lnv_TagData[ll_Count2].of_GetObject ( ) 
			iaa_TopicSingleBeo [1] = iaa_TopicBeo [ ll_Count1 ]
			//lnv_object is no longer needed in this method
			lds_Values = THIS.of_ProcessRange ( lnv_Object, iaa_TopicSingleBeo, lsa_Tags )
			lnv_TagData[ll_Count2].of_SetValues ( lds_Values ) 
		
		NEXT
		
		//now that i am loading all of the topics ahead of time how do i
		//control paging in this method ?
		lnv_Word.of_ReplaceTemplateTags ( lnv_TagData, ll_Count1, anv_TagMessage) 
		
	NEXT
	
	ii_NumberOfChanges += lnv_Word.of_GetNumberOfChanges ( )
		
END IF

FOR ll_Count1 = 1 to ll_TagDataCount
	DESTROY lnv_TagData[ll_Count1]
NEXT

DESTROY lnv_Word

return li_Return
end function

private subroutine of_striptagbrackets (string asa_tags[], ref string asa_strippedtags[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_StripTagBrackets
//
//	Access:  private
//
//	Arguments:  asa_tags[]
//					asa_strippedtags[] by reference
//
// Returns:		
//
//
//	Description:	Loop tags and remove brackets. Pass back in other array.
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
////////////////////////////////////////////////////////////////////////////
long	ll_TagStartPos, &
		ll_TagEndPos, &
		ll_TagCount, &
		ll_Count
		
ll_TagCount = upperbound ( asa_tags )

FOR ll_Count = 1 TO ll_TagCount

	asa_strippedtags[ll_Count] = mid ( asa_tags[ll_Count], 2, len ( asa_tags[ll_Count] ) - 2  )
	
NEXT


end subroutine

private subroutine of_stripnumber (ref string asa_tag[], long al_number);string	lsa_Blank[], &
			lsa_Result[], &
			ls_NewTag, &
			lsa_StrippedTag[]
			
long	ll_Ndx, &
      ll_Ndx2, &
		ll_TagResultCount, &
		ll_TagArrayCount
		
n_cst_string	lnv_String

this.of_StripTagBrackets(asa_Tag, lsa_StrippedTag )
ll_TagArrayCount = upperbound ( lsa_StrippedTag )

FOR ll_Ndx = 1 to ll_TagArrayCount
	lsa_Result = lsa_Blank
	IF lnv_String.of_ParseToArray ( lsa_StrippedTag [ll_Ndx], is_Delimiter , lsa_Result ) > 0 THEN
		//rebuild tag and replace
		ll_TagResultCount = upperbound(lsa_Result) 
		ls_NewTag = "<" 
		
		FOR ll_Ndx2 = 2 to ll_TagResultCount
			ls_NewTag += lsa_Result[ll_Ndx2]
			IF ll_Ndx2 < ll_TagResultCount THEN ls_NewTag += is_Delimiter
		NEXT
		
		ls_NewTag += ">"
		asa_Tag[ll_Ndx] = ls_NewTag
	END IF
NEXT

end subroutine

public function integer of_test (n_cst_msg anv_tagmessage);integer	li_Return = 1 , &
			li_count, &
			li_ContextTagCnt

//string	ls_Tag, &
//			ls_TopicTag, &
//			ls_FirstAddress, &
//			ls_LastAddress, &
//			ls_Value
//			
oleObject	lnv_ApplicationRange
//				lnv_RowsRange, &
//				lnv_NextRange, &
//				lnv_TagRange
//				 
boolean		lb_Retry

//s_parm		lstr_Parm
n_cst_template_Excel	lnv_Excel

lnv_Excel = Create n_cst_template_Excel

inv_Workbook = inv_OleReport.Application.WorkBooks.open(is_TemplateFileName,false,true)
inv_Workbook.Application.Visible=TRUE
lnv_ApplicationRange = inv_Workbook.Application.Cells

IF lnv_Excel.of_SetLastAddress ( lnv_ApplicationRange, "<endtag>" ) = 1 THEN
	//	lnv_NextRange.Value = ""
ELSE
	li_Return = -1
END IF

// Check for topic tag and set delimiter type being used in tag
	//make sure topic matches data being requested on template
IF isvalid(inv_document) THEN
	do while lb_Retry
		IF lnv_Excel.of_FindTopicTag ( lnv_ApplicationRange, is_topic, is_delimiter) = 1 THEN
			lb_Retry = FALSE
		ELSE
			DESTROY inv_OleReport
			IF this.of_ConnectToObject ( is_templatefilename, is_TemplateType ) = 1 THEN
				inv_Workbook = inv_OleReport.Application.WorkBooks.open(is_TemplateFileName,false,true)
			ELSE
				lb_Retry = FALSE
				li_Return = -1
			END IF
		END IF
	loop	

END IF

IF li_Return = 1 THEN

	lnv_Excel.of_SetWorkBook ( inv_WorkBook )
	lnv_Excel.of_SetTopic ( is_Topic )
	
//
//	//	Remove topic tag
//	ls_TopicTag = "<USE" + is_Delimiter + upper ( is_topic )  + ">"
//	lnv_NextRange = lnv_ApplicationRange.Find(ls_TopicTag)
//	ls_FirstAddress = lnv_NextRange.Address
//	lnv_NextRange.Value = ""
//	
//	//PROCESS ANY CONTEXT TAGS PASSED IN THE TAGMESSAGE OBJECT
//	
//	//**	We may want to put this logic in the loop process to populate
//	//**	context tags in each occurrence of the topics.
//	IF isvalid ( anv_TagMessage ) THEN
//		
//		li_ContextTagCnt = anv_TagMessage.of_Get_Count ( )
//		
//		FOR li_Count = 1 to li_ContextTagCnt
//			
//			IF anv_TagMessage.of_Get_Parm ( li_Count, lstr_Parm ) <> 0 THEN
//				ls_Tag = lstr_Parm.is_Label
//				ls_Tag = "<" + ls_Tag + ">"
//				ls_Value = string ( lstr_Parm.ia_Value )
//				
//				lnv_NextRange = lnv_ApplicationRange.Find(ls_Tag)
//				IF isvalid ( lnv_NextRange ) THEN
//					lnv_NextRange.Value = ls_Value
//				END IF
//				
//			END IF
//			
//		NEXT
//
	END IF 
//				
//	lnv_ApplicationRange = inv_Workbook.Application.Range(ls_FirstAddress,ls_LastAddress)
//	lnv_RowsRange = lnv_ApplicationRange.Rows
//	lnv_TagRange = lnv_ApplicationRange.Rows
//
//	/// test logic for multiple topics
//	THIS.of_ProcessExcelTagRange(lnv_TagRange)
//	///end test logic
//	
////	THIS.of_ProcessExcelRowsRange(lnv_RowsRange)
//
//END IF

return li_Return


end function

public function long of_gettags (string as_text, ref string asa_Tags[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetTags
//
//	Access:  private
//
//	Arguments:  anv_rangetext
//					asa_tags[] by reference
//
// Returns:		long  -	number of tags
//
//
//	Description:	Loop through range argument for tags and add to tag array. 
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
string	ls_RangeText, &
			lsa_Blank[]
			
long	ll_TagStartPos, &
		ll_TagEndPos, &
		ll_TagCount
		
boolean	lb_GetTag = TRUE

ll_TagStartPos = 1 
asa_tags[] = lsa_Blank

DO WHILE lb_GetTag
	ll_TagStartPos = pos( as_Text, "<", ll_TagStartPos )
	IF ll_TagStartPos > 0 THEN
		ll_TagendPos = pos( as_Text, ">", ll_TagStartPos )
		IF ll_TagendPos > 0 THEN
			ll_TagCount ++
			asa_Tags [ ll_TagCount ] = mid ( as_Text, ll_TagStartPos, ( ll_TagendPos - ll_TagStartPos ) + 1 )
			ll_TagStartPos = ll_TagendPos
		END IF
	ELSE
		lb_GetTag = FALSE
	END IF
LOOP

return ll_TagCount
end function

private function datastore of_processrange (oleobject anv_range, any aaa_beo[], ref string asa_tags[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessRange
//
//	Access:  private
//
//	Arguments:  
//
// Returns:		datastore
//
//	Description:	
//
// Written by: Norm LeBlanc
// 		Date: 9/18/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
Any	laa_ObjectBeo []

long	ll_TagCount, &
		ll_TopicArrayCount, &
		ll_TopicArrayMax, &
		ll_ObjectArrayCount, &
		ll_ObjectArrayMax, &
		ll_Row, &
		ll_TagNdx, &
		ll_Count, &
		ll_Pos
		
string	lsa_StrippedTags[], &
			lsa_ConcatenatedTags[], &
			lsa_StrippedConcatenatedTags[], &
			ls_ConcatenatedTag, &
			ls_ConcatenatedValue, &
			lsa_Result[], &
			lsa_Blank [], &
			ls_ObjectTag, &
			ls_Value, &
			ls_Test
			
integer	li_RetVal, &
			li_Index

boolean	lb_ConcatenatedTag

datastore	lds_Values

n_cst_string	lnv_String

ll_TagCount = upperbound ( asa_Tags )

lds_Values = this.of_CreateDataStore ( asa_Tags )

IF isvalid ( lds_Values ) THEN

	ll_TopicArrayMax = upperbound ( aaa_Beo )
	
	FOR ll_TopicArrayCount = 1 to ll_TopicArrayMax
		
		of_StripTagBrackets ( asa_Tags , lsa_StrippedTags ) 
	
		FOR ll_TagNdx = 1 TO ll_TagCount

			IF ll_TagNdx = 1 THEN 		//	Row insertion is done during first tag
				ll_row = lds_Values.insertrow(0)
			END IF				

			lsa_Result = lsa_Blank
			ls_Value = ""  // <<*>> 2188

			IF lnv_String.of_ParseToArray ( lsa_StrippedTags [ll_TagNdx], is_Delimiter , lsa_Result ) > 0 THEN
				
				CHOOSE CASE  upperbound ( lsa_Result )
						
					CASE 0 
						//PROBLEM WITH TAG
						
					CASE 1   //Property
						
						/*
							The following logic (down to the end comment) appears 3 times in this script.
							It is not in a seperate object because of the overhead in autoinstantiated beos.
							If this logic changes, make sure the same change is made in the other 2 spots.
						*/
						IF ib_NoTopicBeo THEN
							li_RetVal = -1
						ELSE
							li_RetVal = aaa_beo[ll_TopicArrayCount].Dynamic of_GetValueString ( lsa_Result[1], ls_value )
						END IF
						
						CHOOSE CASE li_RetVal
							CASE -1, 0	//Check custom tags
								of_ProcessCustomTag ( lsa_StrippedTags [ll_TagNdx], ls_Value )
							CASE 1
								IF isnull( ls_Value ) THEN
									ls_Value = ""
								END IF
						END CHOOSE
						
						IF ib_PrepareForURL THEN
							ls_Value = lnv_String.of_PrepareforURL ( ls_Value )							
						END IF
						/*	end comment	*/
						
						lds_Values.object.data.primary[ll_row, ll_TagNdx] = ls_Value

					CASE ELSE	//Object.property
						//get object
						li_RetVal = aaa_beo[ll_TopicArrayCount].Dynamic of_GetObject ( lsa_Result [1], laa_ObjectBeo )
						
						ll_ObjectArrayMax = upperbound ( laa_ObjectBeo ) 
						
						IF ll_ObjectArrayMax = 0 THEN
							CHOOSE CASE li_RetVal
								CASE 0	//Check custom tags
									of_ProcessCustomTag ( lsa_StrippedTags [ll_TagNdx], ls_Value )
								CASE 1 
									ls_Value = ''
								CASE ELSE
									ls_Value = ''
							END CHOOSE							
							lds_Values.object.data.primary[1, ll_TagNdx] = ls_Value
						ELSE
							ls_ObjectTag = ''
							FOR ll_count = 2 to upperbound ( lsa_result )
								ls_ObjectTag += lsa_result [ll_count]
								if ll_Count <> upperbound ( lsa_result ) then ls_objecttag += is_Delimiter		
							NEXT		
							//check tag for braces to see if we are processing a concatenated list
							IF pos( ls_ObjectTag, "[", 1 ) > 0 THEN
								IF this.of_GetTags(ls_ObjectTag, lsa_ConcatenatedTags) > 0 THEN
									lsa_StrippedConcatenatedTags = lsa_Blank
									of_StripTagBrackets ( lsa_ConcatenatedTags , lsa_StrippedConcatenatedTags ) 
									lb_ConcatenatedTag = TRUE
								END IF
							ELSE
								lb_ConcatenatedTag = FALSE
							END IF

						END IF

						ls_ConcatenatedValue=''
							
						FOR  ll_ObjectArrayCount = 1 to ll_ObjectArrayMax
							//test
							//check tag for braces to see if we are processing a concatenated list
							IF lb_ConcatenatedTag THEN
								ls_ConcatenatedTag = ls_ObjectTag
								FOR ll_count = 1 to upperbound ( lsa_StrippedConcatenatedTags )
									
									/*	same as above	*/
									IF ib_NoTopicBeo THEN
										li_RetVal = -1
									ELSE
										li_RetVal = laa_ObjectBeo[ll_ObjectArrayCount].Dynamic of_GetValueString ( lsa_StrippedConcatenatedTags[ll_Count], ls_value )
									END IF
									
									CHOOSE CASE li_RetVal
										CASE -1	//Check custom tags
											of_ProcessCustomTag ( lsa_StrippedTags [ll_TagNdx], ls_Value )
										CASE 1
											IF isnull( ls_Value ) THEN
												ls_Value = ""
											END IF
									END CHOOSE
									
									IF ib_PrepareForURL THEN
										ls_Value = lnv_String.of_PrepareforURL ( ls_Value )							
									END IF								
									/*	send comment	*/
									
									//replace value
									ll_Pos = pos(ls_ConcatenatedTag,lsa_ConcatenatedTags[ll_Count],1)
									ls_ConcatenatedTag = Replace ( ls_ConcatenatedTag, ll_Pos, len(lsa_ConcatenatedTags[ll_Count]), ls_Value )
								NEXT			 
								ls_ConcatenatedTag = mid(ls_ConcatenatedTag,2,len(ls_ConcatenatedTag) - 2)
								ls_ConcatenatedValue +=ls_ConcatenatedTag
								lds_Values.object.data.primary[1, ll_TagNdx] = ls_ConcatenatedValue
							ELSE
								//no braces, regular tag
								/*	same as above	*/
								IF ib_NoTopicBeo THEN
									li_RetVal = -1
								ELSE
									li_RetVal = laa_ObjectBeo[ll_ObjectArrayCount].Dynamic of_GetValueString ( ls_ObjectTag, ls_value )
								END IF
								
								CHOOSE CASE li_RetVal
									CASE -1	//Check custom tags
										of_ProcessCustomTag ( lsa_StrippedTags [ll_TagNdx], ls_Value )
									CASE 1
										IF isnull( ls_Value ) THEN
											ls_Value = ""
										END IF
								END CHOOSE
								
								IF ib_PrepareForURL THEN
									ls_Value = lnv_String.of_PrepareforURL ( ls_Value )							
								END IF								
								/*	end comment	*/
								
								lds_Values.object.data.primary[ll_ObjectArrayCount, ll_TagNdx] = ls_Value	
							
							END IF
							
							//end test								
												
						NEXT

						FOR li_Index = 1 TO upperbound(laa_ObjectBeo)
							DESTROY laa_ObjectBeo[li_index]
						NEXT
						
				END CHOOSE
				
			END IF
			
		NEXT
		
	NEXT
		
END IF
	
return lds_Values

end function

private subroutine of_converttablestotext ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConvertTablestoText
//
//	Access:  private
//
//	Description:	Loop through tables in the document and covert to text with tabs
//						
//
// Written by: Norm LeBlanc
// 		Date: 2/14/03
//		Version: 3.6.00
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

long		ll_TableCount, &
			ll_TableNdx
			
			
oleObject	lnv_DocumentRange, &
				lnv_NextTable

lnv_DocumentRange = inv_document.Range(inv_document.Range.Start, inv_document.Range.End)

ll_TableCount = lnv_DocumentRange.Tables.Count
			
/*	Loop through all tables by incrementing argument 	*/
FOR ll_TableNdx = 1 TO ll_TableCount

	lnv_NextTable = lnv_DocumentRange.Tables.Item(ll_TableNdx)
	
//	lnv_NextTable.ConvertToText (0)	//seperate lines
	lnv_NextTable.ConvertToText (1)	//tabs
//	lnv_NextTable.ConvertToText (2)  //comma
//	lnv_NextTable.ConvertToText (3)	//other
	ib_convertedtabletotext = true
	ii_numberofchanges ++
	ii_numberofchanges ++

			
NEXT

end subroutine

public function integer of_processgenerictaglist (any aa_beosource, string asa_tags[], ref any aaa_data[]);oleobject	lnv_NotUsed
DataStore	lds_Results
Int			li_TagCount
Int			i
Int			li_Return
Long			ll_RowCount
Any			laa_Data[]
Any			laa_Source[]

laa_Source [1] = aa_beosource

lds_Results = THIS.of_Processrange( lnv_NotUsed , laa_Source, asa_tags[] )

li_TagCount = UpperBound ( asa_tags[] )

IF IsValid ( lds_Results ) THEN
	ll_RowCount = lds_Results.Rowcount( )
	IF ll_RowCount > 0 THEN
		FOR i = 1 TO li_TagCount
			laa_Data[i] = lds_Results.GetItemString( 1, i )
		NEXT
		aaa_data[] = laa_Data
		li_Return = UpperBound ( aaa_data[] )
	END IF
END IF

DESTROY ( lds_Results )

RETURN li_Return
end function

public function integer of_processstring (string as_input, ref string as_output, any aa_beosource, n_cst_msg anv_tagmessage);any		laa_source

integer	li_return=1, &
			li_TagCount, &
			li_TagNdx
			
long		ll_pos, &
			ll_row, &
			ll_RowCount

string	ls_Replace, &
			lsa_Tag[]
			
datastore		lds_Values
n_cst_Template	lnv_String
oleobject		lnv_NotUsed
s_parm			lstr_Parm

IF isvalid ( anv_TagMessage )  THEN

	inv_TagMessage = anv_TagMessage

	IF anv_TagMessage.of_Get_Parm ( "URL" , lstr_Parm ) <> 0 THEN
		ib_PrepareforURL = TRUE
	END IF

END IF

laa_Source  = aa_beosource

as_output = as_input

lnv_String = create n_cst_Template

li_TagCount = lnv_String.of_GetTags(as_input, lsa_Tag)

if li_TagCount > 0 then
	lds_Values = THIS.of_Processrange( lnv_NotUsed , laa_Source, lsa_tag[] )
	ll_RowCount = lds_Values.RowCount()
else
	li_Return = 0
end if

if li_Return = 1 then
	FOR ll_Row = 1 TO ll_RowCount
		FOR li_TagNdx = 1 TO li_TagCount
			ls_Replace = lds_values.object.data.primary[ll_row, li_TagNdx]
			ll_pos = pos(as_output, lsa_tag[li_TagNdx])
			as_output = Replace ( as_output, ll_Pos, len(lsa_Tag[li_TagNdx]), ls_Replace )
		NEXT
	NEXT
end if	

Destroy lnv_String

return li_Return

end function

public subroutine of_setdelimiter (string as_delimiter);is_delimiter = as_delimiter
end subroutine

public function string of_getdelimiter ();return is_delimiter
end function

private function datastore of_processrange (ref string asa_tags[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ProcessRange
//
//	Access:  private
//
//	Arguments:  
//
// Returns:		datastore
//
//	Description:	overload, use when there is no beo
//
// Written by: Norm LeBlanc
// 		Date: 4/21/04
//		Version: 3.9.00
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////
long	ll_TagCount, &
		ll_TagNdx, &
		ll_row
		
string	lsa_StrippedTags[], &
			ls_Value
			
datastore	lds_Values

n_cst_string	lnv_String

ll_TagCount = upperbound ( asa_Tags )

lds_Values = this.of_CreateDataStore ( asa_Tags )

IF isvalid ( lds_Values ) THEN

	of_StripTagBrackets ( asa_Tags , lsa_StrippedTags ) 

	FOR ll_TagNdx = 1 TO ll_TagCount

		IF ll_TagNdx = 1 THEN 		//	Row insertion is done during first tag
			ll_row = lds_Values.insertrow(0)
		END IF				

		of_ProcessCustomTag ( lsa_StrippedTags [ll_TagNdx], ls_Value )
		
		IF ib_PrepareForURL THEN
			ls_Value = lnv_String.of_PrepareforURL ( ls_Value )							
		END IF
		
		lds_Values.object.data.primary[ll_row, ll_TagNdx] = ls_Value

		
	NEXT
		
END IF
	
return lds_Values

end function

public function integer of_processstring (string as_input, ref string as_output, n_cst_msg anv_tagmessage);integer	li_return=1, &
			li_TagCount, &
			li_TagNdx
			
long		ll_pos, &
			ll_row, &
			ll_RowCount

string	ls_Replace, &
			lsa_Tag[], &
			ls_value, &
			lsa_StrippedTags[]
			
datastore		lds_Values
n_cst_Template	lnv_String
oleobject		lnv_NotUsed
s_parm			lstr_Parm

IF isvalid ( anv_TagMessage )  THEN

	inv_TagMessage = anv_TagMessage

	IF anv_TagMessage.of_Get_Parm ( "URL" , lstr_Parm ) <> 0 THEN
		ib_PrepareforURL = TRUE
	END IF

END IF

as_output = as_input

lnv_String = create n_cst_Template

li_TagCount = lnv_String.of_GetTags(as_input, lsa_Tag)

if li_TagCount > 0 then
	lds_Values = THIS.of_Processrange( lsa_tag )
	ll_RowCount = lds_Values.RowCount()
else
	li_Return = 0
end if

if li_Return = 1 then
	FOR ll_Row = 1 TO ll_RowCount
		FOR li_TagNdx = 1 TO li_TagCount
			ls_Replace = lds_values.object.data.primary[ll_row, li_TagNdx]
			ll_pos = pos(as_output, lsa_tag[li_TagNdx])
			as_output = Replace ( as_output, ll_Pos, len(lsa_Tag[li_TagNdx]), ls_Replace )
		NEXT
	NEXT
end if	

Destroy lnv_String

return li_Return


end function

public function integer of_process_report_request (string as_file);/***************************************************************************************
NAME: 			of_process_report_request

ACCESS:			public
		
ARGUMENTS: 		
							as_file: 	the path of the file you want to be opened.

RETURNS:			1 if as_file is valid, -1 otherwise
	
DESCRIPTION:	The following opens up a report in thew_psr_viewer.
	


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : Created By Dan	11-22-05
	

***************************************************************************************/n_Cst_msg	lnv_Msg
s_Parm	lstr_Parm
int		li_return

IF as_file > "" THEN
	lstr_Parm.is_label = "FILENAME"
	lstr_Parm.ia_value = as_File
	lnv_Msg.of_Add_parm( lstr_Parm )
	
	w_psr_viewer	lw_Report
	openSheetWithPArm ( lw_Report , lnv_Msg, gnv_app.of_GetFrame( )  )
	
	
	IF isValid(lw_report) THEN
		lw_report.setFocus()
	END IF
	
	li_return = 1
ELSE
	li_return = -1
END IF
return li_return

end function

public function integer of_processcustomtag (string as_tag, ref string as_value);Integer	li_Return
Integer 	li_Pos
String	ls_StrippedTag
String	ls_Value
s_Parm	lstr_Parm	

pt_n_cst_beo  beo

ls_StrippedTag = as_Tag
//Remove Range data
li_Pos =  Pos(as_Tag, ";")
IF li_Pos > 0 THEN
	ls_StrippedTag = Left(as_Tag, li_Pos - 1)
END IF

IF inv_TagMessage.of_Get_Parm ( ls_StrippedTag , lstr_Parm ) <> 0 THEN
	ls_Value = lstr_Parm.ia_Value
	
	IF li_Pos > 0 THEN
		beo = Create pt_n_cst_beo
		//Pass in the value to the beo to check for further formatting (i.e Range)
		beo.of_GetValueString ( as_Tag , ls_Value)
		Destroy beo
	END IF
	
	as_value = ls_Value
	li_Return = 1
	
ELSE
	li_Return = -1
	as_value = ''
END IF

Return li_Return
end function

on n_cst_bso_reportmanager.create
call super::create
end on

on n_cst_bso_reportmanager.destroy
call super::destroy
end on

event destructor;call super::destructor;
IF isvalid ( inv_OleReport ) THEN
	inv_OleReport.DisconnectObject()
END IF
				
destroy ( inv_OleReport )

end event

