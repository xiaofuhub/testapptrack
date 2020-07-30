$PBExportHeader$n_cst_acctlink_peachtree.sru
forward
global type n_cst_acctlink_peachtree from n_cst_acctlink
end type
end forward

global type n_cst_acctlink_peachtree from n_cst_acctlink
end type
global n_cst_acctlink_peachtree n_cst_acctlink_peachtree

forward prototypes
public function integer of_batch_create (n_cst_msg anv_cst_msg)
public function integer of_validate_customers (datastore ads_list)
public function integer of_importfile (ref datastore ads_work, string as_filepath)
public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_cancelwarning)
private subroutine of_olddataload ()
private function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
protected function integer of_insertheaders (ref datastore ads_work, string asa_data[], long al_beforerow)
protected function integer of_appendtofile (datastore lds_work, string as_filename)
protected function datastore of_datainitialization (string asa_transcolumns[])
end prototypes

public function integer of_batch_create (n_cst_msg anv_cst_msg);
/*================================================================================ 
                	of_Batch_Create ( n_cst_msg )   For peachtree
			
			
	This function produces a batch with coma separated values (csv) for Peachtree.
	PeachTree allows one distribution per line.
							
	Return Values:
							1 = Success
						  -1 = Failure 
						  -2 = User Chose no AR Batch	
	
===============================================================================*/



Long		ll_trns
Long		ll_TransCount
Long		ll_dist
Long		ll_DistCount
Long		ll_err_SkipCount
Long		ll_Row
Long		ll_TransactionColumnCount
Long 		ll_SalesDistCount
Long 		j

Int		li_ndx
Int		li_DistIndex
Int		li_Result
Int		li_Winner
Int		li_MsgCount
Int		i
Int		li_RefCount
Int		li_UseDefaultRtn
Int		li_BatchFolderRtn
Int		li_AppendRtn
Int		li_ImportRtn
Int		li_AppendReturn

Dec {2} 	lc_Check

Boolean	lb_UseDefault
Boolean	lb_Repeat
Boolean	lb_Append


String	ls_Err_Skiplist
String	ls_work1
String	ls_Message
String	ls_BatchType
String	ls_AR_Account
String	ls_BatchFile
String	ls_BatchFilePath
String	ls_BatchFolderRtn
String	ls_Path

String	ls_Title
String	ls_PathName
String	ls_FileName
Constant String	ls_Extension = "csv"
String	ls_Filter
String	ls_CancelWarning

String	ls_MessageHeader
String	ls_Reject

String	lsa_Transaction_Columns[]
String	lsa_Distribution_Columns[]

String	lsa_Check[]
String	lsa_Empty[]

String	ls_Value

String 	ls_POLabels
s_Parm		lstr_Parm
n_cst_File	lnv_File
DataStore	lds_Work
DataStore	lds_Temp

s_accounting_transaction lstra_trns[]
s_accounting_distribution lstr_dist



ls_MessageHeader = "Create AR Batch"
ls_Reject = "Could not create AR batch."

ls_PoLabels = THIS.of_Getpolabels( )

// Extract Parameters from message object that was passed in.

li_msgCount = anv_cst_msg.of_get_count ( )

FOR li_ndx = 1 TO li_msgCount
	
	IF anv_cst_msg.of_get_parm ( li_ndx , lstr_parm ) > 0 THEN
		
		CHOOSE CASE lstr_parm.is_label
				
		CASE "BATCH_TYPE"
			ls_BatchType = lstr_Parm.ia_Value
			
		CASE "TRANSACTION" 
			lstra_Trns [ upperbound ( lstra_trns ) + 1 ] = lstr_parm.ia_Value 
			
	   END CHOOSE
		
	END IF
	
NEXT

//Validate requested batch type

CHOOSE CASE ls_batchType
		
CASE "SALES!"
	// Batch Type is OK
	
CASE ELSE
	
	GOTO Failure
	
END CHOOSE



// Get Batch file name
li_UseDefaultRtn = THIS.of_UseDefaultBatchName ( )

//           1 = Success, YES!
//				 2 = Success, NO!
//				 3 = success, ASK!
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

CHOOSE CASE li_useDefaultRtn
	CASE -1 ,0 ,3
		IF	MessageBox ( "Default Batch Name" , "Do you wish to use the default batch name?", QUESTION!, YESNO!, 1 ) = 1 THEN
			lb_useDefault = TRUE
		END IF
	
	CASE 1  // yes, use default
		lb_UseDefault = TRUE	
		
	CASE 2  // No, don't use default 
		lb_UseDefault = FALSE
		
END CHOOSE


li_BatchFolderRtn = THIS.of_GetssBatchFolderName ( ls_Path )
IF lb_UseDefault THEN
	IF li_BatchFolderRtn = -2 THEN
		messageBox ( "Folder Location" , "The folder specified in the system settings '" + ls_Path + &
		    "' does not exist. Please select a folder from the following dialog box." )
	END IF
END IF

	 
IF ( Not lb_UseDefault )OR li_BatchFolderRtn <> 1 THEN
	
	ls_PathName = String ( Now ( ), "mmddhhmmss") + ".csv"
	
	IF li_BatchFolderRtn = 1 THEN
		ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + ".csv"
	END IF

		
	ls_Title = "Specify Batch File Location"
	
	ls_FileName = ""
	ls_filter = "CSV FILES (*.csv), *.csv" // "CSV Files (*.csv), *.csv
	
	ls_CancelWarning =  "You have indicated that you do not wish to create an AR Batch.~n~n"+&
		"PLEASE NOTE: The bills have already been processed, and you will not be able to "+&
		"recreate an AR Batch for them later."
	

	IF THIS.of_GetFileSaveName ( ls_Title , ls_PathName , ls_FileName , ls_Extension, &
		ls_Filter, ls_cancelWarning ) = -1 THEN
		
		RETURN -2  //\\//\\    MID CODE RETURN HERE !!!  \\//\\//\\//\\//
		
	END IF

ELSE
	ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	ls_FileName = String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	
END IF


ls_BatchFile = ls_FileName
ls_BatchFilePath = ls_PathName


// Initialize Transaction and Distribution column arrays

lsa_Transaction_Columns = {"Customer ID" , "Invoice #" , "Date" , "Customer PO" , "Ship Date" , "Date Due", &
								  "Accounts Receivable Account" , "Invoice Note" , "Number of Distributions" , &
								  "Quantity" , "Description" , "G/L Account" , "Tax Type" , "Amount", "Sales Tax Authority" }
								  
