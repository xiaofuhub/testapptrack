$PBExportHeader$n_cst_bso_communication_manager.sru
forward
global type n_cst_bso_communication_manager from n_cst_bso
end type
end forward

shared variables
////begin modification Shared Variables by appeon  20070730
//
//Boolean		sb_AllowInbound = TRUE
//
//n_ds	sds_deviceCache
//n_ds	sds_commequipidcache
//
//datastore  sds_Destination
////end modification Shared Variables by appeon  20070730
end variables

global type n_cst_bso_communication_manager from n_cst_bso
end type
global n_cst_bso_communication_manager n_cst_bso_communication_manager

type variables
Public:

CONSTANT String cs_EMPLOYEE = "EMPLOYEE"
CONSTANT String cs_EQUIPMENT = "EQUIPMENT"

Protected:
String is_DeviceType

//begin modification Shared Variables by appeon  20070730

Boolean		sb_AllowInbound = TRUE

//n_ds	sds_deviceCache
//n_ds	sds_commequipidcache

//datastore  sds_Destination
//end modification Shared Variables by appeon  20070730

end variables

forward prototypes
public function integer of_refreshdevicecache ()
public function datastore of_getdestinationlist ()
protected function integer of_getequipmentid (string as_equipmentref, ref long al_equipmentid)
public function integer of_getinbound (ref datastore ads_message)
protected function integer of_getsystemtemplatepath (ref string as_filepath)
public function integer of_getinboundpath (ref string as_filepath)
public function integer of_getcommunicationdevice (ref string asa_device[], boolean ab_displayresponse)
public function integer of_messagelog (ref n_cst_msg anv_msg)
public function integer of_getlicenseddevices (ref string asa_devicelist[])
public function integer of_purgelogs (ref datawindow adw_messageLog)
public function boolean of_isinboundallowed ()
public function integer of_sendoutbound (n_cst_msg anv_message)
private function integer of_sendtoclipboard (readonly n_cst_msg anv_message)
public function integer of_getmiscdevices (ref string asa_devices[])
public function integer of_getlicensedmobiledevices (ref string asa_devicelist[])
public function integer of_getlicensednonmobiledevices (ref string asa_Devices[])
protected function integer of_populatedestinationdisplay ()
protected function boolean of_isdaylightsavingstime (datetime adt_sent)
public function datastore of_getdevicecache (boolean ab_forcerefresh)
public function n_ds of_getcommequipcache (boolean ab_forcerefresh)
public function integer of_refreshcommequipcache ()
protected function integer of_retrievedevicelist (ref n_ds ads_devicelist)
protected function integer of_retrievecommequiplist (ref n_ds ads_commequiplist)
protected function integer of_errorlog (string as_filename, string as_text, boolean ab_header)
protected function integer of_setauthentication (string as_vehicle)
protected function boolean of_routeshipmentuponcreation ()
public function integer of_testrouting ()
protected function integer of_routeshipment (n_cst_messagedata anv_msgdata, long al_shipmentid, ref n_cst_msg anv_msg)
public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_MessageData anv_MsgData, boolean ab_lastrecorded)
protected function integer of_senddirections (ref n_cst_messagedata anv_msgdata, string as_errortext)
protected function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext)
public function integer of_testassignment ()
protected function integer of_processnewshipmentrequest (ref n_cst_messagedata anv_msgdata)
protected function integer of_replywitherror (n_cst_messagedata anv_msgdata, string as_errortext)
protected function integer of_processinboundmessages (ref n_cst_messagedata anva_msgdata[], ref datastore ads_message)
private function integer of_processdepart (ref n_cst_messagedata anv_msgdata, ref n_cst_beo_event anv_event, ref n_cst_bso_dispatch anv_dispatch)
private function integer of_processarrive (ref n_cst_messagedata anv_msgdata, ref n_cst_beo_event anv_event)
private function integer of_processcontainer (ref n_cst_messagedata anv_msgdata, ref long al_eqid)
private function integer of_processchassis (ref n_cst_messagedata anv_msgdata, ref long al_eqid)
protected function integer of_validateshipmentcreation (ref n_cst_messagedata anv_msgdata)
protected function integer of_createshipment (n_cst_messagedata anv_msgdata, ref n_cst_msg anv_msg)
protected function integer of_assignequipment (ref n_cst_messagedata anv_msgdata, long al_shipment)
public function integer of_processtrailer (ref n_cst_messagedata anv_msgdata, ref long al_eqid)
protected function integer of_processarrivedepart (ref n_cst_messagedata anv_msgdata)
public function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext, boolean ab_createdevice)
protected function integer of_findeventfortruck (ref n_cst_messagedata anv_msgdata)
public function integer of_displaypositionreport (long al_equipmentid, long al_driverid, s_co_info astr_site, boolean ab_lastrecorded)
public function integer of_populatemessagedata (n_cst_messagedata anv_msgdata, long al_cacherow)
public function boolean of_hascommunicationdevice (long al_equipmentid, long al_driverid, ref string as_devicetype, ref long al_deviceid, ref long al_cacherow, ref boolean ab_driverdevice)
public function integer of_displaypositionmap (n_cst_messagedata anv_msgdata, s_co_info astr_site, n_cst_trip anv_trip)
public function integer of_getlastrecordedposition (long al_equipmentid, ref n_cst_messagedata anv_msgdata)
protected function integer of_processspecialfields (n_cst_messagedata anv_msgdata)
public function integer of_unitidlookup (long al_eqid, ref string as_unitid, ref string as_unittype)
protected function integer of_processdutystatus (ref n_cst_messagedata anv_msgdata)
protected function integer of_replytodutystatuschange (n_cst_messagedata anv_messagedata, string as_newstatus)
protected function integer of_replywithsuccess (n_cst_messagedata anv_msgdata)
public function integer of_sourceentityidlookup (string as_unitid, ref long al_entityid, ref string as_resulttype)
public function integer of_sourceentityidlookup (string as_unitid, ref long al_entityid, ref string as_resulttype, string as_devicetype)
end prototypes

public function integer of_refreshdevicecache ();// RETURNS 1 success, -1 Failure

Int	li_Return = -1
Int	li_RetrieveRtn
n_ds	lds_Cache

li_RetrieveRtn = THIS.of_RetrieveDeviceList ( lds_Cache ) 

IF li_RetrieveRtn = 1 THEN
	li_Return = 1 
	DESTROY sds_DeviceCache
	sds_DeviceCache = lds_Cache
ELSE
	DESTROY lds_Cache
	li_Return = -1
END IF


RETURN li_Return
end function

public function datastore of_getdestinationlist ();IF IsValid ( sds_Destination ) THEN
	
ELSE
	THIS.of_PopulateDestinationDisplay ()
END IF

RETURN sds_Destination
end function

protected function integer of_getequipmentid (string as_equipmentref, ref long al_equipmentid);string	ls_null, &
			ls_FindString
			
long		ll_FoundRow, &
			ll_FoundAnotherRow
			
Integer	li_Return = 0			

datastore lds_Equip

setnull ( ls_null )
n_cst_Equipmentmanager	lnv_Equipmentmanager

IF lnv_Equipmentmanager.of_Get_Retrieved_Equip ( ) = FALSE THEN
	
	lnv_Equipmentmanager.of_RefreshActive ( )
	
END IF

lds_Equip = lnv_Equipmentmanager.of_get_ds_equipment ( )

ls_FindString = "eq_status = 'K' AND eq_ref = " + "'" + as_EquipmentRef + "'"  // k = active

ll_foundrow = lds_Equip.find(ls_FindString, 1, lds_equip.rowcount())

IF ll_foundrow > 0 THEN
	IF ll_FoundRow < lds_equip.rowcount() THEN
		//Let's see if there is another one
		ll_FoundAnotherRow = lds_Equip.find(ls_FindString, ll_foundrow + 1, lds_equip.rowcount())
	END IF
	
	IF ll_FoundAnotherRow > 0 THEN
		
		//we have a problem, return a null value
		setnull ( al_EquipmentId )
		li_Return = 2
		
	ELSE
		
		al_EquipmentId = lds_Equip.object.eq_id [ ll_FoundRow ]
		li_Return = 1
		
		
	END IF
	
ELSE
	setnull ( al_EquipmentId )
	li_Return = 0
	
END IF	
		
		
return li_Return





end function

public function integer of_getinbound (ref datastore ads_message);RETURN -1
// implemented by descendent
end function

protected function integer of_getsystemtemplatepath (ref string as_filepath);Integer 	li_Return
String	ls_Path

li_Return = 1

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_Path = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )

IF Len ( ls_Path ) = 0 THEN
	li_Return = -1 
END IF

IF li_Return = 1 THEN
	as_FilePath = ls_Path + "MESSAGE\" + is_DeviceType + "\OUTBOUND\"
END IF

return li_return
end function

public function integer of_getinboundpath (ref string as_filepath);Integer 	li_Return
String	ls_Path

li_Return = 1

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_Path = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )

IF Len ( ls_Path ) = 0 THEN
	li_Return = -1 
END IF

IF li_Return = 1 THEN
	as_FilePath = ls_Path + "MESSAGE\" + is_DeviceType + "\INBOUND\"
END IF

return li_return
end function

public function integer of_getcommunicationdevice (ref string asa_device[], boolean ab_displayresponse);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCommunicationDevice
//
//	Access:  public
//
//	Arguments:  device string array by reference
//
//
// Returns:		number of device types found, if the user cancels out of the box 
//					0 will be returned.
//
//	Description:	
// 		Search the communication device table for the types of devices
//			being used. Pass back the device string array and return the 
//			number of device types being used. 
//	
//			This method should be used to determine which communication device
//			object needs to be instantiated.  If more than one device type is 
//			is found then a response window is needed for a device selection.
//
//
// Written by: Norm LeBlanc
// 		Date: 12/13/00
//		Version: 3.0.5
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

Integer	li_Devicecnt
Long		ll_RowCount = -1
String	lsa_FoundDevices[]
Long	i
Boolean	lb_Continue = TRUE
DataStore	lds_DeviceSelection

lds_DeviceSelection = Create dataStore
lds_DeviceSelection.DataObject = "d_DeviceSelection"

IF isValid ( lds_DeviceSelection ) THEN
	
	lds_DeviceSelection.SetTransObject ( sqlca )
	lds_DeviceSelection.Retrieve ( )
	
	ll_RowCount = lds_DeviceSelection.RowCount ( )
	
	IF ll_RowCount = 1 THEN
		
		lsa_FoundDevices[1] = lds_DeviceSelection.GetItemString ( 1 , "type" )
		li_DeviceCnt = UpperBound ( lsa_FoundDevices ) 
	ELSEIF ll_RowCount > 1 AND ab_displayresponse THEN
		
		openWithParm ( w_DeviceSelection , lds_DeviceSelection )
		
		IF Len ( Trim ( Message.StringParm ) )> 0 THEN
			lsa_FoundDevices[1] = Message.StringParm 
		ELSE
			lb_Continue = FALSE  // user canceled
		END IF
		li_DeviceCnt = UpperBound ( lsa_FoundDevices ) 
	ELSEIF ll_RowCount > 0 AND ab_displayresponse = FALSE THEN
		// i was grabing all the data at once w/ lsa_FoundDevices = lds_DeviceSelection.Object.data
		// but this started causing problems ( ???? i.e. type missmatch ) so I went with the loop
		For i = 1 TO ll_RowCount 		
			lsa_FoundDevices[i] = lds_DeviceSelection.Object.type[i]
		NEXT
		
		li_DeviceCnt = UpperBound ( lsa_FoundDevices ) 
	ELSE
		li_DeviceCnt = -1
	END IF

	asa_device = lsa_FoundDevices
	
		
END IF

IF NOT lb_Continue THEN
	li_DeviceCnt = 0
END IF
Return li_Devicecnt
end function

public function integer of_messagelog (ref n_cst_msg anv_msg);string		ls_Device, &
				ls_FilePath
String		lsa_DeviceList[ ]
String		ls_Today
Boolean		lb_OpenDlg = TRUE
long			ll_DeviceCount
Int			li_Return = 1
Boolean		lb_Continue = TRUE
n_cst_Msg	lnv_Msg
S_Parm		lstr_Parm

w_inboundmessages	lw_message
datastore	lds_InboundMessage

lds_InboundMessage = 	CREATE datastore

lds_InboundMessage.DataObject = "d_communicationlog"
lds_InboundMessage.SetTransObject ( SQLCA ) 

IF anv_Msg.of_Get_Parm ( "DEVICE" , lstr_Parm ) <> 0 THEN
	ls_Device = lstr_Parm.ia_Value
ELSE
	//need to check table for device, if more than one type
	//then display response window ot pick one
	
	ll_DeviceCount = THIS.of_GetCommunicationDevice ( lsa_DeviceList ,lb_OpenDlg ) 
	IF ll_DeviceCount > 0 AND UpperBound (lsa_DeviceList) > 0  THEN
		ls_Device = lsa_DeviceList[1]
	ELSEIF ll_DeviceCount = 0 THEN // userCaneled
		lb_Continue = FALSE
	END IF
	
	IF Len (Trim ( ls_Device ) ) > 0 THEN
		lstr_Parm.is_Label = "DEVICE"
		lstr_Parm.ia_Value = ls_Device
		lnv_Msg.of_Add_Parm ( lstr_Parm )
	END IF
	
END IF

// build path from system templatepath + "\message\" + device + "\inbound\ 'today'.txt"
IF Len (Trim ( ls_Device ) ) > 0 THEN
	
	is_DeviceType = ls_Device
	
	THIS.of_GetInboundPath ( ls_FilePath )
	
	ls_Today = String ( Today ( ) , "mmddyy" ) + ".txt"
	
	ls_FilePath += ls_Today
	lds_InboundMessage.ImportFile ( ls_FilePath )
	
	lstr_Parm.is_Label = "DATASOURCE"
	lstr_Parm.ia_Value = lds_InboundMessage
	lnv_Msg.of_Add_Parm ( lstr_Parm )
	
END IF

anv_msg = lnv_Msg

IF NOT lb_Continue THEN
	li_Return = 0 
END IF

RETURN li_Return
end function

public function integer of_getlicenseddevices (ref string asa_devicelist[]);//n_cst_licensemanager	lnv_LicenseManager
//
//
//IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Qualcomm ) THEN
//	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_Qualcomm
//END IF
//IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_InTouch ) THEN
//	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_InTouch
//END IF
//IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AtRoad )  THEN
//	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_AtRoad
//END IF
//IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_ClipBoard )  THEN
//	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_ClipBoard
//END IF

String	lsa_Mobile[]
String	lsa_NonMobile[]
Int		i
Int		li_NumNonMobile

THIS.of_GetLicensedMobileDevices ( lsa_Mobile )
li_NumNonMobile = THIS.of_GetLicensedNonMobileDevices ( lsa_NonMobile )
 
asa_DeviceList = lsa_Mobile
For i = 1 TO li_NumNonMobile
	asa_DeviceList[UpperBound( asa_DeviceList ) + 1 ] =  lsa_NonMobile [i] 
NEXT

RETURN upperBound ( asa_DeviceList )
end function

public function integer of_purgelogs (ref datawindow adw_messageLog);n_cst_Msg	lnv_msg
s_Parm		lstr_parm
s_anys 		lstr_return
Date			ld_StartDate
Date			ld_EndDate
long			i
long			ll_RowCount
long			ll_MsgCount


