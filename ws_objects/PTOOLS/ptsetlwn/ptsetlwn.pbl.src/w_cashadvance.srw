$PBExportHeader$w_cashadvance.srw
forward
global type w_cashadvance from w_response
end type
type dw_cashadvance from u_dw_cashadvance within w_cashadvance
end type
type cb_1 from u_cbok within w_cashadvance
end type
type cb_2 from u_cbcancel within w_cashadvance
end type
type st_name from statictext within w_cashadvance
end type
type cb_details from commandbutton within w_cashadvance
end type
end forward

global type w_cashadvance from w_response
integer width = 1897
integer height = 1440
string title = "Cash Advance Information"
long backcolor = 12632256
event ue_details ( )
dw_cashadvance dw_cashadvance
cb_1 cb_1
cb_2 cb_2
st_name st_name
cb_details cb_details
end type
global w_cashadvance w_cashadvance

type variables
n_cst_Msg	inv_msg
Long		il_EntityID
n_cst_beo_AmountType	inv_AmountType
n_cst_bso_transactionManager	inv_TransactionManager
DataStore 	ids_PreviousAdvances
s_co_info	                istr_Company
n_cst_beo_trip	inv_Trip
String		is_Description
String		is_Context
end variables

forward prototypes
public function integer wf_getamounttype (String as_Label, ref n_cst_beo_AmountType an_AmountType)
public function integer wf_setentityname (string as_name)
public function integer wf_checkpreviousadvances ()
public function integer wf_employeelist (ref string as_Name, ref long al_ID)
public function integer wf_companylist (ref s_co_info astr_company, string as_entity)
public function integer wf_setentityid (long al_id)
public function integer wf_getcompanyentityid (long al_CompanyID, ref long al_EntityID)
public function integer wf_validateemployee (ref string as_entity, ref long al_EntityID)
public function integer wf_entitychanged ()
public function integer wf_populatefromtrip ()
public function integer wf_getrefnumtype (String as_Type, ref n_cst_beo_RefNumType anv_RefNum)
public function boolean wf_checkrequiredfields (ref string as_message)
end prototypes

event ue_details;n_cst_msg	lnv_Msg
S_Parm	lstr_Parm

Blob	lblb_State 
ids_PreviousAdvances.GetFullState ( lblb_State )

lstr_Parm.is_Label = "STATE"
lstr_Parm.ia_Value = lblb_State
lnv_Msg.of_Add_Parm ( lstr_Parm ) 

OpenWithParm (w_PreviousAdvances , lnv_Msg )
end event

public function integer wf_getamounttype (String as_Label, ref n_cst_beo_AmountType an_AmountType);n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_amounttype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_Beo = lnv_Cache.getBeo("pos(amounttype_tag, '" + as_Label + "') > 0")
	IF isValid(lnv_Beo) THEN
		li_Return = 1
	END IF

END IF
an_AmountType = lnv_Beo

return li_Return

end function

public function integer wf_setentityname (string as_name);//MessageBox ( "Set Name" , as_Name )

dw_cashadvance.object.Entity [1] = as_Name

//dw_cashadvance.setItem ( 1 , "entity" , as_Name )
//dw_cashadvance.AcceptText ( )
//dw_cashadvance.SetRow ( 1 )
//dw_cashadvance.SetColumn ( "entity" )
//dw_cashadvance.SetText ( as_name )
////dw_cashadvance.AcceptText ( )

RETURN 1
end function

public function integer wf_checkpreviousadvances ();String	ls_Filter
Date ld_Today
Long	ll_Type
Long	ll_SetRtn
Long	ll_Filter
Long	ll_Count
Int	li_Return = 1
ld_Today = Today ( )

If Not IsValid ( ids_PreviousAdvances ) THEN
	ids_PreviousAdvances = CREATE DataStore
	ids_PreviousAdvances.DataObject = "d_amountowedlist"
	ids_PreviousAdvances.SetTransObject( SQLCA )	
END IF

If IsValid ( inv_Amounttype ) THEN
	ll_Type = inv_Amounttype.of_getID ( ) 
END IF

IF ids_PreviousAdvances.Retrieve ( ) < 0 THEN
	li_Return = -1
