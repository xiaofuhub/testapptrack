$PBExportHeader$n_cst_transferdocument.sru
forward
global type n_cst_transferdocument from n_base
end type
end forward

global type n_cst_transferdocument from n_base
end type
global n_cst_transferdocument n_cst_transferdocument

type variables
PRIVATE:
String	isa_Errors[]
Int		ii_ErrorCount

Protected:
Long	il_ID
String	is_TransferedFileName
n_cst_Document	inv_Document
n_Cst_DocumentSettings	inv_DocumentSettings

end variables

forward prototypes
public function integer of_executetransfer ()
protected function integer of_establishconnection ()
public function integer of_setdocument (n_cst_document anv_document)
public function integer of_setdocumentsettings (n_cst_documentsettings anv_settings)
public function string of_geterrorstring ()
protected function integer of_recordtransfer ()
protected function integer of_adderror (string as_errormessage)
public function string of_getfilename ()
public function long of_getrequestid ()
public function integer of_setrequestid (long al_id)
public function integer of_getpagecount ()
public function string of_getnametransfered ()
end prototypes

public function integer of_executetransfer ();RETURN -1
end function

protected function integer of_establishconnection ();RETURN -1
end function

public function integer of_setdocument (n_cst_document anv_document);IF isValid ( inv_document ) THEN
	DESTROY ( inv_Document )
END IF
inv_Document = anv_document

RETURN 1
end function

public function integer of_setdocumentsettings (n_cst_documentsettings anv_settings);IF isValid ( inv_documentsettings ) THEN
	DESTROY (inv_documentsettings)
END IF
inv_Documentsettings = anv_settings
RETURN 1
end function

public function string of_geterrorstring ();String	ls_Return
n_CSt_String	lnv_String

lnv_String.of_Arraytostring( isa_errors , "~r~n",ls_Return )

RETURN ls_Return
end function

protected function integer of_recordtransfer ();int	li_Return

RETURN li_Return
end function

protected function integer of_adderror (string as_errormessage);ii_Errorcount ++
isa_errors[ii_errorcount] = as_errormessage
RETURN 1
end function

public function string of_getfilename ();RETURN inv_Document.of_GetFilename( )
end function

public function long of_getrequestid ();RETURN il_id
end function

public function integer of_setrequestid (long al_id);il_ID = al_ID
RETURN 1
end function

public function integer of_getpagecount ();RETURN inv_Document.of_GetPagecount( )
end function

public function string of_getnametransfered ();RETURN is_transferedfilename
end function

on n_cst_transferdocument.create
call super::create
end on

on n_cst_transferdocument.destroy
call super::destroy
end on

