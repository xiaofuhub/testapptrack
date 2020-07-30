$PBExportHeader$n_cst_acctlink.sru
forward
global type n_cst_acctlink from nonvisualobject
end type
end forward

global type n_cst_acctlink from nonvisualobject
end type
global n_cst_acctlink n_cst_acctlink

type variables
Boolean  ib_DirectConnect = False
String      is_Category

Private:
String	isa_ValidCustomerList[]
//Used by of_ValidateCustomerFile, in order to prevent
//reading the customer file again.
Boolean  ib_UseEntityName = False



end variables

forward prototypes
public function integer of_link_open (ref string as_posting_company)
public function integer of_validate_customers (datastore ads_list)
public function integer of_logon (string as_posting_company, string as_uid, string as_pwd)
public function integer of_validate_accounts (n_cst_msg anv_cst_msg, ref string as_notice)
public function integer of_batch_create (n_cst_msg anv_cst_msg)
public function boolean of_link_close ()
protected function integer of_filelocate (string as_filename, ref string as_pathname, boolean ab_forcelocate, string as_generalheader, string as_cancelheader, string as_cancelnote)
protected function integer of_filecreate (string as_filepath, ref string asa_lines[])
protected function integer of_filecreate (string as_filepath)
protected function datastore of_createbatchdatastore (string asa_columnlist[])
protected function string of_gettmpnumbers (readonly s_accounting_transaction astr_transaction)
protected function string of_getreferencenumbers (readonly s_accounting_transaction astr_transaction)
protected function string of_getreferencelist (readonly s_accounting_transaction astr_transaction)
protected function datastore of_createbatchdatastore (integer ai_columncount)
protected function integer of_validatecustomerfile (datastore ads_list)
protected function string of_parsecustomer (string as_source)
protected function integer of_processpayables (ref n_cst_beo_transaction anva_transactions [])
protected function integer of_processreceivables (ref n_cst_beo_transaction anva_transactions [])
public function integer of_getbatchfilename (string as_extension, string as_transtype, ref string as_filename, ref string as_pathname)
public function integer of_batchcreate (n_cst_msg anv_msg)
protected function integer of_getssbatchfoldername (ref string as_pathname)
protected function integer of_usedefaultbatchname ()
public function integer of_getsspayablesfolder (ref string as_path)
protected function integer of_getvendorfile (ref string as_path)
protected function integer of_getemployeevalidationfile (ref string as_path)
public function integer of_validatedivision (n_cst_beo_transaction anva_transactions[], ref long ala_invalidtransactions[])
public function integer of_getvalidationfile (ref string as_filename, string as_filetype)
public function integer of_validatenames (string as_filename, string asa_names[], long ala_ids[], ref long ala_invalidids[])
public subroutine of_validateaccountingcompany (n_cst_beo_transaction anva_transactions[], ref string asa_company[])
public function integer of_dataload (n_cst_accountingdata anva_accountingdata[])
public function integer of_validateallentitiesbytype (string as_type)
public function integer of_validateentities (n_cst_beo_entity anva_entity[], string as_type, ref long ala_invalids[])
public function integer of_validateaccountmaps (n_cst_beo_transaction anva_transactions[], ref long ala_invalidtransactions[], string as_category)
public function integer of_validatevendorfile (ref n_cst_msg anv_msg)
public function integer of_validatebatch (n_cst_accountingdata anva_accountingdata[])
private function boolean of_isbatchprevalidated (n_cst_accountingdata anva_accountingdata[])
public function integer of_getcategories (n_cst_accountingdata anva_accountingdata[], ref string asa_category[])
public function string of_getentitytype (n_cst_accountingdata anva_accountingdata[], ref string as_entityname)
protected function string of_getreferencenumbersbylabel (readonly s_accounting_transaction astr_transaction, string as_labellist)
public function string of_getpolabels ()
protected function integer of_setuseentityname (readonly boolean ab_UseEntityName)
protected function boolean of_getuseentityname ()
public function integer of_dataload (n_cst_beo_transaction anva_transactions[], ref n_cst_accountingdata anva_accountingdata[], ref string as_errormsg, readonly string as_category)
public function integer of_getcustomerfile (ref string as_filename)
public function string of_getshiptypename (long al_shiptype)
private function string of_getrefvalues (n_cst_beo_amountowed anv_amount)
public function string of_buildreftext (n_cst_bcm anv_amountsowed, n_cst_beo_transaction anv_transaction)
public subroutine of_recordarbatch (datawindow adw_target, boolean ab_validated)
end prototypes

public function integer of_link_open (ref string as_posting_company);return 1
end function

public function integer of_validate_customers (datastore ads_list);//This function rubber stamps the list submitted to it.  Any actual validation is the
//responsibility of the inherited working objects.

integer li_invalid_count, li_row

for li_row = 1 to ads_list.rowcount()
	ads_list.object.approved[li_row] = "T"
next

li_invalid_count = 0
return li_invalid_count
end function

public function integer of_logon (string as_posting_company, string as_uid, string as_pwd);return 1
end function

public function integer of_validate_accounts (n_cst_msg anv_cst_msg, ref string as_notice);//This function is not currently responsible for verifying that the accounts passed
//to it are not null.  That is already taken care of in n_cst_billing.of_bill(), 
//where this function is then called.  If we move to use this function more generally, 
//this check will also need to be added.

as_notice = ""
return 1
end function

public function integer of_batch_create (n_cst_msg anv_cst_msg);//The inherited working object must supply code for this function if it wants it to succeed.

//This function is responsible for its own error notifications and explanations.

messagebox("Create Batch", "Could not process request.", exclamation!)

return -1
end function

public function boolean of_link_close ();return true
end function

protected function integer of_filelocate (string as_filename, ref string as_pathname, boolean ab_forcelocate, string as_generalheader, string as_cancelheader, string as_cancelnote);//Return Values : 1 (Success), 0 (User Chooses Cancel)

String	ls_Title, &
			ls_PathName, &
			ls_FileName, &
			ls_Extension, &
			ls_Filter, &
			ls_CancelMessage
Integer	li_Result



IF ab_ForceLocate = FALSE THEN
	IF FileExists ( as_FileName ) THEN
		as_PathName = as_FileName
		RETURN 1
	END IF
ELSE
	IF Pos ( Upper ( as_PathName ), Upper ( as_FileName ) ) > 0 AND &
		Len ( as_PathName ) > Len ( as_FileName ) THEN
			IF FileExists ( as_PathName ) THEN
				RETURN 1
			END IF
	END IF
END IF

ls_Title = "Specify Location of " + Upper ( as_FileName )
ls_PathName = ""  //passing a value here does not appear to have an effect
ls_FileName = ""  //passing a value here does not appear to have an effect
ls_Extension = "" //"exe"
ls_Filter = Lower ( as_FileName ) + ", " + Lower ( as_FileName )

DO

	li_Result = GetFileOpenName ( ls_Title, ls_PathName, ls_FileName, ls_Extension, ls_Filter )

	CHOOSE CASE li_Result

	CASE 1
		//No processing needed

	CASE ELSE
		IF li_Result = 0 THEN
			//User chose cancel in filename dialog.  Proceed to warning.

		ELSE
			//There was an error in filename dialog.
			IF Messagebox ( as_GeneralHeader, "Error attempting to locate " +&
				Upper ( as_FileName ), Exclamation!, RetryCancel!, 1 ) = 1 THEN
					ls_FileName = ""
					CONTINUE
			END IF
		END IF


		ls_CancelMessage = "You have indicated that you do not wish to locate the " +&
			Upper ( as_FileName ) + " file."

		IF Len ( as_CancelNote ) > 0 THEN
			ls_CancelMessage += "~n~nPLEASE NOTE: " + as_CancelNote + "~n~n"
		ELSE
			ls_CancelMessage += "  "
		END IF

		ls_CancelMessage += "Are you sure you want to skip this process?"
			
		IF Messagebox ( as_CancelHeader, ls_CancelMessage, Exclamation!, YesNo!, 2 ) = 2 THEN
			ls_FileName = ""
			CONTINUE
		ELSE
			RETURN 0
		END IF

	END CHOOSE

LOOP UNTIL Len ( ls_FileName ) > 0

as_PathName = ls_PathName
RETURN 1
end function

protected function integer of_filecreate (string as_filepath, ref string asa_lines[]);//Returns : 1 = Success, -1 = Failure

Integer	li_FileHandle, &
			li_Count, &
			li_Ndx, &
			li_Return

li_FileHandle = FileOpen ( as_FilePath, LineMode!, Write!, LockWrite!, Replace! )

IF li_FileHandle = -1 THEN

	RETURN -1

ELSE

	li_Return = 1

	li_Count = UpperBound ( asa_Lines )

	FOR li_Ndx = 1 TO li_Count

		IF IsNull ( asa_Lines [ li_Ndx ] ) THEN
			CONTINUE
		END IF

		IF FileWrite ( li_FileHandle, asa_Lines [ li_Ndx ] ) = -1 THEN
			li_Return = -1
			EXIT
		END IF

	NEXT

	FileClose ( li_FileHandle )
	RETURN li_Return

END IF
end function

protected function integer of_filecreate (string as_filepath);String	lsa_Lines[]

RETURN of_FileCreate ( as_FilePath, lsa_Lines )
end function

protected function datastore of_createbatchdatastore (string asa_columnlist[]);//This was originally where this functionality was implemented.
//It's since been moved into n_cst_Dws.

n_cst_Dws	lnv_Dws

RETURN lnv_Dws.of_CreateDataStore ( asa_ColumnList )
end function

protected function string of_gettmpnumbers (readonly s_accounting_transaction astr_transaction);//Returns a comma-separated list of TMP #'s

String	ls_Value
n_cst_String	lnv_String

lnv_String.of_ArrayToString ( astr_Transaction.isa_Tmps, ", ", ls_Value )

RETURN ls_Value
end function

protected function string of_getreferencenumbers (readonly s_accounting_transaction astr_transaction);//Returns a comma-separated list of TMP #'s

String	ls_Value, &
			lsa_Work[]
Integer	li_Count, &
			li_Ndx
n_cst_String	lnv_String

li_Count = UpperBound ( astr_Transaction.istra_ReferenceNumbers )

FOR li_Ndx = 1 TO li_Count

	lsa_Work [ li_Ndx ] = astr_Transaction.istra_ReferenceNumbers [ li_Ndx ].is_Value

NEXT

lnv_String.of_ArrayToString ( lsa_Work, ", ", ls_Value )

RETURN ls_Value
end function

protected function string of_getreferencelist (readonly s_accounting_transaction astr_transaction);//Returns a comma-separated list of Reference #'s, with type labels

String	ls_Value, &
			lsa_Work[]
Integer	li_Count, &
			li_Ndx
n_cst_String	lnv_String

li_Count = UpperBound ( astr_Transaction.istra_ReferenceNumbers )

FOR li_Ndx = 1 TO li_Count

	lsa_Work [ li_Ndx ] = astr_Transaction.istra_ReferenceNumbers [ li_Ndx ].is_Type +&
		" " + astr_Transaction.istra_ReferenceNumbers [ li_Ndx ].is_Value

NEXT

lnv_String.of_ArrayToString ( lsa_Work, ", ", ls_Value )

RETURN ls_Value
end function

