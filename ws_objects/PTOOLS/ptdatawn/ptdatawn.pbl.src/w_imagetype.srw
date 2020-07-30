$PBExportHeader$w_imagetype.srw
$PBExportComments$ImageType (Window from PBL map PTData) //@(*)[45283711|996]
forward
global type w_imagetype from w_response
end type
type dw_imagetypelist from u_dw_imagetypelist within w_imagetype
end type
type st_1 from u_st within w_imagetype
end type
type ddlb_id from u_ddlb within w_imagetype
end type
type cb_1 from u_cbok within w_imagetype
end type
type cb_2 from u_cbcancel within w_imagetype
end type
type st_2 from u_st within w_imagetype
end type
type st_3 from u_st within w_imagetype
end type
type rb_single from u_rb within w_imagetype
end type
type rb_batch from u_rb within w_imagetype
end type
type gb_2 from groupbox within w_imagetype
end type
type gb_3 from u_gb within w_imagetype
end type
type gb_1 from u_gb within w_imagetype
end type
type cbx_selectscanner from u_cbx within w_imagetype
end type
type cbx_settings from u_cbx within w_imagetype
end type
type rb_flatbed from u_rb within w_imagetype
end type
type rb_feeder from u_rb within w_imagetype
end type
type cb_savesettings from u_cb within w_imagetype
end type
type ddlb_source from dropdownlistbox within w_imagetype
end type
type cbx_multipage from checkbox within w_imagetype
end type
type rb_noimagetype from u_rb within w_imagetype
end type
end forward

global type w_imagetype from w_response
integer x = 197
integer y = 512
integer width = 1417
integer height = 1760
string title = "Scan Image"
long backcolor = 12632256
dw_imagetypelist dw_imagetypelist
st_1 st_1
ddlb_id ddlb_id
cb_1 cb_1
cb_2 cb_2
st_2 st_2
st_3 st_3
rb_single rb_single
rb_batch rb_batch
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
cbx_selectscanner cbx_selectscanner
cbx_settings cbx_settings
rb_flatbed rb_flatbed
rb_feeder rb_feeder
cb_savesettings cb_savesettings
ddlb_source ddlb_source
cbx_multipage cbx_multipage
rb_noimagetype rb_noimagetype
end type
global w_imagetype w_imagetype

type variables
public:
String		is_FilterTopic
n_cst_msg	inv_msg
string		is_Action


end variables

forward prototypes
function any gettaskattribute (String as_name)
function integer settaskattribute (String as_name, n_cst_parameters anv_parameters)
public function integer wf_setmsg (n_cst_msg anv_msg)
public function n_cst_msg wf_getmsg ()
public function long wf_resolvesource (string as_Text)
public function boolean wf_validatetmpselection (long al_tmpid)
public function integer wf_getdivision (long al_tmpid)
end prototypes

function any gettaskattribute (String as_name);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>
Any la_null


Return la_null
//@(text)--

end function

function integer settaskattribute (String as_name, n_cst_parameters anv_parameters);//@(*)[]<nosync>//@(-)Do not edit, move or copy this line//
//@(text)(recreate=yes)<Attributes>

Return 1
//@(text)--

end function

public function integer wf_setmsg (n_cst_msg anv_msg);inv_msg = anv_msg

Return 1
end function

public function n_cst_msg wf_getmsg ();RETURN inv_msg
end function

public function long wf_resolvesource (string as_Text);Long	ll_rtn
CHOOSE CASE UPPER (as_Text)
		
	CASE "ADF"
		ll_rtn = 0
	CASE "TRANSPARENCY"
		ll_rtn = 1
	CASE "FLATBED"
		ll_rtn = 2
	CASE "FEEDER"
		ll_rtn = 3
   CASE "DUPLEX"
		ll_rtn = 4
	CASE "BACK-FRONT"
		ll_rtn = 5
	CASE "BACK ONLY"
		ll_rtn = 6
END CHOOSE

RETURN ll_rtn
end function

