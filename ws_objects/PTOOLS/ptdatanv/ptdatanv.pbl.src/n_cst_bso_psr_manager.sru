$PBExportHeader$n_cst_bso_psr_manager.sru
$PBExportComments$[n_cst_action_Manager]
forward
global type n_cst_bso_psr_manager from n_cst_action_manager
end type
end forward

global type n_cst_bso_psr_manager from n_cst_action_manager
end type
global n_cst_bso_psr_manager n_cst_bso_psr_manager

type variables
Constant 	String cs_Image           = "RULE_IMAGE"

Constant 	String cs_Email   	    =  "RULE_EMAIL"
Constant 	String cs_EmailFormat =  "RULE_EMAILFORMAT"

Constant 	String cs_PrintPrompt  =  "RULE_PRINTPROMPT"
Constant 	String cs_AutoPrint	    =  "RULE_AUTOPRINT"

Constant 	String cs_SaveAsType =  "RULE_SAVEASTYPE"


Constant 	String cs_ShipID	    =  "RULE_SHIPID"
Constant 	String cs_EventID	    =  "RULE_EVENTID"

n_ds	ids_psr

Private:
String	is_FileName
String	isa_PrintImageType[]
String	is_EMailAttachmentFile

Constant 	String cs_PSRFile  =  "C:\PTREPORT"

Boolean	ib_ShowUser =  TRUE
Boolean	ib_BEO_ShipmentsCreated = FALSE

Integer	ii_Email
Integer	ii_Print 
Integer	ii_Image 
Integer	ii_ID

Long	ila_ShipmentIds[]

n_cst_Beo_Shipment    inva_Shipment[]
n_cst_bso_Dispatch     inv_Dispatch

end variables

forward prototypes
public subroutine of_setshowuser (readonly boolean ab_show)
public function boolean of_getshowuser ()
public function integer of_printpsr ()
public function integer of_emailpsr ()
public function string of_getfilename ()
public function integer of_setdispatch (n_cst_bso_Dispatch anv_Dispatch)
public function n_ds of_getdatastore ()
public function integer of_setshipment (n_cst_beo_shipment anv_beo_shipment[])
private function integer of_createbeoshipment ()
public function integer of_setshipment (readonly long al_shipid[])
public function integer of_selectimagestoprint ()
public function integer of_gettagvalues (readonly string as_tagtype, ref string asa_tagarray[])
public function integer of_getprintimages (ref string as_printimage[])
private function integer of_getimagefiles (readonly string asa_imagetypes[], ref string asa_imagefiles[])
public function integer of_openpsr (string as_filename)
public function integer of_retrievepsr ()
public function integer of_retrievepsr (long ala_shipmentid[])
public function integer of_getidvalues (readonly string as_id, ref long ala_id[])
private function integer of_savepsremail ()
public function integer of_findshipids (ref long ala_shipid[])
public function integer of_printpsr (window aw_parent)
end prototypes

public subroutine of_setshowuser (readonly boolean ab_show);// RDT 4-1-03

ib_ShowUser = ab_show
end subroutine

public function boolean of_getshowuser ();// RDT 4-1-03

Return ib_showuser
end function

public function integer of_printpsr ();/***************************************************************************************
NAME			: of_PrintPSR
ACCESS		: Public 
ARGUMENTS	: 
RETURNS		: Integer  (1=Success  -1=Failure)
DESCRIPTION	: prints the n_ds and images with shipment

REVISION		: RDT 4-1-03

				: RDT 6-25-03 
					Check for Image license
					Check for existing images
					Check for Pegasus print controls 
***************************************************************************************/

String 	lsa_PrinterTag[], &
			lsa_ImageFiles[], &
			ls_temp, &
			ls_MessageText, &
			ls_MessageTitle
			
Integer	li_Return = 1, &
			li_Count , &
			li_Upper, &
			li_ShipCount, &
			li_ShipUpper
			
Long 		ll_id

Boolean	lb_Image = TRUE

SetPointer( HourGlass! )

ls_MessageTitle = "Print Report"

n_cst_Msg				lnv_Msg
n_cst_Settings			lnv_Settings
n_cst_licensemanager lnv_licensemanager

n_cst_bso_imagemanager_pegasus lnv_imagemanager_pegasus
lnv_imagemanager_pegasus = Create n_cst_bso_imagemanager_pegasus 

// zmc - Start
n_cst_PrintSrvc lnv_PrintSrvc
lnv_PrintSrvc = CREATE n_cst_PrintSrvc
// zmc - End

