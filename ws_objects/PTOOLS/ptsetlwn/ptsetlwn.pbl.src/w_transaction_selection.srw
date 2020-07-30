$PBExportHeader$w_transaction_selection.srw
forward
global type w_transaction_selection from w_response
end type
type cb_1 from u_cbok within w_transaction_selection
end type
type cb_2 from u_cbcancel within w_transaction_selection
end type
type cb_3 from u_cb within w_transaction_selection
end type
type dw_selection from u_dw_transaction_selection within w_transaction_selection
end type
end forward

global type w_transaction_selection from w_response
integer x = 933
integer y = 688
integer width = 1787
integer height = 1272
string title = "Transaction Selection"
long backcolor = 12632256
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_selection dw_selection
end type
global w_transaction_selection w_transaction_selection

type variables
s_co_info	istr_Company
s_transaction_selection istr_selection
end variables

forward prototypes
public function integer wf_populatewindow (n_cst_msg anv_msg)
public function integer wf_validateemployee (ref string as_entity, ref long al_entityid)
public function integer wf_validatecompany (ref string as_entity, ref long al_entityid)
protected function integer wf_employeelist (ref string as_name, ref long al_id)
protected function integer wf_companylist (ref s_co_info astr_company, string as_entity)
protected function integer wf_getcompanyentityid (long al_companyid, ref long al_entityid)
end prototypes

public function integer wf_populatewindow (n_cst_msg anv_msg);String	ls_Ids
String	ls_Status
String	ls_EntityName
String	ls_EntityType
String	ls_Unbatched
String	ls_BatchNumber
Date		ld_StartDate
Date		ld_EndDate

n_cst_msg	lnv_Msg
s_parm		lstr_Parm

lnv_msg = anv_msg

IF lnv_Msg.of_Get_Parm( "S_TRANSACTION_SELECTION", lstr_Parm ) <> 0 THEN
	istr_Selection = lstr_parm.ia_Value


	IF dw_selection.RowCount () = 1 THEN
		
		IF Not IsNull ( istr_Selection.s_Transactionids ) THEN
			dw_selection.object.ref_code[1] =  istr_Selection.s_Transactionids
		ELSEIF Not IsNull ( istr_Selection.s_BatchNumber ) THEN
			dw_selection.object.BatchNumber[1] = istr_Selection.s_BatchNumber
		END IF
		
		
		IF (( ISNull ( istr_Selection.s_Transactionids ) OR Len ( istr_Selection.s_Transactionids ) = 0 ) &
			AND ( ISNull(istr_Selection.s_BatchNumber ) OR Len ( istr_Selection.s_BatchNumber ) = 0 ) )THEN
			
			IF istr_Selection.i_status = 1 THEN
				ls_Status = "Y"
			ELSE
				ls_Status = "N"
			END IF
			
			//IF ls_Status = "N" THEN		
				ls_Unbatched = istr_Selection.s_unbatched
			//END IF
			
			
			dw_selection.object.Status[1]   = ls_Status
			dw_selection.object.Unbatched[1]= ls_UnBatched
			dw_selection.object.Entity[1]   = istr_Selection.s_EntityName
			dw_selection.object.Entity_Type[1] =  istr_Selection.s_EntityType 
			IF ls_Status <> "Y" AND ls_UnBatched <> "Y" THEN
				dw_selection.object.Begin_Date[1] =  istr_Selection.d_StartDate
				dw_selection.object.End_Date[1] =   istr_Selection.d_endDate
			END IF
		
		END IF
	END IF
END IF

RETURN 1
end function

public function integer wf_validateemployee (ref string as_entity, ref long al_entityid);/*

Updates  -------
	<<*>> 7/25/00 change to call of GetEntityByEntry() to open payables_setup window when 
					  entity is set up to handle transactions. RPZ

*/

Constant Boolean	lb_AllowCreate = TRUE
Constant Boolean	lb_CreateQuery = TRUE
Constant Boolean	lb_OpenSetup   = TRUE

Boolean  lb_Employee 
Long		ll_EntityId
String	ls_MessageHeader

Int		li_ReturnValue

n_cst_EmployeeManager	lnv_EmployeeManager


