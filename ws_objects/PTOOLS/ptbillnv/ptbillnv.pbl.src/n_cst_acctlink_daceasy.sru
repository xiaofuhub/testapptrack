$PBExportHeader$n_cst_acctlink_daceasy.sru
forward
global type n_cst_acctlink_daceasy from n_cst_acctlink
end type
end forward

global type n_cst_acctlink_daceasy from n_cst_acctlink
end type
global n_cst_acctlink_daceasy n_cst_acctlink_daceasy

type variables

end variables

forward prototypes
public function integer of_batch_create (n_cst_msg anv_cst_msg)
public function integer of_validate_customers (datastore ads_list)
protected function string of_parsecustomer (string as_source)
public function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
end prototypes

public function integer of_batch_create (n_cst_msg anv_cst_msg);
/*================================================================================ 
                	of_Batch_Create ( n_cst_msg )   For DacEasy -> actualy interface to 
						 										  2nd story.
			
			
	This function produces a batch with comma separated values (csv) 
	It creates a file with the each transaction having a header and then all the dristributions
	are split out one per line. 
	It relies on double entry accounting.
	
	Return Values:
							1 = Success
						  -1 = Failure 
						  -2 = User Chose no AR Batch	
	Created:				  
		8-7-2000	 <<*>> RPZ
		Modified July 1st 2005: added seconds (ss) to the file save name 
	
===============================================================================*/



Long		ll_trns
Long		ll_TransCount
Long		ll_Row
Long		ll_TransactionColumnCount
Long 		j
//
Int		li_ndx
Int		li_Result
Int		li_MsgCount
Int		i
Int		li_UseDefaultRtn
Int		li_BatchFolderRtn
Int		li_NumDistributions

Boolean	lb_UseDefault
//
String	ls_BatchType
String	ls_BatchFile
String	ls_BatchFilePath
String	ls_Path
//
String	ls_Title
String	ls_PathName
String	ls_FileName
Constant String	ls_Extension = "csv"	
String	ls_Filter
String	ls_CancelWarning
String	ls_MessageHeader
String	ls_Reject
//
String	lsa_Transaction_Columns[]
String	ls_Value


s_Parm		lstr_Parm
n_cst_File	lnv_File
DataStore	lds_Work

s_accounting_transaction lstra_trns[]
s_accounting_transaction lstr_CurrentTransaction
s_accounting_distribution lstr_dist
s_accounting_distribution lstr_current_dist
s_accounting_distribution lstra_distributions[]



