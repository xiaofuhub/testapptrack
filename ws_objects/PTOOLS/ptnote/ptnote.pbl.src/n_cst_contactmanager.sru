$PBExportHeader$n_cst_contactmanager.sru
forward
global type n_cst_contactmanager from n_base
end type
end forward

global type n_cst_contactmanager from n_base
end type
global n_cst_contactmanager n_cst_contactmanager

forward prototypes
public function integer of_getaccauthcontacts (powerobject apo_source, ref long ala_contactsids[])
public function integer of_getaccnotecontacts (powerobject apo_source, ref long ala_contactids[])
public function integer of_geteventcontacts (powerobject apo_source, ref long ala_contactids[])
public function integer of_getshipmentcontacts (powerobject apo_source, ref long ala_contactids[])
public function integer of_getlastfreedatecontacts (powerobject apo_source, ref long ala_contactids[])
public function integer of_getaccauthcontacts (powerobject apo_source, ref long ala_contactsids[], boolean ab_checkfilter)
public function integer of_getaccnotecontacts (powerobject apo_source, ref long ala_contactsids[], boolean ab_checkfilter)
public function integer of_geteventcontacts (powerobject apo_source, ref long ala_contactids[], boolean ab_checkfilter)
public function integer of_getlastfreedatecontacts (powerobject apo_source, ref long ala_contactids[], boolean ab_checkfilter)
public function integer of_getshipmentcontacts (powerobject apo_source, ref long ala_contactids[], boolean ab_checkfilter)
public function integer of_getallcontactsforcompany (n_cst_beo_company anv_company, ref long ala_ids[])
public function integer of_getcontactidsfromaddresses (string asa_Addresses[], ref long ala_ContactIds[])
public function long of_getcontactidforrecipient (mailrecipient anv_recipient)
public function boolean of_doesrolepermitnotification (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company)
public function integer of_addcontactsifneeded (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company, string as_role)
public function integer of_addallcontactstoshipment (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company)
public function integer of_removecontactsifneeded (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company)
public function integer of_removeallcontactsfromshipment (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company)
private function integer of_shouldcontactsexist (n_cst_beo_Shipment anv_Shipment, n_cst_beo_Company anv_Company)
private function boolean of_docontactsexist (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company)
end prototypes

public function integer of_getaccauthcontacts (powerobject apo_source, ref long ala_contactsids[]);RETURN THIS.of_GetAccAuthContacts ( apo_source , ala_contactsids[] , FALSE ) 



end function

public function integer of_getaccnotecontacts (powerobject apo_source, ref long ala_contactids[]);RETURN THIS.of_GetAccNoteContacts ( apo_source , ala_contactids[ ] , FALSE )


end function

public function integer of_geteventcontacts (powerobject apo_source, ref long ala_contactids[]);RETURN THIS.of_GetEventContacts ( apo_source , ala_contactids[ ] , FALSE )
end function

public function integer of_getshipmentcontacts (powerobject apo_source, ref long ala_contactids[]);RETURN THIS.of_GetShipmentContacts ( apo_source , ala_contactids[] , FALSE ) 
end function

public function integer of_getlastfreedatecontacts (powerobject apo_source, ref long ala_contactids[]);RETURN THIS.of_GetLastFreeDateContacts ( apo_source , ala_contactids[] , FALSE )
end function

public function integer of_getaccauthcontacts (powerobject apo_source, ref long ala_contactsids[], boolean ab_checkfilter);Long		lla_Contacts[]
Long		ll_RowCount
Long		ll_i

n_cst_dws	lnv_Dws

ll_RowCount = lnv_Dws.of_RowCount ( apo_Source ) 

FOR ll_i = 1 TO ll_rowCount
	IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonaccauth" ) = 1 THEN
		lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" )
	END IF
NEXT


