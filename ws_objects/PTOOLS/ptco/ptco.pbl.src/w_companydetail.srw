$PBExportHeader$w_companydetail.srw
$PBExportComments$This need to go in next chance.
forward
global type w_companydetail from w_response
end type
type tab_data from u_tab_companydetail within w_companydetail
end type
type tab_data from u_tab_companydetail within w_companydetail
end type
end forward

global type w_companydetail from w_response
integer x = 379
integer y = 400
integer width = 2953
integer height = 1644
long backcolor = 12632256
event ue_updateentity ( )
tab_data tab_data
end type
global w_companydetail w_companydetail

type variables
n_cst_beo_Company	inv_Company


//This is only used if an outside source is not provided.
DataStore	ids_Data
long		il_entityid, &
		il_companyid
boolean		ib_entityexists
string		is_origpayablesid

dataStore	ids_Contacts
Boolean	ib_DestroyContacts

end variables

forward prototypes
private function long wf_displayfromid (n_cst_msg anv_msg)
private function long wf_displayfromsource (n_cst_msg anv_msg)
private subroutine wf_initializeentityinfo ()
private subroutine wf_initializeimaging ()
private subroutine wf_initializecontacts (n_cst_msg anv_msg)
end prototypes

event ue_updateentity;long	ll_return
		
string	ls_payablesid

ls_payablesid = tab_Data.of_GetPayablesId ()
	
if ib_entityexists then
	
else
	if len(trim(ls_payablesid)) > 0 then
		//id entered,  setup new entity
		gnv_cst_Companies.of_MakeEntity ( il_companyid, il_entityid )	
//		gnv_cst_Companies.of_GetEntity (il_companyid, ll_EntityId, &
//		TRUE /*AllowCreate*/, false /*AskToCreate*/ , FALSE /*OpenSetup*/ )
	end if
end if

//update column
UPDATE "entity"  
SET "payablesid" = :ls_payablesid  
WHERE "entity"."id" = :il_entityid   ;

if sqlca.sqlcode = 0 then
	commit;
else
	rollback;
end if


end event

private function long wf_displayfromid (n_cst_msg anv_msg);Long			ll_Id
Long			ll_Return = -1

n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

lnv_Msg = anv_msg

IF lnv_Msg.of_Get_Parm ( "Id", lstr_Parm ) > 0 THEN

	ll_Id = lstr_Parm.ia_Value
	
	ids_Data = CREATE DataStore
	ids_Data.DataObject = "d_company_info"
	ids_Data.SetTransObject ( SQLCA )
	IF ids_Data.Retrieve ( ll_Id ) = 1 THEN
		tab_Data.of_SetSource ( ids_Data )
		tab_Data.Post of_SetCurrentRow ( 1 )
	END IF

	inv_Company = CREATE n_cst_beo_Company	
	inv_Company.of_SetSource ( ids_Data )
	inv_Company.of_SetSourceID ( ll_ID )		
	
	THIS.of_SetUpdateObjects ({ids_Data})

	ll_Return = ll_ID
	
END IF

RETURN ll_Return

end function

private function long wf_displayfromsource (n_cst_msg anv_msg);// Returns 	-1 Error
//				>0 Company ID

Long			ll_Return = -1
Long			ll_Id
Long			ll_Row
any			la_Value				

n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm
n_cst_dws	lnv_Dws
DataWindow	ldw_Source
DataStore	lds_Source


lnv_Msg = anv_msg

