$PBExportHeader$n_cst_acctlink_quickbooks_direct.sru
$PBExportComments$[n_cst_AcctLink_Quickbooks]
forward
global type n_cst_acctlink_quickbooks_direct from n_cst_acctlink_quickbooks
end type
end forward

global type n_cst_acctlink_quickbooks_direct from n_cst_acctlink_quickbooks
end type
global n_cst_acctlink_quickbooks_direct n_cst_acctlink_quickbooks_direct

type prototypes
//
FUNCTION uint FindWindowA (long classname, string windowname) &
	LIBRARY "user32.dll" alias for "FindWindowA;Ansi"
end prototypes

type variables
Protected:

OleObject		inv_Session

//Instance variables to record which QBSDK version
//we will use, ie 1.0, 2.0, etc, and the COM Object name.
//Values for these must be set in the constructor of the 
//descendant object for each respective version.
Integer		ii_QBSDK_MajorVersion
Integer		ii_QBSDK_MinorVersion
String		is_QBSDK_COMObject

Constant Integer	ci_roeContinue = 1

Constant Integer	ci_Locking_DontCare = 2

Constant String        cs_PT_Company_Name = "Profit Tools"
//When we are issued an AppId by QB, record it here.
Constant String	cs_QBAppId_ProfitTools = ""

Boolean 		ib_BackgroundConnect = FALSE // RDT 7-21-03
end variables

forward prototypes
public function integer of_batch_create (n_cst_msg anv_cst_msg)
public function integer of_link_open (ref string as_posting_company)
public function boolean of_link_close ()
public function integer of_validate_customers (datastore ads_list)
public function integer of_getmajorversion ()
public function integer of_getminorversion ()
public function oleobject of_getsession ()
public function integer of_validate_accounts (n_cst_msg anv_cst_msg, ref string as_notice)
private function boolean of_app_running (readonly string as_company)
public function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
public function integer of_validateemployee (readonly n_cst_accountingdata anva_accountingdata[])
public function integer of_createcustomer (ref long ala_ids[])
protected function integer of_createvendoremployee (readonly n_cst_beo_entity anva_entity[])
protected function integer of_createvendor (ref long ala_ids[])
protected function integer of_createvendorcompany (ref n_cst_beo_entity anva_entity[])
protected function integer of_validate_items (readonly string asa_item[], ref string as_notice)
protected function boolean of_customerexist (string as_name)
protected function integer of_validatevendorfile (ref n_cst_msg anv_msg)
protected function boolean of_vendorexist (ref string as_name)
protected function integer of_createvendorcompany (long ala_companyid[])
protected function integer of_setnamerangefilterforaccount (string as_account, ref oleobject anv_filter)
end prototypes

public function integer of_batch_create (n_cst_msg anv_cst_msg);// RDT 4-1-03 PO number Limited to 25 characters.
//Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch

// 
//		THERE ARE MID CODE RETURNS IN THIS SCRIPT
//

String 	ls_err_SkipList, &
			ls_Work1, &
			ls_Message, &
			ls_Batch_Type, &
			ls_ar_Account, &
			ls_CancelWarning, &
			ls_message_header, &
			ls_Reject, &
			lsa_Check[], &
			lsa_Empty[], &
			ls_Value, &
			ls_POLabels	//Added 3.5.15 BKW 9-16-2002

String 	ls_StatusSeverity, &
			ls_StatusMessage 

Decimal 	{2} lc_check

Long 		ll_row, &
	 		ll_trns, & 
			ll_dist, & 
			ll_err_skipcount

Integer 	li_ndx, &
			li_result, &
			li_winner

OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_InvoiceAdd, &
				lnv_LineAdd, & 
				lnv_ResponseList , & 
				lnv_Response     


s_parm lstr_parm

n_cst_msg lnv_cst_msg

s_accounting_transaction  lstra_trns[]
s_accounting_distribution lstr_dist


//There was some freaky behavior here.  I was declaring the following two variables
//below ( i.e. :  string ls_message_header = "Create AR Batch" ) and somehow the
//value was being set (consistently) to another string value from outside this object!
//The separate declaration / value assignment works fine, however.

ls_message_header = "Create AR Batch"
ls_reject = "Could not create AR batch."

ls_CancelWarning = "You have indicated that you do not wish to create an AR Batch.~n~n"+&
		"PLEASE NOTE: The bills have already been processed, and you will not be able to "+&
		"recreate an AR Batch for them later."
	
//Extract parameters from message object that was passed in.

for li_ndx = 1 to anv_cst_msg.of_get_count()
	if anv_cst_msg.of_get_parm(li_ndx, lstr_parm) > 0 then
		choose case lstr_parm.is_label
		case "BATCH_TYPE"
			ls_batch_type = lstr_parm.ia_value
		case "TRANSACTION"
			lstra_trns[upperbound(lstra_trns) + 1] = lstr_parm.ia_value
		end choose
	end if
next

//Validate requested batch type

choose case ls_batch_type
case "SALES!"
	//Batch type is OK
case else
	goto failure
end choose


//Get the list of Reference Labels that will be pulled to populate the PONUM field (added 3.5.15 BKW 09-16-2002)

ls_POLabels = This.of_GetPOLabels ( )

setpointer(hourglass!)	

If IsValid( inv_Session ) Then 
	lnv_Session = inv_Session
Else
	goto failure // ????
End If

lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )

lnv_RequestSet.Attributes.OnError = ci_roeContinue    // Invoice example uses roeStop

Long i
Long	ll_transCount
Boolean	lb_TooLong
ll_TransCount = upperbound(lstra_trns)
FOR i = 1 TO ll_TransCount
	IF LEN ( This.of_GetReferenceList ( lstra_Trns [ i ] ) ) > 4095 THEN
		lb_TooLong = TRUE
	END IF
NEXT

IF lb_TooLong THEN	
	MessageBox ( "QB Memo Field" , "The data being passed to the memo field is too long and will be truncated." , INFORMATION! )	
END IF

//Create the InvoiceAdd requests.

for ll_trns = 1 to ll_TransCount

	//Check for valid company (I deleted this) <- Who is "I" ? 

	lsa_check = lsa_empty
	//changed this from 0 to -1 to allow 0 amounts to be posted
	lc_check = -1
	li_winner = 0

	for ll_dist = 1 to upperbound(lstra_trns[ll_trns].istra_distributions)

		lstr_dist = lstra_trns[ll_trns].istra_distributions[ll_dist]

		//NOTE: the following approach assumes a credit amount to be SALES, and a debit
		//amount to be RECV.  This is probably not an adequate long-term approach.

		if lstr_dist.ib_credit = false then
			lsa_check[upperbound(lsa_check) + 1] = lstr_dist.is_account
			if lstr_dist.ic_amount > lc_check then
				lc_check = lstr_dist.ic_amount
				li_winner = upperbound(lsa_check)
			end if
		end if

	next

	if li_winner = 0 then
		ll_err_skipcount ++
		if len(ls_err_skiplist) > 0 then ls_err_skiplist += ", "
		ls_err_skiplist += lstra_trns[ll_trns].is_document_number
		continue
	else
		ls_ar_account = lsa_check[li_winner]
	end if
	
	if upperbound(lsa_check) > 1 then
		messagebox(ls_message_header, "The invoice " + lstra_trns[ll_trns].is_document_number +&
			" has multiple AR distributions associated with it.  This is not permitted "+&
			"in QuickBooks.  The account " + ls_ar_account + " will be used for "+&
			"the full invoice amount.")
	end if

	//Make Transaction entries
	lnv_RequestSet.ClearRequests ( ) 								//rdt 1-14-03
	lnv_RequestSet.Attributes.OnError = ci_roeContinue			//rdt 1-14-03

	lnv_InvoiceAdd = lnv_RequestSet.AppendInvoiceAddRq ( )

	//Set invoice header info.
	ls_Value = lstra_trns[ll_trns].is_company_code
	IF IsNull( ls_Value ) OR Len( Trim( ls_Value ) ) < 1 Then 
		ls_Value = lstra_trns[ll_trns].is_company_name 
	End If
	
	lnv_InvoiceAdd.CustomerRef.FullName.SetValue ( ls_Value )
	lnv_InvoiceAdd.ARAccountRef.FullName.SetValue ( ls_ar_account )
	ls_Value = Left( lstra_trns[ll_trns].is_document_number , 11)
	lnv_InvoiceAdd.RefNumber.SetValue ( ls_Value )  //InvoiceNumber

	If NOT IsNull( lstra_trns[ll_trns].id_document_date ) Then 
		lnv_InvoiceAdd.TxnDate.SetValue ( lstra_trns[ll_trns].id_document_date )
	End If

	// RDT 4-1-03 PO number Limited to 25 characters.
	// lnv_InvoiceAdd.PONumber.SetValue ( This.of_GetReferenceNumbersByLabel ( lstra_Trns [ ll_Trns ], ls_POLabels ) )
	ls_Value = This.of_GetReferenceNumbersByLabel ( lstra_Trns [ ll_Trns ], ls_POLabels ) 

	If NOT IsNull( ls_Value ) Then 
		lnv_InvoiceAdd.PONumber.SetValue ( Left( ls_Value, 25 ) )
	End if
	
	IF len(lstra_trns[ll_trns].is_payment_terms) > 0 THEN
		lnv_InvoiceAdd.TermsRef.FullName.SetValue ( Left( lstra_trns[ll_trns].is_payment_terms, 31 ) )
	END IF
	
	//memo limit (4095)
	
	 
	lnv_InvoiceAdd.Memo.SetValue ( Left ( This.of_GetReferenceList ( lstra_Trns [ ll_Trns ] ), 4095 ))
	//lnv_InvoiceAdd.Memo.SetValue (  This.of_GetReferenceList ( lstra_Trns [ ll_Trns ] ) )
	
	
	
	
	
	If NOT IsNull( lstra_trns[ll_trns].id_document_date ) Then 
		lnv_InvoiceAdd.ShipDate.SetValue ( lstra_trns[ll_trns].id_Document_Date)   
	End If
	
	lnv_InvoiceAdd.IsToBePrinted.SetValue ( FALSE )  //Appears to default to false.

	//Of the old columns from the iif, the following are not represented:
	//AMOUNT
	If NOT IsNull( lstra_trns[ll_trns].id_document_date ) Then 
		lnv_InvoiceAdd.DueDate.SetValue( lstra_trns[ll_trns].id_payment_due ) 	
	End If

	//Make Distribution entries

	for ll_dist = 1 to upperbound(lstra_trns[ll_trns].istra_distributions)

		lstr_dist = lstra_trns[ll_trns].istra_distributions[ll_dist]
		if lstr_dist.ib_credit = false then continue

		lnv_LineAdd = lnv_InvoiceAdd.ORInvoiceLineAddList.Append.InvoiceLineAdd ( )
		
		//Note: Unlike with the iif, the "Profit Tools" item has to be created in QB
		//Its tax setting should be set, usually to "Non"
		//Should we check whether it exists, and (if possible?) add it if it doesn't?
		// If we do, we may not add the right Account Number to it and confuse the chart of accounts.

		lnv_LineAdd.ItemRef.FullName.SetValue (lstr_dist.is_account )
//		lnv_LineAdd.Desc.SetValue ("Profit Tools" ) 	
		lnv_LineAdd.Quantity.SetValue ("1")
		lnv_LineAdd.Amount.SetValue ( String( lstr_dist.ic_amount ) )
//		lnv_LineAdd.OverrideItemAccountRef.FullName.SetValue ( lstr_dist.is_account )
//		lnv_LineAdd.SalesTaxCodeRef.FullName.SetValue ( "NON" )  

	next

	//Execute the RequestSet
	lnv_ResponseSet  = lnv_Session.DoRequests ( lnv_RequestSet )
	
	lnv_ResponseList = lnv_ResponseSet.ResponseList
	
	lnv_Response     = lnv_ResponseList.GetAt ( 0 )
	
	If lnv_Response.StatusCode <> 0 Then 
		ls_StatusSeverity = String(lnv_response.StatusSeverity) 
		ls_StatusMessage  = lnv_response.StatusMessage 
		MessageBox("Batch Create.", ls_StatusSeverity + "~n" + ls_StatusMessage  )
	End If

next

//Inform user of any invoices that were not included in the batch

if ll_err_skipcount > 0 then
	if ll_err_skipcount = 1 then
		ls_work1 = "invoice was"
	else
		ls_work1 = string(ll_err_skipcount) + " invoices were"
	end if
	if len(ls_message) > 0 then ls_message += "~n~n"
	ls_message += "The following " + ls_work1 + " not included in the AR batch because "+&
		"of processing errors:~n~n" + ls_err_skiplist
	messagebox("Notes on AR Batch", ls_message)
end if

return 1


failure:

if len(ls_reject) > 0 then messagebox(ls_message_header, ls_reject, exclamation!)
return -1
end function

public function integer of_link_open (ref string as_posting_company);//Returns : 1 = Success, -1 = Error, -2 = User chose No AR Batch, 
//-3 = User chose Cancel Billing

// RDT 7-21-03 Background Connect: Added check for system setting & popup window
w_pop_progress lw_Pop		// RDT 7-21-03 

OleObject	lnv_Session, &
				lnv_Response, &
				lnv_ResponseSet, & 
				lnv_ResponseList 
				
String		ls_ErrorMessage, &
				ls_MessageHeader = "Connect to QuickBooks", &
				ls_FileName, &
				ls_FilePath = ""
				
String 		ls_StatusSeverity, &
				ls_StatusMessage , &
				ls_QuickVersion 

Boolean		lb_Created, &
				lb_OleConnection, &
				lb_OpenedConnection, &
				lb_BegunSession				

Integer		li_Result

Integer		li_Return = 1
Any 			la_Value 

n_cst_Settings lnv_Settings


// RDT 7-21-03 - Start
IF lnv_Settings.of_GetSetting ( 20 , la_Value ) = 1 then 
	If "QUICKBOOKSDIRECT2003!" = Trim( String ( la_Value )  ) Then 
		If lnv_Settings.of_GetSetting ( 150 , la_Value ) = 1 then 
			ls_FilePath = Trim( String ( la_Value )  )
			iF Len( ls_FilePath ) > 0 Then 
				ib_BackgroundConnect = TRUE
				If Right ( ls_FilePath,1) <> "\" Then 
					ls_filePath += "\"
				end If
			end iF
		End if
	End if
