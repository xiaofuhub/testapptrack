$PBExportHeader$n_cst_document_tif.sru
$PBExportComments$[n_base] Ancestor of all Document objects
forward
global type n_cst_document_tif from n_cst_document
end type
end forward

global type n_cst_document_tif from n_cst_document
end type
global n_cst_document_tif n_cst_document_tif

forward prototypes
public function integer of_getpagecount ()
end prototypes

public function integer of_getpagecount ();Int	li_Return = 1
Int	li_NumberPages

n_cst_imagingversioncontrol		lnv_Version
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
oleObject								lnv_CountOle

lnv_ImageManager 	= CREATE n_cst_bso_ImageManager_pegasus
lnv_CountOle 		= Create oleObject

IF li_Return = 1 THEN
	IF lnv_ImageManager.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Version.of_unlock( )
END IF

IF li_Return = 1 THEN
	IF lnv_CountOle.ConnectToNewObject (lnv_Version.of_getimagexpressobjectstring( ) ) <> 0 THEN
		li_Return = -1
	END IF
END IF
IF li_Return = 1 THEN
	li_NumberPages = lnv_CountOle.NumPages ( THIS.of_getpathfilename( ) ) 
END IF
IF li_Return = -1 THEN
	li_NumberPages = -1
END IF
	
RETURN li_NumberPages
end function

on n_cst_document_tif.create
call super::create
end on

on n_cst_document_tif.destroy
call super::destroy
end on