IF ab_checkfilter THEN
	
	ll_RowCount = lnv_Dws.of_FilteredCount ( apo_Source ) 

	FOR ll_i = 1 TO ll_rowCount
		IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonaccauth", FILTER! , FALSE ) = 1 THEN
			lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id", FILTER! , FALSE )
		END IF
	NEXT
END IF

ala_ContactsIds[] = lla_Contacts

Return UpperBound ( ala_ContactsIds[] )



end function

public function integer of_getaccnotecontacts (powerobject apo_source, ref long ala_contactsids[], boolean ab_checkfilter);
Long		lla_Contacts[]
Long		ll_RowCount
Long		ll_i

n_cst_dws	lnv_Dws

ll_RowCount = lnv_Dws.of_RowCount ( apo_Source ) 

FOR ll_i = 1 TO ll_rowCount
	IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonaccnote" ) = 1 THEN
		lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" )
	END IF

NEXT

IF ab_CheckFilter THEN	
	ll_RowCount = lnv_Dws.of_FilteredCount ( apo_Source ) 
	FOR ll_i = 1 TO ll_rowCount
		IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonaccnote", filter!, FALSE ) = 1 THEN
			lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" ,filter!, FALSE )
		END IF
	NEXT
END IF

ala_ContactsIds[] = lla_Contacts

Return UpperBound ( ala_ContactsIds[] )



end function

public function integer of_geteventcontacts (powerobject apo_source, ref long ala_contactids[], boolean ab_checkfilter);Long		lla_Contacts[]
Long		ll_RowCount
Long		ll_i

n_cst_dws	lnv_Dws

ll_RowCount = lnv_Dws.of_RowCount ( apo_Source ) 

FOR ll_i = 1 TO ll_rowCount
	IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonevent" ) = 1 THEN
		lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" )
	END IF
NEXT

IF ab_CheckFilter THEN
	ll_RowCount = lnv_Dws.of_FilteredCount ( apo_Source ) 
	FOR ll_i = 1 TO ll_rowCount
		IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonevent", FILTER! , FALSE ) = 1 THEN
			lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" , FILTER! , FALSE  )
		END IF
	NEXT
END IF

ala_ContactIds[] = lla_Contacts

Return UpperBound ( ala_ContactIds[] )



end function

public function integer of_getlastfreedatecontacts (powerobject apo_source, ref long ala_contactids[], boolean ab_checkfilter);Long		lla_Contacts[]
Long		ll_RowCount
Long		ll_i

n_cst_dws	lnv_Dws

ll_RowCount = lnv_Dws.of_RowCount ( apo_Source ) 

FOR ll_i = 1 TO ll_rowCount
	IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonlfd" ) = 1 THEN
		lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" )
	END IF
NEXT

IF ab_CheckFilter THEN  
	ll_RowCount = lnv_Dws.of_FilteredCount ( apo_Source ) 
	FOR ll_i = 1 TO ll_rowCount
		IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonlfd" , FILTER! , FALSE ) = 1 THEN
			lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" , FILTER! , FALSE ) 
		END IF
	NEXT
	
END IF

ala_ContactIds[] = lla_Contacts

Return UpperBound ( ala_ContactIds[] )



end function

public function integer of_getshipmentcontacts (powerobject apo_source, ref long ala_contactids[], boolean ab_checkfilter);Long		lla_Contacts[]
Long		ll_RowCount
Long		ll_i

n_cst_dws	lnv_Dws

ll_RowCount = lnv_Dws.of_RowCount ( apo_Source ) 

FOR ll_i = 1 TO ll_rowCount
	IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonshipment" ) = 1 THEN
		lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" )
	END IF
NEXT


IF ab_CheckFilter THEN
	ll_RowCount = lnv_Dws.of_FilteredCount ( apo_Source ) 
	FOR ll_i = 1 TO ll_rowCount
		IF lnv_Dws.of_GetItemNumber (apo_Source , ll_i , "ct_notifyonshipment" , FILTER! , FALSE ) = 1 THEN
			lla_Contacts[ UpperBound ( lla_Contacts ) + 1 ] = lnv_Dws.of_GetItemNumber (apo_Source ,ll_i , "ct_id" , FILTER! , FALSE )
		END IF
	NEXT
