$PBExportHeader$w_notificationsetup.srw
forward
global type w_notificationsetup from w_response
end type
type st_5 from statictext within w_notificationsetup
end type
type st_6 from statictext within w_notificationsetup
end type
type gb_7 from groupbox within w_notificationsetup
end type
type gb_2 from groupbox within w_notificationsetup
end type
type gb_1 from groupbox within w_notificationsetup
end type
type cb_cancel from commandbutton within w_notificationsetup
end type
type sle_accountname from singlelineedit within w_notificationsetup
end type
type sle_password from singlelineedit within w_notificationsetup
end type
type st_10 from statictext within w_notificationsetup
end type
type st_11 from statictext within w_notificationsetup
end type
type st_12 from statictext within w_notificationsetup
end type
type st_13 from statictext within w_notificationsetup
end type
type st_14 from statictext within w_notificationsetup
end type
type dw_increment from datawindow within w_notificationsetup
end type
type st_15 from statictext within w_notificationsetup
end type
type cb_ok from commandbutton within w_notificationsetup
end type
type cb_request from commandbutton within w_notificationsetup
end type
type st_running from statictext within w_notificationsetup
end type
type uo_shipmentstatustemplate from u_cst_fileselection within w_notificationsetup
end type
type st_statusrequest from statictext within w_notificationsetup
end type
type uo_eventtemplate from u_cst_fileselection within w_notificationsetup
end type
type uo_accnotetemplate from u_cst_fileselection within w_notificationsetup
end type
type uo_accauthtemplate from u_cst_fileselection within w_notificationsetup
end type
type st_event from statictext within w_notificationsetup
end type
type st_accnote from statictext within w_notificationsetup
end type
type st_accauth from statictext within w_notificationsetup
end type
type cbx_notificaiton from checkbox within w_notificationsetup
end type
type uo_lfdtemplate from u_cst_fileselection within w_notificationsetup
end type
type st_lfd from statictext within w_notificationsetup
end type
type cb_clear from commandbutton within w_notificationsetup
end type
type cbx_accessorial from checkbox within w_notificationsetup
end type
type cbx_authorization from checkbox within w_notificationsetup
end type
type st_1 from statictext within w_notificationsetup
end type
type st_fullpath from u_st within w_notificationsetup
end type
type st_fp1 from u_st within w_notificationsetup
end type
type st_2 from statictext within w_notificationsetup
end type
type uo_loadconfirmation from u_cst_fileselection within w_notificationsetup
end type
type em_blackoutstart from editmask within w_notificationsetup
end type
type em_blackoutend from editmask within w_notificationsetup
end type
type st_3 from statictext within w_notificationsetup
end type
type st_4 from statictext within w_notificationsetup
end type
type st_7 from statictext within w_notificationsetup
end type
end forward

global type w_notificationsetup from w_response
int X=713
int Y=312
int Width=2062
int Height=1912
boolean TitleBar=true
string Title="Status Notification"
long BackColor=80269524
st_5 st_5
st_6 st_6
gb_7 gb_7
gb_2 gb_2
gb_1 gb_1
cb_cancel cb_cancel
sle_accountname sle_accountname
sle_password sle_password
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
st_14 st_14
dw_increment dw_increment
st_15 st_15
cb_ok cb_ok
cb_request cb_request
st_running st_running
uo_shipmentstatustemplate uo_shipmentstatustemplate
st_statusrequest st_statusrequest
uo_eventtemplate uo_eventtemplate
uo_accnotetemplate uo_accnotetemplate
uo_accauthtemplate uo_accauthtemplate
st_event st_event
st_accnote st_accnote
st_accauth st_accauth
cbx_notificaiton cbx_notificaiton
uo_lfdtemplate uo_lfdtemplate
st_lfd st_lfd
cb_clear cb_clear
cbx_accessorial cbx_accessorial
cbx_authorization cbx_authorization
st_1 st_1
st_fullpath st_fullpath
st_fp1 st_fp1
st_2 st_2
uo_loadconfirmation uo_loadconfirmation
em_blackoutstart em_blackoutstart
em_blackoutend em_blackoutend
st_3 st_3
st_4 st_4
st_7 st_7
end type
global w_notificationsetup w_notificationsetup

type prototypes
Function boolean SetCurrentDirectoryA (ref string lpszCurDir ) library "KERNEL32.DLL" alias for "SetCurrentDirectoryA;Ansi"


end prototypes

type variables
dataStore	ids_Settings

boolean	ib_StatusRunning
end variables

forward prototypes
private function integer wf_getsettings ()
public function integer wf_loadaccountname ()
public function integer wf_loadpassword ()
public function integer wf_loadincrement ()
public function integer wf_setaccountname (string as_Name)
public function integer wf_setpassword (string as_Password)
public function integer wf_setincrement (long al_increment)
public function integer wf_clearaddresses ()
public function integer wf_startrequestservice ()
public function integer wf_stoprequestservice ()
public function integer wf_setenablenotification (string as_Value)
public function integer wf_loadenablenotification ()
public function integer wf_loadshipmenttemplate ()
public function integer wf_loadeventtemplate ()
public function integer wf_loadaccnotetemplate ()
public function integer wf_loadaccauthtemplate ()
public function integer wf_loadtirtemplate ()
public function integer wf_loadlastfreedatetemplate ()
public function integer wf_setenableauthorization (string as_value)
public function integer wf_setenableaccessorial (string as_value)
private function integer wf_loadenableaccessorial ()
private function integer wf_loadenableauthorization ()
public function string wf_getfullpath (string as_systemsettingid)
public function integer wf_loadconfirmationtemplate ()
private function integer wf_validfilepath (ref string as_filepath, string as_systemid)
private function integer wf_loadblackouttime ()
private function integer wf_setblackouttime ()
private subroutine wf_setenablement ()
end prototypes

