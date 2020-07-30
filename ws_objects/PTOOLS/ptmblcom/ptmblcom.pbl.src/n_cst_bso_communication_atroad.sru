$PBExportHeader$n_cst_bso_communication_atroad.sru
forward
global type n_cst_bso_communication_atroad from n_cst_bso_communication_manager
end type
end forward

global type n_cst_bso_communication_atroad from n_cst_bso_communication_manager
end type
global n_cst_bso_communication_atroad n_cst_bso_communication_atroad

type prototypes
//////////////////////////////////////////////////////////////////////////////////////////
//   DECLARATIONS FOR USAGE OF @ROAD'S API INTERFACE DLLS
/////////////////////////////////////////////////////////////////////////////////////////
Function Integer Send_Veh_Locn_Request ( String rqst_URL, String vehLabel, String userName, &
	String passWord, REF String respBuff ) LIBRARY "atRoadIntf073.dll" alias for "Send_Veh_Locn_Request;Ansi"
	
Function Integer SendOutbForm ( String rqst_URL, String program, String vehLabel, &
	String msg, String turnaround, String resBuff ) LIBRARY "atRoadIntf073.dll" alias for "SendOutbForm;Ansi"

end prototypes

type variables
Private:

String	is_PassWord
String	is_UserName

s_CommDeviceMessage	istr_Message
s_AtRoad_DriverTextMessage istr_DriverText[]
s_AtRoad_DriverFormMessage istr_DriverForm[]
s_AtRoad_VehicleLocnMessage istr_VehicleMessage[]
s_AtRoad_FleetMessage istr_FleetMessage[]
s_AtRoad_OutBMsgsResp istr_OutBndMsg[]

Boolean	ib_TextMessage
Boolean	ib_FormMessage
Boolean	ib_VehicleMessage
Boolean   ib_OutBndStat


OleObject		Inv_XMLObject
String		is_respCode
String    		is_respDesc

Int		ii_LocationStatus
String		is_Duration
String		is_SpeedUOM
String		is_Direction
String		is_Speed

Int		ii_numTextMsgs
Int 		ii_numFormMsgs
Int		ii_numOutbStatMsgs
Int		ii_FleetCount

CONSTANT String	cs_VEH_LOCN = "VEHICLE_LOCATION"
CONSTANT String	cs_INBMESGS = "INBOUND_MESSAGES"
CONSTANT String	cs_RESPSTAT = "RESPONSE_STATUS"
CONSTANT String   cs_VEH_LABL = "VEHICLE_LABEL"
CONSTANT String   cs_DRVR_TEXT_MSG = "TEXT_MSSAGE"
CONSTANT String   cs_DRVR_FILL_IN = "FILL_IN"
CONSTANT String   cs_LOC_STAT = "LOCATION_STATUS"
CONSTANT String   cs_COORD_LOCN = "COORDINATE_LOCATION"
CONSTANT String   cs_MSG_TIMESTAMP = "MESSAGE_TIMESTAMP"
CONSTANT String   cs_ADDRS_LOCN = "ADDRESS_LOCATION"
CONSTANT String   cs_COORD_LOCN_LAT = "LATITUDE"
CONSTANT String   cs_COORD_LOCN_LON = "LONGITUDE"
CONSTANT String   cs_MSG_DATE = "MESSAGE_DATE"
CONSTANT String   cs_MSG_TIME = "MESSAGE_TIME"
CONSTANT String   cs_MSG_TZ = "MESSAGE_TIMEZONE"
CONSTANT String   cs_LOCN_DATE = "LOCATION_DATE"
CONSTANT String   cs_LOCN_TIME = "LOCATION_TIME"
CONSTANT String   cs_LOCN_TZ = "LOCATION_TIMEZONE"
CONSTANT String   cs_ADDRS_BLDG = "BUILDING_NUMBER"
CONSTANT String   cs_ADDRS_STRT = "STREET"
CONSTANT String   cs_ADDRS_CITY = "CITY"
CONSTANT String   cs_ADDRS_STATE = "STATE"
CONSTANT String   cs_ADDRS_ZIP = "ZIP"
CONSTANT String   cs_ADDRS_XSTREET = "CROSS_STREET"
CONSTANT String   cs_ADDRS_CTY = "COUNTY"
CONSTANT String   cs_ADDRS_CTRY = "COUNTRY"
CONSTANT String   cs_CUST_LMK = "CUSTOMER_LANDMARK"
CONSTANT String   cs_LOCN_TIMESTAMP = "LOCATION_TIMESTAMP"
CONSTANT String   cs_DRVR_TEXT_MESG = "DRIVER_TEXT_MESSAGE"
CONSTANT String   cs_DRVR_FORM_MESG = "DRIVER_FORM_MESSAGE"
CONSTANT String   cs_FORM_INFO = "FORM_INFORMATION"
CONSTANT String   cs_DRVR_FORM_NAME = "FORM_NAME"
CONSTANT String   cs_FORM_FLD1 = "FORM_FIELD1"
CONSTANT String   cs_FORM_FLD2 = "FORM_FIELD2"
CONSTANT String   cs_FORM_FLD3 = "FORM_FIELD3"
CONSTANT String   cs_FORM_FLD4 = "FORM_FIELD4"
CONSTANT String   cs_FORM_FLD5 = "FORM_FIELD5"
CONSTANT String   cs_FORM_FLD6 = "FORM_FIELD6"
CONSTANT String   cs_FORM_FLD7 = "FORM_FIELD7"
CONSTANT String   cs_FORM_FLD8 = "FORM_FIELD8"
CONSTANT String   cs_FORM_FLD9 = "FORM_FIELD9"
CONSTANT String   cs_FORM_FLD10 = "FORM_FIELD10"
CONSTANT String   cs_INB_MESGS = "INBOUND_MESSAGES"
CONSTANT String   cs_FLEET_LOCN = "FLEET_LOCATIONS"
CONSTANT String   cs_LOCN_REC = "LOCATION_RECORD"
CONSTANT String   cs_LOCN_PARKED = "PARKED"
CONSTANT String   cs_LOCN_MOVING = "MOVING"
CONSTANT String   cs_LOCN_ADRS = "ADDRESS"
CONSTANT String   cs_LOCN_XSTRT = "CROSS_STREET"
CONSTANT String   cs_LOCN_CITY = "CITY"
CONSTANT String   cs_LOCN_STATE = "STATE"
CONSTANT String   cs_LOCN_ZIPC = "ZIP"
CONSTANT String   cs_LOCN_COUNTY = "COUNTY"
CONSTANT String   cs_LOCN_CTRY = "COUNTRY"
CONSTANT String   cs_LOCN_LNDMK = "LANDMARK"
CONSTANT String   cs_OutBound_Stats= "OUTBOUND_MESSAGE"
CONSTANT String   cs_SEND_OPER = "SEND_STATUS"
CONSTANT String   cs_ORIG_MSG = "ORIG_OUTBOUND_MESSAGE"
CONSTANT String   cs_SEND_STATUS = "SEND_MESSAGES_STATUS"
CONSTANT String   cs_OUTB_STAT_MESG = "OUTBOUND_MESSAGE_ACKNOWLEDGEMENT"

CONSTANT String	cs_HANDHELD = "HANDHELD"
CONSTANT String	cs_ONBOARD = "ONBOARD"

end variables

forward prototypes
public function integer of_parseresponse (string as_responsebuffer)
public function integer of_connecttoobject (ref oleobject anv_xmlobject)
private function integer of_clearinboundmsgdata ()
private function integer of_parsenodes (oleobject anv_xmlresp)
private function integer of_parsedrivernode (ref oleobject anv_drivernode)
private function integer of_parsevehlabel (oleobject anv_node)
private function integer of_parsetextmessage (oleobject anv_node)
private function integer of_parsefillin (oleobject anv_node)
private function integer of_parselocationstats (oleobject anv_node)
private function integer of_parsecoords (oleobject anv_node)
private function integer of_parsetimestamp (oleobject anv_node)
private function integer of_parseresponsestatus (oleobject anv_node)
private function integer of_parsevehiclenodes (oleobject anv_nodes)
private function integer of_parseaddress (oleobject anv_node)
private function boolean of_isresponsestatusgood ()
private function integer of_parseforminfo (oleobject anv_node)
private function integer of_parsestoppedlocns (oleobject anv_node)
private function integer of_parsemovinglocns (oleobject anv_node)
private function integer of_parseinboundmsg (oleobject anv_node)
private function integer of_parsefleet (oleobject anv_node)
private function integer of_parsefleetrecords (oleobject anv_node)
public function integer of_sendoutbound (n_cst_msg anv_message)
private function integer of_parseoutboundstats (oleobject anv_node)
private function integer of_parsesendstatus (oleobject anv_node)
private function integer of_parseorigmsg (oleobject anv_node)
private function integer of_parsesendmsgstatresp (oleobject anv_node)
public function string of_getinboundformpath (string as_formname)
public function integer of_getinbound (ref datastore ads_message)
private function integer of_processinboundmessages (ref datastore ads_inboundmessage)
public function integer of_getlogindata (ref n_cst_msg anv_msg)
public function integer of_executeurlrequest (string as_url, ref string as_buffer)
protected function integer of_setauthentication (string as_vehicle)
public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_MessageData anv_MsgData, boolean ab_lastrecorded)
private function integer of_processdriverform (ref n_cst_messagedata anva_msgdata[])
private function integer of_processdrivertext (ref n_cst_messagedata anva_msgdata[])
private function integer of_mapformmessage (integer ai_index, ref n_cst_messagedata anv_msgdata)
public function string of_formattext (string as_textline, string as_devicetype)
protected function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext)
public function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext, boolean ab_createdevice)
protected function integer of_executesecureposturlrequest (string as_url, string as_args, ref string as_response)
end prototypes

public function integer of_parseresponse (string as_responsebuffer);///////////////////////////////////////////////////////////////////////////////////////////
//
//							           *** TOP LEVEL ***
//
//   ParseResponse - PARSE @ROAD MESSAGE RESPONSE
//		
//		This is the top level function that Should be called to Parse and process
//		any messages from @Road.
//	   All available data will be stored in the instance structures for any processing
//		to grab the desired data.
//
///////////////////////////////////////////////////////////////////////////////////////
//writen by:	Rick Zacher
//on:				01/08/2001
//
//
///////////////////////////////////////////////////////////////////////////////////////////