END IF

ala_ContactIds[] = lla_Contacts

Return UpperBound ( ala_ContactIds[] )



end function

public function integer of_getallcontactsforcompany (n_cst_beo_company anv_company, ref long ala_ids[]);Long	ll_CoID
Long	ll_Count
Long	ll_i
Long	lla_Ids[]
Long	ll_Return = 1

DataStore	lds_Contacts
lds_Contacts = CREATE DataStore

lds_Contacts.DataObject = "d_contact_list"
lds_Contacts.SetTransObject ( SQLCA )

IF Not isValid ( anv_company ) THEN
	ll_Return = -1
END IF

IF ll_Return = 1 THEN
	ll_CoID = anv_Company.of_GetId ( )
	IF ll_CoID > 0 THEN
	ELSE
		ll_Return = -1
	END IF
END IF

IF ll_Return = 1 THEN
	ll_Count = lds_Contacts.Retrieve ( ll_CoID ) 
	FOR ll_i = 1 TO ll_Count
		lla_Ids[ ll_i ] = lds_Contacts.GetItemNumber ( ll_i , "ct_id" )		 
	NEXT
END IF

// Switching return to count here
IF ll_Return = 1 THEN
	ala_ids[] = lla_Ids[]
	ll_Return = ll_Count
END IF

DESTROY lds_Contacts

RETURN ll_Return
end function

public function integer of_getcontactidsfromaddresses (string asa_Addresses[], ref long ala_ContactIds[]);Long	ll_Count
Long	ll_i
Long	lla_Contacts[]
Long	ll_ID
Long	ll_Contacts
Long	ll_Return = 1
String	ls_Address
String	lsa_Result[]
String	ls_Fn

n_cst_String	lnv_String
n_cst_bso_notification_Manager	lnv_Note
lnv_Note = CREATE n_cst_bso_notification_Manager

ll_Count = UpperBound ( asa_Addresses )

FOR ll_i = 1 TO ll_Count
	ls_Address = asa_Addresses[ ll_i ]
	IF len ( ls_Address ) > 0 THEN
		
		lnv_String.of_ParseToArray ( ls_Address , "@" , lsa_Result )

		IF UpperBound ( lsa_Result ) > 1 THEN
			ls_fn = lsa_Result [ 1 ] 
			IF len ( ls_Fn ) > 15 THEN
				ls_Fn = Left ( ls_Fn , 15 ) 
			END IF
		ELSE
			ll_Return = -1
		END IF
	
		ll_ID = lnv_Note.of_GetIdFromEmailAddress ( ls_Address )
		IF ll_ID = 0 THEN			
			ll_ID = lnv_Note.of_NewContact ( ls_Fn , "" , "" , ls_Address , 0 )
		END IF
	END IF
	
	IF ll_ID > 0 THEN
		ll_Contacts ++ 
		lla_Contacts[ ll_Contacts ] = ll_ID
		ll_ID = 0
	END IF
	
NEXT

IF ll_Return = 1 THEN
	ala_ContactIds[] = lla_Contacts
	ll_Return = UpperBound ( ala_ContactIds[] )
END IF

DESTROY ( lnv_Note )

RETURN ll_Return



		
		
end function

public function long of_getcontactidforrecipient (mailrecipient anv_recipient);Long	ll_Count
Long	ll_i
Long	lla_Contacts[]
Long	ll_ID
Long	ll_Contacts
Long		ll_Return = 0
String	ls_Address
String	lsa_Result[]
String	ls_Fn

n_cst_String	lnv_String
n_cst_bso_notification_Manager	lnv_Note
lnv_Note = CREATE n_cst_bso_notification_Manager