private function integer wf_getsettings ();String	ls_InClause
Long	lla_SettingIds [] 

n_cst_Sql lnv_Sql

lla_SettingIds [] = { 109, 110 , 111, 112 , 113, 114 , 117 , 118 , 119 , 120, 135, 136, 137 , 152}

ids_Settings = CREATE datastore
ids_Settings.DataObject = "d_settings"

ids_Settings.SetTransObject ( SQLCA )

ids_Settings.Retrieve ( ) 

ls_InClause = lnv_Sql.of_MakeInClause ( lla_SettingIds )

ids_Settings.SetFilter ( "ss_id " + ls_InClause )
ids_Settings.Filter ( )

THIS.wf_LoadEventTemplate ( )
THIS.wf_LoadShipmentTemplate ( )
THIS.wf_LoadAccountName ( )
THIS.wf_LoadPassword ( )
THIS.wf_LoadIncrement ( )
THIS.wf_LoadEnableNotification ( )
THIS.wf_LoadAccNoteTemplate ( ) 
THIS.wf_LoadAccAuthTemplate ( )
THIS.wf_LoadLastFreeDateTemplate ( )
THIS.wf_LoadBlackoutTime ( )
THIS.wf_LoadConfirmationTemplate ( )
This.wf_LoadEnableAccessorial()
This.wf_LoadEnableAuthorization()

RETURN 1
end function

public function integer wf_loadaccountname ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 112 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
	sle_accountname.Text = ls_Value
END IF

RETURN 1
end function

public function integer wf_loadpassword ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 113 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
	sle_password.Text = ls_Value
END IF


RETURN 1
end function

public function integer wf_loadincrement ();Long		ll_FindRow
String	ls_Template
String	lsa_Result[]
String	ls_Find
Long		ll_Value

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 114 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ll_Value = ids_Settings.GetItemNumber ( ll_FindRow , "ss_Long" )
	dw_increment.SetItem ( 1 , "increment" , ll_Value )
END IF


RETURN 1
end function

public function integer wf_setaccountname (string as_Name);Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 112 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow = 0 THEN
	ll_FindRow = ids_Settings.InsertRow ( 0 )
END IF

IF ll_FindRow > 0 THEN
	ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_Name )
	ids_Settings.SetItem ( ll_FindRow , "ss_id" , 112 )
	ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
END IF


	

RETURN 1
end function

public function integer wf_setpassword (string as_Password);Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 113 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow = 0 THEN
	ll_FindRow = ids_Settings.InsertRow ( 0 )
END IF

IF ll_FindRow > 0 THEN
	ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_Password )
	ids_Settings.SetItem ( ll_FindRow , "ss_id" , 113 )
	ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
END IF


	

RETURN 1
end function

public function integer wf_setincrement (long al_increment);
Long		ll_FindRow, &
			ll_Return = 1
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

IF al_increment < 1 Then 									
	ll_Return = -1
End IF

If ll_Return = 1 Then 
	n_cst_String	lnv_String
	
	ls_Find = "ss_id = " + String ( 114 )
	
	ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
	
	IF ll_FindRow = 0 THEN
		ll_FindRow = ids_Settings.InsertRow ( 0 )
	END IF
	
	IF ll_FindRow > 0 THEN
		ids_Settings.SetItem ( ll_FindRow , "ss_long" , al_increment )
		ids_Settings.SetItem ( ll_FindRow , "ss_id" , 114 )
		ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
	END IF
END IF

RETURN ll_Return 
end function

public function integer wf_clearaddresses ();n_cst_bso_notification_Manager	lnv_Manager
lnv_Manager = CREATE n_cst_bso_Notification_Manager

lnv_Manager.of_ClearAddresses ( )

DESTROY lnv_Manager
RETURN 1
end function

public function integer wf_startrequestservice ();n_cst_bso_Notification_Manager	lnv_Note
lnv_Note = CREATE n_cst_bso_Notification_Manager 

lnv_Note.of_StartStatusRequestService ( )
ib_StatusRunning = TRUE

st_running.Visible = TRUE
cb_request.Text = "Stop request service"


DESTROY ( lnv_Note )
RETURN 1
end function

public function integer wf_stoprequestservice ();n_cst_bso_Notification_Manager	lnv_Note
lnv_Note = CREATE n_cst_bso_Notification_Manager

lnv_Note.of_StopStatusRequestService ( )
ib_StatusRunning = FALSE
cb_request.Text = "Start request service"
st_running.Visible = FALSE
DESTROY ( lnv_Note )
RETURN 1
end function