ll_TransactionColumnCount = UpperBound ( lsa_Transaction_Columns )



lds_Work = of_CreateBatchDataStore ( ll_TransactionColumnCount )

IF NOT isValid ( lds_Work ) THEN
	
	GOTO FAILURE
	
END IF

// added for append
DO
	IF FileExists ( ls_pathname ) THEN
		lb_Repeat = TRUE
		li_AppendRtn = MessageBox ( "Batch Location" , "The specified file (" + ls_pathname + ") already exists. Do you want to append the new file to the existing file?~r~nSelect YES to append.~r~nSelect NO to choose another file name." , QUESTION!, YESNO! , 1 )
		CHOOSE CASE li_AppendRtn
				
			CASE 1
				
				lb_Append = TRUE
				lb_Repeat = FALSE
				
			CASE 2
	
				ls_FileName = ""
				IF THIS.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
					ls_Filter, ls_CancelWarning ) = -1 THEN
						RETURN -2
				END IF
		END CHOOSE
		
	ELSE
		lb_Repeat = FALSE
	END IF
	
LOOP WHILE lb_Repeat


//// end of added for append


IF Not lb_append THEN 
	// Put Column Headers into DataStore
	
	SetPointer ( HOURGLASS! )
	THIS.of_InsertHeaders ( lds_Work , lsa_Transaction_Columns, 0  )

END IF
//load transaction information into dataStore

ll_transCount = UpperBound ( lstra_Trns )
FOR ll_Trns = 1 TO ll_TransCount
	
	// check for Valid Company
	
	// Check for AR account
	
	lsa_Check = lsa_Empty
	//changed this from 0 to -1 to allow 0 amounts to be posted
	lc_check = -1
	li_Winner = 0
	ll_SalesDistCount = 0
	
	ll_DistCount = upperBound ( lstra_trns[ ll_trns ].istra_distributions )
	For ll_Dist = 1 TO ll_DistCount
		
		lstr_dist = lstra_trns[ ll_trns ].istra_distributions[ ll_Dist ]
		
		IF lstr_dist.ib_Credit THEN  // This counts the # of SALES distributions used in the Import File.
			ll_SalesDistCount ++      // The column denotes the # of SALES Distributions for a single 
		END IF							  // transaction.
		
		//NOTE: the following approach assumes a credit amount to be SALES, and a debit
		//amount to be RECV.  This is probably not an adequate long-term approach. 
		
		IF lstr_Dist.ib_Credit = FALSE THEN
			lsa_Check[ upperbound ( lsa_Check ) + 1 ] = lstr_Dist.is_Account
			IF lstr_Dist.ic_amount > lc_Check THEN
				lc_Check = lstr_Dist.ic_amount
				li_Winner = upperBound ( lsa_Check )
			END IF
		END IF
		
	NEXT
	
	
	IF li_Winner = 0 THEN
		ll_Err_SkipCount ++ 
		IF Len( ls_Err_SkipList ) > 0 THEN ls_err_SkipList += ", "
		ls_Err_skipList += lstra_trns[ ll_trns ].is_Document_Number
		CONTINUE
	ELSE
		ls_ar_account = lsa_Check[ li_Winner ]
	END IF
	
	
	IF upperBound ( lsa_Check ) > 1 THEN
		MessageBox( ls_MessageHeader , "The invoice " + lstra_trns[ ll_trns ].is_Document_Number + &
			" has multiple AR distributions associated with it. This is not permited in Peachtree." + &
			" The account " + ls_ar_account + " will be used for the full invoice amount. ")
	END IF
	

	// Make Transaction Entries
	
	FOR li_DistIndex = 1 TO ll_DistCount  // Peachtree puts 1 distribution per line.
													 //  This loop puts in each distribution.
													 
		IF lstra_trns [ ll_trns ].istra_distributions[li_DistIndex].ib_credit = FALSE THEN CONTINUE
			
		ll_Row = lds_Work.insertRow ( 0 ) 
		
		FOR li_ndx = 1 TO ll_TransactionColumnCount  // This Loop fills in the columns for a single
																	// SALES distribution

			ls_value = ""
			
			CHOOSE CASE lsa_Transaction_columns[ li_ndx ]
			CASE "Customer ID"
				ls_Value = lstra_trns[ ll_trns ].is_Company_Code
				
			CASE "Invoice #"
				ls_Value = lstra_trns[ ll_trns ].is_document_number
				
			CASE "Date"
				ls_Value = String( lstra_trns[ ll_trns ].id_document_date , "mm/dd/yy" )
				
			CASE "Customer PO"
				//ls_Value = ""
				ls_Value = THIS.of_Getreferencenumbersbylabel( lstra_trns[ ll_trns ], ls_POLabels )
				
			CASE "Ship Date"
				ls_Value = ""
				
			CASE "Date Due"
				ls_Value = String( lstra_trns[ ll_trns ].id_payment_due , "mm/dd/yy" )
				
			CASE "Accounts Receivable Account"
				ls_Value =  ls_ar_account 
		
			CASE "Invoice Note"
				ls_Value = ""
				
			CASE "Number of Distributions"
				// check for sales only
				// calculated above		
				ls_Value = String ( ll_SalesDistCount ) 		
				
			CASE "Quantity" 
				ls_Value = String( 0 )
				
			CASE "Description" 
				
				ls_Value = of_GetReferenceList( lstra_trns [ ll_trns ] )  
				
				//peachtree has a limit of 2000 characters in this field
				if len(ls_value) > 1999 then
					ls_value = left(ls_value,1999)
				end if
			
			CASE "G/L Account"
				ls_Value = String ( lstra_trns [ ll_trns ].istra_Distributions[ li_DistIndex ].is_Account )
		
			CASE "Tax Type"
				ls_Value = string (1)
				
			CASE "Amount"
				ls_Value = String (  -1 *  lstra_trns [ ll_trns ].istra_Distributions[ li_DistIndex ].ic_amount , "0.00" ) 
			
			CASE "Sales Tax Authority"
				ls_value = ""
			
			CASE ELSE 
				ls_Value = ""
				
			END CHOOSE
			
			lds_Work.object.data.Primary [ ll_Row , li_ndx ] = ls_Value
			
			
		NEXT
		
	NEXT

NEXT



IF lb_Append THEN
	li_AppendReturn = THIS.of_AppendToFile ( lds_Work , ls_PathName ) 
	
	IF li_AppendReturn <> 1 THEN  // append failed
	
		ls_PathName = "" // force save dialog. 
	
		MessageBox("Append to File" , "An error occurred while attempting to append to the existing file. Please select another file to save you batch. This will not append to the selected file." )
		IF lnv_File.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
				ls_Filter, ls_CancelWarning ) = -1 THEN
				RETURN -2
		END IF	
		
		THIS.of_InsertHeaders ( lds_Work , lsa_Transaction_Columns , 1 ) 

	END IF
	