protected function datastore of_createbatchdatastore (integer ai_columncount);//This was originally where this functionality was implemented.
//It's since been moved into n_cst_Dws.

n_cst_Dws	lnv_Dws

RETURN lnv_Dws.of_CreateDataStore ( ai_ColumnCount )
end function

protected function integer of_validatecustomerfile (datastore ads_list);//Returns the number of entries in the primary buffer that do not pass validation 
//(0 = All OK.)  Returns -1 if an error occurs, and -3 if user chooses Cancel Billing.

String	ls_MessageHeader, ls_Title, ls_PathName, ls_FileName, ls_Extension, ls_Filter, &
			lsa_CustList[], ls_Work, ls_AcctName, ls_AcctCode, lsa_RejectList[], ls_Message
Integer	li_Result, li_FileId, li_Pos, li_InvalidCount
Long		ll_Row, ll_Count, ll_Ndx, ll_RowCount
Int		li_FileReturn
String	ls_ValidationFile
String	lsa_Result[]


n_cst_string	lnv_String


ls_MessageHeader = "Validate Customers"

li_FileReturn = THIS.of_getCustomerFile ( ls_ValidationFile )

IF UpperBound ( isa_ValidCustomerList ) = 0 THEN
	

	ls_Title = "Specify Customer File Location"
	ls_PathName = ""
	ls_FileName = ""
	ls_Extension = ""
	ls_Filter = "Text Files (*.txt), *.txt,TSV Files (*.tsv), *.tsv,All Files (*.*), *.*"
	
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
		
					ls_Message = "Error attempting to determine customer file location."
		
					IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, RetryCancel!, 1 ) = 1 THEN
						CONTINUE
					ELSE
						//Proceed to warning
					END IF
				END IF
		
				ls_Message = "Are you sure you want to cancel the billing process?"
		
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
	
	
	IF Len ( ls_FileName ) > 0 THEN
	
		DO
	
			li_FileId = FileOpen ( ls_PathName, LineMode!, Read!, LockWrite! )
	
			IF li_FileId = -1 THEN
	
				ls_Message = "Could not open the file ~"" + ls_PathName +&
					"~", possibly because the file is already in use."
	
				IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, RetryCancel!, 1 ) = 2 THEN 
	
					ls_Message = "Are you sure you want to cancel the billing process?"
	
					IF MessageBox ( ls_MessageHeader, ls_Message, Exclamation!, YesNo!, 2 ) = 2 THEN
						
						li_FileReturn = 0
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
		
					lsa_CustList [ UpperBound ( lsa_CustList ) + 1 ] = of_ParseCustomer ( ls_Work )
		
				END IF
		
			LOOP WHILE li_Result >= 0
		
			FileClose ( li_FileId ) //Error Check??
		
			isa_ValidCustomerList = lsa_CustList
	
		ELSE
			RETURN -3  //Cancel Billing
		END IF
	ELSE
		RETURN -3  //Cancel Billing
	END IF

ELSE
	lsa_CustList = isa_ValidCustomerList

END IF
	
	



ll_Count = UpperBound ( lsa_CustList )
ll_RowCount = ads_List.RowCount ( )

FOR ll_Row = 1 TO ll_RowCount

//	ls_AcctName = Upper ( ads_List.Object.xx_acct_name [ ll_Row ] )
	ls_AcctCode = Upper ( ads_List.Object.co_bill_acctcode [ ll_Row ] )

	IF Len ( ls_AcctCode ) > 0 THEN
		n_cst_anyarraysrv lnv_anyarray
		IF lnv_anyarray.of_Find( lsa_CustList, ls_AcctCode, 1, ll_Count ) > 0 THEN
			ads_List.Object.approved [ ll_row ] = "T"
			CONTINUE
		END IF
	END IF

	li_InvalidCount ++

NEXT

RETURN li_InvalidCount
end function

protected function string of_parsecustomer (string as_source);//This function extracts the customer value to be validated from a work string.
//The work string is expected to be tab delimited, with the customer value in the
//leftmost position.
//It is intended to be overridden, if necessary for different implementations.

Integer	li_TabPos
String	ls_Value

li_TabPos = Pos ( as_Source, "~t" )

IF li_TabPos > 0 THEN
	ls_Value = Left ( as_Source, li_TabPos - 1 )
ELSE
	ls_Value = as_Source
END IF

ls_Value = Upper ( ls_Value )

RETURN ls_Value
end function

protected function integer of_processpayables (ref n_cst_beo_transaction anva_transactions []);//The inherited working object must supply code for this function if it wants it to succeed.

//This function is responsible for its own error notifications and explanations.

messagebox("Create Batch", "Could not process request.", exclamation!)

return -1
end function

protected function integer of_processreceivables (ref n_cst_beo_transaction anva_transactions []);//The inherited working object must supply code for this function if it wants it to succeed.

//This function is responsible for its own error notifications and explanations.

messagebox("Create Batch", "Could not process request.", exclamation!)

return -1
end function

public function integer of_getbatchfilename (string as_extension, string as_transtype, ref string as_filename, ref string as_pathname);/*
	Get the Batch file name and return it

	returns:		1  success
				  -2	failure
	
	-2 is used in calling code to determine if batch was cancelled
		(may want to change this)
*/

String	ls_title, &
			ls_Filter, &
			ls_CancelWarning
String	ls_Path
String	ls_Type

integer	li_Return = 1
Int		li_BatchFolderRtn
Int		li_UseDefaultRtn
Boolean	lb_UseDefault


n_cst_File	lnv_File	

ls_Type = as_transtype

li_UseDefaultRtn = THIS.of_UseDefaultBatchName ( )

//           1 = Success, YES!
//				 2 = Success, NO!
//				 3 = success, ASK!
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

CHOOSE CASE li_useDefaultRtn
	CASE -1 ,0 ,3
		IF	MessageBox ( "Default Batch Name" , "Do you wish to use the default AP batch name?", QUESTION!, YESNO!, 1 ) = 1 THEN
			lb_useDefault = TRUE
		END IF
	
	CASE 1  // yes, use default
		lb_UseDefault = TRUE	
		
	CASE 2  // No, don't use default 
		lb_UseDefault = FALSE
		
END CHOOSE

CHOOSE CASE ls_Type
	CASE "AP", "PR"
		li_BatchFolderRtn = THIS.of_GetssPayablesFolder ( ls_Path )
		ls_CancelWarning = &
		"You have indicated that you do not wish to create an " + as_transtype + &
		" Batch." 

	CASE "AR"
		li_BatchFolderRtn = THIS.of_GetssBatchFolderName ( ls_Path )
		ls_CancelWarning = &
		"You have indicated that you do not wish to create an " + as_transtype + &
		" Batch.~n~n" + "PLEASE NOTE: The bills have already been processed, " + &
		"and you will not be able to " + "recreate an " + as_transtype +" Batch for them later."
	
	CASE ELSE
		
END CHOOSE
	
		

IF lb_UseDefault THEN
	IF li_BatchFolderRtn = -2 THEN
		messageBox ( "Folder Location" , "The folder specified in the system settings '" + ls_Path + &
		    "' does not exist. Please select a folder from the following dialog box." )
	END IF
END IF

	 
IF ( Not lb_UseDefault )OR li_BatchFolderRtn <> 1 THEN
	
	as_PathName = String ( Now ( ), "mmddhhmmss") + "." + as_extension
	
	IF li_BatchFolderRtn = 1 THEN
		as_PathName = ls_Path + String ( Now ( ), "mmddhhmmss") + "." + as_extension
	END IF

	
	as_FileName = ""
	ls_Filter = as_extension + " Files (*." + as_extension + "), *." + as_extension
	
	IF lnv_File.of_GetFileSaveName ( ls_Title, as_PathName, as_filename, as_extension, &
		ls_Filter, ls_CancelWarning ) = -1 THEN
		
			li_Return = -2 
			
	END IF
ELSE
	as_PathName = ls_Path + String ( Now ( ), "mmddhhmm") + "." + as_extension
	as_FileName = String ( Now ( ), "mmddhhmm") + "." + as_extension
END IF

RETURN li_Return
end function

public function integer of_batchcreate (n_cst_msg anv_msg);/*RDT add code for new msg parm and pass this parm to of_dataload */
/*========================================================================================
						of_BatchCreate ( anv_msg )
						
BEO implementation

Return Values : 1 = Success, -1 = Failure, -2 = User Chose No AR Batch

=========================================================================================*/
SetPointer(HourGlass!)
			
Integer	li_Return

string	ls_category,&
			ls_list,&
			ls_batchid,&
			ls_text,&
			ls_message, &
			lsa_blank[], &
			ls_errormsg
			
long		ll_errorcount, &
			ll_index,&
			lla_InvalidTransaction[]

integer	li_msgCount, &
			li_ndx
			
n_cst_beo_Transaction	lnva_Transactions []
n_cst_accountingdata		lnva_accountingdata[]
s_parm lstr_parm

li_Return = 1

isa_ValidCustomerList = lsa_blank[]

// get category from message object.
If anv_msg.of_get_parm ( "CATEGORY" , lstr_parm ) > 0 THEN
	ls_category = lstr_Parm.ia_Value
Else
	ls_category = ""
End If

IF anv_msg.of_get_parm ( "TRANSACTION_BEO_ARRAY" , lstr_parm ) > 0 THEN
	lnva_Transactions = lstr_Parm.ia_Value
	choose case this.of_dataload( lnva_Transactions, lnva_accountingdata, ls_errormsg, ls_category) //RDT
		case 1	//success
			li_Return = 1
		case else //A BATCH FAILED	
			messagebox("Notes on Batch.", ls_errormsg)
			li_Return = -1 
	end choose
	
	IF li_Return = 1 then 
		if upperbound(lnva_accountingdata) > 0 then
			li_return = 1 
		else 
			li_return = -1
		end if
	End If 
	
	///***	Validate Division																***/
	IF li_Return = 1 THEN
		ls_batchid = lnva_accountingdata[1].of_getbatchid()
		ls_category = lnva_accountingdata[1].of_getcategory()
		choose case this.of_ValidateDivision ( lnva_Transactions, lla_InvalidTransaction )
			case 1
				li_return = 1
			case else
				li_return = -1
		end choose
	
		IF li_Return = -1 THEN
			ll_ErrorCount = UpperBound ( lla_InvalidTransaction )
			FOR ll_index = 1 to ll_ErrorCount
			
				if len(ls_list) > 0 then ls_list += ", "
				ls_list += string ( lla_InvalidTransaction [ ll_Index ], "0000" )
			
			NEXT
			IF ll_ErrorCount = 1 THEN
				ls_text = "transaction in BatchNumber " + ls_Batchid + " does"
			ELSE
				ls_text = string(ll_ErrorCount) + " transactions in BatchNumber " + ls_Batchid + " do"
			END IF
			IF len(ls_message) > 0 THEN ls_message += "~n~n"
			ls_message += "The following " + ls_text + " not have all of the divisions assigned for the amounts:~n~n" + &
				 			ls_list + "~n~nPlease update the account maps and retry."
			messagebox("Notes on " + ls_category + " Batch", ls_message)
		END IF	
	
	END IF

