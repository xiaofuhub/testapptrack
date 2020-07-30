$PBExportHeader$u_dw_companiesbycontacts.sru
forward
global type u_dw_companiesbycontacts from u_dw
end type
end forward

global type u_dw_companiesbycontacts from u_dw
integer width = 1733
integer height = 612
string dataobject = "d_companybycontacts"
event ue_addcompany ( string as_setcontactchecks )
event type n_cst_beo_shipment ue_getshipment ( )
event type integer ue_companyadded ( long al_id,  string as_setcontactchecks )
event ue_deletecompany ( )
event type integer ue_companydeleted ( n_cst_beo_company anv_company )
end type
global u_dw_companiesbycontacts u_dw_companiesbycontacts

forward prototypes
public function integer of_retrieve (n_cst_beo_shipment anv_shipment)
public function long of_getcompanyid (long al_row)
public function long of_getallcompanies (ref long ala_coids[])
private function string of_determinecompanyrole (long al_row)
public function n_cst_beo_company of_getcompanyfromrow (long al_row)
public subroutine of_setroles ()
public function integer of_deletecompany (n_cst_beo_company anv_company)
public function integer of_retrieve (readonly n_cst_beo_shipment anva_shipment[])
public function integer of_companyexists (readonly long al_companyid)
public function integer of_addcompany (n_cst_beo_company anv_company, string as_setcontactchecks)
public function integer of_retrieve (readonly long ala_contactid[])
end prototypes

event ue_addcompany;// RDT 3-12-03 Added parameter to set the checkboxes as "Checked", "Unchecked" or "Default"
Long						ll_CoCount
Long						i
S_Parm					lstr_Parm	
n_cst_msg				lnv_Msg	
n_cst_beo_SHipment	lnv_Shipment
n_cst_beo_Company		lnv_Company


//lnv_Shipment = THIS.Event ue_GetShipment ( )

//IF IsValid ( lnv_Shipment ) THEN
//	lstr_Parm.ia_Value = lnv_Shipment
//	lstr_PArm.is_Label = "SHIPMENT"
//	lnv_Msg.of_Add_Parm ( lstr_Parm )

//	OpenWithParm ( w_SelectContactCompany , lnv_Msg ) 
	 
//	IF isValid ( Message.PowerObjectParm )  THEN
//		lnv_Msg = Message.PowerObjectParm 
//	
//		IF lnv_Msg.of_Get_Parm ( "COMPANY" , lstr_Parm ) <> 0 THEN
//			lnva_CoList =  lstr_Parm.ia_Value
//			ll_CoCount = UpperBound ( lnva_CoList )
//			FOR i = 1 TO ll_CoCount

	lnv_Company = gnv_cst_Companies.OF_Select('')  // This opens the Select Company window
	If IsValid ( lnv_Company )  Then 
		//THIS.of_AddCompany ( lnv_Company) 								// RDT 3-12-03 
		THIS.of_AddCompany ( lnv_Company, as_SetContactChecks ) 		// RDT 3-12-03 
	End If
				
//			NEXT
//		END IF
//	END IF
	
//END IF
	
	
end event

event ue_deletecompany;THIS.of_DeleteCompany ( THIS.of_GetCompanyFromRow ( THIS.GetRow( )  ) )
end event

public function integer of_retrieve (n_cst_beo_shipment anv_shipment);Long	lla_Result[]
Long	lla_Temp[]
Int	li_Return = 1 

n_cst_AnyArraySrv	lnv_Array


IF li_return = 1 THEN
	IF NOT IsValid ( anv_Shipment ) THEN
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	
	anv_Shipment.of_GetEventContacts ( lla_Temp ) 
	lnv_Array.of_appendlong ( lla_Result , lla_Temp )
	
	anv_Shipment.of_GetShipmentContacts ( lla_Temp ) 
	lnv_Array.of_appendlong ( lla_Result , lla_Temp )
	
	anv_Shipment.of_GetLastfreeDateContacts ( lla_Temp ) 
	lnv_Array.of_appendlong ( lla_Result , lla_Temp )
	
	anv_Shipment.of_GetAccNoteContacts ( lla_Temp ) 
	lnv_Array.of_appendlong ( lla_Result , lla_Temp )
	
	anv_Shipment.of_GetAccAuthContacts ( lla_Temp ) 
	lnv_Array.of_appendlong ( lla_Result , lla_Temp )
	
	lnv_Array.of_GetShrinked ( lla_Result ,TRUE , TRUE ) 
	
	
END IF

IF li_Return = 1 THEN
	IF UpperBound ( lla_Result ) > 0 THEN
		li_Return = THIS.Retrieve( lla_Result )
	END IF
END IF

IF li_Return > 0 THEN
	THIS.of_SetRoles ( )
END IF


RETURN li_Return

		


end function

