$PBExportHeader$n_cst_bso_document_manager.sru
$PBExportComments$[n_cst_bso] manages save and retrevial of  documents
forward
global type n_cst_bso_document_manager from n_cst_bso
end type
end forward

global type n_cst_bso_document_manager from n_cst_bso
end type
global n_cst_bso_document_manager n_cst_bso_document_manager

type variables
Constant Integer 	ci_Success  =  1
Constant Integer 	ci_Failure     = -1
Constant	Int		ci_NoAction = 0
CONSTANT STRING	cs_TransferMethod_FTP = "FTP"
CONSTANT STRING	cs_TransferMethod_Email = "EMAIL"


String		is_DocumentType
String		is_Catagory = "UNSECURE"
String		is_Topic = "SHIPMENT"
n_cst_document      inv_Document[]
pt_n_cst_beo 	inv_beo


// Note: These are also used to name subdirectories
Constant String	cs_Event         = "EVENTCONFIRM"
Constant String	cs_ACC           = "ACCESSORIAL"
Constant String	cs_AUTHIN     = "AUTHORIZEIN"
Constant String	cs_AUTHACCEPT  = "AUTHORIZEACCEPT"
Constant String	cs_AUTHDENY     = "AUTHORIZEDENY"
Constant String	cs_AUTHOUT = "AUTHORIZEOUT"
Constant String	cs_TIR	        = "TIRNOTIFICATION"
Constant String	cs_LFD 	        = "LFD"
Constant String	cs_SHIPSTAT = "STATUSREQUEST"
Constant String	cs_LoadConfirmation = "LOADCONFIRMATION"



PRIVATE:
datastore	ids_DocumentQueue
DataStore	ids_DocumentHistory

Boolean		ib_QueueReady = FALSE
end variables

forward prototypes
private function string of_getrootdir ()
private function string of_stripcharacters (string as_inputstring, string as_badcharacters)
private function string of_getcatagory ()
private function string of_gettopic ()
private function string of_calculatefilename (string as_codename)
private function string of_addprefix (string as_filename)
private function string of_emailsetbody (n_cst_document anv_document)
public function integer of_savedocument (n_cst_document anv_document)
private function integer of_retrievefilenames (long al_shipid, ref n_cst_document anv_document)
private function integer of_populatedocument (long al_shipid, string as_filespec)
public function integer of_retrievedocuments (unsignedlong al_shipid, string as_documenttype, ref n_cst_document anv_document[])
public function integer of_gettypelist (ref string as_type[])
public function integer of_missingdocumentreport (long ala_ids[], string as_topic)
public function boolean of_documentexist (long al_shipmentid)
public function integer of_savedocument (n_cst_document anv_document, long al_shipmentid)
public function integer of_savedocumentcopy (n_cst_document anv_document, string as_filepathname)
private function integer of_writefile (n_cst_document anv_document)
public function string of_getdocumentdirpath (string as_documenttype)
private function integer of_calculatepath (unsignedlong aul_id, ref string as_filepath)
public function integer of_calculatepath (long al_id, ref string as_filepath, string as_doctype)
public subroutine of_setcatagory (string as_Catagory)
public subroutine of_settopic (string as_Topic)
public function integer of_createpath (string as_path)
public function integer of_transferqueueddocuments ()
public function integer of_adderror (string as_error)
protected function integer of_getdocument (string as_documenttype, long al_targetcompany, long al_shipmentid, ref n_cst_document anv_document)
public function integer of_gettransferdocument (long al_requestid, ref n_cst_transferdocument anv_transferdocument)
public function integer of_addtransferrequest (long al_targetcompany, string as_documenttype, long al_source, boolean ab_normalize)
public function integer of_addtransferrequestforcompany (long al_coid, long al_sourceid)
private function datastore of_getdocumentqueuecache ()
public function integer of_removetransferrequest (long al_company, long al_sourceid)
protected function datastore of_gethistorycache ()
private function integer of_movetransfertohistory (n_cst_transferdocument anv_document)
public function boolean of_hasdocumentbeensent (long al_sourceid, long al_companyid, string as_type)
public function integer of_addtransferrequest (n_cst_beo_image anv_image)
public function integer of_addtransferrequest (long al_targetcompany, string as_documenttype, long al_source, boolean ab_normalize, boolean ab_holdtransfer)
public function integer of_gettransferdocumentsforcompany (long al_company, ref string asa_types[], ref boolean aba_holdstatus[])
public function integer of_showdocumentqueue (long al_sourceid, string as_sourcetype)
public function integer of_removeexpiredrequests ()
public function integer of_addtransferrequestforcurrentshipments (long al_billto)
end prototypes

private function string of_getrootdir ();/***************************************************************************************
NAME			: of_GetRootDir 
ACCESS		: Private
ARGUMENTS	: none
RETURNS		: String (Root directory or \)
DESCRIPTION	: Checks system setting # 33 for entry of Root Directory. 
				  If the Root directory doesn't exist it Will be created. 	
				  If there is no system setting then the root directory is set to "\".
REVISION		: rdt 092602
					Replaced "\" with ls_Separator 
***************************************************************************************/

String	ls_Root
String 	ls_PathBuild
String 	ls_Drive
String 	ls_DirPath
String 	ls_PathParts[]
String 	ls_FileName 
String 	ls_Separator 
String 	ls_errormessage

Integer	li_Result
Long		ll_PartCount
Any		la_String

n_cst_OFRError	lnv_Error

n_cst_Settings	lnv_Settings
n_cst_String 	lnv_string						

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)				// Create file service

ls_Separator = lnv_FileSrv.of_GetSeparator ( )  // get seperator from file service

lnv_Settings.of_GetSetting ( 33 , la_String )
ls_Root = String ( la_String )

If Len( ls_Root ) > 0 Then 
	ls_Root = Upper( ls_Root )
	// add a Separator to the end, if needed.
	If Right ( ls_Root , 1 ) <> ls_Separator THEN
		ls_Root += ls_Separator
	End If
Else
	ls_root = ls_Separator
End If

If lnv_FileSrv.of_directoryExists(ls_Root) Then 			
	li_Result = ci_success 											// exists do nothing
Else
	li_Result = this.of_CreatePath( ls_Root )
End If
// set error
IF len (ls_errormessage) > 0 then
	lnv_Error = This.AddOFRError ( )
	If IsValid ( lnv_Error ) then
		lnv_Error.SetErrorMessage ( ls_ErrorMessage )
	End if
END IF


f_SetFileSrv(lnv_FileSrv, FALSE )			//Destroy File Service

RETURN ls_Root

end function

private function string of_stripcharacters (string as_inputstring, string as_badcharacters);//
/***************************************************************************************
NAME			: of_StripCharacters
ACCESS		: Private
ARGUMENTS	: String (string to examine), String (characters to remove)
RETURNS		: String
DESCRIPTION	: Strip out characters 
REVISION		: RDT 092602
***************************************************************************************/

String 	ls_Return
String	ls_Out
String 	ls_Input[]
Integer	li_InCounter

ls_Return = ""

If IsNull( as_inputstring ) Then 
	// do nothing
Else
	For li_InCounter = 1 to Len(as_inputstring)							
		ls_Input[li_InCounter] = Mid(as_inputstring,li_InCounter, 1)
	Next
	
	FOR li_InCounter = 1 to UpperBound( ls_Input[] )

		If Pos ( as_badcharacters, ls_Input[ li_InCounter ]) = 0 Then  
			// good character. Keep.
			ls_Return += String(ls_Input[ li_InCounter ])
		Else
			// bad character. do nothing (skip)
		End if
		
	NEXT
	
End If

Return ls_Return
end function

private function string of_getcatagory ();//
/***************************************************************************************
NAME			: of_GetCatagory
ACCESS		: Private
ARGUMENTS	: none
RETURNS		: String (is_Catagory)
DESCRIPTION	: Returns is_Catagory (Default on document is "UNSECURE")

REVISION		: RDT 092602
***************************************************************************************/

Return is_catagory
end function

private function string of_gettopic ();//
/***************************************************************************************
NAME			: of_GetTopic
ACCESS		: Private
ARGUMENTS	: none
RETURNS		: String (is_Topic)
DESCRIPTION	: Returns is_Topic (Default is "SHIPMENT")

REVISION		: RDT 092602
***************************************************************************************/

Return is_Topic
end function

private function string of_calculatefilename (string as_codename);//
/***************************************************************************************
NAME			: of_CalculateFileName
ACCESS		: Private
ARGUMENTS	: String (company name)
RETURNS		: String
DESCRIPTION	: Calculates the file name based on the beo type and company Code name argument.
				  Special characters like ( ) ; \ / : * ? " < >  | or periods will be removed. 
				  Shipment file name = CompanyCodeName+Datetime.TXT 
				  Event file name    = Prefix+CompanyCodeName+Datetime
												Events will include a 2-character prefix to identify the type of event. 
												These codes will be retrieved from the n_cst_events.of_GetTypeDisplayValueShort().
REVISION		: RDT 092602
***************************************************************************************/

