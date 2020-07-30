$PBExportHeader$n_cst_appmanager_trucking.sru
$PBExportComments$Trucking (Application Manager from PBL map PTApp) //@(*)[8916340|47:a]<nosync>
forward
global type n_cst_appmanager_trucking from n_cst_appmanager
end type
end forward

global type n_cst_appmanager_trucking from n_cst_appmanager
event task_openfirstwindow ( window aw_framewindow )
event type integer ue_liveload ( string as_commandline )
event type integer ue_communication ( string as_device,  ref string as_errormessage )
event type integer ue_import ( string as_type )
event ue_starteventscheduler ( time at_killtime )
event ue_stopeventscheduler ( )
end type
global n_cst_appmanager_trucking n_cst_appmanager_trucking

type prototypes
FUNCTION ulong GetModuleFileName (ulong hinstModule, ref string lpszPath, ulong cchPath ) &
		Library "KERNEL32.DLL" Alias for "GetModuleFileNameA;Ansi"

// One instance of Profit Tools check.
FUNCTION  boolean  ShowWindow( long  winhandle, int wincommand ) Library "user32.dll"
FUNCTION  BOOLEAN BringWindowToTop(  ulong  HWND  ) Library "user32.dll"
FUNCTION  long        FindWindowA( ulong  Winhandle, string wintitle ) Library "user32.dll" alias for "FindWindowA;Ansi"
end prototypes

type variables
//@(text)(recreate=opt)<Synchronized Instance Variables>
//The following variables will be synchronized with HOW.
//You may edit these variables, add new variables or delete variables.
//Please add one variable declaration per line.

//@(text)--

//@(-)
//The following variables are HOW implementation-only variables.  Do not edit these variables.
n_cst_taskmanager_trucking inv_taskmanager
//@(-)--

//Add your implementation-only instance variables after this line.
//These variables will NOT be synchronized with HOW.

Public:
n_cst_CacheManager	inv_CacheManager

n_cst_timers		inv_Timers

n_cst_Clipboard  		inv_ClipBoard   //RDT 3-12-03
Boolean	ib_GlobalEventScheduler 

String	is_ReportingTime


Private:

n_Cst_AlertManager	inv_AlertManager

Boolean	ib_ScheduledTask
Long	il_NextSpecialOps
Long	il_DBExpected
Long	il_UserID
String	is_ApplicationFolder
Constant String	cs_User_PTADMIN = "PTADMIN"

n_cst_timer_eventhandler		inv_EventScheduler
n_cst_privsmanager				inv_PrivsManager

n_cst_ThreadManager				inv_ThreadManager


//settings
String	is_ShipNoteFormat


DataStore	ids_SetttingCache



end variables

forward prototypes
public function long of_getdbexpected ()
public function integer of_setdbexpected (long al_dbexpected)
public function boolean of_isregistryavailable ()
public function integer of_getnextid (string as_class, ref long al_nextid, boolean ab_commit)
public function integer of_setcachemanager (boolean ab_switch)
public function integer of_getliveloadpath (ref string as_path)
public function string of_getapplicationfile ()
public function string of_getapplicationfolder ()
public function integer of_logonassystem ()
public function n_cst_timers of_gettimers ()
public subroutine of_cachezones ()
public function long of_getnextspecialops ()
public function integer of_setnextspecialops (long al_value)
public function boolean of_runningscheduledtask ()
public function integer of_disconnectfromdb ()
public function integer of_connecttodb ()
public function boolean of_getrestrictedview ()
public function boolean of_bringtotop (unsignedlong al_winhandle)
public function long of_findwindowbytitle (string as_wintitle)
public function boolean of_showwindow (long al_winhandle)
public function boolean of_isapprunning ()
public function n_cst_AlertManager of_getalertmanager ()
public subroutine of_recordtime (string as_data)
public function string of_getshipnoteformat ()
private subroutine of_preloadsettings ()
public function long of_getnumericuserid ()
public function boolean of_attemptpcmilerconnection ()
public function datastore of_getsettingscache ()
public function integer of_setsettingcache (datastore ads_cache)
private function integer of_removeopenshipments ()
public function n_cst_privsManager of_getprivsmanager ()
public function string of_getrailtraceappname ()
public function n_cst_threadmanager of_getthreadmanager ()
end prototypes

event task_openfirstwindow;call super::task_openfirstwindow;//@(data)(recreate=yes)<StartTask>
inv_taskManager.SetFrame(aw_framewindow)
//@(data)--

//@(text)(recreate=yes)<StartTask>
of_SetTrRegistration(TRUE)
inv_trregistration.of_register ( SQLCA )
//@(text)--

end event

event ue_liveload;String	ls_FileGroup
String	ls_LiveLoadPath
Int		li_llPathRtn

n_cst_bso_LiveLoad	lnv_LiveLoad

//Extract the file group information from the commandline.
//NOTE: **THIS LOGIC ASSUMES THAT THE -ll SWITCH IS THE ONLY THING IN THE COMMAND LINE.
//THIS WILL HAVE TO BE REVISED.**
ls_FileGroup = Trim ( Mid ( Trim ( as_CommandLine ), 4 ) )

lnv_LiveLoad = CREATE n_cst_bso_LiveLoad

//If a filegroup has been specified, generate files for it.  Otherwise, just upload any
//existing files  (this can be used if an upload failed after generation.)

