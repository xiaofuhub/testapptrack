$PBExportHeader$w_tv_amounttemplates.srw
$PBExportComments$[w_sheet] TreeView for Amount Template Maintenance
forward
global type w_tv_amounttemplates from w_sheet
end type
type dw_1 from u_dw within w_tv_amounttemplates
end type
type tv_1 from u_tvs within w_tv_amounttemplates
end type
type dw_3 from u_dw within w_tv_amounttemplates
end type
type dw_4 from u_dw within w_tv_amounttemplates
end type
type mle_datalist from u_mle within w_tv_amounttemplates
end type
type st_2 from u_st_label within w_tv_amounttemplates
end type
type st_1 from statictext within w_tv_amounttemplates
end type
type mle_filterlist from multilineedit within w_tv_amounttemplates
end type
type st_linked from statictext within w_tv_amounttemplates
end type
type st_unlinked from statictext within w_tv_amounttemplates
end type
type st_entitytemplates from statictext within w_tv_amounttemplates
end type
type st_linkupdates from statictext within w_tv_amounttemplates
end type
type dw_2 from u_dw within w_tv_amounttemplates
end type
end forward

global type w_tv_amounttemplates from w_sheet
integer x = 0
integer y = 4
integer width = 3538
integer height = 2248
string title = "Payables Setup"
string menuname = "m_Sheets"
toolbaralignment toolbaralignment = alignatleft!
event ue_populate ( )
event type integer ue_save ( )
event ue_delete ( )
event ue_refreshlevel ( )
event ue_refreshitem ( )
event ue_refreshtree ( )
event ue_printtree ( )
event ue_insertrow ( )
event ue_deleteitem ( )
event ue_updatetree ( )
event ue_enable ( boolean ab_enable )
dw_1 dw_1
tv_1 tv_1
dw_3 dw_3
dw_4 dw_4
mle_datalist mle_datalist
st_2 st_2
st_1 st_1
mle_filterlist mle_filterlist
st_linked st_linked
st_unlinked st_unlinked
st_entitytemplates st_entitytemplates
st_linkupdates st_linkupdates
dw_2 dw_2
end type
global w_tv_amounttemplates w_tv_amounttemplates

type variables
DataStore	idsa_Data[4]
DataWindow	idw_Data[4]
Boolean		ib_Changed[4], ib_Retrieve
Boolean		ib_LoadGlobals = True
Boolean		ib_LoadCompanies = True
Boolean		ib_LoadEmployees = True
integer		ii_Template_ds = 1
integer		ii_Company_ds = 2
integer		ii_Employee_ds = 3

Long		il_ChangedItem[], il_CurrentItem[4]

// The following are used for the resizing service
boolean		ib_debug=False	//Debug mode
long		il_OldHeight	//Save the height of the window
integer		ii_windowborder=15	//Window border to be used on all sides
dragobject	idrg_Vertical	//Reference to the vertical control on the left of the window
dragobject	idrg_Horizontal[4]	//Reference to the horizontal controls on the right of the window

Protected:
boolean   ib_inserting=false
integer     ii_selectedlevel
long	il_dsrow
long         il_grandparentitemhandle
long         il_greatgrandparentitemhandle
long         il_parentitemhandle
long         il_xgreatgrandparentitemhandle
long         il_selecteditemhandle

long         il_OldParentItemHandle = 0
integer     ii_ID
string       is_task
long	il_rootitem

Private:
Long 	il_FullHeight 
Long	il_HalfHeight
n_cst_Toolmenu_Manager  inv_ToolmenuManager
end variables

forward prototypes
public subroutine wf_setrootlevel ()
public function integer wf_loademployeetree (long al_handle)
public function integer wf_loadcompanytree (long al_handle)
public function integer wf_loadglobaltree (long al_handle)
public function integer wf_linkentity ()
public function integer wf_linktemplate ()
public function integer wf_unlinkentity ()
public function integer wf_unlinktemplate ()
public function integer wf_reloadglobal ()
public function integer wf_reloadcompany ()
public function integer wf_reloademployee ()
public function integer wf_setnewentitytemplate (long al_row)
public function integer wf_setreftypeid (datawindow adw_datawindow)
public function integer wf_setdivision (integer ai_division)
public function integer wf_validateexpression (string as_type, string as_expression)
private function integer wf_resetupdates ()
private subroutine wf_calcheights ()
public function integer wf_showtemplate ()
public function integer wf_showentity ()
private function integer wf_newtemplate ()
private function integer wf_newcompany ()
private function integer wf_newemployee ()
private function integer wf_opentoentity (long al_entityid)
private function integer wf_opentocompany (long al_entityid)
private function integer wf_opentoemployee (long al_entityid)
public function integer wf_createtoolmenu ()
public subroutine wf_process_request (string as_request)
private subroutine wf_setuppayable ()
private subroutine wf_setuppayroll ()
public function string wf_validate (ref datawindow adw_dw)
private subroutine wf_setupemployee ()
end prototypes

event ue_save;//the pfc_save has the same save logic w.o the save query it is only called by the menu
// I don't have time to move that logic out and chase down all the places that call 
// this expecting it to ask to save.

Integer li_Result1 = 1
Integer li_Result4 = 1
Integer li_Return
Long 	  ll_msg
String	ls_Result = ""
li_Return = 1

IF li_Return = 1 THEN

	li_Result1 = dw_1.AcceptText()
	If li_Result1 = 1 Then 
		//OK
	ELSE
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN

	li_Result4 = dw_4.AcceptText()
	If li_Result4 = 1 Then 
		//OK
	ELSE
		li_Return = -1
	END IF
	
END IF

	
IF li_Return = 1 THEN
	
	IF dw_1.ModifiedCount() > 0 or &
		dw_4.ModifiedCount() > 0 or & 
		dw_4.DeletedCount() > 0  then 
		
		ll_msg = of_MessageBox ("Amount Template ",gnv_app.iapp_object.DisplayName, &
										"Do you want to save changes?", Exclamation!, YesNoCancel!, 1) 
		
		CHOOSE CASE ll_Msg
		
		CASE 1 //Yes

			If  dw_1.ModifiedCount() > 0 then 
				
				ls_Result = This.wf_Validate( dw_1 )		// RDT 6-13-03 
				if ls_Result = "" then 							// RDT 6-13-03 
					// ok												// RDT 6-13-03 
				else													// RDT 6-13-03 
					li_Return = -1									// RDT 6-13-03 
				end if												// RDT 6-13-03 
				if li_Return = 1 then							// RDT 6-13-03	
					If dw_1.Update(False,FALSE) = 1 THEN
						//OK
					ELSE
						ROLLBACK ;
						li_Return = -1
					End if
				end if												// RDT 6-13-03
			End If	
			
			IF li_Return = 1 AND ( dw_4.ModifiedCount() > 0 or dw_4.DeletedCount() > 0 ) then 
				ls_Result = This.wf_Validate( dw_4 )		// RDT 6-13-03 
				if ls_Result = "" then 							// RDT 6-13-03 
					// ok												// RDT 6-13-03 
				else													// RDT 6-13-03 
					li_Return = -1									// RDT 6-13-03 
				end if												// RDT 6-13-03 

				if li_Return = 1 then							// RDT 6-13-03	
					IF dw_4.Update(False,FALSE) = 1 THEN
						//OK
					ELSE
						ROLLBACK ;
						li_Return = -1
					End if
				end if												// RDT 6-13-03
			End If	
	
			If li_Return = 1 THEN 
				COMMIT ;
				dw_1.ResetUpdate ( )
				dw_4.ResetUpdate ( )
			Else
				MessageBox(gnv_App.of_GetAppName()+" Template Save ", "Error Saving Data. " + ls_Result)
			End If		
	
		CASE 2  //No
			//Return success without attempting save
			THIS.wf_ResetUpdates ( )
			
		CASE 3  //Cancel
			//Return "failure"  -- didn't save, don't proceed
			li_Return = -1
			
		CASE ELSE  //Unexpected return
			//Return "failure"
			li_Return = -1
	
		END CHOOSE
	Else
		// nothing needed saving so it was a success
	END IF	
	
END IF

Return li_Return
end event

public subroutine wf_setrootlevel ();
long 	ll_tvi
Long	ll_tvparent
Long	ll_Handle
treeviewitem ltvi_New


ltvi_New.label = "Global"
ltvi_New.Data = "G"
ltvi_New.PictureIndex = 1
ltvi_New.SelectedPictureIndex = 1
ll_Handle = tv_1.InsertItemFirst( 0, ltvi_New )
//tv_1.GetItem ( ll_Handle, item)

ltvi_New.label = "Companies"
ltvi_New.Data = "C"
ltvi_New.PictureIndex = 3
ltvi_New.SelectedPictureIndex = 3
ll_Handle = tv_1.InsertItemLast( 0, ltvi_New )

ltvi_New.label = "Employees"
ltvi_New.Data = "E"
ltvi_New.PictureIndex = 2
ltvi_New.SelectedPictureIndex = 2
ll_Handle = tv_1.InsertItemLast( 0, ltvi_New )


end subroutine

public function integer wf_loademployeetree (long al_handle);// create and retrieve datastore for all employees with entities
// loop thru row and load them into the tree view under the global branch

Long ll_RowCount, &
	  ll_Row
Integer li_ReturnCode
treeviewitem l_tvi
li_ReturnCode = 1

IF isValid ( idsa_data [ ii_employee_ds ] ) THEN
	DESTROY ( idsa_data [ ii_employee_ds ] )
END IF

idsa_data[ii_employee_ds] = create Datastore 
idsa_data[ii_employee_ds].DataObject = "d_AmountTemplateEntityEmp"
idsa_data[ii_employee_ds].SetTransObject(SQLCA)
if idsa_data[ii_employee_ds].retrieve() > 0 then
	idsa_data[ii_employee_ds].setfilter("employees_em_status = 'K'")
	idsa_data[ii_employee_ds].filter()
	ll_rowcount = idsa_data[ii_employee_ds].rowcount()
else
	ll_rowcount = 0
end if

FOR ll_row = 1 TO ll_Rowcount

	l_tvi.label=idsa_data[ii_employee_ds].GetItemString(ll_row,"employee_name")
	l_tvi.Data=idsa_data[ii_employee_ds].GetItemNumber(ll_row,"entity_id")
	tv_1.InsertItemLast(al_handle,l_tvi)

NEXT

Return li_ReturnCode

end function

public function integer wf_loadcompanytree (long al_handle);// create and retrieve datastore for all companies with entities
// loop thru row and load them into the tree view under the global branch

Long ll_RowCount, &
	  ll_Row
Integer li_ReturnCode
treeviewitem l_tvi
li_ReturnCode = 1

IF isValid ( idsa_data[ii_company_ds] ) THEN
	DESTROY ( idsa_data[ii_company_ds] )
END IF

idsa_data[ii_company_ds]= create Datastore 
idsa_data[ii_company_ds].DataObject = "d_AmountTemplateEntityComp"
idsa_data[ii_company_ds].SetTransObject(SQLCA)
ll_Rowcount=idsa_data[ii_company_ds].retrieve()

FOR ll_row = 1 TO ll_Rowcount
	l_tvi.label=idsa_data[ii_company_ds].GetItemString(ll_row,"companies_co_name")
	l_tvi.Data =idsa_data[ii_company_ds].GetItemNumber(ll_row,"entity_id")
	tv_1.InsertItemLast(al_handle,l_tvi)
