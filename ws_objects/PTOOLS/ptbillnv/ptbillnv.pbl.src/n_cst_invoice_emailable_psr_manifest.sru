$PBExportHeader$n_cst_invoice_emailable_psr_manifest.sru
forward
global type n_cst_invoice_emailable_psr_manifest from n_cst_invoice_emailable_psr
end type
end forward

shared variables
//begin modification Shared Variables by appeon  20070730

//n_ds	sds_Source//modified global variables, but duplicate n_cst_invoice_psr_manifest
//Int			si_Count
//end modification Shared Variables by appeon  20070730



end variables

global type n_cst_invoice_emailable_psr_manifest from n_cst_invoice_emailable_psr
end type
global n_cst_invoice_emailable_psr_manifest n_cst_invoice_emailable_psr_manifest

type variables
Long	ila_SourceShipmentIDs[]

//begin modification Shared Variables by appeon  20070730

////n_ds	sds_Source//modified global variables, but duplicate n_cst_invoice_psr_manifest
//Int			si_Count
////end modification Shared Variables by appeon  20070730
end variables

forward prototypes
public function integer of_setsourceshipmentids (long ala_shipids[])
public function integer of_getsourceshipmentids (ref long ala_shipids[])
public function integer of_attachimages (string asa_imagetypes[])
protected function integer of_initailizedatasource ()
public function long of_getbilltoid ()
public function integer of_setcurrentsourceshipmentid (long al_shipid)
public function integer of_buildstringfromschema (string as_schema, ref string as_filename, n_cst_msg anv_msg)
public function integer of_buildstringfromschema (string as_schema, ref string as_filename)
public function integer of_getinvoicefile (ref string as_file)
end prototypes

public function integer of_setsourceshipmentids (long ala_shipids[]);Integer	li_Return = -1

ila_SourceShipmentIds = ala_ShipIds

IF THIS.of_initailizedatasource( ) = 1 THEN
	li_Return = 1
END IF

RETURN li_Return


end function

public function integer of_getsourceshipmentids (ref long ala_shipids[]);ala_ShipIds = ila_SourceShipmentIds

Return 1
end function

public function integer of_attachimages (string asa_imagetypes[]);/***************************************************************************************
NAME: 		of_AttachImages			

ACCESS:		Public
		
ARGUMENTS:	(String asa_ImageTypes[])

RETURNS:		Integer
	
DESCRIPTION: 
				Returns number of attachments If Successful
				Returns -1 if Failiure
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 12/12/05 - Maury
***************************************************************************************/

String	ls_CurrentType
String	ls_Path
String	ls_FileNameFinal
String	ls_NamingSchema
Long		ll_ShipmentId
Long		lla_ShipmentIds[]
String	lsa_ImagePaths[]
String	lsa_EMPTY[]
Long		ll_AttNum
Long		ll_NumImages
Long		ll_NumShipments
Long		ll_Index3
Integer	li_Position = 0
Integer	li_Max
Integer	li_Index, li_Index2
Integer	li_Return = 1

n_cst_msg 	lnv_Msg
n_cst_bso_ImageManager_pegasus	lnv_ImageManager
n_cst_beo_ImageType		lnva_ImageTypes[]
n_cst_bcm					lnv_Bcm
n_cst_bcmService			lnv_bcmService
n_cst_beo_Company			lnv_Company



lnv_Company = Create n_cst_beo_Company
lnv_ImageManager = Create n_cst_bso_ImageManager_Pegasus

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )
IF Not isValid ( lnv_bcm )  THEN
	Return -1 									/////// MID CODE RETURN 
END IF

li_Max = UpperBound ( asa_ImageTypes )

ls_NamingSchema = inv_EISettings.of_GetImageNamingSchema()
IF isNull(ls_NamingSchema) OR Len(ls_NamingSchema) < 1 THEN
	ls_NamingSchema = "<tmp>_img.tif"
END IF
IF Right(ls_NamingSchema, 4) <> ".tif" THEN
	ls_NamingSchema += ".tif"
END IF

This.of_GetSourceShipmentIds(lla_ShipmentIds)
ll_NumShipments = UpperBound(lla_ShipmentIds)

