$PBExportHeader$w_imaging.srw
forward
global type w_imaging from w_sheet
end type
type pb_rotate180 from picturebutton within w_imaging
end type
type pb_rotateright from picturebutton within w_imaging
end type
type pb_rotateleft from picturebutton within w_imaging
end type
type cb_deletepage from u_cb within w_imaging
end type
type cb_print from u_cb within w_imaging
end type
type cb_scan from u_cb within w_imaging
end type
type cb_rotate from u_cb within w_imaging
end type
type gb_1 from u_gb within w_imaging
end type
type st_pageno from u_st within w_imaging
end type
type st_5 from u_st within w_imaging
end type
type cb_prevpage from u_cb within w_imaging
end type
type cb_nextpage from u_cb within w_imaging
end type
type sle_rotate from u_sle within w_imaging
end type
type st_2 from u_st within w_imaging
end type
type cb_barcode from u_cb within w_imaging
end type
type ddlb_topic from u_ddlb within w_imaging
end type
type cb_delete from u_cb within w_imaging
end type
type hsb_zoom from u_hsb within w_imaging
end type
type st_3 from u_st within w_imaging
end type
type st_4 from u_st within w_imaging
end type
type cb_1 from u_cb within w_imaging
end type
type cb_2 from commandbutton within w_imaging
end type
type cbx_showexternal from checkbox within w_imaging
end type
type mle_clipboard from u_mle within w_imaging
end type
type st_clipboard from u_st within w_imaging
end type
type pb_arrow from picturebutton within w_imaging
end type
type pb_zoomin from picturebutton within w_imaging
end type
type pb_zoomout from picturebutton within w_imaging
end type
type pb_zoomselected from picturebutton within w_imaging
end type
type pb_grab from picturebutton within w_imaging
end type
type gb_menu from groupbox within w_imaging
end type
type pb_zoombestfit from picturebutton within w_imaging
end type
type ole_image7 from olecustomcontrol within w_imaging
end type
type ole_scan from olecustomcontrol within w_imaging
end type
type ole_barcode from olecontrol within w_imaging
end type
type ole_print from olecustomcontrol within w_imaging
end type
type ole_image4 from olecustomcontrol within w_imaging
end type
type dw_1 from u_dw_imagelist within w_imaging
end type
type dw_imagelist from u_dw_imagelist within w_imaging
end type
type gb_3 from u_gb within w_imaging
end type
end forward

global type w_imaging from w_sheet
integer x = 37
integer y = 124
integer width = 3552
integer height = 2060
string menuname = "m_sheets"
boolean minbox = false
long backcolor = 12632256
event ue_deletecurrentpage ( )
pb_rotate180 pb_rotate180
pb_rotateright pb_rotateright
pb_rotateleft pb_rotateleft
cb_deletepage cb_deletepage
cb_print cb_print
cb_scan cb_scan
cb_rotate cb_rotate
gb_1 gb_1
st_pageno st_pageno
st_5 st_5
cb_prevpage cb_prevpage
cb_nextpage cb_nextpage
sle_rotate sle_rotate
st_2 st_2
cb_barcode cb_barcode
ddlb_topic ddlb_topic
cb_delete cb_delete
hsb_zoom hsb_zoom
st_3 st_3
st_4 st_4
cb_1 cb_1
cb_2 cb_2
cbx_showexternal cbx_showexternal
mle_clipboard mle_clipboard
st_clipboard st_clipboard
pb_arrow pb_arrow
pb_zoomin pb_zoomin
pb_zoomout pb_zoomout
pb_zoomselected pb_zoomselected
pb_grab pb_grab
gb_menu gb_menu
pb_zoombestfit pb_zoombestfit
ole_image7 ole_image7
ole_scan ole_scan
ole_barcode ole_barcode
ole_print ole_print
ole_image4 ole_image4
dw_1 dw_1
dw_imagelist dw_imagelist
gb_3 gb_3
end type
global w_imaging w_imaging

type variables
Public:
n_cst_msg   	inv_msg
n_cst_beo_Image	inv_Image

Int		ii_CurrentPageNo = 1
Int		ii_TotalPages

Boolean ib_ProcessRowChange = TRUE

Private:
Long		il_MaxWidth
Long  	il_MaxHeight

Long		il_ActiveID
String	is_Topic
Long 		ila_ImageID[]
String	is_Context
Boolean	ib_FullSize = TRUE

CONSTANT INT	ic_FullX = 3653
CONSTANT INT	ic_HalfX = 2000 


CONSTANT INT	ic_BarcodeTO = 0
CONSTANT INT	ic_DeletePageTO = 30
CONSTANT INT	ic_DeleteTO = 40
CONSTANT INT   ic_ScanTO = 50






end variables

forward prototypes
public function oleObject wf_getprintobject ()
public function long wf_getimageid ()
public function integer wf_displayimage (n_cst_beo_image anv_image)
public function integer wf_displayimage (n_cst_beo_image anv_image, integer ai_pageno)
public function n_cst_beo_Image wf_getimage ()
public function integer wf_setimage (n_cst_beo_image anv_image)
public function integer wf_viewnext ()
public function integer wf_setcurrentpage (integer ai_PageNo)
public function integer wf_getcurrentpage ()
public function integer wf_settotalpages (integer ai_numpages)
public function integer wf_gettotalpages ()
public function integer wf_viewprev ()
private function integer wf_settopic (string as_topic)
private function String wf_gettopic ()
public function integer wf_changewindowcontext (integer ai_context)
public function integer wf_setimageid (long al_imageid[])
public function integer wf_getidarray (ref long ala_IDarray[])
public function integer wf_setmessage (n_cst_msg anv_msgObject)
public function n_cst_msg wf_getmessage ()
public function integer of_settitle (String as_Title)
public function integer wf_resetwindow ()
public function string wf_getcontext ()
public function integer wf_setactiveid (long al_id)
private function integer wf_changesize ()
public function boolean wf_hasunknown ()
public function boolean wf_hasnotype ()
public subroutine wf_disablewincontrols ()
public subroutine wf_enablewincontrols ()
public function oleobject wf_getimagingcontrol ()
public function integer wf_deleteimage ()
public function integer wf_setbcm (n_cst_bcm anv_bcm)
public function integer wf_viewunassigned ()
public function integer wf_savechanges ()
private function integer wf_savemenusettings (long al_topmenuid, long al_submenuid)
public function integer wf_applysavedmenusettings ()
private function integer wf_syncdatawindows ()
public function integer wf_checkprivs ()
public function boolean wf_haspermission (string as_function)
end prototypes

event ue_deletecurrentpage();Boolean	lb_Delete
String	ls_File
int		li_PageNumber
String	ls_descript
n_cst_beo_image lnv_image

lnv_image = THIS.wf_GetImage ( )
IF isValid( lnv_image ) THEN
	lb_Delete = MessageBox ( "Delete Page" , "Do you want to delete the current page of this image?" , QUESTION! , YESNO! , 2 ) = 1
	
	
	IF lb_Delete THEN
		li_PageNumber = wf_getcurrentpage( )
		
		ls_File = lnv_image.of_getFilepath( )
		
		IF li_pagenumber > 0 AND Len ( ls_File ) > 0 THEN
			
			IF li_PageNumber = 1 and THIS.wf_gettotalpages( ) = 1 THEN
				THIS.wf_deleteimage( )
				//dw_Imagelist.SetRow ( dw_1.GetRow ( ) ) 
			ELSE
			
				THIS.wf_getimagingcontrol( ).DeletePage( ls_File , li_pagenumber )
				IF THIS.wf_getimagingcontrol( ).ImagError = 0 THEN
					THIS.wf_getimagingcontrol( ).CompactFile ( ls_File, ls_File )
					IF li_PageNumber = THIS.wf_gettotalpages( ) THEN
						li_PageNumber --
					END IF
					//added by dan to log the deletion of pages
					ls_descript = "("+lnv_image.of_gettype( ) + ") Image id: "+ string( lnv_image.of_getid( ) )+" page "+string(li_pageNumber)+ " deleted."
					lnv_image.of_updatemodlog( ls_descript )
					//------------------------------------------
					THIS.wf_Displayimage( THIS.wf_GetImage ( ) ,  li_PageNumber )
					
				ELSE
					MessageBox ( "Delete Page" , "An error occurred while attempting to delete page " + String ( li_PageNumber ) + "." )
				END IF
			END IF
		END IF
		
	END IF
END IF
end event

public function oleObject wf_getprintobject ();Return ole_print.object
end function

public function long wf_getimageid ();Long		ll_ID 


//IF isValid ( inv_image ) AND Not isNull ( inv_Image )THEN
//	ll_ID = 	inv_image.of_GetID ( )
//ELSE
//	ll_ID = 0
//END IF

Return il_activeid
end function

public function integer wf_displayimage (n_cst_beo_image anv_image);


Return wf_DisplayImage ( anv_image , 1 )
end function

public function integer wf_displayimage (n_cst_beo_image anv_image, integer ai_pageno);
Int		li_DisplayPage 
Int		li_NumberPages
String	ls_Topic
Long		ll_ID
String	ls_Title
string	ls_FilePath 

n_cst_beo_Image lnv_Image
n_cst_setting_imagezoomtofit	lnv_setting
String	ls_value

lnv_setting = create n_cst_setting_imagezoomtofit




//hsb_zoom.Position = 100
//hsb_zoom.Event Moved ( hsb_zoom.Position )

IF Not isNull ( anv_image ) THEN
	IF isValid ( anv_Image ) THEN
		li_DisplayPage = ai_pageno
		wf_SetCurrentPage ( ai_Pageno )
		
		lnv_image = anv_Image
		wf_SetActiveID ( lnv_Image.of_GetID ( ) )

		ls_FilePath = lnv_Image.of_GetFilePath ( ) 
		
		IF ls_FilePath <> "" THEN
			
			IF lnv_Image.of_CalcPages ( THIS.wf_getimagingcontrol( ) ) < 0 THEN
				MessageBox( "Display Image" , "An error occurred while attempting to display an image." )
			ELSE
				li_NumberPages = lnv_Image.of_GetNumberPages (  )
				
				wf_SetImage ( anv_image )
				
				THIS.wf_getimagingcontrol( ).PageNbr = li_DisplayPage
				
				THIS.wf_getimagingcontrol( ).FileName = ls_filePath
				
			
				ls_Topic = lnv_Image.of_GetTopic ( )
				ll_id = lnv_image.of_GetID ( )
				
				ls_Title = ls_Topic 
				
				IF ll_id <> 0 THEN
					ls_Title += " No. " + String ( ll_ID )
				END IF	
					
				
				THIS.Title = ls_Title
				
				st_pageno.text = string ( li_DisplayPage ) + " of " + string (li_NumberPages )
				
			END IF
		END IF
	END IF