public function long of_getcompanyid (long al_row);Long	ll_Row
Long	ll_CoID = -1

ll_Row = al_Row

IF ll_Row > 0 AND ll_Row <= THIS.RowCount ( ) THEN
	ll_CoID = THIS.GetItemNumber ( ll_Row, "companies_co_id" )
END IF

RETURN ll_CoID
	
	
	
	
end function

public function long of_getallcompanies (ref long ala_coids[]);// Returns all company IDs in datawindow
Long	ll_RowCount
Long	lla_CoIDs[]
Long	ll_i

ll_RowCount = THIS.RowCount ( )

FOR ll_i = 1 TO ll_RowCount 
	lla_CoIDs[ ll_i ] = THIS.GetItemNumber ( ll_i, "companies_co_id" )
NEXT

ala_CoIds[] = lla_CoIDs

RETURN ll_i
	
	
	
	
end function

private function string of_determinecompanyrole (long al_row);
Int		li_Return = 1
String	ls_Role

n_cst_ShipmentManager lnv_ShipmentManager
n_cst_beo_Company	lnv_Company
n_cst_beo_Shipment	lnv_Shipment

lnv_Company = THIS.of_GetCompanyFromRow ( al_row )
lnv_Shipment = THIS.Event ue_GetShipment ( )