IF IsValid ( adw_messagelog ) THEN
	lstr_Parm.is_Label = "OPTIONAL"
	lstr_Parm.ia_Value = "FALSE"
	lnv_msg.of_Add_Parm ( lstr_Parm )
	
	openWithParm ( w_Date_Range, lnv_Msg )
	
	lstr_return = Message.PowerobjectParm
	
	IF UpperBound ( lstr_return.anys ) = 3 THEN
		ld_StartDate = lstr_Return.anys[2]
		ld_EndDate	 = lstr_Return.anys[3]
		
		ll_RowCount = adw_messagelog.Rowcount ( )
		
		FOR i = ll_RowCount TO 1 STEP -1
			IF adw_messagelog.object.message_Date[i] >= ld_StartDate AND adw_messagelog.object.message_Date[i] <= ld_EndDate THEN
				adw_messagelog.DeleteRow ( i )
				ll_MsgCount ++
			END IF
		NEXT	
	END IF
	
END IF

RETURN ll_MsgCount
end function

public function boolean of_isinboundallowed ();RETURN sb_Allowinbound
end function

public function integer of_sendoutbound (n_cst_msg anv_message);String	ls_Device
S_Parm	lstr_parm
Int		li_Return = -1



IF anv_message.of_Get_Parm ( "DEVICE" , lstr_Parm ) <> 0 THEN 
	ls_Device = lstr_Parm.ia_Value
	
	IF ls_Device = n_cst_constants.cs_ClipBoard THEN
		IF THIS.of_SendToClipBoard ( anv_message ) = 1 THEN
			li_Return = 1
		END IF
	END IF
	
END IF

RETURN li_Return
// implemented by descendent
end function

private function integer of_sendtoclipboard (readonly n_cst_msg anv_message);/*
	This will return:
					-1 = ERROR  (default)
					 1 = successful completion
*/		

// NOTE/Question , How do we want to handle multiple messages. if we support them, then we will have to 
// implement some sort of stack since the clipboard will be written over every time a new 
//	message is processed.

Int			li_Return = -1

long		ll_MessageCnt, &
			ll_MessageNdx, &
			ll_EquipmentId
			
String	ls_TemplatePath, &
			ls_Topic, &
			ls_FreeFormText

BOOLEAN	lb_FreeForm			

any	laa_Message[], &
		laa_beo[], &
		laa_Empty[]

S_Parm						lstr_Parm
n_cst_clipboard			lnv_ClipBoard
s_outboundMessage			lstra_Messages []
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
n_cst_msg					lnv_BlankMessage

//	populate template
IF anv_message.of_Get_Parm ("FREEFORMTEXT", lstr_Parm ) <> 0 THEN
	ls_FreeFormText = lstr_Parm.ia_Value
	lb_FreeForm = TRUE
END IF

IF anv_message.Of_Get_Parm ( "DATA" , lstr_Parm ) <> 0 THEN
	laa_Beo = lstr_Parm.ia_Value 
ELSEIF lb_FreeForm THEN 
	laa_beo = laa_Empty // need to send an array as a parm to of_CreateReports()
ELSE
	li_Return = -1
END IF

IF anv_message.of_Get_Parm ( "MESSAGES" , lstr_Parm ) <> 0 THEN
	lstra_Messages = lstr_Parm.ia_Value 

	ll_MessageCnt = UpperBound ( lstra_Messages )
	
	FOR ll_MessageNdx = 1 TO ll_MessageCnt
		
		lnv_TagMessage = lnv_BlankMessage
		ls_TemplatePath = lstra_Messages[ll_MessageNdx].is_Template
		ls_Topic = lstra_Messages[ll_MessageNdx].is_Topic
		ll_equipmentID = lstra_Messages[ll_MessageNdx].il_destination 
		
		lstr_parm.is_Label = "NUMBERTAGS"
		lstr_Parm.ia_Value = '' 
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )

		IF lb_FreeForm THEN
			lstr_parm.is_Label = "#.FREEFORMTEXT"
			lstr_Parm.ia_Value = ls_FreeFormText
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
		END IF

		IF lnv_ReportManager.of_CreateReport ( ls_Topic, ls_TemplatePath, laa_Beo, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
			//WE MAY NOT WANT TO DO THIS WHEN WE PROCESS MULTIPLE MESSAGES /
			// what about the clipboard !!!!! 
			li_Return = -1
			EXIT
		END IF
		
	NEXT

	IF UpperBound ( laa_Message ) > 0 THEN
		lnv_ClipBoard.of_SetContents ( laa_Message )
		li_Return = 1
	END IF
	
END IF
		
RETURN li_Return
end function

public function integer of_getmiscdevices (ref string asa_devices[]);// this method will pass out by reference any misc devices. i.e. Clipboard
// it will return the number of devices added to the array



Int	  li_DeviceCount
String  lsa_devices[ ]

li_DeviceCount ++
lsa_Devices [ li_DeviceCount ] = n_cst_Constants.cs_Clipboard

//li_DeviceCount ++
//lsa_Devices [ li_DeviceCount ] =

asa_Devices = lsa_Devices
Return li_DeviceCount

end function

public function integer of_getlicensedmobiledevices (ref string asa_devicelist[]);n_cst_licensemanager	lnv_LicenseManager


IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Qualcomm ) THEN
	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_Qualcomm
END IF
IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_InTouch ) THEN
	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_InTouch
END IF
IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_AtRoad )  THEN
	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_AtRoad
END IF

IF lnv_LicenseManager.of_GetLicensed ( n_cst_Constants.cs_Module_Cadec )  THEN
	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_Cadec
END IF

IF lnv_LicenseManager.of_HasCommunicationsLicense ( ) THEN
	asa_DeviceList[ upperBound( asa_DeviceList ) + 1 ] = n_cst_Constants.cs_Module_Nextel
END IF

Return upperBound( asa_DeviceList )
end function

public function integer of_getlicensednonmobiledevices (ref string asa_Devices[]);n_cst_LicenseManager	lnv_LicManager

IF lnv_LicManager.of_GetLicensed ( n_cst_Constants.cs_ClipBoard ) THEN 
	asa_Devices[ Upperbound ( asa_devices ) + 1 ] = n_cst_Constants.cs_ClipBoard
END IF

Return Upperbound ( asa_Devices )

end function

protected function integer of_populatedestinationdisplay ();Int		i 
Long		ll_EmployeeID
Long		ll_EquipID
Long		ll_RowCount
Long		ll_NewRow
String	ls_String


n_ds	lds_Cache
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_EquipmentManager	lnv_EquipmentManager
SetPointer ( HOURGLASS! )
lds_Cache = THIS.of_GEtDeviceCache ( FALSE )
IF isValid ( lds_Cache ) THEN
	
	IF Not Isvalid ( sds_Destination ) THEN
		sds_Destination = CREATE Datastore
		sds_Destination.Dataobject = "d_communication_destination_display"
	END IF
	
	ll_RowCount = lds_cache.RowCount ( )
	

	For i = 1 TO ll_RowCount 
		ll_EmployeeID = lds_Cache.getitemNumber ( i , "employeeid" )
		ll_EquipID = lds_Cache.getitemNumber ( i , "equipmentid" )
		
		IF Not IsNull ( ll_EmployeeID ) THEN
			lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeID, ls_String , 101 /*Lname 1st*/ )
		ELSE
			lnv_EquipmentManager.of_Get_Description ( ll_EquipID , "SHORT_REF!", ls_String )
		END IF
		
		IF len (ls_String ) > 0 THEN
			ll_NewRow = sds_Destination.InsertRow (0)
			
			IF ll_NewRow > 0 THEN
				sds_Destination.SetItem (ll_NewRow, "destination", ls_String )
				sds_Destination.SetItem (ll_NewRow, "employeeid", ll_EmployeeID)
				sds_Destination.SetItem (ll_NewRow, "equipmentid", ll_EquipID )
			END IF
			ls_String = ""
		END IF
			
	NEXT
END IF

RETURN 1



end function

protected function boolean of_isdaylightsavingstime (datetime adt_sent);/*	Does datetime argument fall within daylight savings time ?
	DST begins on the first Sunday of April at 2:00 am and 
	ends on the last Sunday of October at 2:00 am.
*/

boolean	lb_DaylightSavingsTime

integer	li_DSTYear, &
			li_DSTDay, &
			li_Ndx

string	ls_DayName

datetime	ldt_BeginningDST, &
			ldt_EndingDST
			
n_cst_datetime	lnv_DateTime			
li_DSTYear = year ( today ( ) )

//get 1st sunday of April
FOR li_Ndx = 1 to 30

	ls_DayName = DayName ( DATE(string(li_DSTYear) + "-" + "04" + "-" + string(li_Ndx)) )
	IF	upper ( ls_DayName ) = "SUNDAY" THEN
		li_DSTDay = li_Ndx
		EXIT
	END IF
	
NEXT

IF li_DSTDay > 0 THEN
	ldt_BeginningDST = datetime ( date ( string(li_DSTYear) + "-" + "04" + "-" + string(li_DSTDay) ), Time("01:59:59") ) 
END IF

//get last sunday of October
li_DSTDay = 0
FOR li_ndx = 31 to 1 STEP -1
	
	ls_DayName = DayName ( date(string(li_DSTYear) + "-" + "10" + "-" + string(li_Ndx)) )
	IF	upper ( ls_DayName ) = "SUNDAY" THEN
		li_DSTDay = li_Ndx
		EXIT
	END IF
	
NEXT

IF li_DSTDay > 0 THEN
	ldt_EndingDST = datetime ( date ( string(li_DSTYear) + "-" + "10" + "-" + string(li_DSTDay) ), Time("02:00:00") ) 
END IF

//CHECK DATE
IF lnv_DateTime.of_SecondsAfter ( ldt_BeginningDST, adt_sent ) > 0 THEN
	
	IF lnv_DateTime.of_SecondsAfter ( ldt_EndingDST, adt_sent ) < 0 THEN
		
		lb_DaylightSavingsTime = TRUE
		
	ELSE
		
		lb_DaylightSavingsTime = FALSE
	
	END IF
	
ELSE
	
	lb_DaylightSavingsTime = FALSE
	
END IF 

	
return lb_DaylightSavingsTime 

end function

public function datastore of_getdevicecache (boolean ab_forcerefresh);DataStore 	lds_Cache


IF ab_forceRefresh OR NOT isValid ( sds_DeviceCache ) THEN
	THIS.of_RefreshDeviceCache ( )
END IF

IF isValid ( sds_DeviceCache ) THEN
	lds_Cache = sds_DeviceCache	
END IF

RETURN lds_Cache 

end function

public function n_ds of_getcommequipcache (boolean ab_forcerefresh);n_ds lds_cache

IF ab_forceRefresh OR NOT isValid ( sds_commequipidcache ) THEN
	THIS.of_RefreshcommequipCache ( )
END IF

IF isValid ( sds_commequipidcache ) THEN
	lds_Cache = sds_commequipidcache	
END IF

return lds_cache
end function

public function integer of_refreshcommequipcache ();// RETURNS 1 success, -1 Failure

Int	li_Return = -1
Int	li_RetrieveRtn
n_ds	lds_Cache

li_RetrieveRtn = THIS.of_RetrievecommequipList ( lds_Cache ) 

IF li_RetrieveRtn = 1 THEN
	li_Return = 1 
	DESTROY sds_commequipidcache
	sds_commequipidcache = lds_Cache
ELSE
	DESTROY lds_Cache
	li_Return = -1
END IF


RETURN li_Return
end function

protected function integer of_retrievedevicelist (ref n_ds ads_devicelist);// RETURNS 1 , success	-1 Faliure

int	li_Return 
Int	li_RetrieveRtn

IF IsValid ( ads_devicelist ) THEN
	Destroy ads_devicelist
END IF

ads_DeviceList = CREATE n_ds
ads_DeviceList.dataObject = "d_Communication_device"
ads_DeviceList.SetTransObject ( sqlca )


li_RetrieveRtn = ads_devicelist.retrieve ( ) 

IF li_RetrieveRtn >= 0 THEN
	li_Return = 1
ELSE
	li_Return = -1
END IF

Return li_Return 


end function

protected function integer of_retrievecommequiplist (ref n_ds ads_commequiplist);// RETURNS 1 , success	-1 Faliure

int	li_Return 
Int	li_RetrieveRtn

IF IsValid ( ads_commequiplist ) THEN
	Destroy ads_commequiplist
END IF

ads_commequiplist = CREATE n_ds
ads_commequiplist.dataObject = "d_Communication_setup_equipment"
ads_commequiplist.SetTransObject ( sqlca )


li_RetrieveRtn = ads_commequiplist.retrieve ( ) 

IF li_RetrieveRtn >= 0 THEN
	li_Return = 1
ELSE
	li_Return = -1
END IF

Return li_Return 


end function

protected function integer of_errorlog (string as_filename, string as_text, boolean ab_header);integer	li_FileNum
DateTime	ldt_system
			
//Create log file in current directory, if it already exists then a blank line will be appended

IF FileExists ( as_filename ) THEN

	li_FileNum = FileOpen(as_filename, LineMode!, Write!, LockReadWrite!, Append!)
	//write blank line
	IF li_FileNum > 0 THEN 
		FileWrite ( li_FileNum, '' )
	END IF

ELSE

	li_FileNum = FileOpen(as_filename, LineMode!, Write!, LockReadWrite!, Append!)
	
END IF

IF li_FileNum > 0  THEN

	if ab_header then
		ldt_system = DateTime(Today(), Now())
		FileWrite ( li_FileNum, "Error on " + string ( ldt_System ) )
	end if
	
	FileWrite ( li_FileNum, as_text )
	FileClose ( li_FileNum )
	
END IF


return li_FileNum
end function

protected function integer of_setauthentication (string as_vehicle);//descendant has specific code
return -1
end function

protected function boolean of_routeshipmentuponcreation ();/***************************************************************************************
NAME: 			of_RouteShipmentUponCreation		

ACCESS:			Protected	
	
ARGUMENTS: 		None

RETURNS:			Boolean
					
	
DESCRIPTION:
				   indicates whether the system is expected to route shipments after they
					are created
					

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created April 2 2002 RPZ



***************************************************************************************/
Boolean	lb_Return 
Any		la_Setting
n_cst_Settings	lnv_Settings

IF lnv_Settings.of_GetSetting ( 108 , la_Setting ) = 1 THEN
	IF String ( la_Setting ) = "YES!" THEN
		lb_Return = TRUE
	END IF
END IF

RETURN lb_Return
end function

public function integer of_testrouting ();n_cst_MessageData	lnv_MsgData

lnv_MsgData = Create n_cst_MessageData


n_cst_Msg	lnv_Msg

Long		ll_ShipmentID = 101923
Long		ll_EventID = 9444
Long		ll_EquipmentID = 10000015
String	ls_EqRef = "22"


lnv_MsgData.of_SetShipmentID ( ll_ShipmentID )
lnv_MsgData.of_SetEventID ( ll_EventID )
lnv_MsgData.of_SetEquipmentRef ( ls_EqRef )



THIS.of_RouteShipment ( lnv_MsgData , ll_ShipmentID , lnv_Msg ) 


DESTROY lnv_MsgData

RETURN 1
end function

protected function integer of_routeshipment (n_cst_messagedata anv_msgdata, long al_shipmentid, ref n_cst_msg anv_msg);/***************************************************************************************
NAME: 			of_RouteShipment

ACCESS:			Protected
	
ARGUMENTS: 		
					n_cst_msgdata			the information needed for routing should be in this
												object, event id , date, equipment id.
												
					al_ShipmentID			the shipment to be routed.
					
					anv_Msg					used to pass out error text

RETURNS:			
					Int
					 1 Success
					-1 Error
	
DESCRIPTION:
	
		This method will route the first leg in the provided shipment to the equipment
		specified in the n_cst_msgdata object


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :

	Created April 3 2002 RPZ


***************************************************************************************/

String	ls_ErrorMessage
Long		lla_EventIDs[]
Long		ll_InsertionEvent
Long		ll_EquipID
Int		li_Return = 1
Int		li_RouteReturn
Int		i
Int		li_EventCount
Date		ld_InsertionDate