ELSE
	if anv_msg.of_get_parm ( "ACCOUNTINGDATA" , lstr_parm ) > 0 THEN
		lnva_accountingdata = lstr_Parm.ia_Value
		if upperbound(lnva_accountingdata) > 0 then
			li_return = 1
		else
			li_return = -1
		end if
	ELSE
		li_Return = -1 
	END IF
END IF

/***	validate data		***/
if li_return = 1 then 
	if this.of_isbatchprevalidated(lnva_accountingdata) then
		//skip
	else
		choose case this.of_ValidateBatch ( lnva_accountingdata )
			case 1	//success
				li_Return = 1
			case else //A BATCH FAILED	
				// messaging is handled in called method
				li_Return = -1 
		end choose
	end if
end if
/***    	process transactions  		***/
IF li_Return = 1 THEN
	choose case this.of_dataload( lnva_accountingdata )
		case 1	//success
			li_Return = 1
		case else //A BATCH FAILED	
			// messaging is handled in called method
			li_Return = -1 
	end choose
END IF

RETURN li_Return
end function

protected function integer of_getssbatchfoldername (ref string as_pathname);//Returns:   1 = Success 
//				-2 = file DNE
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database
//    THIS  GETS THE AR BATCH FOLDER NAME 

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1
Int		li_FileID
String	lsa_Result[]

n_cst_fileSrvwin32	lnv_fileSrv
lnv_FileSrv = CREATE n_cst_fileSrvwin32
n_cst_String	lnv_String




//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 51 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return
IF li_Return = 1 THEN
	
	IF Right ( ls_Description , 1 ) <> "\" THEN
		ls_Description += "\"
	END IF
	
	as_pathname = ls_description
	IF Not lnv_FileSrv.of_DirectoryExists( ls_Description ) THEN
		
		li_Return = -2
	
	END IF
END IF

IF isValid ( lnv_fileSrv ) THEN
	DESTROY lnv_FileSrv
END IF

RETURN li_Return


end function

protected function integer of_usedefaultbatchname ();//Returns:   1 = Success, YES!
//				 2 = Success, NO!
//				 3 = success, ASK!
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1

//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 52 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE

IF li_Return <> -1 THEN
	
	CHOOSE CASE ls_Description 
		CASE "YES!"
			li_Return = 1
		CASE "NO!"
			li_Return = 2
		CASE "ASK!"
			li_Return = 3
		CASE ELSE
			li_Return = 0
	END CHOOSE
END IF
		

RETURN li_Return


end function

public function integer of_getsspayablesfolder (ref string as_path);//Returns:   1 = Success 
//				-2 = file DNE
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

// THIS GET THE PAYABLES BATCH FOLDER NAME/LOCATION

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1
Int		li_FileID
String	lsa_Result[]

n_cst_fileSrvwin32	lnv_fileSrv
lnv_FileSrv = CREATE n_cst_fileSrvwin32
n_cst_String	lnv_String




//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 54 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( ls_Description ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return
IF li_Return = 1 THEN
	
	IF Right ( ls_Description , 1 ) <> "\" THEN
		ls_Description += "\"
	END IF
	as_path = ls_description
	
	IF Not lnv_FileSrv.of_DirectoryExists( ls_Description ) THEN
		
		li_Return = -2
	
	END IF
END IF

IF isValid ( lnv_fileSrv ) THEN
	DESTROY lnv_FileSrv
END IF

RETURN li_Return


end function

protected function integer of_getvendorfile (ref string as_path);//Returns:   1 = Success 
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1
Int		li_FileID
n_cst_string	lnv_String



//Attempt to retrieve vendor validation file from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 55 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( trim ( ls_Description ) )  > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	li_FileId = FileOpen ( ls_description, LineMode!, Read!, LockWrite! )
	IF li_FileID = -1 THEN
		MessageBox ( "File Access" , "The file path '" + ls_Description + &
		"' specified in the system settings could not accessed. Please select " + &
		+ "a vendor validation file manually." )
		
		li_Return = -1
	ELSE
		li_Return = FileClose ( li_FileID )
	END IF
END IF 

//send back anyway for possible folder location
//IF li_Return = 1 THEN
	
	as_Path = ls_description
	
//END IF
 

RETURN li_Return


end function

protected function integer of_getemployeevalidationfile (ref string as_path);//Returns:   1 = Success 
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1
Int		li_FileID
n_cst_string	lnv_String



//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 56 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( trim ( ls_Description )  ) > 0 THEN
		//Value is OK -- Make sure it's upper case
		ls_Description = Upper ( ls_Description )
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	li_FileId = FileOpen ( ls_description, LineMode!, Read!, LockWrite! )
	IF li_FileID = -1 THEN
		MessageBox ( "File Access" , "The file path '" + ls_Description + &
		"' specified in the system settings could not accessed. Please select " + &
		+ "an employee validation file manually." )
		
		li_Return = -1
	ELSE
		li_Return = FileClose ( li_FileID )
	END IF
END IF
//send back anyway for possible folder location
//IF li_Return = 1 THEN
	
	as_Path = ls_description
	
//END IF
 

RETURN li_Return


end function

public function integer of_validatedivision (n_cst_beo_transaction anva_transactions[], ref long ala_invalidtransactions[]);/*  Make sure division has been entered for all amounts
	return  1 = success
	 		-1  = failure
*/
SetPointer(HourGlass!)
			
Integer	li_Return, &
			li_Division

Long		ll_TransactionCount, &
			ll_DistributionCount, &
			ll_Trns, &
			ll_Dist, &
			ll_err_skipcount
			
datastore	lds_AccountMap
								
n_cst_beo_Transaction	lnv_CurrentTransaction
n_cst_beo_AmountOwed		lnva_AmountsOwed [ ]
n_cst_beo_AmountOwed		lnv_CurrentAmountOwed
n_cst_dws					lnv_dws
			
li_Return = 1

ll_TransactionCount = upperBound	( anva_Transactions )

IF li_Return = 1 then
	FOR ll_Trns = 1 TO ll_TransactionCount

		// Get a single transaction
		lnv_CurrentTransaction = anva_Transactions [ ll_Trns ]
		
		// Get associated AmountsOwed and determine the number of distributions for that trans.
		lnv_CurrentTransaction.of_GetAmountsList ( lnva_AmountsOwed )
		ll_DistributionCount = UpperBound ( lnva_AmountsOwed )
		
	
		FOR ll_dist = 1 TO ll_DistributionCount
			
			// get division and make sure there is one
			lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Dist ]
			li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
			IF isnull ( li_Division ) THEN
				ll_err_skipcount ++
				ala_invalidtransactions[ll_err_skipcount] = lnv_CurrentTransaction.of_GetId ()
				exit
			END IF
			
		NEXT
		
	NEXT // Each Transaction 

END IF

IF ll_err_skipcount > 0 THEN
	li_Return = -1
END IF

return li_Return

end function

public function integer of_getvalidationfile (ref string as_filename, string as_filetype);//Returns the number of entries in the primary buffer that do not pass validation 
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
			ls_ValidationFile, &
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

CHOOSE CASE as_filetype
	CASE "RECIEVABLES"
		ls_label = "Customer"
		li_Return = THIS.of_getCustomerFile ( as_FileName )
	CASE "PAYABLES"
		ls_label = "Vendor"
		li_Return = THIS.of_getVendorFile ( as_FileName )
	CASE "PAYROLL"
		ls_label = "Employee"
		li_Return = THIS.of_getEmployeeValidationFile ( as_FileName )
END CHOOSE


ls_MessageHeader = "Validate " + ls_label + "s"


ls_Title = "Specify " + ls_label + " File Location"
ls_PathName = ""
	ls_Extension = ''//"tsv"
	ls_Filter = "Text Files (*.txt), *.txt,TSV Files (*.tsv), *.tsv,All Files (*.*), *.*"

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
			ls_Filter, ls_drive + ls_directory )
	
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
ELSE
//	ls_PathName = ls_ValidationFile
//	lnv_String.of_ParseToArray ( ls_PathName, "\" , lsa_Result )
//	as_FileName = lsa_Result [ UpperBound ( lsa_Result ) ] 
END IF

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
			
IF UpperBound ( isa_ValidCustomerList ) = 0 THEN
	
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
		
					ls_name = of_ParseCustomer ( ls_Work )
					IF len ( ls_name ) > 0 THEN
						lsa_Names [ UpperBound ( lsa_Names ) + 1 ] = ls_name
					END IF
		
				END IF
		
			LOOP WHILE li_Result >= 0
		
			FileClose ( li_FileId ) //Error Check??
		
			isa_ValidCustomerList = lsa_Names
	
		ELSE
			RETURN -1  //Cancel Billing
		END IF
	ELSE
		RETURN -1  //Cancel Billing
	END IF

ELSE
	lsa_Names = isa_ValidCustomerList

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
	ELSE
		IF isnull(asa_Names[ll_ndx]) then
			li_InvalidCount ++
			ala_InvalidIds [ li_invalidCount ] = ala_Ids[ll_ndx]
		END IF
	END IF

NEXT
if li_return = -1 then
	li_InvalidCount=-1
end if
RETURN li_InvalidCount
end function

public subroutine of_validateaccountingcompany (n_cst_beo_transaction anva_transactions[], ref string asa_company[]);/*		This method assumes that the transactions being passed to it
		have already gone through the of_validatedivision method and
		all the transactions have valid divisions.
		
		If one of the divisions does not have an accounting company
		then an empty list is passed back.
		
		argument:	anva_transactions[]
						asa_company[]	pass back a list of accounting companies
*/
boolean	lb_Found

integer	li_Division, &
			lia_Division[], &
			li_HoldDivision

long		ll_Index1, &
			ll_Index2, &
			ll_Index3, &
			ll_TransactionCount, &
			ll_AmountOwedCount, &
			ll_DivisionCount, &
			ll_companyCount
			
string	ls_AccountingCompany, &
			lsa_Empty []
			
n_cst_beo_ShipType		lnv_ShipType
n_cst_beo_Transaction	lnv_CurrentTransaction
n_cst_beo_AmountOwed		lnva_AmountsOwed [ ]
n_cst_beo_AmountOwed		lnv_CurrentAmountOwed

lnv_ShipType = CREATE n_cst_beo_ShipType


lnv_ShipType.Of_SetUseCache ( TRUE )
ll_TransactionCount = UpperBound ( anva_transactions [] )

//get all the unique divisions and load them into an array
FOR ll_Index1 = 1 TO ll_TransactionCount

	// Get a single transaction
	lnv_CurrentTransaction = anva_transactions [ ll_Index1 ]
	
	// Get associated AmountsOwed.
	lnv_CurrentTransaction.of_GetAmountsList ( lnva_AmountsOwed )
	ll_AmountOwedCount = UpperBound ( lnva_AmountsOwed )
	FOR ll_Index2 = 1 TO ll_AmountOwedCount
		
		// Get Current Amount Owed
		lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Index2 ]
		
		// Get Division
		li_Division = lnv_CurrentAmountOwed.of_Getdivision ( )
		
		lb_Found = FALSE
		FOR ll_Index3 = 1 to ll_DivisionCount
			IF li_Division = lia_Division [ll_Index3] THEN
				lb_Found = TRUE
				EXIT
			END IF
		NEXT

		IF not lb_Found THEN
			ll_DivisionCount ++
			lia_Division [ll_DivisionCount] = li_Division
		END IF			

	NEXT

