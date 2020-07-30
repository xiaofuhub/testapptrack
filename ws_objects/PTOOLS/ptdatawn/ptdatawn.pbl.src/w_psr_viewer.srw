$PBExportHeader$w_psr_viewer.srw
forward
global type w_psr_viewer from w_sheet
end type
type dw_psr from u_dw within w_psr_viewer
end type
type cb_openfile from commandbutton within w_psr_viewer
end type
type cb_2 from commandbutton within w_psr_viewer
end type
type cb_3 from u_cb within w_psr_viewer
end type
type cb_email from u_cb within w_psr_viewer
end type
type cb_save from u_cb within w_psr_viewer
end type
type cb_images from commandbutton within w_psr_viewer
end type
type dw_rules from datawindow within w_psr_viewer
end type
type mle_taglist1 from u_mle within w_psr_viewer
end type
type mle_taglist2 from u_mle within w_psr_viewer
end type
type cb_image_list from u_cb within w_psr_viewer
end type
type st_emails from u_st within w_psr_viewer
end type
end forward

global type w_psr_viewer from w_sheet
integer x = 5
integer y = 4
integer width = 3621
integer height = 2064
string title = "Report Viewer"
string menuname = "m_sheets"
long backcolor = 80269524
dw_psr dw_psr
cb_openfile cb_openfile
cb_2 cb_2
cb_3 cb_3
cb_email cb_email
cb_save cb_save
cb_images cb_images
dw_rules dw_rules
mle_taglist1 mle_taglist1
mle_taglist2 mle_taglist2
cb_image_list cb_image_list
st_emails st_emails
end type
global w_psr_viewer w_psr_viewer

type variables
n_cst_bso_PSR_Manager   inv_PSR_Manager

String	is_PSRFileName
Long	ila_Shipmentid[]
n_cst_Beo_Shipment  inva_Shipment[]

Boolean	ib_Load_Retrieve
n_cst_msg	inv_Msg
end variables

forward prototypes
public function integer wf_loadfile ()
public function integer wf_retrieve ()
private function integer wf_setup_psrmanager ()
private function integer wf_selectimages ()
private subroutine wf_settagdisplay ()
private subroutine wf_setimagebutton ()
private subroutine wf_setemailbutton ()
public function integer wf_saveas ()
protected function integer wf_settitlewithfilename ()
end prototypes

public function integer wf_loadfile ();//String	ls_PathName
//String	ls_FileName
//String	ls_Extension
//String	ls_Filter
//
//ls_Filter = "PSR Files (*.psr),*.psr"
//ls_Extension = "psr"
//
//IF GetFileOpenName ( "PSR Report" , is_PSRFileName, ls_filename , ls_extension , ls_filter  ) = 1 THEN
//	dw_psr.DataObject = ls_PathName
//END IF

SetPointer(Hourglass!)

IF inv_PSR_Manager.of_OpenPSR("") = 1 Then 
	dw_psr.DataObject = inv_PSR_Manager.of_GetFileName()
	This.wf_SetTagDisplay( )
	// Check for emails in PSR
	This.wf_SetEmailButton()
	// check for images in PSR
	This.wf_SetImageButton()
	
End If

RETURN 1
end function

public function integer wf_retrieve ();//
Long		ll_Rows
			
Blob    	lblob_Fullstate

setPointer ( HOURGLASS! )

dw_psr.ShareDataOff()
dw_psr.SetTransObject ( SQLCA )

ll_Rows = dw_psr.Retrieve ( )

dw_psr.GetFullState ( lblob_Fullstate )
inv_PSR_Manager.ids_psr.SetFullState( lblob_Fullstate )


RETURN ll_Rows 

end function

private function integer wf_setup_psrmanager ();//
/***************************************************************************************
NAME			: wf_Setup_PSRManager
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer 	( 1 = success -1=failed )
DESCRIPTION	: 

REVISION		: RDT 4-1-03
***************************************************************************************/

String 	lsa_TagList[], ls_tagstring
Long 	 	ll_Upper

Integer 	li_Return = 1

