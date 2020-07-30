$PBExportHeader$n_cst_acctlink_generic.sru
forward
global type n_cst_acctlink_generic from n_cst_acctlink
end type
end forward

global type n_cst_acctlink_generic from n_cst_acctlink
end type
global n_cst_acctlink_generic n_cst_acctlink_generic

type variables
private:
string		is_termscode, &
		is_type, &
		is_transtype, &
		is_MessageContext, &
		isa_transaction_columns[], &
		is_EarningsType
integer		ii_transactionsign, &
		ii_distributionsign

datastore		ids_work, &
		ids_AccountMap


end variables

forward prototypes
public function integer of_batch_create (n_cst_msg anv_msg)
public function integer of_validate_customers (datastore ads_list)
private function integer of_getfilesavename (string as_Title, ref string as_PathName, ref string as_Filename, String as_Extension, string as_Filter, string as_cancelWarning)
private function integer of_gettransactioncolumns (ref string asa_Columns[])
public function datastore of_datainitialization (string asa_transcolumns[])
private function integer of_loadcolumnheaders (string as_category)
public subroutine of_olddataload ()
private function integer of_accountentries (string asa_account[], decimal aca_amount[], string as_columnstart, long al_row)
private function integer of_distributionentries (string asa_account[], decimal aca_amount[], string as_columnstart, long al_row)
public function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
private function integer of_importfile (ref datastore ads_work, string as_filepath)
end prototypes

public function integer of_batch_create (n_cst_msg anv_msg);//Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch

/*
	Modified July 1st 2005: added seconds (ss) to the file save name 
*/

String	ls_Title, ls_PathName, ls_FileName, ls_Filter, ls_CancelWarning
String	ls_BatchFile, ls_BatchFilePath
String	ls_reportfile, ls_reportbk
Constant String	ls_Extension = "tsv"

String	ls_Message, ls_MessageHeader, ls_Reject
String	ls_Noco_SkipList, ls_Error_SkipList, ls_BatchType, ls_Work1, ls_Work2
String	ls_PostingCompany, lsa_TransactionColumns[], ls_Value

Long		ll_Trns, ll_Dist, ll_Noco_SkipCount, ll_Error_SkipCount, ll_Row
Long		ll_ndx, ll_count
Integer	li_Ndx, li_Result
Integer	li_SalesDistLimit, li_RecvDistLimit, li_SalesDistStart, li_RecvDistStart, &
			li_SalesDistCount, li_RecvDistCount, li_TransactionColumnCount
Boolean	lb_RowError
Boolean  lb_UseDefault
Boolean	lb_Repeat
Boolean	lb_append
Boolean	lb_reportfolder
Boolean	lb_foundreport

Int		li_AppendRtn
Int		li_ImportRtn

Int		li_BatchFolderRtn
Int		li_UseDefaultRtn
String	ls_Path

s_Accounting_Transaction	lstra_Trns[]
s_Accounting_Distribution	lstr_Dist


s_Parm			lstr_Parm
DataStore		lds_Work
n_ds				lds_BillingBatchReport,	lds_appendBatchReport

n_cst_bso_PSR_manager	lnv_PSR_manager
	
lnv_PSR_Manager = Create n_cst_bso_PSR_Manager 	
					
n_cst_fileSrvWin32	lnv_FileSrv
n_cst_dws		lnv_dws
ls_MessageHeader = "Create AR Batch"
ls_Reject = "Could not create AR batch."

ls_Title = "Specify Batch File Location"
	
ls_FileName = ""
ls_Filter = "TSV Files (*.tsv), *.tsv"

ls_CancelWarning = "You have indicated that you do not wish to create an AR Batch.~n~n"+&
	"PLEASE NOTE: The bills have already been processed, and you will not be able to "+&
	"recreate an AR Batch for them later."


//Extract parameters from message object that was passed in.

FOR li_Ndx = 1 TO anv_Msg.of_Get_Count ( )

	IF anv_Msg.of_Get_Parm ( li_Ndx, lstr_Parm ) > 0 THEN

		CHOOSE CASE lstr_Parm.is_Label

		CASE "BATCH_TYPE"
			ls_BatchType = lstr_Parm.ia_Value

		CASE "POSTING_COMPANY"
			ls_PostingCompany = lstr_Parm.ia_Value

		CASE "TRANSACTION"
			lstra_Trns [ UpperBound ( lstra_Trns ) + 1 ] = lstr_Parm.ia_Value

		CASE "BILLING BATCH REPORT"
			lds_BillingBatchReport = lstr_Parm.ia_Value
		
		END CHOOSE

	END IF

NEXT

//Validate requested batch type

CHOOSE CASE ls_BatchType
CASE "SALES!"
	//Batch type is OK
CASE ELSE
	GOTO Failure
END CHOOSE

//Initialize transaction and distribution column arrays
li_TransactionColumnCount = THIS.of_GetTransactionColumns ( lsa_TransactionColumns )