NEXT

// check accounting companies
FOR ll_Index1 = 1 TO ll_DivisionCount

	lnv_ShipType.Of_SetSourceId ( lia_Division [ll_Index1] )
	ls_AccountingCompany = lnv_ShipType.Of_GetAccountingCompany ()
	
	IF isnull ( ls_AccountingCompany ) THEN
		asa_company = lsa_Empty 
		EXIT
	END IF
		
	lb_Found = FALSE
	FOR ll_Index3 = 1 to ll_CompanyCount
		IF ls_AccountingCompany = asa_company [ll_Index3] THEN
			lb_Found = TRUE
			EXIT
		END IF
	NEXT

	IF not lb_Found THEN
		ll_CompanyCount ++
		asa_company [ll_CompanyCount] = ls_AccountingCompany
	END IF			
	
NEXT
	
	
DESTROY ( lnv_ShipType )
end subroutine

public function integer of_dataload (n_cst_accountingdata anva_accountingdata[]);//The inherited working object must supply code for this function if it wants it to succeed.

//This function is responsible for its own error notifications and explanations.
messagebox("Data Load", "Could not process request.", exclamation!)

return -1
end function

public function integer of_validateallentitiesbytype (string as_type);n_cst_Bcm				lnv_Bcm
n_cst_beo_entity		lnv_Entity, &
							lnva_Entities[]
	
w_EntityList			lw_EntityList	
	
string					ls_message

Long						ll_Count, &
							lla_invalids[]
							
integer					li_Return = 1

s_parm		lstr_parm
n_cst_msg	lnv_msg

gnv_App.inv_CacheManager.of_SetAutoCache ( TRUE )
gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_entity", lnv_Bcm, TRUE, TRUE )

IF IsValid ( lnv_Bcm ) THEN

	lnv_Entity = lnv_Bcm.GetFirst ( )

	DO WHILE IsValid ( lnv_Entity )

		ll_Count ++
		lnva_Entities [ ll_Count ] = lnv_Entity

		lnv_Entity = lnv_Bcm.GetNext ( )

	LOOP

END IF

li_Return = this.of_ValidateEntities ( lnva_Entities, as_type, lla_invalids )

IF li_Return = -1 THEN
	ls_message = "Could not verify all of the IDs with the file " + &
	"from your accounting package. The following ID(s) could " + &
	"not be verified."

	lstr_Parm.is_Label = "IDS"
	lstr_Parm.ia_Value = lla_invalids
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	lstr_Parm.is_Label = "MESSAGE"
	lstr_Parm.ia_Value = ls_message
	lnv_msg.of_Add_Parm ( lstr_Parm ) 
	OpenSheetWithParm (lw_EntityList, lnv_msg, gnv_App.of_GetFrame ( ), 0, Layered!  ) 

END IF

return li_Return
end function

public function integer of_validateentities (n_cst_beo_entity anva_entity[], string as_type, ref long ala_invalids[]);/*		
		
		
*/
string	lsa_list [], &
			ls_badnames, &
			ls_message, & 
			ls_id, &
			ls_ValidationFile

INTEGER	li_msgCount, & 
			li_ndx, &
			li_ReceivableCnt, &
			li_PayrollCnt, &
			li_PayableCnt, &
			li_Return, &
			li_Invalids
			
LONG		ll_BeoIndex, &
			ll_BeoCount, &
			ll_ErrorCnt, &
			lla_EntityID [], &
			ll_Count
			
n_cst_beo_entity	lnv_entityBeo

li_Return = 1

ll_BeoCount = UpperBound ( anva_Entity ) 

IF ll_BeoCount = 0 THEN
	li_Return = -1
END IF

FOR ll_BeoIndex = 1 TO ll_BeoCount		

	lnv_EntityBeo = anva_Entity [ ll_BeoIndex ]
	
	IF NOT isValid ( lnv_EntityBeo ) THEN
		li_Return = -1
	END IF
	
	IF li_Return = 1 THEN
		CHOOSE CASE upper(as_type)
			CASE 'RECEIVABLES'
				ls_Id = lnv_EntityBeo.of_GetReceivablesId ( )
				IF isnull ( ls_Id ) OR len ( trim ( ls_Id ) ) = 0 THEN
					//DO NOTHING
				ELSE
					ll_Count ++
					lsa_list [ ll_Count ] = ls_Id
					lla_EntityID [ ll_Count ] = lnv_EntityBeo.of_GetId ( )
				END IF
					
			CASE 'PAYROLL'
				ls_Id = lnv_EntityBeo.of_GetPayrollId ( )
				IF isnull ( ls_Id ) or len ( trim ( ls_Id ) ) = 0 THEN
					//DO NOTHING
				ELSE
					ll_Count ++
					lsa_list [ ll_Count ] = ls_Id
					lla_EntityID [ ll_Count ] = lnv_EntityBeo.of_GetId ( )
				END IF
			CASE 'PAYABLES'
				ls_Id = lnv_EntityBeo.of_GetPayablesId ( )
				IF isnull ( ls_Id ) OR len ( trim ( ls_Id ) ) = 0 THEN
					//DO NOTHING
				ELSE				
					ll_Count ++
					lsa_list [ ll_Count ] = ls_Id
					lla_EntityID [ ll_Count ] = lnv_EntityBeo.of_GetId ( )
				END IF		
		END CHOOSE
	END IF
				

NEXT

IF upperbound ( lsa_list ) > 0 THEN
	
	li_Return = of_GetValidationFile ( ls_ValidationFile, as_type )
	
	if li_return > 0 then
		li_return = of_ValidateNames ( ls_ValidationFile, lsa_list, lla_EntityID, ala_invalids )
		if li_return = 0 then
			li_Return = 1
		else
			li_invalids = li_return
		end if
	end if
	
	IF li_Invalids > 0 THEN	
		li_Return = -1 
	END IF
	
end if
	
return li_Return
end function

public function integer of_validateaccountmaps (n_cst_beo_transaction anva_transactions[], ref long ala_invalidtransactions[], string as_category);// load the string array argument with the transactions 
// that have missing accountmaps
SetPointer(HourGlass!)

String	ls_DistributionAccount, &
			ls_TransactionAccount, &
			ls_FindString
			
Integer	li_Return, &
			li_AmountType, &
			li_Division

Long		ll_TransactionCount, &
			ll_DistributionCount, &
			ll_row, &
			ll_FindRow, &
			ll_Trns, &
			ll_Dist, &
			ll_err_skipcount
			
datastore	lds_AccountMap
								
n_cst_beo_Transaction	lnv_CurrentTransaction
n_cst_beo_AmountOwed		lnva_AmountsOwed [ ]
n_cst_beo_AmountOwed		lnv_CurrentAmountOwed
n_cst_dws					lnv_dws
			
li_Return = 1

ll_TransactionCount = upperBound	( anva_Transactions )

lnv_dws.of_CreateDataStoreByDataObject ( "d_dlkc_accountmap", lds_AccountMap, FALSE )
lds_AccountMap.Retrieve()

IF li_Return = 1 then
	FOR ll_Trns = 1 TO ll_TransactionCount

		// Get a single transaction
		lnv_CurrentTransaction = anva_Transactions [ ll_Trns ]
		
		// Get associated AmountsOwed and determine the number of distributions for that trans.
		lnv_CurrentTransaction.of_GetAmountsList ( lnva_AmountsOwed )
		ll_DistributionCount = UpperBound ( lnva_AmountsOwed )
		
	
		FOR ll_dist = 1 TO ll_DistributionCount
			
			// Get Current Amount Owed
			lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Dist ]
			li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
			li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
			ls_FindString = "accountmap_division = " + string ( li_Division ) + &
								" and accountmap_amounttypeid = " + string ( li_AmountType )
			ll_row = lds_AccountMap.RowCount()
			ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
			IF ll_FindRow = 0 THEN
				ll_err_skipcount ++
				ala_invalidtransactions[ll_err_skipcount] = lnv_CurrentTransaction.of_GetId ()
				exit
			ELSE		
				// make sure there are accounts
				CHOOSE CASE upper(as_category )
				CASE 'PAYABLES'
					ls_TransactionAccount = lds_AccountMap.Object.accountmap_apaccount[ll_FindRow]
					ls_DistributionAccount = lds_AccountMap.Object.accountmap_costaccount[ll_FindRow]
		
				CASE 'RECEIVABLES'
		//			ls_TransactionAccount = lds_AccountMap.Object.accountmap_araccount[ll_FindRow]
		//			ls_DistributionAccount = lds_AccountMap.Object.accountmap_salesaccount[ll_FindRow]
		
				CASE 'PAYROLL'
					ls_TransactionAccount = lds_AccountMap.Object.accountmap_payrollcashaccount[ll_FindRow]
					ls_DistributionAccount = lds_AccountMap.Object.accountmap_payrollexpenseaccount[ll_FindRow]
		
				END CHOOSE
				IF isnull ( ls_TransactionAccount ) or len ( ls_TransactionAccount ) = 0 or &
					isnull ( ls_DistributionAccount ) or len ( ls_DistributionAccount ) = 0 THEN
					ll_err_skipcount ++
					ala_invalidtransactions[ll_err_skipcount] = lnv_CurrentTransaction.of_GetId ()
					exit
				END IF
			END IF
			
		NEXT
		
	NEXT // Each Transaction 

END IF

IF ll_err_skipcount > 0 THEN
	li_Return = -1
END IF

DESTROY lds_AccountMap

return li_Return
end function

public function integer of_validatevendorfile (ref n_cst_msg anv_msg);long	ll_index, &
		ll_transactioncount, &
		lla_id[], &
		lla_invalids[]

integer	li_return = 1, &
			li_invalids

string	lsa_name[], &
			lsa_blank[], &
			ls_category, &
			ls_message,  &
			ls_validationfile
		
s_parm	lstr_parm
n_cst_msg	lnv_msg
w_entitylist	lw_EntityList
n_cst_accountingdata	lnv_accountingdata, &
							lnva_accountingdata[]
							
//get msg parms
if anv_msg.of_get_parm ( "ACCOUNTINGDATA" , lstr_parm ) > 0 THEN
	lnva_accountingdata = lstr_Parm.ia_Value
end if
if anv_msg.of_get_parm ( "ERRORMESSAGE" , lstr_parm ) > 0 THEN
	ls_message = lstr_Parm.ia_Value
else
	ls_message = ''
end if
if anv_msg.of_get_parm ( "CATEGORY" , lstr_parm ) > 0 THEN
	ls_category = lstr_Parm.ia_Value
end if


ll_transactioncount = upperbound ( lnva_accountingdata )

FOR ll_Index = 1 TO ll_TransactionCount		

	lnv_accountingdata = lnva_accountingdata[ll_Index]
	
	IF NOT isValid ( lnv_accountingdata ) THEN
		li_Return = -1
	ELSE		
		CHOOSE CASE upper(ls_category)
			CASE 'RECEIVABLES'
				lsa_name[ll_Index] = lnv_accountingdata.of_getReceivablesId()
					
			CASE 'PAYROLL'
				lsa_name[ll_Index] = lnv_accountingdata.of_getPayrollId()

			CASE 'PAYABLES'
				lsa_name[ll_Index] = lnv_accountingdata.of_getPayablesId()

		END CHOOSE
			
		lla_id[ll_index] = lnv_accountingdata.of_getentityid()
		
	END IF
	