ELSE
	IF is_Context = "CASHADVANCE" THEN
		ls_Filter = "amountowed_fkentity = " + String ( il_entityid )+"  AND amountowed_type = " + String ( ll_Type ) +" AND amountowed_startdate = date ( " +'"' + String (  ld_Today   ) +'"'+ ")"
	ELSEIF is_Context = "TRIPPAYABLE" THEN
		ls_Filter = "amountowed_fkentity = " + String ( il_entityid )+"  AND amountowed_type = " + String ( ll_Type ) +" AND amountowed_trip = '" + String ( inv_Trip.of_GetID ( ) ) + "'"
	END IF
	
	ll_SetRtn = ids_PreviousAdvances.SetFilter ( ls_Filter )
	ll_Filter = ids_PreviousAdvances.Filter ( )
		
	IF ll_SetRtn <> 1 OR ll_Filter <> 1 THEN
		li_Return = -1
	ELSE
		ll_Count = ids_PreviousAdvances.RowCount( ) 
		//MessageBox ( "DESCRIBE" , ids_PreviousAdvances.describe ( "Evaluate ( 'sum ( amountowed_amount ) for all ' , 1 ) " ) )
		li_Return = ll_Count
		
	END IF
	
END IF


RETURN li_Return


//MessageBox( "Count" , ids_PreviousAdvances.RowCount( ))
	//ls_Filter = "amountowed_fkentity = " + String ( il_entityid ) + "  AND amountowed_type = " + String ( ll_Type ) + " AND amountowed_startdate = " + String (  ld_Today )
	//ls_Filter = "amountowed_startdate = date ( " +'"' + String (  ld_Today   ) +'"'+ ")"
end function

public function integer wf_employeelist (ref string as_Name, ref long al_ID);integer li_Return
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

public function integer wf_companylist (ref s_co_info astr_company, string as_entity);Constant Boolean	lb_AllowHold = TRUE
Constant Boolean	lb_Notify = FALSE
Long		ll_ValidateId = 0
Boolean	lb_Search = false
Boolean  lb_Employee 
Boolean	lb_Company
Boolean	lb_validate
String	ls_Search = ""
String	ls_type
Long		ll_EntityId
String	ls_MessageHeader
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

public function integer wf_setentityid (long al_id);Int	li_Count

il_entityid = al_ID

cb_details.Enabled = TRUE
st_name.Visible = TRUE

li_Count = THIS.wf_CheckPreviousAdvances ( )
IF li_Count <> -1 THEN
	IF is_Context = "CASHADVANCE" THEN
		st_name.Text =  String ( li_Count ) + " advances have been issued today."
	ELSEIF is_Context = "TRIPPAYABLE" THEN
		st_name.Text =  String ( li_Count ) + " payable(s) have been assigned to this trip."
		
	END IF
END IF

RETURN 1
end function