Int		li_Return=1

String	ls_parsMesg
String	ls_ResponseType

Boolean	lb_Continue = TRUE
OleObject	lnv_XMLObject
OleObject  lnv_XmlRoot
	 
/////////////////////////////////////////////////////////////////////////////////////////
//   CREATE AN EMPTY XML DOCUMENT
/////////////////////////////////////////////////////////////////////////////////////////


this.of_errorlog("parserr.txt", "XML message length = " + string(len(as_responsebuffer)) + " characters.", false )
    
IF THIS.of_ConnectToObject ( lnv_XMLObject ) = 0 THEN // success	 
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOAD @ROAD'S GET INBOUND VEHICLE MESSAGES XML RESPONSE DOCUMENT AND PARSE
	//////////////////////////////////////////////////////////////////////////////////////// 
	
	If Not lnv_XMLObject.loadXML(as_responsebuffer) Then
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOG @ROAD'S XML RESPONSE DOCUMENT ERRORS!!!  (NOT SUPPOSED TO HAPPEN)
		///////////////////////////////////////////////////////////////////////////////////////// 
		If lnv_XMLObject.parseError.errorCode <> 0 Then
			 ls_parsMesg = "PARSE ERROR ... CODE=" + String(lnv_XMLObject.parseError.errorCode) + "~r~nREASON=" +String ( lnv_XMLObject.parseError.reason)
		Else
			 ls_parsMesg = "PARSE ERROR ... REASON=" + String (lnv_XMLObject.parseError.reason)
		End If
		
		IF Len ( ls_ParsMesg ) > 0 THEN
			//MessageBox ( "AtRoad Error" , ls_ParsMesg )
			
			is_RespCode = String(lnv_XMLObject.parseError.errorCode)
			is_RespDesc = String (lnv_XMLObject.parseError.reason)
			
			this.of_errorlog("parserr.txt", ls_ParsMesg, true )
			this.of_errorlog("parserr.txt", as_responsebuffer, false )
			
			li_Return = -1
			
		END IF
		
		lb_Continue = False

	ELSE
		this.of_errorlog("parserr.txt", "Successful transmission.", false )
	End If
	/////////////////////////////////////////////////////////////////////////////////////////
	//   PARSED @ROAD'S XML RESPONSE OK..  LOOK FOR VALID RESPONSES DOCUMENTS...
	/////////////////////////////////////////////////////////////////////////////////////////
	IF lb_Continue THEN
		 
	////////////////////////////////////////////////////////////////////////////////////////
	//   CLEAR EXISTING INBOUND MESSAGES DATA
	/////////////////////////////////////////////////////////////////////////////////////////
		THIS.of_ClearInboundMsgData ( )
	/////////////////////////////////////////////////////////////////////////////////////////
	//   PARSE THE SEND INBOUND MESSAGES RESPONSE MESSAGE
	/////////////////////////////////////////////////////////////////////////////////////////
		lnv_XmlRoot  = lnv_XMLObject.documentElement
		if THIS.of_ParseNodes ( lnv_XmlRoot ) = -1 then
			li_return = -1
		end if
	
	END IF
	
END IF

Return li_return
end function

public function integer of_connecttoobject (ref oleobject anv_xmlobject);Int	li_Return 
String	ls_Path
String	ls_ErrorMessage


IF IsValid ( Inv_XMLObject ) THEN
	anv_XMLObject = Inv_XMLObject
ELSE
	Inv_XMLObject = CREATE OleObject
	
	
	li_Return = Inv_XMLObject.ConnectToNewObject ( "MSXML.DOMDocument" )
	
	Choose Case li_Return
			
		CASE 0   // success
			anv_XMLObject = inv_XMLObject
			
		CASE -1  //Invalid Call: the argument is the Object property of a control
			ls_ErrorMessage = "Invalid Call: the argument is the Object property of a control"
		CASE -2  //Class name not found
			ls_ErrorMessage = "Class name not found"
		CASE -3  //Object could not be created
			ls_ErrorMessage = "Object could not be created"
		CASE -4  //Could not connect to object
			ls_ErrorMessage = "Could not connect to object"
		CASE -9  //Other error
			ls_ErrorMessage = "Other error"
	
	END CHOOSE
	
	IF li_Return <> 0 THEN
		if gnv_app.of_Runningscheduledtask( ) then
			//no messages
		else
			MessageBox( "Connection to MSXML.DOMDocument Object Error" , "An error code of " +  String ( li_Return ) + &
						" was returned indicating- " + ls_ErrorMessage )
		end if
	END IF
END IF

RETURN li_Return 
end function

private function integer of_clearinboundmsgdata ();is_respcode = ""
is_respdesc = ""
ii_numformmsgs = 0
ii_numoutbstatmsgs = 0
ii_numtextmsgs = 0
ii_fleetcount = 0
Return 1
end function

private function integer of_parsenodes (oleobject anv_xmlresp);///////////////////////////////////////////////////////////////////////////////////////////
//
//   PARSENODES - PARSE @ROAD MESSAGES
//		
//		This is the function that will be called AFTER the method of_ParseResponse
//		is called. All available data will be stored in the instance structures for any processing
//		to grab the desired data.
//
///////////////////////////////////////////////////////////////////////////////////////
//writen by:	Rick Zacher
//on:				01/08/2001
//
//
///////////////////////////////////////////////////////////////////////////////////////////

	
Long	ll_NodeCount
Long  i, j
String	ls_RootName
Int	li_Return = 1

OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

lnv_XmlRoot  = anv_xmlresp
ls_RootName = lnv_XmlRoot.NodeName

lnv_NodeList = lnv_XmlRoot.ChildNodes

ll_NodeCount = lnv_NodeList.Length

for j = 1 to ll_NodeCount
	lnv_CurrentChildNode = lnv_NodeList.NextNode( )
	
	If (lnv_CurrentChildNode.nodeName = cs_RESPSTAT ) Then
		of_ParseResponseStatus ( lnv_CurrentChildNode )
		exit
	END IF
next

IF THIS.of_isResponseStatusGood ( ) THEN
	
	// DETERMINE THE MESSAGE TYPE
	CHOOSE CASE ls_RootName
	
		CASE cs_VEH_LOCN 
			THIS.of_ParseVehicleNodes ( lnv_XmlRoot )
			
		CASE cs_INB_MESGS
			THIS.of_ParseInboundMsg ( lnv_XmlRoot )
			
		CASE cs_FLEET_LOCN 
			THIS.of_ParseFleet ( lnv_XmlRoot ) 
			
		CASE cs_OutBound_Stats,cs_outb_stat_mesg
			THIS.of_ParseOutBoundStats ( lnv_XmlRoot ) 
			
		CASE cs_SEND_STATUS  
			THIS.of_parseSendMsgStatResp ( lnv_XmlRoot ) 
	
	END CHOOSE
ELSE
	li_Return = -1
END IF


Return li_Return 
end function

private function integer of_parsedrivernode (ref oleobject anv_drivernode);///////////////////////////////////////////////////////////////////////////////////////////
//	 
//   PARSENODES - PARSE @ROAD INBOUND VEHICLE MESSAGES RESPONSE MESSAGE
//	
///////////////////////////////////////////////////////////////////////////////////////////
Long	ll_NodeCount
Long  i

OleObject lnv_XmlChild
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

lnv_XmlChild  = anv_DriverNode

lnv_NodeList = lnv_XmlChild.ChildNodes

ll_NodeCount = lnv_NodeList.Length

FOR i = 1 TO ll_NodeCount

	lnv_CurrentChildNode = lnv_NodeList.NextNode( )
     
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR AND Save The Vehicle Label
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_veh_labl ) Then
		THIS.of_ParseVehLabel ( lnv_CurrentChildNode )	
	END IF
	/////////////////////////////////////////////////////////////////////////////////////////
	//  LOOK FOR AND Save The Driver Text Message
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = "DRIVER_TEXT_MESSAGE"  ) OR  lnv_CurrentChildNode.nodeName = "TEXT_MESSAGE" Then
	   THIS.of_ParseTextMessage ( lnv_CurrentChildNode )
	END IF
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR Driver Fill in messages
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_DRVR_FILL_IN   ) Then
   	THIS.of_ParseFillIn ( lnv_CurrentChildNode )
	END IF
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR Location Status Fields
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_LOC_STAT    ) Then
		THIS.of_ParseLocationStats ( lnv_CurrentChildNode )
	END IF
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR Location Coorinates Field
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_COORD_LOCN     ) Then
      THIS.of_ParseCoords ( lnv_CurrentChildNode )
	END IF
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR The Message Time Stamp Field
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_MSG_TIMESTAMP      ) Then
      THIS.of_ParseTimeStamp( lnv_CurrentChildNode )
	END IF
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR The Message Time Stamp Field
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_ADDRS_LOCN       ) Then
      THIS.of_ParseAddress( lnv_CurrentChildNode )
	END IF
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR AND SAVE THE DRIVER FORM INFORMATION
	/////////////////////////////////////////////////////////////////////////////////////////
   If ( lnv_CurrentChildNode.nodeName = cs_FORM_INFO) Then
   	THIS.of_parseFormInfo ( lnv_CurrentChildNode )        
   End If
	
Next

Return 1
end function

private function integer of_parsevehlabel (oleobject anv_node);////////////////////////////////////////////////////////////////////////////////////////
//   PICK UP THE VEHICLE LABEL
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return = -1

IF IsValid ( anv_Node ) THEN
	IF ib_textmessage THEN
		istr_drivertext[ii_numtextmsgs].is_vehiclelabel = anv_Node.Text
	ELSEIF ib_formmessage THEN
		istr_driverform[ii_numformmsgs].is_vehiclelabel = anv_Node.Text
	ELSEIF ib_VehicleMessage THEN
		istr_vehiclemessage[1].is_vehiclelabel = anv_Node.Text
	ELSEIF ib_outbndstat THEN
		istr_outbndmsg[ii_numoutbstatmsgs].is_vehlabel = anv_Node.Text
	END IF
	
	li_Return = 1
END IF
    
Return li_Return   


end function

private function integer of_parsetextmessage (oleobject anv_node);/////////////////////////////////////////////////////////////////////////////////////////
//   PICK UP THE DRIVER TEXT MESSAGE
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return = -1
IF isValid ( anv_Node ) THEN
	IF ib_textmessage THEN
		istr_drivertext[ii_numtextmsgs].is_textmesg = anv_Node.Text
	END IF
	li_Return = 1
