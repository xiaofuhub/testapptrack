$PBExportHeader$n_cst_bso_communication_nextel.sru
forward
global type n_cst_bso_communication_nextel from n_cst_bso_communication_manager
end type
end forward

global type n_cst_bso_communication_nextel from n_cst_bso_communication_manager
end type
global n_cst_bso_communication_nextel n_cst_bso_communication_nextel

forward prototypes
public function integer of_displaypositionmap (s_nextel_mapserviceparms astr_mapparms)
public function integer of_sendoutbound (n_cst_msg anv_message)
public function integer of_displaypositionmap (n_cst_messagedata anv_msgdata, s_co_info astr_site, n_cst_trip anv_trip)
end prototypes

public function integer of_displaypositionmap (s_nextel_mapserviceparms astr_mapparms);//This is a VISUAL function.  It will display map windows, message boxes, etc.
//Returns : 1 (Success), -1 (Error), 0 (User Cancel)

String	ls_Request, &
			ls_MessageHeader
Inet		lnv_Web

n_cst_String	lnv_String

n_cst_Setting_NextelMappingAddress	lnv_NextelMappingAddress

Integer	li_Return = 1

ls_MessageHeader = "Display Position Map"


IF li_Return = 1 AND NOT KeyDown ( KeyShift! ) THEN

	OpenWithParm ( w_MapService_Parms, astr_MapParms )
	
	//If the user OK'd the dialog, an updated s_Nextel_MapServiceParms structure will be passed back out.
	
	IF IsValid ( Message.PowerObjectParm ) THEN
		IF ClassName ( Message.PowerObjectParm ) = "s_nextel_mapserviceparms" THEN
			astr_MapParms = Message.PowerObjectParm
		ELSE
			li_Return = 0  //User cancelled.
		END IF
	ELSE
		li_Return = 0  //User cancelled.
	END IF

END IF


IF li_Return = 1 THEN

	astr_MapParms.is_ServicePath = Trim ( astr_MapParms.is_ServicePath )
	
	IF astr_MapParms.is_ServicePath > "" THEN
		//OK
	ELSE
		lnv_NextelMappingAddress = CREATE n_cst_Setting_NextelMappingAddress
		astr_MapParms.is_ServicePath = Trim ( lnv_NextelMappingAddress.of_GetValue ( ) )
		DESTROY lnv_NextelMappingAddress
	END IF
	
	IF astr_MapParms.is_ServicePath > "" THEN
		ls_Request = astr_MapParms.is_ServicePath  //Note : The address must be followed by the ?RID={encryped role id} parameter.
	ELSE
		MessageBox ( ls_MessageHeader, "The 'Nextel Mapping Service Address' has not been set up in system settings." )
		li_Return = -1
	END IF
	
END IF


