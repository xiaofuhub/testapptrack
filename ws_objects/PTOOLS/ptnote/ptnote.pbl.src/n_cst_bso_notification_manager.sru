$PBExportHeader$n_cst_bso_notification_manager.sru
$PBExportComments$[n_cst_bso]
forward
global type n_cst_bso_notification_manager from n_cst_bso
end type
end forward

global type n_cst_bso_notification_manager from n_cst_bso
end type
global n_cst_bso_notification_manager n_cst_bso_notification_manager

type variables
n_cst_bso_Dispatch	inv_Dispatch

Constant string cs_status_Active = 'K'
Constant string cs_status_Hidden = 'H'

Constant int ci_status_Pending = 0
Constant int ci_status_Error = -1
Constant int ci_status_NoAddr = -3
Constant int ci_status_Success = 1

n_ds 	ids_NoteStatus      		       
String		   is_DocumentType       // rdt 092602
String		   is_ErrorMessage         // rdt 110702
end variables

forward prototypes
private function integer of_getshipment (n_cst_emailmessage anv_mailmsg, ref n_cst_beo_shipment anv_shipment)
private function integer of_populateemail (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmessage)
private function integer of_populateemailtargets (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmessage)
private function integer of_gettemplate (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_mailmsg)
private function integer of_populateemailsubject (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmsg)
private function integer of_populateemailbody (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmsg)
public function integer of_processstatusrequests ()
private function integer of_processstatusrequest (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmessage)
private function n_cst_bso_dispatch of_getdispatchobject ()
public function integer of_approvestatusrequest (n_cst_emailmessage anv_mailmessage)
public function integer of_newcontact (string as_firstname, string as_middlename, string as_lastname, string as_emailaddress, long al_coid)
public function long of_getnewcontactid ()
public function integer of_assigncontacttocompany (long al_contactid, long al_companyid)
public function long of_getidfromemailaddress (string as_emailaddress)
private function long of_getnewnotificationid ()
public function integer of_processnotificationrequest (pt_n_cst_beo anv_ptbeo)
private function integer of_gettemplateforcompany (ref n_cst_emailmessage anv_emailmessage)
public function integer of_clearaddresses ()
public function integer of_startstatusrequestservice ()
public function integer of_stopstatusrequestservice ()
public function boolean of_isstatusrequestrunning ()
private function integer of_getimagepaths (long al_shipmentid, long al_companyid, ref string asa_filepaths[])
public function long of_getcontactsnotified (pt_n_cst_beo anv_beo, ref long ala_contactids[])
public function integer of_creatependingnotification (pt_n_cst_beo anv_ptbeo)
public function long of_getnextstatusid ()
private function integer of_sendnotification (string as_topic, long al_id, ref string as_errorstring)
public function integer of_sendpendingnotifications ()
public function integer of_removependingnotification (pt_n_cst_beo anv_ptbeo)
public function integer of_checknotificationstatus (pt_n_cst_beo anv_ptbeo)
public function string of_getnotificationerror (pt_n_cst_beo anv_ptbeo)
public function integer of_processnotificationrequest (pt_n_cst_beo anv_ptbeo, boolean ab_ignoresetting, ref string as_errorstring)
private function long of_getshipmentid (pt_n_cst_beo anv_beo)
public function integer of_validaterequestrole (n_cst_beo_company anv_company, n_cst_beo_shipment anv_shipment)
public function integer of_setdefaulttemplate (ref n_cst_emailmessage anv_emaildoc)
private function integer of_processattachments (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_mailmsg)
private function integer of_setcontacts (ref pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessage)
private function integer of_setcompany (ref pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessageorig, ref n_cst_emailmessage anva_emailmessage[])
public function integer of_createemaildocument_old (pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessage)
public function integer of_createemaildocument (ref pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessage, ref n_cst_emailmessage anva_emailmessage[])
private function integer of_processnotificationrequest (pt_n_cst_beo anv_ptbeo, n_cst_emailmessage anv_emailmsg, ref n_cst_emailmessage anva_emailmsg[])
public function integer of_eventcompanycontact (readonly long al_companyid, ref n_cst_beo_event anv_event, boolean ab_add)
public function integer of_updatenotificationtable ()
private subroutine of_setwhereclause (ref n_ds ands_datastore, readonly string as_topic, readonly long al_sourceid, readonly string as_doctype)
public subroutine of_setwherepending (ref n_ds ands_datastore)
public function integer of_updatespending ()
public function integer of_updatespending (n_cst_bso_dispatch anv_dispatch)
public function integer of_removeunwarrantednotifications (n_cst_bso_dispatch anv_dispatch)
private function integer of_logerror (string as_Error)
public function boolean of_iscompanyevent (readonly long al_companyid, readonly n_cst_beo_event anv_event)
public function integer of_checkforaccessorialnotifications (n_cst_bso_dispatch anv_dispatch)
protected function integer of_adderror (string as_error)
public function string of_geterrorstring ()
protected function integer of_sendfailurenotification (n_cst_emailmessage anv_mailmsg)
end prototypes

private function integer of_getshipment (n_cst_emailmessage anv_mailmsg, ref n_cst_beo_shipment anv_shipment);// Modified to get the shipment based on additional parameters in the submitted email.
/*

	Search by Invoice Number

	Search by Reference number.
	Profit Tools will search for a shipment containing the specified reference number 
	in any of the 3 primary reference fields. Profit Tools will explicitly exclude equipment 
	numbers from the return set. That is, if the label associated with a matching reference 
	number is an equipment label, the shipment will not be considered a match.
	
	In the event that the shipment could not be found or more than one shipment satisfies the 
	search criteria, Profit Tools will send a reply stating that the search criteria could not 
	be resolved and they should contact the office by other means.


*/



Int	li_Return = -1
Long	ll_ShipmentID
n_cst_beo_Shipment	lnv_Shipment
n_cst_bso_dispatch	lnv_Dispatch
// dataStore	lds_Cache  			// rdt 092602 
n_ds lds_Cache							// rdt 092602 

DESTROY ( anv_shipment )
lnv_Shipment = CREATE n_cst_beo_Shipment

// get a pointer to the instance
lnv_Dispatch = THIS.of_GetDispatchObject ( ) 

ll_ShipmentID = anv_MailMsg.of_GetShipmentID ( ) 

IF ll_ShipmentID > 0 THEN
	
	lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
	lds_Cache = lnv_Dispatch.of_GetShipmentCache ( ) 
	lnv_Shipment.of_SetSource ( lds_Cache )
	lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
	lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
	lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) ) 
	
	IF lnv_Shipment.of_HasSource ( ) THEN
		li_Return = 1 
		anv_Shipment = lnv_Shipment
	END IF
	
END IF


Return li_Return 
	
end function

private function integer of_populateemail (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmessage);/***************************************************************************************
NAME: 			

ACCESS:			
	
ARGUMENTS: 		

RETURNS:			
	
DESCRIPTION:
			When this method is complete, the email object will have targets, 
			subject and body / attachments populated.

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :

RDT 092602 Should not be called 


***************************************************************************************/
Messagebox("Program Error","Call to obsolete function ~nappeon_constant.of_PopulateEmail." &
					+ " ~nThis has been replaced by of_CreateEmailDocument() " )
Int	li_Return = -1
RETURN li_Return

// RDT 092602 Code below commented out 

//// determine who the email is going to
//IF THIS.of_populateEmailTargets ( anv_ptbeo , anv_emailmessage ) <> 1 THEN
//	li_Return = -1
//END IF
//
//IF li_Return = 1 THEN
//	// get the template that should be populated
//	IF THIS.of_GetTemplate ( anv_ptbeo , anv_emailmessage ) <> 1 THEN
//		li_Return = -1
//	END IF
//END IF
//
//IF li_Return = 1 THEN
//	IF THIS.Of_PopulateEmailSubject (anv_ptbeo , anv_emailmessage ) <> 1 THEN
//		li_Return = -1
//	END IF
//END IF
//	
//IF li_Return = 1 THEN
//	IF THIS.Of_PopulateEmailBody (  anv_ptbeo , anv_emailmessage ) <> 1 THEN
//		li_Return = -1
//	END IF
//END IF
//	
//IF li_Return = 1 THEN
//	IF THIS.of_ProcessAttachments ( anv_ptbeo , anv_emailmessage ) <> 1 THEN
//		li_Return = -1
//	END IF
//END IF
//
//RETURN li_Return
end function

private function integer of_populateemailtargets (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmessage);
Long	lla_EmailTargets[]

anv_ptBeo.of_GetNotificationTargets ( lla_EmailTargets )
anv_EmailMessage.of_addtargetcontactids ( lla_EmailTargets )

RETURN 1


end function

private function integer of_gettemplate (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_mailmsg);// this should be obsolete and be replaced by n_cst_companies.of_SetTemplateOnDocument()
Messagebox("Program error","Call to n_cst_Notoficationmanager.of_GetTemplate() " & 
				+"~n should be changed to call ~n n_cst_companies.of_SetTemplateOnDocument()" )

Int		li_Return = -1
String	ls_Template

ls_Template = anv_ptBeo.of_GetNotificationTemplate ( )

IF Len ( ls_Template ) > 0 THEN
	anv_MailMsg.of_SetTemplate ( ls_Template )
	li_Return = 1 
END IF

RETURN li_Return
end function

private function integer of_populateemailsubject (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmsg);Int		li_Return = 1
String	ls_Subject

ls_Subject = anv_PtBeo.of_GetNotificationSubject ( ) 

IF len ( ls_Subject ) > 0 THEN
	anv_EmailMsg.of_SetSubject ( ls_Subject ) 
	li_Return = 1 
END IF

Return li_Return
end function

private function integer of_populateemailbody (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmsg);/***************************************************************************************

NAME: 			of_PopulateEmailBody
	
ACCESS:			Private
	
ARGUMENTS: 		anv_ptbeo
					anv_emailmsg
RETURNS:			Int	
							 1 = Success
							-1 = Failure
DESCRIPTION:
				This method will take a emailMessage object that has been partly populated
				and utilize that information to populate the body of the email with the 
				proper information.
//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
***************************************************************************************/
Int		li_Return = 1
String	ls_Topic
String	ls_template
String	ls_Body
Boolean	lb_Display
Boolean	lb_IncludeForm
Any		laa_Beo []
Any		laa_Data []
Int		li_CreateRtn

n_cst_string				lnv_String
n_cst_Msg					lnv_Msg
n_cst_Bso_ReportManager	lnv_ReportManager

ls_Topic = anv_ptbeo.of_GetTopic ( ) 
ls_Template = anv_emailmsg.of_GetTemplate ( )
lb_IncludeForm = TRUE
lb_Display = FALSE

laa_Beo [1] = anv_ptbeo

IF li_Return = 1 THEN
	li_CreateRtn = lnv_ReportManager.of_createReport ( ls_topic, ls_Template , laa_Beo, lb_display, & 
						                  lb_includeform, laa_Data , lnv_Msg )
	IF li_CreateRtn <> 1 THEN
		li_Return = -1
	END IF

END IF

IF li_Return = 1 THEN
	// at this point we should have the requested data, so we will transfer it to the 
	// body of the email
	
	Long	ll_Count 
	long	i
	ll_Count = UpperBound ( laa_data )
	FOR i = 1 TO ll_Count
		ls_Body += String ( laa_Data[i] )
		IF i < ll_Count THEN
			ls_Body += "~r~n" 
		END IF
	NEXT
	
	anv_emailmsg.of_setbody ( ls_Body )	
	
END IF


RETURN li_Return


end function

public function integer of_processstatusrequests ();/***************************************************************************************
NAME: 			of_ProcessStatusRequests

ACCESS:			Public
	
ARGUMENTS: 		None

RETURNS:			Int
							 1 = Success
							-1 = Error
	
DESCRIPTION:
	This method will look in the inbox for any emails that are requesting a status update.
	An email that is requesting a shipment status will have submitted their system id. 
	This id will be used to determine the company requirements for the status request.
	
	Currently we are responding to shipment statusrequests.
	This method will hand of the shipment beo to the of_ProcessNotificatoinRequest ( ) 
	method. It will call the overloaded version with a partially populated email. 
	the included information will include the target address as well as 
	the requesting company id.


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :

	May 17, 2002  CREATED RPZ
	
***************************************************************************************/

Int	li_Return = 1
Int	li_RequestCount
Int	i
Long	ll_ShipmentID

n_cst_bso_EMail_Manager	lnv_EmailManager
n_cst_EMailMessage		lnva_EmailMessage[]
n_cst_EMailMessage		lnva_Rejects[]
n_cst_EmailMessage		lnv_CurrentEmail
n_cst_ShipmentManager	lnv_ShipmentManager
n_cst_beo_Shipment		lnv_Shipment
pt_n_cst_beo				lnv_PTBeo 

n_cst_licenseManager		lnv_Lic
lnv_EmailManager = CREATE n_cst_bso_EMail_Manager

