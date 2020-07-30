$PBExportHeader$n_cst_bso_email_manager.sru
forward
global type n_cst_bso_email_manager from n_cst_bso
end type
end forward

global type n_cst_bso_email_manager from n_cst_bso
end type
global n_cst_bso_email_manager n_cst_bso_email_manager

type variables
MailSession	inv_MailSession
Protected:
oleObject	inv_MailOle

Constant  Int	ci_EML_SUCCESS = 1

end variables

forward prototypes
private function integer of_connecttoemail (maillogonoption ae_logonoption)
private function integer of_downloadmessages (boolean ab_unreadonly, ref n_cst_emailmessage anva_emailmessages[])
private function integer of_disconnect ()
public function integer of_getstatusrequests (ref n_cst_emailmessage anva_requests[])
public function integer of_sendmail (n_cst_emailmessage anv_emailmessage)
public function integer of_markmessageasread (n_cst_emailmessage anv_mailmessage)
private function integer of_resolverecipients (ref mailmessage anv_mailmessage)
public function integer of_getrecipientsfromaddressbook (ref mailrecipient anva_recipients[])
private function integer of_populatesmtpmail (n_cst_emailmessage anv_mailsource)
protected function integer of_adderror (string as_error)
public function integer of_showerrormessages ()
public function integer of_clearerrors ()
public function string of_geterrorstring ()
public function integer of_getemailreplys (ref n_cst_emailmessage anva_requests[], ref n_cst_emailmessage anva_rejects[])
protected function integer of_establishsmtpconnection ()
end prototypes

private function integer of_connecttoemail (maillogonoption ae_logonoption);/***************************************************************************************
NAME: 			of_ConnectToEMail		

ACCESS:			Private
		
ARGUMENTS: 		ae_logonoption:
					mailNewSession!,	mailDownLoad! ,	mailNewSessionWithDownLoad! 

RETURNS:			Int
					     1 = Successfull Connection
						 -1 = Connection Not Established
	
DESCRIPTION:
	This method will connect to the default mail account of the user. If a connection to
	a mail session already exists it will be disconnected.


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	May 16, 2002 Created RPZ

	Oct 14, 2004 Modified to branch to 3rd party connection

***************************************************************************************/
Int				li_Return = 1
Any				la_Value
String			ls_Name
String			ls_PW
Boolean			lb_UseProfile 

n_cst_Settings	lnv_Settings
mailReturnCode le_mRet


THIS.of_disconnect( ) // get rid of any existing connections


IF ae_logonoption = mailNewSession! THEN
	// we will branch to the new code that establishes a connection to a smtp without using MicroSoft MAPI
	li_Return = THIS.of_Establishsmtpconnection( )
ELSE
	IF isValid ( inv_mailSession ) THEN
		inv_mailSession.mailLogoff()
		DESTROY inv_mailSession
	END IF
	
	
	CHOOSE CASE ae_LogonOption
		
		CASE	mailDownLoad! ,	mailNewSessionWithDownLoad! 
			//OK
		CASE ELSE
			li_Return = -1
	END CHOOSE
	
//	IF li_Return = 1 THEN
//		lnv_Settings.of_GetSetting ( 112 , la_Value )
//		ls_Name = String ( la_Value ) 
//		
//		lnv_Settings.of_GetSetting ( 113 , la_Value )
//		ls_PW = String ( la_Value )
//		
//		
//		IF Len ( ls_Name ) = 0 OR Len ( ls_PW ) = 0 THEN
//			lb_UseProfile = FALSE
//		END IF
//	END IF
	
	IF li_Return = 1 THEN
		
		// Create a mail session
		inv_mailSession = CREATE mailSession
	
		// Log on to the session
		IF lb_UseProfile THEN
			le_mRet = inv_mailSession.mailLogon( ls_Name, ls_PW , ae_LogonOption )
	
		ELSE	
			le_mRet = inv_mailSession.mailLogon( ae_LogonOption )
		END IF
	
		IF le_mRet <> mailReturnSuccess! THEN
			li_Return = -1
			inv_mailSession.mailLogoff()
			DESTROY inv_mailSession
		END IF
		
	END IF
	
