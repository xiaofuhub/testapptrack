$PBExportHeader$u_dw_notificationrecipients.sru
forward
global type u_dw_notificationrecipients from u_dw_companycontacts_list
end type
end forward

global type u_dw_notificationrecipients from u_dw_companycontacts_list
int Width=1765
int Height=848
string DataObject="d_notificationrecipients"
end type
global u_dw_notificationrecipients u_dw_notificationrecipients

type variables
Long	ila_Ids[]
Boolean   ib_EmailBoxVisible = FALSE
Boolean   ib_EventBoxVisible = FALSE
end variables

forward prototypes
public function integer of_addcontact (long al_contactid)
public function integer of_removecontact (long al_RowNumber)
public function integer of_removeall ()
public function integer of_refresh (long ala_ids[])
public function integer of_geteventcontacts (ref long ala_contacts[])
public function integer of_getaccauthcontacts (ref long ala_contacts[])
public function integer of_getlastfreedatecontacts (ref long ala_contacts[])
public function integer of_getshipmentcontacts (ref long ala_contacts[])
public function integer of_addcontacts (long ala_ids[])
public function integer of_getaccnotecontacts (ref long ala_contacts[])
public function integer of_removecontacts (long ala_contacts[])
public function integer of_getallcontactsforshipment (readonly long al_id, ref long ala_contacts[])
public function integer of_showemailcheckbox (readonly boolean ab_show)
public subroutine of_showeventcheckbox (boolean ab_show)
end prototypes

public function integer of_addcontact (long al_contactid);Long	lla_Ids[]
Long	ll_Index

ll_Index = THIS.of_GetIds ( lla_Ids ) + 1
lla_Ids[ ll_Index ] = al_contactid

THIS.of_Refresh ( lla_IDs )

RETURN ll_Index
end function

public function integer of_removecontact (long al_RowNumber);Long	ll_RowNumber
Long	ll_RowCount
Int	li_Return = -1

ll_RowNumber = al_RowNumber
ll_RowCount = THIS.RowCount ( )

IF ll_RowNumber <= ll_RowCount AND NOT IsNull ( ll_RowNumber ) THEN
	IF DeleteRow ( ll_RowNumber ) = 1 THEN
		li_Return = 1
	END IF
END IF

RETURN li_Return
end function

public function integer of_removeall ();THIS.Reset ( )
RETURN 1
end function

public function integer of_refresh (long ala_ids[]);Int	li_Return

IF UpperBound ( ala_ids ) > 0 THEN
	li_Return =  THIS.Retrieve ( ala_Ids[ ] )
END IF

RETURN li_Return
end function

public function integer of_geteventcontacts (ref long ala_contacts[]);
n_cst_ContactManager	lnv_ContactManager
lnv_ContactManager = Create n_cst_ContactManager	

lnv_ContactManager.of_GetEventContacts ( THIS , ala_contacts[] , TRUE )

If Isvalid(lnv_ContactManager ) Then 
	Destroy( lnv_ContactManager )
END IF


Return UpperBound ( ala_Contacts )

end function

public function integer of_getaccauthcontacts (ref long ala_contacts[]);n_cst_ContactManager	lnv_ContactManager
lnv_ContactManager = create n_cst_ContactManager	

lnv_ContactManager.of_GetAccAuthContacts ( THIS , ala_contacts[] , TRUE )

If Isvalid(lnv_ContactManager ) Then 
	Destroy( lnv_ContactManager )
END IF

Return UpperBound ( ala_Contacts )



end function

public function integer of_getlastfreedatecontacts (ref long ala_contacts[]);n_cst_ContactManager	lnv_ContactManager
lnv_ContactManager = Create n_cst_ContactManager	

lnv_ContactManager.of_GetLastFreeDateContacts ( THIS , ala_contacts[] , TRUE )

If Isvalid(lnv_ContactManager ) Then 
	Destroy( lnv_ContactManager )
END IF


Return UpperBound ( ala_Contacts )

end function

public function integer of_getshipmentcontacts (ref long ala_contacts[]);n_cst_ContactManager	lnv_ContactManager
lnv_ContactManager = Create n_cst_ContactManager	

lnv_ContactManager.of_GetShipmentContacts ( THIS , ala_contacts[] , TRUE )

If Isvalid(lnv_ContactManager ) Then 
	Destroy( lnv_ContactManager )
END IF

Return UpperBound ( ala_Contacts )


end function

public function integer of_addcontacts (long ala_ids[]);String	ls_InList
Int		li_Return = 1
Long		ll_Count
n_cst_String	lnv_String

DataStore	lds_NewContacts

lds_NewContacts = CREATE DataStore
lds_NewContacts.DataObject = "d_notificationRecipients"
lds_NewContacts.SetTransObject ( SQLCA )

IF li_Return = 1 THEN
	IF UpperBound ( ala_ids ) = 0 THEN
		li_Return = 0
	END IF
END IF