END IF

IF ole_image7.Visible  THEN// can only be true if they have v7

	ls_value = lnv_setting.of_GetValue()
	IF ls_value = lnv_setting.cs_yes THEN
		ole_image7.object.ZoomToFit ( 2 )
	END IF
END IF

DESTROY lnv_setting
Return 1
end function

public function n_cst_beo_Image wf_getimage ();Return inv_image
end function

public function integer wf_setimage (n_cst_beo_image anv_image);Int		li_NumPages
Int		li_ReturnValue 
Long 		ll_Shipmentid
String	ls_FilePath

IF Not(  isValid ( anv_Image )  ) THEN
	li_ReturnValue = -1
ELSE
	li_NumPages = anv_image.of_GetNumberPages ( )
		
	wf_SetTotalPages( li_NumPages )
	inv_image = anv_Image
	li_ReturnValue = 1	
END IF

// ZMC - 1-13-04
IF li_ReturnValue = 1 THEN
	n_cst_bso_ImageManager lnv_ImageManager
	lnv_ImageManager= CREATE n_cst_bso_ImageManager
	IF lnv_ImageManager.of_HasImageBeenCopiedToArchive(anv_Image) THEN
		wf_DisableWinControls( )
		Messagebox('Imaging Archive','Cannot modify this image because it has been copied to be archived.')								
	ELSE
		wf_enablewincontrols( )
	END IF
	DESTROY(lnv_ImageManager)
END IF

Return  li_ReturnValue
end function

public function integer wf_viewnext ();Int 	li_CurrentPageNo
li_CurrentPageNo = wf_GetCurrentPage ( ) 

if li_currentPageNo + 1 <= wf_GetTotalPages( )  THEN
	wf_DisplayImage ( wf_GetImage() , li_currentPageNo + 1 )
	wf_SetCurrentPage ( li_CurrentPageNo + 1 )
END IF
 

RETURN 1
end function

public function integer wf_setcurrentpage (integer ai_PageNo);ii_currentpageno = ai_PageNo
return 1
end function

public function integer wf_getcurrentpage ();Return ii_currentpageno
end function

public function integer wf_settotalpages (integer ai_numpages);ii_totalpages = ai_NumPages

REturn 1
end function

public function integer wf_gettotalpages ();Return ii_totalpages
end function

public function integer wf_viewprev ();Int	li_CurrentPage

li_CurrentPage = wf_GetCurrentPage ( )

if li_CurrentPage -1 > 0 THEN
	wf_DisplayImage ( wf_GetImage( ) , li_CurrentPage - 1 )
	wf_SetCurrentPage ( li_CurrentPage - 1 )
END IF

RETURN 1
end function

private function integer wf_settopic (string as_topic);is_topic = as_Topic

IF as_Topic = "UNKNOWN" THEN
	wf_ChangeWindowContext ( 2 ) 
	
	THIS.Title = as_Topic
ELSEIF as_topic = "UNASSIGNED" THEN
	
	wf_Changewindowcontext( 3 )
	
	THIS.Title = "Unassigned Images"
	
ELSE
	wf_ChangeWindowContext ( 1 )

END IF



Return 1
end function

private function String wf_gettopic ();Return is_topic
end function

public function integer wf_changewindowcontext (integer ai_context);/* CONTEXT  1 = scan single only
				2 = scan batch or single
				3 = View unassigned Images
*/

n_cst_beo_Image lnv_Image 



CHOOSE CASE ai_Context
		
	CASE 1
		
		cb_barcode.Visible = FALSE
		is_context = "KNOWN"
		wf_ResetWindow ( )
		
	CASE 2
		wf_SetImageID ( {0} ) 
	
		
		//cb_Barcode.Visible = TRUE
			
		THIS.wf_SetCurrentPage ( 0 )
		wf_resetWindow (  )
		is_context = "UNKNOWN"
	
	CASE 3
		cb_scan.Visible = FALSE
		is_Context = "UNASSIGNED"
		ddlb_topic.Enabled = FALSE
		THIS.wf_viewunassigned( )
		
		
		
END CHOOSE

RETURN 1
end function

public function integer wf_setimageid (long al_imageid[]);ila_imageid = al_ImageID
Return 1
end function

public function integer wf_getidarray (ref long ala_IDarray[]);ala_IDarray = ila_imageid[]
Return 1
end function

public function integer wf_setmessage (n_cst_msg anv_msgObject);inv_msg = anv_msgObject
Return 1
end function

public function n_cst_msg wf_getmessage ();RETURN inv_msg
end function

public function integer of_settitle (String as_Title);THIS.Title = as_Title
Return 1

end function

public function integer wf_resetwindow ();//RDT 7-29-03 delete type = "NONE"

n_cst_beo_Image lnv_Image 
st_pageno.Text = "0 of 0"
wf_SetImage ( lnv_Image )

THIS.wf_getimagingcontrol( ).FileName = ""


of_SetTitle ( wf_GetTopic ( ) )


// I commented this b.c. we do not delete the unknown images as of 4.0
//IF wf_HasUnknown () THEN
//	dw_ImageList.Event ue_DeleteUnknown ( )
//END IF
//
////RDT 7-29-03 -Start
//IF wf_HasNoType() THEN
//	dw_ImageList.Event ue_DeleteNoType( )
//END IF
//RDT 7-29-03 -End 


dw_imagelist.Reset ( )
dw_1.Reset ( )

dw_1.Setuilink( TRUE )


Return 1
end function

public function string wf_getcontext ();RETURN is_context
end function

public function integer wf_setactiveid (long al_id);
IF IsNull ( al_id ) THEN
	il_ActiveId = 0 
ELSE
	il_activeid = al_id
END IF

IF NOT THIS.wf_GetTopic () = "UNKNOWN" THEN
	of_SetTitle( THIS.wf_GetTopic () + " No. " + String ( al_id ) ) 
END IF

RETURN 1
end function

private function integer wf_changesize ();//RDT 7-29-03 Changed window sizing to vertial
n_cst_privileges lnv_privileges


IF ib_fullsize then  // go to half size

	ib_FullSize = FALSE
	
	cb_deletepage.TabOrder = 0
	cb_barcode.TabOrder = 0
	cb_delete.Taborder = 0
	cb_scan.Taborder = 0

	//	this.X = 1641 				//RDT 7-29-03 
	This.Y = il_MaxHeight / 2 		//RDT 7-29-03 
	This.Height = il_MaxHeight / 2 //RDT 7-29-03 
	
	dw_imagelist.Object.Image_ID.Protect = 1
	dw_imagelist.Object.Image_Category.Protect = 1
	dw_imagelist.Object.Image_Type.Protect = 1
	setFocus ( dw_imagelist )
	
ELSE
	
	
	
	THIS.width = il_MaxWidth
	ib_FullSize = TRUE
	This.X = 0
	This.Y = 0						//RDT 7-29-03 
	This.Height = il_MaxHeight	//RDT 7-29-03 
	
	cb_deletepage.TabOrder = ic_deletepageto
	cb_barcode.TabOrder = ic_BarcodeTO
	cb_delete.Taborder = ic_DeleteTO
	cb_scan.Taborder = ic_ScanTO
	
	IF lnv_privileges.of_hasImageChangingRights ( ) THEN
		dw_imagelist.Object.Image_Category.Protect = 0
		dw_imagelist.Object.Image_Type.Protect = 0	
	END IF
	
	IF lnv_privileges.of_hasImageChangingRights  ( ) THEN
		dw_imagelist.Object.Image_ID.Protect = 0
	END IF
	
//	Register all versions of the imaging control
	inv_Resize.of_Register ( ole_image4, 'ScaleToRight&Bottom' )
	inv_Resize.of_Register ( ole_image7, 'ScaleToRight&Bottom' )
	
	
	
	inv_Resize.of_Register ( dw_imagelist, 'FixedToRight&ScaleToBottom' )
	
	inv_Resize.of_Register ( gb_3, 'FixedToRight&ScaleToBottom' )
	
	inv_Resize.of_Register ( cb_DeletePage, 'FixedToRight&Bottom' )
	inv_Resize.of_Register ( cb_barcode, 'FixedToRight&Bottom' )
	inv_Resize.of_Register ( cb_delete, 'FixedToRight&Bottom' )
	inv_Resize.of_Register ( cb_scan, 'FixedToRight&Bottom' )
	inv_Resize.of_Register ( cbx_showexternal, 'FixedToRight&Bottom' )
	
	inv_Resize.of_Register ( gb_1, 'FixedToRight' )
	inv_Resize.of_Register ( ddlb_topic, 'FixedToRight' )	
END IF

RETURN 1
end function

public function boolean wf_hasunknown ();Int	i
n_cst_beo_image	lnv_Image
Boolean	lb_return 

For i = 1 TO dw_imagelist.RowCount ( )
	lnv_Image =	dw_imagelist.inv_UILink.getBeo( i )
	IF lnv_Image.of_GetID ( ) > 0 THEN
		CONTINUE
	ELSE
		lb_Return = TRUE
		EXIT
	END IF
	
NEXT

RETURN lb_Return
end function

public function boolean wf_hasnotype ();// RDT 7-29-03 New 
Int	i
n_cst_beo_image	lnv_Image
Boolean	lb_return 

For i = 1 TO dw_imagelist.RowCount ( )
	
	lnv_Image =	dw_imagelist.inv_UILink.getBeo( i )
	
	IF lnv_Image.of_GetType( ) = "NONE" THEN
		lb_Return = TRUE
		EXIT
	ELSE
		CONTINUE
	END IF
	
NEXT

RETURN lb_Return
end function

public subroutine wf_disablewincontrols ();/*
// Function	: 
// Arguments 	: None 
// Returns 	: None
// Description  : Add Description here
// Author	: Add Author Name here
// Created on 	: Add timestamp here
// Modified by 	: Add Author here	TimeStamp
//				
*/

THIS.cb_rotate.Enabled = FALSE
THIS.cb_delete.Enabled = FALSE
THIS.cb_scan.Enabled   = FALSE 
THIS.cb_deletepage.Enabled = FALSE
THIS.dw_imagelist.SetTabOrder('image_id',0)
THIS.dw_imagelist.SetTabOrder('image_category',0)
THIS.dw_imagelist.SetTabOrder('image_type',0)


