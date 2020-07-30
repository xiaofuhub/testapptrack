$PBExportHeader$n_cst_bso_communication_qualcomm.sru
forward
global type n_cst_bso_communication_qualcomm from n_cst_bso_communication_manager
end type
end forward

global type n_cst_bso_communication_qualcomm from n_cst_bso_communication_manager
end type
global n_cst_bso_communication_qualcomm n_cst_bso_communication_qualcomm

type variables
CONSTANT Int 	ci_FileFree = 1
CONSTANT Int 	ci_FileActive = 2
CONSTANT String  cs_FileFree = "FREE"
CONSTANT String  cs_FileActive = "ACTIVE"

Private:
Int    ii_FileHandle
String is_FilePath

end variables

forward prototypes
public function integer of_gettemplate (ref string as_templatepath)
private function integer of_getstatusflag (ref integer ai_filehandle)
public function integer of_sendoutbound (n_cst_msg anv_msg)
private subroutine of_setfilepath ()
public subroutine of_getfilepath (ref string as_path)
protected subroutine of_getimportflagfilelocation (ref string as_filepath)
public subroutine of_getimportfile (ref string as_file)
public subroutine of_getexportfile (ref string as_File)
protected subroutine of_getexportflagfilelocation (ref string as_filepath)
public function integer of_writetoimportfile (any aaa_message[])
public function integer of_getinbound (ref datastore ads_message)
private subroutine of_getmessage (string as_filename, ref n_cst_messagedata anva_msgdata[])
public function integer of_locatetruck (long al_equipmentid, string as_equipmentref, ref n_cst_messagedata anv_msgdata, boolean ab_lastrecorded)
private function integer of_setstatusflag (ref string as_file, integer ai_status)
public function string of_getextensionpath ()
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

private function integer of_getstatusflag (ref integer ai_filehandle);// this method will  attempt to read the text in the file and determine if the file 
// indicates FREE or ACTIVE
//
//	Returns:
//				-1 = ERROR
//			    ci_FileFree (1)
//				 ci_FileActive (2)
//		
						 


String	ls_FileString
Int		li_FileHandle
Int		li_FileReadRtn
Int		li_Return	= -1
	
IF (Not isNull (ai_fileHandle) ) AND li_FileHandle <> -1 THEN
	
	li_FileReadRtn = FileRead ( ai_filehandle , ls_FileString )
	CHOOSE CASE li_FileReadRtn 
			
		CASE is > 0 // success
			
			IF Pos ( Upper ( ls_FileString ), cs_fileFree ) > 0 THEN
				li_Return = ci_FileFree
			ELSEIF Pos ( Upper ( ls_FileString ), cs_fileActive ) > 0 THEN
				li_Return = ci_FileActive
			ELSE
				li_Return = -1
			END IF
			
		CASE -100 //(EOF) is encountered before any characters are read
			li_Return = -1
			
		CASE -1 //error occured
			li_Return = -1
			
		CASE ELSE  // possible null rtn
			li_Return = -1
			
	END CHOOSE
		
END IF

RETURN li_Return 

end function

public function integer of_sendoutbound (n_cst_msg anv_msg);/*
This will return:
						-1 = ERROR  (default)
						 0 = Processing stopped ( File Active )
						 1 = successful completion
	
*/



Boolean	lb_Continue
Boolean	lb_Retry 
Boolean	lb_FreeForm

String	ls_TemplatePath, &
			ls_FilePath, &
			ls_FlagFile, &
			ls_Topic, &
			ls_mctnumber, &
			ls_FreeFormText, &
			ls_messagetitle, &
			ls_message
			
Int		li_Return, &
			li_FileStatus, &
			li_FlagFileHandle, &
			li_MBoxRtn
			
long		ll_MessageCnt, &
			ll_MessageNdx, &
			ll_EquipmentId
			
Any		laa_Message[], &
			laa_Beo[], &
			laa_Empty[]
			
S_parm						lstr_Parm
s_outboundMessage			lstra_Messages []
n_cst_bso_ReportManager	lnv_ReportManager
n_cst_msg					lnv_TagMessage
n_cst_msg					lnv_BlankMessage


