$PBExportHeader$u_cst_documentselect.sru
$PBExportComments$[u_Base] displays document type list and documents
forward
global type u_cst_documentselect from u_base
end type
type dw_types from u_dw_documenttypelist within u_cst_documentselect
end type
type dw_list from u_dw_documentlist within u_cst_documentselect
end type
type cbx_checkall from u_cbx within u_cst_documentselect
end type
type gb_documenttypes from u_gb within u_cst_documentselect
end type
type gb_documentsonfile from u_gb within u_cst_documentselect
end type
type cb_print from u_cb within u_cst_documentselect
end type
type cb_email from u_cb within u_cst_documentselect
end type
type cb_refresh from u_cb within u_cst_documentselect
end type
end forward

global type u_cst_documentselect from u_base
int Width=1783
int Height=2316
event ue_dwlistfilter ( )
event ue_documentclicked ( )
dw_types dw_types
dw_list dw_list
cbx_checkall cbx_checkall
gb_documenttypes gb_documenttypes
gb_documentsonfile gb_documentsonfile
cb_print cb_print
cb_email cb_email
cb_refresh cb_refresh
end type
global u_cst_documentselect u_cst_documentselect

type variables

Private:
String 		isa_FileContents[]
String		is_FilePath
String		is_FileName
Long		il_Shipmentid[]
Integer		ii_Success = 1
Integer		ii_Fail = -1
Boolean		ib_LoadCompleted = FALSE

end variables

forward prototypes
private function integer of_populatedoclist (n_cst_document anv_doc[])
public function integer of_retrievedocs (n_cst_msg anv_msg)
public function string of_getfilepath ()
protected function integer of_setfilepath (string as_FilePath)
private function integer of_setfilename (string as_filename)
public function string of_getfileName ()
public function integer of_printdocument ()
public function integer of_emaildocument ()
private function integer of_retrievetextcontents ()
public function integer of_parseheaderdetails (ref n_cst_emailmessage anv_emailmessage, string as_contents)
private function integer of_retrievedocs ()
public subroutine of_setfocus (string as_Object)
end prototypes

event ue_dwlistfilter;//
/***************************************************************************************
NAME			: ue_DwListFilter
ACCESS		: private
ARGUMENTS	: none
RETURNS		: integer
DESCRIPTION	: 

REVISION		: RDT 092602
***************************************************************************************/

Setpointer(HourGlass!)

String 	ls_Filter = ''

Long		ll_RowCount, &
			ll_Counter

ll_RowCount = dw_types.RowCount()

For ll_Counter = 1 to ll_RowCount 
	If dw_types.GetItemString(ll_Counter, "typechecked")='y' Then 
		if ls_filter = '' Then 
			ls_Filter = "documenttype = " + "'" + dw_types.GetItemString(ll_Counter, "type") + "'"
		else
			ls_Filter = ls_Filter + " or documenttype = " + "'" + dw_types.GetItemString(ll_Counter, "type") + "'"
		end if
		
	End If
Next

If ls_Filter = '' then 
	ls_filter = "documenttype = " + "''"
End IF

dw_list.SetRedraw(FALSE)
dw_list.SetFilter(ls_filter)
dw_list.Filter()
dw_list.SetRedraw(TRUE)

ib_LoadCompleted = TRUE

If dw_list.RowCount() > 0 then 
	dw_list.SelectRow( 0, False )
	dw_list.SelectRow( 1, True )
	dw_list.ScrollToRow( 1 )
	dw_list.TriggerEvent("RowFocusChanged")
End if 




end event

private function integer of_populatedoclist (n_cst_document anv_doc[]);//
/***************************************************************************************
NAME			: of_PopulateDocList
ACCESS		: Private
ARGUMENTS	: n_cst_Document	(anv_Doc[])
RETURNS		: Integer 			(Number of rows)
DESCRIPTION	: Populates the Document List from the array of documents passed in 

REVISION		: RDT 092602
***************************************************************************************/
long 	ll_CurrRow
int 	il_ArrayCount, il_Count

dw_list.SetRedraw(FALSE)

il_ArrayCount = UpperBound( anv_Doc[] ) 

If il_ArrayCount > 0 Then 
	For il_Count  = 1 to il_ArrayCount
		ll_CurrRow = dw_list.InsertRow(0)
		dw_list.SetItem(ll_CurrRow, "ShipmentId", anv_doc[il_Count].of_GetShipmentId( ) )
		dw_list.SetItem(ll_CurrRow, "FileName", anv_doc[il_Count].of_GetFileName( ) )
		dw_list.SetItem(ll_CurrRow, "DocumentType", anv_doc[il_Count].of_GetDocumentType( ) )
		dw_list.SetItem(ll_CurrRow, "PathFileName", anv_doc[il_Count].of_GetPathFileName( ) )
		dw_list.SetItem(ll_CurrRow, "FileDateTime", anv_doc[il_Count].of_GetFileDateTime( ) )
	Next