public function boolean wf_validatetmpselection (long al_tmpid);Boolean lb_RtnVal
String ls_ErrMsg
Int	li_Status
Int	li_RtnVal

n_cst_bso_ImageManager lnv_ImageManager
lnv_ImageManager = Create n_cst_bso_ImageManager

li_Status = lnv_ImageManager.of_Gettmparchivestatus( al_tmpid ) 

IF li_Status = -1 THEN // archived
	li_RtnVal = 1
	ls_ErrMsg = "The specified shipment has had its images archived. ~r~nrequest cancelled." 
	MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg)
ELSEIF li_Status = -2 THEN// only copied not deleted
	ls_ErrMsg = "The specified shipment has had its images copied to be archived. By continuing you will have to recopy the shipment range to include this in the archive. Are you sure you want to do this?"
	IF MessageBox(lnv_ImageManager.cs_ErrMsgHeader,ls_ErrMsg,  QUESTION! , YESNO!, 2 ) = 2 THEN
		li_RtnVal = 1
	END IF
ELSE
	// let the change happen
END IF

Destroy(lnv_ImageManager)

lb_RtnVal = li_RtnVal = 1 
	
Return lb_RtnVal


end function

public function integer wf_getdivision (long al_tmpid);//written by dan 5-4-2006 to return the division of the shipment( or possibly other types )
//associated with this image.
Long	ll_division
Long	ll_tmpNum
N_cst_shipmentManager lnv_shipmentManager

ll_tmpNum = al_tmpID

ll_division = lnv_shipmentManager.of_getDivision( ll_tmpNum )
	

RETURN ll_division
end function

on w_imagetype.create
int iCurrent
call super::create
this.dw_imagetypelist=create dw_imagetypelist
this.st_1=create st_1
this.ddlb_id=create ddlb_id
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.st_3=create st_3
this.rb_single=create rb_single
this.rb_batch=create rb_batch
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.cbx_selectscanner=create cbx_selectscanner
this.cbx_settings=create cbx_settings
this.rb_flatbed=create rb_flatbed
this.rb_feeder=create rb_feeder
this.cb_savesettings=create cb_savesettings
this.ddlb_source=create ddlb_source
this.cbx_multipage=create cbx_multipage
this.rb_noimagetype=create rb_noimagetype
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_imagetypelist
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_id
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.rb_single
this.Control[iCurrent+9]=this.rb_batch
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.cbx_selectscanner
this.Control[iCurrent+14]=this.cbx_settings
this.Control[iCurrent+15]=this.rb_flatbed
this.Control[iCurrent+16]=this.rb_feeder
this.Control[iCurrent+17]=this.cb_savesettings
this.Control[iCurrent+18]=this.ddlb_source
this.Control[iCurrent+19]=this.cbx_multipage
this.Control[iCurrent+20]=this.rb_noimagetype
end on

on w_imagetype.destroy
call super::destroy
destroy(this.dw_imagetypelist)
destroy(this.st_1)
destroy(this.ddlb_id)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rb_single)
destroy(this.rb_batch)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.cbx_selectscanner)
destroy(this.cbx_settings)
destroy(this.rb_flatbed)
destroy(this.rb_feeder)
destroy(this.cb_savesettings)
destroy(this.ddlb_source)
destroy(this.cbx_multipage)
destroy(this.rb_noimagetype)
end on

event open;call super::open;//@(data)(recreate=yes)<Parameters>
//@(data)--

//@(data)(recreate=yes)<Links>
Setlinkage(TRUE)
//@(data)--

//@(data)(recreate=yes)<GenerationOptions>
of_SetResize(TRUE)
SetTransactionManagement(TRUE)
inv_txsrv.SetLoadUpdateList(TRUE)
//@(data)--

//@(text)(recreate=yes)<RetrieveNoArgs>
inv_Linkage.Retrieve ( dw_ImageTypeList )
//@(text)--