NEXT

IF li_Return = 1 THEN
	IF upperbound ( lsa_name ) > 0 THEN
		
		ls_category = lnva_accountingdata[1].of_getcategory()
		
		li_Return = of_GetValidationFile ( ls_ValidationFile, ls_category )
		//clear instance list
		isa_ValidCustomerList = lsa_blank
		if li_return > 0 then
			li_return = of_ValidateNames ( ls_ValidationFile, lsa_name, lla_ID, lla_invalids )
			if li_return = 0 then
				li_Return = 1
			else
				li_invalids = li_return
			end if
		end if
		
		IF li_Invalids > 0 THEN	
			li_Return = -1 
		END IF
		
	end if

	IF li_Return = -1 THEN

		lstr_Parm.is_Label = "IDS"
		lstr_Parm.ia_Value = lla_invalids
		lnv_msg.of_Add_Parm ( lstr_Parm ) 
		lstr_Parm.is_Label = "MESSAGE"
		lstr_Parm.ia_Value = ls_message
		lnv_msg.of_Add_Parm ( lstr_Parm ) 
	
		//There may not be any entities if this is a carrier batch,
		//only display the message.
		IF upperbound(lla_invalids) > 0 then
			IF lla_invalids[1] = 0 then
				messagebox("Vendor Validation", "Could not verify all of the IDs with the file " + &
							"from your accounting package. ")
			ELSE
				OpenSheetWithParm (lw_EntityList, lnv_msg, gnv_App.of_GetFrame ( ), 0, Layered!  ) 
			END IF
		END IF
	END IF
end if

return li_return

end function

public function integer of_validatebatch (n_cst_accountingdata anva_accountingdata[]);// RDT 02-24-03 - If using Quickbooks direct connect then Payables or Payroll id is not required.
SetPointer(HourGlass!)
			
Integer	li_invalids,&
			li_Return = 1

string 	ls_message, &
			lsa_AcountingCompany [], &
			lsa_entityname[], &
			ls_entityname, &
			ls_text, &
			ls_list, &
			ls_BatchNumber, &
			ls_category,&
			ls_validationfile, &
			lsa_Entitycategory[], &
			ls_EntityType

			
Long		ll_Index, &
			ll_index2, &
			ll_EntityCnt, &
			ll_TransactionCount, &
			lla_InvalidTransaction [], &
			ll_ErrorCount, &
			lla_entityid[],&
			lla_Invalids[]

boolean	lb_found

w_EntityList   lw_EntityList

s_parm						lstr_parm
n_cst_msg					lnv_msg
n_cst_accountingdata		lnv_accountingdata
n_cst_beo_entity			lnv_entitybeo, &
								lnva_entity []
//have batches already been validated


//Get Batch number for error messages
ll_TransactionCount = UpperBound ( anva_accountingdata )
IF ll_TransactionCount = 0 THEN
	li_Return = -1
END IF

IF li_Return = 1 THEN
	lnv_accountingdata = anva_accountingdata[1]
	ls_BatchNumber = lnv_accountingdata.of_GetBatchid ( )
	/***	Validate Entity Type. (Batches must contain a single category.)	***/
	choose case THIS.of_GetCategories( anva_accountingdata, lsa_Entitycategory )
		case 1
			li_return = 1
		case else
			li_return = -1
	end choose
END IF

IF li_Return = 1 THEN
	//this checks categories
	ll_EntityCnt = upperbound ( lsa_EntityCategory )
	CHOOSE CASE ll_EntityCnt
		CASE 0
			messagebox ( "Batch Error", "No categories were found for BatchNumber " + &
					ls_BatchNumber + ".  The Batch can't be processed.  " + &
					"Please correct the batch and retry. ", StopSign!) 				
			li_Return = -1
		CASE 1
			ls_category = lsa_EntityCategory[1]
		CASE ELSE
			messagebox ( "Batch Error", "Mixed categories " + &
					"were found for BatchNumber " + ls_BatchNumber + ". " + &
					"Please correct the batch and retry. ", StopSign!) 
			li_Return = -1
	END CHOOSE
END IF

//check mixed ids
IF li_Return = 1 THEN
	
	ls_EntityType  = THIS.of_GetEntityType( anva_accountingdata, ls_entityname)

	choose case ls_EntityType
		case ''
			choose case ls_category
				case "PAYABLES"
					If NOT ib_directconnect then 		//RDT 022403
						messagebox ( "Batch Error", "Missing payable or payroll id for " + &
								ls_entityname + ".  The Batch can't be processed.  " + &
								"Please correct the batch and retry. ") 				
						li_Return = -1
					End If									//RDT 022403
				case "RECEIVABLES"
					messagebox ( "Batch Error", "Missing receivables id(s) for BatchNumber " + &
							ls_BatchNumber + ".  The Batch can't be processed.  " + &
							"Please correct the batch and retry. ") 				
					li_Return = -1
					
			end choose
		case appeon_constant.cs_mixed
			messagebox ( "Batch Error", "Mixed payable ids and payroll ids " + &
			"were found for BatchNumber " + ls_BatchNumber + ". " + &
			"Please correct the batch and retry. ") 
			li_Return = -1
		case else
			//ok
	end choose
	
end if

/***	Validate names against the file from the accounting package    ***/
IF li_Return = 1 THEN

	lstr_Parm.is_Label = "ACCOUNTINGDATA"
	lstr_Parm.ia_Value = anva_accountingdata
	lnv_msg.of_Add_Parm ( lstr_Parm ) 		

	ls_message = "Could not verify all of the IDs with the file " + &
	"from your accounting package. The following ID(s) could " + &
	"not be verified.  If you make any changes, you will have to " + &
	"retrieve the batch again from the Transaction Selection Window " + &
	"for the changes to take effect."

	lstr_Parm.is_Label = "ERRORMESSAGE"
	lstr_Parm.ia_Value = ls_message
	lnv_msg.of_Add_Parm ( lstr_Parm ) 		

	lstr_Parm.is_Label = "CATEGORY"
	lstr_Parm.ia_Value = ls_CATEGORY
	lnv_msg.of_Add_Parm ( lstr_Parm ) 		

	if this.of_validatevendorfile(lnv_msg) < 0 then
		li_return = -1
	end if
END IF
//
///***	Validate Accounting Company (There should be only one company)	***/
//IF li_Return = 1 THEN
//
//	this.of_ValidateAccountingCompany ( anva_Transactions, lsa_AcountingCompany )
//	
//	IF UpperBound ( lsa_AcountingCompany ) = 0 THEN
//		messagebox ( "Batch Error","One or more divisions used in BatchNumber " + &
//				 ls_BatchNumber + " do not have a posting company specified.  " + &
//				"Please verify your shipment type setup.", StopSign!) 
//		li_Return = -1		
//	ELSEIF UpperBound ( lsa_AcountingCompany ) > 1 THEN
//		messagebox ( "Batch Error", &
//		"The transactions in BatchNumber - " + ls_BatchNumber + " do not all post to the same "+&
//		"company (based on their shipment types).  In order to create " + &
//		"the " + as_category + " batch, only those transactions associated with ONE valid " + &
//		"company can be batched together.  ", StopSign!)
//		li_Return = -1		
//	END IF
//
//END IF
//
///***    	Validate Accountmaps  		***/
IF li_Return = 1 THEN
	FOR ll_Index = 1 TO ll_TransactionCount		
	
		lnv_accountingdata = anva_accountingdata[ll_Index]
		
		IF NOT isValid ( lnv_accountingdata ) THEN
			li_Return = -1
		ELSE		
			if lnv_accountingdata.of_validateaccountmaps() = 1 then
				//ok
			else
				//get id
//				lla_InvalidTransaction[upperbound(lla_InvalidTransaction) + 1] = 
			end if
		END IF
		
	NEXT


//	li_return = this.of_ValidateAccountMaps ( anva_Transactions, lla_InvalidTransaction, as_Category )
	IF li_Return = -1 THEN
		ll_ErrorCount = UpperBound ( lla_InvalidTransaction )
		FOR ll_index = 1 to ll_ErrorCount
			if len(ls_list) > 0 then ls_list += ", "
			ls_list += string ( lla_InvalidTransaction [ ll_Index ], "0000" )
		continue

		NEXT
		IF ll_ErrorCount = 1 THEN
			ls_text = "transaction in BatchNumber - " + ls_BatchNumber + " does"
		ELSE
			ls_text = string(ll_ErrorCount) + " transactions in BatchNumber - " + ls_BatchNumber + " do"
		END IF
		IF len(ls_message) > 0 THEN ls_message += "~n~n"
		ls_message += "The following " + ls_text + " not have all of the account maps for the amount type:~n~n" + &
			 			ls_list + "~n~nPlease update the account maps and retry."
		messagebox("Notes on " + ls_category + " Batch", ls_message)
	END IF

END IF

if li_return = 1 then
	//mark batch as validated
	FOR ll_Index = 1 TO ll_TransactionCount		
		anva_accountingdata[ll_Index].of_setvalidated(true)
	NEXT
end if

RETURN li_Return
end function

private function boolean of_isbatchprevalidated (n_cst_accountingdata anva_accountingdata[]);//loop thru all transactions, in not all have been validated then return fals

long	ll_index, &
		ll_arraycount
	
boolean	lb_validated=true

ll_arraycount=upperbound(anva_accountingdata)

for ll_index = 1 to ll_arraycount

	if anva_accountingdata[ll_index].of_isvalidated() then
		//next
	else
		lb_validated = false
		exit
	end if
	
next

return lb_validated
end function

public function integer of_getcategories (n_cst_accountingdata anva_accountingdata[], ref string asa_category[]);/*		Loop thru all entities and pass back an array of entity categories.
		return 1 = success
				-1 = failure
		
*/


INTEGER	li_msgCount, & 
			li_ndx, &
			li_ReceivableCnt, &
			li_PayrollCnt, &
			li_PayableCnt, &
			li_Return
			
LONG		ll_Index, &
			ll_Count
	
string	lsa_init []

s_parm lstr_parm
n_cst_accountingdata		lnv_accountingdata

asa_category = lsa_init

li_Return = 1

ll_Count = UpperBound ( anva_accountingdata ) 

FOR ll_Index = 1 TO ll_Count		

	lnv_accountingdata = anva_accountingdata [ ll_Index ]
	
	if lnv_accountingdata.of_getcategory ( ) = 'RECEIVABLES' then li_ReceivableCnt += 1
	if lnv_accountingdata.of_getcategory ( ) = 'PAYROLL' then	li_PayrollCnt += 1
	if lnv_accountingdata.of_getcategory ( ) = 'PAYABLES' then li_PayableCnt += 1				

NEXT
	
IF li_ReceivableCnt > 0 THEN asa_category [upperbound ( asa_category ) + 1] = 'RECEIVABLES'
IF li_PayrollCnt > 0 THEN asa_category [upperbound ( asa_category ) + 1] = 'PAYROLL'
IF li_PayableCnt > 0 THEN asa_category [upperbound ( asa_category ) + 1] = 'PAYABLES'

return li_Return
end function

