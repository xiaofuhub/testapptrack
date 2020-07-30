$PBExportHeader$n_cst_bso_imagemanager_pegasus.sru
forward
global type n_cst_bso_imagemanager_pegasus from n_cst_bso_imagemanager
end type
end forward

shared variables

end variables

global type n_cst_bso_imagemanager_pegasus from n_cst_bso_imagemanager
event feederempty ( ref long pagenumber,  ref boolean stopscan ) External
end type
global n_cst_bso_imagemanager_pegasus n_cst_bso_imagemanager_pegasus

type prototypes
SUBROUTINE IX_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY "imagxpr6.dll"  ALIAS FOR "PS_Unlock"

SUBROUTINE PP_Unlock ( long pw1, long pw2, long pw3, long pw4) &
	LIBRARY "PrntPRO2.dll" ALIAS FOR "PS_Unlock"


end prototypes

type variables
Public:
oleObject    io_ScanObject
oleObject    io_BarCodeObject 
oleObject    io_ImageObject
oleObject    io_PrintObject

n_cst_bcm	inv_Bcm
n_cst_beo_Image	inv_Image
Datastore ids_modlog


end variables

forward prototypes
public function integer of_processbarcodes (n_cst_beo_imagetype anv_imagetype, n_cst_beo_image anv_images[], oleobject anv_olebarcode, oleobject anv_oleimage)
public function integer of_displayimage (n_cst_beo_image anv_image, integer ai_pageno, oleobject anv_imageobject)
public function integer of_deleteunknown (n_cst_beo_image anva_Images[])
protected function integer of_getunknown (n_cst_beo_imagetype anv_imagetype)
protected function integer of_populateunknown (n_cst_beo_imagetype anv_imagetype)
protected function integer of_loadimagelist (string asa_imagepaths[])
protected function integer of_loadimagelist (string asa_imagepaths[], n_cst_beo_imagetype anv_imagetype)
public function integer of_getimagelist (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[])
public function integer of_populateimage (string as_imagepath, ref n_cst_beo_image anv_image)
public function integer of_generateimagelist (long ala_tmpnbrs[], n_cst_beo_imagetype ana_imagetypes[], ref n_cst_beo_image ana_images[])
public function integer of_viewimages (string as_topic, long ala_id[], integer ai_priv)
public function boolean of_doesimageexist (n_cst_beo_imagetype anv_imagetype, long al_id)
public function boolean of_doesimageexist (string as_imagepath)
public function string of_createpath (n_cst_beo_imagetype anv_imagetype, long al_id)
public function integer of_createfolder (string asa_pathparts[], string asa_nodefolders[])
public function integer of_createpath (string as_topic, string as_category, string as_type, unsignedlong aul_value, ref string asa_pathparts[], ref string asa_nodefolders[])
public function string of_getroot ()
public function integer of_getimagetypesfortype (string as_Type, ref n_cst_beo_ImageType anva_ImageTypes[])
public function integer of_unknownbatch ()
protected function boolean of_validaterootaccess ()
public function integer of_missingimagereport (long ala_ids[], string as_topic)
public function integer of_getimagetypes (string as_topic, ref n_cst_beo_imagetype anva_imagetypes[])
public function integer of_gettypevaluelist (string as_topic, ref string as_valuelist)
public function integer of_checkconnection ()
public function integer of_scan (long ala_ids[], long al_activeid, ref string as_topic, string as_context, oleobject anv_scanobject)
protected function integer of_scanbatch (n_cst_beo_imagetype anv_imagetype, long al_id, boolean ab_multipage, oleobject anv_olescan, boolean ab_settings, boolean ab_scannerselect, boolean ab_feeder, long al_scansource)
protected function integer of_scanunknownbatch (oleobject anv_olescan, n_cst_beo_imagetype anv_imagetype, boolean ab_settings, boolean ab_scannerselect, boolean ab_feeder, long al_scansource)
public function integer of_pasteimage (readonly long ala_shipid[])
protected function integer of_loadimagelistnotype (string asa_imagepaths[], n_cst_beo_imagetype anv_imagetype, long al_id)
public function integer of_populatenotype (string as_imagepath, ref n_cst_beo_image anv_image, long al_id)
public function integer of_copyimage (n_cst_beo_image anv_image, readonly long al_shipid)
public function integer of_getimagelist (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong al_startshipmentid, unsignedlong al_endshipmentid, ref string asa_imagepaths[])
public function integer of_append (string as_appendtofile, string as_filetoappend)
public function integer of_viewunassignedimages ()
public function n_cst_bcm of_getunassignedimagebcm ()
public function integer of_getimagetypes (string as_topic, ref string asa_types[])
private function string of_getnextschemaroot ()
protected function string of_getbatchfolder ()
public function integer of_scannotypebatch (long al_id, oleobject anv_olescan, boolean ab_scannerselect, boolean ab_settings, long al_scansource, boolean ab_feeder)
private function integer of_updatemodlog (long as_newid, string as_category, string as_type, string as_topic, string as_moddescript)
public function integer of_getoleimgaeobject (ref oleobject anv_imageobject)
public function integer of_defaultscannersettings (ref oleobject anv_scan)
end prototypes

public function integer of_processbarcodes (n_cst_beo_imagetype anv_imagetype, n_cst_beo_image anv_images[], oleobject anv_olebarcode, oleobject anv_oleimage);/*===================================================================================

of_ProcessBarcodes
				Arguments:
							anv_imagetype
							anv_images[]
							anv_olebarcode
							anv_oleimage							
							
				This Function will take a list of images along with an image type.
				The images will be evaluated for a barcode.
				If a barcode is found it will be looked up to see if that number belongs to a 
				shipment. if so get the tmp number and apply it to the image for proper
				storage. 
				
====================================================================================*/

String	ls_BarcodeValue
String	ls_ErrorMessage
Int		li_ReturnValue = 1
Int		li_NumBarcodes
Long		ll_ImageCount
Long		i
Long		ll_NewTemp  // new tmp no.


n_cst_beo_Image	lnva_Images[]
n_cst_beo_Image   lnv_CurrentImage

n_cst_beo_ImageType lnv_ImageType


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

lnva_Images = anv_images[]
OleObject	ole_barCodeObject	
OleObject	ole_ImageObject

ls_ErrorMessage = "An error occurred while attempting to process barcodes."


ole_barCodeObject = anv_olebarcode
ole_ImageObject = anv_oleimage

//IF Not IsNull ( anv_imagetype ) THEN
//	li_ReturnValue = -1
//END IF



IF li_ReturnValue = 1 THEN

	IF (Not IsValid ( ole_BarCodeObject ) ) OR ( Not IsValid ( ole_ImageObject ) ) THEN
		li_ReturnValue = -1
	END IF
	
END IF

IF li_ReturnValue = 1 THEN
	SetPointer ( HOURGLASS! )


	//ole_ImageObject.UpDate = TRUE
	
	ll_ImageCount = Upperbound ( lnva_Images )
	
	For i = 1 TO ll_ImageCount
		
	
		lnv_CurrentImage =  lnva_Images[i]
		
		IF Not IsValid ( lnv_CurrentImage ) THEN
			li_ReturnValue = -1
			EXIT
		END IF
		
		lnv_ImageType = lnv_CurrentImage.of_GetImageType ( )
		
		ole_ImageObject.FileName = lnv_CurrentImage.of_GetFilePath ( )
		
		ole_barcodeobject.OwnDIB = False
		ole_barcodeobject.hDIB = ole_imageobject.hDIB
		  
		
		ole_barcodeobject.ImageSource = 0
		ole_barcodeobject.AnalyzeBarcode ( )
		
		li_NumBarcodes = ole_barcodeObject.NumBarcodes
		
		
		IF li_NumBarcodes > 0 THEN
			ole_barcodeobject.GetBarcode( 1 )
		
			ls_BarCodeValue = String( ole_barcodeObject.barcodeResult) 
			messageBox ( "BarCode Result" , string ( ls_BarCodeValue ) )
			
			// Send to Brian's Code and Get Back a tmp #
			//ll_NewTemp = XXX.of_XXX ( ll_BarcodeNumber )
		
				
			// The line below can be removed once  testing is over!!
			//ll_NEWTemp = Long (w_imaging.sle_1.text)
			
			
			IF isvalid ( lnv_ImageType ) THEN
				lnv_CurrentImage.of_Move ( anv_imagetype , ll_NewTemp )
	
				lnv_CurrentImage.of_SetID ( ll_NewTemp )
				// fill an array with the values so the new image with its id can be displayed
				// in the image list
			ELSE 
				li_ReturnValue = -1
			
			END IF	
			
		Else 
			MessageBox ( "Bar Codes", "Could not read barcode" )
		END IF	
		
	Next
	
END IF

//ole_ImageObject.UpDate = TRUE



//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



RETURN li_ReturnValue

end function

public function integer of_displayimage (n_cst_beo_image anv_image, integer ai_pageno, oleobject anv_imageobject);/*=================================================================================
of_DisplayImage
			Arguments:
			
					anv_image = the image beo that is to be displayed
			
					ai_pageno = the page number of the image that is to be displayed
					
					anv_imageobject = pegasus's COM object
					
					By calling this function the image passed in will be displayed in 
					w_imaging if it is valid. 

	Return Value: 0 = No Mod Locks available

===================================	==============================================*/

String	ls_FilePath 
String	ls_ErrorMessage
Int		li_DisplayPage 
Int		li_ReturnValue = 1
Int		li_NumberPages

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_LicenseManager		lnv_LicenseManager
n_cst_beo_Image lnv_Image

lnv_Image = anv_image


li_DisplayPage = ai_pageno

ls_ErrorMessage = "An error occurred while attempting to display an image."

//	Request a lock for user
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Imaging, "E" ) < 0 THEN
	li_ReturnValue = 0
END IF


IF Not isValid ( lnv_Image ) THEN
	li_ReturnValue = -1	
END IF

IF li_ReturnValue = 1 THEN
	
	li_NumberPages = lnv_Image.of_CalcPages ( anv_ImageObject ) 
	IF li_NumberPages = 0 THEN
		li_ReturnValue = -1
	END IF
	
END IF

IF li_ReturnValue = 1 THEN
	IF isValid ( W_imaging )  THEN 
		w_Imaging.wf_DisplayImage( lnv_image , ai_pageno )
	ELSE
		li_ReturnValue = -1
		ls_ErrorMessage = "An error occurred while attempting to locate a window to display the image."
	END IF
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

Return li_ReturnValue 
end function

public function integer of_deleteunknown (n_cst_beo_image anva_Images[]);Int 	i
Int	li_ImageCount

	
li_ImageCount = UpperBound( anva_Images )	

For i = 1 TO li_ImageCount 
	anva_Images [ i ] .of_DeleteImage ( )
NEXT
	
	
Return 1	
end function

protected function integer of_getunknown (n_cst_beo_imagetype anv_imagetype);// this might not be needed.... replaced with populateUnknown()

/*===================================================================================
of_GetUnknown
			Arguments:
					anv_imagetype = The imagetype for the images without an id.
					
					This function will populate the image list in w_imageing if it is valid.

=====================================================================================*/
String  	lsa_ImagePaths [ ]
String 	ls_TotalPath
String	ls_Root
String	ls_ErrorMessage
Long		ll_fileCnt
Long 		i , j
Int		li_ReturnValue = 1


n_cst_beo_ImageType lnva_ImageType []
n_cst_beo_ImageType lnv_CurrentBeo

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

ls_ErrorMessage = "An error occurred while attempting to locate images without IDs."

lnv_filesrvwin32 = Create n_cst_filesrvwin32

ls_Root = THIS.of_getRoot ( ) 
IF Len( ls_Root ) = 0 THEN
	li_ReturnValue = -1
END IF
	

IF li_ReturnValue = 1 THEN

	ll_fileCnt=lnv_filesrvwin32.of_dirlist ( ls_root+"*.*", 39, lnv_dirattrib )

	FOR i = 1 TO ll_fileCnt
	
		ls_TotalPath = ls_root + lnv_dirattrib[i].is_filename
				
		j++
		lsa_ImagePaths [ j ] = ls_TotalPath
		
	NEXT
	
li_ReturnValue = THIS.of_LoadImageList ( lsa_ImagePaths , anv_imagetype )
	
END IF



//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


DESTROY	lnv_filesrvwin32
Return li_ReturnValue
end function

protected function integer of_populateunknown (n_cst_beo_imagetype anv_imagetype);/*===================================================================================
of_GetUnknown
			Arguments:
					anv_imagetype = The imagetype for the images without an id.
					
					This function will populate the image list in w_imageing if it is valid.

=====================================================================================*/
String  	lsa_ImagePaths [ ]
String 	ls_TotalPath
String	ls_Root
String	ls_ErrorMessage
Long		ll_fileCnt
Long 		i , j
Int		li_ReturnValue = 1


n_cst_beo_ImageType lnva_ImageType []
n_cst_beo_ImageType lnv_CurrentBeo

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

ls_ErrorMessage = "An error occurred while attempting to locate images without IDs."

lnv_filesrvwin32 = Create n_cst_filesrvwin32

ls_Root = THIS.of_getBatchFolder ( ) 
IF Len( ls_Root ) = 0 THEN
	li_ReturnValue = -1
END IF
	

IF li_ReturnValue = 1 THEN

	ll_fileCnt=lnv_filesrvwin32.of_dirlist ( ls_root+"*.*", 39, lnv_dirattrib )

	FOR i = 1 TO ll_fileCnt
	
		ls_TotalPath = ls_root + lnv_dirattrib[i].is_filename
				
		j++
		lsa_ImagePaths [ j ] = ls_TotalPath
		
	NEXT
	
li_ReturnValue = 	THIS.of_LoadImageList ( lsa_ImagePaths , anv_imagetype )
	
END IF



//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


DESTROY	lnv_filesrvwin32
Return li_ReturnValue



end function

protected function integer of_loadimagelist (string asa_imagepaths[]);
n_cst_beo_imageType	lnv_NullImageType


RETURN THIS.of_LoadImageList (asa_imagepaths , lnv_NullImageType )




end function

protected function integer of_loadimagelist (string asa_imagepaths[], n_cst_beo_imagetype anv_imagetype);/*==================================================================================

of_LoadImageList:
						Arguments:
						
							asa_imagepaths[] = an array of image Paths that are to be displayed.
							
							anv_imagetype    = IF VALID - then it is assumed that the path 
													 can't be parsed to determin the image type ( ie 
													 unknown batch ).
													 IF NOT VALID - Then the image type will be extracted
													 from the path.
					
						Description:
										This function will update the image list in the window 
										w_imageList if it is valid with a valid ui_link. 




====================================================================================*/
String		lsa_ImagePaths[]
String		ls_ErrorMessage
Long 			k
Int			li_ReturnValue = 1

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_bcm			lnv_Bcm
n_cst_beo_Image	lnv_Image