li_SalesDistLimit = 25
li_SalesDistStart = li_TransactionColumnCount + 1

FOR li_Ndx = 1 TO li_SalesDistLimit  //Allows up to x sales distributions per invoice

	li_TransactionColumnCount ++
	lsa_TransactionColumns [ li_TransactionColumnCount ] = &
		"SalesAcct" + String ( li_Ndx, "00" )
	li_TransactionColumnCount ++
	lsa_TransactionColumns [ li_TransactionColumnCount ] = &
		"SalesAmt" + String ( li_Ndx, "00" )

NEXT

li_RecvDistLimit = 25
li_RecvDistStart = li_TransactionColumnCount + 1

FOR li_Ndx = 1 TO li_RecvDistLimit  //Allows up to x receivables distributions per invoice

	li_TransactionColumnCount ++
	lsa_TransactionColumns [ li_TransactionColumnCount ] = &
		"RecvAcct" + String ( li_Ndx, "00" )
	li_TransactionColumnCount ++
	lsa_TransactionColumns [ li_TransactionColumnCount ] = &
		"RecvAmt" + String ( li_Ndx, "00" )

NEXT

//Set up datastore to hold batch information for export
lds_Work = of_CreateBatchDataStore ( lsa_TransactionColumns )

IF NOT IsValid ( lds_Work ) THEN
	GOTO Failure
END IF




