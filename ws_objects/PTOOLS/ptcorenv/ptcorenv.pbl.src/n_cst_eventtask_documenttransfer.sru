$PBExportHeader$n_cst_eventtask_documenttransfer.sru
forward
global type n_cst_eventtask_documenttransfer from n_cst_eventtask
end type
end forward

global type n_cst_eventtask_documenttransfer from n_cst_eventtask
end type
global n_cst_eventtask_documenttransfer n_cst_eventtask_documenttransfer

forward prototypes
public function integer of_execute ()
end prototypes

public function integer of_execute ();Int	li_Return
String	ls_Result
Int	i
Int	li_ErrorCount

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_licensemanager	lnv_LicenseManager

IF NOT lnv_LicenseManager.of_hasdocumentttansfer( ) THEN  // EARLY RETURN HERE //\\//\\//\\//\\
	THIS.of_Setprocessingresult( ci_result_error )
	THIS.of_Setresultstring( "Document Transfer is not licensed." )
	THIS.of_Disableevent( )
	RETURN 0	
END IF



n_Cst_bso_Document_Manager	lnv_DocMan
lnv_DocMan = CREATE n_Cst_bso_Document_Manager

li_Return = ci_result_success

lnv_DocMan.clearofrerrors( )
IF lnv_docMan.of_Transferqueueddocuments( ) <> 1 THEN
	li_Return = ci_result_error
	lnv_ErrorCollection = lnv_DocMan.getofrerrorcollection( )
	lnv_Errorcollection.GetErrorArray( lnva_Error )	
	li_ErrorCount = lnv_Errorcollection.geterrorcount( )

	For i = 1 TO li_ErrorCount
		ls_Result = string( lnva_Error[i].getErrorMessage() ) + "~r~n"
	next

ELSE
	ls_Result = "Document transfer was successful."
END IF

THIS.of_Setprocessingresult( li_Return )
THIS.of_Setresultstring( ls_Result )


lnv_DocMan.of_Removeexpiredrequests( )


DESTROY ( lnv_DocMan )

RETURN 1
end function

event constructor;call super::constructor;is_taskdescription = 'This is the process that will transfer documents.'
is_Tabpagelabel = "Document Transfer"
is_eventname = "ptev_documenttransfer"
is_schedulename = "ptsch_documenttransfer"
is_Procedurename = "ptsp_documenttransfer"
end event

on n_cst_eventtask_documenttransfer.create
call super::create
end on

on n_cst_eventtask_documenttransfer.destroy
call super::destroy
end on