end subroutine

public subroutine wf_enablewincontrols ();//THIS.cb_rotate.Enabled = TRUE
//THIS.cb_delete.Enabled = TRUE
//THIS.cb_scan.Enabled   = TRUE
//THIS.cb_deletepage.Enabled = TRUE
//THIS.dw_imagelist.SetTabOrder('image_id',10)
//THIS.dw_imagelist.SetTabOrder('image_category',20)
//THIS.dw_imagelist.SetTabOrder('image_type',30)

//not sure if I should change it to this, Dan 6-29-06
wf_checkprivs()
end subroutine

public function oleobject wf_getimagingcontrol ();OleObject	loo_Return

n_cst_imagingversioncontrol	lnv_ImageVersion
n_cst_bso_imagemanager			lnv_ImageManager

lnv_ImageManager	 = CREATE n_cst_bso_imagemanager

IF lnv_ImageManager.of_Getimagingversioncontrol( lnv_ImageVersion ) = 1 THEN
	CHOOSE CASE lnv_ImageVersion.ir_version
			
		CASE appeon_constant.cr_version_4
			loo_Return = ole_image4.object
			
		CASE appeon_constant.cr_version_7
			loo_Return = ole_image7.object
			
		CASE ELSE
			
			
	END CHOOSE
END IF

DESTROY ( lnv_ImageManager )

RETURN loo_Return 
end function

public function integer wf_deleteimage ();n_cst_beo_Image 	lnv_image

lnv_Image = wf_getImage ( )

IF isValid ( lnv_Image ) THEN

	lnv_Image.of_DeleteImage ( )
	THIS.wf_getimagingcontrol( ).Filename = ""
	st_pageno.text = "0 of 0"
	of_SetTitle ( wf_GetTopic ( ) )
	
	//dw_imagelist.EVENT ue_DeleteRow ( )
	dw_1.EVENT ue_DeleteRow ( )
	
	IF dw_1.rowCount( ) = 0 THEN
		cb_deletepage.enabled = false
	END IF
END IF

RETURN 1
end function

public function integer wf_setbcm (n_cst_bcm anv_bcm);Int li_RtnVal = 1
n_cst_beo_image   	lnv_Beo

n_cst_bso_ImageManager_Pegasus lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = Create n_cst_bso_ImageManager_Pegasus 

IF IsValid(anv_Bcm) THEN
	ib_ProcessRowChange	= FALSE
	IF dw_ImageList.inv_UILink.SetBcm ( anv_Bcm ) <> 1 THEN 
	ELSE
		wf_syncdatawindows( )
	END IF
	ib_ProcessRowChange	= TRUE
ELSE
	li_RtnVal = -1
END IF

IF li_RtnVal = 1 THEN

	IF dw_ImageList.RowCount() > 0 THEN
		lnv_beo =dw_ImageList. inv_uilink.getBeo(1)
	ELSE
		li_RtnVal = -1
	END IF
END IF

IF li_RtnVal = 1 THEN
	IF IsValid(lnv_beo) THEN
		wf_Displayimage( lnv_Beo)
	ELSE
		li_RtnVal = -1
	END IF
END IF

Destroy(lnv_ImageManager_Pegasus)

Return li_RtnVal 
end function

public function integer wf_viewunassigned ();n_cst_bso_ImageManager_Pegasus	lnv_ImageManager
n_cst_bcm			lnv_Bcm

lnv_imageManager = CREATE n_cst_bso_ImageManager_Pegasus

IF isValid ( lnv_imageManager ) THEN
	lnv_Bcm = lnv_imageManager.of_GetUnassignedimagebcm( )
END IF

THIS.wf_setbcm(lnv_Bcm)
//IF IsValid ( lnv_Bcm ) THEN
//	THIS.dw_ImageList.inv_UILink.SetBcm ( lnv_Bcm )
//END IF

DESTROY ( lnv_ImageManager )

RETURN 1




//Int		li_ReturnValue = 1
//Long 		ll_filecnt
//Long		i
//Long		ll_ImageCount
//String	ls_TotalPath
//String	ls_Root
//String	lsa_ImagePaths[]			
//			
//n_cst_bcm			lnv_Bcm
//
//n_cst_beo_imageType 	lnv_ImageType
//
//n_cst_filesrvwin32	lnv_filesrvwin32
//n_cst_dirattrib		lnv_dirattrib[]
//
//lnv_filesrvwin32 = Create n_cst_filesrvwin32
//
//IF li_ReturnValue = 1 THEN
//	ls_Root = inv_ImageManager.of_getBatchFolder ( ) 
//	IF Len( ls_Root ) = 0 THEN
//		li_ReturnValue = -1
//	END IF
//END IF
//
//IF li_ReturnValue = 1 THEN
//	ll_filecnt = lnv_filesrvwin32.of_dirlist ( ls_root+"*.*", 39, lnv_dirattrib )
//	FOR i = 1 TO ll_filecnt
//		ls_TotalPath = ls_root + lnv_dirattrib[i].is_filename
//		ll_ImageCount++
//		lsa_ImagePaths [ ll_ImageCount ] = ls_TotalPath
//	NEXT
//END IF
//	
//IF li_ReturnValue = 1 THEN
//
//	lnv_Bcm = gnv_BcmMgr.CreateBcm ( )				
//	lnv_Bcm.SetDlk ( "n_cst_dlkc_imageType" )
//	lnv_Bcm.AddClass ( "n_cst_beo_imageType" )
//	
//	lnv_Bcm.NewBeo ( lnv_ImageType )
//	
//	lnv_ImageType.of_settopic ( "SHIPMENT" )
//	lnv_ImageType.of_setcategory ( "UNSECURE")	
//	lnv_ImageType.of_settype ( "NONE" )
//	
//END IF
//
//String		ls_ErrorMessage
//
//
//
//
//n_cst_bcm			lnv_Bcm2
//n_cst_beo_Image	lnv_Image
//
//
//IF NOT isValid (  THIS.dw_ImageList.inv_UILink ) THEN
//	li_ReturnValue = -1
//	ls_ErrorMessage = "The updating of the image list could not be performed."
//END IF
//
//	
//IF li_ReturnValue = 1 THEN	
//	
//	
//	lnv_Bcm2 = gnv_BcmMgr.CreateBcm ( )
//	lnv_Bcm2.SetDlk ( "n_cst_dlkc_image" )
//	lnv_Bcm2.AddClass ( "n_cst_beo_image" )
//	
//	IF Not IsValid ( lnv_bcm ) THEN
//		li_ReturnValue = -1
//	END IF
//		
//	IF li_ReturnValue = 1 THEN
//		
//		FOR i = 1 to ll_ImageCount
//			
//			IF NOT inv_imagemanager.of_DoesImageExist ( lsa_ImagePaths [ i ]  ) THEN
//				CONTINUE
//			END IF
//			Long	ll_NewRtn
//			ll_NewRtn = lnv_Bcm2.NewBeo ( lnv_Image )
//			
//	
//			IF IsValid ( lnv_Image ) THEN
//				
//				IF isValid ( lnv_ImageType ) THEN
//					
//					lnv_Image.of_SetImageType ( lnv_imagetype )
//					lnv_Image.of_SetFilePath ( lsa_ImagePaths [ i ] )
//					lnv_image.of_setid( 0, FALSE )
//					
//				
//				ELSE
//				//	li_ReturnValue = THIS.of_PopulateImage ( lsa_ImagePaths [ k ]  , lnv_image)
//				END IF
//
//			ELSE
//				li_ReturnValue = -1
//				ls_ErrorMessage = "An error occurred while attempting to update the image list."
//				EXIT
//			END IF
//			
//		NEXT
//		
//	END IF
//END IF
//
//IF li_ReturnValue = 1 THEN
//	
//	THIS.dw_ImageList.inv_UILink.SetBcm ( lnv_Bcm2 )
//	
//END IF
//
//DESTROY ( lnv_filesrvwin32 )
//
//RETURN li_ReturnValue
end function

public function integer wf_savechanges ();Int	i
Long	ll_Shipment
String	ls_Type

String	ls_OriginalType
Long		ll_OriginalShipment

FOR i = 1 TO dw_1.RowCount ( )
	ll_Shipment = dw_1.GetItemNumber ( i , "image_id" )
	dw_1.SetItemStatus ( i , 0 , PRIMARY!, NotModified!	)
	IF IsNull ( ll_Shipment ) OR ll_Shipment = 0 THEN
		CONTINUE
	ELSE
		ls_Type = dw_1.GetItemString( i, "image_Type" )
		
		ll_OriginalShipment = dw_imagelist.GetItemNumber ( i , "image_id" )
		ls_OriginalType = dw_imagelist.GetItemString( i, "image_Type" )
		
		IF ll_OriginalShipment <> ll_Shipment OR isNull ( ll_OriginalShipment ) THEN 
			dw_imagelist.inv_uilink.SetText( i, "image_id", String ( ll_Shipment) )
		//	dw_imagelist.SetItem ( i, "image_id",  ll_Shipment)
		END IF 
		
		IF ls_OriginalType <> ls_Type OR isNull ( ls_OriginalType ) THEN
			dw_imagelist.inv_uilink.SetText( i, "image_Type" , ls_Type)
			//dw_imagelist.SetItem ( i, "image_Type" , ls_Type)
		END IF
	END IF
		
NEXT


RETURN 1
end function

private function integer wf_savemenusettings (long al_topmenuid, long al_submenuid);IF al_submenuid > 0 OR al_topmenuid > 0 THEN
	SetProfileString ( gnv_app.of_getappinifile( ) , "IMAGING", "TOP", String (al_topmenuid ) )
	SetProfileString ( gnv_app.of_getappinifile( ) , "IMAGING", "SUB", String ( al_submenuid ) )
END IF

RETURN 1
end function

public function integer wf_applysavedmenusettings ();String	ls_Top
String	ls_Sub
Boolean	lb_Return
Boolean	lb_Temp
ls_Top = ProfileString ( gnv_app.of_getappinifile( ), "IMAGING", "TOP", "-1" )
ls_Sub = ProfileString ( gnv_app.of_getappinifile( ), "IMAGING", "SUB", "-1" )