ls_MessageHeader = "Create AR Batch"
ls_Reject = "Could not create AR batch."

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
	

	IF lnv_File.of_GetFileSaveName ( ls_Title , ls_PathName , ls_FileName , ls_Extension, &
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

lsa_Transaction_Columns = {"Customer Code" , "Type" , "Invoice" , "Reference" , "Tran Date" , "Due Date", &
								  "Disc Date" , "Disc Rate" , "GL Account" , &
								  "Description" , "Amount", "Name" , "Contact", "Address 1" , "Address 2", "City", "State",&
								  "Zip", "Phone", "Tax Code" , "Term Code" , "Sales Per" }					  
								  								  
ll_TransactionColumnCount = UpperBound ( lsa_Transaction_Columns )

lds_Work = of_CreateBatchDataStore ( ll_TransactionColumnCount )

IF NOT isValid ( lds_Work ) THEN
	
	GOTO FAILURE
	
END IF

// for each transaction structure get the info for the header. 
// then for the current transaction get the array of distribution structs and loop through 
// them filling in the info contianed there in.

ll_transCount = UpperBound ( lstra_Trns )
FOR ll_Trns = 1 TO ll_TransCount  // loop through the transactions

	lstr_CurrentTransaction = lstra_Trns[ ll_Trns ]  // get the current transaction
	
	// now that the ds has been created fill in the cells.
	// this will be done by looping through all the columns and populating a variable that will be 
	// set to the correct field in the ds.
	
	// the big question is do we want/need to include the "optional" data and what is the impact 
	// of including such data?
	
	ll_Row = lds_Work.insertRow ( 0 ) // insert a new row for the transaction line 
	IF NOT ll_Row > 0 THEN 
		ls_Reject = "An error occurred while attempting to insert a line entry."
		GOTO FAILURE
	END IF
	
	FOR i = 1 TO ll_TransactionColumnCount // this loop goes through all the cols.
		
		ls_Value = ""
		
		// commented numbers are the max length of the fields
		CHOOSE CASE lsa_Transaction_columns[ i ]
				
			CASE "Customer Code"
				// co code
				ls_Value = Left ( lstr_CurrentTransaction.is_company_code, 10 )
				//10
			CASE "Type"
				ls_Value = "I" // "I" is for Invoice 
				// 1
			CASE "Invoice"
				// doc #
				ls_Value = Left ( lstr_CurrentTransaction.is_Document_number , 10 ) 
				//10
			CASE "Reference"
				ls_Value = Left ( lstr_CurrentTransaction.istra_referencenumbers[1].is_value , 10 )  // 10
			CASE "Tran Date"  // original Date
				//8
				ls_Value = String ( lstr_CurrentTransaction.id_document_date,"mm/dd/yy" ) 
				
			CASE "Due Date"
				// payment due
				ls_Value = String ( lstr_CurrentTransaction.id_Payment_due,"mm/dd/yy" ) 
				
				//8
			CASE "Disc Date"
				ls_Value = String ( lstr_CurrentTransaction.id_document_date,"mm/dd/yy" )
				
				//8
			CASE "Disc Rate"
				ls_Value = String ( 0 ) 
				//6
			CASE "GL Account"
				//10
			CASE "Description"
				// 24
			CASE "Amount"
				// doc amount
				ls_Value = Left ( String ( lstr_CurrentTransaction.ic_Document_amount	) , 11 )	// from here down the fields are optional... sort of

			CASE "Name"
				// co name
				//ls_Value = Left ( lstr_CurrentTransaction.is_Company_Name , 40 )
				// I don't know if I want to put this in b/c it acts as a flag to include the  optional fields
			CASE "Contact"
				// 40
			CASE "Address 1"
				//40
			CASE "Address 2"							   
				//40
			CASE "City"
				//15
			CASE "State"
				//3
			CASE "Zip"
				//10
			CASE "Phone"
				//14
			CASE "Tax Code"
				//5
			CASE "Term Code"
				// payment terms
				//ls_Value = Left ( lstr_CurrentTransaction.is_payment_Terms , 5 )
				
			CASE "Sales Per"
				// 5
		END CHOOSE
		lds_Work.object.data.Primary [ ll_Row , i ] = ls_Value
	NEXT
	// when this is done then the main transaction line has been created 
	// so it is time to get the distribution struct array from/for the current transaction.
	
	
	lstra_distributions[] = lstr_CurrentTransaction.istra_distributions
	
	// now loop through the each distribution and create a new line for each one and populate the cells
	// of the ds as done above.
	
	li_NumDistributions = upperbound ( lstra_distributions )
	FOR i = 1 TO li_NumDistributions // loop through each distribution.
		
		
		lstr_current_dist = lstra_distributions[ i ] // get the current distribution to work with
	   ll_Row = lds_Work.insertRow ( 0 ) // insert a new row for the distribution line 
		
		FOR j = 1 To ll_TransactionColumnCount // loop through the columns and populate the data
			
			ls_Value = ""
			
			CHOOSE CASE lsa_Transaction_columns[ j ]
				
				CASE "Customer Code"
					// co code
					ls_Value = "" // this has to be blank and has to have a comma follow it
					
				CASE "Type"
					IF lstr_current_dist.ib_credit THEN
						ls_Value = "C"
					ELSE
						ls_Value = "D"
					END IF
					
				CASE "Invoice"
					// doc #
					//ls_Value = lstr_CurrentTransaction.is_Document_number
					
				CASE "Reference"
				CASE "Tran Date"
				CASE "Due Date"
				CASE "Disc Date"
				CASE "Disc Rate"
				CASE "GL Account"
					ls_Value =  lstr_current_dist.is_account 
					
				CASE "Description"  
					//24
					ls_Value =  '"' + Left (  of_GetReferenceList( lstr_CurrentTransaction ) , 22 )+'"'
					
				CASE "Amount"
					// doc amount
				   ls_Value = Left (String ( lstr_current_dist.ic_amount ), 11 )		// from here down the fields are optional... sort of
	
				CASE "Name"
					// once again by putting this in it will flag 2nd story as to include the rest of 
					// the following data
				CASE "Contact"
				CASE "Address 1"
				CASE "Address 2"							   
				CASE "City"
				CASE "State"
				CASE "Zip"
				CASE "Phone"
				CASE "Tax Code"
				CASE "Term Code"
					// payment terms
					//ls_Value = lstr_CurrentTransaction.is_payment_Terms
					
				CASE "Sales Per"
				
			END CHOOSE
			
			lds_Work.object.data.Primary [ ll_Row , j ] = ls_Value
			
		NEXT // next column
		
	NEXT // next distrbution
	
NEXT // next transaction				


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

destroy lds_Work

Return 1

//\\//\\//\\//\\//\\  Failure //\\//\\//\\//\\

Failure:

IF len ( ls_Reject ) > 0 THEN 
	messageBox ( ls_messageHeader , ls_Reject , EXCLAMATION! )
END IF

Destroy lds_work 
RETURN -1


end function

public function integer of_validate_customers (datastore ads_list);RETURN of_ValidateCustomerFile ( ads_List )
end function

protected function string of_parsecustomer (string as_source);Integer	li_TabPos
String	ls_Value


ls_Value = as_Source

ls_Value = Trim ( Upper ( ls_Value ) )

RETURN ls_Value

end function

public function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);/*

*/