IF NOT lnv_lic.of_HasNotificationLicense ( ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
//	li_RequestCount = lnv_EmailManager.of_GetStatusRequests ( lnva_EmailMessage ) //rdt 102602
 li_RequestCount = lnv_EmailManager.of_GetEmailReplys( lnva_EmailMessage , lnva_Rejects ) //rdt 102602
	IF li_RequestCount = -1 THEN
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN
	FOR i = 1 TO li_RequestCount 
		lnv_CurrentEmail = lnva_EmailMessage[i]

		If lnv_CurrentEmail.of_IsStatusRequest() Then // rdt 102602
			// we will need to get the shipment for the current request. and submit the email 
			// object to it.
			THIS.of_GetShipment ( lnv_CurrentEmail , lnv_Shipment ) 
				
			lnv_PTBeo = lnv_Shipment
	
			THIS.of_ProcessStatusRequest ( lnv_PTBeo , lnv_CurrentEmail )

		END IF
													// rdt 102602
		
	NEXT
END IF


Int	li_RejectCount
li_RejectCount = UpperBound ( lnva_Rejects ) 
FOR i = 1 TO li_RejectCount
	THIS.of_SendFailurenotification( lnva_Rejects[i] )
NEXT



If Isvalid( lnv_EmailManager ) Then 
	DESTROY ( lnv_EmailManager )
End If

If Isvalid( lnv_PTBeo ) Then 
	DESTROY ( lnv_PTBeo )
End If

DESTROY  ( inv_Dispatch ) // I am doing this because we had a problem 
								// with the status request pulling the wrong data

RETURN li_Return
end function

private function integer of_processstatusrequest (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_emailmessage);/***************************************************************************************
NAME: 			

ACCESS:			Private
	
ARGUMENTS: 		

RETURNS:			
	
DESCRIPTION:	
					This method should be used to reply to email requests for a shipment status

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :

RDT 092602 changed to call of_CreateEmailDocument()

***************************************************************************************/

Long 	ll_Count 
Int	li_Return = 1
n_cst_bso_Email_Manager	lnv_EmailManager
lnv_EmailManager = CREATE n_cst_bso_Email_Manager

n_cst_EmailMessage lnva_EmailMessage[]

is_documenttype  = appeon_constant.cs_shipstat	// RDT 092602

This.of_CreateEmailDocument ( anv_ptbeo, anv_emailmessage, lnva_EmailMessage[]  )// RDT 092602

IF li_Return = 1 THEN
	For ll_Count = 1 to UpperBound ( lnva_EmailMessage[] )
		IF lnv_EmailManager.of_SendMail ( lnva_EmailMessage[ ll_Count ] ) <> 1 THEN
			li_Return = -1
		ELSE
			lnv_EmailManager.of_MarkMessageAsRead ( anv_emailmessage )
		END IF
	Next
END IF


DESTROY (lnv_EmailManager)

RETURN li_Return

// This works OK 4-15-03 but is not flexible.
//This.of_CreateEmailDocument ( anv_ptbeo, anv_emailmessage )							// RDT 092602
//n_cst_Companies	lnv_Companies
//lnv_Companies 	 = Create n_cst_Companies	
//Long	ll_CompanyID
//ll_CompanyID = anv_EmailMessage.of_getrequestingcompanyid (  ) 
//anv_EmailMessage.of_SetDocumentType ( is_DocumentType  )
//	
//			IF isNull ( ll_CompanyID ) THEN
//				IF li_Return = ci_Status_Success THEN
//					If THIS.of_SetDefaultTemplate ( anv_emailmessage  ) <> 1 THEN
//						li_Return = ci_Status_Error
//					End If
//				END IF
//			ELSE
//				IF li_Return = ci_Status_Success THEN
//					anv_EmailMessage.of_SetCompanyid ( ll_companyid ) 
//					// set template on document
//					If lnv_Companies.of_SetTemplateOnDocument ( anv_EmailMessage, ll_CompanyId ) <> 1 THEN
//						li_Return = ci_Status_Error
//					End If
//				END IF
//			END IF
//
//			IF li_Return = ci_Status_Success THEN
//				// Populate Email Body 
//				If THIS.Of_PopulateEmailBody ( anv_ptbeo, anv_EmailMessage ) <> 1  Then
//					li_Return = ci_status_error
//				End If
//			END IF
//
//			IF li_Return = ci_Status_Success THEN
//				//  Populate Email Subject 
//				If THIS.Of_PopulateEmailSubject ( anv_ptbeo, anv_EmailMessage) <> 1 THEN
//					li_Return = ci_Status_Error
//				End If
//			END IF
//			
//			IF li_Return = ci_Status_Success THEN
//				// Process Attachments
//				If THIS.of_ProcessAttachments ( anv_ptbeo, anv_EmailMessage) <> 1 THEN
//					li_Return = ci_Status_Error
//				End If
//			END IF
//				

end function

private function n_cst_bso_dispatch of_getdispatchobject ();IF NOT isValid ( inv_Dispatch ) THEN
	inv_Dispatch = CREATE n_cst_bso_Dispatch
END IF

RETURN inv_Dispatch
end function

public function integer of_approvestatusrequest (n_cst_emailmessage anv_mailmessage);/***************************************************************************************
NAME: 			of_ApproveStatusRequest

ACCESS:			public
	
ARGUMENTS: 		anv_mailmessage

RETURNS:			Int	
					-1  Error
					 0  Request NOT approved   -- default
					 1  Request APPROVED
	
DESCRIPTION:

					this method will determine if the company making the status request 
					Satisfies the 'security' requirements


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	June 4, 2002  Created RPZ



***************************************************************************************/

Int	li_Return = 0
Long	ll_ReqCoID
Long	ll_ShipmentID
Long	lla_ReferecedCompanies[]
Long	ll_CompanyCount
Long	i

n_cst_Beo_Shipment	lnv_Shipment
n_cst_Beo_Company lnv_Company
n_cst_bso_Dispatch	lnv_Dispatch

lnv_Company = CREATE n_cst_beo_Company
lnv_Shipment = CREATE n_Cst_beo_Shipment
lnv_Dispatch = THIS.of_GetDispatchObject ( )

ll_ReqCoID = anv_MailMessage.of_GetRequestingCompanyID ( )
ll_ShipmentID = anv_mailmessage.of_GetShipmentID ( )

gnv_cst_companies.of_Cache ( ll_ReqCoID , TRUE )
lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )

lnv_Company.of_SetUseCache ( TRUE )
lnv_Company.of_SetSourceID ( ll_ReqCoID )

lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
lnv_Shipment.of_SetSourceId ( ll_ShipmentID )

IF NOT lnv_Company.of_HasSource ( ) THEN
	li_Return = -1
END IF

IF NOT lnv_Shipment.of_HasSource ( ) THEN
	li_Return = -1
END IF

IF li_Return <> -1 THEN
	
	CHOOSE CASE lnv_Company.of_GetRequiredRequestRole ( ) 
			
		CASE n_cst_constants.cs_RequestRole_none
			li_Return = 0
			
		CASE n_cst_constants.cs_RequestRole_BillTo

				IF lnv_Shipment.of_GetBillTo ( ) = ll_ReqCoID THEN
					li_Return = 1
				ELSE
					li_Return = 0
				END IF
				
		CASE n_cst_constants.cs_RequestRole_Any			
		
			lnv_Shipment.of_GetReferencedCompanies ( lla_ReferecedCompanies )
			ll_CompanyCount = UpperBound ( lla_ReferecedCompanies )
			FOR i = 1 TO ll_CompanyCount
				IF lla_ReferecedCompanies[i] = ll_ReqCoID THEN
					li_Return = 1
					EXIT
				END IF
			NEXT
											
	END CHOOSE

END IF 


DESTROY ( lnv_Company )
DESTROY ( lnv_Shipment )

RETURN li_Return
end function

public function integer of_newcontact (string as_firstname, string as_middlename, string as_lastname, string as_emailaddress, long al_coid);Long	ll_Count
Long	i
Long	ll_CoID
long	ll_NewRow
String	ls_First
String	ls_Middle
String	ls_Last
String	ls_Email
Long		ll_NewID

ls_First = as_FirstName 
ls_Middle = as_MiddleName
ls_Last = as_LastName
ls_Email = as_EmailAddress
ll_CoId = al_CoID

//dataStore	lds_Contacts										// rdt 092602
//lds_Contacts = CREATE dataStore							// rdt 092602
n_ds 	lds_Contacts												// rdt 092602
lds_Contacts = CREATE n_ds										// rdt 092602

lds_Contacts.dataobject = "d_CompanyContacts_list"
lds_Contacts.SetTransObject ( SQLCA )

If ll_CoID = 0 THEN
	SetNull ( ll_CoId )
END IF

ll_NewRow = lds_Contacts.InsertRow ( 0 ) 

lds_Contacts.SetItem ( ll_NewRow ,  "ct_fn" , ls_First )
lds_Contacts.SetItem ( ll_NewRow ,  "ct_mi" , ls_Middle )
lds_Contacts.SetItem ( ll_NewRow ,  "ct_ln" , ls_Last )
lds_Contacts.SetItem ( ll_NewRow ,  "ct_emailaddress" , ls_Email )
lds_Contacts.SetItem ( ll_NewRow ,  "ct_co" , ll_Coid )
lds_Contacts.SetItem ( ll_NewRow ,  "ct_status" , this.cs_status_active )
ll_NewId =  THIS.of_GetNewContactID ( ) 
lds_Contacts.SetItem ( ll_NewRow ,  "ct_id" , ll_NewId )

IF lds_Contacts.Update ( ) = 1 THEN
	Commit;
ELSE
	RollBack;
END IF

DESTROY ( lds_Contacts ) 

RETURN ll_NewID 




end function

public function long of_getnewcontactid ();

long	ll_Return

SELECT Max ( "ct_id" )INTO :ll_Return FROM Contacts;

IF SQLCA.SqlCode = 0 THEN
	COMMIT ;
ELSE		
	ROLLBACK ;
END IF

IF isNull ( ll_Return ) THEN
	ll_Return = 0 
END IF

ll_Return ++

RETURN ll_Return

end function

public function integer of_assigncontacttocompany (long al_contactid, long al_companyid);Long	ll_Count
Int	li_Return = -1
//dataStore	lds_Contacts							// rdt 092602
//lds_Contacts = CREATE dataStore				// rdt 092602
n_ds 	lds_Contacts									// rdt 092602
lds_Contacts = CREATE n_ds							// rdt 092602

lds_Contacts.dataobject = "d_CompanyContacts_list"
lds_Contacts.SetTransObject ( SQLCA )
lds_Contacts.object.datawindow.table.select = "SELECT * FROM contacts"
lds_Contacts.Retrieve ( 0 ) // this just satisfies the need for retrieval args. its not used


lds_Contacts.SetFilter ( "ct_id = " + String ( al_ContactID ) )
lds_Contacts.Filter ( ) 

ll_Count = lds_Contacts.RowCount ( )

IF ll_Count = 1 THEN
	lds_Contacts.SetItem ( 1 , "ct_co" , al_CompanyID )
	IF lds_Contacts.Update ( ) = 1 THEN
		Commit;
		li_Return = 1
	ELSE
		RollBack;
	END IF
END IF

RETURN li_Return


end function

public function long of_getidfromemailaddress (string as_emailaddress);Long	ll_Return = 0
Long	ll_RowCount


//dataStore	lds_Contacts							// rdt 092602
//lds_Contacts = CREATE dataStore				// rdt 092602
n_ds 	lds_Contacts									// rdt 092602
lds_Contacts = CREATE n_ds							// rdt 092602

lds_Contacts.dataobject = "d_CompanyContacts_list"
lds_Contacts.SetTransObject ( SQLCA )

lds_Contacts.object.datawindow.table.select = "SELECT * FROM contacts"
ll_RowCount = lds_Contacts.Retrieve ({0}) // this just satisfies the need for retrieval args. its not used

lds_Contacts.SetFilter ( "ct_emailaddress = '" + Trim ( as_emailaddress ) + "'" )
lds_Contacts.Filter ( )

ll_RowCount = lds_Contacts.RowCount ( )
IF ll_RowCount > 0 THEN
	ll_Return = lds_Contacts.GetItemNumber ( 1 , "ct_id" )
	
	// check to see if it was hidden and if so activate it	
	IF lds_Contacts.GetItemString ( 1 , "ct_Status" ) = this.cs_Status_Hidden THEN
		lds_Contacts.SetItem ( 1 , "ct_Status"  , this.cs_Status_Active )
	END IF	
	
END IF

IF lds_Contacts.Update ( ) = 1 THEN
	Commit;
ELSE
	RollBack;
END IF

Destroy ( lds_Contacts )

RETURN ll_Return
end function

private function long of_getnewnotificationid ();long	ll_Return

SELECT Max ( "id" )INTO :ll_Return FROM notification;

IF SQLCA.SqlCode = 0 THEN
	COMMIT ;
ELSE		
	ROLLBACK ;
END IF

IF isNull ( ll_Return ) THEN
	ll_Return = 0 
END IF

ll_Return ++

RETURN ll_Return

end function

public function integer of_processnotificationrequest (pt_n_cst_beo anv_ptbeo);String ls_Error

RETURN THIS.of_ProcessNotificationRequest ( anv_ptbeo , FALSE , ls_Error)  // false = ignore sys setting



end function