END IF

RETURN li_Return

end function

private function integer of_downloadmessages (boolean ab_unreadonly, ref n_cst_emailmessage anva_emailmessages[]);/***************************************************************************************
NAME: 			of_DownLoadMessages		

ACCESS:			Private
	
ARGUMENTS: 		ab_UnreadOnly: only get unread messages
					anva_EmailMessages: the messages returned by reference
					
					
RETURNS:			int:
						> -1 : Number of messages
						  -1 : Error
	
DESCRIPTION:
				This Method will process the messages in the inbox and populate 
				e-mail objects and return them by reference

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	May 16, 2002	Created RPZ



***************************************************************************************/

Int	li_Return = 1
Int	li_ConnectionReturn
Int	li_MessageCount 
Int	i

mailMessage 		 	lnv_MailMsg
n_cst_EmailMessage	lnva_Messages[]

li_ConnectionReturn = THIS.of_ConnectToEmail ( mailDownLoad! ) 

IF li_ConnectionReturn <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	inv_MailSession.mailGetMessages ( ab_unreadonly )
	
	li_MessageCount = UpperBound ( inv_MailSession.MessageID[ ] )

	FOR i = 1 TO li_MessageCount
		inv_MailSession.mailReadMessage ( inv_MailSession.MessageID[ i ], lnv_MailMsg , mailEntireMessage!, FALSE )
		lnva_Messages[i].of_Populate ( lnv_MailMsg )
		lnva_Messages[i].of_SetMsgID ( inv_MailSession.MessageID[ i ] )
	NEXT
	
	anva_emailmessages = lnva_Messages
	li_Return = UpperBound ( anva_emailmessages )
	
END IF



RETURN li_Return

end function

private function integer of_disconnect ();IF isValid ( inv_Mailole ) THEN
	inv_MailOle.Disconnect()
	inv_mailole.disconnectobject( )
	DESTROY ( inv_mailole )
END IF

IF IsValid ( inv_MailSession ) THEN
	inv_MailSession.mailLogoff()
	DESTROY inv_MailSession	
END IF

RETURN 1
end function

public function integer of_getstatusrequests (ref n_cst_emailmessage anva_requests[]);/***************************************************************************************
NAME: 			of_GetStatusRequests

ACCESS:			Public
	
ARGUMENTS: 		n_cst_EmailMessage anva_requests[] by reference 

RETURNS:			Int
					    # > -1 = the number of status requests
						     -1 = Error
							  
DESCRIPTION:
		This method will download messages from the server and determine if they are status
		request. It will return any requsts by reference

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	May 16, 2002   CREATED RPZ

***************************************************************************************/

Int	li_Return = 1
Int	li_MessageCount
Int	li_RequestCount
Int	i
Boolean	lb_UnreadOnly = TRUE

n_cst_bso_Notification_Manager	lnv_NoteManager
n_cst_emailMessage 	lnva_Messages[], &
							lnva_Requests[]

lnv_NoteManager = Create n_cst_bso_Notification_Manager


li_MessageCount = THIS.of_DownLoadMessages ( lb_UnreadOnly , lnva_Messages )

IF li_MessageCount = -1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	
	FOR i = 1 TO li_MessageCount
		IF lnva_Messages[i].of_IsStatusRequest ( ) THEN
			
			// if it is a status request then extract the request data from the mail msg
			lnva_Messages[i].of_ProcessRequestData ( )
			IF lnv_NoteManager.of_ApproveStatusRequest ( lnva_Messages[i] ) = 1 THEN
				li_RequestCount ++
				lnva_Requests[ li_RequestCount ] = lnva_Messages[i]
			ELSE
				// request is not approved and we don't want to keep checking it
				This.of_MarkMessageAsRead ( lnva_Messages[i] )
			END IF
			
		END IF
	NEXT
	
	li_Return = li_RequestCount
	anva_Requests = lnva_Requests
	
END IF

DESTROY ( lnv_NoteManager ) 

Return li_Return


end function

public function integer of_sendmail (n_cst_emailmessage anv_emailmessage);Int		li_Return = 1
Int		li_ConnectRtn
int		li_ResolveRtn
String	lsa_Targets[]
Long		ll_Shipment  // used for error reporting