li_FlagFileHandle = -1
li_Return = 1

this.Of_SetFilePath ()
// Check the flag of the import status

THIS.of_GetImportFlagFileLocation ( ls_FlagFile )

DO
	//first try to open in a shared mode
	IF FileExists ( ls_FlagFile ) THEN
		
		li_FlagFileHandle = FileOpen ( ls_FlagFile , StreamMode! , Read! , Shared! )
	
		IF li_FlagFileHandle >= 0 THEN

			li_FileStatus = THIS.of_GetStatusFlag ( li_FlagFileHandle )	
			FileClose ( li_FlagFileHandle )
			
			IF li_FileStatus = ci_FileFree THEN
				IF THIS.of_SetStatusflag( ls_FlagFile , ci_fileactive ) = 1 THEN
					lb_Continue = TRUE	
				ELSE
					li_Return = -1
					ls_Message = "Profit Tools could not set the flag file to active."
				END IF
			END IF
			
		END IF
			
		IF NOT lb_Continue THEN
				
			if gnv_app.of_Runningscheduledtask( ) then
				//no messaging
			else
				CHOOSE CASE MessageBox ("Outbound Message", &
								"Profit Tools could not send the outbound message." + &
								" This could be because Qtracks is busy." , &
								 Information!, RetryCancel!, 1 ) 
					CASE 1
						lb_Retry = TRUE
					
					CASE ELSE
						lb_Retry = FALSE
						lb_Continue = FALSE
						li_Return = -1
						
				END CHOOSE
				
			end if
			
		END IF
	
		

	ELSE
		
		//file does not exist, try opening in write mode	
		IF THIS.of_Setstatusflag( ls_FlagFile , ci_fileactive ) = 1 THEN
			lb_Continue = TRUE
		ELSE
			li_Return = -1
			ls_Message = "Profit Tools could not set the flag file to active."
		END IF		
	END IF
	
LOOP WHILE lb_Retry 

IF lb_Continue THEN
	IF Not isValid ( anv_Msg ) THEN 
		
		li_Return = -1
	
	END IF
	
	//populate template
	IF li_Return = 1 THEN
		
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
		
		
		IF li_Return = 1 THEN
			
			IF anv_msg.of_Get_Parm ( "MESSAGES" , lstr_Parm ) <> 0 THEN
				lstra_Messages = lstr_Parm.ia_Value 
			
				ll_MessageCnt = UpperBound ( lstra_Messages )
				
				FOR ll_MessageNdx = 1 TO ll_MessageCnt
					
					lnv_TagMessage = lnv_BlankMessage
					ls_TemplatePath = lstra_Messages[ll_MessageNdx].is_Template
					ls_Topic = lstra_Messages[ll_MessageNdx].is_Topic
					ll_equipmentID = lstra_Messages[ll_MessageNdx].il_destination 
		
					  SELECT unitid 
						 INTO :ls_mctnumber  
						 FROM communicationdevice 
						WHERE equipmentid = :ll_EquipmentId  
								AND type = :is_DeviceType;
			
						commit;
	
					IF isnull ( ls_mctnumber ) OR len ( trim ( ls_mctnumber ) ) = 0 THEN
						
						ls_messagetitle = "Outbound Message"
						ls_message = "There is no unitid ( MCTNUMBER ) in the communication device table for this equipment."
						li_Return = -1
						EXIT
						
					ELSE
						
						lstr_parm.is_Label = "#.MCTNUMBER"
						lstr_Parm.ia_Value = ls_mctnumber
						lnv_TagMessage.of_Add_Parm ( lstr_Parm )
	
						lstr_parm.is_Label = "NUMBERTAGS"
						lstr_Parm.ia_Value = " " 
						lnv_TagMessage.of_Add_Parm ( lstr_Parm )

						IF lb_FreeForm THEN
							lstr_parm.is_Label = "FREEFORMTEXT"
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
			
		END IF
		
	END IF
	
	// write to file
	IF li_Return = 1 THEN
		IF THIS.of_WriteToImportFile ( laa_Message ) < 0  THEN
			ls_messagetitle = "Outbound Message"
			ls_message = "Profit Tools could not send the outbound message." + &
							" This could be because Qtracks is busy. Try again." 
			li_Return = -1  
		END IF
	END IF
	
	THIS.of_Setstatusflag( ls_FlagFile , ci_filefree )
	
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