IF isValid ( anv_Recipient  ) THEN

	ls_Address = anv_Recipient.Address
	
	lnv_String.of_ParseToArray ( ls_Address , ":" , lsa_Result )
	IF UpperBound ( lsa_Result ) > 1 THEN // if the recipient comes from the addressBook it
		ls_Address = lsa_Result [ 2 ]     //  lookes like   SMTP:rzacher@profittools.net
	END IF										//   this will strip out the SMTP:
	
	IF len ( ls_Address ) > 0 THEN
		
		lnv_String.of_ParseToArray ( ls_Address , "@" , lsa_Result )

		IF UpperBound ( lsa_Result ) > 1 THEN
			ls_fn = lsa_Result [ 1 ] 
			IF len ( ls_Fn ) > 15 THEN
				ls_Fn = Left ( ls_Fn , 15 ) 
			END IF
		ELSE
			ll_Return = -1
		END IF
	
		ll_ID = lnv_Note.of_GetIdFromEmailAddress ( ls_Address )
		IF ll_ID = 0 THEN			
			ll_ID = lnv_Note.of_NewContact ( ls_Fn , "" , "" , ls_Address , 0 )
		END IF
	END IF
	
	IF ll_ID > 0 THEN
		ll_Return = ll_ID
	END IF
	
END IF


DESTROY ( lnv_Note )

RETURN ll_Return



		
		
end function

public function boolean of_doesrolepermitnotification (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company);// this method will determine if the company should have contacts being notified given the role
// of the company in the provided shipment

String	ls_ActualRole
String	ls_NeededRole
String	lsa_Roles[]
Int		li_RoleCount
Int		li_i
Boolean	lb_Return

n_cst_String	lnv_String
n_cst_shipmentManager	lnv_ShipmentManager

ls_ActualRole = lnv_SHipmentManager.of_GetCompanyRoleInShipment ( anv_Shipment, anv_Company  )
ls_NeededRole = anv_Company.of_GetRequiredRequestrole ( )


CHOOSE CASE ls_NeededRole
		
	CASE n_cst_constants.cs_requestrole_any
		lb_Return = NOT  ls_ActualRole = n_cst_Companies.cs_CompanyRole_None
		
		
	CASE n_cst_constants.cs_requestrole_Billto
		
		lnv_String.of_ParseToArray ( ls_ActualRole , "," , lsa_Roles )
		li_RoleCount = UpperBound ( lsa_Roles )
		FOR li_i = 1 TO li_RoleCount 
			IF lsa_Roles[ li_i ] =  n_cst_Companies.cs_CompanyRole_BillTo THEN
				lb_Return = TRUE 
				EXIT 
			END IF
		NEXT
			
	CASE n_cst_constants.cs_requestrole_NONE
		lb_Return = FALSE
		
END CHOOSE 


RETURN lb_Return
end function

public function integer of_addcontactsifneeded (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company, string as_role);// RDT 6-11-03 Add AccAuth Contacts for BillTo Companies 

Int	li_Return = 1
Boolean	lb_Continue = TRUE
Long		lla_Contacts[]

n_cst_LicenseManager	lnv_Lic

IF lb_Continue THEN
	lb_Continue = lnv_Lic.of_hasnotificationlicense ( )
	li_Return = 0 
END IF

IF lb_Continue THEN
	lb_Continue = isValid ( anv_Shipment ) AND IsValid ( anv_Company )
END IF

// first, do we need to add all
IF lb_Continue THEN
	lb_Continue = THIS.of_DoesRolePermitNotification ( anv_Shipment , anv_Company ) 
END IF

IF lb_Continue THEN
	// Should there be contacts on the shipment already
	//	THIS.of_ShouldContactsExist ( anv_Shipment , anv_Company )
END IF





