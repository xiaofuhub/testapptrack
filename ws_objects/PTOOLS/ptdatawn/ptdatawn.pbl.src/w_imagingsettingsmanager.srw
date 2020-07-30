$PBExportHeader$w_imagingsettingsmanager.srw
forward
global type w_imagingsettingsmanager from w_response
end type
type tab_imagingsettingsmanager from u_tab_imagingsettingsmanager within w_imagingsettingsmanager
end type
type tab_imagingsettingsmanager from u_tab_imagingsettingsmanager within w_imagingsettingsmanager
end type
type cb_cancel from u_cbcancel within w_imagingsettingsmanager
end type
type cb_ok from u_cbok within w_imagingsettingsmanager
end type
type cb_apply from commandbutton within w_imagingsettingsmanager
end type
end forward

global type w_imagingsettingsmanager from w_response
integer width = 2112
integer height = 2012
string title = "Imaging Settings Manager"
event ue_apply ( )
event type integer ue_copyimages ( long al_startshipmentid,  long al_endshipmentid,  long al_maxarchivesize )
event type integer ue_deleteimages ( long al_volumenumber )
event type integer ue_recopyimages ( long al_startshipmentid,  long al_endshipmentid,  long al_maxarchivesize,  long al_volnum )
tab_imagingsettingsmanager tab_imagingsettingsmanager
cb_cancel cb_cancel
cb_ok cb_ok
cb_apply cb_apply
end type
global w_imagingsettingsmanager w_imagingsettingsmanager

type variables
Boolean ib_sysadminrights
String is_IsSettingsTabEmpty = 'NO'
String isa_ImagePaths[]

n_cst_beo_ImageType inva_ImageTypes[]

end variables

forward prototypes
public function long wf_getmaxshipmentid ()
public function integer wf_insertrowinimagearchive (long al_volumenumberid, long al_startshipmentid, long al_endshipmentid, integer ai_deletedfromcurrent)
public function integer wf_getimagingrootfolder ()
public function integer wf_refreshhistorytab ()
public function integer wf_populatevolumenumbers ()
public function integer wf_populaterecopyvolnumbers ()
private function integer wf_archivetabpgvalidations (long al_startshipmentid, long al_endshipmentid, long al_maxarchivesize, ref string as_errormessage, ref integer ai_returnvalue)
public function integer wf_setendshipmentid (long al_endshipmentid)
public function integer wf_setstartshipmentid (long al_startshipmentid)
public function integer wf_updatesettingstab ()
public function integer wf_setarchivefolder ()
public function long wf_getmaxarchivesize ()
public subroutine wf_getarchivefolder (ref string as_archivefoldername)
public subroutine wf_gettargetfolder (ref string as_targetfolder)
public subroutine wf_getmaxarchivesettings (ref string as_maxarchivesettings)
public function integer wf_updatehistorytab ()
public function integer wf_refreshtabpages ()
public function integer wf_checkrecopyfolderexists (long al_volnum)
public function integer wf_recopyimages (long al_startshipmentid, long al_endshipmentid, long al_volnum, long al_maxarchivesize)
public function integer wf_setmaxarchivesizeonupdate ()
public function integer wf_flagvolnumasdeleted (long al_volumenumber)
public function integer wf_ifprevvoldeleted (long al_volumenumber)
public function integer wf_isemptytemptargetfolder (string as_temptargetfolder, ref string as_localfolder, ref string as_oritemptargetfolder, ref boolean ab_localfolderfullmessage)
public subroutine wf_makewaitmsginvisible ()
public subroutine wf_makewaitmsgvisible ()
public subroutine wf_makewaitrecopymsgvisible ()
public subroutine wf_makewaitrecopymsginvisible ()
private function integer wf_deleteimages (long al_volumenumber, n_cst_beo_imagetype anva_imagetypes[], string asa_imagepaths[])
public subroutine wf_setcursoronendshipmentid ()
public function boolean wf_settargetfolder ()
public function boolean wf_doessettingstabfoldersexists ()
end prototypes

event ue_apply();/////////////////////////////////////////////////////////
// Event			: ue_apply
// Arguments 	: None
// Returns 	 	: None
// Description : Save modifiable stored fields for archive, settings & history tab pages  
//					  Update the System_settings table.
//					  Update the imagearchive table	
// Author		: ZMC - 2003-10-07
////////////////////////////////////////////////////////

String ls_ErrMsg

n_cst_privileges  lnv_Privileges

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager

IF lnv_Privileges.of_HasSysAdminRights( ) THEN
	IF wf_UpdateSettingsTab() = 1 THEN
		is_IsSettingsTabEmpty = 'NO'
	ELSE
		is_IsSettingsTabEmpty = 'YES'
	END IF	
	
	IF wf_SetMaxArchiveSizeOnUpdate( ) <> 1 THEN
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'MaxArchiveSize on update failed for archive tab.')
	END IF
END IF

IF wf_UpdateHistoryTab() <> 1 THEN 
	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Update failed for history tab.')
End If 

Destroy lnv_ImageManager
end event

event type integer ue_copyimages(long al_startshipmentid, long al_endshipmentid, long al_maxarchivesize);//////////////////////////////////////////////////////////////////////////////
//	Event: 		ue_CopyImages
//
//	Arguments:	None
//
//	Returns:		Integer
//				 1 = success
//				-1 = failure
//
//	Description:	
//		Get starting and ending shipment number for the images to copy and maximum number
//		Validation:
//			ending number is greater than the starting number
//			maximum size has been entered
//			n_cst_bso_imagemanager.of_GetArchiveSize()
//			n_cst_bso_imagemanager.of_CheckSpaceRequirements() -  // Moved this fuctionality to n_cst_bso_imagemanager.of_GetArchiveSize()
//				Maximum number is megabytes and should be multiplied by 1024.
//				If the number returned is not equal to 0 then the return is the last shipment #
// 				that will fit. For example if the user asks to archive Shipment # 50000 to 
//				Shipment #100000	and the maximum is reached at Shipment Id 82168 then
//				round down the ending Shipment # to nearest 100 (82100) and let user know. 
//				They can change the end Shipment # to a lower number than the reported one.
//			n_cst_bso_imagemanager.of_GetTemporaryTargetFolder()
//			n_cst_bso_imagemanager.of_IsTemporaryTargetFolderEmpty()
//
//		Create an array of shipment ids from the range.  
//		Send array, temporary target folder to n_cst_bso_ImageManager.of_CopyAllImages.
//
//		Display messagebox for any failures.  After a successful copy, populate the volume 
//		number field and let the user know that they should note the volume number and 
//		Shipment Id range on the disk for later retrieval.  Insert a row into the ImageArchive
//		table with the startshipment, endshipment, and volume (max id + 1).
//////////////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
Int li_RtnVal
Int li_CalcArchiveSizeRtn

Long ll_Ctr
Long ll_ImageNum
Long ll_startshipmentid
Long ll_endshipmentid
Long ll_maxarchivesize
Long ll_RtndShipmentId
Long ll_maxvolumenumber
Long ll_ShipmentCtr
Long ll_ShipmentCtr1

Double ldbl_TotalArchiveSize
Double ldbl_DestinationArchiveSize

Boolean lb_localfolderfullmessage
Boolean lb_GetTemporaryTargetFolder

String ls_Msg
String ls_Msg1
String ls_ErrorMsg
String ls_ErrMsg
String ls_VolumeNumber
String ls_TemporaryTargetFolder
String ls_Localfolder
String ls_OriTempTargetFolder
String lsa_NewImagePaths[]
String ls_Value
String ls_FileName
String ls_Drive
String ls_DirPath
String ls_File
String ls_Ext

SetPointer(HourGlass!)

wf_MakeWaitMsgVisible( )

ll_StartShipmentId = al_StartShipmentId
ll_EndShipmentId	 =	al_EndShipmentId
ll_MaxArchiveSize  = al_MaxArchiveSize

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager

n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = Create n_cst_bso_ImageManager_Pegasus

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