NEXT

Return li_ReturnCode

end function

public function integer wf_loadglobaltree (long al_handle);// create and retrieve datastore for all global templates
// loop thru row and load them into the tree view under the global branch

Long ll_RowCount, &
	  ll_Row
Integer li_ReturnCode
String	ls_Select
n_cst_sql	lnv_sql
n_cst_SqlAttrib	lnv_SqlAttrib[]

treeviewitem l_tvi

li_ReturnCode = 1

IF isValid ( idsa_data [ ii_template_ds ] ) THEN
	DESTROY ( idsa_data [ ii_template_ds ] )
END IF


idsa_data[ii_template_ds] = create Datastore 
idsa_data[ii_template_ds].DataObject = "d_AmountTemplateGlobalone"
idsa_data[ii_template_ds].SetTransObject(SQLCA)

ls_Select = idsa_data[ii_template_ds].describe ( "DataWindow.table.Select" )

lnv_Sql.of_Parse ( ls_Select , lnv_SqlAttrib )
IF UpperBound ( lnv_SqlAttrib ) > 0 THEN  
	lnv_SqlAttrib[1].s_where = "~~~"amounttemplate~~~".~~~"fkentity~~~" is Null"		
	ls_Select = lnv_sql.of_Assemble ( lnv_SqlAttrib )
	IF Len ( ls_Select ) > 0 THEN
		idsa_data[ii_template_ds].Object.DataWindow.table.Select = ls_Select 
	END IF
END IF


ll_Rowcount=idsa_data[ii_template_ds].retrieve(1)
ll_row = 1

FOR ll_row = 1 TO ll_Rowcount
	l_tvi.label = idsa_data[ii_template_ds].GetItemString(ll_row,"amounttemplate_name")
	l_tvi.Data  = idsa_data[ii_template_ds].GetItemNumber(ll_row,"amounttemplate_id")
	tv_1.InsertItemLast(al_handle,l_tvi)
NEXT

Return li_ReturnCode

end function

public function integer wf_linkentity ();//MFS 8/22/06 - Check Privs before linking
Integer li_ReturnCode, &
		  li_EntityID, & 
		  li_SelectedRow, & 
		  li_Result
long    ll_InsertRow
Long	  ll_Division
Long	  ll_EmpId
boolean	lb_Skipped
boolean	lb_Authorized = TRUE

DataStore lds_join

n_cst_PrivsManager   lnv_privsManager

lds_Join = Create Datastore
lds_Join.DataObject = "d_amounttemplatejoinentity"
lds_Join.SetTransObject(SQLCA)
lds_Join.retrieve()

li_SelectedRow = 0
li_ReturnCode = 1

li_SelectedRow = dw_3.GetSelectedRow(0)

DO WHILE li_SelectedRow <> 0 
	lb_Authorized = TRUE
	li_EntityID = dw_3.GetItemNumber(li_SelectedRow, "id")
	
	//check divisional privs before linking
	ll_EmpId = dw_3.GetItemNumber(li_SelectedRow, "entity_fkemployee")
	IF ll_EmpId > 0 THEN
		ll_Division = dw_3.GetItemNumber(li_SelectedRow, "entity_division")
		lnv_privsManager = gnv_App.of_GetPrivsManager()
		IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyEmployeePayable, ll_Division) <> 1 THEN
			lb_Authorized = FALSE
		END IF
	END IF
	
	IF lb_Authorized THEN
		ll_InsertRow = lds_join.InsertRow(0)
		If ll_InsertRow = -1 then 
			messagebox("Payables Setup.","Error on Insert of Entity")
			li_ReturnCode = -1
			Exit
		End if
		lds_join.SetItem(ll_InsertRow, "fkEntity", li_EntityId)
		lds_join.SetItem(ll_InsertRow, "fkamounttemplate", ii_Id)
	ELSE
		lb_Skipped = TRUE
	END IF
	
	li_SelectedRow = dw_3.GetSelectedRow(li_SelectedRow)
LOOP


If li_ReturnCode = 1 then 
	lds_Join.AcceptText()
	li_Result = lds_Join.update(true, true)
	If li_Result = 1 	Then 
		COMMIT ;
		dw_2.Trigger event pfc_retrieve()
		dw_3.Trigger Event Pfc_Retrieve()
	Else
		ROLLBACK;
		li_ReturnCode = 1
		MessageBox(" Payables Setup","Error saving entity link. Please save template first.")
	End If
End If

//Some could not be linked, lack privs
IF lb_Skipped THEN
	MessageBox("Link Employee", "One or more employees could not be linked.~r~nYou are not authorized to modify employee payables for this division.", Exclamation!)
END IF


Destroy(lds_Join)

return li_ReturnCode

end function

public function integer wf_linktemplate ();
//
Integer li_ReturnCode, &
		  li_LinkID, & 
		  li_SelectedRow, &
		  li_Result 
long    ll_InsertRow

li_SelectedRow = 0
li_ReturnCode = 1

DataStore lds_join
lds_Join = Create Datastore
lds_Join.DataObject = "d_AmountTemplateJoinEntity"
lds_Join.SetTransObject(SQLCA)
lds_Join.retrieve()

li_SelectedRow = dw_3.GetSelectedRow(0)

DO WHILE li_SelectedRow <> 0 
	li_LinkID = dw_3.GetItemNumber(li_SelectedRow, "id")
	ll_InsertRow = lds_join.InsertRow(0)
	If ll_InsertRow = -1 then 
		messagebox("Error on Insert of row",String(ll_InsertRow))
		li_ReturnCode = -1
		Exit
	End if
	lds_join.SetItem(ll_InsertRow, "fkEntity", ii_ID)
	lds_join.SetItem(ll_InsertRow, "fkamounttemplate", li_LinkID)
	li_SelectedRow = dw_3.GetSelectedRow(li_SelectedRow)
LOOP

If li_ReturnCode = 1 then 
	lds_Join.AcceptText()
	li_Result = lds_Join.update(true, true)
	If li_Result = 1 	Then 
		COMMIT ;
		dw_2.Trigger event pfc_retrieve()
		dw_3.Trigger Event Pfc_Retrieve()
	Else
		ROLLBACK;
		li_ReturnCode = 1
		MessageBox(gnv_app.of_getappname ( )+" Payables Setup","Error Saving Entity Link")
	End If
End If

Destroy(lds_Join)

return li_ReturnCode

end function

public function integer wf_unlinkentity ();// find the row in the join table based on the selected row and delete it.
Integer li_ReturnCode, &
		  li_EntityID, & 
		  li_SelectedRow, &
		  li_Result 
long    ll_DeleteRow
String ls_EntityID,&
		 ls_AmountTemplateId, &
		 ls_FindString
Boolean	lb_Authorized = TRUE
Boolean 	lb_Skipped
long 		ll_division
long		ll_EmpId

n_cst_privsmanager lnv_Privsmanager

DataStore lds_join
lds_Join = Create Datastore
lds_Join.DataObject = "d_amounttemplatejoinentity"
lds_Join.SetTransObject(SQLCA)
lds_Join.retrieve()

li_SelectedRow = 0
li_ReturnCode = 1
ls_AmountTemplateId = String(ii_id)

li_SelectedRow = dw_2.GetSelectedRow(0)

DO WHILE li_SelectedRow <> 0 
	lb_Authorized = TRUE
	ls_EntityID = String(dw_2.GetItemNumber(li_SelectedRow, "id"))
	
	//check divisional privs for employees before linking
	ll_EmpId = dw_2.GetItemNumber(li_SelectedRow, "entity_fkemployee")
	IF ll_EmpId > 0 THEN
		ll_Division = dw_2.GetItemNumber(li_SelectedRow, "entity_division")
		lnv_privsManager = gnv_App.of_GetPrivsManager()
		IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyEmployeePayable, ll_Division) <> 1 THEN
			lb_Authorized = FALSE
		END IF
	END IF
	
	IF lb_Authorized THEN
		ll_deleteRow = lds_join.Find("fkEntity = "+ls_EntityId+" and fkamounttemplate = "+ls_AmountTemplateId, 1, lds_join.RowCount())
		IF ll_DeleteRow > 0 THEN
			lds_join.DeleteRow(ll_deleteRow)
		END IF
	ELSE
		lb_Skipped = TRUE
	END IF
	li_SelectedRow = dw_2.GetSelectedRow(li_SelectedRow)
LOOP

If li_ReturnCode = 1 then 
	lds_Join.AcceptText()
	li_Result = lds_Join.update(true, true)
	If li_Result = 1 	Then 
		COMMIT ;
		dw_2.Trigger event pfc_retrieve()
		dw_3.Trigger Event Pfc_Retrieve()
	Else
		ROLLBACK;
		li_ReturnCode = -1
		MessageBox("Payables Setup","Error Deleting Entity Link")
	End If
End If

//Some could not be linked, lack priv
IF lb_Skipped THEN
	MessageBox("UnLink Employee", "One or more employees could not be unlinked.~r~nYou are not authorized to modify employee payables for this division.", Exclamation!)
END IF

Destroy(lds_Join)

return li_ReturnCode

end function

public function integer wf_unlinktemplate ();// find the row in the join table based on the selected row and delete it.
Integer li_ReturnCode, &
		  li_LinkID, & 
		  li_SelectedRow, &
		  li_Result
long    ll_DeleteRow
String ls_EntityID,&
		 ls_AmountTemplateId, &
		 ls_FindString

DataStore lds_join
lds_Join = Create Datastore
lds_Join.DataObject = "d_amounttemplatejoinentity"
lds_Join.SetTransObject(SQLCA)
lds_Join.retrieve()

li_SelectedRow = 0
li_ReturnCode = 1
ls_EntityId = String(ii_ID)

li_SelectedRow = dw_2.GetSelectedRow(0)

DO WHILE li_SelectedRow <> 0 
	ls_AmountTemplateID = String(dw_2.GetItemNumber(li_SelectedRow, "id"))
	ll_deleteRow = lds_join.Find("fkEntity = "+ls_EntityId+" and fkamounttemplate = "+ls_AmountTemplateId, 1, lds_join.RowCount())
	IF ll_DeleteRow > 0 THEN
		lds_join.DeleteRow(ll_deleteRow)
	END IF
	li_SelectedRow = dw_2.GetSelectedRow(li_SelectedRow)
LOOP

If li_ReturnCode = 1 then 
	lds_Join.AcceptText()
	li_Result = lds_Join.update(true, true)
	If li_Result = 1 	Then 
		COMMIT ;
		dw_2.Trigger event pfc_retrieve()
		dw_3.Trigger Event Pfc_Retrieve()
	Else
		ROLLBACK;
		li_ReturnCode = 1
		MessageBox("Payables Setup","Error Deleting Template Link")
	End If
End If
Destroy(lds_Join)

return li_ReturnCode


end function

public function integer wf_reloadglobal ();long 	ll_tvi
Long	ll_tvparent
Long	ll_hand

treeviewitem ltvi_New

tv_1.collapseitem(1)
tv_1.DeleteItem(1)

ltvi_New.label="Global"
ltvi_New.Data="G"
ltvi_New.PictureIndex = 1
ltvi_New.SelectedPictureIndex = 1
ll_hand = tv_1.InsertItemFirst(0, ltvi_New)