public function integer wf_setenablenotification (string as_Value);Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 109 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow = 0 THEN
	ll_FindRow = ids_Settings.InsertRow ( 0 )
END IF

IF ll_FindRow > 0 THEN
	ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_Value )
	ids_Settings.SetItem ( ll_FindRow , "ss_id" , 109 )
	ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
END IF


	

RETURN 1
end function

public function integer wf_loadenablenotification ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 109 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF


cbx_notificaiton.Checked = ls_Value =  "YES!"
IF NOT ib_statusrunning THEN
	uo_eventtemplate.of_SetEnabled ( ls_Value =  "YES!" )
END IF

RETURN 1
end function

public function integer wf_loadshipmenttemplate ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 110 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

IF Len ( ls_Value ) > 0 THEN	
	uo_shipmentstatustemplate.Event ue_SetFileFromPath ( ls_Value ) 
END IF


RETURN 1
end function

public function integer wf_loadeventtemplate ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 111 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

IF Len ( ls_Value ) > 0 THEN	
	uo_eventtemplate.Event ue_SetFileFromPath ( ls_Value ) 
END IF


RETURN 1
end function

public function integer wf_loadaccnotetemplate ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 117 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

IF Len ( ls_Value ) > 0 THEN	
	uo_accnotetemplate.Event ue_SetFileFromPath ( ls_Value ) 
END IF


RETURN 1
end function

public function integer wf_loadaccauthtemplate ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 118 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

IF Len ( ls_Value ) > 0 THEN	
	uo_accauthtemplate.Event ue_SetFileFromPath ( ls_Value ) 
END IF


RETURN 1
end function

public function integer wf_loadtirtemplate ();//Long		ll_FindRow
//String	ls_Value 
//String	ls_Template
//String	lsa_Result[]
//String	ls_Find
//
//n_cst_String	lnv_String
//
//ls_Find = "ss_id = " + String ( 119 )
//
//ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
//
//IF ll_FindRow > 0 THEN
//	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
//END IF
//
//IF Len ( ls_Value ) > 0 THEN	
//	uo_tirtemplate.Event ue_SetFileFromPath ( ls_Value ) 
//END IF
//
//
RETURN 1
end function

public function integer wf_loadlastfreedatetemplate ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 120 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

IF Len ( ls_Value ) > 0 THEN	
	uo_lfdtemplate.Event ue_SetFileFromPath ( ls_Value ) 
END IF


RETURN 1
end function

public function integer wf_setenableauthorization (string as_value);//
/***************************************************************************************
NAME			: wf_SetEnableAuthorization
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Sets System settings 
REVISION		: RDT 120302
***************************************************************************************/
Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 136 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow = 0 THEN
	ll_FindRow = ids_Settings.InsertRow ( 0 )
END IF

IF ll_FindRow > 0 THEN
	ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_Value )
	ids_Settings.SetItem ( ll_FindRow , "ss_id" , 136 )
	ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
END IF


	

RETURN 1
end function

public function integer wf_setenableaccessorial (string as_value);//
/***************************************************************************************
NAME			: wf_SetEnableAccessorial
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Sets System settings 
REVISION		: RDT 120302
***************************************************************************************/

Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 135 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow = 0 THEN
	ll_FindRow = ids_Settings.InsertRow ( 0 )
END IF

IF ll_FindRow > 0 THEN
	ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_Value )
	ids_Settings.SetItem ( ll_FindRow , "ss_id" , 135 )
	ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
END IF

RETURN 1
end function

private function integer wf_loadenableaccessorial ();//
/***************************************************************************************
NAME			: wf_LoadEnableAccessorial
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Gets System settings and sets Accessorial items on window.

REVISION		: RDT 120302
***************************************************************************************/
Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 135 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

cbx_accessorial.Checked = ls_Value =  "YES!"
uo_accnotetemplate.of_SetEnabled ( ls_Value =  "YES!" )

RETURN 1



end function

private function integer wf_loadenableauthorization ();//
/***************************************************************************************
NAME			: wf_LoadEnableAuthorization
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Gets System settings and sets Authorization items on window.

REVISION		: RDT 120302
***************************************************************************************/
Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 136 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

cbx_authorization.Checked = ls_Value =  "YES!"
uo_accauthtemplate.of_SetEnabled ( ls_Value =  "YES!" )

RETURN 1



end function

public function string wf_getfullpath (string as_systemsettingid);// RDT 12-18-02 
Long		ll_FindRow
String	ls_Find
String	ls_Return

ls_Find = "ss_id = " + as_systemsettingid

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Return = ids_Settings.GetItemString ( ll_FindRow , "ss_string")
Else 
	ls_Return = ""
END IF

RETURN ls_Return
end function

public function integer wf_loadconfirmationtemplate ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 137 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

IF Len ( ls_Value ) > 0 THEN	
	uo_loadconfirmation.Event ue_SetFileFromPath ( ls_Value ) 
END IF


RETURN 1
end function

private function integer wf_validfilepath (ref string as_filepath, string as_systemid);//
/***************************************************************************************
NAME			: wf_ValidFilePath
ACCESS		: Private 
ARGUMENTS	: String 	file path
				  String		System ID setting
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: 
				 Check for a path in the as_Filepath
				 If found then make sure it's valid (could be miss-typed)
				 If NOT found then try to get the system setting path and append the name to it.
				 IF all the above fail then give error message. 
REVISION		: RDT 3-5-03
***************************************************************************************/

