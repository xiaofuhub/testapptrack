$PBExportHeader$u_tabpage_settings.sru
forward
global type u_tabpage_settings from u_tabpage_imagearchive
end type
type cb_browsearchivefolder from commandbutton within u_tabpage_settings
end type
type cb_browsetargetfolder from commandbutton within u_tabpage_settings
end type
type st_mb from statictext within u_tabpage_settings
end type
type sle_archivefolder from singlelineedit within u_tabpage_settings
end type
type st_temporarytargetfolder3 from statictext within u_tabpage_settings
end type
type sle_maxsizemedia from singlelineedit within u_tabpage_settings
end type
type st_maxsizeofarchivemedia from statictext within u_tabpage_settings
end type
type st_archivefolder from statictext within u_tabpage_settings
end type
type st_archivefolder1 from statictext within u_tabpage_settings
end type
type sle_targetfolder from singlelineedit within u_tabpage_settings
end type
type st_targetfolder from statictext within u_tabpage_settings
end type
type st_temporarytargetfolder2 from statictext within u_tabpage_settings
end type
type st_temporarytargetfolder1 from statictext within u_tabpage_settings
end type
type gb_temporarytargetfolder from groupbox within u_tabpage_settings
end type
type gb_archivefolder from groupbox within u_tabpage_settings
end type
end forward

global type u_tabpage_settings from u_tabpage_imagearchive
integer width = 1977
integer height = 1292
event type long ue_getmaxarchivesize ( )
event ue_getarchivefolder ( string as_archivefolder )
cb_browsearchivefolder cb_browsearchivefolder
cb_browsetargetfolder cb_browsetargetfolder
st_mb st_mb
sle_archivefolder sle_archivefolder
st_temporarytargetfolder3 st_temporarytargetfolder3
sle_maxsizemedia sle_maxsizemedia
st_maxsizeofarchivemedia st_maxsizeofarchivemedia
st_archivefolder st_archivefolder
st_archivefolder1 st_archivefolder1
sle_targetfolder sle_targetfolder
st_targetfolder st_targetfolder
st_temporarytargetfolder2 st_temporarytargetfolder2
st_temporarytargetfolder1 st_temporarytargetfolder1
gb_temporarytargetfolder gb_temporarytargetfolder
gb_archivefolder gb_archivefolder
end type
global u_tabpage_settings u_tabpage_settings

forward prototypes
public function integer setfocus ()
public function integer of_setarchivefolder (string as_archivefolder)
public subroutine of_getarchivefolder (ref string as_archivefoldername)
public subroutine of_getmaxarchivesettings (ref string as_maxarchivesettings)
public subroutine of_gettargetfolder (ref string as_targetfolder)
public function boolean of_gettemporarytargetfolder (string as_temptargetfolder)
end prototypes

public function integer setfocus ();Int li_ReturnValue = 1 
Sle_targetfolder.SetFocus()
Return li_ReturnValue
end function

public function integer of_setarchivefolder (string as_archivefolder);/////////////////////////////////////////////////////////////////////
//
// Function		: of_setarchivefolder
// Arguments	: as_archivefolder - String
// Returns 		: 1 = Success, -1 Failure
// Description : This method is called to display archive folder
//					  path stored in system settings table (ss_id = 154)
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Int li_ReturnValue = 1
String ls_ArchiveFolder

n_cst_Privileges lnv_Privileges

ls_ArchiveFolder = as_archivefolder
Sle_ArchiveFolder.Text = ls_ArchiveFolder


IF lnv_Privileges.of_hassysadminrights( ) THEN
	Sle_ArchiveFolder.Enabled = True
	cb_browsearchivefolder.Enabled = True
ELSE
	Sle_ArchiveFolder.Enabled = False
	cb_browsearchivefolder.Enabled = False
END IF


Return li_ReturnValue
end function

public subroutine of_getarchivefolder (ref string as_archivefoldername);/////////////////////////////////////////////////////////////////////
//
// Function		: of_getarchivefolder
// Arguments	: as_archivefoldername - String  by reference
// Returns 		: None
// Description : Fetches Archive folder path stored in system settings table (ss_id = 154)
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

String ls_archivefoldername

ls_archivefoldername = sle_archivefolder.Text
as_archivefoldername = ls_archivefoldername





end subroutine

public subroutine of_getmaxarchivesettings (ref string as_maxarchivesettings);/////////////////////////////////////////////////////////////////////
//
// Function		: of_getmaxarchivesettings
// Arguments	: as_maxarchivesettings - String  by reference
// Returns 		: None
// Description : Fetches Maximum archive size value stored in system settings table (ss_id = 155)
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

String ls_maxarchivesetting

ls_maxarchivesetting = sle_maxsizemedia.Text

as_maxarchivesettings = ls_maxarchivesetting
end subroutine

public subroutine of_gettargetfolder (ref string as_targetfolder);/////////////////////////////////////////////////////////////////////
//
// Function		: of_gettargetfolder
// Arguments	: 1. as_targetfolder - String  by reference
// Returns 		: None
// Description : Fetches Target folder path	stored in system settings table (ss_id = 153)
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

