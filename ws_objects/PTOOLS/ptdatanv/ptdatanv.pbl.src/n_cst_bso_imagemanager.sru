$PBExportHeader$n_cst_bso_imagemanager.sru
$PBExportComments$ImageManager (Non-persistent Class from PBL map PTData) //@(*)[3498600|52]
forward
global type n_cst_bso_imagemanager from n_cst_bso
end type
end forward

shared variables
//@(text)(recreate=opt)<Synchronized Shared Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.
n_cst_bso_imagemanager sn_n_cst_bso_imagemanager_a[] //@(*)[3498600|52:n]<nosync>
Integer sn_n_cst_bso_imagemanager_c //@(*)[3498600|52:c]<nosync>
//@(text)--

//Add your implementation-only shared variables after this line.
//These variables will NOT be synchronized with HOW.

end variables

global type n_cst_bso_imagemanager from n_cst_bso
end type
global n_cst_bso_imagemanager n_cst_bso_imagemanager

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.

//@(text)--
Constant String	cs_Type_Label 		= "Type"
Constant String	cs_Type_Shipment 	= "Invoice"
Constant String	cs_Data_TempNo 	= "TempNo"
Constant String	cs_VolNumPrefix 	= 'PTARCHIVE'			// ZMC 10-31-03
Constant String 	cs_ErrMsgHeader	= 'Imaging Archive'
//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

private:
n_ds	ids_Cache

n_cst_bcm	inv_n_cst_Bcm


end variables

forward prototypes
protected function Integer of_makeconnection ()
protected function Integer of_closeconnection ()
public function Integer of_print (n_cst_msg an_msgobj)
public function Integer of_display (n_cst_msg an_msgobj)
public function integer of_getcache (n_cst_bcm anv_cache)
public function long of_getcache (n_ds ads_cache)
public function long of_getmaxarchivesize ()
public function long of_getimagingarchivelist (n_cst_beo_imagetype anva_beoimagetypearray[], long ala_shipmentid[])
public function boolean of_istemporarytargetfolderempty (string as_temporarytargetfolder)
public function integer of_getshipmentidarray (long al_startshipmentid, long al_endshipmentid, ref long ala_shipmentid[])
public function long of_checkspacerequirements (long ala_shipmentid[], double adbl_totalarchivesize, double adbl_destinationarchivesize)
public function integer of_getimagingrootfolder (ref string as_imagingrootfolder)
public function integer of_createfolder (string as_path)
public function integer of_getmaxvolumenumber (ref long al_maxvolumenumber)
public function integer of_getshipmentrangeforvolume (long al_volumenumber, ref long al_startshipmentid, ref long al_endshipmentid)
public function integer of_getarchivefolder (ref string as_foldername)
public function integer of_generatearchiveimagelist (long ala_tmpnbrs[], n_cst_beo_imagetype ana_imagetypes[], ref n_cst_beo_image ana_images[], ref string asa_imagepaths[])
public function string of_getrootfolder (integer ai_ssidnum)
public function integer of_getarchiveimagelist (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[], long al_volnum)
public function integer of_recopyimages (long ala_shipmentid[], string as_temporarytargetfolder, long al_volnum)
public function integer of_doesarchiveimagesexists (long ala_shipmentid[], ref long ala_archiveshipmentidrange[], ref long ala_volumenumber[])
public function integer of_getarchiveimagelistmultiple (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[])
public function integer of_getvolumeforshipmentrange (long al_shipmentid, ref long al_volumenumber)
public function integer of_isimagecurrentorarchived (long al_shipmentid, n_cst_beo_image anv_beo)
public function integer of_getimagepathsfromarchive (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[])
public function integer of_doesarchiveimagesexists (long al_shipmentid)
public function integer of_getimagepathforarchivedimages (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], long ala_volumenumbers[], ref string asa_imagepaths[])
public function integer of_copyallimages (long ala_shipmentid[], string as_temporarytargetfolder, ref string as_volumenumber)
public function long of_extractvolumenumber (string as_volume)
public function boolean of_gettemporarytargetfolder (ref string as_foldername)
public function integer of_getimagingversioncontrol (ref n_cst_imagingversioncontrol anv_version)
public function integer of_calcarchivesize (long ala_startshipmentid[], double adbl_maxarchivesize, ref long al_shipmentctr, ref double adbl_totalarchivesize)
public function integer of_copyallimages (string as_temporarytargetfolder, ref string as_volumenumber, n_cst_beo_imagetype anva_imagetypes[], string asa_imagepaths[])
public function integer of_recopyimages (unsignedlong al_startshipmentid, unsignedlong al_endshipmentid, string as_temporarytargetfolder, long al_volnum, n_cst_beo_imagetype anva_imagetypes[], readonly string asa_imagepaths[])
public function integer of_generatearchiveimagelist (unsignedlong al_startshipmentid, unsignedlong al_endshipmentid, n_cst_beo_imagetype ana_imagetypes[], ref n_cst_beo_image ana_images[], string asa_imagepaths[])
public function integer of_calcarchivesize (long al_startshipmentid, long al_endshipmentid, double adbl_maxarchivesize, ref long al_shipmentctr, ref double adbl_totalarchivesize, ref n_cst_beo_imagetype anva_imagetypes[], ref string asa_imagepaths[], ref long al_ctr)
public function boolean of_hasimagebeencopiedtoarchive (n_cst_beo_image anv_image)
public function integer of_gettmparchivestatus (long al_shipmentid)
public function integer of_viewunassignedimages ()
end prototypes

protected function Integer of_makeconnection ();//@(*)[3515638|54]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--
Return -1
end function

protected function Integer of_closeconnection ();//@(*)[3588398|55]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>


//@(text)--

Return -1
end function

public function Integer of_print (n_cst_msg an_msgobj);//@(*)[65098347|83]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Return -1
end function

public function Integer of_display (n_cst_msg an_msgobj);//@(*)[65437726|85]//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Documentation>

//@(text)--

/* Replace the code fragment below with your code. */
//@(text)(recreate=no)<return value>

//@(text)--

Return -1
end function

public function integer of_getcache (n_cst_bcm anv_cache);//Returns: 1, -1   (Cache is passed back by reference in anv_Cache)
//Will attempt to retrieve the cache, if it hasn't been retrieved already.

n_cst_bcm	lnv_Cache
Integer		li_Return

li_Return = -1


IF gnv_App.inv_CacheManager.of_GetCache ( "n_dlkc_imagetype", lnv_Cache, TRUE, TRUE ) = 1 THEN

	li_Return = 1
END IF


anv_Cache = lnv_Cache

RETURN li_Return
end function

public function long of_getcache (n_ds ads_cache);if isvalid(ids_Cache) then
	//already created
else
	ids_Cache = CREATE n_ds
	ids_Cache.DataObject = "d_Settings"
	ids_Cache.SetTransObject ( SQLCA )
	ids_Cache.Retrieve()
	ids_Cache.SetSort('ss_id D')
	ids_Cache.Sort()

end if
ads_Cache = ids_Cache
return ids_Cache.rowcount()
end function

public function long of_getmaxarchivesize ();/////////////////////////////////////////////////////////
//
// Function		: of_getmaxarchivesize
// Arguments 	: None
// Returns 		: Max archive size in MB stored in system settings table, long
// Description : Returns the value stored in Systems Settings table where Ss_id = 155
// Author		: ZMC
// Created on 	: 10-22-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_RtnVal
Any la_Value
Long ll_value
Long ll_ReturnValue



n_cst_settings lnv_Settings

li_RtnVal = lnv_Settings.of_GetSetting( 155, la_Value)

ll_value = Long(la_Value)

IF li_RtnVal = 1 AND ll_value > 0 THEN
	ll_ReturnValue = Long(la_Value)
END IF

Return ll_ReturnValue



end function

public function long of_getimagingarchivelist (n_cst_beo_imagetype anva_beoimagetypearray[], long ala_shipmentid[]);/////////////////////////////////////////////////////////
//
// Function		: of_GetImagingArchiveList
// Arguments	: None 
// Returns 		: Long li_ReturnValue
// Description : Add Description here
// Author		: Zach 
// Created on 	: 2003-10-10
// Modified by : Add Author here	     TimeStamp
//				
/////////////////////////////////////////////////////////

String lsa_ImagePaths[]
Long ll_ShipmentId[]
Long li_ReturnValue = 1
Long ll_TotalImages

// Declare variable of type n_cst_beo_ImageType
// to pass as an argument to 
// of_GetImageTypesForType method of n_cst_bso_imagemanager_pegasus NVO
n_cst_beo_ImageType lnva_ImageTypes[]

lnva_ImageTypes[] = anva_beoimagetypearray[]

ll_ShipmentId = ala_shipmentid[]

// Declaration of variable lnv_Bcm of type n_cst_bcm
n_cst_bcm	lnv_Bcm

n_cst_bso_ImageManager_Pegasus lnv_imagemanager_pegasus
lnv_imagemanager_pegasus = CREATE n_cst_bso_ImageManager_Pegasus

IF Not IsValid ( lnv_Bcm ) THEN
	
	lnv_Bcm = gnv_BcmMgr.CreateBcm ( )
	IF Not isValid ( lnv_Bcm ) THEN
		li_ReturnValue = -1
	ELSE
		lnv_Bcm.SetDlk 	( "n_cst_dlkc_image" )
		lnv_Bcm.AddClass 	( "n_cst_beo_image" )
	END IF
END IF

IF li_ReturnValue = 1 THEN
	ll_TotalImages = lnv_imagemanager_pegasus.of_GetImageList (lnva_ImageTypes[],ll_ShipmentId[],lsa_ImagePaths[])
	li_ReturnValue = ll_TotalImages
ELSE
		li_ReturnValue = -1
END IF

DESTROY lnv_imagemanager_pegasus

Return li_ReturnValue
end function

public function boolean of_istemporarytargetfolderempty (string as_temporarytargetfolder);/* ////////////////////////////////////////////////////////
//
// Function		: of_istemporarytargetfolderempty
// Arguments 	: as_temporarytargetfolder. string 
// Returns 		: True = Found False = Not Found
// Description : Checks if the temporary target folder has been deleted or still has 
//						the images which the user may have copied to an external media
// Author		: ZMC
// Created on 	: 10-20-03
// Modified by : Add Author here	TimeStamp
//				
//////////////////////////////////////////////////////// */

Boolean lb_ReturnValue
Long ll_UpperBound
String ls_TemporaryTargetFolder

ls_TemporaryTargetFolder = as_temporarytargetfolder