// Tell PSR Manager to retrieve data
If inv_PSR_Manager.of_OpenPSR( is_PSRFilename)  = 1 then 
	
	if upperbound(ila_ShipmentId) > 0 then
		inv_PSR_Manager.of_RetrievePSR( ila_Shipmentid[] )
	else
		inv_PSR_Manager.of_RetrievePSR( )
	end if
	
	if upperbound(ila_ShipmentId) > 0 then
		inv_PSR_Manager.of_SetShipment( ila_Shipmentid[] )
	end if
	
	dw_psr.DataObject = is_PSRFilename 
	dw_psr.SetTransObject(SQLCA)
	inv_PSR_Manager.ids_psr.ShareData( dw_psr )
	
	// set the tag display line
	this.wf_SetTagDisplay( )
	
End If

// Check for emails in PSR
This.wf_SetEmailButton()
// check for images in PSR
This.wf_SetImageButton()

Return li_Return 




end function

private function integer wf_selectimages ();// 
// Get rules from psr_manager and load into datawindow Then display datawindow

String 	lsa_TagList[]
Long 	 	ll_Count, ll_Upper, ll_row

ll_Upper = inv_PSR_Manager.of_GetTagValues( inv_PSR_Manager.cs_Image, lsa_TagList[] )

dw_Rules.Reset()

For ll_count = 1 to ll_upper 
	ll_row = dw_Rules.InsertRow(0)
	dw_Rules.SetItem(ll_row,'rowchecked','Y') 
	dw_Rules.SetItem(ll_row,'rule_type',lsa_TagList[ll_count]) 
	dw_Rules.SetItem(ll_row,'rule',inv_PSR_Manager.cs_Image) 

Next

If ll_Upper > 0 then 
	
	If dw_Rules.Visible = TRUE Then 
		dw_Rules.Visible = False
	Else
		dw_Rules.Visible = TRUE
	End If
	
Else
	MessageBox("Images","No Images linked to file")
	
End If


Return 1
end function

private subroutine wf_settagdisplay ();//
/***************************************************************************************
NAME			: wf_SetTagDisplay
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: none
DESCRIPTION	: Sets the display line on the window to show imbedded tags 
				  Currently Images & PSR

					Note: Images are from the instance variable on the PSR manager because
							the user can change which images they want to send.
REVISION		: RDT 

// RDT EMAIL Turned off for now. 5-05-03

***************************************************************************************/
Long 		ll_Upper 
String	lsa_TagList[], &
			lsa_Blank[], &
			ls_TagString
			
n_cst_String	lnv_String
n_cst_LicenseManager	lnv_Lic

mle_taglist1.text = ""
mle_taglist2.text = ""

IF lnv_Lic.of_GetLicensed ( n_cst_constants.cs_module_imaging ) Then 
	
	//////// Show Image list on window
	ll_Upper = inv_PSR_Manager.of_getprintimages ( lsa_TagList[] )
	ls_TagString = ""
	if ll_Upper > 0 Then 
		lnv_String.of_ArrayToString( lsa_TagList[] , ", " , ls_tagstring) 
		mle_taglist1.text = ls_tagstring 
	end if

END IF

// RDT EMAIL Turned off for now. 5-05-03
////////// Show Email Targets on window
//lsa_TagList[] = lsa_Blank[]
//ll_Upper = inv_PSR_Manager.of_GetTagValues( inv_PSR_Manager.cs_email, lsa_TagList[] )
//ls_TagString = ""
//st_emails.Text = "" 
//if ll_Upper > 0 Then 
//	lnv_String.of_ArrayToString( lsa_TagList[] , ", " , ls_tagstring ) 
//	mle_taglist2.text = ls_tagstring + "."
//	st_emails.Text = "Emails:" 
//end if
//
//
end subroutine

private subroutine wf_setimagebutton ();String 	lsa_tagarray[]
n_cst_LicenseManager	lnv_Lic