END IF

IF ( Not lb_Append ) OR ( li_AppendReturn ) <> 1 THEN
	// Export Contents of DataStore to Batch File

	Do 
		li_Result = lds_Work.SaveAs( ls_PathName , CSV! , FALSE )
		
		IF li_Result = -1 THEN 
			IF MessageBox ( ls_MessageHeader , "Could not save batch file." , EXCLAMATION! , &
					RetryCancel! , 1 ) = 2 THEN
					ls_Reject = ""
					GOTO FAILURE
			END IF
		END IF
		
	LOOP UNTIL li_Result = 1

END IF
// Inform User of any invoices that were not included in the batch

IF ll_err_SkipCount > 0 THEN
	IF ll_err_SkipCount = 1 THEN
		ls_Work1 = "invoice was"
	ELSE
		ls_Work1 = String ( ll_Err_SkipCount ) + " invoices were"
	END IF
	
	IF len( ls_Message ) > 0 THEN ls_Message += "~n~n"
	ls_Message += "The following " + ls_Work1 + " not included in the AR batch because of" + &
					" processing errors: ~n~n" + ls_Err_skipList
	MessageBox ( "Notes on AR Batch" , ls_Message )
END IF

destroy lds_Work



Return 1

//\\//\\//\\//\\//\\  Failure //\\//\\//\\//

Failure:

IF len ( ls_Reject ) > 0 THEN 
	messageBox ( ls_messageHeader , ls_Reject , EXCLAMATION! )
END IF

Destroy lds_work 
RETURN -1


end function

public function integer of_validate_customers (datastore ads_list);RETURN of_ValidateCustomerFile ( ads_List )

end function

public function integer of_importfile (ref datastore ads_work, string as_filepath);// switch the file name to a .txt  Import the file and switch the name back to its original 
// file name
String	ls_SourceFile 
String	ls_TargetFile
Boolean	lb_Renamed
Int		li_ImportRtn
Int		li_Return = -1

ls_SourceFile = as_FilePath
//ls_TargetFile = Left ( Trim ( as_FilePath ), ( Len ( Trim ( as_FilePath ) ) - 3 ) ) + "txt"

n_cst_fileSrvWin32	lnv_FileSrv
lnv_FileSrv = CREATE n_cst_fileSrvWin32

//IF lnv_FileSrv.of_FileRename ( ls_SourceFile , ls_TargetFile ) = 1 THEN
	
	lb_Renamed = TRUE
	li_ImportRtn = ads_Work.ImportFile ( ls_SourceFile )
	IF li_ImportRtn >= 1 THEN  //  There should be 1 header rows. if not they will be able to select another file.
		li_Return = 1 // success here
	END IF
	
//END IF
//
//IF lb_Renamed THEN  // even if the import fails we still want to rename the file back
//	 lnv_FileSrv.of_FileRename ( ls_TargetFile , ls_SourceFile   )
//END IF
	
DESTROY  lnv_FileSrv  
RETURN li_Return
end function

public function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_cancelwarning);// THIS should be moved to the file srv object in core. 
//Return Values : 1 = Success (values returned in as_PathName and as_FileName ), 
//						-1 = Failure, or User-Initiated Cancel (user has to "approve" failure)

String	ls_PathName, &
			ls_FileName, &
			ls_Message
Integer	li_Result

ls_PathName = as_PathName
ls_FileName = ""

as_PathName = ""
as_FileName = ""

