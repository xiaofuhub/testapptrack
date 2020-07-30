$PBExportHeader$n_cst_invoice_emailable.sru
forward
global type n_cst_invoice_emailable from n_cst_invoice
end type
end forward

global type n_cst_invoice_emailable from n_cst_invoice
end type
global n_cst_invoice_emailable n_cst_invoice_emailable

type prototypes
Function ulong GetCurrentThreadId() LIBRARY "kernel32.dll" 
end prototypes

type variables
mailFileDescription  inva_Attachment[]

n_cst_EmailInvoiceSettings	 inv_EISettings

// !! Used To delete this path for clean up !!
String	cs_FilePath = "C:\Temp\Invoices\" 
end variables

forward prototypes
public function integer of_getimages (ref string asa_images[])
public function integer of_generate ()
public function integer of_attachimages (string asa_imagetypes[])
public function integer of_send (n_cst_emailmessage anv_emailmsg)
public function integer of_attatchinvoice (string as_path, string as_filename)
public function integer of_buildstringfromschema (string as_schema, ref string as_filename, n_cst_msg anv_msg)
public function integer of_buildstringfromschema (string as_schema, ref string as_filename)
public function integer of_getinvoicefile (ref string as_file)
end prototypes

public function integer of_getimages (ref string asa_images[]);String	lsa_Types[]
Long	ll_Return
Long	ll_BillToID
Long	ll_ShipmentID
Int	i

n_cst_Settings		lnv_Settings
n_cst_beo_Company	lnv_Company

lnv_Company = Create n_cst_beo_Company

ll_BillToID = This.of_GetBillToId()

IF ll_BillToID > 0 THEN
	lnv_Company.of_SetUsecache( True )
	lnv_Company.of_SetSourceID ( ll_BillToID ) 
	lnv_Company.of_GetEmailInvoiceImageTypes ( lsa_Types )
END IF
	
asa_Images = lsa_Types		

ll_Return = UpperBound(asa_Images)	

Destroy lnv_Company

Return ll_Return
end function

public function integer of_generate ();/***************************************************************************************
NAME: 		of_Generate			

ACCESS:		Public
		
ARGUMENTS:	(None)

RETURNS:		Integer
	
DESCRIPTION: 
				Generates An Invoice Email with Appropriate Attachments
				
				Returns 1 if email is generated
				Returns -1 otherwise
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 11/28/05 - Maury
***************************************************************************************/

Integer	li_Return = 1
Long		ll_Index
Long		ll_Max
Long		ll_BillToId
Long		ll_ShipmentId
String	ls_SubjectSchema
String	ls_Subject
String	ls_FileName
String	ls_Path
String	ls_Drive
String	ls_DirPath
String	ls_EmailAddress
String	ls_BccAddress
String	ls_BodySchema
String	ls_Body
String	lsa_EmailTargets[]
String	lsa_BccTargets[]
String	lsa_Images[]

n_cst_EmailMessage	lnv_EmailMsg
n_cst_FileSrvWin32	lnv_FileSrv
n_cst_String			lnv_String

lnv_FileSrv = Create n_cst_FileSrvWin32

inv_EISettings = Create n_cst_EmailInvoiceSettings	
ll_BillToId = This.of_GetBillToId()

inv_EISettings.of_SetCompanyId(ll_BillToId)

ll_ShipmentId = This.of_GetSourceShipmentId()

IF This.of_GetInvoiceFile(ls_Path) <> 1 THEN
	//Error populated by of_GetInvoiceFile
	li_Return = -1
END IF

//Path should be valid but just in case
IF isNull(ls_Path) OR Len(ls_Path) = 0 THEN
	li_Return = -1
END IF

lnv_EmailMsg.of_Setshipmentid( ll_ShipmentId )

//Set Subject Line
IF li_Return = 1 THEN
	ls_SubjectSchema = inv_EISettings.of_GetInvoiceSubjectLineSchema()
	IF isNull(ls_SubjectSchema) OR Len(ls_SubjectSchema) < 1 THEN
		ls_SubjectSchema = "Invoice_<tmp>"
	END IF
	IF This.of_BuildStringFromSchema(ls_SubjectSchema, ls_Subject) <> -1 THEN
		lnv_EmailMsg.of_SetSubject(ls_Subject)
	ELSE
		This.of_AddError("Could not process name for subject line schema '" + ls_SubjectSchema + "'.")
		li_Return = -1
	END IF