Integer	li_Return = 1

String	ls_New_Drive, &
			ls_New_DirPath, &
			ls_New_FileName, &
			ls_Old_DirPath, &
			ls_Old_FileName, &
			ls_DriveDirPath, &
			ls_MessageHeader, &
			ls_SystemSetting
			
ls_MessageHeader = "Notification Setup"
			
n_cst_filesrv  lnv_FileSrv

f_SetFileSrv(lnv_FileSrv, TRUE)				// Create file service

lnv_filesrv.of_parsepath ( as_filepath, ls_New_Drive, ls_New_DirPath, ls_New_FileName )

// Check for a Drive 
If Len ( Trim ( ls_New_Drive ) ) < 1 Then 

	// Get system settings. 
	ls_SystemSetting = This.wf_GetFullPath( as_systemid ) 
	
	lnv_filesrv.of_parsepath ( ls_SystemSetting, ls_New_Drive, ls_Old_DirPath, ls_Old_FileName )
	
	If Len ( Trim ( ls_New_Drive) ) < 1 Then 
		MessageBox(ls_MessageHeader ,"Please include a drive letter in the path.")
		li_Return = -1
	Else
		ls_DriveDirPath = ls_New_Drive+ls_Old_DirPath
	End If

Else
	// combine drive and directory for DirectoryExists function
	ls_DriveDirPath = ls_New_Drive+ls_New_DirPath
End If

// check for valid path 
If li_Return = 1 Then 
	IF NOT lnv_FileSrv.of_DirectoryExists( ls_DriveDirPath ) Then 
		MessageBox(ls_MessageHeader ,"Invalid Drive or Path. ~nPlease verify you can access the drive and path.")
		li_Return = -1
	End If
End If

//check for a file name
If li_Return = 1 Then 
	If Len ( Trim ( ls_New_FileName ) ) < 1 Then 
		MessageBox(ls_MessageHeader ,"No File Name. ~nPlease enter a valid file name.")
		ls_New_FileName = ls_Old_FileName // set file name to old value
		
		li_Return = -1
	Else
		as_filepath = ls_DriveDirPath+ls_New_FileName
	End IF
End If


f_SetFileSrv(lnv_FileSrv, FALSE )			//Destroy File Service

Return li_Return 
end function

private function integer wf_loadblackouttime ();Long		ll_FindRow
String	ls_Value 
String	ls_Template
String	lsa_Result[]
String	ls_Find

n_cst_String	lnv_String

ls_Find = "ss_id = " + String ( 152 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow > 0 THEN
	ls_Value = ids_Settings.GetItemString ( ll_FindRow , "ss_string" )
END IF

IF Len ( ls_Value ) > 0 THEN
	lnv_String.of_ParseToarray ( ls_Value , "*" , lsa_Result )
	IF UpperBound ( lsa_Result ) > 1 THEN
		em_blackoutstart.Text = lsa_Result[1]
		em_blackoutend.Text = lsa_Result[2]
	END IF
END IF


RETURN 1
end function

private function integer wf_setblackouttime ();Long		ll_FindRow
String	ls_Value 
String	ls_Find

n_cst_String	lnv_String

ls_Value = String ( em_blackoutstart.Text )+"*"+ String ( em_blackoutend.Text )
ls_Find = "ss_id = " + String ( 152 )

ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )

IF ll_FindRow = 0 THEN
	ll_FindRow = ids_Settings.InsertRow ( 0 )
END IF

IF ll_FindRow > 0 THEN
	ids_Settings.SetItem ( ll_FindRow , "ss_string" , ls_Value )
	ids_Settings.SetItem ( ll_FindRow , "ss_id" , 152 )
	ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
END IF
RETURN 1
end function

private subroutine wf_setenablement ();cb_clear.Enabled = Not ib_StatusRunning
cbx_notificaiton.Enabled = Not ib_StatusRunning
dw_increment.Enabled = Not ib_StatusRunning

cbx_accessorial.Enabled = Not ib_StatusRunning   // RDT 12-16-02 
cbx_authorization.Enabled = Not ib_StatusRunning // RDT 12-16-02  

uo_shipmentstatustemplate.of_SetEnabled ( Not ib_StatusRunning )
uo_eventtemplate.of_SetEnabled ( (Not ib_StatusRunning) AND cbx_notificaiton.checked  )
uo_accauthtemplate.of_SetEnabled ( (Not ib_StatusRunning) AND cbx_authorization.Checked )
uo_accnotetemplate.of_SetEnabled ( (Not ib_StatusRunning) AND cbx_accessorial.checked )

em_blackoutend.Enabled = Not ib_StatusRunning
em_blackoutstart.Enabled = Not ib_StatusRunning
uo_lfdtemplate.of_SetEnabled ( Not ib_StatusRunning )
uo_loadconfirmation.of_SetEnabled ( Not ib_StatusRunning )


end subroutine