String 	ls_Return
String	ls_BadCharacters
String 	ls_Extension

SetNull( ls_Return )

ls_BadCharacters = "( ) ; \ / : * ? ~" < > . | "
ls_Extension	  = ".TXT"
n_cst_String lnv_String

If IsNull( as_CodeName ) Then     
	// do nothing
Else
	as_CodeName  = lnv_String.of_RemoveNonPrint( as_CodeName  )			// remove nonprintable characters
	as_CodeName  = lnv_String.of_RemoveWhiteSpace( as_CodeName  )		// remove white space 
	as_CodeName  = this.of_StripCharacters( as_CodeName , ls_BadCharacters ) // Remove bad characters
	If IsValid (inv_beo) Then 
		If inv_beo.of_GetTopic() = "EVENT" Then 
			as_CodeName = this.of_AddPrefix( as_CodeName )						// add event type prefix to name
		End If
	End If
	ls_Return = as_CodeName + "-" + String(Today(), "mmddyy-hhmmss") + ls_Extension // add time stamp and extension

End If

Return ls_Return
end function

private function string of_addprefix (string as_filename);//
/***************************************************************************************
NAME			: of_AddPrefix
ACCESS		: Private
ARGUMENTS	: String (file name)
RETURNS		: String (file name with prefix added)
DESCRIPTION	: Adds a prefix on the file name. 
				  Currently Used for Events. (BEO must have an of_GetType() method)

REVISION		: RDT 092602
***************************************************************************************/
Character lchr_Type
String	 ls_Return

lchr_Type = inv_beo.Dynamic of_GetType()

n_cst_events lnv_Events				// autoinstantiated

ls_Return = lnv_Events.of_GetTypeDisplayValueShort ( lchr_Type ) + "-" + as_filename 

Return ls_Return 
end function

private function string of_emailsetbody (n_cst_document anv_document);//
/***************************************************************************************
NAME			: of_EmailSetBody
ACCESS		: Private
ARGUMENTS	: n_cst_Document
RETURNS		: String  (New body)
DESCRIPTION	: For EMAIL Documents only. 
					Add Email addresses, Subject Line, and File names of any attachments
					to the body of the document text.

REVISION		: RDT 092602
***************************************************************************************/
String	ls_Body
String 	ls_Addresses[]
String 	ls_Subject
String 	ls_AttachPath
String 	ls_AttachFile

Integer	li_Count

MailFileDescription lobj_MFD[]

anv_Document.Dynamic of_GetTargetAddresses ( ls_Addresses[] ) // get addresses from document

// add the current date and time document was saved
ls_Body = ls_Body + "~r~n" + "Date: " +String( Today(),"MM/DD/YYYY" ) + "   Time: "+ String( Now(),"hh:mm am/pm" ) 

// Loop thru array and add addresses to body text 
FOR li_Count = 1 TO UpperBound( ls_Addresses[] )
		ls_Body = ls_Body + "~r~n" + "To: "+ ls_Addresses[li_Count]
NEXT

// get subject from document and append to body
ls_Body = ls_Body + "~r~n" + "Subject: "+ anv_Document.Dynamic of_getsubject ( )

// check for attachments
If anv_Document.Dynamic of_GetAttachments ( lobj_MFD[]) > 0 Then 	
	FOR li_Count = 1 TO UpperBound( lobj_MFD[] )
			ls_AttachPath = lobj_MFD[ li_Count ].PathName
			ls_AttachFile = lobj_MFD[ li_Count ].FileName
			ls_Body = ls_Body + "~r~n" + "Attachment: " + ls_AttachPath + ls_AttachFile 
	NEXT
End If

ls_Body = ls_Body + "~r~n" + "~r~n" + anv_Document.Dynamic of_GetBody ( )

Return  ls_Body 

end function

public function integer of_savedocument (n_cst_document anv_document);// 
/***************************************************************************************
NAME			: of_SaveDocument
ACCESS		: Public
ARGUMENTS	: n_cst_document
RETURNS		: ci_failure or ci_success
DESCRIPTION	: Uses the document passed in to Save the file to disk.

REVISION		: RDT 092602
***************************************************************************************/
String 	ls_Catagory 
String 	ls_Topic		
String 	ls_DocType	
String 	ls_Filename	
String 	ls_FilePath
String 	ls_FileText
String 	ls_errormessage 
Long		ll_Id
Long 		ll_errorcount 
Integer 	li_Return 
Integer 	li_UpperBound
Integer 	li_Count

li_Return = ci_failure

n_cst_OFRError    lnva_Errors[]
This.ClearOFRErrors ( )

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)															// Create file service

inv_beo		= anv_document.of_GetBEO ( )			
ll_Id			= anv_document.of_GetShipmentId ( )										// Get the id (used to figure out path) 
is_DocumentType = anv_document.of_GetDocumentType ( ) 							// Get the Document Type (Event, AccNote, TIR, etc.)

ls_Filename	= This.Of_CalculateFileName ( anv_Document.of_GetFileName ( ) )// Calculate the file name from the document name
li_Return 	= anv_document.of_SetFilename ( ls_FileName )  
If li_Return = 1 Then 
	// ok
Else
	ls_errormessage = "Error in File name " + ls_FileName
End iF

If li_Return = 1 Then 
	li_Return 	= This.Of_CalculatePath ( ll_id, ls_FilePath ) 						// calculate path
End If

If li_Return = 1 Then
	li_Return 	= anv_document.of_SetPath( ls_FilePath )  
Else
	ls_errormessage = "Error in File Path " + ls_FilePath 
End iF

If li_Return = 1 Then
	anv_Document.of_SetPathFileName( ls_FilePath + ls_FileName )
	This.of_WriteFile( anv_document )
End IF
//If li_Return = ci_success Then 
//	if NOT lnv_FileSrv.of_directoryExists( ls_FilePath )	Then 					// check if path exists
//		li_Return = This.Of_CreatePath ( ls_FilePath )
//	end if
//End If
//
//If li_Return = ci_success Then 
//	ls_FileName = ls_FilePath + ls_FileName											// add path to File name 
//
//	If anv_document.ib_Email then 
//		ls_FileText = This.of_EmailSetBody( anv_document )
//	Else
//		ls_FileText = anv_Document.of_GetText( )
//	End If
//
//	If lnv_FileSrv.of_FileWrite( ls_FileName, ls_FileText, FALSE ) = 1 Then  // (FALSE = OverWrite existing file)
//		li_Return = ci_Success
//	Else
//		ls_errormessage = "File Write Error. Please verify file name "+ls_FileName 
//		li_Return = ci_Failure
//	End If
//	
//End If

// error check
This.GetOFRErrors ( lnva_Errors )
ll_errorcount = This.geterrorcount ( )
if ll_errorcount > 0 then
	ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
	 if Len ( ls_errormessage ) > 0 then
		//OK
	 else
		ls_errormessage = "Unspecified error on Document Save."
	 end if
	 if len(ls_errormessage) > 0 then
			messagebox("Error Saving Document", ls_errormessage)
			li_return = -1
	 end if
end if

f_SetFileSrv(lnv_FileSrv, FALSE)														// Destroy file service

Return li_Return 


end function

private function integer of_retrievefilenames (long al_shipid, ref n_cst_document anv_document);//
/***************************************************************************************
NAME			: of_RetrieveFileNames
ACCESS		: Private
ARGUMENTS	: Long		(Shipment Id)
				: n_cst_document (ref)
RETURNS		: Integer 	(ci_success, ci_failure)
DESCRIPTION	: Finds files related to the shipment id and document type 
				  The file name (including path) are stored in an array in the n_cst_document object.

REVISION		: RDT 092602
***************************************************************************************/
String	ls_Return[]
String	ls_FileNames[]
String	ls_FileSpec
String	ls_FilePath
Integer	li_Return
Integer	li_Count

n_cst_dirattrib lnv_dirlist[] 

li_Return = ci_success
ls_fileSpec = "\*.*"

n_cst_filesrv  lnv_FileSrv

f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service

This.of_CalculatePath(al_shipid, ls_FilePath) 					// get the path

If lnv_FileSrv.of_directoryexists ( ls_FilePath ) Then 
	lnv_filesrv.of_dirlist ( ls_FilePath+ls_FileSpec, 0 , lnv_dirlist[] )
Else
	li_Return = ci_failure
End If

If li_Return = ci_success Then 										// load array with file names
	If UpperBound( lnv_dirlist[] ) > 0 Then 
//		MessageBox("ret_filename ", is_documenttype +" Array = "+String( UpperBound( lnv_dirlist[] ) ))
		For li_Count = 1 to UpperBound( lnv_dirlist[] )
			anv_document.of_AddFileName ( ls_FilePath + lnv_dirList[li_Count].is_filename )
		Next
	End If
End If


f_SetFileSrv(lnv_FileSrv, FALSE)

Return li_Return
end function

