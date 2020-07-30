$PBExportHeader$n_cst_bso_communication_intouch.sru
forward
global type n_cst_bso_communication_intouch from n_cst_bso_communication_manager
end type
end forward

global type n_cst_bso_communication_intouch from n_cst_bso_communication_manager
end type
global n_cst_bso_communication_intouch n_cst_bso_communication_intouch

type variables
protected:
string is_filepath
end variables

forward prototypes
public function integer of_sendoutbound (n_cst_msg anv_msg)
private subroutine of_getmessage (string asa_formhistory[], ref n_cst_messagedata anva_msgdata[])
public function integer of_getfleetlocation (ref datastore ads_message)
public function integer of_getinbound (ref datastore ads_message)
public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_messagedata anv_msgdata, boolean ab_lastrecorded)
private function integer of_getmappedmsgtype (string as_message, ref n_cst_messagedata anv_msgdata)
private function integer of_getfieldmapping (ref string asa_mapping[])
private function integer of_mapquestionandanswer (string as_question, string as_answer, ref n_cst_messagedata anv_msgdata)
private function integer of_getformmapping (ref string asa_Mapping[])
private function integer of_standardizefield (ref string as_value, string asa_values[])
private subroutine of_getlocation (string asa_location[], ref n_cst_messagedata anva_msgdata[])
public function string of_getextensionpath ()
end prototypes

public function integer of_sendoutbound (n_cst_msg anv_msg);/*
This will return:
						-1 = ERROR  (default)
						 1 = successful completion
	
*/

Integer	li_Return = 1, &
			li_InternetRet


long		ll_MessageCnt, &
			ll_MessageNdx, &
			ll_EquipmentId, &
			ll_ArrayCnt, &
			ll_Ndx
			
String	ls_UnitId, &
			ls_Text, &
			ls_NewText, &
			ls_TemplatePath, &
			ls_Topic, &
			ls_URL, &
			ls_SerialNumber, &
			ls_FreeFormText, &
			ls_message, &
			ls_messagetitle
			
BOOLEAN	lb_FreeForm			

any	laa_Message[], &
		laa_beo[], &
		laa_Empty[]

s_parm	lstr_Parm
s_outboundMessage			lstra_Messages []
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
n_cst_msg					lnv_BlankMessage
n_cst_string	lnv_String

//	populate template
IF anv_msg.of_Get_Parm ("FREEFORMTEXT", lstr_Parm ) <> 0 THEN
	ls_FreeFormText = lstr_Parm.ia_Value
	lb_FreeForm = TRUE
END IF

IF anv_msg.Of_Get_Parm ( "DATA" , lstr_Parm ) <> 0 THEN
	laa_Beo = lstr_Parm.ia_Value 
ELSEIF lb_FreeForm THEN 
	laa_beo = laa_Empty // need to send an array as a parm to of_CreateReports()
ELSE
	li_Return = -1
END IF