End If

dw_list.Sort()
dw_list.SetRedraw(TRUE)

Return il_ArrayCount
end function

public function integer of_retrievedocs (n_cst_msg anv_msg);//
/***************************************************************************************
NAME			: of_RetrieveDocs
ACCESS		: Public
ARGUMENTS	: none	
RETURNS		: integer	(Number of documents retrieved)
DESCRIPTION	: Loop thru dw_types and retrieve all documents that are checked. 
				  Shipment Id's are passed as an array in the message object.
REVISION		: RDT 092602
***************************************************************************************/
Integer 	li_DW_Counter, &
			li_MSG_Counter, &
			li_MsgCount, &
			li_Return 

Long		ll_RowCount, &
			ll_CurRow

String	ls_DocType

SetPointer(HourGlass!)

ib_LoadCompleted = FALSE 			// set so Row Focus will not show details as the dw is loaded
dw_list.Reset ( )

s_Parm	lstr_parm
li_MsgCount = anv_Msg.of_Get_Count ( )

ll_RowCount = dw_Types.RowCount ( )


If ll_RowCount > 0 Then 
	li_return = ii_success
End IF

If li_return = ii_success Then 
	n_cst_document lnv_doc[]
	n_cst_document lnv_Blank_Doc[]
	n_cst_bso_Document_Manager lnv_DocMan
	lnv_docMan = Create n_cst_bso_Document_Manager 								// create document manager

	IF anv_msg.of_Get_parm ( "SHIPMENTID", lstr_Parm) <> 0 THEN
		il_shipmentid[] = lstr_Parm.ia_Value 
	END IF

	For li_DW_Counter = 1 to ll_RowCount 
	
		ls_DocType = 	dw_Types.GetItemString ( li_DW_Counter, "type" )		// get Doc type 

		For li_MSG_Counter = 1 to UpperBound( il_shipmentid[] )
			If lnv_docMan.of_RetrieveDocuments ( il_shipmentid[li_MSG_Counter], ls_DocType , lnv_doc ) = 1 then 
				
				If UpperBound( lnv_doc[] ) > 0 Then 
					This.of_PopulateDocList( lnv_doc )								
					lnv_doc[] = lnv_Blank_Doc[]
				End IF
				
			End IF
			
		Next
	
	Next
	
	Destroy ( lnv_docMan ) 																// Destroy document manager
	
End If

dw_List.SelectRow(0, FALSE)	// unselect all rows

ib_LoadCompleted = TRUE 		// set so rowfocus will show details.

If dw_List.RowCount() > 0 Then 
	dw_List.SelectRow(1, TRUE)	   // select first row and show document
	dw_List.SetRow(1) 
	dw_List.TriggerEvent("rowfocuschanged")
End If

Return li_Return 


end function

public function string of_getfilepath ();//
/***************************************************************************************
NAME			: of_GetFilePath
ACCESS		: Public
ARGUMENTS	: none
RETURNS		: String	(is_filepath) 
DESCRIPTION	: Returns file name and Full path to file.

REVISION		: RDT 092602
***************************************************************************************/

Return is_FilePath 
end function

protected function integer of_setfilepath (string as_FilePath);// 
is_filepath = as_FilePath
Return 1
end function

private function integer of_setfilename (string as_filename);//
/***************************************************************************************
NAME			: of_SetFileName
ACCESS		: Private
ARGUMENTS	: String		(File name)
RETURNS		: Integer
DESCRIPTION	: Set an instance variable to the file name passed in 

REVISION		: RDT 092602
***************************************************************************************/

is_FileName = as_filename

Return 1
end function

public function string of_getfileName ();//
/***************************************************************************************
NAME			: of_GetFileName
ACCESS		: Public
ARGUMENTS	: none
RETURNS		: String	(is_fileName) 
DESCRIPTION	: Returns file name only

REVISION		: RDT 092602
***************************************************************************************/

Return is_FileName
end function

public function integer of_printdocument ();//
/***************************************************************************************
NAME			: of_PrintDocument
ACCESS		: Private
ARGUMENTS	: None
RETURNS		: Integer	(1=Success, -1=Fail)
DESCRIPTION	: um, it prints the selected document

REVISION		: RDT 092602
***************************************************************************************/
long 		li_prt, &
			li_Counter, &
			li_PrintReturn, &
			li_Return 
			