pfc_n_cst_filesrvwin32 lnv_fileservwin32
lnv_fileservwin32 = CREATE pfc_n_cst_filesrvwin32

n_cst_dirattrib anv_dirlist[]

/* 49207 stands for: 
Values as as follows
0  Read/write files·	
1  Read-only files·	
2  Hidden files·	
4  System files·	
16 Subdirectories·	
32 Archive (modified) files·	
16384  Drives·	
32768  Exclude read/write files from the list 
To list several types,add the numbers associated with the types. For example, 
to list read-write files, subdirectories, and drives, use 0+16+16384 or 16400 for filetype.
*/
lnv_fileservwin32.of_Dirlist( ls_TemporaryTargetFolder, 16439, anv_dirlist[] )

ll_UpperBound = UpperBound(anv_dirlist[])

IF ll_UpperBound > 0 THEN
	lb_ReturnValue = False
ELSE
	lb_ReturnValue = True
END IF

DESTROY lnv_fileservwin32

RETURN lb_ReturnValue
end function

public function integer of_getshipmentidarray (long al_startshipmentid, long al_endshipmentid, ref long ala_shipmentid[]);/////////////////////////////////////////////////////////
//
// Function		: of_getshipmentidarray
// Arguments 	: al_startshipmentid,long
//					  al_endshipmentid,long
//					  ala_shipmentid[], Long Array, by reference			
// Returns 		: 1 = Success, -1 = Failure
// Description : When passed a starting and an ending shipment id, 
//					  this method returns an array of shipment ids	
// Author		: ZMC
// Created on 	: 10-20-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Long ll_Ctr
Long ll_value
Long ll_startshipmentid
Long ll_endshipmentid
Long ll_shipmentid[]

ll_startshipmentid = al_startshipmentid
ll_endshipmentid   = al_endshipmentid

Do WHILE ll_startshipmentid <= ll_endshipmentid
	ll_Ctr++

	// Check if ll_startshipmentid exists in disp_ship table.
	
	SELECT ds_id into :ll_value
	FROM disp_ship
	WHERE ds_id = :ll_startshipmentid;
	Commit;
	IF (Not IsNull(ll_value)) OR ll_value > 0 THEN
		ll_shipmentid[ll_Ctr] = ll_startshipmentid
	END IF

//	ll_shipmentid[ll_Ctr] = ll_startshipmentid
	
	ll_startshipmentid++
Loop

ll_startshipmentid = al_startshipmentid
ala_shipmentid 	 = ll_shipmentid

IF UpperBound(ll_shipmentid[]) = 0 THEN
	li_ReturnValue = -1
END IF
	
Return li_ReturnValue
end function

public function long of_checkspacerequirements (long ala_shipmentid[], double adbl_totalarchivesize, double adbl_destinationarchivesize);/////////////////////////////////////////////////////////
//
// Function		: of_checkspacerequirement
// Arguments 	: ala_shipmentid[], long array 
//					  adbl_totalarchivesize, double
//					  adbl_destinationarchivesize, double
// Returns 		: Long - Shipment Id 
// Description : Checks to see if the shipment Id range fits into the max 
//					  archive size stated in the settings tabpage. 
//					  If not then from the shipment id range, retuns the last shipment 
//					  id which can fit into the max archive size range. 
// Author		: ZMC
// Created on 	: 10-15-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Long 		ll_Ctr 
Int 		li_Len
Long		ll_ReturnValue
Long		ll_ShipmentCtr
Long 		ll_ShipmentId[]
Long 		ll_TotalImages 
Long 		ll_UpperBound

Double	ldbl_TotalArchiveSize
Double 	ldbl_DestinationArchiveSize
Double	ldbl_TotalSpace

String 	ls_Ext
String 	ls_File
String 	ls_Drive
String 	ls_DirPath
String 	ls_FileName
String 	ls_ReplaceStr
String 	ls_ShipmentCtr
String   ls_FileNameExtract
String	lsa_ImagePaths[]		

ll_ShipmentId = ala_shipmentid
ldbl_TotalArchiveSize = adbl_totalarchivesize
ldbl_DestinationArchiveSize = adbl_DestinationArchiveSize

n_cst_beo_ImageType lnva_ImageTypes[]

// Instantiation of  variable lnv_imagemanager_pegasus for type 
// User Object n_cst_bso_imagemanager_pegasus
n_cst_bso_imagemanager_pegasus lnv_imagemanager_pegasus
lnv_imagemanager_pegasus = CREATE n_cst_bso_imagemanager_pegasus

// Instantiation of  variable lnv_filesrvwin32 for type UO pfc_n_cst_filesrvwin32
pfc_n_cst_filesrvwin32 lnv_filesrvwin32
lnv_filesrvwin32 = CREATE pfc_n_cst_filesrvwin32 

lnv_imagemanager_pegasus.of_GetImageTypes('SHIPMENT',lnva_ImageTypes[])

ll_TotalImages = lnv_imagemanager_pegasus.of_GetImageList & 
			(lnva_ImageTypes[],ll_ShipmentId[],lsa_ImagePaths[])

ll_UpperBound = UpperBound( lsa_ImagePaths[] )
	
DO WHILE ldbl_TotalSpace <= ldbl_DestinationArchiveSize
	FOR ll_Ctr = 1 TO ll_UpperBound		
		ls_FileName = lsa_ImagePaths [ll_Ctr]
		ldbl_TotalSpace = ldbl_TotalSpace + Long((lnv_filesrvwin32.of_GetFileSize(ls_FileName)/1024))
		IF ldbl_TotalSpace > ldbl_DestinationArchiveSize THEN
			EXIT
		END IF
	NEXT
LOOP

ls_FileName = lsa_ImagePaths[ll_Ctr]
lnv_filesrvwin32.of_ParsePath(ls_FileName,ls_Drive,ls_DirPath,ls_File,ls_Ext)
ll_ShipmentCtr = Long(ls_File)

// Rounding of RtndShipmentId to the closest hundred.
li_Len = LEN(String(ll_ShipmentCtr))
IF li_Len > 2 THEN 
	ls_ShipmentCtr = String(ll_ShipmentCtr)
	ls_ReplaceStr = '00'
	ls_ShipmentCtr = Replace(ls_ShipmentCtr,((li_Len - 2) + 1),2,ls_ReplaceStr)
	ll_ShipmentCtr = Long(ls_ShipmentCtr)
END IF

ll_ReturnValue = ll_ShipmentCtr

DESTROY lnv_imagemanager_pegasus
DESTROY lnv_filesrvwin32

RETURN ll_ReturnValue
end function

public function integer of_getimagingrootfolder (ref string as_imagingrootfolder);/////////////////////////////////////////////////////////
//
// Function		: of_getimagingrootfolder
// Arguments 	: as_imagingrootfolder, string, by reference
// Returns 		: Imaging Root folder stored in system settings table, Integer
// Description : Returns the value of Imaging folder stored in Systems 
//				     Settings table where Ss_id = 155
// Author		: ZMC
// Created on 	: 10-22-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Any la_imagingrootfolder // Any Datatype is the requirement of lnv_Settings.of_GetSetting method
String ls_imagingrootfolder

n_cst_settings lnv_Settings

li_ReturnValue = lnv_Settings.of_GetSetting( 33, la_imagingrootfolder)

ls_imagingrootfolder = String(la_imagingrootfolder)

IF li_ReturnValue = 1 AND ls_imagingrootfolder <> '' THEN
	as_imagingrootfolder = la_imagingrootfolder
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue
end function

public function integer of_createfolder (string as_path);/////////////////////////////////////////////////////////
//
// Function		: of_createfolder
// Arguments 	: as_path, string 
// Returns 		: 1 = Success, -1 = Failure
// Description : Create a folder when full path is passed to it on the 
//					  desired drive
// Author		: ZMC
// Created on 	: 10-23-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1

String ls_Path
String ls_Drive
String ls_DirPath
String ls_filename 
String ls_Separator 
String ls_PathBuild
String lsa_PathParts[]

Long ll_PartCount

ls_Path = as_path
ls_Separator = '\'

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32 
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

n_cst_String lnv_string

// Parse the path into parts and create directory by directory
IF lnv_FileSrvWin32.of_parsepath(ls_Path,ls_Drive,ls_DirPath,ls_filename) = 1 THEN
	ll_PartCount = lnv_string.of_parsetoarray(ls_DirPath,ls_Separator,lsa_PathParts[])
	IF ll_PartCount > 0 THEN
		ls_PathBuild = ls_Drive
		For ll_PartCount = 1 to UpperBound( lsa_PathParts[])			// loop thru dir path and create each directory as needed	
			ls_PathBuild = ls_PathBuild + lsa_PathParts[ll_PartCount] + ls_Separator
			IF lnv_FileSrvWin32.of_directoryExists(ls_PathBuild) THEN // Returns Boolean 			
				// Do nothing
			Else
				IF lnv_FileSrvWin32.of_CreateDirectory(ls_PathBuild) = 1 THEN				
				ELSE
					li_ReturnValue = -1 
					MessageBox(cs_ErrMsgHeader,'Can not create directory path: '+ ls_PathBuild ) 
					EXIT
				END IF
			End If
		Next
	ELSE	
		li_ReturnValue = -1 
		MessageBox(cs_ErrMsgHeader,'Parsing of path to array failed while copying images.') 
	END IF	
ELSE	
	li_ReturnValue = -1 
	MessageBox(cs_ErrMsgHeader,'Parsing of path failed while copying images.') 
END IF

DESTROY lnv_FileSrvWin32

Return li_ReturnValue
end function

public function integer of_getmaxvolumenumber (ref long al_maxvolumenumber);/////////////////////////////////////////////////////////
//
// Function		: of_getmaxvolumenumber
// Arguments 	: al_maxvolumenumber, long, by reference 
// Returns 		: 1 = Success, -1 = Failure
// Description : Retuns maximum volume volume number which is last volume number + 1
// Author		: ZMC
// Created on 	: 10-21-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1

Long ll_RowCount
Long ll_MaxVolumeNumber

DataStore lds_imagearchive

IF NOT IsValid(lds_imagearchive) THEN
	lds_imagearchive = Create DataStore
	lds_imagearchive.DataObject = 'd_imagingsettingsmanagerhistory'
	lds_imagearchive.SetTransObject(SQLCA)
END IF

lds_imagearchive.SetSort("volumenumberid")
lds_imagearchive.Sort()

ll_RowCount = lds_imagearchive.Retrieve()
Commit;