CHOOSE CASE lnv_EmployeeManager.of_GetEntityByEntry (as_Entity, ll_EntityId, &
	lb_AllowCreate, lb_CreateQuery, lb_OpenSetup )

	CASE 1  //Entity identified successfully.
		lb_Employee = TRUE
		as_entity = lnv_EmployeeManager.is_LastEmpDisplay
		al_EntityID = ll_EntityId
		
	CASE ELSE
		lb_Employee = FALSE	
END CHOOSE

IF lb_Employee THEN
	li_ReturnValue = 1 
ELSE
	li_ReturnValue = 0
END IF

RETURN li_ReturnValue
end function

public function integer wf_validatecompany (ref string as_entity, ref long al_entityid);//Code is unused.
RETURN -1

//Constant String	ls_Type = "ANY!"
//
//Constant Boolean	lb_Validate = FALSE
//Constant Boolean	lb_AllowCreate = TRUE
//Constant Boolean	lb_CreateQuery = FALSE //true
//
//Constant Boolean	lb_AllowHold = TRUE
//Constant Boolean	lb_Notify = FALSE
//Long		ll_ValidateId = 0
//Boolean	lb_Search = FALSE
//Boolean  lb_Employee 
//Boolean	lb_Company
//String	ls_Search = ""
//Long		ll_EntityId
//String	ls_MessageHeader
//
//Int		li_ReturnValue = 0
//
//
//n_cst_bso_TransactionManager	lnv_TransactionManager
//
//
//s_co_info	lstr_Company
//
//n_cst_EmployeeManager	lnv_EmployeeManager
//
//IF Len ( as_Entity ) > 0 THEN
//
//	lb_Search = TRUE
//	ls_Search = as_Entity
//
//END IF
//
//
//CHOOSE CASE gnv_cst_Companies.of_Select ( lstr_Company, ls_Type, lb_Search, ls_Search, lb_Validate, ll_ValidateId, &
//	lb_AllowHold, lb_Notify )
//
//CASE 1
//
//	lnv_TransactionManager = CREATE n_cst_bso_TransactionManager
//
//	CHOOSE CASE lnv_TransactionManager.of_GetCompanyEntity ( lstr_Company.co_id, ll_EntityId )
//
//	CASE 1
//		//Entity identified successfully.  Proceed.
//		li_ReturnValue = 1
//
//	CASE 0
//
//		IF MessageBox ( ls_MessageHeader, "The company you have indicated is not currently set up "+&
//			"to handle transactions.  Do you want to perform the setup now?", Question!, YesNo!, 1 ) = 1 THEN
//
//			CHOOSE CASE lnv_TransactionManager.of_MakeCompanyEntity ( lstr_Company.co_Id, ll_EntityId )
//
//			CASE -1  //Failed
//				MessageBox ( ls_MessageHeader, "Could not perform setup.  Request cancelled.", Exclamation! )
//				
//			CASE ELSE
//				li_ReturnValue = 1
//				//Entity was created successfully (or already exists.)  Proceed.
//
//			END CHOOSE
//
//		END IF
//
//	CASE ELSE  //-1
//
//		MessageBox ( ls_MessageHeader, "Could not process request.  Request cancelled.", Exclamation! )
//		
//	END CHOOSE
//
//END CHOOSE
//
//IF isValid ( lnv_TransactionManager ) THEN
//	DESTROY lnv_TransactionManager
//END IF
//
//IF li_ReturnValue = 1 THEN
//	as_Entity = lstr_Company.co_Name
//	al_EntityID = ll_EntityID
//END IF
//
//RETURN li_ReturnValue
end function

protected function integer wf_employeelist (ref string as_name, ref long al_id);integer li_Return
s_emp_info find_ems

//	find_ems.em_type = 2
//	find_ems.em_status = "K"

openwithparm(w_emp_list, find_ems)
find_ems = message.powerobjectparm
if find_ems.em_id > 0 then
//		force_change = true
	as_name = find_ems.em_fn + " " + find_ems.em_ln
	al_id = find_ems.em_id

else
	setnull(as_name)
	setnull(al_id)
	li_Return = -1

end if
//

Return li_Return

end function

protected function integer wf_companylist (ref s_co_info astr_company, string as_entity);Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
integer	li_Return

IF Len ( as_Entity ) > 0 THEN

	lb_Search = TRUE
	ls_Search = as_Entity