END IF

//Set Body
IF li_Return = 1 THEN
	ls_BodySchema = inv_EISettings.of_GetBodySchema()
	IF NOT isNull(ls_BodySchema) AND Len(ls_BodySchema) > 0 THEN
		
		IF This.of_BuildStringFromSchema(ls_BodySchema, ls_Body) = 1 THEN
			
			IF NOT isNull(ls_Body) AND Len(ls_Body) > 0 THEN
				lnv_EmailMsg.of_SetBody(ls_Body)
			END IF
			
		ELSE
			
			This.of_AddError("Could not process name for body schema '" + ls_BodySchema + "'.")
			li_Return = -1
			
		END IF
	END IF
END IF

//Attatch Files
IF li_Return = 1 THEN
	//Parse Path
	lnv_FileSrv.of_ParsePath(ls_Path, ls_Drive, ls_DirPath, ls_FileName)
	
	This.of_AttatchInvoice(ls_Path, ls_FileName)
	
	This.of_GetImages(lsa_images[])

	IF UpperBound(lsa_Images[]) > 0 THEN
		IF This.of_AttachImages(lsa_Images[]) <> -1 THEN
			li_Return = 1
		ELSE
			li_Return = -1
		END IF
	END IF
END IF

//Set Target Address. Send.
IF li_Return = 1 THEN
	lnv_EmailMsg.of_ProcessAttachments(inva_Attachment[])
	
	ls_EmailAddress = inv_EISettings.of_GetTargetAddress()
	lnv_String.of_Parsetoarray(ls_EmailAddress, ";", lsa_EmailTargets[])
	lnv_EmailMsg.of_AddTargets( lsa_EmailTargets[] )
	
	ls_BccAddress = inv_EISettings.of_GetTargetBcc()
	IF NOT isNull(ls_BccAddress) AND Len(ls_BccAddress) > 0 THEN
		lnv_String.of_ParseToArray(ls_BccAddress, ";", lsa_BccTargets[])
		lnv_EmailMsg.of_AddTargetsBcc(lsa_BccTargets[])
	END IF
	
	IF This.of_Send(lnv_EmailMsg) <> -1 THEN
		//ok
	ELSE
		//Error populated in of_Send
		li_Return = -1
	END IF
END IF


//Cleanup
lnv_FileSrv.of_DelTree(cs_FILEPATH)

Destroy lnv_FileSrv
Destroy inv_EISettings
Return li_Return
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
				Created 11/28/05 - Maury
***************************************************************************************/

String	ls_CurrentType
String	ls_Path
String	ls_FileNameFinal
String	ls_NamingSchema
String	lsa_ImagePaths[]
String	lsa_EMPTY[]
Long		ll_ShipmentId
Long		ll_AttNum
Long		ll_NumImages
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

ll_ShipmentID = THIS.of_Getsourceshipmentid( )

FOR li_index = 1 TO li_Max 
	lsa_ImagePaths = lsa_EMPTY
	ls_CurrentType = asa_ImageTypes[ li_Index ]
	
	inv_EISettings.of_ProcessSpecialTagsForEI(ls_NamingSchema, ls_CurrentType, lnv_Msg) //lnv_msg will get special tag by ref

	lnv_bcmService.of_getallbeo ( lnv_bcm, "imagetype_type = '"  + ls_CurrentType + "'" , lnva_ImageTypes )
	
	lnv_ImageManager.of_GetImagelist( lnva_ImageTypes, {ll_ShipmentID}, lsa_imagepaths )
	
	ll_NumImages = upperBound ( lsa_imagepaths )
	
	FOR li_Index2 = 1 TO ll_NumImages
		ls_Path = lsa_ImagePaths[li_Index2]
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
				This.of_AddError("Could not process name for naming schema " + ls_NamingSchema + " for shipment number " + String(ll_ShipmentID) + ".")
				li_Return = -1
				EXIT //Invoice will not get sent
			END IF
		END IF
	NEXT
	lnv_Msg.of_Reset() //Remove Previous Special Tag form lnv_Msg