n_cst_beo_ImageType lnva_ImageTypes[]

// Check to see if settings tab has all valid values.
IF (wf_SetTargetFolder( ) = FALSE OR wf_SetArchiveFolder( ) <> 1 OR wf_GetMaxArchiveSize( ) = 0) THEN
	ls_ErrMsg = "Please enter all values in 'Settings' tab to proceed with copy process."
	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
	is_IsSettingsTabEmpty = 'YES'
	li_ReturnValue = -1 
ELSE	
	is_IsSettingsTabEmpty = 'NO'
END IF

IF li_ReturnValue = 1 THEN
	// Check to see if folders on Settings tab exist.
	IF NOT This.wf_DoesSettingsTabFoldersExists( ) THEN
		li_ReturnValue = -1
		is_IsSettingsTabEmpty = 'YES'
	END IF
END IF

IF li_ReturnValue = 1  THEN
	IF wf_ArchiveTabpgValidations(ll_startshipmentid,ll_endshipmentid,ll_maxarchivesize,ls_ErrorMsg,li_RtnVal) = 1 THEN
	ELSE
		tab_ImagingSettingsManager.of_ArchiveTabpgValidations(ls_ErrorMsg,li_RtnVal)
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue = 1 THEN
	// Arrive at KiloBytes figure for MaxArchiveSize Value
	ldbl_DestinationArchiveSize = ll_MaxArchiveSize * 1024  // Size in KB.
	
	// Calculate the total archive space needed to archive the ShipmentIds
	li_CalcArchiveSizeRtn = lnv_ImageManager.of_CalcArchiveSize(ll_startshipmentid,ll_endshipmentid,ldbl_DestinationArchiveSize, &
									ll_ShipmentCtr,ldbl_TotalArchiveSize,inva_ImageTypes,isa_ImagePaths,ll_ImageNum)
	
	li_ReturnValue = li_CalcArchiveSizeRtn
	
	IF li_ReturnValue = 1 THEN
		IF ldbl_DestinationArchiveSize < ldbl_TotalArchiveSize THEN
			ll_RtndShipmentId	= ll_ShipmentCtr
			IF ll_RtndShipmentId <> ll_EndShipmentId THEN
				IF ll_RtndShipmentId > 0 THEN
					IF ll_RtndShipmentId < ll_StartShipmentId THEN
						ll_EndShipmentId =  ll_StartShipmentId + 1
					ELSE
						ll_EndShipmentId = ll_RtndShipmentId
					END IF
					IF MessageBox(lnv_ImageManager.cs_ErrMsgHeader,"For the Maximum Archive Size of " + &
									String(ll_maxarchivesize) + " MB, Upto " + String(ll_endshipmentid) + &
									" Shipment Ids can be accomodated. Do you wish to copy this shipment id range?",&
										Question!,YesNo!,1) = 1 THEN
						wf_SetEndShipmentId(ll_endshipmentid)
						n_cst_AnyArraySrv lnv_AnyArraySrv
											
						IF UpperBound(isa_ImagePaths) > 0 THEN								 
							lsa_NewImagePaths[] = {""}
							FOR ll_Ctr = 1 TO ll_ImageNum
								ls_Value = isa_ImagePaths[ll_Ctr]
								lnv_FileSrvWin32.of_ParsePath(ls_Value,ls_Drive,ls_DirPath,ls_File,ls_Ext)
								ll_ShipmentCtr1 = Long(ls_File)
								
								IF ll_ShipmentCtr1 > ll_endshipmentid THEN
									EXIT
								ELSE	
									lsa_NewImagePaths[ll_Ctr] =  ls_Value
								END IF
							NEXT
							
							isa_ImagePaths[] = {""}
							isa_ImagePaths = lsa_NewImagePaths
							lnv_AnyArraySrv.of_GetShrinked(isa_ImagePaths, TRUE,TRUE)
						END IF
					ELSE
						li_ReturnValue = -1
					END IF
				ELSE
					li_ReturnValue = -1
				END IF
			END IF
		END IF
		
		IF li_ReturnValue = 1 THEN
			// of_GetTemporaryTargetFolder
			lb_GetTemporaryTargetFolder = lnv_ImageManager.of_GetTemporaryTargetFolder(ls_TemporaryTargetFolder)

			IF lnv_FileSrvWin32.of_DirectoryExists(ls_TemporaryTargetFolder)	THEN
				
				// of_IsTemporaryTargetFolderEmpty
				IF lb_GetTemporaryTargetFolder THEN
					wf_IsEmptyTempTargetFolder(ls_TemporaryTargetFolder,ls_Localfolder,&
									ls_OriTempTargetFolder,lb_LocalFolderFullMessage)
				END IF
						
				// Send temporary target folder, ImageTypes & ImagePaths to n_cst_bso_ImageManager.of_CopyAllImages ()
				IF lnv_ImageManager.of_CopyAllImages(ls_TemporaryTargetFolder,ls_VolumeNumber,inva_ImageTypes,isa_ImagePaths) = 1 THEN
					ll_maxvolumenumber = lnv_ImageManager.of_ExtractVolumeNumber(ls_VolumeNumber)
				
					// Insert a row in ImageArchive table
					IF This.wf_InsertRowInImageArchive(ll_MaxVolumeNumber,ll_StartShipmentId,ll_EndShipmentId,0) = 1 THEN
						IF wf_RefreshTabPages( ) <> 1 THEN					
							li_ReturnValue = -1
							MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Refreshing of tab pages failed.')
						END IF	
					ELSE
						li_ReturnValue = -1
						MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Row insertion in table ImageArchive failed.')
					END IF	
				ELSE
					li_ReturnValue = -1
					MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error Copying Images.')
				END IF
			ELSE
				li_ReturnValue = -1 
				MessageBox(lnv_ImageManager.cs_ErrMsgHeader,"Cannot continue. Invalid Target Folder.")
			END IF	
		END IF	
	
	ELSEIF li_ReturnValue = -2 THEN 
		ll_EndShipmentId = ll_EndShipmentId + 1
		wf_SetStartShipmentId(ll_EndShipmentId)
	ELSEIF li_ReturnValue = -1 THEN 
		wf_SetCursorOnEndShipmentId( )
	END IF	
END IF

IF li_ReturnValue = 1 THEN
	ls_Msg1 = 'Found Folder(s) ' + ls_Localfolder + ' on ' + ls_OriTempTargetFolder + & 
				 ' drive. You may delete or move folder(s) to free space' + '.'
	ls_Msg = 'Copying Successfully Completed. Shipment Id range from ' 
	
	
	IF lb_LocalFolderFullMessage THEN 
		MessageBox("Copying Successfully Completed ",ls_Msg1 + ' ' + ls_Msg + String(ll_StartShipmentId) + & 
					" to " + String(ll_EndShipmentId) + ", Volume Name " + ls_VolumeNumber + '.') 
	ELSE
		MessageBox("Copying Successfully Completed ",ls_Msg + String(ll_StartShipmentId) + & 
					" to " + String(ll_EndShipmentId) + ", Volume Name " + ls_VolumeNumber + '.') 
	END IF
	ll_EndShipmentId = wf_GetMaxShipmentId ( )			
	wf_SetStartShipmentId(ll_EndShipmentId)
END IF

Destroy lnv_ImageManager
DESTROY lnv_FileSrvWin32
Destroy lnv_ImageManager_Pegasus
wf_MakeWaitMsgInvisible( )

Return li_ReturnValue
end event

event type integer ue_deleteimages(long al_volumenumber);/*
/////////////////////////////////////////////////////////////////////////////
//
//	Event:  ue_DeleteImages
//
//	Access:  private
//
//	Arguments:
//
//	Returns:		Integer 
//					1 = Success , 2 = Failure
//					
//
//	Description:	
//		Present the user with a 'Confirm to delete' message.
//		Get the Shipment Id range from the	ImageArchive table for the selected volume. 
//		Create an array of shipment ids.  Pass to n_cst_bso_imagemanager_pegasus.
//		of_GenerateImageList() which will pass out an array of n_cst_beo_image..
//
//		Loop through beos and delete the images using n_cst_beo_image.of_DeleteImage().
//		Use pfc_n_cst_filesrvWin32.of_DelTree to delete the folder name.
//		
//		Note : Even though of_DelTree is a method on pfc_n_cst_filesrv, use pfc_n_cst_filesrvWin32
//				 to delete folder else it will fail to delete the folder. 
//
//		After a successful removal of images, flag the volume as having been removed.   
//		DeletedFromCurrent = 1
//
//////////////////////////////////////////////////////////////////////////////
*/