END IF

IF li_Return = 1 THEN
	If NOT ib_BackgroundConnect Then 	
		if NOT of_App_Running( as_Posting_Company  ) Then 
			If MessageBox(ls_MessageHeader,"Is QuickBooks currently running on this computer?",Question!,YesNo!, 2) = 2 THEN
				li_Return = -1
			End IF
		end if
	End if
END IF 
// RDT 7-21-03 - End

IF li_Return = 1 THEN
	
	IF Len ( is_QBSDK_COMObject ) > 0 AND &
		ii_QBSDK_MajorVersion > 0 THEN
		
		//OK -- proceed.
		
	ELSE
		
		ls_ErrorMessage = "COM object and version number settings were not properly initialized."
		li_Return = -1
		
	END IF
	
END IF


IF li_Return = 1 THEN

	lnv_Session = Create OleObject
	lb_Created = TRUE

	SetPointer ( HourGlass! )
	
	li_Result = lnv_Session.ConnectToNewObject ( is_QBSDK_COMObject )

	CHOOSE CASE li_Result
			
		CASE 0   //Success
			
			//Flag that we've established ole connection
			lb_OleConnection = TRUE
			
		CASE -1  //-1  Invalid Call: the argument is the Object property of a control
			
			ls_ErrorMessage = "-1  Invalid Call: the argument is the Object property of a control"
			li_Return = -1
			
		CASE -2  //-2  Class name not found
			
			ls_ErrorMessage = "-2  Class name not found"
			li_Return = -1
			
		CASE -3  //-3  Object could not be created
			
			ls_ErrorMessage = "-3  Object could not be created"
			li_Return = -1
			
		CASE -4  //-4  Could not connect to object
			
			ls_ErrorMessage = "-4  Could not connect to object"
			li_Return = -1
			
		CASE -9  //-9  Other error
			
			ls_ErrorMessage = "-9  Other error"
			li_Return = -1
			
		CASE ELSE  //Null, or unexpected return
			
			ls_ErrorMessage = "Unexpected return value."
			li_Return = -1
			
	END CHOOSE

	IF li_Return = -1 THEN
		
		ls_ErrorMessage = "Error = " + ls_ErrorMessage
			
	END IF
	
END IF

IF li_Return = 1 THEN
	//lnv_Session.OpenConnection ( "", "Profit Tools for Trucking" ) 
	lnv_Response = lnv_Session.OpenConnection ( "", "Profit Tools for Trucking" ) 
	// lnv_Response is ALWAYS null 
	// RDT 12-23-02 added error checking start
		If IsValid( lnv_Session ) Then 
			lb_OpenedConnection = TRUE		
		Else
			ls_ErrorMessage = "QuickBooks Session not valid. ~nProcessing Stopped."
			li_Return = -1 
			lb_OpenedConnection = FALSE
		End If
	// RDT 12-23-02 added error checking end
	
End If

IF li_Return = 1 THEN
	
	//Note: This call appears to return an oleobject, not a long, so I don't think
	//we can error-check it.

	// RDT 7-21-03 //	lnv_Response = lnv_Session.BeginSession ( cs_QBAppId_ProfitTools, ci_Locking_DontCare ) // RDT blows up here if no connection 
	// RDT 7-21-03 //	ls_FileName 		 = Upper ( lnv_Session.GetCurrentCompanyFileName ( ) )
	// RDT 7-21-03 //	as_Posting_Company = Upper ( as_Posting_Company ) + ".QBW"
	
	// RDT 7-21-03 - Start 
	If ib_BackgroundConnect Then 
		ls_FileName = ls_Filepath + Upper ( as_Posting_Company ) + ".QBW"

		if NOT FileExists( ls_FileName )  Then 
			ls_ErrorMessage = "QuickBooks File not found: " +ls_FileName +"~nProcessing Stopped."
			li_Return = -1
		end if
	End if
END IF 

IF li_Return = 1 then 
	If ib_BackgroundConnect Then 
			Open(lw_Pop)
			lw_Pop.wf_settext ("Connecting to QuickBooks file~n"+ls_FileName  )
			lw_Pop.wf_showbar ( False)
	End if
	
	lnv_Response = lnv_Session.BeginSession ( ls_FileName , ci_Locking_DontCare ) 		

	If ib_BackgroundConnect Then 
			Close (lw_Pop)
		Else
			ls_FileName 		 = Upper ( lnv_Session.GetCurrentCompanyFileName ( ) )
			as_Posting_Company = Upper ( as_Posting_Company ) + ".QBW"
	End if
END IF
// RDT 7-21-03 - END

IF li_Return = 1 THEN

	IF Pos ( ls_FileName, as_Posting_Company  ) > 0 THEN
		//OK, company recognized.
	ELSE
		IF MessageBox ( ls_MessageHeader, "The posting company requested, ~n~n~"" +&
			as_Posting_Company + "~",~n~nis different from the QuickBooks file in use,~n~n~""+&
			ls_FileName + "~".~n~nPress OK to post to the current QuickBooks company, or "+&
			"Cancel to cancel the batch and switch to the correct QuickBooks company.", &
			Exclamation!, OKCancel!, 2 ) = 1 THEN
			
			//User selected OK to proceed.
			
		ELSE
			
			//User chose to cancel billing.
			li_Return = -3
			
		END IF
		
	END IF
	
END IF


IF li_Return = 1 THEN
	
	//Store a reference to the session object we've created on the instance variable.
	inv_Session = lnv_Session

ELSE
	
	ls_ErrorMessage = "Could not establish connection with Quickbooks.~n~n" + ls_ErrorMessage
	MessageBox ( ls_MessageHeader, ls_ErrorMessage, Exclamation! )
	
	
	//Undo any steps that were successful in creating the session object.
	
	IF lb_BegunSession = TRUE THEN
		lnv_Session.EndSession ( )
	END IF
	
	IF lb_OpenedConnection = TRUE THEN
		lnv_Session.CloseConnection ( )
	END IF
	
	IF lb_OleConnection = TRUE THEN
		lnv_Session.DisconnectObject ( )
	END IF
	
	IF lb_Created = TRUE THEN
		DESTROY lnv_Session
	END IF
	
END IF

RETURN li_Return
end function

public function boolean of_link_close ();
OleObject	lnv_Session

IF IsValid ( inv_Session ) THEN

	lnv_Session = inv_Session

	lnv_Session.EndSession ( )
	
	lnv_Session.CloseConnection ( )
	
	lnv_Session.DisconnectObject ( )
	
	DESTROY lnv_Session
	
END IF


RETURN TRUE
end function

public function integer of_validate_customers (datastore ads_list);//Returns the number of entries in the primary buffer that do not pass validation 
//(0 = All OK.)  Returns -1 if an error occurs, and -3 if user chooses Cancel Billing.

//RDT 01-02-03 Added call to of_CreateCustomer
//RDT 04-22-03 Added call to of_VendorExist to check for duplicates
String	ls_MessageHeader, &
			ls_Work, &
			ls_AcctName, &
			lsa_RejectList[], &
			ls_Message, &
			ls_Value, &
			ls_StatusSeverity, &
			ls_StatusMessage, &
			ls_CustomerRet, &
			lsa_DuplicateList[]
			
Integer	li_InvalidCount

Long		ll_Row, &
			ll_RejectCount, &
			ll_ListCount, &
			ll_Ndx, &
			ll_Id, &
			lla_RejectIds[]
			
OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_CustomerQuery, &
				lnv_CustomerFilter, &
				lnv_NameFilter, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_CustomerRet, &
				lnv_CustomerRetList, &
				lnv_CustomerRetRecord
			
				
n_cst_beo_Company	lnv_Company

Boolean	lb_Continue = TRUE

ls_MessageHeader = "Validate Customers"


IF lb_Continue THEN

	IF IsValid ( inv_Session ) THEN
		
		lnv_Session = inv_Session
		
	ELSE
		
		lb_Continue = FALSE
		
	END IF
	
END IF


IF lb_Continue THEN

	lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
	
	IF IsValid ( lnv_RequestSet ) THEN
		//OK
	ELSE
		lb_Continue = FALSE
	END IF
	
END IF

//// Check for name length
IF lb_Continue THEN
	ll_ListCount = ads_List.RowCount ( )

	FOR ll_Row = 1 TO ll_ListCount
		ls_AcctName = ads_List.Object.co_bill_acctcode[ ll_row ]
		// Use AR id if it exists.
		If IsNull ( ls_AcctName ) OR Len( Trim( ls_AcctName ) ) < 1 Then 
			ls_AcctName = ads_List.Object.xx_acct_name [ ll_Row ]  
		End IF	
		If Len ( ls_AcctName ) > 41 Then 
				ls_Work = ls_AcctName + "~n"
				lb_Continue = FALSE
		End If
	Next
	
	if lb_Continue = FALSE Then 
		ls_Message = "The following Profit Tools company names are greater than 41 characters.~n"+ls_Work + &
			"QuickBooks will not allow names greater than 41 characters. Process stopped."
		MessageBox ( ls_MessageHeader, ls_Message, None!, OK!  ) 
		RETURN -3		// MID-CODE RETURN 
	end if
	
End If


IF lb_Continue THEN
	
	ll_ListCount = ads_List.RowCount ( )
	
	FOR ll_Row = 1 TO ll_ListCount
	
		lnv_RequestSet.ClearRequests ( )

		lnv_RequestSet.Attributes.OnError = ci_roeContinue
	
		lnv_CustomerQuery = lnv_RequestSet.AppendCustomerQueryRq ( )
		
		lnv_CustomerFilter = lnv_CustomerQuery.ORCustomerListQuery.CustomerListFilter
		lnv_NameFilter = lnv_CustomerFilter.ORNameFilter.NameRangeFilter
		
		ll_Id = ads_List.Object.co_id [ ll_Row ]
		ls_AcctName = ads_List.Object.co_bill_acctcode[ ll_row ]
		// Use AR id if it exists.
		If IsNull ( ls_AcctName ) OR Len( Trim( ls_AcctName ) ) < 1 Then 
			ls_AcctName = ads_List.Object.xx_acct_name [ ll_Row ]  
		End IF	


		THIS.of_Setnamerangefilterforaccount( ls_AcctName , lnv_NameFilter )
//		lnv_NameFilter.FromName.SetValue ( ls_AcctName )
//		lnv_NameFilter.ToName.SetValue ( ls_AcctName )

		lnv_ResponseSet = lnv_Session.DoRequests ( lnv_RequestSet )
	
		lnv_ResponseList = lnv_ResponseSet.ResponseList
		
		lnv_Response = lnv_ResponseList.GetAt ( 0 )


		//RDT 12-23-02 Error check
		IF lnv_Response.StatusCode <> 0 THEN
			if lnv_Response.StatusCode = 1 Then // Not found
				if This.of_VendorExist( ls_AcctName ) Then 											// RDT 4-22-03 
					lsa_DuplicateList[ UpperBound(lsa_DuplicateList[]) + 1] = ls_AcctName	// RDT 4-22-03 
				else																								// RDT 4-22-03 
					ll_RejectCount ++
					lla_RejectIds [ ll_RejectCount ] = ll_Id
					lsa_RejectList [ ll_RejectCount ] = ls_AcctName
					lb_Continue = FALSE
				end if 																							// RDT 4-22-03 
			else
				ls_StatusSeverity =  String(lnv_response.StatusSeverity) 
				ls_StatusMessage  =  lnv_response.StatusMessage 
					MessageBox(ls_MessageHeader, "Error Severity: " + ls_StatusSeverity &
													 + "~nError Message : " + ls_StatusMessage  )
			end if
		ELSE
			//we may have more than one customer 
//			For ll_Ndx = 0 to lnv_ResponseList.Count() -1
			For ll_Ndx = 0 to lnv_Response.Detail.Count() -1

				lnv_CustomerRet = lnv_Response.Detail.GetAt(ll_Ndx )
				ls_CustomerRet = lnv_CustomerRet.Name.GetValue()
				
				If Upper( ls_CustomerRet) = Upper( ls_AcctName ) Then 
					lb_Continue = TRUE
					// found customer exit FOR loop
					Exit
				Else
					if This.of_VendorExist( ls_AcctName ) Then 										// RDT 4-22-03 
						lsa_DuplicateList[UpperBound(lsa_DuplicateList[]) + 1] = ls_AcctName	// RDT 4-22-03 
					else																							// RDT 4-22-03 
						ll_RejectCount ++
						lla_RejectIds [ ll_RejectCount ] = ll_Id
						lsa_RejectList [ ll_RejectCount ] = ls_AcctName
						lb_Continue = FALSE
					end if																						// RDT 4-22-03 
				End If
				
			Next
		
		END IF

	NEXT
	

	
	

	IF ll_RejectCount > 0 THEN

		ls_Work = ""

		FOR ll_Ndx = 1 TO ll_RejectCount
			ls_Work += lsa_RejectList [ ll_Ndx ] + "~n"
		NEXT

		ls_Message = "The following Profit Tools companies do not have an exact match in "+&
			"QuickBooks:~n~n" + ls_Work + "~nDo you want to add these companies to Quickbooks "+&
			"and proceed with billing?"

		IF MessageBox ( ls_MessageHeader, ls_Message, None!, YesNo!, 2 ) = 2 THEN
			RETURN -3  	// MID-CODE RETURN
		Else																		
			If This.of_CreateCustomer( lla_RejectIds ) = 1 Then  
				lb_Continue = TRUE
			End If
		END IF
		
	END IF

END IF

// RDT 4-22-03 START 
If UpperBound( lsa_DuplicateList[] ) > 0 Then 
	For ll_Ndx = 1 to UpperBound( lsa_DuplicateList[] )
		ls_Work += lsa_DuplicateList[ ll_Ndx ] + "~n"
	Next
	MessageBox(ls_MessageHeader, "The Following Customers Exist in QuickBooks as Vendors .~n" + &
											 ls_Work + &
											"~nPlease Specify an Alternate Accounting ID on the Company Settings Tag."+&
											"~nProcessing will stop." )
	goto failure