IF li_Return = 1 THEN
	// Retrieve the new contacts to be added
	ll_Count = lds_NewContacts.Retrieve ( ala_ids[] )
	IF ll_Count <= 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	// turn off the redraw of this
	THIS.SetRedraw ( FALSE ) 
	
	// filter this to the new contacts so we can remove any that are dups
	lnv_String.of_ArrayToString ( ala_ids , "," , ls_InList )
	THIS.SetFilter( "ct_id in (" + ls_InList + ")" )
	THIS.Filter ( ) 
	THIS.RowsDiscard ( 1 , THIS.RowCount ( ) , PRIMARY! ) 
	
	// now set the filter back
	THIS.of_FIlterList ( )
	
	// and copy the new rows into this
	lds_NewContacts.RowsCopy ( 1, lds_NewContacts.RowCount ( ) , PRIMARY! , THIS , 999 ,Primary! )
	
	// Turn the redraw back on
	THIS.SetRedraw ( TRUE )
END IF

DESTROY ( lds_NewContacts ) 

RETURN li_Return
end function

public function integer of_getaccnotecontacts (ref long ala_contacts[]);n_cst_ContactManager	lnv_ContactManager
lnv_ContactManager = create n_cst_ContactManager	

lnv_ContactManager.of_GetAccNoteContacts ( THIS , ala_contacts[] , TRUE )

If Isvalid(lnv_ContactManager ) Then 
	Destroy( lnv_ContactManager )
END IF

Return UpperBound ( ala_Contacts )


end function

public function integer of_removecontacts (long ala_contacts[]);String			ls_InList
n_cst_string	lnv_String

THIS.SetRedraw ( TRUE ) 

// filter this to the new contacts so we can remove any that are dups
lnv_String.of_ArrayToString ( ala_contacts[] , "," , ls_InList )
THIS.SetFilter( "ct_id in (" + ls_InList + ")" )
THIS.Filter ( ) 
THIS.RowsDiscard ( 1 , THIS.RowCount ( ) , PRIMARY! ) 

// now set the filter back
//THIS.of_FIlterList ( )

THIS.SetRedraw ( TRUE ) 

RETURN 1
end function

public function integer of_getallcontactsforshipment (readonly long al_id, ref long ala_contacts[]);
Integer li_Return 


n_cst_ContactManager	lnv_CtManager
lnv_CtManager = CREATE n_cst_ContactManager

n_cst_beo_Company	lnv_Co
lnv_Co = CREATE n_cst_beo_Company

lnv_Co.of_SetUseCache ( TRUE ) 
lnv_Co.of_SetSourceID ( al_ID ) 

IF lnv_Co.of_HasSource( ) THEN
	lnv_CtManager.of_GetAllContactsForCompany ( lnv_Co , ala_Contacts[] )
	li_Return = UpperBound ( ala_Contacts[] )
ELSE
	 li_Return = -1
END IF



If Isvalid(lnv_CtManager ) Then 
	Destroy( lnv_CtManager )
END IF

Return li_Return




end function

public function integer of_showemailcheckbox (readonly boolean ab_show);// shows email check box and hides the others.

ib_EmailBoxVisible = ab_show

If ab_show Then 

	this.Object.rowchecked.Visible = 1
//	this.Object.ct_emailaddress.Width =  1
	this.Object.ct_emailaddress.Visible = 1
	this.Object.ct_notifyonevent.Visible = 0
	this.Object.ct_notifyonshipment.Visible = 0
	this.Object.ct_notifyonlfd.Visible = 0
	this.Object.ct_notifyonaccnote.Visible = 0
	this.Object.ct_notifyonaccauth.Visible = 0
Else

	this.Object.rowchecked.Visible = 0
//	this.Object.ct_emailaddress.Width = 0
	this.Object.ct_emailaddress.Visible = 0
	this.Object.ct_notifyonevent.Visible = 1
	this.Object.ct_notifyonshipment.Visible = 1
	this.Object.ct_notifyonlfd.Visible = 1
	this.Object.ct_notifyonaccnote.Visible = 1
	this.Object.ct_notifyonaccauth.Visible = 1
	
End If

Return 1

end function

public subroutine of_showeventcheckbox (boolean ab_show);// If ab_Show = TRUE 	Shows the Event check box and hides the others 
// If ab_Show = FALSE 	Hides the Event check box and shows all the others.

ib_EventBoxVisible  = ab_show

If ab_show Then 
	this.Object.ct_notifyonevent.Visible = 1
	this.Object.ct_notifyonshipment.Visible = 0
	this.Object.ct_notifyonlfd.Visible = 0
	this.Object.ct_notifyonaccnote.Visible = 0
	this.Object.ct_notifyonaccauth.Visible = 0
Else
	this.Object.ct_notifyonevent.Visible = 0
	this.Object.ct_notifyonshipment.Visible = 1
	this.Object.ct_notifyonlfd.Visible = 1
	this.Object.ct_notifyonaccnote.Visible = 1
	this.Object.ct_notifyonaccauth.Visible = 1
	
End If

end subroutine

event constructor;call super::constructor;THIS.SetTransObject ( SQLCA )
end event

event ue_refresh;long	lla_Ids[]

IF THIS.of_GetIds (  lla_Ids  ) > 0 THEN
	THIS.of_Refresh ( lla_Ids )
END IF
end event