////////////////// Get shipmentids from ids_psr 
If This.of_GetIdValues ( this.cs_ShipId, ila_shipmentids[] ) < 1 then 
	This.of_FindShipIds( ila_shipmentids ) 
End If

////////////////// Need at least one shipment to find and print images
IF UpperBound ( ila_shipmentids ) > 0  THEN
	lb_Image	= TRUE
ELSE
	lb_Image = FALSE 
END IF

////////////////// Check for Image License
IF lb_Image Then 
	If lnv_licensemanager.of_getlicensed ( n_cst_constants.cs_module_imaging ) Then 
		lb_Image	= TRUE
	Else
		lb_Image = FALSE 
	End If
END IF

////////////////// Check for existing images
IF lb_Image Then 
	If This.of_getimagefiles ( isa_PrintImageType[ ], lsa_imagefiles[] ) > 0  then 
		lb_Image = TRUE
	Else
		lb_Image = FALSE 
		ls_MessageText = "Print Report? "
	End if
END IF

////////////////// Check for Pegasus print control
IF lb_Image Then 
	If lnv_imagemanager_pegasus.of_checkconnection ( )	= 0 then 
		lb_Image = TRUE
	Else
		lb_Image = FALSE 
		if ib_ShowUser Then 
			MessageBox(ls_MessageTitle ,"Image print controls are not installed on this machine.~nImages will not print.")
		end if			

	End If
END IF 

If lb_Image Then 
	ls_MessageText = "Print Report and Associated Images ?"
Else
	ls_MessageText = "Print Report? "
End if

////////////////// check for AutoPrint tag
IF This.of_getTagValues(cs_autoprint, lsa_PrinterTag[] ) > 0 Then 
	ls_temp = Trim( Upper( lsa_PrinterTag[1] ) )  
	if ls_temp = "TRUE" or ls_temp = "YES"  then 
		ib_ShowUser = FALSE 
	End if
END IF 

////////////////// ask user to continue
IF ib_ShowUser THEN
	li_Return = MessageBox(ls_MessageTitle ,ls_MessageText , Question!, YesNo!, 1) 		
	If li_Return = 2 Then 
		li_return = -1 
	End If
ELSE
	li_Return = 1	
END IF

////////////////// Printer setup
IF li_Return = 1 and ib_ShowUser Then 
	//li_Return = PrintSetup ( ) // commented by zmc 

	/* -=#=- 1/26/07 MFS
		I am reverting back to the PrintSetup() call because
		the lnv_printSrvc.of_print() uses the external PFC print call.
		I experienced the following problems when using the PFC print call:
		
		IF my default printer is 'A' and I want to print this report on printer 'B'..
		
		1) I choose 'B' in the PFC print options and it still prints to 'A' AND..
		2) Printer 'B' becomes my global default printer (I must now go change my default back to 'A' via the OS).
	*/
	
	// -=#=- commented out 1/26/07
	//IF lnv_PrintSrvc.of_print(ids_psr) <> 1 THEN
	//		li_Return = -1
	//	END IF
	//End IF
	
	li_Return = PrintSetup ( ) // -=#=- 1/26/07
END IF
////////////////// Print report
IF li_return = 1 then 
	//ids_psr.PRint() // commented by zmc 
	ids_psr.PRint()   // -=#=- 1/26/07 see above comment 
	
	
	If lb_Image then 
	
		////////////////// print the images
		n_cst_pegasus_print	lnv_Peg_print
		lnv_Peg_print = create n_cst_pegasus_print
		li_Upper = UpperBound( isa_PrintImageType[] )
		
		If li_Upper > 0 Then 
			
			////////////////// Check for Print Setting on PSR file
			This.of_GetTagValues( This.cs_printprompt, lsa_PrinterTag[] ) 
			
			If UpperBound( lsa_PrinterTag[] )  > 0 then 

					if lsa_PrinterTag[1] = "DEFAULT" then 
						lnv_Peg_print.of_PrintDefaults( lnv_msg )
					else 
						lnv_Peg_print.of_PrintSetup ( lnv_msg )
					end if
				
			End If
	
			////////////////// use Pegasus to print images
			FOR li_Count = 1 TO Upperbound ( isa_PrintImageType[] )
				For li_ShipCount = 1 to UpperBound( ila_shipmentids[ ] )
					li_Return = lnv_Peg_print.of_Print (  isa_PrintImageType[li_Count ], ila_shipmentids[li_ShipCount] , lnv_msg )
				Next
			NEXT
			
			DESTROY lnv_Peg_print 
								
		End if // li_upper > 0 

	End If // lb_Image

END IF	


Return li_Return 
end function