//@(text)(recreate=yes)<resizevalues>
inv_resize.of_SetMinSize(1300, 400)
inv_resize.of_Register (dw_imagetypelist, 'ScaleToRight')
//@(text)--


//---

Long			lla_IDs[]
Long			ll_ActiveID
Int			i
String		ls_Topic
String		ls_Context
String		ls_Result
String		ls_IniFile

n_cst_msg	lnv_Msg
S_parm		lstr_Parm

lnv_Msg = wf_GetMsg ( )

ls_IniFile = gnv_app.of_GetAppIniFile ( )

rb_single.Checked = TRUE

rb_Feeder.Checked = TRUE

IF IsValid ( lnv_msg ) THEN
	
	IF lnv_Msg.of_Get_Parm ( "IDARRAY" , lstr_Parm )  <> 0 THEN
		lla_IDs = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "ACTIVEID" , lstr_Parm )  <> 0 THEN
		ll_ActiveID = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "TOPIC" , lstr_Parm )  <> 0 THEN
		ls_Topic = lstr_Parm.ia_Value
	END IF
	
	IF lnv_Msg.of_Get_Parm ( "CONTEXT" , lstr_Parm )  <> 0 THEN
		ls_context = lstr_Parm.ia_Value
	END IF
	
	
	
	IF NOT ls_Context = "UNKNOWN"  AND ls_Topic <> "KNOWN" THEN
		
		rb_single.Checked = TRUE
		dw_imagetypelist.SetFilter("imagetype_topic = '"+ls_Topic+" '")	
		dw_imagetypelist.Filter ( )
	ELSE
		cbx_multipage.Checked = FALSE
		cbx_multipage.Enabled = FALSE
		rb_batch.Checked = TRUE
		ddlb_id.Enabled = FALSE
		dw_imagetypelist.SetFilter("")	
		dw_imagetypelist.Filter ( )
		ll_activeId = 0
	
	END IF
	
	FOR i = 1 TO UpperBound ( lla_Ids )
	
		ddlb_id.AddItem ( String (lla_Ids[ i ] ,"000") )
	NEXT
 
//	If lla_ids[1] = 0 then 								//RDT 7-29-03
//		rb_noimagetype.Enabled = FALSE				//RDT 7-29-03
//	End if													//RDT 7-29-03

	ddlb_ID.text = String ( ll_ActiveID ,"000")

END IF

ddlb_source.TEXT  = "ADF"

ls_Result =  ProfileString ( ls_IniFile, "scan settings", "source" , "" )
IF ls_Result = "FLATBED" THEN
	rb_flatbed.checked = TRUE
END IF

ls_Result =  ProfileString ( ls_IniFile, "scan settings", "settings" , "" )
IF ls_Result = "TRUE" THEN
	cbx_settings.Checked = TRUE
END IF

ls_Result =  ProfileString ( ls_IniFile, "scan settings", "select scanner" , "" )
IF ls_Result = "TRUE" THEN
	cbx_selectscanner.Checked = TRUE
END IF





	



end event

event pfc_default;//RDT 7-29-03 UNknown Image Type
Long			ll_Row
Long			ll_SelectedID

Boolean		lb_KnownID
Boolean		lb_Settings  // display settings dialog
Boolean		lb_SelectScanner // display scanner select dialog
Boolean		lb_Feeder
Boolean		lb_Continue = TRUE
String		ls_topic, ls_type , ls_Cat
Long			ll_division

n_cst_shipmentManager	lnv_shipmentManager
n_cst_privsManager	lnv_privsManager
n_cst_Beo_ImageType 	lnv_ImageType

n_cst_msg 	lnv_msg
s_parm 		lstr_parm 

ll_SelectedID = Long ( ddlb_id.Text	 )


lnv_privsManager = gnv_app.of_getprivsmanager( ) //create n_cst_privsManager		//replace with global

// IF rb_single.Checked THEN //RDT 7-29-03
IF rb_single.Checked OR rb_NoImageType.Checked THEN //RDT 7-29-03
	lb_KnownID = TRUE