wf_LoadGlobalTree(ll_hand)

tv_1.SelectItem ( ll_hand )


return 1
end function

public function integer wf_reloadcompany ();long ll_tvi, ll_tvparent, ll_hand
treeviewitem l_tvi

tv_1.collapseitem(2)
tv_1.DeleteItem(2)

l_tvi.label="Company"
l_tvi.Data="C"

ll_hand = tv_1.InsertItem ( 0, 1, l_tvi)
wf_LoadCompanyTree(ll_hand)
tv_1.SelectItem ( ll_hand )

return 1
end function

public function integer wf_reloademployee ();long ll_tvi, ll_tvparent, ll_hand
treeviewitem l_tvi

tv_1.collapseitem(3)
tv_1.DeleteItem(3)

l_tvi.label = "Employee"
l_tvi.Data = "E"

ll_hand = tv_1.InsertItem ( 0, 2, l_tvi)
wf_LoadEmployeeTree(ll_hand)
tv_1.SelectItem ( ll_hand )
return 1
end function

public function integer wf_setnewentitytemplate (long al_row);// 
// set the kfentity to the entity id when adding an Entity template 
/*
Revision: rdt 102602 Set default of amounttemplate_intervaltype when adding a new template
*/

long ll_Return, &
	  ll_NextId
	 
Long		ll_ReturnValue 
Int		li_Division	  

ll_Return = -1

//If dw_4.dataobject = "d_AmounttemplateAssigned" then 
IF al_Row > 0 THEN
	IF  gnv_app.of_getNextID ( "n_cst_beo_amountTemplate" , ll_NextID , TRUE /*commit*/ ) = 1 THEN

		dw_4.SetItem(al_Row,"amounttemplate_id",ll_NextID )
		dw_4.SetItem(al_Row,"amounttemplate_fkentity",ii_id)
		dw_4.SetItem(al_Row,"amounttemplate_category",n_cst_constants.ci_category_payables )
		dw_4.SetItem(al_Row,"amounttemplate_intervaltype", 0) 		// rdt 102602 

		dw_4.ScrollToRow(al_Row)

		IF dw_1.RowCount( ) = 1 THEN
			li_Division = dw_1.GetItemNumber( 1 , "entity_division" )
			IF NOT isNull ( li_Division ) THEN
				dw_4.SetItem( al_Row , "amounttemplate_division"  , li_Division )
			END IF

		END IF
		
		dw_4.SetITem ( al_Row , "amounttemplate_type" , appeon_constant.ci_Type_DateRange)


	END IF
END IF
//END IF
	

return ll_Return 

end function

public function integer wf_setreftypeid (datawindow adw_datawindow);
Long ll_num, ll_return

ll_return = 1
Setnull(ll_num)

Choose Case adw_datawindow.GetColumnName ( )
	Case "ref1typeid" 
		adw_datawindow.accepttext()
		If adw_datawindow.GetitemNumber(adw_datawindow.GetRow(),"Ref1TypeId") = 0 then
			adw_datawindow.SetItem(adw_datawindow.GetRow(),"Ref1TypeId",ll_num)
			ll_return = 2
		End if
	Case "ref2typeid"
		adw_datawindow.accepttext()
		If adw_datawindow.GetitemNumber(adw_datawindow.GetRow(),"Ref2TypeId") = 0 then
			adw_datawindow.SetItem(adw_datawindow.GetRow(),"Ref2TypeId",ll_num)
			ll_return = 2
		End if
	Case "ref3typeid"
		adw_datawindow.accepttext()
		If adw_datawindow.GetitemNumber(adw_datawindow.GetRow(),"Ref3TypeId") = 0 then
			adw_datawindow.SetItem(adw_datawindow.GetRow(),"Ref3TypeId",ll_num)
			ll_return = 2
		End if
	Case "amounttemplate_ref1typeid"
		adw_datawindow.accepttext()
		If adw_datawindow.GetitemNumber(adw_datawindow.GetRow(),"amounttemplate_ref1typeid") = 0 then
			adw_datawindow.SetItem(adw_datawindow.GetRow(),"amounttemplate_ref1typeid",ll_num)
			ll_return = 2
		End if
	Case "amounttemplate_ref2typeid"
		adw_datawindow.accepttext()
		If adw_datawindow.GetitemNumber(adw_datawindow.GetRow(),"amounttemplate_ref2typeid") = 0 then
			adw_datawindow.SetItem(adw_datawindow.GetRow(),"amounttemplate_ref2typeid",ll_num)
			ll_return = 2
		End if
	Case "amounttemplate_ref3typeid"
		adw_datawindow.accepttext()
		If adw_datawindow.GetitemNumber(adw_datawindow.GetRow(),"amounttemplate_ref3typeid") = 0 then
			adw_datawindow.SetItem(adw_datawindow.GetRow(),"amounttemplate_ref3typeid",ll_num)
			ll_return = 2
		End if
End Choose
Return ll_return
end function

public function integer wf_setdivision (integer ai_division);Integer li_rc = 1
n_cst_beo_ShipType	lnv_ShipType
Boolean	lb_Active

String	ls_Message, &
			ls_MessageHeader = "Change Division"

n_cst_OFRError	lnv_Error

lnv_ShipType = CREATE n_cst_beo_ShipType


IF li_rc > 0 THEN

	IF ai_Division = 0 THEN
		//User has selected None.  We will clear field.
		SetNull ( ai_Division )
		li_rc = 2  //To force redisplay of field

	ELSEIF IsNull ( ai_Division ) THEN
		//OK - No processing needed.

	ELSE

		lnv_ShipType.of_SetUseCache ( TRUE )
		lnv_ShipType.of_SetSourceId ( ai_Division )

		lb_Active = lnv_ShipType.of_IsActive ( )

		IF lb_Active = FALSE THEN
	
			ls_Message = "The division you have selected has been deactivated, and is only "+&
				"listed for historical display purposes.  Please make another selection, or "+&
				"press Esc twice to clear your edit."
			li_rc = -1

		ELSEIF IsNull ( lb_Active ) THEN

			ls_Message = "Could not validate your selection.  Please make another selection, or "+&
				"press Esc twice to clear your edit."
			li_rc = -1
	
		END IF

	END IF

END IF


//If an error explanation was provided above, create an OFRError.
//IF li_rc = -1 AND Len ( ls_Message ) > 0 THEN
//	lnv_Error = THIS.AddOFRError ( )
//	lnv_Error.SetErrorMessage( ls_Message )
//	lnv_Error.SetMessageHeader ( ls_MessageHeader )
//END IF

IF li_rc = -1 AND Len ( ls_Message ) > 0 THEN
	MessageBox ( ls_MessageHeader , ls_Message )
END IF 


DESTROY ( lnv_ShipType )
return li_rc

end function

public function integer wf_validateexpression (string as_type, string as_expression);//Returns: 1 = Valid, 0 = Empty or Null Expression, -1 = Invalid or Error
//RDT Returns: 0 = Valid, -1 = Empty or Null Expression, 1 = Invalid or Error
DataStore	lds_Data
//n_cst_OFRError	lnv_Error
String		ls_Field, &
				ls_ColType, &
				lsa_colname[], &
				ls_modify, &
				ls_Message = "Could not process request."

Integer	li_Return = 0

CHOOSE CASE Upper ( as_Type )

CASE "NUMERIC"
	ls_Field = "cf_Numeric"
	ls_ColType = "number"
	ls_modify = ls_Field + ".Expression = '" + as_Expression + "'"
	
CASE "CHAR"
	ls_Field = "cf_Numeric"
	ls_ColType = "char"
	ls_modify = ls_Field + '.Expression = "' + as_Expression + '"'
	
CASE ELSE  //Unexpected Value
	ls_Message = "Could not process request.  (Invalid type requested.)"
	li_Return = 1

END CHOOSE

IF li_Return = 0 THEN

	IF Len ( as_Expression ) > 0 THEN
		//check for ratecode expression
		if pos(as_expression,':',1) > 0 then
			//don't evaluate
		else	
			lds_Data = CREATE DataStore
			lds_Data.DataObject = "d_ItineraryData"
			
			IF lds_Data.Modify ( ls_modify ) = "" THEN
				//Expression is Valid.  Check whether it's the right type.
				IF Lower ( lds_Data.Describe ( ls_Field + ".ColType" ) ) = Lower ( ls_ColType ) THEN
					//Expression is the type expected.
				ELSE
					ls_Message = "The expression you have entered does not evaluate to a " + ls_ColType + "."
					li_Return = 1
				END IF
	
			ELSE
				ls_Message = "The expression you have entered is invalid."
				li_Return = 1
			END IF
			
			DESTROY lds_Data
		end if
	END IF

END IF

IF li_Return = 1 THEN
	MessageBox("Edit Expression", ls_Message )
END IF

RETURN li_Return

end function

private function integer wf_resetupdates ();Int	li_i
Int	li_Count

li_Count = UpperBound ( idsa_Data[] )

FOR li_i = 1 TO li_Count
	IF IsValid ( idsa_Data[ li_i ] ) THEN
		idsa_Data[ li_i ].ResetUpdate ( )
	END IF
NEXT

dw_1.ResetUpdate ( )
dw_2.ResetUpdate ( )
dw_3.ResetUpdate ( )
dw_4.ResetUpdate ( )

RETURN 1
end function

private subroutine wf_calcheights ();il_HalfHeight = dw_2.Height
il_FullHeight = dw_4.y - dw_2.y + dw_4.height
end subroutine

public function integer wf_showtemplate ();// performs setup for showing template details when a user clicks a template from TView
// create data stores for dw_1, dw_2, and dw_3
// retrieve data based on template id.
Integer li_ReturnCode
Long ll_Row 
String ls_Object1, &
		 ls_Object2, &
		 ls_Object3
		 
n_cst_PrivsManager	lnv_PrivsManager

ls_Object1 = "d_AmountTemplateGlobalone"
ls_Object2 = "d_AmountTemplateCompEmpLinked"
ls_Object3 = "d_AmountTemplateCompEmpNotLinked"

li_ReturnCode = 1

dw_1.DataObject = ls_object1
dw_1.SetTransObject(sqlca)

n_cst_Presentation_AmountType lnv_PresentationAmountType
lnv_PresentationAmountType.of_SetCategory ( n_cst_constants.ci_category_payables )

n_cst_presentation_amounttemplate lnv_PresentationAmounttemplate
lnv_PresentationAmounttemplate.of_Setpresentation(dw_1)

dw_2.DataObject = ls_object2
dw_2.SetTransObject(sqlca)
dw_2.of_SetRowSelect ( true)
dw_2.inv_Rowselect.of_SetStyle(2)

dw_3.DataObject = ls_object3
dw_3.SetTransObject(sqlca)
dw_3.of_SetRowSelect ( true)
dw_3.inv_Rowselect.of_SetStyle(2)


//Enable all dws
dw_1.Event ue_SetEnable(True)
dw_2.Event ue_SetEnable(True)
dw_3.Event ue_SetEnable(True)


dw_1.Trigger Event Pfc_Retrieve() //rowfocuschanged may enable disable payroll or payable id's
lnv_PresentationAmountType.of_Setpresentation(dw_1)

dw_2.Trigger Event Pfc_Retrieve()
dw_3.Trigger Event Pfc_Retrieve()

