$PBExportHeader$n_cst_acctlink_quickbooks.sru
$PBExportComments$[n_cst_AcctLink]
forward
global type n_cst_acctlink_quickbooks from n_cst_acctlink
end type
end forward

global type n_cst_acctlink_quickbooks from n_cst_acctlink
end type
global n_cst_acctlink_quickbooks n_cst_acctlink_quickbooks

forward prototypes
public function integer of_batch_create (n_cst_msg anv_cst_msg)
public function integer of_validate_customers (datastore ads_list)
public function integer of_getvalidationfile (ref string as_filename, string as_filetype)
public function integer of_validatenames (string as_filename, string asa_names[], long ala_ids[], ref long ala_invalidids[])
private function string of_parsename (string as_source)
private function integer of_importfile (ref datastore ads_work, string as_filepath)
private function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_cancelwarning)
private function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
protected function datastore of_datainitialization (string asa_transcolumns[], string asa_distcolumns[])
end prototypes

public function integer of_batch_create (n_cst_msg anv_cst_msg);//Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch

// 
//		THERE ARE MID CODE RETURNS IN THIS SCRIPT
//


/*
	Modified July 1st 2005: added seconds (ss) to the file save name 
*/


string ls_err_skiplist, ls_work1, ls_message, ls_batch_type, ls_ar_account
long ll_trns, ll_dist, ll_err_skipcount

integer li_ndx, li_result, li_winner
s_parm lstr_parm
n_cst_msg lnv_cst_msg
s_accounting_transaction lstra_trns[]
s_accounting_distribution lstr_dist

String	ls_Title, ls_PathName, ls_FileName, ls_Filter, ls_CancelWarning
Constant String	ls_Extension = "iif"
n_cst_File	lnv_File

string ls_message_header, ls_reject
string lsa_transaction_columns[], lsa_distribution_columns[]
string lsa_check[], lsa_empty[], ls_value
datastore lds_work
decimal {2} lc_check
long ll_row

Int		li_UseDefaultRtn
Int		li_batchFolderRtn
Int		li_AppendRtn
Int		li_ImportRtn
String	ls_Path
Boolean	lb_UseDefault

Boolean	lb_Append,&
			lb_Repeat

String	ls_POLabels	//Added 3.5.15 BKW 9-16-2002

//There was some freaky behavior here.  I was declaring the following two variables
//below ( i.e. :  string ls_message_header = "Create AR Batch" ) and somehow the
//value was being set (consistently) to another string value from outside this object!
//The separate declaration / value assignment works fine, however.

ls_message_header = "Create AR Batch"
ls_reject = "Could not create AR batch."


ls_CancelWarning = "You have indicated that you do not wish to create an AR Batch.~n~n"+&
		"PLEASE NOTE: The bills have already been processed, and you will not be able to "+&
		"recreate an AR Batch for them later."
	
ls_Title = "Specify Batch File Location"
ls_Filter = "IIF Files (*.iif), *.iif"  //"IIF Files (*.iif), *.iif, All Files (*.*), *.*"



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

//Get Batch File Name
li_UseDefaultRtn = THIS.of_UseDefaultBatchName ( )

//           1 = Success, YES!
//				 2 = Success, NO!
//				 3 = success, ASK!
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

CHOOSE CASE li_useDefaultRtn
	CASE -1 ,0 ,3
		IF	MessageBox ( "Default Batch Name" , "Do you wish to use the default AR batch name?", QUESTION!, YESNO!, 1 ) = 1 THEN
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
	
	ls_PathName = String ( Now ( ), "mmddhhmmss") + ".iif"
	
	IF li_BatchFolderRtn = 1 THEN
		ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + ".iif"
	END IF
	
	ls_FileName = ""
	
	IF THIS.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
		ls_Filter, ls_CancelWarning ) = -1 THEN
			RETURN -2
	END IF
	
ELSE
	
	ls_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	ls_FileName = String ( Now ( ), "mmddhhmmss") + "." + ls_extension
	
END IF


//Get the list of Reference Labels that will be pulled to populate the PONUM field (added 3.5.15 BKW 09-16-2002)

