$PBExportHeader$n_cst_emailmessage.sru
$PBExportComments$[n_cst_Document]
forward
global type n_cst_emailmessage from n_cst_document
end type
end forward

global type n_cst_emailmessage from n_cst_document autoinstantiate
end type

type variables
CONSTANT String cs_StatusRequest = "STATUSREQUEST"
CONSTANT String cs_AuthorizationReply = "AUTHORIZATIONREPLY"


Private:
String	isa_Addresses[]
String	isa_BccAddresses[]
String	is_Originator
String	is_Subject
String	is_Body
String	is_MsgID
String	is_Author

Long	ila_ContactIds[]
Long	il_RequestingCoId

mailFileDescription	inva_Attachments[]
mailRecipient	inva_Recipient[]
end variables

forward prototypes
public function integer of_addtargetaddress (string as_address)
public function integer of_gettargetaddresses (ref string asa_targetaddresses[])
public function integer of_setbody (string as_BodyText)
public function string of_getbody ()
public function int of_setsubject (string as_Subject)
public function string of_getsubject ()
public function string of_gettemplate ()
public function int of_settemplate (string as_Template)
public function long of_getrequestingcompanyid ()
public function int of_setrequestingcompanyid (Long al_CoID)
public function integer of_populate (mailmessage anv_mailmsg)
private function integer of_processrecipients (mailRecipient anva_Recipients[])
public function boolean of_isstatusrequest ()
public function integer of_processrequestdata ()
public function integer of_setshipmentid (long al_ShipmentID)
public function integer of_addtargets (string asa_emailtargets[])
public function integer of_getattachments (ref mailfiledescription anva_filedescription[])
public function mailmessage of_getmailmessage ()
public function integer of_setmsgid (string as_id)
public function string of_getmsgid ()
public function integer of_getaddresscount ()
public function integer of_processattachments (mailfiledescription anva_filedescriptions[])
public function integer of_addtargetcontactids (long ala_ids[])
public function integer of_addtargetcontactid (long al_id)
public function integer of_gettargetids (ref long ala_contacts[])
public function boolean of_isauthorizationreply ()
public function boolean of_isvalidauthorizationreply ()
public function integer of_parsereply ()
public function integer of_resettargetaddresses ()
public function integer of_addtargetbcc (string as_address)
public function integer of_addtargetsbcc (string asa_targets[])
public function integer of_gettargetbccs (ref string asa_targetbccs[])
public function integer of_setauthor (string as_author)
public function string of_getauthor ()
end prototypes

public function integer of_addtargetaddress (string as_address);Int				i
String			lsa_Addresses[]
n_cst_String	lnv_Sring

// RDT 4-1-03
If IsNull( as_address) Then 
	// do nothing
Else
	
	lnv_Sring.of_Parsetoarray( as_address , ';' , lsa_Addresses )
	FOR i = 1 TO UpperBound ( lsa_Addresses )		
	
		isa_addresses[ UpperBound ( isa_addresses ) + 1 ] = Trim ( lsa_Addresses[i] ) 
		
	NEXT
	
End If

Return 1
end function

public function integer of_gettargetaddresses (ref string asa_targetaddresses[]);// REVISIONS: 
//rdt 092602 Changed lds_Contacts to be n_ds
//				 Added test for UpperBound( ila_contactids[] )


String	lsa_Addresses[]
Long		ll_RowCount
Long		i

//DataStore	lds_Contacts				// rdt 092602
//lds_Contacts = CREATE DataStore	// rdt 092602
n_ds 	lds_Contacts						// rdt 092602
lds_Contacts = CREATE n_ds				// rdt 092602


lds_Contacts.DataObject = "d_notificationrecipients"
lds_Contacts.SetTransObject ( SQLCA )

If UpperBound( ila_contactids[] ) > 0 Then 		// rdt 092602
	ll_RowCount = lds_Contacts.Retrieve ( ila_contactids[]  )
	FOR i = 1 TO ll_RowCount 
		lsa_Addresses [i] = lds_Contacts.GetItemString ( i , "ct_emailaddress" )
	NEXT

