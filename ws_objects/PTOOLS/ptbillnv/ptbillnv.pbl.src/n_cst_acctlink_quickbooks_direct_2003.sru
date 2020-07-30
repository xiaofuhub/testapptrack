$PBExportHeader$n_cst_acctlink_quickbooks_direct_2003.sru
$PBExportComments$[n_cst_AcctLink_QuickBooks_Direct]
forward
global type n_cst_acctlink_quickbooks_direct_2003 from n_cst_acctlink_quickbooks_direct
end type
end forward

global type n_cst_acctlink_quickbooks_direct_2003 from n_cst_acctlink_quickbooks_direct
end type
global n_cst_acctlink_quickbooks_direct_2003 n_cst_acctlink_quickbooks_direct_2003

forward prototypes
protected function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
end prototypes

protected function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);
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

This Version uses QBFC 2.0 and will allow users to apply the AP distribution to a spicific account
 ( APAccountRef.FullName.SetValue ) 
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

	ll_division = anva_accountingdata[1].of_GetShipType()
	
	//By this point prior edit checking will have made sure that all divisions 
	//have the same posting company
	
	lnv_ShipType.Of_SetSourceId ( ll_division )
	ls_AccountingCompany = lnv_ShipType.Of_GetAccountingCompany ()
	
	if this.of_Link_Open(ls_AccountingCompany) = 1 Then 
		lnv_Session = inv_Session
	else
		ls_MessageContext = "Can not connect to QuickBooks."
		li_return = -1
	end if

	destroy (lnv_ShipType)
	
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
				lnv_AddRecord.VendorRef.FullName.SetValue( ls_EntityId )
				lnv_AddRecord.TxnDate.SetValue ( string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY") )
				If Len ( Trim( lnv_accountingdata.of_getDescription ( )	) ) > 0 Then 
					lnv_AddRecord.Memo.SetValue (  lnv_accountingdata.of_getDescription ( )	 )
				End If
				lnv_AddRecord.RefNumber.SetValue ( string(lnv_accountingdata.of_GetDocumentNumber ( )	) )  //DocumentNumber (check)
				// Get AP ACCOUNT THIS ONLY WORKS IN QBFC 2.0
				lnv_accountingdata.of_GetDistributionAPaccount ( lsa_Value )
				ls_Value = lsa_Value [1] // use first one as they should all be the same
				If Len ( Trim( ls_Value ) ) > 0 Then 
					lnv_AddRecord.APAccountRef.FullName.SetValue( ls_Value )
				End if
		
				//credits	
				lnv_AddCredit.VendorRef.FullName.SetValue( ls_EntityId )
				lnv_AddCredit.TxnDate.SetValue ( string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY") )
				If Len ( Trim( lnv_accountingdata.of_getDescription ( )	) ) > 0 Then 
					lnv_AddCredit.Memo.SetValue (  lnv_accountingdata.of_getDescription ( )	 )
				End If
				lnv_AddCredit.RefNumber.SetValue ( string(lnv_accountingdata.of_GetDocumentNumber ( )	) )  //DocumentNumber (check)
				// Get AP ACCOUNT THIS ONLY WORKS IN QBFC 2.0
				lnv_accountingdata.of_GetDistributionAPaccount ( lsa_Value )
				ls_Value = lsa_Value [1] // use first one as they should all be the same
				If Len ( Trim( ls_Value ) ) > 0 Then 
					lnv_AddCredit.APAccountRef.FullName.SetValue( ls_Value )
				End if
				
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
				lnv_AddRecord.RefNumber.SetValue ( string(lnv_accountingdata.of_GetDocumentNumber ( )	) )  //DocumentNumber (check)
			Case Else 
				MessageBox("Program Error","n_cst_AcctLink_quickbooks_Direct.ofDataLoad() ~nCase3: "+Upper(ls_category)+" : not coded:")
				li_Return = -1	
		End Choose
		
		//Make Distribution entries
		li_RecordCnt = 0
		li_CreditCnt = 0
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
						MessageBox("Quick Books AP Record Create Error ", ls_StatusSeverity + "~n" + ls_StatusMessage  )
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

on n_cst_acctlink_quickbooks_direct_2003.create
call super::create
end on

on n_cst_acctlink_quickbooks_direct_2003.destroy
call super::destroy
end on

event constructor;call super::constructor;/*
QBFC2 can issue qbXML 1.1 and 1.0 requests to QuickBooks 2002, you do that by setting the version of 
qbXML you want QBFC to generate in your call to CreateMsgSetRequest, providing the major and minor 
version numbers:

CreateMsgSetRequest(2,0)  will return an IMsgSetRequest for qbXML 2.0 (QB2003)

CreateMsgSetRequest(1,1)  will return an IMsgSetRequest for qbXML 1.1 (QB 2002 R2 and later)

CreateMsgSetRequest(1,0)  will return an IMsgSetRequest for qbXML 1.0 (QB 2002 R1)

You can tell the version of QuickBooks you have by holding down CTRL and typing "1" while in the QuickBooks UI.
*/

//Initialize instance variables to record which QBSDK version

ii_QBSDK_MajorVersion = 2
ii_QBSDK_MinorVersion = 0
is_QBSDK_COMObject = "QBFC2.QBSessionManager"

ib_directconnect = TRUE
end event