End If
// RDT 4-22-03 END 


IF lb_Continue THEN

	//Mark all companies in list as valid
	
	FOR ll_Row = 1 TO ads_List.RowCount ( )
		ads_List.Object.approved [ ll_Row ] = "T"
	NEXT
	
	li_InvalidCount = 0
	
ELSE
	
	li_InvalidCount = -1
	
END IF

RETURN li_InvalidCount

failure:
li_InvalidCount = -3
RETURN li_InvalidCount

end function

public function integer of_getmajorversion ();Return ii_qbsdk_majorversion
end function

public function integer of_getminorversion ();Return ii_qbsdk_minorversion
end function

public function oleobject of_getsession ();Return inv_session
end function

public function integer of_validate_accounts (n_cst_msg anv_cst_msg, ref string as_notice);//
/***************************************************************************************
NAME			: of_Validate_Accounts
ACCESS		: Public
ARGUMENTS	: n_cst_msg		(anv_cst_msg)
				  String 		(as_Notice) This is the results returned to calling method.
				  
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Validates accounts against QuickBooks accounts.
					List of account not found are displayed and -1 is returned
					Get list of accounts and check to see if they exist in QuickBooks

This assumes there's a connection to QB Already!

REVISION		: RDT 01-02-03
				RDT 7-10-03 Added check for account number
				RDT 7-21-03 Added instructions if background connected and insufficient permission
***************************************************************************************/

Integer		li_Return = 1, & 
				li_Count, &
				li_ErrorCount = 0

Long 			ll_ndx

String 		ls_MessageTitle = "Validate Accounts", &
				ls_ErrorMessage, &
				lsa_Accounts[], &
				lsa_AccountSales[], &
				lsa_AccountRecv[], &
				ls_temp, &
				ls_FieldRet, &
				ls_StatusSeverity, &
				ls_StatusMessage  , &
				ls_accountNumber 

				
OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_ResponseList , & 
				lnv_Response, &
				lnv_ResponseDetail, &
				lnv_AccountFilter , &
				lnv_NameFilter , &
				lnv_AccountQuery, &
				lnv_RecordRet
				
s_parm					lstr_parm

// THIS IS NOW DONE IN OF_DATALOAD
//IF anv_cst_msg.of_Get_Parm ( "SALES" , lstr_Parm ) <> 0 THEN
//	lsa_AccountSales[] = lstr_Parm.ia_Value
//	if This.of_Validate_Items( lsa_AccountSales, as_notice ) = 1 then 
//		li_Return = 1
//	else
//		li_Return = -1
//	end if
//End If

If li_Return = 1 Then 
	
	IF anv_cst_msg.of_Get_Parm ( "RECV" , lstr_Parm ) <> 0 THEN
		lsa_AccountRecv[] = lstr_Parm.ia_Value
		For li_Count = 1 to UpperBound( lsa_AccountRecv )
			lsa_Accounts[ UpperBound(lsa_Accounts) + 1] = lsa_AccountRecv[li_Count] 
		Next
		
	End If
	
	If IsValid( inv_Session ) Then 
		lnv_Session = inv_Session
		lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
		If NOT IsValid ( lnv_RequestSet ) Then 
				li_Return = -1
		End if
	Else
		MessageBox( ls_MessageTitle , "No session to connect to. Process stopped.")
		li_Return = -1
	End If

End If

If li_Return = 1 Then 

	lnv_RequestSet.ClearRequests ( )
	lnv_RequestSet.Attributes.OnError = ci_roeContinue
	
	lnv_AccountQuery = lnv_RequestSet.AppendAccountQueryRq ( )
	lnv_NameFilter = lnv_AccountQuery.ORAccountListQuery.AccountListFilter.ORNameFilter.NameRangeFilter

	
	For li_Count = 1 to UpperBound( lsa_Accounts )

		ls_temp = lsa_Accounts[ li_Count ] 
		
		THIS.of_SetNamerangefilterforaccount( ls_temp, lnv_NameFilter )
		//lnv_NameFilter.FromName.SetValue	( ls_temp )
		//lnv_NameFilter.ToName.SetValue ( ls_temp )

		if isvalid( lnv_RequestSet ) Then 
			
			lnv_ResponseSet  = lnv_Session.DoRequests ( lnv_RequestSet )
			
		end If
	
		lnv_ResponseList = lnv_ResponseSet.ResponseList
		
		lnv_Response = lnv_ResponseList.GetAt ( 0 )

		//RDT 12-23-02 Error check

		IF lnv_Response.StatusCode <> 0 THEN
			if lnv_Response.StatusCode = 1 Then // Not found
					ls_ErrorMessage = ls_ErrorMessage + "Account '" +lsa_Accounts[ li_Count ] + "' Not in QuickBooks.~n" 
					li_ErrorCount ++
			else
				ls_StatusSeverity =  String(lnv_response.StatusSeverity) 
				ls_StatusMessage  =  lnv_response.StatusMessage 
				
				If ib_backgroundconnect And &   
				   Left( Upper( ls_StatusMessage ), 29) = "INSUFFICIENT PERMISSION LEVEL" THEN 
				   ls_StatusMessage += "~nLogout of QuickBooks and try billing again."
				End if

			 	as_Notice = "~nQuickbooks Error: " +ls_StatusMessage 
				li_Return = -1
				Exit // no sense continuing the loop
			end if
		ELSE
			//we may have more than one account 
			For ll_Ndx = 0 to lnv_Response.Detail.Count() -1

				lnv_RecordRet = lnv_Response.Detail.GetAt(ll_Ndx )
				ls_FieldRet = lnv_RecordRet.FullName.GetValue()
				
				If Isvalid ( lnv_RecordRet.AccountNumber ) Then 						// RDT 7-10-03 
					ls_accountNumber = lnv_RecordRet.AccountNumber.GetValue()		// RDT 7-10-03 
				end if																				// RDT 7-10-03 

				If Upper( ls_FieldRet) = Upper( ls_temp ) Then 
					// Account Found exit loop 
					Exit
				Else
					If Upper( ls_accountNumber ) = Upper ( ls_Temp )Then 				// RDT 7-10-03 
						// Account Found exit loop 											// RDT 7-10-03 
						Exit																			// RDT 7-10-03 
					End if																			// RDT 7-10-03 
					ls_ErrorMessage = ls_ErrorMessage + "Account '" +lsa_Accounts[ li_Count ] + "' Not in QuickBooks.~n" 
					li_ErrorCount ++
				End If
				
			Next
		
		END IF

	Next

	If li_ErrorCount > 0 Then 
		as_Notice = ls_ErrorMessage
		li_Return = -1
	End If
	
End If

Return li_Return 
end function

private function boolean of_app_running (readonly string as_company);//
/***************************************************************************************
NAME			: of_app_Running
ACCESS		: Private 
ARGUMENTS	: String 	(Company)
RETURNS		: Boolean 
DESCRIPTION	: Checks to see if the application is running on the PC.
					The opened Quickbooks Company name must match the posting company for this to work.

REVISION		: RDT 01-30-03
***************************************************************************************/

Boolean 	lb_Return = False

uint  	val =0
int  		usage, rc
String 	ls_WindowName

If Val = 0 Then
	ls_WindowName = as_Company + " - QuickBooks Pro 2002"
	val = FindWindowA( 0, ls_WindowName )
End If

If Val = 0 Then
	ls_WindowName = as_Company + " - QuickBooks Premier 2002"
	val = FindWindowA( 0, ls_WindowName )
End If

If Val = 0 Then
	ls_WindowName = as_Company + " - QuickBooks Premier Edition 2002"
	val = FindWindowA( 0, ls_WindowName )
End If

If Val = 0 Then
	ls_WindowName = as_Company + " - QuickBooks Pro 2003"
	val = FindWindowA( 0, ls_WindowName )
End If

If Val = 0 Then
	ls_WindowName = as_Company + " - QuickBooks Premier Edition 2003"
	val = FindWindowA( 0, ls_WindowName )
End If

If val <> 0 Then 
	lb_Return = TRUE
End If

Return lb_Return 
end function

public function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);
/***************************************************************************************
NAME			: of_dataload
ACCESS		: Private 
ARGUMENTS	: n_cst_accountingdata
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Validates Vendor exist in Qbooks.
				  Validates Employees exist in Qbooks.
				  Loads data into the Quickbooks 

REVISION		: RDT 01-02-03
  				  Added Direct connect code
					Quickbooks doesn't require the payables id or payroll id exist BUT if 
					the ID exists we use that instead of the name.
					
					Create proper record for payable. Bill for vendor or check for employee. 
RDT 5-06-03 Check for negative amounts. QBooks does not allow negative amounts.					 
***************************************************************************************/

SetPointer(HourGlass!)

String	ls_TransType, &
			ls_value, &
			ls_reject, &
			ls_message_header, &
			ls_MessageContext, & 
			ls_type, &
			ls_message, &
			ls_pathname, &
			ls_filename, &
			lsa_distributionaccount[], &
			ls_category, &
			ls_EntityId, &
			ls_StatusSeverity , &
			ls_StatusMessage, &
			ls_AccountingCompany, &
			lsa_value[] , &
			lsa_distvalue[], &
			lsa_Blank[] 

Boolean  lb_BillAdd
			
Integer 	li_TransactionSign, &
			li_DistributionSign, &
			li_ndx, &
			li_result, &
			li_RecordCnt, &
			li_CreditCnt, &
			li_Return

Long		ll_TransactionCount, &
			ll_DistributionCount, &
			ll_trns, &
			ll_dist, &
			ll_row, &
			ll_division
			
decimal	lca_AmountOwed[]

OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_CreditRequestSet, &
				lnv_ResponseSet, &
				lnv_AddRecord, &
				lnv_AddCredit, &
				lnv_LineAdd, & 
				lnv_ResponseList , & 
				lnv_Response     
				
n_cst_accountingdata		lnv_accountingdata
n_cst_msg					lnv_cst_msg
s_parm						lstr_parm
n_cst_anyarraysrv			lnv_anyarraysrv

li_Return = 1
If Len( Trim( is_Category ) ) < 1 Then 		//RDT 02-18-03
	ls_category = anva_accountingdata[1].of_GetCategory ( ) // ALL Catagories should be the same!!
Else														//RDT 02-18-03
	ls_category =	is_Category 					//RDT 02-18-03
End If													//RDT 02-18-03

Choose case upper(ls_category)
	case 'PAYABLES'
		ls_type = "AP"
		ls_TransType = "BILL" 
		ls_MessageContext = "AP"
		li_TransactionSign = 1 // RDT 
		li_DistributionSign = 1
		
	case "PAYROLL"
		ls_type = "PR"
		ls_TransType = "CHECK" 
		ls_MessageContext = "PR"
		li_TransactionSign = 1 //RDT
		li_DistributionSign = 1

	Case Else 
		MessageBox("Program Error","n_cst_AcctLink_quickbooks_Direct.ofDataLoad() ~nCase1: "+Upper(ls_category)+" : not coded:")
		li_Return = -1	
		
end choose

ls_message_header = "Create " + ls_type + " Batch"
ls_reject = "Could not create "+ ls_type + " batch."
ll_TransactionCount = upperBound	( anva_accountingdata )


// Create Message Request 
If IsValid(inv_Session) Then 
	lnv_Session = inv_Session
Else
	n_cst_beo_ShipType		lnv_ShipType
	lnv_ShipType = CREATE n_cst_beo_ShipType
	lnv_ShipType.Of_SetUseCache ( TRUE )

	//By this point prior edit checking will have made sure that all divisions 
	//have the same posting company
	
	ll_division = anva_accountingdata[1].of_GetShipType()
	
	lnv_ShipType.Of_SetSourceId ( ll_division )
	ls_AccountingCompany = lnv_ShipType.Of_GetAccountingCompany ()
	
	if this.of_Link_Open(ls_AccountingCompany) = 1 Then 
		lnv_Session = inv_Session
	else
		ls_MessageContext = "Can not connect to QuickBooks."
		li_return = -1
	end if

	destroy(lnv_ShipType)
	
End if

IF li_Return = 1 then	
	lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( This.ii_QBSDK_MajorVersion, This.ii_QBSDK_MinorVersion )
	lnv_CreditRequestSet = lnv_Session.CreateMsgSetRequest ( This.ii_QBSDK_MajorVersion, This.ii_QBSDK_MinorVersion )
End If

// Validation section ****
Choose Case upper(ls_category)
	Case	"PAYABLES"
		// Validate vendor
		lnv_cst_msg.of_reset()
		lstr_parm.is_label = "ACCOUNTINGDATA"
		lstr_parm.ia_value =  anva_accountingdata			
		lnv_cst_msg.of_add_parm(lstr_parm)
		// this is already being called in validate batch nwl 11/22/04
//		IF This.of_ValidateVendorFile( lnv_Cst_Msg  ) = -3 Then 
//			// User did not want to add vendors or the add failed. we should stop the process
//			li_Return = -3
//		End If
		
		If li_Return = 1 Then 
			// Validate the Items get array of items
			lsa_value[] = lsa_Blank[]
			For ll_Trns = 1 to Upperbound(anva_accountingdata[] )
				anva_accountingdata[ll_trns].of_getdistributioncostaccount ( lsa_distvalue[] )
				lnv_anyarraysrv.of_appendstring ( lsa_value,  lsa_distvalue )
			Next
			lnv_AnyArraySrv.of_getshrinked ( lsa_Value, TRUE, TRUE)
			
			If this.of_Validate_Items(lsa_value, ls_MessageContext) = 1 Then 
				li_Return = 1
			else
				ls_reject = "Cannot create an AP batch due to the following problems:~n" &
				+ ls_MessageContext + "~n~nRequest cancelled."
				li_Return = -3
			end if
		End If

		If li_Return = 1 Then 

			// validate Accounts
			lnv_cst_msg.of_reset()
			lsa_value[] = lsa_Blank[]
			For ll_trns = 1 to UpperBound( anva_AccountingData )
				anva_AccountingData[ll_trns].of_GetDistributionAPaccount ( lsa_distvalue[]  )
				lnv_anyarraysrv.of_appendstring ( lsa_value,  lsa_distvalue )
			Next
			lnv_AnyArraySrv.of_getshrinked ( lsa_Value, TRUE, TRUE)
			
			lstr_parm.is_label = "RECV" 
			lstr_parm.ia_value = lsa_Value[]
			lnv_cst_msg.of_add_parm(lstr_parm)
								
			if this.of_validate_accounts(lnv_cst_msg, ls_MessageContext) = -1 then
				ls_reject = "Cannot create an AP batch due to the following problems:~n" &
								+ ls_MessageContext + "~n~nRequest cancelled."
					li_Return = -3
			end if
		End If	
	Case "PAYROLL"
		If This.of_ValidateEmployee ( anva_accountingdata ) = -3 Then 
			li_Return = -3
			// All Employees must exist in QBooks. 
		End If

		// validate Accounts
		lnv_cst_msg.of_reset()
		lsa_value[] = lsa_Blank[]
		For ll_trns = 1 to UpperBound( anva_AccountingData )
			lsa_value[ll_trns] = anva_AccountingData[ll_trns].of_GetTransactionAccount()
		Next
		lstr_parm.is_label = "RECV" 
		lstr_parm.ia_value = lsa_Value[]
		lnv_cst_msg.of_add_parm(lstr_parm)
							
		if this.of_validate_accounts(lnv_cst_msg, ls_MessageContext) = -1 then
			ls_reject = "Cannot create an AP batch due to the following problems:~n" &
							+ ls_MessageContext + "~n~nRequest cancelled."
				li_Return = -3
		end if

