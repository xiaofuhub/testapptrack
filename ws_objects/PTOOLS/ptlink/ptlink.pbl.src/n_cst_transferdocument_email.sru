$PBExportHeader$n_cst_transferdocument_email.sru
forward
global type n_cst_transferdocument_email from n_cst_transferdocument
end type
end forward

global type n_cst_transferdocument_email from n_cst_transferdocument
end type
global n_cst_transferdocument_email n_cst_transferdocument_email

type variables
Private:
n_cst_bso_Email_Manager	inv_EmailMan
end variables

forward prototypes
public function integer of_executetransfer ()
private function n_cst_emailmessage of_populateemail ()
public function string of_getnametransferedas ()
end prototypes

public function integer of_executetransfer ();Int	li_Return
String	ls_Error
n_cst_emailmessage	lnv_EmailMessage

li_Return = 1
lnv_EmailMessage = THIS.of_Populateemail( )



IF inv_emailman.of_sendmail( lnv_EmailMessage ) <> 1 THEN
	ls_Error = "An error occurred while attempting send mail message.~r~n" + inv_emailman.of_Geterrorstring( )
	THIS.of_Adderror( ls_Error )
	li_Return = -1
END IF



RETURN li_Return
end function

private function n_cst_emailmessage of_populateemail ();String	ls_Target
String	ls_Subject
String	ls_File
String	ls_TranferFileName

n_cst_EmailMessage	lnv_EmailMessage
mailFileDescription lnv_Attachment[]

ls_Subject = inv_Documentsettings.of_GetsubjectLine( inv_document )
IF isNull ( ls_Subject ) THEN
	ls_Subject = ""
END IF

ls_Target = inv_documentsettings.of_Gettargetaddress( )
lnv_EmailMessage.of_Addtargetaddress( ls_Target )
lnv_EmailMessage.of_SetSubject( ls_Subject )

ls_TranferFileName = inv_Documentsettings.of_Getfilename( inv_document )
is_transferedfilename = ls_TranferFileName

ls_File = inv_document.of_getpathFilename( )
// we will have to name the file in different ways before we attach it

lnv_Attachment[1].FileType = MailAttach!
lnv_Attachment[1].FileName = ls_TranferFileName // this is the one that matches the Schema
lnv_Attachment[1].pathName = ls_File
lnv_Attachment[1].position = 0
	
	
lnv_EmailMessage.of_ProcessAttachments ( lnv_Attachment )
	

RETURN lnv_EmailMessage

end function

public function string of_getnametransferedas ();RETURN is_transferedfilename
end function

on n_cst_transferdocument_email.create
call super::create
end on

on n_cst_transferdocument_email.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_emailman = CREATE n_cst_bso_email_manager
end event

event destructor;call super::destructor;
Destroy ( inv_emailman )
end event