IF anv_msg.of_Get_Parm ( "MESSAGES" , lstr_Parm ) <> 0 THEN
	lstra_Messages = lstr_Parm.ia_Value 

	ll_MessageCnt = UpperBound ( lstra_Messages )
	
	FOR ll_MessageNdx = 1 TO ll_MessageCnt
		
		lnv_TagMessage = lnv_BlankMessage
		ls_TemplatePath = lstra_Messages[ll_MessageNdx].is_Template
		ls_Topic = lstra_Messages[ll_MessageNdx].is_Topic
		ll_equipmentID = lstra_Messages[ll_MessageNdx].il_destination 

		  SELECT eq_ref 
			 INTO :ls_UnitId
			 FROM equipment 
			WHERE eq_id = :ll_EquipmentId   ;

			commit;

		IF isnull ( ls_UnitId ) OR len ( trim ( ls_UnitId ) ) = 0 THEN
			ls_messagetitle = "Outbound Message"
			ls_message = "Could not find an equipment reference number in the equipment table for this equipment."
			li_Return = -1
			EXIT
			
		ELSE
			
			lstr_parm.is_Label = "NUMBERTAGS"
			lstr_Parm.ia_Value = '' 
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )

			lstr_parm.is_Label = "URL"
			lstr_Parm.ia_Value = ''
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )

			lstr_parm.is_Label = "#.UNITID"
			lstr_Parm.ia_Value = ls_UnitId
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )

			lstr_parm.is_Label = "#.SERVICE"
			lstr_Parm.ia_Value = "mes_send"
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )

			IF lb_FreeForm THEN
				lstr_parm.is_Label = "#.FREEFORMTEXT"
				lstr_Parm.ia_Value = ls_FreeFormText
				lnv_TagMessage.of_Add_Parm ( lstr_Parm )
			END IF

			IF lnv_ReportManager.of_CreateReport ( ls_Topic, ls_TemplatePath, laa_Beo, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
				//WE MAY NOT WANT TO DO THIS WHEN WE PROCESS MULTIPLE MESSAGES 
				li_Return = -1
				EXIT
			END IF
		
	END IF 
			
	NEXT
	
END IF 

// Send URL

/*	
	mes_send service returns last asn, we store this in the communication
	device table.
*/

IF li_Return = 1 THEN

	Inet	linet_Communication
	n_ir_Communication	lir_Communication
		
	ll_ArrayCnt = upperbound ( laa_Message ) 
	//send messages
	FOR ll_Ndx = 1 to ll_ArrayCnt
		
		IF len ( trim ( laa_Message [ll_Ndx] ) ) = 0 THEN
			CONTINUE
		ELSE
			
			ls_URL = string (laa_Message [ll_Ndx])
			
			IF GetContextService("Internet", linet_Communication) = 1 THEN
		
				lir_Communication = CREATE n_ir_Communication
				
				li_InternetRet = linet_Communication.GetURL (ls_URL, lir_Communication)
				CHOOSE CASE  li_InternetRet
		
					CASE 1  	//	Success
		
		//				ls_SerialNumber = string ( lir_Communication.iblb_Data )
		//				
		//			  UPDATE communicationdevice
		//			     SET lastmessagenumber = :ls_SerialNumber  
		//			   WHERE unitid = :ls_UnitId   ;
		//
		//				COMMIT;
		//				
		//				IF SQLCA.SQLCODE <> 0 THEN
		//					
		//					
		//				END IF
						//
				
					CASE -1  //	General error
						li_Return = -1 
						ls_messagetitle = "Internet Error"
						ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: General Error"
						
					CASE -2  //	Invalid URL
						li_Return = -1
						ls_messagetitle = "Internet Error"
						ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: Invalid URL"
						
					CASE -4  //	Cannot connect to the Internet
						li_Return = -1
						ls_messagetitle = "Internet Error"
						ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: Cannot connect to the Internet"
						
				END CHOOSE
		
				IF isvalid ( lir_Communication ) THEN
					DESTROY lir_Communication
				END IF
	
			END IF
		
		END IF
		
	NEXT
	
END IF

if li_Return = -1 then
	if gnv_app.of_Runningscheduledtask( ) then
		//no messages
	else
		messagebox(ls_messagetitle, ls_message)
	end if	
end if

RETURN li_Return 
end function

private subroutine of_getmessage (string asa_formhistory[], ref n_cst_messagedata anva_msgdata[]);Long		ll_Pos, &
			ll_Message_Ndx, &
			ll_Message_Max, &
			ll_MsgNdx, &
			ll_ArrayCnt, &
			ll_Ndx, &
			ll_AdjustedOffset, &
			ll_DSTOffSet
			
Int		li_BaseTimeZone
			
datetime	ldt_LTZReceived, &
			ldt_GMTReceived

String	ls_Label, &
			lsa_Message[], &
			lsa_Blank[], &
			lsa_Work[], &
			ls_MessageType, &
			ls_Line, &
			ls_Message, &
			ls_Delimiter

String	ls_Question
String	ls_Answer

//s_CommDeviceMessage	lstra_Blankmessage[]
n_cst_MessageData			lnv_CurrentMsg

n_cst_string			lnv_String
n_cst_datetime			lnv_DateTime
n_cst_Settings	lnv_Settings

//astra_Message = lstra_Blankmessage

Int	li_Count 
Int	i

li_Count = UpperBound ( anva_MsgData )
FOR i = 1 TO li_Count 
	Destroy ( anva_MsgData[i] )
NEXT



ll_Message_Max = upperbound ( asa_FormHistory ) 
ls_Delimiter = '~t'

////get timezone from system_settings
li_BaseTimeZone = lnv_Settings.of_GetBaseTimeZone ( ) 
IF isNull ( li_BaseTimeZone ) THEN
	RETURN 																/// EARLY RETURN HERE !!!!
END IF


//GMT is timezone 10
ll_AdjustedOffset = (10 - li_BaseTimeZone) * -1


FOR ll_Message_Ndx = 1 to ll_Message_Max
	
	lsa_Message = lsa_Blank
	ll_ArrayCnt = lnv_String.of_ParsetoArray ( asa_FormHistory [ ll_Message_Ndx ] , ls_Delimiter, lsa_Message )
					
	//Get data from message and load into structure
	IF ll_ArrayCnt < 7 THEN 
		//invalid message
		CONTINUE
	END IF
	
	ll_MsgNdx ++
	anva_MsgData[ ll_MsgNdx ] = CREATE	n_cst_messageData
	lnv_CurrentMsg = anva_MsgData[ ll_MsgNdx ]
	
	FOR ll_Ndx = 1 to ll_ArrayCnt
			
		ls_Message = ''
		ls_MessageType = ""
	
		ls_message = lnv_String.of_RemoveNonPrint ( lsa_Message [ ll_Ndx ] )
		
		IF len ( trim ( ls_message ) ) > 0 THEN

			CHOOSE CASE ll_Ndx
					
				CASE 1	//	Truck number
					lnv_CurrentMsg.of_SetEquipmentRef ( trim ( ls_message ) )
					
				CASE 2	//	Created datetime
					lsa_Work = lsa_Blank
					IF lnv_String.of_ParsetoArray ( ls_message, ' ', lsa_Work ) = 2 THEN
						ldt_GMTReceived = datetime ( date(lsa_Work [1]), time(lsa_Work [2]) ) 	
						ldt_LTZReceived = lnv_DateTime.of_RelativeDateTime(ldt_GMTReceived, (ll_AdjustedOffset * 3600) )
						
						//adjust for daylight savings time if necessary
						IF this.of_IsDaylightSavingsTime ( ldt_LTZReceived ) THEN
							//ADD 1 HOUR
							ll_DSTOffSet = ll_AdjustedOffset + 1
							ldt_LTZReceived = lnv_DateTime.of_RelativeDateTime(ldt_GMTReceived, (ll_DSTOffSet * 3600) )
						END IF

						lnv_CurrentMsg.of_SetLastPositionDate ( Date(ldt_LTZReceived) )
						lnv_CurrentMsg.of_SetLastPositionTime ( Time(ldt_LTZReceived) )
					END IF
					
				CASE 3	//	Received datetime
					
				CASE 4	//	Form Serial Number
						lnv_CurrentMsg.of_SetLastMessageNumber ( trim ( ls_message ) )
				CASE 5	// Form Id
					
				CASE 6	//	Form name
					
					// get the form name and map to the proper message type
					THIS.of_GetMappedMsgType ( ls_Message , lnv_CurrentMsg )

				CASE ELSE
					
					/*
					the way intouch handles multiple fields is with questions and answers
					so the file will contain
				   //	   Q          A      	Q			 A
					... FUEL TYPE	DIESEL	LAST STOP	YES	
					So I am going to grab the next 2 messages to get the question and answer 
					as a pair.
					*/
					
					ls_Question = ls_Message
					ll_Ndx ++
					ls_Answer = lnv_String.of_RemoveNonPrint ( lsa_Message [ ll_Ndx ] )				
					
					THIS.of_MapQuestionAndAnswer ( ls_Question , ls_Answer , lnv_CurrentMsg )
		
			END CHOOSE
				
		END IF

	NEXT
	//end get data from message
	
NEXT
end subroutine

public function integer of_getfleetlocation (ref datastore ads_message);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFleetLocation
//
//	Access:  public
//
//	Arguments:  ads_message by reference
//
//
//	Description:	
//
// Written by: Norm LeBlanc
// 		Date: 12/11/00
//		Version: 3.0.5
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

Integer	li_Return

Long		ll_MessageCnt, &
			ll_ArrayCnt, &
			ll_Ndx

String	ls_URL, &
			ls_Data, &
			lsa_FormHistory [], &
			ls_Delimiter, &
			ls_TemplatePath
					
Boolean	lb_Success			

any		laa_Data [], &
			laa_Beo[], &
			laa_message []
			
Int		li_Count
Int		i

n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
Inet							linet_Communication
n_ir_Communication		lir_Communication
//s_CommDeviceMessage		lstra_CommDeviceMessage[]
n_cst_messageData			lnva_MsgData[]
n_cst_string				lnv_String
		
li_Return = 1

IF GetContextService("Internet", linet_Communication) = 1 THEN

	lir_Communication = CREATE n_ir_Communication

	IF THIS.of_GetInboundPath ( ls_TemplatePath ) = 1 THEN
		
		ls_TemplatePath = ls_TemplatePath + "fleetloc.doc"
		
		IF lnv_ReportManager.of_CreateReport ( "", ls_TemplatePath, laa_Beo, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
			//WE MAY NOT WANT TO DO THIS WHEN WE PROCESS MULTIPLE MESSAGES 
			li_Return = -1
		
		ELSE
			
			ll_ArrayCnt = upperbound ( laa_Message ) 
			FOR ll_Ndx = 1 to ll_ArrayCnt
				ls_URL = ls_URL + string (laa_Message [ll_Ndx])
			NEXT
		END IF
		
	ELSE
		
		li_Return = -1
		
	END IF

	IF li_Return = 1 THEN
		

		CHOOSE CASE linet_Communication.GetURL (ls_URL, lir_Communication) 
	
			CASE 1  	//	Success
				
				ls_data = String ( lir_Communication.iblb_Data )
				
				IF pos ( ls_data, "success", 1 ) = 0 THEN
					IF pos (ls_data, "SUCCESS", 1 ) = 0 THEN
						lb_Success = FALSE
					ELSE
						lb_Success = TRUE
					END if
				ELSE
					lb_Success = TRUE
				END IF
				
				IF lb_Success THEN
					
					ls_Delimiter = '~r'  
					ll_MessageCnt = lnv_String.of_ParsetoArray ( ls_Data, ls_Delimiter, lsa_FormHistory ) 
				
					//load message structure array
					this.of_GetMessage ( lsa_FormHistory, lnva_MsgData )
				
					IF this.of_ProcessInboundMessages ( lnva_MsgData, ads_Message ) < 0 THEN
						
						li_Return = -1
						
					END IF
					
				END IF
		
			CASE -1  //	General error
			
			CASE -2  //	Invalid URL
			
			CASE -4  //	Cannot connect to the Internet
				
		END CHOOSE
		
	end if

END IF

IF isvalid ( lir_Communication ) THEN
	DESTROY lir_Communication
END IF

li_Count = UpperBound ( lnva_MsgData )
FOR i = 1 TO li_Count
	Destroy ( lnva_MsgData[i] )
NEXT

return li_Return
end function

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
//	Get the max serial number from the communication device table where
// type equal Intouch. This number os used as an argument for the 
//	service being requested. This will give us all messages since that number.
//
// Message types that will be processed are Arrival and Departure for event confirmation
// and driver requests for directions.  Any of these types that can't be processed
// will be apended to an error log file.
//
// These messages and any other message types will be added to ads_message for reference.
//
//
// Written by: Norm LeBlanc
// 		Date: 12/04/00
//		Version: 3.0.5
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//		April 4 2002: changed code to work with n_cst_messageData  RPZ
//
//////////////////////////////////////////////////////////////////////////////

//

// Send URL

/*	
	mes_send service returns last asn, we store this in the communication
	device table.
*/

Integer	li_Return, &
			li_InternetRet

Long		ll_LastSerialNumber, &
			ll_MessageCnt, &
			ll_ArrayCnt, &
			ll_Ndx

String	ls_URL, &
			ls_Data, &
			ls_SerialNumber, &
			ls_UnitID, &
			lsa_FormHistory [], &
			ls_Delimiter, &
			ls_TemplatePath, &
			ls_message, &
			ls_messagetitle
				
Boolean	lb_Success			

any		laa_Data [], &
			laa_Beo[], &
			laa_message []
Int		i
Int		li_Count

s_parm						lstr_Parm
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
Inet							linet_Communication
n_ir_Communication		lir_Communication
//s_CommDeviceMessage		lstra_CommDeviceMessage[]
n_cst_MessageData			lnva_MsgData[]
n_cst_string				lnv_String
		
li_Return = 1


  SELECT max ( convert ( Int, lastmessagenumber ) )
    INTO :ll_LastSerialNumber  
    FROM communicationdevice  ;


	commit;
	
if isnull(ll_LastSerialNumber) then
	ll_LastSerialNumber = 1
end if
	

IF GetContextService("Internet", linet_Communication) = 1 THEN

	lir_Communication = CREATE n_ir_Communication

	IF THIS.of_GetInboundPath ( ls_TemplatePath ) = 1 THEN
		
		ls_TemplatePath = ls_TemplatePath + "URL.doc"
		
		lstr_parm.is_Label = "NUMBERTAGS"
		lstr_Parm.ia_Value = '' 
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )

		lstr_parm.is_Label = "URL"
		lstr_Parm.ia_Value = ''
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )

		lstr_parm.is_Label = "#.SERVICE"
		lstr_Parm.ia_Value = "form_history"
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )

		lstr_parm.is_Label = "#.LASTASN"
		lstr_Parm.ia_Value = string ( ll_LastSerialNumber )
		lnv_TagMessage.of_Add_Parm ( lstr_Parm )

		IF lnv_ReportManager.of_CreateReport ( "", ls_TemplatePath, laa_Beo, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
			//WE MAY NOT WANT TO DO THIS WHEN WE PROCESS MULTIPLE MESSAGES 
			li_Return = -1
		
		ELSE
			
			ll_ArrayCnt = upperbound ( laa_Message ) 
			FOR ll_Ndx = 1 to ll_ArrayCnt
				ls_URL = ls_URL + string (laa_Message [ll_Ndx])
			NEXT
		END IF
		
	ELSE
		
		li_Return = -1
		
	END IF

	IF li_Return = 1 THEN
		
		li_InternetRet = linet_Communication.GetURL (ls_URL, lir_Communication)
		
		CHOOSE CASE li_InternetRet  
	
			CASE 1  	//	Success
				
				ls_data = String ( lir_Communication.iblb_Data )
				
				IF pos ( ls_data, "success", 1 ) = 0 THEN
					IF pos (ls_data, "SUCCESS", 1 ) = 0 THEN
						lb_Success = FALSE
					ELSE
						lb_Success = TRUE
					END if
				ELSE
					lb_Success = TRUE
				END IF
				
				IF lb_Success THEN
					
					ls_Delimiter = '~r'  
					ll_MessageCnt = lnv_String.of_ParsetoArray ( ls_Data, ls_Delimiter, lsa_FormHistory ) 
				
					//load message structure array
					this.of_GetMessage ( lsa_FormHistory, lnva_MsgData )
				
					IF this.of_ProcessInboundMessages ( lnva_MsgData, ads_Message ) < 0 THEN
						
						li_Return = -1
						
					END IF
					
				END IF
		
			CASE -1  //	General error
				li_Return = -1 
				ls_messagetitle = "Internet Error"
				ls_message =  "Return Code = " + string ( li_InternetRet ) + " Error: General Error"
				
			CASE -2  //	Invalid URL
				li_Return = -1
				ls_messagetitle = "Internet Error"
				ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: Invalid URL"
				
			CASE -4  //	Cannot connect to the Internet
				li_Return = -1
				ls_messagetitle = "Internet Error"
				ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: Cannot connect to the Internet"
						
		END CHOOSE
		
	end if

END IF

if li_Return = -1 then
	if gnv_app.of_Runningscheduledtask( ) then
		//no messages
	else
		if len(ls_message) > 0 then
			messagebox(ls_messagetitle, ls_message)
		end if
	end if	
end if

IF isvalid ( lir_Communication ) THEN
	DESTROY lir_Communication
END IF

li_Count = UpperBound ( lnva_MsgData ) 
FOR i = 1 TO li_Count 
	DESTROY ( lnva_MsgData[i] )
NEXT

return li_Return
end function

public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_messagedata anv_msgdata, boolean ab_lastrecorded);//////////////////////////////////////////////////////////////////////////////
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

