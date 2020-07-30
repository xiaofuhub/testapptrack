$PBExportHeader$n_cst_acctlink_aquagulf.sru
forward
global type n_cst_acctlink_aquagulf from n_cst_acctlink
end type
end forward

global type n_cst_acctlink_aquagulf from n_cst_acctlink
end type
global n_cst_acctlink_aquagulf n_cst_acctlink_aquagulf

forward prototypes
public function integer of_batch_create (n_cst_msg anv_cst_msg)
end prototypes

public function integer of_batch_create (n_cst_msg anv_cst_msg);//Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch


string	ls_err_skiplist, &
			ls_work1, &
			ls_message, &
			ls_batch_type, &
			ls_ar_account, &
			ls_Title, &
			ls_PathName, &
			ls_FileName, &
			ls_Filter, &
			ls_CancelWarning, &
			ls_message_header, &
			ls_reject, &
			lsa_transaction_columns[], &
			lsa_distribution[], &
			lsa_empty[], &
			ls_value, &
			ls_Path
Constant String	ls_Extension = "csv"
			
long		ll_trns, &
			ll_trans_max, &
			ll_dist, &
			ll_dist_max, &
			ll_err_skipcount, &
			ll_row, &
			ll_TransactionColumnCount, &
			ll_TransactionTotalCount


integer 	li_ndx, &
			li_ndx_max, &
			li_result, &
			li_accounts, &
			li_Return, &
			li_UseDefaultRtn, &
			li_BatchfolderRtn
				
Boolean	lb_UseDefault
decimal {2} lc_check



/*	DataStores	*/
datastore lds_work

/*	Structures	*/			
s_parm lstr_parm
s_accounting_transaction lstra_trns[]
s_accounting_distribution lstr_dist

n_cst_msg lnv_cst_msg
n_cst_File	lnv_File

ls_message_header = "Create AR Batch"
ls_reject = "Could not create AR batch."
li_accounts = 12  //the max number of groups of account codes and amounts
li_ndx_max = li_accounts * 2
//empty distribution array
FOR li_ndx = 1 to li_ndx_max STEP 2
	
	lsa_empty[li_ndx] = " "
	lsa_empty[li_ndx + 1] = ".0"
	
NEXT

//Extract parameters from message object that was passed in.

FOR li_ndx = 1 to anv_cst_msg.of_get_count()
	
	IF anv_cst_msg.of_get_parm(li_ndx, lstr_parm) > 0 then
		
		choose case lstr_parm.is_label
				
		case "BATCH_TYPE"
			ls_batch_type = lstr_parm.ia_value
			
		case "TRANSACTION"
			lstra_trns[upperbound(lstra_trns) + 1] = lstr_parm.ia_value
			
		end choose
		
	END IF
	
NEXT

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
	
	ls_PathName = String ( Now ( ), "mmddhhmm") + ".csv"
	
	IF li_BatchFolderRtn = 1 THEN
		ls_PathName = ls_Path + String ( Now ( ), "mmddhhmm") + ".csv"
	END IF	
	

	ls_Title = "Specify Batch File Location"
	
	ls_FileName = ""
	ls_filter = "CSV FILES (*.csv), *.csv" // "CSV Files (*.csv), *.csv
	ls_CancelWarning =  "You have indicated that you do not wish to create an AR Batch.~n~n"+&
		"PLEASE NOTE: The bills have already been processed, and you will not be able to "+&
		"recreate an AR Batch for them later."
		
	IF lnv_File.of_GetFileSaveName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, &
		ls_Filter, ls_CancelWarning ) = -1 THEN
		
			RETURN -2
			
	END IF
	
ELSE
	ls_PathName = ls_Path + String ( Now ( ), "mmddhhmm") + "." + ls_extension
	ls_FileName = String ( Now ( ), "mmddhhmm") + "." + ls_extension
END IF

// Initialize Transaction column arrays

lsa_Transaction_Columns = {"CUSTCODE", "INV#", "INVTOTAL", "INVDATE", "COL5", &
									"COL6", "COL7", "COL8", "COL9", "COL10", "COL11", &
									"COL12", "COL13", "COL14", "BILLINGCO"}

ll_TransactionColumnCount =  UpperBound ( lsa_Transaction_Columns )	

ll_TransactionTotalCount = ll_TransactionColumnCount

FOR li_ndx = 1 to li_accounts
	
	ll_TransactionTotalCount ++
	lsa_Transaction_Columns[ll_TransactionTotalCount] = "ACCTCODE" + String(li_ndx)
	ll_TransactionTotalCount ++
	lsa_Transaction_Columns[ll_TransactionTotalCount] = "AMOUNT" + String(li_ndx)
	