on w_notificationsetup.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_6=create st_6
this.gb_7=create gb_7
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_cancel=create cb_cancel
this.sle_accountname=create sle_accountname
this.sle_password=create sle_password
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_13=create st_13
this.st_14=create st_14
this.dw_increment=create dw_increment
this.st_15=create st_15
this.cb_ok=create cb_ok
this.cb_request=create cb_request
this.st_running=create st_running
this.uo_shipmentstatustemplate=create uo_shipmentstatustemplate
this.st_statusrequest=create st_statusrequest
this.uo_eventtemplate=create uo_eventtemplate
this.uo_accnotetemplate=create uo_accnotetemplate
this.uo_accauthtemplate=create uo_accauthtemplate
this.st_event=create st_event
this.st_accnote=create st_accnote
this.st_accauth=create st_accauth
this.cbx_notificaiton=create cbx_notificaiton
this.uo_lfdtemplate=create uo_lfdtemplate
this.st_lfd=create st_lfd
this.cb_clear=create cb_clear
this.cbx_accessorial=create cbx_accessorial
this.cbx_authorization=create cbx_authorization
this.st_1=create st_1
this.st_fullpath=create st_fullpath
this.st_fp1=create st_fp1
this.st_2=create st_2
this.uo_loadconfirmation=create uo_loadconfirmation
this.em_blackoutstart=create em_blackoutstart
this.em_blackoutend=create em_blackoutend
this.st_3=create st_3
this.st_4=create st_4
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.gb_7
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.sle_accountname
this.Control[iCurrent+8]=this.sle_password
this.Control[iCurrent+9]=this.st_10
this.Control[iCurrent+10]=this.st_11
this.Control[iCurrent+11]=this.st_12
this.Control[iCurrent+12]=this.st_13
this.Control[iCurrent+13]=this.st_14
this.Control[iCurrent+14]=this.dw_increment
this.Control[iCurrent+15]=this.st_15
this.Control[iCurrent+16]=this.cb_ok
this.Control[iCurrent+17]=this.cb_request
this.Control[iCurrent+18]=this.st_running
this.Control[iCurrent+19]=this.uo_shipmentstatustemplate
this.Control[iCurrent+20]=this.st_statusrequest
this.Control[iCurrent+21]=this.uo_eventtemplate
this.Control[iCurrent+22]=this.uo_accnotetemplate
this.Control[iCurrent+23]=this.uo_accauthtemplate
this.Control[iCurrent+24]=this.st_event
this.Control[iCurrent+25]=this.st_accnote
this.Control[iCurrent+26]=this.st_accauth
this.Control[iCurrent+27]=this.cbx_notificaiton
this.Control[iCurrent+28]=this.uo_lfdtemplate
this.Control[iCurrent+29]=this.st_lfd
this.Control[iCurrent+30]=this.cb_clear
this.Control[iCurrent+31]=this.cbx_accessorial
this.Control[iCurrent+32]=this.cbx_authorization
this.Control[iCurrent+33]=this.st_1
this.Control[iCurrent+34]=this.st_fullpath
this.Control[iCurrent+35]=this.st_fp1
this.Control[iCurrent+36]=this.st_2
this.Control[iCurrent+37]=this.uo_loadconfirmation
this.Control[iCurrent+38]=this.em_blackoutstart
this.Control[iCurrent+39]=this.em_blackoutend
this.Control[iCurrent+40]=this.st_3
this.Control[iCurrent+41]=this.st_4
this.Control[iCurrent+42]=this.st_7
end on

on w_notificationsetup.destroy
call super::destroy
destroy(this.st_5)
destroy(this.st_6)
destroy(this.gb_7)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_cancel)
destroy(this.sle_accountname)
destroy(this.sle_password)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.dw_increment)
destroy(this.st_15)
destroy(this.cb_ok)
destroy(this.cb_request)
destroy(this.st_running)
destroy(this.uo_shipmentstatustemplate)
destroy(this.st_statusrequest)
destroy(this.uo_eventtemplate)
destroy(this.uo_accnotetemplate)
destroy(this.uo_accauthtemplate)
destroy(this.st_event)
destroy(this.st_accnote)
destroy(this.st_accauth)
destroy(this.cbx_notificaiton)
destroy(this.uo_lfdtemplate)
destroy(this.st_lfd)
destroy(this.cb_clear)
destroy(this.cbx_accessorial)
destroy(this.cbx_authorization)
destroy(this.st_1)
destroy(this.st_fullpath)
destroy(this.st_fp1)
destroy(this.st_2)
destroy(this.uo_loadconfirmation)
destroy(this.em_blackoutstart)
destroy(this.em_blackoutend)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_7)
end on

event open;call super::open;

n_cst_bso_Notification_Manager	lnv_Note
lnv_Note = CREATE n_cst_bso_Notification_Manager

IF lnv_Note.of_IsStatusRequestRunning ( ) THEN
	ib_StatusRunning = TRUE
	cb_request.Text = "Stop request service"
	
END IF

st_running.Visible = ib_StatusRunning

//cb_clear.Enabled = Not ib_StatusRunning
//cbx_notificaiton.Enabled = Not ib_StatusRunning
//dw_increment.Enabled = Not ib_StatusRunning
//uo_eventtemplate.of_SetEnabled ( Not ib_StatusRunning )
//uo_shipmentstatustemplate.of_SetEnabled ( Not ib_StatusRunning )
THIS.wf_GetSettings ( )