FOR li_index = 1 TO li_Max 
	ls_CurrentType = asa_ImageTypes[ li_Index ]
	
	inv_EISettings.of_ProcessSpecialTagsForEI(ls_NamingSchema, ls_CurrentType, lnv_Msg) //lnv_msg will get special tag by ref
	
	lnv_bcmService.of_getallbeo ( lnv_bcm, "imagetype_type = '"  + ls_CurrentType + "'" , lnva_ImageTypes )
	
	FOR ll_Index3 = 1 TO ll_NumShipments
		ll_ShipmentId = lla_ShipmentIds[ll_Index3]
		//Temporarily set source shipment id (has same effect of calling of_SetSourceShipmentId without calling of_initializedatasource()
		This.of_SetCurrentSourceShipmentId(ll_ShipmentId)
		
		lsa_ImagePaths = lsa_EMPTY
		lnv_ImageManager.of_GetImagelist( lnva_ImageTypes, {ll_ShipmentId}, lsa_ImagePaths )
		
		ll_NumImages = upperBound ( lsa_ImagePaths )

		FOR li_Index2 = 1 TO ll_NumImages
			ls_Path = lsa_ImagePaths[ll_NumImages]
			IF lnv_ImageManager.of_DoesImageExist ( ls_Path ) THEN
				
				IF This.of_BuildStringFromSchema(ls_NamingSchema, ls_FileNameFinal, lnv_Msg) <> 1 THEN
					li_Return = -1
				END IF
				
				IF li_Return = 1 THEN
					li_Position ++ //Should start at position 1 because invoice pdf is at postion 0
					ll_AttNum = UpperBound(inva_Attachment[]) + 1
					inva_Attachment[ll_AttNum].FileType = MailAttach!
					inva_Attachment[ll_AttNum].FileName = ls_FileNameFinal
					inva_Attachment[ll_AttNum].pathName = ls_Path
					inva_Attachment[ll_AttNum].position = li_Position
				ELSE
					This.of_AddError("Could not process manifest image name for naming schema " + ls_NamingSchema + " for shipment number " + String(ll_ShipmentID) + ".")
					EXIT //Invoice will not get sent
				END IF
				
			END IF
		
		NEXT
		
		IF li_Return = -1 THEN
			EXIT
		END IF
		
	NEXT	
	
	lnv_Msg.of_Reset() //Remove Previous Special Tag form lnv_Msg
	IF li_Return = -1 THEN
			EXIT
	END IF
	
NEXT


li_Return = li_Position //Number of Images Attached

Destroy lnv_Company 
Destroy ( lnv_ImageManager )

RETURN li_Return
end function

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

public function long of_getbilltoid ();Long	ll_Return
Long	ll_BillToID
Long	ll_ShipmentID
Long	lla_ShipIds[]

This.of_Getsourceshipmentids(lla_ShipIds[])
ll_ShipmentID = lla_ShipIds[1]  //Bill to id should be the same for all shipments in a manifest

Select ds_Billto_id
Into :ll_BillToID
From disp_Ship
Where ds_Id = :ll_ShipmentID;

Commit;

ll_Return = ll_BillToId


Return ll_Return
end function

public function integer of_setcurrentsourceshipmentid (long al_shipid);il_SourceShipmentId = al_ShipId

Return 1
end function

public function integer of_buildstringfromschema (string as_schema, ref string as_filename, n_cst_msg anv_msg);/***************************************************************************************
NAME: 	of_BuildStringFromSchema

ACCESS:	Public
		
ARGUMENTS: 		
							(None)

RETURNS:		String
	
DESCRIPTION:
		
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : 
			Created 7/17/06 - Maury
			7/17/06 MFS - Added <invoicenumber> tag logic to strip the '--x' from the file name
***************************************************************************************/

String	ls_Result
String	ls_Schema
Long		ll_SourceShipment
Long		lla_SourceShipmentIds[]
Integer	li_CreateRtn
Integer	li_Return
Integer	li_Pos
Any		laa_Beo[]

n_cst_String	lnv_String

n_cst_FileSrvWin32		lnv_FileSrv
n_cst_Msg  					lnv_Msg
n_cst_bso_Dispatch 		lnv_Dispatch
n_cst_beo_Shipment		lnv_Shipment
n_cst_Bso_ReportManager	lnv_ReportManager
n_cst_documentsettings  lnv_doc

lnv_FileSrv = Create n_cst_FileSrvWin32
lnv_Dispatch = Create n_cst_bso_Dispatch
lnv_Shipment = Create n_cst_beo_Shipment