IF lnv_Lic.of_GetLicensed ( n_cst_constants.cs_module_imaging ) Then 
		
	If isValid ( inv_PSR_Manager ) Then 
	
		if inv_PSR_Manager.of_GetTagValues ( inv_PSR_Manager.cs_image, lsa_tagarray[] ) > 0 Then 
			cb_images.Visible		 = TRUE
			cb_image_list.Visible = TRUE
		else
			cb_images.Visible 	 = FALSE
			cb_image_list.Visible = FALSE
		end if
		
	End If

End If

end subroutine

private subroutine wf_setemailbutton ();// RDT EMAIL Turned off for now. 5-05-03

String	lsa_TagArray[]

n_cst_LicenseManager	lnv_Lic

IF lnv_Lic.of_GetLicensed ( n_cst_constants.cs_module_notification ) Then 

	If isValid ( inv_PSR_Manager ) Then 
	
		if inv_PSR_Manager.of_GetTagValues ( inv_PSR_Manager.cs_email, lsa_tagarray[] ) > 0 Then
			//cb_email.Visible = TRUE  // RDT Turned off for now. 
			cb_email.Visible = FALSE			
		else
			cb_email.Visible = FALSE
			
		end if
		
	End If

End If
end subroutine

public function integer wf_saveas ();
//
/***************************************************************************************
NAME		  : wf_Saveas
ACCESS	  : Public 
ARGUMENTS  : none
			  
RETURNS	  : Integer	(1=success -1=failed)
DESCRIPTION: Checks for the default Save as Type in the psr and uses that

This is from PB Help SaveAs() 
	Working with DataStore objects If you are working with a DataStore, 
	you must supply the filename argument.
		 
REVISION	  : RDT 4-1-03
***************************************************************************************/
Integer	li_Return = 1 , &
			li_Result

String	lsa_Tag[], &
			ls_FileType

SetPointer( HourGlass! )

// Get File Type from PSR 
If inv_psr_manager.of_GetTagValues ( inv_psr_manager.cs_SaveAsType, lsa_Tag[] ) > 0 Then 
	ls_FileType = lsa_Tag[1]
Else
	ls_FileType = ""	
End If

Choose Case Lower( ls_FileType )
	
		
//	Case "clipboard"
//		li_Return = dw_psr.SaveAs ( "", Clipboard!, true )
	Case "csv"
		li_Return = dw_psr.SaveAs ( "", CSV!, true )
	Case "dbase2"
		li_Return = dw_psr.SaveAs ( "", dBASE2!, true )
	Case "dbase3"
		li_Return = dw_psr.SaveAs ( "", dBASE3!, true )
	Case "dif"
		li_Return = dw_psr.SaveAs ( "", DIF!, true )
	Case "excel"
		li_Return = dw_psr.SaveAs ( "", Excel!, true )
	Case "excel5"
		li_Return = dw_psr.SaveAs ( "", Excel5!, true )
	Case "htmltable"
		li_Return = dw_psr.SaveAs ( "", HTMLTable!, true )
	Case "psreport"
		li_Return = dw_psr.SaveAs ( "", PSReport!, true )
	Case "sqlinsert"
		li_Return = dw_psr.SaveAs ( "", SQLInsert!, true )
	Case "sylk"
		li_Return = dw_psr.SaveAs ( "", SYLK!, true )
	Case "text"
		li_Return = dw_psr.SaveAs ( "", Text!, true )
	Case "wks"
		li_Return = dw_psr.SaveAs ( "", WKS!, true )
	Case "wk1"
		li_Return = dw_psr.SaveAs ( "", WK1!, true )
	Case "windows mettafile", "mettafile"
		li_Return = dw_psr.SaveAs ( "", WMF!, true )
	Case Else 
		li_Return = dw_psr.SaveAs ( )
End Choose

Return li_Return 
end function

protected function integer wf_settitlewithfilename ();Int		li_Return = 1
String	lsa_Temp[]
string	ls_FileName
Int		li_Count

n_cst_String	lnv_String