END IF

li_Return = gnv_cst_Companies.of_Select &
	( astr_company, ls_Type, lb_Search, ls_Search, lb_Validate, &
	  ll_ValidateId, lb_AllowHold, lb_Notify )
 
return li_Return
end function

protected function integer wf_getcompanyentityid (long al_companyid, ref long al_entityid);/*

Updates  -------
	<<*>> 7/25/00 change to call of GetEntity() to open payables_setup window when entity is 
					  set up to handle transactions. RPZ

*/



Integer	li_Return = -1
Long		ll_EntityId
String	ls_MessageHeader = "Select Company"


CHOOSE CASE gnv_cst_Companies.of_GetEntity (al_CompanyId, ll_EntityId, &
	TRUE /*AllowCreate*/, TRUE /*AskToCreate*/ , TRUE /*OpenSetup*/ )

CASE 1
	//Entity identified successfully.  Proceed.
	li_Return = 1

CASE 0

	//Not found (and user chose not to create.)

CASE ELSE  //-1

	//Error

	MessageBox ( ls_MessageHeader, "Could not process request.  Request cancelled.", Exclamation! )
	
END CHOOSE


IF li_Return = 1 THEN
	al_EntityID = ll_EntityID
END IF

return li_Return
end function

on w_transaction_selection.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_selection=create dw_selection
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.dw_selection
end on

on w_transaction_selection.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_selection)
end on

event open;call super::open;// GET THE STRUCT AND POPULATE STUFF
n_cst_msg	lnv_msg

lnv_msg = message.powerobjectparm

ib_disableclosequery = TRUE

IF dw_selection.insertRow (0) <> 1 THEN
	MessageBox( "Transaction Selection" , "An error occurred while attempting to open the transaction selection window." )
	Close ( THIS )
END IF


IF gnv_app.of_GetPrivsmanager( ).of_Useadvancedprivs( ) THEN
	MessageBox( "Transaction Selection" , "You are not authorized to access transactions this way. Use the Settlement Batch Manager instead." )
	Close ( THIS )
	RETURN
END IF

IF isValid (lnv_Msg ) THEN
	THIS.wf_PopulateWindow ( lnv_Msg )
END IF

dw_selection.setColumn ( "entity" )
dw_selection.setFocus ( )

end event

event pfc_default;// load structure
String 	ls_Status
String	ls_IDs
String	ls_EntityName
String	ls_EntityType
String	lsa_Result[]
String	ls_Unbatched
String	ls_BatchNumber
String	ls_ErrorMessage = "An Error occurred while attempting to process selection"

Int		li_MboxRtn
Int		i,j
Int		li_EntityValidation
Int		li_Status
iNT	   li_Return

Long		lla_Ids[]
Long		ll_DaysAfter
Long		ll_EntityID

Date 		ld_StartDate
Date 		ld_EndDate
Boolean  lb_HaveData = FALSE
Boolean  lb_Error
Boolean	lb_Close 
Boolean 	lb_LookupCompany
Boolean	lb_GetEntityID

n_cst_String	lnv_String
n_cst_Msg		lnv_Msg
S_Parm			lstr_parm

SetPointer ( HOURGLASS! )
SetNull ( ll_EntityID )

IF dw_selection.AcceptText ( ) = 1 THEN
	
ELSE
	lb_Error = TRUE
END IF

ls_Ids       = dw_selection.object.ref_code[1]
ls_Status    = Upper ( dw_selection.object.Status[1] ) 
ls_EntityName =  dw_selection.object.Entity[1]
ls_EntityType =  dw_selection.object.Entity_Type[1]
ld_StartDate = dw_selection.object.begin_date[1]
ld_EndDate   = dw_selection.object.End_date[1]
ls_Unbatched = Upper ( dw_selection.object.Unbatched[1] )
ls_BatchNumber = Trim (dw_selection.object.BatchNumber[1])

IF ls_EntityName = istr_Selection.s_EntityName then
	lb_LookupCompany = FALSE
ELSE
	lb_LookupCompany = TRUE
END IF

IF istr_Selection.l_EntityID = 0 or isnull( istr_Selection.l_EntityID )THEN
	lb_GetEntityID = TRUE
ELSE
	lb_GetEntityID = FALSE
