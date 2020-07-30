$PBExportHeader$n_cst_bso_communication_cadec.sru
forward
global type n_cst_bso_communication_cadec from n_cst_bso_communication_manager
end type
end forward

global type n_cst_bso_communication_cadec from n_cst_bso_communication_manager
end type
global n_cst_bso_communication_cadec n_cst_bso_communication_cadec

type variables

Private:
Int    ii_FileHandle
String is_FilePath

end variables

forward prototypes
public function integer of_gettemplate (ref string as_templatepath)
private subroutine of_setfilepath ()
public subroutine of_getfilepath (ref string as_path)
public function integer of_getinbound (ref datastore ads_message)
public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_messagedata anv_msgdata, boolean ab_lastrecorded)
public subroutine of_getimportfile (ref string as_file)
protected function integer of_processinboundmessages (ref n_cst_messagedata anva_msgdata[], ref datastore ads_message)
protected subroutine of_getmessage (datastore ads_import, ref n_cst_messagedata anva_msgdata[])
private function integer of_moveinboundfile (string as_importfile, ref string as_newfile)
private function integer of_processfile (ref datastore ads_import, ref datastore ads_message)
public function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext, boolean ab_createdevice)
end prototypes

public function integer of_gettemplate (ref string as_templatepath);

// get template Returns:
//								-1 = error
//								 0 = User Canceled
//								 1 = success



Int		li_Return 
Int		li_FileOpenRtn
String	ls_PathName
String	ls_FileName
String	ls_Extension
String	ls_Filter

ls_Extension = ".doc"
ls_Filter = "All Files (*.*),*.*"

// do we want to change the directory to the location of the templates
// first??
// do we know the path ??


li_FileOpenRtn = GetFileOpenName ( "Outbound Qualcomm Templates", ls_pathname, ls_filename , ls_extension , ls_filter  ) 
IF li_FileOpenRtn = 1 THEN
	li_Return = 1
ELSEIF li_FileOpenRtn = 0 THEN
	// userCanceled
	li_Return = 0 
ELSE  // unexpected return
	li_Return = -1
END IF
	

as_TemplatePath = ls_PathName

RETURN li_Return 
end function

private subroutine of_setfilepath ();//	Set the path for commnication message importing and exporting from
//	the system setting 

Integer	li_Return
string	ls_path

n_cst_setting_TopLevelFolderForIOFiles	lnv_Setting

lnv_Setting = create n_cst_setting_TopLevelFolderForIOFiles

ls_path =  lnv_Setting.of_Getvalue( ) 

destroy lnv_setting

IF len(ls_path) > 0 THEN
	is_filepath = String ( ls_path ) 
else
	//use the application path
	is_filepath = gnv_app.of_GetApplicationfolder( )
END IF

end subroutine

public subroutine of_getfilepath (ref string as_path);IF len ( is_FilePath ) > 0 THEN
	//CONTINUE
	
ELSE
	
	THIS.of_SetFilePath ( )

END IF

as_path = is_filepath

end subroutine

public function integer of_getinbound (ref datastore ads_message);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetInbound
//
//	Access:  public
//
//	Arguments:  ads_message by reference
//
//
//	Description:	
//
// 
//
//
// Written by: Norm LeBlanc
// 		Date: 11/24/04
//		Version: 4.0.01
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////


string	ls_ImportFile, &
			ls_FileName, &
			ls_ErrorMessage
			
integer	li_Ret = 1, &
			li_index

Int		li_Count
Int		i

long		ll_ImportRet

boolean	lb_ProcessFile

n_cst_MessageData		lnva_MsgData[]
n_cst_OFRError			lnv_Error
datastore				lds_import

THIS.of_GetImportFile ( ls_FileName ) 

if fileexists(ls_FileName) then
	
	THIS.of_MoveInboundFile(ls_FileName, ls_ImportFile)
	
	if len(ls_ImportFile) > 0 then
		lds_Import = create datastore
		lds_Import.dataobject = 'd_cadec'
		lds_Import.SetTransobject( SQLCA )
		
		ll_ImportRet = lds_import.ImportFile(ls_ImportFile)
		IF ll_ImportRet < 0 THEN
			li_Ret = -1
			ls_errormessage = "Received an error code " + string(ll_ImportRet) + " while importing cadec file. "
			lnv_Error = This.AddOFRError ( )
			if IsValid ( lnv_Error ) then
				lnv_Error.SetErrorMessage ( ls_ErrorMessage )
			end if			
		ELSE	
			//process file
			if this.of_ProcessFile(lds_import, ads_message) = 1 then
				li_Ret = 1
			else
				ls_errormessage = "Encountered an error while processing the cadec import file. "
				lnv_Error = This.AddOFRError ( )
				if IsValid ( lnv_Error ) then
					lnv_Error.SetErrorMessage ( ls_ErrorMessage )
				end if			
				li_Ret = -1
			end if

		END IF
		
		destroy lds_import
		
		//don't delete the file if we encountered errors
		if li_ret = 1 then
			FileDelete(ls_ImportFile)
		end if
			
	else
		//problem moving file
		//error message set in of_moveinboundfile method
		li_Ret = -1
	end if
	