li_Count = lnv_String.of_Parsetoarray( is_psrfilename , '\' , lsa_Temp )
IF li_Count > 0 THEN
	ls_FileName = lsa_Temp[li_Count]
END IF

IF Len ( ls_FileName ) > 0 THEN
	THIS.Title = "Report: " + ls_FileName
ELSE
	li_Return = -1
END IF


RETURN li_Return


end function

event open;call super::open;ib_DisableCloseQuery =TRUE 
of_SetResize(TRUE)
inv_Resize.of_SetOrigSize ( This.Width - 40 , This.Height - 170 )
inv_resize.of_Register (dw_psr, 'ScaleToRight&Bottom')
inv_Resize.of_register (mle_taglist1, 'ScaleToRight')
inv_Resize.of_register (mle_taglist2, 'ScaleToRight')
gf_Mask_Menu ( m_sheets )


// RDT 4-1-03
// create psr manager
inv_PSR_Manager = Create n_cst_bso_PSR_Manager 

cb_email.Visible 		 = False
cb_images.Visible 	 = False
cb_image_list.Visible = False

end event

on w_psr_viewer.create
int iCurrent
call super::create
if this.MenuName = "m_sheets" then this.MenuID = create m_sheets
this.dw_psr=create dw_psr
this.cb_openfile=create cb_openfile
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_email=create cb_email
this.cb_save=create cb_save
this.cb_images=create cb_images
this.dw_rules=create dw_rules
this.mle_taglist1=create mle_taglist1
this.mle_taglist2=create mle_taglist2
this.cb_image_list=create cb_image_list
this.st_emails=create st_emails
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_psr
this.Control[iCurrent+2]=this.cb_openfile
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_email
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_images
this.Control[iCurrent+8]=this.dw_rules
this.Control[iCurrent+9]=this.mle_taglist1
this.Control[iCurrent+10]=this.mle_taglist2
this.Control[iCurrent+11]=this.cb_image_list
this.Control[iCurrent+12]=this.st_emails
end on

on w_psr_viewer.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_psr)
destroy(this.cb_openfile)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_email)
destroy(this.cb_save)
destroy(this.cb_images)
destroy(this.dw_rules)
destroy(this.mle_taglist1)
destroy(this.mle_taglist2)
destroy(this.cb_image_list)
destroy(this.st_emails)
end on

event close;call super::close;
If IsValid( inv_psr_manager ) Then Destroy ( inv_psr_manager )

end event

event pfc_postopen;// RDT 4-1-03
If Len( Trim( is_psrfilename) ) > 0 then 
	This.wf_Setup_PsrManager( ) 
ELSE
	THIS.wf_LoadFile ( )
End If


end event

type dw_psr from u_dw within w_psr_viewer
integer x = 27
integer y = 324
integer width = 3520
integer height = 1532
integer taborder = 0
boolean bringtotop = true
boolean hscrollbar = true
end type

event constructor;// RDT 4-1-03 Code Block added - Start
// IF message parm contains a filename 
// 	Create the psr_manger

// RDT 6-06-03 IsValid and check class of PowerObjectParm 

String		ls_FileName

Long			lla_Shipid[], &
				ll_Return = 1


s_parm		lstr_parm
n_cst_msg	lnv_msg

// RDT 6-06-03 
IF IsValid( Message.PowerObjectParm ) Then 

	If UPPER( Message.PowerObjectParm.ClassName ( ) ) <> "N_CST_MSG" Then 
		ll_Return = -1
	End If

ELSE
		ll_Return = -1
END IF

IF ll_Return = 1 Then 
	

	lnv_msg = Message.PowerObjectParm
	inv_msg = lnv_msg
	//If IsValid(lnv_msg) Then 

	If lnv_msg.of_Get_Parm ( "FILENAME" , lstr_Parm ) <> 0 Then 	
		
		is_psrfilename = lstr_Parm.ia_value 

	End If
	
	If lnv_msg.of_Get_Parm ( "SHIPMENTID" , lstr_Parm ) <> 0 Then 	
		
		ila_shipmentid[]= lstr_Parm.ia_value 
		
	End If

	If lnv_msg.of_Get_Parm ( "SHIPMENTARRAY" , lstr_Parm ) <> 0 Then 	
		
		inva_shipment[] = lstr_Parm.ia_value 
		
	End If
	
