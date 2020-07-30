$PBExportHeader$n_cst_transferdocument_ftp.sru
forward
global type n_cst_transferdocument_ftp from n_cst_transferdocument
end type
end forward

global type n_cst_transferdocument_ftp from n_cst_transferdocument
end type
global n_cst_transferdocument_ftp n_cst_transferdocument_ftp

forward prototypes
public function integer of_executetransfer ()
end prototypes

public function integer of_executetransfer ();String	ls_Folder
String	ls_Source
String	ls_Target
String	ls_TranferFileName
Int		li_Return = 1
Int		li_CopyReturn

ls_Folder = inv_documentsettings.of_Gettargetaddress( )
ls_TranferFileName = inv_Documentsettings.of_Getfilename( inv_document )
is_transferedfilename = ls_TranferFileName


IF Right ( ls_Folder, 1 ) <> "\" THEN
	ls_Folder += "\" 
END IF

ls_Target = ls_Folder + ls_TranferFileName
ls_Source = inv_Document.of_Getpathfilename( )

li_CopyReturn = FileCopy ( ls_Source , ls_Target , TRUE )
IF li_CopyReturn <> 1 THEN
	li_Return = -1
END IF



RETURN li_Return


end function

on n_cst_transferdocument_ftp.create
call super::create
end on

on n_cst_transferdocument_ftp.destroy
call super::destroy
end on