IF ll_RowCount > 0 THEN 
	ll_MaxVolumeNumber = lds_imagearchive.Object.VolumeNumberId[ll_RowCount]

	IF ll_MaxVolumeNumber = 0 THEN 
		ll_MaxVolumeNumber = 1
	ELSE
		ll_MaxVolumeNumber++
	END IF	

	al_maxvolumenumber =  ll_MaxVolumeNumber
ELSEIF ll_RowCount = 0 THEN
	ll_MaxVolumeNumber = 1
	al_maxvolumenumber = ll_MaxVolumeNumber
ELSE
	li_ReturnValue = -1
	MessageBox(cs_ErrMsgHeader,'Error while retrieving Imagearchive information.')
END IF	

Destroy lds_imagearchive
RETURN li_ReturnValue
end function

public function integer of_getshipmentrangeforvolume (long al_volumenumber, ref long al_startshipmentid, ref long al_endshipmentid);/////////////////////////////////////////////////////////
//
// Function		: of_getshipmentrangeforvolume
// Arguments 	: al_volumenumber, long
//					  al_startshipmentid, long, by reference	
//					  al_endshipmentid, long, by reference
// Returns 		: 1 = Success, -1 = Failure
// Description : Returns shipmet id range when a volume number is passed to it. 
// Author		: ZMC
// Created on 	: 10-20-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Int li_RowFound

Long ll_VolumeNumber
Long ll_RowCount
Long ll_StartShipmentId
Long ll_EndShipmentId

String ls_SearchStr

DataStore lds_ImageArchive

ll_VolumeNumber = al_volumenumber

IF Not IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DataStore
	lds_ImageArchive.DataObject = 'd_ImagingSettingsManagerHistory'
	lds_ImageArchive.SetTransObject(SQLCA)
END IF	

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;
IF ll_RowCount > 0 THEN
	ls_SearchStr 				= "volumenumberid = " + String(ll_VolumeNumber)
	li_RowFound 				= lds_ImageArchive.Find(ls_SearchStr,1,ll_RowCount)
	IF li_RowFound > 0 THEN
		ll_StartShipmentId 	= lds_ImageArchive.Object.StartShipmentId[li_RowFound] 
		ll_EndShipmentId 		= lds_ImageArchive.Object.EndShipmentId  [li_RowFound] 
		al_StartShipmentId	= ll_StartShipmentId
		al_EndShipmentId 		= ll_EndShipmentId 
	ELSEIF li_RowFound 		= 0 THEN
		li_ReturnValue 		= -1
		MessageBox(cs_ErrMsgHeader,'No shipmentid range found.')
	ELSE
		li_ReturnValue = -1
		MessageBox(cs_ErrMsgHeader,'Error finding shipment id range.')			
	END IF	
END IF

RETURN li_ReturnValue


end function

public function integer of_getarchivefolder (ref string as_foldername);/////////////////////////////////////////////////////////
//
// Function		: of_getarchivefolder
// Arguments 	: as_foldername, string, by reference
// Returns 		: 1 = Success, -1 = Failure
// Description : Returns the value of Archive folder 
//					  stored in Systems Settings table where Ss_id = 154
// Author		: ZMC
// Created on 	: 10-22-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Int li_RtnVal
Any la_value
String ls_value

n_cst_settings	lnv_settings

li_RtnVal = lnv_settings.of_GetSetting(154,la_value)

ls_value = String(la_value)

IF li_RtnVal = 1 AND ls_value <> '' THEN 
	as_foldername = la_value
ELSE
	li_ReturnValue = -1
END IF

Return li_ReturnValue



end function

public function integer of_generatearchiveimagelist (long ala_tmpnbrs[], n_cst_beo_imagetype ana_imagetypes[], ref n_cst_beo_image ana_images[], ref string asa_imagepaths[]);/*=================================================================================
of_GenerateArchiveImageList
				Arguments:
						ala_tmpnbrs[]   
						ana_imagetypes[]
						ana_images[]
						asa_imagepaths[]
						
						after calling of_GetImageList() the paths are used to populate a list 
						of images. of which are put in ana_images[]. Also the image paths are 
						put in asa_imagepaths[]						
						
Note : This method is an exact copy of the method of_GenerateImageList coded
			in n_cst_bso_imagemanager except for tha fact that down the line in 
			the code	this method checks for ll_ListReturn <= 0 as shown below 
			rather than checking for ll_ListReturn <> 1  
			IF ll_ListReturn <= 0 THEN
				li_ReturnValue = -1
			END IF

=================================================================================*/

Long						ll_IDs[]
String					lsa_ImagePaths[]
String					ls_ErrorMessage
Long 						k
Int						li_ReturnValue = 1
Long						ll_ListReturn 


n_cst_beo_Image		lnv_Image
n_cst_beo_image		lnva_Images[]


n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = CREATE n_cst_bso_ImageManager_Pegasus

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error


n_cst_beo_ImageType 	lnva_Imagetypes[]
ls_ErrorMessage = "An error occurred while attempting to generate a list of archive images."

IF Not IsValid ( inv_n_cst_Bcm ) THEN
	
	inv_n_cst_Bcm = gnv_BcmMgr.CreateBcm ( )
	IF Not isValid ( inv_n_cst_Bcm ) THEN
		li_ReturnValue = -1
	ELSE
		inv_n_cst_Bcm.SetDlk ( "n_cst_dlkc_image" )
		inv_n_cst_Bcm.AddClass ( "n_cst_beo_image" )
	END IF
END IF

IF li_ReturnValue = 1 THEN
	
	inv_n_cst_Bcm.SetDlk ( "n_cst_dlkc_image" )
	inv_n_cst_Bcm.AddClass ( "n_cst_beo_image" )
	
	ll_ListReturn = lnv_ImageManager_Pegasus.of_GetImageList (   ana_imagetypes[] , ala_tmpnbrs[], lsa_ImagePaths )
	
END IF

IF ll_ListReturn <= 0 THEN
	li_ReturnValue = -1
ELSE
	asa_ImagePaths[] = lsa_ImagePaths[]
END IF

IF li_ReturnValue = 1 THEN
	
	for K = 1 to upperbound ( lsa_ImagePaths ) 

		IF inv_n_cst_Bcm.NewBeo ( lnv_Image ) = -1 THEN
			li_ReturnValue = -1
			EXIT
		END IF
	
		li_ReturnValue = lnv_ImageManager_Pegasus.of_PopulateImage ( lsa_ImagePaths [ k ]  , lnv_image)
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

DESTROY lnv_ImageManager_Pegasus

Return li_ReturnValue






end function

public function string of_getrootfolder (integer ai_ssidnum);//Returns:   1 = Success 
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

// Argument = ai_ssidnum - ssid num from System settings table

String	ls_Description
String	lsa_Result[]
String	ls_Root
Integer	li_SqlCode
Integer 	li_ssidnum
Integer	li_Return = 1

n_cst_string	lnv_String

li_ssidnum = ai_ssidnum  


//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = :li_ssidnum;

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

public function integer of_getarchiveimagelist (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[], long al_volnum);/*==================================================================================
of_getArchiveImageList:
				
				Arguments:
					anva_beoimagetypearray[] = An array of image types that will be combined
														with all the tmpnumbers and then looked up to 
														determine if that particular image exists
					aula_tmpnumber[]			 = An array of all the tmpNumbers to be searched
				 	asa_imagepaths[] (reference)
					 								 = All images that were found will have their file
														paths inserted into the array and made available 
														to whatever called the function
					al_VolNum					= The volume number belonging to the Tmpid[]
													  in the archive 	
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
Long		ll_IDCount
Int		li_CreatePathReturn
Int		li_ReturnValue  = 1
Long 		i,k, j
Long		ll_BeoCount
Long 		ll_VolumeNumber

ll_VolumeNumber = al_VolNum

n_cst_beo_ImageType lnva_ImageType []
n_cst_beo_ImageType lnv_CurrentBeo

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

lnva_ImageType = anva_beoimagetypearray[]

n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = Create n_cst_bso_ImageManager_Pegasus

ls_ErrorMessage = "An error occurred while attempting to retrieve the image list."

ls_Root = THIS.of_GetRootfolder (154 )

IF IsNull(ls_Root) or Len (Trim(ls_Root)) = 0 THEN
	li_ReturnValue = -1
	ls_ErrorMessage = "An error occurred while attempting to locate file paths."
END IF

IF li_ReturnValue = 1 THEN
	
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
			
				li_CreatePathReturn = lnv_ImageManager_Pegasus.of_CreatePath & 
											( ls_Topic , ls_Category , ls_Type , lul_TmpNum , & 
											lsa_PathParts [] , lsa_NodeFolders [] )
			END IF
				
			IF li_CreatePathReturn <> 1 THEN
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while creating an image path."
			END IF
			
			IF li_ReturnValue = 1 THEN
				// The Document name is not in the PathParts, It is at the upperbound of the node folders
				ls_TotalPath = ls_Root + String(ll_VolumeNumber) +'\' + lsa_Pathparts [ upperBound ( lsa_PathParts ) ] +"\"+ &
								lsa_NodeFolders[ upperBound ( lsa_NodeFolders ) ] + ".tif"
			END IF		
				
			IF Len ( ls_TotalPath ) > 0 THEN
				IF lnv_ImageManager_Pegasus.of_DoesImageExist ( ls_TotalPath  ) THEN		

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

asa_ImagePaths[] =  lsa_ImagePaths[]

IF li_ReturnValue <> -1 THEN
	li_ReturnValue = UpperBound (  lsa_ImagePaths[] )
END IF

Destroy lnv_ImageManager_Pegasus

Return li_ReturnValue









end function

public function integer of_recopyimages (long ala_shipmentid[], string as_temporarytargetfolder, long al_volnum);/* /////////////////////////////////////////////////////////
//
// Function		: of_recopyimages
// Arguments 	: ala_shipmentid[], long
//					  as_temporarytargetfolder, string
//					  al_volnum,string
// Returns 		: 1 = Success, -1 Failure
// Description : Called to recopy images to local belonging to a volume number
//					  if the user deletes it accidently
// Author		: ZMC
// Created on 	: 10-20-03
// Modified by : Add Author here	TimeStamp
//				
///////////////////////////////////////////////////////// */

Int li_ReturnValue = 1

Long ll_Ctr
Int li_Pos
Int li_Count

Long ll_VolumeNumber
Long ll_UpperBound
Long lla_ShipmentId[]

String ls_Temp
String ls_OriImageFolder
String ls_OriTempFolder
String ls_ImagingRootFolder
String ls_TemporaryTargetFolder
String ls_VolumeNumber
String lsa_ImagePath[]