lnv_privsManager = gnv_App.of_GetPrivsManager()
//Allow editing based on priv
IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyGlobalPayable) <> 1 THEN
	dw_1.Event ue_SetEnable(False)
END IF

dw_2.Height = il_FullHeight
dw_3.Height = il_FullHeight

// hide the shown stuff ;)
dw_4.visible= false
st_entitytemplates.visible = false

Return li_ReturnCode
end function

public function integer wf_showentity ();// performs setup for showing company details when a user clicks TView
// create data stores for dw_1, dw_2, and dw_3
// retrieve data based on template id.
Integer li_ReturnCode
Long ll_Row 
String 	ls_Select

String ls_Object1, &
		 ls_Object2, &
		 ls_Object3, &
		 ls_Object4
Long	ll_Division
Boolean lb_Authorized = TRUE

n_cst_PrivsManager		lnv_privsManager

n_cst_sql			lnv_Sql
n_cst_sqlAttrib	lnv_SqlAttrib[]
n_cst_String		lnv_String


ls_Object1 = "d_entitylist2"
ls_Object2 = "d_AmounttemplateLinked"
ls_Object3 = "d_AmounttemplateNotLinked"
//ls_Object4 = "d_AmounttemplateAssigned"
ls_Object4 = "d_AmountTemplateGlobalone"

n_cst_presentation_amounttemplate lnv_PresentationAmounttemplate

n_cst_Presentation_AmountType lnv_PresentationAmountType
lnv_PresentationAmountType.of_SetCategory ( n_cst_constants.ci_category_payables )

li_ReturnCode = 1
dw_1.DataObject = ls_object1
dw_1.SetTransObject(sqlca)
lnv_PresentationAmounttemplate.of_Setpresentation(dw_1)
lnv_PresentationAmountType.of_Setpresentation(dw_1)

// linked dw
dw_2.DataObject = ls_object2
dw_2.SetTransObject(sqlca)
dw_2.of_SetRowSelect ( true)
dw_2.inv_Rowselect.of_SetStyle(2)
lnv_PresentationAmounttemplate.of_Setpresentation(dw_2)
lnv_PresentationAmountType.of_Setpresentation(dw_2)

// unlinked dw
dw_3.DataObject = ls_object3
dw_3.SetTransObject(sqlca)
dw_3.of_SetRowSelect ( true)
dw_3.inv_Rowselect.of_SetStyle(2)
lnv_PresentationAmounttemplate.of_Setpresentation(dw_3)
lnv_PresentationAmountType.of_Setpresentation(dw_3)



//if ls_Object4 <> "" then // why is this here
	dw_4.DataObject = ls_object4		
	dw_4.SetTransObject(sqlca)
	
	
	lnv_PresentationAmounttemplate.of_Setpresentation(dw_4)
	lnv_PresentationAmountType.of_Setpresentation(dw_4)
	
	ls_Select = dw_4.describe ( "DataWindow.table.Select" )
	
	lnv_Sql.of_Parse ( ls_Select , lnv_SqlAttrib )
	IF UpperBound ( lnv_SqlAttrib ) > 0 THEN  
//		the retreval arg has 'id' it so i have to do a swap
		lnv_SqlAttrib[1].s_where =	lnv_String.of_GlobalReplace ( lnv_SqlAttrib[1].s_where , "_id" , "***" )	
		lnv_SqlAttrib[1].s_where =	lnv_String.of_GlobalReplace ( lnv_SqlAttrib[1].s_where , "id" , "fkentity" )	
		lnv_SqlAttrib[1].s_where =	lnv_String.of_GlobalReplace ( lnv_SqlAttrib[1].s_where , "***" , "_ID" )	
		ls_Select = lnv_sql.of_Assemble ( lnv_SqlAttrib )
		IF Len ( ls_Select ) > 0 THEN
			dw_4.Object.DataWindow.table.Select = ls_Select 
		END IF
	END IF
		
	dw_4.visible= TRUE
	st_entitytemplates.visible = TRUE
	
	dw_2.height = il_HalfHeight
	dw_3.height = il_HalfHeight
	
//end if


//Enable all datawindows
dw_1.Event ue_SetEnable(TRUE)
dw_2.Event ue_SetEnable(TRUE)
dw_3.EVent ue_SetEnable(TRUE)
dw_4.EVent ue_SetEnable(TRUE)



dw_1.Trigger Event Pfc_Retrieve()//rowfocuschanged may enable disable payroll or payable id's
dw_2.Trigger Event Pfc_Retrieve()
dw_3.Trigger Event Pfc_Retrieve()
dw_4.Trigger Event Pfc_Retrieve()

//Check user permissions to enable disable user access to employees
IF is_Task = "E" THEN
	ll_Row = dw_1.GetRow()
	IF ll_Row > 0 THEN
		ll_Division = dw_1.GetItemNumber(ll_Row, "entity_division")
		lnv_privsManager = gnv_App.of_GetPrivsManager()
		//Allow editing based on priv
		IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyEmployeePayable, ll_Division) <> 1 THEN
			dw_1.Event ue_SetEnable(FALSE)
			dw_2.Event ue_SetEnable(FALSE)
			dw_3.Event ue_SetEnable(FALSE)
			dw_4.Event ue_SetEnable(FALSE)
		END IF
	END IF
END IF

// hide stuff
//mle_datalist.visible = False
//mle_filterlist.visible = False
//st_1.visible = False
//st_2.visible = False
//

Return li_ReturnCode
end function

private function integer wf_newtemplate ();/*
Revision: rdt 102602 Set default of amounttemplate_intervaltype when adding a new template
Revision: MFS 08/22/06 - ModifyGlobalTemplate priv	
*/

Long	ll_Row
Long	ll_NextId
Int	li_Return = -1

n_cst_PrivsManager	lnv_PrivsManager

lnv_privsManager = gnv_App.of_GetPrivsManager()

IF lnv_PrivsManager.of_GetUserpermissionfromfn(lnv_PrivsManager.cs_ModifyGlobalPayable) = 1 THEN
	
	dw_3.Reset()
	//IF dw_1.DataObject <> "amounttemplateglobalone" THEN
		wf_ShowTemplate ( )
	//END IF
	dw_2.Reset()
	
	dw_1.Reset()
	
	dw_1.SetRow(dw_1.InsertRow(0))
	SetFocus(dw_1)
	IF gnv_app.of_getNextID ( "n_cst_beo_amountTemplate" , ll_NextID , TRUE /*commit*/ ) = 1 THEN
		ll_row = dw_1.getrow()	            
		IF ll_Row > 0 AND Lower ( dw_1.DataObject ) = "d_amounttemplateglobalone" THEN
			dw_1.SetItem(ll_Row,"amounttemplate_id",ll_NextID )
			ii_id = ll_NextID 														// rdt 102602 
			dw_1.SetItem(ll_Row,"amounttemplate_category",n_cst_constants.ci_category_payables )
			dw_1.SetItem(ll_Row,"amounttemplate_intervaltype", 0) 		// rdt 102602 
			
			li_Return = 1
		END IF
	END IF
ELSE
	MessageBox("Add Template", "You are not authorized to modify global settlement templates.", Exclamation!)
END IF


Return li_Return

end function

private function integer wf_newcompany ();Int	li_Return = -1

String	ls_Search = ""
String	ls_type
String 	ls_fn
long		ll_EntityID
Long		ll_ValidateId = 0
Long		ll_Row
Boolean	lb_AllowCreate = TRUE
Boolean	lb_createquery = TRUE
Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Boolean	lb_Search = false
Boolean	lb_validate

//Long		ll_NextId
//Boolean  lb_Employee 
//Boolean	lb_Company
//String	ls_MessageHeader
//String 	ls_Empty = ""
//String 	ls_Entity
//String 	ls_ln

TreeViewItem ltvi_item
s_co_Info 	lstr_Company

li_Return = gnv_cst_Companies.of_Select &
	( lstr_Company, ls_Type, lb_Search, "", lb_Validate, &
	  0, lb_AllowHold, lb_Notify )
	  
IF NOT ( li_Return = 1 AND NOT isNull ( lstr_Company.co_id  ) ) THEN
	li_Return = -1 
END IF

IF li_Return = 1 THEN
		  
	gnv_cst_Companies.of_GetEntity (lstr_Company.co_id, ll_EntityId, &
										lb_AllowCreate, lb_createquery , FALSE /*OpenSetup*/ )
		
	IF ll_EntityID > 0 THEN
		
		ii_ID = ll_EntityID
		// Check for an existing row in the datastore. 
		ls_Search = "entity_id =" + String(ll_EntityID)
		ll_Row = idsa_data[ii_company_ds].Find( ls_Search, 0, idsa_data[ ii_company_ds ].RowCount( ) )
		
		If ll_row = 0 Then 
		// row not found so add to tree and scroll to new item.
		
			SELECT C.co_name
			INTO   :ls_fn
			FROM   entity as E, companies as C
			WHERE  ( E.fkcompany = C.co_id ) and ( ( E.id = :ii_id) )  ;
			
			If SQLCA.SQLCode = 0 Then 
				ltvi_item.label=ls_fn
				ltvi_item.Data=ii_id
				tv_1.SelectItem ( tv_1.InsertItemLast(2,ltvi_item))
				SetFocus( dw_1 )
			End If
			
			Commit;
			
		Else
			MessageBox("Duplicate Company","Duplicate found. Please review the list.")
		End If
	END IF
END IF

RETURN li_Return
end function

private function integer wf_newemployee ();String	ls_Empty
String	ls_Search
String	ls_fn
String	ls_ln
Boolean	lb_AllowCreate	= TRUE
Boolean	lb_CreateQuery = TRUE
Long		ll_Row
Long		ll_EntityID

n_Cst_EmployeeManager	lnv_EmpManager
TreeViewItem	ltvi_Item

lnv_EmpManager.of_getentitybyentry ( ls_Empty, ll_EntityID, lb_allowcreate, lb_createquery )

IF ll_EntityID > 0 THEN
	// Check for an existing row in the datastore. 
	ls_Search = "entity_id =" + String(ll_EntityID)
	
	ll_Row = idsa_data[ii_employee_ds].Find( ls_Search, 0, idsa_data[ ii_employee_ds ].RowCount() )
	If ll_row = 0 Then 
		ii_id = ll_EntityId
		// add to tree and scroll to new item.
		SELECT E.em_fn, E.em_ln
		INTO   :ls_fn, :ls_ln
		FROM   entity as N, employees as E
		WHERE  (E.em_id = N.fkemployee ) and ( ( N.id = :ii_Id ) );

		If SQLCA.SQLCode = 0 Then 
			ltvi_item.label=ls_ln+", "+ls_fn
			ltvi_item.Data=ii_id
			tv_1.SelectItem ( tv_1.InsertItemLast(3,ltvi_item))
			SetFocus(dw_1)
		End If
	
		commit;
	
	Else
		MessageBox("Add Employee ","Duplicate found. Please review the list.")
	End If
END IF

RETURN 1
end function

private function integer wf_opentoentity (long al_entityid);Long	ll_RowCount 
Long	ll_EmpID
Long	ll_CoID
Int	li_Return = -1 

dataStore	lds_Entity
lds_Entity = CREATE DataStore