else
	// no file, no error
	li_Ret = 1
end if

return li_Ret
end function

public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_messagedata anv_msgdata, boolean ab_lastrecorded); //////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Locatetruck
//
//	Access:  public
//
//	Arguments:  
//					al_equipmentId
//					ads_message by reference
//					ab_LastRecorded
//
//
//	Description:	
//			If ab_LastRecorded is TRUE then get the location from the device
//			table otherwise force a call to the truck to get the current
//			location of the truck. 
//
//			Force a call to the truck(odl.doc), check for success.  If call is successful
//			then send one_loctruck service.(truckloc.doc) to get the actual 
//			lat/long for the truck.
//
//
// Written by: Norm LeBlanc
// 		Date: 12/12/00
//		Version: 3.0.5
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

//

// Send URL

/*	
	loc_onetruck service
*/
long		ll_RowCount, &
			ll_FoundRow
string	ls_FindString
Integer	li_Return
n_ds	lds_Cache

li_Return = 1

IF Not IsValid ( anv_msgData ) THEN
	anv_msgData = CREATE n_cst_messageData 
END IF

IF ab_LastRecorded THEN
	//get latlong from device table
	
	lds_Cache = THIS.of_GetDeviceCache (TRUE)
	ll_RowCount = lds_Cache.RowCount()
	ls_FindString = "equipmentid = " + string ( al_equipmentid ) + " and type = '" + is_devicetype + "'"
	ll_FoundRow = lds_Cache.find(ls_FindString, 1, ll_RowCount)
	IF ll_FoundRow > 0 THEN
		//Norm had just been setting lat and long off the cache here.  Replaced with of_PopulateMessageData 2/17/05 BKW.
		This.of_PopulateMessageData ( anv_MsgData, ll_FoundRow )
	ELSE
		li_Return = -1
	END IF

ELSE

//no current position yet

END IF

return li_Return
end function

public subroutine of_getimportfile (ref string as_file);// this function will return by reference a file in which the message to be sent to the 
// truck ( export ) should be read from. if the file does not exist it will be created 
// so the calling script can append to the passed file.

long ll_FileNum

string	ls_file

n_cst_setting_InboundCadecFile	lnv_Setting

lnv_Setting = create n_cst_setting_InboundCadecFile

ls_file =  lnv_Setting.of_Getvalue( ) 

destroy lnv_setting

as_file = ls_file
end subroutine

protected function integer of_processinboundmessages (ref n_cst_messagedata anva_msgdata[], ref datastore ads_message);/*

	Ancestor reports on all messsages received. The method is being 
	overridden to only report on errors

*/

Integer	li_Return = 1
long		ll_Ndx, &
			ll_MessageCount, &
			ll_NewRow, &
			lla_UpdatedEqId[], &
			ll_ShipId, &
			ll_EventId
			
Long		ll_Equipment			
String	ls_ErrorText
String	ls_ErrorMessage
String	ls_TrailerMessage
String	ls_Text
String	ls_Driver
String	ls_EventStatus
String	ls_EventType
String	ls_SiteCodeName
String	ls_Trailer

n_cst_EquipmentManager	lnv_Equipment
n_cst_ofrError		lnva_Errors[]

datastore	lds_CommunicationDevice

lds_CommunicationDevice = 	CREATE datastore
lds_CommunicationDevice.DataObject = "d_Communication_Device"
lds_CommunicationDevice.SetTransObject ( SQLCA ) 