Else	 														// rdt 092602 
	ll_RowCount = UpperBound ( isa_addresses[] )			
	FOR i = 1 TO ll_RowCount 
		lsa_Addresses [UpperBound ( lsa_Addresses ) + 1 ] = isa_addresses [ i ]
	NEXT
	
End If 														// rdt 092602 

Destroy ( lds_Contacts )

asa_TargetAddresses[] = lsa_Addresses[]

RETURN UpperBound ( asa_TargetAddresses )
end function

public function integer of_setbody (string as_BodyText);is_Body = as_BodyText

RETURN 1
end function

public function string of_getbody ();RETURN is_Body
end function

public function int of_setsubject (string as_Subject);is_Subject = as_Subject
RETURN 1
end function

public function string of_getsubject ();Return is_Subject
end function

public function string of_gettemplate ();RETURN is_Template
end function

public function int of_settemplate (string as_Template);is_Template = as_Template
Return 1
end function

public function long of_getrequestingcompanyid ();Return il_RequestingCoID
end function

public function int of_setrequestingcompanyid (Long al_CoID);il_RequestingCoID = al_CoID
Return 1
end function

public function integer of_populate (mailmessage anv_mailmsg);mailRecipient			lnva_mailRecipient[]
mailFileDescription	lnva_mailFileDescription[]

Int	li_Return = 1

// get the body of the e-mail
is_body = anv_MailMsg.NoteText

// get the subject
is_Subject = anv_MailMsg.Subject


// get the addresses from the email
THIS.of_ProcessRecipients ( anv_MailMsg.Recipient[ ]	)

// get any attachments
THIS.of_ProcessAttachments ( anv_MailMsg.AttachmentFile[ ] )



RETURN li_Return
end function

private function integer of_processrecipients (mailRecipient anva_Recipients[]);inva_recipient[] = anva_Recipients[]

RETURN 1

end function

public function boolean of_isstatusrequest ();/***************************************************************************************
NAME: 			of_IsStatusRequest

ACCESS:			Public
	
ARGUMENTS: 		NONE

RETURNS:			Boolean	
			
	
DESCRIPTION:
			This method looks at the subject line of the email and if it contains 
			as a substring STATUSREQUEST then this method will return TRUE else FALSE

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	May 16, 2002 CREATED	RPZ




***************************************************************************************/
Boolean	lb_return 
String	ls_Working


ls_Working = UPPER ( THIS.of_GetSubject ( ) )

IF Pos ( ls_Working , cs_StatusRequest ) > 0  THEN
	lb_Return = TRUE 
END IF

RETURN lb_Return
end function

public function integer of_processrequestdata ();/***************************************************************************************

NAME: 			of_ProecessRequestData

ACCESS:			Public
	
ARGUMENTS: 		NONE

RETURNS:			Int
	
DESCRIPTION:	
			This method will parse the email message and determine the information need to
			validate the request.
			i.e. populate the company id making the request
				  get the return address from the body
				  get shipment id from the body


COMPANY ID
SHIPMENT ID
RETURN ADDRESS


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	May 16, 2002   CREATED RPZ




***************************************************************************************/

CONSTANT String	cs_FieldDelimiter = "~r~n"
CONSTANT String   cs_ValueDelimiter = "="

Int		li_Return 
String	ls_EmailAddress
String	ls_Working
String	lsa_FieldResults[]
String	lsa_ValueResults[]
String	lsa_Result[]  
Long		ll_CoID
Int		li_FieldCount
Int		i
Int		li_ExpectedValues = 3
Int		li_ReceivedValues
String	ls_invoiceNumber
String	ls_RefValue
Long		ll_ShipmentID
n_cst_ShipmentManager	lnv_ShipMan
String	ls_ErrorMessage	// this is what we will send back if the request was not successful


li_Return = 1

n_cst_String	lnv_String

ls_Working = THIS.is_Body

// get the fields from the email
li_FieldCount = lnv_String.of_ParseToArray ( ls_Working , cs_FieldDelimiter , lsa_FieldResults )