li_llPathRtn = THIS.of_GetLiveLoadPath ( ls_LiveLoadPath )
IF li_llpathRtn = 1 THEN
	
	IF Len ( ls_FileGroup ) > 0 THEN
		lnv_LiveLoad.of_GenerateFiles ( ls_FileGroup )
	END IF
	
	Run ( ls_LiveLoadPath + "llapps\" + "liveload.exe -b")
ELSE
	MessageBox ( "LiveLoad" , "The file 'LiveLoad.ini' could not be located. Please be sure the system setting in Profit Tools is correct.")
END IF

DESTROY lnv_LiveLoad

RETURN li_llPathRtn
end event

event type integer ue_communication(string as_device, ref string as_errormessage);
integer	li_Return = 1
long		ll_errorcount
string	ls_Device, &
			ls_CommunicationObject, &
			ls_TemplatePath, &
			ls_errormessage
			
datastore	lds_InboundMessage

n_cst_bso_Communication_Manager lnv_Communication
n_cst_OFRError	lnva_Errors[]

ls_Device = as_device

//need to check table for device, if more than one type
//then display response window ot pick one

CHOOSE CASE UPPER (ls_Device)
	
	CASE "QUALCOMM" , n_cst_constants.cs_CommunicationDevice_Qualcomm 
		ls_CommunicationObject = "n_cst_bso_Communication_QualComm"
		
			
	CASE "NEXTEL" , n_cst_constants.cs_CommunicationDevice_Nextel
		ls_CommunicationObject = "n_cst_bso_Communication_Nextel"

	CASE "INTOUCH", n_cst_constants.cs_CommunicationDevice_InTouch
		ls_CommunicationObject = "n_cst_bso_Communication_Intouch"
	
	CASE "ATROAD", n_cst_constants.cs_CommunicationDevice_AtRoad
		ls_CommunicationObject = "n_cst_bso_Communication_AtRoad"
		
	CASE "CADEC", n_cst_constants.cs_CommunicationDevice_Cadec
		ls_CommunicationObject = "n_cst_bso_Communication_Cadec"


END CHOOSE

IF len ( ls_CommunicationObject ) > 0 THEN
	
	lnv_Communication = CREATE USING ls_CommunicationObject
	
END IF


IF isValid ( lnv_Communication ) THEN
	lds_InboundMessage = 	CREATE datastore
	lds_InboundMessage.DataObject = "d_communicationlog"
	lds_InboundMessage.SetTransObject ( SQLCA ) 
	
	lnv_Communication.of_GetinboundPath ( ls_TemplatePath )
	// build path from system templatepath + "\message\" + device + "\intouch\inbound\message.txt"
	//ls_TemplatePath += "message.txt"
	ls_TemplatePath += String (Today ( ) , "mmddyy" ) + ".txt"

	lds_InboundMessage.ImportFile ( ls_TemplatePath )

	lnv_Communication.ClearOFRErrors ( )
	li_Return = lnv_Communication.of_GetInBound(lds_InboundMessage)
	ll_ErrorCount = lnv_Communication.GetErrorCount ( )
	
	//ll_errorcount = upperbound(lnva_errors)
	
	if ll_errorcount > 0 then
		lnv_Communication.GetOFRErrors ( lnva_Errors )
		ls_errormessage = lnva_Errors [ ll_errorcount ].GetErrorMessage ( )

		if Len ( ls_errormessage ) > 0 then
			//OK
		else
			ls_errormessage = "Unspecified error on inbound processing."
		end if
	
		if len(ls_errormessage) > 0 then
			as_errormessage = ls_errormessage
			li_return = -1
		end if
	end if	

	//should we check return code for message if running visible
	//			messagebox("Process Inbound Message", "No messages to process.")
	
	IF isValid ( lds_InboundMessage ) THEN 

		lds_InboundMessage.SaveAs ( ls_TemplatePath , TEXT!, FALSE )
		
	END IF

	IF IsValid ( lnv_Communication ) THEN
		DESTROY lnv_Communication
	END IF
	
	IF isValid ( lds_InBoundMessage  ) THEN
		DESTROY lds_InBoundMessage
	END IF
	
END IF
//
return li_return
end event

event type integer ue_import(string as_type);String	ls_Null
String	ls_Error
n_cst_edi_Transaction_204	lnv_204
lnv_204 = Create n_cst_edi_Transaction_204

n_cst_edishipmentprocessmanager	lnv_EDIImportManager

IF THIS.of_LogOnAsSystem ( ) <> 1 THEN
//	Need to write an error
	ls_Error = "COULD NOT INITIALIZE PROFIT TOOLS. NO FILES IMPORTED"
	lnv_204.of_WriteErrorLog ( ls_Error )
ELSE
	
	//lnv_ShipmentManager.of_Import204ShipmentFile ( ls_Null )
	lnv_EdiImportManager = CREATE n_cst_edishipmentprocessmanager
	IF lnv_EDIImportManager.of_importpendingfiles( ) = 1 THEN
		IF lnv_EDIImportManager.of_processpendingshipments( ) <> 1 THEN
			ls_Error = lnv_EDIImportManager.of_GetErrorString ()
			IF Len ( ls_Error ) > 0 THEN 
				lnv_204.of_WriteErrorLog ( ls_Error )
			END IF
		END IF
	END IF
	DESTROY ( lnv_EDIImportManager )

END IF

DESTROY ( lnv_204 )

RETURN 1
end event

event ue_starteventscheduler(time at_killtime);THIS.of_Logonassystem( )
gnv_App.of_Getframe( ).Title = "Profit Tools Scheduler"
inv_Eventscheduler = CREATE n_cst_timer_eventhandler
inv_eventscheduler.of_Setkilltime( at_killtime )
inv_eventscheduler.Start( 1 )

Open ( w_TasksRunning  )

Constant ULong MINIMIZE  = 61472
post(Handle(gnv_app.of_GetFrame( ) ), 274, MINIMIZE , 0)
end event

event ue_stopeventscheduler();inv_eventscheduler.stop( )
end event

public function long of_getdbexpected ();RETURN il_DBExpected
end function

public function integer of_setdbexpected (long al_dbexpected);IF IsNull ( al_DBExpected ) THEN
	RETURN -1
END IF

il_DBExpected = al_DBExpected
RETURN 1
end function

public function boolean of_isregistryavailable ();//Overload to eliminate registry attempts in the application

RETURN FALSE
end function

public function integer of_getnextid (string as_class, ref long al_nextid, boolean ab_commit);//Overriding ancestor stub function.  Application-specific implementation (including
//call to SQLCA).

//Returns : 1, -1
// Revision: RDT 110702 - Added code for notificationstatus 

Integer	li_IdClass
SetNull ( li_IdClass )

CHOOSE CASE Lower ( as_Class )
	
CASE "n_cst_beo_transaction"
	li_IdClass = 1

CASE "n_cst_beo_amountowed"
	li_IdClass = 2

CASE "n_cst_beo_amounttype"
	li_IdClass = 3

CASE "n_cst_beo_ratetype"
	li_IdClass = 4

CASE "n_cst_beo_refnumtype"
	li_IdClass = 5

CASE "n_cst_beo_entity"
	li_IdClass = 6

CASE "n_cst_beo_equipmentleasetype"
	li_IdClass = 7

CASE "n_cst_beo_amounttemplate"
	li_IdClass = 8
	
CASE "route"
	li_IdClass = 9
	
CASE "communication_device"
	li_IdClass = 10

CASE "paysplit"
	li_IdClass = 11
	
CASE "edicontrol"
	li_IdClass = 12

CASE "ratecodename"
	li_IdClass = 14

CASE "rateid"
	li_IdClass = 15

CASE "notificationstatus"		// RDT 110702 
	li_IdClass = 16				// RDT 110702 

CASE "codedefault" 
	li_IdClass = 17
	
CASE "edi"
	li_IdClass = 18
	
CASE "arbatchid"
	li_IdClass = 19
	
CASE "useralert"
	li_IdClass = 20
	
CASE "event" , "n_cst_beo_event"
	li_IdClass = 21
	
CASE "item" , "n_cst_beo_item"
	li_IdClass = 22
	
CASE "n_cst_beo_shipment" , "shipment"
	li_idClass = 23
	
CASE  "documenttransfer"
	li_idClass = 24
CASE "privid"
	li_IdClass = 25
CASE "dwlink"
	li_IdClass = 26
CASE "errorlog"
	li_IdClass = 27
CASE "equipment" 
	li_IdClass = 28
CASE "documentnumber"
	li_IdClass = 29
CASE "interfacesequence"
	li_IdClass = 30
CASE "gen204request"	//added by dan 3-22-07
	li_idClass = 31
CASE "itintemplates"
	li_idClass = 32
	
	
END CHOOSE

RETURN SQLCA.of_GetNextId ( li_IdClass, al_NextId, ab_Commit )
end function

public function integer of_setcachemanager (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//   Function:        of_SetCacheManager
//
//   Access:        public
//
//   Arguments:
//   ab_switch      True - start (create) the service,
//                  False - stop (destroy) the service
//
//   Returns:        Integer
//                   1 - Successful operation.
//                   0 - No action taken.
//                  -1 - An error was encountered.
//                  
//   Description:     Starts or stops the CacheManager Service.
//
//////////////////////////////////////////////////////////////////////////////
    
//Check arguments
If IsNull(ab_switch) Then
   Return -1
End If
    
IF ab_Switch THEN
   IF IsNull(inv_CacheManager) Or Not IsValid (inv_CacheManager) THEN
      inv_CacheManager = CREATE n_cst_CacheManager
      Return 1
   END IF
ELSE
   IF IsValid (inv_CacheManager) THEN
      DESTROY inv_CacheManager
      Return 1
   END IF   
END IF
    
Return 0

end function

public function integer of_getliveloadpath (ref string as_path);

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1



SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 57 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK --
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE

IF li_Return = 1 THEN
	IF RIGHT ( ls_Description , 1 ) <> "\" THEN
		ls_Description += "\"
	END IF
	IF NOT FileExists ( ls_Description + "llapps\liveload.ini" ) THEN
		li_Return = -1
	ELSE
		as_Path = ls_Description
	END IF
END IF


RETURN li_Return


end function

public function string of_getapplicationfile ();string ls_FileName
ulong lul_Handle
ulong lul_Length

lul_Handle = handle(getapplication()) //get application handle
lul_Length = 255
ls_FileName = Space(lul_Length) //pre-allocate buffer

//Note: this call will work for the currently running application.

//If you run it from within PB, it will give you PB's application path.  
//When you compile and run you application it will return that application's path
GetModuleFilename (lul_Handle, ls_FileName, lul_Length)


RETURN ls_FileName
end function

public function string of_getapplicationfolder ();//Returns : The application folder path (the path to the folder containing trucking.exe).
//The folder path will have a "/" on the end of it.
//If the folder cannot be determined, returns the empty string.

//Under the development environment, we will be seeing the path to the powerbuilder
//executable, not trucking.exe, so in that case we'll provide the path to the working
//development folder.  This will never come up outside of the development context,
//so we can move the folder at our discretion.

String	ls_ApplicationFolder, &
			ls_ApplicationFile
Integer	li_Pos

IF Len ( is_ApplicationFolder ) > 0 THEN

	//The value's already been determined on a previous call.  Use it.
	ls_ApplicationFolder = is_ApplicationFolder

ELSE

	//Get the path to the application exe file.
	ls_ApplicationFile = Lower ( This.of_GetApplicationFile ( ) )

	//Find the exe portion of the string.
	li_Pos = Pos ( ls_ApplicationFile, "\trucking.exe" )

	IF li_Pos > 0 THEN

		//We found the exe.  Take the folder path to the left of it.
		ls_ApplicationFolder = Left ( ls_ApplicationFile, li_Pos )

	ELSE

		//Check if we're seeing the pb60.exe in the development environment.
		li_Pos = Pos ( ls_ApplicationFile, "\pb90.exe" )

		IF li_Pos > 0 THEN
			//We're in development.  Give the development working path.
			ls_ApplicationFolder = "c:\Dev\Working PT\PTOOLS\ptapp\"
		END IF

	END IF

	//If we got a value, store it for use by future calls.
	IF Len ( ls_ApplicationFolder ) > 0 THEN
		is_ApplicationFolder = ls_ApplicationFolder
	END IF

END IF

RETURN ls_ApplicationFolder
end function

public function integer of_logonassystem ();
String	ls_ValidPassword, &
			ls_Status, &
			ls_MessageHeader, &
			ls_User
Long		ll_ClassId, &
			ll_EmpId
n_cst_Privileges	lnv_Privileges
n_cst_LicenseManager	lnv_LicenseManager

ls_MessageHeader = "System Logon"

ls_User = cs_user_ptadmin
//Validate UserId and Password

SELECT em_id, em_class, em_status 
INTO :ll_EmpId, :ll_ClassId, :ls_Status
FROM employees WHERE em_ref = :ls_User ;


// this is just being set here since we are system, I don't think it is even referenced.
g_max_permit = "T"



CHOOSE CASE SQLCA.SqlCode

CASE -1
	ROLLBACK ;
//	messagebox(ls_MessageHeader, "Could not validate logon with database -- Please "+&
//		"retry.", exclamation!)
	RETURN -2

CASE 100
	COMMIT ;
//	messagebox(ls_MessageHeader, "The User ID you have specified is invalid -- "+&
//		"Please retry.", exclamation!)
	RETURN -2

CASE 0
	COMMIT ;
//	if as_Password = upper(ls_ValidPassword) then
//		//Password is valid
//	else
////		messagebox(ls_MessageHeader, "The Password you have specified is invalid -- "+&
////			"Please retry.", exclamation!)
//		RETURN -1
//	end if
//	if ls_Status <> 'K' then
//		messagebox(ls_MessageHeader, "The User ID you have specified has been " +&
//		"deactivated.", exclamation!)
//		RETURN -2
//	end if 

END CHOOSE


//Validate User Access Privileges

IF lnv_Privileges.of_SetEmployeeId ( ll_EmpId ) < 1 THEN
//	MessageBox ( ls_MessageHeader, "Could not validate employee ID.  Please retry.", &
//		Exclamation! )
	RETURN -2
END IF

IF lnv_Privileges.of_SetUserClass ( ll_ClassId ) < 1 THEN
//	MessageBox ( ls_MessageHeader, "Could not validate user class.  Please retry.", &
//		Exclamation! )
	RETURN -2
END IF

IF lnv_Privileges.of_System_Logon ( ) = FALSE THEN
//	messagebox(ls_MessageHeader, "Your current user settings specify that you are not " +&
//	"a system user.  Someone with access must change your privileges before you can " +&
//	"proceed.", exclamation!)
	RETURN -2
end if

// this is here because the of_Initialize call needs to know the user. 
THIS.of_SetUserID ( cs_user_ptadmin )
il_userid = ll_EmpId

IF lnv_Privileges.of_Initialize ( ) = -1 THEN
//	messagebox(ls_MessageHeader, "Could not retrieve user privilege settings from database -- Please "+&
//		"retry.", exclamation!)
	RETURN -2
END IF


lnv_Privileges.of_SetUserClass ( lnv_Privileges.ci_Class_Administrative )
RETURN 1
end function

public function n_cst_timers of_gettimers ();IF not isValid ( inv_timers ) THEN
	inv_Timers = CREATE n_cst_Timers 
END IF

RETURN inv_Timers
end function

public subroutine of_cachezones ();SetPointer(Hourglass!)
n_cst_licensemanager	lnv_licensemanager

//cache zones if autorating licensed 
if lnv_LicenseManager.of_HasAutoRatingLicensed() then
	n_cst_bso_rating	lnv_rating
	lnv_Rating = create n_cst_bso_rating
	//constructor will cache into shared variable
	if isvalid(lnv_rating) then
		destroy lnv_rating
	end if
end if
		

end subroutine

public function long of_getnextspecialops ();RETURN il_NextSpecialOps
end function

public function integer of_setnextspecialops (long al_value);integer	li_return = 1

IF IsNull ( al_value ) THEN
	li_return = -1
END IF

if li_return = 1 then
	il_NextSpecialOps = al_value
end if

RETURN li_return
end function

public function boolean of_runningscheduledtask ();RETURN ib_scheduledtask OR ib_globaleventscheduler
end function

public function integer of_disconnectfromdb ();///\\\ Functions are looking for the window title so don't change the title string below.  ///\\\

Int	li_Rtn
li_Rtn = SQLCA.of_disconnect ( )
IF li_Rtn = 0 THEN // success
	gnv_app.of_GetFrame ( ).Title = "Profit Tools for Trucking                         *** Database Connection Closed ***"
END IF
	
RETURN li_Rtn
end function

public function integer of_connecttodb ();Int		li_Return = 1
String	ls_IniFile

ls_inifile = gnv_app.of_GetAppIniFile()

SetPointer(Hourglass!)

IF SQLCA.of_Init(ls_inifile,"Database") = -1 THEN     
 	li_Return = -1
END IF  

IF li_Return = 1 THEN
	IF SQLCA.of_Connect() = -1 THEN     
		li_Return = -1
	ELSE
		gnv_app.of_GetFrame ( ).Title = "Profit Tools for Trucking"	
	END IF
END IF


IF li_Return = 1 THEN
//Clear DBParm Entry, for Security Reasons
	SQLCA.DBParm = ""
	
	//Register the application for authenticated engines
	
	String	ls_Authentication
	
	ls_Authentication = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='" +&
		"Company=Profit Tools;Application=Profit Tools;" +&
		"Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g3c11fae706313da0c4860f35d6e3836a3caf7f00'"
	
	EXECUTE IMMEDIATE :ls_Authentication ;
	COMMIT ;
END IF

Return li_Return


end function

public function boolean of_getrestrictedview ();environment env
GetEnvironment(env)

RETURN NOT env.ScreenWidth	>= 1024


end function

public function boolean of_bringtotop (unsignedlong al_winhandle);Return BringWindowToTop( al_winhandle )
end function

public function long of_findwindowbytitle (string as_wintitle);Return FindWindowA( 0, as_wintitle )
end function

public function boolean of_showwindow (long al_winhandle);Return ShowWindow( al_winhandle, 5 )
end function

public function boolean of_isapprunning ();// zmc - 2-12-04

Boolean lb_RtnVal 
Long	  ll_winhandle

n_cst_setting_ptmultipleinstancesallowed lnv_Instance
lnv_Instance = CREATE n_cst_setting_ptmultipleinstancesallowed

IF Upper(lnv_Instance.of_GetValue( )) = Upper(lnv_Instance.cs_No) THEN
	
	ll_winhandle	=	This.of_FindWindowByTitle( "Profit Tools for Trucking" )
	
	IF ll_winhandle  <= 0 THEN
		ll_winhandle	=	This.of_FindWindowByTitle( "Profit Tools for Trucking                         *** Database Connection Closed ***" )	
	END IF
	
	IF ll_winhandle > 0 THEN
		This.of_BringToTop( ll_winhandle )
		This.of_ShowWindow( ll_winhandle )
		lb_RtnVal = TRUE
	END IF
END IF
DESTROY(lnv_Instance)
Return lb_RtnVal
end function

public function n_cst_AlertManager of_getalertmanager ();IF Not isValid ( inv_alertmanager ) THEN
	inv_alertmanager = CREATE n_cst_AlertManager
END IF

RETURN inv_alertmanager
end function

public subroutine of_recordtime (string as_data);// this is here to help with internal debugging of heavy processing during development
is_reportingtime += "~r~n" + as_data + " - " + String ( NOW ( ) )

end subroutine

public function string of_getshipnoteformat (); IF is_shipnoteformat = "" THEN
	n_cst_Settings	lnv_Settings
 	is_shipnoteformat = lnv_Settings.of_GetShipNoteFormat ( ) 	 
END IF

RETURN is_Shipnoteformat
end function

private subroutine of_preloadsettings ();// call this to load any setting that you want loaded before they are needed.

this.of_Getshipnoteformat( )
end subroutine

public function long of_getnumericuserid ();RETURN il_Userid
end function

public function boolean of_attemptpcmilerconnection ();String	ls_IniFile
String	ls_User
Boolean 	lb_Return
ls_IniFile = this.of_Getappinifile( )

ls_User = THIS.of_Getuserid( )

lb_Return = ProfileString ( ls_IniFile, "PcmConnection", ls_User , "YES" ) = "YES"


RETURN lb_Return
end function

public function datastore of_getsettingscache ();RETURN ids_Setttingcache
end function

public function integer of_setsettingcache (datastore ads_cache);ids_Setttingcache = ads_cache
RETURN 1
end function

private function integer of_removeopenshipments (); /***************************************************************************************
NAME: of_RemoveOpenShipments

ACCESS:	Private
		
ARGUMENTS: 	(None)
					

RETURNS:		Integer
	
DESCRIPTION:
			Deletes all rows from the OpenShipments table for the 
			machine and userid that is running the application.


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
		Created 1/3/2006 - Maury

***************************************************************************************/
integer	li_Return
string 	ls_MachineName
Long		ll_UserId

n_cst_PlatformWin32 lnv_Platform

lnv_Platform = Create n_cst_PlatformWin32
ls_MachineName = lnv_Platform.of_GetComputerName()
ll_UserId = gnv_App.of_GetNumericUserId( )

IF Len ( ls_MachineName ) > 0 THEN

	DELETE FROM "openshipments"  
	   WHERE "openshipments"."machinename" = :ls_MachineName AND "openshipments"."userid" = :ll_UserId ;
	
	CHOOSE CASE SQLCA.SqlCode
	
	CASE 0
		COMMIT ;
		li_Return = 1
	
	CASE 100  //Fetched row not found
		COMMIT ;
		li_Return = 0
	
	CASE ELSE
		ROLLBACK ;
		li_Return = -1
	
	END CHOOSE
	
ELSE
	li_Return = 0
	
END IF

destroy lnv_platform

Return li_Return


end function

public function n_cst_privsManager of_getprivsmanager ();IF not isValid ( inv_privsmanager ) THEN
	inv_privsmanager = CREATE n_cst_privsmanager
END IF

RETURN inv_PRivsmanager
end function

public function string of_getrailtraceappname ();Return "Track and Trace"
end function

public function n_cst_threadmanager of_getthreadmanager ();IF NOT isValid ( inv_threadmanager ) THEN
	inv_threadmanager = CREATE n_cst_threadmanager
END IF

Return inv_threadmanager
end function

on n_cst_appmanager_trucking.create
call super::create
end on

on n_cst_appmanager_trucking.destroy
call super::destroy
end on

event constructor;call super::constructor;String	ls_ApplicationFolder, &
			ls_IniFile

//Get the application folder path, so we can provide a full path to the ini file.
ls_ApplicationFolder = This.of_GetApplicationFolder ( )
ls_IniFile = ls_ApplicationFolder + "trucking.ini"

//@(data)(recreate=no)<INI File>
of_SetAppIniFile(ls_IniFile)
gnv_bcmmgr.SetIniFile(ls_IniFile)
//@(data)--

//@(text)(recreate=yes)<Task Manager>
inv_TaskManager = create n_cst_taskmanager_trucking
//@(text)--

String	ls_Version, &
			ls_AppName, &
			ls_CopyRight, &
			ls_Logo
Long		ll_DBExpected, &
			ll_NextSpecialOps

ll_DBExpected = 123
ll_NextSpecialOps = 1
ls_Version = "4.1.35"
ls_AppName = "Profit Tools® for Trucking"
ls_CopyRight = "Copyright © 1996 - 2007 Profit Tools, Inc."
ls_Logo = "ptftw6.wmf"

of_SetDBExpected ( ll_DBExpected )
of_SetNextSpecialOps ( ll_NextSpecialOps )
of_SetVersion ( ls_Version )
of_SetAppName ( ls_AppName )
of_SetCopyRight ( ls_CopyRight )
of_SetLogo ( ls_Logo)

iapp_Object.ToolBarText = TRUE
iapp_Object.ToolBarTips = FALSE
iapp_Object.ToolBarUserControl = FALSE

Randomize ( 0 )


//Initialize Global Variables (Which should be eliminated)
setnull(null_int)
setnull(null_long)
setnull(null_dec)
setnull(null_date)
setnull(null_time)
setnull(null_datetime)
setnull(null_str)
setnull(null_char)
g_max_h = 2053
g_max_w = 3393
end event

event destructor;call super::destructor;//@(text)(recreate=yes)<Body>
destroy inv_taskmanager
//@(text)--

of_SetCacheManager ( FALSE )

/*
	Replaced all direct calls to pcms functions with functions on routing object.
	n_cst_trip determines correct routing object
*/

string	ls_version
n_cst_trip	lnv_trip
n_cst_routing	lnv_routing

boolean	lb_pcmilerinstalled
n_cst_licensemanager	lnv_licensemanager

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_PCMiler ) or &
	lnv_LicenseManager.of_usepcmilerstreets() THEN
	//ok to proceed
	IF pcmm_inst = FALSE THEN
		lb_pcmilerinstalled = false
	else
		lb_pcmilerinstalled = true
	end if
else
		lb_pcmilerinstalled = false
END IF


if lb_pcmilerinstalled then

	lnv_trip = create n_cst_trip
	if lnv_trip.of_connect(lnv_routing) then
		if lnv_routing.of_isvalid() then
			if lnv_routing.of_isstreets() then
	//			lnv_routing.of_cleanupmap()
			else
				ls_version = lnv_routing.of_about("ProductVersion")
				choose case ls_version
					case "14.0"
						lnv_routing.of_cleanupmap()
					case else //11.0, 12.0, 2000.0
						//don't do cleanup
				end choose
			end if
			lnv_trip.of_disconnect()
		end if
	end if
	destroy lnv_trip

end if


IF isValid ( inv_Timers ) THEN
	DESTROY ( inv_Timers )
END IF

IF isValid ( inv_alertmanager ) THEN
	DESTROY ( inv_alertmanager )
END IF

if lnv_LicenseManager.of_HasAutoRatingLicensed() then
	n_cst_bso_rating	lnv_rating
	lnv_rating = create n_cst_bso_rating
	if isvalid(lnv_rating) then
		lnv_rating.of_destroycache()
		destroy lnv_rating
	end if
end if

IF isValid ( inv_privsmanager ) THEN
	DESTROY ( inv_privsmanager )
END IF

IF isValid(inv_ThreadManager) THEN
	Destroy(inv_ThreadManager)
END IF
end event

event pfc_open;call super::pfc_open;//@(text)(recreate=yes)<Application Setup>
of_SetTrRegistration(TRUE)
inv_trregistration.of_register ( SQLCA )
//@(text)--


//Check the command line switches to see if we're being asked to run a liveload upload.
//If so, set the lb_LiveLoad flag so we can break off and process the request later.
// We will also be checking to see if a special request was made for the inbound 
// communication prcessing.

Boolean	lb_LiveLoad
Boolean	lb_Communication
Boolean	lb_pcmilerconnected
Boolean	lb_204	// import 204 shipments
Boolean	lb_Scheduled


Time		lt_KillTime
String	ls_Temp
String	ls_Device, &
			ls_errormessage
String	ls_ScheduleMsg
String	ls_RailTraceAppName

								// IMPORTANT NOTE 
/*
	Although it looks a though like the app will respond to multiple switches for 
	the same instance of the application,  IT WON'T
	Live Load needs to be alone.
*/


//IF messagebox ( "204" , "Run 204 ?" , QUESTION! , YESNO! , 1 ) = 1 THEN
//	as_CommandLine = "-204"
//END IF

//
//IF messagebox ( "EVENTS" , "Run SCHEDULER ?" , QUESTION! , YESNO! , 1 ) = 1 THEN
//	as_CommandLine = "-sched"
//END IF

IF Pos ( Lower ( as_CommandLine ), "-sched" ) > 0 THEN
	ib_GlobalEventScheduler = TRUE
	ls_Temp = String ( Mid ( as_commandline , 8 , 5 ) )
	SetNull ( lt_KillTime ) 
	IF isTime ( ls_Temp ) THEN
		lt_KillTime = Time ( ls_Temp )
	END IF
	
END IF


IF Pos ( Lower ( as_CommandLine ), "-ll" ) > 0 THEN
	lb_LiveLoad = TRUE
	lb_Scheduled = TRUE
END IF

IF Pos ( Lower ( as_CommandLine ), "-204" ) > 0 THEN	
	lb_204 = TRUE
	lb_Scheduled = TRUE
END IF

//	At this point if -comm is specified on the command line it should be last b/c of the 
//	additional device parameter
// we can put more logic here later to accept it in any place
IF Pos ( Lower ( as_CommandLine ), "-comm" ) > 0 THEN	
	lb_Communication = TRUE
	lb_Scheduled = TRUE
END IF

ib_scheduledtask = lb_Scheduled OR ib_GlobalEventScheduler
	
//The following is transplanted / edited HOW code from pfc_PostOpen in w_Frame_Trucking.

String	ls_inifile

ls_inifile = gnv_app.of_GetAppIniFile()

SetPointer(Hourglass!)
IF SQLCA.of_Init(ls_inifile,"Database") = -1 THEN     
 	MessageBox( "System Start-Up", "Unable to connect to database using " + ls_inifile +&
		"~n~nProgram will close.", Exclamation! ) 
	Event Trigger pfc_Exit ( )
	RETURN
END IF  

IF SQLCA.of_Connect() = -1 THEN     
	MessageBox( "System Start-Up", "Unable to connect to database using " + ls_inifile +&
		"~n~nProgram will close.", Exclamation! ) 
	Event Trigger pfc_Exit ( )
	RETURN
END IF
SetPointer(Arrow!)
//////////////////End of Transplanted Code

//Clear DBParm Entry, for Security Reasons
SQLCA.DBParm = ""

//Register the application for authenticated engines

String	ls_Authentication

ls_Authentication = "SET TEMPORARY OPTION CONNECTION_AUTHENTICATION='" +&
	"Company=Profit Tools;Application=Profit Tools;" +&
	"Signature=000fa55157edb8e14d818eb4fe3db41447146f1571g3c11fae706313da0c4860f35d6e3836a3caf7f00'"

EXECUTE IMMEDIATE :ls_Authentication ;
COMMIT ;

of_SetCacheManager ( TRUE )
n_cst_LicenseManager	lnv_LicenseManager

IF lnv_LicenseManager.of_ApproveConnection ( ) THEN
	//Connection Approved -- Proceed
ELSE
	Event Trigger pfc_Exit ( )
	RETURN
END IF


//delete any locked modules left over from improper shutdown
lnv_LicenseManager.of_DeleteModuleLocks ( )



//Initialize CacheManager

//of_SetCacheManager ( TRUE )


//Initialize Global DataStores

gnv_cst_companies = create n_cst_companies

gds_emp = create datastore
gds_emp.dataobject = "d_emp_list"
gds_emp.settransobject(sqlca)

gds_privs = create datastore
gds_privs.dataobject = "d_emp_classes"
gds_privs.settransobject(sqlca)

gds_pcmiles = create datastore
gds_pcmiles.dataobject = "d_pcmiles"




/* 
		Here we will respond to any command line args sent in
*/


//If a LiveLoad export has been requested, attempt it and shut down the application.
IF lb_LiveLoad THEN
	This.Event ue_LiveLoad ( as_CommandLine )
END IF

//If a communication import has been requested, attempt it and shut down the application.
IF lb_Communication THEN
	//i.e.  -comm qualcomm
	Int li_Pos
	li_Pos = Pos ( Lower ( as_CommandLine ), "-comm"  )
	ls_Device = Trim ( Mid ( Trim ( as_CommandLine ), li_Pos + 6 ) )
	IF Len ( Trim ( ls_Device ) ) > 0 THEN
		This.Event ue_communication ( ls_Device, ls_errormessage )
	END IF	
END IF

// IF a 204 Shipment import has been requested, attempt it and shut down the application.
IF lb_204 THEN
	THIS.Event ue_Import ( "204" )
END IF

// this will exit before login if being run by scheduler or switched command line args
IF lb_Scheduled THEN
	This.Event pfc_Exit ( )
	RETURN	
END IF


IF NOT ib_globaleventscheduler THEN
	// zmc - 2-12-04 - Start
	// Perform application instance running check.
	IF This.of_IsAppRunning() THEN
		This.Event pfc_Exit ( )
		RETURN   	
	END IF
	// zmc - 2-12-04 - End
	
	//Perform User LogIn
	
	IF of_LogonDlg ( ) = 1 THEN
		//Logon Successful -- Proceed
	ELSE
		Event Trigger pfc_Exit ( )
		RETURN
	END IF

	//Warn user if RailTrace app is not updating Profit Tools
	//Note: If a user with asa6 db restores a backup db, it will not
   //      auto enable the railtrace app. So warn here if RT is inactive.
	
	ls_RailTraceAppName = gnv_App.of_GetRailTraceAppName()
	IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_RailTrace ) THEN
		IF lnv_LIcenseManager.of_IsRailTraceSetup() THEN
			IF lnv_LicenseManager.of_IsRailTraceActiveOutbound() THEN
				IF NOT lnv_LicenseManager.of_IsRailTraceActiveInbound() THEN
					MessageBox("Program Initialization", "The " + ls_RailTraceAppName + " application is not currently "+&									
					"updating Profit Tools.~r~nTo enable " + ls_RailTraceAppName + " interaction go to Equipment system settings.", Exclamation!, OK!)
				END IF
			END IF
		END IF
	END IF
	
	//Connect to PC*Miler, if appropriate
	
	/*
		Replaced all direct calls to pcms functions with functions on routing object.
		n_cst_trip determines correct routing object
	*/
	SetPointer(Hourglass!)
	
	IF THIS.of_AttemptPCMilerConnection ( ) THEN

		if pcms_inst AND (lnv_LicenseManager.of_usepcmilerstreets() or &
				lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.ci_Module_PCMiler ) ) then
			setpointer(hourglass!)
			n_cst_trip	lnv_trip
			n_cst_routing	lnv_routing
			lnv_trip = create n_cst_trip
			if lnv_trip.of_isconnected() then
				//already connected
				lb_pcmilerconnected=true
			else
				if lnv_trip.of_connect(lnv_routing) then
					if lnv_routing.of_isvalid() then
						lb_pcmilerconnected=true
					else
						lb_pcmilerconnected=false
					end if
				else
					lb_pcmilerconnected=false
				end if
			end if
	
			if lb_pcmilerconnected then
				
				n_cst_PCMilerConversions	lnv_PCMilerConversions
				
				lnv_PCMilerConversions = create n_cst_PCMilerConversions
				
				lnv_PCMilerConversions.of_ConvertPQ(lnv_routing)
			
				destroy lnv_PCMilerConversions
				
			end if
			

			destroy lnv_routing
			destroy lnv_trip
		
			if lb_pcmilerconnected then
				//continue
			else
				IF ib_globaleventscheduler THEN
					
					
					ls_ScheduleMsg += "~r~nCould not connect to PC*Miler."
					
				ELSE
					if messagebox("Program Initialization", "Could not connect to PC*Miler.  Do you "+&
							"want to log on to Profit Tools anyway?", question!, yesno!, 2) = 2 then
							Event Trigger pfc_Exit ( )
						RETURN
					end if
				END IF
			end if
		end if
	ELSE
		
		// flag that pcMiler is not installed since some things/objects are just checking to see if it 
		// is installed, not conncted.
		
		pcmm_inst = FALSE
		pcms_inst = FALSE
		pcms_on = FALSE
		
		
	END IF
	
	//Retrieve Employee List
	
	setpointer(hourglass!)
	
	if gds_emp.retrieve() = -1 then
		rollback ;
		messagebox("Program Initialization", "Could not retrieve employee list from "+&
			"database.~n~rProgram will close.", exclamation!)

		Event Trigger pfc_Exit ( )
		RETURN
	else
		commit ;
	end if
	
	g_emp_refresh = datetime(today(), now())
	g_emp_update = g_emp_refresh
	