NEXT

li_Return = li_Position //Number of Images Attached

Destroy lnv_Company 
Destroy ( lnv_ImageManager )

Return li_Return

end function

public function integer of_send (n_cst_emailmessage anv_emailmsg);/***************************************************************************************
NAME: 		of_Send	

ACCESS:		Public
		
ARGUMENTS:	(n_cst_EmailMessage anv_EmailMsg)

RETURNS:		Integer
	
DESCRIPTION: 
				Returns 1 if email is sent
				Returns -1 error occured sending email
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 11/28/05 - Maury
***************************************************************************************/

Integer	li_Return
String	ls_Error

n_cst_bso_email_manager lnv_EmailManager


lnv_EmailManager = CREATE n_cst_bso_email_manager


IF lnv_EmailManager.of_SendMail( anv_EmailMsg ) <> 1 THEN
	ls_Error = lnv_EmailManager.of_GetErrorString( )
	This.of_AddError(ls_Error)
	li_Return = -1
ELSE
	li_Return = 1
END IF


Destroy ( lnv_EmailManager )
	

Return li_Return
end function

public function integer of_attatchinvoice (string as_path, string as_filename);inva_Attachment[1].FileType = MailAttach!
inva_Attachment[1].FileName = as_FileName
inva_Attachment[1].pathName = as_Path
inva_Attachment[1].position = 0
	
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
			Created 12/1/05 - Maury
***************************************************************************************/

String	ls_FileName
String	ls_Return
Long		ll_SourceShipment
Integer	li_CreateRtn
Integer	li_Return
Any		laa_Beo[]

n_cst_FileSrvWin32		lnv_FileSrv
n_cst_Msg  					lnv_Msg
n_cst_bso_Dispatch 		lnv_Dispatch
n_cst_beo_Shipment		lnv_Shipment
n_cst_Bso_ReportManager	lnv_ReportManager
n_cst_documentsettings  lnv_doc

lnv_FileSrv = Create n_cst_FileSrvWin32
lnv_Dispatch = Create n_cst_bso_Dispatch
lnv_Shipment = Create n_cst_beo_Shipment

ll_SourceShipment = This.of_Getsourceshipmentid()


lnv_Dispatch.of_retrieveshipment( ll_SourceShipment )
lnv_Shipment.of_SetSource(lnv_Dispatch.of_GetShipmentCache())
lnv_Shipment.of_SetSourceId(ll_SourceShipment)
lnv_Shipment.of_SetItemSource(lnv_Dispatch.of_GetItemCache())
lnv_Shipment.of_SetEventSource(lnv_Dispatch.of_GetEventCache())

lnv_Shipment.of_SetContext(lnv_Dispatch)


laa_Beo[1] = lnv_Shipment

li_CreateRtn = lnv_ReportManager.of_ProcessString( as_Schema, ls_Return, laa_Beo, anv_Msg)
IF li_CreateRtn = -1 THEN
	li_Return = -1
ELSE
	as_FileName = ls_Return
	li_return = 1
END IF


Destroy lnv_Shipment
Destroy lnv_Dispatch
Destroy lnv_FileSrv

Return li_Return

end function

public function integer of_buildstringfromschema (string as_schema, ref string as_filename);n_cst_Msg	lnv_msg

Return This.of_BuildStringFromSchema(as_schema, as_Filename, lnv_Msg)


end function

public function integer of_getinvoicefile (ref string as_file);String	ls_Null
// Implemented in decendents

Return 0
end function

on n_cst_invoice_emailable.create
call super::create
end on

on n_cst_invoice_emailable.destroy
call super::destroy
end on

event constructor;call super::constructor;String	ls_CurrentThreadId

//Make file path unique:
//This is necessary because if we are doing a threaded resend, 
//the same folder should not be used because we run into access problems
ls_CurrentThreadId = String(GetCurrentThreadId())
IF NOT isNull(ls_CurrentThreadId) AND Len(ls_CurrentThreadId) > 0 THEN
	cs_FilePath += ls_CurrentThreadId + "\"
END IF

end event