//Get Batch File Name
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
	
	ls_PathName = String ( Now ( ), "mmddhhmmss" ) + ".tsv"
	
	IF li_BatchFolderRtn = 1 THEN
		ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + ".tsv"
	END IF

	
	IF THIS.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
		ls_Filter, ls_CancelWarning ) = -1 THEN
	
		RETURN -2
	
	END IF
	lnv_FileSrv = CREATE n_cst_fileSrvWin32
	lb_reportfolder = lnv_FileSrv.of_directoryexists ( replace(ls_PathName, pos(ls_pathname, ls_filename, 1), len(ls_filename), 'reports\') )
	DESTROY  lnv_FileSrv  
	if lb_reportfolder then								
		ls_reportfile = ls_PathName
		ls_reportfile = replace(ls_reportfile, pos(ls_reportfile, ls_extension, 1), len(ls_extension), "psr")
		ls_reportfile = replace(ls_pathname, pos(ls_pathname, ls_filename, 1), &
										len(ls_filename), 'reports\' + left(ls_filename,len(ls_filename) - 3) + "psr")
		if fileexists(ls_reportfile) then
			lb_foundreport=true
			ls_reportbk = replace(ls_reportfile, pos(ls_reportfile, '.psr', 1), 4, 'bk.psr')
		else
			lb_reportfolder = false
		end if
	end if
	
ELSE
	ls_FileName = String ( Now ( ), "mmddhhmmss")
	
	lnv_FileSrv = CREATE n_cst_fileSrvWin32
	lb_reportfolder = lnv_FileSrv.of_directoryexists ( ls_Path + 'reports\' )
	DESTROY  lnv_FileSrv  
	if lb_reportfolder then								
		//report name will be same as batch name
		ls_reportfile = ls_Path + 'reports\' + ls_FileName + ".psr"
		ls_reportbk = ls_Path + 'reports\' + ls_FileName + 'bk' + ".psr"
	end if
	
	ls_FileName +=  + "." + ls_extension
	ls_PathName = ls_Path + ls_FileName
	
END IF
ls_BatchFile = ls_FileName
ls_BatchFilePath = ls_PathName

// added for append
DO
	IF FileExists ( ls_pathname ) THEN
		lb_Repeat = TRUE
		li_AppendRtn = MessageBox ( "Batch Location" , "The specified file (" + ls_pathname + ") already exists. Do you want to append the new file to the existing file?~r~nSelect YES to append.~r~nSelect NO to choose another file name." , QUESTION!, YESNO! , 1 )
		CHOOSE CASE li_AppendRtn
				
			CASE 1

				li_ImportRtn = THIS.of_ImportFile ( lds_Work , ls_PathName ) 
				IF li_ImportRtn = 1 THEN
					lb_Append = TRUE
					lb_Repeat = FALSE
				ELSE
					MessageBox ( "Append to existing file", "The existing file could not be imported. You may retry the import or select another file.")
					IF THIS.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
						ls_Filter, ls_CancelWarning ) = -1 THEN
						RETURN -2
					END IF
				END IF
				
				
			CASE 2
	
				ls_FileName = ""
				IF THIS.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
					ls_Filter, ls_CancelWarning ) = -1 THEN
						RETURN -2
				END IF
				
				if lb_reportfolder then
					ls_reportfile = ls_PathName + ls_FileName + ".psr"
				end if
					
		END CHOOSE
		
	ELSE
		lb_Repeat = FALSE
	END IF
	
LOOP WHILE lb_Repeat


//// end of added for append



//Load transaction information into datastore

SetPointer ( HourGlass! )

FOR ll_Trns = 1 TO UpperBound ( lstra_Trns )

	lb_RowError = FALSE

	//Check for valid company

	IF Len ( lstra_Trns [ ll_Trns ].is_company_code ) > 0 THEN
		//Accounting ID is OK  (Company name isn't used)
	ELSE
		ll_Noco_SkipCount ++
		IF Len ( ls_Noco_SkipList ) > 0 THEN ls_Noco_SkipList += ", "
		ls_Noco_SkipList += lstra_Trns [ ll_Trns ].is_document_number
		CONTINUE
	END IF

	//Check for AR account (I deleted this)


	//Make Transaction entries

	ll_Row = lds_Work.InsertRow ( 0 )

	FOR li_Ndx = 1 TO li_TransactionColumnCount

		CHOOSE CASE lsa_TransactionColumns [ li_Ndx ]
		CASE "TransactionType"
			ls_Value = "INVOICE"
		CASE "CustomerId"
			ls_Value = lstra_Trns [ ll_Trns ].is_company_code
		CASE "CustomerName"
			ls_Value = lstra_Trns [ ll_Trns ].is_Company_Name
		CASE "InvoiceNumber"
			ls_Value = lstra_Trns [ ll_Trns ].is_document_number
		CASE "InvoiceDate"
			ls_Value = String ( lstra_Trns [ ll_Trns ].id_document_date, "mm/dd/yyyy" )
		CASE "InvoiceAmount"
			ls_Value = String ( lstra_Trns [ ll_Trns ].ic_document_amount, "0.00" )
		CASE "PaymentTerms"
			ls_Value = lstra_Trns [ ll_Trns ].is_Payment_Terms
		CASE "DueDate"
			ls_Value = String ( lstra_Trns [ ll_Trns ].id_payment_due, "mm/dd/yyyy" )
		CASE "TmpNumbers"
			ls_Value = of_GetTmpNumbers ( lstra_Trns [ ll_Trns ] )
		CASE "RefNumbers"
			ls_Value = of_GetReferenceNumbers ( lstra_Trns [ ll_Trns ] )
		CASE "RefList"
			ls_Value = of_GetReferenceList ( lstra_Trns [ ll_Trns ] )
		CASE ELSE
			ls_Value = ""
		END CHOOSE

		lds_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value

	NEXT


	//Make Distribution entries

	li_SalesDistCount = 0
	li_RecvDistCount = 0

	FOR ll_Dist = 1 TO UpperBound ( lstra_Trns [ ll_Trns ].istra_distributions )

		lstr_Dist = lstra_Trns [ ll_Trns ].istra_distributions [ ll_Dist ]

		IF lstr_Dist.ib_credit THEN

			li_SalesDistCount ++

			IF li_SalesDistCount > li_SalesDistLimit THEN
				lb_RowError = TRUE
				EXIT
			END IF
	
			ls_Value = lstr_Dist.is_account
			lds_Work.Object.Data.Primary [ ll_Row, &
				li_SalesDistStart + 2 * ( li_SalesDistCount - 1 ) ] = ls_Value
	
			ls_Value = String ( lstr_Dist.ic_amount, "0.00" )
			lds_Work.Object.Data.Primary [ ll_Row, &
				li_SalesDistStart + 2 * ( li_SalesDistCount - 1 ) + 1 ] = ls_Value

		ELSE

			li_RecvDistCount ++

			IF li_RecvDistCount > li_RecvDistLimit THEN
				lb_RowError = TRUE
				EXIT
			END IF
	
			ls_Value = lstr_Dist.is_account
			lds_Work.Object.Data.Primary [ ll_Row, &
				li_RecvDistStart + 2 * ( li_RecvDistCount - 1 ) ] = ls_Value
	
			ls_Value = String ( lstr_Dist.ic_amount, "0.00" )
			lds_Work.Object.Data.Primary [ ll_Row, &
				li_RecvDistStart + 2 * ( li_RecvDistCount - 1 ) + 1 ] = ls_Value

		END IF

	NEXT

	IF lb_RowError THEN
		ll_Error_SkipCount ++
		IF Len ( ls_Error_SkipList ) > 0 THEN ls_Error_SkipList += ", "
		ls_Error_SkipList += lstra_Trns [ ll_Trns ].is_document_number
		lds_Work.DeleteRow ( ll_Row )
		CONTINUE
	END IF

NEXT


//Export contents of datastore to batch file

DO

	li_Result = lds_Work.SaveAs ( ls_BatchFilePath, Text!, FALSE )

	IF li_Result = -1 THEN
		IF MessageBox ( ls_MessageHeader, "Could not save batch file.", Exclamation!, &
			RetryCancel!, 1 ) = 2 THEN

			ls_Reject = ""
			GOTO Failure

		END IF
	END IF

LOOP UNTIL li_Result = 1

if lb_reportfolder then
	if lds_BillingBatchReport.rowcount() > 0 then
		lnv_FileSrv = CREATE n_cst_fileSrvWin32	
		if lb_append then
			if lb_foundreport then
				//copy the report so it doesn't get replaced
				lnv_FileSrv.of_Filecopy ( ls_reportfile , ls_reportbk )					
			end if
			IF lnv_PSR_Manager.of_OpenPSR(ls_reportfile) = 1 Then 
				lds_appendBatchReport = Create n_ds
				lds_appendBatchReport.SettransObject(SQLCA)
				lds_appendBatchReport.DataObject = lnv_PSR_Manager.of_GetFileName()
				ll_count = lds_appendBatchReport.rowcount()
				lds_BillingBatchReport.rowscopy(1, ll_count, primary!, lds_appendBatchReport, lds_appendBatchReport.rowcount() + 1, Primary!)
				lds_appendBatchReport.SaveAs (ls_reportfile , PSReport!, TRUE )
			else
				DO
					IF FileExists ( ls_reportfile ) THEN
						messagebox('Billing Batch Report',  'Delete, move or rename the file ' + &
																ls_reportfile + ' and then click OK to continue.')
						lb_Repeat = TRUE		
					ELSE
						lb_Repeat = FALSE
					END IF
					
				LOOP WHILE lb_Repeat

				lds_BillingBatchReport.SaveAs (ls_reportfile , PSReport!, TRUE )

			end if
		else	
			lnv_FileSrv.of_FileRename ( ls_reportfile , ls_reportbk )					
			lds_BillingBatchReport.SaveAs (ls_reportfile , PSReport!, TRUE )
		end if	
		DESTROY  lnv_FileSrv  
	end if
	
	if isvalid(lds_BillingBatchReport) then
		destroy lds_BillingBatchReport
	end if
	
	if isvalid(lds_appendBatchReport) then
		destroy lds_appendBatchReport
	end if
	
end if

//Inform user of any invoices that were not included in the batch

IF ll_Noco_SkipCount > 0 or ll_Error_SkipCount > 0 THEN

	IF ll_Noco_SkipCount > 0 THEN

		IF ll_Noco_SkipCount = 1 THEN
			ls_Work1 = "invoice was"
			ls_Work2 = "company"
		ELSE
			ls_Work1 = String ( ll_Noco_SkipCount) + " invoices were"
			ls_Work2 = "companies"
		END IF

		ls_Message += "The following " + ls_Work1 + " not included in the AR batch because the " +&
			ls_Work2 + " being billed did not have a valid accounting ID:~n~n" +&
			ls_Noco_SkipList

	END IF

	IF ll_Error_SkipCount > 0 THEN

		IF ll_Error_SkipCount = 1 THEN
			ls_Work1 = "invoice was"
		ELSE
			ls_Work1 = String ( ll_Error_SkipCount) + " invoices were"
		END IF

		IF Len ( ls_Message ) > 0 THEN
			ls_Message += "~n~n"
		END IF

		ls_Message += "The following " + ls_Work1 + " not included in the AR batch because "+&
			"of processing errors:~n~n" + ls_Error_SkipList

	END IF

	MessageBox ( "Notes on AR Batch", ls_Message )

END IF

DESTROY lds_Work

RETURN 1


Failure:

IF Len ( ls_Reject ) > 0 THEN
	MessageBox ( ls_MessageHeader, ls_Reject, Exclamation! )
END IF

DESTROY lds_Work
destroy lnv_PSR_Manager

RETURN -1
end function

public function integer of_validate_customers (datastore ads_list);RETURN of_ValidateCustomerFile ( ads_List )
end function

private function integer of_getfilesavename (string as_Title, ref string as_PathName, ref string as_Filename, String as_Extension, string as_Filter, string as_cancelWarning);// THIS should be moved to the file srv object in core. 
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

private function integer of_gettransactioncolumns (ref string asa_Columns[]);asa_Columns = { &
	"TransactionType", &
	"CustomerId", &
	"CustomerName", &
	"InvoiceNumber", &
	"InvoiceDate", &
	"InvoiceAmount", &
	"PaymentTerms", &
	"DueDate", &
	"TmpNumbers", &
	"RefNumbers", &
	"RefList", &
	"Reserved01", &
	"Reserved02", &
	"Reserved03", &
	"Reserved04", &
	"Reserved05", &
	"Reserved06", &
	"Reserved07", &
	"Reserved08", &
	"Reserved09", &
	"Reserved10", &
	"Reserved11", &
	"Reserved12", &
	"Reserved13", &
	"Reserved14", &
	"Reserved15", &
	"Reserved16", &
	"Reserved17", &
	"Reserved18", &
	"Reserved19", &
	"Reserved20" }
	
RETURN UpperBound ( asa_Columns )
end function

public function datastore of_datainitialization (string asa_transcolumns[]);/*
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

////Put column headers into datastore
//IF li_Return = 1 THEN
//
//	setpointer(hourglass!)
//	
//	ll_row = lds_work.insertrow(0)
//	FOR li_ndx = 1 TO li_TransColumnCount
//		lds_work.object.data.primary[ll_row, li_ndx] = asa_transcolumns [][li_ndx]
//	NEXT
//
//END IF

RETURN lds_work
end function

private function integer of_loadcolumnheaders (string as_category);integer	li_ndx

Choose case upper( as_category )
	case "PAYABLES"
		is_TermsCode = "TV"   
		is_type = "AP"
		is_TransType = "/PAYABLE"  
		is_MessageContext = "AP"
		ii_TransactionSign = -1
		ii_DistributionSign = 1
		isa_transaction_columns = { &
						"TransactionLabel", &
						"VendorID", &
						"InvoiceNumber", &
						"InvoiceDate", &
						"InvoiceAmount", &
						"InvoiceReference", &
						"DueDate_TermsCode", &
						"DiscountAvailable", &
						"DiscountDate" }		
		FOR li_Ndx = 1 TO 20  //allow up to 20 distributions 
			
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				"DistAcct" + String ( li_Ndx, "00" )
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				"DistAmt" + String ( li_Ndx, "00" )
		NEXT
		
		FOR li_Ndx = 1 TO 20  //allow up to 20 ap accounts
			
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				is_type + "Acct" + String ( li_Ndx, "00" )
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				is_type + "Amt" + String ( li_Ndx, "00" )
		NEXT
		
	case "RECEIVABLES"
		is_TermsCode = "TC" 
		is_MessageContext	= "AR"
		is_type = "AR"
		is_TransType = "/INVOICE" 
		ii_TransactionSign = 1
		ii_DistributionSign = -1
		isa_transaction_columns = { &
						"TransactionLabel", &
						"CustomerId", &
						"InvoiceNumber", &
						"InvoiceDate", &
						"InvoiceAmount", &
						"InvoiceDescription", &
						"DueDate_TermsCode", &
						"DiscountAvailable", &
						"DiscountDate", &
						"SalesRepNumber", &
						"DefaultSalesAcct", &
						"FreightAmount", &
					/*	"TaxableSubtotal", &  This is only included if TAXSPLIT is specified as an import option*/ &
						"TaxAmount1", &
						"TaxId1", &
						"TaxAmount2", &
						"TaxId2", &
						"TaxAmount3", &
						"TaxId3" }	
						
		FOR li_Ndx = 1 TO 16  //BusinessWorks allows up to 16 sales distributions per invoice
	
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				"SalesAcct" + String ( li_Ndx, "00" )
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				"SalesAmt" + String ( li_Ndx, "00" )

		NEXT		
	case "PAYROLL"
		is_MessageContext	= "PR"
		is_type = "PR"
		is_EarningsType = "MISC"
		ii_DistributionSign = 1
		isa_transaction_columns = { &
						"EmployeeId", &
						"GrossWages" }
		FOR li_Ndx = 1 TO 20  //allows up to 20 distributions
			
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				"DistAcct" + String ( li_Ndx, "00" )
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				"DistAmt" + String ( li_Ndx, "00" )
		NEXT

		FOR li_Ndx = 1 TO 20  //allow up to 20 cash accounts
			
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				is_type + "Acct" + String ( li_Ndx, "00" )
			isa_transaction_columns [ UpperBound ( isa_transaction_columns ) + 1 ] = &
				is_type + "Amt" + String ( li_Ndx, "00" )
		NEXT
		

end choose

return upperbound(isa_transaction_columns)

end function

public subroutine of_olddataload ();///*
//	These file formats are based on business works with a few alterations.
//	Some columns which don't make sense were left in because customers already
//	had mappings to their accounting package based on businessworks.
//*/
//
//SetPointer(HourGlass!)
//
//Boolean	lb_RowError
//
//string	ls_reject, &
//			ls_Error_SkipList, &
//			ls_messageheader, &
//			ls_pathname, &
//			ls_filename, &
//			ls_EntityName, &
//			ls_value, &
//			ls_FindString, &
//			ls_transactionaccount
//			
//
//Integer	li_Return, &
//			li_ndx, &
//			li_result, &
//			li_AmountType, &
//			li_Division
//
//Long		ll_TransactionCount, &
//			ll_distributioncount, &
//			ll_trns, &
//			ll_dist, &
//			ll_error_skipcount, &
//			ll_TransactionColumnCount, &
//			ll_row, &
//			ll_FindRow, &
//			ll_Winner
//			
//Dec {2}	lc_check, &
//			lc_AmountOwed
//			
//n_cst_beo_Transaction	lnv_CurrentTransaction
//n_cst_beo_AmountOwed		lnva_AmountsOwed [ ]
//n_cst_beo_AmountOwed		lnv_CurrentAmountOwed
//n_cst_beo_Entity			lnv_CurrentEntity
//n_cst_dws					lnv_dws
//			
//li_Return = 1
//
//ll_TransactionColumnCount = this.of_loadcolumnheaders(as_category)
//
//ls_messageheader = "Create " + is_type + " Batch"
//ls_reject = "Could not create "+ is_type + " batch."
//ll_TransactionCount = upperBound	( anva_Transactions )
//
////Get Batch File Name
//IF li_Return = 1 THEN
//	li_Return = this.of_getbatchfilename("tsv",is_MessageContext, ls_filename, ls_pathname)
//	//	returns 1 (success) or -1 (failure)
//END IF
//
//lnv_dws.of_CreateDataStoreByDataObject ( "d_dlkc_accountmap", ids_AccountMap, FALSE )
//ids_AccountMap.Retrieve()
//
//IF li_Return = 1 then
//	ids_work = this.of_datainitialization( isa_transaction_columns [] )
//	IF NOT IsValid ( ids_Work ) THEN
//		li_Return = -1
//	END IF
//END IF
//
//
//IF li_Return = 1 THEN
//
//	SetPointer ( HourGlass! )
//
//	FOR ll_Trns = 1 TO ll_TransactionCount
//	
//		lb_RowError = FALSE
//		
//		// load current transaction into a local var
//		lnv_CurrentTransaction = anva_transactions [ ll_trns ]
//		
//		// load all associated AmountsOwed into local Var
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
//			IF lc_AmountOwed * ii_DistributionSign > lc_check then
//				lc_check = lnv_CurrentAmountOwed.of_GetAmount ( ) * ii_DistributionSign
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
//		ll_FindRow = ids_AccountMap.Find ( ls_FindString, 1, ids_AccountMap.RowCount() )
//		
///*  If we want to use this method for receivables 
//		then we will have to copy the 	//Check for AR account
//		
//		logic from of_batch_create
//*/
//
//		IF ll_FindRow > 0 THEN
//			CHOOSE CASE is_type
//				CASE "AP"
//					ls_EntityName = lnv_CurrentEntity.of_GetPayablesId ( )
//					ls_TransactionAccount = ids_AccountMap.Object.accountmap_apaccount[ll_FindRow]
//		
//				CASE "AR"
//		//			ls_EntityName = lnv_CurrentEntity.of_GetReceivablesId ( )
//		//			ls_TransactionAccount = ids_AccountMap.Object.accountmap_araccount[ll_FindRow]
//		
//				CASE "PR"
//					ls_EntityName = lnv_CurrentEntity.of_GetPayrollId ( )
//					ls_TransactionAccount = ids_AccountMap.Object.accountmap_payrollcashaccount[ll_FindRow]
//		
//			END CHOOSE
//		END IF
//	
//		//Make Transaction entries
//	
//		ll_Row = ids_Work.InsertRow ( 0 )
//	
//		FOR li_Ndx = 1 TO ll_TransactionColumnCount
//			
//			ls_value = ""
//	
//			CHOOSE CASE isa_transaction_columns [ li_Ndx ]
//					
//			CASE "TransactionLabel"
//				ls_Value = is_TransType
//				
//			CASE "CustomerID", "VendorID", "EmployeeId"
//				ls_Value = ls_EntityName
//				
//			CASE "InvoiceNumber"
//				ls_Value = lnv_CurrentTransaction.of_GetDocumentNumber ( )
//			CASE "InvoiceDate"
//				ls_Value = String ( lnv_CurrentTransaction.of_GetDocumentDate ( ) , "mm/dd/yy" )
//				
//			CASE "InvoiceAmount", "GrossWages"
//				ls_Value = String ( lnv_CurrentTransaction.of_GetPreTaxNet  ( )  )
//				
//			CASE "InvoiceDescription", "InvoiceReference"
//				ls_Value = lnv_CurrentTransaction.of_getDescription (  )
//				
//			CASE "DueDate_TermsCode"
//				ls_Value = is_TermsCode
//								
//			CASE "EarningsType"
//				ls_Value = is_EarningsType
//
//			CASE "PLACEHOLDER"
//				ls_Value = ""
//				
//			CASE "DiscountAvailable"
//				ls_Value = ""
//				
//			CASE "DiscountDate"
//				ls_Value = ""
//				
//			CASE ELSE
//				ls_Value = ""
//				
//			END CHOOSE
//	
//			ids_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
//	
//		NEXT
//		
//		//distribution entries
//		this.of_distributionentries(lnva_AmountsOwed, "DistAcct01", ll_Row)
//		
//		//payable or cash account entries
//		this.of_accountentries(lnva_AmountsOwed, is_type + "Acct01", ll_Row)
//		
//	NEXT
//
//END IF
//
////Export contents of datastore to batch file
//IF li_Return = 1 THEN
//	DO
//		li_result = ids_Work.saveas(ls_pathname, text!, false)
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
//DESTROY ids_Work
//DESTROY ids_AccountMap
//RETURN 1
end subroutine

private function integer of_accountentries (string asa_account[], decimal aca_amount[], string as_columnstart, long al_row);
string	ls_findstring, &
			ls_account, &
			lsa_account[]
			
decimal	lca_amount[]

integer	li_ndx, &
			li_division, &
			li_amounttype

long		ll_transactioncolumncount, &
			ll_distributioncount, &
			ll_dist, &
			ll_findrow, &
			ll_ndx, &
			ll_arraycount

boolean	lb_accountfound

ll_transactioncolumncount = upperbound(isa_transaction_columns)
ll_distributioncount = UpperBound ( asa_account )

//get total of all unique accounts
for ll_dist = 1 to ll_distributioncount

	ls_account = asa_account[ll_dist]

	//is account type already in array
	lb_accountfound=false
	ll_arraycount = upperbound(lsa_account)
	for ll_ndx = 1 to ll_arraycount
		if ls_Account = lsa_account[ll_ndx] then
			lb_accountfound=true
			exit
		end if
	next
	if lb_accountfound then
		lca_amount[ll_ndx] += aca_amount[ll_dist]
	else
		lsa_account[ll_arraycount + 1] = ls_account
		lca_amount[ll_arraycount + 1] = aca_amount[ll_dist]
	end if
next

FOR li_Ndx = 1 TO ll_transactioncolumncount
	// Stop when the first distribution column is reached
	IF isa_transaction_columns [ li_Ndx ] = as_columnstart THEN  // ie: "APAcct01"
		EXIT
	END IF

NEXT

if li_ndx > ll_transactioncolumncount then
	//problem
else

	IF isa_transaction_columns [ li_Ndx ] = as_columnstart THEN
	
		ll_arraycount = upperbound(lsa_account)
	
		FOR ll_Dist = 1 TO ll_arraycount
		
			//only allow 20 distributions
			IF ll_Dist + 1 > 20 THEN
				EXIT
			END IF	
		
			ids_Work.Object.Data.Primary [ al_Row, li_Ndx ] = lsa_account[ll_Dist]
		
			li_Ndx ++
			ids_Work.Object.Data.Primary [ al_Row, li_Ndx ] = String ( lca_amount[ll_dist] , "0.00" )
		
			li_Ndx ++
		
		NEXT	
	end if
end if

return 1
end function

private function integer of_distributionentries (string asa_account[], decimal aca_amount[], string as_columnstart, long al_row);
string	ls_findstring, &
			ls_distributionaccount, &
			ls_value
			
integer	li_ndx, &
			li_division, &
			li_amounttype

long		ll_transactioncolumncount, &
			ll_distributioncount, &
			ll_dist, &
			ll_findrow

ll_transactioncolumncount = upperbound(isa_transaction_columns)
ll_distributioncount = UpperBound ( asa_account )
FOR li_Ndx = 1 TO ll_transactioncolumncount
	// Stop when the first distribution column is reached
	IF isa_transaction_columns [ li_Ndx ] = as_columnstart THEN  // ie: "distAcct01"
		EXIT
	END IF

NEXT

if li_ndx > ll_transactioncolumncount then
	//problem
else
	IF isa_transaction_columns [ li_Ndx ] = as_columnstart THEN
	
		FOR ll_Dist = 1 TO ll_distributioncount
			
			// Get Associated Amount Owed
			//only allow 20 distributions
			IF ll_Dist + 1 > 20 THEN
				EXIT
			END IF	
		
			ls_Value = asa_account[ll_Dist]
			ids_Work.Object.Data.Primary [ al_Row, li_Ndx ] = ls_Value
		
			li_Ndx ++
			
			ls_Value = String ( aca_amount[ll_Dist] , "0.00" )
			ids_Work.Object.Data.Primary [ al_Row, li_Ndx ] = ls_Value
		
			li_Ndx ++
		
		NEXT	
	end if
end if

return 1
end function

public function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);/*
	These file formats are based on business works with a few alterations.
	Some columns which don't make sense were left in because customers already
	had mappings to their accounting package based on businessworks.
*/