mailReturnCode 		mRet
mailMessage 			lnv_mMsg
THIS.of_Clearerrors( )

ll_Shipment = anv_emailmessage.of_GetShipmentID ( )
IF isNull ( ll_Shipment ) THEN
	ll_Shipment = 0
END IF

//ll_Shipment = anv_emailmessage.il_ShipmentID
// connect to the mail account
li_ConnectRtn = THIS.of_ConnectToEmail ( mailNewSession! ) 
IF li_ConnectRtn <> 1 THEN
	THIS.of_AddError ( "Could not start a new mail session." )
	li_Return = -1
END IF

IF li_Return = 1 THEN
	IF inv_mailole.ClearMessageContents(127) <> ci_eml_success THEN  //127 = clear all
		THIS.of_AddError ( "Could not clear message contents." )
		li_Return = -1
	END IF
END IF

// get the message in a format that can be sent
IF li_Return = 1 THEN
	IF THIS.of_populatesmtpmail( anv_emailmessage ) <> 1 THEN
		THIS.of_AddError ( "Could not populate mail message." )
		li_Return = -1 
	END IF
END IF


IF li_Return = 1 THEN
	IF inv_MailOle.SendMessage ( ) <> ci_eml_success THEN
		IF ll_Shipment > 0 THEN
			THIS.of_AddError ( "Could not send mail message. (Shipment: " + String ( ll_Shipment ) +")" )
		ELSE 
			THIS.of_AddError ( "Could not send mail message." )
		END IF
		li_Return = -1 
	END IF
END IF

//// resolve all the recipients. needed to go through gateways
//IF li_Return = 1 THEN
//	li_ResolveRtn = THIS.of_ResolveRecipients ( lnv_mMsg )
//	IF li_ResolveRtn <> 1 THEN
//		li_Return = -1 
//	END IF
//END IF

// send the message
//IF li_Return = 1 THEN	
//	mRet = inv_mailsession.mailSend( lnv_mMsg )
//	IF mRet <> mailReturnSuccess! THEN
//		li_Return = -1
//	END IF
//END IF
//
//Changed this condition from li_Return = 1  3.5.19 BKW
IF li_ConnectRtn = 1 THEN // <<*>> 
	THIS.of_Disconnect ( ) 
END IF

RETURN li_Return


end function

public function integer of_markmessageasread (n_cst_emailmessage anv_mailmessage);MailMessage	lnv_MailMsg

IF THIS.of_ConnectToEMail ( mailDownLoad! ) = 1 THEN

	inv_MailSession.mailReadMessage ( anv_MailMessage.of_GetMsgID ( ) , lnv_MailMsg , mailEntireMessage!, TRUE )
	
END IF

RETURN  1


end function

private function integer of_resolverecipients (ref mailmessage anv_mailmessage);Int	li_Return = 1
Int	li_RecipCount				//Was unused, now used in 3.5.19
Int	li_ResolvedCount			//Added 3.5.19
Int	li_Index						//Changed name 3.5.19 (was previously unused)

mailMessage 			lnv_mMsg
MailRecipient			lnva_ResolvedRecipients[]		//Added 3.5.19
MailRecipientType		le_RecipientType					//Added 3.5.19


//Begin ResolveRecipient Addition -- 3.5.19 BKW

//Peform ResolveRecipient on each recipient on the message
//This is necessary for mail to go through a mail server like exchange, even for literal addresses.

//I'm doing this here rather than in n_cst_EmailMessage.of_GetMailMessage because a mailsession is needed,
//and we have one here, and we don't have one there, and I don't want to incur the extra overhead of 
//getting and closing a mailsession just to do resolverecipient on the mail message.

//On a local mail system, (where this lookup is actually not needed for a literal address), the lookup
//only takes 1/100 of a second, so there is not much penalty for doing this, and you get the added benefit
//that users can use address book names if they really want to.

lnv_mMsg = anv_mailmessage