END IF

Return li_Return 
end function

private function integer of_parsefillin (oleobject anv_node);/////////////////////////////////////////////////////////////////////////////////////////
//   PICK UP THE DRIVER MESSAGE "FILL IN" DATA
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return = -1

IF isValid ( anv_node ) THEN
	li_Return = 1
	IF ib_textmessage THEN
		istr_drivertext[ii_numtextmsgs].is_fillindata = anv_Node.Text
	ELSEIF ib_formmessage THEN
		istr_driverform[ii_numformmsgs].is_fillindata = anv_Node.Text
	END IF
END IF

Return li_Return 
end function

private function integer of_parselocationstats (oleobject anv_node);////////////////////////////////////////////////////////////////////////////////////////
//   GEt location stats
//   	
//
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return 
Long	ll_NodeCount 
long	i
String	ls_Name

OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
		///////////////////////////////////////////////////////////////////////////////////////////
		//  LOOK FOR AND PARSE THE STATUS INFO
		///////////////////////////////////////////////////////////////////////////////////////////
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		ls_Name = lnv_CurrentChildNode.nodeName
		
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE "STOPPED" LOCATION TAGS
		/////////////////////////////////////////////////////////////////////////////////////////
      If (ls_Name = "LOCATION_STOPPED") Then
         THIS.of_parseStoppedLocns(lnv_CurrentChildNode)
      End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE "MOVING" LOCATION TAGS
		/////////////////////////////////////////////////////////////////////////////////////////
		If (ls_Name = "LOCATION_MOVING") Then
		  THIS.of_parseMovingLocns(lnv_CurrentChildNode)
		End If
        
    Next
END IF

Return 1

end function

private function integer of_parsecoords (oleobject anv_node);////////////////////////////////////////////////////////////////////////////////////////
//   
//   	GEt The Lat/Lon
//
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return = -1
Long	ll_NodeCount
Long  i

OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
	///////////////////////////////////////////////////////////////////////////////////////////
	//  LOOK FOR AND PARSE THE LOCATION COORDINATE TAGS
	///////////////////////////////////////////////////////////////////////////////////////////
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		If (lnv_CurrentChildNode.nodeName = cs_COORD_LOCN_LAT ) Then
			
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_locn_lat = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_locn_lat = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_locn_lat = lnv_CurrentChildNode.Text
				
			END IF
						
			
		ElseIf (lnv_CurrentChildNode.nodeName = cs_COORD_LOCN_LON) Then
			
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_locn_lon = right ( trim (lnv_CurrentChildNode.Text), len (string(lnv_CurrentChildNode.Text)) - 1 )
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_locn_lon = right ( trim (lnv_CurrentChildNode.Text), len (string(lnv_CurrentChildNode.Text)) - 1 )
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_locn_lon = right ( trim (lnv_CurrentChildNode.Text), len (string(lnv_CurrentChildNode.Text)) - 1 )
			END IF
			
		End If
	
	NEXT
END IF
Return li_Return   
end function

private function integer of_parsetimestamp (oleobject anv_node);////////////////////////////////////////////////////////////////////////////////////////
//   
//   	GEt The Time Stamp
//
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return = -1
Long	ll_NodeCount
Long  i
String	ls_Name

OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
		///////////////////////////////////////////////////////////////////////////////////////////
		//  LOOK FOR AND PARSE THE LOCATION COORDINATE TAGS
		///////////////////////////////////////////////////////////////////////////////////////////
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		ls_Name = lnv_CurrentChildNode.nodeName
		
		If (ls_Name = cs_MSG_DATE) Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_mesgdate = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_mesgdate = lnv_CurrentChildNode.Text
			ELSEIF ib_outbndstat THEN
				istr_outbndmsg[ii_numoutbstatmsgs].is_mesgdate = lnv_CurrentChildNode.Text
			END IF
		 
	  	ELSEIF (ls_Name = cs_locn_date) Then
			istr_vehiclemessage[1].is_locnDate = lnv_CurrentChildNode.Text
			
	  	ElseIf (ls_Name = cs_MSG_TIME) Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_mesgtime = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_mesgtime = lnv_CurrentChildNode.Text
			ELSEIF ib_outbndstat THEN
				istr_outbndmsg[ii_numoutbstatmsgs].is_mesgtime = lnv_CurrentChildNode.Text
			END IF
			
	 	ELSEIF (ls_Name = cs_locn_Time) Then
			istr_vehiclemessage[1].is_locntime = lnv_CurrentChildNode.Text
			
	  	ElseIf (ls_Name = cs_MSG_TZ) Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_mesgtimezone = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_mesgtimezone = lnv_CurrentChildNode.Text
			ELSEIF ib_outbndstat THEN
				istr_outbndmsg[ii_numoutbstatmsgs].is_mesgtimezone = lnv_CurrentChildNode.Text
			END IF
		  // drvrTextMsg.mesgTimeZone = xml_Child.Text
	  	ELSEIF (ls_Name = cs_locn_tz) Then
			istr_vehiclemessage[1].is_locntimezone = lnv_CurrentChildNode.Text
		END IF
	
	NEXT
END IF

Return li_Return   



end function

private function integer of_parseresponsestatus (oleobject anv_node);////////////////////////////////////////////////////////////////////////////////////////
//   
//   	GET THE RESPONSE STATUS CODE AND DESCRIPTINO
//
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return = -1
Long	ll_NodeCount
Long  i
String	ls_Name

OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
		///////////////////////////////////////////////////////////////////////////////////////////
		//  LOOK FOR AND PARSE THE STATUS TAGS
		///////////////////////////////////////////////////////////////////////////////////////////
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		ls_Name = lnv_CurrentChildNode.nodeName
		
		CHOOSE CASE ls_Name
				
			CASE "CODE"
				IF ib_vehiclemessage THEN
					istr_vehiclemessage[1].is_respcode = lnv_CurrentChildNode.Text
				END IF
				is_respcode = lnv_CurrentChildNode.Text
				
			CASE "DESCRIPTION"
				IF ib_vehiclemessage THEN
					istr_vehiclemessage[1].is_respdesc = lnv_CurrentChildNode.Text
				END IF
				is_respdesc = lnv_CurrentChildNode.Text
				
		END CHOOSE
	
	NEXT
END IF
Return li_Return   


   
end function

private function integer of_parsevehiclenodes (oleobject anv_nodes);
///////////////////////////////////////////////////////////////////////////////////////////
//	 
//   PARSEVEHICLENODES - PARSE @ROAD INBOUND VEHICLE MESSAGES RESPONSE MESSAGE
//	
///////////////////////////////////////////////////////////////////////////////////////////


	
Long	ll_NodeCount
Long  i

OleObject lnv_XmlChild
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

lnv_XmlChild  = anv_Nodes

lnv_NodeList = lnv_XmlChild.ChildNodes

ll_NodeCount = lnv_NodeList.Length

ib_VehicleMessage = TRUE
FOR i = 1 TO ll_NodeCount

	lnv_CurrentChildNode = lnv_NodeList.NextNode( )

	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR AND Save The Vehicle Label
	///////////////////////////////////////////////////////////////////////////////////////////			
	If (lnv_CurrentChildNode.nodeName = cs_veh_labl ) Then
		THIS.of_ParseVehLabel ( lnv_CurrentChildNode )	
	END IF
		
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR Location Status Fields
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_LOC_STAT ) Then
      THIS.of_ParseLocationStats ( lnv_CurrentChildNode )
	END IF
		
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR Location Coorinates Field
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_COORD_LOCN ) Then
		THIS.of_ParseCoords ( lnv_CurrentChildNode )
	END IF
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR The Message Time Stamp Field
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_LOCN_TIMESTAMP ) Then
		   THIS.of_ParseTimeStamp( lnv_CurrentChildNode )
	END IF
	///////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR The Message Time Stamp Field
	///////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_ADDRS_LOCN  ) Then
		   THIS.of_ParseAddress( lnv_CurrentChildNode )
	END IF
		
NEXT
	
ib_VehicleMessage = FALSE

Return 1
end function

private function integer of_parseaddress (oleobject anv_node);////////////////////////////////////////////////////////////////////////////////////////
//   
//   	GEt The Address Stuff
//
/////////////////////////////////////////////////////////////////////////////////////////
Int	li_Return = -1
Long	ll_NodeCount
Long  i
String	ls_Name

OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
	///////////////////////////////////////////////////////////////////////////////////////////
	//  LOOK FOR AND PARSE THE address TAGS
	///////////////////////////////////////////////////////////////////////////////////////////
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		ls_Name = lnv_CurrentChildNode.nodeName
		
		If (ls_Name = cs_ADDRS_BLDG) Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_bldgnumber = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_bldgnumber = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_bldgnumber = lnv_CurrentChildNode.Text
			END IF
						
      ElseIf (ls_Name = cs_ADDRS_STRT) Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_streetname = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_streetname = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_streetname = lnv_CurrentChildNode.Text
			END IF
				
				
      ElseIf (ls_Name = cs_ADDRS_CITY) Then            
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_cityname = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_cityname = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_cityname = lnv_CurrentChildNode.Text
			END IF
				
      ElseIf (ls_Name = cs_ADDRS_STATE) Then            
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_stateabrv = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_stateabrv = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_stateabrv = lnv_CurrentChildNode.Text
			END IF
				
      ElseIf (ls_Name = cs_ADDRS_ZIP) Then           
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_zipcode = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_zipcode = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_zipcode = lnv_CurrentChildNode.Text
			END IF
				
      ElseIf (ls_Name = cs_ADDRS_XSTREET) Then            
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_crossstrt = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_crossstrt = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_crossstrt = lnv_CurrentChildNode.Text
			END IF
				
      ElseIf (ls_Name = cs_ADDRS_CTY) Then           
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_countyname = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_countyname = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_countyname = lnv_CurrentChildNode.Text
			END IF
				
      ElseIf (ls_Name = cs_ADDRS_CTRY) Then
  			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_countryname = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_countryname = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_countryname = lnv_CurrentChildNode.Text
			END IF
				  
      ElseIf (ls_Name = cs_CUST_LMK) Then 
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_customerlmk = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_customerlmk = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_customerlmk = lnv_CurrentChildNode.Text
			END IF
				
      End If
		  
	NEXT

