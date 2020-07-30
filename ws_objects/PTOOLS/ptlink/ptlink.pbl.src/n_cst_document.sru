$PBExportHeader$n_cst_document.sru
$PBExportComments$[n_base] Ancestor of all Document objects
forward
global type n_cst_document from n_base
end type
end forward

global type n_cst_document from n_base
end type
global n_cst_document n_cst_document

type variables
Constant Integer 	ci_Success      =  1
Constant Integer 	ci_Failure         = -1
Protected:
String 		is_DocumentType
String		is_Text
String		is_Template
String		is_Source
String		is_CompanyCode
String		is_FileName
String		is_FileNameList[]
String		is_FileExtension
String		is_PathFileName
String		is_Path
String		is_AcceptDeny
String		is_ReferNumber
Long		il_CompanyId
Long		il_ShipmentId
DateTime		idt_FileDateTime
Boolean                   ib_Email
pt_n_cst_beo 	inv_beo

end variables

forward prototypes
public function integer of_setdocumenttype (string as_document)
public function string of_getdocumenttype ()
public function integer of_settext (string as_text)
public function pt_n_cst_beo of_getbeo ()
public function integer of_setbeo (pt_n_cst_beo anv_beo)
public function long of_getcompanyid ()
public function integer of_setcompanyid (long al_companyid)
public function string of_gettext ()
public function string of_gettemplatename ()
public function integer of_settemplatename (string as_templatename)
public function integer of_setshipmentid (unsignedlong al_shipmentid)
public function long of_getShipmentid ()
public function integer of_setfilename (string as_filename)
public function string of_getfilename ()
public function integer of_addfilename (string as_Filename)
public function integer of_setfilenamelist (string as_FileList[])
public function integer of_setpathfilename (string as_pathfilename)
public function string of_getpathfilename ()
public function datetime of_getfiledatetime ()
public function integer of_SetFileDateTime (datetime adt_file)
public function integer of_setpath (string as_path)
public function String of_getpath ()
public function boolean of_isemail ()
public subroutine of_isemail (boolean ab_Email)
public function string of_getacceptdeny ()
public function integer of_setcompanycode (string as_companycode)
public function string of_getcompanycode ()
public function integer of_getpagecount ()
end prototypes

public function integer of_setdocumenttype (string as_document);/***************************************************************************************
NAME			: of_SetDocumentType
ACCESS		: Public
ARGUMENTS	: String  = Document type
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Sets the document type (Event, Accessorial Note, LFD, TIR, Authorization)

REVISION		: RDT 09-26-02
***************************************************************************************/
Integer li_Return  
li_Return  = ci_Failure

If IsNull( as_document ) Then 
	//  do nothing
Else
	is_documenttype = as_document
	li_Return = ci_Success
End If

Return li_Return
end function

public function string of_getdocumenttype ();/***************************************************************************************
NAME			: of_GetDocumentType
ACCESS		: Public
ARGUMENTS	: none
RETURNS		: is_documentType
DESCRIPTION	: Returns the is_document if set, otherwise it gets it from the BEO 

REVISION		: RDT 092602
***************************************************************************************/

If len( Trim( is_DocumentType ) ) < 1 Then 

	If isValid( inv_beo ) Then 
		is_DocumentType = inv_beo.of_GetDocumentType( ) 
	End If

End If

If len( Trim( is_DocumentType ) ) < 1 Then 
	MessageBox("Program Error n_cst_document.of_GetDocumentType()", "is_Document Type not set or found on BEO.")
End If

Return is_DocumentType 



end function

public function integer of_settext (string as_text);/***************************************************************************************
NAME			: of_SetText
ACCESS		: public
ARGUMENTS	: String 
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Sets the text of the document

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return
li_Return = ci_success

If isNull( as_Text ) then
	is_Text = ''
Else
	is_Text = as_Text
End If

Return li_Return 

end function

public function pt_n_cst_beo of_getbeo ();/***************************************************************************************
NAME			: of_GetBeo
ACCESS		: Public
ARGUMENTS	: none
RETURNS		: pt_n_cst_beo
DESCRIPTION	: Gets beo associated with this document

REVISION		: RDT 09-26-02
***************************************************************************************/

Return inv_beo
end function