NEXT	

//Set up datastore to hold batch information for export

lds_Work = of_CreateBatchDataStore ( ll_TransactionTotalCount )

IF NOT IsValid ( lds_Work ) THEN
	
	messagebox(ls_message_header, ls_reject, exclamation!)
	RETURN -1
	
END IF

//Put column headers into datastore

setpointer(hourglass!)

//ll_row = lds_work.insertrow(0)
//
//FOR li_ndx = 1 to ll_TransactionColumnCount
//	
//	lds_work.object.data.primary[ll_row, li_ndx] = lsa_transaction_columns[li_ndx]
//	
//
//NEXT

//Load transaction information into datastore

ll_trans_max = upperbound(lstra_trns)

FOR ll_trns = 1 to ll_trans_max

	//Check for valid company 
		//of_validatecustomers()

	//load distribution array
	lsa_distribution[] = lsa_empty[]
	ll_dist_max = upperbound(lstra_trns[ll_trns].istra_distributions)
	li_ndx = -1
	FOR ll_dist = 1 to ll_dist_max 
		
		lstr_dist = lstra_trns[ll_trns].istra_distributions[ll_dist]
		IF NOT lstr_dist.ib_credit THEN
			CONTINUE
		END IF
		li_ndx += 2
		lsa_distribution[li_ndx] = lstr_dist.is_account
		lsa_distribution[li_ndx + 1] = string(lstr_dist.ic_amount, "0.00")
		
	NEXT

	/*		If there are more distributions than can be 
			handled in the array then add to error list and skip.*/
	ll_dist_max = (li_ndx + 1) / 2  
	IF ll_dist_max > li_accounts then 
		ll_err_skipcount ++
		if len(ls_err_skiplist) > 0 then ls_err_skiplist += ", "
		ls_err_skiplist += lstra_trns[ll_trns].is_document_number + "(too many distributions)"
		continue
	END IF
	
		
	//Make Transaction entries

	ll_row = lds_work.insertrow(0)

	FOR li_ndx = 1 to ll_TransactionColumnCount

		choose case lsa_transaction_columns[li_ndx]
				
		case "CUSTCODE"		
			ls_value = lstra_trns[ll_trns].is_company_code
		case "INV#"
			ls_value = lstra_trns[ll_trns].is_document_number
		case "INVTOTAL"
			ls_value = string(lstra_trns[ll_trns].ic_document_amount, "0.00")
		case "INVDATE" 
			ls_value = string(lstra_trns[ll_trns].id_document_date, "mm/dd/yy")
		case "COL5"
			ls_value = " "
		case "COL6", "COL7", "COL8", "COL9", "COL10", "COL11", "COL12", "COL13", "COL14"
			ls_value = ".0"
		case "BILLINGCO"
			ls_value = "XPR"
			
		End choose

		lds_work.object.data.primary[ll_row, li_ndx] = ls_value

	NEXT
	
	/*	Make distribution entries	*/
		
	ll_dist = 1

	FOR li_ndx = ll_TransactionColumnCount + 1 to ll_TransactionTotalCount

		lds_work.object.data.primary[ll_row, li_ndx] = lsa_distribution[ll_dist]
		ll_dist ++

	NEXT

NEXT


//Export contents of datastore to batch file

do
	li_result = lds_work.saveas(ls_pathname, CSV!, false)

	IF li_result = -1 then
		
		IF messagebox(ls_message_header, "Could not save batch file.", exclamation!, &
			retrycancel!, 1) = 2 then
			
			ls_reject = ""
			goto failure
			
		END IF
		
	END IF
	
loop until li_result = 1


//Inform user of any invoices that were not included in the batch

IF ll_err_skipcount > 0 then
	
	IF ll_err_skipcount = 1 then
		
		ls_work1 = "invoice was"
		
	else
		
		ls_work1 = string(ll_err_skipcount) + " invoices were"
		
	END IF
	
	IF len(ls_message) > 0 then ls_message += "~n~n"
	ls_message += "The following " + ls_work1 + " not included in the AR batch because "+&
		"of processing errors:~n~n" + ls_err_skiplist
	messagebox("Notes on AR Batch", ls_message)
END IF

destroy lds_work
return 1


failure:

IF len(ls_reject) > 0 then messagebox(ls_message_header, ls_reject, exclamation!)
destroy lds_work
return -1
end function

on n_cst_acctlink_aquagulf.create
TriggerEvent( this, "constructor" )
end on

on n_cst_acctlink_aquagulf.destroy
TriggerEvent( this, "destructor" )
end on