IF li_Return = 1 THEN
	
	//Append the supplied parameter values to the request path.
	
	IF astr_MapParms.is_Start > "" THEN
		ls_Request += "&Start=" + astr_MapParms.is_Start
	END IF
	
	IF astr_MapParms.is_End > "" THEN
		ls_Request += "&End=" + astr_MapParms.is_End
	END IF
	
	IF astr_MapParms.ii_Hours > 0 THEN
		ls_Request += "&Hours=" + String ( astr_MapParms.ii_Hours )
	END IF
	
	IF astr_MapParms.ii_Minutes > 0 THEN
		ls_Request += "&Minutes=" + String ( astr_MapParms.ii_Minutes )
	END IF
	
	astr_MapParms.is_IdList = Trim ( astr_MapParms.is_IdList )
	astr_MapParms.is_GroupIdList = Trim ( astr_MapParms.is_GroupIdList )
	astr_MapParms.istr_Center.co_City = Trim ( astr_MapParms.istr_Center.co_City )
	astr_MapParms.istr_Center.co_State = Trim ( astr_MapParms.istr_Center.co_State )
	astr_MapParms.istr_Center.co_Zip = Trim ( astr_MapParms.istr_Center.co_Zip )
	
	IF astr_MapParms.is_IdList > "" THEN
		ls_Request += "&ID=" + astr_MapParms.is_IdList
	END IF
	
	IF astr_MapParms.is_GroupIdList > "" THEN
		ls_Request += "&GroupID=" + astr_MapParms.is_GroupIdList
	END IF
	
	IF astr_MapParms.is_Lat > "" AND astr_MapParms.is_Lon > "" THEN
		
		//Note:  Elutions requires Lat and Lon in DMS format.  If they're not in DMS format,
		//they should be converted.  However, this is a moot point at the moment because nothing
		//is actually populating these parms.
		
		ls_Request += "&Lat=" + astr_MapParms.is_Lat
		ls_Request += "&Lon=" + astr_MapParms.is_Lon
	
	ELSEIF astr_MapParms.istr_Center.co_City > "" AND astr_MapParms.istr_Center.co_State > "" THEN
		
		IF astr_MapParms.istr_Center.co_Addr1 > "" THEN
			ls_Request += "&StreetAddress=" + astr_MapParms.istr_Center.co_Addr1
		END IF
		
		ls_Request += "&City=" + astr_MapParms.istr_Center.co_City
		ls_Request += "&State=" + astr_MapParms.istr_Center.co_State
		
		IF Pos ( "AB BC MB NB NF NT NS ON PE PQ QC SK YK", astr_MapParms.istr_Center.co_State ) > 0 THEN
			ls_Request += "&Country=Canada"
			IF astr_MapParms.istr_Center.co_Zip > "" THEN
				ls_Request += "&PostalCode=" + lnv_String.of_GlobalReplace ( astr_MapParms.istr_Center.co_Zip, " ", "" )
			END IF
		ELSEIF astr_MapParms.istr_Center.co_State = "MX" THEN
			ls_Request += "&Country=Mexico" //Currently, Mexico is not supported, but no big problem to try it.
			IF astr_MapParms.istr_Center.co_Zip > "" THEN
				ls_Request += "&PostalCode=" + lnv_String.of_GlobalReplace ( astr_MapParms.istr_Center.co_Zip, " ", "" )
			END IF
		ELSE
			ls_Request += "&Country=United_States"
			IF astr_MapParms.istr_Center.co_Zip > "" THEN
				ls_Request += "&PostalCode=" + Left ( astr_MapParms.istr_Center.co_Zip, 5 )
			END IF
		END IF
		
	END IF
	
	IF astr_MapParms.ii_Radius > 0 THEN
		ls_Request += "&Radius=" + String ( astr_MapParms.ii_Radius )
	END IF
	
	IF astr_MapParms.ii_Refresh > 0 THEN
		ls_Request += "&Refresh=" + String ( astr_MapParms.ii_Refresh )
	END IF
	
END IF


IF li_Return = 1 THEN

	IF GetContextService ( "Internet", lnv_Web ) = 1 THEN
	
		lnv_Web.HyperlinkToURL ( ls_Request )
		
	END IF

END IF

RETURN li_Return
end function

public function integer of_sendoutbound (n_cst_msg anv_message);//Note: With the exception of the section added for Nextel-specific processing by BKW 2/21/05,
//most of this script -- including comments -- was copied from n_cst_bso_communication_manager 
//(sending messages to the Clipboard.)