String ls_TargetFolder

ls_TargetFolder = Sle_targetfolder.Text

as_targetfolder = ls_TargetFolder
end subroutine

public function boolean of_gettemporarytargetfolder (string as_temptargetfolder);/////////////////////////////////////////////////////////////////////
//
// Function		: of_gettemporarytargetfolder
// Arguments	: as_temptargetfolder - String  by value
// Returns 		: None
// Description : This method is called to display temp target folder
//					  path stored in system settings table (ss_id = 153)
// Author		: ZMC
// Created on 	: 2003-15-10 
// Modified by : Add Author here	TimeStamp
//				
/////////////////////////////////////////////////////////////////////

Boolean lb_ReturnValue = TRUE
String ls_temptargetfolder

n_cst_privileges lnv_Privileges

ls_temptargetfolder = as_temptargetfolder

sle_targetfolder.Text = ls_temptargetfolder

IF lnv_Privileges.of_hassysadminrights( ) THEN
	sle_targetfolder.Enabled 		= True
	cb_browsetargetfolder.Enabled = True
ELSE
	sle_targetfolder.Enabled 		= False
	cb_browsetargetfolder.Enabled = False
END IF

Return lb_ReturnValue
end function

on u_tabpage_settings.create
int iCurrent
call super::create
this.cb_browsearchivefolder=create cb_browsearchivefolder
this.cb_browsetargetfolder=create cb_browsetargetfolder
this.st_mb=create st_mb
this.sle_archivefolder=create sle_archivefolder
this.st_temporarytargetfolder3=create st_temporarytargetfolder3
this.sle_maxsizemedia=create sle_maxsizemedia
this.st_maxsizeofarchivemedia=create st_maxsizeofarchivemedia
this.st_archivefolder=create st_archivefolder
this.st_archivefolder1=create st_archivefolder1
this.sle_targetfolder=create sle_targetfolder
this.st_targetfolder=create st_targetfolder
this.st_temporarytargetfolder2=create st_temporarytargetfolder2
this.st_temporarytargetfolder1=create st_temporarytargetfolder1
this.gb_temporarytargetfolder=create gb_temporarytargetfolder
this.gb_archivefolder=create gb_archivefolder
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_browsearchivefolder
this.Control[iCurrent+2]=this.cb_browsetargetfolder
this.Control[iCurrent+3]=this.st_mb
this.Control[iCurrent+4]=this.sle_archivefolder
this.Control[iCurrent+5]=this.st_temporarytargetfolder3
this.Control[iCurrent+6]=this.sle_maxsizemedia
this.Control[iCurrent+7]=this.st_maxsizeofarchivemedia
this.Control[iCurrent+8]=this.st_archivefolder
this.Control[iCurrent+9]=this.st_archivefolder1
this.Control[iCurrent+10]=this.sle_targetfolder
this.Control[iCurrent+11]=this.st_targetfolder
this.Control[iCurrent+12]=this.st_temporarytargetfolder2
this.Control[iCurrent+13]=this.st_temporarytargetfolder1
this.Control[iCurrent+14]=this.gb_temporarytargetfolder
this.Control[iCurrent+15]=this.gb_archivefolder
end on

on u_tabpage_settings.destroy
call super::destroy
destroy(this.cb_browsearchivefolder)
destroy(this.cb_browsetargetfolder)
destroy(this.st_mb)
destroy(this.sle_archivefolder)
destroy(this.st_temporarytargetfolder3)
destroy(this.sle_maxsizemedia)
destroy(this.st_maxsizeofarchivemedia)
destroy(this.st_archivefolder)
destroy(this.st_archivefolder1)
destroy(this.sle_targetfolder)
destroy(this.st_targetfolder)
destroy(this.st_temporarytargetfolder2)
destroy(this.st_temporarytargetfolder1)
destroy(this.gb_temporarytargetfolder)
destroy(this.gb_archivefolder)
end on

event constructor;call super::constructor;Long ll_MaxArchiveSize
n_cst_Privileges lnv_Privileges

ll_MaxArchiveSize = This.Event ue_GetMaxArchiveSize ( )

Sle_maxsizemedia.Text = String(ll_MaxArchiveSize)

IF lnv_Privileges.of_hassysadminrights( ) THEN
	sle_maxsizemedia.Enabled = True
ELSE
	sle_maxsizemedia.Enabled = False
END IF
end event

event ue_allowpagechange;call super::ue_allowpagechange;Boolean	lb_Return 

lb_Return = AncestorReturnValue

IF Len ( TRIM  ( sle_maxsizemedia.Text )  ) = 0 THEN
	sle_maxsizemedia.SetFocus ( )
	lb_Return = FALSE
END IF

IF Len ( TRIM  ( sle_archivefolder.Text )  ) = 0 THEN
	sle_archivefolder.SetFocus ( )
	lb_Return = FALSE
END IF

IF Len ( TRIM  ( sle_targetfolder.Text )  ) = 0 THEN
	sle_targetfolder.SetFocus ( )
	lb_Return = FALSE