public function string of_getentitytype (n_cst_accountingdata anva_accountingdata[], ref string as_entityname);/*		
	Loop thru all entities and pass back an entity type.
	
	If a blank type is found then pass the entityname by reference
		return 1 = success
				-1 = failure
		
*/

		
LONG		ll_index, &
			ll_Count

string	ls_entitytype, &
			ls_test

n_cst_accountingdata		lnv_accountingdata

ll_Count = UpperBound ( anva_accountingdata ) 

FOR ll_Index = 1 TO ll_Count		

	lnv_accountingdata = anva_accountingdata [ ll_Index ]
	
	ls_test = lnv_accountingdata.of_GetEntityType ( )
	
	if isnull(ls_test) or len(trim(ls_test)) = 0 then
		ls_EntityType = ''
		as_entityname = lnv_accountingdata.of_GetEntityName ( )
		exit
	end if
	
	if ll_Index = 1 then
		ls_EntityType = ls_test
	else
		if ls_EntityType <> ls_test then
			ls_EntityType = appeon_constant.cs_mixed
			exit
		end if
	end if

NEXT
	
return ls_entitytype
end function

protected function string of_getreferencenumbersbylabel (readonly s_accounting_transaction astr_transaction, string as_labellist);//Returns a comma-separated list of Reference #'s matching the label list requested.

//as_LabelList should be a quoted, comma-separated list of label text, for example:
//"P.O. #", or "P.O. #", "BOOKING #"

//The labels must be quoted to avoid partial-match issues, ie BL vs. MASTER BL


String	ls_Value, &
			lsa_Work[]
Integer	li_Count, &
			li_Ndx, &
			li_TargetCount
n_cst_String	lnv_String

//Take upper case of list parameter, so comparisons won't have to consider case, below.
as_LabelList = Upper ( as_LabelList )

li_Count = UpperBound ( astr_Transaction.istra_ReferenceNumbers )

FOR li_Ndx = 1 TO li_Count

	IF Pos ( as_LabelList, "~"" + Upper ( astr_Transaction.istra_ReferenceNumbers [ li_Ndx ].is_Type ) + "~"" ) > 0 THEN

		li_TargetCount ++
		lsa_Work [ li_TargetCount ] = astr_Transaction.istra_ReferenceNumbers [ li_Ndx ].is_Value

	END IF

NEXT

lnv_String.of_ArrayToString ( lsa_Work, ", ", ls_Value )

RETURN ls_Value
end function

public function string of_getpolabels ();//Returns the LabelList to use for determining P.O. #  (allows for user-defined list)

String	ls_Value
any		la_Value

n_cst_settings lnv_Settings

IF lnv_Settings.of_GetSetting (121 , la_Value ) <> 1 THEN
	//DEFAULT
	ls_Value = "~"P.O. #~""
ELSE
	ls_Value = String ( la_Value )
END IF

RETURN ls_Value
end function

protected function integer of_setuseentityname (readonly boolean ab_UseEntityName);//
/***************************************************************************************
NAME			: of_SetUseEntityName
ACCESS		: Protected
ARGUMENTS	: Boolean	
RETURNS		: Integer (1=Success, -1=Fail)
DESCRIPTION	: Set the instance variable ib_UseEntityName

REVISION		: RDT 02-12-03
***************************************************************************************/

Integer	li_Return 

ib_UseEntityName = ab_UseEntityName


Return li_Return
end function

protected function boolean of_getuseentityname ();//
/***************************************************************************************
NAME			: of_GetUseEntityName
ACCESS		: Public 
ARGUMENTS	: none
RETURNS		: Boolean	
DESCRIPTION	: Returns the value of the instance variable ib_UseEntityName

REVISION		: RDT 01
***************************************************************************************/

Return ib_useentityname
end function

public function integer of_dataload (n_cst_beo_transaction anva_transactions[], ref n_cst_accountingdata anva_accountingdata[], ref string as_errormsg, readonly string as_category);// of_DataLoad ( n_cst_beo_transaction, n_cst_accountingdata, string as_errormsg )
// RDT 2-18-03 added as_category 
// RDT 2-24-03 Initialized arrays 
// RDT 3-05-03 Do Not Allow 0 amounts to be processed
// RDT 5-06-03 ALLOW 0 and negative amounts to be processed

SetPointer(HourGlass!)

String	ls_EntityName, &
			ls_apaccount, &
			lsa_apaccount[], &
			ls_cashaccount, &
			lsa_cashaccount[], &
			ls_costaccount, &
			lsa_costaccount[], &
			ls_expenseaccount, &
			lsa_expenseaccount[], &
			ls_TransactionAccount, &
			ls_FindString, &
			lsa_account[], &
			ls_employee, &
			ls_ReceivablesId, &
			ls_PayablesId, &
			ls_PayrollId, &
			ls_shiptypename, &
			ls_Ref, &
			lsa_RefList[]
			
String	lsa_ProcessedTypes[]
String	ls_Temp

Integer	li_Return, &
			li_DistributionSign, &
			li_AmountType, &
			li_Division

Long		ll_TransactionCount, &
			ll_DistributionCount, &
			ll_trns, &
			ll_dist, &
			ll_row, &
			ll_index, &
			ll_count, &
			ll_FindRow, &
			ll_found, &
			ll_Winner, &
			ll_EntityId, &
			ll_CompanyId, &
			ll_EmployeeId, &
		   ll_AccountCount 
			
decimal	lc_Check, &
			lc_quantity, &
			lc_AmountOwed, &
			lca_quantity[], &
			lca_amount[]
			
String	lsa_Blank[]	//RDT 2-24-03 
Decimal 	lca_Blank[]	//RDT 2-24-03 	

boolean	lb_UseEntityId = true
n_Cst_AnyArraySrv	lnv_Array
n_cst_bcm lnv_bcm
n_cst_database lnv_database
n_cst_query lnv_query
lnv_database = gnv_bcmmgr.GetDatabase ( )





datastore					lds_AccountMap
//begin comment by appeon 20070727					
//n_cst_constants			lnv_Constants
n_cst_constant			lnv_Constants
//begin comment by appeon 20070727
n_cst_beo_Transaction	lnv_CurrentTransaction
n_cst_beo_AmountOwed		lnva_AmountsOwed [ ]
n_cst_beo_AmountOwed		lnv_CurrentAmountOwed
n_cst_beo_Entity			lnv_CurrentEntity
n_cst_beo_company			lnv_Company
n_cst_EmployeeManager	lnv_EmployeeManager
n_cst_dws					lnv_dws
n_cst_accountingdata		lnva_accountingdata[]			
string	ls_amounttype

n_cst_bcm	lnv_Cache
n_cst_beo_amounttype	lnv_Beo

lnv_Company = CREATE n_cst_beo_company
				

li_Return = 1

ll_TransactionCount = upperBound	( anva_Transactions )

lnv_dws.of_CreateDataStoreByDataObject ( "d_dlkc_accountmap", lds_AccountMap, FALSE )
lds_AccountMap.Retrieve()

IF li_Return = 1 then
	
	if This.of_GetUseEntityName() then 
		lb_UseEntityId = FALSE
	else
		lb_UseEntityId = true
	end if

	FOR ll_Trns = 1 TO ll_TransactionCount

		ls_EntityName = ''
		ll_EntityId = 0
		ll_DistributionCount = 0
		ls_PayablesId = ''
		ls_PayrollId = ''
		ls_TransactionAccount = ''
		//RDT 2-24-03 initialized arrays - start
		lsa_apaccount[] 		= lsa_Blank[]
		lsa_costaccount[]		= lsa_Blank[]
		lsa_expenseaccount[]	= lsa_Blank[]
		lsa_cashaccount[]		= lsa_Blank[]
		lca_amount[]			= lca_Blank[]
		lca_quantity[]			= lca_Blank[]		
		//RDT 2-24-03 initialized arrays - end 
		lsa_ProcessedTypes 	= lsa_Blank
		lsa_RefList				= lsa_Blank
		// Get a single transaction
		lnv_CurrentTransaction = anva_Transactions [ ll_Trns ]
		
		// Get associated AmountsOwed and determine the number of distributions for that trans.
		lnv_CurrentTransaction.of_GetAmountsList ( lnva_AmountsOwed )
		ll_DistributionCount = UpperBound ( lnva_AmountsOwed )
		
		//nwl  - added this to avoid processing transactions that don't have amounts
		//if no amounts, no need to create zero entry 
		if ll_DistributionCount > 0 then
			//ok proceed
		else
			//no amounts
			continue
		end if
		
		// load current Entity
		lnv_CurrentEntity = lnv_CurrentTransaction.of_GetEntity ( ) 
		
		IF NOT isValid ( lnv_CurrentEntity ) THEN
			li_Return = -1
			exit
		END IF

		ll_entityid = lnv_CurrentEntity.of_GetId()

//Currently there is always a category so this check won't happen NWL 2/20/04
		If len(trim( as_Category ) ) = 0 Then 			//	RDT 02-18-03 
			if Len ( lnv_CurrentEntity.of_GetReceivablesId ( ) ) > 0 then  is_category = 'RECEIVABLES'
			if Len ( lnv_CurrentEntity.of_GetPayablesId ( ) ) > 	 0 then  is_category = 'PAYABLES'
			if Len ( lnv_CurrentEntity.of_GetPayrollId ( ) ) >  	 0 then 	is_category= 'PAYROLL'
		Else														//	RDT 02-18-03 
			is_Category = as_Category						//	RDT 02-18-03 
		End if 													//	RDT 02-18-03 
		
		if len(trim(is_category)) = 0 then 
			as_errormsg = "There is no Payables or Payroll id for the entity. The Batch cannot be exported."
			li_return = -1
			exit
		end if