public function integer of_setbeo (pt_n_cst_beo anv_beo);/***************************************************************************************
NAME			: of_SetBEO
ACCESS		: public
ARGUMENTS	: pt_n_cst_Beo
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Sets the beo instance of the document

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return

li_Return  = ci_Failure

If IsNull(anv_beo) Then 
	//  do nothing 
Else
	inv_beo = anv_beo
	li_Return = ci_Success
End If

Return li_Return 
end function

public function long of_getcompanyid ();/***************************************************************************************
NAME			: of_GetCompanyId
ACCESS		: public
ARGUMENTS	: none
RETURNS		: Company ID
DESCRIPTION	: 

REVISION		: rdt 092602
***************************************************************************************/

Return il_companyid
end function

public function integer of_setcompanyid (long al_companyid);/***************************************************************************************
NAME			: of_SetCompanyId
ACCESS		: public
ARGUMENTS	: Long (Company ID)
RETURNS		: ci_Success, ci_failure
DESCRIPTION	: 

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return

li_Return  = ci_Failure

If IsNull(al_CompanyId) Then 
	// do nothing
Else
	il_companyid = al_CompanyId
	li_Return = ci_Success
End If

Return li_Return  
end function

public function string of_gettext ();/***************************************************************************************
NAME			: of_GetText
ACCESS		: public
ARGUMENTS	: none
RETURNS		: Document text
DESCRIPTION	: 

REVISION		: rdt 092602
***************************************************************************************/

Return is_text
end function

public function string of_gettemplatename ();/***************************************************************************************
NAME			: of_GetTemplateName
ACCESS		: public
ARGUMENTS	: none
RETURNS		: Template Name
DESCRIPTION	: Returns the template name associated with this document

REVISION		: rdt 092602
***************************************************************************************/
return is_template
end function

public function integer of_settemplatename (string as_templatename);/***************************************************************************************
NAME			: of_SetTemplateName
ACCESS		: Public
ARGUMENTS	: Template name (String)
RETURNS		: ci_success, ci_failure
DESCRIPTION	: 

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return

li_Return  = ci_Failure

If IsNull(as_TemplateName) Then 
	//  do nothing 
Else
	is_template = as_TemplateName
	li_Return 	= ci_Success
End If

Return li_Return 
end function

public function integer of_setshipmentid (unsignedlong al_shipmentid);/***************************************************************************************
NAME			: of_SetShipment
ACCESS		: public
ARGUMENTS	: ULong (Shipment Number)
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Sets the shipment number to the value passed in	

REVISION		: RDT 092602
***************************************************************************************/

Integer li_Return

li_Return  = ci_Failure

If IsNull(al_ShipmentId) Then 
	// do nothing
Else
	il_ShipmentId = al_ShipmentId
	li_Return = ci_Success
End If

Return li_Return  

end function

public function long of_getShipmentid ();/***************************************************************************************
NAME			: of_GetCompanyId
ACCESS		: public
ARGUMENTS	: none
RETURNS		: Shipment ID
DESCRIPTION	: 

REVISION		: rdt 092602
***************************************************************************************/

Return il_shipmentid
end function

public function integer of_setfilename (string as_filename);//
/***************************************************************************************
NAME			: of_SetFileName
ACCESS		: Public
ARGUMENTS	: String (File Name)
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Set instance variable to the argument

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return  
li_Return  = ci_Failure

If IsNull( as_filename) Then 
	//  do nothing
Else
	is_filename = as_filename
	li_Return = ci_Success
End If

Return li_Return

end function

public function string of_getfilename ();//
/***************************************************************************************
NAME			: of_GetFileName
ACCESS		: Public
ARGUMENTS	: none 
RETURNS		: is_fileName
DESCRIPTION	: Get instance variable is_fileName

REVISION		: rdt 092602
***************************************************************************************/

Return is_filename 

end function

public function integer of_addfilename (string as_Filename);/***************************************************************************************
NAME			: of_AddFileName
ACCESS		: public
ARGUMENTS	: String (File Name)
RETURNS		: ci_failure, ci_success
DESCRIPTION	: Adds the string argument to the File name array. 

REVISION		: rdt 092602
***************************************************************************************/
integer li_Return 

li_Return = ci_failure

If IsNull( as_Filename ) then
	// do nothing. li_Return already set to ci_failure