IF lnv_Msg.of_Get_Parm ( "Source", lstr_Parm ) > 0 THEN
	
	la_Value = lstr_Parm.ia_Value
	tab_Data.of_SetSource ( lstr_Parm.ia_Value )
	
	//This makes it so the window wont try an actual update.  
	//It does validate the dw's before closing, though.
	This.of_SetUpdateable ( FALSE )
	
	IF lnv_Msg.of_Get_Parm ( "Row", lstr_Parm ) > 0 THEN
		ll_Row = lstr_Parm.ia_Value
		tab_Data.Post of_SetCurrentRow ( ll_Row  )
	END IF
	
	CHOOSE CASE lnv_Dws.of_ResolvePowerObject ( la_Value, ldw_Source, lds_Source )
			
		CASE DataWindow!
			
			if ll_row > 0 then
				ll_Id = ldw_source.object.co_id[ll_row]
			else
				if ldw_source.rowcount() = 1 then
					ll_id = ldw_source.object.co_id[1]
				end if
			end if
			
						
		CASE DataStore!
			
			if ll_row > 0 then
				ll_Id = lds_source.object.co_id[ll_row]
			else
				if lds_source.rowcount() = 1 then
					ll_id = lds_source.object.co_id[1]
				end if
			end if
	END CHOOSE
	
ELSE
	ll_Return = -1
END IF
	
IF ll_ID > 0 THEN

	IF isValid ( tab_Data.of_GetSource ( ) ) THEN
		inv_Company = CREATE n_cst_beo_Company	
		inv_Company.of_SetSource ( tab_Data.of_GetSource ( ) )
		inv_Company.of_SetSourceID ( ll_ID )
	END IF	
	
	ll_Return = ll_ID
	
END IF
	
RETURN ll_Return
end function

private subroutine wf_initializeentityinfo ();if il_companyid > 0 then
	SELECT "entity"."id", "entity"."payablesid"  
	 INTO :il_entityid, :is_origpayablesid  
	 FROM "entity"  
	WHERE "entity"."fkcompany" = :il_companyid   ;

	commit;
		
	choose case sqlca.sqlcode
		case 0
			if il_entityid > 0 then
				ib_entityexists=true
			else
				ib_entityexists=false
			end if
		case else
			ib_entityexists=false
	end choose
	
	if len(trim(is_origpayablesid)) > 0 then
		tab_Data.of_SetPayablesId ( is_origpayablesid )
	end if
end if


	
end subroutine

private subroutine wf_initializeimaging ();n_cst_LicenseManager	lnv_LicenseManager
Boolean lb_ShowImaging = TRUE

IF NOT lnv_LicenseManager.of_GetLicensed ( n_cst_constants.cs_module_imaging ) THEN
	lb_ShowImaging = FALSE
END IF

IF isValid ( inv_Company ) THEN
	IF inv_Company.of_GetFacilityOf ( ) > 0 THEN
		lb_ShowImaging = FALSE
	END IF
END IF

tab_data.tabpage_imaging.Visible = lb_ShowImaging

end subroutine

private subroutine wf_initializecontacts (n_cst_msg anv_msg);//Boolean	lb_ShowNotification
s_Parm	lstr_Parm
PowerObject	apoa_UpdateObjects[]

//n_cst_LicenseManager lnv_LicenseManager


/*MFS 5/9/07 - Enable contacts tab for image email purposes
lb_ShowNotification = lnv_LicenseManager.of_HasNotificationLicense ( ) OR &
							 lnv_LicenseManager.of_HasEDI214License ( )
							
tab_data.tabpage_contacts.Visible = lb_ShowNotification

IF lb_ShowNotification THEN
*/
	If anv_msg.of_Get_Parm ( "COMPANYID" , lstr_Parm ) <> 0 THEN
		tab_Data.tabpage_contacts.of_SetCompanyID ( lstr_Parm.ia_Value ) 
	ELSEIF anv_msg.of_Get_Parm ( "Id" , lstr_Parm ) <> 0 THEN
		tab_Data.tabpage_contacts.of_SetCompanyID ( lstr_Parm.ia_Value ) 		
	END IF

	If anv_msg.of_Get_Parm ( "CONTACTS" , lstr_Parm ) <> 0 THEN
		ids_Contacts = lstr_Parm.ia_Value 
	ELSE
		ids_Contacts = CREATE dataStore
		ids_Contacts.DataObject = "d_companyContacts_list"
		ids_Contacts.SetTransObject ( sqlca )
		
		ib_DestroyContacts = TRUE
		ids_Contacts.Retrieve ( {il_companyid} )
		ids_Contacts.SetFilter ( "ct_co = " + String ( il_companyid ) ) 
		ids_Contacts.Filter ( )
		
		THIS.of_GetUpdateObjects( apoa_UpdateObjects[] )
		apoa_UpdateObjects[ UpperBound ( apoa_UpdateObjects[] ) + 1 ] = ids_Contacts
		THIS.of_SetUpdateObjects ( apoa_UpdateObjects )
		
	END IF
	tab_Data.tabpage_contacts.of_SetContactSource ( ids_Contacts ) 

	IF isValid ( inv_Company ) THEN
		tab_Data.tabpage_contacts.of_SetCompany ( inv_Company )
	END IF