DO

	li_Result = GetFileSaveName ( as_Title, ls_PathName, ls_FileName, as_Extension, as_Filter )

	CHOOSE CASE li_Result
	CASE 1
		// success
	CASE ELSE
		IF li_Result = 0 THEN
			//User chose cancel in filename dialog.  Proceed to warning.
		ELSE
			//There was an error in filename dialog.
			IF MessageBox ( as_Title, "Error attempting to determine filename.", &
				Exclamation!, RetryCancel!, 1 ) = 1 THEN
					ls_FileName = ""
					CONTINUE
			END IF
		END IF

		IF IsNull ( as_CancelWarning ) THEN

			//No cancel warning required

			RETURN -1

		ELSE

			//Issue cancel warning

			ls_Message = as_CancelWarning
			IF Len ( ls_Message ) > 0 THEN
				ls_Message += "~n~n"
			END IF
			ls_Message += "Are you sure you want to cancel?"

			IF MessageBox ( "Cancel File Create", ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
				ls_FileName = ""
				CONTINUE
			ELSE
				RETURN -1
			END IF
		END IF

	END CHOOSE

LOOP UNTIL Len ( ls_FileName ) > 0

as_FileName = ls_FileName
as_PathName = ls_PathName

RETURN 1
	
end function

private subroutine of_olddataload ();//SetPointer(HourGlass!)
//
//Boolean	lb_Found
//
//String	ls_ar_account, &
//			ls_TransType, &
//			lsa_transaction_columns[], &
//			lsa_Account [], &
//			lsa_DistributionAccounts [], &
//			ls_value, &
//			ls_reject, &
//			ls_Error_SkipList, &
//			ls_messageheader, &
//			ls_MessageContext, & 
//			ls_type, &
//			ls_work1, &
//			ls_message, &
//			ls_pathname, &
//			ls_filename, &
//			ls_entityid, &
//			ls_Path, &
//			ls_FindString, &
//			ls_EntityName, &
//			ls_TransactionAccount, &
//			ls_DistributionAccount
//
//Integer	li_Return, &
//			li_winner, &
//			li_ndx, &
//			li_result, &
//			li_amount_category, &
//			li_PayablesFolderRtn, &
//			li_Division, &
//			li_AmountType, &
//			li_DistributionLine
//
//Long		ll_TransactionCount, &
//			ll_DistributionCount, &
//			ll_trns, &
//			ll_distIndex, &
//			ll_err_skipcount, &
//			ll_TransactionColumnCount, &
//			ll_row, &
//			ll_Winner, &
//			ll_dist, &
//			ll_Findrow
//			
//Dec {2}	lc_check, &
//			lc_PreNetCheck, &
//			lc_amountowed, &
//			lca_DistributionTotals []
//
//
//			
//datastore					lds_work, &
//								lds_AccountMap
//								
//n_cst_constants			lnv_Constants
//n_cst_beo_Transaction	lnv_CurrentTransaction
//n_cst_beo_AmountOwed		lnva_AmountsOwed [ ]
//n_cst_beo_AmountOwed		lnv_CurrentAmountOwed
//n_cst_beo_AmountType		lnv_CurrentAmountType
//n_cst_beo_Entity			lnv_CurrentEntity
//n_cst_dws					lnv_dws
//n_cst_string				lnv_string			
//
//li_Return = 1
//
//Choose case upper( as_category )
//	case "PAYABLES"
//		ls_type = "AP"
//		ls_MessageContext = "AP"
//		lsa_Transaction_Columns = { &
//							"Vendor ID" 	, &
//							"Invoice #" 	, &
//							"Date" 			, &
//							"Date Due"		, &
//							"Accounts Payable Account" , &
//							"Number of Distributions" , & 
//							"Quantity" 		, &
//							"Description" 	, &
//							"G/L Account" 	, &
//							"Amount" 		} 
//							
//		
//							
//	case "RECEIVABLES"
//		ls_type = "AR"
//		ls_MessageContext = "AR"
//		lsa_Transaction_Columns = { &
//							"Customer ID" 	, &
//							"Invoice #" 	, &
//							"Date" 			, &
//							"Customer PO" 	, &
//							"Ship Date" 	, &
//							"Accounts Receivable Account" , &
//							"Invoice Note" , &
//							"Number of Distributions" , & 
//							"Quantity"		, &
//							"Description" 	, &
//							"G/L Account" 	, &
//							"Tax Type" 		, &
//							"Amount"			, &
//							"Sales Tax Authority" } // Required
//	case "PAYROLL"
//		ls_type = "PR"
//		ls_MessageContext = "PR"
//		lsa_Transaction_Columns = { &
//							"Employee ID" 	, &
//							"Date" 			, &
//							"Cash Account" , &
//							"Pay Period End", &
//							"Number of Distributions" , & 
//							"Pay Field-Number", &
//							"Pay Field-Account", &
//							"Pay Field-Expense Account", &
//							"Pay Field-Amount", &
//							"Pay Field-Memo Amount"} 
//end choose
//
//ls_MessageHeader = "Create " + ls_MessageContext +" Batch"
//ls_Reject = "Could not create " + ls_MessageContext + " batch."
//ll_TransactionColumnCount = UpperBound ( lsa_Transaction_Columns )
//ll_TransactionCount = upperBound	( anva_Transactions )
//
////Get Batch File Name
//IF li_Return = 1 THEN
//	li_Return = this.of_getbatchfilename("csv",ls_MessageContext, ls_filename, ls_pathname)
//	//	returns 1 (success) or -1 (failure)
//END IF
//
//lnv_dws.of_CreateDataStoreByDataObject ( "d_dlkc_accountmap", lds_AccountMap, FALSE )
//lds_AccountMap.Retrieve()
//
//IF li_Return = 1 then
//	lds_work = this.of_datainitialization( lsa_transaction_columns [] )
//	IF NOT IsValid ( lds_Work ) THEN
//		li_Return = -1
//	END IF
//END IF
//
//IF li_Return = 1 THEN
//
//	SetPointer ( HOURGLASS! )
//	
//	//load transaction information into dataStore
//
//	FOR ll_Trns = 1 TO ll_TransactionCount
//		
//		li_DistributionLine = 0
//		
//		// Put Current Transaction Into Local Variable
//		lnv_CurrentTransaction = anva_transactions [ ll_Trns ]
//		
//		// Get all associated AmountsOwed into Array lnva_AmountsOwed
//		lnv_CurrentTransaction.of_GetAmountsList ( lnva_AmountsOwed )
//		ll_DistributionCount = UpperBound ( lnva_AmountsOwed )
//		
//		// load current Entity
//		lnv_CurrentEntity = lnv_CurrentTransaction.of_GetEntity ( ) 
//		
//		IF NOT isValid ( lnv_CurrentEntity ) THEN
//			li_Return = -1
//		END IF
//					
//		//Get account from amountowed type with greatest amount
//		
//		lc_check = 0
//		ll_winner = 0
//		for ll_dist = 1 to ll_DistributionCount
//			lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Dist ]
//			lc_AmountOwed = lnv_CurrentAmountOwed.of_GetAmount ( )
//			IF lc_AmountOwed > lc_check then
//				lc_check = lnv_CurrentAmountOwed.of_GetAmount ( ) 
//				ll_winner = ll_Dist
//			end if
//		next
//
//		if ll_winner = 0 then
//			//error msg
//			continue
//		end if
//
//		/*	 An accountmap should be found. These were already validated.	*/ 
//		lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_winner ]
//		li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
//		li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
//		ls_FindString = "accountmap_division = " + string ( li_Division ) + &
//							" and accountmap_amounttypeid = " + string ( li_AmountType )
//		ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
//	
///*  If we want to use this method for receivables 
//		then we will have to copy the 	//Check for AR account
//		
//		logic fron of_batch_create
//*/
//
//		IF ll_FindRow > 0 THEN
//			CHOOSE CASE ls_type
//				CASE "AP"
//					ls_EntityName = lnv_CurrentEntity.of_GetPayablesId ( )
//					ls_TransactionAccount = lds_AccountMap.Object.accountmap_apaccount[ll_FindRow]
//		
//				CASE "AR"
//		//			ls_EntityName = lnv_CurrentEntity.of_GetReceivablesId ( )
//		//			ls_TransactionAccount = lds_AccountMap.Object.accountmap_araccount[ll_FindRow]
//		
//				CASE "PR"
//					ls_EntityName = lnv_CurrentEntity.of_GetPayrollId ( )
//					ls_TransactionAccount = lds_AccountMap.Object.accountmap_payrollcashaccount[ll_FindRow]
//		
//			END CHOOSE
//		end if
//	
//		// Now loop through all the distributions for the current transaction and populate all 
//		// the column fields.
//		
//		// Make Transaction Entries
//		
//		
//		/*	For payroll we need to be able to control the distribution lines for the check
//			if we want to keep track of taxable and non-taxable amounts
//			Round up sums by distribution line entered in account map	
//			for payroll expense account we will parse the payrollexpenseaccount
//			into distribution line and expense account,  then sum all of the distribution lines	
//		*/
//		IF ls_Type = "PR" THEN
//			FOR ll_DistIndex = 1 TO ll_DistributionCount
//				lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_DistIndex ]
//				// Get Current Amount Owed
//				li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
//				li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
//				ls_FindString = "accountmap_division = " + string ( li_Division ) + &
//									" and accountmap_amounttypeid = " + string ( li_AmountType )
//				ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
//				
//				// get account
//				IF ll_FindRow > 0 THEN
//					ls_DistributionAccount = lds_AccountMap.Object.accountmap_payrollexpenseaccount[ll_FindRow]
//					//parse account 1st entry is distribution line and 2nd entry is expense account
//					lnv_string.of_ParseToArray ( ls_DistributionAccount, ",", lsa_account )
//					IF upperbound ( lsa_account ) <> 2 or &
//						isnull ( lsa_account [1] ) or &
//						len ( lsa_account [1] ) = 0 THEN
//						// put in 1st distribution line 
//							lsa_DistributionAccounts [1] = lsa_Account [2]
//							lca_DistributionTotals [1] +=	lnv_CurrentAmountOwed.of_GetAmount ( )
//					ELSE
//						IF li_DistributionLine > 0 THEN
//						//did we already get this line before
//							lb_found = FALSE
//							FOR li_ndx = 1 to li_DistributionLine
//								IF integer ( lsa_Account [1] ) = li_ndx THEN
//									lca_DistributionTotals [li_DistributionLine] +=	lnv_CurrentAmountOwed.of_GetAmount ( )
//									lb_found = TRUE
//								END IF
//							NEXT
//							IF not lb_Found THEN
//								li_DistributionLine ++
//								lsa_DistributionAccounts [li_DistributionLine] = lsa_Account [2]
//								lca_DistributionTotals [li_DistributionLine] +=	lnv_CurrentAmountOwed.of_GetAmount ( )
//							END IF
//						ELSE
//							li_DistributionLine ++
//							lsa_DistributionAccounts [li_DistributionLine] = lsa_Account [2]
//							lca_DistributionTotals [li_DistributionLine] +=	lnv_CurrentAmountOwed.of_GetAmount ( )							
//						END IF
//					END IF			
//				END IF
//			next
//			ll_DistributionCount = upperbound ( lsa_DistributionAccounts )
//			FOR ll_DistIndex = 1 TO ll_DistributionCount  // Peachtree puts 1 distribution per line.
//																	 //  This loop puts in each distribution.
//				ll_Row = lds_Work.insertRow ( 0 ) 
//				
//				FOR li_ndx = 1 TO ll_TransactionColumnCount  // This Loop fills in the columns for a single
//																			// SALES distribution
//																				
//					ls_value = ""																			
//																				
//					CHOOSE CASE lsa_Transaction_columns[ li_ndx ]
//					CASE "Employee ID"
//						ls_Value = ls_EntityName
//															
//					CASE "Date"
//						ls_Value = String( lnv_CurrentTransaction.of_GetDocumentDate ( ) , "mm/dd/yy" )
//	
//					CASE "Pay Period End"
//						ls_Value = String( lnv_CurrentTransaction.of_GetEndDate ( ) , "mm/dd/yy" )
//			
//					CASE "Cash Account"
//						ls_Value = ls_TransactionAccount
//				
//					CASE "Number of Distributions"
//						// calculated above		
//						ls_Value = String ( ll_DistributionCount ) 		
//						
//					CASE "Description" 
//						ls_Value = lnv_CurrentTransaction.of_GetDescription ( )  
//						 
//						//peachtree has a limit of 2000 characters in this field
//						if len(ls_value) > 1999 then
//							ls_value = left(ls_value,1999)
//						end if
//					
//					CASE "G/L Account"
//						ls_Value = ls_TransactionAccount
//				
//					CASE "Pay Field-Number"
//						ls_Value = string ( ll_DistIndex )
//						
//					CASE "Pay Field-Account"
//						ls_Value = lsa_DistributionAccounts [ ll_DistIndex ]
//	
//					CASE "Pay Field-Expense Account", "Pay Field-Memo Amount"
//						ls_Value = ""
//							
//					CASE "Amount", "Pay Field-Amount"
//						ls_Value = String ( 	lca_DistributionTotals [ll_DistIndex]   , "0.00" ) 
//						
//					CASE ELSE 
//						ls_Value = ""
//						
//					END CHOOSE
//					
//					lds_Work.object.data.Primary [ ll_Row , li_ndx ] = ls_Value
//					
//				NEXT
//			NEXT
//		ELSE		
//		
//			FOR ll_DistIndex = 1 TO ll_DistributionCount  // Peachtree puts 1 distribution per line.
//																	 //  This loop puts in each distribution.
//				lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_DistIndex ]
//				// Get Current Amount Owed
//				li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
//				li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
//				ls_FindString = "accountmap_division = " + string ( li_Division ) + &
//									" and accountmap_amounttypeid = " + string ( li_AmountType )
//				ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
//				
//				// get account
//				IF ll_FindRow > 0 THEN
//					CHOOSE CASE ls_type
//						CASE "AP"
//							ls_DistributionAccount = lds_AccountMap.Object.accountmap_costaccount[ll_FindRow]
//				
//						CASE "AR"
//				//			ls_DistributionAccount = lds_AccountMap.Object.accountmap_salesaccount[ll_FindRow]
//				
//						CASE "PR"
//							ls_DistributionAccount = lds_AccountMap.Object.accountmap_payrollexpenseaccount[ll_FindRow]
//				
//					END CHOOSE
//				END IF
//	
//				ll_Row = lds_Work.insertRow ( 0 ) 
//				
//				FOR li_ndx = 1 TO ll_TransactionColumnCount  // This Loop fills in the columns for a single
//																			// SALES distribution
//																				
//					ls_value = ""																			
//																				
//					CHOOSE CASE lsa_Transaction_columns[ li_ndx ]
//					CASE "Customer ID" , "Vendor ID", "Employee ID"
//						ls_Value = ls_EntityName
//											
//					CASE "Invoice #"
//						ls_Value = lnv_CurrentTransaction.of_GetDocumentNumber ( )
//						
//					CASE "Date" , "Date Due"
//						ls_Value = String( lnv_CurrentTransaction.of_GetDocumentDate ( ) , "mm/dd/yy" )
//	
//					CASE "Pay Period End"
//						ls_Value = String( lnv_CurrentTransaction.of_GetEndDate ( ) , "mm/dd/yy" )
//			
//					CASE "Customer PO"
//						ls_Value = ""
//						
//					CASE "Ship Date"
//						ls_Value = ""
//						
//					CASE "Accounts Receivable Account" , "Accounts Payable Account", "Cash Account"
//						ls_Value = ls_TransactionAccount
//				
//					CASE "Invoice Note"  
//						ls_Value = lnv_CurrentTransaction.of_GetPublicNote ( )
//						
//					CASE "Number of Distributions"
//						// calculated above		
//						ls_Value = String ( ll_DistributionCount ) 		
//						
//					CASE "Quantity" 
//						ls_Value = String( lnv_CurrentAmountOwed.of_GetQuantity ( ) )
//						
//					CASE "Description" 
//						ls_Value = lnv_CurrentTransaction.of_GetDescription ( )  
//						 
//						//peachtree has a limit of 2000 characters in this field
//						if len(ls_value) > 1999 then
//							ls_value = left(ls_value,1999)
//						end if
//					
//					CASE "G/L Account"
//						ls_Value = ls_DistributionAccount
//				
//					CASE "Tax Type"
//						ls_Value = string (1)
//						
//					CASE "Pay Field-Number"
//						ls_Value = "1"
//						
//					CASE "Pay Field-Account"
//						ls_Value = ls_DistributionAccount
//	
//					CASE "Pay Field-Expense Account", "Pay Field-Memo Amount"
//						ls_Value = ""
//							
//					CASE "Amount", "Pay Field-Amount"
//						ls_Value = String ( lnv_CurrentAmountOwed.of_GetAmount ( )  , "0.00" ) 
//						
//					CASE "Sales Tax Authority" //receivables only
//		//				ls_Value = String ( 0 )    
//		//   			not sure what the value should be??  it is required!
//		
//					CASE ELSE 
//						ls_Value = ""
//						
//					END CHOOSE
//					
//					lds_Work.object.data.Primary [ ll_Row , li_ndx ] = ls_Value
//					
//				NEXT
//				
//			NEXT
//			
//			IF	li_Return = -1 THEN	EXIT
//		END IF	
//	NEXT
//END IF
//
////Export contents of datastore to batch file
//IF li_Return = 1 THEN
//	DO
//		li_result = lds_work.saveas(ls_pathname, CSV!, false)
//		IF li_result = -1 THEN
//			IF messagebox(ls_messageheader, "Could not save batch file.", exclamation!, &
//				retrycancel!, 1) = 2 THEN
//				ls_reject = ""
//				li_Return = -1
//				EXIT
//			END IF
//		END IF
//	LOOP UNTIL li_result = 1
//END IF
//
//IF li_Return = -1 THEN
//	IF len(ls_reject) > 0 THEN 
//		messagebox(ls_messageheader, ls_reject, exclamation!)
//	END IF
//END IF
//
//DESTROY lds_work
//DESTROY lds_AccountMap
//RETURN li_Return
end subroutine

private function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);SetPointer(HourGlass!)