ELSE
	lb_KnownID = FALSE
END IF

IF lb_KnownID THEN
//// Check to see if this tmpid has been archived
	IF wf_ValidateTmpSelection(ll_SelectedID) THEN
		lb_Continue = FALSE
		ddlb_id.Text = ""
		ddlb_id.SetFocus()
	END IF
	
	//Added By dan 5-5-2006 to check to see if user has permission to can the document for that division
	IF lb_continue THEN
		ll_division = lnv_shipmentManager.of_getDivision( ll_selectedID )
		IF lnv_privsManager.of_getuserpermissionfromfn( lnv_privsManager.cs_scanImage, ll_division ) = 1 THEN
			//has permission
		ELSE
			lb_continue = false
			ddlb_id.Text = ""
			ddlb_id.SetFocus()
		END IF
	END IF
	//--------------------------------
END IF

IF lb_Continue THEN
	
	IF cbx_selectscanner.Checked THEN
		lb_SelectScanner = TRUE
	ELSE
		lb_SelectScanner = FALSE
	END IF
	
	IF cbx_settings.Checked  THEN
		lb_Settings = TRUE
	ELSE
		lb_Settings = FALSE
	END IF
	
	// IF cbx_multipage.Checked OR rb_batch.Checked THEN //RDT 7-29-03
//	IF cbx_multipage.Checked OR rb_batch.Checked OR rb_NoImageType.Checked THEN //RDT 7-29-03
//		lb_Feeder = TRUE
//	ELSE
//		lb_Feeder = FALSE
//	END IF
//	

	lb_Feeder = ddlb_source.Text = "ADF" OR ddlb_source.Text = "FEEDER"
	
	
	
	lstr_Parm.is_Label = "SELECTEDID"
	lstr_Parm.ia_Value = ll_selectedID
	inv_Msg.of_add_parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "KNOWNID"
	lstr_Parm.ia_Value = lb_KnownID
	inv_Msg.of_add_parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "SETTINGS"
	lstr_Parm.ia_Value = lb_Settings
	inv_Msg.of_add_parm ( lstr_Parm ) 
	
	lstr_Parm.is_Label = "SCANNERSELECT"
	lstr_Parm.ia_Value = lb_SelectScanner
	inv_Msg.of_add_parm ( lstr_Parm ) 
		
	lstr_Parm.is_Label = "FEEDER"
	lstr_Parm.ia_Value = lb_Feeder
	inv_Msg.of_add_parm ( lstr_Parm ) 
	
	lstr_parm.is_Label = "CONTINUE"
	lstr_parm.ia_Value = TRUE
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	lstr_parm.is_Label = "SCANSOURCE"
	lstr_parm.ia_Value = wf_ResolveSource ( ddlb_source.Text )
	inv_Msg.of_Add_Parm ( lstr_Parm )
	
	IF rb_NoImageType.Checked Then 														//RDT 7-29-03 
		if ll_SelectedID > 0 then 
	
			lstr_Parm.is_Label = "IMAGETYPE"	 												//RDT 7-29-03 
			lstr_Parm.ia_Value = "NONE"		 												//RDT 7-29-03 
			inv_Msg.of_add_parm ( lstr_Parm ) 	 											//RDT 7-29-03 
			
			lstr_parm.is_Label = "NOIMAGETYPE"		 										//RDT 7-29-03 
			lstr_parm.ia_Value = TRUE	 														//RDT 7-29-03 
			inv_Msg.of_Add_Parm ( lstr_Parm )	 											//RDT 7-29-03 
		
			closeWithReturn ( THIS , inv_Msg )												//RDT 7-29-03 
		else
			MessageBox ( "Tmp. selection" , "Please select a Tmp. Number." )		
		end if
			
	Else	 													 									//RDT 7-29-03 
		ll_Row = dw_imagetypelist.getRow ( ) 
	
		IF ll_Row > 0 THEN
				
			lstr_Parm.is_Label = "IMAGETYPE"
			lstr_Parm.ia_Value = dw_imagetypelist.inv_UIlink.getBeo( ll_Row )
			inv_Msg.of_add_parm ( lstr_Parm ) 
			
			lstr_parm.is_Label = "NOIMAGETYPE"		 										//RDT 7-29-03 
			lstr_parm.ia_Value = FALSE  														//RDT 7-29-03 
			inv_Msg.of_Add_Parm ( lstr_Parm )	 											//RDT 7-29-03 
		
			closeWithReturn ( THIS , inv_Msg )
		Else
			MessageBox ( "Type selection" , "Please select an imagetype." )		
		End IF	 													 								//RDT 7-29-03 
	
	END IF