/*END IF*/
end subroutine

on w_companydetail.create
int iCurrent
call super::create
this.tab_data=create tab_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_data
end on

on w_companydetail.destroy
call super::destroy
destroy(this.tab_data)
end on

event open;call super::open;//Either send source (optionally with row), or send ID

n_cst_Msg	lnv_Msg
s_Parm		lstr_Parm

Integer		li_TabIndex
Long			ll_DisplayRtn
any			la_Value				
Int			li_Return = 1

n_cst_Licensemanager	lnv_LicenseManager

IF li_Return = 1 THEN
	IF NOT IsValid ( Message.PowerObjectParm ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	
	lnv_Msg = Message.PowerObjectParm

	IF lnv_Msg.of_Get_Parm ( "Source", lstr_Parm ) > 0 THEN
		
		ll_DisplayRtn = THIS.wf_DisplayFromSource ( lnv_Msg ) 
		
	ELSEIF lnv_Msg.of_Get_Parm ( "Id", lstr_Parm ) > 0 THEN

		ll_DisplayRtn = THIS.wf_DisplayFromID ( lnv_Msg ) 

	END IF
	
ELSE
	
	li_Return = -1
	
END IF

IF li_Return = 1 THEN
	
	IF isValid ( inv_company ) THEN
		IF inv_company.of_GetStatus( ) = 'D' THEN
			li_Return = -1     ///// changing to error

			messagebox("Company Information", "Could not retrieve requested information.~n~nCompany "+&
				"has been deleted.", exclamation!)
	
		END IF
		
	END IF		
END IF

IF li_Return = 1 THEN

	IF ll_DisplayRtn > 0 THEN
		il_companyid = ll_DisplayRtn
	END IF

	IF lnv_Msg.of_Get_Parm ( "Tab", lstr_Parm ) > 0 THEN
		li_TabIndex = lstr_Parm.ia_Value
		tab_Data.Post SelectTab ( li_TabIndex )  
	END IF

	THIS.wf_InitializeEntityInfo ( )
	
END IF

IF li_Return = 1 THEN
	THIS.wf_initializeContacts ( lnv_Msg )
END IF


IF li_Return <> 1 THEN
	CLOSE ( THIS ) 
END IF


end event

event close;call super::close;DESTROY ids_Data
Destroy ( inv_Company )

IF ib_DestroyContacts THEN
	DESTROY ids_Contacts 
END IF
end event

event closequery;long		ll_return
integer	li_rc
string	ls_payablesid

Powerobject lpo_updatearray[]

If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

li_rc = of_UpdateChecks(lpo_updatearray)

ll_return = super::event closequery( )

if ll_return = 0 then
	if This.of_isUpdateable() = false then
		ls_payablesid = tab_Data.of_GetPayablesId ()
		
		if is_origpayablesid = ls_payablesid then
			//no update neede
		else
			choose case messagebox("Company Information", "The Payables ID has been changed. Save before closing?", &
				question!, yesnocancel!, 1)
					case 1
						this.trigger event ue_updateentity()
						return 0
					case 3
						return 1
			end choose
		end if
		
	else
		
		ls_payablesid = tab_Data.of_GetPayablesId ()
		
		if is_origpayablesid = ls_payablesid then
			//no update needed
		else
			If UpperBound(ipo_updateobjects) > 0 Then
				lpo_updatearray = ipo_updateobjects
			Else
				lpo_updatearray = This.Control		
			End If
			
			if li_rc > 0 then
				//already asked
				this.trigger event ue_updateentity()
				return 0
			else
				choose case messagebox("Company Information", "The Payables ID has been changed. Save before closing?", &
					question!, yesnocancel!, 1)
						case 1
							this.trigger event ue_updateentity()
							return 0
						case 3
							return 1
				end choose
			end if
		end if
		
	end if
end if

RETURN ll_Return



end event

event pfc_preupdate;call super::pfc_preupdate;Long	ll_NewID
Long	ll_RowCount 
Long	i

n_Cst_bso_Notification_manager	lnv_Manager
lnv_Manager = Create n_Cst_bso_Notification_manager

IF isValid ( ids_Contacts ) THEN
	
	ll_RowCount = ids_Contacts.RowCount ( )
	
	ll_NewId = lnv_Manager.of_GetNewContactID( )

	FOR i = 1 TO ll_RowCount 
		IF IsNull ( ids_Contacts.GetItemNumber ( i , "ct_id" ) ) THEN			
			ids_Contacts.SetItem ( i , "ct_id" , ll_NewID) 
			ll_NewID ++
		END IF
		
	NEXT
	
END IF

DESTROY ( lnv_Manager )

RETURN AncestorReturnValue
end event

event pfc_postopen;call super::pfc_postopen;
n_Cst_beo_Company	lnv_Co
lnv_Co = CREATE n_cst_beo_Company
lnv_co.of_SetSourceID ( il_companyid )

n_cst_AlertManager	lnv_AlertManager
lnv_AlertManager = CREATE n_cst_AlertManager
lnv_AlertManager.of_showalerts( {lnv_Co})
Destroy ( lnv_AlertManager )
DESTROY ( lnv_Co )
end event

type cb_help from w_response`cb_help within w_companydetail
end type

type tab_data from u_tab_companydetail within w_companydetail
integer x = 87
integer y = 44
integer taborder = 10
boolean bringtotop = true
end type

event ue_selectionchanged;PowerObject	lpo_Source
Long			ll_CurrentRow
n_cst_dws	lnv_Dws

lpo_Source = This.of_GetSource ( )
ll_CurrentRow = This.of_GetCurrentRow ( )

Parent.Title = "Company/Facility Details"

IF ll_CurrentRow > 0 THEN
	//Parent.Title += " : " + lnv_Dws.of_GetItemString ( lpo_Source, ll_CurrentRow, "co_name" )
	IF IsValid ( This.tabpage_PhysicalAddress ) THEN
		IF IsValid ( This.tabpage_PhysicalAddress.dw_PhysicalAddress ) THEN
			Parent.Title += " : " + This.tabpage_PhysicalAddress.dw_PhysicalAddress.GetItemString ( ll_CurrentRow, "co_name" )
		END IF
	END IF
END IF


end event

event pfc_update;call super::pfc_update;long	ll_return
string	ls_payablesid

ll_return = ancestorReturnValue

if ll_return = 1 then
	ls_payablesid = tab_Data.of_GetPayablesId ()
	
	if is_origpayablesid = ls_payablesid then
		//nothing changed no update
	else
		parent.trigger event ue_updateentity()
	end if
	
end if

return ll_return 

end event

event pfc_updatespending;call super::pfc_updatespending;long	ll_return
string	ls_payablesid

ll_return = ancestorReturnValue

if ll_return = 0 then
	ls_payablesid = this.of_GetPayablesId ()
	if is_origpayablesid = ls_payablesid then
		//nothing changed no update
	else
		ll_return = 1
	end if

end if

return ll_return 

end event

event ue_getcompany;RETURN inv_Company
end event