Boolean	lb_Found

String	ls_TransType, &
			lsa_transaction_columns[], &
			lsa_ParsedAccount1 [], &
			lsa_ParsedAccount2 [], &
			lsa_CostExpenseAccount [], &
			lsa_distributioncolumns[], &
			lsa_CombinedDistAccounts [], &
			lsa_CombinedAPCash[], &
			lsa_APCashAccount[], &
/*4.0*/	lsa_DistributionNotes[],&
			ls_value, &
			ls_reject, &
			ls_messageheader, &
			ls_MessageContext, & 
			ls_type, &
			ls_pathname, &
			ls_filename, &
			ls_TransactionAccount, &
			ls_CostExpenseAccount, &
			ls_APCashAccount, &
			ls_category, &
			ls_EntityId

Integer	li_Return, &
			li_ndx, &
			li_result, &
			li_DistributionLine

Long		ll_TransactionCount, &
			ll_DistributionCount, &
			ll_Distributioncolumncount, &
			ll_trns, &
			ll_distIndex, &
			ll_TransactionColumnCount, &
			ll_row	
			
Dec {2}	lca_DistributionTotals [], &
			lca_amountowed[], &
			lca_Quantity[], &
			lca_Blank[]
	
datastore					lds_work
n_cst_string				lnv_string
n_cst_accountingdata		lnv_accountingdata