SetPointer(HourGlass!)

string	ls_reject, &
			ls_message_header, &
			ls_pathname, &
			ls_filename, &
			ls_value, &
			ls_category, &
			ls_EntityId, &
			lsa_transaction_columns[], &
			lsa_distributionaccount[], &
			ls_type,&
			ls_messagecontext
			

Integer	li_Return, &
			li_DistNdx, &
			li_Ndx, &
			li_result, &
			li_transNdx, &
			li_TransactionSign, &
			li_DistributionSign 
			

Long		ll_TransactionCount, &
			ll_distributioncount, &
			ll_trns, &
			ll_TransactionColumnCount, &
			ll_row
			
Dec {2}	lca_amountowed[], &
			lc_total
		
boolean	lb_credit

n_cst_accountingdata		lnv_accountingdata
datastore				 	lds_work
li_Return = 1
ls_category = anva_accountingdata[1].of_GetCategory ( )

Choose case upper(ls_category)
	case 'PAYABLES'
		ls_type = "AP"
		ls_MessageContext = "AP"
		li_TransactionSign = -1
		li_DistributionSign = 1
		lb_credit=false
		lsa_Transaction_Columns = {"Customer Code" , "Type" , "Invoice" , "Reference" , "Tran Date" , "Due Date", &
								  "Disc Date" , "Disc Rate" , "GL Account" , &
								  "Description" , "Amount", "Name" , "Contact", "Address 1" , "Address 2", "City", "State",&
								  "Zip", "Phone", "Tax Code" , "Term Code" , "Sales Per" }					  
								  								  
	case 'RECEIVABLES'
		ls_type = "AR"
		ls_MessageContext = "AR"
		li_TransactionSign = 1
		li_DistributionSign = -1
		lb_credit = true
		lsa_Transaction_Columns = {"Customer Code" , "Type" , "Invoice" , "Reference" , "Tran Date" , "Due Date", &
								  "Disc Date" , "Disc Rate" , "GL Account" , &
								  "Description" , "Amount", "Name" , "Contact", "Address 1" , "Address 2", "City", "State",&
								  "Zip", "Phone", "Tax Code" , "Term Code" , "Sales Per" }					  
								  								  
	case "PAYROLL"
		ls_type = "PR"
		ls_MessageContext = "PR"
		li_TransactionSign = -1
		li_DistributionSign = 1
		lb_credit=false
		lsa_Transaction_Columns = {"Customer Code" , "Type" , "Invoice" , "Reference" , "Tran Date" , "Due Date", &
								  "Disc Date" , "Disc Rate" , "GL Account" , &
								  "Description" , "Amount", "Name" , "Contact", "Address 1" , "Address 2", "City", "State",&
								  "Zip", "Phone", "Tax Code" , "Term Code" , "Sales Per" }					  
								  								  
end choose

ls_message_header = "Create " + ls_type + " Batch"
ls_reject = "Could not create "+ ls_type + " batch."
ll_TransactionCount = upperBound	( anva_accountingdata )