Int li_Return = 1 
String ls_ErrMsg

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager


// Check to see if settings tab has all valid values.
IF (wf_SetTargetFolder( ) = FALSE OR wf_SetArchiveFolder( ) <> 1 OR wf_GetMaxArchiveSize( ) = 0) THEN
		ls_ErrMsg = "Please enter all values in 'Settings' tab to proceed with delete process."
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
		is_IsSettingsTabEmpty = 'YES'
		li_Return = -1 
ELSE	
	is_IsSettingsTabEmpty = 'NO'	
END IF

IF li_Return = 1 THEN
	// Check to see if folders on Settings tab exist.
	IF NOT This.wf_DoesSettingsTabFoldersExists( ) THEN
		li_Return = -1 
		is_IsSettingsTabEmpty = 'YES'
	END IF
END IF

IF li_Return = 1 THEN
	// Check to see if volume num prior to one being deleted is deleted or not?
	IF wf_IfPrevVolDeleted(al_VolumeNumber) <> 1 THEN
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	IF MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Are you sure you want to delete?',Question!,OKCancel!,2) = 1 THEN
		
		Long ll_StartShipmentId
		Long ll_EndShipmentId
		
		n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
		lnv_ImageManager_Pegasus = CREATE n_cst_bso_ImageManager_Pegasus
		
		n_cst_beo_ImageType inva_ImageTypes1[]
		inva_ImageTypes = inva_ImageTypes1
				
		IF li_Return = 1  THEN 
			n_cst_beo_ImageType lnva_ImageTypes1[]
			inva_ImageTypes = lnva_ImageTypes1
			isa_ImagePaths[] = {""}
			lnv_imagemanager_Pegasus.of_GetImageTypes('SHIPMENT',inva_ImageTypes[]) 
	
			IF lnv_ImageManager.of_getshipmentrangeforvolume(al_VolumeNumber,ll_StartShipmentId,ll_EndShipmentId) = 1 THEN
				IF lnv_imagemanager_pegasus.of_GetImageList &
					(inva_ImageTypes,ll_startshipmentid,ll_Endshipmentid,isa_ImagePaths[]) > 0 THEN
				ELSE
					li_Return = -1 
				END IF	
			ELSE
				li_Return = -1 
			END IF	
			
			DESTROY(lnv_ImageManager)
			DESTROY(lnv_ImageManager_Pegasus)
			
			IF li_Return = 1 THEN
				Return wf_Deleteimages(al_volumenumber, inva_imagetypes, isa_imagepaths)
			ELSE
				MESSAGEBOX(lnv_ImageManager.cs_ErrMsgHeader,"Error Deleteting Images ")
			END IF
		END IF	
	ELSE
		li_Return = -1
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Delete cancelled for volume: ' + String(al_volumenumber))
	END IF	
END IF

Return li_Return
end event

event type integer ue_recopyimages(long al_startshipmentid, long al_endshipmentid, long al_maxarchivesize, long al_volnum);Int li_ReturnValue = 1
Long ll_VolumeNumber 
String ls_VolumeNumber
String ls_ErrMsg

SetPointer(HourGlass!)

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager

// Check to see if settings tab has all valid values.
IF (wf_SetTargetFolder( ) = FALSE OR wf_SetArchiveFolder( ) <> 1 OR wf_GetMaxArchiveSize( ) = 0) THEN
		ls_ErrMsg = "Please enter all values in 'Settings' tab to proceed with recopy process."
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
		is_IsSettingsTabEmpty = 'YES'
		li_ReturnValue = -1 
ELSE	
	is_IsSettingsTabEmpty = 'NO'	
END IF

IF li_ReturnValue = 1 THEN
	// Check to see if folders on Settings tab exist.
	IF NOT This.wf_DoesSettingsTabFoldersExists( ) THEN
		li_ReturnValue = -1 
		is_IsSettingsTabEmpty = 'YES'
	END IF
END IF

IF li_ReturnValue = 1 THEN

	ll_VolumeNumber = al_volnum
	
	ls_VolumeNumber = lnv_ImageManager.cs_VolNumPrefix + String(ll_VolumeNumber)
	
	IF wf_checkrecopyfolderexists(ll_VolumeNumber) = 1 THEN
		wf_Makewaitrecopymsgvisible( )
		IF wf_recopyimages(al_startshipmentid,al_endshipmentid,al_volnum, al_maxarchivesize) <> 1 THEN
			li_ReturnValue = -1
		END IF
	ELSE
		li_ReturnValue = -1			
		MessageBox('Recopying Images','TmpId range from ' + & 
					String(al_startshipmentid) + ' to ' + & 
					String(al_endshipmentid) + ' have already been copied to volume ' + & 
					ls_VolumeNumber + '.')  
	END IF
	
	DESTROY lnv_ImageManager
	
	wf_MakewaitrecopymsgInvisible( )
	
END IF

Return li_ReturnValue
end event

public function long wf_getmaxshipmentid ();/////////////////////////////////////////////////////////
//
// Function	: wf_getmaxshipmentid
// Arguments: None
//
// Returns 		 : Max shipment id (a long value)
// Description  : This fuction is called to get Maxshipmentid which is 
// 					derived as the record having max of volume number in 
//						image archive table and pick up the endshipmentid 
//						increment it by 1
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////
Long ll_ReturnValue = 1
Long ll_RowCount

DataStore lds_imagearchive

IF NOT IsValid(lds_imagearchive) THEN
	lds_imagearchive = Create DataStore
	lds_imagearchive.DataObject = 'd_imagingsettingsmanagerhistory'
	lds_imagearchive.SetTransObject(SQLCA)
END IF

ll_RowCount = lds_imagearchive.Retrieve() 
Commit;
IF ll_RowCount > 0 THEN  
	ll_ReturnValue = lds_imagearchive.Object.EndShipmentId[ll_RowCount]
	ll_ReturnValue += 1
END IF

DESTROY(lds_imagearchive)
RETURN ll_ReturnValue




end function

public function integer wf_insertrowinimagearchive (long al_volumenumberid, long al_startshipmentid, long al_endshipmentid, integer ai_deletedfromcurrent);/////////////////////////////////////////////////////////
//
// Function	: wf_insertrowinimagearchive
// Arguments: al_volumenumberid,long 
//				  al_startshipmentid,long	
//				  al_endshipmentid,long 	
//				  ai_deletedfromcurrent,Integer
// Returns 		 : 1 = Success, -1 = Failure
// Description  : This fuction is called to insert a record in imagearchive table
//						after successfully copying images to a temp target folder.
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Int li_UpdateStatus
Int li_InsertRowStatus
Int li_DeletedFromCurrent

Long ll_VolumeNumberId
Long ll_StartShipmentId
Long ll_EndShipmentId
Long ll_RowCount

DataStore lds_Imagearchive

ll_VolumeNumberId 		= al_volumenumberid
ll_StartShipmentId		= al_startshipmentid
ll_EndShipmentId			= al_endshipmentid
li_DeletedFromCurrent 	= ai_deletedfromcurrent

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager

IF NOT IsValid(lds_imagearchive) THEN
	lds_imagearchive = Create DataStore
	lds_imagearchive.DataObject = 'd_imagingsettingsmanagerhistory'
	lds_Imagearchive.SetTransObject(SQLCA)
END IF

ll_RowCount = lds_Imagearchive.Retrieve()
Commit;