IF li_Return = 1 THEN

	li_RecipCount = UpperBound ( lnv_mMsg.Recipient )

	FOR li_Index = 1 TO li_RecipCount

		//Record the RecipientType for cross-check and use below.
		le_RecipientType = lnv_mMsg.Recipient [ li_Index ].RecipientType

		CHOOSE CASE inv_MailSession.MailResolveRecipient ( lnv_mMsg.Recipient [ li_Index ] )

		CASE MailReturnSuccess!

			//As it turns out, under Outlook Express, the call to ResolveRecipient will step on
			//the RecipientType, changing it from MailTo! to MailOriginator! (apparently some kind of low-level bug)
			//So, we need to set it back in these cases.

			IF lnv_mMsg.Recipient [ li_Index ].RecipientType = le_RecipientType THEN
				//OK
			ELSE
				lnv_mMsg.Recipient [ li_Index ].RecipientType = le_RecipientType
			END IF

			//Now, increment li_ResolvedCount and record the recipient in the ResolvedRecipient array.

			li_ResolvedCount ++
			lnva_ResolvedRecipients [ li_ResolvedCount ] = lnv_mMsg.Recipient [ li_Index ]


		END CHOOSE

	NEXT

	lnv_mMsg.Recipient = lnva_ResolvedRecipients

	//If there are no resolved recipients, fail, and do not attempt to send the message

	IF li_ResolvedCount = 0 THEN
		li_Return = -1
	END IF

END IF

//END ResolveRecipient Addition -- 3.5.19 BKW

RETURN li_Return
end function

public function integer of_getrecipientsfromaddressbook (ref mailrecipient anva_recipients[]);Int		li_Return = 1
Int		li_ConnectRtn
int		li_ResolveRtn

mailReturnCode 		le_mRet
mailMessage 			lnv_mMsg

// connect to the mail account
//li_ConnectRtn = THIS.of_ConnectToEmail ( mailNewSession! ) 
// I am calling with mailNewSessionWithDownLoad! because I want to connect to the
// default mail program to access the address book.
li_ConnectRtn = THIS.of_ConnectToEmail ( mailNewSessionWithDownLoad! )
IF li_ConnectRtn <> 1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	le_mRet = inv_mailsession.mailAddress ( lnv_mMsg )

	IF le_mRet <> mailReturnSuccess! THEN
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	anva_Recipients[]	= lnv_mMsg.Recipient
END IF
	
IF li_ConnectRtn = 1 THEN
	THIS.of_Disconnect ( )
END IF


RETURN li_Return
end function

private function integer of_populatesmtpmail (n_cst_emailmessage anv_mailsource);Int		li_Return = 1
Int		i
Int		li_Count
String	lsa_Targets[]
String	lsa_TargetBccs[]
String	ls_Author

ls_Author = anv_MailSource.of_GetAuthor()
IF isNull(ls_Author) OR Len(ls_Author) = 0 THEN
	n_cst_setting_replyemailaddress	lnv_Address
	lnv_Address = CREATE n_cst_setting_replyemailaddress
	ls_Author = lnv_Address.of_Getvalue( )
	Destroy lnv_Address
END IF

MailFileDescription	lnva_Attachment[]
IF NOT isvalid (inv_mailole) THEN
	li_Return = -1
END IF

// add the recipients
IF li_return = 1 THEN
	li_Count = anv_MailSource.of_GetTargetAddresses ( lsa_Targets )
	inv_MailOle.ResetGroup()
	inv_MailOle.SetGroupName("Email")
	FOR i = 1 TO li_Count
		inv_MailOle.AddToGroup(lsa_Targets[i], lsa_Targets[i])	
	NEXT
	inv_MailOle.AddRecipientsGroup(1, TRUE)
END IF

// add bcc recipients
IF li_Return = 1 THEN
	li_Count = anv_MailSource.of_GetTargetBccs(lsa_TargetBccs[])
	inv_MailOle.ResetGroup()
	inv_MailOle.SetGroupName("BCC")
	FOR i = 1 TO li_Count
		inv_MailOle.AddToGroup(lsa_TargetBccs[i], lsa_TargetBccs[i])
	NEXT
	inv_MailOle.AddRecipientsGroup(3, TRUE)
END IF