IF ls_Top <> "-1" AND ls_Sub <> "-1" THEN
//	ole_image7.event menuselect( 1, 0, Integer (ls_Top ), integer ( ls_Sub ), 0 , 0 )
	
//	CHOOSE CASE 
	 //ole_image7.object.MenuSetItemChecked ( 1 , 0 , Integer (ls_Top ) , Integer ( ls_Sub ) , TRUE , TRUE )
	 
	//ole_image7.Dynamic MenuSetItemChecked ( 1 , 0 , 400 , 1 , TRUE , TRUE )

	
	
END IF


RETURN 1
end function

private function integer wf_syncdatawindows ();Blob	lblb_State
//dw_imagelist.inv_uilink.Sharedata( THIS )

dw_Imagelist.GetFullstate( lblb_State )
dw_1.SetFullState( lblb_State )

dw_1.Setuilink( FALSE )
RETURN 1
end function

public function integer wf_checkprivs ();//Created By Dan 5-3-2006
//this function will disable and enable buttons based on a users
//privileges for the division in which the shipment that is associated
//with the image.  
Int		li_return
Long		ll_division

n_cst_privsManager	lnv_privsManager
n_cst_beo_image lnv_image 

lnv_image = this.wf_Getimage( )
lnv_privsManager = gnv_app.of_getprivsmanager( )  //create n_cst_privsManager			//tempory, will be a call on the app to get this

IF isValid( lnv_image ) AND isValid( lnv_privsManager )THEN
	ll_division = lnv_image.of_getDivision( )
	
	
	IF lnv_privsManager.of_getUserpermissionfromfn( lnv_privsManager.cs_DeleteImage , ll_division ) = 1 THEN
		THIS.cb_delete.Enabled = TRUE
		THIS.cb_deletepage.Enabled = TRUE
		IF this.wf_getcurrentpage( ) > 0 THEN
			THIS.cb_delete.visible = TRUE
			THIS.cb_deletepage.visible = TRUE
		END IF
	ELSE
		THIS.cb_delete.Enabled = FALSE
		THIS.cb_deletepage.Enabled = FALSE
		//THIS.cb_delete.visible = false
		//THIS.cb_deletepage.visible = false
	END IF
	
	IF lnv_privsManager.of_getUserpermissionfromfn( lnv_privsManager.cs_ScanImage , ll_division ) = 1 THEN
		THIS.cb_scan.Enabled   = TRUE
		this.cb_scan.visible = true
	ELSE
		THIS.cb_scan.Enabled   = FALSE
		//this.cb_scan.visible = false
	END IF
	
	IF lnv_privsManager.of_getUserpermissionfromfn( lnv_privsManager.cs_ModifyImage , ll_division ) = 1 THEN
		
		// I commented out the enablement/tab order of some of the folling controls because they should never have focus.
		// <<*>> 
		
		THIS.cb_rotate.Enabled = TRUE
		THIS.dw_1.SetTabOrder('image_id',10)
	//	THIS.dw_1.SetTabOrder('image_category',20)
		THIS.dw_1.SetTabOrder('image_type',30)
//		THIS.dw_imagelist.SetTabOrder('image_id',10)
//		THIS.dw_imagelist.SetTabOrder('image_category',20)
//		THIS.dw_imagelist.SetTabOrder('image_type',30)
		This.ddlb_topic.enabled = true
		
		dw_1.Object.Image_Type.protect = 0	
		dw_1.Object.Image_id.protect = 0
	//	dw_1.Object.Image_category.protect = 0
	ELSE
		THIS.cb_rotate.Enabled = FALSE
		THIS.dw_1.SetTabOrder('image_id',0)
		THIS.dw_1.SetTabOrder('image_category',0)
		THIS.dw_1.SetTabOrder('image_type',0)
		THIS.dw_imagelist.SetTabOrder('image_id',0)
		THIS.dw_imagelist.SetTabOrder('image_category',0)
		THIS.dw_imagelist.SetTabOrder('image_type',0)
		this.ddlb_topic.enabled = False
		dw_1.Object.Image_Type.protect = 1
		dw_1.Object.Image_id.protect = 1
		dw_1.Object.Image_category.protect = 1
	END IF
	
	
END IF

//Messagebox("Rowfocuschange","rowfocuschange")

RETURN li_Return
end function

public function boolean wf_haspermission (string as_function);//written by dan. 5-4-2006.  Returns true if a user has permission
//to do the function as_function for the current image.  Only used for
//rotation saving right now.  Returns true all the time for old funtionality.

Boolean	lb_return
Long		ll_division

n_cst_privsManager	lnv_privsManager

lnv_privsManager = gnv_app.of_getprivsmanager( ) //create n_cst_privsManager			//tempory, will be a call on the app to get this
	
IF isValid( inv_image ) AND isValid( lnv_privsManager )THEN
	ll_division = inv_image.of_getDivision( )
	
	IF lnv_privsManager.of_getUserpermissionfromfn( as_function , ll_division ) = 1 THEN
		lb_return = true
	ELSE
		//lb_remains false
	END IF
END IF

RETURN lb_return
end function

on w_imaging.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.pb_rotate180=create pb_rotate180
this.pb_rotateright=create pb_rotateright
this.pb_rotateleft=create pb_rotateleft
this.cb_deletepage=create cb_deletepage
this.cb_print=create cb_print
this.cb_scan=create cb_scan
this.cb_rotate=create cb_rotate
this.gb_1=create gb_1
this.st_pageno=create st_pageno
this.st_5=create st_5
this.cb_prevpage=create cb_prevpage
this.cb_nextpage=create cb_nextpage
this.sle_rotate=create sle_rotate
this.st_2=create st_2
this.cb_barcode=create cb_barcode
this.ddlb_topic=create ddlb_topic
this.cb_delete=create cb_delete
this.hsb_zoom=create hsb_zoom
this.st_3=create st_3
this.st_4=create st_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_showexternal=create cbx_showexternal
this.mle_clipboard=create mle_clipboard
this.st_clipboard=create st_clipboard
this.pb_arrow=create pb_arrow
this.pb_zoomin=create pb_zoomin
this.pb_zoomout=create pb_zoomout
this.pb_zoomselected=create pb_zoomselected
this.pb_grab=create pb_grab
this.gb_menu=create gb_menu
this.pb_zoombestfit=create pb_zoombestfit
this.ole_image7=create ole_image7
this.ole_scan=create ole_scan
this.ole_barcode=create ole_barcode
this.ole_print=create ole_print
this.ole_image4=create ole_image4
this.dw_1=create dw_1
this.dw_imagelist=create dw_imagelist
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_rotate180
this.Control[iCurrent+2]=this.pb_rotateright
this.Control[iCurrent+3]=this.pb_rotateleft
this.Control[iCurrent+4]=this.cb_deletepage
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_scan
this.Control[iCurrent+7]=this.cb_rotate
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.st_pageno
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.cb_prevpage
this.Control[iCurrent+12]=this.cb_nextpage
this.Control[iCurrent+13]=this.sle_rotate
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.cb_barcode
this.Control[iCurrent+16]=this.ddlb_topic
this.Control[iCurrent+17]=this.cb_delete
this.Control[iCurrent+18]=this.hsb_zoom
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.cb_1
this.Control[iCurrent+22]=this.cb_2
this.Control[iCurrent+23]=this.cbx_showexternal
this.Control[iCurrent+24]=this.mle_clipboard
this.Control[iCurrent+25]=this.st_clipboard
this.Control[iCurrent+26]=this.pb_arrow
this.Control[iCurrent+27]=this.pb_zoomin
this.Control[iCurrent+28]=this.pb_zoomout
this.Control[iCurrent+29]=this.pb_zoomselected
this.Control[iCurrent+30]=this.pb_grab
this.Control[iCurrent+31]=this.gb_menu
this.Control[iCurrent+32]=this.pb_zoombestfit
this.Control[iCurrent+33]=this.ole_image7
this.Control[iCurrent+34]=this.ole_scan
this.Control[iCurrent+35]=this.ole_barcode
this.Control[iCurrent+36]=this.ole_print
this.Control[iCurrent+37]=this.ole_image4
this.Control[iCurrent+38]=this.dw_1
this.Control[iCurrent+39]=this.dw_imagelist
this.Control[iCurrent+40]=this.gb_3
end on

on w_imaging.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_rotate180)
destroy(this.pb_rotateright)
destroy(this.pb_rotateleft)
destroy(this.cb_deletepage)
destroy(this.cb_print)
destroy(this.cb_scan)
destroy(this.cb_rotate)
destroy(this.gb_1)
destroy(this.st_pageno)
destroy(this.st_5)
destroy(this.cb_prevpage)
destroy(this.cb_nextpage)
destroy(this.sle_rotate)
destroy(this.st_2)
destroy(this.cb_barcode)
destroy(this.ddlb_topic)
destroy(this.cb_delete)
destroy(this.hsb_zoom)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_showexternal)
destroy(this.mle_clipboard)
destroy(this.st_clipboard)
destroy(this.pb_arrow)
destroy(this.pb_zoomin)
destroy(this.pb_zoomout)
destroy(this.pb_zoomselected)
destroy(this.pb_grab)
destroy(this.gb_menu)
destroy(this.pb_zoombestfit)
destroy(this.ole_image7)
destroy(this.ole_scan)
destroy(this.ole_barcode)
destroy(this.ole_print)
destroy(this.ole_image4)
destroy(this.dw_1)
destroy(this.dw_imagelist)
destroy(this.gb_3)
end on

event open;call super::open;
// the message object is intercepted in the constructor if dw_ImageList and set to an
// instance variable in w_imaging
//RDT 7-29-03 Added clipboard

String	ls_Topic
Int		li_Privs
Long		lla_id[]
Any		la_Setting
Long 		ll_division
n_cst_Settings	lnv_settings
n_cst_beo_image		lnv_image
N_cst_privsManager lnv_privsManager
N_cst_shipmentManager	lnv_shipmentManager


lnv_privsManager = gnv_app.of_getPrivsManager()

//	Request a lock for user
n_cst_LicenseManager lnv_LicenseManager 
IF lnv_LicenseManager.of_GetModuleLock ( n_cst_constants.cs_Module_Imaging, "E" ) < 0 THEN
	ib_DisableCloseQuery = TRUE
	close (this)
	return
END IF

n_cst_imagingversioncontrol	lnv_ImageVersion
n_cst_bso_imagemanager			lnv_ImageManager

lnv_ImageManager	 = CREATE n_cst_bso_imagemanager