SetPointer(HourGlass!)

Boolean	lb_RowError

string	ls_reject, &
			ls_Error_SkipList, &
			ls_messageheader, &
			ls_pathname, &
			ls_filename, &
			ls_EntityName, &
			ls_value, &
			ls_FindString, &
			ls_category, &
			ls_EntityId, &
			ls_transactionaccount, &
			lsa_account[], &
			lsa_transaction_columns[]
			

Integer	li_Return, &
			li_ndx, &
			li_result, &
			li_AmountType, &
			li_Division

Long		ll_TransactionCount, &
			ll_distributioncount, &
			ll_distributioncolumncount, &
			ll_trns, &
			ll_dist, &
			ll_error_skipcount, &
			ll_TransactionColumnCount, &
			ll_row, &
			ll_FindRow, &
			ll_Winner
			
Dec {2}	lc_check, &
			lc_AmountOwed, &
			lca_amountowed[]
			
n_cst_accountingdata		lnv_accountingdata

li_Return = 1
ls_category = anva_accountingdata[1].of_GetCategory ( )

ll_TransactionColumnCount = this.of_loadcolumnheaders(ls_category)

ls_messageheader = "Create " + is_type + " Batch"
ls_reject = "Could not create "+ is_type + " batch."
ll_TransactionCount = upperBound	( anva_accountingdata )