lds_Entity.DataObject = "d_EntityList"
lds_Entity.SetTransObject ( SQLCA )

ll_RowCount = lds_Entity.Retrieve ( {al_EntityID} )

IF ll_RowCount > 0 THEN // should only be one
	ll_EmpID = lds_Entity.GetItemNumber( 1 , "entity_fkemployee" )
	ll_CoID = lds_Entity.GetItemNumber( 1 , "entity_fkcompany" )
	
	IF IsNull ( ll_EmpID ) THEN
		IF THIS.wf_OpenToCompany ( al_EntityID ) = 1 THEN
			li_Return = 1 
		END IF
	ELSE
		IF THIS.wf_OpenToEmployee ( al_EntityID ) = 1 THEN
			li_Return = 1 
		END IF
	END IF

END IF

Destroy ( lds_Entity )

RETURN li_Return
end function

private function integer wf_opentocompany (long al_entityid);Long	ll_i
Long	lla_Handles[]
Long	ll_Handle
Long	ll_Return = -1
Int	li_Next
TreeViewItem	ltvi_Current

//THIS.wf_ReloadCompany ( )

THIS.wf_loadCompanyTree ( 2 )

tv_1.Post ExpandItem ( 2 )
ib_loadcompanies = FALSE

li_next = upperbound(lla_Handles) + 1

ll_handle = tv_1.FindItem(ChildTreeItem! , 2)

// add siblings to the queue
Do While ll_handle > 0
	// add handle to queue
	li_next = upperbound(lla_Handles) + 1
	lla_Handles[li_next] = ll_handle
	ll_handle = tv_1.FindItem(NextTreeItem!, ll_handle)
Loop

FOR ll_i = 1 TO li_Next
	tv_1.GetItem ( lla_Handles[ll_i], ltvi_Current)
	IF ltvi_Current.data = al_entityid THEN
		EXIT 
	END IF
NEXT


IF ll_i <= li_Next THEN // found it
	tv_1.SelectItem ( lla_Handles[ll_i] )
	ll_Return = 1
END IF

RETURN ll_Return
end function

private function integer wf_opentoemployee (long al_entityid);Long	ll_i
Long	lla_Handles[]
Long	ll_Handle
Long	ll_Return = -1
Int	li_Next
TreeViewItem	ltvi_Current

//THIS.wf_ReloadEmployee ( )

THIS.wf_LoadEmployeeTree ( 3 ) 

li_next = upperbound(lla_Handles) + 1

ll_handle = tv_1.FindItem(ChildTreeItem! , 3)

tv_1.Post ExpandItem ( 3 )
ib_loademployees = FALSE

// add siblings to the queue
Do While ll_handle > 0
	// add handle to queue
	li_next = upperbound(lla_Handles) + 1
	lla_Handles[li_next] = ll_handle
	ll_handle = tv_1.FindItem(NextTreeItem!, ll_handle)
Loop

FOR ll_i = 1 TO li_Next
	tv_1.GetItem ( lla_Handles[ll_i], ltvi_Current)
	IF ltvi_Current.data = al_entityid THEN
		EXIT 
	END IF
NEXT


IF ll_i <= li_Next THEN // found it
	tv_1.SelectItem ( lla_Handles[ll_i] )
	ll_Return = 1
END IF

RETURN ll_Return
end function

public function integer wf_createtoolmenu ();s_toolmenu lstr_toolmenu

if isvalid(inv_ToolmenuManager) then return 0

inv_ToolmenuManager = create n_cst_toolmenu_manager
inv_ToolmenuManager.of_set_parent(this)

inv_ToolmenuManager.of_add_standard("DIVIDER!")

inv_ToolmenuManager.of_make_default(lstr_toolmenu, false, true)
lstr_toolmenu.s_name = "SAVE!"
lstr_toolmenu.s_menuitem_text = "&Save~tCtrl+S"
inv_ToolmenuManager.of_add_toolmenu(lstr_toolmenu)

inv_ToolmenuManager.of_set_target_menu(m_sheets.m_current)

return 1
end function

public subroutine wf_process_request (string as_request);CHOOSE CASE as_Request
	
	CASE "SAVE!"
		PostEvent ( "pfc_Save" )
END CHOOSE
		
end subroutine

private subroutine wf_setuppayable ();//
/***************************************************************************************
NAME			: wf_SetupPayable
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: none
DESCRIPTION	: Unprotects Payable id and changes colors to white 
				  Protects   Payroll Id and changes colors to grey
REVISION		: RDT 5-9-03 
***************************************************************************************/

Long	ll_Grey, &
		ll_White
		
ll_Grey  = RGB(128,128,128)
ll_White = RGB(255,255,255)

dw_1.Object.entity_payrollid.Protect = 1
dw_1.Object.entity_payrollid.Background.Color = ll_Grey

dw_1.Object.entity_payablesid.Protect = 0
dw_1.Object.entity_payablesid.Background.Color = ll_White

end subroutine

private subroutine wf_setuppayroll ();//
/***************************************************************************************
NAME			: wf_SetupPayable
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: none
DESCRIPTION	: 	  Protects   Payable Id and changes colors to grey
					  Unprotects Payroll id and changes colors to white 
REVISION		: RDT 5-9-03 
***************************************************************************************/

Long	ll_Grey, &
		ll_White
		
ll_Grey  = RGB(128,128,128)
ll_White = RGB(255,255,255)

dw_1.Object.entity_payrollid.Protect = 0
dw_1.Object.entity_payrollid.Background.Color = ll_White

dw_1.Object.entity_payablesid.Protect = 1
dw_1.Object.entity_payablesid.Background.Color = ll_Grey

end subroutine

public function string wf_validate (ref datawindow adw_dw);
Long	ll_row, ll_rowCount
String ls_Return = ""

long ll
String ls_do 
ls_do = adw_dw.DataObject

Choose Case adw_dw.DataObject
		
	Case "d_AmountTemplateGlobalone"
		// test for amount type
		ll_RowCount = adw_dw.RowCount()
		
		If ll_RowCount > 0 then 
			
			For ll_Row = 1 to ll_RowCount
				
				ll = 	adw_dw.GetItemNumber( ll_Row, "amounttemplate_amounttypeid") 
				ls_do = String(adw_dw.GetItemNumber( ll_Row, "amounttemplate_amounttypeid") )
				
				if IsNull ( adw_dw.GetItemNumber( ll_Row, "amounttemplate_amounttypeid") ) OR &
								adw_dw.GetItemNumber( ll_Row, "amounttemplate_amounttypeid") < 1 then 
					
					ls_Return = "Amount Type is Missing."
					ll_Row = ll_RowCount  
					
				end if
					
			Next
			
		End if
		
End Choose


Return ls_Return 
end function

private subroutine wf_setupemployee ();//
/***************************************************************************************
NAME			: wf_SetupEmployee
ACCESS		: Private 
ARGUMENTS	: none
RETURNS		: none
DESCRIPTION	: 	  Protects   Payable Id and changes colors to grey
					  Protects   Payroll id and changes colors to white 
REVISION		: RDT 7-28-03 
***************************************************************************************/

Long	ll_Grey, &
		ll_White
		
ll_Grey  = RGB(128,128,128)
ll_White = RGB(255,255,255)

dw_1.Object.entity_payrollid.Protect = 1
dw_1.Object.entity_payrollid.Background.Color = ll_Grey

dw_1.Object.entity_payablesid.Protect = 1
dw_1.Object.entity_payablesid.Background.Color = ll_Grey

end subroutine

on w_tv_amounttemplates.create
int iCurrent
call super::create
if this.MenuName = "m_Sheets" then this.MenuID = create m_Sheets
this.dw_1=create dw_1
this.tv_1=create tv_1
this.dw_3=create dw_3
this.dw_4=create dw_4
this.mle_datalist=create mle_datalist
this.st_2=create st_2
this.st_1=create st_1
this.mle_filterlist=create mle_filterlist
this.st_linked=create st_linked
this.st_unlinked=create st_unlinked
this.st_entitytemplates=create st_entitytemplates
this.st_linkupdates=create st_linkupdates
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.mle_datalist
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.mle_filterlist
this.Control[iCurrent+9]=this.st_linked
this.Control[iCurrent+10]=this.st_unlinked
this.Control[iCurrent+11]=this.st_entitytemplates
this.Control[iCurrent+12]=this.st_linkupdates
this.Control[iCurrent+13]=this.dw_2
end on

on w_tv_amounttemplates.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.tv_1)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.mle_datalist)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_filterlist)
destroy(this.st_linked)
destroy(this.st_unlinked)
destroy(this.st_entitytemplates)
destroy(this.st_linkupdates)
destroy(this.dw_2)
end on

event open;long		ll_ndx, &
			ll_arraycount, &
			ll_row

Long		ll_EntityID

SetPointer(HourGlass!)
n_cst_Privileges	lnv_Privileges

IF NOT gnv_App.of_Getprivsmanager( ).of_useadvancedprivs( ) THEN
	IF lnv_Privileges.of_Settlements_EntitySetup ( ) = TRUE THEN
		//User is authorized.
	ELSE
		MessageBox ( "Entity Payables Setup", lnv_Privileges.of_GetRestrictMessage ( ) )
		Close ( This )
		RETURN							//// MID CODE RETURN \\\
	END IF
END IF


ll_EntityId = Message.DoubleParm

dw_1.of_setbase(true)
dw_1.of_SetTransObject(sqlca)
dw_1.of_setproperty(true)

//gf_Mask_Menu(m_Sheets)
This.wf_CreateToolmenu ( )


// set root level items
this.wf_SetRootLevel()

// The following lines are for setting up the resizing service
il_OldHeight = This.WorkspaceHeight()
idrg_Vertical = tv_1

//// Set DataWindow objects in array
idw_Data[1] = dw_1
idw_Data[2] = dw_2
idw_Data[3] = dw_3
idw_Data[4] = dw_4

//Enable the Resize Service
This.of_SetResize ( TRUE )

//Set size so that proper alignment will be kept when opening as layered (full screen)
inv_Resize.of_SetOrigSize ( This.Width - 16, This.Height - 144 )
inv_Resize.of_SetMinSize ( 1300, 400 )

//Register Resizable controls
inv_Resize.of_Register ( dw_1, 'Scale' )
inv_Resize.of_Register ( dw_2, 'Scale' )
inv_Resize.of_Register ( dw_3, 'Scale' )
inv_Resize.of_Register ( dw_4, 'Scale' )
inv_Resize.of_Register ( st_1, 'Scale' )
inv_Resize.of_Register ( st_2, 'Scale' )
inv_Resize.of_Register ( st_linked, 'Scale' )
inv_Resize.of_Register ( st_unlinked, 'Scale' )
inv_Resize.of_Register ( st_linkupdates, 'Scale' )
inv_Resize.of_Register ( st_entitytemplates, 'Scale' )
inv_Resize.of_Register ( mle_filterlist, 'Scale' )
inv_Resize.of_Register ( mle_datalist, 'Scale' )
inv_Resize.of_Register ( tv_1, 'Scale' )

IF NOT isNull ( ll_EntityID ) THEN
	THIS.wf_OpenToEntity ( ll_EntityID )
END IF


THIS.Post wf_CalcHeights ( )

n_Cst_presentation_AmountType	lnv_AmountType
lnv_AmountType.of_SetPresentation ( dw_4 ) 


end event