IF lnv_ImageManager.of_Getimagingversioncontrol( lnv_ImageVersion ) = 1 THEN
	CHOOSE CASE lnv_ImageVersion.ir_version
			
		CASE appeon_constant.cr_version_4
			ole_image4.Visible = TRUE
			ole_image7.Visible = FALSE
			cb_DeletePage.Visible = FALSE
			
			pb_Arrow.Visible = FALSE
			pb_Zoomin.Visible = FALSE
			pb_Zoomout.Visible = FALSE
			pb_zoomselected.Visible = FALSE
			pb_zoombestfit.Visible = FALSE
			pb_grab.Visible = FALSE
			pb_rotateleft.Visible = FALSE
			pb_rotateRight.Visible = FALSE
			pb_rotate180.Visible = FALSE
			gb_Menu.Visible = FALSE
			
			hsb_zoom.Visible = TRUE
			st_3.Visible = TRUE
			st_4.Visible = TRUE
			
			SetFocus (ole_image4)
			
		CASE appeon_constant.cr_version_7
			ole_image4.Visible = FALSE
			ole_image7.Visible = TRUE
			cb_DeletePage.Visible = TRUE
			
			gb_Menu.Visible = TRUE
			pb_Arrow.Visible = TRUE
			pb_Zoomin.Visible = TRUE
			pb_Zoomout.Visible = TRUE
			pb_zoomselected.Visible = TRUE
			pb_zoombestfit.Visible = TRUE
			pb_grab.Visible = TRUE
			pb_rotateleft.Visible = TRUE
			pb_rotateRight.Visible = TRUE
			pb_rotate180.Visible = TRUE
			
			hsb_zoom.Visible = FALSE
			st_3.Visible = FALSE
			st_4.Visible = FALSE
			
			
								
			SetFocus (ole_image7)
			ole_image7.Object.ToolSet ( 1 , 1, 0 ) 
			
			
			
		CASE ELSE
	END CHOOSE
END IF

DESTROY ( lnv_ImageManager )


n_cst_Privileges	lnv_Privileges
n_cst_msg	lnv_msg
s_parm	lstr_Parm

gf_mask_Menu ( m_sheets )


setPointer ( HOURGLASS! )

/*
IF lnv_privileges.of_hasAuditRights ( ) THEN
	cb_delete.Visible = TRUE
END IF

IF lnv_Privileges.of_HasScanningRights ( ) THEN
	cb_scan.Visible = TRUE
END IF
*/





lnv_Msg = wf_getMessage( )

IF isValid ( lnv_Msg ) THEN
	
	IF lnv_msg.of_Get_Parm( "PRIV" , lstr_Parm ) <> 0 THEN
		li_Privs = lstr_Parm.ia_Value
	END IF
	
	IF lnv_msg.of_Get_Parm( "TOPIC" , lstr_Parm ) <> 0 THEN
		ls_Topic = lstr_Parm.ia_Value
		wf_SetTopic ( ls_Topic )
	END IF
	
	IF lnv_msg.of_Get_Parm( "ID" , lstr_Parm ) <> 0 THEN
		lla_id = lstr_Parm.ia_Value
		wf_SetActiveID ( lla_id[1] )
   	wf_SetImageID ( lla_id )
		
		ll_division = lnv_shipmentManager.of_getDivision( lla_id[1] )
		
	END IF

	ddlb_Topic.Text = wf_getTopic ( )

END IF

lnv_image = this.wf_getImage()
IF ll_division > 0 THEN
	IF lnv_privsManager.of_getUserpermissionfromfn( lnv_privsManager.cs_DeleteImage, ll_division) = 1 THEN
		cb_delete.Visible = TRUE
	ELSE
		cb_delete.enabled = false
		cb_deletepage.enabled = false
	END IF
	
	IF lnv_privsManager.of_getUserpermissionfromfn( lnv_privsManager.cs_scanimage, ll_division ) = 1  THEN
		cb_scan.Visible = TRUE
	ELSE
		cb_scan.enabled = false
	END IF
ELSE
	//no division = no shiptype,
	//if using extended privs, the user can scan as many things as they want
	//if there isn't then it comes down to the old functionality
	
	IF lnv_privsmanager.of_useAdvancedPrivs() THEn
		cb_delete.Visible = TRUE
		cb_scan.Visible = TRUE
	ELSE 
		IF lnv_privileges.of_hasAuditRights ( ) THEN
			cb_delete.Visible = TRUE
		ELSE
			cb_delete.visible = false
			cb_deletepage.enabled = false
		END IF
		
		IF lnv_Privileges.of_HasScanningRights ( ) THEN
			cb_scan.Visible = TRUE
		ELSE
			cb_scan.visible = false
		END IF
				
	END IF
END IF
//SetFocus (ole_image)

IF isValid( lnv_image ) THEN
	//deletepage button stays visible	
ELSE
	cb_deletepage.enabled = false
END IF

IF lnv_settings.of_GEtSetting ( 64, la_Setting ) = 1 THEN// "Enable Imaging External Exception Notification" 
	if String ( la_Setting ) = "NO!" THEN
		cbx_showexternal.Checked = FALSE
	ELSE
		cbx_showexternal.Checked = TRUE
	END IF
END IF

this.post wf_checkPrivs()

This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
//il_MaxWidth = This.Width - 16
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )

inv_Resize.of_SetMinSize ( 3579, 932 )
THIS.x = 0
THIS.y = 0


this.dw_1.bringtotop = true

//Register Resizable controls
inv_Resize.of_Register ( dw_imagelist, 'FixedToRight&ScaleToBottom' )
inv_Resize.of_Register ( dw_1, 'FixedToRight&ScaleToBottom' )
inv_Resize.of_Register ( gb_3, 'FixedToRight&ScaleToBottom' )


inv_Resize.of_Register ( cb_deletepage, 'FixedToRight&Bottom' )
inv_Resize.of_Register ( cb_barcode, 'FixedToRight&Bottom' )
inv_Resize.of_Register ( cb_delete, 'FixedToRight&Bottom' )
inv_Resize.of_Register ( cb_scan, 'FixedToRight&Bottom' )
inv_Resize.of_Register ( cbx_showexternal, 'FixedToRight&Bottom' )

inv_Resize.of_Register ( gb_1, 'FixedToRight' )
inv_Resize.of_Register ( ddlb_topic, 'FixedToRight' )
inv_Resize.of_Register ( mle_clipboard, 'FixedToRight' )
inv_Resize.of_Register ( st_clipboard, 'FixedToRight' )

inv_Resize.of_Register ( st_2, 'FixedToBottom' )
inv_Resize.of_Register ( cb_rotate, 'FixedToBottom' )
inv_Resize.of_Register ( sle_rotate, 'FixedToBottom' )
inv_Resize.of_Register ( cb_nextpage, 'FixedToBottom' )
inv_Resize.of_Register ( cb_prevpage, 'FixedToBottom' )
inv_Resize.of_Register ( hsb_zoom, 'FixedToBottom' )
inv_Resize.of_Register ( st_pageno, 'FixedToBottom' )
inv_Resize.of_Register ( cb_2, 'FixedToBottom' )
inv_Resize.of_Register ( cb_1, 'FixedToBottom' )
inv_Resize.of_Register ( st_5, 'FixedToBottom' )
inv_Resize.of_Register ( st_3, 'FixedToBottom' )
inv_Resize.of_Register ( st_4, 'FixedToBottom' )
inv_Resize.of_Register ( cb_print, 'FixedToBottom' )