ls_POLabels = This.of_GetPOLabels ( )


//Initialize transaction and distribution column arrays
lsa_transaction_columns = {"!TRNS", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM", "MEMO", "DUEDATE", "TERMS", "PONUM"}  //PONUM added 3.5.15 BKW
lsa_distribution_columns = {"!SPL", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM", "INVITEM", "TAXABLE"}


//Set up datastore to hold batch information for export

lds_Work = of_CreateBatchDataStore ( &
	Max ( UpperBound ( lsa_transaction_columns ), UpperBound ( lsa_distribution_columns) ) )

IF NOT IsValid ( lds_Work ) THEN
	GOTO Failure
END IF

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
		END CHOOSE
		
	ELSE
		lb_Repeat = FALSE
	END IF
	
LOOP WHILE lb_Repeat

setpointer(hourglass!)	

IF Not lb_Append THEN
	
	//Put column headers into datastore
	ll_row = lds_work.insertrow(0)
	
	for li_ndx = 1 to upperbound(lsa_transaction_columns)
		lds_work.object.data.primary[ll_row, li_ndx] = lsa_transaction_columns[li_ndx]
	next
	
	ll_row = lds_work.insertrow(0)
	
	for li_ndx = 1 to upperbound(lsa_distribution_columns)
		lds_work.object.data.primary[ll_row, li_ndx] = lsa_distribution_columns[li_ndx]
	next
	
	ll_row = lds_work.insertrow(0)
	
	lds_work.object.data.primary[ll_row, 1] = "!ENDTRNS"


END IF
	

//Load transaction information into datastore

for ll_trns = 1 to upperbound(lstra_trns)

	//Check for valid company (I deleted this)

	//Check for AR account

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

	ll_row = lds_work.insertrow(0)

	for li_ndx = 1 to upperbound(lsa_transaction_columns)
		
		ls_value = ""

		choose case lsa_transaction_columns[li_ndx]
		case "!TRNS"
			ls_value = "TRNS"
		case "TRNSTYPE"
			ls_value = "INVOICE"
		case "DATE"
			ls_value = string(lstra_trns[ll_trns].id_document_date, "mm/dd/yyyy")
		case "ACCNT"
			ls_value = ls_ar_account
		case "NAME"
			ls_value = lstra_trns[ll_trns].is_company_name
		case "AMOUNT"
			ls_value = string(lstra_trns[ll_trns].ic_document_amount, "0.00")
		case "DOCNUM"
			ls_value = lstra_trns[ll_trns].is_document_number
		case "MEMO"
			ls_Value = of_GetReferenceList ( lstra_Trns [ ll_Trns ] )
		case "DUEDATE"
			ls_value = string(lstra_trns[ll_trns].id_payment_due, "mm/dd/yyyy")
		case "TERMS"
			if len(lstra_trns[ll_trns].is_payment_terms) > 0 then &
				ls_value = lstra_trns[ll_trns].is_payment_terms else ls_value = ""
		case "PONUM"  //Added 3.5.15 BKW  9-16-2002
			ls_Value = This.of_GetReferenceNumbersByLabel ( lstra_Trns [ ll_Trns ], ls_POLabels )
		case else
			ls_value = ""
		end choose

		lds_work.object.data.primary[ll_row, li_ndx] = ls_value

	next

	//Make Distribution entries

	for ll_dist = 1 to upperbound(lstra_trns[ll_trns].istra_distributions)

		lstr_dist = lstra_trns[ll_trns].istra_distributions[ll_dist]
		if lstr_dist.ib_credit = false then continue

		ll_row = lds_work.insertrow(0)

		for li_ndx = 1 to upperbound(lsa_distribution_columns)
			
			ls_value = ""

			choose case lsa_distribution_columns[li_ndx]
			case "!SPL"
				ls_value = "SPL"
			case "TRNSTYPE"
				ls_value = "INVOICE"
			case "DATE"
				ls_value = string(lstra_trns[ll_trns].id_document_date, "mm/dd/yyyy")
			case "ACCNT"
				ls_value = lstr_dist.is_account
			case "NAME"
				ls_value = lstra_trns[ll_trns].is_company_name
			case "AMOUNT"
				ls_value = string(lstr_dist.ic_amount * -1, "0.00")
			case "DOCNUM"
				ls_value = lstra_trns[ll_trns].is_document_number
			case "INVITEM"
				ls_value = "Profit Tools"
			case "TAXABLE"
				ls_value = "N"
			case else
				ls_value = ""
			end choose

			lds_work.object.data.primary[ll_row, li_ndx] = ls_value

		next
	next

	//Add End Transaction Entry

	ll_row = lds_work.insertrow(0)
	lds_work.object.data.primary[ll_row, 1] = "ENDTRNS"

next


//Export contents of datastore to batch file

do
	li_result = lds_work.saveas(ls_pathname, text!, false)

	if li_result = -1 then
		if messagebox(ls_message_header, "Could not save batch file.", exclamation!, &
			retrycancel!, 1) = 2 then
				ls_reject = ""
				goto failure
		end if
	end if
loop until li_result = 1


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

destroy lds_work
return 1


failure:

if len(ls_reject) > 0 then messagebox(ls_message_header, ls_reject, exclamation!)
destroy lds_work
return -1
end function

public function integer of_validate_customers (datastore ads_list);//Returns the number of entries in the primary buffer that do not pass validation 
//(0 = All OK.)  Returns -1 if an error occurs, and -3 if user chooses Cancel Billing.
n_cst_anyarraysrv lnv_anyarray

String	ls_MessageHeader, ls_Title, ls_PathName, ls_FileName, ls_Extension, ls_Filter, &
			lsa_CustList[], ls_Work, ls_AcctName, lsa_RejectList[], ls_Message
Integer	li_Result, li_FileId, li_Pos, li_InvalidCount
Long		ll_Row, ll_Count, ll_Ndx
Int		li_FileReturn
String	lsa_Result[]
String	ls_ValidationFile

n_cst_String lnv_String


ls_MessageHeader = "Validate Customers"

ls_Message = "Do you want to validate the customers being billed in this batch against "+&
	"an exported QuickBooks customer list?"


IF MessageBox ( ls_MessageHeader, ls_Message, Question!, YesNo!, 1 ) = 1 THEN

	li_FileReturn = THIS.of_GetCustomerFile ( ls_ValidationFile )


	ls_Title = "Specify Customer File Location"
	ls_PathName = ""
	ls_FileName = ""
	ls_Extension = "iif"
	ls_Filter = "IIF Files (*.iif), *.iif, All Files (*.*), *.*"

	IF li_FileReturn <> 1 THEN
		//initdirectory
		string	ls_directory, &
					ls_file, &
					ls_drive
		n_cst_filesrvwin32	lnv_filesrv
		lnv_filesrv = create n_cst_filesrvwin32
		lnv_filesrv.of_ParsePath(ls_ValidationFile, ls_Drive, ls_directory, ls_File)
		destroy lnv_filesrv
	
		
		DO
			li_Result = GetFileOpenName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
				ls_Filter, ls_drive + ls_directory )
		
			CHOOSE CASE li_Result
			CASE 1
				//No processing needed
			CASE ELSE
	
				ls_FileName = ""
	
				IF li_Result = 0 THEN
					//User chose cancel in filename dialog.  Proceed to warning.
				ELSE
					//There was an error in filename dialog.
	
					ls_Message = "Error attempting to determine customer filename."
	
					IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, RetryCancel!, 1 ) = 1 THEN
						CONTINUE
					ELSE
						//Proceed to warning
					END IF
				END IF
	
				ls_Message = "Are you sure you want to skip the customer validation process?"
	
				IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
					CONTINUE
				ELSE
					EXIT
				END IF
		
			END CHOOSE
			
		
		LOOP UNTIL Len ( ls_FileName ) > 0
	ELSE
		ls_PathName = ls_ValidationFile
		lnv_String.of_ParseToArray ( ls_PathName, "\" , lsa_Result )
		ls_FileName = lsa_Result [ UpperBound ( lsa_Result ) ] 
	END IF

ELSE
	ls_FileName = ""
END IF

IF Len ( ls_FileName ) > 0 THEN

	DO

		li_FileId = FileOpen ( ls_PathName, LineMode!, Read!, LockWrite! )

		IF li_FileId = -1 THEN

			ls_Message = "Could not open the file ~"" + ls_PathName +&
				"~", possibly because the file is already in use."

			IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, RetryCancel!, 1 ) = 2 THEN 

				ls_Message = "Are you sure you want to skip the customer validation process?"

				IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
					CONTINUE
				ELSE
					EXIT
				END IF
			END IF
		END IF

	LOOP UNTIL li_FileId >= 0

	IF li_FileId >= 0 THEN

		DO

			ls_Work = ""
			li_Result = FileRead ( li_FileId, ls_Work )

			IF li_Result > 0 THEN

				IF Left ( ls_Work, 5 ) = "CUST~t" THEN

					ls_Work = Replace ( ls_Work, 1, 5, "" )
					li_Pos = Pos ( ls_Work, "~t" )

					IF li_Pos > 1 THEN
						ls_Work = Left ( ls_Work, li_Pos - 1 )
					END IF

					IF Left ( ls_Work, 1 ) = "~"" THEN
						ls_Work = Replace ( ls_Work, 1, 1, "" )
					END IF

					IF Right ( ls_Work, 1 ) = "~"" THEN
						ls_Work = Left ( ls_Work, Len ( ls_Work ) - 1 )
					END IF

					lsa_CustList [ UpperBound ( lsa_CustList ) + 1 ] = Upper ( ls_Work )

				END IF

			END IF

		LOOP WHILE li_Result >= 0

		FileClose ( li_FileId ) //Error Check??

		ll_Count = UpperBound ( lsa_CustList )

		FOR ll_Row = 1 TO ads_List.RowCount ( )
		
			ls_AcctName = Upper ( ads_List.Object.xx_acct_name [ ll_Row ] )
			IF lnv_anyarray.of_Find ( lsa_CustList, ls_AcctName, 1, ll_Count ) > 0 THEN
				CONTINUE
			END IF
			lsa_RejectList [ UpperBound ( lsa_RejectList ) + 1 ] = ls_AcctName

		NEXT

		ll_Count = UpperBound ( lsa_RejectList )

		IF ll_Count > 0 THEN

			ls_Work = ""

			FOR ll_Ndx = 1 TO ll_Count
				ls_Work += lsa_RejectList [ ll_Ndx ] + "~n"
			NEXT

			ls_Message = "The following Profit Tools companies do not have an exact match in "+&
				"QuickBooks:~n~n" + ls_Work + "~nIf you proceed, QuickBooks will create "+&
				"new customer entries with these names when you import the batch."+&
				"~n~nDo you want to proceed?"

			IF MessageBox ( ls_MessageHeader, ls_Message, None!, YesNo!, 2 ) = 2 THEN
				RETURN -3
			END IF

		END IF
	END IF