public function integer of_emailpsr ();//
/***************************************************************************************
NAME			:  of_EmailPSR	
ACCESS		:  Public 
ARGUMENTS	:  none
RETURNS		: 	none
DESCRIPTION	:  Get email addresses from PSR
					If ib_showuser then display the notification email selection window
					
REVISION		:  RDT 4-1-03
***************************************************************************************/
String 	lsa_Email[], &
			ls_EmailBody , & 
			ls_EmailSubject = "Files for " , &
			lsa_Type[], &
			lsa_FilePath[]

Integer 	i, &
			li_Upper

Integer	li_Return = 1

SetPointer( HourGlass! )

this.of_createbeoshipment()

MailFileDescription lsa_MailFile[]

n_cst_Msg	lnv_msg
s_parm		lstr_Parm

This.of_GetTagValues( cs_Email,  lsa_Email[] ) 

IF ib_showuser THEN

	// populate the message object with the emails in tags
	If UpperBound( lsa_Email [] ) > 0 Then 
		lstr_Parm.is_label = "EMAILARRAY"
		lstr_Parm.ia_value =  lsa_Email[] 
		lnv_Msg.of_Add_Parm( lstr_Parm )
	End If
	
	// populate the message object with the shipment
	lstr_Parm.is_label = "SHIPMENTARRAY"
	lstr_Parm.ia_value = inva_Shipment[]
	lnv_Msg.of_Add_Parm( lstr_Parm )

	// Open Shipment notification window to display email addresses.
	OpenWithParm (w_ShipmentNotification, lnv_msg) 

	//// Get returned addresses 
	lnv_msg.of_Reset()
	lnv_Msg = Message.PowerObjectParm	

	If IsValid( lnv_Msg ) Then 
		if lnv_msg.of_Get_Parm ( "ADDRESSARRAY" , lstr_Parm ) <> 0 then
			lsa_Email[] = lstr_Parm.ia_Value 
		else
			messagebox("Email Images","No Email Addresses were selected")
			li_Return = -1
		end if
	Else
		li_Return = -1 // window closed without sending a message object back. (Cancel)
	End If

	//// Get Shipment ids and add to subject line
	If li_return = 1 Then 
		li_upper = UpperBound ( inva_Shipment[] ) 
		For i = 1 to li_upper
			ls_EmailSubject = ls_EmailSubject + String( inva_Shipment[i].of_getid ( ) )+ " "
		Next
	End IF

END IF // ib_showuser
	
// Save PSR as a file
If li_Return = 1 Then 
	if This.of_SavePSREmail( ) = 1 then 
		li_Return = 1
	else
		if ib_showuser Then 
			MessageBox("Email Image", "PSR File Failed to save. Process stopped.")
		end if
		li_Return = -1
	end if 
End If
	
//// Create emails
If li_Return = 1 Then 
	
	n_cst_EmailMessage  lnv_EmailMessage
	
	n_cst_bso_Email_Manager lnv_Email_Manager
	lnv_Email_Manager = Create n_cst_bso_Email_Manager 

	// get the image files and load them into lsa_MailFile[ ] 
	This.of_GetImageFiles( isa_PrintImageType[], lsa_FilePath[] )
	For i = 1 to UpperBound( lsa_FilePath[] ) 			
		lnv_EmailMessage.of_addfilename ( lsa_FilePath[i]) 
		lsa_MailFile[i].Pathname = lsa_FilePath[i] 
	Next

	// Attach PSR file
	lnv_EmailMessage.of_addfilename ( is_emailattachmentfile ) 
	lsa_MailFile[ i + 1].Pathname = is_emailattachmentfile

	ls_EmailBody = "Please see attached Files"
	lnv_EmailMessage.of_addtargets ( lsa_Email[] )
	lnv_EmailMessage.of_setbody ( ls_EmailBody )
	lnv_EmailMessage.of_setsubject ( ls_EmailSubject )
	lnv_EmailMessage.of_processattachments (  lsa_MailFile[ ]  )

		
	if lnv_Email_Manager.Of_SendMail(lnv_EmailMessage) = -1 then 
		if ib_showuser Then 
			MessageBox("Email Image", "Email Failed to send.")
		end if
		li_Return = -1
	end if

	
	Destroy ( lnv_Email_Manager )
	
End If
	

Return li_Return
end function

public function string of_getfilename ();// RDT 4-1-03
Return is_filename
end function

public function integer of_setdispatch (n_cst_bso_Dispatch anv_Dispatch);


inv_dispatch = anv_Dispatch


Return 1


 
end function