IF ll_RowCount >= 0 THEN 
	li_InsertRowStatus = lds_Imagearchive.InsertRow(0)
	IF li_InsertRowStatus > 0 THEN
		lds_Imagearchive.Object.VolumeNumberId[li_InsertRowStatus] 		= ll_VolumeNumberId
		lds_Imagearchive.Object.StartShipmentId[li_InsertRowStatus]	 	= ll_StartShipmentId
		lds_Imagearchive.Object.EndShipmentId[li_InsertRowStatus] 		= ll_EndShipmentId
		lds_Imagearchive.Object.DeletedFromCurrent[li_InsertRowStatus] = li_DeletedFromCurrent
	ELSE
		li_ReturnValue = -1 
	END IF
	
	IF li_ReturnValue = 1 THEN
		li_UpdateStatus = lds_Imagearchive.Update()
		IF li_UpdateStatus = 1 THEN 
			Commit USING SQLCA;
		ELSE
			ROLLBACK USING SQLCA;
			li_ReturnValue = -1
		END IF
	END IF	
END IF

DESTROY lnv_ImageManager
DESTROY lds_Imagearchive

Return li_ReturnValue
end function

public function integer wf_getimagingrootfolder ();/////////////////////////////////////////////////////////
//
// Function	: wf_getimagingrootfolder
// Arguments: None
//
// Returns 		 : 1 = Success, -1 = Failure
// Description  : This fuction is called to extract information from
// 					systems settings table regarding Imaging root folder
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
String ls_ImagingRootFolder
String ls_ErrMsg1  
String ls_ErrMsg2

ls_ErrMsg1 = 'Imaging root folder path needs to be set up in system settings. ' 
ls_ErrMsg2 = 'Please log in as PTADMIN and set imaging root folder path.' 


n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager

IF lnv_ImageManager.of_GetImagingRootFolder(ls_ImagingRootFolder) = 1 THEN
	tab_imagingsettingsmanager.of_GetImagingRootFolder(ls_ImagingRootFolder)
ELSE
	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg1 + ls_ErrMsg2)
	li_ReturnValue = -1
END IF

DESTROY lnv_ImageManager

Return li_ReturnValue
 


end function

public function integer wf_refreshhistorytab ();Return tab_imagingsettingsmanager.of_refreshhistorytab( )


end function

public function integer wf_populatevolumenumbers ();Int li_ReturnValue = 1
Int li_Ctr

Long ll_RowCount
Long lla_VolumeNum[]

DataStore lds_imagearchive

IF NOT IsValid(lds_imagearchive) THEN
	lds_imagearchive = Create DataStore
	lds_imagearchive.DataObject = 'd_imagingsettingsmanagerhistory'
	lds_imagearchive.SetTransObject(SQLCA)
END IF
ll_RowCount = lds_imagearchive.Retrieve()
Commit;
IF ll_RowCount > 0 THEN
	lds_imagearchive.SetFilter("DeletedFromCurrent <> 1")
	lds_imagearchive.Filter()
	ll_RowCount = lds_imagearchive.RowCount()
	IF ll_RowCount > 0 THEN 
		FOR li_Ctr = 1 TO ll_RowCount
			lla_VolumeNum[li_Ctr] = lds_imagearchive.Object.VolumeNumberId[li_Ctr]
		NEXT 
		tab_imagingsettingsmanager.of_PopulateVolumeNumbers(lla_VolumeNum[])
		tab_imagingsettingsmanager.of_EnaDisVolume(1)	
	ELSE	
		tab_imagingsettingsmanager.of_EnaDisVolume(-1)
		tab_imagingsettingsmanager.of_ResetVolume()
	END IF
ELSE
	tab_imagingsettingsmanager.of_EnaDisVolume(-1)
	tab_imagingsettingsmanager.of_ResetVolume()
END IF	
lds_imagearchive.SetFilter("")
lds_imagearchive.Filter()

Destroy lds_imagearchive

RETURN li_ReturnValue



end function

public function integer wf_populaterecopyvolnumbers ();/////////////////////////////////////////////////////////
//
// Function	: wf_populaterecopyvolnumbers
// Arguments: None
// Returns 		 : 1 = Success, -1 = Failure
// Description  : This fuction is called to the ddlb for  volume numbers in the recopy
//						section of tabpage archive
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////


Int li_ReturnValue = 1
Int li_Ctr

Long ll_RowCount
Long lla_VolumeNum[]

DataStore lds_imagearchive

IF NOT IsValid(lds_imagearchive) THEN
	lds_imagearchive = Create DataStore
	lds_imagearchive.DataObject = 'd_imagingsettingsmanagerhistory'
	lds_imagearchive.SetTransObject(SQLCA)
END IF
ll_RowCount = lds_imagearchive.Retrieve()
Commit;
IF ll_RowCount > 0 THEN
	lds_imagearchive.SetFilter("DeletedFromCurrent <> 1")
	lds_imagearchive.Filter()
	ll_RowCount = lds_imagearchive.RowCount()
	IF ll_RowCount > 0 THEN 
		FOR li_Ctr = 1 TO ll_RowCount
			lla_VolumeNum[li_Ctr] = lds_imagearchive.Object.VolumeNumberId[li_Ctr]
		NEXT 
		tab_imagingsettingsmanager.of_populaterecopyvolume(lla_VolumeNum[]) 
		tab_imagingsettingsmanager.of_PopulateRecopyShipmentIds(lds_imagearchive)
		tab_imagingsettingsmanager.of_EnaDisRecopyVolume(1)
	ELSE
		tab_imagingsettingsmanager.of_EnaDisRecopyVolume(-1)
		tab_imagingsettingsmanager.of_ResetRecopyVolume()
	END IF
ELSE
	tab_imagingsettingsmanager.of_EnaDisRecopyVolume(-1)
	tab_imagingsettingsmanager.of_ResetRecopyVolume()
END IF	

lds_imagearchive.SetFilter("")
lds_imagearchive.Filter()

Destroy lds_imagearchive

RETURN li_ReturnValue



end function

private function integer wf_archivetabpgvalidations (long al_startshipmentid, long al_endshipmentid, long al_maxarchivesize, ref string as_errormessage, ref integer ai_returnvalue);/////////////////////////////////////////////////////////
//
// Function	: wf_archivetabpgvalidations
// Arguments: al_startshipmentid,long 
//				  al_endshipmentid,long	
//				  al_maxarchivesize,long 	
//				  as_errormessage, String	
//				  ai_returnvalue, integer
//
// Returns 		 : 1 = Success, -1, -2 or -3 = Failure
// Description  : This fuction is called as a window function on 
//						w_iamgingsettingsmanager to validate information
//						entered by user on tabpage archive
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Long ll_startshipmentid
Long ll_endshipmentid
Long ll_maxarchivesize

String ls_ErrMsg

ll_startshipmentid	=	al_startshipmentid
ll_endshipmentid		=	al_endshipmentid
ll_maxarchivesize		=	al_maxarchivesize

// Check if Value for Maximum size of archive media is zero or null
IF ISNULL(ll_maxarchivesize) OR ll_maxarchivesize = 0 THEN 
	ls_ErrMsg = 'Blank or zero value not allowed for Maximum Size of Archive Media.'
	li_ReturnValue = -1
END IF		

// Check if Value for endshipmentid is zero or null

IF ll_endshipmentid = 0 THEN
	ls_ErrMsg = 'Blank or zero value not allowed for Shipment #.'
	li_ReturnValue = -2 	
	// Checking if endshipmentnum < startshipmentnum
ELSEIF ll_endshipmentid < ll_startshipmentid THEN
	ls_ErrMsg = 'Number entered is less than Shipment #.'
	li_ReturnValue = -3 	
END IF

as_ErrorMessage = ls_ErrMsg
ai_ReturnValue	 = li_ReturnValue

Return li_ReturnValue
end function

public function integer wf_setendshipmentid (long al_endshipmentid);Return tab_imagingsettingsmanager.of_setendshipmentid(al_endshipmentid)

end function