ELSE
	THIS.Post event ue_starteventscheduler( lt_KillTime )
END IF

this.post of_cachezones()
THIS.post of_preloadsettings( )


//@(data)(recreate=yes)<Application Options>
Open(iw_frame, "w_frame_trucking")
//@(data)--
	
IF NOT ib_GlobalEventScheduler THEN
	n_cst_AlertManager	lnv_AlertManager
	lnv_AlertManager = CREATE n_cst_AlertManager
	lnv_AlertManager.of_Showsystemalerts( )
	Destroy ( lnv_AlertManager )
END IF

//delete any open shipment windows left over from improper shutdown
This.of_RemoveOpenShipments()

end event

event pfc_logon;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_logon  OVERRIDING ANCESTOR
//
//	Arguments:
//	as_userid   User ID attempting to logon
//	as_password   Password of user attempting to logon
//
//	Returns:  integer
//	 1 = successful logon
//	-1 = failure (Invalid Password)
//	-2 = Failure (Invalid User, Other General Failure) **This is an extension**
//
//	Description:  Specific logon functionality for the application.
//	Perform logon processing based on User ID and password given.
//
//	Note:  this event will be responsible for displaying any error messages
//	if the logon fails for any reason.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_ValidPassword, &
			ls_Status, &
			ls_MessageHeader