IF li_Return = 1 THEN
	Int	i	
	
	pt_n_cst_beo	lnva_Beos[]
	lnva_Beos = laa_Beo
	FOR i = 1 TO UpperBound ( lnva_Beos )
		
		IF lnva_Beos[i].ClassName ( ) = 'n_cst_beo_event' THEN
			lnva_Beos[i].Dynamic of_SetStatus ( 'T' ) 
		END IF			
	NEXT
	
END IF

RETURN li_Return 
end function

private subroutine of_setfilepath ();//	Set the path for commnication message importing and exporting from
//	the system setting 

Integer li_Return
any	la_Path
String	ls_Path

n_cst_settings lnv_Settings

li_Return = 1

IF lnv_Settings.of_GetSetting ( 66 , la_path ) <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ls_Path = Trim ( String ( la_Path ) ) 
	IF Right ( ls_Path , 1 ) <> '\' THEN
		ls_Path += '\'
	END IF
END IF

IF li_Return = 1 THEN
	is_filepath = ls_Path + "DBC\QTRACS\"
END IF

end subroutine

public subroutine of_getfilepath (ref string as_path);IF len ( is_FilePath ) > 0 THEN
	//CONTINUE
	
ELSE
	
	THIS.of_SetFilePath ( )

END IF


as_path = is_filepath

end subroutine

protected subroutine of_getimportflagfilelocation (ref string as_filepath);// This method will populate the reference argument with the full file path to the 
// location of the 'QIIMPORT.FLG' file. 

as_filepath = is_FilePath + 'QIIMPORT.FLG'




end subroutine

public subroutine of_getimportfile (ref string as_file);// this function will return by reference a file in which the message to be sent to the 
// truck ( import ) should be written to. if the file does not exist it will be created 
// so the calling script can append to the passed file.

long ll_FileNum

as_File = is_FilePath + "QIIMPORT.TXT"
IF fileExists(as_File) THEN
	//OK
ELSE
	ll_FileNum = fileopen (as_File)
	fileclose(ll_FileNum)
	
END IF

end subroutine

public subroutine of_getexportfile (ref string as_File);// this function will return by reference a file in which the message to be sent to the 
// truck ( export ) should be read from. if the file does not exist it will be created 
// so the calling script can append to the passed file.

long ll_FileNum

as_File = is_FilePath + "QIEXPORT.TXT"
IF fileExists(as_File) THEN
	//OK
ELSE
	ll_FileNum = fileopen (as_File)
	fileclose(ll_FileNum)
	
END IF

end subroutine

protected subroutine of_getexportflagfilelocation (ref string as_filepath);// This method will populate the reference argument with the file path for the 
// 'QIEXPORT.FLG' file specified in the system setting.

STRING	ls_FilePath

ls_FilePAth = is_FilePath + "QIEXPORT.FLG"

as_filepath = ls_FilePath

end subroutine

public function integer of_writetoimportfile (any aaa_message[]);// this method will write data to the target file 

Int		li_FileStatus, &
			li_Return = 1, &
			li_FileReturn
			
Long		ll_FileHandle, &
			ll_Ndx, & 
			ll_ArrayCount
			
String	ls_ImportFileLocation, &
			ls_FileText
		
		
THIS.of_GetImportFile ( ls_ImportFileLocation )

ll_FileHandle = FileOpen ( ls_ImportFileLocation, LineMode!, Write!, LockReadWrite!, Append! )

IF ll_FileHandle > 0 THEN
	
	ll_ArrayCount = upperbound (aaa_Message)	
	
	FOR ll_Ndx = 1 TO ll_ArrayCount
	
		ls_FileText = aaa_Message [ ll_Ndx ]
		
		IF FileWrite ( ll_FileHandle, ls_FileText ) < 0 THEN
			
			li_Return = -1
			EXIT
			
		END IF
		
		
	NEXT
	
	FileClose ( ll_FileHandle )
	