//end of category check		
		
		SetNull( lc_check ) // RDT 5-06-03
		ll_winner = 1
		for ll_dist = 1 to ll_DistributionCount
			lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Dist ]
			lc_AmountOwed = lnv_CurrentAmountOwed.of_GetAmount ( )
 			if isnull(lc_AmountOwed) then
				lc_AmountOwed = 0
			end if
			// RDT 5-06-03 Added - Start
			if IsNull( lc_Check ) then 
				lc_check = lc_AmountOwed
			end if
			if lc_AmountOwed > lc_check then
				lc_check = lnv_CurrentAmountOwed.of_GetAmount ( ) 
				if isnull(lc_check) then
					lc_check = 0
				end if
			 	ll_winner = ll_Dist
			end if
			// RDT 5-06-03 Added - end			
		next
		
		CHOOSE CASE upper(is_category)
			CASE 'PAYABLES'
				ls_PayablesId = lnv_CurrentEntity.of_GetPayablesId ( )
				if isnull(ls_PayablesId) then
					ls_PayablesId = ''
				end if

				ll_CompanyId = lnv_CurrentEntity.of_GetCompanyid()

				If IsNull ( ll_CompanyId ) then 
					ll_EmployeeId = lnv_CurrentEntity.of_Getfkemployee()
					
					IF lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeId, ls_employee, &
						appeon_constant.ci_DescribeType_FirstLast ) = 1 THEN

						ls_EntityName = ls_employee
			
					END IF

					if lb_useentityid then
						ls_entityname = ls_PayablesId 
					end if
					
				Else

					gnv_cst_Companies.of_Cache ( ll_CompanyId, TRUE )
					
					lnv_Company.of_SetUseCache ( TRUE )
					lnv_Company.of_SetSourceId ( ll_CompanyId )
					
					IF lnv_Company.of_HasSource ( ) THEN
						ls_EntityName = lnv_Company.of_GetName()
					END IF
					
					if lb_useentityid then
						ls_entityname = ls_PayablesId 
					end if
				End If								
			CASE 'PAYROLL'
				ls_PayrollId = lnv_CurrentEntity.of_GetPayrollId ( )
				ll_EmployeeId = lnv_CurrentEntity.of_Getfkemployee()
				if isnull(ls_PayrollId) then
					ls_PayrollId = ''
				end if
				IF lnv_EmployeeManager.of_DescribeEmployee ( ll_EmployeeId, ls_employee, &
					appeon_constant.ci_DescribeType_FirstLast ) = 1 THEN

					ls_EntityName = ls_employee
		
				END IF

				if lb_useentityid then
					ls_entityname = ls_PayrollId 
				end if
			CASE 'RECEIVABLES'
				MessageBox("of_DataLoad","Case1 = RECEIVABLES error.")
		END CHOOSE

		// RDT 5-06-03 ALLOW 0 amounts to be processed
		//		// RDT 3-05-03 Do Not Allow 0 amounts to be processed
		//		if ll_winner = 0 then
		//			continue
		//		end if

		/*	 An accountmap should be found. These were already validated.	*/ 
		if ll_DistributionCount > 0 then
			if ll_winner > 0 then	
				lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_winner ]
				if isvalid(lnv_CurrentAmountOwed) then
					li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
					li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
					if isnull(li_division) or li_division = 0 then
						//division missing can't process
						as_errormsg = "Amount id " + string(lnv_CurrentAmountOwed.of_GetId ()) + " for entity " + &
											ls_EntityName + " is missing a division. The Batch cannot be exported."
											
						li_return = -1
						exit
					else
						ls_FindString = "accountmap_division = " + string ( li_Division ) + &
											 " and accountmap_amounttypeid = " + string ( li_AmountType )
						ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )	
						
						IF ll_FindRow > 0 THEN
							choose case upper(is_category)
								CASE 'PAYABLES'
									ls_TransactionAccount = lds_AccountMap.Object.accountmap_apaccount[ll_FindRow]
								CASE 'PAYROLL'
									ls_TransactionAccount = lds_AccountMap.Object.accountmap_payrollcashaccount[ll_FindRow]
							end choose									
						else
							//amount type missing in shiptype 
				
							IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN
				
								lnv_Beo = lnv_Cache.GetBeo ( "amounttype_id = " + String ( li_AmountType ) )
							
								IF IsValid ( lnv_Beo ) THEN
									ls_amounttype = lnv_Beo.of_getname()
								ELSE
									ls_amounttype = ''
								END IF
							
							ELSE
								ls_amounttype = ''			
							END IF
							
							as_errormsg = "Amount Type " + ls_amounttype + " is missing in Ship Type/Division - " + &
											this.of_GetShipTypeName(li_Division) + ".~nThe Batch cannot be exported."
							li_return = -1
							Exit
						END IF
				
						if isnull(ls_transactionaccount) or len(trim(ls_transactionAccount)) = 0 then
							as_errormsg = "An account is missing in AP accounts for Ship Type/Division - " + &
											this.of_GetShipTypeName(li_Division) + ".  The Batch cannot be exported."
							li_return = -1
							exit
						end if
					end if
				end if
			end if
		end if
			
		//Make Transaction entries
		ll_AccountCount = UpperBound( lnva_accountingdata ) + 1
		lnva_accountingdata[ ll_AccountCount ]  = create n_cst_accountingdata

		lnva_accountingdata[ ll_AccountCount ].of_setcategory ( is_category ) 
		lnva_accountingdata[ ll_AccountCount ].of_setbatchid ( lnv_CurrentTransaction.of_GetBatchNumber ( ) )
		lnva_accountingdata[ ll_AccountCount ].of_settransactionaccount(ls_TransactionAccount)
		lnva_accountingdata[ ll_AccountCount ].of_setEntityName(ls_EntityName)
		lnva_accountingdata[ ll_AccountCount ].of_setEntityid(ll_EntityId)	
		lnva_accountingdata[ ll_AccountCount ].of_setPayablesId(ls_PayablesId)
		lnva_accountingdata[ ll_AccountCount ].of_setPayrollId(ls_PayrollId)
		lnva_accountingdata[ ll_AccountCount ].of_setReceivablesId(ls_ReceivablesId)	
		lnva_accountingdata[ ll_AccountCount ].of_setEntityType()	
		lnva_accountingdata[ ll_AccountCount ].of_setpretaxnet (lnv_CurrentTransaction.of_getPreTaxNet ( ) )
		lnva_accountingdata[ ll_AccountCount ].of_setDocumentNumber (lnv_CurrentTransaction.of_GetDocumentNumber ( ) )
		lnva_accountingdata[ ll_AccountCount ].of_setPublicNote (lnv_currentTransaction.of_getPublicNote ( ) )
		lnva_accountingdata[ ll_AccountCount ].of_setref1text ( lnv_currentTransaction.of_getref1text() )
		lnva_accountingdata[ ll_AccountCount ].of_setref2text ( lnv_currentTransaction.of_getref2text() )
		lnva_accountingdata[ ll_AccountCount ].of_setref3text ( lnv_currentTransaction.of_getref3text() )
		lnva_accountingdata[ ll_AccountCount ].of_setDocumentdate (lnv_CurrentTransaction.of_GetDocumentDate ( ))		
		lnva_accountingdata[ ll_AccountCount ].of_setDuedate (relativedate(lnv_CurrentTransaction.of_GetDocumentDate ( ),7))		
		lnva_accountingdata[ ll_AccountCount ].of_setDescription (lnv_CurrentTransaction.of_getDescription (  ) )
		lnva_accountingdata[ ll_AccountCount ].of_setenddate (lnv_CurrentTransaction.of_GetEndDate ( ) )
	
		
		
		//Make Distribution entries
		FOR ll_dist = 1 TO ll_DistributionCount
			
			// Get Current Amount Owed
			lnv_CurrentAmountOwed = lnva_AmountsOwed [ ll_Dist ]
			li_AmountType = lnv_CurrentAmountOwed.of_GetType ( )
			li_Division = lnv_CurrentAmountOwed.of_GetDivision ( )
			
			
			if isnull(li_division) or li_division = 0 then
				//division missing can't process
				as_errormsg = "Amount id " + string(lnv_CurrentAmountOwed.of_GetId ()) + " for entity " + &
									ls_EntityName + " is missing a division. The Batch cannot be exported."								
				li_return = -1
				exit
			else
				ls_FindString = "accountmap_division = " + string ( li_Division ) + &
									" and accountmap_amounttypeid = " + string ( li_AmountType )
				ll_FindRow = lds_AccountMap.Find ( ls_FindString, 1, lds_AccountMap.RowCount() )
				
				if ll_dist = 1 then
					//amounts for a transaction go to a single division
					lnva_accountingdata[ll_AccountCount].of_setShipType ( lnv_CurrentAmountOwed.of_GetDivision ( ) )
				end if
			end if
			
			// get account
			IF ll_FindRow > 0 THEN
			CHOOSE CASE upper(is_category)
				CASE 'PAYABLES'
					ls_apaccount = lds_AccountMap.Object.accountmap_apaccount[ll_FindRow]
					ls_costaccount = lds_AccountMap.Object.accountmap_costaccount[ll_FindRow]
			
					if isnull(ls_apaccount) or len(trim(ls_apaccount)) = 0 or &
						isnull(ls_costaccount) or len(trim(ls_costaccount)) = 0 then
						as_errormsg = "An account is missing in AP accounts for Ship Type/Division - " + &
											this.of_GetShipTypeName(li_Division) + ".  The Batch cannot be exported."
						li_return = -1
					else
						ll_count = upperbound(lsa_apaccount)
						if ll_count = 0 then
							ll_found = 1 
							lsa_apaccount[ll_found] = ls_apaccount
							lsa_costaccount[ll_found] = ls_costaccount
						else	
							ll_found = 0
							for ll_index = 1 to ll_count
								if lsa_apaccount[ll_index] = ls_apaccount then
									if lsa_costaccount[ll_index] = ls_costaccount then
										ll_found = ll_index
										exit
									end if
								end if
							next
							if ll_found = 0 then
								ll_found = ll_count + 1
								lsa_apaccount[ll_found] = ls_apaccount
								lsa_costaccount[ll_found] = ls_costaccount
							end if
						end if
						
						//amount
						lc_AmountOwed = lnv_CurrentAmountOwed.of_GetAmount ( )	 
						if isnull(lc_AmountOwed) then
							lc_AmountOwed = 0
						end if
						lca_amount[ll_found] += lc_AmountOwed	
						
						//quantity
						lc_quantity = lnv_CurrentAmountOwed.of_GetQuantity ( )
						if isnull(lc_quantity) then
							lc_quantity = 0
						end if
						lca_quantity[ll_found] += lc_quantity
						
					end if
							
				CASE 'PAYROLL'			
					ls_cashaccount = lds_AccountMap.Object.accountmap_payrollcashaccount[ll_FindRow]
					ls_expenseaccount = lds_AccountMap.Object.accountmap_payrollexpenseaccount[ll_FindRow]
					
					if isnull(ls_cashaccount) or len(trim(ls_cashaccount)) = 0 or &
						isnull(ls_expenseaccount) or len(trim(ls_expenseaccount)) = 0 then
						as_errormsg = "An account is missing in AP accounts for Ship Type/Division - " + &
											this.of_GetShipTypeName(li_Division) + ".  The Batch cannot be exported."
						li_return = -1
					else
						ll_count = upperbound(lsa_cashaccount)
						if ll_count = 0 then
							ll_found = 1 
							lsa_cashaccount[ll_found] = ls_cashaccount
							lsa_expenseaccount[ll_found] = ls_expenseaccount							
						else	
							ll_found = 0
							for ll_index = 1 to ll_count
								if lsa_cashaccount[ll_index] = ls_cashaccount then
									if lsa_expenseaccount[ll_index] = ls_expenseaccount then
										ll_found = ll_index
										exit
									end if
								end if
							next
							if ll_found = 0 then
								ll_found = ll_count + 1
								lsa_cashaccount[ll_found] = ls_cashaccount
								lsa_expenseaccount[ll_found] = ls_expenseaccount							
							end if
						end if
						
						//amount
						lc_AmountOwed = lnv_CurrentAmountOwed.of_GetAmount ( )
						if isnull(lc_AmountOwed) then
							lc_AmountOwed = 0
						end if
						lca_amount[ll_found] += lc_AmountOwed
						
						//quantity
						lc_quantity = lnv_CurrentAmountOwed.of_GetQuantity ( )
						if isnull(lc_quantity) then
							lc_quantity = 0
						end if
						lca_quantity[ll_found] += lc_Quantity
						
					end if
					CASE 'RECEIVABLES'
						MessageBox("of_DataLoad","Case2 = RECEIVABLES.")
				END CHOOSE
			else
				//amount type missing in shiptype 
				IF gnv_App.inv_CacheManager.of_GetCache ( "n_cst_dlkc_amounttype", lnv_Cache, TRUE, TRUE ) = 1 THEN
	
					lnv_Beo = lnv_Cache.GetBeo ( "amounttype_id = " + String ( li_AmountType ) )
				
					IF IsValid ( lnv_Beo ) THEN
						ls_amounttype = lnv_Beo.of_getname()
					ELSE
						ls_amounttype = ''
					END IF
				
				ELSE
					ls_amounttype = ''			
				END IF
				
				as_errormsg = "Amount Type " + ls_amounttype + " is missing in Ship Type/Division - " + &
									this.of_GetShipTypeName(li_Division) + ".~nThe Batch cannot be exported."
				li_return = -1
				Exit
				
			END IF
			if li_return = -1 then
				exit
			end if
			
			/////////////////////////////  <<*>>
			IF IsNull ( lnv_Array.of_Find( lsa_ProcessedTypes , String ( li_AmountType ) + ":" + String ( li_Division ) , 1 , UpperBound ( lsa_ProcessedTypes ) ) ) THEN
				lnv_query = lnv_database.GetQuery ( )			
				lnv_Query.SetArguments ( {li_Division,li_AmountType, lnv_CurrentTransaction.of_getid( ) } )
				lnv_Bcm = lnv_query.ExecuteQuery("n_cst_dlkc_amountowed" , "" , "SameDistribution")	
				IF isValid ( lnv_BCM ) THEN
					lsa_ProcessedTypes[UpperBound ( lsa_ProcessedTypes ) + 1 ]  =  String ( li_AmountType ) + ":" + String ( li_Division )				
					ls_Temp = THIS.of_buildreftext( lnv_Bcm , lnv_CurrentTransaction )
					IF len ( ls_Temp ) > 0 THEN
						IF UpperBound ( lsa_RefList ) >= ll_Found THEN
							IF Len ( lsa_RefList [ll_Found] 	)  > 0 THEN							 
								 lsa_RefList [ll_Found] += ", "
							END IF
						END IF						
					END IF
					lsa_RefList[ll_found] += ls_Temp
				END IF
			END IF				
			///////// END OF MY STUFF
			
						
		NEXT // Each Distribution
		
		if li_return = 1 then
			lnva_accountingdata[ll_AccountCount].of_setDistributionapaccount(lsa_apaccount)
			lnva_accountingdata[ll_AccountCount].of_setDistributioncostaccount(lsa_costaccount)
			lnva_accountingdata[ll_AccountCount].of_setDistributionexpenseaccount(lsa_expenseaccount)
			lnva_accountingdata[ll_AccountCount].of_setDistributioncashaccount(lsa_cashaccount)
			lnva_accountingdata[ll_AccountCount].of_setDistributionamount(lca_amount)
			lnva_accountingdata[ll_AccountCount].of_setDistributionquantity (lca_quantity )
			lnva_Accountingdata[ll_AccountCount].of_SetDistributionnote( lsa_RefList )
		end if

		if li_return = -1 then
			exit
		end if
			
	NEXT // Each Transaction 