private function integer of_populatedocument (long al_shipid, string as_filespec);//
/***************************************************************************************
NAME			: of_PopulateDocument
ACCESS		: Private
ARGUMENTS	: Long		(Shipment Id)
				: String		(File specification "\*.*")
RETURNS		: Integer 	(ci_success, ci_failure , ci_NoAction (file DNE ))
DESCRIPTION	: Finds the document and creates array value and populates the following;
					is_DocumentType
					is_Text
					is_FileName
					il_ShipmentId
					idt_FileDateTime		
					
REVISION		: RDT 092602
***************************************************************************************/
String	ls_FileText[]
String	ls_PathFileName 
String	ls_FilePath
String	ls_Text
String	ls_ErrorMessage
String	ls_Separator
Integer	li_Return
Integer	li_TextCount
Integer	li_DirCount
Integer	li_ArrayCount
Date		ldt_FileDate
Time		ltm_FileTime
DateTime	ldttm_FileDateTime
String	ls_CreateString

li_Return = ci_success

n_cst_OFRError	lnv_Error
n_cst_dirattrib lnv_dirlist[] 
n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service
ls_Separator = lnv_FileSrv.of_GetSeparator ( )  				// get separator from file service

CHOOSE CASE as_filespec
			
	CASE "*.tif"
		
		ls_CreateString	 = "n_cst_Document_tif"
	CASE ELSE
		ls_CreateString = "n_cst_Document"
		
END CHOOSE


If left(as_FileSpec , 1 ) <> ls_Separator Then  				// add separator if needed
	as_FileSpec = ls_Separator + as_FileSpec
End If

If is_DocumentType = This.cs_authin Then 
		/******* DO NOT CALCULATE PATH FOR AUTHIN. FILES ARE STORED IN ONE DIRECTORY *******/
		is_DocumentType = This.cs_authin 
		ls_FilePath  = This.Of_GetRootDir()									// Get root directory
		ls_FilePath += This.Of_GetCatagory ( ) + ls_Separator 		// Get the Catagory (Secured, Unsecured) & add to path
		ls_FilePath += This.Of_GetTopic ( )	   + ls_Separator 		// Get the Topic (Employee, Shipment) & add to path
		ls_FilePath += is_DocumentType  			+ ls_Separator 		// Add document type onto
		as_FileSpec = "?" + String(al_shipid) + "*.txt"
Else
		This.of_CalculatePath(al_shipid, ls_FilePath) 					// get the path for the ship id
End if

If lnv_FileSrv.of_directoryexists ( ls_FilePath ) Then 		// does it exist?
	lnv_filesrv.of_dirlist ( ls_FilePath + as_FileSpec , 0 , lnv_dirlist[] )
Else
	li_Return = ci_Noaction
End If

IF UpperBound ( lnv_dirlist ) = 0 THEN  // I added this because Rich was returning success just because the 
	li_Return = ci_Noaction					// folder exits... but what if the document was deleted, the folder will still be there...(duh)
END IF

If li_Return = ci_success Then 								// load array with all the file names in the directory

	
			
	li_ArrayCount = UpperBound( inv_document[] )
	
	
	
	If UpperBound( lnv_dirlist[] ) > 0 Then 

		For li_DirCount = 1 to UpperBound( lnv_dirlist[] )
			li_ArrayCount ++												
			ls_PathFileName = ls_FilePath + lnv_dirList[ li_DirCount ].is_filename
			
			IF as_filespec <> "*.tif" THEN
				If lnv_FileSrv.of_fileread ( ls_PathFileName, ls_FileText[] ) = -1 then 
					ls_errormessage = "Error Reading File " +ls_PathFileName				// error reading file
					Exit
				Else
					ls_Text = ''
					For li_TextCount = 1 to UpperBound( ls_FileText[] )				// Load array of contents into text
						ls_Text += ls_FileText[ li_TextCount ] 
					Next
				End If
			END IF

			inv_document[ li_ArrayCount ] = Create USING ls_CreateString					// instantiate &  load
			inv_document[ li_ArrayCount ].of_SetFileName ( lnv_dirList[ li_DirCount ].is_filename )	
			inv_document[ li_ArrayCount ].of_SetPathFileName ( ls_PathFileName )	
			inv_document[ li_ArrayCount ].of_SetShipmentId ( al_shipid )
			inv_document[ li_ArrayCount ].of_SetDocumentType( is_documenttype )
			inv_document[ li_ArrayCount ].of_SetText ( ls_Text )
			// get file create DateTime
			lnv_FileSrv.of_GetCreationDateTime ( ls_PathFileName , ldt_FileDate, ltm_FileTime)
			ldttm_FileDateTime = DATETIME(ldt_FileDate , ltm_FileTime)			
			inv_document[ li_ArrayCount ].of_SetFileDateTime( ldttm_FileDateTime  )

		Next
	End If
	
End If

If len (ls_errormessage) > 0 then
	lnv_Error = This.AddOFRError ( )
	if IsValid ( lnv_Error ) then
		lnv_Error.SetErrorMessage ( ls_ErrorMessage )
	end if
End if


f_SetFileSrv(lnv_FileSrv, FALSE)										// Destory file service

Return li_Return
end function

public function integer of_retrievedocuments (unsignedlong al_shipid, string as_documenttype, ref n_cst_document anv_document[]);//
/***************************************************************************************
NAME			: of_RetrieveDocuments
ACCESS		: Public
ARGUMENTS	: Unsigned Long (Shipment ID)
				: String			 (Document Type)
				: n_cst_document[]
RETURNS		: Integer 		 (ci_success, ci_failure)
DESCRIPTION	: Retrieves all documents for a shipment ID. 
					If the Document Type =  "" all file names for the shipment id are returned
					If the Document Type is NOT = "" then only those types of documents are returned. 
REVISION		: RDT 092602
***************************************************************************************/

String 	ls_FilePath   , & 
			ls_FileName[] , & 
			ls_ErrorMessage, &
			ls_Separator, &
			ls_FileMask
Long		ll_id, &
			ll_ErrorCount
Integer	li_Return 

li_Return  = ci_success

inv_document[] = anv_document[]

n_cst_OFRError    lnva_Errors[]
This.ClearOFRErrors ( )

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)															// Create file service
ls_Separator = lnv_FileSrv.of_GetSeparator ( )										// get Separator for OS

ls_FileMask  = ls_Separator + "*.TXT"

is_DocumentType = as_documenttype

If is_DocumentType = "" Then 
		is_DocumentType = This.cs_event
		This.of_PopulateDocument( al_shipid , ls_FileMask)

		is_DocumentType = This.cs_acc
		This.of_PopulateDocument( al_shipid , ls_FileMask)

		is_DocumentType = This.cs_authin
//		This.of_PopulateDocument( al_shipid , ls_FileMask)
		This.of_PopulateDocument( al_shipid , "?" + String(al_shipid) + ls_FileMask)


		is_DocumentType = This.cs_AuthAccept
		This.of_PopulateDocument( al_shipid , ls_FileMask)

		is_DocumentType = This.cs_AuthDeny
		This.of_PopulateDocument( al_shipid , ls_FileMask)

		is_DocumentType = This.cs_authout
		This.of_PopulateDocument( al_shipid , ls_FileMask)

		is_DocumentType = This.cs_lfd
		This.of_PopulateDocument( al_shipid , ls_FileMask)

		is_DocumentType = This.cs_tir
		This.of_PopulateDocument( al_shipid , ls_FileMask)

		is_DocumentType = This.cs_shipstat
		This.of_PopulateDocument( al_shipid , ls_FileMask)

Else
		This.of_PopulateDocument( al_shipid , ls_FileMask)

End if

// error check
This.GetOFRErrors ( lnva_Errors )
ll_errorcount = This.geterrorcount ( )
if ll_errorcount > 0 then
	ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
	 if Len ( ls_errormessage ) > 0 then
		//OK
	 else
		ls_errormessage = "Unspecified error on Retrieve Document."
	 end if
	 if len( ls_errormessage ) > 0 then
			messagebox( "Error Retreiving Document", ls_errormessage )
			li_return = ci_failure
	 end if
end if

f_SetFileSrv(lnv_FileSrv, FALSE)										// destroy file service
anv_document[] = inv_document[] 										// return Documents by reference
Return li_Return 

end function

public function integer of_gettypelist (ref string as_type[]);//
/***************************************************************************************
NAME			: of_GetTypeList
ACCESS		: Public
ARGUMENTS	: String		(Array of types) by reference
RETURNS		: Integer	(Number of elements in Array)
DESCRIPTION	: Returns an array of the current documents types supported
				: ie: Accessorial = cs_acc, 
				
				NOTE cs_authin is not included. This is a special type of document.

REVISION		: RDT 092602
***************************************************************************************/
Integer 	li_Count 

li_Count = 0

//Accessorial
li_Count ++
as_Type[li_Count] = cs_acc

//Authorization In
//li_Count ++
//as_Type[li_Count] = cs_authin

//Authorization Accept
li_Count ++
as_Type[li_Count] = cs_authAccept

//Authorization Deny 
li_Count ++
as_Type[li_Count] = cs_authDeny