End Choose

///// Process transaction loop
IF li_Return = 1 then
	FOR ll_Trns = 1 TO ll_TransactionCount
		
		// added this in 4.0.21
		li_CreditCnt = 0
		li_RecordCnt = 0 
		
		
		lnv_RequestSet.ClearRequests ( )
		lnv_RequestSet.Attributes.OnError = ci_roeContinue

		lnv_CreditRequestSet.ClearRequests ( )
		lnv_CreditRequestSet.Attributes.OnError = ci_roeContinue

		// Get a single transaction
		lnv_accountingdata = anva_accountingdata [ ll_Trns ]

		choose case upper(ls_category)
			case "PAYABLES"
				//Set header info
				lnv_AddRecord = lnv_RequestSet.AppendBillAddRq( )  // BillAdd
				lnv_AddCredit = lnv_CreditRequestSet.AppendVendorCreditAddRq( )  // VendorCreditAdd

				ls_EntityId  = lnv_accountingdata.of_GetPayablesId ( )
				If IsNull( ls_EntityId ) OR Len( Trim( ls_EntityId ) ) < 1 Then 
					ls_EntityId = lnv_accountingdata.of_GetEntityName ( ) 
				End IF
				lb_BillAdd    = TRUE

			case "PAYROLL"
				//Set header info
				lnv_AddRecord = lnv_RequestSet.AppendCheckAddRq ( )