public function integer wf_setstartshipmentid (long al_startshipmentid);Return tab_imagingsettingsmanager.of_setstartshipmentid(al_startshipmentid)

end function

public function integer wf_updatesettingstab ();Int li_ReturnValue = 1 
String ls_TargetFolder
String ls_ArchiveFolder
String ls_MaxArchiveSize
String ls_ErrMsg

n_cst_Settings lnv_Settings

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager

// Save records for Ss_id in table "system_settings"
// for Ss_id - 153, 154, 155

// Get Target Folder. 
wf_GetTargetFolder(ls_TargetFolder)
ls_TargetFolder = TRIM(ls_TargetFolder)

IF (Not IsNULL(ls_TargetFolder)) AND (Len(ls_TargetFolder) > 0) THEN
	IF NOT lnv_FileSrvWin32.of_DirectoryExists(ls_TargetFolder) THEN
		ls_ErrMsg = ls_ErrMsg + " " + "Target Folder " + ls_TargetFolder + " does not exist."
		li_ReturnValue  = -1 
	END IF
END IF	

IF li_ReturnValue = 1 THEN
	// Update Target Folder
	IF lnv_Settings.of_SetSetting(153,ls_TargetFolder,lnv_Settings.cs_datatype_string) <>  1 THEN 
		li_ReturnValue  = -1 
	END IF
END IF	

IF li_ReturnValue  = 1  THEN
	// Update Target Folder
	IF lnv_Settings.of_savesetting( ) <> 1 THEN 
		li_ReturnValue  = -1 
	END IF
END IF		

// Get Archive Folder
wf_getarchivefolder(ls_ArchiveFolder)
ls_ArchiveFolder = TRIM(ls_ArchiveFolder)

IF (Not IsNULL(ls_ArchiveFolder)) AND (Len(ls_ArchiveFolder) > 0) THEN
	IF NOT lnv_FileSrvWin32.of_DirectoryExists(ls_ArchiveFolder) THEN
		ls_ErrMsg = ls_ErrMsg + " " + "Archive Folder " + ls_ArchiveFolder + " does not exist."
		li_ReturnValue  = -1 
	END IF
END IF
	
IF	li_ReturnValue  = 1 	THEN
	// Update Archive Folder
	IF lnv_Settings.of_SetSetting(154,ls_ArchiveFolder,lnv_Settings.cs_datatype_string) <> 1 THEN 
		li_ReturnValue = -1
	END IF
END IF	

IF li_ReturnValue = 1 THEN 
	// Update Archive Folder	
	IF lnv_Settings.of_savesetting( ) <> 1 THEN 
		li_ReturnValue = -1
	END IF
END IF	

// Get Max Archive Size
wf_getMaxarchiveSettings(ls_MaxArchiveSize)
ls_MaxArchiveSize = TRIM(ls_MaxArchiveSize)

IF Long(ls_MaxArchiveSize) < 0 THEN
	ls_ErrMsg = ls_ErrMsg + " " + "Negative value not allowed in Max Archive Size."
	li_ReturnValue = -1
END IF

IF li_ReturnValue = 1 THEN
	// Update Max Archive Size
	IF lnv_Settings.of_SetSetting(155,ls_MaxArchiveSize,lnv_Settings.cs_datatype_string) <> 1 THEN 
		li_ReturnValue = -1
	END IF	
END IF	

IF li_ReturnValue = 1 THEN
	// Update Max Archive Size	
	IF lnv_Settings.of_savesetting( ) <> 1 THEN
		li_ReturnValue = -1
	END IF
END IF

IF li_ReturnValue <> 1 THEN
	MessageBox(lnv_ImageManager.cs_errmsgheader,ls_ErrMsg) 				
END IF	

Destroy(lnv_FileSrvWin32)
Destroy(lnv_ImageManager)

RETURN li_ReturnValue
end function

public function integer wf_setarchivefolder ();/////////////////////////////////////////////////////////
//
// Function	: wf_setarchivefolder
// Arguments: None
//
// Returns 		 : 1 = Success, -1 = Failure
// Description  : This fuction is called to set archive folder's
// 					value on tabpage settings
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1
String ls_ArchiveFolder

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager

IF (lnv_ImageManager.of_GetArchivefolder(ls_ArchiveFolder)  = 1  AND ls_ArchiveFolder <> '')THEN
	IF tab_imagingsettingsmanager.of_SetArchiveFolder(ls_ArchiveFolder) = 1 THEN
	ELSE
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Value not found for archive folder.')
		li_ReturnValue = -1
	END IF
ELSE
	//	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Value not found for archive folder.')
	li_ReturnValue = -1
END IF

DESTROY lnv_ImageManager

Return li_ReturnValue


 


end function

public function long wf_getmaxarchivesize ();/////////////////////////////////////////////////////////
//
// Function	: wf_getmaxarchivesize
// Arguments: None
//
// Returns 		 : Archive size in MB 
// Description  : This fuction is called to extract information from
// 					systems settings table regarding max archive size
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////
Long ll_ReturnValue
Any la_Value

n_cst_bso_imagemanager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_imagemanager

ll_ReturnValue = lnv_imagemanager.of_GetMaxArchiveSize( )

Destroy lnv_ImageManager

Return ll_ReturnValue
end function

public subroutine wf_getarchivefolder (ref string as_archivefoldername);tab_imagingsettingsmanager.of_getarchivefolder( as_archivefoldername)

end subroutine

public subroutine wf_gettargetfolder (ref string as_targetfolder);tab_imagingsettingsmanager.of_gettargetfolder(as_targetfolder)
end subroutine

public subroutine wf_getmaxarchivesettings (ref string as_maxarchivesettings);tab_imagingsettingsmanager.of_getmaxarchivesettings( as_maxarchivesettings)
end subroutine

public function integer wf_updatehistorytab ();Return tab_imagingsettingsmanager.of_updatehistorytab( )
end function

public function integer wf_refreshtabpages ();/////////////////////////////////////////////////////////
//
// Function	: wf_getimagingrootfolder
// Arguments: None
//
// Returns 		 : 1 = Success, -1 = Failure
// Description  : This fuction is called to refresh history tab page 
// 					and populate the ddlbs on tabpage archive
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1

n_cst_bso_ImageManager 	lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager

IF wf_RefreshHistoryTab	( ) = 1 THEN
	// Populate Volume Number 
	IF  wf_PopulateVolumeNumbers() = 1 THEN
		// Success - Do Nothing
	ELSE
		li_ReturnValue = -1
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error Populating Volume Numbers.')
	END IF
	
	
	// Populate Recopy Volume Number 
	IF li_ReturnValue = 1 THEN 
		IF  wf_PopulateRecopyVolNumbers() = 1 THEN
			// Success - Do Nothing
		ELSE
			li_ReturnValue = -1
			MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error Populating Volume Numbers.')
		END IF
	END IF	
ELSE
	li_ReturnValue = -1
	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Refreshing of history tab failed.')
END IF	

Destroy lnv_ImageManager

Return li_ReturnValue

end function

public function integer wf_checkrecopyfolderexists (long al_volnum);/////////////////////////////////////////////////////////
//
// Function	: wf_checkrecopyfolderexists
// Arguments: al_volnum,long 
//
// Returns 		 : 1 = Success, -1 = Failure
// Description  : This fuction is called to check during recopy 
//						on the target folder whether the files already exist.
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////


Int li_ReturnValue = 1 
Long ll_VolumeNumber
String ls_TempFolder
String ls_PathBuild
String ls_VolumeNumber

ll_VolumeNumber = al_volnum

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager

ls_VolumeNumber = lnv_ImageManager.cs_VolNumPrefix + String(ll_VolumeNumber)

IF lnv_ImageManager.of_GetTemporaryTargetFolder(ls_TempFolder) THEN
	ls_PathBuild = ls_TempFolder + ls_VolumeNumber
	IF lnv_FileSrvWin32.of_DirectoryExists(ls_PathBuild) THEN 
		li_ReturnValue = -1 
	END IF