DESTROY (lnv_Note)

THIS.wf_SetEnablement ( )
end event

event close;call super::close;Destroy ( ids_Settings )
end event

type st_5 from statictext within w_notificationsetup
int X=73
int Y=748
int Width=1751
int Height=140
boolean Enabled=false
boolean BringToTop=true
string Text="Email addresses that are entered and are not part of a company profile are stored for easy reference later. You can delete these here."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_notificationsetup
int X=73
int Y=912
int Width=1307
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="This will not clear addresses in the company profile."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_7 from groupbox within w_notificationsetup
int X=41
int Y=36
int Width=1943
int Height=648
int TabOrder=10
string Text="Select the default templates to be used for: "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_notificationsetup
int X=46
int Y=1036
int Width=1938
int Height=604
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_notificationsetup
int X=41
int Y=696
int Width=1943
int Height=328
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_notificationsetup
int X=1065
int Y=1672
int Width=247
int Height=108
int TabOrder=190
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CLOSE ( PARENT ) 
end event

type sle_accountname from singlelineedit within w_notificationsetup
int X=489
int Y=1244
int Width=709
int Height=80
int TabOrder=120
boolean Enabled=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Parent.wf_SetAccountName ( THIS.Text )
end event

type sle_password from singlelineedit within w_notificationsetup
int X=489
int Y=1356
int Width=709
int Height=72
int TabOrder=130
boolean Enabled=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean PassWord=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Parent.wf_SetPassWord ( this.Text )
end event

type st_10 from statictext within w_notificationsetup
int X=87
int Y=1248
int Width=379
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Account Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_notificationsetup
int X=87
int Y=1332
int Width=274
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Password:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_notificationsetup
int X=87
int Y=1100
int Width=1051
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Enter the profile information for the Email "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_13 from statictext within w_notificationsetup
int X=87
int Y=1160
int Width=1051
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="account that will receive status requests."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within w_notificationsetup
int X=105
int Y=1448
int Width=727
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Check for new request every "
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_increment from datawindow within w_notificationsetup
int X=827
int Y=1428
int Width=238
int Height=100
int TabOrder=140
boolean BringToTop=true
string DataObject="d_spin"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;THIS.InsertRow ( 0 )
dw_increment.SetItem ( 1 , "increment" , 1)

end event

event itemchanged;// RDT 6-27-03 Added validation for increment value ( increment > 4 and increment < 301 )
Long ll_ret
ll_ret = 0


IF Long( data ) > 4 AND Long( data ) < 301 Then 		// RDT 6-27-03 

	If Parent.wf_SetIncrement ( Long ( data ) ) = -1 Then
	
		Parent.wf_LoadIncrement()
		ll_ret = 1
		
	End If

ELSE																	// RDT 6-27-03 
	ll_ret = 1														// RDT 6-27-03 
END IF																// RDT 6-27-03 

Return ll_ret
end event

type st_15 from statictext within w_notificationsetup
int X=1065
int Y=1448
int Width=160
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="min."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_notificationsetup
int X=731
int Y=1672
int Width=247
int Height=108
int TabOrder=180
boolean BringToTop=true
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_increment.AcceptText ( )
ids_Settings.Update ( )
gnv_app.of_getTimers ( ).of_SetStatusRequestBlackout ( Time (em_blackoutstart.Text) , Time (  em_blackoutend.Text ) )
Close ( PARENT ) 
end event

type cb_request from commandbutton within w_notificationsetup
int X=1417
int Y=1100
int Width=507
int Height=108
int TabOrder=170
boolean BringToTop=true
string Text="Start request service"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Boolean	lb_Refresh 
SetPointer (  HOURGLASS! )
IF ib_StatusRunning THEN
	
	lb_Refresh = NOT sqlca.of_IsConnected ( )		
	Parent.wf_StopRequestService ( )
	IF lb_Refresh THEN
		Parent.wf_GetSettings ( )
	END IF
	
ELSE
	Parent.wf_StartRequestService ( )
END IF

Parent.wf_SetEnablement ( )


end event

type st_running from statictext within w_notificationsetup
int X=1417
int Y=1248
int Width=507
int Height=168
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text="Request service is running"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=32768
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_shipmentstatustemplate from u_cst_fileselection within w_notificationsetup
int X=1179
int Y=332
int Width=763
int TabOrder=90
boolean BringToTop=true
end type

on uo_shipmentstatustemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;Long		ll_FindRow
String	ls_Template
String	ls_Find
Integer  li_Return = 1

//// RDT 3-5-03 check for file path
If Parent.wf_ValidFilePath( as_Path, String ( 110 ) ) = 1 Then 

	ls_Find = "ss_id = " + String ( 110 )
	
	ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
	
	IF ll_FindRow = 0 THEN
		ll_FindRow = ids_Settings.InsertRow ( 0 )
	END IF
	
	IF ll_FindRow > 0 THEN
		ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_path )
		ids_Settings.SetItem ( ll_FindRow , "ss_id" , 110 )
		ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
	END IF

	this.event ue_slegetfocus()
Else
	li_Return = -1
	SetFocus(this)