END IF	


end event

event pfc_cancel;call super::pfc_cancel;n_cst_msg	lnv_msg
S_Parm		lstr_Parm


lstr_Parm.is_Label = "CONTINUE"
lstr_Parm.ia_Value = FALSE
inv_msg.of_add_Parm ( lstr_Parm )

CloseWithReturn ( THIS , lnv_Msg )

end event

event closequery;call super::closequery;s_parm	lstr_parm
	
IF inv_Msg.of_Get_Count ( ) < 3 THEN
	lstr_Parm.is_Label = "CONTINUE"
	lstr_Parm.ia_Value = FALSE
	inv_msg.of_Add_Parm(lstr_Parm)
END IF

Message.PowerObjectParm = inv_msg
  
end event

type cb_help from w_response`cb_help within w_imagetype
integer x = 2450
end type

type dw_imagetypelist from u_dw_imagetypelist within w_imagetype
string tag = ";objectid=[45296747|997]"
integer x = 78
integer y = 376
integer width = 1239
integer height = 516
integer taborder = 10
string dragicon = "Application!"
boolean hscrollbar = false
boolean hsplitscroll = false
end type

on dw_imagetypelist.create
call u_dw_imagetypelist::create
end on

on dw_imagetypelist.destroy
call u_dw_imagetypelist::destroy
end on

event constructor;call super::constructor;//@(data)(recreate=yes)<GenerationOptions>
//@(data)--
n_cst_Msg	lnv_Msg
ib_Rmbmenu = FALSE

n_cst_bcm	lnv_Bcm


gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )

THIS.inv_UILink.setBcm( lnv_Bcm )


THIS.object.ImageType_Type.protect = 1
THIS.object.imageType_Category.protect = 1

THIS.object.imageType_Topic.width = 0
THIS.object.imageType_Topic_t.width = 0

THIS.object.imageType_Type_t.x = 526
THIS.object.imageType_Type.x = 526

THIS.object.imageType_Category_t.x = 9
THIS.object.imageType_Category.x = 9


THIS.object.imageType_Topic.tabsequence = 0


end event

event ue_searchfilteredlist;//Long	ll_RowCount
//Int 	li_Return
//Int 	i
//Long	lula_TmpNum[]
//
// w_imaging.wf_GetidArray ( lula_TmpNum )
//
//n_cst_bso_ImageManager_Pegasus 	lnv_PegasusImage
//lnv_PegasusImage = Create n_cst_bso_ImageManager_Pegasus
//
//n_cst_beo_ImageType  	lnva_ImageType [ ]
//
//
//ll_RowCount = this.RowCount ( ) 
//li_Return = 1
//
//For i = 1 TO ll_RowCount
//
//	lnva_ImageType[ upperBound ( lnva_ImageType ) + 1 ] = This.inv_UILink.GetBeo ( i )
//
//Next
//
//lnv_PegasusImage.of_GetImageList ( lnva_ImageType , lula_TmpNum[], ole_image.object )
//
//Destroy lnv_PegasusImage
end event

type st_1 from u_st within w_imagetype
integer x = 78
integer y = 268
integer width = 219
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "Tmp No:"
end type

type ddlb_id from u_ddlb within w_imagetype
integer x = 297
integer y = 256
integer width = 485
integer height = 420
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 1090519039
boolean allowedit = true
end type

event modified;//RDT 7-29-03
Boolean lb_scanOk
Long 		ll_division
n_Cst_privsManager		lnv_privsManager
n_cst_ShipmentManager	lnv_ShipmentManager

lnv_privsManager = gnv_app.of_getprivsmanager( ) //create n_cst_privsManager

CHOOSE CASE lnv_ShipmentManager.of_ShipmentExists ( Long ( THIS.Text ) )

CASE TRUE
	//Exists
	rb_noimagetype.Enabled = TRUE					//RDT 7-29-03
	
	// Also check to see if this Tmpid has not been archived.
	// zmc - 1-14-04 
	IF wf_ValidateTmpSelection(Long ( THIS.Text )) THEN	
		Return 1
	END IF
	
	//condition added by dan to check privs scanning documents for the shipment tye
	IF isNumber( this.text ) THEN
		ll_division = wf_getDivision( long(this.text) )
		
		IF ll_division > 0 THEN
			IF lnv_privsManager.of_getuserpermissionfromfn( lnv_privsManager.cs_SCANImage, ll_division ) = 1 THEN
				lb_scanOk = true
			ELSE
				lb_scanOk = false
			END IF
		END IF
	ELSE
		lb_scanOk = true
	END IF
	
	IF not Lb_scanOk THEN
		MessageBox("Scan", "You do not have sufficient rights to scan for the current shipment type.", EXCLAMATION! )
		rb_noimagetype.Enabled = FALSE 	
		rb_noimagetype.Checked = FALSE 	
		//this.text = "000"
		THIS.setFocus()
		
	END IF
	//----------------------------------------------------------
	
	
CASE FALSE
	
	MessageBox( "ID Selection" , "The Tmp No. you selected does not exist. Please Try again.")
	rb_noimagetype.Enabled = FALSE				//RDT 7-29-03
	rb_noimagetype.Checked = FALSE 				//RDT 7-29-03
	THIS.SetFocus (  )

	Return 1
	//Does not exist

CASE ELSE
	
	//Error -- Could not determine

END CHOOSE


end event

event selectionchanged;If this.text <> "000" then 
	rb_noimagetype.Enabled = TRUE 		
else
	rb_noimagetype.Enabled = FALSE 	
	rb_noimagetype.Checked = FALSE 	
End if
end event

type cb_1 from u_cbok within w_imagetype
integer x = 192
integer y = 1544
integer width = 233
integer taborder = 80
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_2 from u_cbcancel within w_imagetype
integer x = 471
integer y = 1544
integer width = 233
integer taborder = 70
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type st_2 from u_st within w_imagetype
integer x = 69
integer y = 32
integer width = 1317
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "Select a Tmp No. for the Image as well as an image "
end type

type st_3 from u_st within w_imagetype
integer x = 64
integer y = 92
integer width = 494
boolean bringtotop = true
integer textsize = -9
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 12632256
string text = "type, then click OK."
end type

type rb_single from u_rb within w_imagetype
integer x = 78
integer y = 956
integer width = 1134
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 12632256
string text = "Scan a single document with a known Tmp No."
end type

event clicked;ddlb_id.Enabled = TRUE
cbx_multipage.Enabled = TRUE
dw_imageTypeList.Enabled = TRUE //RDT 7-29-03


end event

type rb_batch from u_rb within w_imagetype
integer x = 78
integer y = 1024
integer width = 1234
boolean bringtotop = true
long backcolor = 12632256
string text = "Scan a batch of documents with unknown Tmp Nos.  "
end type

event clicked;ddlb_id.Text = "000"
ddlb_id.Enabled = FALSE
cbx_multipage.Checked = FALSE
cbx_multipage.ENABLED = FALSE
ddlb_source.Text = "ADF"

dw_imageTypeList.Enabled = TRUE //RDT 7-29-03

end event

type gb_2 from groupbox within w_imagetype
integer x = 50
integer y = 1208
integer width = 1289
integer height = 164
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from u_gb within w_imagetype
integer x = 50
integer y = 1372
integer width = 1294
integer height = 124
integer taborder = 40
long backcolor = 12632256
string text = ""
end type

type gb_1 from u_gb within w_imagetype
integer x = 50
integer y = 200
integer width = 1294
integer height = 1008
integer taborder = 60
long backcolor = 12632256
string text = ""
end type

type cbx_selectscanner from u_cbx within w_imagetype
integer x = 777
integer y = 1412
integer width = 430
boolean bringtotop = true
long backcolor = 12632256
string text = "Select Scanner"
end type

type cbx_settings from u_cbx within w_imagetype
integer x = 82
integer y = 1412
integer width = 663
boolean bringtotop = true
long backcolor = 12632256
string text = "Select scanner properties"
end type

type rb_flatbed from u_rb within w_imagetype
integer x = 133
integer y = 1704
integer width = 521
boolean bringtotop = true
string text = "Scan Single Page "
end type

type rb_feeder from u_rb within w_imagetype
integer x = 704
integer y = 1700
integer width = 494
boolean bringtotop = true
string text = "Scan Multi Page"
end type

type cb_savesettings from u_cb within w_imagetype
integer x = 750
integer y = 1544
integer width = 411
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer weight = 400
string text = "Save Settings"
end type

event clicked;Int	li_ReturnValue

String	ls_Source
String	ls_selectScanner
String 	ls_Settings

String 	ls_IniFile

ls_IniFile = gnv_App.of_GetAppIniFile ( )
IF rb_feeder.checked = TRUE THEN
	ls_Source = "FEEDER"
ELSE
	ls_Source = "FLATBED"
END IF


li_ReturnValue = SetProfileString ( ls_inifile, "scan settings", "source", ls_Source )


IF li_ReturnValue = 1 THEN
	
	IF cbx_selectscanner.Checked = TRUE THEN
		ls_selectScanner = "TRUE"
	ELSE 
		ls_SelectScanner = "FALSE"
	END IF
	
	li_ReturnValue = SetProfileString ( ls_inifile, "scan settings" , "select scanner", ls_selectScanner )
	
END IF

IF li_ReturnValue = 1 THEN
	
	IF cbx_settings.Checked = TRUE THEN
		ls_settings = "TRUE"
	ELSE 
		ls_settings = "FALSE"
	END IF
	
	li_ReturnValue = SetProfileString ( ls_inifile, "scan settings" , "settings", ls_settings )
	
END IF

IF li_ReturnValue <> 1 THEN
	
	MessageBox ( "Save Settings" , "An error occurred while attempting to save the current settings." )
	
END IF

	
end event

type ddlb_source from dropdownlistbox within w_imagetype
integer x = 82
integer y = 1256
integer width = 622
integer height = 400
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"ADF","TRANSPARENCY","FLATBED","FEEDER","DUPLEX","BACK-FRONT","BACK ONLY"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;IF index = 4 OR index = 1 THEN
ELSE
	cbx_multipage.Checked = FALSE
END IF
end event

type cbx_multipage from checkbox within w_imagetype
integer x = 741
integer y = 1268
integer width = 567
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Scan Multi-Page Doc"
boolean checked = true
end type

event clicked;IF THIS.CHECKED THEN 
	ddlb_source.TEXT = "ADF"
END IF
end event

type rb_noimagetype from u_rb within w_imagetype
integer x = 78
integer y = 1092
integer width = 1166
boolean bringtotop = true
long backcolor = 12632256
string text = "Scan a batch of documents of unknown Types"
end type

event clicked;ddlb_id.Enabled = TRUE 
cbx_multipage.Checked = FALSE
cbx_multipage.ENABLED = FALSE
ddlb_source.Text = "ADF"

//RDT 7-29-03 
dw_imagetypelist.SelectRow(0, FALSE)
dw_imageTypeList.SetRow(0)
dw_imageTypeList.Enabled = FALSE


end event