event close;Integer	li_Cnt
long		ll_ndx, &
			ll_arraycount

ll_arraycount = upperbound(idsa_Data)
For ll_ndx = 1 To ll_arraycount
	Destroy idsa_Data[ll_ndx]
Next

DESTROY inv_ToolmenuManager
end event

event pfc_save;
Integer li_Result1 = 1
Integer li_Result4 = 1
Integer li_Return
Long 	  ll_msg
String	ls_Result = ""

li_Return = 1

IF li_Return = 1 THEN

	li_Result1 = dw_1.AcceptText()
	If li_Result1 = 1 Then 
		//OK
		ls_Result = This.wf_Validate( dw_1 )		// RDT 6-13-03 
		if ls_Result = "" then 							// RDT 6-13-03 
			// ok												// RDT 6-13-03 
		else													// RDT 6-13-03 
			MessageBox(gnv_App.of_GetAppName()+" Template Save ",ls_Result)		// RDT 6-13-03 
			li_Return = -1									// RDT 6-13-03 
		end if												// RDT 6-13-03 
	ELSE
		li_Return = -1
	END IF
	
END IF

IF li_Return = 1 THEN

	li_Result4 = dw_4.AcceptText()
	If li_Result4 = 1 Then 
		//OK
		ls_Result = This.wf_Validate( dw_4 )		// RDT 6-13-03 
		if ls_Result = "" then 							// RDT 6-13-03 
			// ok												// RDT 6-13-03 
		else													// RDT 6-13-03 
			MessageBox(gnv_App.of_GetAppName()+" Template Save ",ls_Result)		// RDT 6-13-03 
			li_Return = -1									// RDT 6-13-03 
		end if												// RDT 6-13-03 
	ELSE
		li_Return = -1
	END IF
	
END IF

	
IF li_Return = 1 THEN
	
	IF dw_1.ModifiedCount() > 0 or &
		dw_4.ModifiedCount() > 0 or & 
		dw_4.DeletedCount() > 0  then 
		
	
		If  dw_1.ModifiedCount() > 0 then 
			If dw_1.Update(False,FALSE) = 1 THEN
				//OK
			ELSE
				ROLLBACK ;
				li_Return = -1
			End if
		End If	
		
		IF li_Return = 1 AND ( dw_4.ModifiedCount() > 0 or dw_4.DeletedCount() > 0 ) then 
			IF dw_4.Update(False,FALSE) = 1 THEN
				//OK
			ELSE
				ROLLBACK ;
				li_Return = -1
			End if
		End If	

		If li_Return = 1 THEN 
			COMMIT ;
			dw_1.ResetUpdate ( )
			dw_4.ResetUpdate ( )
		Else
			MessageBox(gnv_App.of_GetAppName()+" Payables Setup", "Error Saving Data")
		End If		
	
		
	Else
		// nothing needed saving so it was a success
	END IF	
	
END IF

Return li_Return
end event

type dw_1 from u_dw within w_tv_amounttemplates
event ue_setenable ( boolean ab_enable )
integer x = 1088
integer y = 24
integer width = 2386
integer taborder = 20
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_setenable(boolean ab_enable);Long		ll_ColumnCount
Long		i
String	ls_ColName
String	lsa_ColList[]
string	ls_ret

n_cst_DwSrv		lnv_Dwsrv

lnv_Dwsrv = Create n_cst_DwSrv
lnv_Dwsrv.of_SetRequestor( This )

ll_ColumnCount = lnv_Dwsrv.of_Getobjects( lsa_ColList[], "*", "detail", true /*visibleonly*/)
This.SetRedraw(FALSE)
FOR i = 1 TO ll_ColumnCount
	ls_ColName = lsa_ColList[i]
	
	IF ab_Enable THEN
		ls_ret = This.Modify( ls_ColName + ".protect=0" )
		ls_ret = This.Modify( ls_ColName + ".background.color='" + String(rgb(255,255,255)) + "'" )
	ELSE
		ls_ret = This.Modify( ls_ColName + ".protect=1" )
		ls_ret = This.Modify( ls_ColName + ".background.color='" + String(rgb(128,128,128)) + "'" )	
	END IF
	
NEXT
This.SetRedraw(TRUE)

Destroy(lnv_Dwsrv)
end event

event pfc_retrieve;call super::pfc_retrieve;Return this.retrieve(ii_id)	

end event

event constructor;ib_rmbmenu = False

n_cst_Presentation_AmountType lnv_PresentationAmountType
lnv_PresentationAmountType.of_SetCategory ( n_cst_constants.ci_category_payables )


end event

event itemchanged;call super::itemchanged;//0  (Default) Accept the data value
//1  Reject the data value and don't allow focus to change
//2  Reject the data value but allow the focus to change

// force Ref1TypeId Ref2TypeId Ref3TypeId values to null if = 0
Long 		ll_null, ll_return
String	ls_Null

ll_return = ancestorreturnvalue
SetNull(ls_Null)
Setnull(ll_Null)

Choose Case dwo.name //this.GetColumnName ( )
		
	Case "ref1typeid", "ref2typeid", "ref3typeid", "ratetypeid", &
		  "amounttemplate_ref1typeid", "amounttemplate_ref2typeid", "amounttemplate_ref3typeid","amounttemplate_ratetypeid"
		  
		IF isNumber( Data ) THEN  
			IF Long ( Data )  = 0 THEN 
				this.SetItem( row , String ( dwo.name ) ,ll_Null)
				ll_Return = 2
			END IF
		END IF


	Case "amounttemplate_division"
		  
		IF Data = "0" THEN
			SetNull ( ll_Null )
			dwo.Primary [ Row ] = ll_Null
			parent.wf_setdivision( ll_Null )			
			ll_Return = 2
		END IF
		

	Case "amounttemplate_aggregatecalc"
		
		IF Data = "0" THEN 
			this.SetItem( row , "amounttemplate_splitsby" ,ls_Null)				
		END IF
					
	Case "amounttemplate_quantity", "amounttemplate_rate", "amounttemplate_amount", "amounttemplate_generationcondition"
		//0 = Valid, -1 = Empty or Null Expression, 1 = Invalid or Error
		IF parent.wf_validateexpression("NUMERIC", data ) = 1 THEN
			ll_Return = 1
		END IF			

	Case "amounttemplate_selectionfilter"
			IF parent.wf_validateexpression("CHAR", data ) = 1 THEN
				ll_Return = 1
			END IF				
				
End Choose
	
Return ll_Return
end event

event itemerror;call super::itemerror;// 1 = Reject the data value with no message box

Long	ll_Return

ll_Return = AncestorReturnValue
CHOOSE CASE dwo.name 
	CASE "amounttemplate_quantity", "amounttemplate_rate", "amounttemplate_amount", &
		"amounttemplate_generationcondition" , "amounttemplate_selectionfilter"
		ll_Return = 1  // message should be provided by method called in item changed
	
	END CHOOSE
	

RETURN ll_Return

end event

event rowfocuschanged;call super::rowfocuschanged;// RDT 5-9-03 disable payroll or payable id's based on employee type

Long ll_Return = 1
Long	ll_Row

IF This.DataObject = "d_entitylist2" Then 
	ll_Row = This.GetRow()
	IF ll_Row > 0 THEN
		
		If IsNull ( this.GetItemNumber( ll_Row, 'entity_fkcompany' ) ) Then 
			
			Choose Case this.GetItemNumber( This.GetRow(), 'di_type_driver' )
					
				Case n_cst_constants.ci_employee_owneroperator, n_cst_constants.ci_employee_3rdparty
					Parent.wf_SetupPayable()
					
					if Len( Trim( This.GetItemString( 1 , 'entity_payrollid' ) ) ) > 0 Then 
						MessageBox("Payable Error ", "Entity is an Owner Operator or 3rd Party and can not have a Payroll Id.~nPayroll Id will be cleared.")
						This.SetItem( 1 , 'entity_payrollid','' )
					end if
					
				Case n_cst_constants.ci_employee_companydriver, n_cst_constants.ci_employee_casual
					Parent.wf_SetupPayRoll()
			
					if Len( Trim( This.GetItemString( 1 , 'entity_payablesid' ) ) ) > 0 Then 
						MessageBox("Payable Error ", "Entity is a Company or Casual Driver and can not have a Payables Id.~nPayables Id will be cleared.")
						This.SetItem( 1 , 'entity_payablesid','' )
					end if
		
				Case Else // must be an employee that is not a driver
					Parent.wf_SetupEmployee()
					
					if ( Len( Trim( This.GetItemString( 1 , 'entity_payablesid' ) ) ) > 0 ) OR &
						( Len( Trim( This.GetItemString( 1 , 'entity_payrollid' ) ) ) > 0 )  Then 
						MessageBox("Payable Error ", "Entity has no driver type and can not have a Payroll or Payables Id.~nIds will be cleared.")
						This.SetItem( 1 , 'entity_payablesid','' )
						This.SetItem( 1 , 'entity_payrollid','' )
					end if
					
			End Choose
			
		Else
			// must be a Company Record 
			Parent.wf_SetupPayable()
			if Len( Trim( This.GetItemString( 1 , 'entity_payrollid' ) ) ) > 0 Then 
				MessageBox("Payable Error ", "Entity is a Company and can not have a Payroll Id.~nPayroll Id will be cleared.")
				This.SetItem( 1 , 'entity_payrollid','' )
			end if
	
		End If
	END IF

END IF

Return ll_Return 
end event

type tv_1 from u_tvs within w_tv_amounttemplates
event ue_changeselection ( integer ai_dwlevel )
event type integer ue_deleteemployee ( )
integer x = 5
integer y = 24
integer width = 1042
integer height = 2008
integer taborder = 10
fontcharset fontcharset = ansi!
long backcolor = 1090519039
boolean linesatroot = true
string picturename[] = {"Globals!","Custom076!","Library5!"}
end type

event type integer ue_deleteemployee();String 	ls_findString 
Long 		ll_row
Long		ll_Division

integer	li_Return = 1
treeviewitem ltvi_item

n_cst_PrivsManager	lnv_privsManager
// find id in ds
// delete row in ds
// update 
// delete the tree item

//Check divisional permissions for modifying employee settlements
ll_Row = dw_1.GetRow()
IF ll_Row > 0 THEN
	ll_Division = dw_1.GetItemNumber(ll_Row, "entity_division")
	lnv_privsManager = gnv_App.of_GetPrivsManager()
	IF lnv_PrivsManager.of_GetUserPermissionFromFn(lnv_PrivsManager.cs_ModifyEmployeePayable, ll_Division) <> 1 THEN
		li_Return = -1 //Do not allow delete
		MessageBox("Delete Employee", "You are not authorized to modify employee payables for this division.", Exclamation!)
	END IF
END IF

IF li_Return = 1 THEN
	IF tv_1.GetItem(il_selecteditemhandle, ltvi_item) <> 1 THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN
	IF NOT IsNumber ( String ( ltvi_item.Data ) ) THEN  // without first casting to a string i was getting
		li_Return = -1												// a "can't convert any to string" error.
	END IF
END IF
	
IF li_Return = 1 THEN
	ii_id = ltvi_item.Data
	IF messagebox("Please Confirm","OK to permanently delete employee: "+ltvi_item.label + " from the payables setup? ~r~n*** This will delete all historical payable records as well as any unassigned amounts",Question!, YesNo!, 2) <> 1 THEN
		li_Return = 0
	END IF			