public function n_ds of_getdatastore ();Return ids_psr
end function

public function integer of_setshipment (n_cst_beo_shipment anv_beo_shipment[]);Integer	li_Return = 1

If IsValid( anv_beo_shipment[1] ) Then 
	inva_shipment[] = anv_beo_shipment[]
Else
	li_Return = -1
End If


Return li_Return 
end function

private function integer of_createbeoshipment ();//
/***************************************************************************************
NAME			: wf_createboeshipment
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: none
DESCRIPTION	: uses il_shipmentid to create shipment beo

REVISION		: RDT 4-1-03
***************************************************************************************/
Integer 	li_Count, &
			li_upper, &
			li_Return 

n_cst_Beo_Shipment  lnv_Shipment


//n_cst_bso_Dispatch	lnv_Dispatch
inv_Dispatch = CREATE n_cst_bso_Dispatch

// Get shipmentids from ids_psr 
IF This.of_GetIdValues ( this.cs_ShipId, ila_shipmentids[] ) < 1 Then 
	This.of_FindShipIds( ila_shipmentids[] ) 
END IF


li_upper = UpperBound( ila_shipmentids[] ) 

For li_Count = 1 to li_Upper
	inva_shipment [ li_Count ] = Create n_cst_Beo_Shipment  
	
	inv_Dispatch.of_RetrieveShipment ( ila_ShipmentIds[ li_count ] )
	
	inva_shipment [ li_Count ].of_SetSource ( inv_Dispatch.of_GetShipmentCache ( ) )
	inva_shipment [ li_Count ].of_SetSourceId ( ila_ShipmentIds[ li_count ] )
	inva_shipment [ li_Count ].of_SetEventSource ( inv_Dispatch.of_GetEventCache ( ) )
	inva_shipment [ li_Count ].of_SetItemSource ( inv_Dispatch.of_GetItemCache ( ) )
	
	ib_BEO_ShipmentsCreated = TRUE
	
Next

//Destroy lnv_Dispatch 

Return li_Return 
end function

public function integer of_setshipment (readonly long al_shipid[]);

ila_shipmentids[] = al_shipid[]

Return 1
end function

public function integer of_selectimagestoprint ();//
/***************************************************************************************
NAME			: of_SelectImagesToPrint
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: Integer	( Number of Images to Print, 0 = no images,  -1=error)
DESCRIPTION	: Displays current Images in a window.
				  Window lets user select which images to print 	
				  Window returns and array of images to print. 
				  This method saves those images in an instance variable.
REVISION		: RDT 4-1-03
***************************************************************************************/

Integer 	li_Return 

Long		ll_upper

n_cst_Msg 	lnv_Msg
s_Parm		lstr_Parm

// get current list of images

n_cst_String	lnv_String

// setup message object
	
lstr_Parm.is_Label = "IMAGES"
lstr_Parm.ia_Value = isa_printimagetype[]
lnv_msg.of_Add_Parm( lstr_Parm ) 


// Display Image Selection Window
w_ImageTypeSelection lw_Images
OpenWithParm(lw_Images, lnv_msg)

// Get Return from Window
lnv_Msg = Message.PowerObjectParm

If lnv_Msg.of_Get_Parm ( "IMAGES" , lstr_Parm ) <> 0 THEN
	isa_PrintImageType[] = lstr_Parm.ia_Value
End If


Return li_Return 


end function

public function integer of_gettagvalues (readonly string as_tagtype, ref string asa_tagarray[]);//
/***************************************************************************************
NAME			: of_GetTagValues
ACCESS		: Public 

ARGUMENTS	: String 		Tag Type to look for in the ids_psr ( ie: cs_image)
				  String Array	Tag list (by Reference ) 
				  
RETURNS		: integer		number of elements in array, 0 = No Tag found, -1 = error
									
DESCRIPTION	: Uses Describe to find Image tags in the PSR. 
					Parses the tag into an array passed by reference.
					Returns the number of elements found.

REVISION		: RDT 4-1-03
***************************************************************************************/
Integer	li_Return 
String	ls_Description, &
			ls_Tag, &
			lsa_TagArray[]
			

n_Cst_String lnv_String

// check for valid psr
If IsValid( ids_Psr) Then 
	li_Return = 1
Else
	li_Return = -1
End IF

If li_Return = 1 then 
	// get describe of object
	ls_Description = as_TagType + ".tag"
	ls_Tag = ids_psr.Describe( ls_Description )	
	
	If ls_tag = "!" Then 
		li_Return = 0 
	Else
		// Remove white spaces
		ls_Tag = lnv_string.of_removewhitespace ( ls_tag )
		
		lnv_string.of_parsetoarray ( ls_Tag, ",", asa_TagArray[] )
		li_Return = UpperBound( asa_TagArray[] )
	End IF
	