END IF

//Mark all companies in list as valid

FOR ll_Row = 1 TO ads_List.RowCount ( )
	ads_List.Object.approved [ ll_Row ] = "T"
NEXT

li_InvalidCount = 0
RETURN li_InvalidCount
end function

public function integer of_getvalidationfile (ref string as_filename, string as_filetype);
//RDT 02-20-03 - Checks for direct connect. If true we skip this step.

//Returns the number of entries in the primary buffer that do not pass validation 
//(0 = All OK.)  Returns -1 if an error occurs, and -3 if user chooses Cancel Billing.

String	ls_MessageHeader, &
			ls_Title, &
			ls_PathName, &
			ls_Extension, &
			ls_Filter, &
			lsa_CustList[], &
			ls_Work, &
			ls_AcctName, &
			ls_AcctCode, &
			lsa_RejectList[], &
			ls_Message, &
			lsa_Result[], &
			ls_label
			
Integer	li_Result, &
			li_FileId, &
			li_Pos, &
			li_InvalidCount, &
			li_Return
			
Long		ll_fileCount, &
			ll_Ndx, &
			ll_listCount


n_cst_string	lnv_String
//return 0, no validation, quickbooks will create accounts 
//during import if the names are not found
IF ib_directconnect Then  	//RDT 02-20-03
	li_return = 0 				//RDT 02-20-03