//Authorization Out
li_Count ++
as_Type[li_Count] = cs_authout

//Event Confirmation
li_Count ++
as_Type[li_Count] = cs_event

//Last Free Date
li_Count ++
as_Type[li_Count] = cs_lfd

//TIR Report
li_Count ++
as_Type[li_Count] = cs_tir

//Status Request
li_Count ++
as_Type[li_Count] = cs_shipstat

//Load Confirmation
li_Count ++
as_Type[li_Count] = THIS.cs_loadconfirmation

Return li_Count


end function

public function integer of_missingdocumentreport (long ala_ids[], string as_topic);//
/***************************************************************************************
NAME			: of_MissingDocumentReport
ACCESS		: public
ARGUMENTS	: Long Array 	(Shipment id's) 
				: String			(Topic)
RETURNS		: ??
DESCRIPTION	: 

REVISION		: RDT 092602
***************************************************************************************/
String	ls_CurrentType
String	lsa_Types[]
String 	ls_ColName
String	ls_ErrorMessage
String	ls_Format
String 	ls_ExistValue  = "ü"
String	ls_NotExistValue = ""
Blob		lblob_FullState
Boolean	lb_Continue

Long		ll_NewRow
Long		ll_CurrentID
String	ls_Report_name
String	lsa_labels[]
Any		laa_Values[] 

Int		li_typeCount
Int		li_Counter 
Int		li_returnValue = 1

n_cst_msg	lnv_msg
S_parm		lstr_Parm
n_cst_ShipmentManager	lnv_ShipmentManager

n_cst_dws 	lnv_dws
DataStore lds_Images
lds_Images = Create DataStore
lds_Images.dataObject = "d_MissingImages2"

ls_ErrorMessage = "An error occurred while attempting to generate a missing image report."

setPointer( HOURGLASS! )

is_topic = as_topic

// open Type selection window 
lstr_parm.is_Label = "TOPIC"
lstr_Parm.ia_Value = as_topic
lnv_msg.of_Add_parm ( lstr_parm )
openWithParm ( w_MissingImageTypeSelection  , lnv_msg )

SetPointer ( HOURGLASS! )

lnv_msg = message.powerobjectparm

IF isValid ( lnv_msg ) THEN
	IF lnv_Msg.of_get_Parm ( "CONTINUE", lstr_Parm )  <> 0 THEN
		lb_continue = lstr_Parm.ia_Value 
	END IF
	
	IF lnv_Msg.of_get_Parm ( "FORMAT", lstr_Parm )  <> 0 THEN
		ls_Format = lstr_Parm.ia_Value 
		IF ls_Format = "" THEN
			li_ReturnValue = -1
		ELSEIF ls_Format = "Mark Documents on File" THEN
			lds_Images.object.Missing_images.Text = "= On File"
			
		ELSE
			ls_ExistValue = ""
			ls_NotExistValue = "ü"
			lds_Images.object.Missing_images.Text = "= Missing "
		END IF
	END IF
END IF
	
IF lb_Continue THEN
	IF lnv_Msg.of_Get_Parm ( "TYPES" , lstr_parm ) <> 0 THEN
		lsa_Types = lstr_Parm.ia_Value
	ELSE 
		li_ReturnValue = -1
	END IF
ELSE
	li_ReturnValue = 0 // user canceled
END IF

// check for more than 20 in msg object.
If li_ReturnValue = 1 Then 
	If UpperBound( lsa_Types ) > 19 Then 
		messageBox ( "Image Types" , "Please limit the number of types to less then 20." )			
		Return 0  // change this and inform user   // MID CODE RTN		
	End If
End If

// set the column names in the datawindow
If li_ReturnValue = 1 Then 
	FOR li_Counter = 1 TO upperBound ( lsa_Types )
		ls_colname = lds_Images.describe("#" + string(li_Counter + 1) + ".name")
		ls_ColName += "_t"
		lds_Images.modify(ls_colname + ".font.escapement = 450 " )
		lds_Images.modify(ls_ColName + ".text = '"+lsa_Types[li_Counter]+"'")
	Next
End If
	
IF li_ReturnValue = 1 THEN
	
	n_cst_setting_includeparentinimagelookup	lnv_IncludeParents
	lnv_IncludeParents = CREATE n_cst_setting_includeparentinimagelookup
	IF lnv_IncludeParents.of_Getvalue( ) = lnv_IncludeParents.cs_yes THEN
		lnv_ShipmentManager.of_Addparentidstolist( ala_ids , ala_ids )
	END IF	
	DESTROY ( lnv_IncludeParents )
	
	
	FOR li_Counter = 1 TO upperBound ( ala_ids[] )
		
		ll_NewRow = lds_Images.InsertRow(0)
		ll_CurrentID = ala_IDs [ li_Counter ]	
		lds_Images.object.Image_id[ li_Counter ] =  ll_CurrentID
		
		FOR li_TypeCount = 1 TO upperBound ( lsa_Types )
			ls_colname = lds_Images.describe("#" + string(li_TypeCount + 1) + ".name")
			
			is_documenttype = lsa_Types[ li_TypeCount ]
			
			IF this.of_DocumentExist (ala_ids[ li_Counter ]) THEN
				lds_Images.SetItem ( ll_NewRow, ls_colName , ls_ExistValue )
			ELSE
				lds_Images.SetItem ( ll_NewRow, ls_colName , ls_NotExistValue )
			END IF
			
		NEXT
	NEXT
	
END IF

IF li_ReturnValue = 1 THEN
	
	ls_report_name = "Missing Document Report"
		
	lsa_labels[upperbound(lsa_labels) + 1] = "TARGET!"
	laa_values[upperbound(laa_values) + 1] = lds_Images
	
	lsa_labels[upperbound(lsa_labels) + 1] = "REPORT_NAME!"
	laa_values[upperbound(laa_values) + 1] = ls_Report_Name
	
	lsa_labels[upperbound(lsa_labels) + 1] = "REPORT_LABEL!"
	laa_values[upperbound(laa_values) + 1] = "OFFICIAL COPY"
	
	lnv_dws.of_create_header(lsa_labels, laa_values)
	
	lds_Images.getFullstate ( lblob_fullstate )
	
	lstr_parm.is_Label = "DATAOBJECT"
	lstr_Parm.ia_Value = lblob_FullState
	lnv_msg.of_Add_parm ( lstr_parm )
	
	lstr_parm.is_Label = "TOPIC"
	lstr_Parm.ia_Value = as_topic
	lnv_msg.of_Add_parm ( lstr_parm )
	
	openWithParm ( w_MissingImageDisplay  , lnv_msg )
	
	lnv_msg = message.powerobjectparm
END IF	

IF li_ReturnValue = -1 THEN
	MessageBox( "Missing Image Report" , ls_ErrorMessage )
END IF

DESTROY lds_Images

Return li_returnValue
	

end function

public function boolean of_documentexist (long al_shipmentid);//
/***************************************************************************************
NAME			: of_DocumentExist
ACCESS		: Private
ARGUMENTS	: Long		(Shipment Id)
RETURNS		: Boolean	(True = Document found, False = Document NOT found)
DESCRIPTION	: Using arguments this method looks for documents (files) in the directory 
					and returns True if at least one file was found. 
					False is returned if none where found or the directory doesn't exist. 

REVISION		: RDT 092602
***************************************************************************************/
String	ls_FilePath
String	ls_Separator
Boolean 	lb_Found_It
lb_Found_It = False

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service
n_cst_dirattrib lnv_dirlist[]

This.of_CalculatePath(al_shipmentid, ls_FilePath) 

If lnv_FileSrv.of_directoryExists( ls_FilePath ) Then 
	ls_FilePath += "*.*"

// I Changed the file type from 0(RDT) to 39(RPZ) 

	if lnv_fileSrv.of_dirlist ( ls_FilePath, 39, lnv_dirlist[] ) > 0 Then 
		lb_Found_It = TRUE
	end if
	
End IF
f_SetFileSrv(lnv_FileSrv, FALSE )										// Destroy file service

Return lb_Found_It 
end function

public function integer of_savedocument (n_cst_document anv_document, long al_shipmentid);//   Use this when you don't have a beo.
/***************************************************************************************
NAME			: of_SaveDocument
ACCESS		: Public
ARGUMENTS	: n_cst_document	(anv_document)
				  long				(Shipment id )
RETURNS		: Integer 			(ci_failure, ci_success)
DESCRIPTION	: Uses the shipment ID to calculate the File Path and calls of_writefile
				  Use this when you don't have a beo.
					* If an Accept record already exists do not save this reply. *

REVISION		: RDT 102602
***************************************************************************************/
String 	ls_FilePath, &
			ls_FileName, &
			ls_FullName, &
			ls_CodeName, &
			ls_ErrorMessage, &
			ls_Separator 

Integer 	li_Return = ci_success

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service
ls_Separator = lnv_FileSrv.of_GetSeparator ( )  				// get seperator from file service