inv_Resize.of_Register ( ole_image4, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( ole_image7, 'ScaleToRight&Bottom' )
inv_Resize.of_Register ( gb_menu , inv_resize.scalebottom )




end event

event pfc_postopen;
il_MaxWidth = This.Width 

il_MaxHeight = This.Height


IF wf_GetTopic ( ) = "UNKNOWN" THEN
	cb_scan.Event Clicked ( )
END IF

//THIS.wf_Applysavedmenusettings( )  // not used at this point
end event

event close;call super::close;THIS.wf_savechanges( )
end event

type pb_rotate180 from picturebutton within w_imaging
integer x = 50
integer y = 1336
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Rotate180.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;INT	li_CurrentPage
Int	li_Degrees = 180
Boolean lb_saverotation
IF isValid ( inv_image ) THEN
	Parent.wf_getimagingcontrol( ).Rotate ( li_Degrees )
	li_CurrentPage = wf_GetCurrentPage ( )
	
	//modified by dan to check permissions
	lb_saveRotation = parent.wf_haspermission( appeon_constant.cs_modifyImage )
END IF

IF lb_saveRotation THEN
	inv_image.of_SaveRotation ( li_CurrentPage , li_Degrees )
END IF
end event

type pb_rotateright from picturebutton within w_imaging
integer x = 50
integer y = 1176
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "RotateRight.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;INT	li_CurrentPage
Int	li_Degrees = 270
Boolean lb_saveRotation
IF isValid ( inv_image ) THEN
	Parent.wf_getimagingcontrol( ).Rotate ( li_Degrees )
	li_CurrentPage = wf_GetCurrentPage ( )
	//condition adde by dan to check permissions
	lb_saveRotation = parent.wf_hasPermission( appeon_constant.cs_ModifyImage )
END IF

IF lb_saveRotation THEN
	inv_image.of_SaveRotation ( li_CurrentPage , li_Degrees )
END IF
end event

type pb_rotateleft from picturebutton within w_imaging
integer x = 50
integer y = 1016
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "RotateLeft.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;INT	li_CurrentPage
Int	li_Degrees = 90
Boolean lb_saveRotation
IF isValid ( inv_image ) THEN
	Parent.wf_getimagingcontrol( ).Rotate ( li_Degrees )
	li_CurrentPage = wf_GetCurrentPage ( )
	//added by dan 5-4-2006 to check permissions
	lb_saveRotation = parent.wf_hasPermission( appeon_constant.cs_ModifyImage )
	
END IF

IF lb_saveRotation THEN
	inv_image.of_SaveRotation ( li_CurrentPage , li_Degrees )
END IF
end event

type cb_deletepage from u_cb within w_imaging
boolean visible = false
integer x = 2048
integer y = 1608
integer width = 553
integer height = 76
integer taborder = 30
boolean bringtotop = true
string text = "Delete Page"
end type

event clicked;call super::clicked;Parent.event ue_deletecurrentpage( )
end event

type cb_print from u_cb within w_imaging
integer x = 603
integer y = 1612
integer width = 393
integer height = 76
integer taborder = 80
boolean bringtotop = true
string text = "&Print Image"
end type

event clicked;

dw_imagelist.Event ue_PrintImage ( )
end event

type cb_scan from u_cb within w_imaging
integer x = 3067
integer y = 1608
integer width = 357
integer height = 76
integer taborder = 50
boolean bringtotop = true
string text = "&Scan New"
end type

event clicked;//RDT 7-29-03 Check for types = "NONE" before next scan
Long		lla_ID[]
Long		ll_ID
Long		ll_ActiveID

Boolean	lb_Multipage = FALSE
Boolean 	lb_Scan = TRUE
Boolean	lb_Continue = TRUE
Blob		lblb_State

String	ls_Topic
String	ls_Context

Int		i
Int		li_return 
n_cst_Privileges	lnv_privileges
n_cst_beo_Image	lnva_Images[]

n_cst_bso_imageManager_Pegasus lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_imageManager_Pegasus


//IF lnv_ImageManager.ib_archiveimage THEN
	IF dw_imagelist.RowCount () > 0 THEN
	
		IF messageBox( "Scanning" , "By initiating a new scan you will save the image list and temporarily clear the image list. Do you want " &
					+ "to continue?", QUESTION!, YESNO! , 2 ) = 1 THEN				
				
				PARENT.wf_savechanges( )
				
				if (dw_imagelist.acceptText ( ) <> -1 ) THEN
					IF lb_Continue = TRUE THEN
						wf_ResetWindow ( ) 
					END IF
				ELSE
					lb_Continue = FALSE
				END IF
			
		ELSE
			
			lb_Continue = FALSE
			
		END IF
		
	END IF
		
		
	IF lb_Continue THEN	
		
		PARENT.wf_GetIDarray ( lla_ID )
		ll_ActiveID = wf_GetImageID ( ) 
		ls_Topic = wf_gettopic ( ) 
		ls_Context = wf_GetContext ( )
		
		ll_ActiveID = wf_GetImageID ( ) 
		wf_GetIDarray ( lla_ID )
		
		li_Return = lnv_ImageManager.of_Scan ( lla_ID , ll_ActiveID , ls_Topic  , ls_Context, ole_scan.object)
	
		IF li_Return > 0 THEN
			ddlb_topic.Text = Upper ( ls_Topic )
		END IF
		
		
	
		IF li_Return = 2 OR lnv_privileges.of_hasImageChangingRights  ( ) THEN
			dw_imagelist.Object.Image_ID.Protect = 0
		ELSEIF li_Return = 1 THEN //AND ( Not lnv_privileges.of_CanChangeImageID  ( ) )THEN
			dw_imagelist.Object.Image_ID.Protect = 1
		END IF
		
		IF li_Return = -1 THEN
		//	messageBox("New Scan" , "An error occured while attempting to scan a new document.",STOPSIGN! )
		END IF
		
	END IF
//ELSE
//	MessageBox('Information','Scanning new images to archive TMPs not allowed')
//END IF
IF lb_Continue THEN
	dw_Imagelist.GetFullstate( lblb_State )
	dw_1.SetFullState( lblb_State )
	
	dw_1.Setuilink( FALSE )

END IF

DESTROY lnv_ImageManager
end event

type cb_rotate from u_cb within w_imaging
integer x = 283
integer y = 1612
integer width = 265
integer height = 76
integer taborder = 70
boolean bringtotop = true
string text = "&Rotate"
end type

event clicked;INT	li_CurrentPage
Long	ll_Pos

IF Long (sle_rotate.text  ) < 0 OR Long (sle_rotate.text  ) > 360 THEN
	MessageBox ( "Degrees of Rotation" , "Please enter a positive value less than 360 degrees.")
ELSEIF Long (sle_rotate.text  ) = 0 THEN
	
ELSEIF IsValid ( Inv_Image ) THEN
	ll_pos = hsb_zoom.position
	Parent.wf_getimagingcontrol( ).Zoom ( 1 ) 
	Parent.wf_getimagingcontrol( ).Rotate ( sle_rotate.text )
	li_CurrentPage = wf_GetCurrentPage ( )
	inv_image.of_SaveRotation ( li_CurrentPage , Long ( sle_rotate.text ) )
	hsb_zoom.EVENT Moved ( ll_pos )
	hsb_zoom.position = ll_pos
	sle_rotate.text = "0"
END IF
end event

type gb_1 from u_gb within w_imaging
integer x = 2025
integer y = 12
integer width = 695
integer height = 188
integer taborder = 0
integer weight = 700
fontcharset fontcharset = ansi!
long backcolor = 12632256
string text = "Image &Topic"
end type

type st_pageno from u_st within w_imaging
integer x = 1765
integer y = 1612
integer width = 261
integer height = 68
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "0 of 0"
end type

type st_5 from u_st within w_imaging
integer x = 1614
integer y = 1616
integer width = 142
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "Page"
end type

type cb_prevpage from u_cb within w_imaging
integer x = 1134
integer y = 1608
integer width = 215
integer height = 76
integer taborder = 90
boolean bringtotop = true
string text = "&<<"
end type

event clicked;wf_ViewPrev ( )
end event

type cb_nextpage from u_cb within w_imaging
integer x = 1371
integer y = 1608
integer width = 215
integer height = 76
integer taborder = 100
boolean bringtotop = true
string text = ">&>"
end type

event clicked;

wf_ViewNext ( )
end event

type sle_rotate from u_sle within w_imaging
event processkey pbm_dwnkey
integer x = 41
integer y = 1612
integer width = 187
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "0"
end type

event rbuttondown;call super::rbuttondown;Parent.wf_displayimage( PARENT.wf_getimage( ) )
end event

type st_2 from u_st within w_imaging
integer x = 229
integer y = 1588
integer width = 55
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "o"
end type

type cb_barcode from u_cb within w_imaging
boolean visible = false
integer x = 2030
integer y = 1736
integer width = 558
integer height = 76
integer taborder = 0
boolean bringtotop = true
string text = "Process &Barcodes"
end type

event clicked;Long		ll_RowCount
String	ls_Topic
Boolean	lb_DeleteLeftovers = TRUE
Int 		i

n_cst_beo_ImageType	lnv_Imagetype
n_cst_Beo_Image		lnva_Images[]

n_cst_bso_imageManager_pegasus lnv_manager
lnv_manager = create n_cst_bso_imageManager_pegasus

// To be included in the next version .
/*
ll_RowCount = dw_imagelist.RowCount ( )
IF ll_RowCount > 0 THEN
	
	For i = 1 TO ll_RowCount
		
		lnv_Manager.of_ProcessBarcodes( lnv_ImageType ,  {dw_imagelist.inv_UILink.GetBeo ( i )} , ole_barcode.object , wf_getimagingcontrol( ))	
		dw_imagelist.inv_UILink.refreshFromBCM ( )
	Next
	
ELSE
	MessageBox ( "Process Barcodes" , "There are no images to process" )
	
END IF
*/
messageBox("Process Barcodes" , "barcode functionality is not supported in this version of Profit Tools.")

DESTROY lnv_manager




end event

type ddlb_topic from u_ddlb within w_imaging
integer x = 2057
integer y = 80
integer width = 635
integer taborder = 0
boolean bringtotop = true
boolean allowedit = true
string item[] = {"SHIPMENT","UNKNOWN"}
end type

event getfocus;call super::getfocus;IF dw_imagelist.RowCount () > 0 THEN

	IF MessageBox ( "Changing Topic", "By changing the topic you will reset the image list and lose any images without assigned Tmp numbers. Do you want to continue?",QUESTION! , YESNO!, 2 ) = 2 THEN
		dw_imagelist.setfocus ( )
		
	END IF
	
END IF
end event

event selectionchanged;wf_SetTopic ( THIS.Text )
dw_imagelist.Reset( )
end event

type cb_delete from u_cb within w_imaging
integer x = 2619
integer y = 1608
integer width = 430
integer height = 76
integer taborder = 40
boolean bringtotop = true
string text = "&Delete Image"
end type

event clicked;IF MessageBox ( "Delete Image" , "Are you sure you want to delete the entire image?", Question! , YESNO! , 2 ) = 1 THEN
	PARENT.wf_Deleteimage( )
END IF
end event

type hsb_zoom from u_hsb within w_imaging
integer x = 46
integer y = 1756
integer width = 960
integer height = 48
integer taborder = 110
boolean bringtotop = true
boolean stdheight = false
integer minposition = 1
integer maxposition = 400
integer position = 200
end type

event moved;Parent.wf_getimagingcontrol( ).Zoom ( ( scrollpos / 2 ) / 100  ) 
end event

event pageleft;
This.Position -= 25

Event Moved ( This.Position )
end event

event pageright;This.Position += 25

Event Moved ( This.Position )
end event

event lineleft;This.Position -= 2

Event Moved ( This.Position )
end event

event lineright;This.Position += 2

Event Moved ( This.Position )
end event

type st_3 from u_st within w_imaging
integer x = 50
integer y = 1700
integer width = 233
integer height = 56
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 12632256
string text = "Zoom out"
end type

type st_4 from u_st within w_imaging
integer x = 814
integer y = 1700
integer width = 192
integer height = 56
boolean bringtotop = true
long backcolor = 12632256
string text = "Zoom in"
end type

type cb_1 from u_cb within w_imaging
integer x = 1605
integer y = 1728
integer width = 311
integer height = 76
integer taborder = 130
boolean bringtotop = true
string text = "Sa&ve As"
end type

event clicked;//ole_image7.Object.MenuAddItem( 1 , 0 , 99 , 0 , "RICK" , 1 , 2 )
//ole_image7.Object.MenuAddItem( 1 , 0 , 101 , 1 , "Zacher" , 1 , 2 )
//ole_image7.object.MenuSetItemChecked ( 1 , 0 , 101 , 1 , TRUE , FALSE)


//(
//
//long menuType
//
//long tool
//
//long topMenuID,
//
//long subMenuID,
//
//String menuText,
//
//long user1,
//
//long user2
//
//);
//RETURN


String	ls_FilePath
String 	rfileName
String	ls_SourcePath

n_cst_FileSrv lnv_FileSrv
lnv_FileSrv = Create n_cst_FileSrv
n_cst_beo_Image	lnv_image



lnv_Image = wf_GetImage ( )
IF Not IsNull ( lnv_image ) AND IsValid ( lnv_Image ) Then
	ls_FilePath = lnv_image.of_GEtFilePath (  )
	ls_SourcePath = ls_FilePath
	ls_FilePath = "C:\untitled"
	GetFileSaveName ( "Save As", ls_FilePath , rfilename , ".tif" , "TIF Files (*.tif),*.tif"    )
	
	
 lnv_FileSrv.of_FileCopy ( ls_SourcePath , ls_FilePath , TRUE )
	
	
END IF


DESTROY lnv_FileSrv
end event

type cb_2 from commandbutton within w_imaging
integer x = 1134
integer y = 1728
integer width = 453
integer height = 76
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Window Size"
end type

event clicked;wf_ChangeSize ( )

end event

type cbx_showexternal from checkbox within w_imaging
integer x = 2391
integer y = 1744
integer width = 1074
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Display external exception messages"
boolean lefttext = true
end type

type mle_clipboard from u_mle within w_imaging
integer x = 2775
integer y = 72
integer width = 681
integer height = 124
integer taborder = 10
boolean bringtotop = true
boolean autohscroll = true
end type

event modified;clipboard(This.text)
st_clipboard.text = "Clipboard *"

end event

type st_clipboard from u_st within w_imaging
integer x = 2779
integer y = 16
integer height = 56
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
long backcolor = 12632256
string text = "Clipboard"
end type

type pb_arrow from picturebutton within w_imaging
integer x = 50
integer y = 56
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "ArrowBlack.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;ole_image7.Object.ToolSet ( 0 , 1, 0 ) 
end event

type pb_zoomin from picturebutton within w_imaging
integer x = 50
integer y = 216
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Zoomin.bmp"
boolean map3dcolors = true
end type

event clicked;ole_image7.Object.ToolSet ( 1 , 1, 0 ) 
end event

type pb_zoomout from picturebutton within w_imaging
integer x = 50
integer y = 376
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Zoomout.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;ole_image7.Object.ToolSet ( 2 , 1, 0 ) 
end event

type pb_zoomselected from picturebutton within w_imaging
integer x = 50
integer y = 536
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "ZoomSelect.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;ole_image7.Object.ToolSet ( 3 , 1, 0 ) 
end event

type pb_grab from picturebutton within w_imaging
integer x = 50
integer y = 696
integer width = 165
integer height = 144
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "grabimage.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;ole_image7.Object.ToolSet ( 4 , 1, 0 ) 
end event

type gb_menu from groupbox within w_imaging
integer x = 23
integer y = 4
integer width = 219
integer height = 1576
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type pb_zoombestfit from picturebutton within w_imaging
integer x = 50
integer y = 852
integer width = 165
integer height = 144
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "StrechImage.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;//ib_bestfit = TRUE
//THIS.Visible = FALSE
//p_bestfitdown.Visible = TRUE
ole_image7.object.ZoomToFit ( 2 )
end event

type ole_image7 from olecustomcontrol within w_imaging
event click ( )
event dblclick ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event keyup ( integer keycode,  integer shift )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event notify ( )
event progress ( long imageid,  long operationid,  long bytesprocessed,  long totalbytes,  long pctdone,  boolean bdone,  boolean basync,  long ocx_error )
event oledragover ( any data,  integer format,  long effect,  long shift,  integer ocx_x,  integer ocx_y,  long state )
event oledragdrop ( any data,  integer format,  long effect,  long button,  long shift,  integer ocx_x,  integer ocx_y )
event scroll ( integer bar,  integer action )
event timertick ( )
event cb ( integer id,  integer cbid )
event imagestatuschanged ( integer id,  integer eopid,  long lstatus )
event menuselect ( integer menu,  integer tool,  long topmenuid,  long submenuid,  long user1,  long user2 )
event toolbarselect ( integer tool,  long user1,  long user2 )
event tooluse ( integer tool,  integer action,  long ocx_x,  long ocx_y )
integer x = 270
integer y = 24
integer width = 1618
integer height = 1560
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_imaging.win"
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event menuselect(integer menu, integer tool, long topmenuid, long submenuid, long user1, long user2);//PArent.wf_SaveMenuSettings ( Topmenuid , Submenuid )  // not used at this point

end event

type ole_scan from olecustomcontrol within w_imaging
event feederempty ( long pagenumber,  boolean stopscan )
event status ( long percent )
event beforescan ( long pagenumber )
event afterscan ( long pagenumber )
integer x = 1234
integer y = 344
integer width = 146
integer height = 128
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_imaging.win"
integer binaryindex = 1
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event externalexception;action = ExceptionIgnore!


IF cbx_showexternal.Checked THEN
	IF Pos ( Upper ( Description ), "CANCEL" ) > 0  THEN
		//User cancelled, and debug is off.  Do not display diagnostic message
	ELSE
		MessageBox ( "External Exception: Scanning" , STRING ( description ) + "~r~nCode:"+ String ( exceptioncode) + &
						"~r~n~r~nScanErrorCode: " + String (THIS.Object.ScanErrorCode ) + "~r~nScanErrorString: " + String (THIS.Object.ScanErrorString ) )
	
	END IF
END IF
	
end event

type ole_barcode from olecontrol within w_imaging
boolean visible = false
integer x = 1047
integer y = 344
integer width = 155
integer height = 124
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_imaging.win"
integer binaryindex = 2
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type ole_print from olecustomcontrol within w_imaging
boolean visible = false
integer x = 859
integer y = 344
integer width = 165
integer height = 120
boolean border = false
string binarykey = "w_imaging.win"
integer binaryindex = 3
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type ole_image4 from olecustomcontrol within w_imaging
event click ( )
event dblclick ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event notify ( )
event progress ( integer id,  integer pctdone )
event asyncprogress ( integer id,  long bytesprocessed,  long totalbytes,  boolean done,  long ocx_error )
integer x = 14
integer y = 24
integer width = 1938
integer height = 1560
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_imaging.win"
integer binaryindex = 4
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type dw_1 from u_dw_imagelist within w_imaging
event ue_deleterow ( )
integer x = 2048
integer y = 300
integer width = 1376
integer height = 1292
integer taborder = 20
boolean bringtotop = false
boolean hscrollbar = false
boolean hsplitscroll = false
boolean ib_isupdateable = false
end type

event ue_deleterow();
Long	ll_Row

ll_Row = THIS.getRow( ) 

IF ll_Row > 0 THEN
	This.DeleteRow ( ll_Row )
	dw_Imagelist.DeleteRow ( ll_Row )

	IF THIS.RowCount () > 0 THEN

		//THIS.Post SetRow  ( 1 ) 
		THIS.EVENT RowFocusChanged ( 1 ) 
	END IF
ELSEIF THIS.RowCount ( ) > 0 THEN
	MessageBox ( "Delete Image", "Please select an image to delete." )
END IF


end event

event rowfocuschanged;call super::rowfocuschanged;THIS.SetRow ( currentrow )
dw_imagelist.SetRow ( currentrow )
dw_imagelist.event rowfocuschanged( currentrow )

THIS.SetRedraw ( TRUE ) // off in 'changing
end event

event constructor;call super::constructor;n_cst_Presentation_image	lnv_Presentation
lnv_Presentation.of_SetPresentation ( This )

n_cst_Privileges	lnv_Privileges

ib_disableclosequery = TRUE


THIS.Object.Image_category.protect = 1	

IF lnv_privileges.of_hasImageChangingRights ( ) THEN

	
ELSE
	
	THIS.Object.Image_Type.protect = 1	

END IF 


IF Not lnv_privileges.of_hasImageChangingRights  ( ) THEN
	THIS.Object.Image_ID.Protect = 1
END IF


end event

event ue_companylist;call super::ue_companylist;//OVER RIDE
dw_Imagelist.event ue_companylist( )


end event

event ue_copyimage;//override
dw_Imagelist.event ue_copyimage( )
end event

event ue_emailimage;//override
dw_Imagelist.event ue_emailimage( )
end event

event rowfocuschanging;call super::rowfocuschanging;THIS.SetRedraw( FALSE )
end event

event ue_savelist;call super::ue_savelist;RETURN PARENT.wf_savechanges( )
end event

event ue_addtotransferqueue;call super::ue_addtotransferqueue;dw_Imagelist.of_Addtransferrequest( )
end event

event ue_getimageid;call super::ue_getimageid;RETURN Parent.wf_getimageid( )
end event

type dw_imagelist from u_dw_imagelist within w_imaging
event ue_deleterow ( )
event ue_deleteunknown ( )
event ue_deletenotype ( )
integer x = 2048
integer y = 300
integer width = 1376
integer height = 1292
integer taborder = 0
boolean bringtotop = false
boolean hscrollbar = false
boolean hsplitscroll = false
end type

event ue_deleterow();
Long	ll_Row

ll_Row = THIS.getRow( ) 

IF ll_Row > 0 THEN
	This.DeleteRow ( ll_Row )

	IF THIS.RowCount () > 0 THEN
		THIS.EVENT RowFocusChanged ( 1 ) 
	END IF
ELSEIF THIS.RowCount ( ) > 0 THEN
	MessageBox ( "Delete Image", "Please select an image to delete." )
END IF


end event

event ue_deleteunknown;Int	i
n_cst_beo_image	lnv_Image


For i = 1 TO dw_imagelist.RowCount ( )
	lnv_Image =	dw_imagelist.inv_UILink.getBeo( i )
	IF lnv_Image.of_GetID ( ) > 0 THEN
		CONTINUE
	ELSE
		
		FileDelete( lnv_Image.of_GetFilePath ( ) )
	END IF
	
NEXT
end event

event ue_deletenotype;//RDT 7-29-03 Deletes all images that have a type of "NONE"
Int	i
n_cst_beo_image	lnv_Image

For i = 1 TO dw_imagelist.RowCount ( )
	lnv_Image =	dw_imagelist.inv_UILink.getBeo( i )
	
	IF lnv_Image.of_GetType() = "NONE" THEN
		FileDelete( lnv_Image.of_GetFilePath ( ) )
	END IF
	
NEXT
end event

event rowfocuschanged;call super::rowfocuschanged;Long	ll_SelectedRow
Long 	ll_ShipmentId

n_cst_beo_image   	lnv_Beo
n_cst_bso_ImageManager_Pegasus	lnv_ImageManager_Pegasus
lnv_ImageManager_Pegasus = create n_cst_bso_ImageManager_Pegasus

ll_SelectedRow = currentrow
if ll_SelectedRow > 0 AND ib_ProcessRowChange then 
//	THIS.SetRow ( ll_SelectedRow )
	lnv_beo = inv_uilink.getBeo( ll_SelectedRow )
	IF IsValid ( lnv_beo ) THEN
		
		dw_1.SelectRow ( ll_SelectedRow , TRUE  )
		THIS.SelectRow ( ll_SelectedRow, TRUE )	
		
		lnv_ImageManager_Pegasus.of_DisplayImage ( lnv_Beo , 1 , wf_getimagingcontrol( ) )
	END IF
END IF

parent.wf_checkPrivs()

DESTROY lnv_ImageManager_Pegasus

end event

event constructor;call super::constructor;n_cst_Privileges	lnv_Privileges
n_cst_Presentation_image	lnv_Presentation

lnv_Presentation.of_SetPresentation ( This )
ib_disableclosequery = TRUE

n_cst_msg	lnv_msg

lnv_msg = message.powerobjectparm

PARENT.wf_setmessage ( lnv_msg )

THIS.Object.Image_category.protect = 1	

IF lnv_privileges.of_hasImageChangingRights ( ) THEN

	
ELSE
	
	THIS.Object.Image_Type.protect = 1	

END IF 


IF Not lnv_privileges.of_hasImageChangingRights  ( ) THEN
	THIS.Object.Image_ID.Protect = 1
END IF


end event

event ue_printimage;Long	lla_SelectedRows []
Long	i
Int	li_PrintError
Long	ll_SelectedCount
Long	ll_PageCount

n_cst_msg	lnv_msg
s_Parm		lstr_Parm
n_cst_Beo_Image lnv_Image

ll_SelectedCount = inv_rowselect.of_SelectedCount (  lla_SelectedRows [] ) 

ole_print.object.Orientation = 1

IF ll_SelectedCount > 0 THEN
	
	ole_print.object.PdRangeEnable = 0
	
	IF ll_SelectedCount = 1 THEN // we will enable the user to indicate a specific range to print
		lnv_Image = This.inv_UILink.GetBeo ( lla_selectedRows [ 1 ] )
		IF IsValid ( lnv_Image ) THEN		
			ll_PageCount = lnv_Image.of_CalcPages ( wf_getimagingcontrol( ) )
			ole_print.object.PdRangeEnable = 1
			ole_print.object.PdMaxPage = ll_PageCount
		END IF		
	END IF
	
	ole_print.object.PrintDialog()
	
	li_PrintError = ole_print.object.printError 
	IF li_PrintError = -3005 THEN  // user canceled
		 ll_SelectedCount = 0 // skip the loop
	END IF
	
	For i = 1 TO  ll_SelectedCount	
	
		lnv_Image = This.inv_UILink.GetBeo ( lla_selectedRows [ i ] )
		
		lstr_Parm.is_Label = "SETTINGS"
		lstr_Parm.ia_Value = ole_print.object
		lnv_msg.of_Add_Parm (lstr_Parm )
		
		lnv_Image.of_Print ( ole_print.object , wf_getimagingcontrol( ) , lnv_msg)
		
	NEXT
	
END IF
end event

event pfc_update;// override
RETURN PARENT.wf_Savechanges( )
end event

type gb_3 from u_gb within w_imaging
integer x = 2021
integer y = 220
integer width = 1440
integer height = 1496
integer taborder = 0
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "Image List"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
09w_imaging.bin 
2800000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffe00000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000ecadb20001c7419400000003000004000000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a0000000200000001000000046d3cf4f346e7c2f3533e26a1916b2a1000000000ecac2b6001c74194ecadb20001c74194000000000000000000000000fffffffe00000002000000030000000400000005000000060000000700000008000000090000000a0000000b0000000c0000000d0000000e0000000ffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00650050006100670075007300200073006d004900670061006e0069000000670000476800000000000039a20000000000003a2e0000000000003abc0000000000420008003600000041004400320033003500300045003100430038003400430042003000320031003700320032004100300043003200450039003500330039003400320000004522c57622f8ec93c5000100030710000024960000284f000000080000000000020003000000000005c0c00013000b00c00009ffff0be3520311ce8f91aa00e39d51b84b0000000001424402bc4d0d0001615320535320736e666972650000000900000000000000000000000000130000000000000000001300090000000000000000000000000000000000000000000b00000003000b0000000bffff000b0000000b0000000b0000000b000000030000000000000000000bffff000b0000000300030000000000000000000300030000000000030000000b0000000b00000003000b0000000b00000008000000000002000200000002000a0003000a0000000200010003000300000000000100010003000300000000000d00000003000b00000003ffff0000000a000100030003000000000000ffff000b00030003000300000000000a00010003000300000000000000020008000000000000000300030000000000000001000300030000000000010000000b00000003006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000038c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030000000000000000000300030000000000000000000bffff000b00000003000300000000000000000003000b0000000b00000003000000000000ffff000b00010003000b0000000bffff000bffff0003ffff000027100000000b0000000300080000000000020003000000000000ffff000b0002000800000000000200080000000000020008000000000002000800000000000000030003000000000000000000030003000000000000ffff000b0000000b00000003000b0000000b0000000300000000000000020008000000000002000800000000000200080000000000010003000300000000000100010003000b000000030000000000040000000300030000000000000000000b000000030003000000000000000100030003000000000001000a000300030000000000000000000200000003000300000000000000000003000300000000000000000003000300000000000000000003000b00000003000000000000000100020000000b0000000b0000000b00000003000300000000000000000003000b0000000b00000003000000000000000000030002000000020000000b00000003ffff0000000000000002000000050000000000023ff0000b00ff0003000000000000003a00340030003100000020003400310033003a003a003500360035005a00200043004d00670000006c005f00760069006c006500000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000ecadb20001c7419400000003000001000000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004a57b568011d236cac0007fbd7b2a57d100000000ecadb20001c74194ecadb20001c74194000000000000000000000000fffffffe0000000200000003fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00650050006100670075007300200073006f005300740066006100770065007200530020006100630058006e007200700073006500200073003100560030002e002e000800550000004e0044003000330057003000470030005000450048002d0033004200310030004e0045005300430000005022c57622dd980f80000003000000034f0000034f0000000b000200080000000000040003000800000000000200080000000000020008000000000002000b0000000b0000000b0000000b0001000b000000000000000056ae000000000000551a00000000000055ac00000000000057b2000000000000563400000000000051f60000000000005276000000000000530c00000000000050f6000000000000517a00000000000047ec000000000000487e000000000000490000000000000049820000000000004a0a0000000000004a9e0000000000004b2c0000000000004ba60000000000004c24
220000000000004ca60000000000004d340000000000004dc00000000000004f5a0000000000004ff00000000000004e4c000000000000506c0000000000004ed40000000000005dc20000000000005e58000000000000583a00000000000058c2000000000000594600000000000059dc0000000000005a660000000000005aec0000000000005b700000000000005bf60000000000005c900000000000005d2a00000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000100000086000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
290000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000ecadb20001c7419400000003000001c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000003c0000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a00000002000000010000000498958ef211d19c756000fe9c14733a0800000000ecadb20001c74194ecadb20001c74194000000000000000000000000fffffffe0000000200000003000000040000000500000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00650050006100670075007300200073006f005300740066006100770065007200500020006900720074006e005200500020004f002e0031003000300030002e005e0008004900000041004a00420045004f004d004c004e004e004200500046004e004b004e004c004800420044004e004a004e004d0042004c0046004a00440050004900500047004b0041004f004e0043005000490047004b0044004900440000004f22c57622e365fb2400000202000003b90000031a0001000b000000030013000000ffffff00000003000400004370000000000004000443b4437000000024000800500000006900720074006e005200500020004f006f0044007500630065006d0074006e000300000000000d0001000300020000001300010000000000010003001300000000000000000004000343b40000000100000004000b4370000900010be3520311ce8f91aa00e39d51b84b0000000001388002bc4d0d0001615320535320736e6669726500000009000000000000000000000000000b0000000800010000000200000000000000000000506c0000000000004ed40000000000005dc20000000000005e58000000000000583a00000000000058c2000000000000594600000000000059dc0000000000005a660000000000005aec0000000000005b700000000000005bf60000000000005c900000000000005d2a00000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000014a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffe00000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000ecadb20001c7419400000003000002400000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a0000000200000001000000043c98538e11d36a9aa0fcfba82d72716d00000000ecadb20001c74194ecadb20001c74194000000000000000000000000fffffffe00000002000000030000000400000005000000060000000700000008fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00650050006100670075007300200073006f0053007400660061007700650072004900200061006d00580067007200700073006500200073003400560030002e002e00080039000000320059003000370053003000470030005000450058002d003300420034003000500041004500580000005022c57622e365fb2400010003030000002bd20000284f0000000800000000000000000009000000000000000000000000000300000000000000000009000000000000000000000000000900000be3520311ce8f91aa00e39d51b84b0000000001424402bc4d0d0001615320535320736e66697265ffff000b000f0013000380000000000500000003000300000000000100030003000200000002000a000b00010003000000000000ffff000b0000000b00000003000b0000000800000000000000000008000800000000000000020008000000000000000b0000000bffff000b00000002000000020000000300030000000000030000000b0000000b0000000b0000000b0000000b00000013000800000000000000000008000800000000000000000008000b000000030000000000000000000300030000000000000000000300020000000b0000000b0000000bffff0002ffff0002001900030023000000000001000300020000001300010000000000010003000300000000000d00000003000b00000002000000020000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000001000001d400000000
200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000002000100030001000000000000000b00130378ffff000b00000003000300000000000000000003000b0000000b00000003000000000000ffff000b00010003000b0000000bffff000bffff0003ffff000027100000000b0000000300080000000000020003000000000000ffff000b0002000800000000000200080000000000020008000000000002000800000000000000030003000000000000000000030003000000000000ffff000b0000000b00000003000b0000000b0000000300000000000000020008000000000002000800000000000200080000000000010003000300000000000100010003000b000000030000000000040000000300030000000000000000000b000000030003000000000000000100030003000000000001000a000300030000000000000000000200000003000300000000000000000003000300000000000000000003000300000000000000000003000b00000003000000000000000100020000000b0000000b0000000b00000003000300000000000000000003000b0000000b00000003000000000000000000030002000000020000000b00000003ffff0000000000000002000000050000000000023ff0000b00ff0003000000000000003a00340030003100000020003400310033003a003a003500360035005a00200043004d00670000006c005f00760069006c00650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19w_imaging.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