/*
I am removing the call to THIS.of_DoContactsExist ( ) because it was not taking into account where the contacts exist. 
Take for example when the same company is set as the bill to and the origin. If the Bill to is set before the event site then
when the site is set on the event the code thinks because the company already exists on the shipment ( as a billto ) all of the 
contacts already exist.

IF lb_Continue THEN
	lb_Continue = NOT  THIS.of_DoContactsExist ( anv_Shipment , anv_Company ) 
END IF


Addtionaly I will remove the conditional processing to set the acc auth contacts, since this will be 
done by of_AddAllContactsToShipement ( )
*/






IF lb_Continue THEN
	// ADD ALL THE CONTACTS TO THE SHIPMENT
	THIS.of_AddAllcontactsToShipment ( anv_Shipment , anv_Company ) 

//ELSE																						// RDT 6-11-03	
//	if anv_Shipment.of_GetBillTo() = anv_company.of_GetID() AND  & 
//		 anv_company.of_GetRequiredRequestRole ( ) <> n_cst_constants.cs_requestrole_NONE then // <<*>>
//		 
//		DataStore	lds_Source														// RDT 6-11-03			
//		lds_Source = CREATE DataStore												// RDT 6-11-03			
//		lds_Source.DataObject = "d_notificationRecipients"					// RDT 6-11-03			
//		lds_Source.SetTransObject ( SQLCA )										// RDT 6-11-03			
//		THIS.of_GetAllContactsForCompany ( anv_Company, lla_Contacts ) // RDT 6-11-03			
//		lds_Source.Retrieve ( lla_Contacts ) 									// RDT 6-11-03			
//		THIS.of_GetAccAuthContacts ( lds_Source, lla_Contacts )			// RDT 6-11-03			
//		anv_Shipment.of_AddAccAuthContacts ( lla_Contacts )				// RDT 6-11-03			
//		Destroy ( lds_Source )														// RDT 6-11-03	
//	end if																				// RDT 6-11-03	
	
END IF


RETURN li_Return
end function

public function integer of_addallcontactstoshipment (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company);// RDT 5-13-03 changed to add contacts to events
// RDT 6-11-03 Only add AccessAuth contacts for the shipment billto companies 

Long	lla_Contacts[], &
		ll_CompanyId
		
Int	li_Return = 1, &
		i
n_cst_beo_Shipment	lnv_Shipment

DataStore	lds_Source
lds_Source = CREATE DataStore

lds_Source.DataObject = "d_notificationRecipients"
lds_Source.SetTransObject ( SQLCA )

// RDT 5-13-03 - Start 
n_cst_beo_event 						lnva_Events[]
n_cst_bso_Notification_Manager  	lnv_Notification_Manager
lnv_Notification_Manager = Create n_cst_bso_Notification_Manager  
// RDT 5-13-03 - End

IF isValid  ( anv_Shipment ) AND IsValid ( anv_Company ) THEN
	
	THIS.of_GetAllContactsForCompany ( anv_Company, lla_Contacts ) 
	IF UpperBound (  lla_Contacts ) > 0 THEN
		lds_Source.Retrieve ( lla_Contacts ) 
		Commit;
	END IF
	
	lnv_Shipment = anv_Shipment
	
	THIS.of_GetAccNoteContacts ( lds_Source,  lla_Contacts  )
	lnv_Shipment.of_AddAccNoteContacts ( lla_Contacts )
	
	If anv_Shipment.of_GetBillTo() = anv_Company.of_GetID() Then 	// RDT 6-11-03	
		THIS.of_GetAccAuthContacts ( lds_Source,lla_Contacts )
		lnv_Shipment.of_AddAccAuthContacts ( lla_Contacts )
	End If 																			// RDT 6-11-03	
	
	THIS.of_GetEventContacts ( lds_Source, lla_Contacts )
	//	lnv_Shipment.of_AddEventContacts ( lla_Contacts ) // RDT 5-13-03 
	// RDT 5-13-03 -START
	// get all events 
	lnv_Shipment.of_GetEventList (lnva_events[] )	
	ll_CompanyId = anv_Company.of_getid ( )
	For i = 1 to UpperBound( lnva_events[] )
		lnv_Notification_Manager.of_eventcompanycontact ( ll_CompanyId , lnva_events[i], TRUE /*add*/ )
	Next
	// RDT 5-13-03 -END

	
	THIS.of_GetShipmentContacts ( lds_Source, lla_Contacts )
	lnv_Shipment.of_AddShipmentContacts ( lla_Contacts )
	
	THIS.of_GetLastFreeDateContacts ( lds_Source, lla_Contacts )
	lnv_Shipment.of_AddLastFreeDateContacts ( lla_Contacts )
	