private function integer of_gettemplateforcompany (ref n_cst_emailmessage anv_emailmessage);Long		ll_CompanyID
String	ls_Template
Int		li_Return = -1

n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company

ll_CompanyID = anv_emailmessage.of_GetRequestingCompanyID () 

IF ll_CompanyID > 0 THEN

	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceID ( ll_CompanyID ) 

	
	ls_Template = lnv_Company.of_GetStatusRequestTemplate ( )
	
	IF len ( ls_Template ) > 0 THEN
		li_Return = 1
		anv_emailmessage.of_SetTemplate ( ls_Template )
	END IF
	
END IF

DESTROY lnv_Company 

RETURN li_Return
end function

public function integer of_clearaddresses ();Long			ll_RowCount
Long			i
Int			li_Return = -1

//DataStore	lds_List						// rdt 092602
//lds_List = Create DataStore			// rdt 092602
n_ds 	lds_List								// rdt 092602
lds_List = Create n_ds					// rdt 092602

lds_List.DataObject = "d_companyContacts_list"
lds_List.SetTransObject ( SQLCA )

lds_List.object.datawindow.table.select = "SELECT * FROM contacts"
ll_RowCount = lds_List.Retrieve ( 0 ) // this just satisfies the need for retrieval args. its not used

lds_List.SetFilter ( "isNull (ct_co)" )
lds_List.Filter ( ) 

ll_RowCount = lds_List.RowCount ( )

FOR i = 1 TO ll_RowCount
	
	lds_List.SetItem ( i , "ct_status" , appeon_constant.cs_Status_Hidden )
	
NEXT

IF lds_List.Update ( ) = 1 THEN
	Commit;
	li_Return = 1
ELSE
	RollBack;
END IF

DESTROY ( lds_List )

RETURN li_Return

end function

public function integer of_startstatusrequestservice ();// RDT 5-06-03 Added Timer for Notifications

gnv_app.of_GetTimers ( ).of_StartTimer ( n_cst_Constants.cs_Timer_StatusRequest )

gnv_app.of_GetTimers ( ).of_StartTimer ( n_cst_constants.cs_timer_Notification ) // RDT 5-06-03 

RETURN 1
end function

public function integer of_stopstatusrequestservice ();// RDT 5-06-03 Added Notification timer
gnv_app.of_GetTimers ( ).of_StopTimer ( n_cst_Constants.cs_Timer_StatusRequest )

gnv_app.of_GetTimers ( ).of_StopTimer ( n_cst_constants.cs_timer_Notification )

RETURN 1
end function

public function boolean of_isstatusrequestrunning ();RETURN gnv_App.of_GetTimers ( ).of_IsRunning ( n_cst_constants.cs_Timer_StatusRequest )
end function

private function integer of_getimagepaths (long al_shipmentid, long al_companyid, ref string asa_filepaths[]);Long		ll_CompanyID
String	lsa_ImageTypes[]
String	lsa_Attach[]
String	ls_CurrentType
String	ls_Path
Int		li_Count
Int		i,k
Int		li_Return = -1

n_cst_bso_ImageManager_pegasus	lnv_ImageManager
n_cst_beo_ImageType		lnva_ImageTypes[]
n_cst_beo_ImageType		lnv_CurrentImageBeo
n_cst_bcm					lnv_Bcm
n_cst_bcmService			lnv_bcmService
n_cst_beo_Company			lnv_Company


lnv_Company = CREATE n_cst_beo_Company
lnv_ImageManager = Create n_cst_bso_ImageManager_Pegasus

gnv_app.inv_cacheManager.of_GetCache ( "n_cst_dlkc_imagetype" , lnv_Bcm , TRUE , TRUE )
IF Not isValid ( lnv_bcm )  THEN
	RETURN -1 									/////// MID CODE RETURN 
END IF

ll_CompanyID = al_companyid
IF ll_CompanyID > 0 THEN	
	lnv_Company.of_SetUseCache ( TRUE )
	lnv_Company.of_SetSourceID ( ll_CompanyID ) 
	lnv_Company.of_GetAttachImageTypes( lsa_ImageTypes )
END IF

li_Count = UpperBound ( lsa_ImageTypes )
FOR i = 1 TO li_Count 
	
	ls_CurrentType = lsa_ImageTypes[ i ]
	 		
	lnv_bcmService.of_getallbeo ( lnv_bcm, "imagetype_type = '"  + ls_CurrentType + "'" , lnva_ImageTypes )
			
	FOR k = 1 TO upperBound ( lnva_ImageTypes )			
		lnv_CurrentImageBEO = lnva_ImageTypes[ k ]
		ls_Path = lnv_Imagemanager.of_CreatePath (lnv_CurrentImageBeo , al_shipmentid )
		IF lnv_ImageManager.of_DoesImageExist ( ls_Path ) THEN
			lsa_Attach [ UpperBound ( lsa_Attach ) + 1 ] = ls_Path
		END IF
	NEXT
	
NEXT

asa_filepaths[] = lsa_Attach

li_Return = UpperBound( asa_FilePaths )

DESTROY lnv_Company 
DESTROY ( lnv_ImageManager )

RETURN li_Return

end function

public function long of_getcontactsnotified (pt_n_cst_beo anv_beo, ref long ala_contactids[]);//String	ls_Select
//Long		ll_RowCount
//Long		i
//String	ls_Context 
//Long		ll_ID
//
//IF Not isValid ( anv_beo ) THEN
	RETURN -1
//END IF	
//
//DataStore	lds_note
//lds_Note = CREATE DataStore
//lds_Note.DataObject = "d_notification"
//lds_Note.SetTransObject ( SQLCA )
//
//ll_ID = anv_beo.DYNAMIC of_GetID ( )
//ls_Context = anv_beo.of_GetTopic ( )
//
//IF ll_ID > 0 THEN
//	CHOOSE CASE ls_Context
//			
//		CASE "SHIPMENT"		
//			ls_Select = "SELECT * FROM NOTIFICATION where shipmentid = " + String ( ll_ID )
//					
//		CASE "EVENT"		
//			ls_Select = "SELECT * FROM NOTIFICATION where eventid = " + String ( ll_ID )		
//				
//	END CHOOSE
//	
//	lds_Note.object.datawindow.table.select = ls_Select
//	ll_RowCount = lds_Note.Retrieve ( )
//	
//	FOR i = 1 TO ll_RowCount			
//		
//		ala_contactids[i] = lds_Note.GetItemNumber ( i , "ContactID" )
//		
//	NEXT			
//	
//	DESTROY ( lds_Note )
//END IF
//
//RETURN ll_RowCount
end function

public function integer of_creatependingnotification (pt_n_cst_beo anv_ptbeo);//
//REVISION : RDT 092602 added code for new column DocumentType in NotificationStatus table 
// RDT 5-28-03 changed to check for rows in instance and database
Long	ll_ID
Long	ll_RowCount
Long	ll_Find
Long	ll_NotificationID
Int	li_Return = -1

Boolean lb_ExistsOnInstance = False

String	ls_topic
String	ls_FindString

n_ds lds_notestatus 
lds_notestatus = CREATE n_ds
lds_notestatus.DataObject = "d_notificationStatus"
lds_notestatus.SetTransObject ( SQLCA )


IF NOT isValid ( anv_PtBeo ) THEN
	RETURN -1
END IF

is_DocumentType = anv_PtBeo.of_GetDocumentType( ) 		// get the document type from the BEO

ll_ID = anv_PtBeo.DYNAMIC of_GetID ( ) 
ls_Topic = anv_PtBeo.of_GetTopic ( )

IF IsNull ( ls_Topic ) OR Len ( ls_Topic ) = 0 OR ll_ID <= 0 THEN
	RETURN -1
END IF

ll_RowCount = ids_notestatus.RowCount  ( )

// Look for entry on instance
IF ll_RowCount > 0 THEN 
	ls_FindString = "NotificationTopic = '" + ls_Topic + "'" + " AND SourceID = " & 
	               + String ( ll_ID ) + " AND DocumentType = '" + is_documenttype + "'" // RDT 092602 

	ll_Find = ids_notestatus.Find ( ls_FindString , 1 , ll_RowCount + 1 ) 
	IF ll_Find > 0 THEN // set the status to pending  '0'
		IF ids_notestatus.SetItem ( ll_Find , "notificationstatus" , THIS.ci_Status_Pending ) = 1 THEN
			lb_ExistsOnInstance = TRUE
			li_Return = 1                               
		END IF
	END IF
END IF

If NOT lb_ExistsOnInstance Then 
	// if not found on instance check database
	This.of_SetWhereClause( lds_notestatus ,ls_Topic, ll_ID , is_DocumentType )
	ll_Find = lds_notestatus.Retrieve()	
	IF ll_Find > 0 THEN 
		// Copy row to instance and set the status to pending  '0'
		if lds_notestatus.RowsCopy(ll_Find, 1, Primary!, ids_notestatus, 1, Primary!) = 1 then 
			ids_NoteStatus.SetItemStatus(1, 0, Primary!, NotModified!)	
			ids_NoteStatus.SetItemStatus(1, 0, Primary!, DataModified!)		
			ids_NoteStatus.SetItem ( 1 , "notificationstatus" , THIS.ci_Status_Pending ) 
			li_Return = 1                               
		else
			li_Return = -1
		end if
	END IF

END IF

IF ll_Find = 0 THEN 
	// did not find any on instance or database, so create new entry on Instance 
	ll_RowCount = ids_notestatus.InsertRow ( 0 )
	IF ll_RowCount > 0 THEN
		ll_NotificationID = THIS.of_GetNextStatusID ( ) 
		If ll_NotificationID = -1 Then 
				RETURN -1 	/* MID CODE RETURN */
		End If
		ids_notestatus.SetItem ( ll_RowCount , "id" , ll_NotificationID )
		ids_notestatus.SetItem ( ll_RowCount , "notificationtopic" , ls_Topic)
		ids_notestatus.SetItem ( ll_RowCount , "sourceid" , ll_ID )
		ids_notestatus.SetItem ( ll_RowCount , "notificationstatus" , THIS.ci_Status_Pending )
		ids_notestatus.SetItem ( ll_RowCount , "documenttype" , is_documenttype)							// RDT 092602
		li_Return = 1
	END IF

END IF

Destroy ( lds_notestatus ) 

RETURN li_Return 
end function

public function long of_getnextstatusid ();
// RDT 110702  Changed to get Next ID from gnv_app.of_getnextid & Added error message

long	 ll_Return

// RDT 110702 Comment Block - Start//
//	SELECT Max ( "id" )INTO :ll_Return FROM notificationStatus;
//	
//	IF SQLCA.SqlCode = 0 THEN
//		COMMIT ;
//	ELSE		
//		ROLLBACK ;
//	END IF
//	IF isNull ( ll_Return ) THEN
//		ll_Return = 0
//	END IF
//	
//	ll_Return ++
//// RDT 110702 Comment Block - End //

If gnv_app.of_getnextid ( "NotificationStatus", ll_Return, TRUE) = -1 Then 
	ll_Return = -1
	MessageBox("Notification Manager Error", "Error retrieving next id for Notification Status. ")
End If


RETURN ll_Return



end function

private function integer of_sendnotification (string as_topic, long al_id, ref string as_errorstring);// RDT 7-01-03 percolate the return code back to calling script.
Int		li_Return
String	ls_Error
Long		ll_ShipmentID

ls_Error = "Could not process request"

n_cst_bso_Dispatch	lnv_Dispatch
lnv_Dispatch = CREATE n_cst_bso_Dispatch

n_cst_beo_Shipment	lnv_Shipment
lnv_Shipment = CREATE n_cst_beo_Shipment

pt_n_cst_beo	lnv_Source

CHOOSE CASE UPPER ( as_Topic )
		
	CASE "EVENT" 
		lnv_Dispatch.of_RetrieveEvents( {al_ID} )
		lnv_Source = CREATE n_cst_beo_Event		
		lnv_Source.of_SetSourceID ( al_ID ) 		
		lnv_Source.of_SetSource ( lnv_Dispatch.of_GetEventCache ( ) )
		
		ll_ShipmentID = lnv_Source.Dynamic of_GetShipment( )
		IF ll_ShipmentID > 0 THEN
			lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
			lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
			lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
			lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
			lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
			lnv_Source.Dynamic of_Setshipment ( lnv_Shipment )
			lnv_Source.Dynamic of_SetDocumentType ( is_documenttype ) // rdt 12-18-02 
		END IF
		
	CASE "ITEM" 
		lnv_Dispatch.of_RetrieveItems( {al_ID} ) 	// rdt 092602 added 
		lnv_Source = CREATE n_cst_beo_Item
		lnv_Source.of_SetSourceID ( al_ID ) 
		lnv_Source.of_SetSource ( lnv_Dispatch.of_GetItemCache ( ) )
		
		// rdt 092602 added lines start 
		ll_ShipmentID = lnv_Source.Dynamic of_GetShipment( )
		IF ll_ShipmentID > 0 THEN
			lnv_Dispatch.of_RetrieveShipment ( ll_ShipmentID )
			lnv_Shipment.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
			lnv_Shipment.of_SetSourceID ( ll_ShipmentID )
			lnv_Shipment.of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
			lnv_Shipment.of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
			lnv_Source.Dynamic of_Setshipment ( lnv_Shipment )
			lnv_Source.Dynamic of_SetDocumentType ( is_documenttype ) // rdt 12-18-02 

		END IF
		// rdt 092602 added lines end
		
	CASE "SHIPMENT"
		lnv_Dispatch.of_RetrieveShipment ( al_ID )
		lnv_Source = CREATE n_cst_beo_Shipment
		lnv_Source.of_SetSource ( lnv_Dispatch.of_GetShipmentCache ( ) )
		lnv_Source.of_SetSourceID ( al_ID )
		lnv_Source.Dynamic of_SetEventSource ( lnv_Dispatch.of_GetEventCache ( ) )
		lnv_Source.Dynamic of_SetItemSource ( lnv_Dispatch.of_GetItemCache ( ) )
		lnv_Source.Dynamic of_SetDocumentType ( is_documenttype ) // rdt 12-18-02 
	