IF NOT isValid (  w_imaging.dw_ImageList.inv_UILink ) THEN
	li_ReturnValue = -1
	ls_ErrorMessage = "The updating of the image list could not be performed."
END IF

	
IF li_ReturnValue = 1 THEN
	
	
	lsa_ImagePaths = asa_imagepaths[]
	
	lnv_Bcm = gnv_BcmMgr.CreateBcm ( )
	lnv_Bcm.SetDlk ( "n_cst_dlkc_image" )
	lnv_Bcm.AddClass ( "n_cst_beo_image" )
	
	IF Not IsValid ( lnv_bcm ) THEN
		li_ReturnValue = -1
	END IF
		
	IF li_ReturnValue = 1 THEN
		
		FOR K = 1 to upperbound ( lsa_ImagePaths ) 
			
			IF NOT THIS.of_DoesImageExist ( lsa_ImagePaths [ k ]  ) THEN
				CONTINUE
			END IF
			Long	ll_NewRtn
			ll_NewRtn = lnv_Bcm.NewBeo ( lnv_Image )
			
	
			IF IsValid ( lnv_Image ) THEN
				IF isValid ( anv_ImageType ) THEN
					lnv_Image.of_SetImageType ( anv_imagetype )
					lnv_Image.of_SetFilePath ( lsa_ImagePaths [ k ] )
				ELSE
					li_ReturnValue = THIS.of_PopulateImage ( lsa_ImagePaths [ k ]  , lnv_image)
				END IF
			ELSE
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while attempting to update the image list."
				EXIT
			END IF
		NEXT
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF w_Imaging.wf_SetBCM(lnv_Bcm) <> 1 THEN
		li_ReturnValue = -1 
	END IF	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


Return li_ReturnValue


end function

public function integer of_getimagelist (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[]);/*==================================================================================
of_getImageList:
				
				Arguments:
					anva_beoimagetypearray[] = An array of image types that will be combined
														with all the tmpnumbers and then looked up to 
														determine if that particular image exists
					aula_tmpnumber[]			 = An array of all the tmpNumbers to be searched
				 	asa_imagepaths[] (reference)
					 								 = All images that were found will have their file
														paths inserted into the array and made available 
														to whatever called the function
===================================================================================*/

String	ls_Topic
String	ls_Type
String	ls_Category
String  	lsa_ImagePaths [ ]
String	ls_Root
String	lsa_PathParts [ ]
String	lsa_NodeFolders [ ] 
String 	ls_TotalPath
String	ls_ErrorMessage
ULong		lul_TmpNum
Long		lla_IDsWOImages[]
Int		li_CreatePathReturn
Int		li_ReturnValue  = 1
// Changed from Int to Long by ZMC on 11-11-03 to accomodate large Shipment Ids 
Long 		i,k, j 
// Changed from Int to Long by ZMC on 11-11-03 to accomodate large Shipment Ids 
Long		ll_IDCount
Long		ll_BeoCount

n_cst_shipmentmanager	lnv_ShipmentManager
n_cst_beo_ImageType lnva_ImageType []
n_cst_beo_ImageType lnv_CurrentBeo

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

lnva_ImageType = anva_beoimagetypearray[]

ls_ErrorMessage = "An error occurred while attempting to retrieve the image list."

ls_Root = THIS.of_GetRoot ( )

IF Len (ls_Root) = 0 THEN
	li_ReturnValue = -1
	ls_ErrorMessage = "An error occurred while attempting to locate file paths."
END IF


IF li_ReturnValue = 1 THEN
	n_cst_setting_includeparentinimagelookup	lnv_IncludeParents
	lnv_IncludeParents = CREATE n_cst_setting_includeparentinimagelookup
	IF lnv_IncludeParents.of_Getvalue( ) = lnv_IncludeParents.cs_yes THEN
		lnv_ShipmentManager.of_Addparentidstolist( aula_tmpnumber , aula_tmpnumber )
	END IF
	
	DESTROY ( lnv_IncludeParents )
	
	ll_BeoCount = upperBound  ( lnva_ImageType ) 
	ll_IDCount = upperbound ( aula_tmpnumber )
	
	
	For K = 1 To ll_IDCount
	
		IF li_ReturnValue = -1 THEN
			EXIT
		END IF
	
		lul_TmpNum = aula_tmpnumber[K]
	
		For i = 1 To ll_BeoCount
			
			lnv_CurrentBeo = lnva_ImageType [ i ]
			
			IF Not IsValid ( lnv_CurrentBeo ) THEN
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while evaluating an image type."
			END IF
			
			IF li_ReturnValue = 1 THEN
				ls_Topic = lnv_CurrentBeo.of_GetTopic ( )
				ls_Type  = lnv_CurrentBeo.of_GetType ( )
				ls_Category = lnv_CurrentBeo.of_GetCategory ( )
			
				li_CreatePathReturn = THIS.of_CreatePath ( ls_Topic , ls_Category , ls_Type , lul_TmpNum , lsa_PathParts [] , lsa_NodeFolders [] )
			END IF
				
			IF li_CreatePathReturn <> 1 THEN
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while creating an image path."
			END IF
			
			IF li_ReturnValue = 1 THEN
				// The Document name is not in the PathParts, It is at the upperbound if the node folders
				ls_TotalPath = ls_Root + lsa_Pathparts [ upperBound ( lsa_PathParts ) ] +"\"+ &
								lsa_NodeFolders[ upperBound ( lsa_NodeFolders ) ] + ".tif"
			END IF		
		
				
			IF Len ( ls_TotalPath ) > 0 THEN
			
				IF of_DoesImageExist ( ls_TotalPath  ) THEN		
					j++
					lsa_ImagePaths [ j ] = ls_TotalPath
				ELSE
					CONTINUE
				END IF
				
			ELSE
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while obtaining the path to an image."
			END IF
			
			IF li_ReturnValue = -1 THEN
				EXIT
			END IF
			
		NEXT
		
	NEXT
	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



asa_ImagePaths =  lsa_ImagePaths

IF li_ReturnValue <> -1 THEN
	li_ReturnValue = UpperBound (  lsa_ImagePaths )
END IF

Return li_ReturnValue








end function

public function integer of_populateimage (string as_imagepath, ref n_cst_beo_image anv_image);/*========================================================================================
of_populateImage
					Arguments:
								as_imagepath
								anv_image
								
				This function parses the imagePath and populates anv_image with the 
				proper properties.

=======================================================================================*/
String	ls_Topic
String	ls_Type
String	ls_Category
String 	lsa_Result [ ]
String	ls_ErrorMessage
Int		li_ReturnValue = 1
Long		ll_ID
Long		ll_PartsCount

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_beo_ImageType	lnv_ImageType

n_cst_beo_Image	lnv_Image
n_cst_string	lnv_string

ls_ErrorMessage = "An error occurred while attempting to populate an image."

lnv_Image = anv_Image