ll_VolumeNumber = al_volnum

lla_ShipmentId[] = ala_shipmentid[]
ls_TemporaryTargetFolder = as_temporarytargetfolder

n_cst_beo_ImageType lnva_ImageTypes[]

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

n_cst_bso_ImageManager lnv_imagemanager
lnv_imagemanager = CREATE n_cst_bso_ImageManager

n_cst_bso_ImageManager_Pegasus lnv_bso_imagemanager_pegasus
lnv_bso_imagemanager_pegasus = CREATE n_cst_bso_ImageManager_Pegasus

n_cst_bso_Document_Manager lnv_Document_Manager
lnv_Document_Manager = CREATE n_cst_bso_Document_Manager

ls_VolumeNumber = lnv_imagemanager.cs_VolNumPrefix + String(ll_VolumeNumber)

IF of_GetImagingRootFolder(ls_ImagingRootFolder) = 1 THEN
	IF lnv_bso_imagemanager_pegasus.of_GetImageTypes('SHIPMENT', & 
							lnva_ImageTypes[]) > 0 THEN 
		IF lnv_bso_imagemanager_pegasus.of_GetImageList(lnva_ImageTypes[], & 
								ala_shipmentid[],lsa_ImagePath[]) > 0 THEN
			ll_UpperBound = UpperBound(lsa_ImagePath[])
			ls_OriImageFolder = ls_ImagingRootFolder
			ls_OriTempFolder 	= ls_TemporaryTargetFolder
			li_Count 			= Len(ls_ImagingRootFolder)
//			li_Count 			= li_Count - 1
			
			IF li_ReturnValue = 1 THEN
				FOR ll_Ctr = 1 TO ll_UpperBound
					ls_ImagingRootFolder 		= lsa_ImagePath[ll_Ctr]
					li_Pos = Pos(Upper(ls_ImagingRootFolder),Upper(ls_OriImageFolder))
					IF li_Pos <= 0 THEN 
						li_ReturnValue = -1
						MessageBox(cs_ErrMsgHeader,'File not found.')
						EXIT
					END IF	
								
					ls_Temp 			 				= Replace(ls_ImagingRootFolder,li_Pos,li_Count,'')
					ls_TemporaryTargetFolder	= ls_OriTempFolder + '\' + ls_VolumeNumber +  ls_Temp
					
					
					
					IF of_CreateFolder(ls_TemporaryTargetFolder) = 1 THEN
						IF lnv_FileSrvWin32.of_FileCopy(ls_ImagingRootFolder,ls_TemporaryTargetFolder) <> 1 THEN				
							li_ReturnValue = -1
							MessageBox(cs_ErrMsgHeader,'File copy failed.')
							EXIT
						END IF
					ELSE
						li_ReturnValue = -1
						MessageBox(cs_ErrMsgHeader,'Failed to create folder.')
						EXIT
					END IF	
				Next
			END IF	
		ELSE	
			li_ReturnValue = -1
			MessageBox(cs_ErrMsgHeader,'Image list not found while recopying images.')
		END IF	
	ELSE	
		li_ReturnValue = -1
		MessageBox(cs_ErrMsgHeader,'Image types not found while recopying images.')
	END IF	
ELSE	
	li_ReturnValue = -1
	MessageBox(cs_ErrMsgHeader,'Imaging root folder information not found.')
END IF

DESTROY lnv_bso_imagemanager_pegasus
DESTROY lnv_FileSrvWin32
DESTROY lnv_imagemanager

Return li_ReturnValue
end function

public function integer of_doesarchiveimagesexists (long ala_shipmentid[], ref long ala_archiveshipmentidrange[], ref long ala_volumenumber[]);////////////////////////////////////////////////////////
//
// Function		: of_DoesArchiveImagesExists
// Arguments 	: ala_ShipmentId[], Long Array
//				     al_EndShipmentId, Long (by reference)
// Returns 		: 1 = Success, - 3 = Archived images range not found 
//										- 2 = Invoke of_GetImagepathsfromarchive from 
//												Pegasus
// Description : Add Description here
// Author		: Add Author Name here
// Created on 	: Add timestamp here
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
Long ll_Ctr
Int ll_Ctr1
Int li_Found
Long l

Long ll_RowCount

Long ll_VolumeNumber
Long ll_EndShipmentId
Long ll_StartShipmentId
Long ll_UpperShipmentId
Long ll_CurrentShipmentId
Long ll_LowerShipmentRange

Long lla_ShipmentId[]
Long lla_VolumeNumber[]
Long lla_archiveshipmentidrange[]

n_cst_AnyArraySrv lnv_AnyArraySrv

lla_ShipmentId = ala_ShipmentId

ll_UpperShipmentId = UpperBound(lla_ShipmentId)

DataStore lds_ImageArchive

IF NOT IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DataStore
	lds_ImageArchive.DataObject = 'd_ImagingSettingsManagerHistory'
	lds_ImageArchive.SetTransObject(SQLCA)
END IF


lds_ImageArchive.SetFilter("deletedfromcurrent = 1")
lds_ImageArchive.Filter()

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;

IF ll_RowCount > 0 THEN
	lds_ImageArchive.SetSort("VolumeNumberID A")
	lds_ImageArchive.Sort()
	
	ll_LowerShipmentRange = lla_ShipmentId[LowerBound(lla_ShipmentId[])]
	ll_Ctr1 = 1	

	FOR l = 1 TO UpperBound(lla_ShipmentId[])
		ll_CurrentShipmentId = lla_ShipmentId[l]		
		FOR ll_Ctr = 1 TO ll_RowCount
			ll_StartShipmentId = lds_ImageArchive.Object.StartShipmentId[ll_Ctr]
			ll_EndShipmentId = lds_ImageArchive.Object.EndShipmentId[ll_Ctr]
			IF ll_LowerShipmentRange >	ll_EndShipmentId THEN
				Continue;
			END IF
			
			IF  (ll_CurrentShipmentId >= ll_StartShipmentId AND  ll_CurrentShipmentId <= ll_EndShipmentId) THEN
				ll_VolumeNumber = lds_ImageArchive.Object.VolumeNumberId[ll_Ctr]
				lla_VolumeNumber[ll_Ctr1] = ll_VolumeNumber
				ll_Ctr1++
				li_Found = lds_ImageArchive.Find("VolumeNumberId = " + String(ll_VolumeNumber),1,ll_RowCount)
			END IF	
		NEXT 	
	NEXT 	
	// Shrink the array to remove duplicates & null.
	lnv_AnyArraySrv.of_GetShrinked(lla_VolumeNumber,TRUE,TRUE)
ELSE
	// Return -2 so that it will indicate that no archive images were found
	// and also in the of_viewimages method of Pegasus object 
	// it will set li_ReturnValue = 1 so that normal continualtion of 
	// of the program can continue. 
	li_ReturnValue = -2
END IF
	
Destroy lds_ImageArchive

ala_archiveshipmentidrange[] = lla_ShipmentId[]
ala_volumenumber[] = lla_VolumeNumber[]

Return li_ReturnValue
end function

public function integer of_getarchiveimagelistmultiple (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[]);/*==================================================================================
of_getArchiveImageListmultiple:
				
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
String 	ls_VolumeNumber
Long		lul_TmpNum
Long		lla_IDsWOImages[]
Long 		ll_volumeNumber
Long		ll_IDCount
Int		li_CreatePathReturn
Int		li_ReturnValue  = 1
Long 		i,k, j
long		ll_BeoCount

n_cst_beo_ImageType lnva_ImageType []
n_cst_beo_ImageType lnv_CurrentBeo

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error

lnva_ImageType = anva_beoimagetypearray[]

n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = Create n_cst_bso_ImageManager_Pegasus

ls_ErrorMessage = "An error occurred while attempting to retrieve the image list."

ls_Root = THIS.of_GetRootfolder (154 )

IF IsNull(ls_Root) or Len (Trim(ls_Root)) = 0 THEN
	li_ReturnValue = -1
	ls_ErrorMessage = "An error occurred while attempting to locate file paths."
END IF

IF li_ReturnValue = 1 THEN
	
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
			
				li_CreatePathReturn = lnv_ImageManager_Pegasus.of_CreatePath & 
											( ls_Topic , ls_Category , ls_Type , lul_TmpNum , & 
											lsa_PathParts [] , lsa_NodeFolders [] )
			END IF
				
			IF li_CreatePathReturn <> 1 THEN
				li_ReturnValue = -1
				ls_ErrorMessage = "An error occurred while creating an image path."
			END IF
			
			IF li_ReturnValue = 1 THEN
				
				of_getvolumeforshipmentrange( lul_TmpNum, ll_volumeNumber)
				ls_VolumeNumber = This.cs_VolNumPrefix + String(ll_volumeNumber)
				// The Document name is not in the PathParts, It is at the upperbound of the node folders
				ls_TotalPath = ls_Root + ls_VolumeNumber + '\' + lsa_Pathparts [ upperBound ( lsa_PathParts ) ] +"\"+ &
								lsa_NodeFolders[ upperBound ( lsa_NodeFolders ) ] + ".tif"
			END IF		
				
			IF Len ( ls_TotalPath ) > 0 THEN
				IF lnv_ImageManager_Pegasus.of_DoesImageExist ( ls_TotalPath  ) THEN		

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

asa_ImagePaths[] =  lsa_ImagePaths[]

IF li_ReturnValue <> -1 THEN
	li_ReturnValue = UpperBound (  lsa_ImagePaths[] )
END IF

Destroy lnv_ImageManager_Pegasus

Return li_ReturnValue









end function

public function integer of_getvolumeforshipmentrange (long al_shipmentid, ref long al_volumenumber);/////////////////////////////////////////////////////////
//
// Function		: of_getvolumeforshipmentrange
// Arguments 	: al_startshipmentid, long 
//					  al_endshipmentid, long
//					  al_volumenumber, long	by reference	
// Returns 		: 1 = Success, -1 = Failure
// Description : Returns Volume Number when a Shipment Id range is passed to it. 
// Author		: 
// Created on 	: 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1

Long ll_Ctr

Long ll_VolumeNumber
Long ll_RowCount
Long ll_ShipmentId
Long ll_EndShipmentId

ll_ShipmentId = al_shipmentid

DataStore lds_ImageArchive

IF Not IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DataStore
	lds_ImageArchive.DataObject = 'd_ImagingSettingsManagerHistory'
	lds_ImageArchive.SetTransObject(SQLCA)
END IF	

lds_ImageArchive.SetFilter('deletedfromcurrent = 1')
lds_ImageArchive.Filter()

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;
IF ll_RowCount > 0 THEN
	lds_ImageArchive.SetSort('volumenumberid A')
	lds_ImageArchive.Sort()
	FOR ll_Ctr = 1 TO ll_RowCount
		ll_EndShipmentId 		= lds_ImageArchive.Object.EndShipmentId  [ll_Ctr] 
		IF ll_ShipmentId <= ll_EndShipmentId THEN
			ll_VolumeNumber = lds_ImageArchive.Object.VolumeNumberId[ll_Ctr]
			Exit
		END IF
	NEXT
ELSE
	li_ReturnValue = -1
	MessageBox(cs_ErrMsgHeader,'No rows in ImageArchive table.')			
END IF

al_volumenumber = ll_VolumeNumber

RETURN li_ReturnValue


end function

public function integer of_isimagecurrentorarchived (long al_shipmentid, n_cst_beo_image anv_beo);/////////////////////////////////////////////////////////
//
// Function		: of_isimagecurrentorarchived
// Arguments 	: al_shipmentid, Long
// Returns 		: 1 = Current Image, -1 = Archived Image
// Description : Returns the info for an image whether is it's
//					  available in Imaging Root Folder or it's been archived
// Author		: ZMC
// Created on 	: 10-29-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
Long ll_ShipmentId
String ls_FilePath
String ls_ArchiveFolder
String ls_Drive,ls_DirPath,ls_File,ls_Ext

ll_ShipmentId = al_shipmentid

n_cst_beo_Image lnv_beo

lnv_beo = anv_beo

IF ISVALID(lnv_beo) THEN
	// get the whole path for this shipment id
	ls_FilePath = Upper(lnv_Beo.of_getFilePath())
	
	pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
	lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32
	lnv_filesrvwin32.of_ParsePath(ls_FilePath,ls_Drive,ls_DirPath,ls_File,ls_Ext)
	
	IF This.of_Doesarchiveimagesexists( Long(ls_File)) = 1 THEN
		li_ReturnValue = -1 // archived
	END IF
	
	/*
	// Get the archive folder location
	IF This.of_Getarchivefolder(ls_ArchiveFolder) = 1 THEN
		// Find the archive folder in the shipment id's file path
		IF Pos(ls_FilePath,Upper(ls_ArchiveFolder)) > 0 THEN
			li_ReturnValue = -1
		ELSE
			li_ReturnValue = 1
		END IF
	END IF
	*/
	