//Get Batch File Name
IF li_Return = 1 THEN
	li_Return = this.of_getbatchfilename("tsv",is_MessageContext, ls_filename, ls_pathname)
	//	returns 1 (success) or -1 (failure)
END IF

IF li_Return = 1 then
	ids_work = this.of_datainitialization( isa_transaction_columns [] )
	IF NOT IsValid ( ids_Work ) THEN
		li_Return = -1
	END IF
END IF


IF li_Return = 1 THEN

	SetPointer ( HourGlass! )

	FOR ll_Trns = 1 TO ll_TransactionCount
	
		lb_RowError = FALSE
		
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
		
		//Make Transaction entries
		ll_row = ids_work.insertrow(0)

		FOR li_Ndx = 1 TO ll_TransactionColumnCount
			
			ls_value = ""
	
			CHOOSE CASE isa_transaction_columns [ li_Ndx ]
					
			CASE "TransactionLabel"
				ls_Value = is_TransType
				
			CASE "CustomerID", "VendorID", "EmployeeId"
				ls_Value = ls_EntityId
				
			CASE "InvoiceNumber"
				ls_Value = string(lnv_accountingdata.of_GetDocumentNumber ( )	)
			CASE "InvoiceDate"
				ls_Value = string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY")
				
			CASE "InvoiceAmount", "GrossWages"
				ls_Value = string(lnv_accountingdata.of_getPreTaxNet ( ))
				
			CASE "InvoiceDescription", "InvoiceReference"
				ls_Value = lnv_accountingdata.of_getDescription (  )
				
			CASE "DueDate_TermsCode"
				ls_Value = is_TermsCode
								
			CASE "EarningsType"
				ls_Value = is_EarningsType

			CASE "PLACEHOLDER"
				ls_Value = ""
				
			CASE "DiscountAvailable"
				ls_Value = ""
				
			CASE "DiscountDate"
				ls_Value = ""
				
			CASE ELSE
				ls_Value = ""
				
			END CHOOSE
	
			ids_Work.Object.Data.Primary [ ll_Row, li_Ndx ] = ls_Value
	
		NEXT
		
		//distribution entries
		lnv_accountingdata.of_Getcostexpenseaccount ( lsa_Account )
		this.of_distributionentries(lsa_Account,lca_AmountOwed, "DistAcct01", ll_Row)
		
		//payable or cash account entries
		lnv_accountingdata.of_Getapcashaccount ( lsa_Account )
		this.of_accountentries(lsa_Account, lca_AmountOwed, is_type + "Acct01", ll_Row)
		
	NEXT