Else
	is_filenamelist[ UpperBound( is_filenamelist[] ) + 1 ] = as_Filename
	li_Return = ci_success
End If

Return li_Return
end function

public function integer of_setfilenamelist (string as_FileList[]);//
/***************************************************************************************
NAME			: of_SetFileNameList
ACCESS		: public
ARGUMENTS	: String Array (File List)
RETURNS		: Integer 		(ci_success, ci_failure)
DESCRIPTION	: 

REVISION		: RDT 092602
***************************************************************************************/
is_filenamelist[] = as_FileList[]
Return ci_success
end function

public function integer of_setpathfilename (string as_pathfilename);//
/***************************************************************************************
NAME			: of_SetPathFileName
ACCESS		: Public
ARGUMENTS	: String (Full Path and File Name)
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Set instance variable to the argument

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return  
li_Return  = ci_Failure

If IsNull( as_pathfilename) Then 
	//  do nothing
Else
	is_pathfilename = as_pathfilename
	li_Return = ci_Success
End If

Return li_Return

end function

public function string of_getpathfilename ();//
/***************************************************************************************
NAME			: of_GetPathFileName
ACCESS		: Public
ARGUMENTS	: none 
RETURNS		: is_PathFileName 
DESCRIPTION	: Get instance variable is_PathFileName 

REVISION		: rdt 092602
***************************************************************************************/

Return is_PathFileName 

end function

public function datetime of_getfiledatetime ();//
/***************************************************************************************
NAME			: of_GetFileDateTime
ACCESS		: Public
ARGUMENTS	: none 
RETURNS		: DateTime 	(idt_filedatetime)
DESCRIPTION	: Get instance variable idt_filedatetime

REVISION		: rdt 092602
***************************************************************************************/

Return idt_filedatetime

end function

public function integer of_SetFileDateTime (datetime adt_file);//
/***************************************************************************************
NAME			: of_SetFileDateTime
ACCESS		: Public
ARGUMENTS	: DateTime (File Create date and time)
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Set instance variable to the argument

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return  
li_Return  = ci_Failure

If IsNull( adt_file) Then 
	//  do nothing
Else
	idt_filedatetime = adt_file
	li_Return = ci_Success
End If

Return li_Return

end function

public function integer of_setpath (string as_path);//
/***************************************************************************************
NAME			: of_SetPath
ACCESS		: Public
ARGUMENTS	: String (Full Path ) NO FILE NAME
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Set instance variable to the argument

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return  
li_Return  = ci_Failure

If IsNull( as_path) Then 
	//  do nothing
Else
	is_path = as_path
	li_Return = ci_Success
End If

Return li_Return

end function

public function String of_getpath ();//
/***************************************************************************************
NAME			: of_GetPath
ACCESS		: Public
ARGUMENTS	: none
RETURNS		: String (Full Path ) NO FILE NAME
DESCRIPTION	: 
REVISION		: rdt 092602
***************************************************************************************/

Return is_path 

end function

public function boolean of_isemail ();Return ib_email
end function

public subroutine of_isemail (boolean ab_Email);
// Sets variable
ib_email = ab_Email
end subroutine

public function string of_getacceptdeny ();return is_AcceptDeny
end function

public function integer of_setcompanycode (string as_companycode);//
/***************************************************************************************
NAME			: of_SetCompanyCode
ACCESS		: Public
ARGUMENTS	: String (Co. Code)
RETURNS		: ci_success, ci_failure
DESCRIPTION	: Set instance variable to the argument

REVISION		: rdt 092602
***************************************************************************************/
Integer li_Return  
li_Return  = ci_Failure

If IsNull( as_companycode) Then 
	//  do nothing
Else
	is_CompanyCode= as_CompanyCode
	li_Return = ci_Success
End If

Return li_Return

end function

public function string of_getcompanycode ();/***************************************************************************************
NAME			: of_GetCompanyCode
ACCESS		: public
ARGUMENTS	: none
RETURNS		: Company ID
DESCRIPTION	: 

REVISION		: rdt 092602
***************************************************************************************/

Return is_CompanyCode
end function

public function integer of_getpagecount ();




RETURN 1
end function

on n_cst_document.create
call super::create
end on

on n_cst_document.destroy
call super::destroy
end on