End If


Return li_Return 
end function

public function integer of_getprintimages (ref string as_printimage[]);//
/***************************************************************************************
NAME			: wf_getPrintImages
ACCESS		: Public 
ARGUMENTS	: string array  by ref
RETURNS		: Integer Number of elements in array 

REVISION		: RDT 4-1-03	
***************************************************************************************/
as_printimage[] = isa_PrintImageType[]
Return UpperBound( isa_PrintImageType[] )


end function

private function integer of_getimagefiles (readonly string asa_imagetypes[], ref string asa_imagefiles[]);//
/***************************************************************************************
NAME			: of_GetImageFiles

ACCESS		: Private 
ARGUMENTS	: String Array asa_imagetypes[]  			
				  String Array asa_ImageFiles[]	by ref  (File names)

RETURNS		: Integer 	(number of files found)
DESCRIPTION	: finds the Image files using the image manager and returns the file path & Name

REVISION		: RDT 
***************************************************************************************/

Integer 	li_Return, &
			li_Count, &
			li_ShipCount , &
			i, &
			k

String	ls_CurrentType
String	lsa_ImageTypes[]
String	lsa_Attach[]
String	ls_Path

n_cst_bcm					lnv_Bcm
n_cst_bcmService			lnv_bcmService
n_cst_beo_ImageType		lnva_ImageTypes[]
n_cst_beo_ImageType		lnv_CurrentImageBeo

n_cst_bso_ImageManager_pegasus	lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager_Pegasus

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )

li_Count = UpperBound ( asa_ImageTypes[] )

FOR i = 1 TO li_Count 
	
	ls_CurrentType = asa_ImageTypes[ i ]
	 		
	lnv_bcmService.of_getallbeo ( lnv_bcm, "imagetype_type = '"  + ls_CurrentType + "'" , lnva_ImageTypes )
	// For each shipment
	For li_ShipCount = 1 to UpperBound( ila_shipmentids )
		// for each image type 
		for k = 1 TO upperBound ( lnva_ImageTypes )			
			lnv_CurrentImageBEO = lnva_ImageTypes[ k ]
			ls_Path = lnv_Imagemanager.of_CreatePath (lnv_CurrentImageBeo , ila_shipmentids[ li_ShipCount ])
			
			IF lnv_ImageManager.of_DoesImageExist ( ls_Path ) THEN
				lsa_Attach [ UpperBound ( lsa_Attach ) + 1 ] = ls_Path
			END IF
			
		next
		
	Next
	
NEXT

asa_imagefiles[] = lsa_Attach

li_Return = UpperBound( asa_imagefiles )

Destroy lnv_ImageManager 

Return li_Return 
end function

public function integer of_openpsr (string as_filename);//
/***************************************************************************************
NAME		  : of_OpenPSR
ACCESS	  : Public 
ARGUMENTS  : String		File Name
			  
RETURNS	  : Integer	(1=success -1=failed)
DESCRIPTION: If the Argument is empty then prompt user for file to retrieve, 
				 otherwise retrieve file in argument.
				 Test for valid PSR file by looking for at least one column in the datawindow.
				 
REVISION	  : RDT 4-1-03
***************************************************************************************/
Integer	li_Return = 1 

String	ls_PathName, &
			ls_FileName, &
			ls_InitDir,  &
			ls_Extension, &
			ls_Filter, &
			lsa_tags[]
n_Cst_FileSrvwin32	lnv_FileSrv
lnv_FileSrv = CREATE n_Cst_FileSrvwin32

SetPointer( HourGlass! )

ls_Filter = "PSR Files (*.psr),*.psr"
ls_Extension = "psr"

// Get Templates Path Folder location.
n_cst_setting_templatespathfolder lnv_folder
lnv_folder = CREATE n_cst_setting_templatespathfolder
ls_InitDir = lnv_folder.of_GetValue()

IF lnv_FileSrv.of_directoryexists( ls_InitDir +"reports" )  THEN
	ls_InitDir += "reports"
END IF


// If as_filename is blank prompt user for file.
If Len ( Trim ( as_filename ) ) = 0 Then
	li_return = GetFileOpenName ( "PSR Report" , as_filename, ls_filename , ls_extension , ls_filter , ls_InitDir )
Else
	if FileExists( as_filename ) Then
		li_Return = 1
	else
		li_Return = -1
	end if
End If