String 	ls_FileContents

li_return = 1

SetPointer(HourGlass!)

If Len( Trim( is_filename ) ) > 0 Then 

	If Upper( Right( Trim (is_filename), 3 ) ) = "TXT" Then 
		li_prt = PrintOpen(is_FileName)
		Print(li_prt, is_FileName)
		Print(li_prt, " ")
		For li_Counter = 1 to UpperBound( isa_filecontents[] )
			ls_FileContents += isa_filecontents[li_Counter]
		Next
		
		li_PrintReturn = Print(li_prt, ls_fileContents)
		If li_PrintReturn = -1 Then 
			MessageBox("Document Print","Error Printing document. Please check printer connections and setup.")
			li_Return = -1
		End If
		
		PrintClose(li_prt)
	Else
	// image print here.
	MessageBox("u_cst_DocumentSelect.of_PrintDocument() ","Program not coded to print Images.")
	
	End If
Else 
	MessageBox("Document Print","No Document was selected. Please select a document to print.")
End If 


Return li_Return

end function

public function integer of_emaildocument ();//
/***************************************************************************************
NAME			: of_EmailDocument
ACCESS		: Private
ARGUMENTS	: none
RETURNS		: integer 	(1= success, -1=fail)
DESCRIPTION	: Emails document. This doesn't recreate the document from the beo. 
				  WYSIWYG in the email message.

REVISION		: RDT 092602
***************************************************************************************/

Integer	li_Return, &
			li_Counter
String 	ls_Line, &
			ls_ParsedData, &
			ls_Body 


n_cst_EmailMessage lnv_EmailMessage												// n_cst_EmailMessage = autoinstantiate
n_cst_String lnv_String

For li_Counter = 1 to UpperBound( isa_filecontents[] )					// loop thru file contents
	If li_Counter = 1 then 
		this.of_ParseHeaderDetails(lnv_EmailMessage, isa_filecontents[li_Counter])
	end If
	ls_line = isa_filecontents[ li_Counter ] 
	// Add line to body.
	ls_Body += ls_line
Next

lnv_EmailMessage.of_SetShipmentID( dw_list.GetItemNumber( dw_list.GetRow() ,"shipmentid") )		//set shipment id 
lnv_EmailMessage.of_SetDocumentType( dw_list.GetItemString( dw_list.GetRow() ,"DocumentType") )	//set Document Type
lnv_EmailMessage.of_setbody ( ls_Body )																			// set body
lnv_EmailMessage.of_IsEmail ( True )

If Len( ls_Body ) > 20 Then 
	n_cst_bso_email_manager lnv_Email_Manager
	lnv_Email_Manager = create n_cst_bso_email_manager
	
	n_cst_bso_document_manager lnv_DocumentMan 
	lnv_DocumentMan = Create n_cst_bso_document_manager 

	li_Return = lnv_Email_Manager.of_SendMail ( lnv_EmailMessage )    // send email
	If li_Return = 1 then 																			  
		lnv_DocumentMan.Of_SaveDocumentCopy( lnv_EmailMessage, is_filepath ) 				// Save w/document manager
		
	Else
		MessageBox("Program Error","Error Sending Email message.")
		li_Return = -1
	End If
Else
	MessageBox("Program Error","File contents are empty. Message not sent.")
	li_Return = -1
End If

Return li_Return 
end function

private function integer of_retrievetextcontents ();//
/***************************************************************************************
NAME			: of_RetrieveTextContents
ACCESS		: Private
ARGUMENTS	: String		(Filename with full path)
RETURNS		: Integer	Number of items in array
DESCRIPTION	: Retrieve the Text file contents into isa_FileContents[]
					
					Note lnv_FileSrv.of_FileRead returns and array of strings only IF the file is larger than 
					32K (32,765 byes to be exact). Otherwise it will return 1 item in the array which contains 
					the file contents.
					
REVISION		: RDT 092602
***************************************************************************************/

Integer	li_Return, & 
			li_Result

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)				// Create file service

li_Result = lnv_FileSrv.of_FileRead ( this.of_getfilepath ( ), isa_filecontents ) // read file in instance array

li_Return = li_Result 

f_SetFileSrv(lnv_FileSrv, FALSE )			// Destroy file service

Return li_Return 

end function