END IF

IF li_Return = 1 THEN
	ls_findString = "entity_id = "+ String(ii_id)
	ll_row = idsa_data[ii_Employee_ds].Find( ls_findstring, 1, idsa_data[ii_Employee_ds].RowCount())
	If ll_row <= 0 Then 
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN				
	If idsa_data[ii_Employee_ds].DeleteRow(ll_row) <> 1 Then 
		li_Return = -1 
	END IF
END IF

IF li_Return = 1 THEN
	If idsa_data[ii_Employee_ds].Update(True,True) = 1 Then 
	//	parent.wf_reloademployee( )
		dw_1.Reset()
		dw_2.Reset()
		dw_3.Reset()
		li_Return = 1
		tv_1.DeleteItem ( il_selecteditemhandle )
	Else
		li_Return = -1
	End If
End If

RETURN li_Return
end event

event constructor;call super::constructor;of_setbase(true)
of_setlevelsource(true)
of_setprint(true)
of_setupdateable(true)

ib_rmbmenu=TRUE


end event

event endlabeledit;call super::endlabeledit;//event pfc_save()

this.event pfc_RefreshItem(handle)
end event

event selectionchanged;Long				ll_ParentHandle	

treeviewitem	ltvi_new

SetPointer(HourGlass!)

CHOOSE CASE newhandle
	CASE 1
		this.ExpandItem ( newhandle )
		is_Task = "T"
		If ib_LoadGlobals then 
			wf_LoadGlobalTree(newhandle)
			//this.ExpandItem ( newhandle )
			ib_LoadGlobals = FALSE
		End If
	CASE 2
		this.ExpandItem ( newhandle )
		is_Task = "C"
		If ib_LoadCompanies then 
			wf_LoadCompanyTree(newhandle)
			this.ExpandItem ( newhandle )
			ib_LoadCompanies = FALSE
		End If
	CASE 3
		this.ExpandItem ( newhandle )
		is_Task = "E"
		If ib_LoadEmployees then 
			wf_LoadEmployeeTree(newhandle)
			this.ExpandItem ( newhandle )
			ib_LoadEmployees = FALSE
		End If
END CHOOSE

IF NewHandle > 3 Then  
	// Find the parent to figure out which dw's to load
	ll_ParentHandle = tv_1.FindItem(ParentTreeItem!, tv_1.FindItem(CurrentTreeItem!, 0))
	
	CHOOSE CASE ll_ParentHandle
		Case -1 
			// do nothing You are at the top.	
			
		CASE 1
			// get data from current item
			this.GetItem ( newhandle, ltvi_new)
			ii_ID = ltvi_new.Data
			is_Task = "T"
			wf_ShowTemplate( )
		CASE 2
			// get data from current item
			this.GetItem ( newhandle, ltvi_new)
			ii_ID = ltvi_new.Data
			is_Task = "C"
			wf_ShowEntity( )
		CASE 3
			// get data from current item
			this.GetItem ( newhandle, ltvi_new)
			ii_ID = ltvi_new.Data
			is_Task = "E"
			wf_ShowEntity( )
		Case else
			MessageBox("Program Error","Parent not found in tv_1.Selectionchanged event")	
	END CHOOSE

END IF

end event

event selectionchanging;
long ll_return, &
	  ll_msg, &
	  ll_result

SetPointer(HourGlass!)

ll_Return = 0 
ll_Result = Parent.Trigger Event ue_Save()
If ll_Result = -1 Then 
	ll_Return = 1
Else
	il_selecteditemhandle = newhandle
End IF

Return ll_Return

end event

event rightclicked;// OverRide Ancestor
String	lsa_parm_labels[]
Any		laa_parm_values[]
Long		ll_RootHandle
Int		li_Return = 1
String	ls_PopRtn

TreeViewItem ltvi_Root

IF li_Return = 1 THEN
	ll_RootHandle = this.finditem(ParentTreeItem!, handle)
END IF

IF li_Return = 1 THEN
	IF ll_RootHandle = -1 THEN
		ll_RootHandle = handle
	END IF

	IF tv_1.GetItem ( ll_RootHandle, ltvi_Root ) <> 1 THEN
		li_Return = -1 
	END IF
	
END IF

IF li_Return = 1 THEN
		
	lsa_parm_labels[1] = "ADD_ITEM"
	laa_parm_values[1] = "Add"
	
	CHOOSE CASE String ( ltvi_Root.data )
			
		CASE "G" 
			lsa_parm_labels[2] = "ADD_ITEM"
			laa_parm_values[2] = "Delete"
			
			lsa_parm_labels[3] = "ADD_ITEM"
			laa_parm_values[3] = "-"
			
			lsa_parm_labels[4] = "ADD_ITEM"
			laa_parm_values[4] = "Refresh"
		
			
		CASE "E" 
			lsa_parm_labels[2] = "ADD_ITEM"
			laa_parm_values[2] = "Delete"
			
	
	END CHOOSE
	
END IF



IF li_Return = 1 THEN
	ls_PopRtn = f_pop_standard(lsa_parm_labels, laa_parm_values)
	
	Choose Case ls_PopRtn
			
		Case "ADD" 
			THIS.Event pfc_NewItem ( )
			
		Case "DELETE" 
			THIS.Event pfc_DeleteItem ( )
			
		CASE "REFRESH"
			IF Parent.Event ue_Save ( ) = 1 THEN
				dw_1.Reset ( )
				PARENT.Post wf_ReloadGlobal ( )			
				// all of the reloads seem to have a problem I dont have time to fix them now. but when you reload the index gets all
				// messed up
				
			END IF
			
	End Choose
END IF

RETURN li_Return
end event

event pfc_newitem;call super::pfc_newitem;//String 	ls_Entity
//String	ls_Search = ""
//String	ls_type
//String	ls_MessageHeader
//String 	ls_Empty = ""
//String 	ls_fn
//String 	ls_ln
//long		ll_EntityID
//Long		ll_ValidateId = 0
//Long		ll_Row
//Long		ll_NextId
//Boolean	lb_AllowCreate = TRUE
//Boolean	lb_createquery = TRUE
//Constant Boolean	lb_AllowHold = TRUE
//Constant Boolean	lb_Notify = FALSE
//Boolean	lb_Search = false
//Boolean  lb_Employee 
//Boolean	lb_Company
//Boolean	lb_validate
integer	li_Return = -1

//
s_co_Info					lstr_Company
treeviewitem 				ltvi_Item
n_cst_EmployeeManager	lnv_EmpManager

Choose Case is_Task
	Case "T"
//		IF dw_1.DataObject <> "amounttemplateglobalone" THEN
//			wf_ShowTemplate ( )
//		END IF
//			
//		// reset the dw's and insert a row.
//		dw_1.Reset()
//		dw_2.Reset()
//		dw_3.Reset()
//		
//		dw_1.SetRow(dw_1.InsertRow(0))
//		SetFocus(dw_1)
//		IF  gnv_app.of_getNextID ( "n_cst_beo_amountTemplate" , ll_NextID , TRUE /*commit*/ ) = 1 THEN
//			ll_row = dw_1.getrow()	            
//			IF ll_Row > 0 AND Lower ( dw_1.DataObject ) = "d_amounttemplateglobalone" THEN
//				dw_1.SetItem(ll_Row,"amounttemplate_id",ll_NextID )
//				dw_1.SetItem(ll_Row,"amounttemplate_category",n_cst_constants.ci_category_payables )
//				li_Return = 1
//			END IF
//		END IF
		IF PARENT.wf_NewTemplate ( ) = 1 THEN
			li_Return = 1
		END IF
			
	
	Case "C"
		
		IF PARENT.wf_NewCompany ( ) = 1 THEN
			li_Return = 1
		END IF
		
//		IF Len ( ls_Entity ) > 0 THEN
//			lb_Search = TRUE
//			ls_Search = ls_Entity
//		END IF
//		
//		li_Return = gnv_cst_Companies.of_Select &
//			( lstr_Company, ls_Type, lb_Search, ls_Search, lb_Validate, &
//			  ll_ValidateId, lb_AllowHold, lb_Notify )
//			  
//		gnv_cst_Companies.of_GetEntity (lstr_Company.co_id, ll_EntityId, &
//			TRUE /*AllowCreate*/, TRUE /*AskToCreate*/ , FALSE /*OpenSetup*/ )
//			
//		IF ll_EntityID > 0 THEN
//			
//			ii_ID = ll_EntityID
//			// Check for an existing row in the datastore. 
//			ls_Search = "entity_id =" + String(ll_EntityID)
//			ll_Row = idsa_data[ii_company_ds].Find(ls_Search,0,idsa_data[ii_company_ds].RowCount())
//			
//			If ll_row = 0 Then 
//			// row not found so add to tree and scroll to new item.
//				SELECT C.co_name
//				INTO   :ls_fn
//				FROM   entity as E, companies as C
//				WHERE  (E.fkcompany = C.co_id ) and (( E.id = :ii_id) )  ;
//				
//				If SQLCA.SQLCode = 0 Then 
//					ltvi_item.label=ls_fn
//					ltvi_item.Data=ii_id
//					tv_1.SelectItem ( tv_1.InsertItemLast(2,ltvi_item))
//					SetFocus(dw_1)
//				End If
//				
//				Commit;
//				
//			Else
//				MessageBox("Duplicate Company","Duplicate found. Please review the list.")
//			End If
//		END IF

	Case "E"
		
		IF Parent.wf_NewEmployee ( ) = 1 THEN
			li_Return = 1
		END IF
		
//		lnv_EmpManager.of_getentitybyentry ( ls_Empty, ll_EntityID, lb_allowcreate, lb_createquery )
//		
//		IF ll_EntityID > 0 THEN
//			// Check for an existing row in the datastore. 
//			ls_Search = "entity_id =" + String(ll_EntityID)
//			
//			ll_Row = idsa_data[ii_employee_ds].Find( ls_Search, 0, idsa_data[ ii_employee_ds ].RowCount() )
//			If ll_row = 0 Then 
//				ii_id = ll_EntityId
//				// add to tree and scroll to new item.
//				SELECT E.em_fn, E.em_ln
//				INTO   :ls_fn, :ls_ln
//				FROM   entity as N, employees as E
//				WHERE  (E.em_id = N.fkemployee ) and ( ( N.id = :ii_Id ) );
//		
//				If SQLCA.SQLCode = 0 Then 
//					ltvi_item.label=ls_ln+", "+ls_fn
//					ltvi_item.Data=ii_id
//					tv_1.SelectItem ( tv_1.InsertItemLast(3,ltvi_item))
//					SetFocus(dw_1)
//				End If
//			
//				commit;
//			
//			Else
//				MessageBox("Duplicate Employee","Duplicate found. Please review the list.")
//			End If
//		END IF
//		
End Choose



Return li_return
end event

event pfc_deleteitem;// Ancestor Override 

String 	ls_findString 
Long 		ll_row

integer	li_Return = 1
treeviewitem ltvi_item

n_cst_PrivsManager	lnv_PrivsManager