is_Documenttype = anv_Document.of_GetDocumentType() 
ls_CodeName = anv_Document.of_GetCompanyCode()

// Retrieve the company name / code because it is part of the file name. 
If Len( Trim( ls_CodeName ) ) < 1 Then  

	SELECT "companies"."co_name",   
			"companies"."co_code_name"  
	 INTO :ls_FullName, 
			:ls_CodeName
	 FROM "current_shipment_list",   
			"companies"  
	WHERE ( "current_shipment_list"."ds_billto_id" = "companies"."co_id" ) and  
			(  "current_shipment_list"."ds_id" = :al_shipmentid  )   ;
			
	CHOOSE CASE SQLCA.SqlCode
		CASE 0
			COMMIT ;
			li_Return = 1
		CASE ELSE
			ROLLBACK ;
			li_Return = -1
			ls_ErrorMessage = "Shipment "+String( al_shipmentid ) +" not on file"
	END CHOOSE
End If

If li_Return = 1 Then 
	if Len( Trim( ls_CodeName ) ) < 1 OR IsNull( ls_CodeName ) Then 
		ls_CodeName = Left( ls_FullName, 5 )
	end if	

	ls_FileName  = This.of_CalculateFileName( ls_CodeName )

	if is_DocumentType = This.cs_authin Then 									// authin type
		/*Check for existing ACCEPT reply*/
		is_DocumentType = This.cs_authAccept
		If This.of_DocumentExist ( al_shipmentid ) Then  
			// accept document was processed and exists. do nothing
			li_Return = -1
			is_DocumentType = This.cs_authin 
		Else
			/******* DO NOT CALCULATE PATH FOR AUTHIN. FILES ARE STORED IN ONE DIRECTORY *******/
			is_DocumentType = This.cs_authin 
			ls_FileName  = anv_Document.of_GetAcceptDeny( ) + String(al_shipmentid)   + "-" + ls_FileName  // create file name
			ls_FilePath  = This.Of_GetRootDir()									// Get root directory
			ls_FilePath += This.Of_GetCatagory ( ) + ls_Separator 		// Get the Catagory (Secured, Unsecured) & add to path
			ls_FilePath += This.Of_GetTopic ( )	   + ls_Separator 		// Get the Topic (Employee, Shipment) & add to path
			ls_FilePath += is_DocumentType  			+ ls_Separator 		// Add document type onto path
		End If

	else

		li_Return   = This.of_CalculatePath( al_shipmentid , ls_filepath )  
	end if

End If

If li_Return = 1 Then 
	anv_Document.of_SetFileName( ls_FileName )
	anv_Document.of_SetPath( ls_filepath )
	anv_Document.of_SetPathFileName( ls_FilePath + ls_FileName )
	anv_Document.of_IsEmail( TRUE )
	li_Return = This.of_WriteFile( anv_document )
Else 
	If Len(Trim( ls_ErrorMessage ) ) > 0 Then 
		MessageBox("Document Save error.",ls_ErrorMessage)
	End If	
End If

f_SetFileSrv(lnv_FileSrv, FALSE)															// Destroy file service


return li_Return 
end function

public function integer of_savedocumentcopy (n_cst_document anv_document, string as_filepathname);//
/***************************************************************************************
NAME			: of_SaveDocumentCopy
ACCESS		: Public
ARGUMENTS	: n_cst_document	(anv_document)
				  String				Original File Path and Name 
RETURNS		: ci_failure or ci_success
DESCRIPTION	: Uses the Original File Path and Name passed in to Save the file to disk.

REVISION		: RDT 092602
***************************************************************************************/
String 	ls_FilePath
String	ls_FileExtension
String 	ls_FileText
Integer 	li_Return 

li_Return = ci_failure

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)															// Create file service

n_cst_String	lnv_string																	// create string service (Autoinstantiated)


// save the file extension
ls_FileExtension = Right( as_filepathname, 4 )

// Strip the date and time from the file name, which should be the last 18 characters

ls_FilePath = Mid( as_filepathname, 0, Len(as_filepathname)-18)
// add the new date and old extension to file name
ls_FilePath = ls_FilePath+ "-" + String(Today(), "mmddyy-hhmmss") + ls_FileExtension // add time stamp and extension

If anv_document.of_IsEmail( ) Then 
	ls_FileText = This.of_EmailSetBody( anv_document )
Else
	ls_FileText = anv_Document.of_GetText( )
End If

If lnv_FileSrv.of_FileWrite( ls_FilePath, ls_FileText, FALSE ) = 1 Then 
	li_Return = ci_Success
Else
	MessageBox("File Save Error","File could not be written to disk. Please verify path and file name " + ls_FilePath )
	li_Return = ci_Failure
End If


f_SetFileSrv(lnv_FileSrv, FALSE)														// Destroy file service

Return li_Return 


end function

private function integer of_writefile (n_cst_document anv_document);//
/***************************************************************************************
NAME			: of_WriteFile
ACCESS		: private
ARGUMENTS	: n_cst_document
RETURNS		: Integer	(ci_success, ci_failure)
DESCRIPTION	: Checks for existance of directory and creates if needed.
				  Writes file to disk.

REVISION		: RDT 102602
***************************************************************************************/
String	ls_FileText, &
			ls_errormessage, &
			ls_Path, &
			ls_PathFileName

Long		ll_errorcount 			

Integer 	li_Return = ci_success

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)															// Create file service

ls_Path = anv_Document.of_GetPath() 

If NOT lnv_FileSrv.of_directoryExists( ls_Path  )	Then 					// check if path exists
	li_Return = This.Of_CreatePath ( ls_Path  )
End if

If li_Return = ci_success Then 

	If anv_document.of_IsEmail() then 
		ls_FileText = This.of_EmailSetBody( anv_document )
	Else
		ls_FileText = anv_Document.of_GetText( )
	End If

	If lnv_FileSrv.of_FileWrite( anv_Document.of_GetPathFileName() , ls_FileText, FALSE ) = 1 Then  // (FALSE = OverWrite existing file)
		li_Return = ci_Success
	Else
		ls_errormessage = "File Write Error. Please verify file name "+anv_Document.of_GetPathFileName() 
		li_Return = ci_Failure
	End If
	
End If

// error check
//This.GetOFRErrors ( lnva_Errors )
//ll_errorcount = This.geterrorcount ( )
//if ll_errorcount > 0 then
//	ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )
//	 if Len ( ls_errormessage ) > 0 then
//		//OK
//	 else
//		ls_errormessage = "Unspecified error on Document Save."
//	 end if
//	 if len(ls_errormessage) > 0 then
//			messagebox("Error Saving Document", ls_errormessage)
//			li_return = -1
//	 end if
//end if

f_SetFileSrv(lnv_FileSrv, FALSE)														// Destroy file service


Return li_Return 


end function

public function string of_getdocumentdirpath (string as_documenttype);
/***************************************************************************************
NAME			: of_GetDocumentDirPath
ACCESS		: Public
ARGUMENTS	: String		(document type)
RETURNS		: String		(Directory path for document type)
DESCRIPTION	: Returns the directory for a document type. 
					This is used to find the default directory when you don't have a document object.
					Example: Read the files in the Authorization Reply directory.

REVISION		: RDT 102602
***************************************************************************************/
String 	ls_Return, &
			ls_Separator

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service
ls_Separator = lnv_FileSrv.of_GetSeparator ( )  				// get seperator from file service

Choose Case as_documenttype
	Case This.cs_authin
		ls_Return = This.Of_GetRootDir()								// Get root directory
		ls_Return  += "UNSECURE" + ls_Separator 	
		ls_Return  += "SHIPMENT" + ls_Separator 	
		ls_Return  += This.cs_authin + ls_Separator 
		
	Case Else
		ls_Return = This.Of_GetRootDir()								// Get root directory
		MessageBox("Program Note cst_bso_document_Manager.of_GetDocumentDirPath()","Case Statment not coded for "+as_documenttype +"~nReturning root dir")
End Choose

f_SetFileSrv(lnv_FileSrv, FALSE )									// Destroy file service


Return ls_Return 
end function

private function integer of_calculatepath (unsignedlong aul_id, ref string as_filepath);/***************************************************************************************
NAME			: of_CalculatePath
ACCESS		: Private
ARGUMENTS	: Long 		(document/shipment id passed by value)
				  String 	(File Path 	 passed by reference)
RETURNS		: Integer 	(ci_failure, ci_success)
DESCRIPTION	: 

REVISION		:RDT 091802
	This will figure out what the directory structure should be for the type of document 
	passed in. This one does NOT create directories
	
--	This same type of logic also exists in n_cst_beo_image --  
***************************************************************************************/
String 	ls_Range
String  	ls_lowRange
String 	ls_Path1
String 	ls_Path2 
String  	ls_Group
String	ls_Separator 
String	ls_errormessage
long		ll_Cat
long		lla_Span[]
long		ll_ID
ulong		lul_LowLim  
ulong		lul_ValueTemp
ulong		lul_Value
Integer	li_PathCounter
Integer	li_Return 
Integer	li_Result 

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service