public function integer of_parseheaderdetails (ref n_cst_emailmessage anv_emailmessage, string as_contents);//
/***************************************************************************************
NAME			: of_ParseHeaderDetails
ACCESS		: Private
ARGUMENTS	: n_cst_Document	
RETURNS		: Integer	(1=Success, -1=fail)
DESCRIPTION	: Parses the string and looks for header information for email
				  Looks for all "TO:" lines and only the first "Subject:" line.

REVISION		: RDT 092602
***************************************************************************************/
String	ls_Delimiter, &
			ls_Line[], &
			ls_ParsedData 

Integer	li_Counter, &
			li_ArrayCount

ls_Delimiter = "~r~n"

n_cst_String lnv_String			// Create string service (Autoinstantiated)

li_ArrayCount = lnv_String.of_ParseToArray( as_Contents , ls_Delimiter , ls_Line[])

For li_Counter = 1 to li_ArrayCount 

	If pos(ls_line[ li_Counter ], "To: ") > 0 Then 														// this is an address line
		ls_ParsedData = mid(ls_line[ li_Counter ], pos(ls_line[ li_Counter ], "To: ") + Len("To: ") ) 
		anv_EmailMessage.of_AddTargetAddress ( ls_ParsedData )										// add address to document
	End if
	
	If Len( Trim( anv_EmailMessage.of_GetSubject ( ) ) ) < 1 Then 								// if empty then fill else skip
		if pos(ls_line[ li_Counter ], "Subject: ") > 0 Then 										// this is an Subject line
			ls_ParsedData = mid(ls_line[ li_Counter ], pos(ls_line[ li_Counter ], "Subject: ") + Len("Subject: ") ) 	
			anv_EmailMessage.of_SetSubject ( ls_ParsedData + " - COPY -")					// Set subject on document
		end if	
	End If

Next

Return 1




end function

private function integer of_retrievedocs ();//
/***************************************************************************************
NAME			: of_RetrieveDocs()  Overloads of_RetrieveDocs(n_cst_msg) 
ACCESS		: Private
ARGUMENTS	: none
RETURNS		: Integer		(1=Success, -1=Fail)
DESCRIPTION	: Used to refresh document list

REVISION		: RDT 092602
***************************************************************************************/

Long 		lla_parm[], &
	 		lla_parm1, &
			ll_Bound
Integer 	li_counter, &
			li_Return 


s_parm		lstr_parm
n_cst_msg	lnv_msg

ll_Bound = UpperBound(il_shipmentid[])

If ll_Bound > 0 Then 

	For li_counter = 1 to ll_Bound 
	// populate message object with shipment id's
		lstr_Parm.is_Label = "SHIPMENTID"
		lstr_Parm.ia_Value = il_shipmentid[ ]
		lnv_Msg.of_Add_Parm ( lstr_Parm )
	Next

	li_Return = this.of_RetrieveDocs(lnv_msg)

Else
	MessageBox("Retrieve Failed","No Shipment ID's to retrieve.")
	li_Return = -1
End IF

Return li_Return 


end function

public subroutine of_setfocus (string as_Object);

Choose Case Upper( as_Object )
	Case "LIST"
		dw_list.SetFocus()
	Case Else
		cbx_checkall.SetFocus()
End Choose


end subroutine

on u_cst_documentselect.create
int iCurrent
call super::create
this.dw_types=create dw_types
this.dw_list=create dw_list
this.cbx_checkall=create cbx_checkall
this.gb_documenttypes=create gb_documenttypes
this.gb_documentsonfile=create gb_documentsonfile
this.cb_print=create cb_print
this.cb_email=create cb_email
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_types
this.Control[iCurrent+2]=this.dw_list
this.Control[iCurrent+3]=this.cbx_checkall
this.Control[iCurrent+4]=this.gb_documenttypes
this.Control[iCurrent+5]=this.gb_documentsonfile
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_email
this.Control[iCurrent+8]=this.cb_refresh
end on

on u_cst_documentselect.destroy
call super::destroy
destroy(this.dw_types)
destroy(this.dw_list)
destroy(this.cbx_checkall)
destroy(this.gb_documenttypes)
destroy(this.gb_documentsonfile)
destroy(this.cb_print)
destroy(this.cb_email)
destroy(this.cb_refresh)
end on

event constructor;call super::constructor;
dw_types.of_RetrieveDocumentTypes ( )
dw_Types.of_SetAllRowsChecked()

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Register Resizable controls
inv_Resize.of_Register ( cb_email, 'Scale')
inv_Resize.of_Register ( cb_print, 'Scale')
inv_Resize.of_Register ( cb_refresh, 'Scale')
inv_Resize.of_Register ( cbx_checkall, 'Scale')
inv_Resize.of_Register ( dw_list, 'Scale')
inv_Resize.of_Register ( dw_types, 'Scale')
inv_Resize.of_Register ( gb_documentsonfile, 'Scale')
inv_Resize.of_Register ( gb_documenttypes, 'Scale')
	