END IF

Return li_Return   

end function

private function boolean of_isresponsestatusgood ();Boolean lb_Return 

IF is_respcode = "1" THEN
	lb_Return = TRUE 
END IF

RETURN lb_Return 
end function

private function integer of_parseforminfo (oleobject anv_node);Int	li_Return 
Long	ll_NodeCount 
long	i
String	ls_Name


OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
	///////////////////////////////////////////////////////////////////////////////////////////
	//  LOOK FOR AND PARSE THE FORM INFO
	///////////////////////////////////////////////////////////////////////////////////////////
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		ls_Name = lnv_CurrentChildNode.nodeName
		
		If (ls_Name = cs_DRVR_FORM_NAME) Then
			istr_driverform[ii_numformmsgs].is_formName = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD1) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[1] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD2) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[2] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD3) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[3] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD4) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[4] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD5) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[5] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD6) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[6] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD7) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[7] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD8) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[8] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD9) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[9] = lnv_CurrentChildNode.Text
		ElseIf (ls_Name = cs_FORM_FLD10) Then
			istr_driverform[ii_numformmsgs].is_formfieldData[10] = lnv_CurrentChildNode.Text
		End If
	Next
	
END IF
return 1
end function

private function integer of_parsestoppedlocns (oleobject anv_node);Int	li_Return = -1
Long	ll_NodeCount 
long	i
String	ls_Name


OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
		
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		ls_Name = lnv_CurrentChildNode.nodeName
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE "STOPPED" LOCATION TAGS
		////////////////////////////////////////////////////////////////////////////////////////
      If (ls_Name = "DURATION") Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].ii_locnstatus = 1//' = STOPPED
				istr_drivertext[ii_numtextmsgs].is_stopduration = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].ii_locnstatus =  1//' = STOPPED
				istr_driverform[ii_numformmsgs].is_stopduration = lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].ii_locnstatus =  1//' = STOPPED
				istr_vehiclemessage[1].is_stopduration = lnv_CurrentChildNode.Text
			END IF
            
      End If
	Next
END IF
RETURN li_Return
end function

private function integer of_parsemovinglocns (oleobject anv_node);Int	li_Return 
Long	ll_NodeCount 
long	i
String	ls_Name


OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	IF ib_textmessage THEN
		istr_drivertext[ii_numtextmsgs].ii_locnstatus =  2
	ELSEIF ib_formmessage THEN
		istr_driverform[ii_numformmsgs].ii_locnstatus =  2
	ELSEIF ib_vehiclemessage THEN
		istr_vehiclemessage[1].ii_locnstatus =  2
	END IF		
	

	FOR i = 1 TO ll_NodeCount
		
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		ls_Name = lnv_CurrentChildNode.nodeName
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE "MOVING" LOCATION TAGS
		//////////////////////////////////////////////////////////////////////////////////////////
		If (ls_Name = "SPEED") Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_speed = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_speed =  lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_Speed =  lnv_CurrentChildNode.Text
			END IF		
            
      ElseIf (ls_Name = "SPEED_UOM") Then
			IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_speed_uom = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_speed_uom =  lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_speed_uom =  lnv_CurrentChildNode.Text
			END IF
			
      ElseIf (ls_Name = "DIRECTION") Then
         IF ib_textmessage THEN
				istr_drivertext[ii_numtextmsgs].is_direction = lnv_CurrentChildNode.Text
			ELSEIF ib_formmessage THEN
				istr_driverform[ii_numformmsgs].is_direction =  lnv_CurrentChildNode.Text
			ELSEIF ib_vehiclemessage THEN
				istr_vehiclemessage[1].is_direction =  lnv_CurrentChildNode.Text
			END IF
      End If
             
    Next
END IF
RETURN 1
end function

private function integer of_parseinboundmsg (oleobject anv_node);Long	ll_NodeCount
Long  i
Boolean	lb_Continue = TRUE
Int	li_Return = -1

OleObject lnv_XmlChild
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

lnv_XmlChild  = anv_node

lnv_NodeList = lnv_XmlChild.ChildNodes

ll_NodeCount = lnv_NodeList.Length

FOR i = 1 TO ll_NodeCount


	lnv_CurrentChildNode = lnv_NodeList.NextNode( )
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR AND PROCESS RESPONSE MESSAGE STATUS FIELDS..
	/////////////////////////////////////////////////////////////////////////////////////////
  	If (lnv_CurrentChildNode.nodeName = cs_RESPSTAT) Then
		
		THIS.of_parseResponseStatus ( lnv_CurrentChildNode )
		/////////////////////////////////////////////////////////////////////////////////////////
		//   EXIT IF RESPONSE MESSAGE STATUS IS NO GOOD
		/////////////////////////////////////////////////////////////////////////////////////////
		If (of_isResponseStatusGood() = False) Then
			lb_Continue = FALSE
		End If
	End If
	/////////////////////////////////////////////////////////////////////////////////////////
	//  LOOK FOR AVAILABLE INBOUND MESSAGES..
	/////////////////////////////////////////////////////////////////////////////////////////
	//   IS THIS A DRIVER TEXT MESSAGE??
	/////////////////////////////////////////////////////////////////////////////////////////
	IF lb_Continue THEN
		li_Return = 1
		If (lnv_CurrentChildNode.nodeName = cs_DRVR_TEXT_MESG) Then
			////////////////////////////////////////////////////////////////////////////////////////
			//   PARSE THE DRIVER TEXT MESSAGE
			/////////////////////////////////////////////////////////////////////////////////////////
			ii_numtextmsgs ++
			ib_textmessage = TRUE
			THIS.of_parseDriverNode ( lnv_CurrentChildNode) 
			ib_textmessage = FALSE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   IS THIS A DRIVER FORM MESSAGE??
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_DRVR_FORM_MESG) Then
			///////////////////////////////////////////////////////////////////////////////////////////
			//   PARSE THE DRIVER FORM MESSAGE
			/////////////////////////////////////////////////////////////////////////////////////////
			ii_numformmsgs ++
			ib_formmessage = TRUE
			THIS.of_parseDriverNode ( lnv_CurrentChildNode)
			ib_formmessage = FALSE		
		End If
	END IF

Next

RETURN li_Return
end function

private function integer of_parsefleet (oleobject anv_node);Long	ll_NodeCount
Long  i

OleObject lnv_XmlChild
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

lnv_XmlChild  = anv_node
lnv_NodeList = lnv_XmlChild.ChildNodes

ll_NodeCount = lnv_NodeList.Length

FOR i = 1 TO ll_NodeCount

	lnv_CurrentChildNode = lnv_NodeList.NextNode( )
	
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR AND PROCESS RESPONSE MESSAGE STATUS FIELDS..
	/////////////////////////////////////////////////////////////////////////////////////////
   If (lnv_CurrentChildNode.nodeName = cs_RESPSTAT) Then
      THIS.of_parseResponseStatus (lnv_CurrentChildNode ) 
   End If
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR AND PROCESS LOCATION RECORDS IN THE FLEET LOCATION RESPONSE..
	/////////////////////////////////////////////////////////////////////////////////////////
   If (lnv_CurrentChildNode.nodeName = cs_LOCN_REC) Then
      THIS.of_parseFleetRecords ( lnv_CurrentChildNode ) 
   End If
	
Next
	  
Return 1

end function

private function integer of_parsefleetrecords (oleobject anv_node);Int	li_Return = -1
Long	ll_NodeCount
Long  i

OleObject lnv_XmlRoot
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist

ii_fleetcount ++ 

IF IsValid ( anv_Node ) THEN
	
	li_Return = 1
	lnv_XmlRoot  = anv_node
	lnv_NodeList = lnv_XmlRoot.ChildNodes
	ll_NodeCount = lnv_NodeList.Length

	FOR i = 1 TO ll_NodeCount
		///////////////////////////////////////////////////////////////////////////////////////////
		//  LOOK FOR AND PARSE THE FLEET STUFF
		///////////////////////////////////////////////////////////////////////////////////////////
		lnv_CurrentChildNode = lnv_NodeList.NextNode( )
		

		//////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "LABEL" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_VEH_LABL OR lnv_CurrentChildNode.nodeName = "LABEL") Then
			istr_fleetmessage[ii_fleetcount].is_vehiclelabel = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "LAT" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_COORD_LOCN_LAT OR lnv_CurrentChildNode.nodeName = "LAT" ) Then
			istr_fleetmessage[ii_fleetcount].is_locn_Lat = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "LON" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_COORD_LOCN_LON OR lnv_CurrentChildNode.nodeName = "LON") Then
			istr_fleetmessage[ii_fleetcount].is_locn_Lon = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "TIMESTAMP" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_TIMESTAMP OR lnv_CurrentChildNode.nodeName = "TIMESTAMP") Then
			istr_fleetmessage[ii_fleetcount].is_locn_DTG = lnv_CurrentChildNode.Text
			istr_fleetmessage[ii_fleetcount].is_locn_DTG_uom = String ( lnv_CurrentChildNode.Attributes.getNamedItem("UOM").nodeValue )
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "MOVING" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_MOVING) Then
			istr_fleetmessage[ii_fleetcount].ii_locnStatus = 2
			istr_fleetmessage[ii_fleetcount].is_speed = String ( lnv_CurrentChildNode.Attributes.getNamedItem("SPEED").nodeValue )
			istr_fleetmessage[ii_fleetcount].is_speed_uom = String (  lnv_CurrentChildNode.Attributes.getNamedItem("UOM").nodeValue )
			istr_fleetmessage[ii_fleetcount].is_locn_hdg = String ( lnv_CurrentChildNode.Attributes.getNamedItem("HEADING").nodeValue ) 
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//  LOOK FOR AND PARSE THE LOCATION "PARKED" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_PARKED) Then
			istr_fleetmessage[ii_fleetcount].ii_locnStatus = 1
			istr_fleetmessage[ii_fleetcount].is_Stop_uom = String (  lnv_CurrentChildNode.Attributes.getNamedItem("UOM").nodeValue )
			istr_fleetmessage[ii_fleetcount].is_stopDuration = String ( lnv_CurrentChildNode.Attributes.getNamedItem("DURATION").nodeValue ) 
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "ADDRESS" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_ADRS) Then
			istr_fleetmessage[ii_fleetcount].is_locnAdrs = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//  LOOK FOR AND PARSE THE LOCATION "CROSS STREET" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_XSTRT) Then
			istr_fleetmessage[ii_fleetcount].is_locnXStrt = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "CITY" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_CITY) Then
			istr_fleetmessage[ii_fleetcount].is_locnCity = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "STATE" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_STATE) Then
			istr_fleetmessage[ii_fleetcount].is_locnState = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "ZIP CODE" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_ZIPC) Then
			istr_fleetmessage[ii_fleetcount].is_locnZipC = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "COUNTY" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_COUNTY) Then
			istr_fleetmessage[ii_fleetcount].is_locn_Cty = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "LANDMARK" TAG
		/////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_LNDMK) Then
			istr_fleetmessage[ii_fleetcount].is_locn_LMK = lnv_CurrentChildNode.Text
			CONTINUE
		End If
		/////////////////////////////////////////////////////////////////////////////////////////
		//   LOOK FOR AND PARSE THE LOCATION "COUNTRY" TAG
		////////////////////////////////////////////////////////////////////////////////////////
		If (lnv_CurrentChildNode.nodeName = cs_LOCN_CTRY) Then
			istr_fleetmessage[ii_fleetcount].is_locnCtry = lnv_CurrentChildNode.Text
			CONTINUE
		End If


	NEXT
		