Else								//RDT 02-20-03

	CHOOSE CASE as_filetype
		CASE "RECIEVABLES"
			ls_label = "Customer"
		CASE "PAYABLES"
			ls_label = "Vendor"
		CASE "PAYROLL"
			ls_label = "Employee"
	END CHOOSE
		
	ls_MessageHeader = "Validate Entities"
	choose case MessageBox ( ls_MessageHeader,&
		"Do you want to validate the " + ls_label + "s against "+&
		"an exported QuickBooks file?", Question!, YesNo!, 1 )
		
	case 1
	
		CHOOSE CASE as_filetype
			CASE "RECIEVABLES"
				li_Return = THIS.of_getCustomerFile ( as_FileName )
			CASE "PAYABLES"
				li_Return = THIS.of_getVendorFile ( as_FileName )
			CASE "PAYROLL"
				li_Return = THIS.of_getEmployeeValidationFile ( as_FileName )
		END CHOOSE
		
		
		ls_MessageHeader = "Validate " + ls_label + "s"
		
		
		ls_Title = "Specify " + ls_label + " File Location"
		ls_PathName = ""
		ls_Extension = "tsv"
		ls_Filter = "IIF Files (*.iif), *.iif,Text Files (*.txt), *.txt,All Files (*.*), *.*"
		
		IF li_Return <> 1 THEN
			//initdirectory
			string	ls_directory, &
						ls_file, &
						ls_drive
			n_cst_filesrvwin32	lnv_filesrv
			lnv_filesrv = create n_cst_filesrvwin32
			lnv_filesrv.of_ParsePath(as_FileName, ls_Drive, ls_directory, ls_File)
			destroy lnv_filesrv
	

			DO
			
				li_Result = GetFileOpenName ( ls_Title, ls_PathName, as_FileName, ls_Extension, &
					ls_Filter, ls_drive + ls_directory)
			
				CHOOSE CASE li_Result
				CASE 1
					//No processing needed
				CASE ELSE
			
					as_FileName = ""
			
					IF li_Result = 0 THEN
						//User chose cancel in filename dialog.  Proceed to warning.
					ELSE
						//There was an error in filename dialog.
			
						ls_Message = "Error attempting to determine " + ls_label + " file location."
			
						IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, RetryCancel!, 1 ) = 1 THEN
							CONTINUE
						ELSE
							//Proceed to warning
						END IF
					END IF
			
					ls_Message = "Are you sure you want to cancel this process?"
			
					IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
						CONTINUE
					ELSE
						li_Return = -1
						EXIT
					END IF
			
				END CHOOSE
			
			LOOP UNTIL Len ( as_FileName ) > 0
			IF len ( as_filename ) > 0 THEN
				as_FileName = ls_pathname 
				li_Return = 1
			END IF
			
		END IF
	case else
		li_return = 0
	end choose