END IF

Return lb_Return
end event

type cb_browsearchivefolder from commandbutton within u_tabpage_settings
integer x = 1531
integer y = 900
integer width = 279
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Browse"
end type

event clicked;String ls_Path 
String ls_AppFolder

ls_Path = Trim(sle_archivefolder.Text)

IF (IsNull(ls_Path)) OR (Len(ls_Path) = 0) THEN
	ls_AppFolder = gnv_app.of_GetApplicationfolder( )	
	IF GetFolder("",ls_AppFolder)	 > 0 THEN 
		sle_archivefolder.Text = ls_AppFolder
	END IF	
ELSE
	IF GetFolder("",ls_Path )	> 0 THEN 
		sle_archivefolder.Text = ls_path
	END IF
END IF
end event

type cb_browsetargetfolder from commandbutton within u_tabpage_settings
integer x = 1531
integer y = 388
integer width = 279
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Browse"
end type

event clicked;String ls_Path 
String ls_AppFolder

ls_Path = Trim(sle_targetfolder.Text)

IF (IsNull(ls_Path)) OR (Len(ls_Path) = 0) THEN
	ls_AppFolder = gnv_app.of_GetApplicationfolder( )	
	IF GetFolder("",ls_AppFolder)	 > 0 THEN 
		sle_targetfolder.Text = ls_AppFolder
	END IF	
ELSE
	IF GetFolder("",ls_Path )	> 0 THEN 
		sle_targetfolder.Text = ls_path
	END IF
END IF
end event

type st_mb from statictext within u_tabpage_settings
integer x = 1358
integer y = 1172
integer width = 91
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "MB"
boolean focusrectangle = false
end type

type sle_archivefolder from singlelineedit within u_tabpage_settings
integer x = 480
integer y = 904
integer width = 1029
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
integer accelerator = 102
borderstyle borderstyle = stylelowered!
end type

event getfocus;This.SelectText(1,Len(This.Text))
end event

event modified;IF left ( THIS.Text, 2 ) = "\\" THEN
	MessageBox ( "Folder Path" , "UNC paths are not supported. Please use the Browse button to select a mapped drive." )
	THIS.Text = ""
	THIS.SetFocus	( )
END IF
end event

type st_temporarytargetfolder3 from statictext within u_tabpage_settings
integer x = 219
integer y = 280
integer width = 1047
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "from this target folder after a successful archive."
boolean focusrectangle = false
end type

type sle_maxsizemedia from singlelineedit within u_tabpage_settings
integer x = 1111
integer y = 1156
integer width = 229
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
integer accelerator = 109
borderstyle borderstyle = stylelowered!
end type

event getfocus;This.SelectText(1,Len(This.Text))
end event

type st_maxsizeofarchivemedia from statictext within u_tabpage_settings
integer x = 421
integer y = 1168
integer width = 704
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Maximum size of archive media"
boolean focusrectangle = false
end type

type st_archivefolder from statictext within u_tabpage_settings
integer x = 133
integer y = 916
integer width = 347
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Archive &Folder"
boolean focusrectangle = false
end type

type st_archivefolder1 from statictext within u_tabpage_settings
integer x = 219
integer y = 744
integer width = 1179
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "The folder location for accessing the archived images"
boolean focusrectangle = false
end type

type sle_targetfolder from singlelineedit within u_tabpage_settings
event type string ue_gettargetfolder ( )
integer x = 480
integer y = 388
integer width = 1029
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
integer accelerator = 116
borderstyle borderstyle = stylelowered!
end type

event constructor;String ls_TargetFolder
String ls_ArchiveFolder

sle_targetfolder.Text	= ls_TargetFolder 
sle_archivefolder.Text	= ls_ArchiveFolder
end event

event getfocus;This.SelectText(1,Len(This.Text) )
end event

event modified;IF left ( THIS.Text, 2 ) = "\\" THEN
	MessageBox ( "Folder Path" , "UNC paths are not supported. Please use the Browse button to select a mapped drive." )
	THIS.Text = ""
	THIS.SetFocus ( )
END IF
end event

type st_targetfolder from statictext within u_tabpage_settings
integer x = 133
integer y = 396
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Target Folder"
boolean focusrectangle = false
end type

type st_temporarytargetfolder2 from statictext within u_tabpage_settings
integer x = 219
integer y = 212
integer width = 1632
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "been copied, they should be moved to the archive media and then deleted"
boolean focusrectangle = false
end type

type st_temporarytargetfolder1 from statictext within u_tabpage_settings
integer x = 219
integer y = 144
integer width = 1559
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "The target folder is the location for copied images. After the images have"
boolean focusrectangle = false
end type

type gb_temporarytargetfolder from groupbox within u_tabpage_settings
integer x = 37
integer y = 32
integer width = 1902
integer height = 536
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Temporary Target Folder"
end type

type gb_archivefolder from groupbox within u_tabpage_settings
integer x = 37
integer y = 656
integer width = 1902
integer height = 440
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Archive Folder"
end type