ELSE
	
	li_Return = -1
	
END IF		
	
		
RETURN li_Return

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
//	Try to open the flg file locked so that qtracs can't access while we are using the 
//	export file.  If open successfully and the flag is set to free then copy the 
//	export file and then delete the original. Release the flg file so qtracs can
// continue generating messages to a new export file.
//
// Message types that will be processed are Arrival and Departure for event confirmation
// and driver requests for directions.  Any of these types that can't be processed
// will be apended to an error log file.
// These messages and any other message types will be added to ads_message for reference
// ( could be displayed and printed, maybe a row could be Emailed to the appropriate 
// person to handle message)
// 
// 
//
//
// Written by: Norm LeBlanc
// 		Date: 11/15/00
//		Version: 3.0
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	
//////////////////////////////////////////////////////////////////////////////

//
string	ls_line, &
			ls_FlagFile, &
			ls_ExportFile, & 
			ls_FileName, &
			ls_TempFileName, &
			lsa_Result [], &
			ls_Backupfile
			
integer	li_Ret, &
			li_FileRead, &
			li_FlagFileHandle, &
			li_FileStatus, &
			li_TempFileHandle, &
			li_ExportFileHandle

Int		li_Count
Int		i


boolean	lb_Retry, &
			lb_Continue
			
//s_CommDeviceMessage	lstra_CommDeviceMessage[]

n_cst_MessageData		lnva_MsgData[]
n_cst_string			lnv_String

this.Of_SetFilePath ()

this.of_GetExportFlagFileLocation ( ls_FlagFile )

li_Ret = 1


DO  		
	
	//first try to open in read mode
	IF FileExists ( ls_FlagFile ) THEN
		
		li_FlagFileHandle = FileOpen ( ls_FlagFile , StreamMode! , Read! , Shared!)
	
		IF li_FlagFileHandle >= 0 THEN

			li_FileStatus = THIS.of_GetStatusFlag ( li_FlagFileHandle )	
			FileClose ( li_FlagFileHandle )
			IF li_FileStatus = ci_FileFree THEN
				IF THIS.of_Setstatusflag( ls_FlagFile , ci_fileactive ) = 1 THEN
					lb_Continue = TRUE
				ELSE
					li_Ret = -1
			//		ls_Message = "Profit Tools could not set the flag file to active." 
				END IF
			END IF
			
		END IF
			
		IF NOT lb_Continue THEN
				
			if gnv_app.of_Runningscheduledtask( ) then
				//no messages
				li_Ret = -1
			else

				CHOOSE CASE MessageBox ("Import Message", &
								"Profit Tools could not import the inbound messages." + &
								" This could be because QTRACS is busy." , &
								 Information!, RetryCancel!, 1 ) 
					CASE 1
						lb_Retry = TRUE
						
					CASE ELSE
						lb_Retry = FALSE
						lb_Continue = FALSE
						li_Ret = -1
						
				END CHOOSE
								
			end if
									
		END IF
			
	ELSE
		
		//file does not exist, try opening in write mode	
		IF THIS.of_Setstatusflag( ls_FlagFile , ci_fileactive ) = 1 THEN
			lb_Continue = TRUE
		ELSE
			li_Ret = -1
	//		ls_Message = "Profit Tools could not set the flag file to active."
		END IF
		
	END IF
	
LOOP WHILE lb_Retry 