IF Not IsValid ( lnv_Shipment ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ls_Role = lnv_ShipmentManager.of_GetCompanyRoleInShipment ( lnv_Shipment, lnv_Company ) 
END IF

DESTROY ( lnv_Company )

RETURN ls_Role
end function

public function n_cst_beo_company of_getcompanyfromrow (long al_row);Long	ll_ID 
n_cst_beo_Company	lnv_Company
lnv_Company = CREATE n_cst_beo_Company

ll_ID = THIS.of_GetCompanyID ( al_Row ) 

IF ll_ID > 0 THEN
	gnv_cst_companies.of_Cache ( ll_ID , TRUE ) 
	lnv_Company.of_SetUseCache ( TRUE ) 
	lnv_Company.of_SetSourceID ( ll_ID )
END IF

IF NOT lnv_Company.of_HasSource ( ) THEN
	DESTROY ( lnv_Company ) 
END IF

RETURN lnv_Company 
end function

public subroutine of_setroles ();Long		ll_RowCount
String	ls_Role
Long		ll_i 
ll_RowCount = THIS.RowCount ( )


IF ll_RowCount > 0 THEN
	
	For ll_i = 1 TO ll_RowCount
		ls_Role = THIS.of_DetermineCompanyRole ( ll_i )	
		THIS.SetItem ( ll_i , "Role" , ls_Role)
	NEXt
	
END IF		

end subroutine

public function integer of_deletecompany (n_cst_beo_company anv_company);Long	ll_Row
Long	ll_CoID
Int	li_Return = 1

IF NOT isValid ( anv_Company ) THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	ll_CoID = anv_Company.of_GetID ( )
	IF NOT ll_CoID > 0 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	ll_Row = THIS.Find ( "companies_co_id = " + String ( ll_CoID ) , 1 , 9999 ) 
	IF ll_Row <= 0 THEN
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	IF THIS.RowsDiscard ( ll_Row , ll_Row , Primary!  ) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	THIS.Event ue_CompanyDeleted ( anv_Company )
END IF

RETURN li_Return
end function

public function integer of_retrieve (readonly n_cst_beo_shipment anva_shipment[]);// RDT 3-12-03 retrieve all Contacts the shipment and load them into an array
// RDT 6-09-03 changed to get event contacts from events

Long		lla_Result[]
Long		lla_Temp[]

// RDT 6-09-03 -New- start
Long		ll_Count, ll_Upper, lla_Contacts[]

n_cst_beo_event lnva_Events[]
// RDT 6-09-03 -new- end

Integer	li_Count, &
			li_Upper

Int		li_Return = 1 

n_cst_AnyArraySrv	lnv_Array

li_Upper = UpperBound( anva_Shipment[] )
If li_Upper < 1  then 
	li_Return = -1
End If

IF li_Return = 1 THEN
	For li_Count = 1 to li_Upper 
	
		// RDT 6-09-03//		anva_Shipment[ li_Count ].of_GetEventContacts ( lla_Temp ) 
		// RDT 6-09-03 - start
		anva_Shipment[ li_Count ].of_GetEventList ( lnva_Events[] )
		ll_upper = UpperBound( lnva_Events[] )
		
		IF ll_Upper > 0 Then 
			
			For ll_Count = 1 to ll_Upper
				lnva_Events[ ll_Count ].of_GetNotificationTargets ( lla_Contacts )			
				lnv_Array.of_AppendLong ( lla_Temp,  lla_Contacts )
				If IsValid( lnva_Events[ ll_Count ] ) Then Destroy ( lnva_Events[ ll_Count ] ) 
			Next
			
			lnv_Array.of_GetShrinked ( lla_Temp, TRUE , TRUE )
			
		END IF 
		// RDT 6-09-03 - End 

		lnv_Array.of_appendlong ( lla_Result , lla_Temp )		
		
		anva_Shipment[ li_Count ].of_GetShipmentContacts ( lla_Temp ) 
		lnv_Array.of_appendlong ( lla_Result , lla_Temp )
		
		anva_Shipment[ li_Count ].of_GetLastfreeDateContacts ( lla_Temp ) 
		lnv_Array.of_appendlong ( lla_Result , lla_Temp )
		
		anva_Shipment[ li_Count ].of_GetAccNoteContacts ( lla_Temp ) 
		lnv_Array.of_appendlong ( lla_Result , lla_Temp )
		
		anva_Shipment[ li_Count ].of_GetAccAuthContacts ( lla_Temp ) 
		lnv_Array.of_appendlong ( lla_Result , lla_Temp )
			
	Next	
	lnv_Array.of_GetShrinked ( lla_Result ,TRUE , TRUE ) 
END IF
//MessageBox("RICH u_dw_companies.of_Retrieve" , "# of contacts"+String(upperbound(lla_Result) ) )
IF li_Return = 1 THEN
	IF UpperBound ( lla_Result ) > 0 THEN
		li_Return = THIS.Retrieve( lla_Result )
	END IF
END IF

IF li_Return > 0 THEN
	THIS.of_SetRoles ( )
END IF


RETURN li_Return

		


end function

public function integer of_companyexists (readonly long al_companyid);// RDT 3-12-03 Looks for company id in rows.
Integer	li_Return 
String 	ls_Find
ls_Find = "companies_co_id = "+String( al_CompanyID ) 

li_Return = This.Find(ls_find, 0, this.RowCount() )

Return li_Return 
	
end function

public function integer of_addcompany (n_cst_beo_company anv_company, string as_setcontactchecks);//  RDT 3-12-03 Added as_SetContactChecks argument
//  RDT 3-12-03 changed to public

Long		ll_Row
Long		lla_ExistingCos[]
Boolean	lb_Exists
Int		li_MsgRtn
Int		li_Return = 1

n_cst_anyarraysrv lnv_Array

IF li_Return = 1 THEN
	IF Not isValid ( anv_Company ) THEN
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	THIS.of_GetAllCompanies ( lla_ExistingCos )
	lb_Exists =  lnv_Array.of_findlong ( lla_ExistingCos , anv_company.of_GetID ( ), 1, 9999 ) > 0 
END IF

IF lb_Exists AND li_Return = 1 THEN
	li_MsgRtn = MessageBox ( "Add Company" , anv_Company.of_GetName ( ) + &
	" already exists in the Notification List. ~r~nReassigning it will reset any changes made to the contacts associated with this company.~r~n" + &
	"Do you want to reassign it?" , QUESTION! , YESNO! , 2 )   
	CHOOSE CASE li_MsgRtn
		CASE 1 // reload			
			IF THIS.of_DeleteCompany ( anv_Company ) <> 1 THEN
				li_Return = -1
			END IF
		CASE 2 // Bail
			li_Return = 0 
	END CHOOSE 
END IF

IF li_Return = 1 THEN
	ll_Row = THIS.InsertRow ( 0 ) 
	IF ll_Row <= 0 THEN
		li_Return = -1
	END IF	
END IF

IF li_Return = 1 THEN
	This.SetRow( ll_Row ) // RDT 6-09-03
	THIS.SetItem ( ll_Row , "companies_co_name" , anv_Company.of_GetName ( ) )
	THIS.SetItem ( ll_Row , "companies_co_id" , anv_Company.of_GetID ( ) )
	THIS.SetItem ( ll_Row , "role" , THIS.of_DetermineCompanyRole ( ll_Row )  )
	THIS.ScrollToRow ( ll_Row )
//	THIS.Event ue_CompanyAdded ( anv_Company.of_GetID ( ) )								// RDT 3-12-03
	THIS.Event ue_CompanyAdded ( anv_Company.of_GetID ( ), as_SetContactChecks ) // RDT 3-12-03
END IF

DESTROY ( anv_company )

RETURN li_Return 
end function

public function integer of_retrieve (readonly long ala_contactid[]);// RDT 5-13-03 retrieve Companies by contact id

Int		li_Return = 1 

IF UpperBound ( ala_contactid[]) > 0 THEN
	li_Return = THIS.Retrieve( ala_contactid[] )
END IF

IF li_Return > 0 THEN
	THIS.of_SetRoles ( )
END IF

RETURN li_Return
end function

event constructor;THIS.SetTransObject( sqlca )


end event

on u_dw_companiesbycontacts.create
end on

on u_dw_companiesbycontacts.destroy
end on