END IF

//Export contents of datastore to batch file
IF li_Return = 1 THEN
	DO
		li_result = ids_Work.saveas(ls_pathname, text!, false)
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

DESTROY ids_Work
DESTROY ids_AccountMap
RETURN 1
end function

private function integer of_importfile (ref datastore ads_work, string as_filepath);// switch the file name to a .txt  Import the file and switch the name back to its original 
// file name
String	ls_SourceFile 
String	ls_TargetFile
Boolean	lb_Renamed
Int		li_ImportRtn
Int		li_Return = -1

ls_SourceFile = as_FilePath
ls_TargetFile = Left ( Trim ( as_FilePath ), ( Len ( Trim ( as_FilePath ) ) - 3 ) ) + "txt"

n_cst_fileSrvWin32	lnv_FileSrv
lnv_FileSrv = CREATE n_cst_fileSrvWin32

IF lnv_FileSrv.of_FileRename ( ls_SourceFile , ls_TargetFile ) = 1 THEN
	
	lb_Renamed = TRUE
	li_ImportRtn = ads_Work.ImportFile ( ls_TargetFile )
	IF li_ImportRtn >=1 THEN  
		li_Return = 1 // success here
	END IF
	
END IF

IF lb_Renamed THEN  // even if the import fails we still want to rename the file back
	 lnv_FileSrv.of_FileRename ( ls_TargetFile , ls_SourceFile   )
END IF
	
DESTROY  lnv_FileSrv  
RETURN li_Return
end function

on n_cst_acctlink_generic.create
call super::create
end on

on n_cst_acctlink_generic.destroy
call super::destroy
end on