ELSE	
	li_ReturnValue = - 1
	MessageBox(lnv_ImageManager.cs_errmsgheader,'Temporary target folder could not be located.')
END IF

DESTROY lnv_ImageManager
DESTROY lnv_FileSrvWin32

Return li_ReturnValue

end function

public function integer wf_recopyimages (long al_startshipmentid, long al_endshipmentid, long al_volnum, long al_maxarchivesize);/////////////////////////////////////////////////////////
//
// Function	: 
// Arguments 	: None 
// Returns 	: None
// Description  : Add Description here
// Author	: Add Author Name here
// Created on 	: Add timestamp here
// Modified by 	: Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue  = 1 
Long ll_startshipmentid
Long ll_endshipmentid
Long ll_maxarchivesize
Long ll_volumenumber
Long ll_ShipmentId[]

Long ll_RtndShipmentId

String ls_TemporaryTargetFolder
String ls_VolumeNumber
String	lsa_ImagePaths[]

Boolean lb_GetTemporaryTargetFolder
Boolean lb_IsTemporaryTargetFolderEmpty

SetPointer(HourGlass!)

ll_startshipmentid = al_startshipmentid
ll_endshipmentid	 =	al_endshipmentid
ll_maxarchivesize  = al_maxarchivesize
ll_volumenumber	 = al_volnum

n_cst_beo_ImageType lnva_ImageTypes[]
n_cst_beo_ImageType lnva_ImageTypes1[]

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager

n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = Create n_cst_bso_ImageManager_Pegasus

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32

ls_VolumeNumber = lnv_ImageManager.cs_VolNumPrefix + String(ll_volumenumber)

IF li_ReturnValue = 1 THEN 
	// of_GetTemporaryTargetFolder
	lb_GetTemporaryTargetFolder = lnv_ImageManager.of_GetTemporaryTargetFolder(ls_TemporaryTargetFolder)

	IF lnv_FileSrvWin32.of_directoryexists(ls_TemporaryTargetFolder)	THEN
		// Send array, temporary target folder to n_cst_bso_ImageManager.of_ReCopyAllImages ()
		lsa_ImagePaths[] = {""}
		lnva_ImageTypes = lnva_ImageTypes1
		IF lnv_imagemanager_pegasus.of_GetImageTypes('SHIPMENT',lnva_ImageTypes[]) > 0 THEN
			 lnv_imagemanager_pegasus.of_GetImageList &
				(lnva_ImageTypes[],ll_startshipmentid,ll_endshipmentid,lsa_ImagePaths[])
		END IF
		
		IF UpperBound(lsa_ImagePaths) > 0 THEN 
			IF lnv_ImageManager.of_ReCopyImages(ll_startshipmentid,ll_endshipmentid,ls_TemporaryTargetFolder,ll_volumenumber,lnva_ImageTypes[],lsa_ImagePaths[]) = 1 THEN
				wf_refreshtabpages( )
			ELSE
				li_ReturnValue = -1
				MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error Recopying images.')
			END IF
		ELSE	
			li_ReturnValue = -1
			MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error Recopying images.')
		END IF	
	ELSE
		li_ReturnValue = -1
		MessageBox("Imaging Archive - Target Folder.","Cannot continue. Invalid Target Folder.")
	END IF	
END IF	

IF li_ReturnValue = 1 THEN
	MessageBox('Recopying Successfully Completed ','Recopying Successfully Completed. Shipment Id range from ' + & 
				String(ll_StartShipmentId) + ' to ' + String(ll_EndShipmentId) + & 
				' Volume ' + ls_VolumeNumber + '.')
	ll_EndShipmentId = wf_GetMaxShipmentId ( )			
END IF

DESTROY lnv_ImageManager
DESTROY lnv_FileSrvWin32
Destroy lnv_ImageManager_Pegasus

Return li_ReturnValue
end function

public function integer wf_setmaxarchivesizeonupdate ();Long ll_Maxarchivesize
n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager  = CREATE n_cst_bso_ImageManager

ll_Maxarchivesize = lnv_ImageManager.of_Getmaxarchivesize( )
DESTROY lnv_ImageManager
Return tab_imagingsettingsmanager.of_Setmaxarchivesizeonupdate(ll_Maxarchivesize)




end function

public function integer wf_flagvolnumasdeleted (long al_volumenumber);/* ////////////////////////////////////////////////////////

	Function		: wf_flagvolnumasdeleted
	Arguments 	: al_volumenumber, Long
	Returns 		: 1 = Success, -1 Failure
	Description : Flags a volume number in ImageArchive table as "deleted from current = 1" for "yes" 
	Author		: ZMC
	Created on 	: 10-31-03
	Modified by : Add Author here	TimeStamp
				
//////////////////////////////////////////////////////// */


Int li_ReturnValue = 1 
Int li_RowFound
Long ll_RowCount
Long ll_VolumeNumber

ll_VolumeNumber = al_VolumeNumber

DataStore lds_ImageArchive

n_cst_bso_ImageManager lnv_ImageManager

lnv_ImageManager = Create n_cst_bso_ImageManager

IF Not IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DataStore
	lds_ImageArchive.DataObject = 'd_imagingsettingsmanagerhistory'
	lds_ImageArchive.SetTransObject(SQLCA)
END IF	

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;

IF ll_RowCount > 0 THEN
	li_RowFound = lds_ImageArchive.Find("VolumeNumberId = " + String(ll_VolumeNumber),1,ll_RowCount)
	IF li_RowFound = 0 THEN
		li_ReturnValue = -1
	END IF
	
	IF li_ReturnValue = 1 THEN
		lds_ImageArchive.Object.DeletedFromCurrent[li_RowFound] = 1
		IF lds_ImageArchive.Update() = 1 THEN
			Commit Using SQLCA;
		ELSE
			RollBack Using SQLCA;
			li_ReturnValue = -1 
			MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Updation for table imagearchive failed.')				
		END IF
	END IF
END IF
Destroy lnv_ImageManager
Return li_ReturnValue


end function

public function integer wf_ifprevvoldeleted (long al_volumenumber);/* ////////////////////////////////////////////////////////
 
   Function		: wf_IfPrevVolDeleted 
   Arguments 	: al_volumenumber
   Returns 		: 1 = Success, -1 Failure
   Description : Checks to see if the immediate previous volume number has been deleted 
					  for the current volume number the user is trying to delete
   Author		: ZMC
   Created on 	: 10-31-03
   Modified by : Add Author here	TimeStamp
				
///////////////////////////////////////////////////////// */

Int li_ReturnValue = 1 
Int li_RowFound

Long ll_RowCount
Long ll_VolumeNumber
Long ll_VolNumToDelete

ll_VolumeNumber = al_volumenumber

DataStore lds_ImageArchive

IF Not IsValid(lds_ImageArchive) THEN 
	lds_ImageArchive = CREATE DATASTORE
	lds_ImageArchive.DataObject = 'd_ImagingSettingsManagerHistory'
	lds_ImageArchive.SetTransObject(SQLCA)
END IF	

lds_ImageArchive.SetFilter("DeletedFromCurrent = 0")
lds_ImageArchive.Filter()

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;
IF ll_RowCount > 0 THEN 
	ll_VolNumToDelete = lds_ImageArchive.Object.VolumeNumberId[1]
END IF

IF ll_VolNumToDelete > 0 THEN 
	IF ll_VolNumToDelete <> ll_VolumeNumber THEN
		li_ReturnValue = -1
		MessageBox('Cannot Delete Volume','Please delete volume ' + & 
			String(ll_VolNumToDelete) + ' before deleting volume ' + String(ll_VolumeNumber) + '.')
	END IF
ELSE
	li_ReturnValue = -1 
END IF	

Return li_ReturnValue
end function

public function integer wf_isemptytemptargetfolder (string as_temptargetfolder, ref string as_localfolder, ref string as_oritemptargetfolder, ref boolean ab_localfolderfullmessage);/////////////////////////////////////////////////////////
//
// Function	: wf_emptytemptargetfolder
// Arguments: as_temptargetfolder,String
//				  as_localfolder, string (reference)
//				  as_oritemptargetfolder string (reference)	
// Returns 		 : 1 = Success, -1 = Failure
// Description  : This fuction is called to notify the user to clear his
// 					temporary target folder to make space
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Int li_ReturnValue = 1 
Int li_Ctr 