End If							//RDT 02-20-03

RETURN li_return
end function

public function integer of_validatenames (string as_filename, string asa_names[], long ala_ids[], ref long ala_invalidids[]);
string	ls_message, &
			ls_messageheader, &
			ls_work, &
			ls_name, &
			lsa_Names []
			
integer	li_fileid, &
			li_return, &
			li_result, &
			li_invalidcount
			
long		ll_count, &
			ll_rowcount, &
			ll_filecount, &
			ll_listCount, &
			ll_ndx		
			
IF Len ( as_FileName ) > 0 THEN

	DO

		li_FileId = FileOpen ( as_FileName, LineMode!, Read!, LockWrite! )

		IF li_FileId = -1 THEN

			ls_Message = "Could not open the file ~"" + as_FileName +&
				"~", possibly because the file is already in use."

			IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, RetryCancel!, 1 ) = 2 THEN 

				ls_Message = "Are you sure you want to cancel the batch process?"

				IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
					
					li_Return = -1
					CONTINUE
				ELSE
					
					EXIT
				END IF
			END IF
		END IF

	LOOP UNTIL li_FileId >= 0

	IF li_FileId >= 0 THEN
	
		DO
	
			ls_Work = ""
			li_Result = FileRead ( li_FileId, ls_Work )
	
			IF li_Result > 0 THEN

				ls_name = of_parsename ( ls_work )
	
				IF len ( ls_name ) > 0 THEN
					lsa_Names [ UpperBound ( lsa_Names ) + 1 ] = ls_name
				END IF
	
			END IF
	
		LOOP WHILE li_Result >= 0
	
		FileClose ( li_FileId ) //Error Check??
	