END IF

//Export contents of datastore to batch file

DESTROY lds_AccountMap
DESTROY lnv_Company

anva_accountingdata = lnva_accountingdata

RETURN li_Return
end function

public function integer of_getcustomerfile (ref string as_filename);//Returns:   1 = Success 
//				 0 = Value has not been defined, or is not valid
//				-1 = Error retrieving value from database

String	ls_Description
Integer	li_SqlCode

Integer	li_Return = 1
Int		li_FileID
n_cst_string	lnv_String



//Attempt to retrieve Required Image Types for billing from database

SELECT ss_String INTO :ls_Description FROM System_Settings WHERE ss_Id = 50 ;

li_SqlCode = SQLCA.SqlCode

COMMIT ;


//Evaluate retrieval result

CHOOSE CASE li_SqlCode

CASE 100		//Value not defined
	li_Return = 0

CASE 0		//Success.  Validate value.
	IF Len ( trim ( ls_Description ) ) > 0 THEN
		//Value is OK 
	ELSE
		li_Return = 0
	END IF

CASE ELSE	//Error
	li_Return = -1

END CHOOSE


//Set Reference Parameters and Return

IF li_Return = 1 THEN
	li_FileId = FileOpen ( ls_description, LineMode!, Read!, LockWrite! )
	IF li_FileID = -1 THEN
		MessageBox ( "File Access" , "The file path '" + ls_Description + &
		"' specified in the system settings could not accessed. Please select " + &
		+ "a customer validation file manually." )
		
		li_Return = -1
	ELSE
		li_Return = FileClose ( li_FileID )
	END IF
END IF

//send back anyway for possible folder location
//IF li_Return = 1 THEN
	
	as_FileName = ls_description
	
//END IF
 

RETURN li_Return


end function

public function string of_getshiptypename (long al_shiptype);n_cst_ship_Type	lnv_ShipTypeManager

string	ls_name

lnv_ShipTypeManager.of_Ready ( TRUE ) 

if lnv_ShipTypeManager.of_Getname (al_shiptype, ls_name ) = 1 then
	//success
end if

return ls_name

end function

private function string of_getrefvalues (n_cst_beo_amountowed anv_amount);String	ls_Text
Int		li_Type
String	ls_Return




RETURN ls_Return
end function

public function string of_buildreftext (n_cst_bcm anv_amountsowed, n_cst_beo_transaction anv_transaction);String	ls_Return
String	ls_Temp
String	ls_Type
String	ls_Text
Int		li_Type
String	ls_TrxString
String	ls_AmountsString
Int	li_Count
Int	i
Int	li_Keep


n_cst_beo_Transaction	lnv_Trans
n_cst_beo_AmountOwed		lnv_Amount

lnv_Trans = anv_transaction

IF isValid ( lnv_Trans ) THEN  // pull the values off the Transactins
	li_Type = lnv_Trans.of_GetRef1Type ( )
	ls_Text = lnv_Trans.of_GetRef1Text ( )
	
	IF li_Type > 0 AND Len ( ls_Text ) > 0 THEN
		
		SELECT "refnumtype"."name"  
		 INTO :ls_Type  
		 FROM "refnumtype"  
		WHERE "refnumtype"."id" = :li_Type   ;
		COMMIT;


		// get the display value for the type here.
		IF isNull (ls_Type) THEN
			ls_Type = ""
		END IF
		
		IF isNull ( ls_Text ) THEN
			ls_Text = ""
		END IF
		ls_TrxString = String (ls_Type) + ": " + ls_Text
	END IF	
		
	li_Count = anv_amountsowed.GetCount ( )
	// do the first pass to see if all of the types are the same
	// we are going to build the string expecting them to be the same.
	// if they turn out to be different we will bail and build the string 
	// differently.

	FOR i = 1 TO li_Count
		
		lnv_Amount = anv_amountsowed.Getat ( i ) 
		
		li_Type = lnv_Amount.of_getRef1Type ( )
		ls_Text = lnv_Amount.of_GetRef1Text( )
		
		// screen for Nulls
		IF isNull ( ls_Text ) THEN
			ls_Text = ""
		END IF
		IF IsNull ( li_Type ) THEN
			li_Type = 0 
		END IF 
		
		IF li_Keep = 0 AND li_Type > 0 THEN				
			SELECT "refnumtype"."name"  
				 INTO :ls_Type  
				 FROM "refnumtype"  
				WHERE "refnumtype"."id" = :li_Type   ;
				COMMIT;
			IF isNull ( ls_Type ) THEN
				ls_Type = ""
			ELSE
				li_Keep = li_Type
			END IF			
		END IF
						
		IF li_Type <> li_Keep THEN
			EXIT
		END IF
		IF len ( ls_Text ) > 0 THEN
			ls_AmountsString += " " + ls_Text 
		END IF
		
		IF i < li_Count AND Len ( ls_AmountsString ) > 0 THEN
			ls_AmountsString += ","
		END IF		
		
	NEXT
	
	IF i > li_Count THEN  // we finished the loop with all of the same ref types, so put the type
								 // on the front of the string.
		IF Len ( ls_Type ) > 0 AND Len ( ls_AmountsString ) > 0 THEN
			ls_AmountSString = ls_Type + ": " + ls_amountsString
		END IF
	
	ELSE  // we exited to loop early and will need to build the string again.	
		
		ls_AmountsString = ""
		
		FOR i = 1 TO li_Count
			
			lnv_Amount = anv_amountsowed.Getat ( i ) 
			
			li_Type = lnv_Amount.of_getRef1Type ( )
			ls_Text = lnv_Amount.of_GetRef1Text( )
			
			IF isNull ( ls_Text ) THEN
				ls_Text = ""
			END IF
			IF IsNull ( li_Type ) THEN
				li_Type = 0 
			END IF 
			
			
		  SELECT "refnumtype"."name"  
			 INTO :ls_Type  
			 FROM "refnumtype"  
			WHERE "refnumtype"."id" = :li_Type   ;
			COMMIT;
			
			
			IF isNull ( ls_Type ) THEN
				ls_Type = ""
			END IF
			IF Len ( ls_Type ) > 0 OR Len (ls_Text) > 0 THEN
				IF i = 1 THEN
					ls_AmountsString = ls_Type + ": " + ls_Text
				ELSE
					ls_AmountsString += " " + ls_Type + ": " + ls_Text
				END IF
				
				IF i < li_Count THEN
					ls_AmountsString += ","
				END IF
			END IF
			
		NEXT
		
	END IF							
	
END IF


IF Len ( ls_TrxString ) > 0 THEN
	
	ls_Return = ls_TrxString //
	IF Len ( ls_AmountsString ) > 0 THEN
		ls_Return += ", " + ls_AmountsString
	END IF
	
ELSE
	ls_Return = ls_AmountsString
END IF

IF IsNull ( ls_Return ) THEN 
	ls_Return = ""
END IF

RETURN ls_Return

end function

public subroutine of_recordarbatch (datawindow adw_target, boolean ab_validated);long	ll_nextid, &
		ll_Id, &
		ll_rowcount, &
		ll_row, &
		ll_newrow
			
CONSTANT Boolean cb_Commit	= TRUE	

n_ds	lds_ARBatch

ll_rowcount = adw_target.rowcount()

IF gnv_App.of_GetNextId ( "arbatchid", ll_NextId, cb_Commit ) = 1 THEN

	lds_ARBatch = create n_ds
	lds_ARBatch.dataobject = 'd_arbatch'
	lds_ARBatch.SetTransObject(SQLCA)
	
	for ll_row = 1 to ll_rowcount
		
		ll_newrow = lds_ARBatch.Insertrow(0)
		
		if ll_Newrow > 0 then
			ll_id = adw_target.object.ds_id[ll_row]
			lds_ARBatch.object.dispshipid[ll_newrow] = ll_id
			lds_ARBatch.object.arbatchid[ll_newrow] = ll_NextId
			IF ab_validated THEN
				lds_ARBatch.object.validated[ll_newrow] = "T"
			ELSE
				lds_ARBatch.object.validated[ll_newrow] = "F"
			END IF
		end if
		
	next
	
	if lds_ARBatch.update() = 1 then
		commit;
	else
		rollback;
	end if
	
END IF
end subroutine

on n_cst_acctlink.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_acctlink.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