ls_Separator = lnv_FileSrv.of_GetSeparator ( )  				// get seperator from file service

lla_Span[1] = 8000000
lla_Span[2] = 40000
lla_Span[3] = 200
ls_Path2 	= ""

li_Return 	= ci_Success
lul_Value 	= aul_id

ls_Path1  = This.Of_GetRootDir()									// Get root directory
ls_Path1 += This.Of_GetCatagory ( ) + ls_Separator 		// Get the Catagory (Secured, Unsecured) & add to path
ls_Path1 += This.Of_GetTopic ( )	   + ls_Separator 		// Get the Topic (Employee, Shipment) & add to path

If is_DocumentType = '' then 
	ls_Path1 += "NoType" 		+ ls_Separator 				// add Doc type to path
Else
	ls_Path1 += is_documenttype 		+ ls_Separator 		// add Doc type to path
End if

For li_PathCounter = 1 To 3										// this creates path based on shipment id
		If li_PathCounter = 1 THEN
			lul_ValueTemp = lul_value
		Else 
			lul_ValueTemp = mod ( lul_Value , lla_Span[ li_PathCounter -1 ] )  // previous span
		END IF
			
		ll_Cat 		= int ( lul_ValueTemp / lla_Span[ li_PathCounter ] ) + 1			

		ls_group 	= String(ll_Cat,"#,000")
		lul_LowLim 	= lul_Value - ( mod ( lul_Value , lla_Span[ li_PathCounter ] ) )

		If lul_LowLim > 0 THEN
			ls_lowRange = string ( lul_LowLim,"#,000" )
		Else
			ls_lowRange = String ( lul_LowLim )
		END IF

		ls_Range = ls_group + " " + ls_lowRange 
		ls_Path2 = ls_Range + ls_Separator 			
		ls_Path1 = ls_Path1 + ls_Path2

NEXT

ls_Path1 += String ( lul_Value,"#,000" ) 	+ ls_Separator 	// add id as final directory

as_filepath =  ls_Path1													// set argument to calculated path for return

f_SetFileSrv(lnv_FileSrv, FALSE) 									// destroy file service

Return li_Return




end function

public function integer of_calculatepath (long al_id, ref string as_filepath, string as_doctype);//overloaded
/***************************************************************************************
NAME			: of_CalculatePath
ACCESS		: Public
ARGUMENTS	: Long 		(document/shipment id passed by value)
				  String 	(File Path 	 			 passed by reference)
				  String		(document type			 passed by value)
RETURNS		: Integer 	(ci_failure, ci_success)
DESCRIPTION	: calculates the path for an ID and document type

				  NOTE defaults used for Catagory and Topic UNSECURED SHIPMENT

REVISION		: RDT 102602
***************************************************************************************/

Integer	li_Return 

is_DocumentType = as_DocType

li_Return = This.of_CalculatePath(al_id, as_FilePath)

Return li_Return 

end function

public subroutine of_setcatagory (string as_Catagory);//
/***************************************************************************************
NAME			: of_SetCatagory
ACCESS		: Public
ARGUMENTS	: String	(Catagory )
RETURNS		: none
DESCRIPTION	: Sets instance variable to argument

REVISION		: RDT 102602
***************************************************************************************/

is_Catagory = as_Catagory
end subroutine

public subroutine of_settopic (string as_Topic);//
/***************************************************************************************
NAME			: of_SetTopic
ACCESS		: Public
ARGUMENTS	: String	(Topic)
RETURNS		: none
DESCRIPTION	: Sets instance variable to argument

REVISION		: RDT 102602
***************************************************************************************/

is_topic = as_topic
end subroutine

public function integer of_createpath (string as_path);//
/***************************************************************************************
NAME			: of_CreatePath
ACCESS		: Public
ARGUMENTS	: String  (path to create)
RETURNS		: Integer (ci_success, ci_failure )
DESCRIPTION	: Parses a string and creates a directory structure. 
					If the path exists nothing changes.

REVISION		: RDT 092602
***************************************************************************************/

String	ls_Drive , &
			ls_DirPath , &
			ls_filename , &
			ls_PathBuild , &
			ls_PathParts[] , &
			ls_Separator , &
			ls_errormessage
Integer 	li_Return , & 
			li_Result 
Long		ll_PartCount
Any		la_String

n_cst_OFRError	lnv_Error

n_cst_Settings	lnv_Settings
n_cst_String 	lnv_string						

n_cst_filesrv  lnv_FileSrv
f_SetFileSrv(lnv_FileSrv, TRUE)										// Create file service

ls_Separator = lnv_FileSrv.of_GetSeparator ( )  				// get seperator from file service

li_Return = ci_success

// Parse the path into parts and create directory by directory
lnv_FileSrv.of_parsepath ( as_path, ls_Drive, ls_DirPath, ls_filename )
ll_PartCount = lnv_string.of_parsetoarray ( ls_DirPath, ls_Separator, ls_PathParts[] ) 
ls_PathBuild = ls_Drive

For ll_PartCount = 1 to UpperBound( ls_PathParts[] )			// loop thru dir path and create each directory as needed	

	ls_PathBuild = ls_PathBuild + ls_PathParts[ll_PartCount] + ls_Separator
	If lnv_FileSrv.of_directoryExists( ls_PathBuild ) Then 			
		li_Result = ci_success 											// exists do nothing
	Else
		li_Result = lnv_FileSrv.of_CreateDirectory( ls_PathBuild )				
		If li_Result <> 1 Then 
			ls_errormessage = "Error Creating Directory "+ls_PathBuild 
MessageBox("Program Error","Can not Create Directory Path: "+ ls_PathBuild ) 
		End If
	End If
	
Next

f_SetFileSrv(lnv_FileSrv, FALSE )									// DESTROY file service

// set error
IF len (ls_errormessage) > 0 then
	lnv_Error = This.AddOFRError ( )
	If IsValid ( lnv_Error ) then
		lnv_Error.SetErrorMessage ( ls_ErrorMessage )
		li_Return = ci_failure
	End if
END IF

Return li_Return
end function

public function integer of_transferqueueddocuments ();Int	li_Return
Long	ll_DocCount
Long	i
long	ll_RequestID
Int	li_TransferResult
n_cst_transferdocument	lnv_TransferDocument
n_Cst_AnyArraySrv	lnv_Array
n_cst_Document	lnva_EmptyDocs[]


DataStore	lds_Queue
lds_Queue = THIS.of_Getdocumentqueuecache( )

li_Return = ci_success

ll_DocCount = lds_Queue.RowCount ( )
IF ll_DocCount < 0 THEN
	li_Return = ci_failure
	THIS.of_AddError( "An error occurred while attempting to retrieve queued documents.")
END IF

IF li_Return = ci_success THEN
	FOR i = ll_DocCount TO 1 STEP -1 // backwards because the move to history processing deletes rows
		
		ll_RequestID = lds_Queue.GetItemNumber ( i , "id" )
		
		IF lds_Queue.GetItemString ( i , "HoldTransfer" ) = "1" THEN
			CONTINUE
		END IF
		
		li_TransferResult = THIS.of_GetTransferdocument( ll_RequestID , lnv_TransferDocument )
		IF li_TransferResult = ci_success THEN
			
			IF lnv_TransferDocument.of_Executetransfer( ) <> 1 THEN
				THIS.of_Adderror( lnv_TransferDocument.of_GetErrorString ( ) )
				li_Return = ci_failure
				EXIT // do we really want to exit here? maybe we should try to keep sending
			ELSE
				THIS.of_Movetransfertohistory( lnv_TransferDocument )
			END IF
			
		ELSEIF li_TransferResult = ci_Noaction THEN
			// document DNE on the Source
		ELSE
			li_Return = ci_Failure
			THIS.of_AddError ( "An error occurred while attempting to obtain a handle to the Transfer Document." ) 
			
		END IF
		
		DESTROY ( lnv_TransferDocument )
		lnv_Array.of_Destroy( inv_document )
		inv_Document = lnva_EmptyDocs
		GarbageCollect()
		
	
		
	NEXT
END IF

THIS.event pt_save( )

RETURN li_Return 
end function

public function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )

RETURN 1
end function

protected function integer of_getdocument (string as_documenttype, long al_targetcompany, long al_shipmentid, ref n_cst_document anv_document);Int		li_Return
String	ls_DocumentPath
String	ls_PTDocumentType
Long		ll_TargetCompany

n_cst_bso_Dispatch	lnv_Disp
lnv_Disp = CREATE n_Cst_bso_Dispatch
pt_n_cst_beo	lnv_Source
lnv_SOurce = CREATE n_cst_beo_Shipment

lnv_Disp.of_RetrieveShipment( al_shipmentid )
lnv_source.of_SetContext( lnv_Disp )
lnv_Source.of_SetSource ( lnv_Disp.of_GetShipmentCache ( ) )
lnv_Source.of_SetSourceid( al_shipmentid )
lnv_Source.Dynamic of_SetEventSource ( lnv_Disp.of_GetEventCache ( )  )
lnv_Source.Dynamic of_setItemSource( lnv_Disp.of_GetItemCache ( ) )