IF li_FieldCount >= 3 THEN
	
	FOR i = 1 TO UpperBound ( lsa_FieldResults )
		IF lnv_String.of_ParseToArray ( lsa_FieldResults [i] , cs_ValueDelimiter ,lsa_Result ) > 1 THEN
			CHOOSE CASE Upper ( Trim ( lsa_Result[1] ) )
					
				CASE "PWD"
					IF isNumber ( Trim ( lsa_Result[2] ) )THEN
						THIS.of_SetRequestingCompanyID ( Long ( lsa_Result[2] ) )
						li_ReceivedValues ++
					ELSE
						li_Return = -1
					END IF
					
				CASE "SHIPMENT"
					IF isNumber ( Trim ( lsa_Result[2] ) )THEN
						//THIS.il_ShipmentID = Long (lsa_Result [2] )
						ll_ShipmentID = Long (lsa_Result [2] )
						li_ReceivedValues ++
					ELSE
						li_Return = -1
					END IF
										
				CASE "RESPONSE"
					THIS.of_AddTargetAddress (Trim (  lsa_Result[2] ) )
					li_ReceivedValues ++
					
				CASE "INVOICE"
					ls_InvoiceNumber = Trim ( lsa_Result[2] )
					ll_ShipmentID = lnv_ShipMan.of_findshipmentbyinvoicenumber( ls_invoiceNumber )
					IF ll_ShipmentID > 0 THEN
						li_ReceivedValues ++
					ELSE
						li_Return = -1
						ls_ErrorMessage = "Your request by invoice '" + ls_invoiceNumber + "' could not be processed."

					END IF
					
				CASE "REFERENCE"
					ls_RefValue = Trim ( lsa_Result[2] )
					ll_ShipmentID = lnv_ShipMan.of_FindShipmentbyreftext( ls_RefValue ,  TRUE /*boolean ab_excludeequipmenttypes */)
					IF ll_ShipmentID > 0 THEN
						li_ReceivedValues ++
					ELSE
						li_Return = -1
						ls_ErrorMessage = "Your request by reference '" + ls_RefValue + "' could not be processed."
					END IF
					
			END CHOOSE
		END IF
		
	NEXT
					
ELSE
	li_Return = -1
END IF


IF ll_ShipmentID > 0 AND li_ReceivedValues = li_ExpectedValues THEN
	il_shipmentid = ll_ShipmentID
END IF

IF li_Return = -1 THEN
	THIS.of_SetBody( ls_ErrorMessage )
	THIS.of_SetSubject( "Status Request Failure" )
END IF

RETURN li_Return
end function

public function integer of_setshipmentid (long al_ShipmentID);il_ShipmentID = al_ShipmentID
RETURN 1
end function

public function integer of_addtargets (string asa_emailtargets[]);Int	li_TargetCount 
Int	i

li_TargetCount = UpperBound( asa_EmailTargets[] )


FOR i = 1 TO li_TargetCount 
	THIS.of_AddTargetAddress ( asa_EmailTargets[i] )
NEXT

RETURN 1
end function

public function integer of_getattachments (ref mailfiledescription anva_filedescription[]);anva_filedescription[] = inva_attachments[]
RETURN UpperBound ( anva_FileDescription )
end function

public function mailmessage of_getmailmessage ();int		li_Return = 1
Int		i
Int		li_RecipCount
String	lsa_Targets[]

MailMessage lnv_mMsg
MailFileDescription	lnva_Attachment[]

// add the recipients
IF li_return = 1 THEN
	li_RecipCount = THIS.of_GetTargetAddresses ( lsa_Targets )
	FOR i = 1 TO li_RecipCount
		lnv_mMsg.Recipient[i].name = lsa_Targets[i]
		lnv_mMsg.Recipient[i].address = lsa_Targets[i]
		lnv_mMsg.Recipient[i].RecipientType = mailTo!
	NEXT
END IF


// populate the email body
IF li_Return = 1 THEN
	lnv_mMsg.NoteText = THIS.of_GetBody ( )	
END IF

// populate the email Subject
IF li_Return = 1 THEN
	lnv_mMsg.Subject = THIS.of_GetSubject ( )	