END IF
IF String (ld_StartDate) = "1/1/00" THEN
	SetNull ( ld_StartDate )
END IF
IF String (ld_EndDate ) = "1/1/00" THEN
	SetNull ( ld_ENDDate )
END IF


IF NOT lb_Error THEN  // validate transaction nums
	IF Len ( ls_Ids ) > 0 AND NOT isNull ( ls_ids ) THEN
		lnv_String.of_ParseToArray ( ls_Ids, "," ,lsa_Result )
		
		For i = 1 To UpperBound ( lsa_Result ) 
			IF isNumber ( lsa_Result [i] ) THEN
				lb_HaveData = TRUE
				j ++ 
				lla_ids[j] = Long ( lsa_Result [i] )
			ELSE
				lb_Error = TRUE 
				ls_ErrorMessage = "An error occurred while attempting to process the entity ids."
				dw_selection.SetColumn ( "ref_code" )
				
			END IF
		NEXT		
	ELSE
		 
	END IF
END IF


IF NOT lb_Error THEN  // validate entity
	// the long boolean expression it to prevent evaluation of the entity name if a transaction or bathc number is specified.		
	if Len ( ls_EntityName ) > 0 and  ( ( Len ( ls_BatchNumber ) = 0 OR IsNull ( ls_Batchnumber ) ) AND ( ISNull (ls_ids ) OR Len ( ls_Ids ) = 0 )  ) THEN
		lb_HaveData = TRUE
		CHOOSE CASE UPPER ( ls_EntityType )
				
			CASE "E"
			
				li_EntityValidation = THIS.wf_ValidateEmployee( ls_EntityName, ll_EntityID ) 
				IF li_EntityValidation <> 1 THEN
					lb_Error = TRUE
					SetNull ( ls_ErrorMessage ) // error message provided by validateEmployee
					dw_selection.SetColumn ( "Entity" )		
				END IF
				
			CASE "C"

				IF lb_LookupCompany THEN		
					li_Return = wf_companylist (istr_company, ls_EntityName )
					IF li_Return = 1 THEN
						lb_GetEntityID = TRUE
					ELSEIF li_Return = 0 THEN
						lb_Error = TRUE
						SetNull ( ls_ErrorMessage )
					END IF
				END IF
				IF Not lb_Error THEN	
					IF lb_GetEntityID THEN
						li_EntityValidation = THIS.wf_GetCompanyEntityID( istr_company.co_id, ll_EntityID ) 
						IF li_EntityValidation <> 1 THEN
							lb_Error = TRUE
							setNull ( ls_ErrorMessage  )
							dw_selection.SetColumn ( "Entity" )
						ELSE
							dw_selection.object.Entity[1] = ls_EntityName
						END IF
					
					ELSE
						 ll_EntityID = istr_Selection.l_EntityID				
					END IF
				END IF
			CASE ELSE
				ls_ErrorMessage = "Please indicate whether the entiy you have entered is a company or an employee." 
				lb_Error = TRUE
				dw_selection.SetColumn ( "Entity_type" )
			
		END CHOOSE
	END IF
END IF


IF NOT lb_Error THEN // get status (open / other )
	CHOOSE CASE ls_Status
		CASE "Y"
			lb_HaveData = TRUE
			li_Status = 1  // open
		CASE ELSE
			li_Status = 0  // other
	END CHOOSE
END IF

IF NOT lb_Error THEN // 
	CHOOSE CASE ls_Unbatched 
		CASE "Y"
			lb_HaveData = TRUE
	END CHOOSE
END IF

IF NOT lb_Error THEN // 
	IF Len ( ls_BatchNumber ) > 0 AND Not IsNull ( ls_BatchNumber) THEN
			lb_HaveData = TRUE
	END IF
END IF


IF Not lb_Error THEN  //validate date 
	IF Not ISNull ( ld_StartDate ) OR NOT isNull (ld_EndDate ) THEN
		lb_HaveData = TRUE
		ll_DaysAfter = DaysAfter ( ld_StartDate , ld_EndDate )
		Choose CASE ll_DaysAfter
			CASE is < 0
				ls_ErrorMessage = "Please enter an ending date later or equal to the starting date."
				lb_Error = TRUE
				dw_selection.SetColumn ( "End_Date" )
			CASE ELSE
				//
				
		END CHOOSE
	END IF