n_cst_Document	lnv_Document

li_Return = ci_Success

ls_PTDocumentType = as_documenttype
is_documenttype = ls_PTDocumentType
CHOOSE CASE THIS.of_Populatedocument( al_ShipmentID , "*.tif" ) 
	CASE ci_Success
		lnv_Document = inv_document[1]
		lnv_Document.of_Setbeo( lnv_Source )
	CASE ci_NoAction
		li_Return = ci_noaction
	CASE ELSE
		THIS.of_AddError( "Failure populating document" )
		li_Return = ci_Failure
END CHOOSE

anv_document = lnv_Document


RETURN li_Return






end function

public function integer of_gettransferdocument (long al_requestid, ref n_cst_transferdocument anv_transferdocument);Int	li_Return
Long	ll_TargetCompany
Long	ll_SourceID
String	ls_DocumentType
String	ls_TransferMethod

n_cst_Document	lnv_Document
n_cst_TransferDocument	lnv_TransferDocument
n_cst_Documentsettings	lnv_DocumentSettings


li_Return = ci_success

// first we need to determine some information about the request.
// get the target company, this will be used to get the setting for the company
// the the document type, this will be used to help determine if there are any special requirements for the 
//								  the document, as well as help determine the transfer method. (ftp,email)
//								  Document type should be a PT Document, This could be an imagetype or some 
//								  other type of document like a TIR, LFD report. 
// the sourceid,	this will help us find the source so we can resolve the request (tmp# )
  SELECT "transferdocumentqueue"."targetcompany",   
         "transferdocumentqueue"."documenttype",   
         "transferdocumentqueue"."sourceid"  
    INTO :ll_TargetCompany,   
         :ls_DocumentType,   
         :ll_SourceID  
    FROM "transferdocumentqueue"  
   WHERE "transferdocumentqueue"."id" = :al_RequestID   ;



IF SQLCA.Sqlcode <> 0 THEN
	li_Return = ci_Failure
	THIS.of_Adderror( "An error occurred while attemting to retrieve the document values for request "+ string ( al_Requestid ) )
	Rollback;
ELSE
	COMMIT;
END IF

IF li_Return = ci_success THEN
	CHOOSE CASE THIS.of_GetDocument( ls_DocumentType , ll_TargetCompany , ll_SourceID , lnv_Document ) 
		CASE ci_failure 
			li_Return = ci_failure
			THIS.of_Adderror( "An error occurred while attemting to retrieve the document for request " + string ( al_Requestid ) )
		CASE ci_noaction		 // document dne	
			li_Return = ci_noaction
		CASE ci_success
			// ok to continue
	END CHOOSE
END IF

IF li_Return = ci_success THEN
	IF gnv_Cst_companies.of_GetDocumentsettings( ll_TargetCompany, lnv_Document ,lnv_DocumentSettings ) = ci_Success THEN
		
		CHOOSE CASE lnv_DocumentSettings.of_Gettransfermethod( )
				
			CASE cs_transfermethod_ftp
				lnv_TransferDocument = CREATE n_Cst_TransferDocument_ftp
		
			CASE cs_Transfermethod_email
				lnv_TransferDocument = CREATE n_Cst_TransferDocument_EMAIL

			CASE ELSE
				li_Return = ci_failure
				THIS.of_Adderror( "An error occurred while attemting to obtain the document settings.")
		END CHOOSE
	ELSE
		li_Return = ci_failure
		THIS.of_Adderror( "Document settings could not be populated" )
	END IF	
END IF

IF IsValid ( lnv_TransferDocument ) THEN
	lnv_TransferDocument.of_Setrequestid( al_requestid )
	lnv_TransferDocument.of_Setdocument( lnv_Document )
	lnv_TransferDocument.of_SetDocumentsettings( lnv_DocumentSettings )	
	anv_transferdocument = lnv_TransferDocument
END IF

RETURN li_Return
end function

public function integer of_addtransferrequest (long al_targetcompany, string as_documenttype, long al_source, boolean ab_normalize);Boolean	lb_HoldTransfer
RETURN THIS.of_Addtransferrequest( al_targetcompany, as_documenttype, al_source, ab_normalize, lb_HoldTransfer )
end function

public function integer of_addtransferrequestforcompany (long al_coid, long al_sourceid);Int	li_Count
String	lsa_Types[]
Boolean	lba_Hold[]

Int	i
// this gets all the types
li_Count = THIS.of_GetTransferdocumentsforcompany( al_coid , lsa_Types , lba_Hold )

FOR i = 1 TO li_Count
	THIS.of_Addtransferrequest( al_coid ,lsa_Types[i] , al_sourceid , FALSE , lba_Hold[i] )
NEXT


RETURN li_Count
end function

private function datastore of_getdocumentqueuecache ();IF Not ib_queueready THEN
	ids_documentqueue.Retrieve ( )
	ib_queueready = TRUE
END IF

RETURN ids_documentqueue


end function

public function integer of_removetransferrequest (long al_company, long al_sourceid);Long	ll_Count
String	ls_Filter

DataStore	lds_Cache
IF Not( IsNull (al_Company ) OR IsNull (al_sourceid )) THEN
	lds_Cache = THIS.of_GetDocumentqueuecache( )
	
	ls_Filter = "TargetCompany = " + String ( al_company ) + " AND SourceID = " + String ( al_sourceid )
	lds_Cache.SetFilter ( ls_Filter ) 
	lds_Cache.Filter ( )
	
	
	ll_Count = lds_Cache.RowCount()
	lds_Cache.RowsMove( 1,ll_count, PRIMARY!,lds_Cache , 99 ,DELETE!)
	
	lds_Cache.SetFilter ( "" )
	lds_Cache.Filter()
END IF
RETURN ll_Count
end function

protected function datastore of_gethistorycache ();RETURN ids_Documenthistory
end function

private function integer of_movetransfertohistory (n_cst_transferdocument anv_document);Long		ll_Row
String	ls_Find
long		ll_TransferID
String	ls_FileName
Date		ld_DateSent
Int		li_PageCount
Long		ll_Company
long		ll_Source
String	ls_Type
Int		li_Return = 1

DataStore	lds_Cache
DataStore	lds_History

ld_DateSent = TODAY ( )

lds_Cache = THIS.of_Getdocumentqueuecache( )
lds_History = THIS.of_GetHistorycache( )

//ls_FileName = anv_document.of_GetFileName ( )
ls_FileName = anv_document.of_GetNameTransfered ( )
ll_TransferID = anv_document.of_GetRequestID ( )
li_PageCount = anv_document.of_GetPageCount ( )
ls_Find = "id = " + String ( ll_TransferID )
ll_Row = lds_Cache.Find ( ls_Find , 1 , lds_Cache.RowCount ( ) )
IF ll_Row > 0 THEN
	
	ll_Company = lds_Cache.GetItemnumber( ll_Row , "Targetcompany" )
	ls_Type = lds_Cache.GetItemString( ll_Row , "DocumentType" )
	ll_Source = lds_Cache.GetItemnumber( ll_Row , "sourceID" )
	
	
	IF lds_Cache.RowsMove( ll_Row ,ll_Row, PRIMARY!, lds_Cache ,  99,DELETE!) = 1 THEN
		ll_Row = lds_History.insertRow ( 0 )
		lds_History.SetItem ( ll_Row , "id" , ll_TransferID )
		lds_History.SetItem ( ll_Row , "Company" , ll_Company )
		lds_History.SetItem ( ll_Row , "DocumentType", ls_Type )
		lds_History.SetItem ( ll_Row , "source" , ll_Source )
		lds_History.SetITem ( ll_Row , "FileName" , ls_FileName )
		lds_History.SetITem ( ll_Row , "PageCount" , li_PageCount )
		lds_History.SetITem ( ll_Row , "datesent" , ld_DateSent )
	ELSE
		li_Return = -1
	END IF
ELSE 
	li_Return = -1
END IF



RETURN li_Return
end function

public function boolean of_hasdocumentbeensent (long al_sourceid, long al_companyid, string as_type);boolean	lb_Return

Int	li_Count

  SELECT Count ( "documenttransferhistory"."id"  )
    INTO :li_Count  
    FROM "documenttransferhistory"  
   WHERE ( "documenttransferhistory"."company" = :al_CompanyID ) AND  
         ( "documenttransferhistory"."documenttype" = :as_Type ) AND  
         ( "documenttransferhistory"."source" = :al_sourceID )  ;
Commit;

lb_Return = li_Count > 0 

RETURN lb_Return
end function

public function integer of_addtransferrequest (n_cst_beo_image anv_image);Long	ll_TargetCompany
String	ls_DocumentType
Long	ll_SourceID
Int	li_Return = 1

ll_SourceID = Anv_image.of_GetID ( )
ls_DocumentType = anv_Image.of_GetType ( )

 
SELECT "ds_billto_id"
INTO :ll_TargetCompany
FROM "disp_Ship"
WHERE"ds_id" = :ll_SourceID;
COMMIT;