Long ll_RowCount
Long ll_VolumeNumber
Long ll_UpperBound

Boolean lb_localfolderfullmessage

String ls_Localfolder
String ls_Folder[]
String ls_TempTargetFolder
String ls_OriTempTargetFolder
String ls_VolumeNumber

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager

ls_TempTargetFolder = as_temptargetfolder
ls_OriTempTargetFolder =  as_temptargetfolder

DataStore lds_ImageArchive

IF Not IsValid(lds_ImageArchive) THEN
	lds_ImageArchive = CREATE DataStore
	lds_ImageArchive.DataObject = 'd_imagingsettingsmanagerhistory'
END IF
lds_ImageArchive.SetTransObject(SQLCA)

ll_RowCount = lds_ImageArchive.Retrieve()
Commit;
IF ll_RowCount > 0 THEN
	FOR li_Ctr = 1 TO ll_RowCount
		ll_VolumeNumber = lds_ImageArchive.Object.VolumeNumberID[li_Ctr] 
		ls_VolumeNumber = lnv_ImageManager.cs_VolNumPrefix + String(ll_VolumeNumber)
		ls_TempTargetFolder = ls_OriTempTargetFolder + ls_VolumeNumber
		IF Not lnv_ImageManager.of_IsTemporaryTargetFolderEmpty(ls_TempTargetFolder) THEN 
			ls_Folder[li_Ctr] = ls_VolumeNumber
		END IF
	NEXT
	ll_UpperBound = UpperBound(ls_Folder[])
	IF ll_UpperBound > 0 THEN
		FOR li_Ctr = 1 TO ll_UpperBound
			ls_Localfolder = ls_Localfolder +  ls_Folder[li_Ctr] + ','
		NEXT
		ls_Localfolder = Left(ls_Localfolder,(Len(ls_Localfolder) - 1))
		// Conveying to the user that the current folder structure on their 
		// local drive is not empty and they need to either delete or move it
		lb_localfolderfullmessage = TRUE
		/*
		MessageBox('Local Folder(s) Status warning',' Found Folder(s) ' + ls_Localfolder + & 
						' on ' + ls_OriTempTargetFolder + & 
						' drive. You may delete or move folder(s) to free space' + '.')
						*/
	END IF
END IF

as_localfolder = ls_Localfolder
as_oritemptargetfolder = ls_OriTempTargetFolder
ab_localfolderfullmessage = lb_localfolderfullmessage

DESTROY lnv_ImageManager
DESTROY lds_ImageArchive

Return li_ReturnValue
end function

public subroutine wf_makewaitmsginvisible ();tab_imagingsettingsmanager.of_Makewaitmsginvisible( )
end subroutine

public subroutine wf_makewaitmsgvisible ();tab_imagingsettingsmanager.of_Makewaitmsgvisible( )
end subroutine

public subroutine wf_makewaitrecopymsgvisible ();tab_imagingsettingsmanager.of_Makewaitrecopymsgvisible( )
end subroutine

public subroutine wf_makewaitrecopymsginvisible ();tab_imagingsettingsmanager.of_Makewaitrecopymsginvisible( )
end subroutine

private function integer wf_deleteimages (long al_volumenumber, n_cst_beo_imagetype anva_imagetypes[], string asa_imagepaths[]);//////////////////////////////////////////////////////////////////////////////
//
//	Method: wf_deleteimages // Called by Event ue_DeleteImages
//
//	Access:  private
//
//	Arguments:
//
//	Returns:		Integer 
//					1 = Success , 2 = Failure
//					
//
//	Description:	
//		Present the user with a 'Confirm to delete' message.
//		Get the Shipment Id range from the	ImageArchive table for the selected volume. 
//		Create an array of shipment ids.  Pass to n_cst_bso_imagemanager_pegasus.
//		of_GenerateImageList() which will pass out an array of n_cst_beo_image..
//
//		Loop through beos and delete the images using n_cst_beo_image.of_DeleteImage().
//		Use pfc_n_cst_filesrvWin32.of_DelTree to delete the folder name.
//		
//		Note : Even though of_DelTree is a method on pfc_n_cst_filesrv, use pfc_n_cst_filesrvWin32
//				 to delete folder else it will fail to delete the folder. 
//
//		After a successful removal of images, flag the volume as having been removed.   
//		DeletedFromCurrent = 1
//
//////////////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1
Int li_Ctr
Int li_Pos
Int li_UpperBound

Long ll_VolumeNumber
Long ll_StartShipmentId
Long ll_EndShipmentId
Long lla_ShipmentId[]

String ls_FolderName
String lsa_ImagePath[]

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_bso_ImageManager

n_cst_bso_ImageManager_Pegasus lnv_imagemanager_Pegasus
lnv_imagemanager_Pegasus = CREATE n_cst_bso_ImageManager_Pegasus

pfc_n_cst_filesrvwin32 lnv_filesrvwin32
lnv_filesrvwin32 = CREATE pfc_n_cst_filesrvwin32 

n_cst_beo_ImageType lnva_ImageTypes[]

n_cst_beo_image lnva_images[]
n_cst_beo_image lnva_CurrentImage

ll_VolumeNumber = al_volumenumber
lsa_ImagePath	 = asa_imagepaths
lnva_ImageTypes = anva_ImageTypes

IF li_ReturnValue = 1 THEN
	IF lnv_ImageManager.of_getshipmentrangeforvolume(ll_VolumeNumber,ll_StartShipmentId,ll_EndShipmentId) = 1 THEN
		li_UpperBound =  lnv_ImageManager.of_GenerateArchiveImageList & 										 
								(ll_StartShipmentId,ll_EndShipmentId,anva_ImageTypes,lnva_images[],lsa_ImagePath[]) 
								
		IF li_UpperBound > 0 THEN 					
			// Delete Image(s)
			FOR li_Ctr = 1 TO li_UpperBound
				lnva_CurrentImage = lnva_images[li_Ctr]
				IF lnva_CurrentImage.of_DeleteImage() = 1 THEN
					Continue
				ELSE
					li_ReturnValue = -1 
					MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error while deleting image.')
					EXIT			
				END IF	
			NEXT
		ELSE
			li_returnValue = -1 
		END IF
		// Delete Folder name too
		IF li_ReturnValue = 1 THEN
			li_UpperBound = UpperBound(lsa_ImagePath[])
			FOR li_Ctr = 1 TO li_UpperBound
				ls_FolderName  = lsa_ImagePath[li_Ctr]
				ls_FolderName  = Reverse(lsa_ImagePath[li_Ctr])
				li_Pos 			= Pos(ls_FolderName,'\')
				IF li_Pos > 0 THEN
					ls_FolderName  = Mid(ls_FolderName ,li_Pos)
					ls_FolderName	= Reverse(ls_FolderName)
				END IF
				IF lnv_filesrvwin32.of_DelTree(ls_FolderName) = 1 THEN
					Continue
				ELSE
					li_ReturnValue = -1
					MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error while deleting folder ' + ls_FolderName + '.')
					EXIT
				END IF
			NEXT
		END IF
	ELSE
		li_returnValue = -1
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error finding images types.')
	END IF
ELSE
	li_ReturnValue = -1
	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Error creating array for range between ' + &
					String(ll_StartShipmentId) + ' and ' + String(ll_EndShipmentId) + '.')
END IF	

IF li_ReturnValue = 1 THEN // If image(s) are deleted successfully
	// Flag the volume as have been removed from ImageArchive table.
	IF wf_FlagVolNumAsDeleted(ll_VolumeNumber) <> 1 THEN 
		li_ReturnValue = -1 
	END IF	
END IF