End If

Return li_Return
//RETURN 1
end event

event constructor;call super::constructor;THIS.of_SetFileOpenTitle ( "Select shipment status template" )
end event

event ue_slegetfocus;
st_fullpath.text = Parent.wf_GetFullPath( String ( 110 ) )
end event

type st_statusrequest from statictext within w_notificationsetup
int X=1179
int Y=272
int Width=631
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Automated Status Reply"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_eventtemplate from u_cst_fileselection within w_notificationsetup
int X=297
int Y=172
int TabOrder=30
boolean BringToTop=true
end type

on uo_eventtemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;Long		ll_FindRow
String	ls_Template
String	ls_Find

Integer  li_Return = 1

//// RDT 3-5-03 check for file path
If Parent.wf_ValidFilePath( as_Path, String ( 111 ) ) = 1 Then 

	ls_Find = "ss_id = " + String ( 111 )
	
	ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
	
	IF ll_FindRow = 0 THEN
		ll_FindRow = ids_Settings.InsertRow ( 0 )
	END IF
	
	IF ll_FindRow > 0 THEN
		ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_path )
		ids_Settings.SetItem ( ll_FindRow , "ss_id" , 111 )
		ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
	END IF

	this.event ue_slegetfocus()
Else
	li_Return = -1
	SetFocus(this)
End If

Return li_Return
//RETURN 1
end event

event constructor;call super::constructor;THIS.of_SetFileOpenTitle ( "Select event confirmation template" )
end event

event ue_slegetfocus;
st_fullpath.text = Parent.wf_GetFullPath( String ( 111 ) )


end event

type uo_accnotetemplate from u_cst_fileselection within w_notificationsetup
int X=297
int Y=332
int TabOrder=50
boolean BringToTop=true
end type

on uo_accnotetemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;Long		ll_FindRow
String	ls_Template
String	ls_Find
Integer  li_Return = 1

//// RDT 3-5-03 check for file path
If Parent.wf_ValidFilePath( as_Path, String ( 117 ) ) = 1 Then 

	ls_Find = "ss_id = " + String ( 117 )
	
	ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
	
	IF ll_FindRow = 0 THEN
		ll_FindRow = ids_Settings.InsertRow ( 0 )
	END IF
	
	IF ll_FindRow > 0 THEN
		ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_path )
		ids_Settings.SetItem ( ll_FindRow , "ss_id" , 117 )
		ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
	END IF

	this.event ue_slegetfocus()
Else
	li_Return = -1
	SetFocus(this)
End If

Return li_Return

end event

event constructor;call super::constructor;THIS.of_SetFileOpenTitle ( "Select accessorial notification template" )
end event

event ue_slegetfocus;
st_fullpath.text = Parent.wf_GetFullPath( String ( 117 ) )
end event

type uo_accauthtemplate from u_cst_fileselection within w_notificationsetup
int X=297
int Y=492
int Width=759
int TabOrder=70
boolean BringToTop=true
end type

on uo_accauthtemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;Integer	li_Return = 1
Long		ll_FindRow
String	ls_Template
String	ls_Find

//// RDT 3-5-03 check for file path
If Parent.wf_ValidFilePath( as_Path, String ( 118 ) ) = 1 Then 

	ls_Find = "ss_id = " + String ( 118 )
	
	ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
	
	IF ll_FindRow = 0 THEN
		ll_FindRow = ids_Settings.InsertRow ( 0 )
	END IF
	
	IF ll_FindRow > 0 THEN
		ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_path )
		ids_Settings.SetItem ( ll_FindRow , "ss_id" , 118 )
		ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
	END IF
	this.event ue_slegetfocus()
Else
	li_Return = -1
	SetFocus(this)
End If

Return li_Return

//RETURN 1
end event

event constructor;call super::constructor;THIS.of_SetFileOpenTitle ( "Select accessorial auth. template" )
end event

event ue_slegetfocus;
st_fullpath.text = Parent.wf_GetFullPath( String ( 118 ) )
end event

type st_event from statictext within w_notificationsetup
int X=297
int Y=116
int Width=489
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Event Confirmation"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_accnote from statictext within w_notificationsetup
int X=302
int Y=272
int Width=425
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Acc. Notification"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_accauth from statictext within w_notificationsetup
int X=297
int Y=432
int Width=453
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Acc. Authorization"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_notificaiton from checkbox within w_notificationsetup
int X=142
int Y=184
int Width=64
int Height=52
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Value

IF THIS.Checked THEN
	ls_Value = "YES!"
	uo_eventtemplate.of_SetEnabled ( TRUE )
ELSE
	ls_Value = "NO!"
	uo_eventtemplate.of_SetEnabled ( FALSE )
END IF

wf_SetEnableNotification ( ls_Value )
end event

type uo_lfdtemplate from u_cst_fileselection within w_notificationsetup
int X=1179
int Y=172
int Width=763
int TabOrder=80
boolean BringToTop=true
long BackColor=80269524
end type

on uo_lfdtemplate.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;Long		ll_FindRow
String	ls_Template
String	ls_Find
Integer  li_Return = 1