li_Return = 1
ls_category = anva_accountingdata[1].of_GetCategory ( )
Choose case upper(ls_category)
	case "PAYABLES"
		ls_type = "AP"
		ls_MessageContext = "AP"
		lsa_Transaction_Columns = { &
							"Vendor ID" 	, &
							"Invoice #" 	, &
							"Date" 			, &
							"Date Due"		, &
							"Accounts Payable Account" , &
							"Number of Distributions" , & 
							"Quantity" 		, &
							"Description" 	, &
							"G/L Account" 	, &
							"Amount"       , &
	/*Added 4.0*/		"PO Note" } 
							
		
							
	case "RECEIVABLES"
		ls_type = "AR"
		ls_MessageContext = "AR"
		lsa_Transaction_Columns = { &
							"Customer ID" 	, &
							"Invoice #" 	, &
							"Date" 			, &
							"Customer PO" 	, &
							"Ship Date" 	, &
							"Accounts Receivable Account" , &
							"Invoice Note" , &
							"Number of Distributions" , & 
							"Quantity"		, &
							"Description" 	, &
							"G/L Account" 	, &
							"Tax Type" 		, &
							"Amount"			, &
							"Sales Tax Authority" } // Required
	case "PAYROLL"
		ls_type = "PR"
		ls_MessageContext = "PR"
		lsa_Transaction_Columns = { &
							"Employee ID" 	, &
							"Date" 			, &
							"Cash Account" , &
							"Pay Period End", &
							"Number of Distributions" , & 
							"Pay Field-Number", &
							"Pay Field-Account", &
							"Pay Field-Expense Account", &
							"Pay Field-Amount", &
							"Pay Field-Memo Amount"} 
end choose

ls_MessageHeader = "Create " + ls_MessageContext +" Batch"
ls_Reject = "Could not create " + ls_MessageContext + " batch."
ll_TransactionCount = upperBound	( anva_accountingdata )
ll_DistributionColumnCount = upperBound( lsa_distributioncolumns[] )
ll_TransactionColumnCount = upperBound	( lsa_transaction_columns[] )

//Get Batch File Name
IF li_Return = 1 THEN
	li_Return = this.of_getbatchfilename("csv",ls_MessageContext, ls_filename, ls_pathname)
	//	returns 1 (success) or -1 (failure)
END IF