END IF


//Add the the attachments
IF li_Return = 1 THEN
	THIS.of_GetAttachments ( lnva_Attachment )	
	lnv_mMsg.AttachmentFile = lnva_Attachment
END IF

RETURN lnv_mMsg
end function

public function integer of_setmsgid (string as_id);is_msgid = as_id
RETURN 1
end function

public function string of_getmsgid ();RETURN is_MsgID
end function

public function integer of_getaddresscount ();
String	lsa_Addresses[]											
RETURN THIS.of_GetTargetAddresses ( lsa_Addresses ) 
// RDT 092602
// of_GetTargetAddresses also adds addresses to the array. Should this be changed to only return the number of addresses?
//Return UpperBound( isa_addresses[] )
end function

public function integer of_processattachments (mailfiledescription anva_filedescriptions[]);inva_attachments[] = anva_FileDescriptions[]

RETURN 1
end function

public function integer of_addtargetcontactids (long ala_ids[]);Int	li_TargetCount 
Int	i

li_TargetCount = UpperBound( ala_ids[] )

FOR i = 1 TO li_TargetCount 
	THIS.of_AddTargetContactid ( ala_ids[i] )
NEXT

RETURN 1


end function

public function integer of_addtargetcontactid (long al_id);
ila_contactids[ UpperBound ( ila_contactids ) + 1 ] = al_id
Return 1
end function

public function integer of_gettargetids (ref long ala_contacts[]);ala_Contacts[] = ila_contactids[]
RETURN UpperBound ( ala_Contacts )
end function

public function boolean of_isauthorizationreply ();//
/***************************************************************************************
NAME			: of_IsAuthorizationReply
ACCESS		: Public
ARGUMENTS	: NONE
RETURNS		: Boolean
DESCRIPTION	: This method looks at the subject line of the email.
					If it contains a substring of cs_AuthorizationReply then method will 
					return TRUE else it returns FALSE

REVISION		: RDT 092602
***************************************************************************************/

Boolean	lb_Return 
String	ls_Working

ls_Working = UPPER ( THIS.of_GetSubject ( ) )

IF Pos ( ls_Working , this.cs_AuthorizationReply ) > 0  THEN
	lb_Return = TRUE 
else
	lb_Return = FALSE
END IF

RETURN lb_Return

end function

public function boolean of_isvalidauthorizationreply ();//
/***************************************************************************************
NAME			: of_IsValidAuthorizationReply
ACCESS		: Public
ARGUMENTS	: 
				: 
RETURNS		: Boolean 	True = Reply passes validation  
								False= Reply fails validation  
DESCRIPTION	: Validates the authorization reply
				  Validation: company is the bill to on the shipment 
				  If it is not an error message is added to the body.
				  il_Company id and il_Shipment id should have been set already 
			  
REVISION		: RDT 092602
***************************************************************************************/
Boolean 	lb_Return
Long		ll_Id


SELECT "current_shipment_list"."ds_id"
    INTO :ll_Id   
    FROM "current_shipment_list"  
   WHERE ( "current_shipment_list"."ds_id" = :il_Shipmentid ) AND  
         ( "current_shipment_list"."ds_billto_id" = :il_companyid )   ;

	CHOOSE CASE SQLCA.SqlCode
		CASE 0
			COMMIT ;
			lb_Return = TRUE
		CASE ELSE
			ROLLBACK ;
			lb_Return = FALSE
			is_body = "ERROR. BILLTO ID DOES NOT MATCH SHIPMENT ~n~r~n~r" + is_Body
	END CHOOSE

Return lb_Return

end function