ELSE 
	li_Return = -1
END IF


DESTROY ( lds_Source )
// RDT 5-13-03 - Start 
DESTROY ( lnv_Notification_Manager )

For i = 1 to UpperBound( lnva_events[] )
	If IsValid( lnva_events[i] ) Then
		Destroy ( lnva_events[i] ) 
	End If
Next
// RDT 5-13-03 - End

RETURN li_Return



end function

public function integer of_removecontactsifneeded (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company);// RDT 6-11-03 Remove Auth Contacts if company is not the Bill To on the shipment

Int	li_Return = 1
Boolean	lb_Continue = TRUE
Boolean	lb_RemoveContacts
String	ls_Role


n_cst_LicenseManager		lnv_Lic
n_cst_ShipmentManager	lnv_Manager

IF lb_Continue THEN
	lb_Continue = lnv_Lic.of_hasnotificationlicense ( )
	li_Return = 0 
END IF

IF lb_Continue THEN
	lb_Continue = isValid ( anv_Shipment ) AND IsValid ( anv_Company )
END IF

IF lb_Continue THEN
	
	ls_Role = lnv_Manager.of_GetCompanyRoleInShipment ( anv_Shipment, anv_Company ) 
	IF ls_Role = n_cst_companies.cs_companyrole_none THEN
		lb_RemoveContacts = TRUE
	ELSE
		IF NOT THIS.of_DoesRolePermitNotification ( anv_Shipment , anv_Company ) THEN
			lb_RemoveContacts = TRUE
		END IF
	END IF
END IF

IF lb_Continue THEN
	IF lb_RemoveContacts THEN
		THIS.of_RemoveAllContactsFromShipment ( anv_Shipment , anv_Company )
	ELSE
		// RDT 6-09-03 - Start 
		// if company is not the billto remove the authorization contacts 
		If anv_shipment.of_getbillto ( ) <> anv_company.of_getid ( ) Then 
			Long 	lla_Contacts[], lla_ShipmentContacts[]
			n_cst_anyarraysrv lnv_Array
			DataStore	lds_Source
			lds_Source = CREATE DataStore
			lds_Source.DataObject = "d_notificationRecipients"
			lds_Source.SetTransObject ( SQLCA )
			THIS.of_GetAccAuthContacts ( lds_Source, lla_Contacts )
			anv_Shipment.of_GetAccAuthContacts ( lla_ShipmentContacts )
			lnv_Array.of_removelong ( lla_ShipmentContacts, lla_Contacts, TRUE )
			anv_Shipment.of_SetAccAuthContacts ( lla_ShipmentContacts )
			Destroy ( lds_Source )
		End if
		// RDT 6-09-03 - End 	
	END IF

	
END IF

RETURN li_Return

end function

public function integer of_removeallcontactsfromshipment (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company);// RDT 5-13-03 remove contacts from event
Long	lla_Contacts[], &
		ll_CompanyID
		

Long	lla_ShipmentContacts[]

Int	li_Return = 1, &
		i

n_cst_beo_Shipment	lnv_Shipment
n_cst_anyarraysrv lnv_Array

DataStore	lds_Source
lds_Source = CREATE DataStore

lds_Source.DataObject = "d_notificationRecipients"
lds_Source.SetTransObject ( SQLCA )