IF li_Return = 1 THEN
	IF inv_MailOle.AddAuthor( ls_Author, ls_Author ) <> ci_eml_success THEN
		THIS.of_Adderror( "The author of the email could not be set. Make sure your reply address is specified in the System Settings." )
		li_Return = -1
	END IF
END IF

// populate the email body
IF li_Return = 1 THEN
	// The textual body of the message
	inv_MailOle.TextualBodyEncoding = 0  // the object will decide.
	inv_MailOle.TextualBody = anv_MailSource.of_GetBody ( ) 
END IF

// populate the email Subject
IF li_Return = 1 THEN
	inv_MailOle.Subject = anv_MailSource.of_GetSubject ( )	
END IF

//Add the the attachments
IF li_Return = 1 THEN
	anv_MailSource.of_GetAttachments ( lnva_Attachment )	
	li_Count = UpperBound ( lnva_Attachment )
	FOR i = 1 TO li_Count
		IF inv_MailOle.AddAttachment(lnva_Attachment[i].pathname, 2 , lnva_Attachment[i].Filename, "" ) <> ci_eml_success THEN
			THIS.of_Adderror( "The specified attachments could not be added to the email." )
			li_Return = -1
		END IF
	NEXT
	
END IF


RETURN li_Return
end function

protected function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )
lnv_Error.SetMessageHeader ( "Email Manager" )

RETURN 1
end function

public function integer of_showerrormessages ();int 		li_errorCount
int		i
String	ls_ErrorString

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_Errorcollection.GetErrorcount( )

For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() )
next

MessageBox("Email messaging" , ls_ErrorString , EXCLAMATION! )

RETURN 1
end function

public function integer of_clearerrors ();THIS.Clearofrerrors( )
RETURN 1
end function

public function string of_geterrorstring ();int 		li_errorCount
int		i
String	ls_ErrorString

n_cst_OFRError lnva_Error[]
n_cst_OFRError_Collection lnv_ErrorCollection

lnv_ErrorCollection = This.GetOFRErrorCollection ( )
lnv_Errorcollection.GetErrorArray( lnva_Error )
li_ErrorCount = lnv_Errorcollection.GetErrorcount( )

For i = 1 TO li_ErrorCount
	ls_ErrorString += string( lnva_Error[i].getErrorMessage() ) + "~r~n"
next

RETURN ls_ErrorString
end function

public function integer of_getemailreplys (ref n_cst_emailmessage anva_requests[], ref n_cst_emailmessage anva_rejects[]);//
/***************************************************************************************
NAME			: of_GetEmailReplys
ACCESS		: Public
ARGUMENTS	: n_cst_EmailMessage (anva_requests[] by reference)
				: string					(Type of email)
RETURNS		: integer				(Number of requests or -1=Failed)
DESCRIPTION	: This method will download messages from the server and return those that match the 
					as_MessageType. Right now they are AuthorizeRequest type. 
					Return any requsts by reference

REVISION		: RDT 092602
***************************************************************************************/

Integer	li_Return = 1
Integer	li_MessageCount, &
			li_RequestCount, &
			li_RejectCount, &
			i
Boolean	lb_UnreadOnly = TRUE

n_cst_bso_Notification_Manager	lnv_NoteManager
n_cst_emailMessage 	lnva_Messages[], &
							lnva_Requests[], &
							lnva_Rejects[]

n_cst_bso_Document_Manager	lnv_DocMan
lnv_DocMan = create n_cst_bso_Document_Manager

lnv_NoteManager = Create n_cst_bso_Notification_Manager

li_MessageCount = THIS.of_DownLoadMessages ( lb_UnreadOnly , lnva_Messages )