//Get Batch File Name
IF li_Return = 1 THEN
	li_Return = this.of_getbatchfilename("csv",ls_MessageContext, ls_filename, ls_pathname)
	//	returns 1 (success) or -1 (failure)
END IF

IF li_Return = 1 then
	ll_TransactionColumnCount = UpperBound ( lsa_Transaction_Columns )
	lds_Work = of_CreateBatchDataStore ( ll_TransactionColumnCount )
	
	IF NOT isValid ( lds_Work ) THEN		
		li_return = -1		
	END IF

END IF


IF li_Return = 1 THEN

	SetPointer ( HourGlass! )

	FOR ll_Trns = 1 TO ll_TransactionCount  // loop through the transactions
	
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
		lnv_accountingdata.of_GetcostexpenseAccount	(lsa_distributionaccount)
		
		ll_Row = lds_Work.insertRow ( 0 ) // insert a new row for the transaction line 
		IF NOT ll_Row > 0 THEN 
			ls_Reject = "An error occurred while attempting to insert a line entry."
			li_return = -1	
		END IF
		
		if li_return = -1 then
			exit
		end if
		
		FOR li_ndx = 1 TO ll_TransactionColumnCount // this loop goes through all the cols.
			
			ls_Value = ""
			
			// commented numbers are the max length of the fields
			CHOOSE CASE lsa_Transaction_columns[ li_ndx ]
					
				CASE "Customer Code"
					// co code
					ls_Value = Left ( ls_EntityId, 10 )
					//10
				CASE "Type"
					ls_Value = "I" // "I" is for Invoice 
					// 1
				CASE "Invoice"
					// doc #
					ls_Value = Left ( string(lnv_accountingdata.of_GetDocumentNumber ( )	) , 10 ) 
					//10
				CASE "Reference"
					ls_Value = Left ( lnv_accountingdata.of_GetRef1Text() , 10 )// 10
				CASE "Tran Date"  // original Date
					//8
					ls_Value = string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YY")
					
				CASE "Due Date"
					// payment due
					ls_Value = string(lnv_accountingdata.of_GetDueDate ( ), "MM/DD/YY")
					
					//8
				CASE "Disc Date"
					ls_Value = string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YY")
					
					//8
				CASE "Disc Rate"
					ls_Value = String ( 0 ) 
					//6
				CASE "GL Account"
					//10
				CASE "Description"
					// 24
				CASE "Amount"
					// doc amount
					ls_Value = Left ( string(lnv_accountingdata.of_getPreTaxNet ( )) , 11 )	// from here down the fields are optional... sort of
	
				CASE "Name"
					// co name
					//ls_Value = Left ( lstr_CurrentTransaction.is_Company_Name , 40 )
					// I don't know if I want to put this in b/c it acts as a flag to include the  optional fields
				CASE "Contact"
					// 40
				CASE "Address 1"
					//40
				CASE "Address 2"							   
					//40
				CASE "City"
					//15
				CASE "State"
					//3
				CASE "Zip"
					//10
				CASE "Phone"
					//14
				CASE "Tax Code"
					//5
				CASE "Term Code"
					// payment terms
					//ls_Value = Left ( lstr_CurrentTransaction.is_payment_Terms , 5 )
					
				CASE "Sales Per"
					// 5
			END CHOOSE
			lds_Work.object.data.Primary [ ll_Row , li_ndx] = ls_Value
		NEXT
		// when this is done then the main transaction line has been created 
		// so it is time to get the distributions
		
		//first create the credit line for the AP account
		lc_total = 0
		FOR li_DistNdx = 1 TO ll_DistributionCount
			lc_total = lc_total + lca_AmountOwed[li_DistNdx]
		next
		if lc_total > 0 then
			ll_Row = lds_Work.insertRow ( 0 ) // insert a new row for the distribution line 
			
			FOR li_transNdx = 1 To ll_TransactionColumnCount // loop through the columns and populate the data
				
				ls_Value = ""
				
				CHOOSE CASE lsa_Transaction_columns[ li_transNdx ]
					
					CASE "Customer Code"
						// co code
						ls_Value = "" // this has to be blank and has to have a comma follow it
						
					CASE "Type"
						
						//credit
						ls_Value = "C"
						
					CASE "Invoice"
						// doc #
						//ls_Value = lstr_CurrentTransaction.is_Document_number
						
					CASE "Reference"
					CASE "Tran Date"
					CASE "Due Date"
					CASE "Disc Date"
					CASE "Disc Rate"
					CASE "GL Account"
						ls_Value =  lnv_accountingdata.of_GetTransactionAccount()
						
					CASE "Description"  
						//24
						ls_Value =  '"' + Left (  lnv_accountingdata.of_getDescription (  ) , 22 )+'"'
						
					CASE "Amount"
						// doc amount
						ls_Value = Left ( string(lc_total  * li_DistributionSign, "0.00"), 11 )		// from here down the fields are optional... sort of
		
					CASE "Name"
						// once again by putting this in it will flag 2nd story as to include the rest of 
						// the following data
					CASE "Contact"
					CASE "Address 1"
					CASE "Address 2"							   
					CASE "City"
					CASE "State"
					CASE "Zip"
					CASE "Phone"
					CASE "Tax Code"
					CASE "Term Code"
						// payment terms
						//ls_Value = lstr_CurrentTransaction.is_payment_Terms
						
					CASE "Sales Per"
					
				END CHOOSE
				
				lds_Work.object.data.Primary [ ll_Row , li_transNdx ] = ls_Value
				
			NEXT // next column
		end if
		
		// now loop through the each distribution and create a new line for each one and populate the cells
		// of the ds as done above.
		if li_return = 1 then		
			FOR li_DistNdx = 1 TO ll_DistributionCount // loop through each distribution.
				
				ll_Row = lds_Work.insertRow ( 0 ) // insert a new row for the distribution line 
				
				FOR li_transNdx = 1 To ll_TransactionColumnCount // loop through the columns and populate the data
					
					ls_Value = ""
					
					CHOOSE CASE lsa_Transaction_columns[ li_transNdx ]
						
						CASE "Customer Code"
							// co code
							ls_Value = "" // this has to be blank and has to have a comma follow it
							
						CASE "Type"
							
							//ap = credit
							//cost = debit
							IF lb_credit THEN
								ls_Value = "C"
							ELSE
								ls_Value = "D"
							END IF
							
						CASE "Invoice"
							// doc #
							//ls_Value = lstr_CurrentTransaction.is_Document_number
							
						CASE "Reference"
						CASE "Tran Date"
						CASE "Due Date"
						CASE "Disc Date"
						CASE "Disc Rate"
						CASE "GL Account"
							ls_Value =  lsa_distributionaccount[li_DistNdx]
							
						CASE "Description"  
							//24
							ls_Value =  '"' + Left (  lnv_accountingdata.of_getDescription (  ) , 22 )+'"'
							
						CASE "Amount"
							// doc amount
							ls_Value = Left ( string(lca_AmountOwed[li_DistNdx] * li_DistributionSign , "0.00"), 11 )		// from here down the fields are optional... sort of
			
						CASE "Name"
							// once again by putting this in it will flag 2nd story as to include the rest of 
							// the following data
						CASE "Contact"
						CASE "Address 1"
						CASE "Address 2"							   
						CASE "City"
						CASE "State"
						CASE "Zip"
						CASE "Phone"
						CASE "Tax Code"
						CASE "Term Code"
							// payment terms
							//ls_Value = lstr_CurrentTransaction.is_payment_Terms
							
						CASE "Sales Per"
						
					END CHOOSE
					
					lds_Work.object.data.Primary [ ll_Row , li_transNdx ] = ls_Value
					
				NEXT // next column
				
			NEXT // next distrbution
		end if
	NEXT // next transaction				

end if

//Export contents of datastore to batch file
IF li_Return = 1 THEN
	DO
		li_result = lds_Work.saveas(ls_pathname, CSV!, false)
		IF li_result = -1 THEN
			IF messagebox(ls_message_header, "Could not save batch file.", exclamation!, &
				retrycancel!, 1) = 2 THEN
				ls_reject = ""
				li_Return = -1
				EXIT
			END IF
		END IF
	LOOP UNTIL li_result = 1
END IF

DESTROY lds_Work

RETURN li_return
end function

on n_cst_acctlink_daceasy.create
call super::create
end on

on n_cst_acctlink_daceasy.destroy
call super::destroy
end on