IF NOT IsValid ( lnv_Image ) THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	
	lnv_String.of_ParseToArray ( as_ImagePath , "\" , lsa_Result  )
	
	ll_PartsCount = UpperBound ( lsa_Result ) 
	
	ls_Category = lsa_Result [ ll_PartsCount - 7 ] //3
	ls_Topic = lsa_Result [ ll_PartsCount - 6 ]  //4
	ls_Type	= lsa_Result [ ll_PartsCount - 5  ]//5
	
	lnv_String.of_parseToArray ( lsa_Result [ ll_PartsCount ] , "." ,lsa_Result )//9
	
	
	ll_id =  long ( lsa_Result [ 1 ] ) 
	
	//lnv_ImageType = lnv_Image.of_GetImageType ( )
	
	//IF isValid ( lnv_ImageType) THEN
		
		lnv_image.of_SetTopic ( ls_Topic ) 
		lnv_image.of_SetType ( ls_Type ) 
		lnv_image.of_Setcategory ( ls_Category  ) 
	
		//
//		lnv_imageType.of_SetTopic ( ls_Topic ) 
//		lnv_imageType.of_SetType ( ls_Type ) 
//		lnv_imageType.of_Setcategory ( ls_Category  ) 
	
		lnv_Image.of_SetImageType ( lnv_ImageType )
		
		lnv_image.of_SetID( ll_id )
		lnv_Image.of_SetFilePath ( as_imagepath )
			
		anv_Image = lnv_Image
	//ELSE
		//li_ReturnValue = -1
		
	//END IF
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


Return li_ReturnValue

end function

public function integer of_generateimagelist (long ala_tmpnbrs[], n_cst_beo_imagetype ana_imagetypes[], ref n_cst_beo_image ana_images[]);/*=================================================================================
of_GenerateImageList
				Arguments:
						ala_tmpnbrs[]   
						ana_imagetypes[]
						ana_images[]
						
						after calling of_GetImageList() the paths are used to populate a list 
						of images. of which are put in ana_images[]
						

=================================================================================*/
Long						ll_IDs[]
String					lsa_ImagePaths[]
String					ls_ErrorMessage
Long 						k
Int						li_ReturnValue = 1
Long						ll_ListReturn 


n_cst_beo_Image		lnv_Image
n_cst_beo_image		lnva_Images[]
 

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error


n_cst_beo_ImageType 	lnva_Imagetypes[]
ls_ErrorMessage = "An error occurred while attempting to generate a list of images."

IF Not IsValid ( inv_Bcm ) THEN
	
	inv_Bcm = gnv_BcmMgr.CreateBcm ( )
	IF Not isValid ( inv_Bcm ) THEN
		li_ReturnValue = -1
	ELSE
		inv_Bcm.SetDlk ( "n_cst_dlkc_image" )
		inv_Bcm.AddClass ( "n_cst_beo_image" )
	END IF
END IF



IF li_ReturnValue = 1 THEN
	
	inv_Bcm.SetDlk ( "n_cst_dlkc_image" )
	inv_Bcm.AddClass ( "n_cst_beo_image" )
	
	ll_ListReturn = THIS.of_GetImageList (   ana_imagetypes[] , ala_tmpnbrs[], lsa_ImagePaths )
	
END IF


//IF ll_ListReturn <> 1 THEN // zmc commented by zmc - 3/12/04
IF ll_ListReturn <= 0 THEN 
	li_ReturnValue = -1
END IF


IF li_ReturnValue = 1 THEN
	
	for K = 1 to upperbound ( lsa_ImagePaths ) 

		IF inv_Bcm.NewBeo ( lnv_Image ) = -1 THEN
			li_ReturnValue = -1
			EXIT
		END IF
	
		li_ReturnValue = THIS.of_PopulateImage ( lsa_ImagePaths [ k ]  , lnv_image)
		IF li_ReturnValue = 1 THEN
			lnva_Images [ upperBound ( lnva_Images ) + 1 ] = lnv_Image
		ELSE
			EXIT
		END IF
		
	NEXT
	
	IF li_ReturnValue = 1 THEN
		li_ReturnValue  = upperBound ( lnva_Images )
		ana_images[] = lnva_Images
	END IF
END IF


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


Return li_ReturnValue




end function

public function integer of_viewimages (string as_topic, long ala_id[], integer ai_priv);/*=====================================================================================
of_ViewImages
			Args:
				as_topic = The topic of the images ( or the screen this was kicked off from)
							  also used as the filter for the image type list
				ala_id[]	= a list of ids to be used in viewing the images
				ai_priv	= the users Privileges

	This function is intended to be called to kick off the viewing of images from within 
	a particular screen.
	
	
	>> all propagated error will be displayed at this level<<

=====================================================================================*/

Int		li_ReturnValue = 1
Int 		li_RtnStatus
String 	ls_Msg1
String 	ls_Msg2
Boolean	lb_RootAccess
Boolean	lb_Continue = TRUE

Long lla_archiveimagerange[]
Long lla_VolumeNumber[]
 
n_cst_LicenseManager	lnv_LicenseManager

n_cst_OFRError_Collection lnv_ErrorCollection

//n_cst_bso_ImageManager lnv_ImageManager
//lnv_ImageManager = CREATE n_cst_bso_ImageManager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN
	
	//	Request a lock for user
//	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Imaging, "E" ) < 0 THEN
//		lb_Continue = FALSE
//		li_ReturnValue = -2
//	END IF

   IF lb_Continue THEN
		n_cst_msg lnv_msg
		s_parm	lstr_parm
		
		lstr_Parm.is_Label = "TOPIC"
		lstr_Parm.ia_Value = as_topic
		lnv_Msg.of_Add_Parm( lstr_Parm ) 
		
		
		lstr_Parm.is_Label = "ID"
		lstr_Parm.ia_Value = ala_id
		lnv_Msg.of_Add_Parm( lstr_Parm ) 
		
		lstr_Parm.is_Label = "PRIV"
		lstr_Parm.ia_Value = ai_priv
		lnv_Msg.of_Add_Parm( lstr_Parm ) 
		
		lb_RootAccess = THIS.of_ValidateRootAccess ( )
		
		IF NOT lb_RootAccess THEN
			MessageBox( "File Access" , "The root path specified in the system settings could not be accessed. Be sure the folder exists and try again.", EXCLAMATION! )
		ELSE	
		
			IF THIS.of_CheckConnection ( ) <> 0 THEN
				li_ReturnValue = -1
				MessageBox( "Control Connection" , "Profit Tools could not locate the necessary controls needed to perform this operation.") 
			END IF
			
			IF li_ReturnValue = 1 THEN
				IF ISValid ( W_Imaging ) THEN
//					IF w_imaging.wf_HasUnknown() THEN
//						IF messageBox ( "Imaging" , "By viewing images, any images without ids will be lost do you wish to continue?" , EXCLAMATION!, YESNO! , 2 ) = 1 THEN
						
							li_ReturnValue = w_imaging.wf_ResetWindow ( )
//						ELSE
//							li_ReturnValue = 0 
//						END IF
//					END IF
				END IF
				
			
				IF li_ReturnValue = 1 THEN
					OpenSheetWithParm ( w_Imaging, lnv_msg , gnv_App.of_GetFrame ( ), 0, Layered! )
					
					SetPointer(HourGlass!)
					
					n_cst_beo_imageType	lnva_ImageTypes[]
					String					lsa_ImagePaths[]
			
			
					IF isValid ( W_imaging ) THEN						
						IF  Not IsValid ( w_Imaging.wf_getimagingcontrol( ) )  THEN
							li_ReturnValue = -1
						END IF
					ELSE
						li_ReturnValue = -1
					END IF
				
					IF li_ReturnValue = 1 THEN
			
						li_ReturnValue = THIS.of_GetImageTypes ( as_topic , lnva_ImageTypes )
					
						IF IsValid ( w_imaging ) AND li_ReturnValue <> -1 THEN

							li_returnValue = of_GetImageList ( lnva_ImageTypes , ala_id[],  lsa_ImagePaths[])
							
							// ZMC 10/30/03
							IF UpperBound(ala_id) > 0 THEN
								li_RtnStatus = THIS.of_DoesArchiveImagesExists & 
														(ala_id[],lla_archiveimagerange[],lla_VolumeNumber[])
								IF UpperBound(lla_VolumeNumber[]) > 0 THEN						 
									IF li_RtnStatus = 1 THEN
										ls_Msg1 = "Your TmpId(s) selection include(s) archived images. Do you want to view them now?"
										ls_Msg2 = "Press 'Yes' to display Archive Images. Press 'No' to display Active Images."
										IF MessageBox('View Images',ls_Msg1 + ' ' + ls_Msg2,Question!,YesNo!,1) = 1 THEN
											THIS.of_getimagepathforarchivedimages & 
													(lnva_ImageTypes,lla_archiveimagerange[],lla_VolumeNumber[], lsa_ImagePaths[])											
										END IF		
									ELSEIF li_RtnStatus = -2 THEN
										li_ReturnValue = 1
									END IF
								END IF							
							END IF
							
							IF li_ReturnValue <> -1 THEN
								IF UpperBound(lsa_ImagePaths[]) > 0 THEN
									li_ReturnValue = of_loadImageList ( lsa_ImagePaths[] )
								END IF	
							END IF
							
							IF UpperBound(lsa_ImagePaths[]) = 0  THEN					
								//MessageBox('No images were found','No images were found. Please check your archived records.')
							END IF	
							
						END IF
					END IF
			END IF
		END IF
		
		//* Error Reporting *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
		int 	li_errorCount
		int	i

		
		n_cst_OFRError lnv_Error[]
		lnv_ErrorCollection = This.GetOFRErrorCollection ( )
		lnv_Errorcollection.GetErrorArray( lnv_Error )
		li_ErrorCount = upperBound(lnv_Error)
		
		For i = 1 TO li_ErrorCount
		
		MessageBox("Imaging" , string( lnv_Error[i].getErrorMessage() ), EXCLAMATION! )
		
		next
		
		IF li_ErrorCount > 0 THEN
			li_ReturnValue = -1
		END IF
		//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
	
		END IF
	END IF  // mod request
	
ELSE
	MessageBox("Document Imaging", "You are not currently licensed for this module. Please Contact Profit Tools." ) 
END IF

Return li_returnValue
end function

public function boolean of_doesimageexist (n_cst_beo_imagetype anv_imagetype, long al_id);/*============================================================================
of_DoesImageExist
					Arguments:
								anv_imagetype
								al_id
		

=================================================================================*/
String	ls_Path
String	ls_ErrorMessage
Int		li_returnValue = 1
Boolean 	lb_ReturnValue 


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error



IF isValid ( anv_ImageType ) THEN
	ls_Path = This.of_CreatePath ( anv_imagetype , al_id )

	IF	Len (ls_path) = 0 THEN
		li_ReturnValue = -1
		ls_ErrorMessage = "An error occurred while attempting to determine if an image exists." 
	ELSE
		lb_ReturnValue = THIS.of_DoesImageExist ( ls_Path )
	END IF
	
END IF


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lb_ReturnValue = FALSE
END IF

RETURN lb_ReturnValue 
end function

public function boolean of_doesimageexist (string as_imagepath);
Int	li_FileCnt
Boolean	lb_ReturnValue


n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

lnv_filesrvwin32 = Create n_cst_filesrvwin32


li_filecnt = lnv_filesrvwin32.of_dirlist ( as_imagepath, 39, lnv_dirattrib )

IF li_FileCnt = 1 THEN
	lb_ReturnValue = TRUE
END IF


DESTROY lnv_filesrvwin32
Return lb_ReturnValue
end function

public function string of_createpath (n_cst_beo_imagetype anv_imagetype, long al_id);/*======================================================================================

of_CreatePath:
				overloaded-
				In this version of of_createPath 
				the Aguments are:
											anv_imagetype = this will be broken down to create the path
																
											al_id			  = the id used to define the file name


========================================================================================*/
String 	ls_Topic
String	ls_Category
String	ls_Type
String 	ls_FileName
Ulong		lul_id
String	lsa_PathParts [ ]
String	lsa_NodeFolders [ ]

String	ls_TotalPath
String	ls_DriveLetter 
String	ls_ErrorMessage
Int		li_CreatePathReturn
Int		li_ReturnValue = 1

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

ls_ErrorMessage = "An error occurred while attempting to create a file path. "


IF isValid ( anv_imagetype ) THEN
	ls_topic = anv_ImageType.of_GetTopic()
	ls_Category = anv_ImageType.of_GetCategory()
	ls_Type = anv_ImageType.of_GetType()
ELSE
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	
	lul_id = al_ID
	
	ls_DriveLetter = THIS.of_GetRoot ( )
	
	IF Len ( ls_DriveLetter ) = 0  OR ( lul_id = 0 ) THEN
		li_ReturnValue = -1
	END IF
	
END IF


IF li_ReturnValue = 1 THEN
	
	li_CreatePathReturn = THIS.of_CreatePath ( ls_topic , ls_Category , ls_Type , lul_id , lsa_PathParts[] , lsa_NodeFolders[])
	
	IF li_CreatePathReturn = 1 THEN
		ls_FileName = lsa_NodeFolders [ upperBound ( lsa_NodeFolders ) ] 
		ls_TotalPath = ls_DriveLetter + lsa_PathParts[ upperBound(lsa_Pathparts) ] + "\" +ls_FileName+".tif"

	ELSE
		li_returnValue = -1
		
	END IF

END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	ls_TotalPath = ""
END IF

Return ls_TotalPath
end function

public function integer of_createfolder (string asa_pathparts[], string asa_nodefolders[]);/*====================================================================================

of_CreateFolder:
			Arguments:
						asa_pathparts[]   = contains the the different path parts for a specified 
												  path. the first element will be "" and the last will have
												  the total path with out the file name.
						asa_nodefolders[] = contains a list of the individual folders of a specified
												  path. they are used to append onto the path parts so that
												  a complete folder can be created using 'lnv_win32'.
												  
												  NOTE: The file name can be obtained at the upperbound of
												  		  asa_nodefolders[].
														

======================================================================================*/

Long 		i
Long 		j
Long	 	li_partsCount

String	ls_DriveRoot
String	ls_ErrorMessage
Int		li_ReturnValue = 1

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

ls_ErrorMessage = "An error occurred while attempting to create a new folder."

n_cst_filesrvWin32  lnv_win32
lnv_win32 = create n_cst_filesrvWin32

li_partsCount = upperBound ( asa_pathparts[ ] )
ls_DriveRoot = THIS.of_GetRoot ( )


IF NOT lnv_Win32.of_DirectoryExists ( ls_DriveRoot + asa_pathparts[ upperBound ( asa_pathparts) ] ) THEN

	j = 1
	DO While ( (j <= li_PartsCount ) AND ( lnv_Win32.of_directoryExists ( asa_PathParts [ j ] ) ))
		j ++
	Loop
	
	For i = j To li_PartsCount
		
		li_ReturnValue = lnv_win32.of_createDirectory (ls_DriveRoot + asa_pathparts[ i ] )
		
	//	IF li_ReturnValue = -1 THEN
	//		EXIT
	//	END IF
	next
END IF
	
	

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


destroy lnv_Win32

RETURN  li_ReturnValue
end function

public function integer of_createpath (string as_topic, string as_category, string as_type, unsignedlong aul_value, ref string asa_pathparts[], ref string asa_nodefolders[]);/*====================================================================================

of_CreatePath
		Arguments: 	as_topic			
					  	as_category
						as_type
						aul_value
						asa_pathparts[]
						asa_nodefolders[]

		once the path has been created the individual path parts and node folders will 
		be put into the two arrays.
		an example of the arrays:
			
			pathparts[1] = ""									nodeFolders[1] = "FirstFolder"
			pathparts[2] = "FirstFolder"					nodeFolders[2] = "SecondFolder"
			pathparts[3] = "FirstFolder\SecondFolder" nodeFolders[3] = "ThirdFolder"
			
		NOTE:
			The file Name can be obtained 
			at the upperBound of the nodeFolders without the extension.
					  
=====================================================================================*/

String	lsa_NodeFolders[7]	// individual folder names used to tack onto paths
String	lsa_PathParts[8]
String 	ls_Group
String 	ls_Range
String  	ls_lowRange
Ulong		lul_LowLim  
Ulong		lul_ValueTemp
ULong		lul_Value
Long		ll_Cat
Long		ll_PathCounter
Long		lla_Span[]

Int		li_ReturnValue = 1



lla_Span[1] = 8000000
lla_Span[2] = 40000
lla_Span[3] = 200

lul_Value = aul_value

ll_PathCounter = 1


lsa_PathParts [ ll_Pathcounter ] = ""
lsa_NodeFolders [ ll_PathCounter ] = as_category

ll_PathCounter ++ // = 2
lsa_PathParts[ ll_PathCounter ] = as_category
lsa_NodeFolders[ ll_PathCounter ] = as_topic

ll_PathCounter++ // = 3
lsa_PathParts[ ll_PathCounter ] =  as_category + "\" + as_topic
lsa_NodeFolders [ ll_PathCounter ] = as_type

ll_PathCounter++  // = 4
lsa_PathParts[ ll_PathCounter ] = as_category + "\" + as_topic + "\" + as_type



For ll_PathCounter = 5 To 7  

	If ll_PathCounter = 5 THEN
		
		lul_ValueTemp = lul_value

	Else 

		lul_ValueTemp = mod ( lul_Value , lla_Span[ ll_PathCounter - 5 ] )  // previous span

	END IF
	
	IF  lla_Span[ ll_PathCounter - 4 ] <> 0 THEN
		
		ll_Cat = int ( lul_ValueTemp / lla_Span[ ll_PathCounter - 4 ] ) + 1
		ls_group = String(ll_Cat,"#,000")
		
	ELSE
		li_ReturnValue = -1
		EXIT
	END IF
	
	IF li_ReturnValue = 1 THEN
		lul_LowLim = lul_Value - ( mod ( lul_Value , lla_Span[ ll_PathCounter - 4  ] ) )
		
		If lul_LowLim > 0 THEN
			ls_lowRange = string ( lul_LowLim,"#,000" )
		Else
			ls_lowRange = String ( lul_LowLim )
		END IF
			
		ls_Range = ls_group+ " " + ls_lowRange 
		
		lsa_PathParts [ ll_PathCounter ] = lsa_PathParts [ ll_PathCounter - 1 ] + "\" + ls_Range
		lsa_NodeFolders[ ll_PathCounter - 1] = ls_Range
	END IF

NEXT


lsa_NodeFolders[ ll_PathCounter - 1 ] = String ( aul_Value,"#,000" )	
lsa_PathParts [ ll_PathCounter ] = lsa_PathParts [ ll_PathCounter - 1 ] + "\" + lsa_NodeFolders [ ll_pathCounter - 1 ]


asa_NodeFolders = lsa_NodeFolders
asa_PathParts = lsa_PathParts

return li_ReturnValue



end function

public function string of_getroot ();//Returns:   1 = Success 
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
String	lsa_Result[]
String	ls_Root
Integer	li_SqlCode

Integer	li_Return = 1

n_cst_string	lnv_String



//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 33 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( TRIM (ls_Description) ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE



//C:\PTIMAGES
IF li_Return = 1 THEN
	
	
	IF Right ( ls_Description , 1 ) <> "\" THEN
		ls_Description += "\"
	END IF
	
	//lnv_String.of_ParseToArray ( ls_Description , "\" , lsa_Result )
 // 	lnv_String.of_ArrayToString ( lsa_Result , "\" , ls_Root )
   //ls_Root += "\"
	
	ls_Root = ls_Description
	
END IF
 

RETURN ls_Root

end function

public function integer of_getimagetypesfortype (string as_Type, ref n_cst_beo_ImageType anva_ImageTypes[]);n_cst_bcm	lnv_bcm
n_cst_bcmService	lnv_bcmService
n_cst_Beo_ImageType	lnva_imageTypes[]
String		ls_SearchExpression

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )
	

ls_SearchExpression = "imagetype_type = '"  + as_Type + "'"

IF isValid ( lnv_bcm ) THEN
	
	lnv_bcmService.of_getallbeo ( lnv_bcm, ls_SearchExpression , lnva_ImageTypes )
	
END IF

anva_ImageTypes = lnva_ImageTypes

Return UpperBound (lnva_ImageTypes )
end function

public function integer of_unknownbatch ();/*=============================================================================
of_UnknownBatch
			Argument:
				ai_priv = specifies the users Privileges  // not implemented at this time
																		// instead a call is made to the priv 
																		// object
				
		This Function will open w_Imaging and prepare it for a unknownBatch Scan.
		

==============================================================================*/

Int		li_ReturnValue = 1
n_cst_msg lnv_msg
s_parm	lstr_parm
n_cst_privileges lnv_Privs
n_cst_privsManager	lnv_privsManager


lnv_privsManager = gnv_app.of_getPrivsManager()
lstr_Parm.is_Label = "TOPIC"
lstr_Parm.ia_Value = "UNKNOWN"
lnv_Msg.of_Add_Parm( lstr_Parm ) 

lstr_Parm.is_Label = "PRIV"
lstr_Parm.ia_Value = 1
lnv_Msg.of_Add_Parm( lstr_Parm ) 

//old code before dan changed it on 6-29-06
/*IF THIS.of_CheckConnection ( ) <> 0 THEN
	li_ReturnValue = -1
	MessageBox( "Control Connection" , "Profit Tools could not locate the necessary controls needed to perform this operation.") 
ELSEIF lnv_Privs.of_hasScanningRights ( ) THEN
	OpenSheetWithParm ( w_Imaging, lnv_msg , gnv_App.of_GetFrame ( ), 0, Layered! )
ELSE
	MessageBox( "Scan Batch" , "You do not have the required user rights to perform this operation. Request canceled.",EXCLAMATION! )
END IF
*/

//new dan code
IF THIS.of_CheckConnection ( ) <> 0 THEN
	li_ReturnValue = -1
	MessageBox( "Control Connection" , "Profit Tools could not locate the necessary controls needed to perform this operation.") 
ELSEIF lnv_privsManager.of_useadvancedprivs( ) THEN
	OpenSheetWithParm ( w_Imaging, lnv_msg , gnv_App.of_GetFrame ( ), 0, Layered! )
ELSE		//old way
	IF lnv_Privs.of_hasScanningRights ( ) THEN
		OpenSheetWithParm ( w_Imaging, lnv_msg , gnv_App.of_GetFrame ( ), 0, Layered! )
	ELSE
		MessageBox( "Scan Batch" , "You do not have the required user rights to perform this operation. Request canceled.",EXCLAMATION! )
	END IF
END IF
//--------------



Return li_ReturnValue
end function

protected function boolean of_validaterootaccess ();String	ls_Root
String	lsa_Result[]
String	ls_DriveLetter
String	ls_Path
Boolean	lb_ReturnValue 
Int		li_CreateRtn
Int		i