IF lds_CommunicationDevice.Retrieve(0) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN

	ll_MessageCount = upperbound ( anva_MsgData )
	
	FOR ll_Ndx = 1 TO ll_MessageCount
		
		This.ClearOFRErrors ( ) 
		ll_Equipment = 0
		ls_ErrorMessage = ""
		ls_TrailerMessage = ""
		ls_Text = ""
		
		//is there an itinerary for the msg date?
		
		//is there a matching event for the message?
		if this.of_findeventfortruck( anva_MsgData[ll_Ndx]) = 1 then
			
			IF this.of_SetNewLocation ( anva_MsgData[ll_Ndx], lds_CommunicationDevice, ls_ErrorText, TRUE/* create*/ ) < 0 THEN
		
				ls_ErrorMessage = ls_ErrorText
				
			ELSE
				
				//Does structure have a trailer number? 
				//Assign before updating times so confirmation can happen.
	
				ls_Trailer = anva_MsgData[ll_Ndx].of_GetTrailer ( )
				IF len(ls_Trailer) > 0 THEN
					if THIS.of_ProcessTrailer ( anva_MsgData[ll_Ndx] , ll_Equipment ) <> 1 then
						IF THIS.GetOFRErrors ( lnva_Errors ) > 0 THEN
							ls_TrailerMessage = lnva_Errors[1].GetErrorMessage ( )
						END IF
	
						//problem assigning trailer to an event that did not already have
						//an assignment
						
						//don't stop updating of times
						This.ClearOFRErrors ( )
						
					end if
				END IF
					
				IF ll_Equipment > 0 THEN
					lla_UpdatedEqId[ upperbound (lla_UpdatedEqId) + 1] = ll_Equipment
				END IF
				
				CHOOSE CASE anva_MsgData[ ll_Ndx ].of_GetMessageType ( ) //is_MessageType
						
					CASE "ARRIVE", "DEPART" 	//Update event
		
						IF THIS.of_ProcessArriveDepart ( anva_MsgData[ ll_Ndx ]  ) <> -1 THEN
							//success
						ELSE
							//error will be reported below.
						END IF
								
					CASE ELSE
						
						ls_ErrorMessage = "Invalid status type."
						
				END CHOOSE
			
			END IF
			
		else
			//error in message object
			
		end if
				
		IF THIS.GetOFRErrors ( lnva_Errors ) > 0 THEN
			ls_ErrorMessage = lnva_Errors[1].GetErrorMessage ( )
		END IF

		IF len(ls_ErrorMessage) > 0 or len(ls_TrailerMessage) > 0 then
			
			ls_Driver = anva_MsgData[ll_Ndx].of_GetDriverRef ( )
			ls_EventStatus = anva_MsgData[ll_Ndx].of_GetMessageType ( )
			ls_EventType = anva_MsgData[ll_Ndx].of_GetEventType ( )
			ls_SiteCodeName = anva_MsgData[ll_Ndx].of_GetSiteCodeName ( )
			ll_ShipId = anva_MsgData[ll_Ndx].of_GetShipmentID ( )
			
			ls_Text = ls_Text + "Driver: "
			if len(ls_Driver) > 0 then
				ls_Text = ls_Text + ls_driver + " "
			else
				ls_Text = ls_Text + "N/A" + " "
			end if
			
			ls_text = ls_Text + "Status: "
			if len(ls_EventStatus) > 0 then
				ls_Text = ls_Text + ls_EventStatus + " "
			else
				ls_Text = ls_Text + "N/A" + " "
			end if
			
			ls_Text = ls_Text + "Type: "
			if len(ls_EventType) > 0 then
				ls_Text = ls_Text + ls_EventType + " "
			else
				ls_Text = ls_Text + "N/A" + " "
			end if
			
			ls_Text = ls_Text + "at "
			if len(ls_SiteCodeName) > 0 then
				ls_Text = ls_Text + ls_SiteCodeName + " "
			else
				ls_Text = ls_Text + "N/A" + " "
			end if
			
			ls_Text = ls_Text + "Shipment: "
			if ll_ShipId > 0 then
				ls_Text = ls_Text + string(ll_ShipId) + " "
			else
				ls_Text = ls_Text + "N/A" + " "
			end if
			
			if len(ls_TrailerMessage) > 0 then
				if len(ls_ErrorMessage) > 0 then
					//add it to the text message, don't want to wipe out additional errors
					ls_Text = ls_Text + ls_TrailerMessage
				else
					//put it in the error message
					ls_ErrorMessage = ls_TrailerMessage
				end if
			end if
			
			ls_text = ls_Text + anva_MsgData[ll_Ndx].of_GetMessageText( )
			
			//write to message datastore
			ll_NewRow = ads_message.InsertRow(0)
			ads_message.Object.message_source[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetEquipmentRef ( )//is_EquipmentRef
			ads_message.Object.message_date[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetlastPositionDate ( )//id_LastPositionDate
			ads_message.Object.message_time[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetLastPositionTime ( )//it_LastPositionTime
			ads_message.Object.message_position[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetLastPositionLocation ( ) //is_LastPositionLocation
			ads_message.Object.message_text[ll_NewRow] =  ls_Text
			ads_message.Object.message_shipmentid[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetShipmentID ( )//il_shipmentid
			ads_message.Object.message_eventid[ll_NewRow] = anva_MsgData[ll_Ndx].of_GetEventID ( )//il_eventid
				
			ads_message.Object.message_errortext[ll_NewRow] = ls_ErrorMessage
			ads_message.Object.message_status[ll_NewRow] = "E"
			
			li_Return = -1
			
		END IF		
			

	NEXT

END IF

//IF li_Return = 1 THEN
	
	IF lds_CommunicationDevice.Update() = 1 THEN
		COMMIT USING SQLCA;	
	ELSE
		ROLLBACK USING SQLCA;
		li_Return = -1
	END IF		

//END IF


//refresh updated equipment references
IF upperbound ( lla_UpdatedEqId ) > 0 THEN
	lnv_Equipment.of_Cache ( lla_UpdatedEqId, TRUE )
END IF

This.ClearOFRErrors ( ) 

return li_Return
end function

protected subroutine of_getmessage (datastore ads_import, ref n_cst_messagedata anva_msgdata[]);Long		ll_row, &
			ll_rowcount, &
			ll_column, &
			ll_columncount, &
			ll_Pos, &
			ll_Message_Ndx, &
			ll_Message_Max, &
			ll_DataObjectIndex, &
			ll_Null

String	ls_ColumnName, &
			lsa_Message[], &
			lsa_Blank[], &
			ls_MessageType, &
			ls_Line, &
			ls_Text

Boolean	lb_Message
Int		li_Count
Int		i

n_cst_messageData		lnv_CurrentMsg

li_Count = UpperBound ( anva_MsgData )
FOR i = 1 TO li_Count
	DESTROY ( anva_MsgData[i] )
NEXT

Setnull( ll_Null )

ll_rowcount = ads_Import.rowcount()
ll_columncount = long(ads_Import.Object.DataWindow.Column.Count)

for ll_row = 1 to ll_rowcount
						
	ll_DataobjectIndex ++
	anva_MsgData[ll_DataobjectIndex] = CREATE n_cst_MessageData
	lnv_CurrentMsg	= anva_MsgData[ll_DataobjectIndex]
	
	//Get message
	for ll_column = 1 to ll_columncount
		
		ls_columnName = ads_Import.Describe("#" + String(ll_column) + ".Name")
		ls_text = ads_Import.GetItemString(ll_row, ll_column)

		//Get data from message and load into structure
		CHOOSE CASE UPPER(ls_ColumnName)
				
			CASE 'VEHICLEID', "POWERUNIT"	//UnitId	
				lnv_CurrentMsg.of_SetEquipmentRef ( trim ( ls_text ) )
																	
			CASE 'DRIVERID'
				lnv_CurrentMsg.of_SetDriverRef ( trim ( ls_text ) )
				
			CASE 'EVENTTYPE', 'EVENT'
				lnv_CurrentMsg.of_SetEventType ( trim ( ls_text ) )
				
			CASE 'STATUSTYPE', 'STATUS'
				choose case upper(ls_text)
					case 'A', 'ARRIVE'
						//Arrive Event Type
						lnv_CurrentMsg.of_SetMessageType ( "ARRIVE" )
						
					case 'D', 'DEPART'
						//Depart Event Type
						lnv_CurrentMsg.of_SetMessageType ( "DEPART" )
						
				end choose
				
			CASE 'ACCOUNTID', 'CODENAME'	//LastPositionLocation
				lnv_CurrentMsg.of_SetSiteCodeName ( trim ( ls_text ) )
				
			CASE 'LATITUDE', 'LAT'		//LastPositionLat
				lnv_CurrentMsg.of_SetLastPositionLat ( trim ( ls_text ) )
				
			CASE 'LONGITUDE', 'LONG'	//LastPositionLong
				lnv_CurrentMsg.of_SetLastPositionLong ( trim ( ls_text ) )
								
			CASE 'DATE', 'MESSAGEDATE'
				lnv_CurrentMsg.of_SetLastPositionDate ( Date ( ls_text ) )
				
			CASE 'TIME', 'MESSAGETIME'
				lnv_CurrentMsg.of_SetLastPositionTime ( Time ( ls_text ) )
				
			CASE 'TRAILERID'
				lnv_CurrentMsg.of_SetTrailer ( ls_text )
				
			CASE "COMODITY", 'TMP'		//Text Message
				//look for tmp #
				IF isnumber ( ls_Text ) THEN
					lnv_CurrentMsg.of_SetShipmentId ( long ( ls_Text ) )
				END IF

		END CHOOSE
	
	next

NEXT

end subroutine

private function integer of_moveinboundfile (string as_importfile, ref string as_newfile);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_MoveINboundFile
//  
//	Access		:private
//
//	Arguments	:as_newfile by reference
//
//	Return		:integer
//					1 = success
//				  -1 = failure
//						
//	Description	:
//
//			We need to move the inbound file before processing in order to avoid a
//			collision or missed messages from the Cadec system. This method will 
//			attempt to move the file if it is not locked by Cadec. If there is a 
//			conflict then this method will loop for 20 seconds. If the move was 
//			unsuccessful, a -1 will be returned.
//
//
// Written by	:Norm LeBlanc
// 		Date	:12/14/2004
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

Integer	li_Return = 1, &
			li_FileRet, &
			i, &
			j

String	ls_File, &
			ls_ImportFile, &
			ls_TempFileName, &
			ls_Movename, &
			ls_Drive, &
			ls_Directory

n_cst_string			lnv_String
n_cst_filesrvwin32	lnv_filesrvwin32

lnv_filesrvwin32 = CREATE n_cst_FileSrvwin32

ls_ImportFile = as_ImportFile

//Strip filename and rename
lnv_filesrvwin32.of_ParsePath(ls_ImportFile, ls_Drive, ls_directory, ls_File)

if li_Return = 1 then
	
	// Changed this from "hhss" to "hhmmss" because the scheduler seemed to 
	// hitting the same hh and ss every hour.
	ls_Movename = string ( today(),"mmdd") + string ( now(), "hhmmss") + ".txt"
	
	ls_TempFileName = ls_ImportFile
	ls_TempFileName = lnv_String.of_Substitute (ls_TempFileName, ls_File, ls_Movename)
	
	if fileExists(ls_TempFileName) then
		fileDelete(ls_TempFileName)
	end if
	
	//try to rename the file so that cadec will create a new one 
	//If the file is locked for write then try in a loop
	//if not successful then exit.
	do	
		
		li_FileRet = lnv_filesrvwin32.of_FileRename(ls_importfile, ls_TempFileName)
		if li_FileRet = 1 then
			as_newfile = ls_TempFileName
		else
			//try 3 times
			j ++
			
			if j = 4 then
				
				li_Return = -1
				exit
				
			else
				
				For i = 1 TO 10 
					Yield ( ) 
				NEXT

			end if
			
		end if
		
	loop until li_FileRet = 1
	
end if

destroy lnv_filesrvwin32

return li_Return

end function

private function integer of_processfile (ref datastore ads_import, ref datastore ads_message);///////////////////////////////////////////////////////////////////////////////
//
//	Name			:of_ProcessFile
//  
//	Access		:private
//
//	Arguments	:ads_import by ref
//					 ads_message by ref
//
//	Return		:integer
//						-1 failure
//						 1 success
//	Description	:
//
//			Process the import file and create a message log of failed messages.
//
// Written by	:Norm LeBlanc
// 		Date	:12/21/2004
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History	:date, name, comment
//
//	
//////////////////////////////////////////////////////////////////////////////
//

integer	li_Return = 1, &
			li_Count, &
			i
			
n_cst_MessageData		lnva_MsgData[]
n_cst_OFRError			lnv_Error

//load message structure array
this.of_GetMessage ( ads_import, lnva_MsgData )

li_Count = UpperBound ( lnva_MsgData )

IF this.of_ProcessInboundMessages ( lnva_MsgData, ads_Message ) < 0 THEN
	
	li_Return = -1
	
END IF

FOR i = 1 TO li_Count 
	DESTROY ( lnva_MsgData[i] )
NEXT

return li_Return
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

ll_EquipmentId =  anv_MsgData.of_GEtTractorId()

ll_DeviceRowCount = ads_CommunicationDevice.RowCount()

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

on n_cst_bso_communication_cadec.destroy
call super::destroy
end on

event constructor;call super::constructor;
is_DeviceType = n_cst_Constants.cs_CommunicationDevice_Cadec
end event

on n_cst_bso_communication_cadec.create
call super::create
end on