/*
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
			ll_EmployeeId		//Is ll_EquipmentId for most packages -- see note below.
			
//Note:	There is currently no flag on s_OutboundMessage to indicate whether il_Destination is an employee id
//or an equipment id.  All the other package processing assume it's an equipment id, and here, we'll assume it's 
//an employee id.  However, it would be better to label this explicitly or make it separate fields, so that if 
//something like Nextel took on the ability to be linked to EITHER an employee or equipment, we could handle it.
//However, adjusting this is beyond the time constraints on the current project.  
//--BKW 2/21/05
			
String	ls_TemplatePath, &
			ls_Topic, &
			ls_FreeFormText

BOOLEAN	lb_FreeForm			

any	laa_Message[], &
		laa_beo[], &
		laa_Empty[]

S_Parm						lstr_Parm
//n_cst_clipboard			lnv_ClipBoard
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
		ll_EmployeeId = lstra_Messages[ll_MessageNdx].il_destination 
		
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

//	IF UpperBound ( laa_Message ) > 0 THEN
//		lnv_ClipBoard.of_SetContents ( laa_Message )
//		li_Return = 1
//	END IF
	
END IF


//This is the section added for Nextel processing by BKW 2/21/05.  
//Everything else was copied from n_cst_bso_communication_manager (sending messages to the Clipboard.)

li_Return = 1  //It's defaulted to -1, above!

n_ds		lds_Cache

long		ll_RowCount, &
			ll_FoundRow

string	ls_FindString, &
			ls_PhoneNumber
			
String	ls_Message, &
			lsa_Addresses[]

n_cst_bso_email_manager	lnv_EmailManager
n_cst_emailmessage		lnv_EmailMsg


IF li_Return = 1 THEN

	ll_MessageCnt = UpperBound ( laa_Message )

	FOR ll_MessageNdx = 1 TO ll_MessageCnt
		
		ls_Message += String ( laa_Message [ ll_MessageNdx ] ) + "~r~n"
		
	NEXT
	
END IF


IF li_Return = 1 THEN

	ls_FindString = "employeeid = " + string ( ll_EmployeeId ) + " and type = '" + is_devicetype + "'"

	lds_Cache = THIS.of_GetDeviceCache (TRUE)
	
	IF IsValid ( lds_Cache ) THEN
		ll_RowCount = lds_Cache.RowCount()
		ll_FoundRow = lds_Cache.find(ls_FindString, 1, ll_RowCount)
	END IF

	
	IF ll_FoundRow > 0 THEN
		ls_PhoneNumber = Trim ( lds_Cache.Object.PhoneNumber [ ll_FoundRow ] )
	ELSE
		ls_PhoneNumber = ""
	END IF

	
	IF Len ( ls_PhoneNumber ) = 10 AND IsNumber ( ls_PhoneNumber ) THEN
		//We were able to establish a valid phone number.  It will be used to contact the driver.
		lsa_Addresses [ 1 ] = ls_PhoneNumber + "@messaging.nextel.com"
	ELSE
		//We were unable to establish a valid phone number.
		li_Return = -1
	END IF
	
END IF


IF li_Return = 1 AND ls_Message > "" THEN

	lnv_EmailManager = CREATE n_cst_bso_email_manager
	
	lnv_emailMsg.of_AddTargets ( lsa_Addresses )
	
	lnv_EmailMsg.of_SetSubject ( String ( laa_Message [ 1 ] ) )
	lnv_EmailMsg.of_SetBody ( ls_Message )

	IF lnv_EmailManager.of_SendMail ( lnv_EmailMsg ) <> 1 THEN
		li_Return = -1
	END IF 
	
	DESTROY lnv_EmailManager
	
END IF

		
RETURN li_Return
end function

public function integer of_displaypositionmap (n_cst_messagedata anv_msgdata, s_co_info astr_site, n_cst_trip anv_trip);//This is a VISUAL function.  It will display maps, messageboxes, etc.

String	ls_MessageHeader, &
			ls_ErrorMessage

s_Nextel_MapServiceParms	lstr_MapParms
n_cst_Setting_NextelMappingAddress	lnv_NextelMappingAddress

Integer	li_Return = 1

ls_MessageHeader = "Display Position Map"

IF li_Return = 1 THEN
	
	IF IsValid ( anv_MsgData ) THEN
		lstr_MapParms.is_IdList = Trim ( anv_MsgData.of_GetDeviceUnitId ( ) )
	ELSE
		li_Return = -1
	END IF
	
END IF


//Get the MapServicePath value.  

//Note: This would be handled during map-launch in the 2nd version of this function
//which gets called below, if not handled here.  However, for purposes of a clear one-stop
//message box, I wanted to check both the DeviceUnitId and the MapServicePath here, rather 
//than reporting one issue, having the user fix it, and then reporting the 2nd separately.

IF li_Return = 1 THEN
	
	lnv_NextelMappingAddress = CREATE n_cst_Setting_NextelMappingAddress
	lstr_MapParms.is_ServicePath = Trim ( lnv_NextelMappingAddress.of_GetValue ( ) )
	DESTROY lnv_NextelMappingAddress
	
END IF


IF lstr_MapParms.is_IdList > "" AND lstr_MapParms.is_ServicePath > "" THEN
	
	//OK
	
ELSE
	
	ls_ErrorMessage = "Cannot display the online position map due to the following issues:~n~n"
	
	IF lstr_MapParms.is_ServicePath > "" THEN
		//OK
	ELSE
		ls_ErrorMessage += "The 'Nextel Mapping Service Address' has not been set up in system settings.~n"
	END IF
	
	IF lstr_MapParms.is_IdList > "" THEN
		//OK
	ELSE
		ls_ErrorMessage += "The Device UnitId has not been specified in Mobile Communications device setup.~n"
	END IF
	
	//At present, since we can't get position data for Nextel devices, there's no fallback option available --
	//it's either the online map, or nothing.  If we can get position data in the future, we could give the
	//user the option of viewing a PCMiler map, perhaps -- although if they've got position data, they probably
	//have the MapServicePath and the UnitId anyway, so it may be a moot point.

	MessageBox ( ls_MessageHeader, ls_ErrorMessage )
	
	li_Return = -1
	
END IF


IF li_Return = 1 THEN
	
	lstr_MapParms.istr_Center = astr_Site
	This.of_DisplayPositionMap ( lstr_MapParms )
	
END IF


RETURN li_Return
end function

on n_cst_bso_communication_nextel.create
call super::create
end on

on n_cst_bso_communication_nextel.destroy
call super::destroy
end on

event constructor;call super::constructor;is_DeviceType = n_cst_constants.cs_CommunicationDevice_Nextel
end event