IF li_MessageCount = -1 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN

	FOR i = 1 TO li_MessageCount
		
		IF lnva_Messages[i].of_IsAuthorizationReply( ) THEN
			// if it is an Authorization Reply then extract the request data from the mail msg
			lnva_Messages[i].of_ParseReply ( )

			lnva_Messages[i].of_IsValidAuthorizationReply( ) // process anyway. Error is in message body.
			lnva_Messages[i].of_SetDocumentType(appeon_constant.cs_AuthIN )
			li_RequestCount ++
			lnva_Requests[ li_RequestCount ] = lnva_Messages[i]
			lnva_Requests[ li_RequestCount ].of_GetShipmentId ( )
			lnva_Requests[ li_RequestCount ].of_IsEmail( TRUE )
			lnv_DocMan.of_savedocument ( lnva_Requests[ li_RequestCount ], lnva_Requests[ li_RequestCount ].of_GetShipmentId ( ) )	
			this.of_MarkMessageAsRead ( lnva_Messages[i] )

		END IF

		IF lnva_Messages[i].of_IsStatusRequest ( ) THEN
			// if it is a status request then extract the request data from the mail msg
			IF lnva_Messages[i].of_ProcessRequestData ( ) = 1 THEN

				IF lnv_NoteManager.of_ApproveStatusRequest ( lnva_Messages[i] ) = 1 THEN
					li_RequestCount ++
					lnva_Requests[ li_RequestCount ] = lnva_Messages[i]				
				END IF
			ELSE
				li_RejectCount ++
				lnva_Rejects[ li_RejectCount ] = lnva_Messages[i]				
			END IF
			
			this.of_MarkMessageAsRead ( lnva_Messages[i] )
			
		END IF

	NEXT
	
	li_Return = li_RequestCount
	anva_Requests = lnva_Requests
	anva_Rejects = lnva_Rejects
	
END IF

DESTROY lnv_NoteManager
DESTROY lnv_DocMan

Return li_Return

end function

protected function integer of_establishsmtpconnection ();Int				li_Return = 1
String			ls_Server
Boolean			lb_UseProfile 
String			ls_Name
String			ls_Pw
Any				la_Value
n_cst_Settings	lnv_Settings

IF isValid ( inv_mailole ) THEN
	inv_mailole.Disconnect()
	inv_mailole.disconnectobject( )
	DESTROY inv_mailole
END IF

IF li_Return = 1 THEN
	// Create a mail session
	inv_mailole = CREATE OleObject
	IF inv_mailole.ConnectToNewObject( "LEADeMail.LEADSmtp.20" ) <> 0 THEN
		// we could not connect
		THIS.of_AddError ( "Could not connect to ole object" )
		li_Return = -1
		Destroy ( inv_mailole )
	END IF
END IF

IF li_Return = 1 THEN
	n_cst_setting_smtpserver	lnv_MailServerSetting
	lnv_MailServerSetting = CREATE n_cst_setting_smtpserver
	ls_Server = lnv_MailServerSetting.of_GetValue( )
	DESTROY ( lnv_MailServerSetting )
	
	IF Len (ls_Server) > 0 THEN
		inv_mailole.ServerAddress = ls_Server // i.e. mail.Profittools.net 
		inv_mailole.ServerPort = 25	// default
		inv_mailole.Timeout = 60   // standard. we may need to increase this or send a NOOP to
											// keep the connection active.
	ELSE
		THIS.of_AddError ( "SMTP Server address has not been specified. (system setting)" )
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF inv_mailole.Connect ( ) <> ci_eml_success THEN
		THIS.of_AddError ( "Could not connect to mail server. The most probable cause is that your email server requires authentication. Additional settings will need to be specified in the System Settings." )
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN

	lnv_Settings.of_GetSetting ( 112 , la_Value )
	ls_Name = String ( la_Value ) 
	
	lnv_Settings.of_GetSetting ( 113 , la_Value )
	ls_PW = String ( la_Value )
		
	IF Len ( ls_Name ) > 0 AND Len ( ls_PW ) > 0 THEN
		lb_UseProfile = TRUE
	END IF
	
	IF lb_UseProfile THEN
		// If the SMTP server requires authentication...   
		inv_mailole.UserName = ls_Name
		inv_mailole.Password = ls_PW   
		IF inv_mailole.Login() <> ci_eml_success THEN
			THIS.of_AddError ( "Could not login to server." )
			li_Return = -1
		END IF
	END IF
END IF



RETURN li_Return
end function

on n_cst_bso_email_manager.create
call super::create
end on

on n_cst_bso_email_manager.destroy
call super::destroy
end on

event destructor;call super::destructor;THIS.of_Disconnect ( )
end event