n_cst_FileSrvWin32 	lnv_FileSrv
lnv_FileSrv = CREATE n_cst_FileSrvWin32

n_cst_string	lnv_String


ls_Root = THIS.of_GetRoot ( )

IF Len (ls_Root) > 0 THEN
	lb_ReturnValue = lnv_FileSrv.of_DirectoryExists( ls_Root )
	
	
	IF lb_ReturnValue = FALSE THEN
		IF messageBox( "Image File Access", "The root path spcified in the system settings (" + ls_Root + ") does not exist. Would you like to create it now?", QUESTION! , YESNO! , 1 ) = 1 THEN
		
			lnv_String.of_ParseToArray ( ls_Root , ":" ,lsa_Result )
			ls_DriveLetter = lsa_Result[1] + ":"
			
			lnv_String.of_ParseToArray ( lsa_Result[2] , "\", lsa_Result )		
			ls_Path = ls_DriveLetter //+ lsa_Result[1]		
		//	li_CreateRtn =	lnv_FileSrv.of_CreateDirectory ( ls_Path )
			
			For i = 2 TO UpperBound ( lsa_Result )
				
				ls_Path += "\" + lsa_Result[i]
				li_CreateRtn =	lnv_FileSrv.of_CreateDirectory ( ls_Path )
				
			NEXT
			
			lb_ReturnValue = FileExists ( ls_path )
			
		END IF
	END IF
ELSE
	
	lb_ReturnValue = FALSE
END IF
	
DESTROY lnv_FileSrv

RETURN lb_ReturnValue
end function

public function integer of_missingimagereport (long ala_ids[], string as_topic);//String 	ls_SearchExpression
//String	ls_CurrentType
//String	lsa_Types[]
//String 	ls_ColName
//String	ls_ErrorMessage
//String	ls_Format
//String 	ls_ExistValue  = "ü"
//String	ls_NotExistValue = ""
//Blob		lblob_FullState
//Boolean	lb_Continue
//Long		j
//Long		k
//Long		ll_NewRow
//Long		ll_CurrentID
//String	ls_Report_name
//String	lsa_labels[]
//Any		laa_Values[] 
//Int		i
//Int		li_typeCount
//
//Int		li_returnValue = 1
//n_cst_msg	lnv_msg
//S_parm		lstr_Parm
//
//
//n_cst_bcm				lnv_Bcm
//n_cst_beo_ImageType	lnva_ImageTypes[]
//n_cst_beo_ImageType	lnva_ImageTypeCollection[]
//n_cst_beo_ImageType	lnv_CurrentImageBeo
//n_cst_bcmService		lnv_bcmService
//n_cst_dws 	lnv_dws
//DataStore lds_Images
//lds_Images = Create DataStore
//lds_Images.dataObject = "d_MissingImages2"
//
//n_cst_bso_ImageManager_pegasus	lnv_ImageManager
//lnv_ImageManager = Create n_cst_bso_ImageManager_Pegasus
//
//ls_ErrorMessage = "An error occurred while attempting to generate a missing image report."
//
//	
//setPointer( HOURGLASS! )
//
//IF NOT THIS.of_ValidateRootAccess ( ) THEN
//	ls_ErrorMessage = "An error occurred while attempting to access the image files. Processing stopped." 
//	li_ReturnValue = -1	
//END IF	
//
//
//IF li_ReturnValue = 1 THEN
//	
//	lstr_parm.is_Label = "TOPIC"
//	lstr_Parm.ia_Value = as_topic
//	lnv_msg.of_Add_parm ( lstr_parm )
//	
//	openWithParm ( w_MissingImageTypeSelection  , lnv_msg )
//	
//	SetPointer ( HOURGLASS! )
//	
//	lnv_msg = message.powerobjectparm
//
//	IF isValid ( lnv_msg ) THEN
//		
//		IF lnv_Msg.of_get_Parm ( "CONTINUE", lstr_Parm )  <> 0 THEN
//			lb_continue = lstr_Parm.ia_Value 
//		END IF
//		
//		IF lnv_Msg.of_get_Parm ( "FORMAT", lstr_Parm )  <> 0 THEN
//			ls_Format = lstr_Parm.ia_Value 
//			IF ls_Format = "" THEN
//				li_ReturnValue = -1
//			ELSEIF ls_Format = "Mark Images on File" THEN
//				lds_Images.object.Missing_images.Text = "= Images on File"
//				
//			ELSE
//				ls_ExistValue = ""
//				ls_NotExistValue = "ü"
//				lds_Images.object.Missing_images.Text = "= Missing Images"
//			END IF
//		END IF
//	END IF
//		
//	IF lb_Continue THEN
//		IF lnv_Msg.of_Get_Parm ( "TYPES" , lstr_parm ) <> 0 THEN
//			lsa_Types = lstr_Parm.ia_Value
//		ELSE 
//			li_ReturnValue = -1
//		END IF
//	ELSE
//		li_ReturnValue = 0 // user canceled
//	END IF
//END IF
//
//
//IF li_ReturnValue = 1 THEN
//	For i = 1 TO upperBound ( lsa_types ) 
//		li_TypeCount = THIS.of_getImageTypesForType ( lsa_Types[i] , lnva_ImageTypes )
//		IF li_TypeCount > 0 THEN
//			For k = 1 TO li_TypeCount
//				lnva_ImageTypeCollection [ upperBound ( lnva_ImagetypeCollection ) + 1 ] = lnva_ImageTypes[k]
//			NEXT
//		ELSEIF li_TypeCount = -1 THEN
//			li_ReturnValue = -1
//		END IF
//	NEXT
//END IF
//		
//		
//		
//IF li_ReturnValue = 1 THEN
//	IF upperBound ( lnva_ImageTypeCollection ) > 19 THEN
//		messageBox ( "Image Types" , "Please limit the number of types to less then 20." )
//		Return 0  // change this and inform user   // MID CODE RTN
//	END IF
//	FOR k = 1 TO upperBound ( lnva_ImageTypeCollection )
//		lnv_CurrentImageBEO = lnva_ImageTypeCollection[ k ]
//		ls_CurrentType = lnv_CurrentImageBeo.of_GetType ( )
//				
//		ls_colname = lds_Images.describe("#" + string(K+1) + ".name")
//		ls_ColName += "_t"
//		lds_Images.modify(ls_colname + ".font.escapement = 450 " )
//		
//		lds_Images.modify(ls_ColName + ".text = '"+ls_CurrentType+"'")
//	Next
//	
//END IF		
//	
//	
//IF li_ReturnValue = 1 THEN
//	FOR j = 1 TO upperBound ( ala_ids[] )
//		
//		ll_NewRow = lds_Images.InsertRow(0)
//		ll_CurrentID = ala_IDs [ j ]	
//		lds_Images.object.Image_id[j] =  ll_CurrentID
//		
//		FOR k = 1 TO upperBound ( lnva_ImageTypeCollection )
//			lnv_CurrentImageBEO = lnva_ImageTypeCollection[ k ]
//			ls_CurrentType = lnv_CurrentImageBeo.of_GetType ( )
//			
//			ls_colname = lds_Images.describe("#" + string(K+1) + ".name")
//			
//			IF lnv_Imagemanager.of_DoesImageExist ( lnv_currentImageBeo , ll_CurrentID ) THEN
//				lds_Images.SetItem ( ll_NewRow, ls_colName , ls_ExistValue )
//			ELSE
//				lds_Images.SetItem ( ll_NewRow, ls_colName , ls_NotExistValue )
//			END IF
//			
//		NEXT
//	NEXT
//	
//END IF
//
//IF li_ReturnValue = 1 THEN
//	
//	ls_report_name = "Missing Image Report"
// RDT 102602 This method is obsolete. Use the following instead.
messagebox("Program Error ","Obsolete Method call to: n_cst_bso_ImageManager.of_MissingImageReport()")

Integer	li_Return
n_cst_bso_Document_Manager lnv_DocMan
lnv_DocMan = Create n_cst_bso_Document_Manager 
li_Return = lnv_DocMan.of_MissingDocumentReport(ala_ids[], as_topic )
Return li_Return

//		
//	lsa_labels[upperbound(lsa_labels) + 1] = "TARGET!"
//	laa_values[upperbound(laa_values) + 1] = lds_Images
//	
//	lsa_labels[upperbound(lsa_labels) + 1] = "REPORT_NAME!"
//	laa_values[upperbound(laa_values) + 1] = ls_Report_Name
//	
//	lsa_labels[upperbound(lsa_labels) + 1] = "REPORT_LABEL!"
//	laa_values[upperbound(laa_values) + 1] = "OFFICIAL COPY"
//	
//	lnv_dws.of_create_header(lsa_labels, laa_values)
//	
//	lds_Images.getFullstate ( lblob_fullstate )
//	
//	lstr_parm.is_Label = "DATAOBJECT"
//	lstr_Parm.ia_Value = lblob_FullState
//	lnv_msg.of_Add_parm ( lstr_parm )
//	
//	lstr_parm.is_Label = "TOPIC"
//	lstr_Parm.ia_Value = as_topic
//	lnv_msg.of_Add_parm ( lstr_parm )
//	
//	openWithParm ( w_MissingImageDisplay  , lnv_msg )
//	
//	lnv_msg = message.powerobjectparm
//END IF	
//
//
//
//IF li_ReturnValue = -1 THEN
//	MessageBox( "Missing Image Report" , ls_ErrorMessage )
//END IF
//
//DESTROY lds_Images
//DESTROY lnv_ImageManager
//
//Return li_returnValue
//	
//
end function

public function integer of_getimagetypes (string as_topic, ref n_cst_beo_imagetype anva_imagetypes[]);/*====================================================================================
of_GetImageTypes
				Arguments:
							as_topic	=			The topic for which you want to find all image 
													types for.
													
							anva_imagetypes[]	= The list of all the image types found for 
													  the specified topic.


=====================================================================================*/


Long  	ll_RowCount
Long		i
Long		ll_Index

String	ls_Topic 
String	ls_ErrorMessage
Int		li_ReturnValue = 1

n_cst_bcm	lnv_Bcm
n_cst_beo_ImageType  	lnva_ImageType[]
n_cst_beo_ImageType		lnv_CurrentImageType


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

ls_ErrorMessage = "An error occurred while retrieving the list of image types."
ls_Topic = as_topic

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )

IF Not IsValid ( lnv_Bcm ) THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	
	ll_RowCount = lnv_Bcm.getCount () 

	For i = 1 To ll_RowCount
	
		ll_Index = lnv_Bcm.getBeoIndex ( i )
		
		lnv_CurrentImageType = lnv_Bcm.getAt ( ll_Index )
			
		IF isValid ( lnv_CurrentImageType ) THEN
			
			IF lnv_CurrentImageType.of_GetTopic ( ) = ls_Topic THEN
				
				lnva_ImageType[ upperBound ( lnva_ImageType ) + 1] = lnv_CurrentImageType
				
			END IF
			
		END IF

	NEXT
	
END IF

anva_imagetypes[] = lnva_ImageType


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = 1 THEN
	li_ReturnValue = upperBound ( anva_imagetypes[] )
END IF 

Return li_ReturnValue
end function

public function integer of_gettypevaluelist (string as_topic, ref string as_valuelist);Long		ll_RowCount
Long		i
Long		ll_index
String 	ls_Topic
String	ls_ErrorMessage
String	ls_Type
String	ls_Types
Int		li_ReturnValue = 1

n_cst_bcm	lnv_Bcm

n_cst_beo_ImageType		lnv_CurrentImageType


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

ls_ErrorMessage = "An error occurred while retrieving the list of image types."
ls_Topic = as_topic

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )

IF Not IsValid ( lnv_Bcm ) THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	
	ll_RowCount = lnv_Bcm.getCount () 

	For i = 1 To ll_RowCount
	
		ll_Index = lnv_Bcm.getBeoIndex ( i )
		
		lnv_CurrentImageType = lnv_Bcm.getAt ( ll_Index )
			
		IF isValid ( lnv_CurrentImageType ) THEN
			
			IF lnv_CurrentImageType.of_GetTopic ( ) = ls_Topic THEN
				 ls_Type = lnv_CurrentImageType.of_GetType( )
				IF i = 1 THEN 
					ls_Types = ls_Type+"~t"+ls_Type+"/"
				ELSE
					ls_Types += ls_Type+"~t"+ls_Type+"/"
				END IF
				
				
				
			END IF
			
		END IF

	NEXT
	
END IF

as_ValueList = ls_Types


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



Return li_ReturnValue
end function

public function integer of_checkconnection ();/*
 0  Success
-1  Invalid Call: the argument is the Object property of a control
-2  Class name not found
-3  Object could not be created
-4  Could not connect to object
-9  Other error
*/

oleobject	ole_Test
ole_Test = CREATE oleObject
Int	li_ReturnValue = -9
Int	li_ImageRtn
Int	li_PrintRtn
String 	ls_ValueArray[]
n_cst_LicenseManager	lnv_LicenseManager
n_cst_imagingversioncontrol	lnv_ImagingVersion

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN
	
	IF THIS.of_GetImagingversioncontrol( lnv_ImagingVersion ) = 1 THEN
//	IF RegistryValues( "HKEY_CLASSES_ROOT\imagXpr4.ImagXpress.1",ls_valuearray) = 1 THEN // dlls installed
		lnv_ImagingVersion.of_unlock( )
//		IX_Unlock( 1908224506, 378711776, 1341927877, 10527 )
//		PP_Unlock( 1908224506, 378711776, 1341927877, 10527 )
		
		
		li_ImageRtn = ole_Test.ConnectToNewObject ( lnv_ImagingVersion.of_getimagexpressobjectstring( ) )
		
		IF li_ImageRtn = 0 THEN
			ole_Test.DisconnectObject()
		END IF		
		
		li_PrintRtn= ole_Test.ConnectToNewObject (lnv_ImagingVersion.of_getprintproObjectstring( ) )
		IF li_PrintRtn = 0 THEN
			ole_Test.DisconnectObject()
		END IF
		

		IF li_ImageRtn = 0 AND li_PRintRtn = 0 THEN
			li_ReturnValue = 0
		END IF

	END IF
	DESTROY ( lnv_ImagingVersion )

END IF
	
	
DESTROY ole_Test

Return li_ReturnValue
end function

public function integer of_scan (long ala_ids[], long al_activeid, ref string as_topic, string as_context, oleobject anv_scanobject);/*==================================================================================
	of_Scan	
				Arguments:
						ala_ids[]
						al_activeid
						as_topic
						lb_knownid
						anv_scanobject

	This Function can be called to start the scanning process
	It will open a window ( w_imageTypes ) so the user can select the image properties.
	
	
	Return values	 2 = Batch - allow user to change TMP Nos	
						 1 = success
						-2 = user canceled
						-1	= failure
						 0 = Mod Lock Failure
						
>> all propagated errors will be displayed at this level <<
//RDT 7-29-03 scan without image types						
==================================================================================*/