IF lb_Continue THEN
	
	THIS.of_GetExportFile ( ls_ExportFile ) 
	lnv_String.of_ParseToArray ( ls_ExportFile, "\" , lsa_Result )
	ls_FileName = lsa_Result [ UpperBound ( lsa_Result ) ] 
	
	ls_Backupfile = string ( today(),"mmdd") + string ( now(), "hhmmss") + ".txt"
	ls_TempFileName = ls_ExportFile
	ls_TempFileName = lnv_String.of_Substitute (ls_TempFileName, ls_FileName, ls_Backupfile)
	
	li_ExportFileHandle = FileOpen ( ls_ExportFile , LineMode! , Read! , LockReadWrite!)
	IF li_ExportFileHandle > 0 THEN
		li_TempFileHandle = FileOpen ( ls_TempFileName , LineMode! , Write! , LockReadWrite!)
		//write export file to a temp file, delete export file and free flag
		//delete temp file when done processing
		DO UNTIL li_FileRead = -100
		
			li_FileRead = FileRead( li_ExportFileHandle, ls_line )
			IF li_FileRead > 0 THEN
				FileWrite( li_TempFileHandle, ls_line )
			END IF
			
		LOOP

		
	ELSE
	
		li_Ret = 0
		
	END IF
		
	FileClose(li_ExportFileHandle)
	FileClose(li_TempFileHandle)
	FileDelete(ls_ExportFile)
	li_FileRead = 0
	
	THIS.of_Setstatusflag( ls_FlagFile , ci_filefree )
	
END IF

IF li_Ret = 1	THEN
	//load message structure array
	this.of_GetMessage ( ls_TempFileName, lnva_MsgData )
	
	IF this.of_ProcessInboundMessages ( lnva_MsgData, ads_Message ) < 0 THEN
		
		li_Ret = -1
		
	END IF
	
END IF

li_Count = UpperBound ( lnva_MsgData )
FOR i = 1 TO li_Count 
	DESTROY ( lnva_MsgData[i] )
NEXT

return li_Ret
end function

private subroutine of_getmessage (string as_filename, ref n_cst_messagedata anva_msgdata[]);//Modified 2/22/05 BKW to fix bug seen in field.  Qualcomm added a new file entry called POSITION (a position report) 
//in addition to the old message entries.  Because of the way Norm had coded this, we were not handling this gracefully,
//and were stuck in an infinite loop.

Integer	li_FileNum, &
			li_FileRead
			
Long		ll_Pos, &
			ll_Message_Ndx, &
			ll_Message_Max, &
			ll_DataObjectIndex, &
			ll_Null

String	ls_Label, &
			lsa_Message[], &
			lsa_Blank[], &
			ls_MessageType, &
			ls_Line, &
			ls_Message, &
			ls_Text

Boolean	lb_Message
Int		li_Count
Int		i

//s_CommDeviceMessage	lstra_Blankmessage[]

n_cst_messageData		lnv_CurrentMsg

li_Count = UpperBound ( anva_MsgData )
FOR i = 1 TO li_Count
	DESTROY ( anva_MsgData[i] )
NEXT


Setnull( ll_Null )
//astra_Message = lstra_Blankmessage

li_FileNum = FileOpen ( as_filename, LineMode!, Read! , LockReadWrite! )

IF li_FileNum > 0 THEN
	
	DO UNTIL li_FileRead = -100
		
		li_FileRead = FileRead( li_FileNum, ls_line )
						
		//STRIP LABEL
		ll_Pos = Pos ( ls_Line, " ", 1 ) 
		IF ll_Pos > 0 THEN
			ls_Label = Trim ( Left ( ls_Line, ll_Pos ) )
		ELSE
			ls_Label = ""
		END IF
		
		IF len ( ls_Label ) = 0 THEN CONTINUE

		//Get message
		IF ls_Label = "#START" THEN 
		
			lsa_Message = lsa_Blank
			ls_Message = ''
			ll_Message_Ndx = 0
			ls_MessageType = ""
			lb_Message = TRUE
			
			//load message array, have complete message when #END MESSAGE label found
			DO WHILE lb_Message 
				
				li_FileRead = FileRead( li_FileNum, ls_line )
				
				IF li_FileRead > 0 THEN
					
//					IF left ( ls_Line, 12 ) = "#END MESSAGE" THEN   
					//Changed 2/22/05 BKW -- START/END MESSAGE are no longer the only entries in the file
					//There is now also START/END POSITION. 
//																		( <<*>> And START/END TEXT ) 
					
					IF Upper ( Left ( ls_Line, 4 ) ) = "#END" AND (left ( ls_Line, 9 ) <> "#END TEXT") THEN  //<<*>> 3/2/05 added the #END TEXT check b.c. that label is included in the
																																		// message loop. Without it we would stop processing once we hit #END TEXT label 
																																		// resulting in excluding the macro data from future processing
						lb_Message = FALSE
						
					ELSE
						
						ll_Message_Ndx ++
						lsa_message[ll_message_Ndx] = ls_Line
						
					END IF
					
				ELSE
					lb_Message = FALSE   //Added 2/22/05 BKW to prevent infinite loop if "#END" value expected is not encountered.
					
				END IF
				
			LOOP
			
			ll_Message_Max = UpperBound ( lsa_Message )
			
			//Get data from message and load into structure
			ll_DataobjectIndex ++
			anva_MsgData[ll_DataobjectIndex] = CREATE n_cst_MessageData
			lnv_CurrentMsg	= anva_MsgData[ll_DataobjectIndex]
//			IF NOT isValid ( lnv_CurrentMsg ) THEN
//				lnv_CurrentMsg = CREATE n_cst_MessageData
//			END IF
			
			
			FOR ll_Message_Ndx = 1 to ll_Message_Max
				
				//Strip label and info
				ll_Pos = Pos ( lsa_Message [ll_Message_Ndx], " ", 1 ) 
				IF ll_Pos > 0 THEN
					//Does this line have a label?
					IF Left ( lsa_Message [ll_Message_Ndx], 1 ) = "#" THEN
						
						ls_Label = Trim ( Left ( lsa_Message [ll_Message_Ndx], ll_Pos ) )
						ls_message = Mid ( lsa_Message [ll_Message_Ndx], ll_Pos + 1, + &
										len ( lsa_Message [ll_Message_Ndx] ) - ll_Pos )
										
					ELSE
						ls_Label = "#TEXT"
						ls_message = lsa_Message [ll_Message_Ndx]
						
					END IF
				ELSE
					//if no space, see if there is text on this line without spaces
					IF Left ( lsa_Message [ll_Message_Ndx], 1 ) = "#" THEN
						//This is a label without data, nothing to do
					ELSE
						ls_Label = "#TEXT"
						ls_message = lsa_Message [ll_Message_Ndx]
						
					END IF
						
//					ls_Label = ""
					
				END IF
				
				IF len ( ls_Label ) = 0 THEN CONTINUE

				CHOOSE CASE ls_Label

					CASE "#MCTNUMBER"	//UnitId	
						lnv_CurrentMsg.of_SetDeviceUnitId ( trim ( ls_message )  )
														
					CASE "#UNITNUM" 	//EquipmentId
						lnv_CurrentMsg.of_SetEquipmentRef ( trim ( ls_message ) )
						
					CASE "#POSDATE"	//LastPositionDate
						lnv_CurrentMsg.of_SetLastPositionDate ( Date(ls_message) )
						
					CASE "#POSTIME"	//LastPositionTime
						lnv_CurrentMsg.of_SetLastPositionTime ( Time(ls_message) )
						
					CASE "#POSITION"	//LastPositionLocation
						lnv_CurrentMsg.of_SetLastPositionLocation ( trim ( ls_message ) )
						
					CASE "#POSLAT"		//LastPositionLat
						lnv_CurrentMsg.of_SetLastPositionLat ( trim ( ls_message ) )
						
					CASE "#POSLON"		//LastPositionLong
						lnv_CurrentMsg.of_SetLastPositionLong ( trim ( ls_message ) )
						
					CASE "#FIELD:1"  	//EventId
						IF isnumber ( ls_message ) THEN
							lnv_CurrentMsg.of_SetEventId ( long(ls_message) )
						ELSE
							lnv_CurrentMsg.of_SetEventId ( ll_Null )
						END IF
						
					CASE "#MACRO"
						
						IF isnumber ( ls_message ) THEN
							IF ls_message = "0" THEN
								//	Freeform message, messagetype is not processed
								lnv_CurrentMsg.of_SetMessageType ( "" )
							END IF
							
							IF lnv_CurrentMsg.of_GetMessageType ( ) = "DIRECTIONS" THEN
								lnv_CurrentMsg.of_SetOutboundTemplate ( "MACRO" + trim ( ls_message ) + ".DOC" )
							ELSE
								lnv_CurrentMsg.of_SetOutboundTemplate ( "" )
							END IF
						END IF			
						
					CASE "#TEXT"		//Text Message
						IF len ( lnv_CurrentMsg.of_GetMessageText( ) ) = 0 THEN
							//This is the first line of text. This is where the macro label would be.
							//let's check this one for message type
							
							IF Pos ( ls_Message, "DEPART", 1 ) > 0 THEN
								
								//Depart Event Type
								lnv_CurrentMsg.of_SetMessageType ( "DEPART" )
							
							ELSEIF Pos ( ls_Message, "ARRIVE", 1 ) > 0 THEN
						
								//Arrive Event Type
								lnv_CurrentMsg.of_SetMessageType ( "ARRIVE" )
								
							ELSEIF Pos ( ls_Message, "DIRECTION", 1 ) > 0 THEN
						
								//Arrive Event Type
								lnv_CurrentMsg.of_SetMessageType ( "DIRECTIONS" )
								
							ELSE
								
								lnv_CurrentMsg.of_SetMessageType ( "" )
								
							END IF	
							
						END IF
						
						//look for tmp #
						ll_pos =  pos ( ls_message, "TMP#-", 1 )
						IF ll_pos > 0 THEN
							//lets look for the number
							ls_Text = right ( ls_message, len (ls_message) - (ll_pos + 4) )
							lnv_CurrentMsg.of_SetShipmentId ( long(ls_message) )
							ll_pos = pos ( ls_Text, "_", 1 ) 
							
							IF ll_pos = 0 THEN
								ll_pos = pos ( ls_Text, " ", 1 ) 
							END IF
							
							IF ll_pos = 0 THEN
								ll_pos = pos ( ls_Text, "~r", 1 ) 
							END IF
							
							IF ll_pos > 0 THEN
								IF isnumber ( left ( ls_Text, ll_pos -1 ) ) THEN
									lnv_CurrentMsg.of_SetShipmentId ( long ( left ( ls_Text, ll_pos -1 ) ) )
								END IF
							END IF
							
						END IF
						lnv_CurrentMsg.of_AppendToMessageText ( " " + trim ( ls_message ) )	
						
					CASE ELSE //Special Fields
						IF Pos(ls_Label, "#FIELD:[") <> 0 THEN
							lnv_CurrentMsg.of_SetSpecialField( ls_Label ,trim(ls_Message))
						END IF		
				END CHOOSE

			NEXT
			
		END IF
		//end get data from message
		
	LOOP
	FileClose(li_FileNum)
END IF
end subroutine

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

private function integer of_setstatusflag (ref string as_file, integer ai_status);Int	li_WriteReturn
Int	li_FileHandle
String	ls_Status
Int	li_Return = 1

li_FileHandle = FileOpen ( as_file , StreamMode! , Write! , Shared!, Replace!)

IF li_FileHandle >= 0 THEN

	CHOOSE CASE ai_status
			
		CASE ci_filefree
			ls_Status = cs_filefree
			
		CASE ci_Fileactive
			ls_Status = cs_Fileactive
			
		CASE ELSE
			li_Return = -1
	END CHOOSE
	
	IF li_Return = 1 THEN
		
		li_WriteReturn = FileWrite ( li_FileHandle , ls_Status )
		IF li_WriteReturn = -1 THEN
			li_Return = -1
		END IF
			
	END IF
	
	FileClose ( li_FileHandle )
	
END IF

RETURN li_Return

end function

public function string of_getextensionpath ();Return "message\qualcomm\outbound\"
end function

on n_cst_bso_communication_qualcomm.create
call super::create
end on

on n_cst_bso_communication_qualcomm.destroy
call super::destroy
end on

event constructor;call super::constructor;
is_DeviceType = n_cst_Constants.cs_CommunicationDevice_Qualcomm
end event