// RDT 5-13-03 - Start 
n_cst_beo_event 						lnva_Events[]
n_cst_bso_Notification_Manager  	lnv_Notification_Manager
lnv_Notification_Manager = Create n_cst_bso_Notification_Manager  
// RDT 5-13-03 - End

IF isValid  ( anv_Shipment ) AND IsValid ( anv_Company ) THEN
		
	THIS.of_GetAllContactsForCompany ( anv_Company, lla_Contacts ) 
	IF UpperBound ( lla_Contacts ) > 0 THEN
		lds_Source.Retrieve ( lla_Contacts ) 
		Commit;
	END IF
	
	lnv_Shipment = anv_Shipment
	
	THIS.of_GetAccNoteContacts ( lds_Source,  lla_Contacts  )
	lnv_Shipment.of_GetAccNoteContacts ( lla_ShipmentContacts )
	lnv_Array.of_removelong ( lla_ShipmentContacts, lla_Contacts, TRUE )
	lnv_Shipment.of_SetAccNoteContacts ( lla_ShipmentContacts )
	
	THIS.of_GetAccAuthContacts ( lds_Source,lla_Contacts )
	lnv_Shipment.of_GetAccAuthContacts ( lla_ShipmentContacts )
	lnv_Array.of_removelong ( lla_ShipmentContacts, lla_Contacts, TRUE )
	lnv_Shipment.of_SetAccAuthContacts ( lla_ShipmentContacts )
	
	
	THIS.of_GetEventContacts ( lds_Source, lla_Contacts )
	// RDT 5-13-03 //	lnv_Shipment.of_GetEventContacts ( lla_ShipmentContacts )						
	// RDT 5-13-03 //	lnv_Array.of_removelong ( lla_ShipmentContacts, lla_Contacts, TRUE )
	// RDT 5-13-03 //	lnv_Shipment.of_SetEventContacts ( lla_ShipmentContacts )
	// RDT 5-13-03 -START
	lnv_Shipment.of_GetEventList (lnva_events[] )	
	ll_CompanyId = anv_Company.of_getid ( )
	For i = 1 to UpperBound( lnva_events[] )
		lnv_Notification_Manager.of_eventcompanycontact ( ll_CompanyId , lnva_events[i], FALSE /*remove*/ )
	Next
	// RDT 5-13-03 -END
	
	
	THIS.of_GetShipmentContacts ( lds_Source, lla_Contacts )
	lnv_Shipment.of_GetShipmentContacts ( lla_ShipmentContacts )
	lnv_Array.of_removelong ( lla_ShipmentContacts, lla_Contacts, TRUE )
	lnv_Shipment.of_SetShipmentContacts ( lla_ShipmentContacts )
	
	THIS.of_GetLastFreeDateContacts ( lds_Source, lla_Contacts )
	lnv_Shipment.of_GetLastFreeDateContacts ( lla_ShipmentContacts )
	lnv_Array.of_removelong ( lla_ShipmentContacts, lla_Contacts, TRUE )
	lnv_Shipment.of_SetLastFreeDateContacts ( lla_ShipmentContacts )
ELSE 
	li_Return = -1
END IF


DESTROY ( lds_Source )

// RDT 5-13-03 - Start 
DESTROY ( lnv_Notification_Manager )
For i = 1 to UpperBound( lnva_events[] )
	If IsValid( lnva_events[i] ) Then
		Destroy ( lnva_events[i] ) 
	End If
Next
// RDT 5-13-03 - End


RETURN li_Return



end function

private function integer of_shouldcontactsexist (n_cst_beo_Shipment anv_Shipment, n_cst_beo_Company anv_Company);RETURN 0
end function

private function boolean of_docontactsexist (n_cst_beo_shipment anv_shipment, n_cst_beo_company anv_company);// RDT 6-09-03 changed to get contacts from events, not shipment.
Long	lla_CompanyContacts[]
Long	lla_Contacts[]
Boolean	lb_Found
Boolean	lb_Continue 
Long		ll_Null
Int		li_FindRtn
Long		ll_Count
Long		i