S_Parm	lstr_parm
n_cst_beo_Event		lnva_EventList[]
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_dispatch	lnv_Dispatch
n_cst_OFRError		lnva_Errors[]
n_cst_OFRError		lnv_Error

lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Dispatch = CREATE n_cst_bso_Dispatch

ld_InsertionDate = TODAY () 

IF isValid ( anv_MsgData ) THEN
	THIS.of_GetEquipmentID ( anv_MsgData.of_GetEquipmentRef ( ) , ll_EquipID )
	ll_InsertionEvent = anv_MsgData.of_GetEventID ( )
ELSE 
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF lnv_Dispatch.of_RetrieveShipment( al_ShipmentID ) = 1 THEN
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache  ( ) )
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceID ( al_ShipmentID )
		
		lnv_Shipment.of_getlegeventlist ( 1 /* LEG 1 */, lnva_EventList  )
		li_EventCount = UpperBound ( lnva_EventList )
	
		FOR i = 1 TO li_EventCount
			lla_EventIds[i] = lnva_EventList[i].of_GetID ( )
		NEXT
								
		IF UpperBound( lla_EventIds ) = 0 THEN
			li_Return = -1
			ls_ErrorMessage += "No events were found in the first leg of the shipment. "
		END IF
	ELSE 
		li_Return = -1
		ls_ErrorMessage += "Could not retrieve the needed shipment. "
	END IF
END IF

// check the values that will be sent into of_Route
IF li_Return = 1 THEN 
	IF UpperBound ( lla_EventIDs ) = 0 THEN
		li_Return = 0
	END IF
END IF

IF li_Return = 1 THEN 
	IF ll_EquipID <= 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN 
	IF ll_InsertionEvent <= 0 THEN
		li_Return = -1
	END IF
END IF

// route the events
IF li_Return = 1 THEN	
	li_RouteReturn = lnv_Dispatch.of_route ( lla_EventIDs, gc_Dispatch.ci_ItinType_PowerUnit,+&
				    			ll_EquipID , ld_InsertionDate , 0 /*date scale style*/ , + &
				    			ll_InsertionEvent , gc_Dispatch.ci_InsertionStyle_After )

	IF li_RouteReturn <> 1 THEN
		li_Return = -1
		IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
			//There are errors to process -- Get the error text
			ls_ErrorMEssage += lnva_Errors[1].GetErrorMessage ( )
		END IF
	ELSE

	END IF

END IF

IF li_Return <> 1 THEN

	This.ClearOFRErrors ( ) //Processing above may have loaded some.
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMEssage )
	
END IF

IF li_Return = 1 THEN
	lnv_Dispatch.Event pt_Save ( )
END IF

//										Error will be in OFR
//IF li_Return = -1 THEN
//	lstr_Parm.is_Label = "ERROR"
//	lstr_Parm.ia_Value = ls_ErrorMessage 
//	anv_Msg.of_Add_Parm ( lstr_Parm ) 
//END IF

DESTROY ( lnv_Dispatch )
DESTROY ( lnv_Shipment )

RETURN li_Return 

end function

public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_MessageData anv_MsgData, boolean ab_lastrecorded);RETURN -1
// implemented by descendent
end function

protected function integer of_senddirections (ref n_cst_messagedata anv_msgdata, string as_errortext);/*

*/

String	ls_TemplatePath

Integer	li_SQLCode, &
			li_EquipmentRet, &
			li_Return = 1

long		ll_CompanyId, &
			ll_EquipmentId
Long		ll_EventID

Any 		laa_BEO []

s_parm					lstr_Parm
n_cst_beo_Company		lnva_CompanyBeo[]
s_OutBoundMessage		lstra_Outbound []
n_cst_msg				lnv_Msg

lnva_CompanyBeo[1] = CREATE n_cst_beo_Company

ll_EventID = anv_MsgData.of_GetEventID ( )

IF isnull ( ll_EventID ) OR ll_EventID = 0 THEN
	as_ErrorText = "The event id could not be found. Directions were not sent." 
	li_Return = -1
	
END IF

IF li_Return = 1 THEN
	
	
	
	SELECT "disp_events"."de_site"  
	INTO :ll_CompanyId 
	FROM "disp_events"  
	WHERE "disp_events"."de_id" = :ll_EventID  ;

	li_sqlcode = sqlca.sqlcode
	commit;

	IF li_SqlCode <> 0 THEN
		as_ErrorText = "The event id could not be found. Directions were not sent." 
		
	ELSE
		
		gnv_cst_Companies.of_Cache ( ll_CompanyId, TRUE )
		lnva_CompanyBeo[1].of_SetUseCache ( TRUE )
		lnva_CompanyBeo[1].of_SetSourceId ( ll_CompanyId )
		laa_Beo = lnva_CompanyBeo
		
		lstra_Outbound[1].is_Topic = n_cst_constants.cs_ReportTopic_COMPANY

		IF this.of_Getsystemtemplatepath ( ls_TemplatePath ) < 0 THEN
			as_ErrorText = "Template folder path not defined in system settings."
			li_Return = -1
			
		ELSE
		
			lstra_Outbound[1].is_Template = ls_TemplatePath + anv_MsgData.of_GetOutboundTemplate ( )//is_OutboundTemplate
													
			IF FileExists ( lstra_Outbound[1].is_Template ) THEN		
				//OK
			ELSE
				as_ErrorText = "Template not found: " + lstra_Outbound[1].is_Template
				li_Return = -1
				
			END IF
			
			li_EquipmentRet = this.of_GetEquipmentId ( anv_MsgData.of_GetEquipmentRef ( ), ll_EquipmentId )
			
			IF isnull ( ll_EquipmentID ) THEN
				//ERROR
				CHOOSE CASE li_EquipmentRet
					CASE 0
						as_errortext = "Equipment Reference number not found in Communication table." 
					CASE 2
						as_errortext = "More than one Equipment Reference number found in Equipment table." 
				END CHOOSE
				
				li_Return = -1
				
			ELSE
				
				lstra_Outbound[1].il_Destination = 	ll_EquipmentID
			
				//build lnv message
				lstr_parm.is_Label = "MESSAGES"
				lstr_Parm.ia_Value = lstra_Outbound
				lnv_Msg.of_Add_Parm ( lstr_Parm )
				
				lstr_Parm.is_Label = "DATA"
				lstr_Parm.ia_Value = laa_Beo
				lnv_Msg.of_Add_Parm ( lstr_Parm )
			
				//send message
				IF this.of_SendOutBound ( lnv_msg ) <> 1 THEN
					as_ErrorText = "An error occurred while trying to send directions." 
					li_Return = -1
			
				END IF
				
			END IF
			
		END IF
		
	END IF

END IF

DESTROY lnva_CompanyBeo[1]

return li_Return
end function

protected function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext);/*
	Using the equipment reference number let's try to get a single equipment id.
	If we are successful then we will set the info in the datastore
*/

Integer	li_EquipmentRet, &
			li_Return = 1

Long		ll_EquipmentId, &
			ll_DeviceFound, &
			ll_DeviceRowCount
			
String	ls_FindString

ll_DeviceRowCount = ads_CommunicationDevice.RowCount()

li_EquipmentRet = this.of_GetEquipmentId ( anv_MsgData.of_GEtEquipmentRef ( ), ll_EquipmentId )


IF isnull ( ll_EquipmentID ) THEN
	//ERROR
	CHOOSE CASE li_EquipmentRet
		CASE 0
			as_errortext = "Equipment Reference number not found in Communication table." 
		CASE 2
			as_errortext = "More than one Equipment Reference number found in Equipment table." 
	END CHOOSE
	
	li_Return = -1
	
ELSE
	
	ls_FindString = "type = '" + is_DeviceType + &
						"' and equipmentid = " + string ( ll_EquipmentID  )
	ll_DeviceFound = ads_CommunicationDevice.Find ( ls_FindString, 1, ll_DeviceRowCount )
	
	IF ll_DeviceFound > 0 THEN
		ads_CommunicationDevice.Object.LastPositionLat[ll_DeviceFound] = anv_MsgData.of_GetLastPositionLat ( )
		ads_CommunicationDevice.Object.LastPositionLong[ll_DeviceFound] = anv_MsgData.of_GetLastPositionLong ( )
		ads_CommunicationDevice.Object.LastPositionLocation[ll_DeviceFound] = anv_MsgData.of_GetLastPositionLocation ( )
		ads_CommunicationDevice.Object.LastPositionDate[ll_DeviceFound] = anv_MsgData.of_GetLastPositionDate ( )
		ads_CommunicationDevice.Object.LastPositionTime[ll_DeviceFound] = anv_MsgData.of_GetLastPositionTime ( )
		ads_CommunicationDevice.Object.LastMessageNumber[ll_DeviceFound] = anv_MsgData.of_GetLastMessageNumber ( )

	ELSE
		as_errortext = "Communication Device not found in Communication table." 
		li_Return = -1
	END IF
	
END IF
	
return li_Return
end function

public function integer of_testassignment ();n_cst_MessageData	lnv_MsgData

lnv_MsgData = Create n_cst_MessageData


n_cst_Msg	lnv_Msg

Long		ll_ShipmentID = 101923//854
Long		ll_EventID = 9444
Long		ll_EquipmentID = 10000015
String	ls_EqRef = "22"


lnv_MsgData.of_SetShipmentID ( ll_ShipmentID )
lnv_MsgData.of_SetEventID ( ll_EventID )
lnv_MsgData.of_SetEquipmentRef ( ls_EqRef )
lnv_MsgData.of_SetContainerID ( 10000532 )


MEssageBox ( "Assign Rtn" , THIS.of_AssignEquipment ( lnv_MsgData , ll_ShipmentID )  )


DESTROY lnv_MsgData

RETURN 1
end function

protected function integer of_processnewshipmentrequest (ref n_cst_messagedata anv_msgdata);Int	li_Return = 1
Long	lla_ShipmentIds[]
Long	ll_ShipmentID
S_Parm	lstr_Parm
n_cst_msg	lnv_Msg



IF li_Return = 1 THEN
	IF THIS.of_ValidateShipmentCreation ( anv_msgdata  ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF THIS.of_CreateShipment ( anv_MsgData , lnv_Msg ) <> 1 THEN
		li_Return = -1
	END IF
END IF
		
IF li_Return = 1 THEN
	IF THIS.of_RouteShipmentUponCreation ( ) THEN
	
		IF lnv_msg.of_Get_Parm ( "NEWIDS" , lstr_Parm ) <> 0 THEN
			lla_ShipmentIDS = lstr_Parm.ia_Value
		ELSE
			li_Return = -1
		END IF
		
		IF li_Return = 1 THEN
			IF UpperBound ( lla_ShipmentIDS ) > 0 THEN
				ll_ShipmentID = lla_ShipmentIDS [ 1 ] 
		
				IF THIS.of_RouteShipment ( anv_MsgData , ll_ShipmentID , lnv_Msg) <> 1 THEN
					li_Return = -1
				END IF
		
				IF li_Return = 1 THEN
					IF THIS.of_AssignEquipment ( anv_MsgData , ll_ShipmentID ) <> 1 THEN
						li_Return = -1
					END IF
				END IF
				
			END IF
		END IF
		
	END IF
END IF



RETURN li_Return
end function

protected function integer of_replywitherror (n_cst_messagedata anv_msgdata, string as_errortext);Any			la_Path
String		ls_FilePath
String		ls_DocName
String		ls_ExtensionPath
Long			ll_Destination 
Int			li_Return = 1

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm
s_OutboundMessage	lstra_Messages[]

ls_DocName = "freeform.doc"

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_FilePath = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )
ls_ExtensionPath = "message\" + is_DeviceType + "\outbound\"
IF len ( ls_FilePath ) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	lstra_Messages[1].is_Template = ls_FilePath + ls_ExtensionPath + ls_DocName
ELSE
	li_Return = -1
END IF

ll_Destination = anv_msgdata.of_GetTractorID ( ) 
IF ll_Destination <= 0 THEN

	ll_Destination = anv_msgdata.of_GetDriverID ( )
END IF

IF ll_Destination <= 0 THEN
	li_Return = -1
ELSE
	lstra_Messages[1].il_destination = ll_Destination
END IF

lstr_Parm.is_Label = "FREEFORMTEXT"
lstr_Parm.ia_Value = as_errortext
lnv_Msg.of_Add_Parm ( lstr_Parm ) 


lstr_Parm.is_Label = "MESSAGES"
lstr_Parm.ia_Value = lstra_Messages
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

IF li_Return = 1 THEN
	IF THIS.of_SendOutbound ( lnv_Msg ) <> 1 THEN
		li_Return = -1 
	END IF
END IF

RETURN li_Return
end function

protected function integer of_processinboundmessages (ref n_cst_messagedata anva_msgdata[], ref datastore ads_message);Integer	li_Return = 1
long		ll_Ndx, &
			ll_MessageCount, &
			ll_NewRow, &
			lla_UpdatedEqId[]			
Long		ll_Equipment			
String	ls_ErrorText
String	ls_Trailer
Boolean	lb_Success = TRUE
Boolean	lb_UpdateUnkEquip = TRUE
String	ls_ErrorMessage
String	ls_Reply
Boolean	lb_ShouldReplyWithSuccess
String	ls_ReplyMsg
String	ls_Warning

n_cst_EquipmentManager	lnv_Equipment
n_cst_ofrError		lnva_Errors[]
n_cst_Msg			lnv_SpecialFields
s_parm				lstr_Parm

datastore	lds_CommunicationDevice

lds_CommunicationDevice = 	CREATE datastore
lds_CommunicationDevice.DataObject = "d_Communication_Device"
lds_CommunicationDevice.SetTransObject ( SQLCA ) 