END IF
		
RETURN 1

end function

public function integer of_sendoutbound (n_cst_msg anv_message);/*
This will return:
						-1 = ERROR  (default)
						 1 = successful completion
	
*/

Integer	li_Return = 1, &
			li_DLLRet

long		ll_MessageCnt, &
			ll_MessageNdx, &
			ll_SourceEntityId, &
			ll_ArrayCnt, &
			ll_Ndx, &
			ll_beondx, &
			ll_beocount
			
String	ls_UnitId, &
			ls_Text, &
			ls_NewText, &
			ls_TemplatePath, &
			ls_Topic, &
			ls_URL, &
			ls_SerialNumber, &
			ls_FreeFormText, &
			ls_buffer, &
			ls_User, &
			ls_PassWord, &
			ls_Init, &
			ls_msg, &
			ls_ReturnField,	&   
			ls_Format, &
			ls_Field, &
			ls_UnitType, &
			ls_Args
			
String	ls_Message
			
BOOLEAN	lb_FreeForm			
Boolean	lb_OldDevice

any	laa_Message[], &
		laa_beo[], &
		laa_CurrentBeo[], &
		laa_Empty[]

s_parm	lstr_Parm
s_outboundMessage			lstra_Messages []
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
n_cst_msg					lnv_BlankMessage
n_cst_string	lnv_String
n_cst_AnyArraySrv			lnv_ArraySrv