Boolean	lb_KnownID
Boolean 	lb_Settings
Boolean	lb_ScannerSelect
Boolean 	lb_Feeder
Boolean	lb_Continue  = TRUE // used for mod locks
Boolean	lb_NoImageType 
Long 		ll_ID
Long		ll_ScanSource
String 	ls_Topic
String	ls_Type
String	ls_Cat
String	ls_ErrorMessage
Int		li_ReturnValue = 1
Int		li_Return 

n_cst_OFRError lnv_Error
n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_LicenseManager	lnv_LicenseManager


IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Imaging ) THEN

	//	Request a lock for user
	IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Scanning, "E" ) < 0 THEN
		lb_Continue = FALSE
		li_ReturnValue = 0
	END IF

	IF lb_Continue THEN

		ls_ErrorMessage = "An error occurred while attempting to scan."
		
		s_parm		lstr_parm
		n_cst_msg	lnv_msg
		
		n_cst_beo_ImageType 	lnv_ImageType

		IF THIS.of_CheckConnection ( ) <> 0 THEN
			li_ReturnValue = -1
			MessageBox( "Control Connection" , "Profit Tools could not locate the necessary controls needed to perform this operation.") 
		END IF

		IF isValid ( anv_scanobject  ) AND NOT isNull ( anv_scanobject ) and li_ReturnValue = 1 THEN

			IF	NOT anv_scanobject.ScannerLoaded THEN
				ls_ErrorMessage = "No scanner drivers could be located."
				MessageBox ( "New Scan", ls_ErrorMessage, EXCLAMATION! )
				li_ReturnValue = -1
			END IF

		ELSE
			li_ReturnValue = -1
		END IF

		IF li_ReturnValue = 1 THEN
			IF Not THIS.of_ValidateRootAccess( ) THEN
				MessageBox( "File Access" , "The root path specified in the system settings could not be accessed. Be sure the folder exists and try again.", EXCLAMATION! )
				li_ReturnValue = -1
			END IF
		END IF
				
				
		IF li_ReturnValue = 1 THEN
			lstr_parm.is_Label = "IDARRAY"
			lstr_Parm.ia_Value = ala_IDs
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			lstr_parm.is_Label = "ACTIVEID"
			lstr_Parm.ia_Value = al_ActiveID
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			lstr_parm.is_Label = "TOPIC"
			lstr_Parm.ia_Value = as_topic
			lnv_Msg.of_Add_Parm ( lstr_Parm )
			
			
			lstr_parm.is_Label = "CONTEXT"
			lstr_Parm.ia_Value = as_context
			lnv_Msg.of_Add_Parm ( lstr_Parm )
		
			// w_imageType will be opened so the user can select an imageType and ID
			OpenWithParm ( w_imageType , lnv_msg )
			
		END IF
			
		// outBound
		
		///////////////////////////////////////
		
		// inBound
		
		// get The selected values here. 
		lnv_msg = message.powerobjectparm
		
		if IsValid ( lnv_Msg )  AND li_ReturnValue = 1 THEN
			
			//First check to see if the user canceled
			IF lnv_msg.of_get_Parm ("CONTINUE" , lstr_Parm ) <> 0 THEN
				
				IF lstr_Parm.ia_Value THEN // bool from continue
				
					IF lnv_msg.of_get_Parm ("NOIMAGETYPE" , lstr_Parm ) <> 0 THEN		//RDT 7-29-03 
						lb_NoImageType = lstr_Parm.ia_Value 									//RDT 7-29-03 
					END IF																				//RDT 7-29-03 
					
				
					IF lnv_msg.of_get_Parm ("SELECTEDID" , lstr_Parm ) <> 0 THEN
						ll_ID = Long  ( lstr_Parm.ia_Value )
					END IF

					If NOT lb_NoImageType Then 													//RDT 7-29-03 
						IF lnv_msg.of_get_Parm ("IMAGETYPE" , lstr_Parm ) <> 0 THEN
							lnv_ImageType =  lstr_Parm.ia_Value 
						END IF
					END IF																				//RDT 7-29-03 
				
					
					IF lnv_msg.of_get_Parm ("KNOWNID" , lstr_Parm ) <> 0 THEN
						lb_KnownID =  lstr_Parm.ia_Value 
					END IF
					
					IF lnv_msg.of_get_Parm ("SETTINGS" , lstr_Parm ) <> 0 THEN
						lb_Settings =  lstr_Parm.ia_Value 
					END IF
					
					IF lnv_msg.of_get_Parm ("SCANNERSELECT" , lstr_Parm ) <> 0 THEN
						lb_ScannerSelect =  lstr_Parm.ia_Value 
					END IF
					
					IF lnv_msg.of_get_Parm ("FEEDER" , lstr_Parm ) <> 0 THEN
						lb_Feeder =  lstr_Parm.ia_Value 
					END IF
					
					IF lnv_msg.of_get_Parm ("SCANSOURCE" , lstr_Parm ) <> 0 THEN
						ll_ScanSource =  lstr_Parm.ia_Value 
					END IF
				
					
					IF isValid ( lnv_ImageType ) THEN						
						as_topic = lnv_ImageType.of_GetTopic ( )
						IF lb_Feeder THEN
							
							messageBox( "New Multi-Page Scan" , "Be sure the documents are properly loaded in the scanner's automatic document feeder." )
						
						ELSE
							messageBox( "New Scan" , "Be sure the document is properly loaded in the scanner." )
						END IF
						IF lb_knownid THEN
							
							IF ISValid ( w_Imaging ) THEN
							//	w_imaging.wf_ChangeWindowContext ( 1 )
							END IF
							
							li_Return  = THIS.of_ScanBatch ( lnv_ImageType , ll_ID , TRUE, anv_scanobject , lb_Settings , lb_ScannerSelect , lb_Feeder, ll_ScanSource ) 

						ELSE
							IF ISValid ( w_Imaging ) THEN
								w_imaging.wf_ChangeWindowContext ( 2 )
							END IF
							
							li_Return = THIS.of_ScanUnknownBatch ( anv_ScanObject , lnv_ImageType , lb_Settings , lb_ScannerSelect , lb_Feeder, ll_scanSource )
							
							IF li_Return > 0 THEN
								li_ReturnValue  = 2
							END IF
						END IF
					ELSE
						If lb_NoImageType Then 																				//RDT 7-29-03 
							IF lb_Feeder THEN
								messageBox( "New Multi-Page Scan" , "Be sure the documents are properly loaded in the scanner's automatic document feeder." )//RDT 7-29-03 
							ELSE																									//RDT 7-29-03 
								messageBox( "New Scan" , "Be sure the document is properly loaded in the scanner." )//RDT 7-29-03 
							END IF																								//RDT 7-29-03 
							li_Return  = THIS.of_ScanNoTypeBatch ( ll_ID , anv_scanobject , lb_ScannerSelect , lb_Settings , ll_ScanSource , lb_Feeder ) //RDT 7-29-03 
						End If 																									//RDT 7-29-03 
						
					END IF		
		
				ELSE
					li_Return = -2
				END IF
				
				
			ELSE
				li_Return = -1
			END IF
			
			
		ELSE
			li_Return = -1
		END IF
	
		
		//* Error Reporting *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
		int 	li_errorCount
		int	i
		
		lnv_ErrorCollection = This.GetOFRErrorCollection ( )
		lnv_Errorcollection.GetErrorArray( lnva_Error )
		li_ErrorCount = upperBound(lnva_Error)
		
		For i = 1 TO li_ErrorCount
		
			MessageBox("Scanning" , string( lnva_Error[i].getErrorMessage() ), EXCLAMATION! )
		
		next
		
		IF li_ErrorCount > 0 THEN
			li_ReturnValue = -1
		END IF
		//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//
		
		
	END IF // lb_continue From Mod Lock
	
ELSE
	MessageBox("Document Imaging", "You are not currently licensed for this module. Please Contact Profit Tools." ) 
	
END IF

RETURN li_ReturnValue







end function

protected function integer of_scanbatch (n_cst_beo_imagetype anv_imagetype, long al_id, boolean ab_multipage, oleobject anv_olescan, boolean ab_settings, boolean ab_scannerselect, boolean ab_feeder, long al_scansource);/*=======================================================================================
Note: The name of this function is missleading This function only scans single documents.
if you want to scan a batch the function of_ScanUnknownBatch () can be called.

of_ScanBatch: This function takes aguments:

					anv_imagetype = Beo specifing the imagetype for the document about to be 
										 scanned
										 
					al_id			  = the id for the image ( i.e.:TMP No )
					
					ab_multipage  = bool specifing whether the document is a multiple page doc.
										 if ab_multipage = FALSE then documents will replace existing
										 
					anv_olescan   = Pegasus COM object which should be valid when passed in
					
	Description:
					This Function is responsible for scanning a single document. when the scan is 
				complete the new document will be displayed in the image list if a valid window 
				exists.
					
					



========================================================================================*/

String 	ls_Topic
String	ls_Category
String	ls_Type
String 	ls_FileName
Ulong		lul_id
String	lsa_PathParts [ ]
String	lsa_NodeFolders [ ]

String	ls_TotalPath
String	ls_DriveLetter 
String	ls_ErrorMessage

Int		li_CreatePathReturn
Int		li_CreateFolderReturn
Int		li_result

Int		li_Error
Long		ll_ScanError
Int 		li_ReturnValue = 1
String	ls_moddescript
Long		ll_numpages

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error
n_cst_beo_Image	lnv_Image

oleObject		lnv_Ole_ScanObject
oleObject		lnv_ole_imageObject

lnv_Ole_ScanObject  = anv_oleScan
lul_id = al_ID


ls_ErrorMessage = "An error occurred while attempting to scan."


IF lul_id = 0 THEN
	ls_ErrorMessage = "The image ID is not valid for this type of scan."
	li_ReturnValue = -1
END IF


IF li_ReturnValue =1 THEN
	ls_DriveLetter = THIS.of_GetRoot ( )
	
	IF Len ( ls_DriveLetter ) = 0 THEN
		ls_ErrorMessage = "An error occurred while locating folder to store document."
		li_ReturnValue = -1
	END IF
END IF



IF li_ReturnValue = 1 THEN
	IF isValid ( anv_imagetype ) THEN
		ls_topic = anv_ImageType.of_GetTopic()
		ls_Category = anv_ImageType.of_GetCategory()
		ls_Type = anv_ImageType.of_GetType()
	ELSE
		ls_ErrorMessage = "The image type for the new document could not be resolved."
		li_ReturnValue = -1
	END IF
END IF



IF li_ReturnValue = 1 THEN

	IF isValid ( lnv_Ole_ScanObject ) THEN
		
		lnv_Ole_ScanObject.SaveFileType=4 // group 4 
		
		li_CreatePathReturn = THIS.of_CreatePath ( ls_topic , ls_Category , ls_Type , lul_id , lsa_PathParts[] , lsa_NodeFolders[])
		IF li_CreatePathReturn <> 1 THEN
			li_ReturnValue = -1
		END IF
			
		IF li_returnValue = 1 THEN
			li_CreateFolderReturn = THIS.of_CreateFolder ( lsa_PathParts[] , lsa_NodeFolders[]  ) 
		END IF
		
		IF li_CreateFolderReturn <> 1 THEN
			li_ReturnValue = -1 
		END IF
		
		IF li_ReturnValue = 1 THEN
			
			ls_FileName = lsa_NodeFolders [ upperBound ( lsa_NodeFolders ) ] 
		
		
			ls_TotalPath = ls_DriveLetter + lsa_PathParts[ upperBound(lsa_Pathparts) ] + "\" +ls_FileName+".tif"
	
			IF ab_multiPage THEN
				lnv_Ole_ScanObject.ScanMultipage = TRUE
				
			END IF
		
		
			IF li_ReturnValue = 1 AND ab_ScannerSelect THEN	
				lnv_Ole_ScanObject.SetScanName ( )
				li_Error = lnv_ole_ScanObject.ScanErrorCode
				
				IF li_Error = -4526 THEN
					
					//li_Error = 0
					//IF MessageBox ( "Scanner Select", "By canceling out of the scanner selection you have removed any previously selected scanner. Do you want to select a scanner?", QUESTION! ,YESNO! , 1) = 1 THEN
					//	lnv_Ole_ScanObject.SetScanName ( )
					//	li_Error = lnv_ole_ScanObject.ScanErrorCode
					//END IF
				END IF	
			END IF
		    
			//MessageBox ( "ERROR FROM SCAN SELECT" , string ( li_Error )  + string (lnv_ole_ScanObject.ScanErrorString) )
			IF li_Error <> 0 THEN
				li_ReturnValue = -2
				li_Error = 0
			END IF
		
			IF li_ReturnValue = 1 THEN
				This.of_DefaultScannerSettings(lnv_Ole_ScanObject) //MFS 5/29/05 - just DPI for now
			END IF
			
			
			IF li_ReturnValue = 1 AND ab_Settings THEN		
				lnv_Ole_ScanObject.SettingsDialog( )
				li_Error = lnv_ole_ScanObject.ScanErrorCode
			END IF
			
			IF li_Error <> 0 THEN
				li_ReturnValue = -1
			END IF
			
			IF li_ReturnValue = 1 THEN
					lnv_Ole_ScanObject.CreateDib = True
					lnv_Ole_ScanObject.ScanFileName = ls_TotalPath

					
					IF ab_Feeder THEN
						IF al_ScanSource <> 0 THEN
							lnv_Ole_ScanObject.ScanSetting = 10
							lnv_Ole_ScanObject.ScanSettingLong = al_ScanSource
						END IF
						lnv_Ole_ScanObject.ScanBatch ( )
					ELSE
						IF al_ScanSource <> 0 THEN
							lnv_Ole_ScanObject.ScanSetting = 10
							lnv_Ole_ScanObject.ScanSettingLong = al_ScanSource 
						END IF
						
						CHOOSE CASE al_ScanSource 
							
						CASE 3 // explicitly picked feeder
							lnv_Ole_ScanObject.ScanBatch ( )
							
						CASE ELSE 
							lnv_Ole_ScanObject.ScanSingle( )
							
						END CHOOSE
					END IF
					
					
						
							
							
					ll_ScanError = lnv_Ole_ScanObject.ScanErrorCode
					IF ll_ScanError <> 0 THEN 
						li_ReturnValue = -1
					END IF
			END IF 
			
			IF li_ReturnValue = 1 THEN
				li_returnValue = 	THIS.of_ViewImages ( ls_topic , {al_ID} , 1 )
			END IF
				
		END IF
	ELSE 
		li_ReturnValue = -1 
		ls_ErrorMessage = "The scanning process could not be completed do to internal complications."
	END IF
	
	//added by Dan 1-9-2006
	IF li_returnValue = 1 THEN
		IF NOT isValid(inv_Bcm) THEN
			inv_Bcm = gnv_BcmMgr.CreateBcm ( )
		END IF
		inv_Bcm.SetDlk ( "n_cst_dlkc_image" )
		inv_Bcm.AddClass ( "n_cst_beo_image" )
		li_result = inv_Bcm.NewBeo ( lnv_Image )
		li_result = THIS.of_PopulateImage (  ls_TotalPath , lnv_image)
		
		if this.of_getoleimgaeobject( lnv_ole_imageObject )  = 1 THEN
			ll_numpages = lnv_image.of_calcpages( lnv_ole_imageObject )
		END IF
		
		ls_moddescript = "Scanned "+ ls_Type +" For: "+ string( lul_id )+ ", total page count: "+ string(ll_numPages)
		
		lnv_Image.of_updatemodlog( /*lul_id, ls_Category, ls_Type, ls_topic,*/ ls_moddescript )
	END IF
	//------------------------------
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF isValid( lnv_ole_imageObject ) THEN
	lnv_ole_imageObject.disconnectobject( )
	destroy lnv_ole_imageObject 