END CHOOSE		

IF isValid ( lnv_Source ) THEN

	li_Return = THIS.of_ProcessNotificationRequest ( lnv_Source , FALSE , ls_Error )

//	CHOOSE CASE THIS.of_ProcessNotificationRequest ( lnv_Source , FALSE , ls_Error )
	CHOOSE CASE li_Return 
		CASE 1
			//li_Return = 1
			
		CASE else
			//li_Return = -1
			as_ErrorString = ls_Error
	END CHOOSE


END IF
	

DESTROY ( lnv_Dispatch ) 
DESTROY ( lnv_Source )
DESTROY ( lnv_Shipment )				// RDT 092602

Return li_Return
end function

public function integer of_sendpendingnotifications ();// RDT 5-28-03 changed to use local n_ds for retrieval of only pending notifications
// changed ids_notestatus to lds_notestatus
// RDT 6-26-03 Changed to update and commit row by row by row row row your ....
// RDT 6-26-03 Added log file for datbase errors.

Long	ll_RowCount
Long	i
Long	ll_ID
String	ls_Topic 
String	ls_Filter
String 	ls_ErrorString
String	ls_Where
Int		li_SendRtn 
Int		li_Return = 1

SetPointer ( HOURGLASS! )
// RDT 5-28-03 filter no longer needed
//ls_Filter = "notificationstatus = " + String ( THIS.ci_status_pending )
//ids_notestatus.SetFilter ( ls_Filter )
//ids_notestatus.Filter ( )

// RDT 5-28-03 -Start
n_ds lds_notestatus 
lds_notestatus = CREATE n_ds
lds_notestatus.DataObject = "d_notificationStatus"
lds_notestatus.SetTransObject ( SQLCA )

// Set where clause to retrieve only pending notifications.
//ls_Where = lds_notestatus.Describe( "DataWindow.Table.Select" )
of_SetWherePending( lds_notestatus) 
//lds_notestatus.Modify( "DataWindow.Table.Select='" + ls_Where + "'")

ll_RowCount = lds_notestatus.Retrieve ( )

// RDT 5-28-03 -End 
//ll_RowCount = lds_notestatus.RowCount ( )

FOR i = 1 TO ll_RowCount
	
	ls_ErrorString = ""
	ls_Topic = lds_notestatus.GetItemString ( i , "notificationtopic" )
	ll_ID = lds_notestatus.GetItemNumber ( i , "sourceid" )
	is_documenttype = lds_notestatus.GetItemString(i, "documenttype" )							// RDT 092602
	li_SendRtn = THIS.of_SendNotification ( ls_Topic , ll_ID , ls_ErrorString ) 
	lds_notestatus.SetItem ( i , "notificationstatus", li_SendRtn )
	lds_notestatus.SetItem ( i , "errorstring", ls_ErrorString )
	
	IF li_SendRtn <> 1 THEN
		THIS.of_AddError ( ls_ErrorString ) 
		li_Return = -1
	END IF
 //NEXT 																	// RDT 6-26-03 

 //IF ll_RowCount > 0 THEN 										// RDT 6-26-03 

	IF lds_notestatus.Update ( ) = 1 THEN
		Commit;
	ELSE
		RollBack;
		This.of_logError( "Database Update Error. " + is_DocumentType &
								+ " " + ls_Topic &
								+ " " + String( ll_ID) 	) 			// RDT 6-26-03 
		lds_NoteStatus.ResetUpdate() 								// RDT 6-26-03 
	END IF
 //END IF 																// RDT 6-26-03 

NEXT																		// RDT 6-26-03 

//ids_notestatus.SetFilter ( "" )
//ids_notestatus.Filter ( )

Destroy ( lds_notestatus )

RETURN li_Return

end function

public function integer of_removependingnotification (pt_n_cst_beo anv_ptbeo);//
//REVISION : RDT 092602 added code for new column DocumentType in NotificationStatus table 
// RDT 5-28-03 Check for notification on instance then database 
// RDT 5-28-03 replaced FIND with retrieve logic
// RDT 7-02-03 Changed logic to discard rows instead of deleting them. Delete causes DB error code -3.

/*
	Remove will 
		If not in database check for notification on instance 
			if found delete it.
		Check for notification on database
		IF found 
			check status
			if status is not 0 then give message to user that it was sent 
			If status = 0 then copy to instance primary buffer, set error code to -1 and error message to canceled.

*/

Long	ll_ID
Long	ll_RowCount
Long	ll_Find
Int	li_Return = 1
Int		li_Status

String	ls_Error
String	ls_topic
String	ls_FindString
Boolean	lb_FoundInDatabase = false

//DataStore	lds_Temp					// rdt 092602
//lds_Temp = CREATE dataStore		// rdt 092602
n_ds	lds_Temp							// rdt 092602
lds_Temp = CREATE n_ds				// rdt 092602

lds_Temp.DataObject = "d_NotificationStatus"
lds_Temp.SettransObject ( SQLCA )

IF NOT isValid ( anv_PtBeo ) THEN
	RETURN -1
END IF

ll_ID = anv_PtBeo.DYNAMIC of_GetID ( ) 
ls_Topic = anv_PtBeo.of_GetTopic ( )

IF IsNull ( ls_Topic ) OR Len ( ls_Topic ) = 0 OR ll_ID <= 0 THEN
	RETURN -1
END IF

If li_Return = 1 then 
	If NOT lb_FoundInDatabase Then 
		ll_RowCount = ids_notestatus.RowCount() 
		IF ll_RowCount > 0 THEN 
			// look for existing entry on instance
			//	ls_FindString = "NotificationTopic = '" + ls_Topic + "' AND SourceID = " + String ( ll_ID ) + " AND notificationstatus = " +String(THIS.ci_Status_Pending) &
			//				+ " AND documenttype = '" +is_documenttype+"'"  													// RDT 092602
			ls_FindString = "NotificationTopic = '" + ls_Topic + "' AND SourceID = " + String ( ll_ID ) +  &
							+ " AND documenttype = '" +is_documenttype+"'"  											//RDT 7-02-03
			ll_Find = ids_NoteStatus.Find ( ls_FindString , 1 , ll_RowCount + 1 ) 
			If ll_Find > 0 Then 
				//if ids_NoteStatus.DeleteRow ( ll_Find ) = 1 then 													//RDT 7-02-03
				if ids_NoteStatus.RowsDiscard ( ll_Find, ll_Find, Primary! ) = 1 then 							//RDT 7-02-03
					li_Return = 1                               
				else
					li_Return = -1
				end if
			End If
		END IF
	END IF
END IF

// check for notification in database
This.of_setwhereclause ( lds_Temp, ls_topic, ll_id, anv_PtBeo.of_GetDocumentType( )  )
ll_Find = lds_Temp.Retrieve ( ) 

IF ll_Find > 0 THEN
	
	lb_FoundInDatabase = TRUE 
	li_Status = lds_Temp.GetItemNumber ( ll_Find , "notificationstatus" )
	ls_Error = lds_Temp.GetItemString ( ll_Find , "errorstring" ) 
	
	If li_status = 1 OR li_status = -1 then 
		//MessageBox("Cancel Pending Notification","A notification has already been sent.")
		li_Return = -1
	Else
		// copy row to instance and set values
		If lds_Temp.RowsCopy(ll_Find, 1, Primary!, ids_notestatus, 1, Primary!) = 1 then 
			ids_NoteStatus.SetItemStatus(1, 0, Primary!, NotModified!)	
			ids_NoteStatus.SetItemStatus(1, 0, Primary!, DataModified!)			
			ids_notestatus.SetItem ( 1 , "notificationstatus" , THIS.ci_Status_Error ) 
			ids_notestatus.SetItem ( 1 , "errorstring" , "User Canceled" ) 
//			MessageBox("Cancel Pending Notification","Then notification will be canceled when the shipment is saved.")
		End if
	End if
		

END IF

//IF li_Return = 1 THEN
	//li_Return = ids_Notestatus.Update()
//END IF

DESTROY ( lds_Temp )

RETURN li_Return 
end function

public function integer of_checknotificationstatus (pt_n_cst_beo anv_ptbeo);// returns -2 default, DNE
//  		  -1 Error sending
// 		   0 Pending	
//				1 success
// RDT added event type in find statement 
// RDT 5-28-03 changed to use local n_ds and retrieve from database

Long	ll_ID
Long	ll_RowCount
Long	ll_Find
Int	li_Return = -2
Boolean	lb_NoteOnInstance = False
String	ls_topic
String	ls_FindString

IF NOT isValid ( anv_PtBeo ) THEN
	RETURN -1
END IF

ll_ID = anv_PtBeo.DYNAMIC of_GetID ( ) 
ls_Topic = anv_PtBeo.of_GetTopic ( )

IF IsNull ( ls_Topic ) OR Len ( ls_Topic ) = 0 OR ll_ID <= 0 THEN
	RETURN -1
END IF

is_DocumentType = anv_PtBeo.of_GetDocumentType( ) 

// Check for notification on instance
If ids_notestatus.RowCount()  > 0 Then 
	
	ls_FindString = "NotificationTopic = '" + ls_Topic + "'" + " AND SourceID = " & 
							+ String ( ll_ID ) + " AND DocumentType = '" + anv_PtBeo.of_GetDocumentType( ) + "'" 				// RDT 092602 
	ll_Find = ids_notestatus.Find ( ls_FindString , 0 , ids_notestatus.RowCount() + 1 ) 
	If ll_Find > 0 Then 
		lb_NoteOnInstance = TRUE 
		li_Return = ids_notestatus.GetItemNumber ( ll_Find , "notificationstatus" )		
	End If
End If

IF NOT lb_NoteOnInstance Then 
	// RDT 5-28-03 -Start
	n_ds lds_notestatus 
	lds_notestatus = CREATE n_ds
	lds_notestatus.DataObject = "d_notificationStatus"
	lds_notestatus.SetTransObject ( SQLCA )
	
	This.of_SetWhereClause( lds_notestatus, ls_Topic,ll_ID, anv_PtBeo.of_GetDocumentType( )  ) 
	
	ll_Find = lds_notestatus.Retrieve ( )
	// RDT 5-28-03 -End 
	IF ll_Find > 0 THEN 
		li_Return = lds_notestatus.GetItemNumber ( ll_Find , "notificationstatus" )		
	END IF	
	
	Destroy ( lds_notestatus )
End IF

RETURN li_Return 
end function

public function string of_getnotificationerror (pt_n_cst_beo anv_ptbeo);//
//REVISION : RDT 092602 added code for new column DocumentType in NotificationStatus table 
// 			 RDT 5-28-03 changed to use local n_ds and retrieve from database
//

Long	ll_RowCount
Long	ll_Find
Long	ll_id
String	ls_topic
String	ls_FindString
String	ls_Return

Boolean 	lb_NoteOnInstance = False

SetNull ( ls_Return )

IF NOT isValid ( anv_PtBeo ) THEN
	RETURN ls_Return
END IF

ll_ID = anv_PtBeo.DYNAMIC of_GetID ( ) 
ls_Topic = anv_PtBeo.of_GetTopic ( )

IF IsNull ( ls_Topic ) OR Len ( ls_Topic ) = 0 OR ll_ID <= 0 THEN
	RETURN ls_Return
END IF


// Check for notification on instance
is_DocumentType = anv_PtBeo.of_GetDocumentType( ) 
ls_FindString = "NotificationTopic = '" + ls_Topic + "'" + " AND SourceID = " & 
						+ String ( ll_ID ) + " AND DocumentType = '" + is_documenttype + "'" 				// RDT 092602 
ll_Find = ids_notestatus.Find ( ls_FindString , 1 , ll_RowCount + 1 ) 
If ll_Find > 0 Then 
	lb_NoteOnInstance = TRUE 
	ls_Return = ids_notestatus.GetItemString ( ll_Find , "errorstring" )
End If

// if not on instance Check for notification in Database
If NOT lb_NoteOnInstance Then 
	// RDT 5-28-03 -Start
	n_ds lds_notestatus 
	lds_notestatus = CREATE n_ds
	lds_notestatus.DataObject = "d_notificationStatus"
	lds_notestatus.SetTransObject ( SQLCA )
	This.of_SetWhereClause( lds_notestatus, ls_Topic, ll_ID, is_documenttype )
	ll_Find = lds_notestatus.Retrieve ( )
	// RDT 5-28-03 -End 
	IF ll_Find > 0 THEN 
		ls_Return = lds_notestatus.GetItemString ( ll_Find , "errorstring" )
	END IF
	
	Destroy ( lds_notestatus )