//				ls_EntityId   = lnv_accountingdata.of_GetEntityName ( ) 				// RDT 4-22-03
				ls_EntityId  = lnv_accountingdata.of_GetPayrollId ( ) 				// RDT 4-22-03
				If IsNull( ls_EntityId ) OR Len( Trim( ls_EntityId ) ) < 1 Then	// RDT 4-22-03
					ls_EntityId = lnv_accountingdata.of_GetEntityName ( )  			// RDT 4-22-03
				End IF 																				// RDT 4-22-03
				lb_BillAdd    = FALSE
				
			case Else 
					MessageBox("Program Error","n_cst_AcctLink_quickbooks_Direct.ofDataLoad() ~nCase2: "+Upper(ls_category)+" : not coded:")
					li_Return = -1
		end choose
		
		// Get associated AmountsOwed and determine the number of distributions for that trans.
		ll_DistributionCount = lnv_accountingdata.of_GetdistributionAmount ( lca_AmountOwed )

		
		lnv_accountingdata.of_GetcostexpenseAccount	(lsa_distributionaccount)

		//Make Transaction entries
		ls_value = ""

		Choose Case upper(ls_category)
			Case "PAYABLES"
			
				//bill			
				lnv_AddRecord.VendorRef.FullName.SetValue( Left( ls_EntityId , 41) )
				lnv_AddRecord.TxnDate.SetValue ( string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY") )
				If Len ( Trim( lnv_accountingdata.of_getDescription ( )	) ) > 0 Then 
					lnv_AddRecord.Memo.SetValue (  lnv_accountingdata.of_getDescription ( )	 )
				End If
				lnv_AddRecord.RefNumber.SetValue ( Left( string(lnv_accountingdata.of_GetDocumentNumber() ), 20 ) )  //DocumentNumber (check)
				
				//credits	
				lnv_AddCredit.VendorRef.FullName.SetValue( ls_EntityId )
				lnv_AddCredit.TxnDate.SetValue ( string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY") )
				If Len ( Trim( lnv_accountingdata.of_getDescription ( )	) ) > 0 Then 
					lnv_AddCredit.Memo.SetValue (  lnv_accountingdata.of_getDescription ( )	 )
				End If
				lnv_AddCredit.RefNumber.SetValue ( string(lnv_accountingdata.of_GetDocumentNumber ( )	) )  //DocumentNumber (check)
				
			Case "PAYROLL"
				lnv_cst_msg.of_reset()
				
				lstr_parm.is_label = "RECV" 
				lstr_parm.ia_value = { lnv_accountingdata.of_GetTransactionAccount ( ) }
				lnv_cst_msg.of_add_parm(lstr_parm)
				
				if this.of_validate_accounts(lnv_cst_msg, ls_MessageContext) = -1 then
					ls_reject = "Cannot create an AP batch due to the following problems:~n" &
									+ ls_MessageContext + "~n~nRequest cancelled."
						li_Return = -1 
					Exit   // STOP THE FOR LOOP
				end if
				lnv_AddRecord.AccountRef.FullName.SetValue( lnv_accountingdata.of_GetTransactionAccount ( ) )
				lnv_AddRecord.PayeeEntityRef.FullName.SetValue( ls_EntityId )
				lnv_AddRecord.TxnDate.SetValue ( string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY") )
				
				If Len ( Trim( lnv_accountingdata.of_getDescription ( )	) ) > 0 Then 
					lnv_AddRecord.Memo.SetValue (  lnv_accountingdata.of_getDescription ( )	 )
				End If
				lnv_AddRecord.RefNumber.SetValue ( Left( string(lnv_accountingdata.of_GetDocumentNumber() ) , 11 )  )  //DocumentNumber (check)

			Case Else 
				MessageBox("Program Error","n_cst_AcctLink_quickbooks_Direct.ofDataLoad() ~nCase3: "+Upper(ls_category)+" : not coded:")
				li_Return = -1	
		End Choose
		//Make Distribution entries
		FOR ll_dist = 1 TO ll_DistributionCount

			Choose Case upper(ls_category)
				Case "PAYABLES"
					lnv_accountingdata.of_GetDistributionCostAccount ( lsa_value[] )
					ls_Value = lsa_value[ll_Dist] 
					
					IF lca_AmountOwed[ll_dist] < 0 Then 
						lnv_LineAdd = lnv_AddCredit.ORItemLineAddList.Append()
						lnv_LineAdd.ItemLineAdd.Amount.SetValue( string(lca_AmountOwed[ll_dist] * -1 , "0.00") )
						li_CreditCnt ++
					ELSE
						lnv_LineAdd = lnv_AddRecord.ORItemLineAddList.Append()
						lnv_LineAdd.ItemLineAdd.Amount.SetValue( string(lca_AmountOwed[ll_dist] * li_DistributionSign , "0.00") )
						li_RecordCnt ++
					End if
					
					lnv_LineAdd.ItemLineAdd.ItemRef.FullName.SetValue ( ls_Value ) 
					If Len ( Trim( lnv_accountingdata.of_getDescription ( )	) ) > 0 Then 
						lnv_LineAdd.ItemLineAdd.Desc.SetValue ( Trim( lnv_accountingdata.of_getDescription ( )	) )
					End If
					

				Case "PAYROLL"

					lnv_LineAdd = lnv_AddRecord.ExpenseLineAddList.Append()
					li_RecordCnt ++
					lnv_accountingdata.of_getdistributionexpenseaccount ( lsa_value[] )
					ls_Value = lsa_value[ ll_Dist ]												
					lnv_LineAdd.AccountRef.FullName.SetValue ( ls_Value ) 	
					
					lnv_LineAdd.Amount.SetValue( string(lca_AmountOwed[ll_dist] * li_DistributionSign , "0.00") )
					
					if Len ( Trim( lnv_accountingdata.of_getDescription ( )	) ) > 0 Then 
						lnv_LineAdd.Memo.SetValue( lnv_accountingdata.of_getDescription ( )	 )
					end if

				Case Else 
					MessageBox("Program Error","n_cst_AcctLink_quickbooks_Direct.ofDataLoad() ~nCase: "+Upper(ls_category)+" : not coded:")

			End Choose
	
		NEXT // Each Distribution
		
		If li_Return = 1 Then 
			if li_RecordCnt > 0 then
				//Execute the RequestSet
				lnv_ResponseSet  = lnv_Session.DoRequests ( lnv_RequestSet )
				lnv_ResponseList = lnv_ResponseSet.ResponseList
		
				if IsValid( lnv_ResponseList ) Then 
					//lnv_ResponseList.Count()
					lnv_Response     = lnv_ResponseList.GetAt ( 0 )
					
					IF lnv_Response.StatusCode <> 0 Then 
						
						ls_StatusSeverity = String(lnv_response.StatusSeverity) 
						ls_StatusMessage  = lnv_response.StatusMessage 
						MessageBox("Quick Books Record Create Error", ls_StatusSeverity + "~n" + ls_StatusMessage  )
						li_Return = -1 
						Exit   // STOP THE FOR LOOP
						
					END IF
					
				end if	
			end if
			
			if li_CreditCnt > 0 then
				//Execute the  CreditRequestSet
				lnv_ResponseSet  = lnv_Session.DoRequests ( lnv_CreditRequestSet ) 
				lnv_ResponseList = lnv_ResponseSet.ResponseList
		
				if IsValid( lnv_ResponseList ) Then 
					//lnv_ResponseList.Count()
					lnv_Response     = lnv_ResponseList.GetAt ( 0 )
					
					IF lnv_Response.StatusCode <> 0 Then 
						
						ls_StatusSeverity = String(lnv_response.StatusSeverity) 
						ls_StatusMessage  = lnv_response.StatusMessage 
						MessageBox("Quick Books AP Record Create Error ", ls_StatusSeverity + "~n" + ls_StatusMessage  )
						li_Return = -1 
						Exit   // STOP THE FOR LOOP
						
					END IF
		
				end if
			end if
			
		Else
			// li_Return <> 1  so Stop the FOR loop 
			Exit   
		End If

	NEXT // Each Transaction 

END IF

IF li_Return <> 1 THEN
	IF len(ls_reject) > 0 THEN 
		messagebox(ls_message_header, ls_reject, exclamation!)
	END IF
END IF

//move this outside, call it before destroying object
//This.of_Link_Close()

RETURN li_Return

end function

public function integer of_validateemployee (readonly n_cst_accountingdata anva_accountingdata[]);
String	ls_MessageHeader, &
			ls_Work, &
			lsa_RejectList[], &
			ls_Message, &
			ls_Value, &
			ls_StatusSeverity, &
			ls_StatusMessage, &
			ls_employeeRet, &
			ls_Employee 
			
Integer	li_InvalidCount

Long		ll_Row, &
			ll_RejectCount, &
			ll_ListCount, &
			ll_Ndx, &
			ll_NdxEmployee, &
			ll_Id, &
			lla_RejectIds[], &
			ll_UpperBound 
			
OleObject	lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_employeeQuery, &
				lnv_employeeFilter, &
				lnv_NameFilter, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_employeeRet, &
				lnv_employeeRetList, &
				lnv_employeeRetRecord

Boolean	lb_Continue = TRUE

ls_MessageHeader = "Validate Employee"

IF IsValid ( inv_Session ) THEN
	lb_continue = TRUE
ELSE
	lb_Continue = FALSE
	
END IF

IF lb_Continue THEN

	lnv_RequestSet = inv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )

	IF IsValid ( lnv_RequestSet ) THEN
		//OK
	ELSE
		ls_Message = "Quick Books Request Set Invalid. Process Stopped." 
		lb_Continue = FALSE
		li_InvalidCount = -3  	
	END IF
	
END IF

ll_UpperBound = UpperBound (anva_accountingdata[])

For ll_ndx = 1 to ll_UpperBound 
	If lb_Continue Then  
		// If a payroll id exists use it
		ls_Employee = anva_AccountingData[ll_ndx].of_GetPayrollId() 
		If IsNull ( ls_Employee ) OR Len( Trim( ls_Employee ) ) < 1 Then 
				ls_Employee = anva_AccountingData[ll_ndx].of_GetEntityName()
		End If	
		If IsNull ( ls_Employee ) OR Len( Trim( ls_Employee ) ) < 1 Then 
			MessageBox(ls_MessageHeader, "Employee Name Missing ")
			lb_Continue = False
			ll_RejectCount = -3
		End If
			
			lnv_RequestSet.ClearRequests ( )
			lnv_RequestSet.Attributes.OnError = ci_roeContinue 
			lnv_employeeQuery = lnv_RequestSet.AppendEmployeeQueryRq ( )
			lnv_NameFilter = lnv_employeeQuery.ORListQuery.ListFilter.ORNameFilter.NameRangeFilter
			lnv_NameFilter.FromName.SetValue ( ls_Employee )
			lnv_NameFilter.ToName.SetValue ( ls_Employee )
	
			lnv_ResponseSet = inv_Session.DoRequests ( lnv_RequestSet )
			lnv_ResponseList = lnv_ResponseSet.ResponseList
			lnv_Response = lnv_ResponseList.GetAt ( 0 )
	
			IF lnv_Response.StatusCode <> 0 THEN
				if lnv_Response.StatusCode = 1 Then // Not found
						ll_RejectCount ++
						lla_RejectIds [ ll_RejectCount ] = ll_Id
						lsa_RejectList [ ll_RejectCount ] = ls_Employee
				else
					ls_StatusSeverity =  String(lnv_response.StatusSeverity) 
					ls_StatusMessage  =  lnv_response.StatusMessage 
						MessageBox("Validate Employee", "Error Severity: " + ls_StatusSeverity &
														 + "~nError Message : " + ls_StatusMessage  )
						lb_Continue = FALSE
						li_InvalidCount = -3  	
				end if
			ELSE
				//we may have more than one employee 
				ll_ListCount = lnv_ResponseList.Count() -1

//				For ll_NdxEmployee = 0 to ll_ListCount 
				For ll_NdxEmployee = 0 to lnv_Response.Detail.Count() -1

	
					lnv_employeeRet = lnv_Response.Detail.GetAt( ll_NdxEmployee )
					ls_employeeRet = lnv_employeeRet.Name.GetValue()
					
					If Upper( ls_employeeRet) = Upper( ls_Employee) Then 
						// employee found exit for loop
						Exit 
					Else
						ll_RejectCount ++
						lla_RejectIds [ ll_RejectCount ] = ll_Id
						lsa_RejectList [ ll_RejectCount ] = ls_Employee
					End If
					
				Next
		
			END IF
			
		END IF // lb_continue
		
Next //loop
IF lb_Continue Then  

	IF ll_RejectCount > 0 THEN

		ls_Work = ""

		FOR ll_Ndx = 1 TO ll_RejectCount
			ls_Work += lsa_RejectList [ ll_Ndx ] + "~n"
		NEXT

		ls_Message = "The following Profit Tools Employees or Payroll Ids do not have a match in "+&
			"QuickBooks:~n~n" + ls_Work + "~nPlease add them to Quickbooks "+&
			"before proceeding."

		MessageBox ( ls_MessageHeader, ls_Message, None!, ok!) 
		li_InvalidCount = -3  	
		
	END IF

END IF	// lb_continue

RETURN li_InvalidCount
end function

public function integer of_createcustomer (ref long ala_ids[]);//
/***************************************************************************************
NAME			: of_CreateCustomer
ACCESS		: Public 
ARGUMENTS	: Long Array 	ala_ids[]
				: OLEObject 	anv_session
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Creates a customer in QuickBooks

REVISION		: RDT 01-02-03
				  RDT 4-1-03  Company name now goes into first line of address 
***************************************************************************************/
String	ls_MessageHeader, &
			ls_AcctName, &
			ls_Value

String 	ls_StatusSeverity, &
			ls_StatusMessage 

Integer	li_InvalidCount

Integer  li_Return = 1 

Long		ll_Row, &
			ll_ListCount, &
			ll_Ndx, &
			ll_Id

OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_CustomerQuery, &
				lnv_CustomerFilter, &
				lnv_NameFilter, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_CustomerAdd

ls_MessageHeader = "Create QuickBooks Customer"
lnv_Session = this.of_GetSession()
lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( this.of_GetMajorversion(), this.of_GetMinorVersion() )

n_cst_beo_Company 	lnv_Company 
lnv_Company = CREATE n_cst_beo_Company
lnv_Company.of_SetUseCache ( TRUE )
//lnv_RequestSet.ClearRequests ( )
//lnv_RequestSet.Attributes.OnError = ci_roeContinue

FOR ll_Ndx = 1 TO UpperBound( ala_ids[] )
	lnv_RequestSet.ClearRequests ( )
	lnv_RequestSet.Attributes.OnError = ci_roeContinue
	
	lnv_Company.of_SetSourceId ( ala_ids [ ll_Ndx ] )
	
	lnv_CustomerAdd = lnv_RequestSet.AppendCustomerAddRq ( )

	IF lnv_Company.of_GetBillSame ( ) = "F" THEN
		
		ls_Value = lnv_Company.of_getaccountingid ( )
		
		If IsNull( ls_Value ) OR Len( Trim ( ls_Value ) ) < 1 Then 
			ls_Value = Left( lnv_Company.of_GetBillingName ( )	, 41)
		End If
		
		IF IsNull ( ls_Value ) OR Len( Trim ( ls_Value ) ) < 1 THEN 
			ls_Value =  Left( lnv_Company.of_GetName ( ) , 41)			
		End If
		
		lnv_CustomerAdd.Name.SetValue ( ls_Value )
		lnv_CustomerAdd.CompanyName.SetValue ( ls_Value )
		lnv_CustomerAdd.BillAddress.Addr1.SetValue ( Left( ls_Value, 41 )  )

		//Trying to set a null value will cause a crash.
		ls_Value = Left( lnv_Company.of_GetBillAddress1 ( ), 41 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.Addr2.SetValue ( ls_Value )
		END IF
		
		ls_Value = Left( lnv_Company.of_GetBillingAddress2 ( ), 41)
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.Addr3.SetValue (  ls_Value )
		END IF
		
		ls_Value = Left( lnv_Company.of_GetBillingCity ( ), 31)
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.City.SetValue ( ls_Value )
		END IF
		
		ls_Value = Left( lnv_Company.of_GetBillingState ( ), 21)
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.State.SetValue ( ls_Value )
		END IF

		If lnv_Company.of_GetUSnon ( ) = "U" AND IsNumber( lnv_Company.of_GetBillingZip( ) ) Then 
			ls_Value = Left( lnv_company.of_formatzip ( lnv_Company.of_GetBillingZip ( )  ), 13)
		Else
			ls_Value = Left( lnv_Company.of_GetBillingZip ( ), 13)
		End If
			
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.PostalCode.SetValue ( ls_Value ) 
		END IF
		
	ELSE

		ls_Value = lnv_Company.of_getaccountingid ( )
		
		If IsNull( ls_Value ) OR Len( Trim ( ls_Value ) ) < 1 Then 
			ls_Value = Left( lnv_Company.of_GetName ( ) , 41 )
		End If

		
		If NOT IsNull( ls_Value ) Then 
			lnv_CustomerAdd.Name.SetValue ( ls_Value )
			lnv_CustomerAdd.CompanyName.SetValue ( ls_Value )
		 	lnv_CustomerAdd.BillAddress.Addr1.SetValue ( ls_Value)
		End If

		ls_Value = Left( lnv_Company.of_GetAddress1 ( ) , 41)
		If NOT IsNull( ls_Value ) Then 
		 	lnv_CustomerAdd.BillAddress.Addr2.SetValue ( ls_Value)
		End If

		ls_Value = Left( lnv_Company.of_GetAddress2 ( ) , 41)
		If NOT IsNull( ls_Value ) Then 
			lnv_CustomerAdd.BillAddress.Addr3.SetValue ( ls_Value )  
		End If

		ls_Value = Left( lnv_Company.of_GetCity ( ), 31)
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.City.SetValue ( ls_Value )
		END IF
		
		ls_Value = Left( lnv_Company.of_GetState ( ), 21 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.State.SetValue ( ls_Value )
		END IF
		
		If lnv_Company.of_GetUSnon ( ) = "U" AND IsNumber( lnv_Company.of_GetZip( ) ) Then 
			ls_Value = Left( lnv_company.of_formatzip ( lnv_Company.of_GetZip ( )), 13)
		Else
			ls_Value = Left( lnv_Company.of_GetZip ( ), 13)
		End If
		
		IF NOT IsNull ( ls_Value ) THEN
			lnv_CustomerAdd.BillAddress.PostalCode.SetValue ( ls_Value )
		END IF
			
	END IF
	// Fields common to both addresses
	ls_Value = Left( lnv_Company.of_formatphone1 ( ), 21)
	IF NOT IsNull ( ls_Value ) THEN
		lnv_CustomerAdd.Phone.SetValue ( ls_Value ) 
	END IF

	ls_Value = Left( lnv_Company.of_formatphone2 ( ), 21)
	IF NOT IsNull ( ls_Value ) THEN
		lnv_CustomerAdd.AltPhone.SetValue ( ls_Value ) 
	END IF

	ls_Value = Left( lnv_Company.of_formatfax ( ), 21)
	IF NOT IsNull ( ls_Value ) THEN
		lnv_CustomerAdd.Fax.SetValue ( ls_Value ) 
	END IF


	lnv_ResponseSet = lnv_Session.DoRequests( lnv_RequestSet )
	
	// Error Check 
	lnv_ResponseList = lnv_ResponseSet.ResponseList
	If IsNull( lnv_ResponseList ) Then 
		// do nothing
	Else
		lnv_Response = lnv_ResponseList.GetAt ( 0 )
		If lnv_Response.StatusCode <> 0 Then 
			ls_StatusSeverity = String(lnv_response.StatusSeverity) 
			ls_StatusMessage  = lnv_response.StatusMessage 
			MessageBox(ls_MessageHeader, ls_StatusSeverity + "~n" + ls_StatusMessage  )
			li_Return = -1
			EXIT
		End If
	End If
	
NEXT

Destroy lnv_Company 

 Return li_Return 
end function

protected function integer of_createvendoremployee (readonly n_cst_beo_entity anva_entity[]);
/***************************************************************************************
NAME			: of_CreateVendorEmployee
ACCESS		: Protected
ARGUMENTS	: n_cst_beo_Entity[]
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Creates a Vendor in QuickBooks from PTools Employee data

REVISION		: RDT 02-04-03

***************************************************************************************/
String	ls_MessageHeader, &
			ls_AcctName, &
			ls_Value, &
			ls_Name , &
			ls_StatusSeverity, &
			ls_StatusMessage 

Integer	li_InvalidCount, &
			li_beoCount, &
			li_EntityCount, &
			i

Integer  li_Return = 1 

Long		ll_Row, &
			ll_ListCount, &
			ll_Ndx, &
			ll_Id, &
			lla_Id[], &
			ll_ResponseCode

OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_VendorQuery, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_VendorAdd

n_cst_beo_Employee		lnv_Employee
n_cst_bcm 					lnv_bcm
n_cst_database 			lnv_database
n_cst_query 				lnv_query

ls_MessageHeader = "Create QuickBooks Vendor from Employee Record"

If NOT IsValid( inv_Session ) Then 
	MessageBox(ls_MessageHeader,"Could not create QuickBooks Vendor. ~nConnection Failed to QuickBooks.")
	li_Return = -1
End if

//Get ids from array of Entities
li_EntityCount = UpperBound( anva_entity[] )
For ll_ndx = 1 to  li_EntityCount 
	lla_Id[ ll_ndx ]	= anva_entity[ ll_ndx ].of_getfkemployee ( ) 
Next 

// get the employee beo's
If li_Return = 1 Then 
	lnv_database = gnv_bcmmgr.GetDatabase()
	
	If IsValid(lnv_database) Then
		lnv_query = lnv_database.GetQuery()
		lnv_query.SetArgument(lla_id[])
		lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_employee","","Ids")
	End If

End If

If li_Return = 1 Then 
	If NOT IsValid( lnv_BCM ) OR ISNull( lnv_BCM ) Then 
		li_Return = -3
		MessageBox(ls_MessageHeader, "Invalid or Null BCM. Process Terminated.") 
	End If
		
End If

If li_Return = 1 Then 
	lnv_RequestSet = inv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
//	lnv_RequestSet.ClearRequests ( )
//	lnv_RequestSet.Attributes.OnError = ci_roeContinue

//	li_beoCount = lnv_bcm.getcount()
//	FOR ll_Ndx = 1 TO li_beoCount 

	FOR ll_Ndx = 1 TO li_EntityCount
		
		//need to make sure we have the employee beo that matches the entity beo  NWL 04-02-02
		for i = 1 to li_EntityCount
			lnv_Employee = lnv_bcm.Getat( i )
			if isvalid(lnv_employee) then
				if lnv_Employee.of_GetId() = anva_entity[ ll_ndx ].of_getfkemployee ( ) then
					exit
				else
					continue
				end if
			end if
		next

		if isvalid(lnv_employee) then
			//ok
		else
			continue
		end if

		If NOT IsValid ( lnv_Employee ) Then 
			li_Return = -3
			MessageBox(ls_MessageHeader, "Employee record is inactive or deleted. ")
		End If
		
		lnv_RequestSet.ClearRequests ( )
		lnv_RequestSet.Attributes.OnError = ci_roeContinue
		lnv_VendorAdd = lnv_RequestSet.AppendVendorAddRq ( )
		
		// check for payables ID and use it if it exists 
		ls_Value = anva_Entity[ ll_ndx ].of_getpayablesid ( )
		If IsNull ( ls_Value ) OR Len( Trim( ls_value ) ) < 1 Then 	//RDT 4-22-03
			ls_Value = anva_Entity[ ll_ndx ].of_getpayrollid ( )		//RDT 4-22-03
		End If																		//RDT 4-22-03
		
		If IsNull ( ls_Value ) OR Len( Trim( ls_value ) ) < 1 Then 	
			ls_Value = Left ( Trim(lnv_Employee.of_getfirstname ( )) +" "+ Trim( lnv_Employee.of_getlastname ( )) , 41)
		End IF
		
		If IsNull( ls_Value ) Then 
			MessageBox(ls_MessageHeader,"Invalid Employee Name "+ls_Value)
			li_Return = -3
			Exit
		Else
			ls_Name  = ls_Value 
			lnv_VendorAdd.Name.SetValue ( ls_Value )
//			lnv_VendorAdd.CompanyName.SetValue ( ls_Value )
		End If

		ls_Value = Left ( lnv_Employee.of_GetAddress1 ( ) , 41 )
		If NOT IsNull( ls_Value ) Then 
			lnv_VendorAdd.VendorAddress.Addr1.SetValue ( ls_Value)
		End If
	
		ls_Value = Left ( lnv_Employee.of_GetCity ( ), 31 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.VendorAddress.City.SetValue ( ls_Value )
		END IF
		
		ls_Value = Left ( lnv_Employee.of_GetState ( ), 21 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.VendorAddress.State.SetValue ( ls_Value )
		END IF
		
		ls_Value = lnv_Employee.of_GetZip ( )
		IF NOT IsNull ( ls_Value ) THEN
			ls_Value = Left ( ls_Value , 13 )
			lnv_VendorAdd.VendorAddress.PostalCode.SetValue ( ls_Value )
		END IF
				
		// Fields common to both addresses
		ls_Value = Left ( lnv_Employee.of_getphone ( ), 21 ) 
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.Phone.SetValue ( ls_Value ) 
		END IF
		
		lnv_ResponseSet = inv_Session.DoRequests( lnv_RequestSet )	
		// Error Check 
		lnv_ResponseList = lnv_ResponseSet.ResponseList
		If IsNull( lnv_ResponseList ) Then 
			// do nothing
		Else
			lnv_Response = lnv_ResponseList.GetAt ( 0 )
			ll_ResponseCode = lnv_Response.StatusCode 
			
			Choose Case ll_ResponseCode 
				Case 0 
					// no errors continue 
					
				Case 3100
					// duplicate entry 
					MessageBox( ls_MessageHeader, "The name '" + ls_Name + "' exists in QuickBooks. "+ &
									"~nPlease change the Employee in Profit Tools and run the process again.")
					li_Return = -3
					Exit
					
				Case Else
					ls_StatusSeverity = String(lnv_response.StatusSeverity) 
					ls_StatusMessage  = lnv_response.StatusMessage 
					MessageBox(ls_MessageHeader,"Severity: "+ ls_StatusSeverity + "~n" + ls_StatusMessage +"~nCode: "+String(ll_ResponseCode) )
					li_Return = -3
					Exit
					
			End Choose

		End If

	NEXT

	Destroy lnv_Employee 

End If

Return li_Return 
end function

protected function integer of_createvendor (ref long ala_ids[]);
/***************************************************************************************
NAME			: of_CreateVendor
ACCESS		: Protected
ARGUMENTS	: Long Array 	ala_ids[]
				  lnv_session 
RETURNS		: Integer (1=Success, -1=Fail, -3 = Stop process)
DESCRIPTION	: Creates a Vendor in QuickBooks

REVISION		: RDT 02-04-03

This will seperate the employee id's from the Company id's and put them into 
seperate arrays. 
Then it will call of_CreateVendorCompany ( ids[]) creates vendors from company data
or of_CreateVendorEmployee( ids[]) creates vendors from employee data as needed.
 
***************************************************************************************/
String	ls_MessageHeader, &
			ls_AcctName, &
			ls_Value

Long		ll_Row, &
			ll_Ndx, &
			ll_CompanyIds[], & 
			ll_EmployeeIds[]

Integer	li_Count, &			
			li_Return, &
			li_CompNdx, &
			li_EmpNdx

n_cst_Beo_Entity			lnv_Entity
n_cst_Beo_Entity			lnva_Entity_Company[]		
n_cst_Beo_Entity			lnva_Entity_Employee[]
n_cst_bcm 					lnv_bcm
n_cst_database 			lnv_database
n_cst_query 				lnv_query

ls_MessageHeader = "Create QuickBooks Vendors"

// get the entity beo's
lnv_database = gnv_bcmmgr.GetDatabase()

If IsValid(lnv_database) Then
	lnv_query = lnv_database.GetQuery()
	lnv_query.SetArgument(ala_ids[])
	lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_entity","","Ids")
	li_Return = 1
Else
	li_Return = -1
End If


If li_Return = 1 Then 
	If NOT IsValid( lnv_BCM ) OR ISNull( lnv_BCM ) Then 
		li_Return = -3
		MessageBox(ls_MessageHeader, "Create Vendor. Invalid or Null BCM. Process Terminated.") 
	End If
		
End If		
			
If li_Return = 1 Then 
	li_Count = lnv_bcm.getcount()
	li_CompNdx = 0
	li_EmpNdx  = 0
	
	FOR ll_Ndx = 1 TO li_Count 
		lnv_Entity = lnv_bcm.Getat( ll_Ndx )
	
		If NOT IsValid ( lnv_Entity ) Then 
			li_Return = -3
			MessageBox(ls_MessageHeader, "Entity record problem. ")
		End If
	
		If NOT IsNull( lnv_Entity.of_GetCompanyid ( ) ) Then 
				li_CompNdx ++
				lnva_Entity_Company[ li_CompNdx ] = lnv_Entity
		End if
			
		If NOT IsNull( lnv_Entity.of_Getfkemployee( ) ) Then 
				li_EmpNdx ++
				lnva_Entity_Employee[ li_EmpNdx ] = lnv_Entity
		End if
	Next
	
	If li_CompNdx > 0 Then 
		li_Return = This.of_CreateVendorCompany( lnva_Entity_Company )
	End If
	
	If li_EmpNdx > 0 then 
			li_Return = This.of_CreateVendorEmployee( lnva_Entity_Employee)
	End If
	
End If		

Return li_Return 
end function

protected function integer of_createvendorcompany (ref n_cst_beo_entity anva_entity[]);
/***************************************************************************************
NAME			: of_CreateVendorCompany
ACCESS		: Protected
ARGUMENTS	: n_cst_beo_entity[]
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Creates a Vendor in QuickBooks from PTools Company data

REVISION		: RDT 02-04-03

***************************************************************************************/
String	ls_MessageHeader, &
			ls_AcctName, &
			ls_Value

String 	ls_StatusSeverity, &
			ls_StatusMessage 

Integer	li_InvalidCount

Integer  li_Return = 1 

Long		ll_Row, &
			ll_ListCount, &
			ll_Ndx, &
			ll_Id, &
			ll_ResponseCode, &
			ll_Upperbound, &
			lla_ids[]

OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_VendorQuery, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_VendorAdd
				
ls_MessageHeader = "Create QuickBooks Vendor from Company Record"

If NOT IsValid( inv_Session ) Then 
	MessageBox(ls_MessageHeader,"Could not create QuickBooks Vendor. ~nConnection Failed to QuickBooks.")
	li_Return = -1
End if

// Get company Id's from array of entities
If li_Return = 1 Then
	ll_ListCount = UpperBound( anva_entity[] )
	For ll_ndx = 1 to ll_ListCount
		lla_ids[ll_ndx] = anva_Entity[ ll_ndx ].of_GetCompanyid ( )
	Next
End If

If li_Return = 1 Then 
	lnv_RequestSet = inv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
//	lnv_RequestSet.ClearRequests ( )
//	lnv_RequestSet.Attributes.OnError = ci_roeContinue

	gnv_cst_companies.of_Cache( lla_ids[], TRUE /*refresh*/)	
	n_cst_beo_Company 	lnv_Company 
	lnv_Company = CREATE n_cst_beo_Company
	lnv_Company.of_SetUseCache ( TRUE )
	
	ll_Upperbound = UpperBound( lla_ids[] )
	
	FOR ll_Ndx = 1 TO ll_UpperBound
		lnv_RequestSet.ClearRequests ( )
		lnv_RequestSet.Attributes.OnError = ci_roeContinue

		lnv_Company.of_SetSourceId ( lla_ids [ ll_Ndx ] )

		lnv_VendorAdd = lnv_RequestSet.AppendVendorAddRq ( )
		
		// check for payables ID and use it if it exists 
		ls_Value = anva_Entity[ ll_ndx ].of_getpayablesid ( )

		If IsNull ( ls_Value ) OR Len( Trim( ls_value ) ) < 1 Then 	
			ls_Value = Left ( lnv_Company.of_GetName ( ) , 41)
		End IF
	
		If NOT IsNull( ls_Value ) Then 
			lnv_VendorAdd.Name.SetValue ( ls_Value )
			lnv_VendorAdd.CompanyName.SetValue ( ls_Value )
		Else
			MessageBox(ls_MessageHeader,"Invalid Vendor Name. Vendor Name is Null")
			li_Return = -1
			Exit
		End If

		ls_Value = Left ( lnv_Company.of_GetAddress1 ( ) , 41 )
		If NOT IsNull( ls_Value ) Then 
			lnv_VendorAdd.VendorAddress.Addr1.SetValue ( ls_Value)
		End If

	
		ls_Value = Left ( lnv_Company.of_GetAddress2 ( ) , 41 )
		If NOT IsNull( ls_Value ) Then 
			lnv_VendorAdd.VendorAddress.Addr2.SetValue ( ls_Value )  
		End If

		ls_Value = Left ( lnv_Company.of_GetCity ( ), 31 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.VendorAddress.City.SetValue ( ls_Value )
		END IF
		
		ls_Value = Left ( lnv_Company.of_GetState ( ), 21 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.VendorAddress.State.SetValue ( ls_Value )
		END IF
		
		If lnv_Company.of_GetUSnon ( ) = "U" AND IsNumber( lnv_Company.of_GetZip( ) ) Then 
			ls_Value = lnv_company.of_formatzip ( lnv_Company.of_GetZip ( ))
		Else
			ls_Value = lnv_Company.of_GetZip ( )
		End If
		
		IF NOT IsNull ( ls_Value ) THEN
			ls_Value = Left ( ls_Value , 13 )
			lnv_VendorAdd.VendorAddress.PostalCode.SetValue ( ls_Value )
		END IF
				
		// Fields common to both addresses
		ls_Value = Left ( lnv_Company.of_formatphone1 ( ), 21 ) 
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.Phone.SetValue ( ls_Value ) 
		END IF
		
		lnv_ResponseSet = inv_Session.DoRequests( lnv_RequestSet )	
		// Error Check 
		lnv_ResponseList = lnv_ResponseSet.ResponseList
		If IsNull( lnv_ResponseList ) Then 
			// do nothing
		Else
			lnv_Response = lnv_ResponseList.GetAt ( 0 )
			ll_ResponseCode = lnv_Response.StatusCode 
			
			Choose Case ll_ResponseCode 
				Case 0 
					// no errors continue 
					
				Case 3100
					// duplicate entry 
					MessageBox( ls_MessageHeader, "The name '" + lnv_Company.of_GetName ( ) + "' exists in QuickBooks. "+ &
									"~nPlease change the Company in Profit Tools and run the process again.")
					li_Return = -3
					Exit
					
				Case Else
					ls_StatusSeverity = String(lnv_response.StatusSeverity) 
					ls_StatusMessage  = lnv_response.StatusMessage 
					MessageBox(ls_MessageHeader,"Severity: "+ ls_StatusSeverity + "~n" + ls_StatusMessage +"~nCode: "+String(ll_ResponseCode) )
					li_Return = -3
					Exit
					
			End Choose

		End If
	NEXT

	Destroy lnv_Company 

End If

Return li_Return 
end function

protected function integer of_validate_items (readonly string asa_item[], ref string as_notice);//
/***************************************************************************************
NAME			: of_Validate_Items	
ACCESS		: Protected
ARGUMENTS	: String Array	(items)
				: String 		(as_notice ref)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Validates the items exist in QuickBooks
REVISION		: RDT 01-02-03
***************************************************************************************/

Integer		li_Return = 1, & 
				li_Count, &
				li_ErrorCount = 0
				
Long 			ll_ndx

String 		ls_MessageTitle = "Validate Item Accounts", &
				ls_ErrorMessage, &
				ls_temp, &
				ls_StatusSeverity, &
				ls_StatusMessage , &
				ls_FieldRet
				
OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_ResponseList , & 
				lnv_Response, &
				lnv_AccountFilter , &
				lnv_NameFilter , &
				lnv_AccountQuery, &
				lnv_RecordRet, &
				lnv_Temp

If IsValid( inv_Session ) Then 
	lnv_Session = inv_Session
	lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
	If NOT IsValid ( lnv_RequestSet ) Then 
			li_Return = -1
	End if
Else
	MessageBox( ls_MessageTitle , "No session to connect to. Process stopped.")
	li_Return = -1
End If

If li_Return = 1 Then 

	lnv_RequestSet.ClearRequests ( )
	lnv_RequestSet.Attributes.OnError = ci_roeContinue

	lnv_AccountQuery = lnv_RequestSet.AppendItemQueryRq( )
	lnv_NameFilter = lnv_AccountQuery.ORListQuery.ListFilter.ORNameFilter.NameRangeFilter

	For li_Count = 1 to UpperBound( asa_item[] )

		ls_temp = asa_item[ li_Count ] 
		
		lnv_NameFilter.FromName.SetValue	( ls_temp )
		lnv_NameFilter.ToName.SetValue ( ls_temp )

		if isvalid( lnv_RequestSet ) Then 
			lnv_ResponseSet  = lnv_Session.DoRequests ( lnv_RequestSet )
		end If
	
		lnv_ResponseList = lnv_ResponseSet.ResponseList
		
		lnv_Response = lnv_ResponseList.GetAt ( 0 )

		//RDT 12-23-02 Error check
		IF lnv_Response.StatusCode <> 0 THEN
			if lnv_Response.StatusCode = 1 Then // Not found
				ls_ErrorMessage = ls_ErrorMessage + "Item " +asa_Item[ li_Count ] + " is not in QuickBooks or is Inactive.~n" 	
				li_ErrorCount ++
			else
				ls_StatusSeverity =  String(lnv_response.StatusSeverity) 
				ls_StatusMessage  =  lnv_response.StatusMessage 
				MessageBox("Validate Accounts", "Error Severity: " + ls_StatusSeverity &
													 + "~nError Message : " + ls_StatusMessage  )
			end if 
		ELSE
			//we may have more than one 

			For ll_Ndx = 0 to lnv_Response.Detail.Count() -1
				lnv_RecordRet = lnv_Response.Detail.GetAt(ll_Ndx ) // lnv_RecordRet now = IORItemRetList
				li_Return = -1
				
				If IsValid( lnv_RecordRet.ItemServiceRet ) 		Then  
					lnv_temp = lnv_RecordRet.ItemServiceRet 
					li_Return = 1
				End If

				If IsValid( lnv_RecordRet.ItemNonInventoryRet ) Then 	
					lnv_temp = lnv_RecordRet.ItemNonInventoryRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemOtherChargeRet) 	Then 
					lnv_temp = lnv_RecordRet.ItemOtherChargeRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemInventoryRet) 		Then 	
					lnv_temp = lnv_RecordRet.ItemInventoryRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemInventoryAssemblyRet) Then 
					lnv_temp = lnv_RecordRet.ItemInventoryAssemblyRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemSubtotalRet) Then 
					lnv_temp = lnv_RecordRet.ItemSubtotalRet
					li_Return = 1
				End If
		
				If IsValid( lnv_RecordRet.ItemDiscountRet) 		Then 
					lnv_temp = lnv_RecordRet.ItemDiscountRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemPaymentRet) 		Then 
					lnv_temp = lnv_RecordRet.ItemPaymentRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemSalesTaxRet) 		Then	
					lnv_temp = lnv_RecordRet.ItemSalesTaxRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemSalesTaxGroupRet) Then 
					lnv_temp = lnv_RecordRet.ItemSalesTaxGroupRet
					li_Return = 1
				End If
				
				If IsValid( lnv_RecordRet.ItemGroupRet) 			Then 
					lnv_temp = lnv_RecordRet.ItemGroupRet
					li_Return = 1
				End If

				If li_Return = -1 Then
					MessageBox("Program Error","Quickbooks Item type not found.")
					Return -1	// MID-CODE RETURN
				End If				
				ls_FieldRet = lnv_Temp.Name.GetValue() 
				
				If Upper( ls_FieldRet) = Upper( ls_temp ) Then 
					// Found item 
					Exit 
				Else
					ls_ErrorMessage = ls_ErrorMessage + "Item " +asa_Item[ li_Count ] + " is not in QuickBooks or is Inactive.~n" 	
					li_ErrorCount ++
				End If
				
			Next
		
		END IF //lnv_Response.StatusCode <> 0 
		
	Next

	If li_ErrorCount > 0 Then 
		as_Notice = ls_ErrorMessage
		li_Return = -1
	End If
	
End If

Return li_Return 
end function

protected function boolean of_customerexist (string as_name);// RDT 4-22-03 Check for Existing Customers 
// checks for existing Customer in Quickbooks.


String	ls_MessageHeader, &
			ls_Work, &
			lsa_RejectList[], &
			ls_Message, &
			ls_Name, &
			ls_StatusSeverity, &
			ls_StatusMessage, &
			ls_CustomerRet
			
Integer	li_InvalidCount

Boolean	lb_CustomerFound

Long		ll_Row, &
			ll_RejectCount, &
			ll_transactioncount , &
			ll_Index, &
			ll_Customer_Index, &
			ll_Id, &
			lla_RejectIds[]
			
OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_CustomerQuery, &
				lnv_CustomerFilter, &
				lnv_NameFilter, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_CustomerRet, &
				lnv_CustomerRetList, &
				lnv_CustomerRetRecord

Boolean		lb_Continue = TRUE 

ll_RejectCount = 0

ls_MessageHeader = "Existing Customer"

IF IsValid ( inv_Session ) THEN
	lnv_Session = inv_Session
ELSE
	ll_RejectCount = -1 
END IF

IF ll_RejectCount = 0 THEN 
	lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
	
	IF IsValid ( lnv_RequestSet ) THEN
		//OK
	ELSE
		ls_Message = "Quick Books Request Set Invalid. Process Stopped." 
		ll_RejectCount = -1
	END IF
	
END IF

IF ll_RejectCount = 0 THEN 
	
		ls_name = as_name
	
		IF lb_Continue THEN
	
			lnv_RequestSet.ClearRequests ( )
			lnv_RequestSet.Attributes.OnError = ci_roeContinue
			lnv_CustomerQuery = lnv_RequestSet.AppendCustomerQueryRq ( )
			lnv_CustomerFilter = lnv_CustomerQuery.ORCustomerListQuery.CustomerListFilter
			lnv_NameFilter = lnv_CustomerFilter.ORNameFilter.NameRangeFilter
			
			lnv_NameFilter.FromName.SetValue ( ls_Name)
			lnv_NameFilter.ToName.SetValue ( ls_Name )
	
			lnv_ResponseSet = lnv_Session.DoRequests ( lnv_RequestSet )
		
			lnv_ResponseList = lnv_ResponseSet.ResponseList
			
			lnv_Response = lnv_ResponseList.GetAt ( 0 )
	
			IF lnv_Response.StatusCode <> 0 THEN
				if lnv_Response.StatusCode = 1 Then // Not found
					lb_CustomerFound = FALSE
				else
					ls_StatusSeverity =  String(lnv_response.StatusSeverity) 
					ls_StatusMessage  =  lnv_response.StatusMessage 
						MessageBox(ls_MessageHeader, "Error Severity: " + ls_StatusSeverity &
														 + "~nError Message : " + ls_StatusMessage  )
				end if
			ELSE
				//we may have more than one Customer 
				//For ll_Customer_Index = 0 to lnv_ResponseList.Count() -1  //lnv_ResponseList is zero based
				For ll_Customer_Index = 0 to lnv_Response.Detail.Count() -1

					lnv_CustomerRet = lnv_Response.Detail.GetAt( ll_Customer_Index )
					ls_CustomerRet = lnv_CustomerRet.Name.GetValue()
					
					If Upper( ls_CustomerRet) = Upper( ls_Name ) Then 
						lb_CustomerFound = TRUE
						Exit
					Else
						lb_CustomerFound = FALSE
					End If
					
				Next
			END IF // lnv_Response.StatusCode <> 0 
		END IF // lb_Continue 

END IF // reject count 


RETURN lb_CustomerFound 


end function

protected function integer of_validatevendorfile (ref n_cst_msg anv_msg);// of_ValidateVendorFile validates against Quickbooks.
// RDT 4-22-03 Check for Existing Customers 
// RDT 4-23-03 Make a list of duplicate customers
// RDT 5-26-03 Process Non entity companies
String	ls_MessageHeader, &
			ls_Work, &
			lsa_RejectList[], &
			ls_Message, &
			ls_Name, &
			ls_StatusSeverity, &
			ls_StatusMessage, &
			ls_VendorRet, &
			ls_AccountingCompany, &
			lsa_DuplicateList[]
			
Integer	li_InvalidCount

Long		ll_Row, &
			ll_RejectCount, &
			ll_transactioncount , &
			ll_Index, &
			ll_Vendor_Index, &
			ll_Id, &
			lla_RejectIds[], &
			ll_division, &
			lla_RejectedCompanyIDs[]		// RDT 5-26-03

			
OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_VendorQuery, &
				lnv_VendorFilter, &
				lnv_NameFilter, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_VendorRet, &
				lnv_VendorRetList, &
				lnv_VendorRetRecord

Boolean		lb_Continue = TRUE 

ll_RejectCount = 0

s_parm	lstr_parm

n_cst_accountingdata	lnv_accountingdata, &
							lnva_accountingdata[]
							
//get msg parms
if anv_msg.of_get_parm ( "ACCOUNTINGDATA" , lstr_parm ) > 0 THEN
	lnva_accountingdata =  lstr_Parm.ia_Value 
end if

ls_MessageHeader = "Validate Vendors"

// Create Message Request if needed
If IsValid(inv_Session) Then 
	lnv_Session = inv_Session
Else

	n_cst_beo_ShipType		lnv_ShipType
	lnv_ShipType = CREATE n_cst_beo_ShipType
	lnv_ShipType.Of_SetUseCache ( TRUE )

	//By this point prior edit checking will have made sure that all divisions 
	//have the same posting company
	
	ll_division = lnva_accountingdata[1].of_GetShipType()
	
	lnv_ShipType.Of_SetSourceId ( ll_division )
	ls_AccountingCompany = lnv_ShipType.Of_GetAccountingCompany ()
	
	if this.of_Link_Open(ls_AccountingCompany) = 1 Then 
		lnv_Session = inv_Session
	else
		ll_RejectCount  = -1
	end if
	
	destroy(lnv_ShipType)
	
End if


IF ll_RejectCount = 0 THEN 
	lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
	
	IF IsValid ( lnv_RequestSet ) THEN
		//OK
	ELSE
		ls_Message = "Quick Books Request Set Invalid. Process Stopped." 
		ll_RejectCount = -1
	END IF
	
END IF

Yield ( )
IF ll_RejectCount = 0 THEN 
	ll_transactioncount = upperbound ( lnva_accountingdata )
	
	FOR ll_Index = 1 TO ll_TransactionCount	
		lnv_accountingdata = lnva_accountingdata[ll_Index]
	
		If lnv_accountingdata.of_getcategory ( ) <> lnv_accountingdata.cs_payables Then 
			// Skip it
			continue 
		End If

		
		ls_name = lnv_accountingdata.of_GetPayablesId ( )

		// Use ID if it exists else use the name 
		If IsNull( ls_name ) OR Len( Trim( ls_Name ) ) < 1 Then 
			ls_Name = lnv_accountingdata.of_getentityName()
		End IF



		ll_id   = lnv_accountingdata.of_getentityid ( )
		
		// RDT 5-26-03 Seperate out NON-entity companies -start
		If isnull(ll_id) or ll_id = 0 Then 
			ll_id = 0
			//this will be added if rejected
//			lla_RejectedCompanyIDs[UpperBound( lla_RejectedCompanyIDs ) + 1 ] = lnv_accountingdata.of_GetCompanyId ( )
		End If


		If Len( Trim( ls_Name ) ) < 1 Then 
			MessageBox(ls_MessageHeader, "Name Missing ")
			lb_Continue = False
			ll_RejectCount = -3
		End If
						
		IF lb_Continue THEN
			If Len ( ls_Name) > 41 Then 
				lb_Continue = FALSE
				ls_Message = "The following Profit Tools Vendor is greater than 41 characters.~n"+ls_Name + &
					"QuickBooks will not allow names greater than 41 characters. Please edit before continuing."
				MessageBox ( ls_MessageHeader, ls_Message, None!, OK!  ) 
				ll_RejectCount = -3
				lb_Continue = FALSE
			end if
		End If
	
		IF lb_Continue THEN
	
			lnv_RequestSet.ClearRequests ( )
			lnv_RequestSet.Attributes.OnError = ci_roeContinue
			lnv_VendorQuery = lnv_RequestSet.AppendVendorQueryRq ( )
			lnv_VendorFilter = lnv_VendorQuery.ORVendorListQuery.VendorListFilter
			lnv_NameFilter = lnv_VendorFilter.ORNameFilter.NameRangeFilter
						
			lnv_NameFilter.FromName.SetValue ( ls_Name)
			lnv_NameFilter.ToName.SetValue ( ls_Name )
	
			lnv_ResponseSet = lnv_Session.DoRequests ( lnv_RequestSet )
		
			lnv_ResponseList = lnv_ResponseSet.ResponseList
			
			lnv_Response = lnv_ResponseList.GetAt ( 0 )
	
			IF lnv_Response.StatusCode <> 0 THEN
				if lnv_Response.StatusCode = 1 Then // Not found
				
					If This.of_CustomerExist( ls_Name ) Then 										// RDT 4-22-03 
						lsa_DuplicateList[UpperBound(lsa_DuplicateList[]) + 1] = ls_Name	// RDT 4-22-03 
					Else																						// RDT 4-22-03 
						ll_RejectCount ++
						lla_RejectIds [ ll_RejectCount ] = ll_Id
						lsa_RejectList [ ll_RejectCount ] = ls_Name
						if ll_id = 0 then
							//add to non entity list
							lla_RejectedCompanyIDs[UpperBound( lla_RejectedCompanyIDs ) + 1 ] = lnv_accountingdata.of_GetCompanyId ( )
						end if
					End If 																					// RDT 4-22-03 
						
				else
					ls_StatusSeverity =  String(lnv_response.StatusSeverity) 
					ls_StatusMessage  =  lnv_response.StatusMessage 
						MessageBox("Validate Accounts", "Error Severity: " + ls_StatusSeverity &
														 + "~nError Message : " + ls_StatusMessage  )
				end if
			ELSE
				//we may have more than one Vendor 
				//For ll_Vendor_Index = 0 to lnv_ResponseList.Count() -1  //lnv_ResponseList is zero based
				For ll_Vendor_Index = 0 to lnv_Response.Detail.Count() -1

					lnv_VendorRet = lnv_Response.Detail.GetAt( ll_Vendor_Index )
					ls_VendorRet = lnv_VendorRet.Name.GetValue()
					
					If Upper( ls_VendorRet) = Upper( ls_Name ) Then 
						// Found Vendor exit loop
						Exit
					Else
						If This.of_CustomerExist( ls_Name ) Then 										// RDT 4-22-03 
							lsa_DuplicateList[UpperBound(lsa_DuplicateList[]) + 1] = ls_Name	// RDT 4-22-03 
						Else																						// RDT 4-22-03 
							ll_RejectCount ++
							lla_RejectIds [ ll_RejectCount ] = ll_Id
							lsa_RejectList [ ll_RejectCount ] = ls_Name
							if ll_id = 0 then
								//add to non entity list
								lla_RejectedCompanyIDs[UpperBound( lla_RejectedCompanyIDs ) + 1 ] = lnv_accountingdata.of_GetCompanyId ( )
							end if
						End If 																					// RDT 4-22-03 
	
					End If
					
				Next
			END IF // lnv_Response.StatusCode <> 0 
		END IF // lb_Continue 
	Next
END IF // reject count 

// RDT 4-22-03 START 
If UpperBound( lsa_DuplicateList[] ) > 0 Then 
	For ll_index = 1 to UpperBound( lsa_DuplicateList[] )
		ls_Work += lsa_DuplicateList[ ll_Index ] + "~n"
	Next
	MessageBox("Validate Vendors", "The Following Vendors Exist in QuickBooks as Customers.~n" + &
											 ls_Work + &
											"~nPlease Specify an Alternate Accounts Payable ID on the Company Settings Tag.")
	goto failure
End If
// RDT 4-22-03 END 

If lb_Continue Then 
	IF ll_RejectCount > 0 THEN			// IF ll_RejectCount = -1 there was an error
		ls_Work = ""
		FOR ll_Index = 1 TO ll_RejectCount
			ls_Work += lsa_RejectList [ ll_Index ] + "~n"
		NEXT
	
		ls_Message = "The following Vendors or Payable Id's do not have a match in "+&
			"QuickBooks:~n" + ls_Work + "Do you want to add these to Quickbooks "+&
			"and proceed with billing?"
	
		IF MessageBox ( ls_MessageHeader, ls_Message, None!, YesNo!, 2 ) = 2 THEN
			ll_RejectCount = -3
		Else																		
			ll_RejectCount = This.of_CreateVendor( lla_RejectIds )
			// RDT 5-26-03 process non entity companies 
			If UpperBound( lla_RejectedCompanyIDs ) > 0 Then 
				IF This.of_CreateVendorCompany( lla_RejectedCompanyIDs[] ) <> 1 THEN
					ll_RejectCount = -1 // 12/21/04 <<*>>
				END IF
			End if

		END IF
	
	END IF
END IF // lb_Continue

RETURN ll_RejectCount 

failure:
ll_RejectCount = -3
RETURN ll_RejectCount 

end function

protected function boolean of_vendorexist (ref string as_name);// RDT 4-23-03 Check for Existing Vendors in QBooks

String	ls_MessageHeader, &
			ls_Work, &
			lsa_RejectList[], &
			ls_Message, &
			ls_Name, &
			ls_StatusSeverity, &
			ls_StatusMessage, &
			ls_VendorRet
			
Integer	li_InvalidCount

Boolean	lb_VendorFound

Long		ll_Row, &
			ll_RejectCount, &
			ll_transactioncount , &
			ll_Index, &
			ll_Vendor_Index, &
			ll_Id, &
			lla_RejectIds[]
			
OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_VendorQuery, &
				lnv_VendorFilter, &
				lnv_NameFilter, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_VendorRet, &
				lnv_VendorRetList, &
				lnv_VendorRetRecord

Boolean		lb_Continue = TRUE 

ll_RejectCount = 0

ls_MessageHeader = "Existing Vendor"

IF IsValid ( inv_Session ) THEN
	lnv_Session = inv_Session
ELSE
	ll_RejectCount = -1 
END IF

IF ll_RejectCount = 0 THEN 
	lnv_RequestSet = lnv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
	
	IF IsValid ( lnv_RequestSet ) THEN
		//OK
	ELSE
		ls_Message = "Quick Books Request Set Invalid. Process Stopped." 
		ll_RejectCount = -1
	END IF
	
END IF

IF ll_RejectCount = 0 THEN 
	
		ls_name = as_name
	
		IF lb_Continue THEN
	
			lnv_RequestSet.ClearRequests ( )
			lnv_RequestSet.Attributes.OnError = ci_roeContinue
			lnv_VendorQuery = lnv_RequestSet.AppendVendorQueryRq ( )
			lnv_VendorFilter = lnv_VendorQuery.ORVendorListQuery.VendorListFilter
			lnv_NameFilter = lnv_VendorFilter.ORNameFilter.NameRangeFilter
			
			lnv_NameFilter.FromName.SetValue ( ls_Name)
			lnv_NameFilter.ToName.SetValue ( ls_Name )

	
			lnv_ResponseSet = lnv_Session.DoRequests ( lnv_RequestSet )
		
			lnv_ResponseList = lnv_ResponseSet.ResponseList
			
			lnv_Response = lnv_ResponseList.GetAt ( 0 )
	
			IF lnv_Response.StatusCode <> 0 THEN
				if lnv_Response.StatusCode = 1 Then // Not found
					lb_VendorFound = FALSE
				else
					ls_StatusSeverity =  String(lnv_response.StatusSeverity) 
					ls_StatusMessage  =  lnv_response.StatusMessage 
						MessageBox(ls_MessageHeader, "Error Severity: " + ls_StatusSeverity &
														 + "~nError Message : " + ls_StatusMessage  )
				end if
			ELSE
				//we may have more than one Vendor 
				//For ll_Vendor_Index = 0 to lnv_ResponseList.Count() -1  //lnv_ResponseList is zero based
				For ll_Vendor_Index = 0 to lnv_Response.Detail.Count() -1

					lnv_VendorRet = lnv_Response.Detail.GetAt( ll_Vendor_Index )
					ls_VendorRet = lnv_VendorRet.Name.GetValue()
					
					If Upper( ls_VendorRet) = Upper( ls_Name ) Then 
						lb_VendorFound = TRUE
						Exit
					Else
						lb_VendorFound = FALSE
					End If
					
				Next
			END IF // lnv_Response.StatusCode <> 0 
		END IF // lb_Continue 

END IF // reject count 


RETURN lb_VendorFound 


end function

protected function integer of_createvendorcompany (long ala_companyid[]);
/***************************************************************************************
NAME			: of_CreateVendorCompany
ACCESS		: Protected
ARGUMENTS	: Long array	(Company Ids)
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Creates a Vendor in QuickBooks from PTools Company data

REVISION		: RDT 02-04-03

***************************************************************************************/
String	ls_MessageHeader, &
			ls_AcctName, &
			ls_Value

String 	ls_StatusSeverity, &
			ls_StatusMessage 

Integer	li_InvalidCount

Integer  li_Return = 1 

Long		ll_Row, &
			ll_ListCount, &
			ll_Ndx, &
			ll_Id, &
			ll_ResponseCode, &
			ll_Upperbound

OleObject	lnv_Session, &
				lnv_RequestSet, &
				lnv_ResponseSet, &
				lnv_VendorQuery, &
				lnv_ResponseList, &
				lnv_Response, &
				lnv_VendorAdd
				
ls_MessageHeader = "Create QuickBooks Vendor from Company Record"
If NOT IsValid( inv_Session ) Then 
	MessageBox(ls_MessageHeader,"Could not create QuickBooks Vendor. ~nConnection Failed to QuickBooks.")
	li_Return = -1
End if


If li_Return = 1 Then 
	lnv_RequestSet = inv_Session.CreateMsgSetRequest ( ii_QBSDK_MajorVersion, ii_QBSDK_MinorVersion )
//	lnv_RequestSet.ClearRequests ( )
//	lnv_RequestSet.Attributes.OnError = ci_roeContinue

	gnv_cst_companies.of_Cache( ala_CompanyId[], TRUE /*refresh*/)	
	n_cst_beo_Company 	lnv_Company 
	lnv_Company = CREATE n_cst_beo_Company
	lnv_Company.of_SetUseCache ( TRUE )
	
	ll_Upperbound = UpperBound( ala_CompanyId[] )
	
	FOR ll_Ndx = 1 TO ll_UpperBound
		lnv_RequestSet.ClearRequests ( )
		lnv_RequestSet.Attributes.OnError = ci_roeContinue

		lnv_Company.of_SetSourceId ( ala_CompanyId[ ll_Ndx ] )

		lnv_VendorAdd = lnv_RequestSet.AppendVendorAddRq ( )
		
		ls_Value = Left ( lnv_Company.of_GetName ( ) , 41)
	
		If NOT IsNull( ls_Value ) Then 
			lnv_VendorAdd.Name.SetValue ( ls_Value )
			lnv_VendorAdd.CompanyName.SetValue ( ls_Value )
		Else
			MessageBox(ls_MessageHeader,"Invalid Vendor Name. Vendor Name is Null")
			li_Return = -1
			Exit
		End If

		ls_Value = Left ( lnv_Company.of_GetAddress1 ( ) , 41 )
		If NOT IsNull( ls_Value ) Then 
			lnv_VendorAdd.VendorAddress.Addr1.SetValue ( ls_Value)
		End If

	
		ls_Value = Left ( lnv_Company.of_GetAddress2 ( ) , 41 )
		If NOT IsNull( ls_Value ) Then 
			lnv_VendorAdd.VendorAddress.Addr2.SetValue ( ls_Value )  
		End If

		ls_Value = Left ( lnv_Company.of_GetCity ( ), 31 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.VendorAddress.City.SetValue ( ls_Value )
		END IF
		
		ls_Value = Left ( lnv_Company.of_GetState ( ), 21 )
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.VendorAddress.State.SetValue ( ls_Value )
		END IF
		
		If lnv_Company.of_GetUSnon ( ) = "U" AND IsNumber( lnv_Company.of_GetZip( ) ) Then 
			ls_Value = lnv_company.of_formatzip ( lnv_Company.of_GetZip ( ))
		Else
			ls_Value = lnv_Company.of_GetZip ( )
		End If
		
		IF NOT IsNull ( ls_Value ) THEN
			ls_Value = Left ( ls_Value , 13 )
			lnv_VendorAdd.VendorAddress.PostalCode.SetValue ( ls_Value )
		END IF
				
		// Fields common to both addresses
		ls_Value = Left ( lnv_Company.of_formatphone1 ( ), 21 ) 
		IF NOT IsNull ( ls_Value ) THEN
			lnv_VendorAdd.Phone.SetValue ( ls_Value ) 
		END IF
		
		lnv_ResponseSet = inv_Session.DoRequests( lnv_RequestSet )	
		// Error Check 
		lnv_ResponseList = lnv_ResponseSet.ResponseList
		If IsNull( lnv_ResponseList ) Then 
			// do nothing
		Else
			lnv_Response = lnv_ResponseList.GetAt ( 0 )
			ll_ResponseCode = lnv_Response.StatusCode 
			
			Choose Case ll_ResponseCode 
				Case 0 
					// no errors continue 
					
				Case 3100
					// duplicate entry 
					MessageBox( ls_MessageHeader, "The name '" + lnv_Company.of_GetName ( ) + "' exists in QuickBooks. "+ &
									"~nPlease change the Company in Profit Tools and run the process again.")
					li_Return = -3
					Exit
					
				Case Else
					ls_StatusSeverity = String(lnv_response.StatusSeverity) 
					ls_StatusMessage  = lnv_response.StatusMessage 
					MessageBox(ls_MessageHeader,"Severity: "+ ls_StatusSeverity + "~n" + ls_StatusMessage +"~nCode: "+String(ll_ResponseCode) )
					li_Return = -3
					Exit
					
			End Choose

		End If
	NEXT

	Destroy lnv_Company 

End If

Return li_Return 
end function

protected function integer of_setnamerangefilterforaccount (string as_account, ref oleobject anv_filter);


String	ls_Account
String	ls_From
String	ls_To
Long		ll_From
Long		ll_To


ls_Account = as_account

IF isNumber ( ls_Account ) THEN
	
	ll_From = Long ( ls_Account )
	ll_To = ll_From + 1
	
	ls_From = String ( ll_From )
	ls_To = String ( ll_To )
	
ELSE
	
	ls_From = ls_Account
	ls_To = ls_Account
	
END IF

anv_filter.FromName.SetValue	( ls_From )
anv_filter.ToName.SetValue ( ls_To )


RETURN 1


/*  HERE IS WHY WE NEED TO DO IT THIS WAY 

Okay, based on what I found from engineering, if you have 
'Use account number' turned on & Account name = Account Receivable with Account number=1200
exists in QB_2006_Premier_US, The following request XML does not work: -


<?xml version="1.0"?>
<?qbxml version="2.0"?>
<QBXML>
<QBXMLMsgsRq onError = "continueOnError">
<AccountQueryRq requestID = "0">
<NameRangeFilter>
<FromName>1200</FromName>
<ToName>1200</ToName>
</NameRangeFilter>
</AccountQueryRq>
</QBXMLMsgsRq>
</QBXML>

But following works: -

<?xml version="1.0"?>
<?qbxml version="2.0"?>
<QBXML>
<QBXMLMsgsRq onError = "continueOnError">
<AccountQueryRq requestID = "0">
<NameRangeFilter>
<FromName>1200</FromName>
<ToName>1201</ToName>
</NameRangeFilter>
</AccountQueryRq>
</QBXMLMsgsRq>
</QBXML>


This is what QB thinks is the FullName when it’s doing the filtering:
"1200 · Accounts Receivable”
This string is greater than “1200”, but less than “1201”.  
When we build the FullName in the response, we return the version of the
FullName that has no account number in it..   


So, if it worked with previous versions of QB (before QB_2006_Premier_US) it would be because it is a *bug in previous versions* that has been fixed in QB_2006_Premier_US.  It has been documented in SDK 5.0 release notes as follows (see under Bugs Fixed): -


Bugs Fixed in This Release
In the past, if you specified a RefNumberRangeFilter and gave a
"ToRefNumber" of "A", you would get back records whose RefNumbers
started with "A", such as "AAF001", "AF-CM-01", etc. This behavior was
incorrect, as "AAF001" is NOT lexicographically less than "A". In
QuickBooks 2006, the transaction queries will have the corrected
behavior.

Therefore, our suggestion for you would be to use one of the three solutions I suggested so far: -
1) If possible, do not use Account numbers, use Account names 
2) If 1) is not possible, use request as follows: 
<?xml version="1.0"?>
<?qbxml version="2.0"?>
<QBXML>
<QBXMLMsgsRq onError = "continueOnError">
<AccountQueryRq requestID = "0">
<NameFilter>
<MatchCriterion>Contains</MatchCriterion>
<Name>1200</Name>
</NameFilter>
</AccountQueryRq>
</QBXMLMsgsRq>
</QBXML>

 

3) If 2) is not possible, use request as follows:

<?xml version="1.0"?>
<?qbxml version="2.0"?>
<QBXML>
<QBXMLMsgsRq onError = "continueOnError">
<AccountQueryRq requestID = "0">
<NameRangeFilter>
<FromName>1200</FromName>
<ToName>1201</ToName>
</NameRangeFilter>
</AccountQueryRq>
</QBXMLMsgsRq>
</QBXML>

 

However, please note that end user would need to have “Use account number” set in preferences
before solution 2) or 3) would work.  So, you may want to do a PreferencesQueryRq 
first, to see what the value of IsUsingAccountNumbers is.  
Then do #1 if it’s false, or #2 or #3 if it’s true.


Thanks!
- Iqbal
*/

end function

on n_cst_acctlink_quickbooks_direct.create
call super::create
end on

on n_cst_acctlink_quickbooks_direct.destroy
call super::destroy
end on

event constructor;call super::constructor;/* These notes are also in the decendants
QBFC2 can issue qbXML 1.1 and 1.0 requests to QuickBooks 2002, you do that by setting the version of 
qbXML you want QBFC to generate in your call to CreateMsgSetRequest, providing the major and minor 
version numbers:

CreateMsgSetRequest(2,0)  will return an IMsgSetRequest for qbXML 2.0 (QuickBooks 2003)

CreateMsgSetRequest(1,1)  will return an IMsgSetRequest for qbXML 1.1 (QuickBooks 2002 R2 and later)

CreateMsgSetRequest(1,0)  will return an IMsgSetRequest for qbXML 1.0 (QuickBooks 2002 R1)

You can tell the version of QuickBooks you have by holding down CTRL and typing "1" while in the QuickBooks UI.
*/




// QuickBooks uses the Entity Name, not ID, to find accounts and customers. 
ib_DirectConnect = TRUE
end event