END IF

return li_ReturnValue

end function

protected function integer of_scanunknownbatch (oleobject anv_olescan, n_cst_beo_imagetype anv_imagetype, boolean ab_settings, boolean ab_scannerselect, boolean ab_feeder, long al_scansource);/*====================================================================================


of_ScanUnknownBatch
			Arguments:
				anv_olescan
				anv_imagetype
				
				This Function will scan a batch of documents without knowing the ID. The ID 
				will be to 0.	A valid ImageType is needed to properly resolve the image when
				it is analyzed for a barcode
				
				
			
NOTE:
Folder name lengths can't exceed a length of 8 and can't contain "," when using pegasus's
schema.
=======================================================================================*/
Int 		li_DocsScaned = -1
Int		li_Error
Int		li_ReturnValue = 1
Int		li_NumBarcodes
String	ls_ErrorMessage
String	ls_TotalPath
String	ls_Root
String	ls_schemaRoot
Long		ll_TempHdib
Boolean  lb_Again = FALSE
String	ls_moddeScript



ls_schemaRoot = THIS.of_GetnextSchemaRoot ( )

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

OleObject	ole_Scan

ls_ErrorMessage = "An error occurred while attempting to scan a batch of documents."

ole_Scan = anv_OleScan

IF li_ReturnValue = 1 THEN
	
	ls_Root = THIS.of_GetBatchFolder( )
	
	IF Len ( ls_Root ) = 0 THEN
		ls_ErrorMessage = "An error occurred while attempting to locate a temporary folder to store a the batch of documents." 
		li_ReturnValue = -1
	END IF
	
END IF

IF li_ReturnValue = 1 THEN
	
	IF ab_ScannerSelect THEN
		
			ole_scan.SetScanName( )
			li_Error = ole_Scan.ScanErrorCode
//			IF li_Error = -4526 THEN
//				IF MessageBox ( "Scanner Select", "By canceling out of the scanner selection you have removed any previously selected scanner. Do you want to select a scanner?", QUESTION! ,YESNO! , 1) = 1 THEN
//					lb_Again = TRUE
//				ELSE
//					lb_Again =FALSE
//				END IF
			
		
	END IF
	
	IF li_Error < 0 THEN
		li_ReturnValue  = -2
	END IF
	
	IF li_ReturnValue = 1 THEN
		This.of_DefaultScannerSettings(ole_Scan) //MFS 5/29/05 - just DPI for now
	END IF
	
	IF li_ReturnValue = 1 AND ab_Settings THEN 
		ole_scan.SettingsDialog( )
		li_Error = ole_Scan.ScanErrorCode
	END IF
	
	IF li_Error < 0 THEN
		li_ReturnValue = -1
	END IF
	
	
	IF li_ReturnValue = 1 THEN
		ole_Scan.SaveFileType=4 // group 4   3.8
		ole_Scan.ScanMultiPage= False
		
		IF ab_Feeder THEN
			
			ole_Scan.UseSchema = TRUE
			ole_Scan.ScanFileName = ls_Root + ls_schemaRoot
			ole_Scan.ScanFileDir = ls_Root
			ole_Scan.ScanFileRoot = ls_schemaRoot
			ole_Scan.ScanFileSchema= "$####"
			IF al_ScanSource <> 0 THEN					
				ole_Scan.ScanSetting = 10
				ole_Scan.ScanSettingLong = al_ScanSource
			END IF
			ole_scan.ScanBatch ( )
		ELSE		
			ole_Scan.ScanFileName = ls_Root + ls_schemaRoot + "0001.tif"
			ole_Scan.ScanSetting = 10
			ole_Scan.ScanSettingLong = 2
			ole_scan.ScanSingle ( )
		END IF
			
	END IF
	
	li_Error = ole_Scan.ScanErrorCode
	
	IF li_Error < 0 THEN
		li_ReturnValue = -1
	END IF
	
	IF li_Returnvalue = 1 THEN
		
		li_ReturnValue = THIS.of_PopulateUnknown ( anv_ImageType )

	END IF
	
	
	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


Return li_ReturnValue

end function

public function integer of_pasteimage (readonly long ala_shipid[]);//
/***************************************************************************************
NAME			: of_PasteImage
ACCESS		: Public 
ARGUMENTS	: Long Array	(Ship ids)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Copies the image to the shipments passed in

REVISION		: RDT 3-12-03 
***************************************************************************************/
String 	ls_Type, &
			ls_Shipments

String	ls_TargetPath
String 	ls_SourcePath

Integer	li_Return = 1
Long		ll_Count, &
			ll_Upper, &
			ll_ShipIDCount, &
			ll_ShipUpper

Any 		la_image[]

n_cst_beo_Image lnva_Images[]


ls_Type = gnv_app.inv_ClipBoard.cs_Image

IF gnv_app.inv_ClipBoard.of_GetType() <> ls_Type Then 
	MessageBox("ClipBoard Paste Failed","The clipboard does not contain any images.")
	li_Return = -1
End IF

If li_Return = 1 Then
	ll_ShipUpper = UpperBound( ala_ShipID[] )
	If ll_ShipUpper > 1 Then 
		ls_shipments = " To the " + String(ll_ShipUpper) + " Tmp#'s."
	Else
		ls_Shipments = " To Tmp# " + String( ala_Shipid[ 1 ] )		
	End If
End If

If li_Return = 1 Then
	
	gnv_app.inv_ClipBoard.of_GetContents( la_Image, ls_Type )
	lnva_Images[] = la_Image[]
	//loop thru each image and copy it to each shipment
	ll_Upper = UpperBound( lnva_Images[] )
	
	For ll_Count = 1 to ll_Upper
		If Messagebox("Paste Image","Paste Tmp# "+String( lnva_images[ ll_Count].of_getid ( ) ) + &
					" Image "+lnva_images[ ll_Count ].of_gettype ( ) + ls_Shipments, Question!, YesNo!,1 ) = 1 Then 

					For ll_ShipIDCount = 1 to ll_ShipUpper 
						li_Return = This.of_CopyImage( lnva_images[ ll_Count ], ala_shipid[ ll_ShipIDCount] )
					Next
		End If

	Next

End if


Return li_Return 
end function

protected function integer of_loadimagelistnotype (string asa_imagepaths[], n_cst_beo_imagetype anv_imagetype, long al_id);/*==================================================================================

of_LoadImageListNoType
						Arguments:
						
							asa_imagepaths[] = an array of image Paths that are to be displayed.
							
							anv_imagetype    = IF VALID - then it is assumed that the path 
													 can't be parsed to determin the image type ( ie 
													 unknown batch ).
													 IF NOT VALID - Then the image type will be extracted
													 from the path.
					
						Description:
										This function will update the image list in the window 
										w_imageList if it is valid with a valid ui_link. 

==============================================================*/
String		lsa_ImagePaths[]
String		ls_ErrorMessage
Long 			k
Int			li_ReturnValue = 1

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_bcm			lnv_Bcm
n_cst_beo_Image	lnv_Image


IF NOT isValid (  w_imaging.dw_ImageList.inv_UILink ) THEN
	li_ReturnValue = -1
	ls_ErrorMessage = "The updating of the image list could not be performed."
END IF

	
IF li_ReturnValue = 1 THEN	
	lsa_ImagePaths = asa_imagepaths[]
	
	lnv_Bcm = gnv_BcmMgr.CreateBcm ( )
	lnv_Bcm.SetDlk ( "n_cst_dlkc_image" )
	lnv_Bcm.AddClass ( "n_cst_beo_image" )
	
	IF Not IsValid ( lnv_bcm ) THEN
		li_ReturnValue = -1
	END IF
		
	IF li_ReturnValue = 1 THEN
		
		FOR K = 1 to upperbound ( lsa_ImagePaths ) 
			
			IF NOT THIS.of_DoesImageExist ( lsa_ImagePaths [ k ]  ) THEN
				CONTINUE
			END IF
			Long	ll_NewRtn
			ll_NewRtn = lnv_Bcm.NewBeo ( lnv_Image )
			
	
			IF IsValid ( lnv_Image ) THEN
				
				IF isValid ( anv_ImageType ) THEN
					
					lnv_Image.of_SetImageType ( anv_imagetype )
					lnv_Image.of_SetFilePath ( lsa_ImagePaths [ k ] )
					lnv_image.of_setid( al_ID, FALSE )
					
				
				ELSE
					li_ReturnValue = THIS.of_PopulateImage ( lsa_ImagePaths [ k ]  , lnv_image)
				END IF

			ELSE
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while attempting to update the image list."
				EXIT
			END IF
			
		NEXT
		
	END IF
END IF

IF li_ReturnValue = 1 THEN
	
	w_imaging.dw_ImageList.inv_UILink.SetBcm ( lnv_Bcm )
	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


Return li_ReturnValue


end function

public function integer of_populatenotype (string as_imagepath, ref n_cst_beo_image anv_image, long al_id);/*========================================================================================
of_populateNoType
					Arguments:
								as_imagepath
								anv_image
								al_id
								
				This function the populates anv_image with the proper properties.

=======================================================================================*/
String	ls_Topic
String	ls_Type
String	ls_Category
String 	lsa_Result [ ]
String	ls_ErrorMessage
Int		li_ReturnValue = 1


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

n_cst_beo_ImageType	lnv_ImageType

n_cst_beo_Image	lnv_Image
n_cst_string	lnv_string

ls_ErrorMessage = "An error occurred while attempting to populate an image."

lnv_Image = anv_Image

IF NOT IsValid ( lnv_Image ) THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	
	ls_Category = "UNSECURE"
	ls_Topic = "SHIPMENT"
	ls_Type	= "NONE"
	
		
		lnv_image.of_SetTopic ( ls_Topic ) 
		lnv_image.of_SetType ( ls_Type ) 
		lnv_image.of_Setcategory ( ls_Category  ) 
	
		lnv_Image.of_SetImageType ( lnv_ImageType )
		
		lnv_image.of_SetID( al_id, FALSE )
		lnv_Image.of_SetFilePath ( as_imagepath )
			
		anv_Image = lnv_Image
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\


Return li_ReturnValue

end function

public function integer of_copyimage (n_cst_beo_image anv_image, readonly long al_shipid);
/***************************************************************************************
NAME			: of_CopyImage
ACCESS		: Public 
ARGUMENTS	: n_Cst_Beo_image
  				  Long	(Shipment id to copy image to)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 
REVISION		: RDT 3-12-03
				  RDT 5-05-03 Images file names less than 1000 were not being saved correctly.
				  The leading 0's were masked out (ie: 010.tif  was being saved as 10.tif

***************************************************************************************/
String	ls_TargetPath
String 	ls_SourcePath
String	ls_topic
String	ls_Type
String	ls_Catagory
String 	ls_drive, &
			ls_dirpath, &
			ls_filename, &
			ls_ext , &
			ls_MessageTitle

Int		li_Return 
Int		li_NumberPages
INT		i
Int		li_ImageError
Long		ll_HoldID
Long		li_result
Long		ll_oldId
Boolean	lb_Append 

String	ls_moddescript

li_Return = 1

n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_bso_Document_Manager		lnv_DocumentMan
n_cst_beo_Image	lnv_Image

OLeobject	lnv_ole_image
lnv_DocumentMan = create n_cst_bso_Document_Manager		

ls_MessageTitle = "Paste Image"

n_cst_Filesrv 	lnv_FileSrv
lnv_FileSrv = create n_cst_Filesrvwin32

IF li_Return = 1 THEN
	CHOOSE CASE lnv_ShipmentManager.of_ShipmentExists ( al_shipid )
	
	CASE TRUE
		//Exists
	
	CASE FALSE
		li_Return = -1
		MessageBox("Shipment Error","Shipment not found. Copy Failed.")
		//Does not exist
	
	CASE ELSE
		li_Return = -1
		//Error -- Could not determine
	
	END CHOOSE
	
END IF
//	Need to get the topic, type & catagory of source to calculate the file path (Createfilepath) DONE

IF li_Return = 1 THEN

	SetPointer ( HOURGLASS! )

	ls_SourcePath = anv_image.of_GetFilePath ( ) 
	// get file extension
	lnv_filesrv.of_parsepath ( ls_SourcePath, ls_drive, ls_dirpath, ls_filename, ls_ext )

	ls_Topic = anv_image.of_GetTopic ( )
	ls_Type = anv_image.of_GetType ( )
	ls_Catagory = anv_image.of_GetCategory ( )
	ll_oldId = anv_image.of_getId()			//added by dan to keep history of what it was

	// CalculatePath for Target
	lnv_DocumentMan.of_settopic ( ls_Topic )
	lnv_DocumentMan.of_setcatagory ( ls_catagory )
	lnv_DocumentMan.of_calculatepath ( al_shipid, ls_TargetPath, ls_Type  )
	lnv_DocumentMan.of_createpath ( ls_TargetPath )
	ls_TargetPath = 	ls_TargetPath + String(al_shipid,"#,###,###,000") + "." +ls_ext //RDT 5-05-03 
	
	// Check for existing file
	If FileExists( ls_Targetpath ) Then 
		CHOOSE CASE MessageBox(ls_MessageTitle, ls_Type + " Exists for "+String( al_ShipId ) + "~nReplace? ~r~n~r~nYES to REPLACE~r~nNO to APPEND ",Question!,YesNoCancel!, 2 ) 
			CASE 1 // Replace
				lb_Append = FALSE
			Case 2 // append
				lb_Append = TRUE
			Case Else // stop			
				li_Return = -1
		END CHOOSE
	End If
	
	
	If li_Return = 1 then 
		IF lb_Append THEN
			li_result = THIS.of_Append( ls_TargetPath , ls_SourcePath)
			//added by dan 1-9-2006
			IF li_result = 1 THEN
				
				
			
				//the following is required to create a new image beo so that we can maintain
				//the integrity of the original copied image
				IF NOT isValid(inv_Bcm) THEN
					inv_Bcm = gnv_BcmMgr.CreateBcm ( )
				END IF
				inv_Bcm.SetDlk ( "n_cst_dlkc_image" )
				inv_Bcm.AddClass ( "n_cst_beo_image" )
				li_result = inv_Bcm.NewBeo ( lnv_Image )
				li_result = THIS.of_PopulateImage (  ls_TargetPath , lnv_image)
				
				IF this.of_getoleimgaeobject(lnv_ole_image) = 1 THEN
					li_NumberPages = lnv_image.of_calcpages( lnv_ole_image )
					ls_moddescript = "("+ ls_Type+ ") Image Id: "+ string( ll_oldId )+ " appended to existing image. Total Page(s): "+ string(li_NumberPages)
				ELSE
					ls_moddescript = "("+ ls_Type+ ") Image Id: "+ string( ll_oldId )+ " appended to existing image."
				END IF
				lnv_Image.of_updatemodlog( ls_moddescript )
				