// Refresh history tab & Volume Numbers on Archive tab.
IF li_ReturnValue = 1 THEN // If Volume is flagged off as removed then  
	// Refresh History tab and populate volume numbers
	IF wf_refreshtabpages() = 1 THEN 
	ELSE
		li_ReturnValue = -1
	END IF	
END IF

DESTROY lnv_ImageManager 
DESTROY lnv_imagemanager_Pegasus
DESTROY lnv_filesrvwin32

IF li_ReturnValue  = 1 THEN
	IF wf_refreshtabpages() = 1 THEN 
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Images deleted sucessfully for TmpId range from ' + & 
		String(ll_StartShipmentId) + ' to ' + String(ll_EndShipmentId) + '.')
	ELSE
		li_ReturnValue	= -1 	
		MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Refresh Unsuccessful.')
	END IF
END IF	

Return li_ReturnValue 

end function

public subroutine wf_setcursoronendshipmentid ();tab_imagingsettingsmanager.of_SetCursoronendshipmentid( )
end subroutine

public function boolean wf_settargetfolder ();/////////////////////////////////////////////////////////
//
// Function	: wf_getimagingrootfolder
// Arguments: None
//
// Returns 		 : True = Success, False = Failure
// Description  : This fuction is called to set target folder's
// 					value on tabpage settings
// Author	    : ZMC
// Created on 	 : 10-13-2003
// Modified by  : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////

Boolean lb_ReturnValue = TRUE
String ls_TargetFolder

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager

IF lnv_ImageManager.of_Gettemporarytargetfolder(ls_TargetFolder)  AND ls_TargetFolder <> '' THEN
	tab_imagingsettingsmanager.of_Gettemporarytargetfolder(ls_TargetFolder)
ELSE
	//MessageBox(lnv_ImageManager.cs_ErrMsgHeader,'Value not found for target folder.')
	lb_ReturnValue = False
END IF

DESTROY lnv_ImageManager

Return lb_ReturnValue


 


end function

public function boolean wf_doessettingstabfoldersexists ();Boolean lb_RtnVal = TRUE
String ls_TargetFolder
String ls_ArchiveFolder
String ls_ErrMsg

n_cst_Bso_ImageManager lnv_ImageManager
lnv_ImageManager = CREATE n_cst_Bso_ImageManager

pfc_n_cst_FileSrvWin32 lnv_FileSrvWin32
lnv_FileSrvWin32 = CREATE pfc_n_cst_FileSrvWin32


lnv_ImageManager.of_Gettemporarytargetfolder(ls_TargetFolder)
lnv_ImageManager.of_GetArchivefolder(ls_ArchiveFolder)

// Check if the Target folder in settings tab exists.
IF NOT lnv_FileSrvWin32.of_Directoryexists(ls_TargetFolder) THEN
	ls_ErrMsg = "Please check if Target Folder " + ls_TargetFolder + " on Settings tab exist."
	lb_RtnVal = FALSE
END IF	
		
// Check if the Archive folder in settings tab exists.		
IF NOT lnv_FileSrvWin32.of_Directoryexists(ls_ArchiveFolder) THEN
	ls_ErrMsg = ls_ErrMsg + " " + "Please check if Archive Folder " + ls_ArchiveFolder + " on Settings tab exist."
	lb_RtnVal = FALSE
END IF

IF Not lb_RtnVal THEN
	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
END IF

DESTROY(lnv_ImageManager)
DESTROY(lnv_FileSrvWin32)

Return lb_RtnVal
end function

on w_imagingsettingsmanager.create
int iCurrent
call super::create
this.tab_imagingsettingsmanager=create tab_imagingsettingsmanager
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_apply=create cb_apply
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_imagingsettingsmanager
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_apply
end on

on w_imagingsettingsmanager.destroy
call super::destroy
destroy(this.tab_imagingsettingsmanager)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_apply)
end on

event open;call super::open;Int li_ReturnValue = 1 
String ls_ErrMsg1

n_cst_privileges lnv_Privileges

IF lnv_Privileges.of_HasSysAdminRights( ) THEN
	ib_SysAdminRights = TRUE
ELSE
	ib_SysAdminRights = FALSE
END IF

// Display the window on top left
This.X = 10
This.Y = 10
			
IF wf_GetImagingRootFolder	( ) <> 1 THEN
	li_ReturnValue = -1 
END IF

IF li_ReturnValue = 1 THEN 
	IF (wf_SetTargetFolder( ) = FALSE OR wf_SetArchiveFolder( ) 	<> 1 OR wf_GetMaxArchiveSize( ) = 0) & 
				AND ib_SysAdminRights = FALSE THEN
		ls_ErrMsg1 = "Please log in as 'PTADMIN' and enter values in settings tab to use Imaging Archive" 			
		MessageBox('Imaging Archive Settings',ls_ErrMsg1)									
		li_ReturnValue = -1 
	ELSEIF (wf_SetTargetFolder( ) = FALSE OR wf_SetArchiveFolder( ) 	<> 1 OR wf_GetMaxArchiveSize( ) = 0) & 
				AND ib_SysAdminRights = TRUE THEN
		ls_ErrMsg1 = "Enter values in settings tab to use Imaging Archive" 			
		MessageBox('Imaging Archive Settings',ls_ErrMsg1)									
	END IF
	is_IsSettingsTabEmpty = 'YES'
ELSE
	Close(This)
END IF
	
IF li_ReturnValue = 1 THEN
	wf_GetMaxShipmentId( )
	wf_RefreshHistoryTab			( )
	wf_PopulateVolumeNumbers	( )
	wf_PopulateRecopyVolNumbers( )
ELSE
	Close(This)
END IF
end event

event pfc_postopen;call super::pfc_postopen;IF ib_SysAdminRights THEN
	tab_ImagingSettingsManager.SelectTab(2)
END IF
end event

type cb_help from w_response`cb_help within w_imagingsettingsmanager
end type

type tab_imagingsettingsmanager from u_tab_imagingsettingsmanager within w_imagingsettingsmanager
integer x = 32
integer y = 36
integer width = 2016
integer height = 1600
integer taborder = 10
end type

event ue_copyimages;call super::ue_copyimages;Parent.Event ue_CopyImages (al_startshipmentid,al_endshipmentid,al_maxarchivesize )
end event

event ue_getmaxshipmentid;call super::ue_getmaxshipmentid;RETURN PARENT.wf_GetMaxShipmentId ( )

end event

event ue_getmaxarchivesize;call super::ue_getmaxarchivesize;Return Parent.wf_Getmaxarchivesize( )
end event

event ue_populatetab;call super::ue_populatetab;//Return Parent.wf_populatehistorytab( )
end event

event ue_refreshhistorytab;call super::ue_refreshhistorytab;Return PARENT.wf_refreshhistorytab( )
end event

event ue_recopyimages;call super::ue_recopyimages;Parent.Event ue_RecopyImages(al_startshipmentid,al_endshipmentid,al_maxarchivesize,al_volnum)
end event

event ue_deleteimages;call super::ue_deleteimages;Parent.Event ue_DeleteImages(al_volumenumber)
end event

event ue_getarchivefolder;call super::ue_getarchivefolder;Parent.wf_getarchivefolder(as_archivefolder)
end event

type cb_cancel from u_cbcancel within w_imagingsettingsmanager
integer x = 1513
integer y = 1724
integer width = 233
integer taborder = 30
integer weight = 400
end type

event clicked;call super::clicked;Close(Parent)
end event

type cb_ok from u_cbok within w_imagingsettingsmanager
integer x = 1211
integer y = 1724
integer width = 233
integer taborder = 20
integer weight = 400
fontcharset fontcharset = ansi!
string text = "Ok"
end type

event clicked;call super::clicked;Parent.Event ue_apply()
Parent.Event CloseQuery()
ib_disableclosequery = TRUE 

IF is_IsSettingsTabEmpty = 'NO' THEN
	Close(Parent)
END IF

	

end event

type cb_apply from commandbutton within w_imagingsettingsmanager
integer x = 1815
integer y = 1724
integer width = 233
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Apply"
end type

event clicked;Parent.Event ue_apply()
end event