Choose Case is_Task
	Case "T"

		lnv_privsManager = gnv_App.of_GetPrivsManager()

		IF lnv_PrivsManager.of_GetUserpermissionfromfn(lnv_PrivsManager.cs_ModifyGlobalPayable) <> 1 THEN
			li_Return = -1
			MessageBox("Delete Template", "You are not authorized to modify global settlement templates.", Exclamation!)
		END IF
		// get id from tv selected item.
		// find id in ds
		// delete row in ds
		// update 
		// delete the tree item
		IF li_Return = 1 THEN
			IF tv_1.GetItem(il_selecteditemhandle, ltvi_item) <> 1 THEN
				li_Return = -1
			END IF
		END IF
		
		IF li_Return = 1 THEN
			IF NOT IsNumber ( String ( ltvi_item.Data ) ) THEN  // without first casting to a string i was getting
				li_Return = -1												// a "can't convert any to string" error.
			END IF
		END IF
			
		IF li_Return = 1 THEN
			ii_id = ltvi_item.Data
			IF messagebox("Please Confirm","OK to Permanently Delete Template: "+ltvi_item.label,Question!, YesNo!, 2) <> 1 THEN
				li_Return = 0
			END IF			
		END IF
		
		IF li_Return = 1 THEN
			ls_findString = "amounttemplate_id = "+ String(ii_id)
			ll_row = idsa_data[ii_template_ds].Find( ls_findstring, 1, idsa_data[ii_template_ds].RowCount())
			If ll_row <= 0 Then 
				li_Return = -1 
			END IF
		END IF
		
		IF li_Return = 1 THEN				
			If idsa_data[ii_template_ds].DeleteRow(ll_row) <> 1 Then 
				li_Return = -1 
			END IF
		END IF
		
		IF li_Return = 1 THEN
			If idsa_data[ii_template_ds].Update(True,True) = 1 Then 
				//parent.wf_reloadglobal() replacing with
				tv_1.DeleteItem ( il_selecteditemhandle )
				
				dw_1.Reset()
				dw_2.Reset()
				dw_3.Reset()
				li_Return = 1
			Else
				li_Return = -1
			End If
		End If
		
	Case "C"

		li_Return = 0
		
	Case "E"
		IF THIS.event ue_deleteemployee( ) = 1 THEN
			li_Return = 1
		ELSE 
			li_Return = -1
		END IF

	
End Choose

Return li_Return


end event

type dw_3 from u_dw within w_tv_amounttemplates
event ue_setenable ( boolean ab_enable )
integer x = 2322
integer y = 444
integer width = 1152
integer height = 672
integer taborder = 40
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_setenable(boolean ab_enable);This.Enabled = ab_Enable

IF ab_Enable THEN
	This.Object.DataWindow.Color = rgb(255,255,255)
ELSE
	This.Object.DataWindow.Color = rgb(128,128,128)
END IF
end event

event getfocus;call super::getfocus;tv_1.Post Event ue_changeselection(3)

end event

event doubleclicked;Choose case is_Task
	Case "T"
		parent.wf_LinkEntity()
	Case "E", "C"
		parent.wf_LinkTemplate()
End Choose

end event

event rbuttondown;call super::rbuttondown;
String	lsa_parm_labels[]
Any		laa_parm_values[]

lsa_parm_labels[1] = "ADD_ITEM"
laa_parm_values[1] = "Link Selected"

lsa_parm_labels[2] = "ADD_ITEM"
laa_parm_values[2] = "-"

lsa_parm_labels[3] = "ADD_ITEM"
laa_parm_values[3] = "Link All"
Choose Case f_pop_standard(lsa_parm_labels, laa_parm_values)
	Case "LINK ALL" 
		If MessageBox("Please Confirm","This will Link all items. ~nAre you Sure?",Exclamation!, yesno!,2) = 1 Then
			this.selectrow(0,true)
			this.TriggerEvent(doubleclicked!)
		End if
	Case "LINK SELECTED" 
		this.TriggerEvent(doubleclicked!)
End Choose

end event

event pfc_retrieve;call super::pfc_retrieve;long 	ll_rowcount, &
	  	ll_return
String ls_title

If is_Task <> "T" then
	ls_title = "UnLinked Global Templates: "
Else
	ls_title = "UnLinked Entities: "
End IF
  
ll_rowcount = this.retrieve(ii_id)
st_unlinked.Text= ls_title +String(ll_rowcount,"###,###,###")

return ll_return
end event

type dw_4 from u_dw within w_tv_amounttemplates
event ue_setenable ( boolean ab_enable )
integer x = 1088
integer y = 1180
integer width = 2386
integer height = 644
integer taborder = 50
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_setenable(boolean ab_enable);This.Enabled = ab_Enable

IF ab_Enable THEN
	This.Object.DataWindow.Color = rgb(255,255,255)
ELSE
	This.Object.DataWindow.Color = rgb(128,128,128)
END IF
end event

event pfc_retrieve;call super::pfc_retrieve;
return this.retrieve(ii_id)


end event

event pfc_addrow;call super::pfc_addrow;
return wf_setnewentitytemplate(ancestorreturnvalue)
end event

event pfc_insertrow;call super::pfc_insertrow;
return wf_setnewentitytemplate(ancestorreturnvalue)
end event

event itemchanged;call super::itemchanged;// force Ref1TypeId Ref2TypeId Ref3TypeId values to null if = 0
Long 		ll_null, ll_return
String	ls_Null

ll_return = ancestorreturnvalue
SetNull(ls_Null)
Setnull(ll_Null)

Choose Case dwo.name
		
	Case "ref1typeid", "ref2typeid", "ref3typeid", "ratetypeid", &
		  "amounttemplate_ref1typeid", "amounttemplate_ref2typeid", "amounttemplate_ref3typeid","amounttemplate_ratetypeid"
		
		
		IF Data   = "0" THEN 
			this.SetItem( row , String ( dwo.name ) ,ll_Null)
			ll_Return = 2
		END IF
		
		
	Case "amounttemplate_division"
		
			IF Data = "0" THEN
				SetNull ( ll_Null )
				dwo.Primary [ Row ] = ll_Null
				parent.wf_setdivision( ll_Null )			
				ll_Return = 2
			END IF
			
		
	Case "amounttemplate_aggregatecalc"
				
		IF Data = "0" THEN 
			this.SetItem( row , "amounttemplate_splitsby" ,ls_Null)
		END IF
		
	Case "amounttemplate_quantity", "amounttemplate_rate", "amounttemplate_amount", "amounttemplate_generationcondition"
			//0 = Valid, -1 = Empty or Null Expression, 1 = Invalid or Error
			IF parent.wf_validateexpression("NUMERIC", data ) = 1 THEN
				ll_Return = 1
			END IF				
		
	Case "amounttemplate_selectionfilter"
			IF parent.wf_validateexpression("CHAR", data ) = 1 THEN
				ll_Return = 1
			END IF				
				
End Choose


Return ll_Return
end event

event itemerror;call super::itemerror;// 1 = Reject the data value with no message box

Long	ll_Return

ll_Return = AncestorReturnValue
CHOOSE CASE dwo.name 
	CASE "amounttemplate_quantity", "amounttemplate_rate", "amounttemplate_amount", &
		"amounttemplate_generationcondition", "amounttemplate_selectionfilter"
		ll_Return = 1  // message should be provided by method called in item changed
	END CHOOSE

RETURN ll_Return

end event

event constructor;//This.of_SetSort(TRUE)
This.of_SetAutoSort ( TRUE )
end event

type mle_datalist from u_mle within w_tv_amounttemplates
integer x = 2322
integer y = 1896
integer width = 1152
integer height = 140
integer taborder = 70
boolean bringtotop = true
string text = "TotalMiles , LoadedMiles , EmptyMiles , BobtailMiles , DeadheadMiles , TotalWeight , Shipments , Events , Hooks , Drops , Mounts , Dismounts , Pickups , Deliveries , Stops , WorkingStops , FreightRevenue , StartDate , EndDate , ItineraryHours"
boolean vscrollbar = true
end type

type st_2 from u_st_label within w_tv_amounttemplates
integer x = 2322
integer y = 1840
integer width = 1152
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
long textcolor = 0
long backcolor = 67108864
string text = "Data for Amount Template Expressions"
end type

type st_1 from statictext within w_tv_amounttemplates
integer x = 1088
integer y = 1840
integer width = 1152
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Data for Selection Filter Expression"
boolean focusrectangle = false
end type

type mle_filterlist from multilineedit within w_tv_amounttemplates
integer x = 1088
integer y = 1896
integer width = 1152
integer height = 140
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "OriginId , OriginRef , OriginCity , OriginState , DestinationId , DestinationRef , DestinationCity , DestinationState , EventSequence , ShipmentType , Pickup  Deliver , NewTrip , EndTrip , Hook , Drop , Mount , Dismount , Bobtail , DeadHead"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_linked from statictext within w_tv_amounttemplates
integer x = 1088
integer y = 388
integer width = 1152
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_unlinked from statictext within w_tv_amounttemplates
integer x = 2322
integer y = 388
integer width = 1152
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_entitytemplates from statictext within w_tv_amounttemplates
integer x = 1088
integer y = 1124
integer width = 430
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Entity Templates"
boolean focusrectangle = false
end type

type st_linkupdates from statictext within w_tv_amounttemplates
integer x = 1947
integer y = 332
integer width = 800
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Links updates are immediate"
boolean focusrectangle = false
end type

type dw_2 from u_dw within w_tv_amounttemplates
event ue_setenable ( boolean ab_enable )
integer x = 1088
integer y = 444
integer width = 1152
integer height = 672
integer taborder = 30
boolean bringtotop = true
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_setenable(boolean ab_enable);This.Enabled = ab_Enable

IF ab_Enable THEN
	This.Object.DataWindow.Color = rgb(255,255,255)
ELSE
	This.Object.DataWindow.Color = rgb(128,128,128)
END IF
end event

event getfocus;call super::getfocus;tv_1.Post Event ue_changeselection(2)

end event

event doubleclicked;Choose case is_Task
	Case "T"
		parent.wf_UnlinkEntity()
	Case "E", "C"
		parent.wf_UnlinkTemplate()
End Choose

end event

event rbuttondown;call super::rbuttondown;
String	lsa_parm_labels[]
Any		laa_parm_values[]

lsa_parm_labels[1] = "ADD_ITEM"
laa_parm_values[1] = "Unlink Selected"

lsa_parm_labels[2] = "ADD_ITEM"
laa_parm_values[2] = "-"

lsa_parm_labels[3] = "ADD_ITEM"
laa_parm_values[3] = "Unlink All"

Choose Case f_pop_standard(lsa_parm_labels, laa_parm_values)
	Case "UNLINK SELECTED" 
		this.TriggerEvent(doubleclicked!)
	Case "UNLINK ALL" 
		If MessageBox("Please Confirm","This will unlink all items. ~nAre you Sure?",Exclamation!, yesno!,2) = 1 Then
			this.selectrow(0,true)
			this.TriggerEvent(doubleclicked!)
		End if
End Choose
		


end event

event pfc_retrieve;call super::pfc_retrieve;long 	ll_rowcount, &
	  	ll_return
String ls_title

If is_Task <> "T" then
	ls_title = "Linked Global Templates: "
Else
	ls_title = "Linked Entities: "
End IF

ll_rowcount = this.retrieve(ii_id)
st_linked.Text=ls_title+String(ll_rowcount,"###,###,###")

return ll_return

end event