IF li_Return = 1 then
	lds_work = this.of_datainitialization( lsa_transaction_columns [] )
	IF NOT IsValid ( lds_Work ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 THEN

	SetPointer ( HOURGLASS! )
	
	//load transaction information into dataStore

	FOR ll_Trns = 1 TO ll_TransactionCount
		
		li_DistributionLine = 0	
		lca_DistributionTotals = lca_Blank
		
		// Get a single transaction
		lnv_accountingdata = anva_accountingdata [ ll_Trns ]
		
		choose case upper(ls_category)
			case "PAYABLES"
				ls_EntityId = lnv_accountingdata.of_GetPayablesId ( )
			case "PAYROLL"
				ls_EntityId = lnv_accountingdata.of_GetPayrollId ( )
			case "RECEIVABLES"
				ls_EntityId = lnv_accountingdata.of_GetReceivablesId ( )
		end choose
		
		// Get associated AmountsOwed and determine the number of distributions for that trans.
		ll_DistributionCount = lnv_accountingdata.of_GetdistributionAmount ( lca_AmountOwed )
		lnv_accountingdata.of_GetdistributionQuantity ( lca_Quantity )
		lnv_accountingdata.of_GetcostexpenseAccount	(lsa_costexpenseaccount)
		lnv_accountingdata.of_GetAPCashAccount(lsa_APCashAccount)
		lnv_accountingdata.of_getdistributionnotes(  lsa_DistributionNotes )
		
		//Make Transaction entries
	
		// Now loop through all the distributions for the current transaction and populate all 
		// the column fields.
		
		// Make Transaction Entries
			
		/*	For payroll we need to be able to control the distribution lines for the check
			if we want to keep track of taxable and non-taxable amounts
			Round up sums by distribution line entered in account map	
			for payroll expense account we will parse the payrollexpenseaccount
			into distribution line and expense account,  then sum all of the distribution lines	
		*/
		IF ls_Type = "PR" THEN
			FOR ll_DistIndex = 1 TO ll_DistributionCount
				ls_CostExpenseAccount = lsa_CostExpenseAccount[ll_DistIndex]
				ls_APCashAccount = lsa_APCashAccount[ll_DistIndex]
				lnv_string.of_ParseToArray ( ls_APCashAccount, ",", lsa_ParsedAccount2 )
				choose case upperbound(lsa_parsedAccount2)
					case 0 	//this shouldn't happen but just in case
						lsa_ParsedAccount2 [1] = '0'
						lsa_ParsedAccount2 [2] = '0'
					case 1 //if only one number in account field
						lsa_parsedAccount2 [2] = lsa_ParsedAccount2 [1] 
					case else
						//ok
				end choose
					
				//parse account 1st entry is distribution line and 2nd entry is expense account
				lnv_string.of_ParseToArray ( ls_CostExpenseAccount, ",", lsa_ParsedAccount1 )
				IF upperbound ( lsa_ParsedAccount1 ) <> 2 or &
					isnull ( lsa_ParsedAccount1 [1] ) or &
					len ( lsa_ParsedAccount1 [1] ) = 0 THEN
					// put in 1st distribution line 
						lsa_CombinedDistAccounts [1] = lsa_ParsedAccount1 [1]
						lsa_CombinedAPCash [1] = lsa_ParsedAccount2 [1]
						lca_DistributionTotals [1] +=	lca_AmountOwed[ll_DistIndex]
				ELSE
					IF li_DistributionLine > 0 THEN
					//did we already get this line before
						lb_found = FALSE
						FOR li_ndx = 1 to li_DistributionLine
							IF integer ( lsa_ParsedAccount1 [1] ) = li_ndx THEN
								lca_DistributionTotals [li_ndx] +=	lca_AmountOwed[ll_DistIndex]
								lb_found = TRUE
							END IF
						NEXT
						IF not lb_Found THEN
							li_DistributionLine ++
							lsa_CombinedDistAccounts [li_DistributionLine] = lsa_ParsedAccount1 [2]
							lsa_CombinedAPCash [li_DistributionLine] = lsa_ParsedAccount2 [2]
							lca_DistributionTotals [li_DistributionLine] +=	lca_AmountOwed[ll_DistIndex]
						END IF
					ELSE
						li_DistributionLine ++
						lsa_CombinedDistAccounts [li_DistributionLine] = lsa_ParsedAccount1 [2]
						lsa_CombinedAPCash [li_DistributionLine] = lsa_ParsedAccount2 [2]
						lca_DistributionTotals [li_DistributionLine] +=	lca_AmountOwed[ll_DistIndex]						
					END IF
				END IF			
			next
			
			if li_return = 1 then
				ll_DistributionCount = upperbound ( lsa_CombinedDistAccounts )
				FOR ll_DistIndex = 1 TO ll_DistributionCount  // Peachtree puts 1 distribution per line.
																		 //  This loop puts in each distribution.
					ll_Row = lds_Work.insertRow ( 0 ) 
					
					FOR li_ndx = 1 TO ll_TransactionColumnCount  // This Loop fills in the columns for a single
																				// SALES distribution
																					
						ls_value = ""																			
																					
						CHOOSE CASE lsa_Transaction_columns[ li_ndx ]
						CASE "Employee ID"
							ls_Value = ls_EntityId
																
						CASE "Date"
							ls_Value = string( lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YY")					
		
						CASE "Pay Period End"
							ls_Value = String( lnv_accountingdata.of_GetEndDate ( ) , "mm/dd/yy" )
				
						CASE "Number of Distributions"
							// calculated above		
							ls_Value = String ( ll_DistributionCount ) 		
							
						CASE "Description" 
							ls_Value = lnv_accountingdata.of_GetDescription ( )  
							 
							//peachtree has a limit of 2000 characters in this field
							if len(ls_value) > 1999 then
								ls_value = left(ls_value,1999)
							end if
						
						CASE "Cash Account", "G/L Account"
							ls_Value = lsa_CombinedAPCash [ ll_DistIndex ]
						
						
						CASE "Pay Field-Number"
							ls_Value = string ( ll_DistIndex )
							
						CASE "Pay Field-Account"
							//expense account
							ls_Value = lsa_CombinedDistAccounts [ ll_DistIndex ]
		
						CASE "Pay Field-Expense Account", "Pay Field-Memo Amount"
							ls_Value = ""
								
						CASE "Amount", "Pay Field-Amount"
							ls_Value = String ( 	lca_DistributionTotals [ll_DistIndex]   , "0.00" ) 
							
						CASE ELSE 
							ls_Value = ""
							
						END CHOOSE
						
						lds_Work.object.data.Primary [ ll_Row , li_ndx ] = ls_Value
						
					NEXT
				NEXT
			end if
		ELSE		
		
			FOR ll_DistIndex = 1 TO ll_DistributionCount  // Peachtree puts 1 distribution per line.
																	 //  This loop puts in each distribution.
				ll_row = lds_work.insertrow(0)

				FOR li_ndx = 1 TO ll_TransactionColumnCount  // This Loop fills in the columns for a single
																			// SALES distribution
																				
					ls_value = ""																			
																				
					CHOOSE CASE lsa_Transaction_columns[ li_ndx ]
					CASE "Customer ID" , "Vendor ID", "Employee ID"
						ls_Value = ls_EntityId
											
					CASE "Invoice #"
						ls_Value = string(lnv_accountingdata.of_GetDocumentNumber ( )	)
						
					CASE "Date" 
						ls_Value = string( lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YY")
	
					CASE "Date Due"
						ls_Value = string( lnv_accountingdata.of_GetDueDate ( ), "MM/DD/YY")
						
					CASE "Pay Period End"
						ls_Value = String( lnv_accountingdata.of_GetEndDate ( ) , "mm/dd/yy" )
			
					CASE "Customer PO"
						ls_Value = ""
						
					CASE "Ship Date"
						ls_Value = ""
						
					CASE "Accounts Receivable Account" , "Accounts Payable Account", "Cash Account"
						ls_Value = lsa_APCashAccount [ ll_DistIndex ]
//						ls_Value = lnv_accountingdata.of_GetTransactionAccount ()
				
					CASE "PO Note" 
						ls_Value = lsa_DistributionNotes [ ll_DistIndex ]
						IF Len ( ls_Value ) > 1999 THEN
							ls_Value = Left (ls_Value , 1999)
						END IF
					CASE "Invoice Note"  
						ls_Value = lnv_accountingdata.of_GetPublicNote ( )
						
					CASE "Number of Distributions"
						// calculated above		
						ls_Value = String ( ll_DistributionCount ) 		
						
					CASE "Quantity" 
						ls_Value = string(lca_quantity[ll_DistIndex])
						
					CASE "Description" 
						ls_Value = lnv_accountingdata.of_GetDescription ( )  
						 
						//peachtree has a limit of 2000 characters in this field
						if len(ls_value) > 1999 then
							ls_value = left(ls_value,1999)
						end if
					
					CASE "G/L Account"
						ls_Value = lsa_CostExpenseAccount [ ll_DistIndex ]
//						ls_Value = lsa_APCashAccount [ ll_DistIndex ]
				
					CASE "Tax Type"
						ls_Value = string (1)
						
					CASE "Pay Field-Number"
						ls_Value = "1"
						
					CASE "Pay Field-Account"
						//cost account
						ls_Value = lsa_CostExpenseAccount [ ll_DistIndex ]
	
					CASE "Pay Field-Expense Account", "Pay Field-Memo Amount"
						ls_Value = ""
							
					CASE "Amount", "Pay Field-Amount"
						ls_Value = string(lca_AmountOwed[ll_DistIndex], "0.00")
						
					CASE "Sales Tax Authority" //receivables only
		//				ls_Value = String ( 0 )    
		//   			not sure what the value should be??  it is required!
		
					CASE ELSE 
						ls_Value = ""
						
					END CHOOSE
					
					lds_Work.object.data.Primary [ ll_Row , li_ndx ] = ls_Value
					
				NEXT
				
			NEXT
			
			IF	li_Return = -1 THEN	EXIT
		END IF	
	NEXT
END IF

//Export contents of datastore to batch file
IF li_Return = 1 THEN
	DO
		li_result = lds_work.saveas(ls_pathname, CSV!, false)
		IF li_result = -1 THEN
			IF messagebox(ls_messageheader, "Could not save batch file.", exclamation!, &
				retrycancel!, 1) = 2 THEN
				ls_reject = ""
				li_Return = -1
				EXIT
			END IF
		END IF
	LOOP UNTIL li_result = 1
END IF

IF li_Return = -1 THEN
	IF len(ls_reject) > 0 THEN 
		messagebox(ls_messageheader, ls_reject, exclamation!)
	END IF
END IF

DESTROY lds_work
RETURN li_Return
end function

protected function integer of_insertheaders (ref datastore ads_work, string asa_data[], long al_beforerow);Long	ll_Row
Int	li_ndx
Long	ll_Count

ll_Count = UpperBound ( asa_data )

ll_Row = ads_Work.insertRow ( al_BeforeRow )
	
FOR li_ndx = 1 TO ll_Count 
	ads_Work.object.Data.primary[ ll_Row , li_ndx ] = asa_data [ li_ndx ]
NEXT

RETURN 1
end function

protected function integer of_appendtofile (datastore lds_work, string as_filename);String	ls_TempFile
Int		li_Result
Int		li_SaveRtn
Int		li_Return = -1 
Boolean	lb_Result
n_cst_fileSrv	lnv_File
lnv_File = CREATE n_cst_fileSrv

ls_TempFile = "C:\" + string ( Now ( ) , "hhmmss") + "pt.tmp" 

li_SaveRtn = lds_Work.SaveAs( ls_TempFile , CSV! , FALSE )

IF li_SaveRtn = 1 THEN
	li_Result =  lnv_File.of_fileCopy ( ls_TempFile , as_filename , TRUE )
END IF 
	
IF li_Result = 1 THEN
	lb_Result =  FileDelete ( ls_TempFile )
END IF

IF li_SaveRtn = 1 AND li_Result = 1 THEN
	li_Return = 1 
END IF

DESTROY ( lnv_File )

RETURN li_Return

end function

protected function datastore of_datainitialization (string asa_transcolumns[]);/*
		Creates the datastore and sets the transaction columns.
		Returns:  datastore


*/

SetPointer(HourGlass!)

Integer	li_Return, &
			li_TransColumnCount, &
			li_ndx

Long		ll_row
datastore lds_work

li_Return = 1
li_TransColumnCount = upperbound( asa_transcolumns )
//Set up datastore to hold batch information for export
IF li_Return = 1 THEN
	lds_Work = of_CreateBatchDataStore ( li_TransColumnCount )
	IF NOT IsValid ( lds_Work ) THEN
		li_Return = -1
	END IF
END IF

//Put column headers into datastore
IF li_Return = 1 THEN

	setpointer(hourglass!)
	
	ll_row = lds_work.insertrow(0)
	FOR li_ndx = 1 TO li_TransColumnCount
		lds_work.object.data.primary[ll_row, li_ndx] = asa_transcolumns [li_ndx]
	NEXT

END IF

RETURN lds_work
end function

on n_cst_acctlink_peachtree.create
call super::create
end on

on n_cst_acctlink_peachtree.destroy
call super::destroy
end on