public function integer wf_getcompanyentityid (long al_CompanyID, ref long al_EntityID);/*

Updates  -------

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

public function integer wf_validateemployee (ref string as_entity, ref long al_EntityID);/*

Updates  -------

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

public function integer wf_entitychanged ();MessageBox (  "Entity Changed" , "Now" ) 
wf_SetEntityName (inv_TransactionManager.of_DescribeEntity ( il_EntityID, 0 ) )
Return 1
end function

public function integer wf_populatefromtrip ();String	ls_Carriername 
String 	ls_TripNumber
Long 		ll_CarrierID
Int		li_Return = 1


n_cst_Companies	lnv_Cos

lnv_Cos = CREATE n_cst_Companies


ls_CarrierName = inv_Trip.of_GetCarriername ( )
ll_CarrierID = inv_Trip.of_GetCarrierID ( )
ls_tripNumber = String ( inv_Trip.of_GetID ( ) )
IF lnv_Cos.of_GetEntity ( ll_CarrierID , il_EntityID, TRUE , TRUE  )  <> 1 THEN
	MessageBox ( "Cash Advance" , "The entity selected has not been setup to handle transactions. Request cancelled.")
	li_Return = -1	
ELSE
	
	IF il_EntityID > 0 THEN
		THIS.wf_SetEntityID ( il_EntityID )
	END IF
	THIS.wf_GetAmountType ( "TRIP_PAY" ,  inv_AmountType)
	
	dw_CashAdvance.object.tripnumber[1] = ls_TripNumber
	dw_CashAdvance.object.entity[1] = ls_CarrierName
	dw_cashadvance.object.Entity_Type[1] = "C"
	dw_cashadvance.object.Amount[1] = inv_Trip.of_GetPayablesTotal ( )
	
	
END IF



Destroy lnv_Cos


Return li_Return
end function

public function integer wf_getrefnumtype (String as_Type, ref n_cst_beo_RefNumType anv_RefNum);n_cst_bcm	lnv_Cache
n_cst_beo	lnv_Beo
Integer		li_Return

Constant String	ls_Class = "n_cst_dlkc_refnumtype"
Constant Boolean	lb_CreateNew = TRUE
Constant Boolean	lb_RetrieveNew = TRUE

li_Return = -1

IF gnv_App.inv_CacheManager.of_GetCache ( ls_Class, lnv_Cache, lb_CreateNew, lb_RetrieveNew ) = 1 THEN
	li_Return = 0
	lnv_Beo = lnv_Cache.getBeo("pos(refnumType_Tag, '" + as_Type + "') > 0")
	IF isValid( lnv_Beo ) THEN
		li_Return = 1
	END IF

END IF

anv_RefNum = lnv_Beo
RETURN li_Return
end function

public function boolean wf_checkrequiredfields (ref string as_message);Boolean	lb_Return = TRUE
String 	ls_ErrorMessage 
IF dw_cashadvance.RowCount ( ) = 1 AND dw_CashAdvance.Accepttext ( ) = 1 THEN
		
	IF Len ( Trim ( dw_cashadvance.object.Dispatcher [ 1 ]  ) ) = 0 OR &
			IsNull (dw_cashadvance.object.Dispatcher [ 1 ] ) THEN
		lb_Return = FALSE
		ls_ErrorMessage = "Please enter your name in the Dispatcher field."
		dw_cashadvance.SetRow ( 1 )
		dw_cashadvance.SetColumn ( "Dispatcher" )
		dw_cashadvance.SetFocus ( )

	END IF
	
	IF is_Context <> "TRIPPAYABLE" THEN
		IF Len ( Trim ( dw_cashadvance.object.CheckNumber [ 1 ]  ) ) = 0 OR &
				IsNull (dw_cashadvance.object.CheckNumber [ 1 ] )THEN
			lb_Return = FALSE
			ls_ErrorMessage = "Please enter the check number." 
			dw_cashadvance.SetRow ( 1 )
			dw_cashadvance.SetColumn ( "CheckNumber" )
			dw_cashadvance.SetFocus ( )
		END IF
	END IF
	
	IF  dw_cashadvance.object.Amount [ 1 ]  <= 0 OR &
			IsNull (dw_cashadvance.object.Amount [ 1 ] ) THEN
		lb_Return = FALSE
		ls_ErrorMessage = "Please enter a value greater than 0 in the amount field." 
		dw_cashadvance.SetRow ( 1 )
		dw_cashadvance.SetColumn ( "Amount" )
		dw_cashadvance.SetFocus ( )
	END IF
	
	IF Not il_EntityID > 0 THEN
		lb_Return = False
		ls_ErrorMessage = "Please indicate the entity."
	END IF
	
	IF Len ( ls_ErrorMessage ) > 0 THEN
		as_Message = ls_ErrorMessage
//		MessageBox ( "Required Field" , ls_ErrorMessage )
	END IF
ELSE
	lb_Return = FALSE
END IF

RETURN lb_Return


end function

on w_cashadvance.create
int iCurrent
call super::create
this.dw_cashadvance=create dw_cashadvance
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_name=create st_name
this.cb_details=create cb_details
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cashadvance
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_name
this.Control[iCurrent+5]=this.cb_details
end on

on w_cashadvance.destroy
call super::destroy
destroy(this.dw_cashadvance)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_name)
destroy(this.cb_details)
end on

event open;call super::open;SetPointer ( HOURGLASS! )
Int	li_TypeRtn
Int	li_Count
Int	li_PopulateRtn = 1

S_Parm	lstr_Parm
n_cst_Beo_AmountType	lnv_AmountType
n_cst_Beo_RefNumType		lnv_RefNumType


IF ISValid ( message.powerObjectParm ) THEN
	inv_Msg = message.powerObjectParm 
END IF

dw_cashadvance.insertRow ( 0 )
ib_DisableCloseQuery = TRUE

inv_TransactionManager = CREATE n_cst_bso_TransactionManager
inv_TransactionManager.of_SetDefaultCategory ( n_cst_Constants.ci_Category_Payables )

IF inv_Msg.of_Get_Parm ( "TRIP" , lstr_Parm ) <> 0 THEN
	inv_Trip = lstr_Parm.ia_Value
	is_Context = "TRIPPAYABLE"
	
	IF IsValid (inv_Trip) THEN
		is_Description = "TRIP PAY"
		li_PopulateRtn = wf_PopulateFromTrip ( )
		dw_cashadvance.Object.CheckNumber.Visible = FALSE
		dw_cashadvance.Object.CheckNumber_t.Visible = FALSE
	END IF
		
END IF
IF is_Context <> "TRIPPAYABLE" THEN
	IF THIS.wf_GetRefNumType ( "FUELCARD_TRANSACTIONREF" , lnv_RefNumtype ) <> 1 THEN
		MessageBox( "Cash Advance" , "There is no Reference type specified with the tag 'FUELCARD_TRANSACTIONREF'. You will not be able to save a cash advance until this is done. " )
	END IF
END IF


IF li_populateRtn = 1 THEN
	IF Not isValid ( inv_Trip ) THEN
		
		IF inv_Msg.of_Get_Parm ( "ENTITYID" , lstr_Parm ) <> 0 THEN
			il_EntityID = lstr_Parm.ia_Value
			
			IF inv_Msg.of_Get_Parm ( "ENTITYTYPE" , lstr_Parm ) <> 0 THEN
				dw_cashadvance.object.Entity_Type[1] = lstr_Parm.ia_Value 
			END IF
	
		ELSE
			dw_cashadvance.object.Entity_Type[1] = "E"
			st_name.Visible = FALSE
			cb_details.Enabled = FALSE
		END IF
		
		li_TypeRtn = THIS.wf_GetAmountType ( "CASHADVANCE" ,  lnv_AmountType)
	
		IF li_TypeRtn <> 1 THEN  
			MessageBox ( "Cash Advance" , "There is no AmountType specified with the tag 'CASHADVANCE' for this operation. You will not be able to generate a cash advance until this is done. " )
		ELSE
			inv_AmountType = lnv_AmountType
			is_Description = "CASH ADVANCE"
			is_Context = "CASHADVANCE"
		END IF
		
	END IF
	

	IF il_EntityID > 0 THEN
		THIS.wf_setEntityID ( il_EntityID )
		String ls_Name
		ls_Name =  inv_TransactionManager.of_DescribeEntity ( il_EntityID, 0 ) 
		wf_SetEntityName ( ls_Name )
	END IF 
	// set the default user id 
	
	dw_CashAdvance.object.Dispatcher [ 1 ] = gnv_App.of_GetUserID ( )
ELSE
	Close ( THIS )
END IF
end event

event pfc_cancel;call super::pfc_cancel;close ( THIS )
end event

event pfc_default;Boolean	lb_Continue = TRUE
Dec		ldec_Amount 
Int		li_save_rc
Int		li_EntityValidation
String	ls_CheckNumber
String	ls_UserAccount
String	ls_EntityName
String	ls_TripNumber
String 	ls_ErrorMessage

String	ls_Dispatcher
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_Beo_RefNumType		lnv_RefNumType
n_cst_beo_AmountOwed 	lnv_AmountOwed

IF THIS.wf_GetRefNumType ( "FUELCARD_TRANSACTIONREF" , lnv_RefNumtype ) <> 1 THEN
	lb_Continue = FALSE
//	MessageBox( "Cash Advance" , "Profit Tools could not find the 'FUELCARD_TRANSACTIONREF' reference tag. You will not be able to save your advance." )
ELSE  // continue processing
	lb_Continue = wf_CheckRequiredFields ( ls_ErrorMessage )
END IF

IF IsNull  ( il_EntityID ) THEN
	lb_Continue = FALSE
END IF

IF Not IsValid ( inv_AmountType ) THEN
	lb_Continue = FALSE
END IF


IF IsValid ( inv_TransactionManager ) AND lb_Continue THEN

	inv_TransactionManager.of_SetDefaultEntityID( il_EntityID )
	
	lnv_AmountOwed = inv_TransactionManager.of_NewAmountOwed ( )
	ls_Dispatcher =  dw_cashadvance.object.Dispatcher [ 1 ]
	ls_CheckNumber = dw_Cashadvance.object.checkNumber [ 1 ]
	ls_TripNumber = dw_Cashadvance.object.tripNumber [ 1 ]
	IF IsValid ( lnv_AmountOwed ) THEN
		
		lnv_AmountOwed.of_SetAmount ( dw_cashadvance.object.Amount [ 1 ] )
		lnv_AmountOwed.of_SetType ( inv_AmountType.of_GetID ( ) )
		lnv_AmountOwed.of_SetDescription ( is_Description )
		lnv_AmountOwed.of_SetPublicNote ( dw_cashadvance.object.Comment [ 1 ] )
		lnv_AmountOwed.of_SetStartDate ( Today ( ) )
		lnv_AmountOwed.of_SetInternalNote ( "USER ACCOUNT: " + gnv_App.of_GetUserID ( ) + "/  DISPATCHER: " + ls_Dispatcher )
		lnv_AmountOwed.of_setRef1Text ( ls_CheckNumber )
		lnv_AmountOwed.of_setRef1Type ( lnv_RefNumType.of_GetID ( )  )
		lnv_AmountOwed.of_setTrip ( ls_TripNumber )
	//	lnv_AmountOwed.of_SetDivision ( null_int )
		IF isValid ( inv_Trip ) THEN
			lnv_AmountOwed.of_SetDriver ( inv_Trip.of_GetDriver ( ) )
		END IF
		
		THIS.Event pfc_Save ( )  // error notice provide by save
		
	END IF
	
	
END IF

IF Not lb_Continue THEN
	IF Len ( ls_ErrorMessage ) > 0 THEN
	ELSE 
		ls_ErrorMessage = "The cash advance could not be saved. Make sure the entity selected is set up to take transactions." 
	END IF
	MessageBox ( "Save Advance" , ls_ErrorMessage )
END IF	
end event

event pfc_save;// OVERRIDE ANCESTOR SCRIPT 

Int	li_save_rc
li_save_rc = inv_TransactionManager.Event pt_Save ( )

IF li_save_rc <= 0 THEN
	MessageBox ( "Save Changes", "Could not save changes to database.", Exclamation! )
ELSE
	Post Event pfc_Cancel ( )
				
END IF
RETURN li_save_rc
end event

event close;call super::close;Destroy ids_PreviousAdvances
DESTROY inv_TransactionManager
end event

event pfc_postopen;this.Title = is_Description
end event

type cb_help from w_response`cb_help within w_cashadvance
integer x = 1787
integer y = 1284
end type

type dw_cashadvance from u_dw_cashadvance within w_cashadvance
integer x = 50
integer y = 180
integer width = 1760
integer height = 968
integer taborder = 20
boolean bringtotop = true
end type

event buttonclicked;CHOOSE CASE dwo.Name

CASE "list_button"

	CHOOSE CASE this.object.entity_type[row]

	CASE  "E"
		string ls_name 
		long ll_id
		
		wf_employeelist(ls_name,ll_id)
		
		IF not isnull(ls_name) THEN
			
			//THIS.SetItem ( row , "entity" , ls_Name ) 
			THIS.SetRow ( row )
			THIS.SetColumn ( "entity" )
			THIS.SetText ( ls_Name )
			THIS.AcceptText (  )
			
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
			
				THIS.SetRow ( row )
				THIS.SetColumn ( "entity" )
				THIS.SetText ( istr_Company.co_Name )
				THIS.AcceptText (  )
				
			END IF

		END IF
	
	 
	
	END CHOOSE
	
	
	
END CHOOSE
end event

event itemchanged;call super::itemchanged;Boolean 	lb_Employee
Long		ll_EntityID

CHOOSE CASE dwo.name
		
	CASE "entity"
			
		CHOOSE CASE THIS.object.Entity_Type[row]
			CASE "E" 
				
				lb_Employee = TRUE
				
			CASE "C" 
				lb_Employee = FALSE
				
			CASE ELSE
				SetNull ( lb_Employee )
				
		END CHOOSE
		
		IF Not IsNull ( lb_Employee ) THEN
			IF lb_Employee THEN
				// set the entity id for the employee
				wf_ValidateEmployee( data, ll_EntityID )
						
			ELSEIF Not lb_Employee THEN
				// set the entity id for the Company
				 wf_companylist (istr_company, data )
				 wf_GetCompanyEntityID( istr_company.co_id, ll_EntityID ) 
				 
			END IF
			
			wf_SetEntityID ( ll_EntityID )
			
		END IF
		

END CHOOSE

				
				
end event

event itemfocuschanged;call super::itemfocuschanged;
//CHOOSE CASE dwo.name
//		
//	CASE "entity"
//wf_SetEntityName (inv_TransactionManager.of_DescribeEntity ( il_EntityID, 0 ) )		
//END CHOOSE
end event

type cb_1 from u_cbok within w_cashadvance
integer x = 640
integer y = 1168
integer width = 233
integer taborder = 30
boolean bringtotop = true
string text = "Save"
end type

type cb_2 from u_cbcancel within w_cashadvance
integer x = 1001
integer y = 1168
integer width = 233
integer taborder = 40
boolean bringtotop = true
end type

type st_name from statictext within w_cashadvance
integer x = 73
integer y = 52
integer width = 1385
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_details from commandbutton within w_cashadvance
integer x = 1486
integer y = 52
integer width = 261
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Details"
end type

event clicked;Event ue_Details ( )
end event