Long		ll_ClassId, &
			ll_EmpId
n_cst_Privileges	lnv_Privileges
n_cst_LicenseManager	lnv_LicenseManager

ls_MessageHeader = "System Logon"


//Validate UserId and Password

SELECT em_id, em_password, em_max_permit, em_class, em_status 
INTO :ll_EmpId, :ls_ValidPassword, :g_max_permit, :ll_ClassId, :ls_Status
FROM employees WHERE em_ref = :as_UserId ;

CHOOSE CASE SQLCA.SqlCode

CASE -1
	ROLLBACK ;
	messagebox(ls_MessageHeader, "Could not validate logon with database -- Please "+&
		"retry.", exclamation!)
	RETURN -2

CASE 100
	COMMIT ;
	messagebox(ls_MessageHeader, "The User ID you have specified is invalid -- "+&
		"Please retry.", exclamation!)
	RETURN -2

CASE 0
	COMMIT ;
	if as_Password = upper(ls_ValidPassword) then
		//Password is valid
	else
		messagebox(ls_MessageHeader, "The Password you have specified is invalid -- "+&
			"Please retry.", exclamation!)
		RETURN -1
	end if
	if ls_Status <> 'K' then
		messagebox(ls_MessageHeader, "The User ID you have specified has been " +&
		"deactivated.", exclamation!)
		RETURN -2
	end if 