END IF

Destroy(lnv_FileSrvWin32)

Return li_ReturnValue
end function

public function integer of_getimagepathsfromarchive (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], ref string asa_imagepaths[]);/*
// Function	: of_GetImagepathsfromarchive:
// Arguments 	: anva_beoimagetypearray[] = An array of image types that will be combined
														with all the tmpnumbers and then looked up to 
														determine if that particular image exists
					aula_tmpnumber[]			 = An array of all the tmpNumbers to be searched
				 	asa_imagepaths[] (reference)
					 								 = All images that were found will have their file
														paths inserted into the array and made available 
														to whatever called the function
// Returns 		: 1 = Success, -1 Failure
// Description : Returns the image paths from the archive media where
//						the images might be externally stored						
// Author		: ZMC
// Created on 	: 10-24-03
// Modified by : Add Author here	TimeStamp
//				
*/
	
Int li_ReturnValue = 1

Long li_Ctr

Long lla_tmpnumber[]

Long ll_RowCount
Long ll_RowFound
Long ll_EndShipmentId
Long ll_VolumeNumberId
Long ll_StartShipmentId

String ls_ArchiveFolder
String lsa_ImagePaths[]

DataStore lds_ImageArchive

n_cst_beo_imageType	lnva_ImageTypes[]

lla_tmpnumber[] = aula_tmpnumber[]
lnva_ImageTypes[] = anva_beoimagetypearray[]

IF Not IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DATASTORE
	lds_ImageArchive.DataObject = 'd_imagingsettingsmanagerhistory'
END IF

lds_ImageArchive.SetTransObject(SQLCA)

lds_ImageArchive.SetFilter("DeletedfromCurrent = 1")
lds_ImageArchive.Filter()

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;

IF ll_RowCount > 0 THEN
	For li_Ctr = 1 to ll_RowCount
		ll_StartShipmentId = lds_ImageArchive.Object.StartShipmentId[li_Ctr]
		ll_EndShipmentId	 = lds_ImageArchive.Object.EndShipmentId[li_Ctr]
		// Check if lla_tmpnumber array has more than one element
		// If there's only one element, use 1 for the element 
		IF UpperBound(lla_tmpnumber) = 1 THEN 
			IF lla_tmpnumber[1] >= ll_StartShipmentId AND lla_tmpnumber[1] <= ll_EndShipmentId THEN
				li_ReturnValue = 1
				EXIT
			ELSE
				li_ReturnValue = -1
				CONTINUE
			END IF
		END IF	
	Next
	
	IF li_ReturnValue = 1 THEN
		ll_RowFound = lds_ImageArchive.Find("StartShipmentId = " + String(ll_StartShipmentId) + & 
						" and EndShipmentId = " + String(ll_EndShipmentId),1,ll_RowCount)
		IF ll_RowFound > 0 THEN				
			ll_VolumeNumberId = lds_ImageArchive.Object.VolumeNumberId[ll_RowFound]
			IF IsNull(ll_VolumeNumberId) OR ll_VolumeNumberId = 0 THEN 
				li_ReturnValue = -1 
				MessageBox(cs_ErrMsgHeader,'Image Volume number not found.')						
			END IF
		ELSE
			li_ReturnValue = 1
		END IF	
	ELSE
		li_ReturnValue = -1
		MessageBox(cs_ErrMsgHeader,'Shipment # ' + String(lla_tmpnumber[1]) + 'not found in Archive.')						
	END IF
	
	IF li_ReturnValue = 1 THEN
		IF of_GetArchivefolder(ls_ArchiveFolder) = 1 THEN
			IF MessageBox(cs_ErrMsgHeader,'If you wish to view image please insert Volume ' + String(ll_VolumeNumberId) + & 
				' in ' + ls_ArchiveFolder + ' to retrieve image from archive?',Information!,OkCancel!,2) = 1 THEN
				IF of_GetArchiveImageList ( lnva_ImageTypes[] ,lla_tmpnumber[], & 
													lsa_ImagePaths[],ll_VolumeNumberId)	> 0 THEN
					// Do Nothing
				ELSE
					li_ReturnValue = -1
					MessageBox(cs_ErrMsgHeader,'Shipment # ' + String(lla_tmpnumber[1]) + 'not found in Archive.')				
				END IF
			END IF			
		ELSE	
			li_ReturnValue = -1 
			MessageBox(cs_ErrMsgHeader,'Error while getting Archive folder information.')
		END IF
	END IF
END IF

DESTROY lds_ImageArchive

asa_imagepaths[] = lsa_ImagePaths[]

Return li_ReturnValue
end function

public function integer of_doesarchiveimagesexists (long al_shipmentid);/////////////////////////////////////////////////////////
//
// Function		: of_DoesArchiveImagesExists
// Arguments 	: ala_ShipmentId, Long 
// Returns 		: 1 = Success, - 1 Failure
// Description : Add Description here
// Author		: Add Author Name here
// Created on 	: Add timestamp here
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = -1 
Long ll_Ctr
Long ll_ShipmentId
Long ll_RowCount
Long ll_EndShipmentId
Long ll_VolumeNumber

ll_ShipmentId = al_ShipmentId

DataStore lds_ImageArchive

IF NOT IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DataStore
	lds_ImageArchive.DataObject = 'd_ImagingSettingsManagerHistory'
	lds_ImageArchive.SetTransObject(SQLCA)
END IF


lds_ImageArchive.SetFilter("deletedfromcurrent = 1")
lds_ImageArchive.Filter()

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;
IF ll_RowCount > 0 THEN
	lds_ImageArchive.SetSort("VolumeNumberID A")
	lds_ImageArchive.Sort()
	FOR ll_Ctr = 1 TO ll_RowCount
	 ll_EndShipmentId = lds_ImageArchive.Object.EndShipmentId[ll_Ctr]
	 IF ll_EndShipmentId > ll_shipmentid  THEN
		 li_ReturnValue = 1
		 EXIT
	 END IF
	NEXT
END IF	

Destroy lds_ImageArchive

Return li_ReturnValue 

end function

public function integer of_getimagepathforarchivedimages (n_cst_beo_imagetype anva_beoimagetypearray[], unsignedlong aula_tmpnumber[], long ala_volumenumbers[], ref string asa_imagepaths[]);/*
// Function	: of_getimagepathforarchivedimages:
// Arguments 	: anva_beoimagetypearray[] = An array of image types that will be combined
														with all the tmpnumbers and then looked up to 
														determine if that particular image exists
					aula_tmpnumber[]			 = An array of all the tmpNumbers to be searched
				 	asa_imagepaths[] (reference)
					 								 = All images that were found will have their file
														paths inserted into the array and made available 
														to whatever called the function
// Returns 		: 1 = Success, -1 Failure
// Description : Returns the image paths from the archive media where
//						the images might be externally stored						
// Author		: 
// Created on 	: 
// Modified by : Add Author here	TimeStamp
//				
*/
	
Int li_ReturnValue = 1
Long li_Ctr
Long lla_tmpnumber[]

Long ll_EndShipmentId
Long ll_StartShipmentId
Long ll_VolumeNumber[]
Long ll_UpperBound	

String ls_ArchiveFolder
String lsa_ImagePaths[]
String  ls_VolumeNumberId

n_cst_beo_ImageType lnva_ImageTypes[]

lnva_ImageTypes[] = anva_beoimagetypearray[]

lla_tmpnumber[] = aula_tmpnumber[]
ll_VolumeNumber[] = ala_volumenumbers[]
	
ll_UpperBound = UpperBound(ll_VolumeNumber[])

IF ll_UpperBound > 0 THEN
	li_Ctr = 0
	FOR li_Ctr = 1 TO ll_UpperBound
		ls_VolumeNumberId	= ls_VolumeNumberId + This.cs_VolNumPrefix + String(ll_VolumeNumber[li_Ctr]) + ','
	NEXT
	ls_VolumeNumberId = Left(ls_VolumeNumberId,(Len(ls_VolumeNumberId) - 1))
END IF
	