n_cst_anyarraysrv	lnv_Array

SetNull	( ll_Null )
lb_Continue = IsValid( anv_Company )

IF lb_Continue THEN
	THIS.of_GetAllContactsForCompany ( anv_Company , lla_CompanyContacts )
	ll_count = UpperBound ( lla_CompanyContacts )
END IF

IF lb_Continue THEN
	lb_Continue = IsValid ( anv_shipment ) 
END IF

IF lb_Continue THEN
	IF NOT lb_Found THEN
		anv_shipment.of_GetAccNoteContacts ( lla_Contacts )
		FOR i = 1 TO ll_Count
			li_FindRtn = lnv_Array.of_findlong ( lla_Contacts , lla_CompanyContacts [ i ] ,ll_Null , ll_Null) 
			IF Not IsNull ( li_FindRtn ) THEN
				lb_Found = TRUE 
				EXIT
			END IF
		NEXT
	END IF
	
	IF NOT lb_Found THEN
		anv_shipment.of_GetAccAuthContacts ( lla_Contacts )
		FOR i = 1 TO ll_Count
			li_FindRtn = lnv_Array.of_findlong ( lla_Contacts , lla_CompanyContacts [ i ] ,ll_Null , ll_Null) 
			IF Not IsNull ( li_FindRtn ) THEN
				lb_Found = TRUE 
				EXIT
			END IF
		NEXT
	END IF
	
	IF NOT lb_Found THEN
		// RDT 6-09-03 anv_shipment.of_GetEventContacts ( lla_Contacts )
		// RDT 6-09-03 - start
		Long		ll_EventCount, ll_Upper
		Long		lla_EventContacts[]
		n_cst_beo_event lnva_Events[]
		
		anv_shipment.of_GetEventList ( lnva_Events[] )
		ll_upper = UpperBound( lnva_Events[] )
		
		IF ll_Upper > 0 Then 
			
			For ll_EventCount = 1 to ll_Upper
				lnva_Events[ ll_EventCount ].of_GetNotificationTargets ( lla_EventContacts )			
				lnv_Array.of_AppendLong ( lla_Contacts, lla_EventContacts )
				If IsValid( lnva_Events[ ll_EventCount ] ) Then Destroy ( lnva_Events[ ll_EventCount ] ) 
			Next
			
			lnv_Array.of_GetShrinked ( lla_Contacts, TRUE , TRUE )
			
		END IF 
		// RDT 6-09-03 - end
		
		FOR i = 1 TO ll_Count
			li_FindRtn = lnv_Array.of_findlong ( lla_Contacts , lla_CompanyContacts [ i ] ,ll_Null , ll_Null) 
			IF Not IsNull ( li_FindRtn ) THEN
				lb_Found = TRUE 
				EXIT
			END IF
		NEXT
	END IF

	IF NOT lb_Found THEN
		anv_shipment.of_GetShipmentContacts ( lla_Contacts )
		FOR i = 1 TO ll_Count
			li_FindRtn = lnv_Array.of_findlong ( lla_Contacts , lla_CompanyContacts [ i ] ,ll_Null , ll_Null) 
			IF Not IsNull ( li_FindRtn ) THEN
				lb_Found = TRUE 
				EXIT
			END IF
		NEXT
	END IF


	IF NOT lb_Found THEN
		anv_shipment.of_GetLastFreeDateContacts ( lla_Contacts )
		FOR i = 1 TO ll_Count
			li_FindRtn = lnv_Array.of_findlong ( lla_Contacts , lla_CompanyContacts [ i ] ,ll_Null , ll_Null) 
			IF Not IsNull ( li_FindRtn ) THEN
				lb_Found = TRUE 
				EXIT
			END IF
		NEXT
	END IF
	
END IF

RETURN lb_Found
end function

on n_cst_contactmanager.create
call super::create
end on

on n_cst_contactmanager.destroy
call super::destroy
end on