END CHOOSE


//Validate User Access Privileges

IF lnv_Privileges.of_SetEmployeeId ( ll_EmpId ) < 1 THEN
	MessageBox ( ls_MessageHeader, "Could not validate employee ID.  Please retry.", &
		Exclamation! )
	RETURN -2
END IF

IF lnv_Privileges.of_SetUserClass ( ll_ClassId ) < 1 THEN
	MessageBox ( ls_MessageHeader, "Could not validate user class.  Please retry.", &
		Exclamation! )
	RETURN -2
END IF

IF lnv_Privileges.of_System_Logon ( ) = FALSE THEN
	messagebox(ls_MessageHeader, "Your current user settings specify that you are not " +&
	"a system user.  Someone with access must change your privileges before you can " +&
	"proceed.", exclamation!)
	RETURN -2
end if

// this is here because the of_Initialize call needs to know the user. 
gnv_app.is_userid = as_UserId 

IF lnv_Privileges.of_Initialize ( ) = -1 THEN
	messagebox(ls_MessageHeader, "Could not retrieve user privilege settings from database -- Please "+&
		"retry.", exclamation!)
	RETURN -2
END IF


il_userid = ll_EmpId

lnv_LicenseManager.of_AddOperation() //Update Op with empid

RETURN 1
end event

event pfc_prelogondlg;call super::pfc_prelogondlg;anv_LogonAttrib.ii_LogonAttempts = 32767
anv_LogonAttrib.is_AppName = "Profit Tools"  //Overriding full name used by default
end event

event pfc_close;call super::pfc_close;n_cst_LicenseManager lnv_LicenseManager
//delete any locked modules
lnv_LicenseManager.of_DeleteModuleLocks ( )


end event