This.of_Getsourceshipmentids(lla_SourceShipmentIds)
//Use the first shipment in the manifest to process the string
ll_SourceShipment = lla_SourceShipmentIds[1] 

lnv_Dispatch.of_retrieveshipment( ll_SourceShipment )
lnv_Shipment.of_SetSource(lnv_Dispatch.of_GetShipmentCache())
lnv_Shipment.of_SetSourceId(ll_SourceShipment)
lnv_Shipment.of_SetItemSource(lnv_Dispatch.of_GetItemCache())
lnv_Shipment.of_SetEventSource(lnv_Dispatch.of_GetEventCache())

lnv_Shipment.of_SetContext(lnv_Dispatch)

ls_Schema = as_Schema
IF Pos(ls_Schema, "<invoicenumber>") > 0 THEN
	ls_Schema = lnv_String.of_GlobalReplace(ls_Schema, "<invoicenumber>", "<manifestinvoicenumbernodashes>", TRUE)
END IF
	
laa_Beo[1] = lnv_Shipment

li_CreateRtn = lnv_ReportManager.of_ProcessString(ls_Schema, ls_Result, laa_Beo, anv_Msg)
IF li_CreateRtn = -1 THEN
	li_Return = -1
ELSE
	
	as_FileName = ls_Result
	li_Return = 1
	
END IF



Destroy lnv_Shipment
Destroy lnv_Dispatch
Destroy lnv_FileSrv

Return li_Return

end function

public function integer of_buildstringfromschema (string as_schema, ref string as_filename);n_cst_Msg	lnv_msg

Return This.of_BuildStringFromSchema(as_schema, as_Filename, lnv_Msg)
end function

public function integer of_getinvoicefile (ref string as_file);/***************************************************************************************
NAME: 	of_GetInvoiceFile	

ACCESS:	Public
		
ARGUMENTS: (ref string as_file)

RETURNS:		String
	
DESCRIPTION:
		Creates a Directory Path (if it doesnt already exist) and FileName for the current Invoice
		
		Returns 1 if invoice file is saved
		Returns -1 if error getting invoice file
	
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : 
			Created 12/12/05 - MFS
***************************************************************************************/
Integer	li_Return = 1
String	ls_Directory
String	ls_FilePath
String	ls_FileName
String	ls_NamingSchema
String	ls_Return
String	ls_ErrorMsg
Long		lla_SourceShipments[]
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

	This.of_GetSourceShipmentIds(lla_SourceShipments[])
	IF UpperBound(lla_SourceShipments[]) > 0 THEN
		IF isValid(sds_Source) THEN	
			ll_RetrieveRtn = sds_source.Retrieve( lla_SourceShipments[] )
		END IF

		IF ll_RetrieveRtn <= 0 THEN
			ls_ErrorMsg = "Failed to retrieve source invoice file for manifest."
			li_Return = -1	
		END IF
		
		Commit;
	ELSE 
		ls_ErrorMsg = "Invalid shipment id when attempting to access invoice file for manifest."
		li_Return = -1
	END IF
	
END IF

//Create Folder for invoice file
IF li_Return = 1 THEN
	ls_Directory = cs_FILEPATH
	IF NOT lnv_FileSrv.of_Directoryexists(ls_Directory) THEN
		IF lnv_FileSrv.of_CreateFolder(ls_Directory) <> 1 THEN
			ls_ErrorMsg = "Invoice target folder " + ls_Directory + " could not be created for manifest."
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
		
		li_ProcessString = This.of_BuildStringFromSchema(ls_NamingSchema, ls_FileName)
		IF li_ProcessString = 1 THEN
			//make sure filename has .pdf extension
			IF Right(ls_FileName, 4) <> ".pdf" THEN
				ls_FileName += ".pdf"
			END IF
		ELSE
			ls_ErrorMsg = "Could not process an invoice file name for naming schema " + ls_NamingSchema + " for manifest."
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
		ls_ErrorMsg = "Failed to save " + ls_FileName + " to " + ls_Directory + " for manifest."
		li_Return = -1
	END IF
END IF
	
IF li_Return <> 1 THEN
	This.of_Adderror( ls_ErrorMsg )
END IF

Destroy lnv_FileSrv

Return li_Return
end function

on n_cst_invoice_emailable_psr_manifest.create
call super::create
end on

on n_cst_invoice_emailable_psr_manifest.destroy
call super::destroy
end on