//// RDT 3-5-03 check for file path
If Parent.wf_ValidFilePath( as_Path, String ( 120 ) ) = 1 Then 

	ls_Find = "ss_id = " + String ( 120 )
	
	ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
	
	IF ll_FindRow = 0 THEN
		ll_FindRow = ids_Settings.InsertRow ( 0 )
	END IF
	
	IF ll_FindRow > 0 THEN
		ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_path )
		ids_Settings.SetItem ( ll_FindRow , "ss_id" , 120 )
		ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
	END IF
	
	this.event ue_slegetfocus()
Else
	li_Return = -1
	SetFocus(this)
End If

Return li_Return

//RETURN 1
end event

event constructor;call super::constructor;THIS.of_SetFileOpenTitle ( "Select Last Free Date template" )
end event

event ue_slegetfocus;
st_fullpath.text = Parent.wf_GetFullPath( String ( 120 ) )
end event

type st_lfd from statictext within w_notificationsetup
int X=1179
int Y=116
int Width=439
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="LFD Notification"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_clear from commandbutton within w_notificationsetup
int X=1417
int Y=896
int Width=507
int Height=108
int TabOrder=110
boolean BringToTop=true
string Text="Clear Addresses"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Setpointer ( HOURGLASS! )
Parent.wf_ClearAddresses ( )
end event

type cbx_accessorial from checkbox within w_notificationsetup
int X=142
int Y=344
int Width=64
int Height=52
int TabOrder=40
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Value

IF THIS.Checked THEN
	ls_Value = "YES!"
	uo_accnotetemplate.of_SetEnabled ( TRUE )
ELSE
	ls_Value = "NO!"
	uo_accnotetemplate.of_SetEnabled ( FALSE )
END IF

Parent.wf_SetEnableAccessorial ( ls_Value )
end event

type cbx_authorization from checkbox within w_notificationsetup
int X=142
int Y=504
int Width=64
int Height=52
int TabOrder=60
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Value

IF THIS.Checked THEN
	ls_Value = "YES!"
	uo_accauthtemplate.of_SetEnabled ( TRUE )
ELSE
	ls_Value = "NO!"
	uo_accauthtemplate.of_SetEnabled ( FALSE )
END IF

Parent.wf_SetEnableAuthorization ( ls_Value )
end event

type st_1 from statictext within w_notificationsetup
int X=73
int Y=116
int Width=201
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Enable"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_fullpath from u_st within w_notificationsetup
int X=233
int Y=604
int Width=1705
boolean BringToTop=true
string Text=""
FontCharSet FontCharSet=Ansi!
end type

type st_fp1 from u_st within w_notificationsetup
int X=73
int Y=604
int Width=142
boolean BringToTop=true
string Text="Path:"
FontCharSet FontCharSet=Ansi!
end type

type st_2 from statictext within w_notificationsetup
int X=1179
int Y=432
int Width=521
int Height=56
boolean Enabled=false
boolean BringToTop=true
string Text="Shipment Status"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_loadconfirmation from u_cst_fileselection within w_notificationsetup
int X=1179
int Y=492
int Width=763
int TabOrder=100
boolean BringToTop=true
long BackColor=80269524
end type

on uo_loadconfirmation.destroy
call u_cst_fileselection::destroy
end on

event ue_filechanged;Long		ll_FindRow
String	ls_Template
String	ls_Find
Integer  li_Return = 1

//// RDT 3-5-03 check for file path
If Parent.wf_ValidFilePath( as_Path, String ( 137 ) ) = 1 Then 
	
	ls_Find = "ss_id = " + String ( 137 )
	
	ll_FindRow = ids_Settings.Find ( ls_Find , 1  , 99 )
	
	IF ll_FindRow = 0 THEN
		ll_FindRow = ids_Settings.InsertRow ( 0 )
	END IF
	
	IF ll_FindRow > 0 THEN
		ids_Settings.SetItem ( ll_FindRow , "ss_string" , as_path )
		ids_Settings.SetItem ( ll_FindRow , "ss_id" , 137 )
		ids_Settings.SetItem ( ll_FindRow , "ss_uid" , 0 )
	END IF

	this.event ue_slegetfocus()
Else
	li_Return = -1
	SetFocus(this)
End If

Return li_Return
//RETURN 1
end event

event constructor;call super::constructor;THIS.of_SetFileOpenTitle ( "Select load confirmation template" )
end event

event ue_slegetfocus;st_fullpath.text = Parent.wf_GetFullPath( String ( 137 ) )
end event

type em_blackoutstart from editmask within w_notificationsetup
int X=837
int Y=1528
int Width=201
int Height=80
int TabOrder=150
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm"
MaskDataType MaskDataType=TimeMask!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Parent.wf_SetBlackOutTime ( ) 
end event

type em_blackoutend from editmask within w_notificationsetup
int X=1166
int Y=1528
int Width=201
int Height=80
int TabOrder=160
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm"
MaskDataType MaskDataType=TimeMask!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Parent.wf_SetBlackOutTime ( ) 
end event

type st_3 from statictext within w_notificationsetup
int X=105
int Y=1540
int Width=709
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Except between the hours of"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_notificationsetup
int X=1051
int Y=1540
int Width=101
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="and"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_notificationsetup
int X=1390
int Y=1532
int Width=183
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="(24 hr)"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