// Set ids_PSR to file
If li_return = 1 THEN
	ids_psr.DataObject = as_filename
	is_FileName = as_filename
END IF

// Test for valid PSR file by looking for at least one column in the datawindow.
IF li_Return = 1 then 

	If Integer ( ids_psr.Describe("DataWindow.Column.Count") ) = 0 Then 
		li_Return = -1
		if ib_showuser Then 
			MessageBox("PSR File Retrieve" , "Invalid PSR file. Please review file: " + as_filename)
		end if
	End If

END IF

// Get any images and store them in is_PrintImageType[]
If li_Return = 1 Then 
	isa_PrintImageType[] = lsa_tags[] // Clear array
	This.of_gettagvalues ( cs_image, isa_PrintImageType[] ) 
End If
DESTROY(lnv_folder)
DESTROY(lnv_FileSrv )

Return li_Return 
end function

public function integer of_retrievepsr ();
//
/***************************************************************************************
NAME		  : of_RetrievePSR
ACCESS	  : Public 
ARGUMENTS  : none
			  
RETURNS	  : Integer	(1=success -1=failed)
DESCRIPTION: If the Argument is empty then prompt user for file to retrieve, 
				 otherwise retrieve file in argument.
				 Test for valid PSR file by looking for at least one column in the datawindow.
				 
REVISION	  : RDT 4-1-03
***************************************************************************************/
Integer	li_Return = 1 

String	ls_PathName, &
			ls_FileName, &
			ls_Extension, &
			ls_Filter, &
			lsa_tags[] 

SetPointer( HourGlass! )

//ls_Filter = "PSR Files (*.psr),*.psr"
//ls_Extension = "psr"
//
//// If as_filename is blank prompt user for file.
//If Len ( Trim ( as_filename ) ) = 0 Then 
//	li_return = GetFileOpenName ( "PSR Report" , as_filename, ls_filename , ls_extension , ls_filter  ) 
//Else
//	if FileExists( as_filename ) Then
//		li_Return = 1
//	else
//		li_Return = -1
//	end if
//End If
//
//// Set ids_PSR to file
//If li_return = 1 THEN
//	ids_psr.DataObject = as_filename
//END IF
//
//// Test for valid PSR file by looking for at least one column in the datawindow.
//IF li_Return = 1 then 
//
//	If Integer ( ids_psr.Describe("DataWindow.Column.Count") ) = 0 Then 
//		li_Return = -1
//		if ib_showuser Then 
//			MessageBox("PSR File Retrieve" , "Invalid PSR file. Please review file: " + as_filename)
//		end if
//	End If
//
//END IF

// Retrieve the data for the datawindow
ids_psr.SetTransObject( SQLCA )
//nwl
//li_Return = ids_psr.Retrieve(  )

//// Get any images and store them in is_PrintImageType[]
//If li_Return = 1 Then 
//	if This.of_gettagvalues ( cs_image, isa_PrintImageType[] ) = 0 Then 
//		isa_PrintImageType[] = lsa_tags[] 
//	end if
//End If

Return li_Return 
end function

public function integer of_retrievepsr (long ala_shipmentid[]);//
/***************************************************************************************
NAME		  : of_RetrievePSR
ACCESS	  : Public 
ARGUMENTS  : Long	array		Shipment id
			  
RETURNS	  : Integer	(1=success -1=failed)
DESCRIPTION: If the Argument is empty then prompt user for file to retrieve, 
				 otherwise retrieve file in argument.
				 Test for valid PSR file by looking for at least one column in the datawindow.
				 
REVISION	  : RDT 4-1-03
***************************************************************************************/
Integer	li_Return = 1 

String	ls_PathName, &
			ls_FileName, &
			ls_Extension, &
			ls_Filter, &
			lsa_tags[] ,&
			ls_IdList, ls_PosString, ls_sort

n_cst_String	lnv_String
SetPointer( HourGlass! )

ls_Filter = "PSR Files (*.psr),*.psr"
ls_Extension = "psr"

//// If as_filename is blank prompt user for file.
//If Len ( Trim ( as_filename ) ) = 0 Then 
//	li_return = GetFileOpenName ( "PSR Report" , as_filename, ls_filename , ls_extension , ls_filter  ) 
//Else
//	if FileExists( as_filename ) Then
//		li_Return = 1
//	else
//		li_Return = -1
//	end if
//End If
//
//// Set ids_PSR to file
//If li_return = 1 THEN
//	ids_psr.DataObject = as_filename
//END IF
//
//// Test for valid PSR file by looking for at least one column in the datawindow.
//IF li_Return = 1 then 
//
//	If Integer ( ids_psr.Describe("DataWindow.Column.Count") ) = 0 Then 
//		li_Return = -1
//		if ib_showuser Then 
//			MessageBox("PSR File Retrieve" , "Invalid PSR file. Please review file: " + as_filename)
//		end if
//	End If
//
//END IF