END IF
IF lb_Error THEN
	messageBox ( "ERROR" , ls_ErrorMessage )
	dw_selection.SetFocus (  )
ELSE
	istr_Selection.s_Transactionids = ls_ids
	istr_Selection.la_Transactionids = lla_Ids
	istr_Selection.s_EntityName = ls_EntityName
	istr_Selection.l_EntityID = ll_EntityID
	istr_Selection.s_EntityType = ls_Entitytype
	istr_Selection.d_StartDate = ld_StartDate
	istr_Selection.d_endDate = ld_EndDate
	istr_Selection.i_status = li_Status
	istr_Selection.s_Unbatched = ls_UnBatched
	istr_Selection.s_batchNumber = TRIM ( Upper (ls_BatchNumber) )
	istr_Selection.b_HaveData = lb_HaveData
END IF

IF Not lb_HaveData AND NOT lb_Error THEN
	li_MboxRtn =	MessageBox ("Transaction Selection" , "The selections you have made will retrieve all of"+&
			+" the history. This operation could take a while. Do you want to continue?" ,&
			  QUESTION! , YESNO!, 1 ) 
	
	CHOOSE CASE li_MBoxRtn
		CASE 1 // continue
				lb_Close = TRUE
			
		CASE 2 // bail
			
		CASE ELSE
				lb_Close = TRUE
	END CHOOSE
	
END IF	
IF li_MboxRtn <> 2 AND Not lb_Error THEN
	lb_Close = TRUE
END IF

IF lb_Close THEN
	lstr_Parm.is_Label = "S_TRANSACTION_SELECTION"
	lstr_Parm.ia_Value = istr_Selection
	lnv_Msg.of_Add_Parm ( lstr_Parm ) 
	CloseWithReturn ( THIS, lnv_Msg )

END IF


end event

event pfc_cancel;call super::pfc_cancel;close ( this )
end event

type cb_help from w_response`cb_help within w_transaction_selection
end type

type cb_1 from u_cbok within w_transaction_selection
integer x = 425
integer y = 1044
integer width = 233
integer taborder = 20
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_2 from u_cbcancel within w_transaction_selection
integer x = 1074
integer y = 1044
integer width = 233
integer taborder = 40
boolean bringtotop = true
integer weight = 400
fontcharset fontcharset = ansi!
end type

type cb_3 from u_cb within w_transaction_selection
integer x = 745
integer y = 1044
integer width = 233
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer weight = 400
string text = "&Reset"
end type

event clicked;dw_selection.EVENT ue_Reset( )
end event

type dw_selection from u_dw_transaction_selection within w_transaction_selection
integer x = 9
integer y = 40
integer width = 1728
integer height = 972
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;CHOOSE CASE Upper ( dwo.Name )
			
	CASE "UNBATCHED"
		THIS.object.status[1] = "N"
		
	CASE "STATUS"
		THIS.object.unbatched[1] = "N"
		
		
END CHOOSE

		

end event

event ue_reset;call super::ue_reset;IF ancestorReturnValue <> 1 THEN
	MessageBox("Window Reset" , "An error occurred while resetting the window." ) 
	Close (Parent )
END IF

Return ancestorReturnValue
end event

event buttonclicked;CHOOSE CASE dwo.Name

CASE "list_button"

	CHOOSE CASE this.object.entity_type[row]

	CASE  "E"
		string ls_name 
		long ll_id
		
		wf_employeelist(ls_name,ll_id)
		
		IF not isnull(ls_name) THEN
			this.object.entity[row] = ls_name
		END IF
		
	CASE "C"
	
		string 		ls_entity
		if this.AcceptText() <> -1 then
			ls_Entity =  this.object.entity[row]
		end if
		
		wf_companylist (istr_company, ls_entity )
		
		IF not isnull(istr_Company.co_Name) THEN
			IF isnull ( ls_Entity ) THEN
				ls_Entity = ""
			END IF
			IF ls_Entity <> istr_Company.co_Name THEN
				this.object.entity[row] = istr_Company.co_Name
				istr_Selection.s_entityname = istr_Company.co_Name
				istr_Selection.l_EntityID = 0
			END IF

		END IF
	
	END CHOOSE
	
END CHOOSE
end event