// set row selection on List datawindow
dw_list.of_SetRowSelect ( TRUE ) 
dw_list.inv_rowselect.of_SetStyle ( 0 ) 



end event

type dw_types from u_dw_documenttypelist within u_cst_documentselect
int X=41
int Y=136
int Width=1659
int Height=780
int TabOrder=10
boolean BringToTop=true
end type

event itemchanged;call super::itemchanged;// set the filter on the list window.
parent.PostEvent("ue_dwListFilter")
end event

type dw_list from u_dw_documentlist within u_cst_documentselect
int X=41
int Y=1004
int Width=1659
int Height=1036
int TabOrder=70
boolean BringToTop=true
boolean HScrollBar=true
end type

event rowfocuschanged;call super::rowfocuschanged;
// Get the file contents and show in mle

Long 		ll_return = -1
Long		ll_Row

If ib_LoadCompleted Then 
	ll_Row = This.GetRow() 
	If ll_Row > 0 Then

		Parent.of_SetFilePath (This.GetItemString( ll_Row , "PathFileName" ) )
		Parent.of_SetFileName (This.GetItemString( ll_Row , "FileName" ) )
		Parent.of_RetrieveTextContents( )
		Parent.Post Event ue_documentclicked()
		ll_return = 1

		Choose Case This.GetItemString( ll_Row , "documenttype" ) 

			Case appeon_constant.cs_acc, &
				  appeon_constant.cs_event, &
				  appeon_constant.cs_authout

					cb_email.Enabled = TRUE

			Case Else
					cb_email.Enabled = FALSE
				
		End Choose
	
	End IF
End IF

Return ll_return 


end event

event clicked;call super::clicked;This.TriggerEvent("RowFocusChanged")
end event

type cbx_checkall from u_cbx within u_cst_documentselect
int X=46
int Y=68
int Width=357
boolean BringToTop=true
string Text="Check All"
boolean Checked=true
end type

event clicked;
If this.checked = TRUE Then 
	dw_Types.of_SetAllRowsChecked ( )

Else
	ib_LoadCompleted = False
	dw_Types.of_SetAllRowsUnChecked ( )

End If

parent.PostEvent("ue_dwListFilter")

end event

type gb_documenttypes from u_gb within u_cst_documentselect
int X=14
int Y=0
int Width=1737
int Height=936
int TabOrder=50
string Text="Document &Types"
end type

type gb_documentsonfile from u_gb within u_cst_documentselect
int X=14
int Y=940
int Width=1737
int Height=1124
int TabOrder=60
string Text="Documents on &File"
end type

type cb_print from u_cb within u_cst_documentselect
int X=626
int Y=2088
int Width=485
int TabOrder=20
boolean BringToTop=true
string Text="&Print"
end type

event clicked;If dw_list.GetSelectedRow(0) > 0 Then 
	Parent.of_PrintDocument()
Else
	MessageBox("Document Print error","No Document was selected. Please select a document first.")
End if

end event

type cb_email from u_cb within u_cst_documentselect
int X=1207
int Y=2088
int Width=485
int TabOrder=30
boolean BringToTop=true
string Text="Resend &Email"
end type

event clicked;
String	ls_DocType, &
			ls_ShipmentID
			
Long 		ll_Row
If dw_list.GetSelectedRow(0) > 0 Then 
	// get file type and date to display
	ll_Row = dw_list.GetRow()
	ls_DocType 		= dw_list.GetItemString(ll_Row, "documenttype")
	ls_ShipmentID	= String( dw_list.GetItemNumber(ll_Row, "shipmentid") )
	
	If messageBox("Document Display. Please Confirm","Resend the "+ls_DocType+" for " + ls_ShipmentID +" document via Email?",Question!,YesNo!, 2) = 1 then 
		Parent.of_EmailDocument( )
	End If
Else
	MessageBox("Document Email error","No Document was selected. Please select a document first.")
End if
end event

type cb_refresh from u_cb within u_cst_documentselect
int X=46
int Y=2088
int Width=485
int TabOrder=40
boolean BringToTop=true
string Text="&Refresh"
end type

event clicked;Parent.of_RetrieveDocs( )
cbx_checkall.Checked = TRUE
dw_Types.of_SetAllRowsChecked()
end event