IF ll_TargetCompany = 0 OR isNull (ll_TargetCompany )  THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	li_Return  = THIS.of_Addtransferrequest( ll_TargetCompany , ls_DocumentType , ll_SourceID , FALSE )
END IF
	
RETURN li_Return
end function

public function integer of_addtransferrequest (long al_targetcompany, string as_documenttype, long al_source, boolean ab_normalize, boolean ab_holdtransfer);Long		ll_ID
Int		li_Return = 1
String	ls_Type
Long		ll_Row
String	ls_Find
String	ls_HoldTransfer = "0"
Date		ld_ExpirationDate
Int		li_KeepDays
Int	li_SetRtn

DataStore	lds_Cache

lds_Cache = THIS.of_GetDocumentqueuecache( )
gnv_app.of_Getnextid( "documenttransfer", ll_id ,TRUE )

IF ab_holdtransfer THEN
	ls_HoldTransfer = "1"
END IF

IF ab_normalize THEN
// normalize the document type
  SELECT "companydocumentmapping"."ptdocument"  
    INTO :ls_Type  
    FROM "companydocumentmapping"  
   WHERE ( "companydocumentmapping"."targetcompanyid" = :al_TargetCompany ) AND  
         ( "companydocumentmapping"."targetcompanydocument" = :as_documenttype )   ;
	Commit;
ELSE
	ls_Type = as_documenttype
END IF


IF Len ( ls_Type ) > 0 THEN
	
	  SELECT "companydocumenttransfersettings"."daystokeepactive"  
    INTO :li_KeepDays  
    FROM "companydocumenttransfersettings"  
   WHERE "companydocumenttransfersettings"."coid" = :al_TargetCompany   ;

	IF SQLCA.Sqlcode = 0 THEN
		COMMIT;
	ELSE
		ROLLBACK;
	END IF
	
	IF li_KeepDays > 0 THEN
		ld_ExpirationDate = RelativeDate ( Today ( ) , li_KeepDays )
	ELSE
		SetNull ( ld_ExpirationDate )
	END IF
	
END IF


IF Len ( ls_Type ) > 0 THEN
	// see if the entry exists
	ls_Find = "TargetCompany = " + String ( al_TargetCompany ) + " AND SourceID = " + String ( al_Source ) + " And documenttype = '" + ls_Type + "'" 
	ll_Row = lds_Cache.Find ( ls_Find, 1 , lds_Cache.RowCount() )
	IF ll_Row = 0 THEN		
		ll_Row = lds_Cache.InsertRow ( 0 ) 
		IF ll_Row > 0 THEN
			li_SetRtn = lds_Cache.SetItem ( ll_Row ,"id"  ,ll_id  ) 
			li_SetRtn = lds_Cache.SetItem ( ll_Row ,"targetcompany"  , al_TargetCompany ) 
			li_SetRtn = lds_Cache.SetItem ( ll_Row , "documenttype" , ls_Type ) 
			li_SetRtn = lds_Cache.SetItem ( ll_Row , "sourceid" ,al_Source) 
//			li_SetRtn = lds_Cache.SetItem ( ll_Row , "holdtransfer" ,ls_HoldTransfer) 
			li_SetRtn = lds_Cache.SetItem ( ll_Row , "Datesubmitted" ,Today()) 
			li_SetRtn = lds_Cache.SetItem ( ll_Row , "timesubmitted" ,Now()) 
			li_SetRtn = lds_Cache.SetItem ( ll_Row , "addedby" ,gnv_app.of_getuserid( ) ) 
		END IF
	ELSE
		li_Return = ci_Noaction
	END IF
	
	li_SetRtn = lds_Cache.SetItem ( ll_Row , "holdtransfer" ,ls_HoldTransfer) 
	// we are going to reset the clock if we get another request.
	li_SetRtn = lds_Cache.SetItem ( ll_Row , "expirationdate" , ld_ExpirationDate ) 	
	
ELSE 
	li_Return = -1
END IF
	

RETURN li_Return
end function

public function integer of_gettransferdocumentsforcompany (long al_company, ref string asa_types[], ref boolean aba_holdstatus[]);Int	li_Return
String	ls_Temp
String	lsa_Types[]
Boolean	lba_Hold[]
String	ls_Hold
Int	li_Count

 DECLARE Cur_TransferTypes CURSOR FOR  
  SELECT "companydocumentmapping"."ptdocument"  ,
 			"companydocumentmapping"."holdtransfer"  
    FROM "companydocumentmapping"  
   WHERE ( "companydocumentmapping"."targetcompanyid" = :al_company ) AND  
         ( "companydocumentmapping"."send" = '1' )   
           ;
  OPEN Cur_TransferTypes;

do while sqlca.sqlcode = 0
	
	FETCH Cur_TransferTypes INTO :ls_Temp , :ls_Hold ;
	
	if sqlca.sqlcode = 0 then
		li_Count ++
		lsa_Types[li_Count] = ls_Temp
		IF ls_Hold = "1" THEN
			lba_Hold[li_Count] = TRUE
		ELSE
			lba_Hold[li_Count] = FALSE
		END IF
	END IF
LOOP		

CLOSE Cur_TransferTypes;
Commit;

asa_types[] = lsa_Types
aba_holdstatus[] = lba_Hold

RETURN li_Count
end function

public function integer of_showdocumentqueue (long al_sourceid, string as_sourcetype);n_cst_msg	lnv_Msg
s_Parm	lstr_Parm

lstr_Parm.ia_Value = al_sourceid
CHOOSE CASE as_sourcetype
		
	CASE "COMPANY"
		lstr_Parm.is_label = "COMPANYID"
	CASE "SHIPMENT"
		lstr_Parm.is_label = "SHIPMENTID"
END CHOOSE


lnv_Msg.of_Add_Parm ( lstr_Parm )
OpenWithParm ( w_documenttransferqueue , lnv_msg )
RETURN 1
end function

public function integer of_removeexpiredrequests ();Int	li_Return
Long	ll_DocCount
Long	i

DataStore	lds_Queue
lds_Queue = THIS.of_Getdocumentqueuecache( )

li_Return = ci_success

ll_DocCount = lds_Queue.retrieve( )
IF ll_DocCount < 0 THEN
	li_Return = ci_failure
	THIS.of_AddError( "An error occurred while attempting to retrieve queued documents.")
END IF

IF li_Return = ci_success THEN
Int	li_SetRtn
	li_SetRtn = lds_Queue.SetFilter ( "expirationdate <= Date ( Today()) and holdtransfer = '0'" )
	lds_Queue.Filter ( )
	ll_DocCount = lds_Queue.RowCount( )
	FOR i = ll_DocCount TO 1 STEP -1
		lds_Queue.Deleterow( i )
	NEXT
	
END IF


THIS.event pt_save( )

lds_Queue.SetFilter ( "" )
lds_Queue.Filter( )

RETURN li_Return 
end function

public function integer of_addtransferrequestforcurrentshipments (long al_billto);Long	ll_ShipmentID
Int	li_Return = 1
Long	ll_Count
Long	i
Long	lla_Ids[]


 DECLARE cur_shipments CURSOR  FOR  
  SELECT "current_shipment_list"."ds_id"  
    FROM "current_shipment_list"  
   WHERE "current_shipment_list"."ds_billto_id" = :al_BillTo  ;

OPEN cur_shipments ;

do while sqlca.sqlcode = 0
	
	FETCH cur_shipments INTO :ll_ShipmentID ;
	
	if sqlca.sqlcode = 0 then
		ll_Count ++
		lla_Ids[ll_Count] = ll_ShipmentID
	END IF
LOOP		

CLOSE cur_shipments;
Commit;

FOR i = 1 TO ll_Count
	IF THIS.of_Addtransferrequestforcompany( al_billto , lla_Ids[i] ) <> 1 THEN
		li_Return = -1
	END IF
NEXT


RETURN li_Return
 
end function

on n_cst_bso_document_manager.create
call super::create
end on

on n_cst_bso_document_manager.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_documentqueue = CREATE DataStore
ids_Documentqueue.DataObject = "d_documentqueue"
ids_Documentqueue.SetTransObject ( SQLCA )

ids_documenthistory = CREATE DataStore
ids_documenthistory.DataObject = "d_documenttransferhistory"
ids_documenthistory.SetTransObject ( SQLCA )


//ids_documentqueue.Retrieve ( )
end event

event pt_save;call super::pt_save;Int	li_Return

IF ids_documentqueue.Update () = 1 THEN
	li_Return = 1
	COMMIT;
ELSE
	ROLLBACK;
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF ids_documenthistory.Update ( ) = 1 THEN
		li_Return = 1
		COMMIT;
	ELSE
		ROLLBACK;
		li_Return = -1
	END IF
END IF

RETURN li_Return
end event

event destructor;call super::destructor;DESTROY ( ids_documenthistory )
DESTROY ( ids_documentqueue )
end event