//			isa_ValidCustomerList = lsa_Names

	ELSE
		RETURN -1  //Cancel Billing
	END IF
ELSE
	RETURN -1  //Cancel Billing
END IF

ll_filecount = UpperBound ( lsa_Names )
ll_listCount = UpperBound ( asa_Names )

FOR ll_ndx = 1 TO ll_listCount

	IF Len ( asa_Names[ll_ndx]  ) > 0 THEN
		n_cst_anyarraysrv lnv_anyarray
		IF lnv_anyarray.of_Find( lsa_Names, asa_Names[ll_ndx], 1, ll_fileCount ) > 0 THEN
			CONTINUE
		ELSE
			li_InvalidCount ++
			ala_InvalidIds [ li_invalidCount ] = ala_Ids[ll_ndx]
		END IF
	END IF

NEXT
if li_return = -1 then
	li_InvalidCount=-1
end if

IF li_InvalidCount > 0 THEN

	CHOOSE CASE MessageBox ( ls_MessageHeader, &
		"Some of the Profit Tools entities were not found in the your "+&
		"QuickBooks file. Do you want to let QuickBooks create "+&
		"the new entries when you import the batch.", None!, YesNo!, 2 )
	CASE 1
		li_InvalidCount = 0
		
	CASE 2
			
	END CHOOSE

END IF

RETURN li_InvalidCount
end function

private function string of_parsename (string as_source);//	Override ancestor method

Integer	li_TabPos
String	ls_Value

if  Left ( as_source, 5 ) = "CUST~t" then

	as_source = Replace ( as_source, 1, 5, "" )
	li_TabPos = Pos ( as_source, "~t" )
	
elseif Left ( as_source, 4 ) = "EMP~t"  then

		as_source = Replace ( as_source, 1, 4, "" )
		li_TabPos = Pos ( as_source, "~t" )
		
elseif Left ( as_source, 5 ) = "VEND~t"  then

		as_source = Replace ( as_source, 1, 5, "" )
		li_TabPos = Pos ( as_source, "~t" )
else
		as_source = ""

end if

IF li_TabPos > 1 THEN
	as_source = Left ( as_source, li_TabPos - 1 )
END IF

IF Left ( as_source, 1 ) = "~"" THEN
	as_source = Replace ( as_source, 1, 1, "" )
END IF

IF Right ( as_source, 1 ) = "~"" THEN
	as_source = Left ( as_source, Len ( as_source ) - 1 )
END IF


ls_Value = Upper ( as_source )

RETURN ls_Value
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
	IF li_ImportRtn >= 3 THEN  //  There should be 3 header rows. if not they will be able to select another file.
		li_Return = 1 // success here
	END IF
	
END IF

IF lb_Renamed THEN  // even if the import fails we still want to rename the file back
	 lnv_FileSrv.of_FileRename ( ls_TargetFile , ls_SourceFile   )
END IF
	
DESTROY  lnv_FileSrv  
RETURN li_Return
end function

private function integer of_getfilesavename (string as_title, ref string as_pathname, ref string as_filename, string as_extension, string as_filter, string as_cancelwarning);// THIS should be moved to the file srv object in core. 
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

private function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);SetPointer(HourGlass!)

String	ls_TransType, &
			lsa_transaction_columns[], &
			lsa_distribution_columns[], &
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
			ls_EntityId

Integer	li_Return, &
			li_TransactionSign, &
			li_DistributionSign, &
			li_ndx, &
			li_result

