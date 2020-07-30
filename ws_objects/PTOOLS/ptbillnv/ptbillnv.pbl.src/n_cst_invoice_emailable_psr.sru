$PBExportHeader$n_cst_invoice_emailable_psr.sru
forward
global type n_cst_invoice_emailable_psr from n_cst_invoice_emailable
end type
end forward

shared variables
//begin modification Shared Variables by appeon  20070730

//n_ds	sds_Source//modified global variables, but duplicate n_cst_invoice_psr_manifest
//Int			si_Count
//end modification Shared Variables by appeon  20070730
end variables

global type n_cst_invoice_emailable_psr from n_cst_invoice_emailable
end type
global n_cst_invoice_emailable_psr n_cst_invoice_emailable_psr

type variables
//begin modification Shared Variables by appeon  20070730

//n_ds	sds_Source//modified global variables, but duplicate n_cst_invoice_psr_manifest
Int			si_Count
//end modification Shared Variables by appeon  20070730
end variables

forward prototypes
protected function integer of_initailizedatasource ()
protected function boolean of_usearray ()
public function integer of_getinvoicefile (ref string as_file)
end prototypes

protected function integer of_initailizedatasource ();Int		li_Return = -1
String	ls_Template
IF Not IsValid ( sds_source ) THEN
	
	ls_Template = THIS.of_GetSourcefile( )
	
	// verrify that it is a .psr
	IF Upper ( Right (  TRIM ( ls_Template ) , 4 ) ) = ".PSR" THEN
		// set it on the source
		sds_source = CREATE n_ds
		sds_source.DataObject = ls_Template
		sds_source.SetTransObject ( SQLCA )
	END IF


END IF

IF IsValid ( sds_source ) THEN
	IF Len ( sds_source.DataObject ) > 0 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

protected function boolean of_usearray ();Boolean	lb_Return
String	lsa_ArgNames[]
String	lsa_ArgTypes[]

n_Cst_Dssrv	lnv_Dssrv
lnv_Dssrv = CREATE n_Cst_dssrv
lnv_Dssrv.of_SetRequestor( sds_source )

IF lnv_Dssrv.of_dwarguments( lsa_ArgNames, lsa_ArgTypes ) > 0 THEN
	lb_Return = Upper ( lsa_ArgTypes[1] ) = "NUMBERLIST"
END IF

Destroy ( lnv_Dssrv )

RETURN lb_Return
end function

public function integer of_getinvoicefile (ref string as_file);/***************************************************************************************
NAME: 	of_GetInvoiceFile	

ACCESS:	Public
		
ARGUMENTS: (ref as_file)

RETURNS:		Integer
	
DESCRIPTION:
		Creates a Directory Path (if it doesnt already exist) and FileName for the current Invoice
		
		Returns 1 if invoice file path is valid
		Return -1 if invoice file could not be created
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : 
			Created 11/28/05 - Maury
***************************************************************************************/
Integer	li_Return = 1
String	ls_Directory
String	ls_FilePath
String	ls_FileName
String	ls_NamingSchema
String	ls_Return
String	ls_ErrorMsg
Long		ll_SourceShipment
Long		ll_RetrieveRtn
Integer	li_Save
Integer	li_ProcessString
Any		laa_Beo[]


n_cst_FileSrvWin32		lnv_FileSrv
n_cst_DocumentSettings  lnv_doc

lnv_FileSrv = Create n_cst_FileSrvWin32

ls_ErrorMsg = "Error when gettting invoice file."

//Retrieve Source Invoice File
IF li_Return = 1 THEN
	ll_SourceShipment = This.of_GetSourceShipmentId( )
	IF ll_SourceShipment > 0 THEN
		IF This.of_UseArray ( ) THEN
			ll_RetrieveRtn = sds_source.Retrieve( {ll_SourceShipment} )
		ELSE
			ll_RetrieveRtn = sds_source.Retrieve( ll_SourceShipment )
		END IF
		
		IF ll_RetrieveRtn <= 0 THEN
			ls_ErrorMsg = "Failed to retrieve source invoice file for shipment number " + String(ll_SourceShipment)
			li_Return = -1	
		END IF
		
		Commit;
	ELSE 
		ls_ErrorMsg = "Invalid shipment id when attempting to access invoice file."
		li_Return = -1
	END IF
END IF

//Create Folder for invoice file
IF li_Return = 1 THEN
	ls_Directory = cs_FILEPATH
	IF NOT lnv_FileSrv.of_Directoryexists(ls_Directory) THEN
		IF lnv_FileSrv.of_CreateFolder(ls_Directory) <> 1 THEN
			ls_ErrorMsg = "Invoice target folder " + ls_Directory + " could not be created for shipment number " + String(ll_SourceShipment) + "."
			li_Return = -1
		END IF
	END IF
END IF

//Process Invoice name from Naming Schema
IF li_Return = 1 THEN
	IF isValid(inv_EISettings) THEN
		ls_NamingSchema = inv_EISettings.of_GetInvoiceNamingSchema()
		IF isNull(ls_NamingSchema) OR Len(ls_NamingSchema) < 1 THEN
			ls_NamingSchema = "Invoice_<tmp>.pdf"
		END IF
		IF Right(ls_NamingSchema, 4) <> ".pdf" THEN
			ls_NamingSchema += ".pdf"
		END IF
		
		li_ProcessString = This.of_BuildStringFromSchema(ls_NamingSchema, ls_FileName)
		IF li_ProcessString <> 1 THEN
			ls_ErrorMsg = "Could not process a file name for naming schema " + ls_NamingSchema + " for shipment id " + String(ll_SourceShipment) + "."
			li_Return = -1
		END IF
	ELSE
		li_Return = -1
	END IF
END IF

//Save Invoice File
IF li_Return = 1 THEN
	ls_FilePath = ls_Directory + ls_FileName
	sds_Source.Object.DataWindow.Export.PDF.Method = Distill!
	li_Save = sds_Source.SaveAs(ls_FilePath, PDF!, True)
	IF li_Save = 1 THEN
		as_File = ls_FilePath
	ELSE
		ls_ErrorMsg = "Failed to save " + ls_FileName + " to " + ls_Directory + " for shipment id " + String(ll_SourceShipment) + "."
		li_Return = -1
	END IF
END IF
	
IF li_Return <> 1 THEN
	THIS.of_Adderror( ls_ErrorMsg )
END IF

Destroy lnv_FileSrv

Return li_Return

end function

on n_cst_invoice_emailable_psr.create
call super::create
end on

on n_cst_invoice_emailable_psr.destroy
call super::destroy
end on

event destructor;call super::destructor;si_count --
IF si_count = 0 THEN
	Destroy ( sds_source ) 
END IF
end event

event constructor;call super::constructor;si_Count ++
end event