//				IF isvalid(anv_image ) THEN
//					anv_image.of_updateModLog( "Image Id: "+ string( ll_oldId )+ " appended to "+ string(al_shipid) )
//				END IF
			END IF
			//-----------------------------
		ELSE
			// if we want to append here we will have to use the imaging controls since we are dealing with a .tiff file.			
			Choose Case lnv_FileSrv.of_FileCopy( ls_SourcePath, ls_TargetPath, FALSE )
				Case 1 
					//	1 successful
					//added by Dan 1-9-2006
					
					
					
					//the following is required to create a new image beo so that we can maintain
					//the integrity of the original copied image
					IF NOT isValid(inv_Bcm) THEN
						inv_Bcm = gnv_BcmMgr.CreateBcm ( )
					END IF
					inv_Bcm.SetDlk ( "n_cst_dlkc_image" )
					inv_Bcm.AddClass ( "n_cst_beo_image" )
					li_result = inv_Bcm.NewBeo ( lnv_Image )
					li_result = THIS.of_PopulateImage (  ls_TargetPath , lnv_image)
			
					IF this.of_getoleimgaeobject(lnv_ole_image) = 1 THEN
						li_NumberPages = lnv_image.of_calcpages( lnv_ole_image )
						ls_moddescript = "("+ ls_Type+ ") Image Id: "+ string( ll_oldId )+ " replaced old image."+" Total Page(s): "+string( li_NumberPages )
					ELSE
						ls_moddescript = "("+ ls_Type+ ") Image Id: "+ string( ll_oldId )+ " replaced old image."
					END IF
					lnv_Image.of_updatemodlog( ls_moddescript )
//					IF isvalid(anv_image ) THEN
//						anv_image.of_updateModLog( "Image Id: "+ string( ll_oldId )+ " appended to "+ string(al_shipid) )
//					END IF
					//-------------------------------
				Case -1
					// -1 error reading the source file
					MessageBox(ls_MessageTitle, "Cannot read the source file " + ls_SourcePath )
					li_return = -1
				Case -2
					// -2 error writting to the target file.
					MessageBox(ls_MessageTitle, "Cannot write to target file " + ls_TargetPath)
					li_Return = -1
			End Choose
		End If
	END IF
END IF

DESTROY 	lnv_DocumentMan
DESTROY 	lnv_FileSrv
IF isValid( lnv_ole_image ) THEN
	lnv_ole_image.disconnectobject( )
	destroy lnv_ole_image 
END IF
Return li_Return

end function

public function integer of_getimagelist (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong al_startshipmentid, unsignedlong al_endshipmentid, ref string asa_imagepaths[]);/*==================================================================================
of_getImageList:
				
				Arguments:
					anva_beoimagetypearray[] = An array of image types that will be combined
														with all the tmpnumbers and then looked up to 
														determine if that particular image exists
					aula_tmpnumber[]			 = An array of all the tmpNumbers to be searched
				 	asa_imagepaths[] (reference)
					 								 = All images that were found will have their file
														paths inserted into the array and made available 
														to whatever called the function
===================================================================================*/

String	ls_Topic
String	ls_Type
String	ls_Category
String  	lsa_ImagePaths [ ]
String	ls_Root
String	lsa_PathParts [ ]
String	lsa_NodeFolders [ ] 
String 	ls_TotalPath
String	ls_ErrorMessage
ULong		lul_TmpNum
Long		lla_IDsWOImages[]
Long 		ll_value
Int		li_CreatePathReturn
Int		li_ReturnValue  = 1
// Changed from Int to Long by ZMC on 11-11-03 to accomodate large Shipment Ids 
Long 		i,k, j 
// Changed from Int to Long by ZMC on 11-11-03 to accomodate large Shipment Ids 
Long		ll_IDCount
Long		ll_BeoCount

n_cst_shipmentmanager	lnv_ShipmentManager
n_cst_beo_ImageType lnva_ImageType []
n_cst_beo_ImageType lnv_CurrentBeo

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

lnva_ImageType = anva_beoimagetypearray[]

ls_ErrorMessage = "An error occurred while attempting to retrieve the image list."

ls_Root = THIS.of_GetRoot ( )

IF Len (ls_Root) = 0 THEN
	li_ReturnValue = -1
	ls_ErrorMessage = "An error occurred while attempting to locate file paths."
END IF


IF li_ReturnValue = 1 THEN

///************************ The below commented code is irrelevant to imaging module in getimagelist method******************** ///
/* 
	n_cst_setting_includeparentinimagelookup	lnv_IncludeParents
	lnv_IncludeParents = CREATE n_cst_setting_includeparentinimagelookup
	IF lnv_IncludeParents.of_Getvalue( ) = lnv_IncludeParents.cs_yes THEN
		ll_NewEndShipmentId = lnv_ShipmentManager.of_Addparentidstolist(al_startshipmentid,al_endshipmentid)
	END IF
	
	DESTROY ( lnv_IncludeParents )
*/	
	
	ll_BeoCount = upperBound  ( lnva_ImageType ) 
		
	lul_TmpNum = al_StartShipmentId	
	ll_IDCount = al_EndShipmentId
	
	For K = al_StartShipmentId	 To ll_IDCount
		IF li_ReturnValue = -1 THEN
			EXIT
		END IF
	
	// Check if ll_startshipmentid exists in disp_ship table.
		SELECT ds_id into :ll_value
		FROM disp_ship
		WHERE ds_id = :lul_TmpNum;
		Commit;
		IF IsNull(ll_value) OR ll_value <= 0 THEN
			lul_TmpNum++
			Continue
		END IF

		For i = 1 To ll_BeoCount
			
			lnv_CurrentBeo = lnva_ImageType [ i ]
			
			IF Not IsValid ( lnv_CurrentBeo ) THEN
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while evaluating an image type."
			END IF
			
			IF li_ReturnValue = 1 THEN
				ls_Topic = lnv_CurrentBeo.of_GetTopic ( )
				ls_Type  = lnv_CurrentBeo.of_GetType ( )
				ls_Category = lnv_CurrentBeo.of_GetCategory ( )
			
				li_CreatePathReturn = THIS.of_CreatePath ( ls_Topic , ls_Category , ls_Type , lul_TmpNum , lsa_PathParts [] , lsa_NodeFolders [] )
			END IF
				
			IF li_CreatePathReturn <> 1 THEN
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while creating an image path."
			END IF
			
			IF li_ReturnValue = 1 THEN
				// The Document name is not in the PathParts, It is at the upperbound if the node folders
				ls_TotalPath = ls_Root + lsa_Pathparts [ upperBound ( lsa_PathParts ) ] +"\"+ &
								lsa_NodeFolders[ upperBound ( lsa_NodeFolders ) ] + ".tif"
			END IF		
		
				
			IF Len ( ls_TotalPath ) > 0 THEN
			
				IF of_DoesImageExist ( ls_TotalPath  ) THEN		
					j++
					lsa_ImagePaths [ j ] = ls_TotalPath
				ELSE
					CONTINUE
				END IF
				
			ELSE
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while obtaining the path to an image."
			END IF
			
			IF li_ReturnValue = -1 THEN
				EXIT
			END IF
			
		NEXT
		
		lul_TmpNum++
	NEXT
	
END IF

//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



asa_ImagePaths =  lsa_ImagePaths

IF li_ReturnValue <> -1 THEN
	li_ReturnValue = UpperBound (  lsa_ImagePaths )
END IF

Return li_ReturnValue








end function

public function integer of_append (string as_appendtofile, string as_filetoappend);Int	li_ImageError
Int	li_ReturnValue = 1
Int	li_NewPageCount
Int	i
	
n_cst_bso_ImageManager				lnv_ImageManager
n_cst_imagingversioncontrol		lnv_Version
oleObject								lnv_ResultOle

//modified by dan 1-11-2006

//lnv_ResultOle 		= Create oleObject
//
IF li_ReturnValue = 1 THEN
	IF THIS.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
		li_ReturnValue = -1
	END IF
END IF
//
//IF li_ReturnValue = 1 THEN
//	IF lnv_ResultOle.ConnectToNewObject (lnv_Version.of_getimagexpressobjectstring( ) ) <> 0 THEN
//		li_ReturnValue = -1
//	END IF
//END IF

//lnv_resultOle = this.of_getOLEImgaeObject( )


li_returnValue = this.of_getOleImgaeobject( lnv_resultOle )
//--------------------------------------------------------
IF li_ReturnValue = 1 THEN
	SetPointer ( HOURGLASS! )
	
	lnv_ResultOle.SaveMultiPage = TRUE	// by setting this to true, the call to savefile
	// will append if the SaveFileName exists	
	
	li_NewPageCount = lnv_ResultOle.NumPages ( as_filetoappend ) 
	
	lnv_Version.of_SetCompression ( lnv_ResultOle )
	
	For i = 1 TO li_NewPageCount
		lnv_ResultOle.PageNbr = i
		lnv_ResultOle.FileName = as_filetoappend // load this file and...
		lnv_ResultOle.SaveFileName = as_appendtofile // ... save it as (append)
		lnv_ResultOle.SaveFile ( )
		
		li_ImageError = lnv_ResultOle.ImagError ( )			
	NEXT

END IF


lnv_ResultOle.DisconnectObject ( )

DESTROY  lnv_Version
DESTROY  lnv_ResultOle

Return li_ReturnValue
end function

public function integer of_viewunassignedimages ();Int		li_ReturnValue = 1

n_cst_msg lnv_msg
s_parm	lstr_parm

lstr_Parm.is_Label = "TOPIC"
lstr_Parm.ia_Value = "UNASSIGNED"
lnv_Msg.of_Add_Parm( lstr_Parm ) 

lstr_Parm.is_Label = "PRIV"
lstr_Parm.ia_Value = 1
lnv_Msg.of_Add_Parm( lstr_Parm ) 

IF THIS.of_CheckConnection ( ) <> 0 THEN
	li_ReturnValue = -1
	MessageBox( "Control Connection" , "Profit Tools could not locate the necessary controls needed to perform this operation.") 
ELSE
	OpenSheetWithParm ( w_Imaging, lnv_msg , gnv_App.of_GetFrame ( ), 0, Layered! )
END IF


RETURN li_ReturnValue
end function

public function n_cst_bcm of_getunassignedimagebcm ();Int		li_ReturnValue = 1
Long 		ll_filecnt
Long		i
Long		ll_ImageCount
String	ls_TotalPath
String	ls_Root
String	lsa_ImagePaths[]			
			
n_cst_bcm			lnv_Bcm

n_cst_beo_imageType 	lnv_ImageType

n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

lnv_filesrvwin32 = Create n_cst_filesrvwin32

IF li_ReturnValue = 1 THEN
	ls_Root = THIS.of_getBatchFolder ( ) 
	IF Len( ls_Root ) = 0 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	ll_filecnt = lnv_filesrvwin32.of_dirlist ( ls_root+"*.*", 39, lnv_dirattrib )
	FOR i = 1 TO ll_filecnt
		ls_TotalPath = ls_root + lnv_dirattrib[i].is_filename
		ll_ImageCount++
		lsa_ImagePaths [ ll_ImageCount ] = ls_TotalPath
	NEXT
END IF
	
IF li_ReturnValue = 1 THEN

	lnv_Bcm = gnv_BcmMgr.CreateBcm ( )				
	lnv_Bcm.SetDlk ( "n_cst_dlkc_imageType" )
	lnv_Bcm.AddClass ( "n_cst_beo_imageType" )
	
	lnv_Bcm.NewBeo ( lnv_ImageType )
	
	lnv_ImageType.of_settopic ( "SHIPMENT" )
	lnv_ImageType.of_setcategory ( "UNSECURE")	
	lnv_ImageType.of_settype ( "NONE" )
	
END IF

String		ls_ErrorMessage


n_cst_bcm			lnv_Bcm2
n_cst_beo_Image	lnv_Image

	
IF li_ReturnValue = 1 THEN	
	
	
	lnv_Bcm2 = gnv_BcmMgr.CreateBcm ( )
	lnv_Bcm2.SetDlk ( "n_cst_dlkc_image" )
	lnv_Bcm2.AddClass ( "n_cst_beo_image" )
	
	IF Not IsValid ( lnv_bcm ) THEN
		li_ReturnValue = -1
	END IF
		
	IF li_ReturnValue = 1 THEN
		
		FOR i = 1 to ll_ImageCount
			
			IF NOT THIS.of_DoesImageExist ( lsa_ImagePaths [ i ]  ) THEN
				CONTINUE
			END IF
			Long	ll_NewRtn
			ll_NewRtn = lnv_Bcm2.NewBeo ( lnv_Image )
			
	
			IF IsValid ( lnv_Image ) THEN
				
				IF isValid ( lnv_ImageType ) THEN
					
					lnv_Image.of_SetImageType ( lnv_imagetype )
					lnv_Image.of_SetFilePath ( lsa_ImagePaths [ i ] )
					lnv_image.of_setid( 0, FALSE )
				
				END IF

			ELSE
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while attempting to update the image list."
				EXIT
			END IF
			
		NEXT
		
	END IF
END IF



DESTROY ( lnv_filesrvwin32 )

RETURN lnv_Bcm2
end function

public function integer of_getimagetypes (string as_topic, ref string asa_types[]);Long		ll_RowCount
Long		i
Long		ll_index
String 	ls_Topic
String	ls_ErrorMessage
String	ls_Type
String	lsa_Types[]
Int		li_ReturnValue = 1
Int		li_TypeCount 

n_cst_bcm	lnv_Bcm

n_cst_beo_ImageType		lnv_CurrentImageType


n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

ls_ErrorMessage = "An error occurred while retrieving the list of image types."
ls_Topic = as_topic

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )

IF Not IsValid ( lnv_Bcm ) THEN
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	
	ll_RowCount = lnv_Bcm.getCount () 

	For i = 1 To ll_RowCount
	
		ll_Index = lnv_Bcm.getBeoIndex ( i )
		
		lnv_CurrentImageType = lnv_Bcm.getAt ( ll_Index )
			
		IF isValid ( lnv_CurrentImageType ) THEN
			
			IF lnv_CurrentImageType.of_GetTopic ( ) = ls_Topic THEN
				 ls_Type = lnv_CurrentImageType.of_GetType( )
				 li_TypeCount ++
				 lsa_Types[li_TypeCount] = ls_Type
			END IF
			
		END IF

	NEXT
	
END IF

asa_types[] = lsa_Types


//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



Return li_ReturnValue
end function

private function string of_getnextschemaroot ();String	ls_Root
String	ls_Rtn
String	ls_FileName
Long		ll_Count
Long		i,j
Int		li_Temp
String	ls_Temp
Int		li_Max
Char	lca_Temp[]
Int	li_Bound
n_cst_filesrvwin32	lnv_FileSrv
n_cst_dirattrib	lnva_DirAttribs[]


ls_Root = THIS.of_getBatchfolder( )

lnv_FileSrv = CREATE n_cst_filesrvwin32

ll_Count = lnv_FileSrv.of_Dirlist( ls_Root + "*.tif" , 0, lnva_DirAttribs )

FOR i = 1 TO ll_Count

	ls_FileName = lnva_DirAttribs[i].is_altfilename
	
	IF Left ( ls_FileName , 3 ) <> 'DOC' THEN
		CONTINUE
	END IF
	
	lca_Temp = ls_FileName
	
	li_Bound = UpperBound ( lca_Temp )
	ls_Temp = ""
	FOR j = 4 TO li_Bound
		IF ISNumber( lca_Temp[j] ) THEN
			ls_Temp += String ( lca_Temp[j] )
		ELSE
			EXIT
		END IF
	NEXT
	
	li_Temp = Integer ( ls_Temp ) 
	
	IF li_Temp > li_Max THEN
		li_Max = li_Temp
	END IF
	
NEXT

li_Max ++
ls_Rtn = "DOC" + String ( li_Max ) + "Z"



DESTROY ( lnv_FileSrv ) 

RETURN ls_Rtn
end function

protected function string of_getbatchfolder ();String	ls_BatchRoot
n_cst_setting_imagingscanpathunnassigned	lnv_setting		//added by dan 2-14-07
n_cst_filesrvwin32	lnv_Filesrv
lnv_Filesrv = CREATE n_cst_filesrvwin32

String	ls_path 
//2-14-07added by dan to use the system setting instead. 

lnv_setting = create n_cst_setting_imagingscanpathunnassigned
ls_path = lnv_setting.of_getValue( )
//ls_BatchRoot = "c:\imagetmp\" +gnv_App.of_Getuserid( ) + "\"     old code
ls_BatchRoot = ls_path + "\" + +gnv_App.of_Getuserid( ) + "\"
///////////////////
IF lnv_FileSrv.of_DirectoryExists ( ls_BatchRoot ) THEN
	
ELSE
	IF THIS.of_Createfolder( ls_BatchRoot ) <> 1 THEN
		ls_BatchRoot = ""
	END IF
END IF

DESTROY lnv_setting
DESTROY lnv_Filesrv
RETURN ls_BatchRoot
end function

public function integer of_scannotypebatch (long al_id, oleobject anv_olescan, boolean ab_scannerselect, boolean ab_settings, long al_scansource, boolean ab_feeder);//
/***************************************************************************************
NAME			: of_ScanNoTypeBatch
ACCESS		: Private 
ARGUMENTS	: 	al_id
					anv_olescan
					ab_scannerselect
					ab_settings
					al_scansource

RETURNS		: Integer ( 1 = success, -1 = Failed ) 
DESCRIPTION	: Creates scan batches without image types.
		
Folder name lengths can't exceed a length of 8 and can't contain "," when using pegasus's
schema.

REVISION		: RDT 7-29-03 
***************************************************************************************/

Integer  li_DocsScaned = -1, &
			li_Error, &
			li_ReturnValue = 1
			
Long 		ll_filecnt, &
			i, & 
			k

String	ls_ErrorMessage, &
			ls_TotalPath, &
			ls_Root, &
			lsa_ImagePaths[]		
String	ls_SchemaRoot
			
Long		ll_TempHdib
Long		ll_NewRtn
Boolean  lb_Again = FALSE

String	ls_moddescript
n_cst_beo_imageType 	lnv_ImageType

n_cst_filesrvwin32	lnv_filesrvwin32
n_cst_dirattrib		lnv_dirattrib[]

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

OleObject	ole_Scan

ls_ErrorMessage = "An error occurred while attempting to scan a batch of documents."

ole_Scan = anv_OleScan

IF li_ReturnValue = 1 THEN
	
	ls_Root = THIS.of_GetBatchFolder( )
	
	IF Len ( ls_Root ) = 0 THEN
		ls_ErrorMessage = "An error occurred while attempting to locate a temporary folder to store a the batch of documents." 
		li_ReturnValue = -1
	END IF
	
END IF

IF li_ReturnValue = 1 THEN
	
	IF ab_ScannerSelect THEN
		
			ole_scan.SetScanName( )
			li_Error = ole_Scan.ScanErrorCode
		
	END IF
	
	IF li_Error < 0 THEN
		li_ReturnValue  = -2
	END IF
	
	IF li_ReturnValue = 1 THEN
		This.of_DefaultScannerSettings(ole_Scan) //MFS 5/29/05 - just DPI for now
	END IF
	
	IF li_ReturnValue = 1 AND ab_Settings THEN 
		ole_scan.SettingsDialog( )
		li_Error = ole_Scan.ScanErrorCode
	END IF
	
	IF li_Error < 0 THEN
		li_ReturnValue = -1
	END IF
	
	IF li_ReturnValue = 1 THEN
		ole_Scan.SaveFileType=4 // group 4   3.8
		ole_Scan.ScanMultiPage= False
		ls_SchemaRoot = THIS.of_GetNextschemaroot( )
		IF ab_Feeder THEN
			
			ole_Scan.UseSchema = TRUE
			ole_Scan.ScanFileName = ls_Root + ls_schemaRoot
			ole_Scan.ScanFileDir = ls_Root
			ole_Scan.ScanFileRoot = ls_schemaRoot
			ole_Scan.ScanFileSchema= "$####"
			IF al_ScanSource <> 0 THEN					
				ole_Scan.ScanSetting = 10
				ole_Scan.ScanSettingLong = al_ScanSource
			END IF
			ole_scan.ScanBatch ( )
		ELSE		
			ole_Scan.UseSchema = FALSE
			ole_Scan.ScanFileName = ls_Root + ls_schemaRoot + "0001.tif"
			ole_Scan.ScanSetting = 10
			ole_Scan.ScanSettingLong = 2
			ole_scan.ScanSingle ( )
		END IF
		li_Error = ole_Scan.ScanErrorCode
	END IF
	
	IF li_Error < 0 THEN
		li_ReturnValue = -1
	END IF
END IF
	
///////////// get number of files saved ///////////// 
IF li_Returnvalue = 1 THEN
	ls_ErrorMessage = "An error occurred while attempting to locate images without IDs."
	lnv_filesrvwin32 = Create n_cst_filesrvwin32

	ls_Root = THIS.of_getBatchFolder ( ) 
	IF Len( ls_Root ) = 0 THEN
		li_ReturnValue = -1
	END IF
	
	IF li_ReturnValue = 1 THEN
	
		ll_filecnt = lnv_filesrvwin32.of_dirlist ( ls_root+"*.*", 39, lnv_dirattrib )
		FOR i = 1 TO ll_filecnt
		
			ls_TotalPath = ls_root + lnv_dirattrib[i].is_filename								
			lsa_ImagePaths [ i ] = ls_TotalPath

		NEXT
		
	END IF

END IF

//////////////////////////
n_cst_bcm			lnv_Bcm
n_cst_bcm			lnv_Bcm2
n_cst_beo_Image	lnv_Image


IF NOT isValid (  w_imaging.dw_ImageList.inv_UILink ) THEN
	li_ReturnValue = -1
	ls_ErrorMessage = "The updating of the image list could not be performed."
END IF

	
IF li_ReturnValue = 1 THEN
	
	
	lnv_Bcm = gnv_BcmMgr.CreateBcm ( )
	lnv_Bcm.SetDlk ( "n_cst_dlkc_image" )
	lnv_Bcm.AddClass ( "n_cst_beo_image" )
	
	lnv_Bcm2 = gnv_BcmMgr.CreateBcm ( )				
	lnv_Bcm2.SetDlk ( "n_cst_dlkc_imageType" )
	lnv_Bcm2.AddClass ( "n_cst_beo_imageType" )

	IF Not IsValid ( lnv_bcm ) THEN
		li_ReturnValue = -1
	END IF
		
		FOR K = 1 to upperbound ( lsa_ImagePaths ) 
			
			IF NOT THIS.of_DoesImageExist ( lsa_ImagePaths [ k ]  ) THEN
				CONTINUE
			END IF
			
			ll_NewRtn = lnv_Bcm.NewBeo ( lnv_Image )
			
			IF IsValid ( lnv_Image ) THEN
				
				ll_NewRtn = lnv_Bcm2.NewBeo ( lnv_ImageType )				
				
				IF isValid ( lnv_ImageType ) THEN
					
					lnv_ImageType.of_settopic ( "SHIPMENT" )
					lnv_ImageType.of_setcategory ( "UNSECURE")	
					lnv_ImageType.of_settype ( "NONE" )
					
					lnv_Image.of_SetImageType ( lnv_imagetype )
					lnv_Image.of_SetFilePath ( lsa_ImagePaths [ k ] )
					lnv_image.of_setid( al_ID, FALSE )
					
				
				ELSE
					li_ReturnValue = THIS.of_populateNoType ( lsa_ImagePaths [ k ]  , lnv_image, al_ID)					
								
				END IF

			ELSE
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while attempting to update the image list."
				EXIT
			END IF
			
		NEXT
		
	END IF
////////////////////////////


///////////// Create image type of NONE for untyped files ///////////// 
IF li_Returnvalue = 1 THEN
	If IsValid( lnv_ImageType ) Then 
		lnv_ImageType.of_settopic ( "SHIPMENT" )
		lnv_ImageType.of_setcategory ( "UNSECURE")	
		lnv_ImageType.of_settype ( "NONE" )
	Else
		li_Returnvalue = -1 
	END IF
END IF

///////////// Load the images ///////////// 
IF li_Returnvalue = 1 THEN
	li_ReturnValue = 	THIS.of_LoadImageListNoType ( lsa_ImagePaths , lnv_imagetype, al_id )
END IF

//added by Dan 1-9-2006
//IF li_returnValue = 1 THEN
//	ls_moddescript = "Scanned Batch Id: "+ string( aL_id )+ " with no types"
//	inv_Image.of_updatemodlog( al_id, "UNSECURE", "NONE", "SHIPMENT", ls_moddescript )
//END IF
//----------------------------------------------------

DESTROY lnv_filesrvwin32 



//* Error Processing *\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

IF li_ReturnValue = -1 THEN
	lnv_Errorcollection = This.GetOFRErrorCollection ( )
	lnv_Errorcollection.getErrorArray( lnv_ErrorArray[] )
	IF upperBound( lnv_ErrorArray ) = 0 THEN
	
		lnv_Error = THIS.AddOFRError ( )
		lnv_Error.SetErrorMessage( ls_ErrorMessage )

	END IF
END IF

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\



Return li_ReturnValue


end function

private function integer of_updatemodlog (long as_newid, string as_category, string as_type, string as_topic, string as_moddescript);//function created by dan 1-9-2006
DateTime	ldt_now
Long	ll_newModRow
Int	li_result

//IF isValid (ids_modLog) THEN
//	ll_newModRow = ids_modLog.insertRow( 0 )
//	ids_modLog.setItem( ll_newModRow, "modid", as_newId )
//	ids_modLog.setItem( ll_newModRow, "category", as_category )
//	ids_modLog.setItem( ll_newModRow, "type", as_type )
//	ids_modLog.setItem( ll_newModRow, "topic", as_topic )
//	ids_modLog.setItem( ll_newModRow, "moddescription", as_modDescript )
//	ldt_now =  DateTime( today(), Time(String(Now(), "hh:mm:ss") ))
//	ids_modLog.setItem( ll_newModRow,"datet" ,ldt_now )
//	ids_modLog.setItem( ll_newModRow, "user", gnv_app.of_getuserid( ) )
//	
//	li_result = ids_modLog.update( )
//	IF li_result = 1 THEN
//		COMMIT;
//	ELSE
//		ROLLBACK;
//	END IF
//END IF
Return li_result		
end function

public function integer of_getoleimgaeobject (ref oleobject anv_imageobject);//added by Dan 1-11-2006
Int	li_returnValue
n_cst_imagingversioncontrol		lnv_Version
oleObject								lnv_ResultOle
li_returnValue = 1

lnv_ResultOle 		= Create oleObject

IF li_ReturnValue = 1 THEN
	IF THIS.of_GetImagingversioncontrol( lnv_Version ) <> 1 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	IF lnv_ResultOle.ConnectToNewObject (lnv_Version.of_getimagexpressobjectstring( ) ) <> 0 THEN
		li_ReturnValue = -1
	END IF
END IF


anv_imageObject = lnv_resultOle
RETURN li_returnValue

end function

public function integer of_defaultscannersettings (ref oleobject anv_scan);Integer	li_Return = 1
Integer	li_Dpi
String	ls_Dpi

// dpi resolution
			
li_Dpi = 200 //default

ls_Dpi = ProfileString ( gnv_App.of_GetAppIniFile ( ), "Scanning", "DPI", "" )
IF isNumber(ls_Dpi) THEN
	IF Integer(ls_Dpi) <= 200 THEN //only allow 200 dpi or less 
		li_Dpi = Integer(ls_Dpi)
	END IF
END IF

anv_Scan.ScanSetting = 0
anv_Scan.ScanSettingLong = li_Dpi
anv_Scan.ScanSetting = 1
anv_Scan.ScanSettingLong = li_Dpi


Return li_Return
end function

on n_cst_bso_imagemanager_pegasus.create
call super::create
end on

on n_cst_bso_imagemanager_pegasus.destroy
call super::destroy
end on

event destructor;call super::destructor;IF isValid( inv_Bcm ) THEN
	gnv_BcmMgr.DestroyBcm ( inv_Bcm )
END IF

//added by dan 1-9-2006
IF isValid( ids_modLog ) THEN
	Destroy ids_modLog
	
END IF
	
end event

event constructor;call super::constructor;//added by dan 1/9-2006
ids_modLog			=	CREATE Datastore

ids_modLog.dataobject = "d_imagemods"

ids_modLog.setTransObject( SQLCA )
ids_modLog.Retrieve( )
end event