Long		ll_TransactionCount, &
			ll_DistributionCount, &
			ll_trns, &
			ll_dist, &
			ll_DistributionColumnCount, &
			ll_TransactionColumnCount, &
			ll_row
			
decimal	lca_AmountOwed[]
			
datastore					lds_work
n_cst_accountingdata		lnv_accountingdata

li_Return = 1
ls_category = anva_accountingdata[1].of_GetCategory ( )

Choose case upper(ls_category)
	case 'PAYABLES'
		ls_type = "AP"
		ls_TransType = "BILL" 
		ls_MessageContext = "AP"
		li_TransactionSign = -1
		li_DistributionSign = 1
		lsa_transaction_columns = {"!TRNS", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM", "MEMO", "DUEDATE"}
		lsa_distribution_columns = {"!SPL", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM", "INVITEM", "TAXABLE"}
	case 'RECEIVABLES'
		ls_type = "AR"
		ls_TransType = "INVOICE" 
		ls_MessageContext = "AR"
		li_TransactionSign = 1
		li_DistributionSign = -1
		lsa_transaction_columns = {"!TRNS", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM", "MEMO", "DUEDATE", "TERMS"}
		lsa_distribution_columns = {"!SPL", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM", "INVITEM", "TAXABLE"}	
	case "PAYROLL"
		ls_type = "PR"
		ls_TransType = "CHECK" 
		ls_MessageContext = "PR"
		li_TransactionSign = -1
		li_DistributionSign = 1
		lsa_transaction_columns = {"!TRNS", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM"}
		lsa_distribution_columns = {"!SPL", "TRNSTYPE", "DATE", "ACCNT", "NAME", "AMOUNT", "DOCNUM"}
end choose

ls_message_header = "Create " + ls_type + " Batch"
ls_reject = "Could not create "+ ls_type + " batch."
ll_TransactionCount = upperBound	( anva_accountingdata )
ll_DistributionColumnCount = upperBound( lsa_distribution_columns[] )
ll_TransactionColumnCount = upperBound	( lsa_transaction_columns[] )

//Get Batch File Name
IF li_Return = 1 THEN
	li_Return = this.of_getbatchfilename("iif",ls_MessageContext, ls_filename, ls_pathname)
	//	returns 1 (success) or -1 (failure)
END IF

IF li_Return = 1 then
	lds_work = this.of_datainitialization( lsa_transaction_columns [], lsa_distribution_columns [] )
	IF NOT IsValid ( lds_Work ) THEN
		li_Return = -1
	END IF
END IF

IF li_Return = 1 then
	FOR ll_Trns = 1 TO ll_TransactionCount

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
		
		if isnull(ls_EntityId) or len(trim(ls_entityid)) = 0 then
			ls_entityid = lnv_accountingdata.of_getentityname()
		end if
		
		// Get associated AmountsOwed and determine the number of distributions for that trans.
		ll_DistributionCount = lnv_accountingdata.of_GetdistributionAmount ( lca_AmountOwed )
		lnv_accountingdata.of_GetcostexpenseAccount	(lsa_distributionaccount)
		
		//Make Transaction entries
		ll_row = lds_work.insertrow(0)
		FOR li_ndx = 1 TO ll_TransactionColumnCount
			
			ls_value = ""
	
			CHOOSE CASE lsa_transaction_columns[li_ndx]
			CASE "!TRNS"  
				ls_value = "TRNS"
			CASE "TRNSTYPE"
				ls_value = ls_TransType
			CASE "DATE"
				ls_value = string(lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY")
			CASE "ACCNT"
				ls_value = lnv_accountingdata.of_GetTransactionAccount ( )
			CASE "NAME"
				ls_value = ls_EntityId
			CASE "AMOUNT"
				ls_value = string(lnv_accountingdata.of_getPreTaxNet ( ) * li_TransactionSign, "0.00")
			CASE "DOCNUM"
				ls_value = string(lnv_accountingdata.of_GetDocumentNumber ( )	)
			CASE "MEMO"
				ls_Value = lnv_accountingdata.of_getDescription ( )				
			CASE "DUEDATE"
				ls_value = string(lnv_accountingdata.of_GetDueDate ( ), "MM/DD/YYYY")				
			CASE "TERMS"  // INVOICES ONLY
				CASE ELSE
				ls_value = ""				
			END CHOOSE
	
			lds_work.object.data.primary[ll_row, li_ndx] = ls_value
	
		NEXT  // transaction column loop
		
		//Make Distribution entries
		FOR ll_dist = 1 TO ll_DistributionCount
			
			ll_row = lds_work.insertrow(0)
	
			FOR li_ndx = 1 TO ll_DistributionColumnCount
				
				ls_value = ""
	
				CHOOSE CASE lsa_distribution_columns[li_ndx]
						
				CASE "!SPL"
					ls_value = "SPL"				
				CASE "TRNSTYPE"
					ls_value = ls_TransType					
				CASE "DATE"
					ls_value = string( lnv_accountingdata.of_GetDocumentDate ( ), "MM/DD/YYYY")					
				CASE "ACCNT"
					ls_value = lsa_distributionaccount[ll_dist]
				CASE "NAME"
					ls_value = ls_EntityId
				CASE "AMOUNT"
					ls_value = string(lca_AmountOwed[ll_dist] * li_DistributionSign , "0.00")					
				CASE "DOCNUM"
					ls_value = string(lnv_accountingdata.of_GetDocumentNumber ( )					)
				CASE "INVITEM"
					ls_value = "Profit Tools"					
				CASE "TAXABLE"
					ls_value = "N"					
				CASE ELSE
					ls_value = ""					
				END CHOOSE
	
				lds_work.object.data.primary[ll_row, li_ndx] = ls_value
		
			NEXT // distribution column
		NEXT // Each Distribution
	
		//Add End Transaction Entry
		ll_row = lds_work.insertrow(0)
		lds_work.object.data.primary[ll_row, 1] = "ENDTRNS"
	
	NEXT // Each Transaction 

END IF

//Export contents of datastore to batch file
IF li_Return = 1 THEN
	DO
		li_result = lds_work.saveas(ls_pathname, text!, false)
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

IF li_Return = -1 THEN
	IF len(ls_reject) > 0 THEN 
		messagebox(ls_message_header, ls_reject, exclamation!)
	END IF
END IF

DESTROY lds_work
RETURN li_Return
end function

protected function datastore of_datainitialization (string asa_transcolumns[], string asa_distcolumns[]);/*
		Creates the datastore and sets the transaction columns and
		distribution columns.
		
		Returns:  datastore


*/

SetPointer(HourGlass!)

Integer	li_Return, &
			li_TransColumnCount, &
			li_DistColumnCount, &
			li_ndx

Long		ll_row
datastore lds_work

li_Return = 1
li_TransColumnCount = upperbound( asa_transcolumns )
li_DistColumnCount = upperbound( asa_distcolumns )
//Set up datastore to hold batch information for export
IF li_Return = 1 THEN
	lds_Work = of_CreateBatchDataStore ( Max ( li_TransColumnCount , li_DistColumnCount ) )
	IF NOT IsValid ( lds_Work ) THEN
		li_Return = -1
	END IF
END IF

//Put column headers into datastore
IF li_Return = 1 THEN

	setpointer(hourglass!)
	ll_row = lds_work.insertrow(0)
	FOR li_ndx = 1 TO li_TransColumnCount
		lds_work.object.data.primary[ll_row, li_ndx] = asa_transcolumns [][li_ndx]
	NEXT
	
	ll_row = lds_work.insertrow(0)
	FOR li_ndx = 1 TO li_DistColumnCount
		lds_work.object.data.primary[ll_row, li_ndx] = asa_distcolumns[li_ndx]
	NEXT
	
	ll_row = lds_work.insertrow(0)
	lds_work.object.data.primary[ll_row, 1] = "!ENDTRNS"

END IF



RETURN lds_work
end function

on n_cst_acctlink_quickbooks.create
call super::create
end on

on n_cst_acctlink_quickbooks.destroy
call super::destroy
end on

event constructor;// QuickBooks uses the Entity Name, not ID, to find accounts and customers. 
This.of_SetUseEntityName ( TRUE )
end event