End If

RETURN ls_Return 
end function

public function integer of_processnotificationrequest (pt_n_cst_beo anv_ptbeo, boolean ab_ignoresetting, ref string as_errorstring);// RDT 4-15-03 Changed to send lnva_EmailMessage[] to of_ProcessNotificationRequest
// RDT 7-01-03 
Int		li_Return = 1
Int		li_Result
Integer 	li_Count
String	ls_Body
Any		la_Value
Boolean 	lb_Continue = TRUE
String	ls_ErrorMessage

n_cst_emailMessage	lnv_EmailMessage, lnva_EmailMessage[]

n_cst_settings			lnv_Settings

n_cst_bso_Email_Manager	lnv_EmailManager
lnv_EmailManager = CREATE n_cst_bso_Email_Manager

n_cst_bso_document_manager lnv_DocumentMan 
lnv_DocumentMan = Create n_cst_bso_document_manager 

// RDT 12-03-02 Comment Block Start
//IF NOT ab_IgnoreSetting THEN
//	IF lnv_Settings.of_GetSetting ( 109 , la_value ) <> 1 THEN
//		lb_Continue = FALSE
//	END IF
//	IF String ( la_Value ) <> "YES!" THEN
//		lb_Continue = FALSE		
//	END IF		
//END IF
// RDT 12-03-02 Comment Block End 

IF lb_Continue THEN
	lb_Continue = anv_ptbeo.of_SendNotification ( ) // added 12/3/02 <<*>> rpz
	li_Return = 0
END IF


IF lb_Continue THEN

	li_Result = THIS.of_ProcessNotificationRequest ( anv_ptbeo , lnv_EmailMessage, lnva_EmailMessage[] ) 		// RDT 7-01-03
	//	IF THIS.of_ProcessNotificationRequest ( anv_ptbeo , lnv_EmailMessage, lnva_EmailMessage[] ) = 1 THEN	// RDT 7-01-03
		IF li_Result = 1 THEN																											// RDT 7-01-03
		
		//IF lnv_EmailMessage.of_GetAddressCount ( ) > 0 THEN				// RDT 092602 commented 
		//	lnv_EmailManager.of_SendMail ( lnv_EmailMessage ) 				// RDT 092602 commented 

		// RDT 5-13-03 If array is empty, no companies needed notification, BUT still set a successful email.
		If UpperBound( lnva_EmailMessage[] ) < 1 Then 
			//li_Return = ci_status_success 			//RDT 7-01-03
			li_Return = ci_Status_NoAddr				//RDT 7-01-03
			as_errorstring = is_errormessage	
		End if
		// RDT 092602 added lines Start
		For li_Count = 1 to Upperbound( lnva_EmailMessage[] ) 
			li_Result = lnv_EmailManager.of_SendMail ( lnva_EmailMessage[ li_Count ] )   // send email
			If li_Result = 1 then 																			  
				lnv_DocumentMan.Of_SaveDocument( lnva_EmailMessage[ li_Count ] ) // Save w/document manager
				li_Return = li_Result 		
			ELSE
				li_Return = -1
				ls_ErrorMessage += lnv_EmailManager.of_getErrorstring( )
			End If
		Next
		
	ELSE
		//li_Return = 0 // RDT 7-01-03 
		li_Return = li_Result
		as_errorstring = is_errormessage	
	END IF
	
END IF

IF li_Return = -1 THEN
	as_Errorstring += "~r~n" + ls_ErrorMessage
END IF

DESTROY ( lnv_EmailManager )
DESTROY ( lnv_DocumentMan )

RETURN li_Return

end function

private function long of_getshipmentid (pt_n_cst_beo anv_beo);
//REVISION : RDT 092602 added "ITEM" in Choose Case

Long ll_ShipId

Choose Case Upper( anv_beo.of_gettopic ( ) )
	Case "EVENT", "ITEM"																		//RDT 092602
		ll_ShipId = anv_beo.dynamic of_getShipment ( )		
	Case "SHIPMENT"
		ll_ShipId = anv_beo.dynamic of_getId ( )		
	Case else
		MessageBox("Program Error","appeon_constant.of_GetShipmentId Case statement error")
		SetNull(ll_ShipId)
End CHoose

Return ll_ShipId
end function

public function integer of_validaterequestrole (n_cst_beo_company anv_company, n_cst_beo_shipment anv_shipment);/***************************************************************************************
NAME: 			of_ValidateRequestRole

ACCESS:			public
	
ARGUMENTS: 		anv_company
					anv_shipment

RETURNS:			Int	
					-1  Error
					 0  Request NOT approved   -- default
					 1  Request APPROVED
	
DESCRIPTION:	this method will determin if the company meets the required role

					

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :
	Dec 5, 2002  Created RPZ



***************************************************************************************/

Int	li_Return = 0
Long	ll_ReqCoID
Long	ll_ShipmentID
Long	lla_ReferecedCompanies[]
Long	ll_CompanyCount
Long	i

n_cst_Beo_Shipment	lnv_Shipment
n_cst_Beo_Company lnv_Company

lnv_Shipment = anv_Shipment
lnv_Company = anv_Company

IF NOT isValid ( lnv_Shipment ) THEN
	li_Return = -1
END IF

IF NOT isValid ( lnv_Company ) THEN
	li_Return = -1
END IF