IF lds_CommunicationDevice.Retrieve(0) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN

	n_cst_setting_MobileCommReplyError  lnv_ReplyError
	lnv_ReplyError = Create n_cst_setting_MobileCommReplyError
	ls_Reply = lnv_ReplyError.of_Getvalue( )
	Destroy lnv_ReplyError
	
	n_cst_setting_MobileCommReplySuccess  lnv_ReplySuccess
	lnv_ReplySuccess = Create n_cst_setting_MobileCommReplySuccess
	lb_ShouldReplyWithSuccess = lnv_ReplySuccess.of_Getvalue( ) = lnv_ReplySuccess.cs_yes
	Destroy lnv_ReplySuccess	

	ll_MessageCount = upperbound ( anva_MsgData )
	
	FOR ll_Ndx = 1 TO ll_MessageCount
		
		This.ClearOFRErrors ( ) 
		ll_Equipment = 0
		ls_ErrorMessage = ""
		ls_Warning = ""
		lb_Success = TRUE
		lb_UpdateUnkEquip = TRUE
		
		//write to message datastore
		ll_NewRow = ads_message.InsertRow(0)
		ads_message.Object.message_source[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetEquipmentRef ( )//is_EquipmentRef
		ads_message.Object.message_date[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetlastPositionDate ( )//id_LastPositionDate
		ads_message.Object.message_time[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetLastPositionTime ( )//it_LastPositionTime
		ads_message.Object.message_position[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetLastPositionLocation ( ) //is_LastPositionLocation
		ads_message.Object.message_text[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetMessageText ( )//is_Text
		ads_message.Object.message_shipmentid[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetShipmentID ( )//il_shipmentid
		ads_message.Object.message_eventid[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetEventID ( )//il_eventid
		ads_message.Object.message_sourceentityid[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetSourceEntityId()
		ads_message.Object.message_sourceentitytype[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetSourceEntityType()
		

	
/*
		We really don't want to have 'CONTINUE' statements in here because we need some on the 
		processing to report errors to back to the driver, but the method below will only fail if
		the equipment and/or the device can't be resolved, in which case a message can't be sent
		to the driver anyway.
*/	
		IF this.of_SetNewLocation ( anva_MsgData[ll_Ndx], lds_CommunicationDevice, ls_ErrorText ) < 0 THEN
	
			ads_message.Object.message_errortext[ll_NewRow] = ls_ErrorText
			ads_message.Object.message_status[ll_NewRow] = "E"
			CONTINUE
			
		END IF
		
		// Modified to allow the equipment processing to happen first
		// incase we need the UNK-Equip to be specified before 
		// attempting to confirm the event.
		
		
		IF anva_MsgData[ ll_Ndx ].of_GetMessageType ( ) <> "NEW SHIPMENT" THEN
			/*																	*/
			//Does structure have a container number?
			IF len ( trim (anva_MsgData[ll_Ndx].of_GetContainer ( ) ) ) > 0 THEN
				IF THIS.of_ProcessContainer ( anva_MsgData[ll_Ndx] , ll_Equipment ) = -1 THEN
					ads_message.Object.message_status[ll_NewRow] = "E"
					lb_Success = FALSE
				END IF
			END IF
				
			// Does structure have a chasis number.
			IF len ( trim (anva_MsgData[ll_Ndx].of_GetChassis ( )) ) > 0 THEN
				IF THIS.of_ProcessChassis ( anva_MsgData[ll_Ndx] , ll_Equipment )= -1 THEN
					ads_message.Object.message_status[ll_NewRow] = "E"
					lb_Success = FALSE
				END IF			
			END IF
			
			//Does structure have a trailer number?
	
			ls_Trailer = anva_MsgData[ll_Ndx].of_GetTrailer ( )
			IF len(ls_Trailer) > 0 THEN
				IF THIS.of_ProcessTrailer ( anva_MsgData[ll_Ndx] , ll_Equipment )	= -1 THEN
					ads_message.Object.message_status[ll_NewRow] = "E"
					lb_Success = FALSE
				END IF
			END IF
				
			IF ll_Equipment > 0 THEN
				lla_UpdatedEqId[ upperbound (lla_UpdatedEqId) + 1] = ll_Equipment
			END IF
			
									
			//Does structure have special fields?
			lnv_SpecialFields = anva_MsgData[ll_Ndx].of_GetSpecialFields()
			IF lnv_SpecialFields.of_get_count( ) > 0 THEN
				CHOOSE CASE This.of_ProcessSpecialFields(anva_MsgData[ll_Ndx])
					CASE -1 //Error
						ads_message.Object.message_status[ll_NewRow] = "E"
						lb_Success = FALSE
					CASE 0 //Could not process, but we still want to continue
						//Log warning and continue
						IF THIS.geterrorcount( ) > 0 AND THIS.GetOFRErrors ( lnva_Errors ) > 0 THEN
							ls_Warning = lnva_Errors[1].GetErrorMessage ( )
							This.ClearOFRErrors ( )
						END IF
				END CHOOSE
			END IF
			/*	                              */
																	
		END IF	
		
		
		//	Need to determine what type of message is being received 
		// and what type of response is required.		
		CHOOSE CASE anva_MsgData[ ll_Ndx ].of_GetMessageType ( ) //is_MessageType
				
			CASE "ARRIVE", "DEPART" 	//Update event
				
				IF THIS.of_ProcessArriveDepart ( anva_MsgData[ ll_Ndx ]  ) <> -1 THEN
					ads_message.Object.message_status[ll_NewRow] = "I"
				ELSE
					ads_message.Object.message_status[ll_NewRow] = "E"
					lb_Success = FALSE
				END IF
				

			CASE "DIRECTIONS" //Driver request for company directions
				
				IF this.Of_SendDirections ( anva_MsgData[ ll_Ndx ], ls_ErrorText ) < 0 THEN
					
					ads_message.Object.message_errortext[ll_NewRow] = ls_ErrorText
					ads_message.Object.message_status[ll_NewRow] = "E"
//					CONTINUE
					lb_Success = FALSE

				ELSE					
					ads_message.Object.message_status[ll_NewRow] = "I"
				END IF
				
				
			CASE "NEW SHIPMENT"					
		
				Int	li_NewShipRtn
				
				lb_UpdateUnkEquip = FALSE
				li_NewShipRtn = THIS.of_ProcessNewShipmentRequest ( anva_MsgData[ll_Ndx] )
				
				IF li_NewShipRtn <> 1 THEN
					
					lb_Success = FALSE						
					ads_message.Object.message_status[ll_NewRow] = "E"
					
					IF THIS.GetOFRErrors ( lnva_Errors ) > 0 THEN
						ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
						//There are errors to process -- Get the error text
						//MessageBox ( "New Shipment" , ls_ErrorMessage )
						
					ELSE
						ls_ErrorMessage = "New shipment request was not completed successfully."
					END IF
														
				ELSE
					ads_message.Object.message_status[ll_NewRow] = "I"
				END IF
				
				
			CASE "DUTYSTATUS"

				IF THIS.of_ProcessDutyStatus ( anva_MsgData[ ll_Ndx ]  ) <> -1 THEN
					ads_message.Object.message_status[ll_NewRow] = "I"
				ELSE
					ads_message.Object.message_status[ll_NewRow] = "E"
					lb_Success = FALSE
				END IF
								
		END CHOOSE
		
		//Get any other error messages
		IF THIS.geterrorcount( ) > 0 AND THIS.GetOFRErrors ( lnva_Errors ) > 0 THEN
			ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
		END IF
		
		
		IF NOT lb_Success THEN
			
			IF ls_Reply = n_cst_setting_MobileCommReplyError.cs_Yes THEN
				//Reply with Errors
				
				IF NOT isNull(ls_ErrorMessage) AND Len(ls_ErrorMessage) > 0 THEN
					IF THIS.of_ReplyWithError ( anva_MsgData[ll_Ndx] , ls_ErrorMessage ) = 1 THEN
						ads_message.Object.message_reply[ll_NewRow] = ls_ReplyMsg
					END IF
				END IF
			END IF
			
		ELSE			
			IF lb_ShouldReplyWithSuccess THEN						
				IF THIS.of_ReplyWithSuccess ( anva_MsgData[ll_Ndx] ) = 1 THEN
					ads_message.Object.message_reply[ll_NewRow] = "Message has been receivied"
				END IF					
			END IF					
		END IF
		
		//Put any warnings/errors in the message_errortext 
		IF NOT isNull(ls_Warning) AND Len(ls_Warning) > 0 THEN
			ls_ErrorMessage = ls_Warning + "~r~n" + ls_ErrorMessage
		END IF
		
		IF NOT isNull(ls_ErrorMessage) AND Len(ls_ErrorMessage) > 0 THEN
			ads_message.Object.message_errortext[ll_NewRow] = ls_ErrorMessage
		END IF
			
			
	NEXT

END IF

IF li_Return = 1 THEN
	
	IF lds_CommunicationDevice.Update() = 1 THEN
		COMMIT USING SQLCA;	
	ELSE
		ROLLBACK USING SQLCA;
		li_Return = -1
	END IF		

END IF


//refresh updated equipment references
IF upperbound ( lla_UpdatedEqId ) > 0 THEN
	lnv_Equipment.of_Cache ( lla_UpdatedEqId, TRUE )
END IF

This.ClearOFRErrors ( ) 

Destroy ( lds_CommunicationDevice )

return li_Return
end function

private function integer of_processdepart (ref n_cst_messagedata anv_msgdata, ref n_cst_beo_event anv_event, ref n_cst_bso_dispatch anv_dispatch);//RETURN 1 , -1 , 0

Int		li_Return = 1
Long		ll_ErrorCount
String	ls_ErrorMessage
Date		ld_EventDate
Date		ld_MessageDate

n_cst_OFRError	lnv_Error, &
					lnva_Errors[]

IF NOT isValid ( anv_Event ) THEN
	li_Return = -1
	ls_ErrorMessage = "The event could not be resolved."
END IF

IF li_Return = 1 THEn
	IF NOT anv_event.of_HasSource ( ) THEN
		li_Return = -1
		ls_ErrorMessage = "The event information could not be retrieved."
	END IF
END IF

IF NOT isValid ( anv_msgData ) THEN
	li_Return = -1 
	ls_ErrorMessage = "The message data is not valid."
END IF

IF li_Return = 1 THEN
	
	ld_EventDate = anv_Event.of_GetDateArrived ( )
	ld_EventDate = Date ( DateTime ( ld_EventDate ) ) 
	ld_MessageDate = anv_msgData.of_GetLastPositionDate ( )
	
	CHOOSE CASE DaysAfter ( ld_EventDate, ld_MessageDate )

		CASE 0, 1
			//Same day, or next day (for example, next morning after midnight)

		CASE ELSE
			ls_ErrorMessage = "The routing date does not match the date in the message."
			li_Return = -1
			
	END CHOOSE

END IF

IF li_Return = 1 THEN
	IF anv_Event.of_SetTimeDeparted ( anv_msgData.of_GetLastPositionTime ( ) ) <> 1 THEN
	
		ls_ErrorMessage = "Could not update departure time."
		li_Return = -1
		
	END IF
END IF

IF li_Return = 1 THEN
	anv_Dispatch.ClearOFRErrors ( )

	IF anv_Dispatch.of_ConfirmEvent ( anv_event.of_GetID ( ), FALSE /*Non-Interactive*/ ) >= 0 THEN
		//OK
		anv_Event.of_SetConfirmedBy ( "DRIVER" )
	ELSE
		ls_ErrorMessage = "Event times were updated, but the event could not be confirmed complete."			
		IF anv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
			ls_ErrorMessage += "~r~n" + lnva_Errors[1].GetErrorMessage ( )
		END IF
		
		li_Return = 0  // we don't want to send out a hard error b/c we still want the calling
							// script to save
	END IF
END IF

IF li_Return <> 1 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF


Return li_Return
end function

private function integer of_processarrive (ref n_cst_messagedata anv_msgdata, ref n_cst_beo_event anv_event);Int		li_return = 1
Date		ld_EventDate
Date		ld_MessageDate
String	ls_ErrorMessage

n_cst_Beo_Event	lnv_Event 
n_cst_OFRError		lnv_Error

lnv_Event = anv_event

IF Not isValid ( lnv_Event ) THEN
	li_Return = -1
	ls_ErrorMessage = "The event could not be resolved."
END IF

IF li_Return = 1 THEN
	IF NOT lnv_Event.of_HasSource ( ) THEN
		li_Return = -1
		ls_ErrorMessage = "The event information could not be retrieved."
	END IF
END IF

IF li_Return = 1 THEN
	IF NOT isValid ( anv_msgdata ) THEN
		li_Return = -1
		ls_ErrorMessage = "The message data was not valid."
	END IF
END IF

IF li_Return = 1 THEN
	ld_MessageDate = anv_msgdata.of_GetLastPositionDate ( )
	ld_EventDate = lnv_Event.of_GetDateArrived ( )
 	ld_EventDate = Date ( DateTime ( ld_EventDate ) )  //This should already be clean, but j.i
	 
	IF ld_EventDate <> ld_MessageDate THEN

		ls_ErrorMessage = "The routing date does not match the date in the message."
		li_Return = -1

		//Note:  Technically, we could update over the date if it were non-routed or 3rd party.
		//Not sure if we wan't the extra processing overhead, as there may be a SQL call when 
		//the beo checks this.  So, barring that, we'll just reject this.
		
	END IF
END IF

IF li_Return = 1 THEN
	IF lnv_Event.of_SetTimeArrived ( anv_msgdata.of_GetLastPositionTime ( ) ) <> 1 THEN
		ls_ErrorMessage = "Could not update arrival time."
		li_Return = -1	
	END IF
END IF

IF li_Return = -1 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

RETURN li_Return
end function

private function integer of_processcontainer (ref n_cst_messagedata anv_msgdata, ref long al_eqid);Int		li_Return = 1
Long		ll_EventID
Long		lla_ContainerList[]
String	ls_ErrorMessage
String	ls_NewEqRef
String	ls_MessageLabel
String	ls_Unknown = "UNK"
String	ls_OldeqRef
DataStore	lds_EventCache

n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch lnv_Dispatch 
n_cst_OFRError		lnv_Error

lnv_Event = CREATE n_cst_beo_Event
lnv_Dispatch = CREATE n_cst_bso_Dispatch

IF NOT isValid ( anv_MsgData ) THEN
	li_Return = -1
	ls_ErrorMessage = "The message data is not valid."
END IF

IF li_Return = 1 THEN
	ll_EventID = anv_MsgData.of_GetEventID ( ) 

	lnv_Dispatch.of_RetrieveEvents ( {ll_EventID} )
	lds_EventCache = lnv_Dispatch.of_GEtEventCache ( )

	IF isValid ( lds_EventCache ) THEN
		lds_EventCache.SetFilter ( "" )
		lds_EventCache.Filter ( )		
		
		lnv_Event.of_SetSource ( lds_EventCache )
		lnv_Event.of_SetSourceID ( ll_EventID )
	END IF
END IF

IF Not lnv_Event.of_HasSource ( ) THEN
	li_Return = -1
	ls_ErrorMessage = "The event could not be resolved." 
END IF

IF li_Return = 1 THEN
	
	lnv_Event.of_GetContainerList ( lla_ContainerList , FALSE)
	IF UpperBound ( lla_ContainerList ) > 0 THEN
		ls_NewEqRef = anv_MsgData.of_GetContainer ( )
		ls_MessageLabel = "Container"
		
		  UPDATE "equipment"  
			  SET "eq_ref" = :ls_NewEqRef 
			WHERE ( "equipment"."eq_id" = :lla_ContainerList[1] ) AND  
						( left ( upper("equipment"."eq_ref"), 3)  = :ls_Unknown );
	
		IF SQLCA.SQLCODE <> 0 THEN
			ls_ErrorMessage = "Could not update " + ls_MessageLabel + " number. " + SQLCA.sqlerrtext
			li_Return = -1
			
		ELSE
			IF SQLCA.SQLNROWS = 0 THEN
			
				  SELECT "equipment"."eq_ref"  
					 INTO :ls_OldEqRef  
					 FROM "equipment"  
					WHERE "equipment"."eq_id" = :lla_ContainerList[1]  ;
					
				IF SQLCA.SQLCODE <> 0 THEN
					ls_ErrorMessage = "Could not SELECT " + ls_MessageLabel + " number. " + SQLCA.sqlerrtext
					li_Return = -1					
				ELSE
					IF trim (ls_OldEqRef) <> trim (ls_NewEqRef) THEN
						ls_ErrorMessage = "Could not update " + ls_MessageLabel + " " + &
													ls_OldEqREf + " with " + ls_MessageLabel + " " + &
													ls_NewEqRef + " sent by driver."
						li_Return = -1
					END IF
					
				END IF
			ELSE
				al_EqID = lla_ContainerList[1]				
			END IF
			
		END IF
	
		commit ;
	END IF
	
END IF

IF li_Return = -1 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF
	
DESTROY (lnv_Event )  
DESTROY ( lnv_Dispatch ) 

RETURN li_Return
end function

private function integer of_processchassis (ref n_cst_messagedata anv_msgdata, ref long al_eqid);Int		li_Return = 1
Long		ll_EventID
Long		lla_Id[]
String	ls_ErrorMessage
String	ls_NewEqRef
String	ls_MessageLabel
String	ls_Unknown = "UNK"
String	ls_OldeqRef

DataStore	lds_EventCache

n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch lnv_Dispatch 
n_cst_OFRError		lnv_Error

lnv_Event = CREATE n_cst_beo_Event
lnv_Dispatch = CREATE n_cst_bso_Dispatch

IF NOT isValid ( anv_MsgData ) THEN
	li_Return = -1
	ls_ErrorMessage = "The message data is not valid."
END IF

IF li_Return = 1 THEN
	ll_EventID = anv_MsgData.of_GetEventID ( ) 

	lnv_Dispatch.of_RetrieveEvents ( {ll_EventID} )
	lds_EventCache = lnv_Dispatch.of_GEtEventCache ( )

	IF isValid ( lds_EventCache ) THEN
		lds_EventCache.SetFilter ( "" )
		lds_EventCache.Filter ( )		
		
		lnv_Event.of_SetSource ( lds_EventCache )
		lnv_Event.of_SetSourceID ( ll_EventID )
	END IF
END IF

IF Not lnv_Event.of_HasSource ( ) THEN
	li_Return = -1
	ls_ErrorMessage = "The event could not be resolved." 
END IF

IF li_Return = 1 THEN
	lnv_Event.of_GetTrailerList (lla_Id, FALSE)
	IF UpperBound ( lla_Id ) > 0 THEN
		ls_NewEqRef = anv_msgdata.of_GetChassis ( )
		ls_MessageLabel = "Chassis"
		
		  UPDATE "equipment"  
			  SET "eq_ref" = :ls_NewEqRef 
			WHERE ( "equipment"."eq_id" = :lla_Id[1] ) AND  
					( left ( upper("equipment"."eq_ref"), 3)  = :ls_Unknown );

		IF SQLCA.SQLCODE <> 0 THEN
			ls_ErrorMessage = "Could not update " + ls_MessageLabel + " number. " + &
																			SQLCA.sqlerrtext
			li_Return = -1
			
		ELSE
			IF SQLCA.SQLNROWS = 0 THEN
			
			  SELECT "equipment"."eq_ref"  
				 INTO :ls_OldEqRef  
				 FROM "equipment"  
				WHERE "equipment"."eq_id" = :lla_Id[1]  ;
				
				IF SQLCA.SQLCODE <> 0 THEN
					ls_ErrorMessage = "Could not SELECT " + ls_MessageLabel + " number. " +	SQLCA.sqlerrtext
					li_Return = -1
					
				ELSE
					IF trim (ls_OldEqRef) <> trim (ls_NewEqRef) THEN
						ls_ErrorMessage = "Could not update " + ls_MessageLabel + " " + &
												ls_OldEqREf + " with " + ls_MessageLabel + " " + &
												ls_NewEqRef + " sent by driver."
						li_Return = -1
					END IF
					
				END IF				
			ELSE
				al_eqid = lla_Id[1]				
			END IF
			
		END IF

		commit ;
	END IF
END IF
				
DESTROY ( lnv_Dispatch ) 
DESTROY ( lnv_Event )

IF li_Return = -1 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

RETURN li_Return
end function

protected function integer of_validateshipmentcreation (ref n_cst_messagedata anv_msgdata);/***************************************************************************************
NAME: 			of_ValidateShipmentCreation

ACCESS:			protected
		
ARGUMENTS: 		anv_msgdata
					anv_msg

RETURNS:			Int
					 1  shipment data is valid 
					-1  Error
	
DESCRIPTION:
					This method will determin if the information contained in teh msgdata
					object will be sufficient and accurate to create a shipment.

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created April 2 2002  RPZ



***************************************************************************************/
String	ls_Container
String	ls_ErrorMessage
String	ls_Eqref
String	ls_Template
Long		ll_EquipID
Long		ll_ShipmentID
Long		lla_Matches[]
Long		ll_EventID
Long		ll_SearchRtn
Date		ld_Date	
Int		li_Return = 1


S_Parm	lstr_Parm
n_cst_ofrError	lnv_Error
n_cst_shipmentManager	lnv_ShipmentManager
n_cst_equipmentManager	lnv_EquipmentManager
n_cst_bso_Dispatch	lnv_Dispatch	
n_cst_beo_itinerary2	lnv_itin

lnv_Dispatch = CREATE n_cst_bso_Dispatch

IF NOT IsValid ( anv_MsgData ) THEN
	li_Return = -1
END IF


//  First attempt to identify the container
//  we will need to use a lookup method that will accept variations of special chars 
IF li_Return = 1 THEN
	ll_SearchRtn = lnv_EquipmentManager.of_SmartSearch ( anv_msgdata.of_GetContainer ( ), "C" , "K" , lla_Matches )
	IF ll_SearchRtn <= 0 THEN
		li_Return = -1
		ls_ErrorMessage = "A container could not be matched to (" + anv_msgdata.of_GetContainer ( ) + ")."
	
	ELSEIF ll_SearchRtn > 1 THEN
		li_Return = -1 
		ls_ErrorMessage = "Multiple containers were found in Profit Tools that match " + anv_msgdata.of_GetContainer ( ) 
	ELSE
		anv_msgdata.of_SetContainerID ( lla_Matches[1]  )
	END IF
END IF




// be sure the template name can be resolved
IF li_Return = 1 THEN
	ls_Template = anv_MsgData.of_GetShipmentTemplate ( )
	ll_ShipmentID = lnv_ShipmentManager.of_GetIDFromTemplate ( ls_Template )
	
	IF ll_ShipmentID > 0 THEN
		// ok
	ELSE
		li_Return = -1
		ls_ErrorMessage += "the shipment template (" + ls_Template + ") could not be resolved. "
	END IF
END IF



IF THIS.of_RouteShipmentUponCreation ( ) THEN

	// be sure the event id specified by the driver as the event to route after is in fact
	// part of his truck's itinerary for the day.
	IF li_Return = 1 THEN
		
		ll_EventID = anv_MsgData.of_GetEventID ( ) 
		ls_EqRef = anv_MsgData.of_GetEquipmentRef ( )
		ld_Date = TODAY ( ) 
		
		IF THIS.of_GetEquipmentID ( ls_EqRef , ll_EquipId ) <> 1 THEN
			li_Return = -1
			ls_ErrorMessage += "the equipment reference could not be resolved. "
		ELSE
			lnv_Itin = lnv_Dispatch.of_GetItinerary ( gc_Dispatch.ci_ItinType_PowerUnit , ll_EquipID , ld_Date , ld_Date )

			IF isvalid(lnv_Itin) THEN
				IF NOT lnv_Itin.of_ValidateEventID ( ll_EventID ) THEN
					li_Return = -1
				END IF
			ELSE
				li_Return = -1
			END IF
			
			IF li_return = -1 THEN
				ls_ErrorMessage += "the event id "+ String ( ll_EventID ) + " could not be matched to the itinerary for " + ls_Eqref + " on " + String ( ld_Date ) +". " 	
			END IF
			
		END IF
	END IF
END IF

IF li_Return = -1 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

//anv_msg.of_Reset ( )
//lstr_Parm.is_Label = "ERROR" 
//lstr_Parm.ia_Value = ls_ErrorMessage
//anv_Msg.of_Add_Parm ( lstr_Parm )


DESTROY ( lnv_Dispatch )
DESTROY ( lnv_Itin )

RETURN li_Return
end function

protected function integer of_createshipment (n_cst_messagedata anv_msgdata, ref n_cst_msg anv_msg);/***************************************************************************************
NAME: 			of_CreateShipment

ACCESS:			Protected
	
ARGUMENTS: 		anv_MsgData
					anv_Msg

RETURNS:			INT
					1 = Successful creation 
					-1 = Error
	
DESCRIPTION:	
					This method will pass the msgdata object off to the shipment manger
					and have it create the shipment 


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created April 2 2002  RPZ



***************************************************************************************/

Int	li_Return = 1 

n_cst_ShipmentManager	lnv_ShipmentManager

IF lnv_ShipmentManager.of_CreateShipment ( anv_MsgData , anv_Msg ) <> 1 THEN
	li_Return = -1
END IF

RETURN li_Return

end function

protected function integer of_assignequipment (ref n_cst_messagedata anv_msgdata, long al_shipment);Int		li_Return = -1
Int		li_ItinType
Int		li_AssignRtn
Long		lla_EquipmentID
Long		ll_ContainerID 
Long		ll_EventID
Date		ld_RouteDate
String	ls_Equipment

n_cst_OFRError		lnva_Errors[]
n_cst_OFRError		lnv_Error

n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Shipment = CREATE n_cst_Beo_Shipment
lnv_Dispatch = CREATE n_cst_bso_Dispatch


ld_RouteDate = anv_msgdata.of_GetLastPositionDate ( )
IF isNull ( ld_RouteDate ) THEN
	ld_RouteDate = ToDay ( ) 
END IF

ll_ContainerID = anv_msgdata.of_GetContainerID ( ) 
IF ll_ContainerID > 0 THEN
	
	li_itinType = gc_Dispatch.ci_ItinType_Container
	
	IF lnv_Dispatch.of_RetrieveShipment ( al_Shipment ) = 1 THEN
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Shipment.of_SetSourceID ( al_Shipment )
		
		lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Shipment.of_SetItemSource( lnv_Dispatch.of_GetItemCache ( ) )		
	END IF

END IF


ll_EventID = 0
IF lnv_Shipment.of_hasSource ( ) THEN
	ll_EventID = lnv_Shipment.of_GetFirstEventID ( "MH" ) // hook or mount
END IF


li_AssignRtn = 0
IF ll_EventID > 0 THEN
	li_assignRtn = lnv_Dispatch.of_assign ( ll_EventID , li_itinType , ll_ContainerID , ld_RouteDate )
END IF


IF li_AssignRtn = 1 THEN
	IF lnv_Dispatch.Event pt_Save ( ) = 1 THEN
		li_Return = 1
	END IF
ELSE

	IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
		//There are errors to process -- Get the error text
		lnv_Error = This.AddOFRError ( )
		lnv_Error.SetErrorMessage ( lnva_Errors[1].GetErrorMessage ( ) )
	END IF

END IF


DESTROY lnv_Dispatch
DESTROY lnv_Shipment

RETURN li_Return 
end function

public function integer of_processtrailer (ref n_cst_messagedata anv_msgdata, ref long al_eqid);Int		li_Return = 1
Long		ll_EventID
Long		ll_TrailerID
Long		lla_Id[]
String	ls_ErrorMessage
String	ls_MessageLabel

DataStore	lds_EventCache

n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch lnv_Dispatch 

n_cst_OFRError		lnva_Errors[]
n_cst_OFRError		lnv_Error

lnv_Event = CREATE n_cst_beo_Event
lnv_Dispatch = CREATE n_cst_bso_Dispatch

IF NOT isValid ( anv_MsgData ) THEN
	li_Return = -1
	ls_ErrorMessage = "The message data is not valid."
END IF

if anv_MsgData.of_Geteventtype() = 'H' then
	li_Return = 1
else
	//wrong event type
	li_Return = -1
end if

IF li_Return = 1 THEN
	ll_EventID = anv_MsgData.of_GetEventID ( ) 

	lnv_Dispatch.of_RetrieveEvents ( {ll_EventID} )
	lds_EventCache = lnv_Dispatch.of_GEtEventCache ( )

	IF isValid ( lds_EventCache ) THEN
		lds_EventCache.SetFilter ( "" )
		lds_EventCache.Filter ( )		
		
		lnv_Event.of_SetSource ( lds_EventCache )
		lnv_Event.of_SetSourceID ( ll_EventID )
	END IF
END IF

IF li_Return = 1 THEN
	IF Not lnv_Event.of_HasSource ( ) THEN
		li_Return = -1
		ls_ErrorMessage = "The event could not be resolved." 
	END IF
end if

IF li_Return = 1 THEN
	lnv_Event.of_GetTrailerList (lla_Id, FALSE)
	IF UpperBound ( lla_Id ) > 0 THEN
		//already a trailer assigned to the event
	else

		choose case anv_MsgData.of_GetTrailerID(ll_TrailerID)
			case 1
			//assign 
			IF lnv_Dispatch.of_assign ( ll_EventID , gc_Dispatch.ci_ItinType_TrailerChassis , ll_TrailerID , anv_MsgData.of_GetLastPositionDate() ) = 1 THEN
				IF lnv_Dispatch.Event pt_Save ( ) = 1 THEN
					li_Return = 1
					al_eqid = ll_TrailerID
				END IF
			ELSE		
				IF lnv_Dispatch.GetOFRErrors ( lnva_Errors ) > 0 THEN
					//There are errors to process -- Get the error text
					ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
					li_Return = -1
				END IF
			end if
			
			case 0
				//no trailer id sent with message
				ls_ErrorMessage = "No trailer number was sent with the hook."
				li_Return = -1
				
			case -1
				//trailer id is invalid
				ls_ErrorMessage = "The trailer number sent is not a valid number."
				li_Return = -1
				
		end choose
		
	end if
END IF
				
DESTROY ( lnv_Dispatch ) 
DESTROY ( lnv_Event )

IF li_Return = -1 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

RETURN li_Return
end function

protected function integer of_processarrivedepart (ref n_cst_messagedata anv_msgdata);Int		li_Return = 1
String	ls_ErrorMessage
String	ls_SourceType
Date		ld_EventDate
Date		ld_MessageDate
Long		ll_EventID
Long		ll_SourceId
DataStore	lds_EventCache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_beo_Event		lnv_Event 
n_cst_OFRError			lnv_Error


lnv_Event = CREATE n_cst_beo_Event
lnv_Dispatch = CREATE n_cst_bso_Dispatch 

IF NOT isValid ( lnv_dispatch ) THEN
	li_Return = -1 
	ls_ErrorMessage = "The dispatch object is not valid."
END IF

IF NOT isValid ( anv_msgdata ) THEN
	li_Return = -1
	ls_ErrorMessage = "The message data is not valid."
END IF

IF li_Return = 1 THEN
	ll_EventId = anv_msgdata.of_GEtEventID ( )
	IF isNull(ll_EventId) OR ll_EventId = 0 THEN
		li_Return = -1
		ls_ErrorMessage = "The event id submitted is not valid (0/null)."
	END IF
END IF

IF li_Return = 1 THEN
	
	lnv_dispatch.of_RetrieveEvents ( { ll_EventId } )
	
	lds_eventCache = lnv_dispatch.of_GeteventCache ( )
	IF isValid ( lds_eventCache ) THEN
		lds_EventCache.SetFilter ( "" )
		lds_EventCache.Filter ( )
	END IF

	lnv_Event.of_SetSource ( lds_EventCache )
	lnv_Event.of_SetSourceId ( ll_EventId )
	lnv_Event.of_SetContext ( lnv_Dispatch )
END IF


IF li_Return = 1 THEN
	IF NOT lnv_Event.of_HasSource ( ) THEN
		li_Return = -1
		ls_ErrorMessage = "Profit Tools cannot retrieve event information for event #" + String(ll_EventId) + "."
	END IF
END IF

//Verfiy we are updating an event that is associated to the source entity
IF li_Return = 1 THEN
	
	ll_SourceId = anv_msgdata.of_GetSourceEntityID ( ) 
	
	IF ll_SourceId > 0 THEN
		
		ls_SourceType = anv_MsgData.of_GetSourceEntityType()
		CHOOSE CASE ls_SourceType
			CASE cs_Employee
				IF ll_SourceId <> lnv_Event.of_GetDriverId() THEN
					li_Return = -1
					ls_ErrorMessage = "The event id (" + String(ll_EventId) + ") submitted is not associated with the source driver's itinerary"
				END IF
			CASE cs_Equipment
				IF ll_SourceId <> lnv_Event.of_GetTractorId( ) THEN
					li_Return = -1
					ls_ErrorMessage = "The event id (" + String(ll_EventId) + ") submitted is not associated with the source tractor's itinerary."
				END IF
		END CHOOSE
		
	END IF

END IF

IF li_Return = 1 THEN

	IF lnv_Event.of_IsConfirmed ( ) THEN
		ls_ErrorMessage =  "The event (" + string(ll_EventId) + ") has already been confirmed as completed."
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN

	//Read the current date off the event (if any)
	ld_EventDate = lnv_Event.of_GetDateArrived ( )
	ld_EventDate = Date ( DateTime ( ld_EventDate ) )  //This should already be clean, but j.i.c.

	IF IsNull ( ld_EventDate ) THEN
	
		IF lnv_Event.of_SetDateArrived ( ld_MessageDate ) = 1 THEN
			//If it's a non-routed event, this will be allowed.
		ELSE
			//Otherwise, it will not be allowed.
			ls_ErrorMessage = "The event (" + String(ll_EventId) + ")  has not been routed."
			li_Return = -1
		END IF
	
	END IF
END IF

IF li_Return = 1 THEN

	CHOOSE CASE anv_msgdata.of_GetMessageType ( ) //is_MessageType
			
		CASE "ARRIVE"
			IF THIS.of_ProcessArrive ( anv_msgdata , lnv_event ) = -1 THEN
				li_Return = -1
			END IF
			
		CASE "DEPART"
			// this could return 0 but we still want to save in that case
			IF THIS.of_ProcessDepart ( anv_MsgData , lnv_event , lnv_dispatch ) = -1 THEN
				li_Return = -1
			END IF
			
	END CHOOSE
END IF
//
///*	
//	See if there are any comments to add the event note.  It	will be assumed 
//	that comments are last in the message.  If we find a comments label, 
//	then everything after that label	will be stripped and added to event notes.	
//*/
IF li_Return = 1 THEN
	
	IF len( anv_msgdata.of_GetEventnotes ( )/*is_EventNotes*/ ) > 0 THEN
		//IF This Fails I'm not going to stop the update for an error on notes.
		lnv_Event.of_AppendNote ( anv_msgdata.of_GetEventnotes ( ) ) 				
	END IF								
	
	CHOOSE CASE lnv_dispatch.Event pt_Save ( )
	
		CASE 1  //Success
			//OK
		
		CASE ELSE  //-1 Failure
			ls_ErrorMessage = "Could not save updates to event information."
			li_Return = -1
		
	END CHOOSE
END IF

// testing the len here b/c some method will cause -1 but will add their own 
// error message
IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

DESTROY lnv_Dispatch
DESTROY lnv_Event
				
RETURN li_Return
end function

public function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext, boolean ab_createdevice);/*
	Using the equipment reference number let's try to get a single equipment id.
	If we are successful then we will set the info in the datastore if we don't find the
	device in the communicationdevice table then create if boolean true
*/

Integer	li_EquipmentRet, &
			li_Return = 1

Long		ll_EquipmentId, &
			ll_DeviceFound, &
			ll_DeviceRowCount, &
			ll_NextId
			
String	ls_FindString

Constant Boolean	cb_Commit = TRUE

ll_DeviceRowCount = ads_CommunicationDevice.RowCount()

li_EquipmentRet = this.of_GetEquipmentId ( anv_MsgData.of_GEtEquipmentRef ( ), ll_EquipmentId )

IF isnull ( ll_EquipmentID ) THEN
	//ERROR
	CHOOSE CASE li_EquipmentRet
		CASE 0
			as_errortext = "Equipment Reference number not found in Communication table." 
		CASE 2
			as_errortext = "More than one Equipment Reference number found in Equipment table." 
	END CHOOSE
	
	li_Return = -1
	
ELSE
	
	ls_FindString = "type = '" + is_DeviceType + &
						"' and equipmentid = " + string ( ll_EquipmentID  )
	ll_DeviceFound = ads_CommunicationDevice.Find ( ls_FindString, 1, ll_DeviceRowCount )
	
	IF ll_DeviceFound > 0 THEN
		//got it
	ELSE
		IF ab_CreateDevice then
			IF gnv_App.of_GetNextId ( "communication_device", ll_NextId, cb_Commit ) = 1 THEN
				ll_DeviceFound = ads_CommunicationDevice.InsertRow(0)
				IF ll_DeviceFound > 0 then
					ads_CommunicationDevice.Object.Id[ll_DeviceFound] = ll_NextId
					ads_CommunicationDevice.Object.EquipmentId[ll_DeviceFound] = ll_EquipmentID
					ads_CommunicationDevice.Object.type[ll_DeviceFound] = n_cst_constants.cs_communicationdevice_cadec
				END IF
			END IF
		END IF
	END IF

	IF ll_DeviceFound > 0 THEN
		ads_CommunicationDevice.Object.LastPositionLat[ll_DeviceFound] = anv_MsgData.of_GetLastPositionLat ( )
		ads_CommunicationDevice.Object.LastPositionLong[ll_DeviceFound] = anv_MsgData.of_GetLastPositionLong ( )
		ads_CommunicationDevice.Object.LastPositionLocation[ll_DeviceFound] = anv_MsgData.of_GetLastPositionLocation ( )
		ads_CommunicationDevice.Object.LastPositionDate[ll_DeviceFound] = anv_MsgData.of_GetLastPositionDate ( )
		ads_CommunicationDevice.Object.LastPositionTime[ll_DeviceFound] = anv_MsgData.of_GetLastPositionTime ( )
		ads_CommunicationDevice.Object.LastMessageNumber[ll_DeviceFound] = anv_MsgData.of_GetLastMessageNumber ( )

	ELSE
		as_errortext = "Communication Device not found in Communication table." 
		li_Return = -1
	END IF
	
END IF
	
return li_Return

end function

protected function integer of_findeventfortruck (ref n_cst_messagedata anv_msgdata);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FindEventForTruck
//
//	Access:  public
//
//	Arguments:  ads_message by reference
//
//
//	Description:	
//
// 	Using the truck #, Date, TMP # and Event Type, try to find an event in the
//		the truck itinerary. If there is no TMP on the event then or if there
//		is more than one unconfirmed event of the appropriate type then try to 
//		determine the correct event using the account id (codename).  If none found
//		then write to error log.  If one is found then set it in the argument. 
//
// Written by: Norm LeBlanc
// 		Date: 11/30/04
//		Version: 4.0.01
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

integer	li_return = 1, &
			li_eventcount, &
			li_index, &
			li_Possible

long		ll_TruckId, &
			ll_site, &
			ll_event, &
			ll_MessageShipId, &
			ll_ShipId

string	ls_MessageEventType, &
			ls_MessageSiteCodeName, &
			ls_ErrorMessage, &
			ls_codename, &
			ls_type
			
date		ld_min, &
			ld_max
			
boolean	lb_FoundMatch

n_cst_bso_Dispatch	lnv_Dispatch	
n_cst_OFRError			lnv_Error
	
n_cst_beo_itinerary2	lnv_itinerary
n_cst_beo_Event		lnva_Event[], &
							lnva_Possible[]

n_cst_beo_Company		lnv_Company

lnv_Dispatch = CREATE n_cst_bso_Dispatch
	
ll_truckId = anv_msgdata.of_GetTractorId()
ls_MessageEventType = anv_msgdata.of_Geteventtype()
ll_MessageShipId = anv_msgdata.of_GetShipmentId()
ls_MessageSiteCodeName = anv_msgdata.of_GetSiteCodeName()

ld_min = anv_msgdata.of_GetLastPositionDate()
ld_max = anv_msgdata.of_GetLastPositionDate()

lnv_itinerary = lnv_Dispatch.of_GetItinerary ( gc_Dispatch.ci_ItinType_PowerUnit , ll_truckId , ld_min , ld_max )

IF isvalid(lnv_itinerary) THEN
	//ok
	li_eventcount = lnv_Itinerary.of_GetEventlist( lnva_Event )
	if li_eventcount > 0 then
		//ok
	else
		ls_ErrorMessage = "No itinerary for this date."
		li_Return = -1
	end if
ELSE
	ls_ErrorMessage = "Invalid itinerary."
	li_Return = -1
END IF
	
	
If li_Return = 1 then
	
	//first look for matching tmps
	for li_index = 1 to li_Eventcount
		
		//skip if already confirmed
		if lnva_Event[li_index].of_isconfirmed( ) then
			continue
		end if
	
		//Look for next unconfirmed event that matches the type and tmp
		
		ls_type = lnva_Event[li_index].of_Gettype( )
		ll_ShipId = lnva_Event[li_index].of_getshipment( )		
		
		//Does type match?
		if ls_MessageEventType = ls_type then
			//Does TMP match?
			if ll_MessageShipId = ll_ShipId then
				li_Possible ++
				lnva_Possible[ li_Possible ] = lnva_Event[li_index]
				
			end if
			
		end if		
				
	next
	
	//did we find more than one ?
	
	choose case li_Possible
			
		case 1
			//acceptable
			ll_event = lnva_Possible[1].of_GetId()

		case is > 1
			//ambiguous try to match by site
			ll_event = 0
			
			for li_index = 1 to li_Possible
				
				if lnva_Possible[li_index].of_GetSite( lnv_Company ) = 1 then
					//ok
					ls_codename = lnv_Company.of_Getcodename( )
					if trim(ls_MessageSiteCodeName) = trim(ls_codename) then
						if ll_event > 0 then
							//we already found one 
							//can't determine event
							ll_event = 0
							li_return = 0
							exit
						else
							ll_event = lnva_Possible[li_index].of_GetId()
						end if
						
					end if
					
				end if
						
			next
			
		case else //0
			//look for event by site
			
			for li_index = 1 to li_Eventcount
				
				if lnva_Event[li_index].of_isconfirmed( ) then
					continue
				end if
			
				//Look for next unconfirmed event that matches the type and site(codename)
				
				ls_type = lnva_Event[li_index].of_Gettype( )
				ll_site = lnva_Event[li_index].of_getsite( )		
				
				//Does type match?
				if ls_MessageEventType = ls_type then
					//Does site match?
					if lnva_Event[li_index].of_GetSite( lnv_Company ) = 1 then
						//ok
						ls_codename = lnv_Company.of_Getcodename( )
						if trim(ls_MessageSiteCodeName) = trim(ls_codename) then
							if ll_event > 0 then
								//we already found one 
								//can't determine event
								ll_event = 0
								li_return = 0
								exit
							else
								ll_event = lnva_Event[li_index].of_GetId()
								exit
							end if
						
							
						end if
						
					end if
							
				end if	
				
			next
			
	end choose

End If

IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

if ll_event > 0 then
	anv_msgdata.of_SetEventId(ll_event)
end if

DESTROY ( lnv_Dispatch )
DESTROY ( lnv_itinerary )

return li_Return
end function

public function integer of_displaypositionreport (long al_equipmentid, long al_driverid, s_co_info astr_site, boolean ab_lastrecorded);//Note:  This is a VISUAL function.  It will display messageboxes, pop map windows, etc.


long		ll_DeviceCount, &
			ll_PowerUnitId, &
			ll_DriverId, &
			ll_DeviceId, &
			ll_CacheRow

string	ls_DeviceType, &
			lsa_DeviceList[], &
			ls_CommunicationObject, &
			ls_EquipmentRef, &
			ls_Hours, &
			ls_Minutes, &
			ls_PCMS, &
			ls_MessageHeader = "Position Report", &
			ls_LocationMessage, &
			ls_PositionReport
				
boolean	lb_DriverDevice, &
			lb_HasPositionData, &
			lb_ProcessMileage, &
			lb_DisplayMap
			
Date		ld_PositionDate
Time		lt_PositionTime
String	ls_PositionLocation

n_cst_trip		lnv_trip
n_cst_routing	lnv_routing

n_cst_licensemanager		lnv_licensemanager
n_cst_EquipmentManager	lnv_EquipmentManager

n_cst_MessageData			lnv_MsgData

n_cst_bso_Communication_Manager lnv_Communication  //Will be used to hold a 2nd, device-specific instance.



Integer	li_Return = 1



IF li_Return = 1 THEN

	IF This.of_HasCommunicationDevice ( al_EquipmentId, al_DriverId, ls_DeviceType, ll_DeviceId, ll_CacheRow, lb_DriverDevice ) THEN
		
		//OK

	ELSE
		Messagebox ( ls_MessageHeader, "No Communication Device found." )
		li_Return = -1
		
	END IF

END IF




IF li_Return = 1 THEN
	
	CHOOSE CASE ls_DeviceType
			
		CASE n_cst_constants.cs_CommunicationDevice_Qualcomm 
			ls_CommunicationObject = "n_cst_bso_Communication_QualComm"
				
		CASE n_cst_constants.cs_CommunicationDevice_Nextel
			ls_CommunicationObject = "n_cst_bso_Communication_Nextel"
	
		CASE n_cst_constants.cs_CommunicationDevice_InTouch
			ls_CommunicationObject = "n_cst_bso_Communication_Intouch"
			
		CASE n_cst_constants.cs_CommunicationDevice_AtRoad
			ls_CommunicationObject = "n_cst_bso_Communication_AtRoad"
	
		CASE n_cst_constants.cs_CommunicationDevice_Cadec
			ls_CommunicationObject = "n_cst_bso_Communication_Cadec"

	END CHOOSE
	
	IF len ( ls_CommunicationObject ) > 0 THEN
		
		lnv_Communication = CREATE USING ls_CommunicationObject
		lnv_MsgData = CREATE n_cst_MessageData
		
	ELSE
		
		MessageBox ( ls_MessageHeader, "Error -- Invalid device type." )
		li_Return = -1
		
	END IF
	
END IF



IF li_Return = 1 THEN


	IF lb_DriverDevice = FALSE AND ls_DeviceType <> n_cst_constants.cs_CommunicationDevice_Nextel THEN
		
		//This is the original version of the locate function coded by Norm.  It only supports truck-based devices.
		//Nextel devices are currently not capable of reporting position back to PT, so we will leave this as-is for now,
		//and exclude Nextel devices from this processing.  If Nextel devices do become capable of reporting back position,
		//we should consolidate this into one function that would take a device id, rather than an Equipment / Driver Id.

		IF lnv_EquipmentManager.of_Get_Description ( al_EquipmentId, "REF_ONLY!", ls_EquipmentRef ) = 1 THEN
			//Success
		ELSE
			SetNull ( ls_EquipmentRef )
		END IF


		IF lnv_Communication.of_LocateTruck ( al_EquipmentId, ls_EquipmentRef, lnv_MsgData, ab_LastRecorded ) < 0 THEN
			MessageBox ( ls_MessageHeader, "Position data not available." )
			li_Return = -1
		ELSE
			lb_HasPositionData = TRUE
			
			ld_PositionDate = lnv_MsgData.of_GetLastPositionDate ( )
			lt_PositionTime = lnv_MsgData.of_GetLastPositionTime ( )
			ls_PositionLocation = lnv_MsgData.of_GetLastPositionLocation ( )
			
			IF ls_PositionLocation > "" THEN

				IF Len ( ls_EquipmentRef ) > 0 THEN
					ls_LocationMessage = "Unit " + ls_EquipmentRef
				ELSE
					ls_LocationMessage = "This vehicle"
				END IF
				
				ls_LocationMessage += " was reported at " + ls_PositionLocation
				
				IF NOT IsNull ( ld_PositionDate ) THEN
					
					ls_LocationMessage += " on " + String ( ld_PositionDate, "m/d" )
					
					IF NOT IsNull ( lt_PositionTime ) THEN
						
						ls_LocationMessage += " at " + String ( lt_PositionTime, "h:mm AM/PM" )
						
					END IF
					
					ls_LocationMessage += "."
					
				ELSE
					
					ls_LocationMessage += " at an unspecified time."
					
				END IF
				
			END IF
			
			IF Len ( ls_PositionReport ) > 0 THEN
				ls_PositionReport += "~n~n"
			END IF
			
			ls_PositionReport += ls_LocationMessage
			
		END IF

	ELSEIF ls_DeviceType = n_cst_constants.cs_CommunicationDevice_Nextel THEN
		
		This.of_PopulateMessageData ( lnv_MsgData, ll_CacheRow )
				
	END IF
		
END IF


//If we have position data and a site with a PCMLocator or a ZIP, see if we have PCMiler available to determine distance and drive time.
//If we don't have position data, don't bother with PCMiler, because there's nothing to process.

IF li_Return = 1 AND lb_HasPositionData AND (astr_Site.co_PCM > "" OR astr_Site.co_Zip > "") THEN

	IF lnv_LicenseManager.of_UsePCMilerStreets ( ) OR lnv_LicenseManager.of_HasPCMilerLicense ( ) THEN
		
		lnv_trip = create n_cst_trip
		if lnv_trip.of_connect(lnv_routing) then
			if lnv_routing.of_isvalid() then
				lb_ProcessMileage = TRUE
			end if
		end if

	END IF

END IF


IF li_Return = 1 AND lb_ProcessMileage then

//	CHOOSE CASE ls_DeviceType
//
//		//Instead of converting the data and storing it consistently, apparently Norm stored it in mixed format, 
//		//and converted it here.  Not the preferred approach, but...
//		
//		
//		//Qualcomm and Cadec lat-longs come in HMSD format, which is what PCMiler accpets.
//		//Intouch and AtRoad come in DMS format, which needs to be converted to HMSD.
//			
//			
//		CASE n_cst_constants.cs_CommunicationDevice_Qualcomm, n_cst_constants.cs_CommunicationDevice_Cadec 
//			
//			ls_latlong = lnv_MsgData.of_GetLastPositionLat  ( ) + "," + lnv_MsgData.of_GetLastPositionLong ( )
//			
//			ls_pcms = ls_latlong
//			  
//		CASE n_cst_constants.cs_CommunicationDevice_InTouch, n_cst_constants.cs_CommunicationDevice_AtRoad
//			  
//			decimal lc_decimal,&
//						lc_work
//						
//			string ls_work, &
//					ls_decimal
//			//lattitude		
//			lc_decimal = dec ( lnv_MsgData.of_GetLastPositionLat( ) )
//			
//			//hours
//			ls_hours= string (int(lc_decimal),"000")
//			
//			//minutes
//			ls_decimal = string ( lc_decimal )
//			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
//			ls_minutes = string ( lc_work, "00")
//			
//			//seconds
//			ls_decimal = string ( lc_work )
//			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
//			ls_seconds =  string ( lc_work, "00")
//			
//			ls_lat = ls_hours + ls_minutes + ls_seconds + "N"
//			
//			//longitude
//			lc_decimal = dec ( lnv_MsgData.of_GetLastPositionLong ( ) )
//			
//			//hours
//			ls_hours= string (int(lc_decimal),"000")
//			
//			//minutes
//			ls_decimal = string ( lc_decimal )
//			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
//			ls_minutes = string ( lc_work, "00")
//			
//			//seconds
//			ls_decimal = string ( lc_work )
//			lc_work = dec ("." + right ( ls_decimal, len (ls_decimal) - pos ( ls_decimal ,"." ) ) ) * 60 
//			ls_seconds =  string ( lc_work, "00")
//			
//			ls_long = ls_hours + ls_minutes + ls_seconds + "W"
//			
//			ls_latlong = ls_lat + "," + ls_long
//			
//			ls_pcms = ls_latlong
//			
//
//	END CHOOSE
			
			
	//The logic above was moved into GetLastPositionLatLong, and the subordinate functions it delegates to.
	//So, the above logic was commented and replaced by this call...
	//Note that where the logic above is checking device types to determine which stored value format to expect,
	//the new logic just looks at the data to see which type it is, without making any device-type-based assumptions.
	//This was changed 4/21/05 BKW
	ls_PCMS = lnv_MsgData.of_GetLastPositionLatLong ( "HMSD" /*Hrs Mins Secs Direction Format*/ )
	
	
	//pcmiler stuff
	string	ls_TotalTime, &
				ls_LegTime, &
				ls_ProximityMessage, &
				ls_timemessage
	
	long 		ll_Minute, &
				ll_TotalMinutes, &
				ll_Hours, &
				ll_tripid
				
	dec 		lc_totaldistance
	
	lnv_trip.of_addstop(ls_PCMS)
	
	//Norm was only using locator here.  BKW added zip. 2/16/05
	
	IF astr_Site.co_PCM > "" THEN  //If a locator is provided, use it.
		lnv_Trip.of_AddStop ( astr_Site.co_pcm )
	ELSEIF Match ( astr_Site.co_Zip, "^[0-9]+$" ) THEN  //The zip contains only digits -- a US Zip
		lnv_Trip.of_AddStop ( Left ( astr_Site.co_zip, 5 ) )
	ELSE
		lnv_Trip.of_AddStop ( astr_Site.co_Zip )
	END IF
		
	ll_tripid = lnv_trip.of_createtrip()
//	lnv_trip.of_calculatetrip(ll_tripid, 27, 0, 0, lc_totaldistance, ll_totalminutes)  --Norms comment
	lnv_trip.of_calculatetrip(ll_tripid, 31, 0, 0, lc_totaldistance, ll_totalminutes)

	
	ll_totalminutes += ll_minute
	ll_hours = truncate(ll_minute / 60.0, 0)
	ll_minute = ll_minute - ll_hours * 60
	ls_LegTime = string(ll_Hours, "0") + ":" + string(ll_Minute, "00")

	ll_Hours = truncate(ll_TotalMinutes / 60.0, 0)
	ll_minute = ll_TotalMinutes - ll_Hours * 60
	ls_TotalTime = string(ll_hours, "0") + ":" + string(ll_Minute, "00")
	
	if ll_hours > 0 THEN
		ls_Hours = string(ll_hours, "0") + " Hours"
		ls_timemessage = ls_hours
	end if
	
	if ll_minute > 0 then 
		ls_minutes = string(ll_Minute, "00") + " Minutes"
		ls_timemessage = ls_timemessage + " " + ls_minutes
	end if
	
	ls_ProximityMessage = "The vehicle is " + string(lc_totaldistance,"0.0;-0.0;0.0;'N.A.'") + &
				" miles from the stop and could arrive there in approximately " + ls_timemessage + "."
				

	IF Len ( ls_PositionReport ) > 0 THEN
		ls_PositionReport += "~n~n"
	END IF
	
	ls_PositionReport += ls_ProximityMessage
	
	
END IF


IF li_Return = 1 THEN

	IF Len ( ls_PositionReport ) > 0 THEN

		//Presently, Nextel devices will be effectively excluded from getting the mapping question
		//because they will not have positions recorded and therefore will not have an ls_PositionReport string.
	
		IF ( lb_ProcessMileage AND pcmm_inst /*Global indicating whether mapping is installed*/ ) OR &
			ls_DeviceType = n_cst_constants.cs_CommunicationDevice_Nextel THEN
		
			ls_PositionReport += "~n~nDo you want to display a position map for this vehicle?"
		
			CHOOSE CASE Messagebox ( ls_MessageHeader, ls_PositionReport, None!, YesNo!, 1 )
					
				CASE 1 //Yes
					lb_DisplayMap = TRUE
					
			END CHOOSE
			
		ELSE
			
			MessageBox ( ls_MessageHeader, ls_PositionReport, None! )
			
		END IF
		
	ELSEIF ls_DeviceType = n_cst_constants.cs_CommunicationDevice_Nextel THEN
		
		//Presently, Nextel devices will not have positions recorded, and therefore the only way of fulfilling
		//the position report request is to display the Elutions map that may be available for them.
		
		lb_DisplayMap = TRUE
		
	END IF
	
END IF


IF li_Return = 1 AND lb_DisplayMap = TRUE THEN
	
	lnv_Communication.of_DisplayPositionMap ( lnv_MsgData, astr_Site, lnv_Trip )
		
END IF		



DESTROY lnv_Communication
DESTROY lnv_MsgData

IF IsValid ( lnv_Trip ) THEN
	DESTROY lnv_Trip
END IF

RETURN li_Return



//*************
//A code relic from Norm's version of the function.

//IF li_Return = 1 THEN
//	//need to check table for device, if more than one type
//	//then display response window ot pick one
//	IF IsValid ( lnv_Communication ) THEN
//		ll_DeviceCount = lnv_Communication.of_GetCommunicationDevice ( lsa_DeviceList ,lb_OpenDlg ) 
//		IF ll_DeviceCount > 0 AND UpperBound (lsa_DeviceList) > 0  THEN
//			ls_DeviceType = lsa_DeviceList[1]
//		ELSE
//			li_Return = -1
//		END IF
//	END IF
//END IF
end function

public function integer of_populatemessagedata (n_cst_messagedata anv_msgdata, long al_cacherow);//Populate anv_msgdata with as many values as possible off the device cache.
//Note that this is NOT all the values on the anv_msgdata object, many of which relate to a specific message.
//The DeviceUnitId and the values for LastRecordedPosition will be provided.

//If anv_msgdata is not valid, it will be created.

//Returns : 1, -1

//Created : 2/17/05 BKW  to consolidate and expand on processing Norm had been doing in various other scripts.

n_ds		lds_Cache
Long		ll_RowCount

Integer	li_Return = 1


IF li_Return = 1 THEN
	
	lds_Cache = This.of_GetDeviceCache ( FALSE /*Do NOT force refresh -- a refresh could invalidate the row number passed in*/ )

	IF IsValid ( lds_Cache ) THEN
		ll_RowCount = lds_Cache.RowCount()
	END IF
	
	IF al_CacheRow > 0 AND al_CacheRow <= ll_RowCount THEN
		//OK
	ELSE
		li_Return = -1
	END IF
	
END IF


IF li_Return = 1 THEN

	IF NOT IsValid ( anv_MsgData ) THEN
		anv_MsgData = CREATE n_cst_MessageData
	END IF

	anv_MsgData.of_SetDeviceUnitId ( lds_Cache.Object.UnitId [ al_CacheRow ] )
	anv_MsgData.of_SetLastPositionLocation ( lds_Cache.Object.LastPositionLocation [ al_CacheRow ] )
	anv_MsgData.of_SetLastPositionLat ( lds_Cache.Object.LastPositionLat [ al_CacheRow ] )
	anv_MsgData.of_SetLastPositionLong ( lds_Cache.Object.LastPositionLong [ al_CacheRow ] )
	anv_MsgData.of_SetLastPositionDate ( lds_Cache.Object.LastPositionDate [ al_CacheRow ] )
	anv_MsgData.of_SetLastPositionTime ( lds_Cache.Object.LastPositionTime [ al_CacheRow ] )

END IF


RETURN li_Return
end function

public function boolean of_hascommunicationdevice (long al_equipmentid, long al_driverid, ref string as_devicetype, ref long al_deviceid, ref long al_cacherow, ref boolean ab_driverdevice);//does this equipment or driver have a device?

//Returns whether a device was found (TRUE / FALSE).

//A specific device type can be requested in as_DeviceType, or it can be left blank.
//The device type found will be passed out by reference in as_DeviceType.
//If no device is found, as_DeviceType will be set to Null.

//al_DeviceId will be used to pass out the system id of the device found.
//This value is used outbound only, any value passed in is ignored.
//If no device is found, the value is set to null.

//al_CacheRow will be used to pass out the cache row of the device found.
//This value is used outbound only, any value passed in is ignored.
//If no device is found, the value is set to null.

//ab_DriverDevice indicates whether the device found is linked to the driver rather than the equipment.
//This value is used outbound only, any value passed in is ignored.
//If no device is found, the value is set to null.


long		ll_RowCount, &
			ll_FoundRow
string	ls_FindString

n_ds	lds_Cache
 
Boolean	lb_Continue = TRUE
Boolean	lb_Return = FALSE

lds_Cache = THIS.of_GetDeviceCache ( TRUE /*Force Refresh*/ )
ll_RowCount = lds_Cache.RowCount()


IF lb_Continue THEN

	//Clean up the as_DeviceType parameter for use in comparisons
	
	as_DeviceType = Upper ( Trim ( as_DeviceType ) )
	
	IF as_DeviceType = "" THEN
		SetNull ( as_DeviceType )
	END IF

	//Clear any inbound value in ab_DriverDevice and al_DeviceId
	SetNull ( ab_DriverDevice )
	SetNull ( al_DeviceId )
	SetNull ( al_CacheRow )
	
END IF


//Look for devices linked to equipment.  These will take precedence over driver devices, if available.

IF lb_Continue AND al_EquipmentId > 0 THEN

	ls_FindString = "equipmentid = " + string ( al_equipmentid ) 
	
	IF as_DeviceType > "" THEN
		
		ls_FindString += " and type = '" + as_devicetype + "'"
		
	END IF

	ll_FoundRow = lds_Cache.Find ( ls_FindString, 1, ll_RowCount )
	
	IF ll_FoundRow > 0 THEN
		as_DeviceType = lds_Cache.GetItemString ( ll_FoundRow, "type" )
		al_DeviceId = lds_Cache.GetItemNumber ( ll_FoundRow, "id" )
		al_CacheRow = ll_FoundRow
		ab_DriverDevice = FALSE
		lb_Continue = FALSE
		lb_Return = TRUE
	END IF
	
END IF


IF lb_Continue AND al_DriverId > 0 THEN

	ls_FindString = "employeeid = " + string ( al_driverid ) 
	
	IF as_DeviceType > "" THEN
		
		ls_FindString += " and type = '" + as_devicetype + "'"
		
	END IF

	ll_FoundRow = lds_Cache.Find ( ls_FindString, 1, ll_RowCount )
	
	IF ll_FoundRow > 0 THEN
		as_DeviceType = lds_Cache.GetItemString ( ll_FoundRow, "type" )
		al_DeviceId = lds_Cache.GetItemNumber ( ll_FoundRow, "id" )
		al_CacheRow = ll_FoundRow
		ab_DriverDevice = FALSE
		lb_Continue = FALSE
		lb_Return = TRUE
	END IF
	
END IF


IF lb_Return = FALSE THEN
	SetNull ( as_DeviceType )
END IF

RETURN lb_Return
end function

public function integer of_displaypositionmap (n_cst_messagedata anv_msgdata, s_co_info astr_site, n_cst_trip anv_trip);//Note:  The astr_Site parameter, which specifies a "center point" for the position map
//(typically, the stop the vehicle is headed to next), is not utilized here in the base 
//version of the function, since all the information needed to display the PCMiler map is 
//already in lnv_Trip.  However, this information is included because it may be needed in 
//other overloads of the function  (Nextel being one such case.)

Integer	li_Return = 1

s_Mapping		lstr_Mapping
w_Map				lw_Map
w_Map_Streets	lw_Map_Streets

n_cst_LicenseManager	lnv_LicenseManager

//Check the pcmm_inst global, which indicates whether mapping is installed

IF li_Return = 1 THEN

	IF pcmm_inst THEN
		//OK
	ELSE
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	
	lstr_Mapping.TypeMap = "R"  //"Route" type
	lstr_Mapping.TypeRoute = "P" //"Practical" route type
	lstr_Mapping.Valid_TripId = anv_Trip.of_GetTripId ( )
	
	IF lstr_Mapping.Valid_TripId > 0 THEN
		//OK
	ELSE
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN
	
	IF lnv_LicenseManager.of_UsePCMilerStreets ( ) THEN
		OpenWithParm ( lw_Map_Streets, lstr_Mapping, gnv_App.of_GetFrame () )
	ELSE
		OpenWithParm ( lw_Map, lstr_Mapping, gnv_App.of_GetFrame () )
	END IF
	
END IF

RETURN li_Return
end function

public function integer of_getlastrecordedposition (long al_equipmentid, ref n_cst_messagedata anv_msgdata);//Get last recorded position data from the device table.

integer	li_Return

long		ll_RowCount, &
			ll_FoundRow
string	ls_FindString

n_ds	lds_Cache

lds_Cache = THIS.of_GetDeviceCache (TRUE)
ll_RowCount = lds_Cache.RowCount()
ls_FindString = "equipmentid = " + string ( al_equipmentid ) 

//Made this part of the find string conditional 4/21/05 BKW.  Norm was always using it, but this prevented the 
//find from succeeding in cases where the generic comm manager had been created for general position lookups.
IF is_DeviceType > "" THEN
	ls_FindString += " and type = '" + is_devicetype + "'"
END IF

ll_FoundRow = lds_Cache.find(ls_FindString, 1, ll_RowCount)

IF ll_FoundRow > 0 THEN
	//Norm had just been setting lat and long off the cache here.  Replaced with of_PopulateMessageData 2/17/05 BKW.
	This.of_PopulateMessageData ( anv_MsgData, ll_FoundRow )
	li_Return = 1
ELSE
	li_Return = -1
	
END IF

return li_Return
end function

protected function integer of_processspecialfields (n_cst_messagedata anv_msgdata);/***************************************************************************************
NAME: 			of_ProcessSpecialTags	

ACCESS:			Protected	
	
ARGUMENTS: 		(n_cst_MessageData anv_MsgData)

RETURNS:			Integer
					
	
DESCRIPTION:
				  Sets any Special Fields on the Event corresponding to the msgData
					
				  Returns 1:  Successful
				  Returns -1: Hard Error
				  Returns 0:  Could not process a field becuase of another requirement, check ofrerrors

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Created 12/12/05 MFS



***************************************************************************************/

Int		li_Return = 1
Integer	li_ErrorCount
Long		ll_EventID
Long		ll_Index
String	ls_ErrorMessage
String	lsa_Errors[]
Long		ll_NumFields
DataStore	lds_EventCache
n_cst_Msg	lnv_SpecialFields
s_parm		lstr_Parm
Long		ll_ShipmentID

n_cst_beo_Event	lnv_Event
n_cst_bso_Dispatch lnv_Dispatch 
n_cst_beo_Shipment	lnv_Shipment
n_cst_OFRError		lnv_Error

lnv_Event = CREATE n_cst_beo_Event
lnv_Dispatch = CREATE n_cst_bso_Dispatch


IF NOT isValid ( anv_MsgData ) THEN
	li_Return = -1
	ls_ErrorMessage = "The message data is not valid."
END IF

IF li_Return = 1 THEN
	ll_EventID = anv_MsgData.of_GetEventID ( ) 

	lnv_Dispatch.of_RetrieveEvents ( {ll_EventID} )
	lds_EventCache = lnv_Dispatch.of_GEtEventCache ( )

	IF isValid ( lds_EventCache ) THEN
		lds_EventCache.SetFilter ( "" )
		lds_EventCache.Filter ( )		
		
		lnv_Event.of_SetSource ( lds_EventCache )
		lnv_Event.of_SetSourceID ( ll_EventID )
	END IF
	
	ll_ShipmentID = lnv_Event.of_GetShipment ( )
	
	IF ll_ShipmentID > 0 THEN
		lnv_Shipment = CREATE n_cst_beo_Shipment
		lnv_Shipment.of_SetAllowfilterset( TRUE )
		lnv_Dispatch.of_Retrieveshipment( ll_ShipmentID )
		lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentcache( ) )
		lnv_Shipment.of_SetSourceid( ll_ShipmentID )
		lnv_Shipment.of_SetItemsource ( lnv_Dispatch.of_GetITemCache( ) )
		lnv_Event.of_SetShipment( lnv_Shipment )
		
		
		
	END IF
	
END IF

IF Not lnv_Event.of_HasSource ( ) THEN
	li_Return = -1
	ls_ErrorMessage = "The event could not be resolved." 
END IF

IF li_Return = 1 THEN
	lnv_SpecialFields = anv_MsgData.of_GetSpecialFields()
	ll_NumFields = lnv_SpecialFields.of_Get_Count()
	FOR ll_Index = 1 TO ll_NumFields
		IF lnv_SpecialFields.of_Get_Parm( ll_Index, lstr_Parm) <> 0 THEN
			lnv_Event.of_ClearErrors( )
			lnv_Event.Event ue_SetValueAny( lstr_Parm.is_Label, lstr_Parm.ia_Value)
			li_ErrorCount = lnv_Event.of_GetErrors(lsa_Errors[])
			IF li_ErrorCount > 0 THEN
				//MFS 4/16/07 - We are catching errors here incase the special field is a UNK update
				//and we cannot process because of duplicate containers
				ls_ErrorMessage = lsa_Errors[1]
				li_Return = 0
			END IF
		END IF
	NEXT
END IF

IF li_Return <> 1 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

IF li_Return <> -1 THEN
	IF lnv_Dispatch.event pt_save( ) = -1 THEN
		li_Return = -1
	END IF
	
END IF
DESTROY (lnv_Event )  
DESTROY ( lnv_Dispatch ) 
DESTROY ( lnv_Shipment ) 

RETURN li_Return
end function

public function integer of_unitidlookup (long al_eqid, ref string as_unitid, ref string as_unittype);//Lookup for unitid on the communication table for a given employee/equipment id
//Return 1 if found, -1 if not found
//ref as_unitid: unitid associated with the eq/em id passed in (empty string if not found)
//ref as_unittype: EMPLOYEE or EQUIPMENT

Integer	li_Return
Long		ll_FindRow
String	ls_UnitId
String	ls_FindString
String	ls_Type

n_ds		lds_DeviceCache

lds_DeviceCache = This.of_GetDeviceCache(False)
//Find Equipment Device
ls_FindString = "type = '" + is_DeviceType + "' AND equipmentid = " + String(al_eqid)
ll_FindRow = lds_DeviceCache.Find(ls_FindString, 1, lds_DeviceCache.RowCount())
ls_Type = cs_EQUIPMENT
//Find employee handheld device
IF ll_FindRow < 1 THEN
	ls_FindString = "type = '" + is_DeviceType + "' AND employeeid = " + String(al_eqid)
	ll_FindRow = lds_DeviceCache.Find(ls_FindString, 1, lds_DeviceCache.RowCount())
	ls_Type = cs_EMPLOYEE
END IF

IF ll_FindRow > 0 THEN
	ls_UnitId = lds_DeviceCache.GetItemString(ll_FindRow, "unitid")
	as_unitid = ls_UnitId
	as_unittype = ls_Type
	li_Return = 1
ELSE
	li_Return = -1
END IF
	
Return li_Return
end function

protected function integer of_processdutystatus (ref n_cst_messagedata anv_msgdata);Int		li_Return = 1
String	ls_ErrorMessage
Date		ld_EventDate
Date		ld_MessageDate
Long		ll_EventID
DataStore	lds_EventCache
n_cst_bso_Dispatch	lnv_Dispatch
n_cst_OFRError			lnv_Error

lnv_Dispatch = CREATE n_cst_bso_Dispatch 

IF NOT isValid ( lnv_dispatch ) THEN
	li_Return = -1 
	ls_ErrorMessage = "The dispatch object is not valid."
END IF

IF NOT isValid ( anv_msgdata ) THEN
	li_Return = -1
	ls_ErrorMessage = "The message data is not valid."
END IF

// we have the message data. we need to get the driver that is submitting 
// the duty status change. 
// if the device is a hand held then it will be linked to the driver
// but if the device is a hard mount there is no way to get the driver, so we 
// will require that they send in their id along with the status change. 
Long	ll_DriverID
Int	li_Status = -1
String	ls_DutyStatus
DateTime ldtm_now



ll_DriverID = anv_msgdata.of_getDriverID ( ) 
IF ll_DriverID > 0 THEN
	ls_DutyStatus =  anv_msgdata.of_GetDriverDutyStatus ( ) 
	
	IF ls_DutyStatus = "ON"  THEN
		li_Status = 1
		ldtm_now = DateTime ( Today ( ) , now ( ) ) 
	ELSEIF ls_DutyStatus = "OFF" THEN
		li_Status = 0
	ELSE
		
		// could not determine the status
		li_Return = -1
		ls_ErrorMessage = "Driver duty status could not be determined."
	END IF
		
ELSE
	li_Return = -1
	ls_ErrorMessage = "Driver id could not be resolved."
	
END IF

IF li_Return = 1 THEN
	IF li_Status = 1 THEN
		
	  UPDATE "driverinfo"  
     SET "di_dutystatus" = :li_status,   
         "di_dutystatusdatetime" = :ldtm_now
		WHERE "di_id" = :ll_DriverID ;
		
	ELSE
		
	 UPDATE "driverinfo"  
     SET "di_dutystatus" = :li_status 
		WHERE "di_id" = :ll_DriverID ;
	
	END IF	
	
	IF SQLCA.sqlcode  = 0 THEN
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF
	
	
END IF

IF li_Return = 1 THEN
	THIS.of_Replytodutystatuschange( anv_msgdata , ls_DutyStatus )
END IF
// testing the len here b/c some method will cause -1 but will add their own 
// error message
IF li_Return = -1 AND Len ( ls_ErrorMessage ) > 0 THEN	
	lnv_Error = This.AddOFRError ( )
	lnv_Error.SetErrorMessage ( ls_ErrorMessage )
END IF

DESTROY lnv_Dispatch

				
RETURN li_Return
end function

protected function integer of_replytodutystatuschange (n_cst_messagedata anv_messagedata, string as_newstatus);Any			la_Path
String		ls_FilePath
String		ls_DocName
String		ls_ExtensionPath
Long			ll_Destination 
Int			li_Return = 1
String		ls_Message
String 		ls_First
String		ls_Last
String		ls_Entity

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm
s_OutboundMessage	lstra_Messages[]

ls_DocName = "freeform.doc"

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_FilePath = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )

ls_ExtensionPath = "message\" + is_DeviceType + "\outbound\"
IF len ( ls_FilePath ) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	lstra_Messages[1].is_Template = ls_FilePath + ls_ExtensionPath + ls_DocName
ELSE
	li_Return = -1
END IF


ll_Destination = anv_Messagedata.of_GetTractorID ( ) 
IF ll_Destination > 0 THEN
	
	
	  SELECT "equipment"."eq_ref"  
    INTO :ls_Entity  
    FROM "equipment"  
   WHERE "equipment"."eq_id" = :ll_Destination   
           ;
	Commit;

ELSE // try the driver
	ll_Destination = anv_Messagedata.of_GetDriverID ( )
	IF ll_Destination > 0 THEN
		
		SELECT "employees"."em_fn",   
				"employees"."em_ln"  
		 INTO :ls_First,   
				:ls_Last  
		 FROM "employees"  
		WHERE "employees"."em_id" = :ll_Destination   
				  ;
		Commit;
		
		ls_Entity = ls_First + " " + ls_Last 
		
	END IF
END IF


IF ll_Destination <= 0 THEN
	li_Return = -1
ELSE
	lstra_Messages[1].il_destination = ll_Destination
END IF

// determine the confimation mesage to send to the driver
CHOOSE CASE as_newstatus
	CASE "ON"
		ls_Message = "Welcome ON DUTY " + ls_Entity
	CASE "OFF"
		ls_Message = "Goodbye " + ls_Entity
END CHOOSE


lstr_Parm.is_Label = "FREEFORMTEXT"
lstr_Parm.ia_Value = ls_Message
lnv_Msg.of_Add_Parm ( lstr_Parm ) 


lstr_Parm.is_Label = "MESSAGES"
lstr_Parm.ia_Value = lstra_Messages
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

IF li_Return = 1 THEN
	IF THIS.of_SendOutbound ( lnv_Msg ) <> 1 THEN
		li_Return = -1 
	END IF
END IF

RETURN li_Return
end function

protected function integer of_replywithsuccess (n_cst_messagedata anv_msgdata);Any			la_Path
String		ls_FilePath
String		ls_DocName
String		ls_ExtensionPath
Long			ll_Destination 
Int			li_Return = 1

n_cst_msg	lnv_Msg
S_Parm		lstr_Parm
s_OutboundMessage	lstra_Messages[]

ls_DocName = "freeform.doc"

n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_FilePath = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting )
ls_ExtensionPath = "message\" + is_DeviceType + "\outbound\"
IF len ( ls_FilePath ) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	lstra_Messages[1].is_Template = ls_FilePath + ls_ExtensionPath + ls_DocName
ELSE
	li_Return = -1
END IF

ll_Destination = anv_msgdata.of_GetTractorID ( ) 
IF ll_Destination <= 0 THEN

	ll_Destination = anv_msgdata.of_GetDriverID ( )
	
	IF ll_Destination <= 0 THEN
		ll_Destination = anv_msgdata.of_GetSourceEntityID ( ) 
	END IF
END IF

IF ll_Destination <= 0 THEN
	li_Return = -1
ELSE
	lstra_Messages[1].il_destination = ll_Destination
END IF



//Dispatch has recieved the + anv_msgdata.of_GetMessagetype ()  + " message."

lstr_Parm.is_Label = "FREEFORMTEXT"
lstr_Parm.ia_Value = "Dispatch has received the "+ anv_msgdata.of_GetMessagetype ()  + " message."
lnv_Msg.of_Add_Parm ( lstr_Parm ) 


lstr_Parm.is_Label = "MESSAGES"
lstr_Parm.ia_Value = lstra_Messages
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

IF li_Return = 1 THEN
	IF THIS.of_SendOutbound ( lnv_Msg ) <> 1 THEN
		li_Return = -1 
	END IF
END IF

RETURN li_Return
end function

public function integer of_sourceentityidlookup (string as_unitid, ref long al_entityid, ref string as_resulttype);Return This.of_SourceEntityIdLookup(as_unitid, al_entityid, as_resulttype, is_DeviceType)
end function

public function integer of_sourceentityidlookup (string as_unitid, ref long al_entityid, ref string as_resulttype, string as_devicetype);//Lookup for eq/em id on the communication table for a given unitid
//Return 1 if found, -1 if not found
//ref al_result: equipment/employee id associated with the unit id passed in (empty string if not found)
//ref as_resulttype: EMPLOYEE or EQUIPMENT

Integer	li_Return
Long		ll_FindRow
Long		ll_Id
String	ls_FindString
String	ls_Type

n_ds		lds_DeviceCache

lds_DeviceCache = This.of_GetDeviceCache(False)
//Find unitid
ls_FindString = "type = '" + as_DeviceType + "' AND unitid = '" + String(as_unitid) + "'"
ll_FindRow = lds_DeviceCache.Find(ls_FindString, 1, lds_DeviceCache.RowCount())

IF ll_Findrow > 0 THEN
	
	ll_Id = lds_DeviceCache.GetItemNumber(ll_FindRow, "equipmentid")
	ls_Type = cs_EQUIPMENT
	IF isNull(ll_Id) OR ll_Id < 1 THEN
		ll_Id = lds_DeviceCache.GetItemNumber(ll_FindRow, "employeeId")
		ls_Type = cs_EMPLOYEE
	END IF
	
	IF ll_Id > 0 THEN
		al_entityid = ll_Id
		as_resultType = ls_Type
		li_Return = 1
	ELSE
		li_Return = -1
	END IF
	
ELSE
	li_Return = -1
END IF

Return li_Return
end function

on n_cst_bso_communication_manager.create
call super::create
end on

on n_cst_bso_communication_manager.destroy
call super::destroy
end on

event constructor;call super::constructor;IF Not IsValid (sds_DeviceCache) THEN

	sds_DeviceCache = CREATE n_ds
	sds_DeviceCache.dataobject = "d_communication_device"
	sds_DeviceCache.settransobject (sqlca)
	sds_DeviceCache.Retrieve( )
//
//	THIS.of_RetrieveDeviceList ( temp )
//	IF IsValid ( temp ) THEN
//		sds_DeviceCache = temp
//		Destroy Temp
//	END IF

END IF

IF Not IsValid ( sds_Destination ) THEN
	sds_Destination = CREATE DataStore
	sds_Destination.DataObject = "d_Communication_Destination_Display"
   THIS.of_PopulateDestinationDisplay ( )
END IF
end event