public function integer of_parsereply ();//
/***************************************************************************************
NAME			: of_ParseReply
ACCESS		: Private
ARGUMENTS	: String		(Reply)
RETURNS		: Integer	(ci_success, ci_failure)
DESCRIPTION	: Parses the email message and loads the instance variables with the parsed values.

Sent to Standard IO
//http://www.StandardIO.com/ProfitTools?rsp=auth&ans=ACCEPT&rtn=rtremblay@ProfitTools.net&shp=103233&com=9

StandardIO sends 
From: standard io
TO: jkid@tonka.com
Subject: AUTHORIZATIONREPLY

ans: ACCEPT
rtn: rtremblay@ProfitTools.net
shp: 103233
com: 9 
ref: 123456789 

Read each line of the email and validate the ship# with the company.
Use document manager to store message in directory.
***************************************************************************************
REVISION		: 
	RDT 012203 initial version
	RDT 3-6-03 Added Reference number

***************************************************************************************/
String	ls_FieldDelimiter = "~r~n"
String   ls_ValueDelimiter = ":"

String	lsa_FieldResults[], &
			lsa_ResultValues[], &
			lsa_Result[], &
			ls_Working, & 
			ls_responceType, & 
			ls_returnaddress 

Integer	li_i, &
			li_Return , &
			li_FieldCount

li_Return = ci_success

n_cst_String	lnv_String

ls_Working = lnv_String.of_Trim( THIS.is_Body )

//ls_Working = lnv_String.of_RemoveNonPrint( ls_Working )   //caution: this will remove the cr/lf
//ls_Working = lnv_String.of_RemoveWhiteSpace( ls_Working ) //caution: this will remove the cr/lf

If Len( ls_Working ) > 0 Then 
	
	li_FieldCount = lnv_String.of_ParseToArray ( ls_Working , ls_FieldDelimiter , lsa_FieldResults )
	/* array:  [1]=ans:ACCEPT [2]=rtn:rtremblay@ProfitTools.net [3]=shp:103233 [4]=com:9 [5]=Comment: asdfghjkl	*/
	FOR li_i = 1 TO li_FieldCount 
		
		IF lnv_String.of_ParseToArray ( lsa_FieldResults [li_i] , ls_ValueDelimiter ,lsa_Result ) > 1 THEN
		/* array:  [1]=ans [2]=ACCEPT		*/		
		
			Choose Case UPPER( lsa_Result[1] )
					
				Case "ANS"
					If Trim( Upper( lsa_Result[2] ) ) = "ACCEPT" Then 
						is_AcceptDeny = "A" 
					Else
						is_AcceptDeny = "D" 
					End if
					
				Case "SHP"
					il_shipmentid = Long( lsa_Result[2] )
					
				Case "COM"
					il_companyid  = Long( lsa_Result[2] ) 
					
				Case	"REF"
					is_ReferNumber  = lsa_Result[2] 

				Case Else
					// do nothing
					
			End Choose	
			
		End IF
		
	NEXT

Else
	li_Return = ci_failure

End If

Return li_Return 

end function

public function integer of_resettargetaddresses ();// of_resettargetaddresses

String ls_Blank[]

isa_Addresses[] = ls_blank[]

RETURN 1
end function

public function integer of_addtargetbcc (string as_address);IF Not IsNull( as_address) THEN 
	isa_BccAddresses[ UpperBound ( isa_BccAddresses ) + 1 ] = Trim ( as_Address) 
END IF

Return 1
end function

public function integer of_addtargetsbcc (string asa_targets[]);Int	li_TargetCount 
Int	i

li_TargetCount = UpperBound( asa_Targets[] )


FOR i = 1 TO li_TargetCount 
	THIS.of_AddTargetBCC ( asa_Targets[i] )
NEXT

RETURN 1
end function

public function integer of_gettargetbccs (ref string asa_targetbccs[]);String	lsa_Addresses[]
Long		ll_RowCount
Long		i

ll_RowCount = UpperBound ( isa_BccAddresses[] )			
FOR i = 1 TO ll_RowCount 
	lsa_Addresses [UpperBound ( lsa_Addresses ) + 1 ] = isa_BccAddresses[i]
NEXT

asa_TargetBccs[] = lsa_Addresses[]

RETURN UpperBound ( asa_TargetBccs[] )
end function

public function integer of_setauthor (string as_author);is_Author = as_Author
Return 1
end function

public function string of_getauthor ();Return is_Author
end function

on n_cst_emailmessage.create
call super::create
end on

on n_cst_emailmessage.destroy
call super::destroy
end on