n_ds	lds_DeviceCache

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
		ll_SourceEntityID = lstra_Messages[ll_MessageNdx].il_destination 
		
		This.of_UnitIdLookup(ll_SourceEntityId, ls_UnitId, ls_UnitType /*EMPLOYEE/EQUIPMENT*/)
		
		IF ls_UnitType = cs_EQUIPMENT THEN
			ls_Format = cs_ONBOARD
		ELSEIF ls_UnitType =cs_EMPLOYEE THEN
			ls_Format = cs_HANDHELD
		END IF
		
		IF isnull ( ls_UnitId ) OR len ( trim ( ls_UnitId ) ) = 0 THEN
			if gnv_app.of_Runningscheduledtask( ) then
				//no messages
			else
				MessageBox ("Outbound Message", &
					"Could not find a unit id in the device table for this equipment/employee.")
			end if
			li_Return = -1
			EXIT
			
		ELSE
			
			lstr_parm.is_Label = "NUMBERTAGS"
			lstr_Parm.ia_Value = '' 
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			IF lb_FreeForm THEN
				lstr_parm.is_Label = "FREEFORMTEXT"
				lstr_Parm.ia_Value = ls_FreeFormText
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			END IF

			if lb_FreeForm then
				//force the for next loop to happen once
				ll_beocount = 1
			else
				ll_beocount = upperbound(laa_beo)
			end if
			
			if this.of_setauthentication(ls_UnitId) <> 1 then
				li_return = -1 
			else
				lb_OldDevice = LOWER(ProfileString(gnv_App.of_GetAppIniFile ( ), "ATROAD","Device","new")) = "old"
				/***!*** 
				 For new devices: We do not want a seperate reports and requests made for each beo
				 becuase we want to support single templates with multiple events
				 that get sent in one message.
				 <1.tag><2.tag>
				***!***/
				IF NOT lb_OldDevice THEN
					ll_Beocount = 1
					laa_CurrentBeo = laa_Beo
				END IF
				
				for ll_beondx = ll_beocount to 1 step -1
					
					//for the old device, use seperate report for each beo
					IF lb_OldDevice THEN
						laa_Message = laa_empty
						laa_Currentbeo = laa_empty
						ls_message = ''
						
						if lb_FreeForm then
							//no beo
						else
							laa_Currentbeo[1] = laa_beo[ll_beondx]
						end if
					END IF

					IF lnv_ReportManager.of_CreateReport ( ls_Topic, ls_TemplatePath, laa_CurrentBeo, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
						//WE MAY NOT WANT TO DO THIS WHEN WE PROCESS MULTIPLE MESSAGES 
						li_Return = -1
						EXIT
					END IF
					
					ll_ArrayCnt = upperbound ( laa_Message ) 
				
					FOR ll_Ndx = 1 to ll_ArrayCnt

						ls_Field = This.of_FormatText(laa_Message [ll_Ndx], ls_Format)
						
						ls_Message  += string (ls_Field)
					NEXT
					
					ls_buffer = space(32767)
						
					ls_message = lnv_String.of_PrepareforURL ( ls_message )	
					
					ls_URL = "https://www.road.com/apps/SendOutbMessage"
					ls_Args = "Vehicle_Label=" + ls_UnitId + "&Message_Text=" + ls_message
					//Revised: 6/02/06 MFS
					//Update: This.of_ExecuteUrlRequest(..) replaced with This.of_ExecuteSecurePostUrlRequest(...)
					//Reason: of_ExecuteUrlRequest uses GetUrl() which does not suport 'url encoded' line feeds (%0A)
					li_Return = This.of_ExecuteSecurePostUrlRequest(ls_url, ls_Args, ls_buffer)
				next
				
			end if
			
		END IF 
			
	NEXT
	
END IF 

RETURN li_Return 
end function

private function integer of_parseoutboundstats (oleobject anv_node);/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
//
//   PARSENODES - PARSE @ROAD OUTBOUND MESSAGE STATUS TAGS
//
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

Long	ll_NodeCount
Long  i

OleObject lnv_XmlChild
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist


lnv_XmlChild  = anv_node

lnv_NodeList = lnv_XmlChild.ChildNodes

ll_NodeCount = lnv_NodeList.Length

ii_numoutbstatmsgs ++
ib_outbndstat = TRUE
FOR i = 1 TO ll_NodeCount

  
	lnv_CurrentChildNode = lnv_NodeList.NextNode( )

	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR THE VEHICLE LABEL FIELD..
	/////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_VEH_LABL) Then
		THIS.of_parseVehLabel ( lnv_CurrentChildNode )
	End If
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR THE SEND MESSAGE STATUS FIELD..
	/////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_SEND_OPER) Then
		THIS.of_parseSendStatus ( lnv_CurrentChildNode )
	End If
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR THE MESSAGE TIMESTAMP FIELD..
	//////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_MSG_TIMESTAMP) Then
		THIS.of_parseTimeStamp ( lnv_CurrentChildNode )
	End If
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR THE ORIGINAL MESSAGE SENT FIELD..
	/////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_ORIG_MSG) Then
		THIS.of_parseOrigMsg ( lnv_CurrentChildNode )
	End If

Next

ib_outbndstat = FALSE
RETURN 1
end function

private function integer of_parsesendstatus (oleobject anv_node);/////////////////////////////////////////////////////////////////////////////////////////
//   PICK UP THE SEND MESSAGE STATUS
/////////////////////////////////////////////////////////////////////////////////////////
IF isValid ( anv_node ) THEN
	istr_outbndmsg[ii_numoutbstatmsgs].is_sendStat = anv_node.Text
END IF

RETURN 1
end function

private function integer of_parseorigmsg (oleobject anv_node);/////////////////////////////////////////////////////////////////////////////////////////
//   PICK UP THE ORIGINAL MESSAGE
/////////////////////////////////////////////////////////////////////////////////////////

IF isValid ( anv_Node ) THEN    
	istr_outbndmsg[ii_numoutbstatmsgs].is_origMesg = anv_Node.Text
END IF

RETURN 1
end function

private function integer of_parsesendmsgstatresp (oleobject anv_node);Long	ll_NodeCount
Long  i

OleObject lnv_XmlChild
OleObject lnv_CurrentChildNode
Oleobject lnv_Nodelist


lnv_XmlChild  = anv_node

lnv_NodeList = lnv_XmlChild.ChildNodes

ll_NodeCount = lnv_NodeList.Length


FOR i = 1 TO ll_NodeCount

	lnv_CurrentChildNode = lnv_NodeList.NextNode( )
	/////////////////////////////////////////////////////////////////////////////////////////
	//   LOOK FOR AND PROCESS RESPONSE MESSAGE STATUS FIELDS..
	/////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_RESPSTAT) Then
		THIS.of_parseResponseStatus ( lnv_CurrentChildNode )
		/////////////////////////////////////////////////////////////////////////////////////////
		//   EXIT IF RESPONSE MESSAGE STATUS IS NO GOOD
		//////////////////////////////////////////////////////////////////////////////////////////
//		If (isRespStatusGood() = False) Then
//			 parseSendMsgStatResp = True
//			 Exit Function
//		End If
	End If
	//////////////////////////////////////////////////////////////////////////////////////////
	//   IS THIS AN OUTBOUND MESSAGE STATUS??
	/////////////////////////////////////////////////////////////////////////////////////////
	If (lnv_CurrentChildNode.nodeName = cs_OUTB_STAT_MESG) Then
		/////////////////////////////////////////////////////////////////////////////////////////
		//   PARSE THE OUTBOUND MESSAGE STATUS MESSAGE
		/////////////////////////////////////////////////////////////////////////////////////////
		THIS.of_parseNodes ( lnv_CurrentChildNode )
	//	il_numSendMsgsStat ++
	End If

Next

RETURN 1
end function

public function string of_getinboundformpath (string as_formname);String	ls_Path

of_getinboundPath ( ls_Path )

IF Len ( Trim (ls_Path) ) > 0 THEN
	IF Right ( Trim ( ls_Path ) , 1 ) <> "\" THEN
		ls_path += "\"
	END IF
	
	IF Pos ( Upper (as_formname) , "ARRIVE" ) > 0 THEN
		ls_Path += "arrive.doc"
	ELSEIF Pos ( Upper (as_formname) , "DEPART" ) > 0 THEN
		ls_Path += "depart.doc"
	ELSEIF Pos ( Upper (as_formname) , "DIRECT" ) > 0 THEN
		ls_Path += "direct.doc"
	ELSEIF Pos ( Upper (as_formname) , "COMMENT" ) > 0 THEN
		ls_Path += "comment.doc"
	ELSE
		ls_Path += as_formname + ".doc"
	END IF
	
END IF


RETURN ls_Path 
end function

public function integer of_getinbound (ref datastore ads_message);String	ls_Buffer
String	ls_Vehicle='0'
String	ls_User
String	ls_PassWord, &
			ls_url, &
			ls_null, &
			ls_errormessage

Int		li_Return = 1

Int		li_DLLRet

ls_buffer = space(32767)
		
n_cst_Msg	lnv_msg
S_Parm	lstr_parm
n_cst_OFRError	lnv_Error

setnull(ls_null)

//following call to dll for authentication
if this.of_setauthentication(ls_null) <> 1 then
	li_return = -1 
else
	ls_buffer = space(32767)
	ls_URL = "https://www.road.com/apps/GetInboundMessages?"
	li_Return = this.of_executeurlrequest(ls_url, ls_buffer)
	if li_return = 1 then
		if THIS.of_ParseResponse ( ls_Buffer )	 = 1 then
			THIS.of_ProcessinboundMessages (ads_message)
		else
			li_return = -1
			ls_errormessage = "Status Code: " + is_respCode  + "~r~nDescription: " + is_respDesc + ". "
			lnv_Error = This.AddOFRError ( )
			if IsValid ( lnv_Error ) then
				lnv_Error.SetErrorMessage ( ls_ErrorMessage )
			end if			
		end if
	else
		if gnv_app.of_Runningscheduledtask( ) then
			//no messages
		else
			messagebox("Internet Error",ls_buffer)
		end if 
	end if
end if
RETURN li_Return

end function

private function integer of_processinboundmessages (ref datastore ads_inboundmessage);
//s_CommDeviceMessage	lstra_Message[]
n_cst_messageData	lnva_MsgData [ ]


IF UpperBound ( istr_driverform ) > 0 THEN
	THIS.of_ProcessDriverForm ( lnva_MsgData )
END IF

IF UpperBound ( istr_drivertext ) > 0 THEN
	THIS.of_ProcessDriverText ( lnva_MsgData )
END IF

THIS.of_ProcessInboundMessages ( lnva_MsgData , ads_InboundMessage )

Int 	i
Int	li_Count

li_Count = UpperBound ( lnva_MsgData )
FOR  i = 1 TO li_Count
	Destroy ( lnva_MsgData[i] )
NEXT

RETURN 1
end function

public function integer of_getlogindata (ref n_cst_msg anv_msg);Integer 	li_Return
Int		i
any	laa_Empty[]
any 	laa_Message[]
String	ls_FilePath
String	ls_UserName
String	ls_PassWord
String	ls_Working
String	lsa_Result[]


s_Parm		lstr_Parm
n_cst_Msg	lnv_TagMessage
n_cst_bso_reportManager	lnv_ReportManager
n_cst_String	lnv_String

li_Return = 1

String	ls_Path
n_cst_setting_templatespathfolder	lnv_PathSetting
lnv_PathSetting = CREATE n_cst_setting_templatespathfolder
ls_Path = lnv_PathSetting.of_Getvalue( )
DESTROY ( lnv_PathSetting ) 

IF len ( ls_Path ) = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ls_FilePath = ls_Path + "MESSAGE\" + n_cst_Constants.cs_CommunicationDevice_AtRoad+"\Login.doc"
END IF

IF FileExists ( ls_FilePath ) THEN
	
	lstr_parm.is_Label = "NUMBERTAGS"
	lstr_Parm.ia_Value = '' 
	lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
	IF lnv_ReportManager.of_CreateReport ( "", ls_FilePath, laa_Empty, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
		li_Return = -1
	END IF
	FOR i =1 TO Upperbound ( laa_Message ) 
		ls_working = String	( laa_Message[i]) 
		
		IF Len ( TRIM ( ls_Working ) ) > 0 THEN
			lnv_String.of_ParseToArray ( ls_Working , "=" , lsa_Result )
			IF UpperBound ( lsa_Result ) = 2 THEN
				IF Pos ( Upper (Trim ( lsa_Result[1])) , "PASS" ) > 0 THEN
					ls_Password = lsa_Result[2]
				ELSEIF Pos ( Upper (Trim ( lsa_Result[1])) , "USER" ) > 0 THEN
					ls_UserName = lsa_Result[2]
				END IF
			END IF
		END IF
	NEXT
	
END IF

IF Len ( ls_PassWord ) > 0 AND Len ( ls_Username ) > 0 THEN
	lstr_Parm.is_Label = "PASSWORD" 
	lstr_Parm.ia_Value = ls_Password 
	anv_msg.of_Add_Parm ( lstr_Parm )
	
	lstr_Parm.is_Label = "USERNAME" 
	lstr_Parm.ia_Value = ls_UserName 
	anv_msg.of_Add_Parm ( lstr_Parm )
ELSE
	li_Return = -1
END IF

	
return li_return
end function

public function integer of_executeurlrequest (string as_url, ref string as_buffer);Int	li_Return = 1, &
		li_Internet	

Inet							linet_Communication
n_ir_Communication		lir_Communication
	
IF GetContextService("Internet", linet_Communication) = 1 THEN

	lir_Communication = CREATE n_ir_Communication
	
	li_Internet = linet_Communication.GetURL (as_URL, lir_Communication)
	
	

	CHOOSE CASE li_Internet  
	
		CASE 1  	//	Success
			
			as_buffer = String ( lir_Communication.iblb_Data )
			
			if pos(as_buffer,'Authorization Required') > 0 then
				
				as_buffer = "Not logged into AtRoad"
				li_return = -1
				
			end if
			
		CASE -1  //	General error
			li_Return = -1 
			as_buffer = "Return Code = " + string ( li_Internet ) + " Error: General Error"
			
		CASE -2  //	Invalid URL
			li_Return = -1
			as_buffer = "Return Code = " + string ( li_Internet ) + " Error: Invalid URL"
			
		CASE -4  //	Cannot connect to the Internet
			li_Return = -1
			as_buffer = "Return Code = " + string ( li_Internet ) + " Error: Cannot connect to the Internet"
						
	END CHOOSE
					
end if

IF isvalid ( lir_Communication ) THEN
	DESTROY lir_Communication
END IF

return li_return
end function

protected function integer of_setauthentication (string as_vehicle);integer	li_return = 1
long		ll_rowcount, &
			ll_index
string	ls_equipref, &
			ls_buffer, &
			ls_url="https://www.road.com/apps/GetVehicleLocation"
boolean	lb_found

n_ds		lds_commequip

ls_buffer = space(32767)

if isnull(as_vehicle) or len(trim(as_vehicle)) = 0 then
	//get first one in list
	lds_commequip = this.of_getcommequipcache(true)
	
	if isvalid(lds_commequip) then
		ll_rowcount = lds_commequip.rowcount()
	end if 
	
	for ll_index = 1 to ll_rowcount
		ls_equipref = lds_commequip.object.equipment_eq_ref[ll_index]
		if len(trim(ls_equipref)) > 0 then
			if lds_commequip.object.type[ll_index] = n_cst_constants.cs_CommunicationDevice_AtRoad then
				lb_found = true
				exit
			end if
		end if
	next
else
	ls_equipref = as_vehicle
	lb_found=true
end if

if lb_found then 
	if Send_Veh_Locn_Request (ls_url, ls_equipref, is_UserName, is_PassWord, ls_buffer ) < 0 then
		li_return = 1
	end if
else
	li_return = -1
end if

return li_return
end function

public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_MessageData anv_MsgData, boolean ab_lastrecorded);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Locatetruck
//
//	Access:  public
//
//	Arguments:  
//					al_equipmentId
//					al_equipmentref
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
// 		Date: 01/02/01
//		Version: 3.0.5
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	      April 3 2002 changed argument to n_cst_MessageData
//	
//////////////////////////////////////////////////////////////////////////////

//

// Send URL

/*	
	loc_onetruck service
*/

Integer	li_Return, &
			li_DLLRet

Long		ll_MessageCnt, &
			ll_ArrayCnt, &
			ll_Ndx
			
String	ls_URL, &
			ls_Data, &
			ls_Vehicle, &
			ls_User, &
			ls_PassWord, &
			ls_Buffer, &
			lsa_Location [], &
			ls_Delimiter, &
			ls_TemplatePath, &
			ls_OdlPath
			
				
Boolean	lb_Success			

any		laa_Data [], &
			laa_Beo[], &
			laa_message []

s_parm						lstr_Parm
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
Inet							linet_Communication
n_ir_Communication		lir_Communication
s_CommDeviceMessage		lstra_CommDeviceMessage[]
n_cst_string				lnv_String
li_Return = 1

IF ab_LastRecorded THEN
	
	IF this.of_GetLastRecordedPosition ( al_equipmentid, anv_MsgData ) < 0 THEN
		li_Return = -1
	END IF

ELSE
	ll_ArrayCnt = upperbound ( laa_Message ) 

	FOR ll_Ndx = 1 to ll_ArrayCnt
		ls_URL = ls_URL + string (laa_Message [ll_Ndx])
	NEXT
	
	ls_buffer = space(32767)
		
//	li_DLLRet = InitIntf("INITIALIZE INTERFACE...", 0, 0)
		
	ls_URL= "https://www.road.com/apps/GetVehicleLocation"
	ls_Vehicle =as_equipmentref
	ls_User = is_UserName
	ls_PassWord = is_password
	
	li_DLLRet = Send_Veh_Locn_Request ( ls_URL, ls_Vehicle, ls_User, ls_PassWord, ls_buffer ) 
	
	THIS.of_ParseResponse ( ls_Buffer )
	
	IF UpperBound ( istr_vehiclemessage ) > 0 THEN
		anv_MsgData.of_SetLastPositionLat ( istr_vehiclemessage[1].is_Locn_lat )
		anv_MsgData.of_SetLastPositionLong ( istr_vehiclemessage[1].is_Locn_Lon )
	END IF
		
END IF

return li_Return
end function

private function integer of_processdriverform (ref n_cst_messagedata anva_msgdata[]);Int 	i
Int	li_Count
Int	li_Current

Long		ll_SourceEntityId

String	ls_Name
String	ls_Location
String 	ls_Number
String	ls_Street
String	ls_City
String 	ls_County
String	ls_Country
String	ls_LandMark
String	ls_Zip
String	ls_State
String	ls_CrossStreet	
String   ls_type
String	ls_Ref


li_Current = ( UpperBound ( anva_MsgData[] ) + 1 )
li_Count = UpperBound ( istr_driverform ) 

FOR i = 1 TO li_Count
	anva_MsgData[li_Current] = CREATE n_cst_MessageData
//	IF NOT isValid (anva_MsgData[li_Current] ) THEN
//		anva_MsgData[li_Current] = CREATE n_cst_MessageData
//	END IF
	
	// this will take care of the event and shipment id
	THIS.of_MapFormMessage ( i , anva_MsgData[li_Current] )
	
	anva_MsgData[li_Current].of_SetLastPositionLat ( istr_driverform[i].is_locn_Lat )
	anva_MsgData[li_Current].of_SetLastPositionLong ( istr_driverform[i].is_locn_Lon )
	
	This.of_SourceEntityIdLookup(istr_driverform[i].is_VehicleLabel, ll_SourceEntityId, ls_Type)
	anva_MsgData[li_Current].of_SetSourceEntityId ( ll_SourceEntityId )
	anva_MsgData[li_Current].of_SetSourceEntityType( ls_Type )
	
	IF ls_Type = cs_Equipment THEN
		Select "equipment"."eq_ref"
		Into	:ls_Ref
		From	"equipment"
		Where "equipment"."eq_id" = :ll_SourceEntityId;
		commit;
	ELSEIF ls_Type = cs_Employee THEN
		Select "employees"."em_ref"
		Into	:ls_Ref
		From	"employees"
		Where "employees"."em_id" = :ll_SourceEntityId;
		commit;
	END IF
	
	anva_MsgData[li_Current].of_SetEquipmentRef( ls_Ref )
	
	anva_MsgData[li_Current].of_SetLastPositionDate ( DATE (istr_driverform[i].is_mesgDate ) )
	anva_MsgData[li_Current].of_SetlastPositionTime ( Time (istr_driverform[i].is_MesgTime ) )
	
	ls_Number = istr_driverform[i].is_BldgNumber
	ls_Street = istr_driverform[i].is_StreetName
	ls_City = istr_driverform[i].is_CityName
	ls_State = istr_driverform[i].is_Stateabrv
	ls_Zip = istr_driverform[i].is_ZipCode
	
	ls_Location = ls_Number + " " + ls_Street + " " + ls_City + " " + ls_State + " " + ls_Zip

	anva_MsgData[li_Current].of_SetlastPositionLocation ( ls_Location )
	
	IF Pos ( UPPER ( istr_driverform[i].is_FormName) , "ARRIVE" ) > 0 THEN 
		anva_MsgData[li_Current].of_SetMessageType ( "ARRIVE" )
	ELSEIF Pos ( UPPER ( istr_driverform[i].is_FormName) , "DEPART" ) > 0 THEN 
		anva_MsgData[li_Current].of_SetMessageType ( "DEPART" )
	ELSEIF Pos ( UPPER ( istr_driverform[i].is_FormName) , "DIRECT" ) > 0 THEN 
		anva_MsgData[li_Current].of_SetMessageType ( "DIRECTIONS" )
		anva_MsgData[li_Current].of_SetOutBoundTemplate ( "DIRECTNS.doc" )
	ELSEIF Pos ( UPPER ( istr_driverform[i].is_FormName) , "DUTY" ) > 0 THEN 
		anva_MsgData[li_Current].of_SetMessageType ( "DUTYSTATUS" )
	ELSE 
		anva_MsgData[li_Current].of_SetMessageType ( "" )
	END IF
	
	li_Current ++
	
NEXT

RETURN 1
end function

private function integer of_processdrivertext (ref n_cst_messagedata anva_msgdata[]);Int 	i
Int	li_Count
Int	li_Current

Long		ll_SourceEntityId

String	ls_Name
String	ls_Location
String 	ls_Number
String	ls_Street
String	ls_City
String 	ls_County
String	ls_Country
String	ls_LandMark
String	ls_Zip
String	ls_State
String	ls_CrossStreet	
String	ls_type
String	ls_Ref

li_Current = ( UpperBound ( anva_MsgData[] ) + 1 )
li_Count = UpperBound ( istr_drivertext ) 

FOR i = 1 TO li_Count
	anva_MsgData[li_Current] = CREATE n_cst_MessageData
//	IF NOT isValid (anva_MsgData[li_Current] ) THEN
//		anva_MsgData[li_Current] = CREATE n_cst_MessageData
//	END IF
	
	
	anva_MsgData[li_Current].of_SetLastPositionLat ( istr_drivertext[i].is_locn_Lat )
	anva_MsgData[li_Current].of_SetLastPositionLong ( istr_drivertext[i].is_locn_Lon )
	
	This.of_SourceEntityIdLookup(istr_drivertext[i].is_VehicleLabel, ll_SourceEntityId, ls_Type)
	anva_MsgData[li_Current].of_SetSourceEntityId ( ll_SourceEntityId )
	
	IF ls_Type = cs_Equipment THEN
		Select "equipment"."eq_ref"
		Into	:ls_Ref
		From	"equipment"
		Where "equipment"."eq_id" = :ll_SourceEntityId;
	ELSEIF ls_Type = cs_Employee THEN
		Select "employees"."em_ref"
		Into	:ls_Ref
		From	"employees"
		Where "employees"."em_id" = :ll_SourceEntityId;
	END IF
	
	anva_MsgData[li_Current].of_SetEquipmentRef( ls_Ref )
	
	anva_MsgData[li_Current].of_SetLastPositionDate ( DATE (istr_drivertext[i].is_mesgDate ) )
	anva_MsgData[li_Current].of_SetlastPositionTime ( Time (istr_drivertext[i].is_MesgTime ) )
	
	ls_Number = istr_drivertext[i].is_BldgNumber
	ls_Street = istr_drivertext[i].is_StreetName
	ls_City = istr_drivertext[i].is_CityName
	ls_State = istr_drivertext[i].is_Stateabrv
	ls_Zip = istr_drivertext[i].is_ZipCode
	
	ls_Location = ls_Number + " " + ls_Street + " " + ls_City + " " + ls_State + " " + ls_Zip

	anva_MsgData[li_Current].of_SetlastPositionLocation ( ls_Location )
	
	anva_MsgData[li_Current].of_SetMessageText ( istr_drivertext[i].is_FillinData )

	li_Current ++
	
NEXT

RETURN 1

end function

private function integer of_mapformmessage (integer ai_index, ref n_cst_messagedata anv_msgdata);String	ls_Topic 
String	ls_TemplatePath
String	lsa_Result[]
String	ls_Working
String	lsa_Empty[]
String	ls_Tag
Int		li_Return = 1
Int		i
Int		li_Index
Int		li_FormIndex 

Any		laa_Empty[]  
Any 		laa_Message[]

Long	ll_EmpId
n_cst_employeemanager	lnv_EmployeeManager

S_Parm	lstr_Parm
n_cst_msg					lnv_TagMessage
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_String	lnv_String
//s_CommDeviceMessage lstr_CommMessage

ls_Topic = ""
li_FormIndex = ai_index  // change for looping 

IF Not ISValid ( anv_msgdata ) THEN
	anv_msgdata = CREATE n_cst_messageData 
END IF

//lstr_parm.is_Label = "NUMBERTAGS"
//lstr_Parm.ia_Value = '' 
//lnv_TagMessage.of_Add_Parm ( lstr_Parm )
IF li_FormIndex <= UpperBound ( istr_driverform ) THEN

	ls_TemplatePath = THIS.of_getInboundFormPath ( istr_driverform[li_FormIndex].is_FormName )
		
	IF fileexists ( ls_TemplatePath) THEN
		IF lnv_ReportManager.of_CreateReport ( ls_Topic, ls_TemplatePath, laa_Empty, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
			li_Return = -1
		END IF
	else
		li_Return = -1
	end if
	
	IF li_Return = 1 THEN
	
		For i = 1 TO UpperBound ( laa_Message ) 
			lsa_Result = lsa_Empty
			li_Index = 0
			ls_Tag = ""
			
			ls_Working = laa_Message[i]
			IF Len ( Trim (ls_Working) ) > 0 THEN
				lnv_String.of_ParseToArray ( ls_Working , "=" , lsa_Result )
				
				IF UpperBound ( lsa_Result ) = 2 THEN
					IF isNumber ( lsa_Result[1] ) THEN
						li_Index = Long ( lsa_Result[1] )
					ELSE
						CONTINUE
					END IF
					
					ls_Tag = UPPER ( lsa_Result[2] )
			
				ELSE 
					CONTINUE
				END IF
				
				IF li_FormIndex <= UpperBound ( istr_driverform ) THEN
					IF li_Index > 0 and li_Index <= UpperBound( istr_driverform[li_FormIndex].is_formfielddata[]) & 
						AND Len ( Trim ( ls_Tag ) ) > 0  THEN
						
						CHOOSE CASE Upper ( Trim ( ls_Tag ) )
								
							CASE "TMP" , "TEMP" , "TEMP#" , "TMP#"
								anv_MsgData.of_SetShipmentID ( LONG (istr_driverform[li_FormIndex].is_formfielddata[li_Index]) )
							CASE "EVENT.ID"
								anv_MsgData.of_SetEventID ( LONG (istr_driverform[li_FormIndex].is_formfielddata[li_Index]) )
							CASE "TEXT"
//								lstr_CommMessage.is_Text = istr_driverform[li_FormIndex].is_formfielddata[li_Index]								
							CASE "EVENT.NOTES"
								anv_MsgData.of_SetEventNotes ( istr_driverform[li_FormIndex].is_formfielddata[li_Index]	)
							CASE "EVENT.CONTAINER"
								anv_MsgData.of_Setcontainer ( istr_driverform[li_FormIndex].is_formfielddata[li_Index] )
							CASE "EVENT.CHASIS"
								anv_MsgData.of_SetChassis ( istr_driverform[li_FormIndex].is_formfielddata[li_Index] )
							CASE "DRIVER.ID"
								anv_msgdata.of_SetDriverID ( istr_driverform[li_FormIndex].is_formfielddata[li_Index] )
							CASE "DRIVER.QUICKREF"
								
								IF lnv_EmployeeManager.of_getemployeebycode( istr_driverform[li_FormIndex].is_formfielddata[li_Index], ll_EmpId ) = 1 THEN
									anv_msgdata.of_SetDriverID ( String ( ll_EmpId ) )
								END IF
								
								
								
							CASE "DRIVER.DUTYSTATUS"
								IF anv_msgdata.of_SetDriverDutyStatus ( istr_driverform[li_FormIndex].is_formfielddata[li_Index] ) <> 1 THEN
									li_Return = -1
								END IF
						END CHOOSE
						anv_MsgData.of_AppendToMessageText ( ' ' + ls_Tag + ' ' + istr_driverform[li_FormIndex].is_formfielddata[li_Index] )
						// Tags will need to have [ ] around them to be successfully processed by the 
						// special field processing. i.e [SHIPMENT.SEAL]
						anv_Msgdata.of_SetSpecialField ( ls_Tag,istr_driverform[li_FormIndex].is_formfielddata[li_Index]  )
					END IF
				END IF
			END IF
			
		NEXT
		
	END IF
ELSE
	li_Return = -1
END IF

//IF li_Return = 1 THEN
//	astr_message = lstr_CommMessage
//END IF
//
Return li_Return
end function

public function string of_formattext (string as_textline, string as_devicetype);Long		i, ll_Pos
Long		ll_NumLines
Long		ll_Len
String	ls_Result
String	ls_Text
String	ls_Line
String	ls_Lines[] //each element will have 40 chars of text

Constant Integer	ci_PADLENGTH = 40

n_cst_String	lnv_String

IF as_DeviceType = cs_ONBOARD THEN
	
	ls_Text = as_TextLine
	//Parse text into array element padded to 40 characters
	ll_Len = Len(ls_Text)
	DO WHILE ll_Len > ci_PADLENGTH

		ll_Pos = LastPos(ls_Text, " ", ci_PADLENGTH)
		IF ll_Pos = 0 THEN 
			ll_Pos = ci_PADLENGTH
		END IF
		ls_Line = Left(ls_Text, ll_Pos)
		ls_Line = lnv_String.of_PadRight(ls_Line, ci_PADLENGTH)	
		ls_Lines[Upperbound(ls_Lines) + 1] = ls_Line
		
		ls_Text = Right(ls_Text, ll_Len - ll_Pos)
		ll_Len = Len(ls_Text)
	LOOP
	
	//Add remaining line to array
	IF Len(ls_Text) > 0 THEN
		ls_Line = ls_Text
		ls_Line = lnv_String.of_PadRight(ls_Line, ci_PADLENGTH)	
		ls_Lines[Upperbound(ls_Lines) + 1] = ls_Line
	END IF
	
	//apend to result
	ll_NumLines = UpperBound(ls_Lines[])
	FOR i = 1 TO ll_NumLines
		ls_Result += ls_Lines[i]
	NEXT
	
ELSEIF as_DeviceType = cs_HANDHELD THEN
	IF NOT isNull(as_TextLine) AND Len(as_TextLine) > 0 THEN
		ls_Result = as_Textline + "~n"
	END IF
ELSE
	ls_Result = ls_Text //No formatting
END IF

Return ls_Result
end function

protected function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext);Integer	li_Return = 1

Long		ll_SourceEntityId, &
			ll_DeviceFound, &
			ll_DeviceRowCount
			
String	ls_FindString

ll_DeviceRowCount = ads_CommunicationDevice.RowCount()

ll_SourceEntityId = anv_MsgData.of_GetSourceEntityId ( )

IF isnull ( ll_SourceEntityId) THEN
	
	as_errortext = "Equipment Reference number not found on message" 
	li_Return = -1
	
ELSE
	
	ls_FindString = "type = '" + is_DeviceType + &
						"' and equipmentid = " + string ( ll_SourceEntityId )
	ll_DeviceFound = ads_CommunicationDevice.Find ( ls_FindString, 1, ll_DeviceRowCount )
	
	IF ll_DeviceFound < 1 THEN
		ls_FindString = "type = '" + is_DeviceType + &
						"' and employeeid = " + string ( ll_SourceEntityId )
		ll_DeviceFound = ads_CommunicationDevice.Find ( ls_FindString, 1, ll_DeviceRowCount )
	END IF
	
	//find employee id if no equip
	
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

public function integer of_setnewlocation (ref n_cst_messagedata anv_msgdata, ref datastore ads_communicationdevice, ref string as_errortext, boolean ab_createdevice);Integer	li_Return = 1

Long		ll_SourceEntityId, &
			ll_DeviceFound, &
			ll_DeviceRowCount, &
			ll_NextId
			
String	ls_FindString

Constant Boolean	cb_Commit = TRUE

ll_DeviceRowCount = ads_CommunicationDevice.RowCount()

ll_SourceEntityId = anv_MsgData.of_GetSourceEntityId ( )

IF isnull ( ll_SourceEntityId) THEN

	as_errortext = "Equipment Reference number not found in message." 
	li_Return = -1
	
ELSE
	
	ls_FindString = "type = '" + is_DeviceType + &
						"' and equipmentid = " + string ( ll_SourceEntityId )
	ll_DeviceFound = ads_CommunicationDevice.Find ( ls_FindString, 1, ll_DeviceRowCount )
	
	IF ll_DeviceFound < 1 THEN
		ls_FindString = "type = '" + is_DeviceType + &
						"' and employeeid = " + string ( ll_SourceEntityId )
		ll_DeviceFound = ads_CommunicationDevice.Find ( ls_FindString, 1, ll_DeviceRowCount )
	END IF
	//find employee id if no equip
	
	IF ll_DeviceFound > 0 THEN
		//got it
	ELSE
		IF ab_CreateDevice then
			IF gnv_App.of_GetNextId ( "communication_device", ll_NextId, cb_Commit ) = 1 THEN
				ll_DeviceFound = ads_CommunicationDevice.InsertRow(0)
				IF ll_DeviceFound > 0 then
					ads_CommunicationDevice.Object.Id[ll_DeviceFound] = ll_NextId
					ads_CommunicationDevice.Object.EquipmentId[ll_DeviceFound] = ll_SourceEntityId
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

protected function integer of_executesecureposturlrequest (string as_url, string as_args, ref string as_response);/***************************************************************************************
NAME: 		of_ExecuteSecurePostUrlRequest

ACCESS:		Private
		
ARGUMENTS:	( String as_Url, String as_Args, Ref String as_response )

RETURNS:		Integer
	
DESCRIPTION: 
				The purpose of this function is to provied exetended http request capabilities
				that the Powerbuilder does not support.
				
				Powerbuilder function GetURL does not support 'url encoded' line feed characters (%0A or %0D)
				Powerbuilder function PostURL does not support SSL (https://)
				
				Instead we create a MicroSoft XMLHTTP OLE object and use that to POST the request
				
				Returns 1 if request succeeds
				Returns -1 error
				
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
				Created 6/02/06 - Maury
***************************************************************************************/

Integer 	li_Return = 1

String 	ls_Response, &
			ls_ResponseText, &
			ls_StatusText, &
			ls_CurrentVersion
			
Long 		ll_StatusCode

OleObject lnv_xmlhttp

lnv_xmlhttp = Create OleObject

//Get XMLHTTP Current Version
IF RegistryGet("HKEY_CLASSES_ROOT\Msxml2.XMLHTTP\CurVer", "", RegString!, ls_CurrentVersion) = -1 THEN
	li_Return = -1
	as_Response = "XMLHTTP OLE not found"
END IF

//Connect to OLE
IF li_Return = 1 THEN
	IF lnv_xmlhttp.ConnectToNewObject(ls_CurrentVersion) <> 0 THEN
		as_response = "Could not connect to XMLHTTP OLE object"
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN	
	//Send Request
	lnv_xmlhttp.Open("POST",as_url, False)
	lnv_xmlhttp.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	lnv_xmlhttp.Send(as_args)
	
	//Get response
	ls_StatusText = lnv_xmlhttp.StatusText
	ll_StatusCode = lnv_xmlhttp.Status
	ls_ResponseText = lnv_xmlhttp.ResponseText
	
	as_Response = ls_ResponseText
	
	//Check HTTP Response code for errors
	IF ll_StatusCode >= 300 THEN
		//Error code 300 found on example code online. 
		//We do not have documentation on this ole object to verify the rc values
		li_Return = -1
	ELSE
		li_Return = 1
	END IF
	
	//Cleanup
	lnv_xmlhttp.DisconnectObject()
END IF

Destroy lnv_XmlHttp

Return li_Return
end function

on n_cst_bso_communication_atroad.create
call super::create
end on

on n_cst_bso_communication_atroad.destroy
call super::destroy
end on

event constructor;call super::constructor;
is_DeviceType = n_cst_constants.cs_CommunicationDevice_AtRoad

n_cst_Msg	lnv_msg
S_Parm	lstr_parm

IF THIS.of_GetLoginData ( lnv_Msg ) = 1 THEN
	
	IF lnv_Msg.of_Get_Parm ( "PASSWORD" , lstr_Parm ) <> 0 THEN
		is_PassWord = String( lstr_Parm.ia_Value )
	END IF
	IF lnv_Msg.of_Get_Parm ( "USERNAME" , lstr_Parm ) <> 0 THEN
		is_UserName = String( lstr_Parm.ia_Value )
	END IF
	
END IF
end event

event destructor;call super::destructor;IF isvalid ( Inv_XMLObject ) THEN
	Inv_XMLObject.DisconnectObject()
END IF
				
destroy ( Inv_XMLObject )

end event