// Retrieve the data for the datawindow
//If li_Return = 1 Then
	
	//Build Sort
	lnv_String.of_arraytostring( ala_shipmentid[], ',', ls_IdList)
	ls_PosString = "," + ls_IdList + ","
	ls_Sort = "Pos ( '" + ls_PosString + "',  ',' + String ( ds_id ) + ',' ) A"
	ids_psr.setsort( ls_Sort)
	
	ids_psr.SetTransObject( SQLCA )
	li_Return = ids_psr.Retrieve( ala_shipmentid )
//	If li_Return < 1 then // no rows retrieved
//		li_Return = -1 
////	Else
////		li_Return = 1
//	End If
//END IF
//
//// Get any images and store them in is_PrintImageType[]
//If li_Return = 1 Then 
//	This.of_gettagvalues ( cs_image, isa_PrintImageType[] ) 
//End If
//
Return li_Return 
end function

public function integer of_getidvalues (readonly string as_id, ref long ala_id[]);//
/***************************************************************************************
NAME			: of_GetIDValues
ACCESS		: Public 
		
ARGUMENTS	: String ID type (ie: cs_ShipID)
				  Long Array 	(by Reference ) 
				  
RETURNS		: integernumber of elements in array, 0 = No Tag found, -1 = error
									
DESCRIPTION	: Uses Describe to find Image tags in the PSR. 
					Parses the tag into an array passed by reference.
					Returns the number of elements found.

REVISION		: RDT 4-1-03
***************************************************************************************/
Integer	li_Return = 1

Long		ll_RowCount, &
			ll_Row	
			
		
n_cst_AnyArraySrv	lnv_ArraySrv
	
ll_RowCount = ids_psr.RowCount()
// check for rows
If ll_RowCount < 1 Then 
	li_Return = -1
End If

// check for id column in datawindow
If li_Return = 1 Then 
	
	If Upper( ids_psr.Describe( as_ID+".Type" ) ) = "COLUMN" Then 
		li_Return = 1 
	Else
		li_Return = -1
	End If
	
End If

// Get id's 
If li_Return = 1 Then 
	
	For ll_row = 1 to ll_RowCount
		ala_id[ ll_row ] = ids_psr.GetItemNumber(ll_Row, as_ID ) 
	Next	
	
	lnv_ArraySrv.of_GetShrinked ( ala_id[], TRUE , TRUE )
	li_Return = UpperBound( ala_id[] )

End if
	

Return li_Return 
end function

private function integer of_savepsremail ();//
/***************************************************************************************
NAME		  : of_SavePSR
ACCESS	  : Private 
ARGUMENTS  : none
			  
RETURNS	  : Integer	(1=success -1=failed)
DESCRIPTION: Saves the psr as a file so email can send it.
				 
REVISION	  : RDT 4-1-03
***************************************************************************************/
Integer	li_Return = 1 
String	ls_FileType, &
			lsa_Tags[]
			
SetPointer( HourGlass! )

// Get File Type from PSR 
If this.of_GetTagValues( cs_EmailFormat, lsa_Tags[] ) > 0 then 
	ls_FileType = lsa_Tags[1]
End If

Choose Case Lower( ls_FileType )
	Case "clipboard"
		MessageBox("Report File Save","The Email Format Rule is set to save the file to the clipboard. ~nThis file type can not be attached an email. ~nPlease change the Email Format Rule in the report.") 
		li_Return = -1
		
	Case "csv"
		is_EMailAttachmentFile = cs_psrfile+".csv"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, CSV!, true )
		
	Case "dbase2"
		is_EMailAttachmentFile = cs_psrfile+".dbf"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, dBASE2!, true )
		
	Case "dbase3"
		is_EMailAttachmentFile = cs_psrfile+".dbf"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, dBASE3!, true )

	Case "dif"
		is_EMailAttachmentFile = cs_psrfile+".dif"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, DIF!, true )
		
	Case "excel"
		is_EMailAttachmentFile = cs_psrfile+".xls"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, Excel!, true )

	Case "excel5"
		is_EMailAttachmentFile = cs_psrfile+".xls"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, Excel5!, true )

	Case "sylk"
		is_EMailAttachmentFile = cs_psrfile+".xls"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, SYLK!, true )

	Case "htmltable"
		is_EMailAttachmentFile = cs_psrfile+".htm"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, HTMLTable!, true )
		
	Case "psreport"
		is_EMailAttachmentFile = cs_psrfile+".psr"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, PSReport!, true )
		
	Case "sqlinsert"
		is_EMailAttachmentFile = cs_psrfile+".sql"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, SQLInsert!, true )
		
	Case "text"
		is_EMailAttachmentFile = cs_psrfile+".txt"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, Text!, true )
		
	Case "wks"
		is_EMailAttachmentFile = cs_psrfile+".wks"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, WKS!, true )
		
	Case "wk1"
		is_EMailAttachmentFile = cs_psrfile+".wk1"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, WK1!, true )
		
	Case "windows mettafile", "mettafile"
		is_EMailAttachmentFile = cs_psrfile+".wmf"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile, WMF!, true )
		

	Case ELSE 
		is_EMailAttachmentFile = cs_psrfile+".txt"
		li_Return = ids_psr.SaveAs ( is_EMailAttachmentFile , TEXT!, true)