IF li_Return <> -1 THEN
	IF NOT lnv_Company.of_HasSource ( ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return <> -1 THEN
	IF NOT lnv_Shipment.of_HasSource ( ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return <> -1 THEN
	ll_ReqCoID = lnv_Company.of_GetID ( )
END IF

IF li_Return <> -1 THEN
	
	CHOOSE CASE lnv_Company.of_GetRequiredRequestRole ( ) 
			
		CASE n_cst_constants.cs_RequestRole_none
			li_Return = 0
			
		CASE n_cst_constants.cs_RequestRole_BillTo

				IF lnv_Shipment.of_GetBillTo ( ) = ll_ReqCoID THEN
					li_Return = 1
				ELSE
					li_Return = 0
				END IF
				
		CASE n_cst_constants.cs_RequestRole_Any			
		
			lnv_Shipment.of_GetReferencedCompanies ( lla_ReferecedCompanies )
			ll_CompanyCount = UpperBound ( lla_ReferecedCompanies )
			FOR i = 1 TO ll_CompanyCount
				IF lla_ReferecedCompanies[i] = ll_ReqCoID THEN
					li_Return = 1
					EXIT
				END IF
			NEXT
											
	END CHOOSE

END IF 

RETURN li_Return



end function

public function integer of_setdefaulttemplate (ref n_cst_emailmessage anv_emaildoc);/*
110			x		Default Template for Shipment Status
111			x		Default Template for Event notification
117			x		Default Template for Accessorial Notification
118			x		Default Template for Accessorial Authorization
120			x		Default Template for Last Free Date Report
*/
Any		la_Value
String	ls_Template
Int		li_Return = 1
Int		li_Setting

n_Cst_Settings	lnv_Settings

Choose Case anv_emaildoc.of_GetDocumentType( ) 
		
	Case appeon_constant.cs_acc
		li_Setting = 117
	
	Case appeon_constant.cs_event
		li_Setting = 111
		
	Case appeon_constant.cs_authout
		li_Setting = 118
		
	Case appeon_constant.cs_tir
		
		
	Case appeon_constant.cs_lfd
		li_Setting = 120

	Case appeon_constant.cs_shipstat
		li_Setting = 110
	
	Case appeon_constant.cs_LoadConfirmation
		li_Setting = 137
					
	Case else
		MessageBox("Program Error","Missing case in n_cst_Companies.of_SetTemplateOnDocument")
End Choose

IF li_Setting > 0 THEN
	lnv_Settings.of_GetSetting ( li_Setting , la_Value )
	ls_Template = String ( la_Value ) 
END IF

If Len( Trim ( ls_template) ) > 0 Then 
	anv_emaildoc.of_SetTemplateName ( ls_Template )
Else
	li_Return = -1
End If


RETURN li_Return
end function

private function integer of_processattachments (pt_n_cst_beo anv_ptbeo, ref n_cst_emailmessage anv_mailmsg);/***************************************************************************************
NAME: 			

ACCESS:			
	
ARGUMENTS: 		

RETURNS:			
	
DESCRIPTION:


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY :

April 13 2004, 
	Added check to make sure the document type was Shipment Status or LoadConfirmation <<*>> RPZ
	and removed a restriction the see if the confirmend event count = the total event count.

***************************************************************************************/

Int		li_Return = 1
String	lsa_Paths[]
String	ls_DocumentType
Int		li_Count
Int		i

mailFileDescription lnva_Attachment[]

ls_DocumentType = anv_ptbeo.of_GetDocumentType ( )

IF ls_DocumentType = appeon_constant.cs_shipstat OR &
	ls_DocumentType = appeon_constant.cs_LoadConfirmation THEN 
	
	li_Count = THIS.of_GetImagePaths ( anv_ptbeo.of_GEtSourceID ( ) , &
												anv_mailmsg.of_GetRequestingCompanyID ( ) , lsa_Paths )
	
	FOR i = 1 TO li_Count
	
		lnva_Attachment[i].FileType = MailAttach!
		lnva_Attachment[i].FileName = ""
		lnva_Attachment[i].pathName = lsa_Paths[i]
		lnva_Attachment[i].position = 0
	
	NEXT
	
	anv_mailmsg.of_ProcessAttachments ( lnva_Attachment )
	
END IF


RETURN li_Return

end function

private function integer of_setcontacts (ref pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessage);//
/***************************************************************************************
NAME			: of_SetContacts
ACCESS		: Private 
ARGUMENTS	: pt_n_cst_Beo 
				: n_cst_emailmessage
RETURNS		: Integer	(Number of contacts)
DESCRIPTION	: Finds contacts needed for email message. 
					If the message alread has a contact on it (status request reply) that will be used.
					
REVISION		: RDT 4-15-03
***************************************************************************************/

String 	ls_ExistingAddress[]

Long		lla_EmailTargets[]

Integer 	li_Return = 0

li_Return = ci_status_success
// check for existing email address in email messate
anv_emailmessage.of_GetTargetAddresses ( ls_ExistingAddress[] )

li_Return = UpperBound( ls_ExistingAddress[]  ) 

// if not found get targets from beo
If li_Return < 1  Then 
	li_Return = anv_beo.of_GetNotificationTargets ( lla_emailtargets[] )		// get email addresses from the beo
	// set target contacts on the emailmessage
	anv_emailmessage.of_addtargetcontactids ( lla_emailtargets[] )
End If

Return li_Return 

end function

private function integer of_setcompany (ref pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessageorig, ref n_cst_emailmessage anva_emailmessage[]);//
/***************************************************************************************
NAME			: of_SetCompany
ACCESS		: Private 
ARGUMENTS	: pt_n_cst_beo 		anv_Beo	by Ref
				: n_cst_EmailMessage	anv_EmailMessageOrig by Ref (Original email message)
				: n_cst_EmailMessage	anva_EmailMessage[] by Ref
RETURNS		: Integer (Number of email messages created)
DESCRIPTION	: Gets the email message and finds all the companies by the contact ids. 
				  Creates a new email message for each company

REVISION		: RDT 4-15-03
				: RDT 7-01-03 Code for new "No Address Icon"
***************************************************************************************/
Integer 	li_Return = 1

Long 		ll_CompanyID, &
			ll_OldCompanyId, &
			ll_ShipId, &
			ll_ContactID, &
			lla_emailtargets[] , &
			ll_RowCount, &
			ll_Count = 1 , &
			ll_CompanyCount
			
String	ls_DocumentType, &
			ls_CompanyCode, &
			ls_ContactAddress

Boolean 	lba_FoundOneEmailAddress[]		//RDT 7-01-03


			
ll_CompanyID  =  anv_EmailMessageOrig.of_getrequestingcompanyid ( )
ls_DocumentType = anv_beo.of_getdocumenttype ( )

If IsNull ( ll_CompanyID ) OR ll_CompanyID = 0 Then 
	// use datastore to get companies and create emailmessages
	n_ds lds_company
	lds_Company = Create n_ds

	lds_Company.Dataobject = 'd_companycodename'						// This groups the email addresses by company 
	lds_Company.SetTransObject(SQLCA)

	anv_beo.of_GetNotificationTargets ( lla_emailtargets[] )		// get email contact ids from the beo
	
	ll_ShipId = This.of_GetShipmentId ( anv_beo )					

	If UpperBound( lla_emailtargets[] ) < 1 Then 					// test for contact ids retrieved
		//li_Return = ci_status_error //RDT 7-01-03 
		li_Return = ci_status_NoAddr  //RDT 7-01-03 
		is_errormessage = "No contacts selected to send Email."
	Else
		ll_RowCount = lds_Company.Retrieve( lla_emailtargets[] ) 				// retrieve dw for all Id's 
		if ll_RowCount < 1 then 													//RDT 7-01-03 
			li_Return = ci_status_NoAddr  										//RDT 7-01-03 
			is_errormessage = "No contacts selected for Email."		//RDT 7-01-03 
		end if
	End If

	IF li_Return = ci_status_success Then 
		For ll_Count = 1 to ll_RowCount 	 																	// loop thru datastore and Create Email documents
			ll_CompanyId = lds_Company.GetItemNumber(ll_Count, 'companies_co_id')
			
			lba_FoundOneEmailAddress[ ll_Count ] = FALSE 	//RDT 7-01-03
			
			// RDT 5-13-03 -Start
			IF ll_CompanyID >  0 THEN
				if anv_beo.of_SendNotification( ll_CompanyID ) Then 
					// do nothing and continue to send email.
				else
					CONTINUE // skip this company
				end if
			END IF
			// RDT 5-13-03 -End 

			If ll_CompanyId <> ll_OldCompanyID OR IsNull ( ll_CompanyId ) then 

				ll_CompanyCount ++																				// new company, so create a new document of type email
				anva_EmailMessage[ ll_CompanyCount ].of_SetDocumentType ( ls_DocumentType  )  // set the document type on the email
	
				// set the rest
				anva_EmailMessage[ ll_CompanyCount ].of_SetShipmentId ( ll_ShipId )
					
				ls_CompanyCode = Trim ( lds_Company.GetItemString(ll_Count, 'companies_co_code_name' ) ) // Get the companycode name 

				If Len( ls_CompanyCode ) < 1 OR IsNull( ls_CompanyCode ) Then 															  
					ls_CompanyCode = Left( Trim( lds_Company.GetItemString( ll_Count, 'companies_co_name' ) ) , 5) // if no companycode then use first 5 char of name 
				End If	
				If IsNull( ls_CompanyCode ) Then 
					ls_CompanyCode = ''
				End If
					
				ls_ContactAddress = lds_Company.GetItemString( ll_Count, 'contacts_ct_emailaddress')
				
				If IsNull( ls_ContactAddress ) Then 
					// do nothing 
				Else	
					lba_FoundOneEmailAddress[ ll_Count ] = TRUE 		//RDT 7-01-03 End 
				
					anva_EmailMessage[ ll_CompanyCount ].of_AddTargetContactID( ll_ContactId  )
					anva_EmailMessage[ ll_CompanyCount ].of_SetBEO ( anv_beo )
					anva_EmailMessage[ ll_CompanyCount ].of_SetRequestingCompanyid ( ll_CompanyId )				
					anva_EmailMessage[ ll_CompanyCount ].of_SetFileName ( ls_CompanyCode ) 					// The real file name will be calculated in the document manager
					anva_EmailMessage[ ll_CompanyCount ].of_AddTargetAddress (  ls_ContactAddress )
					anva_EmailMessage[ ll_CompanyCount ].of_AddTargetContactID ( lds_Company.GetItemNumber( ll_Count, 'contacts_ct_id') )
					anva_EmailMessage[ ll_CompanyCount ].of_IsEmail( True )

				End If	

				ll_OldCompanyID = ll_CompanyId
				IF isNull ( ll_OldCompanyID ) THEN
					ll_OldCompanyID = 0 
				END IF
			Else
				// Same company so add the contact id & address to the current document
				ll_ContactId 		= lds_Company.GetItemNumber( ll_Count, 'contacts_ct_id') 
				ls_ContactAddress = lds_Company.GetItemString( ll_Count, 'contacts_ct_emailaddress')
				
				If IsNull( ls_ContactAddress ) Then 
					// do nothing 
				Else	
					lba_FoundOneEmailAddress[ ll_Count ] = TRUE 		//RDT 7-01-03
					anva_EmailMessage[ ll_CompanyCount ].of_AddTargetAddress (  ls_ContactAddress )
					anva_EmailMessage[ ll_CompanyCount ].of_AddTargetContactID( ll_ContactId  )
				End If
				
			End If
	
		Next
	END IF		
	
	Destroy lds_Company


Else
	// Copy the original email message to the a new one 
	anva_emailmessage[ll_Count] = anv_emailmessageorig
	anva_EmailMessage[ll_Count].of_SetDocumentType ( ls_DocumentType  ) 
	li_Return = 1
End If

//RDT 7-01-03 Check for missing addresses _Start 
For ll_count = 1 to UpperBound( lba_FoundOneEmailAddress[])
	If lba_FoundOneEmailAddress[ ll_count ] = FALSE Then 
		// throw error and stop loop
		li_Return = ci_status_NoAddr  //RDT 7-01-03 
		is_errormessage = "At least one company has no Email addresses."
		Exit
	End if
Next
//RDT 7-01-03 Check for missing addresses _End 

Return li_Return 
end function

public function integer of_createemaildocument_old (pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessage);Return -1
////  THIS IS THE OLD WAY
///***************************************************************************************
//NAME			: of_CreateEmailDocument ("of_Magic")
//ACCESS		: Public
//ARGUMENTS	: pt_n_cst_beo
//				: n_cst_EmailMessage
//RETURNS		: integer		(ci_status_success, ci_status_error)
//DESCRIPTION	: Creates an Email document from BEO and Email Message. 
//					A seperate email document is created for each Company in the beo.
//					The contacts and companies are retrieved into a datastore. The datastore is sorted by company id. 
//					Loop thru the datastore and create inv_EmailDocument[]'s for each company found.
//					Note inv_EmailDocument is set as autoinstantiate
//REVISION		: rdt 092602
//RDT 4-15-03 Check for Existing Addresses in anv_emailmessage
//***************************************************************************************/
//Boolean	lb_NeedsAddress
//Long		ll_Count 
//Long		ll_Data_Count 
//Long		ll_ContactId
//Long 		lla_emailtargets[] 
//Long 		ll_CompanyId
//Long		ll_OldCompanyId
//Long		ll_CompanyCount = 0 
//Long		ll_ShipId
//Long		ll_RowCount
//String	ls_FileName
//String	ls_CompanyCode
//String	ls_ContactAddress
//String	ls_ExistingAddress[]
//Integer	li_Return
//
//w_pop_progress lnv_pop
//Open(lnv_pop)
//lnv_pop.wf_settext ( "Creating Email Document")
//lnv_pop.wf_showbar ( False)
//
//n_cst_String lnv_String
//
//li_Return = ci_status_success
//
//n_cst_EmailMessage  lnv_BlankEmailDocument[]
//inv_EmailDocument[] = lnv_BlankEmailDocument[]					// resets the instance
//
//n_ds lds_company
//lds_Company = Create n_ds
//
//lds_Company.Dataobject = 'd_companycodename'						// This groups the email addresses by company 
//lds_Company.SetTransObject(SQLCA)
//
//n_cst_companies lnv_Companies											// create companies service
//lnv_Companies = create n_cst_companies 
//
//If Len( is_DocumentType ) < 1 Then 
//	is_DocumentType = anv_beo.of_getdocumenttype ( )
//End if
//
////If This.of_GetContactIds( anv_beo, anv_emailmessage, lla_emailtargets ) = 0 Then
////	//  no contacts found
////	li_Return = -1
////End If
//
//li_Return = anv_beo.of_GetNotificationTargets ( lla_emailtargets[] )		// get email addresses from the beo
//
//
//If UpperBound( lla_emailtargets[] ) < 1 Then 					// test for addresses retrieved
//	li_Return = ci_status_error
//	is_errormessage = "No address available to send Email."
//Else
//	lds_Company.Retrieve( lla_emailtargets[] ) 					// retrieve dw for all Id's 
//	ll_ShipId = This.of_GetShipmentId ( anv_beo )					
//	If IsNull ( ll_ShipId ) Then
//		li_Return = ci_status_error
//	End If
//
//End If
//
//
//If li_Return = ci_status_success Then 
//	ll_RowCount = lds_Company.RowCount()
//
//	For ll_Count = 1 to ll_RowCount 	 															// loop thru datastore and load Email document 
//		ll_CompanyId = lds_Company.GetItemNumber(ll_Count, 'companies_co_id')
//
//		If ll_CompanyId <> ll_OldCompanyID OR IsNull ( ll_CompanyID ) then 
//
//			ll_CompanyCount ++																	// new company, so create a new document of type email
//			inv_EmailDocument[ ll_CompanyCount ].of_SetDocumentType ( is_DocumentType  ) // set the document type on the email
//
//			IF isNull ( ll_CompanyID ) THEN
//				IF li_Return = ci_Status_Success THEN
//					If THIS.of_SetDefaultTemplate ( inv_EmailDocument[ ll_CompanyCount ]  ) <> 1 THEN
//						li_Return = ci_Status_Error
//					End If
//				END IF
//			ELSE
//	
//				IF li_Return = ci_Status_Success THEN
//					inv_EmailDocument[ ll_CompanyCount ].of_SetCompanyid ( ll_companyid ) // RDT 3-25-03 
//					// set template on document
//					If lnv_Companies.of_SetTemplateOnDocument ( inv_EmailDocument[ ll_CompanyCount ] , ll_CompanyId ) <> 1 THEN
//						li_Return = ci_Status_Error
//					End If
//				END IF
//			END IF
//
//			IF li_Return = ci_Status_Success THEN
//				// Populate Email Body 
//				If THIS.Of_PopulateEmailBody ( anv_beo, inv_EmailDocument[ ll_CompanyCount ] ) <> 1  Then
//					li_Return = ci_status_error
//				End If
//			END IF
//
//			IF li_Return = ci_Status_Success THEN
//				//  Populate Email Subject 
//				If THIS.Of_PopulateEmailSubject ( anv_beo , inv_EmailDocument[ ll_CompanyCount ] ) <> 1 THEN
//					li_Return = ci_Status_Error
//				End If
//			END IF
//			
//			IF li_Return = ci_Status_Success THEN
//				// Process Attachments
//				If THIS.of_ProcessAttachments ( anv_beo , inv_EmailDocument[ ll_CompanyCount ] ) <> 1 THEN
//					li_Return = ci_Status_Error
//				End If
//			END IF
//
//			IF li_Return = ci_Status_Success THEN
//				// set the rest
//				inv_EmailDocument[ ll_CompanyCount ].of_SetShipmentId ( ll_ShipId )
//				
//				ls_CompanyCode = Trim ( lds_Company.GetItemString(ll_Count, 'companies_co_code_name' ) ) // Get the companycode name 
//				If Len( ls_CompanyCode ) < 1 OR IsNull( ls_CompanyCode ) Then 															  
//					ls_CompanyCode = Left( Trim( lds_Company.GetItemString( ll_Count, 'companies_co_name' ) ) , 5) // if no companycode then use first 5 char of name 
//				End If	
//				If IsNull( ls_CompanyCode ) Then 
//					ls_CompanyCode = ''
//				End If
//				
//				If IsNull (ls_ContactAddress ) Then 
//					ls_ContactAddress = lds_Company.GetItemString( ll_Count, 'contacts_ct_emailaddress')
//				End If
//				inv_EmailDocument[ ll_CompanyCount ].of_AddTargetContactID( ll_ContactId  )
//				inv_EmailDocument[ ll_CompanyCount ].of_SetBEO ( anv_beo )
//				inv_EmailDocument[ ll_CompanyCount ].of_SetCompanyid ( ll_CompanyId )
//				inv_EmailDocument[ ll_CompanyCount ].of_SetFileName ( ls_CompanyCode ) 					// The real file name will be calculated in the document manager
//				inv_EmailDocument[ ll_CompanyCount ].of_AddTargetAddress (  ls_ContactAddress )
//				inv_EmailDocument[ ll_CompanyCount ].of_AddTargetContactID ( lds_Company.GetItemNumber( ll_Count, 'contacts_ct_id') )
//				inv_EmailDocument[ ll_CompanyCount ].of_IsEmail( True )
//				ll_OldCompanyID = ll_CompanyId
//
//				IF isNull ( ll_OldCompanyID ) THEN
//					ll_OldCompanyID = 0 
//				END IF
//			END IF
//			
//		Else
//			// Same company so add the contact id & address to the current document
//			ll_ContactId 		= lds_Company.GetItemNumber( ll_Count, 'contacts_ct_id') 
//			If IsNull (ls_ContactAddress ) Then 
//				ls_ContactAddress = lds_Company.GetItemString( ll_Count, 'contacts_ct_emailaddress')
//			End If
//			If IsNull( ls_ContactAddress ) Then 
//				// skip it
//			Else
//				inv_EmailDocument[ ll_CompanyCount ].of_AddTargetAddress (  ls_ContactAddress )
//				inv_EmailDocument[ ll_CompanyCount ].of_AddTargetContactID( ll_ContactId  )
//			End If
//		
//		End If
//			
//	Next			
//
//End If	
//
//Destroy  lds_Company
//Destroy  lnv_Companies 
//
//Close(lnv_pop)
//
//return li_Return 
end function

public function integer of_createemaildocument (ref pt_n_cst_beo anv_beo, ref n_cst_emailmessage anv_emailmessage, ref n_cst_emailmessage anva_emailmessage[]);//
/***************************************************************************************
NAME			: of_CreateEmailsDocument ("of_Magic, The gathering")
ACCESS		: Public
ARGUMENTS	: pt_n_cst_beo         ref
				: n_cst_EmailMessage   ref
				: anva_EmailMessage[]  ref
RETURNS		: integer		(ci_status_success, ci_status_error)
DESCRIPTION	: Creates an Email document from BEO and Email Message. 
					A seperate email document is created for each Company in the beo.
					The contacts and companies are retrieved into a datastore. The datastore is sorted by company id. 
					Loop thru the datastore and create inv_EmailDocument[]'s for each company found.
					Note inv_EmailDocument is set as autoinstantiate
REVISION		: rdt 092602
RDT 4-15-03 Check for Existing Addresses in anv_emailmessage
RDT 5-13-03 Call to verify customer wants notification for event type

***************************************************************************************/
Long		ll_Count, &
			ll_Upper, &
			ll_CompanyID 

Integer	li_Return

n_cst_String lnv_String

li_Return = ci_status_success

n_cst_EmailMessage	lnva_EmailMessage [] 

n_cst_bso_Email_Manager	lnv_EmailManager
lnv_EmailManager = CREATE n_cst_bso_Email_Manager

This.of_SetContacts( anv_beo, anv_EmailMessage) 							// Set the contacts on the email document
li_Return = This.of_SetCompany( anv_beo, anv_EmailMessage, lnva_EmailMessage[]) 	// Set the Companies on the email document

If li_Return = ci_status_success Then 
	ll_Upper = UpperBound( lnva_EmailMessage[] ) 

	For ll_Count = 1 to ll_Upper 
	
			ll_CompanyID = lnva_EmailMessage[ll_Count].of_GetRequestingCompanyid ( )
						
			IF isNull ( ll_CompanyID ) or  ll_CompanyID = 0 THEN
				IF li_Return = ci_Status_Success THEN
					If THIS.of_SetDefaultTemplate ( lnva_EmailMessage[ ll_Count ]  ) <> 1 THEN
						li_Return = ci_Status_Error
					End If
				END IF
			ELSE
				IF li_Return = ci_Status_Success THEN
					lnva_EmailMessage[ ll_Count ].of_SetCompanyid ( ll_companyid ) // RDT 3-25-03 
					// set template on document
					If gnv_cst_companies.of_SetTemplateOnDocument ( lnva_EmailMessage[ ll_Count ] , ll_CompanyId ) <> 1 THEN
						li_Return = ci_Status_Error
					End If
				END IF
			END IF

			IF li_Return = ci_Status_Success THEN
				// Populate Email Body 
				If THIS.Of_PopulateEmailBody ( anv_beo, lnva_EmailMessage[ ll_Count ] ) <> 1  Then
					li_Return = ci_status_error
				End If
			END IF

			IF li_Return = ci_Status_Success THEN
				//  Populate Email Subject 
				If THIS.Of_PopulateEmailSubject ( anv_beo , lnva_EmailMessage[ ll_Count ] ) <> 1 THEN
					li_Return = ci_Status_Error
				End If
			END IF

			IF li_Return = ci_Status_Success THEN
				// Process Attachments
				If THIS.of_ProcessAttachments ( anv_beo , lnva_EmailMessage[ ll_Count ] ) <> 1 THEN
					li_Return = ci_Status_Error
				End If
			END IF

	Next			

End If	


anva_EmailMessage[] = lnva_EmailMessage[ ]

return li_Return 
end function

private function integer of_processnotificationrequest (pt_n_cst_beo anv_ptbeo, n_cst_emailmessage anv_emailmsg, ref n_cst_emailmessage anva_emailmsg[]);
/***************************************************************************************

NAME: 			of_ProcessNotificationRequest	(overloaded)

ACCESS:			Private
	
ARGUMENTS: 		pt_n_cst_beo, the data source for the notification
					anv_EMailMsg, 
					anva_emailmsg[]

RETURNS:			
	
DESCRIPTION:


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
REVISION HISTORY : RZ
						 RDT 092602 - modified to create email Documents 
***************************************************************************************/
String 	ls_Error
Int		li_Return  = 1
Int		li_Result
Integer	li_Count

n_cst_licenseManager	lnv_Lic

IF NOT lnv_lic.of_HasNotificationLicense ( ) THEN
	li_Return = ci_Status_Error
END IF

// RDT 092602 Start
If li_Return = ci_status_success Then 
	li_Result = This.of_CreateEmailDocument ( anv_ptbeo, anv_emailmsg, anva_EmailMsg[]) 
End If

li_Return = li_Result 

Return li_Return

// RDT 092602 end

// RDT 092602 Commented Code below is replaced by document processing code above.
/*
IF li_Return = ci_Status_Success THEN
	IF THIS.of_PopulateEMailTargets ( anv_ptbeo , anv_emailmsg ) <> 1 THEN
		li_Return = ci_Status_Error
	END IF
END IF

IF li_Return = ci_Status_Success THEN
	// get the template that should be populated
	IF THIS.of_GetTemplate ( anv_ptbeo , anv_emailmsg ) <> 1 THEN
		li_Return = ci_Status_Error
	END IF
END IF

IF li_Return = ci_Status_Success THEN
	IF THIS.Of_PopulateEmailSubject (anv_ptbeo , anv_emailmsg ) <> 1 THEN
		li_Return = ci_Status_Error
	END IF
END IF

	
IF li_Return = ci_Status_Success THEN
	IF THIS.Of_PopulateEmailBody (  anv_ptbeo , anv_emailmsg) <> 1 THEN
		li_Return = ci_Status_Error
	END IF
END IF

	
IF li_Return = ci_Status_Success THEN
	IF THIS.of_ProcessAttachments ( anv_ptbeo , anv_emailmsg ) <> 1 THEN
		li_Return = ci_Status_Error
	END IF
END IF
Return li_Return

*/


end function

public function integer of_eventcompanycontact (readonly long al_companyid, ref n_cst_beo_event anv_event, boolean ab_add);//
/***************************************************************************************
NAME			: of_EventCompanyContact
ACCESS		: Public 

ARGUMENTS	: Long				al_companyid
				  n_cst_beo_Event	anv_event
				  Boolean			ab_add  (True = add contacts, False = Delete contacts)
				  
RETURNS		: Integer	( 1 = success, -1 = failed)	
DESCRIPTION	: Adds company contacts to event 

REVISION		: RDT 5-13-03
***************************************************************************************/

Long		ll_ShipmentId, &
			lla_CompanyId[], &
			lla_Contacts[]
			
Integer	li_Return = 1 , &
			li_Upper, &
			i

IF al_CompanyId =  0 THEN 
	Return -1  // MIDCODE RETURN 
End If

If NOT anv_Event.of_IsCrossDock( ) Then //RDT 8-27-03

	anv_Event.of_SetAllowFilterSet ( TRUE )

	DataStore	lds_Source
	lds_Source = CREATE DataStore
	lds_Source.DataObject = "d_notificationRecipients"
	lds_Source.SetTransObject ( SQLCA )

	n_cst_beo_Company 	lnv_Company 
	lnv_Company = CREATE n_cst_beo_Company

	n_cst_ContactManager lnv_ContactManager
	lnv_ContactManager = Create n_cst_ContactManager 

	lla_CompanyId[1] = al_companyid
	gnv_cst_companies.of_Cache( lla_companyid[] , TRUE /*refresh*/)	
	lnv_Company.of_SetUseCache ( TRUE )

	If NOT lnv_company.of_HasSource() Then 
		lnv_company.of_Setsourceid ( al_CompanyId )
	Else
		MessageBox("Program Error","Company has no Source")
		Return -1
	End if
	
	If isValid ( lnv_Company ) Then 
		lnv_ContactManager.of_GetAllContactsForCompany ( lnv_Company, lla_Contacts ) 
		IF UpperBound ( lla_Contacts ) > 0 THEN
			lds_Source.Retrieve ( lla_Contacts ) 
			COMMIT;
		END IF
		// get company Event notification contacts		
		lnv_ContactManager.of_GetEventContacts ( lds_Source, lla_Contacts )
	Else 
		li_Return = -1
	End if
	
	// RDT 8-12-03 - Start
	If ab_Add Then 
		IF This.of_iscompanyevent ( al_companyid, anv_event ) Then 
			li_Return = 1 
		else
			li_Return = -1 
		End IF
	End If
	// RDT 8-12-03 - End

	If li_Return = 1 Then 
		if ab_Add then 

		// ADD contacts into event.
			li_Upper = UpperBound ( lla_Contacts )
			For i = 1 to li_Upper
				anv_event.of_AddContactId ( lla_Contacts [i] )
			Next
		else
		// DELETE contacts from event.
			li_Upper = UpperBound ( lla_Contacts )
			For i = 1 to li_Upper
				anv_event.of_RemoveContactId ( lla_Contacts [i] )
			Next
			
		end if
	End If

	DESTROY ( lds_Source )
	DESTROY ( lnv_Company )
	DESTROY ( lnv_ContactManager )

END IF 

Return li_Return 

end function

public function integer of_updatenotificationtable ();// RDT 5-28-03 

Integer 	li_Return 
li_Return = ids_notestatus.Update ( ) 

IF li_Return = 1 then 
	ids_noteStatus.Reset()
End IF

Return li_Return 
end function

private subroutine of_setwhereclause (ref n_ds ands_datastore, readonly string as_topic, readonly long al_sourceid, readonly string as_doctype);// of_SetWhereClause
// RDT 5-28-03 
Long	ll_pos
String 	ls_NewSelect, &
			ls_WherePart

///Strip off any current where clause
ls_NewSelect = ands_datastore.GetSQLSelect()

ll_pos = pos( UPPER( ls_NewSelect ) , "WHERE" )
If ll_pos > 0 Then 
	ls_NewSelect = Left( ls_NewSelect  , ll_pos - 1 )
End If

ls_NewSelect = ls_NewSelect + "WHERE ( "

ls_WherePart = "notificationstatus.notificationtopic = " + "'" + as_topic + "'" 

ls_NewSelect = ls_NewSelect + ls_Wherepart + ") and (" 

// this used to have ' around the al_sourceID
ls_WherePart = "notificationstatus.sourceid = " +  String( al_sourceid ) 

ls_NewSelect = ls_NewSelect + ls_Wherepart + ") and ("

ls_WherePart ="notificationstatus.documenttype = " + "'" + as_doctype + "'" 

ls_NewSelect = ls_NewSelect + ls_Wherepart +")"




//// Set new Select
ands_datastore.SetSQLSelect( ls_NewSelect )





end subroutine

public subroutine of_setwherepending (ref n_ds ands_datastore);// of_SetWherePending
// RDT 5-28-03 
Long	ll_pos
String 	ls_NewSelect

ls_NewSelect = ands_datastore.Describe( "DataWindow.Table.Select" )

//Strip off any current where clause
ll_pos = pos( UPPER( ls_NewSelect ) , "WHERE" )
If ll_pos > 0 Then 
	ls_NewSelect = Left( ls_NewSelect , ll_pos - 1 )
End If

// Set new where 
ls_NewSelect = ls_NewSelect + "WHERE ( "+ '~~"notificationstatus~~".~~"notificationstatus~~" = 0'+")"

ands_datastore.Modify( "DataWindow.Table.Select='" + ls_NewSelect + "'")


end subroutine

public function integer of_updatespending ();//
/***************************************************************************************
NAME			: of_IsPendingNoteSave
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: Integer	(1 = Yes, 0 = no) 	
DESCRIPTION	: Checks for any pending saves on the ids_NoteStatus 

REVISION		: RDT 5-28-03
				: call overloaded version <<*>> rpz 6/6/03
***************************************************************************************/

RETURN THIS.of_UpdatesPending ( n_Cst_bso_Dispatch )
end function

public function integer of_updatespending (n_cst_bso_dispatch anv_dispatch);
/***************************************************************************************
NAME			: of_IsPendingNoteSave
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: Integer	(1 = Yes, 0 = no) 	
DESCRIPTION	: Checks for any pending saves on the ids_NoteStatus 

REVISION		: RDT 5-28-03
				: overloaded to use dispatch <<*>> rpz 6/6/03
***************************************************************************************/
Integer 	li_Return = 0

IF IsValid ( anv_Dispatch ) THEN
	THIS.of_RemoveUnwarrantedNotifications ( anv_Dispatch )
END IF

If ids_NoteStatus.ModifiedCount ( ) > 0 Then 
	li_Return = 1
End If

If ids_NoteStatus.DeletedCount ( ) > 0 Then 
	li_Return = 1
End If


Return li_Return 
end function

public function integer of_removeunwarrantednotifications (n_cst_bso_dispatch anv_dispatch);/*
	this method will remove pending notifications from the cache and DB if it should not be sent. 
	this is mainly for ACCESORIAL NOTE b/c the pending note is created when the item is added and at that point we don't 
	know the amount type so we can't determine if it should sent at that point. 

*/
Int	li_Return = 1
Long	ll_RowCount 
Long	ll_NoteIndex
Long	ll_ItemIndex
Long	ll_ItemCount
Long	ll_ShipID
Long	ll_ShipmentCount
Long	i
Long	lla_ShipmentIds []
String	ls_OldFilter
String	ls_Filter
Boolean	lb_Keep

n_cst_beo_Item	lnv_Item
DataStore	lds_ItemCache
DataStore	lds_ItemCacheCopy
n_cst_AnyArraySrv	lnv_Array
n_cst_beo_Shipment	lnv_Shipment

n_Cst_beo_Item	lnva_Items[]
n_Cst_beo_Item	lnva_EmptyItems[]

lnv_Item = CREATE n_cst_beo_item
lds_ItemCacheCopy = CREATE DataStore
lnv_Shipment = CREATE n_cst_beo_Shipment

IF isValid ( anv_Dispatch ) THEN
	lds_ItemCache = anv_Dispatch.of_GetItemCache ( )
ELSE
	li_Return = -1
END IF

ls_Filter = "notificationstatus = " + String ( THIS.ci_status_Pending ) + " AND documenttype = '" + appeon_constant.cs_acc + "'"

IF li_Return = 1 THEN
	
	n_cst_dws	lnv_dws

	lds_ItemCacheCopy.DataObject  = lds_ItemCache.DataObject
	// this keeps the itemStatus
	lnv_dws.of_rowscopy ( lds_ItemCache, 1, lds_ItemCache.RowCount ( ), Primary!, lds_ItemCacheCopy, PRIMARY! )
	lnv_dws.of_rowscopy ( lds_ItemCache, 1, lds_ItemCache.FilteredCount ( ), FILTER!, lds_ItemCacheCopy, PRIMARY! )

	// use the real rows copy so the row status is changed
	lds_ItemCache.RowsCopy (1, lds_ItemCache.DeletedCount ( ), DELETE!, lds_ItemCacheCopy, 999, 	PRIMARY! )
	
	
	ids_NoteStatus.setFilter ( ls_Filter )
	ids_NoteStatus.Filter( )
	
	ll_RowCount =  ids_NoteStatus.RowCount (  )
	
	IF ll_RowCount > 0 THEN 
	// I don't think it will ever find an accessorial notification in the cache since I changed the way
	// the accessorail creation happens ( at pre save of the dispatch )
	// but I am going to leave it here just in case.
		
		FOR ll_NoteIndex = ll_RowCount TO 1 STEP -1
			lb_Keep = FALSE
			
			ll_ShipID = ids_NoteStatus.GetItemNumber ( ll_NoteIndex , "sourceid" )
			lds_ItemCacheCopy.SetFilter ( "di_shipment_id = " + String ( ll_ShipID ) )
			lds_ItemCacheCopy.Filter ( )
			lnv_Item.of_SetSource ( lds_ItemCacheCopy ) 
			ll_ItemCount = lds_ItemCacheCopy.RowCount ( ) 
			// the only way we are going to get rid of a pending notification 
			// is if all the items on the shipment are flagged to not notify
			FOR ll_ItemIndex = 1 TO ll_ItemCount				
				lnv_Item.of_SetSourceRow ( ll_ItemIndex )
				
				IF lnv_Item.of_SendNotification ( ) THEN // keep
					lb_Keep = TRUE 
					EXIT
				END IF
									
			NEXT
			
			IF NOT lb_Keep THEN // remove Pending notificatation from cache
				ids_NoteStatus.DeleteRow ( ll_NoteIndex )
			END IF
			
		NEXT
		
		
	ELSE
		
//		need to check the db bc it is not in the cache

		ll_RowCount = lds_ItemCacheCopy.RowCount ( )
					
		// we are only going to check modified rows bc it would take a modified row
		// to remove a notification
		FOR ll_ItemIndex = 1 TO ll_RowCount 
			IF lds_ItemCacheCopy.getItemStatus ( ll_ItemIndex , 0 , PRIMARY!) <> NotModified! THEN
				lla_ShipmentIds[ UpperBound  ( lla_ShipmentIds ) + 1 ]  = lds_ItemCacheCopy.GetItemNumber ( ll_ItemIndex , "di_shipment_id" )		
			END IF		
		NEXT
		
		lnv_Array.of_GetShrinked ( lla_ShipmentIds , TRUE , TRUE )
				
		ll_ShipmentCount = UpperBound ( lla_ShipmentIds )
		lnv_Shipment.of_SetSource ( anv_Dispatch.of_GetShipmentCache ( ) ) 
		lnv_SHipment.of_SetItemSource ( anv_Dispatch.of_GetItemCache () )
	
		lnv_Shipment.of_setDocumentType ( appeon_constant.cs_acc )
	
		For i = 1 to ll_ShipmentCount
			lb_Keep = FALSE
			lnv_Shipment.of_SetSourceID ( lla_ShipmentIDs [ i ] )
			lnv_Shipment.of_GetItemList ( lnva_Items )
			ll_ItemCount = UpperBound ( lnva_Items )
			FOR ll_ItemIndex = 1 TO ll_ItemCount
				IF lnva_Items[ ll_ItemIndex ].of_SendNotification ( ) THEN // keep
					lb_Keep = TRUE 
				END IF
			NEXT
			
			IF NOT lb_Keep THEN
				THIS.of_RemovePendingNotification ( lnv_SHipment )
			END IF
			
			lnv_array.of_Destroy ( lnva_Items )
			lnva_Items = lnva_EmptyItems
		NEXT
		
					
	END IF
	
END IF

ids_NoteStatus.setFilter ( "" )
ids_NoteStatus.Filter( )

DESTROY ( lnv_Shipment ) 
Destroy ( lnv_Item )
Destroy ( lds_ItemCacheCopy )

RETURN li_Return
end function

private function integer of_logerror (string as_Error);//
/***************************************************************************************
NAME			: of_LogError
ACCESS		: Private 
ARGUMENTS	: String	as_error
RETURNS		: integer (1=success, -1=failed)
DESCRIPTION	: Opens the notification log file and writes the error to it.

REVISION		: RDT 6-26-03
***************************************************************************************/

Integer 	li_FileNum, &
			li_Return 
String 	ls_Error = ""

li_Return = 1

li_FileNum = FileOpen ( "c:\NoteLog.txt" , LineMode!, Write!, LockWrite!, Append! )

ls_Error += String( Today() , "yyyy/mmm/dd hh:mm:ss ") + "  "

ls_Error += as_error

IF FileWrite( li_FileNum, ls_Error) = -1 then 
	li_Return = -1 
ELSE 
	li_Return = 1
END IF
	
FileClose(li_FileNum)

Return li_Return 
end function

public function boolean of_iscompanyevent (readonly long al_companyid, readonly n_cst_beo_event anv_event);//
/***************************************************************************************
NAME			: of_IsCompanyEvent
ACCESS		: Public 
ARGUMENTS	: Long				al_Companyid
				  n_cst_beo_event	anv_event
				  
RETURNS		: Boolean	
DESCRIPTION	: Checks company rule to see if company contacts should be added to event 

REVISION		: RDT 5-13-03
***************************************************************************************/

String	ls_Origin, &
			ls_Destination

Boolean 	lb_Return = FALSE, &
			lb_Inbound, &
			lb_Outbound

Long		ll_ShipmentId, &
			ll_ShipOriginID, &
			ll_ShipDestID

IF al_CompanyId =  0 or IsNull( al_CompanyId ) Then 
	lb_Return = TRUE
ELSE 


	n_cst_bso_Dispatch	lnv_Dispatch
	n_cst_beo_Shipment	lnv_Shipment
	n_cst_beo_Company		lnv_Company
		
	If anv_event.of_GetShipment( lnv_Shipment ) <> 1 then 
//		messagebox("Program error","No lnv_Shipment on event")
		Return lb_Return  // Mid-Code Return		
	end if
	
	lnv_Dispatch = CREATE n_cst_bso_Dispatch
	lnv_Company	 = CREATE n_cst_beo_Company		
				
	lnv_Company.of_SetUseCache ( TRUE )

	// get company notification settings
	If NOT lnv_company.of_HasSource() Then 
		lnv_company.of_Setsourceid ( al_CompanyId )		
	End if
	
	ls_Destination = lnv_Company.of_GetNotificationEventDestination ( )
	ls_Origin 		= lnv_Company.of_GetNotificationEventOrigin ( )
	
	ll_ShipOriginID = lnv_shipment.of_getorigin ( ) 
	ll_ShipDestID	 = lnv_shipment.of_getdestination ( )

	If anv_event.of_IsPickupGroup() Then 
		Choose Case ls_Origin 
			Case n_cst_constants.cs_notificatioevent_orig
				// check if event is an origin
				if anv_event.of_IsOrigin( ll_ShipOriginID ) Then 
					lb_Return = TRUE

				end if
	
			Case n_cst_constants.cs_notificatioevent_hmp
				// check event type
				if anv_event.of_IsPickupGroup() Then 
					lb_Return = TRUE

				end if
				
			Case Else
				lb_Return = FALSE
		End Choose

	End If
	
	If anv_event.of_IsDeliverGroup() Then 
		Choose Case ls_Destination 
			Case n_cst_constants.cs_notificatioevent_dest
				// check if event is a Destination 
					if anv_event.of_isDestination ( ll_ShipDestID ) Then 
						lb_Return = TRUE
					end if
	
			Case n_cst_constants.cs_notificatioevent_drn
				// check event type
				if anv_event.of_isDeliverGroup ( ) Then 
					lb_Return = TRUE
				end if
				
			Case Else
				lb_Return = FALSE
		End Choose
	End If	

	Destroy ( lnv_Dispatch )
	Destroy ( lnv_Company )  // RDT 8-12-03

	
END IF 

Return lb_Return 

end function

public function integer of_checkforaccessorialnotifications (n_cst_bso_dispatch anv_dispatch);Int	li_Return = 1
Long	ll_ItemIndex
Long	ll_ItemCount

n_cst_beo_Shipment	lnv_Shipment
n_cst_beo_Item			lnv_Item
DataStore				lds_ItemCache

lnv_Shipment = CREATE n_cst_beo_Shipment
lnv_Item = CREATE n_cst_beo_item

lnv_Shipment.of_setDocumentType ( appeon_constant.cs_acc )	

IF isValid ( anv_Dispatch ) THEN
	lds_ItemCache = anv_Dispatch.of_GetItemCache ( )
	lnv_Shipment.of_SetSource( anv_Dispatch.of_GetShipmentCache () )

ELSE
	li_Return = -1
END IF


IF li_Return = 1 THEN
	ll_ItemCount = lds_ItemCache.RowCount ( ) 
	FOR ll_ItemIndex = 1 TO ll_ItemCount
		
		IF lds_ItemCache.GetItemStatus ( ll_ItemIndex , 0 , PRIMARY! ) <> NotModified! THEN  // see if it is warrented
			lnv_Item.of_SetSource ( lds_ItemCache ) 
			lnv_Item.of_SetSourceRow ( ll_ItemIndex )
			
			IF lnv_Item.of_SendNotification ( ) THEN // keep
				lnv_Shipment.of_SetSourceID ( lnv_Item.of_GetShipment ( ) )				
				THIS.of_CreatePendingNotification ( lnv_SHipment )				
			END IF
			
		END IF
			
	NEXT
	
	ll_ItemCount = lds_ItemCache.FilteredCount ( ) 
	FOR ll_ItemIndex = 1 TO ll_ItemCount
		
		IF lds_ItemCache.GetItemStatus ( ll_ItemIndex , 0 , Filter! ) <> NotModified! THEN  // see if it is warrented
			lnv_Item.of_SetSource ( lds_ItemCache ) 
			lnv_Item.of_SetSourceRow ( ll_ItemIndex )
			
			IF lnv_Item.of_SendNotification ( ) THEN // keep
				lnv_Shipment.of_SetSourceID ( lnv_Item.of_GetShipment ( ) )				
				THIS.of_CreatePendingNotification ( lnv_SHipment )				
			END IF
			
		END IF
			
	NEXT
	
END IF

Destroy ( lnv_Item )
DESTROY ( lnv_Shipment )

RETURN li_Return
end function

protected function integer of_adderror (string as_error);String				ls_ErrorMessage
n_cst_OFRError		lnv_Error

lnv_Error = This.AddOFRError ( )

ls_ErrorMessage = as_error 

lnv_Error.SetErrorMessage( ls_ErrorMessage )
lnv_Error.SetMessageHeader ( "Notification" )

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

protected function integer of_sendfailurenotification (n_cst_emailmessage anv_mailmsg);Int	li_Return
n_cst_bso_email_manager	lnv_EmailMan
lnv_EmailMan = CREATE n_cst_bso_email_manager

li_Return = lnv_EmailMan.of_Sendmail( anv_mailmsg )

DESTROY ( lnv_EmailMan )


RETURN li_Return
end function

on n_cst_bso_notification_manager.create
call super::create
end on

on n_cst_bso_notification_manager.destroy
call super::destroy
end on

event destructor;call super::destructor;DESTROY ( inv_Dispatch )
DESTROY ( ids_notestatus )

end event

event constructor;call super::constructor;//// rdt 092602 ids_notestatus = CREATE DataStore
ids_notestatus = CREATE n_ds
ids_notestatus.DataObject = "d_notificationStatus"
ids_notestatus.SetTransObject ( SQLCA )
//ids_notestatus.Retrieve ( )


end event