Integer	li_Return, &
			li_InternetRet

Long		ll_MessageCnt, &
			ll_ArrayCnt, &
			ll_Ndx
String	ls_URL, &
			ls_Data, &
			ls_UnitID, &
			lsa_Location [], &
			ls_Delimiter, &
			ls_TemplatePath, &
			ls_OdlPath, &
			ls_message, &
			ls_messagetitle
			
				
Boolean	lb_Success			

any		laa_Data [], &
			laa_Beo[], &
			laa_message []

s_parm						lstr_Parm
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
Inet							linet_Communication
n_ir_Communication		lir_Communication
//s_CommDeviceMessage		lstra_CommDeviceMessage[]
n_cst_MessageData			lnva_MsgData[]
n_cst_string				lnv_String
li_Return = 1

IF ab_LastRecorded THEN
	
	IF this.of_GetLastRecordedPosition ( al_equipmentid, anv_MsgData ) < 0 THEN
		li_Return = -1
		
	END IF

ELSE

	IF GetContextService("Internet", linet_Communication) = 1 THEN
	
		lir_Communication = CREATE n_ir_Communication
	
		IF THIS.of_GetInboundPath ( ls_TemplatePath ) = 1 THEN
			
			lstr_parm.is_Label = "NUMBERTAGS"
			lstr_Parm.ia_Value = '' 
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
			lstr_parm.is_Label = "URL"
			lstr_Parm.ia_Value = ''
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
			lstr_parm.is_Label = "#.TRUCKNUM"
			lstr_Parm.ia_Value = as_equipmentref
			lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
	
	//FORCE ODL
			ls_ODLPath = ls_templatePath + "odl.doc"
	
			IF lnv_ReportManager.of_CreateReport ( "", ls_ODLPath, laa_Beo, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
				li_Return = -1
			
			ELSE
				
				ll_ArrayCnt = upperbound ( laa_Message ) 
				FOR ll_Ndx = 1 to ll_ArrayCnt
					ls_URL = ls_URL + string (laa_Message [ll_Ndx])
				NEXT
	
				li_InternetRet = linet_Communication.GetURL (ls_URL, lir_Communication) 
				
				CHOOSE CASE li_InternetRet
		
					CASE 1  	//	Success
						
						ls_data = String ( lir_Communication.iblb_Data )
						
						IF pos ( ls_data, "success", 1 ) = 0 THEN
							IF pos (ls_data, "SUCCESS", 1 ) = 0 THEN
								lb_Success = FALSE
							ELSE
								lb_Success = TRUE
							END if
						ELSE
							lb_Success = TRUE
						END IF
						
					CASE -1  //	General error
						li_Return = -1 
						ls_messagetitle = "Internet Error"
						ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: General Error"
						
					CASE -2  //	Invalid URL
						li_Return = -1
						ls_messagetitle = "Internet Error"
						ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: Invalid URL"
						
					CASE -4  //	Cannot connect to the Internet
						li_Return = -1
						ls_messagetitle = "Internet Error"
						ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: Cannot connect to the Internet"
										
				END CHOOSE
	
			END IF
			
		ELSE
			
			li_Return = -1
			
		END IF
		
	//GET LOCATION
		IF li_Return = 1 THEN
			
			ls_TemplatePath = ls_TemplatePath + "truckloc.doc"
		
			IF lnv_ReportManager.of_CreateReport ( "", ls_TemplatePath, laa_Beo, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
				li_Return = -1
				
			ELSE
					
				ls_URL = ""
				ll_ArrayCnt = upperbound ( laa_Message ) 
				FOR ll_Ndx = 1 to ll_ArrayCnt
					ls_URL = ls_URL + string (laa_Message [ll_Ndx])
				NEXT
				
			END IF
	
		END IF
	
		IF li_Return = 1 THEN
			
	
			CHOOSE CASE linet_Communication.GetURL (ls_URL, lir_Communication) 
		
				CASE 1  	//	Success
					
					ls_data = String ( lir_Communication.iblb_Data )
					
					IF pos ( ls_data, "success", 1 ) = 0 THEN
						IF pos (ls_data, "SUCCESS", 1 ) = 0 THEN
							lb_Success = FALSE
						ELSE
							lb_Success = TRUE
						END if
					ELSE
						lb_Success = TRUE
					END IF
					
					IF lb_Success THEN
						
						ls_Delimiter = '~r'  
						ll_MessageCnt = lnv_String.of_ParsetoArray ( ls_Data, ls_Delimiter, lsa_Location ) 
					
						//load message structure array
						this.of_GetLocation ( lsa_Location, lnva_MsgData )
						IF UpperBound( lnva_MsgData ) > 0 THEN
							anv_MsgData=lnva_MsgData[1]
						END IF
									
					END IF
			
					CASE -1  //	General error
						li_Return = -1
						ls_messagetitle = "Internet Error"
						ls_message =  "Return Code = " + string ( li_InternetRet ) + " Error: General Error"
						
					CASE -2  //	Invalid URL
						li_Return = -1
						ls_messagetitle = "Internet Error"
						ls_message =  "Return Code = " + string ( li_InternetRet ) + " Error: Invalid URL"
						
					CASE -4  //	Cannot connect to the Internet
						li_Return = -1
						ls_messagetitle = "Internet Error"
						ls_message = "Return Code = " + string ( li_InternetRet ) + " Error: Cannot connect to the Internet"
										
			END CHOOSE
			
		end if
	
	END IF
	
	IF isvalid ( lir_Communication ) THEN
		DESTROY lir_Communication
	END IF

END IF

if li_Return = -1 then
	if gnv_app.of_Runningscheduledtask( ) then
		//no messages
	else
		if len (ls_message) > 0 then
			messagebox(ls_messagetitle, ls_message)
		end if
	end if	
end if

return li_Return
end function

private function integer of_getmappedmsgtype (string as_message, ref n_cst_messagedata anv_msgdata);String	ls_Msg
String	lsa_values[]

ls_Msg = Trim (  Upper ( as_Message ) )

anv_MsgData.of_AppendToMessageText ( " " + ls_Msg )

THIS.of_GetFormMapping ( lsa_Values )

THIS.of_StandardizeField ( ls_Msg , lsa_Values )

anv_MsgData.of_SetMessageType ( ls_Msg )

IF ls_Msg = "DIRECTIONS" THEN
	anv_MsgData.of_SetOutboundTemplate ( "DIRECTNS.DOC"  )
END IF


RETURN -1
end function

private function integer of_getfieldmapping (ref string asa_mapping[]);String	ls_Topic 
String	ls_TemplatePath
Int		li_Return = 1

Any		laa_Empty[]  
Any 		laa_Message[]

S_Parm	lstr_Parm
n_cst_msg					lnv_TagMessage
n_cst_bso_ReportManager	lnv_ReportManager

ls_Topic = ""

IF THIS.of_getInboundPath ( ls_TemplatePath ) = 1 THEN
	IF Right ( ls_TemplatePath , 1 ) <> "\" THEN
		ls_TemplatePath += "\"
	END IF
	ls_TemplatePath += "Fieldmap.doc"
END IF
	
IF lnv_ReportManager.of_CreateReport ( ls_Topic, ls_TemplatePath, laa_Empty, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
	li_Return = -1
ELSE
	asa_Mapping[] = laa_Message
END IF

RETURN li_Return
end function

private function integer of_mapquestionandanswer (string as_question, string as_answer, ref n_cst_messagedata anv_msgdata);//String	ls_Question
//String	ls_Answer
String	lsa_Work[]
String	lsa_Fields[]
String	lsa_Values[]
Long		ll_Null
Int		li_Return = 1


n_cst_String	lnv_String

SetNull ( ll_Null )

IF Not isValid ( anv_MsgData ) THEN
	RETURN -1										// EARLY RETURN HERE !!!
END IF


THIS.of_GetFieldmapping ( lsa_Values )

IF THIS.of_StandardizeField ( as_Question , lsa_Values ) = 1 THEN
		
	CHOOSE CASE as_Question 
			
		CASE "LOCATION"	//LastPositionLocation
			anv_MsgData.of_SetLastPositionLocation ( trim ( as_Answer ) )
		
		CASE "LAT / LONG"	//LastPositionLat LastPositionLong	
			IF lnv_String.of_ParsetoArray ( as_Answer, ' ', lsa_Work ) > 2 THEN
				anv_MsgData.of_SetLastPositionLat ( lsa_Work [1] )
				anv_MsgData.of_SetLastPositionLong ( right ( lsa_Work [2], len ( lsa_Work [2] ) - 1 ) )
			END IF 
			
		CASE "EVENT #"	//EventId
			IF isnumber ( as_Answer ) THEN
				anv_MsgData.of_SetEventId ( long(as_Answer) )
			ELSE
				anv_MsgData.of_SetEventId ( ll_Null )
			END IF			
			
		CASE "TMP"			
			IF isnumber ( as_Answer ) THEN
				anv_MsgData.of_Setshipmentid ( long ( as_Answer ) )
			END IF
			
		CASE "CONTAINER"	
			anv_MsgData.of_Setcontainer ( as_Answer )			
			
		CASE "CHASSIS"
			anv_MsgData.of_Setchassis ( as_Answer )
			
		CASE "TEMPLATE"
			anv_MsgData.of_SetShipmentTemplate ( as_Answer )
		
	END CHOOSE
	
	IF as_Question = "LOCATION" or as_Question = "LAT / LONG"	THEN
		//Don't put in message text
	ELSE
		anv_msgdata.of_AppendToMessageText ( " " + as_Question + " " + as_Answer )			
	END IF
	
ELSE 
	li_Return = -1
END IF


RETURN li_Return
end function

private function integer of_getformmapping (ref string asa_Mapping[]);String	ls_Topic 
String	ls_TemplatePath
Int		li_Return = 1

Any		laa_Empty[]  
Any 		laa_Message[]

S_Parm	lstr_Parm
n_cst_msg					lnv_TagMessage
n_cst_bso_ReportManager	lnv_ReportManager

ls_Topic = ""

IF THIS.of_getInboundPath ( ls_TemplatePath ) = 1 THEN
	IF Right ( ls_TemplatePath , 1 ) <> "\" THEN
		ls_TemplatePath += "\"
	END IF
	ls_TemplatePath += "Formmap.doc"
END IF
	
IF lnv_ReportManager.of_CreateReport ( ls_Topic, ls_TemplatePath, laa_Empty, FALSE, TRUE, laa_Message, lnv_TagMessage )  < 0 THEN
	li_Return = -1
ELSE
	asa_Mapping[] = laa_Message
END IF

RETURN li_Return
end function

private function integer of_standardizefield (ref string as_value, string asa_values[]);/*
	Although we may return -1 here it does not mean failure only that the field was
	not mapped to anything else.

*/

String	ls_Working
String	lsa_Parsed[]
Int		li_Count
Int		i
Int		li_Return = 1

n_cst_String	lnv_String

as_Value = TRIM ( Upper ( as_Value ) )
	
li_Count = UpperBound ( asa_Values[] )

FOR i = 1 TO li_Count
	ls_Working = asa_Values[i]
	
	lnv_String.of_ParseToArray ( ls_Working , "=" , lsa_Parsed ) 
	IF UpperBound ( lsa_Parsed ) = 2 THEN
		IF as_Value = Trim ( Upper ( lsa_Parsed [1] ) ) THEN
			as_Value = Trim ( Upper ( lsa_Parsed [2] ) ) // standard value
			EXIT 
		END IF
	END IF

NEXT	

IF i > li_Count THEN
	li_Return = -1
END IF

RETURN li_Return
end function

private subroutine of_getlocation (string asa_location[], ref n_cst_messagedata anva_msgdata[]);Long		ll_Pos, &
			ll_Message_Ndx, &
			ll_Message_Max, &
			ll_MsgIndex, &
			ll_ArrayCnt, &
			ll_Ndx, &
			ll_Null, & 
			ll_LocalTimeZone, &
			ll_AdjustedOffset
			
datetime	ldt_LTZReceived, &
			ldt_GMTReceived

String	ls_Label, &
			lsa_Message[], &
			lsa_Blank[], &
			lsa_Work[], &
			ls_MessageType, &
			ls_Line, &
			ls_Message, &
			ls_Delimiter
Int		i
Int		li_Count
//s_CommDeviceMessage	lstra_Blankmessage[]
n_cst_string			lnv_String
n_cst_datetime			lnv_DateTime
n_cst_messageData		lnv_CurrentMsg

Setnull( ll_Null )
//astra_Message = lstra_Blankmessage
li_Count = UpperBound ( anva_MsgData[] )
FOR i = 1 To li_Count
	DESTROY ( anva_MsgData [i] )
NEXT



ll_Message_Max = upperbound ( asa_location[] ) 
ls_Delimiter = '~t'

//get timezone from system_settings
//GMT is timezone 10
//
ll_LocalTimeZone = 5
ll_AdjustedOffset = (10 - ll_LocalTimeZone) * -1

FOR ll_Message_Ndx = 1 to ll_Message_Max
	
	lsa_Message = lsa_Blank
	ll_ArrayCnt = lnv_String.of_ParsetoArray ( asa_location[] [ ll_Message_Ndx ] , ls_Delimiter, lsa_Message )
					
	//Get data from message and load into structure
	IF ll_ArrayCnt < 7 THEN 
		//invalid message
		CONTINUE
	END IF
	
	
	ll_MsgIndex ++
	anva_MsgData[ ll_MsgIndex ] = CREATE n_cst_MessageData	
	lnv_CurrentMsg = anva_MsgData[ ll_MsgIndex ]	
	
	FOR ll_Ndx = 1 to ll_ArrayCnt				
			
		ls_Message = ''
		ls_MessageType = ""
		
		ls_message = lnv_String.of_RemoveNonPrint ( lsa_Message [ ll_Ndx ] )
		
		IF len ( trim ( ls_message ) ) > 0 THEN

			CHOOSE CASE ll_Ndx
					
				CASE 1	//	Truck number
					lnv_CurrentMsg.of_SetEquipmentRef ( trim ( ls_message ) )
					
				CASE 2	//	Received datetime
					lsa_Work = lsa_Blank
					IF lnv_String.of_ParsetoArray ( ls_message, ' ', lsa_Work ) = 2 THEN
						ldt_GMTReceived = datetime ( date(lsa_Work [1]), time(lsa_Work [2]) ) 	
						ldt_LTZReceived = lnv_DateTime.of_RelativeDateTime(ldt_GMTReceived, (ll_AdjustedOffset * 3600) )
						lnv_CurrentMsg.of_SetLastPositionDate ( Date(ldt_LTZReceived) )
						lnv_CurrentMsg.of_SetLastPositionTime ( Time(ldt_LTZReceived) )
					END IF
					
				CASE 3	//	speed

				CASE 4	// heading
					
				CASE 5	// GPS Quality
										
				CASE 6	// Latitude 
					lnv_CurrentMsg.of_SetLastPositionLat ( trim ( ls_message ) )
		
				CASE 7	//	Longitude
					lnv_CurrentMsg.of_SetLastPositionLong ( right ( trim (ls_message), len (ls_message) - 1 )	)
					
				CASE 8	// LOCATION
					lnv_CurrentMsg.of_SetLastPositionLocation ( trim ( ls_message ) )
						
			END CHOOSE
				
		END IF

	NEXT
	//end get data from message
	
NEXT
end subroutine

public function string of_getextensionpath ();Return "message\intouch\outbound\"
end function

on n_cst_bso_communication_intouch.create
call super::create
end on

on n_cst_bso_communication_intouch.destroy
call super::destroy
end on

event constructor;call super::constructor;
is_DeviceType = n_cst_constants.cs_CommunicationDevice_intouch
end event