End Choose



Return li_Return 
end function

public function integer of_findshipids (ref long ala_shipid[]);//
/***************************************************************************************
NAME			: of_FindShipIds
ACCESS		: Public 
		
ARGUMENTS	:  Long Array ala_shipid[] (by Reference ) 
				  
RETURNS		: integernumber of elements in array, 0 = No ID found, -1 = error
									
DESCRIPTION	: Uses Describe to find shipid columns in the PSR. 
					Parses the ids into an array passed by reference.
					Returns the number of elements found.

REVISION		: RDT 4-1-03
***************************************************************************************/
Integer	li_Return = 1

Long		ll_RowCount, &
			ll_index, &
			ll_upper

String	lsa_Shipid_Column_list[], &
			ls_Column
			
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "ds_id"
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "de_shipment_id"
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "di_shipment_id"
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "cs_id"

lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "disp_ship_ds_id"
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "disp_events_de_shipment_id"
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "disp_items_di_shipment_id"
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "current_shipment_list_ds_id"
lsa_Shipid_Column_list[ UpperBound( lsa_Shipid_Column_list[] ) + 1 ] = "current_shipments_cs_id"

ll_upper = UpperBound( lsa_Shipid_Column_list[] ) 
		
n_cst_AnyArraySrv	lnv_ArraySrv
	
ll_RowCount = ids_psr.RowCount()

// check for rows
If ll_RowCount < 1 Then 
	li_Return = -1
End If

If li_Return = 1 Then 
	// look for ds_id, disp_id, de_shipment_id, di_shipment_id, cs_id
	For ll_index = 1 to ll_upper
		li_return = -1
		// check for id column in datawindow and use the first one found
		If Upper( ids_psr.Describe( lsa_Shipid_Column_list[ ll_index ]+".Type" ) ) = "COLUMN" Then 
			ls_Column = lsa_Shipid_Column_list[ ll_index ]
			li_Return = 1 
			ll_Index = ll_upper
		End If
	Next
End If
// Get id's 
If li_Return = 1 Then 
	
	For ll_Index = 1 to ll_RowCount
		ala_shipid[ ll_Index ] = ids_psr.GetItemNumber(ll_Index , ls_Column ) 
	Next	
	
	lnv_ArraySrv.of_GetShrinked ( ala_shipid[], TRUE , TRUE )
	li_Return = UpperBound( ala_shipid[] )

End if
	
Return li_Return 

end function

public function integer of_printpsr (window aw_parent);Int li_Return = -1 
IF ids_psr.of_SetParentWindow( aw_parent ) = 1 THEN
	IF THIS.of_printpsr( ) = 1 THEN
		li_Return = 1 
	END IF	
END IF	
Return li_Return
end function

on n_cst_bso_psr_manager.create
call super::create
end on

on n_cst_bso_psr_manager.destroy
call super::destroy
end on

event destructor;
Long ll_i, ll_upper
ll_Upper = UpperBound( inva_Shipment[] ) 

For ll_i = 1 to ll_upper

	If IsValid ( inva_Shipment[ll_i] ) Then 
		Destroy ( inva_Shipment[ll_i] ) 
	End If
	
Next

If IsValid( inv_Dispatch ) Then 
	Destroy inv_Dispatch 
End If

If IsValid( ids_psr ) Then 
	Destroy ids_psr
End If

end event

event constructor;
ids_psr = Create n_ds

ids_psr.SetTransObject(SQLCA) 

SetNull ( ii_email )
SetNull ( ii_image )
SetNull ( ii_print )
end event