IF This.of_GetArchivefolder(ls_ArchiveFolder) = 1 THEN
	IF MessageBox(cs_ErrMsgHeader,'If you wish to view image(s) please insert Volume ' +  ls_VolumeNumberId + & 
		' in ' + ls_ArchiveFolder + ' to retrieve image from archive?',Information!,OkCancel!,2) = 1 THEN
		IF of_GetArchiveImageListmultiple ( lnva_ImageTypes[] ,lla_tmpnumber[], &
											lsa_ImagePaths[])	> 0 THEN
			// Do Nothing
		ELSE
			li_ReturnValue = -1
			//MessageBox(cs_ErrMsgHeader,'Shipment # ' + String(lla_tmpnumber[1]) + 'not found in Archive')				
		END IF
	END IF			
ELSE	
	li_ReturnValue = -1 
	MessageBox(cs_ErrMsgHeader,'Error while getting Archive folder information.')
END IF

asa_imagepaths[] = lsa_ImagePaths[]

Return li_ReturnValue

end function

public function integer of_copyallimages (long ala_shipmentid[], string as_temporarytargetfolder, ref string as_volumenumber);/////////////////////////////////////////////////////////
//
// Function		: of_copyallimages
// Arguments 	: ala_shipmentid[], long Array
//					  as_temporarytargetfolder, string 	
// Returns 		: 1 = Success, -1 = Failure
// Description : Copy images from Imaging root folder to local drive
// Author		: ZMC
// Created on 	: 10-24-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Long ll_Ctr
Int li_Pos
Int li_Count

Long ll_maxvolumenumber
Long ll_UpperBound
Long ll_shipmentid[]

String ls_temp
String ls_OriImageFolder
String ls_OriTempFolder
String ls_ImagingRootFolder
String ls_volumenumber
String ls_temporarytargetfolder
String ls_ImagePath[]

ll_shipmentid[] = ala_shipmentid[]
ls_temporarytargetfolder = as_temporarytargetfolder

n_cst_beo_ImageType lnva_ImageTypes[]

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

n_cst_bso_ImageManager lnv_ImageManager
lnv_imagemanager = CREATE n_cst_bso_ImageManager

n_cst_bso_ImageManager_Pegasus lnv_imagemanager_pegasus
lnv_imagemanager_pegasus = CREATE n_cst_bso_ImageManager_Pegasus

n_cst_bso_Document_Manager lnv_Document_Manager
lnv_Document_Manager = CREATE n_cst_bso_Document_Manager

IF of_GetImagingRootFolder(ls_ImagingRootFolder) = 1 THEN
	IF lnv_imagemanager_pegasus.of_GetImageTypes('SHIPMENT', & 
							lnva_ImageTypes[]) > 0 THEN 
		IF lnv_imagemanager_pegasus.of_GetImageList(lnva_ImageTypes[], & 
								ala_shipmentid[],ls_ImagePath[]) > 0 THEN
			ll_UpperBound = UpperBound(ls_ImagePath[])
			ls_OriImageFolder = ls_ImagingRootFolder
			ls_OriTempFolder 	= ls_temporarytargetfolder
			li_Count 			= Len(ls_ImagingRootFolder)
			//li_Count 			= li_Count - 1
			
			// Get New Volume Number
			IF of_getmaxvolumenumber(ll_maxvolumenumber) = 1 THEN
				ls_volumenumber = lnv_imagemanager.cs_VolNumPrefix + String(ll_maxvolumenumber)
				as_VolumeNumber = ls_volumenumber
			ELSE
				li_ReturnValue = -1 	
				MessageBox(cs_ErrMsgHeader,'No new volume number got generated.')
			END IF
			
			IF li_ReturnValue = 1 THEN
				FOR ll_Ctr = 1 TO ll_UpperBound
					ls_ImagingRootFolder 		= ls_ImagePath[ll_Ctr]
					li_Pos = Pos(Upper(ls_ImagingRootFolder),Upper(ls_OriImageFolder))
					IF li_Pos <= 0 THEN 
						li_ReturnValue = -1
						MessageBox(cs_ErrMsgHeader,'File not found.')
						EXIT
					END IF	
								
					ls_temp 			 				= Replace(ls_ImagingRootFolder,li_Pos,li_Count,'')
					ls_temporarytargetfolder	= ls_OriTempFolder + '\' +ls_volumenumber +  ls_temp
					
					IF of_CreateFolder(ls_temporarytargetfolder) = 1 THEN
						IF lnv_FileSrvWin32.of_FileCopy(ls_ImagingRootFolder,ls_temporarytargetfolder) <> 1 THEN
							li_ReturnValue = -1
							MessageBox(cs_ErrMsgHeader,'File copy failed.')
							EXIT
						END IF
					ELSE
						li_ReturnValue = -1
						MessageBox(cs_ErrMsgHeader,'Failed to create folder.')
						EXIT
					END IF	
				Next
			END IF	
		ELSE	
			li_ReturnValue = -1
			MessageBox(cs_ErrMsgHeader,'Image list not found while copying images.')
		END IF	
	ELSE	
		li_ReturnValue = -1
		MessageBox(cs_ErrMsgHeader,'Image types not found while copying images.')
	END IF	
ELSE	
	li_ReturnValue = -1
	MessageBox(cs_ErrMsgHeader,'Imaging root folder information not found.')
END IF

DESTROY lnv_imagemanager
DESTROY lnv_imagemanager_pegasus
DESTROY lnv_FileSrvWin32

RETURN li_ReturnValue
end function

public function long of_extractvolumenumber (string as_volume);/////////////////////////////////////////////////////////
//
// Function		: of_extractvolumenumber 
// Arguments 	: as_volume, string
// Returns 		: Numeric part of VolumeNumber
// Description : Pass This.cs_VolNumPrefix + VolumeNumber and get volumenumber back
// Author		: ZMC
// Created on 	: 10-30-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Long ll_VolumeNumber
String ls_volume

ls_volume 			= as_volume
ll_VolumeNumber 	= Long(Mid(ls_volume,10))

Return ll_VolumeNumber

end function

public function boolean of_gettemporarytargetfolder (ref string as_foldername);/////////////////////////////////////////////////////////
//
// Function		: of_gettemporarytargetfolder
// Arguments 	: as_foldername, String
// Returns 		: True - Found, False - Not Found
// Description : Retuns teh value stored in systems settings table for temporary target folder 
//					  where SSid = 153
// Author		: ZMC
// Created on 	: 10-30-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Boolean lb_ReturnValue
Any la_value
String ls_value

n_cst_settings	lnv_settings

lnv_settings.of_GetSetting(153,la_value)

ls_value = String(la_value)

IF	 ISNULL(ls_value) OR LEN(TRIM(ls_value)) = 0 THEN
	lb_ReturnValue =  FALSE
ELSE
	as_foldername = la_value 
	lb_ReturnValue = TRUE
END IF

Return lb_ReturnValue
end function

public function integer of_getimagingversioncontrol (ref n_cst_imagingversioncontrol anv_version);Int		li_Return = -1
String	ls_Version
String	ls_RegistryValue
String	lsa_ValueArray[]
n_cst_imagingversioncontrol	lnv_Version

ls_Version = "n_cst_imagingversioncontrol"

IF RegistryGet ( "HKEY_LOCAL_MACHINE\SOFTWARE\Profit Tools Inc.\Document Imaging", "version", RegString!, ls_RegistryValue ) = 1 THEN
	ls_Version += "_" + ls_RegistryValue
	li_Return = 1
ELSE // we will check to see if the dlls are registered the old way to backwards compatability
	IF RegistryValues( "HKEY_CLASSES_ROOT\imagXpr4.ImagXpress.1",lsa_ValueArray) = 1 THEN 
		ls_Version += "_1" 
		li_Return = 1
	END IF
END IF

IF li_Return = 1 THEN
	lnv_Version = CREATE Using ls_Version
	anv_version = lnv_Version
END IF

RETURN li_Return
end function

public function integer of_calcarchivesize (long ala_startshipmentid[], double adbl_maxarchivesize, ref long al_shipmentctr, ref double adbl_totalarchivesize);/////////////////////////////////////////////////////////
//
// Function		: of_calcarchivesize
// Arguments 	: ala_startshipmentid[], long array 
//					  adbl_totalarchivesize, double
// Returns 		: 1 = Success, - 1 = Failure
// Description : Calculates the size in bytes & retuns in KB of 
//					  the shipment Id range passed. 
// Author		: ZMC
// Created on 	: 10-15-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int		li_ReturnValue = 1
Int 		li_Len

Long		ll_Ctr
Long 		lla_Shipmentid[]
Long 		ll_TotalImages
Long 		ll_ShipmentCtr

Double	ldbl_TotSpace
Double	ldbl_FileSize
Double   ldbl_FileSpace

String 	ls_ErrMsg
String 	ls_FileName 
String 	ls_Drive
String 	ls_DirPath
String 	ls_File
String 	ls_Ext
String 	ls_ErrorMessage
String 	ls_ShipmentCtr
String 	ls_ReplaceStr

String	lsa_ImagePaths[]		


lla_Shipmentid = ala_startshipmentid
ls_ErrorMessage = "An error occurred while attempting to generate a list of images."

n_cst_beo_ImageType lnva_ImageTypes[]

n_cst_bso_imagemanager_pegasus lnv_imagemanager_pegasus
lnv_imagemanager_pegasus = CREATE n_cst_bso_imagemanager_pegasus

pfc_n_cst_filesrvwin32 lnv_filesrvwin32
lnv_filesrvwin32 = CREATE pfc_n_cst_filesrvwin32

ls_ErrMsg = 'No images found for shipment Id range from ' + &
				String(lla_Shipmentid[LowerBound(lla_Shipmentid)])  + ' and ' + &
				String(lla_Shipmentid[UpperBound(lla_Shipmentid)]) + '.'