End If

// RDT 4-1-03 Code Block added - End 

THIS.of_setDeleteable ( FALSE )
THIS.of_setInsertable ( FALSE )
THIS.of_SetAutoSort ( TRUE )
THIS.of_SetAutoFilter ( TRUE )
THIS.of_SetRowSelect ( false )
THIS.Event ue_SetFocusIndicator ( TRUE )

end event

event ue_autofilter;// OverRiding
String	ls_Null
SetNull ( ls_Null )

THIS.SetFilter ( ls_Null ) 
THIS.Filter ( )

RETURN 1
end event

event ue_autosort;// OverRiding
String	ls_Null
SetNull ( ls_Null )

THIS.SetSort ( ls_Null ) 
THIS.Sort ( )

RETURN 1
end event

type cb_openfile from commandbutton within w_psr_viewer
integer x = 27
integer y = 36
integer width = 379
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Open File"
end type

event clicked;parent.wf_LoadFile ( )


end event

type cb_2 from commandbutton within w_psr_viewer
integer x = 439
integer y = 36
integer width = 379
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Retrieve"
end type

event clicked;
Parent.wf_Retrieve()
end event

type cb_3 from u_cb within w_psr_viewer
integer x = 850
integer y = 36
integer width = 379
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
string text = "&Print"
end type

event clicked;//dw_psr.Print()


String	ls_Printer

ls_Printer = PrintgetPrinter ( )

IF IsValid ( inv_psr_Manager ) Then 
	inv_psr_Manager.of_setshowuser ( TRUE )
	inv_psr_manager.of_PrintPSR(PARENT)
End If

printSetPrinter ( ls_Printer )
end event

type cb_email from u_cb within w_psr_viewer
integer x = 2158
integer y = 36
integer width = 379
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
string text = "&Email"
end type

event clicked;inv_psr_manager.of_EmailPSR()

end event

type cb_save from u_cb within w_psr_viewer
integer x = 1262
integer y = 36
integer width = 379
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
string text = "&Save"
end type

event clicked;
Parent.wf_saveAs()
end event

type cb_images from commandbutton within w_psr_viewer
integer x = 1673
integer y = 36
integer width = 453
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Show &Images"
end type

event clicked;Long	lla_Ids[]

IF IsValid ( inv_psr_Manager ) Then 
	n_cst_bso_ImageManager_Pegasus	lnv_ImageManager
	lnv_ImageManager = CREATE n_cst_bso_ImageManager_Pegasus
	
	//inv_psr_manager.of_GetIdValues( inv_psr_manager.cs_shipid, lla_ids[] ) 
	
	inv_psr_manager.of_FindShipIds( lla_ids[] )
	
	IF UpperBound ( lla_Ids ) > 0 THEN
		lnv_ImageManager.of_ViewImages ( "SHIPMENT" , lla_Ids , 1)
	Else
		MessageBox("View Images","No Shipments on Report. At Least One Shipment is Required to View Images.")
	END IF
	
	DESTROY lnv_ImageManager
End If
end event

type dw_rules from datawindow within w_psr_viewer
boolean visible = false
integer x = 2560
integer y = 32
integer width = 969
integer height = 328
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_ext_psrrulelist"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type mle_taglist1 from u_mle within w_psr_viewer
integer x = 315
integer y = 156
integer width = 3145
integer height = 72
integer taborder = 80
boolean bringtotop = true
long backcolor = 80269524
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylebox!
end type

type mle_taglist2 from u_mle within w_psr_viewer
integer x = 315
integer y = 236
integer width = 3145
integer height = 80
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 80269524
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylebox!
end type

type cb_image_list from u_cb within w_psr_viewer
integer x = 27
integer y = 148
integer width = 261
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
string text = "I&mages"
end type

event clicked;
inv_psr_manager.of_selectimagestoprint ( )

Parent.wf_SetTagDisplay()
end event

type st_emails from u_st within w_psr_viewer
integer x = 27
integer y = 236
integer width = 261
integer height = 80
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = ""
alignment alignment = center!
end type