IF lnv_imagemanager_pegasus.of_GetImageTypes('SHIPMENT',lnva_ImageTypes[]) > 0 THEN
	ll_TotalImages = lnv_imagemanager_pegasus.of_GetImageList &
				(lnva_ImageTypes[],lla_Shipmentid[],lsa_ImagePaths[])
	IF ll_TotalImages > 0 THEN
	ELSE
		li_ReturnValue = -1
		ls_ErrMsg = 'No images found for shipment Id range from ' + &
						String(lla_Shipmentid[LowerBound(lla_Shipmentid)])  + ' and ' + &
						String(lla_Shipmentid[UpperBound(lla_Shipmentid)]) + '.'
		MessageBox(This.cs_ErrMsgHeader,ls_ErrMsg)
	END IF
	
	IF li_ReturnValue = 1  THEN
		ldbl_TotSpace 	= 0
		ldbl_FileSize 	= 0
		ldbl_FileSpace = 0 
		FOR ll_Ctr = 1 TO ll_TotalImages
			ls_filename = lsa_ImagePaths[ll_Ctr]
			ldbl_FileSize 	= lnv_filesrvwin32.of_GetFileSize(ls_filename)
			ldbl_TotSpace 	= ldbl_TotSpace + ldbl_FileSize // Accumulate file sizes
			
			ldbl_FileSpace = Long(ldbl_TotSpace / 1024)

			IF ldbl_FileSpace > adbl_MaxArchiveSize THEN
				EXIT
			END IF
		NEXT
		ls_FileName = lsa_ImagePaths[ll_Ctr]
		lnv_filesrvwin32.of_ParsePath(ls_FileName,ls_Drive,ls_DirPath,ls_File,ls_Ext)
		ll_ShipmentCtr = Long(ls_File)
		
		// Rounding of RtndShipmentId to the closest hundred.
		li_Len = LEN(String(ll_ShipmentCtr))
		IF li_Len > 2 THEN
			ls_ShipmentCtr = String(ll_ShipmentCtr)
			ls_ReplaceStr = '00'
			ls_ShipmentCtr = Replace(ls_ShipmentCtr,((li_Len - 2) + 1),2,ls_ReplaceStr)
			ll_ShipmentCtr = Long(ls_ShipmentCtr)
		END IF
	END IF
ELSE	
	li_ReturnValue = -1
	MessageBox(cs_ErrMsgHeader,ls_ErrMsg)
END IF

adbl_totalarchivesize = ldbl_FileSpace
al_ShipmentCtr = ll_ShipmentCtr

DESTROY lnv_imagemanager_pegasus
DESTROY lnv_filesrvwin32

RETURN li_ReturnValue
end function

public function integer of_copyallimages (string as_temporarytargetfolder, ref string as_volumenumber, n_cst_beo_imagetype anva_imagetypes[], string asa_imagepaths[]);/////////////////////////////////////////////////////////
//
// Function		: of_copyallimages
// Arguments 	: ala_shipmentid[], long Array
//					  as_temporarytargetfolder, string 	
// Returns 		: 1 = Success, -1 = Failure
// Description : Copy images from Imaging root folder to local drive
// Author		: ZMC
// Created on 	: 10-24-03
// Modified by : Add Author here	TimeStamp
//				
///////////////////////////////////////////////////////// 

Int li_ReturnValue = 1
Long ll_Ctr
Int li_Pos
Int li_Count

Long ll_maxvolumenumber
Long ll_UpperBound
Long ll_shipmentid[]

String ls_temp
String ls_OriImageFolder
String ls_OriTempFolder
String ls_ImagingRootFolder
String ls_volumenumber
String ls_temporarytargetfolder
String ls_ImagePath[]

ls_temporarytargetfolder = as_temporarytargetfolder

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

n_cst_bso_Document_Manager lnv_Document_Manager
lnv_Document_Manager = CREATE n_cst_bso_Document_Manager

IF of_GetImagingRootFolder(ls_ImagingRootFolder) = 1 THEN
	ll_UpperBound 		= UpperBound(asa_ImagePaths[])
	ls_OriImageFolder = ls_ImagingRootFolder
	ls_OriTempFolder 	= ls_temporarytargetfolder
	li_Count 			= Len(ls_ImagingRootFolder)
	//li_Count 			= li_Count - 1
			
	// Get New Volume Number
	IF of_getmaxvolumenumber(ll_maxvolumenumber) = 1 THEN
		ls_volumenumber = This.cs_VolNumPrefix + String(ll_maxvolumenumber)
		as_VolumeNumber = ls_volumenumber
	ELSE
		li_ReturnValue = -1 	
		MessageBox(cs_ErrMsgHeader,'No new volume number got generated.')
	END IF
			
	IF li_ReturnValue = 1 THEN
		FOR ll_Ctr = 1 TO ll_UpperBound
			ls_ImagingRootFolder 		= asa_ImagePaths[ll_Ctr]
			li_Pos = Pos(Upper(ls_ImagingRootFolder),Upper(ls_OriImageFolder))
			IF li_Pos <= 0 THEN 
				li_ReturnValue = -1
				MessageBox(cs_ErrMsgHeader,'File not found.')
				EXIT
			END IF	
						
			ls_temp 			 				= Replace(ls_ImagingRootFolder,li_Pos,li_Count,'')
			ls_temporarytargetfolder	= ls_OriTempFolder
			IF Right ( ls_temporarytargetfolder , 1 ) <> "\" THEN
				ls_Temporarytargetfolder +=  '\' 
			END IF
			
			IF Left ( ls_Temp,1 ) <> '\' THEN
				// there was a problem w.o. this if the 'pos' match removed the '\' 
				ls_Temp = '\' + ls_temp
				
			END IF
			
			ls_temporarytargetfolder += ls_volumenumber +  ls_temp
			
			IF of_CreateFolder(ls_temporarytargetfolder) = 1 THEN
				IF lnv_FileSrvWin32.of_FileCopy(ls_ImagingRootFolder,ls_temporarytargetfolder) <> 1 THEN
					li_ReturnValue = -1
					MessageBox(cs_ErrMsgHeader,'File copy failed.')
					EXIT
				END IF
			ELSE
				li_ReturnValue = -1
				MessageBox(cs_ErrMsgHeader,'Failed to create folder.')
				EXIT
			END IF	
		Next
	END IF	
ELSE	
	li_ReturnValue = -1
	MessageBox(cs_ErrMsgHeader,'Imaging root folder information not found.')
END IF

DESTROY lnv_FileSrvWin32

RETURN li_ReturnValue
end function

public function integer of_recopyimages (unsignedlong al_startshipmentid, unsignedlong al_endshipmentid, string as_temporarytargetfolder, long al_volnum, n_cst_beo_imagetype anva_imagetypes[], readonly string asa_imagepaths[]);/* /////////////////////////////////////////////////////////
//
// Function		: of_recopyimages
// Arguments 	: ala_shipmentid[], long
//					  as_temporarytargetfolder, string
//					  al_volnum,string
// Returns 		: 1 = Success, -1 Failure
// Description : Called to recopy images to local belonging to a volume number
//					  if the user deletes it accidently
// Author		: ZMC
// Created on 	: 10-20-03
// Modified by : Add Author here	TimeStamp
//				
///////////////////////////////////////////////////////// */ 

Int li_ReturnValue = 1

Long ll_Ctr
Int li_Pos
Int li_Count

Long ll_VolumeNumber
Long ll_UpperBound

String ls_Temp
String ls_OriImageFolder
String ls_OriTempFolder
String ls_ImagingRootFolder
String ls_TemporaryTargetFolder
String ls_VolumeNumber

ll_VolumeNumber = al_volnum

ls_TemporaryTargetFolder = as_temporarytargetfolder

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

ls_VolumeNumber = This.cs_VolNumPrefix + String(ll_VolumeNumber)

IF of_GetImagingRootFolder(ls_ImagingRootFolder) = 1 THEN
	ll_UpperBound = UpperBound(asa_ImagePaths[])
	ls_OriImageFolder = ls_ImagingRootFolder
	ls_OriTempFolder 	= ls_TemporaryTargetFolder
	li_Count 			= Len(ls_ImagingRootFolder)
	
	IF li_ReturnValue = 1 THEN
		FOR ll_Ctr = 1 TO ll_UpperBound
			ls_ImagingRootFolder 		= asa_ImagePaths[ll_Ctr]
			li_Pos = Pos(Upper(ls_ImagingRootFolder),Upper(ls_OriImageFolder))
			IF li_Pos <= 0 THEN 
				li_ReturnValue = -1
				MessageBox(cs_ErrMsgHeader,'File not found.')
				EXIT
			END IF	
						
			ls_Temp 			 				= Replace(ls_ImagingRootFolder,li_Pos,li_Count,'')
			ls_TemporaryTargetFolder	= ls_OriTempFolder + '\' + ls_VolumeNumber +  ls_Temp
			
			IF of_CreateFolder(ls_TemporaryTargetFolder) = 1 THEN
				IF lnv_FileSrvWin32.of_FileCopy(ls_ImagingRootFolder,ls_TemporaryTargetFolder) <> 1 THEN				
					li_ReturnValue = -1
					MessageBox(cs_ErrMsgHeader,'File copy failed.')
					EXIT
				END IF
			ELSE
				li_ReturnValue = -1
				MessageBox(cs_ErrMsgHeader,'Failed to create folder.')
				EXIT
			END IF	
		Next
	END IF	
ELSE	
	li_ReturnValue = -1
	MessageBox(cs_ErrMsgHeader,'Image list not found while recopying images.')
END IF	

DESTROY lnv_FileSrvWin32

Return li_ReturnValue
end function

public function integer of_generatearchiveimagelist (unsignedlong al_startshipmentid, unsignedlong al_endshipmentid, n_cst_beo_imagetype ana_imagetypes[], ref n_cst_beo_image ana_images[], string asa_imagepaths[]);/*=================================================================================
of_GenerateArchiveImageList
				Arguments:
						ala_tmpnbrs[]   
						ana_imagetypes[]
						ana_images[]
						asa_imagepaths[]
						
						after calling of_GetImageList() the paths are used to populate a list 
						of images. of which are put in ana_images[]. Also the image paths are 
						put in asa_imagepaths[]						
						
Note : This method is an exact copy of the method of_GenerateImageList coded
			in n_cst_bso_imagemanager except for tha fact that down the line in 
			the code	this method checks for ll_ListReturn <= 0 as shown below 
			rather than checking for ll_ListReturn <> 1  
			IF ll_ListReturn <= 0 THEN
				li_ReturnValue = -1
			END IF

=================================================================================*/

Long						ll_IDs[]
String					lsa_ImagePaths[]
String					ls_ErrorMessage
Long 						k
Int						li_ReturnValue = 1
Long						ll_ListReturn 


n_cst_beo_Image		lnv_Image
n_cst_beo_image		lnva_Images[]


n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = CREATE n_cst_bso_ImageManager_Pegasus

n_cst_OFRError_Collection lnv_ErrorCollection
n_cst_OFRError lnv_ErrorArray[]
n_cst_OFRError lnv_Error


ls_ErrorMessage = "An error occurred while attempting to generate a list of archive images."

IF Not IsValid ( inv_n_cst_Bcm ) THEN
	
	inv_n_cst_Bcm = gnv_BcmMgr.CreateBcm ( )
	IF Not isValid ( inv_n_cst_Bcm ) THEN
		li_ReturnValue = -1
	ELSE
		inv_n_cst_Bcm.SetDlk ( "n_cst_dlkc_image" )
		inv_n_cst_Bcm.AddClass ( "n_cst_beo_image" )
	END IF
END IF

IF li_ReturnValue = 1 THEN
	
	inv_n_cst_Bcm.SetDlk ( "n_cst_dlkc_image" )
	inv_n_cst_Bcm.AddClass ( "n_cst_beo_image" )
	
END IF

lsa_ImagePaths = asa_ImagePaths

IF li_ReturnValue = 1 THEN
	
	for K = 1 to upperbound ( lsa_ImagePaths ) 

		IF inv_n_cst_Bcm.NewBeo ( lnv_Image ) = -1 THEN
			li_ReturnValue = -1
			EXIT
		END IF
	
		li_ReturnValue = lnv_ImageManager_Pegasus.of_PopulateImage ( lsa_ImagePaths [ k ]  , lnv_image)
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

DESTROY lnv_ImageManager_Pegasus

Return li_ReturnValue






end function

public function integer of_calcarchivesize (long al_startshipmentid, long al_endshipmentid, double adbl_maxarchivesize, ref long al_shipmentctr, ref double adbl_totalarchivesize, ref n_cst_beo_imagetype anva_imagetypes[], ref string asa_imagepaths[], ref long al_ctr);/////////////////////////////////////////////////////////
//
// Function		: of_calcarchivesize
// Arguments 	: ala_startshipmentid[], long array 
//					  adbl_totalarchivesize, double
// Returns 		: 1 = Success, - 1 = Failure
// Description : Calculates the size in bytes & retuns in KB of 
//					  the shipment Id range passed. 
// Author		: ZMC
// Created on 	: 10-15-03
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int		li_ReturnValue = 1
Int 		li_Len

Long		ll_Ctr
Long 		ll_TotalImages
Long 		ll_ShipmentCtr
Long 		ll_StartShipmentId
Long 		ll_EndShipmentId


Double	ldbl_TotSpace
Double	ldbl_FileSize
Double   ldbl_FileSpace

String 	ls_ErrMsg
String 	ls_FileName 
String 	ls_Drive
String 	ls_DirPath
String 	ls_File
String 	ls_Ext
String 	ls_ErrorMessage
String 	ls_ShipmentCtr
String 	ls_ReplaceStr

String	lsa_ImagePaths[]		

ll_StartShipmentId = al_startshipmentid
ll_EndShipmentId	 = al_Endshipmentid

ls_ErrorMessage = "An error occurred while attempting to generate a list of images."

n_cst_beo_ImageType lnva_ImageTypes[]

n_cst_bso_imagemanager_pegasus lnv_imagemanager_pegasus
lnv_imagemanager_pegasus = CREATE n_cst_bso_imagemanager_pegasus

pfc_n_cst_filesrvwin32 lnv_filesrvwin32
lnv_filesrvwin32 = CREATE pfc_n_cst_filesrvwin32

ls_ErrMsg = 'No images found for shipment Id range from ' + &
						String(ll_StartShipmentid)   + ' and ' + &
						String(ll_EndShipmentid)  + '.' + & 
						' Do you wish to proceed with Shipment # starting from ' + String(ll_EndShipmentid + 1) + '?' 

IF lnv_imagemanager_pegasus.of_GetImageTypes('SHIPMENT',lnva_ImageTypes[]) > 0 THEN
	
	ll_TotalImages = lnv_imagemanager_pegasus.of_GetImageList &
				(lnva_ImageTypes[],al_startshipmentid,al_Endshipmentid,lsa_ImagePaths[])

	IF ll_TotalImages > 0 THEN
	ELSE
		li_ReturnValue = -1
		IF MessageBox(This.cs_ErrMsgHeader,ls_ErrMsg,Question!,YesNo!,2) = 1 THEN
			li_ReturnValue = -2
		ELSE
			li_ReturnValue = -1
		END IF	
	END IF
	
	IF li_ReturnValue = 1  THEN
		ldbl_TotSpace 	= 0
		ldbl_FileSize 	= 0
		ldbl_FileSpace = 0 
		FOR ll_Ctr = 1 TO ll_TotalImages
			ls_filename = lsa_ImagePaths[ll_Ctr]
			ldbl_FileSize 	= lnv_filesrvwin32.of_GetFileSize(ls_filename)
			ldbl_TotSpace 	= ldbl_TotSpace + ldbl_FileSize // Accumulate file sizes
			
			ldbl_FileSpace = Long(ldbl_TotSpace / 1024)

			IF ldbl_FileSpace > adbl_MaxArchiveSize THEN
				ls_FileName = lsa_ImagePaths[ll_Ctr]
				lnv_filesrvwin32.of_ParsePath(ls_FileName,ls_Drive,ls_DirPath,ls_File,ls_Ext)
				ll_ShipmentCtr = Long(ls_File)
				EXIT
			END IF
		NEXT
		
		al_Ctr = ll_Ctr
		
		// Rounding of RtndShipmentId to the closest hundred.
		li_Len = LEN(String(ll_ShipmentCtr))
		IF li_Len > 2 THEN
			ls_ShipmentCtr = String(ll_ShipmentCtr)
			ls_ReplaceStr = '00'
			ls_ShipmentCtr = Replace(ls_ShipmentCtr,((li_Len - 2) + 1),2,ls_ReplaceStr)
			ll_ShipmentCtr = Long(ls_ShipmentCtr)
		END IF
	END IF
ELSE	
	IF MessageBox(This.cs_ErrMsgHeader,ls_ErrMsg,Question!,YesNo!,2) = 1 THEN
		li_ReturnValue = -2
	ELSE
		li_ReturnValue = -1
	END IF	
END IF

adbl_totalarchivesize	= ldbl_FileSpace
al_ShipmentCtr 			= ll_ShipmentCtr
anva_imagetypes 			= lnva_ImageTypes
asa_imagepaths 			= lsa_ImagePaths

DESTROY lnv_imagemanager_pegasus
DESTROY lnv_filesrvwin32

RETURN li_ReturnValue
end function

public function boolean of_hasimagebeencopiedtoarchive (n_cst_beo_image anv_image);Boolean lb_RtnVal

Long ll_ShipmentId
Long ll_MaxShipmentID
String ls_FilePath
String ls_Drive,ls_DirPath,ls_File,ls_Ext

n_cst_beo_Image lnv_Image

lnv_Image = anv_image



IF IsValid(lnv_Image) THEN
	// get the whole path for this shipment id
	ls_FilePath = Upper(lnv_Image.of_getFilePath())
	
	IF POS ( Upper ( ls_FilePath ) , Upper ( "C:\imagetmp\" ) ) = 0 THEN  // skip files in the batch temp folder
		
	
		pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
		lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32
		lnv_filesrvwin32.of_ParsePath(ls_FilePath,ls_Drive,ls_DirPath,ls_File,ls_Ext)
	
		ll_ShipmentId = Long(ls_File)	
		
		SELECT Max(EndShipmentId) INTO :ll_MaxShipmentID 
		FROM ImageArchive;
		Commit;
		
		IF (Not IsNull(ll_MaxShipmentID)) OR (ll_MaxShipmentID > 0) THEN
			IF ll_ShipmentId <= ll_MaxShipmentID  THEN
				lb_RtnVal = TRUE			
			END IF	
		END IF
		
	END IF
	
END IF

Destroy(lnv_FileSrvWin32)

Return lb_RtnVal
end function

public function integer of_gettmparchivestatus (long al_shipmentid);//	1 active
// -1 Archived
// -2 Copied


Int	li_Return = 1

Long 	ll_Ctr
Long 	ll_ShipmentId
Long 	ll_RowCount
Long 	ll_EndShipmentId
Long 	ll_VolumeNumber
Int	li_DeletedStatus

ll_ShipmentId = al_ShipmentId

DataStore lds_ImageArchive

lds_ImageArchive = CREATE DataStore
lds_ImageArchive.DataObject = 'd_ImagingSettingsManagerHistory'
lds_ImageArchive.SetTransObject(SQLCA)

ll_RowCount = lds_ImageArchive.Retrieve()

IF ll_RowCount > 0 THEN
	lds_ImageArchive.SetSort("VolumeNumberID A")
	lds_ImageArchive.Sort()
	
	FOR ll_Ctr = 1 TO ll_RowCount
		ll_EndShipmentId = lds_ImageArchive.Object.EndShipmentId[ll_Ctr]
		IF ll_EndShipmentId >= ll_shipmentid  THEN
			li_DeletedStatus = lds_ImageArchive.Object.deletedfromcurrent[ll_Ctr]
			IF li_DeletedStatus = 1 THEN
				li_Return = -1
			ELSE
				li_Return = -2
			END IF
			EXIT
		END IF
	NEXT
	
END IF	

Destroy lds_ImageArchive

Return li_Return 

end function

public function integer of_viewunassignedimages ();/*=============================================================================
==============================================================================*/

Int		li_ReturnValue = 1
n_cst_msg lnv_msg
s_parm	lstr_parm
n_cst_privileges lnv_Privs
n_cst_privsManager	lnv_privsmanager

lnv_privsManager = gnv_app.of_getPrivsManager()

lstr_Parm.is_Label = "TOPIC"
lstr_Parm.ia_Value = "UNASSIGNED"
lnv_Msg.of_Add_Parm( lstr_Parm ) 

lstr_Parm.is_Label = "PRIV"
lstr_Parm.ia_Value = 1
lnv_Msg.of_Add_Parm( lstr_Parm ) 

/*old code before new privs stuff by dan
IF Dynamic of_CheckConnection ( ) <> 0 THEN
	li_ReturnValue = -1
	MessageBox( "Control Connection" , "Profit Tools could not locate the necessary controls needed to perform this operation.") 
ELSEIF lnv_Privs.of_hasScanningRights ( ) THEN
	OpenSheetWithParm ( w_Imaging, lnv_msg , gnv_App.of_GetFrame ( ), 0, Layered! )
ELSE
	MessageBox( "Scan Batch" , "You do not have the required user rights to perform this operation. Request canceled.",EXCLAMATION! )
END IF
*/

///dans new code
IF Dynamic of_CheckConnection ( ) <> 0 THEN
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
//-----------------


Return li_ReturnValue

RETURN -1
end function

on n_cst_bso_imagemanager.create
call super::create
end on

on n_cst_bso_imagemanager.destroy
call super::destroy
end on

event constructor;call super::constructor;//@(text)(recreate=yes)<init>

//@(text)--

end event

